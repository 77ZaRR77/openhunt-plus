export BotGetItemTeamGoal
code
proc BotGetItemTeamGoal 12 12
file "..\..\..\..\code\game\ai_cmd.c"
line 155
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:
;4:/*****************************************************************************
;5: * name:		ai_cmd.c
;6: *
;7: * desc:		Quake3 bot AI
;8: *
;9: * $Archive: /MissionPack/code/game/ai_cmd.c $
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
;30://
;31:#include "chars.h"				//characteristics
;32:#include "inv.h"				//indexes into the inventory
;33:#include "syn.h"				//synonyms
;34:#include "match.h"				//string matching types and vars
;35:
;36:// for the voice chats
;37:#include "../../ui/menudef.h"
;38:
;39:int notleader[MAX_CLIENTS];
;40:
;41:#ifdef DEBUG
;42:/*
;43:==================
;44:BotPrintTeamGoal
;45:==================
;46:*/
;47:void BotPrintTeamGoal(bot_state_t *bs) {
;48:	char netname[MAX_NETNAME];
;49:	float t;
;50:
;51:	ClientName(bs->client, netname, sizeof(netname));
;52:	t = bs->teamgoal_time - FloatTime();
;53:	switch(bs->ltgtype) {
;54:		case LTG_TEAMHELP:
;55:		{
;56:			BotAI_Print(PRT_MESSAGE, "%s: I'm gonna help a team mate for %1.0f secs\n", netname, t);
;57:			break;
;58:		}
;59:		case LTG_TEAMACCOMPANY:
;60:		{
;61:			BotAI_Print(PRT_MESSAGE, "%s: I'm gonna accompany a team mate for %1.0f secs\n", netname, t);
;62:			break;
;63:		}
;64:		case LTG_GETFLAG:
;65:		{
;66:			BotAI_Print(PRT_MESSAGE, "%s: I'm gonna get the flag for %1.0f secs\n", netname, t);
;67:			break;
;68:		}
;69:		case LTG_RUSHBASE:
;70:		{
;71:			BotAI_Print(PRT_MESSAGE, "%s: I'm gonna rush to the base for %1.0f secs\n", netname, t);
;72:			break;
;73:		}
;74:		case LTG_RETURNFLAG:
;75:		{
;76:			BotAI_Print(PRT_MESSAGE, "%s: I'm gonna try to return the flag for %1.0f secs\n", netname, t);
;77:			break;
;78:		}
;79:#ifdef MISSIONPACK
;80:		case LTG_ATTACKENEMYBASE:
;81:		{
;82:			BotAI_Print(PRT_MESSAGE, "%s: I'm gonna attack the enemy base for %1.0f secs\n", netname, t);
;83:			break;
;84:		}
;85:		case LTG_HARVEST:
;86:		{
;87:			BotAI_Print(PRT_MESSAGE, "%s: I'm gonna harvest for %1.0f secs\n", netname, t);
;88:			break;
;89:		}
;90:#endif
;91:		case LTG_DEFENDKEYAREA:
;92:		{
;93:			BotAI_Print(PRT_MESSAGE, "%s: I'm gonna defend a key area for %1.0f secs\n", netname, t);
;94:			break;
;95:		}
;96:		case LTG_GETITEM:
;97:		{
;98:			BotAI_Print(PRT_MESSAGE, "%s: I'm gonna get an item for %1.0f secs\n", netname, t);
;99:			break;
;100:		}
;101:		case LTG_KILL:
;102:		{
;103:			BotAI_Print(PRT_MESSAGE, "%s: I'm gonna kill someone for %1.0f secs\n", netname, t);
;104:			break;
;105:		}
;106:		case LTG_CAMP:
;107:		case LTG_CAMPORDER:
;108:		{
;109:			BotAI_Print(PRT_MESSAGE, "%s: I'm gonna camp for %1.0f secs\n", netname, t);
;110:			break;
;111:		}
;112:		case LTG_PATROL:
;113:		{
;114:			BotAI_Print(PRT_MESSAGE, "%s: I'm gonna patrol for %1.0f secs\n", netname, t);
;115:			break;
;116:		}
;117:		// JUHOX: print new LTG_ESCAPE
;118:#if 1
;119:		case LTG_ESCAPE:
;120:		{
;121:			BotAI_Print(PRT_MESSAGE, "%s: I'm gonna escape for %1.0f secs\n", netname, t);
;122:			break;
;123:		}
;124:#endif
;125:		// JUHOX: print new LTG_WAIT
;126:#if 1
;127:		case LTG_WAIT:
;128:		{
;129:			BotAI_Print(PRT_MESSAGE, "%s: I'm gonna wait for %1.0f secs\n", netname, t);
;130:			break;
;131:		}
;132:#endif
;133:		default:
;134:		{
;135:			if (bs->ctfroam_time > FloatTime()) {
;136:				t = bs->ctfroam_time - FloatTime();
;137:				BotAI_Print(PRT_MESSAGE, "%s: I'm gonna roam for %1.0f secs\n", netname, t);
;138:			}
;139:			else {
;140:				BotAI_Print(PRT_MESSAGE, "%s: I've got a regular goal\n", netname);
;141:			}
;142:		}
;143:	}
;144:}
;145:#endif //DEBUG
;146:
;147:/*
;148:==================
;149:BotGetItemTeamGoal
;150:
;151:FIXME: add stuff like "upper rocket launcher"
;152:"the rl near the railgun", "lower grenade launcher" etc.
;153:==================
;154:*/
;155:int BotGetItemTeamGoal(char *goalname, bot_goal_t *goal) {
line 158
;156:	int i;
;157:
;158:	if (!strlen(goalname)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $93
CNSTI4 0
RETI4
ADDRGP4 $92
JUMPV
LABELV $93
line 159
;159:	i = -1;
ADDRLP4 0
CNSTI4 -1
ASGNI4
LABELV $95
line 160
;160:	do {
line 161
;161:		i = trap_BotGetLevelItemGoal(i, goalname, goal);
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 162
;162:		if (i > 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $98
line 164
;163:			//do NOT defend dropped items
;164:			if (goal->flags & GFL_DROPPED)
ADDRFP4 4
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $100
line 165
;165:				continue;
ADDRGP4 $96
JUMPV
LABELV $100
line 166
;166:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $92
JUMPV
LABELV $98
line 168
;167:		}
;168:	} while(i > 0);
LABELV $96
ADDRLP4 0
INDIRI4
CNSTI4 0
GTI4 $95
line 169
;169:	return qfalse;
CNSTI4 0
RETI4
LABELV $92
endproc BotGetItemTeamGoal 12 12
export BotGetMessageTeamGoal
proc BotGetMessageTeamGoal 12 12
line 177
;170:}
;171:
;172:/*
;173:==================
;174:BotGetMessageTeamGoal
;175:==================
;176:*/
;177:int BotGetMessageTeamGoal(bot_state_t *bs, char *goalname, bot_goal_t *goal) {
line 180
;178:	bot_waypoint_t *cp;
;179:
;180:	if (BotGetItemTeamGoal(goalname, goal)) return qtrue;
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 BotGetItemTeamGoal
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $103
CNSTI4 1
RETI4
ADDRGP4 $102
JUMPV
LABELV $103
line 182
;181:
;182:	cp = BotFindWayPoint(bs->checkpoints, goalname);
ADDRFP4 0
INDIRP4
CNSTI4 14404
ADDP4
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BotFindWayPoint
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 183
;183:	if (cp) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $105
line 184
;184:		memcpy(goal, &cp->goal, sizeof(bot_goal_t));
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 185
;185:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $102
JUMPV
LABELV $105
line 187
;186:	}
;187:	return qfalse;
CNSTI4 0
RETI4
LABELV $102
endproc BotGetMessageTeamGoal 12 12
export BotGetTime
proc BotGetTime 600 16
line 195
;188:}
;189:
;190:/*
;191:==================
;192:BotGetTime
;193:==================
;194:*/
;195:float BotGetTime(bot_match_t *match) {
line 201
;196:	bot_match_t timematch;
;197:	char timestring[MAX_MESSAGE_SIZE];
;198:	float t;
;199:
;200:	//if the matched string has a time
;201:	if (match->subtype & ST_TIME) {
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $108
line 203
;202:		//get the time string
;203:		trap_BotMatchVariable(match, TIME, timestring, MAX_MESSAGE_SIZE);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 6
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 205
;204:		//match it to find out if the time is in seconds or minutes
;205:		if (trap_BotFindMatch(timestring, &timematch, MTCONTEXT_TIME)) {
ADDRLP4 0
ARGP4
ADDRLP4 256
ARGP4
CNSTU4 8
ARGU4
ADDRLP4 588
ADDRGP4 trap_BotFindMatch
CALLI4
ASGNI4
ADDRLP4 588
INDIRI4
CNSTI4 0
EQI4 $110
line 206
;206:			if (timematch.type == MSG_FOREVER) {
ADDRLP4 256+256
INDIRI4
CNSTI4 107
NEI4 $112
line 207
;207:				t = 99999999.0f;
ADDRLP4 584
CNSTF4 1287568416
ASGNF4
line 208
;208:			}
ADDRGP4 $113
JUMPV
LABELV $112
line 209
;209:			else if (timematch.type == MSG_FORAWHILE) {
ADDRLP4 256+256
INDIRI4
CNSTI4 109
NEI4 $115
line 210
;210:				t = 10 * 60; // 10 minutes
ADDRLP4 584
CNSTF4 1142292480
ASGNF4
line 211
;211:			}
ADDRGP4 $116
JUMPV
LABELV $115
line 212
;212:			else if (timematch.type == MSG_FORALONGTIME) {
ADDRLP4 256+256
INDIRI4
CNSTI4 108
NEI4 $118
line 213
;213:				t = 30 * 60; // 30 minutes
ADDRLP4 584
CNSTF4 1155596288
ASGNF4
line 214
;214:			}
ADDRGP4 $119
JUMPV
LABELV $118
line 215
;215:			else {
line 216
;216:				trap_BotMatchVariable(&timematch, TIME, timestring, MAX_MESSAGE_SIZE);
ADDRLP4 256
ARGP4
CNSTI4 6
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 217
;217:				if (timematch.type == MSG_MINUTES) t = atof(timestring) * 60;
ADDRLP4 256+256
INDIRI4
CNSTI4 105
NEI4 $121
ADDRLP4 0
ARGP4
ADDRLP4 592
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 584
ADDRLP4 592
INDIRF4
CNSTF4 1114636288
MULF4
ASGNF4
ADDRGP4 $122
JUMPV
LABELV $121
line 218
;218:				else if (timematch.type == MSG_SECONDS) t = atof(timestring);
ADDRLP4 256+256
INDIRI4
CNSTI4 106
NEI4 $124
ADDRLP4 0
ARGP4
ADDRLP4 596
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 584
ADDRLP4 596
INDIRF4
ASGNF4
ADDRGP4 $125
JUMPV
LABELV $124
line 219
;219:				else t = 0;
ADDRLP4 584
CNSTF4 0
ASGNF4
LABELV $125
LABELV $122
line 220
;220:			}
LABELV $119
LABELV $116
LABELV $113
line 222
;221:			//if there's a valid time
;222:			if (t > 0) return FloatTime() + t;
ADDRLP4 584
INDIRF4
CNSTF4 0
LEF4 $127
ADDRGP4 floattime
INDIRF4
ADDRLP4 584
INDIRF4
ADDF4
RETF4
ADDRGP4 $107
JUMPV
LABELV $127
line 223
;223:		}
LABELV $110
line 224
;224:	}
LABELV $108
line 225
;225:	return 0;
CNSTF4 0
RETF4
LABELV $107
endproc BotGetTime 600 16
bss
align 4
LABELV $130
skip 4
export FindClientByName
code
proc FindClientByName 1040 12
line 233
;226:}
;227:
;228:/*
;229:==================
;230:FindClientByName
;231:==================
;232:*/
;233:int FindClientByName(char *name) {
line 238
;234:	int i;
;235:	char buf[MAX_INFO_STRING];
;236:	static int maxclients;
;237:
;238:	if (!maxclients)
ADDRGP4 $130
INDIRI4
CNSTI4 0
NEI4 $131
line 239
;239:		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
ADDRGP4 $133
ARGP4
ADDRLP4 1028
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 $130
ADDRLP4 1028
INDIRI4
ASGNI4
LABELV $131
line 240
;240:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $137
JUMPV
LABELV $134
line 241
;241:		ClientName(i, buf, sizeof(buf));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 242
;242:		if (!Q_stricmp(buf, name)) return i;
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1032
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 0
NEI4 $138
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $129
JUMPV
LABELV $138
line 243
;243:	}
LABELV $135
line 240
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $137
ADDRLP4 0
INDIRI4
ADDRGP4 $130
INDIRI4
GEI4 $140
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $134
LABELV $140
line 244
;244:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $144
JUMPV
LABELV $141
line 245
;245:		ClientName(i, buf, sizeof(buf));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 246
;246:		if (stristr(buf, name)) return i;
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1036
ADDRGP4 stristr
CALLP4
ASGNP4
ADDRLP4 1036
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $145
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $129
JUMPV
LABELV $145
line 247
;247:	}
LABELV $142
line 244
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $144
ADDRLP4 0
INDIRI4
ADDRGP4 $130
INDIRI4
GEI4 $147
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $141
LABELV $147
line 248
;248:	return -1;
CNSTI4 -1
RETI4
LABELV $129
endproc FindClientByName 1040 12
bss
align 4
LABELV $149
skip 4
export FindEnemyByName
code
proc FindEnemyByName 1044 12
line 256
;249:}
;250:
;251:/*
;252:==================
;253:FindEnemyByName
;254:==================
;255:*/
;256:int FindEnemyByName(bot_state_t *bs, char *name) {
line 261
;257:	int i;
;258:	char buf[MAX_INFO_STRING];
;259:	static int maxclients;
;260:
;261:	if (!maxclients)
ADDRGP4 $149
INDIRI4
CNSTI4 0
NEI4 $150
line 262
;262:		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
ADDRGP4 $133
ARGP4
ADDRLP4 1028
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 $149
ADDRLP4 1028
INDIRI4
ASGNI4
LABELV $150
line 263
;263:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $155
JUMPV
LABELV $152
line 264
;264:		if (BotSameTeam(bs, i)) continue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1032
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 0
EQI4 $156
ADDRGP4 $153
JUMPV
LABELV $156
line 265
;265:		ClientName(i, buf, sizeof(buf));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 266
;266:		if (!Q_stricmp(buf, name)) return i;
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1036
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
NEI4 $158
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $148
JUMPV
LABELV $158
line 267
;267:	}
LABELV $153
line 263
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $155
ADDRLP4 0
INDIRI4
ADDRGP4 $149
INDIRI4
GEI4 $160
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $152
LABELV $160
line 268
;268:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $164
JUMPV
LABELV $161
line 269
;269:		if (BotSameTeam(bs, i)) continue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1036
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
EQI4 $165
ADDRGP4 $162
JUMPV
LABELV $165
line 270
;270:		ClientName(i, buf, sizeof(buf));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 271
;271:		if (stristr(buf, name)) return i;
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1040
ADDRGP4 stristr
CALLP4
ASGNP4
ADDRLP4 1040
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $167
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $148
JUMPV
LABELV $167
line 272
;272:	}
LABELV $162
line 268
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $164
ADDRLP4 0
INDIRI4
ADDRGP4 $149
INDIRI4
GEI4 $169
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $161
LABELV $169
line 273
;273:	return -1;
CNSTI4 -1
RETI4
LABELV $148
endproc FindEnemyByName 1044 12
bss
align 4
LABELV $171
skip 4
export NumPlayersOnSameTeam
code
proc NumPlayersOnSameTeam 1044 12
line 281
;274:}
;275:
;276:/*
;277:==================
;278:NumPlayersOnSameTeam
;279:==================
;280:*/
;281:int NumPlayersOnSameTeam(bot_state_t *bs) {
line 286
;282:	int i, num;
;283:	char buf[MAX_INFO_STRING];
;284:	static int maxclients;
;285:
;286:	if (!maxclients)
ADDRGP4 $171
INDIRI4
CNSTI4 0
NEI4 $172
line 287
;287:		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
ADDRGP4 $133
ARGP4
ADDRLP4 1032
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 $171
ADDRLP4 1032
INDIRI4
ASGNI4
LABELV $172
line 289
;288:
;289:	num = 0;
ADDRLP4 1028
CNSTI4 0
ASGNI4
line 290
;290:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $177
JUMPV
LABELV $174
line 291
;291:		trap_GetConfigstring(CS_PLAYERS+i, buf, MAX_INFO_STRING);
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 292
;292:		if (strlen(buf)) {
ADDRLP4 4
ARGP4
ADDRLP4 1036
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
EQI4 $178
line 293
;293:			if (BotSameTeam(bs, i+1)) num++;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 1040
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
EQI4 $180
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $180
line 294
;294:		}
LABELV $178
line 295
;295:	}
LABELV $175
line 290
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $177
ADDRLP4 0
INDIRI4
ADDRGP4 $171
INDIRI4
GEI4 $182
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $174
LABELV $182
line 296
;296:	return num;
ADDRLP4 1028
INDIRI4
RETI4
LABELV $170
endproc NumPlayersOnSameTeam 1044 12
export BotGetPatrolWaypoints
proc BotGetPatrolWaypoints 672 16
line 304
;297:}
;298:
;299:/*
;300:==================
;301:TeamPlayIsOn
;302:==================
;303:*/
;304:int BotGetPatrolWaypoints(bot_state_t *bs, bot_match_t *match) {
line 311
;305:	char keyarea[MAX_MESSAGE_SIZE];
;306:	int patrolflags;
;307:	bot_waypoint_t *wp, *newwp, *newpatrolpoints;
;308:	bot_match_t keyareamatch;
;309:	bot_goal_t goal;
;310:
;311:	newpatrolpoints = NULL;
ADDRLP4 592
CNSTP4 0
ASGNP4
line 312
;312:	patrolflags = 0;
ADDRLP4 652
CNSTI4 0
ASGNI4
line 314
;313:	//
;314:	trap_BotMatchVariable(match, KEYAREA, keyarea, MAX_MESSAGE_SIZE);
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 5
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
ADDRGP4 $185
JUMPV
LABELV $184
line 316
;315:	//
;316:	while(1) {
line 317
;317:		if (!trap_BotFindMatch(keyarea, &keyareamatch, MTCONTEXT_PATROLKEYAREA)) {
ADDRLP4 8
ARGP4
ADDRLP4 264
ARGP4
CNSTU4 64
ARGU4
ADDRLP4 656
ADDRGP4 trap_BotFindMatch
CALLI4
ASGNI4
ADDRLP4 656
INDIRI4
CNSTI4 0
NEI4 $187
line 318
;318:			trap_EA_SayTeam(bs->client, "what do you say?");
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 $189
ARGP4
ADDRGP4 trap_EA_SayTeam
CALLV
pop
line 319
;319:			BotFreeWaypoints(newpatrolpoints);
ADDRLP4 592
INDIRP4
ARGP4
ADDRGP4 BotFreeWaypoints
CALLV
pop
line 320
;320:			bs->patrolpoints = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 14408
ADDP4
CNSTP4 0
ASGNP4
line 321
;321:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $183
JUMPV
LABELV $187
line 323
;322:		}
;323:		trap_BotMatchVariable(&keyareamatch, KEYAREA, keyarea, MAX_MESSAGE_SIZE);
ADDRLP4 264
ARGP4
CNSTI4 5
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 324
;324:		if (!BotGetMessageTeamGoal(bs, keyarea, &goal)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 596
ARGP4
ADDRLP4 660
ADDRGP4 BotGetMessageTeamGoal
CALLI4
ASGNI4
ADDRLP4 660
INDIRI4
CNSTI4 0
NEI4 $190
line 327
;325:			//BotAI_BotInitialChat(bs, "cannotfind", keyarea, NULL);
;326:			//trap_BotEnterChat(bs->cs, 0, CHAT_TEAM);
;327:			BotFreeWaypoints(newpatrolpoints);
ADDRLP4 592
INDIRP4
ARGP4
ADDRGP4 BotFreeWaypoints
CALLV
pop
line 328
;328:			bs->patrolpoints = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 14408
ADDP4
CNSTP4 0
ASGNP4
line 329
;329:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $183
JUMPV
LABELV $190
line 332
;330:		}
;331:		//create a new waypoint
;332:		newwp = BotCreateWayPoint(keyarea, goal.origin, goal.areanum);
ADDRLP4 8
ARGP4
ADDRLP4 596
ARGP4
ADDRLP4 596+12
INDIRI4
ARGI4
ADDRLP4 664
ADDRGP4 BotCreateWayPoint
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 664
INDIRP4
ASGNP4
line 333
;333:		if (!newwp)
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $193
line 334
;334:			break;
ADDRGP4 $186
JUMPV
LABELV $193
line 336
;335:		//add the waypoint to the patrol points
;336:		newwp->next = NULL;
ADDRLP4 4
INDIRP4
CNSTI4 92
ADDP4
CNSTP4 0
ASGNP4
line 337
;337:		for (wp = newpatrolpoints; wp && wp->next; wp = wp->next);
ADDRLP4 0
ADDRLP4 592
INDIRP4
ASGNP4
ADDRGP4 $198
JUMPV
LABELV $195
LABELV $196
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
ASGNP4
LABELV $198
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $199
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $195
LABELV $199
line 338
;338:		if (!wp) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $200
line 339
;339:			newpatrolpoints = newwp;
ADDRLP4 592
ADDRLP4 4
INDIRP4
ASGNP4
line 340
;340:			newwp->prev = NULL;
ADDRLP4 4
INDIRP4
CNSTI4 96
ADDP4
CNSTP4 0
ASGNP4
line 341
;341:		}
ADDRGP4 $201
JUMPV
LABELV $200
line 342
;342:		else {
line 343
;343:			wp->next = newwp;
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 344
;344:			newwp->prev = wp;
ADDRLP4 4
INDIRP4
CNSTI4 96
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 345
;345:		}
LABELV $201
line 347
;346:		//
;347:		if (keyareamatch.subtype & ST_BACK) {
ADDRLP4 264+260
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $202
line 348
;348:			patrolflags = PATROL_LOOP;
ADDRLP4 652
CNSTI4 1
ASGNI4
line 349
;349:			break;
ADDRGP4 $186
JUMPV
LABELV $202
line 351
;350:		}
;351:		else if (keyareamatch.subtype & ST_REVERSE) {
ADDRLP4 264+260
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $205
line 352
;352:			patrolflags = PATROL_REVERSE;
ADDRLP4 652
CNSTI4 2
ASGNI4
line 353
;353:			break;
ADDRGP4 $186
JUMPV
LABELV $205
line 355
;354:		}
;355:		else if (keyareamatch.subtype & ST_MORE) {
ADDRLP4 264+260
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $186
line 356
;356:			trap_BotMatchVariable(&keyareamatch, MORE, keyarea, MAX_MESSAGE_SIZE);
ADDRLP4 264
ARGP4
CNSTI4 6
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 357
;357:		}
line 358
;358:		else {
line 359
;359:			break;
LABELV $209
line 361
;360:		}
;361:	}
LABELV $185
line 316
ADDRGP4 $184
JUMPV
LABELV $186
line 363
;362:	//
;363:	if (!newpatrolpoints || !newpatrolpoints->next) {
ADDRLP4 592
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $213
ADDRLP4 592
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $211
LABELV $213
line 364
;364:		trap_EA_SayTeam(bs->client, "I need more key points to patrol\n");
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 $214
ARGP4
ADDRGP4 trap_EA_SayTeam
CALLV
pop
line 365
;365:		BotFreeWaypoints(newpatrolpoints);
ADDRLP4 592
INDIRP4
ARGP4
ADDRGP4 BotFreeWaypoints
CALLV
pop
line 366
;366:		newpatrolpoints = NULL;
ADDRLP4 592
CNSTP4 0
ASGNP4
line 367
;367:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $183
JUMPV
LABELV $211
line 370
;368:	}
;369:	//
;370:	BotFreeWaypoints(bs->patrolpoints);
ADDRFP4 0
INDIRP4
CNSTI4 14408
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotFreeWaypoints
CALLV
pop
line 371
;371:	bs->patrolpoints = newpatrolpoints;
ADDRFP4 0
INDIRP4
CNSTI4 14408
ADDP4
ADDRLP4 592
INDIRP4
ASGNP4
line 373
;372:	//
;373:	bs->curpatrolpoint = bs->patrolpoints;
ADDRLP4 660
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 660
INDIRP4
CNSTI4 14412
ADDP4
ADDRLP4 660
INDIRP4
CNSTI4 14408
ADDP4
INDIRP4
ASGNP4
line 374
;374:	bs->patrolflags = patrolflags;
ADDRFP4 0
INDIRP4
CNSTI4 14416
ADDP4
ADDRLP4 652
INDIRI4
ASGNI4
line 376
;375:	//
;376:	return qtrue;
CNSTI4 1
RETI4
LABELV $183
endproc BotGetPatrolWaypoints 672 16
export BotAddressedToBot
proc BotAddressedToBot 1572 16
line 384
;377:}
;378:
;379:/*
;380:==================
;381:BotAddressedToBot
;382:==================
;383:*/
;384:int BotAddressedToBot(bot_state_t *bs, bot_match_t *match) {
line 392
;385:	char addressedto[MAX_MESSAGE_SIZE];
;386:	char netname[MAX_MESSAGE_SIZE];
;387:	char name[MAX_MESSAGE_SIZE];
;388:	char botname[128];
;389:	int client;
;390:	bot_match_t addresseematch;
;391:
;392:	trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 840
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 393
;393:	client = ClientOnSameTeamFromName(bs, netname);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 840
ARGP4
ADDRLP4 1228
ADDRGP4 ClientOnSameTeamFromName
CALLI4
ASGNI4
ADDRLP4 1096
ADDRLP4 1228
INDIRI4
ASGNI4
line 394
;394:	if (client < 0) return qfalse;
ADDRLP4 1096
INDIRI4
CNSTI4 0
GEI4 $216
CNSTI4 0
RETI4
ADDRGP4 $215
JUMPV
LABELV $216
line 396
;395:	//if the message is addressed to someone
;396:	if (match->subtype & ST_ADDRESSED) {
ADDRFP4 4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $218
line 397
;397:		trap_BotMatchVariable(match, ADDRESSEE, addressedto, sizeof(addressedto));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 584
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 399
;398:		//the name of this bot
;399:		ClientName(bs->client, botname, 128);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 1100
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 ClientName
CALLP4
pop
ADDRGP4 $221
JUMPV
LABELV $220
line 401
;400:		//
;401:		while(trap_BotFindMatch(addressedto, &addresseematch, MTCONTEXT_ADDRESSEE)) {
line 402
;402:			if (addresseematch.type == MSG_EVERYONE) {
ADDRLP4 0+256
INDIRI4
CNSTI4 101
NEI4 $223
line 403
;403:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $215
JUMPV
LABELV $223
line 405
;404:			}
;405:			else if (addresseematch.type == MSG_MULTIPLENAMES) {
ADDRLP4 0+256
INDIRI4
CNSTI4 102
NEI4 $226
line 406
;406:				trap_BotMatchVariable(&addresseematch, TEAMMATE, name, sizeof(name));
ADDRLP4 0
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 328
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 407
;407:				if (strlen(name)) {
ADDRLP4 328
ARGP4
ADDRLP4 1232
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1232
INDIRI4
CNSTI4 0
EQI4 $229
line 408
;408:					if (stristr(botname, name)) return qtrue;
ADDRLP4 1100
ARGP4
ADDRLP4 328
ARGP4
ADDRLP4 1236
ADDRGP4 stristr
CALLP4
ASGNP4
ADDRLP4 1236
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $231
CNSTI4 1
RETI4
ADDRGP4 $215
JUMPV
LABELV $231
line 409
;409:					if (stristr(bs->subteam, name)) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 12312
ADDP4
ARGP4
ADDRLP4 328
ARGP4
ADDRLP4 1240
ADDRGP4 stristr
CALLP4
ASGNP4
ADDRLP4 1240
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $233
CNSTI4 1
RETI4
ADDRGP4 $215
JUMPV
LABELV $233
line 410
;410:				}
LABELV $229
line 411
;411:				trap_BotMatchVariable(&addresseematch, MORE, addressedto, MAX_MESSAGE_SIZE);
ADDRLP4 0
ARGP4
CNSTI4 6
ARGI4
ADDRLP4 584
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 412
;412:			}
ADDRGP4 $227
JUMPV
LABELV $226
line 413
;413:			else {
line 414
;414:				trap_BotMatchVariable(&addresseematch, TEAMMATE, name, MAX_MESSAGE_SIZE);
ADDRLP4 0
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 328
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 415
;415:				if (strlen(name)) {
ADDRLP4 328
ARGP4
ADDRLP4 1232
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1232
INDIRI4
CNSTI4 0
EQI4 $222
line 416
;416:					if (stristr(botname, name)) return qtrue;
ADDRLP4 1100
ARGP4
ADDRLP4 328
ARGP4
ADDRLP4 1236
ADDRGP4 stristr
CALLP4
ASGNP4
ADDRLP4 1236
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $237
CNSTI4 1
RETI4
ADDRGP4 $215
JUMPV
LABELV $237
line 417
;417:					if (stristr(bs->subteam, name)) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 12312
ADDP4
ARGP4
ADDRLP4 328
ARGP4
ADDRLP4 1240
ADDRGP4 stristr
CALLP4
ASGNP4
ADDRLP4 1240
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $222
CNSTI4 1
RETI4
ADDRGP4 $215
JUMPV
line 418
;418:				}
line 419
;419:				break;
LABELV $227
line 421
;420:			}
;421:		}
LABELV $221
line 401
ADDRLP4 584
ARGP4
ADDRLP4 0
ARGP4
CNSTU4 32
ARGU4
ADDRLP4 1232
ADDRGP4 trap_BotFindMatch
CALLI4
ASGNI4
ADDRLP4 1232
INDIRI4
CNSTI4 0
NEI4 $220
LABELV $222
line 424
;422:		//Com_sprintf(buf, sizeof(buf), "not addressed to me but %s", addressedto);
;423:		//trap_EA_Say(bs->client, buf);
;424:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $215
JUMPV
LABELV $218
line 426
;425:	}
;426:	else {
line 429
;427:		bot_match_t tellmatch;
;428:
;429:		tellmatch.type = 0;
ADDRLP4 1232+256
CNSTI4 0
ASGNI4
line 431
;430:		//if this message wasn't directed solely to this bot
;431:		if (!trap_BotFindMatch(match->string, &tellmatch, MTCONTEXT_REPLYCHAT) ||
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1232
ARGP4
CNSTU4 128
ARGU4
ADDRLP4 1560
ADDRGP4 trap_BotFindMatch
CALLI4
ASGNI4
ADDRLP4 1560
INDIRI4
CNSTI4 0
EQI4 $245
ADDRLP4 1232+256
INDIRI4
CNSTI4 202
EQI4 $242
LABELV $245
line 432
;432:				tellmatch.type != MSG_CHATTELL) {
line 434
;433:			//make sure not everyone reacts to this message
;434:			if (random() > (float ) 1.0 / (NumPlayersOnSameTeam(bs)-1)) return qfalse;
ADDRLP4 1564
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1568
ADDRGP4 NumPlayersOnSameTeam
CALLI4
ASGNI4
ADDRLP4 1564
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 1564
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1065353216
ADDRLP4 1568
INDIRI4
CNSTI4 1
SUBI4
CVIF4 4
DIVF4
LEF4 $246
CNSTI4 0
RETI4
ADDRGP4 $215
JUMPV
LABELV $246
line 435
;435:		}
LABELV $242
line 436
;436:	}
line 437
;437:	return qtrue;
CNSTI4 1
RETI4
LABELV $215
endproc BotAddressedToBot 1572 16
export BotGPSToPosition
proc BotGPSToPosition 20 12
line 445
;438:}
;439:
;440:/*
;441:==================
;442:BotGPSToPosition
;443:==================
;444:*/
;445:int BotGPSToPosition(char *buf, vec3_t position) {
line 446
;446:	int i, j = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 449
;447:	int num, sign;
;448:
;449:	for (i = 0; i < 3; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $249
line 450
;450:		num = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $254
JUMPV
LABELV $253
line 451
;451:		while(buf[j] == ' ') j++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $254
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 32
EQI4 $253
line 452
;452:		if (buf[j] == '-') {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 45
NEI4 $256
line 453
;453:			j++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 454
;454:			sign = -1;
ADDRLP4 12
CNSTI4 -1
ASGNI4
line 455
;455:		}
ADDRGP4 $259
JUMPV
LABELV $256
line 456
;456:		else {
line 457
;457:			sign = 1;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 458
;458:		}
ADDRGP4 $259
JUMPV
LABELV $258
line 459
;459:		while (buf[j]) {
line 460
;460:			if (buf[j] >= '0' && buf[j] <= '9') {
ADDRLP4 16
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 48
LTI4 $261
ADDRLP4 16
INDIRI4
CNSTI4 57
GTI4 $261
line 461
;461:				num = num * 10 + buf[j] - '0';
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 10
MULI4
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ADDI4
CNSTI4 48
SUBI4
ASGNI4
line 462
;462:				j++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 463
;463:			}
ADDRGP4 $262
JUMPV
LABELV $261
line 464
;464:			else {
line 465
;465:				j++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 466
;466:				break;
ADDRGP4 $260
JUMPV
LABELV $262
line 468
;467:			}
;468:		}
LABELV $259
line 459
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $258
LABELV $260
line 469
;469:		BotAI_Print(PRT_MESSAGE, "%d\n", sign * num);
CNSTI4 1
ARGI4
ADDRGP4 $263
ARGP4
ADDRLP4 12
INDIRI4
ADDRLP4 4
INDIRI4
MULI4
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 470
;470:		position[i] = (float) sign * num;
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
ADDRLP4 12
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 471
;471:	}
LABELV $250
line 449
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 3
LTI4 $249
line 472
;472:	return qtrue;
CNSTI4 1
RETI4
LABELV $248
endproc BotGPSToPosition 20 12
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
import BotMayNBGBeAvailable
import BotMayLTGItemBeReachable
import BotRememberLTGItemUnreachable
import BotDumpNodeSwitches
import BotResetNodeSwitches
import AINode_Battle_NBG
import AINode_Battle_Retreat
import AINode_Battle_Chase
import AINode_Battle_Fight
import AINode_Seek_LTG
import AINode_Seek_NBG
import AINode_Seek_ActivateEntity
import AINode_Stand
import AINode_Respawn
import AINode_Observer
import AINode_Intermission
import AIEnter_Battle_NBG
import AIEnter_Battle_Retreat
import AIEnter_Battle_Chase
import AIEnter_Battle_Fight
import AIEnter_Seek_Camp
import AIEnter_Seek_LTG
import AIEnter_Seek_NBG
import AIEnter_Seek_ActivateEntity
import AIEnter_Stand
import AIEnter_Respawn
import AIEnter_Observer
import AIEnter_Intermission
import BotPrintTeamGoal
import BotMatchMessage
bss
export notleader
align 4
LABELV notleader
skip 256
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
LABELV $263
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $214
byte 1 73
byte 1 32
byte 1 110
byte 1 101
byte 1 101
byte 1 100
byte 1 32
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 32
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 112
byte 1 97
byte 1 116
byte 1 114
byte 1 111
byte 1 108
byte 1 10
byte 1 0
align 1
LABELV $189
byte 1 119
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 100
byte 1 111
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 32
byte 1 115
byte 1 97
byte 1 121
byte 1 63
byte 1 0
align 1
LABELV $133
byte 1 115
byte 1 118
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
