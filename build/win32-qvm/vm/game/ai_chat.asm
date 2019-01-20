bss
align 4
LABELV $93
skip 4
export BotNumActivePlayers
code
proc BotNumActivePlayers 1056 12
file "..\..\..\..\code\game\ai_chat.c"
line 48
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:
;4:/*****************************************************************************
;5: * name:		ai_chat.c
;6: *
;7: * desc:		Quake3 bot AI
;8: *
;9: * $Archive: /MissionPack/code/game/ai_chat.c $
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
;29://
;30:#include "chars.h"				//characteristics
;31:#include "inv.h"				//indexes into the inventory
;32:#include "syn.h"				//synonyms
;33:#include "match.h"				//string matching types and vars
;34:
;35:// for the voice chats
;36:#ifdef MISSIONPACK // bk001205
;37:#include "../../ui/menudef.h"
;38:#endif
;39:
;40:#define TIME_BETWEENCHATTING	25
;41:
;42:
;43:/*
;44:==================
;45:BotNumActivePlayers
;46:==================
;47:*/
;48:int BotNumActivePlayers(void) {
line 53
;49:	int i, num;
;50:	char buf[MAX_INFO_STRING];
;51:	static int maxclients;
;52:
;53:	if (!maxclients)
ADDRGP4 $93
INDIRI4
CNSTI4 0
NEI4 $94
line 54
;54:		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
ADDRGP4 $96
ARGP4
ADDRLP4 1032
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 $93
ADDRLP4 1032
INDIRI4
ASGNI4
LABELV $94
line 56
;55:
;56:	num = 0;
ADDRLP4 1028
CNSTI4 0
ASGNI4
line 57
;57:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 1024
CNSTI4 0
ASGNI4
ADDRGP4 $100
JUMPV
LABELV $97
line 58
;58:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
ADDRLP4 1024
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 60
;59:		//if no config string or no name
;60:		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n"))) continue;
ADDRLP4 0
ARGP4
ADDRLP4 1036
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
EQI4 $104
ADDRLP4 0
ARGP4
ADDRGP4 $103
ARGP4
ADDRLP4 1040
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 1044
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $101
LABELV $104
ADDRGP4 $98
JUMPV
LABELV $101
line 62
;61:		//skip spectators
;62:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) continue;
ADDRLP4 0
ARGP4
ADDRGP4 $107
ARGP4
ADDRLP4 1048
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1048
INDIRP4
ARGP4
ADDRLP4 1052
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 3
NEI4 $105
ADDRGP4 $98
JUMPV
LABELV $105
line 64
;63:		//
;64:		num++;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 65
;65:	}
LABELV $98
line 57
ADDRLP4 1024
ADDRLP4 1024
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $100
ADDRLP4 1024
INDIRI4
ADDRGP4 $93
INDIRI4
GEI4 $108
ADDRLP4 1024
INDIRI4
CNSTI4 64
LTI4 $97
LABELV $108
line 66
;66:	return num;
ADDRLP4 1028
INDIRI4
RETI4
LABELV $92
endproc BotNumActivePlayers 1056 12
bss
align 4
LABELV $110
skip 4
export BotIsFirstInRankings
code
proc BotIsFirstInRankings 1524 12
line 74
;67:}
;68:
;69:/*
;70:==================
;71:BotIsFirstInRankings
;72:==================
;73:*/
;74:int BotIsFirstInRankings(bot_state_t *bs) {
line 80
;75:	int i, score;
;76:	char buf[MAX_INFO_STRING];
;77:	static int maxclients;
;78:	playerState_t ps;
;79:
;80:	if (!maxclients)
ADDRGP4 $110
INDIRI4
CNSTI4 0
NEI4 $111
line 81
;81:		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
ADDRGP4 $96
ARGP4
ADDRLP4 1500
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 $110
ADDRLP4 1500
INDIRI4
ASGNI4
LABELV $111
line 83
;82:
;83:	score = bs->cur_ps.persistant[PERS_SCORE];
ADDRLP4 1496
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRI4
ASGNI4
line 84
;84:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $116
JUMPV
LABELV $113
line 85
;85:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
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
line 87
;86:		//if no config string or no name
;87:		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n"))) continue;
ADDRLP4 4
ARGP4
ADDRLP4 1504
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1504
INDIRI4
CNSTI4 0
EQI4 $119
ADDRLP4 4
ARGP4
ADDRGP4 $103
ARGP4
ADDRLP4 1508
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1508
INDIRP4
ARGP4
ADDRLP4 1512
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1512
INDIRI4
CNSTI4 0
NEI4 $117
LABELV $119
ADDRGP4 $114
JUMPV
LABELV $117
line 89
;88:		//skip spectators
;89:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) continue;
ADDRLP4 4
ARGP4
ADDRGP4 $107
ARGP4
ADDRLP4 1516
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1516
INDIRP4
ARGP4
ADDRLP4 1520
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1520
INDIRI4
CNSTI4 3
NEI4 $120
ADDRGP4 $114
JUMPV
LABELV $120
line 91
;90:		//
;91:		BotAI_GetClientState(i, &ps);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1028
ARGP4
ADDRGP4 BotAI_GetClientState
CALLI4
pop
line 92
;92:		if (score < ps.persistant[PERS_SCORE]) return qfalse;
ADDRLP4 1496
INDIRI4
ADDRLP4 1028+248
INDIRI4
GEI4 $122
CNSTI4 0
RETI4
ADDRGP4 $109
JUMPV
LABELV $122
line 93
;93:	}
LABELV $114
line 84
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $116
ADDRLP4 0
INDIRI4
ADDRGP4 $110
INDIRI4
GEI4 $125
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $113
LABELV $125
line 94
;94:	return qtrue;
CNSTI4 1
RETI4
LABELV $109
endproc BotIsFirstInRankings 1524 12
bss
align 4
LABELV $127
skip 4
export BotIsLastInRankings
code
proc BotIsLastInRankings 1524 12
line 102
;95:}
;96:
;97:/*
;98:==================
;99:BotIsLastInRankings
;100:==================
;101:*/
;102:int BotIsLastInRankings(bot_state_t *bs) {
line 108
;103:	int i, score;
;104:	char buf[MAX_INFO_STRING];
;105:	static int maxclients;
;106:	playerState_t ps;
;107:
;108:	if (!maxclients)
ADDRGP4 $127
INDIRI4
CNSTI4 0
NEI4 $128
line 109
;109:		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
ADDRGP4 $96
ARGP4
ADDRLP4 1500
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 $127
ADDRLP4 1500
INDIRI4
ASGNI4
LABELV $128
line 111
;110:
;111:	score = bs->cur_ps.persistant[PERS_SCORE];
ADDRLP4 1496
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRI4
ASGNI4
line 112
;112:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $133
JUMPV
LABELV $130
line 113
;113:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
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
line 115
;114:		//if no config string or no name
;115:		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n"))) continue;
ADDRLP4 4
ARGP4
ADDRLP4 1504
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1504
INDIRI4
CNSTI4 0
EQI4 $136
ADDRLP4 4
ARGP4
ADDRGP4 $103
ARGP4
ADDRLP4 1508
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1508
INDIRP4
ARGP4
ADDRLP4 1512
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1512
INDIRI4
CNSTI4 0
NEI4 $134
LABELV $136
ADDRGP4 $131
JUMPV
LABELV $134
line 117
;116:		//skip spectators
;117:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) continue;
ADDRLP4 4
ARGP4
ADDRGP4 $107
ARGP4
ADDRLP4 1516
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1516
INDIRP4
ARGP4
ADDRLP4 1520
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1520
INDIRI4
CNSTI4 3
NEI4 $137
ADDRGP4 $131
JUMPV
LABELV $137
line 119
;118:		//
;119:		BotAI_GetClientState(i, &ps);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1028
ARGP4
ADDRGP4 BotAI_GetClientState
CALLI4
pop
line 120
;120:		if (score > ps.persistant[PERS_SCORE]) return qfalse;
ADDRLP4 1496
INDIRI4
ADDRLP4 1028+248
INDIRI4
LEI4 $139
CNSTI4 0
RETI4
ADDRGP4 $126
JUMPV
LABELV $139
line 121
;121:	}
LABELV $131
line 112
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $133
ADDRLP4 0
INDIRI4
ADDRGP4 $127
INDIRI4
GEI4 $142
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $130
LABELV $142
line 122
;122:	return qtrue;
CNSTI4 1
RETI4
LABELV $126
endproc BotIsLastInRankings 1524 12
bss
align 1
LABELV $144
skip 32
align 4
LABELV $145
skip 4
export BotFirstClientInRankings
code
proc BotFirstClientInRankings 1528 12
line 130
;123:}
;124:
;125:/*
;126:==================
;127:BotFirstClientInRankings
;128:==================
;129:*/
;130:char *BotFirstClientInRankings(void) {
line 137
;131:	int i, bestscore, bestclient;
;132:	char buf[MAX_INFO_STRING];
;133:	static char name[32];
;134:	static int maxclients;
;135:	playerState_t ps;
;136:
;137:	if (!maxclients)
ADDRGP4 $145
INDIRI4
CNSTI4 0
NEI4 $146
line 138
;138:		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
ADDRGP4 $96
ARGP4
ADDRLP4 1504
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 $145
ADDRLP4 1504
INDIRI4
ASGNI4
LABELV $146
line 140
;139:
;140:	bestscore = -999999;
ADDRLP4 1496
CNSTI4 -999999
ASGNI4
line 141
;141:	bestclient = 0;
ADDRLP4 1500
CNSTI4 0
ASGNI4
line 142
;142:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $151
JUMPV
LABELV $148
line 143
;143:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
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
line 145
;144:		//if no config string or no name
;145:		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n"))) continue;
ADDRLP4 4
ARGP4
ADDRLP4 1508
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1508
INDIRI4
CNSTI4 0
EQI4 $154
ADDRLP4 4
ARGP4
ADDRGP4 $103
ARGP4
ADDRLP4 1512
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1512
INDIRP4
ARGP4
ADDRLP4 1516
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1516
INDIRI4
CNSTI4 0
NEI4 $152
LABELV $154
ADDRGP4 $149
JUMPV
LABELV $152
line 147
;146:		//skip spectators
;147:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) continue;
ADDRLP4 4
ARGP4
ADDRGP4 $107
ARGP4
ADDRLP4 1520
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1520
INDIRP4
ARGP4
ADDRLP4 1524
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1524
INDIRI4
CNSTI4 3
NEI4 $155
ADDRGP4 $149
JUMPV
LABELV $155
line 149
;148:		//
;149:		BotAI_GetClientState(i, &ps);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1028
ARGP4
ADDRGP4 BotAI_GetClientState
CALLI4
pop
line 150
;150:		if (ps.persistant[PERS_SCORE] > bestscore) {
ADDRLP4 1028+248
INDIRI4
ADDRLP4 1496
INDIRI4
LEI4 $157
line 151
;151:			bestscore = ps.persistant[PERS_SCORE];
ADDRLP4 1496
ADDRLP4 1028+248
INDIRI4
ASGNI4
line 152
;152:			bestclient = i;
ADDRLP4 1500
ADDRLP4 0
INDIRI4
ASGNI4
line 153
;153:		}
LABELV $157
line 154
;154:	}
LABELV $149
line 142
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $151
ADDRLP4 0
INDIRI4
ADDRGP4 $145
INDIRI4
GEI4 $161
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $148
LABELV $161
line 155
;155:	EasyClientName(bestclient, name, 32);
ADDRLP4 1500
INDIRI4
ARGI4
ADDRGP4 $144
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 156
;156:	return name;
ADDRGP4 $144
RETP4
LABELV $143
endproc BotFirstClientInRankings 1528 12
bss
align 1
LABELV $163
skip 32
align 4
LABELV $164
skip 4
export BotLastClientInRankings
code
proc BotLastClientInRankings 1528 12
line 164
;157:}
;158:
;159:/*
;160:==================
;161:BotLastClientInRankings
;162:==================
;163:*/
;164:char *BotLastClientInRankings(void) {
line 171
;165:	int i, worstscore, bestclient;
;166:	char buf[MAX_INFO_STRING];
;167:	static char name[32];
;168:	static int maxclients;
;169:	playerState_t ps;
;170:
;171:	if (!maxclients)
ADDRGP4 $164
INDIRI4
CNSTI4 0
NEI4 $165
line 172
;172:		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
ADDRGP4 $96
ARGP4
ADDRLP4 1504
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 $164
ADDRLP4 1504
INDIRI4
ASGNI4
LABELV $165
line 174
;173:
;174:	worstscore = 999999;
ADDRLP4 1496
CNSTI4 999999
ASGNI4
line 175
;175:	bestclient = 0;
ADDRLP4 1500
CNSTI4 0
ASGNI4
line 176
;176:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $170
JUMPV
LABELV $167
line 177
;177:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
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
line 179
;178:		//if no config string or no name
;179:		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n"))) continue;
ADDRLP4 4
ARGP4
ADDRLP4 1508
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1508
INDIRI4
CNSTI4 0
EQI4 $173
ADDRLP4 4
ARGP4
ADDRGP4 $103
ARGP4
ADDRLP4 1512
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1512
INDIRP4
ARGP4
ADDRLP4 1516
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1516
INDIRI4
CNSTI4 0
NEI4 $171
LABELV $173
ADDRGP4 $168
JUMPV
LABELV $171
line 181
;180:		//skip spectators
;181:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) continue;
ADDRLP4 4
ARGP4
ADDRGP4 $107
ARGP4
ADDRLP4 1520
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1520
INDIRP4
ARGP4
ADDRLP4 1524
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1524
INDIRI4
CNSTI4 3
NEI4 $174
ADDRGP4 $168
JUMPV
LABELV $174
line 183
;182:		//
;183:		BotAI_GetClientState(i, &ps);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1028
ARGP4
ADDRGP4 BotAI_GetClientState
CALLI4
pop
line 184
;184:		if (ps.persistant[PERS_SCORE] < worstscore) {
ADDRLP4 1028+248
INDIRI4
ADDRLP4 1496
INDIRI4
GEI4 $176
line 185
;185:			worstscore = ps.persistant[PERS_SCORE];
ADDRLP4 1496
ADDRLP4 1028+248
INDIRI4
ASGNI4
line 186
;186:			bestclient = i;
ADDRLP4 1500
ADDRLP4 0
INDIRI4
ASGNI4
line 187
;187:		}
LABELV $176
line 188
;188:	}
LABELV $168
line 176
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $170
ADDRLP4 0
INDIRI4
ADDRGP4 $164
INDIRI4
GEI4 $180
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $167
LABELV $180
line 189
;189:	EasyClientName(bestclient, name, 32);
ADDRLP4 1500
INDIRI4
ARGI4
ADDRGP4 $163
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 190
;190:	return name;
ADDRGP4 $163
RETP4
LABELV $162
endproc BotLastClientInRankings 1528 12
bss
align 4
LABELV $182
skip 4
align 1
LABELV $183
skip 32
export BotRandomOpponentName
code
proc BotRandomOpponentName 1320 12
line 198
;191:}
;192:
;193:/*
;194:==================
;195:BotRandomOpponentName
;196:==================
;197:*/
;198:char *BotRandomOpponentName(bot_state_t *bs) {
line 205
;199:	int i, count;
;200:	char buf[MAX_INFO_STRING];
;201:	int opponents[MAX_CLIENTS], numopponents;
;202:	static int maxclients;
;203:	static char name[32];
;204:
;205:	if (!maxclients)
ADDRGP4 $182
INDIRI4
CNSTI4 0
NEI4 $184
line 206
;206:		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
ADDRGP4 $96
ARGP4
ADDRLP4 1292
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 $182
ADDRLP4 1292
INDIRI4
ASGNI4
LABELV $184
line 208
;207:
;208:	numopponents = 0;
ADDRLP4 1028
CNSTI4 0
ASGNI4
line 209
;209:	opponents[0] = 0;
ADDRLP4 1036
CNSTI4 0
ASGNI4
line 210
;210:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $189
JUMPV
LABELV $186
line 211
;211:		if (i == bs->client) continue;
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $190
ADDRGP4 $187
JUMPV
LABELV $190
line 213
;212:		//
;213:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
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
line 215
;214:		//if no config string or no name
;215:		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n"))) continue;
ADDRLP4 4
ARGP4
ADDRLP4 1296
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1296
INDIRI4
CNSTI4 0
EQI4 $194
ADDRLP4 4
ARGP4
ADDRGP4 $103
ARGP4
ADDRLP4 1300
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1300
INDIRP4
ARGP4
ADDRLP4 1304
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1304
INDIRI4
CNSTI4 0
NEI4 $192
LABELV $194
ADDRGP4 $187
JUMPV
LABELV $192
line 217
;216:		//skip spectators
;217:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) continue;
ADDRLP4 4
ARGP4
ADDRGP4 $107
ARGP4
ADDRLP4 1308
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1308
INDIRP4
ARGP4
ADDRLP4 1312
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1312
INDIRI4
CNSTI4 3
NEI4 $195
ADDRGP4 $187
JUMPV
LABELV $195
line 219
;218:		//skip team mates
;219:		if (BotSameTeam(bs, i)) continue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1316
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1316
INDIRI4
CNSTI4 0
EQI4 $197
ADDRGP4 $187
JUMPV
LABELV $197
line 221
;220:		//
;221:		opponents[numopponents] = i;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1036
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 222
;222:		numopponents++;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 223
;223:	}
LABELV $187
line 210
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $189
ADDRLP4 0
INDIRI4
ADDRGP4 $182
INDIRI4
GEI4 $199
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $186
LABELV $199
line 224
;224:	count = random() * numopponents;
ADDRLP4 1300
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 1032
ADDRLP4 1300
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 1300
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
ADDRLP4 1028
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ASGNI4
line 225
;225:	for (i = 0; i < numopponents; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $203
JUMPV
LABELV $200
line 226
;226:		count--;
ADDRLP4 1032
ADDRLP4 1032
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 227
;227:		if (count <= 0) {
ADDRLP4 1032
INDIRI4
CNSTI4 0
GTI4 $204
line 228
;228:			EasyClientName(opponents[i], name, sizeof(name));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1036
ADDP4
INDIRI4
ARGI4
ADDRGP4 $183
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 229
;229:			return name;
ADDRGP4 $183
RETP4
ADDRGP4 $181
JUMPV
LABELV $204
line 231
;230:		}
;231:	}
LABELV $201
line 225
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $203
ADDRLP4 0
INDIRI4
ADDRLP4 1028
INDIRI4
LTI4 $200
line 232
;232:	EasyClientName(opponents[0], name, sizeof(name));
ADDRLP4 1036
INDIRI4
ARGI4
ADDRGP4 $183
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 233
;233:	return name;
ADDRGP4 $183
RETP4
LABELV $181
endproc BotRandomOpponentName 1320 12
bss
align 1
LABELV $207
skip 128
export BotMapTitle
code
proc BotMapTitle 1028 12
line 242
;234:}
;235:
;236:/*
;237:==================
;238:BotMapTitle
;239:==================
;240:*/
;241:
;242:char *BotMapTitle(void) {
line 246
;243:	char info[1024];
;244:	static char mapname[128];
;245:
;246:	trap_GetServerinfo(info, sizeof(info));
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetServerinfo
CALLV
pop
line 248
;247:
;248:	strncpy(mapname, Info_ValueForKey( info, "mapname" ), sizeof(mapname)-1);
ADDRLP4 0
ARGP4
ADDRGP4 $208
ARGP4
ADDRLP4 1024
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $207
ARGP4
ADDRLP4 1024
INDIRP4
ARGP4
CNSTI4 127
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 249
;249:	mapname[sizeof(mapname)-1] = '\0';
ADDRGP4 $207+127
CNSTI1 0
ASGNI1
line 251
;250:
;251:	return mapname;
ADDRGP4 $207
RETP4
LABELV $206
endproc BotMapTitle 1028 12
export BotWeaponNameForMeansOfDeath
proc BotWeaponNameForMeansOfDeath 4 0
line 261
;252:}
;253:
;254:
;255:/*
;256:==================
;257:BotWeaponNameForMeansOfDeath
;258:==================
;259:*/
;260:
;261:char *BotWeaponNameForMeansOfDeath(int mod) {
line 262
;262:	switch(mod) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
LTI4 $211
ADDRLP4 0
INDIRI4
CNSTI4 28
GTI4 $211
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $243-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $243
address $213
address $215
address $233
address $235
address $237
address $239
address $241
address $217
address $219
address $219
address $221
address $221
address $223
address $223
address $225
address $227
address $229
address $229
address $211
address $211
address $211
address $211
address $211
address $211
address $211
address $211
address $211
address $231
code
LABELV $213
line 263
;263:		case MOD_SHOTGUN: return "Shotgun";
ADDRGP4 $214
RETP4
ADDRGP4 $210
JUMPV
LABELV $215
line 264
;264:		case MOD_GAUNTLET: return "Gauntlet";
ADDRGP4 $216
RETP4
ADDRGP4 $210
JUMPV
LABELV $217
line 265
;265:		case MOD_MACHINEGUN: return "Machinegun";
ADDRGP4 $218
RETP4
ADDRGP4 $210
JUMPV
LABELV $219
line 267
;266:		case MOD_GRENADE:
;267:		case MOD_GRENADE_SPLASH: return "Grenade Launcher";
ADDRGP4 $220
RETP4
ADDRGP4 $210
JUMPV
LABELV $221
line 269
;268:		case MOD_ROCKET:
;269:		case MOD_ROCKET_SPLASH: return "Rocket Launcher";
ADDRGP4 $222
RETP4
ADDRGP4 $210
JUMPV
LABELV $223
line 271
;270:		case MOD_PLASMA:
;271:		case MOD_PLASMA_SPLASH: return "Plasmagun";
ADDRGP4 $224
RETP4
ADDRGP4 $210
JUMPV
LABELV $225
line 272
;272:		case MOD_RAILGUN: return "Railgun";
ADDRGP4 $226
RETP4
ADDRGP4 $210
JUMPV
LABELV $227
line 273
;273:		case MOD_LIGHTNING: return "Lightning Gun";
ADDRGP4 $228
RETP4
ADDRGP4 $210
JUMPV
LABELV $229
line 275
;274:		case MOD_BFG:
;275:		case MOD_BFG_SPLASH: return "BFG10K";
ADDRGP4 $230
RETP4
ADDRGP4 $210
JUMPV
LABELV $231
line 283
;276:#ifdef MISSIONPACK
;277:		case MOD_NAIL: return "Nailgun";
;278:		case MOD_CHAINGUN: return "Chaingun";
;279:		case MOD_PROXIMITY_MINE: return "Proximity Launcher";
;280:		case MOD_KAMIKAZE: return "Kamikaze";
;281:		case MOD_JUICED: return "Prox mine";
;282:#endif
;283:		case MOD_GRAPPLE: return "Grapple";
ADDRGP4 $232
RETP4
ADDRGP4 $210
JUMPV
LABELV $233
line 285
;284:#if MONSTER_MODE
;285:		case MOD_CLAW: return "claw";	// JUHOX
ADDRGP4 $234
RETP4
ADDRGP4 $210
JUMPV
LABELV $235
line 286
;286:		case MOD_GUARD: return "Fireball Launcher";	// JUHOX
ADDRGP4 $236
RETP4
ADDRGP4 $210
JUMPV
LABELV $237
line 287
;287:		case MOD_TITAN: return "fist";	// JUHOX
ADDRGP4 $238
RETP4
ADDRGP4 $210
JUMPV
LABELV $239
line 288
;288:		case MOD_MONSTER_LAUNCHER: return "Monster Launcher";	// JUHOX
ADDRGP4 $240
RETP4
ADDRGP4 $210
JUMPV
LABELV $241
line 290
;289:#endif
;290:		case MOD_CHARGE: return "Lightning Gun";	// JUHOX
ADDRGP4 $228
RETP4
ADDRGP4 $210
JUMPV
LABELV $211
line 291
;291:		default: return "[unknown weapon]";
ADDRGP4 $242
RETP4
LABELV $210
endproc BotWeaponNameForMeansOfDeath 4 0
export BotRandomWeaponName
proc BotRandomWeaponName 12 0
line 300
;292:	}
;293:}
;294:
;295:/*
;296:==================
;297:BotRandomWeaponName
;298:==================
;299:*/
;300:char *BotRandomWeaponName(void) {
line 306
;301:	int rnd;
;302:
;303:#ifdef MISSIONPACK
;304:	rnd = random() * 11.9;
;305:#else
;306:	rnd = random() * 8.9;
ADDRLP4 4
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 0
ADDRLP4 4
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 4
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 823027302
MULF4
CVFI4 4
ASGNI4
line 308
;307:#endif
;308:	switch(rnd) {
ADDRLP4 8
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $246
ADDRLP4 8
INDIRI4
CNSTI4 7
GTI4 $246
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $256
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $256
address $248
address $249
address $250
address $251
address $252
address $253
address $254
address $255
code
LABELV $248
line 309
;309:		case 0: return "Gauntlet";
ADDRGP4 $216
RETP4
ADDRGP4 $245
JUMPV
LABELV $249
line 310
;310:		case 1: return "Shotgun";
ADDRGP4 $214
RETP4
ADDRGP4 $245
JUMPV
LABELV $250
line 311
;311:		case 2: return "Machinegun";
ADDRGP4 $218
RETP4
ADDRGP4 $245
JUMPV
LABELV $251
line 312
;312:		case 3: return "Grenade Launcher";
ADDRGP4 $220
RETP4
ADDRGP4 $245
JUMPV
LABELV $252
line 313
;313:		case 4: return "Rocket Launcher";
ADDRGP4 $222
RETP4
ADDRGP4 $245
JUMPV
LABELV $253
line 314
;314:		case 5: return "Plasmagun";
ADDRGP4 $224
RETP4
ADDRGP4 $245
JUMPV
LABELV $254
line 315
;315:		case 6: return "Railgun";
ADDRGP4 $226
RETP4
ADDRGP4 $245
JUMPV
LABELV $255
line 316
;316:		case 7: return "Lightning Gun";
ADDRGP4 $228
RETP4
ADDRGP4 $245
JUMPV
LABELV $246
line 322
;317:#ifdef MISSIONPACK
;318:		case 8: return "Nailgun";
;319:		case 9: return "Chaingun";
;320:		case 10: return "Proximity Launcher";
;321:#endif
;322:		default: return "BFG10K";
ADDRGP4 $230
RETP4
LABELV $245
endproc BotRandomWeaponName 12 0
export BotVisibleEnemies
proc BotVisibleEnemies 168 12
line 331
;323:	}
;324:}
;325:
;326:/*
;327:==================
;328:BotVisibleEnemies
;329:==================
;330:*/
;331:int BotVisibleEnemies(bot_state_t *bs) {
line 338
;332:	float vis;
;333:	int i;
;334:	aas_entityinfo_t entinfo;
;335:
;336:	// JUHOX: don't chat if the enemy is a monster
;337:#if MONSTER_MODE
;338:	if (bs->enemy >= MAX_CLIENTS) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 64
LTI4 $258
CNSTI4 1
RETI4
ADDRGP4 $257
JUMPV
LABELV $258
line 340
;339:#endif
;340:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $260
line 342
;341:
;342:		if (i == bs->client) continue;
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $264
ADDRGP4 $261
JUMPV
LABELV $264
line 344
;343:		//
;344:		BotEntityInfo(i, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 346
;345:		//
;346:		if (!entinfo.valid) continue;
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $266
ADDRGP4 $261
JUMPV
LABELV $266
line 348
;347:		//if the enemy isn't dead and the enemy isn't the bot self
;348:		if (EntityIsDead(&entinfo) || entinfo.number == bs->entitynum) continue;
ADDRLP4 4
ARGP4
ADDRLP4 148
ADDRGP4 EntityIsDead
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $271
ADDRLP4 4+20
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
NEI4 $268
LABELV $271
ADDRGP4 $261
JUMPV
LABELV $268
line 350
;349:		//if the enemy is invisible and not shooting
;350:		if (EntityIsInvisible(VIEWER_OTHERTEAM, &entinfo) && !EntityIsShooting(&entinfo)) {	// JUHOX: added 'VIEWER_OTHERTEAM'
CNSTI4 -2
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 152
ADDRGP4 EntityIsInvisible
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
EQI4 $272
ADDRLP4 4
ARGP4
ADDRLP4 156
ADDRGP4 EntityIsShooting
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
NEI4 $272
line 351
;351:			continue;
ADDRGP4 $261
JUMPV
LABELV $272
line 354
;352:		}
;353:		//if on the same team
;354:		if (BotSameTeam(bs, i)) continue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 160
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 0
EQI4 $274
ADDRGP4 $261
JUMPV
LABELV $274
line 356
;355:		//check if the enemy is visible
;356:		vis = BotEntityVisible(&bs->cur_ps/*bs->entitynum, bs->eye, bs->viewangles*/, 360, i);	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 164
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 144
ADDRLP4 164
INDIRF4
ASGNF4
line 357
;357:		if (vis > 0) return qtrue;
ADDRLP4 144
INDIRF4
CNSTF4 0
LEF4 $276
CNSTI4 1
RETI4
ADDRGP4 $257
JUMPV
LABELV $276
line 358
;358:	}
LABELV $261
line 340
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $260
line 359
;359:	return qfalse;
CNSTI4 0
RETI4
LABELV $257
endproc BotVisibleEnemies 168 12
export BotValidChatPosition
proc BotValidChatPosition 160 28
line 367
;360:}
;361:
;362:/*
;363:==================
;364:BotValidChatPosition
;365:==================
;366:*/
;367:int BotValidChatPosition(bot_state_t *bs) {
line 372
;368:	vec3_t point, start, end, mins, maxs;
;369:	bsp_trace_t trace;
;370:
;371:	//if the bot is dead all positions are valid
;372:	if (BotIsDead(bs)) return qtrue;
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
EQI4 $279
CNSTI4 1
RETI4
ADDRGP4 $278
JUMPV
LABELV $279
line 375
;373:	// JUHOX: don't chat if the enemy is a monster
;374:#if MONSTER_MODE
;375:	if (bs->enemy >= MAX_CLIENTS) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 64
LTI4 $281
CNSTI4 0
RETI4
ADDRGP4 $278
JUMPV
LABELV $281
line 379
;376:#endif
;377:	// JUHOX: don't chat if recently hurt
;378:#if 1
;379:	if (level.clients[bs->client].lasthurt_time > level.time - 3000) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
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
LEI4 $283
CNSTI4 0
RETI4
ADDRGP4 $278
JUMPV
LABELV $283
line 382
;380:#endif
;381:	//never start chatting with a powerup
;382:	if (bs->inventory[INVENTORY_QUAD] ||
ADDRLP4 148
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 148
INDIRP4
CNSTI4 5100
ADDP4
INDIRI4
CNSTI4 0
NEI4 $291
ADDRLP4 148
INDIRP4
CNSTI4 5108
ADDP4
INDIRI4
CNSTI4 0
NEI4 $291
ADDRLP4 148
INDIRP4
CNSTI4 5112
ADDP4
INDIRI4
CNSTI4 0
NEI4 $291
ADDRLP4 148
INDIRP4
CNSTI4 5116
ADDP4
INDIRI4
CNSTI4 0
NEI4 $291
ADDRLP4 148
INDIRP4
CNSTI4 5120
ADDP4
INDIRI4
CNSTI4 0
EQI4 $286
LABELV $291
line 386
;383:		bs->inventory[INVENTORY_HASTE] ||
;384:		bs->inventory[INVENTORY_INVISIBILITY] ||
;385:		bs->inventory[INVENTORY_REGEN] ||
;386:		bs->inventory[INVENTORY_FLIGHT]) return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $278
JUMPV
LABELV $286
line 390
;387:	//must be on the ground
;388:	//if (bs->cur_ps.groundEntityNum != ENTITYNUM_NONE) return qfalse;
;389:	//do not chat if in lava or slime
;390:	VectorCopy(bs->origin, point);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRB
ASGNB 12
line 391
;391:	point[2] -= 24;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1103101952
SUBF4
ASGNF4
line 392
;392:	if (trap_PointContents(point,bs->entitynum) & (CONTENTS_LAVA|CONTENTS_SLIME)) return qfalse;
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 152
ADDRGP4 trap_PointContents
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 24
BANDI4
CNSTI4 0
EQI4 $293
CNSTI4 0
RETI4
ADDRGP4 $278
JUMPV
LABELV $293
line 394
;393:	//do not chat if under water
;394:	VectorCopy(bs->origin, point);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRB
ASGNB 12
line 395
;395:	point[2] += 32;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 396
;396:	if (trap_PointContents(point,bs->entitynum) & MASK_WATER) return qfalse;
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 156
ADDRGP4 trap_PointContents
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $296
CNSTI4 0
RETI4
ADDRGP4 $278
JUMPV
LABELV $296
line 398
;397:	//must be standing on the world entity
;398:	VectorCopy(bs->origin, start);
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRB
ASGNB 12
line 399
;399:	VectorCopy(bs->origin, end);
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRB
ASGNB 12
line 400
;400:	start[2] += 1;
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 401
;401:	end[2] -= 10;
ADDRLP4 24+8
ADDRLP4 24+8
INDIRF4
CNSTF4 1092616192
SUBF4
ASGNF4
line 402
;402:	trap_AAS_PresenceTypeBoundingBox(PRESENCE_CROUCH, mins, maxs);
CNSTI4 4
ARGI4
ADDRLP4 36
ARGP4
ADDRLP4 48
ARGP4
ADDRGP4 trap_AAS_PresenceTypeBoundingBox
CALLV
pop
line 403
;403:	BotAI_Trace(&trace, start, mins, maxs, end, bs->client, MASK_SOLID);
ADDRLP4 60
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 48
ARGP4
ADDRLP4 24
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 404
;404:	if (trace.ent != ENTITYNUM_WORLD) return qfalse;
ADDRLP4 60+80
INDIRI4
CNSTI4 1022
EQI4 $300
CNSTI4 0
RETI4
ADDRGP4 $278
JUMPV
LABELV $300
line 406
;405:	//the bot is in a position where it can chat
;406:	return qtrue;
CNSTI4 1
RETI4
LABELV $278
endproc BotValidChatPosition 160 28
export BotChat_EnterGame
proc BotChat_EnterGame 68 32
line 414
;407:}
;408:
;409:/*
;410:==================
;411:BotChat_EnterGame
;412:==================
;413:*/
;414:int BotChat_EnterGame(bot_state_t *bs) {
line 418
;415:	char name[32];
;416:	float rnd;
;417:
;418:	if (bot_nochat.integer) return qfalse;
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 0
EQI4 $304
CNSTI4 0
RETI4
ADDRGP4 $303
JUMPV
LABELV $304
line 419
;419:	if (bs->lastchat_time > FloatTime() - TIME_BETWEENCHATTING) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 7192
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1103626240
SUBF4
LEF4 $307
CNSTI4 0
RETI4
ADDRGP4 $303
JUMPV
LABELV $307
line 421
;420:	//don't chat in teamplay
;421:	if (TeamPlayIsOn()) return qfalse;
ADDRLP4 36
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $309
CNSTI4 0
RETI4
ADDRGP4 $303
JUMPV
LABELV $309
line 423
;422:	// don't chat in tournament mode
;423:	if (gametype == GT_TOURNAMENT) return qfalse;
ADDRGP4 gametype
INDIRI4
CNSTI4 1
NEI4 $311
CNSTI4 0
RETI4
ADDRGP4 $303
JUMPV
LABELV $311
line 424
;424:	rnd = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_ENTEREXITGAME, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 27
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 40
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 40
INDIRF4
ASGNF4
line 425
;425:	if (!bot_fastchat.integer) {
ADDRGP4 bot_fastchat+12
INDIRI4
CNSTI4 0
NEI4 $313
line 426
;426:		if (random() > rnd) return qfalse;
ADDRLP4 44
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 44
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 44
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
ADDRLP4 0
INDIRF4
LEF4 $316
CNSTI4 0
RETI4
ADDRGP4 $303
JUMPV
LABELV $316
line 427
;427:	}
LABELV $313
line 428
;428:	if (BotNumActivePlayers() <= 1) return qfalse;
ADDRLP4 44
ADDRGP4 BotNumActivePlayers
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 1
GTI4 $318
CNSTI4 0
RETI4
ADDRGP4 $303
JUMPV
LABELV $318
line 429
;429:	if (!BotValidChatPosition(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 BotValidChatPosition
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
NEI4 $320
CNSTI4 0
RETI4
ADDRGP4 $303
JUMPV
LABELV $320
line 430
;430:	BotAI_BotInitialChat(bs, "game_enter",
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 52
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 60
ADDRGP4 BotMapTitle
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $322
ARGP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 $323
ASGNP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 60
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 437
;431:				EasyClientName(bs->client, name, 32),	// 0
;432:				BotRandomOpponentName(bs),				// 1
;433:				"[invalid var]",						// 2
;434:				"[invalid var]",						// 3
;435:				BotMapTitle(),							// 4
;436:				NULL);
;437:	bs->lastchat_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7192
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 438
;438:	bs->chatto = CHAT_ALL;
ADDRFP4 0
INDIRP4
CNSTI4 6072
ADDP4
CNSTI4 0
ASGNI4
line 439
;439:	return qtrue;
CNSTI4 1
RETI4
LABELV $303
endproc BotChat_EnterGame 68 32
export BotChat_ExitGame
proc BotChat_ExitGame 64 32
line 447
;440:}
;441:
;442:/*
;443:==================
;444:BotChat_ExitGame
;445:==================
;446:*/
;447:int BotChat_ExitGame(bot_state_t *bs) {
line 451
;448:	char name[32];
;449:	float rnd;
;450:
;451:	if (bot_nochat.integer) return qfalse;
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 0
EQI4 $325
CNSTI4 0
RETI4
ADDRGP4 $324
JUMPV
LABELV $325
line 452
;452:	if (bs->lastchat_time > FloatTime() - TIME_BETWEENCHATTING) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 7192
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1103626240
SUBF4
LEF4 $328
CNSTI4 0
RETI4
ADDRGP4 $324
JUMPV
LABELV $328
line 454
;453:	//don't chat in teamplay
;454:	if (TeamPlayIsOn()) return qfalse;
ADDRLP4 36
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $330
CNSTI4 0
RETI4
ADDRGP4 $324
JUMPV
LABELV $330
line 456
;455:	// don't chat in tournament mode
;456:	if (gametype == GT_TOURNAMENT) return qfalse;
ADDRGP4 gametype
INDIRI4
CNSTI4 1
NEI4 $332
CNSTI4 0
RETI4
ADDRGP4 $324
JUMPV
LABELV $332
line 457
;457:	rnd = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_ENTEREXITGAME, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 27
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 40
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 40
INDIRF4
ASGNF4
line 458
;458:	if (!bot_fastchat.integer) {
ADDRGP4 bot_fastchat+12
INDIRI4
CNSTI4 0
NEI4 $334
line 459
;459:		if (random() > rnd) return qfalse;
ADDRLP4 44
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 44
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 44
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
ADDRLP4 0
INDIRF4
LEF4 $337
CNSTI4 0
RETI4
ADDRGP4 $324
JUMPV
LABELV $337
line 460
;460:	}
LABELV $334
line 461
;461:	if (BotNumActivePlayers() <= 1) return qfalse;
ADDRLP4 44
ADDRGP4 BotNumActivePlayers
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 1
GTI4 $339
CNSTI4 0
RETI4
ADDRGP4 $324
JUMPV
LABELV $339
line 463
;462:	//
;463:	BotAI_BotInitialChat(bs, "game_exit",
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 48
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 56
ADDRGP4 BotMapTitle
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $341
ARGP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 $323
ASGNP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRLP4 56
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 470
;464:				EasyClientName(bs->client, name, 32),	// 0
;465:				BotRandomOpponentName(bs),				// 1
;466:				"[invalid var]",						// 2
;467:				"[invalid var]",						// 3
;468:				BotMapTitle(),							// 4
;469:				NULL);
;470:	bs->lastchat_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7192
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 471
;471:	bs->chatto = CHAT_ALL;
ADDRFP4 0
INDIRP4
CNSTI4 6072
ADDP4
CNSTI4 0
ASGNI4
line 472
;472:	return qtrue;
CNSTI4 1
RETI4
LABELV $324
endproc BotChat_ExitGame 64 32
export BotChat_StartLevel
proc BotChat_StartLevel 56 16
line 480
;473:}
;474:
;475:/*
;476:==================
;477:BotChat_StartLevel
;478:==================
;479:*/
;480:int BotChat_StartLevel(bot_state_t *bs) {
line 484
;481:	char name[32];
;482:	float rnd;
;483:
;484:	if (bot_nochat.integer) return qfalse;
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 0
EQI4 $343
CNSTI4 0
RETI4
ADDRGP4 $342
JUMPV
LABELV $343
line 485
;485:	if (BotIsObserver(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 BotIsObserver
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $346
CNSTI4 0
RETI4
ADDRGP4 $342
JUMPV
LABELV $346
line 486
;486:	if (bs->lastchat_time > FloatTime() - TIME_BETWEENCHATTING) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 7192
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1103626240
SUBF4
LEF4 $348
CNSTI4 0
RETI4
ADDRGP4 $342
JUMPV
LABELV $348
line 488
;487:	//don't chat in teamplay
;488:	if (TeamPlayIsOn()) {
ADDRLP4 40
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $350
line 490
;489:	    //trap_EA_Command(bs->client, "vtaunt");	// JUHOX: no vtaunt available
;490:	    return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $342
JUMPV
LABELV $350
line 493
;491:	}
;492:	// don't chat in tournament mode
;493:	if (gametype == GT_TOURNAMENT) return qfalse;
ADDRGP4 gametype
INDIRI4
CNSTI4 1
NEI4 $352
CNSTI4 0
RETI4
ADDRGP4 $342
JUMPV
LABELV $352
line 494
;494:	rnd = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_STARTENDLEVEL, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 26
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 44
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 44
INDIRF4
ASGNF4
line 495
;495:	if (!bot_fastchat.integer) {
ADDRGP4 bot_fastchat+12
INDIRI4
CNSTI4 0
NEI4 $354
line 496
;496:		if (random() > rnd) return qfalse;
ADDRLP4 48
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 48
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 48
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
ADDRLP4 0
INDIRF4
LEF4 $357
CNSTI4 0
RETI4
ADDRGP4 $342
JUMPV
LABELV $357
line 497
;497:	}
LABELV $354
line 498
;498:	if (BotNumActivePlayers() <= 1) return qfalse;
ADDRLP4 48
ADDRGP4 BotNumActivePlayers
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 1
GTI4 $359
CNSTI4 0
RETI4
ADDRGP4 $342
JUMPV
LABELV $359
line 499
;499:	BotAI_BotInitialChat(bs, "level_start",
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 52
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $361
ARGP4
ADDRLP4 52
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 502
;500:				EasyClientName(bs->client, name, 32),	// 0
;501:				NULL);
;502:	bs->lastchat_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7192
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 503
;503:	bs->chatto = CHAT_ALL;
ADDRFP4 0
INDIRP4
CNSTI4 6072
ADDP4
CNSTI4 0
ASGNI4
line 504
;504:	return qtrue;
CNSTI4 1
RETI4
LABELV $342
endproc BotChat_StartLevel 56 16
export BotChat_EndLevel
proc BotChat_EndLevel 80 32
line 512
;505:}
;506:
;507:/*
;508:==================
;509:BotChat_EndLevel
;510:==================
;511:*/
;512:int BotChat_EndLevel(bot_state_t *bs) {
line 516
;513:	char name[32];
;514:	float rnd;
;515:
;516:	if (bot_nochat.integer) return qfalse;
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 0
EQI4 $363
CNSTI4 0
RETI4
ADDRGP4 $362
JUMPV
LABELV $363
line 517
;517:	if (BotIsObserver(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 BotIsObserver
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $366
CNSTI4 0
RETI4
ADDRGP4 $362
JUMPV
LABELV $366
line 518
;518:	if (bs->lastchat_time > FloatTime() - TIME_BETWEENCHATTING) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 7192
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1103626240
SUBF4
LEF4 $368
CNSTI4 0
RETI4
ADDRGP4 $362
JUMPV
LABELV $368
line 520
;519:	// teamplay
;520:	if (TeamPlayIsOn()) 
ADDRLP4 40
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $370
line 521
;521:	{
line 522
;522:		if (BotIsFirstInRankings(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 BotIsFirstInRankings
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $372
line 524
;523:			//trap_EA_Command(bs->client, "vtaunt");	// JUHOX: no vtaunt available
;524:		}
LABELV $372
line 525
;525:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $362
JUMPV
LABELV $370
line 528
;526:	}
;527:	// don't chat in tournament mode
;528:	if (gametype == GT_TOURNAMENT) return qfalse;
ADDRGP4 gametype
INDIRI4
CNSTI4 1
NEI4 $374
CNSTI4 0
RETI4
ADDRGP4 $362
JUMPV
LABELV $374
line 529
;529:	rnd = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_STARTENDLEVEL, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 26
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 44
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 44
INDIRF4
ASGNF4
line 530
;530:	if (!bot_fastchat.integer) {
ADDRGP4 bot_fastchat+12
INDIRI4
CNSTI4 0
NEI4 $376
line 531
;531:		if (random() > rnd) return qfalse;
ADDRLP4 48
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 48
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 48
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
ADDRLP4 0
INDIRF4
LEF4 $379
CNSTI4 0
RETI4
ADDRGP4 $362
JUMPV
LABELV $379
line 532
;532:	}
LABELV $376
line 533
;533:	if (BotNumActivePlayers() <= 1) return qfalse;
ADDRLP4 48
ADDRGP4 BotNumActivePlayers
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 1
GTI4 $381
CNSTI4 0
RETI4
ADDRGP4 $362
JUMPV
LABELV $381
line 535
;534:	//
;535:	if (BotIsFirstInRankings(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 BotIsFirstInRankings
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $383
line 536
;536:		BotAI_BotInitialChat(bs, "level_end_victory",
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 56
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 64
ADDRGP4 BotLastClientInRankings
CALLP4
ASGNP4
ADDRLP4 68
ADDRGP4 BotMapTitle
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $385
ARGP4
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRGP4 $323
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 543
;537:				EasyClientName(bs->client, name, 32),	// 0
;538:				BotRandomOpponentName(bs),				// 1
;539:				"[invalid var]",						// 2
;540:				BotLastClientInRankings(),				// 3
;541:				BotMapTitle(),							// 4
;542:				NULL);
;543:	}
ADDRGP4 $384
JUMPV
LABELV $383
line 544
;544:	else if (BotIsLastInRankings(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 BotIsLastInRankings
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $386
line 545
;545:		BotAI_BotInitialChat(bs, "level_end_lose",
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 60
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 68
ADDRGP4 BotFirstClientInRankings
CALLP4
ASGNP4
ADDRLP4 72
ADDRGP4 BotMapTitle
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $388
ARGP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRGP4 $323
ARGP4
ADDRLP4 72
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 552
;546:				EasyClientName(bs->client, name, 32),	// 0
;547:				BotRandomOpponentName(bs),				// 1
;548:				BotFirstClientInRankings(),				// 2
;549:				"[invalid var]",						// 3
;550:				BotMapTitle(),							// 4
;551:				NULL);
;552:	}
ADDRGP4 $387
JUMPV
LABELV $386
line 553
;553:	else {
line 554
;554:		BotAI_BotInitialChat(bs, "level_end",
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 60
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 68
ADDRGP4 BotFirstClientInRankings
CALLP4
ASGNP4
ADDRLP4 72
ADDRGP4 BotLastClientInRankings
CALLP4
ASGNP4
ADDRLP4 76
ADDRGP4 BotMapTitle
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $389
ARGP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRLP4 76
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 561
;555:				EasyClientName(bs->client, name, 32),	// 0
;556:				BotRandomOpponentName(bs),				// 1
;557:				BotFirstClientInRankings(),				// 2
;558:				BotLastClientInRankings(),				// 3
;559:				BotMapTitle(),							// 4
;560:				NULL);
;561:	}
LABELV $387
LABELV $384
line 562
;562:	bs->lastchat_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7192
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 563
;563:	bs->chatto = CHAT_ALL;
ADDRFP4 0
INDIRP4
CNSTI4 6072
ADDP4
CNSTI4 0
ASGNI4
line 564
;564:	return qtrue;
CNSTI4 1
RETI4
LABELV $362
endproc BotChat_EndLevel 80 32
export BotChat_Death
proc BotChat_Death 108 20
line 572
;565:}
;566:
;567:/*
;568:==================
;569:BotChat_Death
;570:==================
;571:*/
;572:int BotChat_Death(bot_state_t *bs) {
line 576
;573:	char name[32];
;574:	float rnd;
;575:
;576:	if (bot_nochat.integer) return qfalse;
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 0
EQI4 $391
CNSTI4 0
RETI4
ADDRGP4 $390
JUMPV
LABELV $391
line 577
;577:	if (bs->lastchat_time > FloatTime() - TIME_BETWEENCHATTING) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 7192
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1103626240
SUBF4
LEF4 $394
CNSTI4 0
RETI4
ADDRGP4 $390
JUMPV
LABELV $394
line 578
;578:	rnd = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_DEATH, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 29
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 36
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 32
ADDRLP4 36
INDIRF4
ASGNF4
line 580
;579:	// don't chat in tournament mode
;580:	if (gametype == GT_TOURNAMENT) return qfalse;
ADDRGP4 gametype
INDIRI4
CNSTI4 1
NEI4 $396
CNSTI4 0
RETI4
ADDRGP4 $390
JUMPV
LABELV $396
line 582
;581:	//if fast chatting is off
;582:	if (!bot_fastchat.integer) {
ADDRGP4 bot_fastchat+12
INDIRI4
CNSTI4 0
NEI4 $398
line 583
;583:		if (random() > rnd) return qfalse;
ADDRLP4 40
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 40
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 40
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
ADDRLP4 32
INDIRF4
LEF4 $401
CNSTI4 0
RETI4
ADDRGP4 $390
JUMPV
LABELV $401
line 584
;584:	}
LABELV $398
line 585
;585:	if (BotNumActivePlayers() <= 1) return qfalse;
ADDRLP4 40
ADDRGP4 BotNumActivePlayers
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 1
GTI4 $403
CNSTI4 0
RETI4
ADDRGP4 $390
JUMPV
LABELV $403
line 587
;586:	//
;587:	if (bs->lastkilledby >= 0 && bs->lastkilledby < MAX_CLIENTS)
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 6016
ADDP4
INDIRI4
CNSTI4 0
LTI4 $405
ADDRLP4 44
INDIRP4
CNSTI4 6016
ADDP4
INDIRI4
CNSTI4 64
GEI4 $405
line 588
;588:		EasyClientName(bs->lastkilledby, name, 32);
ADDRFP4 0
INDIRP4
CNSTI4 6016
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
ADDRGP4 $406
JUMPV
LABELV $405
line 590
;589:	else
;590:		strcpy(name, "[world]");
ADDRLP4 0
ARGP4
ADDRGP4 $407
ARGP4
ADDRGP4 strcpy
CALLP4
pop
LABELV $406
line 592
;591:	//
;592:	if (TeamPlayIsOn() && BotSameTeam(bs, bs->lastkilledby)) {
ADDRLP4 48
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $408
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRLP4 52
INDIRP4
CNSTI4 6016
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $408
line 593
;593:		if (bs->lastkilledby == bs->client) return qfalse;
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 6016
ADDP4
INDIRI4
ADDRLP4 60
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $410
CNSTI4 0
RETI4
ADDRGP4 $390
JUMPV
LABELV $410
line 594
;594:		BotAI_BotInitialChat(bs, "death_teammate", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $412
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 595
;595:		bs->chatto = CHAT_TEAM;
ADDRFP4 0
INDIRP4
CNSTI4 6072
ADDP4
CNSTI4 1
ASGNI4
line 596
;596:	}
ADDRGP4 $409
JUMPV
LABELV $408
line 598
;597:	else
;598:	{
line 600
;599:		//teamplay
;600:		if (TeamPlayIsOn()) {
ADDRLP4 60
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $413
line 602
;601:			//trap_EA_Command(bs->client, "vtaunt");	// JUHOX: no vtaunt available
;602:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $390
JUMPV
LABELV $413
line 605
;603:		}
;604:		//
;605:		if (bs->botdeathtype == MOD_WATER)
ADDRFP4 0
INDIRP4
CNSTI4 6020
ADDP4
INDIRI4
CNSTI4 19
NEI4 $415
line 606
;606:			BotAI_BotInitialChat(bs, "death_drown", BotRandomOpponentName(bs), NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $417
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
ADDRGP4 $416
JUMPV
LABELV $415
line 607
;607:		else if (bs->botdeathtype == MOD_SLIME)
ADDRFP4 0
INDIRP4
CNSTI4 6020
ADDP4
INDIRI4
CNSTI4 20
NEI4 $418
line 608
;608:			BotAI_BotInitialChat(bs, "death_slime", BotRandomOpponentName(bs), NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $420
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
ADDRGP4 $419
JUMPV
LABELV $418
line 609
;609:		else if (bs->botdeathtype == MOD_LAVA)
ADDRFP4 0
INDIRP4
CNSTI4 6020
ADDP4
INDIRI4
CNSTI4 21
NEI4 $421
line 610
;610:			BotAI_BotInitialChat(bs, "death_lava", BotRandomOpponentName(bs), NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 72
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $423
ARGP4
ADDRLP4 72
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
ADDRGP4 $422
JUMPV
LABELV $421
line 611
;611:		else if (bs->botdeathtype == MOD_FALLING)
ADDRFP4 0
INDIRP4
CNSTI4 6020
ADDP4
INDIRI4
CNSTI4 24
NEI4 $424
line 612
;612:			BotAI_BotInitialChat(bs, "death_cratered", BotRandomOpponentName(bs), NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 76
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $426
ARGP4
ADDRLP4 76
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
ADDRGP4 $425
JUMPV
LABELV $424
line 613
;613:		else if (bs->botsuicide || //all other suicides by own weapon
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 6028
ADDP4
INDIRI4
CNSTI4 0
NEI4 $433
ADDRLP4 80
INDIRP4
CNSTI4 6020
ADDP4
INDIRI4
CNSTI4 22
EQI4 $433
ADDRLP4 80
INDIRP4
CNSTI4 6020
ADDP4
INDIRI4
CNSTI4 25
EQI4 $433
ADDRLP4 80
INDIRP4
CNSTI4 6020
ADDP4
INDIRI4
CNSTI4 26
EQI4 $433
ADDRLP4 80
INDIRP4
CNSTI4 6020
ADDP4
INDIRI4
CNSTI4 27
EQI4 $433
ADDRLP4 80
INDIRP4
CNSTI4 6020
ADDP4
INDIRI4
CNSTI4 0
NEI4 $427
LABELV $433
line 619
;614:				bs->botdeathtype == MOD_CRUSH ||
;615:				bs->botdeathtype == MOD_SUICIDE ||
;616:				bs->botdeathtype == MOD_TARGET_LASER ||
;617:				bs->botdeathtype == MOD_TRIGGER_HURT ||
;618:				bs->botdeathtype == MOD_UNKNOWN)
;619:			BotAI_BotInitialChat(bs, "death_suicide", BotRandomOpponentName(bs), NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 84
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $434
ARGP4
ADDRLP4 84
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
ADDRGP4 $428
JUMPV
LABELV $427
line 620
;620:		else if (bs->botdeathtype == MOD_TELEFRAG)
ADDRFP4 0
INDIRP4
CNSTI4 6020
ADDP4
INDIRI4
CNSTI4 23
NEI4 $435
line 621
;621:			BotAI_BotInitialChat(bs, "death_telefrag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $437
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
ADDRGP4 $436
JUMPV
LABELV $435
line 626
;622:#ifdef MISSIONPACK
;623:		else if (bs->botdeathtype == MOD_KAMIKAZE && trap_BotNumInitialChats(bs->cs, "death_kamikaze"))
;624:			BotAI_BotInitialChat(bs, "death_kamikaze", name, NULL);
;625:#endif
;626:		else {
line 627
;627:			if ((bs->botdeathtype == MOD_GAUNTLET ||
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 6020
ADDP4
INDIRI4
CNSTI4 2
EQI4 $442
ADDRLP4 88
INDIRP4
CNSTI4 6020
ADDP4
INDIRI4
CNSTI4 15
EQI4 $442
ADDRLP4 88
INDIRP4
CNSTI4 6020
ADDP4
INDIRI4
CNSTI4 17
EQI4 $442
ADDRLP4 88
INDIRP4
CNSTI4 6020
ADDP4
INDIRI4
CNSTI4 18
NEI4 $438
LABELV $442
ADDRLP4 92
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 92
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 92
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1056964608
GEF4 $438
line 630
;628:				bs->botdeathtype == MOD_RAILGUN ||
;629:				bs->botdeathtype == MOD_BFG ||
;630:				bs->botdeathtype == MOD_BFG_SPLASH) && random() < 0.5) {
line 632
;631:
;632:				if (bs->botdeathtype == MOD_GAUNTLET)
ADDRFP4 0
INDIRP4
CNSTI4 6020
ADDP4
INDIRI4
CNSTI4 2
NEI4 $443
line 633
;633:					BotAI_BotInitialChat(bs, "death_gauntlet",
ADDRFP4 0
INDIRP4
CNSTI4 6020
ADDP4
INDIRI4
ARGI4
ADDRLP4 96
ADDRGP4 BotWeaponNameForMeansOfDeath
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $445
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 96
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
ADDRGP4 $439
JUMPV
LABELV $443
line 637
;634:							name,												// 0
;635:							BotWeaponNameForMeansOfDeath(bs->botdeathtype),		// 1
;636:							NULL);
;637:				else if (bs->botdeathtype == MOD_RAILGUN)
ADDRFP4 0
INDIRP4
CNSTI4 6020
ADDP4
INDIRI4
CNSTI4 15
NEI4 $446
line 638
;638:					BotAI_BotInitialChat(bs, "death_rail",
ADDRFP4 0
INDIRP4
CNSTI4 6020
ADDP4
INDIRI4
ARGI4
ADDRLP4 100
ADDRGP4 BotWeaponNameForMeansOfDeath
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $448
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 100
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
ADDRGP4 $439
JUMPV
LABELV $446
line 643
;639:							name,												// 0
;640:							BotWeaponNameForMeansOfDeath(bs->botdeathtype),		// 1
;641:							NULL);
;642:				else
;643:					BotAI_BotInitialChat(bs, "death_bfg",
ADDRFP4 0
INDIRP4
CNSTI4 6020
ADDP4
INDIRI4
ARGI4
ADDRLP4 104
ADDRGP4 BotWeaponNameForMeansOfDeath
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $449
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 104
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 647
;644:							name,												// 0
;645:							BotWeaponNameForMeansOfDeath(bs->botdeathtype),		// 1
;646:							NULL);
;647:			}
ADDRGP4 $439
JUMPV
LABELV $438
line 649
;648:			//choose between insult and praise
;649:			else if (random() < trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_INSULT, 0, 1)) {
ADDRLP4 96
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 24
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 100
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 96
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 96
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
ADDRLP4 100
INDIRF4
GEF4 $450
line 650
;650:				BotAI_BotInitialChat(bs, "death_insult",
ADDRFP4 0
INDIRP4
CNSTI4 6020
ADDP4
INDIRI4
ARGI4
ADDRLP4 104
ADDRGP4 BotWeaponNameForMeansOfDeath
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $452
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 104
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 654
;651:							name,												// 0
;652:							BotWeaponNameForMeansOfDeath(bs->botdeathtype),		// 1
;653:							NULL);
;654:			}
ADDRGP4 $451
JUMPV
LABELV $450
line 655
;655:			else {
line 656
;656:				BotAI_BotInitialChat(bs, "death_praise",
ADDRFP4 0
INDIRP4
CNSTI4 6020
ADDP4
INDIRI4
ARGI4
ADDRLP4 104
ADDRGP4 BotWeaponNameForMeansOfDeath
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $453
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 104
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 660
;657:							name,												// 0
;658:							BotWeaponNameForMeansOfDeath(bs->botdeathtype),		// 1
;659:							NULL);
;660:			}
LABELV $451
LABELV $439
line 661
;661:		}
LABELV $436
LABELV $428
LABELV $425
LABELV $422
LABELV $419
LABELV $416
line 662
;662:		bs->chatto = CHAT_ALL;
ADDRFP4 0
INDIRP4
CNSTI4 6072
ADDP4
CNSTI4 0
ASGNI4
line 663
;663:	}
LABELV $409
line 664
;664:	bs->lastchat_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7192
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 665
;665:	return qtrue;
CNSTI4 1
RETI4
LABELV $390
endproc BotChat_Death 108 20
export BotChat_Kill
proc BotChat_Kill 80 16
line 673
;666:}
;667:
;668:/*
;669:==================
;670:BotChat_Kill
;671:==================
;672:*/
;673:int BotChat_Kill(bot_state_t *bs) {
line 677
;674:	char name[32];
;675:	float rnd;
;676:
;677:	if (bot_nochat.integer) return qfalse;
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 0
EQI4 $455
CNSTI4 0
RETI4
ADDRGP4 $454
JUMPV
LABELV $455
line 678
;678:	if (bs->lastchat_time > FloatTime() - TIME_BETWEENCHATTING) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 7192
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1103626240
SUBF4
LEF4 $458
CNSTI4 0
RETI4
ADDRGP4 $454
JUMPV
LABELV $458
line 679
;679:	rnd = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_KILL, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 28
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 36
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 32
ADDRLP4 36
INDIRF4
ASGNF4
line 681
;680:	// don't chat in tournament mode
;681:	if (gametype == GT_TOURNAMENT) return qfalse;
ADDRGP4 gametype
INDIRI4
CNSTI4 1
NEI4 $460
CNSTI4 0
RETI4
ADDRGP4 $454
JUMPV
LABELV $460
line 683
;682:	//if fast chat is off
;683:	if (!bot_fastchat.integer) {
ADDRGP4 bot_fastchat+12
INDIRI4
CNSTI4 0
NEI4 $462
line 684
;684:		if (random() > rnd) return qfalse;
ADDRLP4 40
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 40
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 40
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
ADDRLP4 32
INDIRF4
LEF4 $465
CNSTI4 0
RETI4
ADDRGP4 $454
JUMPV
LABELV $465
line 685
;685:	}
LABELV $462
line 686
;686:	if (bs->lastkilledplayer == bs->client) return qfalse;
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 6012
ADDP4
INDIRI4
ADDRLP4 40
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $467
CNSTI4 0
RETI4
ADDRGP4 $454
JUMPV
LABELV $467
line 687
;687:	if (BotNumActivePlayers() <= 1) return qfalse;
ADDRLP4 44
ADDRGP4 BotNumActivePlayers
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 1
GTI4 $469
CNSTI4 0
RETI4
ADDRGP4 $454
JUMPV
LABELV $469
line 688
;688:	if (!BotValidChatPosition(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 BotValidChatPosition
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
NEI4 $471
CNSTI4 0
RETI4
ADDRGP4 $454
JUMPV
LABELV $471
line 690
;689:	//
;690:	if (BotVisibleEnemies(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 BotVisibleEnemies
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $473
CNSTI4 0
RETI4
ADDRGP4 $454
JUMPV
LABELV $473
line 692
;691:	//
;692:	EasyClientName(bs->lastkilledplayer, name, 32);
ADDRFP4 0
INDIRP4
CNSTI4 6012
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 694
;693:	//
;694:	bs->chatto = CHAT_ALL;
ADDRFP4 0
INDIRP4
CNSTI4 6072
ADDP4
CNSTI4 0
ASGNI4
line 695
;695:	if (TeamPlayIsOn() && BotSameTeam(bs, bs->lastkilledplayer)) {
ADDRLP4 56
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $475
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRLP4 60
INDIRP4
CNSTI4 6012
ADDP4
INDIRI4
ARGI4
ADDRLP4 64
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
EQI4 $475
line 696
;696:		BotAI_BotInitialChat(bs, "kill_teammate", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $477
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 697
;697:		bs->chatto = CHAT_TEAM;
ADDRFP4 0
INDIRP4
CNSTI4 6072
ADDP4
CNSTI4 1
ASGNI4
line 698
;698:	}
ADDRGP4 $476
JUMPV
LABELV $475
line 700
;699:	else
;700:	{
line 702
;701:		//don't chat in teamplay
;702:		if (TeamPlayIsOn()) {
ADDRLP4 68
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $478
line 704
;703:			//trap_EA_Command(bs->client, "vtaunt");	// JUHOX: no vtaunt available
;704:			return qfalse;			// don't wait
CNSTI4 0
RETI4
ADDRGP4 $454
JUMPV
LABELV $478
line 707
;705:		}
;706:		//
;707:		if (bs->enemydeathtype == MOD_GAUNTLET) {
ADDRFP4 0
INDIRP4
CNSTI4 6024
ADDP4
INDIRI4
CNSTI4 2
NEI4 $480
line 708
;708:			BotAI_BotInitialChat(bs, "kill_gauntlet", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $482
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 709
;709:		}
ADDRGP4 $481
JUMPV
LABELV $480
line 710
;710:		else if (bs->enemydeathtype == MOD_RAILGUN) {
ADDRFP4 0
INDIRP4
CNSTI4 6024
ADDP4
INDIRI4
CNSTI4 15
NEI4 $483
line 711
;711:			BotAI_BotInitialChat(bs, "kill_rail", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $485
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 712
;712:		}
ADDRGP4 $484
JUMPV
LABELV $483
line 713
;713:		else if (bs->enemydeathtype == MOD_TELEFRAG) {
ADDRFP4 0
INDIRP4
CNSTI4 6024
ADDP4
INDIRI4
CNSTI4 23
NEI4 $486
line 714
;714:			BotAI_BotInitialChat(bs, "kill_telefrag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $488
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 715
;715:		}
ADDRGP4 $487
JUMPV
LABELV $486
line 721
;716:#ifdef MISSIONPACK
;717:		else if (bs->botdeathtype == MOD_KAMIKAZE && trap_BotNumInitialChats(bs->cs, "kill_kamikaze"))
;718:			BotAI_BotInitialChat(bs, "kill_kamikaze", name, NULL);
;719:#endif
;720:		//choose between insult and praise
;721:		else if (random() < trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_INSULT, 0, 1)) {
ADDRLP4 72
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 24
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 76
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 72
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 72
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
ADDRLP4 76
INDIRF4
GEF4 $489
line 722
;722:			BotAI_BotInitialChat(bs, "kill_insult", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $491
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 723
;723:		}
ADDRGP4 $490
JUMPV
LABELV $489
line 724
;724:		else {
line 725
;725:			BotAI_BotInitialChat(bs, "kill_praise", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $492
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 726
;726:		}
LABELV $490
LABELV $487
LABELV $484
LABELV $481
line 727
;727:	}
LABELV $476
line 728
;728:	bs->lastchat_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7192
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 729
;729:	return qtrue;
CNSTI4 1
RETI4
LABELV $454
endproc BotChat_Kill 80 16
export BotChat_EnemySuicide
proc BotChat_EnemySuicide 56 16
line 737
;730:}
;731:
;732:/*
;733:==================
;734:BotChat_EnemySuicide
;735:==================
;736:*/
;737:int BotChat_EnemySuicide(bot_state_t *bs) {
line 741
;738:	char name[32];
;739:	float rnd;
;740:
;741:	if (bot_nochat.integer) return qfalse;
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 0
EQI4 $494
CNSTI4 0
RETI4
ADDRGP4 $493
JUMPV
LABELV $494
line 742
;742:	if (bs->lastchat_time > FloatTime() - TIME_BETWEENCHATTING) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 7192
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1103626240
SUBF4
LEF4 $497
CNSTI4 0
RETI4
ADDRGP4 $493
JUMPV
LABELV $497
line 743
;743:	if (BotNumActivePlayers() <= 1) return qfalse;
ADDRLP4 36
ADDRGP4 BotNumActivePlayers
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 1
GTI4 $499
CNSTI4 0
RETI4
ADDRGP4 $493
JUMPV
LABELV $499
line 745
;744:	//
;745:	rnd = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_KILL, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 28
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 40
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 32
ADDRLP4 40
INDIRF4
ASGNF4
line 747
;746:	//don't chat in teamplay
;747:	if (TeamPlayIsOn()) return qfalse;
ADDRLP4 44
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $501
CNSTI4 0
RETI4
ADDRGP4 $493
JUMPV
LABELV $501
line 749
;748:	// don't chat in tournament mode
;749:	if (gametype == GT_TOURNAMENT) return qfalse;
ADDRGP4 gametype
INDIRI4
CNSTI4 1
NEI4 $503
CNSTI4 0
RETI4
ADDRGP4 $493
JUMPV
LABELV $503
line 751
;750:	//if fast chat is off
;751:	if (!bot_fastchat.integer) {
ADDRGP4 bot_fastchat+12
INDIRI4
CNSTI4 0
NEI4 $505
line 752
;752:		if (random() > rnd) return qfalse;
ADDRLP4 48
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 48
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 48
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
ADDRLP4 32
INDIRF4
LEF4 $508
CNSTI4 0
RETI4
ADDRGP4 $493
JUMPV
LABELV $508
line 753
;753:	}
LABELV $505
line 754
;754:	if (!BotValidChatPosition(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 BotValidChatPosition
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
NEI4 $510
CNSTI4 0
RETI4
ADDRGP4 $493
JUMPV
LABELV $510
line 756
;755:	//
;756:	if (BotVisibleEnemies(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 BotVisibleEnemies
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $512
CNSTI4 0
RETI4
ADDRGP4 $493
JUMPV
LABELV $512
line 758
;757:	//
;758:	if (bs->enemy >= 0) EasyClientName(bs->enemy, name, 32);
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 0
LTI4 $514
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
ADDRGP4 $515
JUMPV
LABELV $514
line 759
;759:	else strcpy(name, "");
ADDRLP4 0
ARGP4
ADDRGP4 $516
ARGP4
ADDRGP4 strcpy
CALLP4
pop
LABELV $515
line 760
;760:	BotAI_BotInitialChat(bs, "enemy_suicide", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $517
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 761
;761:	bs->lastchat_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7192
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 762
;762:	bs->chatto = CHAT_ALL;
ADDRFP4 0
INDIRP4
CNSTI4 6072
ADDP4
CNSTI4 0
ASGNI4
line 763
;763:	return qtrue;
CNSTI4 1
RETI4
LABELV $493
endproc BotChat_EnemySuicide 56 16
export BotChat_HitTalking
proc BotChat_HitTalking 68 20
line 771
;764:}
;765:
;766:/*
;767:==================
;768:BotChat_HitTalking
;769:==================
;770:*/
;771:int BotChat_HitTalking(bot_state_t *bs) {
line 776
;772:	char name[32], *weap;
;773:	int lasthurt_client;
;774:	float rnd;
;775:
;776:	if (bot_nochat.integer) return qfalse;
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 0
EQI4 $519
CNSTI4 0
RETI4
ADDRGP4 $518
JUMPV
LABELV $519
line 777
;777:	if (bs->lastchat_time > FloatTime() - TIME_BETWEENCHATTING) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 7192
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1103626240
SUBF4
LEF4 $522
CNSTI4 0
RETI4
ADDRGP4 $518
JUMPV
LABELV $522
line 778
;778:	if (BotNumActivePlayers() <= 1) return qfalse;
ADDRLP4 44
ADDRGP4 BotNumActivePlayers
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 1
GTI4 $524
CNSTI4 0
RETI4
ADDRGP4 $518
JUMPV
LABELV $524
line 779
;779:	lasthurt_client = g_entities[bs->client].client->lasthurt_client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
ASGNI4
line 781
;780:	//if (!lasthurt_client) return qfalse;	// JUHOX: no longer needed
;781:	if (lasthurt_client == bs->client) return qfalse;
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $527
CNSTI4 0
RETI4
ADDRGP4 $518
JUMPV
LABELV $527
line 783
;782:	//
;783:	if (lasthurt_client < 0 || lasthurt_client >= MAX_CLIENTS) return qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $531
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $529
LABELV $531
CNSTI4 0
RETI4
ADDRGP4 $518
JUMPV
LABELV $529
line 785
;784:	//
;785:	rnd = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_HITTALKING, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 31
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 52
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 40
ADDRLP4 52
INDIRF4
ASGNF4
line 787
;786:	//don't chat in teamplay
;787:	if (TeamPlayIsOn()) return qfalse;
ADDRLP4 56
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $532
CNSTI4 0
RETI4
ADDRGP4 $518
JUMPV
LABELV $532
line 789
;788:	// don't chat in tournament mode
;789:	if (gametype == GT_TOURNAMENT) return qfalse;
ADDRGP4 gametype
INDIRI4
CNSTI4 1
NEI4 $534
CNSTI4 0
RETI4
ADDRGP4 $518
JUMPV
LABELV $534
line 791
;790:	//if fast chat is off
;791:	if (!bot_fastchat.integer) {
ADDRGP4 bot_fastchat+12
INDIRI4
CNSTI4 0
NEI4 $536
line 792
;792:		if (random() > rnd * 0.5) return qfalse;
ADDRLP4 60
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 60
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 60
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
ADDRLP4 40
INDIRF4
CNSTF4 1056964608
MULF4
LEF4 $539
CNSTI4 0
RETI4
ADDRGP4 $518
JUMPV
LABELV $539
line 793
;793:	}
LABELV $536
line 794
;794:	if (!BotValidChatPosition(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 BotValidChatPosition
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
NEI4 $541
CNSTI4 0
RETI4
ADDRGP4 $518
JUMPV
LABELV $541
line 796
;795:	//
;796:	ClientName(g_entities[bs->client].client->lasthurt_client, name, sizeof(name));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 797
;797:	weap = BotWeaponNameForMeansOfDeath(g_entities[bs->client].client->/*lasthurt_client*/lasthurt_mod);	// JUHOX BUGFIX
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 824
ADDP4
INDIRI4
ARGI4
ADDRLP4 64
ADDRGP4 BotWeaponNameForMeansOfDeath
CALLP4
ASGNP4
ADDRLP4 36
ADDRLP4 64
INDIRP4
ASGNP4
line 799
;798:	//
;799:	BotAI_BotInitialChat(bs, "hit_talking", name, weap, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $545
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 36
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 800
;800:	bs->lastchat_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7192
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 801
;801:	bs->chatto = CHAT_ALL;
ADDRFP4 0
INDIRP4
CNSTI4 6072
ADDP4
CNSTI4 0
ASGNI4
line 802
;802:	return qtrue;
CNSTI4 1
RETI4
LABELV $518
endproc BotChat_HitTalking 68 20
export BotChat_HitNoDeath
proc BotChat_HitNoDeath 212 20
line 810
;803:}
;804:
;805:/*
;806:==================
;807:BotChat_HitNoDeath
;808:==================
;809:*/
;810:int BotChat_HitNoDeath(bot_state_t *bs) {
line 816
;811:	char name[32], *weap;
;812:	float rnd;
;813:	int lasthurt_client;
;814:	aas_entityinfo_t entinfo;
;815:
;816:	lasthurt_client = g_entities[bs->client].client->lasthurt_client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
ASGNI4
line 818
;817:	//if (!lasthurt_client) return qfalse;	// JUHOX: no longer needed
;818:	if (lasthurt_client == bs->client) return qfalse;
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $548
CNSTI4 0
RETI4
ADDRGP4 $546
JUMPV
LABELV $548
line 820
;819:	//
;820:	if (lasthurt_client < 0 || lasthurt_client >= MAX_CLIENTS) return qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $552
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $550
LABELV $552
CNSTI4 0
RETI4
ADDRGP4 $546
JUMPV
LABELV $550
line 822
;821:	//
;822:	if (bot_nochat.integer) return qfalse;
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 0
EQI4 $553
CNSTI4 0
RETI4
ADDRGP4 $546
JUMPV
LABELV $553
line 823
;823:	if (bs->lastchat_time > FloatTime() - TIME_BETWEENCHATTING) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 7192
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1103626240
SUBF4
LEF4 $556
CNSTI4 0
RETI4
ADDRGP4 $546
JUMPV
LABELV $556
line 824
;824:	if (BotNumActivePlayers() <= 1) return qfalse;
ADDRLP4 188
ADDRGP4 BotNumActivePlayers
CALLI4
ASGNI4
ADDRLP4 188
INDIRI4
CNSTI4 1
GTI4 $558
CNSTI4 0
RETI4
ADDRGP4 $546
JUMPV
LABELV $558
line 825
;825:	rnd = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_HITNODEATH, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 32
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 192
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 40
ADDRLP4 192
INDIRF4
ASGNF4
line 827
;826:	//don't chat in teamplay
;827:	if (TeamPlayIsOn()) return qfalse;
ADDRLP4 196
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 196
INDIRI4
CNSTI4 0
EQI4 $560
CNSTI4 0
RETI4
ADDRGP4 $546
JUMPV
LABELV $560
line 829
;828:	// don't chat in tournament mode
;829:	if (gametype == GT_TOURNAMENT) return qfalse;
ADDRGP4 gametype
INDIRI4
CNSTI4 1
NEI4 $562
CNSTI4 0
RETI4
ADDRGP4 $546
JUMPV
LABELV $562
line 831
;830:	//if fast chat is off
;831:	if (!bot_fastchat.integer) {
ADDRGP4 bot_fastchat+12
INDIRI4
CNSTI4 0
NEI4 $564
line 832
;832:		if (random() > rnd * 0.5) return qfalse;
ADDRLP4 200
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 200
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 200
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
ADDRLP4 40
INDIRF4
CNSTF4 1056964608
MULF4
LEF4 $567
CNSTI4 0
RETI4
ADDRGP4 $546
JUMPV
LABELV $567
line 833
;833:	}
LABELV $564
line 834
;834:	if (!BotValidChatPosition(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 200
ADDRGP4 BotValidChatPosition
CALLI4
ASGNI4
ADDRLP4 200
INDIRI4
CNSTI4 0
NEI4 $569
CNSTI4 0
RETI4
ADDRGP4 $546
JUMPV
LABELV $569
line 836
;835:	//
;836:	if (BotVisibleEnemies(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 204
ADDRGP4 BotVisibleEnemies
CALLI4
ASGNI4
ADDRLP4 204
INDIRI4
CNSTI4 0
EQI4 $571
CNSTI4 0
RETI4
ADDRGP4 $546
JUMPV
LABELV $571
line 842
;837:	//
;838:#if 0	// JUHOX: safety check
;839:	BotEntityInfo(bs->enemy, &entinfo);
;840:	if (EntityIsShooting(&entinfo)) return qfalse;
;841:#else
;842:	if (bs->enemy >= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 0
LTI4 $573
line 843
;843:		BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
ARGI4
ADDRLP4 44
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 844
;844:		if (EntityIsShooting(&entinfo)) return qfalse;
ADDRLP4 44
ARGP4
ADDRLP4 208
ADDRGP4 EntityIsShooting
CALLI4
ASGNI4
ADDRLP4 208
INDIRI4
CNSTI4 0
EQI4 $575
CNSTI4 0
RETI4
ADDRGP4 $546
JUMPV
LABELV $575
line 845
;845:	}
LABELV $573
line 848
;846:#endif
;847:	//
;848:	ClientName(lasthurt_client, name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 849
;849:	weap = BotWeaponNameForMeansOfDeath(g_entities[bs->client].client->lasthurt_mod);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 824
ADDP4
INDIRI4
ARGI4
ADDRLP4 208
ADDRGP4 BotWeaponNameForMeansOfDeath
CALLP4
ASGNP4
ADDRLP4 36
ADDRLP4 208
INDIRP4
ASGNP4
line 851
;850:	//
;851:	BotAI_BotInitialChat(bs, "hit_nodeath", name, weap, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $578
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 36
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 852
;852:	bs->lastchat_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7192
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 853
;853:	bs->chatto = CHAT_ALL;
ADDRFP4 0
INDIRP4
CNSTI4 6072
ADDP4
CNSTI4 0
ASGNI4
line 854
;854:	return qtrue;
CNSTI4 1
RETI4
LABELV $546
endproc BotChat_HitNoDeath 212 20
export BotChat_HitNoKill
proc BotChat_HitNoKill 208 20
line 862
;855:}
;856:
;857:/*
;858:==================
;859:BotChat_HitNoKill
;860:==================
;861:*/
;862:int BotChat_HitNoKill(bot_state_t *bs) {
line 867
;863:	char name[32], *weap;
;864:	float rnd;
;865:	aas_entityinfo_t entinfo;
;866:
;867:	if (bot_nochat.integer) return qfalse;
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 0
EQI4 $580
CNSTI4 0
RETI4
ADDRGP4 $579
JUMPV
LABELV $580
line 868
;868:	if (bs->lastchat_time > FloatTime() - TIME_BETWEENCHATTING) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 7192
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1103626240
SUBF4
LEF4 $583
CNSTI4 0
RETI4
ADDRGP4 $579
JUMPV
LABELV $583
line 869
;869:	if (BotNumActivePlayers() <= 1) return qfalse;
ADDRLP4 180
ADDRGP4 BotNumActivePlayers
CALLI4
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 1
GTI4 $585
CNSTI4 0
RETI4
ADDRGP4 $579
JUMPV
LABELV $585
line 870
;870:	rnd = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_HITNOKILL, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 33
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 184
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 176
ADDRLP4 184
INDIRF4
ASGNF4
line 872
;871:	//don't chat in teamplay
;872:	if (TeamPlayIsOn()) return qfalse;
ADDRLP4 188
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 188
INDIRI4
CNSTI4 0
EQI4 $587
CNSTI4 0
RETI4
ADDRGP4 $579
JUMPV
LABELV $587
line 874
;873:	// don't chat in tournament mode
;874:	if (gametype == GT_TOURNAMENT) return qfalse;
ADDRGP4 gametype
INDIRI4
CNSTI4 1
NEI4 $589
CNSTI4 0
RETI4
ADDRGP4 $579
JUMPV
LABELV $589
line 876
;875:	//if fast chat is off
;876:	if (!bot_fastchat.integer) {
ADDRGP4 bot_fastchat+12
INDIRI4
CNSTI4 0
NEI4 $591
line 877
;877:		if (random() > rnd * 0.5) return qfalse;
ADDRLP4 192
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 192
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 192
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
ADDRLP4 176
INDIRF4
CNSTF4 1056964608
MULF4
LEF4 $594
CNSTI4 0
RETI4
ADDRGP4 $579
JUMPV
LABELV $594
line 878
;878:	}
LABELV $591
line 879
;879:	if (!BotValidChatPosition(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 192
ADDRGP4 BotValidChatPosition
CALLI4
ASGNI4
ADDRLP4 192
INDIRI4
CNSTI4 0
NEI4 $596
CNSTI4 0
RETI4
ADDRGP4 $579
JUMPV
LABELV $596
line 881
;880:	//
;881:	if (BotVisibleEnemies(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 196
ADDRGP4 BotVisibleEnemies
CALLI4
ASGNI4
ADDRLP4 196
INDIRI4
CNSTI4 0
EQI4 $598
CNSTI4 0
RETI4
ADDRGP4 $579
JUMPV
LABELV $598
line 883
;882:	//
;883:	if (bs->enemy < 0) return qfalse;	// JUHOX: safety check
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 0
GEI4 $600
CNSTI4 0
RETI4
ADDRGP4 $579
JUMPV
LABELV $600
line 884
;884:	if (bs->enemy >= MAX_CLIENTS) return qfalse;	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 64
LTI4 $602
CNSTI4 0
RETI4
ADDRGP4 $579
JUMPV
LABELV $602
line 885
;885:	BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 886
;886:	if (EntityIsShooting(&entinfo)) return qfalse;
ADDRLP4 36
ARGP4
ADDRLP4 200
ADDRGP4 EntityIsShooting
CALLI4
ASGNI4
ADDRLP4 200
INDIRI4
CNSTI4 0
EQI4 $604
CNSTI4 0
RETI4
ADDRGP4 $579
JUMPV
LABELV $604
line 888
;887:	//
;888:	ClientName(bs->enemy, name, sizeof(name));
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 889
;889:	weap = BotWeaponNameForMeansOfDeath(g_entities[bs->enemy].client->lasthurt_mod);
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 824
ADDP4
INDIRI4
ARGI4
ADDRLP4 204
ADDRGP4 BotWeaponNameForMeansOfDeath
CALLP4
ASGNP4
ADDRLP4 32
ADDRLP4 204
INDIRP4
ASGNP4
line 891
;890:	//
;891:	BotAI_BotInitialChat(bs, "hit_nokill", name, weap, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $607
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 32
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 892
;892:	bs->lastchat_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7192
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 893
;893:	bs->chatto = CHAT_ALL;
ADDRFP4 0
INDIRP4
CNSTI4 6072
ADDP4
CNSTI4 0
ASGNI4
line 894
;894:	return qtrue;
CNSTI4 1
RETI4
LABELV $579
endproc BotChat_HitNoKill 208 20
export BotChat_Random
proc BotChat_Random 96 36
line 902
;895:}
;896:
;897:/*
;898:==================
;899:BotChat_Random
;900:==================
;901:*/
;902:int BotChat_Random(bot_state_t *bs) {
line 906
;903:	float rnd;
;904:	char name[32];
;905:
;906:	if (bot_nochat.integer) return qfalse;
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 0
EQI4 $609
CNSTI4 0
RETI4
ADDRGP4 $608
JUMPV
LABELV $609
line 907
;907:	if (BotIsObserver(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 BotIsObserver
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $612
CNSTI4 0
RETI4
ADDRGP4 $608
JUMPV
LABELV $612
line 908
;908:	if (bs->lastchat_time > FloatTime() - TIME_BETWEENCHATTING) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 7192
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1103626240
SUBF4
LEF4 $614
CNSTI4 0
RETI4
ADDRGP4 $608
JUMPV
LABELV $614
line 910
;909:	// don't chat in tournament mode
;910:	if (gametype == GT_TOURNAMENT) return qfalse;
ADDRGP4 gametype
INDIRI4
CNSTI4 1
NEI4 $616
CNSTI4 0
RETI4
ADDRGP4 $608
JUMPV
LABELV $616
line 912
;911:	//don't chat when doing something important :)
;912:	if (bs->ltgtype == LTG_TEAMHELP ||
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 1
EQI4 $621
ADDRLP4 40
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 2
EQI4 $621
ADDRLP4 40
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 5
NEI4 $618
LABELV $621
line 914
;913:		bs->ltgtype == LTG_TEAMACCOMPANY ||
;914:		bs->ltgtype == LTG_RUSHBASE) return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $608
JUMPV
LABELV $618
line 916
;915:	//
;916:	rnd = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_RANDOM, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 34
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 44
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 32
ADDRLP4 44
INDIRF4
ASGNF4
line 917
;917:	if (random() > bs->thinktime * 0.1) return qfalse;
ADDRLP4 48
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 48
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 48
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
CNSTF4 1036831949
MULF4
LEF4 $622
CNSTI4 0
RETI4
ADDRGP4 $608
JUMPV
LABELV $622
line 918
;918:	if (!bot_fastchat.integer) {
ADDRGP4 bot_fastchat+12
INDIRI4
CNSTI4 0
NEI4 $624
line 919
;919:		if (random() > rnd) return qfalse;
ADDRLP4 52
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 52
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 52
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
ADDRLP4 32
INDIRF4
LEF4 $627
CNSTI4 0
RETI4
ADDRGP4 $608
JUMPV
LABELV $627
line 920
;920:		if (random() > 0.25) return qfalse;
ADDRLP4 56
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 56
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 56
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1048576000
LEF4 $629
CNSTI4 0
RETI4
ADDRGP4 $608
JUMPV
LABELV $629
line 921
;921:	}
LABELV $624
line 922
;922:	if (BotNumActivePlayers() <= 1) return qfalse;
ADDRLP4 52
ADDRGP4 BotNumActivePlayers
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 1
GTI4 $631
CNSTI4 0
RETI4
ADDRGP4 $608
JUMPV
LABELV $631
line 924
;923:	//
;924:	if (!BotValidChatPosition(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 BotValidChatPosition
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
NEI4 $633
CNSTI4 0
RETI4
ADDRGP4 $608
JUMPV
LABELV $633
line 926
;925:	//
;926:	if (BotVisibleEnemies(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 BotVisibleEnemies
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $635
CNSTI4 0
RETI4
ADDRGP4 $608
JUMPV
LABELV $635
line 928
;927:	//
;928:	if (bs->lastkilledplayer == bs->client) {
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 6012
ADDP4
INDIRI4
ADDRLP4 64
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $637
line 929
;929:		strcpy(name, BotRandomOpponentName(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 930
;930:	}
ADDRGP4 $638
JUMPV
LABELV $637
line 931
;931:	else {
line 932
;932:		EasyClientName(bs->lastkilledplayer, name, sizeof(name));
ADDRFP4 0
INDIRP4
CNSTI4 6012
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 933
;933:	}
LABELV $638
line 934
;934:	if (TeamPlayIsOn()) {
ADDRLP4 68
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $639
line 936
;935:		//trap_EA_Command(bs->client, "vtaunt");	// JUHOX: no vtaunt available
;936:		return qfalse;			// don't wait
CNSTI4 0
RETI4
ADDRGP4 $608
JUMPV
LABELV $639
line 939
;937:	}
;938:	//
;939:	if (random() < trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_MISC, 0, 1)) {
ADDRLP4 72
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 25
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 76
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 72
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 72
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
ADDRLP4 76
INDIRF4
GEF4 $641
line 940
;940:		BotAI_BotInitialChat(bs, "random_misc",
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 80
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 84
ADDRGP4 BotMapTitle
CALLP4
ASGNP4
ADDRLP4 88
ADDRGP4 BotRandomWeaponName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $643
ARGP4
ADDRLP4 80
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 92
ADDRGP4 $323
ASGNP4
ADDRLP4 92
INDIRP4
ARGP4
ADDRLP4 92
INDIRP4
ARGP4
ADDRLP4 84
INDIRP4
ARGP4
ADDRLP4 88
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 948
;941:					BotRandomOpponentName(bs),	// 0
;942:					name,						// 1
;943:					"[invalid var]",			// 2
;944:					"[invalid var]",			// 3
;945:					BotMapTitle(),				// 4
;946:					BotRandomWeaponName(),		// 5
;947:					NULL);
;948:	}
ADDRGP4 $642
JUMPV
LABELV $641
line 949
;949:	else {
line 950
;950:		BotAI_BotInitialChat(bs, "random_insult",
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 80
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 84
ADDRGP4 BotMapTitle
CALLP4
ASGNP4
ADDRLP4 88
ADDRGP4 BotRandomWeaponName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $644
ARGP4
ADDRLP4 80
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 92
ADDRGP4 $323
ASGNP4
ADDRLP4 92
INDIRP4
ARGP4
ADDRLP4 92
INDIRP4
ARGP4
ADDRLP4 84
INDIRP4
ARGP4
ADDRLP4 88
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 958
;951:					BotRandomOpponentName(bs),	// 0
;952:					name,						// 1
;953:					"[invalid var]",			// 2
;954:					"[invalid var]",			// 3
;955:					BotMapTitle(),				// 4
;956:					BotRandomWeaponName(),		// 5
;957:					NULL);
;958:	}
LABELV $642
line 959
;959:	bs->lastchat_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7192
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 960
;960:	bs->chatto = CHAT_ALL;
ADDRFP4 0
INDIRP4
CNSTI4 6072
ADDP4
CNSTI4 0
ASGNI4
line 961
;961:	return qtrue;
CNSTI4 1
RETI4
LABELV $608
endproc BotChat_Random 96 36
export BotChatTime
proc BotChatTime 8 16
line 969
;962:}
;963:
;964:/*
;965:==================
;966:BotChatTime
;967:==================
;968:*/
;969:float BotChatTime(bot_state_t *bs) {
line 972
;970:	int cpm;
;971:
;972:	cpm = trap_Characteristic_BInteger(bs->character, CHARACTERISTIC_CHAT_CPM, 1, 4000);
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 23
ARGI4
CNSTI4 1
ARGI4
CNSTI4 4000
ARGI4
ADDRLP4 4
ADDRGP4 trap_Characteristic_BInteger
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 974
;973:
;974:	return 2.0;	//(float) trap_BotChatLength(bs->cs) * 30 / cpm;
CNSTF4 1073741824
RETF4
LABELV $645
endproc BotChatTime 8 16
export BotChatTest
proc BotChatTest 180 36
line 982
;975:}
;976:
;977:/*
;978:==================
;979:BotChatTest
;980:==================
;981:*/
;982:void BotChatTest(bot_state_t *bs) {
line 988
;983:
;984:	char name[32];
;985:	char *weap;
;986:	int num, i;
;987:
;988:	num = trap_BotNumInitialChats(bs->cs, "game_enter");
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRGP4 $322
ARGP4
ADDRLP4 44
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 44
INDIRI4
ASGNI4
line 989
;989:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $650
JUMPV
LABELV $647
line 990
;990:	{
line 991
;991:		BotAI_BotInitialChat(bs, "game_enter",
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 48
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 56
ADDRGP4 BotMapTitle
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $322
ARGP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 $323
ASGNP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRLP4 56
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 998
;992:					EasyClientName(bs->client, name, 32),	// 0
;993:					BotRandomOpponentName(bs),				// 1
;994:					"[invalid var]",						// 2
;995:					"[invalid var]",						// 3
;996:					BotMapTitle(),							// 4
;997:					NULL);
;998:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 999
;999:	}
LABELV $648
line 989
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $650
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $647
line 1000
;1000:	num = trap_BotNumInitialChats(bs->cs, "game_exit");
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRGP4 $341
ARGP4
ADDRLP4 48
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 48
INDIRI4
ASGNI4
line 1001
;1001:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $654
JUMPV
LABELV $651
line 1002
;1002:	{
line 1003
;1003:		BotAI_BotInitialChat(bs, "game_exit",
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 52
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 60
ADDRGP4 BotMapTitle
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $341
ARGP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 $323
ASGNP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 60
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1010
;1004:					EasyClientName(bs->client, name, 32),	// 0
;1005:					BotRandomOpponentName(bs),				// 1
;1006:					"[invalid var]",						// 2
;1007:					"[invalid var]",						// 3
;1008:					BotMapTitle(),							// 4
;1009:					NULL);
;1010:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1011
;1011:	}
LABELV $652
line 1001
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $654
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $651
line 1012
;1012:	num = trap_BotNumInitialChats(bs->cs, "level_start");
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRGP4 $361
ARGP4
ADDRLP4 52
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 52
INDIRI4
ASGNI4
line 1013
;1013:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $658
JUMPV
LABELV $655
line 1014
;1014:	{
line 1015
;1015:		BotAI_BotInitialChat(bs, "level_start",
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 56
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $361
ARGP4
ADDRLP4 56
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1018
;1016:					EasyClientName(bs->client, name, 32),	// 0
;1017:					NULL);
;1018:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1019
;1019:	}
LABELV $656
line 1013
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $658
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $655
line 1020
;1020:	num = trap_BotNumInitialChats(bs->cs, "level_end_victory");
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRGP4 $385
ARGP4
ADDRLP4 56
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 56
INDIRI4
ASGNI4
line 1021
;1021:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $662
JUMPV
LABELV $659
line 1022
;1022:	{
line 1023
;1023:		BotAI_BotInitialChat(bs, "level_end_victory",
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 60
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 68
ADDRGP4 BotFirstClientInRankings
CALLP4
ASGNP4
ADDRLP4 72
ADDRGP4 BotLastClientInRankings
CALLP4
ASGNP4
ADDRLP4 76
ADDRGP4 BotMapTitle
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $385
ARGP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRLP4 76
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1030
;1024:				EasyClientName(bs->client, name, 32),	// 0
;1025:				BotRandomOpponentName(bs),				// 1
;1026:				BotFirstClientInRankings(),				// 2
;1027:				BotLastClientInRankings(),				// 3
;1028:				BotMapTitle(),							// 4
;1029:				NULL);
;1030:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1031
;1031:	}
LABELV $660
line 1021
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $662
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $659
line 1032
;1032:	num = trap_BotNumInitialChats(bs->cs, "level_end_lose");
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRGP4 $388
ARGP4
ADDRLP4 60
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 60
INDIRI4
ASGNI4
line 1033
;1033:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $666
JUMPV
LABELV $663
line 1034
;1034:	{
line 1035
;1035:		BotAI_BotInitialChat(bs, "level_end_lose",
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 64
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 72
ADDRGP4 BotFirstClientInRankings
CALLP4
ASGNP4
ADDRLP4 76
ADDRGP4 BotLastClientInRankings
CALLP4
ASGNP4
ADDRLP4 80
ADDRGP4 BotMapTitle
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $388
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRLP4 80
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1042
;1036:				EasyClientName(bs->client, name, 32),	// 0
;1037:				BotRandomOpponentName(bs),				// 1
;1038:				BotFirstClientInRankings(),				// 2
;1039:				BotLastClientInRankings(),				// 3
;1040:				BotMapTitle(),							// 4
;1041:				NULL);
;1042:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1043
;1043:	}
LABELV $664
line 1033
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $666
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $663
line 1044
;1044:	num = trap_BotNumInitialChats(bs->cs, "level_end");
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRGP4 $389
ARGP4
ADDRLP4 64
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 64
INDIRI4
ASGNI4
line 1045
;1045:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $670
JUMPV
LABELV $667
line 1046
;1046:	{
line 1047
;1047:		BotAI_BotInitialChat(bs, "level_end",
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 68
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 72
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 76
ADDRGP4 BotFirstClientInRankings
CALLP4
ASGNP4
ADDRLP4 80
ADDRGP4 BotLastClientInRankings
CALLP4
ASGNP4
ADDRLP4 84
ADDRGP4 BotMapTitle
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $389
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRLP4 80
INDIRP4
ARGP4
ADDRLP4 84
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1054
;1048:				EasyClientName(bs->client, name, 32),	// 0
;1049:				BotRandomOpponentName(bs),				// 1
;1050:				BotFirstClientInRankings(),				// 2
;1051:				BotLastClientInRankings(),				// 3
;1052:				BotMapTitle(),							// 4
;1053:				NULL);
;1054:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1055
;1055:	}
LABELV $668
line 1045
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $670
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $667
line 1056
;1056:	EasyClientName(bs->lastkilledby, name, sizeof(name));
ADDRFP4 0
INDIRP4
CNSTI4 6016
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 1057
;1057:	num = trap_BotNumInitialChats(bs->cs, "death_drown");
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRGP4 $417
ARGP4
ADDRLP4 68
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 68
INDIRI4
ASGNI4
line 1058
;1058:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $674
JUMPV
LABELV $671
line 1059
;1059:	{
line 1061
;1060:		//
;1061:		BotAI_BotInitialChat(bs, "death_drown", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $417
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1062
;1062:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1063
;1063:	}
LABELV $672
line 1058
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $674
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $671
line 1064
;1064:	num = trap_BotNumInitialChats(bs->cs, "death_slime");
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRGP4 $420
ARGP4
ADDRLP4 72
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 72
INDIRI4
ASGNI4
line 1065
;1065:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $678
JUMPV
LABELV $675
line 1066
;1066:	{
line 1067
;1067:		BotAI_BotInitialChat(bs, "death_slime", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $420
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1068
;1068:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1069
;1069:	}
LABELV $676
line 1065
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $678
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $675
line 1070
;1070:	num = trap_BotNumInitialChats(bs->cs, "death_lava");
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRGP4 $423
ARGP4
ADDRLP4 76
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 76
INDIRI4
ASGNI4
line 1071
;1071:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $682
JUMPV
LABELV $679
line 1072
;1072:	{
line 1073
;1073:		BotAI_BotInitialChat(bs, "death_lava", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $423
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1074
;1074:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1075
;1075:	}
LABELV $680
line 1071
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $682
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $679
line 1076
;1076:	num = trap_BotNumInitialChats(bs->cs, "death_cratered");
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRGP4 $426
ARGP4
ADDRLP4 80
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 80
INDIRI4
ASGNI4
line 1077
;1077:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $686
JUMPV
LABELV $683
line 1078
;1078:	{
line 1079
;1079:		BotAI_BotInitialChat(bs, "death_cratered", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $426
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1080
;1080:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1081
;1081:	}
LABELV $684
line 1077
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $686
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $683
line 1082
;1082:	num = trap_BotNumInitialChats(bs->cs, "death_suicide");
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRGP4 $434
ARGP4
ADDRLP4 84
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 84
INDIRI4
ASGNI4
line 1083
;1083:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $690
JUMPV
LABELV $687
line 1084
;1084:	{
line 1085
;1085:		BotAI_BotInitialChat(bs, "death_suicide", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $434
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1086
;1086:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1087
;1087:	}
LABELV $688
line 1083
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $690
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $687
line 1088
;1088:	num = trap_BotNumInitialChats(bs->cs, "death_telefrag");
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRGP4 $437
ARGP4
ADDRLP4 88
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 88
INDIRI4
ASGNI4
line 1089
;1089:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $694
JUMPV
LABELV $691
line 1090
;1090:	{
line 1091
;1091:		BotAI_BotInitialChat(bs, "death_telefrag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $437
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1092
;1092:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1093
;1093:	}
LABELV $692
line 1089
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $694
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $691
line 1094
;1094:	num = trap_BotNumInitialChats(bs->cs, "death_gauntlet");
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRGP4 $445
ARGP4
ADDRLP4 92
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 92
INDIRI4
ASGNI4
line 1095
;1095:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $698
JUMPV
LABELV $695
line 1096
;1096:	{
line 1097
;1097:		BotAI_BotInitialChat(bs, "death_gauntlet",
ADDRFP4 0
INDIRP4
CNSTI4 6020
ADDP4
INDIRI4
ARGI4
ADDRLP4 96
ADDRGP4 BotWeaponNameForMeansOfDeath
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $445
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 96
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1101
;1098:				name,												// 0
;1099:				BotWeaponNameForMeansOfDeath(bs->botdeathtype),		// 1
;1100:				NULL);
;1101:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1102
;1102:	}
LABELV $696
line 1095
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $698
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $695
line 1103
;1103:	num = trap_BotNumInitialChats(bs->cs, "death_rail");
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRGP4 $448
ARGP4
ADDRLP4 96
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 96
INDIRI4
ASGNI4
line 1104
;1104:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $702
JUMPV
LABELV $699
line 1105
;1105:	{
line 1106
;1106:		BotAI_BotInitialChat(bs, "death_rail",
ADDRFP4 0
INDIRP4
CNSTI4 6020
ADDP4
INDIRI4
ARGI4
ADDRLP4 100
ADDRGP4 BotWeaponNameForMeansOfDeath
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $448
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 100
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1110
;1107:				name,												// 0
;1108:				BotWeaponNameForMeansOfDeath(bs->botdeathtype),		// 1
;1109:				NULL);
;1110:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1111
;1111:	}
LABELV $700
line 1104
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $702
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $699
line 1112
;1112:	num = trap_BotNumInitialChats(bs->cs, "death_bfg");
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRGP4 $449
ARGP4
ADDRLP4 100
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 100
INDIRI4
ASGNI4
line 1113
;1113:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $706
JUMPV
LABELV $703
line 1114
;1114:	{
line 1115
;1115:		BotAI_BotInitialChat(bs, "death_bfg",
ADDRFP4 0
INDIRP4
CNSTI4 6020
ADDP4
INDIRI4
ARGI4
ADDRLP4 104
ADDRGP4 BotWeaponNameForMeansOfDeath
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $449
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 104
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1119
;1116:				name,												// 0
;1117:				BotWeaponNameForMeansOfDeath(bs->botdeathtype),		// 1
;1118:				NULL);
;1119:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1120
;1120:	}
LABELV $704
line 1113
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $706
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $703
line 1121
;1121:	num = trap_BotNumInitialChats(bs->cs, "death_insult");
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRGP4 $452
ARGP4
ADDRLP4 104
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 104
INDIRI4
ASGNI4
line 1122
;1122:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $710
JUMPV
LABELV $707
line 1123
;1123:	{
line 1124
;1124:		BotAI_BotInitialChat(bs, "death_insult",
ADDRFP4 0
INDIRP4
CNSTI4 6020
ADDP4
INDIRI4
ARGI4
ADDRLP4 108
ADDRGP4 BotWeaponNameForMeansOfDeath
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $452
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 108
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1128
;1125:					name,												// 0
;1126:					BotWeaponNameForMeansOfDeath(bs->botdeathtype),		// 1
;1127:					NULL);
;1128:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1129
;1129:	}
LABELV $708
line 1122
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $710
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $707
line 1130
;1130:	num = trap_BotNumInitialChats(bs->cs, "death_praise");
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRGP4 $453
ARGP4
ADDRLP4 108
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 108
INDIRI4
ASGNI4
line 1131
;1131:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $714
JUMPV
LABELV $711
line 1132
;1132:	{
line 1133
;1133:		BotAI_BotInitialChat(bs, "death_praise",
ADDRFP4 0
INDIRP4
CNSTI4 6020
ADDP4
INDIRI4
ARGI4
ADDRLP4 112
ADDRGP4 BotWeaponNameForMeansOfDeath
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $453
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 112
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1137
;1134:					name,												// 0
;1135:					BotWeaponNameForMeansOfDeath(bs->botdeathtype),		// 1
;1136:					NULL);
;1137:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1138
;1138:	}
LABELV $712
line 1131
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $714
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $711
line 1140
;1139:	//
;1140:	EasyClientName(bs->lastkilledplayer, name, 32);
ADDRFP4 0
INDIRP4
CNSTI4 6012
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 1142
;1141:	//
;1142:	num = trap_BotNumInitialChats(bs->cs, "kill_gauntlet");
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRGP4 $482
ARGP4
ADDRLP4 112
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 112
INDIRI4
ASGNI4
line 1143
;1143:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $718
JUMPV
LABELV $715
line 1144
;1144:	{
line 1146
;1145:		//
;1146:		BotAI_BotInitialChat(bs, "kill_gauntlet", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $482
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1147
;1147:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1148
;1148:	}
LABELV $716
line 1143
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $718
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $715
line 1149
;1149:	num = trap_BotNumInitialChats(bs->cs, "kill_rail");
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRGP4 $485
ARGP4
ADDRLP4 116
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 116
INDIRI4
ASGNI4
line 1150
;1150:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $722
JUMPV
LABELV $719
line 1151
;1151:	{
line 1152
;1152:		BotAI_BotInitialChat(bs, "kill_rail", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $485
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1153
;1153:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1154
;1154:	}
LABELV $720
line 1150
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $722
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $719
line 1155
;1155:	num = trap_BotNumInitialChats(bs->cs, "kill_telefrag");
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRGP4 $488
ARGP4
ADDRLP4 120
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 120
INDIRI4
ASGNI4
line 1156
;1156:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $726
JUMPV
LABELV $723
line 1157
;1157:	{
line 1158
;1158:		BotAI_BotInitialChat(bs, "kill_telefrag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $488
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1159
;1159:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1160
;1160:	}
LABELV $724
line 1156
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $726
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $723
line 1161
;1161:	num = trap_BotNumInitialChats(bs->cs, "kill_insult");
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRGP4 $491
ARGP4
ADDRLP4 124
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 124
INDIRI4
ASGNI4
line 1162
;1162:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $730
JUMPV
LABELV $727
line 1163
;1163:	{
line 1164
;1164:		BotAI_BotInitialChat(bs, "kill_insult", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $491
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1165
;1165:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1166
;1166:	}
LABELV $728
line 1162
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $730
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $727
line 1167
;1167:	num = trap_BotNumInitialChats(bs->cs, "kill_praise");
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRGP4 $492
ARGP4
ADDRLP4 128
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 128
INDIRI4
ASGNI4
line 1168
;1168:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $734
JUMPV
LABELV $731
line 1169
;1169:	{
line 1170
;1170:		BotAI_BotInitialChat(bs, "kill_praise", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $492
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1171
;1171:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1172
;1172:	}
LABELV $732
line 1168
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $734
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $731
line 1173
;1173:	num = trap_BotNumInitialChats(bs->cs, "enemy_suicide");
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRGP4 $517
ARGP4
ADDRLP4 132
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 132
INDIRI4
ASGNI4
line 1174
;1174:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $738
JUMPV
LABELV $735
line 1175
;1175:	{
line 1176
;1176:		BotAI_BotInitialChat(bs, "enemy_suicide", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $517
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1177
;1177:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1178
;1178:	}
LABELV $736
line 1174
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $738
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $735
line 1179
;1179:	ClientName(g_entities[bs->client].client->lasthurt_client, name, sizeof(name));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1180
;1180:	weap = BotWeaponNameForMeansOfDeath(g_entities[bs->client].client->/*lasthurt_client*/lasthurt_mod);	// JUHOX BUGFIX
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 824
ADDP4
INDIRI4
ARGI4
ADDRLP4 136
ADDRGP4 BotWeaponNameForMeansOfDeath
CALLP4
ASGNP4
ADDRLP4 40
ADDRLP4 136
INDIRP4
ASGNP4
line 1181
;1181:	num = trap_BotNumInitialChats(bs->cs, "hit_talking");
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRGP4 $545
ARGP4
ADDRLP4 140
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 140
INDIRI4
ASGNI4
line 1182
;1182:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $744
JUMPV
LABELV $741
line 1183
;1183:	{
line 1184
;1184:		BotAI_BotInitialChat(bs, "hit_talking", name, weap, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $545
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1185
;1185:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1186
;1186:	}
LABELV $742
line 1182
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $744
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $741
line 1187
;1187:	num = trap_BotNumInitialChats(bs->cs, "hit_nodeath");
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRGP4 $578
ARGP4
ADDRLP4 144
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 144
INDIRI4
ASGNI4
line 1188
;1188:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $748
JUMPV
LABELV $745
line 1189
;1189:	{
line 1190
;1190:		BotAI_BotInitialChat(bs, "hit_nodeath", name, weap, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $578
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1191
;1191:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1192
;1192:	}
LABELV $746
line 1188
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $748
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $745
line 1193
;1193:	num = trap_BotNumInitialChats(bs->cs, "hit_nokill");
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRGP4 $607
ARGP4
ADDRLP4 148
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 148
INDIRI4
ASGNI4
line 1194
;1194:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $752
JUMPV
LABELV $749
line 1195
;1195:	{
line 1196
;1196:		BotAI_BotInitialChat(bs, "hit_nokill", name, weap, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $607
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1197
;1197:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1198
;1198:	}
LABELV $750
line 1194
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $752
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $749
line 1200
;1199:	//
;1200:	if (bs->lastkilledplayer == bs->client) {
ADDRLP4 152
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 152
INDIRP4
CNSTI4 6012
ADDP4
INDIRI4
ADDRLP4 152
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $753
line 1201
;1201:		strcpy(name, BotRandomOpponentName(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 156
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 8
ARGP4
ADDRLP4 156
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1202
;1202:	}
ADDRGP4 $754
JUMPV
LABELV $753
line 1203
;1203:	else {
line 1204
;1204:		EasyClientName(bs->lastkilledplayer, name, sizeof(name));
ADDRFP4 0
INDIRP4
CNSTI4 6012
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 1205
;1205:	}
LABELV $754
line 1207
;1206:	//
;1207:	num = trap_BotNumInitialChats(bs->cs, "random_misc");
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRGP4 $643
ARGP4
ADDRLP4 156
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 156
INDIRI4
ASGNI4
line 1208
;1208:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $758
JUMPV
LABELV $755
line 1209
;1209:	{
line 1211
;1210:		//
;1211:		BotAI_BotInitialChat(bs, "random_misc",
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 160
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 164
ADDRGP4 BotMapTitle
CALLP4
ASGNP4
ADDRLP4 168
ADDRGP4 BotRandomWeaponName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $643
ARGP4
ADDRLP4 160
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 172
ADDRGP4 $323
ASGNP4
ADDRLP4 172
INDIRP4
ARGP4
ADDRLP4 172
INDIRP4
ARGP4
ADDRLP4 164
INDIRP4
ARGP4
ADDRLP4 168
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1219
;1212:					BotRandomOpponentName(bs),	// 0
;1213:					name,						// 1
;1214:					"[invalid var]",			// 2
;1215:					"[invalid var]",			// 3
;1216:					BotMapTitle(),				// 4
;1217:					BotRandomWeaponName(),		// 5
;1218:					NULL);
;1219:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1220
;1220:	}
LABELV $756
line 1208
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $758
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $755
line 1221
;1221:	num = trap_BotNumInitialChats(bs->cs, "random_insult");
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRGP4 $644
ARGP4
ADDRLP4 160
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 160
INDIRI4
ASGNI4
line 1222
;1222:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $762
JUMPV
LABELV $759
line 1223
;1223:	{
line 1224
;1224:		BotAI_BotInitialChat(bs, "random_insult",
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 164
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 168
ADDRGP4 BotMapTitle
CALLP4
ASGNP4
ADDRLP4 172
ADDRGP4 BotRandomWeaponName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $644
ARGP4
ADDRLP4 164
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 176
ADDRGP4 $323
ASGNP4
ADDRLP4 176
INDIRP4
ARGP4
ADDRLP4 176
INDIRP4
ARGP4
ADDRLP4 168
INDIRP4
ARGP4
ADDRLP4 172
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1232
;1225:					BotRandomOpponentName(bs),	// 0
;1226:					name,						// 1
;1227:					"[invalid var]",			// 2
;1228:					"[invalid var]",			// 3
;1229:					BotMapTitle(),				// 4
;1230:					BotRandomWeaponName(),		// 5
;1231:					NULL);
;1232:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1233
;1233:	}
LABELV $760
line 1222
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $762
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $759
line 1234
;1234:}
LABELV $646
endproc BotChatTest 180 36
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
import notleader
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
LABELV $644
byte 1 114
byte 1 97
byte 1 110
byte 1 100
byte 1 111
byte 1 109
byte 1 95
byte 1 105
byte 1 110
byte 1 115
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $643
byte 1 114
byte 1 97
byte 1 110
byte 1 100
byte 1 111
byte 1 109
byte 1 95
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 0
align 1
LABELV $607
byte 1 104
byte 1 105
byte 1 116
byte 1 95
byte 1 110
byte 1 111
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $578
byte 1 104
byte 1 105
byte 1 116
byte 1 95
byte 1 110
byte 1 111
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $545
byte 1 104
byte 1 105
byte 1 116
byte 1 95
byte 1 116
byte 1 97
byte 1 108
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $517
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 95
byte 1 115
byte 1 117
byte 1 105
byte 1 99
byte 1 105
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $516
byte 1 0
align 1
LABELV $492
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 95
byte 1 112
byte 1 114
byte 1 97
byte 1 105
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $491
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 95
byte 1 105
byte 1 110
byte 1 115
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $488
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 95
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $485
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 95
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 0
align 1
LABELV $482
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 95
byte 1 103
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $477
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 109
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $453
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 112
byte 1 114
byte 1 97
byte 1 105
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $452
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 105
byte 1 110
byte 1 115
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $449
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 98
byte 1 102
byte 1 103
byte 1 0
align 1
LABELV $448
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 0
align 1
LABELV $445
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 103
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $437
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $434
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 115
byte 1 117
byte 1 105
byte 1 99
byte 1 105
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $426
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 99
byte 1 114
byte 1 97
byte 1 116
byte 1 101
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $423
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 108
byte 1 97
byte 1 118
byte 1 97
byte 1 0
align 1
LABELV $420
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 115
byte 1 108
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $417
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 100
byte 1 114
byte 1 111
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $412
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 109
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $407
byte 1 91
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 93
byte 1 0
align 1
LABELV $389
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 95
byte 1 101
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $388
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 95
byte 1 101
byte 1 110
byte 1 100
byte 1 95
byte 1 108
byte 1 111
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $385
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 95
byte 1 101
byte 1 110
byte 1 100
byte 1 95
byte 1 118
byte 1 105
byte 1 99
byte 1 116
byte 1 111
byte 1 114
byte 1 121
byte 1 0
align 1
LABELV $361
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $341
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 95
byte 1 101
byte 1 120
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $323
byte 1 91
byte 1 105
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 118
byte 1 97
byte 1 114
byte 1 93
byte 1 0
align 1
LABELV $322
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 95
byte 1 101
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $242
byte 1 91
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 93
byte 1 0
align 1
LABELV $240
byte 1 77
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 76
byte 1 97
byte 1 117
byte 1 110
byte 1 99
byte 1 104
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $238
byte 1 102
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $236
byte 1 70
byte 1 105
byte 1 114
byte 1 101
byte 1 98
byte 1 97
byte 1 108
byte 1 108
byte 1 32
byte 1 76
byte 1 97
byte 1 117
byte 1 110
byte 1 99
byte 1 104
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $234
byte 1 99
byte 1 108
byte 1 97
byte 1 119
byte 1 0
align 1
LABELV $232
byte 1 71
byte 1 114
byte 1 97
byte 1 112
byte 1 112
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $230
byte 1 66
byte 1 70
byte 1 71
byte 1 49
byte 1 48
byte 1 75
byte 1 0
align 1
LABELV $228
byte 1 76
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 71
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $226
byte 1 82
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $224
byte 1 80
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $222
byte 1 82
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 32
byte 1 76
byte 1 97
byte 1 117
byte 1 110
byte 1 99
byte 1 104
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $220
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 76
byte 1 97
byte 1 117
byte 1 110
byte 1 99
byte 1 104
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $218
byte 1 77
byte 1 97
byte 1 99
byte 1 104
byte 1 105
byte 1 110
byte 1 101
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $216
byte 1 71
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $214
byte 1 83
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $208
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $107
byte 1 116
byte 1 0
align 1
LABELV $103
byte 1 110
byte 1 0
align 1
LABELV $96
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
