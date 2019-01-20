export IsPlayerInvolvedInFighting
code
proc IsPlayerInvolvedInFighting 4 8
file "..\..\..\..\code\game\g_active.c"
line 30
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:
;4:#include "g_local.h"
;5:#include "inv.h"	// JUHOX: for MODELINDEX_INVISIBILITY
;6:
;7:// JUHOX: includes needed for AI access
;8:#if 1
;9:#include "botlib.h"
;10:#include "be_aas.h"
;11:#include "be_ea.h"
;12:#include "be_ai_char.h"
;13:#include "be_ai_chat.h"
;14:#include "be_ai_gen.h"
;15:#include "be_ai_goal.h"
;16:#include "be_ai_move.h"
;17:#include "be_ai_weap.h"
;18://
;19:#include "ai_main.h"
;20:#include "ai_dmq3.h"
;21:#include "ai_team.h"
;22:#endif
;23:
;24:
;25:/*
;26:=================
;27:JUHOX: IsPlayerInvolvedInFighting
;28:=================
;29:*/
;30:qboolean IsPlayerInvolvedInFighting(int clientNum) {
line 31
;31:	if (clientNum < 0 || clientNum >= MAX_CLIENTS) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $95
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $93
LABELV $95
line 32
;32:		G_Error("BUG! IsPlayerInvolvedInFighting: clientNum=%d\n", clientNum);
ADDRGP4 $96
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 G_Error
CALLV
pop
line 33
;33:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $92
JUMPV
LABELV $93
line 36
;34:	}
;35:
;36:	if (g_entities[clientNum].health <= 0) return qfalse;
ADDRFP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+736
ADDP4
INDIRI4
CNSTI4 0
GTI4 $97
CNSTI4 0
RETI4
ADDRGP4 $92
JUMPV
LABELV $97
line 37
;37:	if (level.clients[clientNum].ps.powerups[PW_SHIELD]) return qfalse;
ADDRFP4 0
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 356
ADDP4
INDIRI4
CNSTI4 0
EQI4 $100
CNSTI4 0
RETI4
ADDRGP4 $92
JUMPV
LABELV $100
line 39
;38:
;39:	if (level.clients[clientNum].weaponUsageTime > level.time - 3000) return qtrue;
ADDRFP4 0
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 860
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 3000
SUBI4
LEI4 $102
CNSTI4 1
RETI4
ADDRGP4 $92
JUMPV
LABELV $102
line 40
;40:	if (level.clients[clientNum].lasthurt_time > level.time - 3000) return qtrue;
ADDRFP4 0
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 828
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 3000
SUBI4
LEI4 $105
CNSTI4 1
RETI4
ADDRGP4 $92
JUMPV
LABELV $105
line 42
;41:
;42:	return qfalse;
CNSTI4 0
RETI4
LABELV $92
endproc IsPlayerInvolvedInFighting 4 8
export NearHomeBase
proc NearHomeBase 28 8
line 50
;43:}
;44:
;45:/*
;46:=================
;47:JUHOX: NearHomeBase
;48:=================
;49:*/
;50:qboolean NearHomeBase(int team, const vec3_t pos, float homeWeightSquared) {
line 51
;51:	if (g_gametype.integer < GT_CTF) return qfalse;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
GEI4 $109
CNSTI4 0
RETI4
ADDRGP4 $108
JUMPV
LABELV $109
line 53
;52:#if MONSTER_MODE
;53:	if (g_gametype.integer >= GT_STU) return qfalse;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
LTI4 $112
CNSTI4 0
RETI4
ADDRGP4 $108
JUMPV
LABELV $112
line 55
;54:#endif
;55:	switch (team) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $117
ADDRLP4 0
INDIRI4
CNSTI4 2
EQI4 $121
ADDRGP4 $115
JUMPV
LABELV $117
line 57
;56:	case TEAM_RED:
;57:		return homeWeightSquared * DistanceSquared(pos, ctf_redflag.origin) < DistanceSquared(pos, ctf_blueflag.origin);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 ctf_redflag
ARGP4
ADDRLP4 8
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
ADDRLP4 12
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRFP4 8
INDIRF4
ADDRLP4 8
INDIRF4
MULF4
ADDRLP4 12
INDIRF4
GEF4 $119
ADDRLP4 4
CNSTI4 1
ASGNI4
ADDRGP4 $120
JUMPV
LABELV $119
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $120
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $108
JUMPV
LABELV $121
line 59
;58:	case TEAM_BLUE:
;59:		return homeWeightSquared * DistanceSquared(pos, ctf_blueflag.origin) < DistanceSquared(pos, ctf_redflag.origin);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
ADDRLP4 20
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 ctf_redflag
ARGP4
ADDRLP4 24
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRFP4 8
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDRLP4 24
INDIRF4
GEF4 $123
ADDRLP4 16
CNSTI4 1
ASGNI4
ADDRGP4 $124
JUMPV
LABELV $123
ADDRLP4 16
CNSTI4 0
ASGNI4
LABELV $124
ADDRLP4 16
INDIRI4
RETI4
ADDRGP4 $108
JUMPV
LABELV $115
line 61
;60:	}
;61:	return qfalse;
CNSTI4 0
RETI4
LABELV $108
endproc NearHomeBase 28 8
proc TSS_Proportion_RoundToCeil 4 0
line 69
;62:}
;63:
;64:/*
;65:=================
;66:JUHOX: TSS_Proportion_RoundToCeil
;67:=================
;68:*/
;69:static int TSS_Proportion_RoundToCeil(int portion, int total, int newTotal) {
line 70
;70:	if (total == 0) return 0;
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $126
CNSTI4 0
RETI4
ADDRGP4 $125
JUMPV
LABELV $126
line 71
;71:	return (portion * newTotal + total - 1) / total;
ADDRLP4 0
ADDRFP4 4
INDIRI4
ASGNI4
ADDRFP4 0
INDIRI4
ADDRFP4 8
INDIRI4
MULI4
ADDRLP4 0
INDIRI4
ADDI4
CNSTI4 1
SUBI4
ADDRLP4 0
INDIRI4
DIVI4
RETI4
LABELV $125
endproc TSS_Proportion_RoundToCeil 4 0
export TSS_DangerIndex
proc TSS_DangerIndex 20 4
line 116
;72:}
;73:
;74:/*
;75:==================
;76:JUHOX: TSS_KillDamage
;77:
;78:returns the lowest damage that could kill the player
;79:==================
;80:*/
;81:/*
;82:int TSS_KillDamage(playerState_t* ps) {
;83:	int killDamage;
;84:	float pf;	// protection factor
;85:
;86:	pf = (1 - ARMOR_PROTECTION) / ARMOR_PROTECTION;	// currently 0.5
;87:	if (ps->stats[STAT_HEALTH] <= ps->stats[STAT_ARMOR] * pf) {
;88:		killDamage = ps->stats[STAT_HEALTH] / (1 - ARMOR_PROTECTION);
;89:	}
;90:	else {
;91:		//killDamage = ps->stats[STAT_ARMOR] / ARMOR_PROTECTION + (ps->stats[STAT_HEALTH] - ps->stats[STAT_ARMOR] * pf);
;92:		killDamage = ps->stats[STAT_HEALTH] + ps->stats[STAT_ARMOR];	// computes the same as the formula above!
;93:	}
;94:	return killDamage;
;95:}
;96:*/
;97:
;98:/*
;99:==================
;100:JUHOX: TSS_DangerIndex
;101:
;102:danger == -100	... e.g. 100 health, 100 armor, no handicap, not shooting, not panting, not charged
;103:danger == 0		... e.g. health at handicap level, no armor, not shooting, not panting, not charged
;104:danger == 10	... e.g. health at handicap level, no armor, *shooting*, not panting, not charged
;105:danger == 20	... e.g. health at handicap level, no armor, not shooting, *completly exhausted*, not charged
;106:
;107:danger <= -100	... unstoppable!
;108:danger <= 0		... no danger
;109:danger >= 11	... light danger or worse
;110:danger >= 25	... moderate danger or worse
;111:danger >= 50	... high danger or worse
;112:danger >= 75	... extreme danger or worse
;113:danger >= 100	... as good as dead
;114:==================
;115:*/
;116:int TSS_DangerIndex(const playerState_t* ps) {
line 120
;117:	float maxDamage;
;118:	float danger;
;119:
;120:	if (ps->stats[STAT_HEALTH] <= 0) return 0;	// a dead player is not in danger
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $129
CNSTI4 0
RETI4
ADDRGP4 $128
JUMPV
LABELV $129
line 122
;121:
;122:	danger = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 123
;123:	maxDamage = BotPlayerKillDamage(ps);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BotPlayerKillDamage
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
CVIF4 4
ASGNF4
line 124
;124:	if (ps->powerups[PW_CHARGE]) {
ADDRFP4 0
INDIRP4
CNSTI4 352
ADDP4
INDIRI4
CNSTI4 0
EQI4 $131
line 127
;125:		float charge;
;126:
;127:		charge = (ps->powerups[PW_CHARGE] - level.time) / 1000.0F;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 352
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
SUBI4
CVIF4 4
CNSTF4 981668463
MULF4
ASGNF4
line 128
;128:		if (charge > 0.1F) {
ADDRLP4 12
INDIRF4
CNSTF4 1036831949
LEF4 $134
line 129
;129:			maxDamage -= TotalChargeDamage(charge);
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 16
ADDRGP4 TotalChargeDamage
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 16
INDIRF4
SUBF4
ASGNF4
line 130
;130:		}
LABELV $134
line 131
;131:	}
LABELV $131
line 132
;132:	danger += 100 - 100 * maxDamage / ps->stats[STAT_MAX_HEALTH];
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1120403456
ADDRLP4 4
INDIRF4
CNSTF4 1120403456
MULF4
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CVIF4 4
DIVF4
SUBF4
ADDF4
ASGNF4
line 139
;133:
;134:	/*
;135:	if (ps->eFlags & EF_FIRING) {
;136:		danger += 10;
;137:	}
;138:	*/
;139:	if (ps->stats[STAT_STRENGTH] < 2*LOW_STRENGTH_VALUE) {
ADDRFP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1169915904
GEF4 $136
line 140
;140:		danger += 20.0F * (1.0F - ps->stats[STAT_STRENGTH] / (2.0F*LOW_STRENGTH_VALUE));
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
ADDRFP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CVIF4 4
CNSTF4 959365950
MULF4
SUBF4
CNSTF4 1101004800
MULF4
ADDF4
ASGNF4
line 141
;141:	}
LABELV $136
line 142
;142:	return (int) danger;
ADDRLP4 0
INDIRF4
CVFI4 4
RETI4
LABELV $128
endproc TSS_DangerIndex 20 4
proc TSS_GameTypeCompatibleMission 8 0
line 227
;143:}
;144:
;145:#if 1	// JUHOX: definitions for TSS group assignment
;146:typedef enum {
;147:	TSSGAR_unreserved,
;148:	TSSGAR_bestDistance,
;149:	TSSGAR_constraint,
;150:	TSSGAR_flagCarrier,
;151:	TSSGAR_force
;152:} tss_groupAssignmentReservation_t;
;153:
;154:typedef struct tss_groupAssignment_s {
;155:	gclient_t* client;
;156:	int clientNum;
;157:	struct tss_groupInfo_s* oldGroup;
;158:	tss_groupMemberStatus_t oldGMS;
;159:	int oldTaskGoal;
;160:	struct tss_groupInfo_s* group;
;161:	tss_groupAssignmentReservation_t reservation;
;162:	qboolean isAlive;
;163:	qboolean isFighting;
;164:	int danger;
;165:} tss_groupAssignment_t;
;166:
;167:static tss_groupAssignment_t* tssFlagCarrier;
;168:static int tssNumGroupAssignments;
;169:static tss_groupAssignment_t tssGroupAssignments[MAX_CLIENTS];
;170:static int tssNumPlayersAlive;
;171:
;172:typedef struct tss_groupInfo_s {
;173:	int groupNum;
;174:	int rank;	// index into 'groupOrganization'
;175:	int designated1stLeader;	// client number or -1
;176:	int designated2ndLeader;	// client number or -1
;177:	int designated3rdLeader;	// client number or -1
;178:	tss_groupAssignment_t* oldLeader;	// may be NULL
;179:	tss_groupAssignment_t* currentLeader;	// may be NULL
;180:	vec_t leaderDistanceToGoal;
;181:	int totalPlayers;
;182:	int minTotalPlayers;
;183:	int alivePlayers;
;184:	int minAlivePlayers;
;185:	int readyPlayers;
;186:	int minReadyPlayers;
;187:	int maxDanger;
;188:	int maxGuardsPerVictim;
;189:	int minReadyForMission;
;190:	int minGroupSize;
;191:	tss_groupFormation_t groupFormation;
;192:	tss_mission_t mission;
;193:	tss_missionStatus_t missionStatus;
;194:	qboolean missionGoalAvailable;
;195:	bot_goal_t missionGoal;
;196:	qboolean protectFlagCarrier;		// initialized very late
;197:} tss_groupInfo_t;
;198:
;199:static tss_groupInfo_t tssGroupInfo[MAX_GROUPS];
;200:static bot_goal_t* tssHomeBase;		// for CTF
;201:static bot_goal_t* tssEnemyBase;	// for CTF
;202:#endif
;203:
;204:/*
;205:===============
;206:JUHOX: TSS_MayBeGroupLeader
;207:===============
;208:*/
;209:/*
;210:static qboolean TSS_MayBeGroupLeader(const tss_groupAssignment_t* ga, const tss_groupInfo_t* gi) {
;211:	if (!ga || !gi) {
;212:		G_Error("BUG! TSS_MayBeGroupLeader: ga=%d, gi=%d", (int)ga, (int)gi);
;213:		return qfalse;
;214:	}
;215:	if (ga == tssFlagCarrier) return qfalse;
;216:	if (!ga->isAlive) return qfalse;
;217:	if (ga->danger > gi->maxDanger) return qfalse;
;218:	return qtrue;
;219:}
;220:*/
;221:
;222:/*
;223:===============
;224:JUHOX: TSS_GameTypeCompatibleMission
;225:===============
;226:*/
;227:static tss_mission_t TSS_GameTypeCompatibleMission(tss_mission_t mission) {
line 228
;228:	if (g_gametype.integer == GT_CTF) return mission;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $140
ADDRFP4 0
INDIRI4
RETI4
ADDRGP4 $139
JUMPV
LABELV $140
line 230
;229:
;230:	switch (mission) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $144
ADDRLP4 0
INDIRI4
CNSTI4 6
GTI4 $144
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $149
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $149
address $146
address $146
address $146
address $147
address $148
address $148
address $147
code
LABELV $146
line 234
;231:	case TSSMISSION_invalid:
;232:	case TSSMISSION_seek_enemy:
;233:	case TSSMISSION_seek_items:
;234:		return mission;
ADDRFP4 0
INDIRI4
RETI4
ADDRGP4 $139
JUMPV
LABELV $147
line 237
;235:	case TSSMISSION_capture_enemy_flag:
;236:	case TSSMISSION_occupy_enemy_base:
;237:		return TSSMISSION_seek_enemy;
CNSTI4 1
RETI4
ADDRGP4 $139
JUMPV
LABELV $148
line 240
;238:	case TSSMISSION_defend_our_flag:
;239:	case TSSMISSION_defend_our_base:
;240:		return TSSMISSION_seek_items;
CNSTI4 2
RETI4
ADDRGP4 $139
JUMPV
line 242
;241:	default:
;242:		break;
LABELV $144
line 244
;243:	}
;244:	return TSSMISSION_seek_enemy;
CNSTI4 1
RETI4
LABELV $139
endproc TSS_GameTypeCompatibleMission 8 0
proc TSS_PlayerAlivePrediction 12 0
line 252
;245:}
;246:
;247:/*
;248:===============
;249:JUHOX: TSS_PlayerAlivePredition
;250:===============
;251:*/
;252:static void TSS_PlayerAlivePrediction(const gclient_t* client, const tss_serverdata_t* tss, float* amq, float* alq) {
line 253
;253:	if (client->ps.stats[STAT_HEALTH] > 0) {
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
LEI4 $151
line 254
;254:		*amq += 1.0;
ADDRLP4 0
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 255
;255:		*alq += 1.0;
ADDRLP4 4
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 256
;256:	}
ADDRGP4 $152
JUMPV
LABELV $151
line 257
;257:	else {
line 260
;258:		int remainingTime;
;259:
;260:		remainingTime = client->respawnTime + client->respawnDelay - level.time;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 832
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 836
ADDP4
INDIRI4
ADDI4
ADDRGP4 level+32
INDIRI4
SUBI4
ASGNI4
line 261
;261:		if (remainingTime < 0) remainingTime = 0;
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $154
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $154
line 263
;262:
;263:		if (remainingTime < tss->medium_term) {
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 648
ADDP4
INDIRI4
GEI4 $156
line 265
;264:			//*amq += 1.0 - (float)remainingTime / tss->medium_term;
;265:			*amq += 1.0;
ADDRLP4 8
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 266
;266:		}
LABELV $156
line 267
;267:		if (remainingTime < tss->long_term) {
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 652
ADDP4
INDIRI4
GEI4 $158
line 269
;268:			//*alq += 1.0 - (float)remainingTime / tss->long_term;
;269:			*alq += 1.0;
ADDRLP4 8
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 270
;270:		}
LABELV $158
line 271
;271:	}
LABELV $152
line 272
;272:}
LABELV $150
endproc TSS_PlayerAlivePrediction 12 0
proc TSS_InitGroupAssignments 104 16
line 279
;273:
;274:/*
;275:===============
;276:JUHOX: TSS_InitGroupAssignments
;277:===============
;278:*/
;279:static void TSS_InitGroupAssignments(tss_serverdata_t* tss) {
line 284
;280:	int gr, cl, as;
;281:	tss_groupInfo_t* gi;
;282:	tss_groupAssignment_t* ga;
;283:
;284:	tssNumGroupAssignments = 0;
ADDRGP4 tssNumGroupAssignments
CNSTI4 0
ASGNI4
line 285
;285:	tssFlagCarrier = NULL;
ADDRGP4 tssFlagCarrier
CNSTP4 0
ASGNP4
line 286
;286:	tssNumPlayersAlive = 0;
ADDRGP4 tssNumPlayersAlive
CNSTI4 0
ASGNI4
line 287
;287:	if (!tss->isValid) return;
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $161
ADDRGP4 $160
JUMPV
LABELV $161
line 289
;288:
;289:	memset(&tssGroupInfo, 0, sizeof(tssGroupInfo));
ADDRGP4 tssGroupInfo
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1480
ARGI4
ADDRGP4 memset
CALLP4
pop
line 290
;290:	for (gr = 0; gr < MAX_GROUPS; gr++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $163
line 293
;291:		int grp;
;292:
;293:		grp = tss->instructions.groupOrganization[gr];
ADDRLP4 20
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDP4
INDIRU1
CVUI4 1
ASGNI4
line 294
;294:		gi = &tssGroupInfo[grp];
ADDRLP4 0
ADDRLP4 20
INDIRI4
CNSTI4 148
MULI4
ADDRGP4 tssGroupInfo
ADDP4
ASGNP4
line 295
;295:		gi->groupNum = grp;
ADDRLP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ASGNI4
line 296
;296:		gi->rank = gr;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 297
;297:		gi->maxDanger = tss->instructions.orders.order[grp].maxDanger;
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
ADDRLP4 20
INDIRI4
CNSTI4 20
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
ADDP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 298
;298:		gi->maxGuardsPerVictim = tss->instructions.orders.order[grp].maxGuards;
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
ADDRLP4 20
INDIRI4
CNSTI4 20
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
ADDP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 299
;299:		gi->designated1stLeader = tss->designated1stLeaders[grp];
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 20
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 356
ADDP4
ADDP4
INDIRI4
ASGNI4
line 300
;300:		gi->designated2ndLeader = tss->designated2ndLeaders[grp];
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 20
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 396
ADDP4
ADDP4
INDIRI4
ASGNI4
line 301
;301:		gi->designated3rdLeader = tss->designated3rdLeaders[grp];
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 20
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
ADDP4
INDIRI4
ASGNI4
line 302
;302:		gi->leaderDistanceToGoal = 1000000000.0;
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 1315859240
ASGNF4
line 303
;303:		gi->groupFormation = tss->groupFormation[grp];
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
ADDRLP4 20
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
ADDP4
INDIRI4
ASGNI4
line 304
;304:		gi->mission = TSS_GameTypeCompatibleMission(tss->instructions.orders.order[grp].mission);
ADDRLP4 20
INDIRI4
CNSTI4 20
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 TSS_GameTypeCompatibleMission
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
ADDRLP4 24
INDIRI4
ASGNI4
line 305
;305:		gi->missionStatus = tss->missionStatus[grp];
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 20
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 556
ADDP4
ADDP4
INDIRI4
ASGNI4
line 306
;306:		gi->protectFlagCarrier = tss->protectFlagCarrier[grp];
ADDRLP4 0
INDIRP4
CNSTI4 144
ADDP4
ADDRLP4 20
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 596
ADDP4
ADDP4
INDIRI4
ASGNI4
line 308
;307:
;308:		switch (gi->mission) {
ADDRLP4 28
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
LTI4 $167
ADDRLP4 28
INDIRI4
CNSTI4 6
GTI4 $167
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $185
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $185
address $170
address $170
address $170
address $171
address $172
address $173
address $179
code
LABELV $170
LABELV $167
line 313
;309:		case TSSMISSION_invalid:
;310:		case TSSMISSION_seek_enemy:
;311:		case TSSMISSION_seek_items:
;312:		default:
;313:			gi->missionGoalAvailable = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
CNSTI4 0
ASGNI4
line 315
;314:			// NOTE: if there's a group leader, the goal will be specified later in this function
;315:			break;
ADDRGP4 $168
JUMPV
LABELV $171
line 317
;316:		case TSSMISSION_capture_enemy_flag:
;317:			gi->missionGoalAvailable = LocateFlag(OtherTeam(tss->team), &gi->missionGoal);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 OtherTeam
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 88
ADDP4
ARGP4
ADDRLP4 40
ADDRGP4 LocateFlag
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
ADDRLP4 40
INDIRI4
ASGNI4
line 318
;318:			break;
ADDRGP4 $168
JUMPV
LABELV $172
line 320
;319:		case TSSMISSION_defend_our_flag:
;320:			gi->missionGoalAvailable = LocateFlag(tss->team, &gi->missionGoal);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 88
ADDP4
ARGP4
ADDRLP4 48
ADDRGP4 LocateFlag
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
ADDRLP4 48
INDIRI4
ASGNI4
line 321
;321:			break;
ADDRGP4 $168
JUMPV
LABELV $173
line 323
;322:		case TSSMISSION_defend_our_base:
;323:			switch (tss->team) {
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 1
EQI4 $177
ADDRLP4 52
INDIRI4
CNSTI4 2
EQI4 $178
ADDRGP4 $174
JUMPV
LABELV $177
line 325
;324:			case TEAM_RED:
;325:				memcpy(&gi->missionGoal, &ctf_redflag, sizeof(bot_goal_t));
ADDRLP4 0
INDIRP4
CNSTI4 88
ADDP4
ARGP4
ADDRGP4 ctf_redflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 326
;326:				gi->missionGoalAvailable = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
CNSTI4 1
ASGNI4
line 327
;327:				break;
ADDRGP4 $168
JUMPV
LABELV $178
line 329
;328:			case TEAM_BLUE:
;329:				memcpy(&gi->missionGoal, &ctf_blueflag, sizeof(bot_goal_t));
ADDRLP4 0
INDIRP4
CNSTI4 88
ADDP4
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 330
;330:				gi->missionGoalAvailable = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
CNSTI4 1
ASGNI4
line 331
;331:				break;
ADDRGP4 $168
JUMPV
LABELV $174
line 333
;332:			default:
;333:				gi->missionGoalAvailable = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
CNSTI4 0
ASGNI4
line 334
;334:				break;
line 336
;335:			}
;336:			break;
ADDRGP4 $168
JUMPV
LABELV $179
line 338
;337:		case TSSMISSION_occupy_enemy_base:
;338:			switch (tss->team) {
ADDRLP4 60
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 1
EQI4 $183
ADDRLP4 60
INDIRI4
CNSTI4 2
EQI4 $184
ADDRGP4 $180
JUMPV
LABELV $183
line 340
;339:			case TEAM_RED:
;340:				memcpy(&gi->missionGoal, &ctf_blueflag, sizeof(bot_goal_t));
ADDRLP4 0
INDIRP4
CNSTI4 88
ADDP4
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 341
;341:				gi->missionGoalAvailable = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
CNSTI4 1
ASGNI4
line 342
;342:				break;
ADDRGP4 $168
JUMPV
LABELV $184
line 344
;343:			case TEAM_BLUE:
;344:				memcpy(&gi->missionGoal, &ctf_redflag, sizeof(bot_goal_t));
ADDRLP4 0
INDIRP4
CNSTI4 88
ADDP4
ARGP4
ADDRGP4 ctf_redflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 345
;345:				gi->missionGoalAvailable = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
CNSTI4 1
ASGNI4
line 346
;346:				break;
ADDRGP4 $168
JUMPV
LABELV $180
line 348
;347:			default:
;348:				gi->missionGoalAvailable = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
CNSTI4 0
ASGNI4
line 349
;349:				break;
line 352
;350:			}
;351:			// NOTE: if there's a flag carrier, the result may be overwritten later in this function
;352:			break;
LABELV $168
line 354
;353:		}
;354:	}
LABELV $164
line 290
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 10
LTI4 $163
line 356
;355:
;356:	as = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 357
;357:	for (cl = 0; cl < level.maxclients; cl++) {
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 $189
JUMPV
LABELV $186
line 361
;358:		gclient_t* client;
;359:		int areaNum;
;360:
;361:		if (!g_entities[cl].inuse) continue;
ADDRLP4 12
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $191
ADDRGP4 $187
JUMPV
LABELV $191
line 362
;362:		client = level.clients + cl;
ADDRLP4 20
ADDRLP4 12
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 363
;363:		if (client->pers.connected != CON_CONNECTED) continue;
ADDRLP4 20
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $194
ADDRGP4 $187
JUMPV
LABELV $194
line 364
;364:		if (client->sess.sessionTeam != tss->team) {
ADDRLP4 20
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
EQI4 $196
line 365
;365:			if (client->sess.sessionTeam != TEAM_BLUE && client->sess.sessionTeam != TEAM_RED) continue;
ADDRLP4 20
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 2
EQI4 $198
ADDRLP4 20
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 1
EQI4 $198
ADDRGP4 $187
JUMPV
LABELV $198
line 366
;366:			if (client->ps.stats[STAT_HEALTH] > 0 && client->ps.pm_type == PM_SPECTATOR) {
ADDRLP4 20
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
LEI4 $200
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $200
line 368
;367:				// mission leader safety mode
;368:				continue;
ADDRGP4 $187
JUMPV
LABELV $200
line 370
;369:			}
;370:			tss->ots++;
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 712
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 371
;371:			if (client->ps.stats[STAT_HEALTH] > 0) tss->oaq++;
ADDRLP4 20
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
LEI4 $202
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $202
line 372
;372:			TSS_PlayerAlivePrediction(client, tss, &tss->oamq, &tss->oalq);
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRLP4 44
INDIRP4
CNSTI4 688
ADDP4
ARGP4
ADDRLP4 44
INDIRP4
CNSTI4 696
ADDP4
ARGP4
ADDRGP4 TSS_PlayerAlivePrediction
CALLV
pop
line 373
;373:			continue;
ADDRGP4 $187
JUMPV
LABELV $196
line 375
;374:		}
;375:		if (client->sess.teamLeader) {
ADDRLP4 20
INDIRP4
CNSTI4 720
ADDP4
INDIRI4
CNSTI4 0
EQI4 $204
line 376
;376:			tss->missionLeader = client;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 20
INDIRP4
ASGNP4
line 377
;377:		}
LABELV $204
line 378
;378:		if (client->ps.stats[STAT_HEALTH] > 0 && client->ps.pm_type == PM_SPECTATOR) {
ADDRLP4 20
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
LEI4 $206
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $206
line 380
;379:			// mission leader safety mode
;380:			BG_TSS_SetPlayerInfo(&client->ps, TSSPI_isValid, qfalse);
ADDRLP4 20
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 BG_TSS_SetPlayerInfo
CALLV
pop
line 381
;381:			continue;
ADDRGP4 $187
JUMPV
LABELV $206
line 384
;382:		}
;383:
;384:		tss->yts++;
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 385
;385:		ga = &tssGroupAssignments[as++];
ADDRLP4 36
ADDRLP4 16
INDIRI4
ASGNI4
ADDRLP4 16
ADDRLP4 36
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 8
ADDRLP4 36
INDIRI4
CNSTI4 40
MULI4
ADDRGP4 tssGroupAssignments
ADDP4
ASGNP4
line 386
;386:		ga->client = client;
ADDRLP4 8
INDIRP4
ADDRLP4 20
INDIRP4
ASGNP4
line 387
;387:		ga->clientNum = cl;
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 388
;388:		ga->isAlive = (client->ps.stats[STAT_HEALTH] > 0);
ADDRLP4 20
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
LEI4 $209
ADDRLP4 40
CNSTI4 1
ASGNI4
ADDRGP4 $210
JUMPV
LABELV $209
ADDRLP4 40
CNSTI4 0
ASGNI4
LABELV $210
ADDRLP4 8
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 40
INDIRI4
ASGNI4
line 389
;389:		ga->isFighting = qfalse;	// eventually set below
ADDRLP4 8
INDIRP4
CNSTI4 32
ADDP4
CNSTI4 0
ASGNI4
line 390
;390:		ga->danger = TSS_DangerIndex(&client->ps);
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 TSS_DangerIndex
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 44
INDIRI4
ASGNI4
line 391
;391:		ga->group = NULL;
ADDRLP4 8
INDIRP4
CNSTI4 20
ADDP4
CNSTP4 0
ASGNP4
line 392
;392:		ga->reservation = TSSGAR_unreserved;
ADDRLP4 8
INDIRP4
CNSTI4 24
ADDP4
CNSTI4 0
ASGNI4
line 393
;393:		if (client->ps.powerups[PW_REDFLAG] || client->ps.powerups[PW_BLUEFLAG]) {
ADDRLP4 20
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
NEI4 $213
ADDRLP4 20
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
EQI4 $211
LABELV $213
line 394
;394:			tssFlagCarrier = ga;
ADDRGP4 tssFlagCarrier
ADDRLP4 8
INDIRP4
ASGNP4
line 395
;395:		}
LABELV $211
line 397
;396:
;397:		if (ga->isAlive) {
ADDRLP4 8
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 0
EQI4 $214
line 398
;398:			tss->avgStamina += 100 * client->ps.stats[STAT_STRENGTH] / MAX_STRENGTH_VALUE;
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 668
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
CVIF4 4
ADDRLP4 20
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 100
MULI4
CVIF4 4
CNSTF4 946406483
MULF4
ADDF4
CVFI4 4
ASGNI4
line 399
;399:			tssNumPlayersAlive++;
ADDRLP4 56
ADDRGP4 tssNumPlayersAlive
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 401
;400:
;401:			if (IsPlayerInvolvedInFighting(cl)) {
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 IsPlayerInvolvedInFighting
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $216
line 402
;402:				tss->fightIntensity += 100;
ADDRLP4 64
ADDRFP4 0
INDIRP4
CNSTI4 672
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 403
;403:				ga->isFighting = qtrue;
ADDRLP4 8
INDIRP4
CNSTI4 32
ADDP4
CNSTI4 1
ASGNI4
line 404
;404:			}
LABELV $216
line 406
;405:
;406:			if (ga->danger <= tss->rfa_dangerLimit) tss->rfa++;
ADDRLP4 8
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRI4
GTI4 $218
ADDRLP4 64
ADDRFP4 0
INDIRP4
CNSTI4 676
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $218
line 407
;407:			if (ga->danger <= tss->rfd_dangerLimit) tss->rfd++;
ADDRLP4 8
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 640
ADDP4
INDIRI4
GTI4 $220
ADDRLP4 68
ADDRFP4 0
INDIRP4
CNSTI4 680
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $220
line 408
;408:			tss->yaq++;
ADDRLP4 72
ADDRFP4 0
INDIRP4
CNSTI4 700
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 409
;409:		}
LABELV $214
line 410
;410:		TSS_PlayerAlivePrediction(client, tss, &tss->yamq, &tss->yalq);
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRLP4 52
INDIRP4
CNSTI4 684
ADDP4
ARGP4
ADDRLP4 52
INDIRP4
CNSTI4 692
ADDP4
ARGP4
ADDRGP4 TSS_PlayerAlivePrediction
CALLV
pop
line 412
;411:
;412:		if (BG_TSS_GetPlayerInfo(&client->ps, TSSPI_isValid)) {
ADDRLP4 20
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 56
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $222
line 413
;413:			gr = BG_TSS_GetPlayerInfo(&client->ps, TSSPI_group);
ADDRLP4 20
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 60
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 60
INDIRI4
ASGNI4
line 414
;414:			if (gr < 0 || gr >= MAX_GROUPS) goto NoCurrentGroup;
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $226
ADDRLP4 4
INDIRI4
CNSTI4 10
LTI4 $224
LABELV $226
ADDRGP4 $227
JUMPV
LABELV $224
line 416
;415:
;416:			ga->oldGroup = &tssGroupInfo[gr];
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 148
MULI4
ADDRGP4 tssGroupInfo
ADDP4
ASGNP4
line 417
;417:			ga->oldGMS = BG_TSS_GetPlayerInfo(&client->ps, TSSPI_groupMemberStatus);
ADDRLP4 20
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 68
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 68
INDIRI4
ASGNI4
line 418
;418:			if (ga->oldGroup->oldLeader == ga) {
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRP4
CVPU4 4
NEU4 $228
line 419
;419:				switch (ga->oldGroup->mission) {
ADDRLP4 76
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 1
EQI4 $233
ADDRLP4 76
INDIRI4
CNSTI4 2
EQI4 $233
ADDRGP4 $188
JUMPV
LABELV $233
line 422
;420:				case TSSMISSION_seek_enemy:
;421:				case TSSMISSION_seek_items:
;422:					ga->oldGroup->missionGoal.entitynum = ga->clientNum;
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CNSTI4 128
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 423
;423:					VectorCopy(ga->client->ps.origin, ga->oldGroup->missionGoal.origin);
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CNSTI4 88
ADDP4
ADDRLP4 8
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 424
;424:					ga->oldGroup->missionGoalAvailable = qtrue;
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CNSTI4 84
ADDP4
CNSTI4 1
ASGNI4
line 425
;425:					break;
line 427
;426:				default:
;427:					break;
line 429
;428:				}
;429:				break;
ADDRGP4 $188
JUMPV
LABELV $228
line 431
;430:			}
;431:			ga->oldTaskGoal = BG_TSS_GetPlayerInfo(&client->ps, TSSPI_taskGoal);
ADDRLP4 20
INDIRP4
ARGP4
CNSTI4 13
ARGI4
ADDRLP4 76
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 76
INDIRI4
ASGNI4
line 433
;432:
;433:			if (ga->clientNum == tss->currentLeaders[gr]) {
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 476
ADDP4
ADDP4
INDIRI4
NEI4 $223
line 434
;434:				ga->oldGroup->oldLeader = ga;
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 8
INDIRP4
ASGNP4
line 435
;435:			}
line 436
;436:		}
ADDRGP4 $223
JUMPV
LABELV $222
line 437
;437:		else {
LABELV $227
line 439
;438:			NoCurrentGroup:
;439:			ga->oldGroup = NULL;
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
CNSTP4 0
ASGNP4
line 440
;440:			ga->oldGMS = -1;
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 -1
ASGNI4
line 441
;441:			ga->oldTaskGoal = -1;
ADDRLP4 8
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 -1
ASGNI4
line 442
;442:		}
LABELV $223
line 444
;443:
;444:		areaNum = BotPointAreaNum(client->ps.origin);
ADDRLP4 20
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 60
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 60
INDIRI4
ASGNI4
line 445
;445:		if (areaNum > 0 && trap_AAS_AreaReachability(areaNum)) {
ADDRLP4 24
INDIRI4
CNSTI4 0
LEI4 $236
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 68
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $236
line 446
;446:			client->tssLastValidAreaNum = areaNum;
ADDRLP4 20
INDIRP4
CNSTI4 760
ADDP4
ADDRLP4 24
INDIRI4
ASGNI4
line 447
;447:		}
LABELV $236
line 448
;448:	}
LABELV $187
line 357
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $189
ADDRLP4 12
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $186
LABELV $188
line 449
;449:	tssNumGroupAssignments = as;
ADDRGP4 tssNumGroupAssignments
ADDRLP4 16
INDIRI4
ASGNI4
line 451
;450:
;451:	{
line 455
;452:		int groupSizes[MAX_GROUPS];
;453:		int assignments[MAX_GROUPS];
;454:
;455:		for (gr = 0; gr < MAX_GROUPS; gr++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $238
line 456
;456:			groupSizes[gr] = tss->instructions.division.group[gr].minTotalMembers;
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 12
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDP4
INDIRI4
ASGNI4
line 457
;457:		}
LABELV $239
line 455
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 10
LTI4 $238
line 458
;458:		BG_TSS_AssignPlayers(
ADDRGP4 tssNumGroupAssignments
INDIRI4
ARGI4
ADDRLP4 20
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
ARGP4
ADDRGP4 BG_TSS_AssignPlayers
CALLV
pop
line 463
;459:			tssNumGroupAssignments,
;460:			&groupSizes, tss->instructions.division.unassignedPlayers,
;461:			&assignments
;462:		);
;463:		for (gr = 0; gr < MAX_GROUPS; gr++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $242
line 464
;464:			tssGroupInfo[gr].minTotalPlayers = assignments[gr];
ADDRLP4 4
INDIRI4
CNSTI4 148
MULI4
ADDRGP4 tssGroupInfo+36
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 60
ADDP4
INDIRI4
ASGNI4
line 465
;465:		}
LABELV $243
line 463
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 10
LTI4 $242
line 466
;466:	}
line 467
;467:	for (gr = 0; gr < MAX_GROUPS; gr++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $247
line 468
;468:		gi = &tssGroupInfo[gr];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 148
MULI4
ADDRGP4 tssGroupInfo
ADDP4
ASGNP4
line 470
;469:
;470:		gi->minAlivePlayers = TSS_Proportion_RoundToCeil(
ADDRLP4 4
INDIRI4
CNSTI4 12
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDP4
CNSTI4 4
ADDP4
INDIRI4
ARGI4
CNSTI4 100
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 TSS_Proportion_RoundToCeil
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 24
INDIRI4
ASGNI4
line 473
;471:			tss->instructions.division.group[gr].minAliveMembers, 100, gi->minTotalPlayers
;472:		);
;473:		gi->minReadyPlayers = TSS_Proportion_RoundToCeil(
ADDRLP4 4
INDIRI4
CNSTI4 12
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 100
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 TSS_Proportion_RoundToCeil
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
ADDRLP4 32
INDIRI4
ASGNI4
line 476
;474:			tss->instructions.division.group[gr].minReadyMembers, 100, gi->minAlivePlayers
;475:		);
;476:		gi->minReadyForMission = tss->instructions.orders.order[gr].minReady;
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 20
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
ADDP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 477
;477:		gi->minGroupSize = tss->instructions.orders.order[gr].minGroupSize;
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 20
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
ADDP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 480
;478:
;479:		if (
;480:			tssFlagCarrier &&
ADDRGP4 tssFlagCarrier
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $251
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 6
NEI4 $251
ADDRLP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 0
EQI4 $251
line 483
;481:			gi->mission == TSSMISSION_occupy_enemy_base &&
;482:			gi->protectFlagCarrier
;483:		) {
line 484
;484:			memset(&gi->missionGoal, 0, sizeof(gi->missionGoal));
ADDRLP4 0
INDIRP4
CNSTI4 88
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 56
ARGI4
ADDRGP4 memset
CALLP4
pop
line 485
;485:			gi->missionGoal.entitynum = tssFlagCarrier->clientNum;
ADDRLP4 0
INDIRP4
CNSTI4 128
ADDP4
ADDRGP4 tssFlagCarrier
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 486
;486:			gi->missionGoal.areanum = tssFlagCarrier->client->tssLastValidAreaNum;
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
ADDRGP4 tssFlagCarrier
INDIRP4
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
ASGNI4
line 487
;487:			VectorCopy(tssFlagCarrier->client->ps.origin, gi->missionGoal.origin);
ADDRLP4 0
INDIRP4
CNSTI4 88
ADDP4
ADDRGP4 tssFlagCarrier
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 489
;488:			// JUHOX FIXME: should we initialize more fields of 'gi->missionGoal'?
;489:			gi->missionGoalAvailable = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
CNSTI4 1
ASGNI4
line 490
;490:		}
LABELV $251
line 492
;491:
;492:		tss->currentLeaders[gr] = -1;
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 476
ADDP4
ADDP4
CNSTI4 -1
ASGNI4
line 493
;493:	}
LABELV $248
line 467
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 10
LTI4 $247
line 495
;494:
;495:	if (tssNumPlayersAlive > 0) {
ADDRGP4 tssNumPlayersAlive
INDIRI4
CNSTI4 0
LEI4 $253
line 496
;496:		if (g_stamina.integer) {
ADDRGP4 g_stamina+12
INDIRI4
CNSTI4 0
EQI4 $255
line 497
;497:			tss->avgStamina /= tssNumPlayersAlive;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 668
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
ADDRGP4 tssNumPlayersAlive
INDIRI4
DIVI4
ASGNI4
line 498
;498:		}
ADDRGP4 $256
JUMPV
LABELV $255
line 499
;499:		else {
line 500
;500:			tss->avgStamina = 100;
ADDRFP4 0
INDIRP4
CNSTI4 668
ADDP4
CNSTI4 100
ASGNI4
line 501
;501:		}
LABELV $256
line 502
;502:		tss->fightIntensity /= tssNumPlayersAlive;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 672
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
ADDRGP4 tssNumPlayersAlive
INDIRI4
DIVI4
ASGNI4
line 503
;503:	}
LABELV $253
line 504
;504:}
LABELV $160
endproc TSS_InitGroupAssignments 104 16
proc TSS_PlayerDistanceSqr 4 12
line 511
;505:
;506:/*
;507:===============
;508:JUHOX: TSS_PlayerDistanceSqr
;509:===============
;510:*/
;511:static vec_t TSS_PlayerDistanceSqr(const tss_groupAssignment_t* ga1, const tss_groupAssignment_t* ga2) {
line 512
;512:	if (!ga1 || !ga2) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $261
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $259
LABELV $261
line 513
;513:		G_Error("BUG! TSS_PlayerDistanceSqr: ga1=%d, ga2=%d", (int)ga1, (int)ga2);
ADDRGP4 $262
ARGP4
ADDRFP4 0
INDIRP4
CVPU4 4
CVUI4 4
ARGI4
ADDRFP4 4
INDIRP4
CVPU4 4
CVUI4 4
ARGI4
ADDRGP4 G_Error
CALLV
pop
line 514
;514:		return 1000000000.0;
CNSTF4 1315859240
RETF4
ADDRGP4 $258
JUMPV
LABELV $259
line 516
;515:	}
;516:	return DistanceSquared(ga1->client->ps.origin, ga2->client->ps.origin);
ADDRFP4 0
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 0
INDIRF4
RETF4
LABELV $258
endproc TSS_PlayerDistanceSqr 4 12
proc TSS_CancelGroupAssignment 16 4
line 524
;517:}
;518:
;519:/*
;520:===============
;521:JUHOX: TSS_CancelGroupAssignment
;522:===============
;523:*/
;524:static void TSS_CancelGroupAssignment(tss_groupAssignment_t* ga) {
line 527
;525:	tss_groupInfo_t* gi;
;526:
;527:	if (!ga) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $264
line 528
;528:		G_Error("BUG! TSS_CancelGroupAssignment: ga=NULL");
ADDRGP4 $266
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 529
;529:		return;
ADDRGP4 $263
JUMPV
LABELV $264
line 531
;530:	}
;531:	gi = ga->group;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
ASGNP4
line 533
;532:
;533:	ga->group = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
CNSTP4 0
ASGNP4
line 534
;534:	ga->reservation = TSSGAR_unreserved;
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
CNSTI4 0
ASGNI4
line 535
;535:	if (!gi) return;
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $267
ADDRGP4 $263
JUMPV
LABELV $267
line 537
;536:
;537:	gi->totalPlayers--;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 538
;538:	if (ga->isAlive) {
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 0
EQI4 $269
line 539
;539:		gi->alivePlayers--;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 540
;540:		if (ga->danger <= gi->maxDanger) {
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
GTI4 $271
line 541
;541:			gi->readyPlayers--;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 542
;542:		}
LABELV $271
line 543
;543:	}
LABELV $269
line 544
;544:}
LABELV $263
endproc TSS_CancelGroupAssignment 16 4
proc TSS_AssignToGroup 12 12
line 553
;545:
;546:/*
;547:===============
;548:JUHOX: TSS_AssignToGroup
;549:===============
;550:*/
;551:static void TSS_AssignToGroup(
;552:	tss_groupAssignment_t* ga, tss_groupInfo_t* gi, tss_groupAssignmentReservation_t reservation
;553:) {
line 554
;554:	if (!ga || !gi) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $276
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $274
LABELV $276
line 555
;555:		G_Error("BUG! TSS_AssignToGroup: ga=%d, gi=%d", (int)ga, (int)gi);
ADDRGP4 $277
ARGP4
ADDRFP4 0
INDIRP4
CVPU4 4
CVUI4 4
ARGI4
ADDRFP4 4
INDIRP4
CVPU4 4
CVUI4 4
ARGI4
ADDRGP4 G_Error
CALLV
pop
line 556
;556:		return;
ADDRGP4 $273
JUMPV
LABELV $274
line 559
;557:	}
;558:
;559:	gi->totalPlayers++;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 560
;560:	if (ga->isAlive) {
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 0
EQI4 $278
line 561
;561:		gi->alivePlayers++;
ADDRLP4 4
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 562
;562:		if (ga->danger <= gi->maxDanger) {
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
GTI4 $280
line 563
;563:			gi->readyPlayers++;
ADDRLP4 8
ADDRFP4 4
INDIRP4
CNSTI4 48
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 564
;564:		}
LABELV $280
line 565
;565:	}
LABELV $278
line 567
;566:
;567:	if (ga->reservation < reservation) {
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
ADDRFP4 8
INDIRI4
GEI4 $282
line 568
;568:		ga->reservation = reservation;
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 569
;569:	}
LABELV $282
line 570
;570:	ga->group = gi;
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRFP4 4
INDIRP4
ASGNP4
line 571
;571:}
LABELV $273
endproc TSS_AssignToGroup 12 12
proc TSS_CanReserveGroupAssignment 8 12
line 580
;572:
;573:/*
;574:===============
;575:JUHOX: TSS_CanReserveGroupAssignment
;576:===============
;577:*/
;578:static qboolean TSS_CanReserveGroupAssignment(
;579:	tss_groupAssignment_t* ga, tss_groupInfo_t* gi, tss_groupAssignmentReservation_t reservation
;580:) {
line 581
;581:	if (!ga || !gi) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $287
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $285
LABELV $287
line 582
;582:		G_Error("BUG! TSS_CanReserveGroupAssignment: ga=%d, gi=%d", (int)ga, (int)gi);
ADDRGP4 $288
ARGP4
ADDRFP4 0
INDIRP4
CVPU4 4
CVUI4 4
ARGI4
ADDRFP4 4
INDIRP4
CVPU4 4
CVUI4 4
ARGI4
ADDRGP4 G_Error
CALLV
pop
line 583
;583:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $284
JUMPV
LABELV $285
line 585
;584:	}
;585:	if (gi->mission <= TSSMISSION_invalid) return qfalse;
ADDRFP4 4
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 0
GTI4 $289
CNSTI4 0
RETI4
ADDRGP4 $284
JUMPV
LABELV $289
line 586
;586:	if (!ga->group) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $291
CNSTI4 1
RETI4
ADDRGP4 $284
JUMPV
LABELV $291
line 587
;587:	if (ga->group == gi) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CVPU4 4
NEU4 $293
CNSTI4 1
RETI4
ADDRGP4 $284
JUMPV
LABELV $293
line 589
;588:
;589:	if (ga->reservation > reservation) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
ADDRFP4 8
INDIRI4
LEI4 $295
CNSTI4 0
RETI4
ADDRGP4 $284
JUMPV
LABELV $295
line 591
;590:
;591:	if (ga->reservation == reservation) {
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
ADDRFP4 8
INDIRI4
NEI4 $297
line 592
;592:		if (ga->group->rank <= gi->rank) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
GTI4 $299
CNSTI4 0
RETI4
ADDRGP4 $284
JUMPV
LABELV $299
line 593
;593:	}
LABELV $297
line 596
;594:
;595:	if (
;596:		ga->group->rank <= gi->rank &&
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
GTI4 $301
ADDRFP4 8
INDIRI4
CNSTI4 2
GTI4 $301
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
LEI4 $304
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 0
EQI4 $305
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
LEI4 $304
LABELV $305
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
GTI4 $301
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
GTI4 $301
LABELV $304
line 603
;597:		reservation <= TSSGAR_constraint &&
;598:		(
;599:			ga->group->totalPlayers <= ga->group->minTotalPlayers ||
;600:			(ga->isAlive && ga->group->alivePlayers <= ga->group->minAlivePlayers) ||
;601:			(ga->danger <= ga->group->maxDanger && ga->group->readyPlayers <= ga->group->minReadyPlayers)
;602:		)
;603:	) {
line 604
;604:		ga->reservation = TSSGAR_constraint;
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
CNSTI4 2
ASGNI4
line 605
;605:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $284
JUMPV
LABELV $301
line 607
;606:	}
;607:	return qtrue;
CNSTI4 1
RETI4
LABELV $284
endproc TSS_CanReserveGroupAssignment 8 12
proc TSS_MoveToGroupIfPossible 4 12
line 617
;608:}
;609:
;610:/*
;611:===============
;612:JUHOX: TSS_MoveToGroupIfPossible
;613:===============
;614:*/
;615:static qboolean TSS_MoveToGroupIfPossible(
;616:	tss_groupAssignment_t* ga, tss_groupInfo_t* gi, tss_groupAssignmentReservation_t reservation
;617:) {
line 618
;618:	if (!ga || !gi) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $309
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $307
LABELV $309
line 619
;619:		G_Error("BUG! TSS_MoveToGroupIfPossible: ga=%d, gi=%d", (int)ga, (int)gi);
ADDRGP4 $310
ARGP4
ADDRFP4 0
INDIRP4
CVPU4 4
CVUI4 4
ARGI4
ADDRFP4 4
INDIRP4
CVPU4 4
CVUI4 4
ARGI4
ADDRGP4 G_Error
CALLV
pop
line 620
;620:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $306
JUMPV
LABELV $307
line 622
;621:	}
;622:	if (ga->group == gi) {
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CVPU4 4
NEU4 $311
line 623
;623:		if (ga->reservation < reservation) {
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
ADDRFP4 8
INDIRI4
GEI4 $313
line 624
;624:			ga->reservation = reservation;
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 625
;625:		}
LABELV $313
line 626
;626:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $306
JUMPV
LABELV $311
line 629
;627:	}
;628:
;629:	if (!TSS_CanReserveGroupAssignment(ga, gi, reservation)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 TSS_CanReserveGroupAssignment
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $315
CNSTI4 0
RETI4
ADDRGP4 $306
JUMPV
LABELV $315
line 631
;630:
;631:	TSS_CancelGroupAssignment(ga);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 TSS_CancelGroupAssignment
CALLV
pop
line 632
;632:	TSS_AssignToGroup(ga, gi, reservation);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 TSS_AssignToGroup
CALLV
pop
line 633
;633:	return qtrue;
CNSTI4 1
RETI4
LABELV $306
endproc TSS_MoveToGroupIfPossible 4 12
proc TSS_ApplyDistanceBonus 0 0
line 641
;634:}
;635:
;636:/*
;637:===============
;638:JUHOX: TSS_ApplyDistanceBonus
;639:===============
;640:*/
;641:static vec_t TSS_ApplyDistanceBonus(vec_t dist, vec_t factor, vec_t offset) {
line 642
;642:	if (dist > 0) {
ADDRFP4 0
INDIRF4
CNSTF4 0
LEF4 $318
line 643
;643:		dist *= factor;
ADDRFP4 0
ADDRFP4 0
INDIRF4
ADDRFP4 4
INDIRF4
MULF4
ASGNF4
line 644
;644:	}
ADDRGP4 $319
JUMPV
LABELV $318
line 645
;645:	else {
line 646
;646:		dist /= factor;
ADDRFP4 0
ADDRFP4 0
INDIRF4
ADDRFP4 4
INDIRF4
DIVF4
ASGNF4
line 647
;647:	}
LABELV $319
line 648
;648:	dist -= offset;
ADDRFP4 0
ADDRFP4 0
INDIRF4
ADDRFP4 8
INDIRF4
SUBF4
ASGNF4
line 649
;649:	return dist;
ADDRFP4 0
INDIRF4
RETF4
LABELV $317
endproc TSS_ApplyDistanceBonus 0 0
proc TSS_AdjustedGoalDistance 24 16
line 658
;650:}
;651:
;652:/*
;653:===============
;654:JUHOX: TSS_AdjustedGoalDistance
;655:===============
;656:*/
;657:static int tssGoalDistanceCache[MAX_GROUPS][MAX_CLIENTS];
;658:static vec_t TSS_AdjustedGoalDistance(const tss_groupAssignment_t* ga, const tss_groupInfo_t* gi) {
line 661
;659:	vec_t dist;
;660:
;661:	if (!ga || !gi) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $323
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $321
LABELV $323
line 662
;662:		G_Error("BUG! TSS_AdjustedGoalDistance: ga=%d, gi=%d", (int)ga, (int)gi);
ADDRGP4 $324
ARGP4
ADDRFP4 0
INDIRP4
CVPU4 4
CVUI4 4
ARGI4
ADDRFP4 4
INDIRP4
CVPU4 4
CVUI4 4
ARGI4
ADDRGP4 G_Error
CALLV
pop
line 663
;663:		return 1000000000.0f;
CNSTF4 1315859240
RETF4
ADDRGP4 $320
JUMPV
LABELV $321
line 666
;664:	}
;665:
;666:	if (!ga->isAlive) {
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 0
NEI4 $325
line 667
;667:		dist = 0.0f;	// if dead players are accepted, prefer them
ADDRLP4 0
CNSTF4 0
ASGNF4
line 668
;668:	}
ADDRGP4 $326
JUMPV
LABELV $325
line 669
;669:	else if (ga == tssFlagCarrier) {
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 tssFlagCarrier
INDIRP4
CVPU4 4
NEU4 $327
line 670
;670:		if (gi->mission == TSSMISSION_capture_enemy_flag) {
ADDRFP4 4
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 3
NEI4 $329
line 671
;671:			dist = 100000.0f;
ADDRLP4 0
CNSTF4 1203982336
ASGNF4
line 673
;672:			if (
;673:				gi->oldLeader &&
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $328
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 0
LEI4 $328
ADDRFP4 0
INDIRP4
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 0
LEI4 $328
line 676
;674:				gi->oldLeader->client->tssLastValidAreaNum > 0 &&
;675:				ga->client->tssLastValidAreaNum > 0
;676:			) {
line 677
;677:				dist = trap_AAS_AreaTravelTimeToGoalArea(
ADDRLP4 8
ADDRFP4 0
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 12
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
CVIF4 4
ASGNF4
line 681
;678:					ga->client->tssLastValidAreaNum, ga->client->ps.origin,
;679:					gi->oldLeader->client->tssLastValidAreaNum, TFL_DEFAULT
;680:				);
;681:				if (dist <= 0) dist = 100000.0f;
ADDRLP4 0
INDIRF4
CNSTF4 0
GTF4 $328
ADDRLP4 0
CNSTF4 1203982336
ASGNF4
line 682
;682:			}
line 683
;683:		}
ADDRGP4 $328
JUMPV
LABELV $329
line 684
;684:		else {
line 685
;685:			dist = 100000000.0f;
ADDRLP4 0
CNSTF4 1287568416
ASGNF4
line 686
;686:		}
line 687
;687:	}
ADDRGP4 $328
JUMPV
LABELV $327
line 688
;688:	else if (gi->missionGoalAvailable) {
ADDRFP4 4
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 0
EQI4 $335
line 689
;689:		dist = tssGoalDistanceCache[gi->groupNum][ga->clientNum];
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
INDIRI4
CNSTI4 8
LSHI4
ADDRGP4 tssGoalDistanceCache
ADDP4
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 690
;690:		if (dist < 0) {
ADDRLP4 0
INDIRF4
CNSTF4 0
GEF4 $336
line 691
;691:			if (ga->client->tssLastValidAreaNum > 0) {
ADDRFP4 0
INDIRP4
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 0
LEI4 $339
line 692
;692:				dist = trap_AAS_AreaTravelTimeToGoalArea(
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 100
ADDP4
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 8
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
CVIF4 4
ASGNF4
line 696
;693:					ga->client->tssLastValidAreaNum, ga->client->ps.origin,
;694:					gi->missionGoal.areanum, TFL_DEFAULT
;695:				);
;696:			}
ADDRGP4 $340
JUMPV
LABELV $339
line 697
;697:			else {
line 698
;698:				dist = 1000000.0f;
ADDRLP4 0
CNSTF4 1232348160
ASGNF4
line 699
;699:			}
LABELV $340
line 700
;700:			tssGoalDistanceCache[gi->groupNum][ga->clientNum] = dist;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
INDIRI4
CNSTI4 8
LSHI4
ADDRGP4 tssGoalDistanceCache
ADDP4
ADDP4
ADDRLP4 0
INDIRF4
CVFI4 4
ASGNI4
line 701
;701:		}
line 702
;702:	}
ADDRGP4 $336
JUMPV
LABELV $335
line 703
;703:	else {
line 704
;704:		dist = 1000000.0f;
ADDRLP4 0
CNSTF4 1232348160
ASGNF4
line 705
;705:		dist += ga->danger;	// hint for leader determination
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 706
;706:		if (ga->group) dist -= 2000.0f * ga->group->rank;	// hint for constraint based assignment
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $341
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1157234688
MULF4
SUBF4
ASGNF4
LABELV $341
line 707
;707:	}
LABELV $336
LABELV $328
LABELV $326
line 709
;708:
;709:	if (ga->danger <= gi->maxDanger) {
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
GTI4 $343
line 711
;710:		if (
;711:			ga->oldGroup &&
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $345
ADDRLP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
LEI4 $345
ADDRFP4 4
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 2
NEI4 $345
line 714
;712:			ga->danger > ga->oldGroup->maxDanger &&
;713:			gi->mission == TSSMISSION_seek_items
;714:		) {
line 715
;715:			if (gi->missionGoalAvailable) {
ADDRFP4 4
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 0
EQI4 $347
line 716
;716:				dist = TSS_ApplyDistanceBonus(dist, 0.2f, 1000.0f);
ADDRLP4 0
INDIRF4
ARGF4
CNSTF4 1045220557
ARGF4
CNSTF4 1148846080
ARGF4
ADDRLP4 8
ADDRGP4 TSS_ApplyDistanceBonus
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
ASGNF4
line 717
;717:			}
ADDRGP4 $346
JUMPV
LABELV $347
line 718
;718:			else {
line 719
;719:				dist = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 720
;720:			}
line 721
;721:		}
ADDRGP4 $346
JUMPV
LABELV $345
line 722
;722:		else {
line 723
;723:			dist = TSS_ApplyDistanceBonus(dist, 0.9f, 200.0f);
ADDRLP4 0
INDIRF4
ARGF4
CNSTF4 1063675494
ARGF4
CNSTF4 1128792064
ARGF4
ADDRLP4 8
ADDRGP4 TSS_ApplyDistanceBonus
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
ASGNF4
line 724
;724:		}
LABELV $346
line 725
;725:	}
LABELV $343
line 727
;726:
;727:	if (ga->oldGroup == gi) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CVPU4 4
NEU4 $349
line 728
;728:		dist = TSS_ApplyDistanceBonus(dist, 0.9f, 100.0f);
ADDRLP4 0
INDIRF4
ARGF4
CNSTF4 1063675494
ARGF4
CNSTF4 1120403456
ARGF4
ADDRLP4 4
ADDRGP4 TSS_ApplyDistanceBonus
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 729
;729:		switch (ga->oldGMS) {
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 2
EQI4 $354
ADDRLP4 8
INDIRI4
CNSTI4 3
EQI4 $355
ADDRLP4 8
INDIRI4
CNSTI4 4
EQI4 $354
ADDRGP4 $352
JUMPV
LABELV $354
line 732
;730:		case TSSGMS_designatedLeader:
;731:		case TSSGMS_designatedFighter:
;732:			dist = TSS_ApplyDistanceBonus(dist, 0.7f, 500.0f);
ADDRLP4 0
INDIRF4
ARGF4
CNSTF4 1060320051
ARGF4
CNSTF4 1140457472
ARGF4
ADDRLP4 16
ADDRGP4 TSS_ApplyDistanceBonus
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 733
;733:			break;
ADDRGP4 $352
JUMPV
LABELV $355
line 735
;734:		case TSSGMS_temporaryLeader:
;735:			dist = TSS_ApplyDistanceBonus(dist, 0.9f, 200.0f);
ADDRLP4 0
INDIRF4
ARGF4
CNSTF4 1063675494
ARGF4
CNSTF4 1128792064
ARGF4
ADDRLP4 20
ADDRGP4 TSS_ApplyDistanceBonus
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 20
INDIRF4
ASGNF4
line 736
;736:			break;
line 738
;737:		default:
;738:			break;
LABELV $352
line 741
;739:		}
;740:
;741:		if (ga->client->tssCoOperatingWithGroupLeader) {
ADDRFP4 0
INDIRP4
INDIRP4
CNSTI4 764
ADDP4
INDIRI4
CNSTI4 0
EQI4 $356
line 742
;742:			dist = TSS_ApplyDistanceBonus(dist, 0.9f, 100.0f);
ADDRLP4 0
INDIRF4
ARGF4
CNSTF4 1063675494
ARGF4
CNSTF4 1120403456
ARGF4
ADDRLP4 16
ADDRGP4 TSS_ApplyDistanceBonus
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 743
;743:		}
LABELV $356
line 744
;744:	}
LABELV $349
line 746
;745:
;746:	if (gi->designated1stLeader == ga->clientNum) {
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
NEI4 $358
line 747
;747:		dist = TSS_ApplyDistanceBonus(dist, 0.5f, 1000.0f);
ADDRLP4 0
INDIRF4
ARGF4
CNSTF4 1056964608
ARGF4
CNSTF4 1148846080
ARGF4
ADDRLP4 4
ADDRGP4 TSS_ApplyDistanceBonus
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 748
;748:	}
ADDRGP4 $359
JUMPV
LABELV $358
line 749
;749:	else if (gi->designated2ndLeader == ga->clientNum) {
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
NEI4 $360
line 750
;750:		dist = TSS_ApplyDistanceBonus(dist, 0.6f, 750.0f);
ADDRLP4 0
INDIRF4
ARGF4
CNSTF4 1058642330
ARGF4
CNSTF4 1144750080
ARGF4
ADDRLP4 4
ADDRGP4 TSS_ApplyDistanceBonus
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 751
;751:	}
ADDRGP4 $361
JUMPV
LABELV $360
line 752
;752:	else if (gi->designated3rdLeader == ga->clientNum) {
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
NEI4 $362
line 753
;753:		dist = TSS_ApplyDistanceBonus(dist, 0.7f, 500.0f);
ADDRLP4 0
INDIRF4
ARGF4
CNSTF4 1060320051
ARGF4
CNSTF4 1140457472
ARGF4
ADDRLP4 4
ADDRGP4 TSS_ApplyDistanceBonus
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 754
;754:	}
ADDRGP4 $363
JUMPV
LABELV $362
line 755
;755:	else if (ga->group && ga->group != gi) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $364
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CVPU4 4
EQU4 $364
line 756
;756:		if (ga->group->designated1stLeader == ga->clientNum) {
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
NEI4 $366
line 757
;757:			dist = TSS_ApplyDistanceBonus(dist, 2.0f, -1000.0f);
ADDRLP4 0
INDIRF4
ARGF4
CNSTF4 1073741824
ARGF4
CNSTF4 3296329728
ARGF4
ADDRLP4 12
ADDRGP4 TSS_ApplyDistanceBonus
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ASGNF4
line 758
;758:		}
ADDRGP4 $367
JUMPV
LABELV $366
line 759
;759:		else if (ga->group->designated2ndLeader == ga->clientNum) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
NEI4 $368
line 760
;760:			dist = TSS_ApplyDistanceBonus(dist, 1.7f, -750.0f);
ADDRLP4 0
INDIRF4
ARGF4
CNSTF4 1071225242
ARGF4
CNSTF4 3292233728
ARGF4
ADDRLP4 16
ADDRGP4 TSS_ApplyDistanceBonus
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 761
;761:		}
ADDRGP4 $369
JUMPV
LABELV $368
line 762
;762:		else if (ga->group->designated3rdLeader == ga->clientNum) {
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
NEI4 $370
line 763
;763:			dist = TSS_ApplyDistanceBonus(dist, 1.4f, -500.0f);
ADDRLP4 0
INDIRF4
ARGF4
CNSTF4 1068708659
ARGF4
CNSTF4 3287941120
ARGF4
ADDRLP4 20
ADDRGP4 TSS_ApplyDistanceBonus
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 20
INDIRF4
ASGNF4
line 764
;764:		}
LABELV $370
LABELV $369
LABELV $367
line 765
;765:	}
LABELV $364
LABELV $363
LABELV $361
LABELV $359
line 767
;766:
;767:	return dist;
ADDRLP4 0
INDIRF4
RETF4
LABELV $320
endproc TSS_AdjustedGoalDistance 24 16
proc TSS_DistanceBasedGroupAssignment 40 12
line 775
;768:}
;769:
;770:/*
;771:===============
;772:JUHOX: TSS_DistanceBasedGroupAssignment
;773:===============
;774:*/
;775:static void TSS_DistanceBasedGroupAssignment(void) {
line 778
;776:	int as;
;777:
;778:	for (as = 0; as < tssNumGroupAssignments; as++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $376
JUMPV
LABELV $373
line 784
;779:		tss_groupAssignment_t* ga;
;780:		int gr;
;781:		vec_t bestDistance;
;782:		tss_groupInfo_t* bestGroup;
;783:
;784:		ga = &tssGroupAssignments[as];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 40
MULI4
ADDRGP4 tssGroupAssignments
ADDP4
ASGNP4
line 785
;785:		if (!ga->isAlive) continue;
ADDRLP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 0
NEI4 $377
ADDRGP4 $374
JUMPV
LABELV $377
line 787
;786:
;787:		bestDistance = 1000000000.0;
ADDRLP4 12
CNSTF4 1315859240
ASGNF4
line 788
;788:		bestGroup = NULL;
ADDRLP4 16
CNSTP4 0
ASGNP4
line 789
;789:		for (gr = 0; gr < MAX_GROUPS; gr++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $379
line 793
;790:			tss_groupInfo_t* gi;
;791:			vec_t distance;
;792:
;793:			gi = &tssGroupInfo[gr];
ADDRLP4 20
ADDRLP4 8
INDIRI4
CNSTI4 148
MULI4
ADDRGP4 tssGroupInfo
ADDP4
ASGNP4
line 794
;794:			if (gi->mission <= TSSMISSION_invalid) continue;
ADDRLP4 20
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 0
GTI4 $383
ADDRGP4 $380
JUMPV
LABELV $383
line 796
;795:			if (
;796:				ga->danger > gi->maxDanger &&
ADDRLP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ADDRLP4 20
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
LEI4 $385
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 20
INDIRP4
CVPU4 4
EQU4 $385
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRGP4 tssFlagCarrier
INDIRP4
CVPU4 4
EQU4 $385
line 799
;797:				ga->oldGroup != gi &&
;798:				ga != tssFlagCarrier
;799:			) {
line 800
;800:				continue;
ADDRGP4 $380
JUMPV
LABELV $385
line 803
;801:			}
;802:			
;803:			distance = TSS_AdjustedGoalDistance(ga, gi);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 TSS_AdjustedGoalDistance
CALLF4
ASGNF4
ADDRLP4 24
ADDRLP4 36
INDIRF4
ASGNF4
line 804
;804:			if (distance < bestDistance) {
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
GEF4 $387
line 805
;805:				bestDistance = distance;
ADDRLP4 12
ADDRLP4 24
INDIRF4
ASGNF4
line 806
;806:				bestGroup = gi;
ADDRLP4 16
ADDRLP4 20
INDIRP4
ASGNP4
line 807
;807:			}
LABELV $387
line 808
;808:		}
LABELV $380
line 789
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 10
LTI4 $379
line 809
;809:		if (bestGroup) {
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $389
line 810
;810:			TSS_MoveToGroupIfPossible(ga, bestGroup, TSSGAR_bestDistance);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 TSS_MoveToGroupIfPossible
CALLI4
pop
line 811
;811:		}
LABELV $389
line 812
;812:	}
LABELV $374
line 778
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $376
ADDRLP4 0
INDIRI4
ADDRGP4 tssNumGroupAssignments
INDIRI4
LTI4 $373
line 813
;813:}
LABELV $372
endproc TSS_DistanceBasedGroupAssignment 40 12
proc TSS_ReserveBestPlayerForGroup 28 12
line 823
;814:
;815:/*
;816:===============
;817:JUHOX: TSS_ReserveBestPlayerForGroup
;818:===============
;819:*/
;820:static qboolean TSS_ReserveBestPlayerForGroup(
;821:	tss_groupInfo_t* gi, qboolean mustBeAlive, qboolean mustBeReady,
;822:	tss_groupAssignmentReservation_t reservation
;823:) {
line 828
;824:	int as;
;825:	tss_groupAssignment_t* bestPlayer;
;826:	vec_t bestDistance;
;827:
;828:	if (!gi) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $392
line 829
;829:		G_Error("BUG! TSS_ReserveBestPlayerForGroup: gi=NULL");
ADDRGP4 $394
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 830
;830:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $391
JUMPV
LABELV $392
line 833
;831:	}
;832:
;833:	bestPlayer = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 834
;834:	bestDistance = 1000000000.0;
ADDRLP4 4
CNSTF4 1315859240
ASGNF4
line 835
;835:	for (as = 0; as < tssNumGroupAssignments; as++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $398
JUMPV
LABELV $395
line 839
;836:		tss_groupAssignment_t* ga;
;837:		vec_t dist;
;838:
;839:		ga = &tssGroupAssignments[as];
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 40
MULI4
ADDRGP4 tssGroupAssignments
ADDP4
ASGNP4
line 840
;840:		if (ga->group == gi) continue;
ADDRLP4 12
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
NEU4 $399
ADDRGP4 $396
JUMPV
LABELV $399
line 841
;841:		if ((mustBeAlive || mustBeReady) && !ga->isAlive) continue;
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $403
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $401
LABELV $403
ADDRLP4 12
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 0
NEI4 $401
ADDRGP4 $396
JUMPV
LABELV $401
line 842
;842:		if (mustBeReady && ga->danger > gi->maxDanger) continue;
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $404
ADDRLP4 12
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
LEI4 $404
ADDRGP4 $396
JUMPV
LABELV $404
line 843
;843:		if (!TSS_CanReserveGroupAssignment(ga, gi, reservation)) continue;
ADDRLP4 12
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 TSS_CanReserveGroupAssignment
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $406
ADDRGP4 $396
JUMPV
LABELV $406
line 845
;844:
;845:		dist = TSS_AdjustedGoalDistance(ga, gi);
ADDRLP4 12
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 TSS_AdjustedGoalDistance
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 24
INDIRF4
ASGNF4
line 846
;846:		if (dist >= bestDistance) continue;
ADDRLP4 16
INDIRF4
ADDRLP4 4
INDIRF4
LTF4 $408
ADDRGP4 $396
JUMPV
LABELV $408
line 848
;847:
;848:		bestDistance = dist;
ADDRLP4 4
ADDRLP4 16
INDIRF4
ASGNF4
line 849
;849:		bestPlayer = ga;
ADDRLP4 8
ADDRLP4 12
INDIRP4
ASGNP4
line 850
;850:	}
LABELV $396
line 835
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $398
ADDRLP4 0
INDIRI4
ADDRGP4 tssNumGroupAssignments
INDIRI4
LTI4 $395
line 851
;851:	if (!bestPlayer) return qfalse;
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $410
CNSTI4 0
RETI4
ADDRGP4 $391
JUMPV
LABELV $410
line 852
;852:	return TSS_MoveToGroupIfPossible(bestPlayer, gi, reservation);
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 TSS_MoveToGroupIfPossible
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
RETI4
LABELV $391
endproc TSS_ReserveBestPlayerForGroup 28 12
proc TSS_ConstraintBasedGroupAssignment 44 16
line 860
;853:}
;854:
;855:/*
;856:===============
;857:JUHOX: TSS_ConstraintBasedGroupAssignment
;858:===============
;859:*/
;860:static void TSS_ConstraintBasedGroupAssignment(tss_serverdata_t* tss) {
line 867
;861:	int gr;
;862:	tss_groupInfo_t* captureGroup;
;863:	int playersCapturing;
;864:	tss_groupInfo_t* defendGroup;
;865:	int playersDefending;
;866:
;867:	captureGroup = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 868
;868:	playersCapturing = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 869
;869:	defendGroup = NULL;
ADDRLP4 12
CNSTP4 0
ASGNP4
line 870
;870:	playersDefending = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 872
;871:
;872:	for (gr = 0; gr < MAX_GROUPS; gr++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $413
line 875
;873:		tss_groupInfo_t* gi;
;874:
;875:		gi = &tssGroupInfo[tss->instructions.groupOrganization[gr]];
ADDRLP4 20
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDP4
INDIRU1
CVUI4 1
CNSTI4 148
MULI4
ADDRGP4 tssGroupInfo
ADDP4
ASGNP4
line 876
;876:		if (gi->mission <= TSSMISSION_invalid) continue;
ADDRLP4 20
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 0
GTI4 $420
ADDRGP4 $414
JUMPV
LABELV $419
line 878
;877:
;878:		while (gi->readyPlayers < gi->minReadyPlayers) {
line 879
;879:			if (!TSS_ReserveBestPlayerForGroup(gi, qtrue, qtrue, TSSGAR_constraint)) break;
ADDRLP4 20
INDIRP4
ARGP4
CNSTI4 1
ARGI4
CNSTI4 1
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 24
ADDRGP4 TSS_ReserveBestPlayerForGroup
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $422
ADDRGP4 $425
JUMPV
LABELV $422
line 880
;880:		}
LABELV $420
line 878
ADDRLP4 20
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
ADDRLP4 20
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
LTI4 $419
ADDRGP4 $425
JUMPV
LABELV $424
line 882
;881:
;882:		while (gi->alivePlayers < gi->minAlivePlayers) {
line 883
;883:			if (!TSS_ReserveBestPlayerForGroup(gi, qtrue, qfalse, TSSGAR_constraint)) break;
ADDRLP4 20
INDIRP4
ARGP4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 28
ADDRGP4 TSS_ReserveBestPlayerForGroup
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $427
ADDRGP4 $430
JUMPV
LABELV $427
line 884
;884:		}
LABELV $425
line 882
ADDRLP4 20
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ADDRLP4 20
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
LTI4 $424
ADDRGP4 $430
JUMPV
LABELV $429
line 886
;885:
;886:		while (gi->totalPlayers < gi->minTotalPlayers) {
line 887
;887:			if (!TSS_ReserveBestPlayerForGroup(gi, qfalse, qfalse, TSSGAR_constraint)) break;
ADDRLP4 20
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 32
ADDRGP4 TSS_ReserveBestPlayerForGroup
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $432
ADDRGP4 $431
JUMPV
LABELV $432
line 888
;888:		}
LABELV $430
line 886
ADDRLP4 20
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ADDRLP4 20
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
LTI4 $429
LABELV $431
line 890
;889:
;890:		if (gi->mission == TSSMISSION_capture_enemy_flag) {
ADDRLP4 20
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 3
NEI4 $434
line 891
;891:			playersCapturing += gi->totalPlayers;
ADDRLP4 8
ADDRLP4 8
INDIRI4
ADDRLP4 20
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ADDI4
ASGNI4
line 893
;892:			if (
;893:				!captureGroup &&
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $435
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 12
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDP4
INDIRI4
CNSTI4 0
LEI4 $435
line 895
;894:				tss->instructions.division.group[gi->groupNum].minTotalMembers > 0
;895:			) {
line 896
;896:				captureGroup = gi;
ADDRLP4 4
ADDRLP4 20
INDIRP4
ASGNP4
line 897
;897:			}
line 898
;898:		}
ADDRGP4 $435
JUMPV
LABELV $434
line 899
;899:		else if (gi->mission == TSSMISSION_defend_our_flag) {
ADDRLP4 20
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 4
NEI4 $438
line 900
;900:			playersDefending += gi->totalPlayers;
ADDRLP4 16
ADDRLP4 16
INDIRI4
ADDRLP4 20
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ADDI4
ASGNI4
line 902
;901:			if (
;902:				!defendGroup &&
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $440
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 12
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDP4
INDIRI4
CNSTI4 0
LEI4 $440
line 904
;903:				tss->instructions.division.group[gi->groupNum].minTotalMembers > 0
;904:			) {
line 905
;905:				defendGroup = gi;
ADDRLP4 12
ADDRLP4 20
INDIRP4
ASGNP4
line 906
;906:			}
LABELV $440
line 907
;907:		}
LABELV $438
LABELV $435
line 908
;908:	}
LABELV $414
line 872
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 10
LTI4 $413
line 911
;909:
;910:	if (
;911:		captureGroup && playersCapturing <= 0 &&
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $442
ADDRLP4 8
INDIRI4
CNSTI4 0
GTI4 $442
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 OtherTeam
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 Team_GetFlagStatus
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $444
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 Team_GetFlagStatus
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $442
LABELV $444
line 916
;912:		(
;913:			Team_GetFlagStatus(OtherTeam(tss->team)) == FLAG_ATBASE ||
;914:			Team_GetFlagStatus(tss->team) == FLAG_ATBASE
;915:		)
;916:	) {
line 917
;917:		TSS_ReserveBestPlayerForGroup(captureGroup, qfalse, qfalse, TSSGAR_force);
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 TSS_ReserveBestPlayerForGroup
CALLI4
pop
line 918
;918:	}
ADDRGP4 $443
JUMPV
LABELV $442
line 920
;919:	else if (
;920:		defendGroup && playersDefending <= 0 &&
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $445
ADDRLP4 16
INDIRI4
CNSTI4 0
GTI4 $445
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 OtherTeam
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 Team_GetFlagStatus
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 1
NEI4 $445
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 40
ADDRGP4 Team_GetFlagStatus
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $445
line 923
;921:		Team_GetFlagStatus(OtherTeam(tss->team)) == FLAG_TAKEN &&
;922:		Team_GetFlagStatus(tss->team) != FLAG_ATBASE
;923:	) {
line 924
;924:		TSS_ReserveBestPlayerForGroup(defendGroup, qfalse, qfalse, TSSGAR_force);
ADDRLP4 12
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 TSS_ReserveBestPlayerForGroup
CALLI4
pop
line 925
;925:	}
LABELV $445
LABELV $443
line 926
;926:}
LABELV $412
endproc TSS_ConstraintBasedGroupAssignment 44 16
proc TSS_DetermineLeaders 28 8
line 933
;927:
;928:/*
;929:===============
;930:JUHOX: TSS_DetermineLeaders
;931:===============
;932:*/
;933:static void TSS_DetermineLeaders(void) {
line 936
;934:	int as;
;935:
;936:	for (as = 0; as < tssNumGroupAssignments; as++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $451
JUMPV
LABELV $448
line 940
;937:		tss_groupAssignment_t* ga;
;938:		vec_t dist;
;939:
;940:		ga = &tssGroupAssignments[as];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 40
MULI4
ADDRGP4 tssGroupAssignments
ADDP4
ASGNP4
line 941
;941:		if (!ga->isAlive) continue;
ADDRLP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 0
NEI4 $452
ADDRGP4 $449
JUMPV
LABELV $452
line 942
;942:		if (!ga->group) continue;	// should not happen
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $454
ADDRGP4 $449
JUMPV
LABELV $454
line 943
;943:		if (ga->danger > ga->group->maxDanger) continue;
ADDRLP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
LEI4 $456
ADDRGP4 $449
JUMPV
LABELV $456
line 944
;944:		if (ga == tssFlagCarrier) continue;
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRGP4 tssFlagCarrier
INDIRP4
CVPU4 4
NEU4 $458
ADDRGP4 $449
JUMPV
LABELV $458
line 946
;945:		
;946:		dist = TSS_AdjustedGoalDistance(ga, ga->group);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 TSS_AdjustedGoalDistance
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 20
INDIRF4
ASGNF4
line 947
;947:		if (dist < ga->group->leaderDistanceToGoal) {
ADDRLP4 8
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
GEF4 $460
line 948
;948:			ga->group->leaderDistanceToGoal = dist;
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
line 949
;949:			ga->group->currentLeader = ga;
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 950
;950:		}
LABELV $460
line 951
;951:	}
LABELV $449
line 936
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $451
ADDRLP4 0
INDIRI4
ADDRGP4 tssNumGroupAssignments
INDIRI4
LTI4 $448
line 952
;952:}
LABELV $447
endproc TSS_DetermineLeaders 28 8
proc TSS_PlayersCoOperate 16 12
line 959
;953:
;954:/*
;955:===============
;956:JUHOX: TSS_PlayersCoOperate
;957:===============
;958:*/
;959:static qboolean TSS_PlayersCoOperate(const tss_groupAssignment_t* ga1, const tss_groupAssignment_t* ga2, float laxity) {
line 962
;960:	float radius;
;961:
;962:	if (!ga1 || !ga2) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $465
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $463
LABELV $465
line 963
;963:		G_Error("BUG! TSS_PlayersCoOperate: ga1=%d, ga2=%d", (int)ga1, (int)ga2);
ADDRGP4 $466
ARGP4
ADDRFP4 0
INDIRP4
CVPU4 4
CVUI4 4
ARGI4
ADDRFP4 4
INDIRP4
CVPU4 4
CVUI4 4
ARGI4
ADDRGP4 G_Error
CALLV
pop
line 964
;964:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $462
JUMPV
LABELV $463
line 967
;965:	}
;966:
;967:	radius = 500 * (1 + laxity);
ADDRLP4 0
ADDRFP4 8
INDIRF4
CNSTF4 1065353216
ADDF4
CNSTF4 1140457472
MULF4
ASGNF4
line 968
;968:	return TSS_PlayerDistanceSqr(ga1, ga2) < radius * radius;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 TSS_PlayerDistanceSqr
CALLF4
ASGNF4
ADDRLP4 8
INDIRF4
ADDRLP4 0
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
GEF4 $468
ADDRLP4 4
CNSTI4 1
ASGNI4
ADDRGP4 $469
JUMPV
LABELV $468
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $469
ADDRLP4 4
INDIRI4
RETI4
LABELV $462
endproc TSS_PlayersCoOperate 16 12
bss
align 4
LABELV $474
skip 16384
code
proc TSS_CreateRescueSchedule 3668 16
line 991
;969:}
;970:
;971:/*
;972:==================
;973:JUHOX: TSS_CreateRescueSchedule
;974:==================
;975:*/
;976:typedef struct {
;977:	int numAssignments;
;978:	struct {
;979:		tss_groupAssignment_t* guard;
;980:		tss_groupAssignment_t* victim;
;981:	} assignments[MAX_CLIENTS];
;982:} tss_rescueSchedule_t;
;983:static tss_rescueSchedule_t tssRescueSchedule;
;984:typedef struct {
;985:	int usecnt;
;986:	tss_groupAssignment_t* player;
;987:	vec3_t origin;
;988:	int areanum;
;989:	int maxGuards;
;990:} tss_rescuePlayerInfo_t;
;991:static void TSS_CreateRescueSchedule(void) {
line 1000
;992:	int as;
;993:	tss_groupAssignment_t* ga;
;994:	int numVictims, numActiveVictims;
;995:	int numGuards, numActiveGuards;
;996:	tss_rescuePlayerInfo_t victims[MAX_CLIENTS];
;997:	tss_rescuePlayerInfo_t guards[MAX_CLIENTS];
;998:	static int travelTimeCache[MAX_CLIENTS][MAX_CLIENTS];
;999:
;1000:	numVictims = numGuards = 0;
ADDRLP4 3608
CNSTI4 0
ASGNI4
ADDRLP4 3588
ADDRLP4 3608
INDIRI4
ASGNI4
ADDRLP4 3584
ADDRLP4 3608
INDIRI4
ASGNI4
line 1001
;1001:	memset(&victims, 0, sizeof(victims));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1792
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1002
;1002:	memset(&guards, 0, sizeof(guards));
ADDRLP4 1792
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1792
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1003
;1003:	for (as = 0; as < tssNumGroupAssignments; as++) {
ADDRLP4 3600
CNSTI4 0
ASGNI4
ADDRGP4 $478
JUMPV
LABELV $475
line 1007
;1004:		tss_rescuePlayerInfo_t* rpi;
;1005:		int areanum;
;1006:
;1007:		ga = &tssGroupAssignments[as];
ADDRLP4 3592
ADDRLP4 3600
INDIRI4
CNSTI4 40
MULI4
ADDRGP4 tssGroupAssignments
ADDP4
ASGNP4
line 1008
;1008:		if (!ga->isAlive) continue;
ADDRLP4 3592
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 0
NEI4 $479
ADDRGP4 $476
JUMPV
LABELV $479
line 1009
;1009:		if (!ga->group) continue;	// rescue not managed by TSS
ADDRLP4 3592
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $481
ADDRGP4 $476
JUMPV
LABELV $481
line 1010
;1010:		areanum = BotPointAreaNum(ga->client->ps.origin);
ADDRLP4 3592
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 3620
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 3616
ADDRLP4 3620
INDIRI4
ASGNI4
line 1011
;1011:		if (areanum <= 0) continue;
ADDRLP4 3616
INDIRI4
CNSTI4 0
GTI4 $483
ADDRGP4 $476
JUMPV
LABELV $483
line 1013
;1012:
;1013:		if (ga->danger <= ga->group->maxDanger) {
ADDRLP4 3592
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ADDRLP4 3592
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
GTI4 $485
line 1014
;1014:			rpi = &guards[numGuards++];
ADDRLP4 3628
ADDRLP4 3588
INDIRI4
ASGNI4
ADDRLP4 3588
ADDRLP4 3628
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 3612
ADDRLP4 3628
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 1792
ADDP4
ASGNP4
line 1015
;1015:		} else {
ADDRGP4 $486
JUMPV
LABELV $485
line 1016
;1016:			rpi = &victims[numVictims++];
ADDRLP4 3628
ADDRLP4 3584
INDIRI4
ASGNI4
ADDRLP4 3584
ADDRLP4 3628
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 3612
ADDRLP4 3628
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 0
ADDP4
ASGNP4
line 1018
;1017:			if (
;1018:				ga->group->missionStatus == TSSMS_valid ||
ADDRLP4 3592
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
EQI4 $489
ADDRLP4 3592
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 0
EQI4 $487
LABELV $489
line 1020
;1019:				ga->group->protectFlagCarrier
;1020:			) {
line 1021
;1021:				rpi->maxGuards = ga->group->maxGuardsPerVictim;
ADDRLP4 3612
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 3592
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
ASGNI4
line 1022
;1022:			}
ADDRGP4 $488
JUMPV
LABELV $487
line 1023
;1023:			else {
line 1024
;1024:				rpi->maxGuards = 1000;
ADDRLP4 3612
INDIRP4
CNSTI4 24
ADDP4
CNSTI4 1000
ASGNI4
line 1025
;1025:			}
LABELV $488
line 1026
;1026:		}
LABELV $486
line 1028
;1027:
;1028:		rpi->player = ga;
ADDRLP4 3612
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 3592
INDIRP4
ASGNP4
line 1029
;1029:		rpi->areanum = areanum;
ADDRLP4 3612
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 3616
INDIRI4
ASGNI4
line 1030
;1030:		VectorCopy(ga->client->ps.origin, rpi->origin);
ADDRLP4 3612
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 3592
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 1031
;1031:	}
LABELV $476
line 1003
ADDRLP4 3600
ADDRLP4 3600
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $478
ADDRLP4 3600
INDIRI4
ADDRGP4 tssNumGroupAssignments
INDIRI4
LTI4 $475
line 1033
;1032:
;1033:	tssRescueSchedule.numAssignments = 0;
ADDRGP4 tssRescueSchedule
CNSTI4 0
ASGNI4
line 1034
;1034:	numActiveVictims = numVictims;
ADDRLP4 3596
ADDRLP4 3584
INDIRI4
ASGNI4
line 1035
;1035:	numActiveGuards = numGuards;
ADDRLP4 3604
ADDRLP4 3588
INDIRI4
ASGNI4
line 1036
;1036:	memset(&travelTimeCache, -1, sizeof(travelTimeCache));
ADDRGP4 $474
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 16384
ARGI4
ADDRGP4 memset
CALLP4
pop
ADDRGP4 $491
JUMPV
LABELV $490
line 1038
;1037:
;1038:	while (numActiveGuards > 0 && numActiveVictims > 0) {
line 1048
;1039:		int minusecnt;
;1040:		int maxDanger;
;1041:		tss_rescuePlayerInfo_t* rpi;
;1042:		int victim;
;1043:		int guard, assignedGuard, leaderGuard;
;1044:		tss_groupAssignment_t* leader;
;1045:		int bestTravelTime;
;1046:
;1047:		// find the most endangered victim of those with the least number of guards
;1048:		minusecnt = 1000000;
ADDRLP4 3624
CNSTI4 1000000
ASGNI4
line 1049
;1049:		maxDanger = -1000000;
ADDRLP4 3628
CNSTI4 -1000000
ASGNI4
line 1050
;1050:		rpi = NULL;
ADDRLP4 3620
CNSTP4 0
ASGNP4
line 1051
;1051:		for (victim = 0; victim < numVictims; victim++) {
ADDRLP4 3612
CNSTI4 0
ASGNI4
ADDRGP4 $496
JUMPV
LABELV $493
line 1052
;1052:			if (!victims[victim].player) continue;
ADDRLP4 3612
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 0+4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $497
ADDRGP4 $494
JUMPV
LABELV $497
line 1053
;1053:			if (victims[victim].usecnt > minusecnt) continue;
ADDRLP4 3612
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 0
ADDP4
INDIRI4
ADDRLP4 3624
INDIRI4
LEI4 $500
ADDRGP4 $494
JUMPV
LABELV $500
line 1054
;1054:			if (victims[victim].usecnt >= victims[victim].maxGuards) {
ADDRLP4 3612
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 0
ADDP4
INDIRI4
ADDRLP4 3612
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 0+24
ADDP4
INDIRI4
LTI4 $502
line 1055
;1055:				victims[victim].player = NULL;
ADDRLP4 3612
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 0+4
ADDP4
CNSTP4 0
ASGNP4
line 1056
;1056:				numActiveVictims--;
ADDRLP4 3596
ADDRLP4 3596
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1057
;1057:				continue;
ADDRGP4 $494
JUMPV
LABELV $502
line 1060
;1058:			}
;1059:			if (
;1060:				victims[victim].usecnt >= minusecnt &&
ADDRLP4 3612
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 0
ADDP4
INDIRI4
ADDRLP4 3624
INDIRI4
LTI4 $506
ADDRLP4 3612
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 0+4
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ADDRLP4 3628
INDIRI4
GTI4 $506
line 1062
;1061:				victims[victim].player->danger <= maxDanger
;1062:			) {
line 1063
;1063:				continue;
ADDRGP4 $494
JUMPV
LABELV $506
line 1066
;1064:			}
;1065:
;1066:			minusecnt = victims[victim].usecnt;
ADDRLP4 3624
ADDRLP4 3612
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 0
ADDP4
INDIRI4
ASGNI4
line 1067
;1067:			maxDanger = victims[victim].player->danger;
ADDRLP4 3628
ADDRLP4 3612
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 0+4
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ASGNI4
line 1068
;1068:			rpi = &victims[victim];
ADDRLP4 3620
ADDRLP4 3612
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 0
ADDP4
ASGNP4
line 1069
;1069:		}
LABELV $494
line 1051
ADDRLP4 3612
ADDRLP4 3612
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $496
ADDRLP4 3612
INDIRI4
ADDRLP4 3584
INDIRI4
LTI4 $493
line 1071
;1070:
;1071:		if (!rpi) return;
ADDRLP4 3620
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $510
ADDRGP4 $473
JUMPV
LABELV $510
line 1074
;1072:
;1073:		// find the nearest available guard
;1074:		bestTravelTime = 100000000;
ADDRLP4 3632
CNSTI4 100000000
ASGNI4
line 1075
;1075:		assignedGuard = -1;
ADDRLP4 3636
CNSTI4 -1
ASGNI4
line 1076
;1076:		leaderGuard = -1;
ADDRLP4 3644
CNSTI4 -1
ASGNI4
line 1077
;1077:		leader = rpi->player->group->currentLeader;
ADDRLP4 3640
ADDRLP4 3620
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ASGNP4
line 1078
;1078:		for (guard = 0; guard < numGuards; guard++) {
ADDRLP4 3616
CNSTI4 0
ASGNI4
ADDRGP4 $515
JUMPV
LABELV $512
line 1082
;1079:			int travelTime;
;1080:			tss_rescuePlayerInfo_t* grpi;
;1081:
;1082:			grpi = &guards[guard];
ADDRLP4 3648
ADDRLP4 3616
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 1792
ADDP4
ASGNP4
line 1083
;1083:			if (!grpi->player) continue;
ADDRLP4 3648
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $516
ADDRGP4 $513
JUMPV
LABELV $516
line 1085
;1084:			if (
;1085:				grpi->player->group != rpi->player->group &&
ADDRLP4 3648
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 3620
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CVPU4 4
EQU4 $518
ADDRLP4 3648
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 1
EQI4 $518
line 1087
;1086:				grpi->player->group->missionStatus != TSSMS_aborted
;1087:			) continue;
ADDRGP4 $513
JUMPV
LABELV $518
line 1088
;1088:			if (grpi->player == leader) {
ADDRLP4 3648
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 3640
INDIRP4
CVPU4 4
NEU4 $520
line 1089
;1089:				leaderGuard = guard;
ADDRLP4 3644
ADDRLP4 3616
INDIRI4
ASGNI4
line 1090
;1090:				continue;
ADDRGP4 $513
JUMPV
LABELV $520
line 1093
;1091:			}
;1092:
;1093:			travelTime = travelTimeCache[grpi->player->clientNum][rpi->player->clientNum];
ADDRLP4 3652
ADDRLP4 3620
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 3648
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 8
LSHI4
ADDRGP4 $474
ADDP4
ADDP4
INDIRI4
ASGNI4
line 1094
;1094:			if (travelTime < 0) {
ADDRLP4 3652
INDIRI4
CNSTI4 0
GEI4 $522
line 1095
;1095:				travelTime = trap_AAS_AreaTravelTimeToGoalArea(grpi->areanum, grpi->origin, rpi->areanum, TFL_DEFAULT);
ADDRLP4 3648
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ARGI4
ADDRLP4 3648
INDIRP4
CNSTI4 8
ADDP4
ARGP4
ADDRLP4 3620
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 3664
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 3652
ADDRLP4 3664
INDIRI4
ASGNI4
line 1096
;1096:				if (travelTime < 0) travelTime = 0;
ADDRLP4 3652
INDIRI4
CNSTI4 0
GEI4 $524
ADDRLP4 3652
CNSTI4 0
ASGNI4
LABELV $524
line 1097
;1097:				travelTimeCache[grpi->player->clientNum][rpi->player->clientNum] = travelTime;
ADDRLP4 3620
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 3648
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 8
LSHI4
ADDRGP4 $474
ADDP4
ADDP4
ADDRLP4 3652
INDIRI4
ASGNI4
line 1098
;1098:			}
LABELV $522
line 1099
;1099:			if (travelTime <= 0) continue;
ADDRLP4 3652
INDIRI4
CNSTI4 0
GTI4 $526
ADDRGP4 $513
JUMPV
LABELV $526
line 1100
;1100:			if (travelTime >= bestTravelTime) continue;
ADDRLP4 3652
INDIRI4
ADDRLP4 3632
INDIRI4
LTI4 $528
ADDRGP4 $513
JUMPV
LABELV $528
line 1102
;1101:
;1102:			bestTravelTime = travelTime;
ADDRLP4 3632
ADDRLP4 3652
INDIRI4
ASGNI4
line 1103
;1103:			assignedGuard = guard;
ADDRLP4 3636
ADDRLP4 3616
INDIRI4
ASGNI4
line 1104
;1104:		}
LABELV $513
line 1078
ADDRLP4 3616
ADDRLP4 3616
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $515
ADDRLP4 3616
INDIRI4
ADDRLP4 3588
INDIRI4
LTI4 $512
line 1106
;1105:		
;1106:		if (assignedGuard < 0) {
ADDRLP4 3636
INDIRI4
CNSTI4 0
GEI4 $530
line 1107
;1107:			assignedGuard = leaderGuard;
ADDRLP4 3636
ADDRLP4 3644
INDIRI4
ASGNI4
line 1108
;1108:		}
LABELV $530
line 1110
;1109:
;1110:		if (assignedGuard < 0) {
ADDRLP4 3636
INDIRI4
CNSTI4 0
GEI4 $532
line 1111
;1111:			rpi->player = NULL;
ADDRLP4 3620
INDIRP4
CNSTI4 4
ADDP4
CNSTP4 0
ASGNP4
line 1112
;1112:			numActiveVictims--;
ADDRLP4 3596
ADDRLP4 3596
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1113
;1113:			continue;
ADDRGP4 $491
JUMPV
LABELV $532
line 1116
;1114:		}
;1115:
;1116:		tssRescueSchedule.assignments[tssRescueSchedule.numAssignments].guard = guards[assignedGuard].player;
ADDRGP4 tssRescueSchedule
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 tssRescueSchedule+4
ADDP4
ADDRLP4 3636
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 1792+4
ADDP4
INDIRP4
ASGNP4
line 1117
;1117:		tssRescueSchedule.assignments[tssRescueSchedule.numAssignments].victim = rpi->player;
ADDRGP4 tssRescueSchedule
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 tssRescueSchedule+4+4
ADDP4
ADDRLP4 3620
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ASGNP4
line 1118
;1118:		tssRescueSchedule.numAssignments++;
ADDRLP4 3648
ADDRGP4 tssRescueSchedule
ASGNP4
ADDRLP4 3648
INDIRP4
ADDRLP4 3648
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1120
;1119:
;1120:		rpi->usecnt++;
ADDRLP4 3620
INDIRP4
ADDRLP4 3620
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1122
;1121:
;1122:		guards[assignedGuard].player = NULL;
ADDRLP4 3636
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 1792+4
ADDP4
CNSTP4 0
ASGNP4
line 1123
;1123:		numActiveGuards--;
ADDRLP4 3604
ADDRLP4 3604
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1124
;1124:	}
LABELV $491
line 1038
ADDRLP4 3604
INDIRI4
CNSTI4 0
LEI4 $539
ADDRLP4 3596
INDIRI4
CNSTI4 0
GTI4 $490
LABELV $539
line 1125
;1125:}
LABELV $473
endproc TSS_CreateRescueSchedule 3668 16
proc TSS_RescueTeamMate 4 4
line 1132
;1126:
;1127:/*
;1128:==================
;1129:JUHOX: TSS_RescueTeamMate
;1130:==================
;1131:*/
;1132:static tss_groupAssignment_t* TSS_RescueTeamMate(const tss_groupAssignment_t* ga) {
line 1135
;1133:	int as;
;1134:
;1135:	if (!ga) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $541
line 1136
;1136:		G_Error("BUG! TSS_RescueTeamMate: ga=NULL");
ADDRGP4 $543
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 1137
;1137:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $540
JUMPV
LABELV $541
line 1140
;1138:	}
;1139:
;1140:	for (as = 0; as < tssRescueSchedule.numAssignments; as++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $547
JUMPV
LABELV $544
line 1141
;1141:		if (tssRescueSchedule.assignments[as].guard != ga) continue;
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 tssRescueSchedule+4
ADDP4
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
EQU4 $548
ADDRGP4 $545
JUMPV
LABELV $548
line 1143
;1142:
;1143:		return tssRescueSchedule.assignments[as].victim;
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 tssRescueSchedule+4+4
ADDP4
INDIRP4
RETP4
ADDRGP4 $540
JUMPV
LABELV $545
line 1140
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $547
ADDRLP4 0
INDIRI4
ADDRGP4 tssRescueSchedule
INDIRI4
LTI4 $544
line 1146
;1144:	}
;1145:
;1146:	return NULL;
CNSTP4 0
RETP4
LABELV $540
endproc TSS_RescueTeamMate 4 4
proc TSS_GroupSize 44 12
line 1154
;1147:}
;1148:
;1149:/*
;1150:===============
;1151:JUHOX: TSS_GroupSize
;1152:===============
;1153:*/
;1154:static int TSS_GroupSize(const tss_groupInfo_t* gi) {
line 1159
;1155:	int as;
;1156:	int size;
;1157:	float formationLaxity;
;1158:
;1159:	if (!gi) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $554
line 1160
;1160:		G_Error("BUG! TSS_GroupSize: gi=NULL");
ADDRGP4 $556
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 1161
;1161:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $553
JUMPV
LABELV $554
line 1164
;1162:	}
;1163:
;1164:	switch (gi->groupFormation) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $560
ADDRLP4 12
INDIRI4
CNSTI4 1
EQI4 $561
ADDRLP4 12
INDIRI4
CNSTI4 2
EQI4 $562
ADDRGP4 $557
JUMPV
LABELV $560
LABELV $557
line 1167
;1165:	case TSSGF_tight:
;1166:	default:
;1167:		formationLaxity = 0.0f;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 1168
;1168:		break;
ADDRGP4 $558
JUMPV
LABELV $561
line 1170
;1169:	case TSSGF_loose:
;1170:		formationLaxity = 1.0f;
ADDRLP4 8
CNSTF4 1065353216
ASGNF4
line 1171
;1171:		break;
ADDRGP4 $558
JUMPV
LABELV $562
line 1173
;1172:	case TSSGF_free:
;1173:		formationLaxity = 2.0f;
ADDRLP4 8
CNSTF4 1073741824
ASGNF4
line 1174
;1174:		break;
LABELV $558
line 1177
;1175:	}
;1176:
;1177:	size = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1178
;1178:	for (as = 0; as < tssNumGroupAssignments; as++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $566
JUMPV
LABELV $563
line 1182
;1179:		tss_groupAssignment_t* ga;
;1180:		qboolean coOperation;
;1181:
;1182:		ga = &tssGroupAssignments[as];
ADDRLP4 20
ADDRLP4 0
INDIRI4
CNSTI4 40
MULI4
ADDRGP4 tssGroupAssignments
ADDP4
ASGNP4
line 1183
;1183:		if (ga->group != gi) continue;
ADDRLP4 20
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
EQU4 $567
ADDRGP4 $564
JUMPV
LABELV $567
line 1185
;1184:
;1185:		coOperation = ga->client->tssCoOperatingWithGroupLeader;
ADDRLP4 24
ADDRLP4 20
INDIRP4
INDIRP4
CNSTI4 764
ADDP4
INDIRI4
ASGNI4
line 1186
;1186:		ga->client->tssCoOperatingWithGroupLeader = qfalse;
ADDRLP4 20
INDIRP4
INDIRP4
CNSTI4 764
ADDP4
CNSTI4 0
ASGNI4
line 1187
;1187:		if (!ga->isAlive) continue;
ADDRLP4 20
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 0
NEI4 $569
ADDRGP4 $564
JUMPV
LABELV $569
line 1188
;1188:		if (ga->danger > gi->maxDanger) continue;
ADDRLP4 20
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
LEI4 $571
ADDRGP4 $564
JUMPV
LABELV $571
line 1189
;1189:		if (!gi->currentLeader) continue;
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $573
ADDRGP4 $564
JUMPV
LABELV $573
line 1191
;1190:		if (
;1191:			ga != gi->currentLeader &&
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CVPU4 4
ADDRLP4 36
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CVPU4 4
EQU4 $575
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $578
ADDRLP4 28
CNSTF4 1056964608
ASGNF4
ADDRGP4 $579
JUMPV
LABELV $578
ADDRLP4 28
CNSTF4 3197737370
ASGNF4
LABELV $579
ADDRLP4 8
INDIRF4
ADDRLP4 28
INDIRF4
ADDF4
ARGF4
ADDRLP4 40
ADDRGP4 TSS_PlayersCoOperate
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $575
line 1193
;1192:			!TSS_PlayersCoOperate(ga, gi->currentLeader, formationLaxity + (coOperation? 0.5f : -0.3f))
;1193:		) {
line 1194
;1194:			continue;
ADDRGP4 $564
JUMPV
LABELV $575
line 1197
;1195:		}
;1196:
;1197:		ga->client->tssCoOperatingWithGroupLeader = qtrue;
ADDRLP4 20
INDIRP4
INDIRP4
CNSTI4 764
ADDP4
CNSTI4 1
ASGNI4
line 1198
;1198:		size++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1199
;1199:	}
LABELV $564
line 1178
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $566
ADDRLP4 0
INDIRI4
ADDRGP4 tssNumGroupAssignments
INDIRI4
LTI4 $563
line 1201
;1200:
;1201:	return size;
ADDRLP4 4
INDIRI4
RETI4
LABELV $553
endproc TSS_GroupSize 44 12
proc TSS_DetermineMissionStatus 96 12
line 1209
;1202:}
;1203:
;1204:/*
;1205:===============
;1206:JUHOX: TSS_DetermineMissionStatus
;1207:===============
;1208:*/
;1209:static void TSS_DetermineMissionStatus(tss_serverdata_t* tss) {
line 1213
;1210:	int gr;
;1211:	tss_groupInfo_t* gi;
;1212:
;1213:	for (gr = 0; gr < MAX_GROUPS; gr++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $581
line 1218
;1214:		tss_missionStatus_t oldMS;
;1215:		qboolean oldPFC;
;1216:		int groupSize;
;1217:
;1218:		gi = &tssGroupInfo[gr];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 148
MULI4
ADDRGP4 tssGroupInfo
ADDP4
ASGNP4
line 1220
;1219:
;1220:		oldMS = gi->missionStatus;
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
ASGNI4
line 1221
;1221:		oldPFC = gi->protectFlagCarrier;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ASGNI4
line 1222
;1222:		gi->missionStatus = TSSMS_valid;
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
CNSTI4 0
ASGNI4
line 1223
;1223:		gi->protectFlagCarrier = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 144
ADDP4
CNSTI4 0
ASGNI4
line 1225
;1224:
;1225:		groupSize = TSS_GroupSize(gi);	// also sets gclient_t::tssCoOperatingWithGroupLeader
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 TSS_GroupSize
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 20
INDIRI4
ASGNI4
line 1226
;1226:		tss->tidiness += 100 * groupSize;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 664
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
ADDRLP4 8
INDIRI4
CNSTI4 100
MULI4
ADDI4
ASGNI4
line 1228
;1227:
;1228:		if (!gi->currentLeader) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $585
line 1229
;1229:			gi->groupFormation = TSSGF_free;
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 2
ASGNI4
line 1230
;1230:		}
LABELV $585
line 1233
;1231:
;1232:		if (
;1233:			tssFlagCarrier &&
ADDRLP4 28
ADDRGP4 tssFlagCarrier
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $587
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 28
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CVPU4 4
EQU4 $589
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 3
NEI4 $587
LABELV $589
line 1238
;1234:			(
;1235:				gi == tssFlagCarrier->group ||
;1236:				gi->mission == TSSMISSION_capture_enemy_flag
;1237:			)
;1238:		) {
line 1239
;1239:			gi->protectFlagCarrier = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 144
ADDP4
CNSTI4 1
ASGNI4
line 1241
;1240:			if (
;1241:				gi->mission != TSSMISSION_capture_enemy_flag &&
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 3
EQI4 $588
ADDRGP4 tssFlagCarrier
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 4
GEI4 $588
line 1243
;1242:				tssFlagCarrier->reservation < TSSGAR_force
;1243:			) {
line 1244
;1244:				gi->missionStatus = TSSMS_aborted;
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
CNSTI4 1
ASGNI4
line 1245
;1245:			}
line 1246
;1246:		}
ADDRGP4 $588
JUMPV
LABELV $587
line 1259
;1247:		/* NOTE: this adaption can and should be done by the TSS client
;1248:		else if (
;1249:			(
;1250:				gi->mission == TSSMISSION_capture_enemy_flag ||
;1251:				gi->mission == TSSMISSION_occupy_enemy_base
;1252:			) &&
;1253:			Team_GetFlagStatus(tss->team) != FLAG_ATBASE
;1254:		) {
;1255:			// case of emergency! do NOT abort this important mission!
;1256:		}
;1257:		*/
;1258:		else if (
;1259:			!gi->currentLeader ||
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $595
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ARGI4
CNSTI4 100
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ARGI4
ADDRLP4 40
ADDRGP4 TSS_Proportion_RoundToCeil
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
ADDRLP4 40
INDIRI4
LTI4 $595
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
NEI4 $592
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ARGI4
CNSTI4 100
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
ADDRGP4 TSS_Proportion_RoundToCeil
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
ADDRLP4 48
INDIRI4
GEI4 $592
LABELV $595
line 1267
;1260:			//gi->alivePlayers < gi->minAlivePlayers ||
;1261:			//gi->readyPlayers < gi->minReadyPlayers ||
;1262:			gi->readyPlayers < TSS_Proportion_RoundToCeil(gi->minReadyForMission, 100, gi->alivePlayers) ||
;1263:			(
;1264:				gi->groupFormation == TSSGF_tight &&
;1265:				groupSize < TSS_Proportion_RoundToCeil(gi->minGroupSize, 100, gi->alivePlayers)
;1266:			)
;1267:		) {
line 1268
;1268:			gi->missionStatus = TSSMS_aborted;
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
CNSTI4 1
ASGNI4
line 1269
;1269:		}
ADDRGP4 $593
JUMPV
LABELV $592
line 1271
;1270:		else if (
;1271:			tssFlagCarrier &&
ADDRLP4 64
ADDRGP4 tssFlagCarrier
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $596
ADDRLP4 64
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $596
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 6
NEI4 $596
ADDRLP4 64
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $601
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $602
ADDRLP4 52
CNSTF4 3197737370
ASGNF4
ADDRGP4 $603
JUMPV
LABELV $602
ADDRLP4 52
CNSTF4 1050253722
ASGNF4
LABELV $603
ADDRLP4 52
INDIRF4
ARGF4
ADDRLP4 68
ADDRGP4 TSS_PlayersCoOperate
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
NEI4 $596
ADDRGP4 tssFlagCarrier
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 72
ADDRGP4 TSS_PlayerDistanceSqr
CALLF4
ASGNF4
ADDRLP4 76
ADDRGP4 tssFlagCarrier
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRLP4 76
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 80
ADDRGP4 TSS_PlayerDistanceSqr
CALLF4
ASGNF4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $604
ADDRLP4 56
CNSTF4 1133903872
ASGNF4
ADDRGP4 $605
JUMPV
LABELV $604
ADDRLP4 56
CNSTF4 0
ASGNF4
LABELV $605
ADDRLP4 72
INDIRF4
ADDRLP4 80
INDIRF4
ADDRLP4 56
INDIRF4
ADDF4
GEF4 $596
LABELV $601
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 84
ADDRGP4 OtherTeam
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
ARGI4
ADDRGP4 tssFlagCarrier
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $606
ADDRLP4 60
CNSTF4 1082130432
ASGNF4
ADDRGP4 $607
JUMPV
LABELV $606
ADDRLP4 60
CNSTF4 1091567616
ASGNF4
LABELV $607
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 88
ADDRGP4 NearHomeBase
CALLI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 0
EQI4 $596
line 1292
;1272:			tssFlagCarrier->group &&
;1273:			gi->mission == TSSMISSION_occupy_enemy_base &&
;1274:			(
;1275:				!tssFlagCarrier->group->currentLeader ||
;1276:				(
;1277:					!TSS_PlayersCoOperate(
;1278:						tssFlagCarrier, tssFlagCarrier->group->currentLeader,
;1279:						oldPFC? -0.3f : 0.3f
;1280:					) &&
;1281:					(
;1282:						TSS_PlayerDistanceSqr(tssFlagCarrier, gi->currentLeader) <
;1283:						TSS_PlayerDistanceSqr(tssFlagCarrier, tssFlagCarrier->group->currentLeader)
;1284:							+ (oldPFC? 300.0f : 0.0f)
;1285:					)
;1286:				)
;1287:			) &&
;1288:			NearHomeBase(
;1289:				OtherTeam(tss->team), tssFlagCarrier->client->ps.origin,
;1290:				oldPFC? 4.0f : 9.0f
;1291:			)
;1292:		) {
line 1293
;1293:			gi->missionStatus = TSSMS_aborted;
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
CNSTI4 1
ASGNI4
line 1294
;1294:			gi->protectFlagCarrier = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 144
ADDP4
CNSTI4 1
ASGNI4
line 1295
;1295:		}
LABELV $596
LABELV $593
LABELV $588
line 1297
;1296:
;1297:		tss->missionStatus[gr] = gi->missionStatus;
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 556
ADDP4
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
ASGNI4
line 1298
;1298:		tss->protectFlagCarrier[gr] = gi->protectFlagCarrier;
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 596
ADDP4
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ASGNI4
line 1299
;1299:		tss->currentLeaders[gr] = gi->currentLeader? gi->currentLeader->clientNum : -1;
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $609
ADDRLP4 92
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $610
JUMPV
LABELV $609
ADDRLP4 92
CNSTI4 -1
ASGNI4
LABELV $610
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 476
ADDP4
ADDP4
ADDRLP4 92
INDIRI4
ASGNI4
line 1300
;1300:	}
LABELV $582
line 1213
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 10
LTI4 $581
line 1302
;1301:
;1302:	if (tssNumPlayersAlive > 0) {
ADDRGP4 tssNumPlayersAlive
INDIRI4
CNSTI4 0
LEI4 $611
line 1303
;1303:		tss->tidiness /= tssNumPlayersAlive;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 664
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
ADDRGP4 tssNumPlayersAlive
INDIRI4
DIVI4
ASGNI4
line 1304
;1304:	}
LABELV $611
line 1305
;1305:}
LABELV $580
endproc TSS_DetermineMissionStatus 96 12
proc TSS_AssignTask 72 16
line 1316
;1306:
;1307:/*
;1308:===============
;1309:JUHOX: TSS_AssignTask
;1310:===============
;1311:*/
;1312:static tss_missionTask_t TSS_AssignTask(
;1313:	const tss_groupAssignment_t* ga, tss_groupMemberStatus_t gms, tss_groupFormation_t formation,
;1314:	int leader,
;1315:	int* taskGoal	// result
;1316:) {
line 1319
;1317:	tss_groupAssignment_t* teammate;
;1318:
;1319:	*taskGoal = -1;
ADDRFP4 16
INDIRP4
CNSTI4 -1
ASGNI4
line 1320
;1320:	if (!ga) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $614
line 1321
;1321:		G_Error("BUG! TSS_AssignTask: ga=NULL");
ADDRGP4 $616
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 1322
;1322:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $613
JUMPV
LABELV $614
line 1324
;1323:	}
;1324:	if (!ga->group) return -1;
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $617
CNSTI4 -1
RETI4
ADDRGP4 $613
JUMPV
LABELV $617
line 1326
;1325:
;1326:	if (gms == TSSGMS_retreating) {
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $619
line 1327
;1327:		return TSSMT_retreat;
CNSTI4 2
RETI4
ADDRGP4 $613
JUMPV
LABELV $619
line 1330
;1328:	}
;1329:
;1330:	if (tssFlagCarrier && tssHomeBase && tssFlagCarrier->reservation < TSSGAR_force) {
ADDRLP4 4
ADDRGP4 tssFlagCarrier
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $621
ADDRGP4 tssHomeBase
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $621
ADDRLP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 4
GEI4 $621
line 1333
;1331:		tss_missionTask_t oldTask;
;1332:
;1333:		if (BG_TSS_GetPlayerInfo(&ga->client->ps, TSSPI_isValid)) {
ADDRFP4 0
INDIRP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 12
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $623
line 1334
;1334:			oldTask = BG_TSS_GetPlayerInfo(&ga->client->ps, TSSPI_task);
ADDRFP4 0
INDIRP4
INDIRP4
ARGP4
CNSTI4 5
ARGI4
ADDRLP4 16
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 16
INDIRI4
ASGNI4
line 1335
;1335:		}
ADDRGP4 $624
JUMPV
LABELV $623
line 1336
;1336:		else {
line 1337
;1337:			oldTask = -1;
ADDRLP4 8
CNSTI4 -1
ASGNI4
line 1338
;1338:		}
LABELV $624
line 1340
;1339:
;1340:		if (ga == tssFlagCarrier) {
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 tssFlagCarrier
INDIRP4
CVPU4 4
NEU4 $625
line 1341
;1341:			if (!ga->group->currentLeader) {
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $627
line 1342
;1342:				return TSSMT_rushToBase;
CNSTI4 5
RETI4
ADDRGP4 $613
JUMPV
LABELV $627
line 1345
;1343:			}
;1344:			else if (
;1345:				!ga->isFighting &&
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
NEI4 $629
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 5
NEI4 $632
ADDRLP4 16
CNSTF4 3197737370
ASGNF4
ADDRGP4 $633
JUMPV
LABELV $632
ADDRLP4 16
CNSTF4 1050253722
ASGNF4
LABELV $633
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 24
ADDRGP4 TSS_PlayersCoOperate
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $629
ADDRFP4 0
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRGP4 tssHomeBase
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 28
INDIRF4
CNSTF4 1226588160
LEF4 $629
line 1352
;1346:				TSS_PlayersCoOperate(
;1347:					ga, ga->group->currentLeader,
;1348:					oldTask == TSSMT_rushToBase? -0.3f : 0.3f
;1349:				) &&
;1350:				//!NearHomeBase(ga->client->sess.sessionTeam, ga->client->ps.origin, 9)
;1351:				DistanceSquared(ga->client->ps.origin, tssHomeBase->origin) > Square(800.0f)
;1352:			) {
line 1353
;1353:				*taskGoal = leader;
ADDRFP4 16
INDIRP4
ADDRFP4 12
INDIRI4
ASGNI4
line 1354
;1354:				return TSSMT_stickToGroupLeader;
CNSTI4 1
RETI4
ADDRGP4 $613
JUMPV
LABELV $629
line 1356
;1355:			}
;1356:			else {
line 1357
;1357:				return TSSMT_rushToBase;
CNSTI4 5
RETI4
ADDRGP4 $613
JUMPV
LABELV $625
line 1360
;1358:			}
;1359:		}
;1360:		else if (ga == tssFlagCarrier->group->currentLeader) {
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 tssFlagCarrier
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CVPU4 4
NEU4 $634
line 1362
;1361:			if (
;1362:				tssFlagCarrier->danger > ga->group->maxDanger ||
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 tssFlagCarrier
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ADDRLP4 16
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
GTI4 $638
ADDRLP4 16
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRGP4 tssHomeBase
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 20
INDIRF4
CNSTF4 1209810944
GEF4 $636
LABELV $638
line 1364
;1363:				DistanceSquared(ga->client->ps.origin, tssHomeBase->origin) < Square(400.0f)
;1364:			) {
line 1365
;1365:				*taskGoal = tssFlagCarrier->clientNum;
ADDRFP4 16
INDIRP4
ADDRGP4 tssFlagCarrier
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1366
;1366:				return TSSMT_guardFlagCarrier;
CNSTI4 4
RETI4
ADDRGP4 $613
JUMPV
LABELV $636
line 1368
;1367:			}
;1368:			else if (TSS_PlayersCoOperate(ga, tssFlagCarrier, oldTask == TSSMT_rushToBase? 0.3f : -0.3f)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 tssFlagCarrier
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 5
NEI4 $642
ADDRLP4 24
CNSTF4 1050253722
ASGNF4
ADDRGP4 $643
JUMPV
LABELV $642
ADDRLP4 24
CNSTF4 3197737370
ASGNF4
LABELV $643
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 28
ADDRGP4 TSS_PlayersCoOperate
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $639
line 1369
;1369:				*taskGoal = tssFlagCarrier->clientNum;
ADDRFP4 16
INDIRP4
ADDRGP4 tssFlagCarrier
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1370
;1370:				return TSSMT_rushToBase;
CNSTI4 5
RETI4
ADDRGP4 $613
JUMPV
LABELV $639
line 1372
;1371:			}
;1372:			else {
line 1373
;1373:				*taskGoal = tssFlagCarrier->clientNum;
ADDRFP4 16
INDIRP4
ADDRGP4 tssFlagCarrier
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1374
;1374:				return TSSMT_seekGroupMember;
CNSTI4 6
RETI4
ADDRGP4 $613
JUMPV
LABELV $634
line 1378
;1375:			}
;1376:		}
;1377:		else if (
;1378:			ga->group == tssFlagCarrier->group ||
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 tssFlagCarrier
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CVPU4 4
EQU4 $647
ADDRLP4 16
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 0
NEI4 $647
ADDRLP4 16
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 3
NEI4 $644
LABELV $647
line 1381
;1379:			ga->group->protectFlagCarrier ||
;1380:			ga->group->mission == TSSMISSION_capture_enemy_flag
;1381:		) {
line 1382
;1382:			if (TSS_PlayersCoOperate(ga, tssFlagCarrier, oldTask == TSSMT_guardFlagCarrier? 0.5f : -0.3f)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 tssFlagCarrier
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 4
NEI4 $651
ADDRLP4 20
CNSTF4 1056964608
ASGNF4
ADDRGP4 $652
JUMPV
LABELV $651
ADDRLP4 20
CNSTF4 3197737370
ASGNF4
LABELV $652
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 24
ADDRGP4 TSS_PlayersCoOperate
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $648
line 1383
;1383:				*taskGoal = tssFlagCarrier->clientNum;
ADDRFP4 16
INDIRP4
ADDRGP4 tssFlagCarrier
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1384
;1384:				return TSSMT_guardFlagCarrier;
CNSTI4 4
RETI4
ADDRGP4 $613
JUMPV
LABELV $648
line 1386
;1385:			}
;1386:			else {
line 1387
;1387:				*taskGoal = tssFlagCarrier->clientNum;
ADDRFP4 16
INDIRP4
ADDRGP4 tssFlagCarrier
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1388
;1388:				return TSSMT_seekGroupMember;
CNSTI4 6
RETI4
ADDRGP4 $613
JUMPV
LABELV $644
line 1391
;1389:			}
;1390:		}
;1391:	}
LABELV $621
line 1393
;1392:
;1393:	teammate = TSS_RescueTeamMate(ga);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 TSS_RescueTeamMate
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 1394
;1394:	if (teammate) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $653
line 1395
;1395:		*taskGoal = teammate->clientNum;
ADDRFP4 16
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1396
;1396:		return TSSMT_helpTeamMate;
CNSTI4 3
RETI4
ADDRGP4 $613
JUMPV
LABELV $653
line 1400
;1397:	}
;1398:
;1399:	if (
;1400:		gms == TSSGMS_designatedLeader ||
ADDRLP4 12
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 4
EQI4 $658
ADDRLP4 12
INDIRI4
CNSTI4 3
EQI4 $658
ADDRFP4 8
INDIRI4
CNSTI4 2
NEI4 $655
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 1
EQI4 $655
LABELV $658
line 1406
;1401:		gms == TSSGMS_temporaryLeader ||
;1402:		(
;1403:			formation == TSSGF_free &&
;1404:			ga->group->missionStatus != TSSMS_aborted
;1405:		)
;1406:	) {
line 1408
;1407:		if (
;1408:			ga->group->mission == TSSMISSION_seek_enemy &&
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 1
NEI4 $659
ADDRLP4 16
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 1
EQI4 $659
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 IsPlayerInvolvedInFighting
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $659
line 1411
;1409:			ga->group->missionStatus != TSSMS_aborted &&
;1410:			!IsPlayerInvolvedInFighting(ga->clientNum)
;1411:		) {
line 1416
;1412:			int as;
;1413:			int bestDist;
;1414:			const tss_groupAssignment_t* nearestFighter;
;1415:
;1416:			bestDist = 1000000;
ADDRLP4 28
CNSTI4 1000000
ASGNI4
line 1417
;1417:			nearestFighter = NULL;
ADDRLP4 32
CNSTP4 0
ASGNP4
line 1418
;1418:			for (as = 0; as < tssNumGroupAssignments; as++) {
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRGP4 $664
JUMPV
LABELV $661
line 1421
;1419:				const tss_groupAssignment_t* other;
;1420:
;1421:				other = &tssGroupAssignments[as];
ADDRLP4 36
ADDRLP4 24
INDIRI4
CNSTI4 40
MULI4
ADDRGP4 tssGroupAssignments
ADDP4
ASGNP4
line 1422
;1422:				if (other == ga) continue;
ADDRLP4 36
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
NEU4 $665
ADDRGP4 $662
JUMPV
LABELV $665
line 1425
;1423:
;1424:				if (
;1425:					other->isAlive &&
ADDRLP4 36
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 0
EQI4 $667
ADDRLP4 36
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ARGI4
ADDRLP4 44
ADDRGP4 IsPlayerInvolvedInFighting
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $667
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 52
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CVPU4 4
NEU4 $669
ADDRLP4 52
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
ARGP4
CNSTF4 3197737370
ARGF4
ADDRLP4 56
ADDRGP4 TSS_PlayersCoOperate
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
NEI4 $667
LABELV $669
line 1431
;1426:					IsPlayerInvolvedInFighting(other->clientNum) &&
;1427:					(
;1428:						other->group != ga->group ||
;1429:						!TSS_PlayersCoOperate(ga, other, -0.3f)
;1430:					)
;1431:				) {
line 1434
;1432:					int dist;
;1433:
;1434:					dist = trap_AAS_AreaTravelTimeToGoalArea(
ADDRLP4 64
ADDRFP4 0
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
ARGI4
ADDRLP4 64
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 36
INDIRP4
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 68
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 60
ADDRLP4 68
INDIRI4
ASGNI4
line 1438
;1435:						ga->client->tssLastValidAreaNum, ga->client->ps.origin,
;1436:						other->client->tssLastValidAreaNum, TFL_DEFAULT
;1437:					);
;1438:					if (ga->oldTaskGoal == other->clientNum) dist -= 300;
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ADDRLP4 36
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
NEI4 $670
ADDRLP4 60
ADDRLP4 60
INDIRI4
CNSTI4 300
SUBI4
ASGNI4
LABELV $670
line 1439
;1439:					if (dist < bestDist) {
ADDRLP4 60
INDIRI4
ADDRLP4 28
INDIRI4
GEI4 $672
line 1440
;1440:						bestDist = dist;
ADDRLP4 28
ADDRLP4 60
INDIRI4
ASGNI4
line 1441
;1441:						nearestFighter = other;
ADDRLP4 32
ADDRLP4 36
INDIRP4
ASGNP4
line 1442
;1442:					}
LABELV $672
line 1443
;1443:				}
LABELV $667
line 1444
;1444:			}
LABELV $662
line 1418
ADDRLP4 24
ADDRLP4 24
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $664
ADDRLP4 24
INDIRI4
ADDRGP4 tssNumGroupAssignments
INDIRI4
LTI4 $661
line 1445
;1445:			if (nearestFighter) {
ADDRLP4 32
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $674
line 1446
;1446:				*taskGoal = nearestFighter->clientNum;
ADDRFP4 16
INDIRP4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1447
;1447:				return TSSMT_seekEnemyNearTeamMate;
CNSTI4 7
RETI4
ADDRGP4 $613
JUMPV
LABELV $674
line 1449
;1448:			}
;1449:		}
LABELV $659
line 1451
;1450:
;1451:		if (ga->group->missionStatus == TSSMS_aborted) {
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 1
NEI4 $676
line 1456
;1452:			int as;
;1453:			int nearestDist;
;1454:			const tss_groupAssignment_t* nearestTeammate;
;1455:
;1456:			nearestDist = 1000000;
ADDRLP4 28
CNSTI4 1000000
ASGNI4
line 1457
;1457:			nearestTeammate = NULL;
ADDRLP4 32
CNSTP4 0
ASGNP4
line 1458
;1458:			for (as = 0; as < tssNumGroupAssignments; as++) {
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRGP4 $681
JUMPV
LABELV $678
line 1462
;1459:				const tss_groupAssignment_t* other;
;1460:				int dist;
;1461:
;1462:				other = &tssGroupAssignments[as];
ADDRLP4 36
ADDRLP4 24
INDIRI4
CNSTI4 40
MULI4
ADDRGP4 tssGroupAssignments
ADDP4
ASGNP4
line 1463
;1463:				if (!other->isAlive) continue;
ADDRLP4 36
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 0
NEI4 $682
ADDRGP4 $679
JUMPV
LABELV $682
line 1464
;1464:				if (other->group != ga->group) continue;
ADDRLP4 36
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CVPU4 4
EQU4 $684
ADDRGP4 $679
JUMPV
LABELV $684
line 1465
;1465:				if (TSS_PlayersCoOperate(ga, other, 0.0f)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRLP4 44
ADDRGP4 TSS_PlayersCoOperate
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $686
line 1466
;1466:					nearestTeammate = NULL;
ADDRLP4 32
CNSTP4 0
ASGNP4
line 1467
;1467:					break;
ADDRGP4 $680
JUMPV
LABELV $686
line 1469
;1468:				}
;1469:				dist = trap_AAS_AreaTravelTimeToGoalArea(
ADDRLP4 48
ADDRFP4 0
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 36
INDIRP4
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 52
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 52
INDIRI4
ASGNI4
line 1473
;1470:					ga->client->tssLastValidAreaNum, ga->client->ps.origin,
;1471:					other->client->tssLastValidAreaNum, TFL_DEFAULT
;1472:				);
;1473:				if (dist >= nearestDist) continue;
ADDRLP4 40
INDIRI4
ADDRLP4 28
INDIRI4
LTI4 $688
ADDRGP4 $679
JUMPV
LABELV $688
line 1475
;1474:				
;1475:				nearestDist = dist;
ADDRLP4 28
ADDRLP4 40
INDIRI4
ASGNI4
line 1476
;1476:				nearestTeammate = other;
ADDRLP4 32
ADDRLP4 36
INDIRP4
ASGNP4
line 1477
;1477:			}
LABELV $679
line 1458
ADDRLP4 24
ADDRLP4 24
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $681
ADDRLP4 24
INDIRI4
ADDRGP4 tssNumGroupAssignments
INDIRI4
LTI4 $678
LABELV $680
line 1479
;1478:
;1479:			if (nearestTeammate) {
ADDRLP4 32
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $690
line 1480
;1480:				*taskGoal = nearestTeammate->clientNum;
ADDRFP4 16
INDIRP4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1481
;1481:				return TSSMT_seekGroupMember;
CNSTI4 6
RETI4
ADDRGP4 $613
JUMPV
LABELV $690
line 1483
;1482:			}
;1483:			return TSSMT_prepareForMission;
CNSTI4 9
RETI4
ADDRGP4 $613
JUMPV
LABELV $676
line 1486
;1484:		}
;1485:
;1486:		return TSSMT_fulfilMission;
CNSTI4 8
RETI4
ADDRGP4 $613
JUMPV
LABELV $655
line 1489
;1487:	}
;1488:
;1489:	*taskGoal = leader;
ADDRFP4 16
INDIRP4
ADDRFP4 12
INDIRI4
ASGNI4
line 1490
;1490:	if (formation == TSSGF_tight) return TSSMT_stickToGroupLeader;
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $692
CNSTI4 1
RETI4
ADDRGP4 $613
JUMPV
LABELV $692
line 1491
;1491:	return TSSMT_followGroupLeader;
CNSTI4 0
RETI4
LABELV $613
endproc TSS_AssignTask 72 16
proc TSS_SuggestedGroupFormation 88 12
line 1499
;1492:}
;1493:
;1494:/*
;1495:===============
;1496:JUHOX: TSS_SuggestedGroupFormation
;1497:===============
;1498:*/
;1499:static tss_groupFormation_t TSS_SuggestedGroupFormation(const tss_groupAssignment_t* ga) {
line 1503
;1500:	tss_groupFormation_t gf;
;1501:	int team;
;1502:
;1503:	if (!ga) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $695
line 1504
;1504:		G_Error("BUG! TSS_SuggestedGroupFormation: ga=NULL");
ADDRGP4 $697
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 1505
;1505:		return TSSGF_tight;
CNSTI4 0
RETI4
ADDRGP4 $694
JUMPV
LABELV $695
line 1507
;1506:	}
;1507:	if (!ga->group) return TSSGF_tight;
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $698
CNSTI4 0
RETI4
ADDRGP4 $694
JUMPV
LABELV $698
line 1509
;1508:
;1509:	if (ga->group->missionStatus == TSSMS_aborted) return TSSGF_tight;
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 1
NEI4 $700
CNSTI4 0
RETI4
ADDRGP4 $694
JUMPV
LABELV $700
line 1511
;1510:
;1511:	gf = TSSGF_tight;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1512
;1512:	team = ga->client->ps.persistant[PERS_TEAM];
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
ASGNI4
line 1514
;1513:
;1514:	switch (ga->group->mission) {
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 1
LTI4 $703
ADDRLP4 8
INDIRI4
CNSTI4 6
GTI4 $703
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $740-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $740
address $705
address $708
address $717
address $727
address $711
address $712
code
LABELV $705
line 1516
;1515:	case TSSMISSION_seek_enemy:
;1516:		if (IsPlayerInvolvedInFighting(ga->clientNum)) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 IsPlayerInvolvedInFighting
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $703
line 1517
;1517:			gf = TSSGF_free;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 1518
;1518:		}
line 1519
;1519:		break;
ADDRGP4 $703
JUMPV
LABELV $708
line 1521
;1520:	case TSSMISSION_seek_items:
;1521:		if (IsPlayerInvolvedInFighting(ga->clientNum)) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 IsPlayerInvolvedInFighting
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $703
line 1522
;1522:			gf = TSSGF_loose;	// allow greater NGB range
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1523
;1523:		}
line 1524
;1524:		break;
ADDRGP4 $703
JUMPV
LABELV $711
line 1526
;1525:	case TSSMISSION_defend_our_base:
;1526:		gf = TSSGF_loose;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1527
;1527:		break;
ADDRGP4 $703
JUMPV
LABELV $712
line 1530
;1528:	case TSSMISSION_occupy_enemy_base:
;1529:		if (
;1530:			Team_GetFlagStatus(team) != FLAG_ATBASE &&
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 Team_GetFlagStatus
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $713
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 OtherTeam
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 Team_GetFlagStatus
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 1
EQI4 $713
line 1532
;1531:			Team_GetFlagStatus(OtherTeam(team)) != FLAG_TAKEN
;1532:		) {
line 1533
;1533:			gf = TSSGF_free;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 1534
;1534:		}
ADDRGP4 $703
JUMPV
LABELV $713
line 1535
;1535:		else if (NearHomeBase(OtherTeam(team), ga->client->ps.origin, 9)) {
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 OtherTeam
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
CNSTF4 1091567616
ARGF4
ADDRLP4 40
ADDRGP4 NearHomeBase
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $715
line 1536
;1536:			gf = TSSGF_loose;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1537
;1537:		}
ADDRGP4 $703
JUMPV
LABELV $715
line 1538
;1538:		else {
line 1539
;1539:			gf = TSSGF_tight;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1540
;1540:		}
line 1541
;1541:		break;
ADDRGP4 $703
JUMPV
LABELV $717
line 1543
;1542:	case TSSMISSION_capture_enemy_flag:
;1543:		switch (Team_GetFlagStatus(OtherTeam(team))) {
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 48
ADDRGP4 OtherTeam
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 52
ADDRGP4 Team_GetFlagStatus
CALLI4
ASGNI4
ADDRLP4 44
ADDRLP4 52
INDIRI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $723
ADDRLP4 44
INDIRI4
CNSTI4 1
EQI4 $721
ADDRLP4 44
INDIRI4
CNSTI4 4
EQI4 $722
ADDRGP4 $718
JUMPV
LABELV $721
LABELV $718
line 1546
;1544:		case FLAG_TAKEN:
;1545:		default:
;1546:			gf = TSSGF_tight;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1547
;1547:			break;
ADDRGP4 $703
JUMPV
LABELV $722
line 1549
;1548:		case FLAG_DROPPED:
;1549:			gf = TSSGF_free;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 1550
;1550:			break;
ADDRGP4 $703
JUMPV
LABELV $723
line 1553
;1551:		case FLAG_ATBASE:
;1552:			if (
;1553:				NearHomeBase(OtherTeam(team), ga->client->ps.origin, 9) ||
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 OtherTeam
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
CNSTF4 1091567616
ARGF4
ADDRLP4 64
ADDRGP4 NearHomeBase
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
NEI4 $726
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 68
ADDRGP4 Team_GetFlagStatus
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $724
LABELV $726
line 1555
;1554:				Team_GetFlagStatus(team) != FLAG_ATBASE
;1555:			) {
line 1556
;1556:				gf = TSSGF_free;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 1557
;1557:			}
ADDRGP4 $703
JUMPV
LABELV $724
line 1558
;1558:			else {
line 1559
;1559:				gf = TSSGF_tight;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1560
;1560:			}
line 1561
;1561:			break;
line 1563
;1562:		}
;1563:		break;
ADDRGP4 $703
JUMPV
LABELV $727
line 1565
;1564:	case TSSMISSION_defend_our_flag:
;1565:		switch (Team_GetFlagStatus(team)) {
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 64
ADDRGP4 Team_GetFlagStatus
CALLI4
ASGNI4
ADDRLP4 60
ADDRLP4 64
INDIRI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $731
ADDRLP4 60
INDIRI4
CNSTI4 1
EQI4 $735
ADDRLP4 60
INDIRI4
CNSTI4 4
EQI4 $734
ADDRGP4 $728
JUMPV
LABELV $731
line 1567
;1566:		case FLAG_ATBASE:
;1567:			gf = TSSGF_loose;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1568
;1568:			if (!NearHomeBase(team, ga->client->ps.origin, 1)) {
ADDRLP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRLP4 72
ADDRGP4 NearHomeBase
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
NEI4 $703
line 1569
;1569:				gf = TSSGF_free;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 1570
;1570:			}
line 1571
;1571:			break;
ADDRGP4 $703
JUMPV
LABELV $734
line 1573
;1572:		case FLAG_DROPPED:
;1573:			gf = TSSGF_free;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 1574
;1574:			break;
ADDRGP4 $703
JUMPV
LABELV $735
LABELV $728
line 1577
;1575:		case FLAG_TAKEN:
;1576:		default:
;1577:			gf = TSSGF_tight;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1578
;1578:			if (Team_GetFlagStatus(OtherTeam(team)) != FLAG_TAKEN) {
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 76
ADDRGP4 OtherTeam
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
ARGI4
ADDRLP4 80
ADDRGP4 Team_GetFlagStatus
CALLI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 1
EQI4 $736
line 1579
;1579:				gf = TSSGF_free;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 1580
;1580:			}
ADDRGP4 $703
JUMPV
LABELV $736
line 1581
;1581:			else if (IsPlayerFighting(ga->clientNum)) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ARGI4
ADDRLP4 84
ADDRGP4 IsPlayerFighting
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
EQI4 $703
line 1582
;1582:				gf = TSSGF_free;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 1583
;1583:			}
line 1584
;1584:			break;
line 1586
;1585:		}
;1586:		break;
line 1588
;1587:	default:
;1588:		break;
LABELV $703
line 1591
;1589:	}
;1590:
;1591:	return gf;
ADDRLP4 0
INDIRI4
RETI4
LABELV $694
endproc TSS_SuggestedGroupFormation 88 12
proc TSS_GroupAssignment 64 20
line 1599
;1592:}
;1593:
;1594:/*
;1595:===============
;1596:JUHOX: TSS_GroupAssignment
;1597:===============
;1598:*/
;1599:static void TSS_GroupAssignment(tss_serverdata_t* tss) {
line 1603
;1600:	int as;
;1601:	tss_groupAssignment_t* ga;
;1602:
;1603:	if (!tss->isValid) {
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $743
line 1606
;1604:		int i;
;1605:
;1606:		for (i = 0; i < level.maxclients; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $748
JUMPV
LABELV $745
line 1610
;1607:			gentity_t* ent;
;1608:			gclient_t* cl;
;1609:
;1610:			ent = &g_entities[i];
ADDRLP4 16
ADDRLP4 8
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1611
;1611:			if (!ent->inuse) continue;
ADDRLP4 16
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $750
ADDRGP4 $746
JUMPV
LABELV $750
line 1612
;1612:			cl = ent->client;
ADDRLP4 12
ADDRLP4 16
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 1613
;1613:			if (!cl) continue;
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $752
ADDRGP4 $746
JUMPV
LABELV $752
line 1614
;1614:			if (cl->pers.connected != CON_CONNECTED) continue;
ADDRLP4 12
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $754
ADDRGP4 $746
JUMPV
LABELV $754
line 1615
;1615:			if (cl->sess.sessionTeam != tss->team) continue;
ADDRLP4 12
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
EQI4 $756
ADDRGP4 $746
JUMPV
LABELV $756
line 1617
;1616:
;1617:			BG_TSS_SetPlayerInfo(&cl->ps, TSSPI_isValid, qfalse);
ADDRLP4 12
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 BG_TSS_SetPlayerInfo
CALLV
pop
line 1618
;1618:		}
LABELV $746
line 1606
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $748
ADDRLP4 8
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $745
line 1619
;1619:		return;
ADDRGP4 $742
JUMPV
LABELV $743
line 1622
;1620:	}
;1621:
;1622:	TSS_InitGroupAssignments(tss);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 TSS_InitGroupAssignments
CALLV
pop
line 1623
;1623:	if (tssNumGroupAssignments <= 0) return;
ADDRGP4 tssNumGroupAssignments
INDIRI4
CNSTI4 0
GTI4 $758
ADDRGP4 $742
JUMPV
LABELV $758
line 1627
;1624:
;1625:
;1626:
;1627:	memset(tssGoalDistanceCache, -1, sizeof(tssGoalDistanceCache));
ADDRGP4 tssGoalDistanceCache
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 2560
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1629
;1628:
;1629:	TSS_DistanceBasedGroupAssignment();
ADDRGP4 TSS_DistanceBasedGroupAssignment
CALLV
pop
line 1633
;1630:
;1631:
;1632:
;1633:	if (g_gametype.integer == GT_CTF && tssFlagCarrier) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $760
ADDRGP4 tssFlagCarrier
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $760
line 1635
;1634:		if (
;1635:			tssFlagCarrier->group &&
ADDRLP4 8
ADDRGP4 tssFlagCarrier
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $763
ADDRLP4 8
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 3
NEI4 $763
line 1637
;1636:			tssFlagCarrier->group->mission == TSSMISSION_capture_enemy_flag
;1637:		) {
line 1638
;1638:			TSS_MoveToGroupIfPossible(tssFlagCarrier, tssFlagCarrier->group, TSSGAR_flagCarrier);
ADDRLP4 12
ADDRGP4 tssFlagCarrier
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 TSS_MoveToGroupIfPossible
CALLI4
pop
line 1639
;1639:		}
LABELV $763
line 1677
;1640:		/*
;1641:		else {
;1642:			float bestDist;
;1643:			float fcDistSqrToHomeBase;
;1644:			tss_groupInfo_t* bestGroup;
;1645:
;1646:			bestDist = 1000000000.0;
;1647:			bestGroup = NULL;
;1648:			if (tssHomeBase) {
;1649:				fcDistSqrToHomeBase = DistanceSquared(tssFlagCarrier->client->ps.origin, tssHomeBase->origin);
;1650:			}
;1651:			else {
;1652:				// should not happen
;1653:				fcDistSqrToHomeBase = 1000000000.0;
;1654:			}
;1655:
;1656:			for (gr = 0; gr < MAX_GROUPS; gr++) {
;1657:				float dist;
;1658:
;1659:				gi = &tssGroupInfo[gr];
;1660:				if (gi->mission != TSSMISSION_capture_enemy_flag) continue;
;1661:				if (!gi->oldLeader) continue;
;1662:				dist = Distance(tssFlagCarrier->client->ps.origin, gi->oldLeader->client->ps.origin);
;1663:				if (tssFlagCarrier->group == gi) dist *= 0.6;
;1664:				if (tssHomeBase) {
;1665:					if (DistanceSquared(gi->oldLeader->client->ps.origin, tssHomeBase->origin) > fcDistSqrToHomeBase) {
;1666:						dist *= 1.4;
;1667:					}
;1668:				}
;1669:				if (dist < bestDist) {
;1670:					bestDist = dist;
;1671:					bestGroup = gi;
;1672:				}
;1673:			}
;1674:			TSS_MoveToGroupIfPossible(tssFlagCarrier, bestGroup, TSSGAR_flagCarrier);
;1675:		}
;1676:		*/
;1677:	}
LABELV $760
line 1681
;1678:
;1679:
;1680:
;1681:	TSS_ConstraintBasedGroupAssignment(tss);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 TSS_ConstraintBasedGroupAssignment
CALLV
pop
line 1685
;1682:
;1683:
;1684:
;1685:	TSS_DetermineLeaders();
ADDRGP4 TSS_DetermineLeaders
CALLV
pop
line 1689
;1686:
;1687:
;1688:
;1689:	TSS_DetermineMissionStatus(tss);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 TSS_DetermineMissionStatus
CALLV
pop
line 1691
;1690:
;1691:	TSS_CreateRescueSchedule();
ADDRGP4 TSS_CreateRescueSchedule
CALLV
pop
line 1693
;1692:
;1693:	for (as = 0; as < tssNumGroupAssignments; as++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $768
JUMPV
LABELV $765
line 1697
;1694:		playerState_t* ps;
;1695:		entityState_t* es;
;1696:
;1697:		ga = &tssGroupAssignments[as];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 40
MULI4
ADDRGP4 tssGroupAssignments
ADDP4
ASGNP4
line 1698
;1698:		ps = &ga->client->ps;
ADDRLP4 8
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
line 1699
;1699:		es = &g_entities[ga->clientNum].s;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1701
;1700:
;1701:		if (ga->group) {
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $769
line 1708
;1702:			tss_groupMemberStatus_t gms;
;1703:			int leader;
;1704:			tss_groupFormation_t groupFormation;
;1705:			tss_missionTask_t task;
;1706:			int taskGoal;
;1707:
;1708:			BG_TSS_SetPlayerInfo(ps, TSSPI_group, ga->group->groupNum);
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
INDIRI4
ARGI4
ADDRGP4 BG_TSS_SetPlayerInfo
CALLV
pop
line 1710
;1709:
;1710:			if (ga->group->currentLeader == ga) {
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 0
INDIRP4
CVPU4 4
NEU4 $771
line 1712
;1711:				if (
;1712:					ga->clientNum == ga->group->designated1stLeader ||
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
EQI4 $776
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
EQI4 $776
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
NEI4 $773
LABELV $776
line 1715
;1713:					ga->clientNum == ga->group->designated2ndLeader ||
;1714:					ga->clientNum == ga->group->designated3rdLeader
;1715:				) {
line 1716
;1716:					gms = TSSGMS_designatedLeader;
ADDRLP4 24
CNSTI4 4
ASGNI4
line 1717
;1717:				}
ADDRGP4 $772
JUMPV
LABELV $773
line 1718
;1718:				else {
line 1719
;1719:					gms = TSSGMS_temporaryLeader;
ADDRLP4 24
CNSTI4 3
ASGNI4
line 1720
;1720:				}
line 1721
;1721:			}
ADDRGP4 $772
JUMPV
LABELV $771
line 1722
;1722:			else if (ga->isAlive && ga->danger <= ga->group->maxDanger) {
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 0
EQI4 $777
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
GTI4 $777
line 1723
;1723:				gms = TSSGMS_temporaryFighter;
ADDRLP4 24
CNSTI4 1
ASGNI4
line 1724
;1724:			}
ADDRGP4 $778
JUMPV
LABELV $777
line 1725
;1725:			else {
line 1726
;1726:				gms = TSSGMS_retreating;
ADDRLP4 24
CNSTI4 0
ASGNI4
line 1727
;1727:			}
LABELV $778
LABELV $772
line 1728
;1728:			BG_TSS_SetPlayerInfo(ps, TSSPI_groupMemberStatus, gms);
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRGP4 BG_TSS_SetPlayerInfo
CALLV
pop
line 1730
;1729:
;1730:			BG_TSS_SetPlayerInfo(ps, TSSPI_groupSize, ga->group->totalPlayers);
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 7
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ARGI4
ADDRGP4 BG_TSS_SetPlayerInfo
CALLV
pop
line 1731
;1731:			BG_TSS_SetPlayerInfo(ps, TSSPI_membersAlive, ga->group->alivePlayers);
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 8
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ARGI4
ADDRGP4 BG_TSS_SetPlayerInfo
CALLV
pop
line 1732
;1732:			BG_TSS_SetPlayerInfo(ps, TSSPI_membersReady, ga->group->readyPlayers);
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 9
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
ARGI4
ADDRGP4 BG_TSS_SetPlayerInfo
CALLV
pop
line 1734
;1733:
;1734:			leader = (ga->group->currentLeader? ga->group->currentLeader->clientNum : ga->clientNum);
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $780
ADDRLP4 44
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $781
JUMPV
LABELV $780
ADDRLP4 44
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
LABELV $781
ADDRLP4 28
ADDRLP4 44
INDIRI4
ASGNI4
line 1735
;1735:			BG_TSS_SetPlayerInfo(ps, TSSPI_groupLeader, leader);
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 12
ARGI4
ADDRLP4 28
INDIRI4
ARGI4
ADDRGP4 BG_TSS_SetPlayerInfo
CALLV
pop
line 1737
;1736:
;1737:			BG_TSS_SetPlayerInfo(ps, TSSPI_mission, tss->instructions.orders.order[ga->group->groupNum].mission);
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
INDIRI4
CNSTI4 20
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BG_TSS_SetPlayerInfo
CALLV
pop
line 1739
;1738:
;1739:			BG_TSS_SetPlayerInfo(ps, TSSPI_missionStatus, ga->group->missionStatus);
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
ARGI4
ADDRGP4 BG_TSS_SetPlayerInfo
CALLV
pop
line 1741
;1740:
;1741:			groupFormation = ga->group->groupFormation;
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
ASGNI4
line 1742
;1742:			switch (groupFormation) {
ADDRLP4 48
ADDRLP4 16
INDIRI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $783
ADDRLP4 48
INDIRI4
CNSTI4 1
EQI4 $783
ADDRLP4 48
INDIRI4
CNSTI4 2
EQI4 $783
ADDRGP4 $782
JUMPV
line 1746
;1743:			case TSSGF_tight:
;1744:			case TSSGF_loose:
;1745:			case TSSGF_free:
;1746:				break;
LABELV $782
line 1748
;1747:			default:
;1748:				groupFormation = TSSGF_tight;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 1749
;1749:				break;
LABELV $783
line 1751
;1750:			}
;1751:			BG_TSS_SetPlayerInfo(ps, TSSPI_groupFormation, groupFormation);
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 6
ARGI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRGP4 BG_TSS_SetPlayerInfo
CALLV
pop
line 1753
;1752:
;1753:			task = TSS_AssignTask(ga, gms, groupFormation, leader, &taskGoal);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 20
ARGP4
ADDRLP4 56
ADDRGP4 TSS_AssignTask
CALLI4
ASGNI4
ADDRLP4 32
ADDRLP4 56
INDIRI4
ASGNI4
line 1754
;1754:			BG_TSS_SetPlayerInfo(ps, TSSPI_task, task);
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 5
ARGI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRGP4 BG_TSS_SetPlayerInfo
CALLV
pop
line 1755
;1755:			if (taskGoal < 0) taskGoal = ga->clientNum;
ADDRLP4 20
INDIRI4
CNSTI4 0
GEI4 $786
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
LABELV $786
line 1756
;1756:			BG_TSS_SetPlayerInfo(ps, TSSPI_taskGoal, taskGoal);
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 13
ARGI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRGP4 BG_TSS_SetPlayerInfo
CALLV
pop
line 1758
;1757:
;1758:			groupFormation = TSS_SuggestedGroupFormation(ga);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 TSS_SuggestedGroupFormation
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 60
INDIRI4
ASGNI4
line 1759
;1759:			BG_TSS_SetPlayerInfo(ps, TSSPI_suggestedGF, groupFormation);
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 14
ARGI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRGP4 BG_TSS_SetPlayerInfo
CALLV
pop
line 1761
;1760:			
;1761:			BG_TSS_SetPlayerInfo(ps, TSSPI_isValid, qtrue);
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BG_TSS_SetPlayerInfo
CALLV
pop
line 1762
;1762:		}
ADDRGP4 $770
JUMPV
LABELV $769
line 1763
;1763:		else {
line 1764
;1764:			BG_TSS_SetPlayerInfo(ps, TSSPI_isValid, qfalse);
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 BG_TSS_SetPlayerInfo
CALLV
pop
line 1765
;1765:		}
LABELV $770
line 1766
;1766:	}
LABELV $766
line 1693
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $768
ADDRLP4 4
INDIRI4
ADDRGP4 tssNumGroupAssignments
INDIRI4
LTI4 $765
line 1767
;1767:}
LABELV $742
endproc TSS_GroupAssignment 64 20
proc TSS_SendTeamStatus 360 216
line 1774
;1768:
;1769:/*
;1770:===============
;1771:JUHOX: TSS_SendTeamStatus
;1772:===============
;1773:*/
;1774:static void TSS_SendTeamStatus(tss_serverdata_t* tss) {
line 1780
;1775:	char argbuf[256];
;1776:	int cl;
;1777:	int bits;
;1778:	int i;
;1779:
;1780:	if (!tss->missionLeader) return;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $789
ADDRGP4 $788
JUMPV
LABELV $789
line 1782
;1781:
;1782:	i = 0;
ADDRLP4 264
CNSTI4 0
ASGNI4
line 1783
;1783:	bits = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1784
;1784:	for (cl = 0; cl < MAX_CLIENTS; cl++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $791
line 1787
;1785:		gclient_t* client;
;1786:		
;1787:		client = level.clients + cl;
ADDRLP4 268
ADDRLP4 0
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 1789
;1788:		if (
;1789:			g_entities[cl].inuse &&
ADDRLP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+524
ADDP4
INDIRI4
CNSTI4 0
EQI4 $795
ADDRLP4 268
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $795
ADDRLP4 268
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
LEI4 $795
line 1792
;1790:			client->pers.connected == CON_CONNECTED &&
;1791:			client->ps.stats[STAT_HEALTH] > 0
;1792:		) {
line 1793
;1793:			bits |= 1 << (cl & 3);
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
CNSTI4 3
BANDI4
LSHI4
BORI4
ASGNI4
line 1794
;1794:		}
LABELV $795
line 1796
;1795:
;1796:		if ((cl & 3) == 3) {
ADDRLP4 0
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 3
NEI4 $798
line 1797
;1797:			argbuf[i++] = 'A' + bits;
ADDRLP4 276
ADDRLP4 264
INDIRI4
ASGNI4
ADDRLP4 264
ADDRLP4 276
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 276
INDIRI4
ADDRLP4 8
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 65
ADDI4
CVII1 4
ASGNI1
line 1798
;1798:			bits = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1799
;1799:		}
LABELV $798
line 1800
;1800:	}
LABELV $792
line 1784
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $791
line 1801
;1801:	argbuf[i++] = 0;
ADDRLP4 268
ADDRLP4 264
INDIRI4
ASGNI4
ADDRLP4 264
ADDRLP4 268
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 268
INDIRI4
ADDRLP4 8
ADDP4
CNSTI1 0
ASGNI1
line 1803
;1802:
;1803:	if (tssHomeBase && tssEnemyBase) {
ADDRGP4 tssHomeBase
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $800
ADDRGP4 tssEnemyBase
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $800
line 1808
;1804:		float distToHome;
;1805:		float distToEnemy;
;1806:		bot_goal_t flag;
;1807:
;1808:		if (LocateFlag(tss->team, &flag)) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 272
ARGP4
ADDRLP4 336
ADDRGP4 LocateFlag
CALLI4
ASGNI4
ADDRLP4 336
INDIRI4
CNSTI4 0
EQI4 $802
line 1809
;1809:			distToHome = Distance(flag.origin, tssHomeBase->origin);
ADDRLP4 272
ARGP4
ADDRGP4 tssHomeBase
INDIRP4
ARGP4
ADDRLP4 340
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRLP4 332
ADDRLP4 340
INDIRF4
ASGNF4
line 1810
;1810:			distToEnemy = Distance(flag.origin, tssEnemyBase->origin);
ADDRLP4 272
ARGP4
ADDRGP4 tssEnemyBase
INDIRP4
ARGP4
ADDRLP4 344
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRLP4 328
ADDRLP4 344
INDIRF4
ASGNF4
line 1812
;1811:
;1812:			tss->yfp = 200 * distToEnemy / (distToEnemy + distToHome) - 100;
ADDRLP4 348
ADDRLP4 328
INDIRF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 656
ADDP4
ADDRLP4 348
INDIRF4
CNSTF4 1128792064
MULF4
ADDRLP4 348
INDIRF4
ADDRLP4 332
INDIRF4
ADDF4
DIVF4
CNSTF4 1120403456
SUBF4
CVFI4 4
ASGNI4
line 1813
;1813:		}
LABELV $802
line 1814
;1814:		if (LocateFlag(OtherTeam(tss->team), &flag)) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 340
ADDRGP4 OtherTeam
CALLI4
ASGNI4
ADDRLP4 340
INDIRI4
ARGI4
ADDRLP4 272
ARGP4
ADDRLP4 344
ADDRGP4 LocateFlag
CALLI4
ASGNI4
ADDRLP4 344
INDIRI4
CNSTI4 0
EQI4 $804
line 1815
;1815:			distToHome = Distance(flag.origin, tssHomeBase->origin);
ADDRLP4 272
ARGP4
ADDRGP4 tssHomeBase
INDIRP4
ARGP4
ADDRLP4 348
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRLP4 332
ADDRLP4 348
INDIRF4
ASGNF4
line 1816
;1816:			distToEnemy = Distance(flag.origin, tssEnemyBase->origin);
ADDRLP4 272
ARGP4
ADDRGP4 tssEnemyBase
INDIRP4
ARGP4
ADDRLP4 352
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRLP4 328
ADDRLP4 352
INDIRF4
ASGNF4
line 1818
;1817:
;1818:			tss->ofp = 200 * distToEnemy / (distToEnemy + distToHome) - 100;
ADDRLP4 356
ADDRLP4 328
INDIRF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 660
ADDP4
ADDRLP4 356
INDIRF4
CNSTF4 1128792064
MULF4
ADDRLP4 356
INDIRF4
ADDRLP4 332
INDIRF4
ADDF4
DIVF4
CNSTF4 1120403456
SUBF4
CVFI4 4
ASGNI4
line 1819
;1819:		}
LABELV $804
line 1820
;1820:	}
LABELV $800
line 1822
;1821:
;1822:	trap_SendServerCommand(
ADDRGP4 $806
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 272
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 272
INDIRP4
CNSTI4 656
ADDP4
INDIRI4
ARGI4
ADDRLP4 272
INDIRP4
CNSTI4 660
ADDP4
INDIRI4
ARGI4
ADDRLP4 272
INDIRP4
CNSTI4 664
ADDP4
INDIRI4
ARGI4
ADDRLP4 272
INDIRP4
CNSTI4 668
ADDP4
INDIRI4
ARGI4
ADDRLP4 272
INDIRP4
CNSTI4 672
ADDP4
INDIRI4
ARGI4
ADDRGP4 g_respawnDelay+12
INDIRI4
ARGI4
ADDRLP4 272
INDIRP4
CNSTI4 676
ADDP4
INDIRI4
ARGI4
ADDRLP4 272
INDIRP4
CNSTI4 680
ADDP4
INDIRI4
ARGI4
ADDRLP4 272
INDIRP4
CNSTI4 684
ADDP4
INDIRF4
ARGF4
ADDRLP4 272
INDIRP4
CNSTI4 692
ADDP4
INDIRF4
ARGF4
ADDRLP4 272
INDIRP4
CNSTI4 688
ADDP4
INDIRF4
ARGF4
ADDRLP4 272
INDIRP4
CNSTI4 696
ADDP4
INDIRF4
ARGF4
ADDRLP4 272
INDIRP4
CNSTI4 476
ADDP4
INDIRI4
ARGI4
ADDRGP4 tssGroupInfo+32
INDIRI4
ARGI4
ADDRGP4 tssGroupInfo+40
INDIRI4
ARGI4
ADDRGP4 tssGroupInfo+48
INDIRI4
ARGI4
ADDRLP4 272
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ARGI4
ADDRGP4 tssGroupInfo+148+32
INDIRI4
ARGI4
ADDRGP4 tssGroupInfo+148+40
INDIRI4
ARGI4
ADDRGP4 tssGroupInfo+148+48
INDIRI4
ARGI4
ADDRLP4 272
INDIRP4
CNSTI4 484
ADDP4
INDIRI4
ARGI4
ADDRGP4 tssGroupInfo+296+32
INDIRI4
ARGI4
ADDRGP4 tssGroupInfo+296+40
INDIRI4
ARGI4
ADDRGP4 tssGroupInfo+296+48
INDIRI4
ARGI4
ADDRLP4 272
INDIRP4
CNSTI4 488
ADDP4
INDIRI4
ARGI4
ADDRGP4 tssGroupInfo+444+32
INDIRI4
ARGI4
ADDRGP4 tssGroupInfo+444+40
INDIRI4
ARGI4
ADDRGP4 tssGroupInfo+444+48
INDIRI4
ARGI4
ADDRLP4 272
INDIRP4
CNSTI4 492
ADDP4
INDIRI4
ARGI4
ADDRGP4 tssGroupInfo+592+32
INDIRI4
ARGI4
ADDRGP4 tssGroupInfo+592+40
INDIRI4
ARGI4
ADDRGP4 tssGroupInfo+592+48
INDIRI4
ARGI4
ADDRLP4 272
INDIRP4
CNSTI4 496
ADDP4
INDIRI4
ARGI4
ADDRGP4 tssGroupInfo+740+32
INDIRI4
ARGI4
ADDRGP4 tssGroupInfo+740+40
INDIRI4
ARGI4
ADDRGP4 tssGroupInfo+740+48
INDIRI4
ARGI4
ADDRLP4 272
INDIRP4
CNSTI4 500
ADDP4
INDIRI4
ARGI4
ADDRGP4 tssGroupInfo+888+32
INDIRI4
ARGI4
ADDRGP4 tssGroupInfo+888+40
INDIRI4
ARGI4
ADDRGP4 tssGroupInfo+888+48
INDIRI4
ARGI4
ADDRLP4 272
INDIRP4
CNSTI4 504
ADDP4
INDIRI4
ARGI4
ADDRGP4 tssGroupInfo+1036+32
INDIRI4
ARGI4
ADDRGP4 tssGroupInfo+1036+40
INDIRI4
ARGI4
ADDRGP4 tssGroupInfo+1036+48
INDIRI4
ARGI4
ADDRLP4 272
INDIRP4
CNSTI4 508
ADDP4
INDIRI4
ARGI4
ADDRGP4 tssGroupInfo+1184+32
INDIRI4
ARGI4
ADDRGP4 tssGroupInfo+1184+40
INDIRI4
ARGI4
ADDRGP4 tssGroupInfo+1184+48
INDIRI4
ARGI4
ADDRLP4 272
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
ARGI4
ADDRGP4 tssGroupInfo+1332+32
INDIRI4
ARGI4
ADDRGP4 tssGroupInfo+1332+40
INDIRI4
ARGI4
ADDRGP4 tssGroupInfo+1332+48
INDIRI4
ARGI4
ADDRLP4 276
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 276
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1860
;1823:		tss->missionLeader->ps.clientNum,
;1824:		va(
;1825:			"tssupdate %s %d %d %d %d %d %d %d %d %f %f %f %f"
;1826:			" %d %d %d %d"	// A
;1827:			" %d %d %d %d"	// B
;1828:			" %d %d %d %d"	// C
;1829:			" %d %d %d %d"	// D
;1830:			" %d %d %d %d"	// E
;1831:			" %d %d %d %d"	// F
;1832:			" %d %d %d %d"	// G
;1833:			" %d %d %d %d"	// H
;1834:			" %d %d %d %d"	// I
;1835:			" %d %d %d %d"	// J
;1836:			,
;1837:			argbuf,
;1838:			tss->yfp,
;1839:			tss->ofp,
;1840:			tss->tidiness,
;1841:			tss->avgStamina,
;1842:			tss->fightIntensity,
;1843:			g_respawnDelay.integer,
;1844:			tss->rfa,
;1845:			tss->rfd,
;1846:			tss->yamq, tss->yalq,
;1847:			tss->oamq, tss->oalq,
;1848:			tss->currentLeaders[0], tssGroupInfo[0].totalPlayers, tssGroupInfo[0].alivePlayers, tssGroupInfo[0].readyPlayers,
;1849:			tss->currentLeaders[1], tssGroupInfo[1].totalPlayers, tssGroupInfo[1].alivePlayers, tssGroupInfo[1].readyPlayers,
;1850:			tss->currentLeaders[2], tssGroupInfo[2].totalPlayers, tssGroupInfo[2].alivePlayers, tssGroupInfo[2].readyPlayers,
;1851:			tss->currentLeaders[3], tssGroupInfo[3].totalPlayers, tssGroupInfo[3].alivePlayers, tssGroupInfo[3].readyPlayers,
;1852:			tss->currentLeaders[4], tssGroupInfo[4].totalPlayers, tssGroupInfo[4].alivePlayers, tssGroupInfo[4].readyPlayers,
;1853:			tss->currentLeaders[5], tssGroupInfo[5].totalPlayers, tssGroupInfo[5].alivePlayers, tssGroupInfo[5].readyPlayers,
;1854:			tss->currentLeaders[6], tssGroupInfo[6].totalPlayers, tssGroupInfo[6].alivePlayers, tssGroupInfo[6].readyPlayers,
;1855:			tss->currentLeaders[7], tssGroupInfo[7].totalPlayers, tssGroupInfo[7].alivePlayers, tssGroupInfo[7].readyPlayers,
;1856:			tss->currentLeaders[8], tssGroupInfo[8].totalPlayers, tssGroupInfo[8].alivePlayers, tssGroupInfo[8].readyPlayers,
;1857:			tss->currentLeaders[9], tssGroupInfo[9].totalPlayers, tssGroupInfo[9].alivePlayers, tssGroupInfo[9].readyPlayers
;1858:		)
;1859:	);
;1860:}
LABELV $788
endproc TSS_SendTeamStatus 360 216
export TSS_Run
proc TSS_Run 8 4
line 1867
;1861:
;1862:/*
;1863:===============
;1864:JUHOX: TSS_Run
;1865:===============
;1866:*/
;1867:void TSS_Run(void) {
line 1870
;1868:	tss_serverdata_t* tss;
;1869:
;1870:	if (g_gametype.integer < GT_TEAM) return;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
GEI4 $866
ADDRGP4 $865
JUMPV
LABELV $866
line 1872
;1871:#if MONSTER_MODE	// JUHOX: no TSS with STU
;1872:	if (g_gametype.integer >= GT_STU) return;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
LTI4 $869
ADDRGP4 $865
JUMPV
LABELV $869
line 1874
;1873:#endif
;1874:	if (level.time < level.tssTime) return;
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+9260
INDIRI4
GEI4 $872
ADDRGP4 $865
JUMPV
LABELV $872
line 1875
;1875:	level.tssTime = level.time + 500;
ADDRGP4 level+9260
ADDRGP4 level+32
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 1877
;1876:
;1877:	tssHomeBase = NULL;
ADDRGP4 tssHomeBase
CNSTP4 0
ASGNP4
line 1878
;1878:	tssEnemyBase = NULL;
ADDRGP4 tssEnemyBase
CNSTP4 0
ASGNP4
line 1879
;1879:	switch (level.tssNextTeam) {
ADDRLP4 4
ADDRGP4 level+9264
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $881
ADDRLP4 4
INDIRI4
CNSTI4 1
EQI4 $887
ADDRGP4 $878
JUMPV
LABELV $881
LABELV $878
line 1882
;1880:	case 0:
;1881:	default:
;1882:		tss = &level.redTSS;
ADDRLP4 0
ADDRGP4 level+9268
ASGNP4
line 1883
;1883:		tss->team = TEAM_RED;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 1
ASGNI4
line 1884
;1884:		if (g_gametype.integer == GT_CTF) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $883
line 1885
;1885:			tssHomeBase = &ctf_redflag;
ADDRGP4 tssHomeBase
ADDRGP4 ctf_redflag
ASGNP4
line 1886
;1886:			tssEnemyBase = &ctf_blueflag;
ADDRGP4 tssEnemyBase
ADDRGP4 ctf_blueflag
ASGNP4
line 1887
;1887:		}
LABELV $883
line 1888
;1888:		level.tssNextTeam = 1;
ADDRGP4 level+9264
CNSTI4 1
ASGNI4
line 1889
;1889:		break;
ADDRGP4 $879
JUMPV
LABELV $887
line 1891
;1890:	case 1:
;1891:		tss = &level.blueTSS;
ADDRLP4 0
ADDRGP4 level+9984
ASGNP4
line 1892
;1892:		tss->team = TEAM_BLUE;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 2
ASGNI4
line 1893
;1893:		if (g_gametype.integer == GT_CTF) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $889
line 1894
;1894:			tssHomeBase = &ctf_blueflag;
ADDRGP4 tssHomeBase
ADDRGP4 ctf_blueflag
ASGNP4
line 1895
;1895:			tssEnemyBase = &ctf_redflag;
ADDRGP4 tssEnemyBase
ADDRGP4 ctf_redflag
ASGNP4
line 1896
;1896:		}
LABELV $889
line 1897
;1897:		level.tssNextTeam = 0;
ADDRGP4 level+9264
CNSTI4 0
ASGNI4
line 1898
;1898:		break;
LABELV $879
line 1902
;1899:	}
;1900:
;1901:	if (
;1902:		!g_tss.integer ||
ADDRGP4 g_tss+12
INDIRI4
CNSTI4 0
EQI4 $897
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 15000
SUBI4
GEI4 $893
LABELV $897
line 1904
;1903:		tss->lastUpdateTime < level.time - 15000
;1904:	) {
line 1905
;1905:		tss->isValid = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 1906
;1906:	}
LABELV $893
line 1908
;1907:
;1908:	tss->missionLeader = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTP4 0
ASGNP4
line 1909
;1909:	tss->yfp = -999;
ADDRLP4 0
INDIRP4
CNSTI4 656
ADDP4
CNSTI4 -999
ASGNI4
line 1910
;1910:	tss->ofp = -999;
ADDRLP4 0
INDIRP4
CNSTI4 660
ADDP4
CNSTI4 -999
ASGNI4
line 1911
;1911:	tss->tidiness = 0;
ADDRLP4 0
INDIRP4
CNSTI4 664
ADDP4
CNSTI4 0
ASGNI4
line 1912
;1912:	tss->avgStamina = 0;
ADDRLP4 0
INDIRP4
CNSTI4 668
ADDP4
CNSTI4 0
ASGNI4
line 1913
;1913:	tss->fightIntensity = 0;
ADDRLP4 0
INDIRP4
CNSTI4 672
ADDP4
CNSTI4 0
ASGNI4
line 1914
;1914:	tss->rfa = 0;
ADDRLP4 0
INDIRP4
CNSTI4 676
ADDP4
CNSTI4 0
ASGNI4
line 1915
;1915:	tss->rfd = 0;
ADDRLP4 0
INDIRP4
CNSTI4 680
ADDP4
CNSTI4 0
ASGNI4
line 1916
;1916:	tss->yamq = 0.0;
ADDRLP4 0
INDIRP4
CNSTI4 684
ADDP4
CNSTF4 0
ASGNF4
line 1917
;1917:	tss->oamq = 0.0;
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
CNSTF4 0
ASGNF4
line 1918
;1918:	tss->yalq = 0.0;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
CNSTF4 0
ASGNF4
line 1919
;1919:	tss->oalq = 0.0;
ADDRLP4 0
INDIRP4
CNSTI4 696
ADDP4
CNSTF4 0
ASGNF4
line 1920
;1920:	tss->yaq = 0;
ADDRLP4 0
INDIRP4
CNSTI4 700
ADDP4
CNSTI4 0
ASGNI4
line 1921
;1921:	tss->oaq = 0;
ADDRLP4 0
INDIRP4
CNSTI4 704
ADDP4
CNSTI4 0
ASGNI4
line 1922
;1922:	tss->yts = 0;
ADDRLP4 0
INDIRP4
CNSTI4 708
ADDP4
CNSTI4 0
ASGNI4
line 1923
;1923:	tss->ots = 0;
ADDRLP4 0
INDIRP4
CNSTI4 712
ADDP4
CNSTI4 0
ASGNI4
line 1924
;1924:	TSS_GroupAssignment(tss);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 TSS_GroupAssignment
CALLV
pop
line 1925
;1925:	TSS_SendTeamStatus(tss);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 TSS_SendTeamStatus
CALLV
pop
line 1926
;1926:}
LABELV $865
endproc TSS_Run 8 4
export P_DamageFeedback
proc P_DamageFeedback 36 12
line 1938
;1927:
;1928:/*
;1929:===============
;1930:G_DamageFeedback
;1931:
;1932:Called just before a snapshot is sent to the given player.
;1933:Totals up all damage and generates both the player_state_t
;1934:damage values to that client for pain blends and kicks, and
;1935:global pain sound events for all clients.
;1936:===============
;1937:*/
;1938:void P_DamageFeedback( gentity_t *player ) {
line 1943
;1939:	gclient_t	*client;
;1940:	float	count;
;1941:	vec3_t	angles;
;1942:
;1943:	client = player->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 1944
;1944:	if ( client->ps.pm_type == PM_DEAD ) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $899
line 1945
;1945:		return;
ADDRGP4 $898
JUMPV
LABELV $899
line 1949
;1946:	}
;1947:
;1948:	// total points of damage shot at the player this frame
;1949:	count = client->damage_blood + client->damage_armor;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 780
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRI4
ADDI4
CVIF4 4
ASGNF4
line 1950
;1950:	if ( count == 0 ) {
ADDRLP4 4
INDIRF4
CNSTF4 0
NEF4 $901
line 1951
;1951:		return;		// didn't take any damage
ADDRGP4 $898
JUMPV
LABELV $901
line 1954
;1952:	}
;1953:
;1954:	if ( count > 255 ) {
ADDRLP4 4
INDIRF4
CNSTF4 1132396544
LEF4 $903
line 1955
;1955:		count = 255;
ADDRLP4 4
CNSTF4 1132396544
ASGNF4
line 1956
;1956:	}
LABELV $903
line 1962
;1957:
;1958:	// send the information to the client
;1959:
;1960:	// world damage (falling, slime, etc) uses a special code
;1961:	// to make the blend blob centered instead of positional
;1962:	if ( client->damage_fromWorld ) {
ADDRLP4 0
INDIRP4
CNSTI4 800
ADDP4
INDIRI4
CNSTI4 0
EQI4 $905
line 1963
;1963:		client->ps.damagePitch = 255;
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
CNSTI4 255
ASGNI4
line 1964
;1964:		client->ps.damageYaw = 255;
ADDRLP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 255
ASGNI4
line 1966
;1965:
;1966:		client->damage_fromWorld = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 800
ADDP4
CNSTI4 0
ASGNI4
line 1967
;1967:	} else {
ADDRGP4 $906
JUMPV
LABELV $905
line 1968
;1968:		vectoangles( client->damage_from, angles );
ADDRLP4 0
INDIRP4
CNSTI4 788
ADDP4
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 1969
;1969:		client->ps.damagePitch = angles[PITCH]/360.0 * 256;
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
ADDRLP4 8
INDIRF4
CNSTF4 1060506465
MULF4
CVFI4 4
ASGNI4
line 1970
;1970:		client->ps.damageYaw = angles[YAW]/360.0 * 256;
ADDRLP4 0
INDIRP4
CNSTI4 172
ADDP4
ADDRLP4 8+4
INDIRF4
CNSTF4 1060506465
MULF4
CVFI4 4
ASGNI4
line 1971
;1971:	}
LABELV $906
line 1974
;1972:
;1973:	// play an apropriate pain sound
;1974:	if ( (level.time > player->pain_debounce_time) && !(player->flags & FL_GODMODE) ) {
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 24
INDIRP4
CNSTI4 724
ADDP4
INDIRI4
LEI4 $908
ADDRLP4 24
INDIRP4
CNSTI4 540
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $908
line 1975
;1975:		player->pain_debounce_time = level.time + 700;
ADDRFP4 0
INDIRP4
CNSTI4 724
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 700
ADDI4
ASGNI4
line 1980
;1976:		// JUHOX: scale health to 100 for pain event
;1977:#if 0
;1978:		G_AddEvent( player, EV_PAIN, player->health );
;1979:#else
;1980:		G_AddEvent(player, EV_PAIN, (100 * player->health) / client->ps.stats[STAT_MAX_HEALTH]);
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
CNSTI4 57
ARGI4
ADDRLP4 28
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 100
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
DIVI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 1982
;1981:#endif
;1982:		client->ps.damageEvent++;
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1983
;1983:	}
LABELV $908
line 1986
;1984:
;1985:
;1986:	client->ps.damageCount = count;
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 4
INDIRF4
CVFI4 4
ASGNI4
line 1991
;1987:
;1988:	//
;1989:	// clear totals
;1990:	//
;1991:	client->damage_blood = 0;
ADDRLP4 0
INDIRP4
CNSTI4 780
ADDP4
CNSTI4 0
ASGNI4
line 1992
;1992:	client->damage_armor = 0;
ADDRLP4 0
INDIRP4
CNSTI4 776
ADDP4
CNSTI4 0
ASGNI4
line 1993
;1993:	client->damage_knockback = 0;
ADDRLP4 0
INDIRP4
CNSTI4 784
ADDP4
CNSTI4 0
ASGNI4
line 1994
;1994:}
LABELV $898
endproc P_DamageFeedback 36 12
export P_WorldEffects
proc P_WorldEffects 28 32
line 2005
;1995:
;1996:
;1997:
;1998:/*
;1999:=============
;2000:P_WorldEffects
;2001:
;2002:Check for lava / slime contents and drowning
;2003:=============
;2004:*/
;2005:void P_WorldEffects( gentity_t *ent ) {
line 2009
;2006:	qboolean	envirosuit;
;2007:	int			waterlevel;
;2008:
;2009:	if ( ent->client->noclip ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 728
ADDP4
INDIRI4
CNSTI4 0
EQI4 $913
line 2010
;2010:		ent->client->airOutTime = level.time + 12000;	// don't need air
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 868
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 12000
ADDI4
ASGNI4
line 2011
;2011:		return;
ADDRGP4 $912
JUMPV
LABELV $913
line 2014
;2012:	}
;2013:
;2014:	waterlevel = ent->waterlevel;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 792
ADDP4
INDIRI4
ASGNI4
line 2020
;2015:
;2016:	// JUHOX: battlesuit not used as protection
;2017:#if 0
;2018:	envirosuit = ent->client->ps.powerups[PW_BATTLESUIT] > level.time;
;2019:#else
;2020:	envirosuit = qfalse;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2031
;2021:#endif
;2022:
;2023:	//
;2024:	// check for drowning
;2025:	//
;2026:	// JUHOX: also "drown" if holding breath
;2027:#if 0
;2028:	if ( waterlevel == 3 ) {
;2029:#else
;2030:	if (
;2031:		waterlevel >= 3 ||
ADDRLP4 0
INDIRI4
CNSTI4 3
GEI4 $919
ADDRGP4 g_stamina+12
INDIRI4
CNSTI4 0
EQI4 $916
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 488
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $916
LABELV $919
line 2036
;2032:		(
;2033:			g_stamina.integer &&
;2034:			(ent->client->pers.cmd.buttons & BUTTON_HOLD_BREATH)
;2035:		)
;2036:	) {
line 2037
;2037:		ent->client->ps.stats[STAT_PANT_PHASE] = -1;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 216
ADDP4
CNSTI4 -1
ASGNI4
line 2047
;2038:#endif
;2039:		// JUHOX: new air-out condition
;2040:#if 0
;2041:		// envirosuit give air
;2042:		if ( envirosuit ) {
;2043:			ent->client->airOutTime = level.time + 10000;
;2044:		}
;2045:#else
;2046:		if (
;2047:			g_stamina.integer &&
ADDRGP4 g_stamina+12
INDIRI4
CNSTI4 0
EQI4 $920
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 0
LEI4 $920
line 2049
;2048:			ent->client->ps.stats[STAT_STRENGTH] > 0
;2049:		) {
line 2050
;2050:			ent->client->airOutTime = level.time + 10000;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 868
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 10000
ADDI4
ASGNI4
line 2051
;2051:		}
LABELV $920
line 2055
;2052:#endif
;2053:
;2054:		// if out of air, start drowning
;2055:		if ( ent->client->airOutTime < level.time) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 868
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
GEI4 $917
line 2057
;2056:			// drown!
;2057:			ent->client->airOutTime += 1000;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 868
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 2058
;2058:			if ( ent->health > 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
LEI4 $917
line 2060
;2059:				// take more damage the longer underwater
;2060:				ent->damage += 2;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 744
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 2078
;2061:				// JUHOX: no maximum drowning damage
;2062:#if 0
;2063:				if (ent->damage > 15)
;2064:					ent->damage = 15;
;2065:#endif
;2066:
;2067:				// play a gurp sound instead of a normal pain sound
;2068:				// JUHOX: don't play gurp sound if not in water (i.e. just holding breath)
;2069:#if 0
;2070:				if (ent->health <= ent->damage) {
;2071:					G_Sound(ent, CHAN_VOICE, G_SoundIndex("*drown.wav"));
;2072:				} else if (rand()&1) {
;2073:					G_Sound(ent, CHAN_VOICE, G_SoundIndex("sound/player/gurp1.wav"));
;2074:				} else {
;2075:					G_Sound(ent, CHAN_VOICE, G_SoundIndex("sound/player/gurp2.wav"));
;2076:				}
;2077:#else
;2078:				if (waterlevel >= 3) {
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $929
line 2079
;2079:					if (ent->health <= ent->damage) {
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
ADDRLP4 16
INDIRP4
CNSTI4 744
ADDP4
INDIRI4
GTI4 $931
line 2080
;2080:						G_Sound(ent, CHAN_VOICE, G_SoundIndex("*drown.wav"));
ADDRGP4 $933
ARGP4
ADDRLP4 20
ADDRGP4 G_SoundIndex
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRGP4 G_Sound
CALLV
pop
line 2081
;2081:					} else if (rand()&1) {
ADDRGP4 $932
JUMPV
LABELV $931
ADDRLP4 20
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $934
line 2082
;2082:						G_Sound(ent, CHAN_VOICE, G_SoundIndex("sound/player/gurp1.wav"));
ADDRGP4 $936
ARGP4
ADDRLP4 24
ADDRGP4 G_SoundIndex
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRGP4 G_Sound
CALLV
pop
line 2083
;2083:					} else {
ADDRGP4 $935
JUMPV
LABELV $934
line 2084
;2084:						G_Sound(ent, CHAN_VOICE, G_SoundIndex("sound/player/gurp2.wav"));
ADDRGP4 $937
ARGP4
ADDRLP4 24
ADDRGP4 G_SoundIndex
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRGP4 G_Sound
CALLV
pop
line 2085
;2085:					}
LABELV $935
LABELV $932
line 2086
;2086:				}
LABELV $929
line 2090
;2087:#endif
;2088:
;2089:				// don't play a normal pain sound
;2090:				ent->pain_debounce_time = level.time + 200;
ADDRFP4 0
INDIRP4
CNSTI4 724
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 200
ADDI4
ASGNI4
line 2092
;2091:
;2092:				G_Damage (ent, NULL, NULL, NULL, NULL, 
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 744
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
CNSTI4 19
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 2094
;2093:					ent->damage, DAMAGE_NO_ARMOR, MOD_WATER);
;2094:			}
line 2095
;2095:		}
line 2096
;2096:	} else {
ADDRGP4 $917
JUMPV
LABELV $916
line 2097
;2097:		ent->client->airOutTime = level.time + 12000;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 868
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 12000
ADDI4
ASGNI4
line 2098
;2098:		ent->damage = 2;
ADDRFP4 0
INDIRP4
CNSTI4 744
ADDP4
CNSTI4 2
ASGNI4
line 2099
;2099:	}
LABELV $917
line 2104
;2100:
;2101:	//
;2102:	// check for sizzle damage (move to pmove?)
;2103:	//
;2104:	if (waterlevel && 
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $940
ADDRFP4 0
INDIRP4
CNSTI4 788
ADDP4
INDIRI4
CNSTI4 24
BANDI4
CNSTI4 0
EQI4 $940
line 2105
;2105:		(ent->watertype&(CONTENTS_LAVA|CONTENTS_SLIME)) ) {
line 2106
;2106:		if (ent->health > 0
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
LEI4 $942
ADDRLP4 8
INDIRP4
CNSTI4 724
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
GTI4 $942
line 2107
;2107:			&& ent->pain_debounce_time <= level.time	) {
line 2109
;2108:
;2109:			if ( envirosuit ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $945
line 2110
;2110:				G_AddEvent( ent, EV_POWERUP_BATTLESUIT, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 63
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 2111
;2111:			} else {
ADDRGP4 $946
JUMPV
LABELV $945
line 2112
;2112:				if (ent->watertype & CONTENTS_LAVA) {
ADDRFP4 0
INDIRP4
CNSTI4 788
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $947
line 2113
;2113:					G_Damage (ent, NULL, NULL, NULL, NULL, 
ADDRFP4 0
INDIRP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 30
MULI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 21
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 2115
;2114:						30*waterlevel, 0, MOD_LAVA);
;2115:				}
LABELV $947
line 2117
;2116:
;2117:				if (ent->watertype & CONTENTS_SLIME) {
ADDRFP4 0
INDIRP4
CNSTI4 788
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $949
line 2118
;2118:					G_Damage (ent, NULL, NULL, NULL, NULL, 
ADDRFP4 0
INDIRP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 10
MULI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 20
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 2120
;2119:						10*waterlevel, 0, MOD_SLIME);
;2120:				}
LABELV $949
line 2121
;2121:			}
LABELV $946
line 2122
;2122:		}
LABELV $942
line 2123
;2123:	}
LABELV $940
line 2124
;2124:}
LABELV $912
endproc P_WorldEffects 28 32
export G_SetClientSound
proc G_SetClientSound 4 0
line 2133
;2125:
;2126:
;2127:
;2128:/*
;2129:===============
;2130:G_SetClientSound
;2131:===============
;2132:*/
;2133:void G_SetClientSound( gentity_t *ent ) {
line 2140
;2134:#ifdef MISSIONPACK
;2135:	if( ent->s.eFlags & EF_TICKING ) {
;2136:		ent->client->ps.loopSound = G_SoundIndex( "sound/weapons/proxmine/wstbtick.wav");
;2137:	}
;2138:	else
;2139:#endif
;2140:	if (ent->waterlevel && (ent->watertype&(CONTENTS_LAVA|CONTENTS_SLIME)) ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 792
ADDP4
INDIRI4
CNSTI4 0
EQI4 $952
ADDRLP4 0
INDIRP4
CNSTI4 788
ADDP4
INDIRI4
CNSTI4 24
BANDI4
CNSTI4 0
EQI4 $952
line 2141
;2141:		ent->client->ps.loopSound = level.snd_fry;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 444
ADDP4
ADDRGP4 level+364
INDIRI4
ASGNI4
line 2142
;2142:	} else {
ADDRGP4 $953
JUMPV
LABELV $952
line 2143
;2143:		ent->client->ps.loopSound = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 444
ADDP4
CNSTI4 0
ASGNI4
line 2144
;2144:	}
LABELV $953
line 2145
;2145:}
LABELV $951
endproc G_SetClientSound 4 0
export ClientImpacts
proc ClientImpacts 76 12
line 2156
;2146:
;2147:
;2148:
;2149://==============================================================
;2150:
;2151:/*
;2152:==============
;2153:ClientImpacts
;2154:==============
;2155:*/
;2156:void ClientImpacts( gentity_t *ent, pmove_t *pm ) {
line 2161
;2157:	int		i, j;
;2158:	trace_t	trace;
;2159:	gentity_t	*other;
;2160:
;2161:	memset( &trace, 0, sizeof( trace ) );
ADDRLP4 12
ARGP4
CNSTI4 0
ARGI4
CNSTI4 56
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2162
;2162:	for (i=0 ; i<pm->numtouch ; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $959
JUMPV
LABELV $956
line 2163
;2163:		for (j=0 ; j<i ; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $963
JUMPV
LABELV $960
line 2164
;2164:			if (pm->touchents[j] == pm->touchents[i] ) {
ADDRLP4 68
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68
INDIRP4
CNSTI4 84
ADDP4
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68
INDIRP4
CNSTI4 84
ADDP4
ADDP4
INDIRI4
NEI4 $964
line 2165
;2165:				break;
ADDRGP4 $962
JUMPV
LABELV $964
line 2167
;2166:			}
;2167:		}
LABELV $961
line 2163
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $963
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $960
LABELV $962
line 2168
;2168:		if (j != i) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $966
line 2169
;2169:			continue;	// duplicated
ADDRGP4 $957
JUMPV
LABELV $966
line 2171
;2170:		}
;2171:		other = &g_entities[ pm->touchents[i] ];
ADDRLP4 8
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 84
ADDP4
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 2173
;2172:
;2173:		if ( ( ent->r.svFlags & SVF_BOT ) && ( ent->touch ) ) {
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $968
ADDRLP4 68
INDIRP4
CNSTI4 708
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $968
line 2174
;2174:			ent->touch( ent, other, &trace );
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 72
INDIRP4
CNSTI4 708
ADDP4
INDIRP4
CALLV
pop
line 2175
;2175:		}
LABELV $968
line 2177
;2176:
;2177:		if ( !other->touch ) {
ADDRLP4 8
INDIRP4
CNSTI4 708
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $970
line 2178
;2178:			continue;
ADDRGP4 $957
JUMPV
LABELV $970
line 2181
;2179:		}
;2180:
;2181:		other->touch( other, ent, &trace );
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 708
ADDP4
INDIRP4
CALLV
pop
line 2182
;2182:	}
LABELV $957
line 2162
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $959
ADDRLP4 4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
LTI4 $956
line 2186
;2183:
;2184:	// JUHOX: let monsters detect touching players
;2185:#if MONSTER_MODE
;2186:	CheckTouchedMonsters(pm);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CheckTouchedMonsters
CALLV
pop
line 2188
;2187:#endif
;2188:}
LABELV $955
endproc ClientImpacts 76 12
data
align 4
LABELV $973
byte 4 1109393408
byte 4 1109393408
byte 4 1112539136
export G_TouchTriggers
code
proc G_TouchTriggers 4228 16
line 2198
;2189:
;2190:/*
;2191:============
;2192:G_TouchTriggers
;2193:
;2194:Find all trigger entities that ent's current position touches.
;2195:Spectators will only interact with teleporters.
;2196:============
;2197:*/
;2198:void	G_TouchTriggers( gentity_t *ent ) {
line 2206
;2199:	int			i, num;
;2200:	int			touch[MAX_GENTITIES];
;2201:	gentity_t	*hit;
;2202:	trace_t		trace;
;2203:	vec3_t		mins, maxs;
;2204:	static vec3_t	range = { 40, 40, 52 };
;2205:
;2206:	if ( !ent->client ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $974
line 2207
;2207:		return;
ADDRGP4 $972
JUMPV
LABELV $974
line 2215
;2208:	}
;2209:
;2210:#if PLAYER_SCREENSHOTS	// JUHOX: allow players to fall into void for player screenshots
;2211:	return;
;2212:#endif
;2213:
;2214:#if MAPLENSFLARES	// JUHOX: never touch triggers in lens flare editor
;2215:	if (g_editmode.integer == EM_mlf) return;
ADDRGP4 g_editmode+12
INDIRI4
CNSTI4 1
NEI4 $976
ADDRGP4 $972
JUMPV
LABELV $976
line 2223
;2216:#endif
;2217:
;2218:	// dead clients don't activate triggers!
;2219:#if 0	// JUHOX: only ignore dead clients if not spectating
;2220:	if ( ent->client->ps.stats[STAT_HEALTH] <= 0 ) {
;2221:#else
;2222:	if (
;2223:		ent->client->ps.stats[STAT_HEALTH] <= 0 &&
ADDRLP4 4188
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4188
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $979
ADDRLP4 4188
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $979
line 2225
;2224:		ent->client->ps.pm_type != PM_SPECTATOR
;2225:	) {
line 2227
;2226:#endif
;2227:		return;
ADDRGP4 $972
JUMPV
LABELV $979
line 2230
;2228:	}
;2229:
;2230:	VectorSubtract( ent->client->ps.origin, range, mins );
ADDRLP4 4192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
ADDRLP4 4192
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRGP4 $973
INDIRF4
SUBF4
ASGNF4
ADDRLP4 64+4
ADDRLP4 4192
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRGP4 $973+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 64+8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRGP4 $973+8
INDIRF4
SUBF4
ASGNF4
line 2231
;2231:	VectorAdd( ent->client->ps.origin, range, maxs );
ADDRLP4 4196
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
ADDRLP4 4196
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRGP4 $973
INDIRF4
ADDF4
ASGNF4
ADDRLP4 76+4
ADDRLP4 4196
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRGP4 $973+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 76+8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRGP4 $973+8
INDIRF4
ADDF4
ASGNF4
line 2233
;2232:
;2233:	num = trap_EntitiesInBox( mins, maxs, touch, MAX_GENTITIES );
ADDRLP4 64
ARGP4
ADDRLP4 76
ARGP4
ADDRLP4 92
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 4200
ADDRGP4 trap_EntitiesInBox
CALLI4
ASGNI4
ADDRLP4 88
ADDRLP4 4200
INDIRI4
ASGNI4
line 2236
;2234:
;2235:	// can't use ent->absmin, because that has a one unit pad
;2236:	VectorAdd( ent->client->ps.origin, ent->r.mins, mins );
ADDRLP4 4204
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
ADDRLP4 4204
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 4204
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 64+4
ADDRLP4 4204
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 4204
INDIRP4
CNSTI4 440
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4208
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64+8
ADDRLP4 4208
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 4208
INDIRP4
CNSTI4 444
ADDP4
INDIRF4
ADDF4
ASGNF4
line 2237
;2237:	VectorAdd( ent->client->ps.origin, ent->r.maxs, maxs );
ADDRLP4 4212
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
ADDRLP4 4212
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 4212
INDIRP4
CNSTI4 448
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 76+4
ADDRLP4 4212
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 4212
INDIRP4
CNSTI4 452
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4216
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76+8
ADDRLP4 4216
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 4216
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
ADDF4
ASGNF4
line 2239
;2238:
;2239:	for ( i=0 ; i<num ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $996
JUMPV
LABELV $993
line 2240
;2240:		hit = &g_entities[touch[i]];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 92
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 2242
;2241:
;2242:		if ( !hit->touch && !ent->touch ) {
ADDRLP4 0
INDIRP4
CNSTI4 708
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $997
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $997
line 2243
;2243:			continue;
ADDRGP4 $994
JUMPV
LABELV $997
line 2245
;2244:		}
;2245:		if ( !( hit->r.contents & CONTENTS_TRIGGER ) ) {
ADDRLP4 0
INDIRP4
CNSTI4 460
ADDP4
INDIRI4
CNSTI4 1073741824
BANDI4
CNSTI4 0
NEI4 $999
line 2246
;2246:			continue;
ADDRGP4 $994
JUMPV
LABELV $999
line 2253
;2247:		}
;2248:
;2249:		// ignore most entities if a spectator
;2250:#if 0	// JUHOX: determine spectators by 'pm_type'
;2251:		if ( ent->client->sess.sessionTeam == TEAM_SPECTATOR ) {
;2252:#else
;2253:		if (ent->client->ps.pm_type == PM_SPECTATOR) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1001
line 2255
;2254:#endif
;2255:			if ( hit->s.eType != ET_TELEPORT_TRIGGER &&
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 9
EQI4 $1003
ADDRLP4 0
INDIRP4
CNSTI4 708
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 Touch_DoorTrigger
CVPU4 4
EQU4 $1003
line 2258
;2256:				// this is ugly but adding a new ET_? type will
;2257:				// most likely cause network incompatibilities
;2258:				hit->touch != Touch_DoorTrigger) {
line 2259
;2259:				continue;
ADDRGP4 $994
JUMPV
LABELV $1003
line 2261
;2260:			}
;2261:		}
LABELV $1001
line 2265
;2262:
;2263:		// use seperate code for determining if an item is picked up
;2264:		// so you don't have to actually contact its bounding box
;2265:		if ( hit->s.eType == ET_ITEM ) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1005
line 2266
;2266:			if ( !BG_PlayerTouchesItem( &ent->client->ps, &hit->s, level.time ) ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 level+32
INDIRI4
ARGI4
ADDRLP4 4220
ADDRGP4 BG_PlayerTouchesItem
CALLI4
ASGNI4
ADDRLP4 4220
INDIRI4
CNSTI4 0
NEI4 $1006
line 2267
;2267:				continue;
ADDRGP4 $994
JUMPV
line 2269
;2268:			}
;2269:		} else {
LABELV $1005
line 2270
;2270:			if ( !trap_EntityContact( mins, maxs, hit ) ) {
ADDRLP4 64
ARGP4
ADDRLP4 76
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4220
ADDRGP4 trap_EntityContact
CALLI4
ASGNI4
ADDRLP4 4220
INDIRI4
CNSTI4 0
NEI4 $1010
line 2271
;2271:				continue;
ADDRGP4 $994
JUMPV
LABELV $1010
line 2273
;2272:			}
;2273:		}
LABELV $1006
line 2275
;2274:
;2275:		memset( &trace, 0, sizeof(trace) );
ADDRLP4 8
ARGP4
CNSTI4 0
ARGI4
CNSTI4 56
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2277
;2276:
;2277:		if ( hit->touch ) {
ADDRLP4 0
INDIRP4
CNSTI4 708
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1012
line 2278
;2278:			hit->touch (hit, ent, &trace);
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 708
ADDP4
INDIRP4
CALLV
pop
line 2279
;2279:		}
LABELV $1012
line 2281
;2280:
;2281:		if ( ( ent->r.svFlags & SVF_BOT ) && ( ent->touch ) ) {
ADDRLP4 4220
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4220
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $1014
ADDRLP4 4220
INDIRP4
CNSTI4 708
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1014
line 2282
;2282:			ent->touch( ent, hit, &trace );
ADDRLP4 4224
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4224
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 4224
INDIRP4
CNSTI4 708
ADDP4
INDIRP4
CALLV
pop
line 2283
;2283:		}
LABELV $1014
line 2284
;2284:	}
LABELV $994
line 2239
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $996
ADDRLP4 4
INDIRI4
ADDRLP4 88
INDIRI4
LTI4 $993
line 2287
;2285:
;2286:	// if we didn't touch a jump pad this pmove frame
;2287:	if ( ent->client->ps.jumppad_frame != ent->client->ps.pmove_framecount ) {
ADDRLP4 4220
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4220
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 460
ADDP4
INDIRI4
ADDRLP4 4220
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 456
ADDP4
INDIRI4
EQI4 $1016
line 2288
;2288:		ent->client->ps.jumppad_frame = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 0
ASGNI4
line 2289
;2289:		ent->client->ps.jumppad_ent = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 448
ADDP4
CNSTI4 0
ASGNI4
line 2290
;2290:	}
LABELV $1016
line 2291
;2291:}
LABELV $972
endproc G_TouchTriggers 4228 16
export SpectatorThink
proc SpectatorThink 276 12
line 2320
;2292:
;2293:// JUHOX: timescale values
;2294:#if SCREENSHOT_TOOLS
;2295:static const float timeScaleFromMode[16] = {
;2296:	1,
;2297:	1,		// 1
;2298:	0.71,	// 2
;2299:	0.5,	// 3
;2300:	0.35,	// 4
;2301:	0.25,	// 5
;2302:	0.18,	// 6
;2303:	0.1,	// 7
;2304:	0.071,	// 8
;2305:	0.05,	// 9
;2306:	1,
;2307:	1,
;2308:	1,
;2309:	1,
;2310:	1,
;2311:	1
;2312:};
;2313:#endif
;2314:
;2315:/*
;2316:=================
;2317:SpectatorThink
;2318:=================
;2319:*/
;2320:void SpectatorThink( gentity_t *ent, usercmd_t *ucmd ) {
line 2324
;2321:	pmove_t	pm;
;2322:	gclient_t	*client;
;2323:
;2324:	client = ent->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 2326
;2325:
;2326:	if ( client->sess.spectatorState != SPECTATOR_FOLLOW ) {
ADDRLP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRI4
CNSTI4 2
EQI4 $1019
line 2327
;2327:		client->ps.pm_type = PM_SPECTATOR;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 2
ASGNI4
line 2328
;2328:		client->ps.speed = 400;	// faster than normal
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 400
ASGNI4
line 2334
;2329:#if SCREENSHOT_TOOLS	// JUHOX: timescaled spectator speed
;2330:		if (ent->s.number == 0) client->ps.speed /= timeScaleFromMode[level.timeFreezeMode];
;2331:#endif
;2332:
;2333:		// set up for pmove
;2334:		memset (&pm, 0, sizeof(pm));
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 264
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2335
;2335:		pm.ps = &client->ps;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
line 2336
;2336:		pm.cmd = *ucmd;
ADDRLP4 4+4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 24
line 2337
;2337:		pm.tracemask = MASK_PLAYERSOLID & ~CONTENTS_BODY;	// spectators can fly through bodies
ADDRLP4 4+28
CNSTI4 65537
ASGNI4
line 2338
;2338:		pm.trace = trap_Trace;
ADDRLP4 4+256
ADDRGP4 trap_Trace
ASGNP4
line 2339
;2339:		pm.pointcontents = trap_PointContents;
ADDRLP4 4+260
ADDRGP4 trap_PointContents
ASGNP4
line 2342
;2340:
;2341:#if MONSTER_MODE	// JUHOX: set player scale factor for spectator
;2342:		pm.scale = 1;
ADDRLP4 4+68
CNSTF4 1065353216
ASGNF4
line 2345
;2343:#endif
;2344:
;2345:		pm.gametype = g_gametype.integer;	// JUHOX
ADDRLP4 4+64
ADDRGP4 g_gametype+12
INDIRI4
ASGNI4
line 2348
;2346:
;2347:#if MAPLENSFLARES	// JUHOX: set player tracemask & speed for lens flare editor
;2348:		if (g_editmode.integer == EM_mlf) {
ADDRGP4 g_editmode+12
INDIRI4
CNSTI4 1
NEI4 $1028
line 2349
;2349:			pm.tracemask = 0;
ADDRLP4 4+28
CNSTI4 0
ASGNI4
line 2350
;2350:			if (level.lfeFMM) {
ADDRGP4 level+23056
INDIRI4
CNSTI4 0
EQI4 $1032
line 2351
;2351:				client->ps.speed = 30;
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 30
ASGNI4
line 2352
;2352:				if (pm.cmd.buttons & BUTTON_WALKING) client->ps.speed = 15;
ADDRLP4 4+4+16
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1035
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 15
ASGNI4
LABELV $1035
line 2353
;2353:			}
LABELV $1032
line 2354
;2354:			if (pm.cmd.buttons & BUTTON_ATTACK) {
ADDRLP4 4+4+16
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1039
line 2355
;2355:				pm.cmd.forwardmove = 0;
ADDRLP4 4+4+21
CNSTI1 0
ASGNI1
line 2356
;2356:				pm.cmd.rightmove = 0;
ADDRLP4 4+4+22
CNSTI1 0
ASGNI1
line 2357
;2357:				pm.cmd.upmove = 0;
ADDRLP4 4+4+23
CNSTI1 0
ASGNI1
line 2358
;2358:			}
LABELV $1039
line 2359
;2359:		}
LABELV $1028
line 2363
;2360:#endif
;2361:
;2362:		// perform a pmove
;2363:		Pmove (&pm);
ADDRLP4 4
ARGP4
ADDRGP4 Pmove
CALLV
pop
line 2365
;2364:		// save results of pmove
;2365:		VectorCopy( client->ps.origin, ent->s.origin );
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 2367
;2366:
;2367:		G_TouchTriggers( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_TouchTriggers
CALLV
pop
line 2368
;2368:		trap_UnlinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 2369
;2369:	}
LABELV $1019
line 2371
;2370:
;2371:	client->oldbuttons = client->buttons;
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
ASGNI4
line 2372
;2372:	client->buttons = ucmd->buttons;
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 2376
;2373:
;2374:	// attack button cycles through spectators
;2375:#if !SCREENSHOT_TOOLS	// JUHOX: attack button toggles time freeze
;2376:	if ( ( client->buttons & BUTTON_ATTACK ) && ! ( client->oldbuttons & BUTTON_ATTACK ) ) {
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1049
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $1049
line 2377
;2377:		Cmd_FollowCycle_f( ent, 1 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Cmd_FollowCycle_f
CALLV
pop
line 2378
;2378:	}
LABELV $1049
line 2398
;2379:#else
;2380:	if ((client->buttons & BUTTON_ATTACK) && !(client->oldbuttons & BUTTON_ATTACK)) {
;2381:		Cmd_Stop_f(ent);
;2382:	}
;2383:#endif
;2384:
;2385:#if SCREENSHOT_TOOLS	// JUHOX: spectator's use button creates a screenshot
;2386:	if ((client->buttons & BUTTON_USE_HOLDABLE) && !(client->oldbuttons & BUTTON_USE_HOLDABLE)) {
;2387:		trap_SendServerCommand(client->ps.clientNum, "screenshot\n");
;2388:	}
;2389:#endif
;2390:#if SCREENSHOT_TOOLS	// JUHOX: spectator's weapon determines timeFreezeMode
;2391:	if (ent->s.number == 0 && level.time > client->respawnTime + 2000) {
;2392:		level.timeFreezeMode = ucmd->weapon;
;2393:		if (level.timeFreezeMode < 0) level.timeFreezeMode = 0;
;2394:		if (level.timeFreezeMode > 9) level.timeFreezeMode = 9;
;2395:		trap_Cvar_Set("timescale", va("%f", timeScaleFromMode[level.timeFreezeMode]));
;2396:	}
;2397:#endif
;2398:}
LABELV $1018
endproc SpectatorThink 276 12
export ClientInactivityTimer
proc ClientInactivityTimer 8 8
line 2409
;2399:
;2400:
;2401:
;2402:/*
;2403:=================
;2404:ClientInactivityTimer
;2405:
;2406:Returns qfalse if the client is dropped
;2407:=================
;2408:*/
;2409:qboolean ClientInactivityTimer( gclient_t *client ) {
line 2410
;2410:	if ( ! g_inactivity.integer ) {
ADDRGP4 g_inactivity+12
INDIRI4
CNSTI4 0
NEI4 $1052
line 2413
;2411:		// give everyone some time, so if the operator sets g_inactivity during
;2412:		// gameplay, everyone isn't kicked
;2413:		client->inactivityTime = level.time + 60 * 1000;
ADDRFP4 0
INDIRP4
CNSTI4 840
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 60000
ADDI4
ASGNI4
line 2414
;2414:		client->inactivityWarning = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 844
ADDP4
CNSTI4 0
ASGNI4
line 2415
;2415:	} else if ( client->pers.cmd.forwardmove || 
ADDRGP4 $1053
JUMPV
LABELV $1052
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 493
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1060
ADDRLP4 0
INDIRP4
CNSTI4 494
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1060
ADDRLP4 0
INDIRP4
CNSTI4 495
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1060
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1056
LABELV $1060
line 2418
;2416:		client->pers.cmd.rightmove || 
;2417:		client->pers.cmd.upmove ||
;2418:		(client->pers.cmd.buttons & BUTTON_ATTACK) ) {
line 2419
;2419:		client->inactivityTime = level.time + g_inactivity.integer * 1000;
ADDRFP4 0
INDIRP4
CNSTI4 840
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRGP4 g_inactivity+12
INDIRI4
CNSTI4 1000
MULI4
ADDI4
ASGNI4
line 2420
;2420:		client->inactivityWarning = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 844
ADDP4
CNSTI4 0
ASGNI4
line 2421
;2421:	} else if ( !client->pers.localClient ) {
ADDRGP4 $1057
JUMPV
LABELV $1056
ADDRFP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1063
line 2422
;2422:		if ( level.time > client->inactivityTime ) {
ADDRGP4 level+32
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 840
ADDP4
INDIRI4
LEI4 $1065
line 2423
;2423:			trap_DropClient( client - level.clients, "Dropped due to inactivity" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 level
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 5604
DIVI4
ARGI4
ADDRGP4 $1068
ARGP4
ADDRGP4 trap_DropClient
CALLV
pop
line 2424
;2424:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1051
JUMPV
LABELV $1065
line 2426
;2425:		}
;2426:		if ( level.time > client->inactivityTime - 10000 && !client->inactivityWarning ) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 840
ADDP4
INDIRI4
CNSTI4 10000
SUBI4
LEI4 $1069
ADDRLP4 4
INDIRP4
CNSTI4 844
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1069
line 2427
;2427:			client->inactivityWarning = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 844
ADDP4
CNSTI4 1
ASGNI4
line 2428
;2428:			trap_SendServerCommand( client - level.clients, "cp \"Ten seconds until inactivity drop!\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 level
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 5604
DIVI4
ARGI4
ADDRGP4 $1072
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2429
;2429:		}
LABELV $1069
line 2430
;2430:	}
LABELV $1063
LABELV $1057
LABELV $1053
line 2431
;2431:	return qtrue;
CNSTI4 1
RETI4
LABELV $1051
endproc ClientInactivityTimer 8 8
proc GetTeamBase 8 0
line 2440
;2432:}
;2433:
;2434:/*
;2435:==================
;2436:JUHOX: GetTeamBase
;2437:==================
;2438:*/
;2439:static qboolean GetTeamBase(team_t team, vec3_t origin, int* area)
;2440:{
line 2441
;2441:	if (g_gametype.integer != GT_CTF) return qfalse;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
EQI4 $1074
CNSTI4 0
RETI4
ADDRGP4 $1073
JUMPV
LABELV $1074
line 2442
;2442:	switch (team)
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $1080
ADDRLP4 0
INDIRI4
CNSTI4 2
EQI4 $1082
ADDRGP4 $1077
JUMPV
line 2443
;2443:	{
LABELV $1080
line 2445
;2444:	case TEAM_RED:
;2445:		VectorCopy(ctf_redflag.origin, origin);
ADDRFP4 4
INDIRP4
ADDRGP4 ctf_redflag
INDIRB
ASGNB 12
line 2446
;2446:		*area = ctf_redflag.areanum;
ADDRFP4 8
INDIRP4
ADDRGP4 ctf_redflag+12
INDIRI4
ASGNI4
line 2447
;2447:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1073
JUMPV
LABELV $1082
line 2449
;2448:	case TEAM_BLUE:
;2449:		VectorCopy(ctf_blueflag.origin, origin);
ADDRFP4 4
INDIRP4
ADDRGP4 ctf_blueflag
INDIRB
ASGNB 12
line 2450
;2450:		*area = ctf_blueflag.areanum;
ADDRFP4 8
INDIRP4
ADDRGP4 ctf_blueflag+12
INDIRI4
ASGNI4
line 2451
;2451:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1073
JUMPV
LABELV $1077
line 2453
;2452:	default:
;2453:		return qfalse;
CNSTI4 0
RETI4
LABELV $1073
endproc GetTeamBase 8 0
proc GetMissionGoal 96 12
line 2462
;2454:	}
;2455:}
;2456:
;2457:/*
;2458:==================
;2459:JUHOX: GetMissionGoal
;2460:==================
;2461:*/
;2462:static qboolean GetMissionGoal(gclient_t* client, vec3_t target, int* targetArea, int* targetEntity) {
line 2466
;2463:	tss_mission_t mission;
;2464:	bot_goal_t itemGoal;
;2465:
;2466:	mission = BG_TSS_GetPlayerInfo(&client->ps, TSSPI_mission);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRLP4 60
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 60
INDIRI4
ASGNI4
line 2467
;2467:	switch (mission) {
ADDRLP4 64
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 1
LTI4 $1086
ADDRLP4 64
INDIRI4
CNSTI4 6
GTI4 $1086
ADDRLP4 64
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1111-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1111
address $1088
address $1088
address $1089
address $1097
address $1105
address $1108
code
LABELV $1088
line 2470
;2468:	case TSSMISSION_seek_enemy:
;2469:	case TSSMISSION_seek_items:
;2470:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1084
JUMPV
LABELV $1089
line 2472
;2471:	case TSSMISSION_capture_enemy_flag:
;2472:		if (g_gametype.integer != GT_CTF) return qfalse;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
EQI4 $1090
CNSTI4 0
RETI4
ADDRGP4 $1084
JUMPV
LABELV $1090
line 2473
;2473:		if (!LocateFlag(OtherTeam(client->sess.sessionTeam), &itemGoal)) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
ADDRGP4 OtherTeam
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 76
ADDRGP4 LocateFlag
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
NEI4 $1093
CNSTI4 0
RETI4
ADDRGP4 $1084
JUMPV
LABELV $1093
line 2474
;2474:		VectorCopy(itemGoal.origin, target);
ADDRFP4 4
INDIRP4
ADDRLP4 4
INDIRB
ASGNB 12
line 2475
;2475:		*targetArea = itemGoal.areanum;
ADDRFP4 8
INDIRP4
ADDRLP4 4+12
INDIRI4
ASGNI4
line 2476
;2476:		*targetEntity = itemGoal.entitynum;
ADDRFP4 12
INDIRP4
ADDRLP4 4+40
INDIRI4
ASGNI4
line 2477
;2477:		break;
ADDRGP4 $1086
JUMPV
LABELV $1097
line 2479
;2478:	case TSSMISSION_defend_our_flag:
;2479:		if (g_gametype.integer != GT_CTF) return qfalse;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
EQI4 $1098
CNSTI4 0
RETI4
ADDRGP4 $1084
JUMPV
LABELV $1098
line 2480
;2480:		if (!LocateFlag(client->sess.sessionTeam, &itemGoal)) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 80
ADDRGP4 LocateFlag
CALLI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 0
NEI4 $1101
CNSTI4 0
RETI4
ADDRGP4 $1084
JUMPV
LABELV $1101
line 2481
;2481:		VectorCopy(itemGoal.origin, target);
ADDRFP4 4
INDIRP4
ADDRLP4 4
INDIRB
ASGNB 12
line 2482
;2482:		*targetArea = itemGoal.areanum;
ADDRFP4 8
INDIRP4
ADDRLP4 4+12
INDIRI4
ASGNI4
line 2483
;2483:		*targetEntity = itemGoal.entitynum;
ADDRFP4 12
INDIRP4
ADDRLP4 4+40
INDIRI4
ASGNI4
line 2484
;2484:		break;
ADDRGP4 $1086
JUMPV
LABELV $1105
line 2486
;2485:	case TSSMISSION_defend_our_base:
;2486:		if (!GetTeamBase(client->sess.sessionTeam, target, targetArea)) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 84
ADDRGP4 GetTeamBase
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
NEI4 $1086
CNSTI4 0
RETI4
ADDRGP4 $1084
JUMPV
line 2487
;2487:		break;
LABELV $1108
line 2489
;2488:	case TSSMISSION_occupy_enemy_base:
;2489:		if (!GetTeamBase(OtherTeam(client->sess.sessionTeam), target, targetArea)) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
ARGI4
ADDRLP4 88
ADDRGP4 OtherTeam
CALLI4
ASGNI4
ADDRLP4 88
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 92
ADDRGP4 GetTeamBase
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 0
NEI4 $1086
CNSTI4 0
RETI4
ADDRGP4 $1084
JUMPV
line 2490
;2490:		break;
line 2492
;2491:	default:
;2492:		break;
LABELV $1086
line 2494
;2493:	}
;2494:	return qtrue;
CNSTI4 1
RETI4
LABELV $1084
endproc GetMissionGoal 96 12
proc IsAreaVisited 4 0
line 2505
;2495:}
;2496:
;2497:/*
;2498:==================
;2499:JUHOX: IsAreaVisited
;2500:==================
;2501:*/
;2502:#define MAX_VISITED_AREAS 500
;2503:static int visitedAreas[MAX_VISITED_AREAS];
;2504:static int numVisitedAreas;
;2505:static qboolean IsAreaVisited(int area) {
line 2508
;2506:	int i;
;2507:
;2508:	for (i = 0; i < numVisitedAreas; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1117
JUMPV
LABELV $1114
line 2509
;2509:		if (visitedAreas[i] == area) return qtrue;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 visitedAreas
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $1118
CNSTI4 1
RETI4
ADDRGP4 $1113
JUMPV
LABELV $1118
line 2510
;2510:	}
LABELV $1115
line 2508
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1117
ADDRLP4 0
INDIRI4
ADDRGP4 numVisitedAreas
INDIRI4
LTI4 $1114
line 2511
;2511:	return qfalse;
CNSTI4 0
RETI4
LABELV $1113
endproc IsAreaVisited 4 0
proc AddVisitedArea 8 0
line 2519
;2512:}
;2513:
;2514:/*
;2515:==================
;2516:JUHOX: AddVisitedArea
;2517:==================
;2518:*/
;2519:static void AddVisitedArea(int area) {
line 2520
;2520:	visitedAreas[numVisitedAreas++] = area;
ADDRLP4 4
ADDRGP4 numVisitedAreas
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 visitedAreas
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 2521
;2521:}
LABELV $1120
endproc AddVisitedArea 8 0
proc NavAid 660 44
line 2530
;2522:
;2523:/*
;2524:==================
;2525:JUHOX: NavAid
;2526:==================
;2527:*/
;2528:#define MAX_AREA_PREDICTION 5
;2529:#define AREABUFFER_SIZE 100
;2530:static void NavAid(gclient_t* client) {
line 2543
;2531:	tss_missionTask_t task;
;2532:	int taskGoal;
;2533:	gclient_t* taskGoalClient;
;2534:	vec3_t destination;
;2535:	int destArea;
;2536:	int startArea;
;2537:	vec3_t startPos;
;2538:	gentity_t* ent;
;2539:	aas_predictroute_t route;
;2540:	int i;
;2541:	qboolean retreat;
;2542:
;2543:	if (!client) return;
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1122
ADDRGP4 $1121
JUMPV
LABELV $1122
line 2544
;2544:	if (client->ps.stats[STAT_HEALTH] <= 0) return;
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $1124
ADDRGP4 $1121
JUMPV
LABELV $1124
line 2545
;2545:	if (!BG_TSS_GetPlayerInfo(&client->ps, TSSPI_isValid)) return;
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 92
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 0
NEI4 $1126
ADDRGP4 $1121
JUMPV
LABELV $1126
line 2546
;2546:	if (!BG_TSS_GetPlayerInfo(&client->ps, TSSPI_navAid)) return;
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 11
ARGI4
ADDRLP4 96
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 96
INDIRI4
CNSTI4 0
NEI4 $1128
ADDRGP4 $1121
JUMPV
LABELV $1128
line 2547
;2547:	if (!trap_AAS_Initialized()) return;
ADDRLP4 100
ADDRGP4 trap_AAS_Initialized
CALLI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 0
NEI4 $1130
ADDRGP4 $1121
JUMPV
LABELV $1130
line 2549
;2548:
;2549:	BotFindCTFBases();
ADDRGP4 BotFindCTFBases
CALLV
pop
line 2551
;2550:
;2551:	task = BG_TSS_GetPlayerInfo(&client->ps, TSSPI_task);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 5
ARGI4
ADDRLP4 104
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 84
ADDRLP4 104
INDIRI4
ASGNI4
line 2552
;2552:	destArea = -1;
ADDRLP4 52
CNSTI4 -1
ASGNI4
line 2553
;2553:	taskGoal = ENTITYNUM_NONE;
ADDRLP4 64
CNSTI4 1023
ASGNI4
line 2554
;2554:	retreat = qfalse;
ADDRLP4 68
CNSTI4 0
ASGNI4
line 2555
;2555:	switch (task) {
ADDRLP4 108
ADDRLP4 84
INDIRI4
ASGNI4
ADDRLP4 108
INDIRI4
CNSTI4 0
LTI4 $1121
ADDRLP4 108
INDIRI4
CNSTI4 9
GTI4 $1121
ADDRLP4 108
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1175
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1175
address $1146
address $1135
address $1161
address $1135
address $1135
address $1169
address $1135
address $1135
address $1172
address $1161
code
LABELV $1135
line 2561
;2556:	case TSSMT_stickToGroupLeader:
;2557:	case TSSMT_helpTeamMate:
;2558:	case TSSMT_guardFlagCarrier:
;2559:	case TSSMT_seekGroupMember:
;2560:	case TSSMT_seekEnemyNearTeamMate:
;2561:		taskGoal = BG_TSS_GetPlayerInfo(&client->ps, TSSPI_taskGoal);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 13
ARGI4
ADDRLP4 116
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 64
ADDRLP4 116
INDIRI4
ASGNI4
line 2562
;2562:		if (taskGoal < 0 || taskGoal >= MAX_CLIENTS) return;
ADDRLP4 120
ADDRLP4 64
INDIRI4
ASGNI4
ADDRLP4 120
INDIRI4
CNSTI4 0
LTI4 $1138
ADDRLP4 120
INDIRI4
CNSTI4 64
LTI4 $1136
LABELV $1138
ADDRGP4 $1121
JUMPV
LABELV $1136
line 2563
;2563:		if (!g_entities[taskGoal].inuse) return;
ADDRLP4 64
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1139
ADDRGP4 $1121
JUMPV
LABELV $1139
line 2564
;2564:		taskGoalClient = level.clients + taskGoal;
ADDRLP4 88
ADDRLP4 64
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 2565
;2565:		if (taskGoalClient->sess.sessionTeam != client->sess.sessionTeam) return;
ADDRLP4 88
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
EQI4 $1142
ADDRGP4 $1121
JUMPV
LABELV $1142
line 2566
;2566:		if (taskGoalClient->ps.stats[STAT_HEALTH] <= 0) return;
ADDRLP4 88
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $1144
ADDRGP4 $1121
JUMPV
LABELV $1144
line 2567
;2567:		VectorCopy(taskGoalClient->ps.origin, destination);
ADDRLP4 72
ADDRLP4 88
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 2568
;2568:		destArea = taskGoalClient->tssLastValidAreaNum;
ADDRLP4 52
ADDRLP4 88
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
ASGNI4
line 2569
;2569:		break;
ADDRGP4 $1133
JUMPV
LABELV $1146
line 2571
;2570:	case TSSMT_followGroupLeader:
;2571:		taskGoal = BG_TSS_GetPlayerInfo(&client->ps, TSSPI_taskGoal);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 13
ARGI4
ADDRLP4 124
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 64
ADDRLP4 124
INDIRI4
ASGNI4
line 2572
;2572:		if (taskGoal < 0 || taskGoal >= MAX_CLIENTS) return;
ADDRLP4 128
ADDRLP4 64
INDIRI4
ASGNI4
ADDRLP4 128
INDIRI4
CNSTI4 0
LTI4 $1149
ADDRLP4 128
INDIRI4
CNSTI4 64
LTI4 $1147
LABELV $1149
ADDRGP4 $1121
JUMPV
LABELV $1147
line 2573
;2573:		if (!g_entities[taskGoal].inuse) return;
ADDRLP4 64
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1150
ADDRGP4 $1121
JUMPV
LABELV $1150
line 2574
;2574:		taskGoalClient = level.clients + taskGoal;
ADDRLP4 88
ADDRLP4 64
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 2575
;2575:		if (taskGoalClient->sess.sessionTeam != client->sess.sessionTeam) return;
ADDRLP4 88
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
EQI4 $1153
ADDRGP4 $1121
JUMPV
LABELV $1153
line 2576
;2576:		if (taskGoalClient->ps.stats[STAT_HEALTH] <= 0) return;
ADDRLP4 88
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $1155
ADDRGP4 $1121
JUMPV
LABELV $1155
line 2578
;2577:		
;2578:		if (GetMissionGoal(client, destination, &destArea, &i)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 72
ARGP4
ADDRLP4 52
ARGP4
ADDRLP4 60
ARGP4
ADDRLP4 132
ADDRGP4 GetMissionGoal
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 0
EQI4 $1157
line 2580
;2579:			if (
;2580:				trap_AAS_AreaTravelTimeToGoalArea(
ADDRLP4 136
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 136
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
ARGI4
ADDRLP4 136
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 88
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 140
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 144
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
ARGI4
ADDRLP4 144
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 52
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 148
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
ADDRLP4 148
INDIRI4
CNSTI4 200
ADDI4
LEI4 $1159
line 2587
;2581:					client->tssLastValidAreaNum, client->ps.origin, taskGoalClient->tssLastValidAreaNum,
;2582:					TFL_DEFAULT
;2583:				) >
;2584:				trap_AAS_AreaTravelTimeToGoalArea(
;2585:					client->tssLastValidAreaNum, client->ps.origin, destArea, TFL_DEFAULT
;2586:				) + 200
;2587:			) {
line 2588
;2588:				taskGoal = i;
ADDRLP4 64
ADDRLP4 60
INDIRI4
ASGNI4
line 2589
;2589:				break;
ADDRGP4 $1133
JUMPV
LABELV $1159
line 2591
;2590:			}
;2591:		}
LABELV $1157
line 2592
;2592:		VectorCopy(taskGoalClient->ps.origin, destination);
ADDRLP4 72
ADDRLP4 88
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 2593
;2593:		destArea = taskGoalClient->tssLastValidAreaNum;
ADDRLP4 52
ADDRLP4 88
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
ASGNI4
line 2594
;2594:		break;
ADDRGP4 $1133
JUMPV
LABELV $1161
line 2597
;2595:	case TSSMT_retreat:
;2596:	case TSSMT_prepareForMission:
;2597:		if (client->ps.powerups[PW_REDFLAG] || client->ps.powerups[PW_BLUEFLAG]) {
ADDRLP4 136
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 136
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1164
ADDRLP4 136
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1162
LABELV $1164
line 2598
;2598:			if (!GetTeamBase(client->sess.sessionTeam, destination, &destArea)) return;
ADDRFP4 0
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
ARGP4
ADDRLP4 52
ARGP4
ADDRLP4 140
ADDRGP4 GetTeamBase
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
NEI4 $1163
ADDRGP4 $1121
JUMPV
line 2599
;2599:		}
LABELV $1162
line 2600
;2600:		else {
line 2601
;2601:			if (!GetMissionGoal(client, destination, &destArea, &taskGoal)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 72
ARGP4
ADDRLP4 52
ARGP4
ADDRLP4 64
ARGP4
ADDRLP4 140
ADDRGP4 GetMissionGoal
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
NEI4 $1167
ADDRGP4 $1121
JUMPV
LABELV $1167
line 2602
;2602:		}
LABELV $1163
line 2603
;2603:		retreat = qtrue;
ADDRLP4 68
CNSTI4 1
ASGNI4
line 2604
;2604:		break;
ADDRGP4 $1133
JUMPV
LABELV $1169
line 2606
;2605:	case TSSMT_rushToBase:
;2606:		if (!GetTeamBase(client->sess.sessionTeam, destination, &destArea)) return;
ADDRFP4 0
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
ARGP4
ADDRLP4 52
ARGP4
ADDRLP4 140
ADDRGP4 GetTeamBase
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
NEI4 $1133
ADDRGP4 $1121
JUMPV
line 2607
;2607:		break;
LABELV $1172
line 2609
;2608:	case TSSMT_fulfilMission:
;2609:		if (!GetMissionGoal(client, destination, &destArea, &taskGoal)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 72
ARGP4
ADDRLP4 52
ARGP4
ADDRLP4 64
ARGP4
ADDRLP4 144
ADDRGP4 GetMissionGoal
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
NEI4 $1133
ADDRGP4 $1121
JUMPV
line 2610
;2610:		break;
line 2612
;2611:	default:
;2612:		return;
LABELV $1133
line 2615
;2613:	}
;2614:
;2615:	if (destArea < 0) destArea = BotPointAreaNum(destination);
ADDRLP4 52
INDIRI4
CNSTI4 0
GEI4 $1176
ADDRLP4 72
ARGP4
ADDRLP4 116
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 52
ADDRLP4 116
INDIRI4
ASGNI4
LABELV $1176
line 2616
;2616:	if (destArea <= 0) return;
ADDRLP4 52
INDIRI4
CNSTI4 0
GTI4 $1178
ADDRGP4 $1121
JUMPV
LABELV $1178
line 2617
;2617:	if (!trap_AAS_AreaReachability(destArea)) return;
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 120
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 120
INDIRI4
CNSTI4 0
NEI4 $1180
ADDRGP4 $1121
JUMPV
LABELV $1180
line 2619
;2618:	//startArea = BotPointAreaNum(client->ps.origin);
;2619:	startArea = client->tssLastValidAreaNum;
ADDRLP4 48
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
ASGNI4
line 2620
;2620:	if (startArea <= 0) return;
ADDRLP4 48
INDIRI4
CNSTI4 0
GTI4 $1182
ADDRGP4 $1121
JUMPV
LABELV $1182
line 2621
;2621:	if (!trap_AAS_AreaReachability(startArea)) return;
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 124
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 124
INDIRI4
CNSTI4 0
NEI4 $1184
ADDRGP4 $1121
JUMPV
LABELV $1184
line 2623
;2622:
;2623:	ent = G_TempEntity(client->ps.origin, EV_NAVAID0);
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
ARGP4
CNSTI4 88
ARGI4
ADDRLP4 128
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 56
ADDRLP4 128
INDIRP4
ASGNP4
line 2624
;2624:	if (!ent) return;
ADDRLP4 56
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1186
ADDRGP4 $1121
JUMPV
LABELV $1186
line 2625
;2625:	ent->r.singleClient = client->ps.clientNum;
ADDRLP4 56
INDIRP4
CNSTI4 428
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 2626
;2626:	ent->r.svFlags |= SVF_SINGLECLIENT;
ADDRLP4 132
ADDRLP4 56
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 132
INDIRP4
ADDRLP4 132
INDIRP4
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 2627
;2627:	ent->s.otherEntityNum = taskGoal;
ADDRLP4 56
INDIRP4
CNSTI4 140
ADDP4
ADDRLP4 64
INDIRI4
ASGNI4
line 2628
;2628:	ent->s.otherEntityNum2 = retreat;
ADDRLP4 56
INDIRP4
CNSTI4 144
ADDP4
ADDRLP4 68
INDIRI4
ASGNI4
line 2629
;2629:	VectorCopy(destination, ent->s.pos.trDelta);
ADDRLP4 56
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 72
INDIRB
ASGNB 12
line 2630
;2630:	ent->s.time = level.time;
ADDRLP4 56
INDIRP4
CNSTI4 84
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 2631
;2631:	ent->s.time2 = 2;	// start & end position
ADDRLP4 56
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 2
ASGNI4
line 2633
;2632:
;2633:	numVisitedAreas = 0;
ADDRGP4 numVisitedAreas
CNSTI4 0
ASGNI4
line 2634
;2634:	AddVisitedArea(startArea);
ADDRLP4 48
INDIRI4
ARGI4
ADDRGP4 AddVisitedArea
CALLV
pop
line 2635
;2635:	VectorCopy(client->ps.origin, startPos);
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 2636
;2636:	for (i = 2; i < NAVAID_PACKETS * 8; i++) {
ADDRLP4 60
CNSTI4 2
ASGNI4
LABELV $1189
line 2639
;2637:		int j;
;2638:
;2639:		if (startArea == destArea) return;
ADDRLP4 48
INDIRI4
ADDRLP4 52
INDIRI4
NEI4 $1193
ADDRGP4 $1121
JUMPV
LABELV $1193
line 2640
;2640:		for (j = 1; j <= MAX_AREA_PREDICTION; j++) {
ADDRLP4 136
CNSTI4 1
ASGNI4
LABELV $1195
line 2641
;2641:			trap_AAS_PredictRoute(
ADDRLP4 0
ARGP4
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 36
ARGP4
ADDRLP4 52
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 136
INDIRI4
ARGI4
CNSTI4 100000
ARGI4
CNSTI4 3
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1024
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_AAS_PredictRoute
CALLI4
pop
line 2645
;2642:				&route, startArea, startPos, destArea, TFL_DEFAULT, j, 100000,
;2643:				RSE_NOROUTE | RSE_USETRAVELTYPE, 0, TFL_TELEPORT, 0
;2644:			);
;2645:			if (route.stopevent & RSE_NOROUTE) return;
ADDRLP4 0+16
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1199
ADDRGP4 $1121
JUMPV
LABELV $1199
line 2646
;2646:			if (route.stopevent & RSE_USETRAVELTYPE) break;
ADDRLP4 0+16
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1202
ADDRGP4 $1197
JUMPV
LABELV $1202
line 2647
;2647:			if (route.endarea == destArea) break;
ADDRLP4 0+12
INDIRI4
ADDRLP4 52
INDIRI4
NEI4 $1205
ADDRGP4 $1197
JUMPV
LABELV $1205
line 2648
;2648:			if (route.endarea == startArea) continue;
ADDRLP4 0+12
INDIRI4
ADDRLP4 48
INDIRI4
NEI4 $1208
ADDRGP4 $1196
JUMPV
LABELV $1208
line 2649
;2649:			AddVisitedArea(route.endarea);
ADDRLP4 0+12
INDIRI4
ARGI4
ADDRGP4 AddVisitedArea
CALLV
pop
line 2650
;2650:			if (DistanceSquared(route.endpos, startPos) > Square(25)) break;
ADDRLP4 0
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 140
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 140
INDIRF4
CNSTF4 1142702080
LEF4 $1212
ADDRGP4 $1197
JUMPV
LABELV $1212
line 2651
;2651:		}
LABELV $1196
line 2640
ADDRLP4 136
ADDRLP4 136
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 136
INDIRI4
CNSTI4 5
LEI4 $1195
LABELV $1197
line 2652
;2652:		if (j > MAX_AREA_PREDICTION) {
ADDRLP4 136
INDIRI4
CNSTI4 5
LEI4 $1214
line 2661
;2653:			//return;
;2654:			int areas[AREABUFFER_SIZE];
;2655:			int numAreas;
;2656:			vec3_t absmins;
;2657:			vec3_t absmaxs;
;2658:			int currentTravelTime;
;2659:			float bestDistance;
;2660:
;2661:			currentTravelTime = trap_AAS_AreaTravelTimeToGoalArea(startArea, startPos, destArea, TFL_DEFAULT);
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 36
ARGP4
ADDRLP4 52
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 576
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 548
ADDRLP4 576
INDIRI4
ASGNI4
line 2662
;2662:			VectorSet(absmins, -100, -100, -100);
ADDRLP4 552
CNSTF4 3267887104
ASGNF4
ADDRLP4 552+4
CNSTF4 3267887104
ASGNF4
ADDRLP4 552+8
CNSTF4 3267887104
ASGNF4
line 2663
;2663:			VectorSet(absmaxs, 100, 100, 100);
ADDRLP4 564
CNSTF4 1120403456
ASGNF4
ADDRLP4 564+4
CNSTF4 1120403456
ASGNF4
ADDRLP4 564+8
CNSTF4 1120403456
ASGNF4
line 2664
;2664:			VectorAdd(absmins, startPos, absmins);
ADDRLP4 552
ADDRLP4 552
INDIRF4
ADDRLP4 36
INDIRF4
ADDF4
ASGNF4
ADDRLP4 552+4
ADDRLP4 552+4
INDIRF4
ADDRLP4 36+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 552+8
ADDRLP4 552+8
INDIRF4
ADDRLP4 36+8
INDIRF4
ADDF4
ASGNF4
line 2665
;2665:			VectorAdd(absmaxs, startPos, absmaxs);
ADDRLP4 564
ADDRLP4 564
INDIRF4
ADDRLP4 36
INDIRF4
ADDF4
ASGNF4
ADDRLP4 564+4
ADDRLP4 564+4
INDIRF4
ADDRLP4 36+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 564+8
ADDRLP4 564+8
INDIRF4
ADDRLP4 36+8
INDIRF4
ADDF4
ASGNF4
line 2666
;2666:			numAreas = trap_AAS_BBoxAreas(absmins, absmaxs, areas, AREABUFFER_SIZE);
ADDRLP4 552
ARGP4
ADDRLP4 564
ARGP4
ADDRLP4 144
ARGP4
CNSTI4 100
ARGI4
ADDRLP4 580
ADDRGP4 trap_AAS_BBoxAreas
CALLI4
ASGNI4
ADDRLP4 544
ADDRLP4 580
INDIRI4
ASGNI4
line 2667
;2667:			route.endarea = -1;
ADDRLP4 0+12
CNSTI4 -1
ASGNI4
line 2668
;2668:			bestDistance = 100000000.0;
ADDRLP4 140
CNSTF4 1287568416
ASGNF4
line 2669
;2669:			for (j = 0; j < numAreas; j++) {
ADDRLP4 136
CNSTI4 0
ASGNI4
ADDRGP4 $1236
JUMPV
LABELV $1233
line 2675
;2670:				int area;
;2671:				struct aas_areainfo_s areaInfo;
;2672:				int travelTime;
;2673:				float distance;
;2674:
;2675:				area = areas[j];
ADDRLP4 584
ADDRLP4 136
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 144
ADDP4
INDIRI4
ASGNI4
line 2676
;2676:				if (area == startArea) continue;
ADDRLP4 584
INDIRI4
ADDRLP4 48
INDIRI4
NEI4 $1237
ADDRGP4 $1234
JUMPV
LABELV $1237
line 2678
;2677:
;2678:				trap_AAS_AreaInfo(area, &areaInfo);
ADDRLP4 584
INDIRI4
ARGI4
ADDRLP4 588
ARGP4
ADDRGP4 trap_AAS_AreaInfo
CALLI4
pop
line 2679
;2679:				travelTime = trap_AAS_AreaTravelTimeToGoalArea(area, areaInfo.center, destArea, TFL_DEFAULT);
ADDRLP4 584
INDIRI4
ARGI4
ADDRLP4 588+40
ARGP4
ADDRLP4 52
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 648
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 640
ADDRLP4 648
INDIRI4
ASGNI4
line 2680
;2680:				if (travelTime <= 0) continue;
ADDRLP4 640
INDIRI4
CNSTI4 0
GTI4 $1240
ADDRGP4 $1234
JUMPV
LABELV $1240
line 2681
;2681:				if (travelTime >= currentTravelTime) continue;
ADDRLP4 640
INDIRI4
ADDRLP4 548
INDIRI4
LTI4 $1242
ADDRGP4 $1234
JUMPV
LABELV $1242
line 2683
;2682:
;2683:				distance = DistanceSquared(areaInfo.center, startPos);
ADDRLP4 588+40
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 652
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 644
ADDRLP4 652
INDIRF4
ASGNF4
line 2684
;2684:				if (distance >= bestDistance) continue;
ADDRLP4 644
INDIRF4
ADDRLP4 140
INDIRF4
LTF4 $1245
ADDRGP4 $1234
JUMPV
LABELV $1245
line 2686
;2685:
;2686:				if (IsAreaVisited(area)) continue;
ADDRLP4 584
INDIRI4
ARGI4
ADDRLP4 656
ADDRGP4 IsAreaVisited
CALLI4
ASGNI4
ADDRLP4 656
INDIRI4
CNSTI4 0
EQI4 $1247
ADDRGP4 $1234
JUMPV
LABELV $1247
line 2688
;2687:
;2688:				bestDistance = distance;
ADDRLP4 140
ADDRLP4 644
INDIRF4
ASGNF4
line 2689
;2689:				route.endarea = area;
ADDRLP4 0+12
ADDRLP4 584
INDIRI4
ASGNI4
line 2690
;2690:				VectorCopy(areaInfo.center, route.endpos);
ADDRLP4 0
ADDRLP4 588+40
INDIRB
ASGNB 12
line 2691
;2691:			}
LABELV $1234
line 2669
ADDRLP4 136
ADDRLP4 136
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1236
ADDRLP4 136
INDIRI4
ADDRLP4 544
INDIRI4
LTI4 $1233
line 2692
;2692:			if (route.endarea < 0) return;
ADDRLP4 0+12
INDIRI4
CNSTI4 0
GEI4 $1251
ADDRGP4 $1121
JUMPV
LABELV $1251
line 2693
;2693:			AddVisitedArea(route.endarea);
ADDRLP4 0+12
INDIRI4
ARGI4
ADDRGP4 AddVisitedArea
CALLV
pop
line 2694
;2694:		}
LABELV $1214
line 2695
;2695:		SnapVector(route.endpos);
ADDRLP4 0
ADDRLP4 0
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 2697
;2696:
;2697:		switch (i & 7) {
ADDRLP4 140
ADDRLP4 60
INDIRI4
CNSTI4 7
BANDI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
LTI4 $1259
ADDRLP4 140
INDIRI4
CNSTI4 7
GTI4 $1259
ADDRLP4 140
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1273
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1273
address $1262
address $1266
address $1267
address $1268
address $1269
address $1270
address $1271
address $1272
code
LABELV $1262
line 2699
;2698:		case 0:
;2699:			ent = G_TempEntity(route.endpos, EV_NAVAID0 + (i >> 3));
ADDRLP4 0
ARGP4
ADDRLP4 60
INDIRI4
CNSTI4 3
RSHI4
CNSTI4 88
ADDI4
ARGI4
ADDRLP4 148
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 56
ADDRLP4 148
INDIRP4
ASGNP4
line 2700
;2700:			if (!ent) return;
ADDRLP4 56
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1263
ADDRGP4 $1121
JUMPV
LABELV $1263
line 2701
;2701:			ent->r.singleClient = client->ps.clientNum;
ADDRLP4 56
INDIRP4
CNSTI4 428
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 2702
;2702:			ent->r.svFlags |= SVF_SINGLECLIENT;
ADDRLP4 152
ADDRLP4 56
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 152
INDIRP4
ADDRLP4 152
INDIRP4
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 2703
;2703:			ent->s.otherEntityNum = taskGoal;
ADDRLP4 56
INDIRP4
CNSTI4 140
ADDP4
ADDRLP4 64
INDIRI4
ASGNI4
line 2704
;2704:			ent->s.otherEntityNum2 = retreat;
ADDRLP4 56
INDIRP4
CNSTI4 144
ADDP4
ADDRLP4 68
INDIRI4
ASGNI4
line 2705
;2705:			ent->s.time = level.time;
ADDRLP4 56
INDIRP4
CNSTI4 84
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 2706
;2706:			ent->s.time2 = 0;	// increased below
ADDRLP4 56
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 0
ASGNI4
line 2707
;2707:			break;
ADDRGP4 $1260
JUMPV
LABELV $1266
line 2709
;2708:		case 1:
;2709:			VectorCopy(route.endpos, ent->s.pos.trDelta);
ADDRLP4 56
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 0
INDIRB
ASGNB 12
line 2710
;2710:			break;
ADDRGP4 $1260
JUMPV
LABELV $1267
line 2712
;2711:		case 2:
;2712:			VectorCopy(route.endpos, ent->s.apos.trBase);
ADDRLP4 56
INDIRP4
CNSTI4 60
ADDP4
ADDRLP4 0
INDIRB
ASGNB 12
line 2713
;2713:			break;
ADDRGP4 $1260
JUMPV
LABELV $1268
line 2715
;2714:		case 3:
;2715:			VectorCopy(route.endpos, ent->s.apos.trDelta);
ADDRLP4 56
INDIRP4
CNSTI4 72
ADDP4
ADDRLP4 0
INDIRB
ASGNB 12
line 2716
;2716:			break;
ADDRGP4 $1260
JUMPV
LABELV $1269
line 2718
;2717:		case 4:
;2718:			VectorCopy(route.endpos, ent->s.origin);
ADDRLP4 56
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 0
INDIRB
ASGNB 12
line 2719
;2719:			break;
ADDRGP4 $1260
JUMPV
LABELV $1270
line 2721
;2720:		case 5:
;2721:			VectorCopy(route.endpos, ent->s.origin2);
ADDRLP4 56
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 0
INDIRB
ASGNB 12
line 2722
;2722:			break;
ADDRGP4 $1260
JUMPV
LABELV $1271
line 2724
;2723:		case 6:
;2724:			VectorCopy(route.endpos, ent->s.angles);
ADDRLP4 56
INDIRP4
CNSTI4 116
ADDP4
ADDRLP4 0
INDIRB
ASGNB 12
line 2725
;2725:			break;
ADDRGP4 $1260
JUMPV
LABELV $1272
line 2727
;2726:		case 7:
;2727:			VectorCopy(route.endpos, ent->s.angles2);
ADDRLP4 56
INDIRP4
CNSTI4 128
ADDP4
ADDRLP4 0
INDIRB
ASGNB 12
line 2728
;2728:			break;
LABELV $1259
LABELV $1260
line 2730
;2729:		}
;2730:		ent->s.time2++;
ADDRLP4 148
ADDRLP4 56
INDIRP4
CNSTI4 88
ADDP4
ASGNP4
ADDRLP4 148
INDIRP4
ADDRLP4 148
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2731
;2731:		if (route.stopevent & RSE_USETRAVELTYPE) return;
ADDRLP4 0+16
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1274
ADDRGP4 $1121
JUMPV
LABELV $1274
line 2733
;2732:
;2733:		startArea = route.endarea;
ADDRLP4 48
ADDRLP4 0+12
INDIRI4
ASGNI4
line 2734
;2734:		VectorCopy(route.endpos, startPos);
ADDRLP4 36
ADDRLP4 0
INDIRB
ASGNB 12
line 2735
;2735:	}
LABELV $1190
line 2636
ADDRLP4 60
ADDRLP4 60
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 40
LTI4 $1189
line 2736
;2736:}
LABELV $1121
endproc NavAid 660 44
export ClientTimerActions
proc ClientTimerActions 36 12
line 2745
;2737:
;2738:/*
;2739:==================
;2740:ClientTimerActions
;2741:
;2742:Actions that happen once a second
;2743:==================
;2744:*/
;2745:void ClientTimerActions( gentity_t *ent, int msec ) {
line 2751
;2746:	gclient_t	*client;
;2747:#ifdef MISSIONPACK
;2748:	int			maxHealth;
;2749:#endif
;2750:
;2751:	client = ent->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 2752
;2752:	if (client->tssSafetyMode) return;	// JUHOX
ADDRLP4 0
INDIRP4
CNSTI4 768
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1279
ADDRGP4 $1278
JUMPV
LABELV $1279
line 2753
;2753:	client->timeResidual += msec;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
ADDRFP4 4
INDIRI4
ADDI4
ASGNI4
line 2756
;2754:
;2755:#if 1	// JUHOX: update nav aid
;2756:	if (!(ent->r.svFlags & SVF_BOT)) {
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $1286
line 2757
;2757:		client->tssNavAidTimeResidual += msec;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 896
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
ADDRFP4 4
INDIRI4
ADDI4
ASGNI4
line 2759
;2758:
;2759:		if (client->tssNavAidTimeResidual >= 1000) {
ADDRLP4 0
INDIRP4
CNSTI4 896
ADDP4
INDIRI4
CNSTI4 1000
LTI4 $1286
line 2760
;2760:			client->tssNavAidTimeResidual %= 1000;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 896
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1000
MODI4
ASGNI4
line 2761
;2761:			client->tssNavAidTimeResidual -= (rand() % 100);
ADDRLP4 16
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 896
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
ADDRLP4 16
INDIRI4
CNSTI4 100
MODI4
SUBI4
ASGNI4
line 2763
;2762:
;2763:			NavAid(client);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 NavAid
CALLV
pop
line 2764
;2764:		}
line 2765
;2765:	}
ADDRGP4 $1286
JUMPV
LABELV $1285
line 2768
;2766:#endif
;2767:
;2768:	while ( client->timeResidual >= 1000 ) {
line 2769
;2769:		client->timeResidual -= 1000;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1000
SUBI4
ASGNI4
line 2771
;2770:
;2771:		if (!(ent->r.svFlags & SVF_BOT)) NavAid(client);	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $1288
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 NavAid
CALLV
pop
LABELV $1288
line 2775
;2772:
;2773:#if 1	// JUHOX: auto health regeneration
;2774:		if (
;2775:			!g_noHealthRegen.integer &&
ADDRGP4 g_noHealthRegen+12
INDIRI4
CNSTI4 0
NEI4 $1290
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
GEI4 $1290
ADDRLP4 0
INDIRP4
CNSTI4 352
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1290
ADDRLP4 12
INDIRP4
CNSTI4 744
ADDP4
INDIRI4
CNSTI4 2
GTI4 $1290
line 2780
;2776:			ent->health < client->ps.stats[STAT_MAX_HEALTH] &&
;2777:			!client->ps.powerups[PW_CHARGE] &&
;2778:			//client->ps.stats[STAT_STRENGTH] > 0
;2779:			ent->damage <= 2	// don't auto regenerate health if drowning
;2780:		) {
line 2781
;2781:			ent->health += 5;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 5
ADDI4
ASGNI4
line 2782
;2782:			if (ent->health > client->ps.stats[STAT_MAX_HEALTH]) {
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
LEI4 $1293
line 2783
;2783:				ent->health = client->ps.stats[STAT_MAX_HEALTH];
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
ASGNI4
line 2784
;2784:			}
LABELV $1293
line 2785
;2785:		}
LABELV $1290
line 2789
;2786:#endif
;2787:#if 1	// JUHOX: auto armor regeneration
;2788:		if (
;2789:			!g_noHealthRegen.integer &&
ADDRGP4 g_noHealthRegen+12
INDIRI4
CNSTI4 0
NEI4 $1295
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
GEI4 $1295
ADDRLP4 0
INDIRP4
CNSTI4 352
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1295
line 2792
;2790:			client->ps.stats[STAT_ARMOR] < client->ps.stats[STAT_MAX_HEALTH] &&
;2791:			!client->ps.powerups[PW_CHARGE]
;2792:		) {
line 2793
;2793:			client->ps.stats[STAT_ARMOR] += 5;
ADDRLP4 24
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 5
ADDI4
ASGNI4
line 2794
;2794:			if (client->ps.stats[STAT_ARMOR] > client->ps.stats[STAT_MAX_HEALTH]) {
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
LEI4 $1298
line 2795
;2795:				client->ps.stats[STAT_ARMOR] = client->ps.stats[STAT_MAX_HEALTH];
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
ASGNI4
line 2796
;2796:			}
LABELV $1298
line 2797
;2797:		}
LABELV $1295
line 2825
;2798:#endif
;2799:		// regenerate
;2800:#ifdef MISSIONPACK
;2801:		if( bg_itemlist[client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_GUARD ) {
;2802:			maxHealth = client->ps.stats[STAT_MAX_HEALTH] / 2;
;2803:		}
;2804:		else if ( client->ps.powerups[PW_REGEN] ) {
;2805:			maxHealth = client->ps.stats[STAT_MAX_HEALTH];
;2806:		}
;2807:		else {
;2808:			maxHealth = 0;
;2809:		}
;2810:		if( maxHealth ) {
;2811:			if ( ent->health < maxHealth ) {
;2812:				ent->health += 15;
;2813:				if ( ent->health > maxHealth * 1.1 ) {
;2814:					ent->health = maxHealth * 1.1;
;2815:				}
;2816:				G_AddEvent( ent, EV_POWERUP_REGEN, 0 );
;2817:			} else if ( ent->health < maxHealth * 2) {
;2818:				ent->health += 5;
;2819:				if ( ent->health > maxHealth * 2 ) {
;2820:					ent->health = maxHealth * 2;
;2821:				}
;2822:				G_AddEvent( ent, EV_POWERUP_REGEN, 0 );
;2823:			}
;2824:#else
;2825:		if ( client->ps.powerups[PW_REGEN] ) {
ADDRLP4 0
INDIRP4
CNSTI4 332
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1300
line 2826
;2826:			if ( ent->health < client->ps.stats[STAT_MAX_HEALTH]) {
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
GEI4 $1302
line 2827
;2827:				ent->health += 15;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 15
ADDI4
ASGNI4
line 2828
;2828:				if ( ent->health > client->ps.stats[STAT_MAX_HEALTH] * 1.1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1066192077
MULF4
LEF4 $1304
line 2829
;2829:					ent->health = client->ps.stats[STAT_MAX_HEALTH] * 1.1;
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1066192077
MULF4
CVFI4 4
ASGNI4
line 2830
;2830:				}
LABELV $1304
line 2831
;2831:				G_AddEvent( ent, EV_POWERUP_REGEN, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 64
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 2832
;2832:			} else if ( ent->health < client->ps.stats[STAT_MAX_HEALTH] * 2) {
ADDRGP4 $1303
JUMPV
LABELV $1302
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 1
LSHI4
GEI4 $1306
line 2833
;2833:				ent->health += 5;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 5
ADDI4
ASGNI4
line 2834
;2834:				if ( ent->health > client->ps.stats[STAT_MAX_HEALTH] * 2 ) {
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 1
LSHI4
LEI4 $1308
line 2835
;2835:					ent->health = client->ps.stats[STAT_MAX_HEALTH] * 2;
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
line 2836
;2836:				}
LABELV $1308
line 2837
;2837:				G_AddEvent( ent, EV_POWERUP_REGEN, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 64
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 2838
;2838:			}
LABELV $1306
LABELV $1303
line 2841
;2839:			// JUHOX: also regenerate strength
;2840:#if 1
;2841:			client->ps.stats[STAT_STRENGTH] += 0.05 * MAX_STRENGTH_VALUE;
ADDRLP4 24
ADDRLP4 0
INDIRP4
CNSTI4 212
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CVIF4 4
CNSTF4 1147207680
ADDF4
CVFI4 4
ASGNI4
line 2842
;2842:			if (client->ps.stats[STAT_STRENGTH] > MAX_STRENGTH_VALUE) {
ADDRLP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1183621120
LEF4 $1301
line 2843
;2843:				client->ps.stats[STAT_STRENGTH] = MAX_STRENGTH_VALUE;
ADDRLP4 0
INDIRP4
CNSTI4 212
ADDP4
CNSTI4 18000
ASGNI4
line 2844
;2844:			}
line 2847
;2845:#endif
;2846:#endif
;2847:		} else {
ADDRGP4 $1301
JUMPV
LABELV $1300
line 2849
;2848:			// count down health when over max
;2849:			if ( ent->health > client->ps.stats[STAT_MAX_HEALTH] ) {
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
LEI4 $1312
line 2850
;2850:				ent->health--;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2851
;2851:			}
LABELV $1312
line 2852
;2852:		}
LABELV $1301
line 2855
;2853:
;2854:		// count down armor when over max
;2855:		if ( client->ps.stats[STAT_ARMOR] > client->ps.stats[STAT_MAX_HEALTH] ) {
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
LEI4 $1314
line 2856
;2856:			client->ps.stats[STAT_ARMOR]--;
ADDRLP4 28
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2857
;2857:		}
LABELV $1314
line 2858
;2858:	}
LABELV $1286
line 2768
ADDRLP4 0
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 1000
GEI4 $1285
line 2897
;2859:#ifdef MISSIONPACK
;2860:	if( bg_itemlist[client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_AMMOREGEN ) {
;2861:		int w, max, inc, t, i;
;2862:    int weapList[]={WP_MACHINEGUN,WP_SHOTGUN,WP_GRENADE_LAUNCHER,WP_ROCKET_LAUNCHER,WP_LIGHTNING,WP_RAILGUN,WP_PLASMAGUN,WP_BFG,WP_NAILGUN,WP_PROX_LAUNCHER,WP_CHAINGUN};
;2863:    int weapCount = sizeof(weapList) / sizeof(int);
;2864:		//
;2865:    for (i = 0; i < weapCount; i++) {
;2866:		  w = weapList[i];
;2867:
;2868:		  switch(w) {
;2869:			  case WP_MACHINEGUN: max = 50; inc = 4; t = 1000; break;
;2870:			  case WP_SHOTGUN: max = 10; inc = 1; t = 1500; break;
;2871:			  case WP_GRENADE_LAUNCHER: max = 10; inc = 1; t = 2000; break;
;2872:			  case WP_ROCKET_LAUNCHER: max = 10; inc = 1; t = 1750; break;
;2873:			  case WP_LIGHTNING: max = 50; inc = 5; t = 1500; break;
;2874:			  case WP_RAILGUN: max = 10; inc = 1; t = 1750; break;
;2875:			  case WP_PLASMAGUN: max = 50; inc = 5; t = 1500; break;
;2876:			  case WP_BFG: max = 10; inc = 1; t = 4000; break;
;2877:			  case WP_NAILGUN: max = 10; inc = 1; t = 1250; break;
;2878:			  case WP_PROX_LAUNCHER: max = 5; inc = 1; t = 2000; break;
;2879:			  case WP_CHAINGUN: max = 100; inc = 5; t = 1000; break;
;2880:			  default: max = 0; inc = 0; t = 1000; break;
;2881:		  }
;2882:		  client->ammoTimes[w] += msec;
;2883:		  if ( client->ps.ammo[w] >= max ) {
;2884:			  client->ammoTimes[w] = 0;
;2885:		  }
;2886:		  if ( client->ammoTimes[w] >= t ) {
;2887:			  while ( client->ammoTimes[w] >= t )
;2888:				  client->ammoTimes[w] -= t;
;2889:			  client->ps.ammo[w] += inc;
;2890:			  if ( client->ps.ammo[w] > max ) {
;2891:				  client->ps.ammo[w] = max;
;2892:			  }
;2893:		  }
;2894:    }
;2895:	}
;2896:#endif
;2897:}
LABELV $1278
endproc ClientTimerActions 36 12
export TotalChargeDamage
proc TotalChargeDamage 8 0
line 2904
;2898:
;2899:/*
;2900:====================
;2901:JUHOX: TotalChargeDamage
;2902:====================
;2903:*/
;2904:float TotalChargeDamage(float time) {
line 2905
;2905:	if (time <= 0) return 0;
ADDRFP4 0
INDIRF4
CNSTF4 0
GTF4 $1317
CNSTF4 0
RETF4
ADDRGP4 $1316
JUMPV
LABELV $1317
line 2907
;2906:	if (
;2907:		g_lightningDamageLimit.value <= 0 ||
ADDRGP4 g_lightningDamageLimit+8
INDIRF4
CNSTF4 0
LEF4 $1323
ADDRFP4 0
INDIRF4
CNSTF4 1065353216
MULF4
ADDRGP4 g_lightningDamageLimit+8
INDIRF4
GTF4 $1319
LABELV $1323
line 2909
;2908:		CHARGE_DAMAGE_PER_SECOND * time <= g_lightningDamageLimit.value
;2909:	) {
line 2910
;2910:		return CHARGE_DAMAGE_PER_SECOND * 0.5 * Square(time);
ADDRLP4 0
ADDRFP4 0
INDIRF4
ASGNF4
ADDRLP4 0
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
CNSTF4 1056964608
MULF4
RETF4
ADDRGP4 $1316
JUMPV
LABELV $1319
line 2912
;2911:	}
;2912:	else {
line 2915
;2913:		float t0;
;2914:
;2915:		t0 = g_lightningDamageLimit.value / CHARGE_DAMAGE_PER_SECOND;
ADDRLP4 0
ADDRGP4 g_lightningDamageLimit+8
INDIRF4
ASGNF4
line 2916
;2916:		return CHARGE_DAMAGE_PER_SECOND * 0.5 * Square(t0) + g_lightningDamageLimit.value * (time - t0);
ADDRLP4 4
ADDRLP4 0
INDIRF4
ASGNF4
ADDRLP4 4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
CNSTF4 1056964608
MULF4
ADDRGP4 g_lightningDamageLimit+8
INDIRF4
ADDRFP4 0
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
MULF4
ADDF4
RETF4
LABELV $1316
endproc TotalChargeDamage 8 0
proc CauseChargeDamage 36 32
line 2925
;2917:	}
;2918:}
;2919:
;2920:/*
;2921:====================
;2922:JUHOX: CauseChargeDamage
;2923:====================
;2924:*/
;2925:static void CauseChargeDamage(gentity_t* ent) {
line 2928
;2926:	gclient_t* client;
;2927:
;2928:	client = ent->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 2929
;2929:	if (!client) return;
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1327
ADDRGP4 $1326
JUMPV
LABELV $1327
line 2931
;2930:
;2931:	if (client->lastChargeTime) {
ADDRLP4 0
INDIRP4
CNSTI4 976
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1329
line 2936
;2932:		int n;
;2933:		gentity_t* attacker;
;2934:		float damage;
;2935:
;2936:		n = ent->chargeInflictor;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 816
ADDP4
INDIRI4
ASGNI4
line 2937
;2937:		if (n < 0 || n >= MAX_GENTITIES) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $1333
ADDRLP4 4
INDIRI4
CNSTI4 1024
LTI4 $1331
LABELV $1333
line 2938
;2938:			G_Printf("WARNING: invalid charge inflictor: %d\n", n);
ADDRGP4 $1334
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 2939
;2939:			return;
ADDRGP4 $1326
JUMPV
LABELV $1331
line 2941
;2940:		}
;2941:		attacker = &g_entities[n];
ADDRLP4 8
ADDRLP4 4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 2942
;2942:		if (!attacker->client) {
ADDRLP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1335
line 2943
;2943:			G_Printf("WARNING: charge inflictor is not a client: %d\n", n);
ADDRGP4 $1337
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 2944
;2944:			return;
ADDRGP4 $1326
JUMPV
LABELV $1335
line 2947
;2945:		}
;2946:
;2947:		damage = client->chargeDamageResidual + TotalChargeDamage(client->lastChargeAmount);
ADDRLP4 0
INDIRP4
CNSTI4 968
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
ADDRGP4 TotalChargeDamage
CALLF4
ASGNF4
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 972
ADDP4
INDIRF4
ADDRLP4 24
INDIRF4
ADDF4
ASGNF4
line 2948
;2948:		if (ent->waterlevel <= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 792
ADDP4
INDIRI4
CNSTI4 0
GTI4 $1338
line 2951
;2949:			float time;
;2950:
;2951:			time = (level.time - client->lastChargeTime) / 1000.0;
ADDRLP4 28
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 976
ADDP4
INDIRI4
SUBI4
CVIF4 4
CNSTF4 981668463
MULF4
ASGNF4
line 2952
;2952:			damage -= TotalChargeDamage(client->lastChargeAmount - time);
ADDRLP4 0
INDIRP4
CNSTI4 968
ADDP4
INDIRF4
ADDRLP4 28
INDIRF4
SUBF4
ARGF4
ADDRLP4 32
ADDRGP4 TotalChargeDamage
CALLF4
ASGNF4
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 32
INDIRF4
SUBF4
ASGNF4
line 2953
;2953:		}
ADDRGP4 $1339
JUMPV
LABELV $1338
line 2954
;2954:		else {
line 2955
;2955:			client->ps.powerups[PW_CHARGE] -= (int) (1000.0 * client->lastChargeAmount);
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 352
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 968
ADDP4
INDIRF4
CNSTF4 1148846080
MULF4
CVFI4 4
SUBI4
ASGNI4
line 2956
;2956:		}
LABELV $1339
line 2958
;2957:
;2958:		n = (int) damage;
ADDRLP4 4
ADDRLP4 12
INDIRF4
CVFI4 4
ASGNI4
line 2959
;2959:		client->chargeDamageResidual = damage - n;
ADDRLP4 0
INDIRP4
CNSTI4 972
ADDP4
ADDRLP4 12
INDIRF4
ADDRLP4 4
INDIRI4
CVIF4 4
SUBF4
ASGNF4
ADDRGP4 $1342
JUMPV
LABELV $1341
line 2961
;2960:
;2961:		while (n > 0) {	// so slow and fast servers do the damage the same way
line 2964
;2962:			int d;
;2963:
;2964:			if (client->ps.stats[STAT_ARMOR] > 0 && ent->waterlevel <= 0) {
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1344
ADDRFP4 0
INDIRP4
CNSTI4 792
ADDP4
INDIRI4
CNSTI4 0
GTI4 $1344
line 2965
;2965:				d = client->ps.stats[STAT_ARMOR];
ADDRLP4 28
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
line 2966
;2966:				if (d >= n) d = n - 1;
ADDRLP4 28
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $1346
ADDRLP4 28
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $1346
line 2967
;2967:				client->ps.stats[STAT_ARMOR] -= d;
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
ADDRLP4 28
INDIRI4
SUBI4
ASGNI4
line 2968
;2968:				n -= d;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 28
INDIRI4
SUBI4
ASGNI4
line 2970
;2969:
;2970:				d = 1;
ADDRLP4 28
CNSTI4 1
ASGNI4
line 2971
;2971:			}
ADDRGP4 $1345
JUMPV
LABELV $1344
line 2972
;2972:			else {
line 2973
;2973:				d = n;
ADDRLP4 28
ADDRLP4 4
INDIRI4
ASGNI4
line 2974
;2974:			}
LABELV $1345
line 2975
;2975:			G_Damage(ent, attacker, attacker, NULL, NULL, d, 0, MOD_CHARGE);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 28
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 2976
;2976:			n -= d;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 28
INDIRI4
SUBI4
ASGNI4
line 2977
;2977:		}
LABELV $1342
line 2961
ADDRLP4 4
INDIRI4
CNSTI4 0
GTI4 $1341
line 2978
;2978:	}
LABELV $1329
line 2980
;2979:
;2980:	if (client->ps.powerups[PW_CHARGE] > level.time) {
ADDRLP4 0
INDIRP4
CNSTI4 352
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $1348
line 2981
;2981:		client->lastChargeAmount = (client->ps.powerups[PW_CHARGE] - level.time) / 1000.0;
ADDRLP4 0
INDIRP4
CNSTI4 968
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 352
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
SUBI4
CVIF4 4
CNSTF4 981668463
MULF4
ASGNF4
line 2982
;2982:		client->lastChargeTime = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 976
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 2983
;2983:	}
ADDRGP4 $1349
JUMPV
LABELV $1348
line 2984
;2984:	else {
line 2985
;2985:		client->lastChargeAmount = 0.0;
ADDRLP4 0
INDIRP4
CNSTI4 968
ADDP4
CNSTF4 0
ASGNF4
line 2987
;2986:		//client->chargeDamageResidual = 0.0;
;2987:		client->lastChargeTime = 0;
ADDRLP4 0
INDIRP4
CNSTI4 976
ADDP4
CNSTI4 0
ASGNI4
line 2988
;2988:	}
LABELV $1349
line 2989
;2989:}
LABELV $1326
endproc CauseChargeDamage 36 32
export ClientIntermissionThink
proc ClientIntermissionThink 24 0
line 2997
;2990:
;2991:
;2992:/*
;2993:====================
;2994:ClientIntermissionThink
;2995:====================
;2996:*/
;2997:void ClientIntermissionThink( gclient_t *client ) {
line 2998
;2998:	client->ps.eFlags &= ~EF_TALK;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 -4097
BANDI4
ASGNI4
line 2999
;2999:	client->ps.eFlags &= ~EF_FIRING;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -257
BANDI4
ASGNI4
line 3002
;3000:
;3001:#if SPECIAL_VIEW_MODES	// JUHOX: switch to standard view mode during intermission
;3002:	client->viewMode = VIEW_standard;
ADDRFP4 0
INDIRP4
CNSTI4 5592
ADDP4
CNSTI4 0
ASGNI4
line 3003
;3003:	client->viewModeSwitchTime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 5596
ADDP4
CNSTI4 0
ASGNI4
line 3009
;3004:#endif
;3005:
;3006:	// the level will exit when everyone wants to or after timeouts
;3007:
;3008:#if 1	// JUHOX: don't accept ready signals during the first two seconds
;3009:	if (level.time < level.intermissiontime + 2000) {
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+9144
INDIRI4
CNSTI4 2000
ADDI4
GEI4 $1354
line 3010
;3010:		client->buttons = 0;
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 0
ASGNI4
line 3011
;3011:		return;
ADDRGP4 $1353
JUMPV
LABELV $1354
line 3016
;3012:	}
;3013:#endif
;3014:
;3015:	// swap and latch button actions
;3016:	client->oldbuttons = client->buttons;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 740
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
ASGNI4
line 3017
;3017:	client->buttons = client->pers.cmd.buttons;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 736
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 488
ADDP4
INDIRI4
ASGNI4
line 3018
;3018:	if ( client->buttons & ( BUTTON_ATTACK | BUTTON_USE_HOLDABLE ) & ( client->oldbuttons ^ client->buttons ) ) {
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 5
BANDI4
ADDRLP4 16
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
ADDRLP4 16
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
BXORI4
BANDI4
CNSTI4 0
EQI4 $1358
line 3023
;3019:		// this used to be an ^1 but once a player says ready, it should stick
;3020:#if !MEETING
;3021:		client->readyToExit = 1;
;3022:#else
;3023:		if (!level.meeting) {
ADDRGP4 level+24092
INDIRI4
CNSTI4 0
NEI4 $1360
line 3024
;3024:			client->readyToExit = 1;
ADDRFP4 0
INDIRP4
CNSTI4 724
ADDP4
CNSTI4 1
ASGNI4
line 3025
;3025:		}
ADDRGP4 $1361
JUMPV
LABELV $1360
line 3026
;3026:		else {
line 3027
;3027:			client->readyToExit ^= 1;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 724
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 3028
;3028:		}
LABELV $1361
line 3030
;3029:#endif
;3030:	}
LABELV $1358
line 3031
;3031:}
LABELV $1353
endproc ClientIntermissionThink 24 0
export ClientEvents
proc ClientEvents 76 32
line 3042
;3032:
;3033:
;3034:/*
;3035:================
;3036:ClientEvents
;3037:
;3038:Events will be passed on to the clients for presentation,
;3039:but any server game effects are handled here
;3040:================
;3041:*/
;3042:void ClientEvents( gentity_t *ent, int oldEventSequence ) {
line 3053
;3043:	int		i, j;
;3044:	int		event;
;3045:	gclient_t *client;
;3046:	int		damage;
;3047:	vec3_t	dir;
;3048:	vec3_t	origin, angles;
;3049://	qboolean	fired;
;3050:	gitem_t *item;
;3051:	gentity_t *drop;
;3052:
;3053:	client = ent->client;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 3055
;3054:
;3055:	if ( oldEventSequence < client->ps.eventSequence - MAX_PS_EVENTS ) {
ADDRFP4 4
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
CNSTI4 2
SUBI4
GEI4 $1364
line 3056
;3056:		oldEventSequence = client->ps.eventSequence - MAX_PS_EVENTS;
ADDRFP4 4
ADDRLP4 8
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 3057
;3057:	}
LABELV $1364
line 3058
;3058:	for ( i = oldEventSequence ; i < client->ps.eventSequence ; i++ ) {
ADDRLP4 0
ADDRFP4 4
INDIRI4
ASGNI4
ADDRGP4 $1369
JUMPV
LABELV $1366
line 3059
;3059:		event = client->ps.events[ i & (MAX_PS_EVENTS-1) ];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 112
ADDP4
ADDP4
INDIRI4
ASGNI4
line 3061
;3060:
;3061:		switch ( event ) {
ADDRLP4 4
INDIRI4
CNSTI4 11
EQI4 $1372
ADDRLP4 4
INDIRI4
CNSTI4 12
EQI4 $1372
ADDRLP4 4
INDIRI4
CNSTI4 11
LTI4 $1371
LABELV $1399
ADDRLP4 4
INDIRI4
CNSTI4 23
EQI4 $1383
ADDRLP4 4
INDIRI4
CNSTI4 25
EQI4 $1384
ADDRLP4 4
INDIRI4
CNSTI4 26
EQI4 $1398
ADDRGP4 $1371
JUMPV
LABELV $1372
line 3064
;3062:		case EV_FALL_MEDIUM:
;3063:		case EV_FALL_FAR:
;3064:			if ( ent->s.eType != ET_PLAYER ) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 1
EQI4 $1373
line 3065
;3065:				break;		// not in the player model
ADDRGP4 $1371
JUMPV
LABELV $1373
line 3067
;3066:			}
;3067:			if ( g_dmflags.integer & DF_NO_FALLING ) {
ADDRGP4 g_dmflags+12
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $1375
line 3068
;3068:				break;
ADDRGP4 $1371
JUMPV
LABELV $1375
line 3070
;3069:			}
;3070:			if ( event == EV_FALL_FAR ) {
ADDRLP4 4
INDIRI4
CNSTI4 12
NEI4 $1378
line 3071
;3071:				damage = 10;
ADDRLP4 36
CNSTI4 10
ASGNI4
line 3072
;3072:			} else {
ADDRGP4 $1379
JUMPV
LABELV $1378
line 3073
;3073:				damage = 5;
ADDRLP4 36
CNSTI4 5
ASGNI4
line 3074
;3074:			}
LABELV $1379
line 3075
;3075:			VectorSet (dir, 0, 0, 1);
ADDRLP4 16
CNSTF4 0
ASGNF4
ADDRLP4 16+4
CNSTF4 0
ASGNF4
ADDRLP4 16+8
CNSTF4 1065353216
ASGNF4
line 3076
;3076:			ent->pain_debounce_time = level.time + 200;	// no normal pain sound
ADDRFP4 0
INDIRP4
CNSTI4 724
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 200
ADDI4
ASGNI4
line 3077
;3077:			G_Damage (ent, NULL, NULL, NULL, NULL, damage, 0, MOD_FALLING);
ADDRFP4 0
INDIRP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 36
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 24
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 3078
;3078:			break;
ADDRGP4 $1371
JUMPV
LABELV $1383
line 3081
;3079:
;3080:		case EV_FIRE_WEAPON:
;3081:			FireWeapon( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 FireWeapon
CALLV
pop
line 3082
;3082:			break;
ADDRGP4 $1371
JUMPV
LABELV $1384
line 3086
;3083:
;3084:		case EV_USE_ITEM1:		// teleporter
;3085:			// drop flags in CTF
;3086:			item = NULL;
ADDRLP4 12
CNSTP4 0
ASGNP4
line 3087
;3087:			j = 0;
ADDRLP4 28
CNSTI4 0
ASGNI4
line 3089
;3088:
;3089:			if ( ent->client->ps.powerups[ PW_REDFLAG ] ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1385
line 3090
;3090:				item = BG_FindItemForPowerup( PW_REDFLAG );
CNSTI4 7
ARGI4
ADDRLP4 72
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 72
INDIRP4
ASGNP4
line 3091
;3091:				j = PW_REDFLAG;
ADDRLP4 28
CNSTI4 7
ASGNI4
line 3092
;3092:			} else if ( ent->client->ps.powerups[ PW_BLUEFLAG ] ) {
ADDRGP4 $1386
JUMPV
LABELV $1385
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1387
line 3093
;3093:				item = BG_FindItemForPowerup( PW_BLUEFLAG );
CNSTI4 8
ARGI4
ADDRLP4 72
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 72
INDIRP4
ASGNP4
line 3094
;3094:				j = PW_BLUEFLAG;
ADDRLP4 28
CNSTI4 8
ASGNI4
line 3095
;3095:			} else if ( ent->client->ps.powerups[ PW_NEUTRALFLAG ] ) {
ADDRGP4 $1388
JUMPV
LABELV $1387
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1389
line 3096
;3096:				item = BG_FindItemForPowerup( PW_NEUTRALFLAG );
CNSTI4 9
ARGI4
ADDRLP4 72
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 72
INDIRP4
ASGNP4
line 3097
;3097:				j = PW_NEUTRALFLAG;
ADDRLP4 28
CNSTI4 9
ASGNI4
line 3098
;3098:			}
LABELV $1389
LABELV $1388
LABELV $1386
line 3100
;3099:
;3100:			if ( item ) {
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1391
line 3101
;3101:				drop = Drop_Item( ent, item, 0 );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRLP4 72
ADDRGP4 Drop_Item
CALLP4
ASGNP4
ADDRLP4 32
ADDRLP4 72
INDIRP4
ASGNP4
line 3102
;3102:				if (!drop) break;	// JUHOX BUGFIX
ADDRLP4 32
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1393
ADDRGP4 $1371
JUMPV
LABELV $1393
line 3104
;3103:				// decide how many seconds it has left
;3104:				drop->count = ( ent->client->ps.powerups[ j ] - level.time ) / 1000;
ADDRLP4 32
INDIRP4
CNSTI4 764
ADDP4
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
SUBI4
CNSTI4 1000
DIVI4
ASGNI4
line 3105
;3105:				if ( drop->count < 1 ) {
ADDRLP4 32
INDIRP4
CNSTI4 764
ADDP4
INDIRI4
CNSTI4 1
GEI4 $1396
line 3106
;3106:					drop->count = 1;
ADDRLP4 32
INDIRP4
CNSTI4 764
ADDP4
CNSTI4 1
ASGNI4
line 3107
;3107:				}
LABELV $1396
line 3109
;3108:
;3109:				ent->client->ps.powerups[ j ] = 0;
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
CNSTI4 0
ASGNI4
line 3110
;3110:			}
LABELV $1391
line 3134
;3111:
;3112:#ifdef MISSIONPACK
;3113:			if ( g_gametype.integer == GT_HARVESTER ) {
;3114:				if ( ent->client->ps.generic1 > 0 ) {
;3115:					if ( ent->client->sess.sessionTeam == TEAM_RED ) {
;3116:						item = BG_FindItem( "Blue Cube" );
;3117:					} else {
;3118:						item = BG_FindItem( "Red Cube" );
;3119:					}
;3120:					if ( item ) {
;3121:						for ( j = 0; j < ent->client->ps.generic1; j++ ) {
;3122:							drop = Drop_Item( ent, item, 0 );
;3123:							if ( ent->client->sess.sessionTeam == TEAM_RED ) {
;3124:								drop->spawnflags = TEAM_BLUE;
;3125:							} else {
;3126:								drop->spawnflags = TEAM_RED;
;3127:							}
;3128:						}
;3129:					}
;3130:					ent->client->ps.generic1 = 0;
;3131:				}
;3132:			}
;3133:#endif
;3134:			SelectSpawnPoint( ent->client->ps.origin, origin, angles );
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 40
ARGP4
ADDRLP4 52
ARGP4
ADDRGP4 SelectSpawnPoint
CALLP4
pop
line 3135
;3135:			TeleportPlayer( ent, origin, angles );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 40
ARGP4
ADDRLP4 52
ARGP4
ADDRGP4 TeleportPlayer
CALLV
pop
line 3136
;3136:			break;
ADDRGP4 $1371
JUMPV
LABELV $1398
line 3139
;3137:
;3138:		case EV_USE_ITEM2:		// medkit
;3139:			ent->health = ent->client->ps.stats[STAT_MAX_HEALTH] + 25;
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 736
ADDP4
ADDRLP4 72
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 25
ADDI4
ASGNI4
line 3141
;3140:
;3141:			break;
line 3165
;3142:
;3143:#ifdef MISSIONPACK
;3144:		case EV_USE_ITEM3:		// kamikaze
;3145:			// make sure the invulnerability is off
;3146:			ent->client->invulnerabilityTime = 0;
;3147:			// start the kamikze
;3148:			G_StartKamikaze( ent );
;3149:			break;
;3150:
;3151:		case EV_USE_ITEM4:		// portal
;3152:			if( ent->client->portalID ) {
;3153:				DropPortalSource( ent );
;3154:			}
;3155:			else {
;3156:				DropPortalDestination( ent );
;3157:			}
;3158:			break;
;3159:		case EV_USE_ITEM5:		// invulnerability
;3160:			ent->client->invulnerabilityTime = level.time + 10000;
;3161:			break;
;3162:#endif
;3163:
;3164:		default:
;3165:			break;
LABELV $1371
line 3167
;3166:		}
;3167:	}
LABELV $1367
line 3058
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1369
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
LTI4 $1366
line 3169
;3168:
;3169:}
LABELV $1363
endproc ClientEvents 76 32
export ClientRefreshAmmo
proc ClientRefreshAmmo 36 0
line 3219
;3170:
;3171:#ifdef MISSIONPACK
;3172:/*
;3173:==============
;3174:StuckInOtherClient
;3175:==============
;3176:*/
;3177:static int StuckInOtherClient(gentity_t *ent) {
;3178:	int i;
;3179:	gentity_t	*ent2;
;3180:
;3181:	ent2 = &g_entities[0];
;3182:	for ( i = 0; i < MAX_CLIENTS; i++, ent2++ ) {
;3183:		if ( ent2 == ent ) {
;3184:			continue;
;3185:		}
;3186:		if ( !ent2->inuse ) {
;3187:			continue;
;3188:		}
;3189:		if ( !ent2->client ) {
;3190:			continue;
;3191:		}
;3192:		if ( ent2->health <= 0 ) {
;3193:			continue;
;3194:		}
;3195:		//
;3196:		if (ent2->r.absmin[0] > ent->r.absmax[0])
;3197:			continue;
;3198:		if (ent2->r.absmin[1] > ent->r.absmax[1])
;3199:			continue;
;3200:		if (ent2->r.absmin[2] > ent->r.absmax[2])
;3201:			continue;
;3202:		if (ent2->r.absmax[0] < ent->r.absmin[0])
;3203:			continue;
;3204:		if (ent2->r.absmax[1] < ent->r.absmin[1])
;3205:			continue;
;3206:		if (ent2->r.absmax[2] < ent->r.absmin[2])
;3207:			continue;
;3208:		return qtrue;
;3209:	}
;3210:	return qfalse;
;3211:}
;3212:#endif
;3213:
;3214:/*
;3215:================
;3216:JUHOX: ClientRefreshAmmo
;3217:================
;3218:*/
;3219:void ClientRefreshAmmo(gentity_t* ent, int msec) {
line 3223
;3220:	gclient_t* client;
;3221:	int i;
;3222:
;3223:	client = ent->client;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 3224
;3224:	if (client->tssSafetyMode) return;
ADDRLP4 4
INDIRP4
CNSTI4 768
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1401
ADDRGP4 $1400
JUMPV
LABELV $1401
line 3226
;3225:#if SPECIAL_VIEW_MODES
;3226:	if (client->viewMode == VIEW_scanner) return;
ADDRLP4 4
INDIRP4
CNSTI4 5592
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1403
ADDRGP4 $1400
JUMPV
LABELV $1403
line 3229
;3227:#endif
;3228:
;3229:	for (i = WP_NONE+1; i < WP_NUM_WEAPONS; i++) {
ADDRLP4 0
CNSTI4 1
ASGNI4
LABELV $1405
line 3235
;3230:		int maxAmmo;
;3231:		float amount;
;3232:		int pieces;
;3233:		float fraction;
;3234:
;3235:		if (!(client->ps.stats[STAT_WEAPONS] & (1 << i))) continue;
ADDRLP4 4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
NEI4 $1409
ADDRGP4 $1406
JUMPV
LABELV $1409
line 3236
;3236:		if (client->ps.ammo[i] < 0) continue;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
CNSTI4 0
GEI4 $1411
ADDRGP4 $1406
JUMPV
LABELV $1411
line 3237
;3237:		maxAmmo = weaponAmmoCharacteristics[i].maxAmmo;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 weaponAmmoCharacteristics
ADDP4
INDIRI4
ASGNI4
line 3239
;3238:#if MONSTER_MODE
;3239:		if (i == WP_MONSTER_LAUNCHER) maxAmmo = client->monstersAvailable;
ADDRLP4 0
INDIRI4
CNSTI4 11
NEI4 $1413
ADDRLP4 8
ADDRLP4 4
INDIRP4
CNSTI4 964
ADDP4
INDIRI4
ASGNI4
LABELV $1413
line 3241
;3240:#endif
;3241:		if (client->ps.ammo[i] >= maxAmmo) continue;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $1415
ADDRGP4 $1406
JUMPV
LABELV $1415
line 3242
;3242:		if (client->ps.weapon == i && client->ps.weaponstate >= WEAPON_FIRING) continue;
ADDRLP4 4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $1417
ADDRLP4 4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 3
LTI4 $1417
ADDRGP4 $1406
JUMPV
LABELV $1417
line 3244
;3243:
;3244:		amount = weaponAmmoCharacteristics[i].ammoRefresh * msec / 10000.0;
ADDRLP4 16
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 weaponAmmoCharacteristics+4
ADDP4
INDIRF4
ADDRFP4 4
INDIRI4
CVIF4 4
MULF4
CNSTF4 953267991
MULF4
ASGNF4
line 3245
;3245:		pieces = amount;
ADDRLP4 12
ADDRLP4 16
INDIRF4
CVFI4 4
ASGNI4
line 3246
;3246:		fraction = amount - pieces;
ADDRLP4 20
ADDRLP4 16
INDIRF4
ADDRLP4 12
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 3247
;3247:		client->ammoFraction[i] += fraction;
ADDRLP4 28
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 900
ADDP4
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 20
INDIRF4
ADDF4
ASGNF4
line 3248
;3248:		if (client->ammoFraction[i] >= 1.0) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 900
ADDP4
ADDP4
INDIRF4
CNSTF4 1065353216
LTF4 $1420
line 3249
;3249:			pieces += 1;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3250
;3250:			client->ammoFraction[i] -= 1.0;
ADDRLP4 32
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 900
ADDP4
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 3251
;3251:		}
LABELV $1420
line 3252
;3252:		client->ps.ammo[i] += pieces;
ADDRLP4 32
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
ADDI4
ASGNI4
line 3253
;3253:		if (client->ps.ammo[i] >= maxAmmo) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $1422
line 3254
;3254:			client->ps.ammo[i] = maxAmmo;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 3255
;3255:			client->ammoFraction[i] = 0.0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 900
ADDP4
ADDP4
CNSTF4 0
ASGNF4
line 3256
;3256:		}
LABELV $1422
line 3257
;3257:	}
LABELV $1406
line 3229
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 12
LTI4 $1405
line 3258
;3258:}
LABELV $1400
endproc ClientRefreshAmmo 36 0
export SetTargetPos
proc SetTargetPos 40 8
line 3265
;3259:
;3260:/*
;3261:================
;3262:JUHOX: SetTargetPos
;3263:================
;3264:*/
;3265:void SetTargetPos(gentity_t* ent) {
line 3271
;3266:	gentity_t* target;
;3267:	int targetNum;
;3268:	float pos;
;3269:	vec3_t dest;
;3270:	
;3271:	targetNum = ent->client->ps.stats[STAT_TARGET];
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ASGNI4
line 3275
;3272:	#if !MONSTER_MODE
;3273:		if (targetNum < 0 || targetNum >= MAX_CLIENTS) return;
;3274:	#else
;3275:		if (targetNum < 0 || targetNum >= ENTITYNUM_MAX_NORMAL) return;
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $1427
ADDRLP4 4
INDIRI4
CNSTI4 1022
LTI4 $1425
LABELV $1427
ADDRGP4 $1424
JUMPV
LABELV $1425
line 3277
;3276:	#endif
;3277:	target = &g_entities[targetNum];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 3278
;3278:	if (!target->inuse) return;
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1428
ADDRGP4 $1424
JUMPV
LABELV $1428
line 3280
;3279:
;3280:	switch (ent->s.weapon) {
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 1
EQI4 $1433
ADDRLP4 28
INDIRI4
CNSTI4 1
LTI4 $1430
LABELV $1435
ADDRLP4 28
INDIRI4
CNSTI4 6
EQI4 $1434
ADDRGP4 $1430
JUMPV
LABELV $1433
line 3282
;3281:	case WP_GAUNTLET:
;3282:		pos = GAUNTLET_TARGET_POS;
ADDRLP4 20
CNSTF4 1061158912
ASGNF4
line 3283
;3283:		break;
ADDRGP4 $1431
JUMPV
LABELV $1434
line 3285
;3284:	case WP_LIGHTNING:
;3285:		pos = LIGHTNING_TARGET_POS;
ADDRLP4 20
CNSTF4 1056964608
ASGNF4
line 3286
;3286:		break;
ADDRGP4 $1431
JUMPV
LABELV $1430
line 3289
;3287:	default:
;3288:		// should not happen
;3289:		pos = DEFAULT_TARGET_POS;
ADDRLP4 20
CNSTF4 1056964608
ASGNF4
line 3290
;3290:		break;
LABELV $1431
line 3293
;3291:	}
;3292:
;3293:	VectorCopy(target->s.pos.trBase, dest);
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 3294
;3294:	dest[2] += BG_PlayerTargetOffset(&target->s, pos);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 36
ADDRGP4 BG_PlayerTargetOffset
CALLF4
ASGNF4
ADDRLP4 8+8
ADDRLP4 8+8
INDIRF4
ADDRLP4 36
INDIRF4
ADDF4
ASGNF4
line 3295
;3295:	VectorCopy(dest, ent->s.origin2);
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 8
INDIRB
ASGNB 12
line 3296
;3296:}
LABELV $1424
endproc SetTargetPos 40 8
proc GetGauntletTarget 152 28
line 3303
;3297:
;3298:/*
;3299:================
;3300:JUHOX: GetGauntletTarget
;3301:================
;3302:*/
;3303:static void GetGauntletTarget(gentity_t* ent) {
line 3309
;3304:	trace_t tr;
;3305:	vec3_t forward, right, up, muzzle, end;
;3306:	gentity_t* target;
;3307:
;3308:	if (
;3309:		ent->client->ps.weapon != WP_GAUNTLET ||
ADDRLP4 120
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 120
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1440
ADDRLP4 120
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $1438
LABELV $1440
line 3311
;3310:		ent->client->ps.stats[STAT_HEALTH] <= 0
;3311:	) {
line 3312
;3312:		ent->client->ps.stats[STAT_TARGET] = -1;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 208
ADDP4
CNSTI4 -1
ASGNI4
line 3313
;3313:		return;
ADDRGP4 $1437
JUMPV
LABELV $1438
line 3317
;3314:	}
;3315:
;3316:	// set aiming directions
;3317:	AngleVectors(ent->client->ps.viewangles, forward, right, up);
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 96
ARGP4
ADDRLP4 108
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 3319
;3318:
;3319:	CalcMuzzlePoint(ent, forward, right, up, muzzle);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 96
ARGP4
ADDRLP4 108
ARGP4
ADDRLP4 16
ARGP4
ADDRGP4 CalcMuzzlePoint
CALLV
pop
line 3321
;3320:
;3321:	VectorMA(muzzle, 10000, forward, end);
ADDRLP4 84
ADDRLP4 16
INDIRF4
ADDRLP4 4
INDIRF4
CNSTF4 1176256512
MULF4
ADDF4
ASGNF4
ADDRLP4 84+4
ADDRLP4 16+4
INDIRF4
ADDRLP4 4+4
INDIRF4
CNSTF4 1176256512
MULF4
ADDF4
ASGNF4
ADDRLP4 84+8
ADDRLP4 16+8
INDIRF4
ADDRLP4 4+8
INDIRF4
CNSTF4 1176256512
MULF4
ADDF4
ASGNF4
line 3323
;3322:
;3323:	trap_Trace(&tr, muzzle, NULL, NULL, end, ent->s.number, MASK_SHOT);
ADDRLP4 28
ARGP4
ADDRLP4 16
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 84
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 3324
;3324:	if (tr.fraction >= 1) goto NoTarget;
ADDRLP4 28+8
INDIRF4
CNSTF4 1065353216
LTF4 $1447
ADDRGP4 $1450
JUMPV
LABELV $1447
line 3325
;3325:	if (tr.surfaceFlags & SURF_NOIMPACT) goto NoTarget;
ADDRLP4 28+44
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1451
ADDRGP4 $1450
JUMPV
LABELV $1451
line 3327
;3326:
;3327:	target = &g_entities[tr.entityNum];
ADDRLP4 0
ADDRLP4 28+52
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 3329
;3328:	if (
;3329:		(
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1463
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 128
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 128
INDIRI4
CNSTI4 0
NEI4 $1463
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 3
EQI4 $1463
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $1463
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 328
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1463
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1463
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1457
LABELV $1463
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1455
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1455
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 G_IsFriendlyMonster
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
NEI4 $1455
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 144
ADDRGP4 G_CanBeDamaged
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $1455
LABELV $1457
line 3346
;3330:			target->client &&
;3331:			!OnSameTeam(ent, target) &&
;3332:			target->client->sess.sessionTeam != TEAM_SPECTATOR &&
;3333:			target->client->ps.pm_type != PM_SPECTATOR &&
;3334:			!target->client->ps.powerups[PW_INVIS] &&
;3335:			target->client->ps.stats[STAT_HEALTH] > 0 &&
;3336:			target->client->ps.weapon != WP_GAUNTLET
;3337:		)
;3338:#if MONSTER_MODE	// accept monsters for gauntlet target
;3339:		|| (
;3340:			target->monster &&
;3341:			target->health > 0 &&
;3342:			!G_IsFriendlyMonster(ent, target) &&
;3343:			G_CanBeDamaged(target)
;3344:		)
;3345:#endif
;3346:	) {
line 3347
;3347:		ent->client->ps.stats[STAT_TARGET] = tr.entityNum;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 208
ADDP4
ADDRLP4 28+52
INDIRI4
ASGNI4
line 3348
;3348:		SetTargetPos(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 SetTargetPos
CALLV
pop
line 3349
;3349:		ent->client->looseTargetTime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 852
ADDP4
CNSTI4 0
ASGNI4
line 3350
;3350:		return;
ADDRGP4 $1437
JUMPV
LABELV $1455
LABELV $1450
line 3354
;3351:	}
;3352:
;3353:	NoTarget:
;3354:	if (ent->client->ps.stats[STAT_TARGET] < 0) return;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 0
GEI4 $1465
ADDRGP4 $1437
JUMPV
LABELV $1465
line 3355
;3355:	if (!ent->client->looseTargetTime) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 852
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1467
line 3356
;3356:		ent->client->looseTargetTime = level.time + 200;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 852
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 200
ADDI4
ASGNI4
line 3357
;3357:	}
ADDRGP4 $1468
JUMPV
LABELV $1467
line 3359
;3358:	else if (
;3359:		level.time > ent->client->looseTargetTime ||
ADDRLP4 148
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 148
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 852
ADDP4
INDIRI4
GTI4 $1474
ADDRLP4 148
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+736
ADDP4
INDIRI4
CNSTI4 0
GTI4 $1470
LABELV $1474
line 3361
;3360:		g_entities[ent->client->ps.stats[STAT_TARGET]].health <= 0
;3361:	) {
line 3362
;3362:		ent->client->ps.stats[STAT_TARGET] = -1;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 208
ADDP4
CNSTI4 -1
ASGNI4
line 3363
;3363:		ent->client->looseTargetTime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 852
ADDP4
CNSTI4 0
ASGNI4
line 3364
;3364:		return;
ADDRGP4 $1437
JUMPV
LABELV $1470
LABELV $1468
line 3366
;3365:	}
;3366:	SetTargetPos(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 SetTargetPos
CALLV
pop
line 3367
;3367:}
LABELV $1437
endproc GetGauntletTarget 152 28
proc PlayerCharge 4 0
line 3415
;3368:
;3369:/*
;3370:================
;3371:JUHOX DEBUG: SomeTests
;3372:================
;3373:*/
;3374:#if 0
;3375:#include "be_aas.h"	// for TFL_DEFAULT
;3376:static void SomeTests(gentity_t* ent) {
;3377:	trace_t tr;
;3378:	vec3_t forward, right, up, muzzle, end, mins, maxs;
;3379:	int startareanum, endareanum;
;3380:	float directDist;
;3381:	int walkDist;
;3382:	
;3383:	AngleVectors(ent->client->ps.viewangles, forward, right, up);
;3384:
;3385:	CalcMuzzlePoint(ent, forward, right, up, muzzle);
;3386:
;3387:	VectorMA(muzzle, 10000, forward, end);
;3388:
;3389:	VectorSet(mins, -25, -25, -25);
;3390:	VectorSet(maxs, 25, 25, 25);
;3391:
;3392:	trap_Trace(&tr, muzzle, mins, maxs, end, ent->s.number, MASK_SHOT);
;3393:	directDist = Distance(muzzle, tr.endpos);
;3394:
;3395:	VectorCopy(tr.endpos, end);
;3396:	//VectorMA(end, -25, forward, end);
;3397:	VectorCopy(end, muzzle);
;3398:	end[2] -= 10000;
;3399:	trap_Trace(&tr, muzzle, mins, maxs, end, ent->s.number, MASK_SHOT);
;3400:	//tr.endpos[2] += 25;
;3401:
;3402:	startareanum = trap_AAS_PointAreaNum(ent->client->ps.origin);
;3403:	endareanum = trap_AAS_PointAreaNum(tr.endpos);
;3404:	walkDist = trap_AAS_AreaTravelTimeToGoalArea(startareanum, ent->client->ps.origin, endareanum, TFL_DEFAULT | TFL_FLIGHT);
;3405:
;3406:	G_Printf("dd=%f, sa=%d, ea=%d, wd=%d\n", directDist, startareanum, endareanum, walkDist);
;3407:}
;3408:#endif
;3409:
;3410:/*
;3411:================
;3412:JUHOX: PlayerCharge
;3413:================
;3414:*/
;3415:static int PlayerCharge(const playerState_t* ps) {
line 3418
;3416:	int charge;
;3417:
;3418:	charge = ps->powerups[PW_CHARGE] - level.time;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 352
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
SUBI4
ASGNI4
line 3419
;3419:	if (charge < 0) charge = 0;
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $1477
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1477
line 3420
;3420:	return charge;
ADDRLP4 0
INDIRI4
RETI4
LABELV $1475
endproc PlayerCharge 4 0
export CheckPlayerDischarge
proc CheckPlayerDischarge 4288 28
line 3430
;3421:}
;3422:
;3423:/*
;3424:================
;3425:JUHOX: CheckPlayerDischarge
;3426:================
;3427:*/
;3428:#define PLAYERDISCHARGE_RADIUS_PER_SECOND 15.0
;3429:#define PLAYERDISCHARGE_SINGLE_TARGET 1
;3430:void CheckPlayerDischarge(gentity_t* ent) {
line 3451
;3431:	playerState_t* sourcePS;
;3432:	int i, numTargs;
;3433:	float radius, radiusSquared;
;3434:	int targNum[MAX_GENTITIES];
;3435:#if !PLAYERDISCHARGE_SINGLE_TARGET
;3436:	int numAffectedPlayers;
;3437:	playerState_t* affectedPlayers[MAX_CLIENTS+MAX_MONSTERS];
;3438:	int totalCharge;
;3439:#else
;3440:	playerState_t* affectedPlayer;
;3441:	int sourceCharge;
;3442:	int destinationCharge;
;3443:	int resultingCharge;
;3444:#endif
;3445:	vec3_t mins, maxs;
;3446:	int maxCharge;
;3447:
;3448:#if !MONSTER_MODE
;3449:	if (g_gametype.integer < GT_TEAM) return;
;3450:#else
;3451:	if (g_gametype.integer < GT_TEAM && !g_monsterLauncher.integer) return;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
GEI4 $1480
ADDRGP4 g_monsterLauncher+12
INDIRI4
CNSTI4 0
NEI4 $1480
ADDRGP4 $1479
JUMPV
LABELV $1480
line 3453
;3452:#endif
;3453:	if (ent->nextDischargeCheckTime > level.time) return;
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $1484
ADDRGP4 $1479
JUMPV
LABELV $1484
line 3454
;3454:	ent->nextDischargeCheckTime = level.time + 100 + rand() % 50;
ADDRLP4 4160
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ADDRLP4 4160
INDIRI4
CNSTI4 50
MODI4
ADDI4
ASGNI4
line 3457
;3455:
;3456:#if MONSTER_MODE
;3457:	if (ent->monster && level.endPhase >= 3) return;
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1488
ADDRGP4 level+23012
INDIRI4
CNSTI4 3
LTI4 $1488
ADDRGP4 $1479
JUMPV
LABELV $1488
line 3460
;3458:#endif
;3459:
;3460:	sourcePS = G_GetEntityPlayerState(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4164
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4164
INDIRP4
ASGNP4
line 3461
;3461:	if (!sourcePS) return;
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1491
ADDRGP4 $1479
JUMPV
LABELV $1491
line 3462
;3462:	if (!sourcePS->powerups[PW_CHARGE]) return;
ADDRLP4 0
INDIRP4
CNSTI4 352
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1493
ADDRGP4 $1479
JUMPV
LABELV $1493
line 3464
;3463:	
;3464:	radius = PLAYERDISCHARGE_RADIUS_PER_SECOND * (sourcePS->powerups[PW_CHARGE] - level.time) / 1000.0;
ADDRLP4 4148
ADDRLP4 0
INDIRP4
CNSTI4 352
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
SUBI4
CVIF4 4
CNSTF4 1014350479
MULF4
ASGNF4
line 3465
;3465:	if (radius > 0.5 * LIGHTNING_RANGE) radius = 0.5 * LIGHTNING_RANGE;
ADDRLP4 4148
INDIRF4
CNSTF4 1132068864
LEF4 $1496
ADDRLP4 4148
CNSTF4 1132068864
ASGNF4
LABELV $1496
line 3466
;3466:	radiusSquared = Square(radius);
ADDRLP4 8
ADDRLP4 4148
INDIRF4
ADDRLP4 4148
INDIRF4
MULF4
ASGNF4
line 3467
;3467:	maxs[0] = maxs[1] = maxs[2] = radius;
ADDRLP4 4136+8
ADDRLP4 4148
INDIRF4
ASGNF4
ADDRLP4 4136+4
ADDRLP4 4148
INDIRF4
ASGNF4
ADDRLP4 4136
ADDRLP4 4148
INDIRF4
ASGNF4
line 3468
;3468:	mins[0] = mins[1] = mins[2] = -radius;
ADDRLP4 4176
ADDRLP4 4148
INDIRF4
NEGF4
ASGNF4
ADDRLP4 4124+8
ADDRLP4 4176
INDIRF4
ASGNF4
ADDRLP4 4124+4
ADDRLP4 4176
INDIRF4
ASGNF4
ADDRLP4 4124
ADDRLP4 4176
INDIRF4
ASGNF4
line 3469
;3469:	VectorAdd(sourcePS->origin, mins, mins);
ADDRLP4 4124
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 4124
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4124+4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 4124+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4124+8
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 4124+8
INDIRF4
ADDF4
ASGNF4
line 3470
;3470:	VectorAdd(sourcePS->origin, maxs, maxs);
ADDRLP4 4136
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 4136
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4136+4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 4136+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4136+8
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 4136+8
INDIRF4
ADDF4
ASGNF4
line 3471
;3471:	numTargs = trap_EntitiesInBox(mins, maxs, targNum, MAX_GENTITIES);
ADDRLP4 4124
ARGP4
ADDRLP4 4136
ARGP4
ADDRLP4 24
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 4188
ADDRGP4 trap_EntitiesInBox
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 4188
INDIRI4
ASGNI4
line 3478
;3472:	
;3473:#if !PLAYERDISCHARGE_SINGLE_TARGET
;3474:	maxCharge = PlayerCharge(sourcePS) - 1000;
;3475:	totalCharge = 0;
;3476:	numAffectedPlayers = 0;
;3477:#else
;3478:	sourceCharge = PlayerCharge(sourcePS);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4192
ADDRGP4 PlayerCharge
CALLI4
ASGNI4
ADDRLP4 4152
ADDRLP4 4192
INDIRI4
ASGNI4
line 3479
;3479:	maxCharge = sourceCharge - 1000;
ADDRLP4 4120
ADDRLP4 4152
INDIRI4
CNSTI4 1000
SUBI4
ASGNI4
line 3480
;3480:	destinationCharge = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 3481
;3481:	affectedPlayer = NULL;
ADDRLP4 12
CNSTP4 0
ASGNP4
line 3483
;3482:#endif
;3483:	for (i = 0; i < numTargs; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $1513
JUMPV
LABELV $1510
line 3492
;3484:		gentity_t* targ;
;3485:		playerState_t* ps;
;3486:		int charge;
;3487:		trace_t trace;
;3488:#if PLAYERDISCHARGE_SINGLE_TARGET
;3489:		float distanceSquared;
;3490:#endif
;3491:
;3492:		targ = &g_entities[targNum[i]];
ADDRLP4 4200
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 24
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 3493
;3493:		ps = G_GetEntityPlayerState(targ);
ADDRLP4 4200
INDIRP4
ARGP4
ADDRLP4 4268
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 4196
ADDRLP4 4268
INDIRP4
ASGNP4
line 3494
;3494:		if (!ps) continue;
ADDRLP4 4196
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1514
ADDRGP4 $1511
JUMPV
LABELV $1514
line 3495
;3495:		if (ps->persistant[PERS_TEAM] != sourcePS->persistant[PERS_TEAM]) continue;
ADDRLP4 4196
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
EQI4 $1516
ADDRGP4 $1511
JUMPV
LABELV $1516
line 3496
;3496:		if (ps->pm_type == PM_SPECTATOR) continue;
ADDRLP4 4196
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1518
ADDRGP4 $1511
JUMPV
LABELV $1518
line 3498
;3497:#if MONSTER_MODE
;3498:		if (!G_CanBeDamaged(targ)) continue;
ADDRLP4 4200
INDIRP4
ARGP4
ADDRLP4 4272
ADDRGP4 G_CanBeDamaged
CALLI4
ASGNI4
ADDRLP4 4272
INDIRI4
CNSTI4 0
NEI4 $1520
ADDRGP4 $1511
JUMPV
LABELV $1520
line 3499
;3499:		if (ps->persistant[PERS_TEAM] == TEAM_FREE && ps != sourcePS) {
ADDRLP4 4196
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1522
ADDRLP4 4196
INDIRP4
CVPU4 4
ADDRLP4 0
INDIRP4
CVPU4 4
EQU4 $1522
line 3500
;3500:			if (!ent->monster && !targ->monster) continue;
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1524
ADDRLP4 4200
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1524
ADDRGP4 $1511
JUMPV
LABELV $1524
line 3501
;3501:			if (!G_IsFriendlyMonster(ent, targ)) continue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4200
INDIRP4
ARGP4
ADDRLP4 4280
ADDRGP4 G_IsFriendlyMonster
CALLI4
ASGNI4
ADDRLP4 4280
INDIRI4
CNSTI4 0
NEI4 $1526
ADDRGP4 $1511
JUMPV
LABELV $1526
line 3502
;3502:		}
LABELV $1522
line 3504
;3503:#endif
;3504:		if (ps->stats[STAT_HEALTH] <= 0) continue;
ADDRLP4 4196
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $1528
ADDRGP4 $1511
JUMPV
LABELV $1528
line 3519
;3505:#if !PLAYERDISCHARGE_SINGLE_TARGET
;3506:		charge = PlayerCharge(ps);
;3507:		if (ps != sourcePS) {
;3508:			if (charge > maxCharge) continue;
;3509:			if (
;3510:				DistanceSquared(sourcePS->origin, ps->origin) > radiusSquared
;3511:			) continue;
;3512:			trap_Trace(&trace, sourcePS->origin, NULL, NULL, ps->origin, ENTITYNUM_NONE, CONTENTS_SOLID);
;3513:			if (trace.fraction < 1) continue;
;3514:		}
;3515:
;3516:		affectedPlayers[numAffectedPlayers++] = ps;
;3517:		totalCharge += charge;
;3518:#else
;3519:		if (ps == sourcePS) continue;
ADDRLP4 4196
INDIRP4
CVPU4 4
ADDRLP4 0
INDIRP4
CVPU4 4
NEU4 $1530
ADDRGP4 $1511
JUMPV
LABELV $1530
line 3520
;3520:		charge = PlayerCharge(ps);
ADDRLP4 4196
INDIRP4
ARGP4
ADDRLP4 4280
ADDRGP4 PlayerCharge
CALLI4
ASGNI4
ADDRLP4 4204
ADDRLP4 4280
INDIRI4
ASGNI4
line 3521
;3521:		if (charge > maxCharge) continue;
ADDRLP4 4204
INDIRI4
ADDRLP4 4120
INDIRI4
LEI4 $1532
ADDRGP4 $1511
JUMPV
LABELV $1532
line 3522
;3522:		distanceSquared = DistanceSquared(sourcePS->origin, ps->origin);
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 4196
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 4284
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 4208
ADDRLP4 4284
INDIRF4
ASGNF4
line 3523
;3523:		if (distanceSquared > radiusSquared) continue;
ADDRLP4 4208
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $1534
ADDRGP4 $1511
JUMPV
LABELV $1534
line 3525
;3524:
;3525:		trap_Trace(&trace, sourcePS->origin, NULL, NULL, ps->origin, ENTITYNUM_NONE, CONTENTS_SOLID);
ADDRLP4 4212
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 4196
INDIRP4
CNSTI4 20
ADDP4
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 3526
;3526:		if (trace.fraction < 1) continue;
ADDRLP4 4212+8
INDIRF4
CNSTF4 1065353216
GEF4 $1536
ADDRGP4 $1511
JUMPV
LABELV $1536
line 3528
;3527:
;3528:		affectedPlayer = ps;
ADDRLP4 12
ADDRLP4 4196
INDIRP4
ASGNP4
line 3529
;3529:		radiusSquared = distanceSquared;
ADDRLP4 8
ADDRLP4 4208
INDIRF4
ASGNF4
line 3530
;3530:		destinationCharge = charge;
ADDRLP4 16
ADDRLP4 4204
INDIRI4
ASGNI4
line 3532
;3531:#endif
;3532:	}
LABELV $1511
line 3483
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1513
ADDRLP4 4
INDIRI4
ADDRLP4 20
INDIRI4
LTI4 $1510
line 3553
;3533:
;3534:#if !PLAYERDISCHARGE_SINGLE_TARGET
;3535:	if (numAffectedPlayers < 2) return;
;3536:
;3537:	totalCharge /= numAffectedPlayers;
;3538:	totalCharge += level.time;
;3539:	for (i = 0; i < numAffectedPlayers; i++) {
;3540:		gentity_t* flash;
;3541:
;3542:		flash = G_TempEntity(affectedPlayers[i]->origin, EV_DISCHARGE_FLASH);
;3543:		if (flash) {
;3544:			flash->s.otherEntityNum = ent->s.number;
;3545:			flash->s.otherEntityNum2 = affectedPlayers[i]->clientNum;
;3546:		}
;3547:
;3548:		affectedPlayers[i]->powerups[PW_CHARGE] = totalCharge;
;3549:		//g_entities[affectedPlayers[i]->clientNum].s.time2 = totalCharge;	// NOTE: time2 was unused before
;3550:		g_entities[affectedPlayers[i]->clientNum].chargeInflictor = ent->chargeInflictor;
;3551:	}
;3552:#else
;3553:	if (!affectedPlayer) return;
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1539
ADDRGP4 $1479
JUMPV
LABELV $1539
line 3555
;3554:
;3555:	resultingCharge = (sourceCharge + destinationCharge) / 2 + level.time;
ADDRLP4 4156
ADDRLP4 4152
INDIRI4
ADDRLP4 16
INDIRI4
ADDI4
CNSTI4 2
DIVI4
ADDRGP4 level+32
INDIRI4
ADDI4
ASGNI4
line 3557
;3556:	
;3557:	sourcePS->powerups[PW_CHARGE] = resultingCharge;
ADDRLP4 0
INDIRP4
CNSTI4 352
ADDP4
ADDRLP4 4156
INDIRI4
ASGNI4
line 3558
;3558:	affectedPlayer->powerups[PW_CHARGE] = resultingCharge;
ADDRLP4 12
INDIRP4
CNSTI4 352
ADDP4
ADDRLP4 4156
INDIRI4
ASGNI4
line 3559
;3559:	g_entities[affectedPlayer->clientNum].chargeInflictor = ent->chargeInflictor;
ADDRLP4 12
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+816
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 816
ADDP4
INDIRI4
ASGNI4
line 3561
;3560:
;3561:	{
line 3565
;3562:		vec3_t origin;
;3563:		gentity_t* flash;
;3564:
;3565:		VectorAdd(sourcePS->origin, affectedPlayer->origin, origin);
ADDRLP4 4196
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4196+4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4196+8
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDF4
ASGNF4
line 3566
;3566:		VectorScale(origin, 0.5, origin);
ADDRLP4 4196
ADDRLP4 4196
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 4196+4
ADDRLP4 4196+4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 4196+8
ADDRLP4 4196+8
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 3567
;3567:		flash = G_TempEntity(origin, EV_DISCHARGE_FLASH);
ADDRLP4 4196
ARGP4
CNSTI4 85
ARGI4
ADDRLP4 4220
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 4208
ADDRLP4 4220
INDIRP4
ASGNP4
line 3568
;3568:		if (flash) {
ADDRLP4 4208
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1549
line 3569
;3569:			flash->s.otherEntityNum = ent->s.number;
ADDRLP4 4208
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 3570
;3570:			flash->s.otherEntityNum2 = affectedPlayer->clientNum;
ADDRLP4 4208
INDIRP4
CNSTI4 144
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 3571
;3571:		}
LABELV $1549
line 3572
;3572:	}
line 3574
;3573:#endif
;3574:}
LABELV $1479
endproc CheckPlayerDischarge 4288 28
data
align 4
LABELV $1553
byte 4 3240099840
byte 4 3240099840
byte 4 3240099840
align 4
LABELV $1554
byte 4 1092616192
byte 4 1092616192
byte 4 1092616192
code
proc MoveRopeElement 276 28
line 3669
;3575:
;3576:
;3577:/*
;3578:==============
;3579:-JUHOX: SetSpectatorPos
;3580:
;3581:originally from CG_OffsetThirdPersonView() [cg_view.c]
;3582:==============
;3583:*/
;3584:#if 0
;3585:#define	FOCUS_DISTANCE	512	// should match the definition in cg_view.c
;3586:static void SetSpectatorPos(gentity_t* ent) {
;3587:	playerState_t* ps;
;3588:	vec3_t old_origin, old_angles;
;3589:	vec3_t new_origin, new_angles;
;3590:	vec3_t focusAngles;
;3591:	vec3_t focusPoint;
;3592:	vec3_t forward, right, up;
;3593:	float thirdPersonAngle, thirdPersonRange;
;3594:	trace_t trace;
;3595:	static const vec3_t mins = { -15, -15, -15 };
;3596:	static const vec3_t maxs = { 15, 15, 15 };
;3597:	float focusDist;
;3598:	float forwardScale, sideScale;
;3599:
;3600:	if (ent->r.svFlags & SVF_BOT) return;
;3601:
;3602:	ps = &ent->client->ps;
;3603:	VectorCopy(ps->origin, old_origin);
;3604:	VectorCopy(ps->viewangles, old_angles);
;3605:
;3606:	old_origin[2] += ps->viewheight;
;3607:
;3608:	VectorCopy(old_angles, focusAngles);
;3609:	focusAngles[YAW] = ps->stats[STAT_DEAD_YAW];
;3610:	old_angles[YAW] = ps->stats[STAT_DEAD_YAW];
;3611:
;3612:	if (focusAngles[PITCH] > 45) focusAngles[PITCH] = 45;
;3613:	AngleVectors(focusAngles, forward, NULL, NULL);
;3614:
;3615:	VectorMA(old_origin, FOCUS_DISTANCE, forward, focusPoint);
;3616:
;3617:	VectorCopy(old_origin, new_origin);
;3618:	new_origin[2] += 8;
;3619:
;3620:	old_angles[PITCH] *= 0.5;
;3621:	AngleVectors(old_angles, forward, right, up);
;3622:
;3623:	thirdPersonAngle = 0;
;3624:	thirdPersonRange = 40;
;3625:	forwardScale = cos(thirdPersonAngle / 180 * M_PI);
;3626:	sideScale = sin(thirdPersonAngle / 180 * M_PI);
;3627:	VectorMA(new_origin, -thirdPersonRange * forwardScale, forward, new_origin);
;3628:	VectorMA(new_origin, -thirdPersonRange * sideScale, right, new_origin);
;3629:
;3630:	trap_Trace(&trace, old_origin, mins, maxs, new_origin, ps->clientNum, MASK_PLAYERSOLID & ~CONTENTS_BODY);
;3631:
;3632:	if (trace.fraction != 1.0) {
;3633:		VectorCopy(trace.endpos, new_origin);
;3634:		new_origin[2] += (1.0 - trace.fraction) * 32;
;3635:
;3636:		trap_Trace(&trace, old_origin, mins, maxs, new_origin, ps->clientNum, MASK_PLAYERSOLID & ~CONTENTS_BODY);
;3637:		VectorCopy(trace.endpos, new_origin);
;3638:	}
;3639:
;3640:	VectorCopy(new_origin, old_origin);
;3641:
;3642:	VectorSubtract(focusPoint, old_origin, focusPoint);
;3643:	focusDist = sqrt(focusPoint[0] * focusPoint[0] + focusPoint[1] * focusPoint[1]);
;3644:	if (focusDist < 1) {
;3645:		focusDist = 1;	// should never happen
;3646:	}
;3647:	new_angles[PITCH] = -180 / M_PI * atan2(focusPoint[2], focusDist);
;3648:	new_angles[YAW] = old_angles[YAW] - thirdPersonAngle;
;3649:	new_angles[ROLL] = 0;
;3650:
;3651:	G_SetOrigin(ent, new_origin);
;3652:	VectorCopy(new_origin, ps->origin);
;3653:	SetClientViewAngle(ent, new_angles);
;3654:	ps->eFlags ^= EF_TELEPORT_BIT;
;3655:}
;3656:#endif
;3657:
;3658:/*
;3659:==============
;3660:JUHOX: MoveRopeElement
;3661:
;3662:derived from PM_SlideMove() [bg_slidemove.c]
;3663:returns qfalse if element is in solid
;3664:==============
;3665:*/
;3666:#if GRAPPLE_ROPE
;3667:#define	MAX_CLIP_PLANES	5
;3668:#include "bg_local.h"
;3669:static qboolean MoveRopeElement(const vec3_t start, const vec3_t idealpos, vec3_t realpos, qboolean* touch) {
line 3688
;3670:	vec3_t		velocity;
;3671:	static vec3_t ropeMins = {-ROPE_ELEMENT_SIZE, -ROPE_ELEMENT_SIZE, -ROPE_ELEMENT_SIZE};
;3672:	static vec3_t ropeMaxs = {ROPE_ELEMENT_SIZE, ROPE_ELEMENT_SIZE, ROPE_ELEMENT_SIZE};
;3673:
;3674:	int			bumpcount, numbumps;
;3675:	vec3_t		dir;
;3676:	float		d;
;3677:	int			numplanes;
;3678:	vec3_t		planes[MAX_CLIP_PLANES];
;3679:	vec3_t		clipVelocity;
;3680:	int			i, j, k;
;3681:	trace_t	trace;
;3682:	vec3_t		end;
;3683:	float		time_left;
;3684:	float		into;
;3685:
;3686:
;3687:
;3688:	VectorSubtract(idealpos, start, velocity);
ADDRLP4 200
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 204
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 104
ADDRLP4 200
INDIRP4
INDIRF4
ADDRLP4 204
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 104+4
ADDRLP4 200
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 204
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 104+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3689
;3689:	VectorCopy(start, realpos);
ADDRFP4 8
INDIRP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 3690
;3690:	*touch = qfalse;
ADDRFP4 12
INDIRP4
CNSTI4 0
ASGNI4
line 3692
;3691:	
;3692:	numbumps = MAX_CLIP_PLANES - 1;
ADDRLP4 196
CNSTI4 4
ASGNI4
line 3694
;3693:
;3694:	time_left = 1.0;	// seconds
ADDRLP4 176
CNSTF4 1065353216
ASGNF4
line 3696
;3695:
;3696:	numplanes = 0;
ADDRLP4 84
CNSTI4 0
ASGNI4
line 3699
;3697:
;3698:	// never turn against original velocity
;3699:	if (VectorNormalize2(velocity, planes[numplanes]) < 1) return qtrue;
ADDRLP4 104
ARGP4
ADDRLP4 84
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 16
ADDP4
ARGP4
ADDRLP4 208
ADDRGP4 VectorNormalize2
CALLF4
ASGNF4
ADDRLP4 208
INDIRF4
CNSTF4 1065353216
GEF4 $1557
CNSTI4 1
RETI4
ADDRGP4 $1552
JUMPV
LABELV $1557
line 3700
;3700:	numplanes++;
ADDRLP4 84
ADDRLP4 84
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3702
;3701:
;3702:	for (bumpcount=0; bumpcount < numbumps; bumpcount++) {
ADDRLP4 192
CNSTI4 0
ASGNI4
ADDRGP4 $1562
JUMPV
LABELV $1559
line 3705
;3703:
;3704:		// calculate position we are trying to move to
;3705:		VectorMA(realpos, time_left, velocity, end);
ADDRLP4 212
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 180
ADDRLP4 212
INDIRP4
INDIRF4
ADDRLP4 104
INDIRF4
ADDRLP4 176
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 180+4
ADDRLP4 212
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 104+4
INDIRF4
ADDRLP4 176
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 180+8
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 104+8
INDIRF4
ADDRLP4 176
INDIRF4
MULF4
ADDF4
ASGNF4
line 3708
;3706:
;3707:		// see if we can make it there
;3708:		trap_Trace(&trace, realpos, ropeMins, ropeMaxs, end, -1, CONTENTS_SOLID);
ADDRLP4 116
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 $1553
ARGP4
ADDRGP4 $1554
ARGP4
ADDRLP4 180
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 3710
;3709:
;3710:		if (trace.allsolid) {
ADDRLP4 116
INDIRI4
CNSTI4 0
EQI4 $1567
line 3711
;3711:			if (time_left >= 1.0) return qfalse;
ADDRLP4 176
INDIRF4
CNSTF4 1065353216
LTF4 $1569
CNSTI4 0
RETI4
ADDRGP4 $1552
JUMPV
LABELV $1569
line 3712
;3712:			SnapVectorTowards(realpos, start);
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 SnapVectorTowards
CALLV
pop
line 3713
;3713:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1552
JUMPV
LABELV $1567
line 3716
;3714:		}
;3715:
;3716:		if (trace.fraction > 0) {
ADDRLP4 116+8
INDIRF4
CNSTF4 0
LEF4 $1571
line 3718
;3717:			// actually covered some distance
;3718:			VectorCopy(trace.endpos, realpos);
ADDRFP4 8
INDIRP4
ADDRLP4 116+12
INDIRB
ASGNB 12
line 3719
;3719:		}
LABELV $1571
line 3723
;3720:
;3721:		//if (trace.fraction >= 1) return qtrue;
;3722:		// check if we can get back!
;3723:		if (trace.fraction >= 1) {
ADDRLP4 116+8
INDIRF4
CNSTF4 1065353216
LTF4 $1575
line 3726
;3724:			trace_t trace2;
;3725:
;3726:			trap_Trace(&trace2, end, ropeMins, ropeMaxs, realpos, -1, CONTENTS_SOLID);
ADDRLP4 220
ARGP4
ADDRLP4 180
ARGP4
ADDRGP4 $1553
ARGP4
ADDRGP4 $1554
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 3727
;3727:			if (trace2.fraction >= 1) return qtrue;
ADDRLP4 220+8
INDIRF4
CNSTF4 1065353216
LTF4 $1578
CNSTI4 1
RETI4
ADDRGP4 $1552
JUMPV
LABELV $1578
line 3728
;3728:			if (trace.allsolid) {
ADDRLP4 116
INDIRI4
CNSTI4 0
EQI4 $1581
line 3729
;3729:				if (time_left >= 1.0) return qfalse;
ADDRLP4 176
INDIRF4
CNSTF4 1065353216
LTF4 $1583
CNSTI4 0
RETI4
ADDRGP4 $1552
JUMPV
LABELV $1583
line 3730
;3730:				SnapVectorTowards(realpos, start);
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 SnapVectorTowards
CALLV
pop
line 3731
;3731:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1552
JUMPV
LABELV $1581
line 3733
;3732:			}
;3733:		}
LABELV $1575
line 3735
;3734:
;3735:		*touch = qtrue;
ADDRFP4 12
INDIRP4
CNSTI4 1
ASGNI4
line 3737
;3736:
;3737:		time_left -= time_left * trace.fraction;
ADDRLP4 176
ADDRLP4 176
INDIRF4
ADDRLP4 176
INDIRF4
ADDRLP4 116+8
INDIRF4
MULF4
SUBF4
ASGNF4
line 3739
;3738:
;3739:		if (numplanes >= MAX_CLIP_PLANES) {
ADDRLP4 84
INDIRI4
CNSTI4 5
LTI4 $1586
line 3741
;3740:			// this shouldn't really happen
;3741:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1552
JUMPV
LABELV $1586
line 3749
;3742:		}
;3743:
;3744:		//
;3745:		// if this is the same plane we hit before, nudge velocity
;3746:		// out along it, which fixes some epsilon issues with
;3747:		// non-axial planes
;3748:		//
;3749:		for (i = 0; i < numplanes; i++) {
ADDRLP4 80
CNSTI4 0
ASGNI4
ADDRGP4 $1591
JUMPV
LABELV $1588
line 3750
;3750:			if (DotProduct(trace.plane.normal, planes[i]) > 0.99) {
ADDRLP4 116+24
INDIRF4
ADDRLP4 80
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 16
ADDP4
INDIRF4
MULF4
ADDRLP4 116+24+4
INDIRF4
ADDRLP4 80
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 16+4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 116+24+8
INDIRF4
ADDRLP4 80
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 16+8
ADDP4
INDIRF4
MULF4
ADDF4
CNSTF4 1065185444
LEF4 $1592
line 3751
;3751:				VectorAdd(trace.plane.normal, velocity, velocity);
ADDRLP4 104
ADDRLP4 116+24
INDIRF4
ADDRLP4 104
INDIRF4
ADDF4
ASGNF4
ADDRLP4 104+4
ADDRLP4 116+24+4
INDIRF4
ADDRLP4 104+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 104+8
ADDRLP4 116+24+8
INDIRF4
ADDRLP4 104+8
INDIRF4
ADDF4
ASGNF4
line 3752
;3752:				break;
ADDRGP4 $1590
JUMPV
LABELV $1592
line 3754
;3753:			}
;3754:		}
LABELV $1589
line 3749
ADDRLP4 80
ADDRLP4 80
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1591
ADDRLP4 80
INDIRI4
ADDRLP4 84
INDIRI4
LTI4 $1588
LABELV $1590
line 3755
;3755:		if (i < numplanes) {
ADDRLP4 80
INDIRI4
ADDRLP4 84
INDIRI4
GEI4 $1610
line 3756
;3756:			continue;
ADDRGP4 $1560
JUMPV
LABELV $1610
line 3758
;3757:		}
;3758:		VectorCopy(trace.plane.normal, planes[numplanes]);
ADDRLP4 84
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 16
ADDP4
ADDRLP4 116+24
INDIRB
ASGNB 12
line 3759
;3759:		numplanes++;
ADDRLP4 84
ADDRLP4 84
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3766
;3760:
;3761:		//
;3762:		// modify velocity so it parallels all of the clip planes
;3763:		//
;3764:
;3765:		// find a plane that it enters
;3766:		for (i = 0; i < numplanes; i++) {
ADDRLP4 80
CNSTI4 0
ASGNI4
ADDRGP4 $1616
JUMPV
LABELV $1613
line 3767
;3767:			into = DotProduct(velocity, planes[i]);
ADDRLP4 172
ADDRLP4 104
INDIRF4
ADDRLP4 80
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 16
ADDP4
INDIRF4
MULF4
ADDRLP4 104+4
INDIRF4
ADDRLP4 80
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 16+4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 104+8
INDIRF4
ADDRLP4 80
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 16+8
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 3768
;3768:			if (into >= 0.1) {
ADDRLP4 172
INDIRF4
CNSTF4 1036831949
LTF4 $1621
line 3769
;3769:				continue;		// move doesn't interact with the plane
ADDRGP4 $1614
JUMPV
LABELV $1621
line 3780
;3770:			}
;3771:
;3772:			// see how hard we are hitting things
;3773:			/*
;3774:			if ( -into > pml.impactSpeed ) {
;3775:				pml.impactSpeed = -into;
;3776:			}
;3777:			*/
;3778:
;3779:			// slide along the plane
;3780:			PM_ClipVelocity(velocity, planes[i], clipVelocity, OVERCLIP);
ADDRLP4 104
ARGP4
ADDRLP4 80
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 16
ADDP4
ARGP4
ADDRLP4 4
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 3783
;3781:
;3782:			// see if there is a second plane that the new move enters
;3783:			for (j = 0; j < numplanes; j++) {
ADDRLP4 76
CNSTI4 0
ASGNI4
ADDRGP4 $1626
JUMPV
LABELV $1623
line 3784
;3784:				if (j == i) {
ADDRLP4 76
INDIRI4
ADDRLP4 80
INDIRI4
NEI4 $1627
line 3785
;3785:					continue;
ADDRGP4 $1624
JUMPV
LABELV $1627
line 3787
;3786:				}
;3787:				if (DotProduct(clipVelocity, planes[j]) >= 0.1) {
ADDRLP4 4
INDIRF4
ADDRLP4 76
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 16
ADDP4
INDIRF4
MULF4
ADDRLP4 4+4
INDIRF4
ADDRLP4 76
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 16+4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 4+8
INDIRF4
ADDRLP4 76
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 16+8
ADDP4
INDIRF4
MULF4
ADDF4
CNSTF4 1036831949
LTF4 $1629
line 3788
;3788:					continue;		// move doesn't interact with the plane
ADDRGP4 $1624
JUMPV
LABELV $1629
line 3792
;3789:				}
;3790:
;3791:				// try clipping the move to the plane
;3792:				PM_ClipVelocity(clipVelocity, planes[j], clipVelocity, OVERCLIP);
ADDRLP4 4
ARGP4
ADDRLP4 76
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 16
ADDP4
ARGP4
ADDRLP4 4
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 3795
;3793:
;3794:				// see if it goes back into the first clip plane
;3795:				if (DotProduct(clipVelocity, planes[i]) >= 0) {
ADDRLP4 4
INDIRF4
ADDRLP4 80
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 16
ADDP4
INDIRF4
MULF4
ADDRLP4 4+4
INDIRF4
ADDRLP4 80
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 16+4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 4+8
INDIRF4
ADDRLP4 80
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 16+8
ADDP4
INDIRF4
MULF4
ADDF4
CNSTF4 0
LTF4 $1635
line 3796
;3796:					continue;
ADDRGP4 $1624
JUMPV
LABELV $1635
line 3800
;3797:				}
;3798:
;3799:				// slide the original velocity along the crease
;3800:				CrossProduct(planes[i], planes[j], dir);
ADDRLP4 80
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 16
ADDP4
ARGP4
ADDRLP4 76
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 16
ADDP4
ARGP4
ADDRLP4 88
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 3801
;3801:				VectorNormalize(dir);
ADDRLP4 88
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 3802
;3802:				d = DotProduct(dir, velocity);
ADDRLP4 100
ADDRLP4 88
INDIRF4
ADDRLP4 104
INDIRF4
MULF4
ADDRLP4 88+4
INDIRF4
ADDRLP4 104+4
INDIRF4
MULF4
ADDF4
ADDRLP4 88+8
INDIRF4
ADDRLP4 104+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 3803
;3803:				VectorScale(dir, d, clipVelocity);
ADDRLP4 4
ADDRLP4 88
INDIRF4
ADDRLP4 100
INDIRF4
MULF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 88+4
INDIRF4
ADDRLP4 100
INDIRF4
MULF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 88+8
INDIRF4
ADDRLP4 100
INDIRF4
MULF4
ASGNF4
line 3806
;3804:
;3805:				// see if there is a third plane the the new move enters
;3806:				for (k = 0; k < numplanes; k++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1652
JUMPV
LABELV $1649
line 3807
;3807:					if (k == i || k == j) {
ADDRLP4 0
INDIRI4
ADDRLP4 80
INDIRI4
EQI4 $1655
ADDRLP4 0
INDIRI4
ADDRLP4 76
INDIRI4
NEI4 $1653
LABELV $1655
line 3808
;3808:						continue;
ADDRGP4 $1650
JUMPV
LABELV $1653
line 3810
;3809:					}
;3810:					if (DotProduct(clipVelocity, planes[k]) >= 0.1) {
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 16
ADDP4
INDIRF4
MULF4
ADDRLP4 4+4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 16+4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 4+8
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 16+8
ADDP4
INDIRF4
MULF4
ADDF4
CNSTF4 1036831949
LTF4 $1656
line 3811
;3811:						continue;		// move doesn't interact with the plane
ADDRGP4 $1650
JUMPV
LABELV $1656
line 3815
;3812:					}
;3813:
;3814:					// stop dead at a tripple plane interaction
;3815:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1552
JUMPV
LABELV $1650
line 3806
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1652
ADDRLP4 0
INDIRI4
ADDRLP4 84
INDIRI4
LTI4 $1649
line 3817
;3816:				}
;3817:			}
LABELV $1624
line 3783
ADDRLP4 76
ADDRLP4 76
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1626
ADDRLP4 76
INDIRI4
ADDRLP4 84
INDIRI4
LTI4 $1623
line 3820
;3818:
;3819:			// if we have fixed all interactions, try another move
;3820:			VectorCopy(clipVelocity, velocity);
ADDRLP4 104
ADDRLP4 4
INDIRB
ASGNB 12
line 3821
;3821:			break;
ADDRGP4 $1615
JUMPV
LABELV $1614
line 3766
ADDRLP4 80
ADDRLP4 80
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1616
ADDRLP4 80
INDIRI4
ADDRLP4 84
INDIRI4
LTI4 $1613
LABELV $1615
line 3823
;3822:		}
;3823:	}
LABELV $1560
line 3702
ADDRLP4 192
ADDRLP4 192
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1562
ADDRLP4 192
INDIRI4
ADDRLP4 196
INDIRI4
LTI4 $1559
line 3825
;3824:
;3825:	return qtrue;
CNSTI4 1
RETI4
LABELV $1552
endproc MoveRopeElement 276 28
proc ThinkRopeElement 188 16
line 3838
;3826:}
;3827:#endif
;3828:
;3829:/*
;3830:==============
;3831:JUHOX: ThinkRopeElement
;3832:
;3833:returns qfalse if element is in solid
;3834:==============
;3835:*/
;3836:#if GRAPPLE_ROPE
;3837:static ropeElement_t tempRope[MAX_ROPE_ELEMENTS];
;3838:static qboolean ThinkRopeElement(gclient_t* client, int ropeElement, int phase, float dt) {
line 3854
;3839:	const ropeElement_t* srcRope;
;3840:	const ropeElement_t* srcRE;
;3841:	ropeElement_t* dstRE;
;3842:	vec3_t startPos;
;3843:	vec3_t predPos;
;3844:	vec3_t succPos;
;3845:	vec3_t anchorPos;
;3846:	vec3_t velocity;
;3847:	float dist;
;3848:	float f;
;3849:	vec3_t dir;
;3850:	vec3_t idealpos;
;3851:	vec3_t realpos;
;3852:	float errSqr;
;3853:
;3854:	switch (phase) {
ADDRLP4 120
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 120
INDIRI4
CNSTI4 0
EQI4 $1665
ADDRLP4 120
INDIRI4
CNSTI4 1
EQI4 $1666
ADDRGP4 $1663
JUMPV
LABELV $1665
line 3856
;3855:	case 0:
;3856:		srcRope = client->ropeElements;
ADDRLP4 104
ADDRFP4 0
INDIRP4
CNSTI4 1024
ADDP4
ASGNP4
line 3857
;3857:		dstRE = &tempRope[ropeElement];
ADDRLP4 84
ADDRFP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRGP4 tempRope
ADDP4
ASGNP4
line 3858
;3858:		break;
ADDRGP4 $1664
JUMPV
LABELV $1666
line 3860
;3859:	case 1:
;3860:		srcRope = tempRope;
ADDRLP4 104
ADDRGP4 tempRope
ASGNP4
line 3861
;3861:		dstRE = &client->ropeElements[ropeElement];
ADDRLP4 84
ADDRFP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 1024
ADDP4
ADDP4
ASGNP4
line 3862
;3862:		break;
ADDRGP4 $1664
JUMPV
LABELV $1663
line 3864
;3863:	default:
;3864:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1662
JUMPV
LABELV $1664
line 3866
;3865:	}
;3866:	srcRE = &srcRope[ropeElement];
ADDRLP4 24
ADDRFP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 104
INDIRP4
ADDP4
ASGNP4
line 3868
;3867:
;3868:	VectorCopy(client->ropeElements[ropeElement].pos, startPos);
ADDRLP4 108
ADDRFP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 1024
ADDP4
ADDP4
INDIRB
ASGNB 12
line 3870
;3869:
;3870:	if (ropeElement > 0) {
ADDRFP4 4
INDIRI4
CNSTI4 0
LEI4 $1667
line 3871
;3871:		VectorCopy(srcRope[ropeElement-1].pos, predPos);
ADDRLP4 28
ADDRFP4 4
INDIRI4
CNSTI4 28
MULI4
CNSTI4 28
SUBI4
ADDRLP4 104
INDIRP4
ADDP4
INDIRB
ASGNB 12
line 3872
;3872:		VectorCopy(client->ropeElements[ropeElement-1].pos, anchorPos);
ADDRLP4 72
ADDRFP4 4
INDIRI4
CNSTI4 28
MULI4
CNSTI4 28
SUBI4
ADDRFP4 0
INDIRP4
CNSTI4 1024
ADDP4
ADDP4
INDIRB
ASGNB 12
line 3873
;3873:	}
ADDRGP4 $1668
JUMPV
LABELV $1667
line 3874
;3874:	else {
line 3875
;3875:		VectorCopy(client->hook->r.currentOrigin, predPos);
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 884
ADDP4
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 3876
;3876:		VectorCopy(predPos, anchorPos);
ADDRLP4 72
ADDRLP4 28
INDIRB
ASGNB 12
line 3877
;3877:	}
LABELV $1668
line 3879
;3878:
;3879:	if (ropeElement < client->numRopeElements-1) {
ADDRFP4 4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 1020
ADDP4
INDIRI4
CNSTI4 1
SUBI4
GEI4 $1669
line 3880
;3880:		VectorCopy(srcRope[ropeElement+1].pos, succPos);
ADDRLP4 56
ADDRFP4 4
INDIRI4
CNSTI4 28
MULI4
CNSTI4 28
ADDI4
ADDRLP4 104
INDIRP4
ADDP4
INDIRB
ASGNB 12
line 3881
;3881:	}
ADDRGP4 $1670
JUMPV
LABELV $1669
line 3882
;3882:	else {
line 3883
;3883:		VectorCopy(client->ps.origin, succPos);
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 3884
;3884:	}
LABELV $1670
line 3886
;3885:
;3886:	VectorCopy(srcRE->velocity, velocity);
ADDRLP4 0
ADDRLP4 24
INDIRP4
CNSTI4 12
ADDP4
INDIRB
ASGNB 12
line 3888
;3887:	
;3888:	velocity[2] -= 0.5 * g_gravity.value * dt;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRGP4 g_gravity+8
INDIRF4
CNSTF4 1056964608
MULF4
ADDRFP4 12
INDIRF4
MULF4
SUBF4
ASGNF4
line 3889
;3889:	if (!srcRE->touch) {
ADDRLP4 24
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1673
line 3890
;3890:		velocity[0] += 0.05 * dt * crandom();
ADDRLP4 124
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 12
INDIRF4
CNSTF4 1028443341
MULF4
ADDRLP4 124
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 124
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
MULF4
ADDF4
ASGNF4
line 3891
;3891:		velocity[1] += 0.05 * dt * crandom();
ADDRLP4 128
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRFP4 12
INDIRF4
CNSTF4 1028443341
MULF4
ADDRLP4 128
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 128
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
MULF4
ADDF4
ASGNF4
line 3892
;3892:		velocity[2] += 0.05 * dt * crandom();
ADDRLP4 132
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRFP4 12
INDIRF4
CNSTF4 1028443341
MULF4
ADDRLP4 132
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 132
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
MULF4
ADDF4
ASGNF4
line 3893
;3893:	}
LABELV $1673
line 3895
;3894:
;3895:	VectorSubtract(succPos, srcRE->pos, dir);
ADDRLP4 12
ADDRLP4 56
INDIRF4
ADDRLP4 24
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 56+4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 56+8
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3896
;3896:	dist = VectorLength(dir);
ADDRLP4 12
ARGP4
ADDRLP4 128
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 68
ADDRLP4 128
INDIRF4
ASGNF4
line 3897
;3897:	if (dist > 1.5 * ROPE_ELEMENT_SIZE) {
ADDRLP4 68
INDIRF4
CNSTF4 1097859072
LEF4 $1681
line 3898
;3898:		f = 4.0;
ADDRLP4 52
CNSTF4 1082130432
ASGNF4
line 3899
;3899:	}
ADDRGP4 $1682
JUMPV
LABELV $1681
line 3900
;3900:	else if (dist > ROPE_ELEMENT_SIZE) {
ADDRLP4 68
INDIRF4
CNSTF4 1092616192
LEF4 $1683
line 3901
;3901:		f = 2.0;
ADDRLP4 52
CNSTF4 1073741824
ASGNF4
line 3902
;3902:	}
ADDRGP4 $1684
JUMPV
LABELV $1683
line 3903
;3903:	else {
line 3904
;3904:		f = 0.1;
ADDRLP4 52
CNSTF4 1036831949
ASGNF4
line 3905
;3905:	}
LABELV $1684
LABELV $1682
line 3906
;3906:	VectorMA(velocity, f, dir, velocity);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 12
INDIRF4
ADDRLP4 52
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 12+4
INDIRF4
ADDRLP4 52
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 12+8
INDIRF4
ADDRLP4 52
INDIRF4
MULF4
ADDF4
ASGNF4
line 3908
;3907:
;3908:	VectorSubtract(predPos, srcRE->pos, dir);
ADDRLP4 12
ADDRLP4 28
INDIRF4
ADDRLP4 24
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 28+4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 28+8
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3909
;3909:	dist = VectorLength(dir);
ADDRLP4 12
ARGP4
ADDRLP4 140
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 68
ADDRLP4 140
INDIRF4
ASGNF4
line 3910
;3910:	if (dist > 1.5 * ROPE_ELEMENT_SIZE) {
ADDRLP4 68
INDIRF4
CNSTF4 1097859072
LEF4 $1695
line 3911
;3911:		f = 4.0;
ADDRLP4 52
CNSTF4 1082130432
ASGNF4
line 3912
;3912:	}
ADDRGP4 $1696
JUMPV
LABELV $1695
line 3913
;3913:	else if (dist > ROPE_ELEMENT_SIZE) {
ADDRLP4 68
INDIRF4
CNSTF4 1092616192
LEF4 $1697
line 3914
;3914:		f = 2.0;
ADDRLP4 52
CNSTF4 1073741824
ASGNF4
line 3915
;3915:	}
ADDRGP4 $1698
JUMPV
LABELV $1697
line 3916
;3916:	else {
line 3917
;3917:		f = 0.1;
ADDRLP4 52
CNSTF4 1036831949
ASGNF4
line 3918
;3918:	}
LABELV $1698
LABELV $1696
line 3919
;3919:	VectorMA(velocity, f, dir, velocity);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 12
INDIRF4
ADDRLP4 52
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 12+4
INDIRF4
ADDRLP4 52
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 12+8
INDIRF4
ADDRLP4 52
INDIRF4
MULF4
ADDF4
ASGNF4
line 3921
;3920:	
;3921:	VectorScale(velocity, 0.9, velocity);
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1063675494
MULF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
CNSTF4 1063675494
MULF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1063675494
MULF4
ASGNF4
line 3923
;3922:
;3923:	VectorCopy(velocity, dstRE->velocity);
ADDRLP4 84
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 0
INDIRB
ASGNB 12
line 3925
;3924:
;3925:	VectorMA(srcRE->pos, dt, velocity, idealpos);
ADDRLP4 152
ADDRFP4 12
INDIRF4
ASGNF4
ADDRLP4 40
ADDRLP4 24
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDRLP4 152
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 40+4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
ADDRLP4 152
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 40+8
ADDRLP4 24
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
ADDRFP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
line 3927
;3926:
;3927:	{
line 3932
;3928:		vec3_t v;
;3929:		vec3_t w;
;3930:		float d;
;3931:
;3932:		VectorSubtract(succPos, predPos, v);
ADDRLP4 156
ADDRLP4 56
INDIRF4
ADDRLP4 28
INDIRF4
SUBF4
ASGNF4
ADDRLP4 156+4
ADDRLP4 56+4
INDIRF4
ADDRLP4 28+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 156+8
ADDRLP4 56+8
INDIRF4
ADDRLP4 28+8
INDIRF4
SUBF4
ASGNF4
line 3933
;3933:		VectorSubtract(idealpos, predPos, w);
ADDRLP4 168
ADDRLP4 40
INDIRF4
ADDRLP4 28
INDIRF4
SUBF4
ASGNF4
ADDRLP4 168+4
ADDRLP4 40+4
INDIRF4
ADDRLP4 28+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 168+8
ADDRLP4 40+8
INDIRF4
ADDRLP4 28+8
INDIRF4
SUBF4
ASGNF4
line 3934
;3934:		f = VectorNormalize(v);
ADDRLP4 156
ARGP4
ADDRLP4 184
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 52
ADDRLP4 184
INDIRF4
ASGNF4
line 3935
;3935:		d = DotProduct(v, w);
ADDRLP4 180
ADDRLP4 156
INDIRF4
ADDRLP4 168
INDIRF4
MULF4
ADDRLP4 156+4
INDIRF4
ADDRLP4 168+4
INDIRF4
MULF4
ADDF4
ADDRLP4 156+8
INDIRF4
ADDRLP4 168+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 3944
;3936:		/*
;3937:		if (d < 0) {
;3938:			VectorMA(idealpos, -d, v, idealpos);
;3939:		}
;3940:		else if (d > f) {
;3941:			VectorMA(idealpos, f - d, v, idealpos);
;3942:		}
;3943:		*/
;3944:		if (d < 0) {
ADDRLP4 180
INDIRF4
CNSTF4 0
GEF4 $1729
line 3945
;3945:			VectorCopy(predPos, idealpos);
ADDRLP4 40
ADDRLP4 28
INDIRB
ASGNB 12
line 3946
;3946:		}
ADDRGP4 $1730
JUMPV
LABELV $1729
line 3947
;3947:		else if (d > f) {
ADDRLP4 180
INDIRF4
ADDRLP4 52
INDIRF4
LEF4 $1731
line 3948
;3948:			VectorCopy(succPos, idealpos);
ADDRLP4 40
ADDRLP4 56
INDIRB
ASGNB 12
line 3949
;3949:		}
LABELV $1731
LABELV $1730
line 3950
;3950:	}
line 3952
;3951:
;3952:	if (phase == 1) {
ADDRFP4 8
INDIRI4
CNSTI4 1
NEI4 $1733
line 3953
;3953:		VectorSubtract(idealpos, anchorPos, dir);
ADDRLP4 12
ADDRLP4 40
INDIRF4
ADDRLP4 72
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 40+4
INDIRF4
ADDRLP4 72+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 40+8
INDIRF4
ADDRLP4 72+8
INDIRF4
SUBF4
ASGNF4
line 3954
;3954:		dist = VectorLength(dir);
ADDRLP4 12
ARGP4
ADDRLP4 156
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 68
ADDRLP4 156
INDIRF4
ASGNF4
line 3955
;3955:		if (dist > 1.5 * ROPE_ELEMENT_SIZE) {
ADDRLP4 68
INDIRF4
CNSTF4 1097859072
LEF4 $1741
line 3956
;3956:			VectorMA(anchorPos, 1.5 * ROPE_ELEMENT_SIZE / dist, dir, idealpos);
ADDRLP4 40
ADDRLP4 72
INDIRF4
ADDRLP4 12
INDIRF4
CNSTF4 1097859072
ADDRLP4 68
INDIRF4
DIVF4
MULF4
ADDF4
ASGNF4
ADDRLP4 40+4
ADDRLP4 72+4
INDIRF4
ADDRLP4 12+4
INDIRF4
CNSTF4 1097859072
ADDRLP4 68
INDIRF4
DIVF4
MULF4
ADDF4
ASGNF4
ADDRLP4 40+8
ADDRLP4 72+8
INDIRF4
ADDRLP4 12+8
INDIRF4
CNSTF4 1097859072
ADDRLP4 68
INDIRF4
DIVF4
MULF4
ADDF4
ASGNF4
line 3957
;3957:		}
LABELV $1741
line 3958
;3958:	}
LABELV $1733
line 3965
;3959:
;3960:	/*
;3961:	if (!MoveRopeElement(startPos, idealpos, realpos, &dstRE->touch)) {
;3962:		return qfalse;
;3963:	}
;3964:	*/
;3965:	switch (phase) {
ADDRLP4 156
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
EQI4 $1751
ADDRLP4 156
INDIRI4
CNSTI4 1
EQI4 $1752
ADDRGP4 $1749
JUMPV
LABELV $1751
line 3967
;3966:	case 0:
;3967:		VectorCopy(idealpos, dstRE->pos);
ADDRLP4 84
INDIRP4
ADDRLP4 40
INDIRB
ASGNB 12
line 3968
;3968:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1662
JUMPV
LABELV $1752
line 3970
;3969:	case 1:
;3970:		if (!MoveRopeElement(startPos, idealpos, realpos, &dstRE->touch)) {
ADDRLP4 108
ARGP4
ADDRLP4 40
ARGP4
ADDRLP4 92
ARGP4
ADDRLP4 84
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 160
ADDRGP4 MoveRopeElement
CALLI4
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 0
NEI4 $1750
line 3971
;3971:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1662
JUMPV
line 3973
;3972:		}
;3973:		break;
LABELV $1749
LABELV $1750
line 3982
;3974:	}
;3975:
;3976:	/*
;3977:	if (re->touch) {
;3978:		VectorScale(re->velocity, 0.7, re->velocity);
;3979:	}
;3980:	*/
;3981:
;3982:	errSqr = DistanceSquared(idealpos, realpos);
ADDRLP4 40
ARGP4
ADDRLP4 92
ARGP4
ADDRLP4 160
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 88
ADDRLP4 160
INDIRF4
ASGNF4
line 3983
;3983:	if (errSqr > 0.1) {
ADDRLP4 88
INDIRF4
CNSTF4 1036831949
LEF4 $1755
line 3987
;3984:		vec3_t realpos2;
;3985:		qboolean touch;
;3986:
;3987:		startPos[2] += ROPE_ELEMENT_SIZE;
ADDRLP4 108+8
ADDRLP4 108+8
INDIRF4
CNSTF4 1092616192
ADDF4
ASGNF4
line 3988
;3988:		if (MoveRopeElement(startPos, idealpos, realpos2, &touch)) {
ADDRLP4 108
ARGP4
ADDRLP4 40
ARGP4
ADDRLP4 164
ARGP4
ADDRLP4 176
ARGP4
ADDRLP4 180
ADDRGP4 MoveRopeElement
CALLI4
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 0
EQI4 $1758
line 3989
;3989:			if (DistanceSquared(idealpos, realpos2) < errSqr) {
ADDRLP4 40
ARGP4
ADDRLP4 164
ARGP4
ADDRLP4 184
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 184
INDIRF4
ADDRLP4 88
INDIRF4
GEF4 $1760
line 3990
;3990:				dstRE->touch = touch;
ADDRLP4 84
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 176
INDIRI4
ASGNI4
line 3991
;3991:				VectorCopy(realpos2, realpos);
ADDRLP4 92
ADDRLP4 164
INDIRB
ASGNB 12
line 3992
;3992:			}
LABELV $1760
line 3993
;3993:		}
LABELV $1758
line 3994
;3994:	}
LABELV $1755
line 3996
;3995:
;3996:	VectorCopy(realpos, dstRE->pos);
ADDRLP4 84
INDIRP4
ADDRLP4 92
INDIRB
ASGNB 12
line 3997
;3997:	return qtrue;
CNSTI4 1
RETI4
LABELV $1662
endproc ThinkRopeElement 188 16
proc IsRopeTaut 120 28
line 4050
;3998:}
;3999:#endif
;4000:
;4001:/*
;4002:==============
;4003:JUHOX: IsRopeSegmentTaut
;4004:==============
;4005:*/
;4006:/*
;4007:#if GRAPPLE_ROPE
;4008:static qboolean IsRopeSegmentTaut(const vec3_t start, const vec3_t end, int numSections) {
;4009:	return Distance(start, end) / numSections > ROPE_ELEMENT_SIZE;
;4010:}
;4011:#endif
;4012:*/
;4013:
;4014:/*
;4015:==============
;4016:JUHOX: IsRopeTaut
;4017:==============
;4018:*/
;4019:/*
;4020:#if GRAPPLE_ROPE
;4021:static qboolean IsRopeTaut(gentity_t* ent) {
;4022:	gclient_t* client;
;4023:	int i;
;4024:	vec3_t start;
;4025:	int n;
;4026:
;4027:	client = ent->client;
;4028:	if (client->hook->s.eType != ET_GRAPPLE) return qfalse;
;4029:
;4030:	VectorCopy(client->hook->r.currentOrigin, start);
;4031:	n = 0;
;4032:	for (i = 0; i < client->numRopeElements; i++) {
;4033:		ropeElement_t* re;
;4034:
;4035:		re = &client->ropeElements[i];
;4036:		n++;
;4037:		if (!re->touch) continue;
;4038:
;4039:		if (!IsRopeSegmentTaut(start, re->pos, n)) return qfalse;
;4040:
;4041:		VectorCopy(re->pos, start);
;4042:		n = 0;
;4043:	}
;4044:	n++;
;4045:	return IsRopeSegmentTaut(start, client->ps.origin, n);
;4046:}
;4047:#endif
;4048:*/
;4049:#if GRAPPLE_ROPE
;4050:static qboolean IsRopeTaut(gentity_t* ent, qboolean wasTaut) {
line 4059
;4051:	gclient_t* client;
;4052:	int i;
;4053:	int n;
;4054:	vec3_t dir;
;4055:	float dirLengthSqr;
;4056:	float dirLength;
;4057:	float treshold;
;4058:
;4059:	client = ent->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 4060
;4060:	if (client->hook->s.eType != ET_GRAPPLE) return qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 884
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 11
EQI4 $1763
CNSTI4 0
RETI4
ADDRGP4 $1762
JUMPV
LABELV $1763
line 4084
;4061:	
;4062:	/*
;4063:	i = 0;
;4064:	n = client->numRopeElements;
;4065:	while (n > 0) {
;4066:		int j;
;4067:		int m;
;4068:		trace_t trace;
;4069:
;4070:		m = n >> 1;
;4071:		j = i + m;
;4072:
;4073:		trap_Trace(&trace, client->ps.origin, NULL, NULL, client->ropeElements[j].pos, -1, CONTENTS_SOLID);
;4074:
;4075:		if (trace.fraction < 1.0) {
;4076:			i = j + 1;
;4077:			n -= m + 1;
;4078:		}
;4079:		else {
;4080:			n = m;
;4081:		}
;4082:	}
;4083:	*/
;4084:	for (i = client->numRopeElements-1; i >= 0; i--) {
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 1020
ADDP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRGP4 $1768
JUMPV
LABELV $1765
line 4087
;4085:		trace_t trace;
;4086:
;4087:		if (client->ropeElements[i].touch) break;
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
ADDP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1769
ADDRGP4 $1767
JUMPV
LABELV $1769
line 4089
;4088:
;4089:		trap_Trace(&trace, client->ps.origin, NULL, NULL, client->ropeElements[i].pos, -1, CONTENTS_SOLID);
ADDRLP4 36
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
ADDP4
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 4091
;4090:
;4091:		if (trace.fraction < 1.0) break;
ADDRLP4 36+8
INDIRF4
CNSTF4 1065353216
GEF4 $1771
ADDRGP4 $1767
JUMPV
LABELV $1771
line 4092
;4092:	}
LABELV $1766
line 4084
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $1768
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $1765
LABELV $1767
line 4093
;4093:	i++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4095
;4094:
;4095:	if (i >= client->numRopeElements) return qtrue;
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 1020
ADDP4
INDIRI4
LTI4 $1774
CNSTI4 1
RETI4
ADDRGP4 $1762
JUMPV
LABELV $1774
line 4099
;4096:	/*
;4097:	return IsRopeSegmentTaut(client->ropeElements[i].pos, client->ps.origin, client->numRopeElements - i);
;4098:	*/
;4099:	VectorSubtract(client->ropeElements[i].pos, client->ps.origin, dir);
ADDRLP4 8
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8+4
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
ADDP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8+8
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
ADDP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
line 4100
;4100:	dirLengthSqr = VectorLengthSquared(dir);
ADDRLP4 8
ARGP4
ADDRLP4 48
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 20
ADDRLP4 48
INDIRF4
ASGNF4
line 4101
;4101:	dirLength = sqrt(dirLengthSqr);
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 52
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 52
INDIRF4
ASGNF4
line 4102
;4102:	treshold = (wasTaut? 0.2 : 0.1) * dirLength;
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $1779
ADDRLP4 56
CNSTF4 1045220557
ASGNF4
ADDRGP4 $1780
JUMPV
LABELV $1779
ADDRLP4 56
CNSTF4 1036831949
ASGNF4
LABELV $1780
ADDRLP4 24
ADDRLP4 56
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 4103
;4103:	n = i;
ADDRLP4 32
ADDRLP4 4
INDIRI4
ASGNI4
line 4104
;4104:	for (++i; i < client->numRopeElements; i++) {
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $1784
JUMPV
LABELV $1781
line 4110
;4105:		float k;
;4106:		vec3_t pos;
;4107:		vec3_t dir2;
;4108:		vec3_t plummet;
;4109:		
;4110:		VectorCopy(client->ropeElements[i].pos, pos);
ADDRLP4 76
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
ADDP4
INDIRB
ASGNB 12
line 4111
;4111:		VectorSubtract(pos, client->ps.origin, dir2);
ADDRLP4 64
ADDRLP4 76
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 64+4
ADDRLP4 76+4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 64+8
ADDRLP4 76+8
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
line 4112
;4112:		k = DotProduct(dir, dir2) / dirLengthSqr;
ADDRLP4 60
ADDRLP4 8
INDIRF4
ADDRLP4 64
INDIRF4
MULF4
ADDRLP4 8+4
INDIRF4
ADDRLP4 64+4
INDIRF4
MULF4
ADDF4
ADDRLP4 8+8
INDIRF4
ADDRLP4 64+8
INDIRF4
MULF4
ADDF4
ADDRLP4 20
INDIRF4
DIVF4
ASGNF4
line 4113
;4113:		if (k < 0 || k > 1) return qfalse;
ADDRLP4 60
INDIRF4
CNSTF4 0
LTF4 $1795
ADDRLP4 60
INDIRF4
CNSTF4 1065353216
LEF4 $1793
LABELV $1795
CNSTI4 0
RETI4
ADDRGP4 $1762
JUMPV
LABELV $1793
line 4114
;4114:		VectorMA(client->ps.origin, k, dir, plummet);
ADDRLP4 88
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
ADDRLP4 60
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 88+4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 8+4
INDIRF4
ADDRLP4 60
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 88+8
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 8+8
INDIRF4
ADDRLP4 60
INDIRF4
MULF4
ADDF4
ASGNF4
line 4115
;4115:		if (Distance(plummet, pos) > treshold) return qfalse;
ADDRLP4 88
ARGP4
ADDRLP4 76
ARGP4
ADDRLP4 116
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRLP4 116
INDIRF4
ADDRLP4 24
INDIRF4
LEF4 $1800
CNSTI4 0
RETI4
ADDRGP4 $1762
JUMPV
LABELV $1800
line 4116
;4116:	}
LABELV $1782
line 4104
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1784
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 1020
ADDP4
INDIRI4
LTI4 $1781
line 4117
;4117:	return qtrue;
CNSTI4 1
RETI4
LABELV $1762
endproc IsRopeTaut 120 28
proc NextTouchedRopeElement 0 0
line 4127
;4118:}
;4119:#endif
;4120:
;4121:/*
;4122:==============
;4123:JUHOX: NextTouchedRopeElement
;4124:==============
;4125:*/
;4126:#if GRAPPLE_ROPE
;4127:static int NextTouchedRopeElement(gclient_t* client, int index, vec3_t pos) {
line 4128
;4128:	if (index < 0) {
ADDRFP4 4
INDIRI4
CNSTI4 0
GEI4 $1806
line 4129
;4129:		VectorCopy(client->ps.origin, pos);
ADDRFP4 8
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 4130
;4130:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $1802
JUMPV
LABELV $1805
line 4133
;4131:	}
;4132:
;4133:	while (index < client->numRopeElements) {
line 4134
;4134:		if (client->ropeElements[index].touch) break;
ADDRFP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 1024
ADDP4
ADDP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1808
ADDRGP4 $1807
JUMPV
LABELV $1808
line 4135
;4135:		index++;
ADDRFP4 4
ADDRFP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4136
;4136:	}
LABELV $1806
line 4133
ADDRFP4 4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 1020
ADDP4
INDIRI4
LTI4 $1805
LABELV $1807
line 4138
;4137:
;4138:	if (index >= client->numRopeElements) {
ADDRFP4 4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 1020
ADDP4
INDIRI4
LTI4 $1810
line 4139
;4139:		VectorCopy(client->ps.origin, pos);
ADDRFP4 8
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 4140
;4140:		index = -1;
ADDRFP4 4
CNSTI4 -1
ASGNI4
line 4141
;4141:	}
ADDRGP4 $1811
JUMPV
LABELV $1810
line 4142
;4142:	else {
line 4143
;4143:		VectorCopy(client->ropeElements[index].pos, pos);
ADDRFP4 8
INDIRP4
ADDRFP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 1024
ADDP4
ADDP4
INDIRB
ASGNB 12
line 4144
;4144:	}
LABELV $1811
line 4145
;4145:	return index;
ADDRFP4 4
INDIRI4
RETI4
LABELV $1802
endproc NextTouchedRopeElement 0 0
bss
align 4
LABELV $1813
skip 4
align 4
LABELV $1814
skip 4
align 4
LABELV $1815
skip 12
align 4
LABELV $1816
skip 12
align 4
LABELV $1817
skip 4
code
proc TautRopePos 32 12
line 4157
;4146:}
;4147:#endif
;4148:
;4149:/*
;4150:==============
;4151:JUHOX: TautRopePos
;4152:
;4153:called with index=-1 to init
;4154:==============
;4155:*/
;4156:#if GRAPPLE_ROPE
;4157:static void TautRopePos(gclient_t* client, int index, vec3_t pos) {
line 4164
;4158:	static float distCovered;
;4159:	static float totalDist;
;4160:	static vec3_t startPos;
;4161:	static vec3_t dir;
;4162:	static int destIndex;
;4163:
;4164:	if (index < 0) {
ADDRFP4 4
INDIRI4
CNSTI4 0
GEI4 $1818
line 4167
;4165:		vec3_t dest;
;4166:
;4167:		distCovered = 0;
ADDRGP4 $1813
CNSTF4 0
ASGNF4
line 4168
;4168:		VectorCopy(client->hook->r.currentOrigin, startPos);
ADDRGP4 $1815
ADDRFP4 0
INDIRP4
CNSTI4 884
ADDP4
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 4169
;4169:		destIndex = NextTouchedRopeElement(client, 0, dest);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 12
ADDRGP4 NextTouchedRopeElement
CALLI4
ASGNI4
ADDRGP4 $1817
ADDRLP4 12
INDIRI4
ASGNI4
line 4170
;4170:		VectorSubtract(dest, startPos, dir);
ADDRGP4 $1816
ADDRLP4 0
INDIRF4
ADDRGP4 $1815
INDIRF4
SUBF4
ASGNF4
ADDRGP4 $1816+4
ADDRLP4 0+4
INDIRF4
ADDRGP4 $1815+4
INDIRF4
SUBF4
ASGNF4
ADDRGP4 $1816+8
ADDRLP4 0+8
INDIRF4
ADDRGP4 $1815+8
INDIRF4
SUBF4
ASGNF4
line 4171
;4171:		totalDist = VectorNormalize(dir);
ADDRGP4 $1816
ARGP4
ADDRLP4 16
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRGP4 $1814
ADDRLP4 16
INDIRF4
ASGNF4
line 4172
;4172:		return;
ADDRGP4 $1812
JUMPV
LABELV $1818
line 4175
;4173:	}
;4174:
;4175:	distCovered += 1.5 * ROPE_ELEMENT_SIZE;
ADDRLP4 0
ADDRGP4 $1813
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
CNSTF4 1097859072
ADDF4
ASGNF4
LABELV $1826
line 4178
;4176:
;4177:	CheckDist:
;4178:	if (distCovered > totalDist) {
ADDRGP4 $1813
INDIRF4
ADDRGP4 $1814
INDIRF4
LEF4 $1827
line 4179
;4179:		distCovered -= totalDist;
ADDRLP4 4
ADDRGP4 $1813
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRGP4 $1814
INDIRF4
SUBF4
ASGNF4
line 4180
;4180:		if (destIndex < 0) {
ADDRGP4 $1817
INDIRI4
CNSTI4 0
GEI4 $1829
line 4181
;4181:			VectorCopy(client->ps.origin, startPos);
ADDRGP4 $1815
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 4182
;4182:			VectorClear(dir);
ADDRLP4 8
CNSTF4 0
ASGNF4
ADDRGP4 $1816+8
ADDRLP4 8
INDIRF4
ASGNF4
ADDRGP4 $1816+4
ADDRLP4 8
INDIRF4
ASGNF4
ADDRGP4 $1816
ADDRLP4 8
INDIRF4
ASGNF4
line 4183
;4183:			totalDist = 1000000.0;
ADDRGP4 $1814
CNSTF4 1232348160
ASGNF4
line 4184
;4184:		}
ADDRGP4 $1830
JUMPV
LABELV $1829
line 4185
;4185:		else {
line 4188
;4186:			vec3_t dest;
;4187:
;4188:			VectorCopy(client->ropeElements[destIndex].pos, startPos);
ADDRGP4 $1815
ADDRGP4 $1817
INDIRI4
CNSTI4 28
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 1024
ADDP4
ADDP4
INDIRB
ASGNB 12
line 4189
;4189:			destIndex = NextTouchedRopeElement(client, destIndex+1, dest);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 $1817
ASGNP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 8
ARGP4
ADDRLP4 24
ADDRGP4 NextTouchedRopeElement
CALLI4
ASGNI4
ADDRLP4 20
INDIRP4
ADDRLP4 24
INDIRI4
ASGNI4
line 4190
;4190:			VectorSubtract(dest, startPos, dir);
ADDRGP4 $1816
ADDRLP4 8
INDIRF4
ADDRGP4 $1815
INDIRF4
SUBF4
ASGNF4
ADDRGP4 $1816+4
ADDRLP4 8+4
INDIRF4
ADDRGP4 $1815+4
INDIRF4
SUBF4
ASGNF4
ADDRGP4 $1816+8
ADDRLP4 8+8
INDIRF4
ADDRGP4 $1815+8
INDIRF4
SUBF4
ASGNF4
line 4191
;4191:			totalDist = VectorNormalize(dir);
ADDRGP4 $1816
ARGP4
ADDRLP4 28
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRGP4 $1814
ADDRLP4 28
INDIRF4
ASGNF4
line 4192
;4192:			goto CheckDist;
ADDRGP4 $1826
JUMPV
LABELV $1830
line 4194
;4193:		}
;4194:	}
LABELV $1827
line 4195
;4195:	VectorMA(startPos, distCovered, dir, pos);
ADDRFP4 8
INDIRP4
ADDRGP4 $1815
INDIRF4
ADDRGP4 $1816
INDIRF4
ADDRGP4 $1813
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 $1815+4
INDIRF4
ADDRGP4 $1816+4
INDIRF4
ADDRGP4 $1813
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
ADDRGP4 $1815+8
INDIRF4
ADDRGP4 $1816+8
INDIRF4
ADDRGP4 $1813
INDIRF4
MULF4
ADDF4
ASGNF4
line 4196
;4196:}
LABELV $1812
endproc TautRopePos 32 12
proc CreateGrappleRope 32 8
line 4205
;4197:#endif
;4198:
;4199:/*
;4200:==============
;4201:JUHOX: CreateGrappleRope
;4202:==============
;4203:*/
;4204:#if GRAPPLE_ROPE
;4205:static void CreateGrappleRope(gentity_t* ent) {
line 4209
;4206:	gclient_t* client;
;4207:	int i;
;4208:
;4209:	client = ent->client;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 4211
;4210:
;4211:	for (i = 0; i < client->numRopeElements; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1847
JUMPV
LABELV $1844
line 4215
;4212:		gentity_t* ropeEntity;
;4213:		vec3_t pos;
;4214:
;4215:		ropeEntity = client->ropeEntities[i / 8];
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 8
DIVI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 5504
ADDP4
ADDP4
INDIRP4
ASGNP4
line 4216
;4216:		if (!ropeEntity) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1848
line 4217
;4217:			ropeEntity = G_Spawn();
ADDRLP4 24
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 24
INDIRP4
ASGNP4
line 4218
;4218:			if (!ropeEntity) break;
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1850
ADDRGP4 $1846
JUMPV
LABELV $1850
line 4219
;4219:			client->ropeEntities[i / 8] = ropeEntity;
ADDRLP4 0
INDIRI4
CNSTI4 8
DIVI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 5504
ADDP4
ADDP4
ADDRLP4 8
INDIRP4
ASGNP4
line 4221
;4220:
;4221:			ropeEntity->s.eType = ET_GRAPPLE_ROPE;
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 12
ASGNI4
line 4222
;4222:			ropeEntity->classname = "grapple rope element";
ADDRLP4 8
INDIRP4
CNSTI4 528
ADDP4
ADDRGP4 $1852
ASGNP4
line 4223
;4223:			ropeEntity->r.svFlags = SVF_USE_CURRENT_ORIGIN;
ADDRLP4 8
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 128
ASGNI4
line 4224
;4224:		}
LABELV $1848
line 4225
;4225:		ropeEntity->s.time = 0;
ADDRLP4 8
INDIRP4
CNSTI4 84
ADDP4
CNSTI4 0
ASGNI4
line 4227
;4226:
;4227:		VectorCopy(client->ropeElements[i].pos, pos);
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 4
INDIRP4
CNSTI4 1024
ADDP4
ADDP4
INDIRB
ASGNB 12
line 4229
;4228:
;4229:		switch (i & 7) {
ADDRLP4 24
ADDRLP4 0
INDIRI4
CNSTI4 7
BANDI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
LTI4 $1853
ADDRLP4 24
INDIRI4
CNSTI4 7
GTI4 $1853
ADDRLP4 24
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1864
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1864
address $1856
address $1857
address $1858
address $1859
address $1860
address $1861
address $1862
address $1863
code
LABELV $1856
line 4231
;4230:		case 0:
;4231:			G_SetOrigin(ropeEntity, pos);
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 4232
;4232:			trap_LinkEntity(ropeEntity);
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 4233
;4233:			break;
ADDRGP4 $1854
JUMPV
LABELV $1857
line 4235
;4234:		case 1:
;4235:			VectorCopy(pos, ropeEntity->s.pos.trDelta);
ADDRLP4 8
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 12
INDIRB
ASGNB 12
line 4236
;4236:			break;
ADDRGP4 $1854
JUMPV
LABELV $1858
line 4238
;4237:		case 2:
;4238:			VectorCopy(pos, ropeEntity->s.apos.trBase);
ADDRLP4 8
INDIRP4
CNSTI4 60
ADDP4
ADDRLP4 12
INDIRB
ASGNB 12
line 4239
;4239:			break;
ADDRGP4 $1854
JUMPV
LABELV $1859
line 4241
;4240:		case 3:
;4241:			VectorCopy(pos, ropeEntity->s.apos.trDelta);
ADDRLP4 8
INDIRP4
CNSTI4 72
ADDP4
ADDRLP4 12
INDIRB
ASGNB 12
line 4242
;4242:			break;
ADDRGP4 $1854
JUMPV
LABELV $1860
line 4244
;4243:		case 4:
;4244:			VectorCopy(pos, ropeEntity->s.origin);
ADDRLP4 8
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 12
INDIRB
ASGNB 12
line 4245
;4245:			break;
ADDRGP4 $1854
JUMPV
LABELV $1861
line 4247
;4246:		case 5:
;4247:			VectorCopy(pos, ropeEntity->s.origin2);
ADDRLP4 8
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 12
INDIRB
ASGNB 12
line 4248
;4248:			break;
ADDRGP4 $1854
JUMPV
LABELV $1862
line 4250
;4249:		case 6:
;4250:			VectorCopy(pos, ropeEntity->s.angles);
ADDRLP4 8
INDIRP4
CNSTI4 116
ADDP4
ADDRLP4 12
INDIRB
ASGNB 12
line 4251
;4251:			break;
ADDRGP4 $1854
JUMPV
LABELV $1863
line 4253
;4252:		case 7:
;4253:			VectorCopy(pos, ropeEntity->s.angles2);
ADDRLP4 8
INDIRP4
CNSTI4 128
ADDP4
ADDRLP4 12
INDIRB
ASGNB 12
line 4254
;4254:			break;
LABELV $1853
LABELV $1854
line 4256
;4255:		}
;4256:		ropeEntity->s.modelindex = (i & 7) + 1;
ADDRLP4 8
INDIRP4
CNSTI4 160
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 7
BANDI4
CNSTI4 1
ADDI4
ASGNI4
line 4257
;4257:	}
LABELV $1845
line 4211
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1847
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 1020
ADDP4
INDIRI4
LTI4 $1844
LABELV $1846
line 4260
;4258:
;4259:	// delete unused rope entities
;4260:	for (i = (i+7) / 8; i < MAX_ROPE_ELEMENTS / 8; i++) {
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 7
ADDI4
CNSTI4 8
DIVI4
ASGNI4
ADDRGP4 $1868
JUMPV
LABELV $1865
line 4261
;4261:		if (!client->ropeEntities[i]) continue;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 5504
ADDP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1869
ADDRGP4 $1866
JUMPV
LABELV $1869
line 4263
;4262:
;4263:		G_FreeEntity(client->ropeEntities[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 5504
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 4264
;4264:		client->ropeEntities[i] = NULL;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 5504
ADDP4
ADDP4
CNSTP4 0
ASGNP4
line 4265
;4265:	}
LABELV $1866
line 4260
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1868
ADDRLP4 0
INDIRI4
CNSTI4 20
LTI4 $1865
line 4268
;4266:
;4267:	// chain the rope entities together
;4268:	for (i = 0; i < MAX_ROPE_ELEMENTS / 8; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1871
line 4269
;4269:		if (!client->ropeEntities[i]) continue;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 5504
ADDP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1875
ADDRGP4 $1872
JUMPV
LABELV $1875
line 4271
;4270:
;4271:		if (i <= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GTI4 $1877
line 4272
;4272:			client->ropeEntities[i]->s.otherEntityNum = client->hook->s.number;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 5504
ADDP4
ADDP4
INDIRP4
CNSTI4 140
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 884
ADDP4
INDIRP4
INDIRI4
ASGNI4
line 4273
;4273:		}
ADDRGP4 $1878
JUMPV
LABELV $1877
line 4274
;4274:		else if (client->ropeEntities[i - 1]) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
CNSTI4 4
SUBI4
ADDRLP4 4
INDIRP4
CNSTI4 5504
ADDP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1879
line 4276
;4275:			//client->ropeEntities[i - 1]->s.otherEntityNum2 = client->ropeEntities[i]->s.number;
;4276:			client->ropeEntities[i]->s.otherEntityNum = client->ropeEntities[i - 1]->s.number;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 5504
ADDP4
ADDP4
INDIRP4
CNSTI4 140
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
CNSTI4 4
SUBI4
ADDRLP4 4
INDIRP4
CNSTI4 5504
ADDP4
ADDP4
INDIRP4
INDIRI4
ASGNI4
line 4277
;4277:		}
ADDRGP4 $1880
JUMPV
LABELV $1879
line 4278
;4278:		else {
line 4279
;4279:			client->ropeEntities[i]->s.otherEntityNum = ENTITYNUM_NONE;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 5504
ADDP4
ADDP4
INDIRP4
CNSTI4 140
ADDP4
CNSTI4 1023
ASGNI4
line 4280
;4280:		}
LABELV $1880
LABELV $1878
line 4282
;4281:
;4282:		if (i >= MAX_ROPE_ELEMENTS / 8 - 1) {
ADDRLP4 0
INDIRI4
CNSTI4 19
LTI4 $1881
line 4283
;4283:			client->ropeEntities[i]->s.otherEntityNum2 = ent->s.number;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 5504
ADDP4
ADDP4
INDIRP4
CNSTI4 144
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 4284
;4284:		}
ADDRGP4 $1882
JUMPV
LABELV $1881
line 4285
;4285:		else {
line 4286
;4286:			client->ropeEntities[i]->s.otherEntityNum2 = ENTITYNUM_NONE;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 5504
ADDP4
ADDP4
INDIRP4
CNSTI4 144
ADDP4
CNSTI4 1023
ASGNI4
line 4287
;4287:		}
LABELV $1882
line 4288
;4288:	}
LABELV $1872
line 4268
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 20
LTI4 $1871
line 4289
;4289:}
LABELV $1843
endproc CreateGrappleRope 32 8
proc InsertRopeElement 64 16
line 4298
;4290:#endif
;4291:
;4292:/*
;4293:==============
;4294:JUHOX: InsertRopeElement
;4295:==============
;4296:*/
;4297:#if GRAPPLE_ROPE
;4298:static qboolean InsertRopeElement(gclient_t* client, int index, const vec3_t pos) {
line 4305
;4299:	int i;
;4300:	vec3_t predPos;
;4301:	vec3_t predVel;
;4302:	vec3_t succPos;
;4303:	ropeElement_t* re;
;4304:
;4305:	if (client->numRopeElements >= MAX_ROPE_ELEMENTS) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 1020
ADDP4
INDIRI4
CNSTI4 160
LTI4 $1884
CNSTI4 0
RETI4
ADDRGP4 $1883
JUMPV
LABELV $1884
line 4307
;4306:
;4307:	for (i = client->numRopeElements-1; i >= index; i--) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1020
ADDP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRGP4 $1889
JUMPV
LABELV $1886
line 4308
;4308:		client->ropeElements[i+1] = client->ropeElements[i];
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 48
INDIRP4
CNSTI4 1052
ADDP4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 48
INDIRP4
CNSTI4 1024
ADDP4
ADDP4
INDIRB
ASGNB 28
line 4309
;4309:	}
LABELV $1887
line 4307
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $1889
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRI4
GEI4 $1886
line 4310
;4310:	client->numRopeElements++;
ADDRLP4 44
ADDRFP4 0
INDIRP4
CNSTI4 1020
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4312
;4311:
;4312:	if (index > 0) {
ADDRFP4 4
INDIRI4
CNSTI4 0
LEI4 $1890
line 4313
;4313:		VectorCopy(client->ropeElements[index-1].pos, predPos);
ADDRLP4 8
ADDRFP4 4
INDIRI4
CNSTI4 28
MULI4
CNSTI4 28
SUBI4
ADDRFP4 0
INDIRP4
CNSTI4 1024
ADDP4
ADDP4
INDIRB
ASGNB 12
line 4314
;4314:		VectorCopy(client->ropeElements[index-1].velocity, predVel);
ADDRLP4 32
ADDRFP4 4
INDIRI4
CNSTI4 28
MULI4
CNSTI4 28
SUBI4
ADDRFP4 0
INDIRP4
CNSTI4 1024
ADDP4
ADDP4
CNSTI4 12
ADDP4
INDIRB
ASGNB 12
line 4315
;4315:	}
ADDRGP4 $1891
JUMPV
LABELV $1890
line 4316
;4316:	else {
line 4317
;4317:		VectorCopy(client->hook->r.currentOrigin, predPos);
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 884
ADDP4
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 4318
;4318:		BG_EvaluateTrajectoryDelta(&client->hook->s.pos, level.time, predVel);
ADDRFP4 0
INDIRP4
CNSTI4 884
ADDP4
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 level+32
INDIRI4
ARGI4
ADDRLP4 32
ARGP4
ADDRGP4 BG_EvaluateTrajectoryDelta
CALLV
pop
line 4319
;4319:	}
LABELV $1891
line 4321
;4320:
;4321:	if (index < client->numRopeElements-1) {
ADDRFP4 4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 1020
ADDP4
INDIRI4
CNSTI4 1
SUBI4
GEI4 $1893
line 4322
;4322:		VectorCopy(client->ropeElements[index+1].pos, succPos);
ADDRLP4 20
ADDRFP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 1052
ADDP4
ADDP4
INDIRB
ASGNB 12
line 4323
;4323:	}
ADDRGP4 $1894
JUMPV
LABELV $1893
line 4324
;4324:	else {
line 4325
;4325:		VectorCopy(client->ps.origin, succPos);
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 4326
;4326:	}
LABELV $1894
line 4328
;4327:
;4328:	re = &client->ropeElements[index];
ADDRLP4 4
ADDRFP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 1024
ADDP4
ADDP4
ASGNP4
line 4330
;4329:
;4330:	if (DistanceSquared(pos, predPos) < DistanceSquared(pos, succPos)) {
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 48
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 52
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 48
INDIRF4
ADDRLP4 52
INDIRF4
GEF4 $1895
line 4331
;4331:		if (!MoveRopeElement(predPos, pos, re->pos, &re->touch)) return qfalse;
ADDRLP4 8
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 60
ADDRGP4 MoveRopeElement
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
NEI4 $1896
CNSTI4 0
RETI4
ADDRGP4 $1883
JUMPV
line 4332
;4332:	}
LABELV $1895
line 4333
;4333:	else {
line 4334
;4334:		if (!MoveRopeElement(succPos, pos, re->pos, &re->touch)) return qfalse;
ADDRLP4 20
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 60
ADDRGP4 MoveRopeElement
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
NEI4 $1899
CNSTI4 0
RETI4
ADDRGP4 $1883
JUMPV
LABELV $1899
line 4335
;4335:	}
LABELV $1896
line 4336
;4336:	VectorCopy(predVel, re->velocity);
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 32
INDIRB
ASGNB 12
line 4337
;4337:	return qtrue;
CNSTI4 1
RETI4
LABELV $1883
endproc InsertRopeElement 64 16
proc ThinkGrapple 172 28
line 4347
;4338:}
;4339:#endif
;4340:
;4341:/*
;4342:==============
;4343:JUHOX: ThinkGrapple
;4344:==============
;4345:*/
;4346:#if GRAPPLE_ROPE
;4347:static void ThinkGrapple(gentity_t* ent, int msec) {
line 4359
;4348:	float dt;
;4349:	gclient_t* client;
;4350:	int i;
;4351:	int n;
;4352:	vec3_t pullpoint;
;4353:	vec3_t start;
;4354:	vec3_t dir;
;4355:	float dist;
;4356:	qboolean autoCut;
;4357:	float pullSpeed;
;4358:
;4359:	if (g_grapple.integer <= HM_disabled || g_grapple.integer >= HM_num_modes) return;
ADDRGP4 g_grapple+12
INDIRI4
CNSTI4 0
LEI4 $1906
ADDRGP4 g_grapple+12
INDIRI4
CNSTI4 5
LTI4 $1902
LABELV $1906
ADDRGP4 $1901
JUMPV
LABELV $1902
line 4361
;4360:
;4361:	client = ent->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 4363
;4362:
;4363:	if (g_grapple.integer == HM_classic) {
ADDRGP4 g_grapple+12
INDIRI4
CNSTI4 1
NEI4 $1907
line 4365
;4364:		if (
;4365:			client->ps.weapon == WP_GRAPPLING_HOOK &&
ADDRLP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 10
NEI4 $1910
ADDRLP4 0
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1910
ADDRLP4 0
INDIRP4
CNSTI4 884
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1910
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $1910
line 4369
;4366:			!client->offHandHook &&
;4367:			client->hook &&
;4368:			!(client->pers.cmd.buttons & BUTTON_ATTACK)
;4369:		) {
line 4370
;4370:			Weapon_HookFree(client->hook);
ADDRLP4 0
INDIRP4
CNSTI4 884
ADDP4
INDIRP4
ARGP4
ADDRGP4 Weapon_HookFree
CALLV
pop
line 4371
;4371:			return;
ADDRGP4 $1901
JUMPV
LABELV $1910
line 4374
;4372:		}
;4373:
;4374:		if (!client->hook) return;
ADDRLP4 0
INDIRP4
CNSTI4 884
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1912
ADDRGP4 $1901
JUMPV
LABELV $1912
line 4376
;4375:
;4376:		if (client->hook->s.eType != ET_GRAPPLE) {
ADDRLP4 0
INDIRP4
CNSTI4 884
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 11
EQI4 $1914
line 4377
;4377:			client->ps.stats[STAT_GRAPPLE_STATE] = GST_windoff;
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
CNSTI4 3
ASGNI4
line 4378
;4378:		}
ADDRGP4 $1901
JUMPV
LABELV $1914
line 4380
;4379:		else if (
;4380:			VectorLengthSquared(client->ps.velocity) > 160*160 &&
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 68
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 68
INDIRF4
CNSTF4 1187512320
LEF4 $1916
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
NEI4 $1916
line 4382
;4381:			(client->ps.pm_flags & PMF_TIME_KNOCKBACK) == 0
;4382:		) {
line 4383
;4383:			client->ps.stats[STAT_GRAPPLE_STATE] = GST_pulling;
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
CNSTI4 5
ASGNI4
line 4384
;4384:		}
ADDRGP4 $1901
JUMPV
LABELV $1916
line 4385
;4385:		else {
line 4386
;4386:			client->ps.stats[STAT_GRAPPLE_STATE] = GST_silent;
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
CNSTI4 1
ASGNI4
line 4387
;4387:		}
line 4388
;4388:		return;
ADDRGP4 $1901
JUMPV
LABELV $1907
line 4392
;4389:	}
;4390:
;4391:	if (
;4392:		client->hook &&
ADDRLP4 0
INDIRP4
CNSTI4 884
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1918
ADDRLP4 0
INDIRP4
CNSTI4 495
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $1918
ADDRLP4 0
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1918
line 4395
;4393:		client->pers.cmd.upmove < 0 &&
;4394:		client->pers.crouchingCutsRope
;4395:	) {
line 4396
;4396:		Weapon_HookFree(client->hook);
ADDRLP4 0
INDIRP4
CNSTI4 884
ADDP4
INDIRP4
ARGP4
ADDRGP4 Weapon_HookFree
CALLV
pop
line 4397
;4397:		return;
ADDRGP4 $1901
JUMPV
LABELV $1918
line 4400
;4398:	}
;4399:
;4400:	client->ps.pm_flags &= ~PMF_GRAPPLE_PULL;
ADDRLP4 68
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRI4
CNSTI4 -2049
BANDI4
ASGNI4
line 4401
;4401:	client->ps.stats[STAT_GRAPPLE_STATE] = GST_unused;
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
CNSTI4 0
ASGNI4
line 4402
;4402:	if (!client->hook) return;
ADDRLP4 0
INDIRP4
CNSTI4 884
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1920
ADDRGP4 $1901
JUMPV
LABELV $1920
line 4404
;4403:
;4404:	switch (g_grapple.integer) {
ADDRLP4 72
ADDRGP4 g_grapple+12
INDIRI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 2
EQI4 $1925
ADDRLP4 72
INDIRI4
CNSTI4 3
EQI4 $1926
ADDRLP4 72
INDIRI4
CNSTI4 4
EQI4 $1927
ADDRGP4 $1922
JUMPV
LABELV $1925
LABELV $1922
line 4407
;4405:	case HM_tool:
;4406:	default:
;4407:		autoCut = qtrue;
ADDRLP4 60
CNSTI4 1
ASGNI4
line 4408
;4408:		pullSpeed = GRAPPLE_PULL_SPEED_TOOL;
ADDRLP4 56
CNSTF4 1137180672
ASGNF4
line 4409
;4409:		break;
ADDRGP4 $1923
JUMPV
LABELV $1926
line 4411
;4410:	case HM_anchor:
;4411:		autoCut = qfalse;
ADDRLP4 60
CNSTI4 0
ASGNI4
line 4412
;4412:		pullSpeed = GRAPPLE_PULL_SPEED_ANCHOR;
ADDRLP4 56
CNSTF4 1137180672
ASGNF4
line 4413
;4413:		break;
ADDRGP4 $1923
JUMPV
LABELV $1927
line 4415
;4414:	case HM_combat:
;4415:		autoCut = qfalse;
ADDRLP4 60
CNSTI4 0
ASGNI4
line 4416
;4416:		pullSpeed = GRAPPLE_PULL_SPEED_COMBAT;
ADDRLP4 56
CNSTF4 1145569280
ASGNF4
line 4417
;4417:		break;
LABELV $1923
line 4421
;4418:	}
;4419:
;4420:	if (
;4421:		client->hook->s.eType == ET_GRAPPLE &&
ADDRLP4 0
INDIRP4
CNSTI4 884
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 11
NEI4 $1928
ADDRLP4 0
INDIRP4
CNSTI4 1020
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1930
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 884
ADDP4
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 80
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 80
INDIRF4
CNSTF4 1153957888
GEF4 $1928
LABELV $1930
line 4426
;4422:		(
;4423:			client->numRopeElements <= 0 ||
;4424:			DistanceSquared(client->ps.origin, client->hook->r.currentOrigin) < 40*40
;4425:		)
;4426:	) {
line 4427
;4427:		client->numRopeElements = 0;	// no rope explosion
ADDRLP4 0
INDIRP4
CNSTI4 1020
ADDP4
CNSTI4 0
ASGNI4
line 4428
;4428:		if (autoCut) {
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $1931
line 4429
;4429:			Weapon_HookFree(client->hook);
ADDRLP4 0
INDIRP4
CNSTI4 884
ADDP4
INDIRP4
ARGP4
ADDRGP4 Weapon_HookFree
CALLV
pop
line 4430
;4430:			return;
ADDRGP4 $1901
JUMPV
LABELV $1931
line 4433
;4431:		}
;4432:		else if (
;4433:			VectorLengthSquared(client->ps.velocity) > 160*160 &&
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 84
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 84
INDIRF4
CNSTF4 1187512320
LEF4 $1933
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
NEI4 $1933
line 4435
;4434:			(client->ps.pm_flags & PMF_TIME_KNOCKBACK) == 0
;4435:		) {
line 4436
;4436:			client->ps.stats[STAT_GRAPPLE_STATE] = GST_pulling;
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
CNSTI4 5
ASGNI4
line 4437
;4437:		}
ADDRGP4 $1934
JUMPV
LABELV $1933
line 4438
;4438:		else {
line 4439
;4439:			client->ps.stats[STAT_GRAPPLE_STATE] = GST_silent;
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
CNSTI4 1
ASGNI4
line 4440
;4440:		}
LABELV $1934
line 4441
;4441:		VectorCopy(client->hook->r.currentOrigin, client->ps.grapplePoint);
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 884
ADDP4
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 4442
;4442:		client->ps.pm_flags |= PMF_GRAPPLE_PULL;
ADDRLP4 92
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
line 4443
;4443:		goto CreateRope;
ADDRGP4 $1935
JUMPV
LABELV $1928
line 4446
;4444:	}
;4445:
;4446:	dt = msec / 1000.0;
ADDRLP4 12
ADDRFP4 4
INDIRI4
CVIF4 4
CNSTF4 981668463
MULF4
ASGNF4
line 4448
;4447:
;4448:	for (i = client->numRopeElements - 1; i >= 0; i--) {
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 1020
ADDP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRGP4 $1939
JUMPV
LABELV $1936
line 4449
;4449:		if (!ThinkRopeElement(client, i, 0, dt / 2)) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 12
INDIRF4
CNSTF4 1056964608
MULF4
ARGF4
ADDRLP4 84
ADDRGP4 ThinkRopeElement
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
NEI4 $1940
line 4450
;4450:			Weapon_HookFree(client->hook);
ADDRLP4 0
INDIRP4
CNSTI4 884
ADDP4
INDIRP4
ARGP4
ADDRGP4 Weapon_HookFree
CALLV
pop
line 4451
;4451:			return;
ADDRGP4 $1901
JUMPV
LABELV $1940
line 4453
;4452:		}
;4453:	}
LABELV $1937
line 4448
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $1939
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $1936
line 4455
;4454:
;4455:	VectorCopy(client->hook->r.currentOrigin, pullpoint);
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 884
ADDP4
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 4456
;4456:	n = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 4457
;4457:	for (i = 0; i < client->numRopeElements; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $1945
JUMPV
LABELV $1942
line 4458
;4458:		if (!ThinkRopeElement(client, i, 1, dt / 2)) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 12
INDIRF4
CNSTF4 1056964608
MULF4
ARGF4
ADDRLP4 84
ADDRGP4 ThinkRopeElement
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
NEI4 $1946
line 4459
;4459:			Weapon_HookFree(client->hook);
ADDRLP4 0
INDIRP4
CNSTI4 884
ADDP4
INDIRP4
ARGP4
ADDRGP4 Weapon_HookFree
CALLV
pop
line 4460
;4460:			return;
ADDRGP4 $1901
JUMPV
LABELV $1946
line 4462
;4461:		}
;4462:		if (client->ropeElements[i].touch) {
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
ADDP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1948
line 4463
;4463:			VectorCopy(client->ropeElements[i].pos, pullpoint);
ADDRLP4 32
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
ADDP4
INDIRB
ASGNB 12
line 4464
;4464:			n = i;
ADDRLP4 8
ADDRLP4 4
INDIRI4
ASGNI4
line 4465
;4465:		}
LABELV $1948
line 4466
;4466:	}
LABELV $1943
line 4457
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1945
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 1020
ADDP4
INDIRI4
LTI4 $1942
line 4478
;4467:
;4468:	/*
;4469:	{
;4470:		int m;
;4471:
;4472:		m = client->numRopeElements - 1;
;4473:		if (m < n) m = n;
;4474:		VectorCopy(client->ropeElements[m].pos, pullpoint);
;4475:	}
;4476:	*/
;4477:
;4478:	VectorCopy(client->ropeElements[client->numRopeElements-1].pos, start);
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 1020
ADDP4
INDIRI4
CNSTI4 28
MULI4
CNSTI4 28
SUBI4
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
ADDP4
INDIRB
ASGNB 12
line 4479
;4479:	VectorSubtract(client->ps.origin, start, dir);
ADDRLP4 44
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
SUBF4
ASGNF4
ADDRLP4 44+4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 16+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 44+8
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 16+8
INDIRF4
SUBF4
ASGNF4
line 4480
;4480:	dist = VectorNormalize(dir);
ADDRLP4 44
ARGP4
ADDRLP4 92
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 92
INDIRF4
ASGNF4
line 4482
;4481:
;4482:	if (client->hook->s.eType == ET_GRAPPLE) {
ADDRLP4 0
INDIRP4
CNSTI4 884
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 11
NEI4 $1954
line 4486
;4483:		// hook is attached to wall
;4484:		qboolean isRopeTaut;
;4485:
;4486:		isRopeTaut = IsRopeTaut(ent, client->ropeIsTaut);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 5584
ADDP4
INDIRI4
ARGI4
ADDRLP4 100
ADDRGP4 IsRopeTaut
CALLI4
ASGNI4
ADDRLP4 96
ADDRLP4 100
INDIRI4
ASGNI4
line 4487
;4487:		client->ropeIsTaut = isRopeTaut;
ADDRLP4 0
INDIRP4
CNSTI4 5584
ADDP4
ADDRLP4 96
INDIRI4
ASGNI4
line 4520
;4488:		/*
;4489:		if (client->pers.cmd.buttons & BUTTON_GESTURE) {	// JUHOX DEBUG
;4490:			// fixed
;4491:			vec3_t v;
;4492:			float s;
;4493:
;4494:			client->ps.stats[STAT_GRAPPLE_STATE] = GST_fixed;
;4495:			if (client->numRopeElements > 0) {
;4496:				VectorCopy(client->ropeElements[client->numRopeElements-1].pos, pullpoint);
;4497:			}
;4498:			VectorCopy(pullpoint, client->ps.grapplePoint);
;4499:			client->ps.pm_flags |= PMF_GRAPPLE_PULL;
;4500:
;4501:			VectorCopy(client->ps.velocity, v);
;4502:			s = VectorNormalize(v);
;4503:			for (i = 1; i < client->numRopeElements; i++) {
;4504:				ropeElement_t* re;
;4505:				vec3_t vel;
;4506:				float speed;
;4507:				float oldspeed;
;4508:				float totalspeed;
;4509:
;4510:				re = &client->ropeElements[i];
;4511:				speed = (s * i) / client->numRopeElements;
;4512:				oldspeed = VectorLength(re->velocity);
;4513:				totalspeed = speed + oldspeed;
;4514:				VectorScale(v, speed * speed / totalspeed, vel);
;4515:				VectorMA(vel, oldspeed / totalspeed, re->velocity, re->velocity);
;4516:			}
;4517:			goto CreateRope;
;4518:		}
;4519:		else*/
;4520:		if (client->lastTimeWinded < level.time - 250) {
ADDRLP4 0
INDIRP4
CNSTI4 5588
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 250
SUBI4
GEI4 $1956
line 4522
;4521:			// blocked
;4522:			client->ps.stats[STAT_GRAPPLE_STATE] = GST_blocked;
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
CNSTI4 6
ASGNI4
line 4523
;4523:			VectorCopy(pullpoint, client->ps.grapplePoint);
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 32
INDIRB
ASGNB 12
line 4524
;4524:			client->ps.pm_flags |= PMF_GRAPPLE_PULL;
ADDRLP4 104
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 104
INDIRP4
ADDRLP4 104
INDIRP4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
line 4526
;4525:
;4526:			{
line 4530
;4527:				vec3_t v;
;4528:				float speed;
;4529:
;4530:				v[0] = crandom();
ADDRLP4 124
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 108
ADDRLP4 124
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 124
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
ASGNF4
line 4531
;4531:				v[1] = crandom();
ADDRLP4 128
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 108+4
ADDRLP4 128
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 128
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
ASGNF4
line 4532
;4532:				v[2] = crandom();
ADDRLP4 132
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 108+8
ADDRLP4 132
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 132
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
ASGNF4
line 4533
;4533:				speed = 0.5 * ((level.time - client->lastTimeWinded) / 1000.0);
ADDRLP4 120
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 5588
ADDP4
INDIRI4
SUBI4
CVIF4 4
CNSTF4 981668463
MULF4
CNSTF4 1056964608
MULF4
ASGNF4
line 4534
;4534:				if (speed > 2) speed = 2;
ADDRLP4 120
INDIRF4
CNSTF4 1073741824
LEF4 $1962
ADDRLP4 120
CNSTF4 1073741824
ASGNF4
LABELV $1962
line 4535
;4535:				VectorMA(client->ps.velocity, 400 * speed, v, client->ps.velocity);
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 108
INDIRF4
ADDRLP4 120
INDIRF4
CNSTF4 1137180672
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 108+4
INDIRF4
ADDRLP4 120
INDIRF4
CNSTF4 1137180672
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 108+8
INDIRF4
ADDRLP4 120
INDIRF4
CNSTF4 1137180672
MULF4
MULF4
ADDF4
ASGNF4
line 4536
;4536:			}
line 4537
;4537:		}
ADDRGP4 $1957
JUMPV
LABELV $1956
line 4538
;4538:		else if (isRopeTaut) {
ADDRLP4 96
INDIRI4
CNSTI4 0
EQI4 $1966
line 4540
;4539:			// pulling
;4540:			client->ps.stats[STAT_GRAPPLE_STATE] = GST_pulling;
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
CNSTI4 5
ASGNI4
line 4541
;4541:			VectorCopy(pullpoint, client->ps.grapplePoint);
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 32
INDIRB
ASGNB 12
line 4542
;4542:			client->ps.pm_flags |= PMF_GRAPPLE_PULL;
ADDRLP4 104
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 104
INDIRP4
ADDRLP4 104
INDIRP4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
line 4543
;4543:		}
ADDRGP4 $1967
JUMPV
LABELV $1966
line 4544
;4544:		else {
line 4546
;4545:			// winding
;4546:			client->ps.stats[STAT_GRAPPLE_STATE] = GST_rewind;
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
CNSTI4 4
ASGNI4
line 4547
;4547:		}
LABELV $1967
LABELV $1957
line 4549
;4548:
;4549:		{
line 4550
;4550:			TautRopePos(client, -1, NULL);
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 TautRopePos
CALLV
pop
line 4551
;4551:			for (i = 0; i < client->numRopeElements; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $1971
JUMPV
LABELV $1968
line 4560
;4552:				ropeElement_t* re;
;4553:				vec3_t dest;
;4554:				vec3_t v;
;4555:				float f;
;4556:				//float speed;
;4557:				//float oldspeed;
;4558:				//float totalspeed;
;4559:
;4560:				re = &client->ropeElements[i];
ADDRLP4 120
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
ADDP4
ASGNP4
line 4561
;4561:				TautRopePos(client, i, dest);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 124
ARGP4
ADDRGP4 TautRopePos
CALLV
pop
line 4562
;4562:				VectorSubtract(dest, re->pos, v);
ADDRLP4 104
ADDRLP4 124
INDIRF4
ADDRLP4 120
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 104+4
ADDRLP4 124+4
INDIRF4
ADDRLP4 120
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 104+8
ADDRLP4 124+8
INDIRF4
ADDRLP4 120
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 4563
;4563:				VectorScale(v, 16, v);
ADDRLP4 104
ADDRLP4 104
INDIRF4
CNSTF4 1098907648
MULF4
ASGNF4
ADDRLP4 104+4
ADDRLP4 104+4
INDIRF4
CNSTF4 1098907648
MULF4
ASGNF4
ADDRLP4 104+8
ADDRLP4 104+8
INDIRF4
CNSTF4 1098907648
MULF4
ASGNF4
line 4564
;4564:				f = (float)i / client->numRopeElements;
ADDRLP4 116
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRLP4 0
INDIRP4
CNSTI4 1020
ADDP4
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 4565
;4565:				VectorMA(v, Square(f), client->ps.velocity, v);
ADDRLP4 148
ADDRLP4 116
INDIRF4
ADDRLP4 116
INDIRF4
MULF4
ASGNF4
ADDRLP4 104
ADDRLP4 104
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 104+4
ADDRLP4 104+4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 104+8
ADDRLP4 104+8
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 116
INDIRF4
ADDRLP4 116
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 4578
;4566:				//speed = VectorNormalize(v);
;4567:
;4568:				/*
;4569:				oldspeed = VectorLength(re->velocity);
;4570:				totalspeed = speed + oldspeed;
;4571:				VectorScale(v, speed * speed / totalspeed, v);
;4572:				VectorMA(v, oldspeed / totalspeed, re->velocity, re->velocity);
;4573:				*/
;4574:				/*
;4575:				VectorAdd(re->velocity, v, v);
;4576:				VectorScale(v, 0.5, re->velocity);
;4577:				*/
;4578:				VectorCopy(v, re->velocity);
ADDRLP4 120
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 104
INDIRB
ASGNB 12
line 4579
;4579:			}
LABELV $1969
line 4551
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1971
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 1020
ADDP4
INDIRI4
LTI4 $1968
line 4580
;4580:		}
ADDRGP4 $1985
JUMPV
LABELV $1984
line 4582
;4581:
;4582:		while (dist < ROPE_ELEMENT_SIZE) {
line 4585
;4583:			trace_t trace;
;4584:
;4585:			trap_Trace(&trace, start, NULL, NULL, client->ps.origin, -1, CONTENTS_SOLID);
ADDRLP4 104
ARGP4
ADDRLP4 16
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 4586
;4586:			if (trace.startsolid || trace.allsolid || trace.fraction < 1) {
ADDRLP4 104+4
INDIRI4
CNSTI4 0
NEI4 $1992
ADDRLP4 104
INDIRI4
CNSTI4 0
NEI4 $1992
ADDRLP4 104+8
INDIRF4
CNSTF4 1065353216
GEF4 $1987
LABELV $1992
line 4587
;4587:				VectorCopy(pullpoint, client->ps.grapplePoint);
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 32
INDIRB
ASGNB 12
line 4588
;4588:				client->ps.pm_flags |= PMF_GRAPPLE_PULL;
ADDRLP4 160
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 160
INDIRP4
ADDRLP4 160
INDIRP4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
line 4589
;4589:				client->ps.stats[STAT_GRAPPLE_STATE] = GST_pulling;
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
CNSTI4 5
ASGNI4
line 4590
;4590:				goto CreateRope;
ADDRGP4 $1935
JUMPV
LABELV $1987
line 4593
;4591:			}
;4592:
;4593:			client->lastTimeWinded = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 5588
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 4594
;4594:			client->numRopeElements--;
ADDRLP4 160
ADDRLP4 0
INDIRP4
CNSTI4 1020
ADDP4
ASGNP4
ADDRLP4 160
INDIRP4
ADDRLP4 160
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 4595
;4595:			if (client->numRopeElements <= 0) {
ADDRLP4 0
INDIRP4
CNSTI4 1020
ADDP4
INDIRI4
CNSTI4 0
GTI4 $1994
line 4600
;4596:				/*
;4597:				Weapon_HookFree(client->hook);
;4598:				return;
;4599:				*/
;4600:				goto CreateRope;
ADDRGP4 $1935
JUMPV
LABELV $1994
line 4603
;4601:			}
;4602:
;4603:			VectorCopy(client->ropeElements[client->numRopeElements-1].pos, start);
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 1020
ADDP4
INDIRI4
CNSTI4 28
MULI4
CNSTI4 28
SUBI4
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
ADDP4
INDIRB
ASGNB 12
line 4604
;4604:			dist = Distance(start, client->ps.origin);
ADDRLP4 16
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 168
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 168
INDIRF4
ASGNF4
line 4605
;4605:		}
LABELV $1985
line 4582
ADDRLP4 28
INDIRF4
CNSTF4 1092616192
LTF4 $1984
line 4606
;4606:	}
ADDRGP4 $1955
JUMPV
LABELV $1954
line 4607
;4607:	else {
line 4610
;4608:		// hook is flying
;4609:
;4610:		client->ps.stats[STAT_GRAPPLE_STATE] = GST_windoff;
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
CNSTI4 3
ASGNI4
line 4611
;4611:		client->ropeIsTaut = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 5584
ADDP4
CNSTI4 0
ASGNI4
line 4612
;4612:		client->lastTimeWinded = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 5588
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 4636
;4613:		/*
;4614:		if (dist > 2 * ROPE_ELEMENT_SIZE) {
;4615:			int n;
;4616:
;4617:			n = (int) ((dist - ROPE_ELEMENT_SIZE) / ROPE_ELEMENT_SIZE);
;4618:			if (client->numRopeElements + n >= MAX_ROPE_ELEMENTS) {
;4619:				Weapon_HookFree(client->hook);
;4620:				return;
;4621:			}
;4622:
;4623:			for (i = 0; i < n; i++) {
;4624:				vec3_t pos;
;4625:
;4626:				VectorMA(start, (i+1) * ROPE_ELEMENT_SIZE, dir, pos);
;4627:				VectorCopy(pos, client->ropeElements[client->numRopeElements].pos);
;4628:				VectorCopy(
;4629:					client->ropeElements[client->numRopeElements-1].velocity,
;4630:					client->ropeElements[client->numRopeElements].velocity
;4631:				);
;4632:				client->numRopeElements++;
;4633:			}
;4634:		}
;4635:		*/
;4636:		{
line 4639
;4637:			vec3_t prevPos;
;4638:
;4639:			VectorCopy(client->hook->r.currentOrigin, prevPos);
ADDRLP4 96
ADDRLP4 0
INDIRP4
CNSTI4 884
ADDP4
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 4640
;4640:			for (i = 0; i <= client->numRopeElements; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $2000
JUMPV
LABELV $1997
line 4646
;4641:				vec3_t dir;
;4642:				float dist;
;4643:				float maxdist;
;4644:				vec3_t destPos;
;4645:
;4646:				if (i < client->numRopeElements) {
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 1020
ADDP4
INDIRI4
GEI4 $2001
line 4647
;4647:					VectorCopy(client->ropeElements[i].pos, destPos);
ADDRLP4 120
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
ADDP4
INDIRB
ASGNB 12
line 4648
;4648:					maxdist = 1.7 * ROPE_ELEMENT_SIZE;
ADDRLP4 136
CNSTF4 1099431936
ASGNF4
line 4649
;4649:				}
ADDRGP4 $2002
JUMPV
LABELV $2001
line 4650
;4650:				else {
line 4651
;4651:					VectorCopy(client->ps.origin, destPos);
ADDRLP4 120
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 4652
;4652:					maxdist = 1.2 * ROPE_ELEMENT_SIZE;
ADDRLP4 136
CNSTF4 1094713344
ASGNF4
line 4653
;4653:				}
LABELV $2002
line 4655
;4654:
;4655:				VectorSubtract(destPos, prevPos, dir);
ADDRLP4 108
ADDRLP4 120
INDIRF4
ADDRLP4 96
INDIRF4
SUBF4
ASGNF4
ADDRLP4 108+4
ADDRLP4 120+4
INDIRF4
ADDRLP4 96+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 108+8
ADDRLP4 120+8
INDIRF4
ADDRLP4 96+8
INDIRF4
SUBF4
ASGNF4
line 4656
;4656:				dist = VectorLength(dir);
ADDRLP4 108
ARGP4
ADDRLP4 140
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 132
ADDRLP4 140
INDIRF4
ASGNF4
line 4657
;4657:				if (dist > maxdist) {
ADDRLP4 132
INDIRF4
ADDRLP4 136
INDIRF4
LEF4 $2009
line 4660
;4658:					int j;
;4659:
;4660:					n = (int) ((dist - ROPE_ELEMENT_SIZE) / ROPE_ELEMENT_SIZE) + 1;
ADDRLP4 8
ADDRLP4 132
INDIRF4
CNSTF4 1092616192
SUBF4
CNSTF4 1036831949
MULF4
CVFI4 4
CNSTI4 1
ADDI4
ASGNI4
line 4661
;4661:					for (j = 0; j < n; j++) {
ADDRLP4 144
CNSTI4 0
ASGNI4
ADDRGP4 $2014
JUMPV
LABELV $2011
line 4664
;4662:						vec3_t pos;
;4663:
;4664:						VectorMA(prevPos, (float)(j+1) / (n+1), dir, pos);
ADDRLP4 148
ADDRLP4 96
INDIRF4
ADDRLP4 108
INDIRF4
ADDRLP4 144
INDIRI4
CNSTI4 1
ADDI4
CVIF4 4
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
CVIF4 4
DIVF4
MULF4
ADDF4
ASGNF4
ADDRLP4 148+4
ADDRLP4 96+4
INDIRF4
ADDRLP4 108+4
INDIRF4
ADDRLP4 144
INDIRI4
CNSTI4 1
ADDI4
CVIF4 4
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
CVIF4 4
DIVF4
MULF4
ADDF4
ASGNF4
ADDRLP4 148+8
ADDRLP4 96+8
INDIRF4
ADDRLP4 108+8
INDIRF4
ADDRLP4 144
INDIRI4
CNSTI4 1
ADDI4
CVIF4 4
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
CVIF4 4
DIVF4
MULF4
ADDF4
ASGNF4
line 4665
;4665:						if (!InsertRopeElement(client, i + j, pos)) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ADDRLP4 144
INDIRI4
ADDI4
ARGI4
ADDRLP4 148
ARGP4
ADDRLP4 168
ADDRGP4 InsertRopeElement
CALLI4
ASGNI4
ADDRLP4 168
INDIRI4
CNSTI4 0
NEI4 $2021
line 4666
;4666:							Weapon_HookFree(client->hook);
ADDRLP4 0
INDIRP4
CNSTI4 884
ADDP4
INDIRP4
ARGP4
ADDRGP4 Weapon_HookFree
CALLV
pop
line 4667
;4667:							return;
ADDRGP4 $1901
JUMPV
LABELV $2021
line 4669
;4668:						}
;4669:					}
LABELV $2012
line 4661
ADDRLP4 144
ADDRLP4 144
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2014
ADDRLP4 144
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $2011
line 4670
;4670:					i += n;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
ADDI4
ASGNI4
line 4671
;4671:				}
LABELV $2009
line 4672
;4672:				VectorCopy(destPos, prevPos);
ADDRLP4 96
ADDRLP4 120
INDIRB
ASGNB 12
line 4673
;4673:			}
LABELV $1998
line 4640
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2000
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 1020
ADDP4
INDIRI4
LEI4 $1997
line 4675
;4674:
;4675:		}
line 4676
;4676:	}
LABELV $1955
LABELV $1935
line 4680
;4677:
;4678:	CreateRope:
;4679:
;4680:	dist = Distance(client->ps.origin, client->hook->r.currentOrigin);
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 884
ADDP4
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 100
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 100
INDIRF4
ASGNF4
line 4681
;4681:	if (dist < 200) {
ADDRLP4 28
INDIRF4
CNSTF4 1128792064
GEF4 $2023
line 4682
;4682:		if (dist < 40) dist = 40;
ADDRLP4 28
INDIRF4
CNSTF4 1109393408
GEF4 $2025
ADDRLP4 28
CNSTF4 1109393408
ASGNF4
LABELV $2025
line 4683
;4683:		pullSpeed *= dist / 200;
ADDRLP4 56
ADDRLP4 56
INDIRF4
ADDRLP4 28
INDIRF4
CNSTF4 1000593162
MULF4
MULF4
ASGNF4
line 4684
;4684:	}
LABELV $2023
line 4685
;4685:	client->ps.stats[STAT_GRAPPLE_SPEED] = pullSpeed;
ADDRLP4 0
INDIRP4
CNSTI4 232
ADDP4
ADDRLP4 56
INDIRF4
CVFI4 4
ASGNI4
line 4687
;4686:
;4687:	CreateGrappleRope(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CreateGrappleRope
CALLV
pop
line 4688
;4688:}
LABELV $1901
endproc ThinkGrapple 172 28
export SendPendingPredictableEvents
proc SendPendingPredictableEvents 40 12
line 4698
;4689:#endif
;4690:
;4691:void BotTestSolid(vec3_t origin);
;4692:
;4693:/*
;4694:==============
;4695:SendPendingPredictableEvents
;4696:==============
;4697:*/
;4698:void SendPendingPredictableEvents( playerState_t *ps ) {
line 4704
;4699:	gentity_t *t;
;4700:	int event, seq;
;4701:	int extEvent, number;
;4702:
;4703:	// if there are still events pending
;4704:	if ( ps->entityEventSequence < ps->eventSequence ) {
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 464
ADDP4
INDIRI4
ADDRLP4 20
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
GEI4 $2028
line 4707
;4705:		// create a temporary entity for this event which is sent to everyone
;4706:		// except the client who generated the event
;4707:		seq = ps->entityEventSequence & (MAX_PS_EVENTS-1);
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 464
ADDP4
INDIRI4
CNSTI4 1
BANDI4
ASGNI4
line 4708
;4708:		event = ps->events[ seq ] | ( ( ps->entityEventSequence & 3 ) << 8 );
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 24
INDIRP4
CNSTI4 112
ADDP4
ADDP4
INDIRI4
ADDRLP4 24
INDIRP4
CNSTI4 464
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 8
LSHI4
BORI4
ASGNI4
line 4710
;4709:		// set external event to zero before calling BG_PlayerStateToEntityState
;4710:		extEvent = ps->externalEvent;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
INDIRI4
ASGNI4
line 4711
;4711:		ps->externalEvent = 0;
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
CNSTI4 0
ASGNI4
line 4713
;4712:		// create temporary entity for event
;4713:		t = G_TempEntity( ps->origin, event );
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ASGNP4
line 4714
;4714:		number = t->s.number;
ADDRLP4 16
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 4715
;4715:		BG_PlayerStateToEntityState( ps, &t->s, qtrue );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BG_PlayerStateToEntityState
CALLV
pop
line 4716
;4716:		t->s.number = number;
ADDRLP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ASGNI4
line 4717
;4717:		t->s.eType = ET_EVENTS + event;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 14
ADDI4
ASGNI4
line 4718
;4718:		t->s.eFlags |= EF_PLAYER_EVENT;
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 4719
;4719:		t->s.otherEntityNum = ps->clientNum;
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 4721
;4720:		// send to everyone except the client who generated the event
;4721:		t->r.svFlags |= SVF_NOTSINGLECLIENT;
ADDRLP4 36
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
line 4722
;4722:		t->r.singleClient = ps->clientNum;
ADDRLP4 0
INDIRP4
CNSTI4 428
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 4724
;4723:		// set back external event
;4724:		ps->externalEvent = extEvent;
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 4725
;4725:	}
LABELV $2028
line 4726
;4726:}
LABELV $2027
endproc SendPendingPredictableEvents 40 12
export ClientThink_real
proc ClientThink_real 412 16
line 4739
;4727:
;4728:/*
;4729:==============
;4730:ClientThink
;4731:
;4732:This will be called once for each client frame, which will
;4733:usually be a couple times for each server frame on fast clients.
;4734:
;4735:If "g_synchronousClients 1" is set, this will be called exactly
;4736:once for each server frame, which makes for smooth demo recording.
;4737:==============
;4738:*/
;4739:void ClientThink_real( gentity_t *ent ) {
line 4746
;4740:	gclient_t	*client;
;4741:	pmove_t		pm;
;4742:	int			oldEventSequence;
;4743:	int			msec;
;4744:	usercmd_t	*ucmd;
;4745:
;4746:	client = ent->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 4750
;4747:
;4748:	//G_Printf("client at %f %f %f\n", client->ps.origin[0], client->ps.origin[1], client->ps.origin[2]);	// JUHOX DEBUG
;4749:	// don't think if the client is not yet connected (and thus not yet spawned in)
;4750:	if (client->pers.connected != CON_CONNECTED) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $2031
line 4751
;4751:		return;
ADDRGP4 $2030
JUMPV
LABELV $2031
line 4754
;4752:	}
;4753:	// mark the time, so the connection sprite can be removed
;4754:	ucmd = &ent->client->pers.cmd;
ADDRLP4 268
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 472
ADDP4
ASGNP4
line 4757
;4755:
;4756:	// sanity check the command time to prevent speedup cheating
;4757:	if ( ucmd->serverTime > level.time + 200 ) {
ADDRLP4 268
INDIRP4
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 200
ADDI4
LEI4 $2033
line 4758
;4758:		ucmd->serverTime = level.time + 200;
ADDRLP4 268
INDIRP4
ADDRGP4 level+32
INDIRI4
CNSTI4 200
ADDI4
ASGNI4
line 4760
;4759://		G_Printf("serverTime <<<<<\n" );
;4760:	}
LABELV $2033
line 4761
;4761:	if ( ucmd->serverTime < level.time - 1000 ) {
ADDRLP4 268
INDIRP4
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
SUBI4
GEI4 $2037
line 4762
;4762:		ucmd->serverTime = level.time - 1000;
ADDRLP4 268
INDIRP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
SUBI4
ASGNI4
line 4764
;4763://		G_Printf("serverTime >>>>>\n" );
;4764:	} 
LABELV $2037
line 4766
;4765:
;4766:	msec = ucmd->serverTime - client->ps.commandTime;
ADDRLP4 272
ADDRLP4 268
INDIRP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
SUBI4
ASGNI4
line 4769
;4767:	// following others may result in bad times, but we still want
;4768:	// to check for follow toggles
;4769:	if ( msec < 1 && client->sess.spectatorState != SPECTATOR_FOLLOW ) {
ADDRLP4 272
INDIRI4
CNSTI4 1
GEI4 $2041
ADDRLP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRI4
CNSTI4 2
EQI4 $2041
line 4770
;4770:		return;
ADDRGP4 $2030
JUMPV
LABELV $2041
line 4772
;4771:	}
;4772:	if ( msec > 200 ) {
ADDRLP4 272
INDIRI4
CNSTI4 200
LEI4 $2043
line 4773
;4773:		msec = 200;
ADDRLP4 272
CNSTI4 200
ASGNI4
line 4774
;4774:	}
LABELV $2043
line 4776
;4775:
;4776:	if ( pmove_msec.integer < 8 ) {
ADDRGP4 pmove_msec+12
INDIRI4
CNSTI4 8
GEI4 $2045
line 4777
;4777:		trap_Cvar_Set("pmove_msec", "8");
ADDRGP4 $2048
ARGP4
ADDRGP4 $2049
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4778
;4778:	}
ADDRGP4 $2046
JUMPV
LABELV $2045
line 4779
;4779:	else if (pmove_msec.integer > 33) {
ADDRGP4 pmove_msec+12
INDIRI4
CNSTI4 33
LEI4 $2050
line 4780
;4780:		trap_Cvar_Set("pmove_msec", "33");
ADDRGP4 $2048
ARGP4
ADDRGP4 $2053
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4781
;4781:	}
LABELV $2050
LABELV $2046
line 4783
;4782:
;4783:	if ( pmove_fixed.integer || client->pers.pmoveFixed ) {
ADDRGP4 pmove_fixed+12
INDIRI4
CNSTI4 0
NEI4 $2057
ADDRLP4 0
INDIRP4
CNSTI4 508
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2054
LABELV $2057
line 4784
;4784:		ucmd->serverTime = ((ucmd->serverTime + pmove_msec.integer-1) / pmove_msec.integer) * pmove_msec.integer;
ADDRLP4 268
INDIRP4
ADDRLP4 268
INDIRP4
INDIRI4
ADDRGP4 pmove_msec+12
INDIRI4
ADDI4
CNSTI4 1
SUBI4
ADDRGP4 pmove_msec+12
INDIRI4
DIVI4
ADDRGP4 pmove_msec+12
INDIRI4
MULI4
ASGNI4
line 4787
;4785:		//if (ucmd->serverTime - client->ps.commandTime <= 0)
;4786:		//	return;
;4787:	}
LABELV $2054
line 4792
;4788:
;4789:	//
;4790:	// check for exiting intermission
;4791:	//
;4792:	if ( level.intermissiontime ) {
ADDRGP4 level+9144
INDIRI4
CNSTI4 0
EQI4 $2061
line 4793
;4793:		ClientIntermissionThink( client );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 ClientIntermissionThink
CALLV
pop
line 4794
;4794:		return;
ADDRGP4 $2030
JUMPV
LABELV $2061
line 4798
;4795:	}
;4796:
;4797:#if MEETING
;4798:	if (level.meeting) {
ADDRGP4 level+24092
INDIRI4
CNSTI4 0
EQI4 $2064
line 4799
;4799:		client->ps.pm_type = PM_MEETING;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 7
ASGNI4
line 4800
;4800:		ClientIntermissionThink(client);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 ClientIntermissionThink
CALLV
pop
line 4801
;4801:		return;
ADDRGP4 $2030
JUMPV
LABELV $2064
line 4806
;4802:	}
;4803:#endif
;4804:
;4805:	// spectators don't do much
;4806:	if ( client->sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRLP4 0
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 3
NEI4 $2067
line 4807
;4807:		if ( client->sess.spectatorState == SPECTATOR_SCOREBOARD ) {
ADDRLP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRI4
CNSTI4 3
NEI4 $2069
line 4808
;4808:			return;
ADDRGP4 $2030
JUMPV
LABELV $2069
line 4810
;4809:		}
;4810:		SpectatorThink( ent, ucmd );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 268
INDIRP4
ARGP4
ADDRGP4 SpectatorThink
CALLV
pop
line 4811
;4811:		return;
ADDRGP4 $2030
JUMPV
LABELV $2067
line 4815
;4812:	}
;4813:
;4814:	// check for inactivity timer, but never drop the local client of a non-dedicated server
;4815:	if ( !ClientInactivityTimer( client ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 280
ADDRGP4 ClientInactivityTimer
CALLI4
ASGNI4
ADDRLP4 280
INDIRI4
CNSTI4 0
NEI4 $2071
line 4816
;4816:		return;
ADDRGP4 $2030
JUMPV
LABELV $2071
line 4820
;4817:	}
;4818:
;4819:	// clear the rewards if time
;4820:	if ( level.time > client->rewardTime ) {
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 848
ADDP4
INDIRI4
LEI4 $2073
line 4821
;4821:		client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
ADDRLP4 284
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 284
INDIRP4
ADDRLP4 284
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 4822
;4822:	}
LABELV $2073
line 4824
;4823:
;4824:	if (level.time >= ent->s.time) ent->s.time = 0;	// JUHOX
ADDRGP4 level+32
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
LTI4 $2076
ADDRFP4 0
INDIRP4
CNSTI4 84
ADDP4
CNSTI4 0
ASGNI4
LABELV $2076
line 4827
;4825:
;4826:#if 1	// JUHOX: set "player is fighting" flag
;4827:	ent->s.modelindex &= ~PFMI_FIGHTING;
ADDRLP4 284
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
ASGNP4
ADDRLP4 284
INDIRP4
ADDRLP4 284
INDIRP4
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 4828
;4828:	if (IsPlayerInvolvedInFighting(ent->s.number)) {
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 288
ADDRGP4 IsPlayerInvolvedInFighting
CALLI4
ASGNI4
ADDRLP4 288
INDIRI4
CNSTI4 0
EQI4 $2079
line 4829
;4829:		ent->s.modelindex |= PFMI_FIGHTING;
ADDRLP4 292
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
ASGNP4
ADDRLP4 292
INDIRP4
ADDRLP4 292
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 4830
;4830:	}
LABELV $2079
line 4833
;4831:#endif
;4832:
;4833:	if ( client->noclip ) {
ADDRLP4 0
INDIRP4
CNSTI4 728
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2081
line 4834
;4834:		client->ps.pm_type = PM_NOCLIP;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 1
ASGNI4
line 4835
;4835:	} else if ( client->ps.stats[STAT_HEALTH] <= 0 ) {
ADDRGP4 $2082
JUMPV
LABELV $2081
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $2083
line 4836
;4836:		client->ps.pm_type = PM_DEAD;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 3
ASGNI4
line 4839
;4837:#if 1	// JUHOX: let dead players spectate
;4838:		if (
;4839:			level.time >= client->respawnTime &&
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 832
ADDP4
INDIRI4
LTI4 $2084
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 832
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 836
ADDP4
INDIRI4
ADDI4
LTI4 $2090
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
GEI4 $2084
LABELV $2090
ADDRLP4 0
INDIRP4
CNSTI4 980
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2084
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $2084
line 4849
;4840:#if MONSTER_MODE
;4841:			(
;4842:				// don't spectate in STU when the respawn delay is over
;4843:				level.time < client->respawnTime + client->respawnDelay ||
;4844:				g_gametype.integer < GT_STU
;4845:			) &&
;4846:#endif
;4847:			client->corpseProduced &&
;4848:			!(ent->r.svFlags & SVF_BOT)
;4849:		) {
line 4850
;4850:			client->ps.pm_type = PM_SPECTATOR;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 2
ASGNI4
line 4851
;4851:		}
line 4854
;4852:#endif
;4853:#if 1	// JUHOX: let mission leaders in safety mode spectate
;4854:	} else if (client->tssSafetyMode) {
ADDRGP4 $2084
JUMPV
LABELV $2083
ADDRLP4 0
INDIRP4
CNSTI4 768
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2091
line 4855
;4855:		client->ps.pm_type = PM_SPECTATOR;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 2
ASGNI4
line 4857
;4856:#endif
;4857:	} else {
ADDRGP4 $2092
JUMPV
LABELV $2091
line 4858
;4858:		client->ps.pm_type = PM_NORMAL;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 0
ASGNI4
line 4859
;4859:	}
LABELV $2092
LABELV $2084
LABELV $2082
line 4861
;4860:
;4861:	client->ps.gravity = g_gravity.value;
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ADDRGP4 g_gravity+8
INDIRF4
CVFI4 4
ASGNI4
line 4864
;4862:
;4863:	// set speed
;4864:	client->ps.speed = g_speed.value;
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
ADDRGP4 g_speed+8
INDIRF4
CVFI4 4
ASGNI4
line 4879
;4865:
;4866:#if 0	// JUHOX: no normal haste
;4867:#ifdef MISSIONPACK
;4868:	if( bg_itemlist[client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_SCOUT ) {
;4869:		client->ps.speed *= 1.5;
;4870:	}
;4871:	else
;4872:#endif
;4873:	if ( client->ps.powerups[PW_HASTE] ) {
;4874:		client->ps.speed *= 1.3;
;4875:	}
;4876:#endif
;4877:
;4878:#if 1	// JUHOX: paralysation
;4879:	if (level.time < client->paralysationTime) {
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 856
ADDP4
INDIRI4
GEI4 $2095
line 4880
;4880:		client->ps.speed = 0.25 * client->ps.speed;
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1048576000
MULF4
CVFI4 4
ASGNI4
line 4881
;4881:	}
LABELV $2095
line 4885
;4882:#endif
;4883:
;4884:#if 1	// JUHOX: gauntlet attack speed up
;4885:	if (client->ps.stats[STAT_HEALTH] > 0 && client->ps.weapon == WP_GAUNTLET) {
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
LEI4 $2098
ADDRLP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 1
NEI4 $2098
line 4887
;4886:		if (
;4887:			(ucmd->buttons & BUTTON_ATTACK) &&
ADDRLP4 268
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $2100
ADDRLP4 268
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $2100
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $2100
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 0
LTI4 $2100
line 4891
;4888:			!(ucmd->buttons & BUTTON_WALKING) &&
;4889:			!(client->ps.pm_flags & PMF_DUCKED) &&
;4890:			client->ps.stats[STAT_TARGET] >= 0
;4891:		) {
line 4892
;4892:			client->ps.speed = client->ps.speed * 1.2;
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1067030938
MULF4
CVFI4 4
ASGNI4
line 4893
;4893:		}
LABELV $2100
line 4894
;4894:	}
LABELV $2098
line 4896
;4895:#endif
;4896:	CheckPlayerDischarge(ent);	// JUHOX
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CheckPlayerDischarge
CALLV
pop
line 4915
;4897:
;4898:	// Let go of the hook if we aren't firing
;4899:#if 0	// JUHOX: grapple release bug fix
;4900:	if ( client->ps.weapon == WP_GRAPPLING_HOOK &&
;4901:		client->hook && !( ucmd->buttons & BUTTON_ATTACK ) ) {
;4902:		Weapon_HookFree(client->hook);
;4903:	}
;4904:#else
;4905:	/* -JUHOX: grapple release bug fix
;4906:	if (
;4907:		client->hook &&
;4908:		(client->ps.weapon != WP_GRAPPLING_HOOK || !(ucmd->buttons & BUTTON_ATTACK))
;4909:	) {
;4910:		Weapon_HookFree(client->hook);
;4911:	}
;4912:	*/
;4913:#endif
;4914:#if GRAPPLE_ROPE
;4915:	ThinkGrapple(ent, msec);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 272
INDIRI4
ARGI4
ADDRGP4 ThinkGrapple
CALLV
pop
line 4919
;4916:#endif
;4917:
;4918:	// set up for pmove
;4919:	oldEventSequence = client->ps.eventSequence;
ADDRLP4 276
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
ASGNI4
line 4921
;4920:
;4921:	memset (&pm, 0, sizeof(pm));
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 264
ARGI4
ADDRGP4 memset
CALLP4
pop
line 4925
;4922:
;4923:	// check for the hit-scan gauntlet, don't let the action
;4924:	// go through as an attack unless it actually hits something
;4925:	if ( client->ps.weapon == WP_GAUNTLET && !( ucmd->buttons & BUTTON_TALK ) &&
ADDRLP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 1
NEI4 $2102
ADDRLP4 268
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $2102
ADDRLP4 268
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $2102
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
GTI4 $2102
line 4926
;4926:		( ucmd->buttons & BUTTON_ATTACK ) && client->ps.weaponTime <= 0 ) {
line 4927
;4927:		pm.gauntletHit = CheckGauntletAttack( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 304
ADDRGP4 CheckGauntletAttack
CALLI4
ASGNI4
ADDRLP4 4+40
ADDRLP4 304
INDIRI4
ASGNI4
line 4928
;4928:	}
LABELV $2102
line 4930
;4929:
;4930:	if ( ent->flags & FL_FORCE_GESTURE ) {
ADDRFP4 0
INDIRP4
CNSTI4 540
ADDP4
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $2105
line 4931
;4931:		ent->flags &= ~FL_FORCE_GESTURE;
ADDRLP4 304
ADDRFP4 0
INDIRP4
CNSTI4 540
ADDP4
ASGNP4
ADDRLP4 304
INDIRP4
ADDRLP4 304
INDIRP4
INDIRI4
CNSTI4 -32769
BANDI4
ASGNI4
line 4932
;4932:		ent->client->pers.cmd.buttons |= BUTTON_GESTURE;
ADDRLP4 308
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 488
ADDP4
ASGNP4
ADDRLP4 308
INDIRP4
ADDRLP4 308
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 4933
;4933:	}
LABELV $2105
line 4962
;4934:
;4935:#ifdef MISSIONPACK
;4936:	// check for invulnerability expansion before doing the Pmove
;4937:	if (client->ps.powerups[PW_INVULNERABILITY] ) {
;4938:		if ( !(client->ps.pm_flags & PMF_INVULEXPAND) ) {
;4939:			vec3_t mins = { -42, -42, -42 };
;4940:			vec3_t maxs = { 42, 42, 42 };
;4941:			vec3_t oldmins, oldmaxs;
;4942:
;4943:			VectorCopy (ent->r.mins, oldmins);
;4944:			VectorCopy (ent->r.maxs, oldmaxs);
;4945:			// expand
;4946:			VectorCopy (mins, ent->r.mins);
;4947:			VectorCopy (maxs, ent->r.maxs);
;4948:			trap_LinkEntity(ent);
;4949:			// check if this would get anyone stuck in this player
;4950:			if ( !StuckInOtherClient(ent) ) {
;4951:				// set flag so the expanded size will be set in PM_CheckDuck
;4952:				client->ps.pm_flags |= PMF_INVULEXPAND;
;4953:			}
;4954:			// set back
;4955:			VectorCopy (oldmins, ent->r.mins);
;4956:			VectorCopy (oldmaxs, ent->r.maxs);
;4957:			trap_LinkEntity(ent);
;4958:		}
;4959:	}
;4960:#endif
;4961:
;4962:	pm.ps = &client->ps;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
line 4963
;4963:	pm.cmd = *ucmd;
ADDRLP4 4+4
ADDRLP4 268
INDIRP4
INDIRB
ASGNB 24
line 4964
;4964:	if ( pm.ps->pm_type == PM_DEAD ) {
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $2108
line 4965
;4965:		pm.tracemask = MASK_PLAYERSOLID & ~CONTENTS_BODY;
ADDRLP4 4+28
CNSTI4 65537
ASGNI4
line 4966
;4966:	}
ADDRGP4 $2109
JUMPV
LABELV $2108
line 4968
;4967:#if 1	// JUHOX: let mission leaders in safety mode spectate
;4968:	else if (client->tssSafetyMode) {
ADDRLP4 0
INDIRP4
CNSTI4 768
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2111
line 4969
;4969:		pm.tracemask = MASK_PLAYERSOLID & ~CONTENTS_BODY;
ADDRLP4 4+28
CNSTI4 65537
ASGNI4
line 4970
;4970:	}
ADDRGP4 $2112
JUMPV
LABELV $2111
line 4973
;4971:#endif
;4972:#if 1	// JUHOX: unspawned player don't touch other players
;4973:	else if (pm.ps->pm_type == PM_SPECTATOR) {
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $2114
line 4974
;4974:		pm.tracemask = MASK_PLAYERSOLID & ~CONTENTS_BODY;
ADDRLP4 4+28
CNSTI4 65537
ASGNI4
line 4975
;4975:	}
ADDRGP4 $2115
JUMPV
LABELV $2114
line 4977
;4976:#endif
;4977:	else if ( ent->r.svFlags & SVF_BOT ) {
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $2117
line 4978
;4978:		pm.tracemask = MASK_PLAYERSOLID | CONTENTS_BOTCLIP;
ADDRLP4 4+28
CNSTI4 37814273
ASGNI4
line 4979
;4979:	}
ADDRGP4 $2118
JUMPV
LABELV $2117
line 4980
;4980:	else {
line 4981
;4981:		pm.tracemask = MASK_PLAYERSOLID;
ADDRLP4 4+28
CNSTI4 33619969
ASGNI4
line 4982
;4982:	}
LABELV $2118
LABELV $2115
LABELV $2112
LABELV $2109
line 4983
;4983:	pm.trace = trap_Trace;
ADDRLP4 4+256
ADDRGP4 trap_Trace
ASGNP4
line 4984
;4984:	pm.pointcontents = trap_PointContents;
ADDRLP4 4+260
ADDRGP4 trap_PointContents
ASGNP4
line 4985
;4985:	pm.debugLevel = g_debugMove.integer;
ADDRLP4 4+32
ADDRGP4 g_debugMove+12
INDIRI4
ASGNI4
line 4986
;4986:	pm.noFootsteps = ( g_dmflags.integer & DF_NO_FOOTSTEPS ) > 0;
ADDRGP4 g_dmflags+12
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
LEI4 $2128
ADDRLP4 304
CNSTI4 1
ASGNI4
ADDRGP4 $2129
JUMPV
LABELV $2128
ADDRLP4 304
CNSTI4 0
ASGNI4
LABELV $2129
ADDRLP4 4+36
ADDRLP4 304
INDIRI4
ASGNI4
line 4988
;4987:#if GRAPPLE_ROPE	// JUHOX: set grapple mode
;4988:	pm.hookMode = g_grapple.integer;
ADDRLP4 4+60
ADDRGP4 g_grapple+12
INDIRI4
ASGNI4
line 4995
;4989:#endif
;4990:
;4991:#if 0	// JUHOX: always use fixed pmove
;4992:	pm.pmove_fixed = pmove_fixed.integer | client->pers.pmoveFixed;
;4993:	pm.pmove_msec = pmove_msec.integer;
;4994:#else
;4995:	pm.pmove_fixed = qtrue;
ADDRLP4 4+248
CNSTI4 1
ASGNI4
line 4996
;4996:	pm.pmove_msec = 10000;
ADDRLP4 4+252
CNSTI4 10000
ASGNI4
line 4999
;4997:#endif
;4998:
;4999:	VectorCopy( client->ps.origin, client->oldOrigin );
ADDRLP4 0
INDIRP4
CNSTI4 748
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 5001
;5000:
;5001:	VectorCopy(ent->s.origin2, pm.target);	// JUHOX: origin2 set in SetTargetPos()
ADDRLP4 4+48
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
INDIRB
ASGNB 12
line 5004
;5002:
;5003:#if MONSTER_MODE	// JUHOX: set player scale factor for normal player
;5004:	pm.scale = 1;
ADDRLP4 4+68
CNSTF4 1065353216
ASGNF4
line 5007
;5005:#endif
;5006:
;5007:	pm.gametype = g_gametype.integer;	// JUHOX
ADDRLP4 4+64
ADDRGP4 g_gametype+12
INDIRI4
ASGNI4
line 5024
;5008:
;5009:#ifdef MISSIONPACK
;5010:		if (level.intermissionQueued != 0 && g_singlePlayer.integer) {
;5011:			if ( level.time - level.intermissionQueued >= 1000  ) {
;5012:				pm.cmd.buttons = 0;
;5013:				pm.cmd.forwardmove = 0;
;5014:				pm.cmd.rightmove = 0;
;5015:				pm.cmd.upmove = 0;
;5016:				if ( level.time - level.intermissionQueued >= 2000 && level.time - level.intermissionQueued <= 2500 ) {
;5017:					trap_SendConsoleCommand( EXEC_APPEND, "centerview\n");
;5018:				}
;5019:				ent->client->ps.pm_type = PM_SPINTERMISSION;
;5020:			}
;5021:		}
;5022:		Pmove (&pm);
;5023:#else
;5024:		Pmove (&pm);
ADDRLP4 4
ARGP4
ADDRGP4 Pmove
CALLV
pop
line 5027
;5025:#endif
;5026:#if 1	// JUHOX: restore strength if stamina not used
;5027:	if (!g_stamina.integer) {
ADDRGP4 g_stamina+12
INDIRI4
CNSTI4 0
NEI4 $2138
line 5028
;5028:		client->ps.stats[STAT_STRENGTH] = MAX_STRENGTH_VALUE;
ADDRLP4 0
INDIRP4
CNSTI4 212
ADDP4
CNSTI4 18000
ASGNI4
line 5029
;5029:	}
LABELV $2138
line 5032
;5030:#endif
;5031:#if 1	// JUHOX: check weapon usage
;5032:	if (client->ps.weaponstate >= WEAPON_FIRING) {
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 3
LTI4 $2141
line 5033
;5033:		client->weaponUsageTime = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 860
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 5037
;5034:
;5035:		// check weapon limit
;5036:		if (
;5037:			g_weaponLimit.integer > 0 &&
ADDRGP4 g_weaponLimit+12
INDIRI4
CNSTI4 0
LEI4 $2144
ADDRLP4 0
INDIRP4
CNSTI4 628
ADDP4
INDIRI4
ADDRGP4 g_weaponLimit+12
INDIRI4
GEI4 $2144
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
LEI4 $2144
ADDRLP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 10
EQI4 $2144
line 5041
;5038:			client->pers.numChoosenWeapons < g_weaponLimit.integer &&
;5039:			client->ps.stats[STAT_HEALTH] > 0 &&
;5040:			client->ps.weapon != WP_GRAPPLING_HOOK
;5041:		) {
line 5044
;5042:			int i;
;5043:
;5044:			for (i = 0; i < client->pers.numChoosenWeapons; i++) {
ADDRLP4 316
CNSTI4 0
ASGNI4
ADDRGP4 $2151
JUMPV
LABELV $2148
line 5045
;5045:				if (client->pers.choosenWeapons[i] == client->ps.weapon) break;
ADDRLP4 316
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 632
ADDP4
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
NEI4 $2152
ADDRGP4 $2150
JUMPV
LABELV $2152
line 5046
;5046:			}
LABELV $2149
line 5044
ADDRLP4 316
ADDRLP4 316
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2151
ADDRLP4 316
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 628
ADDP4
INDIRI4
LTI4 $2148
LABELV $2150
line 5047
;5047:			if (i >= client->pers.numChoosenWeapons) {
ADDRLP4 316
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 628
ADDP4
INDIRI4
LTI4 $2154
line 5051
;5048:				char buf[MAX_CLIENTS+4];
;5049:
;5050:				// add weapon
;5051:				client->pers.choosenWeapons[client->pers.numChoosenWeapons++] = client->ps.weapon;
ADDRLP4 392
ADDRLP4 0
INDIRP4
CNSTI4 628
ADDP4
ASGNP4
ADDRLP4 388
ADDRLP4 392
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 392
INDIRP4
ADDRLP4 388
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 388
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 632
ADDP4
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ASGNI4
line 5053
;5052:
;5053:				if (client->pers.numChoosenWeapons >= g_weaponLimit.integer) {
ADDRLP4 0
INDIRP4
CNSTI4 628
ADDP4
INDIRI4
ADDRGP4 g_weaponLimit+12
INDIRI4
LTI4 $2156
line 5055
;5054:					// restrict to choosen weapons
;5055:					client->ps.stats[STAT_WEAPONS] &= 1 << WP_GRAPPLING_HOOK;
ADDRLP4 400
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
ASGNP4
ADDRLP4 400
INDIRP4
ADDRLP4 400
INDIRP4
INDIRI4
CNSTI4 1024
BANDI4
ASGNI4
line 5056
;5056:					for (i = 0; i < client->pers.numChoosenWeapons; i++) {
ADDRLP4 316
CNSTI4 0
ASGNI4
ADDRGP4 $2162
JUMPV
LABELV $2159
line 5057
;5057:						client->ps.stats[STAT_WEAPONS] |= 1 << client->pers.choosenWeapons[i];
ADDRLP4 408
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
ASGNP4
ADDRLP4 408
INDIRP4
ADDRLP4 408
INDIRP4
INDIRI4
CNSTI4 1
ADDRLP4 316
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 632
ADDP4
ADDP4
INDIRI4
LSHI4
BORI4
ASGNI4
line 5058
;5058:					}
LABELV $2160
line 5056
ADDRLP4 316
ADDRLP4 316
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2162
ADDRLP4 316
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 628
ADDP4
INDIRI4
LTI4 $2159
line 5059
;5059:				}
LABELV $2156
line 5062
;5060:
;5061:				// send new weapon info
;5062:				for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 316
CNSTI4 0
ASGNI4
LABELV $2163
line 5063
;5063:					buf[i] = level.clients[i].pers.numChoosenWeapons + 'A';
ADDRLP4 316
INDIRI4
ADDRLP4 320
ADDP4
ADDRLP4 316
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 628
ADDP4
INDIRI4
CNSTI4 65
ADDI4
CVII1 4
ASGNI1
line 5064
;5064:				}
LABELV $2164
line 5062
ADDRLP4 316
ADDRLP4 316
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 316
INDIRI4
CNSTI4 64
LTI4 $2163
line 5065
;5065:				buf[i] = 0;
ADDRLP4 316
INDIRI4
ADDRLP4 320
ADDP4
CNSTI1 0
ASGNI1
line 5066
;5066:				trap_SetConfigstring(CS_CHOOSENWEAPONS, buf);
CNSTI4 714
ARGI4
ADDRLP4 320
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 5067
;5067:			}
LABELV $2154
line 5068
;5068:		}
LABELV $2144
line 5069
;5069:	}
LABELV $2141
line 5073
;5070:#endif
;5071:#if	1	// JUHOX: check grapple usage
;5072:	if (
;5073:		client->hook
ADDRLP4 0
INDIRP4
CNSTI4 884
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2167
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 1
EQI4 $2167
line 5077
;5074:#if GRAPPLE_ROPE
;5075:		&& client->ps.stats[STAT_GRAPPLE_STATE] != GST_silent
;5076:#endif
;5077:	) {
line 5078
;5078:		client->grappleUsageTime = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 864
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 5079
;5079:	}
LABELV $2167
line 5083
;5080:#endif
;5081:#if 1	// JUHOX: switch cloaking
;5082:	if (
;5083:		g_cloakingDevice.integer &&
ADDRGP4 g_cloakingDevice+12
INDIRI4
CNSTI4 0
EQI4 $2170
ADDRLP4 0
INDIRP4
CNSTI4 860
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 3000
SUBI4
GEI4 $2170
ADDRLP4 0
INDIRP4
CNSTI4 864
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 3000
SUBI4
GEI4 $2170
line 5086
;5084:		client->weaponUsageTime < level.time - 3000 &&
;5085:		client->grappleUsageTime < level.time - 3000
;5086:	) {
line 5087
;5087:		if (!client->ps.powerups[PW_INVIS]) {
ADDRLP4 0
INDIRP4
CNSTI4 328
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2175
line 5088
;5088:			client->ps.stats[STAT_EFFECT] = PE_fade_out;
ADDRLP4 0
INDIRP4
CNSTI4 220
ADDP4
CNSTI4 2
ASGNI4
line 5089
;5089:			client->ps.powerups[PW_EFFECT_TIME] = level.time + SPAWNHULL_TIME;
ADDRLP4 0
INDIRP4
CNSTI4 364
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 5090
;5090:		}
LABELV $2175
line 5091
;5091:		client->ps.powerups[PW_INVIS] = level.time + 1000000000;
ADDRLP4 0
INDIRP4
CNSTI4 328
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000000000
ADDI4
ASGNI4
line 5092
;5092:	}
ADDRGP4 $2171
JUMPV
LABELV $2170
line 5093
;5093:	else {
line 5094
;5094:		if (client->ps.powerups[PW_INVIS]) {
ADDRLP4 0
INDIRP4
CNSTI4 328
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2179
line 5097
;5095:			int endTime;
;5096:
;5097:			client->ps.stats[STAT_EFFECT] = PE_fade_in;
ADDRLP4 0
INDIRP4
CNSTI4 220
ADDP4
CNSTI4 1
ASGNI4
line 5098
;5098:			endTime = level.time + SPAWNHULL_TIME;
ADDRLP4 320
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 5099
;5099:			if (client->ps.powerups[PW_EFFECT_TIME] > level.time) {
ADDRLP4 0
INDIRP4
CNSTI4 364
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $2182
line 5103
;5100:				int startTime;
;5101:				int timePassed;
;5102:
;5103:				startTime = client->ps.powerups[PW_EFFECT_TIME] - SPAWNHULL_TIME;
ADDRLP4 324
ADDRLP4 0
INDIRP4
CNSTI4 364
ADDP4
INDIRI4
CNSTI4 1000
SUBI4
ASGNI4
line 5104
;5104:				timePassed = level.time - startTime;
ADDRLP4 328
ADDRGP4 level+32
INDIRI4
ADDRLP4 324
INDIRI4
SUBI4
ASGNI4
line 5105
;5105:				endTime = level.time + timePassed;
ADDRLP4 320
ADDRGP4 level+32
INDIRI4
ADDRLP4 328
INDIRI4
ADDI4
ASGNI4
line 5106
;5106:			}
LABELV $2182
line 5107
;5107:			client->ps.powerups[PW_EFFECT_TIME] = endTime;
ADDRLP4 0
INDIRP4
CNSTI4 364
ADDP4
ADDRLP4 320
INDIRI4
ASGNI4
line 5108
;5108:		}
LABELV $2179
line 5109
;5109:		client->ps.powerups[PW_INVIS] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 328
ADDP4
CNSTI4 0
ASGNI4
line 5110
;5110:		client->ps.powerups[PW_BATTLESUIT] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 320
ADDP4
CNSTI4 0
ASGNI4
line 5111
;5111:	}
LABELV $2171
line 5115
;5112:#endif
;5113:
;5114:#if 1	// JUHOX: set weapon target
;5115:	switch (client->ps.weapon) {
ADDRLP4 320
ADDRLP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ASGNI4
ADDRLP4 320
INDIRI4
CNSTI4 1
EQI4 $2190
ADDRLP4 320
INDIRI4
CNSTI4 1
LTI4 $2187
LABELV $2194
ADDRLP4 320
INDIRI4
CNSTI4 6
EQI4 $2191
ADDRGP4 $2187
JUMPV
LABELV $2190
line 5117
;5116:	case WP_GAUNTLET:
;5117:		GetGauntletTarget(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 GetGauntletTarget
CALLV
pop
line 5118
;5118:		break;
ADDRGP4 $2188
JUMPV
LABELV $2191
line 5121
;5119:	case WP_LIGHTNING:
;5120:		if (
;5121:			!(client->ps.eFlags & EF_FIRING) &&
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
NEI4 $2188
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $2188
line 5123
;5122:			client->ps.stats[STAT_HEALTH] <= 0
;5123:		) {
line 5124
;5124:			client->ps.stats[STAT_TARGET] = -1;
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
CNSTI4 -1
ASGNI4
line 5126
;5125:			//ent->s.otherEntityNum2 = client->ps.stats[STAT_TARGET];
;5126:		}
line 5128
;5127:		// target searching done when weapon fires in Weapon_LightningFire()
;5128:		break;
ADDRGP4 $2188
JUMPV
LABELV $2187
line 5130
;5129:	default:
;5130:		client->ps.stats[STAT_TARGET] = -1;
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
CNSTI4 -1
ASGNI4
line 5132
;5131:		//ent->s.otherEntityNum2 = ENTITYNUM_NONE;
;5132:		break;
LABELV $2188
line 5137
;5133:	}
;5134:#endif
;5135:
;5136:	// save results of pmove
;5137:	if ( ent->client->ps.eventSequence != oldEventSequence ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
ADDRLP4 276
INDIRI4
EQI4 $2195
line 5138
;5138:		ent->eventTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 556
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 5139
;5139:	}
LABELV $2195
line 5140
;5140:	if (g_smoothClients.integer) {
ADDRGP4 g_smoothClients+12
INDIRI4
CNSTI4 0
EQI4 $2198
line 5141
;5141:		BG_PlayerStateToEntityStateExtraPolate( &ent->client->ps, &ent->s, ent->client->ps.commandTime, qtrue );
ADDRLP4 328
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 328
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRLP4 328
INDIRP4
ARGP4
ADDRLP4 328
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BG_PlayerStateToEntityStateExtraPolate
CALLV
pop
line 5142
;5142:	}
ADDRGP4 $2199
JUMPV
LABELV $2198
line 5143
;5143:	else {
line 5144
;5144:		BG_PlayerStateToEntityState( &ent->client->ps, &ent->s, qtrue );
ADDRLP4 328
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 328
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRLP4 328
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BG_PlayerStateToEntityState
CALLV
pop
line 5145
;5145:	}
LABELV $2199
line 5146
;5146:	SendPendingPredictableEvents( &ent->client->ps );
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRGP4 SendPendingPredictableEvents
CALLV
pop
line 5148
;5147:
;5148:	if ( !( ent->client->ps.eFlags & EF_FIRING ) ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
NEI4 $2201
line 5149
;5149:		client->fireHeld = qfalse;		// for grapple
ADDRLP4 0
INDIRP4
CNSTI4 876
ADDP4
CNSTI4 0
ASGNI4
line 5150
;5150:	}
LABELV $2201
line 5153
;5151:
;5152:	// use the snapped origin for linking so it matches client predicted versions
;5153:	VectorCopy( ent->s.pos.trBase, ent->r.currentOrigin );
ADDRLP4 328
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 328
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 328
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 5155
;5154:
;5155:	VectorCopy (pm.mins, ent->r.mins);
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
ADDRLP4 4+212
INDIRB
ASGNB 12
line 5156
;5156:	VectorCopy (pm.maxs, ent->r.maxs);
ADDRFP4 0
INDIRP4
CNSTI4 448
ADDP4
ADDRLP4 4+224
INDIRB
ASGNB 12
line 5158
;5157:
;5158:	ent->waterlevel = pm.waterlevel;
ADDRFP4 0
INDIRP4
CNSTI4 792
ADDP4
ADDRLP4 4+240
INDIRI4
ASGNI4
line 5159
;5159:	ent->watertype = pm.watertype;
ADDRFP4 0
INDIRP4
CNSTI4 788
ADDP4
ADDRLP4 4+236
INDIRI4
ASGNI4
line 5162
;5160:
;5161:	// execute client events
;5162:	ClientEvents( ent, oldEventSequence );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 276
INDIRI4
ARGI4
ADDRGP4 ClientEvents
CALLV
pop
line 5163
;5163:	CauseChargeDamage(ent);	// JUHOX
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CauseChargeDamage
CALLV
pop
line 5169
;5164:
;5165:	// link entity now, after any personal teleporters have been used
;5166:#if 0	// JUHOX: spectators don't get linked
;5167:	trap_LinkEntity (ent);
;5168:#else
;5169:	if (client->ps.pm_type != PM_SPECTATOR) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $2207
line 5170
;5170:		trap_LinkEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 5171
;5171:	}
ADDRGP4 $2208
JUMPV
LABELV $2207
line 5172
;5172:	else {
line 5173
;5173:		trap_UnlinkEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 5174
;5174:	}
LABELV $2208
line 5176
;5175:#endif
;5176:	if ( !ent->client->noclip ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 728
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2209
line 5177
;5177:		G_TouchTriggers( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_TouchTriggers
CALLV
pop
line 5178
;5178:	}
LABELV $2209
line 5181
;5179:
;5180:	// NOTE: now copy the exact origin over otherwise clients can be snapped into solid
;5181:	VectorCopy( ent->client->ps.origin, ent->r.currentOrigin );
ADDRLP4 332
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 332
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 332
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 5184
;5182:
;5183:	//test for solid areas in the AAS file
;5184:	BotTestAAS(ent->r.currentOrigin);
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRGP4 BotTestAAS
CALLV
pop
line 5187
;5185:
;5186:	// touch other objects
;5187:	ClientImpacts( ent, &pm );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 ClientImpacts
CALLV
pop
line 5190
;5188:
;5189:	// save results of triggers and client events
;5190:	if (ent->client->ps.eventSequence != oldEventSequence) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
ADDRLP4 276
INDIRI4
EQI4 $2211
line 5191
;5191:		ent->eventTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 556
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 5192
;5192:	}
LABELV $2211
line 5195
;5193:
;5194:	// swap and latch button actions
;5195:	client->oldbuttons = client->buttons;
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
ASGNI4
line 5196
;5196:	client->buttons = ucmd->buttons;
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
ADDRLP4 268
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 5197
;5197:	client->latched_buttons |= client->buttons & ~client->oldbuttons;
ADDRLP4 344
ADDRLP4 0
INDIRP4
CNSTI4 744
ADDP4
ASGNP4
ADDRLP4 344
INDIRP4
ADDRLP4 344
INDIRP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
BCOMI4
BANDI4
BORI4
ASGNI4
line 5201
;5198:
;5199:#if MONSTER_MODE	// JUHOX: compute artefact detector value
;5200:	if (
;5201:		g_gametype.integer == GT_STU &&
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
NEI4 $2214
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
LEI4 $2214
ADDRGP4 level+9144
INDIRI4
CNSTI4 0
NEI4 $2214
ADDRGP4 level+23000
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2214
ADDRGP4 level+23000
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
NEI4 $2214
ADDRGP4 level+23012
INDIRI4
CNSTI4 0
GTI4 $2214
line 5207
;5202:		client->ps.stats[STAT_HEALTH] > 0 &&
;5203:		!level.intermissiontime &&
;5204:		level.artefact &&
;5205:		!(level.artefact->s.eFlags & EF_NODRAW) &&
;5206:		level.endPhase <= 0
;5207:	) {
line 5210
;5208:		vec_t dist;
;5209:
;5210:		dist = Distance(client->ps.origin, level.artefact->s.pos.trBase);
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRGP4 level+23000
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 352
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRLP4 348
ADDRLP4 352
INDIRF4
ASGNF4
line 5211
;5211:		if (dist >= 3000) dist = -1;
ADDRLP4 348
INDIRF4
CNSTF4 1161527296
LTF4 $2222
ADDRLP4 348
CNSTF4 3212836864
ASGNF4
ADDRGP4 $2223
JUMPV
LABELV $2222
line 5212
;5212:		else if (dist < 100) dist = 100;
ADDRLP4 348
INDIRF4
CNSTF4 1120403456
GEF4 $2224
ADDRLP4 348
CNSTF4 1120403456
ASGNF4
LABELV $2224
LABELV $2223
line 5213
;5213:		client->ps.stats[STAT_DETECTOR] = (int) dist;
ADDRLP4 0
INDIRP4
CNSTI4 224
ADDP4
ADDRLP4 348
INDIRF4
CVFI4 4
ASGNI4
line 5214
;5214:	}
ADDRGP4 $2215
JUMPV
LABELV $2214
line 5215
;5215:	else {
line 5216
;5216:		client->ps.stats[STAT_DETECTOR] = -1;
ADDRLP4 0
INDIRP4
CNSTI4 224
ADDP4
CNSTI4 -1
ASGNI4
line 5217
;5217:	}
LABELV $2215
line 5221
;5218:#endif
;5219:
;5220:	// check for respawning
;5221:	if ( client->ps.stats[STAT_HEALTH] <= 0 ) {
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $2226
line 5223
;5222:#if 1	// JUHOX: replace STAT_DEAD_YAW
;5223:		client->ps.viewangles[YAW] = client->deadYaw;
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRF4
ASGNF4
line 5241
;5224:#endif
;5225:#if !RESPAWN_DELAY	// JUHOX: check for automatic respawn
;5226:		// wait for the attack button to be pressed
;5227:		if ( level.time > client->respawnTime ) {
;5228:			// forcerespawn is to prevent users from waiting out powerups
;5229:			if ( g_forcerespawn.integer > 0 && 
;5230:				( level.time - client->respawnTime ) > g_forcerespawn.integer * 1000 ) {
;5231:				respawn( ent );
;5232:				return;
;5233:			}
;5234:		
;5235:			// pressing attack or use is the normal respawn method
;5236:			if ( ucmd->buttons & ( BUTTON_ATTACK | BUTTON_USE_HOLDABLE ) ) {
;5237:				respawn( ent );
;5238:			}
;5239:		}
;5240:#else
;5241:		if (level.time < client->respawnTime) {
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 832
ADDP4
INDIRI4
GEI4 $2228
line 5242
;5242:			client->ps.stats[STAT_RESPAWN_INFO] = -1;	// RLT_invalid
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
CNSTI4 -1
ASGNI4
line 5243
;5243:		}
ADDRGP4 $2030
JUMPV
LABELV $2228
line 5244
;5244:		else {
line 5245
;5245:			if (!client->corpseProduced) {
ADDRLP4 0
INDIRP4
CNSTI4 980
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2231
line 5248
;5246:				vec3_t angles;
;5247:
;5248:				CopyToBodyQue(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CopyToBodyQue
CALLV
pop
line 5249
;5249:				ent->s.eFlags |= EF_NODRAW;
ADDRLP4 364
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 364
INDIRP4
ADDRLP4 364
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 5250
;5250:				ent->client->ps.eFlags |= EF_NODRAW;
ADDRLP4 368
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 368
INDIRP4
ADDRLP4 368
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 5251
;5251:				ent->takedamage = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
CNSTI4 0
ASGNI4
line 5253
;5252:				//SetSpectatorPos(ent);
;5253:				angles[ROLL] = 0;
ADDRLP4 352+8
CNSTF4 0
ASGNF4
line 5254
;5254:				angles[PITCH] = -15;
ADDRLP4 352
CNSTF4 3245342720
ASGNF4
line 5256
;5255:				//angles[YAW] = client->ps.stats[STAT_DEAD_YAW];
;5256:				angles[YAW] = client->deadYaw;
ADDRLP4 352+4
ADDRLP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRF4
ASGNF4
line 5257
;5257:				SetClientViewAngle(ent, angles);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 352
ARGP4
ADDRGP4 SetClientViewAngle
CALLV
pop
line 5258
;5258:				client->ps.stats[STAT_PANT_PHASE] = rand();
ADDRLP4 372
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRLP4 372
INDIRI4
ASGNI4
line 5259
;5259:			}
LABELV $2231
line 5261
;5260:
;5261:			client->ps.stats[STAT_RESPAWN_INFO] = GetRespawnLocationType(ent, msec);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 272
INDIRI4
ARGI4
ADDRLP4 352
ADDRGP4 GetRespawnLocationType
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 352
INDIRI4
ASGNI4
line 5263
;5262:
;5263:			if (client->podMarker && level.time > client->podMarker->s.time + 1000) {
ADDRLP4 0
INDIRP4
CNSTI4 1012
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2235
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 1012
ADDP4
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 1000
ADDI4
LEI4 $2235
line 5264
;5264:				G_FreeEntity(client->podMarker);
ADDRLP4 0
INDIRP4
CNSTI4 1012
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 5265
;5265:				client->podMarker = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 1012
ADDP4
CNSTP4 0
ASGNP4
line 5266
;5266:				client->mayRespawnAtDeathOrigin = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 984
ADDP4
CNSTI4 0
ASGNI4
line 5267
;5267:			}
LABELV $2235
line 5269
;5268:
;5269:			if (level.time < client->respawnTime + client->respawnDelay) {
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 832
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 836
ADDP4
INDIRI4
ADDI4
GEI4 $2238
line 5270
;5270:				client->ps.stats[STAT_RESPAWN_INFO] += (
ADDRLP4 368
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
ASGNP4
ADDRLP4 368
INDIRP4
ADDRLP4 368
INDIRP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 832
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 836
ADDP4
INDIRI4
ADDI4
ADDRGP4 level+32
INDIRI4
SUBI4
CNSTI4 1000
ADDI4
CNSTI4 1000
DIVI4
CNSTI4 2
LSHI4
ADDI4
ASGNI4
line 5275
;5271:					(
;5272:						(client->respawnTime + client->respawnDelay - level.time + 1000) / 1000
;5273:					) << 2
;5274:				);
;5275:			}
ADDRGP4 $2030
JUMPV
LABELV $2238
line 5276
;5276:			else {
line 5279
;5277:				//client->ps.stats[STAT_RESPAWN_TIMER] = 0;
;5278:				if (
;5279:					(ucmd->buttons & (BUTTON_ATTACK | BUTTON_USE_HOLDABLE)) ||
ADDRLP4 268
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 5
BANDI4
CNSTI4 0
NEI4 $2244
ADDRLP4 0
INDIRP4
CNSTI4 836
ADDP4
INDIRI4
CNSTI4 0
GEI4 $2030
LABELV $2244
line 5281
;5280:					client->respawnDelay < 0	// set by ForceRespawn()
;5281:				) {
line 5282
;5282:					respawn(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 respawn
CALLV
pop
line 5283
;5283:				}
line 5284
;5284:			}
line 5285
;5285:		}
line 5287
;5286:#endif
;5287:		return;
ADDRGP4 $2030
JUMPV
LABELV $2226
line 5290
;5288:	}
;5289:
;5290:	ClientRefreshAmmo(ent, msec);	// JUHOX
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 272
INDIRI4
ARGI4
ADDRGP4 ClientRefreshAmmo
CALLV
pop
line 5293
;5291:
;5292:#if 1	// JUHOX: randomize pant phase, so players don't breathe in sync
;5293:	if (client->ps.stats[STAT_STRENGTH] > 2.5*LOW_STRENGTH_VALUE) {
ADDRLP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1172987904
LEF4 $2245
line 5294
;5294:		client->ps.stats[STAT_PANT_PHASE] = rand();
ADDRLP4 348
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRLP4 348
INDIRI4
ASGNI4
line 5295
;5295:	}
LABELV $2245
line 5299
;5296:#endif
;5297:
;5298:#if SPECIAL_VIEW_MODES	// JUHOX: handle pending view toggles
;5299:	if (client->viewMode < 0) {
ADDRLP4 0
INDIRP4
CNSTI4 5592
ADDP4
INDIRI4
CNSTI4 0
GEI4 $2247
line 5301
;5300:		// init viewmode
;5301:		client->viewMode = 0;
ADDRLP4 0
INDIRP4
CNSTI4 5592
ADDP4
CNSTI4 0
ASGNI4
line 5302
;5302:		client->viewModeSwitchTime = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 5596
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 5303
;5303:		trap_SendServerCommand(ent->s.clientNum, "viewmode 0");
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ARGI4
ADDRGP4 $2250
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 5304
;5304:	}
LABELV $2247
line 5307
;5305:
;5306:	if (
;5307:		client->numPendingViewToggles > 0 &&
ADDRLP4 0
INDIRP4
CNSTI4 5600
ADDP4
INDIRI4
CNSTI4 0
LEI4 $2251
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 5596
ADDP4
INDIRI4
CNSTI4 200
ADDI4
LTI4 $2251
line 5309
;5308:		level.time >= client->viewModeSwitchTime + VIEWMODE_SWITCHING_TIME
;5309:	) {
line 5310
;5310:		client->viewMode++;
ADDRLP4 352
ADDRLP4 0
INDIRP4
CNSTI4 5592
ADDP4
ASGNP4
ADDRLP4 352
INDIRP4
ADDRLP4 352
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 5311
;5311:		if (client->viewMode >= VIEW_num_modes) {
ADDRLP4 0
INDIRP4
CNSTI4 5592
ADDP4
INDIRI4
CNSTI4 3
LTI4 $2254
line 5312
;5312:			client->viewMode = 0;
ADDRLP4 0
INDIRP4
CNSTI4 5592
ADDP4
CNSTI4 0
ASGNI4
line 5313
;5313:		}
LABELV $2254
line 5314
;5314:		client->viewModeSwitchTime = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 5596
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 5315
;5315:		trap_SendServerCommand(ent->s.clientNum, va("viewmode %d", client->viewMode));
ADDRGP4 $2257
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 5592
ADDP4
INDIRI4
ARGI4
ADDRLP4 356
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ARGI4
ADDRLP4 356
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 5316
;5316:		client->numPendingViewToggles--;
ADDRLP4 360
ADDRLP4 0
INDIRP4
CNSTI4 5600
ADDP4
ASGNP4
ADDRLP4 360
INDIRP4
ADDRLP4 360
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 5317
;5317:	}
LABELV $2251
line 5321
;5318:#endif
;5319:
;5320:	// perform once-a-second actions
;5321:	ClientTimerActions( ent, msec );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 272
INDIRI4
ARGI4
ADDRGP4 ClientTimerActions
CALLV
pop
line 5322
;5322:}
LABELV $2030
endproc ClientThink_real 412 16
export ClientThink
proc ClientThink 4 8
line 5331
;5323:
;5324:/*
;5325:==================
;5326:ClientThink
;5327:
;5328:A new command has arrived from the client
;5329:==================
;5330:*/
;5331:void ClientThink( int clientNum ) {
line 5334
;5332:	gentity_t *ent;
;5333:
;5334:	ent = g_entities + clientNum;
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 5335
;5335:	trap_GetUsercmd( clientNum, &ent->client->pers.cmd );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 472
ADDP4
ARGP4
ADDRGP4 trap_GetUsercmd
CALLV
pop
line 5339
;5336:
;5337:	// mark the time we got info, so we can display the
;5338:	// phone jack if they don't get any for a while
;5339:	ent->client->lastCmdTime = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 732
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 5341
;5340:
;5341:	if ( !(ent->r.svFlags & SVF_BOT) && !g_synchronousClients.integer ) {
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $2260
ADDRGP4 g_synchronousClients+12
INDIRI4
CNSTI4 0
NEI4 $2260
line 5342
;5342:		ClientThink_real( ent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 ClientThink_real
CALLV
pop
line 5343
;5343:	}
LABELV $2260
line 5344
;5344:}
LABELV $2258
endproc ClientThink 4 8
export G_RunClient
proc G_RunClient 0 4
line 5347
;5345:
;5346:
;5347:void G_RunClient( gentity_t *ent ) {
line 5348
;5348:	if ( !(ent->r.svFlags & SVF_BOT) && !g_synchronousClients.integer ) {
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $2264
ADDRGP4 g_synchronousClients+12
INDIRI4
CNSTI4 0
NEI4 $2264
line 5349
;5349:		return;
ADDRGP4 $2263
JUMPV
LABELV $2264
line 5351
;5350:	}
;5351:	ent->client->pers.cmd.serverTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 472
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 5352
;5352:	ClientThink_real( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 ClientThink_real
CALLV
pop
line 5353
;5353:}
LABELV $2263
endproc G_RunClient 0 4
export SpectatorClientEndFrame
proc SpectatorClientEndFrame 20 4
line 5362
;5354:
;5355:
;5356:/*
;5357:==================
;5358:SpectatorClientEndFrame
;5359:
;5360:==================
;5361:*/
;5362:void SpectatorClientEndFrame( gentity_t *ent ) {
line 5366
;5363:	gclient_t	*cl;
;5364:
;5365:	// if we are doing a chase cam or a remote view, grab the latest info
;5366:	if ( ent->client->sess.spectatorState == SPECTATOR_FOLLOW ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 704
ADDP4
INDIRI4
CNSTI4 2
NEI4 $2269
line 5369
;5367:		int		clientNum, flags;
;5368:
;5369:		clientNum = ent->client->sess.spectatorClient;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 708
ADDP4
INDIRI4
ASGNI4
line 5372
;5370:
;5371:		// team follow1 and team follow2 go to whatever clients are playing
;5372:		if ( clientNum == -1 ) {
ADDRLP4 4
INDIRI4
CNSTI4 -1
NEI4 $2271
line 5373
;5373:			clientNum = level.follow1;
ADDRLP4 4
ADDRGP4 level+356
INDIRI4
ASGNI4
line 5374
;5374:		} else if ( clientNum == -2 ) {
ADDRGP4 $2272
JUMPV
LABELV $2271
ADDRLP4 4
INDIRI4
CNSTI4 -2
NEI4 $2274
line 5375
;5375:			clientNum = level.follow2;
ADDRLP4 4
ADDRGP4 level+360
INDIRI4
ASGNI4
line 5376
;5376:		}
LABELV $2274
LABELV $2272
line 5377
;5377:		if ( clientNum >= 0 ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $2277
line 5378
;5378:			cl = &level.clients[ clientNum ];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 5379
;5379:			if ( cl->pers.connected == CON_CONNECTED && cl->sess.sessionTeam != TEAM_SPECTATOR ) {
ADDRLP4 12
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $2279
ADDRLP4 12
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 3
EQI4 $2279
line 5380
;5380:				flags = (cl->ps.eFlags & ~(EF_VOTED | EF_TEAMVOTED)) | (ent->client->ps.eFlags & (EF_VOTED | EF_TEAMVOTED));
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
CNSTI4 -16387
BANDI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
CNSTI4 16386
BANDI4
BORI4
ASGNI4
line 5381
;5381:				ent->client->ps = cl->ps;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ADDRLP4 0
INDIRP4
INDIRB
ASGNB 468
line 5382
;5382:				ent->client->ps.pm_flags |= PMF_FOLLOW;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 4096
BORI4
ASGNI4
line 5383
;5383:				ent->client->ps.eFlags = flags;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 5384
;5384:				return;
ADDRGP4 $2268
JUMPV
LABELV $2279
line 5385
;5385:			} else {
line 5387
;5386:				// drop them to free spectators unless they are dedicated camera followers
;5387:				if ( ent->client->sess.spectatorClient >= 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 708
ADDP4
INDIRI4
CNSTI4 0
LTI4 $2281
line 5388
;5388:					ent->client->sess.spectatorState = SPECTATOR_FREE;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 704
ADDP4
CNSTI4 1
ASGNI4
line 5389
;5389:					ClientBegin( ent->client - level.clients );
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 level
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 5604
DIVI4
ARGI4
ADDRGP4 ClientBegin
CALLV
pop
line 5390
;5390:				}
LABELV $2281
line 5391
;5391:			}
line 5392
;5392:		}
LABELV $2277
line 5393
;5393:	}
LABELV $2269
line 5395
;5394:
;5395:	if ( ent->client->sess.spectatorState == SPECTATOR_SCOREBOARD ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 704
ADDP4
INDIRI4
CNSTI4 3
NEI4 $2283
line 5396
;5396:		ent->client->ps.pm_flags |= PMF_SCOREBOARD;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 8192
BORI4
ASGNI4
line 5397
;5397:	} else {
ADDRGP4 $2284
JUMPV
LABELV $2283
line 5398
;5398:		ent->client->ps.pm_flags &= ~PMF_SCOREBOARD;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -8193
BANDI4
ASGNI4
line 5399
;5399:	}
LABELV $2284
line 5400
;5400:}
LABELV $2268
endproc SpectatorClientEndFrame 20 4
export ClientEndFrame
proc ClientEndFrame 16 16
line 5411
;5401:
;5402:/*
;5403:==============
;5404:ClientEndFrame
;5405:
;5406:Called at the end of each server frame for each connected client
;5407:A fast client will have multiple ClientThink for each ClientEdFrame,
;5408:while a slow client may have multiple ClientEndFrame between ClientThink.
;5409:==============
;5410:*/
;5411:void ClientEndFrame( gentity_t *ent ) {
line 5415
;5412:	int			i;
;5413:	clientPersistant_t	*pers;
;5414:
;5415:	if ( ent->client->sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 3
NEI4 $2286
line 5416
;5416:		SpectatorClientEndFrame( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 SpectatorClientEndFrame
CALLV
pop
line 5417
;5417:		return;
ADDRGP4 $2285
JUMPV
LABELV $2286
line 5420
;5418:	}
;5419:
;5420:	pers = &ent->client->pers;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 468
ADDP4
ASGNP4
line 5423
;5421:
;5422:	// turn off any expired powerups
;5423:	for ( i = 0 ; i < /*MAX_POWERUPS*/PW_NUM_POWERUPS ; i++ ) {	// JUHOX
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2288
line 5424
;5424:		if ( ent->client->ps.powerups[ i ] < level.time ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
GEI4 $2292
line 5425
;5425:			ent->client->ps.powerups[ i ] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
CNSTI4 0
ASGNI4
line 5426
;5426:		}
LABELV $2292
line 5427
;5427:	}
LABELV $2289
line 5423
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 13
LTI4 $2288
line 5429
;5428:#if 1	// JUHOX: turn off expired PW_EFFECT_TIME
;5429:	if (ent->client->ps.powerups[PW_EFFECT_TIME] < level.time) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 364
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
GEI4 $2295
line 5430
;5430:		ent->client->ps.powerups[PW_EFFECT_TIME] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 364
ADDP4
CNSTI4 0
ASGNI4
line 5431
;5431:	}
LABELV $2295
line 5465
;5432:#endif
;5433:
;5434:#ifdef MISSIONPACK
;5435:	// set powerup for player animation
;5436:	if( bg_itemlist[ent->client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_GUARD ) {
;5437:		ent->client->ps.powerups[PW_GUARD] = level.time;
;5438:	}
;5439:	if( bg_itemlist[ent->client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_SCOUT ) {
;5440:		ent->client->ps.powerups[PW_SCOUT] = level.time;
;5441:	}
;5442:	if( bg_itemlist[ent->client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_DOUBLER ) {
;5443:		ent->client->ps.powerups[PW_DOUBLER] = level.time;
;5444:	}
;5445:	if( bg_itemlist[ent->client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_AMMOREGEN ) {
;5446:		ent->client->ps.powerups[PW_AMMOREGEN] = level.time;
;5447:	}
;5448:	if ( ent->client->invulnerabilityTime > level.time ) {
;5449:		ent->client->ps.powerups[PW_INVULNERABILITY] = level.time;
;5450:	}
;5451:#endif
;5452:
;5453:	// save network bandwidth
;5454:#if 0
;5455:	if ( !g_synchronousClients->integer && ent->client->ps.pm_type == PM_NORMAL ) {
;5456:		// FIXME: this must change eventually for non-sync demo recording
;5457:		VectorClear( ent->client->ps.viewangles );
;5458:	}
;5459:#endif
;5460:
;5461:	//
;5462:	// If the end of unit layout is displayed, don't give
;5463:	// the player any normal movement attributes
;5464:	//
;5465:	if ( level.intermissiontime ) {
ADDRGP4 level+9144
INDIRI4
CNSTI4 0
EQI4 $2298
line 5466
;5466:		return;
ADDRGP4 $2285
JUMPV
LABELV $2298
line 5470
;5467:	}
;5468:
;5469:	// burn from lava, etc
;5470:	P_WorldEffects (ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 P_WorldEffects
CALLV
pop
line 5473
;5471:
;5472:	// apply all the damage taken this frame
;5473:	P_DamageFeedback (ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 P_DamageFeedback
CALLV
pop
line 5476
;5474:
;5475:	// add the EF_CONNECTION flag if we haven't gotten commands recently
;5476:	if ( level.time - ent->client->lastCmdTime > 1000 ) {
ADDRGP4 level+32
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
SUBI4
CNSTI4 1000
LEI4 $2301
line 5477
;5477:		ent->s.eFlags |= EF_CONNECTION;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 8192
BORI4
ASGNI4
line 5478
;5478:	} else {
ADDRGP4 $2302
JUMPV
LABELV $2301
line 5479
;5479:		ent->s.eFlags &= ~EF_CONNECTION;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 -8193
BANDI4
ASGNI4
line 5480
;5480:	}
LABELV $2302
line 5482
;5481:
;5482:	ent->client->ps.stats[STAT_HEALTH] = ent->health;	// FIXME: get rid of ent->health...
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
ASGNI4
line 5484
;5483:
;5484:	G_SetClientSound (ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_SetClientSound
CALLV
pop
line 5487
;5485:
;5486:	// set the latest infor
;5487:	if (g_smoothClients.integer) {
ADDRGP4 g_smoothClients+12
INDIRI4
CNSTI4 0
EQI4 $2304
line 5488
;5488:		BG_PlayerStateToEntityStateExtraPolate( &ent->client->ps, &ent->s, ent->client->ps.commandTime, qtrue );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BG_PlayerStateToEntityStateExtraPolate
CALLV
pop
line 5489
;5489:	}
ADDRGP4 $2305
JUMPV
LABELV $2304
line 5490
;5490:	else {
line 5491
;5491:		BG_PlayerStateToEntityState( &ent->client->ps, &ent->s, qtrue );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BG_PlayerStateToEntityState
CALLV
pop
line 5492
;5492:	}
LABELV $2305
line 5493
;5493:	SendPendingPredictableEvents( &ent->client->ps );
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRGP4 SendPendingPredictableEvents
CALLV
pop
line 5498
;5494:
;5495:	// set the bit for the reachability area the client is currently in
;5496://	i = trap_AAS_PointReachabilityAreaIndex( ent->client->ps.origin );
;5497://	ent->client->areabits[i >> 3] |= 1 << (i & 7);
;5498:}
LABELV $2285
endproc ClientEndFrame 16 16
import BotTestSolid
bss
align 4
LABELV tempRope
skip 4480
import PM_StepSlideMove
import PM_SlideMove
import PM_AddEvent
import PM_AddTouchEnt
import PM_ClipVelocity
import c_pmove
import pm_flightfriction
import pm_waterfriction
import pm_friction
import pm_flyaccelerate
import pm_wateraccelerate
import pm_airaccelerate
import pm_accelerate
import pm_wadeScale
import pm_swimScale
import pm_duckScale
import pm_stopspeed
import pml
import pm
align 4
LABELV numVisitedAreas
skip 4
align 4
LABELV visitedAreas
skip 2000
align 4
LABELV tssRescueSchedule
skip 516
align 4
LABELV tssGoalDistanceCache
skip 2560
align 4
LABELV tssEnemyBase
skip 4
align 4
LABELV tssHomeBase
skip 4
align 4
LABELV tssGroupInfo
skip 1480
align 4
LABELV tssNumPlayersAlive
skip 4
align 4
LABELV tssGroupAssignments
skip 2560
align 4
LABELV tssNumGroupAssignments
skip 4
align 4
LABELV tssFlagCarrier
skip 4
import BotEnemyFlagStatus
import BotOwnFlagStatus
import LocateFlag
import FindDroppedFlag
import GetItemGoal
import BotDetermineVisibleTeammates
import BotGetNextTeamMate
import BotGetNextPlayerOrMonster
import BotGetNextPlayer
import BotVoiceChatOnly
import BotVoiceChat
import BotSetTeamMateTaskPreference
import BotGetTeamMateTaskPreference
import BotTeamAI
import ctf_blueflag
import ctf_redflag
import bot_challenge
import bot_testrchat
import bot_nochat
import bot_fastchat
import bot_rocketjump
import bot_grapple
import maxclients
import gametype
import BotMapScripts
import BotPointAreaNum
import ClientOnSameTeamFromName
import ClientFromName
import stristr
import BotFindWayPoint
import BotCreateWayPoint
import BotAlternateRoute
import BotGetAlternateRouteGoal
import BotCTFRetreatGoals
import BotCTFSeekGoals
import BotRememberLastOrderedTask
import BotCTFCarryingFlag
import BotOppositeTeam
import BotTeam
import BotClearActivateGoalStack
import BotPopFromActivateGoalStack
import BotEnableActivateGoalAreas
import BotAIPredictObstacles
import BotAIBlocked
import BotCheckAttack
import BotAimAtEnemy
import BotEntityVisible
import BotRoamGoal
import BotFindEnemy
import InFieldOfVision
import BotVisibleTeamMatesAndEnemies
import BotEnemyFlagCarrierVisible
import BotTeamFlagCarrierVisible
import BotTeamFlagCarrier
import TeamPlayIsOn
import BotSameTeam
import BotAttackMove
import BotWantsToCamp
import BotHasPersistantPowerupAndWeapon
import BotCanAndWantsToRocketJump
import BotWantsToHelp
import BotWantsToChase
import BotWantsToRetreat
import BotWantsToEscape
import BotFeelingBad
import BotAggression
import BotTeamGoals
import BotSetLastOrderedTask
import BotSynonymContext
import ClientSkin
import EasyClientName
import ClientName
import BotSetTeamStatus
import BotSetUserInfo
import EntityIsShooting
import EntityIsInvisible
import EntityIsDead
import BotInLavaOrSlime
import BotIntermission
import BotIsObserver
import BotIsDead
import BotBattleUseItems
import BotUpdateBattleInventory
import BotUpdateInventory
import BotSetupForMovement
import BotChooseWeapon
import BotPlayerDanger
import BotPlayerKillDamage
import BotHoldableItemIsUsefulForPlayer
import BotUnlimitedHealthIsUsefulForPlayer
import BotLimitedHealthIsUsefulForPlayer
import BotArmorIsUsefulForPlayer
import BotFreeWaypoints
import BotDeathmatchAI
import BotShutdownDeathmatchAI
import BotSetupDeathmatchAI
import LTGNearlyFulfilled
import BotEnemyTooStrong
import BotCreateItemGoal
import BotFindCTFBases
import BotReactionTime
import BotTeamLeader
import BotAI_GetSnapshotEntity
import BotAI_GetEntityState
import BotAI_GetClientState
import BotAI_Trace
import BotAI_BotInitialChat
import BotAI_Print
import BotAI_IsBot
import floattime
import BotEntityInfo
import NumBots
import BotResetState
import BotResetWeaponState
import BotFreeWeaponState
import BotAllocWeaponState
import BotLoadWeaponWeights
import BotGetWeaponInfo
import BotChooseBestFightWeapon
import BotShutdownWeaponAI
import BotSetupWeaponAI
import BotShutdownMoveAI
import BotSetupMoveAI
import BotSetBrushModelTypes
import BotAddAvoidSpot
import BotInitMoveState
import BotFreeMoveState
import BotAllocMoveState
import BotPredictVisiblePosition
import BotMovementViewTarget
import BotReachabilityArea
import BotResetLastAvoidReach
import BotResetAvoidReach
import BotMoveInDirection
import BotMoveToGoal
import BotResetMoveState
import BotShutdownGoalAI
import BotSetupGoalAI
import BotFreeGoalState
import BotAllocGoalState
import BotFreeItemWeights
import BotLoadItemWeights
import BotMutateGoalFuzzyLogic
import BotSaveGoalFuzzyLogic
import BotInterbreedGoalFuzzyLogic
import BotUpdateEntityItems
import BotInitLevelItems
import BotSetAvoidGoalTime
import BotAvoidGoalTime
import BotGetMapLocationGoal
import BotGetNextCampSpotGoal
import BotGetLevelItemGoal
import BotItemGoalInVisButNotVisible
import BotTouchingGoal
import BotChooseNBGItem
import BotChooseLTGItem
import BotGetSecondGoal
import BotGetTopGoal
import BotGoalName
import BotDumpGoalStack
import BotDumpAvoidGoals
import BotEmptyGoalStack
import BotPopGoal
import BotPushGoal
import BotRemoveFromAvoidGoals
import BotResetAvoidGoals
import BotResetGoalState
import GeneticParentsAndChildSelection
import BotSetChatName
import BotSetChatGender
import BotLoadChatFile
import BotReplaceSynonyms
import UnifyWhiteSpaces
import BotMatchVariable
import BotFindMatch
import StringContains
import BotGetChatMessage
import BotEnterChat
import BotChatLength
import BotReplyChat
import BotNumInitialChats
import BotInitialChat
import BotNumConsoleMessages
import BotNextConsoleMessage
import BotRemoveConsoleMessage
import BotQueueConsoleMessage
import BotFreeChatState
import BotAllocChatState
import BotShutdownChatAI
import BotSetupChatAI
import BotShutdownCharacters
import Characteristic_String
import Characteristic_BInteger
import Characteristic_Integer
import Characteristic_BFloat
import Characteristic_Float
import BotFreeCharacter
import BotLoadCharacter
import EA_Shutdown
import EA_Setup
import EA_ResetInput
import EA_GetInput
import EA_EndRegular
import EA_View
import EA_Move
import EA_DelayedJump
import EA_Jump
import EA_SelectWeapon
import EA_Use
import EA_Gesture
import EA_Talk
import EA_Respawn
import EA_Attack
import EA_MoveRight
import EA_MoveLeft
import EA_MoveBack
import EA_MoveForward
import EA_MoveDown
import EA_MoveUp
import EA_Walk
import EA_Crouch
import EA_Action
import EA_Command
import EA_SayTeam
import EA_Say
import GetBotLibAPI
import trap_SnapVector
import trap_GeneticParentsAndChildSelection
import trap_BotResetWeaponState
import trap_BotFreeWeaponState
import trap_BotAllocWeaponState
import trap_BotLoadWeaponWeights
import trap_BotGetWeaponInfo
import trap_BotChooseBestFightWeapon
import trap_BotAddAvoidSpot
import trap_BotInitMoveState
import trap_BotFreeMoveState
import trap_BotAllocMoveState
import trap_BotPredictVisiblePosition
import trap_BotMovementViewTarget
import trap_BotReachabilityArea
import trap_BotResetLastAvoidReach
import trap_BotResetAvoidReach
import trap_BotMoveInDirection
import trap_BotMoveToGoal
import trap_BotResetMoveState
import trap_BotFreeGoalState
import trap_BotAllocGoalState
import trap_BotMutateGoalFuzzyLogic
import trap_BotSaveGoalFuzzyLogic
import trap_BotInterbreedGoalFuzzyLogic
import trap_BotFreeItemWeights
import trap_BotLoadItemWeights
import trap_BotUpdateEntityItems
import trap_BotInitLevelItems
import trap_BotSetAvoidGoalTime
import trap_BotAvoidGoalTime
import trap_BotGetLevelItemGoal
import trap_BotGetMapLocationGoal
import trap_BotGetNextCampSpotGoal
import trap_BotItemGoalInVisButNotVisible
import trap_BotTouchingGoal
import trap_BotChooseNBGItem
import trap_BotChooseLTGItem
import trap_BotGetSecondGoal
import trap_BotGetTopGoal
import trap_BotGoalName
import trap_BotDumpGoalStack
import trap_BotDumpAvoidGoals
import trap_BotEmptyGoalStack
import trap_BotPopGoal
import trap_BotPushGoal
import trap_BotResetAvoidGoals
import trap_BotRemoveFromAvoidGoals
import trap_BotResetGoalState
import trap_BotSetChatName
import trap_BotSetChatGender
import trap_BotLoadChatFile
import trap_BotReplaceSynonyms
import trap_UnifyWhiteSpaces
import trap_BotMatchVariable
import trap_BotFindMatch
import trap_StringContains
import trap_BotGetChatMessage
import trap_BotEnterChat
import trap_BotChatLength
import trap_BotReplyChat
import trap_BotNumInitialChats
import trap_BotInitialChat
import trap_BotNumConsoleMessages
import trap_BotNextConsoleMessage
import trap_BotRemoveConsoleMessage
import trap_BotQueueConsoleMessage
import trap_BotFreeChatState
import trap_BotAllocChatState
import trap_Characteristic_String
import trap_Characteristic_BInteger
import trap_Characteristic_Integer
import trap_Characteristic_BFloat
import trap_Characteristic_Float
import trap_BotFreeCharacter
import trap_BotLoadCharacter
import trap_EA_ResetInput
import trap_EA_GetInput
import trap_EA_EndRegular
import trap_EA_View
import trap_EA_Move
import trap_EA_DelayedJump
import trap_EA_Jump
import trap_EA_SelectWeapon
import trap_EA_MoveRight
import trap_EA_MoveLeft
import trap_EA_MoveBack
import trap_EA_MoveForward
import trap_EA_MoveDown
import trap_EA_MoveUp
import trap_EA_Crouch
import trap_EA_Respawn
import trap_EA_Use
import trap_EA_Attack
import trap_EA_Talk
import trap_EA_Gesture
import trap_EA_Action
import trap_EA_Command
import trap_EA_SayTeam
import trap_EA_Say
import trap_AAS_PredictClientMovement
import trap_AAS_Swimming
import trap_AAS_AlternativeRouteGoals
import trap_AAS_PredictRoute
import trap_AAS_EnableRoutingArea
import trap_AAS_AreaTravelTimeToGoalArea
import trap_AAS_AreaReachability
import trap_AAS_IntForBSPEpairKey
import trap_AAS_FloatForBSPEpairKey
import trap_AAS_VectorForBSPEpairKey
import trap_AAS_ValueForBSPEpairKey
import trap_AAS_NextBSPEntity
import trap_AAS_PointContents
import trap_AAS_TraceAreas
import trap_AAS_PointReachabilityAreaIndex
import trap_AAS_PointAreaNum
import trap_AAS_Time
import trap_AAS_PresenceTypeBoundingBox
import trap_AAS_Initialized
import trap_AAS_EntityInfo
import trap_AAS_AreaInfo
import trap_AAS_BBoxAreas
import trap_BotUserCommand
import trap_BotGetServerCommand
import trap_BotGetSnapshotEntity
import trap_BotLibTest
import trap_BotLibUpdateEntity
import trap_BotLibLoadMap
import trap_BotLibStartFrame
import trap_BotLibDefine
import trap_BotLibVarGet
import trap_BotLibVarSet
import trap_BotLibShutdown
import trap_BotLibSetup
import trap_DebugPolygonDelete
import trap_DebugPolygonCreate
import trap_GetEntityToken
import trap_GetUsercmd
import trap_BotFreeClient
import trap_BotAllocateClient
import trap_EntityContact
import trap_EntitiesInBox
import trap_UnlinkEntity
import trap_LinkEntity
import trap_AreasConnected
import trap_AdjustAreaPortalState
import trap_InPVSIgnorePortals
import trap_InPVS
import trap_PointContents
import trap_Trace
import trap_SetBrushModel
import trap_GetServerinfo
import trap_SetUserinfo
import trap_GetUserinfo
import trap_GetConfigstring
import trap_SetConfigstring
import trap_SendServerCommand
import trap_DropClient
import trap_LocateGameData
import trap_Cvar_VariableStringBuffer
import trap_Cvar_VariableValue
import trap_Cvar_VariableIntegerValue
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_SendConsoleCommand
import trap_FS_Seek
import trap_FS_GetFileList
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_FS_FOpenFile
import trap_Args
import trap_Argv
import trap_Argc
import trap_Milliseconds
import trap_Error
import trap_Printf
import g_mapName
import g_proxMineTimeout
import g_singlePlayer
import g_enableBreath
import g_enableDust
import g_rankings
import pmove_msec
import pmove_fixed
import g_smoothClients
import g_blueteam
import g_redteam
import g_cubeTimeout
import g_obeliskRespawnDelay
import g_obeliskRegenAmount
import g_obeliskRegenPeriod
import g_obeliskHealth
import g_filterBan
import g_banIPs
import g_teamForceBalance
import g_teamAutoJoin
import g_allowVote
import g_blood
import g_doWarmup
import g_warmup
import g_motd
import g_synchronousClients
import g_weaponTeamRespawn
import g_weaponRespawn
import g_debugDamage
import g_debugAlloc
import g_debugMove
import g_inactivity
import g_forcerespawn
import g_quadfactor
import g_knockback
import g_speed
import g_gravity
import g_needpass
import g_password
import g_friendlyFire
import g_meeting
import g_weaponLimit
import g_cloakingDevice
import g_unlimitedAmmo
import g_noHealthRegen
import g_noItems
import g_grapple
import g_lightningDamageLimit
import g_baseHealth
import g_stamina
import g_armorFragments
import g_tssSafetyMode
import g_tss
import g_respawnAtPOD
import g_respawnDelay
import g_gameSeed
import g_template
import g_debugEFH
import g_challengingEnv
import g_distanceLimit
import g_monsterLoad
import g_scoreMode
import g_monsterProgression
import g_monsterBreeding
import g_maxMonstersPP
import g_monsterLauncher
import g_skipEndSequence
import g_monstersPerTrap
import g_monsterTitans
import g_monsterGuards
import g_monsterHealthScale
import g_monsterSpawnDelay
import g_maxMonsters
import g_minMonsters
import g_artefacts
import g_capturelimit
import g_timelimit
import g_fraglimit
import g_dmflags
import g_restarted
import g_maxGameClients
import g_maxclients
import g_cheats
import g_dedicated
import g_gametype
import g_editmode
import g_entities
import level
import Pickup_Team
import CheckTeamStatus
import TeamplayInfoMessage
import Team_GetLocationMsg
import Team_GetLocation
import SelectCTFSpawnPoint
import Team_FreeEntity
import Team_ReturnFlag
import Team_InitGame
import Team_CheckHurtCarrier
import Team_FragBonuses
import Team_DroppedFlagThink
import AddTeamScore
import TeamColorString
import OtherTeamName
import TeamName
import OtherTeam
import BotTestAAS
import BotAIStartFrame
import BotAIShutdownClient
import BotAISetupClient
import BotAILoadMap
import BotAIShutdown
import BotAISetup
import IsPlayerFighting
import G_Constitution
import G_GetEntityPlayerState
import EntityAudible
import G_MonsterAction
import G_CheckMonsterDamage
import G_GetMonsterGeneric1
import G_IsMovable
import G_CanBeDamaged
import G_UpdateMonsterCounters
import G_AddMonsterSeed
import G_ReleaseTrap
import G_IsFriendlyMonster
import G_MonsterOwner
import G_IsAttackingGuard
import G_ChargeMonsters
import G_IsMonsterSuccessfulAttacking
import G_IsMonsterNearEntity
import IsFightingMonster
import G_MonsterSpawning
import G_SpawnMonster
import G_MonsterType
import G_MonsterBaseHealth
import G_MonsterHealthScale
import G_GetMonsterSpawnPoint
import G_GetMonsterBounds
import G_KillMonster
import G_MonsterScanForNoises
import CheckTouchedMonsters
import G_NumMonsters
import G_UpdateMonsterCS
import G_InitMonsters
import BotInterbreedEndMatch
import Svcmd_BotList_f
import Svcmd_AddBot_f
import G_BotConnect
import G_RemoveQueuedBotBegin
import G_CheckBotSpawn
import G_GetBotInfoByName
import G_GetBotInfoByNumber
import G_InitBots
import Svcmd_AbortPodium_f
import SpawnModelsOnVictoryPads
import UpdateTournamentInfo
import G_WriteSessionData
import G_InitWorldSession
import G_InitSessionData
import G_ReadSessionData
import Svcmd_GameMem_f
import G_InitMemory
import G_Alloc
import CheckObeliskAttack
import Team_GetDroppedOrTakenFlag
import Team_CheckDroppedItem
import OnSameTeam
import Team_GetFlagStatus
import ClientCommand
import ClientBegin
import ClientDisconnect
import ClientUserinfoChanged
import ClientSetPlayerClass
import ClientConnect
import SelectAppropriateSpawnPoint
import LogExit
import G_Error
import G_Printf
import SendScoreboardMessageToAllClients
import G_LogPrintf
import G_RunThink
import G_SetPlayerRefOrigin
import CheckTeamLeader
import SetLeader
import FindIntermissionPoint
import DeathmatchScoreboardMessage
import G_SetStats
import MoveClientToIntermission
import FireWeapon
import G_FilterPacket
import G_ProcessIPBans
import ConsoleCommand
import PositionWouldTelefrag
import SpotWouldTelefrag
import CalculateRanks
import AddScore
import player_die
import ClientSpawn
import InitBodyQue
import InitClientResp
import InitClientPersistant
import BeginIntermission
import respawn
import CopyToBodyQue
import SelectSpawnPoint
import SetClientViewAngle
import PickTeam
import TeamLeader
import TeamCount
import GetRespawnLocationType
import ForceRespawn
import Weapon_HookThink
import Weapon_HookFree
import CheckTitanAttack
import CheckGauntletAttack
import SnapVectorTowards
import CalcMuzzlePoint
import LogAccuracyHit
import Weapon_GrapplingHook_Throw
import TeleportPlayer
import trigger_teleporter_touch
import InitMover
import Touch_DoorTrigger
import G_RunMover
import fire_monster_seed
import fire_grapple
import fire_bfg
import fire_rocket
import fire_grenade
import fire_plasma
import fire_blaster
import G_RunMissile
import GibEntity
import ScorePlum
import DropArmor
import DropHealth
import TossClientCubes
import TossClientItems
import body_die
import G_InvulnerabilityEffect
import G_RadiusDamage
import G_Damage
import CanDamage
import DoOverkill
import BuildShaderStateConfig
import AddRemap
import G_SetOrigin
import G_AddEvent
import G_AddPredictableEvent
import vectoyaw
import vtos
import tv
import G_acos
import G_TouchSolids
import G_EntitiesFree
import G_FreeEntity
import G_Sound
import G_TempEntity
import G_NumEntitiesFree
import G_Spawn
import G_InitGentity
import G_SetMovedir
import G_UseTargets
import G_PickTarget
import G_Find
import G_KillBox
import G_TeamCommand
import G_SoundIndex
import G_ModelIndex
import SaveRegisteredItems
import RegisterItem
import ClearRegisteredItems
import G_SpawnArtefact
import G_BounceItemRotation
import Touch_Item
import Add_Ammo
import ArmorIndex
import Think_Weapon
import FinishSpawningItem
import G_SpawnItem
import SetRespawn
import LaunchItem
import Drop_Item
import PrecacheItem
import UseHoldableItem
import RespawnItem
import G_RunItem
import G_CheckTeamItems
import G_Say
import Cmd_FollowCycle_f
import SetTeam
import BroadcastTeamChange
import StopFollowing
import Cmd_Score_f
import G_EFH_NextDebugSegment
import G_EFH_SpaceExtent
import G_UpdateLightingOrigins
import G_GetTotalWayLength
import G_MakeWorldAwareOfMonsterDeath
import G_FindSegment
import G_UpdateWorld
import G_SpawnWorld
import G_InitWorldSystem
import G_NewString
import G_SpawnEntitiesFromString
import G_SpawnVector
import G_SpawnInt
import G_SpawnFloat
import G_SpawnString
import G_PlayTemplate
import G_PrintTemplateList
import G_SendGameTemplate
import G_TemplateList_Error
import G_TemplateList_Stop
import G_TemplateList_Request
import G_RestartGameTemplates
import G_DefineTemplate
import G_SetTemplateName
import G_LoadGameTemplates
import G_InitGameTemplates
import sv_mapChecksum
import templateList
import numTemplateFiles
import templateFileList
import InitLocalSeed
import SeededRandom
import SetGameSeed
import BG_PlayerTargetOffset
import BG_PlayerTouchesItem
import BG_PlayerStateToEntityStateExtraPolate
import BG_PlayerStateToEntityState
import BG_TouchJumpPad
import BG_AddPredictableEventToPlayerstate
import BG_EvaluateTrajectoryDelta
import BG_EvaluateTrajectory
import BG_CanItemBeGrabbed
import BG_FindItemForHoldable
import BG_FindItemForPowerup
import BG_FindItemForWeapon
import BG_FindItem
import bg_numItems
import bg_itemlist
import weaponAmmoCharacteristics
import Pmove
import PM_UpdateViewAngles
import BG_TSS_GetPlayerEntityInfo
import BG_TSS_GetPlayerInfo
import BG_TSS_SetPlayerInfo
import BG_TSS_DecodeLeadership
import BG_TSS_CodeLeadership
import BG_TSS_DecodeInstructions
import BG_TSS_CodeInstructions
import TSS_DecodeInt
import TSS_CodeInt
import TSS_DecodeNibble
import TSS_CodeNibble
import BG_TSS_AssignPlayers
import BG_TSS_TakeProportionAway
import BG_TSS_Proportion
import BG_VectorChecksum
import BG_ChecksumChar
import BG_TemplateChecksum
import BG_GetGameTemplateList
import BG_ParseGameTemplate
import local_crandom
import local_random
import DeriveLocalSeed
import LocallySeededRandom
import Com_Printf
import Com_Error
import Info_NextPair
import Info_Validate
import Info_SetValueForKey_Big
import Info_SetValueForKey
import Info_RemoveKey_big
import Info_RemoveKey
import Info_ValueForKey
import va
import Q_CleanStr
import Q_PrintStrlen
import Q_strcat
import Q_strncpyz
import Q_strrchr
import Q_strupr
import Q_strlwr
import Q_stricmpn
import Q_strncmp
import Q_stricmp
import Q_isalpha
import Q_isupper
import Q_islower
import Q_isprint
import Com_sprintf
import Parse3DMatrix
import Parse2DMatrix
import Parse1DMatrix
import SkipRestOfLine
import SkipBracedSection
import COM_MatchToken
import COM_ParseWarning
import COM_ParseError
import COM_Compress
import COM_ParseExt
import COM_Parse
import COM_GetCurrentParseLine
import COM_BeginParseSession
import COM_DefaultExtension
import COM_StripExtension
import COM_SkipPath
import Com_Clamp
import PerpendicularVector
import AngleVectors
import MatrixMultiply
import MakeNormalVectors
import RotateAroundDirection
import RotatePointAroundVector
import ProjectPointOnPlane
import PlaneFromPoints
import AngleDelta
import AngleNormalize180
import AngleNormalize360
import AnglesSubtract
import AngleSubtract
import LerpAngle
import AngleMod
import BoxOnPlaneSide
import SetPlaneSignbits
import AxisCopy
import AxisClear
import AnglesToAxis
import vectoangles
import lrand
import Q_crandom
import Q_random
import Q_rand
import Q_acos
import Q_log2
import VectorRotate
import Vector4Scale
import VectorNormalize2
import VectorNormalize
import CrossProduct
import VectorInverse
import VectorNormalizeFast
import DistanceSquared
import Distance
import VectorLengthSquared
import VectorLength
import VectorCompare
import AddPointToBounds
import ClearBounds
import RadiusFromBounds
import NormalizeColor
import ColorBytes4
import ColorBytes3
import _VectorMA
import _VectorScale
import _VectorCopy
import _VectorAdd
import _VectorSubtract
import _DotProduct
import ByteToDir
import DirToByte
import ClampShort
import ClampChar
import Q_rsqrt
import Q_fabs
import axisDefault
import vec3_origin
import g_color_table
import colorDkGrey
import colorMdGrey
import colorLtGrey
import colorWhite
import colorCyan
import colorMagenta
import colorYellow
import colorBlue
import colorGreen
import colorRed
import colorBlack
import bytedirs
import Com_Memcpy
import Com_Memset
import Hunk_Alloc
import FloatSwap
import LongSwap
import ShortSwap
import acos
import fabs
import abs
import tan
import atan2
import cos
import sin
import sqrt
import floor
import ceil
import memcpy
import memset
import memmove
import sscanf
import vsprintf
import _atoi
import atoi
import _atof
import atof
import toupper
import tolower
import strncpy
import strstr
import strchr
import strcmp
import strcpy
import strcat
import strlen
import rand
import srand
import qsort
lit
align 1
LABELV $2257
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 32
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $2250
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 32
byte 1 48
byte 1 0
align 1
LABELV $2053
byte 1 51
byte 1 51
byte 1 0
align 1
LABELV $2049
byte 1 56
byte 1 0
align 1
LABELV $2048
byte 1 112
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 95
byte 1 109
byte 1 115
byte 1 101
byte 1 99
byte 1 0
align 1
LABELV $1852
byte 1 103
byte 1 114
byte 1 97
byte 1 112
byte 1 112
byte 1 108
byte 1 101
byte 1 32
byte 1 114
byte 1 111
byte 1 112
byte 1 101
byte 1 32
byte 1 101
byte 1 108
byte 1 101
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $1337
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 102
byte 1 108
byte 1 105
byte 1 99
byte 1 116
byte 1 111
byte 1 114
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 97
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $1334
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 105
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 102
byte 1 108
byte 1 105
byte 1 99
byte 1 116
byte 1 111
byte 1 114
byte 1 58
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $1072
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 84
byte 1 101
byte 1 110
byte 1 32
byte 1 115
byte 1 101
byte 1 99
byte 1 111
byte 1 110
byte 1 100
byte 1 115
byte 1 32
byte 1 117
byte 1 110
byte 1 116
byte 1 105
byte 1 108
byte 1 32
byte 1 105
byte 1 110
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 33
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1068
byte 1 68
byte 1 114
byte 1 111
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 100
byte 1 117
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 105
byte 1 110
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $937
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 103
byte 1 117
byte 1 114
byte 1 112
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $936
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 103
byte 1 117
byte 1 114
byte 1 112
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $933
byte 1 42
byte 1 100
byte 1 114
byte 1 111
byte 1 119
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $806
byte 1 116
byte 1 115
byte 1 115
byte 1 117
byte 1 112
byte 1 100
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $697
byte 1 66
byte 1 85
byte 1 71
byte 1 33
byte 1 32
byte 1 84
byte 1 83
byte 1 83
byte 1 95
byte 1 83
byte 1 117
byte 1 103
byte 1 103
byte 1 101
byte 1 115
byte 1 116
byte 1 101
byte 1 100
byte 1 71
byte 1 114
byte 1 111
byte 1 117
byte 1 112
byte 1 70
byte 1 111
byte 1 114
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 58
byte 1 32
byte 1 103
byte 1 97
byte 1 61
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 0
align 1
LABELV $616
byte 1 66
byte 1 85
byte 1 71
byte 1 33
byte 1 32
byte 1 84
byte 1 83
byte 1 83
byte 1 95
byte 1 65
byte 1 115
byte 1 115
byte 1 105
byte 1 103
byte 1 110
byte 1 84
byte 1 97
byte 1 115
byte 1 107
byte 1 58
byte 1 32
byte 1 103
byte 1 97
byte 1 61
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 0
align 1
LABELV $556
byte 1 66
byte 1 85
byte 1 71
byte 1 33
byte 1 32
byte 1 84
byte 1 83
byte 1 83
byte 1 95
byte 1 71
byte 1 114
byte 1 111
byte 1 117
byte 1 112
byte 1 83
byte 1 105
byte 1 122
byte 1 101
byte 1 58
byte 1 32
byte 1 103
byte 1 105
byte 1 61
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 0
align 1
LABELV $543
byte 1 66
byte 1 85
byte 1 71
byte 1 33
byte 1 32
byte 1 84
byte 1 83
byte 1 83
byte 1 95
byte 1 82
byte 1 101
byte 1 115
byte 1 99
byte 1 117
byte 1 101
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 77
byte 1 97
byte 1 116
byte 1 101
byte 1 58
byte 1 32
byte 1 103
byte 1 97
byte 1 61
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 0
align 1
LABELV $466
byte 1 66
byte 1 85
byte 1 71
byte 1 33
byte 1 32
byte 1 84
byte 1 83
byte 1 83
byte 1 95
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 67
byte 1 111
byte 1 79
byte 1 112
byte 1 101
byte 1 114
byte 1 97
byte 1 116
byte 1 101
byte 1 58
byte 1 32
byte 1 103
byte 1 97
byte 1 49
byte 1 61
byte 1 37
byte 1 100
byte 1 44
byte 1 32
byte 1 103
byte 1 97
byte 1 50
byte 1 61
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $394
byte 1 66
byte 1 85
byte 1 71
byte 1 33
byte 1 32
byte 1 84
byte 1 83
byte 1 83
byte 1 95
byte 1 82
byte 1 101
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 66
byte 1 101
byte 1 115
byte 1 116
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 70
byte 1 111
byte 1 114
byte 1 71
byte 1 114
byte 1 111
byte 1 117
byte 1 112
byte 1 58
byte 1 32
byte 1 103
byte 1 105
byte 1 61
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 0
align 1
LABELV $324
byte 1 66
byte 1 85
byte 1 71
byte 1 33
byte 1 32
byte 1 84
byte 1 83
byte 1 83
byte 1 95
byte 1 65
byte 1 100
byte 1 106
byte 1 117
byte 1 115
byte 1 116
byte 1 101
byte 1 100
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 68
byte 1 105
byte 1 115
byte 1 116
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 58
byte 1 32
byte 1 103
byte 1 97
byte 1 61
byte 1 37
byte 1 100
byte 1 44
byte 1 32
byte 1 103
byte 1 105
byte 1 61
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $310
byte 1 66
byte 1 85
byte 1 71
byte 1 33
byte 1 32
byte 1 84
byte 1 83
byte 1 83
byte 1 95
byte 1 77
byte 1 111
byte 1 118
byte 1 101
byte 1 84
byte 1 111
byte 1 71
byte 1 114
byte 1 111
byte 1 117
byte 1 112
byte 1 73
byte 1 102
byte 1 80
byte 1 111
byte 1 115
byte 1 115
byte 1 105
byte 1 98
byte 1 108
byte 1 101
byte 1 58
byte 1 32
byte 1 103
byte 1 97
byte 1 61
byte 1 37
byte 1 100
byte 1 44
byte 1 32
byte 1 103
byte 1 105
byte 1 61
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $288
byte 1 66
byte 1 85
byte 1 71
byte 1 33
byte 1 32
byte 1 84
byte 1 83
byte 1 83
byte 1 95
byte 1 67
byte 1 97
byte 1 110
byte 1 82
byte 1 101
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 71
byte 1 114
byte 1 111
byte 1 117
byte 1 112
byte 1 65
byte 1 115
byte 1 115
byte 1 105
byte 1 103
byte 1 110
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 103
byte 1 97
byte 1 61
byte 1 37
byte 1 100
byte 1 44
byte 1 32
byte 1 103
byte 1 105
byte 1 61
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $277
byte 1 66
byte 1 85
byte 1 71
byte 1 33
byte 1 32
byte 1 84
byte 1 83
byte 1 83
byte 1 95
byte 1 65
byte 1 115
byte 1 115
byte 1 105
byte 1 103
byte 1 110
byte 1 84
byte 1 111
byte 1 71
byte 1 114
byte 1 111
byte 1 117
byte 1 112
byte 1 58
byte 1 32
byte 1 103
byte 1 97
byte 1 61
byte 1 37
byte 1 100
byte 1 44
byte 1 32
byte 1 103
byte 1 105
byte 1 61
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $266
byte 1 66
byte 1 85
byte 1 71
byte 1 33
byte 1 32
byte 1 84
byte 1 83
byte 1 83
byte 1 95
byte 1 67
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 108
byte 1 71
byte 1 114
byte 1 111
byte 1 117
byte 1 112
byte 1 65
byte 1 115
byte 1 115
byte 1 105
byte 1 103
byte 1 110
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 103
byte 1 97
byte 1 61
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 0
align 1
LABELV $262
byte 1 66
byte 1 85
byte 1 71
byte 1 33
byte 1 32
byte 1 84
byte 1 83
byte 1 83
byte 1 95
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 68
byte 1 105
byte 1 115
byte 1 116
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 83
byte 1 113
byte 1 114
byte 1 58
byte 1 32
byte 1 103
byte 1 97
byte 1 49
byte 1 61
byte 1 37
byte 1 100
byte 1 44
byte 1 32
byte 1 103
byte 1 97
byte 1 50
byte 1 61
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $96
byte 1 66
byte 1 85
byte 1 71
byte 1 33
byte 1 32
byte 1 73
byte 1 115
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 73
byte 1 110
byte 1 118
byte 1 111
byte 1 108
byte 1 118
byte 1 101
byte 1 100
byte 1 73
byte 1 110
byte 1 70
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 58
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 78
byte 1 117
byte 1 109
byte 1 61
byte 1 37
byte 1 100
byte 1 10
byte 1 0
