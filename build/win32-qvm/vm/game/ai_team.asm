export BotOwnFlagStatus
code
proc BotOwnFlagStatus 4 4
file "..\..\..\..\code\game\ai_team.c"
line 53
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:
;4:/*****************************************************************************
;5: * name:		ai_team.c
;6: *
;7: * desc:		Quake3 bot AI
;8: *
;9: * $Archive: /MissionPack/code/game/ai_team.c $
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
;30:#include "ai_vcmd.h"
;31:
;32:#include "match.h"
;33:#include "inv.h"	// JUHOX: for MODELINDEX_TELEPORTER
;34:
;35:// for the voice chats
;36:#include "../../ui/menudef.h"
;37:
;38://ctf task preferences for a client
;39:typedef struct bot_ctftaskpreference_s
;40:{
;41:	char		name[36];
;42:	int			preference;
;43:} bot_ctftaskpreference_t;
;44:
;45:bot_ctftaskpreference_t ctftaskpreferences[MAX_CLIENTS];
;46:
;47:
;48:/*
;49:==================
;50:JUHOX: BotOwnFlagStatus
;51:==================
;52:*/
;53:flagStatus_t BotOwnFlagStatus(bot_state_t* bs) {
line 54
;54:	return Team_GetFlagStatus(bs->cur_ps.persistant[PERS_TEAM]);
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 Team_GetFlagStatus
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $92
endproc BotOwnFlagStatus 4 4
export BotEnemyFlagStatus
proc BotEnemyFlagStatus 8 4
line 62
;55:}
;56:
;57:/*
;58:==================
;59:JUHOX: BotEnemyFlagStatus
;60:==================
;61:*/
;62:flagStatus_t BotEnemyFlagStatus(bot_state_t* bs) {
line 63
;63:	return Team_GetFlagStatus(OtherTeam(bs->cur_ps.persistant[PERS_TEAM]));
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 OtherTeam
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 Team_GetFlagStatus
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
RETI4
LABELV $93
endproc BotEnemyFlagStatus 8 4
export BotGetHomeBase
proc BotGetHomeBase 8 0
line 71
;64:}
;65:
;66:/*
;67:==================
;68:JUHOX: BotGetHomeBase
;69:==================
;70:*/
;71:const bot_goal_t* BotGetHomeBase(bot_state_t* bs) {
line 72
;72:	switch (bs->cur_ps.persistant[PERS_TEAM]) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $98
ADDRLP4 0
INDIRI4
CNSTI4 2
EQI4 $99
ADDRGP4 $95
JUMPV
LABELV $98
line 74
;73:	case TEAM_RED:
;74:		return &ctf_redflag;
ADDRGP4 ctf_redflag
RETP4
ADDRGP4 $94
JUMPV
LABELV $99
LABELV $95
line 77
;75:	case TEAM_BLUE:
;76:	default:
;77:		return &ctf_blueflag;
ADDRGP4 ctf_blueflag
RETP4
LABELV $94
endproc BotGetHomeBase 8 0
export BotGetEnemyBase
proc BotGetEnemyBase 8 0
line 86
;78:	}
;79:}
;80:
;81:/*
;82:==================
;83:JUHOX: BotGetEnemyBase
;84:==================
;85:*/
;86:const bot_goal_t* BotGetEnemyBase(bot_state_t* bs) {
line 87
;87:	switch (bs->cur_ps.persistant[PERS_TEAM]) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $104
ADDRLP4 0
INDIRI4
CNSTI4 2
EQI4 $105
ADDRGP4 $101
JUMPV
LABELV $104
line 89
;88:	case TEAM_RED:
;89:		return &ctf_blueflag;
ADDRGP4 ctf_blueflag
RETP4
ADDRGP4 $100
JUMPV
LABELV $105
LABELV $101
line 92
;90:	case TEAM_BLUE:
;91:	default:
;92:		return &ctf_redflag;
ADDRGP4 ctf_redflag
RETP4
LABELV $100
endproc BotGetEnemyBase 8 0
export BotTeamleaderReachable
proc BotTeamleaderReachable 0 0
line 131
;93:	}
;94:}
;95:
;96:/*
;97:==================
;98:BotValidTeamLeader
;99:==================
;100:*/
;101:// JUHOX: BotValidTeamLeader() no longer needed
;102:#if 0
;103:int BotValidTeamLeader(bot_state_t *bs) {
;104:#if !RESPAWN_DELAY	// JUHOX: don't accept dead teamleaders
;105:	if (!strlen(bs->teamleader)) return qfalse;
;106:	if (ClientFromName(bs->teamleader) == -1) return qfalse;
;107:	return qtrue;
;108:#else
;109:	/*
;110:	int client;
;111:	playerState_t ps;
;112:
;113:	if (!bs->teamleader[0]) return qfalse;
;114:	client = ClientFromName(bs->teamleader);
;115:	if (client < 0) return qfalse;
;116:	if (!BotAI_GetClientState(client, &ps)) return qfalse;
;117:	if (ps.stats[STAT_HEALTH] > 0) return qtrue;
;118:	if (ps.stats[STAT_RESPAWN_TIMER] < 10) return qtrue;
;119:	return qfalse;
;120:	*/
;121:	return bs->leader >= 0;
;122:#endif
;123:}
;124:#endif
;125:
;126:/*
;127:==================
;128:JUHOX: BotTeamleaderReachable
;129:==================
;130:*/
;131:void BotTeamleaderReachable(bot_state_t* bs) {
line 132
;132:	bs->teamleadernotreachable = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 11864
ADDP4
CNSTI4 0
ASGNI4
line 133
;133:	bs->teamleaderreachable_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 11868
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 134
;134:	bs->travelLavaAndSlime_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 5988
ADDP4
CNSTF4 0
ASGNF4
line 135
;135:}
LABELV $106
endproc BotTeamleaderReachable 0 0
export BotTeamleaderNotReachable
proc BotTeamleaderNotReachable 0 4
line 142
;136:
;137:/*
;138:==================
;139:JUHOX: BotTeamleaderNotReachable
;140:==================
;141:*/
;142:void BotTeamleaderNotReachable(bot_state_t* bs) {
line 143
;143:	bs->teamleadernotreachable = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 11864
ADDP4
CNSTI4 1
ASGNI4
line 144
;144:	if (bs->teamleaderreachable_time < FloatTime() - 10) {
ADDRFP4 0
INDIRP4
CNSTI4 11868
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1092616192
SUBF4
GEF4 $108
line 145
;145:		if (bs->cur_ps.stats[STAT_HOLDABLE_ITEM] == MODELINDEX_TELEPORTER) {
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 26
NEI4 $110
line 146
;146:			BotTeamleaderReachable(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotTeamleaderReachable
CALLV
pop
line 147
;147:			trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 148
;148:		}
ADDRGP4 $111
JUMPV
LABELV $110
line 149
;149:		else {
line 150
;150:			bs->travelLavaAndSlime_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 5988
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 151
;151:		}
LABELV $111
line 152
;152:	}
LABELV $108
line 153
;153:}
LABELV $107
endproc BotTeamleaderNotReachable 0 4
bss
align 4
LABELV $113
skip 4
export BotNumTeamMates
code
proc BotNumTeamMates 1060 12
line 160
;154:
;155:/*
;156:==================
;157:BotNumTeamMates
;158:==================
;159:*/
;160:int BotNumTeamMates(bot_state_t *bs) {
line 165
;161:	int i, numplayers;
;162:	char buf[MAX_INFO_STRING];
;163:	static int maxclients;
;164:
;165:	if (!maxclients)
ADDRGP4 $113
INDIRI4
CNSTI4 0
NEI4 $114
line 166
;166:		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
ADDRGP4 $116
ARGP4
ADDRLP4 1032
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 $113
ADDRLP4 1032
INDIRI4
ASGNI4
LABELV $114
line 168
;167:
;168:	numplayers = 0;
ADDRLP4 1028
CNSTI4 0
ASGNI4
line 169
;169:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $120
JUMPV
LABELV $117
line 170
;170:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
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
line 172
;171:		//if no config string or no name
;172:		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n"))) continue;
ADDRLP4 4
ARGP4
ADDRLP4 1036
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
EQI4 $124
ADDRLP4 4
ARGP4
ADDRGP4 $123
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
NEI4 $121
LABELV $124
ADDRGP4 $118
JUMPV
LABELV $121
line 174
;173:		//skip spectators
;174:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) continue;
ADDRLP4 4
ARGP4
ADDRGP4 $127
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
NEI4 $125
ADDRGP4 $118
JUMPV
LABELV $125
line 176
;175:		//
;176:		if (BotSameTeam(bs, i)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1056
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
EQI4 $128
line 177
;177:			numplayers++;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 178
;178:		}
LABELV $128
line 179
;179:	}
LABELV $118
line 169
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $120
ADDRLP4 0
INDIRI4
ADDRGP4 $113
INDIRI4
GEI4 $130
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $117
LABELV $130
line 180
;180:	return numplayers;
ADDRLP4 1028
INDIRI4
RETI4
LABELV $112
endproc BotNumTeamMates 1060 12
export BotGetNextPlayer
proc BotGetNextPlayer 12 8
line 191
;181:}
;182:
;183:/*
;184:==================
;185:JUHOX: BotGetNextPlayer
;186:- returns -1 if there are no more players
;187:- does not return the bot itself (if bs != NULL)
;188:- use lastPlayer=-1 for first call
;189:==================
;190:*/
;191:int BotGetNextPlayer(bot_state_t* bs, int lastPlayer, playerState_t* ps) {
line 195
;192:	int currentClient;
;193:
;194:	for (
;195:		currentClient = lastPlayer + 1;
ADDRLP4 0
ADDRFP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $135
JUMPV
LABELV $132
line 198
;196:		currentClient < level.maxclients;
;197:		currentClient++
;198:	) {
line 199
;199:		if (bs && bs->entitynum == currentClient) continue;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $137
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $137
ADDRGP4 $133
JUMPV
LABELV $137
line 200
;200:		if (!g_entities[currentClient].inuse) continue;
ADDRLP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $139
ADDRGP4 $133
JUMPV
LABELV $139
line 201
;201:		if (!g_entities[currentClient].client) continue;
ADDRLP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $142
ADDRGP4 $133
JUMPV
LABELV $142
line 202
;202:		if (g_entities[currentClient].client->pers.connected != CON_CONNECTED) continue;
ADDRLP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $145
ADDRGP4 $133
JUMPV
LABELV $145
line 203
;203:		if (g_entities[currentClient].client->sess.sessionTeam == TEAM_SPECTATOR) continue;
ADDRLP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 3
NEI4 $148
ADDRGP4 $133
JUMPV
LABELV $148
line 204
;204:		if (g_entities[currentClient].client->tssSafetyMode) continue;
ADDRLP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 768
ADDP4
INDIRI4
CNSTI4 0
EQI4 $151
ADDRGP4 $133
JUMPV
LABELV $151
line 205
;205:		if (!BotAI_GetClientState(currentClient, ps)) continue;
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BotAI_GetClientState
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $154
ADDRGP4 $133
JUMPV
LABELV $154
line 206
;206:		return currentClient;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $131
JUMPV
LABELV $133
line 197
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $135
line 196
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $132
line 208
;207:	}
;208:	return -1;
CNSTI4 -1
RETI4
LABELV $131
endproc BotGetNextPlayer 12 8
export BotGetNextPlayerOrMonster
proc BotGetNextPlayerOrMonster 12 12
line 219
;209:}
;210:
;211:/*
;212:==================
;213:JUHOX: BotGetNextPlayerOrMonster
;214:- returns -1 if there are no more players
;215:- does not return the bot itself (if bs != NULL)
;216:- use lastPlayer=-1 for first call
;217:==================
;218:*/
;219:int BotGetNextPlayerOrMonster(bot_state_t* bs, int lastPlayer, playerState_t* ps) {
line 222
;220:	int currentClient;
;221:
;222:	if (lastPlayer < MAX_CLIENTS) {
ADDRFP4 4
INDIRI4
CNSTI4 64
GEI4 $157
line 223
;223:		lastPlayer = BotGetNextPlayer(bs, lastPlayer, ps);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 BotGetNextPlayer
CALLI4
ASGNI4
ADDRFP4 4
ADDRLP4 4
INDIRI4
ASGNI4
line 224
;224:		if (lastPlayer >= 0) return lastPlayer;
ADDRFP4 4
INDIRI4
CNSTI4 0
LTI4 $159
ADDRFP4 4
INDIRI4
RETI4
ADDRGP4 $156
JUMPV
LABELV $159
line 225
;225:		lastPlayer = MAX_CLIENTS - 1;
ADDRFP4 4
CNSTI4 63
ASGNI4
line 226
;226:	}
LABELV $157
line 228
;227:	for (
;228:		currentClient = lastPlayer + 1;
ADDRLP4 0
ADDRFP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $164
JUMPV
LABELV $161
line 231
;229:		currentClient < level.num_entities;
;230:		currentClient++
;231:	) {
line 232
;232:		if (bs && bs->entitynum == currentClient) continue;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $166
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $166
ADDRGP4 $162
JUMPV
LABELV $166
line 233
;233:		if (!BotAI_GetClientState(currentClient, ps)) continue;
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BotAI_GetClientState
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $168
ADDRGP4 $162
JUMPV
LABELV $168
line 234
;234:		return currentClient;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $156
JUMPV
LABELV $162
line 230
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $164
line 229
ADDRLP4 0
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $161
line 236
;235:	}
;236:	return -1;
CNSTI4 -1
RETI4
LABELV $156
endproc BotGetNextPlayerOrMonster 12 12
export BotGetNextTeamMate
proc BotGetNextTeamMate 8 12
line 247
;237:}
;238:
;239:/*
;240:==================
;241:JUHOX: BotGetNextTeamMate
;242:- returns -1 if there are no more team mates
;243:- does not return the bot itself
;244:- use lastTeamMate=-1 for first call
;245:==================
;246:*/
;247:int BotGetNextTeamMate(bot_state_t* bs, int lastTeamMate, playerState_t* ps) {
line 250
;248:	int player;
;249:
;250:	if (gametype < GT_TEAM) return -1;
ADDRGP4 gametype
INDIRI4
CNSTI4 3
GEI4 $171
CNSTI4 -1
RETI4
ADDRGP4 $170
JUMPV
LABELV $171
line 252
;251:
;252:	for (player = lastTeamMate; (player = BotGetNextPlayer(bs, player, ps)) >= 0;) {
ADDRLP4 0
ADDRFP4 4
INDIRI4
ASGNI4
ADDRGP4 $176
JUMPV
LABELV $173
line 253
;253:		if (bs->cur_ps.persistant[PERS_TEAM] == ps->persistant[PERS_TEAM]) {
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
NEI4 $177
line 254
;254:			return player;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $170
JUMPV
LABELV $177
line 256
;255:		}
;256:	}
LABELV $174
line 252
LABELV $176
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 BotGetNextPlayer
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $173
line 257
;257:	return -1;
CNSTI4 -1
RETI4
LABELV $170
endproc BotGetNextTeamMate 8 12
export BotDetermineVisibleTeammates
proc BotDetermineVisibleTeammates 492 12
line 265
;258:}
;259:
;260:/*
;261:==================
;262:JUHOX: BotDetermineVisibleTeammates
;263:==================
;264:*/
;265:void BotDetermineVisibleTeammates(bot_state_t* bs) {
line 269
;266:	int teammate;
;267:	playerState_t ps;
;268:
;269:	if (gametype < GT_TEAM) {
ADDRGP4 gametype
INDIRI4
CNSTI4 3
GEI4 $180
line 270
;270:		bs->numvisteammates = 0;
ADDRFP4 0
INDIRP4
CNSTI4 12180
ADDP4
CNSTI4 0
ASGNI4
line 271
;271:		return;
ADDRGP4 $179
JUMPV
LABELV $180
line 273
;272:	}
;273:	if (FloatTime() < bs->visteammates_time) return;
ADDRGP4 floattime
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 12176
ADDP4
INDIRF4
GEF4 $182
ADDRGP4 $179
JUMPV
LABELV $182
line 274
;274:	bs->visteammates_time = FloatTime() + 1 + random();
ADDRLP4 472
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRFP4 0
INDIRP4
CNSTI4 12176
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
ADDF4
ADDRLP4 472
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 472
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
line 276
;275:
;276:	bs->numvisteammates = 0;
ADDRFP4 0
INDIRP4
CNSTI4 12180
ADDP4
CNSTI4 0
ASGNI4
line 277
;277:	for (teammate = -1; (teammate = BotGetNextTeamMate(bs, teammate, &ps)) >= 0;) {
ADDRLP4 0
CNSTI4 -1
ASGNI4
ADDRGP4 $187
JUMPV
LABELV $184
line 278
;278:		if (ps.stats[STAT_HEALTH] <= 0) continue;
ADDRLP4 4+184
INDIRI4
CNSTI4 0
GTI4 $188
ADDRGP4 $185
JUMPV
LABELV $188
line 279
;279:		if (DistanceSquared(bs->origin, ps.origin) > 1200.0*1200.0) continue;
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 4+20
ARGP4
ADDRLP4 476
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 476
INDIRF4
CNSTF4 1236256768
LEF4 $191
ADDRGP4 $185
JUMPV
LABELV $191
line 280
;280:		if (BotEntityVisible(&bs->cur_ps, 360, teammate)) {
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
ADDRLP4 480
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 480
INDIRF4
CNSTF4 0
EQF4 $194
line 281
;281:			bs->visteammates[bs->numvisteammates++] = teammate;
ADDRLP4 488
ADDRFP4 0
INDIRP4
CNSTI4 12180
ADDP4
ASGNP4
ADDRLP4 484
ADDRLP4 488
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 488
INDIRP4
ADDRLP4 484
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 484
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 12184
ADDP4
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 282
;282:		}
LABELV $194
line 283
;283:	}
LABELV $185
line 277
LABELV $187
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 476
ADDRGP4 BotGetNextTeamMate
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 476
INDIRI4
ASGNI4
ADDRLP4 476
INDIRI4
CNSTI4 0
GEI4 $184
line 284
;284:}
LABELV $179
endproc BotDetermineVisibleTeammates 492 12
export BotSetTeamMateTaskPreference
proc BotSetTeamMateTaskPreference 36 12
line 370
;285:
;286:#if 0	// JUHOX: BotClientTravelTimeToGoal() not needed
;287:/*
;288:==================
;289:BotClientTravelTimeToGoal
;290:==================
;291:*/
;292:int BotClientTravelTimeToGoal(int client, bot_goal_t *goal) {
;293:	playerState_t ps;
;294:	int areanum;
;295:
;296:	BotAI_GetClientState(client, &ps);
;297:	areanum = BotPointAreaNum(ps.origin);
;298:	if (!areanum) return 1;
;299:	return trap_AAS_AreaTravelTimeToGoalArea(areanum, ps.origin, goal->areanum, TFL_DEFAULT);
;300:}
;301:#endif
;302:
;303:#if 0	// JUHOX: BotSortTeamMatesByBaseTravelTime() not needed
;304:/*
;305:==================
;306:BotSortTeamMatesByBaseTravelTime
;307:==================
;308:*/
;309:int BotSortTeamMatesByBaseTravelTime(bot_state_t *bs, int *teammates, int maxteammates) {
;310:
;311:	int i, j, k, numteammates, traveltime;
;312:	char buf[MAX_INFO_STRING];
;313:	static int maxclients;
;314:	int traveltimes[MAX_CLIENTS];
;315:	bot_goal_t *goal = NULL;
;316:
;317:	if (gametype == GT_CTF || gametype == GT_1FCTF) {
;318:		if (BotTeam(bs) == TEAM_RED)
;319:			goal = &ctf_redflag;
;320:		else
;321:			goal = &ctf_blueflag;
;322:	}
;323:#ifdef MISSIONPACK
;324:	else {
;325:		if (BotTeam(bs) == TEAM_RED)
;326:			goal = &redobelisk;
;327:		else
;328:			goal = &blueobelisk;
;329:	}
;330:#endif
;331:	if (!maxclients)
;332:		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
;333:
;334:	numteammates = 0;
;335:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
;336:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
;337:		//if no config string or no name
;338:		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n"))) continue;
;339:		//skip spectators
;340:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) continue;
;341:		//
;342:		if (BotSameTeam(bs, i)) {
;343:			//
;344:			traveltime = BotClientTravelTimeToGoal(i, goal);
;345:			//
;346:			for (j = 0; j < numteammates; j++) {
;347:				if (traveltime < traveltimes[j]) {
;348:					for (k = numteammates; k > j; k--) {
;349:						traveltimes[k] = traveltimes[k-1];
;350:						teammates[k] = teammates[k-1];
;351:					}
;352:					break;
;353:				}
;354:			}
;355:			traveltimes[j] = traveltime;
;356:			teammates[j] = i;
;357:			numteammates++;
;358:			if (numteammates >= maxteammates) break;
;359:		}
;360:	}
;361:	return numteammates;
;362:}
;363:#endif
;364:
;365:/*
;366:==================
;367:BotSetTeamMateTaskPreference
;368:==================
;369:*/
;370:void BotSetTeamMateTaskPreference(bot_state_t *bs, int teammate, int preference) {
line 373
;371:	char teammatename[MAX_NETNAME];
;372:
;373:	ctftaskpreferences[teammate].preference = preference;
ADDRFP4 4
INDIRI4
CNSTI4 40
MULI4
ADDRGP4 ctftaskpreferences+36
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 374
;374:	ClientName(teammate, teammatename, sizeof(teammatename));
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 375
;375:	strcpy(ctftaskpreferences[teammate].name, teammatename);
ADDRFP4 4
INDIRI4
CNSTI4 40
MULI4
ADDRGP4 ctftaskpreferences
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 376
;376:}
LABELV $196
endproc BotSetTeamMateTaskPreference 36 12
export BotGetTeamMateTaskPreference
proc BotGetTeamMateTaskPreference 40 12
line 383
;377:
;378:/*
;379:==================
;380:BotGetTeamMateTaskPreference
;381:==================
;382:*/
;383:int BotGetTeamMateTaskPreference(bot_state_t *bs, int teammate) {
line 386
;384:	char teammatename[MAX_NETNAME];
;385:
;386:	if (!ctftaskpreferences[teammate].preference) return 0;
ADDRFP4 4
INDIRI4
CNSTI4 40
MULI4
ADDRGP4 ctftaskpreferences+36
ADDP4
INDIRI4
CNSTI4 0
NEI4 $199
CNSTI4 0
RETI4
ADDRGP4 $198
JUMPV
LABELV $199
line 387
;387:	ClientName(teammate, teammatename, sizeof(teammatename));
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 388
;388:	if (Q_stricmp(teammatename, ctftaskpreferences[teammate].name)) return 0;
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRI4
CNSTI4 40
MULI4
ADDRGP4 ctftaskpreferences
ADDP4
ARGP4
ADDRLP4 36
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $202
CNSTI4 0
RETI4
ADDRGP4 $198
JUMPV
LABELV $202
line 389
;389:	return ctftaskpreferences[teammate].preference;
ADDRFP4 4
INDIRI4
CNSTI4 40
MULI4
ADDRGP4 ctftaskpreferences+36
ADDP4
INDIRI4
RETI4
LABELV $198
endproc BotGetTeamMateTaskPreference 40 12
export BotSayTeamOrderAlways
proc BotSayTeamOrderAlways 548 20
line 437
;390:}
;391:
;392:#if 0	// JUHOX: BotSortTeamMatesByTaskPreference() not needed
;393:/*
;394:==================
;395:BotSortTeamMatesByTaskPreference
;396:==================
;397:*/
;398:int BotSortTeamMatesByTaskPreference(bot_state_t *bs, int *teammates, int numteammates) {
;399:	int defenders[MAX_CLIENTS], numdefenders;
;400:	int attackers[MAX_CLIENTS], numattackers;
;401:	int roamers[MAX_CLIENTS], numroamers;
;402:	int i, preference;
;403:
;404:	numdefenders = numattackers = numroamers = 0;
;405:	for (i = 0; i < numteammates; i++) {
;406:		preference = BotGetTeamMateTaskPreference(bs, teammates[i]);
;407:		if (preference & TEAMTP_DEFENDER) {
;408:			defenders[numdefenders++] = teammates[i];
;409:		}
;410:		else if (preference & TEAMTP_ATTACKER) {
;411:			attackers[numattackers++] = teammates[i];
;412:		}
;413:		else {
;414:			roamers[numroamers++] = teammates[i];
;415:		}
;416:	}
;417:	numteammates = 0;
;418:	//defenders at the front of the list
;419:	memcpy(&teammates[numteammates], defenders, numdefenders * sizeof(int));
;420:	numteammates += numdefenders;
;421:	//roamers in the middle
;422:	memcpy(&teammates[numteammates], roamers, numroamers * sizeof(int));
;423:	numteammates += numroamers;
;424:	//attacker in the back of the list
;425:	memcpy(&teammates[numteammates], attackers, numattackers * sizeof(int));
;426:	numteammates += numattackers;
;427:
;428:	return numteammates;
;429:}
;430:#endif
;431:
;432:/*
;433:==================
;434:BotSayTeamOrders
;435:==================
;436:*/
;437:void BotSayTeamOrderAlways(bot_state_t *bs, int toclient) {
line 443
;438:	char teamchat[MAX_MESSAGE_SIZE];
;439:	char buf[MAX_MESSAGE_SIZE];
;440:	char name[MAX_NETNAME];
;441:
;442:	//if the bot is talking to itself
;443:	if (bs->client == toclient) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $206
line 445
;444:		//don't show the message just put it in the console message queue
;445:		trap_BotGetChatMessage(bs->cs, buf, sizeof(buf));
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRLP4 256
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGetChatMessage
CALLV
pop
line 446
;446:		ClientName(bs->client, name, sizeof(name));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 512
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 447
;447:		Com_sprintf(teamchat, sizeof(teamchat), EC"(%s"EC")"EC": %s", name, buf);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $208
ARGP4
ADDRLP4 512
ARGP4
ADDRLP4 256
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 448
;448:		trap_BotQueueConsoleMessage(bs->cs, CMS_CHAT, teamchat);
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotQueueConsoleMessage
CALLV
pop
line 449
;449:	}
ADDRGP4 $207
JUMPV
LABELV $206
line 450
;450:	else {
line 451
;451:		trap_BotEnterChat(bs->cs, toclient, CHAT_TELL);
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 452
;452:	}
LABELV $207
line 453
;453:}
LABELV $205
endproc BotSayTeamOrderAlways 548 20
export BotSayTeamOrder
proc BotSayTeamOrder 0 8
line 460
;454:
;455:/*
;456:==================
;457:BotSayTeamOrders
;458:==================
;459:*/
;460:void BotSayTeamOrder(bot_state_t *bs, int toclient) {
line 467
;461:#ifdef MISSIONPACK
;462:	// voice chats only
;463:	char buf[MAX_MESSAGE_SIZE];
;464:
;465:	trap_BotGetChatMessage(bs->cs, buf, sizeof(buf));
;466:#else
;467:	BotSayTeamOrderAlways(bs, toclient);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrderAlways
CALLV
pop
line 469
;468:#endif
;469:}
LABELV $209
endproc BotSayTeamOrder 0 8
export BotVoiceChat
proc BotVoiceChat 0 0
line 476
;470:
;471:/*
;472:==================
;473:BotVoiceChat
;474:==================
;475:*/
;476:void BotVoiceChat(bot_state_t *bs, int toclient, char *voicechat) {
line 485
;477:#ifdef MISSIONPACK
;478:	if (toclient == -1)
;479:		// voice only say team
;480:		trap_EA_Command(bs->client, va("vsay_team %s", voicechat));
;481:	else
;482:		// voice only tell single player
;483:		trap_EA_Command(bs->client, va("vtell %d %s", toclient, voicechat));
;484:#endif
;485:}
LABELV $210
endproc BotVoiceChat 0 0
export BotVoiceChatOnly
proc BotVoiceChatOnly 0 0
line 492
;486:
;487:/*
;488:==================
;489:BotVoiceChatOnly
;490:==================
;491:*/
;492:void BotVoiceChatOnly(bot_state_t *bs, int toclient, char *voicechat) {
line 501
;493:#ifdef MISSIONPACK
;494:	if (toclient == -1)
;495:		// voice only say team
;496:		trap_EA_Command(bs->client, va("vosay_team %s", voicechat));
;497:	else
;498:		// voice only tell single player
;499:		trap_EA_Command(bs->client, va("votell %d %s", toclient, voicechat));
;500:#endif
;501:}
LABELV $211
endproc BotVoiceChatOnly 0 0
export BotSayVoiceTeamOrder
proc BotSayVoiceTeamOrder 0 0
line 508
;502:
;503:/*
;504:==================
;505:BotSayVoiceTeamOrder
;506:==================
;507:*/
;508:void BotSayVoiceTeamOrder(bot_state_t *bs, int toclient, char *voicechat) {
line 512
;509:#ifdef MISSIONPACK
;510:	BotVoiceChat(bs, toclient, voicechat);
;511:#endif
;512:}
LABELV $212
endproc BotSayVoiceTeamOrder 0 0
export BotFindTeamMateInFront
proc BotFindTeamMateInFront 564 16
line 519
;513:
;514:/*
;515:==================
;516:JUHOX: BotFindTeamMateInFront
;517:==================
;518:*/
;519:int BotFindTeamMateInFront(bot_state_t* bs, int leader, const int* teamMates, int numTeamMates) {
line 528
;520:	int bestTravelTime;
;521:	int bestTeamMate;
;522:	int botLeaderTravelTime;
;523:	int numTeamMatesNearToLeader;
;524:	int leaderArea;
;525:	playerState_t ps;
;526:	int i;
;527:
;528:	if (!BotAI_GetClientState(leader, &ps)) return -1;
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 492
ADDRGP4 BotAI_GetClientState
CALLI4
ASGNI4
ADDRLP4 492
INDIRI4
CNSTI4 0
NEI4 $214
CNSTI4 -1
RETI4
ADDRGP4 $213
JUMPV
LABELV $214
line 529
;529:	if (ps.stats[STAT_HEALTH] <= 0) return -1;
ADDRLP4 0+184
INDIRI4
CNSTI4 0
GTI4 $216
CNSTI4 -1
RETI4
ADDRGP4 $213
JUMPV
LABELV $216
line 530
;530:	if (bs->areanum <= 0) return leader;
ADDRFP4 0
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
CNSTI4 0
GTI4 $219
ADDRFP4 4
INDIRI4
RETI4
ADDRGP4 $213
JUMPV
LABELV $219
line 531
;531:	if (!trap_AAS_AreaReachability(bs->areanum)) return leader;
ADDRFP4 0
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
ARGI4
ADDRLP4 496
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 496
INDIRI4
CNSTI4 0
NEI4 $221
ADDRFP4 4
INDIRI4
RETI4
ADDRGP4 $213
JUMPV
LABELV $221
line 533
;532:
;533:	if (numTeamMates <= 0) return leader;
ADDRFP4 12
INDIRI4
CNSTI4 0
GTI4 $223
ADDRFP4 4
INDIRI4
RETI4
ADDRGP4 $213
JUMPV
LABELV $223
line 537
;534:
;535:#if MONSTER_MODE
;536:	if (
;537:		g_gametype.integer == GT_STU &&
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
NEI4 $225
ADDRGP4 g_artefacts+12
INDIRI4
CNSTI4 999
LTI4 $225
ADDRGP4 level+96
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+100-4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $225
line 540
;538:		g_artefacts.integer >= 999 &&
;539:		level.sortedClients[level.numPlayingClients-1] == bs->client
;540:	) {
line 541
;541:		return leader;
ADDRFP4 4
INDIRI4
RETI4
ADDRGP4 $213
JUMPV
LABELV $225
line 545
;542:	}
;543:#endif
;544:
;545:	leaderArea = BotPointAreaNum(ps.origin);
ADDRLP4 0+20
ARGP4
ADDRLP4 500
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 480
ADDRLP4 500
INDIRI4
ASGNI4
line 546
;546:	if (leaderArea <= 0 || !trap_AAS_AreaReachability(leaderArea)) {
ADDRLP4 480
INDIRI4
CNSTI4 0
LEI4 $235
ADDRLP4 480
INDIRI4
ARGI4
ADDRLP4 508
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 508
INDIRI4
CNSTI4 0
NEI4 $233
LABELV $235
line 547
;547:		BotTeamleaderNotReachable(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotTeamleaderNotReachable
CALLV
pop
line 548
;548:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $213
JUMPV
LABELV $233
line 550
;549:	}
;550:	botLeaderTravelTime = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, leaderArea, bs->tfl);
ADDRLP4 512
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 512
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
ARGI4
ADDRLP4 512
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 480
INDIRI4
ARGI4
ADDRLP4 512
INDIRP4
CNSTI4 5984
ADDP4
INDIRI4
ARGI4
ADDRLP4 516
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 476
ADDRLP4 516
INDIRI4
ASGNI4
line 551
;551:	if (botLeaderTravelTime <= 0) {
ADDRLP4 476
INDIRI4
CNSTI4 0
GTI4 $236
line 552
;552:		BotTeamleaderNotReachable(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotTeamleaderNotReachable
CALLV
pop
line 553
;553:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $213
JUMPV
LABELV $236
line 555
;554:	}
;555:	BotTeamleaderReachable(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotTeamleaderReachable
CALLV
pop
line 558
;556:	//if (botLeaderTravelTime > 600) return leader;
;557:
;558:	bestTeamMate = leader;
ADDRLP4 484
ADDRFP4 4
INDIRI4
ASGNI4
line 559
;559:	bestTravelTime = botLeaderTravelTime;
ADDRLP4 472
ADDRLP4 476
INDIRI4
ASGNI4
line 560
;560:	numTeamMatesNearToLeader = 0;
ADDRLP4 488
CNSTI4 0
ASGNI4
line 562
;561:
;562:	for (i = 0; i < numTeamMates; i++) {
ADDRLP4 468
CNSTI4 0
ASGNI4
ADDRGP4 $241
JUMPV
LABELV $238
line 566
;563:		int travelTime;
;564:		int teamMateArea;
;565:
;566:		if (!BotAI_GetClientState(teamMates[i], &ps)) continue;
ADDRLP4 468
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 528
ADDRGP4 BotAI_GetClientState
CALLI4
ASGNI4
ADDRLP4 528
INDIRI4
CNSTI4 0
NEI4 $242
ADDRGP4 $239
JUMPV
LABELV $242
line 567
;567:		if (ps.stats[STAT_HEALTH] <= 0) continue;
ADDRLP4 0+184
INDIRI4
CNSTI4 0
GTI4 $244
ADDRGP4 $239
JUMPV
LABELV $244
line 568
;568:		teamMateArea = BotPointAreaNum(ps.origin);
ADDRLP4 0+20
ARGP4
ADDRLP4 532
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 524
ADDRLP4 532
INDIRI4
ASGNI4
line 569
;569:		if (teamMateArea <= 0 || !trap_AAS_AreaReachability(teamMateArea)) continue;
ADDRLP4 524
INDIRI4
CNSTI4 0
LEI4 $250
ADDRLP4 524
INDIRI4
ARGI4
ADDRLP4 540
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 540
INDIRI4
CNSTI4 0
NEI4 $248
LABELV $250
ADDRGP4 $239
JUMPV
LABELV $248
line 571
;570:
;571:		travelTime = trap_AAS_AreaTravelTimeToGoalArea(teamMateArea, ps.origin, leaderArea, TFL_DEFAULT);
ADDRLP4 524
INDIRI4
ARGI4
ADDRLP4 0+20
ARGP4
ADDRLP4 480
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 544
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 520
ADDRLP4 544
INDIRI4
ASGNI4
line 572
;572:		if (travelTime <= 0 || travelTime >= botLeaderTravelTime) continue;
ADDRLP4 520
INDIRI4
CNSTI4 0
LEI4 $254
ADDRLP4 520
INDIRI4
ADDRLP4 476
INDIRI4
LTI4 $252
LABELV $254
ADDRGP4 $239
JUMPV
LABELV $252
line 574
;573:
;574:		numTeamMatesNearToLeader++;
ADDRLP4 488
ADDRLP4 488
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 576
;575:
;576:		travelTime = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, teamMateArea, bs->tfl);
ADDRLP4 552
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 552
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
ARGI4
ADDRLP4 552
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 524
INDIRI4
ARGI4
ADDRLP4 552
INDIRP4
CNSTI4 5984
ADDP4
INDIRI4
ARGI4
ADDRLP4 556
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 520
ADDRLP4 556
INDIRI4
ASGNI4
line 577
;577:		if (travelTime <= 0 || travelTime >= bestTravelTime) continue;
ADDRLP4 520
INDIRI4
CNSTI4 0
LEI4 $257
ADDRLP4 520
INDIRI4
ADDRLP4 472
INDIRI4
LTI4 $255
LABELV $257
ADDRGP4 $239
JUMPV
LABELV $255
line 579
;578:
;579:		bestTeamMate = teamMates[i];
ADDRLP4 484
ADDRLP4 468
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRI4
ASGNI4
line 580
;580:		bestTravelTime = travelTime;
ADDRLP4 472
ADDRLP4 520
INDIRI4
ASGNI4
line 581
;581:	}
LABELV $239
line 562
ADDRLP4 468
ADDRLP4 468
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $241
ADDRLP4 468
INDIRI4
ADDRFP4 12
INDIRI4
LTI4 $238
line 583
;582:
;583:	if (botLeaderTravelTime > 200 * (numTeamMatesNearToLeader+1)) return leader;
ADDRLP4 476
INDIRI4
ADDRLP4 488
INDIRI4
CNSTI4 200
MULI4
CNSTI4 200
ADDI4
LEI4 $258
ADDRFP4 4
INDIRI4
RETI4
ADDRGP4 $213
JUMPV
LABELV $258
line 584
;584:	return bestTeamMate;
ADDRLP4 484
INDIRI4
RETI4
LABELV $213
endproc BotFindTeamMateInFront 564 16
export BotUpdateRescueSchedule
proc BotUpdateRescueSchedule 4672 16
line 611
;585:}
;586:
;587:/*
;588:==================
;589:JUHOX: BotUpdateRescueSchedule
;590:==================
;591:*/
;592:typedef struct {
;593:	float nextUpdate;
;594:	int team;
;595:	int numAssignments;
;596:	struct {
;597:		int guard;
;598:		int victim;
;599:	} assignments[MAX_CLIENTS];
;600:} rescueSchedule_t;
;601:static rescueSchedule_t rescueSchedule_red;
;602:static rescueSchedule_t rescueSchedule_blue;
;603:typedef struct {
;604:	int usecnt;
;605:	int clientnum;
;606:	int danger;
;607:	vec3_t origin;
;608:	int areanum;
;609:	int maxGuards;	// only valid for victims
;610:} rescuePlayerInfo_t;
;611:rescueSchedule_t* BotUpdateRescueSchedule(bot_state_t* bs) {
line 623
;612:	rescueSchedule_t* rs;
;613:	playerState_t ps;
;614:	int teammate;
;615:	int numVictims;
;616:	int numGuards;
;617:	int numTeammates;
;618:	int numActiveVictims;
;619:	int numActiveGuards;
;620:	rescuePlayerInfo_t victims[MAX_CLIENTS];
;621:	rescuePlayerInfo_t guards[MAX_CLIENTS];
;622:
;623:	if (g_gametype.integer < GT_TEAM) return NULL;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
GEI4 $264
CNSTP4 0
RETP4
ADDRGP4 $263
JUMPV
LABELV $264
line 625
;624:#if BOTS_USE_TSS
;625:	if (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_isValid)) return NULL;
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 4592
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 4592
INDIRI4
CNSTI4 0
EQI4 $267
CNSTP4 0
RETP4
ADDRGP4 $263
JUMPV
LABELV $267
line 628
;626:#endif
;627:
;628:	switch (bs->cur_ps.persistant[PERS_TEAM]) {
ADDRLP4 4596
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ASGNI4
ADDRLP4 4596
INDIRI4
CNSTI4 1
EQI4 $272
ADDRLP4 4596
INDIRI4
CNSTI4 2
EQI4 $273
ADDRGP4 $269
JUMPV
LABELV $272
line 630
;629:	case TEAM_RED:
;630:		rs = &rescueSchedule_red;
ADDRLP4 4572
ADDRGP4 rescueSchedule_red
ASGNP4
line 631
;631:		rs->team = TEAM_RED;
ADDRLP4 4572
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 1
ASGNI4
line 632
;632:		break;
ADDRGP4 $270
JUMPV
LABELV $273
line 634
;633:	case TEAM_BLUE:
;634:		rs = &rescueSchedule_blue;
ADDRLP4 4572
ADDRGP4 rescueSchedule_blue
ASGNP4
line 635
;635:		rs->team = TEAM_BLUE;
ADDRLP4 4572
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 2
ASGNI4
line 636
;636:		break;
ADDRGP4 $270
JUMPV
LABELV $269
line 638
;637:	default:
;638:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $263
JUMPV
LABELV $270
line 641
;639:	}
;640:
;641:	if (rs->nextUpdate > FloatTime()) return rs;
ADDRLP4 4572
INDIRP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $274
ADDRLP4 4572
INDIRP4
RETP4
ADDRGP4 $263
JUMPV
LABELV $274
line 642
;642:	rs->nextUpdate = FloatTime() + 1 + random();
ADDRLP4 4604
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 4572
INDIRP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
ADDF4
ADDRLP4 4604
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 4604
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
line 644
;643:
;644:	numVictims = numGuards = 0;
ADDRLP4 4608
CNSTI4 0
ASGNI4
ADDRLP4 4100
ADDRLP4 4608
INDIRI4
ASGNI4
ADDRLP4 4096
ADDRLP4 4608
INDIRI4
ASGNI4
line 645
;645:	numTeammates = BotNumTeamMates(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4612
ADDRGP4 BotNumTeamMates
CALLI4
ASGNI4
ADDRLP4 4588
ADDRLP4 4612
INDIRI4
ASGNI4
line 646
;646:	memset(victims, -1, sizeof(victims));
ADDRLP4 0
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 2048
ARGI4
ADDRGP4 memset
CALLP4
pop
line 647
;647:	memset(guards, -1, sizeof(guards));
ADDRLP4 2048
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 2048
ARGI4
ADDRGP4 memset
CALLP4
pop
line 648
;648:	for (teammate = -1; (teammate = BotGetNextPlayer(NULL, teammate, &ps)) >= 0;) {
ADDRLP4 4580
CNSTI4 -1
ASGNI4
ADDRGP4 $279
JUMPV
LABELV $276
line 653
;649:		int danger;
;650:		rescuePlayerInfo_t* rpi;
;651:		int areanum;
;652:
;653:		if (ps.stats[STAT_HEALTH] <= 0) continue;
ADDRLP4 4104+184
INDIRI4
CNSTI4 0
GTI4 $280
ADDRGP4 $277
JUMPV
LABELV $280
line 654
;654:		if (rs->team != ps.persistant[PERS_TEAM]) continue;
ADDRLP4 4572
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 4104+248+12
INDIRI4
EQI4 $283
ADDRGP4 $277
JUMPV
LABELV $283
line 656
;655:#if BOTS_USE_TSS
;656:		if (BG_TSS_GetPlayerInfo(&ps, TSSPI_isValid)) continue;	// TSS manages rescue in this case
ADDRLP4 4104
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 4628
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 4628
INDIRI4
CNSTI4 0
EQI4 $287
ADDRGP4 $277
JUMPV
LABELV $287
line 658
;657:#endif
;658:		areanum = BotPointAreaNum(ps.origin);
ADDRLP4 4104+20
ARGP4
ADDRLP4 4632
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 4620
ADDRLP4 4632
INDIRI4
ASGNI4
line 659
;659:		if (areanum <= 0) continue;
ADDRLP4 4620
INDIRI4
CNSTI4 0
GTI4 $290
ADDRGP4 $277
JUMPV
LABELV $290
line 660
;660:		if (!trap_AAS_AreaReachability(areanum)) continue;
ADDRLP4 4620
INDIRI4
ARGI4
ADDRLP4 4636
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 4636
INDIRI4
CNSTI4 0
NEI4 $292
ADDRGP4 $277
JUMPV
LABELV $292
line 662
;661:
;662:		danger = BotPlayerDanger(&ps);
ADDRLP4 4104
ARGP4
ADDRLP4 4640
ADDRGP4 BotPlayerDanger
CALLI4
ASGNI4
ADDRLP4 4624
ADDRLP4 4640
INDIRI4
ASGNI4
line 663
;663:		if (danger >= 15 || ps.powerups[PW_REDFLAG] || ps.powerups[PW_BLUEFLAG]) {
ADDRLP4 4624
INDIRI4
CNSTI4 15
GEI4 $301
ADDRLP4 4104+312+28
INDIRI4
CNSTI4 0
NEI4 $301
ADDRLP4 4104+312+32
INDIRI4
CNSTI4 0
EQI4 $294
LABELV $301
line 664
;664:			rpi = &victims[numVictims++];
ADDRLP4 4644
ADDRLP4 4096
INDIRI4
ASGNI4
ADDRLP4 4096
ADDRLP4 4644
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4616
ADDRLP4 4644
INDIRI4
CNSTI4 5
LSHI4
ADDRLP4 0
ADDP4
ASGNP4
line 665
;665:			if (gametype < GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
GEI4 $302
line 666
;666:				if (danger < 25) {
ADDRLP4 4624
INDIRI4
CNSTI4 25
GEI4 $304
line 667
;667:					rpi->maxGuards = 0;
ADDRLP4 4616
INDIRP4
CNSTI4 28
ADDP4
CNSTI4 0
ASGNI4
line 668
;668:				}
ADDRGP4 $295
JUMPV
LABELV $304
line 669
;669:				else if (danger < 37) {
ADDRLP4 4624
INDIRI4
CNSTI4 37
GEI4 $306
line 670
;670:					rpi->maxGuards = 1;
ADDRLP4 4616
INDIRP4
CNSTI4 28
ADDP4
CNSTI4 1
ASGNI4
line 671
;671:				}
ADDRGP4 $295
JUMPV
LABELV $306
line 672
;672:				else if (danger < 50) {
ADDRLP4 4624
INDIRI4
CNSTI4 50
GEI4 $308
line 673
;673:					rpi->maxGuards = 2;
ADDRLP4 4616
INDIRP4
CNSTI4 28
ADDP4
CNSTI4 2
ASGNI4
line 674
;674:				}
ADDRGP4 $295
JUMPV
LABELV $308
line 675
;675:				else {
line 676
;676:					rpi->maxGuards = 3;
ADDRLP4 4616
INDIRP4
CNSTI4 28
ADDP4
CNSTI4 3
ASGNI4
line 677
;677:				}
line 678
;678:			}
ADDRGP4 $295
JUMPV
LABELV $302
line 679
;679:			else {
line 681
;680:				if (
;681:					(
ADDRLP4 4104+312+28
INDIRI4
CNSTI4 0
NEI4 $317
ADDRLP4 4104+312+32
INDIRI4
CNSTI4 0
EQI4 $310
LABELV $317
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4648
ADDRGP4 BotOwnFlagStatus
CALLI4
ASGNI4
ADDRLP4 4648
INDIRI4
CNSTI4 0
EQI4 $318
ADDRLP4 4572
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ARGI4
ADDRLP4 4104+20
ARGP4
CNSTF4 1065353216
ARGF4
ADDRLP4 4652
ADDRGP4 NearHomeBase
CALLI4
ASGNI4
ADDRLP4 4652
INDIRI4
CNSTI4 0
NEI4 $310
LABELV $318
line 688
;682:						ps.powerups[PW_REDFLAG] || ps.powerups[PW_BLUEFLAG]
;683:					) &&
;684:					(
;685:						BotOwnFlagStatus(bs) == FLAG_ATBASE ||
;686:						!NearHomeBase(rs->team, ps.origin, 1)
;687:					)
;688:				) {
line 689
;689:					rpi->maxGuards = 1000;
ADDRLP4 4616
INDIRP4
CNSTI4 28
ADDP4
CNSTI4 1000
ASGNI4
line 690
;690:				}
ADDRGP4 $295
JUMPV
LABELV $310
line 691
;691:				else if (ps.powerups[PW_REDFLAG] || ps.powerups[PW_BLUEFLAG]) {
ADDRLP4 4104+312+28
INDIRI4
CNSTI4 0
NEI4 $325
ADDRLP4 4104+312+32
INDIRI4
CNSTI4 0
EQI4 $319
LABELV $325
line 692
;692:					rpi->maxGuards = numTeammates - 2;
ADDRLP4 4616
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 4588
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 693
;693:					if (rpi->maxGuards > 2) {
ADDRLP4 4616
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 2
LEI4 $295
line 694
;694:						rpi->maxGuards = 2;
ADDRLP4 4616
INDIRP4
CNSTI4 28
ADDP4
CNSTI4 2
ASGNI4
line 695
;695:					}
line 696
;696:				}
ADDRGP4 $295
JUMPV
LABELV $319
line 697
;697:				else if (danger >= 50 && BotEnemyFlagStatus(bs) == FLAG_TAKEN) {
ADDRLP4 4624
INDIRI4
CNSTI4 50
LTI4 $328
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4656
ADDRGP4 BotEnemyFlagStatus
CALLI4
ASGNI4
ADDRLP4 4656
INDIRI4
CNSTI4 1
NEI4 $328
line 698
;698:					rpi->maxGuards = 1;
ADDRLP4 4616
INDIRP4
CNSTI4 28
ADDP4
CNSTI4 1
ASGNI4
line 699
;699:				}
ADDRGP4 $295
JUMPV
LABELV $328
line 700
;700:				else {
line 701
;701:					rpi->maxGuards = 0;
ADDRLP4 4616
INDIRP4
CNSTI4 28
ADDP4
CNSTI4 0
ASGNI4
line 702
;702:				}
line 703
;703:			}
line 704
;704:		} else {
ADDRGP4 $295
JUMPV
LABELV $294
line 705
;705:			rpi = &guards[numGuards++];
ADDRLP4 4644
ADDRLP4 4100
INDIRI4
ASGNI4
ADDRLP4 4100
ADDRLP4 4644
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4616
ADDRLP4 4644
INDIRI4
CNSTI4 5
LSHI4
ADDRLP4 2048
ADDP4
ASGNP4
line 706
;706:		}
LABELV $295
line 708
;707:
;708:		rpi->usecnt = 0;
ADDRLP4 4616
INDIRP4
CNSTI4 0
ASGNI4
line 709
;709:		rpi->clientnum = teammate;
ADDRLP4 4616
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 4580
INDIRI4
ASGNI4
line 710
;710:		rpi->danger = danger;
ADDRLP4 4616
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 4624
INDIRI4
ASGNI4
line 711
;711:		VectorCopy(ps.origin, rpi->origin);
ADDRLP4 4616
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 4104+20
INDIRB
ASGNB 12
line 712
;712:		rpi->areanum = areanum;
ADDRLP4 4616
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 4620
INDIRI4
ASGNI4
line 713
;713:	}
LABELV $277
line 648
LABELV $279
CNSTP4 0
ARGP4
ADDRLP4 4580
INDIRI4
ARGI4
ADDRLP4 4104
ARGP4
ADDRLP4 4616
ADDRGP4 BotGetNextPlayer
CALLI4
ASGNI4
ADDRLP4 4580
ADDRLP4 4616
INDIRI4
ASGNI4
ADDRLP4 4616
INDIRI4
CNSTI4 0
GEI4 $276
line 715
;714:
;715:	rs->numAssignments = 0;
ADDRLP4 4572
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 0
ASGNI4
line 716
;716:	numActiveVictims = numVictims;
ADDRLP4 4576
ADDRLP4 4096
INDIRI4
ASGNI4
line 717
;717:	numActiveGuards = numGuards;
ADDRLP4 4584
ADDRLP4 4100
INDIRI4
ASGNI4
ADDRGP4 $332
JUMPV
LABELV $331
line 719
;718:
;719:	while (numActiveGuards > 0 && numActiveVictims > 0) {
line 727
;720:		int minusecnt;
;721:		int maxDanger;
;722:		rescuePlayerInfo_t* rpi;
;723:		int victim;
;724:		int guard, assignedGuard, leaderGuard;
;725:		int bestTravelTime;
;726:
;727:		minusecnt = 1000000;
ADDRLP4 4628
CNSTI4 1000000
ASGNI4
line 728
;728:		maxDanger = -1000000;
ADDRLP4 4636
CNSTI4 -1000000
ASGNI4
line 729
;729:		rpi = NULL;
ADDRLP4 4632
CNSTP4 0
ASGNP4
line 730
;730:		for (victim = 0; victim < numVictims; victim++) {
ADDRLP4 4620
CNSTI4 0
ASGNI4
ADDRGP4 $337
JUMPV
LABELV $334
line 731
;731:			if (victims[victim].usecnt < 0) continue;
ADDRLP4 4620
INDIRI4
CNSTI4 5
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
CNSTI4 0
GEI4 $338
ADDRGP4 $335
JUMPV
LABELV $338
line 732
;732:			if (victims[victim].usecnt > minusecnt) continue;
ADDRLP4 4620
INDIRI4
CNSTI4 5
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ADDRLP4 4628
INDIRI4
LEI4 $340
ADDRGP4 $335
JUMPV
LABELV $340
line 733
;733:			if (victims[victim].usecnt >= victims[victim].maxGuards) {
ADDRLP4 4620
INDIRI4
CNSTI4 5
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ADDRLP4 4620
INDIRI4
CNSTI4 5
LSHI4
ADDRLP4 0+28
ADDP4
INDIRI4
LTI4 $342
line 734
;734:				victims[victim].usecnt = -1;
ADDRLP4 4620
INDIRI4
CNSTI4 5
LSHI4
ADDRLP4 0
ADDP4
CNSTI4 -1
ASGNI4
line 735
;735:				numActiveVictims--;
ADDRLP4 4576
ADDRLP4 4576
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 736
;736:				continue;
ADDRGP4 $335
JUMPV
LABELV $342
line 738
;737:			}
;738:			if (victims[victim].usecnt >= minusecnt && victims[victim].danger <= maxDanger) continue;
ADDRLP4 4620
INDIRI4
CNSTI4 5
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ADDRLP4 4628
INDIRI4
LTI4 $345
ADDRLP4 4620
INDIRI4
CNSTI4 5
LSHI4
ADDRLP4 0+8
ADDP4
INDIRI4
ADDRLP4 4636
INDIRI4
GTI4 $345
ADDRGP4 $335
JUMPV
LABELV $345
line 740
;739:
;740:			minusecnt = victims[victim].usecnt;
ADDRLP4 4628
ADDRLP4 4620
INDIRI4
CNSTI4 5
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ASGNI4
line 741
;741:			maxDanger = victims[victim].danger;
ADDRLP4 4636
ADDRLP4 4620
INDIRI4
CNSTI4 5
LSHI4
ADDRLP4 0+8
ADDP4
INDIRI4
ASGNI4
line 742
;742:			rpi = &victims[victim];
ADDRLP4 4632
ADDRLP4 4620
INDIRI4
CNSTI4 5
LSHI4
ADDRLP4 0
ADDP4
ASGNP4
line 743
;743:		}
LABELV $335
line 730
ADDRLP4 4620
ADDRLP4 4620
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $337
ADDRLP4 4620
INDIRI4
ADDRLP4 4096
INDIRI4
LTI4 $334
line 744
;744:		if (!rpi) return rs;
ADDRLP4 4632
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $349
ADDRLP4 4572
INDIRP4
RETP4
ADDRGP4 $263
JUMPV
LABELV $349
line 746
;745:
;746:		bestTravelTime = 100000000;
ADDRLP4 4640
CNSTI4 100000000
ASGNI4
line 747
;747:		assignedGuard = -1;
ADDRLP4 4644
CNSTI4 -1
ASGNI4
line 748
;748:		leaderGuard = -1;
ADDRLP4 4648
CNSTI4 -1
ASGNI4
line 749
;749:		for (guard = 0; guard < numGuards; guard++) {
ADDRLP4 4624
CNSTI4 0
ASGNI4
ADDRGP4 $354
JUMPV
LABELV $351
line 752
;750:			int travelTime;
;751:
;752:			if (guards[guard].usecnt != 0) continue;
ADDRLP4 4624
INDIRI4
CNSTI4 5
LSHI4
ADDRLP4 2048
ADDP4
INDIRI4
CNSTI4 0
EQI4 $355
ADDRGP4 $352
JUMPV
LABELV $355
line 754
;753:
;754:			travelTime = trap_AAS_AreaTravelTimeToGoalArea(guards[guard].areanum, guards[guard].origin, rpi->areanum, TFL_DEFAULT);
ADDRLP4 4624
INDIRI4
CNSTI4 5
LSHI4
ADDRLP4 2048+24
ADDP4
INDIRI4
ARGI4
ADDRLP4 4624
INDIRI4
CNSTI4 5
LSHI4
ADDRLP4 2048+12
ADDP4
ARGP4
ADDRLP4 4632
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 4660
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 4652
ADDRLP4 4660
INDIRI4
ASGNI4
line 755
;755:			if (travelTime <= 0) continue;
ADDRLP4 4652
INDIRI4
CNSTI4 0
GTI4 $359
ADDRGP4 $352
JUMPV
LABELV $359
line 756
;756:			if (g_entities[guards[guard].clientnum].client->sess.teamLeader) {
ADDRLP4 4624
INDIRI4
CNSTI4 5
LSHI4
ADDRLP4 2048+4
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 720
ADDP4
INDIRI4
CNSTI4 0
EQI4 $361
line 757
;757:				leaderGuard = guard;
ADDRLP4 4648
ADDRLP4 4624
INDIRI4
ASGNI4
line 758
;758:				continue;
ADDRGP4 $352
JUMPV
LABELV $361
line 760
;759:			}
;760:			if (travelTime >= bestTravelTime) continue;
ADDRLP4 4652
INDIRI4
ADDRLP4 4640
INDIRI4
LTI4 $365
ADDRGP4 $352
JUMPV
LABELV $365
line 762
;761:
;762:			bestTravelTime = travelTime;
ADDRLP4 4640
ADDRLP4 4652
INDIRI4
ASGNI4
line 763
;763:			assignedGuard = guard;
ADDRLP4 4644
ADDRLP4 4624
INDIRI4
ASGNI4
line 764
;764:		}
LABELV $352
line 749
ADDRLP4 4624
ADDRLP4 4624
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $354
ADDRLP4 4624
INDIRI4
ADDRLP4 4100
INDIRI4
LTI4 $351
line 766
;765:
;766:		if (assignedGuard < 0) {
ADDRLP4 4644
INDIRI4
CNSTI4 0
GEI4 $367
line 767
;767:			assignedGuard = leaderGuard;
ADDRLP4 4644
ADDRLP4 4648
INDIRI4
ASGNI4
line 768
;768:		}		
LABELV $367
line 769
;769:		if (assignedGuard < 0) {
ADDRLP4 4644
INDIRI4
CNSTI4 0
GEI4 $369
line 770
;770:			rpi->usecnt = -1;
ADDRLP4 4632
INDIRP4
CNSTI4 -1
ASGNI4
line 771
;771:			numActiveVictims--;
ADDRLP4 4576
ADDRLP4 4576
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 772
;772:			continue;
ADDRGP4 $332
JUMPV
LABELV $369
line 775
;773:		}
;774:
;775:		rs->assignments[rs->numAssignments].guard = guards[assignedGuard].clientnum;
ADDRLP4 4572
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 3
LSHI4
ADDRLP4 4572
INDIRP4
CNSTI4 12
ADDP4
ADDP4
ADDRLP4 4644
INDIRI4
CNSTI4 5
LSHI4
ADDRLP4 2048+4
ADDP4
INDIRI4
ASGNI4
line 776
;776:		rs->assignments[rs->numAssignments].victim = rpi->clientnum;
ADDRLP4 4572
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 3
LSHI4
ADDRLP4 4572
INDIRP4
CNSTI4 12
ADDP4
ADDP4
CNSTI4 4
ADDP4
ADDRLP4 4632
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 777
;777:		rs->numAssignments++;
ADDRLP4 4660
ADDRLP4 4572
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 4660
INDIRP4
ADDRLP4 4660
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 779
;778:
;779:		rpi->usecnt++;
ADDRLP4 4632
INDIRP4
ADDRLP4 4632
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 781
;780:
;781:		guards[assignedGuard].usecnt++;
ADDRLP4 4668
ADDRLP4 4644
INDIRI4
CNSTI4 5
LSHI4
ADDRLP4 2048
ADDP4
ASGNP4
ADDRLP4 4668
INDIRP4
ADDRLP4 4668
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 782
;782:		numActiveGuards--;
ADDRLP4 4584
ADDRLP4 4584
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 783
;783:	}
LABELV $332
line 719
ADDRLP4 4584
INDIRI4
CNSTI4 0
LEI4 $372
ADDRLP4 4576
INDIRI4
CNSTI4 0
GTI4 $331
LABELV $372
line 785
;784:
;785:	return rs;
ADDRLP4 4572
INDIRP4
RETP4
LABELV $263
endproc BotUpdateRescueSchedule 4672 16
export BotRescueTeamMate
proc BotRescueTeamMate 28 4
line 793
;786:}
;787:
;788:/*
;789:==================
;790:JUHOX: BotRescueTeamMate
;791:==================
;792:*/
;793:int BotRescueTeamMate(bot_state_t* bs, int* helpers, int maxHelpers, int* numHelpers) {
line 799
;794:	rescueSchedule_t* rs;
;795:	int assignment;
;796:	int victim;
;797:	int guard;
;798:
;799:	if (bs->cur_ps.stats[STAT_HEALTH] <= 0) return -1;
ADDRFP4 0
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
CNSTI4 0
GTI4 $374
CNSTI4 -1
RETI4
ADDRGP4 $373
JUMPV
LABELV $374
line 801
;800:
;801:	rs = BotUpdateRescueSchedule(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 BotUpdateRescueSchedule
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRP4
ASGNP4
line 802
;802:	if (!rs) return -1;
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $376
CNSTI4 -1
RETI4
ADDRGP4 $373
JUMPV
LABELV $376
line 804
;803:
;804:	for (assignment = 0; assignment < rs->numAssignments; assignment++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $381
JUMPV
LABELV $378
line 805
;805:		if (rs->assignments[assignment].guard != bs->client) continue;
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
EQI4 $382
ADDRGP4 $379
JUMPV
LABELV $382
line 807
;806:
;807:		victim = rs->assignments[assignment].victim;
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 808
;808:		*numHelpers = 0;
ADDRFP4 12
INDIRP4
CNSTI4 0
ASGNI4
line 809
;809:		for (assignment = 0; assignment < rs->numAssignments; assignment++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $387
JUMPV
LABELV $384
line 810
;810:			guard = rs->assignments[assignment].guard;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDP4
INDIRI4
ASGNI4
line 811
;811:			if (guard == bs->client) continue;
ADDRLP4 8
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $388
ADDRGP4 $385
JUMPV
LABELV $388
line 812
;812:			if (rs->assignments[assignment].victim != victim) continue;
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $390
ADDRGP4 $385
JUMPV
LABELV $390
line 813
;813:			if (*numHelpers >= maxHelpers) continue;
ADDRFP4 12
INDIRP4
INDIRI4
ADDRFP4 8
INDIRI4
LTI4 $392
ADDRGP4 $385
JUMPV
LABELV $392
line 814
;814:			helpers[(*numHelpers)++] = guard;
ADDRLP4 24
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 20
ADDRLP4 24
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 24
INDIRP4
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 815
;815:		}
LABELV $385
line 809
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $387
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
LTI4 $384
line 816
;816:		return victim;
ADDRLP4 12
INDIRI4
RETI4
ADDRGP4 $373
JUMPV
LABELV $379
line 804
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $381
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
LTI4 $378
line 819
;817:	}
;818:
;819:	return -1;
CNSTI4 -1
RETI4
LABELV $373
endproc BotRescueTeamMate 28 4
export BotClientIsGuard
proc BotClientIsGuard 12 4
line 827
;820:}
;821:
;822:/*
;823:==================
;824:JUHOX: BotClientIsGuard
;825:==================
;826:*/
;827:qboolean BotClientIsGuard(bot_state_t* bs, int client) {
line 831
;828:	rescueSchedule_t* rs;
;829:	int assignment;
;830:
;831:	rs = BotUpdateRescueSchedule(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BotUpdateRescueSchedule
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 832
;832:	if (!rs) return qfalse;
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $395
CNSTI4 0
RETI4
ADDRGP4 $394
JUMPV
LABELV $395
line 833
;833:	for (assignment = 0; assignment < rs->numAssignments; assignment++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $400
JUMPV
LABELV $397
line 834
;834:		if (rs->assignments[assignment].guard == client) return qtrue;
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $401
CNSTI4 1
RETI4
ADDRGP4 $394
JUMPV
LABELV $401
line 835
;835:	}
LABELV $398
line 833
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $400
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
LTI4 $397
line 836
;836:	return qfalse;
CNSTI4 0
RETI4
LABELV $394
endproc BotClientIsGuard 12 4
export BotActivateHumanHelpers
proc BotActivateHumanHelpers 588 16
line 844
;837:}
;838:
;839:/*
;840:==================
;841:JUHOX: BotActivateHumanHelpers
;842:==================
;843:*/
;844:void BotActivateHumanHelpers(bot_state_t* bs) {
line 850
;845:	rescueSchedule_t* rs;
;846:	int assignment;
;847:	int helper;
;848:	char buf[64];
;849:
;850:	if (gametype < GT_TEAM) return;
ADDRGP4 gametype
INDIRI4
CNSTI4 3
GEI4 $404
ADDRGP4 $403
JUMPV
LABELV $404
line 852
;851:#if BOTS_USE_TSS
;852:	if (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_isValid)) return;	// TSS manages helper activation
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 76
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
EQI4 $406
ADDRGP4 $403
JUMPV
LABELV $406
line 855
;853:#endif
;854:
;855:	rs = BotUpdateRescueSchedule(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 80
ADDRGP4 BotUpdateRescueSchedule
CALLP4
ASGNP4
ADDRLP4 72
ADDRLP4 80
INDIRP4
ASGNP4
line 856
;856:	if (!rs) return;
ADDRLP4 72
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $408
ADDRGP4 $403
JUMPV
LABELV $408
line 858
;857:
;858:	if (BotPlayerDanger(&bs->cur_ps) >= 25) {
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 84
ADDRGP4 BotPlayerDanger
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 25
LTI4 $410
line 859
;859:		for (assignment = 0; assignment < rs->numAssignments; assignment++) {
ADDRLP4 68
CNSTI4 0
ASGNI4
ADDRGP4 $415
JUMPV
LABELV $412
line 860
;860:			if (rs->assignments[assignment].victim == bs->client) {
ADDRLP4 68
INDIRI4
CNSTI4 3
LSHI4
ADDRLP4 72
INDIRP4
CNSTI4 12
ADDP4
ADDP4
CNSTI4 4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $416
line 865
;861:				int unusedSlot;
;862:				int guard;
;863:				playerState_t ps;
;864:	
;865:				guard = rs->assignments[assignment].guard;
ADDRLP4 88
ADDRLP4 68
INDIRI4
CNSTI4 3
LSHI4
ADDRLP4 72
INDIRP4
CNSTI4 12
ADDP4
ADDP4
INDIRI4
ASGNI4
line 866
;866:				if (BotAI_IsBot(guard)) continue;
ADDRLP4 88
INDIRI4
ARGI4
ADDRLP4 564
ADDRGP4 BotAI_IsBot
CALLP4
ASGNP4
ADDRLP4 564
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $418
ADDRGP4 $413
JUMPV
LABELV $418
line 868
;867:	
;868:				if (!BotAI_GetClientState(guard, &ps)) continue;
ADDRLP4 88
INDIRI4
ARGI4
ADDRLP4 96
ARGP4
ADDRLP4 568
ADDRGP4 BotAI_GetClientState
CALLI4
ASGNI4
ADDRLP4 568
INDIRI4
CNSTI4 0
NEI4 $420
ADDRGP4 $413
JUMPV
LABELV $420
line 869
;869:				if (ps.stats[STAT_HEALTH] <= 0 || BotPlayerDanger(&ps) >= 25) continue;
ADDRLP4 96+184
INDIRI4
CNSTI4 0
LEI4 $425
ADDRLP4 96
ARGP4
ADDRLP4 572
ADDRGP4 BotPlayerDanger
CALLI4
ASGNI4
ADDRLP4 572
INDIRI4
CNSTI4 25
LTI4 $422
LABELV $425
ADDRGP4 $413
JUMPV
LABELV $422
line 871
;870:
;871:				unusedSlot = -1;
ADDRLP4 92
CNSTI4 -1
ASGNI4
line 872
;872:				for (helper = 0; helper < MAX_SUBTEAM_SIZE; helper++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $426
line 873
;873:					if (bs->humanHelpers[helper] < 0) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 11920
ADDP4
ADDP4
INDIRI4
CNSTI4 0
GEI4 $430
line 874
;874:						unusedSlot = helper;
ADDRLP4 92
ADDRLP4 0
INDIRI4
ASGNI4
line 875
;875:						continue;
ADDRGP4 $427
JUMPV
LABELV $430
line 877
;876:					}
;877:					if (bs->humanHelpers[helper] == guard) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 11920
ADDP4
ADDP4
INDIRI4
ADDRLP4 88
INDIRI4
NEI4 $432
line 878
;878:						bs->humanHelpersTime[helper] = FloatTime();
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 12048
ADDP4
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 879
;879:						goto NextAssignment;
ADDRGP4 $434
JUMPV
LABELV $432
line 881
;880:					}
;881:				}
LABELV $427
line 872
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $426
line 883
;882:	
;883:				if (unusedSlot >= 0) {
ADDRLP4 92
INDIRI4
CNSTI4 0
LTI4 $435
line 884
;884:					G_Say(
ADDRLP4 88
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 576
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRGP4 $437
ARGP4
ADDRLP4 576
INDIRP4
ARGP4
ADDRLP4 580
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 584
ADDRGP4 g_entities
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRLP4 584
INDIRP4
ADDP4
ARGP4
ADDRLP4 88
INDIRI4
CNSTI4 844
MULI4
ADDRLP4 584
INDIRP4
ADDP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 580
INDIRP4
ARGP4
ADDRGP4 G_Say
CALLV
pop
line 888
;885:						&g_entities[bs->entitynum], &g_entities[guard], SAY_TELL,
;886:						va("Please help me, %s\n", EasyClientName(guard, buf, sizeof(buf)))
;887:					);
;888:					bs->humanHelpers[unusedSlot] = guard;
ADDRLP4 92
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 11920
ADDP4
ADDP4
ADDRLP4 88
INDIRI4
ASGNI4
line 889
;889:					bs->humanHelpersTime[unusedSlot] = FloatTime();
ADDRLP4 92
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 12048
ADDP4
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 890
;890:				}
LABELV $435
line 891
;891:			}
LABELV $416
LABELV $434
line 892
;892:			NextAssignment:;
line 893
;893:		}
LABELV $413
line 859
ADDRLP4 68
ADDRLP4 68
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $415
ADDRLP4 68
INDIRI4
ADDRLP4 72
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
LTI4 $412
line 894
;894:	}
LABELV $410
line 896
;895:
;896:	for (helper = 0; helper < MAX_SUBTEAM_SIZE; helper++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $438
line 900
;897:		playerState_t ps;
;898:		int clientNum;
;899:
;900:		clientNum = bs->humanHelpers[helper];
ADDRLP4 88
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 11920
ADDP4
ADDP4
INDIRI4
ASGNI4
line 901
;901:		if (clientNum < 0) continue;
ADDRLP4 88
INDIRI4
CNSTI4 0
GEI4 $442
ADDRGP4 $439
JUMPV
LABELV $442
line 903
;902:
;903:		if (!BotAI_GetClientState(clientNum, &ps)) continue;
ADDRLP4 88
INDIRI4
ARGI4
ADDRLP4 92
ARGP4
ADDRLP4 560
ADDRGP4 BotAI_GetClientState
CALLI4
ASGNI4
ADDRLP4 560
INDIRI4
CNSTI4 0
NEI4 $444
ADDRGP4 $439
JUMPV
LABELV $444
line 904
;904:		if (ps.stats[STAT_HEALTH] <= 0 || BotPlayerDanger(&ps) >= 25) {
ADDRLP4 92+184
INDIRI4
CNSTI4 0
LEI4 $449
ADDRLP4 92
ARGP4
ADDRLP4 564
ADDRGP4 BotPlayerDanger
CALLI4
ASGNI4
ADDRLP4 564
INDIRI4
CNSTI4 25
LTI4 $446
LABELV $449
line 905
;905:			bs->humanHelpers[helper] = -1;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 11920
ADDP4
ADDP4
CNSTI4 -1
ASGNI4
line 906
;906:			continue;
ADDRGP4 $439
JUMPV
LABELV $446
line 909
;907:		}
;908:
;909:		if (bs->humanHelpersTime[helper] > FloatTime() - 10) continue;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 12048
ADDP4
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1092616192
SUBF4
LEF4 $450
ADDRGP4 $439
JUMPV
LABELV $450
line 911
;910:
;911:		bs->humanHelpers[helper] = -1;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 11920
ADDP4
ADDP4
CNSTI4 -1
ASGNI4
line 913
;912:
;913:		if (BotClientIsGuard(bs, clientNum)) continue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 88
INDIRI4
ARGI4
ADDRLP4 568
ADDRGP4 BotClientIsGuard
CALLI4
ASGNI4
ADDRLP4 568
INDIRI4
CNSTI4 0
EQI4 $452
ADDRGP4 $439
JUMPV
LABELV $452
line 915
;914:
;915:		G_Say(
ADDRLP4 88
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 572
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRGP4 $454
ARGP4
ADDRLP4 572
INDIRP4
ARGP4
ADDRLP4 576
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 580
ADDRGP4 g_entities
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRLP4 580
INDIRP4
ADDP4
ARGP4
ADDRLP4 88
INDIRI4
CNSTI4 844
MULI4
ADDRLP4 580
INDIRP4
ADDP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 576
INDIRP4
ARGP4
ADDRGP4 G_Say
CALLV
pop
line 919
;916:			&g_entities[bs->entitynum], &g_entities[clientNum], SAY_TELL,
;917:			va("Thanks, %s, I no longer need your help.\n", EasyClientName(clientNum, buf, sizeof(buf)))
;918:		);
;919:	}
LABELV $439
line 896
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $438
line 920
;920:}
LABELV $403
endproc BotActivateHumanHelpers 588 16
export BotTeamMateToFollow
proc BotTeamMateToFollow 680 16
line 927
;921:
;922:/*
;923:==================
;924:JUHOX: BotTeamMateToFollow
;925:==================
;926:*/
;927:int BotTeamMateToFollow(bot_state_t* bs) {
line 934
;928:	int leader;
;929:	int helpers[MAX_SUBTEAM_SIZE];
;930:	int numHelpers;
;931:	playerState_t ps;
;932:	int teamMate;
;933:
;934:	if (FloatTime() < bs->teamgoal_checktime || bs->areanum <= 0) {
ADDRLP4 608
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 608
INDIRP4
CNSTI4 11704
ADDP4
INDIRF4
LTF4 $458
ADDRLP4 608
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
CNSTI4 0
GTI4 $456
LABELV $458
line 935
;935:		if (bs->ltgtype != LTG_TEAMHELP) return -1;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 1
EQI4 $459
CNSTI4 -1
RETI4
ADDRGP4 $455
JUMPV
LABELV $459
line 936
;936:		return bs->teammate;
ADDRFP4 0
INDIRP4
CNSTI4 11560
ADDP4
INDIRI4
RETI4
ADDRGP4 $455
JUMPV
LABELV $456
line 938
;937:	}
;938:	bs->teamgoal_checktime = FloatTime() + 1 + random();
ADDRLP4 612
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRFP4 0
INDIRP4
CNSTI4 11704
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
ADDF4
ADDRLP4 612
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 612
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
line 940
;939:
;940:	BotActivateHumanHelpers(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotActivateHumanHelpers
CALLV
pop
line 943
;941:
;942:#if BOTS_USE_TSS
;943:	if (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_isValid)) {
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 616
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 616
INDIRI4
CNSTI4 0
EQI4 $461
line 947
;944:		tss_missionTask_t task;
;945:		int taskGoal;
;946:
;947:		if (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_groupMemberStatus) == TSSGMS_retreating) return -1;
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 628
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 628
INDIRI4
CNSTI4 0
NEI4 $463
CNSTI4 -1
RETI4
ADDRGP4 $455
JUMPV
LABELV $463
line 948
;948:		task = BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_task);
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTI4 5
ARGI4
ADDRLP4 632
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 620
ADDRLP4 632
INDIRI4
ASGNI4
line 949
;949:		taskGoal = BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_taskGoal);
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTI4 13
ARGI4
ADDRLP4 636
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 624
ADDRLP4 636
INDIRI4
ASGNI4
line 950
;950:		switch (task) {
ADDRLP4 640
ADDRLP4 620
INDIRI4
ASGNI4
ADDRLP4 640
INDIRI4
CNSTI4 0
LTI4 $465
ADDRLP4 640
INDIRI4
CNSTI4 9
GTI4 $465
ADDRLP4 640
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $501
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $501
address $468
address $468
address $500
address $468
address $468
address $500
address $468
address $468
address $500
address $500
code
LABELV $468
line 957
;951:		case TSSMT_followGroupLeader:
;952:		case TSSMT_stickToGroupLeader:
;953:		case TSSMT_helpTeamMate:
;954:		case TSSMT_guardFlagCarrier:
;955:		case TSSMT_seekGroupMember:
;956:		case TSSMT_seekEnemyNearTeamMate:
;957:			leader = taskGoal;
ADDRLP4 472
ADDRLP4 624
INDIRI4
ASGNI4
line 958
;958:			if (leader == bs->client || leader < 0 || leader >= MAX_CLIENTS) return -1;
ADDRLP4 472
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
EQI4 $472
ADDRLP4 472
INDIRI4
CNSTI4 0
LTI4 $472
ADDRLP4 472
INDIRI4
CNSTI4 64
LTI4 $469
LABELV $472
CNSTI4 -1
RETI4
ADDRGP4 $455
JUMPV
LABELV $469
line 959
;959:			switch (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_groupMemberStatus)) {
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 656
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 652
ADDRLP4 656
INDIRI4
ASGNI4
ADDRLP4 652
INDIRI4
CNSTI4 3
EQI4 $476
ADDRLP4 652
INDIRI4
CNSTI4 4
EQI4 $476
ADDRGP4 $473
JUMPV
LABELV $476
line 964
;960:			case TSSGMS_designatedLeader:
;961:			case TSSGMS_temporaryLeader:
;962:				// NOTE: we do not consider helpers because they may change with the group leader
;963:				// travelling around
;964:				return leader;
ADDRLP4 472
INDIRI4
RETI4
ADDRGP4 $455
JUMPV
LABELV $473
line 966
;965:			}
;966:			numHelpers = 0;
ADDRLP4 476
CNSTI4 0
ASGNI4
line 967
;967:			for (teamMate = -1; (teamMate = BotGetNextTeamMate(bs, teamMate, &ps)) >= 0;) {
ADDRLP4 0
CNSTI4 -1
ASGNI4
ADDRGP4 $480
JUMPV
LABELV $477
line 968
;968:				if (teamMate == leader) continue;
ADDRLP4 0
INDIRI4
ADDRLP4 472
INDIRI4
NEI4 $481
ADDRGP4 $478
JUMPV
LABELV $481
line 969
;969:				if (ps.stats[STAT_HEALTH] <= 0) continue;
ADDRLP4 4+184
INDIRI4
CNSTI4 0
GTI4 $483
ADDRGP4 $478
JUMPV
LABELV $483
line 970
;970:				if (!BG_TSS_GetPlayerInfo(&ps, TSSPI_isValid)) continue;
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 664
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 664
INDIRI4
CNSTI4 0
NEI4 $486
ADDRGP4 $478
JUMPV
LABELV $486
line 972
;971:				// NOTE: we do not ignore players of other groups!
;972:				task = BG_TSS_GetPlayerInfo(&ps, TSSPI_task);
ADDRLP4 4
ARGP4
CNSTI4 5
ARGI4
ADDRLP4 668
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 620
ADDRLP4 668
INDIRI4
ASGNI4
line 973
;973:				if (task == TSSMT_retreat) continue;
ADDRLP4 620
INDIRI4
CNSTI4 2
NEI4 $488
ADDRGP4 $478
JUMPV
LABELV $488
line 974
;974:				if (task == TSSMT_rushToBase) continue;
ADDRLP4 620
INDIRI4
CNSTI4 5
NEI4 $490
ADDRGP4 $478
JUMPV
LABELV $490
line 975
;975:				if (task == TSSMT_fulfilMission) continue;
ADDRLP4 620
INDIRI4
CNSTI4 8
NEI4 $492
ADDRGP4 $478
JUMPV
LABELV $492
line 976
;976:				if (task == TSSMT_prepareForMission) continue;
ADDRLP4 620
INDIRI4
CNSTI4 9
NEI4 $494
ADDRGP4 $478
JUMPV
LABELV $494
line 977
;977:				taskGoal = BG_TSS_GetPlayerInfo(&ps, TSSPI_taskGoal);
ADDRLP4 4
ARGP4
CNSTI4 13
ARGI4
ADDRLP4 672
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 624
ADDRLP4 672
INDIRI4
ASGNI4
line 978
;978:				if (taskGoal != leader) continue;
ADDRLP4 624
INDIRI4
ADDRLP4 472
INDIRI4
EQI4 $496
ADDRGP4 $478
JUMPV
LABELV $496
line 980
;979:
;980:				helpers[numHelpers++] = teamMate;
ADDRLP4 676
ADDRLP4 476
INDIRI4
ASGNI4
ADDRLP4 476
ADDRLP4 676
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 676
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 480
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 981
;981:				if (numHelpers >= MAX_SUBTEAM_SIZE) break;
ADDRLP4 476
INDIRI4
CNSTI4 32
LTI4 $498
ADDRGP4 $462
JUMPV
LABELV $498
line 982
;982:			}
LABELV $478
line 967
LABELV $480
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 664
ADDRGP4 BotGetNextTeamMate
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 664
INDIRI4
ASGNI4
ADDRLP4 664
INDIRI4
CNSTI4 0
GEI4 $477
line 983
;983:			break;
ADDRGP4 $462
JUMPV
LABELV $500
line 988
;984:		case TSSMT_retreat:
;985:		case TSSMT_rushToBase:
;986:		case TSSMT_fulfilMission:
;987:		case TSSMT_prepareForMission:
;988:			return -1;
CNSTI4 -1
RETI4
ADDRGP4 $455
JUMPV
LABELV $465
line 990
;989:		default:
;990:			leader = -1;
ADDRLP4 472
CNSTI4 -1
ASGNI4
line 991
;991:			break;
line 993
;992:		}
;993:	}
ADDRGP4 $462
JUMPV
LABELV $461
line 997
;994:	else
;995:#endif
;996:#if MONSTER_MODE
;997:	if (g_gametype.integer >= GT_STU) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
LTI4 $502
line 998
;998:		leader = -1;
ADDRLP4 472
CNSTI4 -1
ASGNI4
line 999
;999:	}
ADDRGP4 $503
JUMPV
LABELV $502
line 1002
;1000:	else
;1001:#endif
;1002:	{
line 1003
;1003:		if (BotPlayerDanger(&bs->cur_ps) >= 25) return -1;
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 620
ADDRGP4 BotPlayerDanger
CALLI4
ASGNI4
ADDRLP4 620
INDIRI4
CNSTI4 25
LTI4 $505
CNSTI4 -1
RETI4
ADDRGP4 $455
JUMPV
LABELV $505
line 1004
;1004:		leader = BotRescueTeamMate(bs, helpers, MAX_SUBTEAM_SIZE, &numHelpers);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 480
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 476
ARGP4
ADDRLP4 624
ADDRGP4 BotRescueTeamMate
CALLI4
ASGNI4
ADDRLP4 472
ADDRLP4 624
INDIRI4
ASGNI4
line 1005
;1005:	}
LABELV $503
LABELV $462
line 1007
;1006:
;1007:	if (leader < 0) {
ADDRLP4 472
INDIRI4
CNSTI4 0
GEI4 $507
line 1008
;1008:		leader = bs->leader;
ADDRLP4 472
ADDRFP4 0
INDIRP4
CNSTI4 11872
ADDP4
INDIRI4
ASGNI4
line 1009
;1009:		if (leader == bs->client) {
ADDRLP4 472
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $509
line 1010
;1010:			BotTeamleaderReachable(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotTeamleaderReachable
CALLV
pop
line 1011
;1011:			return -1;
CNSTI4 -1
RETI4
ADDRGP4 $455
JUMPV
LABELV $509
line 1013
;1012:		}
;1013:		if (!BotAI_GetClientState(leader, &ps)) {
ADDRLP4 472
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 620
ADDRGP4 BotAI_GetClientState
CALLI4
ASGNI4
ADDRLP4 620
INDIRI4
CNSTI4 0
NEI4 $511
line 1014
;1014:			leader = -1;
ADDRLP4 472
CNSTI4 -1
ASGNI4
line 1015
;1015:		}
ADDRGP4 $512
JUMPV
LABELV $511
line 1016
;1016:		else if (ps.stats[STAT_HEALTH] <= 0) {
ADDRLP4 4+184
INDIRI4
CNSTI4 0
GTI4 $513
line 1017
;1017:			leader = -1;
ADDRLP4 472
CNSTI4 -1
ASGNI4
line 1018
;1018:		}
LABELV $513
LABELV $512
line 1019
;1019:		if (leader < 0) {
ADDRLP4 472
INDIRI4
CNSTI4 0
GEI4 $516
line 1022
;1020:			int numTeamMates;
;1021:
;1022:			numTeamMates = 0;
ADDRLP4 624
CNSTI4 0
ASGNI4
line 1023
;1023:			for (teamMate = -1; (teamMate = BotGetNextTeamMate(bs, teamMate, &ps)) >= 0;) {
ADDRLP4 0
CNSTI4 -1
ASGNI4
ADDRGP4 $521
JUMPV
LABELV $518
line 1024
;1024:				if (ps.stats[STAT_HEALTH] <= 0) continue;
ADDRLP4 4+184
INDIRI4
CNSTI4 0
GTI4 $522
ADDRGP4 $519
JUMPV
LABELV $522
line 1025
;1025:				if (bs->ltgtype == LTG_TEAMHELP && teamMate == bs->teammate) {
ADDRLP4 628
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 628
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 1
NEI4 $525
ADDRLP4 0
INDIRI4
ADDRLP4 628
INDIRP4
CNSTI4 11560
ADDP4
INDIRI4
NEI4 $525
line 1026
;1026:					leader = teamMate;
ADDRLP4 472
ADDRLP4 0
INDIRI4
ASGNI4
line 1027
;1027:					break;
ADDRGP4 $520
JUMPV
LABELV $525
line 1029
;1028:				}
;1029:				if (ps.powerups[PW_REDFLAG] || ps.powerups[PW_BLUEFLAG]) {
ADDRLP4 4+312+28
INDIRI4
CNSTI4 0
NEI4 $533
ADDRLP4 4+312+32
INDIRI4
CNSTI4 0
EQI4 $527
LABELV $533
line 1030
;1030:					if (!NearHomeBase(ps.persistant[PERS_TEAM], ps.origin, 9)) {
ADDRLP4 4+248+12
INDIRI4
ARGI4
ADDRLP4 4+20
ARGP4
CNSTF4 1091567616
ARGF4
ADDRLP4 632
ADDRGP4 NearHomeBase
CALLI4
ASGNI4
ADDRLP4 632
INDIRI4
CNSTI4 0
NEI4 $534
line 1031
;1031:						leader = teamMate;
ADDRLP4 472
ADDRLP4 0
INDIRI4
ASGNI4
line 1032
;1032:						break;
ADDRGP4 $520
JUMPV
LABELV $534
line 1034
;1033:					}
;1034:				}
LABELV $527
line 1035
;1035:				numTeamMates++;
ADDRLP4 624
ADDRLP4 624
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1036
;1036:				if (rand() % numTeamMates == 0) {
ADDRLP4 632
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 632
INDIRI4
ADDRLP4 624
INDIRI4
MODI4
CNSTI4 0
NEI4 $539
line 1037
;1037:					leader = teamMate;
ADDRLP4 472
ADDRLP4 0
INDIRI4
ASGNI4
line 1038
;1038:				}
LABELV $539
line 1039
;1039:			}
LABELV $519
line 1023
LABELV $521
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 628
ADDRGP4 BotGetNextTeamMate
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 628
INDIRI4
ASGNI4
ADDRLP4 628
INDIRI4
CNSTI4 0
GEI4 $518
LABELV $520
line 1040
;1040:			if (leader < 0) {
ADDRLP4 472
INDIRI4
CNSTI4 0
GEI4 $541
line 1041
;1041:				BotTeamleaderReachable(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotTeamleaderReachable
CALLV
pop
line 1042
;1042:				return -1;
CNSTI4 -1
RETI4
ADDRGP4 $455
JUMPV
LABELV $541
line 1044
;1043:			}
;1044:		}
LABELV $516
line 1046
;1045:
;1046:		numHelpers = 0;
ADDRLP4 476
CNSTI4 0
ASGNI4
line 1047
;1047:		for (teamMate = -1; (teamMate = BotGetNextTeamMate(bs, teamMate, &ps)) >= 0;) {
ADDRLP4 0
CNSTI4 -1
ASGNI4
ADDRGP4 $546
JUMPV
LABELV $543
line 1048
;1048:			if (teamMate == leader) continue;
ADDRLP4 0
INDIRI4
ADDRLP4 472
INDIRI4
NEI4 $547
ADDRGP4 $544
JUMPV
LABELV $547
line 1049
;1049:			if (ps.stats[STAT_HEALTH] <= 0) continue;
ADDRLP4 4+184
INDIRI4
CNSTI4 0
GTI4 $549
ADDRGP4 $544
JUMPV
LABELV $549
line 1051
;1050:			if (
;1051:				BotPlayerDanger(&ps) >= 25
ADDRLP4 4
ARGP4
ADDRLP4 624
ADDRGP4 BotPlayerDanger
CALLI4
ASGNI4
ADDRLP4 624
INDIRI4
CNSTI4 25
LTI4 $552
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
GEI4 $552
line 1055
;1052:#if MONSTER_MODE
;1053:				&& g_gametype.integer < GT_STU
;1054:#endif
;1055:			) continue;
ADDRGP4 $544
JUMPV
LABELV $552
line 1057
;1056:
;1057:			helpers[numHelpers++] = teamMate;
ADDRLP4 628
ADDRLP4 476
INDIRI4
ASGNI4
ADDRLP4 476
ADDRLP4 628
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 628
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 480
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1058
;1058:			if (numHelpers >= MAX_SUBTEAM_SIZE) break;
ADDRLP4 476
INDIRI4
CNSTI4 32
LTI4 $555
ADDRGP4 $545
JUMPV
LABELV $555
line 1059
;1059:		}
LABELV $544
line 1047
LABELV $546
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 624
ADDRGP4 BotGetNextTeamMate
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 624
INDIRI4
ASGNI4
ADDRLP4 624
INDIRI4
CNSTI4 0
GEI4 $543
LABELV $545
line 1060
;1060:	}
LABELV $507
line 1062
;1061:
;1062:	return BotFindTeamMateInFront(bs, leader, helpers, numHelpers);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 472
INDIRI4
ARGI4
ADDRLP4 480
ARGP4
ADDRLP4 476
INDIRI4
ARGI4
ADDRLP4 620
ADDRGP4 BotFindTeamMateInFront
CALLI4
ASGNI4
ADDRLP4 620
INDIRI4
RETI4
LABELV $455
endproc BotTeamMateToFollow 680 16
export BotDetermineLeader
proc BotDetermineLeader 516 16
line 1070
;1063:}
;1064:
;1065:/*
;1066:==================
;1067:JUHOX: BotDetermineLeader
;1068:==================
;1069:*/
;1070:void BotDetermineLeader(bot_state_t* bs) {
line 1077
;1071:	int i;
;1072:	int group;
;1073:	int bestLeader;
;1074:	int lowestDanger;
;1075:	int highestScore;
;1076:
;1077:	if (gametype < GT_TEAM) {
ADDRGP4 gametype
INDIRI4
CNSTI4 3
GEI4 $558
line 1078
;1078:		bs->leader = bs->client;
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 11872
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1079
;1079:		return;
ADDRGP4 $557
JUMPV
LABELV $558
line 1082
;1080:	}
;1081:
;1082:	group = -1;
ADDRLP4 8
CNSTI4 -1
ASGNI4
line 1084
;1083:#if BOTS_USE_TSS
;1084:	if (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_isValid)) {
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 20
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $560
line 1085
;1085:		group = BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_group);
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 24
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 24
INDIRI4
ASGNI4
line 1086
;1086:		if (group >= MAX_GROUPS) group = -1;
ADDRLP4 8
INDIRI4
CNSTI4 10
LTI4 $562
ADDRLP4 8
CNSTI4 -1
ASGNI4
LABELV $562
line 1087
;1087:	}
LABELV $560
line 1090
;1088:#endif
;1089:
;1090:	if (bs->leader >= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 11872
ADDP4
INDIRI4
CNSTI4 0
LTI4 $568
line 1093
;1091:		playerState_t ps;
;1092:
;1093:		if (!BotAI_GetClientState(bs->leader, &ps)) goto DetermineNewLeader;
ADDRFP4 0
INDIRP4
CNSTI4 11872
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
ADDRLP4 492
ADDRGP4 BotAI_GetClientState
CALLI4
ASGNI4
ADDRLP4 492
INDIRI4
CNSTI4 0
NEI4 $566
ADDRGP4 $568
JUMPV
LABELV $566
line 1094
;1094:		if (ps.stats[STAT_HEALTH] <= 0) goto DetermineNewLeader;
ADDRLP4 24+184
INDIRI4
CNSTI4 0
GTI4 $569
ADDRGP4 $568
JUMPV
LABELV $569
line 1095
;1095:		if (group >= 0) {
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $572
line 1097
;1096:#if BOTS_USE_TSS
;1097:			if (!BG_TSS_GetPlayerInfo(&ps, TSSPI_isValid)) goto DetermineNewLeader;
ADDRLP4 24
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 496
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 496
INDIRI4
CNSTI4 0
NEI4 $574
ADDRGP4 $568
JUMPV
LABELV $574
line 1098
;1098:			if (BG_TSS_GetPlayerInfo(&ps, TSSPI_group) != group) goto DetermineNewLeader;
ADDRLP4 24
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 500
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 500
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $576
ADDRGP4 $568
JUMPV
LABELV $576
line 1099
;1099:			switch (BG_TSS_GetPlayerInfo(&ps, TSSPI_groupMemberStatus)) {
ADDRLP4 24
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 508
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 504
ADDRLP4 508
INDIRI4
ASGNI4
ADDRLP4 504
INDIRI4
CNSTI4 3
EQI4 $565
ADDRLP4 504
INDIRI4
CNSTI4 4
EQI4 $565
ADDRGP4 $568
JUMPV
line 1102
;1100:			case TSSGMS_designatedLeader:
;1101:			case TSSGMS_temporaryLeader:
;1102:				break;
line 1104
;1103:			default:
;1104:				goto DetermineNewLeader;
line 1107
;1105:			}
;1106:#endif
;1107:		}
LABELV $572
line 1108
;1108:		else {
line 1109
;1109:			if (ps.powerups[PW_REDFLAG] || ps.powerups[PW_BLUEFLAG]) goto DetermineNewLeader;
ADDRLP4 24+312+28
INDIRI4
CNSTI4 0
NEI4 $588
ADDRLP4 24+312+32
INDIRI4
CNSTI4 0
EQI4 $565
LABELV $588
ADDRGP4 $568
JUMPV
line 1110
;1110:		}
line 1111
;1111:	}
line 1112
;1112:	else {
line 1113
;1113:		goto DetermineNewLeader;
LABELV $565
line 1116
;1114:	}
;1115:
;1116:	if (bs->leaderCheckTime > FloatTime()) return;
ADDRFP4 0
INDIRP4
CNSTI4 11876
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $589
ADDRGP4 $557
JUMPV
LABELV $589
LABELV $568
line 1118
;1117:	DetermineNewLeader:
;1118:	bs->leaderCheckTime = FloatTime() + 2 + 1*random();
ADDRLP4 24
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRFP4 0
INDIRP4
CNSTI4 11876
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
ADDF4
ADDRLP4 24
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 24
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1065353216
MULF4
ADDF4
ASGNF4
line 1121
;1119:
;1120:#if BOTS_USE_TSS
;1121:	if (group >= 0) {
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $591
line 1122
;1122:		for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $596
JUMPV
LABELV $593
line 1125
;1123:			gclient_t* cl;
;1124:
;1125:			if (!g_entities[i].inuse) continue;
ADDRLP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $598
ADDRGP4 $594
JUMPV
LABELV $598
line 1126
;1126:			cl = g_entities[i].client;
ADDRLP4 28
ADDRLP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
ASGNP4
line 1127
;1127:			if (!cl) continue;
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $602
ADDRGP4 $594
JUMPV
LABELV $602
line 1128
;1128:			if (cl->pers.connected != CON_CONNECTED) continue;
ADDRLP4 28
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $604
ADDRGP4 $594
JUMPV
LABELV $604
line 1129
;1129:			if (cl->sess.sessionTeam != bs->cur_ps.persistant[PERS_TEAM]) continue;
ADDRLP4 28
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
EQI4 $606
ADDRGP4 $594
JUMPV
LABELV $606
line 1130
;1130:			if (cl->tssSafetyMode) continue;
ADDRLP4 28
INDIRP4
CNSTI4 768
ADDP4
INDIRI4
CNSTI4 0
EQI4 $608
ADDRGP4 $594
JUMPV
LABELV $608
line 1131
;1131:			if (cl->ps.stats[STAT_HEALTH] <= 0) continue;
ADDRLP4 28
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $610
ADDRGP4 $594
JUMPV
LABELV $610
line 1132
;1132:			if (!BG_TSS_GetPlayerInfo(&cl->ps, TSSPI_isValid)) continue;
ADDRLP4 28
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 32
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $612
ADDRGP4 $594
JUMPV
LABELV $612
line 1133
;1133:			if (BG_TSS_GetPlayerInfo(&cl->ps, TSSPI_group) != group) continue;
ADDRLP4 28
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 36
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $614
ADDRGP4 $594
JUMPV
LABELV $614
line 1134
;1134:			switch (BG_TSS_GetPlayerInfo(&cl->ps, TSSPI_groupMemberStatus)) {
ADDRLP4 28
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 44
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 44
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 3
EQI4 $619
ADDRLP4 40
INDIRI4
CNSTI4 4
EQI4 $619
ADDRGP4 $616
JUMPV
LABELV $619
line 1137
;1135:			case TSSGMS_designatedLeader:
;1136:			case TSSGMS_temporaryLeader:
;1137:				if (bs->client != i) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
EQI4 $620
line 1140
;1138:					int areanum;
;1139:
;1140:					areanum = BotPointAreaNum(cl->ps.origin);
ADDRLP4 28
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 56
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 52
ADDRLP4 56
INDIRI4
ASGNI4
line 1141
;1141:					if (areanum <= 0) break;
ADDRLP4 52
INDIRI4
CNSTI4 0
GTI4 $622
ADDRGP4 $617
JUMPV
LABELV $622
line 1142
;1142:					if (!trap_AAS_AreaReachability(areanum)) break;
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
NEI4 $624
ADDRGP4 $617
JUMPV
LABELV $624
line 1144
;1143:					if (
;1144:						trap_AAS_AreaTravelTimeToGoalArea(
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
ARGI4
ADDRLP4 64
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 64
INDIRP4
CNSTI4 5984
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
GTI4 $626
line 1147
;1145:							bs->areanum, bs->origin, areanum, bs->tfl
;1146:						) <= 0
;1147:					) {
line 1148
;1148:						break;
ADDRGP4 $617
JUMPV
LABELV $626
line 1150
;1149:					}
;1150:				}
LABELV $620
line 1151
;1151:				bs->leader = i;
ADDRFP4 0
INDIRP4
CNSTI4 11872
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1152
;1152:				return;
ADDRGP4 $557
JUMPV
LABELV $616
LABELV $617
line 1154
;1153:			}
;1154:		}
LABELV $594
line 1122
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $596
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $593
line 1155
;1155:		bs->leader = -1;
ADDRFP4 0
INDIRP4
CNSTI4 11872
ADDP4
CNSTI4 -1
ASGNI4
line 1156
;1156:		return;
ADDRGP4 $557
JUMPV
LABELV $591
line 1160
;1157:	}
;1158:#endif
;1159:
;1160:	bestLeader = -1;
ADDRLP4 16
CNSTI4 -1
ASGNI4
line 1161
;1161:	lowestDanger = 1000000;
ADDRLP4 4
CNSTI4 1000000
ASGNI4
line 1162
;1162:	highestScore = -1000000;
ADDRLP4 12
CNSTI4 -1000000
ASGNI4
line 1163
;1163:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $631
JUMPV
LABELV $628
line 1168
;1164:		const gclient_t* cl;
;1165:		int danger;
;1166:		int score;
;1167:
;1168:		if (!g_entities[i].inuse) continue;
ADDRLP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $633
ADDRGP4 $629
JUMPV
LABELV $633
line 1169
;1169:		cl = g_entities[i].client;
ADDRLP4 28
ADDRLP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
ASGNP4
line 1170
;1170:		if (!cl) continue;
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $637
ADDRGP4 $629
JUMPV
LABELV $637
line 1171
;1171:		if (cl->pers.connected != CON_CONNECTED) continue;
ADDRLP4 28
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $639
ADDRGP4 $629
JUMPV
LABELV $639
line 1172
;1172:		if (cl->sess.sessionTeam != bs->cur_ps.persistant[PERS_TEAM]) continue;
ADDRLP4 28
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
EQI4 $641
ADDRGP4 $629
JUMPV
LABELV $641
line 1173
;1173:		if (cl->ps.stats[STAT_HEALTH] <= 0) continue;
ADDRLP4 28
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $643
ADDRGP4 $629
JUMPV
LABELV $643
line 1174
;1174:		if (cl->tssSafetyMode) continue;
ADDRLP4 28
INDIRP4
CNSTI4 768
ADDP4
INDIRI4
CNSTI4 0
EQI4 $645
ADDRGP4 $629
JUMPV
LABELV $645
line 1175
;1175:		if (cl->ps.powerups[PW_REDFLAG] || cl->ps.powerups[PW_BLUEFLAG]) continue;
ADDRLP4 28
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
NEI4 $649
ADDRLP4 28
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
EQI4 $647
LABELV $649
ADDRGP4 $629
JUMPV
LABELV $647
line 1176
;1176:		danger = BotPlayerDanger(&cl->ps);
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 BotPlayerDanger
CALLI4
ASGNI4
ADDRLP4 32
ADDRLP4 44
INDIRI4
ASGNI4
line 1178
;1177:#if BOTS_USE_TSS
;1178:		if (group >= 0) {
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $650
line 1181
;1179:			qboolean sameGroup;
;1180:
;1181:			sameGroup = qfalse;
ADDRLP4 48
CNSTI4 0
ASGNI4
line 1182
;1182:			if (BG_TSS_GetPlayerInfo(&cl->ps, TSSPI_isValid)) {
ADDRLP4 28
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 52
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $652
line 1183
;1183:				if (BG_TSS_GetPlayerInfo(&cl->ps, TSSPI_group) == group) {
ADDRLP4 28
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 56
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $654
line 1184
;1184:					sameGroup = qtrue;
ADDRLP4 48
CNSTI4 1
ASGNI4
line 1185
;1185:				}
LABELV $654
line 1186
;1186:			}
LABELV $652
line 1187
;1187:			if (!sameGroup) continue;
ADDRLP4 48
INDIRI4
CNSTI4 0
NEI4 $651
ADDRGP4 $629
JUMPV
line 1188
;1188:		}
LABELV $650
line 1191
;1189:		else
;1190:#endif
;1191:		if (cl->sess.teamLeader) {
ADDRLP4 28
INDIRP4
CNSTI4 720
ADDP4
INDIRI4
CNSTI4 0
EQI4 $658
line 1193
;1192:			if (
;1193:				danger < 50
ADDRLP4 32
INDIRI4
CNSTI4 50
LTI4 $663
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
NEI4 $660
LABELV $663
line 1197
;1194:#if MONSTER_MODE
;1195:				|| g_gametype.integer == GT_STU
;1196:#endif
;1197:			) {
line 1198
;1198:				danger = -1000000;
ADDRLP4 32
CNSTI4 -1000000
ASGNI4
line 1199
;1199:			}
LABELV $660
line 1200
;1200:		}
LABELV $658
LABELV $651
line 1201
;1201:		if (danger > lowestDanger) continue;
ADDRLP4 32
INDIRI4
ADDRLP4 4
INDIRI4
LEI4 $664
ADDRGP4 $629
JUMPV
LABELV $664
line 1202
;1202:		score = cl->ps.persistant[PERS_SCORE] - cl->ps.persistant[PERS_KILLED];
ADDRLP4 36
ADDRLP4 28
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
ADDRLP4 28
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
SUBI4
ASGNI4
line 1203
;1203:		if (danger == lowestDanger && score <= highestScore) continue;
ADDRLP4 32
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $666
ADDRLP4 36
INDIRI4
ADDRLP4 12
INDIRI4
GTI4 $666
ADDRGP4 $629
JUMPV
LABELV $666
line 1205
;1204:		if (
;1205:			BotClientIsGuard(bs, i)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 52
ADDRGP4 BotClientIsGuard
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $668
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
EQI4 $668
line 1209
;1206:#if MONSTER_MODE
;1207:			&& g_gametype.integer != GT_STU
;1208:#endif
;1209:		) continue;
ADDRGP4 $629
JUMPV
LABELV $668
line 1227
;1210:/* JUHOX DEBUG
;1211:		if (cl->ps.groundEntityNum != ENTITYNUM_NONE && bs->client != i) {
;1212:			int leaderAreaNum;
;1213:
;1214:			leaderAreaNum = BotPointAreaNum(cl->ps.origin);
;1215:			if (leaderAreaNum <= 0) continue;
;1216:			if (!trap_AAS_AreaReachability(leaderAreaNum)) continue;
;1217:			if (
;1218:				trap_AAS_AreaTravelTimeToGoalArea(
;1219:					bs->areanum, bs->origin, leaderAreaNum, bs->tfl
;1220:				) <= 0
;1221:			) {
;1222:				continue;
;1223:			}
;1224:		}
;1225:*/
;1226:
;1227:		bestLeader = i;
ADDRLP4 16
ADDRLP4 0
INDIRI4
ASGNI4
line 1228
;1228:		lowestDanger = danger;
ADDRLP4 4
ADDRLP4 32
INDIRI4
ASGNI4
line 1229
;1229:		highestScore = score;
ADDRLP4 12
ADDRLP4 36
INDIRI4
ASGNI4
line 1230
;1230:	}
LABELV $629
line 1163
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $631
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $628
line 1231
;1231:	bs->leader = bestLeader;
ADDRFP4 0
INDIRP4
CNSTI4 11872
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 1232
;1232:}
LABELV $557
endproc BotDetermineLeader 516 16
export FindHumanTeamLeader
proc FindHumanTeamLeader 0 0
line 2824
;1233:
;1234:#if 0	// JUHOX: BotCTFOrders_BothFlagsNotAtBase() not needed
;1235:/*
;1236:==================
;1237:BotCTFOrders
;1238:==================
;1239:*/
;1240:void BotCTFOrders_BothFlagsNotAtBase(bot_state_t *bs) {
;1241:	int numteammates, defenders, attackers, i, other;
;1242:	int teammates[MAX_CLIENTS];
;1243:	char name[MAX_NETNAME], carriername[MAX_NETNAME];
;1244:
;1245:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
;1246:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
;1247:	//different orders based on the number of team mates
;1248:	switch(bs->numteammates) {
;1249:		case 1: break;
;1250:		case 2:
;1251:		{
;1252:			//tell the one not carrying the flag to attack the enemy base
;1253:			if (teammates[0] != bs->flagcarrier) other = teammates[0];
;1254:			else other = teammates[1];
;1255:			ClientName(other, name, sizeof(name));
;1256:			BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1257:			BotSayTeamOrder(bs, other);
;1258:			BotSayVoiceTeamOrder(bs, other, VOICECHAT_GETFLAG);
;1259:			break;
;1260:		}
;1261:		case 3:
;1262:		{
;1263:			//tell the one closest to the base not carrying the flag to accompany the flag carrier
;1264:			if (teammates[0] != bs->flagcarrier) other = teammates[0];
;1265:			else other = teammates[1];
;1266:			ClientName(other, name, sizeof(name));
;1267:			if ( bs->flagcarrier != -1 ) {
;1268:				ClientName(bs->flagcarrier, carriername, sizeof(carriername));
;1269:				if (bs->flagcarrier == bs->client) {
;1270:					BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
;1271:					BotSayVoiceTeamOrder(bs, other, VOICECHAT_FOLLOWME);
;1272:				}
;1273:				else {
;1274:					BotAI_BotInitialChat(bs, "cmd_accompany", name, carriername, NULL);
;1275:					BotSayVoiceTeamOrder(bs, other, VOICECHAT_FOLLOWFLAGCARRIER);
;1276:				}
;1277:			}
;1278:			else {
;1279:				//
;1280:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1281:				BotSayVoiceTeamOrder(bs, other, VOICECHAT_GETFLAG);
;1282:			}
;1283:			BotSayTeamOrder(bs, other);
;1284:			//tell the one furthest from the the base not carrying the flag to get the enemy flag
;1285:			if (teammates[2] != bs->flagcarrier) other = teammates[2];
;1286:			else other = teammates[1];
;1287:			ClientName(other, name, sizeof(name));
;1288:			BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1289:			BotSayTeamOrder(bs, other);
;1290:			BotSayVoiceTeamOrder(bs, other, VOICECHAT_RETURNFLAG);
;1291:			break;
;1292:		}
;1293:		default:
;1294:		{
;1295:			defenders = (int) (float) numteammates * 0.4 + 0.5;
;1296:			if (defenders > 4) defenders = 4;
;1297:			attackers = (int) (float) numteammates * 0.5 + 0.5;
;1298:			if (attackers > 5) attackers = 5;
;1299:			if (bs->flagcarrier != -1) {
;1300:				ClientName(bs->flagcarrier, carriername, sizeof(carriername));
;1301:				for (i = 0; i < defenders; i++) {
;1302:					//
;1303:					if (teammates[i] == bs->flagcarrier) {
;1304:						continue;
;1305:					}
;1306:					//
;1307:					ClientName(teammates[i], name, sizeof(name));
;1308:					if (bs->flagcarrier == bs->client) {
;1309:						BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
;1310:						BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_FOLLOWME);
;1311:					}
;1312:					else {
;1313:						BotAI_BotInitialChat(bs, "cmd_accompany", name, carriername, NULL);
;1314:						BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_FOLLOWFLAGCARRIER);
;1315:					}
;1316:					BotSayTeamOrder(bs, teammates[i]);
;1317:				}
;1318:			}
;1319:			else {
;1320:				for (i = 0; i < defenders; i++) {
;1321:					//
;1322:					if (teammates[i] == bs->flagcarrier) {
;1323:						continue;
;1324:					}
;1325:					//
;1326:					ClientName(teammates[i], name, sizeof(name));
;1327:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1328:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_GETFLAG);
;1329:					BotSayTeamOrder(bs, teammates[i]);
;1330:				}
;1331:			}
;1332:			for (i = 0; i < attackers; i++) {
;1333:				//
;1334:				if (teammates[numteammates - i - 1] == bs->flagcarrier) {
;1335:					continue;
;1336:				}
;1337:				//
;1338:				ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1339:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1340:				BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1341:				BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_RETURNFLAG);
;1342:			}
;1343:			//
;1344:			break;
;1345:		}
;1346:	}
;1347:}
;1348:#endif
;1349:
;1350:#if 0	// JUHOX: BotCTFOrders_FlagNotAtBase() not needed
;1351:/*
;1352:==================
;1353:BotCTFOrders
;1354:==================
;1355:*/
;1356:void BotCTFOrders_FlagNotAtBase(bot_state_t *bs) {
;1357:	int numteammates, defenders, attackers, i;
;1358:	int teammates[MAX_CLIENTS];
;1359:	char name[MAX_NETNAME];
;1360:
;1361:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
;1362:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
;1363:	//passive strategy
;1364:	if (!(bs->ctfstrategy & CTFS_AGRESSIVE)) {
;1365:		//different orders based on the number of team mates
;1366:		switch(bs->numteammates) {
;1367:			case 1: break;
;1368:			case 2:
;1369:			{
;1370:				//both will go for the enemy flag
;1371:				ClientName(teammates[0], name, sizeof(name));
;1372:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1373:				BotSayTeamOrder(bs, teammates[0]);
;1374:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_GETFLAG);
;1375:				//
;1376:				ClientName(teammates[1], name, sizeof(name));
;1377:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1378:				BotSayTeamOrder(bs, teammates[1]);
;1379:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
;1380:				break;
;1381:			}
;1382:			case 3:
;1383:			{
;1384:				//keep one near the base for when the flag is returned
;1385:				ClientName(teammates[0], name, sizeof(name));
;1386:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1387:				BotSayTeamOrder(bs, teammates[0]);
;1388:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1389:				//the other two get the flag
;1390:				ClientName(teammates[1], name, sizeof(name));
;1391:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1392:				BotSayTeamOrder(bs, teammates[1]);
;1393:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
;1394:				//
;1395:				ClientName(teammates[2], name, sizeof(name));
;1396:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1397:				BotSayTeamOrder(bs, teammates[2]);
;1398:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
;1399:				break;
;1400:			}
;1401:			default:
;1402:			{
;1403:				//keep some people near the base for when the flag is returned
;1404:				defenders = (int) (float) numteammates * 0.3 + 0.5;
;1405:				if (defenders > 3) defenders = 3;
;1406:				attackers = (int) (float) numteammates * 0.7 + 0.5;
;1407:				if (attackers > 6) attackers = 6;
;1408:				for (i = 0; i < defenders; i++) {
;1409:					//
;1410:					ClientName(teammates[i], name, sizeof(name));
;1411:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1412:					BotSayTeamOrder(bs, teammates[i]);
;1413:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;1414:				}
;1415:				for (i = 0; i < attackers; i++) {
;1416:					//
;1417:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1418:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1419:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1420:					BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_GETFLAG);
;1421:				}
;1422:				//
;1423:				break;
;1424:			}
;1425:		}
;1426:	}
;1427:	else {
;1428:		//different orders based on the number of team mates
;1429:		switch(bs->numteammates) {
;1430:			case 1: break;
;1431:			case 2:
;1432:			{
;1433:				//both will go for the enemy flag
;1434:				ClientName(teammates[0], name, sizeof(name));
;1435:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1436:				BotSayTeamOrder(bs, teammates[0]);
;1437:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_GETFLAG);
;1438:				//
;1439:				ClientName(teammates[1], name, sizeof(name));
;1440:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1441:				BotSayTeamOrder(bs, teammates[1]);
;1442:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
;1443:				break;
;1444:			}
;1445:			case 3:
;1446:			{
;1447:				//everyone go for the flag
;1448:				ClientName(teammates[0], name, sizeof(name));
;1449:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1450:				BotSayTeamOrder(bs, teammates[0]);
;1451:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_GETFLAG);
;1452:				//
;1453:				ClientName(teammates[1], name, sizeof(name));
;1454:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1455:				BotSayTeamOrder(bs, teammates[1]);
;1456:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
;1457:				//
;1458:				ClientName(teammates[2], name, sizeof(name));
;1459:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1460:				BotSayTeamOrder(bs, teammates[2]);
;1461:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
;1462:				break;
;1463:			}
;1464:			default:
;1465:			{
;1466:				//keep some people near the base for when the flag is returned
;1467:				defenders = (int) (float) numteammates * 0.2 + 0.5;
;1468:				if (defenders > 2) defenders = 2;
;1469:				attackers = (int) (float) numteammates * 0.7 + 0.5;
;1470:				if (attackers > 7) attackers = 7;
;1471:				for (i = 0; i < defenders; i++) {
;1472:					//
;1473:					ClientName(teammates[i], name, sizeof(name));
;1474:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1475:					BotSayTeamOrder(bs, teammates[i]);
;1476:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;1477:				}
;1478:				for (i = 0; i < attackers; i++) {
;1479:					//
;1480:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1481:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1482:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1483:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
;1484:				}
;1485:				//
;1486:				break;
;1487:			}
;1488:		}
;1489:	}
;1490:}
;1491:#endif
;1492:
;1493:// JUHOX: BotCTFOrders_EnemyFlagNotAtBase() not needed
;1494:#if 0
;1495:/*
;1496:==================
;1497:BotCTFOrders
;1498:==================
;1499:*/
;1500:void BotCTFOrders_EnemyFlagNotAtBase(bot_state_t *bs) {
;1501:	int numteammates, defenders, attackers, i, other;
;1502:	int teammates[MAX_CLIENTS];
;1503:	char name[MAX_NETNAME], carriername[MAX_NETNAME];
;1504:
;1505:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
;1506:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
;1507:	//different orders based on the number of team mates
;1508:	switch(numteammates) {
;1509:		case 1: break;
;1510:		case 2:
;1511:		{
;1512:			//tell the one not carrying the flag to defend the base
;1513:			if (teammates[0] == bs->flagcarrier) other = teammates[1];
;1514:			else other = teammates[0];
;1515:			ClientName(other, name, sizeof(name));
;1516:			BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1517:			BotSayTeamOrder(bs, other);
;1518:			BotSayVoiceTeamOrder(bs, other, VOICECHAT_DEFEND);
;1519:			break;
;1520:		}
;1521:		case 3:
;1522:		{
;1523:			//tell the one closest to the base not carrying the flag to defend the base
;1524:			if (teammates[0] != bs->flagcarrier) other = teammates[0];
;1525:			else other = teammates[1];
;1526:			ClientName(other, name, sizeof(name));
;1527:			BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1528:			BotSayTeamOrder(bs, other);
;1529:			BotSayVoiceTeamOrder(bs, other, VOICECHAT_DEFEND);
;1530:			//tell the other also to defend the base
;1531:			if (teammates[2] != bs->flagcarrier) other = teammates[2];
;1532:			else other = teammates[1];
;1533:			ClientName(other, name, sizeof(name));
;1534:			BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1535:			BotSayTeamOrder(bs, other);
;1536:			BotSayVoiceTeamOrder(bs, other, VOICECHAT_DEFEND);
;1537:			break;
;1538:		}
;1539:		default:
;1540:		{
;1541:			//60% will defend the base
;1542:			defenders = (int) (float) numteammates * 0.6 + 0.5;
;1543:			if (defenders > 6) defenders = 6;
;1544:			//30% accompanies the flag carrier
;1545:			attackers = (int) (float) numteammates * 0.3 + 0.5;
;1546:			if (attackers > 3) attackers = 3;
;1547:			for (i = 0; i < defenders; i++) {
;1548:				//
;1549:				if (teammates[i] == bs->flagcarrier) {
;1550:					continue;
;1551:				}
;1552:				ClientName(teammates[i], name, sizeof(name));
;1553:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1554:				BotSayTeamOrder(bs, teammates[i]);
;1555:				BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;1556:			}
;1557:			// if we have a flag carrier
;1558:			if ( bs->flagcarrier != -1 ) {
;1559:				ClientName(bs->flagcarrier, carriername, sizeof(carriername));
;1560:				for (i = 0; i < attackers; i++) {
;1561:					//
;1562:					if (teammates[numteammates - i - 1] == bs->flagcarrier) {
;1563:						continue;
;1564:					}
;1565:					//
;1566:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1567:					if (bs->flagcarrier == bs->client) {
;1568:						BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
;1569:						BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_FOLLOWME);
;1570:					}
;1571:					else {
;1572:						BotAI_BotInitialChat(bs, "cmd_accompany", name, carriername, NULL);
;1573:						BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_FOLLOWFLAGCARRIER);
;1574:					}
;1575:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1576:				}
;1577:			}
;1578:			else {
;1579:				for (i = 0; i < attackers; i++) {
;1580:					//
;1581:					if (teammates[numteammates - i - 1] == bs->flagcarrier) {
;1582:						continue;
;1583:					}
;1584:					//
;1585:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1586:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1587:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
;1588:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1589:				}
;1590:			}
;1591:			//
;1592:			break;
;1593:		}
;1594:	}
;1595:}
;1596:#endif
;1597:
;1598:
;1599:// JUHOX: BotCTFOrders_BothFlagsAtBase() not needed
;1600:#if 0
;1601:/*
;1602:==================
;1603:BotCTFOrders
;1604:==================
;1605:*/
;1606:void BotCTFOrders_BothFlagsAtBase(bot_state_t *bs) {
;1607:	int numteammates, defenders, attackers, i;
;1608:	int teammates[MAX_CLIENTS];
;1609:	char name[MAX_NETNAME];
;1610:
;1611:	//sort team mates by travel time to base
;1612:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
;1613:	//sort team mates by CTF preference
;1614:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
;1615:	//passive strategy
;1616:	if (!(bs->ctfstrategy & CTFS_AGRESSIVE)) {
;1617:		//different orders based on the number of team mates
;1618:		switch(numteammates) {
;1619:			case 1: break;
;1620:			case 2:
;1621:			{
;1622:				//the one closest to the base will defend the base
;1623:				ClientName(teammates[0], name, sizeof(name));
;1624:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1625:				BotSayTeamOrder(bs, teammates[0]);
;1626:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1627:				//the other will get the flag
;1628:				ClientName(teammates[1], name, sizeof(name));
;1629:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1630:				BotSayTeamOrder(bs, teammates[1]);
;1631:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
;1632:				break;
;1633:			}
;1634:			case 3:
;1635:			{
;1636:				//the one closest to the base will defend the base
;1637:				ClientName(teammates[0], name, sizeof(name));
;1638:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1639:				BotSayTeamOrder(bs, teammates[0]);
;1640:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1641:				//the second one closest to the base will defend the base
;1642:				ClientName(teammates[1], name, sizeof(name));
;1643:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1644:				BotSayTeamOrder(bs, teammates[1]);
;1645:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_DEFEND);
;1646:				//the other will get the flag
;1647:				ClientName(teammates[2], name, sizeof(name));
;1648:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1649:				BotSayTeamOrder(bs, teammates[2]);
;1650:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
;1651:				break;
;1652:			}
;1653:			default:
;1654:			{
;1655:				defenders = (int) (float) numteammates * 0.5 + 0.5;
;1656:				if (defenders > 5) defenders = 5;
;1657:				attackers = (int) (float) numteammates * 0.4 + 0.5;
;1658:				if (attackers > 4) attackers = 4;
;1659:				for (i = 0; i < defenders; i++) {
;1660:					//
;1661:					ClientName(teammates[i], name, sizeof(name));
;1662:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1663:					BotSayTeamOrder(bs, teammates[i]);
;1664:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;1665:				}
;1666:				for (i = 0; i < attackers; i++) {
;1667:					//
;1668:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1669:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1670:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1671:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
;1672:				}
;1673:				//
;1674:				break;
;1675:			}
;1676:		}
;1677:	}
;1678:	else {
;1679:		//different orders based on the number of team mates
;1680:		switch(numteammates) {
;1681:			case 1: break;
;1682:			case 2:
;1683:			{
;1684:				//the one closest to the base will defend the base
;1685:				ClientName(teammates[0], name, sizeof(name));
;1686:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1687:				BotSayTeamOrder(bs, teammates[0]);
;1688:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1689:				//the other will get the flag
;1690:				ClientName(teammates[1], name, sizeof(name));
;1691:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1692:				BotSayTeamOrder(bs, teammates[1]);
;1693:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
;1694:				break;
;1695:			}
;1696:			case 3:
;1697:			{
;1698:				//the one closest to the base will defend the base
;1699:				ClientName(teammates[0], name, sizeof(name));
;1700:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1701:				BotSayTeamOrder(bs, teammates[0]);
;1702:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1703:				//the others should go for the enemy flag
;1704:				ClientName(teammates[1], name, sizeof(name));
;1705:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1706:				BotSayTeamOrder(bs, teammates[1]);
;1707:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
;1708:				//
;1709:				ClientName(teammates[2], name, sizeof(name));
;1710:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1711:				BotSayTeamOrder(bs, teammates[2]);
;1712:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
;1713:				break;
;1714:			}
;1715:			default:
;1716:			{
;1717:				defenders = (int) (float) numteammates * 0.4 + 0.5;
;1718:				if (defenders > 4) defenders = 4;
;1719:				attackers = (int) (float) numteammates * 0.5 + 0.5;
;1720:				if (attackers > 5) attackers = 5;
;1721:				for (i = 0; i < defenders; i++) {
;1722:					//
;1723:					ClientName(teammates[i], name, sizeof(name));
;1724:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1725:					BotSayTeamOrder(bs, teammates[i]);
;1726:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;1727:				}
;1728:				for (i = 0; i < attackers; i++) {
;1729:					//
;1730:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1731:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1732:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1733:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
;1734:				}
;1735:				//
;1736:				break;
;1737:			}
;1738:		}
;1739:	}
;1740:}
;1741:#endif
;1742:
;1743:// JUHOX: BotCTFOrders() not needed
;1744:#if 0
;1745:/*
;1746:==================
;1747:BotCTFOrders
;1748:==================
;1749:*/
;1750:void BotCTFOrders(bot_state_t *bs) {
;1751:	int flagstatus;
;1752:
;1753:	//
;1754:	if (BotTeam(bs) == TEAM_RED) flagstatus = bs->redflagstatus * 2 + bs->blueflagstatus;
;1755:	else flagstatus = bs->blueflagstatus * 2 + bs->redflagstatus;
;1756:	//
;1757:	switch(flagstatus) {
;1758:		case 0: BotCTFOrders_BothFlagsAtBase(bs); break;
;1759:		case 1: BotCTFOrders_EnemyFlagNotAtBase(bs); break;
;1760:		case 2: BotCTFOrders_FlagNotAtBase(bs); break;
;1761:		case 3: BotCTFOrders_BothFlagsNotAtBase(bs); break;
;1762:	}
;1763:}
;1764:#endif
;1765:
;1766:
;1767:// JUHOX: BotCreateGroup() not needed
;1768:#if 0
;1769:/*
;1770:==================
;1771:BotCreateGroup
;1772:==================
;1773:*/
;1774:void BotCreateGroup(bot_state_t *bs, int *teammates, int groupsize) {
;1775:	char name[MAX_NETNAME], leadername[MAX_NETNAME];
;1776:	int i;
;1777:
;1778:	// the others in the group will follow the teammates[0]
;1779:	ClientName(teammates[0], leadername, sizeof(leadername));
;1780:	for (i = 1; i < groupsize; i++)
;1781:	{
;1782:		ClientName(teammates[i], name, sizeof(name));
;1783:		if (teammates[0] == bs->client) {
;1784:			BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
;1785:		}
;1786:		else {
;1787:			BotAI_BotInitialChat(bs, "cmd_accompany", name, leadername, NULL);
;1788:		}
;1789:		BotSayTeamOrderAlways(bs, teammates[i]);
;1790:	}
;1791:}
;1792:#endif
;1793:
;1794:// JUHOX: (original) BotTeamOrders() not needed
;1795:#if 0
;1796:/*
;1797:==================
;1798:BotTeamOrders
;1799:
;1800:  FIXME: defend key areas?
;1801:==================
;1802:*/
;1803:void BotTeamOrders(bot_state_t *bs) {
;1804:	int teammates[MAX_CLIENTS];
;1805:	int numteammates, i;
;1806:	char buf[MAX_INFO_STRING];
;1807:	static int maxclients;
;1808:
;1809:	if (!maxclients)
;1810:		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
;1811:
;1812:	numteammates = 0;
;1813:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
;1814:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
;1815:		//if no config string or no name
;1816:		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n"))) continue;
;1817:		//skip spectators
;1818:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) continue;
;1819:		//
;1820:		if (BotSameTeam(bs, i)) {
;1821:			teammates[numteammates] = i;
;1822:			numteammates++;
;1823:		}
;1824:	}
;1825:	//
;1826:	switch(numteammates) {
;1827:		case 1: break;
;1828:		case 2:
;1829:		{
;1830:			//nothing special
;1831:			break;
;1832:		}
;1833:		case 3:
;1834:		{
;1835:			//have one follow another and one free roaming
;1836:			BotCreateGroup(bs, teammates, 2);
;1837:			break;
;1838:		}
;1839:		case 4:
;1840:		{
;1841:			BotCreateGroup(bs, teammates, 2);		//a group of 2
;1842:			BotCreateGroup(bs, &teammates[2], 2);	//a group of 2
;1843:			break;
;1844:		}
;1845:		case 5:
;1846:		{
;1847:			BotCreateGroup(bs, teammates, 2);		//a group of 2
;1848:			BotCreateGroup(bs, &teammates[2], 3);	//a group of 3
;1849:			break;
;1850:		}
;1851:		default:
;1852:		{
;1853:			if (numteammates <= 10) {
;1854:				for (i = 0; i < numteammates / 2; i++) {
;1855:					BotCreateGroup(bs, &teammates[i*2], 2);	//groups of 2
;1856:				}
;1857:			}
;1858:			break;
;1859:		}
;1860:	}
;1861:}
;1862:#endif
;1863:
;1864:#ifdef MISSIONPACK
;1865:
;1866:/*
;1867:==================
;1868:Bot1FCTFOrders_FlagAtCenter
;1869:
;1870:  X% defend the base, Y% get the flag
;1871:==================
;1872:*/
;1873:void Bot1FCTFOrders_FlagAtCenter(bot_state_t *bs) {
;1874:	int numteammates, defenders, attackers, i;
;1875:	int teammates[MAX_CLIENTS];
;1876:	char name[MAX_NETNAME];
;1877:
;1878:	//sort team mates by travel time to base
;1879:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
;1880:	//sort team mates by CTF preference
;1881:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
;1882:	//passive strategy
;1883:	if (!(bs->ctfstrategy & CTFS_AGRESSIVE)) {
;1884:		//different orders based on the number of team mates
;1885:		switch(numteammates) {
;1886:			case 1: break;
;1887:			case 2:
;1888:			{
;1889:				//the one closest to the base will defend the base
;1890:				ClientName(teammates[0], name, sizeof(name));
;1891:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1892:				BotSayTeamOrder(bs, teammates[0]);
;1893:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1894:				//the other will get the flag
;1895:				ClientName(teammates[1], name, sizeof(name));
;1896:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1897:				BotSayTeamOrder(bs, teammates[1]);
;1898:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
;1899:				break;
;1900:			}
;1901:			case 3:
;1902:			{
;1903:				//the one closest to the base will defend the base
;1904:				ClientName(teammates[0], name, sizeof(name));
;1905:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1906:				BotSayTeamOrder(bs, teammates[0]);
;1907:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1908:				//the second one closest to the base will defend the base
;1909:				ClientName(teammates[1], name, sizeof(name));
;1910:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1911:				BotSayTeamOrder(bs, teammates[1]);
;1912:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1913:				//the other will get the flag
;1914:				ClientName(teammates[2], name, sizeof(name));
;1915:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1916:				BotSayTeamOrder(bs, teammates[2]);
;1917:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
;1918:				break;
;1919:			}
;1920:			default:
;1921:			{
;1922:				//50% defend the base
;1923:				defenders = (int) (float) numteammates * 0.5 + 0.5;
;1924:				if (defenders > 5) defenders = 5;
;1925:				//40% get the flag
;1926:				attackers = (int) (float) numteammates * 0.4 + 0.5;
;1927:				if (attackers > 4) attackers = 4;
;1928:				for (i = 0; i < defenders; i++) {
;1929:					//
;1930:					ClientName(teammates[i], name, sizeof(name));
;1931:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1932:					BotSayTeamOrder(bs, teammates[i]);
;1933:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;1934:				}
;1935:				for (i = 0; i < attackers; i++) {
;1936:					//
;1937:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1938:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1939:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1940:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
;1941:				}
;1942:				//
;1943:				break;
;1944:			}
;1945:		}
;1946:	}
;1947:	else { //agressive
;1948:		//different orders based on the number of team mates
;1949:		switch(numteammates) {
;1950:			case 1: break;
;1951:			case 2:
;1952:			{
;1953:				//the one closest to the base will defend the base
;1954:				ClientName(teammates[0], name, sizeof(name));
;1955:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1956:				BotSayTeamOrder(bs, teammates[0]);
;1957:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1958:				//the other will get the flag
;1959:				ClientName(teammates[1], name, sizeof(name));
;1960:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1961:				BotSayTeamOrder(bs, teammates[1]);
;1962:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
;1963:				break;
;1964:			}
;1965:			case 3:
;1966:			{
;1967:				//the one closest to the base will defend the base
;1968:				ClientName(teammates[0], name, sizeof(name));
;1969:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1970:				BotSayTeamOrder(bs, teammates[0]);
;1971:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1972:				//the others should go for the enemy flag
;1973:				ClientName(teammates[1], name, sizeof(name));
;1974:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1975:				BotSayTeamOrder(bs, teammates[1]);
;1976:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
;1977:				//
;1978:				ClientName(teammates[2], name, sizeof(name));
;1979:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1980:				BotSayTeamOrder(bs, teammates[2]);
;1981:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
;1982:				break;
;1983:			}
;1984:			default:
;1985:			{
;1986:				//30% defend the base
;1987:				defenders = (int) (float) numteammates * 0.3 + 0.5;
;1988:				if (defenders > 3) defenders = 3;
;1989:				//60% get the flag
;1990:				attackers = (int) (float) numteammates * 0.6 + 0.5;
;1991:				if (attackers > 6) attackers = 6;
;1992:				for (i = 0; i < defenders; i++) {
;1993:					//
;1994:					ClientName(teammates[i], name, sizeof(name));
;1995:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1996:					BotSayTeamOrder(bs, teammates[i]);
;1997:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;1998:				}
;1999:				for (i = 0; i < attackers; i++) {
;2000:					//
;2001:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;2002:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;2003:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;2004:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
;2005:				}
;2006:				//
;2007:				break;
;2008:			}
;2009:		}
;2010:	}
;2011:}
;2012:
;2013:/*
;2014:==================
;2015:Bot1FCTFOrders_TeamHasFlag
;2016:
;2017:  X% towards neutral flag, Y% go towards enemy base and accompany flag carrier if visible
;2018:==================
;2019:*/
;2020:void Bot1FCTFOrders_TeamHasFlag(bot_state_t *bs) {
;2021:	int numteammates, defenders, attackers, i, other;
;2022:	int teammates[MAX_CLIENTS];
;2023:	char name[MAX_NETNAME], carriername[MAX_NETNAME];
;2024:
;2025:	//sort team mates by travel time to base
;2026:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
;2027:	//sort team mates by CTF preference
;2028:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
;2029:	//passive strategy
;2030:	if (!(bs->ctfstrategy & CTFS_AGRESSIVE)) {
;2031:		//different orders based on the number of team mates
;2032:		switch(numteammates) {
;2033:			case 1: break;
;2034:			case 2:
;2035:			{
;2036:				//tell the one not carrying the flag to attack the enemy base
;2037:				if (teammates[0] == bs->flagcarrier) other = teammates[1];
;2038:				else other = teammates[0];
;2039:				ClientName(other, name, sizeof(name));
;2040:				BotAI_BotInitialChat(bs, "cmd_attackenemybase", name, NULL);
;2041:				BotSayTeamOrder(bs, other);
;2042:				BotSayVoiceTeamOrder(bs, other, VOICECHAT_OFFENSE);
;2043:				break;
;2044:			}
;2045:			case 3:
;2046:			{
;2047:				//tell the one closest to the base not carrying the flag to defend the base
;2048:				if (teammates[0] != bs->flagcarrier) other = teammates[0];
;2049:				else other = teammates[1];
;2050:				ClientName(other, name, sizeof(name));
;2051:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;2052:				BotSayTeamOrder(bs, other);
;2053:				BotSayVoiceTeamOrder(bs, other, VOICECHAT_DEFEND);
;2054:				//tell the one furthest from the base not carrying the flag to accompany the flag carrier
;2055:				if (teammates[2] != bs->flagcarrier) other = teammates[2];
;2056:				else other = teammates[1];
;2057:				ClientName(other, name, sizeof(name));
;2058:				if ( bs->flagcarrier != -1 ) {
;2059:					ClientName(bs->flagcarrier, carriername, sizeof(carriername));
;2060:					if (bs->flagcarrier == bs->client) {
;2061:						BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
;2062:						BotSayVoiceTeamOrder(bs, other, VOICECHAT_FOLLOWME);
;2063:					}
;2064:					else {
;2065:						BotAI_BotInitialChat(bs, "cmd_accompany", name, carriername, NULL);
;2066:						BotSayVoiceTeamOrder(bs, other, VOICECHAT_FOLLOWFLAGCARRIER);
;2067:					}
;2068:				}
;2069:				else {
;2070:					//
;2071:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;2072:					BotSayVoiceTeamOrder(bs, other, VOICECHAT_GETFLAG);
;2073:				}
;2074:				BotSayTeamOrder(bs, other);
;2075:				break;
;2076:			}
;2077:			default:
;2078:			{
;2079:				//30% will defend the base
;2080:				defenders = (int) (float) numteammates * 0.3 + 0.5;
;2081:				if (defenders > 3) defenders = 3;
;2082:				//70% accompanies the flag carrier
;2083:				attackers = (int) (float) numteammates * 0.7 + 0.5;
;2084:				if (attackers > 7) attackers = 7;
;2085:				for (i = 0; i < defenders; i++) {
;2086:					//
;2087:					if (teammates[i] == bs->flagcarrier) {
;2088:						continue;
;2089:					}
;2090:					ClientName(teammates[i], name, sizeof(name));
;2091:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;2092:					BotSayTeamOrder(bs, teammates[i]);
;2093:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;2094:				}
;2095:				if (bs->flagcarrier != -1) {
;2096:					ClientName(bs->flagcarrier, carriername, sizeof(carriername));
;2097:					for (i = 0; i < attackers; i++) {
;2098:						//
;2099:						if (teammates[numteammates - i - 1] == bs->flagcarrier) {
;2100:							continue;
;2101:						}
;2102:						//
;2103:						ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;2104:						if (bs->flagcarrier == bs->client) {
;2105:							BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
;2106:							BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_FOLLOWME);
;2107:						}
;2108:						else {
;2109:							BotAI_BotInitialChat(bs, "cmd_accompany", name, carriername, NULL);
;2110:							BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_FOLLOWFLAGCARRIER);
;2111:						}
;2112:						BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;2113:					}
;2114:				}
;2115:				else {
;2116:					for (i = 0; i < attackers; i++) {
;2117:						//
;2118:						if (teammates[numteammates - i - 1] == bs->flagcarrier) {
;2119:							continue;
;2120:						}
;2121:						//
;2122:						ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;2123:						BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;2124:						BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;2125:						BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
;2126:					}
;2127:				}
;2128:				//
;2129:				break;
;2130:			}
;2131:		}
;2132:	}
;2133:	else { //agressive
;2134:		//different orders based on the number of team mates
;2135:		switch(numteammates) {
;2136:			case 1: break;
;2137:			case 2:
;2138:			{
;2139:				//tell the one not carrying the flag to defend the base
;2140:				if (teammates[0] == bs->flagcarrier) other = teammates[1];
;2141:				else other = teammates[0];
;2142:				ClientName(other, name, sizeof(name));
;2143:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;2144:				BotSayTeamOrder(bs, other);
;2145:				BotSayVoiceTeamOrder(bs, other, VOICECHAT_DEFEND);
;2146:				break;
;2147:			}
;2148:			case 3:
;2149:			{
;2150:				//tell the one closest to the base not carrying the flag to defend the base
;2151:				if (teammates[0] != bs->flagcarrier) other = teammates[0];
;2152:				else other = teammates[1];
;2153:				ClientName(other, name, sizeof(name));
;2154:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;2155:				BotSayTeamOrder(bs, other);
;2156:				BotSayVoiceTeamOrder(bs, other, VOICECHAT_DEFEND);
;2157:				//tell the one furthest from the base not carrying the flag to accompany the flag carrier
;2158:				if (teammates[2] != bs->flagcarrier) other = teammates[2];
;2159:				else other = teammates[1];
;2160:				ClientName(other, name, sizeof(name));
;2161:				ClientName(bs->flagcarrier, carriername, sizeof(carriername));
;2162:				if (bs->flagcarrier == bs->client) {
;2163:					BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
;2164:					BotSayVoiceTeamOrder(bs, other, VOICECHAT_FOLLOWME);
;2165:				}
;2166:				else {
;2167:					BotAI_BotInitialChat(bs, "cmd_accompany", name, carriername, NULL);
;2168:					BotSayVoiceTeamOrder(bs, other, VOICECHAT_FOLLOWFLAGCARRIER);
;2169:				}
;2170:				BotSayTeamOrder(bs, other);
;2171:				break;
;2172:			}
;2173:			default:
;2174:			{
;2175:				//20% will defend the base
;2176:				defenders = (int) (float) numteammates * 0.2 + 0.5;
;2177:				if (defenders > 2) defenders = 2;
;2178:				//80% accompanies the flag carrier
;2179:				attackers = (int) (float) numteammates * 0.8 + 0.5;
;2180:				if (attackers > 8) attackers = 8;
;2181:				for (i = 0; i < defenders; i++) {
;2182:					//
;2183:					if (teammates[i] == bs->flagcarrier) {
;2184:						continue;
;2185:					}
;2186:					ClientName(teammates[i], name, sizeof(name));
;2187:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;2188:					BotSayTeamOrder(bs, teammates[i]);
;2189:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;2190:				}
;2191:				ClientName(bs->flagcarrier, carriername, sizeof(carriername));
;2192:				for (i = 0; i < attackers; i++) {
;2193:					//
;2194:					if (teammates[numteammates - i - 1] == bs->flagcarrier) {
;2195:						continue;
;2196:					}
;2197:					//
;2198:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;2199:					if (bs->flagcarrier == bs->client) {
;2200:						BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
;2201:						BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_FOLLOWME);
;2202:					}
;2203:					else {
;2204:						BotAI_BotInitialChat(bs, "cmd_accompany", name, carriername, NULL);
;2205:						BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_FOLLOWFLAGCARRIER);
;2206:					}
;2207:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;2208:				}
;2209:				//
;2210:				break;
;2211:			}
;2212:		}
;2213:	}
;2214:}
;2215:
;2216:/*
;2217:==================
;2218:Bot1FCTFOrders_EnemyHasFlag
;2219:
;2220:  X% defend the base, Y% towards neutral flag
;2221:==================
;2222:*/
;2223:void Bot1FCTFOrders_EnemyHasFlag(bot_state_t *bs) {
;2224:	int numteammates, defenders, attackers, i;
;2225:	int teammates[MAX_CLIENTS];
;2226:	char name[MAX_NETNAME];
;2227:
;2228:	//sort team mates by travel time to base
;2229:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
;2230:	//sort team mates by CTF preference
;2231:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
;2232:	//passive strategy
;2233:	if (!(bs->ctfstrategy & CTFS_AGRESSIVE)) {
;2234:		//different orders based on the number of team mates
;2235:		switch(numteammates) {
;2236:			case 1: break;
;2237:			case 2:
;2238:			{
;2239:				//both defend the base
;2240:				ClientName(teammates[0], name, sizeof(name));
;2241:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;2242:				BotSayTeamOrder(bs, teammates[0]);
;2243:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;2244:				//
;2245:				ClientName(teammates[1], name, sizeof(name));
;2246:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;2247:				BotSayTeamOrder(bs, teammates[1]);
;2248:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_DEFEND);
;2249:				break;
;2250:			}
;2251:			case 3:
;2252:			{
;2253:				//the one closest to the base will defend the base
;2254:				ClientName(teammates[0], name, sizeof(name));
;2255:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;2256:				BotSayTeamOrder(bs, teammates[0]);
;2257:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;2258:				//the second one closest to the base will defend the base
;2259:				ClientName(teammates[1], name, sizeof(name));
;2260:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;2261:				BotSayTeamOrder(bs, teammates[1]);
;2262:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_DEFEND);
;2263:				//the other will also defend the base
;2264:				ClientName(teammates[2], name, sizeof(name));
;2265:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;2266:				BotSayTeamOrder(bs, teammates[2]);
;2267:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_DEFEND);
;2268:				break;
;2269:			}
;2270:			default:
;2271:			{
;2272:				//80% will defend the base
;2273:				defenders = (int) (float) numteammates * 0.8 + 0.5;
;2274:				if (defenders > 8) defenders = 8;
;2275:				//10% will try to return the flag
;2276:				attackers = (int) (float) numteammates * 0.1 + 0.5;
;2277:				if (attackers > 2) attackers = 2;
;2278:				for (i = 0; i < defenders; i++) {
;2279:					//
;2280:					ClientName(teammates[i], name, sizeof(name));
;2281:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;2282:					BotSayTeamOrder(bs, teammates[i]);
;2283:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;2284:				}
;2285:				for (i = 0; i < attackers; i++) {
;2286:					//
;2287:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;2288:					BotAI_BotInitialChat(bs, "cmd_returnflag", name, NULL);
;2289:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;2290:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
;2291:				}
;2292:				//
;2293:				break;
;2294:			}
;2295:		}
;2296:	}
;2297:	else { //agressive
;2298:		//different orders based on the number of team mates
;2299:		switch(numteammates) {
;2300:			case 1: break;
;2301:			case 2:
;2302:			{
;2303:				//the one closest to the base will defend the base
;2304:				ClientName(teammates[0], name, sizeof(name));
;2305:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;2306:				BotSayTeamOrder(bs, teammates[0]);
;2307:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;2308:				//the other will get the flag
;2309:				ClientName(teammates[1], name, sizeof(name));
;2310:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;2311:				BotSayTeamOrder(bs, teammates[1]);
;2312:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_DEFEND);
;2313:				break;
;2314:			}
;2315:			case 3:
;2316:			{
;2317:				//the one closest to the base will defend the base
;2318:				ClientName(teammates[0], name, sizeof(name));
;2319:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;2320:				BotSayTeamOrder(bs, teammates[0]);
;2321:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;2322:				//the others should go for the enemy flag
;2323:				ClientName(teammates[1], name, sizeof(name));
;2324:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;2325:				BotSayTeamOrder(bs, teammates[1]);
;2326:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_DEFEND);
;2327:				//
;2328:				ClientName(teammates[2], name, sizeof(name));
;2329:				BotAI_BotInitialChat(bs, "cmd_returnflag", name, NULL);
;2330:				BotSayTeamOrder(bs, teammates[2]);
;2331:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
;2332:				break;
;2333:			}
;2334:			default:
;2335:			{
;2336:				//70% defend the base
;2337:				defenders = (int) (float) numteammates * 0.7 + 0.5;
;2338:				if (defenders > 8) defenders = 8;
;2339:				//20% try to return the flag
;2340:				attackers = (int) (float) numteammates * 0.2 + 0.5;
;2341:				if (attackers > 2) attackers = 2;
;2342:				for (i = 0; i < defenders; i++) {
;2343:					//
;2344:					ClientName(teammates[i], name, sizeof(name));
;2345:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;2346:					BotSayTeamOrder(bs, teammates[i]);
;2347:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;2348:				}
;2349:				for (i = 0; i < attackers; i++) {
;2350:					//
;2351:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;2352:					BotAI_BotInitialChat(bs, "cmd_returnflag", name, NULL);
;2353:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;2354:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
;2355:				}
;2356:				//
;2357:				break;
;2358:			}
;2359:		}
;2360:	}
;2361:}
;2362:
;2363:/*
;2364:==================
;2365:Bot1FCTFOrders_EnemyDroppedFlag
;2366:
;2367:  X% defend the base, Y% get the flag
;2368:==================
;2369:*/
;2370:void Bot1FCTFOrders_EnemyDroppedFlag(bot_state_t *bs) {
;2371:	int numteammates, defenders, attackers, i;
;2372:	int teammates[MAX_CLIENTS];
;2373:	char name[MAX_NETNAME];
;2374:
;2375:	//sort team mates by travel time to base
;2376:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
;2377:	//sort team mates by CTF preference
;2378:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
;2379:	//passive strategy
;2380:	if (!(bs->ctfstrategy & CTFS_AGRESSIVE)) {
;2381:		//different orders based on the number of team mates
;2382:		switch(numteammates) {
;2383:			case 1: break;
;2384:			case 2:
;2385:			{
;2386:				//the one closest to the base will defend the base
;2387:				ClientName(teammates[0], name, sizeof(name));
;2388:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;2389:				BotSayTeamOrder(bs, teammates[0]);
;2390:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;2391:				//the other will get the flag
;2392:				ClientName(teammates[1], name, sizeof(name));
;2393:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;2394:				BotSayTeamOrder(bs, teammates[1]);
;2395:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
;2396:				break;
;2397:			}
;2398:			case 3:
;2399:			{
;2400:				//the one closest to the base will defend the base
;2401:				ClientName(teammates[0], name, sizeof(name));
;2402:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;2403:				BotSayTeamOrder(bs, teammates[0]);
;2404:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;2405:				//the second one closest to the base will defend the base
;2406:				ClientName(teammates[1], name, sizeof(name));
;2407:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;2408:				BotSayTeamOrder(bs, teammates[1]);
;2409:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_DEFEND);
;2410:				//the other will get the flag
;2411:				ClientName(teammates[2], name, sizeof(name));
;2412:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;2413:				BotSayTeamOrder(bs, teammates[2]);
;2414:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
;2415:				break;
;2416:			}
;2417:			default:
;2418:			{
;2419:				//50% defend the base
;2420:				defenders = (int) (float) numteammates * 0.5 + 0.5;
;2421:				if (defenders > 5) defenders = 5;
;2422:				//40% get the flag
;2423:				attackers = (int) (float) numteammates * 0.4 + 0.5;
;2424:				if (attackers > 4) attackers = 4;
;2425:				for (i = 0; i < defenders; i++) {
;2426:					//
;2427:					ClientName(teammates[i], name, sizeof(name));
;2428:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;2429:					BotSayTeamOrder(bs, teammates[i]);
;2430:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;2431:				}
;2432:				for (i = 0; i < attackers; i++) {
;2433:					//
;2434:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;2435:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;2436:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;2437:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
;2438:				}
;2439:				//
;2440:				break;
;2441:			}
;2442:		}
;2443:	}
;2444:	else { //agressive
;2445:		//different orders based on the number of team mates
;2446:		switch(numteammates) {
;2447:			case 1: break;
;2448:			case 2:
;2449:			{
;2450:				//the one closest to the base will defend the base
;2451:				ClientName(teammates[0], name, sizeof(name));
;2452:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;2453:				BotSayTeamOrder(bs, teammates[0]);
;2454:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;2455:				//the other will get the flag
;2456:				ClientName(teammates[1], name, sizeof(name));
;2457:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;2458:				BotSayTeamOrder(bs, teammates[1]);
;2459:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
;2460:				break;
;2461:			}
;2462:			case 3:
;2463:			{
;2464:				//the one closest to the base will defend the base
;2465:				ClientName(teammates[0], name, sizeof(name));
;2466:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;2467:				BotSayTeamOrder(bs, teammates[0]);
;2468:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;2469:				//the others should go for the enemy flag
;2470:				ClientName(teammates[1], name, sizeof(name));
;2471:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;2472:				BotSayTeamOrder(bs, teammates[1]);
;2473:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
;2474:				//
;2475:				ClientName(teammates[2], name, sizeof(name));
;2476:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;2477:				BotSayTeamOrder(bs, teammates[2]);
;2478:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
;2479:				break;
;2480:			}
;2481:			default:
;2482:			{
;2483:				//30% defend the base
;2484:				defenders = (int) (float) numteammates * 0.3 + 0.5;
;2485:				if (defenders > 3) defenders = 3;
;2486:				//60% get the flag
;2487:				attackers = (int) (float) numteammates * 0.6 + 0.5;
;2488:				if (attackers > 6) attackers = 6;
;2489:				for (i = 0; i < defenders; i++) {
;2490:					//
;2491:					ClientName(teammates[i], name, sizeof(name));
;2492:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;2493:					BotSayTeamOrder(bs, teammates[i]);
;2494:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;2495:				}
;2496:				for (i = 0; i < attackers; i++) {
;2497:					//
;2498:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;2499:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;2500:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;2501:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_DEFEND);
;2502:				}
;2503:				//
;2504:				break;
;2505:			}
;2506:		}
;2507:	}
;2508:}
;2509:
;2510:/*
;2511:==================
;2512:Bot1FCTFOrders
;2513:==================
;2514:*/
;2515:void Bot1FCTFOrders(bot_state_t *bs) {
;2516:	switch(bs->neutralflagstatus) {
;2517:		case 0: Bot1FCTFOrders_FlagAtCenter(bs); break;
;2518:		case 1: Bot1FCTFOrders_TeamHasFlag(bs); break;
;2519:		case 2: Bot1FCTFOrders_EnemyHasFlag(bs); break;
;2520:		case 3: Bot1FCTFOrders_EnemyDroppedFlag(bs); break;
;2521:	}
;2522:}
;2523:
;2524:/*
;2525:==================
;2526:BotObeliskOrders
;2527:
;2528:  X% in defence Y% in offence
;2529:==================
;2530:*/
;2531:void BotObeliskOrders(bot_state_t *bs) {
;2532:	int numteammates, defenders, attackers, i;
;2533:	int teammates[MAX_CLIENTS];
;2534:	char name[MAX_NETNAME];
;2535:
;2536:	//sort team mates by travel time to base
;2537:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
;2538:	//sort team mates by CTF preference
;2539:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
;2540:	//passive strategy
;2541:	if (!(bs->ctfstrategy & CTFS_AGRESSIVE)) {
;2542:		//different orders based on the number of team mates
;2543:		switch(numteammates) {
;2544:			case 1: break;
;2545:			case 2:
;2546:			{
;2547:				//the one closest to the base will defend the base
;2548:				ClientName(teammates[0], name, sizeof(name));
;2549:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;2550:				BotSayTeamOrder(bs, teammates[0]);
;2551:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;2552:				//the other will attack the enemy base
;2553:				ClientName(teammates[1], name, sizeof(name));
;2554:				BotAI_BotInitialChat(bs, "cmd_attackenemybase", name, NULL);
;2555:				BotSayTeamOrder(bs, teammates[1]);
;2556:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_OFFENSE);
;2557:				break;
;2558:			}
;2559:			case 3:
;2560:			{
;2561:				//the one closest to the base will defend the base
;2562:				ClientName(teammates[0], name, sizeof(name));
;2563:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;2564:				BotSayTeamOrder(bs, teammates[0]);
;2565:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;2566:				//the one second closest to the base also defends the base
;2567:				ClientName(teammates[1], name, sizeof(name));
;2568:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;2569:				BotSayTeamOrder(bs, teammates[1]);
;2570:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_DEFEND);
;2571:				//the other one attacks the enemy base
;2572:				ClientName(teammates[2], name, sizeof(name));
;2573:				BotAI_BotInitialChat(bs, "cmd_attackenemybase", name, NULL);
;2574:				BotSayTeamOrder(bs, teammates[2]);
;2575:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_OFFENSE);
;2576:				break;
;2577:			}
;2578:			default:
;2579:			{
;2580:				//50% defend the base
;2581:				defenders = (int) (float) numteammates * 0.5 + 0.5;
;2582:				if (defenders > 5) defenders = 5;
;2583:				//40% attack the enemy base
;2584:				attackers = (int) (float) numteammates * 0.4 + 0.5;
;2585:				if (attackers > 4) attackers = 4;
;2586:				for (i = 0; i < defenders; i++) {
;2587:					//
;2588:					ClientName(teammates[i], name, sizeof(name));
;2589:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;2590:					BotSayTeamOrder(bs, teammates[i]);
;2591:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;2592:				}
;2593:				for (i = 0; i < attackers; i++) {
;2594:					//
;2595:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;2596:					BotAI_BotInitialChat(bs, "cmd_attackenemybase", name, NULL);
;2597:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;2598:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_OFFENSE);
;2599:				}
;2600:				//
;2601:				break;
;2602:			}
;2603:		}
;2604:	}
;2605:	else {
;2606:		//different orders based on the number of team mates
;2607:		switch(numteammates) {
;2608:			case 1: break;
;2609:			case 2:
;2610:			{
;2611:				//the one closest to the base will defend the base
;2612:				ClientName(teammates[0], name, sizeof(name));
;2613:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;2614:				BotSayTeamOrder(bs, teammates[0]);
;2615:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;2616:				//the other will attack the enemy base
;2617:				ClientName(teammates[1], name, sizeof(name));
;2618:				BotAI_BotInitialChat(bs, "cmd_attackenemybase", name, NULL);
;2619:				BotSayTeamOrder(bs, teammates[1]);
;2620:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_OFFENSE);
;2621:				break;
;2622:			}
;2623:			case 3:
;2624:			{
;2625:				//the one closest to the base will defend the base
;2626:				ClientName(teammates[0], name, sizeof(name));
;2627:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;2628:				BotSayTeamOrder(bs, teammates[0]);
;2629:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;2630:				//the others attack the enemy base
;2631:				ClientName(teammates[1], name, sizeof(name));
;2632:				BotAI_BotInitialChat(bs, "cmd_attackenemybase", name, NULL);
;2633:				BotSayTeamOrder(bs, teammates[1]);
;2634:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_OFFENSE);
;2635:				//
;2636:				ClientName(teammates[2], name, sizeof(name));
;2637:				BotAI_BotInitialChat(bs, "cmd_attackenemybase", name, NULL);
;2638:				BotSayTeamOrder(bs, teammates[2]);
;2639:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_OFFENSE);
;2640:				break;
;2641:			}
;2642:			default:
;2643:			{
;2644:				//30% defend the base
;2645:				defenders = (int) (float) numteammates * 0.3 + 0.5;
;2646:				if (defenders > 3) defenders = 3;
;2647:				//70% attack the enemy base
;2648:				attackers = (int) (float) numteammates * 0.7 + 0.5;
;2649:				if (attackers > 7) attackers = 7;
;2650:				for (i = 0; i < defenders; i++) {
;2651:					//
;2652:					ClientName(teammates[i], name, sizeof(name));
;2653:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;2654:					BotSayTeamOrder(bs, teammates[i]);
;2655:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;2656:				}
;2657:				for (i = 0; i < attackers; i++) {
;2658:					//
;2659:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;2660:					BotAI_BotInitialChat(bs, "cmd_attackenemybase", name, NULL);
;2661:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;2662:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_OFFENSE);
;2663:				}
;2664:				//
;2665:				break;
;2666:			}
;2667:		}
;2668:	}
;2669:}
;2670:
;2671:/*
;2672:==================
;2673:BotHarvesterOrders
;2674:
;2675:  X% defend the base, Y% harvest
;2676:==================
;2677:*/
;2678:void BotHarvesterOrders(bot_state_t *bs) {
;2679:	int numteammates, defenders, attackers, i;
;2680:	int teammates[MAX_CLIENTS];
;2681:	char name[MAX_NETNAME];
;2682:
;2683:	//sort team mates by travel time to base
;2684:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
;2685:	//sort team mates by CTF preference
;2686:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
;2687:	//passive strategy
;2688:	if (!(bs->ctfstrategy & CTFS_AGRESSIVE)) {
;2689:		//different orders based on the number of team mates
;2690:		switch(numteammates) {
;2691:			case 1: break;
;2692:			case 2:
;2693:			{
;2694:				//the one closest to the base will defend the base
;2695:				ClientName(teammates[0], name, sizeof(name));
;2696:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;2697:				BotSayTeamOrder(bs, teammates[0]);
;2698:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;2699:				//the other will harvest
;2700:				ClientName(teammates[1], name, sizeof(name));
;2701:				BotAI_BotInitialChat(bs, "cmd_harvest", name, NULL);
;2702:				BotSayTeamOrder(bs, teammates[1]);
;2703:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_OFFENSE);
;2704:				break;
;2705:			}
;2706:			case 3:
;2707:			{
;2708:				//the one closest to the base will defend the base
;2709:				ClientName(teammates[0], name, sizeof(name));
;2710:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;2711:				BotSayTeamOrder(bs, teammates[0]);
;2712:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;2713:				//the one second closest to the base also defends the base
;2714:				ClientName(teammates[1], name, sizeof(name));
;2715:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;2716:				BotSayTeamOrder(bs, teammates[1]);
;2717:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_DEFEND);
;2718:				//the other one goes harvesting
;2719:				ClientName(teammates[2], name, sizeof(name));
;2720:				BotAI_BotInitialChat(bs, "cmd_harvest", name, NULL);
;2721:				BotSayTeamOrder(bs, teammates[2]);
;2722:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_OFFENSE);
;2723:				break;
;2724:			}
;2725:			default:
;2726:			{
;2727:				//50% defend the base
;2728:				defenders = (int) (float) numteammates * 0.5 + 0.5;
;2729:				if (defenders > 5) defenders = 5;
;2730:				//40% goes harvesting
;2731:				attackers = (int) (float) numteammates * 0.4 + 0.5;
;2732:				if (attackers > 4) attackers = 4;
;2733:				for (i = 0; i < defenders; i++) {
;2734:					//
;2735:					ClientName(teammates[i], name, sizeof(name));
;2736:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;2737:					BotSayTeamOrder(bs, teammates[i]);
;2738:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;2739:				}
;2740:				for (i = 0; i < attackers; i++) {
;2741:					//
;2742:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;2743:					BotAI_BotInitialChat(bs, "cmd_harvest", name, NULL);
;2744:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;2745:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_OFFENSE);
;2746:				}
;2747:				//
;2748:				break;
;2749:			}
;2750:		}
;2751:	}
;2752:	else {
;2753:		//different orders based on the number of team mates
;2754:		switch(numteammates) {
;2755:			case 1: break;
;2756:			case 2:
;2757:			{
;2758:				//the one closest to the base will defend the base
;2759:				ClientName(teammates[0], name, sizeof(name));
;2760:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;2761:				BotSayTeamOrder(bs, teammates[0]);
;2762:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;2763:				//the other will harvest
;2764:				ClientName(teammates[1], name, sizeof(name));
;2765:				BotAI_BotInitialChat(bs, "cmd_harvest", name, NULL);
;2766:				BotSayTeamOrder(bs, teammates[1]);
;2767:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_OFFENSE);
;2768:				break;
;2769:			}
;2770:			case 3:
;2771:			{
;2772:				//the one closest to the base will defend the base
;2773:				ClientName(teammates[0], name, sizeof(name));
;2774:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;2775:				BotSayTeamOrder(bs, teammates[0]);
;2776:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;2777:				//the others go harvesting
;2778:				ClientName(teammates[1], name, sizeof(name));
;2779:				BotAI_BotInitialChat(bs, "cmd_harvest", name, NULL);
;2780:				BotSayTeamOrder(bs, teammates[1]);
;2781:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_OFFENSE);
;2782:				//
;2783:				ClientName(teammates[2], name, sizeof(name));
;2784:				BotAI_BotInitialChat(bs, "cmd_harvest", name, NULL);
;2785:				BotSayTeamOrder(bs, teammates[2]);
;2786:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_OFFENSE);
;2787:				break;
;2788:			}
;2789:			default:
;2790:			{
;2791:				//30% defend the base
;2792:				defenders = (int) (float) numteammates * 0.3 + 0.5;
;2793:				if (defenders > 3) defenders = 3;
;2794:				//70% go harvesting
;2795:				attackers = (int) (float) numteammates * 0.7 + 0.5;
;2796:				if (attackers > 7) attackers = 7;
;2797:				for (i = 0; i < defenders; i++) {
;2798:					//
;2799:					ClientName(teammates[i], name, sizeof(name));
;2800:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;2801:					BotSayTeamOrder(bs, teammates[i]);
;2802:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;2803:				}
;2804:				for (i = 0; i < attackers; i++) {
;2805:					//
;2806:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;2807:					BotAI_BotInitialChat(bs, "cmd_harvest", name, NULL);
;2808:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;2809:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_OFFENSE);
;2810:				}
;2811:				//
;2812:				break;
;2813:			}
;2814:		}
;2815:	}
;2816:}
;2817:#endif
;2818:
;2819:/*
;2820:==================
;2821:FindHumanTeamLeader
;2822:==================
;2823:*/
;2824:int FindHumanTeamLeader(bot_state_t *bs) {
line 2850
;2825:	// JUHOX: don't assume humans to be team leader
;2826:#if 0
;2827:	int i;
;2828:
;2829:	for (i = 0; i < MAX_CLIENTS; i++) {
;2830:		if ( g_entities[i].inuse ) {
;2831:			// if this player is not a bot
;2832:			if ( !(g_entities[i].r.svFlags & SVF_BOT) ) {
;2833:				// if this player is ok with being the leader
;2834:				if (!notleader[i]) {
;2835:					// if this player is on the same team
;2836:					if ( BotSameTeam(bs, i) ) {
;2837:						ClientName(i, bs->teamleader, sizeof(bs->teamleader));
;2838:						// if not yet ordered to do anything
;2839:						if ( !BotSetLastOrderedTask(bs) ) {
;2840:							// go on defense by default
;2841:							BotVoiceChat_Defend(bs, i, SAY_TELL);
;2842:						}
;2843:						return qtrue;
;2844:					}
;2845:				}
;2846:			}
;2847:		}
;2848:	}
;2849:#endif
;2850:	return qfalse;
CNSTI4 0
RETI4
LABELV $671
endproc FindHumanTeamLeader 0 0
export BotGoToGoal
proc BotGoToGoal 0 12
line 2858
;2851:}
;2852:
;2853:/*
;2854:==================
;2855:JUHOX: BotGoToGoal
;2856:==================
;2857:*/
;2858:void BotGoToGoal(bot_state_t* bs, const bot_goal_t* goal) {
line 2860
;2859:	//set message time to zero so bot will NOT show any message
;2860:	bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11696
ADDP4
CNSTF4 0
ASGNF4
line 2862
;2861:	//we use the bots-decides-to-camp ltg to make the bot going to the location.
;2862:	bs->ltgtype = LTG_CAMPORDER;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 8
ASGNI4
line 2864
;2863:	//set the team goal
;2864:	memcpy(&bs->teamgoal, goal, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
CNSTI4 11580
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2866
;2865:	//get the team goal time
;2866:	bs->teamgoal_time = FloatTime() + 30;
ADDRFP4 0
INDIRP4
CNSTI4 11700
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1106247680
ADDF4
ASGNF4
line 2868
;2867:	//set the time the bot will stay at the location
;2868:	bs->camp_time = 3;	// note that camp_time formerly had another meaning
ADDRFP4 0
INDIRP4
CNSTI4 7288
ADDP4
CNSTF4 1077936128
ASGNF4
line 2870
;2869:	//the teammate that requested the camping
;2870:	bs->teammate = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11560
ADDP4
CNSTI4 0
ASGNI4
line 2871
;2871:	bs->arrive_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7264
ADDP4
CNSTF4 0
ASGNF4
line 2872
;2872:}
LABELV $672
endproc BotGoToGoal 0 12
export BotGoNearGoal
proc BotGoNearGoal 0 8
line 2879
;2873:
;2874:/*
;2875:==================
;2876:JUHOX: BotGoNearGoal
;2877:==================
;2878:*/
;2879:void BotGoNearGoal(bot_state_t* bs, const bot_goal_t* goal) {
line 2880
;2880:	BotGoToGoal(bs, goal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotGoToGoal
CALLV
pop
line 2881
;2881:	bs->ltgtype = LTG_CAMP;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 7
ASGNI4
line 2882
;2882:	bs->camp_time = 6;
ADDRFP4 0
INDIRP4
CNSTI4 7288
ADDP4
CNSTF4 1086324736
ASGNF4
line 2883
;2883:}
LABELV $673
endproc BotGoNearGoal 0 8
proc TravelConvinience 524 16
line 2890
;2884:
;2885:/*
;2886:==================
;2887:JUHOX: TravelConvinience
;2888:==================
;2889:*/
;2890:static int TravelConvinience(bot_state_t* leader, const bot_goal_t* goal) {
line 2899
;2891:	int teammate;
;2892:	int leaderTraveltime;
;2893:	playerState_t ps;
;2894:	int totalTeammateTraveltime;
;2895:	int numTeammates;	// not counting the leader and team mates who can't reach the goal
;2896:
;2897:
;2898:	if (
;2899:		(goal->flags & GFL_ITEM) &&
ADDRLP4 484
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 484
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $675
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 484
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ARGI4
ADDRLP4 488
ADDRGP4 BotMayLTGItemBeReachable
CALLI4
ASGNI4
ADDRLP4 488
INDIRI4
CNSTI4 0
NEI4 $675
line 2901
;2900:		!BotMayLTGItemBeReachable(leader, goal->entitynum)
;2901:	) return -1000000000;
CNSTI4 -1000000000
RETI4
ADDRGP4 $674
JUMPV
LABELV $675
line 2903
;2902:
;2903:	leaderTraveltime = trap_AAS_AreaTravelTimeToGoalArea(leader->areanum, leader->origin, goal->areanum, TFL_DEFAULT);
ADDRLP4 492
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 492
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
ARGI4
ADDRLP4 492
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 496
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 480
ADDRLP4 496
INDIRI4
ASGNI4
line 2904
;2904:	if (leaderTraveltime < 100) return -1000000000;
ADDRLP4 480
INDIRI4
CNSTI4 100
GEI4 $677
CNSTI4 -1000000000
RETI4
ADDRGP4 $674
JUMPV
LABELV $677
line 2906
;2905:
;2906:	if (gametype < GT_TEAM) return 100000;
ADDRGP4 gametype
INDIRI4
CNSTI4 3
GEI4 $679
CNSTI4 100000
RETI4
ADDRGP4 $674
JUMPV
LABELV $679
line 2908
;2907:
;2908:	totalTeammateTraveltime = 0;
ADDRLP4 476
CNSTI4 0
ASGNI4
line 2909
;2909:	numTeammates = 0;
ADDRLP4 472
CNSTI4 0
ASGNI4
line 2910
;2910:	for (teammate = -1; (teammate = BotGetNextTeamMate(leader, teammate, &ps)) >= 0;) {
ADDRLP4 468
CNSTI4 -1
ASGNI4
ADDRGP4 $684
JUMPV
LABELV $681
line 2914
;2911:		int traveltime;
;2912:		int areanum;
;2913:
;2914:		areanum = BotPointAreaNum(ps.origin);
ADDRLP4 0+20
ARGP4
ADDRLP4 508
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 500
ADDRLP4 508
INDIRI4
ASGNI4
line 2915
;2915:		if (areanum <= 0) continue;
ADDRLP4 500
INDIRI4
CNSTI4 0
GTI4 $686
ADDRGP4 $682
JUMPV
LABELV $686
line 2916
;2916:		if (!trap_AAS_AreaReachability(areanum)) continue;
ADDRLP4 500
INDIRI4
ARGI4
ADDRLP4 512
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 512
INDIRI4
CNSTI4 0
NEI4 $688
ADDRGP4 $682
JUMPV
LABELV $688
line 2917
;2917:		traveltime = trap_AAS_AreaTravelTimeToGoalArea(BotPointAreaNum(ps.origin), ps.origin, goal->areanum, TFL_DEFAULT);
ADDRLP4 0+20
ARGP4
ADDRLP4 516
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 516
INDIRI4
ARGI4
ADDRLP4 0+20
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 520
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 504
ADDRLP4 520
INDIRI4
ASGNI4
line 2918
;2918:		if (traveltime > 0) {
ADDRLP4 504
INDIRI4
CNSTI4 0
LEI4 $692
line 2919
;2919:			totalTeammateTraveltime += traveltime;
ADDRLP4 476
ADDRLP4 476
INDIRI4
ADDRLP4 504
INDIRI4
ADDI4
ASGNI4
line 2920
;2920:			numTeammates++;
ADDRLP4 472
ADDRLP4 472
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2921
;2921:		}
LABELV $692
line 2922
;2922:	}
LABELV $682
line 2910
LABELV $684
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 468
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 500
ADDRGP4 BotGetNextTeamMate
CALLI4
ASGNI4
ADDRLP4 468
ADDRLP4 500
INDIRI4
ASGNI4
ADDRLP4 500
INDIRI4
CNSTI4 0
GEI4 $681
line 2924
;2923:	
;2924:	if (numTeammates <= 0) return 100000;
ADDRLP4 472
INDIRI4
CNSTI4 0
GTI4 $694
CNSTI4 100000
RETI4
ADDRGP4 $674
JUMPV
LABELV $694
line 2925
;2925:	return totalTeammateTraveltime - numTeammates * leaderTraveltime;
ADDRLP4 476
INDIRI4
ADDRLP4 472
INDIRI4
ADDRLP4 480
INDIRI4
MULI4
SUBI4
RETI4
LABELV $674
endproc TravelConvinience 524 16
export GetItemGoal
proc GetItemGoal 12 12
line 2933
;2926:}
;2927:
;2928:/*
;2929:==================
;2930:JUHOX: GetItemGoal
;2931:==================
;2932:*/
;2933:int GetItemGoal(int entitynum, const char* name, bot_goal_t* goal) {
line 2934
;2934:	if (Q_stricmp(name, "emergency") == 0) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $699
ARGP4
ADDRLP4 0
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $697
line 2935
;2935:		for (entitynum++; entitynum < level.numEmergencySpawnPoints; entitynum++) {
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $703
JUMPV
LABELV $700
line 2936
;2936:			memset(goal, 0, sizeof(*goal));
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 56
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2937
;2937:			goal->entitynum = ENTITYNUM_WORLD;
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
CNSTI4 1022
ASGNI4
line 2938
;2938:			VectorSet(goal->mins, -8, -8, -8);
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 3238002688
ASGNF4
line 2939
;2939:			VectorSet(goal->maxs, 8, 8, 8);
ADDRFP4 8
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 1090519040
ASGNF4
line 2940
;2940:			VectorCopy(level.emergencySpawnPoints[entitynum], goal->origin);
ADDRFP4 8
INDIRP4
ADDRFP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 level+10704
ADDP4
INDIRB
ASGNB 12
line 2941
;2941:			goal->areanum = BotPointAreaNum(goal->origin);
ADDRLP4 4
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 2942
;2942:			return entitynum;
ADDRFP4 0
INDIRI4
RETI4
ADDRGP4 $696
JUMPV
LABELV $701
line 2935
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $703
ADDRFP4 0
INDIRI4
ADDRGP4 level+10700
INDIRI4
LTI4 $700
line 2944
;2943:		}
;2944:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $696
JUMPV
LABELV $697
line 2947
;2945:	}
;2946:
;2947:	if (entitynum < MAX_CLIENTS) entitynum = MAX_CLIENTS-1;
ADDRFP4 0
INDIRI4
CNSTI4 64
GEI4 $706
ADDRFP4 0
CNSTI4 63
ASGNI4
LABELV $706
line 2949
;2948:
;2949:	for (entitynum++; entitynum < level.num_entities; entitynum++) {
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $711
JUMPV
LABELV $708
line 2952
;2950:		gentity_t* ent;
;2951:
;2952:		ent = &g_entities[entitynum];
ADDRLP4 4
ADDRFP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 2953
;2953:		if (!ent->inuse) continue;
ADDRLP4 4
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $713
ADDRGP4 $709
JUMPV
LABELV $713
line 2954
;2954:		if (ent->s.eType != ET_ITEM) continue;
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $715
ADDRGP4 $709
JUMPV
LABELV $715
line 2955
;2955:		if (!ent->item) continue;
ADDRLP4 4
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $717
ADDRGP4 $709
JUMPV
LABELV $717
line 2956
;2956:		if (Q_stricmp(name, ent->item->pickup_name)) continue;
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $719
ADDRGP4 $709
JUMPV
LABELV $719
line 2958
;2957:
;2958:		BotCreateItemGoal(ent, goal);
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 BotCreateItemGoal
CALLV
pop
line 2959
;2959:		return entitynum;
ADDRFP4 0
INDIRI4
RETI4
ADDRGP4 $696
JUMPV
LABELV $709
line 2949
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $711
ADDRFP4 0
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $708
line 2962
;2960:	}
;2961:
;2962:	return -1;
CNSTI4 -1
RETI4
LABELV $696
endproc GetItemGoal 12 12
proc SearchItemGoal 324 28
line 2970
;2963:}
;2964:
;2965:/*
;2966:==================
;2967:JUHOX: SearchItemGoal
;2968:==================
;2969:*/
;2970:static qboolean SearchItemGoal(bot_state_t* bs, char** itemList, bot_goal_t* goal) {
line 2979
;2971:	int numFirstChoiceGoals;
;2972:	int numSecondChoiceGoals;
;2973:	int numThirdChoiceGoals;
;2974:	qboolean acceptNewSecondChoiceGoals;
;2975:	bot_goal_t firstChoiceGoal;
;2976:	bot_goal_t secondChoiceGoal;
;2977:	bot_goal_t thirdChoiceGoal;
;2978:
;2979:	if (!itemList) return qfalse;
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $722
CNSTI4 0
RETI4
ADDRGP4 $721
JUMPV
LABELV $722
line 2981
;2980:
;2981:	numFirstChoiceGoals = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2982
;2982:	numSecondChoiceGoals = 0;
ADDRLP4 64
CNSTI4 0
ASGNI4
line 2983
;2983:	numThirdChoiceGoals = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2984
;2984:	acceptNewSecondChoiceGoals = qtrue;
ADDRLP4 68
CNSTI4 1
ASGNI4
ADDRGP4 $725
JUMPV
LABELV $724
line 2985
;2985:	while (*itemList) {
line 2989
;2986:		int location;
;2987:		bot_goal_t potentialGoal;
;2988:
;2989:		if ((*itemList)[0] == 0) {
ADDRFP4 4
INDIRP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $727
line 2990
;2990:			if (numFirstChoiceGoals > 0) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LEI4 $729
line 2991
;2991:				memcpy(goal, &firstChoiceGoal, sizeof(*goal));
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 72
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2992
;2992:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $721
JUMPV
LABELV $729
line 2994
;2993:			}
;2994:			if (numSecondChoiceGoals > 0) {
ADDRLP4 64
INDIRI4
CNSTI4 0
LEI4 $733
line 2995
;2995:				acceptNewSecondChoiceGoals = qfalse;
ADDRLP4 68
CNSTI4 0
ASGNI4
line 2996
;2996:			}
line 2997
;2997:			goto NextItem;
ADDRGP4 $733
JUMPV
LABELV $727
line 3000
;2998:		}
;2999:
;3000:		for (location = -1; (location = GetItemGoal(location, *itemList, &potentialGoal)) >= 0; ) {
ADDRLP4 240
CNSTI4 -1
ASGNI4
ADDRGP4 $737
JUMPV
LABELV $734
line 3004
;3001:			trace_t trace;
;3002:			int travelConvinience;
;3003:
;3004:			if (potentialGoal.flags & GFL_DROPPED) continue;
ADDRLP4 184+48
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $738
ADDRGP4 $735
JUMPV
LABELV $738
line 3005
;3005:			if (potentialGoal.areanum <= 0) continue;
ADDRLP4 184+12
INDIRI4
CNSTI4 0
GTI4 $741
ADDRGP4 $735
JUMPV
LABELV $741
line 3008
;3006:
;3007:			if (
;3008:				(potentialGoal.flags & GFL_ITEM) &&
ADDRLP4 184+48
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $744
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 184+40
INDIRI4
ARGI4
ADDRLP4 304
ADDRGP4 BotMayNBGBeAvailable
CALLI4
ASGNI4
ADDRLP4 304
INDIRI4
CNSTI4 0
NEI4 $744
line 3010
;3009:				!BotMayNBGBeAvailable(bs, potentialGoal.entitynum)
;3010:			) continue;
ADDRGP4 $735
JUMPV
LABELV $744
line 3012
;3011:
;3012:			travelConvinience = TravelConvinience(bs, &potentialGoal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 184
ARGP4
ADDRLP4 308
ADDRGP4 TravelConvinience
CALLI4
ASGNI4
ADDRLP4 244
ADDRLP4 308
INDIRI4
ASGNI4
line 3013
;3013:			if (travelConvinience <= -1000000) continue;
ADDRLP4 244
INDIRI4
CNSTI4 -1000000
GTI4 $748
ADDRGP4 $735
JUMPV
LABELV $748
line 3015
;3014:
;3015:			numThirdChoiceGoals++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3016
;3016:			if (rand() % numThirdChoiceGoals == 0) {
ADDRLP4 312
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 312
INDIRI4
ADDRLP4 0
INDIRI4
MODI4
CNSTI4 0
NEI4 $750
line 3017
;3017:				memcpy(&thirdChoiceGoal, &potentialGoal, sizeof(thirdChoiceGoal));
ADDRLP4 8
ARGP4
ADDRLP4 184
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 3018
;3018:			}
LABELV $750
line 3020
;3019:
;3020:			trap_Trace(&trace, bs->eye, NULL, NULL, potentialGoal.origin, bs->client, MASK_SHOT);
ADDRLP4 248
ARGP4
ADDRLP4 316
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 316
INDIRP4
CNSTI4 4944
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 184
ARGP4
ADDRLP4 316
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
line 3021
;3021:			if (trace.fraction >= 1) continue;
ADDRLP4 248+8
INDIRF4
CNSTF4 1065353216
LTF4 $752
ADDRGP4 $735
JUMPV
LABELV $752
line 3023
;3022:
;3023:			if (travelConvinience >= 0) {
ADDRLP4 244
INDIRI4
CNSTI4 0
LTI4 $755
line 3024
;3024:				numFirstChoiceGoals++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3025
;3025:				if (rand() % numFirstChoiceGoals == 0) {
ADDRLP4 320
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 320
INDIRI4
ADDRLP4 4
INDIRI4
MODI4
CNSTI4 0
NEI4 $756
line 3026
;3026:					memcpy(&firstChoiceGoal, &potentialGoal, sizeof(firstChoiceGoal));
ADDRLP4 72
ARGP4
ADDRLP4 184
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 3027
;3027:				}
line 3028
;3028:			}
ADDRGP4 $756
JUMPV
LABELV $755
line 3029
;3029:			else if (acceptNewSecondChoiceGoals) {
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $759
line 3030
;3030:				numSecondChoiceGoals++;
ADDRLP4 64
ADDRLP4 64
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3031
;3031:				if (rand() % numSecondChoiceGoals == 0) {
ADDRLP4 320
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 320
INDIRI4
ADDRLP4 64
INDIRI4
MODI4
CNSTI4 0
NEI4 $761
line 3032
;3032:					memcpy(&secondChoiceGoal, &potentialGoal, sizeof(secondChoiceGoal));
ADDRLP4 128
ARGP4
ADDRLP4 184
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 3033
;3033:				}
LABELV $761
line 3034
;3034:			}
LABELV $759
LABELV $756
line 3035
;3035:		}
LABELV $735
line 3000
LABELV $737
ADDRLP4 240
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
INDIRP4
ARGP4
ADDRLP4 184
ARGP4
ADDRLP4 244
ADDRGP4 GetItemGoal
CALLI4
ASGNI4
ADDRLP4 240
ADDRLP4 244
INDIRI4
ASGNI4
ADDRLP4 244
INDIRI4
CNSTI4 0
GEI4 $734
LABELV $733
line 3038
;3036:
;3037:		NextItem:
;3038:		itemList++;
ADDRFP4 4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
line 3039
;3039:	}
LABELV $725
line 2985
ADDRFP4 4
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $724
line 3041
;3040:
;3041:	if (numFirstChoiceGoals > 0) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LEI4 $763
line 3042
;3042:		memcpy(goal, &firstChoiceGoal, sizeof(*goal));
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 72
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 3043
;3043:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $721
JUMPV
LABELV $763
line 3045
;3044:	}
;3045:	if (numSecondChoiceGoals > 0) {
ADDRLP4 64
INDIRI4
CNSTI4 0
LEI4 $765
line 3046
;3046:		memcpy(goal, &secondChoiceGoal, sizeof(*goal));
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 128
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 3047
;3047:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $721
JUMPV
LABELV $765
line 3049
;3048:	}
;3049:	if (numThirdChoiceGoals > 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $767
line 3050
;3050:		memcpy(goal, &thirdChoiceGoal, sizeof(*goal));
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 3051
;3051:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $721
JUMPV
LABELV $767
line 3053
;3052:	}
;3053:	return qfalse;
CNSTI4 0
RETI4
LABELV $721
endproc SearchItemGoal 324 28
data
align 4
LABELV $770
address $771
address $772
address $773
address $774
address $775
address $776
address $777
address $778
address $779
address $780
address $781
address $782
address $783
address $784
address $785
address $786
address $787
address $788
address $789
address $790
address $791
address $792
address $793
address $794
address $795
address $796
address $797
address $798
address $799
address $800
address $801
address $802
address $803
address $804
address $805
byte 4 0
align 4
LABELV $811
address $699
byte 4 0
align 4
LABELV $847
address $777
address $780
address $779
address $773
address $848
address $776
address $775
address $772
address $848
address $774
address $771
address $778
byte 4 0
align 4
LABELV $849
address $777
address $780
address $773
address $848
address $776
address $775
address $772
address $848
address $774
address $771
byte 4 0
align 4
LABELV $850
address $779
address $778
byte 4 0
align 4
LABELV $853
address $777
address $780
address $779
address $848
address $776
address $775
address $848
address $774
address $778
byte 4 0
align 4
LABELV $854
address $773
address $848
address $772
address $848
address $771
byte 4 0
align 4
LABELV $855
address $777
address $780
address $848
address $776
address $775
address $848
address $774
byte 4 0
align 4
LABELV $856
address $773
address $848
address $772
address $848
address $771
byte 4 0
align 4
LABELV $857
address $779
address $778
byte 4 0
align 4
LABELV $862
address $773
address $848
address $772
address $848
address $779
address $771
address $780
address $848
address $778
byte 4 0
align 4
LABELV $863
address $777
address $848
address $774
byte 4 0
align 4
LABELV $864
address $775
address $776
byte 4 0
align 4
LABELV $865
address $773
address $848
address $772
address $848
address $771
address $780
byte 4 0
align 4
LABELV $866
address $777
address $848
address $774
byte 4 0
align 4
LABELV $867
address $775
address $776
address $779
address $778
byte 4 0
align 4
LABELV $870
address $779
address $848
address $778
byte 4 0
align 4
LABELV $871
address $777
address $780
address $773
address $772
address $848
address $771
address $774
byte 4 0
align 4
LABELV $872
address $775
address $776
byte 4 0
align 4
LABELV $873
address $777
address $780
address $773
address $772
address $848
address $771
address $774
byte 4 0
align 4
LABELV $874
address $775
address $776
address $779
address $778
byte 4 0
export BotChooseTeamleaderGoal
code
proc BotChooseTeamleaderGoal 536 12
line 3061
;3054:}
;3055:
;3056:/*
;3057:==================
;3058:JUHOX: BotChooseTeamleaderGoal
;3059:==================
;3060:*/
;3061:int BotChooseTeamleaderGoal(bot_state_t* bs, bot_goal_t* goal) {
line 3108
;3062:	static char* allItems[] = {
;3063:		"Armor Shard",
;3064:		"Armor",
;3065:		"Heavy Armor",
;3066:		"5 Health",
;3067:		"25 Health",
;3068:		"50 Health",
;3069:		"Mega Health",
;3070:		"Personal Teleporter",
;3071:		"Medkit",
;3072:		"Regeneration",
;3073:		"Gauntlet",
;3074:		"Shotgun",
;3075:		"Machinegun",
;3076:		"Grenade Launcher",
;3077:		"Rocket Launcher",
;3078:		"Lightning Gun",
;3079:		"Railgun",
;3080:		"Plasma Gun",
;3081:		"BFG10K",
;3082:		"Grappling Hook",
;3083:		"Shells",
;3084:		"Bullets",
;3085:		"Grenades",
;3086:		"Cells",
;3087:		"Lightning",
;3088:		"Rockets",
;3089:		"Slugs",
;3090:		"Bfg Ammo",
;3091:		"Quad Damage",
;3092:		"Battle Suit",
;3093:		"Speed",
;3094:		"Invisibility",
;3095:		"Flight",
;3096:		"Red Flag",
;3097:		"Blue Flag",
;3098:		NULL
;3099:	};
;3100:	char** firstChoiceItems;
;3101:	char** secondChoiceItems;
;3102:	char** thirdChoiceItems;
;3103:
;3104:	int teammate;
;3105:	playerState_t ps;
;3106:	qboolean healthUseful, armorUseful, holdableUseful;
;3107:
;3108:	if (bs->areanum <= 0) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
CNSTI4 0
GTI4 $806
CNSTI4 0
RETI4
ADDRGP4 $769
JUMPV
LABELV $806
line 3110
;3109:
;3110:	if (g_noItems.integer) {
ADDRGP4 g_noItems+12
INDIRI4
CNSTI4 0
EQI4 $808
line 3116
;3111:		static char* dummyList[] = {
;3112:			"emergency",
;3113:			NULL
;3114:		};
;3115:
;3116:		return SearchItemGoal(bs, dummyList, goal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $811
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 496
ADDRGP4 SearchItemGoal
CALLI4
ASGNI4
ADDRLP4 496
INDIRI4
RETI4
ADDRGP4 $769
JUMPV
LABELV $808
line 3119
;3117:	}
;3118:
;3119:	healthUseful = (bs->cur_ps.stats[STAT_HEALTH] < bs->cur_ps.stats[STAT_MAX_HEALTH]);
ADDRLP4 500
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 500
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ADDRLP4 500
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
GEI4 $813
ADDRLP4 496
CNSTI4 1
ASGNI4
ADDRGP4 $814
JUMPV
LABELV $813
ADDRLP4 496
CNSTI4 0
ASGNI4
LABELV $814
ADDRLP4 472
ADDRLP4 496
INDIRI4
ASGNI4
line 3120
;3120:	armorUseful = (bs->cur_ps.stats[STAT_ARMOR] < bs->cur_ps.stats[STAT_MAX_HEALTH]);
ADDRLP4 508
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 508
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ADDRLP4 508
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
GEI4 $816
ADDRLP4 504
CNSTI4 1
ASGNI4
ADDRGP4 $817
JUMPV
LABELV $816
ADDRLP4 504
CNSTI4 0
ASGNI4
LABELV $817
ADDRLP4 476
ADDRLP4 504
INDIRI4
ASGNI4
line 3121
;3121:	holdableUseful = !bs->cur_ps.stats[STAT_HOLDABLE_ITEM];
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 0
NEI4 $819
ADDRLP4 512
CNSTI4 1
ASGNI4
ADDRGP4 $820
JUMPV
LABELV $819
ADDRLP4 512
CNSTI4 0
ASGNI4
LABELV $820
ADDRLP4 480
ADDRLP4 512
INDIRI4
ASGNI4
line 3122
;3122:	for (teammate = -1; (teammate = BotGetNextTeamMate(bs, teammate, &ps)) >= 0;) {
ADDRLP4 468
CNSTI4 -1
ASGNI4
ADDRGP4 $824
JUMPV
LABELV $821
line 3123
;3123:		if (ps.stats[STAT_HEALTH] <= 0) continue;
ADDRLP4 0+184
INDIRI4
CNSTI4 0
GTI4 $825
ADDRGP4 $822
JUMPV
LABELV $825
line 3124
;3124:		if (ps.stats[STAT_HEALTH] < ps.stats[STAT_MAX_HEALTH]) healthUseful = qtrue;
ADDRLP4 0+184
INDIRI4
ADDRLP4 0+184+20
INDIRI4
GEI4 $828
ADDRLP4 472
CNSTI4 1
ASGNI4
LABELV $828
line 3125
;3125:		if (ps.stats[STAT_ARMOR] < ps.stats[STAT_MAX_HEALTH]) armorUseful = qtrue;
ADDRLP4 0+184+12
INDIRI4
ADDRLP4 0+184+20
INDIRI4
GEI4 $833
ADDRLP4 476
CNSTI4 1
ASGNI4
LABELV $833
line 3126
;3126:		if (!bs->cur_ps.stats[STAT_HOLDABLE_ITEM]) holdableUseful = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 0
NEI4 $839
ADDRLP4 480
CNSTI4 1
ASGNI4
LABELV $839
line 3127
;3127:	}
LABELV $822
line 3122
LABELV $824
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 468
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 516
ADDRGP4 BotGetNextTeamMate
CALLI4
ASGNI4
ADDRLP4 468
ADDRLP4 516
INDIRI4
ASGNI4
ADDRLP4 516
INDIRI4
CNSTI4 0
GEI4 $821
line 3129
;3128:
;3129:	if (healthUseful) {
ADDRLP4 472
INDIRI4
CNSTI4 0
EQI4 $841
line 3130
;3130:		if (armorUseful) {
ADDRLP4 476
INDIRI4
CNSTI4 0
EQI4 $843
line 3131
;3131:			if (holdableUseful) {
ADDRLP4 480
INDIRI4
CNSTI4 0
EQI4 $845
line 3149
;3132:				// health useful, armor useful, holdable useful
;3133:				static char* items1[] = {
;3134:					"Mega Health",
;3135:					"Regeneration",
;3136:					"Medkit",
;3137:					"Heavy Armor",
;3138:					"",
;3139:					"50 Health",
;3140:					"25 Health",
;3141:					"Armor",
;3142:					"",
;3143:					"5 Health",
;3144:					"Armor Shard",
;3145:					"Personal Teleporter",
;3146:					NULL
;3147:				};
;3148:
;3149:				firstChoiceItems = items1;
ADDRLP4 484
ADDRGP4 $847
ASGNP4
line 3150
;3150:				secondChoiceItems = NULL;
ADDRLP4 488
CNSTP4 0
ASGNP4
line 3151
;3151:				thirdChoiceItems = NULL;
ADDRLP4 492
CNSTP4 0
ASGNP4
line 3152
;3152:			}
ADDRGP4 $842
JUMPV
LABELV $845
line 3153
;3153:			else {
line 3174
;3154:				// health useful, armor useful
;3155:				static char* items1[] = {
;3156:					"Mega Health",
;3157:					"Regeneration",
;3158:					"Heavy Armor",
;3159:					"",
;3160:					"50 Health",
;3161:					"25 Health",
;3162:					"Armor",
;3163:					"",
;3164:					"5 Health",
;3165:					"Armor Shard",
;3166:					NULL
;3167:				};
;3168:				static char* items2[] = {
;3169:					"Medkit",
;3170:					"Personal Teleporter",
;3171:					NULL
;3172:				};
;3173:
;3174:				firstChoiceItems = items1;
ADDRLP4 484
ADDRGP4 $849
ASGNP4
line 3175
;3175:				secondChoiceItems = items2;
ADDRLP4 488
ADDRGP4 $850
ASGNP4
line 3176
;3176:				thirdChoiceItems = NULL;
ADDRLP4 492
CNSTP4 0
ASGNP4
line 3177
;3177:			}
line 3178
;3178:		}
ADDRGP4 $842
JUMPV
LABELV $843
line 3179
;3179:		else {
line 3180
;3180:			if (holdableUseful) {
ADDRLP4 480
INDIRI4
CNSTI4 0
EQI4 $851
line 3203
;3181:				// health useful, holdable useful
;3182:				static char* items1[] = {
;3183:					"Mega Health",
;3184:					"Regeneration",
;3185:					"Medkit",
;3186:					"",
;3187:					"50 Health",
;3188:					"25 Health",
;3189:					"",
;3190:					"5 Health",
;3191:					"Personal Teleporter",
;3192:					NULL
;3193:				};
;3194:				static char* items2[] = {
;3195:					"Heavy Armor",
;3196:					"",
;3197:					"Armor",
;3198:					"",
;3199:					"Armor Shard",
;3200:					NULL
;3201:				};
;3202:
;3203:				firstChoiceItems = items1;
ADDRLP4 484
ADDRGP4 $853
ASGNP4
line 3204
;3204:				secondChoiceItems = items2;
ADDRLP4 488
ADDRGP4 $854
ASGNP4
line 3205
;3205:				thirdChoiceItems = NULL;
ADDRLP4 492
CNSTP4 0
ASGNP4
line 3206
;3206:			}
ADDRGP4 $842
JUMPV
LABELV $851
line 3207
;3207:			else {
line 3233
;3208:				// health useful
;3209:				static char* items1[] = {
;3210:					"Mega Health",
;3211:					"Regeneration",
;3212:					"",
;3213:					"50 Health",
;3214:					"25 Health",
;3215:					"",
;3216:					"5 Health",
;3217:					NULL
;3218:				};
;3219:				static char* items2[] = {
;3220:					"Heavy Armor",
;3221:					"",
;3222:					"Armor",
;3223:					"",
;3224:					"Armor Shard",
;3225:					NULL
;3226:				};
;3227:				static char* items3[] = {
;3228:					"Medkit",
;3229:					"Personal Teleporter",
;3230:					NULL
;3231:				};
;3232:
;3233:				firstChoiceItems = items1;
ADDRLP4 484
ADDRGP4 $855
ASGNP4
line 3234
;3234:				secondChoiceItems = items2;
ADDRLP4 488
ADDRGP4 $856
ASGNP4
line 3235
;3235:				thirdChoiceItems = items3;
ADDRLP4 492
ADDRGP4 $857
ASGNP4
line 3236
;3236:			}
line 3237
;3237:		}
line 3238
;3238:	}
ADDRGP4 $842
JUMPV
LABELV $841
line 3239
;3239:	else if (armorUseful) {
ADDRLP4 476
INDIRI4
CNSTI4 0
EQI4 $858
line 3240
;3240:		if (holdableUseful) {
ADDRLP4 480
INDIRI4
CNSTI4 0
EQI4 $860
line 3266
;3241:			// armor useful, holdable useful
;3242:			static char* items1[] = {
;3243:				"Heavy Armor",
;3244:				"",
;3245:				"Armor",
;3246:				"",
;3247:				"Medkit",
;3248:				"Armor Shard",
;3249:				"Regeneration",
;3250:				"",
;3251:				"Personal Teleporter",
;3252:				NULL
;3253:			};
;3254:			static char* items2[] = {
;3255:				"Mega Health",
;3256:				"",
;3257:				"5 Health",
;3258:				NULL
;3259:			};
;3260:			static char* items3[] = {
;3261:				"25 Health",
;3262:				"50 Health",
;3263:				NULL
;3264:			};
;3265:
;3266:			firstChoiceItems = items1;
ADDRLP4 484
ADDRGP4 $862
ASGNP4
line 3267
;3267:			secondChoiceItems = items2;
ADDRLP4 488
ADDRGP4 $863
ASGNP4
line 3268
;3268:			thirdChoiceItems = items3;
ADDRLP4 492
ADDRGP4 $864
ASGNP4
line 3269
;3269:		}
ADDRGP4 $859
JUMPV
LABELV $860
line 3270
;3270:		else {
line 3295
;3271:			// armor useful
;3272:			static char* items1[] = {
;3273:				"Heavy Armor",
;3274:				"",
;3275:				"Armor",
;3276:				"",
;3277:				"Armor Shard",
;3278:				"Regeneration",
;3279:				NULL
;3280:			};
;3281:			static char* items2[] = {
;3282:				"Mega Health",
;3283:				"",
;3284:				"5 Health",
;3285:				NULL
;3286:			};
;3287:			static char* items3[] = {
;3288:				"25 Health",
;3289:				"50 Health",
;3290:				"Medkit",
;3291:				"Personal Teleporter",
;3292:				NULL
;3293:			};
;3294:
;3295:			firstChoiceItems = items1;
ADDRLP4 484
ADDRGP4 $865
ASGNP4
line 3296
;3296:			secondChoiceItems = items2;
ADDRLP4 488
ADDRGP4 $866
ASGNP4
line 3297
;3297:			thirdChoiceItems = items3;
ADDRLP4 492
ADDRGP4 $867
ASGNP4
line 3298
;3298:		}
line 3299
;3299:	}
ADDRGP4 $859
JUMPV
LABELV $858
line 3300
;3300:	else if (holdableUseful) {
ADDRLP4 480
INDIRI4
CNSTI4 0
EQI4 $868
line 3324
;3301:		// holdable useful
;3302:		static char* items1[] = {
;3303:			"Medkit",
;3304:			"",
;3305:			"Personal Teleporter",
;3306:			NULL
;3307:		};
;3308:		static char* items2[] = {
;3309:			"Mega Health",
;3310:			"Regeneration",
;3311:			"Heavy Armor",
;3312:			"Armor",
;3313:			"",
;3314:			"Armor Shard",
;3315:			"5 Health",
;3316:			NULL
;3317:		};
;3318:		static char* items3[] = {
;3319:			"25 Health",
;3320:			"50 Health",
;3321:			NULL
;3322:		};
;3323:
;3324:		firstChoiceItems = items1;
ADDRLP4 484
ADDRGP4 $870
ASGNP4
line 3325
;3325:		secondChoiceItems = items2;
ADDRLP4 488
ADDRGP4 $871
ASGNP4
line 3326
;3326:		thirdChoiceItems = items3;
ADDRLP4 492
ADDRGP4 $872
ASGNP4
line 3327
;3327:	}
ADDRGP4 $869
JUMPV
LABELV $868
line 3328
;3328:	else {
line 3348
;3329:		// nothing useful
;3330:		static char* items1[] = {
;3331:			"Mega Health",
;3332:			"Regeneration",
;3333:			"Heavy Armor",
;3334:			"Armor",
;3335:			"",
;3336:			"Armor Shard",
;3337:			"5 Health",
;3338:			NULL
;3339:		};
;3340:		static char* items2[] = {
;3341:			"25 Health",
;3342:			"50 Health",
;3343:			"Medkit",
;3344:			"Personal Teleporter",
;3345:			NULL
;3346:		};
;3347:
;3348:		firstChoiceItems = items1;
ADDRLP4 484
ADDRGP4 $873
ASGNP4
line 3349
;3349:		secondChoiceItems = items2;
ADDRLP4 488
ADDRGP4 $874
ASGNP4
line 3350
;3350:		thirdChoiceItems = NULL;
ADDRLP4 492
CNSTP4 0
ASGNP4
line 3351
;3351:	}
LABELV $869
LABELV $859
LABELV $842
line 3353
;3352:
;3353:	if (SearchItemGoal(bs, firstChoiceItems, goal)) return qtrue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 484
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 520
ADDRGP4 SearchItemGoal
CALLI4
ASGNI4
ADDRLP4 520
INDIRI4
CNSTI4 0
EQI4 $875
CNSTI4 1
RETI4
ADDRGP4 $769
JUMPV
LABELV $875
line 3354
;3354:	if (SearchItemGoal(bs, secondChoiceItems, goal)) return qtrue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 488
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 524
ADDRGP4 SearchItemGoal
CALLI4
ASGNI4
ADDRLP4 524
INDIRI4
CNSTI4 0
EQI4 $877
CNSTI4 1
RETI4
ADDRGP4 $769
JUMPV
LABELV $877
line 3355
;3355:	if (SearchItemGoal(bs, thirdChoiceItems, goal)) return qtrue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 492
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 528
ADDRGP4 SearchItemGoal
CALLI4
ASGNI4
ADDRLP4 528
INDIRI4
CNSTI4 0
EQI4 $879
CNSTI4 1
RETI4
ADDRGP4 $769
JUMPV
LABELV $879
line 3356
;3356:	if (SearchItemGoal(bs, allItems, goal)) return qtrue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $770
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 532
ADDRGP4 SearchItemGoal
CALLI4
ASGNI4
ADDRLP4 532
INDIRI4
CNSTI4 0
EQI4 $881
CNSTI4 1
RETI4
ADDRGP4 $769
JUMPV
LABELV $881
line 3358
;3357:
;3358:	return qfalse;
CNSTI4 0
RETI4
LABELV $769
endproc BotChooseTeamleaderGoal 536 12
export BotSearchTeammate
proc BotSearchTeammate 492 8
line 3366
;3359:}
;3360:
;3361:/*
;3362:==================
;3363:JUHOX: BotSearchTeammate
;3364:==================
;3365:*/
;3366:qboolean BotSearchTeammate(bot_state_t* bs, int teammate) {
line 3370
;3367:	playerState_t ps;
;3368:	int areanum;
;3369:
;3370:	if (bs->client == teammate) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $884
CNSTI4 0
RETI4
ADDRGP4 $883
JUMPV
LABELV $884
line 3371
;3371:	if (bs->ltgtype == LTG_TEAMHELP && bs->teammate == teammate) return qfalse;
ADDRLP4 472
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 472
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 1
NEI4 $886
ADDRLP4 472
INDIRP4
CNSTI4 11560
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $886
CNSTI4 0
RETI4
ADDRGP4 $883
JUMPV
LABELV $886
line 3372
;3372:	if (!BotAI_GetClientState(teammate, &ps)) return qfalse;
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 476
ADDRGP4 BotAI_GetClientState
CALLI4
ASGNI4
ADDRLP4 476
INDIRI4
CNSTI4 0
NEI4 $888
CNSTI4 0
RETI4
ADDRGP4 $883
JUMPV
LABELV $888
line 3373
;3373:	if (ps.persistant[PERS_TEAM] != bs->cur_ps.persistant[PERS_TEAM]) return qfalse;
ADDRLP4 0+248+12
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
EQI4 $890
CNSTI4 0
RETI4
ADDRGP4 $883
JUMPV
LABELV $890
line 3374
;3374:	areanum = BotPointAreaNum(ps.origin);
ADDRLP4 0+20
ARGP4
ADDRLP4 480
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 468
ADDRLP4 480
INDIRI4
ASGNI4
line 3375
;3375:	if (areanum <= 0 || !trap_AAS_AreaReachability(areanum)) return qfalse;
ADDRLP4 468
INDIRI4
CNSTI4 0
LEI4 $897
ADDRLP4 468
INDIRI4
ARGI4
ADDRLP4 488
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 488
INDIRI4
CNSTI4 0
NEI4 $895
LABELV $897
CNSTI4 0
RETI4
ADDRGP4 $883
JUMPV
LABELV $895
line 3376
;3376:	bs->teamgoal.entitynum = teammate;
ADDRFP4 0
INDIRP4
CNSTI4 11620
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 3377
;3377:	bs->teamgoal.areanum = areanum;
ADDRFP4 0
INDIRP4
CNSTI4 11592
ADDP4
ADDRLP4 468
INDIRI4
ASGNI4
line 3378
;3378:	VectorCopy(ps.origin, bs->teamgoal.origin);
ADDRFP4 0
INDIRP4
CNSTI4 11580
ADDP4
ADDRLP4 0+20
INDIRB
ASGNB 12
line 3379
;3379:	VectorSet(bs->teamgoal.mins, -8, -8, -8);
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
line 3380
;3380:	VectorSet(bs->teamgoal.maxs, 8, 8, 8);
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
line 3381
;3381:	bs->ltgtype = LTG_TEAMHELP;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 1
ASGNI4
line 3382
;3382:	bs->teammate = teammate;
ADDRFP4 0
INDIRP4
CNSTI4 11560
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 3383
;3383:	bs->teamgoal_time = FloatTime() + TEAM_HELP_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 11700
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 3384
;3384:	bs->teammessage_time = 0;	// no message
ADDRFP4 0
INDIRP4
CNSTI4 11696
ADDP4
CNSTF4 0
ASGNF4
line 3385
;3385:	return qtrue;
CNSTI4 1
RETI4
LABELV $883
endproc BotSearchTeammate 492 8
export BotDecidesToHelp
proc BotDecidesToHelp 12 12
line 3393
;3386:}
;3387:
;3388:/*
;3389:==================
;3390:JUHOX: BotDecidesToHelp
;3391:==================
;3392:*/
;3393:qboolean BotDecidesToHelp(bot_state_t* bs, int clientThatNeedsHelp) {
line 3394
;3394:	if (!BotSearchTeammate(bs, clientThatNeedsHelp)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 BotSearchTeammate
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $900
CNSTI4 0
RETI4
ADDRGP4 $899
JUMPV
LABELV $900
line 3395
;3395:	if (!BotEntityVisible(&bs->cur_ps, 360, clientThatNeedsHelp)) {
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 4
INDIRF4
CNSTF4 0
NEF4 $902
line 3397
;3396:		//set the time to send a message to the team mates
;3397:		bs->teammessage_time = FloatTime() + 1 + random();
ADDRLP4 8
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRFP4 0
INDIRP4
CNSTI4 11696
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
ADDF4
ADDRLP4 8
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 8
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
line 3398
;3398:	}
LABELV $902
line 3399
;3399:	return qtrue;
CNSTI4 1
RETI4
LABELV $899
endproc BotDecidesToHelp 12 12
export BotRushToBase
proc BotRushToBase 8 12
line 3407
;3400:}
;3401:
;3402:/*
;3403:==================
;3404:JUHOX: BotRushToBase
;3405:==================
;3406:*/
;3407:void BotRushToBase(bot_state_t* bs) {
line 3408
;3408:	if (g_gametype.integer != GT_CTF) return;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
EQI4 $905
ADDRGP4 $904
JUMPV
LABELV $905
line 3410
;3409:
;3410:	if (bs->ltgtype != LTG_RUSHBASE) {
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 5
EQI4 $908
line 3411
;3411:		bs->ltgtype = LTG_RUSHBASE;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 5
ASGNI4
line 3412
;3412:		bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11696
ADDP4
CNSTF4 0
ASGNF4
line 3413
;3413:		bs->rushbaseaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7244
ADDP4
CNSTF4 0
ASGNF4
line 3415
;3414:
;3415:		switch (bs->cur_ps.persistant[PERS_TEAM]) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $913
ADDRLP4 0
INDIRI4
CNSTI4 2
EQI4 $914
ADDRGP4 $910
JUMPV
LABELV $913
line 3417
;3416:		case TEAM_RED:
;3417:			memcpy(&bs->teamgoal, &ctf_redflag, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
CNSTI4 11580
ADDP4
ARGP4
ADDRGP4 ctf_redflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 3418
;3418:			break;
ADDRGP4 $911
JUMPV
LABELV $914
line 3420
;3419:		case TEAM_BLUE:
;3420:			memcpy(&bs->teamgoal, &ctf_blueflag, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
CNSTI4 11580
ADDP4
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 3421
;3421:			break;
LABELV $910
LABELV $911
line 3423
;3422:		}
;3423:	}
LABELV $908
line 3424
;3424:	bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 11700
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
ASGNF4
line 3426
;3425:
;3426:	if (BotOwnFlagStatus(bs) == FLAG_ATBASE) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotOwnFlagStatus
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $915
line 3427
;3427:		bs->rushbaseaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7244
ADDP4
CNSTF4 0
ASGNF4
line 3428
;3428:		bs->ltg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6088
ADDP4
CNSTF4 0
ASGNF4
line 3429
;3429:		bs->nbg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6092
ADDP4
CNSTF4 0
ASGNF4
line 3430
;3430:	}
LABELV $915
line 3431
;3431:}
LABELV $904
endproc BotRushToBase 8 12
proc GetPointAreaNum 12 4
line 3439
;3432:
;3433:
;3434:/*
;3435:==================
;3436:JUHOX: GetPointAreaNum
;3437:==================
;3438:*/
;3439:static int GetPointAreaNum(vec3_t point) {
line 3442
;3440:	int areanum;
;3441:
;3442:	areanum = BotPointAreaNum(point);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 3443
;3443:	if (areanum <= 0) return 0;
ADDRLP4 0
INDIRI4
CNSTI4 0
GTI4 $918
CNSTI4 0
RETI4
ADDRGP4 $917
JUMPV
LABELV $918
line 3444
;3444:	if (!trap_AAS_AreaReachability(areanum)) return 0;
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $920
CNSTI4 0
RETI4
ADDRGP4 $917
JUMPV
LABELV $920
line 3445
;3445:	return areanum;
ADDRLP4 0
INDIRI4
RETI4
LABELV $917
endproc GetPointAreaNum 12 4
proc FindPointAreaNum 108 28
line 3453
;3446:}
;3447:
;3448:/*
;3449:==================
;3450:JUHOX: FindPointAreaNum
;3451:==================
;3452:*/
;3453:static int FindPointAreaNum(vec3_t point) {
line 3457
;3454:	int areanum;
;3455:	int i;
;3456:
;3457:	for (i = 0; i < 15; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $923
line 3462
;3458:		vec3_t dir;
;3459:		vec3_t end;
;3460:		trace_t trace;
;3461:
;3462:		dir[0] = crandom();
ADDRLP4 88
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 8
ADDRLP4 88
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 88
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
line 3463
;3463:		dir[1] = crandom();
ADDRLP4 92
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 8+4
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
SUBF4
CNSTF4 1073741824
MULF4
ASGNF4
line 3464
;3464:		dir[2] = crandom();
ADDRLP4 96
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 8+8
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
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
ASGNF4
line 3465
;3465:		VectorNormalize(dir);
ADDRLP4 8
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 3466
;3466:		VectorMA(point, 100, dir, end);
ADDRLP4 100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
ADDRLP4 100
INDIRP4
INDIRF4
ADDRLP4 8
INDIRF4
CNSTF4 1120403456
MULF4
ADDF4
ASGNF4
ADDRLP4 76+4
ADDRLP4 100
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 8+4
INDIRF4
CNSTF4 1120403456
MULF4
ADDF4
ASGNF4
ADDRLP4 76+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 8+8
INDIRF4
CNSTF4 1120403456
MULF4
ADDF4
ASGNF4
line 3467
;3467:		trap_Trace(&trace, point, NULL, NULL, end, ENTITYNUM_NONE, MASK_SOLID);
ADDRLP4 20
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 76
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 3468
;3468:		if (trace.allsolid || trace.startsolid || trace.fraction >= 1) continue;
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $938
ADDRLP4 20+4
INDIRI4
CNSTI4 0
NEI4 $938
ADDRLP4 20+8
INDIRF4
CNSTF4 1065353216
LTF4 $933
LABELV $938
ADDRGP4 $924
JUMPV
LABELV $933
line 3470
;3469:
;3470:		areanum = GetPointAreaNum(trace.endpos);
ADDRLP4 20+12
ARGP4
ADDRLP4 104
ADDRGP4 GetPointAreaNum
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 104
INDIRI4
ASGNI4
line 3471
;3471:		if (areanum <= 0) continue;
ADDRLP4 0
INDIRI4
CNSTI4 0
GTI4 $940
ADDRGP4 $924
JUMPV
LABELV $940
line 3473
;3472:
;3473:		return areanum;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $922
JUMPV
LABELV $924
line 3457
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 15
LTI4 $923
line 3475
;3474:	}
;3475:	return 0;
CNSTI4 0
RETI4
LABELV $922
endproc FindPointAreaNum 108 28
export FindDroppedOrTakenFlag
proc FindDroppedOrTakenFlag 28 4
line 3487
;3476:}
;3477:
;3478:/*
;3479:==================
;3480:JUHOX: FindDroppedOrTakenFlag
;3481:==================
;3482:*/
;3483:static int redFlagArea;
;3484:static float redFlagAreaTime;
;3485:static int blueFlagArea;
;3486:static float blueFlagAreaTime;
;3487:qboolean FindDroppedOrTakenFlag(int team, bot_goal_t* goal) {
line 3492
;3488:	gentity_t* flag;
;3489:	int* flagArea;
;3490:	float* flagAreaTime;
;3491:
;3492:	if (g_gametype.integer != GT_CTF) return qfalse;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
EQI4 $943
CNSTI4 0
RETI4
ADDRGP4 $942
JUMPV
LABELV $943
line 3493
;3493:	flag = Team_GetDroppedOrTakenFlag(team);
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 Team_GetDroppedOrTakenFlag
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 3494
;3494:	if (!flag) return qfalse;
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $946
CNSTI4 0
RETI4
ADDRGP4 $942
JUMPV
LABELV $946
line 3495
;3495:	if (!flag->inuse) return qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $948
CNSTI4 0
RETI4
ADDRGP4 $942
JUMPV
LABELV $948
line 3496
;3496:	if (!flag->r.linked) return qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
CNSTI4 0
NEI4 $950
CNSTI4 0
RETI4
ADDRGP4 $942
JUMPV
LABELV $950
line 3498
;3497:
;3498:	goal->entitynum = flag->s.number;
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 3499
;3499:	goal->areanum = GetPointAreaNum(flag->s.pos.trBase);
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 16
ADDRGP4 GetPointAreaNum
CALLI4
ASGNI4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 3500
;3500:	switch (team) {
ADDRLP4 20
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 1
EQI4 $954
ADDRLP4 20
INDIRI4
CNSTI4 2
EQI4 $955
ADDRGP4 $952
JUMPV
LABELV $954
line 3502
;3501:	case TEAM_RED:
;3502:		flagArea = &redFlagArea;
ADDRLP4 4
ADDRGP4 redFlagArea
ASGNP4
line 3503
;3503:		flagAreaTime = &redFlagAreaTime;
ADDRLP4 8
ADDRGP4 redFlagAreaTime
ASGNP4
line 3504
;3504:		break;
ADDRGP4 $953
JUMPV
LABELV $955
line 3506
;3505:	case TEAM_BLUE:
;3506:		flagArea = &blueFlagArea;
ADDRLP4 4
ADDRGP4 blueFlagArea
ASGNP4
line 3507
;3507:		flagAreaTime = &blueFlagAreaTime;
ADDRLP4 8
ADDRGP4 blueFlagAreaTime
ASGNP4
line 3508
;3508:		break;
ADDRGP4 $953
JUMPV
LABELV $952
line 3510
;3509:	default:
;3510:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $942
JUMPV
LABELV $953
line 3512
;3511:	}
;3512:	if (goal->areanum <= 0) {
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
GTI4 $956
line 3513
;3513:		if (FloatTime() < *flagAreaTime + 1.0 && *flagArea > 0) {
ADDRGP4 floattime
INDIRF4
ADDRLP4 8
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
GEF4 $958
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 0
LEI4 $958
line 3514
;3514:			goal->areanum = *flagArea;
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 4
INDIRP4
INDIRI4
ASGNI4
line 3515
;3515:		}
ADDRGP4 $957
JUMPV
LABELV $958
line 3516
;3516:		else {
line 3517
;3517:			goal->areanum = FindPointAreaNum(flag->s.pos.trBase);
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 24
ADDRGP4 FindPointAreaNum
CALLI4
ASGNI4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 24
INDIRI4
ASGNI4
line 3518
;3518:			if (goal->areanum > 0) {
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
LEI4 $960
line 3519
;3519:				*flagArea = goal->areanum;
ADDRLP4 4
INDIRP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 3520
;3520:				*flagAreaTime = FloatTime();
ADDRLP4 8
INDIRP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 3521
;3521:			}
ADDRGP4 $957
JUMPV
LABELV $960
line 3522
;3522:			else if (*flagArea > 0 && FloatTime() < *flagAreaTime + 3.0) {
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 0
LEI4 $962
ADDRGP4 floattime
INDIRF4
ADDRLP4 8
INDIRP4
INDIRF4
CNSTF4 1077936128
ADDF4
GEF4 $962
line 3523
;3523:				goal->areanum = *flagArea;
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 4
INDIRP4
INDIRI4
ASGNI4
line 3524
;3524:			}
ADDRGP4 $957
JUMPV
LABELV $962
line 3525
;3525:			else {
line 3526
;3526:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $942
JUMPV
line 3528
;3527:			}
;3528:		}
line 3529
;3529:	}
LABELV $956
line 3530
;3530:	else {
line 3531
;3531:		*flagArea = goal->areanum;
ADDRLP4 4
INDIRP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 3532
;3532:		*flagAreaTime = FloatTime();
ADDRLP4 8
INDIRP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 3533
;3533:	}
LABELV $957
line 3534
;3534:	goal->flags = 0;
ADDRFP4 4
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 3535
;3535:	VectorCopy(flag->s.pos.trBase, goal->origin);
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 3536
;3536:	VectorSet(goal->mins, -8, -8, -8);
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 3238002688
ASGNF4
line 3537
;3537:	VectorSet(goal->maxs, 8, 8, 8);
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 1090519040
ASGNF4
line 3538
;3538:	return qtrue;
CNSTI4 1
RETI4
LABELV $942
endproc FindDroppedOrTakenFlag 28 4
export LocateFlag
proc LocateFlag 20 12
line 3546
;3539:}
;3540:
;3541:/*
;3542:==================
;3543:JUHOX: LocateFlag
;3544:==================
;3545:*/
;3546:qboolean LocateFlag(int team, bot_goal_t* goal) {
line 3547
;3547:	if (g_gametype.integer != GT_CTF) return qfalse;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
EQI4 $965
CNSTI4 0
RETI4
ADDRGP4 $964
JUMPV
LABELV $965
line 3548
;3548:	switch (Team_GetFlagStatus(team)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 Team_GetFlagStatus
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $971
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $976
ADDRLP4 0
INDIRI4
CNSTI4 4
EQI4 $976
ADDRGP4 $968
JUMPV
LABELV $971
line 3550
;3549:	case FLAG_ATBASE:
;3550:		switch (team) {
ADDRLP4 12
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 1
EQI4 $974
ADDRLP4 12
INDIRI4
CNSTI4 2
EQI4 $975
ADDRGP4 $972
JUMPV
LABELV $974
line 3552
;3551:		case TEAM_RED:
;3552:			memcpy(goal, &ctf_redflag, sizeof(*goal));
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 ctf_redflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 3553
;3553:			redFlagArea = 0;
ADDRGP4 redFlagArea
CNSTI4 0
ASGNI4
line 3554
;3554:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $964
JUMPV
LABELV $975
line 3556
;3555:		case TEAM_BLUE:
;3556:			memcpy(goal, &ctf_blueflag, sizeof(*goal));
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 3557
;3557:			blueFlagArea = 0;
ADDRGP4 blueFlagArea
CNSTI4 0
ASGNI4
line 3558
;3558:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $964
JUMPV
LABELV $972
line 3560
;3559:		}
;3560:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $964
JUMPV
LABELV $976
line 3564
;3561:	case FLAG_TAKEN:
;3562:		//return FindTakenFlag(team, goal);
;3563:	case FLAG_DROPPED:
;3564:		return FindDroppedOrTakenFlag(team, goal);
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 FindDroppedOrTakenFlag
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
RETI4
ADDRGP4 $964
JUMPV
LABELV $968
line 3566
;3565:	default:
;3566:		return qfalse;
CNSTI4 0
RETI4
LABELV $964
endproc LocateFlag 20 12
export BotGetDroppedFlag
proc BotGetDroppedFlag 60 12
line 3575
;3567:	}
;3568:}
;3569:
;3570:/*
;3571:==================
;3572:JUHOX: BotGetDroppedFlag
;3573:==================
;3574:*/
;3575:void BotGetDroppedFlag(bot_state_t* bs, int team) {
line 3578
;3576:	bot_goal_t goal;
;3577:
;3578:	bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
line 3579
;3579:	if (!FindDroppedOrTakenFlag(team, &goal)) return;
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 56
ADDRGP4 FindDroppedOrTakenFlag
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
NEI4 $978
ADDRGP4 $977
JUMPV
LABELV $978
line 3582
;3580:
;3581:	//set message time to zero so bot will NOT show any message
;3582:	bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11696
ADDP4
CNSTF4 0
ASGNF4
line 3583
;3583:	bs->ltgtype = LTG_GETITEM;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 10
ASGNI4
line 3585
;3584:	//set the team goal
;3585:	memcpy(&bs->teamgoal, &goal, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
CNSTI4 11580
ADDP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 3587
;3586:	//get the team goal time
;3587:	bs->teamgoal_time = FloatTime() + 120;
ADDRFP4 0
INDIRP4
CNSTI4 11700
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
ASGNF4
line 3588
;3588:	bs->teammate = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11560
ADDP4
CNSTI4 0
ASGNI4
line 3589
;3589:}
LABELV $977
endproc BotGetDroppedFlag 60 12
export BotTeamReadyToGo
proc BotTeamReadyToGo 480 12
line 3596
;3590:
;3591:/*
;3592:==================
;3593:JUHOX: BotTeamReadyToGo
;3594:==================
;3595:*/
;3596:qboolean BotTeamReadyToGo(bot_state_t* bs) {
line 3600
;3597:	playerState_t ps;
;3598:	int teammate;
;3599:
;3600:	if (gametype < GT_TEAM) return qtrue;
ADDRGP4 gametype
INDIRI4
CNSTI4 3
GEI4 $981
CNSTI4 1
RETI4
ADDRGP4 $980
JUMPV
LABELV $981
line 3602
;3601:
;3602:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $983
line 3603
;3603:		if (BotOwnFlagStatus(bs) != FLAG_ATBASE) return qtrue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 472
ADDRGP4 BotOwnFlagStatus
CALLI4
ASGNI4
ADDRLP4 472
INDIRI4
CNSTI4 0
EQI4 $985
CNSTI4 1
RETI4
ADDRGP4 $980
JUMPV
LABELV $985
line 3604
;3604:		if (BotEnemyFlagStatus(bs) == FLAG_TAKEN) return qtrue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 476
ADDRGP4 BotEnemyFlagStatus
CALLI4
ASGNI4
ADDRLP4 476
INDIRI4
CNSTI4 1
NEI4 $987
CNSTI4 1
RETI4
ADDRGP4 $980
JUMPV
LABELV $987
line 3605
;3605:	}
LABELV $983
line 3607
;3606:
;3607:	for (teammate = -1; (teammate = BotGetNextTeamMate(bs, teammate, &ps)) >= 0; ) {
ADDRLP4 468
CNSTI4 -1
ASGNI4
ADDRGP4 $992
JUMPV
LABELV $989
line 3610
;3608:		int danger;
;3609:
;3610:		if (ps.stats[STAT_HEALTH] <= 0) continue;
ADDRLP4 0+184
INDIRI4
CNSTI4 0
GTI4 $993
ADDRGP4 $990
JUMPV
LABELV $993
line 3611
;3611:		if (ps.powerups[PW_REDFLAG] || ps.powerups[PW_BLUEFLAG]) continue;
ADDRLP4 0+312+28
INDIRI4
CNSTI4 0
NEI4 $1002
ADDRLP4 0+312+32
INDIRI4
CNSTI4 0
EQI4 $996
LABELV $1002
ADDRGP4 $990
JUMPV
LABELV $996
line 3612
;3612:		danger = BotPlayerDanger(&ps);
ADDRLP4 0
ARGP4
ADDRLP4 476
ADDRGP4 BotPlayerDanger
CALLI4
ASGNI4
ADDRLP4 472
ADDRLP4 476
INDIRI4
ASGNI4
line 3614
;3613:		if (
;3614:			danger >= 25 ||
ADDRLP4 472
INDIRI4
CNSTI4 25
GEI4 $1009
ADDRLP4 0+184+28
INDIRI4
CVIF4 4
CNSTF4 1161527296
LTF4 $1009
ADDRLP4 0+148
INDIRI4
CNSTI4 0
EQI4 $1003
LABELV $1009
line 3623
;3615:			ps.stats[STAT_STRENGTH] < LOW_STRENGTH_VALUE ||
;3616:			ps.weaponstate != WEAPON_READY/* ||
;3617:			(
;3618:				danger >= 10 &&
;3619:				!BotEntityVisible(&bs->cur_ps, 360, teammate) &&
;3620:				trap_AAS_AreaTravelTimeToGoalArea(BotPointAreaNum(ps.origin), ps.origin, bs->areanum, TFL_DEFAULT) > 200
;3621:			)
;3622:			*/
;3623:		) {
line 3624
;3624:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $980
JUMPV
LABELV $1003
line 3626
;3625:		}
;3626:	}
LABELV $990
line 3607
LABELV $992
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 468
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 472
ADDRGP4 BotGetNextTeamMate
CALLI4
ASGNI4
ADDRLP4 468
ADDRLP4 472
INDIRI4
ASGNI4
ADDRLP4 472
INDIRI4
CNSTI4 0
GEI4 $989
line 3627
;3627:	return qtrue;
CNSTI4 1
RETI4
LABELV $980
endproc BotTeamReadyToGo 480 12
proc BotFulfilMission 120 8
line 3636
;3628:}
;3629:
;3630:/*
;3631:==================
;3632:JUHOX: BotFulfilMission
;3633:==================
;3634:*/
;3635:#if BOTS_USE_TSS
;3636:static void BotFulfilMission(bot_state_t* bs) {
line 3640
;3637:	tss_mission_t mission;
;3638:	bot_goal_t goal;
;3639:
;3640:	if (!BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_isValid)) return;
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 60
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
NEI4 $1011
ADDRGP4 $1010
JUMPV
LABELV $1011
line 3641
;3641:	mission = BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_mission);
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTI4 3
ARGI4
ADDRLP4 64
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 64
INDIRI4
ASGNI4
line 3643
;3642:
;3643:	switch (mission) {
ADDRLP4 68
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 1
LTI4 $1013
ADDRLP4 68
INDIRI4
CNSTI4 6
GTI4 $1013
ADDRLP4 68
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1052-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1052
address $1016
address $1027
address $1036
address $1043
address $1050
address $1051
code
LABELV $1016
line 3645
;3644:	case TSSMISSION_seek_enemy:
;3645:		if (bs->enemy >= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 0
LTI4 $1017
line 3646
;3646:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
line 3647
;3647:			return;
ADDRGP4 $1010
JUMPV
LABELV $1017
line 3650
;3648:		}
;3649:
;3650:		if (bs->ltgtype == LTG_CAMP) return;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 7
NEI4 $1019
ADDRGP4 $1010
JUMPV
LABELV $1019
line 3651
;3651:		if (BotChooseTeamleaderGoal(bs, &goal)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 76
ADDRGP4 BotChooseTeamleaderGoal
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
EQI4 $1021
line 3652
;3652:			bs->noTeamLeaderGoal_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11860
ADDP4
CNSTF4 0
ASGNF4
line 3653
;3653:			BotGoNearGoal(bs, &goal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 BotGoNearGoal
CALLV
pop
line 3654
;3654:		}
ADDRGP4 $1014
JUMPV
LABELV $1021
line 3655
;3655:		else if (bs->noTeamLeaderGoal_time <= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 11860
ADDP4
INDIRF4
CNSTF4 0
GTF4 $1023
line 3656
;3656:			bs->noTeamLeaderGoal_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 11860
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 3657
;3657:		}
ADDRGP4 $1014
JUMPV
LABELV $1023
line 3658
;3658:		else if (bs->noTeamLeaderGoal_time < FloatTime() - 4) {
ADDRFP4 0
INDIRP4
CNSTI4 11860
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1082130432
SUBF4
GEF4 $1014
line 3659
;3659:			bs->leader = -1;
ADDRFP4 0
INDIRP4
CNSTI4 11872
ADDP4
CNSTI4 -1
ASGNI4
line 3660
;3660:		}
line 3661
;3661:		break;
ADDRGP4 $1014
JUMPV
LABELV $1027
line 3663
;3662:	case TSSMISSION_seek_items:
;3663:		if (bs->ltgtype == LTG_CAMP) return;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 7
NEI4 $1028
ADDRGP4 $1010
JUMPV
LABELV $1028
line 3664
;3664:		if (BotChooseTeamleaderGoal(bs, &goal)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 80
ADDRGP4 BotChooseTeamleaderGoal
CALLI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 0
EQI4 $1030
line 3665
;3665:			bs->noTeamLeaderGoal_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11860
ADDP4
CNSTF4 0
ASGNF4
line 3666
;3666:			BotGoNearGoal(bs, &goal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 BotGoNearGoal
CALLV
pop
line 3667
;3667:		}
ADDRGP4 $1014
JUMPV
LABELV $1030
line 3668
;3668:		else if (bs->noTeamLeaderGoal_time <= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 11860
ADDP4
INDIRF4
CNSTF4 0
GTF4 $1032
line 3669
;3669:			bs->noTeamLeaderGoal_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 11860
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 3670
;3670:		}
ADDRGP4 $1014
JUMPV
LABELV $1032
line 3671
;3671:		else if (bs->noTeamLeaderGoal_time < FloatTime() - 4) {
ADDRFP4 0
INDIRP4
CNSTI4 11860
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1082130432
SUBF4
GEF4 $1014
line 3672
;3672:			bs->leader = -1;
ADDRFP4 0
INDIRP4
CNSTI4 11872
ADDP4
CNSTI4 -1
ASGNI4
line 3673
;3673:		}
line 3674
;3674:		break;
ADDRGP4 $1014
JUMPV
LABELV $1036
line 3676
;3675:	case TSSMISSION_capture_enemy_flag:
;3676:		switch (BotEnemyFlagStatus(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 88
ADDRGP4 BotEnemyFlagStatus
CALLI4
ASGNI4
ADDRLP4 84
ADDRLP4 88
INDIRI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
EQI4 $1040
ADDRLP4 84
INDIRI4
CNSTI4 1
EQI4 $1042
ADDRLP4 84
INDIRI4
CNSTI4 4
EQI4 $1041
ADDRGP4 $1037
JUMPV
LABELV $1040
line 3678
;3677:		case FLAG_ATBASE:
;3678:			bs->ltgtype = LTG_GETFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 4
ASGNI4
line 3679
;3679:			bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11696
ADDP4
CNSTF4 0
ASGNF4
line 3680
;3680:			bs->teamgoal_time = trap_AAS_Time() + CTF_GETFLAG_TIME;
ADDRLP4 96
ADDRGP4 trap_AAS_Time
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 11700
ADDP4
ADDRLP4 96
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 3681
;3681:			break;
ADDRGP4 $1014
JUMPV
LABELV $1041
line 3683
;3682:		case FLAG_DROPPED:
;3683:			BotGetDroppedFlag(bs, OtherTeam(bs->cur_ps.persistant[PERS_TEAM]));
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ARGI4
ADDRLP4 100
ADDRGP4 OtherTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 100
INDIRI4
ARGI4
ADDRGP4 BotGetDroppedFlag
CALLV
pop
line 3684
;3684:			break;
ADDRGP4 $1014
JUMPV
LABELV $1042
LABELV $1037
line 3688
;3685:		case FLAG_TAKEN:
;3686:		default:
;3687:			// should not happen
;3688:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
line 3689
;3689:			break;
line 3691
;3690:		}
;3691:		break;
ADDRGP4 $1014
JUMPV
LABELV $1043
line 3693
;3692:	case TSSMISSION_defend_our_flag:
;3693:		switch (BotOwnFlagStatus(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 100
ADDRGP4 BotOwnFlagStatus
CALLI4
ASGNI4
ADDRLP4 96
ADDRLP4 100
INDIRI4
ASGNI4
ADDRLP4 96
INDIRI4
CNSTI4 0
EQI4 $1047
ADDRLP4 96
INDIRI4
CNSTI4 1
EQI4 $1049
ADDRLP4 96
INDIRI4
CNSTI4 4
EQI4 $1048
ADDRGP4 $1044
JUMPV
LABELV $1047
line 3695
;3694:		case FLAG_ATBASE:
;3695:			BotGoToGoal(bs, BotGetHomeBase(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 108
ADDRGP4 BotGetHomeBase
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 108
INDIRP4
ARGP4
ADDRGP4 BotGoToGoal
CALLV
pop
line 3696
;3696:			break;
ADDRGP4 $1014
JUMPV
LABELV $1048
line 3698
;3697:		case FLAG_DROPPED:
;3698:			BotGetDroppedFlag(bs, bs->cur_ps.persistant[PERS_TEAM]);
ADDRLP4 112
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 112
INDIRP4
ARGP4
ADDRLP4 112
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotGetDroppedFlag
CALLV
pop
line 3699
;3699:			break;
ADDRGP4 $1014
JUMPV
LABELV $1049
line 3701
;3700:		case FLAG_TAKEN:
;3701:			bs->ltgtype = LTG_RETURNFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 6
ASGNI4
line 3702
;3702:			bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11696
ADDP4
CNSTF4 0
ASGNF4
line 3703
;3703:			bs->teamgoal_time = trap_AAS_Time() + CTF_RETURNFLAG_TIME;
ADDRLP4 116
ADDRGP4 trap_AAS_Time
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 11700
ADDP4
ADDRLP4 116
INDIRF4
CNSTF4 1127481344
ADDF4
ASGNF4
line 3704
;3704:			break;
ADDRGP4 $1014
JUMPV
LABELV $1044
line 3706
;3705:		default:
;3706:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
line 3707
;3707:			break;
line 3709
;3708:		}
;3709:		break;
ADDRGP4 $1014
JUMPV
LABELV $1050
line 3711
;3710:	case TSSMISSION_defend_our_base:
;3711:		BotGoToGoal(bs, BotGetHomeBase(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 108
ADDRGP4 BotGetHomeBase
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 108
INDIRP4
ARGP4
ADDRGP4 BotGoToGoal
CALLV
pop
line 3712
;3712:		break;
ADDRGP4 $1014
JUMPV
LABELV $1051
line 3714
;3713:	case TSSMISSION_occupy_enemy_base:
;3714:		BotGoToGoal(bs, BotGetEnemyBase(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 112
ADDRGP4 BotGetEnemyBase
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 112
INDIRP4
ARGP4
ADDRGP4 BotGoToGoal
CALLV
pop
line 3715
;3715:		break;
ADDRGP4 $1014
JUMPV
LABELV $1013
line 3717
;3716:	default:
;3717:		bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
line 3718
;3718:		break;
LABELV $1014
line 3720
;3719:	}
;3720:}
LABELV $1010
endproc BotFulfilMission 120 8
export BotTeamGameSingleBotAI
proc BotTeamGameSingleBotAI 512 16
line 3728
;3721:#endif
;3722:
;3723:/*
;3724:==================
;3725:JUHOX: BotTeamGameSingleBotAI
;3726:==================
;3727:*/
;3728:void BotTeamGameSingleBotAI(bot_state_t* bs) {
line 3729
;3729:	if (bs->singlebot_ltg_check_time > FloatTime()) return;
ADDRFP4 0
INDIRP4
CNSTI4 11536
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $1055
ADDRGP4 $1054
JUMPV
LABELV $1055
line 3730
;3730:	bs->singlebot_ltg_check_time = FloatTime() + 0.5 + random();
ADDRLP4 0
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRFP4 0
INDIRP4
CNSTI4 11536
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1056964608
ADDF4
ADDRLP4 0
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 0
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
line 3732
;3731:
;3732:	if (bs->ltgtype == LTG_ESCAPE) return;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 16
NEI4 $1057
ADDRGP4 $1054
JUMPV
LABELV $1057
line 3733
;3733:	if (BotWantsToEscape(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 BotWantsToEscape
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $1059
line 3734
;3734:		BotActivateHumanHelpers(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotActivateHumanHelpers
CALLV
pop
line 3735
;3735:		bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
line 3736
;3736:		return;
ADDRGP4 $1054
JUMPV
LABELV $1059
line 3739
;3737:	}
;3738:
;3739:	if (gametype < GT_TEAM) return;
ADDRGP4 gametype
INDIRI4
CNSTI4 3
GEI4 $1061
ADDRGP4 $1054
JUMPV
LABELV $1061
line 3742
;3740:
;3741:#if BOTS_USE_TSS
;3742:	if (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_isValid)) {
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $1063
line 3746
;3743:		tss_missionTask_t task;
;3744:		int teammate;
;3745:
;3746:		task = BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_task);
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTI4 5
ARGI4
ADDRLP4 20
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 20
INDIRI4
ASGNI4
line 3747
;3747:		switch (task) {
ADDRLP4 24
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
LTI4 $1065
ADDRLP4 24
INDIRI4
CNSTI4 9
GTI4 $1065
ADDRLP4 24
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1094
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1094
address $1071
address $1068
address $1091
address $1068
address $1068
address $1092
address $1068
address $1068
address $1093
address $1091
code
LABELV $1068
line 3753
;3748:		case TSSMT_stickToGroupLeader:
;3749:		case TSSMT_helpTeamMate:
;3750:		case TSSMT_guardFlagCarrier:
;3751:		case TSSMT_seekGroupMember:
;3752:		case TSSMT_seekEnemyNearTeamMate:
;3753:			teammate = BotTeamMateToFollow(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 BotTeamMateToFollow
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 32
INDIRI4
ASGNI4
line 3754
;3754:			if (teammate < 0) {
ADDRLP4 16
INDIRI4
CNSTI4 0
GEI4 $1069
line 3755
;3755:				bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
line 3756
;3756:				break;
ADDRGP4 $1054
JUMPV
LABELV $1069
line 3758
;3757:			}
;3758:			BotSearchTeammate(bs, teammate);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
INDIRI4
ARGI4
ADDRGP4 BotSearchTeammate
CALLI4
pop
line 3759
;3759:			break;
ADDRGP4 $1054
JUMPV
LABELV $1071
line 3761
;3760:		case TSSMT_followGroupLeader:
;3761:			{
line 3766
;3762:				gclient_t* client;
;3763:				bot_goal_t missionGoal;
;3764:				qboolean missionGoalAvailable;
;3765:
;3766:				teammate = BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_taskGoal);
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTI4 13
ARGI4
ADDRLP4 100
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 100
INDIRI4
ASGNI4
line 3767
;3767:				if (teammate < 0 || teammate >= MAX_CLIENTS || teammate == bs->client) {
ADDRLP4 104
ADDRLP4 16
INDIRI4
ASGNI4
ADDRLP4 104
INDIRI4
CNSTI4 0
LTI4 $1075
ADDRLP4 104
INDIRI4
CNSTI4 64
GEI4 $1075
ADDRLP4 104
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1072
LABELV $1075
line 3768
;3768:					bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
line 3769
;3769:					break;
ADDRGP4 $1054
JUMPV
LABELV $1072
line 3771
;3770:				}
;3771:				client = &level.clients[teammate];
ADDRLP4 36
ADDRLP4 16
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 3772
;3772:				switch (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_mission)) {
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTI4 3
ARGI4
ADDRLP4 112
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 108
ADDRLP4 112
INDIRI4
ASGNI4
ADDRLP4 108
INDIRI4
CNSTI4 1
LTI4 $1076
ADDRLP4 108
INDIRI4
CNSTI4 6
GTI4 $1076
ADDRLP4 108
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1084-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1084
address $1083
address $1083
address $1079
address $1081
address $1082
address $1080
code
LABELV $1079
line 3774
;3773:				case TSSMISSION_capture_enemy_flag:
;3774:					missionGoalAvailable = LocateFlag(OtherTeam(bs->cur_ps.persistant[PERS_TEAM]), &missionGoal);
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ARGI4
ADDRLP4 120
ADDRGP4 OtherTeam
CALLI4
ASGNI4
ADDRLP4 120
INDIRI4
ARGI4
ADDRLP4 44
ARGP4
ADDRLP4 124
ADDRGP4 LocateFlag
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 124
INDIRI4
ASGNI4
line 3775
;3775:					break;
ADDRGP4 $1077
JUMPV
LABELV $1080
line 3777
;3776:				case TSSMISSION_occupy_enemy_base:
;3777:					missionGoal = *BotGetEnemyBase(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 128
ADDRGP4 BotGetEnemyBase
CALLP4
ASGNP4
ADDRLP4 44
ADDRLP4 128
INDIRP4
INDIRB
ASGNB 56
line 3778
;3778:					missionGoalAvailable = qtrue;
ADDRLP4 40
CNSTI4 1
ASGNI4
line 3779
;3779:					break;
ADDRGP4 $1077
JUMPV
LABELV $1081
line 3781
;3780:				case TSSMISSION_defend_our_flag:
;3781:					missionGoalAvailable = LocateFlag(bs->cur_ps.persistant[PERS_TEAM], &missionGoal);
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ARGI4
ADDRLP4 44
ARGP4
ADDRLP4 132
ADDRGP4 LocateFlag
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 132
INDIRI4
ASGNI4
line 3782
;3782:					break;
ADDRGP4 $1077
JUMPV
LABELV $1082
line 3784
;3783:				case TSSMISSION_defend_our_base:
;3784:					missionGoal = *BotGetHomeBase(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 136
ADDRGP4 BotGetHomeBase
CALLP4
ASGNP4
ADDRLP4 44
ADDRLP4 136
INDIRP4
INDIRB
ASGNB 56
line 3785
;3785:					missionGoalAvailable = qtrue;
ADDRLP4 40
CNSTI4 1
ASGNI4
line 3786
;3786:					break;
ADDRGP4 $1077
JUMPV
LABELV $1083
LABELV $1076
line 3790
;3787:				case TSSMISSION_seek_enemy:
;3788:				case TSSMISSION_seek_items:
;3789:				default:
;3790:					missionGoalAvailable = qfalse;
ADDRLP4 40
CNSTI4 0
ASGNI4
line 3791
;3791:					break;
LABELV $1077
line 3794
;3792:				}
;3793:				if (
;3794:					missionGoalAvailable &&
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $1086
ADDRLP4 120
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 120
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
ARGI4
ADDRLP4 120
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 124
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 128
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 128
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
ARGI4
ADDRLP4 128
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 44+12
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 132
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 124
INDIRI4
ADDRLP4 132
INDIRI4
CNSTI4 200
ADDI4
LEI4 $1086
line 3801
;3795:					trap_AAS_AreaTravelTimeToGoalArea(
;3796:						bs->areanum, bs->origin, client->tssLastValidAreaNum, TFL_DEFAULT
;3797:					) >
;3798:					trap_AAS_AreaTravelTimeToGoalArea(
;3799:						bs->areanum, bs->origin, missionGoal.areanum, TFL_DEFAULT
;3800:					) + 200
;3801:				) {
line 3802
;3802:					BotFulfilMission(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotFulfilMission
CALLV
pop
line 3803
;3803:				}
ADDRGP4 $1054
JUMPV
LABELV $1086
line 3804
;3804:				else {
line 3805
;3805:					teammate = BotTeamMateToFollow(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 136
ADDRGP4 BotTeamMateToFollow
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 136
INDIRI4
ASGNI4
line 3806
;3806:					if (teammate < 0) {
ADDRLP4 16
INDIRI4
CNSTI4 0
GEI4 $1089
line 3807
;3807:						bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
line 3808
;3808:					}
ADDRGP4 $1054
JUMPV
LABELV $1089
line 3809
;3809:					else {
line 3810
;3810:						BotSearchTeammate(bs, teammate);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
INDIRI4
ARGI4
ADDRGP4 BotSearchTeammate
CALLI4
pop
line 3811
;3811:					}
line 3812
;3812:				}
line 3813
;3813:			}
line 3814
;3814:			break;
ADDRGP4 $1054
JUMPV
LABELV $1091
LABELV $1065
line 3818
;3815:		case TSSMT_retreat:
;3816:		case TSSMT_prepareForMission:
;3817:		default:
;3818:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
line 3819
;3819:			break;
ADDRGP4 $1054
JUMPV
LABELV $1092
line 3821
;3820:		case TSSMT_rushToBase:
;3821:			BotRushToBase(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRushToBase
CALLV
pop
line 3822
;3822:			break;
ADDRGP4 $1054
JUMPV
LABELV $1093
line 3824
;3823:		case TSSMT_fulfilMission:
;3824:			BotFulfilMission(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotFulfilMission
CALLV
pop
line 3825
;3825:			break;
line 3827
;3826:		}
;3827:		return;
ADDRGP4 $1054
JUMPV
LABELV $1063
line 3832
;3828:	}
;3829:#endif
;3830:
;3831:	// check some special cases
;3832:	if (bs->cur_ps.powerups[PW_REDFLAG] || bs->cur_ps.powerups[PW_BLUEFLAG]) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 356
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1097
ADDRLP4 12
INDIRP4
CNSTI4 360
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1095
LABELV $1097
line 3833
;3833:		BotRushToBase(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRushToBase
CALLV
pop
line 3834
;3834:		return;
ADDRGP4 $1054
JUMPV
LABELV $1095
line 3837
;3835:	}
;3836:	if (
;3837:		gametype == GT_CTF &&
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $1098
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 BotOwnFlagStatus
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 1
NEI4 $1098
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 BotEnemyFlagStatus
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $1098
line 3840
;3838:		BotOwnFlagStatus(bs) == FLAG_TAKEN &&
;3839:		BotEnemyFlagStatus(bs) == FLAG_ATBASE
;3840:	) {
line 3841
;3841:		bs->ltgtype = LTG_GETFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 4
ASGNI4
line 3842
;3842:		bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11696
ADDP4
CNSTF4 0
ASGNF4
line 3843
;3843:		bs->teamgoal_time = FloatTime() + CTF_GETFLAG_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 11700
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 3844
;3844:		return;
ADDRGP4 $1054
JUMPV
LABELV $1098
line 3848
;3845:	}
;3846:
;3847:	// standard case
;3848:	if (!bs->ltgtype || bs->ltgtype == LTG_TEAMHELP) {
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1102
ADDRLP4 24
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1100
LABELV $1102
line 3852
;3849:		int teammate;
;3850:		playerState_t ps;
;3851:
;3852:		teammate = BotTeamMateToFollow(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 500
ADDRGP4 BotTeamMateToFollow
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 500
INDIRI4
ASGNI4
line 3853
;3853:		if (teammate < 0) {
ADDRLP4 28
INDIRI4
CNSTI4 0
GEI4 $1103
line 3854
;3854:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
line 3855
;3855:			return;
ADDRGP4 $1054
JUMPV
LABELV $1103
line 3858
;3856:		}
;3857:		
;3858:		if (!BotAI_GetClientState(teammate, &ps)) {
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 32
ARGP4
ADDRLP4 504
ADDRGP4 BotAI_GetClientState
CALLI4
ASGNI4
ADDRLP4 504
INDIRI4
CNSTI4 0
NEI4 $1105
line 3859
;3859:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
line 3860
;3860:			return;
ADDRGP4 $1054
JUMPV
LABELV $1105
line 3862
;3861:		}
;3862:		if (BotPlayerDanger(&ps) >= 50) {
ADDRLP4 32
ARGP4
ADDRLP4 508
ADDRGP4 BotPlayerDanger
CALLI4
ASGNI4
ADDRLP4 508
INDIRI4
CNSTI4 50
LTI4 $1107
line 3863
;3863:			BotDecidesToHelp(bs, teammate);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
INDIRI4
ARGI4
ADDRGP4 BotDecidesToHelp
CALLI4
pop
line 3864
;3864:		}
ADDRGP4 $1101
JUMPV
LABELV $1107
line 3865
;3865:		else {
line 3866
;3866:			BotSearchTeammate(bs, teammate);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
INDIRI4
ARGI4
ADDRGP4 BotSearchTeammate
CALLI4
pop
line 3867
;3867:		}
line 3868
;3868:	}
ADDRGP4 $1101
JUMPV
LABELV $1100
line 3869
;3869:	else if (bs->leader != bs->client) {
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 11872
ADDP4
INDIRI4
ADDRLP4 28
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
EQI4 $1109
line 3870
;3870:		bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
line 3871
;3871:	}
LABELV $1109
LABELV $1101
line 3872
;3872:}
LABELV $1054
endproc BotTeamGameSingleBotAI 512 16
proc BotSetGroupFormation 48 8
line 3880
;3873:
;3874:/*
;3875:==================
;3876:JUHOX: BotSetGroupFormation
;3877:==================
;3878:*/
;3879:#if BOTS_USE_TSS
;3880:static void BotSetGroupFormation(bot_state_t* bs) {
line 4020
;3881:// JUHOX FIXME: as far as I remember the TSS does NOT support the following logic completely, so DONT REMOVE it!
;3882:/*
;3883:	tss_mission_t mission;
;3884:	tss_groupFormation_t oldGF;
;3885:	tss_groupFormation_t newGF;
;3886:	playerState_t ps;
;3887:
;3888:	mission = BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_mission);
;3889:	oldGF = BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_groupFormation);
;3890:
;3891:	if (mission != bs->oldMission) {
;3892:		bs->oldMission = mission;
;3893:		bs->missionChangeTime = FloatTime();
;3894:	}
;3895:
;3896:	if (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_missionStatus) == TSSMS_aborted) {
;3897:		newGF = TSSGF_tight;
;3898:	}
;3899:	else {
;3900:		switch (mission) {
;3901:		case TSSMISSION_seek_enemy:
;3902:			if (bs->enemy < 0) {
;3903:				newGF = TSSGF_tight;
;3904:			}
;3905:			else {
;3906:				newGF = TSSGF_loose;
;3907:			}
;3908:			break;
;3909:		case TSSMISSION_seek_items:
;3910:		case TSSMISSION_defend_our_base:
;3911:			newGF = TSSGF_loose;
;3912:			break;
;3913:		case TSSMISSION_occupy_enemy_base:
;3914:			if (BotOwnFlagStatus(bs) != FLAG_ATBASE && BotEnemyFlagStatus(bs) != FLAG_TAKEN) {
;3915:				newGF = TSSGF_free;
;3916:			}
;3917:			else if (NearHomeBase(OtherTeam(bs->cur_ps.persistant[PERS_TEAM]), bs->origin, 9)) {
;3918:				newGF = TSSGF_loose;
;3919:			}
;3920:			else {
;3921:				newGF = TSSGF_tight;
;3922:			}
;3923:			break;
;3924:		case TSSMISSION_capture_enemy_flag:
;3925:			switch (BotEnemyFlagStatus(bs)) {
;3926:			case FLAG_TAKEN:
;3927:			default:
;3928:				newGF = TSSGF_tight;
;3929:				break;
;3930:			case FLAG_DROPPED:
;3931:				newGF = TSSGF_free;
;3932:				break;
;3933:			case FLAG_ATBASE:
;3934:				if (
;3935:					NearHomeBase(OtherTeam(bs->cur_ps.persistant[PERS_TEAM]), bs->origin, 9) ||
;3936:					BotOwnFlagStatus(bs) != FLAG_ATBASE
;3937:				) {
;3938:					newGF = TSSGF_free;
;3939:				}
;3940:				else {
;3941:					newGF = TSSGF_tight;
;3942:				}
;3943:				break;
;3944:			}
;3945:			break;
;3946:		case TSSMISSION_defend_our_flag:
;3947:			switch (BotOwnFlagStatus(bs)) {
;3948:			case FLAG_ATBASE:
;3949:				newGF = TSSGF_loose;
;3950:				if (!NearHomeBase(bs->cur_ps.persistant[PERS_TEAM], bs->origin, 1)) {
;3951:					newGF = TSSGF_free;
;3952:				}
;3953:				break;
;3954:			case FLAG_DROPPED:
;3955:				newGF = TSSGF_free;
;3956:				break;
;3957:			case FLAG_TAKEN:
;3958:				newGF = TSSGF_tight;
;3959:				if (BotEnemyFlagStatus(bs) != FLAG_TAKEN) {
;3960:					newGF = TSSGF_free;
;3961:				}
;3962:				else if (BotAI_GetClientState(bs->enemy, &ps)) {
;3963:					if (ps.powerups[PW_REDFLAG] || ps.powerups[PW_BLUEFLAG]) {
;3964:						newGF = TSSGF_free;
;3965:					}
;3966:				}
;3967:				break;
;3968:			}
;3969:			break;
;3970:		default:	// should not happen
;3971:			newGF = TSSGF_tight;
;3972:			break;
;3973:		}
;3974:	}
;3975:
;3976:	if (newGF == oldGF) {
;3977:		bs->groupFormationProposal = newGF;
;3978:		bs->groupFormationProposalTime = 0;
;3979:	}
;3980:	else if (
;3981:		newGF != bs->groupFormationProposal ||
;3982:		bs->groupFormationProposalTime <= 0.0
;3983:	) {
;3984:		bs->groupFormationProposal = newGF;
;3985:		if (bs->missionChangeTime < FloatTime() - 2) {
;3986:			bs->groupFormationProposalTime = FloatTime() + 0.5;
;3987:		}
;3988:		else {
;3989:			bs->groupFormationProposalTime = FloatTime() + 1 + random();
;3990:		}
;3991:	}
;3992:	else if (bs->groupFormationProposalTime < FloatTime()) {
;3993:		int group;
;3994:
;3995:		bs->groupFormationProposalTime = 0.0;
;3996:
;3997:		group = BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_group);
;3998:		if (group >= 0 && group < MAX_GROUPS) {
;3999:			tss_serverdata_t* tss;
;4000:
;4001:			switch (bs->cur_ps.persistant[PERS_TEAM]) {
;4002:			case TEAM_RED:
;4003:				tss = &level.redTSS;
;4004:				break;
;4005:			case TEAM_BLUE:
;4006:				tss = &level.blueTSS;
;4007:				break;
;4008:			default:
;4009:				return;
;4010:			}
;4011:			tss->groupFormation[group] = newGF;
;4012:		}
;4013:	}
;4014:*/
;4015:	tss_groupFormation_t oldGF;
;4016:	tss_groupFormation_t newGF;
;4017:	int group;
;4018:	tss_serverdata_t* tss;
;4019:
;4020:	oldGF = BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_groupFormation);
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTI4 6
ARGI4
ADDRLP4 16
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 16
INDIRI4
ASGNI4
line 4021
;4021:	newGF = BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_suggestedGF);
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTI4 14
ARGI4
ADDRLP4 20
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 20
INDIRI4
ASGNI4
line 4022
;4022:	if (oldGF == newGF) return;
ADDRLP4 8
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $1112
ADDRGP4 $1111
JUMPV
LABELV $1112
line 4024
;4023:
;4024:	switch (newGF) {
ADDRLP4 24
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $1115
ADDRLP4 24
INDIRI4
CNSTI4 1
EQI4 $1115
ADDRLP4 24
INDIRI4
CNSTI4 2
EQI4 $1115
ADDRGP4 $1111
JUMPV
line 4028
;4025:	case TSSGF_tight:
;4026:	case TSSGF_loose:
;4027:	case TSSGF_free:
;4028:		break;
line 4030
;4029:	default:
;4030:		return;
LABELV $1115
line 4033
;4031:	}
;4032:
;4033:	group = BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_group);
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 32
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 32
INDIRI4
ASGNI4
line 4034
;4034:	if (group < 0 || group >= MAX_GROUPS) return;
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $1120
ADDRLP4 4
INDIRI4
CNSTI4 10
LTI4 $1118
LABELV $1120
ADDRGP4 $1111
JUMPV
LABELV $1118
line 4036
;4035:
;4036:	switch (bs->cur_ps.persistant[PERS_TEAM]) {
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 1
EQI4 $1124
ADDRLP4 40
INDIRI4
CNSTI4 2
EQI4 $1126
ADDRGP4 $1111
JUMPV
LABELV $1124
line 4038
;4037:	case TEAM_RED:
;4038:		tss = &level.redTSS;
ADDRLP4 12
ADDRGP4 level+9268
ASGNP4
line 4039
;4039:		break;
ADDRGP4 $1122
JUMPV
LABELV $1126
line 4041
;4040:	case TEAM_BLUE:
;4041:		tss = &level.blueTSS;
ADDRLP4 12
ADDRGP4 level+9984
ASGNP4
line 4042
;4042:		break;
line 4044
;4043:	default:
;4044:		return;
LABELV $1122
line 4047
;4045:	}
;4046:
;4047:	tss->groupFormation[group] = newGF;
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
CNSTI4 516
ADDP4
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 4048
;4048:}
LABELV $1111
endproc BotSetGroupFormation 48 8
bss
align 4
LABELV $1135
skip 4
align 4
LABELV $1136
skip 4
export BotTeamLeaderAI
code
proc BotTeamLeaderAI 144 8
line 4056
;4049:#endif
;4050:
;4051:/*
;4052:==================
;4053:JUHOX: BotTeamLeaderAI
;4054:==================
;4055:*/
;4056:void BotTeamLeaderAI(bot_state_t* bs) {
line 4058
;4057:#if BOTS_USE_TSS
;4058:	if (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_isValid)) {
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 0
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1129
line 4059
;4059:		BotSetGroupFormation(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetGroupFormation
CALLV
pop
line 4060
;4060:		return;
ADDRGP4 $1128
JUMPV
LABELV $1129
line 4064
;4061:	}
;4062:#endif
;4063:
;4064:	if (bs->teamleader_ltg_check_time > FloatTime()) return;
ADDRFP4 0
INDIRP4
CNSTI4 11540
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $1131
ADDRGP4 $1128
JUMPV
LABELV $1131
line 4065
;4065:	bs->teamleader_ltg_check_time = FloatTime() + 0.5 + random();
ADDRLP4 4
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRFP4 0
INDIRP4
CNSTI4 11540
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1056964608
ADDF4
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
CNSTF4 796917760
MULF4
ADDF4
ASGNF4
line 4067
;4066:
;4067:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $1133
line 4071
;4068:		static int redOrderState;
;4069:		static int blueOrderState;
;4070:
;4071:		if (Team_GetFlagStatus(TEAM_RED) == FLAG_ATBASE) redOrderState = 0;
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 Team_GetFlagStatus
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $1137
ADDRGP4 $1135
CNSTI4 0
ASGNI4
LABELV $1137
line 4072
;4072:		if (Team_GetFlagStatus(TEAM_BLUE) == FLAG_ATBASE) blueOrderState = 0;
CNSTI4 2
ARGI4
ADDRLP4 12
ADDRGP4 Team_GetFlagStatus
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $1139
ADDRGP4 $1136
CNSTI4 0
ASGNI4
LABELV $1139
line 4074
;4073:
;4074:		if (bs->ltgtype == LTG_GETFLAG && BotEnemyFlagStatus(bs) != FLAG_ATBASE) {
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 4
NEI4 $1141
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 BotEnemyFlagStatus
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $1141
line 4075
;4075:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
line 4076
;4076:		}
LABELV $1141
line 4078
;4077:
;4078:		if (bs->enemy < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 0
GEI4 $1143
line 4079
;4079:			if (!bs->ltgtype) {
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1134
line 4085
;4080:				int* orderState;
;4081:				bot_goal_t* homeBase;
;4082:				bot_goal_t* enemyBase;
;4083:				bot_goal_t goal;
;4084:
;4085:				if (BotEnemyFlagStatus(bs) == FLAG_ATBASE) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 92
ADDRGP4 BotEnemyFlagStatus
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 0
NEI4 $1147
line 4086
;4086:					bs->ltgtype = LTG_GETFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 4
ASGNI4
line 4087
;4087:					bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11696
ADDP4
CNSTF4 0
ASGNF4
line 4088
;4088:					bs->teamgoal_time = trap_AAS_Time() + CTF_GETFLAG_TIME;
ADDRLP4 96
ADDRGP4 trap_AAS_Time
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 11700
ADDP4
ADDRLP4 96
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 4089
;4089:					return;
ADDRGP4 $1128
JUMPV
LABELV $1147
line 4092
;4090:				}
;4091:
;4092:				switch (bs->cur_ps.persistant[PERS_TEAM]) {
ADDRLP4 96
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ASGNI4
ADDRLP4 96
INDIRI4
CNSTI4 1
EQI4 $1152
ADDRLP4 96
INDIRI4
CNSTI4 2
EQI4 $1153
ADDRGP4 $1128
JUMPV
LABELV $1152
line 4094
;4093:				case TEAM_RED:
;4094:					orderState = &redOrderState;
ADDRLP4 24
ADDRGP4 $1135
ASGNP4
line 4095
;4095:					homeBase = &ctf_redflag;
ADDRLP4 28
ADDRGP4 ctf_redflag
ASGNP4
line 4096
;4096:					enemyBase = &ctf_blueflag;
ADDRLP4 32
ADDRGP4 ctf_blueflag
ASGNP4
line 4097
;4097:					break;
ADDRGP4 $1150
JUMPV
LABELV $1153
line 4099
;4098:				case TEAM_BLUE:
;4099:					orderState = &blueOrderState;
ADDRLP4 24
ADDRGP4 $1136
ASGNP4
line 4100
;4100:					homeBase = &ctf_blueflag;
ADDRLP4 28
ADDRGP4 ctf_blueflag
ASGNP4
line 4101
;4101:					enemyBase = &ctf_redflag;
ADDRLP4 32
ADDRGP4 ctf_redflag
ASGNP4
line 4102
;4102:					break;
line 4104
;4103:				default:
;4104:					return;
LABELV $1150
line 4108
;4105:				}
;4106:
;4107:				// searching flags
;4108:				if (BotTeamReadyToGo(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 104
ADDRGP4 BotTeamReadyToGo
CALLI4
ASGNI4
ADDRLP4 104
INDIRI4
CNSTI4 0
EQI4 $1134
line 4109
;4109:					switch (*orderState) {
ADDRLP4 108
ADDRLP4 24
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 108
INDIRI4
CNSTI4 0
LTI4 $1156
ADDRLP4 108
INDIRI4
CNSTI4 3
GTI4 $1156
ADDRLP4 108
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1168
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1168
address $1159
address $1162
address $1165
address $1162
code
LABELV $1159
line 4112
;4110:					case 0:
;4111:						//if (trap_BotTouchingGoal(bs->origin, homeBase)) (*orderState)++;
;4112:						if (DistanceSquared(bs->origin, homeBase->origin) < 300.0*300.0) (*orderState)++;
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 116
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 116
INDIRF4
CNSTF4 1202702336
GEF4 $1160
ADDRLP4 120
ADDRLP4 24
INDIRP4
ASGNP4
ADDRLP4 120
INDIRP4
ADDRLP4 120
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $1134
JUMPV
LABELV $1160
line 4113
;4113:						else BotGoToGoal(bs, homeBase);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 BotGoToGoal
CALLV
pop
line 4114
;4114:						break;
ADDRGP4 $1134
JUMPV
LABELV $1162
LABELV $1156
line 4118
;4115:					case 1:
;4116:					case 3:
;4117:					default:
;4118:						if (BotChooseTeamleaderGoal(bs, &goal)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 124
ADDRGP4 BotChooseTeamleaderGoal
CALLI4
ASGNI4
ADDRLP4 124
INDIRI4
CNSTI4 0
EQI4 $1163
line 4119
;4119:							BotGoNearGoal(bs, &goal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 36
ARGP4
ADDRGP4 BotGoNearGoal
CALLV
pop
line 4120
;4120:						}
LABELV $1163
line 4121
;4121:						(*orderState)++;
ADDRLP4 128
ADDRLP4 24
INDIRP4
ASGNP4
ADDRLP4 128
INDIRP4
ADDRLP4 128
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4122
;4122:						(*orderState) &= 3;
ADDRLP4 132
ADDRLP4 24
INDIRP4
ASGNP4
ADDRLP4 132
INDIRP4
ADDRLP4 132
INDIRP4
INDIRI4
CNSTI4 3
BANDI4
ASGNI4
line 4123
;4123:						break;
ADDRGP4 $1134
JUMPV
LABELV $1165
line 4126
;4124:					case 2:
;4125:						//if (trap_BotTouchingGoal(bs->origin, enemyBase)) (*orderState)++;
;4126:						if (DistanceSquared(bs->origin, enemyBase->origin) < 300.0*300.0) (*orderState)++;
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 136
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 136
INDIRF4
CNSTF4 1202702336
GEF4 $1166
ADDRLP4 140
ADDRLP4 24
INDIRP4
ASGNP4
ADDRLP4 140
INDIRP4
ADDRLP4 140
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $1134
JUMPV
LABELV $1166
line 4127
;4127:						else BotGoToGoal(bs, enemyBase);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRGP4 BotGoToGoal
CALLV
pop
line 4128
;4128:						break;
line 4130
;4129:					}
;4130:				}
line 4131
;4131:			}
line 4132
;4132:		}
ADDRGP4 $1134
JUMPV
LABELV $1143
line 4134
;4133:		else if (	// bs->enemy >= 0
;4134:			bs->ltgtype == LTG_CAMP ||
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 7
EQI4 $1171
ADDRLP4 24
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 8
NEI4 $1134
LABELV $1171
line 4136
;4135:			bs->ltgtype == LTG_CAMPORDER
;4136:		) {
line 4137
;4137:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
line 4138
;4138:		}
line 4139
;4139:	}
ADDRGP4 $1134
JUMPV
LABELV $1133
line 4140
;4140:	else {	// gametype != GT_CTF
line 4141
;4141:		if (bs->enemy < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 0
GEI4 $1172
line 4143
;4142:			if (
;4143:				bs->ltgtype != LTG_CAMP &&
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 7
EQI4 $1174
ADDRLP4 8
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 BotPlayerDanger
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 25
GEI4 $1174
line 4146
;4144:				//bs->nbg_time < FloatTime() &&
;4145:				BotPlayerDanger(&bs->cur_ps) < 25
;4146:			) {
line 4147
;4147:				if (BotTeamReadyToGo(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 BotTeamReadyToGo
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $1173
line 4150
;4148:					bot_goal_t goal;
;4149:	
;4150:					if (BotChooseTeamleaderGoal(bs, &goal)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 76
ADDRGP4 BotChooseTeamleaderGoal
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
EQI4 $1178
line 4151
;4151:						bs->noTeamLeaderGoal_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11860
ADDP4
CNSTF4 0
ASGNF4
line 4152
;4152:						BotGoNearGoal(bs, &goal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 BotGoNearGoal
CALLV
pop
line 4153
;4153:					}
ADDRGP4 $1173
JUMPV
LABELV $1178
line 4154
;4154:					else if (bs->noTeamLeaderGoal_time <= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 11860
ADDP4
INDIRF4
CNSTF4 0
GTF4 $1180
line 4155
;4155:						bs->noTeamLeaderGoal_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 11860
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 4156
;4156:					}
ADDRGP4 $1173
JUMPV
LABELV $1180
line 4157
;4157:					else if (bs->noTeamLeaderGoal_time < FloatTime() - 4) {
ADDRFP4 0
INDIRP4
CNSTI4 11860
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1082130432
SUBF4
GEF4 $1173
line 4158
;4158:						bs->leader = -1;
ADDRFP4 0
INDIRP4
CNSTI4 11872
ADDP4
CNSTI4 -1
ASGNI4
line 4159
;4159:					}
line 4160
;4160:				}
line 4161
;4161:			}
ADDRGP4 $1173
JUMPV
LABELV $1174
line 4162
;4162:			else if (bs->ltgtype == LTG_CAMP && !BotTeamReadyToGo(bs)) {
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 7
NEI4 $1173
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 BotTeamReadyToGo
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $1173
line 4163
;4163:				bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
line 4164
;4164:			}
line 4165
;4165:		}
ADDRGP4 $1173
JUMPV
LABELV $1172
line 4166
;4166:		else {
line 4167
;4167:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
line 4168
;4168:		}
LABELV $1173
line 4169
;4169:	}
LABELV $1134
line 4170
;4170:}
LABELV $1128
endproc BotTeamLeaderAI 144 8
data
align 4
LABELV $1191
byte 4 0
byte 4 10
byte 4 0
byte 4 0
byte 4 1
byte 4 25
byte 4 0
byte 4 0
byte 4 0
byte 4 1
byte 4 10
byte 4 0
byte 4 0
byte 4 1
byte 4 25
byte 4 0
byte 4 0
byte 4 0
byte 4 2
byte 4 10
byte 4 0
byte 4 0
byte 4 1
byte 4 25
byte 4 0
byte 4 0
byte 4 0
byte 4 3
byte 4 10
byte 4 0
byte 4 0
byte 4 1
byte 4 25
byte 4 0
byte 4 0
byte 4 0
byte 4 4
byte 4 10
byte 4 0
byte 4 0
byte 4 1
byte 4 25
byte 4 0
byte 4 0
byte 4 0
byte 4 5
byte 4 10
byte 4 0
byte 4 0
byte 4 1
byte 4 25
byte 4 0
byte 4 0
byte 4 0
byte 4 6
byte 4 10
byte 4 0
byte 4 0
byte 4 1
byte 4 25
byte 4 0
byte 4 0
byte 4 0
byte 4 7
byte 4 10
byte 4 0
byte 4 0
byte 4 1
byte 4 25
byte 4 0
byte 4 0
byte 4 0
byte 4 8
byte 4 10
byte 4 0
byte 4 0
byte 4 1
byte 4 25
byte 4 0
byte 4 0
byte 4 0
byte 4 9
byte 4 10
byte 4 0
byte 4 0
byte 4 1
byte 4 25
byte 4 0
byte 4 0
byte 4 0
align 4
LABELV $1192
byte 4 0
byte 4 100
byte 4 0
byte 4 0
byte 4 2
byte 4 25
byte 4 0
byte 4 0
byte 4 1
byte 4 1
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 2
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 3
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 4
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 5
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 6
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 7
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 8
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 9
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
align 4
LABELV $1193
byte 4 0
byte 4 100
byte 4 0
byte 4 0
byte 4 1
byte 4 25
byte 4 50
byte 4 30
byte 4 1
byte 4 1
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 2
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 3
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 4
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 5
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 6
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 7
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 8
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 9
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
align 4
LABELV $1194
byte 4 0
byte 4 50
byte 4 0
byte 4 0
byte 4 1
byte 4 25
byte 4 50
byte 4 30
byte 4 1
byte 4 1
byte 4 50
byte 4 0
byte 4 0
byte 4 1
byte 4 25
byte 4 50
byte 4 30
byte 4 1
byte 4 2
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 3
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 4
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 5
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 6
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 7
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 8
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 9
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
align 4
LABELV $1195
byte 4 0
byte 4 34
byte 4 0
byte 4 0
byte 4 1
byte 4 25
byte 4 50
byte 4 30
byte 4 1
byte 4 1
byte 4 33
byte 4 0
byte 4 0
byte 4 1
byte 4 25
byte 4 50
byte 4 30
byte 4 1
byte 4 2
byte 4 33
byte 4 0
byte 4 0
byte 4 1
byte 4 25
byte 4 50
byte 4 30
byte 4 1
byte 4 3
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 4
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 5
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 6
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 7
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 8
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 9
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
align 4
LABELV $1196
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 1
byte 4 100
byte 4 0
byte 4 0
byte 4 3
byte 4 25
byte 4 50
byte 4 50
byte 4 0
byte 4 2
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 3
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 4
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 5
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 6
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 7
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 8
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 9
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
align 4
LABELV $1197
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 1
byte 4 100
byte 4 0
byte 4 0
byte 4 3
byte 4 75
byte 4 0
byte 4 0
byte 4 0
byte 4 2
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 3
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 4
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 5
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 6
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 7
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 8
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 9
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
align 4
LABELV $1198
byte 4 0
byte 4 66
byte 4 49
byte 4 75
byte 4 4
byte 4 50
byte 4 50
byte 4 50
byte 4 0
byte 4 1
byte 4 34
byte 4 49
byte 4 75
byte 4 3
byte 4 25
byte 4 50
byte 4 50
byte 4 0
byte 4 2
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 3
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 4
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 5
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 6
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 7
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 8
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 9
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
align 4
LABELV $1199
byte 4 0
byte 4 50
byte 4 49
byte 4 75
byte 4 4
byte 4 50
byte 4 50
byte 4 50
byte 4 0
byte 4 1
byte 4 50
byte 4 49
byte 4 75
byte 4 3
byte 4 25
byte 4 50
byte 4 50
byte 4 0
byte 4 2
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 3
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 4
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 5
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 6
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 7
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 8
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 9
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
align 4
LABELV $1200
byte 4 0
byte 4 34
byte 4 49
byte 4 75
byte 4 4
byte 4 70
byte 4 0
byte 4 0
byte 4 0
byte 4 1
byte 4 66
byte 4 49
byte 4 75
byte 4 3
byte 4 50
byte 4 0
byte 4 0
byte 4 0
byte 4 2
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 3
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 4
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 5
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 6
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 7
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 8
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 9
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
align 4
LABELV $1201
byte 4 0
byte 4 34
byte 4 49
byte 4 75
byte 4 4
byte 4 70
byte 4 0
byte 4 0
byte 4 0
byte 4 1
byte 4 33
byte 4 49
byte 4 75
byte 4 3
byte 4 50
byte 4 0
byte 4 0
byte 4 0
byte 4 2
byte 4 33
byte 4 49
byte 4 0
byte 4 6
byte 4 50
byte 4 0
byte 4 0
byte 4 0
byte 4 3
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 4
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 5
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 6
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 7
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 8
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 9
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
align 4
LABELV $1202
byte 4 0
byte 4 33
byte 4 49
byte 4 75
byte 4 4
byte 4 50
byte 4 49
byte 4 49
byte 4 0
byte 4 1
byte 4 34
byte 4 49
byte 4 75
byte 4 3
byte 4 25
byte 4 49
byte 4 49
byte 4 0
byte 4 2
byte 4 33
byte 4 0
byte 4 0
byte 4 6
byte 4 25
byte 4 49
byte 4 49
byte 4 0
byte 4 3
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 4
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 5
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 6
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 7
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 8
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 9
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
align 4
LABELV $1203
byte 4 0
byte 4 50
byte 4 49
byte 4 75
byte 4 4
byte 4 50
byte 4 0
byte 4 0
byte 4 0
byte 4 1
byte 4 50
byte 4 49
byte 4 75
byte 4 3
byte 4 25
byte 4 0
byte 4 0
byte 4 0
byte 4 2
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 3
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 4
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 5
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 6
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 7
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 8
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 9
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
align 4
LABELV $1204
byte 4 0
byte 4 25
byte 4 49
byte 4 75
byte 4 4
byte 4 50
byte 4 49
byte 4 49
byte 4 0
byte 4 1
byte 4 25
byte 4 49
byte 4 75
byte 4 3
byte 4 25
byte 4 49
byte 4 49
byte 4 0
byte 4 2
byte 4 25
byte 4 0
byte 4 0
byte 4 6
byte 4 25
byte 4 49
byte 4 49
byte 4 0
byte 4 3
byte 4 25
byte 4 0
byte 4 0
byte 4 5
byte 4 50
byte 4 49
byte 4 49
byte 4 0
byte 4 4
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 5
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 6
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 7
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 8
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 9
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
bss
align 4
LABELV $1205
skip 128
export BotMissionLeaderAI
code
proc BotMissionLeaderAI 140 12
line 4218
;4171:
;4172:/*
;4173:==================
;4174:JUHOX: BotMissionLeaderAI
;4175:==================
;4176:*/
;4177:typedef enum {
;4178:	BS_TDM_crowd,
;4179:	BS_TDM_maxforce,
;4180:	BS_TDM_pliers2,
;4181:	BS_TDM_pliers3,
;4182:
;4183:	BS_TDM_num_strategies
;4184:} bot_tdm_strategy;
;4185:typedef enum {
;4186:	BS_CTF_maxforce,
;4187:	BS_CTF_simple,
;4188:	BS_CTF_pliers,
;4189:	BS_CTF_powerpliers,
;4190:	BS_CTF_defensive,
;4191:
;4192:	BS_CTF_num_strategies
;4193:} bot_ctf_strategy;
;4194:#define BOT_MAX_STRATEGIES 8
;4195:typedef struct {
;4196:	int strategy;
;4197:	int lastEnemyScore;
;4198:	int lastOwnScore;
;4199:	int lastEnemyTakenCount;
;4200:	int lastOwnTakenCount;
;4201:	int lastEnemyPossessionTime;
;4202:	int lastOwnPossessionTime;
;4203:	qboolean initialized;
;4204:	int strategySuccess[BOT_MAX_STRATEGIES];
;4205:} bot_missionleaderdata_t;
;4206:typedef struct {
;4207:	int rank;
;4208:	int minTotal;
;4209:	int minAlive;
;4210:	int minReady;
;4211:	tss_mission_t mission;
;4212:	int maxDanger;
;4213:	int missionMinReady;
;4214:	int minGroupSize;
;4215:	int maxGuards;
;4216:} bot_tss_groupinstructions_t;
;4217:typedef bot_tss_groupinstructions_t bot_tss_instructions_t[MAX_GROUPS];
;4218:void BotMissionLeaderAI(bot_state_t *bs) {
line 4411
;4219:	// NOTE: the compiler seems to have a problem initializing a tss_instructions_t variable,
;4220:	//       so we use bot_tss_instructions_t instead.
;4221:
;4222:	// team deathmatch
;4223:	static const bot_tss_instructions_t tdm_crowd_disperse = {
;4224:		{0, 10, 0, 0, TSSMISSION_seek_enemy, 25, 0, 0, 0},
;4225:		{1, 10, 0, 0, TSSMISSION_seek_enemy, 25, 0, 0, 0},
;4226:		{2, 10, 0, 0, TSSMISSION_seek_enemy, 25, 0, 0, 0},
;4227:		{3, 10, 0, 0, TSSMISSION_seek_enemy, 25, 0, 0, 0},
;4228:		{4, 10, 0, 0, TSSMISSION_seek_enemy, 25, 0, 0, 0},
;4229:		{5, 10, 0, 0, TSSMISSION_seek_enemy, 25, 0, 0, 0},
;4230:		{6, 10, 0, 0, TSSMISSION_seek_enemy, 25, 0, 0, 0},
;4231:		{7, 10, 0, 0, TSSMISSION_seek_enemy, 25, 0, 0, 0},
;4232:		{8, 10, 0, 0, TSSMISSION_seek_enemy, 25, 0, 0, 0},
;4233:		{9, 10, 0, 0, TSSMISSION_seek_enemy, 25, 0, 0, 0}
;4234:	};
;4235:	static const bot_tss_instructions_t tdm_crowd_hide = {
;4236:		{0, 100, 0, 0, TSSMISSION_seek_items, 25, 0, 0, 1},
;4237:		{1, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4238:		{2, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4239:		{3, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4240:		{4, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4241:		{5, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4242:		{6, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4243:		{7, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4244:		{8, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4245:		{9, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0}
;4246:	};
;4247:	static const bot_tss_instructions_t tdm_maxforce_default = {
;4248:		{0, 100, 0, 0, TSSMISSION_seek_enemy, 25, 50, 30, 1},
;4249:		{1, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4250:		{2, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4251:		{3, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4252:		{4, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4253:		{5, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4254:		{6, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4255:		{7, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4256:		{8, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4257:		{9, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0}
;4258:	};
;4259:	static const bot_tss_instructions_t tdm_pliers2_default = {
;4260:		{0, 50, 0, 0, TSSMISSION_seek_enemy, 25, 50, 30, 1},
;4261:		{1, 50, 0, 0, TSSMISSION_seek_enemy, 25, 50, 30, 1},
;4262:		{2, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4263:		{3, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4264:		{4, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4265:		{5, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4266:		{6, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4267:		{7, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4268:		{8, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4269:		{9, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0}
;4270:	};
;4271:	static const bot_tss_instructions_t tdm_pliers3_default = {
;4272:		{0, 34, 0, 0, TSSMISSION_seek_enemy, 25, 50, 30, 1},
;4273:		{1, 33, 0, 0, TSSMISSION_seek_enemy, 25, 50, 30, 1},
;4274:		{2, 33, 0, 0, TSSMISSION_seek_enemy, 25, 50, 30, 1},
;4275:		{3, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4276:		{4, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4277:		{5, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4278:		{6, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4279:		{7, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4280:		{8, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4281:		{9, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0}
;4282:	};
;4283:
;4284:	// capture the flag
;4285:	static const bot_tss_instructions_t ctf_maxforce_getEnemyFlag = {
;4286:		{0, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4287:		{1, 100, 0, 0, TSSMISSION_capture_enemy_flag, 25, 50, 50, 0},
;4288:		{2, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4289:		{3, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4290:		{4, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4291:		{5, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4292:		{6, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4293:		{7, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4294:		{8, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4295:		{9, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0}
;4296:	};
;4297:	static const bot_tss_instructions_t ctf_maxforce_emergency = {
;4298:		{0, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4299:		{1, 100, 0, 0, TSSMISSION_capture_enemy_flag, 75, 0, 0, 0},
;4300:		{2, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4301:		{3, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4302:		{4, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4303:		{5, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4304:		{6, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4305:		{7, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4306:		{8, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4307:		{9, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0}
;4308:	};
;4309:	static const bot_tss_instructions_t ctf_maxforce_returnOurFlag = {
;4310:		{0, 66, 49, 75, TSSMISSION_defend_our_flag, 50, 50, 50, 0},
;4311:		{1, 34, 49, 75, TSSMISSION_capture_enemy_flag, 25, 50, 50, 0},
;4312:		{2, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4313:		{3, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4314:		{4, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4315:		{5, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4316:		{6, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4317:		{7, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4318:		{8, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4319:		{9, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0}
;4320:	};
;4321:	static const bot_tss_instructions_t ctf_simple_normal = {
;4322:		{0, 50, 49, 75, TSSMISSION_defend_our_flag, 50, 50, 50, 0},
;4323:		{1, 50, 49, 75, TSSMISSION_capture_enemy_flag, 25, 50, 50, 0},
;4324:		{2, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4325:		{3, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4326:		{4, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4327:		{5, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4328:		{6, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4329:		{7, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4330:		{8, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4331:		{9, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0}
;4332:	};
;4333:	static const bot_tss_instructions_t ctf_simple_emergency = {
;4334:		{0, 34, 49, 75, TSSMISSION_defend_our_flag, 70, 0, 0, 0},
;4335:		{1, 66, 49, 75, TSSMISSION_capture_enemy_flag, 50, 0, 0, 0},
;4336:		{2, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4337:		{3, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4338:		{4, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4339:		{5, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4340:		{6, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4341:		{7, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4342:		{8, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4343:		{9, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0}
;4344:	};
;4345:	static const bot_tss_instructions_t ctf_powerpliers_emergency = {
;4346:		{0, 34, 49, 75, TSSMISSION_defend_our_flag, 70, 0, 0, 0},
;4347:		{1, 33, 49, 75, TSSMISSION_capture_enemy_flag, 50, 0, 0, 0},
;4348:		{2, 33, 49, 0, TSSMISSION_occupy_enemy_base, 50, 0, 0, 0},
;4349:		{3, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4350:		{4, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4351:		{5, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4352:		{6, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4353:		{7, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4354:		{8, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4355:		{9, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0}
;4356:	};
;4357:	static const bot_tss_instructions_t ctf_powerpliers_normal = {
;4358:		{0, 33, 49, 75, TSSMISSION_defend_our_flag, 50, 49, 49, 0},
;4359:		{1, 34, 49, 75, TSSMISSION_capture_enemy_flag, 25, 49, 49, 0},
;4360:		{2, 33, 0, 0, TSSMISSION_occupy_enemy_base, 25, 49, 49, 0},
;4361:		{3, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4362:		{4, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4363:		{5, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4364:		{6, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4365:		{7, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4366:		{8, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4367:		{9, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0}
;4368:	};
;4369:	static const bot_tss_instructions_t ctf_powerpliers_power = {
;4370:		{0, 50, 49, 75, TSSMISSION_defend_our_flag, 50, 0, 0, 0},
;4371:		{1, 50, 49, 75, TSSMISSION_capture_enemy_flag, 25, 0, 0, 0},
;4372:		{2, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4373:		{3, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4374:		{4, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4375:		{5, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4376:		{6, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4377:		{7, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4378:		{8, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4379:		{9, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0}
;4380:	};
;4381:	static const bot_tss_instructions_t ctf_defensive_normal = {
;4382:		{0, 25, 49, 75, TSSMISSION_defend_our_flag, 50, 49, 49, 0},
;4383:		{1, 25, 49, 75, TSSMISSION_capture_enemy_flag, 25, 49, 49, 0},
;4384:		{2, 25, 0, 0, TSSMISSION_occupy_enemy_base, 25, 49, 49, 0},
;4385:		{3, 25, 0, 0, TSSMISSION_defend_our_base, 50, 49, 49, 0},
;4386:		{4, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4387:		{5, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4388:		{6, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4389:		{7, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4390:		{8, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0},
;4391:		{9, 0, 0, 0, TSSMISSION_invalid, 0, 0, 0, 0}
;4392:	};
;4393:
;4394:	static bot_missionleaderdata_t missionleaderdata[2];
;4395:	bot_missionleaderdata_t* mld;
;4396:	int enemyScore;
;4397:	int ownScore;
;4398:	int enemyTakenCount;
;4399:	int ownTakenCount;
;4400:	int enemyPossessionTime;
;4401:	int ownPossessionTime;
;4402:	int success;
;4403:	tss_serverdata_t* tss;
;4404:	int gr;
;4405:	int numStrategies;
;4406:	const bot_tss_instructions_t* instr;
;4407:
;4408:
;4409:
;4410:
;4411:	if (!g_tss.integer) return;
ADDRGP4 g_tss+12
INDIRI4
CNSTI4 0
NEI4 $1206
ADDRGP4 $1190
JUMPV
LABELV $1206
line 4413
;4412:
;4413:	switch (bs->cur_ps.persistant[PERS_TEAM]) {
ADDRLP4 48
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 1
EQI4 $1212
ADDRLP4 48
INDIRI4
CNSTI4 2
EQI4 $1222
ADDRGP4 $1190
JUMPV
LABELV $1212
line 4415
;4414:	case TEAM_RED:
;4415:		mld = &missionleaderdata[0];
ADDRLP4 16
ADDRGP4 $1205
ASGNP4
line 4416
;4416:		tss = &level.redTSS;
ADDRLP4 4
ADDRGP4 level+9268
ASGNP4
line 4417
;4417:		enemyScore = level.teamScores[TEAM_BLUE];
ADDRLP4 24
ADDRGP4 level+44+8
INDIRI4
ASGNI4
line 4418
;4418:		ownScore = level.teamScores[TEAM_RED];
ADDRLP4 28
ADDRGP4 level+44+4
INDIRI4
ASGNI4
line 4419
;4419:		enemyTakenCount = level.ctfRedTakenCount;
ADDRLP4 32
ADDRGP4 level+64
INDIRI4
ASGNI4
line 4420
;4420:		ownTakenCount = level.ctfBlueTakenCount;
ADDRLP4 36
ADDRGP4 level+68
INDIRI4
ASGNI4
line 4421
;4421:		enemyPossessionTime = level.ctfRedPossessionTime;
ADDRLP4 40
ADDRGP4 level+72
INDIRI4
ASGNI4
line 4422
;4422:		ownPossessionTime = level.ctfBluePossessionTime;
ADDRLP4 44
ADDRGP4 level+76
INDIRI4
ASGNI4
line 4423
;4423:		break;
ADDRGP4 $1210
JUMPV
LABELV $1222
line 4425
;4424:	case TEAM_BLUE:
;4425:		mld = &missionleaderdata[1];
ADDRLP4 16
ADDRGP4 $1205+64
ASGNP4
line 4426
;4426:		tss = &level.blueTSS;
ADDRLP4 4
ADDRGP4 level+9984
ASGNP4
line 4427
;4427:		enemyScore = level.teamScores[TEAM_RED];
ADDRLP4 24
ADDRGP4 level+44+4
INDIRI4
ASGNI4
line 4428
;4428:		ownScore = level.teamScores[TEAM_BLUE];
ADDRLP4 28
ADDRGP4 level+44+8
INDIRI4
ASGNI4
line 4429
;4429:		enemyTakenCount = level.ctfBlueTakenCount;
ADDRLP4 32
ADDRGP4 level+68
INDIRI4
ASGNI4
line 4430
;4430:		ownTakenCount = level.ctfRedTakenCount;
ADDRLP4 36
ADDRGP4 level+64
INDIRI4
ASGNI4
line 4431
;4431:		enemyPossessionTime = level.ctfBluePossessionTime;
ADDRLP4 40
ADDRGP4 level+76
INDIRI4
ASGNI4
line 4432
;4432:		ownPossessionTime = level.ctfRedPossessionTime;
ADDRLP4 44
ADDRGP4 level+72
INDIRI4
ASGNI4
line 4433
;4433:		break;
line 4435
;4434:	default:
;4435:		return;
LABELV $1210
line 4438
;4436:	}
;4437:
;4438:	if (tss->lastUpdateTime > level.time - 2000) return;
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 2000
SUBI4
LEI4 $1233
ADDRGP4 $1190
JUMPV
LABELV $1233
line 4439
;4439:	tss->lastUpdateTime = level.time;
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 4441
;4440:
;4441:	switch (g_gametype.integer) {
ADDRLP4 56
ADDRGP4 g_gametype+12
INDIRI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 3
EQI4 $1241
ADDRLP4 56
INDIRI4
CNSTI4 4
EQI4 $1240
ADDRGP4 $1190
JUMPV
LABELV $1240
line 4443
;4442:	case GT_CTF:
;4443:		numStrategies = BS_CTF_num_strategies;
ADDRLP4 20
CNSTI4 5
ASGNI4
line 4444
;4444:		break;
ADDRGP4 $1238
JUMPV
LABELV $1241
line 4446
;4445:	case GT_TEAM:
;4446:		numStrategies = BS_TDM_num_strategies;
ADDRLP4 20
CNSTI4 4
ASGNI4
line 4447
;4447:		break;
line 4449
;4448:	default:
;4449:		return;
LABELV $1238
line 4451
;4450:	}
;4451:	if (mld->strategy < 0 || mld->strategy >= numStrategies) {
ADDRLP4 60
ADDRLP4 16
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
LTI4 $1244
ADDRLP4 60
INDIRI4
ADDRLP4 20
INDIRI4
LTI4 $1242
LABELV $1244
line 4452
;4452:		G_Error("invalid strategy #%d\n", mld->strategy);
ADDRGP4 $1245
ARGP4
ADDRLP4 16
INDIRP4
INDIRI4
ARGI4
ADDRGP4 G_Error
CALLV
pop
line 4453
;4453:	}
LABELV $1242
line 4455
;4454:
;4455:	if (!mld->initialized) {
ADDRLP4 16
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1246
line 4456
;4456:		mld->strategy = rand() % numStrategies;
ADDRLP4 64
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 16
INDIRP4
ADDRLP4 64
INDIRI4
ADDRLP4 20
INDIRI4
MODI4
ASGNI4
line 4457
;4457:		mld->initialized = qtrue;
ADDRLP4 16
INDIRP4
CNSTI4 28
ADDP4
CNSTI4 1
ASGNI4
line 4458
;4458:	}
LABELV $1246
line 4460
;4459:
;4460:	success = mld->strategySuccess[mld->strategy];
ADDRLP4 12
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
INDIRP4
CNSTI4 32
ADDP4
ADDP4
INDIRI4
ASGNI4
line 4462
;4461:
;4462:	success += (ownScore - mld->lastOwnScore) * 1000;
ADDRLP4 12
ADDRLP4 12
INDIRI4
ADDRLP4 28
INDIRI4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
SUBI4
CNSTI4 1000
MULI4
ADDI4
ASGNI4
line 4463
;4463:	success -= (enemyScore - mld->lastEnemyScore) * 1000;
ADDRLP4 12
ADDRLP4 12
INDIRI4
ADDRLP4 24
INDIRI4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
SUBI4
CNSTI4 1000
MULI4
SUBI4
ASGNI4
line 4464
;4464:	mld->lastOwnScore = ownScore;
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 4465
;4465:	mld->lastEnemyScore = enemyScore;
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 24
INDIRI4
ASGNI4
line 4467
;4466:
;4467:	if (g_gametype.integer == GT_CTF) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $1248
line 4468
;4468:		success += (ownTakenCount - mld->lastOwnTakenCount) * 100;
ADDRLP4 12
ADDRLP4 12
INDIRI4
ADDRLP4 36
INDIRI4
ADDRLP4 16
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
SUBI4
CNSTI4 100
MULI4
ADDI4
ASGNI4
line 4469
;4469:		success -= (enemyTakenCount - mld->lastEnemyTakenCount) * 100;
ADDRLP4 12
ADDRLP4 12
INDIRI4
ADDRLP4 32
INDIRI4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
SUBI4
CNSTI4 100
MULI4
SUBI4
ASGNI4
line 4470
;4470:		mld->lastOwnTakenCount = ownTakenCount;
ADDRLP4 16
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 36
INDIRI4
ASGNI4
line 4471
;4471:		mld->lastEnemyTakenCount = enemyTakenCount;
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 32
INDIRI4
ASGNI4
line 4473
;4472:
;4473:		success += (ownPossessionTime - mld->lastOwnPossessionTime) / 100;
ADDRLP4 12
ADDRLP4 12
INDIRI4
ADDRLP4 44
INDIRI4
ADDRLP4 16
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
SUBI4
CNSTI4 100
DIVI4
ADDI4
ASGNI4
line 4474
;4474:		success -= (enemyPossessionTime - mld->lastEnemyPossessionTime) / 100;
ADDRLP4 12
ADDRLP4 12
INDIRI4
ADDRLP4 40
INDIRI4
ADDRLP4 16
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
SUBI4
CNSTI4 100
DIVI4
SUBI4
ASGNI4
line 4475
;4475:		mld->lastOwnPossessionTime = ownPossessionTime;
ADDRLP4 16
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 44
INDIRI4
ASGNI4
line 4476
;4476:		mld->lastEnemyPossessionTime = enemyPossessionTime;
ADDRLP4 16
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 40
INDIRI4
ASGNI4
line 4477
;4477:	}
LABELV $1248
line 4479
;4478:
;4479:	switch (g_gametype.integer) {
ADDRLP4 68
ADDRGP4 g_gametype+12
INDIRI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 3
EQI4 $1255
ADDRLP4 68
INDIRI4
CNSTI4 4
EQI4 $1254
ADDRGP4 $1251
JUMPV
LABELV $1254
line 4481
;4480:	case GT_CTF:
;4481:		success -= rand() % 40;
ADDRLP4 72
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 12
INDIRI4
ADDRLP4 72
INDIRI4
CNSTI4 40
MODI4
SUBI4
ASGNI4
line 4482
;4482:		break;
ADDRGP4 $1252
JUMPV
LABELV $1255
LABELV $1251
line 4485
;4483:	case GT_TEAM:
;4484:	default:
;4485:		success -= rand() % 100;
ADDRLP4 76
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 12
INDIRI4
ADDRLP4 76
INDIRI4
CNSTI4 100
MODI4
SUBI4
ASGNI4
line 4486
;4486:		break;
LABELV $1252
line 4489
;4487:	}
;4488:
;4489:	mld->strategySuccess[mld->strategy] = success;
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
INDIRP4
CNSTI4 32
ADDP4
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 4491
;4490:
;4491:	{
line 4496
;4492:		int i;
;4493:		int bestSuccess;
;4494:		int bestStrategy;
;4495:
;4496:		bestSuccess = -1000000000;
ADDRLP4 80
CNSTI4 -1000000000
ASGNI4
line 4497
;4497:		bestStrategy = 0;
ADDRLP4 84
CNSTI4 0
ASGNI4
line 4498
;4498:		for (i = 0; i < numStrategies; i++) {
ADDRLP4 76
CNSTI4 0
ASGNI4
ADDRGP4 $1259
JUMPV
LABELV $1256
line 4499
;4499:			success = mld->strategySuccess[i];
ADDRLP4 12
ADDRLP4 76
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
INDIRP4
CNSTI4 32
ADDP4
ADDP4
INDIRI4
ASGNI4
line 4500
;4500:			if (i == mld->strategy) success += 1000;
ADDRLP4 76
INDIRI4
ADDRLP4 16
INDIRP4
INDIRI4
NEI4 $1260
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
LABELV $1260
line 4501
;4501:			if (success <= bestSuccess) continue;
ADDRLP4 12
INDIRI4
ADDRLP4 80
INDIRI4
GTI4 $1262
ADDRGP4 $1257
JUMPV
LABELV $1262
line 4503
;4502:
;4503:			bestSuccess = success;
ADDRLP4 80
ADDRLP4 12
INDIRI4
ASGNI4
line 4504
;4504:			bestStrategy = i;
ADDRLP4 84
ADDRLP4 76
INDIRI4
ASGNI4
line 4505
;4505:		}
LABELV $1257
line 4498
ADDRLP4 76
ADDRLP4 76
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1259
ADDRLP4 76
INDIRI4
ADDRLP4 20
INDIRI4
LTI4 $1256
line 4507
;4506:
;4507:		mld->strategy = bestStrategy;
ADDRLP4 16
INDIRP4
ADDRLP4 84
INDIRI4
ASGNI4
line 4508
;4508:	}
line 4510
;4509:
;4510:	instr = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 4511
;4511:	if (g_gametype.integer == GT_CTF) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $1264
line 4512
;4512:		switch (mld->strategy) {
ADDRLP4 76
ADDRLP4 16
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
LTI4 $1267
ADDRLP4 76
INDIRI4
CNSTI4 4
GTI4 $1267
ADDRLP4 76
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1293
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1293
address $1270
address $1277
address $1281
address $1285
address $1290
code
LABELV $1270
line 4515
;4513:		case BS_CTF_maxforce:
;4514:			if (
;4515:				BotOwnFlagStatus(bs) != FLAG_ATBASE &&
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 84
ADDRGP4 BotOwnFlagStatus
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
EQI4 $1271
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 88
ADDRGP4 BotEnemyFlagStatus
CALLI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 1
EQI4 $1271
line 4517
;4516:				BotEnemyFlagStatus(bs) != FLAG_TAKEN
;4517:			) {
line 4518
;4518:				instr = &ctf_maxforce_emergency;
ADDRLP4 8
ADDRGP4 $1197
ASGNP4
line 4519
;4519:			}
ADDRGP4 $1265
JUMPV
LABELV $1271
line 4521
;4520:			else if (
;4521:				BotEnemyFlagStatus(bs) != FLAG_TAKEN ||
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 92
ADDRGP4 BotEnemyFlagStatus
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 1
NEI4 $1276
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 96
ADDRGP4 BotOwnFlagStatus
CALLI4
ASGNI4
ADDRLP4 96
INDIRI4
CNSTI4 0
EQI4 $1276
ADDRLP4 4
INDIRP4
CNSTI4 660
ADDP4
INDIRI4
CNSTI4 0
GEI4 $1273
LABELV $1276
line 4524
;4522:				BotOwnFlagStatus(bs) == FLAG_ATBASE ||
;4523:				tss->ofp < 0
;4524:			) {
line 4525
;4525:				instr = &ctf_maxforce_getEnemyFlag;
ADDRLP4 8
ADDRGP4 $1196
ASGNP4
line 4526
;4526:			}
ADDRGP4 $1265
JUMPV
LABELV $1273
line 4527
;4527:			else {
line 4528
;4528:				instr = &ctf_maxforce_returnOurFlag;
ADDRLP4 8
ADDRGP4 $1198
ASGNP4
line 4529
;4529:			}
line 4530
;4530:			break;
ADDRGP4 $1265
JUMPV
LABELV $1277
line 4533
;4531:		case BS_CTF_simple:
;4532:			if (
;4533:				BotOwnFlagStatus(bs) == FLAG_ATBASE ||
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 100
ADDRGP4 BotOwnFlagStatus
CALLI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 0
EQI4 $1280
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 104
ADDRGP4 BotEnemyFlagStatus
CALLI4
ASGNI4
ADDRLP4 104
INDIRI4
CNSTI4 1
NEI4 $1278
LABELV $1280
line 4535
;4534:				BotEnemyFlagStatus(bs) == FLAG_TAKEN
;4535:			) {
line 4536
;4536:				instr = &ctf_simple_normal;
ADDRLP4 8
ADDRGP4 $1199
ASGNP4
line 4537
;4537:			}
ADDRGP4 $1265
JUMPV
LABELV $1278
line 4538
;4538:			else {
line 4539
;4539:				instr = &ctf_simple_emergency;
ADDRLP4 8
ADDRGP4 $1200
ASGNP4
line 4540
;4540:			}
line 4541
;4541:			break;
ADDRGP4 $1265
JUMPV
LABELV $1281
line 4544
;4542:		case BS_CTF_pliers:
;4543:			if (
;4544:				BotOwnFlagStatus(bs) == FLAG_ATBASE ||
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 108
ADDRGP4 BotOwnFlagStatus
CALLI4
ASGNI4
ADDRLP4 108
INDIRI4
CNSTI4 0
EQI4 $1284
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 112
ADDRGP4 BotEnemyFlagStatus
CALLI4
ASGNI4
ADDRLP4 112
INDIRI4
CNSTI4 1
NEI4 $1282
LABELV $1284
line 4546
;4545:				BotEnemyFlagStatus(bs) == FLAG_TAKEN
;4546:			) {
line 4547
;4547:				instr = &ctf_powerpliers_normal;
ADDRLP4 8
ADDRGP4 $1202
ASGNP4
line 4548
;4548:			}
ADDRGP4 $1265
JUMPV
LABELV $1282
line 4549
;4549:			else {
line 4550
;4550:				instr = &ctf_powerpliers_emergency;
ADDRLP4 8
ADDRGP4 $1201
ASGNP4
line 4551
;4551:			}
line 4552
;4552:			break;
ADDRGP4 $1265
JUMPV
LABELV $1285
line 4555
;4553:		case BS_CTF_powerpliers:
;4554:			if (
;4555:				BotOwnFlagStatus(bs) != FLAG_ATBASE &&
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 116
ADDRGP4 BotOwnFlagStatus
CALLI4
ASGNI4
ADDRLP4 116
INDIRI4
CNSTI4 0
EQI4 $1286
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 120
ADDRGP4 BotEnemyFlagStatus
CALLI4
ASGNI4
ADDRLP4 120
INDIRI4
CNSTI4 1
EQI4 $1286
line 4557
;4556:				BotEnemyFlagStatus(bs) != FLAG_TAKEN
;4557:			) {
line 4558
;4558:				instr = &ctf_powerpliers_emergency;
ADDRLP4 8
ADDRGP4 $1201
ASGNP4
line 4559
;4559:			}
ADDRGP4 $1265
JUMPV
LABELV $1286
line 4561
;4560:			else if (
;4561:				BotEnemyFlagStatus(bs) == FLAG_TAKEN &&
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 124
ADDRGP4 BotEnemyFlagStatus
CALLI4
ASGNI4
ADDRLP4 124
INDIRI4
CNSTI4 1
NEI4 $1288
ADDRLP4 4
INDIRP4
CNSTI4 660
ADDP4
INDIRI4
CNSTI4 10
LTI4 $1288
ADDRLP4 4
INDIRP4
CNSTI4 656
ADDP4
INDIRI4
CNSTI4 10
LTI4 $1288
line 4564
;4562:				tss->ofp >= 10 &&
;4563:				tss->yfp >= 10
;4564:			) {
line 4565
;4565:				instr = &ctf_powerpliers_power;
ADDRLP4 8
ADDRGP4 $1203
ASGNP4
line 4566
;4566:			}
ADDRGP4 $1265
JUMPV
LABELV $1288
line 4567
;4567:			else {
line 4568
;4568:				instr = &ctf_powerpliers_normal;
ADDRLP4 8
ADDRGP4 $1202
ASGNP4
line 4569
;4569:			}
line 4570
;4570:			break;
ADDRGP4 $1265
JUMPV
LABELV $1290
line 4573
;4571:		case BS_CTF_defensive:
;4572:			if (
;4573:				BotOwnFlagStatus(bs) != FLAG_ATBASE &&
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 132
ADDRGP4 BotOwnFlagStatus
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 0
EQI4 $1291
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 136
ADDRGP4 BotEnemyFlagStatus
CALLI4
ASGNI4
ADDRLP4 136
INDIRI4
CNSTI4 1
EQI4 $1291
line 4575
;4574:				BotEnemyFlagStatus(bs) != FLAG_TAKEN
;4575:			) {
line 4576
;4576:				instr = &ctf_powerpliers_emergency;
ADDRLP4 8
ADDRGP4 $1201
ASGNP4
line 4577
;4577:			}
ADDRGP4 $1265
JUMPV
LABELV $1291
line 4578
;4578:			else {
line 4579
;4579:				instr = &ctf_defensive_normal;
ADDRLP4 8
ADDRGP4 $1204
ASGNP4
line 4580
;4580:			}
line 4581
;4581:			break;
ADDRGP4 $1265
JUMPV
LABELV $1267
line 4583
;4582:		default:
;4583:			mld->strategy = 0;
ADDRLP4 16
INDIRP4
CNSTI4 0
ASGNI4
line 4584
;4584:			break;
line 4586
;4585:		}
;4586:	}
ADDRGP4 $1265
JUMPV
LABELV $1264
line 4587
;4587:	else {	// GT_TDM
line 4588
;4588:		switch (mld->strategy) {
ADDRLP4 76
ADDRLP4 16
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
LTI4 $1294
ADDRLP4 76
INDIRI4
CNSTI4 3
GTI4 $1294
ADDRLP4 76
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1305
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1305
address $1297
address $1302
address $1303
address $1304
code
LABELV $1297
line 4590
;4589:		case BS_TDM_crowd:
;4590:			if (BG_TSS_Proportion(tss->yaq, tss->yts, 100) > BG_TSS_Proportion(tss->oaq, tss->ots, 100) - 20) {
ADDRLP4 4
INDIRP4
CNSTI4 700
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 708
ADDP4
INDIRI4
ARGI4
CNSTI4 100
ARGI4
ADDRLP4 88
ADDRGP4 BG_TSS_Proportion
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 704
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 712
ADDP4
INDIRI4
ARGI4
CNSTI4 100
ARGI4
ADDRLP4 96
ADDRGP4 BG_TSS_Proportion
CALLI4
ASGNI4
ADDRLP4 88
INDIRI4
ADDRLP4 96
INDIRI4
CNSTI4 20
SUBI4
LEI4 $1298
line 4591
;4591:				instr = &tdm_crowd_disperse;
ADDRLP4 8
ADDRGP4 $1191
ASGNP4
line 4592
;4592:			}
ADDRGP4 $1295
JUMPV
LABELV $1298
line 4593
;4593:			else if (BG_TSS_Proportion(tss->rfa, tss->yaq, 100) > 75) {
ADDRLP4 4
INDIRP4
CNSTI4 676
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 700
ADDP4
INDIRI4
ARGI4
CNSTI4 100
ARGI4
ADDRLP4 104
ADDRGP4 BG_TSS_Proportion
CALLI4
ASGNI4
ADDRLP4 104
INDIRI4
CNSTI4 75
LEI4 $1300
line 4594
;4594:				instr = &tdm_maxforce_default;
ADDRLP4 8
ADDRGP4 $1193
ASGNP4
line 4595
;4595:			}
ADDRGP4 $1295
JUMPV
LABELV $1300
line 4596
;4596:			else {
line 4597
;4597:				instr = &tdm_crowd_hide;
ADDRLP4 8
ADDRGP4 $1192
ASGNP4
line 4598
;4598:			}
line 4599
;4599:			break;
ADDRGP4 $1295
JUMPV
LABELV $1302
line 4601
;4600:		case BS_TDM_maxforce:
;4601:			instr = &tdm_maxforce_default;
ADDRLP4 8
ADDRGP4 $1193
ASGNP4
line 4602
;4602:			break;
ADDRGP4 $1295
JUMPV
LABELV $1303
line 4604
;4603:		case BS_TDM_pliers2:
;4604:			instr = &tdm_pliers2_default;
ADDRLP4 8
ADDRGP4 $1194
ASGNP4
line 4605
;4605:			break;
ADDRGP4 $1295
JUMPV
LABELV $1304
line 4607
;4606:		case BS_TDM_pliers3:
;4607:			instr = &tdm_pliers3_default;
ADDRLP4 8
ADDRGP4 $1195
ASGNP4
line 4608
;4608:			break;
ADDRGP4 $1295
JUMPV
LABELV $1294
line 4610
;4609:		default:
;4610:			mld->strategy = 0;
ADDRLP4 16
INDIRP4
CNSTI4 0
ASGNI4
line 4611
;4611:			break;
LABELV $1295
line 4613
;4612:		}
;4613:	}
LABELV $1265
line 4614
;4614:	if (!instr) return;
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1306
ADDRGP4 $1190
JUMPV
LABELV $1306
line 4616
;4615:
;4616:	tss->instructions.division.unassignedPlayers = 0;
ADDRLP4 4
INDIRP4
CNSTI4 32
ADDP4
CNSTI4 0
ASGNI4
line 4617
;4617:	tss->rfa_dangerLimit = 25;
ADDRLP4 4
INDIRP4
CNSTI4 636
ADDP4
CNSTI4 25
ASGNI4
line 4618
;4618:	tss->rfd_dangerLimit = 70;
ADDRLP4 4
INDIRP4
CNSTI4 640
ADDP4
CNSTI4 70
ASGNI4
line 4619
;4619:	tss->short_term = 0.1 * 1000 * g_respawnDelay.value;
ADDRLP4 4
INDIRP4
CNSTI4 644
ADDP4
ADDRGP4 g_respawnDelay+8
INDIRF4
CNSTF4 1120403456
MULF4
CVFI4 4
ASGNI4
line 4620
;4620:	tss->medium_term = 0.25 * 1000 * g_respawnDelay.value;
ADDRLP4 4
INDIRP4
CNSTI4 648
ADDP4
ADDRGP4 g_respawnDelay+8
INDIRF4
CNSTF4 1132068864
MULF4
CVFI4 4
ASGNI4
line 4621
;4621:	tss->long_term = 0.75 * 1000 * g_respawnDelay.value;
ADDRLP4 4
INDIRP4
CNSTI4 652
ADDP4
ADDRGP4 g_respawnDelay+8
INDIRF4
CNSTF4 1144750080
MULF4
CVFI4 4
ASGNI4
line 4622
;4622:	for (gr = 0; gr < MAX_GROUPS; gr++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1311
line 4623
;4623:		tss->designated1stLeaders[gr] = -1;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 356
ADDP4
ADDP4
CNSTI4 -1
ASGNI4
line 4624
;4624:		tss->designated2ndLeaders[gr] = -1;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 396
ADDP4
ADDP4
CNSTI4 -1
ASGNI4
line 4625
;4625:		tss->designated3rdLeaders[gr] = -1;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 436
ADDP4
ADDP4
CNSTI4 -1
ASGNI4
line 4627
;4626:
;4627:		tss->instructions.groupOrganization[gr] =				(*instr)[gr].rank;
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 16
ADDP4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 36
MULI4
ADDRLP4 8
INDIRP4
ADDP4
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 4628
;4628:		tss->instructions.division.group[gr].minTotalMembers =	(*instr)[gr].minTotal;
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4
INDIRP4
CNSTI4 36
ADDP4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 36
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 4629
;4629:		tss->instructions.division.group[gr].minAliveMembers =	(*instr)[gr].minAlive;
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4
INDIRP4
CNSTI4 36
ADDP4
ADDP4
CNSTI4 4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 36
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 4630
;4630:		tss->instructions.division.group[gr].minReadyMembers =	(*instr)[gr].minReady;
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4
INDIRP4
CNSTI4 36
ADDP4
ADDP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 36
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 4631
;4631:		tss->instructions.orders.order[gr].mission =			(*instr)[gr].mission;
ADDRLP4 0
INDIRI4
CNSTI4 20
MULI4
ADDRLP4 4
INDIRP4
CNSTI4 156
ADDP4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 36
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 4632
;4632:		tss->instructions.orders.order[gr].maxDanger =			(*instr)[gr].maxDanger;
ADDRLP4 0
INDIRI4
CNSTI4 20
MULI4
ADDRLP4 4
INDIRP4
CNSTI4 156
ADDP4
ADDP4
CNSTI4 4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 36
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 20
ADDP4
INDIRI4
ASGNI4
line 4633
;4633:		tss->instructions.orders.order[gr].minReady =			(*instr)[gr].missionMinReady;
ADDRLP4 0
INDIRI4
CNSTI4 20
MULI4
ADDRLP4 4
INDIRP4
CNSTI4 156
ADDP4
ADDP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 36
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 24
ADDP4
INDIRI4
ASGNI4
line 4634
;4634:		tss->instructions.orders.order[gr].minGroupSize =		(*instr)[gr].minGroupSize;
ADDRLP4 0
INDIRI4
CNSTI4 20
MULI4
ADDRLP4 4
INDIRP4
CNSTI4 156
ADDP4
ADDP4
CNSTI4 12
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 36
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 28
ADDP4
INDIRI4
ASGNI4
line 4635
;4635:		tss->instructions.orders.order[gr].maxGuards =			(*instr)[gr].maxGuards;
ADDRLP4 0
INDIRI4
CNSTI4 20
MULI4
ADDRLP4 4
INDIRP4
CNSTI4 156
ADDP4
ADDP4
CNSTI4 16
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 36
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 32
ADDP4
INDIRI4
ASGNI4
line 4636
;4636:	}
LABELV $1312
line 4622
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 10
LTI4 $1311
line 4638
;4637:
;4638:	tss->isValid = qtrue;
ADDRLP4 4
INDIRP4
CNSTI4 1
ASGNI4
line 4639
;4639:}
LABELV $1190
endproc BotMissionLeaderAI 140 12
export BotTeamAI
proc BotTeamAI 4 12
line 4646
;4640:
;4641:/*
;4642:==================
;4643:BotTeamAI
;4644:==================
;4645:*/
;4646:void BotTeamAI(bot_state_t *bs) {
line 4659
;4647:#if 0	// JUHOX: 'numteammates' & 'netname' no longer needed
;4648:	int numteammates;
;4649:	char netname[MAX_NETNAME];
;4650:#endif
;4651:
;4652:#if 0	// JUHOX: team ai is now strategic ai, so allow it for FFA too
;4653:	//
;4654:	if ( gametype < GT_TEAM  )
;4655:		return;
;4656:#endif
;4657:#if 1	// JUHOX: mission leader ai
;4658:	if (
;4659:		gametype >= GT_TEAM &&
ADDRGP4 gametype
INDIRI4
CNSTI4 3
LTI4 $1316
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
CNSTI4 720
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1316
line 4661
;4660:		g_entities[bs->client].client->sess.teamLeader
;4661:	) {
line 4662
;4662:		BotMissionLeaderAI(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotMissionLeaderAI
CALLV
pop
line 4663
;4663:	}
LABELV $1316
line 4666
;4664:#endif
;4665:#if 1	// JUHOX: a dead bot silently deactivates its human helpers
;4666:	if (bs->cur_ps.stats[STAT_HEALTH] <= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
CNSTI4 0
GTI4 $1319
line 4667
;4667:		memset(&bs->humanHelpers, -1, sizeof(bs->humanHelpers));
ADDRFP4 0
INDIRP4
CNSTI4 11920
ADDP4
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 128
ARGI4
ADDRGP4 memset
CALLP4
pop
line 4668
;4668:		return;
ADDRGP4 $1315
JUMPV
LABELV $1319
line 4707
;4669:	}
;4670:#endif
;4671:#if 0	// JUHOX: determine leader
;4672:	// make sure we've got a valid team leader
;4673:	if (!BotValidTeamLeader(bs)) {
;4674:		//
;4675:		if (!FindHumanTeamLeader(bs)) {
;4676:			//
;4677:			if (!bs->askteamleader_time && !bs->becometeamleader_time) {
;4678:				if (bs->entergame_time + 10 > FloatTime()) {
;4679:					bs->askteamleader_time = FloatTime() + 5 + random() * 10;
;4680:				}
;4681:				else {
;4682:					bs->becometeamleader_time = FloatTime() + 5 + random() * 10;
;4683:				}
;4684:			}
;4685:			if (bs->askteamleader_time && bs->askteamleader_time < FloatTime()) {
;4686:				// if asked for a team leader and no response
;4687:				BotAI_BotInitialChat(bs, "whoisteamleader", NULL);
;4688:				trap_BotEnterChat(bs->cs, 0, CHAT_TEAM);
;4689:				bs->askteamleader_time = 0;
;4690:				bs->becometeamleader_time = FloatTime() + 8 + random() * 10;
;4691:			}
;4692:			if (bs->becometeamleader_time && bs->becometeamleader_time < FloatTime()) {
;4693:				BotAI_BotInitialChat(bs, "iamteamleader", NULL);
;4694:				trap_BotEnterChat(bs->cs, 0, CHAT_TEAM);
;4695:				BotSayVoiceTeamOrder(bs, -1, VOICECHAT_STARTLEADER);
;4696:				ClientName(bs->client, netname, sizeof(netname));
;4697:				strncpy(bs->teamleader, netname, sizeof(bs->teamleader));
;4698:				bs->teamleader[sizeof(bs->teamleader)] = '\0';
;4699:				bs->becometeamleader_time = 0;
;4700:			}
;4701:			return;
;4702:		}
;4703:	}
;4704:	bs->askteamleader_time = 0;
;4705:	bs->becometeamleader_time = 0;
;4706:#else
;4707:	BotDetermineLeader(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotDetermineLeader
CALLV
pop
line 4709
;4708:#endif
;4709:	BotTeamGameSingleBotAI(bs);	// JUHOX
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotTeamGameSingleBotAI
CALLV
pop
line 4716
;4710:
;4711:#if 0	// JUHOX: is this bot the leader?
;4712:	//return if this bot is NOT the team leader
;4713:	ClientName(bs->client, netname, sizeof(netname));
;4714:	if (Q_stricmp(netname, bs->teamleader) != 0) return;
;4715:#else
;4716:	if (bs->leader != bs->client) return;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 11872
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
EQI4 $1321
ADDRGP4 $1315
JUMPV
LABELV $1321
line 4826
;4717:#endif
;4718:	//
;4719:#if 0	// JUHOX: 'numteammates' no longer needed
;4720:	numteammates = BotNumTeamMates(bs);
;4721:#endif
;4722:	//give orders
;4723:#if 0	// JUHOX: always execute team leader ai
;4724:	switch(gametype) {
;4725:		case GT_TEAM:
;4726:		{
;4727:			if (bs->numteammates != numteammates || bs->forceorders) {
;4728:				bs->teamgiveorders_time = FloatTime();
;4729:				bs->numteammates = numteammates;
;4730:				bs->forceorders = qfalse;
;4731:			}
;4732:			//if it's time to give orders
;4733:			if (bs->teamgiveorders_time && bs->teamgiveorders_time < FloatTime() - 5) {
;4734:				BotTeamOrders(bs);
;4735:				//give orders again after 120 seconds
;4736:				bs->teamgiveorders_time = FloatTime() + 120;
;4737:			}
;4738:			break;
;4739:		}
;4740:		case GT_CTF:
;4741:		{
;4742:			//if the number of team mates changed or the flag status changed
;4743:			//or someone wants to know what to do
;4744:			if (bs->numteammates != numteammates || bs->flagstatuschanged || bs->forceorders) {
;4745:				bs->teamgiveorders_time = FloatTime();
;4746:				bs->numteammates = numteammates;
;4747:				bs->flagstatuschanged = qfalse;
;4748:				bs->forceorders = qfalse;
;4749:			}
;4750:			//if there were no flag captures the last 3 minutes
;4751:			if (bs->lastflagcapture_time < FloatTime() - 240) {
;4752:				bs->lastflagcapture_time = FloatTime();
;4753:				//randomly change the CTF strategy
;4754:				if (random() < 0.4) {
;4755:					bs->ctfstrategy ^= CTFS_AGRESSIVE;
;4756:					bs->teamgiveorders_time = FloatTime();
;4757:				}
;4758:			}
;4759:			//if it's time to give orders
;4760:			if (bs->teamgiveorders_time && bs->teamgiveorders_time < FloatTime() - 3) {
;4761:				BotCTFOrders(bs);
;4762:				//
;4763:				bs->teamgiveorders_time = 0;
;4764:			}
;4765:			break;
;4766:		}
;4767:#ifdef MISSIONPACK
;4768:		case GT_1FCTF:
;4769:		{
;4770:			if (bs->numteammates != numteammates || bs->flagstatuschanged || bs->forceorders) {
;4771:				bs->teamgiveorders_time = FloatTime();
;4772:				bs->numteammates = numteammates;
;4773:				bs->flagstatuschanged = qfalse;
;4774:				bs->forceorders = qfalse;
;4775:			}
;4776:			//if there were no flag captures the last 4 minutes
;4777:			if (bs->lastflagcapture_time < FloatTime() - 240) {
;4778:				bs->lastflagcapture_time = FloatTime();
;4779:				//randomly change the CTF strategy
;4780:				if (random() < 0.4) {
;4781:					bs->ctfstrategy ^= CTFS_AGRESSIVE;
;4782:					bs->teamgiveorders_time = FloatTime();
;4783:				}
;4784:			}
;4785:			//if it's time to give orders
;4786:			if (bs->teamgiveorders_time && bs->teamgiveorders_time < FloatTime() - 2) {
;4787:				Bot1FCTFOrders(bs);
;4788:				//
;4789:				bs->teamgiveorders_time = 0;
;4790:			}
;4791:			break;
;4792:		}
;4793:		case GT_OBELISK:
;4794:		{
;4795:			if (bs->numteammates != numteammates || bs->forceorders) {
;4796:				bs->teamgiveorders_time = FloatTime();
;4797:				bs->numteammates = numteammates;
;4798:				bs->forceorders = qfalse;
;4799:			}
;4800:			//if it's time to give orders
;4801:			if (bs->teamgiveorders_time && bs->teamgiveorders_time < FloatTime() - 5) {
;4802:				BotObeliskOrders(bs);
;4803:				//give orders again after 30 seconds
;4804:				bs->teamgiveorders_time = FloatTime() + 30;
;4805:			}
;4806:			break;
;4807:		}
;4808:		case GT_HARVESTER:
;4809:		{
;4810:			if (bs->numteammates != numteammates || bs->forceorders) {
;4811:				bs->teamgiveorders_time = FloatTime();
;4812:				bs->numteammates = numteammates;
;4813:				bs->forceorders = qfalse;
;4814:			}
;4815:			//if it's time to give orders
;4816:			if (bs->teamgiveorders_time && bs->teamgiveorders_time < FloatTime() - 5) {
;4817:				BotHarvesterOrders(bs);
;4818:				//give orders again after 30 seconds
;4819:				bs->teamgiveorders_time = FloatTime() + 30;
;4820:			}
;4821:			break;
;4822:		}
;4823:#endif
;4824:	}
;4825:#else
;4826:	BotTeamLeaderAI(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotTeamLeaderAI
CALLV
pop
line 4828
;4827:#endif
;4828:}
LABELV $1315
endproc BotTeamAI 4 12
bss
align 4
LABELV blueFlagAreaTime
skip 4
align 4
LABELV blueFlagArea
skip 4
align 4
LABELV redFlagAreaTime
skip 4
align 4
LABELV redFlagArea
skip 4
align 4
LABELV rescueSchedule_blue
skip 524
align 4
LABELV rescueSchedule_red
skip 524
export ctftaskpreferences
align 4
LABELV ctftaskpreferences
skip 2560
import BotVoiceChat_Defend
import BotVoiceChatCommand
import FindDroppedFlag
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
LABELV $1245
byte 1 105
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 115
byte 1 116
byte 1 114
byte 1 97
byte 1 116
byte 1 101
byte 1 103
byte 1 121
byte 1 32
byte 1 35
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $848
byte 1 0
align 1
LABELV $805
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $804
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $803
byte 1 70
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $802
byte 1 73
byte 1 110
byte 1 118
byte 1 105
byte 1 115
byte 1 105
byte 1 98
byte 1 105
byte 1 108
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $801
byte 1 83
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $800
byte 1 66
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 83
byte 1 117
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $799
byte 1 81
byte 1 117
byte 1 97
byte 1 100
byte 1 32
byte 1 68
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $798
byte 1 66
byte 1 102
byte 1 103
byte 1 32
byte 1 65
byte 1 109
byte 1 109
byte 1 111
byte 1 0
align 1
LABELV $797
byte 1 83
byte 1 108
byte 1 117
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $796
byte 1 82
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $795
byte 1 76
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $794
byte 1 67
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 0
align 1
LABELV $793
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $792
byte 1 66
byte 1 117
byte 1 108
byte 1 108
byte 1 101
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $791
byte 1 83
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 0
align 1
LABELV $790
byte 1 71
byte 1 114
byte 1 97
byte 1 112
byte 1 112
byte 1 108
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 72
byte 1 111
byte 1 111
byte 1 107
byte 1 0
align 1
LABELV $789
byte 1 66
byte 1 70
byte 1 71
byte 1 49
byte 1 48
byte 1 75
byte 1 0
align 1
LABELV $788
byte 1 80
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 32
byte 1 71
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $787
byte 1 82
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $786
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
LABELV $785
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
LABELV $784
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
LABELV $783
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
LABELV $782
byte 1 83
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $781
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
LABELV $780
byte 1 82
byte 1 101
byte 1 103
byte 1 101
byte 1 110
byte 1 101
byte 1 114
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $779
byte 1 77
byte 1 101
byte 1 100
byte 1 107
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $778
byte 1 80
byte 1 101
byte 1 114
byte 1 115
byte 1 111
byte 1 110
byte 1 97
byte 1 108
byte 1 32
byte 1 84
byte 1 101
byte 1 108
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $777
byte 1 77
byte 1 101
byte 1 103
byte 1 97
byte 1 32
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $776
byte 1 53
byte 1 48
byte 1 32
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $775
byte 1 50
byte 1 53
byte 1 32
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $774
byte 1 53
byte 1 32
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $773
byte 1 72
byte 1 101
byte 1 97
byte 1 118
byte 1 121
byte 1 32
byte 1 65
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $772
byte 1 65
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $771
byte 1 65
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 32
byte 1 83
byte 1 104
byte 1 97
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $699
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
LABELV $454
byte 1 84
byte 1 104
byte 1 97
byte 1 110
byte 1 107
byte 1 115
byte 1 44
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 73
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 108
byte 1 111
byte 1 110
byte 1 103
byte 1 101
byte 1 114
byte 1 32
byte 1 110
byte 1 101
byte 1 101
byte 1 100
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $437
byte 1 80
byte 1 108
byte 1 101
byte 1 97
byte 1 115
byte 1 101
byte 1 32
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 32
byte 1 109
byte 1 101
byte 1 44
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $208
byte 1 25
byte 1 40
byte 1 37
byte 1 115
byte 1 25
byte 1 41
byte 1 25
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $127
byte 1 116
byte 1 0
align 1
LABELV $123
byte 1 110
byte 1 0
align 1
LABELV $116
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
