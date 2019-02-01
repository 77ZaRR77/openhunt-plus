// Copyright (C) 1999-2000 Id Software, Inc.
//

/*****************************************************************************
 * name:		ai_team.c
 *
 * desc:		Quake3 bot AI
 *
 * $Archive: /MissionPack/code/game/ai_team.c $
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
#include "ai_vcmd.h"

#include "match.h"
#include "inv.h"	// JUHOX: for MODELINDEX_TELEPORTER

// for the voice chats
#include "../../ui/menudef.h"

//ctf task preferences for a client
typedef struct bot_ctftaskpreference_s
{
	char		name[36];
	int			preference;
} bot_ctftaskpreference_t;

bot_ctftaskpreference_t ctftaskpreferences[MAX_CLIENTS];


/*
==================
JUHOX: BotOwnFlagStatus
==================
*/
flagStatus_t BotOwnFlagStatus(bot_state_t* bs) {
	return Team_GetFlagStatus(bs->cur_ps.persistant[PERS_TEAM]);
}

/*
==================
JUHOX: BotEnemyFlagStatus
==================
*/
flagStatus_t BotEnemyFlagStatus(bot_state_t* bs) {
	return Team_GetFlagStatus(OtherTeam(bs->cur_ps.persistant[PERS_TEAM]));
}

/*
==================
JUHOX: BotGetHomeBase
==================
*/
const bot_goal_t* BotGetHomeBase(bot_state_t* bs) {
	switch (bs->cur_ps.persistant[PERS_TEAM]) {
	case TEAM_RED:
		return &ctf_redflag;
	case TEAM_BLUE:
	default:
		return &ctf_blueflag;
	}
}

/*
==================
JUHOX: BotGetEnemyBase
==================
*/
const bot_goal_t* BotGetEnemyBase(bot_state_t* bs) {
	switch (bs->cur_ps.persistant[PERS_TEAM]) {
	case TEAM_RED:
		return &ctf_blueflag;
	case TEAM_BLUE:
	default:
		return &ctf_redflag;
	}
}

/*
==================
BotValidTeamLeader
==================
*/
// JUHOX: BotValidTeamLeader() no longer needed
#if 0
int BotValidTeamLeader(bot_state_t *bs) {
#if !RESPAWN_DELAY	// JUHOX: don't accept dead teamleaders
	if (!strlen(bs->teamleader)) return qfalse;
	if (ClientFromName(bs->teamleader) == -1) return qfalse;
	return qtrue;
#else
	/*
	int client;
	playerState_t ps;

	if (!bs->teamleader[0]) return qfalse;
	client = ClientFromName(bs->teamleader);
	if (client < 0) return qfalse;
	if (!BotAI_GetClientState(client, &ps)) return qfalse;
	if (ps.stats[STAT_HEALTH] > 0) return qtrue;
	if (ps.stats[STAT_RESPAWN_TIMER] < 10) return qtrue;
	return qfalse;
	*/
	return bs->leader >= 0;
#endif
}
#endif

/*
==================
JUHOX: BotTeamleaderReachable
==================
*/
void BotTeamleaderReachable(bot_state_t* bs) {
	bs->teamleadernotreachable = qfalse;
	bs->teamleaderreachable_time = FloatTime();
	bs->travelLavaAndSlime_time = 0;
}

/*
==================
JUHOX: BotTeamleaderNotReachable
==================
*/
void BotTeamleaderNotReachable(bot_state_t* bs) {
	bs->teamleadernotreachable = qtrue;
	if (bs->teamleaderreachable_time < FloatTime() - 10) {
		if (bs->cur_ps.stats[STAT_HOLDABLE_ITEM] == MODELINDEX_TELEPORTER) {
			BotTeamleaderReachable(bs);
			trap_EA_Use(bs->client);
		}
		else {
			bs->travelLavaAndSlime_time = FloatTime() + 5;
		}
	}
}

/*
==================
BotNumTeamMates
==================
*/
int BotNumTeamMates(bot_state_t *bs) {
	int i, numplayers;
	char buf[MAX_INFO_STRING];
	static int maxclients;

	if (!maxclients)
		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");

	numplayers = 0;
	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
		//if no config string or no name
		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n"))) continue;
		//skip spectators
		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) continue;
		//
		if (BotSameTeam(bs, i)) {
			numplayers++;
		}
	}
	return numplayers;
}

/*
==================
JUHOX: BotGetNextPlayer
- returns -1 if there are no more players
- does not return the bot itself (if bs != NULL)
- use lastPlayer=-1 for first call
==================
*/
int BotGetNextPlayer(bot_state_t* bs, int lastPlayer, playerState_t* ps) {
	int currentClient;

	for (
		currentClient = lastPlayer + 1;
		currentClient < level.maxclients;
		currentClient++
	) {
		if (bs && bs->entitynum == currentClient) continue;
		if (!g_entities[currentClient].inuse) continue;
		if (!g_entities[currentClient].client) continue;
		if (g_entities[currentClient].client->pers.connected != CON_CONNECTED) continue;
		if (g_entities[currentClient].client->sess.sessionTeam == TEAM_SPECTATOR) continue;
		if (g_entities[currentClient].client->tssSafetyMode) continue;
		if (!BotAI_GetClientState(currentClient, ps)) continue;
		return currentClient;
	}
	return -1;
}

/*
==================
JUHOX: BotGetNextPlayerOrMonster
- returns -1 if there are no more players
- does not return the bot itself (if bs != NULL)
- use lastPlayer=-1 for first call
==================
*/
int BotGetNextPlayerOrMonster(bot_state_t* bs, int lastPlayer, playerState_t* ps) {
	int currentClient;

	if (lastPlayer < MAX_CLIENTS) {
		lastPlayer = BotGetNextPlayer(bs, lastPlayer, ps);
		if (lastPlayer >= 0) return lastPlayer;
		lastPlayer = MAX_CLIENTS - 1;
	}
	for (
		currentClient = lastPlayer + 1;
		currentClient < level.num_entities;
		currentClient++
	) {
		if (bs && bs->entitynum == currentClient) continue;
		if (!BotAI_GetClientState(currentClient, ps)) continue;
		return currentClient;
	}
	return -1;
}

/*
==================
JUHOX: BotGetNextTeamMate
- returns -1 if there are no more team mates
- does not return the bot itself
- use lastTeamMate=-1 for first call
==================
*/
int BotGetNextTeamMate(bot_state_t* bs, int lastTeamMate, playerState_t* ps) {
	int player;

	if (gametype < GT_TEAM) return -1;

	for (player = lastTeamMate; (player = BotGetNextPlayer(bs, player, ps)) >= 0;) {
		if (bs->cur_ps.persistant[PERS_TEAM] == ps->persistant[PERS_TEAM]) {
			return player;
		}
	}
	return -1;
}

/*
==================
JUHOX: BotDetermineVisibleTeammates
==================
*/
void BotDetermineVisibleTeammates(bot_state_t* bs) {
	int teammate;
	playerState_t ps;

	if (gametype < GT_TEAM) {
		bs->numvisteammates = 0;
		return;
	}
	if (FloatTime() < bs->visteammates_time) return;
	bs->visteammates_time = FloatTime() + 1 + random();

	bs->numvisteammates = 0;
	for (teammate = -1; (teammate = BotGetNextTeamMate(bs, teammate, &ps)) >= 0;) {
		if (ps.stats[STAT_HEALTH] <= 0) continue;
		if (DistanceSquared(bs->origin, ps.origin) > 1200.0*1200.0) continue;
		if (BotEntityVisible(&bs->cur_ps, 360, teammate)) {
			bs->visteammates[bs->numvisteammates++] = teammate;
		}
	}
}

#if 0	// JUHOX: BotClientTravelTimeToGoal() not needed
/*
==================
BotClientTravelTimeToGoal
==================
*/
int BotClientTravelTimeToGoal(int client, bot_goal_t *goal) {
	playerState_t ps;
	int areanum;

	BotAI_GetClientState(client, &ps);
	areanum = BotPointAreaNum(ps.origin);
	if (!areanum) return 1;
	return trap_AAS_AreaTravelTimeToGoalArea(areanum, ps.origin, goal->areanum, TFL_DEFAULT);
}
#endif

#if 0	// JUHOX: BotSortTeamMatesByBaseTravelTime() not needed
/*
==================
BotSortTeamMatesByBaseTravelTime
==================
*/
int BotSortTeamMatesByBaseTravelTime(bot_state_t *bs, int *teammates, int maxteammates) {

	int i, j, k, numteammates, traveltime;
	char buf[MAX_INFO_STRING];
	static int maxclients;
	int traveltimes[MAX_CLIENTS];
	bot_goal_t *goal = NULL;

	if (gametype == GT_CTF || gametype == GT_1FCTF) {
		if (BotTeam(bs) == TEAM_RED)
			goal = &ctf_redflag;
		else
			goal = &ctf_blueflag;
	}

	if (!maxclients)
		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");

	numteammates = 0;
	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
		//if no config string or no name
		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n"))) continue;
		//skip spectators
		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) continue;
		//
		if (BotSameTeam(bs, i)) {
			//
			traveltime = BotClientTravelTimeToGoal(i, goal);
			//
			for (j = 0; j < numteammates; j++) {
				if (traveltime < traveltimes[j]) {
					for (k = numteammates; k > j; k--) {
						traveltimes[k] = traveltimes[k-1];
						teammates[k] = teammates[k-1];
					}
					break;
				}
			}
			traveltimes[j] = traveltime;
			teammates[j] = i;
			numteammates++;
			if (numteammates >= maxteammates) break;
		}
	}
	return numteammates;
}
#endif

/*
==================
BotSetTeamMateTaskPreference
==================
*/
void BotSetTeamMateTaskPreference(bot_state_t *bs, int teammate, int preference) {
	char teammatename[MAX_NETNAME];

	ctftaskpreferences[teammate].preference = preference;
	ClientName(teammate, teammatename, sizeof(teammatename));
	strcpy(ctftaskpreferences[teammate].name, teammatename);
}

/*
==================
BotGetTeamMateTaskPreference
==================
*/
int BotGetTeamMateTaskPreference(bot_state_t *bs, int teammate) {
	char teammatename[MAX_NETNAME];

	if (!ctftaskpreferences[teammate].preference) return 0;
	ClientName(teammate, teammatename, sizeof(teammatename));
	if (Q_stricmp(teammatename, ctftaskpreferences[teammate].name)) return 0;
	return ctftaskpreferences[teammate].preference;
}

#if 0	// JUHOX: BotSortTeamMatesByTaskPreference() not needed
/*
==================
BotSortTeamMatesByTaskPreference
==================
*/
int BotSortTeamMatesByTaskPreference(bot_state_t *bs, int *teammates, int numteammates) {
	int defenders[MAX_CLIENTS], numdefenders;
	int attackers[MAX_CLIENTS], numattackers;
	int roamers[MAX_CLIENTS], numroamers;
	int i, preference;

	numdefenders = numattackers = numroamers = 0;
	for (i = 0; i < numteammates; i++) {
		preference = BotGetTeamMateTaskPreference(bs, teammates[i]);
		if (preference & TEAMTP_DEFENDER) {
			defenders[numdefenders++] = teammates[i];
		}
		else if (preference & TEAMTP_ATTACKER) {
			attackers[numattackers++] = teammates[i];
		}
		else {
			roamers[numroamers++] = teammates[i];
		}
	}
	numteammates = 0;
	//defenders at the front of the list
	memcpy(&teammates[numteammates], defenders, numdefenders * sizeof(int));
	numteammates += numdefenders;
	//roamers in the middle
	memcpy(&teammates[numteammates], roamers, numroamers * sizeof(int));
	numteammates += numroamers;
	//attacker in the back of the list
	memcpy(&teammates[numteammates], attackers, numattackers * sizeof(int));
	numteammates += numattackers;

	return numteammates;
}
#endif

/*
==================
BotSayTeamOrders
==================
*/
void BotSayTeamOrderAlways(bot_state_t *bs, int toclient) {
	char teamchat[MAX_MESSAGE_SIZE];
	char buf[MAX_MESSAGE_SIZE];
	char name[MAX_NETNAME];

	//if the bot is talking to itself
	if (bs->client == toclient) {
		//don't show the message just put it in the console message queue
		trap_BotGetChatMessage(bs->cs, buf, sizeof(buf));
		ClientName(bs->client, name, sizeof(name));
		Com_sprintf(teamchat, sizeof(teamchat), EC"(%s"EC")"EC": %s", name, buf);
		trap_BotQueueConsoleMessage(bs->cs, CMS_CHAT, teamchat);
	}
	else {
		trap_BotEnterChat(bs->cs, toclient, CHAT_TELL);
	}
}

/*
==================
BotSayTeamOrders
==================
*/
void BotSayTeamOrder(bot_state_t *bs, int toclient) {
	BotSayTeamOrderAlways(bs, toclient);
}

/*
==================
BotVoiceChat
==================
*/
void BotVoiceChat(bot_state_t *bs, int toclient, char *voicechat) { // SLK: remove
}

/*
==================
BotVoiceChatOnly
==================
*/
void BotVoiceChatOnly(bot_state_t *bs, int toclient, char *voicechat) { // SLK: remove
}

/*
==================
BotSayVoiceTeamOrder
==================
*/
void BotSayVoiceTeamOrder(bot_state_t *bs, int toclient, char *voicechat) { // SLK :remove
}

/*
==================
JUHOX: BotFindTeamMateInFront
==================
*/
int BotFindTeamMateInFront(bot_state_t* bs, int leader, const int* teamMates, int numTeamMates) {
	int bestTravelTime;
	int bestTeamMate;
	int botLeaderTravelTime;
	int numTeamMatesNearToLeader;
	int leaderArea;
	playerState_t ps;
	int i;

	if (!BotAI_GetClientState(leader, &ps)) return -1;
	if (ps.stats[STAT_HEALTH] <= 0) return -1;
	if (bs->areanum <= 0) return leader;
	if (!trap_AAS_AreaReachability(bs->areanum)) return leader;

	if (numTeamMates <= 0) return leader;

	if (
		g_gametype.integer == GT_STU &&
		g_artefacts.integer >= 999 &&
		level.sortedClients[level.numPlayingClients-1] == bs->client
	) {
		return leader;
	}

	leaderArea = BotPointAreaNum(ps.origin);
	if (leaderArea <= 0 || !trap_AAS_AreaReachability(leaderArea)) {
		BotTeamleaderNotReachable(bs);
		return -1;
	}
	botLeaderTravelTime = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, leaderArea, bs->tfl);
	if (botLeaderTravelTime <= 0) {
		BotTeamleaderNotReachable(bs);
		return -1;
	}
	BotTeamleaderReachable(bs);
	//if (botLeaderTravelTime > 600) return leader;

	bestTeamMate = leader;
	bestTravelTime = botLeaderTravelTime;
	numTeamMatesNearToLeader = 0;

	for (i = 0; i < numTeamMates; i++) {
		int travelTime;
		int teamMateArea;

		if (!BotAI_GetClientState(teamMates[i], &ps)) continue;
		if (ps.stats[STAT_HEALTH] <= 0) continue;
		teamMateArea = BotPointAreaNum(ps.origin);
		if (teamMateArea <= 0 || !trap_AAS_AreaReachability(teamMateArea)) continue;

		travelTime = trap_AAS_AreaTravelTimeToGoalArea(teamMateArea, ps.origin, leaderArea, TFL_DEFAULT);
		if (travelTime <= 0 || travelTime >= botLeaderTravelTime) continue;

		numTeamMatesNearToLeader++;

		travelTime = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, teamMateArea, bs->tfl);
		if (travelTime <= 0 || travelTime >= bestTravelTime) continue;

		bestTeamMate = teamMates[i];
		bestTravelTime = travelTime;
	}

	if (botLeaderTravelTime > 200 * (numTeamMatesNearToLeader+1)) return leader;
	return bestTeamMate;
}

/*
==================
JUHOX: BotUpdateRescueSchedule
==================
*/
typedef struct {
	float nextUpdate;
	int team;
	int numAssignments;
	struct {
		int guard;
		int victim;
	} assignments[MAX_CLIENTS];
} rescueSchedule_t;
static rescueSchedule_t rescueSchedule_red;
static rescueSchedule_t rescueSchedule_blue;
typedef struct {
	int usecnt;
	int clientnum;
	int danger;
	vec3_t origin;
	int areanum;
	int maxGuards;	// only valid for victims
} rescuePlayerInfo_t;
rescueSchedule_t* BotUpdateRescueSchedule(bot_state_t* bs) {
	rescueSchedule_t* rs;
	playerState_t ps;
	int teammate;
	int numVictims;
	int numGuards;
	int numTeammates;
	int numActiveVictims;
	int numActiveGuards;
	rescuePlayerInfo_t victims[MAX_CLIENTS];
	rescuePlayerInfo_t guards[MAX_CLIENTS];

	if (g_gametype.integer < GT_TEAM) return NULL;
#if BOTS_USE_TSS
	if (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_isValid)) return NULL;
#endif

	switch (bs->cur_ps.persistant[PERS_TEAM]) {
	case TEAM_RED:
		rs = &rescueSchedule_red;
		rs->team = TEAM_RED;
		break;
	case TEAM_BLUE:
		rs = &rescueSchedule_blue;
		rs->team = TEAM_BLUE;
		break;
	default:
		return NULL;
	}

	if (rs->nextUpdate > FloatTime()) return rs;
	rs->nextUpdate = FloatTime() + 1 + random();

	numVictims = numGuards = 0;
	numTeammates = BotNumTeamMates(bs);
	memset(victims, -1, sizeof(victims));
	memset(guards, -1, sizeof(guards));
	for (teammate = -1; (teammate = BotGetNextPlayer(NULL, teammate, &ps)) >= 0;) {
		int danger;
		rescuePlayerInfo_t* rpi;
		int areanum;

		if (ps.stats[STAT_HEALTH] <= 0) continue;
		if (rs->team != ps.persistant[PERS_TEAM]) continue;
#if BOTS_USE_TSS
		if (BG_TSS_GetPlayerInfo(&ps, TSSPI_isValid)) continue;	// TSS manages rescue in this case
#endif
		areanum = BotPointAreaNum(ps.origin);
		if (areanum <= 0) continue;
		if (!trap_AAS_AreaReachability(areanum)) continue;

		danger = BotPlayerDanger(&ps);
		if (danger >= 15 || ps.powerups[PW_REDFLAG] || ps.powerups[PW_BLUEFLAG]) {
			rpi = &victims[numVictims++];
			if (gametype < GT_CTF) {
				if (danger < 25) {
					rpi->maxGuards = 0;
				}
				else if (danger < 37) {
					rpi->maxGuards = 1;
				}
				else if (danger < 50) {
					rpi->maxGuards = 2;
				}
				else {
					rpi->maxGuards = 3;
				}
			}
			else {
				if (
					(
						ps.powerups[PW_REDFLAG] || ps.powerups[PW_BLUEFLAG]
					) &&
					(
						BotOwnFlagStatus(bs) == FLAG_ATBASE ||
						!NearHomeBase(rs->team, ps.origin, 1)
					)
				) {
					rpi->maxGuards = 1000;
				}
				else if (ps.powerups[PW_REDFLAG] || ps.powerups[PW_BLUEFLAG]) {
					rpi->maxGuards = numTeammates - 2;
					if (rpi->maxGuards > 2) {
						rpi->maxGuards = 2;
					}
				}
				else if (danger >= 50 && BotEnemyFlagStatus(bs) == FLAG_TAKEN) {
					rpi->maxGuards = 1;
				}
				else {
					rpi->maxGuards = 0;
				}
			}
		} else {
			rpi = &guards[numGuards++];
		}

		rpi->usecnt = 0;
		rpi->clientnum = teammate;
		rpi->danger = danger;
		VectorCopy(ps.origin, rpi->origin);
		rpi->areanum = areanum;
	}

	rs->numAssignments = 0;
	numActiveVictims = numVictims;
	numActiveGuards = numGuards;

	while (numActiveGuards > 0 && numActiveVictims > 0) {
		int minusecnt;
		int maxDanger;
		rescuePlayerInfo_t* rpi;
		int victim;
		int guard, assignedGuard, leaderGuard;
		int bestTravelTime;

		minusecnt = 1000000;
		maxDanger = -1000000;
		rpi = NULL;
		for (victim = 0; victim < numVictims; victim++) {
			if (victims[victim].usecnt < 0) continue;
			if (victims[victim].usecnt > minusecnt) continue;
			if (victims[victim].usecnt >= victims[victim].maxGuards) {
				victims[victim].usecnt = -1;
				numActiveVictims--;
				continue;
			}
			if (victims[victim].usecnt >= minusecnt && victims[victim].danger <= maxDanger) continue;

			minusecnt = victims[victim].usecnt;
			maxDanger = victims[victim].danger;
			rpi = &victims[victim];
		}
		if (!rpi) return rs;

		bestTravelTime = 100000000;
		assignedGuard = -1;
		leaderGuard = -1;
		for (guard = 0; guard < numGuards; guard++) {
			int travelTime;

			if (guards[guard].usecnt != 0) continue;

			travelTime = trap_AAS_AreaTravelTimeToGoalArea(guards[guard].areanum, guards[guard].origin, rpi->areanum, TFL_DEFAULT);
			if (travelTime <= 0) continue;
			if (g_entities[guards[guard].clientnum].client->sess.teamLeader) {
				leaderGuard = guard;
				continue;
			}
			if (travelTime >= bestTravelTime) continue;

			bestTravelTime = travelTime;
			assignedGuard = guard;
		}

		if (assignedGuard < 0) {
			assignedGuard = leaderGuard;
		}
		if (assignedGuard < 0) {
			rpi->usecnt = -1;
			numActiveVictims--;
			continue;
		}

		rs->assignments[rs->numAssignments].guard = guards[assignedGuard].clientnum;
		rs->assignments[rs->numAssignments].victim = rpi->clientnum;
		rs->numAssignments++;

		rpi->usecnt++;

		guards[assignedGuard].usecnt++;
		numActiveGuards--;
	}

	return rs;
}

/*
==================
JUHOX: BotRescueTeamMate
==================
*/
int BotRescueTeamMate(bot_state_t* bs, int* helpers, int maxHelpers, int* numHelpers) {
	rescueSchedule_t* rs;
	int assignment;
	int victim;
	int guard;

	if (bs->cur_ps.stats[STAT_HEALTH] <= 0) return -1;

	rs = BotUpdateRescueSchedule(bs);
	if (!rs) return -1;

	for (assignment = 0; assignment < rs->numAssignments; assignment++) {
		if (rs->assignments[assignment].guard != bs->client) continue;

		victim = rs->assignments[assignment].victim;
		*numHelpers = 0;
		for (assignment = 0; assignment < rs->numAssignments; assignment++) {
			guard = rs->assignments[assignment].guard;
			if (guard == bs->client) continue;
			if (rs->assignments[assignment].victim != victim) continue;
			if (*numHelpers >= maxHelpers) continue;
			helpers[(*numHelpers)++] = guard;
		}
		return victim;
	}

	return -1;
}

/*
==================
JUHOX: BotClientIsGuard
==================
*/
qboolean BotClientIsGuard(bot_state_t* bs, int client) {
	rescueSchedule_t* rs;
	int assignment;

	rs = BotUpdateRescueSchedule(bs);
	if (!rs) return qfalse;
	for (assignment = 0; assignment < rs->numAssignments; assignment++) {
		if (rs->assignments[assignment].guard == client) return qtrue;
	}
	return qfalse;
}

/*
==================
JUHOX: BotActivateHumanHelpers
==================
*/
void BotActivateHumanHelpers(bot_state_t* bs) {
	rescueSchedule_t* rs;
	int assignment;
	int helper;
	char buf[64];

	if (gametype < GT_TEAM) return;
#if BOTS_USE_TSS
	if (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_isValid)) return;	// TSS manages helper activation
#endif

	rs = BotUpdateRescueSchedule(bs);
	if (!rs) return;

	if (BotPlayerDanger(&bs->cur_ps) >= 25) {
		for (assignment = 0; assignment < rs->numAssignments; assignment++) {
			if (rs->assignments[assignment].victim == bs->client) {
				int unusedSlot;
				int guard;
				playerState_t ps;

				guard = rs->assignments[assignment].guard;
				if (BotAI_IsBot(guard)) continue;

				if (!BotAI_GetClientState(guard, &ps)) continue;
				if (ps.stats[STAT_HEALTH] <= 0 || BotPlayerDanger(&ps) >= 25) continue;

				unusedSlot = -1;
				for (helper = 0; helper < MAX_SUBTEAM_SIZE; helper++) {
					if (bs->humanHelpers[helper] < 0) {
						unusedSlot = helper;
						continue;
					}
					if (bs->humanHelpers[helper] == guard) {
						bs->humanHelpersTime[helper] = FloatTime();
						goto NextAssignment;
					}
				}

				if (unusedSlot >= 0) {
					G_Say(
						&g_entities[bs->entitynum], &g_entities[guard], SAY_TELL,
						va("Please help me, %s\n", EasyClientName(guard, buf, sizeof(buf)))
					);
					bs->humanHelpers[unusedSlot] = guard;
					bs->humanHelpersTime[unusedSlot] = FloatTime();
				}
			}
			NextAssignment:;
		}
	}

	for (helper = 0; helper < MAX_SUBTEAM_SIZE; helper++) {
		playerState_t ps;
		int clientNum;

		clientNum = bs->humanHelpers[helper];
		if (clientNum < 0) continue;

		if (!BotAI_GetClientState(clientNum, &ps)) continue;
		if (ps.stats[STAT_HEALTH] <= 0 || BotPlayerDanger(&ps) >= 25) {
			bs->humanHelpers[helper] = -1;
			continue;
		}

		if (bs->humanHelpersTime[helper] > FloatTime() - 10) continue;

		bs->humanHelpers[helper] = -1;

		if (BotClientIsGuard(bs, clientNum)) continue;

		G_Say(
			&g_entities[bs->entitynum], &g_entities[clientNum], SAY_TELL,
			va("Thanks, %s, I no longer need your help.\n", EasyClientName(clientNum, buf, sizeof(buf)))
		);
	}
}

/*
==================
JUHOX: BotTeamMateToFollow
==================
*/
int BotTeamMateToFollow(bot_state_t* bs) {
	int leader;
	int helpers[MAX_SUBTEAM_SIZE];
	int numHelpers;
	playerState_t ps;
	int teamMate;

	if (FloatTime() < bs->teamgoal_checktime || bs->areanum <= 0) {
		if (bs->ltgtype != LTG_TEAMHELP) return -1;
		return bs->teammate;
	}
	bs->teamgoal_checktime = FloatTime() + 1 + random();

	BotActivateHumanHelpers(bs);

#if BOTS_USE_TSS
	if (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_isValid)) {
		tss_missionTask_t task;
		int taskGoal;

		if (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_groupMemberStatus) == TSSGMS_retreating) return -1;
		task = BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_task);
		taskGoal = BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_taskGoal);
		switch (task) {
		case TSSMT_followGroupLeader:
		case TSSMT_stickToGroupLeader:
		case TSSMT_helpTeamMate:
		case TSSMT_guardFlagCarrier:
		case TSSMT_seekGroupMember:
		case TSSMT_seekEnemyNearTeamMate:
			leader = taskGoal;
			if (leader == bs->client || leader < 0 || leader >= MAX_CLIENTS) return -1;
			switch (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_groupMemberStatus)) {
			case TSSGMS_designatedLeader:
			case TSSGMS_temporaryLeader:
				// NOTE: we do not consider helpers because they may change with the group leader
				// travelling around
				return leader;
			}
			numHelpers = 0;
			for (teamMate = -1; (teamMate = BotGetNextTeamMate(bs, teamMate, &ps)) >= 0;) {
				if (teamMate == leader) continue;
				if (ps.stats[STAT_HEALTH] <= 0) continue;
				if (!BG_TSS_GetPlayerInfo(&ps, TSSPI_isValid)) continue;
				// NOTE: we do not ignore players of other groups!
				task = BG_TSS_GetPlayerInfo(&ps, TSSPI_task);
				if (task == TSSMT_retreat) continue;
				if (task == TSSMT_rushToBase) continue;
				if (task == TSSMT_fulfilMission) continue;
				if (task == TSSMT_prepareForMission) continue;
				taskGoal = BG_TSS_GetPlayerInfo(&ps, TSSPI_taskGoal);
				if (taskGoal != leader) continue;

				helpers[numHelpers++] = teamMate;
				if (numHelpers >= MAX_SUBTEAM_SIZE) break;
			}
			break;
		case TSSMT_retreat:
		case TSSMT_rushToBase:
		case TSSMT_fulfilMission:
		case TSSMT_prepareForMission:
			return -1;
		default:
			leader = -1;
			break;
		}
	}
	else
#endif

	if (g_gametype.integer >= GT_STU) {
		leader = -1;
	}
	else

	{
		if (BotPlayerDanger(&bs->cur_ps) >= 25) return -1;
		leader = BotRescueTeamMate(bs, helpers, MAX_SUBTEAM_SIZE, &numHelpers);
	}

	if (leader < 0) {
		leader = bs->leader;
		if (leader == bs->client) {
			BotTeamleaderReachable(bs);
			return -1;
		}
		if (!BotAI_GetClientState(leader, &ps)) {
			leader = -1;
		}
		else if (ps.stats[STAT_HEALTH] <= 0) {
			leader = -1;
		}
		if (leader < 0) {
			int numTeamMates;

			numTeamMates = 0;
			for (teamMate = -1; (teamMate = BotGetNextTeamMate(bs, teamMate, &ps)) >= 0;) {
				if (ps.stats[STAT_HEALTH] <= 0) continue;
				if (bs->ltgtype == LTG_TEAMHELP && teamMate == bs->teammate) {
					leader = teamMate;
					break;
				}
				if (ps.powerups[PW_REDFLAG] || ps.powerups[PW_BLUEFLAG]) {
					if (!NearHomeBase(ps.persistant[PERS_TEAM], ps.origin, 9)) {
						leader = teamMate;
						break;
					}
				}
				numTeamMates++;
				if (rand() % numTeamMates == 0) {
					leader = teamMate;
				}
			}
			if (leader < 0) {
				BotTeamleaderReachable(bs);
				return -1;
			}
		}

		numHelpers = 0;
		for (teamMate = -1; (teamMate = BotGetNextTeamMate(bs, teamMate, &ps)) >= 0;) {
			if (teamMate == leader) continue;
			if (ps.stats[STAT_HEALTH] <= 0) continue;
			if ( BotPlayerDanger(&ps) >= 25 	&& g_gametype.integer < GT_STU ) continue;

			helpers[numHelpers++] = teamMate;
			if (numHelpers >= MAX_SUBTEAM_SIZE) break;
		}
	}

	return BotFindTeamMateInFront(bs, leader, helpers, numHelpers);
}

/*
==================
JUHOX: BotDetermineLeader
==================
*/
void BotDetermineLeader(bot_state_t* bs) {
	int i;
	int group;
	int bestLeader;
	int lowestDanger;
	int highestScore;

	if (gametype < GT_TEAM) {
		bs->leader = bs->client;
		return;
	}

	group = -1;
#if BOTS_USE_TSS
	if (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_isValid)) {
		group = BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_group);
		if (group >= MAX_GROUPS) group = -1;
	}
#endif

	if (bs->leader >= 0) {
		playerState_t ps;

		if (!BotAI_GetClientState(bs->leader, &ps)) goto DetermineNewLeader;
		if (ps.stats[STAT_HEALTH] <= 0) goto DetermineNewLeader;
		if (group >= 0) {
#if BOTS_USE_TSS
			if (!BG_TSS_GetPlayerInfo(&ps, TSSPI_isValid)) goto DetermineNewLeader;
			if (BG_TSS_GetPlayerInfo(&ps, TSSPI_group) != group) goto DetermineNewLeader;
			switch (BG_TSS_GetPlayerInfo(&ps, TSSPI_groupMemberStatus)) {
			case TSSGMS_designatedLeader:
			case TSSGMS_temporaryLeader:
				break;
			default:
				goto DetermineNewLeader;
			}
#endif
		}
		else {
			if (ps.powerups[PW_REDFLAG] || ps.powerups[PW_BLUEFLAG]) goto DetermineNewLeader;
		}
	}
	else {
		goto DetermineNewLeader;
	}

	if (bs->leaderCheckTime > FloatTime()) return;
	DetermineNewLeader:
	bs->leaderCheckTime = FloatTime() + 2 + 1*random();

#if BOTS_USE_TSS
	if (group >= 0) {
		for (i = 0; i < level.maxclients; i++) {
			gclient_t* cl;

			if (!g_entities[i].inuse) continue;
			cl = g_entities[i].client;
			if (!cl) continue;
			if (cl->pers.connected != CON_CONNECTED) continue;
			if (cl->sess.sessionTeam != bs->cur_ps.persistant[PERS_TEAM]) continue;
			if (cl->tssSafetyMode) continue;
			if (cl->ps.stats[STAT_HEALTH] <= 0) continue;
			if (!BG_TSS_GetPlayerInfo(&cl->ps, TSSPI_isValid)) continue;
			if (BG_TSS_GetPlayerInfo(&cl->ps, TSSPI_group) != group) continue;
			switch (BG_TSS_GetPlayerInfo(&cl->ps, TSSPI_groupMemberStatus)) {
			case TSSGMS_designatedLeader:
			case TSSGMS_temporaryLeader:
				if (bs->client != i) {
					int areanum;

					areanum = BotPointAreaNum(cl->ps.origin);
					if (areanum <= 0) break;
					if (!trap_AAS_AreaReachability(areanum)) break;
					if (
						trap_AAS_AreaTravelTimeToGoalArea(
							bs->areanum, bs->origin, areanum, bs->tfl
						) <= 0
					) {
						break;
					}
				}
				bs->leader = i;
				return;
			}
		}
		bs->leader = -1;
		return;
	}
#endif

	bestLeader = -1;
	lowestDanger = 1000000;
	highestScore = -1000000;
	for (i = 0; i < level.maxclients; i++) {
		const gclient_t* cl;
		int danger;
		int score;

		if (!g_entities[i].inuse) continue;
		cl = g_entities[i].client;
		if (!cl) continue;
		if (cl->pers.connected != CON_CONNECTED) continue;
		if (cl->sess.sessionTeam != bs->cur_ps.persistant[PERS_TEAM]) continue;
		if (cl->ps.stats[STAT_HEALTH] <= 0) continue;
		if (cl->tssSafetyMode) continue;
		if (cl->ps.powerups[PW_REDFLAG] || cl->ps.powerups[PW_BLUEFLAG]) continue;
		danger = BotPlayerDanger(&cl->ps);
#if BOTS_USE_TSS
		if (group >= 0) {
			qboolean sameGroup;

			sameGroup = qfalse;
			if (BG_TSS_GetPlayerInfo(&cl->ps, TSSPI_isValid)) {
				if (BG_TSS_GetPlayerInfo(&cl->ps, TSSPI_group) == group) {
					sameGroup = qtrue;
				}
			}
			if (!sameGroup) continue;
		}
		else
#endif
		if (cl->sess.teamLeader) {
			if ( danger < 50 || g_gametype.integer == GT_STU ) {
				danger = -1000000;
			}
		}
		if (danger > lowestDanger) continue;
		score = cl->ps.persistant[PERS_SCORE] - cl->ps.persistant[PERS_KILLED];
		if (danger == lowestDanger && score <= highestScore) continue;
		if (
			BotClientIsGuard(bs, i)

			&& g_gametype.integer != GT_STU

		) continue;

		bestLeader = i;
		lowestDanger = danger;
		highestScore = score;
	}
	bs->leader = bestLeader;
}

#if 0	// JUHOX: BotCTFOrders_BothFlagsNotAtBase() not needed
/*
==================
BotCTFOrders
==================
*/
void BotCTFOrders_BothFlagsNotAtBase(bot_state_t *bs) {
	int numteammates, defenders, attackers, i, other;
	int teammates[MAX_CLIENTS];
	char name[MAX_NETNAME], carriername[MAX_NETNAME];

	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
	//different orders based on the number of team mates
	switch(bs->numteammates) {
		case 1: break;
		case 2:
		{
			//tell the one not carrying the flag to attack the enemy base
			if (teammates[0] != bs->flagcarrier) other = teammates[0];
			else other = teammates[1];
			ClientName(other, name, sizeof(name));
			BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
			BotSayTeamOrder(bs, other);
			BotSayVoiceTeamOrder(bs, other, VOICECHAT_GETFLAG);
			break;
		}
		case 3:
		{
			//tell the one closest to the base not carrying the flag to accompany the flag carrier
			if (teammates[0] != bs->flagcarrier) other = teammates[0];
			else other = teammates[1];
			ClientName(other, name, sizeof(name));
			if ( bs->flagcarrier != -1 ) {
				ClientName(bs->flagcarrier, carriername, sizeof(carriername));
				if (bs->flagcarrier == bs->client) {
					BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
					BotSayVoiceTeamOrder(bs, other, VOICECHAT_FOLLOWME);
				}
				else {
					BotAI_BotInitialChat(bs, "cmd_accompany", name, carriername, NULL);
					BotSayVoiceTeamOrder(bs, other, VOICECHAT_FOLLOWFLAGCARRIER);
				}
			}
			else {
				//
				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
				BotSayVoiceTeamOrder(bs, other, VOICECHAT_GETFLAG);
			}
			BotSayTeamOrder(bs, other);
			//tell the one furthest from the the base not carrying the flag to get the enemy flag
			if (teammates[2] != bs->flagcarrier) other = teammates[2];
			else other = teammates[1];
			ClientName(other, name, sizeof(name));
			BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
			BotSayTeamOrder(bs, other);
			BotSayVoiceTeamOrder(bs, other, VOICECHAT_RETURNFLAG);
			break;
		}
		default:
		{
			defenders = (int) (float) numteammates * 0.4 + 0.5;
			if (defenders > 4) defenders = 4;
			attackers = (int) (float) numteammates * 0.5 + 0.5;
			if (attackers > 5) attackers = 5;
			if (bs->flagcarrier != -1) {
				ClientName(bs->flagcarrier, carriername, sizeof(carriername));
				for (i = 0; i < defenders; i++) {
					//
					if (teammates[i] == bs->flagcarrier) {
						continue;
					}
					//
					ClientName(teammates[i], name, sizeof(name));
					if (bs->flagcarrier == bs->client) {
						BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
						BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_FOLLOWME);
					}
					else {
						BotAI_BotInitialChat(bs, "cmd_accompany", name, carriername, NULL);
						BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_FOLLOWFLAGCARRIER);
					}
					BotSayTeamOrder(bs, teammates[i]);
				}
			}
			else {
				for (i = 0; i < defenders; i++) {
					//
					if (teammates[i] == bs->flagcarrier) {
						continue;
					}
					//
					ClientName(teammates[i], name, sizeof(name));
					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_GETFLAG);
					BotSayTeamOrder(bs, teammates[i]);
				}
			}
			for (i = 0; i < attackers; i++) {
				//
				if (teammates[numteammates - i - 1] == bs->flagcarrier) {
					continue;
				}
				//
				ClientName(teammates[numteammates - i - 1], name, sizeof(name));
				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
				BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
				BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_RETURNFLAG);
			}
			//
			break;
		}
	}
}
#endif

#if 0	// JUHOX: BotCTFOrders_FlagNotAtBase() not needed
/*
==================
BotCTFOrders
==================
*/
void BotCTFOrders_FlagNotAtBase(bot_state_t *bs) {
	int numteammates, defenders, attackers, i;
	int teammates[MAX_CLIENTS];
	char name[MAX_NETNAME];

	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
	//passive strategy
	if (!(bs->ctfstrategy & CTFS_AGRESSIVE)) {
		//different orders based on the number of team mates
		switch(bs->numteammates) {
			case 1: break;
			case 2:
			{
				//both will go for the enemy flag
				ClientName(teammates[0], name, sizeof(name));
				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
				BotSayTeamOrder(bs, teammates[0]);
				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_GETFLAG);
				//
				ClientName(teammates[1], name, sizeof(name));
				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
				BotSayTeamOrder(bs, teammates[1]);
				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
				break;
			}
			case 3:
			{
				//keep one near the base for when the flag is returned
				ClientName(teammates[0], name, sizeof(name));
				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
				BotSayTeamOrder(bs, teammates[0]);
				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
				//the other two get the flag
				ClientName(teammates[1], name, sizeof(name));
				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
				BotSayTeamOrder(bs, teammates[1]);
				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
				//
				ClientName(teammates[2], name, sizeof(name));
				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
				BotSayTeamOrder(bs, teammates[2]);
				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
				break;
			}
			default:
			{
				//keep some people near the base for when the flag is returned
				defenders = (int) (float) numteammates * 0.3 + 0.5;
				if (defenders > 3) defenders = 3;
				attackers = (int) (float) numteammates * 0.7 + 0.5;
				if (attackers > 6) attackers = 6;
				for (i = 0; i < defenders; i++) {
					//
					ClientName(teammates[i], name, sizeof(name));
					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
					BotSayTeamOrder(bs, teammates[i]);
					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
				}
				for (i = 0; i < attackers; i++) {
					//
					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
					BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_GETFLAG);
				}
				//
				break;
			}
		}
	}
	else {
		//different orders based on the number of team mates
		switch(bs->numteammates) {
			case 1: break;
			case 2:
			{
				//both will go for the enemy flag
				ClientName(teammates[0], name, sizeof(name));
				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
				BotSayTeamOrder(bs, teammates[0]);
				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_GETFLAG);
				//
				ClientName(teammates[1], name, sizeof(name));
				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
				BotSayTeamOrder(bs, teammates[1]);
				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
				break;
			}
			case 3:
			{
				//everyone go for the flag
				ClientName(teammates[0], name, sizeof(name));
				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
				BotSayTeamOrder(bs, teammates[0]);
				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_GETFLAG);
				//
				ClientName(teammates[1], name, sizeof(name));
				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
				BotSayTeamOrder(bs, teammates[1]);
				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
				//
				ClientName(teammates[2], name, sizeof(name));
				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
				BotSayTeamOrder(bs, teammates[2]);
				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
				break;
			}
			default:
			{
				//keep some people near the base for when the flag is returned
				defenders = (int) (float) numteammates * 0.2 + 0.5;
				if (defenders > 2) defenders = 2;
				attackers = (int) (float) numteammates * 0.7 + 0.5;
				if (attackers > 7) attackers = 7;
				for (i = 0; i < defenders; i++) {
					//
					ClientName(teammates[i], name, sizeof(name));
					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
					BotSayTeamOrder(bs, teammates[i]);
					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
				}
				for (i = 0; i < attackers; i++) {
					//
					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
				}
				//
				break;
			}
		}
	}
}
#endif

// JUHOX: BotCTFOrders_EnemyFlagNotAtBase() not needed
#if 0
/*
==================
BotCTFOrders
==================
*/
void BotCTFOrders_EnemyFlagNotAtBase(bot_state_t *bs) {
	int numteammates, defenders, attackers, i, other;
	int teammates[MAX_CLIENTS];
	char name[MAX_NETNAME], carriername[MAX_NETNAME];

	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
	//different orders based on the number of team mates
	switch(numteammates) {
		case 1: break;
		case 2:
		{
			//tell the one not carrying the flag to defend the base
			if (teammates[0] == bs->flagcarrier) other = teammates[1];
			else other = teammates[0];
			ClientName(other, name, sizeof(name));
			BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
			BotSayTeamOrder(bs, other);
			BotSayVoiceTeamOrder(bs, other, VOICECHAT_DEFEND);
			break;
		}
		case 3:
		{
			//tell the one closest to the base not carrying the flag to defend the base
			if (teammates[0] != bs->flagcarrier) other = teammates[0];
			else other = teammates[1];
			ClientName(other, name, sizeof(name));
			BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
			BotSayTeamOrder(bs, other);
			BotSayVoiceTeamOrder(bs, other, VOICECHAT_DEFEND);
			//tell the other also to defend the base
			if (teammates[2] != bs->flagcarrier) other = teammates[2];
			else other = teammates[1];
			ClientName(other, name, sizeof(name));
			BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
			BotSayTeamOrder(bs, other);
			BotSayVoiceTeamOrder(bs, other, VOICECHAT_DEFEND);
			break;
		}
		default:
		{
			//60% will defend the base
			defenders = (int) (float) numteammates * 0.6 + 0.5;
			if (defenders > 6) defenders = 6;
			//30% accompanies the flag carrier
			attackers = (int) (float) numteammates * 0.3 + 0.5;
			if (attackers > 3) attackers = 3;
			for (i = 0; i < defenders; i++) {
				//
				if (teammates[i] == bs->flagcarrier) {
					continue;
				}
				ClientName(teammates[i], name, sizeof(name));
				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
				BotSayTeamOrder(bs, teammates[i]);
				BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
			}
			// if we have a flag carrier
			if ( bs->flagcarrier != -1 ) {
				ClientName(bs->flagcarrier, carriername, sizeof(carriername));
				for (i = 0; i < attackers; i++) {
					//
					if (teammates[numteammates - i - 1] == bs->flagcarrier) {
						continue;
					}
					//
					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
					if (bs->flagcarrier == bs->client) {
						BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
						BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_FOLLOWME);
					}
					else {
						BotAI_BotInitialChat(bs, "cmd_accompany", name, carriername, NULL);
						BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_FOLLOWFLAGCARRIER);
					}
					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
				}
			}
			else {
				for (i = 0; i < attackers; i++) {
					//
					if (teammates[numteammates - i - 1] == bs->flagcarrier) {
						continue;
					}
					//
					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
				}
			}
			//
			break;
		}
	}
}
#endif


// JUHOX: BotCTFOrders_BothFlagsAtBase() not needed
#if 0
/*
==================
BotCTFOrders
==================
*/
void BotCTFOrders_BothFlagsAtBase(bot_state_t *bs) {
	int numteammates, defenders, attackers, i;
	int teammates[MAX_CLIENTS];
	char name[MAX_NETNAME];

	//sort team mates by travel time to base
	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
	//sort team mates by CTF preference
	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
	//passive strategy
	if (!(bs->ctfstrategy & CTFS_AGRESSIVE)) {
		//different orders based on the number of team mates
		switch(numteammates) {
			case 1: break;
			case 2:
			{
				//the one closest to the base will defend the base
				ClientName(teammates[0], name, sizeof(name));
				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
				BotSayTeamOrder(bs, teammates[0]);
				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
				//the other will get the flag
				ClientName(teammates[1], name, sizeof(name));
				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
				BotSayTeamOrder(bs, teammates[1]);
				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
				break;
			}
			case 3:
			{
				//the one closest to the base will defend the base
				ClientName(teammates[0], name, sizeof(name));
				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
				BotSayTeamOrder(bs, teammates[0]);
				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
				//the second one closest to the base will defend the base
				ClientName(teammates[1], name, sizeof(name));
				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
				BotSayTeamOrder(bs, teammates[1]);
				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_DEFEND);
				//the other will get the flag
				ClientName(teammates[2], name, sizeof(name));
				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
				BotSayTeamOrder(bs, teammates[2]);
				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
				break;
			}
			default:
			{
				defenders = (int) (float) numteammates * 0.5 + 0.5;
				if (defenders > 5) defenders = 5;
				attackers = (int) (float) numteammates * 0.4 + 0.5;
				if (attackers > 4) attackers = 4;
				for (i = 0; i < defenders; i++) {
					//
					ClientName(teammates[i], name, sizeof(name));
					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
					BotSayTeamOrder(bs, teammates[i]);
					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
				}
				for (i = 0; i < attackers; i++) {
					//
					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
				}
				//
				break;
			}
		}
	}
	else {
		//different orders based on the number of team mates
		switch(numteammates) {
			case 1: break;
			case 2:
			{
				//the one closest to the base will defend the base
				ClientName(teammates[0], name, sizeof(name));
				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
				BotSayTeamOrder(bs, teammates[0]);
				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
				//the other will get the flag
				ClientName(teammates[1], name, sizeof(name));
				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
				BotSayTeamOrder(bs, teammates[1]);
				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
				break;
			}
			case 3:
			{
				//the one closest to the base will defend the base
				ClientName(teammates[0], name, sizeof(name));
				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
				BotSayTeamOrder(bs, teammates[0]);
				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
				//the others should go for the enemy flag
				ClientName(teammates[1], name, sizeof(name));
				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
				BotSayTeamOrder(bs, teammates[1]);
				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
				//
				ClientName(teammates[2], name, sizeof(name));
				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
				BotSayTeamOrder(bs, teammates[2]);
				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
				break;
			}
			default:
			{
				defenders = (int) (float) numteammates * 0.4 + 0.5;
				if (defenders > 4) defenders = 4;
				attackers = (int) (float) numteammates * 0.5 + 0.5;
				if (attackers > 5) attackers = 5;
				for (i = 0; i < defenders; i++) {
					//
					ClientName(teammates[i], name, sizeof(name));
					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
					BotSayTeamOrder(bs, teammates[i]);
					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
				}
				for (i = 0; i < attackers; i++) {
					//
					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
				}
				//
				break;
			}
		}
	}
}
#endif

// JUHOX: BotCTFOrders() not needed
#if 0
/*
==================
BotCTFOrders
==================
*/
void BotCTFOrders(bot_state_t *bs) {
	int flagstatus;

	//
	if (BotTeam(bs) == TEAM_RED) flagstatus = bs->redflagstatus * 2 + bs->blueflagstatus;
	else flagstatus = bs->blueflagstatus * 2 + bs->redflagstatus;
	//
	switch(flagstatus) {
		case 0: BotCTFOrders_BothFlagsAtBase(bs); break;
		case 1: BotCTFOrders_EnemyFlagNotAtBase(bs); break;
		case 2: BotCTFOrders_FlagNotAtBase(bs); break;
		case 3: BotCTFOrders_BothFlagsNotAtBase(bs); break;
	}
}
#endif


// JUHOX: BotCreateGroup() not needed
#if 0
/*
==================
BotCreateGroup
==================
*/
void BotCreateGroup(bot_state_t *bs, int *teammates, int groupsize) {
	char name[MAX_NETNAME], leadername[MAX_NETNAME];
	int i;

	// the others in the group will follow the teammates[0]
	ClientName(teammates[0], leadername, sizeof(leadername));
	for (i = 1; i < groupsize; i++)
	{
		ClientName(teammates[i], name, sizeof(name));
		if (teammates[0] == bs->client) {
			BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
		}
		else {
			BotAI_BotInitialChat(bs, "cmd_accompany", name, leadername, NULL);
		}
		BotSayTeamOrderAlways(bs, teammates[i]);
	}
}
#endif

// JUHOX: (original) BotTeamOrders() not needed
#if 0
/*
==================
BotTeamOrders

  FIXME: defend key areas?
==================
*/
void BotTeamOrders(bot_state_t *bs) {
	int teammates[MAX_CLIENTS];
	int numteammates, i;
	char buf[MAX_INFO_STRING];
	static int maxclients;

	if (!maxclients)
		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");

	numteammates = 0;
	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
		//if no config string or no name
		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n"))) continue;
		//skip spectators
		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) continue;
		//
		if (BotSameTeam(bs, i)) {
			teammates[numteammates] = i;
			numteammates++;
		}
	}
	//
	switch(numteammates) {
		case 1: break;
		case 2:
		{
			//nothing special
			break;
		}
		case 3:
		{
			//have one follow another and one free roaming
			BotCreateGroup(bs, teammates, 2);
			break;
		}
		case 4:
		{
			BotCreateGroup(bs, teammates, 2);		//a group of 2
			BotCreateGroup(bs, &teammates[2], 2);	//a group of 2
			break;
		}
		case 5:
		{
			BotCreateGroup(bs, teammates, 2);		//a group of 2
			BotCreateGroup(bs, &teammates[2], 3);	//a group of 3
			break;
		}
		default:
		{
			if (numteammates <= 10) {
				for (i = 0; i < numteammates / 2; i++) {
					BotCreateGroup(bs, &teammates[i*2], 2);	//groups of 2
				}
			}
			break;
		}
	}
}
#endif

/*
==================
FindHumanTeamLeader
==================
*/
int FindHumanTeamLeader(bot_state_t *bs) {
	// JUHOX: don't assume humans to be team leader
#if 0
	int i;

	for (i = 0; i < MAX_CLIENTS; i++) {
		if ( g_entities[i].inuse ) {
			// if this player is not a bot
			if ( !(g_entities[i].r.svFlags & SVF_BOT) ) {
				// if this player is ok with being the leader
				if (!notleader[i]) {
					// if this player is on the same team
					if ( BotSameTeam(bs, i) ) {
						ClientName(i, bs->teamleader, sizeof(bs->teamleader));
						// if not yet ordered to do anything
						if ( !BotSetLastOrderedTask(bs) ) {
							// go on defense by default
							BotVoiceChat_Defend(bs, i, SAY_TELL);
						}
						return qtrue;
					}
				}
			}
		}
	}
#endif
	return qfalse;
}

/*
==================
JUHOX: BotGoToGoal
==================
*/
void BotGoToGoal(bot_state_t* bs, const bot_goal_t* goal) {
	//set message time to zero so bot will NOT show any message
	bs->teammessage_time = 0;
	//we use the bots-decides-to-camp ltg to make the bot going to the location.
	bs->ltgtype = LTG_CAMPORDER;
	//set the team goal
	memcpy(&bs->teamgoal, goal, sizeof(bot_goal_t));
	//get the team goal time
	bs->teamgoal_time = FloatTime() + 30;
	//set the time the bot will stay at the location
	bs->camp_time = 3;	// note that camp_time formerly had another meaning
	//the teammate that requested the camping
	bs->teammate = 0;
	bs->arrive_time = 0;
}

/*
==================
JUHOX: BotGoNearGoal
==================
*/
void BotGoNearGoal(bot_state_t* bs, const bot_goal_t* goal) {
	BotGoToGoal(bs, goal);
	bs->ltgtype = LTG_CAMP;
	bs->camp_time = 6;
}

/*
==================
JUHOX: TravelConvinience
==================
*/
static int TravelConvinience(bot_state_t* leader, const bot_goal_t* goal) {
	int teammate;
	int leaderTraveltime;
	playerState_t ps;
	int totalTeammateTraveltime;
	int numTeammates;	// not counting the leader and team mates who can't reach the goal


	if (
		(goal->flags & GFL_ITEM) &&
		!BotMayLTGItemBeReachable(leader, goal->entitynum)
	) return -1000000000;

	leaderTraveltime = trap_AAS_AreaTravelTimeToGoalArea(leader->areanum, leader->origin, goal->areanum, TFL_DEFAULT);
	if (leaderTraveltime < 100) return -1000000000;

	if (gametype < GT_TEAM) return 100000;

	totalTeammateTraveltime = 0;
	numTeammates = 0;
	for (teammate = -1; (teammate = BotGetNextTeamMate(leader, teammate, &ps)) >= 0;) {
		int traveltime;
		int areanum;

		areanum = BotPointAreaNum(ps.origin);
		if (areanum <= 0) continue;
		if (!trap_AAS_AreaReachability(areanum)) continue;
		traveltime = trap_AAS_AreaTravelTimeToGoalArea(BotPointAreaNum(ps.origin), ps.origin, goal->areanum, TFL_DEFAULT);
		if (traveltime > 0) {
			totalTeammateTraveltime += traveltime;
			numTeammates++;
		}
	}

	if (numTeammates <= 0) return 100000;
	return totalTeammateTraveltime - numTeammates * leaderTraveltime;
}

/*
==================
JUHOX: GetItemGoal
==================
*/
int GetItemGoal(int entitynum, const char* name, bot_goal_t* goal) {
	if (Q_stricmp(name, "emergency") == 0) {
		for (entitynum++; entitynum < level.numEmergencySpawnPoints; entitynum++) {
			memset(goal, 0, sizeof(*goal));
			goal->entitynum = ENTITYNUM_WORLD;
			VectorSet(goal->mins, -8, -8, -8);
			VectorSet(goal->maxs, 8, 8, 8);
			VectorCopy(level.emergencySpawnPoints[entitynum], goal->origin);
			goal->areanum = BotPointAreaNum(goal->origin);
			return entitynum;
		}
		return -1;
	}

	if (entitynum < MAX_CLIENTS) entitynum = MAX_CLIENTS-1;

	for (entitynum++; entitynum < level.num_entities; entitynum++) {
		gentity_t* ent;

		ent = &g_entities[entitynum];
		if (!ent->inuse) continue;
		if (ent->s.eType != ET_ITEM) continue;
		if (!ent->item) continue;
		if (Q_stricmp(name, ent->item->pickup_name)) continue;

		BotCreateItemGoal(ent, goal);
		return entitynum;
	}

	return -1;
}

/*
==================
JUHOX: SearchItemGoal
==================
*/
static qboolean SearchItemGoal(bot_state_t* bs, char** itemList, bot_goal_t* goal) {
	int numFirstChoiceGoals;
	int numSecondChoiceGoals;
	int numThirdChoiceGoals;
	qboolean acceptNewSecondChoiceGoals;
	bot_goal_t firstChoiceGoal;
	bot_goal_t secondChoiceGoal;
	bot_goal_t thirdChoiceGoal;

	if (!itemList) return qfalse;

	numFirstChoiceGoals = 0;
	numSecondChoiceGoals = 0;
	numThirdChoiceGoals = 0;
	acceptNewSecondChoiceGoals = qtrue;
	while (*itemList) {
		int location;
		bot_goal_t potentialGoal;

		if ((*itemList)[0] == 0) {
			if (numFirstChoiceGoals > 0) {
				memcpy(goal, &firstChoiceGoal, sizeof(*goal));
				return qtrue;
			}
			if (numSecondChoiceGoals > 0) {
				acceptNewSecondChoiceGoals = qfalse;
			}
			goto NextItem;
		}

		for (location = -1; (location = GetItemGoal(location, *itemList, &potentialGoal)) >= 0; ) {
			trace_t trace;
			int travelConvinience;

			if (potentialGoal.flags & GFL_DROPPED) continue;
			if (potentialGoal.areanum <= 0) continue;

			if (
				(potentialGoal.flags & GFL_ITEM) &&
				!BotMayNBGBeAvailable(bs, potentialGoal.entitynum)
			) continue;

			travelConvinience = TravelConvinience(bs, &potentialGoal);
			if (travelConvinience <= -1000000) continue;

			numThirdChoiceGoals++;
			if (rand() % numThirdChoiceGoals == 0) {
				memcpy(&thirdChoiceGoal, &potentialGoal, sizeof(thirdChoiceGoal));
			}

			trap_Trace(&trace, bs->eye, NULL, NULL, potentialGoal.origin, bs->client, MASK_SHOT);
			if (trace.fraction >= 1) continue;

			if (travelConvinience >= 0) {
				numFirstChoiceGoals++;
				if (rand() % numFirstChoiceGoals == 0) {
					memcpy(&firstChoiceGoal, &potentialGoal, sizeof(firstChoiceGoal));
				}
			}
			else if (acceptNewSecondChoiceGoals) {
				numSecondChoiceGoals++;
				if (rand() % numSecondChoiceGoals == 0) {
					memcpy(&secondChoiceGoal, &potentialGoal, sizeof(secondChoiceGoal));
				}
			}
		}

		NextItem:
		itemList++;
	}

	if (numFirstChoiceGoals > 0) {
		memcpy(goal, &firstChoiceGoal, sizeof(*goal));
		return qtrue;
	}
	if (numSecondChoiceGoals > 0) {
		memcpy(goal, &secondChoiceGoal, sizeof(*goal));
		return qtrue;
	}
	if (numThirdChoiceGoals > 0) {
		memcpy(goal, &thirdChoiceGoal, sizeof(*goal));
		return qtrue;
	}
	return qfalse;
}

/*
==================
JUHOX: BotChooseTeamleaderGoal
==================
*/
int BotChooseTeamleaderGoal(bot_state_t* bs, bot_goal_t* goal) {
	static char* allItems[] = {
		"Armor Shard",
		"Armor",
		"Heavy Armor",
		"5 Health",
		"25 Health",
		"50 Health",
		"Mega Health",
		"Personal Teleporter",
		"Medkit",
		"Regeneration",
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
		"Red Flag",
		"Blue Flag",
		NULL
	};
	char** firstChoiceItems;
	char** secondChoiceItems;
	char** thirdChoiceItems;

	int teammate;
	playerState_t ps;
	qboolean healthUseful, armorUseful, holdableUseful;

	if (bs->areanum <= 0) return qfalse;

	if (g_noItems.integer) {
		static char* dummyList[] = {
			"emergency",
			NULL
		};

		return SearchItemGoal(bs, dummyList, goal);
	}

	healthUseful = (bs->cur_ps.stats[STAT_HEALTH] < bs->cur_ps.stats[STAT_MAX_HEALTH]);
	armorUseful = (bs->cur_ps.stats[STAT_ARMOR] < bs->cur_ps.stats[STAT_MAX_HEALTH]);
	holdableUseful = !bs->cur_ps.stats[STAT_HOLDABLE_ITEM];
	for (teammate = -1; (teammate = BotGetNextTeamMate(bs, teammate, &ps)) >= 0;) {
		if (ps.stats[STAT_HEALTH] <= 0) continue;
		if (ps.stats[STAT_HEALTH] < ps.stats[STAT_MAX_HEALTH]) healthUseful = qtrue;
		if (ps.stats[STAT_ARMOR] < ps.stats[STAT_MAX_HEALTH]) armorUseful = qtrue;
		if (!bs->cur_ps.stats[STAT_HOLDABLE_ITEM]) holdableUseful = qtrue;
	}

	if (healthUseful) {
		if (armorUseful) {
			if (holdableUseful) {
				// health useful, armor useful, holdable useful
				static char* items1[] = {
					"Mega Health",
					"Regeneration",
					"Medkit",
					"Heavy Armor",
					"",
					"50 Health",
					"25 Health",
					"Armor",
					"",
					"5 Health",
					"Armor Shard",
					"Personal Teleporter",
					NULL
				};

				firstChoiceItems = items1;
				secondChoiceItems = NULL;
				thirdChoiceItems = NULL;
			}
			else {
				// health useful, armor useful
				static char* items1[] = {
					"Mega Health",
					"Regeneration",
					"Heavy Armor",
					"",
					"50 Health",
					"25 Health",
					"Armor",
					"",
					"5 Health",
					"Armor Shard",
					NULL
				};
				static char* items2[] = {
					"Medkit",
					"Personal Teleporter",
					NULL
				};

				firstChoiceItems = items1;
				secondChoiceItems = items2;
				thirdChoiceItems = NULL;
			}
		}
		else {
			if (holdableUseful) {
				// health useful, holdable useful
				static char* items1[] = {
					"Mega Health",
					"Regeneration",
					"Medkit",
					"",
					"50 Health",
					"25 Health",
					"",
					"5 Health",
					"Personal Teleporter",
					NULL
				};
				static char* items2[] = {
					"Heavy Armor",
					"",
					"Armor",
					"",
					"Armor Shard",
					NULL
				};

				firstChoiceItems = items1;
				secondChoiceItems = items2;
				thirdChoiceItems = NULL;
			}
			else {
				// health useful
				static char* items1[] = {
					"Mega Health",
					"Regeneration",
					"",
					"50 Health",
					"25 Health",
					"",
					"5 Health",
					NULL
				};
				static char* items2[] = {
					"Heavy Armor",
					"",
					"Armor",
					"",
					"Armor Shard",
					NULL
				};
				static char* items3[] = {
					"Medkit",
					"Personal Teleporter",
					NULL
				};

				firstChoiceItems = items1;
				secondChoiceItems = items2;
				thirdChoiceItems = items3;
			}
		}
	}
	else if (armorUseful) {
		if (holdableUseful) {
			// armor useful, holdable useful
			static char* items1[] = {
				"Heavy Armor",
				"",
				"Armor",
				"",
				"Medkit",
				"Armor Shard",
				"Regeneration",
				"",
				"Personal Teleporter",
				NULL
			};
			static char* items2[] = {
				"Mega Health",
				"",
				"5 Health",
				NULL
			};
			static char* items3[] = {
				"25 Health",
				"50 Health",
				NULL
			};

			firstChoiceItems = items1;
			secondChoiceItems = items2;
			thirdChoiceItems = items3;
		}
		else {
			// armor useful
			static char* items1[] = {
				"Heavy Armor",
				"",
				"Armor",
				"",
				"Armor Shard",
				"Regeneration",
				NULL
			};
			static char* items2[] = {
				"Mega Health",
				"",
				"5 Health",
				NULL
			};
			static char* items3[] = {
				"25 Health",
				"50 Health",
				"Medkit",
				"Personal Teleporter",
				NULL
			};

			firstChoiceItems = items1;
			secondChoiceItems = items2;
			thirdChoiceItems = items3;
		}
	}
	else if (holdableUseful) {
		// holdable useful
		static char* items1[] = {
			"Medkit",
			"",
			"Personal Teleporter",
			NULL
		};
		static char* items2[] = {
			"Mega Health",
			"Regeneration",
			"Heavy Armor",
			"Armor",
			"",
			"Armor Shard",
			"5 Health",
			NULL
		};
		static char* items3[] = {
			"25 Health",
			"50 Health",
			NULL
		};

		firstChoiceItems = items1;
		secondChoiceItems = items2;
		thirdChoiceItems = items3;
	}
	else {
		// nothing useful
		static char* items1[] = {
			"Mega Health",
			"Regeneration",
			"Heavy Armor",
			"Armor",
			"",
			"Armor Shard",
			"5 Health",
			NULL
		};
		static char* items2[] = {
			"25 Health",
			"50 Health",
			"Medkit",
			"Personal Teleporter",
			NULL
		};

		firstChoiceItems = items1;
		secondChoiceItems = items2;
		thirdChoiceItems = NULL;
	}

	if (SearchItemGoal(bs, firstChoiceItems, goal)) return qtrue;
	if (SearchItemGoal(bs, secondChoiceItems, goal)) return qtrue;
	if (SearchItemGoal(bs, thirdChoiceItems, goal)) return qtrue;
	if (SearchItemGoal(bs, allItems, goal)) return qtrue;

	return qfalse;
}

/*
==================
JUHOX: BotSearchTeammate
==================
*/
qboolean BotSearchTeammate(bot_state_t* bs, int teammate) {
	playerState_t ps;
	int areanum;

	if (bs->client == teammate) return qfalse;
	if (bs->ltgtype == LTG_TEAMHELP && bs->teammate == teammate) return qfalse;
	if (!BotAI_GetClientState(teammate, &ps)) return qfalse;
	if (ps.persistant[PERS_TEAM] != bs->cur_ps.persistant[PERS_TEAM]) return qfalse;
	areanum = BotPointAreaNum(ps.origin);
	if (areanum <= 0 || !trap_AAS_AreaReachability(areanum)) return qfalse;
	bs->teamgoal.entitynum = teammate;
	bs->teamgoal.areanum = areanum;
	VectorCopy(ps.origin, bs->teamgoal.origin);
	VectorSet(bs->teamgoal.mins, -8, -8, -8);
	VectorSet(bs->teamgoal.maxs, 8, 8, 8);
	bs->ltgtype = LTG_TEAMHELP;
	bs->teammate = teammate;
	bs->teamgoal_time = FloatTime() + TEAM_HELP_TIME;
	bs->teammessage_time = 0;	// no message
	return qtrue;
}

/*
==================
JUHOX: BotDecidesToHelp
==================
*/
qboolean BotDecidesToHelp(bot_state_t* bs, int clientThatNeedsHelp) {
	if (!BotSearchTeammate(bs, clientThatNeedsHelp)) return qfalse;
	if (!BotEntityVisible(&bs->cur_ps, 360, clientThatNeedsHelp)) {
		//set the time to send a message to the team mates
		bs->teammessage_time = FloatTime() + 1 + random();
	}
	return qtrue;
}

/*
==================
JUHOX: BotRushToBase
==================
*/
void BotRushToBase(bot_state_t* bs) {
	if (g_gametype.integer != GT_CTF) return;

	if (bs->ltgtype != LTG_RUSHBASE) {
		bs->ltgtype = LTG_RUSHBASE;
		bs->teammessage_time = 0;
		bs->rushbaseaway_time = 0;

		switch (bs->cur_ps.persistant[PERS_TEAM]) {
		case TEAM_RED:
			memcpy(&bs->teamgoal, &ctf_redflag, sizeof(bot_goal_t));
			break;
		case TEAM_BLUE:
			memcpy(&bs->teamgoal, &ctf_blueflag, sizeof(bot_goal_t));
			break;
		}
	}
	bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;

	if (BotOwnFlagStatus(bs) == FLAG_ATBASE) {
		bs->rushbaseaway_time = 0;
		bs->ltg_time = 0;
		bs->nbg_time = 0;
	}
}


/*
==================
JUHOX: GetPointAreaNum
==================
*/
static int GetPointAreaNum(vec3_t point) {
	int areanum;

	areanum = BotPointAreaNum(point);
	if (areanum <= 0) return 0;
	if (!trap_AAS_AreaReachability(areanum)) return 0;
	return areanum;
}

/*
==================
JUHOX: FindPointAreaNum
==================
*/
static int FindPointAreaNum(vec3_t point) {
	int areanum;
	int i;

	for (i = 0; i < 15; i++) {
		vec3_t dir;
		vec3_t end;
		trace_t trace;

		dir[0] = crandom();
		dir[1] = crandom();
		dir[2] = crandom();
		VectorNormalize(dir);
		VectorMA(point, 100, dir, end);
		trap_Trace(&trace, point, NULL, NULL, end, ENTITYNUM_NONE, MASK_SOLID);
		if (trace.allsolid || trace.startsolid || trace.fraction >= 1) continue;

		areanum = GetPointAreaNum(trace.endpos);
		if (areanum <= 0) continue;

		return areanum;
	}
	return 0;
}

/*
==================
JUHOX: FindDroppedOrTakenFlag
==================
*/
static int redFlagArea;
static float redFlagAreaTime;
static int blueFlagArea;
static float blueFlagAreaTime;
qboolean FindDroppedOrTakenFlag(int team, bot_goal_t* goal) {
	gentity_t* flag;
	int* flagArea;
	float* flagAreaTime;

	if (g_gametype.integer != GT_CTF) return qfalse;
	flag = Team_GetDroppedOrTakenFlag(team);
	if (!flag) return qfalse;
	if (!flag->inuse) return qfalse;
	if (!flag->r.linked) return qfalse;

	goal->entitynum = flag->s.number;
	goal->areanum = GetPointAreaNum(flag->s.pos.trBase);
	switch (team) {
	case TEAM_RED:
		flagArea = &redFlagArea;
		flagAreaTime = &redFlagAreaTime;
		break;
	case TEAM_BLUE:
		flagArea = &blueFlagArea;
		flagAreaTime = &blueFlagAreaTime;
		break;
	default:
		return qfalse;
	}
	if (goal->areanum <= 0) {
		if (FloatTime() < *flagAreaTime + 1.0 && *flagArea > 0) {
			goal->areanum = *flagArea;
		}
		else {
			goal->areanum = FindPointAreaNum(flag->s.pos.trBase);
			if (goal->areanum > 0) {
				*flagArea = goal->areanum;
				*flagAreaTime = FloatTime();
			}
			else if (*flagArea > 0 && FloatTime() < *flagAreaTime + 3.0) {
				goal->areanum = *flagArea;
			}
			else {
				return qfalse;
			}
		}
	}
	else {
		*flagArea = goal->areanum;
		*flagAreaTime = FloatTime();
	}
	goal->flags = 0;
	VectorCopy(flag->s.pos.trBase, goal->origin);
	VectorSet(goal->mins, -8, -8, -8);
	VectorSet(goal->maxs, 8, 8, 8);
	return qtrue;
}

/*
==================
JUHOX: LocateFlag
==================
*/
qboolean LocateFlag(int team, bot_goal_t* goal) {
	if (g_gametype.integer != GT_CTF) return qfalse;
	switch (Team_GetFlagStatus(team)) {
	case FLAG_ATBASE:
		switch (team) {
		case TEAM_RED:
			memcpy(goal, &ctf_redflag, sizeof(*goal));
			redFlagArea = 0;
			return qtrue;
		case TEAM_BLUE:
			memcpy(goal, &ctf_blueflag, sizeof(*goal));
			blueFlagArea = 0;
			return qtrue;
		}
		return qfalse;
	case FLAG_TAKEN:
		//return FindTakenFlag(team, goal);
	case FLAG_DROPPED:
		return FindDroppedOrTakenFlag(team, goal);
	default:
		return qfalse;
	}
}

/*
==================
JUHOX: BotGetDroppedFlag
==================
*/
void BotGetDroppedFlag(bot_state_t* bs, int team) {
	bot_goal_t goal;

	bs->ltgtype = 0;
	if (!FindDroppedOrTakenFlag(team, &goal)) return;

	//set message time to zero so bot will NOT show any message
	bs->teammessage_time = 0;
	bs->ltgtype = LTG_GETITEM;
	//set the team goal
	memcpy(&bs->teamgoal, &goal, sizeof(bot_goal_t));
	//get the team goal time
	bs->teamgoal_time = FloatTime() + 120;
	bs->teammate = 0;
}

/*
==================
JUHOX: BotTeamReadyToGo
==================
*/
qboolean BotTeamReadyToGo(bot_state_t* bs) {
	playerState_t ps;
	int teammate;

	if (gametype < GT_TEAM) return qtrue;

	if (gametype == GT_CTF) {
		if (BotOwnFlagStatus(bs) != FLAG_ATBASE) return qtrue;
		if (BotEnemyFlagStatus(bs) == FLAG_TAKEN) return qtrue;
	}

	for (teammate = -1; (teammate = BotGetNextTeamMate(bs, teammate, &ps)) >= 0; ) {
		int danger;

		if (ps.stats[STAT_HEALTH] <= 0) continue;
		if (ps.powerups[PW_REDFLAG] || ps.powerups[PW_BLUEFLAG]) continue;
		danger = BotPlayerDanger(&ps);
		if (
			danger >= 25 ||
			ps.stats[STAT_STRENGTH] < LOW_STRENGTH_VALUE ||
			ps.weaponstate != WEAPON_READY/* ||
			(
				danger >= 10 &&
				!BotEntityVisible(&bs->cur_ps, 360, teammate) &&
				trap_AAS_AreaTravelTimeToGoalArea(BotPointAreaNum(ps.origin), ps.origin, bs->areanum, TFL_DEFAULT) > 200
			)
			*/
		) {
			return qfalse;
		}
	}
	return qtrue;
}

/*
==================
JUHOX: BotFulfilMission
==================
*/
#if BOTS_USE_TSS
static void BotFulfilMission(bot_state_t* bs) {
	tss_mission_t mission;
	bot_goal_t goal;

	if (!BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_isValid)) return;
	mission = BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_mission);

	switch (mission) {
	case TSSMISSION_seek_enemy:
		if (bs->enemy >= 0) {
			bs->ltgtype = 0;
			return;
		}

		if (bs->ltgtype == LTG_CAMP) return;
		if (BotChooseTeamleaderGoal(bs, &goal)) {
			bs->noTeamLeaderGoal_time = 0;
			BotGoNearGoal(bs, &goal);
		}
		else if (bs->noTeamLeaderGoal_time <= 0) {
			bs->noTeamLeaderGoal_time = FloatTime();
		}
		else if (bs->noTeamLeaderGoal_time < FloatTime() - 4) {
			bs->leader = -1;
		}
		break;
	case TSSMISSION_seek_items:
		if (bs->ltgtype == LTG_CAMP) return;
		if (BotChooseTeamleaderGoal(bs, &goal)) {
			bs->noTeamLeaderGoal_time = 0;
			BotGoNearGoal(bs, &goal);
		}
		else if (bs->noTeamLeaderGoal_time <= 0) {
			bs->noTeamLeaderGoal_time = FloatTime();
		}
		else if (bs->noTeamLeaderGoal_time < FloatTime() - 4) {
			bs->leader = -1;
		}
		break;
	case TSSMISSION_capture_enemy_flag:
		switch (BotEnemyFlagStatus(bs)) {
		case FLAG_ATBASE:
			bs->ltgtype = LTG_GETFLAG;
			bs->teammessage_time = 0;
			bs->teamgoal_time = trap_AAS_Time() + CTF_GETFLAG_TIME;
			break;
		case FLAG_DROPPED:
			BotGetDroppedFlag(bs, OtherTeam(bs->cur_ps.persistant[PERS_TEAM]));
			break;
		case FLAG_TAKEN:
		default:
			// should not happen
			bs->ltgtype = 0;
			break;
		}
		break;
	case TSSMISSION_defend_our_flag:
		switch (BotOwnFlagStatus(bs)) {
		case FLAG_ATBASE:
			BotGoToGoal(bs, BotGetHomeBase(bs));
			break;
		case FLAG_DROPPED:
			BotGetDroppedFlag(bs, bs->cur_ps.persistant[PERS_TEAM]);
			break;
		case FLAG_TAKEN:
			bs->ltgtype = LTG_RETURNFLAG;
			bs->teammessage_time = 0;
			bs->teamgoal_time = trap_AAS_Time() + CTF_RETURNFLAG_TIME;
			break;
		default:
			bs->ltgtype = 0;
			break;
		}
		break;
	case TSSMISSION_defend_our_base:
		BotGoToGoal(bs, BotGetHomeBase(bs));
		break;
	case TSSMISSION_occupy_enemy_base:
		BotGoToGoal(bs, BotGetEnemyBase(bs));
		break;
	default:
		bs->ltgtype = 0;
		break;
	}
}
#endif

/*
==================
JUHOX: BotTeamGameSingleBotAI
==================
*/
void BotTeamGameSingleBotAI(bot_state_t* bs) {
	if (bs->singlebot_ltg_check_time > FloatTime()) return;
	bs->singlebot_ltg_check_time = FloatTime() + 0.5 + random();

	if (bs->ltgtype == LTG_ESCAPE) return;
	if (BotWantsToEscape(bs)) {
		BotActivateHumanHelpers(bs);
		bs->ltgtype = 0;
		return;
	}

	if (gametype < GT_TEAM) return;

#if BOTS_USE_TSS
	if (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_isValid)) {
		tss_missionTask_t task;
		int teammate;

		task = BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_task);
		switch (task) {
		case TSSMT_stickToGroupLeader:
		case TSSMT_helpTeamMate:
		case TSSMT_guardFlagCarrier:
		case TSSMT_seekGroupMember:
		case TSSMT_seekEnemyNearTeamMate:
			teammate = BotTeamMateToFollow(bs);
			if (teammate < 0) {
				bs->ltgtype = 0;
				break;
			}
			BotSearchTeammate(bs, teammate);
			break;
		case TSSMT_followGroupLeader:
			{
				gclient_t* client;
				bot_goal_t missionGoal;
				qboolean missionGoalAvailable;

				teammate = BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_taskGoal);
				if (teammate < 0 || teammate >= MAX_CLIENTS || teammate == bs->client) {
					bs->ltgtype = 0;
					break;
				}
				client = &level.clients[teammate];
				switch (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_mission)) {
				case TSSMISSION_capture_enemy_flag:
					missionGoalAvailable = LocateFlag(OtherTeam(bs->cur_ps.persistant[PERS_TEAM]), &missionGoal);
					break;
				case TSSMISSION_occupy_enemy_base:
					missionGoal = *BotGetEnemyBase(bs);
					missionGoalAvailable = qtrue;
					break;
				case TSSMISSION_defend_our_flag:
					missionGoalAvailable = LocateFlag(bs->cur_ps.persistant[PERS_TEAM], &missionGoal);
					break;
				case TSSMISSION_defend_our_base:
					missionGoal = *BotGetHomeBase(bs);
					missionGoalAvailable = qtrue;
					break;
				case TSSMISSION_seek_enemy:
				case TSSMISSION_seek_items:
				default:
					missionGoalAvailable = qfalse;
					break;
				}
				if (
					missionGoalAvailable &&
					trap_AAS_AreaTravelTimeToGoalArea(
						bs->areanum, bs->origin, client->tssLastValidAreaNum, TFL_DEFAULT
					) >
					trap_AAS_AreaTravelTimeToGoalArea(
						bs->areanum, bs->origin, missionGoal.areanum, TFL_DEFAULT
					) + 200
				) {
					BotFulfilMission(bs);
				}
				else {
					teammate = BotTeamMateToFollow(bs);
					if (teammate < 0) {
						bs->ltgtype = 0;
					}
					else {
						BotSearchTeammate(bs, teammate);
					}
				}
			}
			break;
		case TSSMT_retreat:
		case TSSMT_prepareForMission:
		default:
			bs->ltgtype = 0;
			break;
		case TSSMT_rushToBase:
			BotRushToBase(bs);
			break;
		case TSSMT_fulfilMission:
			BotFulfilMission(bs);
			break;
		}
		return;
	}
#endif

	// check some special cases
	if (bs->cur_ps.powerups[PW_REDFLAG] || bs->cur_ps.powerups[PW_BLUEFLAG]) {
		BotRushToBase(bs);
		return;
	}
	if (
		gametype == GT_CTF &&
		BotOwnFlagStatus(bs) == FLAG_TAKEN &&
		BotEnemyFlagStatus(bs) == FLAG_ATBASE
	) {
		bs->ltgtype = LTG_GETFLAG;
		bs->teammessage_time = 0;
		bs->teamgoal_time = FloatTime() + CTF_GETFLAG_TIME;
		return;
	}

	// standard case
	if (!bs->ltgtype || bs->ltgtype == LTG_TEAMHELP) {
		int teammate;
		playerState_t ps;

		teammate = BotTeamMateToFollow(bs);
		if (teammate < 0) {
			bs->ltgtype = 0;
			return;
		}

		if (!BotAI_GetClientState(teammate, &ps)) {
			bs->ltgtype = 0;
			return;
		}
		if (BotPlayerDanger(&ps) >= 50) {
			BotDecidesToHelp(bs, teammate);
		}
		else {
			BotSearchTeammate(bs, teammate);
		}
	}
	else if (bs->leader != bs->client) {
		bs->ltgtype = 0;
	}
}

/*
==================
JUHOX: BotSetGroupFormation
==================
*/
#if BOTS_USE_TSS
static void BotSetGroupFormation(bot_state_t* bs) {
// JUHOX FIXME: as far as I remember the TSS does NOT support the following logic completely, so DONT REMOVE it!
/*
	tss_mission_t mission;
	tss_groupFormation_t oldGF;
	tss_groupFormation_t newGF;
	playerState_t ps;

	mission = BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_mission);
	oldGF = BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_groupFormation);

	if (mission != bs->oldMission) {
		bs->oldMission = mission;
		bs->missionChangeTime = FloatTime();
	}

	if (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_missionStatus) == TSSMS_aborted) {
		newGF = TSSGF_tight;
	}
	else {
		switch (mission) {
		case TSSMISSION_seek_enemy:
			if (bs->enemy < 0) {
				newGF = TSSGF_tight;
			}
			else {
				newGF = TSSGF_loose;
			}
			break;
		case TSSMISSION_seek_items:
		case TSSMISSION_defend_our_base:
			newGF = TSSGF_loose;
			break;
		case TSSMISSION_occupy_enemy_base:
			if (BotOwnFlagStatus(bs) != FLAG_ATBASE && BotEnemyFlagStatus(bs) != FLAG_TAKEN) {
				newGF = TSSGF_free;
			}
			else if (NearHomeBase(OtherTeam(bs->cur_ps.persistant[PERS_TEAM]), bs->origin, 9)) {
				newGF = TSSGF_loose;
			}
			else {
				newGF = TSSGF_tight;
			}
			break;
		case TSSMISSION_capture_enemy_flag:
			switch (BotEnemyFlagStatus(bs)) {
			case FLAG_TAKEN:
			default:
				newGF = TSSGF_tight;
				break;
			case FLAG_DROPPED:
				newGF = TSSGF_free;
				break;
			case FLAG_ATBASE:
				if (
					NearHomeBase(OtherTeam(bs->cur_ps.persistant[PERS_TEAM]), bs->origin, 9) ||
					BotOwnFlagStatus(bs) != FLAG_ATBASE
				) {
					newGF = TSSGF_free;
				}
				else {
					newGF = TSSGF_tight;
				}
				break;
			}
			break;
		case TSSMISSION_defend_our_flag:
			switch (BotOwnFlagStatus(bs)) {
			case FLAG_ATBASE:
				newGF = TSSGF_loose;
				if (!NearHomeBase(bs->cur_ps.persistant[PERS_TEAM], bs->origin, 1)) {
					newGF = TSSGF_free;
				}
				break;
			case FLAG_DROPPED:
				newGF = TSSGF_free;
				break;
			case FLAG_TAKEN:
				newGF = TSSGF_tight;
				if (BotEnemyFlagStatus(bs) != FLAG_TAKEN) {
					newGF = TSSGF_free;
				}
				else if (BotAI_GetClientState(bs->enemy, &ps)) {
					if (ps.powerups[PW_REDFLAG] || ps.powerups[PW_BLUEFLAG]) {
						newGF = TSSGF_free;
					}
				}
				break;
			}
			break;
		default:	// should not happen
			newGF = TSSGF_tight;
			break;
		}
	}

	if (newGF == oldGF) {
		bs->groupFormationProposal = newGF;
		bs->groupFormationProposalTime = 0;
	}
	else if (
		newGF != bs->groupFormationProposal ||
		bs->groupFormationProposalTime <= 0.0
	) {
		bs->groupFormationProposal = newGF;
		if (bs->missionChangeTime < FloatTime() - 2) {
			bs->groupFormationProposalTime = FloatTime() + 0.5;
		}
		else {
			bs->groupFormationProposalTime = FloatTime() + 1 + random();
		}
	}
	else if (bs->groupFormationProposalTime < FloatTime()) {
		int group;

		bs->groupFormationProposalTime = 0.0;

		group = BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_group);
		if (group >= 0 && group < MAX_GROUPS) {
			tss_serverdata_t* tss;

			switch (bs->cur_ps.persistant[PERS_TEAM]) {
			case TEAM_RED:
				tss = &level.redTSS;
				break;
			case TEAM_BLUE:
				tss = &level.blueTSS;
				break;
			default:
				return;
			}
			tss->groupFormation[group] = newGF;
		}
	}
*/
	tss_groupFormation_t oldGF;
	tss_groupFormation_t newGF;
	int group;
	tss_serverdata_t* tss;

	oldGF = BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_groupFormation);
	newGF = BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_suggestedGF);
	if (oldGF == newGF) return;

	switch (newGF) {
	case TSSGF_tight:
	case TSSGF_loose:
	case TSSGF_free:
		break;
	default:
		return;
	}

	group = BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_group);
	if (group < 0 || group >= MAX_GROUPS) return;

	switch (bs->cur_ps.persistant[PERS_TEAM]) {
	case TEAM_RED:
		tss = &level.redTSS;
		break;
	case TEAM_BLUE:
		tss = &level.blueTSS;
		break;
	default:
		return;
	}

	tss->groupFormation[group] = newGF;
}
#endif

/*
==================
JUHOX: BotTeamLeaderAI
==================
*/
void BotTeamLeaderAI(bot_state_t* bs) {
#if BOTS_USE_TSS
	if (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_isValid)) {
		BotSetGroupFormation(bs);
		return;
	}
#endif

	if (bs->teamleader_ltg_check_time > FloatTime()) return;
	bs->teamleader_ltg_check_time = FloatTime() + 0.5 + random();

	if (gametype == GT_CTF) {
		static int redOrderState;
		static int blueOrderState;

		if (Team_GetFlagStatus(TEAM_RED) == FLAG_ATBASE) redOrderState = 0;
		if (Team_GetFlagStatus(TEAM_BLUE) == FLAG_ATBASE) blueOrderState = 0;

		if (bs->ltgtype == LTG_GETFLAG && BotEnemyFlagStatus(bs) != FLAG_ATBASE) {
			bs->ltgtype = 0;
		}

		if (bs->enemy < 0) {
			if (!bs->ltgtype) {
				int* orderState;
				bot_goal_t* homeBase;
				bot_goal_t* enemyBase;
				bot_goal_t goal;

				if (BotEnemyFlagStatus(bs) == FLAG_ATBASE) {
					bs->ltgtype = LTG_GETFLAG;
					bs->teammessage_time = 0;
					bs->teamgoal_time = trap_AAS_Time() + CTF_GETFLAG_TIME;
					return;
				}

				switch (bs->cur_ps.persistant[PERS_TEAM]) {
				case TEAM_RED:
					orderState = &redOrderState;
					homeBase = &ctf_redflag;
					enemyBase = &ctf_blueflag;
					break;
				case TEAM_BLUE:
					orderState = &blueOrderState;
					homeBase = &ctf_blueflag;
					enemyBase = &ctf_redflag;
					break;
				default:
					return;
				}

				// searching flags
				if (BotTeamReadyToGo(bs)) {
					switch (*orderState) {
					case 0:
						//if (trap_BotTouchingGoal(bs->origin, homeBase)) (*orderState)++;
						if (DistanceSquared(bs->origin, homeBase->origin) < 300.0*300.0) (*orderState)++;
						else BotGoToGoal(bs, homeBase);
						break;
					case 1:
					case 3:
					default:
						if (BotChooseTeamleaderGoal(bs, &goal)) {
							BotGoNearGoal(bs, &goal);
						}
						(*orderState)++;
						(*orderState) &= 3;
						break;
					case 2:
						//if (trap_BotTouchingGoal(bs->origin, enemyBase)) (*orderState)++;
						if (DistanceSquared(bs->origin, enemyBase->origin) < 300.0*300.0) (*orderState)++;
						else BotGoToGoal(bs, enemyBase);
						break;
					}
				}
			}
		}
		else if (	// bs->enemy >= 0
			bs->ltgtype == LTG_CAMP ||
			bs->ltgtype == LTG_CAMPORDER
		) {
			bs->ltgtype = 0;
		}
	}
	else {	// gametype != GT_CTF
		if (bs->enemy < 0) {
			if (
				bs->ltgtype != LTG_CAMP &&
				//bs->nbg_time < FloatTime() &&
				BotPlayerDanger(&bs->cur_ps) < 25
			) {
				if (BotTeamReadyToGo(bs)) {
					bot_goal_t goal;

					if (BotChooseTeamleaderGoal(bs, &goal)) {
						bs->noTeamLeaderGoal_time = 0;
						BotGoNearGoal(bs, &goal);
					}
					else if (bs->noTeamLeaderGoal_time <= 0) {
						bs->noTeamLeaderGoal_time = FloatTime();
					}
					else if (bs->noTeamLeaderGoal_time < FloatTime() - 4) {
						bs->leader = -1;
					}
				}
			}
			else if (bs->ltgtype == LTG_CAMP && !BotTeamReadyToGo(bs)) {
				bs->ltgtype = 0;
			}
		}
		else {
			bs->ltgtype = 0;
		}
	}
}

/*
==================
JUHOX: BotMissionLeaderAI
==================
*/
typedef enum {
	BS_TDM_crowd,
	BS_TDM_maxforce,
	BS_TDM_pliers2,
	BS_TDM_pliers3,

	BS_TDM_num_strategies
} bot_tdm_strategy;
typedef enum {
	BS_CTF_maxforce,
	BS_CTF_simple,
	BS_CTF_pliers,
	BS_CTF_powerpliers,
	BS_CTF_defensive,

	BS_CTF_num_strategies
} bot_ctf_strategy;
#define BOT_MAX_STRATEGIES 8
typedef struct {
	int strategy;
	int lastEnemyScore;
	int lastOwnScore;
	int lastEnemyTakenCount;
	int lastOwnTakenCount;
	int lastEnemyPossessionTime;
	int lastOwnPossessionTime;
	qboolean initialized;
	int strategySuccess[BOT_MAX_STRATEGIES];
} bot_missionleaderdata_t;
typedef struct {
	int rank;
	int minTotal;
	int minAlive;
	int minReady;
	tss_mission_t mission;
	int maxDanger;
	int missionMinReady;
	int minGroupSize;
	int maxGuards;
} bot_tss_groupinstructions_t;
typedef bot_tss_groupinstructions_t bot_tss_instructions_t[MAX_GROUPS];
void BotMissionLeaderAI(bot_state_t *bs) {
	// NOTE: the compiler seems to have a problem initializing a tss_instructions_t variable,
	//       so we use bot_tss_instructions_t instead.

	// team deathmatch
	static const bot_tss_instructions_t tdm_crowd_disperse = {
		{0, 10, 0, 0, TSSMISSION_seek_enemy, 25, 0, 0, 0},
		{1, 10, 0, 0, TSSMISSION_seek_enemy, 25, 0, 0, 0},
		{2, 10, 0, 0, TSSMISSION_seek_enemy, 25, 0, 0, 0},
		{3, 10, 0, 0, TSSMISSION_seek_enemy, 25, 0, 0, 0},
		{4, 10, 0, 0, TSSMISSION_seek_enemy, 25, 0, 0, 0},
		{5, 10, 0, 0, TSSMISSION_seek_enemy, 25, 0, 0, 0},
		{6, 10, 0, 0, TSSMISSION_seek_enemy, 25, 0, 0, 0},
		{7, 10, 0, 0, TSSMISSION_seek_enemy, 25, 0, 0, 0},
		{8, 10, 0, 0, TSSMISSION_seek_enemy, 25, 0, 0, 0},
		{9, 10, 0, 0, TSSMISSION_seek_enemy, 25, 0, 0, 0}
	};
	static const bot_tss_instructions_t tdm_crowd_hide = {
		{0, 100, 0, 0, TSSMISSION_seek_items, 25, 0, 0, 1},
		{1, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{2, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{3, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{4, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{5, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{6, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{7, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{8, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{9, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0}
	};
	static const bot_tss_instructions_t tdm_maxforce_default = {
		{0, 100, 0, 0, TSSMISSION_seek_enemy, 25, 50, 30, 1},
		{1, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{2, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{3, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{4, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{5, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{6, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{7, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{8, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{9, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0}
	};
	static const bot_tss_instructions_t tdm_pliers2_default = {
		{0, 50, 0, 0, TSSMISSION_seek_enemy, 25, 50, 30, 1},
		{1, 50, 0, 0, TSSMISSION_seek_enemy, 25, 50, 30, 1},
		{2, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{3, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{4, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{5, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{6, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{7, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{8, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{9, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0}
	};
	static const bot_tss_instructions_t tdm_pliers3_default = {
		{0, 34, 0, 0, TSSMISSION_seek_enemy, 25, 50, 30, 1},
		{1, 33, 0, 0, TSSMISSION_seek_enemy, 25, 50, 30, 1},
		{2, 33, 0, 0, TSSMISSION_seek_enemy, 25, 50, 30, 1},
		{3, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{4, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{5, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{6, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{7, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{8, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{9, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0}
	};

	// capture the flag
	static const bot_tss_instructions_t ctf_maxforce_getEnemyFlag = {
		{0, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{1, 100, 0, 0, TSSMISSION_capture_enemy_flag, 25, 50, 50, 0},
		{2, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{3, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{4, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{5, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{6, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{7, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{8, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{9, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0}
	};
	static const bot_tss_instructions_t ctf_maxforce_emergency = {
		{0, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{1, 100, 0, 0, TSSMISSION_capture_enemy_flag, 75, 0, 0, 0},
		{2, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{3, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{4, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{5, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{6, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{7, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{8, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{9, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0}
	};
	static const bot_tss_instructions_t ctf_maxforce_returnOurFlag = {
		{0, 66, 49, 75, TSSMISSION_defend_our_flag, 50, 50, 50, 0},
		{1, 34, 49, 75, TSSMISSION_capture_enemy_flag, 25, 50, 50, 0},
		{2, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{3, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{4, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{5, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{6, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{7, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{8, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{9, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0}
	};
	static const bot_tss_instructions_t ctf_simple_normal = {
		{0, 50, 49, 75, TSSMISSION_defend_our_flag, 50, 50, 50, 0},
		{1, 50, 49, 75, TSSMISSION_capture_enemy_flag, 25, 50, 50, 0},
		{2, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{3, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{4, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{5, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{6, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{7, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{8, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{9, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0}
	};
	static const bot_tss_instructions_t ctf_simple_emergency = {
		{0, 34, 49, 75, TSSMISSION_defend_our_flag, 70, 0, 0, 0},
		{1, 66, 49, 75, TSSMISSION_capture_enemy_flag, 50, 0, 0, 0},
		{2, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{3, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{4, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{5, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{6, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{7, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{8, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{9, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0}
	};
	static const bot_tss_instructions_t ctf_powerpliers_emergency = {
		{0, 34, 49, 75, TSSMISSION_defend_our_flag, 70, 0, 0, 0},
		{1, 33, 49, 75, TSSMISSION_capture_enemy_flag, 50, 0, 0, 0},
		{2, 33, 49, 0, TSSMISSION_occupy_enemy_base, 50, 0, 0, 0},
		{3, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{4, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{5, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{6, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{7, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{8, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{9, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0}
	};
	static const bot_tss_instructions_t ctf_powerpliers_normal = {
		{0, 33, 49, 75, TSSMISSION_defend_our_flag, 50, 49, 49, 0},
		{1, 34, 49, 75, TSSMISSION_capture_enemy_flag, 25, 49, 49, 0},
		{2, 33, 0, 0, TSSMISSION_occupy_enemy_base, 25, 49, 49, 0},
		{3, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{4, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{5, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{6, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{7, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{8, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{9, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0}
	};
	static const bot_tss_instructions_t ctf_powerpliers_power = {
		{0, 50, 49, 75, TSSMISSION_defend_our_flag, 50, 0, 0, 0},
		{1, 50, 49, 75, TSSMISSION_capture_enemy_flag, 25, 0, 0, 0},
		{2, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{3, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{4, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{5, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{6, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{7, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{8, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{9, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0}
	};
	static const bot_tss_instructions_t ctf_defensive_normal = {
		{0, 25, 49, 75, TSSMISSION_defend_our_flag, 50, 49, 49, 0},
		{1, 25, 49, 75, TSSMISSION_capture_enemy_flag, 25, 49, 49, 0},
		{2, 25, 0, 0, TSSMISSION_occupy_enemy_base, 25, 49, 49, 0},
		{3, 25, 0, 0, TSSMISSION_defend_our_base, 50, 49, 49, 0},
		{4, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{5, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{6, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{7, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{8, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
		{9, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0}
	};

	static bot_missionleaderdata_t missionleaderdata[2];
	bot_missionleaderdata_t* mld;
	int enemyScore;
	int ownScore;
	int enemyTakenCount;
	int ownTakenCount;
	int enemyPossessionTime;
	int ownPossessionTime;
	int success;
	tss_serverdata_t* tss;
	int gr;
	int numStrategies;
	const bot_tss_instructions_t* instr;




	if (!g_tss.integer) return;

	switch (bs->cur_ps.persistant[PERS_TEAM]) {
	case TEAM_RED:
		mld = &missionleaderdata[0];
		tss = &level.redTSS;
		enemyScore = level.teamScores[TEAM_BLUE];
		ownScore = level.teamScores[TEAM_RED];
		enemyTakenCount = level.ctfRedTakenCount;
		ownTakenCount = level.ctfBlueTakenCount;
		enemyPossessionTime = level.ctfRedPossessionTime;
		ownPossessionTime = level.ctfBluePossessionTime;
		break;
	case TEAM_BLUE:
		mld = &missionleaderdata[1];
		tss = &level.blueTSS;
		enemyScore = level.teamScores[TEAM_RED];
		ownScore = level.teamScores[TEAM_BLUE];
		enemyTakenCount = level.ctfBlueTakenCount;
		ownTakenCount = level.ctfRedTakenCount;
		enemyPossessionTime = level.ctfBluePossessionTime;
		ownPossessionTime = level.ctfRedPossessionTime;
		break;
	default:
		return;
	}

	if (tss->lastUpdateTime > level.time - 2000) return;
	tss->lastUpdateTime = level.time;

	switch (g_gametype.integer) {
	case GT_CTF:
		numStrategies = BS_CTF_num_strategies;
		break;
	case GT_TEAM:
		numStrategies = BS_TDM_num_strategies;
		break;
	default:
		return;
	}
	if (mld->strategy < 0 || mld->strategy >= numStrategies) {
		G_Error("invalid strategy #%d\n", mld->strategy);
	}

	if (!mld->initialized) {
		mld->strategy = rand() % numStrategies;
		mld->initialized = qtrue;
	}

	success = mld->strategySuccess[mld->strategy];

	success += (ownScore - mld->lastOwnScore) * 1000;
	success -= (enemyScore - mld->lastEnemyScore) * 1000;
	mld->lastOwnScore = ownScore;
	mld->lastEnemyScore = enemyScore;

	if (g_gametype.integer == GT_CTF) {
		success += (ownTakenCount - mld->lastOwnTakenCount) * 100;
		success -= (enemyTakenCount - mld->lastEnemyTakenCount) * 100;
		mld->lastOwnTakenCount = ownTakenCount;
		mld->lastEnemyTakenCount = enemyTakenCount;

		success += (ownPossessionTime - mld->lastOwnPossessionTime) / 100;
		success -= (enemyPossessionTime - mld->lastEnemyPossessionTime) / 100;
		mld->lastOwnPossessionTime = ownPossessionTime;
		mld->lastEnemyPossessionTime = enemyPossessionTime;
	}

	switch (g_gametype.integer) {
	case GT_CTF:
		success -= rand() % 40;
		break;
	case GT_TEAM:
	default:
		success -= rand() % 100;
		break;
	}

	mld->strategySuccess[mld->strategy] = success;

	{
		int i;
		int bestSuccess;
		int bestStrategy;

		bestSuccess = -1000000000;
		bestStrategy = 0;
		for (i = 0; i < numStrategies; i++) {
			success = mld->strategySuccess[i];
			if (i == mld->strategy) success += 1000;
			if (success <= bestSuccess) continue;

			bestSuccess = success;
			bestStrategy = i;
		}

		mld->strategy = bestStrategy;
	}

	instr = NULL;
	if (g_gametype.integer == GT_CTF) {
		switch (mld->strategy) {
		case BS_CTF_maxforce:
			if (
				BotOwnFlagStatus(bs) != FLAG_ATBASE &&
				BotEnemyFlagStatus(bs) != FLAG_TAKEN
			) {
				instr = &ctf_maxforce_emergency;
			}
			else if (
				BotEnemyFlagStatus(bs) != FLAG_TAKEN ||
				BotOwnFlagStatus(bs) == FLAG_ATBASE ||
				tss->ofp < 0
			) {
				instr = &ctf_maxforce_getEnemyFlag;
			}
			else {
				instr = &ctf_maxforce_returnOurFlag;
			}
			break;
		case BS_CTF_simple:
			if (
				BotOwnFlagStatus(bs) == FLAG_ATBASE ||
				BotEnemyFlagStatus(bs) == FLAG_TAKEN
			) {
				instr = &ctf_simple_normal;
			}
			else {
				instr = &ctf_simple_emergency;
			}
			break;
		case BS_CTF_pliers:
			if (
				BotOwnFlagStatus(bs) == FLAG_ATBASE ||
				BotEnemyFlagStatus(bs) == FLAG_TAKEN
			) {
				instr = &ctf_powerpliers_normal;
			}
			else {
				instr = &ctf_powerpliers_emergency;
			}
			break;
		case BS_CTF_powerpliers:
			if (
				BotOwnFlagStatus(bs) != FLAG_ATBASE &&
				BotEnemyFlagStatus(bs) != FLAG_TAKEN
			) {
				instr = &ctf_powerpliers_emergency;
			}
			else if (
				BotEnemyFlagStatus(bs) == FLAG_TAKEN &&
				tss->ofp >= 10 &&
				tss->yfp >= 10
			) {
				instr = &ctf_powerpliers_power;
			}
			else {
				instr = &ctf_powerpliers_normal;
			}
			break;
		case BS_CTF_defensive:
			if (
				BotOwnFlagStatus(bs) != FLAG_ATBASE &&
				BotEnemyFlagStatus(bs) != FLAG_TAKEN
			) {
				instr = &ctf_powerpliers_emergency;
			}
			else {
				instr = &ctf_defensive_normal;
			}
			break;
		default:
			mld->strategy = 0;
			break;
		}
	}
	else {	// GT_TDM
		switch (mld->strategy) {
		case BS_TDM_crowd:
			if (BG_TSS_Proportion(tss->yaq, tss->yts, 100) > BG_TSS_Proportion(tss->oaq, tss->ots, 100) - 20) {
				instr = &tdm_crowd_disperse;
			}
			else if (BG_TSS_Proportion(tss->rfa, tss->yaq, 100) > 75) {
				instr = &tdm_maxforce_default;
			}
			else {
				instr = &tdm_crowd_hide;
			}
			break;
		case BS_TDM_maxforce:
			instr = &tdm_maxforce_default;
			break;
		case BS_TDM_pliers2:
			instr = &tdm_pliers2_default;
			break;
		case BS_TDM_pliers3:
			instr = &tdm_pliers3_default;
			break;
		default:
			mld->strategy = 0;
			break;
		}
	}
	if (!instr) return;

	tss->instructions.division.unassignedPlayers = 0;
	tss->rfa_dangerLimit = 25;
	tss->rfd_dangerLimit = 70;
	tss->short_term = 0.1 * 1000 * g_respawnDelay.value;
	tss->medium_term = 0.25 * 1000 * g_respawnDelay.value;
	tss->long_term = 0.75 * 1000 * g_respawnDelay.value;
	for (gr = 0; gr < MAX_GROUPS; gr++) {
		tss->designated1stLeaders[gr] = -1;
		tss->designated2ndLeaders[gr] = -1;
		tss->designated3rdLeaders[gr] = -1;

		tss->instructions.groupOrganization[gr] =				(*instr)[gr].rank;
		tss->instructions.division.group[gr].minTotalMembers =	(*instr)[gr].minTotal;
		tss->instructions.division.group[gr].minAliveMembers =	(*instr)[gr].minAlive;
		tss->instructions.division.group[gr].minReadyMembers =	(*instr)[gr].minReady;
		tss->instructions.orders.order[gr].mission =			(*instr)[gr].mission;
		tss->instructions.orders.order[gr].maxDanger =			(*instr)[gr].maxDanger;
		tss->instructions.orders.order[gr].minReady =			(*instr)[gr].missionMinReady;
		tss->instructions.orders.order[gr].minGroupSize =		(*instr)[gr].minGroupSize;
		tss->instructions.orders.order[gr].maxGuards =			(*instr)[gr].maxGuards;
	}

	tss->isValid = qtrue;
}

/*
==================
BotTeamAI
==================
*/
void BotTeamAI(bot_state_t *bs) {
#if 0	// JUHOX: 'numteammates' & 'netname' no longer needed
	int numteammates;
	char netname[MAX_NETNAME];
#endif

#if 0	// JUHOX: team ai is now strategic ai, so allow it for FFA too
	//
	if ( gametype < GT_TEAM  )
		return;
#endif
#if 1	// JUHOX: mission leader ai
	if (
		gametype >= GT_TEAM &&
		g_entities[bs->client].client->sess.teamLeader
	) {
		BotMissionLeaderAI(bs);
	}
#endif
#if 1	// JUHOX: a dead bot silently deactivates its human helpers
	if (bs->cur_ps.stats[STAT_HEALTH] <= 0) {
		memset(&bs->humanHelpers, -1, sizeof(bs->humanHelpers));
		return;
	}
#endif
#if 0	// JUHOX: determine leader
	// make sure we've got a valid team leader
	if (!BotValidTeamLeader(bs)) {
		//
		if (!FindHumanTeamLeader(bs)) {
			//
			if (!bs->askteamleader_time && !bs->becometeamleader_time) {
				if (bs->entergame_time + 10 > FloatTime()) {
					bs->askteamleader_time = FloatTime() + 5 + random() * 10;
				}
				else {
					bs->becometeamleader_time = FloatTime() + 5 + random() * 10;
				}
			}
			if (bs->askteamleader_time && bs->askteamleader_time < FloatTime()) {
				// if asked for a team leader and no response
				BotAI_BotInitialChat(bs, "whoisteamleader", NULL);
				trap_BotEnterChat(bs->cs, 0, CHAT_TEAM);
				bs->askteamleader_time = 0;
				bs->becometeamleader_time = FloatTime() + 8 + random() * 10;
			}
			if (bs->becometeamleader_time && bs->becometeamleader_time < FloatTime()) {
				BotAI_BotInitialChat(bs, "iamteamleader", NULL);
				trap_BotEnterChat(bs->cs, 0, CHAT_TEAM);
				BotSayVoiceTeamOrder(bs, -1, VOICECHAT_STARTLEADER);
				ClientName(bs->client, netname, sizeof(netname));
				strncpy(bs->teamleader, netname, sizeof(bs->teamleader));
				bs->teamleader[sizeof(bs->teamleader)] = '\0';
				bs->becometeamleader_time = 0;
			}
			return;
		}
	}
	bs->askteamleader_time = 0;
	bs->becometeamleader_time = 0;
#else
	BotDetermineLeader(bs);
#endif
	BotTeamGameSingleBotAI(bs);	// JUHOX

#if 0	// JUHOX: is this bot the leader?
	//return if this bot is NOT the team leader
	ClientName(bs->client, netname, sizeof(netname));
	if (Q_stricmp(netname, bs->teamleader) != 0) return;
#else
	if (bs->leader != bs->client) return;
#endif
	//
#if 0	// JUHOX: 'numteammates' no longer needed
	numteammates = BotNumTeamMates(bs);
#endif
	//give orders
#if 0	// JUHOX: always execute team leader ai
	switch(gametype) {
		case GT_TEAM:
		{
			if (bs->numteammates != numteammates || bs->forceorders) {
				bs->teamgiveorders_time = FloatTime();
				bs->numteammates = numteammates;
				bs->forceorders = qfalse;
			}
			//if it's time to give orders
			if (bs->teamgiveorders_time && bs->teamgiveorders_time < FloatTime() - 5) {
				BotTeamOrders(bs);
				//give orders again after 120 seconds
				bs->teamgiveorders_time = FloatTime() + 120;
			}
			break;
		}
		case GT_CTF:
		{
			//if the number of team mates changed or the flag status changed
			//or someone wants to know what to do
			if (bs->numteammates != numteammates || bs->flagstatuschanged || bs->forceorders) {
				bs->teamgiveorders_time = FloatTime();
				bs->numteammates = numteammates;
				bs->flagstatuschanged = qfalse;
				bs->forceorders = qfalse;
			}
			//if there were no flag captures the last 3 minutes
			if (bs->lastflagcapture_time < FloatTime() - 240) {
				bs->lastflagcapture_time = FloatTime();
				//randomly change the CTF strategy
				if (random() < 0.4) {
					bs->ctfstrategy ^= CTFS_AGRESSIVE;
					bs->teamgiveorders_time = FloatTime();
				}
			}
			//if it's time to give orders
			if (bs->teamgiveorders_time && bs->teamgiveorders_time < FloatTime() - 3) {
				BotCTFOrders(bs);
				//
				bs->teamgiveorders_time = 0;
			}
			break;
		}
	}
#else
	BotTeamLeaderAI(bs);
#endif
}

