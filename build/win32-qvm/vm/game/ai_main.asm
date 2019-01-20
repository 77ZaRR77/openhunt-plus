export BotAI_IsBot
code
proc BotAI_IsBot 8 0
file "..\..\..\..\code\game\ai_main.c"
line 77
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:
;4:/*****************************************************************************
;5: * name:		ai_main.c
;6: *
;7: * desc:		Quake3 bot AI
;8: *
;9: * $Archive: /MissionPack/code/game/ai_main.c $
;10: *
;11: *****************************************************************************/
;12:
;13:
;14:#include "g_local.h"
;15:#include "q_shared.h"
;16:#include "botlib.h"		//bot lib interface
;17:#include "be_aas.h"
;18:#include "be_ea.h"
;19:#include "be_ai_char.h"
;20:#include "be_ai_chat.h"
;21:#include "be_ai_gen.h"
;22:#include "be_ai_goal.h"
;23:#include "be_ai_move.h"
;24:#include "be_ai_weap.h"
;25://
;26:#include "ai_main.h"
;27:#include "ai_dmq3.h"
;28:#include "ai_chat.h"
;29:#include "ai_cmd.h"
;30:#include "ai_dmnet.h"
;31:#include "ai_vcmd.h"
;32:
;33://
;34:#include "chars.h"
;35:#include "inv.h"
;36:#include "syn.h"
;37:
;38:#ifndef MAX_PATH
;39:#define MAX_PATH		144
;40:#endif
;41:
;42:
;43://bot states
;44:bot_state_t	*botstates[MAX_CLIENTS];
;45://number of bots
;46:int numbots;
;47://floating point time
;48:float floattime;
;49://time to do a regular update
;50:float regularupdate_time;
;51://
;52:int bot_interbreed;
;53:int bot_interbreedmatchcount;
;54://
;55:vmCvar_t bot_thinktime;
;56:vmCvar_t bot_memorydump;
;57:vmCvar_t bot_saveroutingcache;
;58:vmCvar_t bot_pause;
;59:vmCvar_t bot_report;
;60:vmCvar_t bot_testsolid;
;61:vmCvar_t bot_testclusters;
;62:vmCvar_t bot_developer;
;63:vmCvar_t bot_interbreedchar;
;64:vmCvar_t bot_interbreedbots;
;65:vmCvar_t bot_interbreedcycle;
;66:vmCvar_t bot_interbreedwrite;
;67:
;68:
;69:void ExitLevel( void );
;70:
;71:
;72:/*
;73:==================
;74:JUHOX: BotAI_IsBot
;75:==================
;76:*/
;77:bot_state_t* BotAI_IsBot(int client) {
line 80
;78:	bot_state_t* bs;
;79:
;80:	if (client < 0 || client >= MAX_CLIENTS) return NULL;
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $95
ADDRLP4 4
INDIRI4
CNSTI4 64
LTI4 $93
LABELV $95
CNSTP4 0
RETP4
ADDRGP4 $92
JUMPV
LABELV $93
line 81
;81:	bs = botstates[client];
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
line 82
;82:	if (!bs) return NULL;
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $96
CNSTP4 0
RETP4
ADDRGP4 $92
JUMPV
LABELV $96
line 83
;83:	if (!bs->inuse) return NULL;
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $98
CNSTP4 0
RETP4
ADDRGP4 $92
JUMPV
LABELV $98
line 84
;84:	return bs;
ADDRLP4 0
INDIRP4
RETP4
LABELV $92
endproc BotAI_IsBot 8 0
export BotAI_Print
proc BotAI_Print 2056 12
line 106
;85:}
;86:
;87:#if JUHOX_BOT_DEBUG
;88:/*
;89:==================
;90:JUHOX: BotAI_DebugBot
;91:==================
;92:*/
;93:qboolean BotAI_DebugBot(int clientNum) {
;94:	if (!BotAI_IsBot(clientNum)) return qfalse;
;95:
;96:	botstates[clientNum]->debugThisBot ^= 1;
;97:	return qtrue;
;98:}
;99:#endif
;100:
;101:/*
;102:==================
;103:BotAI_Print
;104:==================
;105:*/
;106:void QDECL BotAI_Print(int type, char *fmt, ...) {
line 110
;107:	char str[2048];
;108:	va_list ap;
;109:
;110:	va_start(ap, fmt);
ADDRLP4 0
ADDRFP4 4+4
ASGNP4
line 111
;111:	vsprintf(str, fmt, ap);
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 vsprintf
CALLI4
pop
line 112
;112:	va_end(ap);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 114
;113:
;114:	switch(type) {
ADDRLP4 2052
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 2052
INDIRI4
CNSTI4 1
LTI4 $102
ADDRLP4 2052
INDIRI4
CNSTI4 5
GTI4 $102
ADDRLP4 2052
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $115-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $115
address $104
address $106
address $108
address $110
address $112
code
LABELV $104
line 115
;115:		case PRT_MESSAGE: {
line 116
;116:			G_Printf("%s", str);
ADDRGP4 $105
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 117
;117:			break;
ADDRGP4 $103
JUMPV
LABELV $106
line 119
;118:		}
;119:		case PRT_WARNING: {
line 120
;120:			G_Printf( S_COLOR_YELLOW "Warning: %s", str );
ADDRGP4 $107
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 121
;121:			break;
ADDRGP4 $103
JUMPV
LABELV $108
line 123
;122:		}
;123:		case PRT_ERROR: {
line 124
;124:			G_Printf( S_COLOR_RED "Error: %s", str );
ADDRGP4 $109
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 125
;125:			break;
ADDRGP4 $103
JUMPV
LABELV $110
line 127
;126:		}
;127:		case PRT_FATAL: {
line 128
;128:			G_Printf( S_COLOR_RED "Fatal: %s", str );
ADDRGP4 $111
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 129
;129:			break;
ADDRGP4 $103
JUMPV
LABELV $112
line 131
;130:		}
;131:		case PRT_EXIT: {
line 132
;132:			G_Error( S_COLOR_RED "Exit: %s", str );
ADDRGP4 $113
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 133
;133:			break;
ADDRGP4 $103
JUMPV
LABELV $102
line 135
;134:		}
;135:		default: {
line 136
;136:			G_Printf( "unknown print type\n" );
ADDRGP4 $114
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 137
;137:			break;
LABELV $103
line 140
;138:		}
;139:	}
;140:}
LABELV $100
endproc BotAI_Print 2056 12
export BotAI_Trace
proc BotAI_Trace 56 28
line 148
;141:
;142:
;143:/*
;144:==================
;145:BotAI_Trace
;146:==================
;147:*/
;148:void BotAI_Trace(bsp_trace_t *bsptrace, vec3_t start, vec3_t mins, vec3_t maxs, vec3_t end, int passent, int contentmask) {
line 151
;149:	trace_t trace;
;150:
;151:	trap_Trace(&trace, start, mins, maxs, end, passent, contentmask);
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 20
INDIRI4
ARGI4
ADDRFP4 24
INDIRI4
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 153
;152:	//copy the trace information
;153:	bsptrace->allsolid = trace.allsolid;
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRI4
ASGNI4
line 154
;154:	bsptrace->startsolid = trace.startsolid;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0+4
INDIRI4
ASGNI4
line 155
;155:	bsptrace->fraction = trace.fraction;
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0+8
INDIRF4
ASGNF4
line 156
;156:	VectorCopy(trace.endpos, bsptrace->endpos);
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 0+12
INDIRB
ASGNB 12
line 157
;157:	bsptrace->plane.dist = trace.plane.dist;
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 0+24+12
INDIRF4
ASGNF4
line 158
;158:	VectorCopy(trace.plane.normal, bsptrace->plane.normal);
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 0+24
INDIRB
ASGNB 12
line 159
;159:	bsptrace->plane.signbits = trace.plane.signbits;
ADDRFP4 0
INDIRP4
CNSTI4 41
ADDP4
ADDRLP4 0+24+17
INDIRU1
ASGNU1
line 160
;160:	bsptrace->plane.type = trace.plane.type;
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 0+24+16
INDIRU1
ASGNU1
line 161
;161:	bsptrace->surface.value = trace.surfaceFlags;
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ADDRLP4 0+44
INDIRI4
ASGNI4
line 162
;162:	bsptrace->ent = trace.entityNum;
ADDRFP4 0
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 0+52
INDIRI4
ASGNI4
line 163
;163:	bsptrace->exp_dist = 0;
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
CNSTF4 0
ASGNF4
line 164
;164:	bsptrace->sidenum = 0;
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 165
;165:	bsptrace->contents = 0;
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
CNSTI4 0
ASGNI4
line 166
;166:}
LABELV $117
endproc BotAI_Trace 56 28
export BotAI_GetClientState
proc BotAI_GetClientState 16 12
line 173
;167:
;168:/*
;169:==================
;170:BotAI_GetClientState
;171:==================
;172:*/
;173:int BotAI_GetClientState( int clientNum, playerState_t *state ) {
line 198
;174:	// JUHOX: let BotAI_GetClientState() accept monsters
;175:#if !MONSTER_MODE
;176:	gentity_t	*ent;
;177:
;178:	// JUHOX: a bit more safety
;179:#if 1
;180:	if (clientNum < 0 || clientNum >= level.maxclients) return qfalse;
;181:#endif
;182:
;183:	ent = &g_entities[clientNum];
;184:	if ( !ent->inuse ) {
;185:		return qfalse;
;186:	}
;187:	if ( !ent->client ) {
;188:		return qfalse;
;189:	}
;190:	if (ent->client->pers.connected != CON_CONNECTED) return qfalse;	// JUHOX: even more safety
;191:
;192:	memcpy( state, &ent->client->ps, sizeof(playerState_t) );
;193:	return qtrue;
;194:#else
;195:	gentity_t* ent;
;196:	playerState_t* ps;
;197:
;198:	if (clientNum < 0 || clientNum >= level.num_entities) return qfalse;
ADDRLP4 8
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $134
ADDRLP4 8
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $131
LABELV $134
CNSTI4 0
RETI4
ADDRGP4 $130
JUMPV
LABELV $131
line 200
;199:
;200:	ent = &g_entities[clientNum];
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 201
;201:	if (!ent->inuse) return qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $135
CNSTI4 0
RETI4
ADDRGP4 $130
JUMPV
LABELV $135
line 202
;202:	if (!ent->r.linked) return qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
CNSTI4 0
NEI4 $137
CNSTI4 0
RETI4
ADDRGP4 $130
JUMPV
LABELV $137
line 204
;203:	
;204:	ps = G_GetEntityPlayerState(ent);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 12
INDIRP4
ASGNP4
line 205
;205:	if (!ps) return qfalse;
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $139
CNSTI4 0
RETI4
ADDRGP4 $130
JUMPV
LABELV $139
line 207
;206:
;207:	memcpy(state, ps, sizeof(playerState_t));
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 468
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 208
;208:	return qtrue;
CNSTI4 1
RETI4
LABELV $130
endproc BotAI_GetClientState 16 12
export BotAI_GetEntityState
proc BotAI_GetEntityState 4 12
line 217
;209:#endif
;210:}
;211:
;212:/*
;213:==================
;214:BotAI_GetEntityState
;215:==================
;216:*/
;217:int BotAI_GetEntityState( int entityNum, entityState_t *state ) {
line 220
;218:	gentity_t	*ent;
;219:
;220:	ent = &g_entities[entityNum];
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 221
;221:	memset( state, 0, sizeof(entityState_t) );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 208
ARGI4
ADDRGP4 memset
CALLP4
pop
line 222
;222:	if (!ent->inuse) return qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $142
CNSTI4 0
RETI4
ADDRGP4 $141
JUMPV
LABELV $142
line 223
;223:	if (!ent->r.linked) return qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
CNSTI4 0
NEI4 $144
CNSTI4 0
RETI4
ADDRGP4 $141
JUMPV
LABELV $144
line 224
;224:	if (ent->r.svFlags & SVF_NOCLIENT) return qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $146
CNSTI4 0
RETI4
ADDRGP4 $141
JUMPV
LABELV $146
line 225
;225:	memcpy( state, &ent->s, sizeof(entityState_t) );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 208
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 226
;226:	return qtrue;
CNSTI4 1
RETI4
LABELV $141
endproc BotAI_GetEntityState 4 12
export BotAI_GetSnapshotEntity
proc BotAI_GetSnapshotEntity 8 12
line 234
;227:}
;228:
;229:/*
;230:==================
;231:BotAI_GetSnapshotEntity
;232:==================
;233:*/
;234:int BotAI_GetSnapshotEntity( int clientNum, int sequence, entityState_t *state ) {
line 237
;235:	int		entNum;
;236:
;237:	entNum = trap_BotGetSnapshotEntity( clientNum, sequence );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 trap_BotGetSnapshotEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 238
;238:	if ( entNum == -1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $149
line 239
;239:		memset(state, 0, sizeof(entityState_t));
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 208
ARGI4
ADDRGP4 memset
CALLP4
pop
line 240
;240:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $148
JUMPV
LABELV $149
line 243
;241:	}
;242:
;243:	BotAI_GetEntityState( entNum, state );
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 BotAI_GetEntityState
CALLI4
pop
line 245
;244:
;245:	return sequence + 1;
ADDRFP4 4
INDIRI4
CNSTI4 1
ADDI4
RETI4
LABELV $148
endproc BotAI_GetSnapshotEntity 8 12
export BotAI_BotInitialChat
proc BotAI_BotInitialChat 56 44
line 253
;246:}
;247:
;248:/*
;249:==================
;250:BotAI_BotInitialChat
;251:==================
;252:*/
;253:void QDECL BotAI_BotInitialChat( bot_state_t *bs, char *type, ... ) {
line 259
;254:	int		i, mcontext;
;255:	va_list	ap;
;256:	char	*p;
;257:	char	*vars[MAX_MATCHVARIABLES];
;258:
;259:	memset(vars, 0, sizeof(vars));
ADDRLP4 8
ARGP4
CNSTI4 0
ARGI4
CNSTI4 32
ARGI4
ADDRGP4 memset
CALLP4
pop
line 260
;260:	va_start(ap, type);
ADDRLP4 40
ADDRFP4 4+4
ASGNP4
line 261
;261:	p = va_arg(ap, char *);
ADDRLP4 48
ADDRLP4 40
INDIRP4
CNSTU4 4
ADDP4
ASGNP4
ADDRLP4 40
ADDRLP4 48
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 48
INDIRP4
CNSTI4 -4
ADDP4
INDIRP4
ASGNP4
line 262
;262:	for (i = 0; i < MAX_MATCHVARIABLES; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $153
line 263
;263:		if( !p ) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $157
line 264
;264:			break;
ADDRGP4 $155
JUMPV
LABELV $157
line 266
;265:		}
;266:		vars[i] = p;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 267
;267:		p = va_arg(ap, char *);
ADDRLP4 52
ADDRLP4 40
INDIRP4
CNSTU4 4
ADDP4
ASGNP4
ADDRLP4 40
ADDRLP4 52
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 52
INDIRP4
CNSTI4 -4
ADDP4
INDIRP4
ASGNP4
line 268
;268:	}
LABELV $154
line 262
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 8
LTI4 $153
LABELV $155
line 269
;269:	va_end(ap);
ADDRLP4 40
CNSTP4 0
ASGNP4
line 271
;270:
;271:	mcontext = BotSynonymContext(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 BotSynonymContext
CALLI4
ASGNI4
ADDRLP4 44
ADDRLP4 52
INDIRI4
ASGNI4
line 273
;272:
;273:	trap_BotInitialChat( bs->cs, type, mcontext, vars[0], vars[1], vars[2], vars[3], vars[4], vars[5], vars[6], vars[7] );
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8+4
INDIRP4
ARGP4
ADDRLP4 8+8
INDIRP4
ARGP4
ADDRLP4 8+12
INDIRP4
ARGP4
ADDRLP4 8+16
INDIRP4
ARGP4
ADDRLP4 8+20
INDIRP4
ARGP4
ADDRLP4 8+24
INDIRP4
ARGP4
ADDRLP4 8+28
INDIRP4
ARGP4
ADDRGP4 trap_BotInitialChat
CALLV
pop
line 274
;274:}
LABELV $151
endproc BotAI_BotInitialChat 56 44
export BotTestAAS
proc BotTestAAS 64 16
line 282
;275:
;276:
;277:/*
;278:==================
;279:BotTestAAS
;280:==================
;281:*/
;282:void BotTestAAS(vec3_t origin) {
line 286
;283:	int areanum;
;284:	aas_areainfo_t info;
;285:
;286:	trap_Cvar_Update(&bot_testsolid);
ADDRGP4 bot_testsolid
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 287
;287:	trap_Cvar_Update(&bot_testclusters);
ADDRGP4 bot_testclusters
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 288
;288:	if (bot_testsolid.integer) {
ADDRGP4 bot_testsolid+12
INDIRI4
CNSTI4 0
EQI4 $167
line 289
;289:		if (!trap_AAS_Initialized()) return;
ADDRLP4 56
ADDRGP4 trap_AAS_Initialized
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
NEI4 $170
ADDRGP4 $166
JUMPV
LABELV $170
line 290
;290:		areanum = BotPointAreaNum(origin);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 60
INDIRI4
ASGNI4
line 291
;291:		if (areanum) BotAI_Print(PRT_MESSAGE, "\remtpy area");
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $172
CNSTI4 1
ARGI4
ADDRGP4 $174
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
ADDRGP4 $168
JUMPV
LABELV $172
line 292
;292:		else BotAI_Print(PRT_MESSAGE, "\r^1SOLID area");
CNSTI4 1
ARGI4
ADDRGP4 $175
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 293
;293:	}
ADDRGP4 $168
JUMPV
LABELV $167
line 294
;294:	else if (bot_testclusters.integer) {
ADDRGP4 bot_testclusters+12
INDIRI4
CNSTI4 0
EQI4 $176
line 295
;295:		if (!trap_AAS_Initialized()) return;
ADDRLP4 56
ADDRGP4 trap_AAS_Initialized
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
NEI4 $179
ADDRGP4 $166
JUMPV
LABELV $179
line 296
;296:		areanum = BotPointAreaNum(origin);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 60
INDIRI4
ASGNI4
line 297
;297:		if (!areanum)
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $181
line 298
;298:			BotAI_Print(PRT_MESSAGE, "\r^1Solid!                              ");
CNSTI4 1
ARGI4
ADDRGP4 $183
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
ADDRGP4 $182
JUMPV
LABELV $181
line 299
;299:		else {
line 300
;300:			trap_AAS_AreaInfo(areanum, &info);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_AAS_AreaInfo
CALLI4
pop
line 301
;301:			BotAI_Print(PRT_MESSAGE, "\rarea %d, cluster %d       ", areanum, info.cluster);
CNSTI4 1
ARGI4
ADDRGP4 $184
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4+12
INDIRI4
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 302
;302:		}
LABELV $182
line 303
;303:	}
LABELV $176
LABELV $168
line 304
;304:}
LABELV $166
endproc BotTestAAS 64 16
bss
align 1
LABELV $187
skip 32
export BotReportStatus
code
proc BotReportStatus 808 44
line 311
;305:
;306:/*
;307:==================
;308:BotReportStatus
;309:==================
;310:*/
;311:void BotReportStatus(bot_state_t *bs) {
line 316
;312:	char goalname[MAX_MESSAGE_SIZE];
;313:	char netname[MAX_MESSAGE_SIZE];
;314:	char *leader, flagstatus[32];
;315:	//
;316:	ClientName(bs->client, netname, sizeof(netname));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 322
;317:	// JUHOX: show leader number
;318:#if 0
;319:	if (Q_stricmp(netname, bs->teamleader) == 0) leader = "L";
;320:	else leader = " ";
;321:#else
;322:	{
line 325
;323:		static char leaderbuf[32];
;324:
;325:		Com_sprintf(leaderbuf, sizeof(leaderbuf), "L%-2d", bs->leader);
ADDRGP4 $187
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $188
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 11872
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 326
;326:		leader = leaderbuf;
ADDRLP4 256
ADDRGP4 $187
ASGNP4
line 327
;327:	}
line 331
;328:#endif
;329:	// JUHOX: special debug info for dead bots
;330:#if 1
;331:	if (bs->cur_ps.stats[STAT_HEALTH] <= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
CNSTI4 0
GTI4 $189
line 332
;332:		BotAI_Print(PRT_MESSAGE, "%-20s         %s : dead\n", netname, leader);
CNSTI4 1
ARGI4
ADDRGP4 $191
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 256
INDIRP4
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 333
;333:		return;
ADDRGP4 $186
JUMPV
LABELV $189
line 337
;334:	}
;335:#endif
;336:
;337:	strcpy(flagstatus, "  ");
ADDRLP4 260
ARGP4
ADDRGP4 $192
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 338
;338:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $193
line 339
;339:		if (BotCTFCarryingFlag(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 548
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 548
INDIRI4
CNSTI4 0
EQI4 $195
line 340
;340:			if (BotTeam(bs) == TEAM_RED) strcpy(flagstatus, S_COLOR_RED"F ");
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 552
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 552
INDIRI4
CNSTI4 1
NEI4 $197
ADDRLP4 260
ARGP4
ADDRGP4 $199
ARGP4
ADDRGP4 strcpy
CALLP4
pop
ADDRGP4 $198
JUMPV
LABELV $197
line 341
;341:			else strcpy(flagstatus, S_COLOR_BLUE"F ");
ADDRLP4 260
ARGP4
ADDRGP4 $200
ARGP4
ADDRGP4 strcpy
CALLP4
pop
LABELV $198
line 342
;342:		}
LABELV $195
line 343
;343:	}
LABELV $193
line 361
;344:#ifdef MISSIONPACK
;345:	else if (gametype == GT_1FCTF) {
;346:		if (Bot1FCTFCarryingFlag(bs)) {
;347:			if (BotTeam(bs) == TEAM_RED) strcpy(flagstatus, S_COLOR_RED"F ");
;348:			else strcpy(flagstatus, S_COLOR_BLUE"F ");
;349:		}
;350:	}
;351:	else if (gametype == GT_HARVESTER) {
;352:		if (BotHarvesterCarryingCubes(bs)) {
;353:			if (BotTeam(bs) == TEAM_RED) Com_sprintf(flagstatus, sizeof(flagstatus), S_COLOR_RED"%2d", bs->inventory[INVENTORY_REDCUBE]);
;354:			else Com_sprintf(flagstatus, sizeof(flagstatus), S_COLOR_BLUE"%2d", bs->inventory[INVENTORY_BLUECUBE]);
;355:		}
;356:	}
;357:#endif
;358:
;359:	// JUHOX: add some additional info to the bot debug info
;360:#if 1
;361:	{
line 364
;362:		char buf[MAX_MESSAGE_SIZE];
;363:
;364:		Com_sprintf(buf, sizeof(buf), "%-20s H%-3dA%-3d", netname, bs->cur_ps.stats[STAT_HEALTH], bs->cur_ps.stats[STAT_ARMOR]);
ADDRLP4 548
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $201
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 804
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 804
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ARGI4
ADDRLP4 804
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 365
;365:		strcpy(netname, buf);
ADDRLP4 0
ARGP4
ADDRLP4 548
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 366
;366:	}
line 368
;367:#endif
;368:	switch(bs->ltgtype) {
ADDRLP4 548
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
ASGNI4
ADDRLP4 548
INDIRI4
CNSTI4 1
LTI4 $202
ADDRLP4 548
INDIRI4
CNSTI4 17
GTI4 $202
ADDRLP4 548
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $238-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $238
address $205
address $207
address $209
address $219
address $221
address $223
address $215
address $215
address $217
address $211
address $213
address $227
address $225
address $202
address $202
address $229
address $231
code
LABELV $205
line 370
;369:		case LTG_TEAMHELP:
;370:		{
line 371
;371:			EasyClientName(bs->teammate, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 11560
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 372
;372:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: helping %s\n", netname, leader, flagstatus, goalname);
CNSTI4 1
ARGI4
ADDRGP4 $206
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 256
INDIRP4
ARGP4
ADDRLP4 260
ARGP4
ADDRLP4 292
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 373
;373:			break;
ADDRGP4 $203
JUMPV
LABELV $207
line 376
;374:		}
;375:		case LTG_TEAMACCOMPANY:
;376:		{
line 377
;377:			EasyClientName(bs->teammate, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 11560
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 378
;378:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: accompanying %s\n", netname, leader, flagstatus, goalname);
CNSTI4 1
ARGI4
ADDRGP4 $208
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 256
INDIRP4
ARGP4
ADDRLP4 260
ARGP4
ADDRLP4 292
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 379
;379:			break;
ADDRGP4 $203
JUMPV
LABELV $209
line 382
;380:		}
;381:		case LTG_DEFENDKEYAREA:
;382:		{
line 383
;383:			trap_BotGoalName(bs->teamgoal.number, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 11624
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 384
;384:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: defending %s\n", netname, leader, flagstatus, goalname);
CNSTI4 1
ARGI4
ADDRGP4 $210
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 256
INDIRP4
ARGP4
ADDRLP4 260
ARGP4
ADDRLP4 292
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 385
;385:			break;
ADDRGP4 $203
JUMPV
LABELV $211
line 388
;386:		}
;387:		case LTG_GETITEM:
;388:		{
line 389
;389:			trap_BotGoalName(bs->teamgoal.number, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 11624
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 390
;390:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: getting item %s\n", netname, leader, flagstatus, goalname);
CNSTI4 1
ARGI4
ADDRGP4 $212
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 256
INDIRP4
ARGP4
ADDRLP4 260
ARGP4
ADDRLP4 292
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 391
;391:			break;
ADDRGP4 $203
JUMPV
LABELV $213
line 394
;392:		}
;393:		case LTG_KILL:
;394:		{
line 395
;395:			ClientName(bs->teamgoal.entitynum, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 11620
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 396
;396:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: killing %s\n", netname, leader, flagstatus, goalname);
CNSTI4 1
ARGI4
ADDRGP4 $214
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 256
INDIRP4
ARGP4
ADDRLP4 260
ARGP4
ADDRLP4 292
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 397
;397:			break;
ADDRGP4 $203
JUMPV
LABELV $215
line 401
;398:		}
;399:		case LTG_CAMP:
;400:		case LTG_CAMPORDER:
;401:		{
line 405
;402:#if 0	// JUHOX: also print camp goal
;403:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: camping\n", netname, leader, flagstatus);
;404:#else
;405:			trap_BotGoalName(bs->teamgoal.number, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 11624
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 406
;406:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: camping at %s\n", netname, leader, flagstatus, goalname);
CNSTI4 1
ARGI4
ADDRGP4 $216
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 256
INDIRP4
ARGP4
ADDRLP4 260
ARGP4
ADDRLP4 292
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 408
;407:#endif
;408:			break;
ADDRGP4 $203
JUMPV
LABELV $217
line 411
;409:		}
;410:		case LTG_PATROL:
;411:		{
line 412
;412:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: patrolling\n", netname, leader, flagstatus);
CNSTI4 1
ARGI4
ADDRGP4 $218
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 256
INDIRP4
ARGP4
ADDRLP4 260
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 413
;413:			break;
ADDRGP4 $203
JUMPV
LABELV $219
line 416
;414:		}
;415:		case LTG_GETFLAG:
;416:		{
line 417
;417:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: capturing flag\n", netname, leader, flagstatus);
CNSTI4 1
ARGI4
ADDRGP4 $220
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 256
INDIRP4
ARGP4
ADDRLP4 260
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 418
;418:			break;
ADDRGP4 $203
JUMPV
LABELV $221
line 421
;419:		}
;420:		case LTG_RUSHBASE:
;421:		{
line 422
;422:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: rushing base\n", netname, leader, flagstatus);
CNSTI4 1
ARGI4
ADDRGP4 $222
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 256
INDIRP4
ARGP4
ADDRLP4 260
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 423
;423:			break;
ADDRGP4 $203
JUMPV
LABELV $223
line 426
;424:		}
;425:		case LTG_RETURNFLAG:
;426:		{
line 427
;427:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: returning flag\n", netname, leader, flagstatus);
CNSTI4 1
ARGI4
ADDRGP4 $224
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 256
INDIRP4
ARGP4
ADDRLP4 260
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 428
;428:			break;
ADDRGP4 $203
JUMPV
LABELV $225
line 431
;429:		}
;430:		case LTG_ATTACKENEMYBASE:
;431:		{
line 432
;432:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: attacking the enemy base\n", netname, leader, flagstatus);
CNSTI4 1
ARGI4
ADDRGP4 $226
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 256
INDIRP4
ARGP4
ADDRLP4 260
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 433
;433:			break;
ADDRGP4 $203
JUMPV
LABELV $227
line 436
;434:		}
;435:		case LTG_HARVEST:
;436:		{
line 437
;437:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: harvesting\n", netname, leader, flagstatus);
CNSTI4 1
ARGI4
ADDRGP4 $228
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 256
INDIRP4
ARGP4
ADDRLP4 260
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 438
;438:			break;
ADDRGP4 $203
JUMPV
LABELV $229
line 443
;439:		}
;440:		// JUHOX: report LTG_ESCAPE
;441:#if 1
;442:		case LTG_ESCAPE:
;443:		{
line 444
;444:			trap_BotGoalName(bs->teamgoal.number, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 11624
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 445
;445:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: escaping to %s\n", netname, leader, flagstatus, goalname);
CNSTI4 1
ARGI4
ADDRGP4 $230
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 256
INDIRP4
ARGP4
ADDRLP4 260
ARGP4
ADDRLP4 292
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 446
;446:			break;
ADDRGP4 $203
JUMPV
LABELV $231
line 451
;447:		}
;448:#endif
;449:#if 1	// JUHOX: report LTG_WAIT
;450:		case LTG_WAIT:
;451:		{
line 452
;452:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: waiting\n", netname, leader, flagstatus);
CNSTI4 1
ARGI4
ADDRGP4 $232
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 256
INDIRP4
ARGP4
ADDRLP4 260
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 453
;453:			break;
ADDRGP4 $203
JUMPV
LABELV $202
line 457
;454:		}
;455:#endif
;456:		default:
;457:		{
line 463
;458:#if 0	// JUHOX: more roaming debug info
;459:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: roaming\n", netname, leader, flagstatus);
;460:#else
;461:			bot_goal_t goal;
;462:
;463:			if (trap_BotGetTopGoal(bs->gs, &goal)) {
ADDRFP4 0
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
ADDRLP4 556
ARGP4
ADDRLP4 612
ADDRGP4 trap_BotGetTopGoal
CALLI4
ASGNI4
ADDRLP4 612
INDIRI4
CNSTI4 0
EQI4 $233
line 464
;464:				trap_BotGoalName(goal.number, goalname, sizeof(goalname));
ADDRLP4 556+44
INDIRI4
ARGI4
ADDRLP4 292
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 465
;465:				BotAI_Print(PRT_MESSAGE, "%-20s%s%s: roaming to %s (ltg=%d,e=%d,r=%d,s=%d,d=%d)\n", netname, leader, flagstatus, goalname, bs->ltgtype, bs->enemy, BotWantsToRetreat(bs), bs->tfl&(TFL_LAVA|TFL_SLIME), BotPlayerDanger(&bs->cur_ps));	// JUHOX DEBUG
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 616
ADDRGP4 BotWantsToRetreat
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 620
ADDRGP4 BotPlayerDanger
CALLI4
ASGNI4
CNSTI4 1
ARGI4
ADDRGP4 $236
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 256
INDIRP4
ARGP4
ADDRLP4 260
ARGP4
ADDRLP4 292
ARGP4
ADDRLP4 624
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 624
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
ARGI4
ADDRLP4 624
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
ARGI4
ADDRLP4 616
INDIRI4
ARGI4
ADDRLP4 624
INDIRP4
CNSTI4 5984
ADDP4
INDIRI4
CNSTI4 6291456
BANDI4
ARGI4
ADDRLP4 620
INDIRI4
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 466
;466:			}
ADDRGP4 $203
JUMPV
LABELV $233
line 467
;467:			else {
line 468
;468:				BotAI_Print(PRT_MESSAGE, "%-20s%s%s: roaming (ltg=%d,e=%d,r=%d,s=%d,d=%d)\n", netname, leader, flagstatus, bs->ltgtype, bs->enemy, BotWantsToRetreat(bs), bs->tfl&(TFL_LAVA|TFL_SLIME), BotPlayerDanger(&bs->cur_ps));	// JUHOX DEBUG
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 616
ADDRGP4 BotWantsToRetreat
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 620
ADDRGP4 BotPlayerDanger
CALLI4
ASGNI4
CNSTI4 1
ARGI4
ADDRGP4 $237
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 256
INDIRP4
ARGP4
ADDRLP4 260
ARGP4
ADDRLP4 624
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 624
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
ARGI4
ADDRLP4 624
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
ARGI4
ADDRLP4 616
INDIRI4
ARGI4
ADDRLP4 624
INDIRP4
CNSTI4 5984
ADDP4
INDIRI4
CNSTI4 6291456
BANDI4
ARGI4
ADDRLP4 620
INDIRI4
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 469
;469:			}
line 471
;470:#endif
;471:			break;
LABELV $203
line 474
;472:		}
;473:	}
;474:}
LABELV $186
endproc BotReportStatus 808 44
export BotTeamplayReport
proc BotTeamplayReport 1060 12
line 481
;475:
;476:/*
;477:==================
;478:BotTeamplayReport
;479:==================
;480:*/
;481:void BotTeamplayReport(void) {
line 485
;482:	int i;
;483:	char buf[MAX_INFO_STRING];
;484:
;485:	BotAI_Print(PRT_MESSAGE, S_COLOR_RED"RED\n");
CNSTI4 1
ARGI4
ADDRGP4 $241
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 486
;486:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $245
JUMPV
LABELV $242
line 488
;487:		//
;488:		if ( !botstates[i] || !botstates[i]->inuse ) continue;
ADDRLP4 1032
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1032
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $248
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1032
INDIRP4
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $246
LABELV $248
ADDRGP4 $243
JUMPV
LABELV $246
line 490
;489:		//
;490:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
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
line 492
;491:		//if no config string or no name
;492:		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n"))) continue;
ADDRLP4 4
ARGP4
ADDRLP4 1036
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
EQI4 $252
ADDRLP4 4
ARGP4
ADDRGP4 $251
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
NEI4 $249
LABELV $252
ADDRGP4 $243
JUMPV
LABELV $249
line 494
;493:		//skip spectators
;494:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_RED) {
ADDRLP4 4
ARGP4
ADDRGP4 $255
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
CNSTI4 1
NEI4 $253
line 495
;495:			BotReportStatus(botstates[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotReportStatus
CALLV
pop
line 496
;496:		}
LABELV $253
line 497
;497:	}
LABELV $243
line 486
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $245
ADDRLP4 0
INDIRI4
ADDRGP4 maxclients
INDIRI4
GEI4 $256
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $242
LABELV $256
line 498
;498:	BotAI_Print(PRT_MESSAGE, S_COLOR_BLUE"BLUE\n");
CNSTI4 1
ARGI4
ADDRGP4 $257
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 499
;499:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $261
JUMPV
LABELV $258
line 501
;500:		//
;501:		if ( !botstates[i] || !botstates[i]->inuse ) continue;
ADDRLP4 1036
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1036
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $264
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1036
INDIRP4
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $262
LABELV $264
ADDRGP4 $259
JUMPV
LABELV $262
line 503
;502:		//
;503:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
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
line 505
;504:		//if no config string or no name
;505:		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n"))) continue;
ADDRLP4 4
ARGP4
ADDRLP4 1040
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
EQI4 $267
ADDRLP4 4
ARGP4
ADDRGP4 $251
ARGP4
ADDRLP4 1044
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1044
INDIRP4
ARGP4
ADDRLP4 1048
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $265
LABELV $267
ADDRGP4 $259
JUMPV
LABELV $265
line 507
;506:		//skip spectators
;507:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_BLUE) {
ADDRLP4 4
ARGP4
ADDRGP4 $255
ARGP4
ADDRLP4 1052
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1052
INDIRP4
ARGP4
ADDRLP4 1056
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 2
NEI4 $268
line 508
;508:			BotReportStatus(botstates[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotReportStatus
CALLV
pop
line 509
;509:		}
LABELV $268
line 510
;510:	}
LABELV $259
line 499
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $261
ADDRLP4 0
INDIRI4
ADDRGP4 maxclients
INDIRI4
GEI4 $270
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $258
LABELV $270
line 511
;511:}
LABELV $240
endproc BotTeamplayReport 1060 12
export BotSetInfoConfigString
proc BotSetInfoConfigString 880 16
line 518
;512:
;513:/*
;514:==================
;515:BotSetInfoConfigString
;516:==================
;517:*/
;518:void BotSetInfoConfigString(bot_state_t *bs) {
line 525
;519:	char goalname[MAX_MESSAGE_SIZE];
;520:	char netname[MAX_MESSAGE_SIZE];
;521:	char action[MAX_MESSAGE_SIZE];
;522:	char *leader, carrying[32], *cs;
;523:	bot_goal_t goal;
;524:	//
;525:	ClientName(bs->client, netname, sizeof(netname));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 288
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 526
;526:	if (/*Q_stricmp(netname, bs->teamleader) == 0*/bs->leader == bs->client) leader = "L";	// JUHOX
ADDRLP4 864
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 864
INDIRP4
CNSTI4 11872
ADDP4
INDIRI4
ADDRLP4 864
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $272
ADDRLP4 544
ADDRGP4 $274
ASGNP4
ADDRGP4 $273
JUMPV
LABELV $272
line 527
;527:	else leader = " ";
ADDRLP4 544
ADDRGP4 $275
ASGNP4
LABELV $273
line 529
;528:
;529:	strcpy(carrying, "  ");
ADDRLP4 256
ARGP4
ADDRGP4 $192
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 530
;530:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $276
line 531
;531:		if (BotCTFCarryingFlag(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 868
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 868
INDIRI4
CNSTI4 0
EQI4 $278
line 532
;532:			strcpy(carrying, "F ");
ADDRLP4 256
ARGP4
ADDRGP4 $280
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 533
;533:		}
LABELV $278
line 534
;534:	}
LABELV $276
line 549
;535:#ifdef MISSIONPACK
;536:	else if (gametype == GT_1FCTF) {
;537:		if (Bot1FCTFCarryingFlag(bs)) {
;538:			strcpy(carrying, "F ");
;539:		}
;540:	}
;541:	else if (gametype == GT_HARVESTER) {
;542:		if (BotHarvesterCarryingCubes(bs)) {
;543:			if (BotTeam(bs) == TEAM_RED) Com_sprintf(carrying, sizeof(carrying), "%2d", bs->inventory[INVENTORY_REDCUBE]);
;544:			else Com_sprintf(carrying, sizeof(carrying), "%2d", bs->inventory[INVENTORY_BLUECUBE]);
;545:		}
;546:	}
;547:#endif
;548:
;549:	switch(bs->ltgtype) {
ADDRLP4 868
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
ASGNI4
ADDRLP4 868
INDIRI4
CNSTI4 1
LTI4 $281
ADDRLP4 868
INDIRI4
CNSTI4 13
GTI4 $281
ADDRLP4 868
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $310-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $310
address $284
address $286
address $288
address $298
address $300
address $302
address $294
address $294
address $296
address $290
address $292
address $306
address $304
code
LABELV $284
line 551
;550:		case LTG_TEAMHELP:
;551:		{
line 552
;552:			EasyClientName(bs->teammate, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 11560
ADDP4
INDIRI4
ARGI4
ADDRLP4 552
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 553
;553:			Com_sprintf(action, sizeof(action), "helping %s", goalname);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $285
ARGP4
ADDRLP4 552
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 554
;554:			break;
ADDRGP4 $282
JUMPV
LABELV $286
line 557
;555:		}
;556:		case LTG_TEAMACCOMPANY:
;557:		{
line 558
;558:			EasyClientName(bs->teammate, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 11560
ADDP4
INDIRI4
ARGI4
ADDRLP4 552
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 559
;559:			Com_sprintf(action, sizeof(action), "accompanying %s", goalname);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $287
ARGP4
ADDRLP4 552
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 560
;560:			break;
ADDRGP4 $282
JUMPV
LABELV $288
line 563
;561:		}
;562:		case LTG_DEFENDKEYAREA:
;563:		{
line 564
;564:			trap_BotGoalName(bs->teamgoal.number, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 11624
ADDP4
INDIRI4
ARGI4
ADDRLP4 552
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 565
;565:			Com_sprintf(action, sizeof(action), "defending %s", goalname);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $289
ARGP4
ADDRLP4 552
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 566
;566:			break;
ADDRGP4 $282
JUMPV
LABELV $290
line 569
;567:		}
;568:		case LTG_GETITEM:
;569:		{
line 570
;570:			trap_BotGoalName(bs->teamgoal.number, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 11624
ADDP4
INDIRI4
ARGI4
ADDRLP4 552
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 571
;571:			Com_sprintf(action, sizeof(action), "getting item %s", goalname);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $291
ARGP4
ADDRLP4 552
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 572
;572:			break;
ADDRGP4 $282
JUMPV
LABELV $292
line 575
;573:		}
;574:		case LTG_KILL:
;575:		{
line 576
;576:			ClientName(bs->teamgoal.entitynum, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 11620
ADDP4
INDIRI4
ARGI4
ADDRLP4 552
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 577
;577:			Com_sprintf(action, sizeof(action), "killing %s", goalname);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $293
ARGP4
ADDRLP4 552
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 578
;578:			break;
ADDRGP4 $282
JUMPV
LABELV $294
line 582
;579:		}
;580:		case LTG_CAMP:
;581:		case LTG_CAMPORDER:
;582:		{
line 583
;583:			Com_sprintf(action, sizeof(action), "camping");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $295
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 584
;584:			break;
ADDRGP4 $282
JUMPV
LABELV $296
line 587
;585:		}
;586:		case LTG_PATROL:
;587:		{
line 588
;588:			Com_sprintf(action, sizeof(action), "patrolling");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $297
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 589
;589:			break;
ADDRGP4 $282
JUMPV
LABELV $298
line 592
;590:		}
;591:		case LTG_GETFLAG:
;592:		{
line 593
;593:			Com_sprintf(action, sizeof(action), "capturing flag");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $299
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 594
;594:			break;
ADDRGP4 $282
JUMPV
LABELV $300
line 597
;595:		}
;596:		case LTG_RUSHBASE:
;597:		{
line 598
;598:			Com_sprintf(action, sizeof(action), "rushing base");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $301
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 599
;599:			break;
ADDRGP4 $282
JUMPV
LABELV $302
line 602
;600:		}
;601:		case LTG_RETURNFLAG:
;602:		{
line 603
;603:			Com_sprintf(action, sizeof(action), "returning flag");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $303
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 604
;604:			break;
ADDRGP4 $282
JUMPV
LABELV $304
line 607
;605:		}
;606:		case LTG_ATTACKENEMYBASE:
;607:		{
line 608
;608:			Com_sprintf(action, sizeof(action), "attacking the enemy base");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $305
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 609
;609:			break;
ADDRGP4 $282
JUMPV
LABELV $306
line 612
;610:		}
;611:		case LTG_HARVEST:
;612:		{
line 613
;613:			Com_sprintf(action, sizeof(action), "harvesting");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $307
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 614
;614:			break;
ADDRGP4 $282
JUMPV
LABELV $281
line 617
;615:		}
;616:		default:
;617:		{
line 618
;618:			trap_BotGetTopGoal(bs->gs, &goal);
ADDRFP4 0
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
ADDRLP4 808
ARGP4
ADDRGP4 trap_BotGetTopGoal
CALLI4
pop
line 619
;619:			trap_BotGoalName(goal.number, goalname, sizeof(goalname));
ADDRLP4 808+44
INDIRI4
ARGI4
ADDRLP4 552
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 620
;620:			Com_sprintf(action, sizeof(action), "roaming %s", goalname);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $309
ARGP4
ADDRLP4 552
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 621
;621:			break;
LABELV $282
line 624
;622:		}
;623:	}
;624:  	cs = va("l\\%s\\c\\%s\\a\\%s",
ADDRGP4 $312
ARGP4
ADDRLP4 544
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 876
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 548
ADDRLP4 876
INDIRP4
ASGNP4
line 628
;625:				leader,
;626:				carrying,
;627:				action);
;628:  	trap_SetConfigstring (CS_BOTINFO + bs->client, cs);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 25
ADDI4
ARGI4
ADDRLP4 548
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 629
;629:}
LABELV $271
endproc BotSetInfoConfigString 880 16
export BotUpdateInfoConfigStrings
proc BotUpdateInfoConfigStrings 1048 12
line 636
;630:
;631:/*
;632:==============
;633:BotUpdateInfoConfigStrings
;634:==============
;635:*/
;636:void BotUpdateInfoConfigStrings(void) {
line 640
;637:	int i;
;638:	char buf[MAX_INFO_STRING];
;639:
;640:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $317
JUMPV
LABELV $314
line 642
;641:		//
;642:		if ( !botstates[i] || !botstates[i]->inuse )
ADDRLP4 1032
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1032
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $320
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1032
INDIRP4
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $318
LABELV $320
line 643
;643:			continue;
ADDRGP4 $315
JUMPV
LABELV $318
line 645
;644:		//
;645:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
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
line 647
;646:		//if no config string or no name
;647:		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n")))
ADDRLP4 4
ARGP4
ADDRLP4 1036
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
EQI4 $323
ADDRLP4 4
ARGP4
ADDRGP4 $251
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
NEI4 $321
LABELV $323
line 648
;648:			continue;
ADDRGP4 $315
JUMPV
LABELV $321
line 649
;649:		BotSetInfoConfigString(botstates[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotSetInfoConfigString
CALLV
pop
line 650
;650:	}
LABELV $315
line 640
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $317
ADDRLP4 0
INDIRI4
ADDRGP4 maxclients
INDIRI4
GEI4 $324
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $314
LABELV $324
line 651
;651:}
LABELV $313
endproc BotUpdateInfoConfigStrings 1048 12
export BotInterbreedBots
proc BotInterbreedBots 288 20
line 658
;652:
;653:/*
;654:==============
;655:BotInterbreedBots
;656:==============
;657:*/
;658:void BotInterbreedBots(void) {
line 664
;659:	float ranks[MAX_CLIENTS];
;660:	int parent1, parent2, child;
;661:	int i;
;662:
;663:	// get rankings for all the bots
;664:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $326
line 665
;665:		if ( botstates[i] && botstates[i]->inuse ) {
ADDRLP4 276
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 276
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $330
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 276
INDIRP4
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $330
line 666
;666:			ranks[i] = botstates[i]->num_kills * 2 - botstates[i]->num_deaths;
ADDRLP4 284
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 284
INDIRP4
ADDP4
INDIRP4
CNSTI4 6052
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 284
INDIRP4
ADDP4
INDIRP4
CNSTI4 6048
ADDP4
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 667
;667:		}
ADDRGP4 $331
JUMPV
LABELV $330
line 668
;668:		else {
line 669
;669:			ranks[i] = -1;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 3212836864
ASGNF4
line 670
;670:		}
LABELV $331
line 671
;671:	}
LABELV $327
line 664
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $326
line 673
;672:
;673:	if (trap_GeneticParentsAndChildSelection(MAX_CLIENTS, ranks, &parent1, &parent2, &child)) {
CNSTI4 64
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 264
ARGP4
ADDRLP4 268
ARGP4
ADDRLP4 260
ARGP4
ADDRLP4 272
ADDRGP4 trap_GeneticParentsAndChildSelection
CALLI4
ASGNI4
ADDRLP4 272
INDIRI4
CNSTI4 0
EQI4 $332
line 674
;674:		trap_BotInterbreedGoalFuzzyLogic(botstates[parent1]->gs, botstates[parent2]->gs, botstates[child]->gs);
ADDRLP4 276
ADDRGP4 botstates
ASGNP4
ADDRLP4 264
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 276
INDIRP4
ADDP4
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
ADDRLP4 268
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 276
INDIRP4
ADDP4
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 276
INDIRP4
ADDP4
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotInterbreedGoalFuzzyLogic
CALLV
pop
line 675
;675:		trap_BotMutateGoalFuzzyLogic(botstates[child]->gs, 1);
ADDRLP4 260
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_BotMutateGoalFuzzyLogic
CALLV
pop
line 676
;676:	}
LABELV $332
line 678
;677:	// reset the kills and deaths
;678:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $334
line 679
;679:		if (botstates[i] && botstates[i]->inuse) {
ADDRLP4 280
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 280
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $338
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 280
INDIRP4
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $338
line 680
;680:			botstates[i]->num_kills = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 6052
ADDP4
CNSTI4 0
ASGNI4
line 681
;681:			botstates[i]->num_deaths = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 6048
ADDP4
CNSTI4 0
ASGNI4
line 682
;682:		}
LABELV $338
line 683
;683:	}
LABELV $335
line 678
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $334
line 684
;684:}
LABELV $325
endproc BotInterbreedBots 288 20
export BotWriteInterbreeded
proc BotWriteInterbreeded 32 8
line 691
;685:
;686:/*
;687:==============
;688:BotWriteInterbreeded
;689:==============
;690:*/
;691:void BotWriteInterbreeded(char *filename) {
line 695
;692:	float rank, bestrank;
;693:	int i, bestbot;
;694:
;695:	bestrank = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 696
;696:	bestbot = -1;
ADDRLP4 12
CNSTI4 -1
ASGNI4
line 698
;697:	// get the best bot
;698:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $341
line 699
;699:		if ( botstates[i] && botstates[i]->inuse ) {
ADDRLP4 20
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $345
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
INDIRP4
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $345
line 700
;700:			rank = botstates[i]->num_kills * 2 - botstates[i]->num_deaths;
ADDRLP4 28
ADDRGP4 botstates
ASGNP4
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 28
INDIRP4
ADDP4
INDIRP4
CNSTI4 6052
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 28
INDIRP4
ADDP4
INDIRP4
CNSTI4 6048
ADDP4
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 701
;701:		}
ADDRGP4 $346
JUMPV
LABELV $345
line 702
;702:		else {
line 703
;703:			rank = -1;
ADDRLP4 4
CNSTF4 3212836864
ASGNF4
line 704
;704:		}
LABELV $346
line 705
;705:		if (rank > bestrank) {
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $347
line 706
;706:			bestrank = rank;
ADDRLP4 8
ADDRLP4 4
INDIRF4
ASGNF4
line 707
;707:			bestbot = i;
ADDRLP4 12
ADDRLP4 0
INDIRI4
ASGNI4
line 708
;708:		}
LABELV $347
line 709
;709:	}
LABELV $342
line 698
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $341
line 710
;710:	if (bestbot >= 0) {
ADDRLP4 12
INDIRI4
CNSTI4 0
LTI4 $349
line 712
;711:		//write out the new goal fuzzy logic
;712:		trap_BotSaveGoalFuzzyLogic(botstates[bestbot]->gs, filename);
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_BotSaveGoalFuzzyLogic
CALLV
pop
line 713
;713:	}
LABELV $349
line 714
;714:}
LABELV $340
endproc BotWriteInterbreeded 32 8
export BotInterbreedEndMatch
proc BotInterbreedEndMatch 8 8
line 723
;715:
;716:/*
;717:==============
;718:BotInterbreedEndMatch
;719:
;720:add link back into ExitLevel?
;721:==============
;722:*/
;723:void BotInterbreedEndMatch(void) {
line 725
;724:
;725:	if (!bot_interbreed) return;
ADDRGP4 bot_interbreed
INDIRI4
CNSTI4 0
NEI4 $352
ADDRGP4 $351
JUMPV
LABELV $352
line 726
;726:	bot_interbreedmatchcount++;
ADDRLP4 0
ADDRGP4 bot_interbreedmatchcount
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 727
;727:	if (bot_interbreedmatchcount >= bot_interbreedcycle.integer) {
ADDRGP4 bot_interbreedmatchcount
INDIRI4
ADDRGP4 bot_interbreedcycle+12
INDIRI4
LTI4 $354
line 728
;728:		bot_interbreedmatchcount = 0;
ADDRGP4 bot_interbreedmatchcount
CNSTI4 0
ASGNI4
line 730
;729:		//
;730:		trap_Cvar_Update(&bot_interbreedwrite);
ADDRGP4 bot_interbreedwrite
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 731
;731:		if (strlen(bot_interbreedwrite.string)) {
ADDRGP4 bot_interbreedwrite+16
ARGP4
ADDRLP4 4
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $357
line 732
;732:			BotWriteInterbreeded(bot_interbreedwrite.string);
ADDRGP4 bot_interbreedwrite+16
ARGP4
ADDRGP4 BotWriteInterbreeded
CALLV
pop
line 733
;733:			trap_Cvar_Set("bot_interbreedwrite", "");
ADDRGP4 $361
ARGP4
ADDRGP4 $362
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 734
;734:		}
LABELV $357
line 735
;735:		BotInterbreedBots();
ADDRGP4 BotInterbreedBots
CALLV
pop
line 736
;736:	}
LABELV $354
line 737
;737:}
LABELV $351
endproc BotInterbreedEndMatch 8 8
export BotInterbreeding
proc BotInterbreeding 16 20
line 744
;738:
;739:/*
;740:==============
;741:BotInterbreeding
;742:==============
;743:*/
;744:void BotInterbreeding(void) {
line 747
;745:	int i;
;746:
;747:	trap_Cvar_Update(&bot_interbreedchar);
ADDRGP4 bot_interbreedchar
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 748
;748:	if (!strlen(bot_interbreedchar.string)) return;
ADDRGP4 bot_interbreedchar+16
ARGP4
ADDRLP4 4
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $364
ADDRGP4 $363
JUMPV
LABELV $364
line 750
;749:	//make sure we are in tournament mode
;750:	if (gametype != GT_TOURNAMENT) {
ADDRGP4 gametype
INDIRI4
CNSTI4 1
EQI4 $367
line 751
;751:		trap_Cvar_Set("g_gametype", va("%d", GT_TOURNAMENT));
ADDRGP4 $370
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $369
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 752
;752:		ExitLevel();
ADDRGP4 ExitLevel
CALLV
pop
line 753
;753:		return;
ADDRGP4 $363
JUMPV
LABELV $367
line 756
;754:	}
;755:	//shutdown all the bots
;756:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $371
line 757
;757:		if (botstates[i] && botstates[i]->inuse) {
ADDRLP4 12
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $375
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $375
line 758
;758:			BotAIShutdownClient(botstates[i]->client, qfalse);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 BotAIShutdownClient
CALLI4
pop
line 759
;759:		}
LABELV $375
line 760
;760:	}
LABELV $372
line 756
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $371
line 762
;761:	//make sure all item weight configs are reloaded and Not shared
;762:	trap_BotLibVarSet("bot_reloadcharacters", "1");
ADDRGP4 $377
ARGP4
ADDRGP4 $378
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 764
;763:	//add a number of bots using the desired bot character
;764:	for (i = 0; i < bot_interbreedbots.integer; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $382
JUMPV
LABELV $379
line 765
;765:		trap_SendConsoleCommand( EXEC_INSERT, va("addbot %s 4 free %i %s%d\n",
ADDRGP4 $384
ARGP4
ADDRGP4 bot_interbreedchar+16
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 50
MULI4
ARGI4
ADDRGP4 bot_interbreedchar+16
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 1
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 767
;766:						bot_interbreedchar.string, i * 50, bot_interbreedchar.string, i) );
;767:	}
LABELV $380
line 764
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $382
ADDRLP4 0
INDIRI4
ADDRGP4 bot_interbreedbots+12
INDIRI4
LTI4 $379
line 769
;768:	//
;769:	trap_Cvar_Set("bot_interbreedchar", "");
ADDRGP4 $387
ARGP4
ADDRGP4 $362
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 770
;770:	bot_interbreed = qtrue;
ADDRGP4 bot_interbreed
CNSTI4 1
ASGNI4
line 771
;771:}
LABELV $363
endproc BotInterbreeding 16 20
export BotEntityInfo
proc BotEntityInfo 0 8
line 778
;772:
;773:/*
;774:==============
;775:BotEntityInfo
;776:==============
;777:*/
;778:void BotEntityInfo(int entnum, aas_entityinfo_t *info) {
line 779
;779:	trap_AAS_EntityInfo(entnum, info);
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_AAS_EntityInfo
CALLV
pop
line 780
;780:}
LABELV $388
endproc BotEntityInfo 0 8
export NumBots
proc NumBots 0 0
line 787
;781:
;782:/*
;783:==============
;784:NumBots
;785:==============
;786:*/
;787:int NumBots(void) {
line 788
;788:	return numbots;
ADDRGP4 numbots
INDIRI4
RETI4
LABELV $389
endproc NumBots 0 0
export BotReactionTime
proc BotReactionTime 12 16
line 814
;789:}
;790:
;791:/*
;792:==============
;793:BotTeamLeader
;794:==============
;795:*/
;796:#if 0	// JUHOX: BotTeamLeader() no longer needed
;797:int BotTeamLeader(bot_state_t *bs) {
;798:	int leader;
;799:
;800:	leader = /*ClientFromName(bs->teamleader)*/bs->leader;	// JUHOX
;801:	if (leader < 0) return qfalse;
;802:	if (!botstates[leader] || !botstates[leader]->inuse) return qfalse;
;803:	return qtrue;
;804:}
;805:#endif
;806:
;807:/*
;808:==============
;809:JUHOX: BotReactionTime
;810:
;811:corrects those crazy reaction time values from the bot files
;812:==============
;813:*/
;814:float BotReactionTime(bot_state_t* bs) {
line 817
;815:	float reactiontime;
;816:
;817:	reactiontime = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_REACTIONTIME, 0, 4);
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 6
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1082130432
ARGF4
ADDRLP4 4
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 818
;818:	reactiontime = 0.1f + 0.05625f * reactiontime * reactiontime;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1030121062
MULF4
ADDRLP4 0
INDIRF4
MULF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 819
;819:	if (bs->settings.arenaLord) {
ADDRFP4 0
INDIRP4
CNSTI4 4900
ADDP4
INDIRI4
CNSTI4 0
EQI4 $391
line 820
;820:		reactiontime *= 0.8f;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 821
;821:		if (reactiontime > 0.3f) reactiontime = 0.3f;
ADDRLP4 0
INDIRF4
CNSTF4 1050253722
LEF4 $393
ADDRLP4 0
CNSTF4 1050253722
ASGNF4
LABELV $393
line 822
;822:	}
LABELV $391
line 823
;823:	return reactiontime;
ADDRLP4 0
INDIRF4
RETF4
LABELV $390
endproc BotReactionTime 12 16
proc BotViewReaction 120 12
line 831
;824:}
;825:
;826:/*
;827:==============
;828:JUHOX: BotViewReaction
;829:==============
;830:*/
;831:static void BotViewReaction(bot_state_t* bs, vec3_t perceivedViewDistortion) {
line 842
;832:	vec3_t diff;
;833:	float currenttime, reactiontime;
;834:	float upper_timelimit, lower_timelimit, besttime;
;835:	int bestentry, numentries;
;836:	vec3_t avgAngles, avgPrcvAngles;
;837:	float upper_timelimit2, lower_timelimit2;
;838:	int numentries2;
;839:	vec3_t avgAngles2;
;840:	int i;
;841:
;842:	currenttime = FloatTime();
ADDRLP4 80
ADDRGP4 floattime
INDIRF4
ASGNF4
line 843
;843:	if (bs->viewhistory.lastUpdateTime <= currenttime - 0.02) {
ADDRFP4 0
INDIRP4
CNSTI4 7912
ADDP4
INDIRF4
ADDRLP4 80
INDIRF4
CNSTF4 1017370378
SUBF4
GTF4 $396
line 844
;844:		bs->viewhistory.lastUpdateTime = currenttime;
ADDRFP4 0
INDIRP4
CNSTI4 7912
ADDP4
ADDRLP4 80
INDIRF4
ASGNF4
line 847
;845:
;846:		// save viewangles
;847:		bs->viewhistory.entryTab[bs->viewhistory.oldestEntry].time = currenttime;
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 7916
ADDP4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 92
INDIRP4
CNSTI4 7920
ADDP4
ADDP4
ADDRLP4 80
INDIRF4
ASGNF4
line 848
;848:		VectorCopy(bs->ideal_viewangles, bs->viewhistory.entryTab[bs->viewhistory.oldestEntry].ideal_view);
ADDRLP4 96
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CNSTI4 7916
ADDP4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 96
INDIRP4
CNSTI4 7920
ADDP4
ADDP4
CNSTI4 4
ADDP4
ADDRLP4 96
INDIRP4
CNSTI4 7852
ADDP4
INDIRB
ASGNB 12
line 849
;849:		VectorSubtract(bs->viewangles, bs->viewhistory.lastviewcommand, diff);
ADDRLP4 100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 100
INDIRP4
CNSTI4 7840
ADDP4
INDIRF4
ADDRLP4 100
INDIRP4
CNSTI4 7888
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 100
INDIRP4
CNSTI4 7844
ADDP4
INDIRF4
ADDRLP4 100
INDIRP4
CNSTI4 7892
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 104
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4+8
ADDRLP4 104
INDIRP4
CNSTI4 7848
ADDP4
INDIRF4
ADDRLP4 104
INDIRP4
CNSTI4 7896
ADDP4
INDIRF4
SUBF4
ASGNF4
line 850
;850:		VectorCopy(diff, bs->viewhistory.entryTab[bs->viewhistory.oldestEntry].viewdistortion);
ADDRLP4 108
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 108
INDIRP4
CNSTI4 7916
ADDP4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 108
INDIRP4
CNSTI4 7920
ADDP4
ADDP4
CNSTI4 16
ADDP4
ADDRLP4 4
INDIRB
ASGNB 12
line 851
;851:		bs->viewhistory.oldestEntry++;
ADDRLP4 112
ADDRFP4 0
INDIRP4
CNSTI4 7916
ADDP4
ASGNP4
ADDRLP4 112
INDIRP4
ADDRLP4 112
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 852
;852:		if (bs->viewhistory.oldestEntry >= VIEWHISTORY_SIZE) bs->viewhistory.oldestEntry = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7916
ADDP4
INDIRI4
CNSTI4 128
LTI4 $400
ADDRFP4 0
INDIRP4
CNSTI4 7916
ADDP4
CNSTI4 0
ASGNI4
LABELV $400
line 853
;853:	}
LABELV $396
line 855
;854:
;855:	reactiontime = 0.5 * bs->reactiontime;
ADDRLP4 88
ADDRFP4 0
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 856
;856:	upper_timelimit = currenttime;
ADDRLP4 56
ADDRLP4 80
INDIRF4
ASGNF4
line 857
;857:	lower_timelimit = upper_timelimit - 2 * reactiontime;
ADDRLP4 72
ADDRLP4 56
INDIRF4
ADDRLP4 88
INDIRF4
CNSTF4 1073741824
MULF4
SUBF4
ASGNF4
line 862
;858:	/*
;859:	upper_timelimit2 = currenttime - reactiontime;
;860:	lower_timelimit2 = upper_timelimit2 - 2 * reactiontime;
;861:	*/
;862:	upper_timelimit2 = currenttime;
ADDRLP4 60
ADDRLP4 80
INDIRF4
ASGNF4
line 863
;863:	lower_timelimit2 = upper_timelimit2 - 4 * reactiontime;
ADDRLP4 76
ADDRLP4 60
INDIRF4
ADDRLP4 88
INDIRF4
CNSTF4 1082130432
MULF4
SUBF4
ASGNF4
line 865
;864:
;865:	besttime = 0;
ADDRLP4 68
CNSTF4 0
ASGNF4
line 866
;866:	bestentry = -1;
ADDRLP4 84
CNSTI4 -1
ASGNI4
line 867
;867:	VectorClear(avgAngles);
ADDRLP4 92
CNSTF4 0
ASGNF4
ADDRLP4 16+8
ADDRLP4 92
INDIRF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 92
INDIRF4
ASGNF4
ADDRLP4 16
ADDRLP4 92
INDIRF4
ASGNF4
line 868
;868:	VectorClear(avgPrcvAngles);
ADDRLP4 96
CNSTF4 0
ASGNF4
ADDRLP4 28+8
ADDRLP4 96
INDIRF4
ASGNF4
ADDRLP4 28+4
ADDRLP4 96
INDIRF4
ASGNF4
ADDRLP4 28
ADDRLP4 96
INDIRF4
ASGNF4
line 869
;869:	VectorClear(avgAngles2);
ADDRLP4 100
CNSTF4 0
ASGNF4
ADDRLP4 40+8
ADDRLP4 100
INDIRF4
ASGNF4
ADDRLP4 40+4
ADDRLP4 100
INDIRF4
ASGNF4
ADDRLP4 40
ADDRLP4 100
INDIRF4
ASGNF4
line 870
;870:	numentries = numentries2 = 0;
ADDRLP4 104
CNSTI4 0
ASGNI4
ADDRLP4 64
ADDRLP4 104
INDIRI4
ASGNI4
ADDRLP4 52
ADDRLP4 104
INDIRI4
ASGNI4
line 871
;871:	for (i = 0; i < VIEWHISTORY_SIZE; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $408
line 874
;872:		float t;
;873:
;874:		t = bs->viewhistory.entryTab[i].time;
ADDRLP4 108
ADDRLP4 0
INDIRI4
CNSTI4 28
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7920
ADDP4
ADDP4
INDIRF4
ASGNF4
line 875
;875:		if (t <= upper_timelimit) {
ADDRLP4 108
INDIRF4
ADDRLP4 56
INDIRF4
GTF4 $412
line 876
;876:			if (t > besttime) {
ADDRLP4 108
INDIRF4
ADDRLP4 68
INDIRF4
LEF4 $414
line 877
;877:				besttime = t;
ADDRLP4 68
ADDRLP4 108
INDIRF4
ASGNF4
line 878
;878:				bestentry = i;
ADDRLP4 84
ADDRLP4 0
INDIRI4
ASGNI4
line 879
;879:			}
LABELV $414
line 880
;880:			if (t >= lower_timelimit) {
ADDRLP4 108
INDIRF4
ADDRLP4 72
INDIRF4
LTF4 $416
line 881
;881:				numentries++;
ADDRLP4 52
ADDRLP4 52
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 882
;882:				AnglesSubtract(bs->viewhistory.entryTab[i].ideal_view, avgAngles, diff);
ADDRLP4 0
INDIRI4
CNSTI4 28
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7920
ADDP4
ADDP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 AnglesSubtract
CALLV
pop
line 883
;883:				VectorMA(avgAngles, 1.0 / numentries, diff, avgAngles);
ADDRLP4 112
ADDRLP4 52
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 16
ADDRLP4 16
INDIRF4
ADDRLP4 4
INDIRF4
CNSTF4 1065353216
ADDRLP4 112
INDIRF4
DIVF4
MULF4
ADDF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 16+4
INDIRF4
ADDRLP4 4+4
INDIRF4
CNSTF4 1065353216
ADDRLP4 112
INDIRF4
DIVF4
MULF4
ADDF4
ASGNF4
ADDRLP4 16+8
ADDRLP4 16+8
INDIRF4
ADDRLP4 4+8
INDIRF4
CNSTF4 1065353216
ADDRLP4 52
INDIRI4
CVIF4 4
DIVF4
MULF4
ADDF4
ASGNF4
line 885
;884:
;885:				AnglesSubtract(bs->viewhistory.entryTab[i].viewdistortion, avgPrcvAngles, diff);
ADDRLP4 0
INDIRI4
CNSTI4 28
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7920
ADDP4
ADDP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 28
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 AnglesSubtract
CALLV
pop
line 886
;886:				VectorMA(avgPrcvAngles, 1.0 / numentries, diff, avgPrcvAngles);
ADDRLP4 116
ADDRLP4 52
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 28
ADDRLP4 28
INDIRF4
ADDRLP4 4
INDIRF4
CNSTF4 1065353216
ADDRLP4 116
INDIRF4
DIVF4
MULF4
ADDF4
ASGNF4
ADDRLP4 28+4
ADDRLP4 28+4
INDIRF4
ADDRLP4 4+4
INDIRF4
CNSTF4 1065353216
ADDRLP4 116
INDIRF4
DIVF4
MULF4
ADDF4
ASGNF4
ADDRLP4 28+8
ADDRLP4 28+8
INDIRF4
ADDRLP4 4+8
INDIRF4
CNSTF4 1065353216
ADDRLP4 52
INDIRI4
CVIF4 4
DIVF4
MULF4
ADDF4
ASGNF4
line 887
;887:			}
LABELV $416
line 888
;888:		}
LABELV $412
line 889
;889:		if (t <= upper_timelimit2) {
ADDRLP4 108
INDIRF4
ADDRLP4 60
INDIRF4
GTF4 $430
line 890
;890:			if (t >= lower_timelimit2) {
ADDRLP4 108
INDIRF4
ADDRLP4 76
INDIRF4
LTF4 $432
line 891
;891:				numentries2++;
ADDRLP4 64
ADDRLP4 64
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 892
;892:				AnglesSubtract(bs->viewhistory.entryTab[i].ideal_view, avgAngles2, diff);
ADDRLP4 0
INDIRI4
CNSTI4 28
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7920
ADDP4
ADDP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 40
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 AnglesSubtract
CALLV
pop
line 893
;893:				VectorMA(avgAngles2, 1.0 / numentries2, diff, avgAngles2);
ADDRLP4 112
ADDRLP4 64
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 40
ADDRLP4 40
INDIRF4
ADDRLP4 4
INDIRF4
CNSTF4 1065353216
ADDRLP4 112
INDIRF4
DIVF4
MULF4
ADDF4
ASGNF4
ADDRLP4 40+4
ADDRLP4 40+4
INDIRF4
ADDRLP4 4+4
INDIRF4
CNSTF4 1065353216
ADDRLP4 112
INDIRF4
DIVF4
MULF4
ADDF4
ASGNF4
ADDRLP4 40+8
ADDRLP4 40+8
INDIRF4
ADDRLP4 4+8
INDIRF4
CNSTF4 1065353216
ADDRLP4 64
INDIRI4
CVIF4 4
DIVF4
MULF4
ADDF4
ASGNF4
line 894
;894:			}
LABELV $432
line 895
;895:		}
LABELV $430
line 896
;896:	}
LABELV $409
line 871
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 128
LTI4 $408
line 897
;897:	if (numentries <= 0) {
ADDRLP4 52
INDIRI4
CNSTI4 0
GTI4 $440
line 898
;898:		if (bestentry >= 0) {
ADDRLP4 84
INDIRI4
CNSTI4 0
LTI4 $442
line 899
;899:			VectorCopy(bs->viewhistory.entryTab[bestentry].ideal_view, avgAngles);
ADDRLP4 16
ADDRLP4 84
INDIRI4
CNSTI4 28
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7920
ADDP4
ADDP4
CNSTI4 4
ADDP4
INDIRB
ASGNB 12
line 900
;900:			VectorCopy(bs->viewhistory.entryTab[bestentry].viewdistortion, avgPrcvAngles);
ADDRLP4 28
ADDRLP4 84
INDIRI4
CNSTI4 28
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7920
ADDP4
ADDP4
CNSTI4 16
ADDP4
INDIRB
ASGNB 12
line 901
;901:		}
ADDRGP4 $443
JUMPV
LABELV $442
line 902
;902:		else {
line 903
;903:			VectorCopy(bs->viewangles, avgAngles);
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 7840
ADDP4
INDIRB
ASGNB 12
line 904
;904:		}
LABELV $443
line 905
;905:	}
LABELV $440
line 906
;906:	if (numentries2 > 0) {
ADDRLP4 64
INDIRI4
CNSTI4 0
LEI4 $444
line 908
;907:		// predict the ideal view angles
;908:		AnglesSubtract(avgAngles, avgAngles2, diff);
ADDRLP4 16
ARGP4
ADDRLP4 40
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 AnglesSubtract
CALLV
pop
line 909
;909:		VectorMA(avgAngles, 1, diff, avgAngles);
ADDRLP4 16
ADDRLP4 16
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 16+4
INDIRF4
ADDRLP4 4+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 16+8
ADDRLP4 16+8
INDIRF4
ADDRLP4 4+8
INDIRF4
ADDF4
ASGNF4
line 910
;910:	}
LABELV $444
line 911
;911:	VectorCopy(avgAngles, bs->viewhistory.real_viewangles);
ADDRFP4 0
INDIRP4
CNSTI4 7876
ADDP4
ADDRLP4 16
INDIRB
ASGNB 12
line 912
;912:	VectorCopy(avgPrcvAngles, perceivedViewDistortion);
ADDRFP4 4
INDIRP4
ADDRLP4 28
INDIRB
ASGNB 12
line 913
;913:}
LABELV $395
endproc BotViewReaction 120 12
export AngleDifference
proc AngleDifference 4 0
line 920
;914:
;915:/*
;916:==============
;917:AngleDifference
;918:==============
;919:*/
;920:float AngleDifference(float ang1, float ang2) {
line 923
;921:	float diff;
;922:
;923:	diff = ang1 - ang2;
ADDRLP4 0
ADDRFP4 0
INDIRF4
ADDRFP4 4
INDIRF4
SUBF4
ASGNF4
line 924
;924:	if (ang1 > ang2) {
ADDRFP4 0
INDIRF4
ADDRFP4 4
INDIRF4
LEF4 $453
line 925
;925:		if (diff > 180.0) diff -= 360.0;
ADDRLP4 0
INDIRF4
CNSTF4 1127481344
LEF4 $454
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
line 926
;926:	}
ADDRGP4 $454
JUMPV
LABELV $453
line 927
;927:	else {
line 928
;928:		if (diff < -180.0) diff += 360.0;
ADDRLP4 0
INDIRF4
CNSTF4 3274964992
GEF4 $457
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
LABELV $457
line 929
;929:	}
LABELV $454
line 930
;930:	return diff;
ADDRLP4 0
INDIRF4
RETF4
LABELV $452
endproc AngleDifference 4 0
export BotChangeViewAngle
proc BotChangeViewAngle 16 4
line 938
;931:}
;932:
;933:/*
;934:==============
;935:BotChangeViewAngle
;936:==============
;937:*/
;938:float BotChangeViewAngle(float angle, float ideal_angle, float speed) {
line 941
;939:	float move;
;940:
;941:	angle = AngleMod(angle);
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRFP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 942
;942:	ideal_angle = AngleMod(ideal_angle);
ADDRFP4 4
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRFP4 4
ADDRLP4 8
INDIRF4
ASGNF4
line 943
;943:	if (angle == ideal_angle) return angle;
ADDRFP4 0
INDIRF4
ADDRFP4 4
INDIRF4
NEF4 $460
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $459
JUMPV
LABELV $460
line 944
;944:	move = ideal_angle - angle;
ADDRLP4 0
ADDRFP4 4
INDIRF4
ADDRFP4 0
INDIRF4
SUBF4
ASGNF4
line 945
;945:	if (ideal_angle > angle) {
ADDRFP4 4
INDIRF4
ADDRFP4 0
INDIRF4
LEF4 $462
line 946
;946:		if (move > 180.0) move -= 360.0;
ADDRLP4 0
INDIRF4
CNSTF4 1127481344
LEF4 $463
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
line 947
;947:	}
ADDRGP4 $463
JUMPV
LABELV $462
line 948
;948:	else {
line 949
;949:		if (move < -180.0) move += 360.0;
ADDRLP4 0
INDIRF4
CNSTF4 3274964992
GEF4 $466
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
LABELV $466
line 950
;950:	}
LABELV $463
line 951
;951:	if (move > 0) {
ADDRLP4 0
INDIRF4
CNSTF4 0
LEF4 $468
line 952
;952:		if (move > speed) move = speed;
ADDRLP4 0
INDIRF4
ADDRFP4 8
INDIRF4
LEF4 $469
ADDRLP4 0
ADDRFP4 8
INDIRF4
ASGNF4
line 953
;953:	}
ADDRGP4 $469
JUMPV
LABELV $468
line 954
;954:	else {
line 955
;955:		if (move < -speed) move = -speed;
ADDRLP4 0
INDIRF4
ADDRFP4 8
INDIRF4
NEGF4
GEF4 $472
ADDRLP4 0
ADDRFP4 8
INDIRF4
NEGF4
ASGNF4
LABELV $472
line 956
;956:	}
LABELV $469
line 957
;957:	return AngleMod(angle + move);
ADDRFP4 0
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ARGF4
ADDRLP4 12
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 12
INDIRF4
RETF4
LABELV $459
endproc BotChangeViewAngle 16 4
export BotChangeViewAngles
proc BotChangeViewAngles 76 16
line 965
;958:}
;959:
;960:/*
;961:==============
;962:BotChangeViewAngles
;963:==============
;964:*/
;965:void BotChangeViewAngles(bot_state_t *bs, float thinktime) {
line 1023
;966:	// JUHOX: new view angle changing
;967:#if 0
;968:	float diff, factor, maxchange, anglespeed, disired_speed;
;969:	int i;
;970:
;971:	if (bs->ideal_viewangles[PITCH] > 180) bs->ideal_viewangles[PITCH] -= 360;
;972:	//
;973:	if (bs->enemy >= 0) {
;974:		factor = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_VIEW_FACTOR, 0.01f, 1);
;975:		maxchange = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_VIEW_MAXCHANGE, 1, 1800);
;976:	}
;977:	else {
;978:		factor = 0.05f;
;979:		maxchange = 360;
;980:	}
;981:	if (maxchange < 240) maxchange = 240;
;982:	maxchange *= thinktime;
;983:	for (i = 0; i < 2; i++) {
;984:		//
;985:		if (bot_challenge.integer) {
;986:			//smooth slowdown view model
;987:			diff = abs(AngleDifference(bs->viewangles[i], bs->ideal_viewangles[i]));
;988:			anglespeed = diff * factor;
;989:			if (anglespeed > maxchange) anglespeed = maxchange;
;990:			bs->viewangles[i] = BotChangeViewAngle(bs->viewangles[i],
;991:											bs->ideal_viewangles[i], anglespeed);
;992:		}
;993:		else {
;994:			//over reaction view model
;995:			bs->viewangles[i] = AngleMod(bs->viewangles[i]);
;996:			bs->ideal_viewangles[i] = AngleMod(bs->ideal_viewangles[i]);
;997:			diff = AngleDifference(bs->viewangles[i], bs->ideal_viewangles[i]);
;998:			disired_speed = diff * factor;
;999:			bs->viewanglespeed[i] += (bs->viewanglespeed[i] - disired_speed);
;1000:			if (bs->viewanglespeed[i] > 180) bs->viewanglespeed[i] = maxchange;
;1001:			if (bs->viewanglespeed[i] < -180) bs->viewanglespeed[i] = -maxchange;
;1002:			anglespeed = bs->viewanglespeed[i];
;1003:			if (anglespeed > maxchange) anglespeed = maxchange;
;1004:			if (anglespeed < -maxchange) anglespeed = -maxchange;
;1005:			bs->viewangles[i] += anglespeed;
;1006:			bs->viewangles[i] = AngleMod(bs->viewangles[i]);
;1007:			//demping
;1008:			bs->viewanglespeed[i] *= 0.45 * (1 - factor);
;1009:		}
;1010:		//BotAI_Print(PRT_MESSAGE, "ideal_angles %f %f\n", bs->ideal_viewangles[0], bs->ideal_viewangles[1], bs->ideal_viewangles[2]);`
;1011:		//bs->viewangles[i] = bs->ideal_viewangles[i];
;1012:	}
;1013:	//bs->viewangles[PITCH] = 0;
;1014:	if (bs->viewangles[PITCH] > 180) bs->viewangles[PITCH] -= 360;
;1015:	//elementary action: view
;1016:	trap_EA_View(bs->client, bs->viewangles);
;1017:#else
;1018:	vec3_t perceivedViewDistortion;
;1019:	vec3_t viewAnglesDest;
;1020:	float factor, maxchange;
;1021:	int i;
;1022:
;1023:	BotViewReaction(bs, perceivedViewDistortion);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 BotViewReaction
CALLV
pop
line 1024
;1024:	VectorCopy(bs->viewhistory.real_viewangles, viewAnglesDest);
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 7876
ADDP4
INDIRB
ASGNB 12
line 1026
;1025:
;1026:	factor = thinktime / bs->reactiontime;
ADDRLP4 8
ADDRFP4 4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
DIVF4
ASGNF4
line 1027
;1027:	if (factor > 1) factor = 1;
ADDRLP4 8
INDIRF4
CNSTF4 1065353216
LEF4 $475
ADDRLP4 8
CNSTF4 1065353216
ASGNF4
LABELV $475
line 1028
;1028:	maxchange = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_VIEW_MAXCHANGE, 240, 1800);
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
CNSTF4 1131413504
ARGF4
CNSTF4 1155596288
ARGF4
ADDRLP4 36
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 36
INDIRF4
ASGNF4
line 1029
;1029:	maxchange *= thinktime;
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRFP4 4
INDIRF4
MULF4
ASGNF4
line 1030
;1030:	for (i = 0; i < 2; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $477
line 1033
;1031:		float viewdelta;
;1032:
;1033:		viewdelta =
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 24
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 7888
ADDP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
ADDP4
INDIRF4
ADDF4
ARGF4
ADDRLP4 48
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 40
ADDRLP4 8
INDIRF4
ADDRLP4 48
INDIRF4
MULF4
ASGNF4
line 1036
;1034:			factor *
;1035:			AngleSubtract(viewAnglesDest[i], bs->viewhistory.lastviewcommand[i] + perceivedViewDistortion[i]);
;1036:		if (viewdelta > maxchange) viewdelta = maxchange;
ADDRLP4 40
INDIRF4
ADDRLP4 4
INDIRF4
LEF4 $481
ADDRLP4 40
ADDRLP4 4
INDIRF4
ASGNF4
ADDRGP4 $482
JUMPV
LABELV $481
line 1037
;1037:		else if (viewdelta < -maxchange) viewdelta = -maxchange;
ADDRLP4 40
INDIRF4
ADDRLP4 4
INDIRF4
NEGF4
GEF4 $483
ADDRLP4 40
ADDRLP4 4
INDIRF4
NEGF4
ASGNF4
LABELV $483
LABELV $482
line 1038
;1038:		bs->viewangles[i] = AngleMod(bs->viewangles[i] + viewdelta);
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 56
INDIRP4
CNSTI4 7840
ADDP4
ADDP4
INDIRF4
ADDRLP4 40
INDIRF4
ADDF4
ARGF4
ADDRLP4 60
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 56
INDIRP4
CNSTI4 7840
ADDP4
ADDP4
ADDRLP4 60
INDIRF4
ASGNF4
line 1039
;1039:		bs->viewhistory.lastviewcommand[i] = AngleMod(bs->viewhistory.lastviewcommand[i] + viewdelta);
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68
INDIRP4
CNSTI4 7888
ADDP4
ADDP4
INDIRF4
ADDRLP4 40
INDIRF4
ADDF4
ARGF4
ADDRLP4 72
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68
INDIRP4
CNSTI4 7888
ADDP4
ADDP4
ADDRLP4 72
INDIRF4
ASGNF4
line 1040
;1040:	}
LABELV $478
line 1030
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LTI4 $477
line 1041
;1041:	trap_EA_View(bs->client, bs->viewangles);
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 40
INDIRP4
CNSTI4 7840
ADDP4
ARGP4
ADDRGP4 trap_EA_View
CALLV
pop
line 1043
;1042:#endif
;1043:}
LABELV $474
endproc BotChangeViewAngles 76 16
export BotInputToUserCommand
proc BotInputToUserCommand 140 16
line 1050
;1044:
;1045:/*
;1046:==============
;1047:BotInputToUserCommand
;1048:==============
;1049:*/
;1050:void BotInputToUserCommand(bot_input_t *bi, usercmd_t *ucmd, int delta_angles[3], int time) {
line 1056
;1051:	vec3_t angles, forward, right;
;1052:	short temp;
;1053:	int j;
;1054:
;1055:	//clear the whole structure
;1056:	memset(ucmd, 0, sizeof(usercmd_t));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 24
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1060
;1057:	//
;1058:	//Com_Printf("dir = %f %f %f speed = %f\n", bi->dir[0], bi->dir[1], bi->dir[2], bi->speed);
;1059:	//the duration for the user command in milli seconds
;1060:	ucmd->serverTime = time;
ADDRFP4 4
INDIRP4
ADDRFP4 12
INDIRI4
ASGNI4
line 1062
;1061:	//
;1062:	if (bi->actionflags & ACTION_DELAYEDJUMP) {
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $486
line 1063
;1063:		bi->actionflags |= ACTION_JUMP;
ADDRLP4 44
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 1064
;1064:		bi->actionflags &= ~ACTION_DELAYEDJUMP;
ADDRLP4 48
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 -32769
BANDI4
ASGNI4
line 1065
;1065:	}
LABELV $486
line 1067
;1066:	//set the buttons
;1067:	if (bi->actionflags & ACTION_RESPAWN) ucmd->buttons = BUTTON_ATTACK;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $488
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 1
ASGNI4
LABELV $488
line 1068
;1068:	if (bi->actionflags & ACTION_ATTACK) ucmd->buttons |= BUTTON_ATTACK;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $490
ADDRLP4 44
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
LABELV $490
line 1069
;1069:	if (bi->actionflags & ACTION_TALK) ucmd->buttons |= BUTTON_TALK;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 65536
BANDI4
CNSTI4 0
EQI4 $492
ADDRLP4 48
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
LABELV $492
line 1070
;1070:	if (bi->actionflags & ACTION_GESTURE) ucmd->buttons |= BUTTON_GESTURE;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 131072
BANDI4
CNSTI4 0
EQI4 $494
ADDRLP4 52
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
LABELV $494
line 1071
;1071:	if (bi->actionflags & ACTION_USE) ucmd->buttons |= BUTTON_USE_HOLDABLE;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $496
ADDRLP4 56
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 4
BORI4
ASGNI4
LABELV $496
line 1072
;1072:	if (bi->actionflags & ACTION_WALK) ucmd->buttons |= BUTTON_WALKING;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 524288
BANDI4
CNSTI4 0
EQI4 $498
ADDRLP4 60
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
LABELV $498
line 1073
;1073:	if (bi->actionflags & ACTION_AFFIRMATIVE) ucmd->buttons |= BUTTON_AFFIRMATIVE;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 1048576
BANDI4
CNSTI4 0
EQI4 $500
ADDRLP4 64
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
LABELV $500
line 1074
;1074:	if (bi->actionflags & ACTION_NEGATIVE) ucmd->buttons |= BUTTON_NEGATIVE;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 2097152
BANDI4
CNSTI4 0
EQI4 $502
ADDRLP4 68
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
LABELV $502
line 1075
;1075:	if (bi->actionflags & ACTION_GETFLAG) ucmd->buttons |= BUTTON_GETFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 8388608
BANDI4
CNSTI4 0
EQI4 $504
ADDRLP4 72
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
LABELV $504
line 1076
;1076:	if (bi->actionflags & ACTION_GUARDBASE) ucmd->buttons |= BUTTON_GUARDBASE;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 16777216
BANDI4
CNSTI4 0
EQI4 $506
ADDRLP4 76
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 256
BORI4
ASGNI4
LABELV $506
line 1077
;1077:	if (bi->actionflags & ACTION_PATROL) ucmd->buttons |= BUTTON_PATROL;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 33554432
BANDI4
CNSTI4 0
EQI4 $508
ADDRLP4 80
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRI4
CNSTI4 512
BORI4
ASGNI4
LABELV $508
line 1078
;1078:	if (bi->actionflags & ACTION_FOLLOWME) ucmd->buttons |= BUTTON_FOLLOWME;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 134217728
BANDI4
CNSTI4 0
EQI4 $510
ADDRLP4 84
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
CNSTI4 1024
BORI4
ASGNI4
LABELV $510
line 1080
;1079:	//
;1080:	ucmd->weapon = bi->weapon;
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 1083
;1081:	//set the view angles
;1082:	//NOTE: the ucmd->angles are the angles WITHOUT the delta angles
;1083:	ucmd->angles[PITCH] = ANGLE2SHORT(bi->viewangles[PITCH]);
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
CNSTF4 1127615329
MULF4
CVFI4 4
CNSTI4 65535
BANDI4
ASGNI4
line 1084
;1084:	ucmd->angles[YAW] = ANGLE2SHORT(bi->viewangles[YAW]);
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
CNSTF4 1127615329
MULF4
CVFI4 4
CNSTI4 65535
BANDI4
ASGNI4
line 1085
;1085:	ucmd->angles[ROLL] = ANGLE2SHORT(bi->viewangles[ROLL]);
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 1127615329
MULF4
CVFI4 4
CNSTI4 65535
BANDI4
ASGNI4
line 1087
;1086:	//subtract the delta angles
;1087:	for (j = 0; j < 3; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $512
line 1088
;1088:		temp = ucmd->angles[j] - delta_angles[j];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRI4
SUBI4
CVII2 4
ASGNI2
line 1096
;1089:		/*NOTE: disabled because temp should be mod first
;1090:		if ( j == PITCH ) {
;1091:			// don't let the player look up or down more than 90 degrees
;1092:			if ( temp > 16000 ) temp = 16000;
;1093:			else if ( temp < -16000 ) temp = -16000;
;1094:		}
;1095:		*/
;1096:		ucmd->angles[j] = temp;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDP4
ADDRLP4 4
INDIRI2
CVII4 2
ASGNI4
line 1097
;1097:	}
LABELV $513
line 1087
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $512
line 1101
;1098:	//NOTE: movement is relative to the REAL view angles
;1099:	//get the horizontal forward and right vector
;1100:	//get the pitch in the range [-180, 180]
;1101:	if (bi->dir[2]) angles[PITCH] = bi->viewangles[PITCH];
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 0
EQF4 $516
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ASGNF4
ADDRGP4 $517
JUMPV
LABELV $516
line 1102
;1102:	else angles[PITCH] = 0;
ADDRLP4 20
CNSTF4 0
ASGNF4
LABELV $517
line 1103
;1103:	angles[YAW] = bi->viewangles[YAW];
ADDRLP4 20+4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 1104
;1104:	angles[ROLL] = 0;
ADDRLP4 20+8
CNSTF4 0
ASGNF4
line 1105
;1105:	AngleVectors(angles, forward, right, NULL);
ADDRLP4 20
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 32
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 1107
;1106:	//bot input speed is in the range [0, 400]
;1107:	bi->speed = bi->speed * 127 / 400;
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 88
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
CNSTF4 1050840924
MULF4
ASGNF4
line 1114
;1108:	//set the view independent movement
;1109:#if 0	// JUHOX BUGFIX: ucmd->xxxmove do not use euclidean distance (see PM_CmdScale())
;1110:	ucmd->forwardmove = DotProduct(forward, bi->dir) * bi->speed;
;1111:	ucmd->rightmove = DotProduct(right, bi->dir) * bi->speed;
;1112:	ucmd->upmove = abs(forward[2]) * bi->dir[2] * bi->speed;
;1113:#else
;1114:	{
line 1117
;1115:		float f, r, u, m;
;1116:
;1117:		f = DotProduct(forward, bi->dir);
ADDRLP4 108
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 104
ADDRLP4 8
INDIRF4
ADDRLP4 108
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ADDRLP4 8+4
INDIRF4
ADDRLP4 108
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 8+8
INDIRF4
ADDRLP4 108
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1118
;1118:		r = DotProduct(right, bi->dir);
ADDRLP4 112
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 96
ADDRLP4 32
INDIRF4
ADDRLP4 112
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ADDRLP4 32+4
INDIRF4
ADDRLP4 112
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 32+8
INDIRF4
ADDRLP4 112
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1119
;1119:		u = abs(forward[2]) * bi->dir[2];
ADDRLP4 8+8
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 116
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 100
ADDRLP4 116
INDIRI4
CVIF4 4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
MULF4
ASGNF4
line 1121
;1120:
;1121:		m = fabs(f);
ADDRLP4 104
INDIRF4
ARGF4
ADDRLP4 120
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 92
ADDRLP4 120
INDIRF4
ASGNF4
line 1122
;1122:		if (fabs(r) > m) m = fabs(r);
ADDRLP4 96
INDIRF4
ARGF4
ADDRLP4 124
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 124
INDIRF4
ADDRLP4 92
INDIRF4
LEF4 $525
ADDRLP4 96
INDIRF4
ARGF4
ADDRLP4 128
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 92
ADDRLP4 128
INDIRF4
ASGNF4
LABELV $525
line 1123
;1123:		if (fabs(u) > m) m = fabs(u);
ADDRLP4 100
INDIRF4
ARGF4
ADDRLP4 132
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 132
INDIRF4
ADDRLP4 92
INDIRF4
LEF4 $527
ADDRLP4 100
INDIRF4
ARGF4
ADDRLP4 136
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 92
ADDRLP4 136
INDIRF4
ASGNF4
LABELV $527
line 1124
;1124:		if (m > 0) {
ADDRLP4 92
INDIRF4
CNSTF4 0
LEF4 $529
line 1125
;1125:			f *= bi->speed / m;
ADDRLP4 104
ADDRLP4 104
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 92
INDIRF4
DIVF4
MULF4
ASGNF4
line 1126
;1126:			r *= bi->speed / m;
ADDRLP4 96
ADDRLP4 96
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 92
INDIRF4
DIVF4
MULF4
ASGNF4
line 1127
;1127:			u *= bi->speed / m;
ADDRLP4 100
ADDRLP4 100
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 92
INDIRF4
DIVF4
MULF4
ASGNF4
line 1128
;1128:		}
LABELV $529
line 1130
;1129:
;1130:		ucmd->forwardmove = f;
ADDRFP4 4
INDIRP4
CNSTI4 21
ADDP4
ADDRLP4 104
INDIRF4
CVFI4 4
CVII1 4
ASGNI1
line 1131
;1131:		ucmd->rightmove = r;
ADDRFP4 4
INDIRP4
CNSTI4 22
ADDP4
ADDRLP4 96
INDIRF4
CVFI4 4
CVII1 4
ASGNI1
line 1132
;1132:		ucmd->upmove = u;
ADDRFP4 4
INDIRP4
CNSTI4 23
ADDP4
ADDRLP4 100
INDIRF4
CVFI4 4
CVII1 4
ASGNI1
line 1133
;1133:	}
line 1148
;1134:#endif
;1135:	// JUHOX BUGFIX: since the ucmd->xxxmove fields are of type 'char', it's not recommended to
;1136:	// add/subtract 127 (could cause an overflow)
;1137:#if 0
;1138:	//normal keyboard movement
;1139:	if (bi->actionflags & ACTION_MOVEFORWARD) ucmd->forwardmove += 127;
;1140:	if (bi->actionflags & ACTION_MOVEBACK) ucmd->forwardmove -= 127;
;1141:	if (bi->actionflags & ACTION_MOVELEFT) ucmd->rightmove -= 127;
;1142:	if (bi->actionflags & ACTION_MOVERIGHT) ucmd->rightmove += 127;
;1143:	//jump/moveup
;1144:	if (bi->actionflags & ACTION_JUMP) ucmd->upmove += 127;
;1145:	//crouch/movedown
;1146:	if (bi->actionflags & ACTION_CROUCH) ucmd->upmove -= 127;
;1147:#else
;1148:	if (bi->actionflags & ACTION_MOVEFORWARD) ucmd->forwardmove = 127;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $531
ADDRFP4 4
INDIRP4
CNSTI4 21
ADDP4
CNSTI1 127
ASGNI1
LABELV $531
line 1149
;1149:	if (bi->actionflags & ACTION_MOVEBACK) ucmd->forwardmove = -127;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $533
ADDRFP4 4
INDIRP4
CNSTI4 21
ADDP4
CNSTI1 -127
ASGNI1
LABELV $533
line 1150
;1150:	if (bi->actionflags & ACTION_MOVELEFT) ucmd->rightmove = -127;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $535
ADDRFP4 4
INDIRP4
CNSTI4 22
ADDP4
CNSTI1 -127
ASGNI1
LABELV $535
line 1151
;1151:	if (bi->actionflags & ACTION_MOVERIGHT) ucmd->rightmove = 127;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $537
ADDRFP4 4
INDIRP4
CNSTI4 22
ADDP4
CNSTI1 127
ASGNI1
LABELV $537
line 1153
;1152:	//jump/moveup
;1153:	if (bi->actionflags & ACTION_JUMP) ucmd->upmove = 127;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $539
ADDRFP4 4
INDIRP4
CNSTI4 23
ADDP4
CNSTI1 127
ASGNI1
LABELV $539
line 1155
;1154:	//crouch/movedown
;1155:	if (bi->actionflags & ACTION_CROUCH) ucmd->upmove = -127;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $541
ADDRFP4 4
INDIRP4
CNSTI4 23
ADDP4
CNSTI1 -127
ASGNI1
LABELV $541
line 1160
;1156:#endif
;1157:	//
;1158:	//Com_Printf("forward = %d right = %d up = %d\n", ucmd.forwardmove, ucmd.rightmove, ucmd.upmove);
;1159:	//Com_Printf("ucmd->serverTime = %d\n", ucmd->serverTime);
;1160:}
LABELV $485
endproc BotInputToUserCommand 140 16
export BotUpdateInput
proc BotUpdateInput 140 28
line 1167
;1161:
;1162:/*
;1163:==============
;1164:BotUpdateInput
;1165:==============
;1166:*/
;1167:void BotUpdateInput(bot_state_t *bs, int time, int elapsed_time) {
line 1173
;1168:	bot_input_t bi;
;1169:	int j;
;1170:	qboolean runningNeeded;	// JUHOX
;1171:
;1172:	//add the delta angles to the bot's current view angles
;1173:	for (j = 0; j < 3; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $544
line 1174
;1174:		bs->viewangles[j] = AngleMod(bs->viewangles[j] + SHORT2ANGLE(bs->cur_ps.delta_angles[j]));
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 52
INDIRP4
CNSTI4 7840
ADDP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 52
INDIRP4
CNSTI4 72
ADDP4
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1001652224
MULF4
ADDF4
ARGF4
ADDRLP4 56
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 52
INDIRP4
CNSTI4 7840
ADDP4
ADDP4
ADDRLP4 56
INDIRF4
ASGNF4
line 1175
;1175:	}
LABELV $545
line 1173
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $544
line 1177
;1176:#if 1	// JUHOX: don't change the view during railgun jump
;1177:	if (bs->railgunJump_jumptime) {
ADDRFP4 0
INDIRP4
CNSTI4 7732
ADDP4
INDIRF4
CNSTF4 0
EQF4 $548
line 1178
;1178:		VectorCopy(bs->viewangles, bs->ideal_viewangles);
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 7852
ADDP4
ADDRLP4 48
INDIRP4
CNSTI4 7840
ADDP4
INDIRB
ASGNB 12
line 1179
;1179:	}
LABELV $548
line 1182
;1180:#endif
;1181:	//change the bot view angles
;1182:	BotChangeViewAngles(bs, (float) elapsed_time / 1000);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
CVIF4 4
CNSTF4 981668463
MULF4
ARGF4
ADDRGP4 BotChangeViewAngles
CALLV
pop
line 1184
;1183:	//retrieve the bot input
;1184:	trap_EA_GetInput(bs->client, (float) time / 1000, &bi);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
CVIF4 4
CNSTF4 981668463
MULF4
ARGF4
ADDRLP4 4
ARGP4
ADDRGP4 trap_EA_GetInput
CALLV
pop
line 1192
;1185:#if !RESPAWN_DELAY	// JUHOX: don't use respawn hack with auto-respawn
;1186:	//respawn hack
;1187:	if (bi.actionflags & ACTION_RESPAWN) {
;1188:		if (bs->lastucmd.buttons & BUTTON_ATTACK) bi.actionflags &= ~(ACTION_RESPAWN|ACTION_ATTACK);
;1189:	}
;1190:#endif
;1191:#if 1	// JUHOX: we depend on some elements of the playerState, which is not updated every frame, so do it now
;1192:	if (!BotAI_GetClientState(bs->client, &bs->cur_ps)) goto CreateUserCommand;
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 52
ADDRGP4 BotAI_GetClientState
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $550
ADDRGP4 $552
JUMPV
LABELV $550
line 1195
;1193:#endif
;1194:#if RESPAWN_DELAY	// JUHOX: press the attack button if dead, to respawn at a regular spawn point
;1195:	if (bs->cur_ps.stats[STAT_HEALTH] <= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
CNSTI4 0
GTI4 $553
line 1196
;1196:		if (bi.actionflags & ACTION_RESPAWN) {
ADDRLP4 4+32
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $555
line 1197
;1197:			bi.actionflags |= ACTION_USE;
ADDRLP4 4+32
ADDRLP4 4+32
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 1198
;1198:		}
ADDRGP4 $556
JUMPV
LABELV $555
line 1199
;1199:		else {
line 1200
;1200:			bi.actionflags |= ACTION_ATTACK;
ADDRLP4 4+32
ADDRLP4 4+32
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 1201
;1201:		}
LABELV $556
line 1202
;1202:		bi.actionflags &= ~ACTION_RESPAWN;
ADDRLP4 4+32
ADDRLP4 4+32
INDIRI4
CNSTI4 -9
BANDI4
ASGNI4
line 1203
;1203:		bs->preventJump = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 7748
ADDP4
CNSTI4 0
ASGNI4
line 1204
;1204:		bs->specialMove = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 7744
ADDP4
CNSTI4 0
ASGNI4
line 1205
;1205:		bs->forceWalk = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 7740
ADDP4
CNSTI4 0
ASGNI4
line 1206
;1206:		bs->walkTrouble = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 7344
ADDP4
CNSTI4 0
ASGNI4
line 1207
;1207:		bs->railgunJump_ordertime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7728
ADDP4
CNSTF4 0
ASGNF4
line 1208
;1208:		bs->railgunJump_jumptime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7732
ADDP4
CNSTF4 0
ASGNF4
line 1209
;1209:		goto CreateUserCommand;
ADDRGP4 $552
JUMPV
LABELV $553
line 1213
;1210:	}
;1211:#endif
;1212:#if 1	// JUHOX: delay release of the machinegun a bit
;1213:	if (bs->weaponnum == WP_MACHINEGUN) {
ADDRFP4 0
INDIRP4
CNSTI4 7804
ADDP4
INDIRI4
CNSTI4 2
NEI4 $561
line 1214
;1214:		if (bi.actionflags & ACTION_ATTACK) {
ADDRLP4 4+32
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $563
line 1215
;1215:			bs->machinegun_attack_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7296
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 1216
;1216:		}
ADDRGP4 $562
JUMPV
LABELV $563
line 1217
;1217:		else if (bs->machinegun_attack_time > FloatTime() - 1) {
ADDRFP4 0
INDIRP4
CNSTI4 7296
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
SUBF4
LEF4 $562
line 1218
;1218:			bi.actionflags |= ACTION_ATTACK;
ADDRLP4 4+32
ADDRLP4 4+32
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 1219
;1219:		}
line 1220
;1220:	}
ADDRGP4 $562
JUMPV
LABELV $561
line 1221
;1221:	else {
line 1222
;1222:		bs->machinegun_attack_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7296
ADDP4
CNSTF4 0
ASGNF4
line 1223
;1223:	}
LABELV $562
line 1226
;1224:#endif
;1225:#if 1	// JUHOX: running needed?
;1226:	runningNeeded = qfalse;
ADDRLP4 44
CNSTI4 0
ASGNI4
line 1227
;1227:	if ((bi.actionflags & ACTION_WALK) || bs->forceWalk) {
ADDRLP4 4+32
INDIRI4
CNSTI4 524288
BANDI4
CNSTI4 0
NEI4 $572
ADDRFP4 0
INDIRP4
CNSTI4 7740
ADDP4
INDIRI4
CNSTI4 0
EQI4 $569
LABELV $572
line 1232
;1228:		trace_t trace;
;1229:		vec3_t start;
;1230:		vec3_t end;
;1231:		
;1232:		VectorMA(bs->cur_ps.origin, 0.150 * g_speed.value, bi.dir, start);
ADDRLP4 136
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
ADDRLP4 136
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 4+4
INDIRF4
ADDRGP4 g_speed+8
INDIRF4
CNSTF4 1041865114
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 56+4
ADDRLP4 136
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 4+4+4
INDIRF4
ADDRGP4 g_speed+8
INDIRF4
CNSTF4 1041865114
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 56+8
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRF4
ADDRLP4 4+4+8
INDIRF4
ADDRGP4 g_speed+8
INDIRF4
CNSTF4 1041865114
MULF4
MULF4
ADDF4
ASGNF4
line 1233
;1233:		VectorCopy(start, end);
ADDRLP4 68
ADDRLP4 56
INDIRB
ASGNB 12
line 1234
;1234:		end[2] -= 75;
ADDRLP4 68+8
ADDRLP4 68+8
INDIRF4
CNSTF4 1117126656
SUBF4
ASGNF4
line 1235
;1235:		trap_Trace(&trace, start, NULL, NULL, end, -1, MASK_PLAYERSOLID & ~CONTENTS_BODY);
ADDRLP4 80
ARGP4
ADDRLP4 56
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 68
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 65537
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1236
;1236:		if (trace.fraction >= 1) {
ADDRLP4 80+8
INDIRF4
CNSTF4 1065353216
LTF4 $584
line 1237
;1237:			runningNeeded = qtrue;
ADDRLP4 44
CNSTI4 1
ASGNI4
line 1238
;1238:		}
LABELV $584
line 1239
;1239:	}
LABELV $569
line 1242
;1240:#endif
;1241:#if 1	// JUHOX: make the 'preventJump' flag work
;1242:	if (bs->preventJump && !runningNeeded && !bs->specialMove) {
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 7748
ADDP4
INDIRI4
CNSTI4 0
EQI4 $587
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $587
ADDRLP4 56
INDIRP4
CNSTI4 7744
ADDP4
INDIRI4
CNSTI4 0
NEI4 $587
line 1243
;1243:		bi.actionflags &= ~ACTION_JUMP;
ADDRLP4 4+32
ADDRLP4 4+32
INDIRI4
CNSTI4 -17
BANDI4
ASGNI4
line 1244
;1244:	}
LABELV $587
line 1248
;1245:#endif
;1246:#if 1	// JUHOX: make the 'forceWalk' flag work
;1247:	if (
;1248:		runningNeeded ||
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $593
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $593
ADDRLP4 60
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 1023
NEI4 $590
LABELV $593
line 1251
;1249:		(bs->cur_ps.pm_flags & PMF_JUMP_HELD) ||
;1250:		bs->cur_ps.groundEntityNum == ENTITYNUM_NONE
;1251:	) {
line 1252
;1252:		bs->forceWalk = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 7740
ADDP4
CNSTI4 0
ASGNI4
line 1253
;1253:		bi.actionflags &= ~ACTION_WALK;
ADDRLP4 4+32
ADDRLP4 4+32
INDIRI4
CNSTI4 -524289
BANDI4
ASGNI4
line 1255
;1254:		//bi.speed = 400;
;1255:	}
LABELV $590
line 1256
;1256:	if (bs->forceWalk) {
ADDRFP4 0
INDIRP4
CNSTI4 7740
ADDP4
INDIRI4
CNSTI4 0
EQI4 $595
line 1257
;1257:		bi.actionflags |= ACTION_WALK;
ADDRLP4 4+32
ADDRLP4 4+32
INDIRI4
CNSTI4 524288
BORI4
ASGNI4
line 1258
;1258:	}
LABELV $595
line 1259
;1259:	bs->walkTrouble = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 7344
ADDP4
CNSTI4 0
ASGNI4
line 1260
;1260:	if (bi.actionflags & ACTION_WALK) {
ADDRLP4 4+32
INDIRI4
CNSTI4 524288
BANDI4
CNSTI4 0
EQI4 $598
line 1261
;1261:		if (bi.speed > 200) bi.speed = 200;
ADDRLP4 4+16
INDIRF4
CNSTF4 1128792064
LEF4 $601
ADDRLP4 4+16
CNSTF4 1128792064
ASGNF4
LABELV $601
line 1263
;1262:		if (
;1263:			bi.speed > 0 &&
ADDRLP4 4+16
INDIRF4
CNSTF4 0
LEF4 $605
ADDRLP4 4+16
INDIRF4
CNSTF4 1120403456
GEF4 $605
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 7744
ADDP4
INDIRI4
CNSTI4 0
NEI4 $605
ADDRLP4 64
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 0
EQI4 $609
ADDRLP4 64
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 64
INDIRP4
CNSTI4 11580
ADDP4
ARGP4
ADDRLP4 68
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 68
INDIRF4
CNSTF4 1112014848
LTF4 $605
LABELV $609
line 1270
;1264:			bi.speed < 100 &&
;1265:			!bs->specialMove &&
;1266:			NOT (
;1267:				bs->ltgtype &&
;1268:				DistanceSquared(bs->origin, bs->teamgoal.origin) < 50
;1269:			)
;1270:		) {
line 1271
;1271:			bs->walkTrouble = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 7344
ADDP4
CNSTI4 1
ASGNI4
line 1272
;1272:		}
LABELV $605
line 1273
;1273:	}
LABELV $598
line 1276
;1274:#endif
;1275:#if 1	// JUHOX: make the railgun jump work
;1276:	if (bs->railgunJump_ordertime) {
ADDRFP4 0
INDIRP4
CNSTI4 7728
ADDP4
INDIRF4
CNSTF4 0
EQF4 $610
line 1277
;1277:		bs->walkTrouble = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 7344
ADDP4
CNSTI4 0
ASGNI4
line 1279
;1278:		// already jumped?
;1279:		if (bs->railgunJump_jumptime > 0) {
ADDRFP4 0
INDIRP4
CNSTI4 7732
ADDP4
INDIRF4
CNSTF4 0
LEF4 $612
line 1280
;1280:			if (bs->railgunJump_jumptime > FloatTime() - 0.25) {
ADDRFP4 0
INDIRP4
CNSTI4 7732
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1048576000
SUBF4
LEF4 $614
line 1281
;1281:				bi.actionflags &= ~(ACTION_ATTACK | ACTION_MOVEFORWARD | ACTION_MOVEBACK | ACTION_MOVELEFT | ACTION_MOVERIGHT);
ADDRLP4 4+32
ADDRLP4 4+32
INDIRI4
CNSTI4 -14850
BANDI4
ASGNI4
line 1282
;1282:				bi.speed = 0;
ADDRLP4 4+16
CNSTF4 0
ASGNF4
line 1283
;1283:			}
ADDRGP4 $613
JUMPV
LABELV $614
line 1284
;1284:			else if (bs->cur_ps.weaponTime <= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
CNSTI4 0
GTI4 $618
line 1285
;1285:				bi.actionflags |= ACTION_ATTACK;
ADDRLP4 4+32
ADDRLP4 4+32
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 1286
;1286:			}
ADDRGP4 $613
JUMPV
LABELV $618
line 1287
;1287:			else {
line 1288
;1288:				bs->railgunJump_ordertime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7728
ADDP4
CNSTF4 0
ASGNF4
line 1289
;1289:				bs->railgunJump_jumptime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7732
ADDP4
CNSTF4 0
ASGNF4
line 1290
;1290:			}
line 1291
;1291:		}
ADDRGP4 $613
JUMPV
LABELV $612
line 1293
;1292:		// railgun requirements still met?
;1293:		else if (bs->railgunJump_ordertime > FloatTime() - 3 && bs->cur_ps.ammo[WP_RAILGUN] > 0) {
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 7728
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1077936128
SUBF4
LEF4 $621
ADDRLP4 64
INDIRP4
CNSTI4 420
ADDP4
INDIRI4
CNSTI4 0
LEI4 $621
line 1295
;1294:			// weapon ready for jump?
;1295:			if (bs->cur_ps.weapon == WP_RAILGUN && bs->cur_ps.weaponTime <= 0) {
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 7
NEI4 $622
ADDRLP4 68
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
CNSTI4 0
GTI4 $622
line 1297
;1296:				if (
;1297:					(bi.actionflags & ACTION_JUMP) ||
ADDRLP4 4+32
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $628
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 1023
EQI4 $622
ADDRLP4 72
INDIRP4
CNSTI4 7728
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
SUBF4
GEF4 $622
ADDRLP4 72
INDIRP4
CNSTI4 168
ADDP4
INDIRF4
CNSTF4 1118437376
LTF4 $622
LABELV $628
line 1303
;1298:					(
;1299:						bs->cur_ps.groundEntityNum != ENTITYNUM_NONE &&
;1300:						bs->railgunJump_ordertime < FloatTime() - 2 &&
;1301:						bs->cur_ps.viewangles[PITCH] >= 85
;1302:					)
;1303:				) {
line 1304
;1304:					bi.actionflags &= ~ACTION_ATTACK;
ADDRLP4 4+32
ADDRLP4 4+32
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 1305
;1305:					bi.actionflags |= ACTION_JUMP;
ADDRLP4 4+32
ADDRLP4 4+32
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 1306
;1306:					bs->railgunJump_jumptime = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7732
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 1307
;1307:				}
line 1308
;1308:			}
line 1309
;1309:		}
ADDRGP4 $622
JUMPV
LABELV $621
line 1310
;1310:		else {
line 1312
;1311:			// railgun jump failed, abort
;1312:			bs->railgunJump_ordertime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7728
ADDP4
CNSTF4 0
ASGNF4
line 1313
;1313:			bs->railgunJump_jumptime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7732
ADDP4
CNSTF4 0
ASGNF4
line 1314
;1314:		}
LABELV $622
LABELV $613
line 1315
;1315:	}
LABELV $610
line 1318
;1316:#endif
;1317:#if 1	// JUHOX: don't let the bot run at low speed
;1318:	if (bi.speed <= 200) bi.actionflags |= ACTION_WALK;
ADDRLP4 4+16
INDIRF4
CNSTF4 1128792064
GTF4 $631
ADDRLP4 4+32
ADDRLP4 4+32
INDIRI4
CNSTI4 524288
BORI4
ASGNI4
LABELV $631
LABELV $552
line 1322
;1319:#endif
;1320:	CreateUserCommand:	// JUHOX
;1321:	//convert the bot input to a usercmd
;1322:	BotInputToUserCommand(&bi, &bs->lastucmd, bs->cur_ps.delta_angles, time);
ADDRLP4 4
ARGP4
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 64
INDIRP4
CNSTI4 72
ADDP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 BotInputToUserCommand
CALLV
pop
line 1324
;1323:	//subtract the delta angles
;1324:	for (j = 0; j < 3; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $635
line 1325
;1325:		bs->viewangles[j] = AngleMod(bs->viewangles[j] - SHORT2ANGLE(bs->cur_ps.delta_angles[j]));
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 72
INDIRP4
CNSTI4 7840
ADDP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 72
INDIRP4
CNSTI4 72
ADDP4
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1001652224
MULF4
SUBF4
ARGF4
ADDRLP4 76
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 72
INDIRP4
CNSTI4 7840
ADDP4
ADDP4
ADDRLP4 76
INDIRF4
ASGNF4
line 1326
;1326:	}
LABELV $636
line 1324
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $635
line 1327
;1327:}
LABELV $543
endproc BotUpdateInput 140 28
export BotAIRegularUpdate
proc BotAIRegularUpdate 0 0
line 1334
;1328:
;1329:/*
;1330:==============
;1331:BotAIRegularUpdate
;1332:==============
;1333:*/
;1334:void BotAIRegularUpdate(void) {
line 1335
;1335:	if (regularupdate_time < FloatTime()) {
ADDRGP4 regularupdate_time
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $640
line 1336
;1336:		trap_BotUpdateEntityItems();
ADDRGP4 trap_BotUpdateEntityItems
CALLV
pop
line 1337
;1337:		regularupdate_time = FloatTime() + 0.3;
ADDRGP4 regularupdate_time
ADDRGP4 floattime
INDIRF4
CNSTF4 1050253722
ADDF4
ASGNF4
line 1338
;1338:	}
LABELV $640
line 1339
;1339:}
LABELV $639
endproc BotAIRegularUpdate 0 0
export RemoveColorEscapeSequences
proc RemoveColorEscapeSequences 20 0
line 1346
;1340:
;1341:/*
;1342:==============
;1343:RemoveColorEscapeSequences
;1344:==============
;1345:*/
;1346:void RemoveColorEscapeSequences( char *text ) {
line 1349
;1347:	int i, l;
;1348:
;1349:	l = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1350
;1350:	for ( i = 0; text[i]; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $646
JUMPV
LABELV $643
line 1351
;1351:		if (Q_IsColorString(&text[i])) {
ADDRLP4 8
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $647
ADDRLP4 8
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $647
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $647
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 94
EQI4 $647
line 1352
;1352:			i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1353
;1353:			continue;
ADDRGP4 $644
JUMPV
LABELV $647
line 1355
;1354:		}
;1355:		if (text[i] > 0x7E)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 126
LEI4 $649
line 1356
;1356:			continue;
ADDRGP4 $644
JUMPV
LABELV $649
line 1357
;1357:		text[l++] = text[i];
ADDRLP4 12
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRI4
ADDRLP4 16
INDIRP4
ADDP4
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRP4
ADDP4
INDIRI1
ASGNI1
line 1358
;1358:	}
LABELV $644
line 1350
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $646
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $643
line 1359
;1359:	text[l] = '\0';
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 1360
;1360:}
LABELV $642
endproc RemoveColorEscapeSequences 20 0
export BotAI
proc BotAI 1088 12
line 1367
;1361:
;1362:/*
;1363:==============
;1364:BotAI
;1365:==============
;1366:*/
;1367:int BotAI(int client, float thinktime) {
line 1372
;1368:	bot_state_t *bs;
;1369:	char buf[1024], *args;
;1370:	int j;
;1371:
;1372:	trap_EA_ResetInput(client);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 trap_EA_ResetInput
CALLV
pop
line 1374
;1373:	//
;1374:	bs = botstates[client];
ADDRLP4 4
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
line 1375
;1375:	if (!bs || !bs->inuse) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $654
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $652
LABELV $654
line 1376
;1376:		BotAI_Print(PRT_FATAL, "BotAI: client %d is not setup\n", client);
CNSTI4 4
ARGI4
ADDRGP4 $655
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 1377
;1377:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $651
JUMPV
LABELV $652
line 1381
;1378:	}
;1379:
;1380:	//retrieve the current client state
;1381:	BotAI_GetClientState( client, &bs->cur_ps );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRGP4 BotAI_GetClientState
CALLI4
pop
ADDRGP4 $657
JUMPV
LABELV $656
line 1384
;1382:
;1383:	//retrieve any waiting server commands
;1384:	while( trap_BotGetServerCommand(client, buf, sizeof(buf)) ) {
line 1386
;1385:		//have buf point to the command and args to the command arguments
;1386:		args = strchr( buf, ' ');
ADDRLP4 12
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 1040
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 1040
INDIRP4
ASGNP4
line 1387
;1387:		if (!args) continue;
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $659
ADDRGP4 $657
JUMPV
LABELV $659
line 1388
;1388:		*args++ = '\0';
ADDRLP4 1044
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 1044
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 1044
INDIRP4
CNSTI1 0
ASGNI1
line 1391
;1389:
;1390:		//remove color espace sequences from the arguments
;1391:		RemoveColorEscapeSequences( args );
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 RemoveColorEscapeSequences
CALLV
pop
line 1393
;1392:
;1393:		if (!Q_stricmp(buf, "cp "))
ADDRLP4 12
ARGP4
ADDRGP4 $663
ARGP4
ADDRLP4 1048
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $661
line 1394
;1394:			{ /*CenterPrintf*/ }
ADDRGP4 $662
JUMPV
LABELV $661
line 1395
;1395:		else if (!Q_stricmp(buf, "cs"))
ADDRLP4 12
ARGP4
ADDRGP4 $666
ARGP4
ADDRLP4 1052
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 0
NEI4 $664
line 1396
;1396:			{ /*ConfigStringModified*/ }
ADDRGP4 $665
JUMPV
LABELV $664
line 1397
;1397:		else if (!Q_stricmp(buf, "print")) {
ADDRLP4 12
ARGP4
ADDRGP4 $669
ARGP4
ADDRLP4 1056
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
NEI4 $667
line 1399
;1398:			//remove first and last quote from the chat message
;1399:			memmove(args, args+1, strlen(args));
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 1060
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 1060
INDIRI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 1400
;1400:			args[strlen(args)-1] = '\0';
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 1068
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1068
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 1401
;1401:			trap_BotQueueConsoleMessage(bs->cs, CMS_NORMAL, args);
ADDRLP4 4
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_BotQueueConsoleMessage
CALLV
pop
line 1402
;1402:		}
ADDRGP4 $668
JUMPV
LABELV $667
line 1403
;1403:		else if (!Q_stricmp(buf, "chat")) {
ADDRLP4 12
ARGP4
ADDRGP4 $672
ARGP4
ADDRLP4 1060
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1060
INDIRI4
CNSTI4 0
NEI4 $670
line 1405
;1404:			//remove first and last quote from the chat message
;1405:			memmove(args, args+1, strlen(args));
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 1064
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 1064
INDIRI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 1406
;1406:			args[strlen(args)-1] = '\0';
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 1072
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1072
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 1407
;1407:			trap_BotQueueConsoleMessage(bs->cs, CMS_CHAT, args);
ADDRLP4 4
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_BotQueueConsoleMessage
CALLV
pop
line 1408
;1408:		}
ADDRGP4 $671
JUMPV
LABELV $670
line 1409
;1409:		else if (!Q_stricmp(buf, "tchat")) {
ADDRLP4 12
ARGP4
ADDRGP4 $675
ARGP4
ADDRLP4 1064
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1064
INDIRI4
CNSTI4 0
NEI4 $673
line 1411
;1410:			//remove first and last quote from the chat message
;1411:			memmove(args, args+1, strlen(args));
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 1068
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 1068
INDIRI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 1412
;1412:			args[strlen(args)-1] = '\0';
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 1076
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1076
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 1413
;1413:			trap_BotQueueConsoleMessage(bs->cs, CMS_CHAT, args);
ADDRLP4 4
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_BotQueueConsoleMessage
CALLV
pop
line 1414
;1414:		}
ADDRGP4 $674
JUMPV
LABELV $673
line 1426
;1415:#ifdef MISSIONPACK
;1416:		else if (!Q_stricmp(buf, "vchat")) {
;1417:			BotVoiceChatCommand(bs, SAY_ALL, args);
;1418:		}
;1419:		else if (!Q_stricmp(buf, "vtchat")) {
;1420:			BotVoiceChatCommand(bs, SAY_TEAM, args);
;1421:		}
;1422:		else if (!Q_stricmp(buf, "vtell")) {
;1423:			BotVoiceChatCommand(bs, SAY_TELL, args);
;1424:		}
;1425:#endif
;1426:		else if (!Q_stricmp(buf, "scores"))
ADDRLP4 12
ARGP4
ADDRGP4 $678
ARGP4
ADDRLP4 1068
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1068
INDIRI4
CNSTI4 0
NEI4 $676
line 1427
;1427:			{ /*FIXME: parse scores?*/ }
ADDRGP4 $677
JUMPV
LABELV $676
line 1428
;1428:		else if (!Q_stricmp(buf, "clientLevelShot"))
ADDRLP4 12
ARGP4
ADDRGP4 $681
ARGP4
ADDRLP4 1072
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1072
INDIRI4
CNSTI4 0
NEI4 $679
line 1429
;1429:			{ /*ignore*/ }
LABELV $679
LABELV $677
LABELV $674
LABELV $671
LABELV $668
LABELV $665
LABELV $662
line 1430
;1430:	}
LABELV $657
line 1384
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1040
ADDRGP4 trap_BotGetServerCommand
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $656
line 1432
;1431:	//add the delta angles to the bot's current view angles
;1432:	for (j = 0; j < 3; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $682
line 1433
;1433:		bs->viewangles[j] = AngleMod(bs->viewangles[j] + SHORT2ANGLE(bs->cur_ps.delta_angles[j]));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 7840
ADDP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 72
ADDP4
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1001652224
MULF4
ADDF4
ARGF4
ADDRLP4 1052
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 7840
ADDP4
ADDP4
ADDRLP4 1052
INDIRF4
ASGNF4
line 1434
;1434:	}
LABELV $683
line 1432
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $682
line 1436
;1435:	//increase the local time of the bot
;1436:	bs->ltime += thinktime;
ADDRLP4 1044
ADDRLP4 4
INDIRP4
CNSTI4 6080
ADDP4
ASGNP4
ADDRLP4 1044
INDIRP4
ADDRLP4 1044
INDIRP4
INDIRF4
ADDRFP4 4
INDIRF4
ADDF4
ASGNF4
line 1438
;1437:	//
;1438:	bs->thinktime = thinktime;
ADDRLP4 4
INDIRP4
CNSTI4 4908
ADDP4
ADDRFP4 4
INDIRF4
ASGNF4
line 1440
;1439:	//origin of the bot
;1440:	VectorCopy(bs->cur_ps.origin, bs->origin);
ADDRLP4 4
INDIRP4
CNSTI4 4916
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRB
ASGNB 12
line 1442
;1441:	//eye coordinates of the bot
;1442:	VectorCopy(bs->cur_ps.origin, bs->eye);
ADDRLP4 4
INDIRP4
CNSTI4 4944
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRB
ASGNB 12
line 1443
;1443:	bs->eye[2] += bs->cur_ps.viewheight;
ADDRLP4 1060
ADDRLP4 4
INDIRP4
CNSTI4 4952
ADDP4
ASGNP4
ADDRLP4 1060
INDIRP4
ADDRLP4 1060
INDIRP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1445
;1444:	//get the area the bot is in
;1445:	bs->areanum = BotPointAreaNum(bs->origin);
ADDRLP4 4
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 1068
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 4956
ADDP4
ADDRLP4 1068
INDIRI4
ASGNI4
line 1447
;1446:	//the real AI
;1447:	BotDeathmatchAI(bs, thinktime);
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRGP4 BotDeathmatchAI
CALLV
pop
line 1449
;1448:	//set the weapon selection every AI frame
;1449:	trap_EA_SelectWeapon(bs->client, bs->weaponnum);
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 7804
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_SelectWeapon
CALLV
pop
line 1451
;1450:	//subtract the delta angles
;1451:	for (j = 0; j < 3; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $686
line 1452
;1452:		bs->viewangles[j] = AngleMod(bs->viewangles[j] - SHORT2ANGLE(bs->cur_ps.delta_angles[j]));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 7840
ADDP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 72
ADDP4
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1001652224
MULF4
SUBF4
ARGF4
ADDRLP4 1084
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 7840
ADDP4
ADDP4
ADDRLP4 1084
INDIRF4
ASGNF4
line 1453
;1453:	}
LABELV $687
line 1451
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $686
line 1455
;1454:	//everything was ok
;1455:	return qtrue;
CNSTI4 1
RETI4
LABELV $651
endproc BotAI 1088 12
export BotScheduleBotThink
proc BotScheduleBotThink 16 0
line 1463
;1456:}
;1457:
;1458:/*
;1459:==================
;1460:BotScheduleBotThink
;1461:==================
;1462:*/
;1463:void BotScheduleBotThink(void) {
line 1466
;1464:	int i, botnum;
;1465:
;1466:	botnum = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1468
;1467:
;1468:	for( i = 0; i < MAX_CLIENTS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $691
line 1469
;1469:		if( !botstates[i] || !botstates[i]->inuse ) {
ADDRLP4 12
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $697
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $695
LABELV $697
line 1470
;1470:			continue;
ADDRGP4 $692
JUMPV
LABELV $695
line 1478
;1471:		}
;1472:		//initialize the bot think residual time
;1473:		// JUHOX BUGFIX: initialize 'botthink_residual' to zero. we use a fairer schedule in 'BotAIStartFrame()'
;1474:#if 0
;1475:		botstates[i]->botthink_residual = bot_thinktime.integer * botnum / numbots;
;1476:		botnum++;
;1477:#else
;1478:		botstates[i]->botthink_residual = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 0
ASGNI4
line 1480
;1479:#endif
;1480:	}
LABELV $692
line 1468
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $691
line 1481
;1481:}
LABELV $690
endproc BotScheduleBotThink 16 0
export BotWriteSessionData
proc BotWriteSessionData 20 72
line 1488
;1482:
;1483:/*
;1484:==============
;1485:BotWriteSessionData
;1486:==============
;1487:*/
;1488:void BotWriteSessionData(bot_state_t *bs) {
line 1492
;1489:	const char	*s;
;1490:	const char	*var;
;1491:
;1492:	s = va(
ADDRGP4 $699
ARGP4
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 11716
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 11720
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 11724
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 11740
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 11768
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 11776
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 11780
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 11772
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 11728
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 11732
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 11736
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 11744
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 11748
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 11752
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 11756
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 11760
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 11764
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 1516
;1493:			"%i %i %i %i %i %i %i %i"
;1494:			" %f %f %f"
;1495:			" %f %f %f"
;1496:			" %f %f %f",
;1497:		bs->lastgoal_decisionmaker,
;1498:		bs->lastgoal_ltgtype,
;1499:		bs->lastgoal_teammate,
;1500:		bs->lastgoal_teamgoal.areanum,
;1501:		bs->lastgoal_teamgoal.entitynum,
;1502:		bs->lastgoal_teamgoal.flags,
;1503:		bs->lastgoal_teamgoal.iteminfo,
;1504:		bs->lastgoal_teamgoal.number,
;1505:		bs->lastgoal_teamgoal.origin[0],
;1506:		bs->lastgoal_teamgoal.origin[1],
;1507:		bs->lastgoal_teamgoal.origin[2],
;1508:		bs->lastgoal_teamgoal.mins[0],
;1509:		bs->lastgoal_teamgoal.mins[1],
;1510:		bs->lastgoal_teamgoal.mins[2],
;1511:		bs->lastgoal_teamgoal.maxs[0],
;1512:		bs->lastgoal_teamgoal.maxs[1],
;1513:		bs->lastgoal_teamgoal.maxs[2]
;1514:		);
;1515:
;1516:	var = va( "botsession%i", bs->client );
ADDRGP4 $700
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRP4
ASGNP4
line 1518
;1517:
;1518:	trap_Cvar_Set( var, s );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1519
;1519:}
LABELV $698
endproc BotWriteSessionData 20 72
export BotReadSessionData
proc BotReadSessionData 1036 76
line 1526
;1520:
;1521:/*
;1522:==============
;1523:BotReadSessionData
;1524:==============
;1525:*/
;1526:void BotReadSessionData(bot_state_t *bs) {
line 1530
;1527:	char	s[MAX_STRING_CHARS];
;1528:	const char	*var;
;1529:
;1530:	var = va( "botsession%i", bs->client );
ADDRGP4 $700
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 1028
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1024
ADDRLP4 1028
INDIRP4
ASGNP4
line 1531
;1531:	trap_Cvar_VariableStringBuffer( var, s, sizeof(s) );
ADDRLP4 1024
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1533
;1532:
;1533:	sscanf(s,
ADDRLP4 0
ARGP4
ADDRGP4 $699
ARGP4
ADDRLP4 1032
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1032
INDIRP4
CNSTI4 11716
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 11720
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 11724
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 11740
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 11768
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 11776
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 11780
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 11772
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 11728
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 11732
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 11736
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 11744
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 11748
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 11752
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 11756
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 11760
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 11764
ADDP4
ARGP4
ADDRGP4 sscanf
CALLI4
pop
line 1556
;1534:			"%i %i %i %i %i %i %i %i"
;1535:			" %f %f %f"
;1536:			" %f %f %f"
;1537:			" %f %f %f",
;1538:		&bs->lastgoal_decisionmaker,
;1539:		&bs->lastgoal_ltgtype,
;1540:		&bs->lastgoal_teammate,
;1541:		&bs->lastgoal_teamgoal.areanum,
;1542:		&bs->lastgoal_teamgoal.entitynum,
;1543:		&bs->lastgoal_teamgoal.flags,
;1544:		&bs->lastgoal_teamgoal.iteminfo,
;1545:		&bs->lastgoal_teamgoal.number,
;1546:		&bs->lastgoal_teamgoal.origin[0],
;1547:		&bs->lastgoal_teamgoal.origin[1],
;1548:		&bs->lastgoal_teamgoal.origin[2],
;1549:		&bs->lastgoal_teamgoal.mins[0],
;1550:		&bs->lastgoal_teamgoal.mins[1],
;1551:		&bs->lastgoal_teamgoal.mins[2],
;1552:		&bs->lastgoal_teamgoal.maxs[0],
;1553:		&bs->lastgoal_teamgoal.maxs[1],
;1554:		&bs->lastgoal_teamgoal.maxs[2]
;1555:		);
;1556:}
LABELV $701
endproc BotReadSessionData 1036 76
export BotAISetupClient
proc BotAISetupClient 520 16
line 1563
;1557:
;1558:/*
;1559:==============
;1560:BotAISetupClient
;1561:==============
;1562:*/
;1563:int BotAISetupClient(int client, struct bot_settings_s *settings, qboolean restart) {
line 1568
;1564:	char filename[MAX_PATH], name[MAX_PATH], gender[MAX_PATH];
;1565:	bot_state_t *bs;
;1566:	int errnum;
;1567:
;1568:	if (!botstates[client]) botstates[client] = G_Alloc(sizeof(bot_state_t));
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $703
CNSTI4 14420
ARGI4
ADDRLP4 440
ADDRGP4 G_Alloc
CALLP4
ASGNP4
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
ADDRLP4 440
INDIRP4
ASGNP4
LABELV $703
line 1569
;1569:	bs = botstates[client];
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
line 1571
;1570:
;1571:	if (bs && bs->inuse) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $705
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $705
line 1572
;1572:		BotAI_Print(PRT_FATAL, "BotAISetupClient: client %d already setup\n", client);
CNSTI4 4
ARGI4
ADDRGP4 $707
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 1573
;1573:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $702
JUMPV
LABELV $705
line 1576
;1574:	}
;1575:
;1576:	if (!trap_AAS_Initialized()) {
ADDRLP4 448
ADDRGP4 trap_AAS_Initialized
CALLI4
ASGNI4
ADDRLP4 448
INDIRI4
CNSTI4 0
NEI4 $708
line 1577
;1577:		BotAI_Print(PRT_FATAL, "AAS not initialized\n");
CNSTI4 4
ARGI4
ADDRGP4 $710
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 1578
;1578:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $702
JUMPV
LABELV $708
line 1582
;1579:	}
;1580:
;1581:	//load the bot character
;1582:	bs->character = trap_BotLoadCharacter(settings->characterfile, settings->skill);
ADDRLP4 452
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 452
INDIRP4
ARGP4
ADDRLP4 452
INDIRP4
CNSTI4 144
ADDP4
INDIRF4
ARGF4
ADDRLP4 456
ADDRGP4 trap_BotLoadCharacter
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 7720
ADDP4
ADDRLP4 456
INDIRI4
ASGNI4
line 1583
;1583:	if (!bs->character) {
ADDRLP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
CNSTI4 0
NEI4 $711
line 1584
;1584:		BotAI_Print(PRT_FATAL, "couldn't load skill %f from %s\n", settings->skill, settings->characterfile);
CNSTI4 4
ARGI4
ADDRGP4 $713
ARGP4
ADDRLP4 460
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 460
INDIRP4
CNSTI4 144
ADDP4
INDIRF4
ARGF4
ADDRLP4 460
INDIRP4
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 1585
;1585:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $702
JUMPV
LABELV $711
line 1588
;1586:	}
;1587:	//copy the settings
;1588:	memcpy(&bs->settings, settings, sizeof(bot_settings_t));
ADDRLP4 0
INDIRP4
CNSTI4 4608
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 296
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1590
;1589:	//allocate a goal state
;1590:	bs->gs = trap_BotAllocGoalState(client);
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 460
ADDRGP4 trap_BotAllocGoalState
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 7752
ADDP4
ADDRLP4 460
INDIRI4
ASGNI4
line 1592
;1591:	//load the item weights
;1592:	trap_Characteristic_String(bs->character, CHARACTERISTIC_ITEMWEIGHTS, filename, MAX_PATH);
ADDRLP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 40
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Characteristic_String
CALLV
pop
line 1593
;1593:	errnum = trap_BotLoadItemWeights(bs->gs, filename);
ADDRLP4 0
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 464
ADDRGP4 trap_BotLoadItemWeights
CALLI4
ASGNI4
ADDRLP4 148
ADDRLP4 464
INDIRI4
ASGNI4
line 1594
;1594:	if (errnum != BLERR_NOERROR) {
ADDRLP4 148
INDIRI4
CNSTI4 0
EQI4 $714
line 1595
;1595:		trap_BotFreeGoalState(bs->gs);
ADDRLP4 0
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeGoalState
CALLV
pop
line 1596
;1596:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $702
JUMPV
LABELV $714
line 1599
;1597:	}
;1598:	//allocate a weapon state
;1599:	bs->ws = trap_BotAllocWeaponState();
ADDRLP4 468
ADDRGP4 trap_BotAllocWeaponState
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 7760
ADDP4
ADDRLP4 468
INDIRI4
ASGNI4
line 1601
;1600:	//load the weapon weights
;1601:	trap_Characteristic_String(bs->character, CHARACTERISTIC_WEAPONWEIGHTS, filename, MAX_PATH);
ADDRLP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Characteristic_String
CALLV
pop
line 1602
;1602:	errnum = trap_BotLoadWeaponWeights(bs->ws, filename);
ADDRLP4 0
INDIRP4
CNSTI4 7760
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 472
ADDRGP4 trap_BotLoadWeaponWeights
CALLI4
ASGNI4
ADDRLP4 148
ADDRLP4 472
INDIRI4
ASGNI4
line 1603
;1603:	if (errnum != BLERR_NOERROR) {
ADDRLP4 148
INDIRI4
CNSTI4 0
EQI4 $716
line 1604
;1604:		trap_BotFreeGoalState(bs->gs);
ADDRLP4 0
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeGoalState
CALLV
pop
line 1605
;1605:		trap_BotFreeWeaponState(bs->ws);
ADDRLP4 0
INDIRP4
CNSTI4 7760
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeWeaponState
CALLV
pop
line 1606
;1606:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $702
JUMPV
LABELV $716
line 1609
;1607:	}
;1608:	//allocate a chat state
;1609:	bs->cs = trap_BotAllocChatState();
ADDRLP4 476
ADDRGP4 trap_BotAllocChatState
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 7756
ADDP4
ADDRLP4 476
INDIRI4
ASGNI4
line 1611
;1610:	//load the chat file
;1611:	trap_Characteristic_String(bs->character, CHARACTERISTIC_CHAT_FILE, filename, MAX_PATH);
ADDRLP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 21
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Characteristic_String
CALLV
pop
line 1612
;1612:	trap_Characteristic_String(bs->character, CHARACTERISTIC_CHAT_NAME, name, MAX_PATH);
ADDRLP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 22
ARGI4
ADDRLP4 296
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Characteristic_String
CALLV
pop
line 1613
;1613:	errnum = trap_BotLoadChatFile(bs->cs, filename, name);
ADDRLP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 296
ARGP4
ADDRLP4 480
ADDRGP4 trap_BotLoadChatFile
CALLI4
ASGNI4
ADDRLP4 148
ADDRLP4 480
INDIRI4
ASGNI4
line 1614
;1614:	if (errnum != BLERR_NOERROR) {
ADDRLP4 148
INDIRI4
CNSTI4 0
EQI4 $718
line 1615
;1615:		trap_BotFreeChatState(bs->cs);
ADDRLP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeChatState
CALLV
pop
line 1616
;1616:		trap_BotFreeGoalState(bs->gs);
ADDRLP4 0
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeGoalState
CALLV
pop
line 1617
;1617:		trap_BotFreeWeaponState(bs->ws);
ADDRLP4 0
INDIRP4
CNSTI4 7760
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeWeaponState
CALLV
pop
line 1618
;1618:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $702
JUMPV
LABELV $718
line 1621
;1619:	}
;1620:	//get the gender characteristic
;1621:	trap_Characteristic_String(bs->character, CHARACTERISTIC_GENDER, gender, MAX_PATH);
ADDRLP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 152
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Characteristic_String
CALLV
pop
line 1623
;1622:	//set the chat gender
;1623:	if (*gender == 'f' || *gender == 'F') trap_BotSetChatGender(bs->cs, CHAT_GENDERFEMALE);
ADDRLP4 484
ADDRLP4 152
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 484
INDIRI4
CNSTI4 102
EQI4 $722
ADDRLP4 484
INDIRI4
CNSTI4 70
NEI4 $720
LABELV $722
ADDRLP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotSetChatGender
CALLV
pop
ADDRGP4 $721
JUMPV
LABELV $720
line 1624
;1624:	else if (*gender == 'm' || *gender == 'M') trap_BotSetChatGender(bs->cs, CHAT_GENDERMALE);
ADDRLP4 488
ADDRLP4 152
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 488
INDIRI4
CNSTI4 109
EQI4 $725
ADDRLP4 488
INDIRI4
CNSTI4 77
NEI4 $723
LABELV $725
ADDRLP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotSetChatGender
CALLV
pop
ADDRGP4 $724
JUMPV
LABELV $723
line 1625
;1625:	else trap_BotSetChatGender(bs->cs, CHAT_GENDERLESS);
ADDRLP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotSetChatGender
CALLV
pop
LABELV $724
LABELV $721
line 1627
;1626:
;1627:	memset(&bs->humanHelpers, -1, sizeof(bs->humanHelpers));	// JUHOX
ADDRLP4 0
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
line 1628
;1628:	bs->leader = -1;	// JUHOX
ADDRLP4 0
INDIRP4
CNSTI4 11872
ADDP4
CNSTI4 -1
ASGNI4
line 1630
;1629:
;1630:	bs->inuse = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 1
ASGNI4
line 1631
;1631:	bs->client = client;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 1632
;1632:	bs->entitynum = client;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 1633
;1633:	bs->setupcount = 4;
ADDRLP4 0
INDIRP4
CNSTI4 6036
ADDP4
CNSTI4 4
ASGNI4
line 1634
;1634:	bs->entergame_time = FloatTime();
ADDRLP4 0
INDIRP4
CNSTI4 6084
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 1635
;1635:	bs->ms = trap_BotAllocMoveState();
ADDRLP4 492
ADDRGP4 trap_BotAllocMoveState
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 7724
ADDP4
ADDRLP4 492
INDIRI4
ASGNI4
line 1636
;1636:	bs->walker = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_WALKER, 0, 1);
ADDRLP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 48
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 500
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 6076
ADDP4
ADDRLP4 500
INDIRF4
ASGNF4
line 1637
;1637:	numbots++;
ADDRLP4 504
ADDRGP4 numbots
ASGNP4
ADDRLP4 504
INDIRP4
ADDRLP4 504
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1639
;1638:
;1639:	if (trap_Cvar_VariableIntegerValue("bot_testichat")) {
ADDRGP4 $728
ARGP4
ADDRLP4 508
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRLP4 508
INDIRI4
CNSTI4 0
EQI4 $726
line 1640
;1640:		trap_BotLibVarSet("bot_testichat", "1");
ADDRGP4 $728
ARGP4
ADDRGP4 $378
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 1641
;1641:		BotChatTest(bs);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 BotChatTest
CALLV
pop
line 1642
;1642:	}
LABELV $726
line 1644
;1643:	//NOTE: reschedule the bot thinking
;1644:	BotScheduleBotThink();
ADDRGP4 BotScheduleBotThink
CALLV
pop
line 1646
;1645:	//if interbreeding start with a mutation
;1646:	if (bot_interbreed) {
ADDRGP4 bot_interbreed
INDIRI4
CNSTI4 0
EQI4 $729
line 1647
;1647:		trap_BotMutateGoalFuzzyLogic(bs->gs, 1);
ADDRLP4 0
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_BotMutateGoalFuzzyLogic
CALLV
pop
line 1648
;1648:	}
LABELV $729
line 1650
;1649:	// if we kept the bot client
;1650:	if (restart) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $731
line 1651
;1651:		BotReadSessionData(bs);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 BotReadSessionData
CALLV
pop
line 1652
;1652:	}
LABELV $731
line 1653
;1653:	bs->reactiontime = BotReactionTime(bs);	// JUHOX
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 516
ADDRGP4 BotReactionTime
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 4912
ADDP4
ADDRLP4 516
INDIRF4
ASGNF4
line 1655
;1654:	//bot has been setup succesfully
;1655:	return qtrue;
CNSTI4 1
RETI4
LABELV $702
endproc BotAISetupClient 520 16
export BotAIShutdownClient
proc BotAIShutdownClient 16 12
line 1663
;1656:}
;1657:
;1658:/*
;1659:==============
;1660:BotAIShutdownClient
;1661:==============
;1662:*/
;1663:int BotAIShutdownClient(int client, qboolean restart) {
line 1666
;1664:	bot_state_t *bs;
;1665:
;1666:	bs = botstates[client];
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
line 1667
;1667:	if (!bs || !bs->inuse) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $736
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $734
LABELV $736
line 1669
;1668:		//BotAI_Print(PRT_ERROR, "BotAIShutdownClient: client %d already shutdown\n", client);
;1669:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $733
JUMPV
LABELV $734
line 1672
;1670:	}
;1671:
;1672:	if (restart) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $737
line 1673
;1673:		BotWriteSessionData(bs);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 BotWriteSessionData
CALLV
pop
line 1674
;1674:	}
LABELV $737
line 1676
;1675:
;1676:	if (BotChat_ExitGame(bs)) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BotChat_ExitGame
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $739
line 1677
;1677:		trap_BotEnterChat(bs->cs, bs->client, CHAT_ALL);
ADDRLP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1678
;1678:	}
LABELV $739
line 1680
;1679:
;1680:	trap_BotFreeMoveState(bs->ms);
ADDRLP4 0
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeMoveState
CALLV
pop
line 1682
;1681:	//free the goal state`			
;1682:	trap_BotFreeGoalState(bs->gs);
ADDRLP4 0
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeGoalState
CALLV
pop
line 1684
;1683:	//free the chat file
;1684:	trap_BotFreeChatState(bs->cs);
ADDRLP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeChatState
CALLV
pop
line 1686
;1685:	//free the weapon weights
;1686:	trap_BotFreeWeaponState(bs->ws);
ADDRLP4 0
INDIRP4
CNSTI4 7760
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeWeaponState
CALLV
pop
line 1688
;1687:	//free the bot character
;1688:	trap_BotFreeCharacter(bs->character);
ADDRLP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeCharacter
CALLV
pop
line 1690
;1689:	//
;1690:	BotFreeWaypoints(bs->checkpoints);
ADDRLP4 0
INDIRP4
CNSTI4 14404
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotFreeWaypoints
CALLV
pop
line 1691
;1691:	BotFreeWaypoints(bs->patrolpoints);
ADDRLP4 0
INDIRP4
CNSTI4 14408
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotFreeWaypoints
CALLV
pop
line 1693
;1692:	//clear activate goal stack
;1693:	BotClearActivateGoalStack(bs);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 BotClearActivateGoalStack
CALLV
pop
line 1695
;1694:	//clear the bot state
;1695:	memset(bs, 0, sizeof(bot_state_t));
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 14420
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1697
;1696:	//set the inuse flag to qfalse
;1697:	bs->inuse = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 1699
;1698:	//there's one bot less
;1699:	numbots--;
ADDRLP4 12
ADDRGP4 numbots
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1701
;1700:	//everything went ok
;1701:	return qtrue;
CNSTI4 1
RETI4
LABELV $733
endproc BotAIShutdownClient 16 12
export BotResetState
proc BotResetState 808 12
line 1712
;1702:}
;1703:
;1704:/*
;1705:==============
;1706:BotResetState
;1707:
;1708:called when a bot enters the intermission or observer mode and
;1709:when the level is changed
;1710:==============
;1711:*/
;1712:void BotResetState(bot_state_t *bs) {
line 1721
;1713:	int client, entitynum, inuse;
;1714:	int movestate, goalstate, chatstate, weaponstate;
;1715:	bot_settings_t settings;
;1716:	int character;
;1717:	playerState_t ps;							//current player state
;1718:	float entergame_time;
;1719:
;1720:	//save some things that should not be reset here
;1721:	memcpy(&settings, &bs->settings, sizeof(bot_settings_t));
ADDRLP4 28
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 4608
ADDP4
ARGP4
CNSTI4 296
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1722
;1722:	memcpy(&ps, &bs->cur_ps, sizeof(playerState_t));
ADDRLP4 328
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTI4 468
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1723
;1723:	inuse = bs->inuse;
ADDRLP4 8
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 1724
;1724:	client = bs->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1725
;1725:	entitynum = bs->entitynum;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1726
;1726:	character = bs->character;
ADDRLP4 324
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ASGNI4
line 1727
;1727:	movestate = bs->ms;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ASGNI4
line 1728
;1728:	goalstate = bs->gs;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ASGNI4
line 1729
;1729:	chatstate = bs->cs;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ASGNI4
line 1730
;1730:	weaponstate = bs->ws;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 7760
ADDP4
INDIRI4
ASGNI4
line 1731
;1731:	entergame_time = bs->entergame_time;
ADDRLP4 796
ADDRFP4 0
INDIRP4
CNSTI4 6084
ADDP4
INDIRF4
ASGNF4
line 1733
;1732:	//free checkpoints and patrol points
;1733:	BotFreeWaypoints(bs->checkpoints);
ADDRFP4 0
INDIRP4
CNSTI4 14404
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotFreeWaypoints
CALLV
pop
line 1734
;1734:	BotFreeWaypoints(bs->patrolpoints);
ADDRFP4 0
INDIRP4
CNSTI4 14408
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotFreeWaypoints
CALLV
pop
line 1736
;1735:	//reset the whole state
;1736:	memset(bs, 0, sizeof(bot_state_t));
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 14420
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1738
;1737:	//copy back some state stuff that should not be reset
;1738:	bs->ms = movestate;
ADDRFP4 0
INDIRP4
CNSTI4 7724
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 1739
;1739:	bs->gs = goalstate;
ADDRFP4 0
INDIRP4
CNSTI4 7752
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 1740
;1740:	bs->cs = chatstate;
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
line 1741
;1741:	bs->ws = weaponstate;
ADDRFP4 0
INDIRP4
CNSTI4 7760
ADDP4
ADDRLP4 24
INDIRI4
ASGNI4
line 1742
;1742:	memcpy(&bs->cur_ps, &ps, sizeof(playerState_t));
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 328
ARGP4
CNSTI4 468
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1743
;1743:	memcpy(&bs->settings, &settings, sizeof(bot_settings_t));
ADDRFP4 0
INDIRP4
CNSTI4 4608
ADDP4
ARGP4
ADDRLP4 28
ARGP4
CNSTI4 296
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1744
;1744:	bs->inuse = inuse;
ADDRFP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ASGNI4
line 1745
;1745:	bs->client = client;
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1746
;1746:	bs->entitynum = entitynum;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 1747
;1747:	bs->character = character;
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
ADDRLP4 324
INDIRI4
ASGNI4
line 1748
;1748:	bs->entergame_time = entergame_time;
ADDRFP4 0
INDIRP4
CNSTI4 6084
ADDP4
ADDRLP4 796
INDIRF4
ASGNF4
line 1750
;1749:	//reset several states
;1750:	if (bs->ms) trap_BotResetMoveState(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
CNSTI4 0
EQI4 $742
ADDRFP4 0
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetMoveState
CALLV
pop
LABELV $742
line 1751
;1751:	if (bs->gs) trap_BotResetGoalState(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
CNSTI4 0
EQI4 $744
ADDRFP4 0
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetGoalState
CALLV
pop
LABELV $744
line 1752
;1752:	if (bs->ws) trap_BotResetWeaponState(bs->ws);
ADDRFP4 0
INDIRP4
CNSTI4 7760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $746
ADDRFP4 0
INDIRP4
CNSTI4 7760
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetWeaponState
CALLV
pop
LABELV $746
line 1753
;1753:	if (bs->gs) trap_BotResetAvoidGoals(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
CNSTI4 0
EQI4 $748
ADDRFP4 0
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidGoals
CALLV
pop
LABELV $748
line 1754
;1754:	if (bs->ms) trap_BotResetAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
CNSTI4 0
EQI4 $750
ADDRFP4 0
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidReach
CALLV
pop
LABELV $750
line 1755
;1755:	memset(&bs->humanHelpers, -1, sizeof(bs->humanHelpers));	// JUHOX
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
line 1756
;1756:	bs->leader = -1;	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 11872
ADDP4
CNSTI4 -1
ASGNI4
line 1757
;1757:	bs->reactiontime = BotReactionTime(bs);	// JUHOX
ADDRLP4 800
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 800
INDIRP4
ARGP4
ADDRLP4 804
ADDRGP4 BotReactionTime
CALLF4
ASGNF4
ADDRLP4 800
INDIRP4
CNSTI4 4912
ADDP4
ADDRLP4 804
INDIRF4
ASGNF4
line 1758
;1758:}
LABELV $741
endproc BotResetState 808 12
export BotAILoadMap
proc BotAILoadMap 284 16
line 1765
;1759:
;1760:/*
;1761:==============
;1762:BotAILoadMap
;1763:==============
;1764:*/
;1765:int BotAILoadMap( int restart ) {
line 1769
;1766:	int			i;
;1767:	vmCvar_t	mapname;
;1768:
;1769:	if (!restart) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $753
line 1770
;1770:		trap_Cvar_Register( &mapname, "mapname", "", CVAR_SERVERINFO | CVAR_ROM );
ADDRLP4 4
ARGP4
ADDRGP4 $755
ARGP4
ADDRGP4 $362
ARGP4
CNSTI4 68
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1771
;1771:		trap_BotLibLoadMap( mapname.string );
ADDRLP4 4+16
ARGP4
ADDRGP4 trap_BotLibLoadMap
CALLI4
pop
line 1772
;1772:	}
LABELV $753
line 1774
;1773:
;1774:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $757
line 1775
;1775:		if (botstates[i] && botstates[i]->inuse) {
ADDRLP4 280
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 280
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $761
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 280
INDIRP4
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $761
line 1776
;1776:			BotResetState( botstates[i] );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotResetState
CALLV
pop
line 1777
;1777:			botstates[i]->setupcount = 4;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 6036
ADDP4
CNSTI4 4
ASGNI4
line 1778
;1778:		}
LABELV $761
line 1779
;1779:	}
LABELV $758
line 1774
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $757
line 1781
;1780:
;1781:	BotSetupDeathmatchAI();
ADDRGP4 BotSetupDeathmatchAI
CALLV
pop
line 1783
;1782:
;1783:	return qtrue;
CNSTI4 1
RETI4
LABELV $752
endproc BotAILoadMap 284 16
bss
align 4
LABELV $764
skip 4
align 4
LABELV $765
skip 4
align 4
LABELV $766
skip 4
export BotAIStartFrame
code
proc BotAIStartFrame 172 12
line 1795
;1784:}
;1785:
;1786:#ifdef MISSIONPACK
;1787:void ProximityMine_Trigger( gentity_t *trigger, gentity_t *other, trace_t *trace );
;1788:#endif
;1789:
;1790:/*
;1791:==================
;1792:BotAIStartFrame
;1793:==================
;1794:*/
;1795:int BotAIStartFrame(int time) {
line 1806
;1796:	int i;
;1797:	gentity_t	*ent;
;1798:	bot_entitystate_t state;
;1799:	int elapsed_time, thinktime;
;1800:	static int local_time;
;1801:	static int botlib_residual;
;1802:	static int lastbotthink_time;
;1803:
;1804:#if ESCAPE_MODE	// JUHOX: no bots in EFH
;1805:	if (
;1806:		g_gametype.integer == GT_EFH ||
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
EQI4 $771
ADDRGP4 $770
ARGP4
ADDRLP4 128
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRLP4 128
INDIRI4
CNSTI4 0
NEI4 $767
LABELV $771
line 1808
;1807:		!trap_Cvar_VariableIntegerValue("bot_enable")
;1808:	) {
line 1809
;1809:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $763
JUMPV
LABELV $767
line 1813
;1810:	}
;1811:#endif
;1812:
;1813:	BotFindCTFBases();	// JUHOX
ADDRGP4 BotFindCTFBases
CALLV
pop
line 1815
;1814:
;1815:	G_CheckBotSpawn();
ADDRGP4 G_CheckBotSpawn
CALLV
pop
line 1817
;1816:
;1817:	trap_Cvar_Update(&bot_rocketjump);
ADDRGP4 bot_rocketjump
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1818
;1818:	trap_Cvar_Update(&bot_grapple);
ADDRGP4 bot_grapple
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1819
;1819:	trap_Cvar_Update(&bot_fastchat);
ADDRGP4 bot_fastchat
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1820
;1820:	trap_Cvar_Update(&bot_nochat);
ADDRGP4 bot_nochat
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1821
;1821:	trap_Cvar_Update(&bot_testrchat);
ADDRGP4 bot_testrchat
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1822
;1822:	trap_Cvar_Update(&bot_thinktime);
ADDRGP4 bot_thinktime
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1823
;1823:	trap_Cvar_Update(&bot_memorydump);
ADDRGP4 bot_memorydump
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1824
;1824:	trap_Cvar_Update(&bot_saveroutingcache);
ADDRGP4 bot_saveroutingcache
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1825
;1825:	trap_Cvar_Update(&bot_pause);
ADDRGP4 bot_pause
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1826
;1826:	trap_Cvar_Update(&bot_report);
ADDRGP4 bot_report
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1828
;1827:
;1828:	if (bot_report.integer) {
ADDRGP4 bot_report+12
INDIRI4
CNSTI4 0
EQI4 $772
line 1831
;1829://		BotTeamplayReport();
;1830://		trap_Cvar_Set("bot_report", "0");
;1831:		BotUpdateInfoConfigStrings();
ADDRGP4 BotUpdateInfoConfigStrings
CALLV
pop
line 1832
;1832:	}
LABELV $772
line 1834
;1833:
;1834:	if (bot_pause.integer) {
ADDRGP4 bot_pause+12
INDIRI4
CNSTI4 0
EQI4 $775
line 1836
;1835:		// execute bot user commands every frame
;1836:		for( i = 0; i < MAX_CLIENTS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $778
line 1837
;1837:			if( !botstates[i] || !botstates[i]->inuse ) {
ADDRLP4 136
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 136
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $784
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 136
INDIRP4
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $782
LABELV $784
line 1838
;1838:				continue;
ADDRGP4 $779
JUMPV
LABELV $782
line 1840
;1839:			}
;1840:			if( g_entities[i].client->pers.connected != CON_CONNECTED ) {
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
EQI4 $785
line 1841
;1841:				continue;
ADDRGP4 $779
JUMPV
LABELV $785
line 1843
;1842:			}
;1843:			botstates[i]->lastucmd.forwardmove = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 509
ADDP4
CNSTI1 0
ASGNI1
line 1844
;1844:			botstates[i]->lastucmd.rightmove = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 510
ADDP4
CNSTI1 0
ASGNI1
line 1845
;1845:			botstates[i]->lastucmd.upmove = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 511
ADDP4
CNSTI1 0
ASGNI1
line 1846
;1846:			botstates[i]->lastucmd.buttons = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 504
ADDP4
CNSTI4 0
ASGNI4
line 1847
;1847:			botstates[i]->lastucmd.serverTime = time;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 488
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 1848
;1848:			trap_BotUserCommand(botstates[i]->client, &botstates[i]->lastucmd);
ADDRLP4 144
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 144
INDIRP4
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 144
INDIRP4
ADDP4
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRGP4 trap_BotUserCommand
CALLV
pop
line 1849
;1849:		}
LABELV $779
line 1836
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $778
line 1850
;1850:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $763
JUMPV
LABELV $775
line 1853
;1851:	}
;1852:
;1853:	if (bot_memorydump.integer) {
ADDRGP4 bot_memorydump+12
INDIRI4
CNSTI4 0
EQI4 $788
line 1854
;1854:		trap_BotLibVarSet("memorydump", "1");
ADDRGP4 $791
ARGP4
ADDRGP4 $378
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 1855
;1855:		trap_Cvar_Set("bot_memorydump", "0");
ADDRGP4 $792
ARGP4
ADDRGP4 $793
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1856
;1856:	}
LABELV $788
line 1857
;1857:	if (bot_saveroutingcache.integer) {
ADDRGP4 bot_saveroutingcache+12
INDIRI4
CNSTI4 0
EQI4 $794
line 1858
;1858:		trap_BotLibVarSet("saveroutingcache", "1");
ADDRGP4 $797
ARGP4
ADDRGP4 $378
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 1859
;1859:		trap_Cvar_Set("bot_saveroutingcache", "0");
ADDRGP4 $798
ARGP4
ADDRGP4 $793
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1860
;1860:	}
LABELV $794
line 1862
;1861:	//check if bot interbreeding is activated
;1862:	BotInterbreeding();
ADDRGP4 BotInterbreeding
CALLV
pop
line 1864
;1863:	//cap the bot think time
;1864:	if (bot_thinktime.integer > 200) {
ADDRGP4 bot_thinktime+12
INDIRI4
CNSTI4 200
LEI4 $799
line 1865
;1865:		trap_Cvar_Set("bot_thinktime", "200");
ADDRGP4 $802
ARGP4
ADDRGP4 $803
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1866
;1866:	}
LABELV $799
line 1868
;1867:	//if the bot think time changed we should reschedule the bots
;1868:	if (bot_thinktime.integer != lastbotthink_time) {
ADDRGP4 bot_thinktime+12
INDIRI4
ADDRGP4 $766
INDIRI4
EQI4 $804
line 1869
;1869:		lastbotthink_time = bot_thinktime.integer;
ADDRGP4 $766
ADDRGP4 bot_thinktime+12
INDIRI4
ASGNI4
line 1870
;1870:		BotScheduleBotThink();
ADDRGP4 BotScheduleBotThink
CALLV
pop
line 1871
;1871:	}
LABELV $804
line 1873
;1872:
;1873:	elapsed_time = time - local_time;
ADDRLP4 120
ADDRFP4 0
INDIRI4
ADDRGP4 $764
INDIRI4
SUBI4
ASGNI4
line 1874
;1874:	local_time = time;
ADDRGP4 $764
ADDRFP4 0
INDIRI4
ASGNI4
line 1876
;1875:
;1876:	botlib_residual += elapsed_time;
ADDRLP4 132
ADDRGP4 $765
ASGNP4
ADDRLP4 132
INDIRP4
ADDRLP4 132
INDIRP4
INDIRI4
ADDRLP4 120
INDIRI4
ADDI4
ASGNI4
line 1878
;1877:
;1878:	if (elapsed_time > bot_thinktime.integer) thinktime = elapsed_time;
ADDRLP4 120
INDIRI4
ADDRGP4 bot_thinktime+12
INDIRI4
LEI4 $808
ADDRLP4 124
ADDRLP4 120
INDIRI4
ASGNI4
ADDRGP4 $809
JUMPV
LABELV $808
line 1879
;1879:	else thinktime = bot_thinktime.integer;
ADDRLP4 124
ADDRGP4 bot_thinktime+12
INDIRI4
ASGNI4
LABELV $809
line 1882
;1880:
;1881:	// update the bot library
;1882:	if ( botlib_residual >= thinktime ) {
ADDRGP4 $765
INDIRI4
ADDRLP4 124
INDIRI4
LTI4 $812
line 1883
;1883:		botlib_residual -= thinktime;
ADDRLP4 136
ADDRGP4 $765
ASGNP4
ADDRLP4 136
INDIRP4
ADDRLP4 136
INDIRP4
INDIRI4
ADDRLP4 124
INDIRI4
SUBI4
ASGNI4
line 1885
;1884:
;1885:		trap_BotLibStartFrame((float) time / 1000);
ADDRFP4 0
INDIRI4
CVIF4 4
CNSTF4 981668463
MULF4
ARGF4
ADDRGP4 trap_BotLibStartFrame
CALLI4
pop
line 1887
;1886:
;1887:		if (!trap_AAS_Initialized()) return qfalse;
ADDRLP4 140
ADDRGP4 trap_AAS_Initialized
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
NEI4 $814
CNSTI4 0
RETI4
ADDRGP4 $763
JUMPV
LABELV $814
line 1890
;1888:
;1889:		//update entities in the botlib
;1890:		for (i = 0; i < MAX_GENTITIES; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $816
line 1891
;1891:			ent = &g_entities[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1892
;1892:			if (!ent->inuse) {
ADDRLP4 4
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $820
line 1893
;1893:				trap_BotLibUpdateEntity(i, NULL);
ADDRLP4 0
INDIRI4
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 trap_BotLibUpdateEntity
CALLI4
pop
line 1894
;1894:				continue;
ADDRGP4 $817
JUMPV
LABELV $820
line 1896
;1895:			}
;1896:			if (!ent->r.linked) {
ADDRLP4 4
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
CNSTI4 0
NEI4 $822
line 1897
;1897:				trap_BotLibUpdateEntity(i, NULL);
ADDRLP4 0
INDIRI4
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 trap_BotLibUpdateEntity
CALLI4
pop
line 1898
;1898:				continue;
ADDRGP4 $817
JUMPV
LABELV $822
line 1900
;1899:			}
;1900:			if (ent->r.svFlags & SVF_NOCLIENT) {
ADDRLP4 4
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $824
line 1901
;1901:				trap_BotLibUpdateEntity(i, NULL);
ADDRLP4 0
INDIRI4
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 trap_BotLibUpdateEntity
CALLI4
pop
line 1902
;1902:				continue;
ADDRGP4 $817
JUMPV
LABELV $824
line 1905
;1903:			}
;1904:			// do not update missiles
;1905:			if (ent->s.eType == ET_MISSILE && ent->s.weapon != WP_GRAPPLING_HOOK) {
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $826
ADDRLP4 4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 10
EQI4 $826
line 1906
;1906:				trap_BotLibUpdateEntity(i, NULL);
ADDRLP4 0
INDIRI4
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 trap_BotLibUpdateEntity
CALLI4
pop
line 1907
;1907:				continue;
ADDRGP4 $817
JUMPV
LABELV $826
line 1910
;1908:			}
;1909:			// do not update event only entities
;1910:			if (ent->s.eType > ET_EVENTS) {
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 14
LEI4 $828
line 1911
;1911:				trap_BotLibUpdateEntity(i, NULL);
ADDRLP4 0
INDIRI4
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 trap_BotLibUpdateEntity
CALLI4
pop
line 1912
;1912:				continue;
ADDRGP4 $817
JUMPV
LABELV $828
line 1917
;1913:			}
;1914:			// JUHOX: do not update armor fragments in the bot library
;1915:#if 1
;1916:			if (
;1917:				ent->s.eType == ET_ITEM &&
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $830
ADDRLP4 4
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 3
NEI4 $830
ADDRLP4 4
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 0
EQI4 $830
line 1920
;1918:				ent->item->giType == IT_ARMOR &&
;1919:				ent->item->giTag
;1920:			) {
line 1921
;1921:				trap_BotLibUpdateEntity(i, NULL);
ADDRLP4 0
INDIRI4
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 trap_BotLibUpdateEntity
CALLI4
pop
line 1922
;1922:				continue;
ADDRGP4 $817
JUMPV
LABELV $830
line 1935
;1923:			}
;1924:#endif
;1925:#ifdef MISSIONPACK
;1926:			// never link prox mine triggers
;1927:			if (ent->r.contents == CONTENTS_TRIGGER) {
;1928:				if (ent->touch == ProximityMine_Trigger) {
;1929:					trap_BotLibUpdateEntity(i, NULL);
;1930:					continue;
;1931:				}
;1932:			}
;1933:#endif
;1934:			//
;1935:			memset(&state, 0, sizeof(bot_entitystate_t));
ADDRLP4 8
ARGP4
CNSTI4 0
ARGI4
CNSTI4 112
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1937
;1936:			//
;1937:			VectorCopy(ent->r.currentOrigin, state.origin);
ADDRLP4 8+8
ADDRLP4 4
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 1938
;1938:			if (i < MAX_CLIENTS) {
ADDRLP4 0
INDIRI4
CNSTI4 64
GEI4 $833
line 1939
;1939:				VectorCopy(ent->s.apos.trBase, state.angles);
ADDRLP4 8+20
ADDRLP4 4
INDIRP4
CNSTI4 60
ADDP4
INDIRB
ASGNB 12
line 1940
;1940:			} else {
ADDRGP4 $834
JUMPV
LABELV $833
line 1941
;1941:				VectorCopy(ent->r.currentAngles, state.angles);
ADDRLP4 8+20
ADDRLP4 4
INDIRP4
CNSTI4 500
ADDP4
INDIRB
ASGNB 12
line 1942
;1942:			}
LABELV $834
line 1943
;1943:			VectorCopy(ent->s.origin2, state.old_origin);
ADDRLP4 8+32
ADDRLP4 4
INDIRP4
CNSTI4 104
ADDP4
INDIRB
ASGNB 12
line 1944
;1944:			VectorCopy(ent->r.mins, state.mins);
ADDRLP4 8+44
ADDRLP4 4
INDIRP4
CNSTI4 436
ADDP4
INDIRB
ASGNB 12
line 1945
;1945:			VectorCopy(ent->r.maxs, state.maxs);
ADDRLP4 8+56
ADDRLP4 4
INDIRP4
CNSTI4 448
ADDP4
INDIRB
ASGNB 12
line 1946
;1946:			state.type = ent->s.eType;
ADDRLP4 8
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1947
;1947:			state.flags = ent->s.eFlags;
ADDRLP4 8+4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1948
;1948:			if (ent->r.bmodel) state.solid = SOLID_BSP;
ADDRLP4 4
INDIRP4
CNSTI4 432
ADDP4
INDIRI4
CNSTI4 0
EQI4 $841
ADDRLP4 8+72
CNSTI4 3
ASGNI4
ADDRGP4 $842
JUMPV
LABELV $841
line 1949
;1949:			else state.solid = SOLID_BBOX;
ADDRLP4 8+72
CNSTI4 2
ASGNI4
LABELV $842
line 1950
;1950:			state.groundent = ent->s.groundEntityNum;
ADDRLP4 8+68
ADDRLP4 4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ASGNI4
line 1951
;1951:			state.modelindex = ent->s.modelindex;
ADDRLP4 8+76
ADDRLP4 4
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ASGNI4
line 1952
;1952:			state.modelindex2 = ent->s.modelindex2;
ADDRLP4 8+80
ADDRLP4 4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
ASGNI4
line 1953
;1953:			state.frame = ent->s.frame;
ADDRLP4 8+84
ADDRLP4 4
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
ASGNI4
line 1954
;1954:			state.event = ent->s.event;
ADDRLP4 8+88
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ASGNI4
line 1955
;1955:			state.eventParm = ent->s.eventParm;
ADDRLP4 8+92
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 1956
;1956:			state.powerups = ent->s.powerups;
ADDRLP4 8+96
ADDRLP4 4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ASGNI4
line 1957
;1957:			state.legsAnim = ent->s.legsAnim;
ADDRLP4 8+104
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
line 1958
;1958:			state.torsoAnim = ent->s.torsoAnim;
ADDRLP4 8+108
ADDRLP4 4
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ASGNI4
line 1959
;1959:			state.weapon = ent->s.weapon;
ADDRLP4 8+100
ADDRLP4 4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ASGNI4
line 1961
;1960:			//
;1961:			trap_BotLibUpdateEntity(i, &state);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
ADDRGP4 trap_BotLibUpdateEntity
CALLI4
pop
line 1962
;1962:		}
LABELV $817
line 1890
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1024
LTI4 $816
line 1964
;1963:
;1964:		BotAIRegularUpdate();
ADDRGP4 BotAIRegularUpdate
CALLV
pop
line 1965
;1965:	}
LABELV $812
line 1967
;1966:
;1967:	floattime = trap_AAS_Time();
ADDRLP4 136
ADDRGP4 trap_AAS_Time
CALLF4
ASGNF4
ADDRGP4 floattime
ADDRLP4 136
INDIRF4
ASGNF4
line 1970
;1968:
;1969:	// execute scheduled bot AI
;1970:	for( i = 0; i < MAX_CLIENTS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $855
line 1971
;1971:		if( !botstates[i] || !botstates[i]->inuse ) {
ADDRLP4 144
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 144
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $861
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 144
INDIRP4
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $859
LABELV $861
line 1972
;1972:			continue;
ADDRGP4 $856
JUMPV
LABELV $859
line 1975
;1973:		}
;1974:		//
;1975:		botstates[i]->botthink_residual += elapsed_time;
ADDRLP4 148
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 148
INDIRP4
ADDRLP4 148
INDIRP4
INDIRI4
ADDRLP4 120
INDIRI4
ADDI4
ASGNI4
line 1990
;1976:		//
;1977:		// JUHOX BUGFIX: randomize the bot schedule
;1978:		// JUHOX: faster AI for fast bots
;1979:#if 0
;1980:		if ( botstates[i]->botthink_residual >= thinktime ) {
;1981:			botstates[i]->botthink_residual -= thinktime;
;1982:
;1983:			if (!trap_AAS_Initialized()) return qfalse;
;1984:
;1985:			if (g_entities[i].client->pers.connected == CON_CONNECTED) {
;1986:				BotAI(i, (float) thinktime / 1000);
;1987:			}
;1988:		}
;1989:#else
;1990:		{
line 2001
;1991:			int avgThinkTime, t;
;1992:
;1993:			/*
;1994:			avgThinkTime = bot_thinktime.integer;
;1995:			t = thinktime;
;1996:			if (botstates[i]->reactiontime < 0.2) {
;1997:				avgThinkTime = avgThinkTime >> 1;
;1998:				t = t >> 1;
;1999:			}
;2000:			*/
;2001:			avgThinkTime = 500.0 * botstates[i]->reactiontime;
ADDRLP4 156
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
CNSTF4 1140457472
MULF4
CVFI4 4
ASGNI4
line 2002
;2002:			t = thinktime;
ADDRLP4 152
ADDRLP4 124
INDIRI4
ASGNI4
line 2004
;2003:
;2004:			if (botstates[i]->botthink_residual + (rand() % avgThinkTime) >= t) {
ADDRLP4 160
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 160
INDIRI4
ADDRLP4 156
INDIRI4
MODI4
ADDI4
ADDRLP4 152
INDIRI4
LTI4 $862
line 2005
;2005:				botstates[i]->botthink_residual -= t;
ADDRLP4 164
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 164
INDIRP4
ADDRLP4 164
INDIRP4
INDIRI4
ADDRLP4 152
INDIRI4
SUBI4
ASGNI4
line 2007
;2006:
;2007:				if (!trap_AAS_Initialized()) return qfalse;
ADDRLP4 168
ADDRGP4 trap_AAS_Initialized
CALLI4
ASGNI4
ADDRLP4 168
INDIRI4
CNSTI4 0
NEI4 $864
CNSTI4 0
RETI4
ADDRGP4 $763
JUMPV
LABELV $864
line 2009
;2008:
;2009:				if (g_entities[i].client->pers.connected == CON_CONNECTED) {
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
NEI4 $866
line 2010
;2010:					BotAI(i, (float) t / 1000);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 152
INDIRI4
CVIF4 4
CNSTF4 981668463
MULF4
ARGF4
ADDRGP4 BotAI
CALLI4
pop
line 2011
;2011:				}
LABELV $866
line 2012
;2012:			}
LABELV $862
line 2013
;2013:		}
line 2015
;2014:#endif
;2015:	}
LABELV $856
line 1970
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $855
line 2019
;2016:
;2017:
;2018:	// execute bot user commands every frame
;2019:	for( i = 0; i < MAX_CLIENTS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $869
line 2020
;2020:		if( !botstates[i] || !botstates[i]->inuse ) {
ADDRLP4 144
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 144
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $875
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 144
INDIRP4
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $873
LABELV $875
line 2021
;2021:			continue;
ADDRGP4 $870
JUMPV
LABELV $873
line 2023
;2022:		}
;2023:		if( g_entities[i].client->pers.connected != CON_CONNECTED ) {
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
EQI4 $876
line 2024
;2024:			continue;
ADDRGP4 $870
JUMPV
LABELV $876
line 2027
;2025:		}
;2026:
;2027:		BotUpdateInput(botstates[i], time, elapsed_time);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 120
INDIRI4
ARGI4
ADDRGP4 BotUpdateInput
CALLV
pop
line 2028
;2028:		trap_BotUserCommand(botstates[i]->client, &botstates[i]->lastucmd);
ADDRLP4 152
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 152
INDIRP4
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 152
INDIRP4
ADDP4
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRGP4 trap_BotUserCommand
CALLV
pop
line 2029
;2029:	}
LABELV $870
line 2019
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $869
line 2031
;2030:
;2031:	return qtrue;
CNSTI4 1
RETI4
LABELV $763
endproc BotAIStartFrame 172 12
export BotInitLibrary
proc BotInitLibrary 212 16
line 2039
;2032:}
;2033:
;2034:/*
;2035:==============
;2036:BotInitLibrary
;2037:==============
;2038:*/
;2039:int BotInitLibrary(void) {
line 2043
;2040:	char buf[144];
;2041:
;2042:	//set the maxclients and maxentities library variables before calling BotSetupLibrary
;2043:	trap_Cvar_VariableStringBuffer("sv_maxclients", buf, sizeof(buf));
ADDRGP4 $880
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 2044
;2044:	if (!strlen(buf)) strcpy(buf, "8");
ADDRLP4 0
ARGP4
ADDRLP4 144
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
NEI4 $881
ADDRLP4 0
ARGP4
ADDRGP4 $883
ARGP4
ADDRGP4 strcpy
CALLP4
pop
LABELV $881
line 2045
;2045:	trap_BotLibVarSet("maxclients", buf);
ADDRGP4 $884
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 2046
;2046:	Com_sprintf(buf, sizeof(buf), "%d", MAX_GENTITIES);
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 $370
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 2047
;2047:	trap_BotLibVarSet("maxentities", buf);
ADDRGP4 $885
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 2049
;2048:	//bsp checksum
;2049:	trap_Cvar_VariableStringBuffer("sv_mapChecksum", buf, sizeof(buf));
ADDRGP4 $886
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 2050
;2050:	if (strlen(buf)) trap_BotLibVarSet("sv_mapChecksum", buf);
ADDRLP4 0
ARGP4
ADDRLP4 148
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
EQI4 $887
ADDRGP4 $886
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $887
line 2052
;2051:	//maximum number of aas links
;2052:	trap_Cvar_VariableStringBuffer("max_aaslinks", buf, sizeof(buf));
ADDRGP4 $889
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 2053
;2053:	if (strlen(buf)) trap_BotLibVarSet("max_aaslinks", buf);
ADDRLP4 0
ARGP4
ADDRLP4 152
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
EQI4 $890
ADDRGP4 $889
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $890
line 2055
;2054:	//maximum number of items in a level
;2055:	trap_Cvar_VariableStringBuffer("max_levelitems", buf, sizeof(buf));
ADDRGP4 $892
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 2056
;2056:	if (strlen(buf)) trap_BotLibVarSet("max_levelitems", buf);
ADDRLP4 0
ARGP4
ADDRLP4 156
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
EQI4 $893
ADDRGP4 $892
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $893
line 2058
;2057:	//game type
;2058:	trap_Cvar_VariableStringBuffer("g_gametype", buf, sizeof(buf));
ADDRGP4 $369
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 2059
;2059:	if (!strlen(buf)) strcpy(buf, "0");
ADDRLP4 0
ARGP4
ADDRLP4 160
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 0
NEI4 $895
ADDRLP4 0
ARGP4
ADDRGP4 $793
ARGP4
ADDRGP4 strcpy
CALLP4
pop
LABELV $895
line 2060
;2060:	trap_BotLibVarSet("g_gametype", buf);
ADDRGP4 $369
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 2062
;2061:	//bot developer mode and log file
;2062:	trap_BotLibVarSet("bot_developer", bot_developer.string);
ADDRGP4 $897
ARGP4
ADDRGP4 bot_developer+16
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 2063
;2063:	trap_BotLibVarSet("log", buf);
ADDRGP4 $899
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 2065
;2064:	//no chatting
;2065:	trap_Cvar_VariableStringBuffer("bot_nochat", buf, sizeof(buf));
ADDRGP4 $900
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 2066
;2066:	if (strlen(buf)) trap_BotLibVarSet("nochat", "0");
ADDRLP4 0
ARGP4
ADDRLP4 164
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 164
INDIRI4
CNSTI4 0
EQI4 $901
ADDRGP4 $903
ARGP4
ADDRGP4 $793
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $901
line 2068
;2067:	//visualize jump pads
;2068:	trap_Cvar_VariableStringBuffer("bot_visualizejumppads", buf, sizeof(buf));
ADDRGP4 $904
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 2069
;2069:	if (strlen(buf)) trap_BotLibVarSet("bot_visualizejumppads", buf);
ADDRLP4 0
ARGP4
ADDRLP4 168
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 168
INDIRI4
CNSTI4 0
EQI4 $905
ADDRGP4 $904
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $905
line 2071
;2070:	//forced clustering calculations
;2071:	trap_Cvar_VariableStringBuffer("bot_forceclustering", buf, sizeof(buf));
ADDRGP4 $907
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 2072
;2072:	if (strlen(buf)) trap_BotLibVarSet("forceclustering", buf);
ADDRLP4 0
ARGP4
ADDRLP4 172
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 0
EQI4 $908
ADDRGP4 $910
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $908
line 2074
;2073:	//forced reachability calculations
;2074:	trap_Cvar_VariableStringBuffer("bot_forcereachability", buf, sizeof(buf));
ADDRGP4 $911
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 2075
;2075:	if (strlen(buf)) trap_BotLibVarSet("forcereachability", buf);
ADDRLP4 0
ARGP4
ADDRLP4 176
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 0
EQI4 $912
ADDRGP4 $914
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $912
line 2077
;2076:	//force writing of AAS to file
;2077:	trap_Cvar_VariableStringBuffer("bot_forcewrite", buf, sizeof(buf));
ADDRGP4 $915
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 2078
;2078:	if (strlen(buf)) trap_BotLibVarSet("forcewrite", buf);
ADDRLP4 0
ARGP4
ADDRLP4 180
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 0
EQI4 $916
ADDRGP4 $918
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $916
line 2080
;2079:	//no AAS optimization
;2080:	trap_Cvar_VariableStringBuffer("bot_aasoptimize", buf, sizeof(buf));
ADDRGP4 $919
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 2081
;2081:	if (strlen(buf)) trap_BotLibVarSet("aasoptimize", buf);
ADDRLP4 0
ARGP4
ADDRLP4 184
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 184
INDIRI4
CNSTI4 0
EQI4 $920
ADDRGP4 $922
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $920
line 2083
;2082:	//
;2083:	trap_Cvar_VariableStringBuffer("bot_saveroutingcache", buf, sizeof(buf));
ADDRGP4 $798
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 2084
;2084:	if (strlen(buf)) trap_BotLibVarSet("saveroutingcache", buf);
ADDRLP4 0
ARGP4
ADDRLP4 188
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 188
INDIRI4
CNSTI4 0
EQI4 $923
ADDRGP4 $797
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $923
line 2086
;2085:	//reload instead of cache bot character files
;2086:	trap_Cvar_VariableStringBuffer("bot_reloadcharacters", buf, sizeof(buf));
ADDRGP4 $377
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 2087
;2087:	if (!strlen(buf)) strcpy(buf, "0");
ADDRLP4 0
ARGP4
ADDRLP4 192
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 192
INDIRI4
CNSTI4 0
NEI4 $925
ADDRLP4 0
ARGP4
ADDRGP4 $793
ARGP4
ADDRGP4 strcpy
CALLP4
pop
LABELV $925
line 2088
;2088:	trap_BotLibVarSet("bot_reloadcharacters", buf);
ADDRGP4 $377
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 2090
;2089:	//base directory
;2090:	trap_Cvar_VariableStringBuffer("fs_basepath", buf, sizeof(buf));
ADDRGP4 $927
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 2091
;2091:	if (strlen(buf)) trap_BotLibVarSet("basedir", buf);
ADDRLP4 0
ARGP4
ADDRLP4 196
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 196
INDIRI4
CNSTI4 0
EQI4 $928
ADDRGP4 $930
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $928
line 2093
;2092:	//game directory
;2093:	trap_Cvar_VariableStringBuffer("fs_game", buf, sizeof(buf));
ADDRGP4 $931
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 2094
;2094:	if (strlen(buf)) trap_BotLibVarSet("gamedir", buf);
ADDRLP4 0
ARGP4
ADDRLP4 200
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 200
INDIRI4
CNSTI4 0
EQI4 $932
ADDRGP4 $934
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $932
line 2096
;2095:	//cd directory
;2096:	trap_Cvar_VariableStringBuffer("fs_cdpath", buf, sizeof(buf));
ADDRGP4 $935
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 2097
;2097:	if (strlen(buf)) trap_BotLibVarSet("cddir", buf);
ADDRLP4 0
ARGP4
ADDRLP4 204
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 204
INDIRI4
CNSTI4 0
EQI4 $936
ADDRGP4 $938
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $936
line 2103
;2098:	//
;2099:#ifdef MISSIONPACK
;2100:	trap_BotLibDefine("MISSIONPACK");
;2101:#endif
;2102:	//setup the bot library
;2103:	return trap_BotLibSetup();
ADDRLP4 208
ADDRGP4 trap_BotLibSetup
CALLI4
ASGNI4
ADDRLP4 208
INDIRI4
RETI4
LABELV $879
endproc BotInitLibrary 212 16
export BotAISetup
proc BotAISetup 8 16
line 2111
;2104:}
;2105:
;2106:/*
;2107:==============
;2108:BotAISetup
;2109:==============
;2110:*/
;2111:int BotAISetup( int restart ) {
line 2115
;2112:	int			errnum;
;2113:
;2114:
;2115:	trap_Cvar_Register(&bot_thinktime, "bot_thinktime", "100", CVAR_CHEAT);
ADDRGP4 bot_thinktime
ARGP4
ADDRGP4 $802
ARGP4
ADDRGP4 $940
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 2116
;2116:	trap_Cvar_Register(&bot_memorydump, "bot_memorydump", "0", CVAR_CHEAT);
ADDRGP4 bot_memorydump
ARGP4
ADDRGP4 $792
ARGP4
ADDRGP4 $793
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 2117
;2117:	trap_Cvar_Register(&bot_saveroutingcache, "bot_saveroutingcache", "0", CVAR_CHEAT);
ADDRGP4 bot_saveroutingcache
ARGP4
ADDRGP4 $798
ARGP4
ADDRGP4 $793
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 2118
;2118:	trap_Cvar_Register(&bot_pause, "bot_pause", "0", CVAR_CHEAT);
ADDRGP4 bot_pause
ARGP4
ADDRGP4 $941
ARGP4
ADDRGP4 $793
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 2119
;2119:	trap_Cvar_Register(&bot_report, "bot_report", "0", CVAR_CHEAT);
ADDRGP4 bot_report
ARGP4
ADDRGP4 $942
ARGP4
ADDRGP4 $793
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 2120
;2120:	trap_Cvar_Register(&bot_testsolid, "bot_testsolid", "0", CVAR_CHEAT);
ADDRGP4 bot_testsolid
ARGP4
ADDRGP4 $943
ARGP4
ADDRGP4 $793
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 2121
;2121:	trap_Cvar_Register(&bot_testclusters, "bot_testclusters", "0", CVAR_CHEAT);
ADDRGP4 bot_testclusters
ARGP4
ADDRGP4 $944
ARGP4
ADDRGP4 $793
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 2122
;2122:	trap_Cvar_Register(&bot_developer, "bot_developer", "0", CVAR_CHEAT);
ADDRGP4 bot_developer
ARGP4
ADDRGP4 $897
ARGP4
ADDRGP4 $793
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 2123
;2123:	trap_Cvar_Register(&bot_interbreedchar, "bot_interbreedchar", "", 0);
ADDRGP4 bot_interbreedchar
ARGP4
ADDRGP4 $387
ARGP4
ADDRGP4 $362
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 2124
;2124:	trap_Cvar_Register(&bot_interbreedbots, "bot_interbreedbots", "10", 0);
ADDRGP4 bot_interbreedbots
ARGP4
ADDRGP4 $945
ARGP4
ADDRGP4 $946
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 2125
;2125:	trap_Cvar_Register(&bot_interbreedcycle, "bot_interbreedcycle", "20", 0);
ADDRGP4 bot_interbreedcycle
ARGP4
ADDRGP4 $947
ARGP4
ADDRGP4 $948
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 2126
;2126:	trap_Cvar_Register(&bot_interbreedwrite, "bot_interbreedwrite", "", 0);
ADDRGP4 bot_interbreedwrite
ARGP4
ADDRGP4 $361
ARGP4
ADDRGP4 $362
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 2129
;2127:
;2128:	//if the game is restarted for a tournament
;2129:	if (restart) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $949
line 2130
;2130:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $939
JUMPV
LABELV $949
line 2134
;2131:	}
;2132:
;2133:	//initialize the bot states
;2134:	memset( botstates, 0, sizeof(botstates) );
ADDRGP4 botstates
ARGP4
CNSTI4 0
ARGI4
CNSTI4 256
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2136
;2135:
;2136:	errnum = BotInitLibrary();
ADDRLP4 4
ADDRGP4 BotInitLibrary
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 2137
;2137:	if (errnum != BLERR_NOERROR) return qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $951
CNSTI4 0
RETI4
ADDRGP4 $939
JUMPV
LABELV $951
line 2138
;2138:	return qtrue;
CNSTI4 1
RETI4
LABELV $939
endproc BotAISetup 8 16
export BotAIShutdown
proc BotAIShutdown 12 8
line 2146
;2139:}
;2140:
;2141:/*
;2142:==============
;2143:BotAIShutdown
;2144:==============
;2145:*/
;2146:int BotAIShutdown( int restart ) {
line 2151
;2147:
;2148:	int i;
;2149:
;2150:	//if the game is restarted for a tournament
;2151:	if ( restart ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $954
line 2153
;2152:		//shutdown all the bots in the botlib
;2153:		for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $956
line 2154
;2154:			if (botstates[i] && botstates[i]->inuse) {
ADDRLP4 8
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $960
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $960
line 2155
;2155:				BotAIShutdownClient(botstates[i]->client, restart);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 BotAIShutdownClient
CALLI4
pop
line 2156
;2156:			}
LABELV $960
line 2157
;2157:		}
LABELV $957
line 2153
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $956
line 2159
;2158:		//don't shutdown the bot library
;2159:	}
ADDRGP4 $955
JUMPV
LABELV $954
line 2160
;2160:	else {
line 2161
;2161:		trap_BotLibShutdown();
ADDRGP4 trap_BotLibShutdown
CALLI4
pop
line 2162
;2162:	}
LABELV $955
line 2163
;2163:	return qtrue;
CNSTI4 1
RETI4
LABELV $953
endproc BotAIShutdown 12 8
import ExitLevel
bss
export bot_interbreedwrite
align 4
LABELV bot_interbreedwrite
skip 272
export bot_interbreedcycle
align 4
LABELV bot_interbreedcycle
skip 272
export bot_interbreedbots
align 4
LABELV bot_interbreedbots
skip 272
export bot_interbreedchar
align 4
LABELV bot_interbreedchar
skip 272
export bot_developer
align 4
LABELV bot_developer
skip 272
export bot_testclusters
align 4
LABELV bot_testclusters
skip 272
export bot_testsolid
align 4
LABELV bot_testsolid
skip 272
export bot_report
align 4
LABELV bot_report
skip 272
export bot_pause
align 4
LABELV bot_pause
skip 272
export bot_saveroutingcache
align 4
LABELV bot_saveroutingcache
skip 272
export bot_memorydump
align 4
LABELV bot_memorydump
skip 272
export bot_thinktime
align 4
LABELV bot_thinktime
skip 272
export bot_interbreedmatchcount
align 4
LABELV bot_interbreedmatchcount
skip 4
export bot_interbreed
align 4
LABELV bot_interbreed
skip 4
export regularupdate_time
align 4
LABELV regularupdate_time
skip 4
export numbots
align 4
LABELV numbots
skip 4
export botstates
align 4
LABELV botstates
skip 256
import BotVoiceChat_Defend
import BotVoiceChatCommand
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
import BotTeamLeader
export floattime
align 4
LABELV floattime
skip 4
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
LABELV $948
byte 1 50
byte 1 48
byte 1 0
align 1
LABELV $947
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 98
byte 1 114
byte 1 101
byte 1 101
byte 1 100
byte 1 99
byte 1 121
byte 1 99
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $946
byte 1 49
byte 1 48
byte 1 0
align 1
LABELV $945
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 98
byte 1 114
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $944
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 99
byte 1 108
byte 1 117
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $943
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 115
byte 1 111
byte 1 108
byte 1 105
byte 1 100
byte 1 0
align 1
LABELV $942
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 114
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $941
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 112
byte 1 97
byte 1 117
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $940
byte 1 49
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $938
byte 1 99
byte 1 100
byte 1 100
byte 1 105
byte 1 114
byte 1 0
align 1
LABELV $935
byte 1 102
byte 1 115
byte 1 95
byte 1 99
byte 1 100
byte 1 112
byte 1 97
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $934
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 100
byte 1 105
byte 1 114
byte 1 0
align 1
LABELV $931
byte 1 102
byte 1 115
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $930
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 100
byte 1 105
byte 1 114
byte 1 0
align 1
LABELV $927
byte 1 102
byte 1 115
byte 1 95
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 112
byte 1 97
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $922
byte 1 97
byte 1 97
byte 1 115
byte 1 111
byte 1 112
byte 1 116
byte 1 105
byte 1 109
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $919
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 97
byte 1 97
byte 1 115
byte 1 111
byte 1 112
byte 1 116
byte 1 105
byte 1 109
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $918
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 119
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $915
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 119
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $914
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 114
byte 1 101
byte 1 97
byte 1 99
byte 1 104
byte 1 97
byte 1 98
byte 1 105
byte 1 108
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $911
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 114
byte 1 101
byte 1 97
byte 1 99
byte 1 104
byte 1 97
byte 1 98
byte 1 105
byte 1 108
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $910
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 99
byte 1 108
byte 1 117
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $907
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 99
byte 1 108
byte 1 117
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $904
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 118
byte 1 105
byte 1 115
byte 1 117
byte 1 97
byte 1 108
byte 1 105
byte 1 122
byte 1 101
byte 1 106
byte 1 117
byte 1 109
byte 1 112
byte 1 112
byte 1 97
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $903
byte 1 110
byte 1 111
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $900
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 110
byte 1 111
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $899
byte 1 108
byte 1 111
byte 1 103
byte 1 0
align 1
LABELV $897
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 100
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 111
byte 1 112
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $892
byte 1 109
byte 1 97
byte 1 120
byte 1 95
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $889
byte 1 109
byte 1 97
byte 1 120
byte 1 95
byte 1 97
byte 1 97
byte 1 115
byte 1 108
byte 1 105
byte 1 110
byte 1 107
byte 1 115
byte 1 0
align 1
LABELV $886
byte 1 115
byte 1 118
byte 1 95
byte 1 109
byte 1 97
byte 1 112
byte 1 67
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 115
byte 1 117
byte 1 109
byte 1 0
align 1
LABELV $885
byte 1 109
byte 1 97
byte 1 120
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 105
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $884
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
align 1
LABELV $883
byte 1 56
byte 1 0
align 1
LABELV $880
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
align 1
LABELV $803
byte 1 50
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $802
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 116
byte 1 104
byte 1 105
byte 1 110
byte 1 107
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $798
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 115
byte 1 97
byte 1 118
byte 1 101
byte 1 114
byte 1 111
byte 1 117
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 99
byte 1 97
byte 1 99
byte 1 104
byte 1 101
byte 1 0
align 1
LABELV $797
byte 1 115
byte 1 97
byte 1 118
byte 1 101
byte 1 114
byte 1 111
byte 1 117
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 99
byte 1 97
byte 1 99
byte 1 104
byte 1 101
byte 1 0
align 1
LABELV $793
byte 1 48
byte 1 0
align 1
LABELV $792
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 109
byte 1 101
byte 1 109
byte 1 111
byte 1 114
byte 1 121
byte 1 100
byte 1 117
byte 1 109
byte 1 112
byte 1 0
align 1
LABELV $791
byte 1 109
byte 1 101
byte 1 109
byte 1 111
byte 1 114
byte 1 121
byte 1 100
byte 1 117
byte 1 109
byte 1 112
byte 1 0
align 1
LABELV $770
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 101
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $755
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $728
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 105
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $713
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 32
byte 1 37
byte 1 102
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
LABELV $710
byte 1 65
byte 1 65
byte 1 83
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 105
byte 1 110
byte 1 105
byte 1 116
byte 1 105
byte 1 97
byte 1 108
byte 1 105
byte 1 122
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $707
byte 1 66
byte 1 111
byte 1 116
byte 1 65
byte 1 73
byte 1 83
byte 1 101
byte 1 116
byte 1 117
byte 1 112
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 97
byte 1 108
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 121
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 117
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $700
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 101
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $699
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
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
byte 1 102
byte 1 0
align 1
LABELV $681
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 76
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 83
byte 1 104
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $678
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $675
byte 1 116
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $672
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $669
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $666
byte 1 99
byte 1 115
byte 1 0
align 1
LABELV $663
byte 1 99
byte 1 112
byte 1 32
byte 1 0
align 1
LABELV $655
byte 1 66
byte 1 111
byte 1 116
byte 1 65
byte 1 73
byte 1 58
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 117
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $387
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 98
byte 1 114
byte 1 101
byte 1 101
byte 1 100
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $384
byte 1 97
byte 1 100
byte 1 100
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 52
byte 1 32
byte 1 102
byte 1 114
byte 1 101
byte 1 101
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $378
byte 1 49
byte 1 0
align 1
LABELV $377
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 114
byte 1 101
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $370
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $369
byte 1 103
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $362
byte 1 0
align 1
LABELV $361
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 98
byte 1 114
byte 1 101
byte 1 101
byte 1 100
byte 1 119
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $312
byte 1 108
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 99
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 97
byte 1 92
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $309
byte 1 114
byte 1 111
byte 1 97
byte 1 109
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $307
byte 1 104
byte 1 97
byte 1 114
byte 1 118
byte 1 101
byte 1 115
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $305
byte 1 97
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $303
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $301
byte 1 114
byte 1 117
byte 1 115
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $299
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $297
byte 1 112
byte 1 97
byte 1 116
byte 1 114
byte 1 111
byte 1 108
byte 1 108
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $295
byte 1 99
byte 1 97
byte 1 109
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $293
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $291
byte 1 103
byte 1 101
byte 1 116
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $289
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $287
byte 1 97
byte 1 99
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 97
byte 1 110
byte 1 121
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $285
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $280
byte 1 70
byte 1 32
byte 1 0
align 1
LABELV $275
byte 1 32
byte 1 0
align 1
LABELV $274
byte 1 76
byte 1 0
align 1
LABELV $257
byte 1 94
byte 1 52
byte 1 66
byte 1 76
byte 1 85
byte 1 69
byte 1 10
byte 1 0
align 1
LABELV $255
byte 1 116
byte 1 0
align 1
LABELV $251
byte 1 110
byte 1 0
align 1
LABELV $241
byte 1 94
byte 1 49
byte 1 82
byte 1 69
byte 1 68
byte 1 10
byte 1 0
align 1
LABELV $237
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 114
byte 1 111
byte 1 97
byte 1 109
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 40
byte 1 108
byte 1 116
byte 1 103
byte 1 61
byte 1 37
byte 1 100
byte 1 44
byte 1 101
byte 1 61
byte 1 37
byte 1 100
byte 1 44
byte 1 114
byte 1 61
byte 1 37
byte 1 100
byte 1 44
byte 1 115
byte 1 61
byte 1 37
byte 1 100
byte 1 44
byte 1 100
byte 1 61
byte 1 37
byte 1 100
byte 1 41
byte 1 10
byte 1 0
align 1
LABELV $236
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 114
byte 1 111
byte 1 97
byte 1 109
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 40
byte 1 108
byte 1 116
byte 1 103
byte 1 61
byte 1 37
byte 1 100
byte 1 44
byte 1 101
byte 1 61
byte 1 37
byte 1 100
byte 1 44
byte 1 114
byte 1 61
byte 1 37
byte 1 100
byte 1 44
byte 1 115
byte 1 61
byte 1 37
byte 1 100
byte 1 44
byte 1 100
byte 1 61
byte 1 37
byte 1 100
byte 1 41
byte 1 10
byte 1 0
align 1
LABELV $232
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $230
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 101
byte 1 115
byte 1 99
byte 1 97
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $228
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 104
byte 1 97
byte 1 114
byte 1 118
byte 1 101
byte 1 115
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $226
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 97
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $224
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $222
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 114
byte 1 117
byte 1 115
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $220
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $218
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 112
byte 1 97
byte 1 116
byte 1 114
byte 1 111
byte 1 108
byte 1 108
byte 1 105
byte 1 110
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $216
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 99
byte 1 97
byte 1 109
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $214
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $212
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $210
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $208
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 97
byte 1 99
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 97
byte 1 110
byte 1 121
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $206
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $201
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 32
byte 1 72
byte 1 37
byte 1 45
byte 1 51
byte 1 100
byte 1 65
byte 1 37
byte 1 45
byte 1 51
byte 1 100
byte 1 0
align 1
LABELV $200
byte 1 94
byte 1 52
byte 1 70
byte 1 32
byte 1 0
align 1
LABELV $199
byte 1 94
byte 1 49
byte 1 70
byte 1 32
byte 1 0
align 1
LABELV $192
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $191
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 58
byte 1 32
byte 1 100
byte 1 101
byte 1 97
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $188
byte 1 76
byte 1 37
byte 1 45
byte 1 50
byte 1 100
byte 1 0
align 1
LABELV $184
byte 1 13
byte 1 97
byte 1 114
byte 1 101
byte 1 97
byte 1 32
byte 1 37
byte 1 100
byte 1 44
byte 1 32
byte 1 99
byte 1 108
byte 1 117
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $183
byte 1 13
byte 1 94
byte 1 49
byte 1 83
byte 1 111
byte 1 108
byte 1 105
byte 1 100
byte 1 33
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $175
byte 1 13
byte 1 94
byte 1 49
byte 1 83
byte 1 79
byte 1 76
byte 1 73
byte 1 68
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 97
byte 1 0
align 1
LABELV $174
byte 1 13
byte 1 101
byte 1 109
byte 1 116
byte 1 112
byte 1 121
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 97
byte 1 0
align 1
LABELV $114
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $113
byte 1 94
byte 1 49
byte 1 69
byte 1 120
byte 1 105
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $111
byte 1 94
byte 1 49
byte 1 70
byte 1 97
byte 1 116
byte 1 97
byte 1 108
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $109
byte 1 94
byte 1 49
byte 1 69
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $107
byte 1 94
byte 1 51
byte 1 87
byte 1 97
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $105
byte 1 37
byte 1 115
byte 1 0
