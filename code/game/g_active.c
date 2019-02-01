// Copyright (C) 1999-2000 Id Software, Inc.
//

#include "g_local.h"
#include "inv.h"	// JUHOX: for MODELINDEX_INVISIBILITY

// JUHOX: includes needed for AI access
#include "botlib.h"
#include "be_aas.h"
#include "be_ea.h"
#include "be_ai_char.h"
#include "be_ai_chat.h"
#include "be_ai_gen.h"
#include "be_ai_goal.h"
#include "be_ai_move.h"
#include "be_ai_weap.h"
#include "ai_main.h"
#include "ai_dmq3.h"
#include "ai_team.h"

/*
=================
JUHOX: IsPlayerInvolvedInFighting
=================
*/
qboolean IsPlayerInvolvedInFighting(int clientNum) {
	if (clientNum < 0 || clientNum >= MAX_CLIENTS) {
		G_Error("BUG! IsPlayerInvolvedInFighting: clientNum=%d\n", clientNum);
		return qfalse;
	}

	if (g_entities[clientNum].health <= 0) return qfalse;
	if (level.clients[clientNum].ps.powerups[PW_SHIELD]) return qfalse;
	if (level.clients[clientNum].weaponUsageTime > level.time - 3000) return qtrue;
	if (level.clients[clientNum].lasthurt_time > level.time - 3000) return qtrue;

	return qfalse;
}

/*
=================
JUHOX: NearHomeBase
=================
*/
qboolean NearHomeBase(int team, const vec3_t pos, float homeWeightSquared) {
	if (g_gametype.integer < GT_CTF) return qfalse;
	if (g_gametype.integer >= GT_STU) return qfalse;

	switch (team) {
	case TEAM_RED:
		return homeWeightSquared * DistanceSquared(pos, ctf_redflag.origin) < DistanceSquared(pos, ctf_blueflag.origin);
	case TEAM_BLUE:
		return homeWeightSquared * DistanceSquared(pos, ctf_blueflag.origin) < DistanceSquared(pos, ctf_redflag.origin);
	}
	return qfalse;
}

/*
=================
JUHOX: TSS_Proportion_RoundToCeil
=================
*/
static int TSS_Proportion_RoundToCeil(int portion, int total, int newTotal) {
	if (total == 0) return 0;
	return (portion * newTotal + total - 1) / total;
}

/*
==================
JUHOX: TSS_DangerIndex

danger == -100	... e.g. 100 health, 100 armor, no handicap, not shooting, not panting, not charged
danger == 0		... e.g. health at handicap level, no armor, not shooting, not panting, not charged
danger == 10	... e.g. health at handicap level, no armor, *shooting*, not panting, not charged
danger == 20	... e.g. health at handicap level, no armor, not shooting, *completly exhausted*, not charged

danger <= -100	... unstoppable!
danger <= 0		... no danger
danger >= 11	... light danger or worse
danger >= 25	... moderate danger or worse
danger >= 50	... high danger or worse
danger >= 75	... extreme danger or worse
danger >= 100	... as good as dead
==================
*/
int TSS_DangerIndex(const playerState_t* ps) {
	float maxDamage;
	float danger;

	if (ps->stats[STAT_HEALTH] <= 0) return 0;	// a dead player is not in danger

	danger = 0;
	maxDamage = BotPlayerKillDamage(ps);
	if (ps->powerups[PW_CHARGE]) {
		float charge;

		charge = (ps->powerups[PW_CHARGE] - level.time) / 1000.0F;
		if (charge > 0.1F) {
			maxDamage -= TotalChargeDamage(charge);
		}
	}
	danger += 100 - 100 * maxDamage / ps->stats[STAT_MAX_HEALTH];

	if (ps->stats[STAT_STRENGTH] < 2*LOW_STRENGTH_VALUE) {
		danger += 20.0F * (1.0F - ps->stats[STAT_STRENGTH] / (2.0F*LOW_STRENGTH_VALUE));
	}
	return (int) danger;
}

// JUHOX: definitions for TSS group assignment
typedef enum {
	TSSGAR_unreserved,
	TSSGAR_bestDistance,
	TSSGAR_constraint,
	TSSGAR_flagCarrier,
	TSSGAR_force
} tss_groupAssignmentReservation_t;

typedef struct tss_groupAssignment_s {
	gclient_t* client;
	int clientNum;
	struct tss_groupInfo_s* oldGroup;
	tss_groupMemberStatus_t oldGMS;
	int oldTaskGoal;
	struct tss_groupInfo_s* group;
	tss_groupAssignmentReservation_t reservation;
	qboolean isAlive;
	qboolean isFighting;
	int danger;
} tss_groupAssignment_t;

static tss_groupAssignment_t* tssFlagCarrier;
static int tssNumGroupAssignments;
static tss_groupAssignment_t tssGroupAssignments[MAX_CLIENTS];
static int tssNumPlayersAlive;

typedef struct tss_groupInfo_s {
	int groupNum;
	int rank;	// index into 'groupOrganization'
	int designated1stLeader;	// client number or -1
	int designated2ndLeader;	// client number or -1
	int designated3rdLeader;	// client number or -1
	tss_groupAssignment_t* oldLeader;	// may be NULL
	tss_groupAssignment_t* currentLeader;	// may be NULL
	vec_t leaderDistanceToGoal;
	int totalPlayers;
	int minTotalPlayers;
	int alivePlayers;
	int minAlivePlayers;
	int readyPlayers;
	int minReadyPlayers;
	int maxDanger;
	int maxGuardsPerVictim;
	int minReadyForMission;
	int minGroupSize;
	tss_groupFormation_t groupFormation;
	tss_mission_t mission;
	tss_missionStatus_t missionStatus;
	qboolean missionGoalAvailable;
	bot_goal_t missionGoal;
	qboolean protectFlagCarrier;		// initialized very late
} tss_groupInfo_t;

static tss_groupInfo_t tssGroupInfo[MAX_GROUPS];
static bot_goal_t* tssHomeBase;		// for CTF
static bot_goal_t* tssEnemyBase;	// for CTF

/*
===============
JUHOX: TSS_GameTypeCompatibleMission
===============
*/
static tss_mission_t TSS_GameTypeCompatibleMission(tss_mission_t mission) {
	if (g_gametype.integer == GT_CTF) return mission;

	switch (mission) {
	case TSSMISSION_invalid:
	case TSSMISSION_seek_enemy:
	case TSSMISSION_seek_items:
		return mission;
	case TSSMISSION_capture_enemy_flag:
	case TSSMISSION_occupy_enemy_base:
		return TSSMISSION_seek_enemy;
	case TSSMISSION_defend_our_flag:
	case TSSMISSION_defend_our_base:
		return TSSMISSION_seek_items;
	default:
		break;
	}
	return TSSMISSION_seek_enemy;
}

/*
===============
JUHOX: TSS_PlayerAlivePredition
===============
*/
static void TSS_PlayerAlivePrediction(const gclient_t* client, const tss_serverdata_t* tss, float* amq, float* alq) {
	if (client->ps.stats[STAT_HEALTH] > 0) {
		*amq += 1.0;
		*alq += 1.0;
	}
	else {
		int remainingTime;

		remainingTime = client->respawnTime + client->respawnDelay - level.time;
		if (remainingTime < 0) remainingTime = 0;
		if (remainingTime < tss->medium_term) *amq += 1.0;
		if (remainingTime < tss->long_term) *alq += 1.0;
	}
}

/*
===============
JUHOX: TSS_InitGroupAssignments
===============
*/
static void TSS_InitGroupAssignments(tss_serverdata_t* tss) {
	int gr, cl, as;
	tss_groupInfo_t* gi;
	tss_groupAssignment_t* ga;

	tssNumGroupAssignments = 0;
	tssFlagCarrier = NULL;
	tssNumPlayersAlive = 0;
	if (!tss->isValid) return;

	memset(&tssGroupInfo, 0, sizeof(tssGroupInfo));
	for (gr = 0; gr < MAX_GROUPS; gr++) {
		int grp;

		grp = tss->instructions.groupOrganization[gr];
		gi = &tssGroupInfo[grp];
		gi->groupNum = grp;
		gi->rank = gr;
		gi->maxDanger = tss->instructions.orders.order[grp].maxDanger;
		gi->maxGuardsPerVictim = tss->instructions.orders.order[grp].maxGuards;
		gi->designated1stLeader = tss->designated1stLeaders[grp];
		gi->designated2ndLeader = tss->designated2ndLeaders[grp];
		gi->designated3rdLeader = tss->designated3rdLeaders[grp];
		gi->leaderDistanceToGoal = 1000000000.0;
		gi->groupFormation = tss->groupFormation[grp];
		gi->mission = TSS_GameTypeCompatibleMission(tss->instructions.orders.order[grp].mission);
		gi->missionStatus = tss->missionStatus[grp];
		gi->protectFlagCarrier = tss->protectFlagCarrier[grp];

		switch (gi->mission) {
		case TSSMISSION_invalid:
		case TSSMISSION_seek_enemy:
		case TSSMISSION_seek_items:
		default:
			gi->missionGoalAvailable = qfalse;
			// NOTE: if there's a group leader, the goal will be specified later in this function
			break;
		case TSSMISSION_capture_enemy_flag:
			gi->missionGoalAvailable = LocateFlag(OtherTeam(tss->team), &gi->missionGoal);
			break;
		case TSSMISSION_defend_our_flag:
			gi->missionGoalAvailable = LocateFlag(tss->team, &gi->missionGoal);
			break;
		case TSSMISSION_defend_our_base:
			switch (tss->team) {
			case TEAM_RED:
				memcpy(&gi->missionGoal, &ctf_redflag, sizeof(bot_goal_t));
				gi->missionGoalAvailable = qtrue;
				break;
			case TEAM_BLUE:
				memcpy(&gi->missionGoal, &ctf_blueflag, sizeof(bot_goal_t));
				gi->missionGoalAvailable = qtrue;
				break;
			default:
				gi->missionGoalAvailable = qfalse;
				break;
			}
			break;
		case TSSMISSION_occupy_enemy_base:
			switch (tss->team) {
			case TEAM_RED:
				memcpy(&gi->missionGoal, &ctf_blueflag, sizeof(bot_goal_t));
				gi->missionGoalAvailable = qtrue;
				break;
			case TEAM_BLUE:
				memcpy(&gi->missionGoal, &ctf_redflag, sizeof(bot_goal_t));
				gi->missionGoalAvailable = qtrue;
				break;
			default:
				gi->missionGoalAvailable = qfalse;
				break;
			}
			// NOTE: if there's a flag carrier, the result may be overwritten later in this function
			break;
		}
	}

	as = 0;
	for (cl = 0; cl < level.maxclients; cl++) {
		gclient_t* client;
		int areaNum;

		if (!g_entities[cl].inuse) continue;
		client = level.clients + cl;
		if (client->pers.connected != CON_CONNECTED) continue;
		if (client->sess.sessionTeam != tss->team) {
			if (client->sess.sessionTeam != TEAM_BLUE && client->sess.sessionTeam != TEAM_RED) continue;
			if (client->ps.stats[STAT_HEALTH] > 0 && client->ps.pm_type == PM_SPECTATOR) {
				// mission leader safety mode
				continue;
			}
			tss->ots++;
			if (client->ps.stats[STAT_HEALTH] > 0) tss->oaq++;
			TSS_PlayerAlivePrediction(client, tss, &tss->oamq, &tss->oalq);
			continue;
		}
		if (client->sess.teamLeader) {
			tss->missionLeader = client;
		}
		if (client->ps.stats[STAT_HEALTH] > 0 && client->ps.pm_type == PM_SPECTATOR) {
			// mission leader safety mode
			BG_TSS_SetPlayerInfo(&client->ps, TSSPI_isValid, qfalse);
			continue;
		}

		tss->yts++;
		ga = &tssGroupAssignments[as++];
		ga->client = client;
		ga->clientNum = cl;
		ga->isAlive = (client->ps.stats[STAT_HEALTH] > 0);
		ga->isFighting = qfalse;	// eventually set below
		ga->danger = TSS_DangerIndex(&client->ps);
		ga->group = NULL;
		ga->reservation = TSSGAR_unreserved;
		if (client->ps.powerups[PW_REDFLAG] || client->ps.powerups[PW_BLUEFLAG]) {
			tssFlagCarrier = ga;
		}

		if (ga->isAlive) {
			tss->avgStamina += 100 * client->ps.stats[STAT_STRENGTH] / MAX_STRENGTH_VALUE;
			tssNumPlayersAlive++;

			if (IsPlayerInvolvedInFighting(cl)) {
				tss->fightIntensity += 100;
				ga->isFighting = qtrue;
			}

			if (ga->danger <= tss->rfa_dangerLimit) tss->rfa++;
			if (ga->danger <= tss->rfd_dangerLimit) tss->rfd++;
			tss->yaq++;
		}
		TSS_PlayerAlivePrediction(client, tss, &tss->yamq, &tss->yalq);

		if (BG_TSS_GetPlayerInfo(&client->ps, TSSPI_isValid)) {
			gr = BG_TSS_GetPlayerInfo(&client->ps, TSSPI_group);
			if (gr < 0 || gr >= MAX_GROUPS) goto NoCurrentGroup;

			ga->oldGroup = &tssGroupInfo[gr];
			ga->oldGMS = BG_TSS_GetPlayerInfo(&client->ps, TSSPI_groupMemberStatus);
			if (ga->oldGroup->oldLeader == ga) {
				switch (ga->oldGroup->mission) {
				case TSSMISSION_seek_enemy:
				case TSSMISSION_seek_items:
					ga->oldGroup->missionGoal.entitynum = ga->clientNum;
					VectorCopy(ga->client->ps.origin, ga->oldGroup->missionGoal.origin);
					ga->oldGroup->missionGoalAvailable = qtrue;
					break;
				default:
					break;
				}
				break;
			}
			ga->oldTaskGoal = BG_TSS_GetPlayerInfo(&client->ps, TSSPI_taskGoal);

			if (ga->clientNum == tss->currentLeaders[gr]) {
				ga->oldGroup->oldLeader = ga;
			}
		}
		else {
			NoCurrentGroup:
			ga->oldGroup = NULL;
			ga->oldGMS = -1;
			ga->oldTaskGoal = -1;
		}

		areaNum = BotPointAreaNum(client->ps.origin);
		if (areaNum > 0 && trap_AAS_AreaReachability(areaNum)) {
			client->tssLastValidAreaNum = areaNum;
		}
	}
	tssNumGroupAssignments = as;

	{
		int groupSizes[MAX_GROUPS];
		int assignments[MAX_GROUPS];

		for (gr = 0; gr < MAX_GROUPS; gr++) {
			groupSizes[gr] = tss->instructions.division.group[gr].minTotalMembers;
		}
		BG_TSS_AssignPlayers(
			tssNumGroupAssignments,
			&groupSizes, tss->instructions.division.unassignedPlayers,
			&assignments
		);
		for (gr = 0; gr < MAX_GROUPS; gr++) {
			tssGroupInfo[gr].minTotalPlayers = assignments[gr];
		}
	}
	for (gr = 0; gr < MAX_GROUPS; gr++) {
		gi = &tssGroupInfo[gr];

		gi->minAlivePlayers = TSS_Proportion_RoundToCeil(
			tss->instructions.division.group[gr].minAliveMembers, 100, gi->minTotalPlayers
		);
		gi->minReadyPlayers = TSS_Proportion_RoundToCeil(
			tss->instructions.division.group[gr].minReadyMembers, 100, gi->minAlivePlayers
		);
		gi->minReadyForMission = tss->instructions.orders.order[gr].minReady;
		gi->minGroupSize = tss->instructions.orders.order[gr].minGroupSize;

		if (
			tssFlagCarrier &&
			gi->mission == TSSMISSION_occupy_enemy_base &&
			gi->protectFlagCarrier
		) {
			memset(&gi->missionGoal, 0, sizeof(gi->missionGoal));
			gi->missionGoal.entitynum = tssFlagCarrier->clientNum;
			gi->missionGoal.areanum = tssFlagCarrier->client->tssLastValidAreaNum;
			VectorCopy(tssFlagCarrier->client->ps.origin, gi->missionGoal.origin);
			// JUHOX FIXME: should we initialize more fields of 'gi->missionGoal'?
			gi->missionGoalAvailable = qtrue;
		}

		tss->currentLeaders[gr] = -1;
	}

	if (tssNumPlayersAlive > 0) {
		if (g_stamina.integer) {
			tss->avgStamina /= tssNumPlayersAlive;
		}
		else {
			tss->avgStamina = 100;
		}
		tss->fightIntensity /= tssNumPlayersAlive;
	}
}

/*
===============
JUHOX: TSS_PlayerDistanceSqr
===============
*/
static vec_t TSS_PlayerDistanceSqr(const tss_groupAssignment_t* ga1, const tss_groupAssignment_t* ga2) {
	if (!ga1 || !ga2) {
		G_Error("BUG! TSS_PlayerDistanceSqr: ga1=%d, ga2=%d", (int)ga1, (int)ga2);
		return 1000000000.0;
	}
	return DistanceSquared(ga1->client->ps.origin, ga2->client->ps.origin);
}

/*
===============
JUHOX: TSS_CancelGroupAssignment
===============
*/
static void TSS_CancelGroupAssignment(tss_groupAssignment_t* ga) {
	tss_groupInfo_t* gi;

	if (!ga) {
		G_Error("BUG! TSS_CancelGroupAssignment: ga=NULL");
		return;
	}
	gi = ga->group;

	ga->group = NULL;
	ga->reservation = TSSGAR_unreserved;
	if (!gi) return;

	gi->totalPlayers--;
	if (ga->isAlive) {
		gi->alivePlayers--;
		if (ga->danger <= gi->maxDanger) {
			gi->readyPlayers--;
		}
	}
}

/*
===============
JUHOX: TSS_AssignToGroup
===============
*/
static void TSS_AssignToGroup( tss_groupAssignment_t* ga, tss_groupInfo_t* gi, tss_groupAssignmentReservation_t reservation ) {
	if (!ga || !gi) {
		G_Error("BUG! TSS_AssignToGroup: ga=%d, gi=%d", (int)ga, (int)gi);
		return;
	}

	gi->totalPlayers++;
	if (ga->isAlive) {
		gi->alivePlayers++;
		if (ga->danger <= gi->maxDanger) {
			gi->readyPlayers++;
		}
	}

	if (ga->reservation < reservation) {
		ga->reservation = reservation;
	}
	ga->group = gi;
}

/*
===============
JUHOX: TSS_CanReserveGroupAssignment
===============
*/
static qboolean TSS_CanReserveGroupAssignment( tss_groupAssignment_t* ga, tss_groupInfo_t* gi, tss_groupAssignmentReservation_t reservation ) {
	if (!ga || !gi) {
		G_Error("BUG! TSS_CanReserveGroupAssignment: ga=%d, gi=%d", (int)ga, (int)gi);
		return qfalse;
	}
	if (gi->mission <= TSSMISSION_invalid) return qfalse;
	if (!ga->group) return qtrue;
	if (ga->group == gi) return qtrue;

	if (ga->reservation > reservation) return qfalse;

	if (ga->reservation == reservation) {
		if (ga->group->rank <= gi->rank) return qfalse;
	}

	if ( ga->group->rank <= gi->rank &&	reservation <= TSSGAR_constraint &&
		( ga->group->totalPlayers <= ga->group->minTotalPlayers ||
        (ga->isAlive && ga->group->alivePlayers <= ga->group->minAlivePlayers) ||
		(ga->danger <= ga->group->maxDanger && ga->group->readyPlayers <= ga->group->minReadyPlayers) )
	) {
		ga->reservation = TSSGAR_constraint;
		return qfalse;
	}
	return qtrue;
}

/*
===============
JUHOX: TSS_MoveToGroupIfPossible
===============
*/
static qboolean TSS_MoveToGroupIfPossible( tss_groupAssignment_t* ga, tss_groupInfo_t* gi, tss_groupAssignmentReservation_t reservation ) {
	if (!ga || !gi) {
		G_Error("BUG! TSS_MoveToGroupIfPossible: ga=%d, gi=%d", (int)ga, (int)gi);
		return qfalse;
	}

	if (ga->group == gi) {
		if (ga->reservation < reservation) {
			ga->reservation = reservation;
		}
		return qtrue;
	}

	if (!TSS_CanReserveGroupAssignment(ga, gi, reservation)) return qfalse;

	TSS_CancelGroupAssignment(ga);
	TSS_AssignToGroup(ga, gi, reservation);
	return qtrue;
}

/*
===============
JUHOX: TSS_ApplyDistanceBonus
===============
*/
static vec_t TSS_ApplyDistanceBonus(vec_t dist, vec_t factor, vec_t offset) {
	if (dist > 0) {
        dist *= factor;
    } else {
        dist /= factor;
    }

	dist -= offset;
	return dist;
}

/*
===============
JUHOX: TSS_AdjustedGoalDistance
===============
*/
static int tssGoalDistanceCache[MAX_GROUPS][MAX_CLIENTS];
static vec_t TSS_AdjustedGoalDistance(const tss_groupAssignment_t* ga, const tss_groupInfo_t* gi) {
	vec_t dist;

	if (!ga || !gi) {
		G_Error("BUG! TSS_AdjustedGoalDistance: ga=%d, gi=%d", (int)ga, (int)gi);
		return 1000000000.0f;
	}

	if (!ga->isAlive) {
		dist = 0.0f;	// if dead players are accepted, prefer them
	}
	else if (ga == tssFlagCarrier) {
		if (gi->mission == TSSMISSION_capture_enemy_flag) {
			dist = 100000.0f;
			if (
				gi->oldLeader &&
				gi->oldLeader->client->tssLastValidAreaNum > 0 &&
				ga->client->tssLastValidAreaNum > 0
			) {
				dist = trap_AAS_AreaTravelTimeToGoalArea(
					ga->client->tssLastValidAreaNum, ga->client->ps.origin,
					gi->oldLeader->client->tssLastValidAreaNum, TFL_DEFAULT
				);
				if (dist <= 0) dist = 100000.0f;
			}
		}
		else {
			dist = 100000000.0f;
		}
	}
	else if (gi->missionGoalAvailable) {
		dist = tssGoalDistanceCache[gi->groupNum][ga->clientNum];
		if (dist < 0) {
			if (ga->client->tssLastValidAreaNum > 0) {
				dist = trap_AAS_AreaTravelTimeToGoalArea(
					ga->client->tssLastValidAreaNum, ga->client->ps.origin,
					gi->missionGoal.areanum, TFL_DEFAULT
				);
			}
			else {
				dist = 1000000.0f;
			}
			tssGoalDistanceCache[gi->groupNum][ga->clientNum] = dist;
		}
	}
	else {
		dist = 1000000.0f;
		dist += ga->danger;	// hint for leader determination
		if (ga->group) dist -= 2000.0f * ga->group->rank;	// hint for constraint based assignment
	}

	if (ga->danger <= gi->maxDanger) {
		if (
			ga->oldGroup &&
			ga->danger > ga->oldGroup->maxDanger &&
			gi->mission == TSSMISSION_seek_items
		) {
			if (gi->missionGoalAvailable) {
				dist = TSS_ApplyDistanceBonus(dist, 0.2f, 1000.0f);
			}
			else {
				dist = 0;
			}
		}
		else {
			dist = TSS_ApplyDistanceBonus(dist, 0.9f, 200.0f);
		}
	}

	if (ga->oldGroup == gi) {
		dist = TSS_ApplyDistanceBonus(dist, 0.9f, 100.0f);
		switch (ga->oldGMS) {
		case TSSGMS_designatedLeader:
		case TSSGMS_designatedFighter:
			dist = TSS_ApplyDistanceBonus(dist, 0.7f, 500.0f);
			break;
		case TSSGMS_temporaryLeader:
			dist = TSS_ApplyDistanceBonus(dist, 0.9f, 200.0f);
			break;
		default:
			break;
		}

		if (ga->client->tssCoOperatingWithGroupLeader) {
			dist = TSS_ApplyDistanceBonus(dist, 0.9f, 100.0f);
		}
	}

	if (gi->designated1stLeader == ga->clientNum) {
		dist = TSS_ApplyDistanceBonus(dist, 0.5f, 1000.0f);
	}
	else if (gi->designated2ndLeader == ga->clientNum) {
		dist = TSS_ApplyDistanceBonus(dist, 0.6f, 750.0f);
	}
	else if (gi->designated3rdLeader == ga->clientNum) {
		dist = TSS_ApplyDistanceBonus(dist, 0.7f, 500.0f);
	}
	else if (ga->group && ga->group != gi) {
		if (ga->group->designated1stLeader == ga->clientNum) {
			dist = TSS_ApplyDistanceBonus(dist, 2.0f, -1000.0f);
		}
		else if (ga->group->designated2ndLeader == ga->clientNum) {
			dist = TSS_ApplyDistanceBonus(dist, 1.7f, -750.0f);
		}
		else if (ga->group->designated3rdLeader == ga->clientNum) {
			dist = TSS_ApplyDistanceBonus(dist, 1.4f, -500.0f);
		}
	}

	return dist;
}

/*
===============
JUHOX: TSS_DistanceBasedGroupAssignment
===============
*/
static void TSS_DistanceBasedGroupAssignment(void) {
	int as;

	for (as = 0; as < tssNumGroupAssignments; as++) {
		tss_groupAssignment_t* ga;
		int gr;
		vec_t bestDistance;
		tss_groupInfo_t* bestGroup;

		ga = &tssGroupAssignments[as];
		if (!ga->isAlive) continue;

		bestDistance = 1000000000.0;
		bestGroup = NULL;
		for (gr = 0; gr < MAX_GROUPS; gr++) {
			tss_groupInfo_t* gi;
			vec_t distance;

			gi = &tssGroupInfo[gr];
			if (gi->mission <= TSSMISSION_invalid) continue;
			if (
				ga->danger > gi->maxDanger &&
				ga->oldGroup != gi &&
				ga != tssFlagCarrier
			) {
				continue;
			}

			distance = TSS_AdjustedGoalDistance(ga, gi);
			if (distance < bestDistance) {
				bestDistance = distance;
				bestGroup = gi;
			}
		}
		if (bestGroup) {
			TSS_MoveToGroupIfPossible(ga, bestGroup, TSSGAR_bestDistance);
		}
	}
}

/*
===============
JUHOX: TSS_ReserveBestPlayerForGroup
===============
*/
static qboolean TSS_ReserveBestPlayerForGroup( tss_groupInfo_t* gi, qboolean mustBeAlive, qboolean mustBeReady,	tss_groupAssignmentReservation_t reservation ) {
	int as;
	tss_groupAssignment_t* bestPlayer;
	vec_t bestDistance;

	if (!gi) {
		G_Error("BUG! TSS_ReserveBestPlayerForGroup: gi=NULL");
		return qfalse;
	}

	bestPlayer = NULL;
	bestDistance = 1000000000.0;
	for (as = 0; as < tssNumGroupAssignments; as++) {
		tss_groupAssignment_t* ga;
		vec_t dist;

		ga = &tssGroupAssignments[as];
		if (ga->group == gi) continue;
		if ((mustBeAlive || mustBeReady) && !ga->isAlive) continue;
		if (mustBeReady && ga->danger > gi->maxDanger) continue;
		if (!TSS_CanReserveGroupAssignment(ga, gi, reservation)) continue;

		dist = TSS_AdjustedGoalDistance(ga, gi);
		if (dist >= bestDistance) continue;

		bestDistance = dist;
		bestPlayer = ga;
	}
	if (!bestPlayer) return qfalse;
	return TSS_MoveToGroupIfPossible(bestPlayer, gi, reservation);
}

/*
===============
JUHOX: TSS_ConstraintBasedGroupAssignment
===============
*/
static void TSS_ConstraintBasedGroupAssignment(tss_serverdata_t* tss) {
	int gr;
	tss_groupInfo_t* captureGroup;
	int playersCapturing;
	tss_groupInfo_t* defendGroup;
	int playersDefending;

	captureGroup = NULL;
	playersCapturing = 0;
	defendGroup = NULL;
	playersDefending = 0;

	for (gr = 0; gr < MAX_GROUPS; gr++) {
		tss_groupInfo_t* gi;

		gi = &tssGroupInfo[tss->instructions.groupOrganization[gr]];
		if (gi->mission <= TSSMISSION_invalid) continue;

		while (gi->readyPlayers < gi->minReadyPlayers) {
			if (!TSS_ReserveBestPlayerForGroup(gi, qtrue, qtrue, TSSGAR_constraint)) break;
		}

		while (gi->alivePlayers < gi->minAlivePlayers) {
			if (!TSS_ReserveBestPlayerForGroup(gi, qtrue, qfalse, TSSGAR_constraint)) break;
		}

		while (gi->totalPlayers < gi->minTotalPlayers) {
			if (!TSS_ReserveBestPlayerForGroup(gi, qfalse, qfalse, TSSGAR_constraint)) break;
		}

		if (gi->mission == TSSMISSION_capture_enemy_flag) {
			playersCapturing += gi->totalPlayers;
			if (
				!captureGroup &&
				tss->instructions.division.group[gi->groupNum].minTotalMembers > 0
			) {
				captureGroup = gi;
			}
		}
		else if (gi->mission == TSSMISSION_defend_our_flag) {
			playersDefending += gi->totalPlayers;
			if (
				!defendGroup &&
				tss->instructions.division.group[gi->groupNum].minTotalMembers > 0
			) {
				defendGroup = gi;
			}
		}
	}

	if (
		captureGroup && playersCapturing <= 0 &&
		(
			Team_GetFlagStatus(OtherTeam(tss->team)) == FLAG_ATBASE ||
			Team_GetFlagStatus(tss->team) == FLAG_ATBASE
		)
	) {
		TSS_ReserveBestPlayerForGroup(captureGroup, qfalse, qfalse, TSSGAR_force);
	}
	else if (
		defendGroup && playersDefending <= 0 &&
		Team_GetFlagStatus(OtherTeam(tss->team)) == FLAG_TAKEN &&
		Team_GetFlagStatus(tss->team) != FLAG_ATBASE
	) {
		TSS_ReserveBestPlayerForGroup(defendGroup, qfalse, qfalse, TSSGAR_force);
	}
}

/*
===============
JUHOX: TSS_DetermineLeaders
===============
*/
static void TSS_DetermineLeaders(void) {
	int as;

	for (as = 0; as < tssNumGroupAssignments; as++) {
		tss_groupAssignment_t* ga;
		vec_t dist;

		ga = &tssGroupAssignments[as];
		if (!ga->isAlive) continue;
		if (!ga->group) continue;	// should not happen
		if (ga->danger > ga->group->maxDanger) continue;
		if (ga == tssFlagCarrier) continue;

		dist = TSS_AdjustedGoalDistance(ga, ga->group);
		if (dist < ga->group->leaderDistanceToGoal) {
			ga->group->leaderDistanceToGoal = dist;
			ga->group->currentLeader = ga;
		}
	}
}

/*
===============
JUHOX: TSS_PlayersCoOperate
===============
*/
static qboolean TSS_PlayersCoOperate(const tss_groupAssignment_t* ga1, const tss_groupAssignment_t* ga2, float laxity) {
	float radius;

	if (!ga1 || !ga2) {
		G_Error("BUG! TSS_PlayersCoOperate: ga1=%d, ga2=%d", (int)ga1, (int)ga2);
		return qfalse;
	}

	radius = 500 * (1 + laxity);
	return TSS_PlayerDistanceSqr(ga1, ga2) < radius * radius;
}

/*
==================
JUHOX: TSS_CreateRescueSchedule
==================
*/
typedef struct {
	int numAssignments;
	struct {
		tss_groupAssignment_t* guard;
		tss_groupAssignment_t* victim;
	} assignments[MAX_CLIENTS];
} tss_rescueSchedule_t;
static tss_rescueSchedule_t tssRescueSchedule;
typedef struct {
	int usecnt;
	tss_groupAssignment_t* player;
	vec3_t origin;
	int areanum;
	int maxGuards;
} tss_rescuePlayerInfo_t;
static void TSS_CreateRescueSchedule(void) {
	int as;
	tss_groupAssignment_t* ga;
	int numVictims, numActiveVictims;
	int numGuards, numActiveGuards;
	tss_rescuePlayerInfo_t victims[MAX_CLIENTS];
	tss_rescuePlayerInfo_t guards[MAX_CLIENTS];
	static int travelTimeCache[MAX_CLIENTS][MAX_CLIENTS];

	numVictims = numGuards = 0;
	memset(&victims, 0, sizeof(victims));
	memset(&guards, 0, sizeof(guards));
	for (as = 0; as < tssNumGroupAssignments; as++) {
		tss_rescuePlayerInfo_t* rpi;
		int areanum;

		ga = &tssGroupAssignments[as];
		if (!ga->isAlive) continue;
		if (!ga->group) continue;	// rescue not managed by TSS
		areanum = BotPointAreaNum(ga->client->ps.origin);
		if (areanum <= 0) continue;

		if (ga->danger <= ga->group->maxDanger) {
			rpi = &guards[numGuards++];
		} else {
			rpi = &victims[numVictims++];
			if (
				ga->group->missionStatus == TSSMS_valid ||
				ga->group->protectFlagCarrier
			) {
				rpi->maxGuards = ga->group->maxGuardsPerVictim;
			}
			else {
				rpi->maxGuards = 1000;
			}
		}

		rpi->player = ga;
		rpi->areanum = areanum;
		VectorCopy(ga->client->ps.origin, rpi->origin);
	}

	tssRescueSchedule.numAssignments = 0;
	numActiveVictims = numVictims;
	numActiveGuards = numGuards;
	memset(&travelTimeCache, -1, sizeof(travelTimeCache));

	while (numActiveGuards > 0 && numActiveVictims > 0) {
		int minusecnt;
		int maxDanger;
		tss_rescuePlayerInfo_t* rpi;
		int victim;
		int guard, assignedGuard, leaderGuard;
		tss_groupAssignment_t* leader;
		int bestTravelTime;

		// find the most endangered victim of those with the least number of guards
		minusecnt = 1000000;
		maxDanger = -1000000;
		rpi = NULL;
		for (victim = 0; victim < numVictims; victim++) {
			if (!victims[victim].player) continue;
			if (victims[victim].usecnt > minusecnt) continue;
			if (victims[victim].usecnt >= victims[victim].maxGuards) {
				victims[victim].player = NULL;
				numActiveVictims--;
				continue;
			}
			if (
				victims[victim].usecnt >= minusecnt &&
				victims[victim].player->danger <= maxDanger
			) {
				continue;
			}

			minusecnt = victims[victim].usecnt;
			maxDanger = victims[victim].player->danger;
			rpi = &victims[victim];
		}

		if (!rpi) return;

		// find the nearest available guard
		bestTravelTime = 100000000;
		assignedGuard = -1;
		leaderGuard = -1;
		leader = rpi->player->group->currentLeader;
		for (guard = 0; guard < numGuards; guard++) {
			int travelTime;
			tss_rescuePlayerInfo_t* grpi;

			grpi = &guards[guard];
			if (!grpi->player) continue;
			if (
				grpi->player->group != rpi->player->group &&
				grpi->player->group->missionStatus != TSSMS_aborted
			) continue;
			if (grpi->player == leader) {
				leaderGuard = guard;
				continue;
			}

			travelTime = travelTimeCache[grpi->player->clientNum][rpi->player->clientNum];
			if (travelTime < 0) {
				travelTime = trap_AAS_AreaTravelTimeToGoalArea(grpi->areanum, grpi->origin, rpi->areanum, TFL_DEFAULT);
				if (travelTime < 0) travelTime = 0;
				travelTimeCache[grpi->player->clientNum][rpi->player->clientNum] = travelTime;
			}
			if (travelTime <= 0) continue;
			if (travelTime >= bestTravelTime) continue;

			bestTravelTime = travelTime;
			assignedGuard = guard;
		}

		if (assignedGuard < 0) {
			assignedGuard = leaderGuard;
		}

		if (assignedGuard < 0) {
			rpi->player = NULL;
			numActiveVictims--;
			continue;
		}

		tssRescueSchedule.assignments[tssRescueSchedule.numAssignments].guard = guards[assignedGuard].player;
		tssRescueSchedule.assignments[tssRescueSchedule.numAssignments].victim = rpi->player;
		tssRescueSchedule.numAssignments++;

		rpi->usecnt++;

		guards[assignedGuard].player = NULL;
		numActiveGuards--;
	}
}

/*
==================
JUHOX: TSS_RescueTeamMate
==================
*/
static tss_groupAssignment_t* TSS_RescueTeamMate(const tss_groupAssignment_t* ga) {
	int as;

	if (!ga) {
		G_Error("BUG! TSS_RescueTeamMate: ga=NULL");
		return NULL;
	}

	for (as = 0; as < tssRescueSchedule.numAssignments; as++) {
		if (tssRescueSchedule.assignments[as].guard != ga) continue;

		return tssRescueSchedule.assignments[as].victim;
	}

	return NULL;
}

/*
===============
JUHOX: TSS_GroupSize
===============
*/
static int TSS_GroupSize(const tss_groupInfo_t* gi) {
	int as;
	int size;
	float formationLaxity;

	if (!gi) {
		G_Error("BUG! TSS_GroupSize: gi=NULL");
		return 0;
	}

	switch (gi->groupFormation) {
	case TSSGF_tight:
	default:
		formationLaxity = 0.0f;
		break;
	case TSSGF_loose:
		formationLaxity = 1.0f;
		break;
	case TSSGF_free:
		formationLaxity = 2.0f;
		break;
	}

	size = 0;
	for (as = 0; as < tssNumGroupAssignments; as++) {
		tss_groupAssignment_t* ga;
		qboolean coOperation;

		ga = &tssGroupAssignments[as];
		if (ga->group != gi) continue;

		coOperation = ga->client->tssCoOperatingWithGroupLeader;
		ga->client->tssCoOperatingWithGroupLeader = qfalse;
		if (!ga->isAlive) continue;
		if (ga->danger > gi->maxDanger) continue;
		if (!gi->currentLeader) continue;
		if (
			ga != gi->currentLeader &&
			!TSS_PlayersCoOperate(ga, gi->currentLeader, formationLaxity + (coOperation? 0.5f : -0.3f))
		) {
			continue;
		}

		ga->client->tssCoOperatingWithGroupLeader = qtrue;
		size++;
	}

	return size;
}

/*
===============
JUHOX: TSS_DetermineMissionStatus
===============
*/
static void TSS_DetermineMissionStatus(tss_serverdata_t* tss) {
	int gr;
	tss_groupInfo_t* gi;

	for (gr = 0; gr < MAX_GROUPS; gr++) {
		tss_missionStatus_t oldMS;
		qboolean oldPFC;
		int groupSize;

		gi = &tssGroupInfo[gr];

		oldMS = gi->missionStatus;
		oldPFC = gi->protectFlagCarrier;
		gi->missionStatus = TSSMS_valid;
		gi->protectFlagCarrier = qfalse;

		groupSize = TSS_GroupSize(gi);	// also sets gclient_t::tssCoOperatingWithGroupLeader
		tss->tidiness += 100 * groupSize;

		if (!gi->currentLeader) {
			gi->groupFormation = TSSGF_free;
		}

		if (
			tssFlagCarrier &&
			(
				gi == tssFlagCarrier->group ||
				gi->mission == TSSMISSION_capture_enemy_flag
			)
		) {
			gi->protectFlagCarrier = qtrue;
			if (
				gi->mission != TSSMISSION_capture_enemy_flag &&
				tssFlagCarrier->reservation < TSSGAR_force
			) {
				gi->missionStatus = TSSMS_aborted;
			}
		}

		else if ( !gi->currentLeader ||	gi->readyPlayers < TSS_Proportion_RoundToCeil(gi->minReadyForMission, 100, gi->alivePlayers) ||
                ( gi->groupFormation == TSSGF_tight && groupSize < TSS_Proportion_RoundToCeil(gi->minGroupSize, 100, gi->alivePlayers) ) ) {
                    gi->missionStatus = TSSMS_aborted;
		}
		else if ( tssFlagCarrier &&	tssFlagCarrier->group && gi->mission == TSSMISSION_occupy_enemy_base &&
                ( !tssFlagCarrier->group->currentLeader || ( !TSS_PlayersCoOperate ( tssFlagCarrier, tssFlagCarrier->group->currentLeader, oldPFC? -0.3f : 0.3f ) &&
                ( TSS_PlayerDistanceSqr(tssFlagCarrier, gi->currentLeader) < TSS_PlayerDistanceSqr(tssFlagCarrier, tssFlagCarrier->group->currentLeader) + (oldPFC? 300.0f : 0.0f) ) ) )
                && NearHomeBase( OtherTeam(tss->team), tssFlagCarrier->client->ps.origin, oldPFC? 4.0f : 9.0f )	) {
                    gi->missionStatus = TSSMS_aborted;
                    gi->protectFlagCarrier = qtrue;
		}

		tss->missionStatus[gr] = gi->missionStatus;
		tss->protectFlagCarrier[gr] = gi->protectFlagCarrier;
		tss->currentLeaders[gr] = gi->currentLeader? gi->currentLeader->clientNum : -1;
	}

	if (tssNumPlayersAlive > 0) {
		tss->tidiness /= tssNumPlayersAlive;
	}
}

/*
===============
JUHOX: TSS_AssignTask
===============
*/
static tss_missionTask_t TSS_AssignTask( const tss_groupAssignment_t* ga, tss_groupMemberStatus_t gms, tss_groupFormation_t formation, int leader, int* taskGoal ) {
	tss_groupAssignment_t* teammate;

	*taskGoal = -1;
	if (!ga) {
		G_Error("BUG! TSS_AssignTask: ga=NULL");
		return -1;
	}
	if (!ga->group) return -1;

	if (gms == TSSGMS_retreating) {
		return TSSMT_retreat;
	}

	if (tssFlagCarrier && tssHomeBase && tssFlagCarrier->reservation < TSSGAR_force) {
		tss_missionTask_t oldTask;

		if (BG_TSS_GetPlayerInfo(&ga->client->ps, TSSPI_isValid)) {
			oldTask = BG_TSS_GetPlayerInfo(&ga->client->ps, TSSPI_task);
		}
		else {
			oldTask = -1;
		}

		if (ga == tssFlagCarrier) {
			if (!ga->group->currentLeader) {
				return TSSMT_rushToBase;
			}
			else if (
				!ga->isFighting &&
				TSS_PlayersCoOperate(
					ga, ga->group->currentLeader,
					oldTask == TSSMT_rushToBase? -0.3f : 0.3f
				) &&

				DistanceSquared(ga->client->ps.origin, tssHomeBase->origin) > Square(800.0f)
			) {
				*taskGoal = leader;
				return TSSMT_stickToGroupLeader;
			}
			else {
				return TSSMT_rushToBase;
			}
		}
		else if (ga == tssFlagCarrier->group->currentLeader) {
			if (
				tssFlagCarrier->danger > ga->group->maxDanger ||
				DistanceSquared(ga->client->ps.origin, tssHomeBase->origin) < Square(400.0f)
			) {
				*taskGoal = tssFlagCarrier->clientNum;
				return TSSMT_guardFlagCarrier;
			}
			else if (TSS_PlayersCoOperate(ga, tssFlagCarrier, oldTask == TSSMT_rushToBase? 0.3f : -0.3f)) {
				*taskGoal = tssFlagCarrier->clientNum;
				return TSSMT_rushToBase;
			}
			else {
				*taskGoal = tssFlagCarrier->clientNum;
				return TSSMT_seekGroupMember;
			}
		}
		else if (
			ga->group == tssFlagCarrier->group ||
			ga->group->protectFlagCarrier ||
			ga->group->mission == TSSMISSION_capture_enemy_flag
		) {
			if (TSS_PlayersCoOperate(ga, tssFlagCarrier, oldTask == TSSMT_guardFlagCarrier? 0.5f : -0.3f)) {
				*taskGoal = tssFlagCarrier->clientNum;
				return TSSMT_guardFlagCarrier;
			}
			else {
				*taskGoal = tssFlagCarrier->clientNum;
				return TSSMT_seekGroupMember;
			}
		}
	}

	teammate = TSS_RescueTeamMate(ga);
	if (teammate) {
		*taskGoal = teammate->clientNum;
		return TSSMT_helpTeamMate;
	}

	if (
		gms == TSSGMS_designatedLeader ||
		gms == TSSGMS_temporaryLeader ||
		(
			formation == TSSGF_free &&
			ga->group->missionStatus != TSSMS_aborted
		)
	) {
		if (
			ga->group->mission == TSSMISSION_seek_enemy &&
			ga->group->missionStatus != TSSMS_aborted &&
			!IsPlayerInvolvedInFighting(ga->clientNum)
		) {
			int as;
			int bestDist;
			const tss_groupAssignment_t* nearestFighter;

			bestDist = 1000000;
			nearestFighter = NULL;
			for (as = 0; as < tssNumGroupAssignments; as++) {
				const tss_groupAssignment_t* other;

				other = &tssGroupAssignments[as];
				if (other == ga) continue;

				if (
					other->isAlive &&
					IsPlayerInvolvedInFighting(other->clientNum) &&
					(
						other->group != ga->group ||
						!TSS_PlayersCoOperate(ga, other, -0.3f)
					)
				) {
					int dist;

					dist = trap_AAS_AreaTravelTimeToGoalArea(
						ga->client->tssLastValidAreaNum, ga->client->ps.origin,
						other->client->tssLastValidAreaNum, TFL_DEFAULT
					);
					if (ga->oldTaskGoal == other->clientNum) dist -= 300;
					if (dist < bestDist) {
						bestDist = dist;
						nearestFighter = other;
					}
				}
			}
			if (nearestFighter) {
				*taskGoal = nearestFighter->clientNum;
				return TSSMT_seekEnemyNearTeamMate;
			}
		}

		if (ga->group->missionStatus == TSSMS_aborted) {
			int as;
			int nearestDist;
			const tss_groupAssignment_t* nearestTeammate;

			nearestDist = 1000000;
			nearestTeammate = NULL;
			for (as = 0; as < tssNumGroupAssignments; as++) {
				const tss_groupAssignment_t* other;
				int dist;

				other = &tssGroupAssignments[as];
				if (!other->isAlive) continue;
				if (other->group != ga->group) continue;
				if (TSS_PlayersCoOperate(ga, other, 0.0f)) {
					nearestTeammate = NULL;
					break;
				}
				dist = trap_AAS_AreaTravelTimeToGoalArea(
					ga->client->tssLastValidAreaNum, ga->client->ps.origin,
					other->client->tssLastValidAreaNum, TFL_DEFAULT
				);
				if (dist >= nearestDist) continue;

				nearestDist = dist;
				nearestTeammate = other;
			}

			if (nearestTeammate) {
				*taskGoal = nearestTeammate->clientNum;
				return TSSMT_seekGroupMember;
			}
			return TSSMT_prepareForMission;
		}

		return TSSMT_fulfilMission;
	}

	*taskGoal = leader;
	if (formation == TSSGF_tight) return TSSMT_stickToGroupLeader;
	return TSSMT_followGroupLeader;
}

/*
===============
JUHOX: TSS_SuggestedGroupFormation
===============
*/
static tss_groupFormation_t TSS_SuggestedGroupFormation(const tss_groupAssignment_t* ga) {
	tss_groupFormation_t gf;
	int team;

	if (!ga) {
		G_Error("BUG! TSS_SuggestedGroupFormation: ga=NULL");
		return TSSGF_tight;
	}
	if (!ga->group) return TSSGF_tight;

	if (ga->group->missionStatus == TSSMS_aborted) return TSSGF_tight;

	gf = TSSGF_tight;
	team = ga->client->ps.persistant[PERS_TEAM];

	switch (ga->group->mission) {
	case TSSMISSION_seek_enemy:
		if (IsPlayerInvolvedInFighting(ga->clientNum)) {
			gf = TSSGF_free;
		}
		break;
	case TSSMISSION_seek_items:
		if (IsPlayerInvolvedInFighting(ga->clientNum)) {
			gf = TSSGF_loose;	// allow greater NGB range
		}
		break;
	case TSSMISSION_defend_our_base:
		gf = TSSGF_loose;
		break;
	case TSSMISSION_occupy_enemy_base:
		if (
			Team_GetFlagStatus(team) != FLAG_ATBASE &&
			Team_GetFlagStatus(OtherTeam(team)) != FLAG_TAKEN
		) {
			gf = TSSGF_free;
		}
		else if (NearHomeBase(OtherTeam(team), ga->client->ps.origin, 9)) {
			gf = TSSGF_loose;
		}
		else {
			gf = TSSGF_tight;
		}
		break;
	case TSSMISSION_capture_enemy_flag:
		switch (Team_GetFlagStatus(OtherTeam(team))) {
		case FLAG_TAKEN:
		default:
			gf = TSSGF_tight;
			break;
		case FLAG_DROPPED:
			gf = TSSGF_free;
			break;
		case FLAG_ATBASE:
			if (
				NearHomeBase(OtherTeam(team), ga->client->ps.origin, 9) ||
				Team_GetFlagStatus(team) != FLAG_ATBASE
			) {
				gf = TSSGF_free;
			}
			else {
				gf = TSSGF_tight;
			}
			break;
		}
		break;
	case TSSMISSION_defend_our_flag:
		switch (Team_GetFlagStatus(team)) {
		case FLAG_ATBASE:
			gf = TSSGF_loose;
			if (!NearHomeBase(team, ga->client->ps.origin, 1)) {
				gf = TSSGF_free;
			}
			break;
		case FLAG_DROPPED:
			gf = TSSGF_free;
			break;
		case FLAG_TAKEN:
		default:
			gf = TSSGF_tight;
			if (Team_GetFlagStatus(OtherTeam(team)) != FLAG_TAKEN) {
				gf = TSSGF_free;
			}
			else if (IsPlayerFighting(ga->clientNum)) {
				gf = TSSGF_free;
			}
			break;
		}
		break;
	default:
		break;
	}

	return gf;
}

/*
===============
JUHOX: TSS_GroupAssignment
===============
*/
static void TSS_GroupAssignment(tss_serverdata_t* tss) {
	int as;
	tss_groupAssignment_t* ga;

	if (!tss->isValid) {
		int i;

		for (i = 0; i < level.maxclients; i++) {
			gentity_t* ent;
			gclient_t* cl;

			ent = &g_entities[i];
			if (!ent->inuse) continue;
			cl = ent->client;
			if (!cl) continue;
			if (cl->pers.connected != CON_CONNECTED) continue;
			if (cl->sess.sessionTeam != tss->team) continue;

			BG_TSS_SetPlayerInfo(&cl->ps, TSSPI_isValid, qfalse);
		}
		return;
	}

	TSS_InitGroupAssignments(tss);
	if (tssNumGroupAssignments <= 0) return;



	memset(tssGoalDistanceCache, -1, sizeof(tssGoalDistanceCache));

	TSS_DistanceBasedGroupAssignment();



	if (g_gametype.integer == GT_CTF && tssFlagCarrier) {
		if ( tssFlagCarrier->group && tssFlagCarrier->group->mission == TSSMISSION_capture_enemy_flag) {
			TSS_MoveToGroupIfPossible(tssFlagCarrier, tssFlagCarrier->group, TSSGAR_flagCarrier);
		}
	}

	TSS_ConstraintBasedGroupAssignment(tss);
	TSS_DetermineLeaders();
	TSS_DetermineMissionStatus(tss);
	TSS_CreateRescueSchedule();

	for (as = 0; as < tssNumGroupAssignments; as++) {
		playerState_t* ps;
		entityState_t* es;

		ga = &tssGroupAssignments[as];
		ps = &ga->client->ps;
		es = &g_entities[ga->clientNum].s;

		if (ga->group) {
			tss_groupMemberStatus_t gms;
			int leader;
			tss_groupFormation_t groupFormation;
			tss_missionTask_t task;
			int taskGoal;

			BG_TSS_SetPlayerInfo(ps, TSSPI_group, ga->group->groupNum);

			if (ga->group->currentLeader == ga) {
				if (
					ga->clientNum == ga->group->designated1stLeader ||
					ga->clientNum == ga->group->designated2ndLeader ||
					ga->clientNum == ga->group->designated3rdLeader
				) {
					gms = TSSGMS_designatedLeader;
				}
				else {
					gms = TSSGMS_temporaryLeader;
				}
			}
			else if (ga->isAlive && ga->danger <= ga->group->maxDanger) {
				gms = TSSGMS_temporaryFighter;
			}
			else {
				gms = TSSGMS_retreating;
			}
			BG_TSS_SetPlayerInfo(ps, TSSPI_groupMemberStatus, gms);

			BG_TSS_SetPlayerInfo(ps, TSSPI_groupSize, ga->group->totalPlayers);
			BG_TSS_SetPlayerInfo(ps, TSSPI_membersAlive, ga->group->alivePlayers);
			BG_TSS_SetPlayerInfo(ps, TSSPI_membersReady, ga->group->readyPlayers);

			leader = (ga->group->currentLeader? ga->group->currentLeader->clientNum : ga->clientNum);
			BG_TSS_SetPlayerInfo(ps, TSSPI_groupLeader, leader);

			BG_TSS_SetPlayerInfo(ps, TSSPI_mission, tss->instructions.orders.order[ga->group->groupNum].mission);

			BG_TSS_SetPlayerInfo(ps, TSSPI_missionStatus, ga->group->missionStatus);

			groupFormation = ga->group->groupFormation;
			switch (groupFormation) {
			case TSSGF_tight:
			case TSSGF_loose:
			case TSSGF_free:
				break;
			default:
				groupFormation = TSSGF_tight;
				break;
			}
			BG_TSS_SetPlayerInfo(ps, TSSPI_groupFormation, groupFormation);

			task = TSS_AssignTask(ga, gms, groupFormation, leader, &taskGoal);
			BG_TSS_SetPlayerInfo(ps, TSSPI_task, task);
			if (taskGoal < 0) taskGoal = ga->clientNum;
			BG_TSS_SetPlayerInfo(ps, TSSPI_taskGoal, taskGoal);

			groupFormation = TSS_SuggestedGroupFormation(ga);
			BG_TSS_SetPlayerInfo(ps, TSSPI_suggestedGF, groupFormation);

			BG_TSS_SetPlayerInfo(ps, TSSPI_isValid, qtrue);
		}
		else {
			BG_TSS_SetPlayerInfo(ps, TSSPI_isValid, qfalse);
		}
	}
}

/*
===============
JUHOX: TSS_SendTeamStatus
===============
*/
static void TSS_SendTeamStatus(tss_serverdata_t* tss) {
	char argbuf[256];
	int cl;
	int bits;
	int i;

	if (!tss->missionLeader) return;

	i = 0;
	bits = 0;
	for (cl = 0; cl < MAX_CLIENTS; cl++) {
		gclient_t* client;

		client = level.clients + cl;
		if (
			g_entities[cl].inuse &&
			client->pers.connected == CON_CONNECTED &&
			client->ps.stats[STAT_HEALTH] > 0
		) {
			bits |= 1 << (cl & 3);
		}

		if ((cl & 3) == 3) {
			argbuf[i++] = 'A' + bits;
			bits = 0;
		}
	}
	argbuf[i++] = 0;

	if (tssHomeBase && tssEnemyBase) {
		float distToHome;
		float distToEnemy;
		bot_goal_t flag;

		if (LocateFlag(tss->team, &flag)) {
			distToHome = Distance(flag.origin, tssHomeBase->origin);
			distToEnemy = Distance(flag.origin, tssEnemyBase->origin);

			tss->yfp = 200 * distToEnemy / (distToEnemy + distToHome) - 100;
		}
		if (LocateFlag(OtherTeam(tss->team), &flag)) {
			distToHome = Distance(flag.origin, tssHomeBase->origin);
			distToEnemy = Distance(flag.origin, tssEnemyBase->origin);

			tss->ofp = 200 * distToEnemy / (distToEnemy + distToHome) - 100;
		}
	}

	trap_SendServerCommand(
		tss->missionLeader->ps.clientNum,
		va(
			"tssupdate %s %d %d %d %d %d %d %d %d %f %f %f %f"
			" %d %d %d %d"	// A
			" %d %d %d %d"	// B
			" %d %d %d %d"	// C
			" %d %d %d %d"	// D
			" %d %d %d %d"	// E
			" %d %d %d %d"	// F
			" %d %d %d %d"	// G
			" %d %d %d %d"	// H
			" %d %d %d %d"	// I
			" %d %d %d %d"	// J
			,
			argbuf,
			tss->yfp,
			tss->ofp,
			tss->tidiness,
			tss->avgStamina,
			tss->fightIntensity,
			g_respawnDelay.integer,
			tss->rfa,
			tss->rfd,
			tss->yamq, tss->yalq,
			tss->oamq, tss->oalq,
			tss->currentLeaders[0], tssGroupInfo[0].totalPlayers, tssGroupInfo[0].alivePlayers, tssGroupInfo[0].readyPlayers,
			tss->currentLeaders[1], tssGroupInfo[1].totalPlayers, tssGroupInfo[1].alivePlayers, tssGroupInfo[1].readyPlayers,
			tss->currentLeaders[2], tssGroupInfo[2].totalPlayers, tssGroupInfo[2].alivePlayers, tssGroupInfo[2].readyPlayers,
			tss->currentLeaders[3], tssGroupInfo[3].totalPlayers, tssGroupInfo[3].alivePlayers, tssGroupInfo[3].readyPlayers,
			tss->currentLeaders[4], tssGroupInfo[4].totalPlayers, tssGroupInfo[4].alivePlayers, tssGroupInfo[4].readyPlayers,
			tss->currentLeaders[5], tssGroupInfo[5].totalPlayers, tssGroupInfo[5].alivePlayers, tssGroupInfo[5].readyPlayers,
			tss->currentLeaders[6], tssGroupInfo[6].totalPlayers, tssGroupInfo[6].alivePlayers, tssGroupInfo[6].readyPlayers,
			tss->currentLeaders[7], tssGroupInfo[7].totalPlayers, tssGroupInfo[7].alivePlayers, tssGroupInfo[7].readyPlayers,
			tss->currentLeaders[8], tssGroupInfo[8].totalPlayers, tssGroupInfo[8].alivePlayers, tssGroupInfo[8].readyPlayers,
			tss->currentLeaders[9], tssGroupInfo[9].totalPlayers, tssGroupInfo[9].alivePlayers, tssGroupInfo[9].readyPlayers
		)
	);
}

/*
===============
JUHOX: TSS_Run
===============
*/
void TSS_Run(void) {
	tss_serverdata_t* tss;

	if (g_gametype.integer < GT_TEAM) return;
	// JUHOX: no TSS with STU
	if (g_gametype.integer >= GT_STU) return;

	if (level.time < level.tssTime) return;
	level.tssTime = level.time + 500;

	tssHomeBase = NULL;
	tssEnemyBase = NULL;
	switch (level.tssNextTeam) {
	case 0:
	default:
		tss = &level.redTSS;
		tss->team = TEAM_RED;
		if (g_gametype.integer == GT_CTF) {
			tssHomeBase = &ctf_redflag;
			tssEnemyBase = &ctf_blueflag;
		}
		level.tssNextTeam = 1;
		break;
	case 1:
		tss = &level.blueTSS;
		tss->team = TEAM_BLUE;
		if (g_gametype.integer == GT_CTF) {
			tssHomeBase = &ctf_blueflag;
			tssEnemyBase = &ctf_redflag;
		}
		level.tssNextTeam = 0;
		break;
	}

	if (
		!g_tss.integer ||
		tss->lastUpdateTime < level.time - 15000
	) {
		tss->isValid = qfalse;
	}

	tss->missionLeader = NULL;
	tss->yfp = -999;
	tss->ofp = -999;
	tss->tidiness = 0;
	tss->avgStamina = 0;
	tss->fightIntensity = 0;
	tss->rfa = 0;
	tss->rfd = 0;
	tss->yamq = 0.0;
	tss->oamq = 0.0;
	tss->yalq = 0.0;
	tss->oalq = 0.0;
	tss->yaq = 0;
	tss->oaq = 0;
	tss->yts = 0;
	tss->ots = 0;
	TSS_GroupAssignment(tss);
	TSS_SendTeamStatus(tss);
}

/*
===============
G_DamageFeedback

Called just before a snapshot is sent to the given player.
Totals up all damage and generates both the player_state_t
damage values to that client for pain blends and kicks, and
global pain sound events for all clients.
===============
*/
void P_DamageFeedback( gentity_t *player ) {
	gclient_t	*client;
	float	count;
	vec3_t	angles;

	client = player->client;
	if ( client->ps.pm_type == PM_DEAD ) {
		return;
	}

	// total points of damage shot at the player this frame
	count = client->damage_blood + client->damage_armor;
	if ( count == 0 ) {
		return;		// didn't take any damage
	}

	if ( count > 255 ) {
		count = 255;
	}

	// send the information to the client

	// world damage (falling, slime, etc) uses a special code
	// to make the blend blob centered instead of positional
	if ( client->damage_fromWorld ) {
		client->ps.damagePitch = 255;
		client->ps.damageYaw = 255;

		client->damage_fromWorld = qfalse;
	} else {
		vectoangles( client->damage_from, angles );
		client->ps.damagePitch = angles[PITCH]/360.0 * 256;
		client->ps.damageYaw = angles[YAW]/360.0 * 256;
	}

	// play an apropriate pain sound
	if ( (level.time > player->pain_debounce_time) && !(player->flags & FL_GODMODE) ) {
		player->pain_debounce_time = level.time + 700;
		// JUHOX: scale health to 100 for pain event
		G_AddEvent(player, EV_PAIN, (100 * player->health) / client->ps.stats[STAT_MAX_HEALTH]);
		client->ps.damageEvent++;
	}

	client->ps.damageCount = count;

	//
	// clear totals
	//
	client->damage_blood = 0;
	client->damage_armor = 0;
	client->damage_knockback = 0;
}



/*
=============
P_WorldEffects

Check for lava / slime contents and drowning
=============
*/
void P_WorldEffects( gentity_t *ent ) {
	qboolean	envirosuit;
	int			waterlevel;

	if ( ent->client->noclip ) {
		ent->client->airOutTime = level.time + 12000;	// don't need air
		return;
	}

	waterlevel = ent->waterlevel;

	// JUHOX: battlesuit not used as protection
	envirosuit = qfalse;

	//
	// check for drowning
	//
	// JUHOX: also "drown" if holding breath

	if (
		waterlevel >= 3 ||
		(
			g_stamina.integer &&
			(ent->client->pers.cmd.buttons & BUTTON_HOLD_BREATH)
		)
	) {
		ent->client->ps.stats[STAT_PANT_PHASE] = -1;

		// JUHOX: new air-out condition

		if (
			g_stamina.integer &&
			ent->client->ps.stats[STAT_STRENGTH] > 0
		) {
			ent->client->airOutTime = level.time + 10000;
		}

		// if out of air, start drowning
		if ( ent->client->airOutTime < level.time) {
			// drown!
			ent->client->airOutTime += 1000;
			if ( ent->health > 0 ) {
				// take more damage the longer underwater
				ent->damage += 2;

				// play a gurp sound instead of a normal pain sound
				// JUHOX: don't play gurp sound if not in water (i.e. just holding breath)

				if (waterlevel >= 3) {
					if (ent->health <= ent->damage) {
						G_Sound(ent, CHAN_VOICE, G_SoundIndex("*drown.wav"));
					} else if (rand()&1) {
						G_Sound(ent, CHAN_VOICE, G_SoundIndex("sound/player/gurp1.wav"));
					} else {
						G_Sound(ent, CHAN_VOICE, G_SoundIndex("sound/player/gurp2.wav"));
					}
				}

				// don't play a normal pain sound
				ent->pain_debounce_time = level.time + 200;

				G_Damage (ent, NULL, NULL, NULL, NULL,
					ent->damage, DAMAGE_NO_ARMOR, MOD_WATER);
			}
		}
	} else {
		ent->client->airOutTime = level.time + 12000;
		ent->damage = 2;
	}

	//
	// check for sizzle damage (move to pmove?)
	//
	if (waterlevel &&
		(ent->watertype&(CONTENTS_LAVA|CONTENTS_SLIME)) ) {
		if (ent->health > 0
			&& ent->pain_debounce_time <= level.time	) {

			if ( envirosuit ) {
				G_AddEvent( ent, EV_POWERUP_BATTLESUIT, 0 );
			} else {
				if (ent->watertype & CONTENTS_LAVA) {
					G_Damage (ent, NULL, NULL, NULL, NULL,
						30*waterlevel, 0, MOD_LAVA);
				}

				if (ent->watertype & CONTENTS_SLIME) {
					G_Damage (ent, NULL, NULL, NULL, NULL,
						10*waterlevel, 0, MOD_SLIME);
				}
			}
		}
	}
}



/*
===============
G_SetClientSound
===============
*/
void G_SetClientSound( gentity_t *ent ) {
	if (ent->waterlevel && (ent->watertype&(CONTENTS_LAVA|CONTENTS_SLIME)) ) {
		ent->client->ps.loopSound = level.snd_fry;
	} else {
		ent->client->ps.loopSound = 0;
	}
}



//==============================================================

/*
==============
ClientImpacts
==============
*/
void ClientImpacts( gentity_t *ent, pmove_t *pm ) {
	int		i, j;
	trace_t	trace;
	gentity_t	*other;

	memset( &trace, 0, sizeof( trace ) );
	for (i=0 ; i<pm->numtouch ; i++) {
		for (j=0 ; j<i ; j++) {
			if (pm->touchents[j] == pm->touchents[i] ) {
				break;
			}
		}
		if (j != i) {
			continue;	// duplicated
		}
		other = &g_entities[ pm->touchents[i] ];

		if ( ( ent->r.svFlags & SVF_BOT ) && ( ent->touch ) ) {
			ent->touch( ent, other, &trace );
		}

		if ( !other->touch ) {
			continue;
		}

		other->touch( other, ent, &trace );
	}

	// JUHOX: let monsters detect touching players
	CheckTouchedMonsters(pm);
}

/*
============
G_TouchTriggers

Find all trigger entities that ent's current position touches.
Spectators will only interact with teleporters.
============
*/
void G_TouchTriggers( gentity_t *ent ) {
	int			i, num;
	int			touch[MAX_GENTITIES];
	gentity_t	*hit;
	trace_t		trace;
	vec3_t		mins, maxs;
	static vec3_t	range = { 40, 40, 52 };

	if ( !ent->client ) {
		return;
	}

	// JUHOX: never touch triggers in lens flare editor
	if (g_editmode.integer == EM_mlf) return;

	// dead clients don't activate triggers!
	if ( ent->client->ps.stats[STAT_HEALTH] <= 0 &&	ent->client->ps.pm_type != PM_SPECTATOR ) return;

	VectorSubtract( ent->client->ps.origin, range, mins );
	VectorAdd( ent->client->ps.origin, range, maxs );

	num = trap_EntitiesInBox( mins, maxs, touch, MAX_GENTITIES );

	// can't use ent->absmin, because that has a one unit pad
	VectorAdd( ent->client->ps.origin, ent->r.mins, mins );
	VectorAdd( ent->client->ps.origin, ent->r.maxs, maxs );

	for ( i=0 ; i<num ; i++ ) {
		hit = &g_entities[touch[i]];

		if ( !hit->touch && !ent->touch ) continue;
		if ( !( hit->r.contents & CONTENTS_TRIGGER ) ) continue;

		// ignore most entities if a spectator
		if (ent->client->ps.pm_type == PM_SPECTATOR) {

			if ( hit->s.eType != ET_TELEPORT_TRIGGER &&
				// this is ugly but adding a new ET_? type will
				// most likely cause network incompatibilities
				hit->touch != Touch_DoorTrigger) {
				continue;
			}
		}

		// use seperate code for determining if an item is picked up
		// so you don't have to actually contact its bounding box
		if ( hit->s.eType == ET_ITEM ) {
			if ( !BG_PlayerTouchesItem( &ent->client->ps, &hit->s, level.time ) ) {
				continue;
			}
		} else {
			if ( !trap_EntityContact( mins, maxs, hit ) ) {
				continue;
			}
		}

		memset( &trace, 0, sizeof(trace) );

		if ( hit->touch ) {
			hit->touch (hit, ent, &trace);
		}

		if ( ( ent->r.svFlags & SVF_BOT ) && ( ent->touch ) ) {
			ent->touch( ent, hit, &trace );
		}
	}

	// if we didn't touch a jump pad this pmove frame
	if ( ent->client->ps.jumppad_frame != ent->client->ps.pmove_framecount ) {
		ent->client->ps.jumppad_frame = 0;
		ent->client->ps.jumppad_ent = 0;
	}
}

/*
=================
SpectatorThink
=================
*/
void SpectatorThink( gentity_t *ent, usercmd_t *ucmd ) {
	pmove_t	pm;
	gclient_t	*client;

	client = ent->client;

	if ( client->sess.spectatorState != SPECTATOR_FOLLOW ) {
		client->ps.pm_type = PM_SPECTATOR;
		client->ps.speed = 400;	// faster than normal

		// set up for pmove
		memset (&pm, 0, sizeof(pm));
		pm.ps = &client->ps;
		pm.cmd = *ucmd;
		pm.tracemask = MASK_PLAYERSOLID & ~CONTENTS_BODY;	// spectators can fly through bodies
		pm.trace = trap_Trace;
		pm.pointcontents = trap_PointContents;

        // JUHOX: set player scale factor for spectator
		pm.scale = 1;

		pm.gametype = g_gametype.integer;	// JUHOX

        // JUHOX: set player tracemask & speed for lens flare editor
		if (g_editmode.integer == EM_mlf) {
			pm.tracemask = 0;
			if (level.lfeFMM) {
				client->ps.speed = 30;
				if (pm.cmd.buttons & BUTTON_WALKING) client->ps.speed = 15;
			}
			if (pm.cmd.buttons & BUTTON_ATTACK) {
				pm.cmd.forwardmove = 0;
				pm.cmd.rightmove = 0;
				pm.cmd.upmove = 0;
			}
		}


		// perform a pmove
		Pmove (&pm);
		// save results of pmove
		VectorCopy( client->ps.origin, ent->s.origin );

		G_TouchTriggers( ent );
		trap_UnlinkEntity( ent );
	}

	client->oldbuttons = client->buttons;
	client->buttons = ucmd->buttons;

	// attack button cycles through spectators
	if ( ( client->buttons & BUTTON_ATTACK ) && ! ( client->oldbuttons & BUTTON_ATTACK ) ) {
		Cmd_FollowCycle_f( ent, 1 );
	}

}


/*
=================
ClientInactivityTimer

Returns qfalse if the client is dropped
=================
*/
qboolean ClientInactivityTimer( gclient_t *client ) {
	if ( ! g_inactivity.integer ) {
		// give everyone some time, so if the operator sets g_inactivity during
		// gameplay, everyone isn't kicked
		client->inactivityTime = level.time + 60 * 1000;
		client->inactivityWarning = qfalse;
	} else if ( client->pers.cmd.forwardmove ||
		client->pers.cmd.rightmove ||
		client->pers.cmd.upmove ||
		(client->pers.cmd.buttons & BUTTON_ATTACK) ) {
		client->inactivityTime = level.time + g_inactivity.integer * 1000;
		client->inactivityWarning = qfalse;
	} else if ( !client->pers.localClient ) {
		if ( level.time > client->inactivityTime ) {
			trap_DropClient( client - level.clients, "Dropped due to inactivity" );
			return qfalse;
		}
		if ( level.time > client->inactivityTime - 10000 && !client->inactivityWarning ) {
			client->inactivityWarning = qtrue;
			trap_SendServerCommand( client - level.clients, "cp \"Ten seconds until inactivity drop!\n\"" );
		}
	}
	return qtrue;
}

/*
==================
JUHOX: GetTeamBase
==================
*/
static qboolean GetTeamBase(team_t team, vec3_t origin, int* area)
{
	if (g_gametype.integer != GT_CTF) return qfalse;
	switch (team)
	{
	case TEAM_RED:
		VectorCopy(ctf_redflag.origin, origin);
		*area = ctf_redflag.areanum;
		return qtrue;
	case TEAM_BLUE:
		VectorCopy(ctf_blueflag.origin, origin);
		*area = ctf_blueflag.areanum;
		return qtrue;
	default:
		return qfalse;
	}
}

/*
==================
JUHOX: GetMissionGoal
==================
*/
static qboolean GetMissionGoal(gclient_t* client, vec3_t target, int* targetArea, int* targetEntity) {
	tss_mission_t mission;
	bot_goal_t itemGoal;

	mission = BG_TSS_GetPlayerInfo(&client->ps, TSSPI_mission);
	switch (mission) {
	case TSSMISSION_seek_enemy:
	case TSSMISSION_seek_items:
		return qfalse;
	case TSSMISSION_capture_enemy_flag:
		if (g_gametype.integer != GT_CTF) return qfalse;
		if (!LocateFlag(OtherTeam(client->sess.sessionTeam), &itemGoal)) return qfalse;
		VectorCopy(itemGoal.origin, target);
		*targetArea = itemGoal.areanum;
		*targetEntity = itemGoal.entitynum;
		break;
	case TSSMISSION_defend_our_flag:
		if (g_gametype.integer != GT_CTF) return qfalse;
		if (!LocateFlag(client->sess.sessionTeam, &itemGoal)) return qfalse;
		VectorCopy(itemGoal.origin, target);
		*targetArea = itemGoal.areanum;
		*targetEntity = itemGoal.entitynum;
		break;
	case TSSMISSION_defend_our_base:
		if (!GetTeamBase(client->sess.sessionTeam, target, targetArea)) return qfalse;
		break;
	case TSSMISSION_occupy_enemy_base:
		if (!GetTeamBase(OtherTeam(client->sess.sessionTeam), target, targetArea)) return qfalse;
		break;
	default:
		break;
	}
	return qtrue;
}

/*
==================
JUHOX: IsAreaVisited
==================
*/
#define MAX_VISITED_AREAS 500
static int visitedAreas[MAX_VISITED_AREAS];
static int numVisitedAreas;
static qboolean IsAreaVisited(int area) {
	int i;

	for (i = 0; i < numVisitedAreas; i++) {
		if (visitedAreas[i] == area) return qtrue;
	}
	return qfalse;
}

/*
==================
JUHOX: AddVisitedArea
==================
*/
static void AddVisitedArea(int area) {
	visitedAreas[numVisitedAreas++] = area;
}

/*
==================
JUHOX: NavAid
==================
*/
#define MAX_AREA_PREDICTION 5
#define AREABUFFER_SIZE 100
static void NavAid(gclient_t* client) {
	tss_missionTask_t task;
	int taskGoal;
	gclient_t* taskGoalClient;
	vec3_t destination;
	int destArea;
	int startArea;
	vec3_t startPos;
	gentity_t* ent;
	aas_predictroute_t route;
	int i;
	qboolean retreat;

	if (!client) return;
	if (client->ps.stats[STAT_HEALTH] <= 0) return;
	if (!BG_TSS_GetPlayerInfo(&client->ps, TSSPI_isValid)) return;
	if (!BG_TSS_GetPlayerInfo(&client->ps, TSSPI_navAid)) return;
	if (!trap_AAS_Initialized()) return;

	BotFindCTFBases();

	task = BG_TSS_GetPlayerInfo(&client->ps, TSSPI_task);
	destArea = -1;
	taskGoal = ENTITYNUM_NONE;
	retreat = qfalse;
	switch (task) {
	case TSSMT_stickToGroupLeader:
	case TSSMT_helpTeamMate:
	case TSSMT_guardFlagCarrier:
	case TSSMT_seekGroupMember:
	case TSSMT_seekEnemyNearTeamMate:
		taskGoal = BG_TSS_GetPlayerInfo(&client->ps, TSSPI_taskGoal);
		if (taskGoal < 0 || taskGoal >= MAX_CLIENTS) return;
		if (!g_entities[taskGoal].inuse) return;
		taskGoalClient = level.clients + taskGoal;
		if (taskGoalClient->sess.sessionTeam != client->sess.sessionTeam) return;
		if (taskGoalClient->ps.stats[STAT_HEALTH] <= 0) return;
		VectorCopy(taskGoalClient->ps.origin, destination);
		destArea = taskGoalClient->tssLastValidAreaNum;
		break;
	case TSSMT_followGroupLeader:
		taskGoal = BG_TSS_GetPlayerInfo(&client->ps, TSSPI_taskGoal);
		if (taskGoal < 0 || taskGoal >= MAX_CLIENTS) return;
		if (!g_entities[taskGoal].inuse) return;
		taskGoalClient = level.clients + taskGoal;
		if (taskGoalClient->sess.sessionTeam != client->sess.sessionTeam) return;
		if (taskGoalClient->ps.stats[STAT_HEALTH] <= 0) return;

		if (GetMissionGoal(client, destination, &destArea, &i)) {
			if (
				trap_AAS_AreaTravelTimeToGoalArea(
					client->tssLastValidAreaNum, client->ps.origin, taskGoalClient->tssLastValidAreaNum,
					TFL_DEFAULT
				) >
				trap_AAS_AreaTravelTimeToGoalArea(
					client->tssLastValidAreaNum, client->ps.origin, destArea, TFL_DEFAULT
				) + 200
			) {
				taskGoal = i;
				break;
			}
		}
		VectorCopy(taskGoalClient->ps.origin, destination);
		destArea = taskGoalClient->tssLastValidAreaNum;
		break;
	case TSSMT_retreat:
	case TSSMT_prepareForMission:
		if (client->ps.powerups[PW_REDFLAG] || client->ps.powerups[PW_BLUEFLAG]) {
			if (!GetTeamBase(client->sess.sessionTeam, destination, &destArea)) return;
		}
		else {
			if (!GetMissionGoal(client, destination, &destArea, &taskGoal)) return;
		}
		retreat = qtrue;
		break;
	case TSSMT_rushToBase:
		if (!GetTeamBase(client->sess.sessionTeam, destination, &destArea)) return;
		break;
	case TSSMT_fulfilMission:
		if (!GetMissionGoal(client, destination, &destArea, &taskGoal)) return;
		break;
	default:
		return;
	}

	if (destArea < 0) destArea = BotPointAreaNum(destination);
	if (destArea <= 0) return;
	if (!trap_AAS_AreaReachability(destArea)) return;

	startArea = client->tssLastValidAreaNum;
	if (startArea <= 0) return;
	if (!trap_AAS_AreaReachability(startArea)) return;

	ent = G_TempEntity(client->ps.origin, EV_NAVAID0);
	if (!ent) return;
	ent->r.singleClient = client->ps.clientNum;
	ent->r.svFlags |= SVF_SINGLECLIENT;
	ent->s.otherEntityNum = taskGoal;
	ent->s.otherEntityNum2 = retreat;
	VectorCopy(destination, ent->s.pos.trDelta);
	ent->s.time = level.time;
	ent->s.time2 = 2;	// start & end position

	numVisitedAreas = 0;
	AddVisitedArea(startArea);
	VectorCopy(client->ps.origin, startPos);
	for (i = 2; i < NAVAID_PACKETS * 8; i++) {
		int j;

		if (startArea == destArea) return;
		for (j = 1; j <= MAX_AREA_PREDICTION; j++) {
			trap_AAS_PredictRoute(
				&route, startArea, startPos, destArea, TFL_DEFAULT, j, 100000,
				RSE_NOROUTE | RSE_USETRAVELTYPE, 0, TFL_TELEPORT, 0
			);
			if (route.stopevent & RSE_NOROUTE) return;
			if (route.stopevent & RSE_USETRAVELTYPE) break;
			if (route.endarea == destArea) break;
			if (route.endarea == startArea) continue;
			AddVisitedArea(route.endarea);
			if (DistanceSquared(route.endpos, startPos) > Square(25)) break;
		}
		if (j > MAX_AREA_PREDICTION) {
			//return;
			int areas[AREABUFFER_SIZE];
			int numAreas;
			vec3_t absmins;
			vec3_t absmaxs;
			int currentTravelTime;
			float bestDistance;

			currentTravelTime = trap_AAS_AreaTravelTimeToGoalArea(startArea, startPos, destArea, TFL_DEFAULT);
			VectorSet(absmins, -100, -100, -100);
			VectorSet(absmaxs, 100, 100, 100);
			VectorAdd(absmins, startPos, absmins);
			VectorAdd(absmaxs, startPos, absmaxs);
			numAreas = trap_AAS_BBoxAreas(absmins, absmaxs, areas, AREABUFFER_SIZE);
			route.endarea = -1;
			bestDistance = 100000000.0;
			for (j = 0; j < numAreas; j++) {
				int area;
				struct aas_areainfo_s areaInfo;
				int travelTime;
				float distance;

				area = areas[j];
				if (area == startArea) continue;

				trap_AAS_AreaInfo(area, &areaInfo);
				travelTime = trap_AAS_AreaTravelTimeToGoalArea(area, areaInfo.center, destArea, TFL_DEFAULT);
				if (travelTime <= 0) continue;
				if (travelTime >= currentTravelTime) continue;

				distance = DistanceSquared(areaInfo.center, startPos);
				if (distance >= bestDistance) continue;

				if (IsAreaVisited(area)) continue;

				bestDistance = distance;
				route.endarea = area;
				VectorCopy(areaInfo.center, route.endpos);
			}
			if (route.endarea < 0) return;
			AddVisitedArea(route.endarea);
		}
		SnapVector(route.endpos);

		switch (i & 7) {
		case 0:
			ent = G_TempEntity(route.endpos, EV_NAVAID0 + (i >> 3));
			if (!ent) return;
			ent->r.singleClient = client->ps.clientNum;
			ent->r.svFlags |= SVF_SINGLECLIENT;
			ent->s.otherEntityNum = taskGoal;
			ent->s.otherEntityNum2 = retreat;
			ent->s.time = level.time;
			ent->s.time2 = 0;	// increased below
			break;
		case 1:
			VectorCopy(route.endpos, ent->s.pos.trDelta);
			break;
		case 2:
			VectorCopy(route.endpos, ent->s.apos.trBase);
			break;
		case 3:
			VectorCopy(route.endpos, ent->s.apos.trDelta);
			break;
		case 4:
			VectorCopy(route.endpos, ent->s.origin);
			break;
		case 5:
			VectorCopy(route.endpos, ent->s.origin2);
			break;
		case 6:
			VectorCopy(route.endpos, ent->s.angles);
			break;
		case 7:
			VectorCopy(route.endpos, ent->s.angles2);
			break;
		}
		ent->s.time2++;
		if (route.stopevent & RSE_USETRAVELTYPE) return;

		startArea = route.endarea;
		VectorCopy(route.endpos, startPos);
	}
}

/*
==================
ClientTimerActions

Actions that happen once a second
==================
*/
void ClientTimerActions( gentity_t *ent, int msec ) {
	gclient_t	*client;

	client = ent->client;
	if (client->tssSafetyMode) return;	// JUHOX
	client->timeResidual += msec;

	// JUHOX: update nav aid
	if (!(ent->r.svFlags & SVF_BOT)) {
		client->tssNavAidTimeResidual += msec;

		if (client->tssNavAidTimeResidual >= 1000) {
			client->tssNavAidTimeResidual %= 1000;
			client->tssNavAidTimeResidual -= (rand() % 100);

			NavAid(client);
		}
	}

	while ( client->timeResidual >= 1000 ) {
		client->timeResidual -= 1000;

		if (!(ent->r.svFlags & SVF_BOT)) NavAid(client);	// JUHOX

    	// JUHOX: auto health regeneration
		if (
			!g_noHealthRegen.integer &&
			ent->health < client->ps.stats[STAT_MAX_HEALTH] &&
			!client->ps.powerups[PW_CHARGE] &&
			//client->ps.stats[STAT_STRENGTH] > 0
			ent->damage <= 2	// don't auto regenerate health if drowning
		) {
			ent->health += 5;
			if (ent->health > client->ps.stats[STAT_MAX_HEALTH]) {
				ent->health = client->ps.stats[STAT_MAX_HEALTH];
			}
		}

        // JUHOX: auto armor regeneration
		if (
			!g_noHealthRegen.integer &&
			client->ps.stats[STAT_ARMOR] < client->ps.stats[STAT_MAX_HEALTH] &&
			!client->ps.powerups[PW_CHARGE]
		) {
			client->ps.stats[STAT_ARMOR] += 5;
			if (client->ps.stats[STAT_ARMOR] > client->ps.stats[STAT_MAX_HEALTH]) {
				client->ps.stats[STAT_ARMOR] = client->ps.stats[STAT_MAX_HEALTH];
			}
		}

		// regenerate
		if ( client->ps.powerups[PW_REGEN] ) {
			if ( ent->health < client->ps.stats[STAT_MAX_HEALTH]) {
				ent->health += 15;
				if ( ent->health > client->ps.stats[STAT_MAX_HEALTH] * 1.1 ) {
					ent->health = client->ps.stats[STAT_MAX_HEALTH] * 1.1;
				}
				G_AddEvent( ent, EV_POWERUP_REGEN, 0 );
			} else if ( ent->health < client->ps.stats[STAT_MAX_HEALTH] * 2) {
				ent->health += 5;
				if ( ent->health > client->ps.stats[STAT_MAX_HEALTH] * 2 ) {
					ent->health = client->ps.stats[STAT_MAX_HEALTH] * 2;
				}
				G_AddEvent( ent, EV_POWERUP_REGEN, 0 );
			}
			// JUHOX: also regenerate strength
			client->ps.stats[STAT_STRENGTH] += 0.05 * MAX_STRENGTH_VALUE;
			if (client->ps.stats[STAT_STRENGTH] > MAX_STRENGTH_VALUE) {
				client->ps.stats[STAT_STRENGTH] = MAX_STRENGTH_VALUE;
			}

		} else {
			// count down health when over max
			if ( ent->health > client->ps.stats[STAT_MAX_HEALTH] ) {
				ent->health--;
			}
		}

		// count down armor when over max
		if ( client->ps.stats[STAT_ARMOR] > client->ps.stats[STAT_MAX_HEALTH] ) {
			client->ps.stats[STAT_ARMOR]--;
		}
	}
}

/*
====================
JUHOX: TotalChargeDamage
====================
*/
float TotalChargeDamage(float time) {
	if (time <= 0) return 0;
	if (
		g_lightningDamageLimit.value <= 0 ||
		CHARGE_DAMAGE_PER_SECOND * time <= g_lightningDamageLimit.value
	) {
		return CHARGE_DAMAGE_PER_SECOND * 0.5 * Square(time);
	}
	else {
		float t0;

		t0 = g_lightningDamageLimit.value / CHARGE_DAMAGE_PER_SECOND;
		return CHARGE_DAMAGE_PER_SECOND * 0.5 * Square(t0) + g_lightningDamageLimit.value * (time - t0);
	}
}

/*
====================
JUHOX: CauseChargeDamage
====================
*/
static void CauseChargeDamage(gentity_t* ent) {
	gclient_t* client;

	client = ent->client;
	if (!client) return;

	if (client->lastChargeTime) {
		int n;
		gentity_t* attacker;
		float damage;

		n = ent->chargeInflictor;
		if (n < 0 || n >= MAX_GENTITIES) {
			G_Printf("WARNING: invalid charge inflictor: %d\n", n);
			return;
		}
		attacker = &g_entities[n];
		if (!attacker->client) {
			G_Printf("WARNING: charge inflictor is not a client: %d\n", n);
			return;
		}

		damage = client->chargeDamageResidual + TotalChargeDamage(client->lastChargeAmount);
		if (ent->waterlevel <= 0) {
			float time;

			time = (level.time - client->lastChargeTime) / 1000.0;
			damage -= TotalChargeDamage(client->lastChargeAmount - time);
		}
		else {
			client->ps.powerups[PW_CHARGE] -= (int) (1000.0 * client->lastChargeAmount);
		}

		n = (int) damage;
		client->chargeDamageResidual = damage - n;

		while (n > 0) {	// so slow and fast servers do the damage the same way
			int d;

			if (client->ps.stats[STAT_ARMOR] > 0 && ent->waterlevel <= 0) {
				d = client->ps.stats[STAT_ARMOR];
				if (d >= n) d = n - 1;
				client->ps.stats[STAT_ARMOR] -= d;
				n -= d;

				d = 1;
			}
			else {
				d = n;
			}
			G_Damage(ent, attacker, attacker, NULL, NULL, d, 0, MOD_CHARGE);
			n -= d;
		}
	}

	if (client->ps.powerups[PW_CHARGE] > level.time) {
		client->lastChargeAmount = (client->ps.powerups[PW_CHARGE] - level.time) / 1000.0;
		client->lastChargeTime = level.time;
	}
	else {
		client->lastChargeAmount = 0.0;
		client->lastChargeTime = 0;
	}
}


/*
====================
ClientIntermissionThink
====================
*/
void ClientIntermissionThink( gclient_t *client ) {
	client->ps.eFlags &= ~EF_TALK;
	client->ps.eFlags &= ~EF_FIRING;

	// JUHOX: switch to standard view mode during intermission
	client->viewMode = VIEW_standard;
	client->viewModeSwitchTime = 0;

	// the level will exit when everyone wants to or after timeouts

	// JUHOX: don't accept ready signals during the first two seconds
	if (level.time < level.intermissiontime + 2000) {
		client->buttons = 0;
		return;
	}

	// swap and latch button actions
	client->oldbuttons = client->buttons;
	client->buttons = client->pers.cmd.buttons;
	if ( client->buttons & ( BUTTON_ATTACK | BUTTON_USE_HOLDABLE ) & ( client->oldbuttons ^ client->buttons ) ) {
		// this used to be an ^1 but once a player says ready, it should stick
#if !MEETING
		client->readyToExit = 1;
#else
		if (!level.meeting) {
			client->readyToExit = 1;
		}
		else {
			client->readyToExit ^= 1;
		}
#endif
	}
}


/*
================
ClientEvents

Events will be passed on to the clients for presentation,
but any server game effects are handled here
================
*/
void ClientEvents( gentity_t *ent, int oldEventSequence ) {
	int		i, j;
	int		event;
	gclient_t *client;
	int		damage;
	vec3_t	dir;
	vec3_t	origin, angles;
	gitem_t *item;
	gentity_t *drop;

	client = ent->client;

	if ( oldEventSequence < client->ps.eventSequence - MAX_PS_EVENTS ) {
		oldEventSequence = client->ps.eventSequence - MAX_PS_EVENTS;
	}
	for ( i = oldEventSequence ; i < client->ps.eventSequence ; i++ ) {
		event = client->ps.events[ i & (MAX_PS_EVENTS-1) ];

		switch ( event ) {
		case EV_FALL_MEDIUM:
		case EV_FALL_FAR:
			if ( ent->s.eType != ET_PLAYER ) {
				break;		// not in the player model
			}
			if ( g_dmflags.integer & DF_NO_FALLING ) {
				break;
			}
			if ( event == EV_FALL_FAR ) {
				damage = 10;
			} else {
				damage = 5;
			}
			VectorSet (dir, 0, 0, 1);
			ent->pain_debounce_time = level.time + 200;	// no normal pain sound
			G_Damage (ent, NULL, NULL, NULL, NULL, damage, 0, MOD_FALLING);
			break;

		case EV_FIRE_WEAPON:
			FireWeapon( ent );
			break;

		case EV_USE_ITEM1:		// teleporter
			// drop flags in CTF
			item = NULL;
			j = 0;

			if ( ent->client->ps.powerups[ PW_REDFLAG ] ) {
				item = BG_FindItemForPowerup( PW_REDFLAG );
				j = PW_REDFLAG;
			} else if ( ent->client->ps.powerups[ PW_BLUEFLAG ] ) {
				item = BG_FindItemForPowerup( PW_BLUEFLAG );
				j = PW_BLUEFLAG;
			} else if ( ent->client->ps.powerups[ PW_NEUTRALFLAG ] ) {
				item = BG_FindItemForPowerup( PW_NEUTRALFLAG );
				j = PW_NEUTRALFLAG;
			}

			if ( item ) {
				drop = Drop_Item( ent, item, 0 );
				if (!drop) break;	// JUHOX BUGFIX
				// decide how many seconds it has left
				drop->count = ( ent->client->ps.powerups[ j ] - level.time ) / 1000;
				if ( drop->count < 1 ) {
					drop->count = 1;
				}

				ent->client->ps.powerups[ j ] = 0;
			}

			SelectSpawnPoint( ent->client->ps.origin, origin, angles );
			TeleportPlayer( ent, origin, angles );
			break;

		case EV_USE_ITEM2: // medkit
			ent->health = ent->client->ps.stats[STAT_MAX_HEALTH] + 25;

			break;

		default:
			break;
		}
	}

}

/*
================
JUHOX: ClientRefreshAmmo
================
*/
void ClientRefreshAmmo(gentity_t* ent, int msec) {
	gclient_t* client;
	int i;

	client = ent->client;
	if (client->tssSafetyMode) return;
	if (client->viewMode == VIEW_scanner) return;

	for (i = WP_NONE+1; i < WP_NUM_WEAPONS; i++) {
		int maxAmmo;
		float amount;
		int pieces;
		float fraction;

		if (!(client->ps.stats[STAT_WEAPONS] & (1 << i))) continue;
		if (client->ps.ammo[i] < 0) continue;
		maxAmmo = weaponAmmoCharacteristics[i].maxAmmo;
		if (i == WP_MONSTER_LAUNCHER) maxAmmo = client->monstersAvailable;
		if (client->ps.ammo[i] >= maxAmmo) continue;
		if (client->ps.weapon == i && client->ps.weaponstate >= WEAPON_FIRING) continue;

		amount = weaponAmmoCharacteristics[i].ammoRefresh * msec / 10000.0;
		pieces = amount;
		fraction = amount - pieces;
		client->ammoFraction[i] += fraction;
		if (client->ammoFraction[i] >= 1.0) {
			pieces += 1;
			client->ammoFraction[i] -= 1.0;
		}
		client->ps.ammo[i] += pieces;
		if (client->ps.ammo[i] >= maxAmmo) {
			client->ps.ammo[i] = maxAmmo;
			client->ammoFraction[i] = 0.0;
		}
	}
}

/*
================
JUHOX: SetTargetPos
================
*/
void SetTargetPos(gentity_t* ent) {
	gentity_t* target;
	int targetNum;
	float pos;
	vec3_t dest;

	targetNum = ent->client->ps.stats[STAT_TARGET];
	if (targetNum < 0 || targetNum >= ENTITYNUM_MAX_NORMAL) return;
	target = &g_entities[targetNum];
	if (!target->inuse) return;

	switch (ent->s.weapon) {
	case WP_GAUNTLET:
		pos = GAUNTLET_TARGET_POS;
		break;
	case WP_LIGHTNING:
		pos = LIGHTNING_TARGET_POS;
		break;
	default:
		// should not happen
		pos = DEFAULT_TARGET_POS;
		break;
	}

	VectorCopy(target->s.pos.trBase, dest);
	dest[2] += BG_PlayerTargetOffset(&target->s, pos);
	VectorCopy(dest, ent->s.origin2);
}

/*
================
JUHOX: GetGauntletTarget
================
*/
static void GetGauntletTarget(gentity_t* ent) {
	trace_t tr;
	vec3_t forward, right, up, muzzle, end;
	gentity_t* target;

	if (
		ent->client->ps.weapon != WP_GAUNTLET ||
		ent->client->ps.stats[STAT_HEALTH] <= 0
	) {
		ent->client->ps.stats[STAT_TARGET] = -1;
		return;
	}

	// set aiming directions
	AngleVectors(ent->client->ps.viewangles, forward, right, up);

	CalcMuzzlePoint(ent, forward, right, up, muzzle);

	VectorMA(muzzle, 10000, forward, end);

	trap_Trace(&tr, muzzle, NULL, NULL, end, ent->s.number, MASK_SHOT);
	if (tr.fraction >= 1) goto NoTarget;
	if (tr.surfaceFlags & SURF_NOIMPACT) goto NoTarget;

	target = &g_entities[tr.entityNum];
	if (
		(
			target->client &&
			!OnSameTeam(ent, target) &&
			target->client->sess.sessionTeam != TEAM_SPECTATOR &&
			target->client->ps.pm_type != PM_SPECTATOR &&
			!target->client->ps.powerups[PW_INVIS] &&
			target->client->ps.stats[STAT_HEALTH] > 0 &&
			target->client->ps.weapon != WP_GAUNTLET
		)

        // accept monsters for gauntlet target
		|| (
			target->monster &&
			target->health > 0 &&
			!G_IsFriendlyMonster(ent, target) &&
			G_CanBeDamaged(target)
		)

	) {
		ent->client->ps.stats[STAT_TARGET] = tr.entityNum;
		SetTargetPos(ent);
		ent->client->looseTargetTime = 0;
		return;
	}

	NoTarget:
	if (ent->client->ps.stats[STAT_TARGET] < 0) return;
	if (!ent->client->looseTargetTime) {
		ent->client->looseTargetTime = level.time + 200;
	}
	else if (
		level.time > ent->client->looseTargetTime ||
		g_entities[ent->client->ps.stats[STAT_TARGET]].health <= 0
	) {
		ent->client->ps.stats[STAT_TARGET] = -1;
		ent->client->looseTargetTime = 0;
		return;
	}
	SetTargetPos(ent);
}

/*
================
JUHOX: PlayerCharge
================
*/
static int PlayerCharge(const playerState_t* ps) {
	int charge;

	charge = ps->powerups[PW_CHARGE] - level.time;
	if (charge < 0) charge = 0;
	return charge;
}

/*
================
JUHOX: CheckPlayerDischarge
================
*/
#define PLAYERDISCHARGE_RADIUS_PER_SECOND 15.0
#define PLAYERDISCHARGE_SINGLE_TARGET 1
void CheckPlayerDischarge(gentity_t* ent) {
	playerState_t* sourcePS;
	int i, numTargs;
	float radius, radiusSquared;
	int targNum[MAX_GENTITIES];
#if !PLAYERDISCHARGE_SINGLE_TARGET
	int numAffectedPlayers;
	playerState_t* affectedPlayers[MAX_CLIENTS+MAX_MONSTERS];
	int totalCharge;
#else
	playerState_t* affectedPlayer;
	int sourceCharge;
	int destinationCharge;
	int resultingCharge;
#endif
	vec3_t mins, maxs;
	int maxCharge;

	if (g_gametype.integer < GT_TEAM && !g_monsterLauncher.integer) return;

	if (ent->nextDischargeCheckTime > level.time) return;
	ent->nextDischargeCheckTime = level.time + 100 + rand() % 50;

	if (ent->monster && level.endPhase >= 3) return;

	sourcePS = G_GetEntityPlayerState(ent);
	if (!sourcePS) return;
	if (!sourcePS->powerups[PW_CHARGE]) return;

	radius = PLAYERDISCHARGE_RADIUS_PER_SECOND * (sourcePS->powerups[PW_CHARGE] - level.time) / 1000.0;
	if (radius > 0.5 * LIGHTNING_RANGE) radius = 0.5 * LIGHTNING_RANGE;
	radiusSquared = Square(radius);
	maxs[0] = maxs[1] = maxs[2] = radius;
	mins[0] = mins[1] = mins[2] = -radius;
	VectorAdd(sourcePS->origin, mins, mins);
	VectorAdd(sourcePS->origin, maxs, maxs);
	numTargs = trap_EntitiesInBox(mins, maxs, targNum, MAX_GENTITIES);

#if !PLAYERDISCHARGE_SINGLE_TARGET
	maxCharge = PlayerCharge(sourcePS) - 1000;
	totalCharge = 0;
	numAffectedPlayers = 0;
#else
	sourceCharge = PlayerCharge(sourcePS);
	maxCharge = sourceCharge - 1000;
	destinationCharge = 0;
	affectedPlayer = NULL;
#endif
	for (i = 0; i < numTargs; i++) {
		gentity_t* targ;
		playerState_t* ps;
		int charge;
		trace_t trace;
#if PLAYERDISCHARGE_SINGLE_TARGET
		float distanceSquared;
#endif

		targ = &g_entities[targNum[i]];
		ps = G_GetEntityPlayerState(targ);
		if (!ps) continue;
		if (ps->persistant[PERS_TEAM] != sourcePS->persistant[PERS_TEAM]) continue;
		if (ps->pm_type == PM_SPECTATOR) continue;

		if (!G_CanBeDamaged(targ)) continue;
		if (ps->persistant[PERS_TEAM] == TEAM_FREE && ps != sourcePS) {
			if (!ent->monster && !targ->monster) continue;
			if (!G_IsFriendlyMonster(ent, targ)) continue;
		}

		if (ps->stats[STAT_HEALTH] <= 0) continue;
#if !PLAYERDISCHARGE_SINGLE_TARGET
		charge = PlayerCharge(ps);
		if (ps != sourcePS) {
			if (charge > maxCharge) continue;
			if (
				DistanceSquared(sourcePS->origin, ps->origin) > radiusSquared
			) continue;
			trap_Trace(&trace, sourcePS->origin, NULL, NULL, ps->origin, ENTITYNUM_NONE, CONTENTS_SOLID);
			if (trace.fraction < 1) continue;
		}

		affectedPlayers[numAffectedPlayers++] = ps;
		totalCharge += charge;
#else
		if (ps == sourcePS) continue;
		charge = PlayerCharge(ps);
		if (charge > maxCharge) continue;
		distanceSquared = DistanceSquared(sourcePS->origin, ps->origin);
		if (distanceSquared > radiusSquared) continue;

		trap_Trace(&trace, sourcePS->origin, NULL, NULL, ps->origin, ENTITYNUM_NONE, CONTENTS_SOLID);
		if (trace.fraction < 1) continue;

		affectedPlayer = ps;
		radiusSquared = distanceSquared;
		destinationCharge = charge;
#endif
	}

#if !PLAYERDISCHARGE_SINGLE_TARGET
	if (numAffectedPlayers < 2) return;

	totalCharge /= numAffectedPlayers;
	totalCharge += level.time;
	for (i = 0; i < numAffectedPlayers; i++) {
		gentity_t* flash;

		flash = G_TempEntity(affectedPlayers[i]->origin, EV_DISCHARGE_FLASH);
		if (flash) {
			flash->s.otherEntityNum = ent->s.number;
			flash->s.otherEntityNum2 = affectedPlayers[i]->clientNum;
		}

		affectedPlayers[i]->powerups[PW_CHARGE] = totalCharge;
		//g_entities[affectedPlayers[i]->clientNum].s.time2 = totalCharge;	// NOTE: time2 was unused before
		g_entities[affectedPlayers[i]->clientNum].chargeInflictor = ent->chargeInflictor;
	}
#else
	if (!affectedPlayer) return;

	resultingCharge = (sourceCharge + destinationCharge) / 2 + level.time;

	sourcePS->powerups[PW_CHARGE] = resultingCharge;
	affectedPlayer->powerups[PW_CHARGE] = resultingCharge;
	g_entities[affectedPlayer->clientNum].chargeInflictor = ent->chargeInflictor;

	{
		vec3_t origin;
		gentity_t* flash;

		VectorAdd(sourcePS->origin, affectedPlayer->origin, origin);
		VectorScale(origin, 0.5, origin);
		flash = G_TempEntity(origin, EV_DISCHARGE_FLASH);
		if (flash) {
			flash->s.otherEntityNum = ent->s.number;
			flash->s.otherEntityNum2 = affectedPlayer->clientNum;
		}
	}
#endif
}

/*
==============
JUHOX: MoveRopeElement

derived from PM_SlideMove() [bg_slidemove.c]
returns qfalse if element is in solid
==============
*/

#define	MAX_CLIP_PLANES	5
#include "bg_local.h"
static qboolean MoveRopeElement(const vec3_t start, const vec3_t idealpos, vec3_t realpos, qboolean* touch) {
	vec3_t		velocity;
	static vec3_t ropeMins = {-ROPE_ELEMENT_SIZE, -ROPE_ELEMENT_SIZE, -ROPE_ELEMENT_SIZE};
	static vec3_t ropeMaxs = {ROPE_ELEMENT_SIZE, ROPE_ELEMENT_SIZE, ROPE_ELEMENT_SIZE};

	int			bumpcount, numbumps;
	vec3_t		dir;
	float		d;
	int			numplanes;
	vec3_t		planes[MAX_CLIP_PLANES];
	vec3_t		clipVelocity;
	int			i, j, k;
	trace_t	trace;
	vec3_t		end;
	float		time_left;
	float		into;


	VectorSubtract(idealpos, start, velocity);
	VectorCopy(start, realpos);
	*touch = qfalse;

	numbumps = MAX_CLIP_PLANES - 1;

	time_left = 1.0;	// seconds

	numplanes = 0;

	// never turn against original velocity
	if (VectorNormalize2(velocity, planes[numplanes]) < 1) return qtrue;
	numplanes++;

	for (bumpcount=0; bumpcount < numbumps; bumpcount++) {

		// calculate position we are trying to move to
		VectorMA(realpos, time_left, velocity, end);

		// see if we can make it there
		trap_Trace(&trace, realpos, ropeMins, ropeMaxs, end, -1, CONTENTS_SOLID);

		if (trace.allsolid) {
			if (time_left >= 1.0) return qfalse;
			SnapVectorTowards(realpos, start);
			return qtrue;
		}

		if (trace.fraction > 0) {
			// actually covered some distance
			VectorCopy(trace.endpos, realpos);
		}

		//if (trace.fraction >= 1) return qtrue;
		// check if we can get back!
		if (trace.fraction >= 1) {
			trace_t trace2;

			trap_Trace(&trace2, end, ropeMins, ropeMaxs, realpos, -1, CONTENTS_SOLID);
			if (trace2.fraction >= 1) return qtrue;
			if (trace.allsolid) {
				if (time_left >= 1.0) return qfalse;
				SnapVectorTowards(realpos, start);
				return qtrue;
			}
		}

		*touch = qtrue;

		time_left -= time_left * trace.fraction;
		// this shouldn't really happen
		if (numplanes >= MAX_CLIP_PLANES) return qtrue;

		//
		// if this is the same plane we hit before, nudge velocity
		// out along it, which fixes some epsilon issues with
		// non-axial planes
		//
		for (i = 0; i < numplanes; i++) {
			if (DotProduct(trace.plane.normal, planes[i]) > 0.99) {
				VectorAdd(trace.plane.normal, velocity, velocity);
				break;
			}
		}
		if (i < numplanes) {
			continue;
		}
		VectorCopy(trace.plane.normal, planes[numplanes]);
		numplanes++;

		//
		// modify velocity so it parallels all of the clip planes
		//

		// find a plane that it enters
		for (i = 0; i < numplanes; i++) {
			into = DotProduct(velocity, planes[i]);
			if (into >= 0.1) {
				continue;		// move doesn't interact with the plane
			}

			// slide along the plane
			PM_ClipVelocity(velocity, planes[i], clipVelocity, OVERCLIP);

			// see if there is a second plane that the new move enters
			for (j = 0; j < numplanes; j++) {
				if (j == i) {
					continue;
				}
				if (DotProduct(clipVelocity, planes[j]) >= 0.1) {
					continue;		// move doesn't interact with the plane
				}

				// try clipping the move to the plane
				PM_ClipVelocity(clipVelocity, planes[j], clipVelocity, OVERCLIP);

				// see if it goes back into the first clip plane
				if (DotProduct(clipVelocity, planes[i]) >= 0) {
					continue;
				}

				// slide the original velocity along the crease
				CrossProduct(planes[i], planes[j], dir);
				VectorNormalize(dir);
				d = DotProduct(dir, velocity);
				VectorScale(dir, d, clipVelocity);

				// see if there is a third plane the the new move enters
				for (k = 0; k < numplanes; k++) {
					if (k == i || k == j) {
						continue;
					}
					if (DotProduct(clipVelocity, planes[k]) >= 0.1) {
						continue;		// move doesn't interact with the plane
					}

					// stop dead at a tripple plane interaction
					return qtrue;
				}
			}

			// if we have fixed all interactions, try another move
			VectorCopy(clipVelocity, velocity);
			break;
		}
	}

	return qtrue;
}


/*
==============
JUHOX: ThinkRopeElement

returns qfalse if element is in solid
==============
*/

static ropeElement_t tempRope[MAX_ROPE_ELEMENTS];
static qboolean ThinkRopeElement(gclient_t* client, int ropeElement, int phase, float dt) {
	const ropeElement_t* srcRope;
	const ropeElement_t* srcRE;
	ropeElement_t* dstRE;
	vec3_t startPos;
	vec3_t predPos;
	vec3_t succPos;
	vec3_t anchorPos;
	vec3_t velocity;
	float dist;
	float f;
	vec3_t dir;
	vec3_t idealpos;
	vec3_t realpos;
	float errSqr;

	switch (phase) {
	case 0:
		srcRope = client->ropeElements;
		dstRE = &tempRope[ropeElement];
		break;
	case 1:
		srcRope = tempRope;
		dstRE = &client->ropeElements[ropeElement];
		break;
	default:
		return qfalse;
	}
	srcRE = &srcRope[ropeElement];

	VectorCopy(client->ropeElements[ropeElement].pos, startPos);

	if (ropeElement > 0) {
		VectorCopy(srcRope[ropeElement-1].pos, predPos);
		VectorCopy(client->ropeElements[ropeElement-1].pos, anchorPos);
	}
	else {
		VectorCopy(client->hook->r.currentOrigin, predPos);
		VectorCopy(predPos, anchorPos);
	}

	if (ropeElement < client->numRopeElements-1) {
		VectorCopy(srcRope[ropeElement+1].pos, succPos);
	}
	else {
		VectorCopy(client->ps.origin, succPos);
	}

	VectorCopy(srcRE->velocity, velocity);

	velocity[2] -= 0.5 * g_gravity.value * dt;
	if (!srcRE->touch) {
		velocity[0] += 0.05 * dt * crandom();
		velocity[1] += 0.05 * dt * crandom();
		velocity[2] += 0.05 * dt * crandom();
	}

	VectorSubtract(succPos, srcRE->pos, dir);
	dist = VectorLength(dir);
	if (dist > 1.5 * ROPE_ELEMENT_SIZE) {
		f = 4.0;
	}
	else if (dist > ROPE_ELEMENT_SIZE) {
		f = 2.0;
	}
	else {
		f = 0.1;
	}
	VectorMA(velocity, f, dir, velocity);

	VectorSubtract(predPos, srcRE->pos, dir);
	dist = VectorLength(dir);
	if (dist > 1.5 * ROPE_ELEMENT_SIZE) {
		f = 4.0;
	}
	else if (dist > ROPE_ELEMENT_SIZE) {
		f = 2.0;
	}
	else {
		f = 0.1;
	}
	VectorMA(velocity, f, dir, velocity);

	VectorScale(velocity, 0.9, velocity);

	VectorCopy(velocity, dstRE->velocity);

	VectorMA(srcRE->pos, dt, velocity, idealpos);

	{
		vec3_t v;
		vec3_t w;
		float d;

		VectorSubtract(succPos, predPos, v);
		VectorSubtract(idealpos, predPos, w);
		f = VectorNormalize(v);
		d = DotProduct(v, w);

		if (d < 0) {
			VectorCopy(predPos, idealpos);
		}
		else if (d > f) {
			VectorCopy(succPos, idealpos);
		}
	}

	if (phase == 1) {
		VectorSubtract(idealpos, anchorPos, dir);
		dist = VectorLength(dir);
		if (dist > 1.5 * ROPE_ELEMENT_SIZE) {
			VectorMA(anchorPos, 1.5 * ROPE_ELEMENT_SIZE / dist, dir, idealpos);
		}
	}

	switch (phase) {
	case 0:
		VectorCopy(idealpos, dstRE->pos);
		return qtrue;
	case 1:
		if (!MoveRopeElement(startPos, idealpos, realpos, &dstRE->touch)) {
			return qfalse;
		}
		break;
	}

	errSqr = DistanceSquared(idealpos, realpos);
	if (errSqr > 0.1) {
		vec3_t realpos2;
		qboolean touch;

		startPos[2] += ROPE_ELEMENT_SIZE;
		if (MoveRopeElement(startPos, idealpos, realpos2, &touch)) {
			if (DistanceSquared(idealpos, realpos2) < errSqr) {
				dstRE->touch = touch;
				VectorCopy(realpos2, realpos);
			}
		}
	}

	VectorCopy(realpos, dstRE->pos);
	return qtrue;
}


static qboolean IsRopeTaut(gentity_t* ent, qboolean wasTaut) {
	gclient_t* client;
	int i;
	int n;
	vec3_t dir;
	float dirLengthSqr;
	float dirLength;
	float treshold;

	client = ent->client;
	if (client->hook->s.eType != ET_GRAPPLE) return qfalse;

	for (i = client->numRopeElements-1; i >= 0; i--) {
		trace_t trace;

		if (client->ropeElements[i].touch) break;

		trap_Trace(&trace, client->ps.origin, NULL, NULL, client->ropeElements[i].pos, -1, CONTENTS_SOLID);

		if (trace.fraction < 1.0) break;
	}
	i++;

	if (i >= client->numRopeElements) return qtrue;

	VectorSubtract(client->ropeElements[i].pos, client->ps.origin, dir);
	dirLengthSqr = VectorLengthSquared(dir);
	dirLength = sqrt(dirLengthSqr);
	treshold = (wasTaut? 0.2 : 0.1) * dirLength;
	n = i;
	for (++i; i < client->numRopeElements; i++) {
		float k;
		vec3_t pos;
		vec3_t dir2;
		vec3_t plummet;

		VectorCopy(client->ropeElements[i].pos, pos);
		VectorSubtract(pos, client->ps.origin, dir2);
		k = DotProduct(dir, dir2) / dirLengthSqr;
		if (k < 0 || k > 1) return qfalse;
		VectorMA(client->ps.origin, k, dir, plummet);
		if (Distance(plummet, pos) > treshold) return qfalse;
	}
	return qtrue;
}


/*
==============
JUHOX: NextTouchedRopeElement
==============
*/
static int NextTouchedRopeElement(gclient_t* client, int index, vec3_t pos) {
	if (index < 0) {
		VectorCopy(client->ps.origin, pos);
		return -1;
	}

	while (index < client->numRopeElements) {
		if (client->ropeElements[index].touch) break;
		index++;
	}

	if (index >= client->numRopeElements) {
		VectorCopy(client->ps.origin, pos);
		index = -1;
	}
	else {
		VectorCopy(client->ropeElements[index].pos, pos);
	}
	return index;
}


/*
==============
JUHOX: TautRopePos

called with index=-1 to init
==============
*/
static void TautRopePos(gclient_t* client, int index, vec3_t pos) {
	static float distCovered;
	static float totalDist;
	static vec3_t startPos;
	static vec3_t dir;
	static int destIndex;

	if (index < 0) {
		vec3_t dest;

		distCovered = 0;
		VectorCopy(client->hook->r.currentOrigin, startPos);
		destIndex = NextTouchedRopeElement(client, 0, dest);
		VectorSubtract(dest, startPos, dir);
		totalDist = VectorNormalize(dir);
		return;
	}

	distCovered += 1.5 * ROPE_ELEMENT_SIZE;

	CheckDist:
	if (distCovered > totalDist) {
		distCovered -= totalDist;
		if (destIndex < 0) {
			VectorCopy(client->ps.origin, startPos);
			VectorClear(dir);
			totalDist = 1000000.0;
		}
		else {
			vec3_t dest;

			VectorCopy(client->ropeElements[destIndex].pos, startPos);
			destIndex = NextTouchedRopeElement(client, destIndex+1, dest);
			VectorSubtract(dest, startPos, dir);
			totalDist = VectorNormalize(dir);
			goto CheckDist;
		}
	}
	VectorMA(startPos, distCovered, dir, pos);
}


/*
==============
JUHOX: CreateGrappleRope
==============
*/
static void CreateGrappleRope(gentity_t* ent) {
	gclient_t* client;
	int i;

	client = ent->client;

	for (i = 0; i < client->numRopeElements; i++) {
		gentity_t* ropeEntity;
		vec3_t pos;

		ropeEntity = client->ropeEntities[i / 8];
		if (!ropeEntity) {
			ropeEntity = G_Spawn();
			if (!ropeEntity) break;
			client->ropeEntities[i / 8] = ropeEntity;

			ropeEntity->s.eType = ET_GRAPPLE_ROPE;
			ropeEntity->classname = "grapple rope element";
			ropeEntity->r.svFlags = SVF_USE_CURRENT_ORIGIN;
		}
		ropeEntity->s.time = 0;

		VectorCopy(client->ropeElements[i].pos, pos);

		switch (i & 7) {
		case 0:
			G_SetOrigin(ropeEntity, pos);
			trap_LinkEntity(ropeEntity);
			break;
		case 1:
			VectorCopy(pos, ropeEntity->s.pos.trDelta);
			break;
		case 2:
			VectorCopy(pos, ropeEntity->s.apos.trBase);
			break;
		case 3:
			VectorCopy(pos, ropeEntity->s.apos.trDelta);
			break;
		case 4:
			VectorCopy(pos, ropeEntity->s.origin);
			break;
		case 5:
			VectorCopy(pos, ropeEntity->s.origin2);
			break;
		case 6:
			VectorCopy(pos, ropeEntity->s.angles);
			break;
		case 7:
			VectorCopy(pos, ropeEntity->s.angles2);
			break;
		}
		ropeEntity->s.modelindex = (i & 7) + 1;
	}

	// delete unused rope entities
	for (i = (i+7) / 8; i < MAX_ROPE_ELEMENTS / 8; i++) {
		if (!client->ropeEntities[i]) continue;

		G_FreeEntity(client->ropeEntities[i]);
		client->ropeEntities[i] = NULL;
	}

	// chain the rope entities together
	for (i = 0; i < MAX_ROPE_ELEMENTS / 8; i++) {
		if (!client->ropeEntities[i]) continue;

		if (i <= 0) {
			client->ropeEntities[i]->s.otherEntityNum = client->hook->s.number;
		}
		else if (client->ropeEntities[i - 1]) {
			client->ropeEntities[i]->s.otherEntityNum = client->ropeEntities[i - 1]->s.number;
		}
		else {
			client->ropeEntities[i]->s.otherEntityNum = ENTITYNUM_NONE;
		}

		if (i >= MAX_ROPE_ELEMENTS / 8 - 1) {
			client->ropeEntities[i]->s.otherEntityNum2 = ent->s.number;
		}
		else {
			client->ropeEntities[i]->s.otherEntityNum2 = ENTITYNUM_NONE;
		}
	}
}


/*
==============
JUHOX: InsertRopeElement
==============
*/
static qboolean InsertRopeElement(gclient_t* client, int index, const vec3_t pos) {
	int i;
	vec3_t predPos;
	vec3_t predVel;
	vec3_t succPos;
	ropeElement_t* re;

	if (client->numRopeElements >= MAX_ROPE_ELEMENTS) return qfalse;

	for (i = client->numRopeElements-1; i >= index; i--) {
		client->ropeElements[i+1] = client->ropeElements[i];
	}
	client->numRopeElements++;

	if (index > 0) {
		VectorCopy(client->ropeElements[index-1].pos, predPos);
		VectorCopy(client->ropeElements[index-1].velocity, predVel);
	}
	else {
		VectorCopy(client->hook->r.currentOrigin, predPos);
		BG_EvaluateTrajectoryDelta(&client->hook->s.pos, level.time, predVel);
	}

	if (index < client->numRopeElements-1) {
		VectorCopy(client->ropeElements[index+1].pos, succPos);
	}
	else {
		VectorCopy(client->ps.origin, succPos);
	}

	re = &client->ropeElements[index];

	if (DistanceSquared(pos, predPos) < DistanceSquared(pos, succPos)) {
		if (!MoveRopeElement(predPos, pos, re->pos, &re->touch)) return qfalse;
	}
	else {
		if (!MoveRopeElement(succPos, pos, re->pos, &re->touch)) return qfalse;
	}
	VectorCopy(predVel, re->velocity);
	return qtrue;
}


/*
==============
JUHOX: ThinkGrapple
==============
*/
static void ThinkGrapple(gentity_t* ent, int msec) {
	float dt;
	gclient_t* client;
	int i;
	int n;
	vec3_t pullpoint;
	vec3_t start;
	vec3_t dir;
	float dist;
	qboolean autoCut;
	float pullSpeed;

	if (g_grapple.integer <= HM_disabled || g_grapple.integer >= HM_num_modes) return;

	client = ent->client;

	if (g_grapple.integer == HM_classic) {
		if (
			client->ps.weapon == WP_GRAPPLING_HOOK &&
			!client->offHandHook &&
			client->hook &&
			!(client->pers.cmd.buttons & BUTTON_ATTACK)
		) {
			Weapon_HookFree(client->hook);
			return;
		}

		if (!client->hook) return;

		if (client->hook->s.eType != ET_GRAPPLE) {
			//client->ps.stats[STAT_GRAPPLE_STATE] = GST_windoff;
			SET_STAT_GRAPPLESTATE ( &client->ps, GST_windoff);
		}
		else if (
			VectorLengthSquared(client->ps.velocity) > 160*160 &&
			(client->ps.pm_flags & PMF_TIME_KNOCKBACK) == 0
		) {
			//client->ps.stats[STAT_GRAPPLE_STATE] = GST_pulling;
			SET_STAT_GRAPPLESTATE ( &client->ps, GST_pulling );
		}
		else {
			//client->ps.stats[STAT_GRAPPLE_STATE] = GST_silent;
			SET_STAT_GRAPPLESTATE ( &client->ps, GST_silent );
		}
		return;
	}

	if (
		client->hook &&
		client->pers.cmd.upmove < 0 &&
		client->pers.crouchingCutsRope
	) {
		Weapon_HookFree(client->hook);
		return;
	}

	client->ps.pm_flags &= ~PMF_GRAPPLE_PULL;
	//client->ps.stats[STAT_GRAPPLE_STATE] = GST_unused;
	SET_STAT_GRAPPLESTATE ( &client->ps, GST_unused);
	if (!client->hook) return;

	switch (g_grapple.integer) {
	case HM_tool:
	default:
		autoCut = qtrue;
		pullSpeed = GRAPPLE_PULL_SPEED_TOOL;
		break;
	case HM_anchor:
		autoCut = qfalse;
		pullSpeed = GRAPPLE_PULL_SPEED_ANCHOR;
		break;
	case HM_combat:
		autoCut = qfalse;
		pullSpeed = GRAPPLE_PULL_SPEED_COMBAT;
		break;
	}

	if (
		client->hook->s.eType == ET_GRAPPLE &&
		(
			client->numRopeElements <= 0 ||
			DistanceSquared(client->ps.origin, client->hook->r.currentOrigin) < 40*40
		)
	) {
		client->numRopeElements = 0;	// no rope explosion
		if (autoCut) {
			Weapon_HookFree(client->hook);
			return;
		}
		else if (
			VectorLengthSquared(client->ps.velocity) > 160*160 &&
			(client->ps.pm_flags & PMF_TIME_KNOCKBACK) == 0
		) {
			//client->ps.stats[STAT_GRAPPLE_STATE] = GST_pulling;
			SET_STAT_GRAPPLESTATE ( &client->ps, GST_pulling);
		}
		else {
			//client->ps.stats[STAT_GRAPPLE_STATE] = GST_silent;
			SET_STAT_GRAPPLESTATE ( &client->ps, GST_silent);
		}
		VectorCopy(client->hook->r.currentOrigin, client->ps.grapplePoint);
		client->ps.pm_flags |= PMF_GRAPPLE_PULL;
		goto CreateRope;
	}

	dt = msec / 1000.0;

	for (i = client->numRopeElements - 1; i >= 0; i--) {
		if (!ThinkRopeElement(client, i, 0, dt / 2)) {
			Weapon_HookFree(client->hook);
			return;
		}
	}

	VectorCopy(client->hook->r.currentOrigin, pullpoint);
	n = 0;
	for (i = 0; i < client->numRopeElements; i++) {
		if (!ThinkRopeElement(client, i, 1, dt / 2)) {
			Weapon_HookFree(client->hook);
			return;
		}
		if (client->ropeElements[i].touch) {
			VectorCopy(client->ropeElements[i].pos, pullpoint);
			n = i;
		}
	}

	VectorCopy(client->ropeElements[client->numRopeElements-1].pos, start);
	VectorSubtract(client->ps.origin, start, dir);
	dist = VectorNormalize(dir);

	if (client->hook->s.eType == ET_GRAPPLE) {
		// hook is attached to wall
		qboolean isRopeTaut;

		isRopeTaut = IsRopeTaut(ent, client->ropeIsTaut);
		client->ropeIsTaut = isRopeTaut;

		if (client->lastTimeWinded < level.time - 250) {
			// blocked
			//client->ps.stats[STAT_GRAPPLE_STATE] = GST_blocked;
			SET_STAT_GRAPPLESTATE ( &client->ps, GST_blocked);
			VectorCopy(pullpoint, client->ps.grapplePoint);
			client->ps.pm_flags |= PMF_GRAPPLE_PULL;

			{
				vec3_t v;
				float speed;

				v[0] = crandom();
				v[1] = crandom();
				v[2] = crandom();
				speed = 0.5 * ((level.time - client->lastTimeWinded) / 1000.0);
				if (speed > 2) speed = 2;
				VectorMA(client->ps.velocity, 400 * speed, v, client->ps.velocity);
			}
		}
		else if (isRopeTaut) {
			// pulling
			//client->ps.stats[STAT_GRAPPLE_STATE] = GST_pulling;
			SET_STAT_GRAPPLESTATE ( &client->ps, GST_pulling);
			VectorCopy(pullpoint, client->ps.grapplePoint);
			client->ps.pm_flags |= PMF_GRAPPLE_PULL;
		}
		else {
			// winding
			//client->ps.stats[STAT_GRAPPLE_STATE] = GST_rewind;
			SET_STAT_GRAPPLESTATE ( &client->ps, GST_rewind);
		}

		{
			TautRopePos(client, -1, NULL);
			for (i = 0; i < client->numRopeElements; i++) {
				ropeElement_t* re;
				vec3_t dest;
				vec3_t v;
				float f;

				re = &client->ropeElements[i];
				TautRopePos(client, i, dest);
				VectorSubtract(dest, re->pos, v);
				VectorScale(v, 16, v);
				f = (float)i / client->numRopeElements;
				VectorMA(v, Square(f), client->ps.velocity, v);

				VectorCopy(v, re->velocity);
			}
		}

		while (dist < ROPE_ELEMENT_SIZE) {
			trace_t trace;

			trap_Trace(&trace, start, NULL, NULL, client->ps.origin, -1, CONTENTS_SOLID);
			if (trace.startsolid || trace.allsolid || trace.fraction < 1) {
				VectorCopy(pullpoint, client->ps.grapplePoint);
				client->ps.pm_flags |= PMF_GRAPPLE_PULL;
				//client->ps.stats[STAT_GRAPPLE_STATE] = GST_pulling;
				SET_STAT_GRAPPLESTATE ( &client->ps, GST_pulling);
				goto CreateRope;
			}

			client->lastTimeWinded = level.time;
			client->numRopeElements--;
			if (client->numRopeElements <= 0) {

				goto CreateRope;
			}

			VectorCopy(client->ropeElements[client->numRopeElements-1].pos, start);
			dist = Distance(start, client->ps.origin);
		}
	}
	else {
		// hook is flying
		//client->ps.stats[STAT_GRAPPLE_STATE] = GST_windoff;
		SET_STAT_GRAPPLESTATE ( &client->ps, GST_windoff);
		client->ropeIsTaut = qfalse;
		client->lastTimeWinded = level.time;

		{
			vec3_t prevPos;

			VectorCopy(client->hook->r.currentOrigin, prevPos);
			for (i = 0; i <= client->numRopeElements; i++) {
				vec3_t dir;
				float dist;
				float maxdist;
				vec3_t destPos;

				if (i < client->numRopeElements) {
					VectorCopy(client->ropeElements[i].pos, destPos);
					maxdist = 1.7 * ROPE_ELEMENT_SIZE;
				}
				else {
					VectorCopy(client->ps.origin, destPos);
					maxdist = 1.2 * ROPE_ELEMENT_SIZE;
				}

				VectorSubtract(destPos, prevPos, dir);
				dist = VectorLength(dir);
				if (dist > maxdist) {
					int j;

					n = (int) ((dist - ROPE_ELEMENT_SIZE) / ROPE_ELEMENT_SIZE) + 1;
					for (j = 0; j < n; j++) {
						vec3_t pos;

						VectorMA(prevPos, (float)(j+1) / (n+1), dir, pos);
						if (!InsertRopeElement(client, i + j, pos)) {
							Weapon_HookFree(client->hook);
							return;
						}
					}
					i += n;
				}
				VectorCopy(destPos, prevPos);
			}
		}
	}

	CreateRope:

	dist = Distance(client->ps.origin, client->hook->r.currentOrigin);
	if (dist < 200) {
		if (dist < 40) dist = 40;
		pullSpeed *= dist / 200;
	}
	client->ps.stats[STAT_GRAPPLE_SPEED] = pullSpeed;

	CreateGrappleRope(ent);
}

void BotTestSolid(vec3_t origin);

/*
==============
SendPendingPredictableEvents
==============
*/
void SendPendingPredictableEvents( playerState_t *ps ) {
	gentity_t *t;
	int event, seq;
	int extEvent, number;

	// if there are still events pending
	if ( ps->entityEventSequence < ps->eventSequence ) {
		// create a temporary entity for this event which is sent to everyone
		// except the client who generated the event
		seq = ps->entityEventSequence & (MAX_PS_EVENTS-1);
		event = ps->events[ seq ] | ( ( ps->entityEventSequence & 3 ) << 8 );
		// set external event to zero before calling BG_PlayerStateToEntityState
		extEvent = ps->externalEvent;
		ps->externalEvent = 0;
		// create temporary entity for event
		t = G_TempEntity( ps->origin, event );
		number = t->s.number;
		BG_PlayerStateToEntityState( ps, &t->s, qtrue );
		t->s.number = number;
		t->s.eType = ET_EVENTS + event;
		t->s.eFlags |= EF_PLAYER_EVENT;
		t->s.otherEntityNum = ps->clientNum;
		// send to everyone except the client who generated the event
		t->r.svFlags |= SVF_NOTSINGLECLIENT;
		t->r.singleClient = ps->clientNum;
		// set back external event
		ps->externalEvent = extEvent;
	}
}

/*
==============
ClientThink

This will be called once for each client frame, which will
usually be a couple times for each server frame on fast clients.

If "g_synchronousClients 1" is set, this will be called exactly
once for each server frame, which makes for smooth demo recording.
==============
*/
void ClientThink_real( gentity_t *ent ) {
	gclient_t	*client;
	pmove_t		pm;
	int			oldEventSequence;
	int			msec;
	usercmd_t	*ucmd;

	client = ent->client;

	//G_Printf("client at %f %f %f\n", client->ps.origin[0], client->ps.origin[1], client->ps.origin[2]);	// JUHOX DEBUG
	// don't think if the client is not yet connected (and thus not yet spawned in)
	if (client->pers.connected != CON_CONNECTED) {
		return;
	}
	// mark the time, so the connection sprite can be removed
	ucmd = &ent->client->pers.cmd;

	// sanity check the command time to prevent speedup cheating
	if ( ucmd->serverTime > level.time + 200 ) {
		ucmd->serverTime = level.time + 200;
	}
	if ( ucmd->serverTime < level.time - 1000 ) {
		ucmd->serverTime = level.time - 1000;
	}

	msec = ucmd->serverTime - client->ps.commandTime;
	// following others may result in bad times, but we still want
	// to check for follow toggles
	if ( msec < 1 && client->sess.spectatorState != SPECTATOR_FOLLOW ) {
		return;
	}
	if ( msec > 200 ) {
		msec = 200;
	}

	if ( pmove_msec.integer < 8 ) {
		trap_Cvar_Set("pmove_msec", "8");
	}
	else if (pmove_msec.integer > 33) {
		trap_Cvar_Set("pmove_msec", "33");
	}

	if ( pmove_fixed.integer || client->pers.pmoveFixed ) {
		ucmd->serverTime = ((ucmd->serverTime + pmove_msec.integer-1) / pmove_msec.integer) * pmove_msec.integer;
	}

	//
	// check for exiting intermission
	//
	if ( level.intermissiontime ) {
		ClientIntermissionThink( client );
		return;
	}

#if MEETING
	if (level.meeting) {
		client->ps.pm_type = PM_MEETING;
		ClientIntermissionThink(client);
		return;
	}
#endif

	// spectators don't do much
	if ( client->sess.sessionTeam == TEAM_SPECTATOR ) {
		if ( client->sess.spectatorState == SPECTATOR_SCOREBOARD ) {
			return;
		}
		SpectatorThink( ent, ucmd );
		return;
	}

	// check for inactivity timer, but never drop the local client of a non-dedicated server
	if ( !ClientInactivityTimer( client ) ) {
		return;
	}

	// clear the rewards if time
	if ( level.time > client->rewardTime ) {
		client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
	}

	if (level.time >= ent->s.time) ent->s.time = 0;	// JUHOX

	// JUHOX: set "player is fighting" flag
	ent->s.modelindex &= ~PFMI_FIGHTING;
	if (IsPlayerInvolvedInFighting(ent->s.number)) {
		ent->s.modelindex |= PFMI_FIGHTING;
	}

	if ( client->noclip ) {
		client->ps.pm_type = PM_NOCLIP;
	} else if ( client->ps.stats[STAT_HEALTH] <= 0 ) {
		client->ps.pm_type = PM_DEAD;
        // JUHOX: let dead players spectate
		if (
			level.time >= client->respawnTime &&

			(
				// don't spectate in STU when the respawn delay is over
				level.time < client->respawnTime + client->respawnDelay ||
				g_gametype.integer < GT_STU
			) &&

			client->corpseProduced &&
			!(ent->r.svFlags & SVF_BOT)
		) {
			client->ps.pm_type = PM_SPECTATOR;
		}

	// JUHOX: let mission leaders in safety mode spectate
	} else if (client->tssSafetyMode) {
		client->ps.pm_type = PM_SPECTATOR;
	} else {
		client->ps.pm_type = PM_NORMAL;
	}

	client->ps.gravity = g_gravity.value;

	// set speed
	client->ps.speed = g_speed.value;

	// JUHOX: paralysation
	if (level.time < client->paralysationTime) {
		client->ps.speed = 0.25 * client->ps.speed;
	}

	// JUHOX: gauntlet attack speed up
	if (client->ps.stats[STAT_HEALTH] > 0 && client->ps.weapon == WP_GAUNTLET) {
		if (
			(ucmd->buttons & BUTTON_ATTACK) &&
			!(ucmd->buttons & BUTTON_WALKING) &&
			!(client->ps.pm_flags & PMF_DUCKED) &&
			client->ps.stats[STAT_TARGET] >= 0
		) {
			client->ps.speed = client->ps.speed * 1.2;
		}
	}

	CheckPlayerDischarge(ent);	// JUHOX

	ThinkGrapple(ent, msec);

	// set up for pmove
	oldEventSequence = client->ps.eventSequence;

	memset (&pm, 0, sizeof(pm));

	// check for the hit-scan gauntlet, don't let the action
	// go through as an attack unless it actually hits something
	if ( client->ps.weapon == WP_GAUNTLET && !( ucmd->buttons & BUTTON_TALK ) &&
		( ucmd->buttons & BUTTON_ATTACK ) && client->ps.weaponTime <= 0 ) {
		pm.gauntletHit = CheckGauntletAttack( ent );
	}

	if ( ent->flags & FL_FORCE_GESTURE ) {
		ent->flags &= ~FL_FORCE_GESTURE;
		ent->client->pers.cmd.buttons |= BUTTON_GESTURE;
	}

	pm.ps = &client->ps;
	pm.cmd = *ucmd;
	if ( pm.ps->pm_type == PM_DEAD ) {
		pm.tracemask = MASK_PLAYERSOLID & ~CONTENTS_BODY;
	}
	// JUHOX: let mission leaders in safety mode spectate
	else if (client->tssSafetyMode) {
		pm.tracemask = MASK_PLAYERSOLID & ~CONTENTS_BODY;
	}

	// JUHOX: unspawned player don't touch other players
	else if (pm.ps->pm_type == PM_SPECTATOR) {
		pm.tracemask = MASK_PLAYERSOLID & ~CONTENTS_BODY;
	}
	else if ( ent->r.svFlags & SVF_BOT ) {
		pm.tracemask = MASK_PLAYERSOLID | CONTENTS_BOTCLIP;
	}
	else {
		pm.tracemask = MASK_PLAYERSOLID;
	}
	pm.trace = trap_Trace;
	pm.pointcontents = trap_PointContents;
	pm.debugLevel = g_debugMove.integer;
	pm.noFootsteps = ( g_dmflags.integer & DF_NO_FOOTSTEPS ) > 0;
	pm.hookMode = g_grapple.integer;

	pm.pmove_fixed = qtrue;
	pm.pmove_msec = 10000;

	VectorCopy( client->ps.origin, client->oldOrigin );

	VectorCopy(ent->s.origin2, pm.target);	// JUHOX: origin2 set in SetTargetPos()

	// JUHOX: set player scale factor for normal player
	pm.scale = 1;

	pm.gametype = g_gametype.integer;	// JUHOX

		Pmove (&pm);

	// JUHOX: restore strength if stamina not used
	if (!g_stamina.integer) {
		client->ps.stats[STAT_STRENGTH] = MAX_STRENGTH_VALUE;
	}

	// JUHOX: check weapon usage
	if (client->ps.weaponstate >= WEAPON_FIRING) {
		client->weaponUsageTime = level.time;

		// check weapon limit
		if (
			g_weaponLimit.integer > 0 &&
			client->pers.numChoosenWeapons < g_weaponLimit.integer &&
			client->ps.stats[STAT_HEALTH] > 0 &&
			client->ps.weapon != WP_GRAPPLING_HOOK
		) {
			int i;

			for (i = 0; i < client->pers.numChoosenWeapons; i++) {
				if (client->pers.choosenWeapons[i] == client->ps.weapon) break;
			}
			if (i >= client->pers.numChoosenWeapons) {
				char buf[MAX_CLIENTS+4];

				// add weapon
				client->pers.choosenWeapons[client->pers.numChoosenWeapons++] = client->ps.weapon;

				if (client->pers.numChoosenWeapons >= g_weaponLimit.integer) {
					// restrict to choosen weapons
					client->ps.stats[STAT_WEAPONS] &= 1 << WP_GRAPPLING_HOOK;
					for (i = 0; i < client->pers.numChoosenWeapons; i++) {
						client->ps.stats[STAT_WEAPONS] |= 1 << client->pers.choosenWeapons[i];
					}
				}

				// send new weapon info
				for (i = 0; i < MAX_CLIENTS; i++) {
					buf[i] = level.clients[i].pers.numChoosenWeapons + 'A';
				}
				buf[i] = 0;
				trap_SetConfigstring(CS_CHOOSENWEAPONS, buf);
			}
		}
	}

	// JUHOX: check grapple usage
	//if (client->hook && client->ps.stats[STAT_GRAPPLE_STATE] != GST_silent ) {
	if ( client->hook && GET_STAT_GRAPPLESTATE (&client->ps) != GST_silent ) {
		client->grappleUsageTime = level.time;
	}

	// JUHOX: switch cloaking
	if (
		g_cloakingDevice.integer &&
		client->weaponUsageTime < level.time - 3000 &&
		client->grappleUsageTime < level.time - 3000
	) {
		if (!client->ps.powerups[PW_INVIS]) {
			//client->ps.stats[STAT_EFFECT] = PE_fade_out;
			SET_STAT_EFFECT(&client->ps, PE_fade_out);

			client->ps.powerups[PW_EFFECT_TIME] = level.time + SPAWNHULL_TIME;
		}
		client->ps.powerups[PW_INVIS] = level.time + 1000000000;
	}
	else {
		if (client->ps.powerups[PW_INVIS]) {
			int endTime;

			//client->ps.stats[STAT_EFFECT] = PE_fade_in;
			SET_STAT_EFFECT(&client->ps, PE_fade_in);
			endTime = level.time + SPAWNHULL_TIME;
			if (client->ps.powerups[PW_EFFECT_TIME] > level.time) {
				int startTime;
				int timePassed;

				startTime = client->ps.powerups[PW_EFFECT_TIME] - SPAWNHULL_TIME;
				timePassed = level.time - startTime;
				endTime = level.time + timePassed;
			}
			client->ps.powerups[PW_EFFECT_TIME] = endTime;
		}
		client->ps.powerups[PW_INVIS] = 0;
		client->ps.powerups[PW_BATTLESUIT] = 0;
	}

	// JUHOX: set weapon target
	switch (client->ps.weapon) {
	case WP_GAUNTLET:
		GetGauntletTarget(ent);
		break;
	case WP_LIGHTNING:
		if (
			!(client->ps.eFlags & EF_FIRING) &&
			client->ps.stats[STAT_HEALTH] <= 0
		) {
			client->ps.stats[STAT_TARGET] = -1;
		}
		// target searching done when weapon fires in Weapon_LightningFire()
		break;
	default:
		client->ps.stats[STAT_TARGET] = -1;
		break;
	}

	// save results of pmove
	if ( ent->client->ps.eventSequence != oldEventSequence ) {
		ent->eventTime = level.time;
	}
	if (g_smoothClients.integer) {
		BG_PlayerStateToEntityStateExtraPolate( &ent->client->ps, &ent->s, ent->client->ps.commandTime, qtrue );
	}
	else {
		BG_PlayerStateToEntityState( &ent->client->ps, &ent->s, qtrue );
	}
	SendPendingPredictableEvents( &ent->client->ps );

	if ( !( ent->client->ps.eFlags & EF_FIRING ) ) {
		client->fireHeld = qfalse; // for grapple
	}

	// use the snapped origin for linking so it matches client predicted versions
	VectorCopy( ent->s.pos.trBase, ent->r.currentOrigin );

	VectorCopy (pm.mins, ent->r.mins);
	VectorCopy (pm.maxs, ent->r.maxs);

	ent->waterlevel = pm.waterlevel;
	ent->watertype = pm.watertype;

	// execute client events
	ClientEvents( ent, oldEventSequence );
	CauseChargeDamage(ent);	// JUHOX

	// link entity now, after any personal teleporters have been used
	// JUHOX: spectators don't get linked
	if (client->ps.pm_type != PM_SPECTATOR) {
		trap_LinkEntity(ent);
	}
	else {
		trap_UnlinkEntity(ent);
	}

	if ( !ent->client->noclip ) {
		G_TouchTriggers( ent );
	}

	// NOTE: now copy the exact origin over otherwise clients can be snapped into solid
	VectorCopy( ent->client->ps.origin, ent->r.currentOrigin );

	//test for solid areas in the AAS file
	BotTestAAS(ent->r.currentOrigin);

	// touch other objects
	ClientImpacts( ent, &pm );

	// save results of triggers and client events
	if (ent->client->ps.eventSequence != oldEventSequence) {
		ent->eventTime = level.time;
	}

	// swap and latch button actions
	client->oldbuttons = client->buttons;
	client->buttons = ucmd->buttons;
	client->latched_buttons |= client->buttons & ~client->oldbuttons;

	// JUHOX: compute artefact detector value
	if (
		g_gametype.integer == GT_STU &&
		client->ps.stats[STAT_HEALTH] > 0 &&
		!level.intermissiontime &&
		level.artefact &&
		!(level.artefact->s.eFlags & EF_NODRAW) &&
		level.endPhase <= 0
	) {
		vec_t dist;

		dist = Distance(client->ps.origin, level.artefact->s.pos.trBase);
		if (dist >= 3000) dist = -1;
		else if (dist < 100) dist = 100;
		client->ps.stats[STAT_DETECTOR] = (int) dist;
	}
	else {
		client->ps.stats[STAT_DETECTOR] = -1;
	}

	// check for respawning
	if ( client->ps.stats[STAT_HEALTH] <= 0 ) {
        // JUHOX: replace STAT_DEAD_YAW
		client->ps.viewangles[YAW] = client->deadYaw;

#if !RESPAWN_DELAY	// JUHOX: check for automatic respawn
		// wait for the attack button to be pressed
		if ( level.time > client->respawnTime ) {
			// forcerespawn is to prevent users from waiting out powerups
			if ( g_forcerespawn.integer > 0 &&
				( level.time - client->respawnTime ) > g_forcerespawn.integer * 1000 ) {
				respawn( ent );
				return;
			}

			// pressing attack or use is the normal respawn method
			if ( ucmd->buttons & ( BUTTON_ATTACK | BUTTON_USE_HOLDABLE ) ) {
				respawn( ent );
			}
		}
#else
		if (level.time < client->respawnTime) {
			client->ps.stats[STAT_RESPAWN_INFO] = -1;	// RLT_invalid
		}
		else {
			if (!client->corpseProduced) {
				vec3_t angles;

				CopyToBodyQue(ent);
				ent->s.eFlags |= EF_NODRAW;
				ent->client->ps.eFlags |= EF_NODRAW;
				ent->takedamage = qfalse;
				//SetSpectatorPos(ent);
				angles[ROLL] = 0;
				angles[PITCH] = -15;
				//angles[YAW] = client->ps.stats[STAT_DEAD_YAW];
				angles[YAW] = client->deadYaw;
				SetClientViewAngle(ent, angles);
				client->ps.stats[STAT_PANT_PHASE] = rand();
			}

			client->ps.stats[STAT_RESPAWN_INFO] = GetRespawnLocationType(ent, msec);

			if (client->podMarker && level.time > client->podMarker->s.time + 1000) {
				G_FreeEntity(client->podMarker);
				client->podMarker = NULL;
				client->mayRespawnAtDeathOrigin = qfalse;
			}

			if (level.time < client->respawnTime + client->respawnDelay) {
				client->ps.stats[STAT_RESPAWN_INFO] += (
					(
						(client->respawnTime + client->respawnDelay - level.time + 1000) / 1000
					) << 2
				);
			}
			else {
				//client->ps.stats[STAT_RESPAWN_TIMER] = 0;
				if (
					(ucmd->buttons & (BUTTON_ATTACK | BUTTON_USE_HOLDABLE)) ||
					client->respawnDelay < 0	// set by ForceRespawn()
				) {
					respawn(ent);
				}
			}
		}
#endif
		return;
	}

	ClientRefreshAmmo(ent, msec);	// JUHOX

	// JUHOX: randomize pant phase, so players don't breathe in sync
	if (client->ps.stats[STAT_STRENGTH] > 2.5*LOW_STRENGTH_VALUE) {
		client->ps.stats[STAT_PANT_PHASE] = rand();
	}

	// JUHOX: handle pending view toggles
	if (client->viewMode < 0) {
		// init viewmode
		client->viewMode = 0;
		client->viewModeSwitchTime = level.time;
		trap_SendServerCommand(ent->s.clientNum, "viewmode 0");
	}

	if (
		client->numPendingViewToggles > 0 &&
		level.time >= client->viewModeSwitchTime + VIEWMODE_SWITCHING_TIME
	) {
		client->viewMode++;
		if (client->viewMode >= VIEW_num_modes) {
			client->viewMode = 0;
		}
		client->viewModeSwitchTime = level.time;
		trap_SendServerCommand(ent->s.clientNum, va("viewmode %d", client->viewMode));
		client->numPendingViewToggles--;
	}

	// perform once-a-second actions
	ClientTimerActions( ent, msec );
}

/*
==================
ClientThink

A new command has arrived from the client
==================
*/
void ClientThink( int clientNum ) {
	gentity_t *ent;

	ent = g_entities + clientNum;
	trap_GetUsercmd( clientNum, &ent->client->pers.cmd );

	// mark the time we got info, so we can display the
	// phone jack if they don't get any for a while
	ent->client->lastCmdTime = level.time;

	if ( !(ent->r.svFlags & SVF_BOT) && !g_synchronousClients.integer ) {
		ClientThink_real( ent );
	}
}


void G_RunClient( gentity_t *ent ) {
	if ( !(ent->r.svFlags & SVF_BOT) && !g_synchronousClients.integer ) {
		return;
	}
	ent->client->pers.cmd.serverTime = level.time;
	ClientThink_real( ent );
}


/*
==================
SpectatorClientEndFrame

==================
*/
void SpectatorClientEndFrame( gentity_t *ent ) {
	gclient_t	*cl;

	// if we are doing a chase cam or a remote view, grab the latest info
	if ( ent->client->sess.spectatorState == SPECTATOR_FOLLOW ) {
		int		clientNum, flags;

		clientNum = ent->client->sess.spectatorClient;

		// team follow1 and team follow2 go to whatever clients are playing
		if ( clientNum == -1 ) {
			clientNum = level.follow1;
		} else if ( clientNum == -2 ) {
			clientNum = level.follow2;
		}
		if ( clientNum >= 0 ) {
			cl = &level.clients[ clientNum ];
			if ( cl->pers.connected == CON_CONNECTED && cl->sess.sessionTeam != TEAM_SPECTATOR ) {
				flags = (cl->ps.eFlags & ~(EF_VOTED | EF_TEAMVOTED)) | (ent->client->ps.eFlags & (EF_VOTED | EF_TEAMVOTED));
				ent->client->ps = cl->ps;
				ent->client->ps.pm_flags |= PMF_FOLLOW;
				ent->client->ps.eFlags = flags;
				return;
			} else {
				// drop them to free spectators unless they are dedicated camera followers
				if ( ent->client->sess.spectatorClient >= 0 ) {
					ent->client->sess.spectatorState = SPECTATOR_FREE;
					ClientBegin( ent->client - level.clients );
				}
			}
		}
	}

	if ( ent->client->sess.spectatorState == SPECTATOR_SCOREBOARD ) {
		ent->client->ps.pm_flags |= PMF_SCOREBOARD;
	} else {
		ent->client->ps.pm_flags &= ~PMF_SCOREBOARD;
	}
}

/*
==============
ClientEndFrame

Called at the end of each server frame for each connected client
A fast client will have multiple ClientThink for each ClientEdFrame,
while a slow client may have multiple ClientEndFrame between ClientThink.
==============
*/
void ClientEndFrame( gentity_t *ent ) {
	int			i;
	clientPersistant_t	*pers;

	if ( ent->client->sess.sessionTeam == TEAM_SPECTATOR ) {
		SpectatorClientEndFrame( ent );
		return;
	}

	pers = &ent->client->pers;

	// turn off any expired powerups
	for ( i = 0 ; i < PW_NUM_POWERUPS ; i++ ) {	// JUHOX
		if ( ent->client->ps.powerups[ i ] < level.time ) {
			ent->client->ps.powerups[ i ] = 0;
		}
	}
	// JUHOX: turn off expired PW_EFFECT_TIME
	if (ent->client->ps.powerups[PW_EFFECT_TIME] < level.time) {
		ent->client->ps.powerups[PW_EFFECT_TIME] = 0;
	}


	//
	// If the end of unit layout is displayed, don't give
	// the player any normal movement attributes
	//
	if ( level.intermissiontime ) {
		return;
	}

	// burn from lava, etc
	P_WorldEffects (ent);

	// apply all the damage taken this frame
	P_DamageFeedback (ent);

	// add the EF_CONNECTION flag if we haven't gotten commands recently
	if ( level.time - ent->client->lastCmdTime > 1000 ) {
		ent->s.eFlags |= EF_CONNECTION;
	} else {
		ent->s.eFlags &= ~EF_CONNECTION;
	}

	ent->client->ps.stats[STAT_HEALTH] = ent->health;	// FIXME: get rid of ent->health...

	G_SetClientSound (ent);

	// set the latest infor
	if (g_smoothClients.integer) {
		BG_PlayerStateToEntityStateExtraPolate( &ent->client->ps, &ent->s, ent->client->ps.commandTime, qtrue );
	}
	else {
		BG_PlayerStateToEntityState( &ent->client->ps, &ent->s, qtrue );
	}
	SendPendingPredictableEvents( &ent->client->ps );
}
