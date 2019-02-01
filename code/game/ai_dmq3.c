// Copyright (C) 1999-2000 Id Software, Inc.
//

/*****************************************************************************
 * name:		ai_dmq3.c
 *
 * desc:		Quake3 bot AI
 *
 * $Archive: /MissionPack/code/game/ai_dmq3.c $
 *
 *****************************************************************************/


#include "g_local.h"
#include "botlib.h"
#include "be_aas.h"
#include "be_ea.h"
#include "be_ai_char.h"
#include "be_ai_chat.h"
#include "be_ai_gen.h"
#include "be_ai_goal.h"
#include "be_ai_move.h"
#include "be_ai_weap.h"
//
#include "ai_main.h"
#include "ai_dmq3.h"
#include "ai_chat.h"
#include "ai_cmd.h"
#include "ai_dmnet.h"
#include "ai_team.h"
//
#include "chars.h"				//characteristics
#include "inv.h"				//indexes into the inventory
#include "syn.h"				//synonyms
#include "match.h"				//string matching types and vars

// for the voice chats
#include "../../ui/menudef.h" // sos001205 - for q3_ui also

// from aasfile.h
#define AREACONTENTS_MOVER				1024
#define AREACONTENTS_MODELNUMSHIFT		24
#define AREACONTENTS_MAXMODELNUM		0xFF
#define AREACONTENTS_MODELNUM			(AREACONTENTS_MAXMODELNUM << AREACONTENTS_MODELNUMSHIFT)

#define IDEAL_ATTACKDIST			140

#define MAX_WAYPOINTS		128
//
bot_waypoint_t botai_waypoints[MAX_WAYPOINTS];
bot_waypoint_t *botai_freewaypoints;

//NOTE: not using a cvars which can be updated because the game should be reloaded anyway
int gametype;		//game type
int maxclients;		//maximum number of clients

vmCvar_t bot_grapple;
vmCvar_t bot_rocketjump;
vmCvar_t bot_fastchat;
vmCvar_t bot_nochat;
vmCvar_t bot_testrchat;
vmCvar_t bot_challenge;
vmCvar_t bot_predictobstacles;
vmCvar_t g_spSkill;

extern vmCvar_t bot_developer;

vec3_t lastteleport_origin;		//last teleport event origin
float lastteleport_time;		//last teleport event time
int max_bspmodelindex;			//maximum BSP model index

//CTF flag goals
bot_goal_t ctf_redflag;
bot_goal_t ctf_blueflag;

#define MAX_ALTROUTEGOALS		32

int altroutegoals_setup;
aas_altroutegoal_t red_altroutegoals[MAX_ALTROUTEGOALS];
int red_numaltroutegoals;
aas_altroutegoal_t blue_altroutegoals[MAX_ALTROUTEGOALS];
int blue_numaltroutegoals;


/*
==================
BotSetUserInfo
==================
*/
void BotSetUserInfo(bot_state_t *bs, char *key, char *value) {
	char userinfo[MAX_INFO_STRING];

	trap_GetUserinfo(bs->client, userinfo, sizeof(userinfo));
	Info_SetValueForKey(userinfo, key, value);
	trap_SetUserinfo(bs->client, userinfo);
	ClientUserinfoChanged( bs->client );
}

/*
==================
BotCTFCarryingFlag
==================
*/
int BotCTFCarryingFlag(bot_state_t *bs) {
	if (gametype != GT_CTF) return CTF_FLAG_NONE;

	if (bs->inventory[INVENTORY_REDFLAG] > 0) return CTF_FLAG_RED;
	else if (bs->inventory[INVENTORY_BLUEFLAG] > 0) return CTF_FLAG_BLUE;
	return CTF_FLAG_NONE;
}

/*
==================
BotTeam
==================
*/
int BotTeam(bot_state_t *bs) {
	char info[1024];

	if (bs->client < 0 || bs->client >= MAX_CLIENTS) {
		//BotAI_Print(PRT_ERROR, "BotCTFTeam: client out of range\n");
		return qfalse;
	}
	trap_GetConfigstring(CS_PLAYERS+bs->client, info, sizeof(info));
	//
	if (atoi(Info_ValueForKey(info, "t")) == TEAM_RED) return TEAM_RED;
	else if (atoi(Info_ValueForKey(info, "t")) == TEAM_BLUE) return TEAM_BLUE;
	return TEAM_FREE;
}

/*
==================
BotOppositeTeam
==================
*/
int BotOppositeTeam(bot_state_t *bs) {
	switch(BotTeam(bs)) {
		case TEAM_RED: return TEAM_BLUE;
		case TEAM_BLUE: return TEAM_RED;
		default: return TEAM_FREE;
	}
}

/*
==================
JUHOX: BotFindCTFBases
==================
*/
void BotFindCTFBases(void) {
	int i;
	qboolean foundRedFlag;
	qboolean foundBlueFlag;

	if (g_gametype.integer != GT_CTF) return;
	if (!trap_AAS_Initialized()) return;
	if (ctf_redflag.areanum && ctf_blueflag.areanum) return;

	foundRedFlag = qfalse;
	foundBlueFlag = qfalse;

	for (i = MAX_CLIENTS; i < level.num_entities; i++) {
		gentity_t* ent;
		gitem_t* item;

		ent = &g_entities[i];
		if (!ent->inuse) continue;
		//if (ent->s.eType != ET_ITEM) continue;
		//if (!ent->r.linked) continue;
		//if (ent->s.eFlags & EF_NODRAW) continue;
		//if (ent->flags & FL_DROPPED_ITEM) continue;

		item = ent->item;
		if (!item) continue;

		if (item->giType != IT_TEAM) continue;

		switch (item->giTag) {
		case PW_REDFLAG:
			BotCreateItemGoal(ent, &ctf_redflag);
			foundRedFlag = qtrue;
			break;
		case PW_BLUEFLAG:
			BotCreateItemGoal(ent, &ctf_blueflag);
			foundBlueFlag = qtrue;
			break;
		}
	}

	if (!foundRedFlag) BotAI_Print(PRT_WARNING, "CTF without Red Flag\n");
	if (!foundBlueFlag) BotAI_Print(PRT_WARNING, "CTF without Blue Flag\n");
}

/*
==================
BotEnemyFlag
==================
*/
bot_goal_t *BotEnemyFlag(bot_state_t *bs) {
	if (BotTeam(bs) == TEAM_RED) {
		return &ctf_blueflag;
	}
	else {
		return &ctf_redflag;
	}
}

/*
==================
BotTeamFlag
==================
*/
bot_goal_t *BotTeamFlag(bot_state_t *bs) {
	if (BotTeam(bs) == TEAM_RED) {
		return &ctf_redflag;
	}
	else {
		return &ctf_blueflag;
	}
}


/*
==================
EntityIsDead
==================
*/
qboolean EntityIsDead(aas_entityinfo_t *entinfo) {
	// JUHOX: let EntityIsDead() accept monsters

	if (entinfo->number >= 0 && entinfo->number < level.num_entities) {
		gentity_t* ent;
		playerState_t* ps;

		ent = &g_entities[entinfo->number];
		if (!ent->inuse) return qtrue;
		if (!ent->r.linked) return qtrue;

		ps = G_GetEntityPlayerState(ent);
		if (!ps) return qtrue;

		if (ps->pm_type != PM_NORMAL) return qtrue;
		if (ps->stats[STAT_HEALTH] <= 0) return qtrue;

		return qfalse;
	}
	return qtrue;

}

/*
==================
EntityCarriesFlag
==================
*/
qboolean EntityCarriesFlag(aas_entityinfo_t *entinfo) {
	if ( entinfo->powerups & ( 1 << PW_REDFLAG ) )
		return qtrue;
	if ( entinfo->powerups & ( 1 << PW_BLUEFLAG ) )
		return qtrue;

	return qfalse;
}

/*
==================
EntityIsInvisible
==================
*/
// JUHOX: take the marks into account
#if 0
qboolean EntityIsInvisible(aas_entityinfo_t *entinfo) {
	// the flag is always visible
	if (EntityCarriesFlag(entinfo)) {
		return qfalse;
	}
	if (entinfo->powerups & (1 << PW_INVIS)) {
		return qtrue;
	}
	return qfalse;
}
#else
qboolean EntityIsInvisible(int viewer, aas_entityinfo_t *entinfo) {
	if (
		(
			entinfo->powerups &
			(
				(1 << PW_INVIS) |
				(1 << PW_BATTLESUIT) |
				(1 << PW_CHARGE) |
				(1 << PW_REDFLAG) |
				(1 << PW_BLUEFLAG)
			)
		) == (1 << PW_INVIS)
	) {
		playerState_t ps1, ps2;

		if (g_gametype.integer < GT_TEAM) return qtrue;
		if (viewer == VIEWER_SAMETEAM) return qfalse;
		if (viewer == VIEWER_OTHERTEAM) return qtrue;
		if (!BotAI_GetClientState(viewer, &ps1)) return qtrue;
		if (!BotAI_GetClientState(entinfo->number, &ps2)) return qtrue;
		if (ps1.persistant[PERS_TEAM] == ps2.persistant[PERS_TEAM]) return qfalse;
		return qtrue;
	}
	return qfalse;
}
#endif

/*
==================
EntityIsShooting
==================
*/
qboolean EntityIsShooting(aas_entityinfo_t *entinfo) {
	if (entinfo->flags & EF_FIRING) {
		return qtrue;
	}
	return qfalse;
}

/*
==================
EntityIsChatting
==================
*/
qboolean EntityIsChatting(aas_entityinfo_t *entinfo) {
	if (entinfo->flags & EF_TALK) {
		return qtrue;
	}
	return qfalse;
}

/*
==================
EntityHasQuad
==================
*/
qboolean EntityHasQuad(aas_entityinfo_t *entinfo) {
	// JUHOX: quad powerup is not used
#if 0
	if (entinfo->powerups & (1 << PW_QUAD)) {
		return qtrue;
	}
#endif
	return qfalse;
}

/*
==================
BotRememberLastOrderedTask
==================
*/
void BotRememberLastOrderedTask(bot_state_t *bs) {
	if (!bs->ordered) {
		return;
	}
	bs->lastgoal_decisionmaker = bs->decisionmaker;
	bs->lastgoal_ltgtype = bs->ltgtype;
	memcpy(&bs->lastgoal_teamgoal, &bs->teamgoal, sizeof(bot_goal_t));
	bs->lastgoal_teammate = bs->teammate;
}

/*
==================
BotSetTeamStatus
==================
*/
void BotSetTeamStatus(bot_state_t *bs) { // SLK :remove
}

// JUHOX: BotSetLastOrderedTask() not needed
#if 0
/*
==================
BotSetLastOrderedTask
==================
*/
int BotSetLastOrderedTask(bot_state_t *bs) {

	if (gametype == GT_CTF) {
		// don't go back to returning the flag if it's at the base
		if ( bs->lastgoal_ltgtype == LTG_RETURNFLAG ) {
			if ( BotTeam(bs) == TEAM_RED ) {
				if ( bs->redflagstatus == 0 ) {
					bs->lastgoal_ltgtype = 0;
				}
			}
			else {
				if ( bs->blueflagstatus == 0 ) {
					bs->lastgoal_ltgtype = 0;
				}
			}
		}
	}

	if ( bs->lastgoal_ltgtype ) {
		bs->decisionmaker = bs->lastgoal_decisionmaker;
		bs->ordered = qtrue;
		bs->ltgtype = bs->lastgoal_ltgtype;
		memcpy(&bs->teamgoal, &bs->lastgoal_teamgoal, sizeof(bot_goal_t));
		bs->teammate = bs->lastgoal_teammate;
		bs->teamgoal_time = FloatTime() + 300;
		BotSetTeamStatus(bs);
		//
		if ( gametype == GT_CTF ) {
			if ( bs->ltgtype == LTG_GETFLAG ) {
				bot_goal_t *tb, *eb;
				int tt, et;

				tb = BotTeamFlag(bs);
				eb = BotEnemyFlag(bs);
				tt = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, tb->areanum, TFL_DEFAULT);
				et = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, eb->areanum, TFL_DEFAULT);
				// if the travel time towards the enemy base is larger than towards our base
				if (et > tt) {
					//get an alternative route goal towards the enemy base
					BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
				}
			}
		}
		return qtrue;
	}
	return qfalse;
}
#endif

// JUHOX: BotRefuseOrder() not needed
#if 0
/*
==================
BotRefuseOrder
==================
*/
void BotRefuseOrder(bot_state_t *bs) {
	if (!bs->ordered)
		return;
	// if the bot was ordered to do something
	if ( bs->order_time && bs->order_time > FloatTime() - 10 ) {
		trap_EA_Action(bs->client, ACTION_NEGATIVE);
		BotVoiceChat(bs, bs->decisionmaker, VOICECHAT_NO);
		bs->order_time = 0;
	}
}
#endif

// JUHOX: 'BotCTFSeekGoals()' no longer used
#if 0
/*
==================
BotCTFSeekGoals
==================
*/
void BotCTFSeekGoals(bot_state_t *bs) {
	float rnd, l1, l2;
	int flagstatus, c;
	vec3_t dir;
	aas_entityinfo_t entinfo;

	//when carrying a flag in ctf the bot should rush to the base
	if (BotCTFCarryingFlag(bs)) {
		//if not already rushing to the base
		if (bs->ltgtype != LTG_RUSHBASE) {
			BotRefuseOrder(bs);
			bs->ltgtype = LTG_RUSHBASE;
			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
			bs->rushbaseaway_time = 0;
			bs->decisionmaker = bs->client;
			bs->ordered = qfalse;
			//
			switch(BotTeam(bs)) {
				case TEAM_RED: VectorSubtract(bs->origin, ctf_blueflag.origin, dir); break;
				case TEAM_BLUE: VectorSubtract(bs->origin, ctf_redflag.origin, dir); break;
				default: VectorSet(dir, 999, 999, 999); break;
			}
			// if the bot picked up the flag very close to the enemy base
			if ( VectorLength(dir) < 128 ) {
				// get an alternative route goal through the enemy base
				BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
			} else {
				// don't use any alt route goal, just get the hell out of the base
				bs->altroutegoal.areanum = 0;
			}
			BotSetUserInfo(bs, "teamtask", va("%d", TEAMTASK_OFFENSE));
			BotVoiceChat(bs, -1, VOICECHAT_IHAVEFLAG);
		}
		else if (bs->rushbaseaway_time > FloatTime()) {
			if (BotTeam(bs) == TEAM_RED) flagstatus = bs->redflagstatus;
			else flagstatus = bs->blueflagstatus;
			//if the flag is back
			if (flagstatus == 0) {
				bs->rushbaseaway_time = 0;
			}
		}
		return;
	}
	// if the bot decided to follow someone
	if ( bs->ltgtype == LTG_TEAMACCOMPANY && !bs->ordered ) {
		// if the team mate being accompanied no longer carries the flag
		BotEntityInfo(bs->teammate, &entinfo);
		if (!EntityCarriesFlag(&entinfo)) {
			bs->ltgtype = 0;
		}
	}
	//
	if (BotTeam(bs) == TEAM_RED) flagstatus = bs->redflagstatus * 2 + bs->blueflagstatus;
	else flagstatus = bs->blueflagstatus * 2 + bs->redflagstatus;
	//if our team has the enemy flag and our flag is at the base
	if (flagstatus == 1) {
		//
		if (bs->owndecision_time < FloatTime()) {
			//if Not defending the base already
			if (!(bs->ltgtype == LTG_DEFENDKEYAREA &&
					(bs->teamgoal.number == ctf_redflag.number ||
					bs->teamgoal.number == ctf_blueflag.number))) {
				//if there is a visible team mate flag carrier
				c = BotTeamFlagCarrierVisible(bs);
				if (c >= 0 &&
						// and not already following the team mate flag carrier
						(bs->ltgtype != LTG_TEAMACCOMPANY || bs->teammate != c)) {
					//
					BotRefuseOrder(bs);
					//follow the flag carrier
					bs->decisionmaker = bs->client;
					bs->ordered = qfalse;
					//the team mate
					bs->teammate = c;
					//last time the team mate was visible
					bs->teammatevisible_time = FloatTime();
					//no message
					bs->teammessage_time = 0;
					//no arrive message
					bs->arrive_time = 1;
					//
					BotVoiceChat(bs, bs->teammate, VOICECHAT_ONFOLLOW);
					//get the team goal time
					bs->teamgoal_time = FloatTime() + TEAM_ACCOMPANY_TIME;
					bs->ltgtype = LTG_TEAMACCOMPANY;
					bs->formation_dist = 3.5 * 32;		//3.5 meter
					BotSetTeamStatus(bs);
					bs->owndecision_time = FloatTime() + 5;
				}
			}
		}
		return;
	}
	//if the enemy has our flag
	else if (flagstatus == 2) {
		//
		if (bs->owndecision_time < FloatTime()) {
			//if enemy flag carrier is visible
			c = BotEnemyFlagCarrierVisible(bs);
			if (c >= 0) {
				//FIXME: fight enemy flag carrier
			}
			//if not already doing something important
			if (bs->ltgtype != LTG_GETFLAG &&
				bs->ltgtype != LTG_RETURNFLAG &&
				bs->ltgtype != LTG_TEAMHELP &&
				bs->ltgtype != LTG_TEAMACCOMPANY &&
				bs->ltgtype != LTG_CAMPORDER &&
				bs->ltgtype != LTG_PATROL &&
				bs->ltgtype != LTG_GETITEM) {

				BotRefuseOrder(bs);
				bs->decisionmaker = bs->client;
				bs->ordered = qfalse;
				//
				if (random() < 0.5) {
					//go for the enemy flag
					bs->ltgtype = LTG_GETFLAG;
				}
				else {
					bs->ltgtype = LTG_RETURNFLAG;
				}
				//no team message
				bs->teammessage_time = 0;
				//set the time the bot will stop getting the flag
				bs->teamgoal_time = FloatTime() + CTF_GETFLAG_TIME;
				//get an alternative route goal towards the enemy base
				BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
				//
				BotSetTeamStatus(bs);
				bs->owndecision_time = FloatTime() + 5;
			}
		}
		return;
	}
	//if both flags Not at their bases
	else if (flagstatus == 3) {
		//
		if (bs->owndecision_time < FloatTime()) {
			// if not trying to return the flag and not following the team flag carrier
			if ( bs->ltgtype != LTG_RETURNFLAG && bs->ltgtype != LTG_TEAMACCOMPANY ) {
				//
				c = BotTeamFlagCarrierVisible(bs);
				// if there is a visible team mate flag carrier
				if (c >= 0) {
					BotRefuseOrder(bs);
					//follow the flag carrier
					bs->decisionmaker = bs->client;
					bs->ordered = qfalse;
					//the team mate
					bs->teammate = c;
					//last time the team mate was visible
					bs->teammatevisible_time = FloatTime();
					//no message
					bs->teammessage_time = 0;
					//no arrive message
					bs->arrive_time = 1;
					//
					BotVoiceChat(bs, bs->teammate, VOICECHAT_ONFOLLOW);
					//get the team goal time
					bs->teamgoal_time = FloatTime() + TEAM_ACCOMPANY_TIME;
					bs->ltgtype = LTG_TEAMACCOMPANY;
					bs->formation_dist = 3.5 * 32;		//3.5 meter
					//
					BotSetTeamStatus(bs);
					bs->owndecision_time = FloatTime() + 5;
				}
				else {
					BotRefuseOrder(bs);
					bs->decisionmaker = bs->client;
					bs->ordered = qfalse;
					//get the enemy flag
					bs->teammessage_time = FloatTime() + 2 * random();
					//get the flag
					bs->ltgtype = LTG_RETURNFLAG;
					//set the time the bot will stop getting the flag
					bs->teamgoal_time = FloatTime() + CTF_RETURNFLAG_TIME;
					//get an alternative route goal towards the enemy base
					BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
					//
					BotSetTeamStatus(bs);
					bs->owndecision_time = FloatTime() + 5;
				}
			}
		}
		return;
	}
	// don't just do something wait for the bot team leader to give orders
	if (BotTeamLeader(bs)) {
		return;
	}
	// if the bot is ordered to do something
	if ( bs->lastgoal_ltgtype ) {
		bs->teamgoal_time += 60;
	}
	// if the bot decided to do something on it's own and has a last ordered goal
	if ( !bs->ordered && bs->lastgoal_ltgtype ) {
		bs->ltgtype = 0;
	}
	//if already a CTF or team goal
	if (bs->ltgtype == LTG_TEAMHELP ||
			bs->ltgtype == LTG_TEAMACCOMPANY ||
			bs->ltgtype == LTG_DEFENDKEYAREA ||
			bs->ltgtype == LTG_GETFLAG ||
			bs->ltgtype == LTG_RUSHBASE ||
			bs->ltgtype == LTG_RETURNFLAG ||
			bs->ltgtype == LTG_CAMPORDER ||
			bs->ltgtype == LTG_PATROL ||
			bs->ltgtype == LTG_GETITEM ||
			bs->ltgtype == LTG_MAKELOVE_UNDER ||
			bs->ltgtype == LTG_MAKELOVE_ONTOP) {
		return;
	}
	//
	if (BotSetLastOrderedTask(bs))
		return;
	//
	if (bs->owndecision_time > FloatTime())
		return;;
	//if the bot is roaming
	if (bs->ctfroam_time > FloatTime())
		return;
	//if the bot has anough aggression to decide what to do
	if (BotAggression(bs) < 50)
		return;
	//set the time to send a message to the team mates
	bs->teammessage_time = FloatTime() + 2 * random();
	//
	if (bs->teamtaskpreference & (TEAMTP_ATTACKER|TEAMTP_DEFENDER)) {
		if (bs->teamtaskpreference & TEAMTP_ATTACKER) {
			l1 = 0.7f;
		}
		else {
			l1 = 0.2f;
		}
		l2 = 0.9f;
	}
	else {
		l1 = 0.4f;
		l2 = 0.7f;
	}
	//get the flag or defend the base
	rnd = random();
	if (rnd < l1 && ctf_redflag.areanum && ctf_blueflag.areanum) {
		bs->decisionmaker = bs->client;
		bs->ordered = qfalse;
		bs->ltgtype = LTG_GETFLAG;
		//set the time the bot will stop getting the flag
		bs->teamgoal_time = FloatTime() + CTF_GETFLAG_TIME;
		//get an alternative route goal towards the enemy base
		BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
		BotSetTeamStatus(bs);
	}
	else if (rnd < l2 && ctf_redflag.areanum && ctf_blueflag.areanum) {
		bs->decisionmaker = bs->client;
		bs->ordered = qfalse;
		//
		if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &ctf_redflag, sizeof(bot_goal_t));
		else memcpy(&bs->teamgoal, &ctf_blueflag, sizeof(bot_goal_t));
		//set the ltg type
		bs->ltgtype = LTG_DEFENDKEYAREA;
		//set the time the bot stops defending the base
		bs->teamgoal_time = FloatTime() + TEAM_DEFENDKEYAREA_TIME;
		bs->defendaway_time = 0;
		BotSetTeamStatus(bs);
	}
	else {
		bs->ltgtype = 0;
		//set the time the bot will stop roaming
		bs->ctfroam_time = FloatTime() + CTF_ROAM_TIME;
		BotSetTeamStatus(bs);
	}
	bs->owndecision_time = FloatTime() + 5;
#ifdef DEBUG
	BotPrintTeamGoal(bs);
#endif //DEBUG
}
#endif	// JUHOX

// JUHOX: 'BotCTFRetreatGoals()' no longer used
#if 0
/*
==================
BotCTFRetreatGoals
==================
*/
void BotCTFRetreatGoals(bot_state_t *bs) {
	//when carrying a flag in ctf the bot should rush to the base
	if (BotCTFCarryingFlag(bs)) {
		//if not already rushing to the base
		if (bs->ltgtype != LTG_RUSHBASE) {
			BotRefuseOrder(bs);
			bs->ltgtype = LTG_RUSHBASE;
			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
			bs->rushbaseaway_time = 0;
			bs->decisionmaker = bs->client;
			bs->ordered = qfalse;
			BotSetTeamStatus(bs);
		}
	}
}
#endif	// JUHOX

// JUHOX: 'BotTeamGoals()' no longer used
#if 0
/*
==================
BotTeamGoals
==================
*/
void BotTeamGoals(bot_state_t *bs, int retreat) {

	if ( retreat ) {
		if (gametype == GT_CTF) {
			BotCTFRetreatGoals(bs);
		}
	}
	else {
		if (gametype == GT_CTF) {
			//decide what to do in CTF mode
			BotCTFSeekGoals(bs);
		}

	}
	// reset the order time which is used to see if
	// we decided to refuse an order
	bs->order_time = 0;
}
#endif	// JUHOX

/*
==================
BotPointAreaNum
==================
*/
int BotPointAreaNum(vec3_t origin) {
	int areanum, numareas, areas[10];
	vec3_t end;

	areanum = trap_AAS_PointAreaNum(origin);
	if (areanum) return areanum;
	VectorCopy(origin, end);
	end[2] += /*10*/24;	// JUHOX
	numareas = trap_AAS_TraceAreas(origin, end, areas, NULL, 10);
	if (numareas > 0) return areas[0];
#if 0	// -JUHOX: search area below the point
	{
		trace_t trace;
		vec3_t mins = {-8, -8, -8};
		vec3_t maxs = {8, 8, 8};

		end[2] -= 10000;
		trap_Trace(&trace, origin, mins, maxs, end, ENTITYNUM_NONE, MASK_SOLID);
		if (!trace.allsolid && !trace.startsolid && trace.fraction < 1) {
			numareas = trap_AAS_TraceAreas(trace.endpos, origin, areas, NULL, 10);
			if (numareas > 0) return areas[0];
		}
	}
#endif
	return 0;
}

/*
==================
ClientName
==================
*/
char *ClientName(int client, char *name, int size) {
	char buf[MAX_INFO_STRING];

	if (client < 0 || client >= MAX_CLIENTS) {
		BotAI_Print(PRT_ERROR, "ClientName: client out of range\n");
		return "[client out of range]";
	}
	trap_GetConfigstring(CS_PLAYERS+client, buf, sizeof(buf));
	strncpy(name, Info_ValueForKey(buf, "n"), size-1);
	name[size-1] = '\0';
	Q_CleanStr( name );
	return name;
}

/*
==================
ClientSkin
==================
*/
char *ClientSkin(int client, char *skin, int size) {
	char buf[MAX_INFO_STRING];

	if (client < 0 || client >= MAX_CLIENTS) {
		BotAI_Print(PRT_ERROR, "ClientSkin: client out of range\n");
		return "[client out of range]";
	}
	trap_GetConfigstring(CS_PLAYERS+client, buf, sizeof(buf));
	strncpy(skin, Info_ValueForKey(buf, "model"), size-1);
	skin[size-1] = '\0';
	return skin;
}

/*
==================
ClientFromName
==================
*/
int ClientFromName(char *name) {
	int i;
	char buf[MAX_INFO_STRING];
	static int maxclients;

	if (!maxclients)
		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
		Q_CleanStr( buf );
		if (!Q_stricmp(Info_ValueForKey(buf, "n"), name)) return i;
	}
	return -1;
}

/*
==================
ClientOnSameTeamFromName
==================
*/
int ClientOnSameTeamFromName(bot_state_t *bs, char *name) {
	int i;
	char buf[MAX_INFO_STRING];
	static int maxclients;

	if (!maxclients)
		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
		if (!BotSameTeam(bs, i))
			continue;
		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
		Q_CleanStr( buf );
		if (!Q_stricmp(Info_ValueForKey(buf, "n"), name)) return i;
	}
	return -1;
}

/*
==================
stristr
==================
*/
char *stristr(char *str, char *charset) {
	int i;

	while(*str) {
		for (i = 0; charset[i] && str[i]; i++) {
			if (toupper(charset[i]) != toupper(str[i])) break;
		}
		if (!charset[i]) return str;
		str++;
	}
	return NULL;
}

/*
==================
EasyClientName
==================
*/
char *EasyClientName(int client, char *buf, int size) {
	int i;
	char *str1, *str2, *ptr, c;
	char name[128];

	strcpy(name, ClientName(client, name, sizeof(name)));
	for (i = 0; name[i]; i++) name[i] &= 127;
	//remove all spaces
	for (ptr = strstr(name, " "); ptr; ptr = strstr(name, " ")) {
		memmove(ptr, ptr+1, strlen(ptr+1)+1);
	}
	//check for [x] and ]x[ clan names
	str1 = strstr(name, "[");
	str2 = strstr(name, "]");
	if (str1 && str2) {
		if (str2 > str1) memmove(str1, str2+1, strlen(str2+1)+1);
		else memmove(str2, str1+1, strlen(str1+1)+1);
	}
	//remove Mr prefix
	if ((name[0] == 'm' || name[0] == 'M') &&
			(name[1] == 'r' || name[1] == 'R')) {
		memmove(name, name+2, strlen(name+2)+1);
	}
	//only allow lower case alphabet characters
	ptr = name;
	while(*ptr) {
		c = *ptr;
		if ((c >= 'a' && c <= 'z') ||
				(c >= '0' && c <= '9') || c == '_') {
			ptr++;
		}
		else if (c >= 'A' && c <= 'Z') {
			*ptr += 'a' - 'A';
			ptr++;
		}
		else {
			memmove(ptr, ptr+1, strlen(ptr + 1)+1);
		}
	}
	strncpy(buf, name, size-1);
	buf[size-1] = '\0';
	return buf;
}

/*
==================
BotSynonymContext
==================
*/
int BotSynonymContext(bot_state_t *bs) {
	int context;

	context = CONTEXT_NORMAL|CONTEXT_NEARBYITEM|CONTEXT_NAMES;

	if ( gametype == GT_CTF	) {
		if (BotTeam(bs) == TEAM_RED) context |= CONTEXT_CTFREDTEAM;
		else context |= CONTEXT_CTFBLUETEAM;
	}

	return context;
}

/*
==================
JUHOX: BotArmorIsUsefulForPlayer
==================
*/
qboolean BotArmorIsUsefulForPlayer(const playerState_t* ps) {
	if (ps->stats[STAT_ARMOR] >= 2 * ps->stats[STAT_MAX_HEALTH]) return qfalse;
	return ps->stats[STAT_HEALTH] > ps->stats[STAT_ARMOR] * ((1 - ARMOR_PROTECTION) / ARMOR_PROTECTION);
}

/*
==================
JUHOX: BotLimitedHealthIsUsefulForPlayer
==================
*/
qboolean BotLimitedHealthIsUsefulForPlayer(const playerState_t* ps) {
	if (ps->powerups[PW_CHARGE]) return qtrue;
	return ps->stats[STAT_HEALTH] < ps->stats[STAT_MAX_HEALTH];
}

/*
==================
JUHOX: BotUnlimitedHealthIsUsefulForPlayer
==================
*/
qboolean BotUnlimitedHealthIsUsefulForPlayer(const playerState_t* ps) {
	if (ps->powerups[PW_CHARGE]) return qtrue;
	if (ps->powerups[PW_REGEN] && ps->stats[STAT_HEALTH] >= ps->stats[STAT_MAX_HEALTH]) return qfalse;
	return ps->stats[STAT_HEALTH] < 2 * ps->stats[STAT_MAX_HEALTH];
}

/*
==================
JUHOX: BotHoldableItemIsUsefulForPlayer
==================
*/
qboolean BotHoldableItemIsUsefulForPlayer(const playerState_t* ps) {
	return ps->stats[STAT_HOLDABLE_ITEM]? qfalse : qtrue;
}

/*
==================
JUHOX: BotPlayerKillDamage

returns the lowest damage that could kill the player
==================
*/
int BotPlayerKillDamage(const playerState_t* ps) {
	int killDamage;
	float pf;	// protection factor

	pf = (1 - ARMOR_PROTECTION) / ARMOR_PROTECTION;	// currently 0.5
	if (ps->stats[STAT_HEALTH] <= ps->stats[STAT_ARMOR] * pf) {
		killDamage = ps->stats[STAT_HEALTH] / (1 - ARMOR_PROTECTION);
	}
	else {
		//killDamage = ps->stats[STAT_ARMOR] / ARMOR_PROTECTION + (ps->stats[STAT_HEALTH] - ps->stats[STAT_ARMOR] * pf);
		killDamage = ps->stats[STAT_HEALTH] + ps->stats[STAT_ARMOR];	// computes the same as the formula above!
	}
	return killDamage;
}

/*
==================
JUHOX: BotPlayerDanger

danger <= -200	... unstoppable!
danger == -100	... 100/100
danger <= 0		... no danger
danger >= 11	... help would be nice, but not required
danger >= 25	... moderate danger
danger >= 75	... extreme danger
danger >= 200	... useless
NOTE:	This function takes information into account that a human player can't derive
		from his display. I justify this by assuming that an endangered player screams
		for help and tells the needed information.
==================
*/
int BotPlayerDanger(const playerState_t* ps) {
	float maxDamage;
	float danger;

	if (ps->stats[STAT_HEALTH] <= 0) return 0;	// a dead player is not in danger

	danger = 0;
	maxDamage = BotPlayerKillDamage(ps);
	if (ps->powerups[PW_CHARGE]) {
		float charge;

		charge = ps->powerups[PW_CHARGE] / 1000.0F - FloatTime();
		if (charge > 0) {
			maxDamage -= TotalChargeDamage(charge);
		}
	}
	danger += 100 - (100 * maxDamage) / ps->stats[STAT_MAX_HEALTH];

	/*
	if (ps->eFlags & EF_FIRING) {
		danger += 10;
	}
	*/
	if (ps->powerups[PW_REDFLAG] || ps->powerups[PW_BLUEFLAG]) {
		danger += 50;
		if (danger < 50) danger = 50;
	}
	if (ps->stats[STAT_STRENGTH] < LOW_STRENGTH_VALUE) {
		danger += 20.0F * (1.0F - (float)ps->stats[STAT_STRENGTH] / LOW_STRENGTH_VALUE);
	}
	return (int) danger;
}

/*
==================
JUHOX: UpdateSplashCalculations
==================
*/
#define APPROX_SPLASH_RADIUS_BFG 400
#define MAX_SPLASH_RADIUS 500
static void UpdateSplashCalculations(bot_state_t* bs) {
	if (bs->enemy < 0) {
		bs->splashCount_grenade = 0;
		bs->splashCount_rocket = 0;
		bs->splashCount_plasma = 0;
		bs->splashCount_bfg = 0;
		bs->splashCount_monster_launcher = 0;
		bs->nextSplashCalculation_time = 0;
		return;
	}

	if (bs->nextSplashCalculation_time < FloatTime()) {
		playerState_t enemyPS;

		bs->nextSplashCalculation_time = FloatTime() + 1 + 0.1 * random();

		bs->splashCount_grenade = 0;
		bs->splashCount_rocket = 0;
		bs->splashCount_plasma = 0;
		bs->splashCount_bfg = 0;
		bs->splashCount_monster_launcher = 0;

		if (BotAI_GetClientState(bs->enemy, &enemyPS)) {
			int player;
			playerState_t playerPS;

			for (player = -1; (player = BotGetNextPlayerOrMonster(bs, player, &playerPS)) >= 0; ) {
				float distance;

				if (player == bs->enemy) continue;

				distance = Distance(bs->origin, playerPS.origin);
				if (distance > MAX_SPLASH_RADIUS) continue;

				if (!BotEntityVisible(&bs->cur_ps, 90, player)) continue;

				if (
					(
						g_gametype.integer >= GT_TEAM &&
						bs->cur_ps.persistant[PERS_TEAM] == playerPS.persistant[PERS_TEAM]
					)

					||
					(
						g_gametype.integer < GT_STU &&
						g_monsterLauncher.integer &&
						G_IsFriendlyMonster(&g_entities[bs->client], &g_entities[playerPS.clientNum])
					)

				) {
					// don't hit this player
					if (distance < SPLASH_RADIUS_GRENADE) bs->splashCount_grenade = -1;
					if (distance < SPLASH_RADIUS_ROCKET) bs->splashCount_rocket = -1;
					if (distance < SPLASH_RADIUS_PLASMA) bs->splashCount_plasma = -1;
					if (distance < APPROX_SPLASH_RADIUS_BFG) bs->splashCount_bfg = -1;
				}
				else {
					// we should hit this player
					if (distance < SPLASH_RADIUS_GRENADE && bs->splashCount_grenade >= 0) bs->splashCount_grenade++;
					if (distance < SPLASH_RADIUS_ROCKET && bs->splashCount_rocket >= 0) bs->splashCount_rocket++;
					if (distance < SPLASH_RADIUS_PLASMA && bs->splashCount_plasma >= 0) bs->splashCount_plasma++;
					if (distance < APPROX_SPLASH_RADIUS_BFG && bs->splashCount_bfg >= 0) bs->splashCount_bfg++;
					if (distance < 500) bs->splashCount_monster_launcher++;
				}
			}
		}
	}
}

// JUHOX: types used with weapon selection
typedef struct {
	int enemyWeapon;
	float distance;
	float verticalDistance;
	qboolean enemyOnGround;
	int enemyConstitution;
	qboolean wallTargetAvailable;
	qboolean mayCauseIdleNoise;
	qboolean chasedByEnemy;	// implies bot's escaping
	qboolean chasingEnemy;
	int danger;
} combatCharacteristics_t;


/*
==================
JUHOX: BotGauntletValue
==================
*/
static float BotGauntletValue(bot_state_t* bs, const combatCharacteristics_t* cc) {
	float value;

	value = 0;

	// ammo
	#if WP_GAUNTLET_MAX_AMMO < 0
		value += 50.0;
	#else
		if (g_unlimitedAmmo.integer) {
			value += 50.0;
		}
		else {
			value += 50.0 * bs->cur_ps.ammo[WP_GAUNTLET] / WP_GAUNTLET_MAX_AMMO;
			if (bs->cur_ps.ammo[WP_GAUNTLET] == 0) value -= 1000;
		}
	#endif

	// distance
	if (cc->distance > 100.0) {
		value += 50.0 * 100.0 / cc->distance;
	}
	else {
		value += 50.0;
	}

	// special attributes
	if (bs->enemy >= 0) {
		if (cc->enemyWeapon == WP_GAUNTLET) {
			if (cc->chasedByEnemy || BotWantsToRetreat(bs)) {
				value += 30.0;	// because enemy can't use Gauntlet's auto aim and speed up
			}
			else if (cc->chasingEnemy) {
				value -= 20.0;
			}
		}
		else if (cc->enemyWeapon == WP_BFG) {
			if (!BotWantsToRetreat(bs)) {
				value += 10.0;
			}
		}
	}
	else if (cc->chasedByEnemy || BotWantsToRetreat(bs)) {
		value -= 30.0;	// we wouldn't be able to attack the enemy
	}

	// prevent gauntlet become the only weapon
	if (
		g_weaponLimit.integer > 0 &&
		level.clients[bs->client].pers.numChoosenWeapons <= 0
	) {
		value -= 1000;
	}


	return value;
}

/*
==================
JUHOX: BotMachineGunValue
==================
*/
static float BotMachineGunValue(bot_state_t* bs, const combatCharacteristics_t* cc) {
	float value;

	value = 0;

	// ammo
	#if WP_MACHINEGUN_MAX_AMMO < 0
		value += 50.0;
	#else
		if (g_unlimitedAmmo.integer) {
			value += 50.0;
		}
		else {
			value += 50.0 * bs->cur_ps.ammo[WP_MACHINEGUN] / WP_MACHINEGUN_MAX_AMMO;
			if (bs->cur_ps.ammo[WP_MACHINEGUN] == 0) value -= 1000;
		}
	#endif

	// distance
	/* machine gun no longer spreads
	if (cc->distance > 500.0) {
		value += 50.0 * 500.0 / cc->distance;
	}
	else {
		value += 50.0;
	}
	*/
	value += 25.0;

	// "splash damage"
	/* machine gun no longer spreads
	if (bs->splashCount_rocket < 0) {
		value -= 15.0;
	}
	else {
		value += 10.0 * bs->splashCount_rocket;
	}
	*/

	// special attributes
	if (bs->cur_ps.weapon != WP_MACHINEGUN || bs->cur_ps.weaponstate != WEAPON_FIRING) {
		value -= 10.0;
	}
	if (bs->enemy >= 0) {
		if (cc->enemyWeapon == WP_GAUNTLET) value += 10.0;
		if (cc->chasingEnemy) value -= 15.0;
		if (cc->chasedByEnemy) value += 15.0;
	}

	return value;
}

/*
==================
JUHOX: BotShotgunValue
==================
*/
static float BotShotgunValue(bot_state_t* bs, const combatCharacteristics_t* cc) {
	float value;

	value = 0;

	// ammo
	#if WP_SHOTGUN_MAX_AMMO < 0
		value += 50.0;
	#else
		if (g_unlimitedAmmo.integer) {
			value += 50.0;
		}
		else {
			value += 50.0 * bs->cur_ps.ammo[WP_SHOTGUN] / WP_SHOTGUN_MAX_AMMO;
			if (bs->cur_ps.ammo[WP_SHOTGUN] == 0) value -= 1000;
		}
	#endif

	// distance
	if (cc->distance > 150.0) {
		value += 50.0 * 150.0 / cc->distance;
	}
	else {
		value += 50.0;
	}

	// "splash damage" (weapon spreading)
	if (bs->splashCount_rocket < 0) {
		value -= 10.0;
	}
	else {
		value += 5.0 * bs->splashCount_rocket;
	}

	// special attributes
	if (
		bs->enemy >= 0 &&
		cc->enemyWeapon == WP_GAUNTLET &&
		//!BotWantsToRetreat(bs)
		cc->chasingEnemy
	) {
		value += 15.0;
	}

	return value;
}

/*
==================
JUHOX: BotGrenadeLauncherValue
==================
*/
static float BotGrenadeLauncherValue(bot_state_t* bs, const combatCharacteristics_t* cc) {
	float value;
	float bestDistance;

	value = 0;

	// ammo
	#if WP_GRENADE_LAUNCHER_MAX_AMMO < 0
		value += 50.0;
	#else
		if (g_unlimitedAmmo.integer) {
			value += 50.0;
		}
		else {
			value += 50.0 * bs->cur_ps.ammo[WP_GRENADE_LAUNCHER] / WP_GRENADE_LAUNCHER_MAX_AMMO;
			if (bs->cur_ps.ammo[WP_GRENADE_LAUNCHER] == 0) value -= 1000;
		}
	#endif

	// distance
	bestDistance = 500.0 - cc->verticalDistance;
	if (bestDistance > SPLASH_RADIUS_GRENADE + 100.0) {
		if (cc->distance > bestDistance) {
			value += 0.1 * bestDistance * (1.0 - (cc->distance - bestDistance) / (0.6 * bestDistance));
		}
		else {
			value += 0.1 * bestDistance * (1.0 + (cc->distance - bestDistance) / (bestDistance - SPLASH_RADIUS_GRENADE));
		}
	}
	else {
		value -= 1000;
	}

	// splash damage
	if (bs->splashCount_grenade < 0) {
		value -= 100.0;
	}
	else {
		value += 20.0 * bs->splashCount_grenade;
	}
	if (bs->splashCount_bfg < 0) {
		value -= 50.0;
	}
	else {
		value += 10.0 * bs->splashCount_bfg;
	}

	// special attributes
	if (bs->enemy >= 0) {
		if (cc->enemyWeapon == WP_PLASMAGUN) value -= 15;
		if (cc->chasedByEnemy) value += 15;
		if (cc->chasingEnemy) value -= 20;
	}

	// prevent grenade launcher become the only weapon
	if (
		g_weaponLimit.integer > 0 &&
		level.clients[bs->client].pers.numChoosenWeapons <= 0
	) {
		value -= 1000;
	}

	return value;
}

/*
==================
JUHOX: BotRocketLauncherValue
==================
*/
static float BotRocketLauncherValue(bot_state_t* bs, const combatCharacteristics_t* cc) {
	float value;
	const float minDistance = 2.5 * SPLASH_RADIUS_ROCKET;

	value = 0;

	// ammo
	#if WP_ROCKET_LAUNCHER_MAX_AMMO < 0
		value += 50.0;
	#else
		if (g_unlimitedAmmo.integer) {
			value += 50.0;
		}
		else {
			value += 50.0 * bs->cur_ps.ammo[WP_ROCKET_LAUNCHER] / WP_ROCKET_LAUNCHER_MAX_AMMO;
			if (bs->cur_ps.ammo[WP_ROCKET_LAUNCHER] == 0) value -= 1000;
		}
	#endif

	// distance
	if (cc->distance > minDistance) {
		value += 50.0 * minDistance / cc->distance;
	}
	else {
		value += 50.0 * (1.0 + (cc->distance - minDistance) / (minDistance - SPLASH_RADIUS_ROCKET));
	}

	// splash damage
	if (bs->splashCount_rocket < 0) {
		value -= 100.0;
	}
	else {
		value += 30.0 * bs->splashCount_rocket;
	}

	// wall target
	if (!cc->wallTargetAvailable) value -= cc->distance / 20.0;

	// special attributes
	if (bs->enemy >= 0 && cc->chasedByEnemy) value += 20.0;

	return value;
}

/*
==================
JUHOX: BotLightningGunValue
==================
*/
static float BotLightningGunValue(bot_state_t* bs, const combatCharacteristics_t* cc) {
	float value;
	const float bestDistance = 0.65 * LIGHTNING_RANGE;

	value = 0;

	// ammo
	#if WP_LIGHTNING_MAX_AMMO < 0
		value += 50.0;
	#else
		if (g_unlimitedAmmo.integer) {
			value += 50.0;
		}
		else {
			value += 50.0 * bs->cur_ps.ammo[WP_LIGHTNING] / WP_LIGHTNING_MAX_AMMO;
			if (bs->cur_ps.ammo[WP_LIGHTNING] == 0) value -= 1000;
		}
	#endif

	// distance
	if (cc->distance > bestDistance) {
		value += 50.0 * (1.0 - (cc->distance - bestDistance) / (LIGHTNING_RANGE - bestDistance));
	}
	else {
		value += 50.0;
	}

	// "splash damage"
	if (bs->splashCount_rocket < 0 && cc->distance > 150) {
		value -= cc->distance / 10.0;
	}
	if (bs->splashCount_rocket > 1) {
		value -= 5.0 * bs->splashCount_rocket;
	}
	if (bs->splashCount_bfg > 1) {
		value -= 3.0 * bs->splashCount_bfg;
	}

	// idle noise
	if (!cc->mayCauseIdleNoise) value -= 50.0;

	// special attributes
	if (bs->enemy >= 0 && cc->enemyWeapon == WP_LIGHTNING) value += 10.0;
	value += 0.2 * cc->danger;
	if (g_entities[bs->client].waterlevel > 1) value -= 100000;
	if (g_lightningDamageLimit.value > 0) {
		value -= 300.0 / g_lightningDamageLimit.value;
	}

	return value;
}

/*
==================
JUHOX: BotRailgunValue
==================
*/
static float BotRailgunValue(bot_state_t* bs, const combatCharacteristics_t* cc) {
	float value;

	value = 0;

	// ammo
	#if WP_RAILGUN_MAX_AMMO < 0
		value += 50.0;
	#else
		if (g_unlimitedAmmo.integer) {
			value += 50.0;
		}
		else {
			value += 50.0 * bs->cur_ps.ammo[WP_RAILGUN] / WP_RAILGUN_MAX_AMMO;
			if (bs->cur_ps.ammo[WP_RAILGUN] == 0) value -= 1000;
		}
	#endif

	// distance
	value += 50.0;

	// idle noise
	if (!cc->mayCauseIdleNoise) value -= 50.0;

	// special attributes
	if (cc->enemyConstitution < 120) value -= 30.0;
	if (
		bs->enemy >= 0 &&
		cc->enemyWeapon == WP_GAUNTLET &&
		cc->chasingEnemy
	) {
		value += 20.0;
	}
	if (bs->splashCount_bfg > 1) value -= 10.0 * bs->splashCount_bfg;	// these enemies might attack us while railgun is reloading

	return value;
}

/*
==================
JUHOX: BotPlasmagunValue
==================
*/
static float BotPlasmagunValue(bot_state_t* bs, const combatCharacteristics_t* cc) {
	float value;
	const float minDistance = 2.0 * SPLASH_RADIUS_PLASMA;

	value = 0;

	// ammo
	#if WP_PLASMAGUN_MAX_AMMO < 0
		value += 50.0;
	#else
		if (g_unlimitedAmmo.integer) {
			value += 50.0;
		}
		else {
			value += 50.0 * bs->cur_ps.ammo[WP_PLASMAGUN] / WP_PLASMAGUN_MAX_AMMO;
			if (bs->cur_ps.ammo[WP_PLASMAGUN] == 0) value -= 1000;
		}
	#endif

	// distance
	if (cc->distance > 500.0) {
		value += 50.0 * 500.0 / cc->distance;
	}
	else if (cc->distance >= minDistance) {
		value += 50.0;
	}
	else {
		value += 50.0 * (1.0 + (cc->distance - minDistance) / (minDistance - SPLASH_RADIUS_PLASMA));
	}

	// splash damage
	if (bs->splashCount_plasma < 0) {
		value -= 50.0;
	}
	else {
		value += 10.0 * bs->splashCount_plasma;
	}

	// wall target
	if (!cc->wallTargetAvailable) value -= cc->distance / 40.0;

	// special attributes
	if (bs->enemy >= 0 && cc->enemyWeapon == WP_GRENADE_LAUNCHER) value += 25.0;

	return value;
}

/*
==================
JUHOX: BotBFGValue
==================
*/
static float BotBFGValue(bot_state_t* bs, const combatCharacteristics_t* cc) {
	float value;
	const float minDistance = 1.5 * APPROX_SPLASH_RADIUS_BFG;

	value = 0;

	// ammo
	#if WP_BFG_MAX_AMMO < 0
		value += 50.0;
	#else
		if (g_unlimitedAmmo.integer) {
			value += 50.0;
		}
		else {
			value += 50.0 * bs->cur_ps.ammo[WP_BFG] / WP_BFG_MAX_AMMO;
			if (bs->cur_ps.ammo[WP_BFG] == 0) value -= 1000;
		}
	#endif

	// distance
	if (cc->distance > minDistance) {
		value += 50.0 * minDistance / cc->distance;
	}
	else {
		value += 50.0 * (1.0 + (cc->distance - minDistance) / (minDistance - APPROX_SPLASH_RADIUS_BFG));
	}

	// splash
	if (bs->splashCount_bfg < 0) {
		value -= 100.0;
	}
	else {
		value += 20.0 * bs->splashCount_bfg;
	}

	// wall target
	if (!cc->wallTargetAvailable) value -= cc->distance / 5.0;

	// idle noise
	if (!cc->mayCauseIdleNoise) value -= 50.0;

	// special attributes
	if (cc->enemyConstitution < 150) value -= 30.0;

	return value;
}

/*
==================
JUHOX: BotMonsterLauncherValue
==================
*/
static float BotMonsterLauncherValue(bot_state_t* bs, const combatCharacteristics_t* cc) {
	float value;
	const float bestDistance = 500.0;
	const float maxDistance = 1200.0;

	value = 0;

	// ammo
	value += 50.0 * bs->cur_ps.ammo[WP_MONSTER_LAUNCHER] / level.maxMonstersPerPlayer;
	if (bs->cur_ps.ammo[WP_MONSTER_LAUNCHER] == 0) value -= 1000;

	// distance
	if (cc->distance > bestDistance) {
		value += 50.0 * (1.0 - (cc->distance - bestDistance) / (maxDistance - bestDistance));
	}
	else {
		value += 50.0;
	}

	// "splash damage"
	value += 5.0 * bs->splashCount_monster_launcher;

	// special attributes
	value += 0.2 * g_monsterHealthScale.integer;
	value += 0.25 * cc->danger;
	if (bs->cur_ps.powerups[PW_CHARGE]) {
		value += 0.01 * (bs->cur_ps.powerups[PW_CHARGE] - level.time);
	}
	if (bs->enemy >= 0) {
		if (cc->chasedByEnemy) value += 20.0;
		if (cc->chasingEnemy) value -= 15.0;
		if (cc->enemyWeapon == WP_BFG) value += 10.0;
		if (bs->enemy < MAX_CLIENTS) {
			if (
				level.clients[bs->enemy].ps.powerups[PW_REDFLAG] ||
				level.clients[bs->enemy].ps.powerups[PW_BLUEFLAG]
			) {
				value -= 10.0;
			}
		}
	}

	// prevent monster launcher become the only weapon
	if (
		g_weaponLimit.integer > 0 &&
		level.clients[bs->client].pers.numChoosenWeapons <= 0
	) {
		value -= 1000;
	}

	return value;
}

/*
==================
JUHOX: BotWeaponValue
==================
*/
static float BotWeaponValue(bot_state_t* bs, const combatCharacteristics_t* cc, int weapon) {
	float value;

	value = -1000000;

	if (bs->cur_ps.stats[STAT_WEAPONS] & (1 << weapon)) {
		switch (weapon) {
		case WP_GAUNTLET:
			value = BotGauntletValue(bs, cc);
			break;
		case WP_MACHINEGUN:
			value = BotMachineGunValue(bs, cc);
			break;
		case WP_SHOTGUN:
			value = BotShotgunValue(bs, cc);
			break;
		case WP_GRENADE_LAUNCHER:
			value = BotGrenadeLauncherValue(bs, cc);
			break;
		case WP_ROCKET_LAUNCHER:
			value = BotRocketLauncherValue(bs, cc);
			break;
		case WP_LIGHTNING:
			value = BotLightningGunValue(bs, cc);
			break;
		case WP_RAILGUN:
			value = BotRailgunValue(bs, cc);
			break;
		case WP_PLASMAGUN:
			value = BotPlasmagunValue(bs, cc);
			break;
		case WP_BFG:
			value = BotBFGValue(bs, cc);
			break;
		case WP_MONSTER_LAUNCHER:
			value = BotMonsterLauncherValue(bs, cc);
			break;
		}
		if (bs->cur_ps.weapon == weapon) value += 30.0;
	}
	return value;
}

/*
==================
JUHOX: BotGetCombatCharacteristics
==================
*/
static void BotGetCombatCharacteristics(bot_state_t* bs, combatCharacteristics_t* cc) {
	if (bs->enemy >= 0 && bs->enemy < MAX_GENTITIES) {
		gentity_t* enemy;
		playerState_t* ps;

		enemy = &g_entities[bs->enemy];
		ps = G_GetEntityPlayerState(enemy);
		if (!ps) goto NoEnemy;

		cc->enemyWeapon = ps->weapon;
		cc->distance = Distance(ps->origin, bs->origin);
		cc->verticalDistance = ps->origin[2] - bs->origin[2];
		cc->enemyOnGround = ps->groundEntityNum != ENTITYNUM_NONE;
		cc->enemyConstitution = G_Constitution(enemy);
		cc->mayCauseIdleNoise = qtrue;
		cc->wallTargetAvailable = bs->walltarget_time > FloatTime() - 0.75;

		cc->chasedByEnemy = qfalse;
		cc->chasingEnemy = qfalse;
		{
			vec3_t vel;
			float speed;

			speed = VectorNormalize2(bs->cur_ps.velocity, vel);
			if (speed > 100) {
				vec3_t dir;
				float d;

				VectorSubtract(ps->origin, bs->origin, dir);
				VectorNormalize(dir);
				d = DotProduct(vel, dir);
				if (d > 0.707) {	// 0.707 = cos(45°)
					cc->chasingEnemy = qtrue;
				}
				else if (d < -0.707) {
					vec3_t enemyVel;

					// we try to escape
					// see if enemy is chasing us
					VectorNormalize2(ps->velocity, enemyVel);
					if (DotProduct(ps->velocity, dir) < -0.707) {	// consider orientation of 'dir'
						cc->chasedByEnemy = qtrue;
					}
				}
			}
		}
	}
	else {
		NoEnemy:
		cc->enemyWeapon = WP_ROCKET_LAUNCHER;
		cc->distance = 500.0;
		cc->verticalDistance = 0;
		cc->enemyOnGround = qtrue;
		cc->enemyConstitution = g_baseHealth.integer;
		cc->mayCauseIdleNoise = bs->enemyvisible_time >= FloatTime() - 5;
		cc->wallTargetAvailable = qtrue;
		cc->chasedByEnemy = qfalse;
		cc->chasingEnemy = qfalse;
	}
	cc->danger = BotPlayerDanger(&bs->cur_ps);
}

/*
==================
JUHOX: BotGoodWeapon
==================
*/
static int BotGoodWeapon(bot_state_t* bs) {
	combatCharacteristics_t cc;
	float values[WP_NUM_WEAPONS];
	float bestValue;
	int weapon;
	int goodWeapon;
	int numGoodWeapons;

	UpdateSplashCalculations(bs);
	BotGetCombatCharacteristics(bs, &cc);

	bestValue = -100000;

	for (weapon = 0; weapon < WP_NUM_WEAPONS; weapon++) {
		float value;

		value = BotWeaponValue(bs, &cc, weapon);

		if (value > bestValue) bestValue = value;

		values[weapon] = value;
	}

	goodWeapon = -1;
	numGoodWeapons = 0;
	for (weapon = 0; weapon < WP_NUM_WEAPONS; weapon++) {
		float value;

		value = values[weapon];
		if (value > bestValue - 10) {
			numGoodWeapons++;
			if (rand() % numGoodWeapons == 0) {
				goodWeapon = weapon;
			}
		}
	}

	return goodWeapon;
}

/*
==================
BotChooseWeapon
==================
*/
void BotChooseWeapon(bot_state_t *bs) {
	int newweaponnum;

	if (bs->cur_ps.stats[STAT_HEALTH] <= 0) return;	// JUHOX
	if (bs->cur_ps.weaponstate == WEAPON_RAISING ||
			bs->cur_ps.weaponstate == WEAPON_DROPPING) {
		if (bs->weaponnum == WP_NONE) return;	// JUHOX
		trap_EA_SelectWeapon(bs->client, bs->weaponnum);
	}
	else {
#if 0	// JUHOX: enhanced weapon selection logic
		newweaponnum = trap_BotChooseBestFightWeapon(bs->ws, bs->inventory);
#else
		if (bs->railgunJump_ordertime > 0) {
			newweaponnum = WP_RAILGUN;
			bs->weaponProposal = newweaponnum;
			bs->weaponProposal_time = 0;
			goto SelectWeapon;
		}

		if (bs->weaponchoose_time > FloatTime()) {
			newweaponnum = bs->weaponProposal;
			if (newweaponnum <= WP_NONE) return;
			goto SelectWeapon;
		}

		bs->weaponchoose_time = FloatTime() + 0.5 + 0.5 * random();

		newweaponnum = BotGoodWeapon(bs);
		if (newweaponnum == WP_NONE) return;	// should only happen for spectators
		if (bs->cur_ps.ammo[bs->weaponnum] <= 0) {
			bs->weaponProposal = newweaponnum;
			bs->weaponProposal_time = 0;
		}

		SelectWeapon:
		if (bs->weaponProposal != newweaponnum) {
			bs->weaponProposal = newweaponnum;
			bs->weaponProposal_time = FloatTime();
			return;
		}
		if (bs->weaponProposal_time > FloatTime() - 2 * /*BotReactionTime(bs)*/bs->reactiontime) {
			return;
		}
		newweaponnum = bs->weaponProposal;
#endif
		if (bs->weaponnum != newweaponnum) bs->weaponchange_time = FloatTime();
		bs->weaponnum = newweaponnum;
		//BotAI_Print(PRT_MESSAGE, "bs->weaponnum = %d\n", bs->weaponnum);
		trap_EA_SelectWeapon(bs->client, bs->weaponnum);
	}
}

/*
==================
JUHOX: LTGNearlyFulfilled
==================
*/
qboolean LTGNearlyFulfilled(bot_state_t* bs) {
	playerState_t ps;
	int danger, strength;

	if (g_gametype.integer != GT_STU && bs->getImportantNBGItem) return qfalse;

	if (
		bs->enemy >= 0 &&
		(
			//!g_stamina.integer ||
			BotPlayerDanger(&bs->cur_ps) > 0
		)
	) return qfalse;
	switch (bs->ltgtype) {
		case 0:
		default:

			if (g_gametype.integer == GT_STU) return qtrue;

			if (!g_stamina.integer) return qfalse;
			if (bs->cur_ps.stats[STAT_STRENGTH] < 2*LOW_STRENGTH_VALUE) return qtrue;
			if (BotWantsToRetreat(bs)) return qfalse;
			return qtrue;
		case LTG_CAMP:
		case LTG_CAMPORDER:
		case LTG_WAIT:
			return qtrue;
		case LTG_TEAMHELP:
			if (!BotAI_GetClientState(bs->teammate, &ps)) return qtrue;
			if (ps.stats[STAT_HEALTH] <= 0) return qtrue;
#if BOTS_USE_TSS
			if (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_isValid)) {
				if (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_groupFormation) == TSSGF_tight) {
					if (VectorLengthSquared(ps.velocity) > 250*250) return qfalse;
					return DistanceSquared(ps.origin, bs->origin) < 300*300;
				}
			}
#endif
			strength = bs->cur_ps.stats[STAT_STRENGTH];
			danger = BotPlayerDanger(&ps);
			if (danger > 25) {
				if (danger > 75) danger = 75;
				return strength < (0.4 + 0.6 * (1 - danger/75.0)) * MAX_STRENGTH_VALUE;
			}
			if (strength < 0.8 * MAX_STRENGTH_VALUE) return qtrue;
			if (
				VectorLengthSquared(ps.velocity) > Square(250) &&
				ps.groundEntityNum != ENTITYNUM_NONE
			) {
				return qfalse;
			}

			if (g_gametype.integer == GT_STU) return qtrue;

			if (DistanceSquared(ps.origin, bs->origin) > Square(600)) return qfalse;
			return qtrue;
		case LTG_ESCAPE:
			if (bs->cur_ps.stats[STAT_STRENGTH] < LOW_STRENGTH_VALUE) return qtrue;
			if (BotWantsToRetreat(bs)) return qfalse;
			return qtrue;
		case LTG_GETFLAG:
			if (BotOwnFlagStatus(bs) != FLAG_ATBASE) return qfalse;
			return qtrue;
		case LTG_RUSHBASE:
			if (BotOwnFlagStatus(bs) == FLAG_ATBASE) return qfalse;
			return NearHomeBase(bs->cur_ps.persistant[PERS_TEAM], bs->origin, 9);
		case LTG_RETURNFLAG:
			if (
				BotEnemyFlagStatus(bs) == FLAG_TAKEN &&
				NearHomeBase(OtherTeam(bs->cur_ps.persistant[PERS_TEAM]), bs->origin, 2)
			) {
				return qtrue;
			}
			switch (bs->cur_ps.persistant[PERS_TEAM]) {
			case TEAM_RED:
				if (
					DistanceSquared(bs->origin, ctf_blueflag.origin) <
					DistanceSquared(bs->teamgoal.origin, ctf_blueflag.origin)
				) {
					return qtrue;
				}
				break;
			case TEAM_BLUE:
				if (
					DistanceSquared(bs->origin, ctf_redflag.origin) <
					DistanceSquared(bs->teamgoal.origin, ctf_redflag.origin)
				) {
					return qtrue;
				}
				break;
			default:
				return qtrue;
			}
			return qfalse;
	}
}

/*
==================
BotSetupForMovement
==================
*/
void BotSetupForMovement(bot_state_t *bs) {
	bot_initmove_t initmove;

	memset(&initmove, 0, sizeof(bot_initmove_t));
	VectorCopy(bs->cur_ps.origin, initmove.origin);
	VectorCopy(bs->cur_ps.velocity, initmove.velocity);
	VectorClear(initmove.viewoffset);
	initmove.viewoffset[2] += bs->cur_ps.viewheight;
	initmove.entitynum = bs->entitynum;
	initmove.client = bs->client;
	initmove.thinktime = bs->thinktime;
	//set the onground flag
	if (bs->cur_ps.groundEntityNum != ENTITYNUM_NONE) initmove.or_moveflags |= MFL_ONGROUND;
	//set the teleported flag
	if ((bs->cur_ps.pm_flags & PMF_TIME_KNOCKBACK) && (bs->cur_ps.pm_time > 0)) {
		initmove.or_moveflags |= MFL_TELEPORTED;
	}
	//set the waterjump flag
	if ((bs->cur_ps.pm_flags & PMF_TIME_WATERJUMP) && (bs->cur_ps.pm_time > 0)) {
		initmove.or_moveflags |= MFL_WATERJUMP;
	}
	//set presence type
	if (bs->cur_ps.pm_flags & PMF_DUCKED) initmove.presencetype = PRESENCE_CROUCH;
	else initmove.presencetype = PRESENCE_NORMAL;
	//
	if (bs->walker > 0.5) initmove.or_moveflags |= MFL_WALK;
	// JUHOX: bots should be silent if nothing important to do
#if 1
	if (
		(
			g_stamina.integer ||
			g_gametype.integer != GT_CTF
		) &&
		!bs->nbgGivesPODMarker &&
		LTGNearlyFulfilled(bs)
	) {
		initmove.or_moveflags |= MFL_WALK;
	}
#endif
	// JUHOX: since the MFL_WALK is not checked by all movement functions (bug?) we use 'forceWalk'
#if 1
	bs->forceWalk = (initmove.or_moveflags & MFL_WALK)? qtrue : qfalse;
#endif
	if (bs->forceWalk) bs->tfl &= ~TFL_JUMP;	// JUHOX
	//
	VectorCopy(bs->viewangles, initmove.viewangles);
	//
	trap_BotInitMoveState(bs->ms, &initmove);
	bs->preventJump = qfalse;	// JUHOX: eventually set later by movement code
	bs->specialMove = qfalse;	// JUHOX: eventually set later
}

/*
==================
BotCheckItemPickup
==================
*/
void BotCheckItemPickup(bot_state_t *bs, int *oldinventory) { // SLK> remove
}

/*
==================
BotUpdateInventory
==================
*/
void BotUpdateInventory(bot_state_t *bs) {
	int oldinventory[MAX_ITEMS];

	memcpy(oldinventory, bs->inventory, sizeof(oldinventory));
	//armor
	bs->inventory[INVENTORY_ARMOR] = bs->cur_ps.stats[STAT_ARMOR];
	//weapons
	bs->inventory[INVENTORY_GAUNTLET] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_GAUNTLET)) != 0;
	bs->inventory[INVENTORY_SHOTGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_SHOTGUN)) != 0;
	bs->inventory[INVENTORY_MACHINEGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_MACHINEGUN)) != 0;
	bs->inventory[INVENTORY_GRENADELAUNCHER] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_GRENADE_LAUNCHER)) != 0;
	bs->inventory[INVENTORY_ROCKETLAUNCHER] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_ROCKET_LAUNCHER)) != 0;
	bs->inventory[INVENTORY_LIGHTNING] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_LIGHTNING)) != 0;
	bs->inventory[INVENTORY_RAILGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_RAILGUN)) != 0;
	bs->inventory[INVENTORY_PLASMAGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_PLASMAGUN)) != 0;
	bs->inventory[INVENTORY_BFG10K] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_BFG)) != 0;
	bs->inventory[INVENTORY_GRAPPLINGHOOK] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_GRAPPLING_HOOK)) != 0;
	//ammo
	bs->inventory[INVENTORY_SHELLS] = bs->cur_ps.ammo[WP_SHOTGUN];
	bs->inventory[INVENTORY_BULLETS] = bs->cur_ps.ammo[WP_MACHINEGUN];
	bs->inventory[INVENTORY_GRENADES] = bs->cur_ps.ammo[WP_GRENADE_LAUNCHER];
	bs->inventory[INVENTORY_CELLS] = bs->cur_ps.ammo[WP_PLASMAGUN];
	bs->inventory[INVENTORY_LIGHTNINGAMMO] = bs->cur_ps.ammo[WP_LIGHTNING];
	bs->inventory[INVENTORY_ROCKETS] = bs->cur_ps.ammo[WP_ROCKET_LAUNCHER];
	bs->inventory[INVENTORY_SLUGS] = bs->cur_ps.ammo[WP_RAILGUN];
	// JUHOX: BFG ammo is now more valuable than before, so cheat the AI a bit
#if 0
	bs->inventory[INVENTORY_BFGAMMO] = bs->cur_ps.ammo[WP_BFG];
#else
	bs->inventory[INVENTORY_BFGAMMO] = 10 * bs->cur_ps.ammo[WP_BFG];
#endif
	//powerups
	bs->inventory[INVENTORY_HEALTH] = bs->cur_ps.stats[STAT_HEALTH];
	bs->inventory[INVENTORY_TELEPORTER] = bs->cur_ps.stats[STAT_HOLDABLE_ITEM] == MODELINDEX_TELEPORTER;
	bs->inventory[INVENTORY_MEDKIT] = bs->cur_ps.stats[STAT_HOLDABLE_ITEM] == MODELINDEX_MEDKIT;
	bs->inventory[INVENTORY_QUAD] = bs->cur_ps.powerups[PW_QUAD] != 0;
	bs->inventory[INVENTORY_ENVIRONMENTSUIT] = bs->cur_ps.powerups[PW_BATTLESUIT] != 0;
	bs->inventory[INVENTORY_HASTE] = bs->cur_ps.powerups[PW_HASTE] != 0;
	bs->inventory[INVENTORY_INVISIBILITY] = bs->cur_ps.powerups[PW_INVIS] != 0;
	bs->inventory[INVENTORY_REGEN] = bs->cur_ps.powerups[PW_REGEN] != 0;
	bs->inventory[INVENTORY_FLIGHT] = bs->cur_ps.powerups[PW_FLIGHT] != 0;
	bs->inventory[INVENTORY_REDFLAG] = bs->cur_ps.powerups[PW_REDFLAG] != 0;
	bs->inventory[INVENTORY_BLUEFLAG] = bs->cur_ps.powerups[PW_BLUEFLAG] != 0;
	BotCheckItemPickup(bs, oldinventory);
}

/*
==================
BotUpdateBattleInventory
==================
*/
void BotUpdateBattleInventory(bot_state_t *bs, int enemy) {
	// JUHOX: ENEMY_HEIGHT and ENEMY_HORIZONTAL_DIST are no longer needed
#if 0
	vec3_t dir;
	aas_entityinfo_t entinfo;

	BotEntityInfo(enemy, &entinfo);
	VectorSubtract(entinfo.origin, bs->origin, dir);
	bs->inventory[ENEMY_HEIGHT] = (int) dir[2];
	dir[2] = 0;
	bs->inventory[ENEMY_HORIZONTAL_DIST] = (int) VectorLength(dir);
	//FIXME: add num visible enemies and num visible team mates to the inventory
#endif
}

/*
==================
BotBattleUseItems
==================
*/
void BotBattleUseItems(bot_state_t *bs) {
	// JUHOX: item usage should also depend on max health
#if 0
	if (bs->inventory[INVENTORY_HEALTH] < 40) {
#else
	if (
		bs->cur_ps.stats[STAT_HEALTH] < 0.4 * bs->cur_ps.stats[STAT_MAX_HEALTH] &&
		level.clients[bs->client].lasthurt_time > level.time + 2000
	) {
#endif
		if (bs->inventory[INVENTORY_TELEPORTER] > 0) {
			if ( !BotCTFCarryingFlag ( bs ) ) {
				trap_EA_Use(bs->client);
			}
		}
	}
	// JUHOX: item usage should also depend on max health
#if 0
	if (bs->inventory[INVENTORY_HEALTH] < 60) {
#else
	if (bs->cur_ps.stats[STAT_HEALTH] < 0.6 * bs->cur_ps.stats[STAT_MAX_HEALTH]) {
#endif
		if (bs->inventory[INVENTORY_MEDKIT] > 0) {
			trap_EA_Use(bs->client);
		}
	}
}

/*
==================
BotSetTeleportTime
==================
*/
void BotSetTeleportTime(bot_state_t *bs) {
	if ((bs->cur_ps.eFlags ^ bs->last_eFlags) & EF_TELEPORT_BIT) {
		bs->teleport_time = FloatTime();
		VectorCopy(bs->origin, bs->teleport_origin);	// JUHOX
	}
	bs->last_eFlags = bs->cur_ps.eFlags;
}

/*
==================
BotIsDead
==================
*/
qboolean BotIsDead(bot_state_t *bs) {
	// JUHOX: use other death condition, dead players may have PM_SPECTATOR now
#if 0
	return (bs->cur_ps.pm_type == PM_DEAD);
#else
	return bs->cur_ps.stats[STAT_HEALTH] <= 0;
#endif
}

/*
==================
BotIsObserver
==================
*/
qboolean BotIsObserver(bot_state_t *bs) {
	char buf[MAX_INFO_STRING];
	if (bs->cur_ps.pm_type == PM_SPECTATOR) return qtrue;
	trap_GetConfigstring(CS_PLAYERS+bs->client, buf, sizeof(buf));
	if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) return qtrue;
	return qfalse;
}

/*
==================
BotIntermission
==================
*/
qboolean BotIntermission(bot_state_t *bs) {
	//NOTE: we shouldn't be looking at the game code...
	if (level.intermissiontime) return qtrue;
#if MEETING	// JUHOX: no AI during meeting
	if (bs->cur_ps.pm_type == PM_MEETING) return qtrue;
#endif
	return (bs->cur_ps.pm_type == PM_FREEZE || bs->cur_ps.pm_type == PM_INTERMISSION);
}

/*
==================
BotInLavaOrSlime
==================
*/
qboolean BotInLavaOrSlime(bot_state_t *bs) {
	vec3_t feet;

	if (bs->travelLavaAndSlime_time > FloatTime()) return qtrue;	// JUHOX
	VectorCopy(bs->origin, feet);
	feet[2] -= 23;
	return (trap_AAS_PointContents(feet) & (CONTENTS_LAVA|CONTENTS_SLIME));
}

/*
==================
BotCreateWayPoint
==================
*/
bot_waypoint_t *BotCreateWayPoint(char *name, vec3_t origin, int areanum) {
	bot_waypoint_t *wp;
	vec3_t waypointmins = {-8, -8, -8}, waypointmaxs = {8, 8, 8};

	wp = botai_freewaypoints;
	if ( !wp ) {
		BotAI_Print( PRT_WARNING, "BotCreateWayPoint: Out of waypoints\n" );
		return NULL;
	}
	botai_freewaypoints = botai_freewaypoints->next;

	Q_strncpyz( wp->name, name, sizeof(wp->name) );
	VectorCopy(origin, wp->goal.origin);
	VectorCopy(waypointmins, wp->goal.mins);
	VectorCopy(waypointmaxs, wp->goal.maxs);
	wp->goal.areanum = areanum;
	wp->next = NULL;
	wp->prev = NULL;
	return wp;
}

/*
==================
BotFindWayPoint
==================
*/
bot_waypoint_t *BotFindWayPoint(bot_waypoint_t *waypoints, char *name) {
	bot_waypoint_t *wp;

	for (wp = waypoints; wp; wp = wp->next) {
		if (!Q_stricmp(wp->name, name)) return wp;
	}
	return NULL;
}

/*
==================
BotFreeWaypoints
==================
*/
void BotFreeWaypoints(bot_waypoint_t *wp) {
	bot_waypoint_t *nextwp;

	for (; wp; wp = nextwp) {
		nextwp = wp->next;
		wp->next = botai_freewaypoints;
		botai_freewaypoints = wp;
	}
}

/*
==================
BotInitWaypoints
==================
*/
void BotInitWaypoints(void) {
	int i;

	botai_freewaypoints = NULL;
	for (i = 0; i < MAX_WAYPOINTS; i++) {
		botai_waypoints[i].next = botai_freewaypoints;
		botai_freewaypoints = &botai_waypoints[i];
	}
}

/*
==================
TeamPlayIsOn
==================
*/
int TeamPlayIsOn(void) {
	return ( gametype >= GT_TEAM );
}

/*
==================
BotAggression
==================
*/
float BotAggression(bot_state_t *bs) {
	if (bs->cur_ps.weaponTime > 1000) return 0;	// JUHOX
	//if the bot has quad
	if (bs->inventory[INVENTORY_QUAD]) {
#if 0	// JUHOX: quad now always makes aggressive (remove the only reference to ENEMY_HORIZONTAL_DIST)
		//if the bot is not holding the gauntlet or the enemy is really nearby
		if (bs->weaponnum != WP_GAUNTLET ||
			bs->inventory[ENEMY_HORIZONTAL_DIST] < 80) {
			return 70;
		}
#else
		return 100;
#endif
	}
#if 0	// JUHOX: don't check the enemy height, so we no longer depend on BotUpdateBattleInventory()
	//if the enemy is located way higher than the bot
	if (bs->inventory[ENEMY_HEIGHT] > 200) return 0;
#endif
#if 0	// JUHOX: take skill into account
	//if the bot is very low on health
	if (bs->inventory[INVENTORY_HEALTH] < 60) return 0;
	//if the bot is low on health
	if (bs->inventory[INVENTORY_HEALTH] < 80) {
		//if the bot has insufficient armor
		if (bs->inventory[INVENTORY_ARMOR] < 40) return 0;
	}
#else
	/*
	if (bs->inventory[INVENTORY_HEALTH] < 0.6 * bs->cur_ps.stats[STAT_MAX_HEALTH]) return 0;
	if (bs->inventory[INVENTORY_HEALTH] < 0.8 * bs->cur_ps.stats[STAT_MAX_HEALTH]) {
		if (bs->inventory[INVENTORY_ARMOR] < 0.4 * bs->cur_ps.stats[STAT_MAX_HEALTH]) return 0;
	}
	*/
	if (BotPlayerDanger(&bs->cur_ps) >= 25) return 0;
#endif
	if (g_unlimitedAmmo.integer) return 100;	// JUHOX
	//if the bot can use the bfg
	if (bs->inventory[INVENTORY_BFG10K] > 0 &&
			bs->inventory[INVENTORY_BFGAMMO] > /*7*/1) return 100;	// JUHOX
	//if the bot can use the railgun
	if (bs->inventory[INVENTORY_RAILGUN] > 0 &&
			bs->inventory[INVENTORY_SLUGS] > /*5*/1) return 95;	// JUHOX
	//if the bot can use the lightning gun
	if (bs->inventory[INVENTORY_LIGHTNING] > 0 &&
			bs->inventory[INVENTORY_LIGHTNINGAMMO] > 50) return 90;
	//if the bot can use the rocketlauncher
	if (bs->inventory[INVENTORY_ROCKETLAUNCHER] > 0 &&
			bs->inventory[INVENTORY_ROCKETS] > /*5*/2) return 90;	// JUHOX
	if (bs->inventory[INVENTORY_MACHINEGUN] > 0 && bs->inventory[INVENTORY_BULLETS] > 14) return 85;	// JUHOX
	//if the bot can use the plasmagun
	if (bs->inventory[INVENTORY_PLASMAGUN] > 0 &&
			bs->inventory[INVENTORY_CELLS] > 40) return 85;
	//if the bot can use the grenade launcher
	if (bs->inventory[INVENTORY_GRENADELAUNCHER] > 0 &&
			bs->inventory[INVENTORY_GRENADES] > 10) return 80;
	//if the bot can use the shotgun
	if (bs->inventory[INVENTORY_SHOTGUN] > 0 &&
			bs->inventory[INVENTORY_SHELLS] > /*10*/2) return 50;	// JUHOX
	//otherwise the bot is not feeling too good
	return 0;
}

/*
==================
BotFeelingBad
==================
*/
float BotFeelingBad(bot_state_t *bs) {
	if (bs->weaponnum == WP_GAUNTLET) {
		return 100;
	}
	if (bs->inventory[INVENTORY_HEALTH] < 40) {
		return 100;
	}
	if (bs->weaponnum == WP_MACHINEGUN) {
		return 90;
	}
	if (bs->inventory[INVENTORY_HEALTH] < 60) {
		return 80;
	}
	return 0;
}

/*
==================
JUHOX: BotEnemyTooStrong
==================
*/
qboolean BotEnemyTooStrong(bot_state_t* bs) {
	int player;
	playerState_t ps;
	int numTotalTeammates, numVisTeammates;
	int numTotalEnemies, numVisEnemies;

	if (gametype < GT_TEAM) return qfalse;
	// JUHOX FIXME: enemy never too strong in STU?
	if (gametype == GT_STU) return qfalse;

	if (bs->enemy < 0 && bs->cur_ps.stats[STAT_HEALTH] > 0) {
		if (bs->enemytoostrong) {
			if (bs->enemytoostrong_time + 1 > FloatTime()) {
				return qtrue;
			}
			bs->enemytoostrong = qfalse;
			bs->enemytoostrong_time = FloatTime();
		}
		return qfalse;
	}

	if (bs->enemytoostrong_time < FloatTime()) {
		bs->enemytoostrong_time = FloatTime() + 0.5 + 0.5*random();

		BotDetermineVisibleTeammates(bs);

		numTotalTeammates = numVisTeammates = 1;	// the bot itself
		numTotalEnemies = numVisEnemies = 0;
		for (player = -1; (player = BotGetNextPlayer(bs, player, &ps)) >= 0; ) {
			qboolean vis;

			if (bs->cur_ps.persistant[PERS_TEAM] == ps.persistant[PERS_TEAM]) {
				numTotalTeammates++;
				continue;
			}
			numTotalEnemies++;
			if (ps.stats[STAT_HEALTH] <= 0) {
				vis = qfalse;
			}
			else {
				vis = (BotEntityVisible(&bs->cur_ps, 90, player) > 0);
			}
			if (vis) numVisEnemies++;
		}

		numVisTeammates += bs->numvisteammates;

		bs->enemytoostrong = (numVisEnemies * numTotalTeammates > numVisTeammates * numTotalEnemies);
	}
	return bs->enemytoostrong;
}

/*
==================
JUHOX: BotWantsToEscape
==================
*/
int BotWantsToEscape(bot_state_t *bs) {
	if (BotCTFCarryingFlag(bs) && !NearHomeBase(bs->cur_ps.persistant[PERS_TEAM], bs->origin, 9)) return qfalse;
#if BOTS_USE_TSS
	if (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_isValid)) {
		if (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_groupMemberStatus) != TSSGMS_retreating) return qfalse;
	}
#endif
	if (bs->enemy < 0) return qfalse;
	if (g_gametype.integer == GT_STU && G_NumMonsters() > 15) return qfalse;	// if too many monsters, it's safer to stay
	if (BotPlayerDanger(&bs->cur_ps) >= 70) return qtrue;
	if (BotEnemyTooStrong(bs)) return qtrue;
	return qfalse;
}

/*
==================
BotWantsToRetreat
==================
*/
int BotWantsToRetreat(bot_state_t *bs) {
	aas_entityinfo_t entinfo;

	// JUHOX: return cached value if possible
	if (bs->wantsToRetreat_time == FloatTime()) return bs->wantsToRetreat;
	bs->wantsToRetreat = qtrue;
	bs->wantsToRetreat_time = FloatTime();

	// JUHOX: retreat when standing in lava or slime
	if (bs->tfl & (TFL_LAVA|TFL_SLIME)) return qtrue;

	if (BotWantsToEscape(bs)) return qtrue;	// JUHOX
	if (gametype == GT_CTF) {
		//always retreat when carrying a CTF flag
		if (BotCTFCarryingFlag(bs))
			return qtrue;
	}
#if BOTS_USE_TSS	// JUHOX: if the TSS is active, only retreat when said to
	if (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_isValid)) {
		if (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_groupMemberStatus) == TSSGMS_retreating) return qtrue;
		if (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_missionStatus) == TSSMS_aborted) return qtrue;
		switch (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_mission)) {
		case TSSMISSION_seek_items:
		case TSSMISSION_capture_enemy_flag:
			return qtrue;
		case TSSMISSION_defend_our_flag:
			if (
				BotOwnFlagStatus(bs) != FLAG_ATBASE ||
				!NearHomeBase(bs->cur_ps.persistant[PERS_TEAM], bs->origin, 9)
			) {
				return qtrue;
			}
			break;
		case TSSMISSION_defend_our_base:
			if (!NearHomeBase(bs->cur_ps.persistant[PERS_TEAM], bs->origin, 4)) {
				return qtrue;
			}
			break;
		case TSSMISSION_occupy_enemy_base:
			if (!NearHomeBase(OtherTeam(bs->cur_ps.persistant[PERS_TEAM]), bs->origin, 2)) {
				return qtrue;
			}
			break;
		case TSSMISSION_seek_enemy:
			break;
		}
		goto NoRetreat;
	}
#endif
	//
	if (bs->enemy >= 0) {
		//if the enemy is carrying a flag
		BotEntityInfo(bs->enemy, &entinfo);
		if (EntityCarriesFlag(&entinfo))
			/*return qfalse;*/goto NoRetreat;	// JUHOX
	}
	//if the bot is getting the flag
	if (bs->ltgtype == LTG_GETFLAG)
		return qtrue;
	//
	// JUHOX: retreat if helping someone
	if (bs->ltgtype == LTG_TEAMHELP) {
		playerState_t ps;

		if (BotAI_GetClientState(bs->teammate, &ps)) {
			float maxDistanceSqr;

			maxDistanceSqr = g_gametype.integer == GT_CTF? Square(300) : Square(500);
			if (DistanceSquared(bs->origin, ps.origin) > maxDistanceSqr) {
				return qtrue;
			}
		}
	}

	if (BotAggression(bs) < 50)
		return qtrue;
	// JUHOX: bot doesn't want to retreat
	NoRetreat:
	bs->wantsToRetreat = qfalse;

	return qfalse;
}

/*
==================
JUHOX: BotWantsToFight
==================
*/
int BotWantsToFight(bot_state_t *bs, int enemy, qboolean indirectVis) {
	playerState_t ps;

	if (!BotAI_GetClientState(enemy, &ps)) return qfalse;

	if (g_entities[enemy].monster && !IsFightingMonster(&g_entities[enemy])) return qfalse;

	if (g_gametype.integer == GT_CTF) {
		if (bs->ltgtype == LTG_RETURNFLAG) {
			if (ps.powerups[PW_REDFLAG] || ps.powerups[PW_BLUEFLAG]) return qtrue;
			if (enemy == bs->blockingEnemy) return qtrue;
			return qfalse;
		}
#if BOTS_USE_TSS
		if (!BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_isValid)) {
#else
		{
#endif
			if (
				!bs->ltgtype ||
				bs->ltgtype == LTG_TEAMHELP
			) {
				if (
					!IsPlayerFighting(enemy) &&
					!ps.powerups[PW_REDFLAG] &&
					!ps.powerups[PW_BLUEFLAG] &&
					enemy != bs->blockingEnemy &&
					!NearHomeBase(bs->cur_ps.persistant[PERS_TEAM], bs->origin, 4)
				) return qfalse;
			}
			else if (bs->leader == bs->client) {
				if (
					BotOwnFlagStatus(bs) == FLAG_TAKEN ||
					BotEnemyFlagStatus(bs) != FLAG_TAKEN
				) {
					if (
						!IsPlayerFighting(enemy) &&
						!ps.powerups[PW_REDFLAG] &&
						!ps.powerups[PW_BLUEFLAG] &&
						enemy != bs->blockingEnemy
					) return qfalse;
				}
			}
		}
	}

	if (
		indirectVis ||
		(
			!IsPlayerFighting(enemy) &&
			!ps.powerups[PW_REDFLAG] &&
			!ps.powerups[PW_BLUEFLAG]
		)
	) {
		if (enemy == bs->blockingEnemy) return qtrue;
		if (bs->ltgtype == LTG_ESCAPE) return qfalse;

		if (G_IsMonsterSuccessfulAttacking(&g_entities[enemy], &g_entities[bs->entitynum])) return qtrue;

		if (BotWantsToRetreat(bs)) return qfalse;
		if (bs->cur_ps.stats[STAT_STRENGTH] < 2 * LOW_STRENGTH_VALUE) {
			return qfalse;
		}
	}

	return qtrue;
}

/*
==================
BotWantsToChase
==================
*/
int BotWantsToChase(bot_state_t *bs) {
	// JUHOX: new chase decision logic
	if (bs->lastenemyareanum <= 0) return qfalse;
	if (BotWantsToRetreat(bs)) return qfalse;
	if (!BotWantsToFight(bs, bs->enemy, qtrue)) return qfalse;
	if (!trap_AAS_AreaReachability(bs->lastenemyareanum)) return qfalse;
	if (trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, bs->lastenemyareanum, bs->tfl) <= 0) return qfalse;
	return qtrue;
}

/*
==================
BotWantsToHelp
==================
*/
int BotWantsToHelp(bot_state_t *bs) {
	return qtrue;
}

/*
==================
BotCanAndWantsToRocketJump
==================
*/
int BotCanAndWantsToRocketJump(bot_state_t *bs) {
	float rocketjumper;

	//if rocket jumping is disabled
	if (!bot_rocketjump.integer) return qfalse;
	if (bs->ltgtype == LTG_CAMP) return qfalse;	// JUHOX: leader should not use rocket jump
	if (bs->cur_ps.powerups[PW_SHIELD]) return qfalse;	// JUHOX: can't shoot with the shield, so no rocket jumping
	if (bs->cur_ps.stats[STAT_STRENGTH] < 2*LOW_STRENGTH_VALUE + JUMP_STRENGTH_DECREASE) return qfalse;	// JUHOX
#if 1	// JUHOX: railgun jump possible?
	if ((bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_RAILGUN)) && bs->cur_ps.ammo[WP_RAILGUN] != 0) {
		return qtrue;
	}
#endif
	//if no rocket launcher
	if (bs->inventory[INVENTORY_ROCKETLAUNCHER] <= 0) return qfalse;
	//if low on rockets
	if (bs->inventory[INVENTORY_ROCKETS] < 3) return qfalse;
	//never rocket jump with the Quad
	if (bs->inventory[INVENTORY_QUAD]) return qfalse;
	//if low on health
	if (bs->inventory[INVENTORY_HEALTH] < 60) return qfalse;
	//if not full health
	if (bs->inventory[INVENTORY_HEALTH] < 90) {
		//if the bot has insufficient armor
		if (bs->inventory[INVENTORY_ARMOR] < 40) return qfalse;
	}
	rocketjumper = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_WEAPONJUMPING, 0, 1);
	if (rocketjumper < 0.5) return qfalse;
	return qtrue;
}

/*
==================
BotHasPersistantPowerupAndWeapon
==================
*/
int BotHasPersistantPowerupAndWeapon(bot_state_t *bs) {
#if 0	// JUHOX: check aggression
	//if the bot is very low on health
	if (bs->inventory[INVENTORY_HEALTH] < 60) return qfalse;
	//if the bot is low on health
	if (bs->inventory[INVENTORY_HEALTH] < 80) {
		//if the bot has insufficient armor
		if (bs->inventory[INVENTORY_ARMOR] < 40) return qfalse;
	}
	//if the bot can use the bfg
	if (bs->inventory[INVENTORY_BFG10K] > 0 &&
			bs->inventory[INVENTORY_BFGAMMO] > 7) return qtrue;
	//if the bot can use the railgun
	if (bs->inventory[INVENTORY_RAILGUN] > 0 &&
			bs->inventory[INVENTORY_SLUGS] > 5) return qtrue;
	//if the bot can use the lightning gun
	if (bs->inventory[INVENTORY_LIGHTNING] > 0 &&
			bs->inventory[INVENTORY_LIGHTNINGAMMO] > 50) return qtrue;
	//if the bot can use the rocketlauncher
	if (bs->inventory[INVENTORY_ROCKETLAUNCHER] > 0 &&
			bs->inventory[INVENTORY_ROCKETS] > 5) return qtrue;
	//
	if (bs->inventory[INVENTORY_NAILGUN] > 0 &&
			bs->inventory[INVENTORY_NAILS] > 5) return qtrue;
	//
	if (bs->inventory[INVENTORY_PROXLAUNCHER] > 0 &&
			bs->inventory[INVENTORY_MINES] > 5) return qtrue;
	//
	if (bs->inventory[INVENTORY_CHAINGUN] > 0 &&
			bs->inventory[INVENTORY_BELT] > 40) return qtrue;
	//if the bot can use the plasmagun
	if (bs->inventory[INVENTORY_PLASMAGUN] > 0 &&
			bs->inventory[INVENTORY_CELLS] > 20) return qtrue;
	return qfalse;
#else
	return BotAggression(bs) >= 50;
#endif
}

#if 0	// JUHOX: no auto camping
/*
==================
BotGoCamp
==================
*/
void BotGoCamp(bot_state_t *bs, bot_goal_t *goal) {
	float camper;

	bs->decisionmaker = bs->client;
	//set message time to zero so bot will NOT show any message
	bs->teammessage_time = 0;
	//set the ltg type
	bs->ltgtype = LTG_CAMP;
	//set the team goal
	memcpy(&bs->teamgoal, goal, sizeof(bot_goal_t));
	//get the team goal time
	camper = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CAMPER, 0, 1);
	if (camper > 0.99) bs->teamgoal_time = FloatTime() + 99999;
	else bs->teamgoal_time = FloatTime() + 120 + 180 * camper + random() * 15;
	//set the last time the bot started camping
	bs->camp_time = FloatTime();
	//the teammate that requested the camping
	bs->teammate = 0;
	//do NOT type arrive message
	bs->arrive_time = 1;
}

/*
==================
BotWantsToCamp
==================
*/
int BotWantsToCamp(bot_state_t *bs) {
	float camper;
	int cs, traveltime, besttraveltime;
	bot_goal_t goal, bestgoal;

	camper = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CAMPER, 0, 1);
	if (camper < 0.1) return qfalse;
	//if the bot has a team goal
	if (bs->ltgtype == LTG_TEAMHELP ||
			bs->ltgtype == LTG_TEAMACCOMPANY ||
			bs->ltgtype == LTG_DEFENDKEYAREA ||
			bs->ltgtype == LTG_GETFLAG ||
			bs->ltgtype == LTG_RUSHBASE ||
			bs->ltgtype == LTG_CAMP ||
			bs->ltgtype == LTG_CAMPORDER ||
			bs->ltgtype == LTG_PATROL) {
		return qfalse;
	}
	//if camped recently
	if (bs->camp_time > FloatTime() - 60 + 300 * (1-camper)) return qfalse;
	//
	if (random() > camper) {
		bs->camp_time = FloatTime();
		return qfalse;
	}
	//if the bot isn't healthy anough
	if (BotAggression(bs) < 50) return qfalse;
	//the bot should have at least have the rocket launcher, the railgun or the bfg10k with some ammo
	if ((bs->inventory[INVENTORY_ROCKETLAUNCHER] <= 0 || bs->inventory[INVENTORY_ROCKETS < 10]) &&
		(bs->inventory[INVENTORY_RAILGUN] <= 0 || bs->inventory[INVENTORY_SLUGS] < 10) &&
		(bs->inventory[INVENTORY_BFG10K] <= 0 || bs->inventory[INVENTORY_BFGAMMO] < 10)) {
		return qfalse;
	}
	//find the closest camp spot
	besttraveltime = 99999;
	for (cs = trap_BotGetNextCampSpotGoal(0, &goal); cs; cs = trap_BotGetNextCampSpotGoal(cs, &goal)) {
		traveltime = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, goal.areanum, TFL_DEFAULT);
		if (traveltime && traveltime < besttraveltime) {
			besttraveltime = traveltime;
			memcpy(&bestgoal, &goal, sizeof(bot_goal_t));
		}
	}
	if (besttraveltime > 150) return qfalse;
	//ok found a camp spot, go camp there
	BotGoCamp(bs, &bestgoal);
	bs->ordered = qfalse;
	//
	return qtrue;
}
#endif	// JUHOX

/*
==================
BotDontAvoid
==================
*/
void BotDontAvoid(bot_state_t *bs, char *itemname) {
	bot_goal_t goal;
	int num;

	num = trap_BotGetLevelItemGoal(-1, itemname, &goal);
	while(num >= 0) {
		trap_BotRemoveFromAvoidGoals(bs->gs, goal.number);
		num = trap_BotGetLevelItemGoal(num, itemname, &goal);
	}
}

/*
==================
BotGoForPowerups
==================
*/
void BotGoForPowerups(bot_state_t *bs) {

	//don't avoid any of the powerups anymore
	BotDontAvoid(bs, "Quad Damage");
	BotDontAvoid(bs, "Regeneration");
	BotDontAvoid(bs, "Battle Suit");
	BotDontAvoid(bs, "Speed");
	BotDontAvoid(bs, "Invisibility");
	//BotDontAvoid(bs, "Flight");
	//reset the long term goal time so the bot will go for the powerup
	//NOTE: the long term goal type doesn't change
	bs->ltg_time = 0;
}

qboolean InFieldOfVision(vec3_t viewangles, float fov, vec3_t angles);	// JUHOX
/*
==================
BotRoamGoal
==================
*/
// JUHOX: BotRoamGoal has now a return value and an additional parameter
#if 0
void BotRoamGoal(bot_state_t *bs, vec3_t goal) {
#else
qboolean BotRoamGoal(bot_state_t *bs, vec3_t goal, qboolean dynamicOnly) {
#endif
	int pc, i;
	float len, rnd;
	vec3_t dir, bestorg, belowbestorg;
	vec3_t angles;	// JUHOX
	bsp_trace_t trace;

#if 1	// JUHOX: search a dynamic roam goal
	if (dynamicOnly && bs->ltgtype != 0 && DistanceSquared(bs->origin, bs->teamgoal.origin) < 300*300) {
		return qfalse;
	}

	{
		float maxdistanceSqr;
		qboolean found;
		float totalWeight;

		if (bs->dynamicroamgoal_time > FloatTime()) {
			if (dynamicOnly && bs->hasDynamicRoamGoal) {
				VectorCopy(bs->dynamicRoamGoal, goal);
				return qtrue;
			}
			return qfalse;
		}
		bs->dynamicroamgoal_time = FloatTime() + 0.4 + 0.4 * random();

		found = qfalse;
		maxdistanceSqr = Square(1200.0);
		if (bs->cur_ps.powerups[PW_CHARGE]) maxdistanceSqr = Square(600.0);
		totalWeight = 0;
		for (i = 0; i < level.num_entities; i++) {
			gentity_t* ent;
			playerState_t* ps;
			vec3_t origin;
			float distanceSqr;
			float weight;

			ent = &g_entities[i];
			if (!ent->inuse) continue;
			if (!ent->r.linked) continue;
			if (!EntityAudible(ent)) continue;
			if (bs->client == i) continue;

			ps = G_GetEntityPlayerState(ent);
			if (ps) {
				VectorCopy(ps->origin, origin);
			}
			else {
				VectorAdd(ent->r.absmin, ent->r.absmax, origin);
				VectorScale(origin, 0.5, origin);
			}

			VectorSubtract(origin, bs->origin, dir);
			distanceSqr = VectorLengthSquared(dir);
			if (distanceSqr > maxdistanceSqr) continue;

			vectoangles(dir, angles);
			if (InFieldOfVision(bs->viewangles, 100, angles)) continue;
			if (!trap_InPVSIgnorePortals(bs->origin, g_entities[i].s.pos.trBase)) continue;

			weight = 1.0 / (distanceSqr + 100);
			totalWeight += weight;
			if (random() <= weight / totalWeight) {
				found = qtrue;
				VectorCopy(origin, goal);
			}
		}
		if (found) {
			bs->roamgoal_time = FloatTime() + 1 + 2 * random();
			VectorCopy(goal, bs->dynamicRoamGoal);
			bs->hasDynamicRoamGoal = qtrue;
			return qtrue;
		}
		bs->hasDynamicRoamGoal = qfalse;
	}
#endif

#if 1	// JUHOX: check if a new roam goal should be determined
	if (dynamicOnly) return qfalse;
	if (bs->roamgoal_time > FloatTime()) return qfalse;
#endif

	for (i = 0; i < /*10*/3; i++) {	// JUHOX
		//start at the bot origin
		VectorCopy(bs->origin, bestorg);
		rnd = random();
		if (rnd > 0.25) {
			//add a random value to the x-coordinate
			if (random() < 0.5) bestorg[0] -= 800 * random() + 100;
			else bestorg[0] += 800 * random() + 100;
		}
		if (rnd < 0.75) {
			//add a random value to the y-coordinate
			if (random() < 0.5) bestorg[1] -= 800 * random() + 100;
			else bestorg[1] += 800 * random() + 100;
		}
		//add a random value to the z-coordinate (NOTE: 48 = maxjump?)
		bestorg[2] += 2 * 48 * crandom();
		//trace a line from the origin to the roam target
		BotAI_Trace(&trace, bs->origin, NULL, NULL, bestorg, bs->entitynum, MASK_SOLID);
		//direction and length towards the roam target
		VectorSubtract(trace.endpos, bs->origin, dir);
#if 1	// JUHOX: check if the goal is already in the field of vision
		vectoangles(dir, angles);
		if (InFieldOfVision(bs->viewangles, 100, angles)) continue;
#endif
		len = VectorNormalize(dir);
		//if the roam target is far away anough
		if (len > 200) {
			//the roam target is in the given direction before walls
			VectorScale(dir, len * trace.fraction - 40, dir);
			VectorAdd(bs->origin, dir, bestorg);
			//get the coordinates of the floor below the roam target
			belowbestorg[0] = bestorg[0];
			belowbestorg[1] = bestorg[1];
			belowbestorg[2] = bestorg[2] - 800;
			BotAI_Trace(&trace, bestorg, NULL, NULL, belowbestorg, bs->entitynum, MASK_SOLID);
			//
			if (!trace.startsolid) {
				trace.endpos[2]++;
				pc = trap_PointContents(trace.endpos, bs->entitynum);
				if (!(pc & (CONTENTS_LAVA | CONTENTS_SLIME))) {
					VectorCopy(bestorg, goal);
#if 0	// JUHOX: found a roaming view goal
					return;
#else
					bs->roamgoal_time = FloatTime() + 0.5 + 2 * random();
					return qtrue;
#endif
				}
			}
		}
	}
#if 0	// JUHOX: no roaming view goal found
	VectorCopy(bestorg, goal);
#else
	bs->roamgoalcnt = 0;	// do not use a roam goal
	return qfalse;
#endif
}

/*
==================
BotAttackMove
==================
*/
bot_moveresult_t BotAttackMove(bot_state_t *bs, int tfl) {
	int movetype, i, attackentity;
	float attack_skill, jumper, croucher, dist/*, strafechange_time*/;	// JUHOX: strafechange_time no longer needed
	float attack_dist, attack_range;
	vec3_t forward, backward, sideward, hordir, up = {0, 0, 1};
	aas_entityinfo_t entinfo;
	bot_moveresult_t moveresult;
	bot_goal_t goal;
	float speed;	// JUHOX

	attackentity = bs->enemy;
#if 1	// JUHOX: safety check
	if (attackentity < 0) {
		memset(&moveresult, 0, sizeof(moveresult));
		return moveresult;
	}
#endif
	//
#if 0	// JUHOX: more chase conditions for attack move
	if (bs->attackchase_time > FloatTime()) {
#else
	BotEntityInfo(attackentity, &entinfo);	// moved to here from below!
	if (
		(
			bs->attackchase_time > FloatTime() ||
			(
				(
					bs->enemysight_time > FloatTime() - 0.5 - Distance(bs->origin, entinfo.origin) / 1000 ||
					(entinfo.powerups & ((1 << PW_REDFLAG) | (1 << PW_BLUEFLAG)))
				) &&
				DistanceSquared(bs->origin, entinfo.origin) > Square(300)
			)
		) &&
		bs->lastenemyareanum > 0
	) {
#endif
		//create the chase goal
		goal.entitynum = attackentity;
		goal.areanum = bs->lastenemyareanum;
		VectorCopy(bs->lastenemyorigin, goal.origin);
		VectorSet(goal.mins, -8, -8, -8);
		VectorSet(goal.maxs, 8, 8, 8);
		//initialize the movement state
		BotSetupForMovement(bs);
		//move towards the goal
		trap_BotMoveToGoal(&moveresult, bs->ms, &goal, tfl);
		return moveresult;
	}
	//
	memset(&moveresult, 0, sizeof(bot_moveresult_t));
	//
	attack_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_ATTACK_SKILL, 0, 1);
	jumper = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_JUMPER, 0, 1);
	croucher = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CROUCHER, 0, 1);
	//if the bot is really stupid
	if (attack_skill < 0.2) return moveresult;
	//initialize the movement state
	BotSetupForMovement(bs);
	//get the enemy entity info
	//BotEntityInfo(attackentity, &entinfo);	// JUHOX: already done above
	//direction towards the enemy
	VectorSubtract(entinfo.origin, bs->origin, forward);
	//the distance towards the enemy
	dist = VectorNormalize(forward);
	VectorNegate(forward, backward);
	//walk, crouch or jump
	movetype = MOVE_WALK;
#if 0	// JUHOX: neither jump nor crouch during attack randomly
	//
	if (bs->attackcrouch_time < FloatTime() - 1) {
		if (random() < jumper) {
			movetype = MOVE_JUMP;
		}
		//wait at least one second before crouching again
		else if (bs->attackcrouch_time < FloatTime() - 1 && random() < croucher) {
			bs->attackcrouch_time = FloatTime() + croucher * 5;
		}
	}
	if (bs->attackcrouch_time > FloatTime()) movetype = MOVE_CROUCH;
#endif
#if 1	// JUHOX: most weapons become more precise if the bot crouches
	if (
		attack_skill >= 0.5 &&
		(
			dist > 600 ||
			(dist > 400 && (bs->cur_ps.pm_flags & PMF_DUCKED)) ||
			bs->cur_ps.weapon == WP_BFG ||
			bs->cur_ps.weapon == WP_ROCKET_LAUNCHER
		) &&
		bs->cur_ps.weapon != WP_GAUNTLET &&
		//bs->cur_ps.weapon != WP_GRENADE_LAUNCHER &&
		bs->cur_ps.weapon != WP_LIGHTNING &&
		(
			bs->cur_ps.weapon == WP_RAILGUN ||
			entinfo.weapon != WP_RAILGUN
		) &&
		bs->couldNotSeeEnemyWhileDucked_time < FloatTime() - 3 &&	// to suppress "crouch-shaking"
		!BotWantsToRetreat(bs) &&
		bs->cur_ps.weapon != WP_NONE
	) {
		movetype = MOVE_CROUCH;
	}
#endif
	//if the bot should jump
	if (movetype == MOVE_JUMP) {
		//if jumped last frame
		if (bs->attackjump_time > FloatTime()) {
			movetype = MOVE_WALK;
		}
		else {
			bs->attackjump_time = FloatTime() + 1;
		}
	}
	if (bs->cur_ps.weapon == WP_GAUNTLET) {
		attack_dist = 0;
		attack_range = 0;
	}
#if 1	// JUHOX: more elaborated attack distances
	else if (bs->cur_ps.weapon == WP_BFG) {
		attack_dist = 1500;
		attack_range = 900;
	}
	else if (bs->cur_ps.weapon == WP_ROCKET_LAUNCHER) {
		attack_dist = 700;
		attack_range = 400;
	}
	else if (bs->cur_ps.weapon == WP_GRENADE_LAUNCHER) {
		attack_dist = 500;
		attack_range = 150;
	}
	else if (bs->cur_ps.weapon == WP_PLASMAGUN) {
		attack_dist = 800;
		attack_range = 500;
	}
	else if (bs->cur_ps.weapon == WP_LIGHTNING) {
		attack_dist = 0.5 * LIGHTNING_RANGE;
		attack_range = 0.4 * LIGHTNING_RANGE;
	}
	else if (bs->cur_ps.weapon == WP_MACHINEGUN) {
		attack_dist = 600;
		attack_range = 500;
	}
	else if (bs->cur_ps.weapon == WP_RAILGUN) {
		attack_dist = 1000;
		attack_range = 800;
	}
	else if (bs->cur_ps.weapon == WP_SHOTGUN) {
		attack_dist = 250;
		attack_range = 150;
	}
#endif
	else {
		attack_dist = IDEAL_ATTACKDIST;
		attack_range = 40;
	}
#if 1	// JUHOX: if the enemy carries a flag, go closer
	if (EntityCarriesFlag(&entinfo)) {
		float attack_min, attack_max;

		attack_min = attack_dist - attack_range;
		attack_max = attack_dist + attack_range;
		if (attack_max > 500 && attack_range > 100) {
			if (attack_min > 300) {
				attack_max = attack_min + 200;
			}
			else {
				attack_max = 500;
			}
			attack_dist = (attack_min + attack_max) / 2;
			attack_range = (attack_max - attack_min) / 2;
		}
	}
#endif
#if 1	// JUHOX: if the enemy uses the bfg, go even closer
	if (entinfo.weapon == WP_BFG && attack_skill > 0.5) {
		attack_dist = 120;
		attack_range = 70;
	}
#endif
#if 1	// JUHOX: if the enemy just fired the bfg, go very close
	if (
		(entinfo.powerups & (1 << PW_BFG_RELOADING)) &&
		!bs->cur_ps.powerups[PW_BFG_RELOADING] &&
		attack_skill > 0.4
	) {
		attack_dist = 50;
		attack_range = 50;
	}
#endif
#if 1	// JUHOX: if the enemy uses lightning gun, stay away
	if (
		entinfo.weapon == WP_LIGHTNING &&
		bs->cur_ps.weapon != WP_GAUNTLET &&
		attack_skill > 0.3
	) {
		attack_dist += LIGHTNING_RANGE + 200;
	}
#endif
	speed = bs->forceWalk? 200 : 400;	// JUHOX
	//if the bot is stupid
#if 0	// JUHOX: different strafe behavior with melee weapon
	if (attack_skill <= 0.4) {
#else
	if
	(
		(attack_dist > 50 && attack_skill <= 0.4) ||
		(
			attack_dist <= 50 && attack_skill > 0.4 &&
			/*dist < 400 &&*/ entinfo.origin[2] - bs->origin[2] < 50
		)
	)
	{
#endif
		//just walk to or away from the enemy
		if (dist > attack_dist + attack_range) {
			if (trap_BotMoveInDirection(bs->ms, forward, /*400*/speed, movetype)) return moveresult;	// JUHOX
		}
		if (dist < attack_dist - attack_range) {
			if (trap_BotMoveInDirection(bs->ms, backward, /*400*/speed, movetype)) return moveresult;	// JUHOX
		}
#if 0	// JUHOX: movement failed or distance is ok. if bot is skilled enough, try strafing.
		return moveresult;
#else
		if (attack_skill <= 0.4) return moveresult;
		if (attack_dist <= 0) {
			bs->attackchase_time = FloatTime() + 10;
			return moveresult;
		}
#endif
	}
#if 1	// JUHOX: check if we should move at all
	if (
		level.clients[bs->client].lasthurt_time < level.time - 3000 &&
		dist >= attack_dist-attack_range &&
		dist <= attack_dist+attack_range
	) {
		vec3_t angles;

		vectoangles(backward, angles);
		if (
			!InFieldOfVision(entinfo.angles, 90, angles) ||
			!IsPlayerFighting(bs->enemy)
		) {
			if (bs->couldNotSeeEnemyWhileDucked_time < FloatTime() - 3) {
				trap_EA_Crouch(bs->client);
			}
			return moveresult;
		}
	}
#endif
#if 0	// JUHOX: new attack strafe code
	//increase the strafe time
	bs->attackstrafe_time += bs->thinktime;
	//get the strafe change time
	strafechange_time = 0.4 + (1 - attack_skill) * 0.2;
	if (attack_skill > 0.7) strafechange_time += crandom() * 0.2;
	//if the strafe direction should be changed
	if (bs->attackstrafe_time > strafechange_time) {
		//some magic number :)
		if (random() > 0.935) {
			//flip the strafe direction
			bs->flags ^= BFL_STRAFERIGHT;
			bs->attackstrafe_time = 0;
		}
	}
#else
	if (bs->attackstrafe_time < FloatTime()) {
		if (bs->attackstrafe_time > 0) {
			bs->flags ^= BFL_STRAFERIGHT;
		}
		bs->attackstrafe_time = FloatTime() + 1.0 + (1.5 - attack_skill) * (1.0 + random());
	}
#endif
	//
	for (i = 0; i < 2; i++) {
		hordir[0] = forward[0];
		hordir[1] = forward[1];
		hordir[2] = 0;
		VectorNormalize(hordir);
		//get the sideward vector
		CrossProduct(hordir, up, sideward);
		//reverse the vector depending on the strafe direction
		if (bs->flags & BFL_STRAFERIGHT) VectorNegate(sideward, sideward);
		//randomly go back a little
		if (random() > 0.9) {
			VectorAdd(sideward, backward, sideward);
		}
		else {
			//walk forward or backward to get at the ideal attack distance
			if (dist > attack_dist + attack_range) {
				VectorAdd(sideward, forward, sideward);
			}
			else if (dist < attack_dist - attack_range) {
				VectorAdd(sideward, backward, sideward);
			}
		}
		//perform the movement
		if (trap_BotMoveInDirection(bs->ms, sideward, /*400*/speed, movetype))	// JUHOX
			return moveresult;
		//movement failed, flip the strafe direction
		bs->flags ^= BFL_STRAFERIGHT;
		bs->attackstrafe_time = 0;
	}
	//bot couldn't do any usefull movement
//	bs->attackchase_time = AAS_Time() + 6;
	return moveresult;
}

/*
==================
BotSameTeam
==================
*/
int BotSameTeam(bot_state_t *bs, int entnum) {
	// JUHOX: use OnSameTeam() for BotSameTeam
#if 0
	char info1[1024], info2[1024];

	if (bs->client < 0 || bs->client >= MAX_CLIENTS) {
		//BotAI_Print(PRT_ERROR, "BotSameTeam: client out of range\n");
		return qfalse;
	}
	if (entnum < 0 || entnum >= MAX_CLIENTS) {
		//BotAI_Print(PRT_ERROR, "BotSameTeam: client out of range\n");
		return qfalse;
	}
	if ( gametype >= GT_TEAM ) {
		// JUHOX: faster team check
#if 0
		trap_GetConfigstring(CS_PLAYERS+bs->client, info1, sizeof(info1));
		trap_GetConfigstring(CS_PLAYERS+entnum, info2, sizeof(info2));
		//
		if (atoi(Info_ValueForKey(info1, "t")) == atoi(Info_ValueForKey(info2, "t"))) return qtrue;
#else
		if (!g_entities[entnum].inuse) return qfalse;
		if (!g_entities[entnum].client) return qfalse;
		if (bs->cur_ps.persistant[PERS_TEAM] == g_entities[entnum].client->ps.persistant[PERS_TEAM]) return qtrue;
#endif
	}
	return qfalse;
#else
	if (bs->client < 0 || bs->client >= MAX_CLIENTS) return qfalse;
	if (entnum < 0 || entnum >= MAX_GENTITIES) return qfalse;
	if (!g_entities[entnum].inuse) return qfalse;
	return OnSameTeam(&g_entities[bs->client], &g_entities[entnum]);
#endif
}

/*
==================
InFieldOfVision
==================
*/
qboolean InFieldOfVision(vec3_t viewangles, float fov, vec3_t angles)
{
	int i;
	float diff, angle;

	for (i = 0; i < 2; i++) {
		angle = AngleMod(viewangles[i]);
		angles[i] = AngleMod(angles[i]);
		diff = angles[i] - angle;
		if (angles[i] > angle) {
			if (diff > 180.0) diff -= 360.0;
		}
		else {
			if (diff < -180.0) diff += 360.0;
		}
		if (diff > 0) {
			if (diff > fov * 0.5) return qfalse;
		}
		else {
			if (diff < -fov * 0.5) return qfalse;
		}
	}
	return qtrue;
}

/*
==================
JUHOX: EntityIsAudible
==================
*/
/*
int EntityIsAudible(aas_entityinfo_t* entinfo) {
	switch (entinfo->weapon) {
	case WP_LIGHTNING:
	case WP_RAILGUN:
	case WP_BFG:
		return qtrue;
	}
	if (g_entities[entinfo->number].eventTime < level.time - 900) return qfalse;
	switch (g_entities[entinfo->number].s.event & ~EV_EVENT_BITS) {
	case EV_NONE:
	case EV_STEP_4:
	case EV_STEP_8:
	case EV_STEP_12:
	case EV_STEP_16:
		return qfalse;
	}
	return qtrue;
}
*/

/*
==================
BotEntityVisible

returns visibility in the range [0, 1] taking fog and water surfaces into account
==================
*/
// JUHOX: new parameter set for BotEntityVisible()
#if 0
float BotEntityVisible(int viewer, vec3_t eye, vec3_t viewangles, float fov, int ent) {
#else
float BotEntityVisible(playerState_t* ps, float fov, int ent) {
#endif
	int i, contents_mask, passent, hitent, infog, inwater, otherinfog, pc;
	float squaredfogdist, waterfactor, vis, bestvis;
	bsp_trace_t trace;
	aas_entityinfo_t entinfo;
	vec3_t dir, entangles, start, end, middle;

	// JUHOX: some vars to support the old parameters
#if 1
	int viewer;
	vec3_t eye;
	vec3_t viewangles;

	viewer = ps->clientNum;
	VectorCopy(ps->origin, eye);
	eye[2] += ps->viewheight;
	VectorCopy(ps->viewangles, viewangles);
#endif

	if (ent < 0) return 0;	// JUHOX: safety check

	//calculate middle of bounding box
	BotEntityInfo(ent, &entinfo);
	if (ent < MAX_CLIENTS && EntityIsDead(&entinfo)) return 0;	// JUHOX: a dead entity is not visible
	VectorAdd(entinfo.mins, entinfo.maxs, middle);
	VectorScale(middle, 0.5, middle);
	VectorAdd(entinfo.origin, middle, middle);
	//check if entity is within field of vision
	// JUHOX: take invisibility and audibility into account

	if (
		ps->persistant[PERS_ATTACKER] == ent &&
		g_entities[viewer].client &&
		g_entities[viewer].client->lasthurt_mod != MOD_CHARGE &&
		g_entities[viewer].client->lasthurt_time > level.time - 500
	) {
		return 1;
	}

	if (G_IsAttackingGuard(ent)) fov = 360;

	if (fov < 360) {
		if (EntityIsInvisible(viewer, &entinfo) && DistanceSquared(middle, eye) > 100*100) {
			bot_state_t* bs;
			float alertness;

			bs = BotAI_IsBot(viewer);
			if (!bs) return 0;
			alertness = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_ALERTNESS, 0, 1);
			fov *= 0.75 * alertness * alertness;
			fov *= bs->settings.skill / 5.0;
		}

		if (ps->powerups[PW_CHARGE]) {
			float disturbance;

			disturbance = 0.0001 * (ps->powerups[PW_CHARGE] - level.time) + 0.5;
			if (disturbance > 1.0) fov /= disturbance;
		}
	}

	VectorSubtract(middle, eye, dir);
	vectoangles(dir, entangles);
	if (!InFieldOfVision(viewangles, fov, entangles)) return 0;
	if (EntityIsInvisible(viewer, &entinfo) && VectorLength(dir) > 1500) return 0;	// JUHOX
	//
	pc = trap_AAS_PointContents(eye);
	infog = (pc & CONTENTS_FOG);
	inwater = (pc & (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER));
	//
	bestvis = 0;
	for (i = 0; i < 3; i++) {

		contents_mask = CONTENTS_SOLID|CONTENTS_PLAYERCLIP;
		passent = viewer;
		hitent = ent;
		VectorCopy(eye, start);
		VectorCopy(middle, end);
		//if the entity is in water, lava or slime
		if (trap_AAS_PointContents(middle) & (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER)) {
			contents_mask |= (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER);
		}
		//if eye is in water, lava or slime
		if (inwater) {
			if (!(contents_mask & (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER))) {
				passent = ent;
				hitent = viewer;
				VectorCopy(middle, start);
				VectorCopy(eye, end);
			}
			contents_mask ^= (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER);
		}
		//trace from start to end
		BotAI_Trace(&trace, start, NULL, NULL, end, passent, contents_mask);
		//if water was hit
		waterfactor = 1.0;
		if (trace.contents & (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER)) {
			//if the water surface is translucent
			if (1) {
				//trace through the water
				contents_mask &= ~(CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER);
				BotAI_Trace(&trace, trace.endpos, NULL, NULL, end, passent, contents_mask);
				waterfactor = 0.5;
			}
		}
		//if a full trace or the hitent was hit
		if (trace.fraction >= 1 || trace.ent == hitent) {
			//check for fog, assuming there's only one fog brush where
			//either the viewer or the entity is in or both are in
			otherinfog = (trap_AAS_PointContents(middle) & CONTENTS_FOG);
			if (infog && otherinfog) {
				VectorSubtract(trace.endpos, eye, dir);
				squaredfogdist = VectorLengthSquared(dir);
			}
			else if (infog) {
				VectorCopy(trace.endpos, start);
				BotAI_Trace(&trace, start, NULL, NULL, eye, viewer, CONTENTS_FOG);
				VectorSubtract(eye, trace.endpos, dir);
				squaredfogdist = VectorLengthSquared(dir);
			}
			else if (otherinfog) {
				VectorCopy(trace.endpos, end);
				BotAI_Trace(&trace, eye, NULL, NULL, end, viewer, CONTENTS_FOG);
				VectorSubtract(end, trace.endpos, dir);
				squaredfogdist = VectorLengthSquared(dir);
			}
			else {
				//if the entity and the viewer are not in fog assume there's no fog in between
				squaredfogdist = 0;
			}
			//decrease visibility with the view distance through fog
			vis = 1 / ((squaredfogdist * 0.001) < 1 ? 1 : (squaredfogdist * 0.001));
			//if entering water visibility is reduced
			vis *= waterfactor;
			//
			if (vis > bestvis) bestvis = vis;
			//if pretty much no fog
			if (bestvis >= 0.95) return bestvis;
		}
		//check bottom and top of bounding box as well
		if (i == 0) middle[2] += entinfo.mins[2];
		else if (i == 1) middle[2] += entinfo.maxs[2] - entinfo.mins[2];
	}
	return bestvis;
}

/*
==================
JUHOX: BotEntityIndirectlyVisible
==================
*/
static qboolean BotEntityIndirectlyVisible(bot_state_t* bs, int ent) {
	static char entityVisStatus[MAX_CLIENTS][MAX_GENTITIES];
	static int entityVisStatusNextCheck[MAX_CLIENTS][MAX_GENTITIES];
	int i;
	qboolean checkStatus;

	if (ent < 0 || ent >= ENTITYNUM_MAX_NORMAL) return qfalse;

	BotDetermineVisibleTeammates(bs);

	checkStatus = qfalse;
	for (i = 0; i < bs->numvisteammates; i++) {
		int teammate;

		teammate = bs->visteammates[i];
		if (teammate < 0 || teammate >= MAX_CLIENTS) continue;	// should not happen
		if (entityVisStatusNextCheck[teammate][ent] <= level.time) {
			checkStatus = qtrue;
			continue;
		}
		if (entityVisStatus[teammate][ent]) return qtrue;
	}
	if (!checkStatus) return qfalse;

	for (i = 0; i < bs->numvisteammates; i++) {
		int teammate;
		gentity_t* tent;
		qboolean vis;
		/*
		gclient_t* client;
		gclient_t* enemy;
		*/

		teammate = bs->visteammates[i];
		if (teammate < 0 || teammate >= MAX_CLIENTS) continue;
		if (entityVisStatusNextCheck[teammate][ent] > level.time) continue;

		tent = &g_entities[teammate];
		if (!tent->inuse) continue;
		if (!tent->client) continue;
		if (tent->health <= 0) continue;

		vis = (BotEntityVisible(&tent->client->ps, 90, ent) > 0);

		entityVisStatus[teammate][ent] = vis;
		entityVisStatusNextCheck[teammate][ent] = level.time + 1000 + rand() % 2000;
		if (vis) return qtrue;

	}
	return qfalse;
}

/*
==================
BotFindEnemy
==================
*/
int BotFindEnemy(bot_state_t *bs, int curenemy) {
	int i, healthdecrease;
	float f, alertness, easyfragger, vis;
	float squaredist, cursquaredist;
	aas_entityinfo_t entinfo, curenemyinfo;
	vec3_t dir/*, angles*/;	// JUHOX: angles no longer needed
	qboolean foundEnemy;	// JUHOX
	int m;	// JUHOX
	static int clientBag[MAX_GENTITIES];	// JUHOX
	int danger;	// JUHOX

	alertness = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_ALERTNESS, 0, 1);
	easyfragger = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_EASY_FRAGGER, 0, 1);
	//check if the health decreased
	healthdecrease = g_entities[bs->entitynum].client->lasthurt_time > level.time - 1000;
	//remember the current health value
	bs->lasthealth = bs->inventory[INVENTORY_HEALTH];
	//
	if (curenemy >= 0) {
		BotEntityInfo(curenemy, &curenemyinfo);

		if (
			EntityCarriesFlag(&curenemyinfo) &&
			!bs->cur_ps.powerups[PW_REDFLAG] &&
			!bs->cur_ps.powerups[PW_BLUEFLAG]
		) {
			return qfalse;
		}

        // JUHOX: healthy bots don't accept new enemies while already fighting
		if (
			bs->cur_ps.weaponstate != WEAPON_READY &&
			BotPlayerDanger(&bs->cur_ps) <= 25
		) return qfalse;

		VectorSubtract(curenemyinfo.origin, bs->origin, dir);
		cursquaredist = VectorLengthSquared(dir);
	}
	else {
		cursquaredist = 0;
	}
	//
	foundEnemy = qfalse;	// JUHOX
	danger = BotPlayerDanger(&bs->cur_ps);	// JUHOX

	m = level.maxclients;

	if (
		g_gametype.integer == GT_STU ||
		g_monsterLauncher.integer
	) {
		m = level.num_entities;
	}

	for (i = 0; i < m; i++) {
		clientBag[i] = i;
	}
	while (m > 0) {
		{
			int j;

			j = rand() % m;
			i = clientBag[j];
			clientBag[j] = clientBag[--m];
		}

		if (!G_GetEntityPlayerState(&g_entities[i])) continue;

		if (i == bs->client) continue;
		//if it's the current enemy
		if (i == curenemy) continue;
        // JUHOX: erlier test for same team
		if (BotSameTeam(bs, i)) continue;

		//
		BotEntityInfo(i, &entinfo);
		//
		if (!entinfo.valid) continue;
		//if the enemy isn't dead and the enemy isn't the bot self
		if (EntityIsDead(&entinfo) || entinfo.number == bs->entitynum) continue;
		//if the enemy is invisible and not shooting

		if (bs->enemy >= 0 && EntityIsInvisible(VIEWER_OTHERTEAM, &entinfo)) continue;

		//if not an easy fragger don't shoot at chatting players
		if (easyfragger < 0.5 && EntityIsChatting(&entinfo)) continue;
		//
		if (lastteleport_time > FloatTime() - 3) {
			VectorSubtract(entinfo.origin, lastteleport_origin, dir);
			if (VectorLengthSquared(dir) < Square(70)) continue;
		}
		//calculate the distance towards the enemy
		VectorSubtract(entinfo.origin, bs->origin, dir);
		squaredist = VectorLengthSquared(dir);
		//if this entity is not carrying a flag
		if (!EntityCarriesFlag(&entinfo))
		{
        // JUHOX: in STU prefer guards
			if (
				g_gametype.integer >= GT_STU &&
				G_IsAttackingGuard(curenemy) &&
				!G_IsAttackingGuard(i)
			) {
				continue;
			}

            // JUHOX: if not too much endangered prefer targets near the goal
			if (
				curenemy >= 0 &&
				danger < 40 &&
				bs->ltgtype != 0 &&
				1.5 * DistanceSquared(entinfo.origin, bs->teamgoal.origin) >
					DistanceSquared(curenemyinfo.origin, bs->teamgoal.origin)
			) {
				continue;
			}

			//if this enemy is further away than the current one
			if (
				curenemy >= 0 && 1.5 * squaredist > cursquaredist &&
				(squaredist > Square(300) || squaredist > cursquaredist) &&
				!bs->lastEnemyAreaPredicted &&
				(!(curenemyinfo.powerups & (1 << PW_SHIELD)) || (entinfo.powerups & (1 << PW_SHIELD)))
			) {
				continue;
			}
		} //end if
		//if the bot has no
		if (squaredist > Square(900.0 + alertness * 4000.0)) continue;
		//if on the same team

	// JUHOX: if retreating ignore cloaked enemies (they are not shooting)
		if (
			(entinfo.powerups & (1 << PW_INVIS)) &&
			!EntityCarriesFlag(&entinfo) &&
			BotWantsToRetreat(bs)
		) {
			continue;
		}

		if (!BotWantsToFight(bs, i, qfalse)) continue;	// JUHOX

		f = 90;
		if (bs->blockingEnemy == i) f = 360;

		//check if the enemy is visible
		vis = BotEntityVisible(&bs->cur_ps/*bs->entitynum, bs->eye, bs->viewangles*/, f, i);	// JUHOX

		if (vis <= 0) {
			int enemyArea;

			if (bs->enemy >= 0) continue;
			if (curenemy >= 0) continue;
			if ((entinfo.powerups & ((1 << PW_INVIS) | (1 << PW_BATTLESUIT))) == (1 << PW_INVIS)) continue;
			if (!BotWantsToFight(bs, i, qtrue)) continue;
			enemyArea = BotPointAreaNum(entinfo.origin);
			if (enemyArea <= 0) continue;
			if (!trap_AAS_AreaReachability(enemyArea)) continue;
			if (!BotEntityIndirectlyVisible(bs, i)) continue;
			if (trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, enemyArea, bs->tfl) <= 0) continue;
		}

		//found an enemy

		foundEnemy = qtrue;
		curenemy = entinfo.number;
		cursquaredist = squaredist;
		bs->lastEnemyAreaPredicted = (vis <= 0);
		if (
			EntityCarriesFlag(&entinfo) &&
			!bs->cur_ps.powerups[PW_REDFLAG] &&
			!bs->cur_ps.powerups[PW_BLUEFLAG]
		) break;
		curenemyinfo = entinfo;

	}

	if (foundEnemy) {
		if (bs->enemy < 0) bs->enemysight_time = FloatTime();
		bs->viewnotperfect_time = FloatTime();
		bs->enemysuicide = qfalse;
		bs->enemydeath_time = 0;

		if (
			g_gametype.integer >= GT_TEAM &&
			!bs->lastEnemyAreaPredicted &&
			bs->enemy < 0 &&
			bs->enemyvisible_time < FloatTime() - 3 &&
			!IsPlayerFighting(bs->client)
		) {
			trap_EA_SayTeam(bs->client, "Contact!\n");
		}
		bs->enemy = curenemy;
		bs->enemyvisible_time = FloatTime();
		VectorCopy(entinfo.origin, bs->lastenemyorigin);
		bs->lastenemyareanum = BotPointAreaNum(entinfo.origin);
	}
	return foundEnemy;

}

/*
==================
BotTeamFlagCarrierVisible
==================
*/
int BotTeamFlagCarrierVisible(bot_state_t *bs) {
	int i;
	float vis;
	aas_entityinfo_t entinfo;

	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
		if (i == bs->client)
			continue;
		//
		BotEntityInfo(i, &entinfo);
		//if this player is active
		if (!entinfo.valid)
			continue;
		//if this player is carrying a flag
		if (!EntityCarriesFlag(&entinfo))
			continue;
		//if the flag carrier is not on the same team
		if (!BotSameTeam(bs, i))
			continue;
		//if the flag carrier is not visible
		vis = BotEntityVisible(&bs->cur_ps/*bs->entitynum, bs->eye, bs->viewangles*/, 360, i);	// JUHOX
		if (vis <= 0)
			continue;
		//
		return i;
	}
	return -1;
}

/*
==================
BotTeamFlagCarrier
==================
*/
int BotTeamFlagCarrier(bot_state_t *bs) {
	int i;
	aas_entityinfo_t entinfo;

	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
		if (i == bs->client)
			continue;
		//
		BotEntityInfo(i, &entinfo);
		//if this player is active
		if (!entinfo.valid)
			continue;
		//if this player is carrying a flag
		if (!EntityCarriesFlag(&entinfo))
			continue;
		//if the flag carrier is not on the same team
		if (!BotSameTeam(bs, i))
			continue;
		//
		return i;
	}
	return -1;
}

/*
==================
BotEnemyFlagCarrierVisible
==================
*/
int BotEnemyFlagCarrierVisible(bot_state_t *bs) {
	int i;
	float vis;
	aas_entityinfo_t entinfo;

	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
		if (i == bs->client)
			continue;
		//
		BotEntityInfo(i, &entinfo);
		//if this player is active
		if (!entinfo.valid)
			continue;
		//if this player is carrying a flag
		if (!EntityCarriesFlag(&entinfo))
			continue;
		//if the flag carrier is on the same team
		if (BotSameTeam(bs, i))
			continue;
		//if the flag carrier is not visible
		vis = BotEntityVisible(&bs->cur_ps/*bs->entitynum, bs->eye, bs->viewangles*/, 360, i);	// JUHOX
		if (vis <= 0)
			continue;
		//
		return i;
	}
	return -1;
}

/*
==================
BotVisibleTeamMatesAndEnemies
==================
*/
// JUHOX: BotVisibleTeamMatesAndEnemies() not used
#if 0
void BotVisibleTeamMatesAndEnemies(bot_state_t *bs, int *teammates, int *enemies, float range) {
	int i;
	float vis;
	aas_entityinfo_t entinfo;
	vec3_t dir;

	if (teammates)
		*teammates = 0;
	if (enemies)
		*enemies = 0;
	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
		if (i == bs->client)
			continue;
		//
		BotEntityInfo(i, &entinfo);
		//if this player is active
		if (!entinfo.valid)
			continue;
		//if this player is carrying a flag
		if (!EntityCarriesFlag(&entinfo))
			continue;
		//if not within range
		VectorSubtract(entinfo.origin, bs->origin, dir);
		if (VectorLengthSquared(dir) > Square(range))
			continue;
		//if the flag carrier is not visible
		vis = BotEntityVisible(&bs->cur_ps/*bs->entitynum, bs->eye, bs->viewangles*/, 360, i);	// JUHOX
		if (vis <= 0)
			continue;
		//if the flag carrier is on the same team
		if (BotSameTeam(bs, i)) {
			if (teammates)
				(*teammates)++;
		}
		else {
			if (enemies)
				(*enemies)++;
		}
	}
}
#endif

/*
==================
JUHOX: SearchGrappleTarget
==================
*/
static qboolean SearchGrappleTarget(int bot, vec3_t start, const vec3_t dest, const vec3_t dir, const vec3_t back, vec3_t target) {
	vec3_t end, tmp;
	bsp_trace_t trace;

	VectorMA(dest, 60, dir, end);
	BotAI_Trace(&trace, start, NULL, NULL, end, bot, MASK_SHOT);
	if (trace.fraction >= 1) return qfalse;	// no wall hit
	if (DistanceSquared(target, trace.endpos) > 10000) return qfalse;
	VectorMA(trace.endpos, 16, back, trace.endpos);
	VectorCopy(trace.endpos, end);
	VectorCopy(trace.endpos, tmp);
	end[2] -= 100;
	BotAI_Trace(&trace, trace.endpos, NULL, NULL, end, bot, MASK_PLAYERSOLID|MASK_WATER);	// is there ground to stand on?
	if (trace.fraction >= 1) return qfalse;
	if ((trace.contents & MASK_PLAYERSOLID) == 0) return qfalse;	// the bot doesn't want to stand there
	VectorCopy(tmp, target);
	return qtrue;
}

/*
==================
JUHOX: LeftOrRightGrappleTarget
==================
*/
static qboolean LeftOrRightGrappleTarget(int bot, vec3_t start, vec3_t dest) {
	vec3_t forward, right, end;

	VectorSubtract(dest, start, forward);
	VectorNormalize(forward);
	CrossProduct(forward, axisDefault[2], right);
	VectorMA(dest, 50, forward, end);
	VectorNegate(forward, forward);
	if (SearchGrappleTarget(bot, start, end, right, forward, dest)) return qtrue;
	VectorNegate(right, right);
	if (SearchGrappleTarget(bot, start, end, right, forward, dest)) return qtrue;
	return qfalse;
}

/*
==================
JUHOX: CheckWallTarget
==================
*/
static qboolean CheckWallTarget(bot_state_t* bs, int enemy, vec3_t start, const vec3_t dest, const vec3_t dir, float maxdist, vec3_t target) {
	vec3_t end, tmp;
	bsp_trace_t trace;

	VectorMA(dest, maxdist, dir, end);
	BotAI_Trace(&trace, start, NULL, NULL, end, bs->client, MASK_SHOT);
	if (trace.fraction >= 1) return qfalse;	// nothing hit
	if (Distance(target, trace.endpos) > 1.5 * maxdist) return qfalse;
	VectorCopy(trace.endpos, tmp);
	BotAI_Trace(&trace, tmp, NULL, NULL, target, enemy, MASK_SHOT);
	if (trace.fraction < 1) return qfalse;	// an obstacle between wall target and enemy
	VectorCopy(tmp, target);
	return qtrue;
}

/*
==================
JUHOX: SearchWallTarget
==================
*/
static qboolean SearchWallTarget(bot_state_t* bs, int enemy, vec3_t start, vec3_t dest, float maxdist) {
	vec3_t forward, right, up, end;

	VectorSubtract(dest, start, forward);
	VectorNormalize(forward);
	CrossProduct(forward, axisDefault[2], right);	// this may actually be a 'left' vector, but that doesn't matter
	CrossProduct(forward, right, up);				// this may actually be a 'down' vector, but ... you know
	VectorMA(dest, maxdist, forward, end);

	// make the wall target unpredictable for the enemy
	if (bs->walltargetorder_time < FloatTime() - 1 - 2 * random()) {
		bs->walltargetorder_time = FloatTime();
		bs->walltargetorder = rand();
	}
	if (bs->walltargetorder & 1) VectorNegate(up, up);
	if (bs->walltargetorder & 2) VectorNegate(right, right);
	if (bs->walltargetorder & 4) {
		vec3_t tmp;

		VectorCopy(up, tmp);
		VectorCopy(right, up);
		VectorCopy(tmp, right);
	}

	if (CheckWallTarget(bs, enemy, start, end, up, maxdist, dest)) return qtrue;
	VectorNegate(up, up);
	if (CheckWallTarget(bs, enemy, start, end, up, maxdist, dest)) return qtrue;

	if (CheckWallTarget(bs, enemy, start, end, right, maxdist, dest)) return qtrue;
	VectorNegate(right, right);
	if (CheckWallTarget(bs, enemy, start, end, right, maxdist, dest)) return qtrue;
	return qfalse;
}

/*
==================
BotAimAtEnemy
==================
*/
void BotAimAtEnemy(bot_state_t *bs) {
	int i, enemyvisible;
	float dist/*, f*/, aim_skill, aim_accuracy, speed/*, reactiontime*/;	// JUHOX: f and reactiontime no longer needed
	vec3_t dir, bestorigin, end, start, groundtarget, cmdmove, enemyvelocity;
	vec3_t mins = {-4,-4,-4}, maxs = {4, 4, 4};
	weaponinfo_t wi;
	aas_entityinfo_t entinfo;
	bot_goal_t goal;
	bsp_trace_t trace;
	vec3_t target;

	//if the bot has no enemy
	if (bs->enemy < 0) {
		return;
	}
	if (bs->weaponnum <= WP_NONE) return;	// JUHOX
	//get the enemy entity information
	BotEntityInfo(bs->enemy, &entinfo);
	//if this is not a player (should be an obelisk)

	if (bs->enemy >= MAX_CLIENTS && g_gametype.integer != GT_STU) {

		//if the obelisk is visible
		VectorCopy(entinfo.origin, target);

		//aim at the obelisk
		VectorSubtract(target, bs->eye, dir);
		vectoangles(dir, bs->ideal_viewangles);
		//set the aim target before trying to attack
		VectorCopy(target, bs->aimtarget);
		return;
	}
	//
	//BotAI_Print(PRT_MESSAGE, "client %d: aiming at client %d\n", bs->entitynum, bs->enemy);
	//
	aim_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_SKILL, 0, 1);
	aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY, 0, 1);
	//

	//get the weapon information

	i = bs->weaponnum;

	if (i == WP_MONSTER_LAUNCHER) i = WP_GRENADE_LAUNCHER;

	trap_BotGetWeaponInfo(bs->ws, i, &wi);

	//get the weapon specific aim accuracy and or aim skill
	if (wi.number == WP_MACHINEGUN) {
		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_MACHINEGUN, 0, 1);
	}
	else if (wi.number == WP_SHOTGUN) {
		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_SHOTGUN, 0, 1);
	}
	else if (wi.number == WP_GRENADE_LAUNCHER) {
		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_GRENADELAUNCHER, 0, 1);
		aim_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_SKILL_GRENADELAUNCHER, 0, 1);
	}
	else if (wi.number == WP_ROCKET_LAUNCHER) {
		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_ROCKETLAUNCHER, 0, 1);
		aim_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_SKILL_ROCKETLAUNCHER, 0, 1);
	}
	else if (wi.number == WP_LIGHTNING) {
		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_LIGHTNING, 0, 1);
	}
	else if (wi.number == WP_RAILGUN) {
		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_RAILGUN, 0, 1);
	}
	else if (wi.number == WP_PLASMAGUN) {
		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_PLASMAGUN, 0, 1);
		aim_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_SKILL_PLASMAGUN, 0, 1);
	}
	else if (wi.number == WP_BFG) {
		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_BFG10K, 0, 1);
		aim_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_SKILL_BFG10K, 0, 1);
		wi.speed = 1000;	// JUHOX
	}
#if 0	// -JUHOX: grapple weapon info
	if (bs->weaponnum == WP_GRAPPLING_HOOK) {
		wi.number = WP_GRAPPLING_HOOK;
		wi.speed = 1500;
		wi.hspread = 0;
		wi.vspread = 0;
		wi.proj.damagetype = 0;
	}
#endif
	//
	if (aim_accuracy <= 0) aim_accuracy = 0.0001f;
	//get the enemy entity information
	BotEntityInfo(bs->enemy, &entinfo);
	//if the enemy is invisible then shoot crappy most of the time
	if (EntityIsInvisible(VIEWER_OTHERTEAM, &entinfo)) {	// JUHOX: added 'VIEWER_OTHERTEAM'
#if 0	// JUHOX: worse accuracy for invisible enemies
		if (random() > 0.1) aim_accuracy *= 0.4f;
#else
		aim_accuracy *= 0.3f;
#endif
	}
	//
	VectorSubtract(entinfo.origin, entinfo.lastvisorigin, enemyvelocity);
	VectorScale(enemyvelocity, 1 / entinfo.update_time, enemyvelocity);
	//enemy origin and velocity is remembered every 0.5 seconds
	if (bs->enemyposition_time < FloatTime()) {
		//
		bs->enemyposition_time = FloatTime() + 0.5;
		VectorCopy(enemyvelocity, bs->enemyvelocity);
		VectorCopy(entinfo.origin, bs->enemyorigin);
	}
	//if not extremely skilled
	if (aim_skill < 0.9) {
		VectorSubtract(entinfo.origin, bs->enemyorigin, dir);
		//if the enemy moved a bit
		if (VectorLengthSquared(dir) > Square(48)) {
			//if the enemy changed direction
			if (DotProduct(bs->enemyvelocity, enemyvelocity) < 0) {
				//aim accuracy should be worse now
				aim_accuracy *= 0.7f;
			}
		}
#if 0	// -JUHOX: accuracy should also depend directly on enemy velocity
		dist = VectorNormalize(dir);
		if (dist < 1) dist = 1;
		CrossProduct(dir, enemyvelocity, end);	// 'end' used temporary
		aim_accuracy -= VectorLength(end) / dist;
		if (aim_accuracy < 0) aim_accuracy = 0;
#endif
	}
	//check visibility of enemy
	enemyvisible = BotEntityVisible(&bs->cur_ps/*bs->entitynum, bs->eye, bs->viewangles*/, 360, bs->enemy);	// JUHOX
	//if the enemy is visible
	if (enemyvisible) {
		//
		VectorCopy(entinfo.origin, bestorigin);
		bestorigin[2] += 8;
		//get the start point shooting from
		//NOTE: the x and y projectile start offsets are ignored
		VectorCopy(bs->origin, start);
		start[2] += bs->cur_ps.viewheight;
		start[2] += wi.offset[2];
		//
		BotAI_Trace(&trace, start, mins, maxs, bestorigin, bs->entitynum, MASK_SHOT);
		//if the enemy is NOT hit
		if (trace.fraction <= 1 && trace.ent != entinfo.number) {
			bestorigin[2] += 16;
		}
		//if it is not an instant hit weapon the bot might want to predict the enemy
		if (wi.speed) {
			//
			VectorSubtract(bestorigin, bs->origin, dir);
			dist = VectorLength(dir);
			VectorSubtract(entinfo.origin, bs->enemyorigin, dir);
			//if the enemy is NOT pretty far away and strafing just small steps left and right
			if (!(dist > 100 && VectorLengthSquared(dir) < Square(32))) {
				//if skilled anough do exact prediction
				if (aim_skill > 0.8 &&
						//if the weapon is ready to fire
						bs->cur_ps.weaponstate == WEAPON_READY) {
					aas_clientmove_t move;
					vec3_t origin;

					VectorSubtract(entinfo.origin, bs->origin, dir);
					//distance towards the enemy
					dist = VectorLength(dir);
					//direction the enemy is moving in
					VectorSubtract(entinfo.origin, entinfo.lastvisorigin, dir);
					//
					VectorScale(dir, 1 / entinfo.update_time, dir);
					//
					VectorCopy(entinfo.origin, origin);
					origin[2] += 1;
					//
					VectorClear(cmdmove);
					//AAS_ClearShownDebugLines();
					trap_AAS_PredictClientMovement(&move, bs->enemy, origin,
														PRESENCE_CROUCH, qfalse,
														dir, cmdmove, 0,
														dist * 10 / wi.speed, 0.1f, 0, 0, qfalse);
					VectorCopy(move.endpos, bestorigin);
					//BotAI_Print(PRT_MESSAGE, "%1.1f predicted speed = %f, frames = %f\n", FloatTime(), VectorLength(dir), dist * 10 / wi.speed);
				}
				//if not that skilled do linear prediction
				else if (aim_skill > 0.4) {
					VectorSubtract(entinfo.origin, bs->origin, dir);
					//distance towards the enemy
					dist = VectorLength(dir);
					//direction the enemy is moving in
					VectorSubtract(entinfo.origin, entinfo.lastvisorigin, dir);
					dir[2] = 0;
					//
					speed = VectorNormalize(dir) / entinfo.update_time;
					//botimport.Print(PRT_MESSAGE, "speed = %f, wi->speed = %f\n", speed, wi->speed);
					//best spot to aim at
					VectorMA(entinfo.origin, (dist / wi.speed) * speed, dir, bestorigin);
				}
			}
		}
		//if the projectile does radial damage
#if 0	// JUHOX: new wall aiming
		if (aim_skill > 0.6 && wi.proj.damagetype & DAMAGETYPE_RADIAL) {
			//if the enemy isn't standing significantly higher than the bot
			if (entinfo.origin[2] < bs->origin[2] + 16) {
				//try to aim at the ground in front of the enemy
				VectorCopy(entinfo.origin, end);
				end[2] -= 64;
				BotAI_Trace(&trace, entinfo.origin, NULL, NULL, end, entinfo.number, MASK_SHOT);
				//
				VectorCopy(bestorigin, groundtarget);
				if (trace.startsolid) groundtarget[2] = entinfo.origin[2] - 16;
				else groundtarget[2] = trace.endpos[2] - 8;
				//trace a line from projectile start to ground target
				BotAI_Trace(&trace, start, NULL, NULL, groundtarget, bs->entitynum, MASK_SHOT);
				//if hitpoint is not vertically too far from the ground target
				if (fabs(trace.endpos[2] - groundtarget[2]) < 50) {
					VectorSubtract(trace.endpos, groundtarget, dir);
					//if the hitpoint is near anough the ground target
					if (VectorLengthSquared(dir) < Square(60)) {
						VectorSubtract(trace.endpos, start, dir);
						//if the hitpoint is far anough from the bot
						if (VectorLengthSquared(dir) > Square(100)) {
							//check if the bot is visible from the ground target
							trace.endpos[2] += 1;
							BotAI_Trace(&trace, trace.endpos, NULL, NULL, entinfo.origin, entinfo.number, MASK_SHOT);
							if (trace.fraction >= 1) {
								//botimport.Print(PRT_MESSAGE, "%1.1f aiming at ground\n", AAS_Time());
								VectorCopy(groundtarget, bestorigin);
							}
						}
					}
				}
			}
		}
#else
		if (aim_skill > 0.6) {
			switch (bs->weaponnum) {
			case WP_GRENADE_LAUNCHER:
			case WP_ROCKET_LAUNCHER:
			case WP_BFG:
			// JUHOX FIXME: try to handle grapple here too
				if (SearchWallTarget(bs, entinfo.number, bs->origin, bestorigin, 100)) {
					bs->walltarget_time = FloatTime();
				}
				break;
			default:
				{
					vec3_t dummy;

					VectorCopy(bestorigin, dummy);
					if (SearchWallTarget(bs, entinfo.number, bs->origin, dummy, 100)) {
						bs->walltarget_time = FloatTime();
					}
				}
				break;
			}
		}
		else {
			bs->walltarget_time = FloatTime();
		}
#endif
#if 1	// JUHOX: grapple aiming
		if (bs->weaponnum == WP_GRAPPLING_HOOK && aim_skill > 0.3) {
			qboolean foundGrappleTarget = qfalse; // JUHOX

			if (entinfo.origin[2] > bs->origin[2]) {	// if the enemy is higher than the bot
				// try to aim at the ceiling above the predicted enemy
				VectorCopy(bestorigin, end);
				end[2] += 200;
				BotAI_Trace(&trace, bestorigin, NULL, NULL, end, entinfo.number, MASK_SHOT);
				if (trace.fraction < 1) {
					VectorCopy(trace.endpos, groundtarget);	// the 'groundtarget' is actually the ceiling target
					// test if the ceiling is visible from the bot
					BotAI_Trace(&trace, start, NULL, NULL, groundtarget, bs->entitynum, MASK_SHOT);
					VectorSubtract(trace.endpos, groundtarget, dir);
					if (VectorLength(dir) < 30) {
						VectorCopy(groundtarget, bestorigin);
						foundGrappleTarget = qtrue;
					}
				}
			}
			if (!foundGrappleTarget) {
				// try to aim at a wall near the enemy
				foundGrappleTarget = LeftOrRightGrappleTarget(bs->entitynum, bs->origin, bestorigin);
			}
		}
#endif
#if 0	// JUHOX: the farther away the enemy the greater the error
		bestorigin[0] += 20 * crandom() * (1 - aim_accuracy);
		bestorigin[1] += 20 * crandom() * (1 - aim_accuracy);
		bestorigin[2] += 10 * crandom() * (1 - aim_accuracy);
#else
		dist = (1 - aim_accuracy) * Distance(bs->origin, bestorigin) / /*15*/30;
		bestorigin[0] += dist * crandom();
		bestorigin[1] += dist * crandom();
		bestorigin[2] += dist * crandom();
#endif
	}
	else {
		if (bs->cur_ps.pm_flags & PMF_DUCKED) bs->couldNotSeeEnemyWhileDucked_time = FloatTime();	// JUHOX
		//
		VectorCopy(bs->lastenemyorigin, bestorigin);
		bestorigin[2] += 8;
		//if the bot is skilled anough
#if 0	// JUHOX: no prediction shots if the enemy area has been predicted
		if (aim_skill > 0.5) {
#else
		if (aim_skill > 0.5 && !bs->lastEnemyAreaPredicted) {
#endif
			//do prediction shots around corners
			if (wi.number == WP_BFG ||
				wi.number == WP_ROCKET_LAUNCHER ||
				wi.number == WP_PLASMAGUN ||	// JUHOX: plasmagun has a significantly greater splash radius now
				wi.number == WP_GRENADE_LAUNCHER) {
				//create the chase goal
				goal.entitynum = bs->client;
				goal.areanum = bs->areanum;
				VectorCopy(bs->eye, goal.origin);
				VectorSet(goal.mins, -8, -8, -8);
				VectorSet(goal.maxs, 8, 8, 8);
				//
				if (trap_BotPredictVisiblePosition(bs->lastenemyorigin, bs->lastenemyareanum, &goal, TFL_DEFAULT, target)) {
					VectorSubtract(target, bs->eye, dir);
					if (VectorLengthSquared(dir) > Square(80)) {
						VectorCopy(target, bestorigin);
						bestorigin[2] -= 20;
					}
				}
				aim_accuracy = 1;
			}
		}
	}
	//
	if (enemyvisible) {
		BotAI_Trace(&trace, bs->eye, NULL, NULL, bestorigin, bs->entitynum, MASK_SHOT);
		VectorCopy(trace.endpos, bs->aimtarget);
	}
	else {
		VectorCopy(bestorigin, bs->aimtarget);
	}
	//get aim direction
	VectorSubtract(bestorigin, bs->eye, dir);
	//
#if 0	// JUHOX: additional error no longer needed for instant-hit weapons
	if (wi.number == WP_MACHINEGUN ||
		wi.number == WP_SHOTGUN ||
		wi.number == WP_LIGHTNING ||
		wi.number == WP_RAILGUN) {
		//distance towards the enemy
		dist = VectorLength(dir);
		if (dist > 150) dist = 150;
		f = 0.6 + dist / 150 * 0.4;
		aim_accuracy *= f;
	}
#endif
#if 0	// JUHOX: no shaking
	//add some random stuff to the aim direction depending on the aim accuracy
	if (aim_accuracy < 0.8) {
		VectorNormalize(dir);
		for (i = 0; i < 3; i++) dir[i] += 0.3 * crandom() * (1 - aim_accuracy);
	}
#endif
	//set the ideal view angles
	vectoangles(dir, bs->ideal_viewangles);
	//take the weapon spread into account for lower skilled bots
#if 0	// JUHOX: ignore spread
	bs->ideal_viewangles[PITCH] += 6 * wi.vspread * crandom() * (1 - aim_accuracy);
	bs->ideal_viewangles[PITCH] = AngleMod(bs->ideal_viewangles[PITCH]);
	bs->ideal_viewangles[YAW] += 6 * wi.hspread * crandom() * (1 - aim_accuracy);
	bs->ideal_viewangles[YAW] = AngleMod(bs->ideal_viewangles[YAW]);
#else
	bs->ideal_viewangles[PITCH] = AngleMod(bs->ideal_viewangles[PITCH]);
	bs->ideal_viewangles[YAW] = AngleMod(bs->ideal_viewangles[YAW]);
#endif
	//if the bots should be really challenging
	if (bot_challenge.integer) {
		//if the bot is really accurate and has the enemy in view for some time
		if (aim_accuracy > 0.9 && bs->enemysight_time < FloatTime() - 1) {
			//set the view angles directly
			if (bs->ideal_viewangles[PITCH] > 180) bs->ideal_viewangles[PITCH] -= 360;
			VectorCopy(bs->ideal_viewangles, bs->viewangles);
			trap_EA_View(bs->client, bs->viewangles);
		}
	}
}

/*
============
JUHOX: MayDamage

Returns qtrue if the inflictor may directly damage the target.
[derived from CanDamage()]
============
*/
static qboolean MayDamage (gentity_t* targ, vec3_t origin) {
	vec3_t	dest;
	trace_t	tr;
	vec3_t	midpoint;

	// use the midpoint of the bounds instead of the origin, because
	// bmodels may have their origin is 0,0,0
	VectorAdd (targ->r.absmin, targ->r.absmax, midpoint);
	VectorScale (midpoint, 0.5, midpoint);

	VectorCopy (midpoint, dest);
	trap_Trace (&tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID);
	if (tr.fraction == 1.0)
		return qtrue;

	return qfalse;
}

/*
============
JUHOX: BotMayRadiusDamageTeamMate
[derived from G_RadiusDamage()]
also returns qtrue if the bot would damage itself
============
*/
static qboolean BotMayRadiusDamageTeamMate(bot_state_t* bs, vec3_t origin, float radius) {
	gentity_t	*ent;
	int			entityList[MAX_GENTITIES];
	int			numListedEntities;
	vec3_t		mins, maxs;
	vec3_t		v;
	int			i, e;
	team_t		team;

	if (g_gametype.integer < GT_TEAM) return qfalse;
	if (!g_friendlyFire.integer) return qfalse;

	if ( radius < 1 ) {
		radius = 1;
	}

	for ( i = 0 ; i < 3 ; i++ ) {
		mins[i] = origin[i] - radius;
		maxs[i] = origin[i] + radius;
	}

	team = g_entities[bs->entitynum].client->sess.sessionTeam;

	numListedEntities = trap_EntitiesInBox(mins, maxs, entityList, MAX_GENTITIES);

	for (e = 0; e < numListedEntities; e++) {
		ent = &g_entities[entityList[e]];

		if (!ent->takedamage) continue;
		if (!ent->client) continue;
		if (ent->client->sess.sessionTeam != team) continue;
		if (ent->client->ps.stats[STAT_HEALTH] <= 0) continue;

		// find the distance from the edge of the bounding box
		for (i = 0; i < 3; i++) {
			if (origin[i] < ent->r.absmin[i]) {
				v[i] = ent->r.absmin[i] - origin[i];
			}
			else if (origin[i] > ent->r.absmax[i]) {
				v[i] = origin[i] - ent->r.absmax[i];
			}
			else {
				v[i] = 0;
			}
		}

		if (VectorLength(v) >= radius) continue;

		if (!MayDamage(ent, origin)) continue;

		return qtrue;
	}

	return qfalse;
}

/*
==================
BotCheckAttack
==================
*/
void BotCheckAttack(bot_state_t *bs) {
	float /*points, */reactiontime, fov/*, firethrottle*/;	// JUHOX: points and firethrottle no longer needed
	int attackentity;
	bsp_trace_t bsptrace;
	//float selfpreservation;
	vec3_t forward, right, start, end, dir, angles;
	weaponinfo_t wi;
	bsp_trace_t trace;
	aas_entityinfo_t entinfo;
	vec3_t mins = {-8, -8, -8}, maxs = {8, 8, 8};
	float prevLineOfFireBlockedTime;	// JUHOX
	float dist;	// JUHOX

	if (bs->weaponnum <= WP_NONE) return;	// JUHOX
	reactiontime = 0.7 * bs->reactiontime;	// JUHOX
	// JUHOX: prepare for reaction-time delay on changes of line-of-fire blocked / not blocked
	prevLineOfFireBlockedTime = bs->lineOfFireBlocked_time;
	bs->lineOfFireBlocked_time = FloatTime();
	if (
		bs->lineOfFireNotBlocked_time > FloatTime() - reactiontime
	) {
		trap_EA_Attack(bs->client);
	}


	attackentity = bs->enemy;
	if (attackentity < 0) return;	// JUHOX
	// JUHOX: don't shoot with a back knocking weapon while flying
	if (
		bs->cur_ps.groundEntityNum == ENTITYNUM_NONE &&
		bs->cur_ps.weapon != WP_GAUNTLET &&
		bs->cur_ps.weapon != WP_LIGHTNING &&
		bs->cur_ps.weapon != WP_PLASMAGUN
	) {
		return;
	}

	//
	BotEntityInfo(attackentity, &entinfo);
	// if not attacking a player
	if (attackentity >= MAX_CLIENTS) { // SLK: remove
	}

	if (entinfo.powerups & (1 << PW_SHIELD)) return;	// JUHOX
	if (EntityIsDead(&entinfo)) return;	// JUHOX


	if (bs->enemysight_time > FloatTime() - reactiontime) {
		bs->viewnotperfect_time = FloatTime();
		return;
	}

	if (bs->teleport_time > FloatTime() - reactiontime) return;

	VectorSubtract(bs->aimtarget, bs->eye, dir);

	if (
		bs->weaponnum == WP_GAUNTLET &&
		BotWantsToRetreat(bs) &&
		VectorLengthSquared(dir) > Square(60)
	) {
		return;
	}

	if (bs->weaponnum == WP_MACHINEGUN && bs->cur_ps.weaponstate >= WEAPON_FIRING) goto Shoot;
	dist = VectorLength(dir);
	if (dist < 100) fov = 120;
	else fov = 20 + 10000 / dist;
	fov += 40 * (1 - trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_SKILL, 0, 1));
	if (g_baseHealth.value > 1) {
		fov += 40 * (1 - bs->cur_ps.stats[STAT_MAX_HEALTH] / g_baseHealth.value);
	}
	if (
		bs->weaponnum == WP_MACHINEGUN ||
		bs->weaponnum == WP_SHOTGUN ||
		bs->weaponnum == WP_GRENADE_LAUNCHER ||
		bs->weaponnum == WP_LIGHTNING
	) {
		// these weapons accept much inprecision
		fov += 90;
	}
	else if (
		bs->weaponnum == WP_ROCKET_LAUNCHER ||
		bs->weaponnum == WP_GAUNTLET
	) {
		// these weapons accept inprecision
		fov += 40;
	}
	else if (
		bs->weaponnum == WP_BFG
	) {
		// this weapon accepts only a bit inprecision (could be dangerous for ourself!)
		fov += 15;
	}
	fov *= 1.1 + 3*reactiontime;
	if (EntityIsInvisible(VIEWER_OTHERTEAM, &entinfo)) fov *= 2;
	vectoangles(dir, angles);
	if (!InFieldOfVision(bs->viewangles, 0.25 * fov, angles)) bs->viewnotperfect_time = FloatTime();
	if (
		bs->weaponnum == WP_RAILGUN &&
		(
			bs->viewnotperfect_time > FloatTime() - 3 * reactiontime ||
			bs->lastEnemyAreaPredicted
		)
	) return;
	if (
		bs->weaponnum == WP_LIGHTNING &&
		(bs->cur_ps.eFlags & EF_FIRING) &&
		bs->cur_ps.stats[STAT_TARGET] >= 0 &&
		bs->cur_ps.stats[STAT_TARGET] < ENTITYNUM_MAX_NORMAL &&
		!BotSameTeam(bs, bs->cur_ps.stats[STAT_TARGET])
	) {
		// do not release lightning gun while it has contact
		goto Shoot;
	}
	if (!InFieldOfVision(bs->viewangles, fov, bs->viewhistory.real_viewangles)) return;
	//if (!InFieldOfVision(bs->viewangles, 90, angles)) return;
	if (dist > 100) {
		BotAI_Trace(&bsptrace, bs->eye, NULL, NULL, bs->aimtarget, bs->client, CONTENTS_SOLID);
		if (bsptrace.fraction < 1) return;
	}
	Shoot:

	//get the weapon info
	{
		int wp;

		wp = bs->weaponnum;

		if (wp == WP_MONSTER_LAUNCHER) wp = WP_GRENADE_LAUNCHER;

		trap_BotGetWeaponInfo(bs->ws, wp, &wi);
	}

	// JUHOX: correct some weapon info
	if (bs->weaponnum == WP_BFG) {
		wi.proj.radius = 400;
		wi.speed = 1000;
	}
	else if (bs->weaponnum == WP_PLASMAGUN) {
		wi.proj.radius = 100;
	}
	else if (bs->weaponnum == WP_GRAPPLING_HOOK) {
		VectorCopy(vec3_origin, wi.offset);
		wi.proj.damagetype = 0;
		wi.flags = 0;
	}

	//get the start point shooting from
	VectorCopy(bs->origin, start);
	start[2] += bs->cur_ps.viewheight;
	AngleVectors(bs->viewangles, forward, right, NULL);
	start[0] += forward[0] * wi.offset[0] + right[0] * wi.offset[1];
	start[1] += forward[1] * wi.offset[0] + right[1] * wi.offset[1];
	start[2] += forward[2] * wi.offset[0] + right[2] * wi.offset[1] + wi.offset[2];
	//end point aiming at
	VectorMA(start, 1000, forward, end);
	//a little back to make sure not inside a very close enemy
	VectorMA(start, -12, forward, start);
	BotAI_Trace(&trace, start, mins, maxs, end, bs->entitynum, MASK_SHOT);
	//if the entity is a client
	if (trace.ent /*>*/>= 0 && trace.ent /*<=*/< MAX_CLIENTS) {	// JUHOX BUGFIX
		if (trace.ent != attackentity) {
			//if a teammate is hit
			if (BotSameTeam(bs, trace.ent))
				return;
		}
	}
#if 0	// JUHOX: enhanced radial damage check
	//if won't hit the enemy or not attacking a player (obelisk)
	if (trace.ent != attackentity || attackentity >= MAX_CLIENTS) {
		//if the projectile does radial damage
		if (wi.proj.damagetype & DAMAGETYPE_RADIAL) {
			if (trace.fraction * 1000 < wi.proj.radius) {
				points = (wi.proj.damage - 0.5 * trace.fraction * 1000) * 0.5;
				if (points > 0) {
					return;
				}
			}
			//FIXME: check if a teammate gets radial damage
		}
	}
#else
	if (wi.proj.damagetype & DAMAGETYPE_RADIAL){
		if (BotMayRadiusDamageTeamMate(bs, trace.endpos, wi.proj.radius)) return;
	}
#endif
#if 1	// JUHOX: handle reaction-time delay on changes of line-of-fire blocked / not blocked
	bs->lineOfFireBlocked_time = prevLineOfFireBlockedTime;
	if (prevLineOfFireBlockedTime > FloatTime() - reactiontime) return;
	bs->lineOfFireNotBlocked_time = FloatTime();
#endif
	//if fire has to be release to activate weapon
	if (wi.flags & WFL_FIRERELEASED) {
		if (bs->flags & BFL_ATTACKED) {
			trap_EA_Attack(bs->client);
		}
	}
	else {
		trap_EA_Attack(bs->client);
	}
	bs->flags ^= BFL_ATTACKED;
}

/*
==================
BotMapScripts
==================
*/
void BotMapScripts(bot_state_t *bs) {
	char info[1024];
	char mapname[128];
	int i, shootbutton;
	float aim_accuracy;
	aas_entityinfo_t entinfo;
	vec3_t dir;

	trap_GetServerinfo(info, sizeof(info));

	strncpy(mapname, Info_ValueForKey( info, "mapname" ), sizeof(mapname)-1);
	mapname[sizeof(mapname)-1] = '\0';

	if (!Q_stricmp(mapname, "q3tourney6")) {
		vec3_t mins = {700, 204, 672}, maxs = {964, 468, 680};
		vec3_t buttonorg = {304, 352, 920};
		//NOTE: NEVER use the func_bobbing in q3tourney6
		bs->tfl &= ~TFL_FUNCBOB;
		//if the bot is below the bounding box
		if (bs->origin[0] > mins[0] && bs->origin[0] < maxs[0]) {
			if (bs->origin[1] > mins[1] && bs->origin[1] < maxs[1]) {
				if (bs->origin[2] < mins[2]) {
					return;
				}
			}
		}
		shootbutton = qfalse;
		//if an enemy is below this bounding box then shoot the button
		for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {

			if (i == bs->client) continue;
			//
			BotEntityInfo(i, &entinfo);
			//
			if (!entinfo.valid) continue;
			//if the enemy isn't dead and the enemy isn't the bot self
			if (EntityIsDead(&entinfo) || entinfo.number == bs->entitynum) continue;
			//
			if (entinfo.origin[0] > mins[0] && entinfo.origin[0] < maxs[0]) {
				if (entinfo.origin[1] > mins[1] && entinfo.origin[1] < maxs[1]) {
					if (entinfo.origin[2] < mins[2]) {
						//if there's a team mate below the crusher
						if (BotSameTeam(bs, i)) {
							shootbutton = qfalse;
							break;
						}
						else {
							shootbutton = qtrue;
						}
					}
				}
			}
		}
		if (shootbutton) {
			bs->flags |= BFL_IDEALVIEWSET;
			VectorSubtract(buttonorg, bs->eye, dir);
			vectoangles(dir, bs->ideal_viewangles);
			aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY, 0, 1);
			bs->ideal_viewangles[PITCH] += 8 * crandom() * (1 - aim_accuracy);
			bs->ideal_viewangles[PITCH] = AngleMod(bs->ideal_viewangles[PITCH]);
			bs->ideal_viewangles[YAW] += 8 * crandom() * (1 - aim_accuracy);
			bs->ideal_viewangles[YAW] = AngleMod(bs->ideal_viewangles[YAW]);
			//
			if (InFieldOfVision(bs->viewangles, 20, bs->ideal_viewangles)) {
				trap_EA_Attack(bs->client);
			}
		}
	}
	else if (!Q_stricmp(mapname, "mpq3tourney6")) {
		//NOTE: NEVER use the func_bobbing in mpq3tourney6
		bs->tfl &= ~TFL_FUNCBOB;
	}
}

/*
==================
BotSetMovedir
==================
*/
// bk001205 - made these static
static vec3_t VEC_UP		= {0, -1,  0};
static vec3_t MOVEDIR_UP	= {0,  0,  1};
static vec3_t VEC_DOWN		= {0, -2,  0};
static vec3_t MOVEDIR_DOWN	= {0,  0, -1};

void BotSetMovedir(vec3_t angles, vec3_t movedir) {
	if (VectorCompare(angles, VEC_UP)) {
		VectorCopy(MOVEDIR_UP, movedir);
	}
	else if (VectorCompare(angles, VEC_DOWN)) {
		VectorCopy(MOVEDIR_DOWN, movedir);
	}
	else {
		AngleVectors(angles, movedir, NULL, NULL);
	}
}

/*
==================
BotModelMinsMaxs

this is ugly
==================
*/
int BotModelMinsMaxs(int modelindex, int eType, int contents, vec3_t mins, vec3_t maxs) {
	gentity_t *ent;
	int i;

	ent = &g_entities[0];
	for (i = 0; i < level.num_entities; i++, ent++) {
		if ( !ent->inuse ) {
			continue;
		}
		if ( eType && ent->s.eType != eType) {
			continue;
		}
		if ( contents && ent->r.contents != contents) {
			continue;
		}
		if (ent->s.modelindex == modelindex) {
			if (mins)
				VectorAdd(ent->r.currentOrigin, ent->r.mins, mins);
			if (maxs)
				VectorAdd(ent->r.currentOrigin, ent->r.maxs, maxs);
			return i;
		}
	}
	if (mins)
		VectorClear(mins);
	if (maxs)
		VectorClear(maxs);
	return 0;
}

/*
==================
BotFuncButtonGoal
==================
*/
int BotFuncButtonActivateGoal(bot_state_t *bs, int bspent, bot_activategoal_t *activategoal) {
	int i, areas[10], numareas, modelindex, entitynum;
	char model[128];
	float lip, dist, health, angle;
	vec3_t size, start, end, mins, maxs, angles, points[10];
	vec3_t movedir, origin, goalorigin, bboxmins, bboxmaxs;
	vec3_t extramins = {1, 1, 1}, extramaxs = {-1, -1, -1};
	bsp_trace_t bsptrace;

	activategoal->shoot = qfalse;
	VectorClear(activategoal->target);
	//create a bot goal towards the button
	trap_AAS_ValueForBSPEpairKey(bspent, "model", model, sizeof(model));
	if (!*model)
		return qfalse;
	modelindex = atoi(model+1);
	if (!modelindex)
		return qfalse;
	VectorClear(angles);
	entitynum = BotModelMinsMaxs(modelindex, ET_MOVER, 0, mins, maxs);
	//get the lip of the button
	trap_AAS_FloatForBSPEpairKey(bspent, "lip", &lip);
	if (!lip) lip = 4;
	//get the move direction from the angle
	trap_AAS_FloatForBSPEpairKey(bspent, "angle", &angle);
	VectorSet(angles, 0, angle, 0);
	BotSetMovedir(angles, movedir);
	//button size
	VectorSubtract(maxs, mins, size);
	//button origin
	VectorAdd(mins, maxs, origin);
	VectorScale(origin, 0.5, origin);
	//touch distance of the button
	dist = fabs(movedir[0]) * size[0] + fabs(movedir[1]) * size[1] + fabs(movedir[2]) * size[2];
	dist *= 0.5;
	//
	trap_AAS_FloatForBSPEpairKey(bspent, "health", &health);
	//if the button is shootable
	if (health) {
		//calculate the shoot target
		VectorMA(origin, -dist, movedir, goalorigin);
		//
		VectorCopy(goalorigin, activategoal->target);
		activategoal->shoot = qtrue;
		//
		BotAI_Trace(&bsptrace, bs->eye, NULL, NULL, goalorigin, bs->entitynum, MASK_SHOT);
		// if the button is visible from the current position
		if (bsptrace.fraction >= 1.0 || bsptrace.ent == entitynum) {
			//
			activategoal->goal.entitynum = entitynum; //NOTE: this is the entity number of the shootable button
			activategoal->goal.number = 0;
			activategoal->goal.flags = 0;
			VectorCopy(bs->origin, activategoal->goal.origin);
			activategoal->goal.areanum = bs->areanum;
			VectorSet(activategoal->goal.mins, -8, -8, -8);
			VectorSet(activategoal->goal.maxs, 8, 8, 8);
			//
			return qtrue;
		}
		else {
			//create a goal from where the button is visible and shoot at the button from there
			//add bounding box size to the dist
			trap_AAS_PresenceTypeBoundingBox(PRESENCE_CROUCH, bboxmins, bboxmaxs);
			for (i = 0; i < 3; i++) {
				if (movedir[i] < 0) dist += fabs(movedir[i]) * fabs(bboxmaxs[i]);
				else dist += fabs(movedir[i]) * fabs(bboxmins[i]);
			}
			//calculate the goal origin
			VectorMA(origin, -dist, movedir, goalorigin);
			//
			VectorCopy(goalorigin, start);
			start[2] += 24;
			VectorCopy(start, end);
			end[2] -= 512;
			numareas = trap_AAS_TraceAreas(start, end, areas, points, 10);
			//
			for (i = numareas-1; i >= 0; i--) {
				if (trap_AAS_AreaReachability(areas[i])) {
					break;
				}
			}
			if (i < 0) {
				// FIXME: trace forward and maybe in other directions to find a valid area
			}
			if (i >= 0) {
				//
				VectorCopy(points[i], activategoal->goal.origin);
				activategoal->goal.areanum = areas[i];
				VectorSet(activategoal->goal.mins, 8, 8, 8);
				VectorSet(activategoal->goal.maxs, -8, -8, -8);
				//
				for (i = 0; i < 3; i++)
				{
					if (movedir[i] < 0) activategoal->goal.maxs[i] += fabs(movedir[i]) * fabs(extramaxs[i]);
					else activategoal->goal.mins[i] += fabs(movedir[i]) * fabs(extramins[i]);
				} //end for
				//
				activategoal->goal.entitynum = entitynum;
				activategoal->goal.number = 0;
				activategoal->goal.flags = 0;
				return qtrue;
			}
		}
		return qfalse;
	}
	else {
		//add bounding box size to the dist
		trap_AAS_PresenceTypeBoundingBox(PRESENCE_CROUCH, bboxmins, bboxmaxs);
		for (i = 0; i < 3; i++) {
			if (movedir[i] < 0) dist += fabs(movedir[i]) * fabs(bboxmaxs[i]);
			else dist += fabs(movedir[i]) * fabs(bboxmins[i]);
		}
		//calculate the goal origin
		VectorMA(origin, -dist, movedir, goalorigin);
		//
		VectorCopy(goalorigin, start);
		start[2] += 24;
		VectorCopy(start, end);
		end[2] -= 100;
		numareas = trap_AAS_TraceAreas(start, end, areas, NULL, 10);
		//
		for (i = 0; i < numareas; i++) {
			if (trap_AAS_AreaReachability(areas[i])) {
				break;
			}
		}
		if (i < numareas) {
			//
			VectorCopy(origin, activategoal->goal.origin);
			activategoal->goal.areanum = areas[i];
			VectorSubtract(mins, origin, activategoal->goal.mins);
			VectorSubtract(maxs, origin, activategoal->goal.maxs);
			//
			for (i = 0; i < 3; i++)
			{
				if (movedir[i] < 0) activategoal->goal.maxs[i] += fabs(movedir[i]) * fabs(extramaxs[i]);
				else activategoal->goal.mins[i] += fabs(movedir[i]) * fabs(extramins[i]);
			} //end for
			//
			activategoal->goal.entitynum = entitynum;
			activategoal->goal.number = 0;
			activategoal->goal.flags = 0;
			return qtrue;
		}
	}
	return qfalse;
}

/*
==================
BotFuncDoorGoal
==================
*/
int BotFuncDoorActivateGoal(bot_state_t *bs, int bspent, bot_activategoal_t *activategoal) {
	int modelindex, entitynum;
	char model[MAX_INFO_STRING];
	vec3_t mins, maxs, origin, angles;

	//shoot at the shootable door
	trap_AAS_ValueForBSPEpairKey(bspent, "model", model, sizeof(model));
	if (!*model)
		return qfalse;
	modelindex = atoi(model+1);
	if (!modelindex)
		return qfalse;
	VectorClear(angles);
	entitynum = BotModelMinsMaxs(modelindex, ET_MOVER, 0, mins, maxs);
	//door origin
	VectorAdd(mins, maxs, origin);
	VectorScale(origin, 0.5, origin);
	VectorCopy(origin, activategoal->target);
	activategoal->shoot = qtrue;
	//
	activategoal->goal.entitynum = entitynum; //NOTE: this is the entity number of the shootable door
	activategoal->goal.number = 0;
	activategoal->goal.flags = 0;
	VectorCopy(bs->origin, activategoal->goal.origin);
	activategoal->goal.areanum = bs->areanum;
	VectorSet(activategoal->goal.mins, -8, -8, -8);
	VectorSet(activategoal->goal.maxs, 8, 8, 8);
	return qtrue;
}

/*
==================
BotTriggerMultipleGoal
==================
*/
int BotTriggerMultipleActivateGoal(bot_state_t *bs, int bspent, bot_activategoal_t *activategoal) {
	int i, areas[10], numareas, modelindex, entitynum;
	char model[128];
	vec3_t start, end, mins, maxs, angles;
	vec3_t origin, goalorigin;

	activategoal->shoot = qfalse;
	VectorClear(activategoal->target);
	//create a bot goal towards the trigger
	trap_AAS_ValueForBSPEpairKey(bspent, "model", model, sizeof(model));
	if (!*model)
		return qfalse;
	modelindex = atoi(model+1);
	if (!modelindex)
		return qfalse;
	VectorClear(angles);
	entitynum = BotModelMinsMaxs(modelindex, 0, CONTENTS_TRIGGER, mins, maxs);
	//trigger origin
	VectorAdd(mins, maxs, origin);
	VectorScale(origin, 0.5, origin);
	VectorCopy(origin, goalorigin);
	//
	VectorCopy(goalorigin, start);
	start[2] += 24;
	VectorCopy(start, end);
	end[2] -= 100;
	numareas = trap_AAS_TraceAreas(start, end, areas, NULL, 10);
	//
	for (i = 0; i < numareas; i++) {
		if (trap_AAS_AreaReachability(areas[i])) {
			break;
		}
	}
	if (i < numareas) {
		VectorCopy(origin, activategoal->goal.origin);
		activategoal->goal.areanum = areas[i];
		VectorSubtract(mins, origin, activategoal->goal.mins);
		VectorSubtract(maxs, origin, activategoal->goal.maxs);
		//
		activategoal->goal.entitynum = entitynum;
		activategoal->goal.number = 0;
		activategoal->goal.flags = 0;
		return qtrue;
	}
	return qfalse;
}

/*
==================
BotPopFromActivateGoalStack
==================
*/
int BotPopFromActivateGoalStack(bot_state_t *bs) {
	if (!bs->activatestack)
		return qfalse;
	BotEnableActivateGoalAreas(bs->activatestack, qtrue);
	bs->activatestack->inuse = qfalse;
	bs->activatestack->justused_time = FloatTime();
	bs->activatestack = bs->activatestack->next;
	return qtrue;
}

/*
==================
BotPushOntoActivateGoalStack
==================
*/
int BotPushOntoActivateGoalStack(bot_state_t *bs, bot_activategoal_t *activategoal) {
	int i, best;
	float besttime;

	best = -1;
	besttime = FloatTime() + 9999;
	//
	for (i = 0; i < MAX_ACTIVATESTACK; i++) {
		if (!bs->activategoalheap[i].inuse) {
			if (bs->activategoalheap[i].justused_time < besttime) {
				besttime = bs->activategoalheap[i].justused_time;
				best = i;
			}
		}
	}
	if (best != -1) {
		memcpy(&bs->activategoalheap[best], activategoal, sizeof(bot_activategoal_t));
		bs->activategoalheap[best].inuse = qtrue;
		bs->activategoalheap[best].next = bs->activatestack;
		bs->activatestack = &bs->activategoalheap[best];
		return qtrue;
	}
	return qfalse;
}

/*
==================
BotClearActivateGoalStack
==================
*/
void BotClearActivateGoalStack(bot_state_t *bs) {
	while(bs->activatestack)
		BotPopFromActivateGoalStack(bs);
}

/*
==================
BotEnableActivateGoalAreas
==================
*/
void BotEnableActivateGoalAreas(bot_activategoal_t *activategoal, int enable) {
	int i;

	if (activategoal->areasdisabled == !enable)
		return;
	for (i = 0; i < activategoal->numareas; i++)
		trap_AAS_EnableRoutingArea( activategoal->areas[i], enable );
	activategoal->areasdisabled = !enable;
}

/*
==================
BotIsGoingToActivateEntity
==================
*/
int BotIsGoingToActivateEntity(bot_state_t *bs, int entitynum) {
	bot_activategoal_t *a;
	int i;

	for (a = bs->activatestack; a; a = a->next) {
		if (a->time < FloatTime())
			continue;
		if (a->goal.entitynum == entitynum)
			return qtrue;
	}
	for (i = 0; i < MAX_ACTIVATESTACK; i++) {
		if (bs->activategoalheap[i].inuse)
			continue;
		//
		if (bs->activategoalheap[i].goal.entitynum == entitynum) {
			// if the bot went for this goal less than 2 seconds ago
			if (bs->activategoalheap[i].justused_time > FloatTime() - 2)
				return qtrue;
		}
	}
	return qfalse;
}

/*
==================
BotGetActivateGoal

  returns the number of the bsp entity to activate
  goal->entitynum will be set to the game entity to activate
==================
*/
//#define OBSTACLEDEBUG

int BotGetActivateGoal(bot_state_t *bs, int entitynum, bot_activategoal_t *activategoal) {
	int i, ent, cur_entities[10], spawnflags, modelindex, areas[MAX_ACTIVATEAREAS*2], numareas, t;
	char model[MAX_INFO_STRING], tmpmodel[128];
	char target[128], classname[128];
	float health;
	char targetname[10][128];
	aas_entityinfo_t entinfo;
	aas_areainfo_t areainfo;
	vec3_t origin, angles, absmins, absmaxs;

	memset(activategoal, 0, sizeof(bot_activategoal_t));
	BotEntityInfo(entitynum, &entinfo);
	Com_sprintf(model, sizeof( model ), "*%d", entinfo.modelindex);
	for (ent = trap_AAS_NextBSPEntity(0); ent; ent = trap_AAS_NextBSPEntity(ent)) {
		if (!trap_AAS_ValueForBSPEpairKey(ent, "model", tmpmodel, sizeof(tmpmodel))) continue;
		if (!strcmp(model, tmpmodel)) break;
	}
	if (!ent) {
		BotAI_Print(PRT_ERROR, "BotGetActivateGoal: no entity found with model %s\n", model);
		return 0;
	}
	trap_AAS_ValueForBSPEpairKey(ent, "classname", classname, sizeof(classname));
	if (!classname) {
		BotAI_Print(PRT_ERROR, "BotGetActivateGoal: entity with model %s has no classname\n", model);
		return 0;
	}
	//if it is a door
	if (!strcmp(classname, "func_door")) {
		if (trap_AAS_FloatForBSPEpairKey(ent, "health", &health)) {
			//if the door has health then the door must be shot to open
			if (health) {
				BotFuncDoorActivateGoal(bs, ent, activategoal);
				return ent;
			}
		}
		//
		trap_AAS_IntForBSPEpairKey(ent, "spawnflags", &spawnflags);
		// if the door starts open then just wait for the door to return
		if ( spawnflags & 1 )
			return 0;
		//get the door origin
		if (!trap_AAS_VectorForBSPEpairKey(ent, "origin", origin)) {
			VectorClear(origin);
		}
		//if the door is open or opening already
		if (!VectorCompare(origin, entinfo.origin))
			return 0;
		// store all the areas the door is in
		trap_AAS_ValueForBSPEpairKey(ent, "model", model, sizeof(model));
		if (*model) {
			modelindex = atoi(model+1);
			if (modelindex) {
				VectorClear(angles);
				BotModelMinsMaxs(modelindex, ET_MOVER, 0, absmins, absmaxs);
				//
				numareas = trap_AAS_BBoxAreas(absmins, absmaxs, areas, MAX_ACTIVATEAREAS*2);
				// store the areas with reachabilities first
				for (i = 0; i < numareas; i++) {
					if (activategoal->numareas >= MAX_ACTIVATEAREAS)
						break;
					if ( !trap_AAS_AreaReachability(areas[i]) ) {
						continue;
					}
					trap_AAS_AreaInfo(areas[i], &areainfo);
					if (areainfo.contents & AREACONTENTS_MOVER) {
						activategoal->areas[activategoal->numareas++] = areas[i];
					}
				}
				// store any remaining areas
				for (i = 0; i < numareas; i++) {
						if (activategoal->numareas >= MAX_ACTIVATEAREAS)
							break;
					if ( trap_AAS_AreaReachability(areas[i]) ) {
						continue;
					}
					trap_AAS_AreaInfo(areas[i], &areainfo);
					if (areainfo.contents & AREACONTENTS_MOVER) {
						activategoal->areas[activategoal->numareas++] = areas[i];
					}
				}
			}
		}
	}
	// if the bot is blocked by or standing on top of a button
	if (!strcmp(classname, "func_button")) {
		return 0;
	}
	// get the targetname so we can find an entity with a matching target
	if (!trap_AAS_ValueForBSPEpairKey(ent, "targetname", targetname[0], sizeof(targetname[0]))) {
		if (bot_developer.integer) {
			BotAI_Print(PRT_ERROR, "BotGetActivateGoal: entity with model \"%s\" has no targetname\n", model);
		}
		return 0;
	}
	// allow tree-like activation
	cur_entities[0] = trap_AAS_NextBSPEntity(0);
	for (i = 0; i >= 0 && i < 10;) {
		for (ent = cur_entities[i]; ent; ent = trap_AAS_NextBSPEntity(ent)) {
			if (!trap_AAS_ValueForBSPEpairKey(ent, "target", target, sizeof(target))) continue;
			if (!strcmp(targetname[i], target)) {
				cur_entities[i] = trap_AAS_NextBSPEntity(ent);
				break;
			}
		}
		if (!ent) {
			if (bot_developer.integer) {
				BotAI_Print(PRT_ERROR, "BotGetActivateGoal: no entity with target \"%s\"\n", targetname[i]);
			}
			i--;
			continue;
		}
		if (!trap_AAS_ValueForBSPEpairKey(ent, "classname", classname, sizeof(classname))) {
			if (bot_developer.integer) {
				BotAI_Print(PRT_ERROR, "BotGetActivateGoal: entity with target \"%s\" has no classname\n", targetname[i]);
			}
			continue;
		}
		// BSP button model
		if (!strcmp(classname, "func_button")) {
			//
			if (!BotFuncButtonActivateGoal(bs, ent, activategoal))
				continue;
			// if the bot tries to activate this button already
			if ( bs->activatestack && bs->activatestack->inuse &&
				 bs->activatestack->goal.entitynum == activategoal->goal.entitynum &&
				 bs->activatestack->time > FloatTime() &&
				 bs->activatestack->start_time < FloatTime() - 2)
				continue;
			// if the bot is in a reachability area
			if ( trap_AAS_AreaReachability(bs->areanum) ) {
				// disable all areas the blocking entity is in
				BotEnableActivateGoalAreas( activategoal, qfalse );
				//
				t = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, activategoal->goal.areanum, bs->tfl);
				// if the button is not reachable
				if (!t) {
					continue;
				}
				activategoal->time = FloatTime() + t * 0.01 + 5;
			}
			return ent;
		}
		// invisible trigger multiple box
		else if (!strcmp(classname, "trigger_multiple")) {
			//
			if (!BotTriggerMultipleActivateGoal(bs, ent, activategoal))
				continue;
			// if the bot tries to activate this trigger already
			if ( bs->activatestack && bs->activatestack->inuse &&
				 bs->activatestack->goal.entitynum == activategoal->goal.entitynum &&
				 bs->activatestack->time > FloatTime() &&
				 bs->activatestack->start_time < FloatTime() - 2)
				continue;
			// if the bot is in a reachability area
			if ( trap_AAS_AreaReachability(bs->areanum) ) {
				// disable all areas the blocking entity is in
				BotEnableActivateGoalAreas( activategoal, qfalse );
				//
				t = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, activategoal->goal.areanum, bs->tfl);
				// if the trigger is not reachable
				if (!t) {
					continue;
				}
				activategoal->time = FloatTime() + t * 0.01 + 5;
			}
			return ent;
		}
		else if (!strcmp(classname, "func_timer")) {
			// just skip the func_timer
			continue;
		}
		// the actual button or trigger might be linked through a target_relay or target_delay
		else if (!strcmp(classname, "target_relay") || !strcmp(classname, "target_delay")) {
			if (trap_AAS_ValueForBSPEpairKey(ent, "targetname", targetname[i+1], sizeof(targetname[0]))) {
				i++;
				cur_entities[i] = trap_AAS_NextBSPEntity(0);
			}
		}
	}
#ifdef OBSTACLEDEBUG
	BotAI_Print(PRT_ERROR, "BotGetActivateGoal: no valid activator for entity with target \"%s\"\n", targetname[0]);
#endif
	return 0;
}

/*
==================
BotGoForActivateGoal
==================
*/
int BotGoForActivateGoal(bot_state_t *bs, bot_activategoal_t *activategoal) {
	aas_entityinfo_t activateinfo;

	activategoal->inuse = qtrue;
	if (!activategoal->time)
		activategoal->time = FloatTime() + 10;
	activategoal->start_time = FloatTime();
	BotEntityInfo(activategoal->goal.entitynum, &activateinfo);
	VectorCopy(activateinfo.origin, activategoal->origin);
	//
	if (BotPushOntoActivateGoalStack(bs, activategoal)) {
		// enter the activate entity AI node
		AIEnter_Seek_ActivateEntity(bs, "BotGoForActivateGoal");
		return qtrue;
	}
	else {
		// enable any routing areas that were disabled
		BotEnableActivateGoalAreas(activategoal, qtrue);
		return qfalse;
	}
}

/*
==================
BotPrintActivateGoalInfo
==================
*/
void BotPrintActivateGoalInfo(bot_state_t *bs, bot_activategoal_t *activategoal, int bspent) {
	char netname[MAX_NETNAME];
	char classname[128];
	char buf[128];

	ClientName(bs->client, netname, sizeof(netname));
	trap_AAS_ValueForBSPEpairKey(bspent, "classname", classname, sizeof(classname));
	if (activategoal->shoot) {
		Com_sprintf(buf, sizeof(buf), "%s: I have to shoot at a %s from %1.1f %1.1f %1.1f in area %d\n",
						netname, classname,
						activategoal->goal.origin[0],
						activategoal->goal.origin[1],
						activategoal->goal.origin[2],
						activategoal->goal.areanum);
	}
	else {
		Com_sprintf(buf, sizeof(buf), "%s: I have to activate a %s at %1.1f %1.1f %1.1f in area %d\n",
						netname, classname,
						activategoal->goal.origin[0],
						activategoal->goal.origin[1],
						activategoal->goal.origin[2],
						activategoal->goal.areanum);
	}
	trap_EA_Say(bs->client, buf);
}

/*
==================
BotRandomMove
==================
*/
void BotRandomMove(bot_state_t *bs, bot_moveresult_t *moveresult) {
	vec3_t dir, angles;

	angles[0] = 0;
	angles[1] = random() * 360;
	angles[2] = 0;
	AngleVectors(angles, dir, NULL, NULL);

	trap_BotMoveInDirection(bs->ms, dir, 400, MOVE_WALK);

	moveresult->failure = qfalse;
	VectorCopy(dir, moveresult->movedir);
}

/*
==================
JUHOX: BotMemorizeOrigin
==================
*/
static void BotMemorizeOrigin(bot_state_t* bs) {
	if (bs->oldOrigin1_time <= FloatTime() - 2) {
		VectorCopy(bs->oldOrigin1, bs->oldOrigin2);
		bs->oldOrigin2_time = bs->oldOrigin1_time;
		VectorCopy(bs->origin, bs->oldOrigin1);
		bs->oldOrigin1_time = FloatTime();
	}
}

/*
==================
JUHOX: BotCheckSidewardVector
==================
*/
static void BotCheckSidewardVector(bot_state_t* bs, const vec3_t sideward) {
	if (bs->oldOrigin2_time >= FloatTime() - 4) {
		vec3_t dir;

		VectorSubtract(bs->origin, bs->oldOrigin2, dir);
		VectorNormalize(dir);
		if (DotProduct(sideward, dir) < 0) {
			bs->flags |= BFL_AVOIDRIGHT;	// try the other direction
		}
		else {
			bs->flags &= ~BFL_AVOIDRIGHT;	// this direction is ok
		}
	}
}

/*
==================
BotAIBlocked

Very basic handling of bots being blocked by other entities.
Check what kind of entity is blocking the bot and try to activate
it. If that's not an option then try to walk around or over the entity.
Before the bot ends in this part of the AI it should predict which doors to
open, which buttons to activate etc.
==================
*/
void BotAIBlocked(bot_state_t *bs, bot_moveresult_t *moveresult, int activate) {
	int /*movetype,*/ bspent;	// JUHOX: using bs->tryMove instead
	vec3_t hordir, /*start, end, mins, maxs,*/ sideward, angles, up = {0, 0, 1};	// JUHOX: some variables no longer needed
	aas_entityinfo_t entinfo;
	bot_activategoal_t activategoal;
	playerState_t ps;	// JUHOX


#if 0	// JUHOX: continue with obstacle avoidance move if the bot was recently blocked
	// if the bot is not blocked by anything
	if (!moveresult->blocked) {
		bs->notblocked_time = FloatTime();
		return;
	}
#else
	if (bs->walkTrouble) {
		bs->tryMove = MOVE_WALK;
		goto BotBlocked;
	}
	if (!moveresult->blocked) {
		bs->blockingEnemy = -1;
		bs->notblocked_time = FloatTime();
		if (bs->tryMove && bs->blocked_time > FloatTime() - 0.5) goto ObstacleAvoidanceMove;
		if (rand() & 1) bs->flags ^= BFL_AVOIDRIGHT;
		VectorSet(bs->notblocked_dir, 0, 0, 0);
		BotMemorizeOrigin(bs);
		return;
	}
	bs->tryMove = MOVE_JUMP;
#endif
	// if stuck in a solid area
	if ( moveresult->type == RESULTTYPE_INSOLIDAREA ) {
		// move in a random direction in the hope to get out
		BotRandomMove(bs, moveresult);
		//
		return;
	}
#if 1	// JUHOX: check if it's an enemy
	if (BotAI_GetClientState(moveresult->blockentity, &ps)) {
		if (
			g_gametype.integer < GT_TEAM ||
			bs->cur_ps.persistant[PERS_TEAM] != ps.persistant[PERS_TEAM]
		) {
			bs->blockingEnemy = moveresult->blockentity;
		}
	}
#endif
	// get info for the entity that is blocking the bot
	BotEntityInfo(moveresult->blockentity, &entinfo);
#ifdef OBSTACLEDEBUG
	ClientName(bs->client, netname, sizeof(netname));
	BotAI_Print(PRT_MESSAGE, "%s: I'm blocked by model %d\n", netname, entinfo.modelindex);
#endif OBSTACLEDEBUG
	// if blocked by a bsp model and the bot wants to activate it
	if (activate && entinfo.modelindex > 0 && entinfo.modelindex <= max_bspmodelindex) {
		// find the bsp entity which should be activated in order to get the blocking entity out of the way
		bspent = BotGetActivateGoal(bs, entinfo.number, &activategoal);
		if (bspent) {
			//
			if (bs->activatestack && !bs->activatestack->inuse)
				bs->activatestack = NULL;
			// if not already trying to activate this entity
			if (!BotIsGoingToActivateEntity(bs, activategoal.goal.entitynum)) {
				//
				BotGoForActivateGoal(bs, &activategoal);
			}
			// if ontop of an obstacle or
			// if the bot is not in a reachability area it'll still
			// need some dynamic obstacle avoidance, otherwise return
			if (!(moveresult->flags & MOVERESULT_ONTOPOFOBSTACLE) &&
				trap_AAS_AreaReachability(bs->areanum))
				return;
		}
		else {
			// enable any routing areas that were disabled
			BotEnableActivateGoalAreas(&activategoal, qtrue);
		}
	}
	// just some basic dynamic obstacle avoidance code
#if 0	// JUHOX: slightly improved obstacle avoidance strategy
	hordir[0] = moveresult->movedir[0];
	hordir[1] = moveresult->movedir[1];
	hordir[2] = 0;
	// if no direction just take a random direction
	if (VectorNormalize(hordir) < 0.1) {
		VectorSet(angles, 0, 360 * random(), 0);
		AngleVectors(angles, hordir, NULL, NULL);
	}
	//
	//if (moveresult->flags & MOVERESULT_ONTOPOFOBSTACLE) movetype = MOVE_JUMP;
	//else
	movetype = MOVE_WALK;
	// if there's an obstacle at the bot's feet and head then
	// the bot might be able to crouch through
	VectorCopy(bs->origin, start);
	start[2] += 18;
	VectorMA(start, 5, hordir, end);
	VectorSet(mins, -16, -16, -24);
	VectorSet(maxs, 16, 16, 4);
	//
	//bsptrace = AAS_Trace(start, mins, maxs, end, bs->entitynum, MASK_PLAYERSOLID);
	//if (bsptrace.fraction >= 1) movetype = MOVE_CROUCH;
	// get the sideward vector
	CrossProduct(hordir, up, sideward);
	//
	if (bs->flags & BFL_AVOIDRIGHT) VectorNegate(sideward, sideward);
	// try to crouch straight forward?
	if (movetype != MOVE_CROUCH || !trap_BotMoveInDirection(bs->ms, hordir, 400, movetype)) {
		// perform the movement
		if (!trap_BotMoveInDirection(bs->ms, sideward, 400, movetype)) {
			// flip the avoid direction flag
			bs->flags ^= BFL_AVOIDRIGHT;
			// flip the direction
			// VectorNegate(sideward, sideward);
			VectorMA(sideward, -1, hordir, sideward);
			// move in the other direction
			trap_BotMoveInDirection(bs->ms, sideward, 400, movetype);
		}
	}
#else
	BotBlocked:
	bs->blocked_time = FloatTime();

	ObstacleAvoidanceMove:
	hordir[0] = moveresult->movedir[0];
	hordir[1] = moveresult->movedir[1];
	hordir[2] = 0;
	//if no direction just take a random direction
	if (VectorNormalize(hordir) < 0.1) {
		VectorSet(angles, 0, 360 * random(), 0);
		AngleVectors(angles, hordir, NULL, NULL);
	}
	CrossProduct(hordir, up, sideward);
	BotCheckSidewardVector(bs, sideward);
	if (bs->flags & BFL_AVOIDRIGHT) VectorNegate(sideward, sideward);

	//if (!bs->walkTrouble) VectorScale(hordir, -0.5, hordir);
	VectorAdd(hordir, sideward, hordir);
	VectorNormalize(hordir);

	{
		float speed;

		speed = bs->forceWalk? 200 : 400;
		//bs->preventJump = qtrue;
		if (!trap_BotMoveInDirection(bs->ms, hordir, speed, bs->tryMove)) {
			if (!trap_BotMoveInDirection(bs->ms, sideward, speed, MOVE_WALK)) {
				bs->oldOrigin1_time = bs->oldOrigin2_time = 0;
				bs->flags ^= BFL_AVOIDRIGHT;
				VectorNegate(sideward, sideward);
				if (!trap_BotMoveInDirection(bs->ms, sideward, speed, MOVE_WALK)) {
					if (DotProduct(bs->notblocked_dir, bs->notblocked_dir) < 0.1) {
						VectorSet(angles, 0, 360 * random(), 0);
						AngleVectors(angles, hordir, NULL, NULL);
					}
					else {
						VectorCopy(bs->notblocked_dir, hordir);
					}
					if (trap_BotMoveInDirection(bs->ms, hordir, speed, MOVE_WALK)) {
						VectorCopy(hordir, bs->notblocked_dir);
					}
					else {
						VectorSet(bs->notblocked_dir, 0, 0, 0);
					}
				}
			}
		}
	}
#endif
	//
	if (bs->notblocked_time < FloatTime() - 0.4) {
		// just reset goals and hope the bot will go into another direction?
		// is this still needed??
		if (bs->ainode == AINode_Seek_NBG) bs->nbg_time = 0;
		else if (bs->ainode == AINode_Seek_LTG) bs->ltg_time = 0;
	}
#if 1	// JUHOX: if blocked quite a long time
	if (
		(
			bs->notblocked_time < FloatTime() - 1 &&
			!BotWantsToRetreat(bs)
		) ||
		bs->notblocked_time < FloatTime() - 2
	) {
		bs->ltgtype = LTG_WAIT;
		bs->teamgoal_time = FloatTime() + 5 * random();
	}
#endif
}

/*
==================
BotAIPredictObstacles

Predict the route towards the goal and check if the bot
will be blocked by certain obstacles. When the bot has obstacles
on it's path the bot should figure out if they can be removed
by activating certain entities.
==================
*/
int BotAIPredictObstacles(bot_state_t *bs, bot_goal_t *goal) {
	int modelnum, entitynum, bspent;
	bot_activategoal_t activategoal;
	aas_predictroute_t route;

	if (!bot_predictobstacles.integer)
		return qfalse;

	// always predict when the goal change or at regular intervals
	if (bs->predictobstacles_goalareanum == goal->areanum &&
		bs->predictobstacles_time > FloatTime() - 6) {
		return qfalse;
	}
	bs->predictobstacles_goalareanum = goal->areanum;
	bs->predictobstacles_time = FloatTime();

	// predict at most 100 areas or 10 seconds ahead
	trap_AAS_PredictRoute(&route, bs->areanum, bs->origin,
							goal->areanum, bs->tfl, 100, 1000,
							RSE_USETRAVELTYPE|RSE_ENTERCONTENTS,
							AREACONTENTS_MOVER, TFL_BRIDGE, 0);
	// if bot has to travel through an area with a mover
	if (route.stopevent & RSE_ENTERCONTENTS) {
		// if the bot will run into a mover
		if (route.endcontents & AREACONTENTS_MOVER) {
			//NOTE: this only works with bspc 2.1 or higher
			modelnum = (route.endcontents & AREACONTENTS_MODELNUM) >> AREACONTENTS_MODELNUMSHIFT;
			if (modelnum) {
				//
				entitynum = BotModelMinsMaxs(modelnum, ET_MOVER, 0, NULL, NULL);
				if (entitynum) {
					//NOTE: BotGetActivateGoal already checks if the door is open or not
					bspent = BotGetActivateGoal(bs, entitynum, &activategoal);
					if (bspent) {
						//
						if (bs->activatestack && !bs->activatestack->inuse)
							bs->activatestack = NULL;
						// if not already trying to activate this entity
						if (!BotIsGoingToActivateEntity(bs, activategoal.goal.entitynum)) {
							//
							//BotAI_Print(PRT_MESSAGE, "blocked by mover model %d, entity %d ?\n", modelnum, entitynum);
							//
							BotGoForActivateGoal(bs, &activategoal);
							return qtrue;
						}
						else {
							// enable any routing areas that were disabled
							BotEnableActivateGoalAreas(&activategoal, qtrue);
						}
					}
				}
			}
		}
	}
	else if (route.stopevent & RSE_USETRAVELTYPE) {
		if (route.endtravelflags & TFL_BRIDGE) {
			//FIXME: check if the bridge is available to travel over
		}
	}
	return qfalse;
}

/*
==================
BotCheckConsoleMessages
==================
*/
void BotCheckConsoleMessages(bot_state_t *bs) {
#if 0	// JUHOX: no bot chats
	char botname[MAX_NETNAME], message[MAX_MESSAGE_SIZE], netname[MAX_NETNAME], *ptr;
	float chat_reply;
	int context, handle;
	bot_consolemessage_t m;
	bot_match_t match;

	//the name of this bot
	ClientName(bs->client, botname, sizeof(botname));
#else
	int handle;
	bot_consolemessage_t m;
#endif
	//
	while((handle = trap_BotNextConsoleMessage(bs->cs, &m)) != 0) {
#if 0	// JUHOX: no bot chats
		//if the chat state is flooded with messages the bot will read them quickly
		if (trap_BotNumConsoleMessages(bs->cs) < 10) {
			//if it is a chat message the bot needs some time to read it
			if (m.type == CMS_CHAT && m.time > FloatTime() - (1 + random())) break;
		}
		//
		ptr = m.message;
		//if it is a chat message then don't unify white spaces and don't
		//replace synonyms in the netname
		if (m.type == CMS_CHAT) {
			//
			if (trap_BotFindMatch(m.message, &match, MTCONTEXT_REPLYCHAT)) {
				ptr = m.message + match.variables[MESSAGE].offset;
			}
		}
		//unify the white spaces in the message
		trap_UnifyWhiteSpaces(ptr);
		//replace synonyms in the right context
		context = BotSynonymContext(bs);
		trap_BotReplaceSynonyms(ptr, context);
		//if there's no match
		if (!BotMatchMessage(bs, m.message)) {
			//if it is a chat message
			if (m.type == CMS_CHAT && !bot_nochat.integer) {
				//
				if (!trap_BotFindMatch(m.message, &match, MTCONTEXT_REPLYCHAT)) {
					trap_BotRemoveConsoleMessage(bs->cs, handle);
					continue;
				}
				//don't use eliza chats with team messages
				if (match.subtype & ST_TEAM) {
					trap_BotRemoveConsoleMessage(bs->cs, handle);
					continue;
				}
				//
				trap_BotMatchVariable(&match, NETNAME, netname, sizeof(netname));
				trap_BotMatchVariable(&match, MESSAGE, message, sizeof(message));
				//if this is a message from the bot self
				if (bs->client == ClientFromName(netname)) {
					trap_BotRemoveConsoleMessage(bs->cs, handle);
					continue;
				}
				//unify the message
				trap_UnifyWhiteSpaces(message);
				//
				trap_Cvar_Update(&bot_testrchat);
				if (bot_testrchat.integer) {
					//
					trap_BotLibVarSet("bot_testrchat", "1");
					//if bot replies with a chat message
					if (trap_BotReplyChat(bs->cs, message, context, CONTEXT_REPLY,
															NULL, NULL,
															NULL, NULL,
															NULL, NULL,
															botname, netname)) {
						BotAI_Print(PRT_MESSAGE, "------------------------\n");
					}
					else {
						BotAI_Print(PRT_MESSAGE, "**** no valid reply ****\n");
					}
				}
				//if at a valid chat position and not chatting already and not in teamplay
				else if (bs->ainode != AINode_Stand && BotValidChatPosition(bs) && !TeamPlayIsOn()) {
					chat_reply = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_REPLY, 0, 1);
					if (random() < 1.5 / (NumBots()+1) && random() < chat_reply) {
						//if bot replies with a chat message
						if (trap_BotReplyChat(bs->cs, message, context, CONTEXT_REPLY,
																NULL, NULL,
																NULL, NULL,
																NULL, NULL,
																botname, netname)) {
							//remove the console message
							trap_BotRemoveConsoleMessage(bs->cs, handle);
							bs->stand_time = FloatTime() + BotChatTime(bs);
							AIEnter_Stand(bs, "BotCheckConsoleMessages: reply chat");
							//EA_Say(bs->client, bs->cs.chatmessage);
							break;
						}
					}
				}
			}
		}
#endif
		//remove the console message
		trap_BotRemoveConsoleMessage(bs->cs, handle);
	}
}

/*
==================
BotCheckEvents
==================
*/
// JUHOX BUGFIX (workaround): BotCheckForGrenades() seems to cause crashes
#if 0
void BotCheckForGrenades(bot_state_t *bs, entityState_t *state) {
	// if this is not a grenade
	if (state->eType != ET_MISSILE || state->weapon != WP_GRENADE_LAUNCHER)
		return;
	// try to avoid the grenade
	trap_BotAddAvoidSpot(bs->ms, state->pos.trBase, 160, AVOID_ALWAYS);
}
#endif


/*
==================
BotCheckEvents
==================
*/
void BotCheckEvents(bot_state_t *bs, entityState_t *state) {
	int event;
	char buf[128];

	//NOTE: this sucks, we're accessing the gentity_t directly
	//but there's no other fast way to do it right now
	if (bs->entityeventTime[state->number] == g_entities[state->number].eventTime) {
		return;
	}
	bs->entityeventTime[state->number] = g_entities[state->number].eventTime;
	//if it's an event only entity
	if (state->eType > ET_EVENTS) {
		event = (state->eType - ET_EVENTS) & ~EV_EVENT_BITS;
	}
	else {
		event = state->event & ~EV_EVENT_BITS;
	}
	//
	switch(event) {
		//client obituary event
		case EV_OBITUARY:
		{
			int target, attacker, mod;

			target = state->otherEntityNum;
			attacker = state->otherEntityNum2;
			mod = state->eventParm;
			//
			if (target == bs->client) {
				bs->botdeathtype = mod;
				bs->lastkilledby = attacker;
				//
				if (target == attacker ||
					target == ENTITYNUM_NONE ||
					target == ENTITYNUM_WORLD) bs->botsuicide = qtrue;
				else bs->botsuicide = qfalse;
				//
				bs->num_deaths++;
			}
			//else if this client was killed by the bot
			else if (attacker == bs->client) {
				bs->enemydeathtype = mod;
				bs->lastkilledplayer = target;
				bs->killedenemy_time = FloatTime();
				//
				bs->num_kills++;
			}
			else if (attacker == bs->enemy && target == attacker) {
				bs->enemysuicide = qtrue;
			}
			//
			break;
		}
		case EV_GLOBAL_SOUND:
		{
			if (state->eventParm < 0 || state->eventParm > MAX_SOUNDS) {
				BotAI_Print(PRT_ERROR, "EV_GLOBAL_SOUND: eventParm (%d) out of range\n", state->eventParm);
				break;
			}
			trap_GetConfigstring(CS_SOUNDS + state->eventParm, buf, sizeof(buf));
			/*
			if (!strcmp(buf, "sound/teamplay/flagret_red.wav")) {
				//red flag is returned
				bs->redflagstatus = 0;
				bs->flagstatuschanged = qtrue;
			}
			else if (!strcmp(buf, "sound/teamplay/flagret_blu.wav")) {
				//blue flag is returned
				bs->blueflagstatus = 0;
				bs->flagstatuschanged = qtrue;
			}
			else*/
				if (!strcmp(buf, "sound/items/poweruprespawn.wav")) {
				//powerup respawned... go get it
				BotGoForPowerups(bs);
			}
			break;
		}
		case EV_GLOBAL_TEAM_SOUND:
		{
			if (gametype == GT_CTF) {
				switch(state->eventParm) {
					case GTS_RED_CAPTURE:
						bs->blueflagstatus = 0;
						bs->redflagstatus = 0;
						bs->flagstatuschanged = qtrue;
						break; //see BotMatch_CTF
					case GTS_BLUE_CAPTURE:
						bs->blueflagstatus = 0;
						bs->redflagstatus = 0;
						bs->flagstatuschanged = qtrue;
						break; //see BotMatch_CTF
					case GTS_RED_RETURN:
						//blue flag is returned
						bs->blueflagstatus = 0;
						bs->flagstatuschanged = qtrue;
						break;
					case GTS_BLUE_RETURN:
						//red flag is returned
						bs->redflagstatus = 0;
						bs->flagstatuschanged = qtrue;
						break;
					case GTS_RED_TAKEN:
						//blue flag is taken
						bs->blueflagstatus = 1;
						bs->flagstatuschanged = qtrue;
						break; //see BotMatch_CTF
					case GTS_BLUE_TAKEN:
						//red flag is taken
						bs->redflagstatus = 1;
						bs->flagstatuschanged = qtrue;
						break; //see BotMatch_CTF
				}
			}
			break;
		}
		case EV_PLAYER_TELEPORT_IN:
		{
			VectorCopy(state->origin, lastteleport_origin);
			lastteleport_time = FloatTime();
			break;
		}
		case EV_GENERAL_SOUND:
		{
			//if this sound is played on the bot
			if (state->number == bs->client) {
				if (state->eventParm < 0 || state->eventParm > MAX_SOUNDS) {
					BotAI_Print(PRT_ERROR, "EV_GENERAL_SOUND: eventParm (%d) out of range\n", state->eventParm);
					break;
				}
				//check out the sound
				trap_GetConfigstring(CS_SOUNDS + state->eventParm, buf, sizeof(buf));
				//if falling into a death pit
				if (!strcmp(buf, "*falling1.wav")) {
					//if the bot has a personal teleporter
					if (bs->inventory[INVENTORY_TELEPORTER] > 0) {
						//use the holdable item
						trap_EA_Use(bs->client);
					}
				}
			}
			break;
		}
		case EV_FOOTSTEP:
		case EV_FOOTSTEP_METAL:
		case EV_FOOTSPLASH:
		case EV_FOOTWADE:
		case EV_SWIM:
		case EV_FALL_SHORT:
		case EV_FALL_MEDIUM:
		case EV_FALL_FAR:
		case EV_STEP_4:
		case EV_STEP_8:
		case EV_STEP_12:
		case EV_STEP_16:
		case EV_JUMP_PAD:
		case EV_JUMP:
		case EV_TAUNT:
		case EV_WATER_TOUCH:
		case EV_WATER_LEAVE:
		case EV_WATER_UNDER:
		case EV_WATER_CLEAR:
		case EV_ITEM_PICKUP:
		case EV_GLOBAL_ITEM_PICKUP:
		case EV_NOAMMO:
		case EV_CHANGE_WEAPON:
		case EV_FIRE_WEAPON:
			//FIXME: either add to sound queue or mark player as someone making noise
			break;
		case EV_USE_ITEM0:
		case EV_USE_ITEM1:
		case EV_USE_ITEM2:
		case EV_USE_ITEM3:
		case EV_USE_ITEM4:
		case EV_USE_ITEM5:
		case EV_USE_ITEM6:
		case EV_USE_ITEM7:
		case EV_USE_ITEM8:
		case EV_USE_ITEM9:
		case EV_USE_ITEM10:
		case EV_USE_ITEM11:
		case EV_USE_ITEM12:
		case EV_USE_ITEM13:
		case EV_USE_ITEM14:
			break;
	}
}

/*
==================
BotCheckSnapshot
==================
*/
void BotCheckSnapshot(bot_state_t *bs) {
	int ent;
	entityState_t state;

	//remove all avoid spots
	trap_BotAddAvoidSpot(bs->ms, vec3_origin, 0, AVOID_CLEAR);
	//reset kamikaze body
	bs->kamikazebody = 0;
	//reset number of proxmines
	bs->numproxmines = 0;
	//
	ent = 0;
	while( ( ent = BotAI_GetSnapshotEntity( bs->client, ent, &state ) ) != -1 ) {
		//check the entity state for events
		BotCheckEvents(bs, &state);

	}
	//check the player state for events
	BotAI_GetEntityState(bs->client, &state);
	//copy the player state events to the entity state
	state.event = bs->cur_ps.externalEvent;
	state.eventParm = bs->cur_ps.externalEventParm;
	//
	BotCheckEvents(bs, &state);
}

/*
==================
BotCheckAir
==================
*/
void BotCheckAir(bot_state_t *bs) {
	// JUHOX: new air-out condition
	if (bs->cur_ps.stats[STAT_STRENGTH] <= 0) {
		if (trap_AAS_PointContents(bs->eye) & (CONTENTS_WATER|CONTENTS_SLIME|CONTENTS_LAVA)) {
			return;
		}
	}

	bs->lastair_time = FloatTime();
}

/*
==================
BotAlternateRoute
==================
*/
bot_goal_t *BotAlternateRoute(bot_state_t *bs, bot_goal_t *goal) {
	// JUHOX: currently no alternate routes available
	return goal;
}

/*
==================
BotGetAlternateRouteGoal
==================
*/
int BotGetAlternateRouteGoal(bot_state_t *bs, int base) {
	aas_altroutegoal_t *altroutegoals;
	bot_goal_t *goal;
	int numaltroutegoals, rnd;

	if (base == TEAM_RED) {
		altroutegoals = red_altroutegoals;
		numaltroutegoals = red_numaltroutegoals;
	}
	else {
		altroutegoals = blue_altroutegoals;
		numaltroutegoals = blue_numaltroutegoals;
	}
	if (!numaltroutegoals)
		return qfalse;
	rnd = (float) random() * numaltroutegoals;
	if (rnd >= numaltroutegoals)
		rnd = numaltroutegoals-1;
	goal = &bs->altroutegoal;
	goal->areanum = altroutegoals[rnd].areanum;
	VectorCopy(altroutegoals[rnd].origin, goal->origin);
	VectorSet(goal->mins, -8, -8, -8);
	VectorSet(goal->maxs, 8, 8, 8);
	goal->entitynum = 0;
	goal->iteminfo = 0;
	goal->number = 0;
	goal->flags = 0;

	bs->reachedaltroutegoal_time = 0;
	return qtrue;
}

/*
==================
BotSetupAlternateRouteGoals
==================
*/
void BotSetupAlternativeRouteGoals(void) {

	if (altroutegoals_setup)
		return;
	altroutegoals_setup = qtrue;
}

/*
==================
BotDeathmatchAI
==================
*/
void BotDeathmatchAI(bot_state_t *bs, float thinktime) {
	char gender[144], name[144], buf[144];
	char userinfo[MAX_INFO_STRING];
	int i;

	//if the bot has just been setup
	if (bs->setupcount > 0) {
		bs->setupcount--;
		if (bs->setupcount > 0) return;
		//get the gender characteristic
		trap_Characteristic_String(bs->character, CHARACTERISTIC_GENDER, gender, sizeof(gender));
		//set the bot gender
		trap_GetUserinfo(bs->client, userinfo, sizeof(userinfo));
		Info_SetValueForKey(userinfo, "sex", gender);
		trap_SetUserinfo(bs->client, userinfo);
		//set the team
		if ( !bs->map_restart && g_gametype.integer != GT_TOURNAMENT ) {
			Com_sprintf(buf, sizeof(buf), "team %s", bs->settings.team);
			trap_EA_Command(bs->client, buf);
		}
		//set the chat gender
		if (gender[0] == 'm') trap_BotSetChatGender(bs->cs, CHAT_GENDERMALE);
		else if (gender[0] == 'f')  trap_BotSetChatGender(bs->cs, CHAT_GENDERFEMALE);
		else  trap_BotSetChatGender(bs->cs, CHAT_GENDERLESS);
		//set the chat name
		ClientName(bs->client, name, sizeof(name));
		trap_BotSetChatName(bs->cs, name, bs->client);
		//
		bs->lastframe_health = bs->inventory[INVENTORY_HEALTH];
		bs->lasthitcount = bs->cur_ps.persistant[PERS_HITS];
		//
		bs->setupcount = 0;
		//
		BotSetupAlternativeRouteGoals();
	}
	//no ideal view set
	bs->flags &= ~BFL_IDEALVIEWSET;
	//
	if (!BotIntermission(bs)) {
		//set the teleport time
		BotSetTeleportTime(bs);
		//update some inventory values
		BotUpdateInventory(bs);
		//check out the snapshot
		BotCheckSnapshot(bs);
		//check for air
		BotCheckAir(bs);
		if (bs->weaponchoose_time < FloatTime() - 1) BotChooseWeapon(bs);	// JUHOX
	}
	//check the console messages
	BotCheckConsoleMessages(bs);
	//if not in the intermission and not in observer mode
	if (!BotIntermission(bs) && !BotIsObserver(bs)) {
		//do team AI
		BotTeamAI(bs);
	}
	//if the bot has no ai node
	if (!bs->ainode) {
		AIEnter_Seek_LTG(bs, "BotDeathmatchAI: no ai node");
	}
	//if the bot entered the game less than 8 seconds ago
	if (!bs->entergamechat && bs->entergame_time > FloatTime() - 8) {
		if (BotChat_EnterGame(bs)) {
			bs->stand_time = FloatTime() + BotChatTime(bs);
			AIEnter_Stand(bs, "BotDeathmatchAI: chat enter game");
		}
		bs->entergamechat = qtrue;
	}
	//reset the node switches from the previous frame
	BotResetNodeSwitches();
	//execute AI nodes
	for (i = 0; i < MAX_NODESWITCHES; i++) {
		if (bs->ainode(bs)) break;
	}
	//if the bot removed itself :)
	if (!bs->inuse) return;
	//if the bot executed too many AI nodes
	if (i >= MAX_NODESWITCHES) {
		trap_BotDumpGoalStack(bs->gs);
		trap_BotDumpAvoidGoals(bs->gs);
		BotDumpNodeSwitches(bs);
		ClientName(bs->client, name, sizeof(name));
		BotAI_Print(PRT_ERROR, "%s at %1.1f switched more than %d AI nodes\n", name, FloatTime(), MAX_NODESWITCHES);
	}
	//
	bs->lastframe_health = bs->inventory[INVENTORY_HEALTH];
	bs->lasthitcount = bs->cur_ps.persistant[PERS_HITS];
}

/*
==================
BotSetEntityNumForGoalWithModel
==================
*/
void BotSetEntityNumForGoalWithModel(bot_goal_t *goal, int eType, char *modelname) {
	gentity_t *ent;
	int i, modelindex;
	vec3_t dir;

	modelindex = G_ModelIndex( modelname );
	ent = &g_entities[0];
	for (i = 0; i < level.num_entities; i++, ent++) {
		if ( !ent->inuse ) {
			continue;
		}
		if ( eType && ent->s.eType != eType) {
			continue;
		}
		if (ent->s.modelindex != modelindex) {
			continue;
		}
		VectorSubtract(goal->origin, ent->s.origin, dir);
		if (VectorLengthSquared(dir) < Square(10)) {
			goal->entitynum = i;
			return;
		}
	}
}

/*
==================
BotSetEntityNumForGoal
==================
*/
void BotSetEntityNumForGoal(bot_goal_t *goal, char *classname) {
	gentity_t *ent;
	int i;
	vec3_t dir;

	ent = &g_entities[0];
	for (i = 0; i < level.num_entities; i++, ent++) {
		if ( !ent->inuse ) {
			continue;
		}
		if ( !Q_stricmp(ent->classname, classname) ) {
			continue;
		}
		VectorSubtract(goal->origin, ent->s.origin, dir);
		if (VectorLengthSquared(dir) < Square(10)) {
			goal->entitynum = i;
			return;
		}
	}
}

/*
==================
BotGoalForBSPEntity
==================
*/
int BotGoalForBSPEntity( char *classname, bot_goal_t *goal ) {
	char value[MAX_INFO_STRING];
	vec3_t origin, start, end;
	int ent, numareas, areas[10];

	memset(goal, 0, sizeof(bot_goal_t));
	for (ent = trap_AAS_NextBSPEntity(0); ent; ent = trap_AAS_NextBSPEntity(ent)) {
		if (!trap_AAS_ValueForBSPEpairKey(ent, "classname", value, sizeof(value)))
			continue;
		if (!strcmp(value, classname)) {
			if (!trap_AAS_VectorForBSPEpairKey(ent, "origin", origin))
				return qfalse;
			VectorCopy(origin, goal->origin);
			VectorCopy(origin, start);
			start[2] -= 32;
			VectorCopy(origin, end);
			end[2] += 32;
			numareas = trap_AAS_TraceAreas(start, end, areas, NULL, 10);
			if (!numareas)
				return qfalse;
			goal->areanum = areas[0];
			return qtrue;
		}
	}
	return qfalse;
}

/*
==================
JUHOX: BotCreateItemGoal
==================
*/
void BotCreateItemGoal(gentity_t* ent, bot_goal_t* goal) {
	memset(goal, 0, sizeof(*goal));
	goal->entitynum = ent->s.number;
	VectorSet(goal->mins, -8, -8, -8);
	VectorSet(goal->maxs, 8, 8, 8);
	VectorCopy(ent->s.pos.trBase, goal->origin);
	goal->flags = GFL_ITEM;
	if (ent->flags & FL_DROPPED_ITEM) {
		goal->flags |= GFL_DROPPED;
		if (ent->item->giType == IT_ARMOR && ent->item->giTag) goal->origin[2] += 8;
	}
	//trap_SnapVector(goal->origin);
	goal->areanum = BotPointAreaNum(goal->origin);
}

/*
==================
BotSetupDeathmatchAI
==================
*/
void BotSetupDeathmatchAI(void) {
	int ent, modelnum;
	char model[128];

	gametype = trap_Cvar_VariableIntegerValue("g_gametype");
	maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");

	trap_Cvar_Register(&bot_rocketjump, "bot_rocketjump", "1", 0);
	trap_Cvar_Register(&bot_grapple, "bot_grapple", "0", 0);
	trap_Cvar_Register(&bot_fastchat, "bot_fastchat", "0", 0);
	trap_Cvar_Register(&bot_nochat, "bot_nochat", "0", 0);
	trap_Cvar_Register(&bot_testrchat, "bot_testrchat", "0", 0);
	trap_Cvar_Register(&bot_challenge, "bot_challenge", "0", 0);
	trap_Cvar_Register(&bot_predictobstacles, "bot_predictobstacles", "1", 0);
	trap_Cvar_Register(&g_spSkill, "g_spSkill", "2", 0);
	//
	// JUHOX BUGFIX: the original flag initializing code didn't work correctly sometimes when
	// restarting the game.

	if (gametype == GT_CTF) BotFindCTFBases();

	max_bspmodelindex = 0;
	for (ent = trap_AAS_NextBSPEntity(0); ent; ent = trap_AAS_NextBSPEntity(ent)) {
		if (!trap_AAS_ValueForBSPEpairKey(ent, "model", model, sizeof(model))) continue;
		if (model[0] == '*') {
			modelnum = atoi(model+1);
			if (modelnum > max_bspmodelindex)
				max_bspmodelindex = modelnum;
		}
	}
	//initialize the waypoint heap
	BotInitWaypoints();
}

/*
==================
BotShutdownDeathmatchAI
==================
*/
void BotShutdownDeathmatchAI(void) {
	altroutegoals_setup = qfalse;
}

