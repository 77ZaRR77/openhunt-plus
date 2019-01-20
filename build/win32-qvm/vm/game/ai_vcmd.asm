export BotVoiceChat_GetFlag
code
proc BotVoiceChat_GetFlag 8 8
file "..\..\..\..\code\game\ai_vcmd.c"
line 52
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:
;4:/*****************************************************************************
;5: * name:		ai_vcmd.c
;6: *
;7: * desc:		Quake3 bot AI
;8: *
;9: * $Archive: /MissionPack/code/game/ai_vcmd.c $
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
;31://
;32:#include "chars.h"				//characteristics
;33:#include "inv.h"				//indexes into the inventory
;34:#include "syn.h"				//synonyms
;35:#include "match.h"				//string matching types and vars
;36:
;37:// for the voice chats
;38:#include "../../ui/menudef.h"
;39:
;40:
;41:typedef struct voiceCommand_s
;42:{
;43:	char *cmd;
;44:	void (*func)(bot_state_t *bs, int client, int mode);
;45:} voiceCommand_t;
;46:
;47:/*
;48:==================
;49:BotVoiceChat_GetFlag
;50:==================
;51:*/
;52:void BotVoiceChat_GetFlag(bot_state_t *bs, int client, int mode) {
line 54
;53:	//
;54:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $92
line 55
;55:		if (!ctf_redflag.areanum || !ctf_blueflag.areanum)
ADDRGP4 ctf_redflag+12
INDIRI4
CNSTI4 0
EQI4 $99
ADDRGP4 ctf_blueflag+12
INDIRI4
CNSTI4 0
NEI4 $94
LABELV $99
line 56
;56:			return;
ADDRGP4 $92
JUMPV
line 57
;57:	}
line 64
;58:#ifdef MISSIONPACK
;59:	else if (gametype == GT_1FCTF) {
;60:		if (!ctf_neutralflag.areanum || !ctf_redflag.areanum || !ctf_blueflag.areanum)
;61:			return;
;62:	}
;63:#endif
;64:	else {
line 65
;65:		return;
LABELV $94
line 68
;66:	}
;67:	//
;68:	bs->decisionmaker = client;
ADDRFP4 0
INDIRP4
CNSTI4 11564
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 69
;69:	bs->ordered = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 11568
ADDP4
CNSTI4 1
ASGNI4
line 70
;70:	bs->order_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 11572
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 72
;71:	//set the time to send a message to the team mates
;72:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 0
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRFP4 0
INDIRP4
CNSTI4 11696
ADDP4
ADDRGP4 floattime
INDIRF4
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
CNSTF4 1073741824
MULF4
ADDF4
ASGNF4
line 74
;73:	//set the ltg type
;74:	bs->ltgtype = LTG_GETFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 4
ASGNI4
line 76
;75:	//set the team goal time
;76:	bs->teamgoal_time = FloatTime() + CTF_GETFLAG_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 11700
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 78
;77:	// get an alternate route in ctf
;78:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $100
line 80
;79:		//get an alternative route goal towards the enemy base
;80:		BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 81
;81:	}
LABELV $100
line 83
;82:	//
;83:	BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 85
;84:	// remember last ordered task
;85:	BotRememberLastOrderedTask(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRememberLastOrderedTask
CALLV
pop
line 89
;86:#ifdef DEBUG
;87:	BotPrintTeamGoal(bs);
;88:#endif //DEBUG
;89:}
LABELV $92
endproc BotVoiceChat_GetFlag 8 8
export BotVoiceChat_Offense
proc BotVoiceChat_Offense 4 12
line 96
;90:
;91:/*
;92:==================
;93:BotVoiceChat_Offense
;94:==================
;95:*/
;96:void BotVoiceChat_Offense(bot_state_t *bs, int client, int mode) {
line 97
;97:	if ( gametype == GT_CTF
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $103
line 101
;98:#ifdef MISSIONPACK
;99:		|| gametype == GT_1FCTF
;100:#endif
;101:		) {
line 102
;102:		BotVoiceChat_GetFlag(bs, client, mode);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 BotVoiceChat_GetFlag
CALLV
pop
line 103
;103:		return;
ADDRGP4 $102
JUMPV
LABELV $103
line 125
;104:	}
;105:#ifdef MISSIONPACK
;106:	if (gametype == GT_HARVESTER) {
;107:		//
;108:		bs->decisionmaker = client;
;109:		bs->ordered = qtrue;
;110:		bs->order_time = FloatTime();
;111:		//set the time to send a message to the team mates
;112:		bs->teammessage_time = FloatTime() + 2 * random();
;113:		//set the ltg type
;114:		bs->ltgtype = LTG_HARVEST;
;115:		//set the team goal time
;116:		bs->teamgoal_time = FloatTime() + TEAM_HARVEST_TIME;
;117:		bs->harvestaway_time = 0;
;118:		//
;119:		BotSetTeamStatus(bs);
;120:		// remember last ordered task
;121:		BotRememberLastOrderedTask(bs);
;122:	}
;123:	else
;124:#endif
;125:	{
line 127
;126:		//
;127:		bs->decisionmaker = client;
ADDRFP4 0
INDIRP4
CNSTI4 11564
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 128
;128:		bs->ordered = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 11568
ADDP4
CNSTI4 1
ASGNI4
line 129
;129:		bs->order_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 11572
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 131
;130:		//set the time to send a message to the team mates
;131:		bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 0
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRFP4 0
INDIRP4
CNSTI4 11696
ADDP4
ADDRGP4 floattime
INDIRF4
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
CNSTF4 1073741824
MULF4
ADDF4
ASGNF4
line 133
;132:		//set the ltg type
;133:		bs->ltgtype = LTG_ATTACKENEMYBASE;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 13
ASGNI4
line 135
;134:		//set the team goal time
;135:		bs->teamgoal_time = FloatTime() + TEAM_ATTACKENEMYBASE_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 11700
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 136
;136:		bs->attackaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7248
ADDP4
CNSTF4 0
ASGNF4
line 138
;137:		//
;138:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 140
;139:		// remember last ordered task
;140:		BotRememberLastOrderedTask(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRememberLastOrderedTask
CALLV
pop
line 141
;141:	}
line 145
;142:#ifdef DEBUG
;143:	BotPrintTeamGoal(bs);
;144:#endif //DEBUG
;145:}
LABELV $102
endproc BotVoiceChat_Offense 4 12
export BotVoiceChat_Defend
proc BotVoiceChat_Defend 12 12
line 152
;146:
;147:/*
;148:==================
;149:BotVoiceChat_Defend
;150:==================
;151:*/
;152:void BotVoiceChat_Defend(bot_state_t *bs, int client, int mode) {
line 164
;153:#ifdef MISSIONPACK
;154:	if ( gametype == GT_OBELISK || gametype == GT_HARVESTER) {
;155:		//
;156:		switch(BotTeam(bs)) {
;157:			case TEAM_RED: memcpy(&bs->teamgoal, &redobelisk, sizeof(bot_goal_t)); break;
;158:			case TEAM_BLUE: memcpy(&bs->teamgoal, &blueobelisk, sizeof(bot_goal_t)); break;
;159:			default: return;
;160:		}
;161:	}
;162:	else
;163:#endif
;164:		if (gametype == GT_CTF
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $105
line 168
;165:#ifdef MISSIONPACK
;166:			|| gametype == GT_1FCTF
;167:#endif
;168:			) {
line 170
;169:		//
;170:		switch(BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $111
ADDRLP4 0
INDIRI4
CNSTI4 2
EQI4 $112
ADDRGP4 $105
JUMPV
LABELV $111
line 171
;171:			case TEAM_RED: memcpy(&bs->teamgoal, &ctf_redflag, sizeof(bot_goal_t)); break;
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
ADDRGP4 $107
JUMPV
LABELV $112
line 172
;172:			case TEAM_BLUE: memcpy(&bs->teamgoal, &ctf_blueflag, sizeof(bot_goal_t)); break;
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
line 173
;173:			default: return;
line 175
;174:		}
;175:	}
line 176
;176:	else {
line 177
;177:		return;
LABELV $107
line 180
;178:	}
;179:	//
;180:	bs->decisionmaker = client;
ADDRFP4 0
INDIRP4
CNSTI4 11564
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 181
;181:	bs->ordered = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 11568
ADDP4
CNSTI4 1
ASGNI4
line 182
;182:	bs->order_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 11572
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 184
;183:	//set the time to send a message to the team mates
;184:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 0
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRFP4 0
INDIRP4
CNSTI4 11696
ADDP4
ADDRGP4 floattime
INDIRF4
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
CNSTF4 1073741824
MULF4
ADDF4
ASGNF4
line 186
;185:	//set the ltg type
;186:	bs->ltgtype = LTG_DEFENDKEYAREA;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 3
ASGNI4
line 188
;187:	//get the team goal time
;188:	bs->teamgoal_time = FloatTime() + TEAM_DEFENDKEYAREA_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 11700
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 190
;189:	//away from defending
;190:	bs->defendaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7236
ADDP4
CNSTF4 0
ASGNF4
line 192
;191:	//
;192:	BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 194
;193:	// remember last ordered task
;194:	BotRememberLastOrderedTask(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRememberLastOrderedTask
CALLV
pop
line 198
;195:#ifdef DEBUG
;196:	BotPrintTeamGoal(bs);
;197:#endif //DEBUG
;198:}
LABELV $105
endproc BotVoiceChat_Defend 12 12
export BotVoiceChat_DefendFlag
proc BotVoiceChat_DefendFlag 0 12
line 205
;199:
;200:/*
;201:==================
;202:BotVoiceChat_DefendFlag
;203:==================
;204:*/
;205:void BotVoiceChat_DefendFlag(bot_state_t *bs, int client, int mode) {
line 206
;206:	BotVoiceChat_Defend(bs, client, mode);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 BotVoiceChat_Defend
CALLV
pop
line 207
;207:}
LABELV $113
endproc BotVoiceChat_DefendFlag 0 12
export BotVoiceChat_Patrol
proc BotVoiceChat_Patrol 0 12
line 214
;208:
;209:/*
;210:==================
;211:BotVoiceChat_Patrol
;212:==================
;213:*/
;214:void BotVoiceChat_Patrol(bot_state_t *bs, int client, int mode) {
line 216
;215:	//
;216:	bs->decisionmaker = client;
ADDRFP4 0
INDIRP4
CNSTI4 11564
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 218
;217:	//
;218:	bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 0
ASGNI4
line 219
;219:	bs->lead_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11844
ADDP4
CNSTF4 0
ASGNF4
line 220
;220:	bs->lastgoal_ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11720
ADDP4
CNSTI4 0
ASGNI4
line 222
;221:	//
;222:	BotAI_BotInitialChat(bs, "dismissed", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $115
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 223
;223:	trap_BotEnterChat(bs->cs, client, CHAT_TELL);
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
line 224
;224:	BotVoiceChatOnly(bs, -1, VOICECHAT_ONPATROL);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 $116
ARGP4
ADDRGP4 BotVoiceChatOnly
CALLV
pop
line 226
;225:	//
;226:	BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 230
;227:#ifdef DEBUG
;228:	BotPrintTeamGoal(bs);
;229:#endif //DEBUG
;230:}
LABELV $114
endproc BotVoiceChat_Patrol 0 12
export BotVoiceChat_Camp
proc BotVoiceChat_Camp 184 16
line 237
;231:
;232:/*
;233:==================
;234:BotVoiceChat_Camp
;235:==================
;236:*/
;237:void BotVoiceChat_Camp(bot_state_t *bs, int client, int mode) {
line 243
;238:	int areanum;
;239:	aas_entityinfo_t entinfo;
;240:	char netname[MAX_NETNAME];
;241:
;242:	//
;243:	bs->teamgoal.entitynum = -1;
ADDRFP4 0
INDIRP4
CNSTI4 11620
ADDP4
CNSTI4 -1
ASGNI4
line 244
;244:	BotEntityInfo(client, &entinfo);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 246
;245:	//if info is valid (in PVS)
;246:	if (entinfo.valid) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $118
line 247
;247:		areanum = BotPointAreaNum(entinfo.origin);
ADDRLP4 0+24
ARGP4
ADDRLP4 180
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 140
ADDRLP4 180
INDIRI4
ASGNI4
line 248
;248:		if (areanum) { // && trap_AAS_AreaReachability(areanum)) {
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $121
line 251
;249:			//NOTE: just assume the bot knows where the person is
;250:			//if (BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, client)) {
;251:				bs->teamgoal.entitynum = client;
ADDRFP4 0
INDIRP4
CNSTI4 11620
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 252
;252:				bs->teamgoal.areanum = areanum;
ADDRFP4 0
INDIRP4
CNSTI4 11592
ADDP4
ADDRLP4 140
INDIRI4
ASGNI4
line 253
;253:				VectorCopy(entinfo.origin, bs->teamgoal.origin);
ADDRFP4 0
INDIRP4
CNSTI4 11580
ADDP4
ADDRLP4 0+24
INDIRB
ASGNB 12
line 254
;254:				VectorSet(bs->teamgoal.mins, -8, -8, -8);
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
line 255
;255:				VectorSet(bs->teamgoal.maxs, 8, 8, 8);
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
line 257
;256:			//}
;257:		}
LABELV $121
line 258
;258:	}
LABELV $118
line 260
;259:	//if the other is not visible
;260:	if (bs->teamgoal.entitynum < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 11620
ADDP4
INDIRI4
CNSTI4 0
GEI4 $124
line 261
;261:		BotAI_BotInitialChat(bs, "whereareyou", EasyClientName(client, netname, sizeof(netname)), NULL);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 144
ARGP4
CNSTI4 36
ARGI4
ADDRLP4 180
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $126
ARGP4
ADDRLP4 180
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 262
;262:		trap_BotEnterChat(bs->cs, client, CHAT_TELL);
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
line 263
;263:		return;
ADDRGP4 $117
JUMPV
LABELV $124
line 266
;264:	}
;265:	//
;266:	bs->decisionmaker = client;
ADDRFP4 0
INDIRP4
CNSTI4 11564
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 267
;267:	bs->ordered = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 11568
ADDP4
CNSTI4 1
ASGNI4
line 268
;268:	bs->order_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 11572
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 270
;269:	//set the time to send a message to the team mates
;270:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 180
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRFP4 0
INDIRP4
CNSTI4 11696
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 180
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 180
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1073741824
MULF4
ADDF4
ASGNF4
line 272
;271:	//set the ltg type
;272:	bs->ltgtype = LTG_CAMPORDER;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 8
ASGNI4
line 274
;273:	//get the team goal time
;274:	bs->teamgoal_time = FloatTime() + TEAM_CAMP_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 11700
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 276
;275:	//the teammate that requested the camping
;276:	bs->teammate = client;
ADDRFP4 0
INDIRP4
CNSTI4 11560
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 278
;277:	//not arrived yet
;278:	bs->arrive_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7264
ADDP4
CNSTF4 0
ASGNF4
line 280
;279:	//
;280:	BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 282
;281:	// remember last ordered task
;282:	BotRememberLastOrderedTask(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRememberLastOrderedTask
CALLV
pop
line 286
;283:#ifdef DEBUG
;284:	BotPrintTeamGoal(bs);
;285:#endif //DEBUG
;286:}
LABELV $117
endproc BotVoiceChat_Camp 184 16
export BotVoiceChat_FollowMe
proc BotVoiceChat_FollowMe 184 16
line 293
;287:
;288:/*
;289:==================
;290:BotVoiceChat_FollowMe
;291:==================
;292:*/
;293:void BotVoiceChat_FollowMe(bot_state_t *bs, int client, int mode) {
line 298
;294:	int areanum;
;295:	aas_entityinfo_t entinfo;
;296:	char netname[MAX_NETNAME];
;297:
;298:	bs->teamgoal.entitynum = -1;
ADDRFP4 0
INDIRP4
CNSTI4 11620
ADDP4
CNSTI4 -1
ASGNI4
line 299
;299:	BotEntityInfo(client, &entinfo);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 301
;300:	//if info is valid (in PVS)
;301:	if (entinfo.valid) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $128
line 302
;302:		areanum = BotPointAreaNum(entinfo.origin);
ADDRLP4 0+24
ARGP4
ADDRLP4 180
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 140
ADDRLP4 180
INDIRI4
ASGNI4
line 303
;303:		if (areanum) { // && trap_AAS_AreaReachability(areanum)) {
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $131
line 304
;304:			bs->teamgoal.entitynum = client;
ADDRFP4 0
INDIRP4
CNSTI4 11620
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 305
;305:			bs->teamgoal.areanum = areanum;
ADDRFP4 0
INDIRP4
CNSTI4 11592
ADDP4
ADDRLP4 140
INDIRI4
ASGNI4
line 306
;306:			VectorCopy(entinfo.origin, bs->teamgoal.origin);
ADDRFP4 0
INDIRP4
CNSTI4 11580
ADDP4
ADDRLP4 0+24
INDIRB
ASGNB 12
line 307
;307:			VectorSet(bs->teamgoal.mins, -8, -8, -8);
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
line 308
;308:			VectorSet(bs->teamgoal.maxs, 8, 8, 8);
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
line 309
;309:		}
LABELV $131
line 310
;310:	}
LABELV $128
line 312
;311:	//if the other is not visible
;312:	if (bs->teamgoal.entitynum < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 11620
ADDP4
INDIRI4
CNSTI4 0
GEI4 $134
line 313
;313:		BotAI_BotInitialChat(bs, "whereareyou", EasyClientName(client, netname, sizeof(netname)), NULL);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 144
ARGP4
CNSTI4 36
ARGI4
ADDRLP4 180
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $126
ARGP4
ADDRLP4 180
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 314
;314:		trap_BotEnterChat(bs->cs, client, CHAT_TELL);
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
line 315
;315:		return;
ADDRGP4 $127
JUMPV
LABELV $134
line 318
;316:	}
;317:	//
;318:	bs->decisionmaker = client;
ADDRFP4 0
INDIRP4
CNSTI4 11564
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 319
;319:	bs->ordered = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 11568
ADDP4
CNSTI4 1
ASGNI4
line 320
;320:	bs->order_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 11572
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 322
;321:	//the team mate
;322:	bs->teammate = client;
ADDRFP4 0
INDIRP4
CNSTI4 11560
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 324
;323:	//last time the team mate was assumed visible
;324:	bs->teammatevisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 11708
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 326
;325:	//set the time to send a message to the team mates
;326:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 180
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRFP4 0
INDIRP4
CNSTI4 11696
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 180
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 180
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1073741824
MULF4
ADDF4
ASGNF4
line 328
;327:	//get the team goal time
;328:	bs->teamgoal_time = FloatTime() + TEAM_ACCOMPANY_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 11700
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 330
;329:	//set the ltg type
;330:	bs->ltgtype = LTG_TEAMACCOMPANY;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 2
ASGNI4
line 331
;331:	bs->formation_dist = 3.5 * 32;		//3.5 meter
ADDRFP4 0
INDIRP4
CNSTI4 12344
ADDP4
CNSTF4 1121976320
ASGNF4
line 332
;332:	bs->arrive_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7264
ADDP4
CNSTF4 0
ASGNF4
line 334
;333:	//
;334:	BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 336
;335:	// remember last ordered task
;336:	BotRememberLastOrderedTask(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRememberLastOrderedTask
CALLV
pop
line 340
;337:#ifdef DEBUG
;338:	BotPrintTeamGoal(bs);
;339:#endif //DEBUG
;340:}
LABELV $127
endproc BotVoiceChat_FollowMe 184 16
export BotVoiceChat_FollowFlagCarrier
proc BotVoiceChat_FollowFlagCarrier 8 12
line 347
;341:
;342:/*
;343:==================
;344:BotVoiceChat_FollowFlagCarrier
;345:==================
;346:*/
;347:void BotVoiceChat_FollowFlagCarrier(bot_state_t *bs, int client, int mode) {
line 350
;348:	int carrier;
;349:
;350:	carrier = BotTeamFlagCarrier(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 BotTeamFlagCarrier
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 351
;351:	if (carrier >= 0)
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $137
line 352
;352:		BotVoiceChat_FollowMe(bs, carrier, mode);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 BotVoiceChat_FollowMe
CALLV
pop
LABELV $137
line 356
;353:#ifdef DEBUG
;354:	BotPrintTeamGoal(bs);
;355:#endif //DEBUG
;356:}
LABELV $136
endproc BotVoiceChat_FollowFlagCarrier 8 12
export BotVoiceChat_ReturnFlag
proc BotVoiceChat_ReturnFlag 4 4
line 363
;357:
;358:/*
;359:==================
;360:BotVoiceChat_ReturnFlag
;361:==================
;362:*/
;363:void BotVoiceChat_ReturnFlag(bot_state_t *bs, int client, int mode) {
line 366
;364:	//if not in CTF mode
;365:	if (
;366:		gametype != GT_CTF
ADDRGP4 gametype
INDIRI4
CNSTI4 4
EQI4 $140
line 370
;367:#ifdef MISSIONPACK
;368:		&& gametype != GT_1FCTF
;369:#endif
;370:		) {
line 371
;371:		return;
ADDRGP4 $139
JUMPV
LABELV $140
line 374
;372:	}
;373:	//
;374:	bs->decisionmaker = client;
ADDRFP4 0
INDIRP4
CNSTI4 11564
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 375
;375:	bs->ordered = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 11568
ADDP4
CNSTI4 1
ASGNI4
line 376
;376:	bs->order_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 11572
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 378
;377:	//set the time to send a message to the team mates
;378:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 0
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRFP4 0
INDIRP4
CNSTI4 11696
ADDP4
ADDRGP4 floattime
INDIRF4
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
CNSTF4 1073741824
MULF4
ADDF4
ASGNF4
line 380
;379:	//set the ltg type
;380:	bs->ltgtype = LTG_RETURNFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 6
ASGNI4
line 382
;381:	//set the team goal time
;382:	bs->teamgoal_time = FloatTime() + CTF_RETURNFLAG_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 11700
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1127481344
ADDF4
ASGNF4
line 383
;383:	bs->rushbaseaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7244
ADDP4
CNSTF4 0
ASGNF4
line 384
;384:	BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 388
;385:#ifdef DEBUG
;386:	BotPrintTeamGoal(bs);
;387:#endif //DEBUG
;388:}
LABELV $139
endproc BotVoiceChat_ReturnFlag 4 4
export BotVoiceChat_StartLeader
proc BotVoiceChat_StartLeader 0 0
line 395
;389:
;390:/*
;391:==================
;392:BotVoiceChat_StartLeader
;393:==================
;394:*/
;395:void BotVoiceChat_StartLeader(bot_state_t *bs, int client, int mode) {
line 400
;396:	// JUHOX: don't start leadership via voice chat
;397:#if 0
;398:	ClientName(client, bs->teamleader, sizeof(bs->teamleader));
;399:#endif
;400:}
LABELV $142
endproc BotVoiceChat_StartLeader 0 0
export BotVoiceChat_StopLeader
proc BotVoiceChat_StopLeader 0 0
line 407
;401:
;402:/*
;403:==================
;404:BotVoiceChat_StopLeader
;405:==================
;406:*/
;407:void BotVoiceChat_StopLeader(bot_state_t *bs, int client, int mode) {
line 417
;408:	// JUHOX: don't stop leadership via voice chat
;409:#if 0
;410:	char netname[MAX_MESSAGE_SIZE];
;411:
;412:	if (!Q_stricmp(bs->teamleader, ClientName(client, netname, sizeof(netname)))) {
;413:		bs->teamleader[0] = '\0';
;414:		notleader[client] = qtrue;
;415:	}
;416:#endif
;417:}
LABELV $143
endproc BotVoiceChat_StopLeader 0 0
export BotVoiceChat_WhoIsLeader
proc BotVoiceChat_WhoIsLeader 0 0
line 424
;418:
;419:/*
;420:==================
;421:BotVoiceChat_WhoIsLeader
;422:==================
;423:*/
;424:void BotVoiceChat_WhoIsLeader(bot_state_t *bs, int client, int mode) {
line 439
;425:	// JUHOX: don't tell leadership via voice chat
;426:#if 0
;427:	char netname[MAX_MESSAGE_SIZE];
;428:
;429:	if (!TeamPlayIsOn()) return;
;430:
;431:	ClientName(bs->client, netname, sizeof(netname));
;432:	//if this bot IS the team leader
;433:	if (!Q_stricmp(netname, bs->teamleader)) {
;434:		BotAI_BotInitialChat(bs, "iamteamleader", NULL);
;435:		trap_BotEnterChat(bs->cs, 0, CHAT_TEAM);
;436:		BotVoiceChatOnly(bs, -1, VOICECHAT_STARTLEADER);
;437:	}
;438:#endif
;439:}
LABELV $144
endproc BotVoiceChat_WhoIsLeader 0 0
export BotVoiceChat_WantOnDefense
proc BotVoiceChat_WantOnDefense 44 16
line 446
;440:
;441:/*
;442:==================
;443:BotVoiceChat_WantOnDefense
;444:==================
;445:*/
;446:void BotVoiceChat_WantOnDefense(bot_state_t *bs, int client, int mode) {
line 450
;447:	char netname[MAX_NETNAME];
;448:	int preference;
;449:
;450:	preference = BotGetTeamMateTaskPreference(bs, client);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 40
ADDRGP4 BotGetTeamMateTaskPreference
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 40
INDIRI4
ASGNI4
line 451
;451:	preference &= ~TEAMTP_ATTACKER;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 -3
BANDI4
ASGNI4
line 452
;452:	preference |= TEAMTP_DEFENDER;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 453
;453:	BotSetTeamMateTaskPreference(bs, client, preference);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSetTeamMateTaskPreference
CALLV
pop
line 455
;454:	//
;455:	EasyClientName(client, netname, sizeof(netname));
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 456
;456:	BotAI_BotInitialChat(bs, "keepinmind", netname, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $146
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 457
;457:	trap_BotEnterChat(bs->cs, client, CHAT_TELL);
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
line 458
;458:	BotVoiceChatOnly(bs, client, VOICECHAT_YES);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $147
ARGP4
ADDRGP4 BotVoiceChatOnly
CALLV
pop
line 459
;459:	trap_EA_Action(bs->client, ACTION_AFFIRMATIVE);
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
line 460
;460:}
LABELV $145
endproc BotVoiceChat_WantOnDefense 44 16
export BotVoiceChat_WantOnOffense
proc BotVoiceChat_WantOnOffense 44 16
line 467
;461:
;462:/*
;463:==================
;464:BotVoiceChat_WantOnOffense
;465:==================
;466:*/
;467:void BotVoiceChat_WantOnOffense(bot_state_t *bs, int client, int mode) {
line 471
;468:	char netname[MAX_NETNAME];
;469:	int preference;
;470:
;471:	preference = BotGetTeamMateTaskPreference(bs, client);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 40
ADDRGP4 BotGetTeamMateTaskPreference
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 40
INDIRI4
ASGNI4
line 472
;472:	preference &= ~TEAMTP_DEFENDER;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 473
;473:	preference |= TEAMTP_ATTACKER;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 474
;474:	BotSetTeamMateTaskPreference(bs, client, preference);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSetTeamMateTaskPreference
CALLV
pop
line 476
;475:	//
;476:	EasyClientName(client, netname, sizeof(netname));
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 477
;477:	BotAI_BotInitialChat(bs, "keepinmind", netname, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $146
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 478
;478:	trap_BotEnterChat(bs->cs, client, CHAT_TELL);
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
line 479
;479:	BotVoiceChatOnly(bs, client, VOICECHAT_YES);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $147
ARGP4
ADDRGP4 BotVoiceChatOnly
CALLV
pop
line 480
;480:	trap_EA_Action(bs->client, ACTION_AFFIRMATIVE);
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
line 481
;481:}
LABELV $148
endproc BotVoiceChat_WantOnOffense 44 16
export BotVoiceChat_Dummy
proc BotVoiceChat_Dummy 0 0
line 483
;482:
;483:void BotVoiceChat_Dummy(bot_state_t *bs, int client, int mode) {
line 484
;484:}
LABELV $149
endproc BotVoiceChat_Dummy 0 0
data
export voiceCommands
align 4
LABELV voiceCommands
address $150
address BotVoiceChat_GetFlag
address $151
address BotVoiceChat_Offense
address $152
address BotVoiceChat_Defend
address $153
address BotVoiceChat_DefendFlag
address $154
address BotVoiceChat_Patrol
address $155
address BotVoiceChat_Camp
address $156
address BotVoiceChat_FollowMe
address $157
address BotVoiceChat_FollowFlagCarrier
address $158
address BotVoiceChat_ReturnFlag
address $159
address BotVoiceChat_StartLeader
address $160
address BotVoiceChat_StopLeader
address $161
address BotVoiceChat_WhoIsLeader
address $162
address BotVoiceChat_WantOnDefense
address $163
address BotVoiceChat_WantOnOffense
byte 4 0
address BotVoiceChat_Dummy
export BotVoiceChatCommand
code
proc BotVoiceChatCommand 340 12
line 504
;485:
;486:voiceCommand_t voiceCommands[] = {
;487:	{VOICECHAT_GETFLAG, BotVoiceChat_GetFlag},
;488:	{VOICECHAT_OFFENSE, BotVoiceChat_Offense },
;489:	{VOICECHAT_DEFEND, BotVoiceChat_Defend },
;490:	{VOICECHAT_DEFENDFLAG, BotVoiceChat_DefendFlag },
;491:	{VOICECHAT_PATROL, BotVoiceChat_Patrol },
;492:	{VOICECHAT_CAMP, BotVoiceChat_Camp },
;493:	{VOICECHAT_FOLLOWME, BotVoiceChat_FollowMe },
;494:	{VOICECHAT_FOLLOWFLAGCARRIER, BotVoiceChat_FollowFlagCarrier },
;495:	{VOICECHAT_RETURNFLAG, BotVoiceChat_ReturnFlag },
;496:	{VOICECHAT_STARTLEADER, BotVoiceChat_StartLeader },
;497:	{VOICECHAT_STOPLEADER, BotVoiceChat_StopLeader },
;498:	{VOICECHAT_WHOISLEADER, BotVoiceChat_WhoIsLeader },
;499:	{VOICECHAT_WANTONDEFENSE, BotVoiceChat_WantOnDefense },
;500:	{VOICECHAT_WANTONOFFENSE, BotVoiceChat_WantOnOffense },
;501:	{NULL, BotVoiceChat_Dummy}
;502:};
;503:
;504:int BotVoiceChatCommand(bot_state_t *bs, int mode, char *voiceChat) {
line 508
;505:	int i, voiceOnly, clientNum, color;
;506:	char *ptr, buf[MAX_MESSAGE_SIZE], *cmd;
;507:
;508:	if (!TeamPlayIsOn()) {
ADDRLP4 280
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 280
INDIRI4
CNSTI4 0
NEI4 $165
line 509
;509:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $164
JUMPV
LABELV $165
line 512
;510:	}
;511:
;512:	if ( mode == SAY_ALL ) {
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $167
line 513
;513:		return qfalse;	// don't do anything with voice chats to everyone
CNSTI4 0
RETI4
ADDRGP4 $164
JUMPV
LABELV $167
line 516
;514:	}
;515:
;516:	Q_strncpyz(buf, voiceChat, sizeof(buf));
ADDRLP4 16
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 517
;517:	cmd = buf;
ADDRLP4 0
ADDRLP4 16
ASGNP4
line 518
;518:	for (ptr = cmd; *cmd && *cmd > ' '; cmd++);
ADDRLP4 12
ADDRLP4 0
INDIRP4
ASGNP4
ADDRGP4 $172
JUMPV
LABELV $169
LABELV $170
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $172
ADDRLP4 284
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 284
INDIRI4
CNSTI4 0
EQI4 $173
ADDRLP4 284
INDIRI4
CNSTI4 32
GTI4 $169
LABELV $173
ADDRGP4 $175
JUMPV
LABELV $174
line 519
;519:	while (*cmd && *cmd <= ' ') *cmd++ = '\0';
ADDRLP4 288
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 288
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 288
INDIRP4
CNSTI1 0
ASGNI1
LABELV $175
ADDRLP4 292
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 292
INDIRI4
CNSTI4 0
EQI4 $177
ADDRLP4 292
INDIRI4
CNSTI4 32
LEI4 $174
LABELV $177
line 520
;520:	voiceOnly = atoi(ptr);
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 296
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 272
ADDRLP4 296
INDIRI4
ASGNI4
line 521
;521:	for (ptr = cmd; *cmd && *cmd > ' '; cmd++);
ADDRLP4 12
ADDRLP4 0
INDIRP4
ASGNP4
ADDRGP4 $181
JUMPV
LABELV $178
LABELV $179
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $181
ADDRLP4 300
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 300
INDIRI4
CNSTI4 0
EQI4 $182
ADDRLP4 300
INDIRI4
CNSTI4 32
GTI4 $178
LABELV $182
ADDRGP4 $184
JUMPV
LABELV $183
line 522
;522:	while (*cmd && *cmd <= ' ') *cmd++ = '\0';
ADDRLP4 304
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 304
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 304
INDIRP4
CNSTI1 0
ASGNI1
LABELV $184
ADDRLP4 308
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 308
INDIRI4
CNSTI4 0
EQI4 $186
ADDRLP4 308
INDIRI4
CNSTI4 32
LEI4 $183
LABELV $186
line 523
;523:	clientNum = atoi(ptr);
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 312
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 312
INDIRI4
ASGNI4
line 524
;524:	for (ptr = cmd; *cmd && *cmd > ' '; cmd++);
ADDRLP4 12
ADDRLP4 0
INDIRP4
ASGNP4
ADDRGP4 $190
JUMPV
LABELV $187
LABELV $188
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $190
ADDRLP4 316
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 316
INDIRI4
CNSTI4 0
EQI4 $191
ADDRLP4 316
INDIRI4
CNSTI4 32
GTI4 $187
LABELV $191
ADDRGP4 $193
JUMPV
LABELV $192
line 525
;525:	while (*cmd && *cmd <= ' ') *cmd++ = '\0';
ADDRLP4 320
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 320
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 320
INDIRP4
CNSTI1 0
ASGNI1
LABELV $193
ADDRLP4 324
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 324
INDIRI4
CNSTI4 0
EQI4 $195
ADDRLP4 324
INDIRI4
CNSTI4 32
LEI4 $192
LABELV $195
line 526
;526:	color = atoi(ptr);
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 328
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 276
ADDRLP4 328
INDIRI4
ASGNI4
line 528
;527:
;528:	if (!BotSameTeam(bs, clientNum)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 332
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 332
INDIRI4
CNSTI4 0
NEI4 $196
line 529
;529:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $164
JUMPV
LABELV $196
line 532
;530:	}
;531:
;532:	for (i = 0; voiceCommands[i].cmd; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $201
JUMPV
LABELV $198
line 533
;533:		if (!Q_stricmp(cmd, voiceCommands[i].cmd)) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 voiceCommands
ADDP4
INDIRP4
ARGP4
ADDRLP4 336
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 336
INDIRI4
CNSTI4 0
NEI4 $202
line 534
;534:			voiceCommands[i].func(bs, clientNum, mode);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 voiceCommands+4
ADDP4
INDIRP4
CALLV
pop
line 535
;535:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $164
JUMPV
LABELV $202
line 537
;536:		}
;537:	}
LABELV $199
line 532
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $201
ADDRLP4 4
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 voiceCommands
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $198
line 538
;538:	return qfalse;
CNSTI4 0
RETI4
LABELV $164
endproc BotVoiceChatCommand 340 12
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
LABELV $163
byte 1 119
byte 1 97
byte 1 110
byte 1 116
byte 1 111
byte 1 110
byte 1 111
byte 1 102
byte 1 102
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $162
byte 1 119
byte 1 97
byte 1 110
byte 1 116
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
LABELV $161
byte 1 119
byte 1 104
byte 1 111
byte 1 105
byte 1 115
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $160
byte 1 115
byte 1 116
byte 1 111
byte 1 112
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $159
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $158
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $157
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 99
byte 1 97
byte 1 114
byte 1 114
byte 1 105
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $156
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
LABELV $155
byte 1 99
byte 1 97
byte 1 109
byte 1 112
byte 1 0
align 1
LABELV $154
byte 1 112
byte 1 97
byte 1 116
byte 1 114
byte 1 111
byte 1 108
byte 1 0
align 1
LABELV $153
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $152
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $151
byte 1 111
byte 1 102
byte 1 102
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $150
byte 1 103
byte 1 101
byte 1 116
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $147
byte 1 121
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $146
byte 1 107
byte 1 101
byte 1 101
byte 1 112
byte 1 105
byte 1 110
byte 1 109
byte 1 105
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $126
byte 1 119
byte 1 104
byte 1 101
byte 1 114
byte 1 101
byte 1 97
byte 1 114
byte 1 101
byte 1 121
byte 1 111
byte 1 117
byte 1 0
align 1
LABELV $116
byte 1 111
byte 1 110
byte 1 112
byte 1 97
byte 1 116
byte 1 114
byte 1 111
byte 1 108
byte 1 0
align 1
LABELV $115
byte 1 100
byte 1 105
byte 1 115
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 101
byte 1 100
byte 1 0
