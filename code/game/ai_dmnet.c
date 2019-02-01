// Copyright (C) 1999-2000 Id Software, Inc.
//

/*****************************************************************************
 * name:		ai_dmnet.c
 *
 * desc:		Quake3 bot AI
 *
 * $Archive: /MissionPack/code/game/ai_dmnet.c $
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
//data file headers
#include "chars.h"			//characteristics
#include "inv.h"			//indexes into the inventory
#include "syn.h"			//synonyms
#include "match.h"			//string matching types and vars

// for the voice chats
#include "../../ui/menudef.h"

//goal flag, see be_ai_goal.h for the other GFL_*
#define GFL_AIR			128

int numnodeswitches;
char nodeswitch[MAX_NODESWITCHES+1][144];

#define LOOKAHEAD_DISTANCE			300

/*
==================
BotResetNodeSwitches
==================
*/
void BotResetNodeSwitches(void) {
	numnodeswitches = 0;
}

/*
==================
BotDumpNodeSwitches
==================
*/
void BotDumpNodeSwitches(bot_state_t *bs) {
	int i;
	char netname[MAX_NETNAME];

	ClientName(bs->client, netname, sizeof(netname));
	BotAI_Print(PRT_MESSAGE, "%s at %1.1f switched more than %d AI nodes\n", netname, FloatTime(), MAX_NODESWITCHES);
	for (i = 0; i < numnodeswitches; i++) {
		BotAI_Print(PRT_MESSAGE, nodeswitch[i]);
	}
	BotAI_Print(PRT_FATAL, "");
}

/*
==================
BotRecordNodeSwitch
==================
*/
void BotRecordNodeSwitch(bot_state_t *bs, char *node, char *str, char *s) {
	char netname[MAX_NETNAME];

	ClientName(bs->client, netname, sizeof(netname));
	Com_sprintf(nodeswitch[numnodeswitches], 144, "%s at %2.1f entered %s: %s from %s\n", netname, FloatTime(), node, str, s);
#ifdef DEBUG
	if (0) {
		BotAI_Print(PRT_MESSAGE, nodeswitch[numnodeswitches]);
	}
#endif //DEBUG
#if JUHOX_BOT_DEBUG
	if (bs->debugThisBot) {
		BotAI_Print(PRT_MESSAGE, nodeswitch[numnodeswitches]);
	}
#endif
	numnodeswitches++;
}

/*
==================
BotGetAirGoal
==================
*/
int BotGetAirGoal(bot_state_t *bs, bot_goal_t *goal) {
	bsp_trace_t bsptrace;
	vec3_t end, mins = {-15, -15, -2}, maxs = {15, 15, 2};
	int areanum;

	//trace up until we hit solid
	VectorCopy(bs->origin, end);
	end[2] += 1000;
	BotAI_Trace(&bsptrace, bs->origin, mins, maxs, end, bs->entitynum, CONTENTS_SOLID|CONTENTS_PLAYERCLIP);
	//trace down until we hit water
	VectorCopy(bsptrace.endpos, end);
	BotAI_Trace(&bsptrace, end, mins, maxs, bs->origin, bs->entitynum, CONTENTS_WATER|CONTENTS_SLIME|CONTENTS_LAVA);
	//if we found the water surface
	if (bsptrace.fraction > 0) {
		areanum = BotPointAreaNum(bsptrace.endpos);
		if (areanum) {
			VectorCopy(bsptrace.endpos, goal->origin);
			goal->origin[2] -= 2;
			goal->areanum = areanum;
			goal->mins[0] = -15;
			goal->mins[1] = -15;
			goal->mins[2] = -1;
			goal->maxs[0] = 15;
			goal->maxs[1] = 15;
			goal->maxs[2] = 1;
			goal->flags = GFL_AIR;
			goal->number = 0;
			goal->iteminfo = 0;
			goal->entitynum = 0;
			return qtrue;
		}
	}
	return qfalse;
}

/*
==================
BotGoForAir
==================
*/
int BotGoForAir(bot_state_t *bs, int tfl, bot_goal_t *ltg, float range) {
	bot_goal_t goal;

	//if the bot needs air
	if (bs->lastair_time < FloatTime() - 6) {
		//
#ifdef DEBUG
		//BotAI_Print(PRT_MESSAGE, "going for air\n");
#endif //DEBUG
		//if we can find an air goal
		if (BotGetAirGoal(bs, &goal)) {
			trap_BotPushGoal(bs->gs, &goal);
			return qtrue;
		}
		else {
			//get a nearby goal outside the water
			while(trap_BotChooseNBGItem(bs->gs, bs->origin, bs->inventory, tfl, ltg, range)) {
				trap_BotGetTopGoal(bs->gs, &goal);
				//if the goal is not in water
				if (!(trap_AAS_PointContents(goal.origin) & (CONTENTS_WATER|CONTENTS_SLIME|CONTENTS_LAVA))) {
					return qtrue;
				}
				trap_BotPopGoal(bs->gs);
			}
			trap_BotResetAvoidGoals(bs->gs);
		}
	}
	return qfalse;
}

/*
==================
JUHOX: BotCheckForWeaponJump
==================
*/
void BotCheckForWeaponJump(bot_state_t* bs, bot_moveresult_t* moveresult) {
	if (moveresult->flags & MOVERESULT_MOVEMENTWEAPON) {
		if (moveresult->weapon == WP_ROCKET_LAUNCHER) {
			if (bs->cur_ps.ammo[WP_RAILGUN] > 0 && bs->cur_ps.stats[STAT_STRENGTH] > LOW_STRENGTH_VALUE) {
				moveresult->weapon = WP_RAILGUN;
				if (!bs->railgunJump_ordertime) {
					bs->railgunJump_ordertime = FloatTime();
					bs->railgunJump_jumptime = 0;
				}
			}
		}
	}
	else if (bs->railgunJump_ordertime && !bs->railgunJump_jumptime) {
		bs->railgunJump_ordertime = 0;
	}
}

/*
==================
JUHOX: BotRememberLTGItemUnreachable
==================
*/
void BotRememberLTGItemUnreachable(bot_state_t* bs, int entitynum) {
	int i;
	int oldestEntry;
	float oldestEntryTime;

	oldestEntry = -1;
	oldestEntryTime = FloatTime();
	for (i = 0; i < LTG_ITEM_MEMORY_SIZE; i++) {
		if (bs->ltg_item_memory.entryTab[i].entitynum == entitynum) {
			bs->ltg_item_memory.entryTab[i].unreachable_time = FloatTime();
			return;
		}
		if (bs->ltg_item_memory.entryTab[i].unreachable_time < oldestEntryTime) {
			oldestEntryTime = bs->ltg_item_memory.entryTab[i].unreachable_time;
			oldestEntry = i;
		}
	}
	if (oldestEntry < 0) oldestEntry = rand() % LTG_ITEM_MEMORY_SIZE;
	bs->ltg_item_memory.entryTab[oldestEntry].entitynum = entitynum;
	bs->ltg_item_memory.entryTab[oldestEntry].unreachable_time = FloatTime();
}

/*
==================
JUHOX: BotMayLTGItemBeReachable
==================
*/
qboolean BotMayLTGItemBeReachable(bot_state_t* bs, int entitynum) {
	int i;

	for (i = 0; i < LTG_ITEM_MEMORY_SIZE; i++) {
		if (bs->ltg_item_memory.entryTab[i].entitynum == entitynum) {
			if (bs->ltg_item_memory.entryTab[i].unreachable_time > FloatTime() - 30) {
				return qfalse;
			}
			else {
				return qtrue;
			}
		}
	}
	return qtrue;

}

/*
==================
JUHOX: BotRememberNBGNotAvailable
==================
*/
void BotRememberNBGNotAvailable(bot_state_t* bs, int entitynum) {
	int i;
	int oldestEntry;
	float oldestEntryTime;

	oldestEntry = -1;
	oldestEntryTime = FloatTime();
	for (i = 0; i < NBGHISTORY_SIZE; i++) {
		if (bs->nbg_history.entryTab[i].entitynum == entitynum) {
			bs->nbg_history.entryTab[i].time = FloatTime();
			return;
		}
		if (bs->nbg_history.entryTab[i].time < oldestEntryTime) {
			oldestEntryTime = bs->nbg_history.entryTab[i].time;
			oldestEntry = i;
		}
	}
	if (oldestEntry < 0) oldestEntry = rand() % NBGHISTORY_SIZE;
	bs->nbg_history.entryTab[oldestEntry].entitynum = entitynum;
	bs->nbg_history.entryTab[oldestEntry].time = FloatTime();
}

/*
==================
JUHOX: BotRememberNBGAvailable
==================
*/
void BotRememberNBGAvailable(bot_state_t* bs, int entitynum) {
	int i;

	for (i = 0; i < NBGHISTORY_SIZE; i++) {
		if (bs->nbg_history.entryTab[i].entitynum == entitynum) {
			bs->nbg_history.entryTab[i].entitynum = 0;
			bs->nbg_history.entryTab[i].time = 0;
			return;
		}
	}
}

/*
==================
JUHOX: BotMayNBGBeAvailable
==================
*/
qboolean BotMayNBGBeAvailable(bot_state_t* bs, int entitynum) {
	int i;

	for (i = 0; i < NBGHISTORY_SIZE; i++) {
		if (bs->nbg_history.entryTab[i].entitynum == entitynum) {
			if (bs->nbg_history.entryTab[i].time > FloatTime() - 20) {
				return qfalse;
			}
			else {
				return qtrue;
			}
		}
	}
	return qtrue;
}

/*
==================
JUHOX: BotChooseNearbyItem

range<0 means "any item at any range"
==================
*/
static int BotChooseNearbyItem(bot_state_t* bs, bot_goal_t* goal, float range) {
	static gclient_t* competitors[MAX_CLIENTS];
	static vec3_t mins = {-15,-15,-15};
	static vec3_t maxs = {15,15,15};
	int numCompetitors;
	int currentEntity;
	qboolean collectArmor;
	qboolean collectLimitedHealth;
	qboolean collectUnlimitedHealth;
	qboolean collectHoldableItem;
	qboolean collectStrengthRegeneration;
	int bestTravelTime;
	float bestDistance;
	gitem_t* foundItem;
	gentity_t* foundEntity;
	vec3_t refOrigin;

	bs->getImportantNBGItem = qfalse;
	bs->nbgGivesPODMarker = qfalse;
	numCompetitors = 0;

	if (range < 0) {
		collectArmor = qtrue;
		collectLimitedHealth = qtrue;
		collectUnlimitedHealth = qtrue;
		collectHoldableItem = qtrue;
		collectStrengthRegeneration = qtrue;
		goto SearchItems;
	}

	VectorCopy(bs->origin, refOrigin);
	if (bs->ltgtype == LTG_TEAMHELP && BotPlayerDanger(&bs->cur_ps) < 25) {
		playerState_t ps;

		if (BotAI_GetClientState(bs->teammate, &ps)) {
			if (ps.stats[STAT_HEALTH] > 0) {
				if (DistanceSquared(bs->origin, ps.origin) > Square(600)) return qfalse;
			}
		}
		VectorCopy(ps.origin, refOrigin);
	}

	collectArmor = BotArmorIsUsefulForPlayer(&bs->cur_ps);
	collectLimitedHealth = BotLimitedHealthIsUsefulForPlayer(&bs->cur_ps);
	collectUnlimitedHealth = BotUnlimitedHealthIsUsefulForPlayer(&bs->cur_ps);
	collectHoldableItem = BotHoldableItemIsUsefulForPlayer(&bs->cur_ps);
	collectStrengthRegeneration = qtrue;
	if (
		g_gametype.integer >= GT_TEAM &&
		BotPlayerDanger(&bs->cur_ps) < 75
	) {
		playerState_t ps;
		int teammate;
		int killDamage;

		killDamage = BotPlayerKillDamage(&bs->cur_ps);
		if (bs->cur_ps.powerups[PW_REDFLAG] || bs->cur_ps.powerups[PW_BLUEFLAG]) killDamage -= 50;
		for (teammate = -1; (teammate = BotGetNextTeamMate(bs, teammate, &ps)) >= 0;) {
			int kd;

			if (ps.stats[STAT_HEALTH] <= 0) continue;
			if (ps.powerups[PW_SHIELD]) continue;
			kd = BotPlayerKillDamage(&ps);
			if (ps.powerups[PW_REDFLAG] || ps.powerups[PW_BLUEFLAG]) kd -= 50;
			if (kd > killDamage) continue;

			if (kd == killDamage) {
				competitors[numCompetitors++] = &level.clients[teammate];
				continue;
			}

			if (bs->cur_ps.stats[STAT_HEALTH] < bs->cur_ps.stats[STAT_MAX_HEALTH]) {
				if (DistanceSquared(bs->origin, ps.origin) > 600.0*600.0) continue;
			}
			else {
				if (DistanceSquared(bs->origin, ps.origin) > 1500.0*1500.0) continue;
			}
			if (!BotEntityVisible(&bs->cur_ps, 360, teammate)) continue;

			if (BotArmorIsUsefulForPlayer(&ps)) collectArmor = qfalse;
			if (BotLimitedHealthIsUsefulForPlayer(&ps)) collectLimitedHealth = qfalse;
			if (BotUnlimitedHealthIsUsefulForPlayer(&ps)) collectUnlimitedHealth = qfalse;
			if (BotHoldableItemIsUsefulForPlayer(&ps)) collectHoldableItem = qfalse;
			if (ps.stats[STAT_STRENGTH] < bs->cur_ps.stats[STAT_STRENGTH]) collectStrengthRegeneration = qfalse;
		}
	}

	if (
		!collectArmor && !collectLimitedHealth &&
		!collectUnlimitedHealth && !collectHoldableItem &&
		gametype < GT_STU &&
		(
			gametype != GT_CTF ||
			(
				!g_respawnAtPOD.integer &&
				Team_GetFlagStatus(TEAM_RED) != FLAG_DROPPED &&
				Team_GetFlagStatus(TEAM_BLUE) != FLAG_DROPPED &&
				!bs->cur_ps.powerups[PW_REDFLAG] &&
				!bs->cur_ps.powerups[PW_BLUEFLAG]
			)
		)
	) {
		return qfalse;
	}

	SearchItems:
	foundItem = NULL;
	foundEntity = NULL;
	if (range < 0) {
		bestTravelTime = 1000000;
	}
	else {
		bestTravelTime = 2 * range * 0.500;	// unit: 1/100th second
	}
	bestDistance = 100000;	// to choose between near items with same travel time
	for (currentEntity = MAX_CLIENTS; currentEntity < level.num_entities; currentEntity++) {
		gentity_t* ent;
		gitem_t* item;
		bot_goal_t potentialGoal;
		qboolean preciousItem;
		qboolean teamItem;
		qboolean enemyFlag;
		qboolean artefact;
		float distance;
		float itemRange;
		vec3_t floor;
		trace_t trace;
		int travelTime1;
		int travelTime2;
		int totalTravelTime;
		int competitor;

		ent = &g_entities[currentEntity];
		if (!ent->inuse) goto NextEntity;
		if (ent->s.eType != ET_ITEM) goto NextEntity;
		if (ent->s.pos.trType != TR_STATIONARY) goto NextEntity;

		item = ent->item;
		if (!item) goto NextEntity;

		preciousItem = qfalse;
		teamItem = qfalse;
		enemyFlag = qfalse;
		artefact = qfalse;
		itemRange = range;
		switch (item->giType) {
		case IT_ARMOR:
			if (!collectArmor) goto NextEntity;
			if (item->quantity >= 50) preciousItem = qtrue;
			break;
		case IT_HEALTH:
			if (item->quantity > 5 && item->quantity < 100) {
				if (!collectLimitedHealth) goto NextEntity;
				if (
					bs->cur_ps.stats[STAT_HEALTH] < 0.8 * bs->cur_ps.stats[STAT_MAX_HEALTH] ||
					bs->cur_ps.powerups[PW_CHARGE]
				) {
					preciousItem = qtrue;
				}
			}
			else {
				if (!collectUnlimitedHealth) goto NextEntity;
				if (item->quantity >= 100) preciousItem = qtrue;
			}
			break;
		case IT_HOLDABLE:
			if (!collectHoldableItem) goto NextEntity;
			if (item->giTag == HI_MEDKIT) preciousItem = qtrue;
			break;
		case IT_POWERUP:
			if (!collectUnlimitedHealth) goto NextEntity;
			if (!collectStrengthRegeneration) goto NextEntity;
			preciousItem = qtrue;
			break;
		case IT_TEAM:
			if (gametype == GT_STU) {
				if (item->giTag != PW_QUAD) goto NextEntity;
				if (
					// ensure the "team works together" condition for unlimited artefacts
					g_artefacts.integer >= 999 &&
					bs->cur_ps.persistant[PERS_SCORE] > level.clients[level.sortedClients[level.numPlayingClients-1]].ps.persistant[PERS_SCORE] &&
					bs->cur_ps.persistant[PERS_SCORE] + 1000 > 2 * level.clients[level.sortedClients[level.numPlayingClients-1]].ps.persistant[PERS_SCORE]
				) {
					goto NextEntity;
				}
				artefact = qtrue;
				itemRange = 400;
				// NOTE: the artefact is not marked precious because the bot can't know its position
				break;
			}

			if (gametype < GT_CTF) goto NextEntity;
			preciousItem = qtrue;
			teamItem = qtrue;
			switch (bs->cur_ps.persistant[PERS_TEAM]) {
			case TEAM_RED:
				enemyFlag = (item->giTag == PW_BLUEFLAG);
				break;
			case TEAM_BLUE:
				enemyFlag = (item->giTag == PW_REDFLAG);
				break;
			default:
				enemyFlag = qfalse;
				break;
			}
			break;
		case IT_POD_MARKER:
			if (ent->s.otherEntityNum2 == bs->cur_ps.persistant[PERS_TEAM]) goto NextEntity;
			if (BotPlayerDanger(&bs->cur_ps) > 30) goto NextEntity;
			if (ent->s.time - level.time > 10000) goto NextEntity;
			if (bs->ltgtype > 0 && ent->s.time - level.time > 5000) goto NextEntity;
			if (bs->enemy >= 0 && ent->s.time - level.time > 3000) goto NextEntity;
			break;
		default:
			goto NextEntity;
		}

		if (
			range >= 0 &&
			bs->teleport_time > FloatTime() - 5 &&
			DistanceSquared(ent->r.currentOrigin, bs->teleport_origin) < 100.0*100.0
		) {
			goto NextEntity;
		}

		if (range < 0) {
			if (ent->flags & FL_DROPPED_ITEM) goto NextEntity;
			if (DistanceSquared(bs->origin, ent->s.pos.trBase) < Square(100)) goto NextEntity;

			BotCreateItemGoal(ent, &potentialGoal);
			if (potentialGoal.areanum <= 0) goto NextEntity;

			VectorCopy(ent->s.pos.trBase, floor);
			floor[2] -= 50;
			trap_Trace(&trace, ent->s.pos.trBase, mins, maxs, floor, currentEntity, MASK_SOLID | CONTENTS_LAVA | CONTENTS_SLIME);
			if (trace.contents & (CONTENTS_LAVA|CONTENTS_SLIME)) goto NextEntity;
			if (trace.fraction >= 1) goto NextEntity;

			distance = Distance(refOrigin, potentialGoal.origin);
		}
		else if (
			preciousItem && !(ent->flags & FL_DROPPED_ITEM) &&
			(
				bs->ltgtype != LTG_RUSHBASE ||
				BotOwnFlagStatus(bs) != FLAG_ATBASE
			)
		) {
			if (
				teamItem && !enemyFlag &&
				!bs->cur_ps.powerups[PW_REDFLAG] && !bs->cur_ps.powerups[PW_BLUEFLAG]
			) {
				goto NextEntity;
			}

			distance = Distance(refOrigin, ent->s.pos.trBase);
			/*
			if (bs->ltgtype == LTG_TEAMHELP) {
				float d;

				d = Distance(bs->teamgoal.origin, ent->r.currentOrigin);
				if (d < distance) distance = d;
			}
			*/
			if (distance > range) goto NextEntity;

			BotCreateItemGoal(ent, &potentialGoal);
			if (potentialGoal.areanum <= 0) goto NextEntity;

			VectorCopy(ent->s.pos.trBase, floor);
			floor[2] -= 50;
			trap_Trace(&trace, ent->s.pos.trBase, mins, maxs, floor, currentEntity, MASK_SOLID | CONTENTS_LAVA | CONTENTS_SLIME);
			if (trace.contents & (CONTENTS_LAVA|CONTENTS_SLIME)) goto NextEntity;
			if (trace.fraction >= 1) goto NextEntity;

			trap_Trace(&trace, bs->eye, NULL, NULL, potentialGoal.origin, bs->client, MASK_SHOT);
			if (trace.fraction >= 1) {
				if (!ent->r.linked || (ent->s.eFlags & EF_NODRAW)) {
					BotRememberNBGNotAvailable(bs, potentialGoal.entitynum);
					goto NextEntity;
				}
				BotRememberNBGAvailable(bs, potentialGoal.entitynum);
			}
			else {
				if (!BotMayNBGBeAvailable(bs, potentialGoal.entitynum)) goto NextEntity;

				if (trap_BotItemGoalInVisButNotVisible(bs->entitynum, bs->eye, bs->viewangles, &potentialGoal)) {
					BotRememberNBGNotAvailable(bs, potentialGoal.entitynum);
					goto NextEntity;
				}
			}
		}
		else {
			if (!ent->r.linked) goto NextEntity;
			if (ent->s.eFlags & EF_NODRAW) goto NextEntity;

			distance = Distance(refOrigin, ent->r.currentOrigin);
			/*
			if (bs->ltgtype == LTG_TEAMHELP) {
				float d;

				d = Distance(bs->teamgoal.origin, ent->r.currentOrigin);
				if (d < distance) distance = d;
			}
			*/
			if (distance > itemRange) goto NextEntity;

			if (distance > 60 && !artefact && BotEntityVisible(&bs->cur_ps, 90, currentEntity) <= 0) goto NextEntity;
			/*
			trap_Trace(&trace, bs->eye, NULL, NULL, potentialGoal.origin, bs->client, MASK_SHOT);
			if (trace.fraction < 1) goto NextLocation;
			*/

			BotCreateItemGoal(ent, &potentialGoal);
			if (potentialGoal.areanum <= 0) goto NextEntity;
			if (!trap_AAS_AreaReachability(potentialGoal.areanum)) goto NextEntity;	// don't know exactly what this function does

			if (artefact) goto GetImportantNBG;

			VectorCopy(goal->origin, floor);
			floor[2] -= 50;
			trap_Trace(&trace, goal->origin, mins, maxs, floor, currentEntity, MASK_SOLID | CONTENTS_LAVA | CONTENTS_SLIME);
			if (trace.contents & (CONTENTS_LAVA|CONTENTS_SLIME)) goto NextEntity;
			if (trace.fraction >= 1) goto NextEntity;

			BotRememberNBGAvailable(bs, currentEntity);
		}

		travelTime1 = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, potentialGoal.areanum, bs->tfl);
		if (travelTime1 <= 0) goto NextEntity;
		travelTime2 = trap_AAS_AreaTravelTimeToGoalArea(potentialGoal.areanum, potentialGoal.origin, bs->areanum, bs->tfl);
		if (travelTime2 <= 0) goto NextEntity;

		if (teamItem) {
			GetImportantNBG:
			bs->getImportantNBGItem = qtrue;
			memcpy(goal, &potentialGoal, sizeof(potentialGoal));
			trap_BotPushGoal(bs->gs, goal);
			foundItem = item;
			foundEntity = ent;
			goto SetItemCharacteristics;
		}

		totalTravelTime = travelTime1 + travelTime2;
		if (totalTravelTime - 50 > bestTravelTime) goto NextEntity;
		if (totalTravelTime + 50 > bestTravelTime && distance >= bestDistance) goto NextEntity;

		for (competitor = 0; competitor < numCompetitors; competitor++) {
			vec_t compDist;

			compDist = Distance(competitors[competitor]->ps.origin, potentialGoal.origin);
			if (compDist < 50) goto NextEntity;
			if (potentialGoal.flags & GFL_DROPPED) {
				if (!BotEntityVisible(&competitors[competitor]->ps, 90, potentialGoal.entitynum)) continue;
			}
			if (compDist < distance) goto NextEntity;
		}

		if (
			g_gametype.integer >= GT_STU &&
			!IsPlayerInvolvedInFighting(bs->client) &&
			G_IsMonsterNearEntity(&g_entities[bs->client], ent)
		) {
			BotRememberNBGNotAvailable(bs, ent->s.number);
			goto NextEntity;
		}

		bestTravelTime = totalTravelTime;
		bestDistance = distance;
		memcpy(goal, &potentialGoal, sizeof(potentialGoal));
		foundItem = item;
		foundEntity = ent;

		NextEntity:;
	}

	if (foundItem) trap_BotPushGoal(bs->gs, goal);

	SetItemCharacteristics:
	if (foundItem) {
		bs->nbgEntity = foundEntity;

		switch (foundItem->giType) {
		case IT_ARMOR:
			bs->nbgGivesArmor = qtrue;
			bs->nbgGivesLimitedHealth = qfalse;
			bs->nbgGivesUnlimitedHealth = qfalse;
			bs->nbgGivesHoldableItem = qfalse;
			bs->nbgGivesStrength = qfalse;
			bs->nbgGivesFlag = qfalse;
			break;
		case IT_HEALTH:
			bs->nbgGivesArmor = qfalse;
			bs->nbgGivesHoldableItem = qfalse;
			bs->nbgGivesStrength = qfalse;
			bs->nbgGivesFlag = qfalse;
			if (foundItem->quantity > 5 && foundItem->quantity < 100) {
				bs->nbgGivesLimitedHealth = qtrue;
				bs->nbgGivesUnlimitedHealth = qfalse;
			}
			else {
				bs->nbgGivesLimitedHealth = qfalse;
				bs->nbgGivesUnlimitedHealth = qtrue;
			}
			break;
		case IT_HOLDABLE:
			bs->nbgGivesArmor = qfalse;
			bs->nbgGivesLimitedHealth = qfalse;
			bs->nbgGivesUnlimitedHealth = qfalse;
			bs->nbgGivesHoldableItem = qtrue;
			bs->nbgGivesStrength = qfalse;
			bs->nbgGivesFlag = qfalse;
			break;
		case IT_POWERUP:
			bs->nbgGivesArmor = qfalse;
			bs->nbgGivesLimitedHealth = qfalse;
			bs->nbgGivesUnlimitedHealth = qtrue;
			bs->nbgGivesHoldableItem = qfalse;
			bs->nbgGivesStrength = qtrue;
			bs->nbgGivesFlag = qfalse;
			break;
		case IT_TEAM:
			bs->nbgGivesArmor = qfalse;
			bs->nbgGivesLimitedHealth = qfalse;
			bs->nbgGivesUnlimitedHealth = qfalse;
			bs->nbgGivesHoldableItem = qfalse;
			bs->nbgGivesStrength = qfalse;
			bs->nbgGivesFlag = (foundItem->giTag != PW_QUAD);

			break;
		case IT_POD_MARKER:
			bs->nbgGivesArmor = qfalse;
			bs->nbgGivesLimitedHealth = qfalse;
			bs->nbgGivesUnlimitedHealth = qfalse;
			bs->nbgGivesHoldableItem = qfalse;
			bs->nbgGivesStrength = qfalse;
			bs->nbgGivesFlag = qfalse;
			bs->nbgGivesPODMarker = qtrue;
			break;
		default:
			G_Error("BUG! BotChooseNearbyItem: found item type #%d (%s)", foundItem->giType, foundItem->classname);
			break;
		}
	}
	return foundItem != NULL;
}

/*
==================
BotNearbyGoal
==================
*/
int BotNearbyGoal(bot_state_t *bs, int tfl, bot_goal_t *ltg, float range) {
	int ret;

	if (range <= 0) return BotChooseNearbyItem(bs, ltg, range);	// JUHOX
	//check if the bot should go for air
	if (BotGoForAir(bs, tfl, ltg, range)) return qtrue;

	// JUHOX: new NBG item choosing strategy
	if (bs->teleport_time > FloatTime() - 3 && !BotWantsToRetreat(bs)) return qfalse;
	ret = BotChooseNearbyItem(bs, ltg, range);

	return ret;
}

/*
==================
JUHOX: BotCheckNBG
==================
*/
static int BotCheckNBG(bot_state_t* bs, bot_goal_t* goal) {
	qboolean collectArmor;
	qboolean collectLimitedHealth;
	qboolean collectUnlimitedHealth;
	qboolean collectHoldableItem;
	qboolean collectStrengthRegeneration;

	if (bs->getImportantNBGItem || bs->nbgGivesFlag) return qtrue;

	if (bs->nbgGivesPODMarker) {
		int teammate;
		playerState_t ps;

		if (BotPlayerDanger(&bs->cur_ps) > 50) return qfalse;

		for (teammate = -1; (teammate = BotGetNextTeamMate(bs, teammate, &ps)) >= 0;) {
			if (ps.stats[STAT_HEALTH] <= 0) continue;
			if (DistanceSquared(ps.origin, goal->origin) < 50*50) return qfalse;
		}
		return qtrue;
	}

	if (bs->cur_ps.powerups[PW_SHIELD]) return qfalse;

	collectArmor = (bs->nbgGivesArmor && BotArmorIsUsefulForPlayer(&bs->cur_ps));
	collectLimitedHealth = (bs->nbgGivesLimitedHealth && BotLimitedHealthIsUsefulForPlayer(&bs->cur_ps));
	collectUnlimitedHealth = (bs->nbgGivesUnlimitedHealth && BotUnlimitedHealthIsUsefulForPlayer(&bs->cur_ps));
	collectHoldableItem = (bs->nbgGivesHoldableItem && BotHoldableItemIsUsefulForPlayer(&bs->cur_ps));
	collectStrengthRegeneration = bs->nbgGivesStrength;
	if (
		!collectArmor &&
		!collectLimitedHealth &&
		!collectUnlimitedHealth &&
		!collectHoldableItem &&
		!collectStrengthRegeneration
	) {
		return qfalse;
	}

	if (BotPlayerDanger(&bs->cur_ps) < 75) {
		playerState_t ps;
		int teammate;
		int killDamage;

		killDamage = BotPlayerKillDamage(&bs->cur_ps) - 10;
		if (bs->cur_ps.powerups[PW_REDFLAG] || bs->cur_ps.powerups[PW_BLUEFLAG]) killDamage -= 50;
		for (teammate = -1; (teammate = BotGetNextTeamMate(bs, teammate, &ps)) >= 0;) {
			int kd;

			if (ps.stats[STAT_HEALTH] <= 0) continue;
			if (ps.powerups[PW_SHIELD]) continue;
			kd = BotPlayerKillDamage(&ps);
			if (ps.powerups[PW_REDFLAG] || ps.powerups[PW_BLUEFLAG]) kd -= 50;
			if (kd >= killDamage) continue;

			if (bs->cur_ps.stats[STAT_HEALTH] < bs->cur_ps.stats[STAT_MAX_HEALTH]) {
				if (DistanceSquared(bs->origin, ps.origin) > 600.0*600.0) continue;
				if (!BotEntityVisible(&bs->cur_ps, 360, teammate)) continue;
			}
			else {
				if (DistanceSquared(bs->origin, ps.origin) > 1500.0*1500.0) continue;
			}

			if (collectArmor && BotArmorIsUsefulForPlayer(&ps)) collectArmor = qfalse;
			if (collectLimitedHealth && BotLimitedHealthIsUsefulForPlayer(&ps)) collectLimitedHealth = qfalse;
			if (collectUnlimitedHealth && BotUnlimitedHealthIsUsefulForPlayer(&ps)) collectUnlimitedHealth = qfalse;
			if (collectHoldableItem && BotHoldableItemIsUsefulForPlayer(&ps)) collectHoldableItem = qfalse;
			if (ps.stats[STAT_STRENGTH] < bs->cur_ps.stats[STAT_STRENGTH]) collectStrengthRegeneration = qfalse;
		}
	}

	if (
		!collectArmor &&
		!collectLimitedHealth &&
		!collectUnlimitedHealth &&
		!collectHoldableItem &&
		!collectStrengthRegeneration
	) {
		return qfalse;
	}

	if (
		g_gametype.integer == GT_STU &&
		g_cloakingDevice.integer &&
		!IsPlayerInvolvedInFighting(bs->client) &&
		bs->nbgEntity &&
		G_IsMonsterNearEntity(&g_entities[bs->client], bs->nbgEntity)
	) {
		BotRememberNBGNotAvailable(bs, bs->nbgEntity->s.number);
		return qfalse;
	}

	return qtrue;
}

/*
==================
JUHOX: FindEscapeGoal
==================
*/
qboolean FindEscapeGoal(
	playerState_t* refugeePS, int refugeeArea, int refugeeTFL,
	int pursuerArea, vec3_t pursuerOrigin,
	bot_goal_t* goal
) {
	static char* itemNames[] = {
		"emergency"
		/*
		"Armor Shard",
		"Armor",
		"Heavy Armor",
		"5 Health",
		"25 Health",
		"50 Health",
		"Mega Health",
		"Regeneration",
		"Personal Teleporter",
		"Medkit",
		"Red Flag",
		"Blue Flag"
		*/
		/*
		"Gauntlet",
		"Shotgun",
		"Machinegun",
		"Grenade Launcher",
		"Rocket Launcher",
		"Lightning Gun",
		"Railgun",
		"Plasma Gun",
		"BFG10K",
		"Grappling Hook",
		"Shells",
		"Bullets",
		"Grenades",
		"Cells",
		"Lightning",
		"Rockets",
		"Slugs",
		"Bfg Ammo",
		"Quad Damage",
		"Battle Suit",
		"Speed",
		"Invisibility",
		"Flight",
		*/
	};
	const int numItems = sizeof(itemNames) / sizeof(itemNames[0]);
	int currentItemName;
	bot_goal_t potentialGoal;
	bot_goal_t nearestGoal;
	qboolean foundNearestGoal;
	int nearestGoalTravelTime;
	bot_goal_t bestGoal;
	qboolean foundBestGoal;
	int bestGoalTravelTime;	// pursuer travel time - refugee travel time (the higher the better)
	int refugeeHome;

	if (refugeeArea <= 0) return qfalse;
	if (pursuerArea <= 0) return qfalse;

	refugeeHome = -1;
	if (gametype == GT_CTF) {
		switch (refugeePS->persistant[PERS_TEAM]) {
		case TEAM_RED:
			refugeeHome = ctf_redflag.areanum;
			break;
		case TEAM_BLUE:
			refugeeHome = ctf_blueflag.areanum;
			break;
		}
	}

	if (!refugeeTFL)
	{
		vec3_t feet;

		refugeeTFL = TFL_DEFAULT;
		VectorCopy(refugeePS->origin, feet);
		feet[2] -= 23;
		if (trap_AAS_PointContents(feet) & (CONTENTS_LAVA|CONTENTS_SLIME)) refugeeTFL |= TFL_LAVA | TFL_SLIME;
	}

	foundNearestGoal = qfalse;
	nearestGoalTravelTime = 100000;
	foundBestGoal = qfalse;
	bestGoalTravelTime = 0;
	for (currentItemName = 0; currentItemName < numItems; currentItemName++) {
		char* itemname;
		int aLocation;

		itemname = itemNames[currentItemName];
		for (aLocation = -1; (aLocation = GetItemGoal(aLocation, itemname, &potentialGoal)) >= 0; ) {
			int refugeeTravelTime;
			int pursuerTravelTime;

			if (potentialGoal.areanum <= 0) continue;
			if (potentialGoal.flags & GFL_DROPPED) continue;
			if (!trap_AAS_AreaReachability(potentialGoal.areanum)) continue;

			refugeeTravelTime = trap_AAS_AreaTravelTimeToGoalArea(refugeeArea, refugeePS->origin, potentialGoal.areanum, refugeeTFL);
			if (refugeeTravelTime <= 0) continue;
			if (potentialGoal.areanum == refugeeHome) {
				int bonus;

				if (!refugeePS->powerups[PW_REDFLAG] && !refugeePS->powerups[PW_BLUEFLAG]) goto EnsureMinDistance;
				bonus = 200;
				if (refugeeTravelTime > 500) bonus += 1000;
				if (
					Team_GetFlagStatus(refugeePS->persistant[PERS_TEAM]) == FLAG_ATBASE ||
					!IsPlayerInvolvedInFighting(refugeePS->clientNum)
				) {
					bonus += 3000;
				}
				else if (refugeeTravelTime < 300) {
					bonus -= 500;
				}
				refugeeTravelTime -= bonus;
			}
			else {
				EnsureMinDistance:
				if (refugeeTravelTime < 300) continue;	// 300 = 3 seconds
			}

			if (refugeeTravelTime < nearestGoalTravelTime) {
				nearestGoalTravelTime = refugeeTravelTime;
				foundNearestGoal = qtrue;
				memcpy(&nearestGoal, &potentialGoal, sizeof(nearestGoal));
			}
			pursuerTravelTime = trap_AAS_AreaTravelTimeToGoalArea(pursuerArea, pursuerOrigin, potentialGoal.areanum, TFL_DEFAULT);
			if (pursuerTravelTime <= 0) pursuerTravelTime = 1000000;
			pursuerTravelTime -= refugeeTravelTime;
			if (pursuerTravelTime > bestGoalTravelTime) {
				bestGoalTravelTime = pursuerTravelTime;
				foundBestGoal = qtrue;
				memcpy(&bestGoal, &potentialGoal, sizeof(bestGoal));
			}
		}
	}

	if (foundBestGoal) {
		memcpy(goal, &bestGoal, sizeof(*goal));
		return qtrue;
	}
	if (foundNearestGoal) {
		memcpy(goal, &nearestGoal, sizeof(*goal));
		return qtrue;
	}
	return qfalse;
}

/*
==================
JUHOX: BotSetEscapeGoal
==================
*/
void BotSetEscapeGoal(bot_state_t* bs) {
	if (bs->enemy < 0) return;

	if (bs->ltgtype == 0) {
		if (
			FindEscapeGoal(
				&bs->cur_ps, bs->areanum, bs->tfl, bs->lastenemyareanum, bs->lastenemyorigin, &bs->teamgoal
			)
		) {
			int danger;

			bs->ltgtype = LTG_ESCAPE;
			danger = BotPlayerDanger(&bs->cur_ps);
			if (bs->cur_ps.powerups[PW_REDFLAG] || bs->cur_ps.powerups[PW_BLUEFLAG]) {
				bs->teamgoal_time = FloatTime() + 1 + random();
			}
			else {
				bs->teamgoal_time = FloatTime() + 3;
				if (danger > 0) bs->teamgoal_time += danger / 10.0;

				if (danger >= 50 && g_gametype.integer >= GT_TEAM) {
					trap_EA_SayTeam(bs->client, "HEEEEEEEELP MEEEEEEEE!");
				}
			}
		}
	}
}

/*
==================
BotReachedGoal
==================
*/
int BotReachedGoal(bot_state_t *bs, bot_goal_t *goal) {
	if (goal->flags & GFL_ITEM) {
        // JUHOX: if the item is a dropped item it may no longer exist
		if (goal->flags & GFL_DROPPED) {
			if (!g_entities[goal->entitynum].inuse) return qtrue;
			if (Distance(goal->origin, g_entities[goal->entitynum].r.currentOrigin) > 50) return qtrue;
		}

        // JUHOX: POD markers are never reached as long as they exist
		if (g_entities[goal->entitynum].item->giType == IT_POD_MARKER) return qfalse;

		//if touching the goal
		if (trap_BotTouchingGoal(bs->origin, goal)) {
			if (!(goal->flags & GFL_DROPPED)) {
				trap_BotSetAvoidGoalTime(bs->gs, goal->number, -1);
			}
			return qtrue;
		}
		//if the goal isn't there
		if (trap_BotItemGoalInVisButNotVisible(bs->entitynum, bs->eye, bs->viewangles, goal)) {
			return qtrue;
		}
		//if in the goal area and below or above the goal and not swimming
		if (bs->areanum == goal->areanum) {
			if (bs->origin[0] > goal->origin[0] + goal->mins[0] && bs->origin[0] < goal->origin[0] + goal->maxs[0]) {
				if (bs->origin[1] > goal->origin[1] + goal->mins[1] && bs->origin[1] < goal->origin[1] + goal->maxs[1]) {
					if (!trap_AAS_Swimming(bs->origin)) {
						return qtrue;
					}
				}
			}
		}
	}
	else if (goal->flags & GFL_AIR) {
		//if touching the goal
		if (trap_BotTouchingGoal(bs->origin, goal)) return qtrue;
		//if the bot got air
		if (bs->lastair_time > FloatTime() - 1) return qtrue;
	}
	else {
		//if touching the goal
		if (trap_BotTouchingGoal(bs->origin, goal)) return qtrue;
	}
	return qfalse;
}

/*
==================
JUHOX: BotCheckIfBlockingTeammates
==================
*/
void BotCheckIfBlockingTeammates(bot_state_t* bs) {
	float vis, dist;
	int i;
	vec3_t dir;
	playerState_t ps;
	float speed;
	vec3_t target;

	if (g_gametype.integer >= GT_TEAM) for (i = 0; i < MAX_CLIENTS; i++) {

		if (i == bs->client) continue;
		if (!BotAI_GetClientState(i, &ps)) continue;
		if (ps.stats[STAT_HEALTH] <= 0) continue;
		if (bs->cur_ps.persistant[PERS_TEAM] != ps.persistant[PERS_TEAM]) continue;
		if (ps.pm_type == PM_SPECTATOR) continue;
		//calculate distance and direction towards the team mate
		VectorSubtract(bs->origin, ps.origin, dir);
		dist = VectorLength(dir);
		if (dist >= 250) continue;
		if (ps.weaponstate < WEAPON_FIRING && dist >= 60) continue;
		//check if the team mate is visible
		vis = BotEntityVisible(&bs->cur_ps, 360, i);
		if (vis <= 0) continue;

		// seems we should go out of the way of this team mate
		//
		//initialize the movement state
		BotSetupForMovement(bs);
		// try to step away a bit
		if (VectorLengthSquared(ps.velocity) > 100) {
			vec3_t vel;
			vec3_t ndir;
			vec3_t c;

			VectorNormalize2(ps.velocity, vel);
			VectorNormalize2(dir, ndir);
			CrossProduct(vel, ndir, c);
			if (VectorLengthSquared(c) > 0.01) {
				CrossProduct(c, vel, dir);
			}
		}
		speed = bs->forceWalk? 200 : 400;
		if (!trap_BotMoveInDirection(bs->ms, dir, speed, MOVE_WALK)) {
			vec3_t up, sideward;

			PerpendicularVector(up, dir);
			CrossProduct(up, dir, sideward);

			// the following is taken from the improved BotAIBlocked() function
			if (bs->flags & BFL_AVOIDRIGHT) VectorNegate(sideward, sideward);

			if (!trap_BotMoveInDirection(bs->ms, sideward, speed, MOVE_WALK)) {
				bs->flags ^= BFL_AVOIDRIGHT;
				VectorNegate(sideward, sideward);
				if (!trap_BotMoveInDirection(bs->ms, sideward, speed, MOVE_WALK)) {
					if (VectorLengthSquared(bs->notblocked_dir) < 0.1) {
						vec3_t angles;

						VectorSet(angles, 0, 360 * random(), 0);
						AngleVectors(angles, dir, NULL, NULL);
					}
					else {
						VectorCopy(bs->notblocked_dir, dir);
					}
					if (trap_BotMoveInDirection(bs->ms, dir, speed, MOVE_WALK)) {
						VectorCopy(dir, bs->notblocked_dir);
					}
					else {
						VectorSet(bs->notblocked_dir, 0, 0, 0);
					}
				}
			}
		}
		bs->preventJump = qtrue;
		break;	// don't bother about other team mates for now
	}

	// look around
	if (BotRoamGoal(bs, target, qfalse)) {
		VectorSubtract(target, bs->origin, dir);
		vectoangles(dir, bs->ideal_viewangles);
		bs->ideal_viewangles[2] *= 0.5;
	}
}

/*
==================
BotGetItemLongTermGoal
==================
*/
int BotGetItemLongTermGoal(bot_state_t *bs, int tfl, bot_goal_t *goal) {
	//if the bot has no goal
	if (!trap_BotGetTopGoal(bs->gs, goal)) {
		//BotAI_Print(PRT_MESSAGE, "no ltg on stack\n");
		bs->ltg_time = 0;
	}
	//if the bot touches the current goal
	else if (BotReachedGoal(bs, goal)) {
		BotChooseWeapon(bs);
		bs->ltg_time = 0;
	}
	//if it is time to find a new long term goal
	if (bs->ltg_time < FloatTime()) {
		//pop the current goal from the stack
		trap_BotPopGoal(bs->gs);
		BotCheckIfBlockingTeammates(bs);
		return qfalse;
	}
	return qtrue;
}

/*
==================
BotGetLongTermGoal

we could also create a seperate AI node for every long term goal type
however this saves us a lot of code
==================
*/
int BotGetLongTermGoal(bot_state_t *bs, int tfl, int retreat, bot_goal_t *goal) {
	vec3_t target, dir, dir2;
	char netname[MAX_NETNAME];
	char buf[MAX_MESSAGE_SIZE];
	int areanum;
	float croucher;
	aas_entityinfo_t entinfo, botinfo;
	bot_waypoint_t *wp;

	// JUHOX: LTG_TEAMHELP is now used to let a bot go to a team mate
	if (bs->ltgtype == LTG_TEAMHELP /*&& !retreat*/) {	// JUHOX: ignore retreat-flag if helping a teammate
		//check for bot typing status message
		if (bs->teammessage_time && bs->teammessage_time < FloatTime()) {
			BotAI_BotInitialChat(bs, "help_start", EasyClientName(bs->teammate, netname, sizeof(netname)), NULL);
			// JUHOX: 'decisionmaker' not used. talk to 'teammate'
			trap_BotEnterChat(bs->cs, bs->teammate, CHAT_TELL);
			bs->teammessage_time = 0;
		}
		//if trying to help the team mate for more than a minute
		if (bs->teamgoal_time < FloatTime())
			bs->ltgtype = 0;

        // JUHOX: new code for searching team mate
		{
			playerState_t ps;
			float maxDistSqr;

			if (!BotAI_GetClientState(bs->teammate, &ps)) {
			StopHelping:
				bs->ltgtype = 0;
				return qfalse;
			}
			if (ps.stats[STAT_HEALTH] <= 0) goto StopHelping;
			if (ps.weaponstate >= WEAPON_FIRING) {
				maxDistSqr = Square(300);
			}
			else {
				maxDistSqr = Square(150);
			}
			if (DistanceSquared(bs->origin, ps.origin) < maxDistSqr) {
				if (BotEntityVisible(&bs->cur_ps, 360, bs->teammate)) {
					trap_BotResetAvoidReach(bs->ms);
					BotCheckIfBlockingTeammates(bs);
					return qfalse;
				}
			}

			// update team goal
			areanum = BotPointAreaNum(ps.origin);
			if (areanum > 0 && trap_AAS_AreaReachability(areanum)) {
				bs->teamgoal.entitynum = bs->teammate;
				bs->teamgoal.areanum = areanum;
				VectorCopy(ps.origin, bs->teamgoal.origin);
				VectorSet(bs->teamgoal.mins, -8, -8, -8);
				VectorSet(bs->teamgoal.maxs, 8, 8, 8);
			}
		}

		memcpy(goal, &bs->teamgoal, sizeof(bot_goal_t));
		return qtrue;
	}
	//if the bot accompanies someone
	if (bs->ltgtype == LTG_TEAMACCOMPANY && !retreat) {
		//check for bot typing status message
		if (bs->teammessage_time && bs->teammessage_time < FloatTime()) {
			BotAI_BotInitialChat(bs, "accompany_start", EasyClientName(bs->teammate, netname, sizeof(netname)), NULL);
			trap_BotEnterChat(bs->cs, bs->decisionmaker, CHAT_TELL);
			BotVoiceChatOnly(bs, bs->decisionmaker, VOICECHAT_YES);
			trap_EA_Action(bs->client, ACTION_AFFIRMATIVE);
			bs->teammessage_time = 0;
		}
		//if accompanying the companion for 3 minutes
		if (bs->teamgoal_time < FloatTime()) {
			BotAI_BotInitialChat(bs, "accompany_stop", EasyClientName(bs->teammate, netname, sizeof(netname)), NULL);
			trap_BotEnterChat(bs->cs, bs->teammate, CHAT_TELL);
			bs->ltgtype = 0;
		}
		//get entity information of the companion
		BotEntityInfo(bs->teammate, &entinfo);
		//if the companion is visible
		if (BotEntityVisible(&bs->cur_ps/*bs->entitynum, bs->eye, bs->viewangles*/, 360, bs->teammate)) {	// JUHOX
			//update visible time
			bs->teammatevisible_time = FloatTime();
			VectorSubtract(entinfo.origin, bs->origin, dir);
			if (VectorLengthSquared(dir) < Square(bs->formation_dist)) {
				//
				// if the client being followed bumps into this bot then
				// the bot should back up
				BotEntityInfo(bs->entitynum, &botinfo);
				// if the followed client is not standing ontop of the bot
				if (botinfo.origin[2] + botinfo.maxs[2] > entinfo.origin[2] + entinfo.mins[2]) {
					// if the bounding boxes touch each other
					if (botinfo.origin[0] + botinfo.maxs[0] > entinfo.origin[0] + entinfo.mins[0] - 4&&
						botinfo.origin[0] + botinfo.mins[0] < entinfo.origin[0] + entinfo.maxs[0] + 4) {
						if (botinfo.origin[1] + botinfo.maxs[1] > entinfo.origin[1] + entinfo.mins[1] - 4 &&
							botinfo.origin[1] + botinfo.mins[1] < entinfo.origin[1] + entinfo.maxs[1] + 4) {
							if (botinfo.origin[2] + botinfo.maxs[2] > entinfo.origin[2] + entinfo.mins[2] - 4 &&
								botinfo.origin[2] + botinfo.mins[2] < entinfo.origin[2] + entinfo.maxs[2] + 4) {
								// if the followed client looks in the direction of this bot
								AngleVectors(entinfo.angles, dir, NULL, NULL);
								dir[2] = 0;
								VectorNormalize(dir);
								//VectorSubtract(entinfo.origin, entinfo.lastvisorigin, dir);
								VectorSubtract(bs->origin, entinfo.origin, dir2);
								VectorNormalize(dir2);
								if (DotProduct(dir, dir2) > 0.7) {
									// back up
									BotSetupForMovement(bs);
									trap_BotMoveInDirection(bs->ms, dir2, 400, MOVE_WALK);
								}
							}
						}
					}
				}
				//check if the bot wants to crouch
				//don't crouch if crouched less than 5 seconds ago
				if (bs->attackcrouch_time < FloatTime() - 5) {
					croucher = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CROUCHER, 0, 1);
					if (random() < bs->thinktime * croucher) {
						bs->attackcrouch_time = FloatTime() + 5 + croucher * 15;
					}
				}
				//don't crouch when swimming
				if (trap_AAS_Swimming(bs->origin)) bs->attackcrouch_time = FloatTime() - 1;
				//if not arrived yet or arived some time ago
				if (bs->arrive_time < FloatTime() - 2) {
					//if not arrived yet
					if (!bs->arrive_time) {
						trap_EA_Gesture(bs->client);
						BotAI_BotInitialChat(bs, "accompany_arrive", EasyClientName(bs->teammate, netname, sizeof(netname)), NULL);
						trap_BotEnterChat(bs->cs, bs->teammate, CHAT_TELL);
						bs->arrive_time = FloatTime();
					}
					//if the bot wants to crouch
					else if (bs->attackcrouch_time > FloatTime()) {
						trap_EA_Crouch(bs->client);
					}
					//else do some model taunts
					else if (random() < bs->thinktime * 0.05) {
						//do a gesture :)
						trap_EA_Gesture(bs->client);
					}
				}
				//if just arrived look at the companion
				if (bs->arrive_time > FloatTime() - 2) {
					VectorSubtract(entinfo.origin, bs->origin, dir);
					vectoangles(dir, bs->ideal_viewangles);
					bs->ideal_viewangles[2] *= 0.5;
				}
				//else look strategically around for enemies

				else if (BotRoamGoal(bs, target, qfalse)) {
					VectorSubtract(target, bs->origin, dir);
					vectoangles(dir, bs->ideal_viewangles);
					bs->ideal_viewangles[2] *= 0.5;
				}
				//check if the bot wants to go for air
				if (BotGoForAir(bs, bs->tfl, &bs->teamgoal, 400)) {
					trap_BotResetLastAvoidReach(bs->ms);
					//get the goal at the top of the stack
					//trap_BotGetTopGoal(bs->gs, &tmpgoal);
					//trap_BotGoalName(tmpgoal.number, buf, 144);
					//BotAI_Print(PRT_MESSAGE, "new nearby goal %s\n", buf);
					//time the bot gets to pick up the nearby goal item
					bs->nbg_time = FloatTime() + 8;
					AIEnter_Seek_NBG(bs, "BotLongTermGoal: go for air");
					return qfalse;
				}
				//
				trap_BotResetAvoidReach(bs->ms);
				return qfalse;
			}
		}
		//if the entity information is valid (entity in PVS)
		if (entinfo.valid) {
			areanum = BotPointAreaNum(entinfo.origin);
			if (areanum && trap_AAS_AreaReachability(areanum)) {
				//update team goal
				bs->teamgoal.entitynum = bs->teammate;
				bs->teamgoal.areanum = areanum;
				VectorCopy(entinfo.origin, bs->teamgoal.origin);
				VectorSet(bs->teamgoal.mins, -8, -8, -8);
				VectorSet(bs->teamgoal.maxs, 8, 8, 8);
			}
		}
		//the goal the bot should go for
		memcpy(goal, &bs->teamgoal, sizeof(bot_goal_t));
		//if the companion is NOT visible for too long
		if (bs->teammatevisible_time < FloatTime() - 60) {
			BotAI_BotInitialChat(bs, "accompany_cannotfind", EasyClientName(bs->teammate, netname, sizeof(netname)), NULL);
			trap_BotEnterChat(bs->cs, bs->teammate, CHAT_TELL);
			bs->ltgtype = 0;
			// just to make sure the bot won't spam this message
			bs->teammatevisible_time = FloatTime();
		}
		return qtrue;
	}

	if (bs->ltgtype == LTG_DEFENDKEYAREA) {
		if (trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin,
				bs->teamgoal.areanum, TFL_DEFAULT) > bs->defendaway_range) {
			bs->defendaway_time = 0;
		}
	}
	//if defending a key area
	if (bs->ltgtype == LTG_DEFENDKEYAREA && !retreat &&
				bs->defendaway_time < FloatTime()) {
		//check for bot typing status message
		if (bs->teammessage_time && bs->teammessage_time < FloatTime()) {
			trap_BotGoalName(bs->teamgoal.number, buf, sizeof(buf));
			BotAI_BotInitialChat(bs, "defend_start", buf, NULL);
			trap_BotEnterChat(bs->cs, 0, CHAT_TEAM);
			BotVoiceChatOnly(bs, -1, VOICECHAT_ONDEFENSE);
			bs->teammessage_time = 0;
		}
		//set the bot goal
		memcpy(goal, &bs->teamgoal, sizeof(bot_goal_t));
		//stop after 2 minutes
		if (bs->teamgoal_time < FloatTime()) {
			trap_BotGoalName(bs->teamgoal.number, buf, sizeof(buf));
			BotAI_BotInitialChat(bs, "defend_stop", buf, NULL);
			trap_BotEnterChat(bs->cs, 0, CHAT_TEAM);
			bs->ltgtype = 0;
		}
		//if very close... go away for some time
		VectorSubtract(goal->origin, bs->origin, dir);
		if (VectorLengthSquared(dir) < Square(70)) {
			trap_BotResetAvoidReach(bs->ms);
			bs->defendaway_time = FloatTime() + 3 + 3 * random();
			if (BotHasPersistantPowerupAndWeapon(bs)) {
				bs->defendaway_range = 100;
			}
			else {
				bs->defendaway_range = 350;
			}
		}
		return qtrue;
	}
	//going to kill someone
	if (bs->ltgtype == LTG_KILL && !retreat) {
		//check for bot typing status message
		if (bs->teammessage_time && bs->teammessage_time < FloatTime()) {
			bs->teammessage_time = 0;
		}

		if (bs->lastkilledplayer == bs->teamgoal.entitynum) {
			bs->ltgtype = 0;
		}

		if (bs->teamgoal_time < FloatTime()) {
			bs->ltgtype = 0;
		}
		//just roam around
		return BotGetItemLongTermGoal(bs, tfl, goal);
	}
	//get an item
	if (bs->ltgtype == LTG_GETITEM /*&& !retreat*/) {	// JUHOX
		//check for bot typing status message
		bs->teammessage_time = 0;

		//set the bot goal
		memcpy(goal, &bs->teamgoal, sizeof(bot_goal_t));
		//stop after some time
		if (bs->teamgoal_time < FloatTime()) {
			bs->ltgtype = 0;
		}
		//
		if (trap_BotItemGoalInVisButNotVisible(bs->entitynum, bs->eye, bs->viewangles, goal)) {
			bs->ltgtype = 0;
		}
		else if (BotReachedGoal(bs, goal)) {
			bs->ltgtype = 0;
		}
		return qtrue;
	}
	//if camping somewhere
	// JUHOX: LTG_CAMP and LTG_CAMPORDER are now used to let a bot go to a location
	if ((bs->ltgtype == LTG_CAMP || bs->ltgtype == LTG_CAMPORDER) /*&& !retreat*/) {	// JUHOX
		float distanceSqr;	// JUHOX

		//check for bot typing status message
		bs->teammessage_time = 0;
		//set the bot goal
		memcpy(goal, &bs->teamgoal, sizeof(bot_goal_t));
		//
		if (bs->teamgoal_time < FloatTime()) {
			bs->ltgtype = 0;
		}
		//if really near the camp spot
		VectorSubtract(goal->origin, bs->origin, dir);

		distanceSqr = VectorLengthSquared(dir);
		if (
			bs->arrive_time ||
			(bs->ltgtype == LTG_CAMPORDER && distanceSqr < Square(50)) ||
			(
				bs->ltgtype == LTG_CAMP &&
				(
					distanceSqr < Square(100) ||
					(
						distanceSqr < Square(500) &&
						(goal->flags & GFL_ITEM) &&
						(
							BotEntityVisible(&bs->cur_ps, 360, goal->entitynum) ||
							(
								trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, goal->areanum, bs->tfl) < 200 &&
								trap_AAS_AreaTravelTimeToGoalArea(goal->areanum, goal->origin, bs->areanum, bs->tfl) < 200
							)
						)
					)
				)
			)
		)

		{
			//if not arrived yet
			if (!bs->arrive_time) {
				bs->teamgoal_time = FloatTime() + bs->camp_time;	// JUHOX: stay here some time. note that camp_time had formerly another meaning
				bs->arrive_time = FloatTime();
			}
			//look strategically around for enemies
			BotCheckIfBlockingTeammates(bs);

			//check if the bot wants to crouch
			//don't crouch if crouched less than 5 seconds ago
			if (bs->attackcrouch_time < FloatTime() - 5) {
				croucher = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CROUCHER, 0, 1);
				if (random() < bs->thinktime * croucher) {
					bs->attackcrouch_time = FloatTime() + 5 + croucher * 15;
				}
			}
			//if the bot wants to crouch
			if (bs->attackcrouch_time > FloatTime()) {
				trap_EA_Crouch(bs->client);
			}
			//don't crouch when swimming
			if (trap_AAS_Swimming(bs->origin)) bs->attackcrouch_time = FloatTime() - 1;
			//make sure the bot is not gonna drown
			if (trap_PointContents(bs->eye,bs->entitynum) & (CONTENTS_WATER|CONTENTS_SLIME|CONTENTS_LAVA)) {
				bs->ltgtype = 0;
			}

			if (bs->camp_range > 0) {
				//FIXME: move around a bit
			}

			trap_BotResetAvoidReach(bs->ms);
			return qfalse;
		}
		return qtrue;
	}
	// JUHOX: handle new ltg LTG_ESCAPE
	if (bs->ltgtype == LTG_ESCAPE) {	// NOTE: we are not checking 'retreat' flag
		//set the bot goal
		memcpy(goal, &bs->teamgoal, sizeof(bot_goal_t));
		//
		if (
			bs->teamgoal_time < FloatTime() ||
			DistanceSquared(goal->origin, bs->origin) < Square(50)
		) {
			bs->ltgtype = 0;
		}
		return qtrue;
	}

	// JUHOX: handle new ltg LTG_WAIT
	if (bs->ltgtype == LTG_WAIT) {	// NOTE: we are not checking 'retreat' flag
		memset(goal, 0, sizeof(*goal));	// not really needed
		BotCheckIfBlockingTeammates(bs);
		if (bs->teamgoal_time < FloatTime()) bs->ltgtype = 0;
		return qfalse;
	}

	//patrolling along several waypoints
	if (bs->ltgtype == LTG_PATROL && !retreat) {
		//check for bot typing status message
		if (bs->teammessage_time && bs->teammessage_time < FloatTime()) {
			strcpy(buf, "");
			for (wp = bs->patrolpoints; wp; wp = wp->next) {
				strcat(buf, wp->name);
				if (wp->next) strcat(buf, " to ");
			}
			BotAI_BotInitialChat(bs, "patrol_start", buf, NULL);
			trap_BotEnterChat(bs->cs, bs->decisionmaker, CHAT_TELL);
			BotVoiceChatOnly(bs, bs->decisionmaker, VOICECHAT_YES);
			trap_EA_Action(bs->client, ACTION_AFFIRMATIVE);
			bs->teammessage_time = 0;
		}

		if (!bs->curpatrolpoint) {
			bs->ltgtype = 0;
			return qfalse;
		}
		//if the bot touches the current goal
		if (trap_BotTouchingGoal(bs->origin, &bs->curpatrolpoint->goal)) {
			if (bs->patrolflags & PATROL_BACK) {
				if (bs->curpatrolpoint->prev) {
					bs->curpatrolpoint = bs->curpatrolpoint->prev;
				}
				else {
					bs->curpatrolpoint = bs->curpatrolpoint->next;
					bs->patrolflags &= ~PATROL_BACK;
				}
			}
			else {
				if (bs->curpatrolpoint->next) {
					bs->curpatrolpoint = bs->curpatrolpoint->next;
				}
				else {
					bs->curpatrolpoint = bs->curpatrolpoint->prev;
					bs->patrolflags |= PATROL_BACK;
				}
			}
		}
		//stop after 5 minutes
		if (bs->teamgoal_time < FloatTime()) {
			BotAI_BotInitialChat(bs, "patrol_stop", NULL);
			trap_BotEnterChat(bs->cs, bs->decisionmaker, CHAT_TELL);
			bs->ltgtype = 0;
		}
		if (!bs->curpatrolpoint) {
			bs->ltgtype = 0;
			return qfalse;
		}
		memcpy(goal, &bs->curpatrolpoint->goal, sizeof(bot_goal_t));
		return qtrue;
	}
#ifdef CTF
	if (gametype == GT_CTF) {
		//if going for enemy flag
		if (bs->ltgtype == LTG_GETFLAG) {
			//check for bot typing status message
			bs->teammessage_time = 0;

			switch(BotTeam(bs)) {
				case TEAM_RED: memcpy(goal, &ctf_blueflag, sizeof(bot_goal_t)); break;
				case TEAM_BLUE: memcpy(goal, &ctf_redflag, sizeof(bot_goal_t)); break;
				default: bs->ltgtype = 0; return qfalse;
			}
			//if touching the flag
			if (trap_BotTouchingGoal(bs->origin, goal)) {
				// make sure the bot knows the flag isn't there anymore
				switch(BotTeam(bs)) {
					case TEAM_RED: bs->blueflagstatus = 1; break;
					case TEAM_BLUE: bs->redflagstatus = 1; break;
				}
				bs->ltgtype = 0;
			}
			//stop after 3 minutes
			if (bs->teamgoal_time < FloatTime()) {
				bs->ltgtype = 0;
			}
			BotAlternateRoute(bs, goal);
			return qtrue;
		}
		//if rushing to the base
		if (bs->ltgtype == LTG_RUSHBASE /*&& bs->rushbaseaway_time < FloatTime()*/) {	// JUHOX
			switch(BotTeam(bs)) {
				case TEAM_RED: memcpy(goal, &ctf_redflag, sizeof(bot_goal_t)); break;
				case TEAM_BLUE: memcpy(goal, &ctf_blueflag, sizeof(bot_goal_t)); break;
				default: bs->ltgtype = 0; return qfalse;
			}
            // JUHOX: allow the flag carrier to escape in certain cases near the base
			if (BotOwnFlagStatus(bs) == FLAG_ATBASE) {
				bs->rushbaseaway_time = 0;
				bs->ltg_time = 0;
				bs->nbg_time = 0;
			}
			else if (
				bs->enemy >= 0 &&
				NearHomeBase(bs->cur_ps.persistant[PERS_TEAM], bs->origin, 9) &&
				(bs->cur_ps.powerups[PW_REDFLAG] || bs->cur_ps.powerups[PW_BLUEFLAG]) &&
				DistanceSquared(bs->lastenemyorigin, goal->origin) < 300*300
			) {
				if (bs->rushbaseaway_time <= 0) bs->ltg_time = 0;
				bs->rushbaseaway_time = FloatTime() + 10;
			}

			if (bs->rushbaseaway_time > 0) {
				if (
					bs->rushbaseaway_time < FloatTime() ||
					!NearHomeBase(bs->cur_ps.persistant[PERS_TEAM], bs->origin, 3)
				) bs->rushbaseaway_time = 0;
				return BotGetItemLongTermGoal(bs, tfl, goal);
			}

			//quit rushing after 2 minutes
			if (bs->teamgoal_time < FloatTime()) bs->ltgtype = 0;
            // JUHOX: don't enforce to touch the goal if it's not there
			if (
				BotOwnFlagStatus(bs) != FLAG_ATBASE &&
				DistanceSquared(bs->origin, goal->origin) < 80*80
			) {
				//bs->rushbaseaway_time = FloatTime() + 3;
				//bs->ltg_time = 0;
				BotCheckIfBlockingTeammates(bs);
				return qfalse;
			}

			//if touching the base flag the bot should loose the enemy flag
			if (trap_BotTouchingGoal(bs->origin, goal)) {
				//if the bot is still carrying the enemy flag then the
				//base flag is gone, now just walk near the base a bit
				if (BotCTFCarryingFlag(bs)) {
					trap_BotResetAvoidReach(bs->ms);

					BotCheckIfBlockingTeammates(bs);
					return qfalse;

				}
				else {
					bs->ltgtype = 0;
				}
			}
			BotAlternateRoute(bs, goal);
			return qtrue;
		}
		//returning flag
		if (bs->ltgtype == LTG_RETURNFLAG) {
			//check for bot typing status message

			bs->teammessage_time = 0;

#if BOTS_USE_TSS	// JUHOX: if tss is active, we should know the location
			if (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_isValid)) {
				if (bs->teamgoal_time < FloatTime()) {
					bs->ltgtype = 0;
				}
				if (LocateFlag(bs->cur_ps.persistant[PERS_TEAM], goal)) {
					return qtrue;
				}
			}
#endif
			switch(BotTeam(bs)) {
				case TEAM_RED: memcpy(goal, &ctf_blueflag, sizeof(bot_goal_t)); break;
				case TEAM_BLUE: memcpy(goal, &ctf_redflag, sizeof(bot_goal_t)); break;
				default: bs->ltgtype = 0; return qfalse;
			}
			//if touching the flag
			if (trap_BotTouchingGoal(bs->origin, goal)) bs->ltgtype = 0;
			//stop after 3 minutes
			if (bs->teamgoal_time < FloatTime()) {
				bs->ltgtype = 0;
			}
			BotAlternateRoute(bs, goal);
			return qtrue;
		}
	}
#endif //CTF

	//normal goal stuff
	return BotGetItemLongTermGoal(bs, tfl, goal);
}

/*
==================
BotLongTermGoal
==================
*/
int BotLongTermGoal(bot_state_t *bs, int tfl, int retreat, bot_goal_t *goal) {
	aas_entityinfo_t entinfo;
	char teammate[MAX_MESSAGE_SIZE];
	float squaredist;
	int areanum;
	vec3_t dir;

	//FIXME: also have air long term goals?
	//
	//if the bot is leading someone and not retreating
	if (bs->lead_time > 0 && !retreat) {
		if (bs->lead_time < FloatTime()) {
			BotAI_BotInitialChat(bs, "lead_stop", EasyClientName(bs->lead_teammate, teammate, sizeof(teammate)), NULL);
			trap_BotEnterChat(bs->cs, bs->teammate, CHAT_TELL);
			bs->lead_time = 0;
			return BotGetLongTermGoal(bs, tfl, retreat, goal);
		}
		//
		if (bs->leadmessage_time < 0 && -bs->leadmessage_time < FloatTime()) {
			BotAI_BotInitialChat(bs, "followme", EasyClientName(bs->lead_teammate, teammate, sizeof(teammate)), NULL);
			trap_BotEnterChat(bs->cs, bs->teammate, CHAT_TELL);
			bs->leadmessage_time = FloatTime();
		}
		//get entity information of the companion
		BotEntityInfo(bs->lead_teammate, &entinfo);
		//
		if (entinfo.valid) {
			areanum = BotPointAreaNum(entinfo.origin);
			if (areanum && trap_AAS_AreaReachability(areanum)) {
				//update team goal
				bs->lead_teamgoal.entitynum = bs->lead_teammate;
				bs->lead_teamgoal.areanum = areanum;
				VectorCopy(entinfo.origin, bs->lead_teamgoal.origin);
				VectorSet(bs->lead_teamgoal.mins, -8, -8, -8);
				VectorSet(bs->lead_teamgoal.maxs, 8, 8, 8);
			}
		}
		//if the team mate is visible
		if (BotEntityVisible(&bs->cur_ps, 360, bs->lead_teammate)) {	// JUHOX
			bs->leadvisible_time = FloatTime();
		}
		//if the team mate is not visible for 1 seconds
		if (bs->leadvisible_time < FloatTime() - 1) {
			bs->leadbackup_time = FloatTime() + 2;
		}
		//distance towards the team mate
		VectorSubtract(bs->origin, bs->lead_teamgoal.origin, dir);
		squaredist = VectorLengthSquared(dir);
		//if backing up towards the team mate
		if (bs->leadbackup_time > FloatTime()) {
			if (bs->leadmessage_time < FloatTime() - 20) {
				BotAI_BotInitialChat(bs, "followme", EasyClientName(bs->lead_teammate, teammate, sizeof(teammate)), NULL);
				trap_BotEnterChat(bs->cs, bs->teammate, CHAT_TELL);
				bs->leadmessage_time = FloatTime();
			}
			//if very close to the team mate
			if (squaredist < Square(100)) {
				bs->leadbackup_time = 0;
			}
			//the bot should go back to the team mate
			memcpy(goal, &bs->lead_teamgoal, sizeof(bot_goal_t));
			return qtrue;
		}
		else {
			//if quite distant from the team mate
			if (squaredist > Square(500)) {
				if (bs->leadmessage_time < FloatTime() - 20) {
					BotAI_BotInitialChat(bs, "followme", EasyClientName(bs->lead_teammate, teammate, sizeof(teammate)), NULL);
					trap_BotEnterChat(bs->cs, bs->teammate, CHAT_TELL);
					bs->leadmessage_time = FloatTime();
				}
				//look at the team mate
				VectorSubtract(entinfo.origin, bs->origin, dir);
				vectoangles(dir, bs->ideal_viewangles);
				bs->ideal_viewangles[2] *= 0.5;
				//just wait for the team mate
				return qfalse;
			}
		}
	}
	// JUHOX: update the teamgoal
	if (BotGetLongTermGoal(bs, tfl, retreat, goal)) {
		if (bs->ltgtype != 0) memcpy(&bs->teamgoal, goal, sizeof(bot_goal_t));
		return qtrue;
	}
	return qfalse;
}

/*
==================
AIEnter_Intermission
==================
*/
void AIEnter_Intermission(bot_state_t *bs, char *s) {
	BotRecordNodeSwitch(bs, "intermission", "", s);
	//reset the bot state
	BotResetState(bs);
	//check for end level chat
	if (BotChat_EndLevel(bs)) {
		trap_BotEnterChat(bs->cs, 0, bs->chatto);
	}
	bs->ainode = AINode_Intermission;
}

/*
==================
AINode_Intermission
==================
*/
int AINode_Intermission(bot_state_t *bs) {
	//if the intermission ended
	if (!BotIntermission(bs)) {
		if (BotChat_StartLevel(bs)) {
			bs->stand_time = FloatTime() + BotChatTime(bs);
		}
		else {
			bs->stand_time = FloatTime() + 2;
		}
		AIEnter_Stand(bs, "intermission: chat");
	}
	return qtrue;
}

/*
==================
AIEnter_Observer
==================
*/
void AIEnter_Observer(bot_state_t *bs, char *s) {
	BotRecordNodeSwitch(bs, "observer", "", s);
	//reset the bot state
	BotResetState(bs);
	bs->ainode = AINode_Observer;
}

/*
==================
AINode_Observer
==================
*/
int AINode_Observer(bot_state_t *bs) {
	//if the bot left observer mode
	if (!BotIsObserver(bs)) {
		AIEnter_Stand(bs, "observer: left observer");
	}
	return qtrue;
}

/*
==================
AIEnter_Stand
==================
*/
void AIEnter_Stand(bot_state_t *bs, char *s) {
	BotRecordNodeSwitch(bs, "stand", "", s);
	bs->standfindenemy_time = FloatTime() + 1;
	bs->ainode = AINode_Stand;
}

/*
==================
AINode_Stand
==================
*/
int AINode_Stand(bot_state_t *bs) {

	//if the bot's health decreased
	if (bs->lastframe_health > bs->inventory[INVENTORY_HEALTH]) {
		if (BotChat_HitTalking(bs)) {
			bs->standfindenemy_time = FloatTime() + BotChatTime(bs) + 0.1;
			bs->stand_time = FloatTime() + BotChatTime(bs) + 0.1;
		}
	}
	if (bs->standfindenemy_time < FloatTime()) {
		if (BotFindEnemy(bs, -1)) {
			AIEnter_Battle_Fight(bs, "stand: found enemy");
			return qfalse;
		}
		bs->standfindenemy_time = FloatTime() + 1;
	}
	// put up chat icon
	trap_EA_Talk(bs->client);
	// when done standing
	if (bs->stand_time < FloatTime()) {
		trap_BotEnterChat(bs->cs, 0, bs->chatto);
		AIEnter_Seek_LTG(bs, "stand: time out");
		return qfalse;
	}

	return qtrue;
}

/*
==================
AIEnter_Respawn
==================
*/
void AIEnter_Respawn(bot_state_t *bs, char *s) {
	BotRecordNodeSwitch(bs, "respawn", "", s);
	//reset some states
	trap_BotResetMoveState(bs->ms);
	trap_BotResetGoalState(bs->gs);
	trap_BotResetAvoidGoals(bs->gs);
	trap_BotResetAvoidReach(bs->ms);
	//if the bot wants to chat
	bs->respawn_time = 0;
	bs->respawnchat_time = 0;
	bs->lastKilled_time = FloatTime();
	//set respawn state
	bs->respawn_wait = qfalse;
	bs->ainode = AINode_Respawn;
}

/*
==================
AINode_Respawn
==================
*/
int AINode_Respawn(bot_state_t *bs) {
	// if waiting for the actual respawn
	if (bs->respawn_wait) {
		if (!BotIsDead(bs)) {
			AIEnter_Seek_LTG(bs, "respawn: respawned");
			bs->lastRespawn_time = FloatTime();	// JUHOX
		}
		else {
#if !RESPAWN_DELAY	// JUHOX: do not try to respawn
			trap_EA_Respawn(bs->client);
#else
			if (
				bs->lastKilled_time - bs->lastRespawn_time < 5 ||
				BotEnemyTooStrong(bs) ||
				(
					g_gametype.integer == GT_CTF &&
					g_respawnAtPOD.integer &&
					!NearHomeBase(bs->cur_ps.persistant[PERS_TEAM], bs->origin, 1) &&
					Team_GetFlagStatus(bs->cur_ps.persistant[PERS_TEAM]) == FLAG_ATBASE &&
					Team_GetFlagStatus(OtherTeam(bs->cur_ps.persistant[PERS_TEAM])) == FLAG_TAKEN
				)
			) {
				trap_EA_Respawn(bs->client);	// respawn normally
			}
#endif
		}
	}
	else if (bs->respawn_time < FloatTime()) {
		// wait until respawned
		bs->respawn_wait = qtrue;
		// elementary action respawn
		trap_EA_Respawn(bs->client);
		//
		if (bs->respawnchat_time) {
			trap_BotEnterChat(bs->cs, 0, bs->chatto);
			bs->enemy = -1;
		}
	}
	if (bs->respawnchat_time && bs->respawnchat_time < FloatTime() - 0.5) {
		trap_EA_Talk(bs->client);
	}
	//
	return qtrue;
}

/*
==================
BotSelectActivateWeapon
==================
*/
int BotSelectActivateWeapon(bot_state_t *bs) {

	if (bs->inventory[INVENTORY_MACHINEGUN] > 0 && bs->inventory[INVENTORY_BULLETS] > 0)
		return WEAPONINDEX_MACHINEGUN;
	else if (bs->inventory[INVENTORY_SHOTGUN] > 0 && bs->inventory[INVENTORY_SHELLS] > 0)
		return WEAPONINDEX_SHOTGUN;
	else if (bs->inventory[INVENTORY_PLASMAGUN] > 0 && bs->inventory[INVENTORY_CELLS] > 0)
		return WEAPONINDEX_PLASMAGUN;
	else if (bs->inventory[INVENTORY_LIGHTNING] > 0 && bs->inventory[INVENTORY_LIGHTNINGAMMO] > 0)
		return WEAPONINDEX_LIGHTNING;
	else if (bs->inventory[INVENTORY_RAILGUN] > 0 && bs->inventory[INVENTORY_SLUGS] > 0)
		return WEAPONINDEX_RAILGUN;
	else if (bs->inventory[INVENTORY_ROCKETLAUNCHER] > 0 && bs->inventory[INVENTORY_ROCKETS] > 0)
		return WEAPONINDEX_ROCKET_LAUNCHER;
	else if (bs->inventory[INVENTORY_BFG10K] > 0 && bs->inventory[INVENTORY_BFGAMMO] > 0)
		return WEAPONINDEX_BFG;
	else {
		return -1;
	}
}

/*
==================
BotClearPath

 try to deactivate obstacles like proximity mines on the bot's path
==================
*/
void BotClearPath(bot_state_t *bs, bot_moveresult_t *moveresult) {
	int i, bestmine;
	float dist, bestdist;
	vec3_t target, dir;
	bsp_trace_t bsptrace;
	entityState_t state;

	// if there is a dead body wearing kamikze nearby
	if (bs->kamikazebody) {
		// if the bot's view angles and weapon are not used for movement
		if ( !(moveresult->flags & (MOVERESULT_MOVEMENTVIEW | MOVERESULT_MOVEMENTWEAPON)) ) {
			//
			BotAI_GetEntityState(bs->kamikazebody, &state);
			VectorCopy(state.pos.trBase, target);
			target[2] += 8;
			VectorSubtract(target, bs->eye, dir);
			vectoangles(dir, moveresult->ideal_viewangles);
			//
			moveresult->weapon = BotSelectActivateWeapon(bs);
			if (moveresult->weapon == -1) {
				// FIXME: run away!
				moveresult->weapon = 0;
			}
			if (moveresult->weapon) {
				//
				moveresult->flags |= MOVERESULT_MOVEMENTWEAPON | MOVERESULT_MOVEMENTVIEW;
				// if holding the right weapon
				if (bs->cur_ps.weapon == moveresult->weapon) {
					// if the bot is pretty close with it's aim
					if (InFieldOfVision(bs->viewangles, 20, moveresult->ideal_viewangles)) {
						//
						BotAI_Trace(&bsptrace, bs->eye, NULL, NULL, target, bs->entitynum, MASK_SHOT);
						// if the mine is visible from the current position
						if (bsptrace.fraction >= 1.0 || bsptrace.ent == state.number) {
							// shoot at the mine
							trap_EA_Attack(bs->client);
						}
					}
				}
			}
		}
	}
	if (moveresult->flags & MOVERESULT_BLOCKEDBYAVOIDSPOT) {
		bs->blockedbyavoidspot_time = FloatTime() + 5;
	}
	// if blocked by an avoid spot and the view angles and weapon are used for movement
	if (bs->blockedbyavoidspot_time > FloatTime() &&
		!(moveresult->flags & (MOVERESULT_MOVEMENTVIEW | MOVERESULT_MOVEMENTWEAPON)) ) {
		bestdist = 300;
		bestmine = -1;
		for (i = 0; i < bs->numproxmines; i++) {
			BotAI_GetEntityState(bs->proxmines[i], &state);
			VectorSubtract(state.pos.trBase, bs->origin, dir);
			dist = VectorLength(dir);
			if (dist < bestdist) {
				bestdist = dist;
				bestmine = i;
			}
		}
		if (bestmine != -1) {
			//
			// state->generic1 == TEAM_RED || state->generic1 == TEAM_BLUE
			//
			// deactivate prox mines in the bot's path by shooting
			// rockets or plasma cells etc. at them
			BotAI_GetEntityState(bs->proxmines[bestmine], &state);
			VectorCopy(state.pos.trBase, target);
			target[2] += 2;
			VectorSubtract(target, bs->eye, dir);
			vectoangles(dir, moveresult->ideal_viewangles);
			// if the bot has a weapon that does splash damage
			if (bs->inventory[INVENTORY_PLASMAGUN] > 0 && bs->inventory[INVENTORY_CELLS] > 0)
				moveresult->weapon = WEAPONINDEX_PLASMAGUN;
			else if (bs->inventory[INVENTORY_ROCKETLAUNCHER] > 0 && bs->inventory[INVENTORY_ROCKETS] > 0)
				moveresult->weapon = WEAPONINDEX_ROCKET_LAUNCHER;
			else if (bs->inventory[INVENTORY_BFG10K] > 0 && bs->inventory[INVENTORY_BFGAMMO] > 0)
				moveresult->weapon = WEAPONINDEX_BFG;
			else {
				moveresult->weapon = 0;
			}
			if (moveresult->weapon) {
				//
				moveresult->flags |= MOVERESULT_MOVEMENTWEAPON | MOVERESULT_MOVEMENTVIEW;
				// if holding the right weapon
				if (bs->cur_ps.weapon == moveresult->weapon) {
					// if the bot is pretty close with it's aim
					if (InFieldOfVision(bs->viewangles, 20, moveresult->ideal_viewangles)) {
						//
						BotAI_Trace(&bsptrace, bs->eye, NULL, NULL, target, bs->entitynum, MASK_SHOT);
						// if the mine is visible from the current position
						if (bsptrace.fraction >= 1.0 || bsptrace.ent == state.number) {
							// shoot at the mine
							trap_EA_Attack(bs->client);
						}
					}
				}
			}
		}
	}
}

/*
==================
AIEnter_Seek_ActivateEntity
==================
*/
void AIEnter_Seek_ActivateEntity(bot_state_t *bs, char *s) {
	BotRecordNodeSwitch(bs, "activate entity", "", s);
	bs->ainode = AINode_Seek_ActivateEntity;
}

/*
==================
AINode_Seek_Activate_Entity
==================
*/
int AINode_Seek_ActivateEntity(bot_state_t *bs) {
	bot_goal_t *goal;
	vec3_t target, dir, ideal_viewangles;
	bot_moveresult_t moveresult;
	int targetvisible;
	bsp_trace_t bsptrace;
	aas_entityinfo_t entinfo;

	if (BotIsObserver(bs)) {
		BotClearActivateGoalStack(bs);
		AIEnter_Observer(bs, "active entity: observer");
		return qfalse;
	}
	//if in the intermission
	if (BotIntermission(bs)) {
		BotClearActivateGoalStack(bs);
		AIEnter_Intermission(bs, "activate entity: intermission");
		return qfalse;
	}
	//respawn if dead
	if (BotIsDead(bs)) {
		BotClearActivateGoalStack(bs);
		AIEnter_Respawn(bs, "activate entity: bot dead");
		return qfalse;
	}
	//
	bs->tfl = TFL_DEFAULT;
	if (bot_grapple.integer) bs->tfl |= TFL_GRAPPLEHOOK;
	// if in lava or slime the bot should be able to get out
	if (BotInLavaOrSlime(bs)) bs->tfl |= TFL_LAVA|TFL_SLIME;
	// map specific code
	BotMapScripts(bs);
	// no enemy
	bs->enemy = -1;
	// if the bot has no activate goal
	if (!bs->activatestack) {
		BotClearActivateGoalStack(bs);
		AIEnter_Seek_NBG(bs, "activate entity: no goal");
		return qfalse;
	}
	//
	goal = &bs->activatestack->goal;
	// initialize target being visible to false
	targetvisible = qfalse;
	// if the bot has to shoot at a target to activate something
	if (bs->activatestack->shoot) {
		//
		BotAI_Trace(&bsptrace, bs->eye, NULL, NULL, bs->activatestack->target, bs->entitynum, MASK_SHOT);
		// if the shootable entity is visible from the current position
		if (bsptrace.fraction >= 1.0 || bsptrace.ent == goal->entitynum) {
			targetvisible = qtrue;
			// if holding the right weapon
			if (bs->cur_ps.weapon == bs->activatestack->weapon) {
				VectorSubtract(bs->activatestack->target, bs->eye, dir);
				vectoangles(dir, ideal_viewangles);
				// if the bot is pretty close with it's aim
				if (InFieldOfVision(bs->viewangles, 20, ideal_viewangles)) {
					trap_EA_Attack(bs->client);
				}
			}
		}
	}
	// if the shoot target is visible
	if (targetvisible) {
		// get the entity info of the entity the bot is shooting at
		BotEntityInfo(goal->entitynum, &entinfo);
		// if the entity the bot shoots at moved
		if (!VectorCompare(bs->activatestack->origin, entinfo.origin)) {
#ifdef DEBUG
			BotAI_Print(PRT_MESSAGE, "hit shootable button or trigger\n");
#endif //DEBUG
			bs->activatestack->time = 0;
		}
		// if the activate goal has been activated or the bot takes too long
		if (bs->activatestack->time < FloatTime()) {
			BotPopFromActivateGoalStack(bs);
			// if there are more activate goals on the stack
			if (bs->activatestack) {
				bs->activatestack->time = FloatTime() + 10;
				return qfalse;
			}
			AIEnter_Seek_NBG(bs, "activate entity: time out");
			return qfalse;
		}
		memset(&moveresult, 0, sizeof(bot_moveresult_t));
	}
	else {
		// if the bot has no goal
		if (!goal) {
			bs->activatestack->time = 0;
		}
		// if the bot does not have a shoot goal
		else if (!bs->activatestack->shoot) {
			//if the bot touches the current goal
			if (trap_BotTouchingGoal(bs->origin, goal)) {
#ifdef DEBUG
				BotAI_Print(PRT_MESSAGE, "touched button or trigger\n");
#endif //DEBUG
				bs->activatestack->time = 0;
			}
		}
		// if the activate goal has been activated or the bot takes too long
		if (bs->activatestack->time < FloatTime()) {
			BotPopFromActivateGoalStack(bs);
			// if there are more activate goals on the stack
			if (bs->activatestack) {
				bs->activatestack->time = FloatTime() + 10;
				return qfalse;
			}
			AIEnter_Seek_NBG(bs, "activate entity: activated");
			return qfalse;
		}
		//predict obstacles
		if (BotAIPredictObstacles(bs, goal))
			return qfalse;
		//initialize the movement state
		BotSetupForMovement(bs);
		//move towards the goal
		trap_BotMoveToGoal(&moveresult, bs->ms, goal, bs->tfl);
		//if the movement failed
		if (moveresult.failure) {
			//reset the avoid reach, otherwise bot is stuck in current area
			trap_BotResetAvoidReach(bs->ms);
			//
			bs->activatestack->time = 0;
		}
		//check if the bot is blocked
		BotAIBlocked(bs, &moveresult, qtrue);
	}
	//
	BotClearPath(bs, &moveresult);
	// if the bot has to shoot to activate
	if (bs->activatestack->shoot) {
		// if the view angles aren't yet used for the movement
		if (!(moveresult.flags & MOVERESULT_MOVEMENTVIEW)) {
			VectorSubtract(bs->activatestack->target, bs->eye, dir);
			vectoangles(dir, moveresult.ideal_viewangles);
			moveresult.flags |= MOVERESULT_MOVEMENTVIEW;
		}
		// if there's no weapon yet used for the movement
		if (!(moveresult.flags & MOVERESULT_MOVEMENTWEAPON)) {
			moveresult.flags |= MOVERESULT_MOVEMENTWEAPON;
			//
			bs->activatestack->weapon = BotSelectActivateWeapon(bs);
			if (bs->activatestack->weapon == -1) {
				//FIXME: find a decent weapon first
				bs->activatestack->weapon = 0;
			}
			moveresult.weapon = bs->activatestack->weapon;
		}
	}
	// if the ideal view angles are set for movement
	if (moveresult.flags & (MOVERESULT_MOVEMENTVIEWSET|MOVERESULT_MOVEMENTVIEW|MOVERESULT_SWIMVIEW)) {
		VectorCopy(moveresult.ideal_viewangles, bs->ideal_viewangles);
	}
	// if waiting for something
	else if (moveresult.flags & MOVERESULT_WAITING) {
		// JUHOX: new roaming view strategy
		if (BotRoamGoal(bs, target, qfalse)) {
			VectorSubtract(target, bs->origin, dir);
			vectoangles(dir, bs->ideal_viewangles);
			bs->ideal_viewangles[2] *= 0.5;
		}
	}
	else if (!(bs->flags & BFL_IDEALVIEWSET)) {
		if (trap_BotMovementViewTarget(bs->ms, goal, bs->tfl, 300, target)) {
			VectorSubtract(target, bs->origin, dir);
			vectoangles(dir, bs->ideal_viewangles);
		}
		else {
			vectoangles(moveresult.movedir, bs->ideal_viewangles);
		}
		bs->ideal_viewangles[2] *= 0.5;
	}
	BotCheckForWeaponJump(bs, &moveresult);	// JUHOX
	// if the weapon is used for the bot movement
	if (moveresult.flags & MOVERESULT_MOVEMENTWEAPON)
		bs->weaponnum = moveresult.weapon;
	// if there is an enemy
	if (BotFindEnemy(bs, -1)) {
		if (BotWantsToRetreat(bs)) {
			//keep the current long term goal and retreat
			AIEnter_Battle_NBG(bs, "activate entity: found enemy");
		}
		else {
			trap_BotResetLastAvoidReach(bs->ms);
			//empty the goal stack
			trap_BotEmptyGoalStack(bs->gs);
			//go fight
			AIEnter_Battle_Fight(bs, "activate entity: found enemy");
		}
		BotClearActivateGoalStack(bs);
	}
	return qtrue;
}

/*
==================
AIEnter_Seek_NBG
==================
*/
void AIEnter_Seek_NBG(bot_state_t *bs, char *s) {
	bot_goal_t goal;
	char buf[144];

	if (trap_BotGetTopGoal(bs->gs, &goal)) {
		trap_BotGoalName(goal.number, buf, 144);
		BotRecordNodeSwitch(bs, "seek NBG", buf, s);
	}
	else {
		BotRecordNodeSwitch(bs, "seek NBG", "no goal", s);
	}
	bs->ainode = AINode_Seek_NBG;
}

/*
==================
AINode_Seek_NBG
==================
*/
int AINode_Seek_NBG(bot_state_t *bs) {
	bot_goal_t goal;
	vec3_t target, dir;
	bot_moveresult_t moveresult;

	if (BotIsObserver(bs)) {
		AIEnter_Observer(bs, "seek nbg: observer");
		return qfalse;
	}
	//if in the intermission
	if (BotIntermission(bs)) {
		AIEnter_Intermission(bs, "seek nbg: intermision");
		return qfalse;
	}
	//respawn if dead
	if (BotIsDead(bs)) {
		AIEnter_Respawn(bs, "seek nbg: bot dead");
		return qfalse;
	}
	//
	bs->tfl = TFL_DEFAULT;
	if (bot_grapple.integer) bs->tfl |= TFL_GRAPPLEHOOK;
	//if in lava or slime the bot should be able to get out
	if (BotInLavaOrSlime(bs)) bs->tfl |= TFL_LAVA|TFL_SLIME;
	//
	if (BotCanAndWantsToRocketJump(bs)) {
		bs->tfl |= TFL_ROCKETJUMP;
	}
	//map specific code
	BotMapScripts(bs);
	//no enemy
	bs->enemy = -1;
	//if the bot has no goal
	if (!trap_BotGetTopGoal(bs->gs, &goal)) bs->nbg_time = 0;
	//if the bot touches the current goal
	else if (BotReachedGoal(bs, &goal)) {
		BotChooseWeapon(bs);
		bs->nbg_time = 0;
		bs->check_time = 0;	// JUHOX: immediately check for another NBG
	}
	// JUHOX: check if the NBG is still useful
	else if (bs->check_time < FloatTime()) {
		bs->check_time = FloatTime() + 1 + 0.5 * random();

		if (!BotCheckNBG(bs, &goal)) {
			bs->nbg_time = 0;
			bs->check_time = 0;
		}
	}

	if (bs->nbg_time < FloatTime()) {
		bs->getImportantNBGItem = qfalse;	// JUHOX
		//pop the current goal from the stack
		trap_BotPopGoal(bs->gs);
		//check for new nearby items right away
		//NOTE: we canNOT reset the check_time to zero because it would create an endless loop of node switches
		bs->check_time = FloatTime() + 0.05;
		//go back to seek ltg
		AIEnter_Seek_LTG(bs, "seek nbg: time out");
		return qfalse;
	}
	//predict obstacles
	if (BotAIPredictObstacles(bs, &goal))
		return qfalse;
	//initialize the movement state
	BotSetupForMovement(bs);

	//move towards the goal
	trap_BotMoveToGoal(&moveresult, bs->ms, &goal, bs->tfl);
	//if the movement failed
	if (moveresult.failure) {
		//reset the avoid reach, otherwise bot is stuck in current area
		trap_BotResetAvoidReach(bs->ms);
		bs->nbg_time = 0;
	}
	//check if the bot is blocked
	BotAIBlocked(bs, &moveresult, qtrue);
	//
	BotClearPath(bs, &moveresult);
	//if the viewangles are used for the movement
	if (moveresult.flags & (MOVERESULT_MOVEMENTVIEWSET|MOVERESULT_MOVEMENTVIEW|MOVERESULT_SWIMVIEW)) {
		VectorCopy(moveresult.ideal_viewangles, bs->ideal_viewangles);
	}
	//if waiting for something
	else if (moveresult.flags & MOVERESULT_WAITING) {
		if (BotRoamGoal(bs, target, qfalse)) {
			VectorSubtract(target, bs->origin, dir);
			vectoangles(dir, bs->ideal_viewangles);
			bs->ideal_viewangles[2] *= 0.5;
		}
	}
	else if (!(bs->flags & BFL_IDEALVIEWSET)) {
		if (BotRoamGoal(bs, target, qtrue)) goto SetViewTarget;	// JUHOX
		if (!trap_BotGetSecondGoal(bs->gs, &goal)) trap_BotGetTopGoal(bs->gs, &goal);
		if (trap_BotMovementViewTarget(bs->ms, &goal, bs->tfl, 300, target)) {
			SetViewTarget:	// JUHOX
			VectorSubtract(target, bs->origin, dir);
			vectoangles(dir, bs->ideal_viewangles);
		}
		//FIXME: look at cluster portals?
		else vectoangles(moveresult.movedir, bs->ideal_viewangles);
		bs->ideal_viewangles[2] *= 0.5;
	}
	BotCheckForWeaponJump(bs, &moveresult);	// JUHOX
	//if the weapon is used for the bot movement
	if (moveresult.flags & MOVERESULT_MOVEMENTWEAPON) bs->weaponnum = moveresult.weapon;
	//if there is an enemy
	if (BotFindEnemy(bs, -1)) {
		if (BotWantsToRetreat(bs)) {
			//keep the current long term goal and retreat
			AIEnter_Battle_NBG(bs, "seek nbg: found enemy");
		}
		else {
			trap_BotResetLastAvoidReach(bs->ms);
			//empty the goal stack
			trap_BotEmptyGoalStack(bs->gs);
			//go fight
			AIEnter_Battle_Fight(bs, "seek nbg: found enemy");
		}
	}
	return qtrue;
}

/*
==================
AIEnter_Seek_LTG
==================
*/
void AIEnter_Seek_LTG(bot_state_t *bs, char *s) {
	//bot_goal_t goal;	// JUHOX: no longer needed
	char buf[144];
	Com_sprintf(buf, sizeof(buf), "#%d", bs->ltgtype);
	BotRecordNodeSwitch(bs, "seek LTG", buf, s);
	bs->ainode = AINode_Seek_LTG;
}

/*
==================
AINode_Seek_LTG
==================
*/
int AINode_Seek_LTG(bot_state_t *bs)
{
	bot_goal_t goal;
	vec3_t target, dir;
	bot_moveresult_t moveresult;
	int range;

	if (BotIsObserver(bs)) {
		AIEnter_Observer(bs, "seek ltg: observer");
		return qfalse;
	}
	//if in the intermission
	if (BotIntermission(bs)) {
		AIEnter_Intermission(bs, "seek ltg: intermission");
		return qfalse;
	}
	//respawn if dead
	if (BotIsDead(bs)) {
		AIEnter_Respawn(bs, "seek ltg: bot dead");
		return qfalse;
	}

	if (BotChat_Random(bs)) {
		bs->stand_time = FloatTime() + BotChatTime(bs);
		AIEnter_Stand(bs, "seek ltg: random chat");
		return qfalse;
	}

	bs->tfl = TFL_DEFAULT;
	if (bot_grapple.integer) bs->tfl |= TFL_GRAPPLEHOOK;
	//if in lava or slime the bot should be able to get out
	if (BotInLavaOrSlime(bs)) bs->tfl |= TFL_LAVA|TFL_SLIME;

	if (BotCanAndWantsToRocketJump(bs)) {
		bs->tfl |= TFL_ROCKETJUMP;
	}
	//map specific code
	BotMapScripts(bs);
	//no enemy
	bs->enemy = -1;

	if (bs->killedenemy_time > FloatTime() - 2) {
		if (random() < bs->thinktime * 1) {
			trap_EA_Gesture(bs->client);
		}
	}
	//if there is an enemy
	if (BotFindEnemy(bs, -1)) {
		if (BotWantsToRetreat(bs)) {
			//keep the current long term goal and retreat
			AIEnter_Battle_Retreat(bs, "seek ltg: found enemy");
			return qfalse;
		}
		else {
			trap_BotResetLastAvoidReach(bs->ms);
			//empty the goal stack
			trap_BotEmptyGoalStack(bs->gs);
			//go fight
			AIEnter_Battle_Fight(bs, "seek ltg: found enemy");
			return qfalse;
		}
	}

	//check for nearby goals periodicly
	if (bs->check_time < FloatTime()) {
		bs->check_time = FloatTime() + 0.5;
		//check if the bot wants to camp
		//BotWantsToCamp(bs);	// JUHOX: no camping
		//

		switch (bs->ltgtype) {
		case LTG_DEFENDKEYAREA:
			range = 400;
			break;
		case LTG_CAMP:
			range = 1000;
			break;
		case LTG_ESCAPE:
			range = 600;	// note: we don't have an enemy yet
			break;
		case LTG_WAIT:
			range = 0;
			break;
		case LTG_RUSHBASE:
			if (
				BotOwnFlagStatus(bs) == FLAG_ATBASE ||
				!NearHomeBase(bs->cur_ps.persistant[PERS_TEAM], bs->origin, 4)
			) range = 100;
			else range = 600;
			break;
		case 0:
			range = 1000;

			if (g_gametype.integer >= GT_STU) {
				if (BotPlayerDanger(&bs->cur_ps) >= 25) {
					range = 600;
				}
				else {
					range = 300;
				}
			}

			break;
		default:
			if (BotCTFCarryingFlag(bs)) range = 150;
			else if (LTGNearlyFulfilled(bs)) {
#if BOTS_USE_TSS
				if (
					BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_isValid) &&
					BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_groupFormation) == TSSGF_tight
				) {
					range = 200;
				}
				else
#endif
				{
					range = 1000;
					if (g_gametype.integer >= GT_STU) {
						if (BotPlayerDanger(&bs->cur_ps) >= 25) {
							range = 500;
						}
						else {
							range = 250;
						}
						if (!g_cloakingDevice.integer) range *= 1.5;
					}

				}
			}
			else range = 150;
		}

		if (BotNearbyGoal(bs, bs->tfl, &goal, range)) {
			trap_BotResetLastAvoidReach(bs->ms);
			//get the goal at the top of the stack
			//trap_BotGetTopGoal(bs->gs, &tmpgoal);
			//trap_BotGoalName(tmpgoal.number, buf, 144);
			//BotAI_Print(PRT_MESSAGE, "new nearby goal %s\n", buf);
			//time the bot gets to pick up the nearby goal item
			bs->nbg_time = FloatTime() + 4 + range * 0.01;
			AIEnter_Seek_NBG(bs, "ltg seek: nbg");
			return qfalse;
		}
	}
	// JUHOX: get the LTG after checking for NBG's
	//get the current long term goal
	if (!BotLongTermGoal(bs, bs->tfl, qfalse, &goal)) {
		return qtrue;
	}

	//predict obstacles
	if (BotAIPredictObstacles(bs, &goal))
		return qfalse;
	//initialize the movement state
	BotSetupForMovement(bs);
	//move towards the goal
	trap_BotMoveToGoal(&moveresult, bs->ms, &goal, bs->tfl);
	//if the movement failed
	if (moveresult.failure) {
		//reset the avoid reach, otherwise bot is stuck in current area
		trap_BotResetAvoidReach(bs->ms);
		//BotAI_Print(PRT_MESSAGE, "movement failure %d\n", moveresult.traveltype);
		bs->ltg_time = 0;
		bs->ltgtype = 0;	// JUHOX
		if (goal.flags & GFL_ITEM) BotRememberLTGItemUnreachable(bs, goal.entitynum);	// JUHOX
	}
	//
	BotAIBlocked(bs, &moveresult, qtrue);
	//
	BotClearPath(bs, &moveresult);
	//if the viewangles are used for the movement
	if (moveresult.flags & (MOVERESULT_MOVEMENTVIEWSET|MOVERESULT_MOVEMENTVIEW|MOVERESULT_SWIMVIEW)) {
		VectorCopy(moveresult.ideal_viewangles, bs->ideal_viewangles);
		bs->specialMove = qtrue;	// JUHOX
	}
	//if waiting for something
	else if (moveresult.flags & MOVERESULT_WAITING) {
		if (BotRoamGoal(bs, target, qfalse)) {

			VectorSubtract(target, bs->origin, dir);
			vectoangles(dir, bs->ideal_viewangles);
			bs->ideal_viewangles[2] *= 0.5;
		}
	}
	else if (!(bs->flags & BFL_IDEALVIEWSET)) {
        // JUHOX: look around if nearly reached the ltg
		if (LTGNearlyFulfilled(bs)) {
			if (BotRoamGoal(bs, target, qfalse)) {
				bs->roamgoalcnt--;
				if (bs->roamgoalcnt < 0) {
					bs->roamgoalcnt = 1 + (rand() & 1);
				}
				if (bs->roamgoalcnt > 0) {
					goto SetViewAngles;
				}
			}
			else if (bs->roamgoalcnt > 0) goto ViewAnglesSet;
		}
		else {
			if (BotRoamGoal(bs, target, qtrue)) goto SetViewAngles;
		}

		if (trap_BotMovementViewTarget(bs->ms, &goal, bs->tfl, 300, target)) {
			VectorSubtract(target, bs->origin, dir);
			vectoangles(dir, bs->ideal_viewangles);
		}
		//FIXME: look at cluster portals?
		else if (VectorLengthSquared(moveresult.movedir)) {
			vectoangles(moveresult.movedir, bs->ideal_viewangles);
		}
		// JUHOX: new roaming view strategy
		else if (BotRoamGoal(bs, target, qfalse)) {

			SetViewAngles:	// JUHOX
			VectorSubtract(target, bs->origin, dir);
			vectoangles(dir, bs->ideal_viewangles);
			bs->ideal_viewangles[2] *= 0.5;
		}
	}
	ViewAnglesSet:	// JUHOX
	BotCheckForWeaponJump(bs, &moveresult);	// JUHOX
	//if the weapon is used for the bot movement
	if (moveresult.flags & MOVERESULT_MOVEMENTWEAPON) bs->weaponnum = moveresult.weapon;
	return qtrue;
}

/*
==================
AIEnter_Battle_Fight
==================
*/
void AIEnter_Battle_Fight(bot_state_t *bs, char *s) {
	BotRecordNodeSwitch(bs, "battle fight", "", s);
	trap_BotResetLastAvoidReach(bs->ms);
	bs->ainode = AINode_Battle_Fight;
	bs->flags &= ~BFL_FIGHTSUICIDAL;	// JUHOX BUGFIX (really needed?)
}

/*
==================
AIEnter_Battle_Fight
==================
*/
void AIEnter_Battle_SuicidalFight(bot_state_t *bs, char *s) {
	BotRecordNodeSwitch(bs, "battle fight", "", s);
	trap_BotResetLastAvoidReach(bs->ms);
	bs->ainode = AINode_Battle_Fight;
	bs->flags |= BFL_FIGHTSUICIDAL;
}

/*
==================
AINode_Battle_Fight
==================
*/
int AINode_Battle_Fight(bot_state_t *bs) {
	int areanum;
	vec3_t target;
	aas_entityinfo_t entinfo;
	bot_moveresult_t moveresult;

	if (BotIsObserver(bs)) {
		AIEnter_Observer(bs, "battle fight: observer");
		return qfalse;
	}

	//if in the intermission
	if (BotIntermission(bs)) {
		AIEnter_Intermission(bs, "battle fight: intermission");
		return qfalse;
	}
	//respawn if dead
	if (BotIsDead(bs)) {
		AIEnter_Respawn(bs, "battle fight: bot dead");
		return qfalse;
	}
	//if there is another better enemy
	if (BotFindEnemy(bs, bs->enemy)) {
#ifdef DEBUG
		BotAI_Print(PRT_MESSAGE, "found new better enemy\n");
#endif
	}
	//if no enemy
	if (bs->enemy < 0) {
		AIEnter_Seek_LTG(bs, "battle fight: no enemy");
		return qfalse;
	}
	//
	BotEntityInfo(bs->enemy, &entinfo);
	//if the enemy is dead
	if (bs->enemydeath_time) {
		if (bs->enemydeath_time < FloatTime() - 1.0) {
			bs->enemydeath_time = 0;
			if (bs->enemysuicide) {
				BotChat_EnemySuicide(bs);
			}
			if (bs->lastkilledplayer == bs->enemy && BotChat_Kill(bs)) {
				bs->stand_time = FloatTime() + BotChatTime(bs);
				AIEnter_Stand(bs, "battle fight: enemy dead");
			}
			else {
				bs->ltg_time = 0;
				AIEnter_Seek_LTG(bs, "battle fight: enemy dead");
			}
			return qfalse;
		}
	}
	else {
		if (EntityIsDead(&entinfo)) {
			bs->enemydeath_time = FloatTime();
			bs->check_time = 0;	// JUHOX: the enemy might have lost something (armor, flags, ...)
		}
	}

	VectorCopy(entinfo.origin, target);
	// if not a player enemy
	if (bs->enemy >= MAX_CLIENTS) { // SLK: useless

	}
	//update the reachability area and origin if possible
	areanum = BotPointAreaNum(target);
	if (areanum && trap_AAS_AreaReachability(areanum)) {
		VectorCopy(target, bs->lastenemyorigin);
		bs->lastenemyareanum = areanum;
	}
	//update the attack inventory values
	BotUpdateBattleInventory(bs, bs->enemy);
	//if the bot's health decreased
	if (bs->lastframe_health > bs->inventory[INVENTORY_HEALTH]) {
		if (BotChat_HitNoDeath(bs)) {
			bs->stand_time = FloatTime() + BotChatTime(bs);
			AIEnter_Stand(bs, "battle fight: chat health decreased");
			return qfalse;
		}
	}
	//if the bot hit someone
	if (bs->cur_ps.persistant[PERS_HITS] > bs->lasthitcount) {
		if (BotChat_HitNoKill(bs)) {
			bs->stand_time = FloatTime() + BotChatTime(bs);
			AIEnter_Stand(bs, "battle fight: chat hit someone");
			return qfalse;
		}
	}
	//if the enemy is not visible
	if (!BotEntityVisible(&bs->cur_ps, 360, bs->enemy)) {	// JUHOX
		bs->flags ^= BFL_STRAFERIGHT;	// JUHOX: the enemy may be vanished because of an unlucky attack move
		if (BotWantsToChase(bs)) {
			AIEnter_Battle_Chase(bs, "battle fight: enemy out of sight");
			return qfalse;
		}
		else {
			AIEnter_Seek_LTG(bs, "battle fight: enemy out of sight");
			return qfalse;
		}
	}
	bs->lastEnemyAreaPredicted = qfalse;	// JUHOX
	bs->enemyvisible_time = FloatTime();	// JUHOX: needed for the "contact"-message
	//use holdable items
	BotBattleUseItems(bs);
	//
	bs->tfl = TFL_DEFAULT;
	if (bot_grapple.integer) bs->tfl |= TFL_GRAPPLEHOOK;
	//if in lava or slime the bot should be able to get out
	if (BotInLavaOrSlime(bs)) bs->tfl |= TFL_LAVA|TFL_SLIME;
	//
	if (BotCanAndWantsToRocketJump(bs)) {
		bs->tfl |= TFL_ROCKETJUMP;
	}

	// JUHOX: check for nearby goals periodicly
	if (bs->check_time < FloatTime()) {
		bot_goal_t goal;

		bs->check_time = FloatTime() + 1;

		if (BotNearbyGoal(bs, bs->tfl, &goal, 300)) {
			bs->nbg_time = FloatTime() + 3;
			trap_BotResetLastAvoidReach(bs->ms);
			AIEnter_Battle_NBG(bs, "battle fight: going for NBG");
			return qfalse;
		}
	}

	//choose the best weapon to fight with
	BotChooseWeapon(bs);
	//do attack movements
	moveresult = BotAttackMove(bs, bs->tfl);
	//if the movement failed
	if (moveresult.failure) {
		//reset the avoid reach, otherwise bot is stuck in current area
		trap_BotResetAvoidReach(bs->ms);
		bs->ltg_time = 0;
	}
	//
	BotAIBlocked(bs, &moveresult, qfalse);
	//aim at the enemy
	BotAimAtEnemy(bs);
	//attack the enemy if possible
	BotCheckAttack(bs);
	//if the bot wants to retreat
	if (!(bs->flags & BFL_FIGHTSUICIDAL)) {
		if (BotWantsToRetreat(bs)) {
			AIEnter_Battle_Retreat(bs, "battle fight: wants to retreat");
			return qtrue;
		}
	}
	return qtrue;
}

/*
==================
AIEnter_Battle_Chase
==================
*/
void AIEnter_Battle_Chase(bot_state_t *bs, char *s) {
	BotRecordNodeSwitch(bs, "battle chase", "", s);
	bs->chase_time = FloatTime();
	bs->chasearea = bs->areanum;	// JUHOX
	VectorCopy(bs->origin, bs->chaseorigin);	// JUHOX
	bs->ainode = AINode_Battle_Chase;
}

/*
==================
AINode_Battle_Chase
==================
*/
int AINode_Battle_Chase(bot_state_t *bs)
{
	bot_goal_t goal;
	vec3_t target, dir;
	bot_moveresult_t moveresult;
	float range;

	if (BotIsObserver(bs)) {
		AIEnter_Observer(bs, "battle chase: observer");
		return qfalse;
	}
	//if in the intermission
	if (BotIntermission(bs)) {
		AIEnter_Intermission(bs, "battle chase: intermission");
		return qfalse;
	}
	//respawn if dead
	if (BotIsDead(bs)) {
		AIEnter_Respawn(bs, "battle chase: bot dead");
		return qfalse;
	}
	//if no enemy
	if (bs->enemy < 0) {
		AIEnter_Seek_LTG(bs, "battle chase: no enemy");
		return qfalse;
	}
	// JUHOX: don't chase a dead enemy
	if (g_entities[bs->enemy].health <= 0) {
		AIEnter_Seek_LTG(bs, "battle chase: enemy dead");
		return qfalse;
	}

	//if the enemy is visible
	if (BotEntityVisible(&bs->cur_ps, 90, bs->enemy)) {	// JUHOX: fov was 360
		AIEnter_Battle_Fight(bs, "battle chase");
		return qfalse;
	}
	//if there is another enemy
	if (BotFindEnemy(bs, -1)) {
		AIEnter_Battle_Fight(bs, "battle chase: better enemy");
		return qfalse;
	}
	//there is no last enemy area
	if (!bs->lastenemyareanum) {
		AIEnter_Seek_LTG(bs, "battle chase: no enemy area");
		return qfalse;
	}
	//
	bs->tfl = TFL_DEFAULT;
	if (bot_grapple.integer) bs->tfl |= TFL_GRAPPLEHOOK;
	//if in lava or slime the bot should be able to get out
	if (BotInLavaOrSlime(bs)) bs->tfl |= TFL_LAVA|TFL_SLIME;
	//
	if (BotCanAndWantsToRocketJump(bs)) {
		bs->tfl |= TFL_ROCKETJUMP;
	}
	//map specific code
	BotMapScripts(bs);
	//create the chase goal
	goal.entitynum = bs->enemy;
	goal.areanum = bs->lastenemyareanum;
	VectorCopy(bs->lastenemyorigin, goal.origin);
	VectorSet(goal.mins, -8, -8, -8);
	VectorSet(goal.maxs, 8, 8, 8);
	//if the last seen enemy spot is reached the enemy could not be found
	// JUHOX: if the enemy is not found try to predict his goal

	if (trap_BotTouchingGoal(bs->origin, &goal)) {
		if (bs->chasearea) {
			playerState_t ps;

			if (!BotAI_GetClientState(bs->enemy, &ps)) goto NoChase;
			if (!FindEscapeGoal(&ps, bs->lastenemyareanum, 0, bs->chasearea, bs->chaseorigin, &goal)) goto NoChase;

			bs->lastenemyareanum = goal.areanum;
			VectorCopy(goal.origin, bs->lastenemyorigin);
			bs->lastEnemyAreaPredicted = qtrue;
			bs->chasearea = 0;
		}
		else {
			NoChase:
			bs->chase_time = 0;
		}
	}

	if (!BotWantsToChase(bs)) bs->chase_time = 0;	// JUHOX
	//if there's no chase time left
	if (!bs->chase_time || bs->chase_time < FloatTime() - /*10*/30) {	// JUHOX
		AIEnter_Seek_LTG(bs, "battle chase: time out");
		return qfalse;
	}
	//check for nearby goals periodicly
	if (bs->check_time < FloatTime()) {
		bs->check_time = FloatTime() + 1;
		range = 150;
		//
		if (BotNearbyGoal(bs, bs->tfl, &goal, range)) {
			//the bot gets 5 seconds to pick up the nearby goal item
			bs->nbg_time = FloatTime() + 0.1 * range + 1;
			trap_BotResetLastAvoidReach(bs->ms);
			AIEnter_Battle_NBG(bs, "battle chase: nbg");
			return qfalse;
		}
	}

	BotUpdateBattleInventory(bs, bs->enemy);
	//initialize the movement state
	BotSetupForMovement(bs);
	//move towards the goal
	trap_BotMoveToGoal(&moveresult, bs->ms, &goal, bs->tfl);
	//if the movement failed
	if (moveresult.failure) {
		//reset the avoid reach, otherwise bot is stuck in current area
		trap_BotResetAvoidReach(bs->ms);
		//BotAI_Print(PRT_MESSAGE, "movement failure %d\n", moveresult.traveltype);
		bs->ltg_time = 0;
		bs->ltgtype = 0;	// JUHOX
	}

	BotAIBlocked(bs, &moveresult, qfalse);

	if (moveresult.flags & (MOVERESULT_MOVEMENTVIEWSET|MOVERESULT_MOVEMENTVIEW|MOVERESULT_SWIMVIEW)) {
		VectorCopy(moveresult.ideal_viewangles, bs->ideal_viewangles);
		bs->specialMove = qtrue;	// JUHOX
	}
	else if (!(bs->flags & BFL_IDEALVIEWSET)) {
		if (bs->chase_time > FloatTime() - 2) {
			bs->lastEnemyAreaPredicted = !bs->chasearea;	// JUHOX
			BotAimAtEnemy(bs);

			// JUHOX: if the enemy sight is lost just a few seconds before don't stop the machine gun
			if ( bs->weaponnum == WP_MACHINEGUN && bs->cur_ps.weaponstate >= WEAPON_FIRING ) {
				BotCheckAttack(bs);
			}
		}
		else {
			// JUHOX: react upon audible stimuli
			if (BotRoamGoal(bs, target, qtrue)) {
				VectorSubtract(target, bs->origin, dir);
				vectoangles(dir, bs->ideal_viewangles);
			} else if (trap_BotMovementViewTarget(bs->ms, &goal, bs->tfl, 300, target)) {
				VectorSubtract(target, bs->origin, dir);
				vectoangles(dir, bs->ideal_viewangles);
			} else {
				vectoangles(moveresult.movedir, bs->ideal_viewangles);
			}
		}
		bs->ideal_viewangles[2] *= 0.5;
	}
	BotCheckForWeaponJump(bs, &moveresult);	// JUHOX
	//if the weapon is used for the bot movement
	if (moveresult.flags & MOVERESULT_MOVEMENTWEAPON) bs->weaponnum = moveresult.weapon;
	//if the bot is in the area the enemy was last seen in
	if (bs->areanum == bs->lastenemyareanum) bs->chase_time = 0;
	//if the bot wants to retreat (the bot could have been damage during the chase)
	return qtrue;
}

/*
==================
AIEnter_Battle_Retreat
==================
*/
void AIEnter_Battle_Retreat(bot_state_t *bs, char *s) {
	BotRecordNodeSwitch(bs, "battle retreat", "", s);
	bs->ainode = AINode_Battle_Retreat;
}

/*
==================
AINode_Battle_Retreat
==================
*/
int AINode_Battle_Retreat(bot_state_t *bs) {
	bot_goal_t goal;
	aas_entityinfo_t entinfo;
	bot_moveresult_t moveresult;
	vec3_t target, dir;
	float attack_skill, range;
	int areanum;
	qboolean goalAvailable;	// JUHOX

	if (BotIsObserver(bs)) {
		AIEnter_Observer(bs, "battle retreat: observer");
		return qfalse;
	}
	//if in the intermission
	if (BotIntermission(bs)) {
		AIEnter_Intermission(bs, "battle retreat: intermission");
		return qfalse;
	}
	//respawn if dead
	if (BotIsDead(bs)) {
		AIEnter_Respawn(bs, "battle retreat: bot dead");
		return qfalse;
	}
	//if no enemy
	if (bs->enemy < 0) {
		AIEnter_Seek_LTG(bs, "battle retreat: no enemy");
		return qfalse;
	}

	BotEntityInfo(bs->enemy, &entinfo);
	if (EntityIsDead(&entinfo)) {
		AIEnter_Seek_LTG(bs, "battle retreat: enemy dead");
		return qfalse;
	}
	//if there is another better enemy
	if (BotFindEnemy(bs, bs->enemy)) {
#ifdef DEBUG
		BotAI_Print(PRT_MESSAGE, "found new better enemy\n");
#endif
	}
	//
	bs->tfl = TFL_DEFAULT;
	if (bot_grapple.integer) bs->tfl |= TFL_GRAPPLEHOOK;
	//if in lava or slime the bot should be able to get out
	if (BotInLavaOrSlime(bs)) bs->tfl |= TFL_LAVA|TFL_SLIME;
	//map specific code
	BotMapScripts(bs);
	//update the attack inventory values
	BotUpdateBattleInventory(bs, bs->enemy);
	//if the bot doesn't want to retreat anymore... probably picked up some nice items
	if (BotWantsToChase(bs)) {
		//empty the goal stack, when chasing, only the enemy is the goal
		trap_BotEmptyGoalStack(bs->gs);
		//go chase the enemy
		AIEnter_Battle_Chase(bs, "battle retreat: wants to chase");
		return qfalse;
	}
	//update the last time the enemy was visible
	if (BotEntityVisible(&bs->cur_ps, 360, bs->enemy)) {	// JUHOX
		bs->enemyvisible_time = FloatTime();
		VectorCopy(entinfo.origin, target);
		// if not a player enemy
		if (bs->enemy >= MAX_CLIENTS) { //SLK : useless

		}
		//update the reachability area and origin if possible
		areanum = BotPointAreaNum(target);
		if (areanum && trap_AAS_AreaReachability(areanum)) {
			VectorCopy(target, bs->lastenemyorigin);
			bs->lastenemyareanum = areanum;
			bs->lastEnemyAreaPredicted = qfalse;	// JUHOX
		}
	}
	// JUHOX: if the enemy is no longer visible and there's something important to do
	if (bs->enemyvisible_time < FloatTime() - 1 && bs->ltgtype != 0 && bs->ltgtype != LTG_WAIT) {
		AIEnter_Seek_LTG(bs, "battle retreat: ignore enemy");
		return qfalse;
	}

	//if the enemy is NOT visible for 4 seconds
	if (bs->enemyvisible_time < FloatTime() - 4) {
		AIEnter_Seek_LTG(bs, "battle retreat: lost enemy");
		return qfalse;
	}

	//use holdable items
	BotBattleUseItems(bs);
	BotSetEscapeGoal(bs);	// JUHOX
	//get the current long term goal while retreating
	// JUHOX: if no LTG available, just do an attack move, but no suicidal fighting
	goalAvailable = BotLongTermGoal(bs, bs->tfl, qtrue, &goal);

	//check for nearby goals periodicly
	if (bs->check_time < FloatTime()) {
		bs->check_time = FloatTime() + /*1*/0.5;	// JUHOX
		range = /*150*/300;	// JUHOX
#ifdef CTF
		if (gametype == GT_CTF) {
			//if carrying a flag the bot shouldn't be distracted too much
			// JUHOX: if the own flag isn't at base use a greater range

			if (BotCTFCarryingFlag(bs)) {
				if (
					BotOwnFlagStatus(bs) == FLAG_ATBASE ||
					!NearHomeBase(bs->cur_ps.persistant[PERS_TEAM], bs->origin, 4)
				) {
					range = 50;
				}
				else {
					range = 200;
				}
			}
		}
#endif //CTF

		if (BotNearbyGoal(bs, bs->tfl, &goal, range)) {
			trap_BotResetLastAvoidReach(bs->ms);
			//time the bot gets to pick up the nearby goal item
			bs->nbg_time = FloatTime() + range / 100 + 1;
			if (bs->getImportantNBGItem || bs->nbgGivesPODMarker) bs->nbg_time += 5.0;	// JUHOX
			AIEnter_Battle_NBG(bs, "battle retreat: nbg");
			return qfalse;
		}
	}
	//initialize the movement state
	BotSetupForMovement(bs);
	//move towards the goal
	// JUHOX: do an attack move if no goal available

	if (
		goalAvailable &&
		(
			goal.entitynum != bs->enemy ||
			DistanceSquared(goal.origin, bs->origin) > 450*450
		) &&
		(
			bs->ltgtype != LTG_RUSHBASE ||
			BotOwnFlagStatus(bs) == FLAG_ATBASE ||
			DistanceSquared(goal.origin, bs->origin) > 300*300
		)
	) {
		trap_BotMoveToGoal(&moveresult, bs->ms, &goal, bs->tfl);
	}
	else {
		moveresult = BotAttackMove(bs, bs->tfl);
	}

	//if the movement failed
	if (moveresult.failure) {
		//reset the avoid reach, otherwise bot is stuck in current area
		trap_BotResetAvoidReach(bs->ms);
		//BotAI_Print(PRT_MESSAGE, "movement failure %d\n", moveresult.traveltype);
		bs->ltg_time = 0;
		bs->ltgtype = 0;	// JUHOX
	}

	BotAIBlocked(bs, &moveresult, qfalse);
	//choose the best weapon to fight with
	BotChooseWeapon(bs);
	//if the view is fixed for the movement
	if (moveresult.flags & (MOVERESULT_MOVEMENTVIEW|MOVERESULT_SWIMVIEW)) {
		VectorCopy(moveresult.ideal_viewangles, bs->ideal_viewangles);
		bs->specialMove = qtrue;	// JUHOX
	}
	else if (!(moveresult.flags & MOVERESULT_MOVEMENTVIEWSET)
				&& !(bs->flags & BFL_IDEALVIEWSET) ) {
		attack_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_ATTACK_SKILL, 0, 1);
		//if the bot is skilled anough
		if (attack_skill > 0.3) {
			BotAimAtEnemy(bs);
		}
		else {
			if (trap_BotMovementViewTarget(bs->ms, &goal, bs->tfl, 300, target)) {
				VectorSubtract(target, bs->origin, dir);
				vectoangles(dir, bs->ideal_viewangles);
			}
			else {
				vectoangles(moveresult.movedir, bs->ideal_viewangles);
			}
			bs->ideal_viewangles[2] *= 0.5;
		}
	}
	BotCheckForWeaponJump(bs, &moveresult);	// JUHOX
	//if the weapon is used for the bot movement
	if (moveresult.flags & MOVERESULT_MOVEMENTWEAPON) bs->weaponnum = moveresult.weapon;
	//attack the enemy if possible
	BotCheckAttack(bs);
	//
	return qtrue;
}

/*
==================
AIEnter_Battle_NBG
==================
*/
void AIEnter_Battle_NBG(bot_state_t *bs, char *s) {
	// JUHOX: record more info for 'battle NBG'
	bot_goal_t goal;
	char buf[144];

	if (trap_BotGetTopGoal(bs->gs, &goal)) {
		trap_BotGoalName(goal.number, buf, 144);
		BotRecordNodeSwitch(bs, "battle NBG", buf, s);
	}
	else {
		BotRecordNodeSwitch(bs, "battle NBG", "no goal", s);
	}

	bs->ainode = AINode_Battle_NBG;
}

/*
==================
AINode_Battle_NBG
==================
*/
int AINode_Battle_NBG(bot_state_t *bs) {
	int areanum;
	bot_goal_t goal;
	aas_entityinfo_t entinfo;
	bot_moveresult_t moveresult;
	float attack_skill;
	vec3_t target, dir;

	if (BotIsObserver(bs)) {
		AIEnter_Observer(bs, "battle nbg: observer");
		return qfalse;
	}
	//if in the intermission
	if (BotIntermission(bs)) {
		AIEnter_Intermission(bs, "battle nbg: intermission");
		return qfalse;
	}
	//respawn if dead
	if (BotIsDead(bs)) {
		AIEnter_Respawn(bs, "battle nbg: bot dead");
		return qfalse;
	}
	//if no enemy
	if (bs->enemy < 0) {
		AIEnter_Seek_NBG(bs, "battle nbg: no enemy");
		return qfalse;
	}

	BotEntityInfo(bs->enemy, &entinfo);
	if (EntityIsDead(&entinfo)) {
		AIEnter_Seek_NBG(bs, "battle nbg: enemy dead");
		return qfalse;
	}

	bs->tfl = TFL_DEFAULT;
	if (bot_grapple.integer) bs->tfl |= TFL_GRAPPLEHOOK;
	//if in lava or slime the bot should be able to get out
	if (BotInLavaOrSlime(bs)) bs->tfl |= TFL_LAVA|TFL_SLIME;
	//
	if (BotCanAndWantsToRocketJump(bs)) {
		bs->tfl |= TFL_ROCKETJUMP;
	}
	//map specific code
	BotMapScripts(bs);
	//update the last time the enemy was visible
	if (BotEntityVisible(&bs->cur_ps, 90, bs->enemy)) {	// JUHOX: fov was 360
		bs->enemyvisible_time = FloatTime();
		VectorCopy(entinfo.origin, target);
		// if not a player enemy
		if (bs->enemy >= MAX_CLIENTS) { // SLK : useless

		}
		//update the reachability area and origin if possible
		areanum = BotPointAreaNum(target);
		if (areanum && trap_AAS_AreaReachability(areanum)) {
			VectorCopy(target, bs->lastenemyorigin);
			bs->lastenemyareanum = areanum;
			bs->lastEnemyAreaPredicted = qfalse;	// JUHOX
		}
	}
	//if the bot has no goal or touches the current goal
	if (!trap_BotGetTopGoal(bs->gs, &goal)) {
		bs->nbg_time = 0;
	}
	else if (BotReachedGoal(bs, &goal)) {
		bs->nbg_time = 0;
	}

	if (bs->nbg_time < FloatTime()) {
		//pop the current goal from the stack
		trap_BotPopGoal(bs->gs);
		//if the bot still has a goal
		if (trap_BotGetTopGoal(bs->gs, &goal))
			AIEnter_Battle_Retreat(bs, "battle nbg: time out");
		else
			AIEnter_Battle_Fight(bs, "battle nbg: time out");
		//
		return qfalse;
	}
	//initialize the movement state
	BotSetupForMovement(bs);
	//move towards the goal
	trap_BotMoveToGoal(&moveresult, bs->ms, &goal, bs->tfl);
	//if the movement failed
	if (moveresult.failure) {
		//reset the avoid reach, otherwise bot is stuck in current area
		trap_BotResetAvoidReach(bs->ms);
		bs->nbg_time = 0;
	}

	BotAIBlocked(bs, &moveresult, qfalse);
	//update the attack inventory values
	BotUpdateBattleInventory(bs, bs->enemy);
	//choose the best weapon to fight with
	BotChooseWeapon(bs);
	//if the view is fixed for the movement
	if (moveresult.flags & (MOVERESULT_MOVEMENTVIEW|MOVERESULT_SWIMVIEW)) {
		VectorCopy(moveresult.ideal_viewangles, bs->ideal_viewangles);
		bs->specialMove = qtrue;	// JUHOX
	}
	else if (!(moveresult.flags & MOVERESULT_MOVEMENTVIEWSET)
				&& !(bs->flags & BFL_IDEALVIEWSET)) {
		attack_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_ATTACK_SKILL, 0, 1);
		//if the bot is skilled anough and the enemy is visible
		if (attack_skill > 0.3) {
			BotAimAtEnemy(bs);
		}
		else {
			if (trap_BotMovementViewTarget(bs->ms, &goal, bs->tfl, 300, target)) {
				VectorSubtract(target, bs->origin, dir);
				vectoangles(dir, bs->ideal_viewangles);
			}
			else {
				vectoangles(moveresult.movedir, bs->ideal_viewangles);
			}
			bs->ideal_viewangles[2] *= 0.5;
		}
	}
	BotCheckForWeaponJump(bs, &moveresult);	// JUHOX
	//if the weapon is used for the bot movement
	if (moveresult.flags & MOVERESULT_MOVEMENTWEAPON) bs->weaponnum = moveresult.weapon;
	//attack the enemy if possible
	BotCheckAttack(bs);
	//
	return qtrue;
}
