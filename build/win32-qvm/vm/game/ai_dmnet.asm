export BotResetNodeSwitches
code
proc BotResetNodeSwitches 0 0
file "..\..\..\..\code\game\ai_dmnet.c"
line 52
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:
;4:/*****************************************************************************
;5: * name:		ai_dmnet.c
;6: *
;7: * desc:		Quake3 bot AI
;8: *
;9: * $Archive: /MissionPack/code/game/ai_dmnet.c $
;10: *
;11: *****************************************************************************/
;12:
;13:#include "g_local.h"
;14:#include "botlib.h"
;15:#include "be_aas.h"
;16:#include "be_ea.h"
;17:#include "be_ai_char.h"
;18:#include "be_ai_chat.h"
;19:#include "be_ai_gen.h"
;20:#include "be_ai_goal.h"
;21:#include "be_ai_move.h"
;22:#include "be_ai_weap.h"
;23://
;24:#include "ai_main.h"
;25:#include "ai_dmq3.h"
;26:#include "ai_chat.h"
;27:#include "ai_cmd.h"
;28:#include "ai_dmnet.h"
;29:#include "ai_team.h"
;30://data file headers
;31:#include "chars.h"			//characteristics
;32:#include "inv.h"			//indexes into the inventory
;33:#include "syn.h"			//synonyms
;34:#include "match.h"			//string matching types and vars
;35:
;36:// for the voice chats
;37:#include "../../ui/menudef.h"
;38:
;39://goal flag, see be_ai_goal.h for the other GFL_*
;40:#define GFL_AIR			128
;41:
;42:int numnodeswitches;
;43:char nodeswitch[MAX_NODESWITCHES+1][144];
;44:
;45:#define LOOKAHEAD_DISTANCE			300
;46:
;47:/*
;48:==================
;49:BotResetNodeSwitches
;50:==================
;51:*/
;52:void BotResetNodeSwitches(void) {
line 53
;53:	numnodeswitches = 0;
ADDRGP4 numnodeswitches
CNSTI4 0
ASGNI4
line 54
;54:}
LABELV $92
endproc BotResetNodeSwitches 0 0
export BotDumpNodeSwitches
proc BotDumpNodeSwitches 40 20
line 61
;55:
;56:/*
;57:==================
;58:BotDumpNodeSwitches
;59:==================
;60:*/
;61:void BotDumpNodeSwitches(bot_state_t *bs) {
line 65
;62:	int i;
;63:	char netname[MAX_NETNAME];
;64:
;65:	ClientName(bs->client, netname, sizeof(netname));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 66
;66:	BotAI_Print(PRT_MESSAGE, "%s at %1.1f switched more than %d AI nodes\n", netname, FloatTime(), MAX_NODESWITCHES);
CNSTI4 1
ARGI4
ADDRGP4 $94
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 floattime
INDIRF4
ARGF4
CNSTI4 50
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 67
;67:	for (i = 0; i < numnodeswitches; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $98
JUMPV
LABELV $95
line 68
;68:		BotAI_Print(PRT_MESSAGE, nodeswitch[i]);
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 144
MULI4
ADDRGP4 nodeswitch
ADDP4
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 69
;69:	}
LABELV $96
line 67
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $98
ADDRLP4 0
INDIRI4
ADDRGP4 numnodeswitches
INDIRI4
LTI4 $95
line 70
;70:	BotAI_Print(PRT_FATAL, "");
CNSTI4 4
ARGI4
ADDRGP4 $99
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 71
;71:}
LABELV $93
endproc BotDumpNodeSwitches 40 20
export BotRecordNodeSwitch
proc BotRecordNodeSwitch 40 32
line 78
;72:
;73:/*
;74:==================
;75:BotRecordNodeSwitch
;76:==================
;77:*/
;78:void BotRecordNodeSwitch(bot_state_t *bs, char *node, char *str, char *s) {
line 81
;79:	char netname[MAX_NETNAME];
;80:
;81:	ClientName(bs->client, netname, sizeof(netname));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 82
;82:	Com_sprintf(nodeswitch[numnodeswitches], 144, "%s at %2.1f entered %s: %s from %s\n", netname, FloatTime(), node, str, s);
ADDRGP4 numnodeswitches
INDIRI4
CNSTI4 144
MULI4
ADDRGP4 nodeswitch
ADDP4
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 $101
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 floattime
INDIRF4
ARGF4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 93
;83:#ifdef DEBUG
;84:	if (0) {
;85:		BotAI_Print(PRT_MESSAGE, nodeswitch[numnodeswitches]);
;86:	}
;87:#endif //DEBUG
;88:#if JUHOX_BOT_DEBUG
;89:	if (bs->debugThisBot) {
;90:		BotAI_Print(PRT_MESSAGE, nodeswitch[numnodeswitches]);
;91:	}
;92:#endif
;93:	numnodeswitches++;
ADDRLP4 36
ADDRGP4 numnodeswitches
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 94
;94:}
LABELV $100
endproc BotRecordNodeSwitch 40 32
data
align 4
LABELV $103
byte 4 3245342720
byte 4 3245342720
byte 4 3221225472
align 4
LABELV $104
byte 4 1097859072
byte 4 1097859072
byte 4 1073741824
export BotGetAirGoal
code
proc BotGetAirGoal 140 28
line 101
;95:
;96:/*
;97:==================
;98:BotGetAirGoal
;99:==================
;100:*/
;101:int BotGetAirGoal(bot_state_t *bs, bot_goal_t *goal) {
line 103
;102:	bsp_trace_t bsptrace;
;103:	vec3_t end, mins = {-15, -15, -2}, maxs = {15, 15, 2};
ADDRLP4 96
ADDRGP4 $103
INDIRB
ASGNB 12
ADDRLP4 108
ADDRGP4 $104
INDIRB
ASGNB 12
line 107
;104:	int areanum;
;105:
;106:	//trace up until we hit solid
;107:	VectorCopy(bs->origin, end);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRB
ASGNB 12
line 108
;108:	end[2] += 1000;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1148846080
ADDF4
ASGNF4
line 109
;109:	BotAI_Trace(&bsptrace, bs->origin, mins, maxs, end, bs->entitynum, CONTENTS_SOLID|CONTENTS_PLAYERCLIP);
ADDRLP4 12
ARGP4
ADDRLP4 124
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 124
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 96
ARGP4
ADDRLP4 108
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 124
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 65537
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 111
;110:	//trace down until we hit water
;111:	VectorCopy(bsptrace.endpos, end);
ADDRLP4 0
ADDRLP4 12+12
INDIRB
ASGNB 12
line 112
;112:	BotAI_Trace(&bsptrace, end, mins, maxs, bs->origin, bs->entitynum, CONTENTS_WATER|CONTENTS_SLIME|CONTENTS_LAVA);
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 96
ARGP4
ADDRLP4 108
ARGP4
ADDRLP4 128
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 128
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 128
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 56
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 114
;113:	//if we found the water surface
;114:	if (bsptrace.fraction > 0) {
ADDRLP4 12+8
INDIRF4
CNSTF4 0
LEF4 $107
line 115
;115:		areanum = BotPointAreaNum(bsptrace.endpos);
ADDRLP4 12+12
ARGP4
ADDRLP4 132
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 120
ADDRLP4 132
INDIRI4
ASGNI4
line 116
;116:		if (areanum) {
ADDRLP4 120
INDIRI4
CNSTI4 0
EQI4 $111
line 117
;117:			VectorCopy(bsptrace.endpos, goal->origin);
ADDRFP4 4
INDIRP4
ADDRLP4 12+12
INDIRB
ASGNB 12
line 118
;118:			goal->origin[2] -= 2;
ADDRLP4 136
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 136
INDIRP4
ADDRLP4 136
INDIRP4
INDIRF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 119
;119:			goal->areanum = areanum;
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 120
INDIRI4
ASGNI4
line 120
;120:			goal->mins[0] = -15;
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
CNSTF4 3245342720
ASGNF4
line 121
;121:			goal->mins[1] = -15;
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 3245342720
ASGNF4
line 122
;122:			goal->mins[2] = -1;
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 3212836864
ASGNF4
line 123
;123:			goal->maxs[0] = 15;
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 1097859072
ASGNF4
line 124
;124:			goal->maxs[1] = 15;
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 1097859072
ASGNF4
line 125
;125:			goal->maxs[2] = 1;
ADDRFP4 4
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 1065353216
ASGNF4
line 126
;126:			goal->flags = GFL_AIR;
ADDRFP4 4
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 128
ASGNI4
line 127
;127:			goal->number = 0;
ADDRFP4 4
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 0
ASGNI4
line 128
;128:			goal->iteminfo = 0;
ADDRFP4 4
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 129
;129:			goal->entitynum = 0;
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
CNSTI4 0
ASGNI4
line 130
;130:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $102
JUMPV
LABELV $111
line 132
;131:		}
;132:	}
LABELV $107
line 133
;133:	return qfalse;
CNSTI4 0
RETI4
LABELV $102
endproc BotGetAirGoal 140 28
export BotGoForAir
proc BotGoForAir 68 24
line 141
;134:}
;135:
;136:/*
;137:==================
;138:BotGoForAir
;139:==================
;140:*/
;141:int BotGoForAir(bot_state_t *bs, int tfl, bot_goal_t *ltg, float range) {
line 145
;142:	bot_goal_t goal;
;143:
;144:	//if the bot needs air
;145:	if (bs->lastair_time < FloatTime() - 6) {
ADDRFP4 0
INDIRP4
CNSTI4 7268
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1086324736
SUBF4
GEF4 $115
line 151
;146:		//
;147:#ifdef DEBUG
;148:		//BotAI_Print(PRT_MESSAGE, "going for air\n");
;149:#endif //DEBUG
;150:		//if we can find an air goal
;151:		if (BotGetAirGoal(bs, &goal)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 56
ADDRGP4 BotGetAirGoal
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $120
line 152
;152:			trap_BotPushGoal(bs->gs, &goal);
ADDRFP4 0
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotPushGoal
CALLV
pop
line 153
;153:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $114
JUMPV
line 155
;154:		}
;155:		else {
LABELV $119
line 157
;156:			//get a nearby goal outside the water
;157:			while(trap_BotChooseNBGItem(bs->gs, bs->origin, bs->inventory, tfl, ltg, range)) {
line 158
;158:				trap_BotGetTopGoal(bs->gs, &goal);
ADDRFP4 0
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotGetTopGoal
CALLI4
pop
line 160
;159:				//if the goal is not in water
;160:				if (!(trap_AAS_PointContents(goal.origin) & (CONTENTS_WATER|CONTENTS_SLIME|CONTENTS_LAVA))) {
ADDRLP4 0
ARGP4
ADDRLP4 60
ADDRGP4 trap_AAS_PointContents
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
NEI4 $122
line 161
;161:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $114
JUMPV
LABELV $122
line 163
;162:				}
;163:				trap_BotPopGoal(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotPopGoal
CALLV
pop
line 164
;164:			}
LABELV $120
line 157
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 60
INDIRP4
CNSTI4 4960
ADDP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 64
ADDRGP4 trap_BotChooseNBGItem
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
NEI4 $119
line 165
;165:			trap_BotResetAvoidGoals(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidGoals
CALLV
pop
line 166
;166:		}
line 167
;167:	}
LABELV $115
line 168
;168:	return qfalse;
CNSTI4 0
RETI4
LABELV $114
endproc BotGoForAir 68 24
export BotCheckForWeaponJump
proc BotCheckForWeaponJump 4 0
line 176
;169:}
;170:
;171:/*
;172:==================
;173:JUHOX: BotCheckForWeaponJump
;174:==================
;175:*/
;176:void BotCheckForWeaponJump(bot_state_t* bs, bot_moveresult_t* moveresult) {
line 177
;177:	if (moveresult->flags & MOVERESULT_MOVEMENTWEAPON) {
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $125
line 178
;178:		if (moveresult->weapon == WP_ROCKET_LAUNCHER) {
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 5
NEI4 $126
line 179
;179:			if (bs->cur_ps.ammo[WP_RAILGUN] > 0 && bs->cur_ps.stats[STAT_STRENGTH] > LOW_STRENGTH_VALUE) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 420
ADDP4
INDIRI4
CNSTI4 0
LEI4 $126
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1161527296
LEF4 $126
line 180
;180:				moveresult->weapon = WP_RAILGUN;
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
CNSTI4 7
ASGNI4
line 181
;181:				if (!bs->railgunJump_ordertime) {
ADDRFP4 0
INDIRP4
CNSTI4 7728
ADDP4
INDIRF4
CNSTF4 0
NEF4 $126
line 182
;182:					bs->railgunJump_ordertime = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7728
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 183
;183:					bs->railgunJump_jumptime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7732
ADDP4
CNSTF4 0
ASGNF4
line 184
;184:				}
line 185
;185:			}
line 186
;186:		}
line 187
;187:	}
ADDRGP4 $126
JUMPV
LABELV $125
line 188
;188:	else if (bs->railgunJump_ordertime && !bs->railgunJump_jumptime) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 7728
ADDP4
INDIRF4
CNSTF4 0
EQF4 $133
ADDRLP4 0
INDIRP4
CNSTI4 7732
ADDP4
INDIRF4
CNSTF4 0
NEF4 $133
line 189
;189:		bs->railgunJump_ordertime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7728
ADDP4
CNSTF4 0
ASGNF4
line 190
;190:	}
LABELV $133
LABELV $126
line 191
;191:}
LABELV $124
endproc BotCheckForWeaponJump 4 0
export BotRememberLTGItemUnreachable
proc BotRememberLTGItemUnreachable 16 0
line 198
;192:
;193:/*
;194:==================
;195:JUHOX: BotRememberLTGItemUnreachable
;196:==================
;197:*/
;198:void BotRememberLTGItemUnreachable(bot_state_t* bs, int entitynum) {
line 203
;199:	int i;
;200:	int oldestEntry;
;201:	float oldestEntryTime;
;202:
;203:	oldestEntry = -1;
ADDRLP4 8
CNSTI4 -1
ASGNI4
line 204
;204:	oldestEntryTime = FloatTime();
ADDRLP4 4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 205
;205:	for (i = 0; i < LTG_ITEM_MEMORY_SIZE; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $136
line 206
;206:		if (bs->ltg_item_memory.entryTab[i].entitynum == entitynum) {
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6640
ADDP4
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $140
line 207
;207:			bs->ltg_item_memory.entryTab[i].unreachable_time = FloatTime();
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6640
ADDP4
ADDP4
CNSTI4 4
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 208
;208:			return;
ADDRGP4 $135
JUMPV
LABELV $140
line 210
;209:		}
;210:		if (bs->ltg_item_memory.entryTab[i].unreachable_time < oldestEntryTime) {
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6640
ADDP4
ADDP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
GEF4 $142
line 211
;211:			oldestEntryTime = bs->ltg_item_memory.entryTab[i].unreachable_time;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6640
ADDP4
ADDP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 212
;212:			oldestEntry = i;
ADDRLP4 8
ADDRLP4 0
INDIRI4
ASGNI4
line 213
;213:		}
LABELV $142
line 214
;214:	}
LABELV $137
line 205
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $136
line 215
;215:	if (oldestEntry < 0) oldestEntry = rand() % LTG_ITEM_MEMORY_SIZE;
ADDRLP4 8
INDIRI4
CNSTI4 0
GEI4 $144
ADDRLP4 12
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRI4
CNSTI4 64
MODI4
ASGNI4
LABELV $144
line 216
;216:	bs->ltg_item_memory.entryTab[oldestEntry].entitynum = entitynum;
ADDRLP4 8
INDIRI4
CNSTI4 3
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6640
ADDP4
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 217
;217:	bs->ltg_item_memory.entryTab[oldestEntry].unreachable_time = FloatTime();
ADDRLP4 8
INDIRI4
CNSTI4 3
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6640
ADDP4
ADDP4
CNSTI4 4
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 218
;218:}
LABELV $135
endproc BotRememberLTGItemUnreachable 16 0
export BotMayLTGItemBeReachable
proc BotMayLTGItemBeReachable 4 0
line 225
;219:
;220:/*
;221:==================
;222:JUHOX: BotMayLTGItemBeReachable
;223:==================
;224:*/
;225:qboolean BotMayLTGItemBeReachable(bot_state_t* bs, int entitynum) {
line 228
;226:	int i;
;227:
;228:	for (i = 0; i < LTG_ITEM_MEMORY_SIZE; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $147
line 229
;229:		if (bs->ltg_item_memory.entryTab[i].entitynum == entitynum) {
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6640
ADDP4
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $151
line 230
;230:			if (bs->ltg_item_memory.entryTab[i].unreachable_time > FloatTime() - 30) {
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6640
ADDP4
ADDP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1106247680
SUBF4
LEF4 $153
line 231
;231:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $146
JUMPV
LABELV $153
line 233
;232:			}
;233:			else {
line 234
;234:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $146
JUMPV
LABELV $151
line 237
;235:			}
;236:		}
;237:	}
LABELV $148
line 228
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $147
line 238
;238:	return qtrue;
CNSTI4 1
RETI4
LABELV $146
endproc BotMayLTGItemBeReachable 4 0
export BotRememberNBGNotAvailable
proc BotRememberNBGNotAvailable 16 0
line 247
;239:	
;240:}
;241:
;242:/*
;243:==================
;244:JUHOX: BotRememberNBGNotAvailable
;245:==================
;246:*/
;247:void BotRememberNBGNotAvailable(bot_state_t* bs, int entitynum) {
line 252
;248:	int i;
;249:	int oldestEntry;
;250:	float oldestEntryTime;
;251:
;252:	oldestEntry = -1;
ADDRLP4 8
CNSTI4 -1
ASGNI4
line 253
;253:	oldestEntryTime = FloatTime();
ADDRLP4 4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 254
;254:	for (i = 0; i < NBGHISTORY_SIZE; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $156
line 255
;255:		if (bs->nbg_history.entryTab[i].entitynum == entitynum) {
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6096
ADDP4
ADDP4
CNSTI4 4
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $160
line 256
;256:			bs->nbg_history.entryTab[i].time = FloatTime();
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6096
ADDP4
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 257
;257:			return;
ADDRGP4 $155
JUMPV
LABELV $160
line 259
;258:		}
;259:		if (bs->nbg_history.entryTab[i].time < oldestEntryTime) {
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6096
ADDP4
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
GEF4 $162
line 260
;260:			oldestEntryTime = bs->nbg_history.entryTab[i].time;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6096
ADDP4
ADDP4
INDIRF4
ASGNF4
line 261
;261:			oldestEntry = i;
ADDRLP4 8
ADDRLP4 0
INDIRI4
ASGNI4
line 262
;262:		}
LABELV $162
line 263
;263:	}
LABELV $157
line 254
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $156
line 264
;264:	if (oldestEntry < 0) oldestEntry = rand() % NBGHISTORY_SIZE;
ADDRLP4 8
INDIRI4
CNSTI4 0
GEI4 $164
ADDRLP4 12
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRI4
CNSTI4 64
MODI4
ASGNI4
LABELV $164
line 265
;265:	bs->nbg_history.entryTab[oldestEntry].entitynum = entitynum;
ADDRLP4 8
INDIRI4
CNSTI4 3
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6096
ADDP4
ADDP4
CNSTI4 4
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 266
;266:	bs->nbg_history.entryTab[oldestEntry].time = FloatTime();
ADDRLP4 8
INDIRI4
CNSTI4 3
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6096
ADDP4
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 267
;267:}
LABELV $155
endproc BotRememberNBGNotAvailable 16 0
export BotRememberNBGAvailable
proc BotRememberNBGAvailable 4 0
line 274
;268:
;269:/*
;270:==================
;271:JUHOX: BotRememberNBGAvailable
;272:==================
;273:*/
;274:void BotRememberNBGAvailable(bot_state_t* bs, int entitynum) {
line 277
;275:	int i;
;276:
;277:	for (i = 0; i < NBGHISTORY_SIZE; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $167
line 278
;278:		if (bs->nbg_history.entryTab[i].entitynum == entitynum) {
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6096
ADDP4
ADDP4
CNSTI4 4
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $171
line 279
;279:			bs->nbg_history.entryTab[i].entitynum = 0;
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6096
ADDP4
ADDP4
CNSTI4 4
ADDP4
CNSTI4 0
ASGNI4
line 280
;280:			bs->nbg_history.entryTab[i].time = 0;
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6096
ADDP4
ADDP4
CNSTF4 0
ASGNF4
line 281
;281:			return;
ADDRGP4 $166
JUMPV
LABELV $171
line 283
;282:		}
;283:	}
LABELV $168
line 277
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $167
line 284
;284:}
LABELV $166
endproc BotRememberNBGAvailable 4 0
export BotMayNBGBeAvailable
proc BotMayNBGBeAvailable 4 0
line 291
;285:
;286:/*
;287:==================
;288:JUHOX: BotMayNBGBeAvailable
;289:==================
;290:*/
;291:qboolean BotMayNBGBeAvailable(bot_state_t* bs, int entitynum) {
line 294
;292:	int i;
;293:
;294:	for (i = 0; i < NBGHISTORY_SIZE; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $174
line 295
;295:		if (bs->nbg_history.entryTab[i].entitynum == entitynum) {
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6096
ADDP4
ADDP4
CNSTI4 4
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $178
line 296
;296:			if (bs->nbg_history.entryTab[i].time > FloatTime() - 20) {
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6096
ADDP4
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1101004800
SUBF4
LEF4 $180
line 297
;297:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $173
JUMPV
LABELV $180
line 299
;298:			}
;299:			else {
line 300
;300:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $173
JUMPV
LABELV $178
line 303
;301:			}
;302:		}
;303:	}
LABELV $175
line 294
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $174
line 304
;304:	return qtrue;
CNSTI4 1
RETI4
LABELV $173
endproc BotMayNBGBeAvailable 4 0
bss
align 4
LABELV $183
skip 256
data
align 4
LABELV $184
byte 4 3245342720
byte 4 3245342720
byte 4 3245342720
align 4
LABELV $185
byte 4 1097859072
byte 4 1097859072
byte 4 1097859072
code
proc BotChooseNearbyItem 600 28
line 314
;305:}
;306:
;307:/*
;308:==================
;309:JUHOX: BotChooseNearbyItem
;310:
;311:range<0 means "any item at any range"
;312:==================
;313:*/
;314:static int BotChooseNearbyItem(bot_state_t* bs, bot_goal_t* goal, float range) {
line 331
;315:	static gclient_t* competitors[MAX_CLIENTS];
;316:	static vec3_t mins = {-15,-15,-15};
;317:	static vec3_t maxs = {15,15,15};
;318:	int numCompetitors;
;319:	int currentEntity;
;320:	qboolean collectArmor;
;321:	qboolean collectLimitedHealth;
;322:	qboolean collectUnlimitedHealth;
;323:	qboolean collectHoldableItem;
;324:	qboolean collectStrengthRegeneration;
;325:	int bestTravelTime;
;326:	float bestDistance;
;327:	gitem_t* foundItem;
;328:	gentity_t* foundEntity;
;329:	vec3_t refOrigin;
;330:
;331:	bs->getImportantNBGItem = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 7736
ADDP4
CNSTI4 0
ASGNI4
line 332
;332:	bs->nbgGivesPODMarker = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6636
ADDP4
CNSTI4 0
ASGNI4
line 333
;333:	numCompetitors = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 335
;334:
;335:	if (range < 0) {
ADDRFP4 8
INDIRF4
CNSTF4 0
GEF4 $186
line 336
;336:		collectArmor = qtrue;
ADDRLP4 40
CNSTI4 1
ASGNI4
line 337
;337:		collectLimitedHealth = qtrue;
ADDRLP4 48
CNSTI4 1
ASGNI4
line 338
;338:		collectUnlimitedHealth = qtrue;
ADDRLP4 36
CNSTI4 1
ASGNI4
line 339
;339:		collectHoldableItem = qtrue;
ADDRLP4 44
CNSTI4 1
ASGNI4
line 340
;340:		collectStrengthRegeneration = qtrue;
ADDRLP4 52
CNSTI4 1
ASGNI4
line 341
;341:		goto SearchItems;
ADDRGP4 $188
JUMPV
LABELV $186
line 344
;342:	}
;343:
;344:	VectorCopy(bs->origin, refOrigin);
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRB
ASGNB 12
line 345
;345:	if (bs->ltgtype == LTG_TEAMHELP && BotPlayerDanger(&bs->cur_ps) < 25) {
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 1
NEI4 $189
ADDRLP4 56
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 60
ADDRGP4 BotPlayerDanger
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 25
GEI4 $189
line 348
;346:		playerState_t ps;
;347:
;348:		if (BotAI_GetClientState(bs->teammate, &ps)) {
ADDRFP4 0
INDIRP4
CNSTI4 11560
ADDP4
INDIRI4
ARGI4
ADDRLP4 64
ARGP4
ADDRLP4 532
ADDRGP4 BotAI_GetClientState
CALLI4
ASGNI4
ADDRLP4 532
INDIRI4
CNSTI4 0
EQI4 $191
line 349
;349:			if (ps.stats[STAT_HEALTH] > 0) {
ADDRLP4 64+184
INDIRI4
CNSTI4 0
LEI4 $193
line 350
;350:				if (DistanceSquared(bs->origin, ps.origin) > Square(600)) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 64+20
ARGP4
ADDRLP4 536
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 536
INDIRF4
CNSTF4 1219479552
LEF4 $196
CNSTI4 0
RETI4
ADDRGP4 $182
JUMPV
LABELV $196
line 351
;351:			}
LABELV $193
line 352
;352:		}
LABELV $191
line 353
;353:		VectorCopy(ps.origin, refOrigin);
ADDRLP4 24
ADDRLP4 64+20
INDIRB
ASGNB 12
line 354
;354:	}
LABELV $189
line 356
;355:
;356:	collectArmor = BotArmorIsUsefulForPlayer(&bs->cur_ps);
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 64
ADDRGP4 BotArmorIsUsefulForPlayer
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 64
INDIRI4
ASGNI4
line 357
;357:	collectLimitedHealth = BotLimitedHealthIsUsefulForPlayer(&bs->cur_ps);
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 68
ADDRGP4 BotLimitedHealthIsUsefulForPlayer
CALLI4
ASGNI4
ADDRLP4 48
ADDRLP4 68
INDIRI4
ASGNI4
line 358
;358:	collectUnlimitedHealth = BotUnlimitedHealthIsUsefulForPlayer(&bs->cur_ps);
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 72
ADDRGP4 BotUnlimitedHealthIsUsefulForPlayer
CALLI4
ASGNI4
ADDRLP4 36
ADDRLP4 72
INDIRI4
ASGNI4
line 359
;359:	collectHoldableItem = BotHoldableItemIsUsefulForPlayer(&bs->cur_ps);
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 76
ADDRGP4 BotHoldableItemIsUsefulForPlayer
CALLI4
ASGNI4
ADDRLP4 44
ADDRLP4 76
INDIRI4
ASGNI4
line 360
;360:	collectStrengthRegeneration = qtrue;
ADDRLP4 52
CNSTI4 1
ASGNI4
line 362
;361:	if (
;362:		g_gametype.integer >= GT_TEAM &&
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $200
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 80
ADDRGP4 BotPlayerDanger
CALLI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 75
GEI4 $200
line 364
;363:		BotPlayerDanger(&bs->cur_ps) < 75
;364:	) {
line 369
;365:		playerState_t ps;
;366:		int teammate;
;367:		int killDamage;
;368:
;369:		killDamage = BotPlayerKillDamage(&bs->cur_ps);
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 560
ADDRGP4 BotPlayerKillDamage
CALLI4
ASGNI4
ADDRLP4 556
ADDRLP4 560
INDIRI4
ASGNI4
line 370
;370:		if (bs->cur_ps.powerups[PW_REDFLAG] || bs->cur_ps.powerups[PW_BLUEFLAG]) killDamage -= 50;
ADDRLP4 564
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 564
INDIRP4
CNSTI4 356
ADDP4
INDIRI4
CNSTI4 0
NEI4 $205
ADDRLP4 564
INDIRP4
CNSTI4 360
ADDP4
INDIRI4
CNSTI4 0
EQI4 $203
LABELV $205
ADDRLP4 556
ADDRLP4 556
INDIRI4
CNSTI4 50
SUBI4
ASGNI4
LABELV $203
line 371
;371:		for (teammate = -1; (teammate = BotGetNextTeamMate(bs, teammate, &ps)) >= 0;) {
ADDRLP4 552
CNSTI4 -1
ASGNI4
ADDRGP4 $209
JUMPV
LABELV $206
line 374
;372:			int kd;
;373:
;374:			if (ps.stats[STAT_HEALTH] <= 0) continue;
ADDRLP4 84+184
INDIRI4
CNSTI4 0
GTI4 $210
ADDRGP4 $207
JUMPV
LABELV $210
line 375
;375:			if (ps.powerups[PW_SHIELD]) continue;
ADDRLP4 84+312+44
INDIRI4
CNSTI4 0
EQI4 $213
ADDRGP4 $207
JUMPV
LABELV $213
line 376
;376:			kd = BotPlayerKillDamage(&ps);
ADDRLP4 84
ARGP4
ADDRLP4 572
ADDRGP4 BotPlayerKillDamage
CALLI4
ASGNI4
ADDRLP4 568
ADDRLP4 572
INDIRI4
ASGNI4
line 377
;377:			if (ps.powerups[PW_REDFLAG] || ps.powerups[PW_BLUEFLAG]) kd -= 50;
ADDRLP4 84+312+28
INDIRI4
CNSTI4 0
NEI4 $223
ADDRLP4 84+312+32
INDIRI4
CNSTI4 0
EQI4 $217
LABELV $223
ADDRLP4 568
ADDRLP4 568
INDIRI4
CNSTI4 50
SUBI4
ASGNI4
LABELV $217
line 378
;378:			if (kd > killDamage) continue;
ADDRLP4 568
INDIRI4
ADDRLP4 556
INDIRI4
LEI4 $224
ADDRGP4 $207
JUMPV
LABELV $224
line 380
;379:
;380:			if (kd == killDamage) {
ADDRLP4 568
INDIRI4
ADDRLP4 556
INDIRI4
NEI4 $226
line 381
;381:				competitors[numCompetitors++] = &level.clients[teammate];
ADDRLP4 576
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 0
ADDRLP4 576
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 576
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $183
ADDP4
ADDRLP4 552
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 382
;382:				continue;
ADDRGP4 $207
JUMPV
LABELV $226
line 385
;383:			}
;384:
;385:			if (bs->cur_ps.stats[STAT_HEALTH] < bs->cur_ps.stats[STAT_MAX_HEALTH]) {
ADDRLP4 576
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 576
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ADDRLP4 576
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
GEI4 $228
line 386
;386:				if (DistanceSquared(bs->origin, ps.origin) > 600.0*600.0) continue;
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 84+20
ARGP4
ADDRLP4 580
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 580
INDIRF4
CNSTF4 1219479552
LEF4 $229
ADDRGP4 $207
JUMPV
line 387
;387:			}
LABELV $228
line 388
;388:			else {
line 389
;389:				if (DistanceSquared(bs->origin, ps.origin) > 1500.0*1500.0) continue;
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 84+20
ARGP4
ADDRLP4 580
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 580
INDIRF4
CNSTF4 1242125376
LEF4 $233
ADDRGP4 $207
JUMPV
LABELV $233
line 390
;390:			}
LABELV $229
line 391
;391:			if (!BotEntityVisible(&bs->cur_ps, 360, teammate)) continue;
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 552
INDIRI4
ARGI4
ADDRLP4 580
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 580
INDIRF4
CNSTF4 0
NEF4 $236
ADDRGP4 $207
JUMPV
LABELV $236
line 393
;392:
;393:			if (BotArmorIsUsefulForPlayer(&ps)) collectArmor = qfalse;
ADDRLP4 84
ARGP4
ADDRLP4 584
ADDRGP4 BotArmorIsUsefulForPlayer
CALLI4
ASGNI4
ADDRLP4 584
INDIRI4
CNSTI4 0
EQI4 $238
ADDRLP4 40
CNSTI4 0
ASGNI4
LABELV $238
line 394
;394:			if (BotLimitedHealthIsUsefulForPlayer(&ps)) collectLimitedHealth = qfalse;
ADDRLP4 84
ARGP4
ADDRLP4 588
ADDRGP4 BotLimitedHealthIsUsefulForPlayer
CALLI4
ASGNI4
ADDRLP4 588
INDIRI4
CNSTI4 0
EQI4 $240
ADDRLP4 48
CNSTI4 0
ASGNI4
LABELV $240
line 395
;395:			if (BotUnlimitedHealthIsUsefulForPlayer(&ps)) collectUnlimitedHealth = qfalse;
ADDRLP4 84
ARGP4
ADDRLP4 592
ADDRGP4 BotUnlimitedHealthIsUsefulForPlayer
CALLI4
ASGNI4
ADDRLP4 592
INDIRI4
CNSTI4 0
EQI4 $242
ADDRLP4 36
CNSTI4 0
ASGNI4
LABELV $242
line 396
;396:			if (BotHoldableItemIsUsefulForPlayer(&ps)) collectHoldableItem = qfalse;
ADDRLP4 84
ARGP4
ADDRLP4 596
ADDRGP4 BotHoldableItemIsUsefulForPlayer
CALLI4
ASGNI4
ADDRLP4 596
INDIRI4
CNSTI4 0
EQI4 $244
ADDRLP4 44
CNSTI4 0
ASGNI4
LABELV $244
line 397
;397:			if (ps.stats[STAT_STRENGTH] < bs->cur_ps.stats[STAT_STRENGTH]) collectStrengthRegeneration = qfalse;
ADDRLP4 84+184+28
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
GEI4 $246
ADDRLP4 52
CNSTI4 0
ASGNI4
LABELV $246
line 398
;398:		}
LABELV $207
line 371
LABELV $209
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 552
INDIRI4
ARGI4
ADDRLP4 84
ARGP4
ADDRLP4 568
ADDRGP4 BotGetNextTeamMate
CALLI4
ASGNI4
ADDRLP4 552
ADDRLP4 568
INDIRI4
ASGNI4
ADDRLP4 568
INDIRI4
CNSTI4 0
GEI4 $206
line 399
;399:	}
LABELV $200
line 402
;400:
;401:	if (
;402:		!collectArmor && !collectLimitedHealth &&
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $250
ADDRLP4 48
INDIRI4
CNSTI4 0
NEI4 $250
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $250
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $250
ADDRLP4 84
ADDRGP4 gametype
INDIRI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 8
GEI4 $250
ADDRLP4 84
INDIRI4
CNSTI4 4
NEI4 $253
ADDRGP4 g_respawnAtPOD+12
INDIRI4
CNSTI4 0
NEI4 $250
CNSTI4 1
ARGI4
ADDRLP4 88
ADDRGP4 Team_GetFlagStatus
CALLI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 4
EQI4 $250
CNSTI4 2
ARGI4
ADDRLP4 92
ADDRGP4 Team_GetFlagStatus
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 4
EQI4 $250
ADDRLP4 96
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CNSTI4 356
ADDP4
INDIRI4
CNSTI4 0
NEI4 $250
ADDRLP4 96
INDIRP4
CNSTI4 360
ADDP4
INDIRI4
CNSTI4 0
NEI4 $250
LABELV $253
line 417
;403:		!collectUnlimitedHealth && !collectHoldableItem &&
;404:#if MONSTER_MODE
;405:		gametype < GT_STU &&
;406:#endif
;407:		(
;408:			gametype != GT_CTF ||
;409:			(
;410:				!g_respawnAtPOD.integer &&
;411:				Team_GetFlagStatus(TEAM_RED) != FLAG_DROPPED &&
;412:				Team_GetFlagStatus(TEAM_BLUE) != FLAG_DROPPED &&
;413:				!bs->cur_ps.powerups[PW_REDFLAG] &&
;414:				!bs->cur_ps.powerups[PW_BLUEFLAG]
;415:			)
;416:		)
;417:	) {
line 418
;418:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $182
JUMPV
LABELV $250
LABELV $188
line 422
;419:	}
;420:
;421:	SearchItems:
;422:	foundItem = NULL;
ADDRLP4 16
CNSTP4 0
ASGNP4
line 423
;423:	foundEntity = NULL;
ADDRLP4 20
CNSTP4 0
ASGNP4
line 424
;424:	if (range < 0) {
ADDRFP4 8
INDIRF4
CNSTF4 0
GEF4 $254
line 425
;425:		bestTravelTime = 1000000;
ADDRLP4 8
CNSTI4 1000000
ASGNI4
line 426
;426:	}
ADDRGP4 $255
JUMPV
LABELV $254
line 427
;427:	else {
line 428
;428:		bestTravelTime = 2 * range * 0.500;	// unit: 1/100th second
ADDRLP4 8
ADDRFP4 8
INDIRF4
CVFI4 4
ASGNI4
line 429
;429:	}
LABELV $255
line 430
;430:	bestDistance = 100000;	// to choose between near items with same travel time
ADDRLP4 12
CNSTF4 1203982336
ASGNF4
line 431
;431:	for (currentEntity = MAX_CLIENTS; currentEntity < level.num_entities; currentEntity++) {
ADDRLP4 4
CNSTI4 64
ASGNI4
ADDRGP4 $259
JUMPV
LABELV $256
line 448
;432:		gentity_t* ent;
;433:		gitem_t* item;
;434:		bot_goal_t potentialGoal;
;435:		qboolean preciousItem;
;436:		qboolean teamItem;
;437:		qboolean enemyFlag;
;438:		qboolean artefact;
;439:		float distance;
;440:		float itemRange;
;441:		vec3_t floor;
;442:		trace_t trace;
;443:		int travelTime1;
;444:		int travelTime2;
;445:		int totalTravelTime;
;446:		int competitor;
;447:		
;448:		ent = &g_entities[currentEntity];
ADDRLP4 160
ADDRLP4 4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 449
;449:		if (!ent->inuse) goto NextEntity;
ADDRLP4 160
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $261
ADDRGP4 $263
JUMPV
LABELV $261
line 450
;450:		if (ent->s.eType != ET_ITEM) goto NextEntity;
ADDRLP4 160
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $264
ADDRGP4 $263
JUMPV
LABELV $264
line 451
;451:		if (ent->s.pos.trType != TR_STATIONARY) goto NextEntity;
ADDRLP4 160
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
EQI4 $266
ADDRGP4 $263
JUMPV
LABELV $266
line 453
;452:
;453:		item = ent->item;
ADDRLP4 168
ADDRLP4 160
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
ASGNP4
line 454
;454:		if (!item) goto NextEntity;
ADDRLP4 168
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $268
ADDRGP4 $263
JUMPV
LABELV $268
line 456
;455:
;456:		preciousItem = qfalse;
ADDRLP4 256
CNSTI4 0
ASGNI4
line 457
;457:		teamItem = qfalse;
ADDRLP4 252
CNSTI4 0
ASGNI4
line 458
;458:		enemyFlag = qfalse;
ADDRLP4 268
CNSTI4 0
ASGNI4
line 459
;459:		artefact = qfalse;
ADDRLP4 260
CNSTI4 0
ASGNI4
line 460
;460:		itemRange = range;
ADDRLP4 264
ADDRFP4 8
INDIRF4
ASGNF4
line 461
;461:		switch (item->giType) {
ADDRLP4 272
ADDRLP4 168
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ASGNI4
ADDRLP4 272
INDIRI4
CNSTI4 3
LTI4 $263
ADDRLP4 272
INDIRI4
CNSTI4 9
GTI4 $263
ADDRLP4 272
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $341-12
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $341
address $273
address $278
address $295
address $290
address $263
address $300
address $327
code
LABELV $273
line 463
;462:		case IT_ARMOR:
;463:			if (!collectArmor) goto NextEntity;
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $274
ADDRGP4 $263
JUMPV
LABELV $274
line 464
;464:			if (item->quantity >= 50) preciousItem = qtrue;
ADDRLP4 168
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 50
LTI4 $271
ADDRLP4 256
CNSTI4 1
ASGNI4
line 465
;465:			break;
ADDRGP4 $271
JUMPV
LABELV $278
line 467
;466:		case IT_HEALTH:
;467:			if (item->quantity > 5 && item->quantity < 100) {
ADDRLP4 168
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 5
LEI4 $279
ADDRLP4 168
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 100
GEI4 $279
line 468
;468:				if (!collectLimitedHealth) goto NextEntity;
ADDRLP4 48
INDIRI4
CNSTI4 0
NEI4 $281
ADDRGP4 $263
JUMPV
LABELV $281
line 470
;469:				if (
;470:					bs->cur_ps.stats[STAT_HEALTH] < 0.8 * bs->cur_ps.stats[STAT_MAX_HEALTH] ||
ADDRLP4 284
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 284
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 284
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1061997773
MULF4
LTF4 $285
ADDRLP4 284
INDIRP4
CNSTI4 368
ADDP4
INDIRI4
CNSTI4 0
EQI4 $271
LABELV $285
line 472
;471:					bs->cur_ps.powerups[PW_CHARGE]
;472:				) {
line 473
;473:					preciousItem = qtrue;
ADDRLP4 256
CNSTI4 1
ASGNI4
line 474
;474:				}
line 475
;475:			}
ADDRGP4 $271
JUMPV
LABELV $279
line 476
;476:			else {
line 477
;477:				if (!collectUnlimitedHealth) goto NextEntity;
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $286
ADDRGP4 $263
JUMPV
LABELV $286
line 478
;478:				if (item->quantity >= 100) preciousItem = qtrue;
ADDRLP4 168
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 100
LTI4 $271
ADDRLP4 256
CNSTI4 1
ASGNI4
line 479
;479:			}
line 480
;480:			break;
ADDRGP4 $271
JUMPV
LABELV $290
line 482
;481:		case IT_HOLDABLE:
;482:			if (!collectHoldableItem) goto NextEntity;
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $291
ADDRGP4 $263
JUMPV
LABELV $291
line 483
;483:			if (item->giTag == HI_MEDKIT) preciousItem = qtrue;
ADDRLP4 168
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
NEI4 $271
ADDRLP4 256
CNSTI4 1
ASGNI4
line 484
;484:			break;
ADDRGP4 $271
JUMPV
LABELV $295
line 486
;485:		case IT_POWERUP:
;486:			if (!collectUnlimitedHealth) goto NextEntity;
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $296
ADDRGP4 $263
JUMPV
LABELV $296
line 487
;487:			if (!collectStrengthRegeneration) goto NextEntity;
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $298
ADDRGP4 $263
JUMPV
LABELV $298
line 488
;488:			preciousItem = qtrue;
ADDRLP4 256
CNSTI4 1
ASGNI4
line 489
;489:			break;
ADDRGP4 $271
JUMPV
LABELV $300
line 492
;490:		case IT_TEAM:
;491:#if MONSTER_MODE
;492:			if (gametype == GT_STU) {
ADDRGP4 gametype
INDIRI4
CNSTI4 8
NEI4 $301
line 493
;493:				if (item->giTag != PW_QUAD) goto NextEntity;
ADDRLP4 168
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 1
EQI4 $303
ADDRGP4 $263
JUMPV
LABELV $303
line 496
;494:				if (
;495:					// ensure the "team works together" condition for unlimited artefacts
;496:					g_artefacts.integer >= 999 &&
ADDRGP4 g_artefacts+12
INDIRI4
CNSTI4 999
LTI4 $305
ADDRLP4 284
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 288
ADDRGP4 level
INDIRP4
ASGNP4
ADDRLP4 284
INDIRP4
CNSTI4 264
ADDP4
INDIRI4
ADDRGP4 level+96
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+100-4
ADDP4
INDIRI4
CNSTI4 5604
MULI4
ADDRLP4 288
INDIRP4
ADDP4
CNSTI4 248
ADDP4
INDIRI4
LEI4 $305
ADDRLP4 284
INDIRP4
CNSTI4 264
ADDP4
INDIRI4
CNSTI4 1000
ADDI4
ADDRGP4 level+96
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+100-4
ADDP4
INDIRI4
CNSTI4 5604
MULI4
ADDRLP4 288
INDIRP4
ADDP4
CNSTI4 248
ADDP4
INDIRI4
CNSTI4 1
LSHI4
LEI4 $305
line 499
;497:					bs->cur_ps.persistant[PERS_SCORE] > level.clients[level.sortedClients[level.numPlayingClients-1]].ps.persistant[PERS_SCORE] &&
;498:					bs->cur_ps.persistant[PERS_SCORE] + 1000 > 2 * level.clients[level.sortedClients[level.numPlayingClients-1]].ps.persistant[PERS_SCORE]
;499:				) {
line 500
;500:					goto NextEntity;
ADDRGP4 $263
JUMPV
LABELV $305
line 502
;501:				}
;502:				artefact = qtrue;
ADDRLP4 260
CNSTI4 1
ASGNI4
line 503
;503:				itemRange = 400;
ADDRLP4 264
CNSTF4 1137180672
ASGNF4
line 505
;504:				// NOTE: the artefact is not marked precious because the bot can't know its position
;505:				break;
ADDRGP4 $271
JUMPV
LABELV $301
line 508
;506:			}
;507:#endif
;508:			if (gametype < GT_CTF) goto NextEntity;
ADDRGP4 gametype
INDIRI4
CNSTI4 4
GEI4 $314
ADDRGP4 $263
JUMPV
LABELV $314
line 509
;509:			preciousItem = qtrue;
ADDRLP4 256
CNSTI4 1
ASGNI4
line 510
;510:			teamItem = qtrue;
ADDRLP4 252
CNSTI4 1
ASGNI4
line 511
;511:			switch (bs->cur_ps.persistant[PERS_TEAM]) {
ADDRLP4 284
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ASGNI4
ADDRLP4 284
INDIRI4
CNSTI4 1
EQI4 $319
ADDRLP4 284
INDIRI4
CNSTI4 2
EQI4 $323
ADDRGP4 $316
JUMPV
LABELV $319
line 513
;512:			case TEAM_RED:
;513:				enemyFlag = (item->giTag == PW_BLUEFLAG);
ADDRLP4 168
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 8
NEI4 $321
ADDRLP4 292
CNSTI4 1
ASGNI4
ADDRGP4 $322
JUMPV
LABELV $321
ADDRLP4 292
CNSTI4 0
ASGNI4
LABELV $322
ADDRLP4 268
ADDRLP4 292
INDIRI4
ASGNI4
line 514
;514:				break;
ADDRGP4 $271
JUMPV
LABELV $323
line 516
;515:			case TEAM_BLUE:
;516:				enemyFlag = (item->giTag == PW_REDFLAG);
ADDRLP4 168
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 7
NEI4 $325
ADDRLP4 296
CNSTI4 1
ASGNI4
ADDRGP4 $326
JUMPV
LABELV $325
ADDRLP4 296
CNSTI4 0
ASGNI4
LABELV $326
ADDRLP4 268
ADDRLP4 296
INDIRI4
ASGNI4
line 517
;517:				break;
ADDRGP4 $271
JUMPV
LABELV $316
line 519
;518:			default:
;519:				enemyFlag = qfalse;
ADDRLP4 268
CNSTI4 0
ASGNI4
line 520
;520:				break;
line 522
;521:			}
;522:			break;
ADDRGP4 $271
JUMPV
LABELV $327
line 524
;523:		case IT_POD_MARKER:
;524:			if (ent->s.otherEntityNum2 == bs->cur_ps.persistant[PERS_TEAM]) goto NextEntity;
ADDRLP4 160
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
NEI4 $328
ADDRGP4 $263
JUMPV
LABELV $328
line 525
;525:			if (BotPlayerDanger(&bs->cur_ps) > 30) goto NextEntity;
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 292
ADDRGP4 BotPlayerDanger
CALLI4
ASGNI4
ADDRLP4 292
INDIRI4
CNSTI4 30
LEI4 $330
ADDRGP4 $263
JUMPV
LABELV $330
line 526
;526:			if (ent->s.time - level.time > 10000) goto NextEntity;
ADDRLP4 160
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
SUBI4
CNSTI4 10000
LEI4 $332
ADDRGP4 $263
JUMPV
LABELV $332
line 527
;527:			if (bs->ltgtype > 0 && ent->s.time - level.time > 5000) goto NextEntity;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 0
LEI4 $335
ADDRLP4 160
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
SUBI4
CNSTI4 5000
LEI4 $335
ADDRGP4 $263
JUMPV
LABELV $335
line 528
;528:			if (bs->enemy >= 0 && ent->s.time - level.time > 3000) goto NextEntity;
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 0
LTI4 $271
ADDRLP4 160
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
SUBI4
CNSTI4 3000
LEI4 $271
ADDRGP4 $263
JUMPV
line 529
;529:			break;
line 531
;530:		default:
;531:			goto NextEntity;
LABELV $271
line 535
;532:		}
;533:
;534:		if (
;535:			range >= 0 &&
ADDRFP4 8
INDIRF4
CNSTF4 0
LTF4 $343
ADDRLP4 280
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 280
INDIRP4
CNSTI4 7272
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
SUBF4
LEF4 $343
ADDRLP4 160
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 280
INDIRP4
CNSTI4 7276
ADDP4
ARGP4
ADDRLP4 284
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 284
INDIRF4
CNSTF4 1176256512
GEF4 $343
line 538
;536:			bs->teleport_time > FloatTime() - 5 &&
;537:			DistanceSquared(ent->r.currentOrigin, bs->teleport_origin) < 100.0*100.0
;538:		) {
line 539
;539:			goto NextEntity;
ADDRGP4 $263
JUMPV
LABELV $343
line 542
;540:		}
;541:
;542:		if (range < 0) {
ADDRFP4 8
INDIRF4
CNSTF4 0
GEF4 $345
line 543
;543:			if (ent->flags & FL_DROPPED_ITEM) goto NextEntity;
ADDRLP4 160
INDIRP4
CNSTI4 540
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $347
ADDRGP4 $263
JUMPV
LABELV $347
line 544
;544:			if (DistanceSquared(bs->origin, ent->s.pos.trBase) < Square(100)) goto NextEntity;
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 160
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 288
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 288
INDIRF4
CNSTF4 1176256512
GEF4 $349
ADDRGP4 $263
JUMPV
LABELV $349
line 546
;545:
;546:			BotCreateItemGoal(ent, &potentialGoal);
ADDRLP4 160
INDIRP4
ARGP4
ADDRLP4 104
ARGP4
ADDRGP4 BotCreateItemGoal
CALLV
pop
line 547
;547:			if (potentialGoal.areanum <= 0) goto NextEntity;
ADDRLP4 104+12
INDIRI4
CNSTI4 0
GTI4 $351
ADDRGP4 $263
JUMPV
LABELV $351
line 549
;548:
;549:			VectorCopy(ent->s.pos.trBase, floor);
ADDRLP4 232
ADDRLP4 160
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 550
;550:			floor[2] -= 50;
ADDRLP4 232+8
ADDRLP4 232+8
INDIRF4
CNSTF4 1112014848
SUBF4
ASGNF4
line 551
;551:			trap_Trace(&trace, ent->s.pos.trBase, mins, maxs, floor, currentEntity, MASK_SOLID | CONTENTS_LAVA | CONTENTS_SLIME);
ADDRLP4 176
ARGP4
ADDRLP4 160
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRGP4 $184
ARGP4
ADDRGP4 $185
ARGP4
ADDRLP4 232
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
CNSTI4 25
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 552
;552:			if (trace.contents & (CONTENTS_LAVA|CONTENTS_SLIME)) goto NextEntity;
ADDRLP4 176+48
INDIRI4
CNSTI4 24
BANDI4
CNSTI4 0
EQI4 $355
ADDRGP4 $263
JUMPV
LABELV $355
line 553
;553:			if (trace.fraction >= 1) goto NextEntity;
ADDRLP4 176+8
INDIRF4
CNSTF4 1065353216
LTF4 $358
ADDRGP4 $263
JUMPV
LABELV $358
line 555
;554:
;555:			distance = Distance(refOrigin, potentialGoal.origin);
ADDRLP4 24
ARGP4
ADDRLP4 104
ARGP4
ADDRLP4 292
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRLP4 164
ADDRLP4 292
INDIRF4
ASGNF4
line 556
;556:		}
ADDRGP4 $346
JUMPV
LABELV $345
line 558
;557:		else if (
;558:			preciousItem && !(ent->flags & FL_DROPPED_ITEM) &&
ADDRLP4 256
INDIRI4
CNSTI4 0
EQI4 $361
ADDRLP4 160
INDIRP4
CNSTI4 540
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
NEI4 $361
ADDRLP4 288
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 288
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 5
NEI4 $363
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 292
ADDRGP4 BotOwnFlagStatus
CALLI4
ASGNI4
ADDRLP4 292
INDIRI4
CNSTI4 0
EQI4 $361
LABELV $363
line 563
;559:			(
;560:				bs->ltgtype != LTG_RUSHBASE ||
;561:				BotOwnFlagStatus(bs) != FLAG_ATBASE
;562:			)
;563:		) {
line 565
;564:			if (
;565:				teamItem && !enemyFlag &&
ADDRLP4 252
INDIRI4
CNSTI4 0
EQI4 $364
ADDRLP4 268
INDIRI4
CNSTI4 0
NEI4 $364
ADDRLP4 296
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 296
INDIRP4
CNSTI4 356
ADDP4
INDIRI4
CNSTI4 0
NEI4 $364
ADDRLP4 296
INDIRP4
CNSTI4 360
ADDP4
INDIRI4
CNSTI4 0
NEI4 $364
line 567
;566:				!bs->cur_ps.powerups[PW_REDFLAG] && !bs->cur_ps.powerups[PW_BLUEFLAG]
;567:			) {
line 568
;568:				goto NextEntity;
ADDRGP4 $263
JUMPV
LABELV $364
line 571
;569:			}
;570:
;571:			distance = Distance(refOrigin, ent->s.pos.trBase);
ADDRLP4 24
ARGP4
ADDRLP4 160
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 300
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRLP4 164
ADDRLP4 300
INDIRF4
ASGNF4
line 580
;572:			/*
;573:			if (bs->ltgtype == LTG_TEAMHELP) {
;574:				float d;
;575:				
;576:				d = Distance(bs->teamgoal.origin, ent->r.currentOrigin);
;577:				if (d < distance) distance = d;
;578:			}
;579:			*/
;580:			if (distance > range) goto NextEntity;
ADDRLP4 164
INDIRF4
ADDRFP4 8
INDIRF4
LEF4 $366
ADDRGP4 $263
JUMPV
LABELV $366
line 582
;581:
;582:			BotCreateItemGoal(ent, &potentialGoal);
ADDRLP4 160
INDIRP4
ARGP4
ADDRLP4 104
ARGP4
ADDRGP4 BotCreateItemGoal
CALLV
pop
line 583
;583:			if (potentialGoal.areanum <= 0) goto NextEntity;
ADDRLP4 104+12
INDIRI4
CNSTI4 0
GTI4 $368
ADDRGP4 $263
JUMPV
LABELV $368
line 585
;584:
;585:			VectorCopy(ent->s.pos.trBase, floor);
ADDRLP4 232
ADDRLP4 160
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 586
;586:			floor[2] -= 50;
ADDRLP4 232+8
ADDRLP4 232+8
INDIRF4
CNSTF4 1112014848
SUBF4
ASGNF4
line 587
;587:			trap_Trace(&trace, ent->s.pos.trBase, mins, maxs, floor, currentEntity, MASK_SOLID | CONTENTS_LAVA | CONTENTS_SLIME);
ADDRLP4 176
ARGP4
ADDRLP4 160
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRGP4 $184
ARGP4
ADDRGP4 $185
ARGP4
ADDRLP4 232
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
CNSTI4 25
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 588
;588:			if (trace.contents & (CONTENTS_LAVA|CONTENTS_SLIME)) goto NextEntity;
ADDRLP4 176+48
INDIRI4
CNSTI4 24
BANDI4
CNSTI4 0
EQI4 $372
ADDRGP4 $263
JUMPV
LABELV $372
line 589
;589:			if (trace.fraction >= 1) goto NextEntity;
ADDRLP4 176+8
INDIRF4
CNSTF4 1065353216
LTF4 $375
ADDRGP4 $263
JUMPV
LABELV $375
line 591
;590:
;591:			trap_Trace(&trace, bs->eye, NULL, NULL, potentialGoal.origin, bs->client, MASK_SHOT);
ADDRLP4 176
ARGP4
ADDRLP4 304
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 304
INDIRP4
CNSTI4 4944
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 104
ARGP4
ADDRLP4 304
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 592
;592:			if (trace.fraction >= 1) {
ADDRLP4 176+8
INDIRF4
CNSTF4 1065353216
LTF4 $378
line 593
;593:				if (!ent->r.linked || (ent->s.eFlags & EF_NODRAW)) {
ADDRLP4 160
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
CNSTI4 0
EQI4 $383
ADDRLP4 160
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $381
LABELV $383
line 594
;594:					BotRememberNBGNotAvailable(bs, potentialGoal.entitynum);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 104+40
INDIRI4
ARGI4
ADDRGP4 BotRememberNBGNotAvailable
CALLV
pop
line 595
;595:					goto NextEntity;
ADDRGP4 $263
JUMPV
LABELV $381
line 597
;596:				}
;597:				BotRememberNBGAvailable(bs, potentialGoal.entitynum);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 104+40
INDIRI4
ARGI4
ADDRGP4 BotRememberNBGAvailable
CALLV
pop
line 598
;598:			}
ADDRGP4 $362
JUMPV
LABELV $378
line 599
;599:			else {
line 600
;600:				if (!BotMayNBGBeAvailable(bs, potentialGoal.entitynum)) goto NextEntity;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 104+40
INDIRI4
ARGI4
ADDRLP4 308
ADDRGP4 BotMayNBGBeAvailable
CALLI4
ASGNI4
ADDRLP4 308
INDIRI4
CNSTI4 0
NEI4 $386
ADDRGP4 $263
JUMPV
LABELV $386
line 602
;601:
;602:				if (trap_BotItemGoalInVisButNotVisible(bs->entitynum, bs->eye, bs->viewangles, &potentialGoal)) {
ADDRLP4 312
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 312
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 312
INDIRP4
CNSTI4 4944
ADDP4
ARGP4
ADDRLP4 312
INDIRP4
CNSTI4 7840
ADDP4
ARGP4
ADDRLP4 104
ARGP4
ADDRLP4 316
ADDRGP4 trap_BotItemGoalInVisButNotVisible
CALLI4
ASGNI4
ADDRLP4 316
INDIRI4
CNSTI4 0
EQI4 $362
line 603
;603:					BotRememberNBGNotAvailable(bs, potentialGoal.entitynum);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 104+40
INDIRI4
ARGI4
ADDRGP4 BotRememberNBGNotAvailable
CALLV
pop
line 604
;604:					goto NextEntity;
ADDRGP4 $263
JUMPV
line 606
;605:				}
;606:			}
line 607
;607:		}
LABELV $361
line 608
;608:		else {
line 609
;609:			if (!ent->r.linked) goto NextEntity;
ADDRLP4 160
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
CNSTI4 0
NEI4 $392
ADDRGP4 $263
JUMPV
LABELV $392
line 610
;610:			if (ent->s.eFlags & EF_NODRAW) goto NextEntity;
ADDRLP4 160
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $394
ADDRGP4 $263
JUMPV
LABELV $394
line 612
;611:
;612:			distance = Distance(refOrigin, ent->r.currentOrigin);
ADDRLP4 24
ARGP4
ADDRLP4 160
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 296
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRLP4 164
ADDRLP4 296
INDIRF4
ASGNF4
line 621
;613:			/*
;614:			if (bs->ltgtype == LTG_TEAMHELP) {
;615:				float d;
;616:				
;617:				d = Distance(bs->teamgoal.origin, ent->r.currentOrigin);
;618:				if (d < distance) distance = d;
;619:			}
;620:			*/
;621:			if (distance > itemRange) goto NextEntity;
ADDRLP4 164
INDIRF4
ADDRLP4 264
INDIRF4
LEF4 $396
ADDRGP4 $263
JUMPV
LABELV $396
line 623
;622:
;623:			if (distance > 60 && !artefact && BotEntityVisible(&bs->cur_ps, 90, currentEntity) <= 0) goto NextEntity;
ADDRLP4 164
INDIRF4
CNSTF4 1114636288
LEF4 $398
ADDRLP4 260
INDIRI4
CNSTI4 0
NEI4 $398
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTF4 1119092736
ARGF4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 300
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 300
INDIRF4
CNSTF4 0
GTF4 $398
ADDRGP4 $263
JUMPV
LABELV $398
line 629
;624:			/*
;625:			trap_Trace(&trace, bs->eye, NULL, NULL, potentialGoal.origin, bs->client, MASK_SHOT);
;626:			if (trace.fraction < 1) goto NextLocation;
;627:			*/
;628:	
;629:			BotCreateItemGoal(ent, &potentialGoal);
ADDRLP4 160
INDIRP4
ARGP4
ADDRLP4 104
ARGP4
ADDRGP4 BotCreateItemGoal
CALLV
pop
line 630
;630:			if (potentialGoal.areanum <= 0) goto NextEntity;
ADDRLP4 104+12
INDIRI4
CNSTI4 0
GTI4 $400
ADDRGP4 $263
JUMPV
LABELV $400
line 631
;631:			if (!trap_AAS_AreaReachability(potentialGoal.areanum)) goto NextEntity;	// don't know exactly what this function does
ADDRLP4 104+12
INDIRI4
ARGI4
ADDRLP4 304
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 304
INDIRI4
CNSTI4 0
NEI4 $403
ADDRGP4 $263
JUMPV
LABELV $403
line 634
;632:
;633:#if MONSTER_MODE
;634:			if (artefact) goto GetImportantNBG;
ADDRLP4 260
INDIRI4
CNSTI4 0
EQI4 $406
ADDRGP4 $408
JUMPV
LABELV $406
line 637
;635:#endif
;636:
;637:			VectorCopy(goal->origin, floor);
ADDRLP4 232
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 638
;638:			floor[2] -= 50;
ADDRLP4 232+8
ADDRLP4 232+8
INDIRF4
CNSTF4 1112014848
SUBF4
ASGNF4
line 639
;639:			trap_Trace(&trace, goal->origin, mins, maxs, floor, currentEntity, MASK_SOLID | CONTENTS_LAVA | CONTENTS_SLIME);
ADDRLP4 176
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $184
ARGP4
ADDRGP4 $185
ARGP4
ADDRLP4 232
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
CNSTI4 25
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 640
;640:			if (trace.contents & (CONTENTS_LAVA|CONTENTS_SLIME)) goto NextEntity;
ADDRLP4 176+48
INDIRI4
CNSTI4 24
BANDI4
CNSTI4 0
EQI4 $410
ADDRGP4 $263
JUMPV
LABELV $410
line 641
;641:			if (trace.fraction >= 1) goto NextEntity;
ADDRLP4 176+8
INDIRF4
CNSTF4 1065353216
LTF4 $413
ADDRGP4 $263
JUMPV
LABELV $413
line 643
;642:
;643:			BotRememberNBGAvailable(bs, currentEntity);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 BotRememberNBGAvailable
CALLV
pop
line 644
;644:		}
LABELV $362
LABELV $346
line 646
;645:
;646:		travelTime1 = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, potentialGoal.areanum, bs->tfl);
ADDRLP4 296
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 296
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
ARGI4
ADDRLP4 296
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 104+12
INDIRI4
ARGI4
ADDRLP4 296
INDIRP4
CNSTI4 5984
ADDP4
INDIRI4
ARGI4
ADDRLP4 300
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 244
ADDRLP4 300
INDIRI4
ASGNI4
line 647
;647:		if (travelTime1 <= 0) goto NextEntity;
ADDRLP4 244
INDIRI4
CNSTI4 0
GTI4 $417
ADDRGP4 $263
JUMPV
LABELV $417
line 648
;648:		travelTime2 = trap_AAS_AreaTravelTimeToGoalArea(potentialGoal.areanum, potentialGoal.origin, bs->areanum, bs->tfl);
ADDRLP4 104+12
INDIRI4
ARGI4
ADDRLP4 104
ARGP4
ADDRLP4 304
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 304
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
ARGI4
ADDRLP4 304
INDIRP4
CNSTI4 5984
ADDP4
INDIRI4
ARGI4
ADDRLP4 308
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 248
ADDRLP4 308
INDIRI4
ASGNI4
line 649
;649:		if (travelTime2 <= 0) goto NextEntity;
ADDRLP4 248
INDIRI4
CNSTI4 0
GTI4 $420
ADDRGP4 $263
JUMPV
LABELV $420
line 651
;650:
;651:		if (teamItem) {
ADDRLP4 252
INDIRI4
CNSTI4 0
EQI4 $422
LABELV $408
line 653
;652:			GetImportantNBG:
;653:			bs->getImportantNBGItem = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 7736
ADDP4
CNSTI4 1
ASGNI4
line 654
;654:			memcpy(goal, &potentialGoal, sizeof(potentialGoal));
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 104
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 655
;655:			trap_BotPushGoal(bs->gs, goal);
ADDRFP4 0
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_BotPushGoal
CALLV
pop
line 656
;656:			foundItem = item;
ADDRLP4 16
ADDRLP4 168
INDIRP4
ASGNP4
line 657
;657:			foundEntity = ent;
ADDRLP4 20
ADDRLP4 160
INDIRP4
ASGNP4
line 658
;658:			goto SetItemCharacteristics;
ADDRGP4 $424
JUMPV
LABELV $422
line 661
;659:		}
;660:
;661:		totalTravelTime = travelTime1 + travelTime2;
ADDRLP4 172
ADDRLP4 244
INDIRI4
ADDRLP4 248
INDIRI4
ADDI4
ASGNI4
line 662
;662:		if (totalTravelTime - 50 > bestTravelTime) goto NextEntity;
ADDRLP4 172
INDIRI4
CNSTI4 50
SUBI4
ADDRLP4 8
INDIRI4
LEI4 $425
ADDRGP4 $263
JUMPV
LABELV $425
line 663
;663:		if (totalTravelTime + 50 > bestTravelTime && distance >= bestDistance) goto NextEntity;
ADDRLP4 172
INDIRI4
CNSTI4 50
ADDI4
ADDRLP4 8
INDIRI4
LEI4 $427
ADDRLP4 164
INDIRF4
ADDRLP4 12
INDIRF4
LTF4 $427
ADDRGP4 $263
JUMPV
LABELV $427
line 665
;664:
;665:		for (competitor = 0; competitor < numCompetitors; competitor++) {
ADDRLP4 100
CNSTI4 0
ASGNI4
ADDRGP4 $432
JUMPV
LABELV $429
line 668
;666:			vec_t compDist;
;667:
;668:			compDist = Distance(competitors[competitor]->ps.origin, potentialGoal.origin);
ADDRLP4 100
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $183
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 104
ARGP4
ADDRLP4 316
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRLP4 312
ADDRLP4 316
INDIRF4
ASGNF4
line 669
;669:			if (compDist < 50) goto NextEntity;
ADDRLP4 312
INDIRF4
CNSTF4 1112014848
GEF4 $433
ADDRGP4 $263
JUMPV
LABELV $433
line 670
;670:			if (potentialGoal.flags & GFL_DROPPED) {
ADDRLP4 104+48
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $435
line 671
;671:				if (!BotEntityVisible(&competitors[competitor]->ps, 90, potentialGoal.entitynum)) continue;
ADDRLP4 100
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $183
ADDP4
INDIRP4
ARGP4
CNSTF4 1119092736
ARGF4
ADDRLP4 104+40
INDIRI4
ARGI4
ADDRLP4 320
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 320
INDIRF4
CNSTF4 0
NEF4 $438
ADDRGP4 $430
JUMPV
LABELV $438
line 672
;672:			}
LABELV $435
line 673
;673:			if (compDist < distance) goto NextEntity;
ADDRLP4 312
INDIRF4
ADDRLP4 164
INDIRF4
GEF4 $441
ADDRGP4 $263
JUMPV
LABELV $441
line 674
;674:		}
LABELV $430
line 665
ADDRLP4 100
ADDRLP4 100
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $432
ADDRLP4 100
INDIRI4
ADDRLP4 0
INDIRI4
LTI4 $429
line 678
;675:
;676:#if MONSTER_MODE
;677:		if (
;678:			g_gametype.integer >= GT_STU &&
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
LTI4 $443
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 312
ADDRGP4 IsPlayerInvolvedInFighting
CALLI4
ASGNI4
ADDRLP4 312
INDIRI4
CNSTI4 0
NEI4 $443
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 160
INDIRP4
ARGP4
ADDRLP4 316
ADDRGP4 G_IsMonsterNearEntity
CALLI4
ASGNI4
ADDRLP4 316
INDIRI4
CNSTI4 0
EQI4 $443
line 681
;679:			!IsPlayerInvolvedInFighting(bs->client) &&
;680:			G_IsMonsterNearEntity(&g_entities[bs->client], ent)
;681:		) {
line 682
;682:			BotRememberNBGNotAvailable(bs, ent->s.number);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 160
INDIRP4
INDIRI4
ARGI4
ADDRGP4 BotRememberNBGNotAvailable
CALLV
pop
line 683
;683:			goto NextEntity;
ADDRGP4 $263
JUMPV
LABELV $443
line 687
;684:		}
;685:#endif
;686:
;687:		bestTravelTime = totalTravelTime;
ADDRLP4 8
ADDRLP4 172
INDIRI4
ASGNI4
line 688
;688:		bestDistance = distance;
ADDRLP4 12
ADDRLP4 164
INDIRF4
ASGNF4
line 689
;689:		memcpy(goal, &potentialGoal, sizeof(potentialGoal));
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 104
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 690
;690:		foundItem = item;
ADDRLP4 16
ADDRLP4 168
INDIRP4
ASGNP4
line 691
;691:		foundEntity = ent;
ADDRLP4 20
ADDRLP4 160
INDIRP4
ASGNP4
LABELV $263
line 693
;692:
;693:		NextEntity:;
line 694
;694:	}
LABELV $257
line 431
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $259
ADDRLP4 4
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $256
line 696
;695:
;696:	if (foundItem) trap_BotPushGoal(bs->gs, goal);
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $446
ADDRFP4 0
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_BotPushGoal
CALLV
pop
LABELV $446
LABELV $424
line 699
;697:
;698:	SetItemCharacteristics:
;699:	if (foundItem) {
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $448
line 700
;700:		bs->nbgEntity = foundEntity;
ADDRFP4 0
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 20
INDIRP4
ASGNP4
line 702
;701:
;702:		switch (foundItem->giType) {
ADDRLP4 100
ADDRLP4 16
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 3
LTI4 $450
ADDRLP4 100
INDIRI4
CNSTI4 9
GTI4 $450
ADDRLP4 100
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $465-12
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $465
address $453
address $454
address $458
address $457
address $450
address $459
address $463
code
LABELV $453
line 704
;703:		case IT_ARMOR:
;704:			bs->nbgGivesArmor = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 1
ASGNI4
line 705
;705:			bs->nbgGivesLimitedHealth = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6616
ADDP4
CNSTI4 0
ASGNI4
line 706
;706:			bs->nbgGivesUnlimitedHealth = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
CNSTI4 0
ASGNI4
line 707
;707:			bs->nbgGivesHoldableItem = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
CNSTI4 0
ASGNI4
line 708
;708:			bs->nbgGivesStrength = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6628
ADDP4
CNSTI4 0
ASGNI4
line 709
;709:			bs->nbgGivesFlag = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6632
ADDP4
CNSTI4 0
ASGNI4
line 710
;710:			break;
ADDRGP4 $451
JUMPV
LABELV $454
line 712
;711:		case IT_HEALTH:
;712:			bs->nbgGivesArmor = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 713
;713:			bs->nbgGivesHoldableItem = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
CNSTI4 0
ASGNI4
line 714
;714:			bs->nbgGivesStrength = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6628
ADDP4
CNSTI4 0
ASGNI4
line 715
;715:			bs->nbgGivesFlag = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6632
ADDP4
CNSTI4 0
ASGNI4
line 716
;716:			if (foundItem->quantity > 5 && foundItem->quantity < 100) {
ADDRLP4 16
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 5
LEI4 $455
ADDRLP4 16
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 100
GEI4 $455
line 717
;717:				bs->nbgGivesLimitedHealth = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6616
ADDP4
CNSTI4 1
ASGNI4
line 718
;718:				bs->nbgGivesUnlimitedHealth = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
CNSTI4 0
ASGNI4
line 719
;719:			}
ADDRGP4 $451
JUMPV
LABELV $455
line 720
;720:			else {
line 721
;721:				bs->nbgGivesLimitedHealth = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6616
ADDP4
CNSTI4 0
ASGNI4
line 722
;722:				bs->nbgGivesUnlimitedHealth = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
CNSTI4 1
ASGNI4
line 723
;723:			}
line 724
;724:			break;
ADDRGP4 $451
JUMPV
LABELV $457
line 726
;725:		case IT_HOLDABLE:
;726:			bs->nbgGivesArmor = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 727
;727:			bs->nbgGivesLimitedHealth = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6616
ADDP4
CNSTI4 0
ASGNI4
line 728
;728:			bs->nbgGivesUnlimitedHealth = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
CNSTI4 0
ASGNI4
line 729
;729:			bs->nbgGivesHoldableItem = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
CNSTI4 1
ASGNI4
line 730
;730:			bs->nbgGivesStrength = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6628
ADDP4
CNSTI4 0
ASGNI4
line 731
;731:			bs->nbgGivesFlag = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6632
ADDP4
CNSTI4 0
ASGNI4
line 732
;732:			break;
ADDRGP4 $451
JUMPV
LABELV $458
line 734
;733:		case IT_POWERUP:
;734:			bs->nbgGivesArmor = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 735
;735:			bs->nbgGivesLimitedHealth = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6616
ADDP4
CNSTI4 0
ASGNI4
line 736
;736:			bs->nbgGivesUnlimitedHealth = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
CNSTI4 1
ASGNI4
line 737
;737:			bs->nbgGivesHoldableItem = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
CNSTI4 0
ASGNI4
line 738
;738:			bs->nbgGivesStrength = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6628
ADDP4
CNSTI4 1
ASGNI4
line 739
;739:			bs->nbgGivesFlag = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6632
ADDP4
CNSTI4 0
ASGNI4
line 740
;740:			break;
ADDRGP4 $451
JUMPV
LABELV $459
line 742
;741:		case IT_TEAM:
;742:			bs->nbgGivesArmor = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 743
;743:			bs->nbgGivesLimitedHealth = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6616
ADDP4
CNSTI4 0
ASGNI4
line 744
;744:			bs->nbgGivesUnlimitedHealth = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
CNSTI4 0
ASGNI4
line 745
;745:			bs->nbgGivesHoldableItem = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
CNSTI4 0
ASGNI4
line 746
;746:			bs->nbgGivesStrength = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6628
ADDP4
CNSTI4 0
ASGNI4
line 750
;747:#if !MONSTER_MODE
;748:			bs->nbgGivesFlag = qtrue;
;749:#else
;750:			bs->nbgGivesFlag = (foundItem->giTag != PW_QUAD);
ADDRLP4 16
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 1
EQI4 $461
ADDRLP4 112
CNSTI4 1
ASGNI4
ADDRGP4 $462
JUMPV
LABELV $461
ADDRLP4 112
CNSTI4 0
ASGNI4
LABELV $462
ADDRFP4 0
INDIRP4
CNSTI4 6632
ADDP4
ADDRLP4 112
INDIRI4
ASGNI4
line 752
;751:#endif
;752:			break;
ADDRGP4 $451
JUMPV
LABELV $463
line 754
;753:		case IT_POD_MARKER:
;754:			bs->nbgGivesArmor = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 755
;755:			bs->nbgGivesLimitedHealth = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6616
ADDP4
CNSTI4 0
ASGNI4
line 756
;756:			bs->nbgGivesUnlimitedHealth = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
CNSTI4 0
ASGNI4
line 757
;757:			bs->nbgGivesHoldableItem = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
CNSTI4 0
ASGNI4
line 758
;758:			bs->nbgGivesStrength = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6628
ADDP4
CNSTI4 0
ASGNI4
line 759
;759:			bs->nbgGivesFlag = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6632
ADDP4
CNSTI4 0
ASGNI4
line 760
;760:			bs->nbgGivesPODMarker = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6636
ADDP4
CNSTI4 1
ASGNI4
line 761
;761:			break;
ADDRGP4 $451
JUMPV
LABELV $450
line 763
;762:		default:
;763:			G_Error("BUG! BotChooseNearbyItem: found item type #%d (%s)", foundItem->giType, foundItem->classname);
ADDRGP4 $464
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
INDIRP4
INDIRP4
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 764
;764:			break;
LABELV $451
line 766
;765:		}
;766:	}
LABELV $448
line 767
;767:	return foundItem != NULL;
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $468
ADDRLP4 100
CNSTI4 1
ASGNI4
ADDRGP4 $469
JUMPV
LABELV $468
ADDRLP4 100
CNSTI4 0
ASGNI4
LABELV $469
ADDRLP4 100
INDIRI4
RETI4
LABELV $182
endproc BotChooseNearbyItem 600 28
export BotNearbyGoal
proc BotNearbyGoal 24 16
line 775
;768:}
;769:
;770:/*
;771:==================
;772:BotNearbyGoal
;773:==================
;774:*/
;775:int BotNearbyGoal(bot_state_t *bs, int tfl, bot_goal_t *ltg, float range) {
line 778
;776:	int ret;
;777:
;778:	if (range <= 0) return BotChooseNearbyItem(bs, ltg, range);	// JUHOX
ADDRFP4 12
INDIRF4
CNSTF4 0
GTF4 $471
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 BotChooseNearbyItem
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $470
JUMPV
LABELV $471
line 780
;779:	//check if the bot should go for air
;780:	if (BotGoForAir(bs, tfl, ltg, range)) return qtrue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 BotGoForAir
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $473
CNSTI4 1
RETI4
ADDRGP4 $470
JUMPV
LABELV $473
line 796
;781:#if 0	// JUHOX: don't adjust the range, just trust me!
;782:	//if the bot is carrying the enemy flag
;783:	if (BotCTFCarryingFlag(bs)) {
;784:		//if the bot is just a few secs away from the base 
;785:		if (trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin,
;786:				bs->teamgoal.areanum, TFL_DEFAULT) < 300) {
;787:			//make the range really small
;788:			range = 50;
;789:		}
;790:	}
;791:#endif
;792:	//
;793:#if 0	// JUHOX: new NBG item choosing strategy
;794:	ret = trap_BotChooseNBGItem(bs->gs, bs->origin, bs->inventory, tfl, ltg, range);
;795:#else
;796:	if (bs->teleport_time > FloatTime() - 3 && !BotWantsToRetreat(bs)) return qfalse;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 7272
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1077936128
SUBF4
LEF4 $475
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 BotWantsToRetreat
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $475
CNSTI4 0
RETI4
ADDRGP4 $470
JUMPV
LABELV $475
line 798
;797:
;798:	ret = BotChooseNearbyItem(bs, ltg, range);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 20
ADDRGP4 BotChooseNearbyItem
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 20
INDIRI4
ASGNI4
line 810
;799:#endif
;800:	/*
;801:	if (ret)
;802:	{
;803:		char buf[128];
;804:		//get the goal at the top of the stack
;805:		trap_BotGetTopGoal(bs->gs, &goal);
;806:		trap_BotGoalName(goal.number, buf, sizeof(buf));
;807:		BotAI_Print(PRT_MESSAGE, "%1.1f: new nearby goal %s\n", FloatTime(), buf);
;808:	}
;809:	*/
;810:	return ret;
ADDRLP4 0
INDIRI4
RETI4
LABELV $470
endproc BotNearbyGoal 24 16
proc BotCheckNBG 588 12
line 818
;811:}
;812:
;813:/*
;814:==================
;815:JUHOX: BotCheckNBG
;816:==================
;817:*/
;818:static int BotCheckNBG(bot_state_t* bs, bot_goal_t* goal) {
line 825
;819:	qboolean collectArmor;
;820:	qboolean collectLimitedHealth;
;821:	qboolean collectUnlimitedHealth;
;822:	qboolean collectHoldableItem;
;823:	qboolean collectStrengthRegeneration;
;824:
;825:	if (bs->getImportantNBGItem || bs->nbgGivesFlag) return qtrue;
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 7736
ADDP4
INDIRI4
CNSTI4 0
NEI4 $480
ADDRLP4 20
INDIRP4
CNSTI4 6632
ADDP4
INDIRI4
CNSTI4 0
EQI4 $478
LABELV $480
CNSTI4 1
RETI4
ADDRGP4 $477
JUMPV
LABELV $478
line 827
;826:
;827:	if (bs->nbgGivesPODMarker) {
ADDRFP4 0
INDIRP4
CNSTI4 6636
ADDP4
INDIRI4
CNSTI4 0
EQI4 $481
line 831
;828:		int teammate;
;829:		playerState_t ps;
;830:
;831:		if (BotPlayerDanger(&bs->cur_ps) > 50) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 496
ADDRGP4 BotPlayerDanger
CALLI4
ASGNI4
ADDRLP4 496
INDIRI4
CNSTI4 50
LEI4 $483
CNSTI4 0
RETI4
ADDRGP4 $477
JUMPV
LABELV $483
line 833
;832:
;833:		for (teammate = -1; (teammate = BotGetNextTeamMate(bs, teammate, &ps)) >= 0;) {
ADDRLP4 492
CNSTI4 -1
ASGNI4
ADDRGP4 $488
JUMPV
LABELV $485
line 834
;834:			if (ps.stats[STAT_HEALTH] <= 0) continue;
ADDRLP4 24+184
INDIRI4
CNSTI4 0
GTI4 $489
ADDRGP4 $486
JUMPV
LABELV $489
line 835
;835:			if (DistanceSquared(ps.origin, goal->origin) < 50*50) return qfalse;
ADDRLP4 24+20
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 500
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 500
INDIRF4
CNSTF4 1159479296
GEF4 $492
CNSTI4 0
RETI4
ADDRGP4 $477
JUMPV
LABELV $492
line 836
;836:		}
LABELV $486
line 833
LABELV $488
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 492
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
ADDRLP4 500
ADDRGP4 BotGetNextTeamMate
CALLI4
ASGNI4
ADDRLP4 492
ADDRLP4 500
INDIRI4
ASGNI4
ADDRLP4 500
INDIRI4
CNSTI4 0
GEI4 $485
line 837
;837:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $477
JUMPV
LABELV $481
line 840
;838:	}
;839:
;840:	if (bs->cur_ps.powerups[PW_SHIELD]) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 372
ADDP4
INDIRI4
CNSTI4 0
EQI4 $495
CNSTI4 0
RETI4
ADDRGP4 $477
JUMPV
LABELV $495
line 842
;841:
;842:	collectArmor = (bs->nbgGivesArmor && BotArmorIsUsefulForPlayer(&bs->cur_ps));
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 6612
ADDP4
INDIRI4
CNSTI4 0
EQI4 $498
ADDRLP4 28
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 32
ADDRGP4 BotArmorIsUsefulForPlayer
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $498
ADDRLP4 24
CNSTI4 1
ASGNI4
ADDRGP4 $499
JUMPV
LABELV $498
ADDRLP4 24
CNSTI4 0
ASGNI4
LABELV $499
ADDRLP4 0
ADDRLP4 24
INDIRI4
ASGNI4
line 843
;843:	collectLimitedHealth = (bs->nbgGivesLimitedHealth && BotLimitedHealthIsUsefulForPlayer(&bs->cur_ps));
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 6616
ADDP4
INDIRI4
CNSTI4 0
EQI4 $501
ADDRLP4 40
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 44
ADDRGP4 BotLimitedHealthIsUsefulForPlayer
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $501
ADDRLP4 36
CNSTI4 1
ASGNI4
ADDRGP4 $502
JUMPV
LABELV $501
ADDRLP4 36
CNSTI4 0
ASGNI4
LABELV $502
ADDRLP4 4
ADDRLP4 36
INDIRI4
ASGNI4
line 844
;844:	collectUnlimitedHealth = (bs->nbgGivesUnlimitedHealth && BotUnlimitedHealthIsUsefulForPlayer(&bs->cur_ps));
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 6620
ADDP4
INDIRI4
CNSTI4 0
EQI4 $504
ADDRLP4 52
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 56
ADDRGP4 BotUnlimitedHealthIsUsefulForPlayer
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $504
ADDRLP4 48
CNSTI4 1
ASGNI4
ADDRGP4 $505
JUMPV
LABELV $504
ADDRLP4 48
CNSTI4 0
ASGNI4
LABELV $505
ADDRLP4 8
ADDRLP4 48
INDIRI4
ASGNI4
line 845
;845:	collectHoldableItem = (bs->nbgGivesHoldableItem && BotHoldableItemIsUsefulForPlayer(&bs->cur_ps));
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 6624
ADDP4
INDIRI4
CNSTI4 0
EQI4 $507
ADDRLP4 64
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 68
ADDRGP4 BotHoldableItemIsUsefulForPlayer
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $507
ADDRLP4 60
CNSTI4 1
ASGNI4
ADDRGP4 $508
JUMPV
LABELV $507
ADDRLP4 60
CNSTI4 0
ASGNI4
LABELV $508
ADDRLP4 12
ADDRLP4 60
INDIRI4
ASGNI4
line 846
;846:	collectStrengthRegeneration = bs->nbgGivesStrength;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 6628
ADDP4
INDIRI4
ASGNI4
line 848
;847:	if (
;848:		!collectArmor &&
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $509
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $509
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $509
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $509
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $509
line 853
;849:		!collectLimitedHealth &&
;850:		!collectUnlimitedHealth &&
;851:		!collectHoldableItem &&
;852:		!collectStrengthRegeneration
;853:	) {
line 854
;854:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $477
JUMPV
LABELV $509
line 857
;855:	}
;856:
;857:	if (BotPlayerDanger(&bs->cur_ps) < 75) {
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 72
ADDRGP4 BotPlayerDanger
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 75
GEI4 $511
line 862
;858:		playerState_t ps;
;859:		int teammate;
;860:		int killDamage;
;861:
;862:		killDamage = BotPlayerKillDamage(&bs->cur_ps) - 10;
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 552
ADDRGP4 BotPlayerKillDamage
CALLI4
ASGNI4
ADDRLP4 548
ADDRLP4 552
INDIRI4
CNSTI4 10
SUBI4
ASGNI4
line 863
;863:		if (bs->cur_ps.powerups[PW_REDFLAG] || bs->cur_ps.powerups[PW_BLUEFLAG]) killDamage -= 50;
ADDRLP4 556
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 556
INDIRP4
CNSTI4 356
ADDP4
INDIRI4
CNSTI4 0
NEI4 $515
ADDRLP4 556
INDIRP4
CNSTI4 360
ADDP4
INDIRI4
CNSTI4 0
EQI4 $513
LABELV $515
ADDRLP4 548
ADDRLP4 548
INDIRI4
CNSTI4 50
SUBI4
ASGNI4
LABELV $513
line 864
;864:		for (teammate = -1; (teammate = BotGetNextTeamMate(bs, teammate, &ps)) >= 0;) {
ADDRLP4 544
CNSTI4 -1
ASGNI4
ADDRGP4 $519
JUMPV
LABELV $516
line 867
;865:			int kd;
;866:
;867:			if (ps.stats[STAT_HEALTH] <= 0) continue;
ADDRLP4 76+184
INDIRI4
CNSTI4 0
GTI4 $520
ADDRGP4 $517
JUMPV
LABELV $520
line 868
;868:			if (ps.powerups[PW_SHIELD]) continue;
ADDRLP4 76+312+44
INDIRI4
CNSTI4 0
EQI4 $523
ADDRGP4 $517
JUMPV
LABELV $523
line 869
;869:			kd = BotPlayerKillDamage(&ps);
ADDRLP4 76
ARGP4
ADDRLP4 564
ADDRGP4 BotPlayerKillDamage
CALLI4
ASGNI4
ADDRLP4 560
ADDRLP4 564
INDIRI4
ASGNI4
line 870
;870:			if (ps.powerups[PW_REDFLAG] || ps.powerups[PW_BLUEFLAG]) kd -= 50;
ADDRLP4 76+312+28
INDIRI4
CNSTI4 0
NEI4 $533
ADDRLP4 76+312+32
INDIRI4
CNSTI4 0
EQI4 $527
LABELV $533
ADDRLP4 560
ADDRLP4 560
INDIRI4
CNSTI4 50
SUBI4
ASGNI4
LABELV $527
line 871
;871:			if (kd >= killDamage) continue;
ADDRLP4 560
INDIRI4
ADDRLP4 548
INDIRI4
LTI4 $534
ADDRGP4 $517
JUMPV
LABELV $534
line 873
;872:
;873:			if (bs->cur_ps.stats[STAT_HEALTH] < bs->cur_ps.stats[STAT_MAX_HEALTH]) {
ADDRLP4 568
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 568
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ADDRLP4 568
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
GEI4 $536
line 874
;874:				if (DistanceSquared(bs->origin, ps.origin) > 600.0*600.0) continue;
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 76+20
ARGP4
ADDRLP4 572
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 572
INDIRF4
CNSTF4 1219479552
LEF4 $538
ADDRGP4 $517
JUMPV
LABELV $538
line 875
;875:				if (!BotEntityVisible(&bs->cur_ps, 360, teammate)) continue;
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 544
INDIRI4
ARGI4
ADDRLP4 576
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 576
INDIRF4
CNSTF4 0
NEF4 $537
ADDRGP4 $517
JUMPV
line 876
;876:			}
LABELV $536
line 877
;877:			else {
line 878
;878:				if (DistanceSquared(bs->origin, ps.origin) > 1500.0*1500.0) continue;
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 76+20
ARGP4
ADDRLP4 572
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 572
INDIRF4
CNSTF4 1242125376
LEF4 $543
ADDRGP4 $517
JUMPV
LABELV $543
line 879
;879:			}
LABELV $537
line 881
;880:
;881:			if (collectArmor && BotArmorIsUsefulForPlayer(&ps)) collectArmor = qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $546
ADDRLP4 76
ARGP4
ADDRLP4 572
ADDRGP4 BotArmorIsUsefulForPlayer
CALLI4
ASGNI4
ADDRLP4 572
INDIRI4
CNSTI4 0
EQI4 $546
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $546
line 882
;882:			if (collectLimitedHealth && BotLimitedHealthIsUsefulForPlayer(&ps)) collectLimitedHealth = qfalse;
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $548
ADDRLP4 76
ARGP4
ADDRLP4 576
ADDRGP4 BotLimitedHealthIsUsefulForPlayer
CALLI4
ASGNI4
ADDRLP4 576
INDIRI4
CNSTI4 0
EQI4 $548
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $548
line 883
;883:			if (collectUnlimitedHealth && BotUnlimitedHealthIsUsefulForPlayer(&ps)) collectUnlimitedHealth = qfalse;
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $550
ADDRLP4 76
ARGP4
ADDRLP4 580
ADDRGP4 BotUnlimitedHealthIsUsefulForPlayer
CALLI4
ASGNI4
ADDRLP4 580
INDIRI4
CNSTI4 0
EQI4 $550
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $550
line 884
;884:			if (collectHoldableItem && BotHoldableItemIsUsefulForPlayer(&ps)) collectHoldableItem = qfalse;
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $552
ADDRLP4 76
ARGP4
ADDRLP4 584
ADDRGP4 BotHoldableItemIsUsefulForPlayer
CALLI4
ASGNI4
ADDRLP4 584
INDIRI4
CNSTI4 0
EQI4 $552
ADDRLP4 12
CNSTI4 0
ASGNI4
LABELV $552
line 885
;885:			if (ps.stats[STAT_STRENGTH] < bs->cur_ps.stats[STAT_STRENGTH]) collectStrengthRegeneration = qfalse;
ADDRLP4 76+184+28
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
GEI4 $554
ADDRLP4 16
CNSTI4 0
ASGNI4
LABELV $554
line 886
;886:		}
LABELV $517
line 864
LABELV $519
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 544
INDIRI4
ARGI4
ADDRLP4 76
ARGP4
ADDRLP4 560
ADDRGP4 BotGetNextTeamMate
CALLI4
ASGNI4
ADDRLP4 544
ADDRLP4 560
INDIRI4
ASGNI4
ADDRLP4 560
INDIRI4
CNSTI4 0
GEI4 $516
line 887
;887:	}
LABELV $511
line 890
;888:
;889:	if (
;890:		!collectArmor &&
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $558
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $558
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $558
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $558
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $558
line 895
;891:		!collectLimitedHealth &&
;892:		!collectUnlimitedHealth &&
;893:		!collectHoldableItem &&
;894:		!collectStrengthRegeneration
;895:	) {
line 896
;896:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $477
JUMPV
LABELV $558
line 901
;897:	}
;898:
;899:#if MONSTER_MODE
;900:	if (
;901:		g_gametype.integer == GT_STU &&
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
NEI4 $560
ADDRGP4 g_cloakingDevice+12
INDIRI4
CNSTI4 0
EQI4 $560
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 76
ADDRGP4 IsPlayerInvolvedInFighting
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
NEI4 $560
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 6608
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $560
ADDRLP4 80
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 80
INDIRP4
CNSTI4 6608
ADDP4
INDIRP4
ARGP4
ADDRLP4 84
ADDRGP4 G_IsMonsterNearEntity
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
EQI4 $560
line 906
;902:		g_cloakingDevice.integer &&
;903:		!IsPlayerInvolvedInFighting(bs->client) &&
;904:		bs->nbgEntity &&
;905:		G_IsMonsterNearEntity(&g_entities[bs->client], bs->nbgEntity)
;906:	) {
line 907
;907:		BotRememberNBGNotAvailable(bs, bs->nbgEntity->s.number);
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRLP4 88
INDIRP4
CNSTI4 6608
ADDP4
INDIRP4
INDIRI4
ARGI4
ADDRGP4 BotRememberNBGNotAvailable
CALLV
pop
line 908
;908:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $477
JUMPV
LABELV $560
line 912
;909:	}
;910:#endif
;911:
;912:	return qtrue;
CNSTI4 1
RETI4
LABELV $477
endproc BotCheckNBG 588 12
data
align 4
LABELV $565
address $566
export FindEscapeGoal
code
proc FindEscapeGoal 236 16
line 924
;913:}
;914:
;915:/*
;916:==================
;917:JUHOX: FindEscapeGoal
;918:==================
;919:*/
;920:qboolean FindEscapeGoal(
;921:	playerState_t* refugeePS, int refugeeArea, int refugeeTFL,
;922:	int pursuerArea, vec3_t pursuerOrigin,
;923:	bot_goal_t* goal
;924:) {
line 967
;925:	static char* itemNames[] = {
;926:		"emergency"
;927:		/*
;928:		"Armor Shard",
;929:		"Armor",
;930:		"Heavy Armor",
;931:		"5 Health",
;932:		"25 Health",
;933:		"50 Health",
;934:		"Mega Health",
;935:		"Regeneration",
;936:		"Personal Teleporter",
;937:		"Medkit",
;938:		"Red Flag",
;939:		"Blue Flag"
;940:		*/
;941:		/*
;942:		"Gauntlet",
;943:		"Shotgun",
;944:		"Machinegun",
;945:		"Grenade Launcher",
;946:		"Rocket Launcher",
;947:		"Lightning Gun",
;948:		"Railgun",
;949:		"Plasma Gun",
;950:		"BFG10K",
;951:		"Grappling Hook",
;952:		"Shells",
;953:		"Bullets",
;954:		"Grenades",
;955:		"Cells",
;956:		"Lightning",
;957:		"Rockets",
;958:		"Slugs",
;959:		"Bfg Ammo",
;960:		"Quad Damage",
;961:		"Battle Suit",
;962:		"Speed",
;963:		"Invisibility",
;964:		"Flight",
;965:		*/
;966:	};
;967:	const int numItems = sizeof(itemNames) / sizeof(itemNames[0]);
ADDRLP4 192
CNSTI4 1
ASGNI4
line 978
;968:	int currentItemName;
;969:	bot_goal_t potentialGoal;
;970:	bot_goal_t nearestGoal;
;971:	qboolean foundNearestGoal;
;972:	int nearestGoalTravelTime;
;973:	bot_goal_t bestGoal;
;974:	qboolean foundBestGoal;
;975:	int bestGoalTravelTime;	// pursuer travel time - refugee travel time (the higher the better)
;976:	int refugeeHome;
;977:
;978:	if (refugeeArea <= 0) return qfalse;
ADDRFP4 4
INDIRI4
CNSTI4 0
GTI4 $567
CNSTI4 0
RETI4
ADDRGP4 $564
JUMPV
LABELV $567
line 979
;979:	if (pursuerArea <= 0) return qfalse;
ADDRFP4 12
INDIRI4
CNSTI4 0
GTI4 $569
CNSTI4 0
RETI4
ADDRGP4 $564
JUMPV
LABELV $569
line 981
;980:
;981:	refugeeHome = -1;
ADDRLP4 64
CNSTI4 -1
ASGNI4
line 982
;982:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $571
line 983
;983:		switch (refugeePS->persistant[PERS_TEAM]) {
ADDRLP4 196
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
ASGNI4
ADDRLP4 196
INDIRI4
CNSTI4 1
EQI4 $576
ADDRLP4 196
INDIRI4
CNSTI4 2
EQI4 $578
ADDRGP4 $573
JUMPV
LABELV $576
line 985
;984:		case TEAM_RED:
;985:			refugeeHome = ctf_redflag.areanum;
ADDRLP4 64
ADDRGP4 ctf_redflag+12
INDIRI4
ASGNI4
line 986
;986:			break;
ADDRGP4 $574
JUMPV
LABELV $578
line 988
;987:		case TEAM_BLUE:
;988:			refugeeHome = ctf_blueflag.areanum;
ADDRLP4 64
ADDRGP4 ctf_blueflag+12
INDIRI4
ASGNI4
line 989
;989:			break;
LABELV $573
LABELV $574
line 991
;990:		}
;991:	}
LABELV $571
line 993
;992:
;993:	if (!refugeeTFL)
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $580
line 994
;994:	{
line 997
;995:		vec3_t feet;
;996:
;997:		refugeeTFL = TFL_DEFAULT;
ADDRFP4 8
CNSTI4 18616254
ASGNI4
line 998
;998:		VectorCopy(refugeePS->origin, feet);
ADDRLP4 196
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 999
;999:		feet[2] -= 23;
ADDRLP4 196+8
ADDRLP4 196+8
INDIRF4
CNSTF4 1102577664
SUBF4
ASGNF4
line 1000
;1000:		if (trap_AAS_PointContents(feet) & (CONTENTS_LAVA|CONTENTS_SLIME)) refugeeTFL |= TFL_LAVA | TFL_SLIME;
ADDRLP4 196
ARGP4
ADDRLP4 208
ADDRGP4 trap_AAS_PointContents
CALLI4
ASGNI4
ADDRLP4 208
INDIRI4
CNSTI4 24
BANDI4
CNSTI4 0
EQI4 $583
ADDRFP4 8
ADDRFP4 8
INDIRI4
CNSTI4 6291456
BORI4
ASGNI4
LABELV $583
line 1001
;1001:	}
LABELV $580
line 1003
;1002:
;1003:	foundNearestGoal = qfalse;
ADDRLP4 180
CNSTI4 0
ASGNI4
line 1004
;1004:	nearestGoalTravelTime = 100000;
ADDRLP4 56
CNSTI4 100000
ASGNI4
line 1005
;1005:	foundBestGoal = qfalse;
ADDRLP4 184
CNSTI4 0
ASGNI4
line 1006
;1006:	bestGoalTravelTime = 0;
ADDRLP4 60
CNSTI4 0
ASGNI4
line 1007
;1007:	for (currentItemName = 0; currentItemName < numItems; currentItemName++) {
ADDRLP4 188
CNSTI4 0
ASGNI4
ADDRGP4 $588
JUMPV
LABELV $585
line 1011
;1008:		char* itemname;
;1009:		int aLocation;
;1010:
;1011:		itemname = itemNames[currentItemName];
ADDRLP4 200
ADDRLP4 188
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $565
ADDP4
INDIRP4
ASGNP4
line 1012
;1012:		for (aLocation = -1; (aLocation = GetItemGoal(aLocation, itemname, &potentialGoal)) >= 0; ) {
ADDRLP4 196
CNSTI4 -1
ASGNI4
ADDRGP4 $592
JUMPV
LABELV $589
line 1016
;1013:			int refugeeTravelTime;
;1014:			int pursuerTravelTime;
;1015:
;1016:			if (potentialGoal.areanum <= 0) continue;
ADDRLP4 0+12
INDIRI4
CNSTI4 0
GTI4 $593
ADDRGP4 $590
JUMPV
LABELV $593
line 1017
;1017:			if (potentialGoal.flags & GFL_DROPPED) continue;
ADDRLP4 0+48
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $596
ADDRGP4 $590
JUMPV
LABELV $596
line 1018
;1018:			if (!trap_AAS_AreaReachability(potentialGoal.areanum)) continue;
ADDRLP4 0+12
INDIRI4
ARGI4
ADDRLP4 212
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 212
INDIRI4
CNSTI4 0
NEI4 $599
ADDRGP4 $590
JUMPV
LABELV $599
line 1020
;1019:
;1020:			refugeeTravelTime = trap_AAS_AreaTravelTimeToGoalArea(refugeeArea, refugeePS->origin, potentialGoal.areanum, refugeeTFL);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 0+12
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 216
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 204
ADDRLP4 216
INDIRI4
ASGNI4
line 1021
;1021:			if (refugeeTravelTime <= 0) continue;
ADDRLP4 204
INDIRI4
CNSTI4 0
GTI4 $603
ADDRGP4 $590
JUMPV
LABELV $603
line 1022
;1022:			if (potentialGoal.areanum == refugeeHome) {
ADDRLP4 0+12
INDIRI4
ADDRLP4 64
INDIRI4
NEI4 $605
line 1025
;1023:				int bonus;
;1024:
;1025:				if (!refugeePS->powerups[PW_REDFLAG] && !refugeePS->powerups[PW_BLUEFLAG]) goto EnsureMinDistance;
ADDRLP4 224
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 224
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
NEI4 $608
ADDRLP4 224
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
NEI4 $608
ADDRGP4 $610
JUMPV
LABELV $608
line 1026
;1026:				bonus = 200;
ADDRLP4 220
CNSTI4 200
ASGNI4
line 1027
;1027:				if (refugeeTravelTime > 500) bonus += 1000;
ADDRLP4 204
INDIRI4
CNSTI4 500
LEI4 $611
ADDRLP4 220
ADDRLP4 220
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
LABELV $611
line 1029
;1028:				if (
;1029:					Team_GetFlagStatus(refugeePS->persistant[PERS_TEAM]) == FLAG_ATBASE ||
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
ARGI4
ADDRLP4 228
ADDRGP4 Team_GetFlagStatus
CALLI4
ASGNI4
ADDRLP4 228
INDIRI4
CNSTI4 0
EQI4 $615
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 232
ADDRGP4 IsPlayerInvolvedInFighting
CALLI4
ASGNI4
ADDRLP4 232
INDIRI4
CNSTI4 0
NEI4 $613
LABELV $615
line 1031
;1030:					!IsPlayerInvolvedInFighting(refugeePS->clientNum)
;1031:				) {
line 1032
;1032:					bonus += 3000;
ADDRLP4 220
ADDRLP4 220
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 1033
;1033:				}
ADDRGP4 $614
JUMPV
LABELV $613
line 1034
;1034:				else if (refugeeTravelTime < 300) {
ADDRLP4 204
INDIRI4
CNSTI4 300
GEI4 $616
line 1035
;1035:					bonus -= 500;
ADDRLP4 220
ADDRLP4 220
INDIRI4
CNSTI4 500
SUBI4
ASGNI4
line 1036
;1036:				}
LABELV $616
LABELV $614
line 1037
;1037:				refugeeTravelTime -= bonus;
ADDRLP4 204
ADDRLP4 204
INDIRI4
ADDRLP4 220
INDIRI4
SUBI4
ASGNI4
line 1038
;1038:			}
ADDRGP4 $606
JUMPV
LABELV $605
line 1039
;1039:			else {
LABELV $610
line 1041
;1040:				EnsureMinDistance:
;1041:				if (refugeeTravelTime < 300) continue;	// 300 = 3 seconds
ADDRLP4 204
INDIRI4
CNSTI4 300
GEI4 $618
ADDRGP4 $590
JUMPV
LABELV $618
line 1042
;1042:			}
LABELV $606
line 1044
;1043:
;1044:			if (refugeeTravelTime < nearestGoalTravelTime) {
ADDRLP4 204
INDIRI4
ADDRLP4 56
INDIRI4
GEI4 $620
line 1045
;1045:				nearestGoalTravelTime = refugeeTravelTime;
ADDRLP4 56
ADDRLP4 204
INDIRI4
ASGNI4
line 1046
;1046:				foundNearestGoal = qtrue;
ADDRLP4 180
CNSTI4 1
ASGNI4
line 1047
;1047:				memcpy(&nearestGoal, &potentialGoal, sizeof(nearestGoal));
ADDRLP4 68
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1048
;1048:			}
LABELV $620
line 1049
;1049:			pursuerTravelTime = trap_AAS_AreaTravelTimeToGoalArea(pursuerArea, pursuerOrigin, potentialGoal.areanum, TFL_DEFAULT);
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 0+12
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 220
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 208
ADDRLP4 220
INDIRI4
ASGNI4
line 1050
;1050:			if (pursuerTravelTime <= 0) pursuerTravelTime = 1000000;
ADDRLP4 208
INDIRI4
CNSTI4 0
GTI4 $623
ADDRLP4 208
CNSTI4 1000000
ASGNI4
LABELV $623
line 1051
;1051:			pursuerTravelTime -= refugeeTravelTime;
ADDRLP4 208
ADDRLP4 208
INDIRI4
ADDRLP4 204
INDIRI4
SUBI4
ASGNI4
line 1052
;1052:			if (pursuerTravelTime > bestGoalTravelTime) {
ADDRLP4 208
INDIRI4
ADDRLP4 60
INDIRI4
LEI4 $625
line 1053
;1053:				bestGoalTravelTime = pursuerTravelTime;
ADDRLP4 60
ADDRLP4 208
INDIRI4
ASGNI4
line 1054
;1054:				foundBestGoal = qtrue;
ADDRLP4 184
CNSTI4 1
ASGNI4
line 1055
;1055:				memcpy(&bestGoal, &potentialGoal, sizeof(bestGoal));
ADDRLP4 124
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1056
;1056:			}
LABELV $625
line 1057
;1057:		}
LABELV $590
line 1012
LABELV $592
ADDRLP4 196
INDIRI4
ARGI4
ADDRLP4 200
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 204
ADDRGP4 GetItemGoal
CALLI4
ASGNI4
ADDRLP4 196
ADDRLP4 204
INDIRI4
ASGNI4
ADDRLP4 204
INDIRI4
CNSTI4 0
GEI4 $589
line 1058
;1058:	}
LABELV $586
line 1007
ADDRLP4 188
ADDRLP4 188
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $588
ADDRLP4 188
INDIRI4
ADDRLP4 192
INDIRI4
LTI4 $585
line 1060
;1059:	
;1060:	if (foundBestGoal) {
ADDRLP4 184
INDIRI4
CNSTI4 0
EQI4 $627
line 1061
;1061:		memcpy(goal, &bestGoal, sizeof(*goal));
ADDRFP4 20
INDIRP4
ARGP4
ADDRLP4 124
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1062
;1062:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $564
JUMPV
LABELV $627
line 1064
;1063:	}
;1064:	if (foundNearestGoal) {
ADDRLP4 180
INDIRI4
CNSTI4 0
EQI4 $629
line 1065
;1065:		memcpy(goal, &nearestGoal, sizeof(*goal));
ADDRFP4 20
INDIRP4
ARGP4
ADDRLP4 68
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1066
;1066:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $564
JUMPV
LABELV $629
line 1068
;1067:	}
;1068:	return qfalse;
CNSTI4 0
RETI4
LABELV $564
endproc FindEscapeGoal 236 16
export BotSetEscapeGoal
proc BotSetEscapeGoal 24 24
line 1076
;1069:}
;1070:
;1071:/*
;1072:==================
;1073:JUHOX: BotSetEscapeGoal
;1074:==================
;1075:*/
;1076:void BotSetEscapeGoal(bot_state_t* bs) {
line 1077
;1077:	if (bs->enemy < 0) return;
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 0
GEI4 $632
ADDRGP4 $631
JUMPV
LABELV $632
line 1079
;1078:
;1079:	if (bs->ltgtype == 0) {
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 0
NEI4 $634
line 1081
;1080:		if (
;1081:			FindEscapeGoal(
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 5984
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 7768
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 7772
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 11580
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 FindEscapeGoal
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $636
line 1084
;1082:				&bs->cur_ps, bs->areanum, bs->tfl, bs->lastenemyareanum, bs->lastenemyorigin, &bs->teamgoal
;1083:			)
;1084:		) {
line 1087
;1085:			int danger;
;1086:
;1087:			bs->ltgtype = LTG_ESCAPE;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 16
ASGNI4
line 1088
;1088:			danger = BotPlayerDanger(&bs->cur_ps);
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 BotPlayerDanger
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 1089
;1089:			if (bs->cur_ps.powerups[PW_REDFLAG] || bs->cur_ps.powerups[PW_BLUEFLAG]) {
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 356
ADDP4
INDIRI4
CNSTI4 0
NEI4 $640
ADDRLP4 16
INDIRP4
CNSTI4 360
ADDP4
INDIRI4
CNSTI4 0
EQI4 $638
LABELV $640
line 1090
;1090:				bs->teamgoal_time = FloatTime() + 1 + random();
ADDRLP4 20
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRFP4 0
INDIRP4
CNSTI4 11700
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
ADDF4
ADDRLP4 20
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 20
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
ADDF4
ASGNF4
line 1091
;1091:			}
ADDRGP4 $639
JUMPV
LABELV $638
line 1092
;1092:			else {
line 1093
;1093:				bs->teamgoal_time = FloatTime() + 3;
ADDRFP4 0
INDIRP4
CNSTI4 11700
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1077936128
ADDF4
ASGNF4
line 1094
;1094:				if (danger > 0) bs->teamgoal_time += danger / 10.0;
ADDRLP4 8
INDIRI4
CNSTI4 0
LEI4 $641
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 11700
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRF4
ADDRLP4 8
INDIRI4
CVIF4 4
CNSTF4 1036831949
MULF4
ADDF4
ASGNF4
LABELV $641
line 1096
;1095:
;1096:				if (danger >= 50 && g_gametype.integer >= GT_TEAM) {
ADDRLP4 8
INDIRI4
CNSTI4 50
LTI4 $643
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $643
line 1097
;1097:					trap_EA_SayTeam(bs->client, "HEEEEEEEELP MEEEEEEEE!");
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 $646
ARGP4
ADDRGP4 trap_EA_SayTeam
CALLV
pop
line 1098
;1098:				}
LABELV $643
line 1099
;1099:			}
LABELV $639
line 1100
;1100:		}
LABELV $636
line 1101
;1101:	}
LABELV $634
line 1102
;1102:}
LABELV $631
endproc BotSetEscapeGoal 24 24
export BotReachedGoal
proc BotReachedGoal 36 16
line 1109
;1103:
;1104:/*
;1105:==================
;1106:BotReachedGoal
;1107:==================
;1108:*/
;1109:int BotReachedGoal(bot_state_t *bs, bot_goal_t *goal) {
line 1110
;1110:	if (goal->flags & GFL_ITEM) {
ADDRFP4 4
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $648
line 1112
;1111:#if 1	// JUHOX: if the item is a dropped item it may no longer exist
;1112:		if (goal->flags & GFL_DROPPED) {
ADDRFP4 4
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $650
line 1113
;1113:			if (!g_entities[goal->entitynum].inuse) return qtrue;
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $652
CNSTI4 1
RETI4
ADDRGP4 $647
JUMPV
LABELV $652
line 1114
;1114:			if (Distance(goal->origin, g_entities[goal->entitynum].r.currentOrigin) > 50) return qtrue;
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+208+280
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRLP4 4
INDIRF4
CNSTF4 1112014848
LEF4 $655
CNSTI4 1
RETI4
ADDRGP4 $647
JUMPV
LABELV $655
line 1115
;1115:		}
LABELV $650
line 1118
;1116:#endif
;1117:#if 1	// JUHOX: POD markers are never reached as long as they exist
;1118:		if (g_entities[goal->entitynum].item->giType == IT_POD_MARKER) return qfalse;
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+808
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 9
NEI4 $659
CNSTI4 0
RETI4
ADDRGP4 $647
JUMPV
LABELV $659
line 1121
;1119:#endif
;1120:		//if touching the goal
;1121:		if (trap_BotTouchingGoal(bs->origin, goal)) {
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 trap_BotTouchingGoal
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $662
line 1122
;1122:			if (!(goal->flags & GFL_DROPPED)) {
ADDRFP4 4
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
NEI4 $664
line 1123
;1123:				trap_BotSetAvoidGoalTime(bs->gs, goal->number, -1);
ADDRFP4 0
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
CNSTF4 3212836864
ARGF4
ADDRGP4 trap_BotSetAvoidGoalTime
CALLV
pop
line 1124
;1124:			}
LABELV $664
line 1125
;1125:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $647
JUMPV
LABELV $662
line 1128
;1126:		}
;1127:		//if the goal isn't there
;1128:		if (trap_BotItemGoalInVisButNotVisible(bs->entitynum, bs->eye, bs->viewangles, goal)) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 4944
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 7840
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 trap_BotItemGoalInVisButNotVisible
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $666
line 1140
;1129:			/*
;1130:			float avoidtime;
;1131:			int t;
;1132:
;1133:			avoidtime = trap_BotAvoidGoalTime(bs->gs, goal->number);
;1134:			if (avoidtime > 0) {
;1135:				t = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, goal->areanum, bs->tfl);
;1136:				if ((float) t * 0.009 < avoidtime)
;1137:					return qtrue;
;1138:			}
;1139:			*/
;1140:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $647
JUMPV
LABELV $666
line 1143
;1141:		}
;1142:		//if in the goal area and below or above the goal and not swimming
;1143:		if (bs->areanum == goal->areanum) {
ADDRFP4 0
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
NEI4 $649
line 1144
;1144:			if (bs->origin[0] > goal->origin[0] + goal->mins[0] && bs->origin[0] < goal->origin[0] + goal->maxs[0]) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 20
ADDRLP4 16
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDF4
LEF4 $649
ADDRLP4 12
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDF4
GEF4 $649
line 1145
;1145:				if (bs->origin[1] > goal->origin[1] + goal->mins[1] && bs->origin[1] < goal->origin[1] + goal->maxs[1]) {
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 4920
ADDP4
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDF4
LEF4 $649
ADDRLP4 24
INDIRP4
CNSTI4 4920
ADDP4
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDF4
GEF4 $649
line 1146
;1146:					if (!trap_AAS_Swimming(bs->origin)) {
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 32
ADDRGP4 trap_AAS_Swimming
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $649
line 1147
;1147:						return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $647
JUMPV
line 1149
;1148:					}
;1149:				}
line 1150
;1150:			}
line 1151
;1151:		}
line 1152
;1152:	}
LABELV $648
line 1153
;1153:	else if (goal->flags & GFL_AIR) {
ADDRFP4 4
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $676
line 1155
;1154:		//if touching the goal
;1155:		if (trap_BotTouchingGoal(bs->origin, goal)) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 trap_BotTouchingGoal
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $678
CNSTI4 1
RETI4
ADDRGP4 $647
JUMPV
LABELV $678
line 1157
;1156:		//if the bot got air
;1157:		if (bs->lastair_time > FloatTime() - 1) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 7268
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
SUBF4
LEF4 $677
CNSTI4 1
RETI4
ADDRGP4 $647
JUMPV
line 1158
;1158:	}
LABELV $676
line 1159
;1159:	else {
line 1161
;1160:		//if touching the goal
;1161:		if (trap_BotTouchingGoal(bs->origin, goal)) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 trap_BotTouchingGoal
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $682
CNSTI4 1
RETI4
ADDRGP4 $647
JUMPV
LABELV $682
line 1162
;1162:	}
LABELV $677
LABELV $649
line 1163
;1163:	return qfalse;
CNSTI4 0
RETI4
LABELV $647
endproc BotReachedGoal 36 16
export BotCheckIfBlockingTeammates
proc BotCheckIfBlockingTeammates 592 16
line 1171
;1164:}
;1165:
;1166:/*
;1167:==================
;1168:JUHOX: BotCheckIfBlockingTeammates
;1169:==================
;1170:*/
;1171:void BotCheckIfBlockingTeammates(bot_state_t* bs) {
line 1179
;1172:	float vis, dist;
;1173:	int i;
;1174:	vec3_t dir;
;1175:	playerState_t ps;
;1176:	float speed;
;1177:	vec3_t target;
;1178:
;1179:	if (g_gametype.integer >= GT_TEAM) for (i = 0; i < MAX_CLIENTS; i++) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $685
ADDRLP4 480
CNSTI4 0
ASGNI4
LABELV $688
line 1181
;1180:
;1181:		if (i == bs->client) continue;
ADDRLP4 480
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $692
ADDRGP4 $689
JUMPV
LABELV $692
line 1182
;1182:		if (!BotAI_GetClientState(i, &ps)) continue;
ADDRLP4 480
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 508
ADDRGP4 BotAI_GetClientState
CALLI4
ASGNI4
ADDRLP4 508
INDIRI4
CNSTI4 0
NEI4 $694
ADDRGP4 $689
JUMPV
LABELV $694
line 1183
;1183:		if (ps.stats[STAT_HEALTH] <= 0) continue;
ADDRLP4 0+184
INDIRI4
CNSTI4 0
GTI4 $696
ADDRGP4 $689
JUMPV
LABELV $696
line 1184
;1184:		if (bs->cur_ps.persistant[PERS_TEAM] != ps.persistant[PERS_TEAM]) continue;
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ADDRLP4 0+248+12
INDIRI4
EQI4 $699
ADDRGP4 $689
JUMPV
LABELV $699
line 1185
;1185:		if (ps.pm_type == PM_SPECTATOR) continue;
ADDRLP4 0+4
INDIRI4
CNSTI4 2
NEI4 $703
ADDRGP4 $689
JUMPV
LABELV $703
line 1187
;1186:		//calculate distance and direction towards the team mate
;1187:		VectorSubtract(bs->origin, ps.origin, dir);
ADDRLP4 512
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 468
ADDRLP4 512
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRLP4 0+20
INDIRF4
SUBF4
ASGNF4
ADDRLP4 468+4
ADDRLP4 512
INDIRP4
CNSTI4 4920
ADDP4
INDIRF4
ADDRLP4 0+20+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 468+8
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRF4
ADDRLP4 0+20+8
INDIRF4
SUBF4
ASGNF4
line 1188
;1188:		dist = VectorLength(dir);
ADDRLP4 468
ARGP4
ADDRLP4 516
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 484
ADDRLP4 516
INDIRF4
ASGNF4
line 1189
;1189:		if (dist >= 250) continue;
ADDRLP4 484
INDIRF4
CNSTF4 1132068864
LTF4 $713
ADDRGP4 $689
JUMPV
LABELV $713
line 1190
;1190:		if (ps.weaponstate < WEAPON_FIRING && dist >= 60) continue;
ADDRLP4 0+148
INDIRI4
CNSTI4 3
GEI4 $715
ADDRLP4 484
INDIRF4
CNSTF4 1114636288
LTF4 $715
ADDRGP4 $689
JUMPV
LABELV $715
line 1192
;1191:		//check if the team mate is visible
;1192:		vis = BotEntityVisible(&bs->cur_ps, 360, i);
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 480
INDIRI4
ARGI4
ADDRLP4 520
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 492
ADDRLP4 520
INDIRF4
ASGNF4
line 1193
;1193:		if (vis <= 0) continue;
ADDRLP4 492
INDIRF4
CNSTF4 0
GTF4 $718
ADDRGP4 $689
JUMPV
LABELV $718
line 1198
;1194:
;1195:		// seems we should go out of the way of this team mate
;1196:		//
;1197:		//initialize the movement state
;1198:		BotSetupForMovement(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetupForMovement
CALLV
pop
line 1200
;1199:		// try to step away a bit
;1200:		if (VectorLengthSquared(ps.velocity) > 100) {
ADDRLP4 0+32
ARGP4
ADDRLP4 524
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 524
INDIRF4
CNSTF4 1120403456
LEF4 $720
line 1205
;1201:			vec3_t vel;
;1202:			vec3_t ndir;
;1203:			vec3_t c;
;1204:
;1205:			VectorNormalize2(ps.velocity, vel);
ADDRLP4 0+32
ARGP4
ADDRLP4 528
ARGP4
ADDRGP4 VectorNormalize2
CALLF4
pop
line 1206
;1206:			VectorNormalize2(dir, ndir);
ADDRLP4 468
ARGP4
ADDRLP4 552
ARGP4
ADDRGP4 VectorNormalize2
CALLF4
pop
line 1207
;1207:			CrossProduct(vel, ndir, c);
ADDRLP4 528
ARGP4
ADDRLP4 552
ARGP4
ADDRLP4 540
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 1208
;1208:			if (VectorLengthSquared(c) > 0.01) {
ADDRLP4 540
ARGP4
ADDRLP4 564
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 564
INDIRF4
CNSTF4 1008981770
LEF4 $724
line 1209
;1209:				CrossProduct(c, vel, dir);
ADDRLP4 540
ARGP4
ADDRLP4 528
ARGP4
ADDRLP4 468
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 1210
;1210:			}
LABELV $724
line 1211
;1211:		}
LABELV $720
line 1212
;1212:		speed = bs->forceWalk? 200 : 400;
ADDRFP4 0
INDIRP4
CNSTI4 7740
ADDP4
INDIRI4
CNSTI4 0
EQI4 $727
ADDRLP4 528
CNSTI4 200
ASGNI4
ADDRGP4 $728
JUMPV
LABELV $727
ADDRLP4 528
CNSTI4 400
ASGNI4
LABELV $728
ADDRLP4 488
ADDRLP4 528
INDIRI4
CVIF4 4
ASGNF4
line 1213
;1213:		if (!trap_BotMoveInDirection(bs->ms, dir, speed, MOVE_WALK)) {
ADDRFP4 0
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRLP4 468
ARGP4
ADDRLP4 488
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRLP4 532
ADDRGP4 trap_BotMoveInDirection
CALLI4
ASGNI4
ADDRLP4 532
INDIRI4
CNSTI4 0
NEI4 $729
line 1216
;1214:			vec3_t up, sideward;
;1215:
;1216:			PerpendicularVector(up, dir);
ADDRLP4 548
ARGP4
ADDRLP4 468
ARGP4
ADDRGP4 PerpendicularVector
CALLV
pop
line 1217
;1217:			CrossProduct(up, dir, sideward);
ADDRLP4 548
ARGP4
ADDRLP4 468
ARGP4
ADDRLP4 536
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 1221
;1218:
;1219:			// the following is taken from the improved BotAIBlocked() function
;1220:
;1221:			if (bs->flags & BFL_AVOIDRIGHT) VectorNegate(sideward, sideward);
ADDRFP4 0
INDIRP4
CNSTI4 5992
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $731
ADDRLP4 536
ADDRLP4 536
INDIRF4
NEGF4
ASGNF4
ADDRLP4 536+4
ADDRLP4 536+4
INDIRF4
NEGF4
ASGNF4
ADDRLP4 536+8
ADDRLP4 536+8
INDIRF4
NEGF4
ASGNF4
LABELV $731
line 1223
;1222:
;1223:			if (!trap_BotMoveInDirection(bs->ms, sideward, speed, MOVE_WALK)) {
ADDRFP4 0
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRLP4 536
ARGP4
ADDRLP4 488
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRLP4 560
ADDRGP4 trap_BotMoveInDirection
CALLI4
ASGNI4
ADDRLP4 560
INDIRI4
CNSTI4 0
NEI4 $737
line 1224
;1224:				bs->flags ^= BFL_AVOIDRIGHT;
ADDRLP4 564
ADDRFP4 0
INDIRP4
CNSTI4 5992
ADDP4
ASGNP4
ADDRLP4 564
INDIRP4
ADDRLP4 564
INDIRP4
INDIRI4
CNSTI4 16
BXORI4
ASGNI4
line 1225
;1225:				VectorNegate(sideward, sideward);
ADDRLP4 536
ADDRLP4 536
INDIRF4
NEGF4
ASGNF4
ADDRLP4 536+4
ADDRLP4 536+4
INDIRF4
NEGF4
ASGNF4
ADDRLP4 536+8
ADDRLP4 536+8
INDIRF4
NEGF4
ASGNF4
line 1226
;1226:				if (!trap_BotMoveInDirection(bs->ms, sideward, speed, MOVE_WALK)) {
ADDRFP4 0
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRLP4 536
ARGP4
ADDRLP4 488
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRLP4 568
ADDRGP4 trap_BotMoveInDirection
CALLI4
ASGNI4
ADDRLP4 568
INDIRI4
CNSTI4 0
NEI4 $743
line 1227
;1227:					if (VectorLengthSquared(bs->notblocked_dir) < 0.1) {
ADDRFP4 0
INDIRP4
CNSTI4 7328
ADDP4
ARGP4
ADDRLP4 572
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 572
INDIRF4
CNSTF4 1036831949
GEF4 $745
line 1230
;1228:						vec3_t angles;
;1229:
;1230:						VectorSet(angles, 0, 360 * random(), 0);
ADDRLP4 576
CNSTF4 0
ASGNF4
ADDRLP4 588
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 576+4
ADDRLP4 588
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 588
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1135869952
MULF4
ASGNF4
ADDRLP4 576+8
CNSTF4 0
ASGNF4
line 1231
;1231:						AngleVectors(angles, dir, NULL, NULL);
ADDRLP4 576
ARGP4
ADDRLP4 468
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 1232
;1232:					}
ADDRGP4 $746
JUMPV
LABELV $745
line 1233
;1233:					else {
line 1234
;1234:						VectorCopy(bs->notblocked_dir, dir);
ADDRLP4 468
ADDRFP4 0
INDIRP4
CNSTI4 7328
ADDP4
INDIRB
ASGNB 12
line 1235
;1235:					}
LABELV $746
line 1236
;1236:					if (trap_BotMoveInDirection(bs->ms, dir, speed, MOVE_WALK)) {
ADDRFP4 0
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRLP4 468
ARGP4
ADDRLP4 488
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRLP4 576
ADDRGP4 trap_BotMoveInDirection
CALLI4
ASGNI4
ADDRLP4 576
INDIRI4
CNSTI4 0
EQI4 $749
line 1237
;1237:						VectorCopy(dir, bs->notblocked_dir);
ADDRFP4 0
INDIRP4
CNSTI4 7328
ADDP4
ADDRLP4 468
INDIRB
ASGNB 12
line 1238
;1238:					}
ADDRGP4 $750
JUMPV
LABELV $749
line 1239
;1239:					else {
line 1240
;1240:						VectorSet(bs->notblocked_dir, 0, 0, 0);
ADDRFP4 0
INDIRP4
CNSTI4 7328
ADDP4
CNSTF4 0
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 7332
ADDP4
CNSTF4 0
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 7336
ADDP4
CNSTF4 0
ASGNF4
line 1241
;1241:					}
LABELV $750
line 1242
;1242:				}
LABELV $743
line 1243
;1243:			}
LABELV $737
line 1244
;1244:		}
LABELV $729
line 1245
;1245:		bs->preventJump = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 7748
ADDP4
CNSTI4 1
ASGNI4
line 1246
;1246:		break;	// don't bother about other team mates for now
ADDRGP4 $690
JUMPV
LABELV $689
line 1179
ADDRLP4 480
ADDRLP4 480
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 480
INDIRI4
CNSTI4 64
LTI4 $688
LABELV $690
LABELV $685
line 1250
;1247:	}
;1248:
;1249:	// look around
;1250:	if (BotRoamGoal(bs, target, qfalse)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 496
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 508
ADDRGP4 BotRoamGoal
CALLI4
ASGNI4
ADDRLP4 508
INDIRI4
CNSTI4 0
EQI4 $751
line 1251
;1251:		VectorSubtract(target, bs->origin, dir);
ADDRLP4 512
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 468
ADDRLP4 496
INDIRF4
ADDRLP4 512
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 468+4
ADDRLP4 496+4
INDIRF4
ADDRLP4 512
INDIRP4
CNSTI4 4920
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 468+8
ADDRLP4 496+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1252
;1252:		vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 468
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 7852
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 1253
;1253:		bs->ideal_viewangles[2] *= 0.5;
ADDRLP4 516
ADDRFP4 0
INDIRP4
CNSTI4 7860
ADDP4
ASGNP4
ADDRLP4 516
INDIRP4
ADDRLP4 516
INDIRP4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 1254
;1254:	}
LABELV $751
line 1255
;1255:}
LABELV $684
endproc BotCheckIfBlockingTeammates 592 16
export BotGetItemLongTermGoal
proc BotGetItemLongTermGoal 8 8
line 1262
;1256:
;1257:/*
;1258:==================
;1259:BotGetItemLongTermGoal
;1260:==================
;1261:*/
;1262:int BotGetItemLongTermGoal(bot_state_t *bs, int tfl, bot_goal_t *goal) {
line 1264
;1263:	//if the bot has no goal
;1264:	if (!trap_BotGetTopGoal(bs->gs, goal)) {
ADDRFP4 0
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 trap_BotGetTopGoal
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $758
line 1266
;1265:		//BotAI_Print(PRT_MESSAGE, "no ltg on stack\n");
;1266:		bs->ltg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6088
ADDP4
CNSTF4 0
ASGNF4
line 1267
;1267:	}
ADDRGP4 $759
JUMPV
LABELV $758
line 1269
;1268:	//if the bot touches the current goal
;1269:	else if (BotReachedGoal(bs, goal)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 BotReachedGoal
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $760
line 1270
;1270:		BotChooseWeapon(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotChooseWeapon
CALLV
pop
line 1271
;1271:		bs->ltg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6088
ADDP4
CNSTF4 0
ASGNF4
line 1272
;1272:	}
LABELV $760
LABELV $759
line 1274
;1273:	//if it is time to find a new long term goal
;1274:	if (bs->ltg_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6088
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $762
line 1276
;1275:		//pop the current goal from the stack
;1276:		trap_BotPopGoal(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotPopGoal
CALLV
pop
line 1328
;1277:#if 0	// JUHOX: nothing useful to do? just wait.
;1278:		//BotAI_Print(PRT_MESSAGE, "%s: choosing new ltg\n", ClientName(bs->client, netname, sizeof(netname)));
;1279:		//choose a new goal
;1280:		//BotAI_Print(PRT_MESSAGE, "%6.1f client %d: BotChooseLTGItem\n", FloatTime(), bs->client);
;1281:		if (trap_BotChooseLTGItem(bs->gs, bs->origin, bs->inventory, tfl)) {
;1282:			/*
;1283:			char buf[128];
;1284:			//get the goal at the top of the stack
;1285:			trap_BotGetTopGoal(bs->gs, goal);
;1286:			trap_BotGoalName(goal->number, buf, sizeof(buf));
;1287:			BotAI_Print(PRT_MESSAGE, "%1.1f: new long term goal %s\n", FloatTime(), buf);
;1288:			*/
;1289:			bs->ltg_time = FloatTime() + 20;
;1290:		}
;1291:		else {//the bot gets sorta stuck with all the avoid timings, shouldn't happen though
;1292:			//
;1293:#ifdef DEBUG
;1294:			char netname[128];
;1295:
;1296:			BotAI_Print(PRT_MESSAGE, "%s: no valid ltg (probably stuck)\n", ClientName(bs->client, netname, sizeof(netname)));
;1297:#endif
;1298:			//trap_BotDumpAvoidGoals(bs->gs);
;1299:			//reset the avoid goals and the avoid reach
;1300:			trap_BotResetAvoidGoals(bs->gs);
;1301:			trap_BotResetAvoidReach(bs->ms);
;1302:		}
;1303:		//get the goal at the top of the stack
;1304:		return trap_BotGetTopGoal(bs->gs, goal);
;1305:#else
;1306:		/*
;1307:		if (BotPlayerDanger(&bs->cur_ps) > 50) {
;1308:			if ((bs->tfl & (TFL_LAVA|TFL_SLIME)) && BotNearbyGoal(bs, bs->tfl, goal, -1)) {
;1309:				bs->ltg_time = FloatTime() + 10;
;1310:				return qtrue;
;1311:			}
;1312:			if (BotNearbyGoal(bs, bs->tfl, goal, 10000)) {
;1313:				bs->ltg_time = FloatTime() + 10;
;1314:				return qtrue;
;1315:			}
;1316:			if (BotNearbyGoal(bs, bs->tfl, goal, -1)) {
;1317:				bs->ltg_time = FloatTime() + 10;
;1318:				return qtrue;
;1319:			}
;1320:			if (trap_BotChooseLTGItem(bs->gs, bs->origin, bs->inventory, tfl)) {
;1321:				if (trap_BotGetTopGoal(bs->gs, goal)) {
;1322:					bs->ltg_time = FloatTime() + 10;
;1323:					return qtrue;
;1324:				}
;1325:			}
;1326:		}
;1327:		*/
;1328:		BotCheckIfBlockingTeammates(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCheckIfBlockingTeammates
CALLV
pop
line 1329
;1329:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $757
JUMPV
LABELV $762
line 1332
;1330:#endif
;1331:	}
;1332:	return qtrue;
CNSTI4 1
RETI4
LABELV $757
endproc BotGetItemLongTermGoal 8 8
export BotGetLongTermGoal
proc BotGetLongTermGoal 1120 16
line 1343
;1333:}
;1334:
;1335:/*
;1336:==================
;1337:BotGetLongTermGoal
;1338:
;1339:we could also create a seperate AI node for every long term goal type
;1340:however this saves us a lot of code
;1341:==================
;1342:*/
;1343:int BotGetLongTermGoal(bot_state_t *bs, int tfl, int retreat, bot_goal_t *goal) {
line 1353
;1344:	vec3_t target, dir, dir2;
;1345:	char netname[MAX_NETNAME];
;1346:	char buf[MAX_MESSAGE_SIZE];
;1347:	int areanum;
;1348:	float croucher;
;1349:	aas_entityinfo_t entinfo, botinfo;
;1350:	bot_waypoint_t *wp;
;1351:
;1352:	// JUHOX: LTG_TEAMHELP is now used to let a bot go to a team mate
;1353:	if (bs->ltgtype == LTG_TEAMHELP /*&& !retreat*/) {	// JUHOX: ignore retreat-flag if helping a teammate
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 1
NEI4 $765
line 1355
;1354:		//check for bot typing status message
;1355:		if (bs->teammessage_time && bs->teammessage_time < FloatTime()) {
ADDRLP4 620
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 620
INDIRP4
CNSTI4 11696
ADDP4
INDIRF4
CNSTF4 0
EQF4 $767
ADDRLP4 620
INDIRP4
CNSTI4 11696
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $767
line 1356
;1356:			BotAI_BotInitialChat(bs, "help_start", EasyClientName(bs->teammate, netname, sizeof(netname)), NULL);
ADDRFP4 0
INDIRP4
CNSTI4 11560
ADDP4
INDIRI4
ARGI4
ADDRLP4 416
ARGP4
CNSTI4 36
ARGI4
ADDRLP4 624
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $769
ARGP4
ADDRLP4 624
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1363
;1357:			// JUHOX: 'decisionmaker' not used. talk to 'teammate'
;1358:#if 0
;1359:			trap_BotEnterChat(bs->cs, bs->decisionmaker, CHAT_TELL);
;1360:			BotVoiceChatOnly(bs, bs->decisionmaker, VOICECHAT_YES);
;1361:			trap_EA_Action(bs->client, ACTION_AFFIRMATIVE);
;1362:#else
;1363:			trap_BotEnterChat(bs->cs, bs->teammate, CHAT_TELL);
ADDRLP4 628
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 628
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRLP4 628
INDIRP4
CNSTI4 11560
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1365
;1364:#endif
;1365:			bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11696
ADDP4
CNSTF4 0
ASGNF4
line 1366
;1366:		}
LABELV $767
line 1368
;1367:		//if trying to help the team mate for more than a minute
;1368:		if (bs->teamgoal_time < FloatTime())
ADDRFP4 0
INDIRP4
CNSTI4 11700
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $770
line 1369
;1369:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
LABELV $770
line 1404
;1370:#if 0	// JUHOX: continue to help even after seeing the teammate
;1371:		//if the team mate IS visible for quite some time
;1372:		if (bs->teammatevisible_time < FloatTime() - 10) bs->ltgtype = 0;
;1373:#endif
;1374:#if 0	// JUHOX: new code for searching team mate
;1375:		//get entity information of the companion
;1376:		BotEntityInfo(bs->teammate, &entinfo);
;1377:		//if the team mate is visible
;1378:		if (BotEntityVisible(&bs->cur_ps/*bs->entitynum, bs->eye, bs->viewangles*/, 360, bs->teammate)) {	// JUHOX
;1379:			//if close just stand still there
;1380:			VectorSubtract(entinfo.origin, bs->origin, dir);
;1381:			if (VectorLengthSquared(dir) < Square(/*100*/entinfo.flags&EF_FIRING? 300 : 150)) {	// JUHOX
;1382:				trap_BotResetAvoidReach(bs->ms);
;1383:				BotCheckIfBlockingTeammates(bs);	// JUHOX
;1384:				return qfalse;
;1385:			}
;1386:		}
;1387:		else {
;1388:			//last time the bot was NOT visible
;1389:			bs->teammatevisible_time = FloatTime();
;1390:		}
;1391:		//if the entity information is valid (entity in PVS)
;1392:		if (entinfo.valid) {
;1393:			areanum = BotPointAreaNum(entinfo.origin);
;1394:			if (areanum && trap_AAS_AreaReachability(areanum)) {
;1395:				//update team goal
;1396:				bs->teamgoal.entitynum = bs->teammate;
;1397:				bs->teamgoal.areanum = areanum;
;1398:				VectorCopy(entinfo.origin, bs->teamgoal.origin);
;1399:				VectorSet(bs->teamgoal.mins, -8, -8, -8);
;1400:				VectorSet(bs->teamgoal.maxs, 8, 8, 8);
;1401:			}
;1402:		}
;1403:#else
;1404:		{
line 1408
;1405:			playerState_t ps;
;1406:			float maxDistSqr;
;1407:
;1408:			if (!BotAI_GetClientState(bs->teammate, &ps)) {
ADDRFP4 0
INDIRP4
CNSTI4 11560
ADDP4
INDIRI4
ARGI4
ADDRLP4 624
ARGP4
ADDRLP4 1096
ADDRGP4 BotAI_GetClientState
CALLI4
ASGNI4
ADDRLP4 1096
INDIRI4
CNSTI4 0
NEI4 $772
LABELV $774
line 1410
;1409:			StopHelping:
;1410:				bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
line 1411
;1411:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $764
JUMPV
LABELV $772
line 1413
;1412:			}
;1413:			if (ps.stats[STAT_HEALTH] <= 0) goto StopHelping;
ADDRLP4 624+184
INDIRI4
CNSTI4 0
GTI4 $775
ADDRGP4 $774
JUMPV
LABELV $775
line 1414
;1414:			if (ps.weaponstate >= WEAPON_FIRING) {
ADDRLP4 624+148
INDIRI4
CNSTI4 3
LTI4 $778
line 1415
;1415:				maxDistSqr = Square(300);
ADDRLP4 1092
CNSTF4 1202702336
ASGNF4
line 1416
;1416:			}
ADDRGP4 $779
JUMPV
LABELV $778
line 1417
;1417:			else {
line 1418
;1418:				maxDistSqr = Square(150);
ADDRLP4 1092
CNSTF4 1185925120
ASGNF4
line 1419
;1419:			}
LABELV $779
line 1420
;1420:			if (DistanceSquared(bs->origin, ps.origin) < maxDistSqr) {
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 624+20
ARGP4
ADDRLP4 1100
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 1100
INDIRF4
ADDRLP4 1092
INDIRF4
GEF4 $781
line 1421
;1421:				if (BotEntityVisible(&bs->cur_ps, 360, bs->teammate)) {
ADDRLP4 1104
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1104
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 1104
INDIRP4
CNSTI4 11560
ADDP4
INDIRI4
ARGI4
ADDRLP4 1108
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 1108
INDIRF4
CNSTF4 0
EQF4 $784
line 1422
;1422:					trap_BotResetAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidReach
CALLV
pop
line 1423
;1423:					BotCheckIfBlockingTeammates(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCheckIfBlockingTeammates
CALLV
pop
line 1424
;1424:					return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $764
JUMPV
LABELV $784
line 1426
;1425:				}
;1426:			}
LABELV $781
line 1429
;1427:
;1428:			// update team goal
;1429:			areanum = BotPointAreaNum(ps.origin);
ADDRLP4 624+20
ARGP4
ADDRLP4 1104
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 412
ADDRLP4 1104
INDIRI4
ASGNI4
line 1430
;1430:			if (areanum > 0 && trap_AAS_AreaReachability(areanum)) {
ADDRLP4 1108
ADDRLP4 412
INDIRI4
ASGNI4
ADDRLP4 1108
INDIRI4
CNSTI4 0
LEI4 $787
ADDRLP4 1108
INDIRI4
ARGI4
ADDRLP4 1112
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 1112
INDIRI4
CNSTI4 0
EQI4 $787
line 1431
;1431:				bs->teamgoal.entitynum = bs->teammate;
ADDRLP4 1116
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1116
INDIRP4
CNSTI4 11620
ADDP4
ADDRLP4 1116
INDIRP4
CNSTI4 11560
ADDP4
INDIRI4
ASGNI4
line 1432
;1432:				bs->teamgoal.areanum = areanum;
ADDRFP4 0
INDIRP4
CNSTI4 11592
ADDP4
ADDRLP4 412
INDIRI4
ASGNI4
line 1433
;1433:				VectorCopy(ps.origin, bs->teamgoal.origin);
ADDRFP4 0
INDIRP4
CNSTI4 11580
ADDP4
ADDRLP4 624+20
INDIRB
ASGNB 12
line 1434
;1434:				VectorSet(bs->teamgoal.mins, -8, -8, -8);
ADDRFP4 0
INDIRP4
CNSTI4 11596
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 11600
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 11604
ADDP4
CNSTF4 3238002688
ASGNF4
line 1435
;1435:				VectorSet(bs->teamgoal.maxs, 8, 8, 8);
ADDRFP4 0
INDIRP4
CNSTI4 11608
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 11612
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 11616
ADDP4
CNSTF4 1090519040
ASGNF4
line 1436
;1436:			}
LABELV $787
line 1437
;1437:		}
line 1439
;1438:#endif
;1439:		memcpy(goal, &bs->teamgoal, sizeof(bot_goal_t));
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 11580
ADDP4
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1440
;1440:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $764
JUMPV
LABELV $765
line 1443
;1441:	}
;1442:	//if the bot accompanies someone
;1443:	if (bs->ltgtype == LTG_TEAMACCOMPANY && !retreat) {
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 2
NEI4 $790
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $790
line 1445
;1444:		//check for bot typing status message
;1445:		if (bs->teammessage_time && bs->teammessage_time < FloatTime()) {
ADDRLP4 620
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 620
INDIRP4
CNSTI4 11696
ADDP4
INDIRF4
CNSTF4 0
EQF4 $792
ADDRLP4 620
INDIRP4
CNSTI4 11696
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $792
line 1446
;1446:			BotAI_BotInitialChat(bs, "accompany_start", EasyClientName(bs->teammate, netname, sizeof(netname)), NULL);
ADDRFP4 0
INDIRP4
CNSTI4 11560
ADDP4
INDIRI4
ARGI4
ADDRLP4 416
ARGP4
CNSTI4 36
ARGI4
ADDRLP4 624
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $794
ARGP4
ADDRLP4 624
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1447
;1447:			trap_BotEnterChat(bs->cs, bs->decisionmaker, CHAT_TELL);
ADDRLP4 628
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 628
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRLP4 628
INDIRP4
CNSTI4 11564
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1448
;1448:			BotVoiceChatOnly(bs, bs->decisionmaker, VOICECHAT_YES);
ADDRLP4 632
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 632
INDIRP4
ARGP4
ADDRLP4 632
INDIRP4
CNSTI4 11564
ADDP4
INDIRI4
ARGI4
ADDRGP4 $795
ARGP4
ADDRGP4 BotVoiceChatOnly
CALLV
pop
line 1449
;1449:			trap_EA_Action(bs->client, ACTION_AFFIRMATIVE);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1048576
ARGI4
ADDRGP4 trap_EA_Action
CALLV
pop
line 1450
;1450:			bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11696
ADDP4
CNSTF4 0
ASGNF4
line 1451
;1451:		}
LABELV $792
line 1453
;1452:		//if accompanying the companion for 3 minutes
;1453:		if (bs->teamgoal_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 11700
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $796
line 1454
;1454:			BotAI_BotInitialChat(bs, "accompany_stop", EasyClientName(bs->teammate, netname, sizeof(netname)), NULL);
ADDRFP4 0
INDIRP4
CNSTI4 11560
ADDP4
INDIRI4
ARGI4
ADDRLP4 416
ARGP4
CNSTI4 36
ARGI4
ADDRLP4 624
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $798
ARGP4
ADDRLP4 624
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1455
;1455:			trap_BotEnterChat(bs->cs, bs->teammate, CHAT_TELL);
ADDRLP4 628
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 628
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRLP4 628
INDIRP4
CNSTI4 11560
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1456
;1456:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
line 1457
;1457:		}
LABELV $796
line 1459
;1458:		//get entity information of the companion
;1459:		BotEntityInfo(bs->teammate, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 11560
ADDP4
INDIRI4
ARGI4
ADDRLP4 272
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 1461
;1460:		//if the companion is visible
;1461:		if (BotEntityVisible(&bs->cur_ps/*bs->entitynum, bs->eye, bs->viewangles*/, 360, bs->teammate)) {	// JUHOX
ADDRLP4 624
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 624
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 624
INDIRP4
CNSTI4 11560
ADDP4
INDIRI4
ARGI4
ADDRLP4 628
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 628
INDIRF4
CNSTF4 0
EQF4 $799
line 1463
;1462:			//update visible time
;1463:			bs->teammatevisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 11708
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 1464
;1464:			VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 632
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 260
ADDRLP4 272+24
INDIRF4
ADDRLP4 632
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 260+4
ADDRLP4 272+24+4
INDIRF4
ADDRLP4 632
INDIRP4
CNSTI4 4920
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 260+8
ADDRLP4 272+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1465
;1465:			if (VectorLengthSquared(dir) < Square(bs->formation_dist)) {
ADDRLP4 260
ARGP4
ADDRLP4 636
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 640
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 636
INDIRF4
ADDRLP4 640
INDIRP4
CNSTI4 12344
ADDP4
INDIRF4
ADDRLP4 640
INDIRP4
CNSTI4 12344
ADDP4
INDIRF4
MULF4
GEF4 $808
line 1469
;1466:				//
;1467:				// if the client being followed bumps into this bot then
;1468:				// the bot should back up
;1469:				BotEntityInfo(bs->entitynum, &botinfo);
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 452
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 1471
;1470:				// if the followed client is not standing ontop of the bot
;1471:				if (botinfo.origin[2] + botinfo.maxs[2] > entinfo.origin[2] + entinfo.mins[2]) {
ADDRLP4 452+24+8
INDIRF4
ADDRLP4 452+84+8
INDIRF4
ADDF4
ADDRLP4 272+24+8
INDIRF4
ADDRLP4 272+72+8
INDIRF4
ADDF4
LEF4 $810
line 1473
;1472:					// if the bounding boxes touch each other
;1473:					if (botinfo.origin[0] + botinfo.maxs[0] > entinfo.origin[0] + entinfo.mins[0] - 4&&
ADDRLP4 452+24
INDIRF4
ADDRLP4 452+84
INDIRF4
ADDF4
ADDRLP4 272+24
INDIRF4
ADDRLP4 272+72
INDIRF4
ADDF4
CNSTF4 1082130432
SUBF4
LEF4 $820
ADDRLP4 452+24
INDIRF4
ADDRLP4 452+72
INDIRF4
ADDF4
ADDRLP4 272+24
INDIRF4
ADDRLP4 272+84
INDIRF4
ADDF4
CNSTF4 1082130432
ADDF4
GEF4 $820
line 1474
;1474:						botinfo.origin[0] + botinfo.mins[0] < entinfo.origin[0] + entinfo.maxs[0] + 4) {
line 1475
;1475:						if (botinfo.origin[1] + botinfo.maxs[1] > entinfo.origin[1] + entinfo.mins[1] - 4 &&
ADDRLP4 452+24+4
INDIRF4
ADDRLP4 452+84+4
INDIRF4
ADDF4
ADDRLP4 272+24+4
INDIRF4
ADDRLP4 272+72+4
INDIRF4
ADDF4
CNSTF4 1082130432
SUBF4
LEF4 $830
ADDRLP4 452+24+4
INDIRF4
ADDRLP4 452+72+4
INDIRF4
ADDF4
ADDRLP4 272+24+4
INDIRF4
ADDRLP4 272+84+4
INDIRF4
ADDF4
CNSTF4 1082130432
ADDF4
GEF4 $830
line 1476
;1476:							botinfo.origin[1] + botinfo.mins[1] < entinfo.origin[1] + entinfo.maxs[1] + 4) {
line 1477
;1477:							if (botinfo.origin[2] + botinfo.maxs[2] > entinfo.origin[2] + entinfo.mins[2] - 4 &&
ADDRLP4 452+24+8
INDIRF4
ADDRLP4 452+84+8
INDIRF4
ADDF4
ADDRLP4 272+24+8
INDIRF4
ADDRLP4 272+72+8
INDIRF4
ADDF4
CNSTF4 1082130432
SUBF4
LEF4 $848
ADDRLP4 452+24+8
INDIRF4
ADDRLP4 452+72+8
INDIRF4
ADDF4
ADDRLP4 272+24+8
INDIRF4
ADDRLP4 272+84+8
INDIRF4
ADDF4
CNSTF4 1082130432
ADDF4
GEF4 $848
line 1478
;1478:								botinfo.origin[2] + botinfo.mins[2] < entinfo.origin[2] + entinfo.maxs[2] + 4) {
line 1480
;1479:								// if the followed client looks in the direction of this bot
;1480:								AngleVectors(entinfo.angles, dir, NULL, NULL);
ADDRLP4 272+36
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 1481
;1481:								dir[2] = 0;
ADDRLP4 260+8
CNSTF4 0
ASGNF4
line 1482
;1482:								VectorNormalize(dir);
ADDRLP4 260
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 1484
;1483:								//VectorSubtract(entinfo.origin, entinfo.lastvisorigin, dir);
;1484:								VectorSubtract(bs->origin, entinfo.origin, dir2);
ADDRLP4 644
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 608
ADDRLP4 644
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRLP4 272+24
INDIRF4
SUBF4
ASGNF4
ADDRLP4 608+4
ADDRLP4 644
INDIRP4
CNSTI4 4920
ADDP4
INDIRF4
ADDRLP4 272+24+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 608+8
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRF4
ADDRLP4 272+24+8
INDIRF4
SUBF4
ASGNF4
line 1485
;1485:								VectorNormalize(dir2);
ADDRLP4 608
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 1486
;1486:								if (DotProduct(dir, dir2) > 0.7) {
ADDRLP4 260
INDIRF4
ADDRLP4 608
INDIRF4
MULF4
ADDRLP4 260+4
INDIRF4
ADDRLP4 608+4
INDIRF4
MULF4
ADDF4
ADDRLP4 260+8
INDIRF4
ADDRLP4 608+8
INDIRF4
MULF4
ADDF4
CNSTF4 1060320051
LEF4 $875
line 1488
;1487:									// back up
;1488:									BotSetupForMovement(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetupForMovement
CALLV
pop
line 1489
;1489:									trap_BotMoveInDirection(bs->ms, dir2, 400, MOVE_WALK);
ADDRFP4 0
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRLP4 608
ARGP4
CNSTF4 1137180672
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotMoveInDirection
CALLI4
pop
line 1490
;1490:								}
LABELV $875
line 1491
;1491:							}
LABELV $848
line 1492
;1492:						}
LABELV $830
line 1493
;1493:					}
LABELV $820
line 1494
;1494:				}
LABELV $810
line 1497
;1495:				//check if the bot wants to crouch
;1496:				//don't crouch if crouched less than 5 seconds ago
;1497:				if (bs->attackcrouch_time < FloatTime() - 5) {
ADDRFP4 0
INDIRP4
CNSTI4 7212
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
SUBF4
GEF4 $881
line 1498
;1498:					croucher = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CROUCHER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 36
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 644
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 592
ADDRLP4 644
INDIRF4
ASGNF4
line 1499
;1499:					if (random() < bs->thinktime * croucher) {
ADDRLP4 648
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 648
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 648
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
ADDRLP4 592
INDIRF4
MULF4
GEF4 $883
line 1500
;1500:						bs->attackcrouch_time = FloatTime() + 5 + croucher * 15;
ADDRFP4 0
INDIRP4
CNSTI4 7212
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
ADDRLP4 592
INDIRF4
CNSTF4 1097859072
MULF4
ADDF4
ASGNF4
line 1501
;1501:					}
LABELV $883
line 1502
;1502:				}
LABELV $881
line 1504
;1503:				//don't crouch when swimming
;1504:				if (trap_AAS_Swimming(bs->origin)) bs->attackcrouch_time = FloatTime() - 1;
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 644
ADDRGP4 trap_AAS_Swimming
CALLI4
ASGNI4
ADDRLP4 644
INDIRI4
CNSTI4 0
EQI4 $885
ADDRFP4 0
INDIRP4
CNSTI4 7212
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
SUBF4
ASGNF4
LABELV $885
line 1506
;1505:				//if not arrived yet or arived some time ago
;1506:				if (bs->arrive_time < FloatTime() - 2) {
ADDRFP4 0
INDIRP4
CNSTI4 7264
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
SUBF4
GEF4 $887
line 1508
;1507:					//if not arrived yet
;1508:					if (!bs->arrive_time) {
ADDRFP4 0
INDIRP4
CNSTI4 7264
ADDP4
INDIRF4
CNSTF4 0
NEF4 $889
line 1509
;1509:						trap_EA_Gesture(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Gesture
CALLV
pop
line 1510
;1510:						BotAI_BotInitialChat(bs, "accompany_arrive", EasyClientName(bs->teammate, netname, sizeof(netname)), NULL);
ADDRFP4 0
INDIRP4
CNSTI4 11560
ADDP4
INDIRI4
ARGI4
ADDRLP4 416
ARGP4
CNSTI4 36
ARGI4
ADDRLP4 648
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $891
ARGP4
ADDRLP4 648
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1511
;1511:						trap_BotEnterChat(bs->cs, bs->teammate, CHAT_TELL);
ADDRLP4 652
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 652
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRLP4 652
INDIRP4
CNSTI4 11560
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1512
;1512:						bs->arrive_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7264
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 1513
;1513:					}
ADDRGP4 $890
JUMPV
LABELV $889
line 1515
;1514:					//if the bot wants to crouch
;1515:					else if (bs->attackcrouch_time > FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 7212
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $892
line 1516
;1516:						trap_EA_Crouch(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Crouch
CALLV
pop
line 1517
;1517:					}
ADDRGP4 $893
JUMPV
LABELV $892
line 1519
;1518:					//else do some model taunts
;1519:					else if (random() < bs->thinktime * 0.05) {
ADDRLP4 648
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 648
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 648
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
CNSTF4 1028443341
MULF4
GEF4 $894
line 1521
;1520:						//do a gesture :)
;1521:						trap_EA_Gesture(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Gesture
CALLV
pop
line 1522
;1522:					}
LABELV $894
LABELV $893
LABELV $890
line 1523
;1523:				}
LABELV $887
line 1525
;1524:				//if just arrived look at the companion
;1525:				if (bs->arrive_time > FloatTime() - 2) {
ADDRFP4 0
INDIRP4
CNSTI4 7264
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
SUBF4
LEF4 $896
line 1526
;1526:					VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 648
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 260
ADDRLP4 272+24
INDIRF4
ADDRLP4 648
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 260+4
ADDRLP4 272+24+4
INDIRF4
ADDRLP4 648
INDIRP4
CNSTI4 4920
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 260+8
ADDRLP4 272+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1527
;1527:					vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 260
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 7852
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 1528
;1528:					bs->ideal_viewangles[2] *= 0.5;
ADDRLP4 652
ADDRFP4 0
INDIRP4
CNSTI4 7860
ADDP4
ASGNP4
ADDRLP4 652
INDIRP4
ADDRLP4 652
INDIRP4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 1529
;1529:				}
ADDRGP4 $897
JUMPV
LABELV $896
line 1535
;1530:				//else look strategically around for enemies
;1531:#if 0	// JUHOX: new roaming view goal strategy
;1532:				else if (random() < bs->thinktime * 0.8) {
;1533:					BotRoamGoal(bs, target);
;1534:#else
;1535:				else if (BotRoamGoal(bs, target, qfalse)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 596
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 648
ADDRGP4 BotRoamGoal
CALLI4
ASGNI4
ADDRLP4 648
INDIRI4
CNSTI4 0
EQI4 $905
line 1537
;1536:#endif
;1537:					VectorSubtract(target, bs->origin, dir);
ADDRLP4 652
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 260
ADDRLP4 596
INDIRF4
ADDRLP4 652
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 260+4
ADDRLP4 596+4
INDIRF4
ADDRLP4 652
INDIRP4
CNSTI4 4920
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 260+8
ADDRLP4 596+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1538
;1538:					vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 260
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 7852
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 1539
;1539:					bs->ideal_viewangles[2] *= 0.5;
ADDRLP4 656
ADDRFP4 0
INDIRP4
CNSTI4 7860
ADDP4
ASGNP4
ADDRLP4 656
INDIRP4
ADDRLP4 656
INDIRP4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 1540
;1540:				}
LABELV $905
LABELV $897
line 1542
;1541:				//check if the bot wants to go for air
;1542:				if (BotGoForAir(bs, bs->tfl, &bs->teamgoal, 400)) {
ADDRLP4 652
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 652
INDIRP4
ARGP4
ADDRLP4 652
INDIRP4
CNSTI4 5984
ADDP4
INDIRI4
ARGI4
ADDRLP4 652
INDIRP4
CNSTI4 11580
ADDP4
ARGP4
CNSTF4 1137180672
ARGF4
ADDRLP4 656
ADDRGP4 BotGoForAir
CALLI4
ASGNI4
ADDRLP4 656
INDIRI4
CNSTI4 0
EQI4 $911
line 1543
;1543:					trap_BotResetLastAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetLastAvoidReach
CALLV
pop
line 1549
;1544:					//get the goal at the top of the stack
;1545:					//trap_BotGetTopGoal(bs->gs, &tmpgoal);
;1546:					//trap_BotGoalName(tmpgoal.number, buf, 144);
;1547:					//BotAI_Print(PRT_MESSAGE, "new nearby goal %s\n", buf);
;1548:					//time the bot gets to pick up the nearby goal item
;1549:					bs->nbg_time = FloatTime() + 8;
ADDRFP4 0
INDIRP4
CNSTI4 6092
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 1550
;1550:					AIEnter_Seek_NBG(bs, "BotLongTermGoal: go for air");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $913
ARGP4
ADDRGP4 AIEnter_Seek_NBG
CALLV
pop
line 1551
;1551:					return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $764
JUMPV
LABELV $911
line 1554
;1552:				}
;1553:				//
;1554:				trap_BotResetAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidReach
CALLV
pop
line 1555
;1555:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $764
JUMPV
LABELV $808
line 1557
;1556:			}
;1557:		}
LABELV $799
line 1559
;1558:		//if the entity information is valid (entity in PVS)
;1559:		if (entinfo.valid) {
ADDRLP4 272
INDIRI4
CNSTI4 0
EQI4 $914
line 1560
;1560:			areanum = BotPointAreaNum(entinfo.origin);
ADDRLP4 272+24
ARGP4
ADDRLP4 632
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 412
ADDRLP4 632
INDIRI4
ASGNI4
line 1561
;1561:			if (areanum && trap_AAS_AreaReachability(areanum)) {
ADDRLP4 636
ADDRLP4 412
INDIRI4
ASGNI4
ADDRLP4 636
INDIRI4
CNSTI4 0
EQI4 $917
ADDRLP4 636
INDIRI4
ARGI4
ADDRLP4 640
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 640
INDIRI4
CNSTI4 0
EQI4 $917
line 1563
;1562:				//update team goal
;1563:				bs->teamgoal.entitynum = bs->teammate;
ADDRLP4 644
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 644
INDIRP4
CNSTI4 11620
ADDP4
ADDRLP4 644
INDIRP4
CNSTI4 11560
ADDP4
INDIRI4
ASGNI4
line 1564
;1564:				bs->teamgoal.areanum = areanum;
ADDRFP4 0
INDIRP4
CNSTI4 11592
ADDP4
ADDRLP4 412
INDIRI4
ASGNI4
line 1565
;1565:				VectorCopy(entinfo.origin, bs->teamgoal.origin);
ADDRFP4 0
INDIRP4
CNSTI4 11580
ADDP4
ADDRLP4 272+24
INDIRB
ASGNB 12
line 1566
;1566:				VectorSet(bs->teamgoal.mins, -8, -8, -8);
ADDRFP4 0
INDIRP4
CNSTI4 11596
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 11600
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 11604
ADDP4
CNSTF4 3238002688
ASGNF4
line 1567
;1567:				VectorSet(bs->teamgoal.maxs, 8, 8, 8);
ADDRFP4 0
INDIRP4
CNSTI4 11608
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 11612
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 11616
ADDP4
CNSTF4 1090519040
ASGNF4
line 1568
;1568:			}
LABELV $917
line 1569
;1569:		}
LABELV $914
line 1571
;1570:		//the goal the bot should go for
;1571:		memcpy(goal, &bs->teamgoal, sizeof(bot_goal_t));
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 11580
ADDP4
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1573
;1572:		//if the companion is NOT visible for too long
;1573:		if (bs->teammatevisible_time < FloatTime() - 60) {
ADDRFP4 0
INDIRP4
CNSTI4 11708
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1114636288
SUBF4
GEF4 $920
line 1574
;1574:			BotAI_BotInitialChat(bs, "accompany_cannotfind", EasyClientName(bs->teammate, netname, sizeof(netname)), NULL);
ADDRFP4 0
INDIRP4
CNSTI4 11560
ADDP4
INDIRI4
ARGI4
ADDRLP4 416
ARGP4
CNSTI4 36
ARGI4
ADDRLP4 632
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $922
ARGP4
ADDRLP4 632
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1575
;1575:			trap_BotEnterChat(bs->cs, bs->teammate, CHAT_TELL);
ADDRLP4 636
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 636
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRLP4 636
INDIRP4
CNSTI4 11560
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1576
;1576:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
line 1578
;1577:			// just to make sure the bot won't spam this message
;1578:			bs->teammatevisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 11708
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 1579
;1579:		}
LABELV $920
line 1580
;1580:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $764
JUMPV
LABELV $790
line 1583
;1581:	}
;1582:	//
;1583:	if (bs->ltgtype == LTG_DEFENDKEYAREA) {
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 3
NEI4 $923
line 1584
;1584:		if (trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin,
ADDRLP4 620
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 620
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
ARGI4
ADDRLP4 620
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 620
INDIRP4
CNSTI4 11592
ADDP4
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 624
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 624
INDIRI4
CVIF4 4
ADDRFP4 0
INDIRP4
CNSTI4 7240
ADDP4
INDIRF4
LEF4 $925
line 1585
;1585:				bs->teamgoal.areanum, TFL_DEFAULT) > bs->defendaway_range) {
line 1586
;1586:			bs->defendaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7236
ADDP4
CNSTF4 0
ASGNF4
line 1587
;1587:		}
LABELV $925
line 1588
;1588:	}
LABELV $923
line 1590
;1589:	//if defending a key area
;1590:	if (bs->ltgtype == LTG_DEFENDKEYAREA && !retreat &&
ADDRLP4 620
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 620
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 3
NEI4 $927
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $927
ADDRLP4 620
INDIRP4
CNSTI4 7236
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $927
line 1591
;1591:				bs->defendaway_time < FloatTime()) {
line 1593
;1592:		//check for bot typing status message
;1593:		if (bs->teammessage_time && bs->teammessage_time < FloatTime()) {
ADDRLP4 624
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 624
INDIRP4
CNSTI4 11696
ADDP4
INDIRF4
CNSTF4 0
EQF4 $929
ADDRLP4 624
INDIRP4
CNSTI4 11696
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $929
line 1594
;1594:			trap_BotGoalName(bs->teamgoal.number, buf, sizeof(buf));
ADDRFP4 0
INDIRP4
CNSTI4 11624
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 1595
;1595:			BotAI_BotInitialChat(bs, "defend_start", buf, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $931
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1596
;1596:			trap_BotEnterChat(bs->cs, 0, CHAT_TEAM);
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1597
;1597:			BotVoiceChatOnly(bs, -1, VOICECHAT_ONDEFENSE);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 $932
ARGP4
ADDRGP4 BotVoiceChatOnly
CALLV
pop
line 1598
;1598:			bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11696
ADDP4
CNSTF4 0
ASGNF4
line 1599
;1599:		}
LABELV $929
line 1601
;1600:		//set the bot goal
;1601:		memcpy(goal, &bs->teamgoal, sizeof(bot_goal_t));
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 11580
ADDP4
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1603
;1602:		//stop after 2 minutes
;1603:		if (bs->teamgoal_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 11700
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $933
line 1604
;1604:			trap_BotGoalName(bs->teamgoal.number, buf, sizeof(buf));
ADDRFP4 0
INDIRP4
CNSTI4 11624
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 1605
;1605:			BotAI_BotInitialChat(bs, "defend_stop", buf, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $935
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1606
;1606:			trap_BotEnterChat(bs->cs, 0, CHAT_TEAM);
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1607
;1607:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
line 1608
;1608:		}
LABELV $933
line 1610
;1609:		//if very close... go away for some time
;1610:		VectorSubtract(goal->origin, bs->origin, dir);
ADDRLP4 628
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 632
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 260
ADDRLP4 628
INDIRP4
INDIRF4
ADDRLP4 632
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 260+4
ADDRLP4 628
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 632
INDIRP4
CNSTI4 4920
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 260+8
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1611
;1611:		if (VectorLengthSquared(dir) < Square(70)) {
ADDRLP4 260
ARGP4
ADDRLP4 636
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 636
INDIRF4
CNSTF4 1167663104
GEF4 $938
line 1612
;1612:			trap_BotResetAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidReach
CALLV
pop
line 1613
;1613:			bs->defendaway_time = FloatTime() + 3 + 3 * random();
ADDRLP4 640
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRFP4 0
INDIRP4
CNSTI4 7236
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1077936128
ADDF4
ADDRLP4 640
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 640
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1077936128
MULF4
ADDF4
ASGNF4
line 1614
;1614:			if (BotHasPersistantPowerupAndWeapon(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 644
ADDRGP4 BotHasPersistantPowerupAndWeapon
CALLI4
ASGNI4
ADDRLP4 644
INDIRI4
CNSTI4 0
EQI4 $940
line 1615
;1615:				bs->defendaway_range = 100;
ADDRFP4 0
INDIRP4
CNSTI4 7240
ADDP4
CNSTF4 1120403456
ASGNF4
line 1616
;1616:			}
ADDRGP4 $941
JUMPV
LABELV $940
line 1617
;1617:			else {
line 1618
;1618:				bs->defendaway_range = 350;
ADDRFP4 0
INDIRP4
CNSTI4 7240
ADDP4
CNSTF4 1135542272
ASGNF4
line 1619
;1619:			}
LABELV $941
line 1620
;1620:		}
LABELV $938
line 1621
;1621:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $764
JUMPV
LABELV $927
line 1624
;1622:	}
;1623:	//going to kill someone
;1624:	if (bs->ltgtype == LTG_KILL && !retreat) {
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 11
NEI4 $942
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $942
line 1626
;1625:		//check for bot typing status message
;1626:		if (bs->teammessage_time && bs->teammessage_time < FloatTime()) {
ADDRLP4 624
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 624
INDIRP4
CNSTI4 11696
ADDP4
INDIRF4
CNSTF4 0
EQF4 $944
ADDRLP4 624
INDIRP4
CNSTI4 11696
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $944
line 1632
;1627:#if 0	// JUHOX: no 'start killing' status message
;1628:			EasyClientName(bs->teamgoal.entitynum, buf, sizeof(buf));
;1629:			BotAI_BotInitialChat(bs, "kill_start", buf, NULL);
;1630:			trap_BotEnterChat(bs->cs, bs->decisionmaker, CHAT_TELL);
;1631:#endif
;1632:			bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11696
ADDP4
CNSTF4 0
ASGNF4
line 1633
;1633:		}
LABELV $944
line 1635
;1634:		//
;1635:		if (bs->lastkilledplayer == bs->teamgoal.entitynum) {
ADDRLP4 628
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 628
INDIRP4
CNSTI4 6012
ADDP4
INDIRI4
ADDRLP4 628
INDIRP4
CNSTI4 11620
ADDP4
INDIRI4
NEI4 $946
line 1642
;1636:#if 0	// JUHOX: no 'kill done' status message
;1637:			EasyClientName(bs->teamgoal.entitynum, buf, sizeof(buf));
;1638:			BotAI_BotInitialChat(bs, "kill_done", buf, NULL);
;1639:			trap_BotEnterChat(bs->cs, bs->decisionmaker, CHAT_TELL);
;1640:			bs->lastkilledplayer = -1;
;1641:#endif
;1642:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
line 1643
;1643:		}
LABELV $946
line 1645
;1644:		//
;1645:		if (bs->teamgoal_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 11700
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $948
line 1646
;1646:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
line 1647
;1647:		}
LABELV $948
line 1649
;1648:		//just roam around
;1649:		return BotGetItemLongTermGoal(bs, tfl, goal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 632
ADDRGP4 BotGetItemLongTermGoal
CALLI4
ASGNI4
ADDRLP4 632
INDIRI4
RETI4
ADDRGP4 $764
JUMPV
LABELV $942
line 1652
;1650:	}
;1651:	//get an item
;1652:	if (bs->ltgtype == LTG_GETITEM /*&& !retreat*/) {	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 10
NEI4 $950
line 1664
;1653:		//check for bot typing status message
;1654:#if 0	// JUHOX: no 'get item' status message
;1655:		if (bs->teammessage_time && bs->teammessage_time < FloatTime()) {
;1656:			trap_BotGoalName(bs->teamgoal.number, buf, sizeof(buf));
;1657:			BotAI_BotInitialChat(bs, "getitem_start", buf, NULL);
;1658:			trap_BotEnterChat(bs->cs, bs->decisionmaker, CHAT_TELL);
;1659:			BotVoiceChatOnly(bs, bs->decisionmaker, VOICECHAT_YES);
;1660:			trap_EA_Action(bs->client, ACTION_AFFIRMATIVE);
;1661:			bs->teammessage_time = 0;
;1662:		}
;1663:#else
;1664:		bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11696
ADDP4
CNSTF4 0
ASGNF4
line 1667
;1665:#endif
;1666:		//set the bot goal
;1667:		memcpy(goal, &bs->teamgoal, sizeof(bot_goal_t));
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 11580
ADDP4
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1669
;1668:		//stop after some time
;1669:		if (bs->teamgoal_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 11700
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $952
line 1670
;1670:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
line 1671
;1671:		}
LABELV $952
line 1673
;1672:		//
;1673:		if (trap_BotItemGoalInVisButNotVisible(bs->entitynum, bs->eye, bs->viewangles, goal)) {
ADDRLP4 624
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 624
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 624
INDIRP4
CNSTI4 4944
ADDP4
ARGP4
ADDRLP4 624
INDIRP4
CNSTI4 7840
ADDP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 628
ADDRGP4 trap_BotItemGoalInVisButNotVisible
CALLI4
ASGNI4
ADDRLP4 628
INDIRI4
CNSTI4 0
EQI4 $954
line 1679
;1674:#if 0	// JUHOX: no 'item not there' status message
;1675:			trap_BotGoalName(bs->teamgoal.number, buf, sizeof(buf));
;1676:			BotAI_BotInitialChat(bs, "getitem_notthere", buf, NULL);
;1677:			trap_BotEnterChat(bs->cs, bs->decisionmaker, CHAT_TELL);
;1678:#endif
;1679:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
line 1680
;1680:		}
ADDRGP4 $955
JUMPV
LABELV $954
line 1681
;1681:		else if (BotReachedGoal(bs, goal)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 632
ADDRGP4 BotReachedGoal
CALLI4
ASGNI4
ADDRLP4 632
INDIRI4
CNSTI4 0
EQI4 $956
line 1687
;1682:#if 0	// JUHOX: no 'got item' status message
;1683:			trap_BotGoalName(bs->teamgoal.number, buf, sizeof(buf));
;1684:			BotAI_BotInitialChat(bs, "getitem_gotit", buf, NULL);
;1685:			trap_BotEnterChat(bs->cs, bs->decisionmaker, CHAT_TELL);
;1686:#endif
;1687:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
line 1688
;1688:		}
LABELV $956
LABELV $955
line 1689
;1689:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $764
JUMPV
LABELV $950
line 1693
;1690:	}
;1691:	//if camping somewhere
;1692:	// JUHOX: LTG_CAMP and LTG_CAMPORDER are now used to let a bot go to a location
;1693:	if ((bs->ltgtype == LTG_CAMP || bs->ltgtype == LTG_CAMPORDER) /*&& !retreat*/) {	// JUHOX
ADDRLP4 624
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 624
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 7
EQI4 $960
ADDRLP4 624
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 8
NEI4 $958
LABELV $960
line 1708
;1694:		float distanceSqr;	// JUHOX
;1695:
;1696:		//check for bot typing status message
;1697:#if 0	// JUHOX: no 'camping' status message
;1698:		if (bs->teammessage_time && bs->teammessage_time < FloatTime()) {
;1699:			if (bs->ltgtype == LTG_CAMPORDER) {
;1700:				BotAI_BotInitialChat(bs, "camp_start", EasyClientName(bs->teammate, netname, sizeof(netname)), NULL);
;1701:				trap_BotEnterChat(bs->cs, bs->decisionmaker, CHAT_TELL);
;1702:				BotVoiceChatOnly(bs, bs->decisionmaker, VOICECHAT_YES);
;1703:				trap_EA_Action(bs->client, ACTION_AFFIRMATIVE);
;1704:			}
;1705:			bs->teammessage_time = 0;
;1706:		}
;1707:#else
;1708:		bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11696
ADDP4
CNSTF4 0
ASGNF4
line 1711
;1709:#endif
;1710:		//set the bot goal
;1711:		memcpy(goal, &bs->teamgoal, sizeof(bot_goal_t));
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 11580
ADDP4
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1713
;1712:		//
;1713:		if (bs->teamgoal_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 11700
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $961
line 1720
;1714:#if 0	// JUHOX: no 'stop camping' status message
;1715:			if (bs->ltgtype == LTG_CAMPORDER) {
;1716:				BotAI_BotInitialChat(bs, "camp_stop", NULL);
;1717:				trap_BotEnterChat(bs->cs, bs->decisionmaker, CHAT_TELL);
;1718:			}
;1719:#endif
;1720:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
line 1721
;1721:		}
LABELV $961
line 1723
;1722:		//if really near the camp spot
;1723:		VectorSubtract(goal->origin, bs->origin, dir);
ADDRLP4 632
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 636
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 260
ADDRLP4 632
INDIRP4
INDIRF4
ADDRLP4 636
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 260+4
ADDRLP4 632
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 636
INDIRP4
CNSTI4 4920
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 260+8
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1727
;1724:#if 0	// JUHOX: try to avoid reaching the camp goal with LTG_CAMP (other bots may want to grab the item)
;1725:		if (VectorLengthSquared(dir) < Square(60))
;1726:#else
;1727:		distanceSqr = VectorLengthSquared(dir);
ADDRLP4 260
ARGP4
ADDRLP4 640
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 628
ADDRLP4 640
INDIRF4
ASGNF4
line 1729
;1728:		if (
;1729:			bs->arrive_time ||
ADDRLP4 644
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 644
INDIRP4
CNSTI4 7264
ADDP4
INDIRF4
CNSTF4 0
NEF4 $971
ADDRLP4 644
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 8
NEI4 $969
ADDRLP4 628
INDIRF4
CNSTF4 1159479296
LTF4 $971
LABELV $969
ADDRLP4 648
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 648
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 7
NEI4 $965
ADDRLP4 652
ADDRLP4 628
INDIRF4
ASGNF4
ADDRLP4 652
INDIRF4
CNSTF4 1176256512
LTF4 $971
ADDRLP4 652
INDIRF4
CNSTF4 1215570944
GEF4 $965
ADDRLP4 656
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 656
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $965
ADDRLP4 648
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 656
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ARGI4
ADDRLP4 660
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 660
INDIRF4
CNSTF4 0
NEF4 $971
ADDRLP4 664
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 664
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
ARGI4
ADDRLP4 664
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRFP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 664
INDIRP4
CNSTI4 5984
ADDP4
INDIRI4
ARGI4
ADDRLP4 668
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 668
INDIRI4
CNSTI4 200
GEI4 $965
ADDRLP4 672
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 672
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 672
INDIRP4
ARGP4
ADDRLP4 676
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 676
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
ARGI4
ADDRLP4 676
INDIRP4
CNSTI4 5984
ADDP4
INDIRI4
ARGI4
ADDRLP4 680
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 680
INDIRI4
CNSTI4 200
GEI4 $965
LABELV $971
line 1750
;1730:			(bs->ltgtype == LTG_CAMPORDER && distanceSqr < Square(50)) ||
;1731:			(
;1732:				bs->ltgtype == LTG_CAMP &&
;1733:				(
;1734:					distanceSqr < Square(100) ||
;1735:					(
;1736:						distanceSqr < Square(500) &&
;1737:						(goal->flags & GFL_ITEM) &&
;1738:						(
;1739:							BotEntityVisible(&bs->cur_ps, 360, goal->entitynum) ||
;1740:							(
;1741:								trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, goal->areanum, bs->tfl) < 200 &&
;1742:								trap_AAS_AreaTravelTimeToGoalArea(goal->areanum, goal->origin, bs->areanum, bs->tfl) < 200
;1743:							)
;1744:						)
;1745:					)
;1746:				)
;1747:			)
;1748:		)
;1749:#endif
;1750:		{
line 1752
;1751:			//if not arrived yet
;1752:			if (!bs->arrive_time) {
ADDRFP4 0
INDIRP4
CNSTI4 7264
ADDP4
INDIRF4
CNSTF4 0
NEF4 $972
line 1760
;1753:#if 0	// JUHOX: no 'arrived at camp goal' status message
;1754:				if (bs->ltgtype == LTG_CAMPORDER) {
;1755:					BotAI_BotInitialChat(bs, "camp_arrive", EasyClientName(bs->teammate, netname, sizeof(netname)), NULL);
;1756:					trap_BotEnterChat(bs->cs, bs->decisionmaker, CHAT_TELL);
;1757:					BotVoiceChatOnly(bs, bs->decisionmaker, VOICECHAT_INPOSITION);
;1758:				}
;1759:#endif
;1760:				bs->teamgoal_time = FloatTime() + bs->camp_time;	// JUHOX: stay here some time. note that camp_time had formerly another meaning
ADDRLP4 684
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 684
INDIRP4
CNSTI4 11700
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 684
INDIRP4
CNSTI4 7288
ADDP4
INDIRF4
ADDF4
ASGNF4
line 1761
;1761:				bs->arrive_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7264
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 1762
;1762:			}
LABELV $972
line 1772
;1763:			//look strategically around for enemies
;1764:#if 0	// JUHOX: new roaming view strategy
;1765:			if (random() < bs->thinktime * 0.8) {
;1766:				BotRoamGoal(bs, target);
;1767:				VectorSubtract(target, bs->origin, dir);
;1768:				vectoangles(dir, bs->ideal_viewangles);
;1769:				bs->ideal_viewangles[2] *= 0.5;
;1770:			}
;1771:#else
;1772:			BotCheckIfBlockingTeammates(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCheckIfBlockingTeammates
CALLV
pop
line 1776
;1773:#endif
;1774:			//check if the bot wants to crouch
;1775:			//don't crouch if crouched less than 5 seconds ago
;1776:			if (bs->attackcrouch_time < FloatTime() - 5) {
ADDRFP4 0
INDIRP4
CNSTI4 7212
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
SUBF4
GEF4 $974
line 1777
;1777:				croucher = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CROUCHER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 36
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 684
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 592
ADDRLP4 684
INDIRF4
ASGNF4
line 1778
;1778:				if (random() < bs->thinktime * croucher) {
ADDRLP4 688
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 688
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 688
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
ADDRLP4 592
INDIRF4
MULF4
GEF4 $976
line 1779
;1779:					bs->attackcrouch_time = FloatTime() + 5 + croucher * 15;
ADDRFP4 0
INDIRP4
CNSTI4 7212
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
ADDRLP4 592
INDIRF4
CNSTF4 1097859072
MULF4
ADDF4
ASGNF4
line 1780
;1780:				}
LABELV $976
line 1781
;1781:			}
LABELV $974
line 1783
;1782:			//if the bot wants to crouch
;1783:			if (bs->attackcrouch_time > FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 7212
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $978
line 1784
;1784:				trap_EA_Crouch(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Crouch
CALLV
pop
line 1785
;1785:			}
LABELV $978
line 1787
;1786:			//don't crouch when swimming
;1787:			if (trap_AAS_Swimming(bs->origin)) bs->attackcrouch_time = FloatTime() - 1;
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 684
ADDRGP4 trap_AAS_Swimming
CALLI4
ASGNI4
ADDRLP4 684
INDIRI4
CNSTI4 0
EQI4 $980
ADDRFP4 0
INDIRP4
CNSTI4 7212
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
SUBF4
ASGNF4
LABELV $980
line 1789
;1788:			//make sure the bot is not gonna drown
;1789:			if (trap_PointContents(bs->eye,bs->entitynum) & (CONTENTS_WATER|CONTENTS_SLIME|CONTENTS_LAVA)) {
ADDRLP4 688
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 688
INDIRP4
CNSTI4 4944
ADDP4
ARGP4
ADDRLP4 688
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 692
ADDRGP4 trap_PointContents
CALLI4
ASGNI4
ADDRLP4 692
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $982
line 1800
;1790:#if 0	// JUHOX: no "stop camping" status message
;1791:				if (bs->ltgtype == LTG_CAMPORDER) {
;1792:					BotAI_BotInitialChat(bs, "camp_stop", NULL);
;1793:					trap_BotEnterChat(bs->cs, bs->decisionmaker, CHAT_TELL);
;1794:					//
;1795:					if (bs->lastgoal_ltgtype == LTG_CAMPORDER) {
;1796:						bs->lastgoal_ltgtype = 0;
;1797:					}
;1798:				}
;1799:#endif
;1800:				bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
line 1801
;1801:			}
LABELV $982
line 1803
;1802:			//
;1803:			if (bs->camp_range > 0) {
ADDRFP4 0
INDIRP4
CNSTI4 7292
ADDP4
INDIRF4
CNSTF4 0
LEF4 $984
line 1805
;1804:				//FIXME: move around a bit
;1805:			}
LABELV $984
line 1807
;1806:			//
;1807:			trap_BotResetAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidReach
CALLV
pop
line 1808
;1808:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $764
JUMPV
LABELV $965
line 1810
;1809:		}
;1810:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $764
JUMPV
LABELV $958
line 1813
;1811:	}
;1812:#if 1	// JUHOX: handle new ltg LTG_ESCAPE
;1813:	if (bs->ltgtype == LTG_ESCAPE) {	// NOTE: we are not checking 'retreat' flag
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 16
NEI4 $986
line 1815
;1814:		//set the bot goal
;1815:		memcpy(goal, &bs->teamgoal, sizeof(bot_goal_t));
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 11580
ADDP4
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1818
;1816:		//
;1817:		if (
;1818:			bs->teamgoal_time < FloatTime() ||
ADDRLP4 628
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 628
INDIRP4
CNSTI4 11700
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LTF4 $990
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 628
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 632
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 632
INDIRF4
CNSTF4 1159479296
GEF4 $988
LABELV $990
line 1820
;1819:			DistanceSquared(goal->origin, bs->origin) < Square(50)
;1820:		) {
line 1821
;1821:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
line 1822
;1822:		}
LABELV $988
line 1823
;1823:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $764
JUMPV
LABELV $986
line 1827
;1824:	}
;1825:#endif
;1826:#if 1	// JUHOX: handle new ltg LTG_WAIT
;1827:	if (bs->ltgtype == LTG_WAIT) {	// NOTE: we are not checking 'retreat' flag
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 17
NEI4 $991
line 1828
;1828:		memset(goal, 0, sizeof(*goal));	// not really needed
ADDRFP4 12
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 56
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1829
;1829:		BotCheckIfBlockingTeammates(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCheckIfBlockingTeammates
CALLV
pop
line 1830
;1830:		if (bs->teamgoal_time < FloatTime()) bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11700
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $993
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
LABELV $993
line 1831
;1831:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $764
JUMPV
LABELV $991
line 1835
;1832:	}
;1833:#endif
;1834:	//patrolling along several waypoints
;1835:	if (bs->ltgtype == LTG_PATROL && !retreat) {
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 9
NEI4 $995
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $995
line 1837
;1836:		//check for bot typing status message
;1837:		if (bs->teammessage_time && bs->teammessage_time < FloatTime()) {
ADDRLP4 628
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 628
INDIRP4
CNSTI4 11696
ADDP4
INDIRF4
CNSTF4 0
EQF4 $997
ADDRLP4 628
INDIRP4
CNSTI4 11696
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $997
line 1838
;1838:			strcpy(buf, "");
ADDRLP4 4
ARGP4
ADDRGP4 $99
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1839
;1839:			for (wp = bs->patrolpoints; wp; wp = wp->next) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 14408
ADDP4
INDIRP4
ASGNP4
ADDRGP4 $1002
JUMPV
LABELV $999
line 1840
;1840:				strcat(buf, wp->name);
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 1841
;1841:				if (wp->next) strcat(buf, " to ");
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1003
ADDRLP4 4
ARGP4
ADDRGP4 $1005
ARGP4
ADDRGP4 strcat
CALLP4
pop
LABELV $1003
line 1842
;1842:			}
LABELV $1000
line 1839
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
ASGNP4
LABELV $1002
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $999
line 1843
;1843:			BotAI_BotInitialChat(bs, "patrol_start", buf, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1006
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1844
;1844:			trap_BotEnterChat(bs->cs, bs->decisionmaker, CHAT_TELL);
ADDRLP4 632
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 632
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRLP4 632
INDIRP4
CNSTI4 11564
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1845
;1845:			BotVoiceChatOnly(bs, bs->decisionmaker, VOICECHAT_YES);
ADDRLP4 636
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 636
INDIRP4
ARGP4
ADDRLP4 636
INDIRP4
CNSTI4 11564
ADDP4
INDIRI4
ARGI4
ADDRGP4 $795
ARGP4
ADDRGP4 BotVoiceChatOnly
CALLV
pop
line 1846
;1846:			trap_EA_Action(bs->client, ACTION_AFFIRMATIVE);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1048576
ARGI4
ADDRGP4 trap_EA_Action
CALLV
pop
line 1847
;1847:			bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11696
ADDP4
CNSTF4 0
ASGNF4
line 1848
;1848:		}
LABELV $997
line 1850
;1849:		//
;1850:		if (!bs->curpatrolpoint) {
ADDRFP4 0
INDIRP4
CNSTI4 14412
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1007
line 1851
;1851:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
line 1852
;1852:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $764
JUMPV
LABELV $1007
line 1855
;1853:		}
;1854:		//if the bot touches the current goal
;1855:		if (trap_BotTouchingGoal(bs->origin, &bs->curpatrolpoint->goal)) {
ADDRLP4 632
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 632
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 632
INDIRP4
CNSTI4 14412
ADDP4
INDIRP4
CNSTI4 36
ADDP4
ARGP4
ADDRLP4 636
ADDRGP4 trap_BotTouchingGoal
CALLI4
ASGNI4
ADDRLP4 636
INDIRI4
CNSTI4 0
EQI4 $1009
line 1856
;1856:			if (bs->patrolflags & PATROL_BACK) {
ADDRFP4 0
INDIRP4
CNSTI4 14416
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $1011
line 1857
;1857:				if (bs->curpatrolpoint->prev) {
ADDRFP4 0
INDIRP4
CNSTI4 14412
ADDP4
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1013
line 1858
;1858:					bs->curpatrolpoint = bs->curpatrolpoint->prev;
ADDRLP4 640
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 640
INDIRP4
CNSTI4 14412
ADDP4
ADDRLP4 640
INDIRP4
CNSTI4 14412
ADDP4
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
ASGNP4
line 1859
;1859:				}
ADDRGP4 $1012
JUMPV
LABELV $1013
line 1860
;1860:				else {
line 1861
;1861:					bs->curpatrolpoint = bs->curpatrolpoint->next;
ADDRLP4 640
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 640
INDIRP4
CNSTI4 14412
ADDP4
ADDRLP4 640
INDIRP4
CNSTI4 14412
ADDP4
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
ASGNP4
line 1862
;1862:					bs->patrolflags &= ~PATROL_BACK;
ADDRLP4 644
ADDRFP4 0
INDIRP4
CNSTI4 14416
ADDP4
ASGNP4
ADDRLP4 644
INDIRP4
ADDRLP4 644
INDIRP4
INDIRI4
CNSTI4 -5
BANDI4
ASGNI4
line 1863
;1863:				}
line 1864
;1864:			}
ADDRGP4 $1012
JUMPV
LABELV $1011
line 1865
;1865:			else {
line 1866
;1866:				if (bs->curpatrolpoint->next) {
ADDRFP4 0
INDIRP4
CNSTI4 14412
ADDP4
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1015
line 1867
;1867:					bs->curpatrolpoint = bs->curpatrolpoint->next;
ADDRLP4 640
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 640
INDIRP4
CNSTI4 14412
ADDP4
ADDRLP4 640
INDIRP4
CNSTI4 14412
ADDP4
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
ASGNP4
line 1868
;1868:				}
ADDRGP4 $1016
JUMPV
LABELV $1015
line 1869
;1869:				else {
line 1870
;1870:					bs->curpatrolpoint = bs->curpatrolpoint->prev;
ADDRLP4 640
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 640
INDIRP4
CNSTI4 14412
ADDP4
ADDRLP4 640
INDIRP4
CNSTI4 14412
ADDP4
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
ASGNP4
line 1871
;1871:					bs->patrolflags |= PATROL_BACK;
ADDRLP4 644
ADDRFP4 0
INDIRP4
CNSTI4 14416
ADDP4
ASGNP4
ADDRLP4 644
INDIRP4
ADDRLP4 644
INDIRP4
INDIRI4
CNSTI4 4
BORI4
ASGNI4
line 1872
;1872:				}
LABELV $1016
line 1873
;1873:			}
LABELV $1012
line 1874
;1874:		}
LABELV $1009
line 1876
;1875:		//stop after 5 minutes
;1876:		if (bs->teamgoal_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 11700
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $1017
line 1877
;1877:			BotAI_BotInitialChat(bs, "patrol_stop", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1019
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1878
;1878:			trap_BotEnterChat(bs->cs, bs->decisionmaker, CHAT_TELL);
ADDRLP4 640
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 640
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRLP4 640
INDIRP4
CNSTI4 11564
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1879
;1879:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
line 1880
;1880:		}
LABELV $1017
line 1881
;1881:		if (!bs->curpatrolpoint) {
ADDRFP4 0
INDIRP4
CNSTI4 14412
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1020
line 1882
;1882:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
line 1883
;1883:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $764
JUMPV
LABELV $1020
line 1885
;1884:		}
;1885:		memcpy(goal, &bs->curpatrolpoint->goal, sizeof(bot_goal_t));
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 14412
ADDP4
INDIRP4
CNSTI4 36
ADDP4
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1886
;1886:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $764
JUMPV
LABELV $995
line 1889
;1887:	}
;1888:#ifdef CTF
;1889:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $1022
line 1891
;1890:		//if going for enemy flag
;1891:		if (bs->ltgtype == LTG_GETFLAG) {
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 4
NEI4 $1024
line 1901
;1892:			//check for bot typing status message
;1893:#if 0	// JUHOX: no "get flag" status message
;1894:			if (bs->teammessage_time && bs->teammessage_time < FloatTime()) {
;1895:				BotAI_BotInitialChat(bs, "captureflag_start", NULL);
;1896:				trap_BotEnterChat(bs->cs, 0, CHAT_TEAM);
;1897:				BotVoiceChatOnly(bs, -1, VOICECHAT_ONGETFLAG);
;1898:				bs->teammessage_time = 0;
;1899:			}
;1900:#else
;1901:			bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11696
ADDP4
CNSTF4 0
ASGNF4
line 1904
;1902:#endif
;1903:			//
;1904:			switch(BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 632
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 628
ADDRLP4 632
INDIRI4
ASGNI4
ADDRLP4 628
INDIRI4
CNSTI4 1
EQI4 $1029
ADDRLP4 628
INDIRI4
CNSTI4 2
EQI4 $1030
ADDRGP4 $1026
JUMPV
LABELV $1029
line 1905
;1905:				case TEAM_RED: memcpy(goal, &ctf_blueflag, sizeof(bot_goal_t)); break;
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $1027
JUMPV
LABELV $1030
line 1906
;1906:				case TEAM_BLUE: memcpy(goal, &ctf_redflag, sizeof(bot_goal_t)); break;
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 ctf_redflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $1027
JUMPV
LABELV $1026
line 1907
;1907:				default: bs->ltgtype = 0; return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
CNSTI4 0
RETI4
ADDRGP4 $764
JUMPV
LABELV $1027
line 1910
;1908:			}
;1909:			//if touching the flag
;1910:			if (trap_BotTouchingGoal(bs->origin, goal)) {
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 640
ADDRGP4 trap_BotTouchingGoal
CALLI4
ASGNI4
ADDRLP4 640
INDIRI4
CNSTI4 0
EQI4 $1031
line 1912
;1911:				// make sure the bot knows the flag isn't there anymore
;1912:				switch(BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 648
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 644
ADDRLP4 648
INDIRI4
ASGNI4
ADDRLP4 644
INDIRI4
CNSTI4 1
EQI4 $1036
ADDRLP4 644
INDIRI4
CNSTI4 2
EQI4 $1037
ADDRGP4 $1033
JUMPV
LABELV $1036
line 1913
;1913:					case TEAM_RED: bs->blueflagstatus = 1; break;
ADDRFP4 0
INDIRP4
CNSTI4 11896
ADDP4
CNSTI4 1
ASGNI4
ADDRGP4 $1034
JUMPV
LABELV $1037
line 1914
;1914:					case TEAM_BLUE: bs->redflagstatus = 1; break;
ADDRFP4 0
INDIRP4
CNSTI4 11892
ADDP4
CNSTI4 1
ASGNI4
LABELV $1033
LABELV $1034
line 1916
;1915:				}
;1916:				bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
line 1917
;1917:			}
LABELV $1031
line 1919
;1918:			//stop after 3 minutes
;1919:			if (bs->teamgoal_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 11700
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $1038
line 1920
;1920:				bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
line 1921
;1921:			}
LABELV $1038
line 1922
;1922:			BotAlternateRoute(bs, goal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 BotAlternateRoute
CALLP4
pop
line 1923
;1923:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $764
JUMPV
LABELV $1024
line 1926
;1924:		}
;1925:		//if rushing to the base
;1926:		if (bs->ltgtype == LTG_RUSHBASE /*&& bs->rushbaseaway_time < FloatTime()*/) {	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 5
NEI4 $1040
line 1927
;1927:			switch(BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 632
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 628
ADDRLP4 632
INDIRI4
ASGNI4
ADDRLP4 628
INDIRI4
CNSTI4 1
EQI4 $1045
ADDRLP4 628
INDIRI4
CNSTI4 2
EQI4 $1046
ADDRGP4 $1042
JUMPV
LABELV $1045
line 1928
;1928:				case TEAM_RED: memcpy(goal, &ctf_redflag, sizeof(bot_goal_t)); break;
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 ctf_redflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $1043
JUMPV
LABELV $1046
line 1929
;1929:				case TEAM_BLUE: memcpy(goal, &ctf_blueflag, sizeof(bot_goal_t)); break;
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $1043
JUMPV
LABELV $1042
line 1930
;1930:				default: bs->ltgtype = 0; return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
CNSTI4 0
RETI4
ADDRGP4 $764
JUMPV
LABELV $1043
line 1933
;1931:			}
;1932:#if 1	// JUHOX: allow the flag carrier to escape in certain cases near the base
;1933:			if (BotOwnFlagStatus(bs) == FLAG_ATBASE) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 640
ADDRGP4 BotOwnFlagStatus
CALLI4
ASGNI4
ADDRLP4 640
INDIRI4
CNSTI4 0
NEI4 $1047
line 1934
;1934:				bs->rushbaseaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7244
ADDP4
CNSTF4 0
ASGNF4
line 1935
;1935:				bs->ltg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6088
ADDP4
CNSTF4 0
ASGNF4
line 1936
;1936:				bs->nbg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6092
ADDP4
CNSTF4 0
ASGNF4
line 1937
;1937:			}
ADDRGP4 $1048
JUMPV
LABELV $1047
line 1939
;1938:			else if (
;1939:				bs->enemy >= 0 &&
ADDRLP4 644
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 644
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 0
LTI4 $1049
ADDRLP4 644
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ARGI4
ADDRLP4 644
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
CNSTF4 1091567616
ARGF4
ADDRLP4 648
ADDRGP4 NearHomeBase
CALLI4
ASGNI4
ADDRLP4 648
INDIRI4
CNSTI4 0
EQI4 $1049
ADDRLP4 652
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 652
INDIRP4
CNSTI4 356
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1051
ADDRLP4 652
INDIRP4
CNSTI4 360
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1049
LABELV $1051
ADDRFP4 0
INDIRP4
CNSTI4 7772
ADDP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 656
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 656
INDIRF4
CNSTF4 1202702336
GEF4 $1049
line 1943
;1940:				NearHomeBase(bs->cur_ps.persistant[PERS_TEAM], bs->origin, 9) &&
;1941:				(bs->cur_ps.powerups[PW_REDFLAG] || bs->cur_ps.powerups[PW_BLUEFLAG]) &&
;1942:				DistanceSquared(bs->lastenemyorigin, goal->origin) < 300*300
;1943:			) {
line 1944
;1944:				if (bs->rushbaseaway_time <= 0) bs->ltg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7244
ADDP4
INDIRF4
CNSTF4 0
GTF4 $1052
ADDRFP4 0
INDIRP4
CNSTI4 6088
ADDP4
CNSTF4 0
ASGNF4
LABELV $1052
line 1945
;1945:				bs->rushbaseaway_time = FloatTime() + 10;
ADDRFP4 0
INDIRP4
CNSTI4 7244
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1092616192
ADDF4
ASGNF4
line 1946
;1946:			}
LABELV $1049
LABELV $1048
line 1948
;1947:
;1948:			if (bs->rushbaseaway_time > 0) {
ADDRFP4 0
INDIRP4
CNSTI4 7244
ADDP4
INDIRF4
CNSTF4 0
LEF4 $1054
line 1950
;1949:				if (
;1950:					bs->rushbaseaway_time < FloatTime() ||
ADDRLP4 660
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 660
INDIRP4
CNSTI4 7244
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LTF4 $1058
ADDRLP4 660
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ARGI4
ADDRLP4 660
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
CNSTF4 1077936128
ARGF4
ADDRLP4 664
ADDRGP4 NearHomeBase
CALLI4
ASGNI4
ADDRLP4 664
INDIRI4
CNSTI4 0
NEI4 $1056
LABELV $1058
line 1952
;1951:					!NearHomeBase(bs->cur_ps.persistant[PERS_TEAM], bs->origin, 3)
;1952:				) bs->rushbaseaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7244
ADDP4
CNSTF4 0
ASGNF4
LABELV $1056
line 1953
;1953:				return BotGetItemLongTermGoal(bs, tfl, goal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 668
ADDRGP4 BotGetItemLongTermGoal
CALLI4
ASGNI4
ADDRLP4 668
INDIRI4
RETI4
ADDRGP4 $764
JUMPV
LABELV $1054
line 1961
;1954:			}
;1955:#endif
;1956:#if 0	// JUHOX: this ltg is also used for group leaders leading the flag carrier
;1957:			//if not carrying the flag anymore
;1958:			if (!BotCTFCarryingFlag(bs)) bs->ltgtype = 0;
;1959:#endif
;1960:			//quit rushing after 2 minutes
;1961:			if (bs->teamgoal_time < FloatTime()) bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11700
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $1059
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
LABELV $1059
line 1964
;1962:#if 1	// JUHOX: don't enforce to touch the goal if it's not there
;1963:			if (
;1964:				BotOwnFlagStatus(bs) != FLAG_ATBASE &&
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 660
ADDRGP4 BotOwnFlagStatus
CALLI4
ASGNI4
ADDRLP4 660
INDIRI4
CNSTI4 0
EQI4 $1061
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 664
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 664
INDIRF4
CNSTF4 1170735104
GEF4 $1061
line 1966
;1965:				DistanceSquared(bs->origin, goal->origin) < 80*80
;1966:			) {
line 1969
;1967:				//bs->rushbaseaway_time = FloatTime() + 3;
;1968:				//bs->ltg_time = 0;
;1969:				BotCheckIfBlockingTeammates(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCheckIfBlockingTeammates
CALLV
pop
line 1970
;1970:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $764
JUMPV
LABELV $1061
line 1974
;1971:			}
;1972:#endif
;1973:			//if touching the base flag the bot should loose the enemy flag
;1974:			if (trap_BotTouchingGoal(bs->origin, goal)) {
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 668
ADDRGP4 trap_BotTouchingGoal
CALLI4
ASGNI4
ADDRLP4 668
INDIRI4
CNSTI4 0
EQI4 $1063
line 1977
;1975:				//if the bot is still carrying the enemy flag then the
;1976:				//base flag is gone, now just walk near the base a bit
;1977:				if (BotCTFCarryingFlag(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 672
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 672
INDIRI4
CNSTI4 0
EQI4 $1065
line 1978
;1978:					trap_BotResetAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidReach
CALLV
pop
line 1983
;1979:#if 0	// JUHOX: just wait for the own flag returning
;1980:					bs->rushbaseaway_time = FloatTime() + 5 + 10 * random();
;1981:					//FIXME: add chat to tell the others to get back the flag
;1982:#else
;1983:					BotCheckIfBlockingTeammates(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCheckIfBlockingTeammates
CALLV
pop
line 1984
;1984:					return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $764
JUMPV
LABELV $1065
line 1987
;1985:#endif
;1986:				}
;1987:				else {
line 1988
;1988:					bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
line 1989
;1989:				}
line 1990
;1990:			}
LABELV $1063
line 1991
;1991:			BotAlternateRoute(bs, goal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 BotAlternateRoute
CALLP4
pop
line 1992
;1992:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $764
JUMPV
LABELV $1040
line 1995
;1993:		}
;1994:		//returning flag
;1995:		if (bs->ltgtype == LTG_RETURNFLAG) {
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 6
NEI4 $1067
line 2005
;1996:			//check for bot typing status message
;1997:#if 0	// JUHOX: no "returning flag" status message
;1998:			if (bs->teammessage_time && bs->teammessage_time < FloatTime()) {
;1999:				BotAI_BotInitialChat(bs, "returnflag_start", NULL);
;2000:				trap_BotEnterChat(bs->cs, 0, CHAT_TEAM);
;2001:				BotVoiceChatOnly(bs, -1, VOICECHAT_ONRETURNFLAG);
;2002:				bs->teammessage_time = 0;
;2003:			}
;2004:#else
;2005:			bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11696
ADDP4
CNSTF4 0
ASGNF4
line 2009
;2006:#endif
;2007:			//
;2008:#if BOTS_USE_TSS	// JUHOX: if tss is active, we should know the location
;2009:			if (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_isValid)) {
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 628
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 628
INDIRI4
CNSTI4 0
EQI4 $1069
line 2010
;2010:				if (bs->teamgoal_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 11700
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $1071
line 2011
;2011:					bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
line 2012
;2012:				}
LABELV $1071
line 2013
;2013:				if (LocateFlag(bs->cur_ps.persistant[PERS_TEAM], goal)) {
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ARGI4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 632
ADDRGP4 LocateFlag
CALLI4
ASGNI4
ADDRLP4 632
INDIRI4
CNSTI4 0
EQI4 $1073
line 2014
;2014:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $764
JUMPV
LABELV $1073
line 2016
;2015:				}
;2016:			}
LABELV $1069
line 2018
;2017:#endif
;2018:			switch(BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 636
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 632
ADDRLP4 636
INDIRI4
ASGNI4
ADDRLP4 632
INDIRI4
CNSTI4 1
EQI4 $1078
ADDRLP4 632
INDIRI4
CNSTI4 2
EQI4 $1079
ADDRGP4 $1075
JUMPV
LABELV $1078
line 2019
;2019:				case TEAM_RED: memcpy(goal, &ctf_blueflag, sizeof(bot_goal_t)); break;
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $1076
JUMPV
LABELV $1079
line 2020
;2020:				case TEAM_BLUE: memcpy(goal, &ctf_redflag, sizeof(bot_goal_t)); break;
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 ctf_redflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $1076
JUMPV
LABELV $1075
line 2021
;2021:				default: bs->ltgtype = 0; return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
CNSTI4 0
RETI4
ADDRGP4 $764
JUMPV
LABELV $1076
line 2024
;2022:			}
;2023:			//if touching the flag
;2024:			if (trap_BotTouchingGoal(bs->origin, goal)) bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 644
ADDRGP4 trap_BotTouchingGoal
CALLI4
ASGNI4
ADDRLP4 644
INDIRI4
CNSTI4 0
EQI4 $1080
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
LABELV $1080
line 2026
;2025:			//stop after 3 minutes
;2026:			if (bs->teamgoal_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 11700
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $1082
line 2027
;2027:				bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
line 2028
;2028:			}
LABELV $1082
line 2029
;2029:			BotAlternateRoute(bs, goal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 BotAlternateRoute
CALLP4
pop
line 2030
;2030:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $764
JUMPV
LABELV $1067
line 2032
;2031:		}
;2032:	}
LABELV $1022
line 2232
;2033:#endif //CTF
;2034:#ifdef MISSIONPACK
;2035:	else if (gametype == GT_1FCTF) {
;2036:		if (bs->ltgtype == LTG_GETFLAG) {
;2037:			//check for bot typing status message
;2038:			if (bs->teammessage_time && bs->teammessage_time < FloatTime()) {
;2039:				BotAI_BotInitialChat(bs, "captureflag_start", NULL);
;2040:				trap_BotEnterChat(bs->cs, 0, CHAT_TEAM);
;2041:				BotVoiceChatOnly(bs, -1, VOICECHAT_ONGETFLAG);
;2042:				bs->teammessage_time = 0;
;2043:			}
;2044:			memcpy(goal, &ctf_neutralflag, sizeof(bot_goal_t));
;2045:			//if touching the flag
;2046:			if (trap_BotTouchingGoal(bs->origin, goal)) {
;2047:				bs->ltgtype = 0;
;2048:			}
;2049:			//stop after 3 minutes
;2050:			if (bs->teamgoal_time < FloatTime()) {
;2051:				bs->ltgtype = 0;
;2052:			}
;2053:			return qtrue;
;2054:		}
;2055:		//if rushing to the base
;2056:		if (bs->ltgtype == LTG_RUSHBASE) {
;2057:			switch(BotTeam(bs)) {
;2058:				case TEAM_RED: memcpy(goal, &ctf_blueflag, sizeof(bot_goal_t)); break;
;2059:				case TEAM_BLUE: memcpy(goal, &ctf_redflag, sizeof(bot_goal_t)); break;
;2060:				default: bs->ltgtype = 0; return qfalse;
;2061:			}
;2062:			//if not carrying the flag anymore
;2063:			if (!Bot1FCTFCarryingFlag(bs)) {
;2064:				bs->ltgtype = 0;
;2065:			}
;2066:			//quit rushing after 2 minutes
;2067:			if (bs->teamgoal_time < FloatTime()) {
;2068:				bs->ltgtype = 0;
;2069:			}
;2070:			//if touching the base flag the bot should loose the enemy flag
;2071:			if (trap_BotTouchingGoal(bs->origin, goal)) {
;2072:				bs->ltgtype = 0;
;2073:			}
;2074:			BotAlternateRoute(bs, goal);
;2075:			return qtrue;
;2076:		}
;2077:		//attack the enemy base
;2078:		if (bs->ltgtype == LTG_ATTACKENEMYBASE &&
;2079:				bs->attackaway_time < FloatTime()) {
;2080:			//check for bot typing status message
;2081:			if (bs->teammessage_time && bs->teammessage_time < FloatTime()) {
;2082:				BotAI_BotInitialChat(bs, "attackenemybase_start", NULL);
;2083:				trap_BotEnterChat(bs->cs, 0, CHAT_TEAM);
;2084:				BotVoiceChatOnly(bs, -1, VOICECHAT_ONOFFENSE);
;2085:				bs->teammessage_time = 0;
;2086:			}
;2087:			switch(BotTeam(bs)) {
;2088:				case TEAM_RED: memcpy(goal, &ctf_blueflag, sizeof(bot_goal_t)); break;
;2089:				case TEAM_BLUE: memcpy(goal, &ctf_redflag, sizeof(bot_goal_t)); break;
;2090:				default: bs->ltgtype = 0; return qfalse;
;2091:			}
;2092:			//quit rushing after 2 minutes
;2093:			if (bs->teamgoal_time < FloatTime()) {
;2094:				bs->ltgtype = 0;
;2095:			}
;2096:			//if touching the base flag the bot should loose the enemy flag
;2097:			if (trap_BotTouchingGoal(bs->origin, goal)) {
;2098:				bs->attackaway_time = FloatTime() + 2 + 5 * random();
;2099:			}
;2100:			return qtrue;
;2101:		}
;2102:		//returning flag
;2103:		if (bs->ltgtype == LTG_RETURNFLAG) {
;2104:			//check for bot typing status message
;2105:			if (bs->teammessage_time && bs->teammessage_time < FloatTime()) {
;2106:				BotAI_BotInitialChat(bs, "returnflag_start", NULL);
;2107:				trap_BotEnterChat(bs->cs, 0, CHAT_TEAM);
;2108:				BotVoiceChatOnly(bs, -1, VOICECHAT_ONRETURNFLAG);
;2109:				bs->teammessage_time = 0;
;2110:			}
;2111:			//
;2112:			if (bs->teamgoal_time < FloatTime()) {
;2113:				bs->ltgtype = 0;
;2114:			}
;2115:			//just roam around
;2116:			return BotGetItemLongTermGoal(bs, tfl, goal);
;2117:		}
;2118:	}
;2119:	else if (gametype == GT_OBELISK) {
;2120:		if (bs->ltgtype == LTG_ATTACKENEMYBASE &&
;2121:				bs->attackaway_time < FloatTime()) {
;2122:
;2123:			//check for bot typing status message
;2124:			if (bs->teammessage_time && bs->teammessage_time < FloatTime()) {
;2125:				BotAI_BotInitialChat(bs, "attackenemybase_start", NULL);
;2126:				trap_BotEnterChat(bs->cs, 0, CHAT_TEAM);
;2127:				BotVoiceChatOnly(bs, -1, VOICECHAT_ONOFFENSE);
;2128:				bs->teammessage_time = 0;
;2129:			}
;2130:			switch(BotTeam(bs)) {
;2131:				case TEAM_RED: memcpy(goal, &blueobelisk, sizeof(bot_goal_t)); break;
;2132:				case TEAM_BLUE: memcpy(goal, &redobelisk, sizeof(bot_goal_t)); break;
;2133:				default: bs->ltgtype = 0; return qfalse;
;2134:			}
;2135:			//if the bot no longer wants to attack the obelisk
;2136:			if (BotFeelingBad(bs) > 50) {
;2137:				return BotGetItemLongTermGoal(bs, tfl, goal);
;2138:			}
;2139:			//if touching the obelisk
;2140:			if (trap_BotTouchingGoal(bs->origin, goal)) {
;2141:				bs->attackaway_time = FloatTime() + 3 + 5 * random();
;2142:			}
;2143:			// or very close to the obelisk
;2144:			VectorSubtract(bs->origin, goal->origin, dir);
;2145:			if (VectorLengthSquared(dir) < Square(60)) {
;2146:				bs->attackaway_time = FloatTime() + 3 + 5 * random();
;2147:			}
;2148:			//quit rushing after 2 minutes
;2149:			if (bs->teamgoal_time < FloatTime()) {
;2150:				bs->ltgtype = 0;
;2151:			}
;2152:			BotAlternateRoute(bs, goal);
;2153:			//just move towards the obelisk
;2154:			return qtrue;
;2155:		}
;2156:	}
;2157:	else if (gametype == GT_HARVESTER) {
;2158:		//if rushing to the base
;2159:		if (bs->ltgtype == LTG_RUSHBASE) {
;2160:			switch(BotTeam(bs)) {
;2161:				case TEAM_RED: memcpy(goal, &blueobelisk, sizeof(bot_goal_t)); break;
;2162:				case TEAM_BLUE: memcpy(goal, &redobelisk, sizeof(bot_goal_t)); break;
;2163:				default: BotGoHarvest(bs); return qfalse;
;2164:			}
;2165:			//if not carrying any cubes
;2166:			if (!BotHarvesterCarryingCubes(bs)) {
;2167:				BotGoHarvest(bs);
;2168:				return qfalse;
;2169:			}
;2170:			//quit rushing after 2 minutes
;2171:			if (bs->teamgoal_time < FloatTime()) {
;2172:				BotGoHarvest(bs);
;2173:				return qfalse;
;2174:			}
;2175:			//if touching the base flag the bot should loose the enemy flag
;2176:			if (trap_BotTouchingGoal(bs->origin, goal)) {
;2177:				BotGoHarvest(bs);
;2178:				return qfalse;
;2179:			}
;2180:			BotAlternateRoute(bs, goal);
;2181:			return qtrue;
;2182:		}
;2183:		//attack the enemy base
;2184:		if (bs->ltgtype == LTG_ATTACKENEMYBASE &&
;2185:				bs->attackaway_time < FloatTime()) {
;2186:			//check for bot typing status message
;2187:			if (bs->teammessage_time && bs->teammessage_time < FloatTime()) {
;2188:				BotAI_BotInitialChat(bs, "attackenemybase_start", NULL);
;2189:				trap_BotEnterChat(bs->cs, 0, CHAT_TEAM);
;2190:				BotVoiceChatOnly(bs, -1, VOICECHAT_ONOFFENSE);
;2191:				bs->teammessage_time = 0;
;2192:			}
;2193:			switch(BotTeam(bs)) {
;2194:				case TEAM_RED: memcpy(goal, &blueobelisk, sizeof(bot_goal_t)); break;
;2195:				case TEAM_BLUE: memcpy(goal, &redobelisk, sizeof(bot_goal_t)); break;
;2196:				default: bs->ltgtype = 0; return qfalse;
;2197:			}
;2198:			//quit rushing after 2 minutes
;2199:			if (bs->teamgoal_time < FloatTime()) {
;2200:				bs->ltgtype = 0;
;2201:			}
;2202:			//if touching the base flag the bot should loose the enemy flag
;2203:			if (trap_BotTouchingGoal(bs->origin, goal)) {
;2204:				bs->attackaway_time = FloatTime() + 2 + 5 * random();
;2205:			}
;2206:			return qtrue;
;2207:		}
;2208:		//harvest cubes
;2209:		if (bs->ltgtype == LTG_HARVEST &&
;2210:			bs->harvestaway_time < FloatTime()) {
;2211:			//check for bot typing status message
;2212:			if (bs->teammessage_time && bs->teammessage_time < FloatTime()) {
;2213:				BotAI_BotInitialChat(bs, "harvest_start", NULL);
;2214:				trap_BotEnterChat(bs->cs, 0, CHAT_TEAM);
;2215:				BotVoiceChatOnly(bs, -1, VOICECHAT_ONOFFENSE);
;2216:				bs->teammessage_time = 0;
;2217:			}
;2218:			memcpy(goal, &neutralobelisk, sizeof(bot_goal_t));
;2219:			//
;2220:			if (bs->teamgoal_time < FloatTime()) {
;2221:				bs->ltgtype = 0;
;2222:			}
;2223:			//
;2224:			if (trap_BotTouchingGoal(bs->origin, goal)) {
;2225:				bs->harvestaway_time = FloatTime() + 4 + 3 * random();
;2226:			}
;2227:			return qtrue;
;2228:		}
;2229:	}
;2230:#endif
;2231:	//normal goal stuff
;2232:	return BotGetItemLongTermGoal(bs, tfl, goal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 628
ADDRGP4 BotGetItemLongTermGoal
CALLI4
ASGNI4
ADDRLP4 628
INDIRI4
RETI4
LABELV $764
endproc BotGetLongTermGoal 1120 16
export BotLongTermGoal
proc BotLongTermGoal 448 16
line 2240
;2233:}
;2234:
;2235:/*
;2236:==================
;2237:BotLongTermGoal
;2238:==================
;2239:*/
;2240:int BotLongTermGoal(bot_state_t *bs, int tfl, int retreat, bot_goal_t *goal) {
line 2250
;2241:	aas_entityinfo_t entinfo;
;2242:	char teammate[MAX_MESSAGE_SIZE];
;2243:	float squaredist;
;2244:	int areanum;
;2245:	vec3_t dir;
;2246:
;2247:	//FIXME: also have air long term goals?
;2248:	//
;2249:	//if the bot is leading someone and not retreating
;2250:	if (bs->lead_time > 0 && !retreat) {
ADDRFP4 0
INDIRP4
CNSTI4 11844
ADDP4
INDIRF4
CNSTF4 0
LEF4 $1085
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $1085
line 2251
;2251:		if (bs->lead_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 11844
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $1087
line 2252
;2252:			BotAI_BotInitialChat(bs, "lead_stop", EasyClientName(bs->lead_teammate, teammate, sizeof(teammate)), NULL);
ADDRFP4 0
INDIRP4
CNSTI4 11784
ADDP4
INDIRI4
ARGI4
ADDRLP4 152
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 416
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1089
ARGP4
ADDRLP4 416
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 2253
;2253:			trap_BotEnterChat(bs->cs, bs->teammate, CHAT_TELL);
ADDRLP4 420
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 420
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRLP4 420
INDIRP4
CNSTI4 11560
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 2254
;2254:			bs->lead_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11844
ADDP4
CNSTF4 0
ASGNF4
line 2255
;2255:			return BotGetLongTermGoal(bs, tfl, retreat, goal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 424
ADDRGP4 BotGetLongTermGoal
CALLI4
ASGNI4
ADDRLP4 424
INDIRI4
RETI4
ADDRGP4 $1084
JUMPV
LABELV $1087
line 2258
;2256:		}
;2257:		//
;2258:		if (bs->leadmessage_time < 0 && -bs->leadmessage_time < FloatTime()) {
ADDRLP4 416
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 416
INDIRP4
CNSTI4 11852
ADDP4
INDIRF4
CNSTF4 0
GEF4 $1090
ADDRLP4 416
INDIRP4
CNSTI4 11852
ADDP4
INDIRF4
NEGF4
ADDRGP4 floattime
INDIRF4
GEF4 $1090
line 2259
;2259:			BotAI_BotInitialChat(bs, "followme", EasyClientName(bs->lead_teammate, teammate, sizeof(teammate)), NULL);
ADDRFP4 0
INDIRP4
CNSTI4 11784
ADDP4
INDIRI4
ARGI4
ADDRLP4 152
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 420
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1092
ARGP4
ADDRLP4 420
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 2260
;2260:			trap_BotEnterChat(bs->cs, bs->teammate, CHAT_TELL);
ADDRLP4 424
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 424
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRLP4 424
INDIRP4
CNSTI4 11560
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 2261
;2261:			bs->leadmessage_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 11852
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2262
;2262:		}
LABELV $1090
line 2264
;2263:		//get entity information of the companion
;2264:		BotEntityInfo(bs->lead_teammate, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 11784
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 2266
;2265:		//
;2266:		if (entinfo.valid) {
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $1093
line 2267
;2267:			areanum = BotPointAreaNum(entinfo.origin);
ADDRLP4 12+24
ARGP4
ADDRLP4 420
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 412
ADDRLP4 420
INDIRI4
ASGNI4
line 2268
;2268:			if (areanum && trap_AAS_AreaReachability(areanum)) {
ADDRLP4 424
ADDRLP4 412
INDIRI4
ASGNI4
ADDRLP4 424
INDIRI4
CNSTI4 0
EQI4 $1096
ADDRLP4 424
INDIRI4
ARGI4
ADDRLP4 428
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 428
INDIRI4
CNSTI4 0
EQI4 $1096
line 2270
;2269:				//update team goal
;2270:				bs->lead_teamgoal.entitynum = bs->lead_teammate;
ADDRLP4 432
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 432
INDIRP4
CNSTI4 11828
ADDP4
ADDRLP4 432
INDIRP4
CNSTI4 11784
ADDP4
INDIRI4
ASGNI4
line 2271
;2271:				bs->lead_teamgoal.areanum = areanum;
ADDRFP4 0
INDIRP4
CNSTI4 11800
ADDP4
ADDRLP4 412
INDIRI4
ASGNI4
line 2272
;2272:				VectorCopy(entinfo.origin, bs->lead_teamgoal.origin);
ADDRFP4 0
INDIRP4
CNSTI4 11788
ADDP4
ADDRLP4 12+24
INDIRB
ASGNB 12
line 2273
;2273:				VectorSet(bs->lead_teamgoal.mins, -8, -8, -8);
ADDRFP4 0
INDIRP4
CNSTI4 11804
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 11808
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 11812
ADDP4
CNSTF4 3238002688
ASGNF4
line 2274
;2274:				VectorSet(bs->lead_teamgoal.maxs, 8, 8, 8);
ADDRFP4 0
INDIRP4
CNSTI4 11816
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 11820
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 11824
ADDP4
CNSTF4 1090519040
ASGNF4
line 2275
;2275:			}
LABELV $1096
line 2276
;2276:		}
LABELV $1093
line 2278
;2277:		//if the team mate is visible
;2278:		if (BotEntityVisible(&bs->cur_ps/*bs->entitynum, bs->eye, bs->viewangles*/, 360, bs->lead_teammate)) {	// JUHOX
ADDRLP4 420
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 420
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 420
INDIRP4
CNSTI4 11784
ADDP4
INDIRI4
ARGI4
ADDRLP4 424
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 424
INDIRF4
CNSTF4 0
EQF4 $1099
line 2279
;2279:			bs->leadvisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 11848
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2280
;2280:		}
LABELV $1099
line 2282
;2281:		//if the team mate is not visible for 1 seconds
;2282:		if (bs->leadvisible_time < FloatTime() - 1) {
ADDRFP4 0
INDIRP4
CNSTI4 11848
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
SUBF4
GEF4 $1101
line 2283
;2283:			bs->leadbackup_time = FloatTime() + 2;
ADDRFP4 0
INDIRP4
CNSTI4 11856
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
ADDF4
ASGNF4
line 2284
;2284:		}
LABELV $1101
line 2286
;2285:		//distance towards the team mate
;2286:		VectorSubtract(bs->origin, bs->lead_teamgoal.origin, dir);
ADDRLP4 428
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 428
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRLP4 428
INDIRP4
CNSTI4 11788
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 428
INDIRP4
CNSTI4 4920
ADDP4
INDIRF4
ADDRLP4 428
INDIRP4
CNSTI4 11792
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 432
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 432
INDIRP4
CNSTI4 4924
ADDP4
INDIRF4
ADDRLP4 432
INDIRP4
CNSTI4 11796
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2287
;2287:		squaredist = VectorLengthSquared(dir);
ADDRLP4 0
ARGP4
ADDRLP4 436
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 408
ADDRLP4 436
INDIRF4
ASGNF4
line 2289
;2288:		//if backing up towards the team mate
;2289:		if (bs->leadbackup_time > FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 11856
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $1105
line 2290
;2290:			if (bs->leadmessage_time < FloatTime() - 20) {
ADDRFP4 0
INDIRP4
CNSTI4 11852
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1101004800
SUBF4
GEF4 $1107
line 2291
;2291:				BotAI_BotInitialChat(bs, "followme", EasyClientName(bs->lead_teammate, teammate, sizeof(teammate)), NULL);
ADDRFP4 0
INDIRP4
CNSTI4 11784
ADDP4
INDIRI4
ARGI4
ADDRLP4 152
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 440
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1092
ARGP4
ADDRLP4 440
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 2292
;2292:				trap_BotEnterChat(bs->cs, bs->teammate, CHAT_TELL);
ADDRLP4 444
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 444
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRLP4 444
INDIRP4
CNSTI4 11560
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 2293
;2293:				bs->leadmessage_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 11852
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2294
;2294:			}
LABELV $1107
line 2296
;2295:			//if very close to the team mate
;2296:			if (squaredist < Square(100)) {
ADDRLP4 408
INDIRF4
CNSTF4 1176256512
GEF4 $1109
line 2297
;2297:				bs->leadbackup_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11856
ADDP4
CNSTF4 0
ASGNF4
line 2298
;2298:			}
LABELV $1109
line 2300
;2299:			//the bot should go back to the team mate
;2300:			memcpy(goal, &bs->lead_teamgoal, sizeof(bot_goal_t));
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 11788
ADDP4
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2301
;2301:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1084
JUMPV
LABELV $1105
line 2303
;2302:		}
;2303:		else {
line 2305
;2304:			//if quite distant from the team mate
;2305:			if (squaredist > Square(500)) {
ADDRLP4 408
INDIRF4
CNSTF4 1215570944
LEF4 $1111
line 2306
;2306:				if (bs->leadmessage_time < FloatTime() - 20) {
ADDRFP4 0
INDIRP4
CNSTI4 11852
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1101004800
SUBF4
GEF4 $1113
line 2307
;2307:					BotAI_BotInitialChat(bs, "followme", EasyClientName(bs->lead_teammate, teammate, sizeof(teammate)), NULL);
ADDRFP4 0
INDIRP4
CNSTI4 11784
ADDP4
INDIRI4
ARGI4
ADDRLP4 152
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 440
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1092
ARGP4
ADDRLP4 440
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 2308
;2308:					trap_BotEnterChat(bs->cs, bs->teammate, CHAT_TELL);
ADDRLP4 444
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 444
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRLP4 444
INDIRP4
CNSTI4 11560
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 2309
;2309:					bs->leadmessage_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 11852
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2310
;2310:				}
LABELV $1113
line 2312
;2311:				//look at the team mate
;2312:				VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 440
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 12+24
INDIRF4
ADDRLP4 440
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 12+24+4
INDIRF4
ADDRLP4 440
INDIRP4
CNSTI4 4920
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 12+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2313
;2313:				vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 7852
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2314
;2314:				bs->ideal_viewangles[2] *= 0.5;
ADDRLP4 444
ADDRFP4 0
INDIRP4
CNSTI4 7860
ADDP4
ASGNP4
ADDRLP4 444
INDIRP4
ADDRLP4 444
INDIRP4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 2316
;2315:				//just wait for the team mate
;2316:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1084
JUMPV
LABELV $1111
line 2318
;2317:			}
;2318:		}
line 2319
;2319:	}
LABELV $1085
line 2324
;2320:	// JUHOX: update the teamgoal
;2321:#if 0
;2322:	return BotGetLongTermGoal(bs, tfl, retreat, goal);
;2323:#else
;2324:	if (BotGetLongTermGoal(bs, tfl, retreat, goal)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 416
ADDRGP4 BotGetLongTermGoal
CALLI4
ASGNI4
ADDRLP4 416
INDIRI4
CNSTI4 0
EQI4 $1122
line 2325
;2325:		if (bs->ltgtype != 0) memcpy(&bs->teamgoal, goal, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1124
ADDRFP4 0
INDIRP4
CNSTI4 11580
ADDP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
LABELV $1124
line 2326
;2326:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1084
JUMPV
LABELV $1122
line 2328
;2327:	}
;2328:	return qfalse;
CNSTI4 0
RETI4
LABELV $1084
endproc BotLongTermGoal 448 16
export AIEnter_Intermission
proc AIEnter_Intermission 8 16
line 2337
;2329:#endif
;2330:}
;2331:
;2332:/*
;2333:==================
;2334:AIEnter_Intermission
;2335:==================
;2336:*/
;2337:void AIEnter_Intermission(bot_state_t *bs, char *s) {
line 2338
;2338:	BotRecordNodeSwitch(bs, "intermission", "", s);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1127
ARGP4
ADDRGP4 $99
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotRecordNodeSwitch
CALLV
pop
line 2340
;2339:	//reset the bot state
;2340:	BotResetState(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotResetState
CALLV
pop
line 2342
;2341:	//check for end level chat
;2342:	if (BotChat_EndLevel(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotChat_EndLevel
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1128
line 2343
;2343:		trap_BotEnterChat(bs->cs, 0, bs->chatto);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 6072
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 2344
;2344:	}
LABELV $1128
line 2345
;2345:	bs->ainode = AINode_Intermission;
ADDRFP4 0
INDIRP4
CNSTI4 4904
ADDP4
ADDRGP4 AINode_Intermission
ASGNP4
line 2346
;2346:}
LABELV $1126
endproc AIEnter_Intermission 8 16
export AINode_Intermission
proc AINode_Intermission 16 8
line 2353
;2347:
;2348:/*
;2349:==================
;2350:AINode_Intermission
;2351:==================
;2352:*/
;2353:int AINode_Intermission(bot_state_t *bs) {
line 2355
;2354:	//if the intermission ended
;2355:	if (!BotIntermission(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotIntermission
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1131
line 2356
;2356:		if (BotChat_StartLevel(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 BotChat_StartLevel
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $1133
line 2357
;2357:			bs->stand_time = FloatTime() + BotChatTime(bs);
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 BotChatTime
CALLF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 7188
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ASGNF4
line 2358
;2358:		}
ADDRGP4 $1134
JUMPV
LABELV $1133
line 2359
;2359:		else {
line 2360
;2360:			bs->stand_time = FloatTime() + 2;
ADDRFP4 0
INDIRP4
CNSTI4 7188
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
ADDF4
ASGNF4
line 2361
;2361:		}
LABELV $1134
line 2362
;2362:		AIEnter_Stand(bs, "intermission: chat");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1135
ARGP4
ADDRGP4 AIEnter_Stand
CALLV
pop
line 2363
;2363:	}
LABELV $1131
line 2364
;2364:	return qtrue;
CNSTI4 1
RETI4
LABELV $1130
endproc AINode_Intermission 16 8
export AIEnter_Observer
proc AIEnter_Observer 0 16
line 2372
;2365:}
;2366:
;2367:/*
;2368:==================
;2369:AIEnter_Observer
;2370:==================
;2371:*/
;2372:void AIEnter_Observer(bot_state_t *bs, char *s) {
line 2373
;2373:	BotRecordNodeSwitch(bs, "observer", "", s);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1137
ARGP4
ADDRGP4 $99
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotRecordNodeSwitch
CALLV
pop
line 2375
;2374:	//reset the bot state
;2375:	BotResetState(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotResetState
CALLV
pop
line 2376
;2376:	bs->ainode = AINode_Observer;
ADDRFP4 0
INDIRP4
CNSTI4 4904
ADDP4
ADDRGP4 AINode_Observer
ASGNP4
line 2377
;2377:}
LABELV $1136
endproc AIEnter_Observer 0 16
export AINode_Observer
proc AINode_Observer 4 8
line 2384
;2378:
;2379:/*
;2380:==================
;2381:AINode_Observer
;2382:==================
;2383:*/
;2384:int AINode_Observer(bot_state_t *bs) {
line 2386
;2385:	//if the bot left observer mode
;2386:	if (!BotIsObserver(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotIsObserver
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1139
line 2387
;2387:		AIEnter_Stand(bs, "observer: left observer");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1141
ARGP4
ADDRGP4 AIEnter_Stand
CALLV
pop
line 2388
;2388:	}
LABELV $1139
line 2389
;2389:	return qtrue;
CNSTI4 1
RETI4
LABELV $1138
endproc AINode_Observer 4 8
export AIEnter_Stand
proc AIEnter_Stand 0 16
line 2397
;2390:}
;2391:
;2392:/*
;2393:==================
;2394:AIEnter_Stand
;2395:==================
;2396:*/
;2397:void AIEnter_Stand(bot_state_t *bs, char *s) {
line 2398
;2398:	BotRecordNodeSwitch(bs, "stand", "", s);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1143
ARGP4
ADDRGP4 $99
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotRecordNodeSwitch
CALLV
pop
line 2399
;2399:	bs->standfindenemy_time = FloatTime() + 1;
ADDRFP4 0
INDIRP4
CNSTI4 7204
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2400
;2400:	bs->ainode = AINode_Stand;
ADDRFP4 0
INDIRP4
CNSTI4 4904
ADDP4
ADDRGP4 AINode_Stand
ASGNP4
line 2401
;2401:}
LABELV $1142
endproc AIEnter_Stand 0 16
export AINode_Stand
proc AINode_Stand 24 12
line 2408
;2402:
;2403:/*
;2404:==================
;2405:AINode_Stand
;2406:==================
;2407:*/
;2408:int AINode_Stand(bot_state_t *bs) {
line 2411
;2409:
;2410:	//if the bot's health decreased
;2411:	if (bs->lastframe_health > bs->inventory[INVENTORY_HEALTH]) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 6064
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 5076
ADDP4
INDIRI4
LEI4 $1145
line 2412
;2412:		if (BotChat_HitTalking(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 BotChat_HitTalking
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $1147
line 2413
;2413:			bs->standfindenemy_time = FloatTime() + BotChatTime(bs) + 0.1;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 BotChatTime
CALLF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 7204
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2414
;2414:			bs->stand_time = FloatTime() + BotChatTime(bs) + 0.1;
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 BotChatTime
CALLF4
ASGNF4
ADDRLP4 16
INDIRP4
CNSTI4 7188
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 20
INDIRF4
ADDF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2415
;2415:		}
LABELV $1147
line 2416
;2416:	}
LABELV $1145
line 2417
;2417:	if (bs->standfindenemy_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 7204
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $1149
line 2418
;2418:		if (BotFindEnemy(bs, -1)) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 4
ADDRGP4 BotFindEnemy
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $1151
line 2419
;2419:			AIEnter_Battle_Fight(bs, "stand: found enemy");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1153
ARGP4
ADDRGP4 AIEnter_Battle_Fight
CALLV
pop
line 2420
;2420:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1144
JUMPV
LABELV $1151
line 2422
;2421:		}
;2422:		bs->standfindenemy_time = FloatTime() + 1;
ADDRFP4 0
INDIRP4
CNSTI4 7204
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2423
;2423:	}
LABELV $1149
line 2425
;2424:	// put up chat icon
;2425:	trap_EA_Talk(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Talk
CALLV
pop
line 2427
;2426:	// when done standing
;2427:	if (bs->stand_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 7188
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $1154
line 2428
;2428:		trap_BotEnterChat(bs->cs, 0, bs->chatto);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 6072
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 2429
;2429:		AIEnter_Seek_LTG(bs, "stand: time out");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1156
ARGP4
ADDRGP4 AIEnter_Seek_LTG
CALLV
pop
line 2430
;2430:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1144
JUMPV
LABELV $1154
line 2433
;2431:	}
;2432:	//
;2433:	return qtrue;
CNSTI4 1
RETI4
LABELV $1144
endproc AINode_Stand 24 12
export AIEnter_Respawn
proc AIEnter_Respawn 0 16
line 2441
;2434:}
;2435:
;2436:/*
;2437:==================
;2438:AIEnter_Respawn
;2439:==================
;2440:*/
;2441:void AIEnter_Respawn(bot_state_t *bs, char *s) {
line 2442
;2442:	BotRecordNodeSwitch(bs, "respawn", "", s);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1158
ARGP4
ADDRGP4 $99
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotRecordNodeSwitch
CALLV
pop
line 2444
;2443:	//reset some states
;2444:	trap_BotResetMoveState(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetMoveState
CALLV
pop
line 2445
;2445:	trap_BotResetGoalState(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetGoalState
CALLV
pop
line 2446
;2446:	trap_BotResetAvoidGoals(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidGoals
CALLV
pop
line 2447
;2447:	trap_BotResetAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidReach
CALLV
pop
line 2459
;2448:	//if the bot wants to chat
;2449:#if 0	// JUHOX: no unnecessary chats please
;2450:	if (BotChat_Death(bs)) {
;2451:		bs->respawn_time = FloatTime() + BotChatTime(bs);
;2452:		bs->respawnchat_time = FloatTime();
;2453:	}
;2454:	else {
;2455:		bs->respawn_time = FloatTime() + 1 + random();
;2456:		bs->respawnchat_time = 0;
;2457:	}
;2458:#else
;2459:	bs->respawn_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7152
ADDP4
CNSTF4 0
ASGNF4
line 2460
;2460:	bs->respawnchat_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7156
ADDP4
CNSTF4 0
ASGNF4
line 2461
;2461:	bs->lastKilled_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6004
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2464
;2462:#endif
;2463:	//set respawn state
;2464:	bs->respawn_wait = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 5996
ADDP4
CNSTI4 0
ASGNI4
line 2465
;2465:	bs->ainode = AINode_Respawn;
ADDRFP4 0
INDIRP4
CNSTI4 4904
ADDP4
ADDRGP4 AINode_Respawn
ASGNP4
line 2466
;2466:}
LABELV $1157
endproc AIEnter_Respawn 0 16
export AINode_Respawn
proc AINode_Respawn 32 12
line 2473
;2467:
;2468:/*
;2469:==================
;2470:AINode_Respawn
;2471:==================
;2472:*/
;2473:int AINode_Respawn(bot_state_t *bs) {
line 2475
;2474:	// if waiting for the actual respawn
;2475:	if (bs->respawn_wait) {
ADDRFP4 0
INDIRP4
CNSTI4 5996
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1160
line 2476
;2476:		if (!BotIsDead(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotIsDead
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1162
line 2477
;2477:			AIEnter_Seek_LTG(bs, "respawn: respawned");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1164
ARGP4
ADDRGP4 AIEnter_Seek_LTG
CALLV
pop
line 2478
;2478:			bs->lastRespawn_time = FloatTime();	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2479
;2479:		}
ADDRGP4 $1161
JUMPV
LABELV $1162
line 2480
;2480:		else {
line 2485
;2481:#if !RESPAWN_DELAY	// JUHOX: do not try to respawn
;2482:			trap_EA_Respawn(bs->client);
;2483:#else
;2484:			if (
;2485:				bs->lastKilled_time - bs->lastRespawn_time < 5 ||
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 6004
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 6000
ADDP4
INDIRF4
SUBF4
CNSTF4 1084227584
LTF4 $1170
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BotEnemyTooStrong
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $1170
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $1161
ADDRGP4 g_respawnAtPOD+12
INDIRI4
CNSTI4 0
EQI4 $1161
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRLP4 16
ADDRGP4 NearHomeBase
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $1161
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 Team_GetFlagStatus
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $1161
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 OtherTeam
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 Team_GetFlagStatus
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 1
NEI4 $1161
LABELV $1170
line 2494
;2486:				BotEnemyTooStrong(bs) ||
;2487:				(
;2488:					g_gametype.integer == GT_CTF &&
;2489:					g_respawnAtPOD.integer &&
;2490:					!NearHomeBase(bs->cur_ps.persistant[PERS_TEAM], bs->origin, 1) &&
;2491:					Team_GetFlagStatus(bs->cur_ps.persistant[PERS_TEAM]) == FLAG_ATBASE &&
;2492:					Team_GetFlagStatus(OtherTeam(bs->cur_ps.persistant[PERS_TEAM])) == FLAG_TAKEN
;2493:				)
;2494:			) {
line 2495
;2495:				trap_EA_Respawn(bs->client);	// respawn normally
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Respawn
CALLV
pop
line 2496
;2496:			}
line 2498
;2497:#endif
;2498:		}
line 2499
;2499:	}
ADDRGP4 $1161
JUMPV
LABELV $1160
line 2500
;2500:	else if (bs->respawn_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 7152
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $1171
line 2502
;2501:		// wait until respawned
;2502:		bs->respawn_wait = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 5996
ADDP4
CNSTI4 1
ASGNI4
line 2504
;2503:		// elementary action respawn
;2504:		trap_EA_Respawn(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Respawn
CALLV
pop
line 2506
;2505:		//
;2506:		if (bs->respawnchat_time) {
ADDRFP4 0
INDIRP4
CNSTI4 7156
ADDP4
INDIRF4
CNSTF4 0
EQF4 $1173
line 2507
;2507:			trap_BotEnterChat(bs->cs, 0, bs->chatto);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 6072
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 2508
;2508:			bs->enemy = -1;
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
CNSTI4 -1
ASGNI4
line 2509
;2509:		}
LABELV $1173
line 2510
;2510:	}
LABELV $1171
LABELV $1161
line 2511
;2511:	if (bs->respawnchat_time && bs->respawnchat_time < FloatTime() - 0.5) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 7156
ADDP4
INDIRF4
CNSTF4 0
EQF4 $1175
ADDRLP4 0
INDIRP4
CNSTI4 7156
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1056964608
SUBF4
GEF4 $1175
line 2512
;2512:		trap_EA_Talk(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Talk
CALLV
pop
line 2513
;2513:	}
LABELV $1175
line 2515
;2514:	//
;2515:	return qtrue;
CNSTI4 1
RETI4
LABELV $1159
endproc AINode_Respawn 32 12
export BotSelectActivateWeapon
proc BotSelectActivateWeapon 28 0
line 2523
;2516:}
;2517:
;2518:/*
;2519:==================
;2520:BotSelectActivateWeapon
;2521:==================
;2522:*/
;2523:int BotSelectActivateWeapon(bot_state_t *bs) {
line 2525
;2524:	//
;2525:	if (bs->inventory[INVENTORY_MACHINEGUN] > 0 && bs->inventory[INVENTORY_BULLETS] > 0)
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 4984
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1178
ADDRLP4 0
INDIRP4
CNSTI4 5036
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1178
line 2526
;2526:		return WEAPONINDEX_MACHINEGUN;
CNSTI4 2
RETI4
ADDRGP4 $1177
JUMPV
LABELV $1178
line 2527
;2527:	else if (bs->inventory[INVENTORY_SHOTGUN] > 0 && bs->inventory[INVENTORY_SHELLS] > 0)
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 4980
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1180
ADDRLP4 4
INDIRP4
CNSTI4 5032
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1180
line 2528
;2528:		return WEAPONINDEX_SHOTGUN;
CNSTI4 3
RETI4
ADDRGP4 $1177
JUMPV
LABELV $1180
line 2529
;2529:	else if (bs->inventory[INVENTORY_PLASMAGUN] > 0 && bs->inventory[INVENTORY_CELLS] > 0)
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 5004
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1182
ADDRLP4 8
INDIRP4
CNSTI4 5044
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1182
line 2530
;2530:		return WEAPONINDEX_PLASMAGUN;
CNSTI4 8
RETI4
ADDRGP4 $1177
JUMPV
LABELV $1182
line 2531
;2531:	else if (bs->inventory[INVENTORY_LIGHTNING] > 0 && bs->inventory[INVENTORY_LIGHTNINGAMMO] > 0)
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 4996
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1184
ADDRLP4 12
INDIRP4
CNSTI4 5048
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1184
line 2532
;2532:		return WEAPONINDEX_LIGHTNING;
CNSTI4 6
RETI4
ADDRGP4 $1177
JUMPV
LABELV $1184
line 2539
;2533:#ifdef MISSIONPACK
;2534:	else if (bs->inventory[INVENTORY_CHAINGUN] > 0 && bs->inventory[INVENTORY_BELT] > 0)
;2535:		return WEAPONINDEX_CHAINGUN;
;2536:	else if (bs->inventory[INVENTORY_NAILGUN] > 0 && bs->inventory[INVENTORY_NAILS] > 0)
;2537:		return WEAPONINDEX_NAILGUN;
;2538:#endif
;2539:	else if (bs->inventory[INVENTORY_RAILGUN] > 0 && bs->inventory[INVENTORY_SLUGS] > 0)
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 5000
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1186
ADDRLP4 16
INDIRP4
CNSTI4 5056
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1186
line 2540
;2540:		return WEAPONINDEX_RAILGUN;
CNSTI4 7
RETI4
ADDRGP4 $1177
JUMPV
LABELV $1186
line 2541
;2541:	else if (bs->inventory[INVENTORY_ROCKETLAUNCHER] > 0 && bs->inventory[INVENTORY_ROCKETS] > 0)
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 4992
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1188
ADDRLP4 20
INDIRP4
CNSTI4 5052
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1188
line 2542
;2542:		return WEAPONINDEX_ROCKET_LAUNCHER;
CNSTI4 5
RETI4
ADDRGP4 $1177
JUMPV
LABELV $1188
line 2543
;2543:	else if (bs->inventory[INVENTORY_BFG10K] > 0 && bs->inventory[INVENTORY_BFGAMMO] > 0)
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 5012
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1190
ADDRLP4 24
INDIRP4
CNSTI4 5060
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1190
line 2544
;2544:		return WEAPONINDEX_BFG;
CNSTI4 9
RETI4
ADDRGP4 $1177
JUMPV
LABELV $1190
line 2545
;2545:	else {
line 2546
;2546:		return -1;
CNSTI4 -1
RETI4
LABELV $1177
endproc BotSelectActivateWeapon 28 0
export BotClearPath
proc BotClearPath 360 28
line 2557
;2547:	}
;2548:}
;2549:
;2550:/*
;2551:==================
;2552:BotClearPath
;2553:
;2554: try to deactivate obstacles like proximity mines on the bot's path
;2555:==================
;2556:*/
;2557:void BotClearPath(bot_state_t *bs, bot_moveresult_t *moveresult) {
line 2565
;2558:	int i, bestmine;
;2559:	float dist, bestdist;
;2560:	vec3_t target, dir;
;2561:	bsp_trace_t bsptrace;
;2562:	entityState_t state;
;2563:
;2564:	// if there is a dead body wearing kamikze nearby
;2565:	if (bs->kamikazebody) {
ADDRFP4 0
INDIRP4
CNSTI4 7456
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1193
line 2567
;2566:		// if the bot's view angles and weapon are not used for movement
;2567:		if ( !(moveresult->flags & (MOVERESULT_MOVEMENTVIEW | MOVERESULT_MOVEMENTWEAPON)) ) {
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 17
BANDI4
CNSTI4 0
NEI4 $1195
line 2569
;2568:			//
;2569:			BotAI_GetEntityState(bs->kamikazebody, &state);
ADDRFP4 0
INDIRP4
CNSTI4 7456
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
ADDRGP4 BotAI_GetEntityState
CALLI4
pop
line 2570
;2570:			VectorCopy(state.pos.trBase, target);
ADDRLP4 236
ADDRLP4 12+12+12
INDIRB
ASGNB 12
line 2571
;2571:			target[2] += 8;
ADDRLP4 236+8
ADDRLP4 236+8
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 2572
;2572:			VectorSubtract(target, bs->eye, dir);
ADDRLP4 332
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 236
INDIRF4
ADDRLP4 332
INDIRP4
CNSTI4 4944
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 236+4
INDIRF4
ADDRLP4 332
INDIRP4
CNSTI4 4948
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 236+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4952
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2573
;2573:			vectoangles(dir, moveresult->ideal_viewangles);
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2575
;2574:			//
;2575:			moveresult->weapon = BotSelectActivateWeapon(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 336
ADDRGP4 BotSelectActivateWeapon
CALLI4
ASGNI4
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 336
INDIRI4
ASGNI4
line 2576
;2576:			if (moveresult->weapon == -1) {
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1204
line 2578
;2577:				// FIXME: run away!
;2578:				moveresult->weapon = 0;
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
CNSTI4 0
ASGNI4
line 2579
;2579:			}
LABELV $1204
line 2580
;2580:			if (moveresult->weapon) {
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1206
line 2582
;2581:				//
;2582:				moveresult->flags |= MOVERESULT_MOVEMENTWEAPON | MOVERESULT_MOVEMENTVIEW;
ADDRLP4 340
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 340
INDIRP4
ADDRLP4 340
INDIRP4
INDIRI4
CNSTI4 17
BORI4
ASGNI4
line 2584
;2583:				// if holding the right weapon
;2584:				if (bs->cur_ps.weapon == moveresult->weapon) {
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
NEI4 $1208
line 2586
;2585:					// if the bot is pretty close with it's aim
;2586:					if (InFieldOfVision(bs->viewangles, 20, moveresult->ideal_viewangles)) {
ADDRFP4 0
INDIRP4
CNSTI4 7840
ADDP4
ARGP4
CNSTF4 1101004800
ARGF4
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
ARGP4
ADDRLP4 344
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 344
INDIRI4
CNSTI4 0
EQI4 $1210
line 2588
;2587:						//
;2588:						BotAI_Trace(&bsptrace, bs->eye, NULL, NULL, target, bs->entitynum, MASK_SHOT);
ADDRLP4 248
ARGP4
ADDRLP4 348
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 348
INDIRP4
CNSTI4 4944
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 236
ARGP4
ADDRLP4 348
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2590
;2589:						// if the mine is visible from the current position
;2590:						if (bsptrace.fraction >= 1.0 || bsptrace.ent == state.number) {
ADDRLP4 248+8
INDIRF4
CNSTF4 1065353216
GEF4 $1216
ADDRLP4 248+80
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $1212
LABELV $1216
line 2592
;2591:							// shoot at the mine
;2592:							trap_EA_Attack(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Attack
CALLV
pop
line 2593
;2593:						}
LABELV $1212
line 2594
;2594:					}
LABELV $1210
line 2595
;2595:				}
LABELV $1208
line 2596
;2596:			}
LABELV $1206
line 2597
;2597:		}
LABELV $1195
line 2598
;2598:	}
LABELV $1193
line 2599
;2599:	if (moveresult->flags & MOVERESULT_BLOCKEDBYAVOIDSPOT) {
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $1217
line 2600
;2600:		bs->blockedbyavoidspot_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 7380
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 2601
;2601:	}
LABELV $1217
line 2603
;2602:	// if blocked by an avoid spot and the view angles and weapon are used for movement
;2603:	if (bs->blockedbyavoidspot_time > FloatTime() &&
ADDRFP4 0
INDIRP4
CNSTI4 7380
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $1219
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 17
BANDI4
CNSTI4 0
NEI4 $1219
line 2604
;2604:		!(moveresult->flags & (MOVERESULT_MOVEMENTVIEW | MOVERESULT_MOVEMENTWEAPON)) ) {
line 2605
;2605:		bestdist = 300;
ADDRLP4 228
CNSTF4 1133903872
ASGNF4
line 2606
;2606:		bestmine = -1;
ADDRLP4 232
CNSTI4 -1
ASGNI4
line 2607
;2607:		for (i = 0; i < bs->numproxmines; i++) {
ADDRLP4 220
CNSTI4 0
ASGNI4
ADDRGP4 $1224
JUMPV
LABELV $1221
line 2608
;2608:			BotAI_GetEntityState(bs->proxmines[i], &state);
ADDRLP4 220
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 7460
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
ADDRGP4 BotAI_GetEntityState
CALLI4
pop
line 2609
;2609:			VectorSubtract(state.pos.trBase, bs->origin, dir);
ADDRLP4 332
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 12+12+12
INDIRF4
ADDRLP4 332
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 12+12+12+4
INDIRF4
ADDRLP4 332
INDIRP4
CNSTI4 4920
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 12+12+12+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2610
;2610:			dist = VectorLength(dir);
ADDRLP4 0
ARGP4
ADDRLP4 336
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 224
ADDRLP4 336
INDIRF4
ASGNF4
line 2611
;2611:			if (dist < bestdist) {
ADDRLP4 224
INDIRF4
ADDRLP4 228
INDIRF4
GEF4 $1235
line 2612
;2612:				bestdist = dist;
ADDRLP4 228
ADDRLP4 224
INDIRF4
ASGNF4
line 2613
;2613:				bestmine = i;
ADDRLP4 232
ADDRLP4 220
INDIRI4
ASGNI4
line 2614
;2614:			}
LABELV $1235
line 2615
;2615:		}
LABELV $1222
line 2607
ADDRLP4 220
ADDRLP4 220
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1224
ADDRLP4 220
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 7716
ADDP4
INDIRI4
LTI4 $1221
line 2616
;2616:		if (bestmine != -1) {
ADDRLP4 232
INDIRI4
CNSTI4 -1
EQI4 $1237
line 2622
;2617:			//
;2618:			// state->generic1 == TEAM_RED || state->generic1 == TEAM_BLUE
;2619:			//
;2620:			// deactivate prox mines in the bot's path by shooting
;2621:			// rockets or plasma cells etc. at them
;2622:			BotAI_GetEntityState(bs->proxmines[bestmine], &state);
ADDRLP4 232
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 7460
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
ADDRGP4 BotAI_GetEntityState
CALLI4
pop
line 2623
;2623:			VectorCopy(state.pos.trBase, target);
ADDRLP4 236
ADDRLP4 12+12+12
INDIRB
ASGNB 12
line 2624
;2624:			target[2] += 2;
ADDRLP4 236+8
ADDRLP4 236+8
INDIRF4
CNSTF4 1073741824
ADDF4
ASGNF4
line 2625
;2625:			VectorSubtract(target, bs->eye, dir);
ADDRLP4 332
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 236
INDIRF4
ADDRLP4 332
INDIRP4
CNSTI4 4944
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 236+4
INDIRF4
ADDRLP4 332
INDIRP4
CNSTI4 4948
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 236+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4952
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2626
;2626:			vectoangles(dir, moveresult->ideal_viewangles);
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2628
;2627:			// if the bot has a weapon that does splash damage
;2628:			if (bs->inventory[INVENTORY_PLASMAGUN] > 0 && bs->inventory[INVENTORY_CELLS] > 0)
ADDRLP4 336
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 336
INDIRP4
CNSTI4 5004
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1246
ADDRLP4 336
INDIRP4
CNSTI4 5044
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1246
line 2629
;2629:				moveresult->weapon = WEAPONINDEX_PLASMAGUN;
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
CNSTI4 8
ASGNI4
ADDRGP4 $1247
JUMPV
LABELV $1246
line 2630
;2630:			else if (bs->inventory[INVENTORY_ROCKETLAUNCHER] > 0 && bs->inventory[INVENTORY_ROCKETS] > 0)
ADDRLP4 340
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 340
INDIRP4
CNSTI4 4992
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1248
ADDRLP4 340
INDIRP4
CNSTI4 5052
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1248
line 2631
;2631:				moveresult->weapon = WEAPONINDEX_ROCKET_LAUNCHER;
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
CNSTI4 5
ASGNI4
ADDRGP4 $1249
JUMPV
LABELV $1248
line 2632
;2632:			else if (bs->inventory[INVENTORY_BFG10K] > 0 && bs->inventory[INVENTORY_BFGAMMO] > 0)
ADDRLP4 344
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 344
INDIRP4
CNSTI4 5012
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1250
ADDRLP4 344
INDIRP4
CNSTI4 5060
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1250
line 2633
;2633:				moveresult->weapon = WEAPONINDEX_BFG;
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
CNSTI4 9
ASGNI4
ADDRGP4 $1251
JUMPV
LABELV $1250
line 2634
;2634:			else {
line 2635
;2635:				moveresult->weapon = 0;
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
CNSTI4 0
ASGNI4
line 2636
;2636:			}
LABELV $1251
LABELV $1249
LABELV $1247
line 2637
;2637:			if (moveresult->weapon) {
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1252
line 2639
;2638:				//
;2639:				moveresult->flags |= MOVERESULT_MOVEMENTWEAPON | MOVERESULT_MOVEMENTVIEW;
ADDRLP4 348
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 348
INDIRP4
ADDRLP4 348
INDIRP4
INDIRI4
CNSTI4 17
BORI4
ASGNI4
line 2641
;2640:				// if holding the right weapon
;2641:				if (bs->cur_ps.weapon == moveresult->weapon) {
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
NEI4 $1254
line 2643
;2642:					// if the bot is pretty close with it's aim
;2643:					if (InFieldOfVision(bs->viewangles, 20, moveresult->ideal_viewangles)) {
ADDRFP4 0
INDIRP4
CNSTI4 7840
ADDP4
ARGP4
CNSTF4 1101004800
ARGF4
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
ARGP4
ADDRLP4 352
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 352
INDIRI4
CNSTI4 0
EQI4 $1256
line 2645
;2644:						//
;2645:						BotAI_Trace(&bsptrace, bs->eye, NULL, NULL, target, bs->entitynum, MASK_SHOT);
ADDRLP4 248
ARGP4
ADDRLP4 356
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 356
INDIRP4
CNSTI4 4944
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 236
ARGP4
ADDRLP4 356
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2647
;2646:						// if the mine is visible from the current position
;2647:						if (bsptrace.fraction >= 1.0 || bsptrace.ent == state.number) {
ADDRLP4 248+8
INDIRF4
CNSTF4 1065353216
GEF4 $1262
ADDRLP4 248+80
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $1258
LABELV $1262
line 2649
;2648:							// shoot at the mine
;2649:							trap_EA_Attack(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Attack
CALLV
pop
line 2650
;2650:						}
LABELV $1258
line 2651
;2651:					}
LABELV $1256
line 2652
;2652:				}
LABELV $1254
line 2653
;2653:			}
LABELV $1252
line 2654
;2654:		}
LABELV $1237
line 2655
;2655:	}
LABELV $1219
line 2656
;2656:}
LABELV $1192
endproc BotClearPath 360 28
export AIEnter_Seek_ActivateEntity
proc AIEnter_Seek_ActivateEntity 0 16
line 2663
;2657:
;2658:/*
;2659:==================
;2660:AIEnter_Seek_ActivateEntity
;2661:==================
;2662:*/
;2663:void AIEnter_Seek_ActivateEntity(bot_state_t *bs, char *s) {
line 2664
;2664:	BotRecordNodeSwitch(bs, "activate entity", "", s);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1264
ARGP4
ADDRGP4 $99
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotRecordNodeSwitch
CALLV
pop
line 2665
;2665:	bs->ainode = AINode_Seek_ActivateEntity;
ADDRFP4 0
INDIRP4
CNSTI4 4904
ADDP4
ADDRGP4 AINode_Seek_ActivateEntity
ASGNP4
line 2666
;2666:}
LABELV $1263
endproc AIEnter_Seek_ActivateEntity 0 16
export AINode_Seek_ActivateEntity
proc AINode_Seek_ActivateEntity 364 28
line 2673
;2667:
;2668:/*
;2669:==================
;2670:AINode_Seek_Activate_Entity
;2671:==================
;2672:*/
;2673:int AINode_Seek_ActivateEntity(bot_state_t *bs) {
line 2681
;2674:	bot_goal_t *goal;
;2675:	vec3_t target, dir, ideal_viewangles;
;2676:	bot_moveresult_t moveresult;
;2677:	int targetvisible;
;2678:	bsp_trace_t bsptrace;
;2679:	aas_entityinfo_t entinfo;
;2680:
;2681:	if (BotIsObserver(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 320
ADDRGP4 BotIsObserver
CALLI4
ASGNI4
ADDRLP4 320
INDIRI4
CNSTI4 0
EQI4 $1266
line 2682
;2682:		BotClearActivateGoalStack(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotClearActivateGoalStack
CALLV
pop
line 2683
;2683:		AIEnter_Observer(bs, "active entity: observer");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1268
ARGP4
ADDRGP4 AIEnter_Observer
CALLV
pop
line 2684
;2684:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1265
JUMPV
LABELV $1266
line 2687
;2685:	}
;2686:	//if in the intermission
;2687:	if (BotIntermission(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 324
ADDRGP4 BotIntermission
CALLI4
ASGNI4
ADDRLP4 324
INDIRI4
CNSTI4 0
EQI4 $1269
line 2688
;2688:		BotClearActivateGoalStack(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotClearActivateGoalStack
CALLV
pop
line 2689
;2689:		AIEnter_Intermission(bs, "activate entity: intermission");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1271
ARGP4
ADDRGP4 AIEnter_Intermission
CALLV
pop
line 2690
;2690:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1265
JUMPV
LABELV $1269
line 2693
;2691:	}
;2692:	//respawn if dead
;2693:	if (BotIsDead(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 328
ADDRGP4 BotIsDead
CALLI4
ASGNI4
ADDRLP4 328
INDIRI4
CNSTI4 0
EQI4 $1272
line 2694
;2694:		BotClearActivateGoalStack(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotClearActivateGoalStack
CALLV
pop
line 2695
;2695:		AIEnter_Respawn(bs, "activate entity: bot dead");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1274
ARGP4
ADDRGP4 AIEnter_Respawn
CALLV
pop
line 2696
;2696:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1265
JUMPV
LABELV $1272
line 2699
;2697:	}
;2698:	//
;2699:	bs->tfl = TFL_DEFAULT;
ADDRFP4 0
INDIRP4
CNSTI4 5984
ADDP4
CNSTI4 18616254
ASGNI4
line 2700
;2700:	if (bot_grapple.integer) bs->tfl |= TFL_GRAPPLEHOOK;
ADDRGP4 bot_grapple+12
INDIRI4
CNSTI4 0
EQI4 $1275
ADDRLP4 332
ADDRFP4 0
INDIRP4
CNSTI4 5984
ADDP4
ASGNP4
ADDRLP4 332
INDIRP4
ADDRLP4 332
INDIRP4
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
LABELV $1275
line 2702
;2701:	// if in lava or slime the bot should be able to get out
;2702:	if (BotInLavaOrSlime(bs)) bs->tfl |= TFL_LAVA|TFL_SLIME;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 336
ADDRGP4 BotInLavaOrSlime
CALLI4
ASGNI4
ADDRLP4 336
INDIRI4
CNSTI4 0
EQI4 $1278
ADDRLP4 340
ADDRFP4 0
INDIRP4
CNSTI4 5984
ADDP4
ASGNP4
ADDRLP4 340
INDIRP4
ADDRLP4 340
INDIRP4
INDIRI4
CNSTI4 6291456
BORI4
ASGNI4
LABELV $1278
line 2704
;2703:	// map specific code
;2704:	BotMapScripts(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotMapScripts
CALLV
pop
line 2706
;2705:	// no enemy
;2706:	bs->enemy = -1;
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
CNSTI4 -1
ASGNI4
line 2708
;2707:	// if the bot has no activate goal
;2708:	if (!bs->activatestack) {
ADDRFP4 0
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1280
line 2709
;2709:		BotClearActivateGoalStack(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotClearActivateGoalStack
CALLV
pop
line 2710
;2710:		AIEnter_Seek_NBG(bs, "activate entity: no goal");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1282
ARGP4
ADDRGP4 AIEnter_Seek_NBG
CALLV
pop
line 2711
;2711:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1265
JUMPV
LABELV $1280
line 2714
;2712:	}
;2713:	//
;2714:	goal = &bs->activatestack->goal;
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
line 2716
;2715:	// initialize target being visible to false
;2716:	targetvisible = qfalse;
ADDRLP4 68
CNSTI4 0
ASGNI4
line 2718
;2717:	// if the bot has to shoot at a target to activate something
;2718:	if (bs->activatestack->shoot) {
ADDRFP4 0
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1283
line 2720
;2719:		//
;2720:		BotAI_Trace(&bsptrace, bs->eye, NULL, NULL, bs->activatestack->target, bs->entitynum, MASK_SHOT);
ADDRLP4 72
ARGP4
ADDRLP4 344
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 344
INDIRP4
CNSTI4 4944
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 344
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CNSTI4 80
ADDP4
ARGP4
ADDRLP4 344
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2722
;2721:		// if the shootable entity is visible from the current position
;2722:		if (bsptrace.fraction >= 1.0 || bsptrace.ent == goal->entitynum) {
ADDRLP4 72+8
INDIRF4
CNSTF4 1065353216
GEF4 $1289
ADDRLP4 72+80
INDIRI4
ADDRLP4 52
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
NEI4 $1285
LABELV $1289
line 2723
;2723:			targetvisible = qtrue;
ADDRLP4 68
CNSTI4 1
ASGNI4
line 2725
;2724:			// if holding the right weapon
;2725:			if (bs->cur_ps.weapon == bs->activatestack->weapon) {
ADDRLP4 348
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 348
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ADDRLP4 348
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
NEI4 $1290
line 2726
;2726:				VectorSubtract(bs->activatestack->target, bs->eye, dir);
ADDRLP4 352
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
ADDRLP4 352
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
ADDRLP4 352
INDIRP4
CNSTI4 4944
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 56+4
ADDRLP4 352
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
ADDRLP4 352
INDIRP4
CNSTI4 4948
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 356
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56+8
ADDRLP4 356
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CNSTI4 88
ADDP4
INDIRF4
ADDRLP4 356
INDIRP4
CNSTI4 4952
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2727
;2727:				vectoangles(dir, ideal_viewangles);
ADDRLP4 56
ARGP4
ADDRLP4 308
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2729
;2728:				// if the bot is pretty close with it's aim
;2729:				if (InFieldOfVision(bs->viewangles, 20, ideal_viewangles)) {
ADDRFP4 0
INDIRP4
CNSTI4 7840
ADDP4
ARGP4
CNSTF4 1101004800
ARGF4
ADDRLP4 308
ARGP4
ADDRLP4 360
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 360
INDIRI4
CNSTI4 0
EQI4 $1294
line 2730
;2730:					trap_EA_Attack(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Attack
CALLV
pop
line 2731
;2731:				}
LABELV $1294
line 2732
;2732:			}
LABELV $1290
line 2733
;2733:		}
LABELV $1285
line 2734
;2734:	}
LABELV $1283
line 2736
;2735:	// if the shoot target is visible
;2736:	if (targetvisible) {
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $1296
line 2738
;2737:		// get the entity info of the entity the bot is shooting at
;2738:		BotEntityInfo(goal->entitynum, &entinfo);
ADDRLP4 52
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ARGI4
ADDRLP4 156
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 2740
;2739:		// if the entity the bot shoots at moved
;2740:		if (!VectorCompare(bs->activatestack->origin, entinfo.origin)) {
ADDRFP4 0
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 156+24
ARGP4
ADDRLP4 344
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 344
INDIRI4
CNSTI4 0
NEI4 $1298
line 2744
;2741:#ifdef DEBUG
;2742:			BotAI_Print(PRT_MESSAGE, "hit shootable button or trigger\n");
;2743:#endif //DEBUG
;2744:			bs->activatestack->time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CNSTI4 60
ADDP4
CNSTF4 0
ASGNF4
line 2745
;2745:		}
LABELV $1298
line 2747
;2746:		// if the activate goal has been activated or the bot takes too long
;2747:		if (bs->activatestack->time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $1301
line 2748
;2748:			BotPopFromActivateGoalStack(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotPopFromActivateGoalStack
CALLI4
pop
line 2750
;2749:			// if there are more activate goals on the stack
;2750:			if (bs->activatestack) {
ADDRFP4 0
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1303
line 2751
;2751:				bs->activatestack->time = FloatTime() + 10;
ADDRFP4 0
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CNSTI4 60
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1092616192
ADDF4
ASGNF4
line 2752
;2752:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1265
JUMPV
LABELV $1303
line 2754
;2753:			}
;2754:			AIEnter_Seek_NBG(bs, "activate entity: time out");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1305
ARGP4
ADDRGP4 AIEnter_Seek_NBG
CALLV
pop
line 2755
;2755:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1265
JUMPV
LABELV $1301
line 2757
;2756:		}
;2757:		memset(&moveresult, 0, sizeof(bot_moveresult_t));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 52
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2758
;2758:	}
ADDRGP4 $1297
JUMPV
LABELV $1296
line 2759
;2759:	else {
line 2761
;2760:		// if the bot has no goal
;2761:		if (!goal) {
ADDRLP4 52
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1306
line 2762
;2762:			bs->activatestack->time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CNSTI4 60
ADDP4
CNSTF4 0
ASGNF4
line 2763
;2763:		}
ADDRGP4 $1307
JUMPV
LABELV $1306
line 2765
;2764:		// if the bot does not have a shoot goal
;2765:		else if (!bs->activatestack->shoot) {
ADDRFP4 0
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1308
line 2767
;2766:			//if the bot touches the current goal
;2767:			if (trap_BotTouchingGoal(bs->origin, goal)) {
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRLP4 344
ADDRGP4 trap_BotTouchingGoal
CALLI4
ASGNI4
ADDRLP4 344
INDIRI4
CNSTI4 0
EQI4 $1310
line 2771
;2768:#ifdef DEBUG
;2769:				BotAI_Print(PRT_MESSAGE, "touched button or trigger\n");
;2770:#endif //DEBUG
;2771:				bs->activatestack->time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CNSTI4 60
ADDP4
CNSTF4 0
ASGNF4
line 2772
;2772:			}
LABELV $1310
line 2773
;2773:		}
LABELV $1308
LABELV $1307
line 2775
;2774:		// if the activate goal has been activated or the bot takes too long
;2775:		if (bs->activatestack->time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $1312
line 2776
;2776:			BotPopFromActivateGoalStack(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotPopFromActivateGoalStack
CALLI4
pop
line 2778
;2777:			// if there are more activate goals on the stack
;2778:			if (bs->activatestack) {
ADDRFP4 0
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1314
line 2779
;2779:				bs->activatestack->time = FloatTime() + 10;
ADDRFP4 0
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CNSTI4 60
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1092616192
ADDF4
ASGNF4
line 2780
;2780:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1265
JUMPV
LABELV $1314
line 2782
;2781:			}
;2782:			AIEnter_Seek_NBG(bs, "activate entity: activated");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1316
ARGP4
ADDRGP4 AIEnter_Seek_NBG
CALLV
pop
line 2783
;2783:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1265
JUMPV
LABELV $1312
line 2786
;2784:		}
;2785:		//predict obstacles
;2786:		if (BotAIPredictObstacles(bs, goal))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRLP4 344
ADDRGP4 BotAIPredictObstacles
CALLI4
ASGNI4
ADDRLP4 344
INDIRI4
CNSTI4 0
EQI4 $1317
line 2787
;2787:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1265
JUMPV
LABELV $1317
line 2789
;2788:		//initialize the movement state
;2789:		BotSetupForMovement(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetupForMovement
CALLV
pop
line 2791
;2790:		//move towards the goal
;2791:		trap_BotMoveToGoal(&moveresult, bs->ms, goal, bs->tfl);
ADDRLP4 0
ARGP4
ADDRLP4 348
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 348
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
INDIRP4
ARGP4
ADDRLP4 348
INDIRP4
CNSTI4 5984
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotMoveToGoal
CALLV
pop
line 2793
;2792:		//if the movement failed
;2793:		if (moveresult.failure) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1319
line 2795
;2794:			//reset the avoid reach, otherwise bot is stuck in current area
;2795:			trap_BotResetAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidReach
CALLV
pop
line 2797
;2796:			//
;2797:			bs->activatestack->time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CNSTI4 60
ADDP4
CNSTF4 0
ASGNF4
line 2798
;2798:		}
LABELV $1319
line 2800
;2799:		//check if the bot is blocked
;2800:		BotAIBlocked(bs, &moveresult, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BotAIBlocked
CALLV
pop
line 2801
;2801:	}
LABELV $1297
line 2803
;2802:	//
;2803:	BotClearPath(bs, &moveresult);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotClearPath
CALLV
pop
line 2805
;2804:	// if the bot has to shoot to activate
;2805:	if (bs->activatestack->shoot) {
ADDRFP4 0
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1321
line 2807
;2806:		// if the view angles aren't yet used for the movement
;2807:		if (!(moveresult.flags & MOVERESULT_MOVEMENTVIEW)) {
ADDRLP4 0+20
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $1323
line 2808
;2808:			VectorSubtract(bs->activatestack->target, bs->eye, dir);
ADDRLP4 344
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
ADDRLP4 344
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
ADDRLP4 344
INDIRP4
CNSTI4 4944
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 56+4
ADDRLP4 344
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
ADDRLP4 344
INDIRP4
CNSTI4 4948
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 348
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56+8
ADDRLP4 348
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CNSTI4 88
ADDP4
INDIRF4
ADDRLP4 348
INDIRP4
CNSTI4 4952
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2809
;2809:			vectoangles(dir, moveresult.ideal_viewangles);
ADDRLP4 56
ARGP4
ADDRLP4 0+40
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2810
;2810:			moveresult.flags |= MOVERESULT_MOVEMENTVIEW;
ADDRLP4 0+20
ADDRLP4 0+20
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 2811
;2811:		}
LABELV $1323
line 2813
;2812:		// if there's no weapon yet used for the movement
;2813:		if (!(moveresult.flags & MOVERESULT_MOVEMENTWEAPON)) {
ADDRLP4 0+20
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $1330
line 2814
;2814:			moveresult.flags |= MOVERESULT_MOVEMENTWEAPON;
ADDRLP4 0+20
ADDRLP4 0+20
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 2816
;2815:			//
;2816:			bs->activatestack->weapon = BotSelectActivateWeapon(bs);
ADDRLP4 344
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 344
INDIRP4
ARGP4
ADDRLP4 348
ADDRGP4 BotSelectActivateWeapon
CALLI4
ASGNI4
ADDRLP4 344
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CNSTI4 76
ADDP4
ADDRLP4 348
INDIRI4
ASGNI4
line 2817
;2817:			if (bs->activatestack->weapon == -1) {
ADDRFP4 0
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1334
line 2819
;2818:				//FIXME: find a decent weapon first
;2819:				bs->activatestack->weapon = 0;
ADDRFP4 0
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CNSTI4 76
ADDP4
CNSTI4 0
ASGNI4
line 2820
;2820:			}
LABELV $1334
line 2821
;2821:			moveresult.weapon = bs->activatestack->weapon;
ADDRLP4 0+24
ADDRFP4 0
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
ASGNI4
line 2822
;2822:		}
LABELV $1330
line 2823
;2823:	}
LABELV $1321
line 2825
;2824:	// if the ideal view angles are set for movement
;2825:	if (moveresult.flags & (MOVERESULT_MOVEMENTVIEWSET|MOVERESULT_MOVEMENTVIEW|MOVERESULT_SWIMVIEW)) {
ADDRLP4 0+20
INDIRI4
CNSTI4 11
BANDI4
CNSTI4 0
EQI4 $1337
line 2826
;2826:		VectorCopy(moveresult.ideal_viewangles, bs->ideal_viewangles);
ADDRFP4 0
INDIRP4
CNSTI4 7852
ADDP4
ADDRLP4 0+40
INDIRB
ASGNB 12
line 2827
;2827:	}
ADDRGP4 $1338
JUMPV
LABELV $1337
line 2829
;2828:	// if waiting for something
;2829:	else if (moveresult.flags & MOVERESULT_WAITING) {
ADDRLP4 0+20
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $1341
line 2835
;2830:		// JUHOX: new roaming view strategy
;2831:#if 0
;2832:		if (random() < bs->thinktime * 0.8) {
;2833:			BotRoamGoal(bs, target);
;2834:#else
;2835:		if (BotRoamGoal(bs, target, qfalse)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 344
ADDRGP4 BotRoamGoal
CALLI4
ASGNI4
ADDRLP4 344
INDIRI4
CNSTI4 0
EQI4 $1342
line 2837
;2836:#endif
;2837:			VectorSubtract(target, bs->origin, dir);
ADDRLP4 348
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
ADDRLP4 296
INDIRF4
ADDRLP4 348
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 56+4
ADDRLP4 296+4
INDIRF4
ADDRLP4 348
INDIRP4
CNSTI4 4920
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 56+8
ADDRLP4 296+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2838
;2838:			vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 56
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 7852
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2839
;2839:			bs->ideal_viewangles[2] *= 0.5;
ADDRLP4 352
ADDRFP4 0
INDIRP4
CNSTI4 7860
ADDP4
ASGNP4
ADDRLP4 352
INDIRP4
ADDRLP4 352
INDIRP4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 2840
;2840:		}
line 2841
;2841:	}
ADDRGP4 $1342
JUMPV
LABELV $1341
line 2842
;2842:	else if (!(bs->flags & BFL_IDEALVIEWSET)) {
ADDRFP4 0
INDIRP4
CNSTI4 5992
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
NEI4 $1350
line 2843
;2843:		if (trap_BotMovementViewTarget(bs->ms, goal, bs->tfl, 300, target)) {
ADDRLP4 344
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 344
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
INDIRP4
ARGP4
ADDRLP4 344
INDIRP4
CNSTI4 5984
ADDP4
INDIRI4
ARGI4
CNSTF4 1133903872
ARGF4
ADDRLP4 296
ARGP4
ADDRLP4 348
ADDRGP4 trap_BotMovementViewTarget
CALLI4
ASGNI4
ADDRLP4 348
INDIRI4
CNSTI4 0
EQI4 $1352
line 2844
;2844:			VectorSubtract(target, bs->origin, dir);
ADDRLP4 352
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
ADDRLP4 296
INDIRF4
ADDRLP4 352
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 56+4
ADDRLP4 296+4
INDIRF4
ADDRLP4 352
INDIRP4
CNSTI4 4920
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 56+8
ADDRLP4 296+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2845
;2845:			vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 56
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 7852
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2846
;2846:		}
ADDRGP4 $1353
JUMPV
LABELV $1352
line 2847
;2847:		else {
line 2848
;2848:			vectoangles(moveresult.movedir, bs->ideal_viewangles);
ADDRLP4 0+28
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 7852
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2849
;2849:		}
LABELV $1353
line 2850
;2850:		bs->ideal_viewangles[2] *= 0.5;
ADDRLP4 352
ADDRFP4 0
INDIRP4
CNSTI4 7860
ADDP4
ASGNP4
ADDRLP4 352
INDIRP4
ADDRLP4 352
INDIRP4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 2851
;2851:	}
LABELV $1350
LABELV $1342
LABELV $1338
line 2852
;2852:	BotCheckForWeaponJump(bs, &moveresult);	// JUHOX
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotCheckForWeaponJump
CALLV
pop
line 2854
;2853:	// if the weapon is used for the bot movement
;2854:	if (moveresult.flags & MOVERESULT_MOVEMENTWEAPON)
ADDRLP4 0+20
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1359
line 2855
;2855:		bs->weaponnum = moveresult.weapon;
ADDRFP4 0
INDIRP4
CNSTI4 7804
ADDP4
ADDRLP4 0+24
INDIRI4
ASGNI4
LABELV $1359
line 2857
;2856:	// if there is an enemy
;2857:	if (BotFindEnemy(bs, -1)) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 344
ADDRGP4 BotFindEnemy
CALLI4
ASGNI4
ADDRLP4 344
INDIRI4
CNSTI4 0
EQI4 $1363
line 2858
;2858:		if (BotWantsToRetreat(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 348
ADDRGP4 BotWantsToRetreat
CALLI4
ASGNI4
ADDRLP4 348
INDIRI4
CNSTI4 0
EQI4 $1365
line 2860
;2859:			//keep the current long term goal and retreat
;2860:			AIEnter_Battle_NBG(bs, "activate entity: found enemy");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1367
ARGP4
ADDRGP4 AIEnter_Battle_NBG
CALLV
pop
line 2861
;2861:		}
ADDRGP4 $1366
JUMPV
LABELV $1365
line 2862
;2862:		else {
line 2863
;2863:			trap_BotResetLastAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetLastAvoidReach
CALLV
pop
line 2865
;2864:			//empty the goal stack
;2865:			trap_BotEmptyGoalStack(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotEmptyGoalStack
CALLV
pop
line 2867
;2866:			//go fight
;2867:			AIEnter_Battle_Fight(bs, "activate entity: found enemy");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1367
ARGP4
ADDRGP4 AIEnter_Battle_Fight
CALLV
pop
line 2868
;2868:		}
LABELV $1366
line 2869
;2869:		BotClearActivateGoalStack(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotClearActivateGoalStack
CALLV
pop
line 2870
;2870:	}
LABELV $1363
line 2871
;2871:	return qtrue;
CNSTI4 1
RETI4
LABELV $1265
endproc AINode_Seek_ActivateEntity 364 28
export AIEnter_Seek_NBG
proc AIEnter_Seek_NBG 204 16
line 2879
;2872:}
;2873:
;2874:/*
;2875:==================
;2876:AIEnter_Seek_NBG
;2877:==================
;2878:*/
;2879:void AIEnter_Seek_NBG(bot_state_t *bs, char *s) {
line 2883
;2880:	bot_goal_t goal;
;2881:	char buf[144];
;2882:
;2883:	if (trap_BotGetTopGoal(bs->gs, &goal)) {
ADDRFP4 0
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 200
ADDRGP4 trap_BotGetTopGoal
CALLI4
ASGNI4
ADDRLP4 200
INDIRI4
CNSTI4 0
EQI4 $1369
line 2884
;2884:		trap_BotGoalName(goal.number, buf, 144);
ADDRLP4 0+44
INDIRI4
ARGI4
ADDRLP4 56
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 2885
;2885:		BotRecordNodeSwitch(bs, "seek NBG", buf, s);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1372
ARGP4
ADDRLP4 56
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotRecordNodeSwitch
CALLV
pop
line 2886
;2886:	}
ADDRGP4 $1370
JUMPV
LABELV $1369
line 2887
;2887:	else {
line 2888
;2888:		BotRecordNodeSwitch(bs, "seek NBG", "no goal", s);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1372
ARGP4
ADDRGP4 $1373
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotRecordNodeSwitch
CALLV
pop
line 2889
;2889:	}
LABELV $1370
line 2890
;2890:	bs->ainode = AINode_Seek_NBG;
ADDRFP4 0
INDIRP4
CNSTI4 4904
ADDP4
ADDRGP4 AINode_Seek_NBG
ASGNP4
line 2891
;2891:}
LABELV $1368
endproc AIEnter_Seek_NBG 204 16
export AINode_Seek_NBG
proc AINode_Seek_NBG 196 20
line 2898
;2892:
;2893:/*
;2894:==================
;2895:AINode_Seek_NBG
;2896:==================
;2897:*/
;2898:int AINode_Seek_NBG(bot_state_t *bs) {
line 2903
;2899:	bot_goal_t goal;
;2900:	vec3_t target, dir;
;2901:	bot_moveresult_t moveresult;
;2902:
;2903:	if (BotIsObserver(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 132
ADDRGP4 BotIsObserver
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 0
EQI4 $1375
line 2904
;2904:		AIEnter_Observer(bs, "seek nbg: observer");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1377
ARGP4
ADDRGP4 AIEnter_Observer
CALLV
pop
line 2905
;2905:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1374
JUMPV
LABELV $1375
line 2908
;2906:	}
;2907:	//if in the intermission
;2908:	if (BotIntermission(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 136
ADDRGP4 BotIntermission
CALLI4
ASGNI4
ADDRLP4 136
INDIRI4
CNSTI4 0
EQI4 $1378
line 2909
;2909:		AIEnter_Intermission(bs, "seek nbg: intermision");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1380
ARGP4
ADDRGP4 AIEnter_Intermission
CALLV
pop
line 2910
;2910:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1374
JUMPV
LABELV $1378
line 2913
;2911:	}
;2912:	//respawn if dead
;2913:	if (BotIsDead(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotIsDead
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $1381
line 2914
;2914:		AIEnter_Respawn(bs, "seek nbg: bot dead");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1383
ARGP4
ADDRGP4 AIEnter_Respawn
CALLV
pop
line 2915
;2915:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1374
JUMPV
LABELV $1381
line 2918
;2916:	}
;2917:	//
;2918:	bs->tfl = TFL_DEFAULT;
ADDRFP4 0
INDIRP4
CNSTI4 5984
ADDP4
CNSTI4 18616254
ASGNI4
line 2919
;2919:	if (bot_grapple.integer) bs->tfl |= TFL_GRAPPLEHOOK;
ADDRGP4 bot_grapple+12
INDIRI4
CNSTI4 0
EQI4 $1384
ADDRLP4 144
ADDRFP4 0
INDIRP4
CNSTI4 5984
ADDP4
ASGNP4
ADDRLP4 144
INDIRP4
ADDRLP4 144
INDIRP4
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
LABELV $1384
line 2921
;2920:	//if in lava or slime the bot should be able to get out
;2921:	if (BotInLavaOrSlime(bs)) bs->tfl |= TFL_LAVA|TFL_SLIME;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 148
ADDRGP4 BotInLavaOrSlime
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
EQI4 $1387
ADDRLP4 152
ADDRFP4 0
INDIRP4
CNSTI4 5984
ADDP4
ASGNP4
ADDRLP4 152
INDIRP4
ADDRLP4 152
INDIRP4
INDIRI4
CNSTI4 6291456
BORI4
ASGNI4
LABELV $1387
line 2923
;2922:	//
;2923:	if (BotCanAndWantsToRocketJump(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 156
ADDRGP4 BotCanAndWantsToRocketJump
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
EQI4 $1389
line 2924
;2924:		bs->tfl |= TFL_ROCKETJUMP;
ADDRLP4 160
ADDRFP4 0
INDIRP4
CNSTI4 5984
ADDP4
ASGNP4
ADDRLP4 160
INDIRP4
ADDRLP4 160
INDIRP4
INDIRI4
CNSTI4 4096
BORI4
ASGNI4
line 2925
;2925:	}
LABELV $1389
line 2927
;2926:	//map specific code
;2927:	BotMapScripts(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotMapScripts
CALLV
pop
line 2929
;2928:	//no enemy
;2929:	bs->enemy = -1;
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
CNSTI4 -1
ASGNI4
line 2931
;2930:	//if the bot has no goal
;2931:	if (!trap_BotGetTopGoal(bs->gs, &goal)) bs->nbg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
ARGP4
ADDRLP4 160
ADDRGP4 trap_BotGetTopGoal
CALLI4
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 0
NEI4 $1391
ADDRFP4 0
INDIRP4
CNSTI4 6092
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 $1392
JUMPV
LABELV $1391
line 2933
;2932:	//if the bot touches the current goal
;2933:	else if (BotReachedGoal(bs, &goal)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ARGP4
ADDRLP4 164
ADDRGP4 BotReachedGoal
CALLI4
ASGNI4
ADDRLP4 164
INDIRI4
CNSTI4 0
EQI4 $1393
line 2934
;2934:		BotChooseWeapon(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotChooseWeapon
CALLV
pop
line 2935
;2935:		bs->nbg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6092
ADDP4
CNSTF4 0
ASGNF4
line 2936
;2936:		bs->check_time = 0;	// JUHOX: immediately check for another NBG
ADDRFP4 0
INDIRP4
CNSTI4 7184
ADDP4
CNSTF4 0
ASGNF4
line 2937
;2937:	}
ADDRGP4 $1394
JUMPV
LABELV $1393
line 2939
;2938:#if 1	// JUHOX: check if the NBG is still useful
;2939:	else if (bs->check_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 7184
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $1395
line 2940
;2940:		bs->check_time = FloatTime() + 1 + 0.5 * random();
ADDRLP4 168
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRFP4 0
INDIRP4
CNSTI4 7184
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
ADDF4
ADDRLP4 168
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 168
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1056964608
MULF4
ADDF4
ASGNF4
line 2942
;2941:
;2942:		if (!BotCheckNBG(bs, &goal)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ARGP4
ADDRLP4 172
ADDRGP4 BotCheckNBG
CALLI4
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 0
NEI4 $1397
line 2943
;2943:			bs->nbg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6092
ADDP4
CNSTF4 0
ASGNF4
line 2944
;2944:			bs->check_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7184
ADDP4
CNSTF4 0
ASGNF4
line 2945
;2945:		}
LABELV $1397
line 2946
;2946:	}
LABELV $1395
LABELV $1394
LABELV $1392
line 2949
;2947:#endif
;2948:	//
;2949:	if (bs->nbg_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6092
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $1399
line 2950
;2950:		bs->getImportantNBGItem = qfalse;	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 7736
ADDP4
CNSTI4 0
ASGNI4
line 2952
;2951:		//pop the current goal from the stack
;2952:		trap_BotPopGoal(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotPopGoal
CALLV
pop
line 2955
;2953:		//check for new nearby items right away
;2954:		//NOTE: we canNOT reset the check_time to zero because it would create an endless loop of node switches
;2955:		bs->check_time = FloatTime() + 0.05;
ADDRFP4 0
INDIRP4
CNSTI4 7184
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1028443341
ADDF4
ASGNF4
line 2957
;2956:		//go back to seek ltg
;2957:		AIEnter_Seek_LTG(bs, "seek nbg: time out");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1401
ARGP4
ADDRGP4 AIEnter_Seek_LTG
CALLV
pop
line 2958
;2958:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1374
JUMPV
LABELV $1399
line 2961
;2959:	}
;2960:	//predict obstacles
;2961:	if (BotAIPredictObstacles(bs, &goal))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ARGP4
ADDRLP4 168
ADDRGP4 BotAIPredictObstacles
CALLI4
ASGNI4
ADDRLP4 168
INDIRI4
CNSTI4 0
EQI4 $1402
line 2962
;2962:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1374
JUMPV
LABELV $1402
line 2964
;2963:	//initialize the movement state
;2964:	BotSetupForMovement(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetupForMovement
CALLV
pop
line 2974
;2965:#if 0	// -JUHOX: if really near the goal, don't trust trap_BotMoveToGoal()
;2966:	VectorSubtract(goal.origin, bs->origin, dir);
;2967:	if (VectorNormalize(dir) < 60 && dir[2] < 30) {
;2968:		if (trap_BotMoveInDirection(bs->ms, dir, bs->forceWalk? 200 : 400, MOVE_WALK)) {
;2969:			return qtrue;
;2970:		}
;2971:	}
;2972:#endif
;2973:	//move towards the goal
;2974:	trap_BotMoveToGoal(&moveresult, bs->ms, &goal, bs->tfl);
ADDRLP4 0
ARGP4
ADDRLP4 172
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 172
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
ARGP4
ADDRLP4 172
INDIRP4
CNSTI4 5984
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotMoveToGoal
CALLV
pop
line 2976
;2975:	//if the movement failed
;2976:	if (moveresult.failure) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1404
line 2978
;2977:		//reset the avoid reach, otherwise bot is stuck in current area
;2978:		trap_BotResetAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidReach
CALLV
pop
line 2979
;2979:		bs->nbg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6092
ADDP4
CNSTF4 0
ASGNF4
line 2980
;2980:	}
LABELV $1404
line 2982
;2981:	//check if the bot is blocked
;2982:	BotAIBlocked(bs, &moveresult, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BotAIBlocked
CALLV
pop
line 2984
;2983:	//
;2984:	BotClearPath(bs, &moveresult);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotClearPath
CALLV
pop
line 2986
;2985:	//if the viewangles are used for the movement
;2986:	if (moveresult.flags & (MOVERESULT_MOVEMENTVIEWSET|MOVERESULT_MOVEMENTVIEW|MOVERESULT_SWIMVIEW)) {
ADDRLP4 0+20
INDIRI4
CNSTI4 11
BANDI4
CNSTI4 0
EQI4 $1406
line 2987
;2987:		VectorCopy(moveresult.ideal_viewangles, bs->ideal_viewangles);
ADDRFP4 0
INDIRP4
CNSTI4 7852
ADDP4
ADDRLP4 0+40
INDIRB
ASGNB 12
line 2988
;2988:	}
ADDRGP4 $1407
JUMPV
LABELV $1406
line 2990
;2989:	//if waiting for something
;2990:	else if (moveresult.flags & MOVERESULT_WAITING) {
ADDRLP4 0+20
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $1410
line 2995
;2991:#if 0	// JUHOX: new roaming view strategy
;2992:		if (random() < bs->thinktime * 0.8) {
;2993:			BotRoamGoal(bs, target);
;2994:#else
;2995:		if (BotRoamGoal(bs, target, qfalse)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 108
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 176
ADDRGP4 BotRoamGoal
CALLI4
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 0
EQI4 $1411
line 2997
;2996:#endif
;2997:			VectorSubtract(target, bs->origin, dir);
ADDRLP4 180
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 120
ADDRLP4 108
INDIRF4
ADDRLP4 180
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 120+4
ADDRLP4 108+4
INDIRF4
ADDRLP4 180
INDIRP4
CNSTI4 4920
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 120+8
ADDRLP4 108+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2998
;2998:			vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 120
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 7852
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2999
;2999:			bs->ideal_viewangles[2] *= 0.5;
ADDRLP4 184
ADDRFP4 0
INDIRP4
CNSTI4 7860
ADDP4
ASGNP4
ADDRLP4 184
INDIRP4
ADDRLP4 184
INDIRP4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 3000
;3000:		}
line 3001
;3001:	}
ADDRGP4 $1411
JUMPV
LABELV $1410
line 3002
;3002:	else if (!(bs->flags & BFL_IDEALVIEWSET)) {
ADDRFP4 0
INDIRP4
CNSTI4 5992
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
NEI4 $1419
line 3003
;3003:		if (BotRoamGoal(bs, target, qtrue)) goto SetViewTarget;	// JUHOX
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 108
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 176
ADDRGP4 BotRoamGoal
CALLI4
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 0
EQI4 $1421
ADDRGP4 $1423
JUMPV
LABELV $1421
line 3004
;3004:		if (!trap_BotGetSecondGoal(bs->gs, &goal)) trap_BotGetTopGoal(bs->gs, &goal);
ADDRFP4 0
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
ARGP4
ADDRLP4 180
ADDRGP4 trap_BotGetSecondGoal
CALLI4
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 0
NEI4 $1424
ADDRFP4 0
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
ARGP4
ADDRGP4 trap_BotGetTopGoal
CALLI4
pop
LABELV $1424
line 3005
;3005:		if (trap_BotMovementViewTarget(bs->ms, &goal, bs->tfl, 300, target)) {
ADDRLP4 184
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 184
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
ARGP4
ADDRLP4 184
INDIRP4
CNSTI4 5984
ADDP4
INDIRI4
ARGI4
CNSTF4 1133903872
ARGF4
ADDRLP4 108
ARGP4
ADDRLP4 188
ADDRGP4 trap_BotMovementViewTarget
CALLI4
ASGNI4
ADDRLP4 188
INDIRI4
CNSTI4 0
EQI4 $1426
LABELV $1423
line 3007
;3006:			SetViewTarget:	// JUHOX
;3007:			VectorSubtract(target, bs->origin, dir);
ADDRLP4 192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 120
ADDRLP4 108
INDIRF4
ADDRLP4 192
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 120+4
ADDRLP4 108+4
INDIRF4
ADDRLP4 192
INDIRP4
CNSTI4 4920
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 120+8
ADDRLP4 108+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3008
;3008:			vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 120
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 7852
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 3009
;3009:		}
ADDRGP4 $1427
JUMPV
LABELV $1426
line 3011
;3010:		//FIXME: look at cluster portals?
;3011:		else vectoangles(moveresult.movedir, bs->ideal_viewangles);
ADDRLP4 0+28
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 7852
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
LABELV $1427
line 3012
;3012:		bs->ideal_viewangles[2] *= 0.5;
ADDRLP4 192
ADDRFP4 0
INDIRP4
CNSTI4 7860
ADDP4
ASGNP4
ADDRLP4 192
INDIRP4
ADDRLP4 192
INDIRP4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 3013
;3013:	}
LABELV $1419
LABELV $1411
LABELV $1407
line 3014
;3014:	BotCheckForWeaponJump(bs, &moveresult);	// JUHOX
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotCheckForWeaponJump
CALLV
pop
line 3016
;3015:	//if the weapon is used for the bot movement
;3016:	if (moveresult.flags & MOVERESULT_MOVEMENTWEAPON) bs->weaponnum = moveresult.weapon;
ADDRLP4 0+20
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1433
ADDRFP4 0
INDIRP4
CNSTI4 7804
ADDP4
ADDRLP4 0+24
INDIRI4
ASGNI4
LABELV $1433
line 3018
;3017:	//if there is an enemy
;3018:	if (BotFindEnemy(bs, -1)) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 176
ADDRGP4 BotFindEnemy
CALLI4
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 0
EQI4 $1437
line 3019
;3019:		if (BotWantsToRetreat(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 180
ADDRGP4 BotWantsToRetreat
CALLI4
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 0
EQI4 $1439
line 3021
;3020:			//keep the current long term goal and retreat
;3021:			AIEnter_Battle_NBG(bs, "seek nbg: found enemy");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1441
ARGP4
ADDRGP4 AIEnter_Battle_NBG
CALLV
pop
line 3022
;3022:		}
ADDRGP4 $1440
JUMPV
LABELV $1439
line 3023
;3023:		else {
line 3024
;3024:			trap_BotResetLastAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetLastAvoidReach
CALLV
pop
line 3026
;3025:			//empty the goal stack
;3026:			trap_BotEmptyGoalStack(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotEmptyGoalStack
CALLV
pop
line 3028
;3027:			//go fight
;3028:			AIEnter_Battle_Fight(bs, "seek nbg: found enemy");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1441
ARGP4
ADDRGP4 AIEnter_Battle_Fight
CALLV
pop
line 3029
;3029:		}
LABELV $1440
line 3030
;3030:	}
LABELV $1437
line 3031
;3031:	return qtrue;
CNSTI4 1
RETI4
LABELV $1374
endproc AINode_Seek_NBG 196 20
export AIEnter_Seek_LTG
proc AIEnter_Seek_LTG 144 16
line 3039
;3032:}
;3033:
;3034:/*
;3035:==================
;3036:AIEnter_Seek_LTG
;3037:==================
;3038:*/
;3039:void AIEnter_Seek_LTG(bot_state_t *bs, char *s) {
line 3052
;3040:	//bot_goal_t goal;	// JUHOX: no longer needed
;3041:	char buf[144];
;3042:
;3043:#if 0	// JUHOX: the goal stack is not relevant here
;3044:	if (trap_BotGetTopGoal(bs->gs, &goal)) {
;3045:		trap_BotGoalName(goal.number, buf, 144);
;3046:		BotRecordNodeSwitch(bs, "seek LTG", buf, s);
;3047:	}
;3048:	else {
;3049:		BotRecordNodeSwitch(bs, "seek LTG", "no goal", s);
;3050:	}
;3051:#else
;3052:	Com_sprintf(buf, sizeof(buf), "#%d", bs->ltgtype);
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 $1443
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 3053
;3053:	BotRecordNodeSwitch(bs, "seek LTG", buf, s);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1444
ARGP4
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotRecordNodeSwitch
CALLV
pop
line 3055
;3054:#endif
;3055:	bs->ainode = AINode_Seek_LTG;
ADDRFP4 0
INDIRP4
CNSTI4 4904
ADDP4
ADDRGP4 AINode_Seek_LTG
ASGNP4
line 3056
;3056:}
LABELV $1442
endproc AIEnter_Seek_LTG 144 16
export AINode_Seek_LTG
proc AINode_Seek_LTG 216 20
line 3064
;3057:
;3058:/*
;3059:==================
;3060:AINode_Seek_LTG
;3061:==================
;3062:*/
;3063:int AINode_Seek_LTG(bot_state_t *bs)
;3064:{
line 3072
;3065:	bot_goal_t goal;
;3066:	vec3_t target, dir;
;3067:	bot_moveresult_t moveresult;
;3068:	int range;
;3069:	//char buf[128];
;3070:	//bot_goal_t tmpgoal;
;3071:
;3072:	if (BotIsObserver(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 136
ADDRGP4 BotIsObserver
CALLI4
ASGNI4
ADDRLP4 136
INDIRI4
CNSTI4 0
EQI4 $1446
line 3073
;3073:		AIEnter_Observer(bs, "seek ltg: observer");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1448
ARGP4
ADDRGP4 AIEnter_Observer
CALLV
pop
line 3074
;3074:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1445
JUMPV
LABELV $1446
line 3077
;3075:	}
;3076:	//if in the intermission
;3077:	if (BotIntermission(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotIntermission
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $1449
line 3078
;3078:		AIEnter_Intermission(bs, "seek ltg: intermission");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1451
ARGP4
ADDRGP4 AIEnter_Intermission
CALLV
pop
line 3079
;3079:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1445
JUMPV
LABELV $1449
line 3082
;3080:	}
;3081:	//respawn if dead
;3082:	if (BotIsDead(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 144
ADDRGP4 BotIsDead
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $1452
line 3083
;3083:		AIEnter_Respawn(bs, "seek ltg: bot dead");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1454
ARGP4
ADDRGP4 AIEnter_Respawn
CALLV
pop
line 3084
;3084:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1445
JUMPV
LABELV $1452
line 3087
;3085:	}
;3086:	//
;3087:	if (BotChat_Random(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 148
ADDRGP4 BotChat_Random
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
EQI4 $1455
line 3088
;3088:		bs->stand_time = FloatTime() + BotChatTime(bs);
ADDRLP4 152
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 152
INDIRP4
ARGP4
ADDRLP4 156
ADDRGP4 BotChatTime
CALLF4
ASGNF4
ADDRLP4 152
INDIRP4
CNSTI4 7188
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 156
INDIRF4
ADDF4
ASGNF4
line 3089
;3089:		AIEnter_Stand(bs, "seek ltg: random chat");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1457
ARGP4
ADDRGP4 AIEnter_Stand
CALLV
pop
line 3090
;3090:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1445
JUMPV
LABELV $1455
line 3093
;3091:	}
;3092:	//
;3093:	bs->tfl = TFL_DEFAULT;
ADDRFP4 0
INDIRP4
CNSTI4 5984
ADDP4
CNSTI4 18616254
ASGNI4
line 3094
;3094:	if (bot_grapple.integer) bs->tfl |= TFL_GRAPPLEHOOK;
ADDRGP4 bot_grapple+12
INDIRI4
CNSTI4 0
EQI4 $1458
ADDRLP4 152
ADDRFP4 0
INDIRP4
CNSTI4 5984
ADDP4
ASGNP4
ADDRLP4 152
INDIRP4
ADDRLP4 152
INDIRP4
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
LABELV $1458
line 3096
;3095:	//if in lava or slime the bot should be able to get out
;3096:	if (BotInLavaOrSlime(bs)) bs->tfl |= TFL_LAVA|TFL_SLIME;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 156
ADDRGP4 BotInLavaOrSlime
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
EQI4 $1461
ADDRLP4 160
ADDRFP4 0
INDIRP4
CNSTI4 5984
ADDP4
ASGNP4
ADDRLP4 160
INDIRP4
ADDRLP4 160
INDIRP4
INDIRI4
CNSTI4 6291456
BORI4
ASGNI4
LABELV $1461
line 3098
;3097:	//
;3098:	if (BotCanAndWantsToRocketJump(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 164
ADDRGP4 BotCanAndWantsToRocketJump
CALLI4
ASGNI4
ADDRLP4 164
INDIRI4
CNSTI4 0
EQI4 $1463
line 3099
;3099:		bs->tfl |= TFL_ROCKETJUMP;
ADDRLP4 168
ADDRFP4 0
INDIRP4
CNSTI4 5984
ADDP4
ASGNP4
ADDRLP4 168
INDIRP4
ADDRLP4 168
INDIRP4
INDIRI4
CNSTI4 4096
BORI4
ASGNI4
line 3100
;3100:	}
LABELV $1463
line 3102
;3101:	//map specific code
;3102:	BotMapScripts(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotMapScripts
CALLV
pop
line 3104
;3103:	//no enemy
;3104:	bs->enemy = -1;
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
CNSTI4 -1
ASGNI4
line 3106
;3105:	//
;3106:	if (bs->killedenemy_time > FloatTime() - 2) {
ADDRFP4 0
INDIRP4
CNSTI4 7260
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
SUBF4
LEF4 $1465
line 3107
;3107:		if (random() < bs->thinktime * 1) {
ADDRLP4 168
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 168
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 168
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
GEF4 $1467
line 3108
;3108:			trap_EA_Gesture(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Gesture
CALLV
pop
line 3109
;3109:		}
LABELV $1467
line 3110
;3110:	}
LABELV $1465
line 3112
;3111:	//if there is an enemy
;3112:	if (BotFindEnemy(bs, -1)) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 168
ADDRGP4 BotFindEnemy
CALLI4
ASGNI4
ADDRLP4 168
INDIRI4
CNSTI4 0
EQI4 $1469
line 3113
;3113:		if (BotWantsToRetreat(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 172
ADDRGP4 BotWantsToRetreat
CALLI4
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 0
EQI4 $1471
line 3115
;3114:			//keep the current long term goal and retreat
;3115:			AIEnter_Battle_Retreat(bs, "seek ltg: found enemy");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1473
ARGP4
ADDRGP4 AIEnter_Battle_Retreat
CALLV
pop
line 3116
;3116:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1445
JUMPV
LABELV $1471
line 3118
;3117:		}
;3118:		else {
line 3119
;3119:			trap_BotResetLastAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetLastAvoidReach
CALLV
pop
line 3121
;3120:			//empty the goal stack
;3121:			trap_BotEmptyGoalStack(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotEmptyGoalStack
CALLV
pop
line 3123
;3122:			//go fight
;3123:			AIEnter_Battle_Fight(bs, "seek ltg: found enemy");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1473
ARGP4
ADDRGP4 AIEnter_Battle_Fight
CALLV
pop
line 3124
;3124:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1445
JUMPV
LABELV $1469
line 3138
;3125:		}
;3126:	}
;3127:	//
;3128:#if 0	// JUHOX: team goals not decided here
;3129:	BotTeamGoals(bs, qfalse);
;3130:#endif
;3131:#if 0	// JUHOX: get the LTG after checking for NBG's
;3132:	//get the current long term goal
;3133:	if (!BotLongTermGoal(bs, bs->tfl, qfalse, &goal)) {
;3134:		return qtrue;
;3135:	}
;3136:#endif
;3137:	//check for nearby goals periodicly
;3138:	if (bs->check_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 7184
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $1474
line 3139
;3139:		bs->check_time = FloatTime() + 0.5;
ADDRFP4 0
INDIRP4
CNSTI4 7184
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 3165
;3140:		//check if the bot wants to camp
;3141:		//BotWantsToCamp(bs);	// JUHOX: no camping
;3142:		//
;3143:#if 0	// JUHOX: new nearby goal ranges
;3144:		if (bs->ltgtype == LTG_DEFENDKEYAREA) range = 400;
;3145:		else range = 150;
;3146:		//
;3147:#ifdef CTF
;3148:		if (gametype == GT_CTF) {
;3149:			//if carrying a flag the bot shouldn't be distracted too much
;3150:			if (BotCTFCarryingFlag(bs))
;3151:				range = 50;
;3152:		}
;3153:#endif //CTF
;3154:#ifdef MISSIONPACK
;3155:		else if (gametype == GT_1FCTF) {
;3156:			if (Bot1FCTFCarryingFlag(bs))
;3157:				range = 50;
;3158:		}
;3159:		else if (gametype == GT_HARVESTER) {
;3160:			if (BotHarvesterCarryingCubes(bs))
;3161:				range = 80;
;3162:		}
;3163:#endif
;3164:#else
;3165:		switch (bs->ltgtype) {
ADDRLP4 172
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 0
LTI4 $1476
ADDRLP4 172
INDIRI4
CNSTI4 7
GTI4 $1507
ADDRLP4 172
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1508
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1508
address $1487
address $1476
address $1476
address $1479
address $1476
address $1483
address $1476
address $1480
code
LABELV $1507
ADDRLP4 172
INDIRI4
CNSTI4 16
EQI4 $1481
ADDRLP4 172
INDIRI4
CNSTI4 17
EQI4 $1482
ADDRGP4 $1476
JUMPV
LABELV $1479
line 3167
;3166:		case LTG_DEFENDKEYAREA:
;3167:			range = 400;
ADDRLP4 120
CNSTI4 400
ASGNI4
line 3168
;3168:			break;
ADDRGP4 $1477
JUMPV
LABELV $1480
line 3170
;3169:		case LTG_CAMP:
;3170:			range = 1000;
ADDRLP4 120
CNSTI4 1000
ASGNI4
line 3171
;3171:			break;
ADDRGP4 $1477
JUMPV
LABELV $1481
line 3173
;3172:		case LTG_ESCAPE:
;3173:			range = 600;	// note: we don't have an enemy yet
ADDRLP4 120
CNSTI4 600
ASGNI4
line 3174
;3174:			break;
ADDRGP4 $1477
JUMPV
LABELV $1482
line 3176
;3175:		case LTG_WAIT:
;3176:			range = 0;
ADDRLP4 120
CNSTI4 0
ASGNI4
line 3177
;3177:			break;
ADDRGP4 $1477
JUMPV
LABELV $1483
line 3180
;3178:		case LTG_RUSHBASE:
;3179:			if (
;3180:				BotOwnFlagStatus(bs) == FLAG_ATBASE ||
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 184
ADDRGP4 BotOwnFlagStatus
CALLI4
ASGNI4
ADDRLP4 184
INDIRI4
CNSTI4 0
EQI4 $1486
ADDRLP4 188
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 188
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ARGI4
ADDRLP4 188
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
CNSTF4 1082130432
ARGF4
ADDRLP4 192
ADDRGP4 NearHomeBase
CALLI4
ASGNI4
ADDRLP4 192
INDIRI4
CNSTI4 0
NEI4 $1484
LABELV $1486
line 3182
;3181:				!NearHomeBase(bs->cur_ps.persistant[PERS_TEAM], bs->origin, 4)
;3182:			) range = 100;
ADDRLP4 120
CNSTI4 100
ASGNI4
ADDRGP4 $1477
JUMPV
LABELV $1484
line 3183
;3183:			else range = 600;
ADDRLP4 120
CNSTI4 600
ASGNI4
line 3184
;3184:			break;
ADDRGP4 $1477
JUMPV
LABELV $1487
line 3186
;3185:		case 0:
;3186:			range = 1000;
ADDRLP4 120
CNSTI4 1000
ASGNI4
line 3188
;3187:#if MONSTER_MODE
;3188:			if (g_gametype.integer >= GT_STU) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
LTI4 $1477
line 3189
;3189:				if (BotPlayerDanger(&bs->cur_ps) >= 25) {
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 196
ADDRGP4 BotPlayerDanger
CALLI4
ASGNI4
ADDRLP4 196
INDIRI4
CNSTI4 25
LTI4 $1491
line 3190
;3190:					range = 600;
ADDRLP4 120
CNSTI4 600
ASGNI4
line 3191
;3191:				}
ADDRGP4 $1477
JUMPV
LABELV $1491
line 3192
;3192:				else {
line 3193
;3193:					range = 300;
ADDRLP4 120
CNSTI4 300
ASGNI4
line 3194
;3194:				}
line 3195
;3195:			}
line 3197
;3196:#endif
;3197:			break;
ADDRGP4 $1477
JUMPV
LABELV $1476
line 3199
;3198:		default:
;3199:			if (BotCTFCarryingFlag(bs)) range = 150;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 196
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 196
INDIRI4
CNSTI4 0
EQI4 $1493
ADDRLP4 120
CNSTI4 150
ASGNI4
ADDRGP4 $1494
JUMPV
LABELV $1493
line 3200
;3200:			else if (LTGNearlyFulfilled(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 200
ADDRGP4 LTGNearlyFulfilled
CALLI4
ASGNI4
ADDRLP4 200
INDIRI4
CNSTI4 0
EQI4 $1495
line 3203
;3201:#if BOTS_USE_TSS
;3202:				if (
;3203:					BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_isValid) &&
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 204
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 204
INDIRI4
CNSTI4 0
EQI4 $1497
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTI4 6
ARGI4
ADDRLP4 208
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 208
INDIRI4
CNSTI4 0
NEI4 $1497
line 3205
;3204:					BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_groupFormation) == TSSGF_tight
;3205:				) {
line 3206
;3206:					range = 200;
ADDRLP4 120
CNSTI4 200
ASGNI4
line 3207
;3207:				}
ADDRGP4 $1496
JUMPV
LABELV $1497
line 3210
;3208:				else
;3209:#endif
;3210:				{
line 3211
;3211:					range = 1000;
ADDRLP4 120
CNSTI4 1000
ASGNI4
line 3213
;3212:#if MONSTER_MODE
;3213:					if (g_gametype.integer >= GT_STU) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
LTI4 $1496
line 3214
;3214:						if (BotPlayerDanger(&bs->cur_ps) >= 25) {
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 212
ADDRGP4 BotPlayerDanger
CALLI4
ASGNI4
ADDRLP4 212
INDIRI4
CNSTI4 25
LTI4 $1502
line 3215
;3215:							range = 500;
ADDRLP4 120
CNSTI4 500
ASGNI4
line 3216
;3216:						}
ADDRGP4 $1503
JUMPV
LABELV $1502
line 3217
;3217:						else {
line 3218
;3218:							range = 250;
ADDRLP4 120
CNSTI4 250
ASGNI4
line 3219
;3219:						}
LABELV $1503
line 3220
;3220:						if (!g_cloakingDevice.integer) range *= 1.5;
ADDRGP4 g_cloakingDevice+12
INDIRI4
CNSTI4 0
NEI4 $1496
ADDRLP4 120
ADDRLP4 120
INDIRI4
CVIF4 4
CNSTF4 1069547520
MULF4
CVFI4 4
ASGNI4
line 3221
;3221:					}
line 3223
;3222:#endif
;3223:				}
line 3224
;3224:			}
ADDRGP4 $1496
JUMPV
LABELV $1495
line 3225
;3225:			else range = 150;
ADDRLP4 120
CNSTI4 150
ASGNI4
LABELV $1496
LABELV $1494
line 3226
;3226:		}
LABELV $1477
line 3229
;3227:#endif
;3228:		//
;3229:		if (BotNearbyGoal(bs, bs->tfl, &goal, range)) {
ADDRLP4 184
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 184
INDIRP4
ARGP4
ADDRLP4 184
INDIRP4
CNSTI4 5984
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
ARGP4
ADDRLP4 120
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 188
ADDRGP4 BotNearbyGoal
CALLI4
ASGNI4
ADDRLP4 188
INDIRI4
CNSTI4 0
EQI4 $1509
line 3230
;3230:			trap_BotResetLastAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetLastAvoidReach
CALLV
pop
line 3236
;3231:			//get the goal at the top of the stack
;3232:			//trap_BotGetTopGoal(bs->gs, &tmpgoal);
;3233:			//trap_BotGoalName(tmpgoal.number, buf, 144);
;3234:			//BotAI_Print(PRT_MESSAGE, "new nearby goal %s\n", buf);
;3235:			//time the bot gets to pick up the nearby goal item
;3236:			bs->nbg_time = FloatTime() + 4 + range * 0.01;
ADDRFP4 0
INDIRP4
CNSTI4 6092
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1082130432
ADDF4
ADDRLP4 120
INDIRI4
CVIF4 4
CNSTF4 1008981770
MULF4
ADDF4
ASGNF4
line 3237
;3237:			AIEnter_Seek_NBG(bs, "ltg seek: nbg");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1511
ARGP4
ADDRGP4 AIEnter_Seek_NBG
CALLV
pop
line 3238
;3238:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1445
JUMPV
LABELV $1509
line 3240
;3239:		}
;3240:	}
LABELV $1474
line 3243
;3241:#if 1	// JUHOX: get the LTG after checking for NBG's
;3242:	//get the current long term goal
;3243:	if (!BotLongTermGoal(bs, bs->tfl, qfalse, &goal)) {
ADDRLP4 172
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 172
INDIRP4
ARGP4
ADDRLP4 172
INDIRP4
CNSTI4 5984
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 52
ARGP4
ADDRLP4 176
ADDRGP4 BotLongTermGoal
CALLI4
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 0
NEI4 $1512
line 3244
;3244:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1445
JUMPV
LABELV $1512
line 3248
;3245:	}
;3246:#endif
;3247:	//predict obstacles
;3248:	if (BotAIPredictObstacles(bs, &goal))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ARGP4
ADDRLP4 180
ADDRGP4 BotAIPredictObstacles
CALLI4
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 0
EQI4 $1514
line 3249
;3249:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1445
JUMPV
LABELV $1514
line 3251
;3250:	//initialize the movement state
;3251:	BotSetupForMovement(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetupForMovement
CALLV
pop
line 3253
;3252:	//move towards the goal
;3253:	trap_BotMoveToGoal(&moveresult, bs->ms, &goal, bs->tfl);
ADDRLP4 0
ARGP4
ADDRLP4 184
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 184
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
ARGP4
ADDRLP4 184
INDIRP4
CNSTI4 5984
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotMoveToGoal
CALLV
pop
line 3255
;3254:	//if the movement failed
;3255:	if (moveresult.failure) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1516
line 3257
;3256:		//reset the avoid reach, otherwise bot is stuck in current area
;3257:		trap_BotResetAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidReach
CALLV
pop
line 3259
;3258:		//BotAI_Print(PRT_MESSAGE, "movement failure %d\n", moveresult.traveltype);
;3259:		bs->ltg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6088
ADDP4
CNSTF4 0
ASGNF4
line 3260
;3260:		bs->ltgtype = 0;	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
line 3261
;3261:		if (goal.flags & GFL_ITEM) BotRememberLTGItemUnreachable(bs, goal.entitynum);	// JUHOX
ADDRLP4 52+48
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1518
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52+40
INDIRI4
ARGI4
ADDRGP4 BotRememberLTGItemUnreachable
CALLV
pop
LABELV $1518
line 3262
;3262:	}
LABELV $1516
line 3264
;3263:	//
;3264:	BotAIBlocked(bs, &moveresult, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BotAIBlocked
CALLV
pop
line 3266
;3265:	//
;3266:	BotClearPath(bs, &moveresult);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotClearPath
CALLV
pop
line 3268
;3267:	//if the viewangles are used for the movement
;3268:	if (moveresult.flags & (MOVERESULT_MOVEMENTVIEWSET|MOVERESULT_MOVEMENTVIEW|MOVERESULT_SWIMVIEW)) {
ADDRLP4 0+20
INDIRI4
CNSTI4 11
BANDI4
CNSTI4 0
EQI4 $1522
line 3269
;3269:		VectorCopy(moveresult.ideal_viewangles, bs->ideal_viewangles);
ADDRFP4 0
INDIRP4
CNSTI4 7852
ADDP4
ADDRLP4 0+40
INDIRB
ASGNB 12
line 3270
;3270:		bs->specialMove = qtrue;	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 7744
ADDP4
CNSTI4 1
ASGNI4
line 3271
;3271:	}
ADDRGP4 $1523
JUMPV
LABELV $1522
line 3273
;3272:	//if waiting for something
;3273:	else if (moveresult.flags & MOVERESULT_WAITING) {
ADDRLP4 0+20
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $1526
line 3278
;3274:#if 0	// JUHOX: new roaming view strategy
;3275:		if (random() < bs->thinktime * 0.8) {
;3276:			BotRoamGoal(bs, target);
;3277:#else
;3278:		if (BotRoamGoal(bs, target, qfalse)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 108
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 188
ADDRGP4 BotRoamGoal
CALLI4
ASGNI4
ADDRLP4 188
INDIRI4
CNSTI4 0
EQI4 $1527
line 3280
;3279:#endif
;3280:			VectorSubtract(target, bs->origin, dir);
ADDRLP4 192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 124
ADDRLP4 108
INDIRF4
ADDRLP4 192
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 124+4
ADDRLP4 108+4
INDIRF4
ADDRLP4 192
INDIRP4
CNSTI4 4920
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 124+8
ADDRLP4 108+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3281
;3281:			vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 124
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 7852
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 3282
;3282:			bs->ideal_viewangles[2] *= 0.5;
ADDRLP4 196
ADDRFP4 0
INDIRP4
CNSTI4 7860
ADDP4
ASGNP4
ADDRLP4 196
INDIRP4
ADDRLP4 196
INDIRP4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 3283
;3283:		}
line 3284
;3284:	}
ADDRGP4 $1527
JUMPV
LABELV $1526
line 3285
;3285:	else if (!(bs->flags & BFL_IDEALVIEWSET)) {
ADDRFP4 0
INDIRP4
CNSTI4 5992
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
NEI4 $1535
line 3287
;3286:#if 1	// JUHOX: look around if nearly reached the ltg
;3287:		if (LTGNearlyFulfilled(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 188
ADDRGP4 LTGNearlyFulfilled
CALLI4
ASGNI4
ADDRLP4 188
INDIRI4
CNSTI4 0
EQI4 $1537
line 3288
;3288:			if (BotRoamGoal(bs, target, qfalse)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 108
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 192
ADDRGP4 BotRoamGoal
CALLI4
ASGNI4
ADDRLP4 192
INDIRI4
CNSTI4 0
EQI4 $1539
line 3289
;3289:				bs->roamgoalcnt--;
ADDRLP4 196
ADDRFP4 0
INDIRP4
CNSTI4 11528
ADDP4
ASGNP4
ADDRLP4 196
INDIRP4
ADDRLP4 196
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 3290
;3290:				if (bs->roamgoalcnt < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 11528
ADDP4
INDIRI4
CNSTI4 0
GEI4 $1541
line 3291
;3291:					bs->roamgoalcnt = 1 + (rand() & 1);
ADDRLP4 200
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 11528
ADDP4
ADDRLP4 200
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 1
ADDI4
ASGNI4
line 3292
;3292:				}
LABELV $1541
line 3293
;3293:				if (bs->roamgoalcnt > 0) {
ADDRFP4 0
INDIRP4
CNSTI4 11528
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1538
line 3294
;3294:					goto SetViewAngles;
ADDRGP4 $1545
JUMPV
line 3296
;3295:				}
;3296:			}
LABELV $1539
line 3297
;3297:			else if (bs->roamgoalcnt > 0) goto ViewAnglesSet;
ADDRFP4 0
INDIRP4
CNSTI4 11528
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1538
ADDRGP4 $1548
JUMPV
line 3298
;3298:		}
LABELV $1537
line 3299
;3299:		else {
line 3300
;3300:			if (BotRoamGoal(bs, target, qtrue)) goto SetViewAngles;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 108
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 192
ADDRGP4 BotRoamGoal
CALLI4
ASGNI4
ADDRLP4 192
INDIRI4
CNSTI4 0
EQI4 $1549
ADDRGP4 $1545
JUMPV
LABELV $1549
line 3301
;3301:		}
LABELV $1538
line 3303
;3302:#endif
;3303:		if (trap_BotMovementViewTarget(bs->ms, &goal, bs->tfl, 300, target)) {
ADDRLP4 192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 192
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
ARGP4
ADDRLP4 192
INDIRP4
CNSTI4 5984
ADDP4
INDIRI4
ARGI4
CNSTF4 1133903872
ARGF4
ADDRLP4 108
ARGP4
ADDRLP4 196
ADDRGP4 trap_BotMovementViewTarget
CALLI4
ASGNI4
ADDRLP4 196
INDIRI4
CNSTI4 0
EQI4 $1551
line 3304
;3304:			VectorSubtract(target, bs->origin, dir);
ADDRLP4 200
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 124
ADDRLP4 108
INDIRF4
ADDRLP4 200
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 124+4
ADDRLP4 108+4
INDIRF4
ADDRLP4 200
INDIRP4
CNSTI4 4920
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 124+8
ADDRLP4 108+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3305
;3305:			vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 124
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 7852
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 3306
;3306:		}
ADDRGP4 $1552
JUMPV
LABELV $1551
line 3308
;3307:		//FIXME: look at cluster portals?
;3308:		else if (VectorLengthSquared(moveresult.movedir)) {
ADDRLP4 0+28
ARGP4
ADDRLP4 200
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 200
INDIRF4
CNSTF4 0
EQF4 $1557
line 3309
;3309:			vectoangles(moveresult.movedir, bs->ideal_viewangles);
ADDRLP4 0+28
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 7852
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 3310
;3310:		}
ADDRGP4 $1558
JUMPV
LABELV $1557
line 3316
;3311:		// JUHOX: new roaming view strategy
;3312:#if 0
;3313:		else if (random() < bs->thinktime * 0.8) {
;3314:			BotRoamGoal(bs, target);
;3315:#else
;3316:		else if (BotRoamGoal(bs, target, qfalse)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 108
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 204
ADDRGP4 BotRoamGoal
CALLI4
ASGNI4
ADDRLP4 204
INDIRI4
CNSTI4 0
EQI4 $1561
LABELV $1545
line 3319
;3317:#endif
;3318:			SetViewAngles:	// JUHOX
;3319:			VectorSubtract(target, bs->origin, dir);
ADDRLP4 208
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 124
ADDRLP4 108
INDIRF4
ADDRLP4 208
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 124+4
ADDRLP4 108+4
INDIRF4
ADDRLP4 208
INDIRP4
CNSTI4 4920
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 124+8
ADDRLP4 108+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3320
;3320:			vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 124
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 7852
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 3321
;3321:			bs->ideal_viewangles[2] *= 0.5;
ADDRLP4 212
ADDRFP4 0
INDIRP4
CNSTI4 7860
ADDP4
ASGNP4
ADDRLP4 212
INDIRP4
ADDRLP4 212
INDIRP4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 3322
;3322:		}
LABELV $1561
LABELV $1558
LABELV $1552
line 3324
;3323:		//bs->ideal_viewangles[2] *= 0.5;	// JUHOX: already done
;3324:	}
LABELV $1535
LABELV $1527
LABELV $1523
LABELV $1548
line 3326
;3325:	ViewAnglesSet:	// JUHOX
;3326:	BotCheckForWeaponJump(bs, &moveresult);	// JUHOX
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotCheckForWeaponJump
CALLV
pop
line 3328
;3327:	//if the weapon is used for the bot movement
;3328:	if (moveresult.flags & MOVERESULT_MOVEMENTWEAPON) bs->weaponnum = moveresult.weapon;
ADDRLP4 0+20
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1567
ADDRFP4 0
INDIRP4
CNSTI4 7804
ADDP4
ADDRLP4 0+24
INDIRI4
ASGNI4
LABELV $1567
line 3330
;3329:	//
;3330:	return qtrue;
CNSTI4 1
RETI4
LABELV $1445
endproc AINode_Seek_LTG 216 20
export AIEnter_Battle_Fight
proc AIEnter_Battle_Fight 4 16
line 3338
;3331:}
;3332:
;3333:/*
;3334:==================
;3335:AIEnter_Battle_Fight
;3336:==================
;3337:*/
;3338:void AIEnter_Battle_Fight(bot_state_t *bs, char *s) {
line 3339
;3339:	BotRecordNodeSwitch(bs, "battle fight", "", s);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1572
ARGP4
ADDRGP4 $99
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotRecordNodeSwitch
CALLV
pop
line 3340
;3340:	trap_BotResetLastAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetLastAvoidReach
CALLV
pop
line 3341
;3341:	bs->ainode = AINode_Battle_Fight;
ADDRFP4 0
INDIRP4
CNSTI4 4904
ADDP4
ADDRGP4 AINode_Battle_Fight
ASGNP4
line 3342
;3342:	bs->flags &= ~BFL_FIGHTSUICIDAL;	// JUHOX BUGFIX (really needed?)
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 5992
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 -65
BANDI4
ASGNI4
line 3343
;3343:}
LABELV $1571
endproc AIEnter_Battle_Fight 4 16
export AIEnter_Battle_SuicidalFight
proc AIEnter_Battle_SuicidalFight 4 16
line 3350
;3344:
;3345:/*
;3346:==================
;3347:AIEnter_Battle_Fight
;3348:==================
;3349:*/
;3350:void AIEnter_Battle_SuicidalFight(bot_state_t *bs, char *s) {
line 3351
;3351:	BotRecordNodeSwitch(bs, "battle fight", "", s);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1572
ARGP4
ADDRGP4 $99
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotRecordNodeSwitch
CALLV
pop
line 3352
;3352:	trap_BotResetLastAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetLastAvoidReach
CALLV
pop
line 3353
;3353:	bs->ainode = AINode_Battle_Fight;
ADDRFP4 0
INDIRP4
CNSTI4 4904
ADDP4
ADDRGP4 AINode_Battle_Fight
ASGNP4
line 3354
;3354:	bs->flags |= BFL_FIGHTSUICIDAL;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 5992
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
line 3355
;3355:}
LABELV $1573
endproc AIEnter_Battle_SuicidalFight 4 16
export AINode_Battle_Fight
proc AINode_Battle_Fight 340 16
line 3362
;3356:
;3357:/*
;3358:==================
;3359:AINode_Battle_Fight
;3360:==================
;3361:*/
;3362:int AINode_Battle_Fight(bot_state_t *bs) {
line 3368
;3363:	int areanum;
;3364:	vec3_t target;
;3365:	aas_entityinfo_t entinfo;
;3366:	bot_moveresult_t moveresult;
;3367:
;3368:	if (BotIsObserver(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 208
ADDRGP4 BotIsObserver
CALLI4
ASGNI4
ADDRLP4 208
INDIRI4
CNSTI4 0
EQI4 $1575
line 3369
;3369:		AIEnter_Observer(bs, "battle fight: observer");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1577
ARGP4
ADDRGP4 AIEnter_Observer
CALLV
pop
line 3370
;3370:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1574
JUMPV
LABELV $1575
line 3374
;3371:	}
;3372:
;3373:	//if in the intermission
;3374:	if (BotIntermission(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 212
ADDRGP4 BotIntermission
CALLI4
ASGNI4
ADDRLP4 212
INDIRI4
CNSTI4 0
EQI4 $1578
line 3375
;3375:		AIEnter_Intermission(bs, "battle fight: intermission");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1580
ARGP4
ADDRGP4 AIEnter_Intermission
CALLV
pop
line 3376
;3376:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1574
JUMPV
LABELV $1578
line 3379
;3377:	}
;3378:	//respawn if dead
;3379:	if (BotIsDead(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 216
ADDRGP4 BotIsDead
CALLI4
ASGNI4
ADDRLP4 216
INDIRI4
CNSTI4 0
EQI4 $1581
line 3380
;3380:		AIEnter_Respawn(bs, "battle fight: bot dead");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1583
ARGP4
ADDRGP4 AIEnter_Respawn
CALLV
pop
line 3381
;3381:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1574
JUMPV
LABELV $1581
line 3384
;3382:	}
;3383:	//if there is another better enemy
;3384:	if (BotFindEnemy(bs, bs->enemy)) {
ADDRLP4 220
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 220
INDIRP4
ARGP4
ADDRLP4 220
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
ARGI4
ADDRLP4 224
ADDRGP4 BotFindEnemy
CALLI4
ASGNI4
ADDRLP4 224
INDIRI4
CNSTI4 0
EQI4 $1584
line 3388
;3385:#ifdef DEBUG
;3386:		BotAI_Print(PRT_MESSAGE, "found new better enemy\n");
;3387:#endif
;3388:	}
LABELV $1584
line 3390
;3389:	//if no enemy
;3390:	if (bs->enemy < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 0
GEI4 $1586
line 3391
;3391:		AIEnter_Seek_LTG(bs, "battle fight: no enemy");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1588
ARGP4
ADDRGP4 AIEnter_Seek_LTG
CALLV
pop
line 3392
;3392:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1574
JUMPV
LABELV $1586
line 3395
;3393:	}
;3394:	//
;3395:	BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3397
;3396:	//if the enemy is dead
;3397:	if (bs->enemydeath_time) {
ADDRFP4 0
INDIRP4
CNSTI4 7228
ADDP4
INDIRF4
CNSTF4 0
EQF4 $1589
line 3398
;3398:		if (bs->enemydeath_time < FloatTime() - 1.0) {
ADDRFP4 0
INDIRP4
CNSTI4 7228
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
SUBF4
GEF4 $1590
line 3399
;3399:			bs->enemydeath_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7228
ADDP4
CNSTF4 0
ASGNF4
line 3400
;3400:			if (bs->enemysuicide) {
ADDRFP4 0
INDIRP4
CNSTI4 6032
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1593
line 3401
;3401:				BotChat_EnemySuicide(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotChat_EnemySuicide
CALLI4
pop
line 3402
;3402:			}
LABELV $1593
line 3403
;3403:			if (bs->lastkilledplayer == bs->enemy && BotChat_Kill(bs)) {
ADDRLP4 228
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 228
INDIRP4
CNSTI4 6012
ADDP4
INDIRI4
ADDRLP4 228
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
NEI4 $1595
ADDRLP4 228
INDIRP4
ARGP4
ADDRLP4 232
ADDRGP4 BotChat_Kill
CALLI4
ASGNI4
ADDRLP4 232
INDIRI4
CNSTI4 0
EQI4 $1595
line 3404
;3404:				bs->stand_time = FloatTime() + BotChatTime(bs);
ADDRLP4 236
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 236
INDIRP4
ARGP4
ADDRLP4 240
ADDRGP4 BotChatTime
CALLF4
ASGNF4
ADDRLP4 236
INDIRP4
CNSTI4 7188
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 240
INDIRF4
ADDF4
ASGNF4
line 3405
;3405:				AIEnter_Stand(bs, "battle fight: enemy dead");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1597
ARGP4
ADDRGP4 AIEnter_Stand
CALLV
pop
line 3406
;3406:			}
ADDRGP4 $1596
JUMPV
LABELV $1595
line 3407
;3407:			else {
line 3408
;3408:				bs->ltg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6088
ADDP4
CNSTF4 0
ASGNF4
line 3409
;3409:				AIEnter_Seek_LTG(bs, "battle fight: enemy dead");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1597
ARGP4
ADDRGP4 AIEnter_Seek_LTG
CALLV
pop
line 3410
;3410:			}
LABELV $1596
line 3411
;3411:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1574
JUMPV
line 3413
;3412:		}
;3413:	}
LABELV $1589
line 3414
;3414:	else {
line 3415
;3415:		if (EntityIsDead(&entinfo)) {
ADDRLP4 68
ARGP4
ADDRLP4 228
ADDRGP4 EntityIsDead
CALLI4
ASGNI4
ADDRLP4 228
INDIRI4
CNSTI4 0
EQI4 $1598
line 3416
;3416:			bs->enemydeath_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7228
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 3417
;3417:			bs->check_time = 0;	// JUHOX: the enemy might have lost something (armor, flags, ...)
ADDRFP4 0
INDIRP4
CNSTI4 7184
ADDP4
CNSTF4 0
ASGNF4
line 3418
;3418:		}
LABELV $1598
line 3419
;3419:	}
LABELV $1590
line 3430
;3420:#if 0	// JUHOX: Invisibility handled by BotEntityVisible() (see below)
;3421:	//if the enemy is invisible and not shooting the bot looses track easily
;3422:	if (EntityIsInvisible(bs->client, &entinfo) && !EntityIsShooting(&entinfo)) {	// JUHOX: added 'bs->client'
;3423:		if (random() < 0.2) {
;3424:			AIEnter_Seek_LTG(bs, "battle fight: invisible");
;3425:			return qfalse;
;3426:		}
;3427:	}
;3428:#endif
;3429:	//
;3430:	VectorCopy(entinfo.origin, target);
ADDRLP4 56
ADDRLP4 68+24
INDIRB
ASGNB 12
line 3432
;3431:	// if not a player enemy
;3432:	if (bs->enemy >= MAX_CLIENTS) {
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 64
LTI4 $1601
line 3440
;3433:#ifdef MISSIONPACK
;3434:		// if attacking an obelisk
;3435:		if ( bs->enemy == redobelisk.entitynum ||
;3436:			bs->enemy == blueobelisk.entitynum ) {
;3437:			target[2] += 16;
;3438:		}
;3439:#endif
;3440:	}
LABELV $1601
line 3442
;3441:	//update the reachability area and origin if possible
;3442:	areanum = BotPointAreaNum(target);
ADDRLP4 56
ARGP4
ADDRLP4 228
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 52
ADDRLP4 228
INDIRI4
ASGNI4
line 3443
;3443:	if (areanum && trap_AAS_AreaReachability(areanum)) {
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $1603
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 236
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 236
INDIRI4
CNSTI4 0
EQI4 $1603
line 3444
;3444:		VectorCopy(target, bs->lastenemyorigin);
ADDRFP4 0
INDIRP4
CNSTI4 7772
ADDP4
ADDRLP4 56
INDIRB
ASGNB 12
line 3445
;3445:		bs->lastenemyareanum = areanum;
ADDRFP4 0
INDIRP4
CNSTI4 7768
ADDP4
ADDRLP4 52
INDIRI4
ASGNI4
line 3446
;3446:	}
LABELV $1603
line 3448
;3447:	//update the attack inventory values
;3448:	BotUpdateBattleInventory(bs, bs->enemy);
ADDRLP4 240
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 240
INDIRP4
ARGP4
ADDRLP4 240
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotUpdateBattleInventory
CALLV
pop
line 3450
;3449:	//if the bot's health decreased
;3450:	if (bs->lastframe_health > bs->inventory[INVENTORY_HEALTH]) {
ADDRLP4 244
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 244
INDIRP4
CNSTI4 6064
ADDP4
INDIRI4
ADDRLP4 244
INDIRP4
CNSTI4 5076
ADDP4
INDIRI4
LEI4 $1605
line 3451
;3451:		if (BotChat_HitNoDeath(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 248
ADDRGP4 BotChat_HitNoDeath
CALLI4
ASGNI4
ADDRLP4 248
INDIRI4
CNSTI4 0
EQI4 $1607
line 3452
;3452:			bs->stand_time = FloatTime() + BotChatTime(bs);
ADDRLP4 252
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 252
INDIRP4
ARGP4
ADDRLP4 256
ADDRGP4 BotChatTime
CALLF4
ASGNF4
ADDRLP4 252
INDIRP4
CNSTI4 7188
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 256
INDIRF4
ADDF4
ASGNF4
line 3453
;3453:			AIEnter_Stand(bs, "battle fight: chat health decreased");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1609
ARGP4
ADDRGP4 AIEnter_Stand
CALLV
pop
line 3454
;3454:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1574
JUMPV
LABELV $1607
line 3456
;3455:		}
;3456:	}
LABELV $1605
line 3458
;3457:	//if the bot hit someone
;3458:	if (bs->cur_ps.persistant[PERS_HITS] > bs->lasthitcount) {
ADDRLP4 248
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 248
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
ADDRLP4 248
INDIRP4
CNSTI4 6068
ADDP4
INDIRI4
LEI4 $1610
line 3459
;3459:		if (BotChat_HitNoKill(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 252
ADDRGP4 BotChat_HitNoKill
CALLI4
ASGNI4
ADDRLP4 252
INDIRI4
CNSTI4 0
EQI4 $1612
line 3460
;3460:			bs->stand_time = FloatTime() + BotChatTime(bs);
ADDRLP4 256
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 256
INDIRP4
ARGP4
ADDRLP4 260
ADDRGP4 BotChatTime
CALLF4
ASGNF4
ADDRLP4 256
INDIRP4
CNSTI4 7188
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 260
INDIRF4
ADDF4
ASGNF4
line 3461
;3461:			AIEnter_Stand(bs, "battle fight: chat hit someone");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1614
ARGP4
ADDRGP4 AIEnter_Stand
CALLV
pop
line 3462
;3462:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1574
JUMPV
LABELV $1612
line 3464
;3463:		}
;3464:	}
LABELV $1610
line 3466
;3465:	//if the enemy is not visible
;3466:	if (!BotEntityVisible(&bs->cur_ps/*bs->entitynum, bs->eye, bs->viewangles*/, 360, bs->enemy)) {	// JUHOX
ADDRLP4 252
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 252
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 252
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
ARGI4
ADDRLP4 256
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 256
INDIRF4
CNSTF4 0
NEF4 $1615
line 3467
;3467:		bs->flags ^= BFL_STRAFERIGHT;	// JUHOX: the enemy may be vanished because of an unlucky attack move
ADDRLP4 260
ADDRFP4 0
INDIRP4
CNSTI4 5992
ADDP4
ASGNP4
ADDRLP4 260
INDIRP4
ADDRLP4 260
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 3468
;3468:		if (BotWantsToChase(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 264
ADDRGP4 BotWantsToChase
CALLI4
ASGNI4
ADDRLP4 264
INDIRI4
CNSTI4 0
EQI4 $1617
line 3469
;3469:			AIEnter_Battle_Chase(bs, "battle fight: enemy out of sight");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1619
ARGP4
ADDRGP4 AIEnter_Battle_Chase
CALLV
pop
line 3470
;3470:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1574
JUMPV
LABELV $1617
line 3472
;3471:		}
;3472:		else {
line 3473
;3473:			AIEnter_Seek_LTG(bs, "battle fight: enemy out of sight");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1619
ARGP4
ADDRGP4 AIEnter_Seek_LTG
CALLV
pop
line 3474
;3474:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1574
JUMPV
LABELV $1615
line 3477
;3475:		}
;3476:	}
;3477:	bs->lastEnemyAreaPredicted = qfalse;	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 7784
ADDP4
CNSTI4 0
ASGNI4
line 3478
;3478:	bs->enemyvisible_time = FloatTime();	// JUHOX: needed for the "contact"-message
ADDRFP4 0
INDIRP4
CNSTI4 7180
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 3480
;3479:	//use holdable items
;3480:	BotBattleUseItems(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotBattleUseItems
CALLV
pop
line 3482
;3481:	//
;3482:	bs->tfl = TFL_DEFAULT;
ADDRFP4 0
INDIRP4
CNSTI4 5984
ADDP4
CNSTI4 18616254
ASGNI4
line 3483
;3483:	if (bot_grapple.integer) bs->tfl |= TFL_GRAPPLEHOOK;
ADDRGP4 bot_grapple+12
INDIRI4
CNSTI4 0
EQI4 $1620
ADDRLP4 260
ADDRFP4 0
INDIRP4
CNSTI4 5984
ADDP4
ASGNP4
ADDRLP4 260
INDIRP4
ADDRLP4 260
INDIRP4
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
LABELV $1620
line 3485
;3484:	//if in lava or slime the bot should be able to get out
;3485:	if (BotInLavaOrSlime(bs)) bs->tfl |= TFL_LAVA|TFL_SLIME;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 264
ADDRGP4 BotInLavaOrSlime
CALLI4
ASGNI4
ADDRLP4 264
INDIRI4
CNSTI4 0
EQI4 $1623
ADDRLP4 268
ADDRFP4 0
INDIRP4
CNSTI4 5984
ADDP4
ASGNP4
ADDRLP4 268
INDIRP4
ADDRLP4 268
INDIRP4
INDIRI4
CNSTI4 6291456
BORI4
ASGNI4
LABELV $1623
line 3487
;3486:	//
;3487:	if (BotCanAndWantsToRocketJump(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 272
ADDRGP4 BotCanAndWantsToRocketJump
CALLI4
ASGNI4
ADDRLP4 272
INDIRI4
CNSTI4 0
EQI4 $1625
line 3488
;3488:		bs->tfl |= TFL_ROCKETJUMP;
ADDRLP4 276
ADDRFP4 0
INDIRP4
CNSTI4 5984
ADDP4
ASGNP4
ADDRLP4 276
INDIRP4
ADDRLP4 276
INDIRP4
INDIRI4
CNSTI4 4096
BORI4
ASGNI4
line 3489
;3489:	}
LABELV $1625
line 3492
;3490:	// JUHOX: check for nearby goals periodicly
;3491:#if 1
;3492:	if (bs->check_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 7184
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $1627
line 3495
;3493:		bot_goal_t goal;
;3494:
;3495:		bs->check_time = FloatTime() + 1;
ADDRFP4 0
INDIRP4
CNSTI4 7184
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3497
;3496:
;3497:		if (BotNearbyGoal(bs, bs->tfl, &goal, 300)) {
ADDRLP4 332
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 332
INDIRP4
ARGP4
ADDRLP4 332
INDIRP4
CNSTI4 5984
ADDP4
INDIRI4
ARGI4
ADDRLP4 276
ARGP4
CNSTF4 1133903872
ARGF4
ADDRLP4 336
ADDRGP4 BotNearbyGoal
CALLI4
ASGNI4
ADDRLP4 336
INDIRI4
CNSTI4 0
EQI4 $1629
line 3498
;3498:			bs->nbg_time = FloatTime() + 3;
ADDRFP4 0
INDIRP4
CNSTI4 6092
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1077936128
ADDF4
ASGNF4
line 3499
;3499:			trap_BotResetLastAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetLastAvoidReach
CALLV
pop
line 3500
;3500:			AIEnter_Battle_NBG(bs, "battle fight: going for NBG");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1631
ARGP4
ADDRGP4 AIEnter_Battle_NBG
CALLV
pop
line 3501
;3501:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1574
JUMPV
LABELV $1629
line 3503
;3502:		}
;3503:	}
LABELV $1627
line 3506
;3504:#endif
;3505:	//choose the best weapon to fight with
;3506:	BotChooseWeapon(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotChooseWeapon
CALLV
pop
line 3508
;3507:	//do attack movements
;3508:	moveresult = BotAttackMove(bs, bs->tfl);
ADDRLP4 0
ARGP4
ADDRLP4 276
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 276
INDIRP4
ARGP4
ADDRLP4 276
INDIRP4
CNSTI4 5984
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotAttackMove
CALLV
pop
line 3510
;3509:	//if the movement failed
;3510:	if (moveresult.failure) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1632
line 3512
;3511:		//reset the avoid reach, otherwise bot is stuck in current area
;3512:		trap_BotResetAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidReach
CALLV
pop
line 3514
;3513:		//BotAI_Print(PRT_MESSAGE, "movement failure %d\n", moveresult.traveltype);
;3514:		bs->ltg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6088
ADDP4
CNSTF4 0
ASGNF4
line 3515
;3515:	}
LABELV $1632
line 3517
;3516:	//
;3517:	BotAIBlocked(bs, &moveresult, qfalse);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAIBlocked
CALLV
pop
line 3519
;3518:	//aim at the enemy
;3519:	BotAimAtEnemy(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotAimAtEnemy
CALLV
pop
line 3521
;3520:	//attack the enemy if possible
;3521:	BotCheckAttack(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCheckAttack
CALLV
pop
line 3523
;3522:	//if the bot wants to retreat
;3523:	if (!(bs->flags & BFL_FIGHTSUICIDAL)) {
ADDRFP4 0
INDIRP4
CNSTI4 5992
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
NEI4 $1634
line 3524
;3524:		if (BotWantsToRetreat(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 280
ADDRGP4 BotWantsToRetreat
CALLI4
ASGNI4
ADDRLP4 280
INDIRI4
CNSTI4 0
EQI4 $1636
line 3525
;3525:			AIEnter_Battle_Retreat(bs, "battle fight: wants to retreat");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1638
ARGP4
ADDRGP4 AIEnter_Battle_Retreat
CALLV
pop
line 3526
;3526:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1574
JUMPV
LABELV $1636
line 3528
;3527:		}
;3528:	}
LABELV $1634
line 3529
;3529:	return qtrue;
CNSTI4 1
RETI4
LABELV $1574
endproc AINode_Battle_Fight 340 16
export AIEnter_Battle_Chase
proc AIEnter_Battle_Chase 8 16
line 3537
;3530:}
;3531:
;3532:/*
;3533:==================
;3534:AIEnter_Battle_Chase
;3535:==================
;3536:*/
;3537:void AIEnter_Battle_Chase(bot_state_t *bs, char *s) {
line 3538
;3538:	BotRecordNodeSwitch(bs, "battle chase", "", s);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1640
ARGP4
ADDRGP4 $99
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotRecordNodeSwitch
CALLV
pop
line 3539
;3539:	bs->chase_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7160
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 3540
;3540:	bs->chasearea = bs->areanum;	// JUHOX
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 7164
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
ASGNI4
line 3541
;3541:	VectorCopy(bs->origin, bs->chaseorigin);	// JUHOX
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 7168
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 4916
ADDP4
INDIRB
ASGNB 12
line 3542
;3542:	bs->ainode = AINode_Battle_Chase;
ADDRFP4 0
INDIRP4
CNSTI4 4904
ADDP4
ADDRGP4 AINode_Battle_Chase
ASGNP4
line 3543
;3543:}
LABELV $1639
endproc AIEnter_Battle_Chase 8 16
export AINode_Battle_Chase
proc AINode_Battle_Chase 660 24
line 3551
;3544:
;3545:/*
;3546:==================
;3547:AINode_Battle_Chase
;3548:==================
;3549:*/
;3550:int AINode_Battle_Chase(bot_state_t *bs)
;3551:{
line 3557
;3552:	bot_goal_t goal;
;3553:	vec3_t target, dir;
;3554:	bot_moveresult_t moveresult;
;3555:	float range;
;3556:
;3557:	if (BotIsObserver(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 136
ADDRGP4 BotIsObserver
CALLI4
ASGNI4
ADDRLP4 136
INDIRI4
CNSTI4 0
EQI4 $1642
line 3558
;3558:		AIEnter_Observer(bs, "battle chase: observer");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1644
ARGP4
ADDRGP4 AIEnter_Observer
CALLV
pop
line 3559
;3559:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1641
JUMPV
LABELV $1642
line 3562
;3560:	}
;3561:	//if in the intermission
;3562:	if (BotIntermission(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotIntermission
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $1645
line 3563
;3563:		AIEnter_Intermission(bs, "battle chase: intermission");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1647
ARGP4
ADDRGP4 AIEnter_Intermission
CALLV
pop
line 3564
;3564:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1641
JUMPV
LABELV $1645
line 3567
;3565:	}
;3566:	//respawn if dead
;3567:	if (BotIsDead(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 144
ADDRGP4 BotIsDead
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $1648
line 3568
;3568:		AIEnter_Respawn(bs, "battle chase: bot dead");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1650
ARGP4
ADDRGP4 AIEnter_Respawn
CALLV
pop
line 3569
;3569:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1641
JUMPV
LABELV $1648
line 3572
;3570:	}
;3571:	//if no enemy
;3572:	if (bs->enemy < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 0
GEI4 $1651
line 3573
;3573:		AIEnter_Seek_LTG(bs, "battle chase: no enemy");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1653
ARGP4
ADDRGP4 AIEnter_Seek_LTG
CALLV
pop
line 3574
;3574:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1641
JUMPV
LABELV $1651
line 3577
;3575:	}
;3576:#if 1	// JUHOX: don't chase a dead enemy
;3577:	if (g_entities[bs->enemy].health <= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+736
ADDP4
INDIRI4
CNSTI4 0
GTI4 $1654
line 3578
;3578:		AIEnter_Seek_LTG(bs, "battle chase: enemy dead");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1657
ARGP4
ADDRGP4 AIEnter_Seek_LTG
CALLV
pop
line 3579
;3579:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1641
JUMPV
LABELV $1654
line 3583
;3580:	}
;3581:#endif
;3582:	//if the enemy is visible
;3583:	if (BotEntityVisible(&bs->cur_ps/*bs->entitynum, bs->eye, bs->viewangles*/, 90, bs->enemy)) {	// JUHOX: fov was 360
ADDRLP4 148
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 148
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTF4 1119092736
ARGF4
ADDRLP4 148
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
ARGI4
ADDRLP4 152
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 152
INDIRF4
CNSTF4 0
EQF4 $1658
line 3584
;3584:		AIEnter_Battle_Fight(bs, "battle chase");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1640
ARGP4
ADDRGP4 AIEnter_Battle_Fight
CALLV
pop
line 3585
;3585:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1641
JUMPV
LABELV $1658
line 3588
;3586:	}
;3587:	//if there is another enemy
;3588:	if (BotFindEnemy(bs, -1)) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 156
ADDRGP4 BotFindEnemy
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
EQI4 $1660
line 3589
;3589:		AIEnter_Battle_Fight(bs, "battle chase: better enemy");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1662
ARGP4
ADDRGP4 AIEnter_Battle_Fight
CALLV
pop
line 3590
;3590:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1641
JUMPV
LABELV $1660
line 3593
;3591:	}
;3592:	//there is no last enemy area
;3593:	if (!bs->lastenemyareanum) {
ADDRFP4 0
INDIRP4
CNSTI4 7768
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1663
line 3594
;3594:		AIEnter_Seek_LTG(bs, "battle chase: no enemy area");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1665
ARGP4
ADDRGP4 AIEnter_Seek_LTG
CALLV
pop
line 3595
;3595:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1641
JUMPV
LABELV $1663
line 3598
;3596:	}
;3597:	//
;3598:	bs->tfl = TFL_DEFAULT;
ADDRFP4 0
INDIRP4
CNSTI4 5984
ADDP4
CNSTI4 18616254
ASGNI4
line 3599
;3599:	if (bot_grapple.integer) bs->tfl |= TFL_GRAPPLEHOOK;
ADDRGP4 bot_grapple+12
INDIRI4
CNSTI4 0
EQI4 $1666
ADDRLP4 160
ADDRFP4 0
INDIRP4
CNSTI4 5984
ADDP4
ASGNP4
ADDRLP4 160
INDIRP4
ADDRLP4 160
INDIRP4
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
LABELV $1666
line 3601
;3600:	//if in lava or slime the bot should be able to get out
;3601:	if (BotInLavaOrSlime(bs)) bs->tfl |= TFL_LAVA|TFL_SLIME;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 164
ADDRGP4 BotInLavaOrSlime
CALLI4
ASGNI4
ADDRLP4 164
INDIRI4
CNSTI4 0
EQI4 $1669
ADDRLP4 168
ADDRFP4 0
INDIRP4
CNSTI4 5984
ADDP4
ASGNP4
ADDRLP4 168
INDIRP4
ADDRLP4 168
INDIRP4
INDIRI4
CNSTI4 6291456
BORI4
ASGNI4
LABELV $1669
line 3603
;3602:	//
;3603:	if (BotCanAndWantsToRocketJump(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 172
ADDRGP4 BotCanAndWantsToRocketJump
CALLI4
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 0
EQI4 $1671
line 3604
;3604:		bs->tfl |= TFL_ROCKETJUMP;
ADDRLP4 176
ADDRFP4 0
INDIRP4
CNSTI4 5984
ADDP4
ASGNP4
ADDRLP4 176
INDIRP4
ADDRLP4 176
INDIRP4
INDIRI4
CNSTI4 4096
BORI4
ASGNI4
line 3605
;3605:	}
LABELV $1671
line 3607
;3606:	//map specific code
;3607:	BotMapScripts(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotMapScripts
CALLV
pop
line 3609
;3608:	//create the chase goal
;3609:	goal.entitynum = bs->enemy;
ADDRLP4 0+40
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
ASGNI4
line 3610
;3610:	goal.areanum = bs->lastenemyareanum;
ADDRLP4 0+12
ADDRFP4 0
INDIRP4
CNSTI4 7768
ADDP4
INDIRI4
ASGNI4
line 3611
;3611:	VectorCopy(bs->lastenemyorigin, goal.origin);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 7772
ADDP4
INDIRB
ASGNB 12
line 3612
;3612:	VectorSet(goal.mins, -8, -8, -8);
ADDRLP4 0+16
CNSTF4 3238002688
ASGNF4
ADDRLP4 0+16+4
CNSTF4 3238002688
ASGNF4
ADDRLP4 0+16+8
CNSTF4 3238002688
ASGNF4
line 3613
;3613:	VectorSet(goal.maxs, 8, 8, 8);
ADDRLP4 0+28
CNSTF4 1090519040
ASGNF4
ADDRLP4 0+28+4
CNSTF4 1090519040
ASGNF4
ADDRLP4 0+28+8
CNSTF4 1090519040
ASGNF4
line 3619
;3614:	//if the last seen enemy spot is reached the enemy could not be found
;3615:	// JUHOX: if the enemy is not found try to predict his goal
;3616:#if 0
;3617:	if (trap_BotTouchingGoal(bs->origin, &goal)) bs->chase_time = 0;
;3618:#else
;3619:	if (trap_BotTouchingGoal(bs->origin, &goal)) {
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 176
ADDRGP4 trap_BotTouchingGoal
CALLI4
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 0
EQI4 $1685
line 3620
;3620:		if (bs->chasearea) {
ADDRFP4 0
INDIRP4
CNSTI4 7164
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1687
line 3623
;3621:			playerState_t ps;
;3622:
;3623:			if (!BotAI_GetClientState(bs->enemy, &ps)) goto NoChase;
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
ARGI4
ADDRLP4 180
ARGP4
ADDRLP4 648
ADDRGP4 BotAI_GetClientState
CALLI4
ASGNI4
ADDRLP4 648
INDIRI4
CNSTI4 0
NEI4 $1689
ADDRGP4 $1691
JUMPV
LABELV $1689
line 3624
;3624:			if (!FindEscapeGoal(&ps, bs->lastenemyareanum, 0, bs->chasearea, bs->chaseorigin, &goal)) goto NoChase;
ADDRLP4 180
ARGP4
ADDRLP4 652
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 652
INDIRP4
CNSTI4 7768
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 652
INDIRP4
CNSTI4 7164
ADDP4
INDIRI4
ARGI4
ADDRLP4 652
INDIRP4
CNSTI4 7168
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 656
ADDRGP4 FindEscapeGoal
CALLI4
ASGNI4
ADDRLP4 656
INDIRI4
CNSTI4 0
NEI4 $1692
ADDRGP4 $1691
JUMPV
LABELV $1692
line 3626
;3625:
;3626:			bs->lastenemyareanum = goal.areanum;
ADDRFP4 0
INDIRP4
CNSTI4 7768
ADDP4
ADDRLP4 0+12
INDIRI4
ASGNI4
line 3627
;3627:			VectorCopy(goal.origin, bs->lastenemyorigin);
ADDRFP4 0
INDIRP4
CNSTI4 7772
ADDP4
ADDRLP4 0
INDIRB
ASGNB 12
line 3628
;3628:			bs->lastEnemyAreaPredicted = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 7784
ADDP4
CNSTI4 1
ASGNI4
line 3629
;3629:			bs->chasearea = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7164
ADDP4
CNSTI4 0
ASGNI4
line 3630
;3630:		}
ADDRGP4 $1688
JUMPV
LABELV $1687
line 3631
;3631:		else {
LABELV $1691
line 3633
;3632:			NoChase:
;3633:			bs->chase_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7160
ADDP4
CNSTF4 0
ASGNF4
line 3634
;3634:		}
LABELV $1688
line 3635
;3635:	}
LABELV $1685
line 3637
;3636:#endif
;3637:	if (!BotWantsToChase(bs)) bs->chase_time = 0;	// JUHOX
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 180
ADDRGP4 BotWantsToChase
CALLI4
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 0
NEI4 $1695
ADDRFP4 0
INDIRP4
CNSTI4 7160
ADDP4
CNSTF4 0
ASGNF4
LABELV $1695
line 3639
;3638:	//if there's no chase time left
;3639:	if (!bs->chase_time || bs->chase_time < FloatTime() - /*10*/30) {	// JUHOX
ADDRLP4 184
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 184
INDIRP4
CNSTI4 7160
ADDP4
INDIRF4
CNSTF4 0
EQF4 $1699
ADDRLP4 184
INDIRP4
CNSTI4 7160
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1106247680
SUBF4
GEF4 $1697
LABELV $1699
line 3640
;3640:		AIEnter_Seek_LTG(bs, "battle chase: time out");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1700
ARGP4
ADDRGP4 AIEnter_Seek_LTG
CALLV
pop
line 3641
;3641:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1641
JUMPV
LABELV $1697
line 3644
;3642:	}
;3643:	//check for nearby goals periodicly
;3644:	if (bs->check_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 7184
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $1701
line 3645
;3645:		bs->check_time = FloatTime() + 1;
ADDRFP4 0
INDIRP4
CNSTI4 7184
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3646
;3646:		range = 150;
ADDRLP4 108
CNSTF4 1125515264
ASGNF4
line 3648
;3647:		//
;3648:		if (BotNearbyGoal(bs, bs->tfl, &goal, range)) {
ADDRLP4 188
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 188
INDIRP4
ARGP4
ADDRLP4 188
INDIRP4
CNSTI4 5984
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 108
INDIRF4
ARGF4
ADDRLP4 192
ADDRGP4 BotNearbyGoal
CALLI4
ASGNI4
ADDRLP4 192
INDIRI4
CNSTI4 0
EQI4 $1703
line 3650
;3649:			//the bot gets 5 seconds to pick up the nearby goal item
;3650:			bs->nbg_time = FloatTime() + 0.1 * range + 1;
ADDRFP4 0
INDIRP4
CNSTI4 6092
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 108
INDIRF4
CNSTF4 1036831949
MULF4
ADDF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3651
;3651:			trap_BotResetLastAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetLastAvoidReach
CALLV
pop
line 3652
;3652:			AIEnter_Battle_NBG(bs, "battle chase: nbg");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1705
ARGP4
ADDRGP4 AIEnter_Battle_NBG
CALLV
pop
line 3653
;3653:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1641
JUMPV
LABELV $1703
line 3655
;3654:		}
;3655:	}
LABELV $1701
line 3657
;3656:	//
;3657:	BotUpdateBattleInventory(bs, bs->enemy);
ADDRLP4 188
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 188
INDIRP4
ARGP4
ADDRLP4 188
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotUpdateBattleInventory
CALLV
pop
line 3659
;3658:	//initialize the movement state
;3659:	BotSetupForMovement(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetupForMovement
CALLV
pop
line 3661
;3660:	//move towards the goal
;3661:	trap_BotMoveToGoal(&moveresult, bs->ms, &goal, bs->tfl);
ADDRLP4 56
ARGP4
ADDRLP4 192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 192
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 192
INDIRP4
CNSTI4 5984
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotMoveToGoal
CALLV
pop
line 3663
;3662:	//if the movement failed
;3663:	if (moveresult.failure) {
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $1706
line 3665
;3664:		//reset the avoid reach, otherwise bot is stuck in current area
;3665:		trap_BotResetAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidReach
CALLV
pop
line 3667
;3666:		//BotAI_Print(PRT_MESSAGE, "movement failure %d\n", moveresult.traveltype);
;3667:		bs->ltg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6088
ADDP4
CNSTF4 0
ASGNF4
line 3668
;3668:		bs->ltgtype = 0;	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
line 3669
;3669:	}
LABELV $1706
line 3671
;3670:	//
;3671:	BotAIBlocked(bs, &moveresult, qfalse);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAIBlocked
CALLV
pop
line 3673
;3672:	//
;3673:	if (moveresult.flags & (MOVERESULT_MOVEMENTVIEWSET|MOVERESULT_MOVEMENTVIEW|MOVERESULT_SWIMVIEW)) {
ADDRLP4 56+20
INDIRI4
CNSTI4 11
BANDI4
CNSTI4 0
EQI4 $1708
line 3674
;3674:		VectorCopy(moveresult.ideal_viewangles, bs->ideal_viewangles);
ADDRFP4 0
INDIRP4
CNSTI4 7852
ADDP4
ADDRLP4 56+40
INDIRB
ASGNB 12
line 3675
;3675:		bs->specialMove = qtrue;	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 7744
ADDP4
CNSTI4 1
ASGNI4
line 3676
;3676:	}
ADDRGP4 $1709
JUMPV
LABELV $1708
line 3677
;3677:	else if (!(bs->flags & BFL_IDEALVIEWSET)) {
ADDRFP4 0
INDIRP4
CNSTI4 5992
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
NEI4 $1712
line 3678
;3678:		if (bs->chase_time > FloatTime() - 2) {
ADDRFP4 0
INDIRP4
CNSTI4 7160
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
SUBF4
LEF4 $1714
line 3679
;3679:			bs->lastEnemyAreaPredicted = !bs->chasearea;	// JUHOX
ADDRLP4 200
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 200
INDIRP4
CNSTI4 7164
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1717
ADDRLP4 196
CNSTI4 1
ASGNI4
ADDRGP4 $1718
JUMPV
LABELV $1717
ADDRLP4 196
CNSTI4 0
ASGNI4
LABELV $1718
ADDRLP4 200
INDIRP4
CNSTI4 7784
ADDP4
ADDRLP4 196
INDIRI4
ASGNI4
line 3680
;3680:			BotAimAtEnemy(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotAimAtEnemy
CALLV
pop
line 3684
;3681:			// JUHOX: if the enemy sight is lost just a few seconds before don't stop the machine gun
;3682:#if 1
;3683:			if (
;3684:				bs->weaponnum == WP_MACHINEGUN &&
ADDRLP4 204
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 204
INDIRP4
CNSTI4 7804
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1715
ADDRLP4 204
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 3
LTI4 $1715
line 3686
;3685:				bs->cur_ps.weaponstate >= WEAPON_FIRING
;3686:			) {
line 3687
;3687:				BotCheckAttack(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCheckAttack
CALLV
pop
line 3688
;3688:			}
line 3690
;3689:#endif
;3690:		}
ADDRGP4 $1715
JUMPV
LABELV $1714
line 3691
;3691:		else {
line 3694
;3692:			// JUHOX: react upon audible stimuli
;3693:#if 1
;3694:			if (BotRoamGoal(bs, target, qtrue)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 112
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 196
ADDRGP4 BotRoamGoal
CALLI4
ASGNI4
ADDRLP4 196
INDIRI4
CNSTI4 0
EQI4 $1721
line 3695
;3695:				VectorSubtract(target, bs->origin, dir);
ADDRLP4 200
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 124
ADDRLP4 112
INDIRF4
ADDRLP4 200
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 124+4
ADDRLP4 112+4
INDIRF4
ADDRLP4 200
INDIRP4
CNSTI4 4920
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 124+8
ADDRLP4 112+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3696
;3696:				vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 124
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 7852
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 3697
;3697:			} else
ADDRGP4 $1722
JUMPV
LABELV $1721
line 3699
;3698:#endif
;3699:			if (trap_BotMovementViewTarget(bs->ms, &goal, bs->tfl, 300, target)) {
ADDRLP4 200
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 200
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 200
INDIRP4
CNSTI4 5984
ADDP4
INDIRI4
ARGI4
CNSTF4 1133903872
ARGF4
ADDRLP4 112
ARGP4
ADDRLP4 204
ADDRGP4 trap_BotMovementViewTarget
CALLI4
ASGNI4
ADDRLP4 204
INDIRI4
CNSTI4 0
EQI4 $1727
line 3700
;3700:				VectorSubtract(target, bs->origin, dir);
ADDRLP4 208
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 124
ADDRLP4 112
INDIRF4
ADDRLP4 208
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 124+4
ADDRLP4 112+4
INDIRF4
ADDRLP4 208
INDIRP4
CNSTI4 4920
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 124+8
ADDRLP4 112+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3701
;3701:				vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 124
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 7852
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 3702
;3702:			}
ADDRGP4 $1728
JUMPV
LABELV $1727
line 3703
;3703:			else {
line 3704
;3704:				vectoangles(moveresult.movedir, bs->ideal_viewangles);
ADDRLP4 56+28
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 7852
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 3705
;3705:			}
LABELV $1728
LABELV $1722
line 3706
;3706:		}
LABELV $1715
line 3707
;3707:		bs->ideal_viewangles[2] *= 0.5;
ADDRLP4 196
ADDRFP4 0
INDIRP4
CNSTI4 7860
ADDP4
ASGNP4
ADDRLP4 196
INDIRP4
ADDRLP4 196
INDIRP4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 3708
;3708:	}
LABELV $1712
LABELV $1709
line 3709
;3709:	BotCheckForWeaponJump(bs, &moveresult);	// JUHOX
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
ARGP4
ADDRGP4 BotCheckForWeaponJump
CALLV
pop
line 3711
;3710:	//if the weapon is used for the bot movement
;3711:	if (moveresult.flags & MOVERESULT_MOVEMENTWEAPON) bs->weaponnum = moveresult.weapon;
ADDRLP4 56+20
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1734
ADDRFP4 0
INDIRP4
CNSTI4 7804
ADDP4
ADDRLP4 56+24
INDIRI4
ASGNI4
LABELV $1734
line 3713
;3712:	//if the bot is in the area the enemy was last seen in
;3713:	if (bs->areanum == bs->lastenemyareanum) bs->chase_time = 0;
ADDRLP4 196
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 196
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
ADDRLP4 196
INDIRP4
CNSTI4 7768
ADDP4
INDIRI4
NEI4 $1738
ADDRFP4 0
INDIRP4
CNSTI4 7160
ADDP4
CNSTF4 0
ASGNF4
LABELV $1738
line 3722
;3714:	//if the bot wants to retreat (the bot could have been damage during the chase)
;3715:	// JUHOX: retreating already handled by 'BotWantsToChase()' above
;3716:#if 0
;3717:	if (BotWantsToRetreat(bs)) {
;3718:		AIEnter_Battle_Retreat(bs, "battle chase: wants to retreat");
;3719:		return qtrue;
;3720:	}
;3721:#endif
;3722:	return qtrue;
CNSTI4 1
RETI4
LABELV $1641
endproc AINode_Battle_Chase 660 24
export AIEnter_Battle_Retreat
proc AIEnter_Battle_Retreat 0 16
line 3730
;3723:}
;3724:
;3725:/*
;3726:==================
;3727:AIEnter_Battle_Retreat
;3728:==================
;3729:*/
;3730:void AIEnter_Battle_Retreat(bot_state_t *bs, char *s) {
line 3731
;3731:	BotRecordNodeSwitch(bs, "battle retreat", "", s);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1741
ARGP4
ADDRGP4 $99
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotRecordNodeSwitch
CALLV
pop
line 3732
;3732:	bs->ainode = AINode_Battle_Retreat;
ADDRFP4 0
INDIRP4
CNSTI4 4904
ADDP4
ADDRGP4 AINode_Battle_Retreat
ASGNP4
line 3733
;3733:}
LABELV $1740
endproc AIEnter_Battle_Retreat 0 16
export AINode_Battle_Retreat
proc AINode_Battle_Retreat 388 20
line 3740
;3734:
;3735:/*
;3736:==================
;3737:AINode_Battle_Retreat
;3738:==================
;3739:*/
;3740:int AINode_Battle_Retreat(bot_state_t *bs) {
line 3749
;3741:	bot_goal_t goal;
;3742:	aas_entityinfo_t entinfo;
;3743:	bot_moveresult_t moveresult;
;3744:	vec3_t target, dir;
;3745:	float attack_skill, range;
;3746:	int areanum;
;3747:	qboolean goalAvailable;	// JUHOX
;3748:
;3749:	if (BotIsObserver(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 288
ADDRGP4 BotIsObserver
CALLI4
ASGNI4
ADDRLP4 288
INDIRI4
CNSTI4 0
EQI4 $1743
line 3750
;3750:		AIEnter_Observer(bs, "battle retreat: observer");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1745
ARGP4
ADDRGP4 AIEnter_Observer
CALLV
pop
line 3751
;3751:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1742
JUMPV
LABELV $1743
line 3754
;3752:	}
;3753:	//if in the intermission
;3754:	if (BotIntermission(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 292
ADDRGP4 BotIntermission
CALLI4
ASGNI4
ADDRLP4 292
INDIRI4
CNSTI4 0
EQI4 $1746
line 3755
;3755:		AIEnter_Intermission(bs, "battle retreat: intermission");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1748
ARGP4
ADDRGP4 AIEnter_Intermission
CALLV
pop
line 3756
;3756:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1742
JUMPV
LABELV $1746
line 3759
;3757:	}
;3758:	//respawn if dead
;3759:	if (BotIsDead(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
ADDRGP4 BotIsDead
CALLI4
ASGNI4
ADDRLP4 296
INDIRI4
CNSTI4 0
EQI4 $1749
line 3760
;3760:		AIEnter_Respawn(bs, "battle retreat: bot dead");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1751
ARGP4
ADDRGP4 AIEnter_Respawn
CALLV
pop
line 3761
;3761:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1742
JUMPV
LABELV $1749
line 3764
;3762:	}
;3763:	//if no enemy
;3764:	if (bs->enemy < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 0
GEI4 $1752
line 3765
;3765:		AIEnter_Seek_LTG(bs, "battle retreat: no enemy");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1754
ARGP4
ADDRGP4 AIEnter_Seek_LTG
CALLV
pop
line 3766
;3766:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1742
JUMPV
LABELV $1752
line 3769
;3767:	}
;3768:	//
;3769:	BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
ARGI4
ADDRLP4 108
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3770
;3770:	if (EntityIsDead(&entinfo)) {
ADDRLP4 108
ARGP4
ADDRLP4 300
ADDRGP4 EntityIsDead
CALLI4
ASGNI4
ADDRLP4 300
INDIRI4
CNSTI4 0
EQI4 $1755
line 3771
;3771:		AIEnter_Seek_LTG(bs, "battle retreat: enemy dead");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1757
ARGP4
ADDRGP4 AIEnter_Seek_LTG
CALLV
pop
line 3772
;3772:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1742
JUMPV
LABELV $1755
line 3775
;3773:	}
;3774:	//if there is another better enemy
;3775:	if (BotFindEnemy(bs, bs->enemy)) {
ADDRLP4 304
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 304
INDIRP4
ARGP4
ADDRLP4 304
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
ARGI4
ADDRLP4 308
ADDRGP4 BotFindEnemy
CALLI4
ASGNI4
ADDRLP4 308
INDIRI4
CNSTI4 0
EQI4 $1758
line 3779
;3776:#ifdef DEBUG
;3777:		BotAI_Print(PRT_MESSAGE, "found new better enemy\n");
;3778:#endif
;3779:	}
LABELV $1758
line 3781
;3780:	//
;3781:	bs->tfl = TFL_DEFAULT;
ADDRFP4 0
INDIRP4
CNSTI4 5984
ADDP4
CNSTI4 18616254
ASGNI4
line 3782
;3782:	if (bot_grapple.integer) bs->tfl |= TFL_GRAPPLEHOOK;
ADDRGP4 bot_grapple+12
INDIRI4
CNSTI4 0
EQI4 $1760
ADDRLP4 312
ADDRFP4 0
INDIRP4
CNSTI4 5984
ADDP4
ASGNP4
ADDRLP4 312
INDIRP4
ADDRLP4 312
INDIRP4
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
LABELV $1760
line 3784
;3783:	//if in lava or slime the bot should be able to get out
;3784:	if (BotInLavaOrSlime(bs)) bs->tfl |= TFL_LAVA|TFL_SLIME;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 316
ADDRGP4 BotInLavaOrSlime
CALLI4
ASGNI4
ADDRLP4 316
INDIRI4
CNSTI4 0
EQI4 $1763
ADDRLP4 320
ADDRFP4 0
INDIRP4
CNSTI4 5984
ADDP4
ASGNP4
ADDRLP4 320
INDIRP4
ADDRLP4 320
INDIRP4
INDIRI4
CNSTI4 6291456
BORI4
ASGNI4
LABELV $1763
line 3786
;3785:	//map specific code
;3786:	BotMapScripts(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotMapScripts
CALLV
pop
line 3788
;3787:	//update the attack inventory values
;3788:	BotUpdateBattleInventory(bs, bs->enemy);
ADDRLP4 324
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 324
INDIRP4
ARGP4
ADDRLP4 324
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotUpdateBattleInventory
CALLV
pop
line 3790
;3789:	//if the bot doesn't want to retreat anymore... probably picked up some nice items
;3790:	if (BotWantsToChase(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 328
ADDRGP4 BotWantsToChase
CALLI4
ASGNI4
ADDRLP4 328
INDIRI4
CNSTI4 0
EQI4 $1765
line 3792
;3791:		//empty the goal stack, when chasing, only the enemy is the goal
;3792:		trap_BotEmptyGoalStack(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotEmptyGoalStack
CALLV
pop
line 3794
;3793:		//go chase the enemy
;3794:		AIEnter_Battle_Chase(bs, "battle retreat: wants to chase");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1767
ARGP4
ADDRGP4 AIEnter_Battle_Chase
CALLV
pop
line 3795
;3795:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1742
JUMPV
LABELV $1765
line 3798
;3796:	}
;3797:	//update the last time the enemy was visible
;3798:	if (BotEntityVisible(&bs->cur_ps/*bs->entitynum, bs->eye, bs->viewangles*/, 360, bs->enemy)) {	// JUHOX
ADDRLP4 332
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 332
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 332
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
ARGI4
ADDRLP4 336
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 336
INDIRF4
CNSTF4 0
EQF4 $1768
line 3799
;3799:		bs->enemyvisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7180
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 3800
;3800:		VectorCopy(entinfo.origin, target);
ADDRLP4 256
ADDRLP4 108+24
INDIRB
ASGNB 12
line 3802
;3801:		// if not a player enemy
;3802:		if (bs->enemy >= MAX_CLIENTS) {
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 64
LTI4 $1771
line 3810
;3803:#ifdef MISSIONPACK
;3804:			// if attacking an obelisk
;3805:			if ( bs->enemy == redobelisk.entitynum ||
;3806:				bs->enemy == blueobelisk.entitynum ) {
;3807:				target[2] += 16;
;3808:			}
;3809:#endif
;3810:		}
LABELV $1771
line 3812
;3811:		//update the reachability area and origin if possible
;3812:		areanum = BotPointAreaNum(target);
ADDRLP4 256
ARGP4
ADDRLP4 340
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 252
ADDRLP4 340
INDIRI4
ASGNI4
line 3813
;3813:		if (areanum && trap_AAS_AreaReachability(areanum)) {
ADDRLP4 344
ADDRLP4 252
INDIRI4
ASGNI4
ADDRLP4 344
INDIRI4
CNSTI4 0
EQI4 $1773
ADDRLP4 344
INDIRI4
ARGI4
ADDRLP4 348
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 348
INDIRI4
CNSTI4 0
EQI4 $1773
line 3814
;3814:			VectorCopy(target, bs->lastenemyorigin);
ADDRFP4 0
INDIRP4
CNSTI4 7772
ADDP4
ADDRLP4 256
INDIRB
ASGNB 12
line 3815
;3815:			bs->lastenemyareanum = areanum;
ADDRFP4 0
INDIRP4
CNSTI4 7768
ADDP4
ADDRLP4 252
INDIRI4
ASGNI4
line 3816
;3816:			bs->lastEnemyAreaPredicted = qfalse;	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 7784
ADDP4
CNSTI4 0
ASGNI4
line 3817
;3817:		}
LABELV $1773
line 3818
;3818:	}
LABELV $1768
line 3821
;3819:	// JUHOX: if the enemy is no longer visible and there's something important to do
;3820:#if 1
;3821:	if (bs->enemyvisible_time < FloatTime() - 1 && bs->ltgtype != 0 && bs->ltgtype != LTG_WAIT) {
ADDRLP4 340
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 340
INDIRP4
CNSTI4 7180
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
SUBF4
GEF4 $1775
ADDRLP4 340
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1775
ADDRLP4 340
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 17
EQI4 $1775
line 3822
;3822:		AIEnter_Seek_LTG(bs, "battle retreat: ignore enemy");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1777
ARGP4
ADDRGP4 AIEnter_Seek_LTG
CALLV
pop
line 3823
;3823:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1742
JUMPV
LABELV $1775
line 3827
;3824:	}
;3825:#endif
;3826:	//if the enemy is NOT visible for 4 seconds
;3827:	if (bs->enemyvisible_time < FloatTime() - 4) {
ADDRFP4 0
INDIRP4
CNSTI4 7180
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1082130432
SUBF4
GEF4 $1778
line 3828
;3828:		AIEnter_Seek_LTG(bs, "battle retreat: lost enemy");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1780
ARGP4
ADDRGP4 AIEnter_Seek_LTG
CALLV
pop
line 3829
;3829:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1742
JUMPV
LABELV $1778
line 3849
;3830:	}
;3831:	// JUHOX: already searched for another enemy
;3832:#if 0
;3833:	//else if the enemy is NOT visible
;3834:	else if (bs->enemyvisible_time < FloatTime()) {
;3835:		//if there is another enemy
;3836:		if (BotFindEnemy(bs, -1)) {
;3837:			bs->ltgtype = 0;	// JUHOX: remove LTG_ESCAPE
;3838:			AIEnter_Battle_Fight(bs, "battle retreat: another enemy");
;3839:			return qfalse;
;3840:		}
;3841:	}
;3842:#endif
;3843:	//
;3844:	// JUHOX: team goals not decided here
;3845:#if 0
;3846:	BotTeamGoals(bs, qtrue);
;3847:#endif
;3848:	//use holdable items
;3849:	BotBattleUseItems(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotBattleUseItems
CALLV
pop
line 3850
;3850:	BotSetEscapeGoal(bs);	// JUHOX
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetEscapeGoal
CALLV
pop
line 3859
;3851:	//get the current long term goal while retreating
;3852:	// JUHOX: if no LTG available, just do an attack move, but no suicidal fighting
;3853:#if 0
;3854:	if (!BotLongTermGoal(bs, bs->tfl, qtrue, &goal)) {
;3855:		AIEnter_Battle_SuicidalFight(bs, "battle retreat: no way out");
;3856:		return qfalse;
;3857:	}
;3858:#else
;3859:	goalAvailable = BotLongTermGoal(bs, bs->tfl, qtrue, &goal);
ADDRLP4 344
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 344
INDIRP4
ARGP4
ADDRLP4 344
INDIRP4
CNSTI4 5984
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 52
ARGP4
ADDRLP4 348
ADDRGP4 BotLongTermGoal
CALLI4
ASGNI4
ADDRLP4 248
ADDRLP4 348
INDIRI4
ASGNI4
line 3862
;3860:#endif
;3861:	//check for nearby goals periodicly
;3862:	if (bs->check_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 7184
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $1781
line 3863
;3863:		bs->check_time = FloatTime() + /*1*/0.5;	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 7184
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 3864
;3864:		range = /*150*/300;	// JUHOX
ADDRLP4 268
CNSTF4 1133903872
ASGNF4
line 3866
;3865:#ifdef CTF
;3866:		if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $1783
line 3873
;3867:			//if carrying a flag the bot shouldn't be distracted too much
;3868:			// JUHOX: if the own flag isn't at base use a greater range
;3869:#if 0
;3870:			if (BotCTFCarryingFlag(bs))
;3871:				range = 50;
;3872:#else
;3873:			if (BotCTFCarryingFlag(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 352
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 352
INDIRI4
CNSTI4 0
EQI4 $1785
line 3875
;3874:				if (
;3875:					BotOwnFlagStatus(bs) == FLAG_ATBASE ||
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 356
ADDRGP4 BotOwnFlagStatus
CALLI4
ASGNI4
ADDRLP4 356
INDIRI4
CNSTI4 0
EQI4 $1789
ADDRLP4 360
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 360
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ARGI4
ADDRLP4 360
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
CNSTF4 1082130432
ARGF4
ADDRLP4 364
ADDRGP4 NearHomeBase
CALLI4
ASGNI4
ADDRLP4 364
INDIRI4
CNSTI4 0
NEI4 $1787
LABELV $1789
line 3877
;3876:					!NearHomeBase(bs->cur_ps.persistant[PERS_TEAM], bs->origin, 4)
;3877:				) {
line 3878
;3878:					range = 50;
ADDRLP4 268
CNSTF4 1112014848
ASGNF4
line 3879
;3879:				}
ADDRGP4 $1788
JUMPV
LABELV $1787
line 3880
;3880:				else {
line 3881
;3881:					range = 200;
ADDRLP4 268
CNSTF4 1128792064
ASGNF4
line 3882
;3882:				}
LABELV $1788
line 3883
;3883:			}
LABELV $1785
line 3885
;3884:#endif
;3885:		}
LABELV $1783
line 3898
;3886:#endif //CTF
;3887:#ifdef MISSIONPACK
;3888:		else if (gametype == GT_1FCTF) {
;3889:			if (Bot1FCTFCarryingFlag(bs))
;3890:				range = 50;
;3891:		}
;3892:		else if (gametype == GT_HARVESTER) {
;3893:			if (BotHarvesterCarryingCubes(bs))
;3894:				range = 80;
;3895:		}
;3896:#endif
;3897:		//
;3898:		if (BotNearbyGoal(bs, bs->tfl, &goal, range)) {
ADDRLP4 352
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 352
INDIRP4
ARGP4
ADDRLP4 352
INDIRP4
CNSTI4 5984
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
ARGP4
ADDRLP4 268
INDIRF4
ARGF4
ADDRLP4 356
ADDRGP4 BotNearbyGoal
CALLI4
ASGNI4
ADDRLP4 356
INDIRI4
CNSTI4 0
EQI4 $1790
line 3899
;3899:			trap_BotResetLastAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetLastAvoidReach
CALLV
pop
line 3901
;3900:			//time the bot gets to pick up the nearby goal item
;3901:			bs->nbg_time = FloatTime() + range / 100 + 1;
ADDRFP4 0
INDIRP4
CNSTI4 6092
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 268
INDIRF4
CNSTF4 1008981770
MULF4
ADDF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3902
;3902:			if (bs->getImportantNBGItem || bs->nbgGivesPODMarker) bs->nbg_time += 5.0;	// JUHOX
ADDRLP4 360
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 360
INDIRP4
CNSTI4 7736
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1794
ADDRLP4 360
INDIRP4
CNSTI4 6636
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1792
LABELV $1794
ADDRLP4 364
ADDRFP4 0
INDIRP4
CNSTI4 6092
ADDP4
ASGNP4
ADDRLP4 364
INDIRP4
ADDRLP4 364
INDIRP4
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
LABELV $1792
line 3903
;3903:			AIEnter_Battle_NBG(bs, "battle retreat: nbg");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1795
ARGP4
ADDRGP4 AIEnter_Battle_NBG
CALLV
pop
line 3904
;3904:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1742
JUMPV
LABELV $1790
line 3906
;3905:		}
;3906:	}
LABELV $1781
line 3908
;3907:	//initialize the movement state
;3908:	BotSetupForMovement(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetupForMovement
CALLV
pop
line 3915
;3909:	//move towards the goal
;3910:	// JUHOX: do an attack move if no goal available
;3911:#if 0
;3912:	trap_BotMoveToGoal(&moveresult, bs->ms, &goal, bs->tfl);
;3913:#else
;3914:	if (
;3915:		goalAvailable &&
ADDRLP4 248
INDIRI4
CNSTI4 0
EQI4 $1796
ADDRLP4 352
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52+40
INDIRI4
ADDRLP4 352
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
NEI4 $1799
ADDRLP4 52
ARGP4
ADDRLP4 352
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 356
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 356
INDIRF4
CNSTF4 1212530944
LEF4 $1796
LABELV $1799
ADDRLP4 360
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 360
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 5
NEI4 $1801
ADDRLP4 360
INDIRP4
ARGP4
ADDRLP4 364
ADDRGP4 BotOwnFlagStatus
CALLI4
ASGNI4
ADDRLP4 364
INDIRI4
CNSTI4 0
EQI4 $1801
ADDRLP4 52
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 368
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 368
INDIRF4
CNSTF4 1202702336
LEF4 $1796
LABELV $1801
line 3925
;3916:		(
;3917:			goal.entitynum != bs->enemy ||
;3918:			DistanceSquared(goal.origin, bs->origin) > 450*450
;3919:		) &&
;3920:		(
;3921:			bs->ltgtype != LTG_RUSHBASE ||
;3922:			BotOwnFlagStatus(bs) == FLAG_ATBASE ||
;3923:			DistanceSquared(goal.origin, bs->origin) > 300*300
;3924:		)
;3925:	) {
line 3926
;3926:		trap_BotMoveToGoal(&moveresult, bs->ms, &goal, bs->tfl);
ADDRLP4 0
ARGP4
ADDRLP4 372
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 372
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
ARGP4
ADDRLP4 372
INDIRP4
CNSTI4 5984
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotMoveToGoal
CALLV
pop
line 3927
;3927:	}
ADDRGP4 $1797
JUMPV
LABELV $1796
line 3928
;3928:	else {
line 3929
;3929:		moveresult = BotAttackMove(bs, bs->tfl);
ADDRLP4 0
ARGP4
ADDRLP4 372
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 372
INDIRP4
ARGP4
ADDRLP4 372
INDIRP4
CNSTI4 5984
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotAttackMove
CALLV
pop
line 3930
;3930:	}
LABELV $1797
line 3933
;3931:#endif
;3932:	//if the movement failed
;3933:	if (moveresult.failure) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1802
line 3935
;3934:		//reset the avoid reach, otherwise bot is stuck in current area
;3935:		trap_BotResetAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidReach
CALLV
pop
line 3937
;3936:		//BotAI_Print(PRT_MESSAGE, "movement failure %d\n", moveresult.traveltype);
;3937:		bs->ltg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6088
ADDP4
CNSTF4 0
ASGNF4
line 3938
;3938:		bs->ltgtype = 0;	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
line 3939
;3939:	}
LABELV $1802
line 3941
;3940:	//
;3941:	BotAIBlocked(bs, &moveresult, qfalse);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAIBlocked
CALLV
pop
line 3943
;3942:	//choose the best weapon to fight with
;3943:	BotChooseWeapon(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotChooseWeapon
CALLV
pop
line 3945
;3944:	//if the view is fixed for the movement
;3945:	if (moveresult.flags & (MOVERESULT_MOVEMENTVIEW|MOVERESULT_SWIMVIEW)) {
ADDRLP4 0+20
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $1804
line 3946
;3946:		VectorCopy(moveresult.ideal_viewangles, bs->ideal_viewangles);
ADDRFP4 0
INDIRP4
CNSTI4 7852
ADDP4
ADDRLP4 0+40
INDIRB
ASGNB 12
line 3947
;3947:		bs->specialMove = qtrue;	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 7744
ADDP4
CNSTI4 1
ASGNI4
line 3948
;3948:	}
ADDRGP4 $1805
JUMPV
LABELV $1804
line 3949
;3949:	else if (!(moveresult.flags & MOVERESULT_MOVEMENTVIEWSET)
ADDRLP4 0+20
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $1808
ADDRFP4 0
INDIRP4
CNSTI4 5992
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
NEI4 $1808
line 3950
;3950:				&& !(bs->flags & BFL_IDEALVIEWSET) ) {
line 3951
;3951:		attack_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_ATTACK_SKILL, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 372
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 272
ADDRLP4 372
INDIRF4
ASGNF4
line 3953
;3952:		//if the bot is skilled anough
;3953:		if (attack_skill > 0.3) {
ADDRLP4 272
INDIRF4
CNSTF4 1050253722
LEF4 $1811
line 3954
;3954:			BotAimAtEnemy(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotAimAtEnemy
CALLV
pop
line 3955
;3955:		}
ADDRGP4 $1812
JUMPV
LABELV $1811
line 3956
;3956:		else {
line 3957
;3957:			if (trap_BotMovementViewTarget(bs->ms, &goal, bs->tfl, 300, target)) {
ADDRLP4 376
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 376
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
ARGP4
ADDRLP4 376
INDIRP4
CNSTI4 5984
ADDP4
INDIRI4
ARGI4
CNSTF4 1133903872
ARGF4
ADDRLP4 256
ARGP4
ADDRLP4 380
ADDRGP4 trap_BotMovementViewTarget
CALLI4
ASGNI4
ADDRLP4 380
INDIRI4
CNSTI4 0
EQI4 $1813
line 3958
;3958:				VectorSubtract(target, bs->origin, dir);
ADDRLP4 384
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 276
ADDRLP4 256
INDIRF4
ADDRLP4 384
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 276+4
ADDRLP4 256+4
INDIRF4
ADDRLP4 384
INDIRP4
CNSTI4 4920
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 276+8
ADDRLP4 256+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3959
;3959:				vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 276
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 7852
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 3960
;3960:			}
ADDRGP4 $1814
JUMPV
LABELV $1813
line 3961
;3961:			else {
line 3962
;3962:				vectoangles(moveresult.movedir, bs->ideal_viewangles);
ADDRLP4 0+28
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 7852
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 3963
;3963:			}
LABELV $1814
line 3964
;3964:			bs->ideal_viewangles[2] *= 0.5;
ADDRLP4 384
ADDRFP4 0
INDIRP4
CNSTI4 7860
ADDP4
ASGNP4
ADDRLP4 384
INDIRP4
ADDRLP4 384
INDIRP4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 3965
;3965:		}
LABELV $1812
line 3966
;3966:	}
LABELV $1808
LABELV $1805
line 3967
;3967:	BotCheckForWeaponJump(bs, &moveresult);	// JUHOX
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotCheckForWeaponJump
CALLV
pop
line 3969
;3968:	//if the weapon is used for the bot movement
;3969:	if (moveresult.flags & MOVERESULT_MOVEMENTWEAPON) bs->weaponnum = moveresult.weapon;
ADDRLP4 0+20
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1820
ADDRFP4 0
INDIRP4
CNSTI4 7804
ADDP4
ADDRLP4 0+24
INDIRI4
ASGNI4
LABELV $1820
line 3971
;3970:	//attack the enemy if possible
;3971:	BotCheckAttack(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCheckAttack
CALLV
pop
line 3973
;3972:	//
;3973:	return qtrue;
CNSTI4 1
RETI4
LABELV $1742
endproc AINode_Battle_Retreat 388 20
export AIEnter_Battle_NBG
proc AIEnter_Battle_NBG 204 16
line 3981
;3974:}
;3975:
;3976:/*
;3977:==================
;3978:AIEnter_Battle_NBG
;3979:==================
;3980:*/
;3981:void AIEnter_Battle_NBG(bot_state_t *bs, char *s) {
line 3989
;3982:	// JUHOX: record more info for 'battle NBG'
;3983:#if 0
;3984:	BotRecordNodeSwitch(bs, "battle NBG", "", s);
;3985:#else
;3986:	bot_goal_t goal;
;3987:	char buf[144];
;3988:
;3989:	if (trap_BotGetTopGoal(bs->gs, &goal)) {
ADDRFP4 0
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 200
ADDRGP4 trap_BotGetTopGoal
CALLI4
ASGNI4
ADDRLP4 200
INDIRI4
CNSTI4 0
EQI4 $1825
line 3990
;3990:		trap_BotGoalName(goal.number, buf, 144);
ADDRLP4 0+44
INDIRI4
ARGI4
ADDRLP4 56
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 3991
;3991:		BotRecordNodeSwitch(bs, "battle NBG", buf, s);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1828
ARGP4
ADDRLP4 56
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotRecordNodeSwitch
CALLV
pop
line 3992
;3992:	}
ADDRGP4 $1826
JUMPV
LABELV $1825
line 3993
;3993:	else {
line 3994
;3994:		BotRecordNodeSwitch(bs, "battle NBG", "no goal", s);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1828
ARGP4
ADDRGP4 $1373
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotRecordNodeSwitch
CALLV
pop
line 3995
;3995:	}
LABELV $1826
line 3997
;3996:#endif
;3997:	bs->ainode = AINode_Battle_NBG;
ADDRFP4 0
INDIRP4
CNSTI4 4904
ADDP4
ADDRGP4 AINode_Battle_NBG
ASGNP4
line 3998
;3998:}
LABELV $1824
endproc AIEnter_Battle_NBG 204 16
export AINode_Battle_NBG
proc AINode_Battle_NBG 352 20
line 4005
;3999:
;4000:/*
;4001:==================
;4002:AINode_Battle_NBG
;4003:==================
;4004:*/
;4005:int AINode_Battle_NBG(bot_state_t *bs) {
line 4013
;4006:	int areanum;
;4007:	bot_goal_t goal;
;4008:	aas_entityinfo_t entinfo;
;4009:	bot_moveresult_t moveresult;
;4010:	float attack_skill;
;4011:	vec3_t target, dir;
;4012:
;4013:	if (BotIsObserver(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 280
ADDRGP4 BotIsObserver
CALLI4
ASGNI4
ADDRLP4 280
INDIRI4
CNSTI4 0
EQI4 $1830
line 4014
;4014:		AIEnter_Observer(bs, "battle nbg: observer");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1832
ARGP4
ADDRGP4 AIEnter_Observer
CALLV
pop
line 4015
;4015:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1829
JUMPV
LABELV $1830
line 4018
;4016:	}
;4017:	//if in the intermission
;4018:	if (BotIntermission(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 284
ADDRGP4 BotIntermission
CALLI4
ASGNI4
ADDRLP4 284
INDIRI4
CNSTI4 0
EQI4 $1833
line 4019
;4019:		AIEnter_Intermission(bs, "battle nbg: intermission");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1835
ARGP4
ADDRGP4 AIEnter_Intermission
CALLV
pop
line 4020
;4020:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1829
JUMPV
LABELV $1833
line 4023
;4021:	}
;4022:	//respawn if dead
;4023:	if (BotIsDead(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 288
ADDRGP4 BotIsDead
CALLI4
ASGNI4
ADDRLP4 288
INDIRI4
CNSTI4 0
EQI4 $1836
line 4024
;4024:		AIEnter_Respawn(bs, "battle nbg: bot dead");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1838
ARGP4
ADDRGP4 AIEnter_Respawn
CALLV
pop
line 4025
;4025:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1829
JUMPV
LABELV $1836
line 4028
;4026:	}
;4027:	//if no enemy
;4028:	if (bs->enemy < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 0
GEI4 $1839
line 4029
;4029:		AIEnter_Seek_NBG(bs, "battle nbg: no enemy");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1841
ARGP4
ADDRGP4 AIEnter_Seek_NBG
CALLV
pop
line 4030
;4030:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1829
JUMPV
LABELV $1839
line 4033
;4031:	}
;4032:	//
;4033:	BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
ARGI4
ADDRLP4 108
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 4034
;4034:	if (EntityIsDead(&entinfo)) {
ADDRLP4 108
ARGP4
ADDRLP4 292
ADDRGP4 EntityIsDead
CALLI4
ASGNI4
ADDRLP4 292
INDIRI4
CNSTI4 0
EQI4 $1842
line 4035
;4035:		AIEnter_Seek_NBG(bs, "battle nbg: enemy dead");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1844
ARGP4
ADDRGP4 AIEnter_Seek_NBG
CALLV
pop
line 4036
;4036:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1829
JUMPV
LABELV $1842
line 4039
;4037:	}
;4038:	//
;4039:	bs->tfl = TFL_DEFAULT;
ADDRFP4 0
INDIRP4
CNSTI4 5984
ADDP4
CNSTI4 18616254
ASGNI4
line 4040
;4040:	if (bot_grapple.integer) bs->tfl |= TFL_GRAPPLEHOOK;
ADDRGP4 bot_grapple+12
INDIRI4
CNSTI4 0
EQI4 $1845
ADDRLP4 296
ADDRFP4 0
INDIRP4
CNSTI4 5984
ADDP4
ASGNP4
ADDRLP4 296
INDIRP4
ADDRLP4 296
INDIRP4
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
LABELV $1845
line 4042
;4041:	//if in lava or slime the bot should be able to get out
;4042:	if (BotInLavaOrSlime(bs)) bs->tfl |= TFL_LAVA|TFL_SLIME;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 300
ADDRGP4 BotInLavaOrSlime
CALLI4
ASGNI4
ADDRLP4 300
INDIRI4
CNSTI4 0
EQI4 $1848
ADDRLP4 304
ADDRFP4 0
INDIRP4
CNSTI4 5984
ADDP4
ASGNP4
ADDRLP4 304
INDIRP4
ADDRLP4 304
INDIRP4
INDIRI4
CNSTI4 6291456
BORI4
ASGNI4
LABELV $1848
line 4044
;4043:	//
;4044:	if (BotCanAndWantsToRocketJump(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
ADDRGP4 BotCanAndWantsToRocketJump
CALLI4
ASGNI4
ADDRLP4 308
INDIRI4
CNSTI4 0
EQI4 $1850
line 4045
;4045:		bs->tfl |= TFL_ROCKETJUMP;
ADDRLP4 312
ADDRFP4 0
INDIRP4
CNSTI4 5984
ADDP4
ASGNP4
ADDRLP4 312
INDIRP4
ADDRLP4 312
INDIRP4
INDIRI4
CNSTI4 4096
BORI4
ASGNI4
line 4046
;4046:	}
LABELV $1850
line 4048
;4047:	//map specific code
;4048:	BotMapScripts(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotMapScripts
CALLV
pop
line 4050
;4049:	//update the last time the enemy was visible
;4050:	if (BotEntityVisible(&bs->cur_ps/*bs->entitynum, bs->eye, bs->viewangles*/, 90, bs->enemy)) {	// JUHOX: fov was 360
ADDRLP4 312
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 312
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTF4 1119092736
ARGF4
ADDRLP4 312
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
ARGI4
ADDRLP4 316
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 316
INDIRF4
CNSTF4 0
EQF4 $1852
line 4051
;4051:		bs->enemyvisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7180
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 4052
;4052:		VectorCopy(entinfo.origin, target);
ADDRLP4 252
ADDRLP4 108+24
INDIRB
ASGNB 12
line 4054
;4053:		// if not a player enemy
;4054:		if (bs->enemy >= MAX_CLIENTS) {
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 64
LTI4 $1855
line 4062
;4055:#ifdef MISSIONPACK
;4056:			// if attacking an obelisk
;4057:			if ( bs->enemy == redobelisk.entitynum ||
;4058:				bs->enemy == blueobelisk.entitynum ) {
;4059:				target[2] += 16;
;4060:			}
;4061:#endif
;4062:		}
LABELV $1855
line 4064
;4063:		//update the reachability area and origin if possible
;4064:		areanum = BotPointAreaNum(target);
ADDRLP4 252
ARGP4
ADDRLP4 320
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 248
ADDRLP4 320
INDIRI4
ASGNI4
line 4065
;4065:		if (areanum && trap_AAS_AreaReachability(areanum)) {
ADDRLP4 324
ADDRLP4 248
INDIRI4
ASGNI4
ADDRLP4 324
INDIRI4
CNSTI4 0
EQI4 $1857
ADDRLP4 324
INDIRI4
ARGI4
ADDRLP4 328
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 328
INDIRI4
CNSTI4 0
EQI4 $1857
line 4066
;4066:			VectorCopy(target, bs->lastenemyorigin);
ADDRFP4 0
INDIRP4
CNSTI4 7772
ADDP4
ADDRLP4 252
INDIRB
ASGNB 12
line 4067
;4067:			bs->lastenemyareanum = areanum;
ADDRFP4 0
INDIRP4
CNSTI4 7768
ADDP4
ADDRLP4 248
INDIRI4
ASGNI4
line 4068
;4068:			bs->lastEnemyAreaPredicted = qfalse;	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 7784
ADDP4
CNSTI4 0
ASGNI4
line 4069
;4069:		}
LABELV $1857
line 4070
;4070:	}
LABELV $1852
line 4072
;4071:	//if the bot has no goal or touches the current goal
;4072:	if (!trap_BotGetTopGoal(bs->gs, &goal)) {
ADDRFP4 0
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
ARGP4
ADDRLP4 320
ADDRGP4 trap_BotGetTopGoal
CALLI4
ASGNI4
ADDRLP4 320
INDIRI4
CNSTI4 0
NEI4 $1859
line 4073
;4073:		bs->nbg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6092
ADDP4
CNSTF4 0
ASGNF4
line 4074
;4074:	}
ADDRGP4 $1860
JUMPV
LABELV $1859
line 4075
;4075:	else if (BotReachedGoal(bs, &goal)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ARGP4
ADDRLP4 324
ADDRGP4 BotReachedGoal
CALLI4
ASGNI4
ADDRLP4 324
INDIRI4
CNSTI4 0
EQI4 $1861
line 4076
;4076:		bs->nbg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6092
ADDP4
CNSTF4 0
ASGNF4
line 4077
;4077:	}
LABELV $1861
LABELV $1860
line 4079
;4078:	//
;4079:	if (bs->nbg_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6092
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $1863
line 4081
;4080:		//pop the current goal from the stack
;4081:		trap_BotPopGoal(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotPopGoal
CALLV
pop
line 4083
;4082:		//if the bot still has a goal
;4083:		if (trap_BotGetTopGoal(bs->gs, &goal))
ADDRFP4 0
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
ARGP4
ADDRLP4 328
ADDRGP4 trap_BotGetTopGoal
CALLI4
ASGNI4
ADDRLP4 328
INDIRI4
CNSTI4 0
EQI4 $1865
line 4084
;4084:			AIEnter_Battle_Retreat(bs, "battle nbg: time out");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1867
ARGP4
ADDRGP4 AIEnter_Battle_Retreat
CALLV
pop
ADDRGP4 $1866
JUMPV
LABELV $1865
line 4086
;4085:		else
;4086:			AIEnter_Battle_Fight(bs, "battle nbg: time out");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1867
ARGP4
ADDRGP4 AIEnter_Battle_Fight
CALLV
pop
LABELV $1866
line 4088
;4087:		//
;4088:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1829
JUMPV
LABELV $1863
line 4091
;4089:	}
;4090:	//initialize the movement state
;4091:	BotSetupForMovement(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetupForMovement
CALLV
pop
line 4093
;4092:	//move towards the goal
;4093:	trap_BotMoveToGoal(&moveresult, bs->ms, &goal, bs->tfl);
ADDRLP4 0
ARGP4
ADDRLP4 328
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 328
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
ARGP4
ADDRLP4 328
INDIRP4
CNSTI4 5984
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotMoveToGoal
CALLV
pop
line 4095
;4094:	//if the movement failed
;4095:	if (moveresult.failure) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1868
line 4097
;4096:		//reset the avoid reach, otherwise bot is stuck in current area
;4097:		trap_BotResetAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidReach
CALLV
pop
line 4099
;4098:		//BotAI_Print(PRT_MESSAGE, "movement failure %d\n", moveresult.traveltype);
;4099:		bs->nbg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6092
ADDP4
CNSTF4 0
ASGNF4
line 4100
;4100:	}
LABELV $1868
line 4102
;4101:	//
;4102:	BotAIBlocked(bs, &moveresult, qfalse);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAIBlocked
CALLV
pop
line 4104
;4103:	//update the attack inventory values
;4104:	BotUpdateBattleInventory(bs, bs->enemy);
ADDRLP4 332
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 332
INDIRP4
ARGP4
ADDRLP4 332
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotUpdateBattleInventory
CALLV
pop
line 4106
;4105:	//choose the best weapon to fight with
;4106:	BotChooseWeapon(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotChooseWeapon
CALLV
pop
line 4108
;4107:	//if the view is fixed for the movement
;4108:	if (moveresult.flags & (MOVERESULT_MOVEMENTVIEW|MOVERESULT_SWIMVIEW)) {
ADDRLP4 0+20
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $1870
line 4109
;4109:		VectorCopy(moveresult.ideal_viewangles, bs->ideal_viewangles);
ADDRFP4 0
INDIRP4
CNSTI4 7852
ADDP4
ADDRLP4 0+40
INDIRB
ASGNB 12
line 4110
;4110:		bs->specialMove = qtrue;	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 7744
ADDP4
CNSTI4 1
ASGNI4
line 4111
;4111:	}
ADDRGP4 $1871
JUMPV
LABELV $1870
line 4112
;4112:	else if (!(moveresult.flags & MOVERESULT_MOVEMENTVIEWSET)
ADDRLP4 0+20
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $1874
ADDRFP4 0
INDIRP4
CNSTI4 5992
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
NEI4 $1874
line 4113
;4113:				&& !(bs->flags & BFL_IDEALVIEWSET)) {
line 4114
;4114:		attack_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_ATTACK_SKILL, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 336
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 264
ADDRLP4 336
INDIRF4
ASGNF4
line 4116
;4115:		//if the bot is skilled anough and the enemy is visible
;4116:		if (attack_skill > 0.3) {
ADDRLP4 264
INDIRF4
CNSTF4 1050253722
LEF4 $1877
line 4118
;4117:			//&& BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, bs->enemy)
;4118:			BotAimAtEnemy(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotAimAtEnemy
CALLV
pop
line 4119
;4119:		}
ADDRGP4 $1878
JUMPV
LABELV $1877
line 4120
;4120:		else {
line 4121
;4121:			if (trap_BotMovementViewTarget(bs->ms, &goal, bs->tfl, 300, target)) {
ADDRLP4 340
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 340
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
ARGP4
ADDRLP4 340
INDIRP4
CNSTI4 5984
ADDP4
INDIRI4
ARGI4
CNSTF4 1133903872
ARGF4
ADDRLP4 252
ARGP4
ADDRLP4 344
ADDRGP4 trap_BotMovementViewTarget
CALLI4
ASGNI4
ADDRLP4 344
INDIRI4
CNSTI4 0
EQI4 $1879
line 4122
;4122:				VectorSubtract(target, bs->origin, dir);
ADDRLP4 348
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 268
ADDRLP4 252
INDIRF4
ADDRLP4 348
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 268+4
ADDRLP4 252+4
INDIRF4
ADDRLP4 348
INDIRP4
CNSTI4 4920
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 268+8
ADDRLP4 252+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRF4
SUBF4
ASGNF4
line 4123
;4123:				vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 268
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 7852
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 4124
;4124:			}
ADDRGP4 $1880
JUMPV
LABELV $1879
line 4125
;4125:			else {
line 4126
;4126:				vectoangles(moveresult.movedir, bs->ideal_viewangles);
ADDRLP4 0+28
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 7852
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 4127
;4127:			}
LABELV $1880
line 4128
;4128:			bs->ideal_viewangles[2] *= 0.5;
ADDRLP4 348
ADDRFP4 0
INDIRP4
CNSTI4 7860
ADDP4
ASGNP4
ADDRLP4 348
INDIRP4
ADDRLP4 348
INDIRP4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 4129
;4129:		}
LABELV $1878
line 4130
;4130:	}
LABELV $1874
LABELV $1871
line 4131
;4131:	BotCheckForWeaponJump(bs, &moveresult);	// JUHOX
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotCheckForWeaponJump
CALLV
pop
line 4133
;4132:	//if the weapon is used for the bot movement
;4133:	if (moveresult.flags & MOVERESULT_MOVEMENTWEAPON) bs->weaponnum = moveresult.weapon;
ADDRLP4 0+20
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1886
ADDRFP4 0
INDIRP4
CNSTI4 7804
ADDP4
ADDRLP4 0+24
INDIRI4
ASGNI4
LABELV $1886
line 4135
;4134:	//attack the enemy if possible
;4135:	BotCheckAttack(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCheckAttack
CALLV
pop
line 4137
;4136:	//
;4137:	return qtrue;
CNSTI4 1
RETI4
LABELV $1829
endproc AINode_Battle_NBG 352 20
bss
export nodeswitch
align 1
LABELV nodeswitch
skip 7344
export numnodeswitches
align 4
LABELV numnodeswitches
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
import AIEnter_Seek_Camp
import BotPrintTeamGoal
import BotMatchMessage
import notleader
import BotChatTest
import BotValidChatPosition
import BotChatTime
import BotChat_Random
import BotChat_EnemySuicide
import BotChat_Kill
import BotChat_Death
import BotChat_HitNoKill
import BotChat_HitNoDeath
import BotChat_HitTalking
import BotChat_EndLevel
import BotChat_StartLevel
import BotChat_ExitGame
import BotChat_EnterGame
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
import G_RunClient
import ClientEndFrame
import ClientThink
import ClientImpacts
import SetTargetPos
import CheckPlayerDischarge
import TotalChargeDamage
import TSS_Run
import TSS_DangerIndex
import IsPlayerInvolvedInFighting
import NearHomeBase
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
import G_TouchTriggers
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
LABELV $1867
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 110
byte 1 98
byte 1 103
byte 1 58
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 0
align 1
LABELV $1844
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 110
byte 1 98
byte 1 103
byte 1 58
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 100
byte 1 101
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $1841
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 110
byte 1 98
byte 1 103
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 0
align 1
LABELV $1838
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 110
byte 1 98
byte 1 103
byte 1 58
byte 1 32
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 100
byte 1 101
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $1835
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 110
byte 1 98
byte 1 103
byte 1 58
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1832
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 110
byte 1 98
byte 1 103
byte 1 58
byte 1 32
byte 1 111
byte 1 98
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1828
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 78
byte 1 66
byte 1 71
byte 1 0
align 1
LABELV $1795
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 58
byte 1 32
byte 1 110
byte 1 98
byte 1 103
byte 1 0
align 1
LABELV $1780
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 58
byte 1 32
byte 1 108
byte 1 111
byte 1 115
byte 1 116
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 0
align 1
LABELV $1777
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 58
byte 1 32
byte 1 105
byte 1 103
byte 1 110
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 0
align 1
LABELV $1767
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 58
byte 1 32
byte 1 119
byte 1 97
byte 1 110
byte 1 116
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $1757
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 58
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 100
byte 1 101
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $1754
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 0
align 1
LABELV $1751
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 58
byte 1 32
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 100
byte 1 101
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $1748
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 58
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1745
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 58
byte 1 32
byte 1 111
byte 1 98
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1741
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $1705
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 115
byte 1 101
byte 1 58
byte 1 32
byte 1 110
byte 1 98
byte 1 103
byte 1 0
align 1
LABELV $1700
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 115
byte 1 101
byte 1 58
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 0
align 1
LABELV $1665
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 115
byte 1 101
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 97
byte 1 0
align 1
LABELV $1662
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 115
byte 1 101
byte 1 58
byte 1 32
byte 1 98
byte 1 101
byte 1 116
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 0
align 1
LABELV $1657
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 115
byte 1 101
byte 1 58
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 100
byte 1 101
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $1653
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 115
byte 1 101
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 0
align 1
LABELV $1650
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 115
byte 1 101
byte 1 58
byte 1 32
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 100
byte 1 101
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $1647
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 115
byte 1 101
byte 1 58
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1644
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 115
byte 1 101
byte 1 58
byte 1 32
byte 1 111
byte 1 98
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1640
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $1638
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 102
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 58
byte 1 32
byte 1 119
byte 1 97
byte 1 110
byte 1 116
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $1631
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 102
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 58
byte 1 32
byte 1 103
byte 1 111
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 78
byte 1 66
byte 1 71
byte 1 0
align 1
LABELV $1619
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 102
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 58
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 115
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $1614
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 102
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 58
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 104
byte 1 105
byte 1 116
byte 1 32
byte 1 115
byte 1 111
byte 1 109
byte 1 101
byte 1 111
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $1609
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 102
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 58
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 32
byte 1 100
byte 1 101
byte 1 99
byte 1 114
byte 1 101
byte 1 97
byte 1 115
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $1597
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 102
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 58
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 100
byte 1 101
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $1588
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 102
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 0
align 1
LABELV $1583
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 102
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 58
byte 1 32
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 100
byte 1 101
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $1580
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 102
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 58
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1577
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 102
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 58
byte 1 32
byte 1 111
byte 1 98
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1572
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 102
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $1511
byte 1 108
byte 1 116
byte 1 103
byte 1 32
byte 1 115
byte 1 101
byte 1 101
byte 1 107
byte 1 58
byte 1 32
byte 1 110
byte 1 98
byte 1 103
byte 1 0
align 1
LABELV $1473
byte 1 115
byte 1 101
byte 1 101
byte 1 107
byte 1 32
byte 1 108
byte 1 116
byte 1 103
byte 1 58
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 0
align 1
LABELV $1457
byte 1 115
byte 1 101
byte 1 101
byte 1 107
byte 1 32
byte 1 108
byte 1 116
byte 1 103
byte 1 58
byte 1 32
byte 1 114
byte 1 97
byte 1 110
byte 1 100
byte 1 111
byte 1 109
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $1454
byte 1 115
byte 1 101
byte 1 101
byte 1 107
byte 1 32
byte 1 108
byte 1 116
byte 1 103
byte 1 58
byte 1 32
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 100
byte 1 101
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $1451
byte 1 115
byte 1 101
byte 1 101
byte 1 107
byte 1 32
byte 1 108
byte 1 116
byte 1 103
byte 1 58
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1448
byte 1 115
byte 1 101
byte 1 101
byte 1 107
byte 1 32
byte 1 108
byte 1 116
byte 1 103
byte 1 58
byte 1 32
byte 1 111
byte 1 98
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1444
byte 1 115
byte 1 101
byte 1 101
byte 1 107
byte 1 32
byte 1 76
byte 1 84
byte 1 71
byte 1 0
align 1
LABELV $1443
byte 1 35
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $1441
byte 1 115
byte 1 101
byte 1 101
byte 1 107
byte 1 32
byte 1 110
byte 1 98
byte 1 103
byte 1 58
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 0
align 1
LABELV $1401
byte 1 115
byte 1 101
byte 1 101
byte 1 107
byte 1 32
byte 1 110
byte 1 98
byte 1 103
byte 1 58
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 0
align 1
LABELV $1383
byte 1 115
byte 1 101
byte 1 101
byte 1 107
byte 1 32
byte 1 110
byte 1 98
byte 1 103
byte 1 58
byte 1 32
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 100
byte 1 101
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $1380
byte 1 115
byte 1 101
byte 1 101
byte 1 107
byte 1 32
byte 1 110
byte 1 98
byte 1 103
byte 1 58
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1377
byte 1 115
byte 1 101
byte 1 101
byte 1 107
byte 1 32
byte 1 110
byte 1 98
byte 1 103
byte 1 58
byte 1 32
byte 1 111
byte 1 98
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1373
byte 1 110
byte 1 111
byte 1 32
byte 1 103
byte 1 111
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $1372
byte 1 115
byte 1 101
byte 1 101
byte 1 107
byte 1 32
byte 1 78
byte 1 66
byte 1 71
byte 1 0
align 1
LABELV $1367
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 58
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 0
align 1
LABELV $1316
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 58
byte 1 32
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $1305
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 58
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 0
align 1
LABELV $1282
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 103
byte 1 111
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $1274
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 58
byte 1 32
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 100
byte 1 101
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $1271
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 58
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1268
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 58
byte 1 32
byte 1 111
byte 1 98
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1264
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $1164
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 58
byte 1 32
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $1158
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $1156
byte 1 115
byte 1 116
byte 1 97
byte 1 110
byte 1 100
byte 1 58
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 0
align 1
LABELV $1153
byte 1 115
byte 1 116
byte 1 97
byte 1 110
byte 1 100
byte 1 58
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 0
align 1
LABELV $1143
byte 1 115
byte 1 116
byte 1 97
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $1141
byte 1 111
byte 1 98
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 58
byte 1 32
byte 1 108
byte 1 101
byte 1 102
byte 1 116
byte 1 32
byte 1 111
byte 1 98
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1137
byte 1 111
byte 1 98
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1135
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 58
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $1127
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1092
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $1089
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 95
byte 1 115
byte 1 116
byte 1 111
byte 1 112
byte 1 0
align 1
LABELV $1019
byte 1 112
byte 1 97
byte 1 116
byte 1 114
byte 1 111
byte 1 108
byte 1 95
byte 1 115
byte 1 116
byte 1 111
byte 1 112
byte 1 0
align 1
LABELV $1006
byte 1 112
byte 1 97
byte 1 116
byte 1 114
byte 1 111
byte 1 108
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $1005
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 0
align 1
LABELV $935
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 95
byte 1 115
byte 1 116
byte 1 111
byte 1 112
byte 1 0
align 1
LABELV $932
byte 1 111
byte 1 110
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $931
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $922
byte 1 97
byte 1 99
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 97
byte 1 110
byte 1 121
byte 1 95
byte 1 99
byte 1 97
byte 1 110
byte 1 110
byte 1 111
byte 1 116
byte 1 102
byte 1 105
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $913
byte 1 66
byte 1 111
byte 1 116
byte 1 76
byte 1 111
byte 1 110
byte 1 103
byte 1 84
byte 1 101
byte 1 114
byte 1 109
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 58
byte 1 32
byte 1 103
byte 1 111
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 97
byte 1 105
byte 1 114
byte 1 0
align 1
LABELV $891
byte 1 97
byte 1 99
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 97
byte 1 110
byte 1 121
byte 1 95
byte 1 97
byte 1 114
byte 1 114
byte 1 105
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $798
byte 1 97
byte 1 99
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 97
byte 1 110
byte 1 121
byte 1 95
byte 1 115
byte 1 116
byte 1 111
byte 1 112
byte 1 0
align 1
LABELV $795
byte 1 121
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $794
byte 1 97
byte 1 99
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 97
byte 1 110
byte 1 121
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $769
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $646
byte 1 72
byte 1 69
byte 1 69
byte 1 69
byte 1 69
byte 1 69
byte 1 69
byte 1 69
byte 1 69
byte 1 76
byte 1 80
byte 1 32
byte 1 77
byte 1 69
byte 1 69
byte 1 69
byte 1 69
byte 1 69
byte 1 69
byte 1 69
byte 1 69
byte 1 33
byte 1 0
align 1
LABELV $566
byte 1 101
byte 1 109
byte 1 101
byte 1 114
byte 1 103
byte 1 101
byte 1 110
byte 1 99
byte 1 121
byte 1 0
align 1
LABELV $464
byte 1 66
byte 1 85
byte 1 71
byte 1 33
byte 1 32
byte 1 66
byte 1 111
byte 1 116
byte 1 67
byte 1 104
byte 1 111
byte 1 111
byte 1 115
byte 1 101
byte 1 78
byte 1 101
byte 1 97
byte 1 114
byte 1 98
byte 1 121
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 58
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 32
byte 1 35
byte 1 37
byte 1 100
byte 1 32
byte 1 40
byte 1 37
byte 1 115
byte 1 41
byte 1 0
align 1
LABELV $101
byte 1 37
byte 1 115
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 50
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $99
byte 1 0
align 1
LABELV $94
byte 1 37
byte 1 115
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 115
byte 1 119
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 101
byte 1 100
byte 1 32
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 110
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 65
byte 1 73
byte 1 32
byte 1 110
byte 1 111
byte 1 100
byte 1 101
byte 1 115
byte 1 10
byte 1 0
