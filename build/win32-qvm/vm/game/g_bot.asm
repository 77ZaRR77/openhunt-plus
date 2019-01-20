export trap_Cvar_VariableValue
code
proc trap_Cvar_VariableValue 132 12
file "..\..\..\..\code\game\g_bot.c"
line 126
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// g_bot.c
;4:
;5:#include "g_local.h"
;6:
;7:
;8:static int		g_numBots;
;9:static char		*g_botInfos[MAX_BOTS];
;10:
;11:
;12:int				g_numArenas;
;13:static char		*g_arenaInfos[MAX_ARENAS];
;14:
;15:
;16:#define BOT_BEGIN_DELAY_BASE		2000
;17:#define BOT_BEGIN_DELAY_INCREMENT	1500
;18:
;19:#define BOT_SPAWN_QUEUE_DEPTH	16
;20:
;21:typedef struct {
;22:	int		clientNum;
;23:	int		spawnTime;
;24:} botSpawnQueue_t;
;25:
;26://static int			botBeginDelay = 0;  // bk001206 - unused, init
;27:static botSpawnQueue_t	botSpawnQueue[BOT_SPAWN_QUEUE_DEPTH];
;28:
;29:vmCvar_t bot_minplayers;
;30:
;31:#if MONSTER_MODE	// JUHOX: monster types
;32:typedef enum {
;33:	HP_entry,
;34:	HP_morphing,
;35:	HP_raising,
;36:	HP_sleeping,
;37:	HP_falling
;38:} hibernationPhase_t;
;39:typedef struct gmonster_s {
;40:	struct gmonster_s* next;
;41:	gentity_t* entity;
;42:	playerState_t ps;
;43:	monsterType_t type;
;44:	int clientNum;
;45:	int owner;
;46:	usercmd_t cmd;
;47:	qboolean superJump;
;48:	localseed_t seed;
;49:	int removeTime;
;50:	int nextHealthRefresh;
;51:	int lastAIFrame;
;52:	int nextAIFrame;
;53:	monsterAction_t action;
;54:	qboolean walk;
;55:	gentity_t* enemy;
;56:	int enemyFoundTime;
;57:	int lastEnemyHitTime;
;58:	int oldEnemyEFlags;
;59:	int oldEFlags;
;60:	qboolean freezeView;
;61:	qboolean enemyWasInView;
;62:	int nextDodgeTime;
;63:	int dodgeDir;
;64:	int nextEnemyVisCheck;
;65:	int nextViewSearch;
;66:	int nextDynViewSearch;
;67:	int nextEnemySearch;
;68:	int nextSpawnPoolCheck;
;69:	vec3_t lastCheckedSpawnPos;
;70:	vec3_t ideal_view;
;71:	gentity_t* sourceOfNoise;
;72:
;73:	gentity_t* lastHurtEntity;
;74:	int lastHurtTime;
;75:	int timeOfBodyCopying;
;76:
;77:	playerState_t* avoidPlayer;
;78:	int startAvoidPlayerTime;
;79:	int stopAvoidPlayerTime;
;80:
;81:	int hibernationTime;
;82:	int hibernationWaitTime;
;83:	hibernationPhase_t hibernationPhase;
;84:	vec3_t hibernationSpot;
;85:	int hibernationBrood;
;86:
;87:	// charge damage computation
;88:	float lastChargeAmount;
;89:	float chargeDamageResidual;
;90:	int lastChargeTime;
;91:
;92:	int generic1;
;93:} gmonster_t;
;94:typedef struct {
;95:	vec3_t origin;
;96:	gentity_t* seed;
;97:} monsterSeed_t;
;98:typedef struct {
;99:	vec3_t origin;
;100:	int numMonsters;
;101:} monsterTrap_t;
;102:#endif
;103:
;104:#if MONSTER_MODE	// JUHOX: monster variables
;105:static int numMonsters;
;106:static int nextMonsterSpawnTime;
;107:#define MAX_MONSTER_SEEDS 200
;108:static int firstMonsterSeed;
;109:static int lastMonsterSeed;
;110:static monsterSeed_t monsterSeeds[MAX_MONSTER_SEEDS];
;111:#define MAX_MONSTER_TRAPS 20
;112:static int firstMonsterTrap;
;113:static int lastMonsterTrap;
;114:static monsterTrap_t monsterTraps[MAX_MONSTER_TRAPS];
;115:static gmonster_t monsterInfo[MAX_MONSTERS];
;116:static gmonster_t* freeMonster;
;117:#define MONSTER_SPAWNPOOL_SIZE 4096
;118:static vec3_t monsterSpawnPool[MONSTER_SPAWNPOOL_SIZE];
;119:static int numMonsterSpawnPoolEntries;
;120:#endif
;121:
;122:extern gentity_t	*podium1;
;123:extern gentity_t	*podium2;
;124:extern gentity_t	*podium3;
;125:
;126:float trap_Cvar_VariableValue( const char *var_name ) {
line 129
;127:	char buf[128];
;128:
;129:	trap_Cvar_VariableStringBuffer(var_name, buf, sizeof(buf));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 130
;130:	return atof(buf);
ADDRLP4 0
ARGP4
ADDRLP4 128
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 128
INDIRF4
RETF4
LABELV $91
endproc trap_Cvar_VariableValue 132 12
export G_ParseInfos
proc G_ParseInfos 2084 12
line 140
;131:}
;132:
;133:
;134:
;135:/*
;136:===============
;137:G_ParseInfos
;138:===============
;139:*/
;140:int G_ParseInfos( char *buf, int max, char *infos[] ) {
line 146
;141:	char	*token;
;142:	int		count;
;143:	char	key[MAX_TOKEN_CHARS];
;144:	char	info[MAX_INFO_STRING];
;145:
;146:	count = 0;
ADDRLP4 2052
CNSTI4 0
ASGNI4
ADDRGP4 $94
JUMPV
LABELV $93
line 148
;147:
;148:	while ( 1 ) {
line 149
;149:		token = COM_Parse( &buf );
ADDRFP4 0
ARGP4
ADDRLP4 2056
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 2056
INDIRP4
ASGNP4
line 150
;150:		if ( !token[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $96
line 151
;151:			break;
ADDRGP4 $95
JUMPV
LABELV $96
line 153
;152:		}
;153:		if ( strcmp( token, "{" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $100
ARGP4
ADDRLP4 2060
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 2060
INDIRI4
CNSTI4 0
EQI4 $98
line 154
;154:			Com_Printf( "Missing { in info file\n" );
ADDRGP4 $101
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 155
;155:			break;
ADDRGP4 $95
JUMPV
LABELV $98
line 158
;156:		}
;157:
;158:		if ( count == max ) {
ADDRLP4 2052
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $102
line 159
;159:			Com_Printf( "Max infos exceeded\n" );
ADDRGP4 $104
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 160
;160:			break;
ADDRGP4 $95
JUMPV
LABELV $102
line 163
;161:		}
;162:
;163:		info[0] = '\0';
ADDRLP4 1028
CNSTI1 0
ASGNI1
ADDRGP4 $106
JUMPV
LABELV $105
line 164
;164:		while ( 1 ) {
line 165
;165:			token = COM_ParseExt( &buf, qtrue );
ADDRFP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 2064
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 2064
INDIRP4
ASGNP4
line 166
;166:			if ( !token[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $108
line 167
;167:				Com_Printf( "Unexpected end of info file\n" );
ADDRGP4 $110
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 168
;168:				break;
ADDRGP4 $107
JUMPV
LABELV $108
line 170
;169:			}
;170:			if ( !strcmp( token, "}" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $113
ARGP4
ADDRLP4 2068
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 2068
INDIRI4
CNSTI4 0
NEI4 $111
line 171
;171:				break;
ADDRGP4 $107
JUMPV
LABELV $111
line 173
;172:			}
;173:			Q_strncpyz( key, token, sizeof( key ) );
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 175
;174:
;175:			token = COM_ParseExt( &buf, qfalse );
ADDRFP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 2072
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 2072
INDIRP4
ASGNP4
line 176
;176:			if ( !token[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $114
line 177
;177:				strcpy( token, "<NULL>" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $116
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 178
;178:			}
LABELV $114
line 179
;179:			Info_SetValueForKey( info, key, token );
ADDRLP4 1028
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 180
;180:		}
LABELV $106
line 164
ADDRGP4 $105
JUMPV
LABELV $107
line 182
;181:		//NOTE: extra space for arena number
;182:		infos[count] = G_Alloc(strlen(info) + strlen("\\num\\") + strlen(va("%d", MAX_ARENAS)) + 1);
ADDRLP4 1028
ARGP4
ADDRLP4 2064
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRGP4 $117
ARGP4
ADDRLP4 2068
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRGP4 $118
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 2072
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 2072
INDIRP4
ARGP4
ADDRLP4 2076
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 2064
INDIRI4
ADDRLP4 2068
INDIRI4
ADDI4
ADDRLP4 2076
INDIRI4
ADDI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 2080
ADDRGP4 G_Alloc
CALLP4
ASGNP4
ADDRLP4 2052
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
ADDRLP4 2080
INDIRP4
ASGNP4
line 183
;183:		if (infos[count]) {
ADDRLP4 2052
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $119
line 184
;184:			strcpy(infos[count], info);
ADDRLP4 2052
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 1028
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 185
;185:			count++;
ADDRLP4 2052
ADDRLP4 2052
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 186
;186:		}
LABELV $119
line 187
;187:	}
LABELV $94
line 148
ADDRGP4 $93
JUMPV
LABELV $95
line 188
;188:	return count;
ADDRLP4 2052
INDIRI4
RETI4
LABELV $92
endproc G_ParseInfos 2084 12
proc G_LoadArenasFromFile 8216 16
line 196
;189:}
;190:
;191:/*
;192:===============
;193:G_LoadArenasFromFile
;194:===============
;195:*/
;196:static void G_LoadArenasFromFile( char *filename ) {
line 201
;197:	int				len;
;198:	fileHandle_t	f;
;199:	char			buf[MAX_ARENAS_TEXT];
;200:
;201:	len = trap_FS_FOpenFile( filename, &f, FS_READ );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8200
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8200
INDIRI4
ASGNI4
line 202
;202:	if ( !f ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $122
line 203
;203:		trap_Printf( va( S_COLOR_RED "file not found: %s\n", filename ) );
ADDRGP4 $124
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8204
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8204
INDIRP4
ARGP4
ADDRGP4 trap_Printf
CALLV
pop
line 204
;204:		return;
ADDRGP4 $121
JUMPV
LABELV $122
line 206
;205:	}
;206:	if ( len >= MAX_ARENAS_TEXT ) {
ADDRLP4 0
INDIRI4
CNSTI4 8192
LTI4 $125
line 207
;207:		trap_Printf( va( S_COLOR_RED "file too large: %s is %i, max allowed is %i", filename, len, MAX_ARENAS_TEXT ) );
ADDRGP4 $127
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 8192
ARGI4
ADDRLP4 8204
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8204
INDIRP4
ARGP4
ADDRGP4 trap_Printf
CALLV
pop
line 208
;208:		trap_FS_FCloseFile( f );
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 209
;209:		return;
ADDRGP4 $121
JUMPV
LABELV $125
line 212
;210:	}
;211:
;212:	trap_FS_Read( buf, len, f );
ADDRLP4 8
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 213
;213:	buf[len] = 0;
ADDRLP4 0
INDIRI4
ADDRLP4 8
ADDP4
CNSTI1 0
ASGNI1
line 214
;214:	trap_FS_FCloseFile( f );
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 216
;215:
;216:	g_numArenas += G_ParseInfos( buf, MAX_ARENAS - g_numArenas, &g_arenaInfos[g_numArenas] );
ADDRLP4 8
ARGP4
ADDRLP4 8204
ADDRGP4 g_numArenas
ASGNP4
ADDRLP4 8208
ADDRLP4 8204
INDIRP4
INDIRI4
ASGNI4
CNSTI4 1024
ADDRLP4 8208
INDIRI4
SUBI4
ARGI4
ADDRLP4 8208
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_arenaInfos
ADDP4
ARGP4
ADDRLP4 8212
ADDRGP4 G_ParseInfos
CALLI4
ASGNI4
ADDRLP4 8204
INDIRP4
ADDRLP4 8208
INDIRI4
ADDRLP4 8212
INDIRI4
ADDI4
ASGNI4
line 217
;217:}
LABELV $121
endproc G_LoadArenasFromFile 8216 16
proc G_LoadArenas 1456 16
line 224
;218:
;219:/*
;220:===============
;221:G_LoadArenas
;222:===============
;223:*/
;224:static void G_LoadArenas( void ) {
line 233
;225:	int			numdirs;
;226:	vmCvar_t	arenasFile;
;227:	char		filename[128];
;228:	char		dirlist[1024];
;229:	char*		dirptr;
;230:	int			i, n;
;231:	int			dirlen;
;232:
;233:	g_numArenas = 0;
ADDRGP4 g_numArenas
CNSTI4 0
ASGNI4
line 235
;234:
;235:	trap_Cvar_Register( &arenasFile, "g_arenasFile", "", CVAR_INIT|CVAR_ROM );
ADDRLP4 148
ARGP4
ADDRGP4 $129
ARGP4
ADDRGP4 $130
ARGP4
CNSTI4 80
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 236
;236:	if( *arenasFile.string ) {
ADDRLP4 148+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $131
line 237
;237:		G_LoadArenasFromFile(arenasFile.string);
ADDRLP4 148+16
ARGP4
ADDRGP4 G_LoadArenasFromFile
CALLV
pop
line 238
;238:	}
ADDRGP4 $132
JUMPV
LABELV $131
line 239
;239:	else {
line 240
;240:		G_LoadArenasFromFile("scripts/arenas.txt");
ADDRGP4 $135
ARGP4
ADDRGP4 G_LoadArenasFromFile
CALLV
pop
line 241
;241:	}
LABELV $132
line 244
;242:
;243:	// get all arenas from .arena files
;244:	numdirs = trap_FS_GetFileList("scripts", ".arena", dirlist, 1024 );
ADDRGP4 $136
ARGP4
ADDRGP4 $137
ARGP4
ADDRLP4 420
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1444
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRLP4 144
ADDRLP4 1444
INDIRI4
ASGNI4
line 245
;245:	dirptr  = dirlist;
ADDRLP4 4
ADDRLP4 420
ASGNP4
line 246
;246:	for (i = 0; i < numdirs; i++, dirptr += dirlen+1) {
ADDRLP4 136
CNSTI4 0
ASGNI4
ADDRGP4 $141
JUMPV
LABELV $138
line 247
;247:		dirlen = strlen(dirptr);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 1448
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 140
ADDRLP4 1448
INDIRI4
ASGNI4
line 248
;248:		strcpy(filename, "scripts/");
ADDRLP4 8
ARGP4
ADDRGP4 $142
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 249
;249:		strcat(filename, dirptr);
ADDRLP4 8
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 250
;250:		G_LoadArenasFromFile(filename);
ADDRLP4 8
ARGP4
ADDRGP4 G_LoadArenasFromFile
CALLV
pop
line 251
;251:	}
LABELV $139
line 246
ADDRLP4 136
ADDRLP4 136
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
ADDRLP4 140
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 4
INDIRP4
ADDP4
ASGNP4
LABELV $141
ADDRLP4 136
INDIRI4
ADDRLP4 144
INDIRI4
LTI4 $138
line 252
;252:	trap_Printf( va( "%i arenas parsed\n", g_numArenas ) );
ADDRGP4 $143
ARGP4
ADDRGP4 g_numArenas
INDIRI4
ARGI4
ADDRLP4 1448
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1448
INDIRP4
ARGP4
ADDRGP4 trap_Printf
CALLV
pop
line 254
;253:
;254:	for( n = 0; n < g_numArenas; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $147
JUMPV
LABELV $144
line 255
;255:		Info_SetValueForKey( g_arenaInfos[n], "num", va( "%i", n ) );
ADDRGP4 $149
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1452
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_arenaInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $148
ARGP4
ADDRLP4 1452
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 256
;256:	}
LABELV $145
line 254
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $147
ADDRLP4 0
INDIRI4
ADDRGP4 g_numArenas
INDIRI4
LTI4 $144
line 257
;257:}
LABELV $128
endproc G_LoadArenas 1456 16
export G_GetArenaInfoByMap
proc G_GetArenaInfoByMap 12 8
line 265
;258:
;259:
;260:/*
;261:===============
;262:G_GetArenaInfoByNumber
;263:===============
;264:*/
;265:const char *G_GetArenaInfoByMap( const char *map ) {
line 268
;266:	int			n;
;267:
;268:	for( n = 0; n < g_numArenas; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $154
JUMPV
LABELV $151
line 269
;269:		if( Q_stricmp( Info_ValueForKey( g_arenaInfos[n], "map" ), map ) == 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_arenaInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $157
ARGP4
ADDRLP4 4
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $155
line 270
;270:			return g_arenaInfos[n];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_arenaInfos
ADDP4
INDIRP4
RETP4
ADDRGP4 $150
JUMPV
LABELV $155
line 272
;271:		}
;272:	}
LABELV $152
line 268
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $154
ADDRLP4 0
INDIRI4
ADDRGP4 g_numArenas
INDIRI4
LTI4 $151
line 274
;273:
;274:	return NULL;
CNSTP4 0
RETP4
LABELV $150
endproc G_GetArenaInfoByMap 12 8
proc PlayerIntroSound 80 12
line 283
;275:}
;276:
;277:
;278:/*
;279:=================
;280:PlayerIntroSound
;281:=================
;282:*/
;283:static void PlayerIntroSound( const char *modelAndSkin ) {
line 287
;284:	char	model[MAX_QPATH];
;285:	char	*skin;
;286:
;287:	Q_strncpyz( model, modelAndSkin, sizeof(model) );
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 288
;288:	skin = Q_strrchr( model, '/' );
ADDRLP4 4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 68
ADDRGP4 Q_strrchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 68
INDIRP4
ASGNP4
line 289
;289:	if ( skin ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $159
line 290
;290:		*skin++ = '\0';
ADDRLP4 72
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 72
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI1 0
ASGNI1
line 291
;291:	}
ADDRGP4 $160
JUMPV
LABELV $159
line 292
;292:	else {
line 293
;293:		skin = model;
ADDRLP4 0
ADDRLP4 4
ASGNP4
line 294
;294:	}
LABELV $160
line 296
;295:
;296:	if( Q_stricmp( skin, "default" ) == 0 ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $163
ARGP4
ADDRLP4 72
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
NEI4 $161
line 297
;297:		skin = model;
ADDRLP4 0
ADDRLP4 4
ASGNP4
line 298
;298:	}
LABELV $161
line 300
;299:
;300:	trap_SendConsoleCommand( EXEC_APPEND, va( "play sound/player/announce/%s.wav\n", skin ) );
ADDRGP4 $164
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 76
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 76
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 301
;301:}
LABELV $158
endproc PlayerIntroSound 80 12
export G_AddRandomBot
proc G_AddRandomBot 80 20
line 308
;302:
;303:/*
;304:===============
;305:G_AddRandomBot
;306:===============
;307:*/
;308:void G_AddRandomBot( int team ) {
line 314
;309:	int		i, n, num;
;310:	float	skill;
;311:	char	*value, netname[36], *teamstr;
;312:	gclient_t	*cl;
;313:
;314:	num = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 315
;315:	for ( n = 0; n < g_numBots ; n++ ) {
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 $169
JUMPV
LABELV $166
line 316
;316:		value = Info_ValueForKey( g_botInfos[n], "name" );
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_botInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $170
ARGP4
ADDRLP4 64
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 64
INDIRP4
ASGNP4
line 318
;317:		//
;318:		for ( i=0 ; i< g_maxclients.integer ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $174
JUMPV
LABELV $171
line 319
;319:			cl = level.clients + i;
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 320
;320:			if ( cl->pers.connected != CON_CONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $176
line 321
;321:				continue;
ADDRGP4 $172
JUMPV
LABELV $176
line 323
;322:			}
;323:			if ( !(g_entities[cl->ps.clientNum].r.svFlags & SVF_BOT) ) {
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+208+216
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $178
line 324
;324:				continue;
ADDRGP4 $172
JUMPV
LABELV $178
line 326
;325:			}
;326:			if ( team >= 0 && cl->sess.sessionTeam != team ) {
ADDRLP4 68
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
LTI4 $182
ADDRLP4 0
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
ADDRLP4 68
INDIRI4
EQI4 $182
line 327
;327:				continue;
ADDRGP4 $172
JUMPV
LABELV $182
line 329
;328:			}
;329:			if ( !Q_stricmp( value, cl->pers.netname ) ) {
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 72
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
NEI4 $184
line 330
;330:				break;
ADDRGP4 $173
JUMPV
LABELV $184
line 332
;331:			}
;332:		}
LABELV $172
line 318
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $174
ADDRLP4 4
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $171
LABELV $173
line 333
;333:		if (i >= g_maxclients.integer) {
ADDRLP4 4
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $186
line 334
;334:			num++;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 335
;335:		}
LABELV $186
line 336
;336:	}
LABELV $167
line 315
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $169
ADDRLP4 12
INDIRI4
ADDRGP4 g_numBots
INDIRI4
LTI4 $166
line 337
;337:	num = random() * num;
ADDRLP4 64
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 16
ADDRLP4 64
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 64
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
ADDRLP4 16
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ASGNI4
line 338
;338:	for ( n = 0; n < g_numBots ; n++ ) {
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 $192
JUMPV
LABELV $189
line 339
;339:		value = Info_ValueForKey( g_botInfos[n], "name" );
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_botInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $170
ARGP4
ADDRLP4 68
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 68
INDIRP4
ASGNP4
line 341
;340:		//
;341:		for ( i=0 ; i< g_maxclients.integer ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $196
JUMPV
LABELV $193
line 342
;342:			cl = level.clients + i;
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 343
;343:			if ( cl->pers.connected != CON_CONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $198
line 344
;344:				continue;
ADDRGP4 $194
JUMPV
LABELV $198
line 346
;345:			}
;346:			if ( !(g_entities[cl->ps.clientNum].r.svFlags & SVF_BOT) ) {
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+208+216
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $200
line 347
;347:				continue;
ADDRGP4 $194
JUMPV
LABELV $200
line 349
;348:			}
;349:			if ( team >= 0 && cl->sess.sessionTeam != team ) {
ADDRLP4 72
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
LTI4 $204
ADDRLP4 0
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
ADDRLP4 72
INDIRI4
EQI4 $204
line 350
;350:				continue;
ADDRGP4 $194
JUMPV
LABELV $204
line 352
;351:			}
;352:			if ( !Q_stricmp( value, cl->pers.netname ) ) {
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 76
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
NEI4 $206
line 353
;353:				break;
ADDRGP4 $195
JUMPV
LABELV $206
line 355
;354:			}
;355:		}
LABELV $194
line 341
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $196
ADDRLP4 4
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $193
LABELV $195
line 356
;356:		if (i >= g_maxclients.integer) {
ADDRLP4 4
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $208
line 357
;357:			num--;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 358
;358:			if (num <= 0) {
ADDRLP4 16
INDIRI4
CNSTI4 0
GTI4 $211
line 359
;359:				skill = trap_Cvar_VariableValue( "g_spSkill" );
ADDRGP4 $213
ARGP4
ADDRLP4 72
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 56
ADDRLP4 72
INDIRF4
ASGNF4
line 360
;360:				if (team == TEAM_RED) teamstr = "red";
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $214
ADDRLP4 60
ADDRGP4 $216
ASGNP4
ADDRGP4 $215
JUMPV
LABELV $214
line 361
;361:				else if (team == TEAM_BLUE) teamstr = "blue";
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $217
ADDRLP4 60
ADDRGP4 $219
ASGNP4
ADDRGP4 $218
JUMPV
LABELV $217
line 362
;362:				else teamstr = "";
ADDRLP4 60
ADDRGP4 $130
ASGNP4
LABELV $218
LABELV $215
line 363
;363:				strncpy(netname, value, sizeof(netname)-1);
ADDRLP4 20
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 35
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 364
;364:				netname[sizeof(netname)-1] = '\0';
ADDRLP4 20+35
CNSTI1 0
ASGNI1
line 365
;365:				Q_CleanStr(netname);
ADDRLP4 20
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 366
;366:				trap_SendConsoleCommand( EXEC_INSERT, va("addbot %s %f %s %i\n", netname, skill, teamstr, 0) );
ADDRGP4 $221
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 76
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 1
ARGI4
ADDRLP4 76
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 367
;367:				return;
ADDRGP4 $165
JUMPV
LABELV $211
line 369
;368:			}
;369:		}
LABELV $208
line 370
;370:	}
LABELV $190
line 338
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $192
ADDRLP4 12
INDIRI4
ADDRGP4 g_numBots
INDIRI4
LTI4 $189
line 371
;371:}
LABELV $165
endproc G_AddRandomBot 80 20
export G_RemoveRandomBot
proc G_RemoveRandomBot 52 8
line 378
;372:
;373:/*
;374:===============
;375:G_RemoveRandomBot
;376:===============
;377:*/
;378:int G_RemoveRandomBot( int team ) {
line 383
;379:	int i;
;380:	char netname[36];
;381:	gclient_t	*cl;
;382:
;383:	for ( i=0 ; i< g_maxclients.integer ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $226
JUMPV
LABELV $223
line 384
;384:		cl = level.clients + i;
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 385
;385:		if ( cl->pers.connected != CON_CONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $228
line 386
;386:			continue;
ADDRGP4 $224
JUMPV
LABELV $228
line 388
;387:		}
;388:		if ( !(g_entities[cl->ps.clientNum].r.svFlags & SVF_BOT) ) {
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+208+216
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $230
line 389
;389:			continue;
ADDRGP4 $224
JUMPV
LABELV $230
line 391
;390:		}
;391:		if ( team >= 0 && cl->sess.sessionTeam != team ) {
ADDRLP4 44
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
LTI4 $234
ADDRLP4 0
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
ADDRLP4 44
INDIRI4
EQI4 $234
line 392
;392:			continue;
ADDRGP4 $224
JUMPV
LABELV $234
line 394
;393:		}
;394:		strcpy(netname, cl->pers.netname);
ADDRLP4 8
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 395
;395:		Q_CleanStr(netname);
ADDRLP4 8
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 396
;396:		trap_SendConsoleCommand( EXEC_INSERT, va("kick %s\n", netname) );
ADDRGP4 $236
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 48
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 1
ARGI4
ADDRLP4 48
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 397
;397:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $222
JUMPV
LABELV $224
line 383
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $226
ADDRLP4 4
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $223
line 399
;398:	}
;399:	return qfalse;
CNSTI4 0
RETI4
LABELV $222
endproc G_RemoveRandomBot 52 8
export G_CountHumanPlayers
proc G_CountHumanPlayers 16 0
line 407
;400:}
;401:
;402:/*
;403:===============
;404:G_CountHumanPlayers
;405:===============
;406:*/
;407:int G_CountHumanPlayers( int team ) {
line 411
;408:	int i, num;
;409:	gclient_t	*cl;
;410:
;411:	num = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 412
;412:	for ( i=0 ; i< g_maxclients.integer ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $241
JUMPV
LABELV $238
line 413
;413:		cl = level.clients + i;
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 414
;414:		if ( cl->pers.connected != CON_CONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $243
line 415
;415:			continue;
ADDRGP4 $239
JUMPV
LABELV $243
line 417
;416:		}
;417:		if ( g_entities[cl->ps.clientNum].r.svFlags & SVF_BOT ) {
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+208+216
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $245
line 418
;418:			continue;
ADDRGP4 $239
JUMPV
LABELV $245
line 420
;419:		}
;420:		if ( team >= 0 && cl->sess.sessionTeam != team ) {
ADDRLP4 12
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
LTI4 $249
ADDRLP4 0
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $249
line 421
;421:			continue;
ADDRGP4 $239
JUMPV
LABELV $249
line 423
;422:		}
;423:		num++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 424
;424:	}
LABELV $239
line 412
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $241
ADDRLP4 4
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $238
line 425
;425:	return num;
ADDRLP4 8
INDIRI4
RETI4
LABELV $237
endproc G_CountHumanPlayers 16 0
export G_CountBotPlayers
proc G_CountBotPlayers 20 0
line 433
;426:}
;427:
;428:/*
;429:===============
;430:G_CountBotPlayers
;431:===============
;432:*/
;433:int G_CountBotPlayers( int team ) {
line 437
;434:	int i, n, num;
;435:	gclient_t	*cl;
;436:
;437:	num = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 438
;438:	for ( i=0 ; i< g_maxclients.integer ; i++ ) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $255
JUMPV
LABELV $252
line 439
;439:		cl = level.clients + i;
ADDRLP4 4
ADDRLP4 8
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 440
;440:		if ( cl->pers.connected != CON_CONNECTED ) {
ADDRLP4 4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $257
line 441
;441:			continue;
ADDRGP4 $253
JUMPV
LABELV $257
line 443
;442:		}
;443:		if ( !(g_entities[cl->ps.clientNum].r.svFlags & SVF_BOT) ) {
ADDRLP4 4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+208+216
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $259
line 444
;444:			continue;
ADDRGP4 $253
JUMPV
LABELV $259
line 446
;445:		}
;446:		if ( team >= 0 && cl->sess.sessionTeam != team ) {
ADDRLP4 16
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
LTI4 $263
ADDRLP4 4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $263
line 447
;447:			continue;
ADDRGP4 $253
JUMPV
LABELV $263
line 449
;448:		}
;449:		num++;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 450
;450:	}
LABELV $253
line 438
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $255
ADDRLP4 8
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $252
line 451
;451:	for( n = 0; n < BOT_SPAWN_QUEUE_DEPTH; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $265
line 452
;452:		if( !botSpawnQueue[n].spawnTime ) {
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue+4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $269
line 453
;453:			continue;
ADDRGP4 $266
JUMPV
LABELV $269
line 455
;454:		}
;455:		if ( botSpawnQueue[n].spawnTime > level.time ) {
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue+4
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $272
line 456
;456:			continue;
ADDRGP4 $266
JUMPV
LABELV $272
line 458
;457:		}
;458:		num++;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 459
;459:	}
LABELV $266
line 451
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $265
line 460
;460:	return num;
ADDRLP4 12
INDIRI4
RETI4
LABELV $251
endproc G_CountBotPlayers 20 0
bss
align 4
LABELV $277
skip 4
export G_CheckMinimumPlayers
code
proc G_CheckMinimumPlayers 36 4
line 468
;461:}
;462:
;463:/*
;464:===============
;465:G_CheckMinimumPlayers
;466:===============
;467:*/
;468:void G_CheckMinimumPlayers( void ) {
line 473
;469:	int minplayers;
;470:	int humanplayers, botplayers;
;471:	static int checkminimumplayers_time;
;472:
;473:	if (level.intermissiontime) return;
ADDRGP4 level+9144
INDIRI4
CNSTI4 0
EQI4 $278
ADDRGP4 $276
JUMPV
LABELV $278
line 475
;474:	//only check once each 10 seconds
;475:	if (checkminimumplayers_time > level.time - 10000) {
ADDRGP4 $277
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 10000
SUBI4
LEI4 $281
line 476
;476:		return;
ADDRGP4 $276
JUMPV
LABELV $281
line 478
;477:	}
;478:	checkminimumplayers_time = level.time;
ADDRGP4 $277
ADDRGP4 level+32
INDIRI4
ASGNI4
line 479
;479:	trap_Cvar_Update(&bot_minplayers);
ADDRGP4 bot_minplayers
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 480
;480:	minplayers = bot_minplayers.integer;
ADDRLP4 0
ADDRGP4 bot_minplayers+12
INDIRI4
ASGNI4
line 481
;481:	if (minplayers <= 0) return;
ADDRLP4 0
INDIRI4
CNSTI4 0
GTI4 $286
ADDRGP4 $276
JUMPV
LABELV $286
line 483
;482:
;483:	if (g_gametype.integer >= GT_TEAM) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $288
line 484
;484:		if (minplayers >= g_maxclients.integer / 2) {
ADDRLP4 0
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
CNSTI4 2
DIVI4
LTI4 $291
line 485
;485:			minplayers = (g_maxclients.integer / 2) -1;
ADDRLP4 0
ADDRGP4 g_maxclients+12
INDIRI4
CNSTI4 2
DIVI4
CNSTI4 1
SUBI4
ASGNI4
line 486
;486:		}
LABELV $291
line 488
;487:
;488:		humanplayers = G_CountHumanPlayers( TEAM_RED );
CNSTI4 1
ARGI4
ADDRLP4 12
ADDRGP4 G_CountHumanPlayers
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 489
;489:		botplayers = G_CountBotPlayers(	TEAM_RED );
CNSTI4 1
ARGI4
ADDRLP4 16
ADDRGP4 G_CountBotPlayers
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
ASGNI4
line 491
;490:		//
;491:		if (humanplayers + botplayers < minplayers) {
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ADDRLP4 0
INDIRI4
GEI4 $295
line 492
;492:			G_AddRandomBot( TEAM_RED );
CNSTI4 1
ARGI4
ADDRGP4 G_AddRandomBot
CALLV
pop
line 493
;493:		} else if (humanplayers + botplayers > minplayers && botplayers) {
ADDRGP4 $296
JUMPV
LABELV $295
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ADDRLP4 0
INDIRI4
LEI4 $297
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $297
line 494
;494:			G_RemoveRandomBot( TEAM_RED );
CNSTI4 1
ARGI4
ADDRGP4 G_RemoveRandomBot
CALLI4
pop
line 495
;495:		}
LABELV $297
LABELV $296
line 497
;496:		//
;497:		humanplayers = G_CountHumanPlayers( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRLP4 24
ADDRGP4 G_CountHumanPlayers
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 24
INDIRI4
ASGNI4
line 498
;498:		botplayers = G_CountBotPlayers( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRLP4 28
ADDRGP4 G_CountBotPlayers
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 28
INDIRI4
ASGNI4
line 500
;499:		//
;500:		if (humanplayers + botplayers < minplayers) {
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ADDRLP4 0
INDIRI4
GEI4 $299
line 501
;501:			G_AddRandomBot( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRGP4 G_AddRandomBot
CALLV
pop
line 502
;502:		} else if (humanplayers + botplayers > minplayers && botplayers) {
ADDRGP4 $289
JUMPV
LABELV $299
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ADDRLP4 0
INDIRI4
LEI4 $289
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $289
line 503
;503:			G_RemoveRandomBot( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRGP4 G_RemoveRandomBot
CALLI4
pop
line 504
;504:		}
line 505
;505:	}
ADDRGP4 $289
JUMPV
LABELV $288
line 506
;506:	else if (g_gametype.integer == GT_TOURNAMENT ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
NEI4 $303
line 507
;507:		if (minplayers >= g_maxclients.integer) {
ADDRLP4 0
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $306
line 508
;508:			minplayers = g_maxclients.integer-1;
ADDRLP4 0
ADDRGP4 g_maxclients+12
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 509
;509:		}
LABELV $306
line 510
;510:		humanplayers = G_CountHumanPlayers( -1 );
CNSTI4 -1
ARGI4
ADDRLP4 12
ADDRGP4 G_CountHumanPlayers
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 511
;511:		botplayers = G_CountBotPlayers( -1 );
CNSTI4 -1
ARGI4
ADDRLP4 16
ADDRGP4 G_CountBotPlayers
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
ASGNI4
line 513
;512:		//
;513:		if (humanplayers + botplayers < minplayers) {
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ADDRLP4 0
INDIRI4
GEI4 $310
line 514
;514:			G_AddRandomBot( TEAM_FREE );
CNSTI4 0
ARGI4
ADDRGP4 G_AddRandomBot
CALLV
pop
line 515
;515:		} else if (humanplayers + botplayers > minplayers && botplayers) {
ADDRGP4 $304
JUMPV
LABELV $310
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ADDRLP4 0
INDIRI4
LEI4 $304
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $304
line 517
;516:			// try to remove spectators first
;517:			if (!G_RemoveRandomBot( TEAM_SPECTATOR )) {
CNSTI4 3
ARGI4
ADDRLP4 24
ADDRGP4 G_RemoveRandomBot
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $304
line 519
;518:				// just remove the bot that is playing
;519:				G_RemoveRandomBot( -1 );
CNSTI4 -1
ARGI4
ADDRGP4 G_RemoveRandomBot
CALLI4
pop
line 520
;520:			}
line 521
;521:		}
line 522
;522:	}
ADDRGP4 $304
JUMPV
LABELV $303
line 523
;523:	else if (g_gametype.integer == GT_FFA) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 0
NEI4 $316
line 524
;524:		if (minplayers >= g_maxclients.integer) {
ADDRLP4 0
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $319
line 525
;525:			minplayers = g_maxclients.integer-1;
ADDRLP4 0
ADDRGP4 g_maxclients+12
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 526
;526:		}
LABELV $319
line 527
;527:		humanplayers = G_CountHumanPlayers( TEAM_FREE );
CNSTI4 0
ARGI4
ADDRLP4 12
ADDRGP4 G_CountHumanPlayers
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 528
;528:		botplayers = G_CountBotPlayers( TEAM_FREE );
CNSTI4 0
ARGI4
ADDRLP4 16
ADDRGP4 G_CountBotPlayers
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
ASGNI4
line 530
;529:		//
;530:		if (humanplayers + botplayers < minplayers) {
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ADDRLP4 0
INDIRI4
GEI4 $323
line 531
;531:			G_AddRandomBot( TEAM_FREE );
CNSTI4 0
ARGI4
ADDRGP4 G_AddRandomBot
CALLV
pop
line 532
;532:		} else if (humanplayers + botplayers > minplayers && botplayers) {
ADDRGP4 $324
JUMPV
LABELV $323
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ADDRLP4 0
INDIRI4
LEI4 $325
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $325
line 533
;533:			G_RemoveRandomBot( TEAM_FREE );
CNSTI4 0
ARGI4
ADDRGP4 G_RemoveRandomBot
CALLI4
pop
line 534
;534:		}
LABELV $325
LABELV $324
line 535
;535:	}
LABELV $316
LABELV $304
LABELV $289
line 536
;536:}
LABELV $276
endproc G_CheckMinimumPlayers 36 4
export G_CheckBotSpawn
proc G_CheckBotSpawn 1032 12
line 543
;537:
;538:/*
;539:===============
;540:G_CheckBotSpawn
;541:===============
;542:*/
;543:void G_CheckBotSpawn( void ) {
line 547
;544:	int		n;
;545:	char	userinfo[MAX_INFO_VALUE];
;546:
;547:	G_CheckMinimumPlayers();
ADDRGP4 G_CheckMinimumPlayers
CALLV
pop
line 549
;548:
;549:	for( n = 0; n < BOT_SPAWN_QUEUE_DEPTH; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $328
line 550
;550:		if( !botSpawnQueue[n].spawnTime ) {
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue+4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $332
line 551
;551:			continue;
ADDRGP4 $329
JUMPV
LABELV $332
line 553
;552:		}
;553:		if ( botSpawnQueue[n].spawnTime > level.time ) {
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue+4
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $335
line 554
;554:			continue;
ADDRGP4 $329
JUMPV
LABELV $335
line 556
;555:		}
;556:		ClientBegin( botSpawnQueue[n].clientNum );
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue
ADDP4
INDIRI4
ARGI4
ADDRGP4 ClientBegin
CALLV
pop
line 557
;557:		botSpawnQueue[n].spawnTime = 0;
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue+4
ADDP4
CNSTI4 0
ASGNI4
line 559
;558:
;559:		if( g_gametype.integer == GT_SINGLE_PLAYER ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 2
NEI4 $340
line 560
;560:			trap_GetUserinfo( botSpawnQueue[n].clientNum, userinfo, sizeof(userinfo) );
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 561
;561:			PlayerIntroSound( Info_ValueForKey (userinfo, "model") );
ADDRLP4 4
ARGP4
ADDRGP4 $343
ARGP4
ADDRLP4 1028
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 PlayerIntroSound
CALLV
pop
line 562
;562:		}
LABELV $340
line 563
;563:	}
LABELV $329
line 549
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $328
line 564
;564:}
LABELV $327
endproc G_CheckBotSpawn 1032 12
proc AddBotToSpawnQueue 4 4
line 572
;565:
;566:
;567:/*
;568:===============
;569:AddBotToSpawnQueue
;570:===============
;571:*/
;572:static void AddBotToSpawnQueue( int clientNum, int delay ) {
line 575
;573:	int		n;
;574:
;575:	for( n = 0; n < BOT_SPAWN_QUEUE_DEPTH; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $345
line 576
;576:		if( !botSpawnQueue[n].spawnTime ) {
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue+4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $349
line 577
;577:			botSpawnQueue[n].spawnTime = level.time + delay;
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue+4
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRFP4 4
INDIRI4
ADDI4
ASGNI4
line 578
;578:			botSpawnQueue[n].clientNum = clientNum;
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 579
;579:			return;
ADDRGP4 $344
JUMPV
LABELV $349
line 581
;580:		}
;581:	}
LABELV $346
line 575
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $345
line 583
;582:
;583:	G_Printf( S_COLOR_YELLOW "Unable to delay spawn\n" );
ADDRGP4 $354
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 584
;584:	ClientBegin( clientNum );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 ClientBegin
CALLV
pop
line 585
;585:}
LABELV $344
endproc AddBotToSpawnQueue 4 4
export G_RemoveQueuedBotBegin
proc G_RemoveQueuedBotBegin 4 0
line 596
;586:
;587:
;588:/*
;589:===============
;590:G_RemoveQueuedBotBegin
;591:
;592:Called on client disconnect to make sure the delayed spawn
;593:doesn't happen on a freed index
;594:===============
;595:*/
;596:void G_RemoveQueuedBotBegin( int clientNum ) {
line 599
;597:	int		n;
;598:
;599:	for( n = 0; n < BOT_SPAWN_QUEUE_DEPTH; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $356
line 600
;600:		if( botSpawnQueue[n].clientNum == clientNum ) {
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $360
line 601
;601:			botSpawnQueue[n].spawnTime = 0;
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue+4
ADDP4
CNSTI4 0
ASGNI4
line 602
;602:			return;
ADDRGP4 $355
JUMPV
LABELV $360
line 604
;603:		}
;604:	}
LABELV $357
line 599
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $356
line 605
;605:}
LABELV $355
endproc G_RemoveQueuedBotBegin 4 0
export G_BotConnect
proc G_BotConnect 1348 12
line 613
;606:
;607:
;608:/*
;609:===============
;610:G_BotConnect
;611:===============
;612:*/
;613:qboolean G_BotConnect( int clientNum, qboolean restart ) {
line 617
;614:	bot_settings_t	settings;
;615:	char			userinfo[MAX_INFO_STRING];
;616:
;617:	trap_GetUserinfo( clientNum, userinfo, sizeof(userinfo) );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 296
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 619
;618:
;619:	Q_strncpyz( settings.characterfile, Info_ValueForKey( userinfo, "characterfile" ), sizeof(settings.characterfile) );
ADDRLP4 296
ARGP4
ADDRGP4 $364
ARGP4
ADDRLP4 1320
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
ADDRLP4 1320
INDIRP4
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 620
;620:	settings.skill = atof( Info_ValueForKey( userinfo, "skill" ) );
ADDRLP4 296
ARGP4
ADDRGP4 $366
ARGP4
ADDRLP4 1324
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1324
INDIRP4
ARGP4
ADDRLP4 1328
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 0+144
ADDRLP4 1328
INDIRF4
ASGNF4
line 621
;621:	Q_strncpyz( settings.team, Info_ValueForKey( userinfo, "team" ), sizeof(settings.team) );
ADDRLP4 296
ARGP4
ADDRGP4 $368
ARGP4
ADDRLP4 1332
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0+148
ARGP4
ADDRLP4 1332
INDIRP4
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 622
;622:	settings.arenaLord = atoi(Info_ValueForKey(userinfo, "arenaLord"));	// JUHOX
ADDRLP4 296
ARGP4
ADDRGP4 $371
ARGP4
ADDRLP4 1336
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1336
INDIRP4
ARGP4
ADDRLP4 1340
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0+292
ADDRLP4 1340
INDIRI4
ASGNI4
line 624
;623:
;624:	if (!BotAISetupClient( clientNum, &settings, restart )) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 1344
ADDRGP4 BotAISetupClient
CALLI4
ASGNI4
ADDRLP4 1344
INDIRI4
CNSTI4 0
NEI4 $372
line 625
;625:		trap_DropClient( clientNum, "BotAISetupClient failed" );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $374
ARGP4
ADDRGP4 trap_DropClient
CALLV
pop
line 626
;626:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $363
JUMPV
LABELV $372
line 629
;627:	}
;628:
;629:	return qtrue;
CNSTI4 1
RETI4
LABELV $363
endproc G_BotConnect 1348 12
proc IsClientNameInUse 8 8
line 638
;630:}
;631:
;632:
;633:/*
;634:===============
;635:JUHOX: IsClientNameInUse
;636:===============
;637:*/
;638:static int IsClientNameInUse(char* name) {
line 641
;639:	int i;
;640:
;641:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $376
line 642
;642:		if (level.clients[i].pers.connected == CON_DISCONNECTED) continue;
ADDRLP4 0
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 0
NEI4 $380
ADDRGP4 $377
JUMPV
LABELV $380
line 643
;643:		if (!Q_stricmp(name, level.clients[i].pers.netname)) return qtrue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $382
CNSTI4 1
RETI4
ADDRGP4 $375
JUMPV
LABELV $382
line 644
;644:	}
LABELV $377
line 641
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $376
line 645
;645:	return qfalse;
CNSTI4 0
RETI4
LABELV $375
endproc IsClientNameInUse 8 8
bss
align 1
LABELV $398
skip 36
code
proc G_AddBot 1136 20
line 653
;646:}
;647:
;648:/*
;649:===============
;650:G_AddBot
;651:===============
;652:*/
;653:static void G_AddBot( const char *name, float skill, const char *team, int delay, char *altname) {
line 665
;654:	int				clientNum;
;655:	char			*botinfo;
;656:	gentity_t		*bot;
;657:	char			*key;
;658:	char			*s;
;659:	char			*botname;
;660:	char			*model;
;661:	char			*headmodel;
;662:	char			userinfo[MAX_INFO_STRING];
;663:
;664:#if ESCAPE_MODE	// JUHOX: no bots in EFH
;665:	if (g_gametype.integer == GT_EFH) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
NEI4 $385
line 666
;666:		return;
ADDRGP4 $384
JUMPV
LABELV $385
line 671
;667:	}
;668:#endif
;669:
;670:	// get the botinfo from bots.txt
;671:	botinfo = G_GetBotInfoByName( name );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1056
ADDRGP4 G_GetBotInfoByName
CALLP4
ASGNP4
ADDRLP4 1036
ADDRLP4 1056
INDIRP4
ASGNP4
line 672
;672:	if ( !botinfo ) {
ADDRLP4 1036
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $388
line 673
;673:		G_Printf( S_COLOR_RED "Error: Bot '%s' not defined\n", name );
ADDRGP4 $390
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 674
;674:		return;
ADDRGP4 $384
JUMPV
LABELV $388
line 678
;675:	}
;676:
;677:	// create the bot's userinfo
;678:	userinfo[0] = '\0';
ADDRLP4 8
CNSTI1 0
ASGNI1
line 680
;679:
;680:	botname = Info_ValueForKey( botinfo, "funname" );
ADDRLP4 1036
INDIRP4
ARGP4
ADDRGP4 $391
ARGP4
ADDRLP4 1060
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1060
INDIRP4
ASGNP4
line 681
;681:	if( !botname[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $392
line 682
;682:		botname = Info_ValueForKey( botinfo, "name" );
ADDRLP4 1036
INDIRP4
ARGP4
ADDRGP4 $170
ARGP4
ADDRLP4 1064
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1064
INDIRP4
ASGNP4
line 683
;683:	}
LABELV $392
line 685
;684:	// check for an alternative name
;685:	if (altname && altname[0]) {
ADDRLP4 1064
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 1064
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $394
ADDRLP4 1064
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $394
line 686
;686:		botname = altname;
ADDRLP4 0
ADDRFP4 16
INDIRP4
ASGNP4
line 687
;687:	}
LABELV $394
line 690
;688:	// JUHOX: if there is already a client with that name use another one
;689:#if 1
;690:	if (IsClientNameInUse(botname)) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1068
ADDRGP4 IsClientNameInUse
CALLI4
ASGNI4
ADDRLP4 1068
INDIRI4
CNSTI4 0
EQI4 $396
line 694
;691:		int ext;
;692:		static char buf[MAX_NETNAME];
;693:
;694:		if (strlen(botname) > MAX_NETNAME-2) botname[MAX_NETNAME-2] = 0;
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1076
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1076
INDIRI4
CNSTI4 34
LEI4 $399
ADDRLP4 0
INDIRP4
CNSTI4 34
ADDP4
CNSTI1 0
ASGNI1
LABELV $399
line 695
;695:		ext = 2;
ADDRLP4 1072
CNSTI4 2
ASGNI4
line 696
;696:		Com_sprintf(buf, sizeof(buf), "%s%d", botname, ext);
ADDRGP4 $398
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 $401
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1072
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
ADDRGP4 $403
JUMPV
LABELV $402
line 697
;697:		while (IsClientNameInUse(buf)) {
line 698
;698:			ext++;
ADDRLP4 1072
ADDRLP4 1072
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 699
;699:			if (ext > 9 && strlen(botname) > MAX_NETNAME-3) botname[MAX_NETNAME-3] = 0;
ADDRLP4 1072
INDIRI4
CNSTI4 9
LEI4 $405
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1080
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1080
INDIRI4
CNSTI4 33
LEI4 $405
ADDRLP4 0
INDIRP4
CNSTI4 33
ADDP4
CNSTI1 0
ASGNI1
ADDRGP4 $406
JUMPV
LABELV $405
line 700
;700:			else if (ext > 99 && strlen(botname) > MAX_NETNAME-4) botname[MAX_NETNAME-4] = 0;
ADDRLP4 1072
INDIRI4
CNSTI4 99
LEI4 $407
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1084
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1084
INDIRI4
CNSTI4 32
LEI4 $407
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
CNSTI1 0
ASGNI1
LABELV $407
LABELV $406
line 701
;701:			Com_sprintf(buf, sizeof(buf), "%s%d", botname, ext);
ADDRGP4 $398
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 $401
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1072
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 702
;702:		}
LABELV $403
line 697
ADDRGP4 $398
ARGP4
ADDRLP4 1080
ADDRGP4 IsClientNameInUse
CALLI4
ASGNI4
ADDRLP4 1080
INDIRI4
CNSTI4 0
NEI4 $402
line 703
;703:		botname = buf;
ADDRLP4 0
ADDRGP4 $398
ASGNP4
line 704
;704:	}
LABELV $396
line 706
;705:#endif
;706:	Info_SetValueForKey( userinfo, "name", botname );
ADDRLP4 8
ARGP4
ADDRGP4 $170
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 707
;707:	Info_SetValueForKey( userinfo, "rate", "25000" );
ADDRLP4 8
ARGP4
ADDRGP4 $409
ARGP4
ADDRGP4 $410
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 708
;708:	Info_SetValueForKey( userinfo, "snaps", "20" );
ADDRLP4 8
ARGP4
ADDRGP4 $411
ARGP4
ADDRGP4 $412
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 709
;709:	Info_SetValueForKey( userinfo, "skill", va("%1.2f", skill) );
ADDRGP4 $413
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRLP4 1072
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
ARGP4
ADDRGP4 $366
ARGP4
ADDRLP4 1072
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 711
;710:
;711:	if ( skill >= 1 && skill < 2 ) {
ADDRLP4 1076
ADDRFP4 4
INDIRF4
ASGNF4
ADDRLP4 1076
INDIRF4
CNSTF4 1065353216
LTF4 $414
ADDRLP4 1076
INDIRF4
CNSTF4 1073741824
GEF4 $414
line 712
;712:		Info_SetValueForKey( userinfo, "handicap", "50" );
ADDRLP4 8
ARGP4
ADDRGP4 $416
ARGP4
ADDRGP4 $417
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 713
;713:	}
ADDRGP4 $415
JUMPV
LABELV $414
line 714
;714:	else if ( skill >= 2 && skill < 3 ) {
ADDRLP4 1080
ADDRFP4 4
INDIRF4
ASGNF4
ADDRLP4 1080
INDIRF4
CNSTF4 1073741824
LTF4 $418
ADDRLP4 1080
INDIRF4
CNSTF4 1077936128
GEF4 $418
line 715
;715:		Info_SetValueForKey( userinfo, "handicap", "70" );
ADDRLP4 8
ARGP4
ADDRGP4 $416
ARGP4
ADDRGP4 $420
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 716
;716:	}
ADDRGP4 $419
JUMPV
LABELV $418
line 717
;717:	else if ( skill >= 3 && skill < 4 ) {
ADDRLP4 1084
ADDRFP4 4
INDIRF4
ASGNF4
ADDRLP4 1084
INDIRF4
CNSTF4 1077936128
LTF4 $421
ADDRLP4 1084
INDIRF4
CNSTF4 1082130432
GEF4 $421
line 718
;718:		Info_SetValueForKey( userinfo, "handicap", "90" );
ADDRLP4 8
ARGP4
ADDRGP4 $416
ARGP4
ADDRGP4 $423
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 719
;719:	}
LABELV $421
LABELV $419
LABELV $415
line 721
;720:
;721:	key = "model";
ADDRLP4 4
ADDRGP4 $343
ASGNP4
line 722
;722:	model = Info_ValueForKey( botinfo, key );
ADDRLP4 1036
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 1088
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1044
ADDRLP4 1088
INDIRP4
ASGNP4
line 723
;723:	if ( !*model ) {
ADDRLP4 1044
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $424
line 724
;724:		model = "visor/default";
ADDRLP4 1044
ADDRGP4 $426
ASGNP4
line 725
;725:	}
LABELV $424
line 726
;726:	Info_SetValueForKey( userinfo, key, model );
ADDRLP4 8
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 1044
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 727
;727:	key = "team_model";
ADDRLP4 4
ADDRGP4 $427
ASGNP4
line 728
;728:	Info_SetValueForKey( userinfo, key, model );
ADDRLP4 8
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 1044
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 730
;729:
;730:	key = "headmodel";
ADDRLP4 4
ADDRGP4 $428
ASGNP4
line 731
;731:	headmodel = Info_ValueForKey( botinfo, key );
ADDRLP4 1036
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 1092
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1048
ADDRLP4 1092
INDIRP4
ASGNP4
line 732
;732:	if ( !*headmodel ) {
ADDRLP4 1048
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $429
line 733
;733:		headmodel = model;
ADDRLP4 1048
ADDRLP4 1044
INDIRP4
ASGNP4
line 734
;734:	}
LABELV $429
line 735
;735:	Info_SetValueForKey( userinfo, key, headmodel );
ADDRLP4 8
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 1048
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 736
;736:	key = "team_headmodel";
ADDRLP4 4
ADDRGP4 $431
ASGNP4
line 737
;737:	Info_SetValueForKey( userinfo, key, headmodel );
ADDRLP4 8
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 1048
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 739
;738:
;739:	key = "gender";
ADDRLP4 4
ADDRGP4 $432
ASGNP4
line 740
;740:	s = Info_ValueForKey( botinfo, key );
ADDRLP4 1036
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 1096
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1032
ADDRLP4 1096
INDIRP4
ASGNP4
line 741
;741:	if ( !*s ) {
ADDRLP4 1032
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $433
line 742
;742:		s = "male";
ADDRLP4 1032
ADDRGP4 $435
ASGNP4
line 743
;743:	}
LABELV $433
line 744
;744:	Info_SetValueForKey( userinfo, "sex", s );
ADDRLP4 8
ARGP4
ADDRGP4 $436
ARGP4
ADDRLP4 1032
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 746
;745:
;746:	key = "color1";
ADDRLP4 4
ADDRGP4 $437
ASGNP4
line 747
;747:	s = Info_ValueForKey( botinfo, key );
ADDRLP4 1036
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 1100
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1032
ADDRLP4 1100
INDIRP4
ASGNP4
line 748
;748:	if ( !*s ) {
ADDRLP4 1032
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $438
line 749
;749:		s = "4";
ADDRLP4 1032
ADDRGP4 $440
ASGNP4
line 750
;750:	}
LABELV $438
line 751
;751:	Info_SetValueForKey( userinfo, key, s );
ADDRLP4 8
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 1032
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 753
;752:
;753:	key = "color2";
ADDRLP4 4
ADDRGP4 $441
ASGNP4
line 754
;754:	s = Info_ValueForKey( botinfo, key );
ADDRLP4 1036
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 1104
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1032
ADDRLP4 1104
INDIRP4
ASGNP4
line 755
;755:	if ( !*s ) {
ADDRLP4 1032
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $442
line 760
;756:		// JUHOX: use color1 if color2 not set
;757:#if 0
;758:		s = "5";
;759:#else
;760:		s = Info_ValueForKey(userinfo, "color1");
ADDRLP4 8
ARGP4
ADDRGP4 $437
ARGP4
ADDRLP4 1108
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1032
ADDRLP4 1108
INDIRP4
ASGNP4
line 762
;761:#endif
;762:	}
LABELV $442
line 763
;763:	Info_SetValueForKey( userinfo, key, s );
ADDRLP4 8
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 1032
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 765
;764:
;765:	s = Info_ValueForKey(botinfo, "aifile");
ADDRLP4 1036
INDIRP4
ARGP4
ADDRGP4 $444
ARGP4
ADDRLP4 1108
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1032
ADDRLP4 1108
INDIRP4
ASGNP4
line 766
;766:	if (!*s ) {
ADDRLP4 1032
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $445
line 767
;767:		trap_Printf( S_COLOR_RED "Error: bot has no aifile specified\n" );
ADDRGP4 $447
ARGP4
ADDRGP4 trap_Printf
CALLV
pop
line 768
;768:		return;
ADDRGP4 $384
JUMPV
LABELV $445
line 772
;769:	}
;770:
;771:	// have the server allocate a client slot
;772:	clientNum = trap_BotAllocateClient();
ADDRLP4 1112
ADDRGP4 trap_BotAllocateClient
CALLI4
ASGNI4
ADDRLP4 1040
ADDRLP4 1112
INDIRI4
ASGNI4
line 773
;773:	if ( clientNum == -1 ) {
ADDRLP4 1040
INDIRI4
CNSTI4 -1
NEI4 $448
line 774
;774:		G_Printf( S_COLOR_RED "Unable to add bot.  All player slots are in use.\n" );
ADDRGP4 $450
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 775
;775:		G_Printf( S_COLOR_RED "Start server with more 'open' slots (or check setting of sv_maxclients cvar).\n" );
ADDRGP4 $451
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 776
;776:		return;
ADDRGP4 $384
JUMPV
LABELV $448
line 780
;777:	}
;778:
;779:	// initialize the bot settings
;780:	if( !team || !*team ) {
ADDRLP4 1116
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 1116
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $454
ADDRLP4 1116
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $452
LABELV $454
line 781
;781:		if( g_gametype.integer >= GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $455
line 782
;782:			if( PickTeam(clientNum) == TEAM_RED) {
ADDRLP4 1040
INDIRI4
ARGI4
ADDRLP4 1120
ADDRGP4 PickTeam
CALLI4
ASGNI4
ADDRLP4 1120
INDIRI4
CNSTI4 1
NEI4 $458
line 783
;783:				team = "red";
ADDRFP4 8
ADDRGP4 $216
ASGNP4
line 784
;784:			}
ADDRGP4 $456
JUMPV
LABELV $458
line 785
;785:			else {
line 786
;786:				team = "blue";
ADDRFP4 8
ADDRGP4 $219
ASGNP4
line 787
;787:			}
line 788
;788:		}
ADDRGP4 $456
JUMPV
LABELV $455
line 789
;789:		else {
line 790
;790:			team = "red";
ADDRFP4 8
ADDRGP4 $216
ASGNP4
line 791
;791:		}
LABELV $456
line 792
;792:	}
LABELV $452
line 794
;793:#if MONSTER_MODE	// JUHOX: in STU all players are in the red team
;794:	if (g_gametype.integer >= GT_STU) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
LTI4 $460
line 795
;795:		team = "red";
ADDRFP4 8
ADDRGP4 $216
ASGNP4
line 796
;796:	}
LABELV $460
line 798
;797:#endif
;798:	Info_SetValueForKey( userinfo, "characterfile", Info_ValueForKey( botinfo, "aifile" ) );
ADDRLP4 1036
INDIRP4
ARGP4
ADDRGP4 $444
ARGP4
ADDRLP4 1120
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 8
ARGP4
ADDRGP4 $364
ARGP4
ADDRLP4 1120
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 799
;799:	Info_SetValueForKey( userinfo, "skill", va( "%5.2f", skill ) );
ADDRGP4 $463
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRLP4 1124
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
ARGP4
ADDRGP4 $366
ARGP4
ADDRLP4 1124
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 800
;800:	Info_SetValueForKey( userinfo, "team", team );
ADDRLP4 8
ARGP4
ADDRGP4 $368
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 802
;801:
;802:	bot = &g_entities[ clientNum ];
ADDRLP4 1052
ADDRLP4 1040
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 803
;803:	bot->r.svFlags |= SVF_BOT;
ADDRLP4 1128
ADDRLP4 1052
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 1128
INDIRP4
ADDRLP4 1128
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 804
;804:	bot->inuse = qtrue;
ADDRLP4 1052
INDIRP4
CNSTI4 524
ADDP4
CNSTI4 1
ASGNI4
line 807
;805:
;806:	// register the userinfo
;807:	trap_SetUserinfo( clientNum, userinfo );
ADDRLP4 1040
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
ADDRGP4 trap_SetUserinfo
CALLV
pop
line 810
;808:
;809:	// have it connect to the game as a normal client
;810:	if ( ClientConnect( clientNum, qtrue, qtrue ) ) {
ADDRLP4 1040
INDIRI4
ARGI4
CNSTI4 1
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 1132
ADDRGP4 ClientConnect
CALLP4
ASGNP4
ADDRLP4 1132
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $464
line 811
;811:		return;
ADDRGP4 $384
JUMPV
LABELV $464
line 814
;812:	}
;813:
;814:	if( delay == 0 ) {
ADDRFP4 12
INDIRI4
CNSTI4 0
NEI4 $466
line 815
;815:		ClientBegin( clientNum );
ADDRLP4 1040
INDIRI4
ARGI4
ADDRGP4 ClientBegin
CALLV
pop
line 816
;816:		return;
ADDRGP4 $384
JUMPV
LABELV $466
line 819
;817:	}
;818:
;819:	AddBotToSpawnQueue( clientNum, delay );
ADDRLP4 1040
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 AddBotToSpawnQueue
CALLV
pop
line 820
;820:}
LABELV $384
endproc G_AddBot 1136 20
export Svcmd_AddBot_f
proc Svcmd_AddBot_f 4112 20
line 828
;821:
;822:
;823:/*
;824:===============
;825:Svcmd_AddBot_f
;826:===============
;827:*/
;828:void Svcmd_AddBot_f( void ) {
line 837
;829:	float			skill;
;830:	int				delay;
;831:	char			name[MAX_TOKEN_CHARS];
;832:	char			altname[MAX_TOKEN_CHARS];
;833:	char			string[MAX_TOKEN_CHARS];
;834:	char			team[MAX_TOKEN_CHARS];
;835:
;836:#if ESCAPE_MODE	// JUHOX: no bots in EFH
;837:	if (g_gametype.integer == GT_EFH) return;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
NEI4 $469
ADDRGP4 $468
JUMPV
LABELV $469
line 841
;838:#endif
;839:
;840:	// are bots enabled?
;841:	if ( !trap_Cvar_VariableIntegerValue( "bot_enable" ) ) {
ADDRGP4 $474
ARGP4
ADDRLP4 4104
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRLP4 4104
INDIRI4
CNSTI4 0
NEI4 $472
line 842
;842:		return;
ADDRGP4 $468
JUMPV
LABELV $472
line 846
;843:	}
;844:
;845:	// name
;846:	trap_Argv( 1, name, sizeof( name ) );
CNSTI4 1
ARGI4
ADDRLP4 1024
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 847
;847:	if ( !name[0] ) {
ADDRLP4 1024
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $475
line 848
;848:		trap_Printf( "Usage: Addbot <botname> [skill 1-5] [team] [msec delay] [altname]\n" );
ADDRGP4 $477
ARGP4
ADDRGP4 trap_Printf
CALLV
pop
line 849
;849:		return;
ADDRGP4 $468
JUMPV
LABELV $475
line 853
;850:	}
;851:
;852:	// skill
;853:	trap_Argv( 2, string, sizeof( string ) );
CNSTI4 2
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 854
;854:	if ( !string[0] ) {
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $478
line 855
;855:		skill = 4;
ADDRLP4 4096
CNSTF4 1082130432
ASGNF4
line 856
;856:	}
ADDRGP4 $479
JUMPV
LABELV $478
line 857
;857:	else {
line 858
;858:		skill = atof( string );
ADDRLP4 0
ARGP4
ADDRLP4 4108
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 4096
ADDRLP4 4108
INDIRF4
ASGNF4
line 859
;859:	}
LABELV $479
line 862
;860:
;861:	// team
;862:	trap_Argv( 3, team, sizeof( team ) );
CNSTI4 3
ARGI4
ADDRLP4 3072
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 865
;863:
;864:	// delay
;865:	trap_Argv( 4, string, sizeof( string ) );
CNSTI4 4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 866
;866:	if ( !string[0] ) {
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $480
line 867
;867:		delay = 0;
ADDRLP4 4100
CNSTI4 0
ASGNI4
line 868
;868:	}
ADDRGP4 $481
JUMPV
LABELV $480
line 869
;869:	else {
line 870
;870:		delay = atoi( string );
ADDRLP4 0
ARGP4
ADDRLP4 4108
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4100
ADDRLP4 4108
INDIRI4
ASGNI4
line 871
;871:	}
LABELV $481
line 874
;872:
;873:	// alternative name
;874:	trap_Argv( 5, altname, sizeof( altname ) );
CNSTI4 5
ARGI4
ADDRLP4 2048
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 876
;875:
;876:	G_AddBot( name, skill, team, delay, altname );
ADDRLP4 1024
ARGP4
ADDRLP4 4096
INDIRF4
ARGF4
ADDRLP4 3072
ARGP4
ADDRLP4 4100
INDIRI4
ARGI4
ADDRLP4 2048
ARGP4
ADDRGP4 G_AddBot
CALLV
pop
line 880
;877:
;878:	// if this was issued during gameplay and we are playing locally,
;879:	// go ahead and load the bot's media immediately
;880:	if ( level.time - level.startTime > 1000 &&
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+40
INDIRI4
SUBI4
CNSTI4 1000
LEI4 $482
ADDRGP4 $486
ARGP4
ADDRLP4 4108
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRLP4 4108
INDIRI4
CNSTI4 0
EQI4 $482
line 881
;881:		trap_Cvar_VariableIntegerValue( "cl_running" ) ) {
line 882
;882:		trap_SendServerCommand( -1, "loaddefered\n" );	// FIXME: spelled wrong, but not changing for demo
CNSTI4 -1
ARGI4
ADDRGP4 $487
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 883
;883:	}
LABELV $482
line 884
;884:}
LABELV $468
endproc Svcmd_AddBot_f 4112 20
export Svcmd_BotList_f
proc Svcmd_BotList_f 4120 20
line 891
;885:
;886:/*
;887:===============
;888:Svcmd_BotList_f
;889:===============
;890:*/
;891:void Svcmd_BotList_f( void ) {
line 898
;892:	int i;
;893:	char name[MAX_TOKEN_CHARS];
;894:	char funname[MAX_TOKEN_CHARS];
;895:	char model[MAX_TOKEN_CHARS];
;896:	char aifile[MAX_TOKEN_CHARS];
;897:
;898:	trap_Printf("^1name             model            aifile              funname\n");
ADDRGP4 $489
ARGP4
ADDRGP4 trap_Printf
CALLV
pop
line 899
;899:	for (i = 0; i < g_numBots; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $493
JUMPV
LABELV $490
line 900
;900:		strcpy(name, Info_ValueForKey( g_botInfos[i], "name" ));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_botInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $170
ARGP4
ADDRLP4 4100
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
ARGP4
ADDRLP4 4100
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 901
;901:		if ( !*name ) {
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $494
line 902
;902:			strcpy(name, "UnnamedPlayer");
ADDRLP4 4
ARGP4
ADDRGP4 $496
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 903
;903:		}
LABELV $494
line 904
;904:		strcpy(funname, Info_ValueForKey( g_botInfos[i], "funname" ));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_botInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $391
ARGP4
ADDRLP4 4104
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
ARGP4
ADDRLP4 4104
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 905
;905:		if ( !*funname ) {
ADDRLP4 1028
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $497
line 906
;906:			strcpy(funname, "");
ADDRLP4 1028
ARGP4
ADDRGP4 $130
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 907
;907:		}
LABELV $497
line 908
;908:		strcpy(model, Info_ValueForKey( g_botInfos[i], "model" ));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_botInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $343
ARGP4
ADDRLP4 4108
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 2052
ARGP4
ADDRLP4 4108
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 909
;909:		if ( !*model ) {
ADDRLP4 2052
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $499
line 910
;910:			strcpy(model, "visor/default");
ADDRLP4 2052
ARGP4
ADDRGP4 $426
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 911
;911:		}
LABELV $499
line 912
;912:		strcpy(aifile, Info_ValueForKey( g_botInfos[i], "aifile"));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_botInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $444
ARGP4
ADDRLP4 4112
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 3076
ARGP4
ADDRLP4 4112
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 913
;913:		if (!*aifile ) {
ADDRLP4 3076
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $501
line 914
;914:			strcpy(aifile, "bots/default_c.c");
ADDRLP4 3076
ARGP4
ADDRGP4 $503
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 915
;915:		}
LABELV $501
line 916
;916:		trap_Printf(va("%-16s %-16s %-20s %-20s\n", name, model, aifile, funname));
ADDRGP4 $504
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 2052
ARGP4
ADDRLP4 3076
ARGP4
ADDRLP4 1028
ARGP4
ADDRLP4 4116
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4116
INDIRP4
ARGP4
ADDRGP4 trap_Printf
CALLV
pop
line 917
;917:	}
LABELV $491
line 899
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $493
ADDRLP4 0
INDIRI4
ADDRGP4 g_numBots
INDIRI4
LTI4 $490
line 918
;918:}
LABELV $488
endproc Svcmd_BotList_f 4120 20
proc G_SpawnBots 1056 16
line 926
;919:
;920:
;921:/*
;922:===============
;923:G_SpawnBots
;924:===============
;925:*/
;926:static void G_SpawnBots( char *botList, int baseDelay ) {
line 933
;927:	char		*bot;
;928:	char		*p;
;929:	float		skill;
;930:	int			delay;
;931:	char		bots[MAX_INFO_VALUE];
;932:
;933:	podium1 = NULL;
ADDRGP4 podium1
CNSTP4 0
ASGNP4
line 934
;934:	podium2 = NULL;
ADDRGP4 podium2
CNSTP4 0
ASGNP4
line 935
;935:	podium3 = NULL;
ADDRGP4 podium3
CNSTP4 0
ASGNP4
line 937
;936:
;937:	skill = trap_Cvar_VariableValue( "g_spSkill" );
ADDRGP4 $213
ARGP4
ADDRLP4 1040
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 12
ADDRLP4 1040
INDIRF4
ASGNF4
line 938
;938:	if( skill < 1 ) {
ADDRLP4 12
INDIRF4
CNSTF4 1065353216
GEF4 $506
line 939
;939:		trap_Cvar_Set( "g_spSkill", "1" );
ADDRGP4 $213
ARGP4
ADDRGP4 $508
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 940
;940:		skill = 1;
ADDRLP4 12
CNSTF4 1065353216
ASGNF4
line 941
;941:	}
ADDRGP4 $507
JUMPV
LABELV $506
line 942
;942:	else if ( skill > 5 ) {
ADDRLP4 12
INDIRF4
CNSTF4 1084227584
LEF4 $509
line 943
;943:		trap_Cvar_Set( "g_spSkill", "5" );
ADDRGP4 $213
ARGP4
ADDRGP4 $511
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 944
;944:		skill = 5;
ADDRLP4 12
CNSTF4 1084227584
ASGNF4
line 945
;945:	}
LABELV $509
LABELV $507
line 947
;946:
;947:	Q_strncpyz( bots, botList, sizeof(bots) );
ADDRLP4 16
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 948
;948:	p = &bots[0];
ADDRLP4 0
ADDRLP4 16
ASGNP4
line 949
;949:	delay = baseDelay;
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRGP4 $513
JUMPV
line 950
;950:	while( *p ) {
LABELV $515
line 952
;951:		//skip spaces
;952:		while( *p && *p == ' ' ) {
line 953
;953:			p++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 954
;954:		}
LABELV $516
line 952
ADDRLP4 1044
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
EQI4 $518
ADDRLP4 1044
INDIRI4
CNSTI4 32
EQI4 $515
LABELV $518
line 955
;955:		if( !p ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $519
line 956
;956:			break;
ADDRGP4 $514
JUMPV
LABELV $519
line 960
;957:		}
;958:
;959:		// mark start of bot name
;960:		bot = p;
ADDRLP4 8
ADDRLP4 0
INDIRP4
ASGNP4
ADDRGP4 $522
JUMPV
LABELV $521
line 963
;961:
;962:		// skip until space of null
;963:		while( *p && *p != ' ' ) {
line 964
;964:			p++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 965
;965:		}
LABELV $522
line 963
ADDRLP4 1048
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
EQI4 $524
ADDRLP4 1048
INDIRI4
CNSTI4 32
NEI4 $521
LABELV $524
line 966
;966:		if( *p ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $525
line 967
;967:			*p++ = 0;
ADDRLP4 1052
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 1052
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 1052
INDIRP4
CNSTI1 0
ASGNI1
line 968
;968:		}
LABELV $525
line 972
;969:
;970:		// we must add the bot this way, calling G_AddBot directly at this stage
;971:		// does "Bad Things"
;972:		trap_SendConsoleCommand( EXEC_INSERT, va("addbot %s %f free %i\n", bot, skill, delay) );
ADDRGP4 $527
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 1052
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 1
ARGI4
ADDRLP4 1052
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 974
;973:
;974:		delay += BOT_BEGIN_DELAY_INCREMENT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1500
ADDI4
ASGNI4
line 975
;975:	}
LABELV $513
line 950
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $516
LABELV $514
line 976
;976:}
LABELV $505
endproc G_SpawnBots 1056 16
proc G_LoadBotsFromFile 8216 16
line 984
;977:
;978:
;979:/*
;980:===============
;981:G_LoadBotsFromFile
;982:===============
;983:*/
;984:static void G_LoadBotsFromFile( char *filename ) {
line 989
;985:	int				len;
;986:	fileHandle_t	f;
;987:	char			buf[MAX_BOTS_TEXT];
;988:
;989:	len = trap_FS_FOpenFile( filename, &f, FS_READ );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8200
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8200
INDIRI4
ASGNI4
line 990
;990:	if ( !f ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $529
line 991
;991:		trap_Printf( va( S_COLOR_RED "file not found: %s\n", filename ) );
ADDRGP4 $124
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8204
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8204
INDIRP4
ARGP4
ADDRGP4 trap_Printf
CALLV
pop
line 992
;992:		return;
ADDRGP4 $528
JUMPV
LABELV $529
line 994
;993:	}
;994:	if ( len >= MAX_BOTS_TEXT ) {
ADDRLP4 0
INDIRI4
CNSTI4 8192
LTI4 $531
line 995
;995:		trap_Printf( va( S_COLOR_RED "file too large: %s is %i, max allowed is %i", filename, len, MAX_BOTS_TEXT ) );
ADDRGP4 $127
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 8192
ARGI4
ADDRLP4 8204
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8204
INDIRP4
ARGP4
ADDRGP4 trap_Printf
CALLV
pop
line 996
;996:		trap_FS_FCloseFile( f );
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 997
;997:		return;
ADDRGP4 $528
JUMPV
LABELV $531
line 1000
;998:	}
;999:
;1000:	trap_FS_Read( buf, len, f );
ADDRLP4 8
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 1001
;1001:	buf[len] = 0;
ADDRLP4 0
INDIRI4
ADDRLP4 8
ADDP4
CNSTI1 0
ASGNI1
line 1002
;1002:	trap_FS_FCloseFile( f );
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 1004
;1003:
;1004:	g_numBots += G_ParseInfos( buf, MAX_BOTS - g_numBots, &g_botInfos[g_numBots] );
ADDRLP4 8
ARGP4
ADDRLP4 8204
ADDRGP4 g_numBots
ASGNP4
ADDRLP4 8208
ADDRLP4 8204
INDIRP4
INDIRI4
ASGNI4
CNSTI4 1024
ADDRLP4 8208
INDIRI4
SUBI4
ARGI4
ADDRLP4 8208
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_botInfos
ADDP4
ARGP4
ADDRLP4 8212
ADDRGP4 G_ParseInfos
CALLI4
ASGNI4
ADDRLP4 8204
INDIRP4
ADDRLP4 8208
INDIRI4
ADDRLP4 8212
INDIRI4
ADDI4
ASGNI4
line 1005
;1005:}
LABELV $528
endproc G_LoadBotsFromFile 8216 16
proc G_LoadBots 1452 16
line 1012
;1006:
;1007:/*
;1008:===============
;1009:G_LoadBots
;1010:===============
;1011:*/
;1012:static void G_LoadBots( void ) {
line 1022
;1013:	vmCvar_t	botsFile;
;1014:	int			numdirs;
;1015:	char		filename[128];
;1016:	char		dirlist[1024];
;1017:	char*		dirptr;
;1018:	int			i;
;1019:	int			dirlen;
;1020:
;1021:#if ESCAPE_MODE	// JUHOX: no bots in EFH
;1022:	if (g_gametype.integer == GT_EFH) return;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
NEI4 $534
ADDRGP4 $533
JUMPV
LABELV $534
line 1025
;1023:#endif
;1024:
;1025:	if ( !trap_Cvar_VariableIntegerValue( "bot_enable" ) ) {
ADDRGP4 $474
ARGP4
ADDRLP4 1440
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRLP4 1440
INDIRI4
CNSTI4 0
NEI4 $537
line 1026
;1026:		return;
ADDRGP4 $533
JUMPV
LABELV $537
line 1029
;1027:	}
;1028:
;1029:	g_numBots = 0;
ADDRGP4 g_numBots
CNSTI4 0
ASGNI4
line 1031
;1030:
;1031:	trap_Cvar_Register( &botsFile, "g_botsFile", "", CVAR_INIT|CVAR_ROM );
ADDRLP4 144
ARGP4
ADDRGP4 $539
ARGP4
ADDRGP4 $130
ARGP4
CNSTI4 80
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1032
;1032:	if( *botsFile.string ) {
ADDRLP4 144+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $540
line 1033
;1033:		G_LoadBotsFromFile(botsFile.string);
ADDRLP4 144+16
ARGP4
ADDRGP4 G_LoadBotsFromFile
CALLV
pop
line 1034
;1034:	}
ADDRGP4 $541
JUMPV
LABELV $540
line 1035
;1035:	else {
line 1036
;1036:		G_LoadBotsFromFile("scripts/bots.txt");
ADDRGP4 $544
ARGP4
ADDRGP4 G_LoadBotsFromFile
CALLV
pop
line 1037
;1037:	}
LABELV $541
line 1040
;1038:
;1039:	// get all bots from .bot files
;1040:	numdirs = trap_FS_GetFileList("scripts", ".bot", dirlist, 1024 );
ADDRGP4 $136
ARGP4
ADDRGP4 $545
ARGP4
ADDRLP4 416
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1444
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRLP4 140
ADDRLP4 1444
INDIRI4
ASGNI4
line 1041
;1041:	dirptr  = dirlist;
ADDRLP4 0
ADDRLP4 416
ASGNP4
line 1042
;1042:	for (i = 0; i < numdirs; i++, dirptr += dirlen+1) {
ADDRLP4 132
CNSTI4 0
ASGNI4
ADDRGP4 $549
JUMPV
LABELV $546
line 1043
;1043:		dirlen = strlen(dirptr);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1448
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 136
ADDRLP4 1448
INDIRI4
ASGNI4
line 1044
;1044:		strcpy(filename, "scripts/");
ADDRLP4 4
ARGP4
ADDRGP4 $142
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1045
;1045:		strcat(filename, dirptr);
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 1046
;1046:		G_LoadBotsFromFile(filename);
ADDRLP4 4
ARGP4
ADDRGP4 G_LoadBotsFromFile
CALLV
pop
line 1047
;1047:	}
LABELV $547
line 1042
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 136
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 0
INDIRP4
ADDP4
ASGNP4
LABELV $549
ADDRLP4 132
INDIRI4
ADDRLP4 140
INDIRI4
LTI4 $546
line 1048
;1048:	trap_Printf( va( "%i bots parsed\n", g_numBots ) );
ADDRGP4 $550
ARGP4
ADDRGP4 g_numBots
INDIRI4
ARGI4
ADDRLP4 1448
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1448
INDIRP4
ARGP4
ADDRGP4 trap_Printf
CALLV
pop
line 1049
;1049:}
LABELV $533
endproc G_LoadBots 1452 16
export G_GetBotInfoByNumber
proc G_GetBotInfoByNumber 8 8
line 1058
;1050:
;1051:
;1052:
;1053:/*
;1054:===============
;1055:G_GetBotInfoByNumber
;1056:===============
;1057:*/
;1058:char *G_GetBotInfoByNumber( int num ) {
line 1059
;1059:	if( num < 0 || num >= g_numBots ) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $554
ADDRLP4 0
INDIRI4
ADDRGP4 g_numBots
INDIRI4
LTI4 $552
LABELV $554
line 1060
;1060:		trap_Printf( va( S_COLOR_RED "Invalid bot number: %i\n", num ) );
ADDRGP4 $555
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_Printf
CALLV
pop
line 1061
;1061:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $551
JUMPV
LABELV $552
line 1063
;1062:	}
;1063:	return g_botInfos[num];
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_botInfos
ADDP4
INDIRP4
RETP4
LABELV $551
endproc G_GetBotInfoByNumber 8 8
export G_GetBotInfoByName
proc G_GetBotInfoByName 16 8
line 1072
;1064:}
;1065:
;1066:
;1067:/*
;1068:===============
;1069:G_GetBotInfoByName
;1070:===============
;1071:*/
;1072:char *G_GetBotInfoByName( const char *name ) {
line 1076
;1073:	int		n;
;1074:	char	*value;
;1075:
;1076:	for ( n = 0; n < g_numBots ; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $560
JUMPV
LABELV $557
line 1077
;1077:		value = Info_ValueForKey( g_botInfos[n], "name" );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_botInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $170
ARGP4
ADDRLP4 8
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 1078
;1078:		if ( !Q_stricmp( value, name ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $561
line 1079
;1079:			return g_botInfos[n];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_botInfos
ADDP4
INDIRP4
RETP4
ADDRGP4 $556
JUMPV
LABELV $561
line 1081
;1080:		}
;1081:	}
LABELV $558
line 1076
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $560
ADDRLP4 0
INDIRI4
ADDRGP4 g_numBots
INDIRI4
LTI4 $557
line 1083
;1082:
;1083:	return NULL;
CNSTP4 0
RETP4
LABELV $556
endproc G_GetBotInfoByName 16 8
export G_InitBots
proc G_InitBots 1144 16
line 1091
;1084:}
;1085:
;1086:/*
;1087:===============
;1088:G_InitBots
;1089:===============
;1090:*/
;1091:void G_InitBots( qboolean restart ) {
line 1100
;1092:	int			fragLimit;
;1093:	int			timeLimit;
;1094:	const char	*arenainfo;
;1095:	char		*strValue;
;1096:	int			basedelay;
;1097:	char		map[MAX_QPATH];
;1098:	char		serverinfo[MAX_INFO_STRING];
;1099:
;1100:	G_LoadBots();
ADDRGP4 G_LoadBots
CALLV
pop
line 1101
;1101:	G_LoadArenas();
ADDRGP4 G_LoadArenas
CALLV
pop
line 1103
;1102:
;1103:	trap_Cvar_Register( &bot_minplayers, "bot_minplayers", "0", CVAR_SERVERINFO );
ADDRGP4 bot_minplayers
ARGP4
ADDRGP4 $564
ARGP4
ADDRGP4 $565
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1105
;1104:
;1105:	if( g_gametype.integer == GT_SINGLE_PLAYER ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 2
NEI4 $566
line 1106
;1106:		trap_GetServerinfo( serverinfo, sizeof(serverinfo) );
ADDRLP4 80
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetServerinfo
CALLV
pop
line 1107
;1107:		Q_strncpyz( map, Info_ValueForKey( serverinfo, "mapname" ), sizeof(map) );
ADDRLP4 80
ARGP4
ADDRGP4 $569
ARGP4
ADDRLP4 1108
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 16
ARGP4
ADDRLP4 1108
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1108
;1108:		arenainfo = G_GetArenaInfoByMap( map );
ADDRLP4 16
ARGP4
ADDRLP4 1112
ADDRGP4 G_GetArenaInfoByMap
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 1112
INDIRP4
ASGNP4
line 1109
;1109:		if ( !arenainfo ) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $570
line 1110
;1110:			return;
ADDRGP4 $563
JUMPV
LABELV $570
line 1113
;1111:		}
;1112:
;1113:		strValue = Info_ValueForKey( arenainfo, "fraglimit" );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $572
ARGP4
ADDRLP4 1116
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1116
INDIRP4
ASGNP4
line 1114
;1114:		fragLimit = atoi( strValue );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1120
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 1120
INDIRI4
ASGNI4
line 1115
;1115:		if ( fragLimit ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $573
line 1116
;1116:			trap_Cvar_Set( "fraglimit", strValue );
ADDRGP4 $572
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1117
;1117:		}
ADDRGP4 $574
JUMPV
LABELV $573
line 1118
;1118:		else {
line 1119
;1119:			trap_Cvar_Set( "fraglimit", "0" );
ADDRGP4 $572
ARGP4
ADDRGP4 $565
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1120
;1120:		}
LABELV $574
line 1122
;1121:
;1122:		strValue = Info_ValueForKey( arenainfo, "timelimit" );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $575
ARGP4
ADDRLP4 1124
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1124
INDIRP4
ASGNP4
line 1123
;1123:		timeLimit = atoi( strValue );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1128
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 1128
INDIRI4
ASGNI4
line 1124
;1124:		if ( timeLimit ) {
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $576
line 1125
;1125:			trap_Cvar_Set( "timelimit", strValue );
ADDRGP4 $575
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1126
;1126:		}
ADDRGP4 $577
JUMPV
LABELV $576
line 1127
;1127:		else {
line 1128
;1128:			trap_Cvar_Set( "timelimit", "0" );
ADDRGP4 $575
ARGP4
ADDRGP4 $565
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1129
;1129:		}
LABELV $577
line 1131
;1130:
;1131:		if ( !fragLimit && !timeLimit ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $578
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $578
line 1132
;1132:			trap_Cvar_Set( "fraglimit", "10" );
ADDRGP4 $572
ARGP4
ADDRGP4 $580
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1133
;1133:			trap_Cvar_Set( "timelimit", "0" );
ADDRGP4 $575
ARGP4
ADDRGP4 $565
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1134
;1134:		}
LABELV $578
line 1136
;1135:
;1136:		basedelay = BOT_BEGIN_DELAY_BASE;
ADDRLP4 1104
CNSTI4 2000
ASGNI4
line 1137
;1137:		strValue = Info_ValueForKey( arenainfo, "special" );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $581
ARGP4
ADDRLP4 1132
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1132
INDIRP4
ASGNP4
line 1138
;1138:		if( Q_stricmp( strValue, "training" ) == 0 ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $584
ARGP4
ADDRLP4 1136
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1136
INDIRI4
CNSTI4 0
NEI4 $582
line 1139
;1139:			basedelay += 10000;
ADDRLP4 1104
ADDRLP4 1104
INDIRI4
CNSTI4 10000
ADDI4
ASGNI4
line 1140
;1140:		}
LABELV $582
line 1142
;1141:
;1142:		if( !restart ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $585
line 1143
;1143:			G_SpawnBots( Info_ValueForKey( arenainfo, "bots" ), basedelay );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $587
ARGP4
ADDRLP4 1140
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1140
INDIRP4
ARGP4
ADDRLP4 1104
INDIRI4
ARGI4
ADDRGP4 G_SpawnBots
CALLV
pop
line 1144
;1144:		}
LABELV $585
line 1145
;1145:	}
LABELV $566
line 1146
;1146:}
LABELV $563
endproc G_InitBots 1144 16
proc FreeMonsterInfo 0 0
line 1154
;1147:
;1148:/*
;1149:===============
;1150:JUHOX: FreeMonsterInfo
;1151:===============
;1152:*/
;1153:#if MONSTER_MODE
;1154:static void FreeMonsterInfo(gmonster_t* monster) {
line 1155
;1155:	if (!monster) return;
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $589
ADDRGP4 $588
JUMPV
LABELV $589
line 1158
;1156:
;1157:	// mark as unused
;1158:	monster->ps.clientNum = 0;
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 1159
;1159:	monster->entity = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTP4 0
ASGNP4
line 1161
;1160:
;1161:	monster->next = freeMonster;
ADDRFP4 0
INDIRP4
ADDRGP4 freeMonster
INDIRP4
ASGNP4
line 1162
;1162:	freeMonster = monster;
ADDRGP4 freeMonster
ADDRFP4 0
INDIRP4
ASGNP4
line 1163
;1163:}
LABELV $588
endproc FreeMonsterInfo 0 0
proc GetMonsterInfo 4 12
line 1172
;1164:#endif
;1165:
;1166:/*
;1167:===============
;1168:JUHOX: GetMonsterInfo
;1169:===============
;1170:*/
;1171:#if MONSTER_MODE
;1172:static gmonster_t* GetMonsterInfo(void) {
line 1175
;1173:	gmonster_t* monster;
;1174:
;1175:	if (!freeMonster) return NULL;
ADDRGP4 freeMonster
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $592
CNSTP4 0
RETP4
ADDRGP4 $591
JUMPV
LABELV $592
line 1177
;1176:
;1177:	monster = freeMonster;
ADDRLP4 0
ADDRGP4 freeMonster
INDIRP4
ASGNP4
line 1178
;1178:	freeMonster = monster->next;
ADDRGP4 freeMonster
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
line 1180
;1179:
;1180:	memset(monster, 0, sizeof(*monster));
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 708
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1181
;1181:	return monster;
ADDRLP4 0
INDIRP4
RETP4
LABELV $591
endproc GetMonsterInfo 4 12
export G_NumMonsters
proc G_NumMonsters 0 0
line 1191
;1182:}
;1183:#endif
;1184:
;1185:/*
;1186:===============
;1187:JUHOX: G_NumMonsters
;1188:===============
;1189:*/
;1190:#if MONSTER_MODE
;1191:int G_NumMonsters(void) {
line 1192
;1192:	return numMonsters;
ADDRGP4 numMonsters
INDIRI4
RETI4
LABELV $594
endproc G_NumMonsters 0 0
proc G_FreeMonster 0 4
line 1202
;1193:}
;1194:#endif
;1195:
;1196:/*
;1197:===============
;1198:JUHOX: G_FreeMonster
;1199:===============
;1200:*/
;1201:#if MONSTER_MODE
;1202:static void G_FreeMonster(gentity_t* monster) {
line 1203
;1203:	if (monster->monster) {
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $596
line 1204
;1204:		FreeMonsterInfo(monster->monster);
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
ARGP4
ADDRGP4 FreeMonsterInfo
CALLV
pop
line 1205
;1205:		monster->monster = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
CNSTP4 0
ASGNP4
line 1206
;1206:	}
LABELV $596
line 1207
;1207:	G_FreeEntity(monster);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 1208
;1208:}
LABELV $595
endproc G_FreeMonster 0 4
export G_KillMonster
proc G_KillMonster 8 4
line 1217
;1209:#endif
;1210:
;1211:/*
;1212:===============
;1213:JUHOX: G_KillMonster
;1214:===============
;1215:*/
;1216:#if MONSTER_MODE
;1217:void G_KillMonster(gentity_t* monster) {
line 1218
;1218:	if (monster->monster && monster->health > 0) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $599
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
LEI4 $599
line 1219
;1219:		numMonsters--;
ADDRLP4 4
ADDRGP4 numMonsters
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1220
;1220:	}
LABELV $599
line 1221
;1221:	G_FreeMonster(monster);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeMonster
CALLV
pop
line 1222
;1222:}
LABELV $598
endproc G_KillMonster 8 4
proc AddMonsterSpawnPoolEntry 8 0
line 1231
;1223:#endif
;1224:
;1225:/*
;1226:===============
;1227:JUHOX: AddMonsterSpawnPoolEntry
;1228:===============
;1229:*/
;1230:#if MONSTER_MODE
;1231:static void AddMonsterSpawnPoolEntry(const vec3_t pos) {
line 1232
;1232:	if (numMonsterSpawnPoolEntries >= MONSTER_SPAWNPOOL_SIZE) return;
ADDRGP4 numMonsterSpawnPoolEntries
INDIRI4
CNSTI4 4096
LTI4 $602
ADDRGP4 $601
JUMPV
LABELV $602
line 1234
;1233:
;1234:	VectorCopy(pos, monsterSpawnPool[numMonsterSpawnPoolEntries++]);
ADDRLP4 4
ADDRGP4 numMonsterSpawnPoolEntries
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
CNSTI4 12
MULI4
ADDRGP4 monsterSpawnPool
ADDP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 1235
;1235:}
LABELV $601
endproc AddMonsterSpawnPoolEntry 8 0
proc CheckMonsterSpawnPoolEntry 8 8
line 1244
;1236:#endif
;1237:
;1238:/*
;1239:===============
;1240:JUHOX: CheckMonsterSpawnPoolEntry
;1241:===============
;1242:*/
;1243:#if MONSTER_MODE
;1244:static void CheckMonsterSpawnPoolEntry(const vec3_t pos) {
line 1247
;1245:	int i;
;1246:
;1247:	if (numMonsterSpawnPoolEntries >= MONSTER_SPAWNPOOL_SIZE) return;
ADDRGP4 numMonsterSpawnPoolEntries
INDIRI4
CNSTI4 4096
LTI4 $605
ADDRGP4 $604
JUMPV
LABELV $605
line 1249
;1248:
;1249:	for (i = 0; i < numMonsterSpawnPoolEntries; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $610
JUMPV
LABELV $607
line 1250
;1250:		if (DistanceSquared(pos, monsterSpawnPool[i]) < 50*50) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 monsterSpawnPool
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 4
INDIRF4
CNSTF4 1159479296
GEF4 $611
ADDRGP4 $604
JUMPV
LABELV $611
line 1251
;1251:	}
LABELV $608
line 1249
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $610
ADDRLP4 0
INDIRI4
ADDRGP4 numMonsterSpawnPoolEntries
INDIRI4
LTI4 $607
line 1252
;1252:	AddMonsterSpawnPoolEntry(pos);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 AddMonsterSpawnPoolEntry
CALLV
pop
line 1253
;1253:}
LABELV $604
endproc CheckMonsterSpawnPoolEntry 8 8
proc InitMonsterSpawnPool 4 4
line 1262
;1254:#endif
;1255:
;1256:/*
;1257:===============
;1258:JUHOX: InitMonsterSpawnPool
;1259:===============
;1260:*/
;1261:#if MONSTER_MODE
;1262:static void InitMonsterSpawnPool(void) {
line 1265
;1263:	int i;
;1264:
;1265:	numMonsterSpawnPoolEntries = 0;
ADDRGP4 numMonsterSpawnPoolEntries
CNSTI4 0
ASGNI4
line 1267
;1266:
;1267:	for (i = 0; i < level.numEmergencySpawnPoints; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $617
JUMPV
LABELV $614
line 1268
;1268:		AddMonsterSpawnPoolEntry(level.emergencySpawnPoints[i]);
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 level+10704
ADDP4
ARGP4
ADDRGP4 AddMonsterSpawnPoolEntry
CALLV
pop
line 1269
;1269:	}
LABELV $615
line 1267
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $617
ADDRLP4 0
INDIRI4
ADDRGP4 level+10700
INDIRI4
LTI4 $614
line 1270
;1270:}
LABELV $613
endproc InitMonsterSpawnPool 4 4
export G_InitMonsters
proc G_InitMonsters 4 4
line 1279
;1271:#endif
;1272:
;1273:/*
;1274:===============
;1275:JUHOX: G_InitMonsters
;1276:===============
;1277:*/
;1278:#if MONSTER_MODE
;1279:void G_InitMonsters(void) {
line 1282
;1280:	int i;
;1281:
;1282:	numMonsters = 0;
ADDRGP4 numMonsters
CNSTI4 0
ASGNI4
line 1283
;1283:	nextMonsterSpawnTime = -1;
ADDRGP4 nextMonsterSpawnTime
CNSTI4 -1
ASGNI4
line 1285
;1284:
;1285:	freeMonster = NULL;
ADDRGP4 freeMonster
CNSTP4 0
ASGNP4
line 1286
;1286:	for (i = 0; i < MAX_MONSTERS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $621
line 1287
;1287:		FreeMonsterInfo(&monsterInfo[i]);
ADDRLP4 0
INDIRI4
CNSTI4 708
MULI4
ADDRGP4 monsterInfo
ADDP4
ARGP4
ADDRGP4 FreeMonsterInfo
CALLV
pop
line 1288
;1288:	}
LABELV $622
line 1286
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 200
LTI4 $621
line 1290
;1289:
;1290:	InitMonsterSpawnPool();
ADDRGP4 InitMonsterSpawnPool
CALLV
pop
line 1292
;1291:
;1292:	firstMonsterSeed = 0;
ADDRGP4 firstMonsterSeed
CNSTI4 0
ASGNI4
line 1293
;1293:	lastMonsterSeed = 0;
ADDRGP4 lastMonsterSeed
CNSTI4 0
ASGNI4
line 1294
;1294:}
LABELV $620
endproc G_InitMonsters 4 4
proc G_MonsterCorrectEntityState 12 0
line 1305
;1295:#endif
;1296:
;1297:/*
;1298:===============
;1299:JUHOX: G_MonsterCorrectEntityState
;1300:
;1301:needed after any call to 'BG_PlayerStateToEntityState()' or 'BG_PlayerStateToEntityStateExtraPolate()'
;1302:===============
;1303:*/
;1304:#if MONSTER_MODE
;1305:static void G_MonsterCorrectEntityState(gentity_t* monster) {
line 1306
;1306:	if (!monster->monster) return;
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $626
ADDRGP4 $625
JUMPV
LABELV $626
line 1308
;1307:
;1308:	monster->s.clientNum = monster->monster->clientNum;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ASGNI4
line 1309
;1309:	monster->s.otherEntityNum = monster->monster->owner;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 140
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 484
ADDP4
INDIRI4
ASGNI4
line 1311
;1310:	if (
;1311:		monster->monster->type == MT_titan &&
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 476
ADDP4
INDIRI4
CNSTI4 2
NEI4 $628
ADDRLP4 8
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
CNSTI4 5
NEI4 $628
line 1313
;1312:		monster->monster->action == MA_sleeping
;1313:	) {
line 1314
;1314:		monster->s.otherEntityNum2 = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
CNSTI4 1
ASGNI4
line 1315
;1315:	}
ADDRGP4 $629
JUMPV
LABELV $628
line 1316
;1316:	else {
line 1317
;1317:		monster->s.otherEntityNum2 = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
CNSTI4 0
ASGNI4
line 1318
;1318:	}
LABELV $629
line 1319
;1319:}
LABELV $625
endproc G_MonsterCorrectEntityState 12 0
export G_UpdateMonsterCS
proc G_UpdateMonsterCS 4 12
line 1328
;1320:#endif
;1321:
;1322:/*
;1323:===============
;1324:JUHOX: G_UpdateMonsterCS
;1325:===============
;1326:*/
;1327:#if MONSTER_MODE
;1328:void G_UpdateMonsterCS(void) {
line 1329
;1329:	trap_SetConfigstring(
ADDRGP4 $631
ARGP4
ADDRGP4 numMonsters
INDIRI4
ARGI4
ADDRGP4 level+22992
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 717
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1333
;1330:		CS_NUMMONSTERS,
;1331:		va("%03d,%d", numMonsters, level.maxMonstersPerPlayer)
;1332:	);
;1333:}
LABELV $630
endproc G_UpdateMonsterCS 4 12
proc MonsterBodyDie 0 8
line 1344
;1334:#endif
;1335:
;1336:/*
;1337:===============
;1338:JUHOX: MonsterBodyDie
;1339:
;1340:derived from body_die() [g_combat.c]
;1341:===============
;1342:*/
;1343:#if MONSTER_MODE
;1344:static void MonsterBodyDie(gentity_t* self, gentity_t* inflictor, gentity_t* attacker, int damage, int mod) {
line 1345
;1345:	if (self->health > GIB_HEALTH) {
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 -40
LEI4 $634
line 1346
;1346:		return;
ADDRGP4 $633
JUMPV
LABELV $634
line 1348
;1347:	}
;1348:	if (!g_blood.integer) {
ADDRGP4 g_blood+12
INDIRI4
CNSTI4 0
NEI4 $636
line 1349
;1349:		self->health = GIB_HEALTH+1;
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 -39
ASGNI4
line 1350
;1350:		return;
ADDRGP4 $633
JUMPV
LABELV $636
line 1353
;1351:	}
;1352:
;1353:	GibEntity(self, 0);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 GibEntity
CALLV
pop
line 1356
;1354:
;1355:	// NOTE: can't free the entity immediatly because it's still needed to broadcast the gib event
;1356:	self->think = G_FreeMonster;
ADDRFP4 0
INDIRP4
CNSTI4 696
ADDP4
ADDRGP4 G_FreeMonster
ASGNP4
line 1357
;1357:	self->nextthink = level.time + 2000;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 1358
;1358:}
LABELV $633
endproc MonsterBodyDie 0 8
proc MonsterDie 44 12
line 1369
;1359:#endif
;1360:
;1361:/*
;1362:===============
;1363:JUHOX: MonsterDie
;1364:
;1365:derived from player_die() [combat.c]
;1366:===============
;1367:*/
;1368:#if MONSTER_MODE
;1369:static void MonsterDie(gentity_t* self, gentity_t* inflictor, gentity_t* attacker, int damage, int mod) {
line 1373
;1370:	int contents;
;1371:	int killer;
;1372:
;1373:	if (!self->monster) return;
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $641
ADDRGP4 $640
JUMPV
LABELV $641
line 1376
;1374:
;1375:#if ESCAPE_MODE
;1376:	G_MakeWorldAwareOfMonsterDeath(self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_MakeWorldAwareOfMonsterDeath
CALLV
pop
line 1379
;1377:#endif
;1378:
;1379:	numMonsters--;
ADDRLP4 8
ADDRGP4 numMonsters
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1382
;1380:
;1381:	if (
;1382:		numMonsters < g_minMonsters.integer &&
ADDRGP4 numMonsters
INDIRI4
ADDRGP4 g_minMonsters+12
INDIRI4
GEI4 $643
ADDRGP4 nextMonsterSpawnTime
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 200
ADDI4
LEI4 $643
line 1384
;1383:		nextMonsterSpawnTime > level.time + 200
;1384:	) {
line 1385
;1385:		nextMonsterSpawnTime = level.time + 200;
ADDRGP4 nextMonsterSpawnTime
ADDRGP4 level+32
INDIRI4
CNSTI4 200
ADDI4
ASGNI4
line 1386
;1386:	}
LABELV $643
line 1388
;1387:
;1388:	if (attacker) {
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $648
line 1389
;1389:		killer = attacker->s.number;
ADDRLP4 4
ADDRFP4 8
INDIRP4
INDIRI4
ASGNI4
line 1391
;1390:		if (
;1391:			g_gametype.integer >= GT_STU &&
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
LTI4 $649
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $649
ADDRGP4 level+23012
INDIRI4
CNSTI4 0
GTI4 $649
ADDRGP4 level+9140
INDIRI4
CNSTI4 0
NEI4 $649
ADDRGP4 level+9144
INDIRI4
CNSTI4 0
NEI4 $649
line 1396
;1392:			attacker->client &&
;1393:			level.endPhase <= 0 &&
;1394:			!level.intermissionQueued &&
;1395:			!level.intermissiontime
;1396:		) {
line 1399
;1397:			int score;
;1398:
;1399:			switch (self->monster->type) {
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 476
ADDP4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $659
ADDRLP4 16
INDIRI4
CNSTI4 1
EQI4 $660
ADDRLP4 16
INDIRI4
CNSTI4 2
EQI4 $661
ADDRGP4 $656
JUMPV
LABELV $659
line 1401
;1400:			case MT_predator:
;1401:				score = 10;
ADDRLP4 12
CNSTI4 10
ASGNI4
line 1402
;1402:				break;
ADDRGP4 $657
JUMPV
LABELV $660
line 1404
;1403:			case MT_guard:
;1404:				score = 30;
ADDRLP4 12
CNSTI4 30
ASGNI4
line 1405
;1405:				break;
ADDRGP4 $657
JUMPV
LABELV $661
line 1407
;1406:			case MT_titan:
;1407:				score = 100;
ADDRLP4 12
CNSTI4 100
ASGNI4
line 1408
;1408:				break;
ADDRGP4 $657
JUMPV
LABELV $656
line 1410
;1409:			default:
;1410:				score = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 1411
;1411:				break;
LABELV $657
line 1413
;1412:			}
;1413:			if (g_scoreMode.integer) {
ADDRGP4 g_scoreMode+12
INDIRI4
CNSTI4 0
EQI4 $662
line 1414
;1414:				score = (score * self->monster->ps.stats[STAT_MAX_HEALTH]) / G_MonsterBaseHealth(self->monster->type, 5.0);
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 476
ADDP4
INDIRI4
ARGI4
CNSTF4 1084227584
ARGF4
ADDRLP4 28
ADDRGP4 G_MonsterBaseHealth
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 12
INDIRI4
ADDRLP4 24
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
MULI4
ADDRLP4 28
INDIRI4
DIVI4
ASGNI4
line 1415
;1415:			}
LABELV $662
line 1416
;1416:			level.stuScore += score;
ADDRLP4 24
ADDRGP4 level+23020
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
ADDI4
ASGNI4
line 1417
;1417:			attacker->client->ps.persistant[PERS_SCORE] += score;
ADDRLP4 28
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 248
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
ADDI4
ASGNI4
line 1418
;1418:			ScorePlum(attacker, self->r.currentOrigin, score);
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 ScorePlum
CALLV
pop
line 1419
;1419:		}
line 1420
;1420:	}
ADDRGP4 $649
JUMPV
LABELV $648
line 1421
;1421:	else {
line 1422
;1422:		killer = ENTITYNUM_NONE;
ADDRLP4 4
CNSTI4 1023
ASGNI4
line 1423
;1423:	}
LABELV $649
line 1425
;1424:
;1425:	contents = trap_PointContents(self->r.currentOrigin, -1);
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 12
ADDRGP4 trap_PointContents
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 1428
;1426:
;1427:	if (
;1428:		self->monster->ps.powerups[PW_CHARGE] - level.time >= 8500 / CHARGE_DAMAGE_PER_SECOND
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 360
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
SUBI4
CVIF4 4
CNSTF4 1174720512
LTF4 $666
line 1429
;1429:	) {
line 1430
;1430:		self->health = GIB_HEALTH;
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 -40
ASGNI4
line 1431
;1431:	}
LABELV $666
line 1433
;1432:
;1433:	self->s.powerups = 0;
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
CNSTI4 0
ASGNI4
line 1434
;1434:	self->r.contents = CONTENTS_CORPSE;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 67108864
ASGNI4
line 1435
;1435:	self->s.loopSound = 0;
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
CNSTI4 0
ASGNI4
line 1436
;1436:	self->r.maxs[2] = -8;
ADDRFP4 0
INDIRP4
CNSTI4 456
ADDP4
CNSTF4 3238002688
ASGNF4
line 1437
;1437:	self->monster->ps.pm_type = PM_DEAD;
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 3
ASGNI4
line 1438
;1438:	memset(self->monster->ps.powerups, 0, PW_NUM_POWERUPS * sizeof(int));
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 320
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 52
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1442
;1439:
;1440:	// never gib in a nodrop
;1441:	if (
;1442:		(
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 -40
GTI4 $674
ADDRLP4 0
INDIRI4
CVIU4 4
CNSTU4 2147483648
BANDU4
CNSTU4 0
NEU4 $674
ADDRGP4 g_blood+12
INDIRI4
CNSTI4 0
NEI4 $675
LABELV $674
ADDRFP4 16
INDIRI4
CNSTI4 25
EQI4 $675
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
CNSTI4 4
NEI4 $669
LABELV $675
line 1449
;1443:			self->health <= GIB_HEALTH &&
;1444:			!(contents & CONTENTS_NODROP) &&
;1445:			g_blood.integer
;1446:		) ||
;1447:		mod == MOD_SUICIDE ||
;1448:		self->monster->action == MA_hibernation
;1449:	) {
line 1451
;1450:		// gib death
;1451:		GibEntity(self, killer);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 GibEntity
CALLV
pop
line 1454
;1452:
;1453:		// NOTE: can't free the entity immediatly because it's still needed to broadcast the gib event
;1454:		self->think = G_FreeMonster;
ADDRFP4 0
INDIRP4
CNSTI4 696
ADDP4
ADDRGP4 G_FreeMonster
ASGNP4
line 1455
;1455:		self->nextthink = level.time + 2000;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 1456
;1456:	}
ADDRGP4 $670
JUMPV
LABELV $669
line 1457
;1457:	else {
line 1462
;1458:		// normal death
;1459:		int i;
;1460:		int anim;
;1461:
;1462:		i = rand() % 3;
ADDRLP4 24
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 24
INDIRI4
CNSTI4 3
MODI4
ASGNI4
line 1464
;1463:
;1464:		switch (i) {
ADDRLP4 28
ADDRLP4 16
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $679
ADDRLP4 28
INDIRI4
CNSTI4 1
EQI4 $680
ADDRLP4 28
INDIRI4
CNSTI4 2
EQI4 $681
ADDRGP4 $677
JUMPV
LABELV $679
line 1466
;1465:		case 0:
;1466:			anim = BOTH_DEATH1;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 1467
;1467:			break;
ADDRGP4 $678
JUMPV
LABELV $680
line 1469
;1468:		case 1:
;1469:			anim = BOTH_DEATH2;
ADDRLP4 20
CNSTI4 2
ASGNI4
line 1470
;1470:			break;
ADDRGP4 $678
JUMPV
LABELV $681
LABELV $677
line 1473
;1471:		case 2:
;1472:		default:
;1473:			anim = BOTH_DEATH3;
ADDRLP4 20
CNSTI4 4
ASGNI4
line 1474
;1474:			break;
LABELV $678
line 1479
;1475:		}
;1476:
;1477:		// for the no-blood option, we need to prevent the health
;1478:		// from going to gib level
;1479:		if (self->health <= GIB_HEALTH) {
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 -40
GTI4 $682
line 1480
;1480:			self->health = GIB_HEALTH + 1;
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 -39
ASGNI4
line 1481
;1481:		}
LABELV $682
line 1483
;1482:
;1483:		self->monster->ps.legsAnim =
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 84
ADDP4
ADDRLP4 32
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 128
BXORI4
ADDRLP4 20
INDIRI4
BORI4
ASGNI4
line 1485
;1484:			((self->monster->ps.legsAnim & ANIM_TOGGLEBIT) ^ ANIM_TOGGLEBIT) | anim;
;1485:		self->monster->ps.torsoAnim =
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 36
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 92
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 128
BXORI4
ADDRLP4 20
INDIRI4
BORI4
ASGNI4
line 1488
;1486:			((self->monster->ps.torsoAnim & ANIM_TOGGLEBIT) ^ ANIM_TOGGLEBIT) | anim;
;1487:
;1488:		G_AddEvent(self, EV_DEATH1 + i, killer);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
INDIRI4
CNSTI4 58
ADDI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 1491
;1489:
;1490:		// the body can still be gibbed
;1491:		self->die = MonsterBodyDie;
ADDRFP4 0
INDIRP4
CNSTI4 720
ADDP4
ADDRGP4 MonsterBodyDie
ASGNP4
line 1494
;1492:
;1493:		// copy anims to entityState
;1494:		BG_PlayerStateToEntityState(&self->monster->ps, &self->s, qtrue);
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 8
ADDP4
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BG_PlayerStateToEntityState
CALLV
pop
line 1495
;1495:		G_MonsterCorrectEntityState(self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_MonsterCorrectEntityState
CALLV
pop
line 1505
;1496:
;1497:		/*
;1498:		self->monster->timeOfSinking = level.time + 6700;
;1499:		self->monster->sinkOriginSet = qfalse;
;1500:		*/
;1501:		// JUHOX: don't copy the monster to the body que in EFH
;1502:#if !ESCAPE_MODE
;1503:		self->monster->timeOfBodyCopying = level.time + 3000;
;1504:#else
;1505:		if (g_gametype.integer != GT_EFH) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
EQI4 $684
line 1506
;1506:			self->monster->timeOfBodyCopying = level.time + 3000;
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 648
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 1507
;1507:		}
LABELV $684
line 1509
;1508:#endif
;1509:	}
LABELV $670
line 1511
;1510:
;1511:	trap_LinkEntity(self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 1512
;1512:}
LABELV $640
endproc MonsterDie 44 12
proc MonsterEvents 92 32
line 1523
;1513:#endif
;1514:
;1515:/*
;1516:================
;1517:JUHOX: MonsterEvents
;1518:
;1519:derived from ClientEvents() [g_active.c]
;1520:================
;1521:*/
;1522:#if MONSTER_MODE
;1523:static void MonsterEvents(gentity_t* monster, int oldEventSequence) {
line 1527
;1524:	int i;
;1525:	gmonster_t* mi;
;1526:
;1527:	mi = monster->monster;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
ASGNP4
line 1528
;1528:	if (!mi) return;
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $689
ADDRGP4 $688
JUMPV
LABELV $689
line 1530
;1529:
;1530:	if (oldEventSequence < mi->ps.eventSequence - MAX_PS_EVENTS) {
ADDRFP4 4
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
CNSTI4 2
SUBI4
GEI4 $691
line 1531
;1531:		oldEventSequence = mi->ps.eventSequence - MAX_PS_EVENTS;
ADDRFP4 4
ADDRLP4 4
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 1532
;1532:	}
LABELV $691
line 1533
;1533:	for (i = oldEventSequence; i < mi->ps.eventSequence; i++) {
ADDRLP4 0
ADDRFP4 4
INDIRI4
ASGNI4
ADDRGP4 $696
JUMPV
LABELV $693
line 1537
;1534:		int event;
;1535:		int damage;
;1536:
;1537:		event = mi->ps.events[i & (MAX_PS_EVENTS-1)];
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 120
ADDP4
ADDP4
INDIRI4
ASGNI4
line 1539
;1538:
;1539:		switch (event) {
ADDRLP4 8
INDIRI4
CNSTI4 11
EQI4 $699
ADDRLP4 8
INDIRI4
CNSTI4 12
EQI4 $699
ADDRLP4 8
INDIRI4
CNSTI4 11
LTI4 $698
LABELV $719
ADDRLP4 8
INDIRI4
CNSTI4 23
EQI4 $706
ADDRGP4 $698
JUMPV
LABELV $699
line 1542
;1540:		case EV_FALL_MEDIUM:
;1541:		case EV_FALL_FAR:
;1542:			if (g_dmflags.integer & DF_NO_FALLING) {
ADDRGP4 g_dmflags+12
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $700
line 1543
;1543:				break;
ADDRGP4 $698
JUMPV
LABELV $700
line 1545
;1544:			}
;1545:			if (event == EV_FALL_FAR) {
ADDRLP4 8
INDIRI4
CNSTI4 12
NEI4 $703
line 1546
;1546:				damage = 10;
ADDRLP4 12
CNSTI4 10
ASGNI4
line 1547
;1547:			} else {
ADDRGP4 $704
JUMPV
LABELV $703
line 1548
;1548:				damage = 5;
ADDRLP4 12
CNSTI4 5
ASGNI4
line 1549
;1549:			}
LABELV $704
line 1550
;1550:			monster->pain_debounce_time = level.time + 200;	// no normal pain sound
ADDRFP4 0
INDIRP4
CNSTI4 724
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 200
ADDI4
ASGNI4
line 1551
;1551:			G_Damage(monster, NULL, NULL, NULL, NULL, damage, 0, MOD_FALLING);
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
ADDRLP4 12
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 24
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 1552
;1552:			break;
ADDRGP4 $698
JUMPV
LABELV $706
line 1555
;1553:
;1554:		case EV_FIRE_WEAPON:
;1555:			switch (mi->type) {
ADDRLP4 20
ADDRLP4 4
INDIRP4
CNSTI4 476
ADDP4
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 1
EQI4 $710
ADDRGP4 $698
JUMPV
LABELV $710
line 1557
;1556:			case MT_guard:
;1557:				{
line 1561
;1558:					vec3_t forward, right, up, muzzlePoint;
;1559:					gentity_t* rocket;
;1560:
;1561:					AngleVectors(mi->ps.viewangles, forward, right, up);
ADDRLP4 4
INDIRP4
CNSTI4 160
ADDP4
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 48
ARGP4
ADDRLP4 64
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 1562
;1562:					CalcMuzzlePoint(monster, forward, right, up, muzzlePoint);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 48
ARGP4
ADDRLP4 64
ARGP4
ADDRLP4 24
ARGP4
ADDRGP4 CalcMuzzlePoint
CALLV
pop
line 1563
;1563:					VectorMA(muzzlePoint, 32, right, muzzlePoint);
ADDRLP4 24
ADDRLP4 24
INDIRF4
ADDRLP4 48
INDIRF4
CNSTF4 1107296256
MULF4
ADDF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 24+4
INDIRF4
ADDRLP4 48+4
INDIRF4
CNSTF4 1107296256
MULF4
ADDF4
ASGNF4
ADDRLP4 24+8
ADDRLP4 24+8
INDIRF4
ADDRLP4 48+8
INDIRF4
CNSTF4 1107296256
MULF4
ADDF4
ASGNF4
line 1565
;1564:					//VectorMA(muzzlePoint, 8, up, muzzlePoint);
;1565:					forward[0] += crandom() * 0.05;
ADDRLP4 76
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 36
ADDRLP4 36
INDIRF4
ADDRLP4 76
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 76
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
CNSTF4 1036831949
MULF4
ADDF4
ASGNF4
line 1566
;1566:					forward[1] += crandom() * 0.05;
ADDRLP4 80
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 36+4
ADDRLP4 36+4
INDIRF4
ADDRLP4 80
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 80
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
CNSTF4 1036831949
MULF4
ADDF4
ASGNF4
line 1567
;1567:					forward[2] += crandom() * 0.05;
ADDRLP4 84
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 36+8
ADDRLP4 36+8
INDIRF4
ADDRLP4 84
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 84
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
CNSTF4 1036831949
MULF4
ADDF4
ASGNF4
line 1568
;1568:					VectorNormalize(forward);
ADDRLP4 36
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 1569
;1569:					rocket = fire_rocket(monster, muzzlePoint, forward);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 88
ADDRGP4 fire_rocket
CALLP4
ASGNP4
ADDRLP4 60
ADDRLP4 88
INDIRP4
ASGNP4
line 1570
;1570:					rocket->methodOfDeath = MOD_GUARD;
ADDRLP4 60
INDIRP4
CNSTI4 756
ADDP4
CNSTI4 4
ASGNI4
line 1571
;1571:					rocket->splashMethodOfDeath = MOD_GUARD;
ADDRLP4 60
INDIRP4
CNSTI4 760
ADDP4
CNSTI4 4
ASGNI4
line 1572
;1572:				}
line 1573
;1573:				break;
line 1575
;1574:			default:
;1575:				break;
line 1577
;1576:			}
;1577:			break;
line 1580
;1578:
;1579:		default:
;1580:			break;
LABELV $698
line 1582
;1581:		}
;1582:	}
LABELV $694
line 1533
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $696
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
LTI4 $693
line 1584
;1583:
;1584:}
LABELV $688
endproc MonsterEvents 92 32
data
align 4
LABELV $721
byte 4 1109393408
byte 4 1109393408
byte 4 1112539136
code
proc MonsterTouchTriggers 4220 16
line 1595
;1585:#endif
;1586:
;1587:/*
;1588:============
;1589:JUHOX: MonsterTouchTriggers
;1590:
;1591:derived from G_TouchTriggers() [from g_active.c]
;1592:============
;1593:*/
;1594:#if MONSTER_MODE
;1595:static void MonsterTouchTriggers(gentity_t* monster) {
line 1603
;1596:	int i, num;
;1597:	int touch[MAX_GENTITIES];
;1598:	gentity_t* hit;
;1599:	trace_t trace;
;1600:	vec3_t mins, maxs;
;1601:	static vec3_t range = { 40, 40, 52 };
;1602:
;1603:	if (!monster->monster) return;
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $722
ADDRGP4 $720
JUMPV
LABELV $722
line 1606
;1604:
;1605:	// dead clients don't activate triggers!
;1606:	if (monster->health <= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
GTI4 $724
line 1607
;1607:		return;
ADDRGP4 $720
JUMPV
LABELV $724
line 1610
;1608:	}
;1609:
;1610:	VectorSubtract(monster->monster->ps.origin, range, mins);
ADDRLP4 4188
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
ADDRLP4 4188
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRGP4 $721
INDIRF4
SUBF4
ASGNF4
ADDRLP4 64+4
ADDRLP4 4188
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRGP4 $721+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 64+8
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRGP4 $721+8
INDIRF4
SUBF4
ASGNF4
line 1611
;1611:	VectorAdd(monster->monster->ps.origin, range, maxs);
ADDRLP4 4192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
ADDRLP4 4192
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRGP4 $721
INDIRF4
ADDF4
ASGNF4
ADDRLP4 76+4
ADDRLP4 4192
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRGP4 $721+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 76+8
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRGP4 $721+8
INDIRF4
ADDF4
ASGNF4
line 1613
;1612:
;1613:	num = trap_EntitiesInBox(mins, maxs, touch, MAX_GENTITIES);
ADDRLP4 64
ARGP4
ADDRLP4 76
ARGP4
ADDRLP4 92
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 4196
ADDRGP4 trap_EntitiesInBox
CALLI4
ASGNI4
ADDRLP4 88
ADDRLP4 4196
INDIRI4
ASGNI4
line 1616
;1614:
;1615:	// can't use ent->absmin, because that has a one unit pad
;1616:	VectorAdd(monster->monster->ps.origin, monster->r.mins, mins);
ADDRLP4 4200
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
ADDRLP4 4200
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 4200
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 64+4
ADDRLP4 4200
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 4200
INDIRP4
CNSTI4 440
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4204
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64+8
ADDRLP4 4204
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 4204
INDIRP4
CNSTI4 444
ADDP4
INDIRF4
ADDF4
ASGNF4
line 1617
;1617:	VectorAdd(monster->monster->ps.origin, monster->r.maxs, maxs);
ADDRLP4 4208
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
ADDRLP4 4208
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 4208
INDIRP4
CNSTI4 448
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 76+4
ADDRLP4 4208
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 4208
INDIRP4
CNSTI4 452
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4212
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76+8
ADDRLP4 4212
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 4212
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
ADDF4
ASGNF4
line 1619
;1618:
;1619:	for (i=0; i < num; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $741
JUMPV
LABELV $738
line 1620
;1620:		hit = &g_entities[touch[i]];
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
line 1622
;1621:
;1622:		if (!hit->touch && !monster->touch) {
ADDRLP4 0
INDIRP4
CNSTI4 708
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $742
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $742
line 1623
;1623:			continue;
ADDRGP4 $739
JUMPV
LABELV $742
line 1625
;1624:		}
;1625:		if (!(hit->r.contents & CONTENTS_TRIGGER)) {
ADDRLP4 0
INDIRP4
CNSTI4 460
ADDP4
INDIRI4
CNSTI4 1073741824
BANDI4
CNSTI4 0
NEI4 $744
line 1626
;1626:			continue;
ADDRGP4 $739
JUMPV
LABELV $744
line 1631
;1627:		}
;1628:
;1629:		// use seperate code for determining if an item is picked up
;1630:		// so you don't have to actually contact its bounding box
;1631:		if (hit->s.eType == ET_ITEM) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $746
line 1633
;1632:			// monsters don't pick up items
;1633:			continue;
ADDRGP4 $739
JUMPV
LABELV $746
line 1634
;1634:		} else {
line 1635
;1635:			if (!trap_EntityContact(mins, maxs, hit)) {
ADDRLP4 64
ARGP4
ADDRLP4 76
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4216
ADDRGP4 trap_EntityContact
CALLI4
ASGNI4
ADDRLP4 4216
INDIRI4
CNSTI4 0
NEI4 $748
line 1636
;1636:				continue;
ADDRGP4 $739
JUMPV
LABELV $748
line 1638
;1637:			}
;1638:		}
line 1640
;1639:
;1640:		memset(&trace, 0, sizeof(trace));
ADDRLP4 8
ARGP4
CNSTI4 0
ARGI4
CNSTI4 56
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1642
;1641:
;1642:		if (hit->touch) {
ADDRLP4 0
INDIRP4
CNSTI4 708
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $750
line 1643
;1643:			hit->touch(hit, monster, &trace);
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
line 1644
;1644:		}
LABELV $750
line 1646
;1645:
;1646:		if (monster->touch) {
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $752
line 1647
;1647:			monster->touch(monster, hit, &trace);
ADDRLP4 4216
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4216
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 4216
INDIRP4
CNSTI4 708
ADDP4
INDIRP4
CALLV
pop
line 1648
;1648:		}
LABELV $752
line 1649
;1649:	}
LABELV $739
line 1619
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $741
ADDRLP4 4
INDIRI4
ADDRLP4 88
INDIRI4
LTI4 $738
line 1652
;1650:
;1651:	// if we didn't touch a jump pad this pmove frame
;1652:	if (monster->monster->ps.jumppad_frame != monster->monster->ps.pmove_framecount) {
ADDRLP4 4216
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4216
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
ADDRLP4 4216
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 464
ADDP4
INDIRI4
EQI4 $754
line 1653
;1653:		monster->monster->ps.jumppad_frame = 0;
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 468
ADDP4
CNSTI4 0
ASGNI4
line 1654
;1654:		monster->monster->ps.jumppad_ent = 0;
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 456
ADDP4
CNSTI4 0
ASGNI4
line 1655
;1655:	}
LABELV $754
line 1656
;1656:}
LABELV $720
endproc MonsterTouchTriggers 4220 16
proc CauseMonsterChargeDamage 36 32
line 1665
;1657:#endif
;1658:
;1659:/*
;1660:====================
;1661:JUHOX: CauseMonsterChargeDamage
;1662:====================
;1663:*/
;1664:#if MONSTER_MODE
;1665:static void CauseMonsterChargeDamage(gentity_t* monster) {
line 1668
;1666:	gmonster_t* mi;
;1667:
;1668:	mi = monster->monster;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
ASGNP4
line 1669
;1669:	if (!mi) return;
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $757
ADDRGP4 $756
JUMPV
LABELV $757
line 1671
;1670:
;1671:	if (mi->lastChargeTime) {
ADDRLP4 0
INDIRP4
CNSTI4 700
ADDP4
INDIRI4
CNSTI4 0
EQI4 $759
line 1676
;1672:		int n;
;1673:		float damage;
;1674:		gentity_t* attacker;
;1675:
;1676:		attacker = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 1677
;1677:		n = monster->chargeInflictor;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 816
ADDP4
INDIRI4
ASGNI4
line 1678
;1678:		if (n >= 0 && n < MAX_CLIENTS) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $761
ADDRLP4 4
INDIRI4
CNSTI4 64
GEI4 $761
line 1679
;1679:			attacker = &g_entities[n];
ADDRLP4 8
ADDRLP4 4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1680
;1680:			if (!attacker->inuse || !attacker->client) attacker = NULL;
ADDRLP4 20
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
EQI4 $765
ADDRLP4 20
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $763
LABELV $765
ADDRLP4 8
CNSTP4 0
ASGNP4
LABELV $763
line 1681
;1681:		}
LABELV $761
line 1683
;1682:
;1683:		damage = mi->chargeDamageResidual + TotalChargeDamage(mi->lastChargeAmount);
ADDRLP4 0
INDIRP4
CNSTI4 692
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
CNSTI4 696
ADDP4
INDIRF4
ADDRLP4 24
INDIRF4
ADDF4
ASGNF4
line 1684
;1684:		if (monster->waterlevel <= 0 || level.endPhase) {
ADDRFP4 0
INDIRP4
CNSTI4 792
ADDP4
INDIRI4
CNSTI4 0
LEI4 $769
ADDRGP4 level+23012
INDIRI4
CNSTI4 0
EQI4 $766
LABELV $769
line 1687
;1685:			float time;
;1686:
;1687:			time = (level.time - mi->lastChargeTime) / 1000.0;
ADDRLP4 28
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 700
ADDP4
INDIRI4
SUBI4
CVIF4 4
CNSTF4 981668463
MULF4
ASGNF4
line 1688
;1688:			damage -= TotalChargeDamage(mi->lastChargeAmount - time);
ADDRLP4 0
INDIRP4
CNSTI4 692
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
line 1689
;1689:		}
ADDRGP4 $767
JUMPV
LABELV $766
line 1690
;1690:		else {
line 1691
;1691:			mi->ps.powerups[PW_CHARGE] -= (int) (1000.0 * mi->lastChargeAmount);
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 360
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
INDIRF4
CNSTF4 1148846080
MULF4
CVFI4 4
SUBI4
ASGNI4
line 1692
;1692:		}
LABELV $767
line 1694
;1693:
;1694:		n = (int) damage;
ADDRLP4 4
ADDRLP4 12
INDIRF4
CVFI4 4
ASGNI4
line 1695
;1695:		mi->chargeDamageResidual = damage - n;
ADDRLP4 0
INDIRP4
CNSTI4 696
ADDP4
ADDRLP4 12
INDIRF4
ADDRLP4 4
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 1697
;1696:
;1697:		if (n) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $771
line 1698
;1698:			G_Damage(monster, attacker, attacker, NULL, NULL, n, 0, MOD_CHARGE);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 28
INDIRP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 1701
;1699:
;1700:			// make sure the monster is aware of the attack even if the damage wasn't strong enough to hurt
;1701:			if (attacker) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $773
line 1702
;1702:				mi->lastHurtEntity = attacker;
ADDRLP4 0
INDIRP4
CNSTI4 640
ADDP4
ADDRLP4 8
INDIRP4
ASGNP4
line 1703
;1703:				mi->lastHurtTime = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 644
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1704
;1704:			}
LABELV $773
line 1705
;1705:		}
LABELV $771
line 1706
;1706:	}
LABELV $759
line 1708
;1707:
;1708:	if (mi->ps.powerups[PW_CHARGE] > level.time) {
ADDRLP4 0
INDIRP4
CNSTI4 360
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $776
line 1709
;1709:		mi->lastChargeAmount = (mi->ps.powerups[PW_CHARGE] - level.time) / 1000.0;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 360
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
SUBI4
CVIF4 4
CNSTF4 981668463
MULF4
ASGNF4
line 1710
;1710:		mi->lastChargeTime = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 700
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1711
;1711:	}
ADDRGP4 $777
JUMPV
LABELV $776
line 1712
;1712:	else {
line 1713
;1713:		mi->lastChargeAmount = 0.0;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
CNSTF4 0
ASGNF4
line 1715
;1714:		//mi->chargeDamageResidual = 0.0;
;1715:		mi->lastChargeTime = 0;
ADDRLP4 0
INDIRP4
CNSTI4 700
ADDP4
CNSTI4 0
ASGNI4
line 1716
;1716:	}
LABELV $777
line 1717
;1717:}
LABELV $756
endproc CauseMonsterChargeDamage 36 32
proc SetUserCmdViewAngles 8 0
line 1726
;1718:#endif
;1719:
;1720:/*
;1721:===============
;1722:JUHOX: SetUserCmdViewAngles
;1723:===============
;1724:*/
;1725:#if MONSTER_MODE
;1726:static void SetUserCmdViewAngles(usercmd_t* cmd, const playerState_t* ps, const vec3_t angles) {
line 1729
;1727:	int i;
;1728:
;1729:	for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $782
line 1730
;1730:		cmd->angles[i] = ANGLE2SHORT(angles[i]) - ps->delta_angles[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRF4
CNSTF4 1127615329
MULF4
CVFI4 4
CNSTI4 65535
BANDI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 56
ADDP4
ADDP4
INDIRI4
SUBI4
ASGNI4
line 1731
;1731:	}
LABELV $783
line 1729
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $782
line 1732
;1732:}
LABELV $781
endproc SetUserCmdViewAngles 8 0
proc SetMonsterViewCmd 44 12
line 1746
;1733:#endif
;1734:
;1735:/*
;1736:===============
;1737:JUHOX: SetMonsterViewCmd
;1738:===============
;1739:*/
;1740:#if MONSTER_MODE
;1741:#define PREDATOR_VIEW_SPEED				240.0	// degrees per second
;1742:#define PREDATOR_HIBERNATION_VIEW_SPEED	120.0
;1743:#define PREDATOR_ATTACK_VIEW_SPEED		450.0
;1744:#define GUARD_VIEW_SPEED				80.0
;1745:#define TITAN_VIEW_SPEED				250.0
;1746:static void SetMonsterViewCmd(gmonster_t* mi, int msec) {
line 1752
;1747:	vec3_t diff;
;1748:	vec_t viewSpeed;
;1749:	vec_t maxDiff;
;1750:	int i;
;1751:
;1752:	AnglesSubtract(mi->ideal_view, mi->ps.viewangles, diff);
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 624
ADDP4
ARGP4
ADDRLP4 24
INDIRP4
CNSTI4 160
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 AnglesSubtract
CALLV
pop
line 1754
;1753:
;1754:	switch (mi->type) {
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 476
ADDP4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $790
ADDRLP4 28
INDIRI4
CNSTI4 1
EQI4 $796
ADDRLP4 28
INDIRI4
CNSTI4 2
EQI4 $797
ADDRGP4 $787
JUMPV
LABELV $790
LABELV $787
line 1757
;1755:	case MT_predator:
;1756:	default:
;1757:		switch (mi->action) {
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 2
EQI4 $794
ADDRLP4 36
INDIRI4
CNSTI4 4
EQI4 $795
ADDRGP4 $791
JUMPV
LABELV $794
line 1759
;1758:		case MA_attacking:
;1759:			viewSpeed = PREDATOR_ATTACK_VIEW_SPEED;
ADDRLP4 20
CNSTF4 1138819072
ASGNF4
line 1760
;1760:			break;
ADDRGP4 $788
JUMPV
LABELV $795
line 1762
;1761:		case MA_hibernation:
;1762:			viewSpeed = PREDATOR_HIBERNATION_VIEW_SPEED;
ADDRLP4 20
CNSTF4 1123024896
ASGNF4
line 1763
;1763:			break;
ADDRGP4 $788
JUMPV
LABELV $791
line 1765
;1764:		default:
;1765:			viewSpeed = PREDATOR_VIEW_SPEED;
ADDRLP4 20
CNSTF4 1131413504
ASGNF4
line 1766
;1766:			break;
line 1768
;1767:		}
;1768:		break;
ADDRGP4 $788
JUMPV
LABELV $796
line 1770
;1769:	case MT_guard:
;1770:		viewSpeed = GUARD_VIEW_SPEED;
ADDRLP4 20
CNSTF4 1117782016
ASGNF4
line 1771
;1771:		break;
ADDRGP4 $788
JUMPV
LABELV $797
line 1773
;1772:	case MT_titan:
;1773:		viewSpeed = TITAN_VIEW_SPEED;
ADDRLP4 20
CNSTF4 1132068864
ASGNF4
line 1774
;1774:		break;
LABELV $788
line 1776
;1775:	}
;1776:	maxDiff = viewSpeed * msec / 1000.0;
ADDRLP4 16
ADDRLP4 20
INDIRF4
ADDRFP4 4
INDIRI4
CVIF4 4
MULF4
CNSTF4 981668463
MULF4
ASGNF4
line 1777
;1777:	for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $798
line 1778
;1778:		if (diff[i] > maxDiff) diff[i] = maxDiff;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
LEF4 $802
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
ADDRLP4 16
INDIRF4
ASGNF4
ADDRGP4 $803
JUMPV
LABELV $802
line 1779
;1779:		else if (diff[i] < -maxDiff) diff[i] = -maxDiff;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
NEGF4
GEF4 $804
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
ADDRLP4 16
INDIRF4
NEGF4
ASGNF4
LABELV $804
LABELV $803
line 1781
;1780:
;1781:		diff[i] += mi->ps.viewangles[i];
ADDRLP4 40
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
ADDP4
INDIRF4
ADDF4
ASGNF4
line 1782
;1782:	}
LABELV $799
line 1777
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $798
line 1784
;1783:
;1784:	SetUserCmdViewAngles(&mi->cmd, &mi->ps, diff);
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 8
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 SetUserCmdViewAngles
CALLV
pop
line 1785
;1785:}
LABELV $786
endproc SetMonsterViewCmd 44 12
export EntityAudible
proc EntityAudible 16 0
line 1793
;1786:#endif
;1787:
;1788:/*
;1789:===============
;1790:JUHOX: EntityAudible
;1791:===============
;1792:*/
;1793:qboolean EntityAudible(const gentity_t* ent) {
line 1794
;1794:	if (ent->s.eType < ET_EVENTS) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 14
GEI4 $807
line 1795
;1795:		switch (ent->s.eType) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $810
ADDRLP4 0
INDIRI4
CNSTI4 3
EQI4 $813
ADDRLP4 0
INDIRI4
CNSTI4 4
EQI4 $810
ADDRGP4 $809
JUMPV
line 1798
;1796:		case ET_PLAYER:
;1797:		case ET_MOVER:
;1798:			break;
LABELV $813
line 1800
;1799:		case ET_MISSILE:
;1800:			switch (ent->s.weapon) {
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 5
EQI4 $817
ADDRLP4 8
INDIRI4
CNSTI4 8
EQI4 $817
ADDRLP4 8
INDIRI4
CNSTI4 9
EQI4 $817
ADDRGP4 $810
JUMPV
LABELV $817
line 1804
;1801:			case WP_ROCKET_LAUNCHER:
;1802:			case WP_PLASMAGUN:
;1803:			case WP_BFG:
;1804:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $806
JUMPV
line 1806
;1805:			}
;1806:			break;
LABELV $809
line 1808
;1807:		default:
;1808:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $806
JUMPV
LABELV $810
line 1810
;1809:		}
;1810:	}
LABELV $807
line 1812
;1811:
;1812:	if (ent->client) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $818
line 1813
;1813:		if (ent->s.eFlags & EF_FIRING) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $820
CNSTI4 1
RETI4
ADDRGP4 $806
JUMPV
LABELV $820
line 1816
;1814:
;1815:#if GRAPPLE_ROPE
;1816:		switch (ent->client->ps.stats[STAT_GRAPPLE_STATE]) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $822
ADDRLP4 0
INDIRI4
CNSTI4 6
GTI4 $822
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $826-12
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $826
address $825
address $825
address $825
address $825
code
LABELV $825
line 1821
;1817:		case GST_windoff:
;1818:		case GST_rewind:
;1819:		case GST_pulling:
;1820:		case GST_blocked:
;1821:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $806
JUMPV
LABELV $822
line 1824
;1822:		}
;1823:#endif
;1824:		switch (ent->s.weapon) {
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 6
EQI4 $831
ADDRLP4 8
INDIRI4
CNSTI4 7
EQI4 $831
ADDRLP4 8
INDIRI4
CNSTI4 9
EQI4 $831
ADDRGP4 $828
JUMPV
LABELV $831
line 1828
;1825:		case WP_LIGHTNING:
;1826:		case WP_RAILGUN:
;1827:		case WP_BFG:
;1828:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $806
JUMPV
LABELV $828
line 1830
;1829:		}
;1830:	}
LABELV $818
line 1832
;1831:
;1832:	if (ent->eventTime < level.time - 900) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 900
SUBI4
GEI4 $832
CNSTI4 0
RETI4
ADDRGP4 $806
JUMPV
LABELV $832
line 1833
;1833:	switch (ent->s.event & ~EV_EVENT_BITS) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 -769
BANDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $835
ADDRLP4 0
INDIRI4
CNSTI4 9
GTI4 $835
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $839
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $839
address $838
address $835
address $835
address $835
address $835
address $835
address $838
address $838
address $838
address $838
code
LABELV $838
line 1840
;1834:	case EV_NONE:
;1835:	case EV_STEP_4:
;1836:	case EV_STEP_8:
;1837:	case EV_STEP_12:
;1838:	case EV_STEP_16:
;1839://	case EV_POWERUP_REGEN:
;1840:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $806
JUMPV
LABELV $835
line 1842
;1841:	}
;1842:	return qtrue;
CNSTI4 1
RETI4
LABELV $806
endproc EntityAudible 16 0
export G_MonsterScanForNoises
proc G_MonsterScanForNoises 32 4
line 1860
;1843:}
;1844:
;1845:#if MONSTER_MODE
;1846:typedef struct {
;1847:	vec3_t origin;
;1848:	gentity_t* source;
;1849:} noiseSource_t;
;1850:static noiseSource_t sourcesOfNoise[MAX_GENTITIES];
;1851:static int numSourcesOfNoise;
;1852:#endif
;1853:
;1854:/*
;1855:===============
;1856:JUHOX: G_MonsterScanForNoises
;1857:===============
;1858:*/
;1859:#if MONSTER_MODE
;1860:void G_MonsterScanForNoises(void) {
line 1863
;1861:	int i;
;1862:
;1863:	numSourcesOfNoise = 0;
ADDRGP4 numSourcesOfNoise
CNSTI4 0
ASGNI4
line 1865
;1864:
;1865:	if (numMonsters <= 0) return;
ADDRGP4 numMonsters
INDIRI4
CNSTI4 0
GTI4 $842
ADDRGP4 $841
JUMPV
LABELV $842
line 1867
;1866:
;1867:	for (i = 0; i < level.num_entities; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $847
JUMPV
LABELV $844
line 1870
;1868:		gentity_t* ent;
;1869:
;1870:		ent = &g_entities[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1871
;1871:		if (!ent->inuse) continue;
ADDRLP4 4
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $849
ADDRGP4 $845
JUMPV
LABELV $849
line 1872
;1872:		if (!ent->r.linked) continue;
ADDRLP4 4
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
CNSTI4 0
NEI4 $851
ADDRGP4 $845
JUMPV
LABELV $851
line 1874
;1873:
;1874:		if (ent->client) {
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $853
line 1875
;1875:			if (ent->health <= 0) continue;
ADDRLP4 4
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
GTI4 $855
ADDRGP4 $845
JUMPV
LABELV $855
line 1876
;1876:			if (ent->client->respawnTime > level.time - 2000) continue;
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 832
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 2000
SUBI4
LEI4 $857
ADDRGP4 $845
JUMPV
LABELV $857
line 1877
;1877:			if (ent->client->ps.powerups[PW_SHIELD]) continue;
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 356
ADDP4
INDIRI4
CNSTI4 0
EQI4 $860
ADDRGP4 $845
JUMPV
LABELV $860
line 1878
;1878:		}
LABELV $853
line 1880
;1879:
;1880:		if (!EntityAudible(ent)) continue;
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 EntityAudible
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $862
ADDRGP4 $845
JUMPV
LABELV $862
line 1882
;1881:
;1882:		sourcesOfNoise[numSourcesOfNoise].source = ent;
ADDRGP4 numSourcesOfNoise
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 sourcesOfNoise+12
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 1883
;1883:		if (ent->client) {
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $865
line 1884
;1884:			VectorCopy(ent->client->ps.origin, sourcesOfNoise[numSourcesOfNoise].origin);
ADDRGP4 numSourcesOfNoise
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 sourcesOfNoise
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 1885
;1885:		}
ADDRGP4 $866
JUMPV
LABELV $865
line 1886
;1886:		else if (ent->monster) {
ADDRLP4 4
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $867
line 1887
;1887:			VectorCopy(ent->monster->ps.origin, sourcesOfNoise[numSourcesOfNoise].origin);
ADDRGP4 numSourcesOfNoise
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 sourcesOfNoise
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRB
ASGNB 12
line 1888
;1888:		}
ADDRGP4 $868
JUMPV
LABELV $867
line 1889
;1889:		else {
line 1892
;1890:			vec3_t org;
;1891:
;1892:			VectorAdd(ent->r.absmin, ent->r.absmax, org);
ADDRLP4 12
ADDRLP4 4
INDIRP4
CNSTI4 464
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 476
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 4
INDIRP4
CNSTI4 468
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 480
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 4
INDIRP4
CNSTI4 472
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 484
ADDP4
INDIRF4
ADDF4
ASGNF4
line 1893
;1893:			VectorScale(org, 0.5, org);
ADDRLP4 12
ADDRLP4 12
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 1895
;1894:
;1895:			VectorCopy(org, sourcesOfNoise[numSourcesOfNoise].origin);
ADDRGP4 numSourcesOfNoise
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 sourcesOfNoise
ADDP4
ADDRLP4 12
INDIRB
ASGNB 12
line 1896
;1896:		}
LABELV $868
LABELV $866
line 1897
;1897:		numSourcesOfNoise++;
ADDRLP4 12
ADDRGP4 numSourcesOfNoise
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1898
;1898:	}
LABELV $845
line 1867
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $847
ADDRLP4 0
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $844
line 1899
;1899:}
LABELV $841
endproc G_MonsterScanForNoises 32 4
proc MonsterSearchView 224 28
line 1908
;1900:#endif
;1901:
;1902:/*
;1903:===============
;1904:JUHOX: MonsterSearchView
;1905:===============
;1906:*/
;1907:#if MONSTER_MODE
;1908:static void MonsterSearchView(gentity_t* monster, localseed_t* masterseed) {
line 1915
;1909:	gmonster_t* mi;
;1910:	int i;
;1911:	localseed_t seed1, seed2, seed3, seed4, seed5;
;1912:	vec3_t angles;
;1913:	qboolean nervous;
;1914:
;1915:	mi = monster->monster;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
ASGNP4
line 1916
;1916:	if (!mi) return;
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $876
ADDRGP4 $875
JUMPV
LABELV $876
line 1918
;1917:
;1918:	DeriveLocalSeed(masterseed, &seed1);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 72
ARGP4
ADDRGP4 DeriveLocalSeed
CALLV
pop
line 1919
;1919:	DeriveLocalSeed(masterseed, &seed2);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 88
ARGP4
ADDRGP4 DeriveLocalSeed
CALLV
pop
line 1920
;1920:	DeriveLocalSeed(masterseed, &seed3);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 DeriveLocalSeed
CALLV
pop
line 1921
;1921:	DeriveLocalSeed(masterseed, &seed4);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 56
ARGP4
ADDRGP4 DeriveLocalSeed
CALLV
pop
line 1922
;1922:	DeriveLocalSeed(masterseed, &seed5);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 40
ARGP4
ADDRGP4 DeriveLocalSeed
CALLV
pop
line 1924
;1923:
;1924:	if (mi->nextDynViewSearch <= level.time) {
ADDRLP4 0
INDIRP4
CNSTI4 600
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
GTI4 $878
line 1929
;1925:		vec_t maxdistanceSqr;
;1926:		int choosen;
;1927:		float totalWeight;
;1928:
;1929:		mi->nextDynViewSearch = level.time + 250 + LocallySeededRandom(&seed1) % 250;
ADDRLP4 72
ARGP4
ADDRLP4 116
ADDRGP4 LocallySeededRandom
CALLU4
ASGNU4
ADDRLP4 0
INDIRP4
CNSTI4 600
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 250
ADDI4
CVIU4 4
ADDRLP4 116
INDIRU4
CNSTU4 250
MODU4
ADDU4
CVUI4 4
ASGNI4
line 1930
;1930:		if (level.intermissiontime) mi->nextDynViewSearch += 100000000;
ADDRGP4 level+9144
INDIRI4
CNSTI4 0
EQI4 $882
ADDRLP4 120
ADDRLP4 0
INDIRP4
CNSTI4 600
ADDP4
ASGNP4
ADDRLP4 120
INDIRP4
ADDRLP4 120
INDIRP4
INDIRI4
CNSTI4 100000000
ADDI4
ASGNI4
LABELV $882
line 1932
;1931:
;1932:		maxdistanceSqr = 1000.0 * 1000.0;
ADDRLP4 108
CNSTF4 1232348160
ASGNF4
line 1934
;1933:		//if (mi->ps.powerups[PW_CHARGE]) maxdistanceSqr = 600.0 * 600.0;
;1934:		choosen = -1;
ADDRLP4 112
CNSTI4 -1
ASGNI4
line 1935
;1935:		totalWeight = 0;
ADDRLP4 104
CNSTF4 0
ASGNF4
line 1937
;1936:
;1937:		for (i = 0; i < numSourcesOfNoise; i++) {
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRGP4 $888
JUMPV
LABELV $885
line 1942
;1938:			vec3_t dir;
;1939:			float distanceSqr;
;1940:			float weight;
;1941:
;1942:			if (sourcesOfNoise[i].source == monster) continue;
ADDRLP4 16
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 sourcesOfNoise+12
ADDP4
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
NEU4 $889
ADDRGP4 $886
JUMPV
LABELV $889
line 1943
;1943:			VectorSubtract(sourcesOfNoise[i].origin, mi->ps.origin, dir);
ADDRLP4 124
ADDRLP4 16
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 sourcesOfNoise
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 124+4
ADDRLP4 16
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 sourcesOfNoise+4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 124+8
ADDRLP4 16
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 sourcesOfNoise+8
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1944
;1944:			distanceSqr = VectorLengthSquared(dir);
ADDRLP4 124
ARGP4
ADDRLP4 152
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 136
ADDRLP4 152
INDIRF4
ASGNF4
line 1945
;1945:			if (distanceSqr > maxdistanceSqr) continue;
ADDRLP4 136
INDIRF4
ADDRLP4 108
INDIRF4
LEF4 $896
ADDRGP4 $886
JUMPV
LABELV $896
line 1958
;1946:			/*
;1947:			// NOTE: don't look at events the monster is already seeing
;1948:			vectoangles(dir, angles);
;1949:			if (
;1950:				fabs(AngleSubtract(angles[YAW], mi->ps.viewangles[YAW])) < 60 &&
;1951:				fabs(AngleSubtract(angles[PITCH], mi->ps.viewangles[PITCH])) < 45
;1952:			) {
;1953:				continue;
;1954:			}
;1955:			*/
;1956:			//if (!trap_InPVSIgnorePortals(mi->ps.origin, ent->s.pos.trBase)) goto NextEntity;
;1957:
;1958:			weight = 1.0 / (distanceSqr + 100);
ADDRLP4 140
CNSTF4 1065353216
ADDRLP4 136
INDIRF4
CNSTF4 1120403456
ADDF4
DIVF4
ASGNF4
line 1959
;1959:			totalWeight += weight;
ADDRLP4 104
ADDRLP4 104
INDIRF4
ADDRLP4 140
INDIRF4
ADDF4
ASGNF4
line 1960
;1960:			if (local_random(&seed5) <= weight / totalWeight) {
ADDRLP4 40
ARGP4
ADDRLP4 156
ADDRGP4 local_random
CALLF4
ASGNF4
ADDRLP4 156
INDIRF4
ADDRLP4 140
INDIRF4
ADDRLP4 104
INDIRF4
DIVF4
GTF4 $898
line 1961
;1961:				choosen = i;
ADDRLP4 112
ADDRLP4 16
INDIRI4
ASGNI4
line 1962
;1962:				vectoangles(dir, mi->ideal_view);
ADDRLP4 124
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 624
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 1963
;1963:				mi->sourceOfNoise = sourcesOfNoise[i].source;
ADDRLP4 0
INDIRP4
CNSTI4 636
ADDP4
ADDRLP4 16
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 sourcesOfNoise+12
ADDP4
INDIRP4
ASGNP4
line 1964
;1964:			}
LABELV $898
line 1972
;1965:			/*
;1966:			numgoals++;
;1967:			if (LocallySeededRandom(&seed5) % numgoals == 0) {
;1968:				vectoangles(dir, angles);
;1969:				VectorCopy(angles, mi->ideal_view);
;1970:			}
;1971:			*/
;1972:		}
LABELV $886
line 1937
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $888
ADDRLP4 16
INDIRI4
ADDRGP4 numSourcesOfNoise
INDIRI4
LTI4 $885
line 1973
;1973:		if (choosen >= 0) {
ADDRLP4 112
INDIRI4
CNSTI4 0
LTI4 $901
line 1977
;1974:			float a1, a2;
;1975:			float viewSpeed;
;1976:
;1977:			a1 = fabs(AngleSubtract(mi->ideal_view[YAW], mi->ps.viewangles[YAW]));
ADDRLP4 0
INDIRP4
CNSTI4 628
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
ADDRLP4 140
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 140
INDIRF4
ARGF4
ADDRLP4 144
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 124
ADDRLP4 144
INDIRF4
ASGNF4
line 1978
;1978:			a2 = fabs(AngleSubtract(mi->ideal_view[PITCH], mi->ps.viewangles[PITCH]));
ADDRLP4 0
INDIRP4
CNSTI4 624
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRLP4 152
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 152
INDIRF4
ARGF4
ADDRLP4 156
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 128
ADDRLP4 156
INDIRF4
ASGNF4
line 1979
;1979:			if (a2 > a1) a1 = a2;
ADDRLP4 128
INDIRF4
ADDRLP4 124
INDIRF4
LEF4 $903
ADDRLP4 124
ADDRLP4 128
INDIRF4
ASGNF4
LABELV $903
line 1980
;1980:			switch (mi->type) {
ADDRLP4 160
ADDRLP4 0
INDIRP4
CNSTI4 476
ADDP4
INDIRI4
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 0
EQI4 $908
ADDRLP4 160
INDIRI4
CNSTI4 1
EQI4 $909
ADDRLP4 160
INDIRI4
CNSTI4 2
EQI4 $910
ADDRGP4 $905
JUMPV
LABELV $908
LABELV $905
line 1983
;1981:			case MT_predator:
;1982:			default:
;1983:				viewSpeed = PREDATOR_VIEW_SPEED;
ADDRLP4 132
CNSTF4 1131413504
ASGNF4
line 1984
;1984:				break;
ADDRGP4 $906
JUMPV
LABELV $909
line 1986
;1985:			case MT_guard:
;1986:				viewSpeed = GUARD_VIEW_SPEED;
ADDRLP4 132
CNSTF4 1117782016
ASGNF4
line 1987
;1987:				break;
ADDRGP4 $906
JUMPV
LABELV $910
line 1989
;1988:			case MT_titan:
;1989:				viewSpeed = TITAN_VIEW_SPEED;
ADDRLP4 132
CNSTF4 1132068864
ASGNF4
line 1990
;1990:				break;
LABELV $906
line 1992
;1991:			}
;1992:			mi->nextEnemySearch = level.time + 100 + (int)(1000 * a1 / viewSpeed);
ADDRLP4 0
INDIRP4
CNSTI4 604
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ADDRLP4 124
INDIRF4
CNSTF4 1148846080
MULF4
ADDRLP4 132
INDIRF4
DIVF4
CVFI4 4
ADDI4
ASGNI4
line 1994
;1993:			//if (mi->type == MT_guard) mi->nextEnemySearch += 500 + rand() % 500;
;1994:			mi->nextDynViewSearch = level.time + 750 + LocallySeededRandom(&seed1) % 500;
ADDRLP4 72
ARGP4
ADDRLP4 168
ADDRGP4 LocallySeededRandom
CALLU4
ASGNU4
ADDRLP4 0
INDIRP4
CNSTI4 600
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 750
ADDI4
CVIU4 4
ADDRLP4 168
INDIRU4
CNSTU4 500
MODU4
ADDU4
CVUI4 4
ASGNI4
line 1995
;1995:			mi->nextViewSearch = level.time + 2000 + LocallySeededRandom(&seed1) % 2000;
ADDRLP4 72
ARGP4
ADDRLP4 172
ADDRGP4 LocallySeededRandom
CALLU4
ASGNU4
ADDRLP4 0
INDIRP4
CNSTI4 596
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 2000
ADDI4
CVIU4 4
ADDRLP4 172
INDIRU4
CNSTU4 2000
MODU4
ADDU4
CVUI4 4
ASGNI4
line 1996
;1996:			mi->walk = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 552
ADDP4
CNSTI4 0
ASGNI4
line 1997
;1997:			return;
ADDRGP4 $875
JUMPV
LABELV $901
line 1999
;1998:		}
;1999:		mi->sourceOfNoise = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 636
ADDP4
CNSTP4 0
ASGNP4
line 2000
;2000:	}
LABELV $878
line 2002
;2001:
;2002:	if (mi->sourceOfNoise) {
ADDRLP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $914
line 2003
;2003:		if (EntityAudible(mi->sourceOfNoise)) {
ADDRLP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRP4
ARGP4
ADDRLP4 104
ADDRGP4 EntityAudible
CALLI4
ASGNI4
ADDRLP4 104
INDIRI4
CNSTI4 0
EQI4 $916
line 2007
;2004:			vec3_t origin;
;2005:			vec3_t dir;
;2006:
;2007:			if (mi->sourceOfNoise->client) {
ADDRLP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $918
line 2008
;2008:				VectorCopy(mi->sourceOfNoise->client->ps.origin, origin);
ADDRLP4 108
ADDRLP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 2009
;2009:			}
ADDRGP4 $919
JUMPV
LABELV $918
line 2010
;2010:			else if (mi->sourceOfNoise->monster) {
ADDRLP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $920
line 2011
;2011:				VectorCopy(mi->sourceOfNoise->monster->ps.origin, origin);
ADDRLP4 108
ADDRLP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRB
ASGNB 12
line 2012
;2012:			}
ADDRGP4 $921
JUMPV
LABELV $920
line 2013
;2013:			else {
line 2014
;2014:				VectorAdd(mi->sourceOfNoise->r.absmin, mi->sourceOfNoise->r.absmax, origin);
ADDRLP4 108
ADDRLP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRP4
CNSTI4 464
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRP4
CNSTI4 476
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 108+4
ADDRLP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRP4
CNSTI4 468
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRP4
CNSTI4 480
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 108+8
ADDRLP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRP4
CNSTI4 472
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRP4
CNSTI4 484
ADDP4
INDIRF4
ADDF4
ASGNF4
line 2015
;2015:				VectorScale(origin, 0.5, origin);
ADDRLP4 108
ADDRLP4 108
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 108+4
ADDRLP4 108+4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 108+8
ADDRLP4 108+8
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 2016
;2016:			}
LABELV $921
LABELV $919
line 2018
;2017:
;2018:			VectorSubtract(origin, mi->ps.origin, dir);
ADDRLP4 120
ADDRLP4 108
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 120+4
ADDRLP4 108+4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 120+8
ADDRLP4 108+8
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2019
;2019:			vectoangles(dir, mi->ideal_view);
ADDRLP4 120
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 624
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2020
;2020:		}
ADDRGP4 $917
JUMPV
LABELV $916
line 2021
;2021:		else {
line 2022
;2022:			mi->sourceOfNoise = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 636
ADDP4
CNSTP4 0
ASGNP4
line 2023
;2023:		}
LABELV $917
line 2024
;2024:	}
LABELV $914
line 2026
;2025:
;2026:	nervous = qfalse;
ADDRLP4 36
CNSTI4 0
ASGNI4
line 2028
;2027:	if (
;2028:		(
ADDRGP4 level+23008
INDIRI4
CNSTI4 0
EQI4 $940
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+23008
INDIRI4
CNSTI4 15000
ADDI4
LTI4 $939
LABELV $940
ADDRGP4 level+23012
INDIRI4
CNSTI4 0
LEI4 $932
ADDRGP4 g_skipEndSequence+12
INDIRI4
CNSTI4 0
NEI4 $932
LABELV $939
ADDRLP4 0
INDIRP4
CNSTI4 476
ADDP4
INDIRI4
CNSTI4 0
NEI4 $932
line 2039
;2029:			(
;2030:				level.artefactCapturedTime &&
;2031:				level.time < level.artefactCapturedTime + 15000
;2032:			) ||
;2033:			(
;2034:				level.endPhase > 0 &&
;2035:				!g_skipEndSequence.integer
;2036:			)
;2037:		) &&
;2038:		mi->type == MT_predator
;2039:	) {
line 2040
;2040:		nervous = qtrue;
ADDRLP4 36
CNSTI4 1
ASGNI4
line 2041
;2041:	}
LABELV $932
line 2044
;2042:
;2043:	if (
;2044:		(
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $945
ADDRLP4 0
INDIRP4
CNSTI4 476
ADDP4
INDIRI4
CNSTI4 2
NEI4 $941
ADDRGP4 level+9144
INDIRI4
CNSTI4 0
NEI4 $941
LABELV $945
ADDRLP4 0
INDIRP4
CNSTI4 596
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDI4
LEI4 $941
line 2052
;2045:			nervous ||
;2046:			(
;2047:				mi->type == MT_titan &&
;2048:				!level.intermissiontime
;2049:			)
;2050:		) &&
;2051:		mi->nextViewSearch > level.time + 1000
;2052:	) {
line 2053
;2053:		mi->nextViewSearch = level.time + 500 + LocallySeededRandom(&seed2) % 500;
ADDRLP4 88
ARGP4
ADDRLP4 104
ADDRGP4 LocallySeededRandom
CALLU4
ASGNU4
ADDRLP4 0
INDIRP4
CNSTI4 596
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 500
ADDI4
CVIU4 4
ADDRLP4 104
INDIRU4
CNSTU4 500
MODU4
ADDU4
CVUI4 4
ASGNI4
line 2054
;2054:	}
LABELV $941
line 2056
;2055:
;2056:	if (mi->nextViewSearch > level.time) return;
ADDRLP4 0
INDIRP4
CNSTI4 596
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $947
ADDRGP4 $875
JUMPV
LABELV $947
line 2057
;2057:	mi->nextViewSearch = level.time + 1000 + LocallySeededRandom(&seed3) % 9000;
ADDRLP4 20
ARGP4
ADDRLP4 104
ADDRGP4 LocallySeededRandom
CALLU4
ASGNU4
ADDRLP4 0
INDIRP4
CNSTI4 596
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDI4
CVIU4 4
ADDRLP4 104
INDIRU4
CNSTU4 9000
MODU4
ADDU4
CVUI4 4
ASGNI4
line 2059
;2058:
;2059:	mi->walk = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 552
ADDP4
CNSTI4 0
ASGNI4
line 2061
;2060:
;2061:	for (i = 0; i < 3; i++) {
ADDRLP4 16
CNSTI4 0
ASGNI4
LABELV $951
line 2066
;2062:		vec3_t dir;
;2063:		vec3_t end;
;2064:		trace_t trace;
;2065:
;2066:		VectorSet(angles, 45 * local_crandom(&seed3), 360 * local_random(&seed3), 0);
ADDRLP4 20
ARGP4
ADDRLP4 188
ADDRGP4 local_crandom
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 188
INDIRF4
CNSTF4 1110704128
MULF4
ASGNF4
ADDRLP4 20
ARGP4
ADDRLP4 192
ADDRGP4 local_random
CALLF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 192
INDIRF4
CNSTF4 1135869952
MULF4
ASGNF4
ADDRLP4 4+8
CNSTF4 0
ASGNF4
line 2068
;2067:		if (
;2068:			fabs(AngleSubtract(angles[YAW], mi->ps.viewangles[YAW])) < 60 &&
ADDRLP4 4+4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
ADDRLP4 196
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 196
INDIRF4
ARGF4
ADDRLP4 200
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 200
INDIRF4
CNSTF4 1114636288
GEF4 $957
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRLP4 204
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 204
INDIRF4
ARGF4
ADDRLP4 208
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 208
INDIRF4
CNSTF4 1110704128
GEF4 $957
line 2070
;2069:			fabs(AngleSubtract(angles[PITCH], mi->ps.viewangles[PITCH])) < 45
;2070:		) {
line 2071
;2071:			continue;
ADDRGP4 $952
JUMPV
LABELV $957
line 2073
;2072:		}
;2073:		if (nervous) {
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $960
line 2074
;2074:			if (LocallySeededRandom(&seed5) & 1) {
ADDRLP4 40
ARGP4
ADDRLP4 212
ADDRGP4 LocallySeededRandom
CALLU4
ASGNU4
ADDRLP4 212
INDIRU4
CNSTU4 1
BANDU4
CNSTU4 0
EQU4 $962
line 2075
;2075:				angles[PITCH] -= 25;
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1103626240
SUBF4
ASGNF4
line 2076
;2076:			}
ADDRGP4 $953
JUMPV
LABELV $962
line 2077
;2077:			else {
line 2078
;2078:				angles[PITCH] += 25;
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1103626240
ADDF4
ASGNF4
line 2079
;2079:			}
line 2080
;2080:			break;
ADDRGP4 $953
JUMPV
LABELV $960
line 2082
;2081:		}
;2082:		AngleVectors(angles, dir, NULL, NULL);
ADDRLP4 4
ARGP4
ADDRLP4 108
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 2083
;2083:		VectorMA(mi->ps.origin, 400, dir, end);
ADDRLP4 120
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 108
INDIRF4
CNSTF4 1137180672
MULF4
ADDF4
ASGNF4
ADDRLP4 120+4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 108+4
INDIRF4
CNSTF4 1137180672
MULF4
ADDF4
ASGNF4
ADDRLP4 120+8
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 108+8
INDIRF4
CNSTF4 1137180672
MULF4
ADDF4
ASGNF4
line 2084
;2084:		trap_Trace(&trace, mi->ps.origin, NULL, NULL, end, mi->ps.clientNum, CONTENTS_SOLID);
ADDRLP4 132
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 120
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 2085
;2085:		if (trace.fraction >= 0.5) {
ADDRLP4 132+8
INDIRF4
CNSTF4 1056964608
LTF4 $968
line 2086
;2086:			VectorCopy(angles, mi->ideal_view);
ADDRLP4 0
INDIRP4
CNSTI4 624
ADDP4
ADDRLP4 4
INDIRB
ASGNB 12
line 2088
;2087:			if (
;2088:				(trace.fraction < 1 && angles[PITCH] > -10) ||
ADDRLP4 132+8
INDIRF4
CNSTF4 1065353216
GEF4 $975
ADDRLP4 4
INDIRF4
CNSTF4 3240099840
GTF4 $974
LABELV $975
ADDRLP4 56
ARGP4
ADDRLP4 220
ADDRGP4 local_random
CALLF4
ASGNF4
ADDRLP4 220
INDIRF4
CNSTF4 1045220557
GEF4 $875
LABELV $974
line 2090
;2089:				local_random(&seed4) < 0.2
;2090:			) {
line 2091
;2091:				mi->walk = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 552
ADDP4
CNSTI4 1
ASGNI4
line 2092
;2092:			}
line 2093
;2093:			return;
ADDRGP4 $875
JUMPV
LABELV $968
line 2095
;2094:		}
;2095:	}
LABELV $952
line 2061
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 3
LTI4 $951
LABELV $953
line 2097
;2096:
;2097:	VectorCopy(angles, mi->ideal_view);
ADDRLP4 0
INDIRP4
CNSTI4 624
ADDP4
ADDRLP4 4
INDIRB
ASGNB 12
line 2098
;2098:}
LABELV $875
endproc MonsterSearchView 224 28
data
align 4
LABELV $977
byte 4 0
byte 4 0
byte 4 1065353216
code
proc EntityVisibleToMonster 124 28
line 2107
;2099:#endif
;2100:
;2101:/*
;2102:===============
;2103:JUHOX: EntityVisibleToMonster
;2104:===============
;2105:*/
;2106:#if MONSTER_MODE
;2107:static qboolean EntityVisibleToMonster(const gentity_t* ent, const gentity_t* monster) {
line 2117
;2108:	vec3_t start;
;2109:	vec3_t dest;
;2110:	vec3_t end;
;2111:	vec3_t dir;
;2112:	static const vec3_t up = {0, 0, 1};
;2113:	vec3_t right;
;2114:	playerState_t* ps;
;2115:	trace_t trace;
;2116:
;2117:	if (!monster->monster) return qfalse;
ADDRFP4 4
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $978
CNSTI4 0
RETI4
ADDRGP4 $976
JUMPV
LABELV $978
line 2119
;2118:
;2119:	VectorCopy(monster->monster->ps.origin, start);
ADDRLP4 80
ADDRFP4 4
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRB
ASGNB 12
line 2120
;2120:	start[2] += monster->monster->ps.viewheight;
ADDRLP4 80+8
ADDRLP4 80+8
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 2121
;2121:	ps = G_GetEntityPlayerState(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 120
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 116
ADDRLP4 120
INDIRP4
ASGNP4
line 2122
;2122:	if (ps) {
ADDRLP4 116
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $981
line 2123
;2123:		VectorCopy(ps->origin, dest);
ADDRLP4 0
ADDRLP4 116
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 2124
;2124:	}
ADDRGP4 $982
JUMPV
LABELV $981
line 2125
;2125:	else {
line 2126
;2126:		VectorCopy(ent->r.currentOrigin, dest);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 2127
;2127:	}
LABELV $982
line 2128
;2128:	trap_Trace(&trace, start, NULL, NULL, dest, monster->s.number, MASK_SHOT);
ADDRLP4 12
ARGP4
ADDRLP4 80
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 2129
;2129:	if (trace.entityNum == ent->s.number || trace.fraction >= 1) return qtrue;
ADDRLP4 12+52
INDIRI4
ADDRFP4 0
INDIRP4
INDIRI4
EQI4 $987
ADDRLP4 12+8
INDIRF4
CNSTF4 1065353216
LTF4 $983
LABELV $987
CNSTI4 1
RETI4
ADDRGP4 $976
JUMPV
LABELV $983
line 2131
;2130:
;2131:	if (ps) {
ADDRLP4 116
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $988
line 2132
;2132:		VectorCopy(dest, end);
ADDRLP4 68
ADDRLP4 0
INDIRB
ASGNB 12
line 2133
;2133:		end[2] += ps->viewheight;
ADDRLP4 68+8
ADDRLP4 68+8
INDIRF4
ADDRLP4 116
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 2134
;2134:		trap_Trace(&trace, start, NULL, NULL, end, monster->s.number, MASK_SHOT);
ADDRLP4 12
ARGP4
ADDRLP4 80
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 68
ARGP4
ADDRFP4 4
INDIRP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 2135
;2135:		if (trace.entityNum == ent->s.number || trace.fraction >= 1) return qtrue;
ADDRLP4 12+52
INDIRI4
ADDRFP4 0
INDIRP4
INDIRI4
EQI4 $995
ADDRLP4 12+8
INDIRF4
CNSTF4 1065353216
LTF4 $991
LABELV $995
CNSTI4 1
RETI4
ADDRGP4 $976
JUMPV
LABELV $991
line 2136
;2136:	}
LABELV $988
line 2138
;2137:
;2138:	VectorSubtract(dest, start, dir);
ADDRLP4 104
ADDRLP4 0
INDIRF4
ADDRLP4 80
INDIRF4
SUBF4
ASGNF4
ADDRLP4 104+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 80+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 104+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 80+8
INDIRF4
SUBF4
ASGNF4
line 2139
;2139:	VectorNormalize(dir);
ADDRLP4 104
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 2140
;2140:	CrossProduct(dir, up, right);
ADDRLP4 104
ARGP4
ADDRGP4 $977
ARGP4
ADDRLP4 92
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 2141
;2141:	VectorMA(dest, 15, right, end);
ADDRLP4 68
ADDRLP4 0
INDIRF4
ADDRLP4 92
INDIRF4
CNSTF4 1097859072
MULF4
ADDF4
ASGNF4
ADDRLP4 68+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 92+4
INDIRF4
CNSTF4 1097859072
MULF4
ADDF4
ASGNF4
ADDRLP4 68+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 92+8
INDIRF4
CNSTF4 1097859072
MULF4
ADDF4
ASGNF4
line 2142
;2142:	trap_Trace(&trace, start, NULL, NULL, end, monster->s.number, MASK_SHOT);
ADDRLP4 12
ARGP4
ADDRLP4 80
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 68
ARGP4
ADDRFP4 4
INDIRP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 2143
;2143:	if (trace.entityNum == ent->s.number || trace.fraction >= 1) return qtrue;
ADDRLP4 12+52
INDIRI4
ADDRFP4 0
INDIRP4
INDIRI4
EQI4 $1012
ADDRLP4 12+8
INDIRF4
CNSTF4 1065353216
LTF4 $1008
LABELV $1012
CNSTI4 1
RETI4
ADDRGP4 $976
JUMPV
LABELV $1008
line 2145
;2144:
;2145:	VectorMA(dest, -15, right, end);
ADDRLP4 68
ADDRLP4 0
INDIRF4
ADDRLP4 92
INDIRF4
CNSTF4 3245342720
MULF4
ADDF4
ASGNF4
ADDRLP4 68+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 92+4
INDIRF4
CNSTF4 3245342720
MULF4
ADDF4
ASGNF4
ADDRLP4 68+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 92+8
INDIRF4
CNSTF4 3245342720
MULF4
ADDF4
ASGNF4
line 2146
;2146:	trap_Trace(&trace, start, NULL, NULL, end, monster->s.number, MASK_SHOT);
ADDRLP4 12
ARGP4
ADDRLP4 80
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 68
ARGP4
ADDRFP4 4
INDIRP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 2147
;2147:	if (trace.entityNum == ent->s.number || trace.fraction >= 1) return qtrue;
ADDRLP4 12+52
INDIRI4
ADDRFP4 0
INDIRP4
INDIRI4
EQI4 $1023
ADDRLP4 12+8
INDIRF4
CNSTF4 1065353216
LTF4 $1019
LABELV $1023
CNSTI4 1
RETI4
ADDRGP4 $976
JUMPV
LABELV $1019
line 2149
;2148:
;2149:	return qfalse;
CNSTI4 0
RETI4
LABELV $976
endproc EntityVisibleToMonster 124 28
proc EntityInViewOfMonster 48 8
line 2159
;2150:}
;2151:#endif
;2152:
;2153:/*
;2154:===============
;2155:JUHOX: EntityInViewOfMonster
;2156:===============
;2157:*/
;2158:#if MONSTER_MODE
;2159:static qboolean EntityInViewOfMonster(const gentity_t* ent, const gmonster_t* mi) {
line 2163
;2160:	vec3_t dir;
;2161:	vec3_t angles;
;2162:
;2163:	VectorSubtract(ent->s.pos.trBase, mi->ps.origin, dir);
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 24
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 24
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2164
;2164:	vectoangles(dir, angles);
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2165
;2165:	if (fabs(AngleSubtract(angles[YAW], mi->ps.viewangles[YAW])) > 60) return qfalse;
ADDRLP4 12+4
INDIRF4
ARGF4
ADDRFP4 4
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
ADDRLP4 32
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 36
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 36
INDIRF4
CNSTF4 1114636288
LEF4 $1027
CNSTI4 0
RETI4
ADDRGP4 $1024
JUMPV
LABELV $1027
line 2166
;2166:	if (fabs(AngleSubtract(angles[PITCH], mi->ps.viewangles[PITCH])) > 45) return qfalse;
ADDRLP4 12
INDIRF4
ARGF4
ADDRFP4 4
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 44
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 44
INDIRF4
CNSTF4 1110704128
LEF4 $1030
CNSTI4 0
RETI4
ADDRGP4 $1024
JUMPV
LABELV $1030
line 2167
;2167:	return qtrue;
CNSTI4 1
RETI4
LABELV $1024
endproc EntityInViewOfMonster 48 8
proc EntityEasilyVisibleToMonsters 0 0
line 2177
;2168:}
;2169:#endif
;2170:
;2171:/*
;2172:===============
;2173:JUHOX: EntityEasilyVisibleToMonsters
;2174:===============
;2175:*/
;2176:#if MONSTER_MODE
;2177:static qboolean EntityEasilyVisibleToMonsters(const gentity_t* ent) {
line 2178
;2178:	if (!ent->client) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1033
CNSTI4 1
RETI4
ADDRGP4 $1032
JUMPV
LABELV $1033
line 2179
;2179:	if (!ent->client->ps.powerups[PW_INVIS]) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 328
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1035
CNSTI4 1
RETI4
ADDRGP4 $1032
JUMPV
LABELV $1035
line 2180
;2180:	if (ent->client->ps.powerups[PW_BATTLESUIT]) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 320
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1037
CNSTI4 1
RETI4
ADDRGP4 $1032
JUMPV
LABELV $1037
line 2181
;2181:	if (ent->client->ps.powerups[PW_REDFLAG]) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1039
CNSTI4 1
RETI4
ADDRGP4 $1032
JUMPV
LABELV $1039
line 2182
;2182:	if (ent->client->ps.powerups[PW_BLUEFLAG]) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1041
CNSTI4 1
RETI4
ADDRGP4 $1032
JUMPV
LABELV $1041
line 2183
;2183:	return qfalse;
CNSTI4 0
RETI4
LABELV $1032
endproc EntityEasilyVisibleToMonsters 0 0
proc CheckMonsterEnemy 48 8
line 2193
;2184:}
;2185:#endif
;2186:
;2187:/*
;2188:===============
;2189:JUHOX: CheckMonsterEnemy
;2190:===============
;2191:*/
;2192:#if MONSTER_MODE
;2193:static void CheckMonsterEnemy(gentity_t* monster, localseed_t* masterseed) {
line 2198
;2194:	gentity_t* enemy;
;2195:	localseed_t seed;
;2196:	playerState_t* ps;
;2197:
;2198:	if (!monster->monster) return;
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1044
ADDRGP4 $1043
JUMPV
LABELV $1044
line 2199
;2199:	if (level.intermissiontime) {
ADDRGP4 level+9144
INDIRI4
CNSTI4 0
EQI4 $1046
line 2200
;2200:		monster->monster->enemy = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 556
ADDP4
CNSTP4 0
ASGNP4
line 2201
;2201:		return;
ADDRGP4 $1043
JUMPV
LABELV $1046
line 2204
;2202:	}
;2203:
;2204:	DeriveLocalSeed(masterseed, &seed);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 DeriveLocalSeed
CALLV
pop
line 2206
;2205:
;2206:	enemy = monster->monster->enemy;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 556
ADDP4
INDIRP4
ASGNP4
line 2207
;2207:	if (!enemy) return;
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1049
ADDRGP4 $1043
JUMPV
LABELV $1049
line 2209
;2208:
;2209:	monster->monster->enemy = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 556
ADDP4
CNSTP4 0
ASGNP4
line 2211
;2210:
;2211:	if (!enemy->inuse) return;
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1051
ADDRGP4 $1043
JUMPV
LABELV $1051
line 2212
;2212:	ps = G_GetEntityPlayerState(enemy);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
ASGNP4
line 2213
;2213:	if (!ps) return;
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1053
ADDRGP4 $1043
JUMPV
LABELV $1053
line 2214
;2214:	if (ps->stats[STAT_HEALTH] <= 0) return;
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $1055
ADDRGP4 $1043
JUMPV
LABELV $1055
line 2215
;2215:	if (ps->powerups[PW_SHIELD]) return;
ADDRLP4 4
INDIRP4
CNSTI4 356
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1057
ADDRGP4 $1043
JUMPV
LABELV $1057
line 2216
;2216:	if (level.endPhase > 0 && monster->monster->nextEnemyVisCheck <= level.time) return;
ADDRGP4 level+23012
INDIRI4
CNSTI4 0
LEI4 $1059
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 592
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
GTI4 $1059
ADDRGP4 $1043
JUMPV
LABELV $1059
line 2219
;2217:
;2218:	if (
;2219:		monster->monster->lastHurtEntity != enemy ||
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 640
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 0
INDIRP4
CVPU4 4
NEU4 $1066
ADDRLP4 28
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 644
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 3000
SUBI4
GEI4 $1063
LABELV $1066
line 2221
;2220:		monster->monster->lastHurtTime < level.time - 3000
;2221:	) {
line 2222
;2222:		if ((enemy->s.eFlags ^ monster->monster->oldEnemyEFlags) & EF_TELEPORT_BIT) {
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 568
ADDP4
INDIRI4
BXORI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $1067
line 2223
;2223:			monster->monster->nextEnemyVisCheck = level.time + 1000 + LocallySeededRandom(&seed) % 1000;
ADDRLP4 8
ARGP4
ADDRLP4 32
ADDRGP4 LocallySeededRandom
CALLU4
ASGNU4
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 592
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDI4
CVIU4 4
ADDRLP4 32
INDIRU4
CNSTU4 1000
MODU4
ADDU4
CVUI4 4
ASGNI4
line 2224
;2224:		}
LABELV $1067
line 2226
;2225:
;2226:		if (monster->monster->nextEnemyVisCheck <= level.time) {
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 592
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
GTI4 $1070
line 2227
;2227:			monster->monster->nextEnemyVisCheck = level.time + 1000 + LocallySeededRandom(&seed) % 1000;
ADDRLP4 8
ARGP4
ADDRLP4 32
ADDRGP4 LocallySeededRandom
CALLU4
ASGNU4
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 592
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDI4
CVIU4 4
ADDRLP4 32
INDIRU4
CNSTU4 1000
MODU4
ADDU4
CVUI4 4
ASGNI4
line 2230
;2228:
;2229:			if (
;2230:				monster->monster->type != MT_titan &&
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 476
ADDP4
INDIRI4
CNSTI4 2
EQI4 $1074
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 EntityEasilyVisibleToMonsters
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $1074
line 2232
;2231:				!EntityEasilyVisibleToMonsters(enemy)
;2232:			) {
line 2235
;2233:				vec_t distSqr;
;2234:
;2235:				distSqr = DistanceSquared(ps->origin, monster->monster->ps.origin);
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 28
ADDP4
ARGP4
ADDRLP4 44
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 40
ADDRLP4 44
INDIRF4
ASGNF4
line 2236
;2236:				if (distSqr > 1000.0 * 1000.0) return;
ADDRLP4 40
INDIRF4
CNSTF4 1232348160
LEF4 $1076
ADDRGP4 $1043
JUMPV
LABELV $1076
line 2237
;2237:			}
LABELV $1074
line 2239
;2238:
;2239:			if (monster->monster->type == MT_guard) {
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 476
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1078
line 2240
;2240:				if (!monster->monster->enemyWasInView) return;
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 580
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1079
ADDRGP4 $1043
JUMPV
line 2241
;2241:			}
LABELV $1078
line 2243
;2242:			else if (
;2243:				!EntityVisibleToMonster(enemy, monster) ||
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 EntityVisibleToMonster
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $1085
ADDRGP4 level+32
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
CNSTI4 5000
ADDI4
LEI4 $1082
LABELV $1085
line 2245
;2244:				level.time > monster->monster->lastEnemyHitTime + 5000
;2245:			) {
line 2246
;2246:				return;
ADDRGP4 $1043
JUMPV
LABELV $1082
LABELV $1079
line 2248
;2247:			}
;2248:		}
LABELV $1070
line 2249
;2249:	}
LABELV $1063
line 2251
;2250:
;2251:	monster->monster->enemy = enemy;
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 556
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 2252
;2252:}
LABELV $1043
endproc CheckMonsterEnemy 48 8
proc SetMonsterEnemy 12 4
line 2261
;2253:#endif
;2254:
;2255:/*
;2256:===============
;2257:JUHOX: SetMonsterEnemy
;2258:===============
;2259:*/
;2260:#if MONSTER_MODE
;2261:static void SetMonsterEnemy(gmonster_t* monster, gentity_t* enemy, localseed_t* seed) {
line 2262
;2262:	monster->enemy = enemy;
ADDRFP4 0
INDIRP4
CNSTI4 556
ADDP4
ADDRFP4 4
INDIRP4
ASGNP4
line 2263
;2263:	monster->nextEnemyVisCheck = level.time + 1000 + (LocallySeededRandom(seed) % 1000);
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 LocallySeededRandom
CALLU4
ASGNU4
ADDRFP4 0
INDIRP4
CNSTI4 592
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDI4
CVIU4 4
ADDRLP4 0
INDIRU4
CNSTU4 1000
MODU4
ADDU4
CVUI4 4
ASGNI4
line 2264
;2264:	monster->lastEnemyHitTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 564
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 2265
;2265:	monster->enemyFoundTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 560
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 2266
;2266:	monster->oldEFlags = monster->ps.eFlags;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 572
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
ASGNI4
line 2267
;2267:	monster->oldEnemyEFlags = G_GetEntityPlayerState(enemy)->eFlags;
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 568
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
ASGNI4
line 2268
;2268:	monster->freezeView = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
CNSTI4 0
ASGNI4
line 2269
;2269:	monster->enemyWasInView = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 580
ADDP4
CNSTI4 1
ASGNI4
line 2270
;2270:	monster->nextDodgeTime = level.time + 500;
ADDRFP4 0
INDIRP4
CNSTI4 584
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 2271
;2271:	monster->dodgeDir = 0;
ADDRFP4 0
INDIRP4
CNSTI4 588
ADDP4
CNSTI4 0
ASGNI4
line 2272
;2272:}
LABELV $1086
endproc SetMonsterEnemy 12 4
proc SearchMonsterEnemy 4240 12
line 2281
;2273:#endif
;2274:
;2275:/*
;2276:===============
;2277:JUHOX: SearchMonsterEnemy
;2278:===============
;2279:*/
;2280:#if MONSTER_MODE
;2281:static void SearchMonsterEnemy(gentity_t* monster, localseed_t* masterseed) {
line 2290
;2282:	gmonster_t* mi;
;2283:	int i;
;2284:	int n;
;2285:	int clientBag[MAX_GENTITIES];
;2286:	localseed_t seed;
;2287:	gentity_t* nearestEnemy;
;2288:	float minDistanceSqr;
;2289:
;2290:	if (level.intermissiontime) return;
ADDRGP4 level+9144
INDIRI4
CNSTI4 0
EQI4 $1092
ADDRGP4 $1091
JUMPV
LABELV $1092
line 2291
;2291:	if (level.endPhase > 0) return;
ADDRGP4 level+23012
INDIRI4
CNSTI4 0
LEI4 $1095
ADDRGP4 $1091
JUMPV
LABELV $1095
line 2293
;2292:
;2293:	mi = monster->monster;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
ASGNP4
line 2294
;2294:	if (!mi) return;
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1098
ADDRGP4 $1091
JUMPV
LABELV $1098
line 2296
;2295:
;2296:	DeriveLocalSeed(masterseed, &seed);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4104
ARGP4
ADDRGP4 DeriveLocalSeed
CALLV
pop
line 2299
;2297:
;2298:	if (
;2299:		mi->enemy &&
ADDRLP4 0
INDIRP4
CNSTI4 556
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1100
ADDRLP4 0
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 2000
SUBI4
GTI4 $1104
ADDRLP4 0
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 5000
SUBI4
LEI4 $1100
LABELV $1104
line 2304
;2300:		(
;2301:			mi->lastEnemyHitTime > level.time - 2000 ||
;2302:			mi->enemyFoundTime > level.time - 5000
;2303:		)
;2304:	) {
line 2305
;2305:		return;
ADDRGP4 $1091
JUMPV
LABELV $1100
line 2309
;2306:	}
;2307:
;2308:	if (
;2309:		mi->lastHurtEntity &&
ADDRLP4 0
INDIRP4
CNSTI4 640
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1105
ADDRLP4 0
INDIRP4
CNSTI4 644
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
SUBI4
LEI4 $1105
ADDRLP4 0
INDIRP4
CNSTI4 640
ADDP4
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1105
ADDRLP4 0
INDIRP4
CNSTI4 640
ADDP4
INDIRP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 484
ADDP4
INDIRI4
EQI4 $1105
ADDRLP4 0
INDIRP4
CNSTI4 640
ADDP4
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
EQU4 $1105
line 2314
;2310:		mi->lastHurtTime > level.time - 1000 &&
;2311:		mi->lastHurtEntity->health > 0 &&
;2312:		mi->lastHurtEntity->s.number != mi->owner &&
;2313:		mi->lastHurtEntity != monster
;2314:	) {
line 2317
;2315:		playerState_t* ps;
;2316:
;2317:		ps = G_GetEntityPlayerState(mi->lastHurtEntity);
ADDRLP4 0
INDIRP4
CNSTI4 640
ADDP4
INDIRP4
ARGP4
ADDRLP4 4144
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 4140
ADDRLP4 4144
INDIRP4
ASGNP4
line 2319
;2318:		if (
;2319:			g_gametype.integer < GT_TEAM ||
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $1114
ADDRLP4 4148
ADDRLP4 4140
INDIRP4
ASGNP4
ADDRLP4 4148
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1114
ADDRLP4 4148
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
NEI4 $1114
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
LTI4 $1091
ADDRLP4 0
INDIRP4
CNSTI4 640
ADDP4
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1091
ADDRLP4 0
INDIRP4
CNSTI4 640
ADDP4
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 476
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 476
ADDP4
INDIRI4
GTI4 $1091
LABELV $1114
line 2327
;2320:			!ps ||
;2321:			ps->persistant[PERS_TEAM] != mi->ps.persistant[PERS_TEAM] ||
;2322:			(
;2323:				g_gametype.integer >= GT_STU &&
;2324:				mi->lastHurtEntity->monster &&
;2325:				mi->lastHurtEntity->monster->type <= mi->type
;2326:			)
;2327:		) {
line 2328
;2328:			SetMonsterEnemy(mi, mi->lastHurtEntity, &seed);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 640
ADDP4
INDIRP4
ARGP4
ADDRLP4 4104
ARGP4
ADDRGP4 SetMonsterEnemy
CALLV
pop
line 2329
;2329:		}
line 2330
;2330:		return;
ADDRGP4 $1091
JUMPV
LABELV $1105
line 2333
;2331:	}
;2332:
;2333:	if (mi->nextEnemySearch > level.time) return;
ADDRLP4 0
INDIRP4
CNSTI4 604
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $1115
ADDRGP4 $1091
JUMPV
LABELV $1115
line 2335
;2334:	//mi->nextEnemySearch = level.time + 1000 + (LocallySeededRandom(&seed) % 1000);
;2335:	mi->nextEnemySearch = level.time + 250 + (LocallySeededRandom(&seed) % 250);
ADDRLP4 4104
ARGP4
ADDRLP4 4140
ADDRGP4 LocallySeededRandom
CALLU4
ASGNU4
ADDRLP4 0
INDIRP4
CNSTI4 604
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 250
ADDI4
CVIU4 4
ADDRLP4 4140
INDIRU4
CNSTU4 250
MODU4
ADDU4
CVUI4 4
ASGNI4
line 2337
;2336:
;2337:	n = level.maxclients;
ADDRLP4 4120
ADDRGP4 level+24
INDIRI4
ASGNI4
line 2339
;2338:	if (
;2339:		mi->type == MT_titan ||
ADDRLP4 0
INDIRP4
CNSTI4 476
ADDP4
INDIRI4
CNSTI4 2
EQI4 $1124
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
GEI4 $1120
ADDRGP4 g_monsterLauncher+12
INDIRI4
CNSTI4 0
EQI4 $1120
LABELV $1124
line 2344
;2340:		(
;2341:			g_gametype.integer < GT_STU &&
;2342:			g_monsterLauncher.integer
;2343:		)
;2344:	) {
line 2345
;2345:		n = level.num_entities;
ADDRLP4 4120
ADDRGP4 level+12
INDIRI4
ASGNI4
line 2346
;2346:	}
LABELV $1120
line 2347
;2347:	for (i = 0; i < n; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $1129
JUMPV
LABELV $1126
line 2348
;2348:		clientBag[i] = i;
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 2349
;2349:	}
LABELV $1127
line 2347
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1129
ADDRLP4 4
INDIRI4
ADDRLP4 4120
INDIRI4
LTI4 $1126
line 2351
;2350:
;2351:	nearestEnemy = NULL;
ADDRLP4 4128
CNSTP4 0
ASGNP4
line 2352
;2352:	minDistanceSqr = 1e12;
ADDRLP4 4124
CNSTF4 1399379109
ASGNF4
ADDRGP4 $1131
JUMPV
LABELV $1130
line 2353
;2353:	while (i > 0) {
line 2361
;2354:		int j;
;2355:		gentity_t* ent;
;2356:		playerState_t* ps;
;2357:		vec3_t dir;
;2358:		vec_t distanceSqr;
;2359:		vec3_t angles;
;2360:
;2361:		j = LocallySeededRandom(&seed) % i;
ADDRLP4 4104
ARGP4
ADDRLP4 4184
ADDRGP4 LocallySeededRandom
CALLU4
ASGNU4
ADDRLP4 4168
ADDRLP4 4184
INDIRU4
ADDRLP4 4
INDIRI4
CVIU4 4
MODU4
CVUI4 4
ASGNI4
line 2362
;2362:		ent = &g_entities[clientBag[j]];
ADDRLP4 4144
ADDRLP4 4168
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 2363
;2363:		clientBag[j] = clientBag[--i];
ADDRLP4 4188
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRLP4 4
ADDRLP4 4188
INDIRI4
ASGNI4
ADDRLP4 4168
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
ADDRLP4 4188
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
INDIRI4
ASGNI4
line 2365
;2364:
;2365:		if (!ent->inuse) continue;
ADDRLP4 4144
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1133
ADDRGP4 $1131
JUMPV
LABELV $1133
line 2366
;2366:		ps = G_GetEntityPlayerState(ent);
ADDRLP4 4144
INDIRP4
ARGP4
ADDRLP4 4192
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 4148
ADDRLP4 4192
INDIRP4
ASGNP4
line 2367
;2367:		if (!ps) continue;
ADDRLP4 4148
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1135
ADDRGP4 $1131
JUMPV
LABELV $1135
line 2368
;2368:		if (ps->stats[STAT_HEALTH] <= 0) continue;
ADDRLP4 4148
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $1137
ADDRGP4 $1131
JUMPV
LABELV $1137
line 2369
;2369:		if (ps->persistant[PERS_TEAM] == TEAM_SPECTATOR) continue;
ADDRLP4 4148
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1139
ADDRGP4 $1131
JUMPV
LABELV $1139
line 2370
;2370:		if (G_IsFriendlyMonster(ent, monster)) continue;
ADDRLP4 4144
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4196
ADDRGP4 G_IsFriendlyMonster
CALLI4
ASGNI4
ADDRLP4 4196
INDIRI4
CNSTI4 0
EQI4 $1141
ADDRGP4 $1131
JUMPV
LABELV $1141
line 2371
;2371:		if (!G_CanBeDamaged(ent)) continue;
ADDRLP4 4144
INDIRP4
ARGP4
ADDRLP4 4200
ADDRGP4 G_CanBeDamaged
CALLI4
ASGNI4
ADDRLP4 4200
INDIRI4
CNSTI4 0
NEI4 $1143
ADDRGP4 $1131
JUMPV
LABELV $1143
line 2372
;2372:		if (ps->powerups[PW_SHIELD]) continue;
ADDRLP4 4148
INDIRP4
CNSTI4 356
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1145
ADDRGP4 $1131
JUMPV
LABELV $1145
line 2373
;2373:		if (ent == monster) continue;
ADDRLP4 4144
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
NEU4 $1147
ADDRGP4 $1131
JUMPV
LABELV $1147
line 2374
;2374:		if (ent == mi->enemy) continue;
ADDRLP4 4144
INDIRP4
CVPU4 4
ADDRLP4 0
INDIRP4
CNSTI4 556
ADDP4
INDIRP4
CVPU4 4
NEU4 $1149
ADDRGP4 $1131
JUMPV
LABELV $1149
line 2376
;2375:
;2376:		VectorSubtract(ps->origin, mi->ps.origin, dir);
ADDRLP4 4152
ADDRLP4 4148
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4152+4
ADDRLP4 4148
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4152+8
ADDRLP4 4148
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2377
;2377:		distanceSqr = VectorLengthSquared(dir);
ADDRLP4 4152
ARGP4
ADDRLP4 4212
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 4164
ADDRLP4 4212
INDIRF4
ASGNF4
line 2378
;2378:		if (distanceSqr > Square(3000.0f)) continue;
ADDRLP4 4164
INDIRF4
CNSTF4 1258902592
LEF4 $1153
ADDRGP4 $1131
JUMPV
LABELV $1153
line 2380
;2379:		if (
;2380:			mi->type != MT_titan &&
ADDRLP4 0
INDIRP4
CNSTI4 476
ADDP4
INDIRI4
CNSTI4 2
EQI4 $1155
ADDRLP4 4144
INDIRP4
ARGP4
ADDRLP4 4216
ADDRGP4 EntityEasilyVisibleToMonsters
CALLI4
ASGNI4
ADDRLP4 4216
INDIRI4
CNSTI4 0
NEI4 $1155
line 2382
;2381:			!EntityEasilyVisibleToMonsters(ent)
;2382:		) {
line 2383
;2383:			if (distanceSqr > Square(600.0f)) continue;
ADDRLP4 4164
INDIRF4
CNSTF4 1219479552
LEF4 $1157
ADDRGP4 $1131
JUMPV
LABELV $1157
line 2384
;2384:			if (!EntityAudible(ent) && distanceSqr > Square(200.0f)) continue;
ADDRLP4 4144
INDIRP4
ARGP4
ADDRLP4 4220
ADDRGP4 EntityAudible
CALLI4
ASGNI4
ADDRLP4 4220
INDIRI4
CNSTI4 0
NEI4 $1159
ADDRLP4 4164
INDIRF4
CNSTF4 1193033728
LEF4 $1159
ADDRGP4 $1131
JUMPV
LABELV $1159
line 2385
;2385:		}
LABELV $1155
line 2387
;2386:
;2387:		vectoangles(dir, angles);
ADDRLP4 4152
ARGP4
ADDRLP4 4172
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2388
;2388:		if (fabs(AngleSubtract(angles[YAW], mi->ps.viewangles[YAW])) > 60.0f) continue;
ADDRLP4 4172+4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
ADDRLP4 4220
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 4220
INDIRF4
ARGF4
ADDRLP4 4224
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 4224
INDIRF4
CNSTF4 1114636288
LEF4 $1161
ADDRGP4 $1131
JUMPV
LABELV $1161
line 2389
;2389:		if (fabs(AngleSubtract(angles[PITCH], mi->ps.viewangles[PITCH])) > 45.0f) continue;
ADDRLP4 4172
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRLP4 4228
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 4228
INDIRF4
ARGF4
ADDRLP4 4232
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 4232
INDIRF4
CNSTF4 1110704128
LEF4 $1164
ADDRGP4 $1131
JUMPV
LABELV $1164
line 2391
;2390:
;2391:		if (!EntityVisibleToMonster(ent, monster)) continue;
ADDRLP4 4144
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4236
ADDRGP4 EntityVisibleToMonster
CALLI4
ASGNI4
ADDRLP4 4236
INDIRI4
CNSTI4 0
NEI4 $1166
ADDRGP4 $1131
JUMPV
LABELV $1166
line 2393
;2392:
;2393:		if (mi->type == MT_titan) {
ADDRLP4 0
INDIRP4
CNSTI4 476
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1168
line 2394
;2394:			if (distanceSqr < minDistanceSqr) {
ADDRLP4 4164
INDIRF4
ADDRLP4 4124
INDIRF4
GEF4 $1169
line 2395
;2395:				minDistanceSqr = distanceSqr;
ADDRLP4 4124
ADDRLP4 4164
INDIRF4
ASGNF4
line 2396
;2396:				nearestEnemy = ent;
ADDRLP4 4128
ADDRLP4 4144
INDIRP4
ASGNP4
line 2397
;2397:			}
line 2398
;2398:		}
ADDRGP4 $1169
JUMPV
LABELV $1168
line 2399
;2399:		else {
line 2400
;2400:			SetMonsterEnemy(mi, ent, &seed);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4144
INDIRP4
ARGP4
ADDRLP4 4104
ARGP4
ADDRGP4 SetMonsterEnemy
CALLV
pop
line 2401
;2401:			return;
ADDRGP4 $1091
JUMPV
LABELV $1169
line 2403
;2402:		}
;2403:	}
LABELV $1131
line 2353
ADDRLP4 4
INDIRI4
CNSTI4 0
GTI4 $1130
line 2405
;2404:
;2405:	if (mi->type == MT_titan && nearestEnemy) {
ADDRLP4 0
INDIRP4
CNSTI4 476
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1172
ADDRLP4 4128
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1172
line 2406
;2406:		SetMonsterEnemy(mi, nearestEnemy, &seed);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4128
INDIRP4
ARGP4
ADDRLP4 4104
ARGP4
ADDRGP4 SetMonsterEnemy
CALLV
pop
line 2407
;2407:		return;
ADDRGP4 $1091
JUMPV
LABELV $1172
line 2411
;2408:	}
;2409:
;2410:	if (
;2411:		g_gametype.integer >= GT_STU &&
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
LTI4 $1174
ADDRLP4 0
INDIRP4
CNSTI4 652
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1174
ADDRLP4 0
INDIRP4
CNSTI4 656
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 500
SUBI4
LEI4 $1174
ADDRLP4 0
INDIRP4
CNSTI4 476
ADDP4
INDIRI4
CNSTI4 2
EQI4 $1178
ADDRLP4 4148
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 4148
INDIRI4
CNSTI4 5
MODI4
CNSTI4 0
NEI4 $1174
LABELV $1178
line 2418
;2412:		mi->avoidPlayer &&
;2413:		mi->startAvoidPlayerTime > level.time - 500 &&
;2414:		(
;2415:			mi->type == MT_titan ||
;2416:			rand() % 5 == 0
;2417:		)
;2418:	) {
line 2421
;2419:		gentity_t* troublemaker;
;2420:
;2421:		troublemaker = &g_entities[mi->avoidPlayer->clientNum];
ADDRLP4 4152
ADDRLP4 0
INDIRP4
CNSTI4 652
ADDP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 2423
;2422:		if (
;2423:			troublemaker->monster &&
ADDRLP4 4156
ADDRLP4 4152
INDIRP4
ASGNP4
ADDRLP4 4156
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1179
ADDRLP4 4156
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 476
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1179
line 2425
;2424:			troublemaker->monster->type == MT_predator
;2425:		) {
line 2429
;2426:			vec3_t dir;
;2427:			vec3_t angles;
;2428:
;2429:			VectorSubtract(troublemaker->monster->ps.origin, mi->ps.origin, dir);
ADDRLP4 4184
ADDRLP4 4152
INDIRP4
ASGNP4
ADDRLP4 4160
ADDRLP4 4184
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4160+4
ADDRLP4 4184
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4160+8
ADDRLP4 4152
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2430
;2430:			vectoangles(dir, angles);
ADDRLP4 4160
ARGP4
ADDRLP4 4172
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2432
;2431:			if (
;2432:				fabs(AngleSubtract(angles[YAW], mi->ps.viewangles[YAW])) < 30.0f &&
ADDRLP4 4172+4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
ADDRLP4 4192
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 4192
INDIRF4
ARGF4
ADDRLP4 4196
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 4196
INDIRF4
CNSTF4 1106247680
GEF4 $1183
ADDRLP4 4172
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRLP4 4200
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 4200
INDIRF4
ARGF4
ADDRLP4 4204
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 4204
INDIRF4
CNSTF4 1101004800
GEF4 $1183
line 2434
;2433:				fabs(AngleSubtract(angles[PITCH], mi->ps.viewangles[PITCH])) < 20.0f
;2434:			) {
line 2435
;2435:				SetMonsterEnemy(mi, troublemaker, &seed);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4152
INDIRP4
ARGP4
ADDRLP4 4104
ARGP4
ADDRGP4 SetMonsterEnemy
CALLV
pop
line 2436
;2436:				mi->lastHurtEntity = troublemaker;
ADDRLP4 0
INDIRP4
CNSTI4 640
ADDP4
ADDRLP4 4152
INDIRP4
ASGNP4
line 2437
;2437:				mi->lastHurtTime = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 644
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 2438
;2438:			}
LABELV $1183
line 2439
;2439:		}
LABELV $1179
line 2440
;2440:	}
LABELV $1174
line 2441
;2441:}
LABELV $1091
endproc SearchMonsterEnemy 4240 12
proc ScanForMonsterEnemy 8308 16
line 2454
;2442:#endif
;2443:
;2444:/*
;2445:===============
;2446:JUHOX: ScanForMonsterEnemy
;2447:
;2448:used in hibernation mode only
;2449:returns qtrue if hibernation should be quit
;2450:===============
;2451:*/
;2452:#if MONSTER_MODE
;2453:#define MONSTER_HIBERNATION_SCAN_RADIUS 300.0f
;2454:static qboolean ScanForMonsterEnemy(gentity_t* monster, localseed_t* masterseed) {
line 2463
;2455:	gmonster_t* mi;
;2456:	int i;
;2457:	int n;
;2458:	vec3_t mins, maxs;
;2459:	int nearEntities[MAX_GENTITIES];
;2460:	int bag[MAX_GENTITIES];
;2461:	localseed_t seed;
;2462:
;2463:	if (level.intermissiontime) return qfalse;
ADDRGP4 level+9144
INDIRI4
CNSTI4 0
EQI4 $1188
CNSTI4 0
RETI4
ADDRGP4 $1187
JUMPV
LABELV $1188
line 2464
;2464:	if (level.endPhase > 0) return qfalse;
ADDRGP4 level+23012
INDIRI4
CNSTI4 0
LEI4 $1191
CNSTI4 0
RETI4
ADDRGP4 $1187
JUMPV
LABELV $1191
line 2466
;2465:
;2466:	mi = monster->monster;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
ASGNP4
line 2467
;2467:	if (!mi) return qfalse;
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1194
CNSTI4 0
RETI4
ADDRGP4 $1187
JUMPV
LABELV $1194
line 2469
;2468:
;2469:	DeriveLocalSeed(masterseed, &seed);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4104
ARGP4
ADDRGP4 DeriveLocalSeed
CALLV
pop
line 2472
;2470:
;2471:	if (
;2472:		mi->lastHurtEntity &&
ADDRLP4 4
INDIRP4
CNSTI4 640
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1196
ADDRLP4 4
INDIRP4
CNSTI4 644
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
SUBI4
LEI4 $1196
line 2474
;2473:		mi->lastHurtTime > level.time - 1000
;2474:	) {
line 2475
;2475:		mi->nextEnemySearch = level.time + 1000;
ADDRLP4 4
INDIRP4
CNSTI4 604
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 2476
;2476:		SearchMonsterEnemy(monster, &seed);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4104
ARGP4
ADDRGP4 SearchMonsterEnemy
CALLV
pop
line 2477
;2477:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1187
JUMPV
LABELV $1196
line 2480
;2478:	}
;2479:
;2480:	if (mi->ps.powerups[PW_CHARGE]) {
ADDRLP4 4
INDIRP4
CNSTI4 360
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1200
line 2481
;2481:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1187
JUMPV
LABELV $1200
line 2484
;2482:	}
;2483:
;2484:	if (mi->hibernationBrood > 0) {
ADDRLP4 4
INDIRP4
CNSTI4 688
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1202
line 2485
;2485:		if (mi->nextEnemySearch > level.time) return qfalse;
ADDRLP4 4
INDIRP4
CNSTI4 604
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $1204
CNSTI4 0
RETI4
ADDRGP4 $1187
JUMPV
LABELV $1204
line 2486
;2486:		mi->nextEnemySearch = level.time + 1000 + (LocallySeededRandom(&seed) % 1000);
ADDRLP4 4104
ARGP4
ADDRLP4 8248
ADDRGP4 LocallySeededRandom
CALLU4
ASGNU4
ADDRLP4 4
INDIRP4
CNSTI4 604
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDI4
CVIU4 4
ADDRLP4 8248
INDIRU4
CNSTU4 1000
MODU4
ADDU4
CVUI4 4
ASGNI4
line 2488
;2487:
;2488:		VectorCopy(mi->ps.origin, mins);
ADDRLP4 8220
ADDRLP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRB
ASGNB 12
line 2489
;2489:		VectorCopy(mi->ps.origin, maxs);
ADDRLP4 8232
ADDRLP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRB
ASGNB 12
line 2490
;2490:		mins[0] -= MONSTER_HIBERNATION_SCAN_RADIUS;
ADDRLP4 8220
ADDRLP4 8220
INDIRF4
CNSTF4 1133903872
SUBF4
ASGNF4
line 2491
;2491:		mins[1] -= MONSTER_HIBERNATION_SCAN_RADIUS;
ADDRLP4 8220+4
ADDRLP4 8220+4
INDIRF4
CNSTF4 1133903872
SUBF4
ASGNF4
line 2492
;2492:		mins[2] -= 2000;
ADDRLP4 8220+8
ADDRLP4 8220+8
INDIRF4
CNSTF4 1157234688
SUBF4
ASGNF4
line 2493
;2493:		maxs[0] += MONSTER_HIBERNATION_SCAN_RADIUS;
ADDRLP4 8232
ADDRLP4 8232
INDIRF4
CNSTF4 1133903872
ADDF4
ASGNF4
line 2494
;2494:		maxs[1] += MONSTER_HIBERNATION_SCAN_RADIUS;
ADDRLP4 8232+4
ADDRLP4 8232+4
INDIRF4
CNSTF4 1133903872
ADDF4
ASGNF4
line 2495
;2495:		n = trap_EntitiesInBox(mins, maxs, nearEntities, MAX_GENTITIES);
ADDRLP4 8220
ARGP4
ADDRLP4 8232
ARGP4
ADDRLP4 4124
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 8252
ADDRGP4 trap_EntitiesInBox
CALLI4
ASGNI4
ADDRLP4 4120
ADDRLP4 8252
INDIRI4
ASGNI4
line 2496
;2496:		for (i = 0; i < n; i++) bag[i] = i;
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1214
JUMPV
LABELV $1211
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
LABELV $1212
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1214
ADDRLP4 0
INDIRI4
ADDRLP4 4120
INDIRI4
LTI4 $1211
ADDRGP4 $1216
JUMPV
LABELV $1215
line 2498
;2497:
;2498:		while (i > 0) {
line 2505
;2499:			int j;
;2500:			gentity_t* ent;
;2501:			playerState_t* ps;
;2502:			vec3_t foot;
;2503:			float footDist;
;2504:
;2505:			j = LocallySeededRandom(&seed) % i;
ADDRLP4 4104
ARGP4
ADDRLP4 8288
ADDRGP4 LocallySeededRandom
CALLU4
ASGNU4
ADDRLP4 8280
ADDRLP4 8288
INDIRU4
ADDRLP4 0
INDIRI4
CVIU4 4
MODU4
CVUI4 4
ASGNI4
line 2506
;2506:			ent = &g_entities[nearEntities[bag[j]]];
ADDRLP4 8260
ADDRLP4 8280
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4124
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 2507
;2507:			bag[j] = bag[--i];
ADDRLP4 8292
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRLP4 0
ADDRLP4 8292
INDIRI4
ASGNI4
ADDRLP4 8280
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
ADDRLP4 8292
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
INDIRI4
ASGNI4
line 2509
;2508:
;2509:			if (!ent->inuse) continue;
ADDRLP4 8260
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1218
ADDRGP4 $1216
JUMPV
LABELV $1218
line 2510
;2510:			ps = G_GetEntityPlayerState(ent);
ADDRLP4 8260
INDIRP4
ARGP4
ADDRLP4 8296
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 8264
ADDRLP4 8296
INDIRP4
ASGNP4
line 2511
;2511:			if (!ps) continue;
ADDRLP4 8264
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1220
ADDRGP4 $1216
JUMPV
LABELV $1220
line 2512
;2512:			if (ps->stats[STAT_HEALTH] <= 0) continue;
ADDRLP4 8264
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $1222
ADDRGP4 $1216
JUMPV
LABELV $1222
line 2513
;2513:			if (ps->persistant[PERS_TEAM] == TEAM_SPECTATOR) continue;
ADDRLP4 8264
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1224
ADDRGP4 $1216
JUMPV
LABELV $1224
line 2514
;2514:			if (ent == monster) continue;
ADDRLP4 8260
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
NEU4 $1226
ADDRGP4 $1216
JUMPV
LABELV $1226
line 2515
;2515:			if (ps->powerups[PW_SHIELD]) continue;
ADDRLP4 8264
INDIRP4
CNSTI4 356
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1228
ADDRGP4 $1216
JUMPV
LABELV $1228
line 2517
;2516:
;2517:			if (ent->monster) {
ADDRLP4 8260
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1230
line 2518
;2518:				if (ent->monster->type != MT_predator) continue;
ADDRLP4 8260
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 476
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1232
ADDRGP4 $1216
JUMPV
LABELV $1232
line 2519
;2519:				if (ent->monster->action != MA_attacking) continue;
ADDRLP4 8260
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
CNSTI4 2
EQI4 $1234
ADDRGP4 $1216
JUMPV
LABELV $1234
line 2520
;2520:			}
LABELV $1230
line 2522
;2521:
;2522:			VectorCopy(mi->ps.origin, foot);
ADDRLP4 8268
ADDRLP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRB
ASGNB 12
line 2523
;2523:			foot[2] = ent->r.currentOrigin[2];
ADDRLP4 8268+8
ADDRLP4 8260
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ASGNF4
line 2524
;2524:			footDist = Distance(foot, ent->r.currentOrigin);
ADDRLP4 8268
ARGP4
ADDRLP4 8260
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 8300
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRLP4 8284
ADDRLP4 8300
INDIRF4
ASGNF4
line 2525
;2525:			if (footDist > 0.5f * (mi->ps.origin[2] - foot[2])) continue;
ADDRLP4 8284
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 8268+8
INDIRF4
SUBF4
CNSTF4 1056964608
MULF4
LEF4 $1237
ADDRGP4 $1216
JUMPV
LABELV $1237
line 2527
;2526:
;2527:			if (!EntityVisibleToMonster(ent, monster)) continue;
ADDRLP4 8260
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8304
ADDRGP4 EntityVisibleToMonster
CALLI4
ASGNI4
ADDRLP4 8304
INDIRI4
CNSTI4 0
NEI4 $1240
ADDRGP4 $1216
JUMPV
LABELV $1240
line 2529
;2528:
;2529:			if (!ent->monster) SetMonsterEnemy(mi, ent, &seed);
ADDRLP4 8260
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1242
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8260
INDIRP4
ARGP4
ADDRLP4 4104
ARGP4
ADDRGP4 SetMonsterEnemy
CALLV
pop
LABELV $1242
line 2530
;2530:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1187
JUMPV
LABELV $1216
line 2498
ADDRLP4 0
INDIRI4
CNSTI4 0
GTI4 $1215
line 2532
;2531:		}
;2532:	}
LABELV $1202
line 2534
;2533:
;2534:	return qfalse;
CNSTI4 0
RETI4
LABELV $1187
endproc ScanForMonsterEnemy 8308 16
proc TryDucking 156 28
line 2544
;2535:}
;2536:#endif
;2537:
;2538:/*
;2539:===============
;2540:JUHOX: TryDucking
;2541:===============
;2542:*/
;2543:#if MONSTER_MODE
;2544:static qboolean TryDucking(gentity_t* monster) {
line 2556
;2545:	gmonster_t* mi;
;2546:	vec3_t viewAngles;
;2547:	vec3_t viewDir;
;2548:	vec3_t end;
;2549:	vec3_t mins;
;2550:	vec3_t maxs;
;2551:	vec3_t testMins;
;2552:	vec3_t testMaxs;
;2553:	trace_t trace;
;2554:	float nonDuckedFraction;
;2555:
;2556:	mi = monster->monster;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
ASGNP4
line 2557
;2557:	if (!mi) return qfalse;
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1245
CNSTI4 0
RETI4
ADDRGP4 $1244
JUMPV
LABELV $1245
line 2559
;2558:
;2559:	G_GetMonsterBounds(mi->type, mins, maxs);
ADDRLP4 12
INDIRP4
CNSTI4 476
ADDP4
INDIRI4
ARGI4
ADDRLP4 132
ARGP4
ADDRLP4 28
ARGP4
ADDRGP4 G_GetMonsterBounds
CALLV
pop
line 2561
;2560:
;2561:	VectorCopy(mi->ps.viewangles, viewAngles);
ADDRLP4 52
ADDRLP4 12
INDIRP4
CNSTI4 160
ADDP4
INDIRB
ASGNB 12
line 2562
;2562:	viewAngles[PITCH] = 0;
ADDRLP4 52
CNSTF4 0
ASGNF4
line 2563
;2563:	viewAngles[ROLL] = 0;
ADDRLP4 52+8
CNSTF4 0
ASGNF4
line 2564
;2564:	AngleVectors(viewAngles, viewDir, NULL, NULL);
ADDRLP4 52
ARGP4
ADDRLP4 64
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 2565
;2565:	VectorMA(mi->ps.origin, maxs[0], viewDir, end);
ADDRLP4 152
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 40
ADDRLP4 12
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 64
INDIRF4
ADDRLP4 152
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 40+4
ADDRLP4 12
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 64+4
INDIRF4
ADDRLP4 152
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 40+8
ADDRLP4 12
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 64+8
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ADDF4
ASGNF4
line 2568
;2566:
;2567:	// is there an obstacle above the waist?
;2568:	VectorCopy(mins, testMins);
ADDRLP4 0
ADDRLP4 132
INDIRB
ASGNB 12
line 2569
;2569:	VectorCopy(maxs, testMaxs);
ADDRLP4 16
ADDRLP4 28
INDIRB
ASGNB 12
line 2570
;2570:	testMins[0] *= 0.8f;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 2571
;2571:	testMins[1] *= 0.8f;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 2572
;2572:	testMins[2] *= 0.8f;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 2573
;2573:	testMaxs[0] *= 0.8f;
ADDRLP4 16
ADDRLP4 16
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 2574
;2574:	testMaxs[1] *= 0.8f;
ADDRLP4 16+4
ADDRLP4 16+4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 2576
;2575:	//testMaxs[2] *= 0.8f;
;2576:	trap_Trace(&trace, mi->ps.origin, testMins, testMaxs, end, monster->s.number, CONTENTS_SOLID | CONTENTS_PLAYERCLIP);
ADDRLP4 76
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 28
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 40
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 65537
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 2578
;2577:	//if (trace.fraction >= 1.0f) return qfalse;
;2578:	nonDuckedFraction = trace.fraction;
ADDRLP4 144
ADDRLP4 76+8
INDIRF4
ASGNF4
line 2581
;2579:
;2580:	// does it help if the monster ducks?
;2581:	VectorCopy(mins, testMins);
ADDRLP4 0
ADDRLP4 132
INDIRB
ASGNB 12
line 2582
;2582:	VectorCopy(maxs, testMaxs);
ADDRLP4 16
ADDRLP4 28
INDIRB
ASGNB 12
line 2583
;2583:	testMins[0] *= 0.8f;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 2584
;2584:	testMins[1] *= 0.8f;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 2585
;2585:	testMins[2] *= 0.8f;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 2586
;2586:	testMaxs[0] *= 0.8f;
ADDRLP4 16
ADDRLP4 16
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 2587
;2587:	testMaxs[1] *= 0.8f;
ADDRLP4 16+4
ADDRLP4 16+4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 2588
;2588:	testMaxs[2] *= 0.4f;
ADDRLP4 16+8
ADDRLP4 16+8
INDIRF4
CNSTF4 1053609165
MULF4
ASGNF4
line 2589
;2589:	trap_Trace(&trace, mi->ps.origin, testMins, testMaxs, end, monster->s.number, CONTENTS_SOLID | CONTENTS_PLAYERCLIP);
ADDRLP4 76
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 28
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 40
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 65537
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 2590
;2590:	if (trace.fraction <= nonDuckedFraction) return qfalse;
ADDRLP4 76+8
INDIRF4
ADDRLP4 144
INDIRF4
GTF4 $1260
CNSTI4 0
RETI4
ADDRGP4 $1244
JUMPV
LABELV $1260
line 2592
;2591:
;2592:	return qtrue;
CNSTI4 1
RETI4
LABELV $1244
endproc TryDucking 156 28
data
align 4
LABELV $1563
byte 4 3245342720
byte 4 3245342720
byte 4 3250585600
align 4
LABELV $1564
byte 4 1097859072
byte 4 1097859072
byte 4 1107296256
code
proc MonsterAI 240 28
line 2602
;2593:}
;2594:#endif
;2595:
;2596:/*
;2597:===============
;2598:JUHOX: MonsterAI
;2599:===============
;2600:*/
;2601:#if MONSTER_MODE
;2602:static void MonsterAI(gentity_t* monster) {
line 2607
;2603:	gmonster_t* mi;
;2604:	//int msec;
;2605:	localseed_t seed;
;2606:
;2607:	mi = monster->monster;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
ASGNP4
line 2608
;2608:	if (!mi) return;
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1264
ADDRGP4 $1263
JUMPV
LABELV $1264
line 2610
;2609:
;2610:	SetMonsterViewCmd(mi, level.time - mi->cmd.serverTime);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRI4
SUBI4
ARGI4
ADDRGP4 SetMonsterViewCmd
CALLV
pop
line 2612
;2611:
;2612:	mi->cmd.serverTime = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 2613
;2613:	if (mi->nextAIFrame > level.time) return;
ADDRLP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $1268
ADDRGP4 $1263
JUMPV
LABELV $1268
line 2615
;2614:
;2615:	mi->cmd.forwardmove = 0;
ADDRLP4 0
INDIRP4
CNSTI4 509
ADDP4
CNSTI1 0
ASGNI1
line 2616
;2616:	mi->cmd.rightmove = 0;
ADDRLP4 0
INDIRP4
CNSTI4 510
ADDP4
CNSTI1 0
ASGNI1
line 2617
;2617:	mi->cmd.upmove = 0;
ADDRLP4 0
INDIRP4
CNSTI4 511
ADDP4
CNSTI1 0
ASGNI1
line 2618
;2618:	mi->cmd.buttons = 0;
ADDRLP4 0
INDIRP4
CNSTI4 504
ADDP4
CNSTI4 0
ASGNI4
line 2619
;2619:	mi->superJump = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
CNSTI4 0
ASGNI4
line 2620
;2620:	mi->ps.pm_flags &= ~PMF_GRAPPLE_PULL;
ADDRLP4 24
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 -2049
BANDI4
ASGNI4
line 2622
;2621:
;2622:	if (monster->health <= 0) return;
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
GTI4 $1271
ADDRGP4 $1263
JUMPV
LABELV $1271
line 2625
;2623:	//if (monster->s.time) return;
;2624:
;2625:	DeriveLocalSeed(&monster->monster->seed, &seed);
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 516
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 DeriveLocalSeed
CALLV
pop
line 2627
;2626:
;2627:	mi->nextAIFrame = level.time + 100 + (LocallySeededRandom(&seed) % 100);
ADDRLP4 4
ARGP4
ADDRLP4 28
ADDRGP4 LocallySeededRandom
CALLU4
ASGNU4
ADDRLP4 0
INDIRP4
CNSTI4 544
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
CVIU4 4
ADDRLP4 28
INDIRU4
CNSTU4 100
MODU4
ADDU4
CVUI4 4
ASGNI4
line 2629
;2628:	//msec = level.time - mi->lastAIFrame;
;2629:	mi->lastAIFrame = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 540
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 2631
;2630:
;2631:	CheckMonsterEnemy(monster, &seed);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 CheckMonsterEnemy
CALLV
pop
line 2634
;2632:
;2633:	if (
;2634:		mi->action != MA_hibernation &&
ADDRLP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
CNSTI4 4
EQI4 $1275
ADDRLP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
CNSTI4 5
EQI4 $1275
line 2636
;2635:		mi->action != MA_sleeping
;2636:	) {
line 2637
;2637:		monster->s.modelindex &= ~(PFMI_HIBERNATION_MODE | PFMI_HIBERNATION_MORPHED);
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 -19
BANDI4
ASGNI4
line 2639
;2638:		if (
;2639:			level.endPhase >= 3 &&
ADDRGP4 level+23012
INDIRI4
CNSTI4 3
LTI4 $1277
ADDRLP4 0
INDIRP4
CNSTI4 360
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
SUBI4
CNSTI4 5000
LEI4 $1277
line 2641
;2640:			mi->ps.powerups[PW_CHARGE] - level.time > 5000
;2641:		) {
line 2642
;2642:			mi->action = MA_panic;
ADDRLP4 0
INDIRP4
CNSTI4 548
ADDP4
CNSTI4 3
ASGNI4
line 2643
;2643:		}
ADDRGP4 $1278
JUMPV
LABELV $1277
line 2644
;2644:		else if (!mi->enemy) {
ADDRLP4 0
INDIRP4
CNSTI4 556
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1281
line 2645
;2645:			mi->action = MA_waiting;
ADDRLP4 0
INDIRP4
CNSTI4 548
ADDP4
CNSTI4 0
ASGNI4
line 2646
;2646:			if (mi->avoidPlayer) {
ADDRLP4 0
INDIRP4
CNSTI4 652
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1283
line 2647
;2647:				if (mi->stopAvoidPlayerTime < level.time) {
ADDRLP4 0
INDIRP4
CNSTI4 660
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
GEI4 $1285
line 2648
;2648:					mi->avoidPlayer = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 652
ADDP4
CNSTP4 0
ASGNP4
line 2649
;2649:				}
ADDRGP4 $1286
JUMPV
LABELV $1285
line 2650
;2650:				else {
line 2651
;2651:					mi->action = MA_avoiding;
ADDRLP4 0
INDIRP4
CNSTI4 548
ADDP4
CNSTI4 1
ASGNI4
line 2652
;2652:				}
LABELV $1286
line 2653
;2653:			}
LABELV $1283
line 2654
;2654:		}
LABELV $1281
LABELV $1278
line 2655
;2655:	}
LABELV $1275
line 2657
;2656:
;2657:	switch (mi->action) {
ADDRLP4 36
ADDRLP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
LTI4 $1288
ADDRLP4 36
INDIRI4
CNSTI4 5
GTI4 $1288
ADDRLP4 36
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1580
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1580
address $1291
address $1327
address $1340
address $1499
address $1504
address $1575
code
LABELV $1291
line 2659
;2658:	case MA_waiting:
;2659:		MonsterSearchView(monster, &seed);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 MonsterSearchView
CALLV
pop
line 2660
;2660:		if (mi->walk && level.endPhase <= 0) {
ADDRLP4 0
INDIRP4
CNSTI4 552
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1292
ADDRGP4 level+23012
INDIRI4
CNSTI4 0
GTI4 $1292
line 2665
;2661:			trace_t trace;
;2662:			vec3_t dir;
;2663:			vec3_t end;
;2664:
;2665:			AngleVectors(mi->ps.viewangles, dir, NULL, NULL);
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
ARGP4
ADDRLP4 112
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 2666
;2666:			VectorMA(mi->ps.origin, 75.0f, dir, end);
ADDRLP4 44
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 112
INDIRF4
CNSTF4 1117126656
MULF4
ADDF4
ASGNF4
ADDRLP4 44+4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 112+4
INDIRF4
CNSTF4 1117126656
MULF4
ADDF4
ASGNF4
ADDRLP4 44+8
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 112+8
INDIRF4
CNSTF4 1117126656
MULF4
ADDF4
ASGNF4
line 2667
;2667:			trap_Trace(&trace, mi->ps.origin, NULL, NULL, end, monster->s.number, CONTENTS_SOLID|CONTENTS_PLAYERCLIP);
ADDRLP4 56
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 44
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 65537
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 2668
;2668:			if (trace.fraction < 1.0f) {
ADDRLP4 56+8
INDIRF4
CNSTF4 1065353216
GEF4 $1299
line 2669
;2669:				mi->walk = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 552
ADDP4
CNSTI4 0
ASGNI4
line 2670
;2670:			}
ADDRGP4 $1300
JUMPV
LABELV $1299
line 2671
;2671:			else {
line 2674
;2672:				vec3_t start;
;2673:
;2674:				VectorCopy(trace.endpos, start);
ADDRLP4 128
ADDRLP4 56+12
INDIRB
ASGNB 12
line 2675
;2675:				VectorCopy(start, end);
ADDRLP4 44
ADDRLP4 128
INDIRB
ASGNB 12
line 2676
;2676:				end[2] -= 400.0f;
ADDRLP4 44+8
ADDRLP4 44+8
INDIRF4
CNSTF4 1137180672
SUBF4
ASGNF4
line 2677
;2677:				trap_Trace(&trace, start, NULL, NULL, end, monster->s.number, MASK_OPAQUE|CONTENTS_PLAYERCLIP|CONTENTS_TRIGGER);
ADDRLP4 56
ARGP4
ADDRLP4 128
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 44
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 1073807385
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 2679
;2678:				if (
;2679:					trace.fraction >= 1 ||
ADDRLP4 56+8
INDIRF4
CNSTF4 1065353216
GEF4 $1308
ADDRLP4 56+48
INDIRI4
CNSTI4 1073741848
BANDI4
CNSTI4 0
EQI4 $1304
LABELV $1308
line 2681
;2680:					(trace.contents & (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_TRIGGER))
;2681:				) {
line 2682
;2682:					mi->walk = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 552
ADDP4
CNSTI4 0
ASGNI4
line 2683
;2683:				}
LABELV $1304
line 2684
;2684:			}
LABELV $1300
line 2685
;2685:			mi->cmd.forwardmove = 32;
ADDRLP4 0
INDIRP4
CNSTI4 509
ADDP4
CNSTI1 32
ASGNI1
line 2686
;2686:			mi->cmd.buttons |= BUTTON_WALKING;
ADDRLP4 128
ADDRLP4 0
INDIRP4
CNSTI4 504
ADDP4
ASGNP4
ADDRLP4 128
INDIRP4
ADDRLP4 128
INDIRP4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 2687
;2687:		}
LABELV $1292
line 2688
;2688:		SearchMonsterEnemy(monster, &seed);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 SearchMonsterEnemy
CALLV
pop
line 2689
;2689:		if (mi->enemy) {
ADDRLP4 0
INDIRP4
CNSTI4 556
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1309
line 2698
;2690:			/*
;2691:			if (monster->health > 0.5 * mi->ps.stats[STAT_MAX_HEALTH]) {
;2692:				mi->action = MA_attacking;
;2693:			}
;2694:			else {
;2695:				mi->action = MA_escaping;
;2696:			}
;2697:			*/
;2698:			mi->action = MA_attacking;
ADDRLP4 0
INDIRP4
CNSTI4 548
ADDP4
CNSTI4 2
ASGNI4
line 2699
;2699:		}
LABELV $1309
line 2702
;2700:
;2701:		if (
;2702:			g_gametype.integer == GT_STU &&
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
NEI4 $1289
ADDRLP4 0
INDIRP4
CNSTI4 664
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1289
ADDRGP4 g_monsterBreeding+12
INDIRI4
CNSTI4 0
EQI4 $1289
line 2705
;2703:			mi->hibernationTime &&
;2704:			g_monsterBreeding.integer
;2705:		) {
line 2707
;2706:			if (
;2707:				!mi->walk &&
ADDRLP4 0
INDIRP4
CNSTI4 552
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1289
ADDRLP4 0
INDIRP4
CNSTI4 556
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1289
ADDRLP4 0
INDIRP4
CNSTI4 664
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
GTI4 $1289
line 2710
;2708:				!mi->enemy &&
;2709:				mi->hibernationTime <= level.time
;2710:			) {
line 2714
;2711:				trace_t trace;
;2712:				vec3_t end;
;2713:
;2714:				VectorCopy(mi->ps.origin, end);
ADDRLP4 104
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRB
ASGNB 12
line 2715
;2715:				end[2] += 4000.0f;
ADDRLP4 104+8
ADDRLP4 104+8
INDIRF4
CNSTF4 1165623296
ADDF4
ASGNF4
line 2716
;2716:				trap_Trace(&trace, mi->ps.origin, NULL, NULL, end, monster->s.number, MASK_PLAYERSOLID);
ADDRLP4 48
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 104
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 33619969
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 2718
;2717:				if (
;2718:					trace.fraction < 1.0f &&
ADDRLP4 48+8
INDIRF4
CNSTF4 1065353216
GEF4 $1319
ADDRLP4 48+8
INDIRF4
CNSTF4 1022739087
LEF4 $1319
ADDRLP4 48+44
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $1319
ADDRLP4 48+48
INDIRI4
CNSTI4 33554432
BANDI4
CNSTI4 0
NEI4 $1319
line 2722
;2719:					trace.fraction > 0.03f &&
;2720:					!(trace.surfaceFlags & SURF_NOIMPACT) &&
;2721:					!(trace.contents & CONTENTS_BODY)
;2722:				) {
line 2723
;2723:					mi->action = MA_hibernation;
ADDRLP4 0
INDIRP4
CNSTI4 548
ADDP4
CNSTI4 4
ASGNI4
line 2724
;2724:					mi->hibernationPhase = HP_entry;
ADDRLP4 0
INDIRP4
CNSTI4 672
ADDP4
CNSTI4 0
ASGNI4
line 2725
;2725:					mi->ideal_view[PITCH] = -90.0f;
ADDRLP4 0
INDIRP4
CNSTI4 624
ADDP4
CNSTF4 3266576384
ASGNF4
line 2726
;2726:					VectorCopy(trace.endpos, mi->hibernationSpot);
ADDRLP4 0
INDIRP4
CNSTI4 676
ADDP4
ADDRLP4 48+12
INDIRB
ASGNB 12
line 2727
;2727:				}
ADDRGP4 $1289
JUMPV
LABELV $1319
line 2728
;2728:				else {
line 2729
;2729:					mi->hibernationWaitTime = 15000 + LocallySeededRandom(&seed) % 30000;
ADDRLP4 4
ARGP4
ADDRLP4 116
ADDRGP4 LocallySeededRandom
CALLU4
ASGNU4
ADDRLP4 0
INDIRP4
CNSTI4 668
ADDP4
ADDRLP4 116
INDIRU4
CNSTU4 30000
MODU4
CNSTU4 15000
ADDU4
CVUI4 4
ASGNI4
line 2730
;2730:					mi->hibernationTime = level.time + mi->hibernationWaitTime;
ADDRLP4 0
INDIRP4
CNSTI4 664
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 668
ADDP4
INDIRI4
ADDI4
ASGNI4
line 2731
;2731:				}
line 2732
;2732:			}
line 2733
;2733:		}
line 2734
;2734:		break;
ADDRGP4 $1289
JUMPV
LABELV $1327
line 2736
;2735:	case MA_avoiding:
;2736:		{
line 2740
;2737:			vec3_t start, end;
;2738:			vec3_t dir;
;2739:
;2740:			mi->walk = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 552
ADDP4
CNSTI4 0
ASGNI4
line 2742
;2741:
;2742:			VectorCopy(mi->ps.origin, start);
ADDRLP4 44
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRB
ASGNB 12
line 2743
;2743:			start[2] += mi->ps.viewheight;
ADDRLP4 44+8
ADDRLP4 44+8
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 2744
;2744:			VectorCopy(mi->avoidPlayer->origin, end);
ADDRLP4 56
ADDRLP4 0
INDIRP4
CNSTI4 652
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 2745
;2745:			end[2] += mi->avoidPlayer->viewheight;
ADDRLP4 56+8
ADDRLP4 56+8
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 652
ADDP4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 2746
;2746:			VectorSubtract(end, start, dir);
ADDRLP4 68
ADDRLP4 56
INDIRF4
ADDRLP4 44
INDIRF4
SUBF4
ASGNF4
ADDRLP4 68+4
ADDRLP4 56+4
INDIRF4
ADDRLP4 44+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 68+8
ADDRLP4 56+8
INDIRF4
ADDRLP4 44+8
INDIRF4
SUBF4
ASGNF4
line 2747
;2747:			vectoangles(dir, mi->ideal_view);
ADDRLP4 68
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 624
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2749
;2748:
;2749:			if (fabs(AngleSubtract(mi->ideal_view[YAW], mi->ps.viewangles[YAW])) > 90.0f) {
ADDRLP4 0
INDIRP4
CNSTI4 628
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
ADDRLP4 84
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 84
INDIRF4
ARGF4
ADDRLP4 88
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 88
INDIRF4
CNSTF4 1119092736
LEF4 $1336
line 2750
;2750:				mi->cmd.forwardmove = 32;
ADDRLP4 0
INDIRP4
CNSTI4 509
ADDP4
CNSTI1 32
ASGNI1
line 2751
;2751:			}
ADDRGP4 $1337
JUMPV
LABELV $1336
line 2752
;2752:			else {
line 2753
;2753:				mi->cmd.forwardmove = -32;
ADDRLP4 0
INDIRP4
CNSTI4 509
ADDP4
CNSTI1 -32
ASGNI1
line 2754
;2754:			}
LABELV $1337
line 2755
;2755:			mi->cmd.buttons |= BUTTON_WALKING;
ADDRLP4 92
ADDRLP4 0
INDIRP4
CNSTI4 504
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 2756
;2756:		}
line 2757
;2757:		SearchMonsterEnemy(monster, &seed);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 SearchMonsterEnemy
CALLV
pop
line 2758
;2758:		if (mi->enemy) mi->action = MA_attacking;
ADDRLP4 0
INDIRP4
CNSTI4 556
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1289
ADDRLP4 0
INDIRP4
CNSTI4 548
ADDP4
CNSTI4 2
ASGNI4
line 2759
;2759:		break;
ADDRGP4 $1289
JUMPV
LABELV $1340
line 2762
;2760:	case MA_attacking:
;2761:
;2762:		switch (mi->type) {
ADDRLP4 44
ADDRLP4 0
INDIRP4
CNSTI4 476
ADDP4
INDIRI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $1344
ADDRLP4 44
INDIRI4
CNSTI4 1
EQI4 $1409
ADDRLP4 44
INDIRI4
CNSTI4 2
EQI4 $1441
ADDRGP4 $1342
JUMPV
LABELV $1344
line 2767
;2763:
;2764:		// predator attacking
;2765:		case MT_predator:
;2766:
;2767:			mi->hibernationTime = level.time + mi->hibernationWaitTime;
ADDRLP4 0
INDIRP4
CNSTI4 664
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 668
ADDP4
INDIRI4
ADDI4
ASGNI4
line 2769
;2768:
;2769:			if (mi->enemyFoundTime < level.time - 250) {
ADDRLP4 0
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 250
SUBI4
GEI4 $1346
line 2770
;2770:				mi->cmd.forwardmove = 127;
ADDRLP4 0
INDIRP4
CNSTI4 509
ADDP4
CNSTI1 127
ASGNI1
line 2771
;2771:			}
LABELV $1346
line 2772
;2772:			{
line 2780
;2773:				playerState_t* enemyPS;
;2774:				vec3_t start, end;
;2775:				vec3_t dir, horizDir;
;2776:				vec_t distSqr, horizDistSqr;
;2777:				localseed_t seed1;
;2778:				localseed_t seed2;
;2779:
;2780:				enemyPS = G_GetEntityPlayerState(mi->enemy);
ADDRLP4 0
INDIRP4
CNSTI4 556
ADDP4
INDIRP4
ARGP4
ADDRLP4 148
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 92
ADDRLP4 148
INDIRP4
ASGNP4
line 2781
;2781:				VectorCopy(mi->ps.origin, start);
ADDRLP4 68
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRB
ASGNB 12
line 2782
;2782:				start[2] += mi->ps.viewheight;
ADDRLP4 68+8
ADDRLP4 68+8
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 2783
;2783:				VectorCopy(enemyPS->origin, end);
ADDRLP4 80
ADDRLP4 92
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 2784
;2784:				end[2] += enemyPS->viewheight;
ADDRLP4 80+8
ADDRLP4 80+8
INDIRF4
ADDRLP4 92
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 2785
;2785:				VectorSubtract(end, start, dir);
ADDRLP4 56
ADDRLP4 80
INDIRF4
ADDRLP4 68
INDIRF4
SUBF4
ASGNF4
ADDRLP4 56+4
ADDRLP4 80+4
INDIRF4
ADDRLP4 68+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 56+8
ADDRLP4 80+8
INDIRF4
ADDRLP4 68+8
INDIRF4
SUBF4
ASGNF4
line 2787
;2786:
;2787:				DeriveLocalSeed(&seed, &seed1);
ADDRLP4 4
ARGP4
ADDRLP4 112
ARGP4
ADDRGP4 DeriveLocalSeed
CALLV
pop
line 2788
;2788:				DeriveLocalSeed(&seed, &seed2);
ADDRLP4 4
ARGP4
ADDRLP4 132
ARGP4
ADDRGP4 DeriveLocalSeed
CALLV
pop
line 2790
;2789:
;2790:				if (!mi->freezeView) {
ADDRLP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1357
line 2791
;2791:					if ((enemyPS->eFlags ^ mi->oldEnemyEFlags) & EF_TELEPORT_BIT) {
ADDRLP4 92
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 568
ADDP4
INDIRI4
BXORI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $1359
line 2792
;2792:						mi->freezeView = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 576
ADDP4
CNSTI4 1
ASGNI4
line 2793
;2793:						mi->nextEnemyVisCheck = level.time + 1000 + (LocallySeededRandom(&seed1) % 1000);
ADDRLP4 112
ARGP4
ADDRLP4 152
ADDRGP4 LocallySeededRandom
CALLU4
ASGNU4
ADDRLP4 0
INDIRP4
CNSTI4 592
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDI4
CVIU4 4
ADDRLP4 152
INDIRU4
CNSTU4 1000
MODU4
ADDU4
CVUI4 4
ASGNI4
line 2794
;2794:					}
ADDRGP4 $1358
JUMPV
LABELV $1359
line 2795
;2795:					else {
line 2796
;2796:						vectoangles(dir, mi->ideal_view);
ADDRLP4 56
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 624
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2797
;2797:					}
line 2798
;2798:				}
ADDRGP4 $1358
JUMPV
LABELV $1357
line 2799
;2799:				else if ((mi->ps.eFlags ^ mi->oldEFlags) & EF_TELEPORT_BIT) {
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
BXORI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $1362
line 2800
;2800:					mi->freezeView = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 576
ADDP4
CNSTI4 0
ASGNI4
line 2801
;2801:				}
LABELV $1362
LABELV $1358
line 2802
;2802:				mi->oldEFlags = mi->ps.eFlags;
ADDRLP4 0
INDIRP4
CNSTI4 572
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
ASGNI4
line 2803
;2803:				mi->oldEnemyEFlags = enemyPS->eFlags;
ADDRLP4 0
INDIRP4
CNSTI4 568
ADDP4
ADDRLP4 92
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
ASGNI4
line 2805
;2804:
;2805:				distSqr = VectorLengthSquared(dir);
ADDRLP4 56
ARGP4
ADDRLP4 160
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 108
ADDRLP4 160
INDIRF4
ASGNF4
line 2806
;2806:				VectorCopy(dir, horizDir);
ADDRLP4 96
ADDRLP4 56
INDIRB
ASGNB 12
line 2807
;2807:				horizDir[2] = 0;
ADDRLP4 96+8
CNSTF4 0
ASGNF4
line 2808
;2808:				horizDistSqr = VectorLengthSquared(horizDir);
ADDRLP4 96
ARGP4
ADDRLP4 164
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 128
ADDRLP4 164
INDIRF4
ASGNF4
line 2810
;2809:
;2810:				if (mi->cmd.forwardmove) {
ADDRLP4 0
INDIRP4
CNSTI4 509
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1365
line 2812
;2811:					if (
;2812:						(
ADDRLP4 128
INDIRF4
CNSTF4 1193033728
GEF4 $1372
ADDRLP4 56+8
INDIRF4
CNSTF4 1099956224
GTF4 $1371
LABELV $1372
ADDRLP4 112
ARGP4
ADDRLP4 172
ADDRGP4 local_random
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ARGP4
ADDRLP4 176
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 176
INDIRF4
CNSTF4 1176256512
GEF4 $1373
ADDRLP4 168
CNSTF4 1045220557
ASGNF4
ADDRGP4 $1374
JUMPV
LABELV $1373
ADDRLP4 168
CNSTF4 1017370378
ASGNF4
LABELV $1374
ADDRLP4 172
INDIRF4
ADDRLP4 168
INDIRF4
GEF4 $1367
LABELV $1371
ADDRLP4 92
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1023
EQI4 $1367
ADDRLP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1367
line 2821
;2813:							(
;2814:								horizDistSqr < Square(200.0f) &&
;2815:								dir[2] > /*STEPSIZE*/18.0f
;2816:							) ||
;2817:							local_random(&seed1) < (VectorLengthSquared(mi->ps.velocity) < Square(100.0f)? 0.2f : 0.02f)
;2818:						) &&
;2819:						enemyPS->groundEntityNum != ENTITYNUM_NONE &&
;2820:						!mi->freezeView
;2821:					) {
line 2822
;2822:						mi->cmd.upmove = 127;
ADDRLP4 0
INDIRP4
CNSTI4 511
ADDP4
CNSTI1 127
ASGNI1
line 2823
;2823:						if (dir[2] > 45.0f) mi->superJump = qtrue;
ADDRLP4 56+8
INDIRF4
CNSTF4 1110704128
LEF4 $1368
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
CNSTI4 1
ASGNI4
line 2824
;2824:					}
ADDRGP4 $1368
JUMPV
LABELV $1367
line 2825
;2825:					else if (mi->ps.groundEntityNum != ENTITYNUM_NONE) {
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 1023
EQI4 $1378
line 2828
;2826:						trace_t trace;
;2827:
;2828:						AngleVectors(mi->ps.viewangles, dir, NULL, NULL);
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
ARGP4
ADDRLP4 56
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 2829
;2829:						VectorMA(mi->ps.origin, 0.150f * g_speed.value, dir, start);
ADDRLP4 68
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 56
INDIRF4
ADDRGP4 g_speed+8
INDIRF4
CNSTF4 1041865114
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 68+4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 56+4
INDIRF4
ADDRGP4 g_speed+8
INDIRF4
CNSTF4 1041865114
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 68+8
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 56+8
INDIRF4
ADDRGP4 g_speed+8
INDIRF4
CNSTF4 1041865114
MULF4
MULF4
ADDF4
ASGNF4
line 2830
;2830:						VectorCopy(start, end);
ADDRLP4 80
ADDRLP4 68
INDIRB
ASGNB 12
line 2831
;2831:						end[2] -= 100.0f;
ADDRLP4 80+8
ADDRLP4 80+8
INDIRF4
CNSTF4 1120403456
SUBF4
ASGNF4
line 2832
;2832:						trap_Trace(&trace, start, NULL, NULL, end, -1, MASK_PLAYERSOLID & ~CONTENTS_BODY);
ADDRLP4 180
ARGP4
ADDRLP4 68
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 80
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 65537
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 2833
;2833:						if (trace.fraction >= 1) {
ADDRLP4 180+8
INDIRF4
CNSTF4 1065353216
LTF4 $1388
line 2834
;2834:							mi->cmd.upmove = 127;
ADDRLP4 0
INDIRP4
CNSTI4 511
ADDP4
CNSTI1 127
ASGNI1
line 2835
;2835:							if (horizDistSqr > Square(400.0f)) {
ADDRLP4 128
INDIRF4
CNSTF4 1209810944
LEF4 $1391
line 2836
;2836:								VectorCopy(start, end);
ADDRLP4 80
ADDRLP4 68
INDIRB
ASGNB 12
line 2837
;2837:								end[2] += 200.0f;
ADDRLP4 80+8
ADDRLP4 80+8
INDIRF4
CNSTF4 1128792064
ADDF4
ASGNF4
line 2838
;2838:								trap_Trace(&trace, start, NULL, NULL, end, -1, MASK_PLAYERSOLID & ~CONTENTS_BODY);
ADDRLP4 180
ARGP4
ADDRLP4 68
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 80
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 65537
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 2839
;2839:								if (trace.fraction >= 1.0f) {
ADDRLP4 180+8
INDIRF4
CNSTF4 1065353216
LTF4 $1394
line 2840
;2840:									mi->superJump = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
CNSTI4 1
ASGNI4
line 2841
;2841:								}
LABELV $1394
line 2842
;2842:							}
LABELV $1391
line 2843
;2843:						}
LABELV $1388
line 2844
;2844:					}
LABELV $1378
LABELV $1368
line 2845
;2845:				}
LABELV $1365
line 2847
;2846:
;2847:				if (distSqr < Square(100.0f)) {
ADDRLP4 108
INDIRF4
CNSTF4 1176256512
GEF4 $1397
line 2850
;2848:					float viewDiff;
;2849:
;2850:					mi->cmd.buttons |= BUTTON_ATTACK;
ADDRLP4 172
ADDRLP4 0
INDIRP4
CNSTI4 504
ADDP4
ASGNP4
ADDRLP4 172
INDIRP4
ADDRLP4 172
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 2852
;2851:					// prevent the predator from orbitting the enemy
;2852:					viewDiff = fabs(AngleSubtract(mi->ps.viewangles[YAW], mi->ideal_view[YAW]));
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 628
ADDP4
INDIRF4
ARGF4
ADDRLP4 180
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 180
INDIRF4
ARGF4
ADDRLP4 184
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 168
ADDRLP4 184
INDIRF4
ASGNF4
line 2853
;2853:					if (viewDiff > 60.0f) viewDiff = 60.0f;
ADDRLP4 168
INDIRF4
CNSTF4 1114636288
LEF4 $1399
ADDRLP4 168
CNSTF4 1114636288
ASGNF4
LABELV $1399
line 2854
;2854:					mi->cmd.forwardmove = 127 - 2 * viewDiff;
ADDRLP4 0
INDIRP4
CNSTI4 509
ADDP4
CNSTF4 1123942400
ADDRLP4 168
INDIRF4
CNSTF4 1073741824
MULF4
SUBF4
CVFI4 4
CVII1 4
ASGNI1
line 2855
;2855:				}
ADDRGP4 $1342
JUMPV
LABELV $1397
line 2856
;2856:				else if (!mi->freezeView) {
ADDRLP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1342
line 2857
;2857:					if (mi->nextDodgeTime <= level.time) {
ADDRLP4 0
INDIRP4
CNSTI4 584
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
GTI4 $1403
line 2858
;2858:						mi->nextDodgeTime = level.time + 500 + (LocallySeededRandom(&seed2) % 1000);
ADDRLP4 132
ARGP4
ADDRLP4 168
ADDRGP4 LocallySeededRandom
CALLU4
ASGNU4
ADDRLP4 0
INDIRP4
CNSTI4 584
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 500
ADDI4
CVIU4 4
ADDRLP4 168
INDIRU4
CNSTU4 1000
MODU4
ADDU4
CVUI4 4
ASGNI4
line 2860
;2859:
;2860:						mi->dodgeDir = 32 + (LocallySeededRandom(&seed2) & 63);
ADDRLP4 132
ARGP4
ADDRLP4 172
ADDRGP4 LocallySeededRandom
CALLU4
ASGNU4
ADDRLP4 0
INDIRP4
CNSTI4 588
ADDP4
ADDRLP4 172
INDIRU4
CNSTU4 63
BANDU4
CNSTU4 32
ADDU4
CVUI4 4
ASGNI4
line 2861
;2861:						if (LocallySeededRandom(&seed2) & 1) mi->dodgeDir = -mi->dodgeDir;
ADDRLP4 132
ARGP4
ADDRLP4 176
ADDRGP4 LocallySeededRandom
CALLU4
ASGNU4
ADDRLP4 176
INDIRU4
CNSTU4 1
BANDU4
CNSTU4 0
EQU4 $1407
ADDRLP4 0
INDIRP4
CNSTI4 588
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 588
ADDP4
INDIRI4
NEGI4
ASGNI4
LABELV $1407
line 2862
;2862:					}
LABELV $1403
line 2863
;2863:					mi->cmd.rightmove = mi->dodgeDir;
ADDRLP4 0
INDIRP4
CNSTI4 510
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 588
ADDP4
INDIRI4
CVII1 4
ASGNI1
line 2864
;2864:				}
line 2865
;2865:			}
line 2866
;2866:			break;
ADDRGP4 $1342
JUMPV
LABELV $1409
line 2870
;2867:
;2868:		// guard attacking
;2869:		case MT_guard:
;2870:			if (mi->enemyFoundTime < level.time - 500) {
ADDRLP4 0
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 500
SUBI4
GEI4 $1410
line 2871
;2871:				mi->cmd.buttons |= BUTTON_ATTACK;
ADDRLP4 56
ADDRLP4 0
INDIRP4
CNSTI4 504
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 2872
;2872:			}
ADDRGP4 $1411
JUMPV
LABELV $1410
line 2873
;2873:			else {
line 2874
;2874:				mi->cmd.buttons |= BUTTON_GESTURE;
ADDRLP4 56
ADDRLP4 0
INDIRP4
CNSTI4 504
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 2875
;2875:			}
LABELV $1411
line 2876
;2876:			{
line 2883
;2877:				playerState_t* enemyPS;
;2878:				vec3_t start, end;
;2879:				vec3_t dir;
;2880:				localseed_t seed1;
;2881:				trace_t trace;
;2882:
;2883:				enemyPS = G_GetEntityPlayerState(mi->enemy);
ADDRLP4 0
INDIRP4
CNSTI4 556
ADDP4
INDIRP4
ARGP4
ADDRLP4 168
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 136
ADDRLP4 168
INDIRP4
ASGNP4
line 2884
;2884:				VectorCopy(mi->ps.origin, start);
ADDRLP4 56
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRB
ASGNB 12
line 2885
;2885:				start[2] += mi->ps.viewheight;
ADDRLP4 56+8
ADDRLP4 56+8
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 2886
;2886:				VectorCopy(enemyPS->origin, end);
ADDRLP4 68
ADDRLP4 136
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 2887
;2887:				end[2] += enemyPS->viewheight;
ADDRLP4 68+8
ADDRLP4 68+8
INDIRF4
ADDRLP4 136
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 2888
;2888:				VectorSubtract(end, start, dir);
ADDRLP4 140
ADDRLP4 68
INDIRF4
ADDRLP4 56
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 68+4
INDIRF4
ADDRLP4 56+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 68+8
INDIRF4
ADDRLP4 56+8
INDIRF4
SUBF4
ASGNF4
line 2890
;2889:
;2890:				DeriveLocalSeed(&seed, &seed1);
ADDRLP4 4
ARGP4
ADDRLP4 152
ARGP4
ADDRGP4 DeriveLocalSeed
CALLV
pop
line 2892
;2891:
;2892:				trap_Trace(&trace, start, NULL, NULL, end, monster->s.number, MASK_SHOT);
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
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 2894
;2893:				if (
;2894:					(trace.fraction >= 1 || trace.entityNum == mi->enemy->s.number) &&
ADDRLP4 80+8
INDIRF4
CNSTF4 1065353216
GEF4 $1425
ADDRLP4 80+52
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 556
ADDP4
INDIRP4
INDIRI4
NEI4 $1421
LABELV $1425
ADDRLP4 0
INDIRP4
CNSTI4 580
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1426
ADDRLP4 0
INDIRP4
CNSTI4 556
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 176
ADDRGP4 EntityInViewOfMonster
CALLI4
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 0
EQI4 $1421
LABELV $1426
line 2896
;2895:					(mi->enemyWasInView || EntityInViewOfMonster(mi->enemy, mi))
;2896:				) {
line 2897
;2897:					mi->enemyWasInView = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 580
ADDP4
CNSTI4 1
ASGNI4
line 2898
;2898:					if (!mi->freezeView) {
ADDRLP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1427
line 2899
;2899:						if ((enemyPS->eFlags ^ mi->oldEnemyEFlags) & EF_TELEPORT_BIT) {
ADDRLP4 136
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 568
ADDP4
INDIRI4
BXORI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $1429
line 2900
;2900:							mi->freezeView = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 576
ADDP4
CNSTI4 1
ASGNI4
line 2901
;2901:							mi->nextEnemyVisCheck = level.time + 1000 + (LocallySeededRandom(&seed1) % 1000);
ADDRLP4 152
ARGP4
ADDRLP4 180
ADDRGP4 LocallySeededRandom
CALLU4
ASGNU4
ADDRLP4 0
INDIRP4
CNSTI4 592
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDI4
CVIU4 4
ADDRLP4 180
INDIRU4
CNSTU4 1000
MODU4
ADDU4
CVUI4 4
ASGNI4
line 2902
;2902:						}
ADDRGP4 $1422
JUMPV
LABELV $1429
line 2903
;2903:						else {
line 2904
;2904:							vectoangles(dir, mi->ideal_view);
ADDRLP4 140
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 624
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2905
;2905:						}
line 2906
;2906:					}
ADDRGP4 $1422
JUMPV
LABELV $1427
line 2907
;2907:					else if ((mi->ps.eFlags ^ mi->oldEFlags) & EF_TELEPORT_BIT) {
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
BXORI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $1422
line 2908
;2908:						mi->freezeView = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 576
ADDP4
CNSTI4 0
ASGNI4
line 2909
;2909:					}
line 2910
;2910:				}
ADDRGP4 $1422
JUMPV
LABELV $1421
line 2911
;2911:				else {
line 2912
;2912:					mi->enemyWasInView = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 580
ADDP4
CNSTI4 0
ASGNI4
line 2913
;2913:				}
LABELV $1422
line 2914
;2914:				mi->oldEFlags = mi->ps.eFlags;
ADDRLP4 0
INDIRP4
CNSTI4 572
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
ASGNI4
line 2915
;2915:				mi->oldEnemyEFlags = enemyPS->eFlags;
ADDRLP4 0
INDIRP4
CNSTI4 568
ADDP4
ADDRLP4 136
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
ASGNI4
line 2919
;2916:
;2917:				// stop shooting if we'd hit a titan
;2918:				if (
;2919:					trace.fraction < 1 &&
ADDRLP4 80+8
INDIRF4
CNSTF4 1065353216
GEF4 $1342
ADDRLP4 80+52
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1342
ADDRLP4 80+52
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+520
ADDP4
INDIRP4
CNSTI4 476
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1342
line 2922
;2920:					g_entities[trace.entityNum].monster &&
;2921:					g_entities[trace.entityNum].monster->type == MT_titan
;2922:				) {
line 2923
;2923:					mi->cmd.buttons &= ~BUTTON_ATTACK;
ADDRLP4 184
ADDRLP4 0
INDIRP4
CNSTI4 504
ADDP4
ASGNP4
ADDRLP4 184
INDIRP4
ADDRLP4 184
INDIRP4
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 2924
;2924:				}
line 2925
;2925:			}
line 2926
;2926:			break;
ADDRGP4 $1342
JUMPV
LABELV $1441
line 2930
;2927:
;2928:		// titan attacking (derived from predator attack code)
;2929:		case MT_titan:
;2930:			if (mi->enemyFoundTime < level.time - 250) {
ADDRLP4 0
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 250
SUBI4
GEI4 $1442
line 2931
;2931:				mi->cmd.forwardmove = 127;
ADDRLP4 0
INDIRP4
CNSTI4 509
ADDP4
CNSTI1 127
ASGNI1
line 2934
;2932:
;2933:				if (
;2934:					mi->enemyFoundTime < level.time - 700 &&
ADDRLP4 0
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 700
SUBI4
GEI4 $1443
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ARGP4
ADDRLP4 60
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 60
INDIRF4
CNSTF4 1176256512
GEF4 $1443
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 TryDucking
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
EQI4 $1443
line 2937
;2935:					VectorLengthSquared(mi->ps.velocity) < Square(100.0f) &&
;2936:					TryDucking(monster)
;2937:				) {
line 2938
;2938:					mi->cmd.upmove = -127;
ADDRLP4 0
INDIRP4
CNSTI4 511
ADDP4
CNSTI1 -127
ASGNI1
line 2939
;2939:				}
line 2940
;2940:			}
ADDRGP4 $1443
JUMPV
LABELV $1442
line 2941
;2941:			else {
line 2942
;2942:				mi->cmd.buttons |= BUTTON_GESTURE;
ADDRLP4 56
ADDRLP4 0
INDIRP4
CNSTI4 504
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 2943
;2943:			}
LABELV $1443
line 2944
;2944:			{
line 2952
;2945:				playerState_t* enemyPS;
;2946:				vec3_t start, end;
;2947:				vec3_t dir, horizDir;
;2948:				vec_t distSqr, horizDistSqr;
;2949:				localseed_t seed1;
;2950:				localseed_t seed2;
;2951:
;2952:				enemyPS = G_GetEntityPlayerState(mi->enemy);
ADDRLP4 0
INDIRP4
CNSTI4 556
ADDP4
INDIRP4
ARGP4
ADDRLP4 148
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 92
ADDRLP4 148
INDIRP4
ASGNP4
line 2953
;2953:				VectorCopy(mi->ps.origin, start);
ADDRLP4 68
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRB
ASGNB 12
line 2954
;2954:				start[2] += mi->ps.viewheight;
ADDRLP4 68+8
ADDRLP4 68+8
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 2955
;2955:				VectorCopy(enemyPS->origin, end);
ADDRLP4 80
ADDRLP4 92
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 2956
;2956:				end[2] += enemyPS->viewheight;
ADDRLP4 80+8
ADDRLP4 80+8
INDIRF4
ADDRLP4 92
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 2957
;2957:				VectorSubtract(end, start, dir);
ADDRLP4 56
ADDRLP4 80
INDIRF4
ADDRLP4 68
INDIRF4
SUBF4
ASGNF4
ADDRLP4 56+4
ADDRLP4 80+4
INDIRF4
ADDRLP4 68+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 56+8
ADDRLP4 80+8
INDIRF4
ADDRLP4 68+8
INDIRF4
SUBF4
ASGNF4
line 2959
;2958:
;2959:				DeriveLocalSeed(&seed, &seed1);
ADDRLP4 4
ARGP4
ADDRLP4 112
ARGP4
ADDRGP4 DeriveLocalSeed
CALLV
pop
line 2960
;2960:				DeriveLocalSeed(&seed, &seed2);
ADDRLP4 4
ARGP4
ADDRLP4 132
ARGP4
ADDRGP4 DeriveLocalSeed
CALLV
pop
line 2962
;2961:
;2962:				if (!mi->freezeView) {
ADDRLP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1456
line 2963
;2963:					if ((enemyPS->eFlags ^ mi->oldEnemyEFlags) & EF_TELEPORT_BIT) {
ADDRLP4 92
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 568
ADDP4
INDIRI4
BXORI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $1458
line 2964
;2964:						mi->freezeView = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 576
ADDP4
CNSTI4 1
ASGNI4
line 2965
;2965:						mi->nextEnemyVisCheck = level.time + 1000 + (LocallySeededRandom(&seed1) % 1000);
ADDRLP4 112
ARGP4
ADDRLP4 152
ADDRGP4 LocallySeededRandom
CALLU4
ASGNU4
ADDRLP4 0
INDIRP4
CNSTI4 592
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDI4
CVIU4 4
ADDRLP4 152
INDIRU4
CNSTU4 1000
MODU4
ADDU4
CVUI4 4
ASGNI4
line 2966
;2966:					}
ADDRGP4 $1457
JUMPV
LABELV $1458
line 2967
;2967:					else {
line 2968
;2968:						vectoangles(dir, mi->ideal_view);
ADDRLP4 56
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 624
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2969
;2969:					}
line 2970
;2970:				}
ADDRGP4 $1457
JUMPV
LABELV $1456
line 2971
;2971:				else if ((mi->ps.eFlags ^ mi->oldEFlags) & EF_TELEPORT_BIT) {
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
BXORI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $1461
line 2972
;2972:					mi->freezeView = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 576
ADDP4
CNSTI4 0
ASGNI4
line 2973
;2973:				}
LABELV $1461
LABELV $1457
line 2974
;2974:				mi->oldEFlags = mi->ps.eFlags;
ADDRLP4 0
INDIRP4
CNSTI4 572
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
ASGNI4
line 2975
;2975:				mi->oldEnemyEFlags = enemyPS->eFlags;
ADDRLP4 0
INDIRP4
CNSTI4 568
ADDP4
ADDRLP4 92
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
ASGNI4
line 2977
;2976:
;2977:				distSqr = VectorLengthSquared(dir);
ADDRLP4 56
ARGP4
ADDRLP4 160
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 108
ADDRLP4 160
INDIRF4
ASGNF4
line 2978
;2978:				VectorCopy(dir, horizDir);
ADDRLP4 96
ADDRLP4 56
INDIRB
ASGNB 12
line 2979
;2979:				horizDir[2] = 0;
ADDRLP4 96+8
CNSTF4 0
ASGNF4
line 2980
;2980:				horizDistSqr = VectorLengthSquared(horizDir);
ADDRLP4 96
ARGP4
ADDRLP4 164
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 128
ADDRLP4 164
INDIRF4
ASGNF4
line 2982
;2981:
;2982:				if (mi->cmd.forwardmove) {
ADDRLP4 0
INDIRP4
CNSTI4 509
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1464
line 2984
;2983:					if (
;2984:						(
ADDRLP4 128
INDIRF4
CNSTF4 1193033728
GEF4 $1471
ADDRLP4 56+8
INDIRF4
CNSTF4 1099956224
GTF4 $1470
LABELV $1471
ADDRLP4 112
ARGP4
ADDRLP4 172
ADDRGP4 local_random
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ARGP4
ADDRLP4 176
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 176
INDIRF4
CNSTF4 1120403456
GEF4 $1472
ADDRLP4 168
CNSTF4 1045220557
ASGNF4
ADDRGP4 $1473
JUMPV
LABELV $1472
ADDRLP4 168
CNSTF4 1008981770
ASGNF4
LABELV $1473
ADDRLP4 172
INDIRF4
ADDRLP4 168
INDIRF4
GEF4 $1466
LABELV $1470
ADDRLP4 92
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1023
EQI4 $1466
ADDRLP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1466
line 2993
;2985:							(
;2986:								horizDistSqr < Square(200.0f) &&
;2987:								dir[2] > /*STEPSIZE*/18.0f
;2988:							) ||
;2989:							local_random(&seed1) < (VectorLengthSquared(mi->ps.velocity) < 100.0f? 0.2f : 0.01f)
;2990:						) &&
;2991:						enemyPS->groundEntityNum != ENTITYNUM_NONE &&
;2992:						!mi->freezeView
;2993:					) {
line 2994
;2994:						mi->cmd.upmove = 127;
ADDRLP4 0
INDIRP4
CNSTI4 511
ADDP4
CNSTI1 127
ASGNI1
line 2995
;2995:					}
ADDRGP4 $1467
JUMPV
LABELV $1466
line 2996
;2996:					else if (mi->ps.groundEntityNum != ENTITYNUM_NONE) {
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 1023
EQI4 $1474
line 2999
;2997:						trace_t trace;
;2998:
;2999:						AngleVectors(mi->ps.viewangles, dir, NULL, NULL);
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
ARGP4
ADDRLP4 56
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 3000
;3000:						VectorMA(mi->ps.origin, 0.2f * g_speed.value, dir, start);
ADDRLP4 68
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 56
INDIRF4
ADDRGP4 g_speed+8
INDIRF4
CNSTF4 1045220557
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 68+4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 56+4
INDIRF4
ADDRGP4 g_speed+8
INDIRF4
CNSTF4 1045220557
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 68+8
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 56+8
INDIRF4
ADDRGP4 g_speed+8
INDIRF4
CNSTF4 1045220557
MULF4
MULF4
ADDF4
ASGNF4
line 3001
;3001:						VectorCopy(start, end);
ADDRLP4 80
ADDRLP4 68
INDIRB
ASGNB 12
line 3002
;3002:						end[2] -= 100.0f;
ADDRLP4 80+8
ADDRLP4 80+8
INDIRF4
CNSTF4 1120403456
SUBF4
ASGNF4
line 3003
;3003:						trap_Trace(&trace, start, NULL, NULL, end, -1, MASK_PLAYERSOLID & ~CONTENTS_BODY);
ADDRLP4 180
ARGP4
ADDRLP4 68
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 80
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 65537
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 3004
;3004:						if (trace.fraction >= 1.0f) {
ADDRLP4 180+8
INDIRF4
CNSTF4 1065353216
LTF4 $1484
line 3005
;3005:							mi->cmd.upmove = 127;
ADDRLP4 0
INDIRP4
CNSTI4 511
ADDP4
CNSTI1 127
ASGNI1
line 3016
;3006:							/*
;3007:							if (horizDistSqr > Square(400)) {
;3008:								VectorCopy(start, end);
;3009:								end[2] += 200;
;3010:								trap_Trace(&trace, start, NULL, NULL, end, -1, MASK_PLAYERSOLID & ~CONTENTS_BODY);
;3011:								if (trace.fraction >= 1) {
;3012:									mi->superJump = qtrue;
;3013:								}
;3014:							}
;3015:							*/
;3016:						}
LABELV $1484
line 3017
;3017:					}
LABELV $1474
LABELV $1467
line 3018
;3018:				}
LABELV $1464
line 3020
;3019:
;3020:				if (distSqr < Square(200.0f)) {
ADDRLP4 108
INDIRF4
CNSTF4 1193033728
GEF4 $1487
line 3023
;3021:					float viewDiff;
;3022:
;3023:					mi->cmd.buttons |= BUTTON_ATTACK;
ADDRLP4 172
ADDRLP4 0
INDIRP4
CNSTI4 504
ADDP4
ASGNP4
ADDRLP4 172
INDIRP4
ADDRLP4 172
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 3025
;3024:					// prevent titan from orbitting the enemy
;3025:					viewDiff = fabs(AngleSubtract(mi->ps.viewangles[YAW], mi->ideal_view[YAW]));
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 628
ADDP4
INDIRF4
ARGF4
ADDRLP4 180
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 180
INDIRF4
ARGF4
ADDRLP4 184
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 168
ADDRLP4 184
INDIRF4
ASGNF4
line 3026
;3026:					if (viewDiff > 60.0f) viewDiff = 60.0f;
ADDRLP4 168
INDIRF4
CNSTF4 1114636288
LEF4 $1489
ADDRLP4 168
CNSTF4 1114636288
ASGNF4
LABELV $1489
line 3027
;3027:					mi->cmd.forwardmove = 127 - 2 * viewDiff;
ADDRLP4 0
INDIRP4
CNSTI4 509
ADDP4
CNSTF4 1123942400
ADDRLP4 168
INDIRF4
CNSTF4 1073741824
MULF4
SUBF4
CVFI4 4
CVII1 4
ASGNI1
line 3028
;3028:				}
ADDRGP4 $1342
JUMPV
LABELV $1487
line 3030
;3029:				else if (
;3030:					!mi->freezeView &&
ADDRLP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1342
ADDRLP4 0
INDIRP4
CNSTI4 509
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1342
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ARGP4
ADDRLP4 172
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 172
INDIRF4
CNSTF4 1185925120
GEF4 $1342
line 3034
;3031:					// titan doesn't dodge, only tries to walk around obstacles
;3032:					mi->cmd.forwardmove &&
;3033:					VectorLengthSquared(mi->ps.velocity) < Square(150.0f)
;3034:				) {
line 3035
;3035:					if (mi->nextDodgeTime <= level.time) {
ADDRLP4 0
INDIRP4
CNSTI4 584
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
GTI4 $1493
line 3036
;3036:						mi->nextDodgeTime = level.time + 500 + (LocallySeededRandom(&seed2) % 1000);
ADDRLP4 132
ARGP4
ADDRLP4 176
ADDRGP4 LocallySeededRandom
CALLU4
ASGNU4
ADDRLP4 0
INDIRP4
CNSTI4 584
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 500
ADDI4
CVIU4 4
ADDRLP4 176
INDIRU4
CNSTU4 1000
MODU4
ADDU4
CVUI4 4
ASGNI4
line 3038
;3037:
;3038:						mi->dodgeDir = 32 + (LocallySeededRandom(&seed2) & 63);
ADDRLP4 132
ARGP4
ADDRLP4 180
ADDRGP4 LocallySeededRandom
CALLU4
ASGNU4
ADDRLP4 0
INDIRP4
CNSTI4 588
ADDP4
ADDRLP4 180
INDIRU4
CNSTU4 63
BANDU4
CNSTU4 32
ADDU4
CVUI4 4
ASGNI4
line 3039
;3039:						if (LocallySeededRandom(&seed2) & 1) mi->dodgeDir = -mi->dodgeDir;
ADDRLP4 132
ARGP4
ADDRLP4 184
ADDRGP4 LocallySeededRandom
CALLU4
ASGNU4
ADDRLP4 184
INDIRU4
CNSTU4 1
BANDU4
CNSTU4 0
EQU4 $1497
ADDRLP4 0
INDIRP4
CNSTI4 588
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 588
ADDP4
INDIRI4
NEGI4
ASGNI4
LABELV $1497
line 3040
;3040:					}
LABELV $1493
line 3041
;3041:					mi->cmd.rightmove = mi->dodgeDir;
ADDRLP4 0
INDIRP4
CNSTI4 510
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 588
ADDP4
INDIRI4
CVII1 4
ASGNI1
line 3042
;3042:				}
line 3043
;3043:			}
line 3044
;3044:			break;
line 3047
;3045:
;3046:		default:
;3047:			break;
LABELV $1342
line 3049
;3048:		}
;3049:		SearchMonsterEnemy(monster, &seed);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 SearchMonsterEnemy
CALLV
pop
line 3055
;3050:		/*
;3051:		if (monster->health < 0.25f * mi->ps.stats[STAT_MAX_HEALTH]) {
;3052:			mi->action = MA_escaping;
;3053:		}
;3054:		*/
;3055:		break;
ADDRGP4 $1289
JUMPV
LABELV $1499
line 3098
;3056:	/*
;3057:	case MA_escaping:
;3058:		if (
;3059:			mi->lastHurtEntity &&
;3060:			mi->lastHurtEntity != mi->enemy &&
;3061:			mi->lastHurtTime > level.time - 1000 &&
;3062:			mi->lastHurtEntity->health > 0 &&
;3063:			mi->lastEnemyHitTime < level.time - 500
;3064:		) {
;3065:			SetMonsterEnemy(mi, mi->lastHurtEntity);
;3066:		}
;3067:		mi->cmd.forwardmove = -127;
;3068:		{
;3069:			vec3_t start, end;
;3070:			vec3_t dir;
;3071:			vec_t angleDiff;
;3072:
;3073:			VectorCopy(mi->ps.origin, start);
;3074:			start[2] += mi->ps.viewheight;
;3075:			VectorCopy(mi->enemy->client->ps.origin, end);
;3076:			end[2] += mi->enemy->client->ps.viewheight;
;3077:			VectorSubtract(end, start, dir);
;3078:			vectoangles(dir, mi->ideal_view);
;3079:
;3080:			angleDiff = AngleSubtract(mi->ideal_view[YAW] + 180.0f, mi->enemy->client->ps.viewangles[YAW]);
;3081:			if (angleDiff > 0) {
;3082:				mi->cmd.rightmove = 127;
;3083:			}
;3084:			else {
;3085:				mi->cmd.rightmove = -127;
;3086:			}
;3087:
;3088:			if (VectorLengthSquared(dir) < Square(100.0f)) {
;3089:				mi->cmd.buttons |= BUTTON_ATTACK;
;3090:			}
;3091:		}
;3092:		if (monster->health > 0.75f * mi->ps.stats[STAT_MAX_HEALTH]) {
;3093:			mi->action = MA_attacking;
;3094:		}
;3095:		break;
;3096:	*/
;3097:	case MA_panic:
;3098:		mi->hibernationTime = 0;
ADDRLP4 0
INDIRP4
CNSTI4 664
ADDP4
CNSTI4 0
ASGNI4
line 3100
;3099:
;3100:		mi->cmd.forwardmove = 127;
ADDRLP4 0
INDIRP4
CNSTI4 509
ADDP4
CNSTI1 127
ASGNI1
line 3102
;3101:
;3102:		if (mi->nextViewSearch > level.time) break;
ADDRLP4 0
INDIRP4
CNSTI4 596
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $1500
ADDRGP4 $1289
JUMPV
LABELV $1500
line 3103
;3103:		mi->nextViewSearch = level.time + 500 + LocallySeededRandom(&seed) % 1000;
ADDRLP4 4
ARGP4
ADDRLP4 52
ADDRGP4 LocallySeededRandom
CALLU4
ASGNU4
ADDRLP4 0
INDIRP4
CNSTI4 596
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 500
ADDI4
CVIU4 4
ADDRLP4 52
INDIRU4
CNSTU4 1000
MODU4
ADDU4
CVUI4 4
ASGNI4
line 3105
;3104:
;3105:		VectorSet(mi->ideal_view, 0, 360.0f * local_random(&seed), 0);
ADDRLP4 0
INDIRP4
CNSTI4 624
ADDP4
CNSTF4 0
ASGNF4
ADDRLP4 4
ARGP4
ADDRLP4 56
ADDRGP4 local_random
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 628
ADDP4
ADDRLP4 56
INDIRF4
CNSTF4 1135869952
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 632
ADDP4
CNSTF4 0
ASGNF4
line 3106
;3106:		break;
ADDRGP4 $1289
JUMPV
LABELV $1504
line 3109
;3107:
;3108:	case MA_hibernation:	// predator only
;3109:		switch (mi->hibernationPhase) {
ADDRLP4 60
ADDRLP4 0
INDIRP4
CNSTI4 672
ADDP4
INDIRI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
LTI4 $1289
ADDRLP4 60
INDIRI4
CNSTI4 4
GTI4 $1289
ADDRLP4 60
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1574
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1574
address $1508
address $1514
address $1517
address $1525
address $1548
code
LABELV $1508
line 3111
;3110:		case HP_entry:
;3111:			if (mi->ps.viewangles[PITCH] < -85.0f) {
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
CNSTF4 3265921024
GEF4 $1509
line 3112
;3112:				mi->hibernationPhase = HP_morphing;
ADDRLP4 0
INDIRP4
CNSTI4 672
ADDP4
CNSTI4 1
ASGNI4
line 3113
;3113:				mi->hibernationBrood = 0;
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
CNSTI4 0
ASGNI4
line 3114
;3114:				mi->ps.stats[STAT_EFFECT] = PE_hibernation;
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
CNSTI4 3
ASGNI4
line 3115
;3115:				mi->ps.powerups[PW_EFFECT_TIME] = level.time + SPAWNHULL_TIME;
ADDRLP4 0
INDIRP4
CNSTI4 372
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 3116
;3116:				VectorCopy(mi->hibernationSpot, monster->s.origin2);
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 676
ADDP4
INDIRB
ASGNB 12
line 3117
;3117:				monster->s.modelindex |= (
ADDRLP4 68
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRI4
CNSTI4 14
BORI4
ASGNI4
line 3122
;3118:					PFMI_HIBERNATION_MODE |
;3119:					PFMI_HIBERNATION_DRAW_SEED |
;3120:					PFMI_HIBERNATION_DRAW_THREAD
;3121:				);
;3122:			}
ADDRGP4 $1289
JUMPV
LABELV $1509
line 3123
;3123:			else {
line 3124
;3124:				SearchMonsterEnemy(monster, &seed);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 SearchMonsterEnemy
CALLV
pop
line 3125
;3125:				if (monster->enemy) {
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1289
line 3126
;3126:					mi->action = MA_attacking;
ADDRLP4 0
INDIRP4
CNSTI4 548
ADDP4
CNSTI4 2
ASGNI4
line 3127
;3127:				}
line 3128
;3128:			}
line 3129
;3129:			break;
ADDRGP4 $1289
JUMPV
LABELV $1514
line 3131
;3130:		case HP_morphing:
;3131:			if (!mi->ps.powerups[PW_EFFECT_TIME]) {
ADDRLP4 0
INDIRP4
CNSTI4 372
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1289
line 3132
;3132:				mi->hibernationPhase = HP_raising;
ADDRLP4 0
INDIRP4
CNSTI4 672
ADDP4
CNSTI4 2
ASGNI4
line 3133
;3133:				mi->ps.origin[2] += DEFAULT_VIEWHEIGHT;
ADDRLP4 68
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRF4
CNSTF4 1104150528
ADDF4
ASGNF4
line 3134
;3134:				mi->ps.eFlags ^= EF_TELEPORT_BIT;	// prevent lerping
ADDRLP4 72
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 4
BXORI4
ASGNI4
line 3135
;3135:				monster->s.modelindex |= PFMI_HIBERNATION_MORPHED;
ADDRLP4 76
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 3136
;3136:				VectorSet(mi->ps.velocity, 100.0f*crandom(), 100.0f*crandom(), 0);
ADDRLP4 80
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 80
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 80
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
CNSTF4 1120403456
MULF4
ASGNF4
ADDRLP4 84
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 84
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 84
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
CNSTF4 1120403456
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
CNSTF4 0
ASGNF4
line 3137
;3137:				mi->ps.pm_time = 100;
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
CNSTI4 100
ASGNI4
line 3138
;3138:				mi->ps.pm_flags |= PMF_TIME_KNOCKBACK;
ADDRLP4 88
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
line 3139
;3139:			}
line 3140
;3140:			break;
ADDRGP4 $1289
JUMPV
LABELV $1517
line 3142
;3141:		case HP_raising:
;3142:			VectorCopy(mi->hibernationSpot, mi->ps.grapplePoint);
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 676
ADDP4
INDIRB
ASGNB 12
line 3143
;3143:			mi->ps.pm_flags |= PMF_GRAPPLE_PULL;
ADDRLP4 72
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
line 3144
;3144:			mi->ps.stats[STAT_GRAPPLE_SPEED] = 200;
ADDRLP4 0
INDIRP4
CNSTI4 240
ADDP4
CNSTI4 200
ASGNI4
line 3145
;3145:			mi->ps.stats[STAT_GRAPPLE_STATE] = GST_silent;
ADDRLP4 0
INDIRP4
CNSTI4 236
ADDP4
CNSTI4 1
ASGNI4
line 3147
;3146:
;3147:			if ((rand() & 127) == 0) {
ADDRLP4 76
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 127
BANDI4
CNSTI4 0
NEI4 $1518
line 3148
;3148:				mi->ps.velocity[0] += 40.0f * crandom();
ADDRLP4 80
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 84
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRF4
ADDRLP4 80
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 80
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
CNSTF4 1109393408
MULF4
ADDF4
ASGNF4
line 3149
;3149:				mi->ps.velocity[1] += 40.0f * crandom();
ADDRLP4 88
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 92
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRF4
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
CNSTF4 1109393408
MULF4
ADDF4
ASGNF4
line 3150
;3150:			}
LABELV $1518
line 3152
;3151:
;3152:			if (DistanceSquared(mi->ps.origin, mi->hibernationSpot) < Square(100.0f)) {
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 676
ADDP4
ARGP4
ADDRLP4 84
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 84
INDIRF4
CNSTF4 1176256512
GEF4 $1520
line 3153
;3153:				mi->hibernationTime = level.time + 15000 + LocallySeededRandom(&seed) % 30000;
ADDRLP4 4
ARGP4
ADDRLP4 88
ADDRGP4 LocallySeededRandom
CALLU4
ASGNU4
ADDRLP4 0
INDIRP4
CNSTI4 664
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 15000
ADDI4
CVIU4 4
ADDRLP4 88
INDIRU4
CNSTU4 30000
MODU4
ADDU4
CVUI4 4
ASGNI4
line 3154
;3154:				mi->hibernationPhase = HP_sleeping;
ADDRLP4 0
INDIRP4
CNSTI4 672
ADDP4
CNSTI4 3
ASGNI4
line 3155
;3155:			}
LABELV $1520
line 3157
;3156:
;3157:			if (ScanForMonsterEnemy(monster, &seed)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 88
ADDRGP4 ScanForMonsterEnemy
CALLI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 0
EQI4 $1289
line 3158
;3158:				mi->hibernationPhase = HP_falling;
ADDRLP4 0
INDIRP4
CNSTI4 672
ADDP4
CNSTI4 4
ASGNI4
line 3159
;3159:			}
line 3160
;3160:			break;
ADDRGP4 $1289
JUMPV
LABELV $1525
line 3162
;3161:		case HP_sleeping:
;3162:			VectorCopy(mi->hibernationSpot, mi->ps.grapplePoint);
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 676
ADDP4
INDIRB
ASGNB 12
line 3163
;3163:			mi->ps.pm_flags |= PMF_GRAPPLE_PULL;
ADDRLP4 96
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 96
INDIRP4
ADDRLP4 96
INDIRP4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
line 3164
;3164:			mi->ps.stats[STAT_GRAPPLE_SPEED] = (int) (2.0f * Distance(mi->ps.origin, mi->hibernationSpot));
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 676
ADDP4
ARGP4
ADDRLP4 104
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 240
ADDP4
ADDRLP4 104
INDIRF4
CNSTF4 1073741824
MULF4
CVFI4 4
ASGNI4
line 3165
;3165:			mi->ps.stats[STAT_GRAPPLE_STATE] = GST_silent;
ADDRLP4 0
INDIRP4
CNSTI4 236
ADDP4
CNSTI4 1
ASGNI4
line 3167
;3166:
;3167:			if ((rand() & 127) == 0) {
ADDRLP4 108
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 108
INDIRI4
CNSTI4 127
BANDI4
CNSTI4 0
NEI4 $1526
line 3168
;3168:				mi->ps.velocity[0] += 40.0f * crandom();
ADDRLP4 112
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 116
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 116
INDIRP4
ADDRLP4 116
INDIRP4
INDIRF4
ADDRLP4 112
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 112
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
CNSTF4 1109393408
MULF4
ADDF4
ASGNF4
line 3169
;3169:				mi->ps.velocity[1] += 40.0f * crandom();
ADDRLP4 120
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 124
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 124
INDIRP4
ADDRLP4 124
INDIRP4
INDIRF4
ADDRLP4 120
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 120
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
CNSTF4 1109393408
MULF4
ADDF4
ASGNF4
line 3170
;3170:			}
ADDRGP4 $1527
JUMPV
LABELV $1526
line 3172
;3171:			else if (
;3172:				level.artefactCapturedTime &&
ADDRGP4 level+23008
INDIRI4
CNSTI4 0
EQI4 $1528
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+23008
INDIRI4
CNSTI4 15000
ADDI4
GEI4 $1528
line 3174
;3173:				level.time < level.artefactCapturedTime + 15000
;3174:			) {
line 3177
;3175:				float intensity;
;3176:
;3177:				intensity = 10.0f;
ADDRLP4 112
CNSTF4 1092616192
ASGNF4
line 3178
;3178:				if (level.time > level.artefactCapturedTime + 10000) {
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+23008
INDIRI4
CNSTI4 10000
ADDI4
LEI4 $1533
line 3179
;3179:					intensity *= (float)(level.artefactCapturedTime + 15000 - level.time) / 5000.0;
ADDRLP4 112
ADDRLP4 112
INDIRF4
ADDRGP4 level+23008
INDIRI4
CNSTI4 15000
ADDI4
ADDRGP4 level+32
INDIRI4
SUBI4
CVIF4 4
CNSTF4 961656599
MULF4
MULF4
ASGNF4
line 3180
;3180:				}
LABELV $1533
line 3181
;3181:				mi->ps.velocity[0] += intensity * crandom();
ADDRLP4 116
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 120
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 120
INDIRP4
ADDRLP4 120
INDIRP4
INDIRF4
ADDRLP4 112
INDIRF4
ADDRLP4 116
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 116
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
line 3182
;3182:				mi->ps.velocity[1] += intensity * crandom();
ADDRLP4 124
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 128
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 128
INDIRP4
ADDRLP4 128
INDIRP4
INDIRF4
ADDRLP4 112
INDIRF4
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
line 3183
;3183:			}
LABELV $1528
LABELV $1527
line 3186
;3184:
;3185:			if (
;3186:				level.time >= mi->hibernationTime &&
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 664
ADDP4
INDIRI4
LTI4 $1539
ADDRGP4 level+9144
INDIRI4
CNSTI4 0
NEI4 $1539
line 3190
;3187:				!level.intermissiontime /*&&
;3188:				numMonsters < g_maxMonsters.integer &&
;3189:				numMonsters < MAX_MONSTERS*/
;3190:			) {
line 3191
;3191:				mi->hibernationTime = level.time + 15000 + LocallySeededRandom(&seed) % 30000;
ADDRLP4 4
ARGP4
ADDRLP4 112
ADDRGP4 LocallySeededRandom
CALLU4
ASGNU4
ADDRLP4 0
INDIRP4
CNSTI4 664
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 15000
ADDI4
CVIU4 4
ADDRLP4 112
INDIRU4
CNSTU4 30000
MODU4
ADDU4
CVUI4 4
ASGNI4
line 3192
;3192:				mi->hibernationBrood++;
ADDRLP4 116
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
ASGNP4
ADDRLP4 116
INDIRP4
ADDRLP4 116
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3193
;3193:				if (mi->hibernationBrood >= 3) {
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
INDIRI4
CNSTI4 3
LTI4 $1544
line 3194
;3194:					mi->hibernationPhase = HP_falling;
ADDRLP4 0
INDIRP4
CNSTI4 672
ADDP4
CNSTI4 4
ASGNI4
line 3195
;3195:				}
LABELV $1544
line 3196
;3196:			}
LABELV $1539
line 3198
;3197:
;3198:			if (ScanForMonsterEnemy(monster, &seed)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 112
ADDRGP4 ScanForMonsterEnemy
CALLI4
ASGNI4
ADDRLP4 112
INDIRI4
CNSTI4 0
EQI4 $1289
line 3199
;3199:				mi->hibernationPhase = HP_falling;
ADDRLP4 0
INDIRP4
CNSTI4 672
ADDP4
CNSTI4 4
ASGNI4
line 3200
;3200:			}
line 3201
;3201:			break;
ADDRGP4 $1289
JUMPV
LABELV $1548
line 3203
;3202:		case HP_falling:
;3203:			monster->s.modelindex &= ~PFMI_HIBERNATION_DRAW_THREAD;
ADDRLP4 116
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
ASGNP4
ADDRLP4 116
INDIRP4
ADDRLP4 116
INDIRP4
INDIRI4
CNSTI4 -9
BANDI4
ASGNI4
line 3205
;3204:
;3205:			if (mi->enemy) {
ADDRLP4 0
INDIRP4
CNSTI4 556
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1549
line 3209
;3206:				vec3_t origin;
;3207:				vec3_t dir;
;3208:
;3209:				VectorAdd(mi->enemy->r.absmin, mi->enemy->r.absmax, origin);
ADDRLP4 120
ADDRLP4 0
INDIRP4
CNSTI4 556
ADDP4
INDIRP4
CNSTI4 464
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 556
ADDP4
INDIRP4
CNSTI4 476
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 120+4
ADDRLP4 0
INDIRP4
CNSTI4 556
ADDP4
INDIRP4
CNSTI4 468
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 556
ADDP4
INDIRP4
CNSTI4 480
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 120+8
ADDRLP4 0
INDIRP4
CNSTI4 556
ADDP4
INDIRP4
CNSTI4 472
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 556
ADDP4
INDIRP4
CNSTI4 484
ADDP4
INDIRF4
ADDF4
ASGNF4
line 3210
;3210:				VectorScale(origin, 0.5f, origin);
ADDRLP4 120
ADDRLP4 120
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 120+4
ADDRLP4 120+4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 120+8
ADDRLP4 120+8
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 3211
;3211:				VectorSubtract(origin, mi->ps.origin, dir);
ADDRLP4 132
ADDRLP4 120
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 132+4
ADDRLP4 120+4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 132+8
ADDRLP4 120+8
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3212
;3212:				vectoangles(dir, mi->ideal_view);
ADDRLP4 132
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 624
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 3213
;3213:			}
LABELV $1549
line 3215
;3214:
;3215:			if (mi->ps.groundEntityNum != ENTITYNUM_NONE) {
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 1023
EQI4 $1289
line 3220
;3216:				static const vec3_t mins = {-15.0f, -15.0f, -24.0f};
;3217:				static const vec3_t maxs = {15.0f, 15.0f, 32.0f};
;3218:				vec3_t spawnorigin;
;3219:
;3220:				monster->s.modelindex &= ~PFMI_HIBERNATION_DRAW_SEED;
ADDRLP4 132
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
ASGNP4
ADDRLP4 132
INDIRP4
ADDRLP4 132
INDIRP4
INDIRI4
CNSTI4 -5
BANDI4
ASGNI4
line 3222
;3221:
;3222:				if (G_GetMonsterSpawnPoint(mins, maxs, &seed, spawnorigin, MSM_atOrigin, mi->ps.origin)) {
ADDRGP4 $1563
ARGP4
ADDRGP4 $1564
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 120
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
ARGP4
ADDRLP4 136
ADDRGP4 G_GetMonsterSpawnPoint
CALLI4
ASGNI4
ADDRLP4 136
INDIRI4
CNSTI4 0
EQI4 $1565
line 3223
;3223:					G_SetOrigin(monster, spawnorigin);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 120
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 3224
;3224:					VectorCopy(spawnorigin, mi->ps.origin);
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 120
INDIRB
ASGNB 12
line 3225
;3225:					mi->ps.eFlags ^= EF_TELEPORT_BIT;	// prevent lerping
ADDRLP4 140
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
ASGNP4
ADDRLP4 140
INDIRP4
ADDRLP4 140
INDIRP4
INDIRI4
CNSTI4 4
BXORI4
ASGNI4
line 3226
;3226:					monster->s.modelindex &= ~(PFMI_HIBERNATION_MODE | PFMI_HIBERNATION_MORPHED);
ADDRLP4 144
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
ASGNP4
ADDRLP4 144
INDIRP4
ADDRLP4 144
INDIRP4
INDIRI4
CNSTI4 -19
BANDI4
ASGNI4
line 3227
;3227:					mi->ps.stats[STAT_EFFECT] = PE_spawn;
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
CNSTI4 0
ASGNI4
line 3228
;3228:					mi->ps.powerups[PW_EFFECT_TIME] = level.time + SPAWNHULL_TIME;
ADDRLP4 0
INDIRP4
CNSTI4 372
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 3229
;3229:					mi->action = MA_waiting;
ADDRLP4 0
INDIRP4
CNSTI4 548
ADDP4
CNSTI4 0
ASGNI4
line 3230
;3230:					if (mi->enemy) mi->action = MA_attacking;
ADDRLP4 0
INDIRP4
CNSTI4 556
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1568
ADDRLP4 0
INDIRP4
CNSTI4 548
ADDP4
CNSTI4 2
ASGNI4
LABELV $1568
line 3231
;3231:					mi->hibernationWaitTime = 15000 + LocallySeededRandom(&seed) % 30000;
ADDRLP4 4
ARGP4
ADDRLP4 148
ADDRGP4 LocallySeededRandom
CALLU4
ASGNU4
ADDRLP4 0
INDIRP4
CNSTI4 668
ADDP4
ADDRLP4 148
INDIRU4
CNSTU4 30000
MODU4
CNSTU4 15000
ADDU4
CVUI4 4
ASGNI4
line 3232
;3232:					mi->hibernationTime = level.time + mi->hibernationWaitTime;
ADDRLP4 0
INDIRP4
CNSTI4 664
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 668
ADDP4
INDIRI4
ADDI4
ASGNI4
line 3234
;3233:					if (
;3234:						mi->hibernationBrood > 0 &&
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1289
ADDRLP4 156
ADDRGP4 numMonsters
INDIRI4
ASGNI4
ADDRLP4 156
INDIRI4
ADDRGP4 g_maxMonsters+12
INDIRI4
GEI4 $1289
ADDRLP4 156
INDIRI4
CNSTI4 200
GEI4 $1289
line 3237
;3235:						numMonsters < g_maxMonsters.integer &&
;3236:						numMonsters < MAX_MONSTERS
;3237:					) {
line 3238
;3238:						G_ReleaseTrap(mi->hibernationBrood, spawnorigin);
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
INDIRI4
ARGI4
ADDRLP4 120
ARGP4
ADDRGP4 G_ReleaseTrap
CALLV
pop
line 3239
;3239:					}
line 3240
;3240:				}
ADDRGP4 $1289
JUMPV
LABELV $1565
line 3241
;3241:				else {
line 3242
;3242:					G_KillMonster(monster);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_KillMonster
CALLV
pop
line 3243
;3243:				}
line 3244
;3244:			}
line 3245
;3245:			break;
line 3247
;3246:		}
;3247:		break;
ADDRGP4 $1289
JUMPV
LABELV $1575
line 3251
;3248:
;3249:	case MA_sleeping:	// titan only
;3250:		if (
;3251:			mi->lastHurtEntity ||
ADDRLP4 0
INDIRP4
CNSTI4 640
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1578
ADDRLP4 0
INDIRP4
CNSTI4 652
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1289
LABELV $1578
line 3253
;3252:			mi->avoidPlayer
;3253:		) {
line 3254
;3254:			mi->action = MA_waiting;
ADDRLP4 0
INDIRP4
CNSTI4 548
ADDP4
CNSTI4 0
ASGNI4
line 3256
;3255:
;3256:			mi->ps.stats[STAT_EFFECT] = PE_titan_awaking;
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
CNSTI4 4
ASGNI4
line 3257
;3257:			mi->ps.powerups[PW_EFFECT_TIME] = level.time + SPAWNHULL_TIME;
ADDRLP4 0
INDIRP4
CNSTI4 372
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 3258
;3258:		}
line 3259
;3259:		break;
LABELV $1288
LABELV $1289
line 3261
;3260:	}
;3261:}
LABELV $1263
endproc MonsterAI 240 28
export IsFightingMonster
proc IsFightingMonster 0 0
line 3270
;3262:#endif
;3263:
;3264:/*
;3265:===============
;3266:JUHOX: IsFightingMonster
;3267:===============
;3268:*/
;3269:#if MONSTER_MODE
;3270:qboolean IsFightingMonster(gentity_t* ent) {
line 3271
;3271:	if (!ent->monster) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1582
CNSTI4 0
RETI4
ADDRGP4 $1581
JUMPV
LABELV $1582
line 3272
;3272:	if (ent->monster->action != MA_attacking) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
CNSTI4 2
EQI4 $1584
CNSTI4 0
RETI4
ADDRGP4 $1581
JUMPV
LABELV $1584
line 3273
;3273:	if (ent->monster->enemyFoundTime > level.time - 350) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 350
SUBI4
LEI4 $1586
CNSTI4 0
RETI4
ADDRGP4 $1581
JUMPV
LABELV $1586
line 3274
;3274:	return qtrue;
CNSTI4 1
RETI4
LABELV $1581
endproc IsFightingMonster 0 0
export CheckTouchedMonsters
proc CheckTouchedMonsters 28 0
line 3284
;3275:}
;3276:#endif
;3277:
;3278:/*
;3279:===============
;3280:JUHOX: CheckTouchedMonsters
;3281:===============
;3282:*/
;3283:#if MONSTER_MODE
;3284:void CheckTouchedMonsters(pmove_t* pm) {
line 3287
;3285:	int i;
;3286:
;3287:	for (i = 0; i < pm->numtouch; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1593
JUMPV
LABELV $1590
line 3291
;3288:		int te;
;3289:		gmonster_t* mi;
;3290:
;3291:		te = pm->touchents[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 84
ADDP4
ADDP4
INDIRI4
ASGNI4
line 3292
;3292:		if (te < 0 || te >= ENTITYNUM_WORLD) continue;
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $1596
ADDRLP4 4
INDIRI4
CNSTI4 1022
LTI4 $1594
LABELV $1596
ADDRGP4 $1591
JUMPV
LABELV $1594
line 3293
;3293:		if (!g_entities[te].inuse) continue;
ADDRLP4 4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1597
ADDRGP4 $1591
JUMPV
LABELV $1597
line 3294
;3294:		mi = g_entities[te].monster;
ADDRLP4 8
ADDRLP4 4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+520
ADDP4
INDIRP4
ASGNP4
line 3295
;3295:		if (!mi) continue;
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1601
ADDRGP4 $1591
JUMPV
LABELV $1601
line 3297
;3296:
;3297:		switch (mi->type) {
ADDRLP4 16
ADDRLP4 8
INDIRP4
CNSTI4 476
ADDP4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $1606
ADDRLP4 16
INDIRI4
CNSTI4 1
EQI4 $1604
ADDRLP4 16
INDIRI4
CNSTI4 2
EQI4 $1606
ADDRGP4 $1604
JUMPV
LABELV $1606
line 3300
;3298:		case MT_predator:
;3299:		case MT_titan:
;3300:			mi->avoidPlayer = pm->ps;
ADDRLP4 8
INDIRP4
CNSTI4 652
ADDP4
ADDRFP4 0
INDIRP4
INDIRP4
ASGNP4
line 3301
;3301:			mi->startAvoidPlayerTime = level.time;
ADDRLP4 8
INDIRP4
CNSTI4 656
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 3302
;3302:			mi->stopAvoidPlayerTime = level.time + 500 + rand() % 700;
ADDRLP4 24
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 660
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 500
ADDI4
ADDRLP4 24
INDIRI4
CNSTI4 700
MODI4
ADDI4
ASGNI4
line 3303
;3303:			break;
line 3305
;3304:		case MT_guard:
;3305:			break;
line 3307
;3306:		default:
;3307:			break;
LABELV $1604
line 3309
;3308:		}
;3309:	}
LABELV $1591
line 3287
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1593
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
LTI4 $1590
line 3310
;3310:}
LABELV $1589
endproc CheckTouchedMonsters 28 0
proc ThinkMonster 328 32
line 3321
;3311:#endif
;3312:
;3313:/*
;3314:===============
;3315:JUHOX: ThinkMonster
;3316:
;3317:derived from ClientThink_real() [g_active.c]
;3318:===============
;3319:*/
;3320:#if MONSTER_MODE
;3321:static void ThinkMonster(gentity_t* monster) {
line 3328
;3322:	gmonster_t* mi;
;3323:	usercmd_t* ucmd;
;3324:	int msec;
;3325:	pmove_t pm;
;3326:	int oldEventSequence;
;3327:
;3328:	mi = monster->monster;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
ASGNP4
line 3329
;3329:	if (!mi) return;
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1611
ADDRGP4 $1610
JUMPV
LABELV $1611
line 3331
;3330:
;3331:	if (mi->removeTime && level.time >= mi->removeTime) {
ADDRLP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1613
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
LTI4 $1613
line 3334
;3332:		gentity_t* tent;
;3333:
;3334:		tent = G_TempEntity(mi->ps.origin, EV_PLAYER_TELEPORT_OUT);
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
ARGP4
CNSTI4 43
ARGI4
ADDRLP4 288
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 284
ADDRLP4 288
INDIRP4
ASGNP4
line 3335
;3335:		if (tent) tent->s.clientNum = monster->s.clientNum;
ADDRLP4 284
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1616
ADDRLP4 284
INDIRP4
CNSTI4 168
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
LABELV $1616
line 3336
;3336:		G_FreeMonster(monster);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeMonster
CALLV
pop
line 3337
;3337:		return;
ADDRGP4 $1610
JUMPV
LABELV $1613
line 3340
;3338:	}
;3339:
;3340:	if (mi->nextHealthRefresh <= level.time && monster->health > 0) {
ADDRLP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
GTI4 $1618
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1618
line 3341
;3341:		mi->nextHealthRefresh = level.time + 200;
ADDRLP4 0
INDIRP4
CNSTI4 536
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 200
ADDI4
ASGNI4
line 3344
;3342:
;3343:		if (
;3344:			monster->health < mi->ps.stats[STAT_MAX_HEALTH] &&
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
GEI4 $1622
ADDRLP4 0
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1622
line 3346
;3345:			!mi->ps.stats[PW_CHARGE]
;3346:		) {
line 3347
;3347:			monster->health++;
ADDRLP4 288
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
ASGNP4
ADDRLP4 288
INDIRP4
ADDRLP4 288
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3348
;3348:		}
LABELV $1622
line 3349
;3349:	}
LABELV $1618
line 3350
;3350:	mi->ps.stats[STAT_HEALTH] = monster->health;
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
ASGNI4
line 3352
;3351:
;3352:	MonsterAI(monster);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 MonsterAI
CALLV
pop
line 3353
;3353:	if (!monster->inuse) return;
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1624
ADDRGP4 $1610
JUMPV
LABELV $1624
line 3355
;3354:
;3355:	ucmd = &mi->cmd;
ADDRLP4 276
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
ASGNP4
line 3356
;3356:	msec = ucmd->serverTime - mi->ps.commandTime;
ADDRLP4 272
ADDRLP4 276
INDIRP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
SUBI4
ASGNI4
line 3357
;3357:	if (msec < 1) goto Exit;
ADDRLP4 272
INDIRI4
CNSTI4 1
GEI4 $1626
ADDRGP4 $1628
JUMPV
LABELV $1626
line 3358
;3358:	if (msec > 200) msec = 200;
ADDRLP4 272
INDIRI4
CNSTI4 200
LEI4 $1629
ADDRLP4 272
CNSTI4 200
ASGNI4
LABELV $1629
line 3360
;3359:
;3360:	if (monster->health <= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
GTI4 $1631
line 3361
;3361:		mi->ps.pm_type = PM_DEAD;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 3
ASGNI4
line 3363
;3362:
;3363:		if (mi->timeOfBodyCopying && level.time >= mi->timeOfBodyCopying) {
ADDRLP4 0
INDIRP4
CNSTI4 648
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1632
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 648
ADDP4
INDIRI4
LTI4 $1632
line 3364
;3364:			CopyToBodyQue(monster);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CopyToBodyQue
CALLV
pop
line 3365
;3365:			G_FreeMonster(monster);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeMonster
CALLV
pop
line 3366
;3366:			return;
ADDRGP4 $1610
JUMPV
line 3368
;3367:		}
;3368:	}
LABELV $1631
line 3369
;3369:	else {
line 3370
;3370:		mi->ps.pm_type = PM_NORMAL;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 3371
;3371:	}
LABELV $1632
line 3373
;3372:
;3373:	mi->ps.gravity = g_gravity.integer;
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
ADDRGP4 g_gravity+12
INDIRI4
ASGNI4
line 3374
;3374:	mi->ps.speed = g_speed.integer;
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
ADDRGP4 g_speed+12
INDIRI4
ASGNI4
line 3376
;3375:
;3376:	CheckPlayerDischarge(monster);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CheckPlayerDischarge
CALLV
pop
line 3378
;3377:
;3378:	oldEventSequence = mi->ps.eventSequence;
ADDRLP4 268
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
ASGNI4
line 3380
;3379:
;3380:	memset(&pm, 0, sizeof(pm));
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 264
ARGI4
ADDRGP4 memset
CALLP4
pop
line 3382
;3381:
;3382:	pm.ps = &mi->ps;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
line 3383
;3383:	pm.cmd = *ucmd;
ADDRLP4 4+4
ADDRLP4 276
INDIRP4
INDIRB
ASGNB 24
line 3384
;3384:	if (pm.ps->pm_type == PM_DEAD) {
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1639
line 3385
;3385:		pm.tracemask = MASK_PLAYERSOLID & ~CONTENTS_BODY;
ADDRLP4 4+28
CNSTI4 65537
ASGNI4
line 3386
;3386:	}
ADDRGP4 $1640
JUMPV
LABELV $1639
line 3387
;3387:	else {
line 3388
;3388:		pm.tracemask = MASK_PLAYERSOLID;
ADDRLP4 4+28
CNSTI4 33619969
ASGNI4
line 3389
;3389:	}
LABELV $1640
line 3390
;3390:	pm.trace = trap_Trace;
ADDRLP4 4+256
ADDRGP4 trap_Trace
ASGNP4
line 3391
;3391:	pm.pointcontents = trap_PointContents;
ADDRLP4 4+260
ADDRGP4 trap_PointContents
ASGNP4
line 3392
;3392:	pm.debugLevel = g_debugMove.integer;
ADDRLP4 4+32
ADDRGP4 g_debugMove+12
INDIRI4
ASGNI4
line 3393
;3393:	pm.noFootsteps = (g_dmflags.integer & DF_NO_FOOTSTEPS) != 0;
ADDRGP4 g_dmflags+12
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $1650
ADDRLP4 284
CNSTI4 1
ASGNI4
ADDRGP4 $1651
JUMPV
LABELV $1650
ADDRLP4 284
CNSTI4 0
ASGNI4
LABELV $1651
ADDRLP4 4+36
ADDRLP4 284
INDIRI4
ASGNI4
line 3395
;3394:
;3395:	switch (mi->type) {
ADDRLP4 288
ADDRLP4 0
INDIRP4
CNSTI4 476
ADDP4
INDIRI4
ASGNI4
ADDRLP4 288
INDIRI4
CNSTI4 0
EQI4 $1655
ADDRLP4 288
INDIRI4
CNSTI4 1
EQI4 $1664
ADDRLP4 288
INDIRI4
CNSTI4 2
EQI4 $1666
ADDRGP4 $1652
JUMPV
LABELV $1655
LABELV $1652
line 3398
;3396:	case MT_predator:
;3397:	default:
;3398:		pm.scale = 1;
ADDRLP4 4+68
CNSTF4 1065353216
ASGNF4
line 3399
;3399:		pm.hookMode = HM_combat;
ADDRLP4 4+60
CNSTI4 4
ASGNI4
line 3400
;3400:		if (monster->s.modelindex & PFMI_HIBERNATION_MORPHED) {
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1658
line 3401
;3401:			pm.hibernation = qtrue;
ADDRLP4 4+76
CNSTI4 1
ASGNI4
line 3402
;3402:		}
LABELV $1658
line 3404
;3403:		if (
;3404:			(ucmd->buttons & BUTTON_ATTACK) &&
ADDRLP4 276
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1653
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 0
GTI4 $1653
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1653
line 3407
;3405:			mi->ps.weaponTime <= 0 &&
;3406:			monster->health > 0
;3407:		) {
line 3408
;3408:			pm.gauntletHit = CheckGauntletAttack(monster);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
ADDRGP4 CheckGauntletAttack
CALLI4
ASGNI4
ADDRLP4 4+40
ADDRLP4 296
INDIRI4
ASGNI4
line 3409
;3409:		}
line 3410
;3410:		break;
ADDRGP4 $1653
JUMPV
LABELV $1664
line 3412
;3411:	case MT_guard:
;3412:		pm.scale = MONSTER_GUARD_SCALE;
ADDRLP4 4+68
CNSTF4 1073741824
ASGNF4
line 3413
;3413:		break;
ADDRGP4 $1653
JUMPV
LABELV $1666
line 3415
;3414:	case MT_titan:
;3415:		pm.scale = MONSTER_TITAN_SCALE;
ADDRLP4 4+68
CNSTF4 1080033280
ASGNF4
line 3416
;3416:		mi->ps.speed = (int) (2.0f * g_speed.integer);
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
ADDRGP4 g_speed+12
INDIRI4
CVIF4 4
CNSTF4 1073741824
MULF4
CVFI4 4
ASGNI4
line 3418
;3417:		if (
;3418:			(ucmd->buttons & BUTTON_ATTACK) &&
ADDRLP4 276
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1653
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 0
GTI4 $1653
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1653
line 3421
;3419:			mi->ps.weaponTime <= 0 &&
;3420:			monster->health > 0
;3421:		) {
line 3422
;3422:			pm.gauntletHit = CheckTitanAttack(monster);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
ADDRGP4 CheckTitanAttack
CALLI4
ASGNI4
ADDRLP4 4+40
ADDRLP4 296
INDIRI4
ASGNI4
line 3423
;3423:		}
line 3424
;3424:		break;
LABELV $1653
line 3427
;3425:	}
;3426:
;3427:	pm.gametype = g_gametype.integer;
ADDRLP4 4+64
ADDRGP4 g_gametype+12
INDIRI4
ASGNI4
line 3429
;3428:
;3429:	pm.pmove_fixed = qtrue;
ADDRLP4 4+248
CNSTI4 1
ASGNI4
line 3430
;3430:	pm.pmove_msec = 10000;
ADDRLP4 4+252
CNSTI4 10000
ASGNI4
line 3431
;3431:	Pmove(&pm);
ADDRLP4 4
ARGP4
ADDRGP4 Pmove
CALLV
pop
line 3433
;3432:
;3433:	mi->ps.stats[STAT_STRENGTH] = MAX_STRENGTH_VALUE;
ADDRLP4 0
INDIRP4
CNSTI4 220
ADDP4
CNSTI4 18000
ASGNI4
line 3434
;3434:	mi->ps.stats[STAT_TARGET] = -1;
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
CNSTI4 -1
ASGNI4
line 3436
;3435:
;3436:	if (mi->ps.eventSequence != oldEventSequence) {
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
ADDRLP4 268
INDIRI4
EQI4 $1676
line 3437
;3437:		monster->eventTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 556
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 3438
;3438:	}
LABELV $1676
line 3439
;3439:	BG_PlayerStateToEntityState(&mi->ps, &monster->s, qtrue);
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BG_PlayerStateToEntityState
CALLV
pop
line 3440
;3440:	G_MonsterCorrectEntityState(monster);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_MonsterCorrectEntityState
CALLV
pop
line 3442
;3441:
;3442:	VectorCopy(monster->s.pos.trBase, monster->r.currentOrigin);
ADDRLP4 296
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 296
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 296
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 3444
;3443:
;3444:	VectorCopy(pm.mins, monster->r.mins);
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
ADDRLP4 4+212
INDIRB
ASGNB 12
line 3445
;3445:	VectorCopy(pm.maxs, monster->r.maxs);
ADDRFP4 0
INDIRP4
CNSTI4 448
ADDP4
ADDRLP4 4+224
INDIRB
ASGNB 12
line 3447
;3446:
;3447:	monster->waterlevel = pm.waterlevel;
ADDRFP4 0
INDIRP4
CNSTI4 792
ADDP4
ADDRLP4 4+240
INDIRI4
ASGNI4
line 3448
;3448:	monster->watertype = pm.watertype;
ADDRFP4 0
INDIRP4
CNSTI4 788
ADDP4
ADDRLP4 4+236
INDIRI4
ASGNI4
line 3450
;3449:
;3450:	MonsterEvents(monster, oldEventSequence);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 268
INDIRI4
ARGI4
ADDRGP4 MonsterEvents
CALLV
pop
line 3451
;3451:	CauseMonsterChargeDamage(monster);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CauseMonsterChargeDamage
CALLV
pop
line 3453
;3452:
;3453:	trap_LinkEntity(monster);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 3455
;3454:
;3455:	MonsterTouchTriggers(monster);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 MonsterTouchTriggers
CALLV
pop
line 3457
;3456:
;3457:	VectorCopy(mi->ps.origin, monster->r.currentOrigin);
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRB
ASGNB 12
line 3460
;3458:
;3459:	// touch other objects
;3460:	ClientImpacts(monster, &pm);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 ClientImpacts
CALLV
pop
line 3463
;3461:
;3462:	// save results of triggers and client events
;3463:	if (mi->ps.eventSequence != oldEventSequence) {
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
ADDRLP4 268
INDIRI4
EQI4 $1683
line 3464
;3464:		monster->eventTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 556
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 3465
;3465:	}
LABELV $1683
line 3468
;3466:
;3467:	// turn off expired powerups
;3468:	if (mi->ps.powerups[PW_CHARGE] < level.time) mi->ps.powerups[PW_CHARGE] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 360
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
GEI4 $1686
ADDRLP4 0
INDIRP4
CNSTI4 360
ADDP4
CNSTI4 0
ASGNI4
LABELV $1686
line 3469
;3469:	if (mi->ps.powerups[PW_EFFECT_TIME] < level.time) mi->ps.powerups[PW_EFFECT_TIME] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 372
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
GEI4 $1689
ADDRLP4 0
INDIRP4
CNSTI4 372
ADDP4
CNSTI4 0
ASGNI4
LABELV $1689
line 3473
;3470:
;3471:	// spawn pool
;3472:	if (
;3473:		g_gametype.integer == GT_STU &&
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
NEI4 $1692
ADDRGP4 g_gameSeed+12
INDIRI4
CNSTI4 0
NEI4 $1692
ADDRLP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1692
ADDRLP4 0
INDIRP4
CNSTI4 608
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
GTI4 $1692
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 1022
NEI4 $1692
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1692
line 3479
;3474:		g_gameSeed.integer == 0 &&
;3475:		mi->action == MA_waiting &&
;3476:		mi->nextSpawnPoolCheck <= level.time &&
;3477:		mi->ps.groundEntityNum == ENTITYNUM_WORLD &&
;3478:		mi->ps.stats[STAT_HEALTH] > 0
;3479:	) {
line 3480
;3480:		mi->nextSpawnPoolCheck = level.time + 1000 + rand() % 1000;
ADDRLP4 304
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 608
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDI4
ADDRLP4 304
INDIRI4
CNSTI4 1000
MODI4
ADDI4
ASGNI4
line 3481
;3481:		if (DistanceSquared(mi->ps.origin, mi->lastCheckedSpawnPos) > Square(10.0f)) {
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 612
ADDP4
ARGP4
ADDRLP4 312
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 312
INDIRF4
CNSTF4 1120403456
LEF4 $1698
line 3482
;3482:			CheckMonsterSpawnPoolEntry(mi->ps.origin);
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
ARGP4
ADDRGP4 CheckMonsterSpawnPoolEntry
CALLV
pop
line 3483
;3483:			VectorCopy(mi->ps.origin, mi->lastCheckedSpawnPos);
ADDRLP4 0
INDIRP4
CNSTI4 612
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRB
ASGNB 12
line 3484
;3484:		}
LABELV $1698
line 3485
;3485:	}
LABELV $1692
line 3489
;3486:
;3487:	// world effects
;3488:	if (
;3489:		(
ADDRLP4 0
INDIRP4
CNSTI4 476
ADDP4
INDIRI4
CNSTI4 1
EQI4 $1702
ADDRLP4 0
INDIRP4
CNSTI4 476
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1700
LABELV $1702
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 0
LTI4 $1700
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 1022
GEI4 $1700
line 3495
;3490:			mi->type == MT_guard ||
;3491:			mi->type == MT_titan
;3492:		) &&
;3493:		mi->ps.groundEntityNum >= 0 &&
;3494:		mi->ps.groundEntityNum < ENTITYNUM_WORLD
;3495:	) {
line 3499
;3496:		gentity_t* ent;
;3497:		playerState_t* ps;
;3498:
;3499:		ent = &g_entities[mi->ps.groundEntityNum];
ADDRLP4 316
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 3500
;3500:		ps = G_GetEntityPlayerState(ent);
ADDRLP4 316
INDIRP4
ARGP4
ADDRLP4 320
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 312
ADDRLP4 320
INDIRP4
ASGNP4
line 3502
;3501:		if (
;3502:			ps &&
ADDRLP4 324
ADDRLP4 312
INDIRP4
ASGNP4
ADDRLP4 324
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1703
ADDRLP4 324
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 0
LTI4 $1703
ADDRLP4 324
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1022
GTI4 $1703
line 3505
;3503:			ps->groundEntityNum >= 0 &&
;3504:			ps->groundEntityNum <= ENTITYNUM_WORLD
;3505:		) {
line 3506
;3506:			G_Damage(ent, NULL, monster, NULL, NULL, 100000, 0, MOD_CRUSH);
ADDRLP4 316
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTI4 100000
ARGI4
CNSTI4 0
ARGI4
CNSTI4 22
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 3507
;3507:		}
LABELV $1703
line 3508
;3508:	}
LABELV $1700
line 3510
;3509:	if (
;3510:		monster->waterlevel &&
ADDRLP4 312
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 312
INDIRP4
CNSTI4 792
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1705
ADDRLP4 312
INDIRP4
CNSTI4 788
ADDP4
INDIRI4
CNSTI4 24
BANDI4
CNSTI4 0
EQI4 $1705
ADDRLP4 312
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1705
ADDRLP4 312
INDIRP4
CNSTI4 724
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
GTI4 $1705
line 3514
;3511:		(monster->watertype & (CONTENTS_LAVA|CONTENTS_SLIME)) &&
;3512:		monster->health > 0 &&
;3513:		monster->pain_debounce_time <= level.time
;3514:	) {
line 3515
;3515:		if (monster->watertype & CONTENTS_LAVA) {
ADDRFP4 0
INDIRP4
CNSTI4 788
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $1708
line 3516
;3516:			G_Damage(monster, NULL, NULL, NULL, NULL, 30*monster->waterlevel, 0, MOD_LAVA);
ADDRLP4 316
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 316
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
ADDRLP4 316
INDIRP4
CNSTI4 792
ADDP4
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
line 3517
;3517:		}
LABELV $1708
line 3519
;3518:
;3519:		if (monster->watertype & CONTENTS_SLIME) {
ADDRFP4 0
INDIRP4
CNSTI4 788
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1710
line 3520
;3520:			G_Damage(monster, NULL, NULL, NULL, NULL, 10*monster->waterlevel, 0, MOD_SLIME);
ADDRLP4 316
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 316
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
ADDRLP4 316
INDIRP4
CNSTI4 792
ADDP4
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
line 3521
;3521:		}
LABELV $1710
line 3522
;3522:	}
LABELV $1705
LABELV $1628
line 3525
;3523:
;3524:	Exit:
;3525:	monster->nextthink = level.time + 1;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3526
;3526:}
LABELV $1610
endproc ThinkMonster 328 32
proc PainMonster 8 12
line 3537
;3527:#endif
;3528:
;3529:/*
;3530:===============
;3531:JUHOX: PainMonster
;3532:
;3533:derived from P_DamageFeedback() [g_active.c]
;3534:===============
;3535:*/
;3536:#if MONSTER_MODE
;3537:static void PainMonster(gentity_t* monster, gentity_t* attacker, int damage) {
line 3538
;3538:	if (!monster->monster) return;
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1714
ADDRGP4 $1713
JUMPV
LABELV $1714
line 3540
;3539:
;3540:	if (level.time > monster->pain_debounce_time && damage > 0) {
ADDRGP4 level+32
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 724
ADDP4
INDIRI4
LEI4 $1716
ADDRFP4 8
INDIRI4
CNSTI4 0
LEI4 $1716
line 3541
;3541:		monster->pain_debounce_time = level.time + 650 + rand() % 100;
ADDRLP4 0
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 724
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 650
ADDI4
ADDRLP4 0
INDIRI4
CNSTI4 100
MODI4
ADDI4
ASGNI4
line 3542
;3542:		G_AddEvent(monster, EV_PAIN, (100 * monster->health) / monster->monster->ps.stats[STAT_MAX_HEALTH]);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 57
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 100
MULI4
ADDRLP4 4
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
DIVI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 3543
;3543:	}
LABELV $1716
line 3544
;3544:	if (attacker && G_GetEntityPlayerState(attacker)) {
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1720
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1720
line 3545
;3545:		monster->monster->lastHurtEntity = attacker;
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 640
ADDP4
ADDRFP4 4
INDIRP4
ASGNP4
line 3546
;3546:		monster->monster->lastHurtTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 644
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 3547
;3547:	}
LABELV $1720
line 3548
;3548:}
LABELV $1713
endproc PainMonster 8 12
data
align 4
LABELV $1724
byte 4 3245342720
byte 4 3245342720
byte 4 3250585600
align 4
LABELV $1725
byte 4 1097859072
byte 4 1097859072
byte 4 1107296256
align 4
LABELV $1726
byte 4 3253731328
byte 4 3253731328
byte 4 3258974208
align 4
LABELV $1727
byte 4 1106247680
byte 4 1106247680
byte 4 1115684864
align 4
LABELV $1728
byte 4 3260153856
byte 4 3260153856
byte 4 3265789952
align 4
LABELV $1729
byte 4 1112670208
byte 4 1112670208
byte 4 1121976320
export G_GetMonsterBounds
code
proc G_GetMonsterBounds 8 0
line 3557
;3549:#endif
;3550:
;3551:/*
;3552:===============
;3553:JUHOX: G_GetMonsterBounds
;3554:===============
;3555:*/
;3556:#if MONSTER_MODE
;3557:void G_GetMonsterBounds(monsterType_t type, vec3_t mins, vec3_t maxs) {
line 3565
;3558:	static const vec3_t predatorMins = {-15.0f, -15.0f, -24.0f};
;3559:	static const vec3_t predatorMaxs = {15.0f, 15.0f, 32.0f};
;3560:	static const vec3_t guardMins = {-15.0f*MONSTER_GUARD_SCALE, -15.0f*MONSTER_GUARD_SCALE, -24.0f*MONSTER_GUARD_SCALE};
;3561:	static const vec3_t guardMaxs = { 15.0f*MONSTER_GUARD_SCALE,  15.0f*MONSTER_GUARD_SCALE,  32.0f*MONSTER_GUARD_SCALE};
;3562:	static const vec3_t titanMins = {-15.0f*MONSTER_TITAN_SCALE, -15.0f*MONSTER_TITAN_SCALE, -24.0f*MONSTER_TITAN_SCALE};
;3563:	static const vec3_t titanMaxs = { 15.0f*MONSTER_TITAN_SCALE,  15.0f*MONSTER_TITAN_SCALE,  32.0f*MONSTER_TITAN_SCALE};
;3564:
;3565:	switch (type) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1733
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $1734
ADDRLP4 0
INDIRI4
CNSTI4 2
EQI4 $1735
ADDRGP4 $1730
JUMPV
LABELV $1733
LABELV $1730
line 3568
;3566:	case MT_predator:
;3567:	default:
;3568:		VectorCopy(predatorMins, mins);
ADDRFP4 4
INDIRP4
ADDRGP4 $1724
INDIRB
ASGNB 12
line 3569
;3569:		VectorCopy(predatorMaxs, maxs);
ADDRFP4 8
INDIRP4
ADDRGP4 $1725
INDIRB
ASGNB 12
line 3570
;3570:		break;
ADDRGP4 $1731
JUMPV
LABELV $1734
line 3572
;3571:	case MT_guard:
;3572:		VectorCopy(guardMins, mins);
ADDRFP4 4
INDIRP4
ADDRGP4 $1726
INDIRB
ASGNB 12
line 3573
;3573:		VectorCopy(guardMaxs, maxs);
ADDRFP4 8
INDIRP4
ADDRGP4 $1727
INDIRB
ASGNB 12
line 3574
;3574:		break;
ADDRGP4 $1731
JUMPV
LABELV $1735
line 3576
;3575:	case MT_titan:
;3576:		VectorCopy(titanMins, mins);
ADDRFP4 4
INDIRP4
ADDRGP4 $1728
INDIRB
ASGNB 12
line 3577
;3577:		VectorCopy(titanMaxs, maxs);
ADDRFP4 8
INDIRP4
ADDRGP4 $1729
INDIRB
ASGNB 12
line 3578
;3578:		break;
LABELV $1731
line 3580
;3579:	}
;3580:}
LABELV $1723
endproc G_GetMonsterBounds 8 0
proc FitBoxIn 148 28
line 3594
;3581:#endif
;3582:
;3583:/*
;3584:===============
;3585:JUHOX: FitBoxIn
;3586:===============
;3587:*/
;3588:#if MONSTER_MODE
;3589:static qboolean FitBoxIn(
;3590:	const vec3_t origin,
;3591:	const vec3_t boxmins, const vec3_t boxmaxs,
;3592:	int mask,
;3593:	vec3_t result
;3594:) {
line 3603
;3595:	vec3_t boxsize;
;3596:	vec3_t end;
;3597:	vec3_t mins;
;3598:	vec3_t maxs;
;3599:	trace_t trace;
;3600:	vec3_t boundmins;
;3601:	vec3_t boundmaxs;
;3602:
;3603:	if (trap_PointContents(origin, -1) & mask) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 128
ADDRGP4 trap_PointContents
CALLI4
ASGNI4
ADDRLP4 128
INDIRI4
ADDRFP4 12
INDIRI4
BANDI4
CNSTI4 0
EQI4 $1737
CNSTI4 0
RETI4
ADDRGP4 $1736
JUMPV
LABELV $1737
line 3605
;3604:
;3605:	VectorSubtract(boxmaxs, boxmins, boxsize);
ADDRLP4 132
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 136
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 116
ADDRLP4 132
INDIRP4
INDIRF4
ADDRLP4 136
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 116+4
ADDRLP4 132
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 136
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 116+8
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3607
;3606:
;3607:	VectorCopy(origin, result);
ADDRFP4 16
INDIRP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 3611
;3608:	
;3609:	// fit X co-ordinate in
;3610:
;3611:	VectorCopy(result, end);
ADDRLP4 56
ADDRFP4 16
INDIRP4
INDIRB
ASGNB 12
line 3612
;3612:	end[0] -= boxsize[0];
ADDRLP4 56
ADDRLP4 56
INDIRF4
ADDRLP4 116
INDIRF4
SUBF4
ASGNF4
line 3613
;3613:	trap_Trace(&trace, result, NULL, NULL, end, -1, mask);
ADDRLP4 0
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 56
ARGP4
CNSTI4 -1
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 3614
;3614:	if (trace.fraction <= 0 || trace.startsolid || trace.allsolid) return qfalse;
ADDRLP4 0+8
INDIRF4
CNSTF4 0
LEF4 $1746
ADDRLP4 0+4
INDIRI4
CNSTI4 0
NEI4 $1746
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1741
LABELV $1746
CNSTI4 0
RETI4
ADDRGP4 $1736
JUMPV
LABELV $1741
line 3615
;3615:	VectorCopy(trace.endpos, boundmins);
ADDRLP4 92
ADDRLP4 0+12
INDIRB
ASGNB 12
line 3616
;3616:	trap_Trace(&trace, boundmins, NULL, NULL, result, -1, mask);	// trace back
ADDRLP4 0
ARGP4
ADDRLP4 92
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 3617
;3617:	if (trace.fraction < 1 || trace.startsolid || trace.allsolid) return qfalse;
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
LTF4 $1753
ADDRLP4 0+4
INDIRI4
CNSTI4 0
NEI4 $1753
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1748
LABELV $1753
CNSTI4 0
RETI4
ADDRGP4 $1736
JUMPV
LABELV $1748
line 3619
;3618:
;3619:	VectorCopy(result, end);
ADDRLP4 56
ADDRFP4 16
INDIRP4
INDIRB
ASGNB 12
line 3620
;3620:	end[0] += boxsize[0];
ADDRLP4 56
ADDRLP4 56
INDIRF4
ADDRLP4 116
INDIRF4
ADDF4
ASGNF4
line 3621
;3621:	trap_Trace(&trace, result, NULL, NULL, end, -1, mask);
ADDRLP4 0
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 56
ARGP4
CNSTI4 -1
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 3622
;3622:	if (trace.fraction <= 0 || trace.startsolid || trace.allsolid) return qfalse;
ADDRLP4 0+8
INDIRF4
CNSTF4 0
LEF4 $1759
ADDRLP4 0+4
INDIRI4
CNSTI4 0
NEI4 $1759
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1754
LABELV $1759
CNSTI4 0
RETI4
ADDRGP4 $1736
JUMPV
LABELV $1754
line 3623
;3623:	VectorCopy(trace.endpos, boundmaxs);
ADDRLP4 104
ADDRLP4 0+12
INDIRB
ASGNB 12
line 3624
;3624:	trap_Trace(&trace, boundmaxs, NULL, NULL, result, -1, mask);	// trace back
ADDRLP4 0
ARGP4
ADDRLP4 104
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 3625
;3625:	if (trace.fraction < 1 || trace.startsolid || trace.allsolid) return qfalse;
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
LTF4 $1766
ADDRLP4 0+4
INDIRI4
CNSTI4 0
NEI4 $1766
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1761
LABELV $1766
CNSTI4 0
RETI4
ADDRGP4 $1736
JUMPV
LABELV $1761
line 3627
;3626:
;3627:	if (boundmaxs[0] - boundmins[0] < boxsize[0]) return qfalse;	// not enough space to fix box in
ADDRLP4 104
INDIRF4
ADDRLP4 92
INDIRF4
SUBF4
ADDRLP4 116
INDIRF4
GEF4 $1767
CNSTI4 0
RETI4
ADDRGP4 $1736
JUMPV
LABELV $1767
line 3629
;3628:
;3629:	if (result[0] + boxmins[0] < boundmins[0]) result[0] = boundmins[0] - boxmins[0];
ADDRFP4 16
INDIRP4
INDIRF4
ADDRFP4 4
INDIRP4
INDIRF4
ADDF4
ADDRLP4 92
INDIRF4
GEF4 $1769
ADDRFP4 16
INDIRP4
ADDRLP4 92
INDIRF4
ADDRFP4 4
INDIRP4
INDIRF4
SUBF4
ASGNF4
LABELV $1769
line 3630
;3630:	if (result[0] + boxmaxs[0] > boundmaxs[0]) result[0] = boundmaxs[0] - boxmaxs[0];
ADDRFP4 16
INDIRP4
INDIRF4
ADDRFP4 8
INDIRP4
INDIRF4
ADDF4
ADDRLP4 104
INDIRF4
LEF4 $1771
ADDRFP4 16
INDIRP4
ADDRLP4 104
INDIRF4
ADDRFP4 8
INDIRP4
INDIRF4
SUBF4
ASGNF4
LABELV $1771
line 3634
;3631:
;3632:	// fit Y co-ordinate in
;3633:
;3634:	VectorSet(mins, boxmins[0], -0.1f, -0.1f);
ADDRLP4 80
ADDRFP4 4
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 80+4
CNSTF4 3184315597
ASGNF4
ADDRLP4 80+8
CNSTF4 3184315597
ASGNF4
line 3635
;3635:	VectorSet(maxs, boxmaxs[0], +0.1f, +0.1f);
ADDRLP4 68
ADDRFP4 8
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 68+4
CNSTF4 1036831949
ASGNF4
ADDRLP4 68+8
CNSTF4 1036831949
ASGNF4
line 3637
;3636:
;3637:	VectorCopy(result, end);
ADDRLP4 56
ADDRFP4 16
INDIRP4
INDIRB
ASGNB 12
line 3638
;3638:	end[1] -= boxsize[1];
ADDRLP4 56+4
ADDRLP4 56+4
INDIRF4
ADDRLP4 116+4
INDIRF4
SUBF4
ASGNF4
line 3639
;3639:	trap_Trace(&trace, result, mins, maxs, end, -1, mask);
ADDRLP4 0
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 80
ARGP4
ADDRLP4 68
ARGP4
ADDRLP4 56
ARGP4
CNSTI4 -1
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 3640
;3640:	if (trace.fraction <= 0 || trace.startsolid || trace.allsolid) return qfalse;
ADDRLP4 0+8
INDIRF4
CNSTF4 0
LEF4 $1784
ADDRLP4 0+4
INDIRI4
CNSTI4 0
NEI4 $1784
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1779
LABELV $1784
CNSTI4 0
RETI4
ADDRGP4 $1736
JUMPV
LABELV $1779
line 3641
;3641:	VectorCopy(trace.endpos, boundmins);
ADDRLP4 92
ADDRLP4 0+12
INDIRB
ASGNB 12
line 3642
;3642:	trap_Trace(&trace, boundmins, mins, maxs, result, -1, mask);	// trace back
ADDRLP4 0
ARGP4
ADDRLP4 92
ARGP4
ADDRLP4 80
ARGP4
ADDRLP4 68
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 3643
;3643:	if (trace.fraction < 1 || trace.startsolid || trace.allsolid) return qfalse;
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
LTF4 $1791
ADDRLP4 0+4
INDIRI4
CNSTI4 0
NEI4 $1791
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1786
LABELV $1791
CNSTI4 0
RETI4
ADDRGP4 $1736
JUMPV
LABELV $1786
line 3645
;3644:
;3645:	VectorCopy(result, end);
ADDRLP4 56
ADDRFP4 16
INDIRP4
INDIRB
ASGNB 12
line 3646
;3646:	end[1] += boxsize[1];
ADDRLP4 56+4
ADDRLP4 56+4
INDIRF4
ADDRLP4 116+4
INDIRF4
ADDF4
ASGNF4
line 3647
;3647:	trap_Trace(&trace, result, mins, maxs, end, -1, mask);
ADDRLP4 0
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 80
ARGP4
ADDRLP4 68
ARGP4
ADDRLP4 56
ARGP4
CNSTI4 -1
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 3648
;3648:	if (trace.fraction <= 0 || trace.startsolid || trace.allsolid) return qfalse;
ADDRLP4 0+8
INDIRF4
CNSTF4 0
LEF4 $1799
ADDRLP4 0+4
INDIRI4
CNSTI4 0
NEI4 $1799
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1794
LABELV $1799
CNSTI4 0
RETI4
ADDRGP4 $1736
JUMPV
LABELV $1794
line 3649
;3649:	VectorCopy(trace.endpos, boundmaxs);
ADDRLP4 104
ADDRLP4 0+12
INDIRB
ASGNB 12
line 3650
;3650:	trap_Trace(&trace, boundmaxs, mins, maxs, result, -1, mask);	// trace back
ADDRLP4 0
ARGP4
ADDRLP4 104
ARGP4
ADDRLP4 80
ARGP4
ADDRLP4 68
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 3651
;3651:	if (trace.fraction < 1 || trace.startsolid || trace.allsolid) return qfalse;
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
LTF4 $1806
ADDRLP4 0+4
INDIRI4
CNSTI4 0
NEI4 $1806
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1801
LABELV $1806
CNSTI4 0
RETI4
ADDRGP4 $1736
JUMPV
LABELV $1801
line 3653
;3652:
;3653:	if (boundmaxs[1] - boundmins[1] < boxsize[1]) return qfalse;	// not enough space to fit box in
ADDRLP4 104+4
INDIRF4
ADDRLP4 92+4
INDIRF4
SUBF4
ADDRLP4 116+4
INDIRF4
GEF4 $1807
CNSTI4 0
RETI4
ADDRGP4 $1736
JUMPV
LABELV $1807
line 3655
;3654:
;3655:	if (result[1] + boxmins[1] < boundmins[1]) result[1] = boundmins[1] - boxmins[1];
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDF4
ADDRLP4 92+4
INDIRF4
GEF4 $1812
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 92+4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
LABELV $1812
line 3656
;3656:	if (result[1] + boxmaxs[1] > boundmaxs[1]) result[1] = boundmaxs[1] - boxmaxs[1];
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDF4
ADDRLP4 104+4
INDIRF4
LEF4 $1816
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 104+4
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
LABELV $1816
line 3660
;3657:
;3658:	// fit Z co-ordinate in
;3659:
;3660:	VectorSet(mins, boxmins[0], boxmins[1], -0.1f);
ADDRLP4 140
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 80
ADDRLP4 140
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 80+4
ADDRLP4 140
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 80+8
CNSTF4 3184315597
ASGNF4
line 3661
;3661:	VectorSet(maxs, boxmaxs[0], boxmaxs[1], +0.1f);
ADDRLP4 144
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 68
ADDRLP4 144
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 68+4
ADDRLP4 144
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 68+8
CNSTF4 1036831949
ASGNF4
line 3663
;3662:
;3663:	VectorCopy(result, end);
ADDRLP4 56
ADDRFP4 16
INDIRP4
INDIRB
ASGNB 12
line 3664
;3664:	end[2] -= boxsize[2];
ADDRLP4 56+8
ADDRLP4 56+8
INDIRF4
ADDRLP4 116+8
INDIRF4
SUBF4
ASGNF4
line 3665
;3665:	maxs[2] = 1;
ADDRLP4 68+8
CNSTF4 1065353216
ASGNF4
line 3666
;3666:	trap_Trace(&trace, result, mins, maxs, end, -1, mask);
ADDRLP4 0
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 80
ARGP4
ADDRLP4 68
ARGP4
ADDRLP4 56
ARGP4
CNSTI4 -1
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 3667
;3667:	if (trace.fraction <= 0 || trace.startsolid || trace.allsolid) return qfalse;
ADDRLP4 0+8
INDIRF4
CNSTF4 0
LEF4 $1832
ADDRLP4 0+4
INDIRI4
CNSTI4 0
NEI4 $1832
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1827
LABELV $1832
CNSTI4 0
RETI4
ADDRGP4 $1736
JUMPV
LABELV $1827
line 3668
;3668:	VectorCopy(trace.endpos, boundmins);
ADDRLP4 92
ADDRLP4 0+12
INDIRB
ASGNB 12
line 3669
;3669:	trap_Trace(&trace, boundmins, mins, maxs, result, -1, mask);	// trace back
ADDRLP4 0
ARGP4
ADDRLP4 92
ARGP4
ADDRLP4 80
ARGP4
ADDRLP4 68
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 3670
;3670:	if (trace.fraction < 1 || trace.startsolid || trace.allsolid) return qfalse;
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
LTF4 $1839
ADDRLP4 0+4
INDIRI4
CNSTI4 0
NEI4 $1839
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1834
LABELV $1839
CNSTI4 0
RETI4
ADDRGP4 $1736
JUMPV
LABELV $1834
line 3672
;3671:
;3672:	VectorCopy(result, end);
ADDRLP4 56
ADDRFP4 16
INDIRP4
INDIRB
ASGNB 12
line 3673
;3673:	end[2] += boxsize[2];
ADDRLP4 56+8
ADDRLP4 56+8
INDIRF4
ADDRLP4 116+8
INDIRF4
ADDF4
ASGNF4
line 3674
;3674:	trap_Trace(&trace, result, mins, maxs, end, -1, mask);
ADDRLP4 0
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 80
ARGP4
ADDRLP4 68
ARGP4
ADDRLP4 56
ARGP4
CNSTI4 -1
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 3675
;3675:	if (trace.fraction <= 0 || trace.startsolid || trace.allsolid) return qfalse;
ADDRLP4 0+8
INDIRF4
CNSTF4 0
LEF4 $1847
ADDRLP4 0+4
INDIRI4
CNSTI4 0
NEI4 $1847
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1842
LABELV $1847
CNSTI4 0
RETI4
ADDRGP4 $1736
JUMPV
LABELV $1842
line 3676
;3676:	VectorCopy(trace.endpos, boundmaxs);
ADDRLP4 104
ADDRLP4 0+12
INDIRB
ASGNB 12
line 3677
;3677:	trap_Trace(&trace, boundmaxs, mins, maxs, result, -1, mask);	// trace back
ADDRLP4 0
ARGP4
ADDRLP4 104
ARGP4
ADDRLP4 80
ARGP4
ADDRLP4 68
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 3678
;3678:	if (trace.fraction < 1 || trace.startsolid || trace.allsolid) return qfalse;
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
LTF4 $1854
ADDRLP4 0+4
INDIRI4
CNSTI4 0
NEI4 $1854
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1849
LABELV $1854
CNSTI4 0
RETI4
ADDRGP4 $1736
JUMPV
LABELV $1849
line 3680
;3679:
;3680:	if (boundmaxs[2] - boundmins[2] < boxsize[2]) return qfalse;	// not enough space to fit box in
ADDRLP4 104+8
INDIRF4
ADDRLP4 92+8
INDIRF4
SUBF4
ADDRLP4 116+8
INDIRF4
GEF4 $1855
CNSTI4 0
RETI4
ADDRGP4 $1736
JUMPV
LABELV $1855
line 3682
;3681:
;3682:	if (result[2] + boxmins[2] < boundmins[2]) result[2] = boundmins[2] - boxmins[2];
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
ADDRLP4 92+8
INDIRF4
GEF4 $1860
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 92+8
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
LABELV $1860
line 3683
;3683:	if (result[2] + boxmaxs[2] > boundmaxs[2]) result[2] = boundmaxs[2] - boxmaxs[2];
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
ADDRLP4 104+8
INDIRF4
LEF4 $1864
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 104+8
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
LABELV $1864
line 3685
;3684:
;3685:	return qtrue;
CNSTI4 1
RETI4
LABELV $1736
endproc FitBoxIn 148 28
export G_GetMonsterSpawnPoint
proc G_GetMonsterSpawnPoint 188 28
line 3699
;3686:}
;3687:#endif
;3688:
;3689:/*
;3690:===============
;3691:JUHOX: G_GetMonsterSpawnPoint
;3692:===============
;3693:*/
;3694:#if MONSTER_MODE
;3695:qboolean G_GetMonsterSpawnPoint(
;3696:	const vec3_t mmins, const vec3_t mmaxs,
;3697:	localseed_t* masterseed, vec3_t result,
;3698:	monsterspawnmode_t mode, const vec3_t origin
;3699:) {
line 3704
;3700:	int choosen;
;3701:	localseed_t seed1;
;3702:	localseed_t seed2;
;3703:
;3704:	DeriveLocalSeed(masterseed, &seed1);
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 DeriveLocalSeed
CALLV
pop
line 3705
;3705:	DeriveLocalSeed(masterseed, &seed2);
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
ADDRGP4 DeriveLocalSeed
CALLV
pop
line 3708
;3706:
;3707:	if (
;3708:		mode == MSM_atOrigin ||
ADDRLP4 36
ADDRFP4 16
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 2
EQI4 $1871
ADDRLP4 36
INDIRI4
CNSTI4 1
NEI4 $1869
LABELV $1871
line 3710
;3709:		mode == MSM_nearOrigin
;3710:	) {
line 3718
;3711:		int i;
;3712:		trace_t trace;
;3713:		vec3_t nearOrigin;
;3714:		vec3_t end;
;3715:		float size;
;3716:		float maxDistance;
;3717:
;3718:		size = Distance(mmins, mmaxs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 132
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRLP4 124
ADDRLP4 132
INDIRF4
ASGNF4
line 3719
;3719:		maxDistance = size;
ADDRLP4 128
ADDRLP4 124
INDIRF4
ASGNF4
line 3720
;3720:		if (mode == MSM_nearOrigin) maxDistance += 400;
ADDRFP4 16
INDIRI4
CNSTI4 1
NEI4 $1872
ADDRLP4 128
ADDRLP4 128
INDIRF4
CNSTF4 1137180672
ADDF4
ASGNF4
LABELV $1872
line 3722
;3721:
;3722:		for (i = 0; i < 30; i++) {
ADDRLP4 108
CNSTI4 0
ASGNI4
LABELV $1874
line 3723
;3723:			if (i <= 0 && mode == MSM_atOrigin) {
ADDRLP4 108
INDIRI4
CNSTI4 0
GTI4 $1878
ADDRFP4 16
INDIRI4
CNSTI4 2
NEI4 $1878
line 3724
;3724:				VectorCopy(origin, nearOrigin);
ADDRLP4 96
ADDRFP4 20
INDIRP4
INDIRB
ASGNB 12
line 3725
;3725:			}
ADDRGP4 $1879
JUMPV
LABELV $1878
line 3726
;3726:			else {
line 3731
;3727:				vec3_t angles;
;3728:				vec3_t dir;
;3729:				float distance;
;3730:
;3731:				angles[0] = 360.0f * local_random(&seed1);
ADDRLP4 0
ARGP4
ADDRLP4 164
ADDRGP4 local_random
CALLF4
ASGNF4
ADDRLP4 152
ADDRLP4 164
INDIRF4
CNSTF4 1135869952
MULF4
ASGNF4
line 3732
;3732:				angles[1] = 360.0f * local_random(&seed1);
ADDRLP4 0
ARGP4
ADDRLP4 168
ADDRGP4 local_random
CALLF4
ASGNF4
ADDRLP4 152+4
ADDRLP4 168
INDIRF4
CNSTF4 1135869952
MULF4
ASGNF4
line 3733
;3733:				angles[2] = 360.0f * local_random(&seed1);
ADDRLP4 0
ARGP4
ADDRLP4 172
ADDRGP4 local_random
CALLF4
ASGNF4
ADDRLP4 152+8
ADDRLP4 172
INDIRF4
CNSTF4 1135869952
MULF4
ASGNF4
line 3734
;3734:				AngleVectors(angles, dir, NULL, NULL);
ADDRLP4 152
ARGP4
ADDRLP4 136
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 3735
;3735:				distance = size + maxDistance * local_random(&seed1);
ADDRLP4 0
ARGP4
ADDRLP4 176
ADDRGP4 local_random
CALLF4
ASGNF4
ADDRLP4 148
ADDRLP4 124
INDIRF4
ADDRLP4 128
INDIRF4
ADDRLP4 176
INDIRF4
MULF4
ADDF4
ASGNF4
line 3736
;3736:				VectorMA(origin, distance, dir, nearOrigin);
ADDRLP4 180
ADDRFP4 20
INDIRP4
ASGNP4
ADDRLP4 96
ADDRLP4 180
INDIRP4
INDIRF4
ADDRLP4 136
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 96+4
ADDRLP4 180
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 136+4
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 96+8
ADDRFP4 20
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 136+8
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ADDF4
ASGNF4
line 3738
;3737:
;3738:				trap_Trace(&trace, origin, NULL, NULL, nearOrigin, -1, CONTENTS_SOLID | CONTENTS_PLAYERCLIP);
ADDRLP4 40
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 96
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 65537
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 3739
;3739:				if (trace.fraction * distance < 2.0f || trace.startsolid || trace.allsolid) continue;
ADDRLP4 40+8
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
CNSTF4 1073741824
LTF4 $1891
ADDRLP4 40+4
INDIRI4
CNSTI4 0
NEI4 $1891
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $1886
LABELV $1891
ADDRGP4 $1875
JUMPV
LABELV $1886
line 3742
;3740:
;3741:				// step back from the wall
;3742:				VectorSubtract(trace.endpos, dir, nearOrigin);
ADDRLP4 96
ADDRLP4 40+12
INDIRF4
ADDRLP4 136
INDIRF4
SUBF4
ASGNF4
ADDRLP4 96+4
ADDRLP4 40+12+4
INDIRF4
ADDRLP4 136+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 96+8
ADDRLP4 40+12+8
INDIRF4
ADDRLP4 136+8
INDIRF4
SUBF4
ASGNF4
line 3744
;3743:
;3744:				trap_Trace(&trace, nearOrigin, NULL, NULL, origin, -1, CONTENTS_SOLID | CONTENTS_PLAYERCLIP);
ADDRLP4 40
ARGP4
ADDRLP4 96
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 65537
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 3745
;3745:				if (trace.fraction < 1 || trace.startsolid || trace.allsolid) continue;
ADDRLP4 40+8
INDIRF4
CNSTF4 1065353216
LTF4 $1906
ADDRLP4 40+4
INDIRI4
CNSTI4 0
NEI4 $1906
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $1901
LABELV $1906
ADDRGP4 $1875
JUMPV
LABELV $1901
line 3746
;3746:			}
LABELV $1879
line 3747
;3747:			if (!FitBoxIn(nearOrigin, mmins, mmaxs, CONTENTS_SOLID | CONTENTS_PLAYERCLIP, nearOrigin)) {
ADDRLP4 96
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 65537
ARGI4
ADDRLP4 96
ARGP4
ADDRLP4 136
ADDRGP4 FitBoxIn
CALLI4
ASGNI4
ADDRLP4 136
INDIRI4
CNSTI4 0
NEI4 $1907
line 3748
;3748:				continue;
ADDRGP4 $1875
JUMPV
LABELV $1907
line 3751
;3749:			}
;3750:
;3751:			VectorCopy(nearOrigin, end);
ADDRLP4 112
ADDRLP4 96
INDIRB
ASGNB 12
line 3752
;3752:			end[2] -= 1000;
ADDRLP4 112+8
ADDRLP4 112+8
INDIRF4
CNSTF4 1148846080
SUBF4
ASGNF4
line 3753
;3753:			trap_Trace(&trace, nearOrigin, mmins, mmaxs, end, -1, MASK_PLAYERSOLID);
ADDRLP4 40
ARGP4
ADDRLP4 96
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 112
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 33619969
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 3754
;3754:			if (trace.fraction >= 1) continue;
ADDRLP4 40+8
INDIRF4
CNSTF4 1065353216
LTF4 $1910
ADDRGP4 $1875
JUMPV
LABELV $1910
line 3756
;3755:
;3756:			trace.endpos[2] += 1;
ADDRLP4 40+12+8
ADDRLP4 40+12+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3757
;3757:			SnapVectorTowards(trace.endpos, origin);
ADDRLP4 40+12
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRGP4 SnapVectorTowards
CALLV
pop
line 3758
;3758:			if (PositionWouldTelefrag(trace.endpos, mmins, mmaxs)) continue;
ADDRLP4 40+12
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 PositionWouldTelefrag
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $1916
ADDRGP4 $1875
JUMPV
LABELV $1916
line 3760
;3759:
;3760:			VectorCopy(trace.endpos, result);
ADDRFP4 12
INDIRP4
ADDRLP4 40+12
INDIRB
ASGNB 12
line 3761
;3761:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1868
JUMPV
LABELV $1875
line 3722
ADDRLP4 108
ADDRLP4 108
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 108
INDIRI4
CNSTI4 30
LTI4 $1874
line 3763
;3762:		}
;3763:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1868
JUMPV
LABELV $1869
line 3766
;3764:	}
;3765:
;3766:	if (numMonsterSpawnPoolEntries > 0) {
ADDRGP4 numMonsterSpawnPoolEntries
INDIRI4
CNSTI4 0
LEI4 $1920
line 3767
;3767:		choosen = LocallySeededRandom(&seed1) % numMonsterSpawnPoolEntries;
ADDRLP4 0
ARGP4
ADDRLP4 40
ADDRGP4 LocallySeededRandom
CALLU4
ASGNU4
ADDRLP4 32
ADDRLP4 40
INDIRU4
ADDRGP4 numMonsterSpawnPoolEntries
INDIRI4
CVIU4 4
MODU4
CVUI4 4
ASGNI4
line 3768
;3768:		return G_GetMonsterSpawnPoint(mmins, mmaxs, &seed2, result, MSM_nearOrigin, monsterSpawnPool[choosen]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 32
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 monsterSpawnPool
ADDP4
ARGP4
ADDRLP4 44
ADDRGP4 G_GetMonsterSpawnPoint
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
RETI4
ADDRGP4 $1868
JUMPV
LABELV $1920
line 3770
;3769:	}
;3770:	return qfalse;
CNSTI4 0
RETI4
LABELV $1868
endproc G_GetMonsterSpawnPoint 188 28
proc RandomWaitingMonster 40 8
line 3780
;3771:}
;3772:#endif
;3773:
;3774:/*
;3775:===============
;3776:JUHOX: RandomWaitingMonster
;3777:===============
;3778:*/
;3779:#if MONSTER_MODE
;3780:static gentity_t* RandomWaitingMonster(localseed_t* masterseed, int owner) {
line 3786
;3781:	int i;
;3782:	gentity_t* monster;
;3783:	int n;
;3784:	localseed_t seed;
;3785:
;3786:	n = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 3787
;3787:	monster = NULL;
ADDRLP4 24
CNSTP4 0
ASGNP4
line 3788
;3788:	DeriveLocalSeed(masterseed, &seed);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 DeriveLocalSeed
CALLV
pop
line 3789
;3789:	for (i = MAX_CLIENTS; i < level.num_entities; i++) {
ADDRLP4 0
CNSTI4 64
ASGNI4
ADDRGP4 $1926
JUMPV
LABELV $1923
line 3792
;3790:		gentity_t* ent;
;3791:
;3792:		ent = &g_entities[i];
ADDRLP4 28
ADDRLP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 3793
;3793:		if (!ent->inuse) continue;
ADDRLP4 28
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1928
ADDRGP4 $1924
JUMPV
LABELV $1928
line 3794
;3794:		if (ent->s.eType != ET_PLAYER) continue;
ADDRLP4 28
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 1
EQI4 $1930
ADDRGP4 $1924
JUMPV
LABELV $1930
line 3795
;3795:		if (!ent->monster) continue;
ADDRLP4 28
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1932
ADDRGP4 $1924
JUMPV
LABELV $1932
line 3796
;3796:		if (ent->health <= 0) continue;
ADDRLP4 28
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
GTI4 $1934
ADDRGP4 $1924
JUMPV
LABELV $1934
line 3797
;3797:		if (ent->monster->action != MA_waiting) continue;
ADDRLP4 28
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1936
ADDRGP4 $1924
JUMPV
LABELV $1936
line 3798
;3798:		if (ent->monster->walk) continue;
ADDRLP4 28
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 552
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1938
ADDRGP4 $1924
JUMPV
LABELV $1938
line 3799
;3799:		if (owner >= 0 && ent->monster->owner != owner) continue;
ADDRLP4 32
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
LTI4 $1940
ADDRLP4 28
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 484
ADDP4
INDIRI4
ADDRLP4 32
INDIRI4
EQI4 $1940
ADDRGP4 $1924
JUMPV
LABELV $1940
line 3801
;3800:
;3801:		n++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3802
;3802:		if (LocallySeededRandom(&seed) % n == 0) monster = ent;
ADDRLP4 8
ARGP4
ADDRLP4 36
ADDRGP4 LocallySeededRandom
CALLU4
ASGNU4
ADDRLP4 36
INDIRU4
ADDRLP4 4
INDIRI4
CVIU4 4
MODU4
CNSTU4 0
NEU4 $1942
ADDRLP4 24
ADDRLP4 28
INDIRP4
ASGNP4
LABELV $1942
line 3803
;3803:	}
LABELV $1924
line 3789
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1926
ADDRLP4 0
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $1923
line 3804
;3804:	return monster;
ADDRLP4 24
INDIRP4
RETP4
LABELV $1922
endproc RandomWaitingMonster 40 8
export G_MonsterHealthScale
proc G_MonsterHealthScale 4 0
line 3814
;3805:}
;3806:#endif
;3807:
;3808:/*
;3809:===============
;3810:JUHOX: G_MonsterHealthScale
;3811:===============
;3812:*/
;3813:#if MONSTER_MODE
;3814:float G_MonsterHealthScale(void) {
line 3817
;3815:	float healthScale;
;3816:
;3817:	healthScale = g_monsterHealthScale.integer;
ADDRLP4 0
ADDRGP4 g_monsterHealthScale+12
INDIRI4
CVIF4 4
ASGNF4
line 3818
;3818:	if (g_gametype.integer >= GT_STU) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
LTI4 $1946
line 3819
;3819:		healthScale *= (
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRGP4 g_monsterProgression+12
INDIRI4
CVIF4 4
CNSTF4 1008981770
MULF4
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+40
INDIRI4
SUBI4
CVIF4 4
CNSTF4 931909477
MULF4
MULF4
CNSTF4 1065353216
ADDF4
MULF4
ASGNF4
line 3823
;3820:			1.0f +
;3821:			0.01f * g_monsterProgression.integer * ((level.time - level.startTime) / 60000.0f)
;3822:		);
;3823:	}
LABELV $1946
line 3825
;3824:
;3825:	return healthScale;
ADDRLP4 0
INDIRF4
RETF4
LABELV $1944
endproc G_MonsterHealthScale 4 0
export G_MonsterBaseHealth
proc G_MonsterBaseHealth 20 4
line 3835
;3826:}
;3827:#endif
;3828:
;3829:/*
;3830:===============
;3831:JUHOX: G_MonsterBaseHealth
;3832:===============
;3833:*/
;3834:#if MONSTER_MODE
;3835:int G_MonsterBaseHealth(monsterType_t type, float healthScale) {
line 3836
;3836:	switch (type) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1956
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $1957
ADDRLP4 0
INDIRI4
CNSTI4 2
EQI4 $1958
ADDRGP4 $1953
JUMPV
LABELV $1956
line 3838
;3837:	case MT_predator:
;3838:		return (int) floor(3.0f * healthScale + 0.5f);
ADDRFP4 4
INDIRF4
CNSTF4 1077936128
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRLP4 8
ADDRGP4 floor
CALLF4
ASGNF4
ADDRLP4 8
INDIRF4
CVFI4 4
RETI4
ADDRGP4 $1952
JUMPV
LABELV $1957
line 3840
;3839:	case MT_guard:
;3840:		return (int) floor(10.0f * healthScale + 0.5f);
ADDRFP4 4
INDIRF4
CNSTF4 1092616192
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRLP4 12
ADDRGP4 floor
CALLF4
ASGNF4
ADDRLP4 12
INDIRF4
CVFI4 4
RETI4
ADDRGP4 $1952
JUMPV
LABELV $1958
line 3842
;3841:	case MT_titan:
;3842:		return (int) floor(50.0f * healthScale + 0.5f);
ADDRFP4 4
INDIRF4
CNSTF4 1112014848
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRLP4 16
ADDRGP4 floor
CALLF4
ASGNF4
ADDRLP4 16
INDIRF4
CVFI4 4
RETI4
ADDRGP4 $1952
JUMPV
LABELV $1953
line 3844
;3843:	default:
;3844:		return 0;
CNSTI4 0
RETI4
LABELV $1952
endproc G_MonsterBaseHealth 20 4
export G_MonsterType
proc G_MonsterType 12 4
line 3855
;3845:	}
;3846:}
;3847:#endif
;3848:
;3849:/*
;3850:===============
;3851:JUHOX: G_MonsterType
;3852:===============
;3853:*/
;3854:#if MONSTER_MODE
;3855:monsterType_t G_MonsterType(localseed_t* seed) {
line 3859
;3856:	int total;
;3857:	int r;
;3858:
;3859:	total = g_monsterGuards.integer + g_monsterTitans.integer;
ADDRLP4 4
ADDRGP4 g_monsterGuards+12
INDIRI4
ADDRGP4 g_monsterTitans+12
INDIRI4
ADDI4
ASGNI4
line 3860
;3860:	if (total < 100) total = 100;
ADDRLP4 4
INDIRI4
CNSTI4 100
GEI4 $1962
ADDRLP4 4
CNSTI4 100
ASGNI4
LABELV $1962
line 3862
;3861:
;3862:	r = LocallySeededRandom(seed) % total;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 LocallySeededRandom
CALLU4
ASGNU4
ADDRLP4 0
ADDRLP4 8
INDIRU4
ADDRLP4 4
INDIRI4
CVIU4 4
MODU4
CVUI4 4
ASGNI4
line 3864
;3863:
;3864:	if (r < g_monsterGuards.integer) return MT_guard;
ADDRLP4 0
INDIRI4
ADDRGP4 g_monsterGuards+12
INDIRI4
GEI4 $1964
CNSTI4 1
RETI4
ADDRGP4 $1959
JUMPV
LABELV $1964
line 3865
;3865:	r -= g_monsterGuards.integer;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRGP4 g_monsterGuards+12
INDIRI4
SUBI4
ASGNI4
line 3867
;3866:
;3867:	if (r < g_monsterTitans.integer) return MT_titan;
ADDRLP4 0
INDIRI4
ADDRGP4 g_monsterTitans+12
INDIRI4
GEI4 $1968
CNSTI4 2
RETI4
ADDRGP4 $1959
JUMPV
LABELV $1968
line 3870
;3868:	//r -= g_monsterTitans.integer;
;3869:
;3870:	return MT_predator;
CNSTI4 0
RETI4
LABELV $1959
endproc G_MonsterType 12 4
export G_SpawnMonster
proc G_SpawnMonster 108 12
line 3890
;3871:}
;3872:#endif
;3873:
;3874:/*
;3875:===============
;3876:JUHOX: G_SpawnMonster
;3877:===============
;3878:*/
;3879:#if MONSTER_MODE
;3880:gentity_t* G_SpawnMonster(
;3881:	monsterType_t type,
;3882:	const vec3_t spawn_origin, const vec3_t spawn_angles,
;3883:	int removeTime,
;3884:	team_t spawnteam, int owner,
;3885:	const localseed_t* seed,
;3886:	gentity_t* monster,	// if non-NULL, telemorph this
;3887:	int maxHealth,
;3888:	monsterAction_t action,
;3889:	int generic1
;3890:) {
line 3898
;3891:	vec3_t mins, maxs;
;3892:	vec3_t spawnorigin;
;3893:	gmonster_t* mi;
;3894:	float healthScale;
;3895:	int eFlags;
;3896:	qboolean telemorph;
;3897:
;3898:	G_GetMonsterBounds(type, mins, maxs);
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 20
ARGP4
ADDRLP4 32
ARGP4
ADDRGP4 G_GetMonsterBounds
CALLV
pop
line 3900
;3899:
;3900:	VectorCopy(spawn_origin, spawnorigin);
ADDRLP4 4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 3902
;3901:
;3902:	if (!monster) {
ADDRFP4 28
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1972
line 3903
;3903:		monster = G_Spawn();
ADDRLP4 52
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRFP4 28
ADDRLP4 52
INDIRP4
ASGNP4
line 3904
;3904:		if (!monster) return NULL;
ADDRFP4 28
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1974
CNSTP4 0
RETP4
ADDRGP4 $1971
JUMPV
LABELV $1974
line 3906
;3905:
;3906:		mi = GetMonsterInfo();
ADDRLP4 56
ADDRGP4 GetMonsterInfo
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 56
INDIRP4
ASGNP4
line 3907
;3907:		if (!mi) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1976
line 3908
;3908:			G_FreeEntity(monster);
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 3909
;3909:			return NULL;
CNSTP4 0
RETP4
ADDRGP4 $1971
JUMPV
LABELV $1976
line 3912
;3910:		}
;3911:
;3912:		eFlags = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 3913
;3913:		telemorph = qfalse;
ADDRLP4 44
CNSTI4 0
ASGNI4
line 3914
;3914:	}
ADDRGP4 $1973
JUMPV
LABELV $1972
line 3915
;3915:	else {
line 3916
;3916:		mi = monster->monster;
ADDRLP4 0
ADDRFP4 28
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
ASGNP4
line 3917
;3917:		eFlags = mi->ps.eFlags & EF_TELEPORT_BIT;
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
CNSTI4 4
BANDI4
ASGNI4
line 3918
;3918:		telemorph = qtrue;
ADDRLP4 44
CNSTI4 1
ASGNI4
line 3919
;3919:		trap_UnlinkEntity(monster);
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 3920
;3920:	}
LABELV $1973
line 3922
;3921:
;3922:	memset(monster, 0, sizeof(*monster));
ADDRFP4 28
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 844
ARGI4
ADDRGP4 memset
CALLP4
pop
line 3923
;3923:	G_InitGentity(monster);
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 G_InitGentity
CALLV
pop
line 3924
;3924:	memset(mi, 0, sizeof(*mi));
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 708
ARGI4
ADDRGP4 memset
CALLP4
pop
line 3925
;3925:	monster->monster = mi;
ADDRFP4 28
INDIRP4
CNSTI4 520
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 3926
;3926:	mi->type = type;
ADDRLP4 0
INDIRP4
CNSTI4 476
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 3927
;3927:	mi->entity = monster;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 28
INDIRP4
ASGNP4
line 3928
;3928:	mi->seed = *seed;
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
ADDRFP4 24
INDIRP4
INDIRB
ASGNB 16
line 3929
;3929:	mi->owner = owner;
ADDRLP4 0
INDIRP4
CNSTI4 484
ADDP4
ADDRFP4 20
INDIRI4
ASGNI4
line 3930
;3930:	mi->removeTime = removeTime;
ADDRLP4 0
INDIRP4
CNSTI4 532
ADDP4
ADDRFP4 12
INDIRI4
ASGNI4
line 3931
;3931:	switch (spawnteam) {
ADDRLP4 52
ADDRFP4 16
INDIRI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 1
EQI4 $1981
ADDRLP4 52
INDIRI4
CNSTI4 2
EQI4 $1982
ADDRGP4 $1978
JUMPV
LABELV $1981
line 3933
;3932:	case TEAM_RED:
;3933:		monster->s.clientNum = CLIENTNUM_MONSTER_PREDATOR_RED;
ADDRFP4 28
INDIRP4
CNSTI4 168
ADDP4
CNSTI4 67
ASGNI4
line 3934
;3934:		break;
ADDRGP4 $1979
JUMPV
LABELV $1982
line 3936
;3935:	case TEAM_BLUE:
;3936:		monster->s.clientNum = CLIENTNUM_MONSTER_PREDATOR_BLUE;
ADDRFP4 28
INDIRP4
CNSTI4 168
ADDP4
CNSTI4 68
ASGNI4
line 3937
;3937:		break;
ADDRGP4 $1979
JUMPV
LABELV $1978
line 3939
;3938:	default:
;3939:		monster->s.clientNum = CLIENTNUM_MONSTERS + type;
ADDRFP4 28
INDIRP4
CNSTI4 168
ADDP4
ADDRFP4 0
INDIRI4
CNSTI4 64
ADDI4
ASGNI4
line 3940
;3940:		break;
LABELV $1979
line 3942
;3941:	}
;3942:	mi->clientNum = monster->s.clientNum;
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
ADDRFP4 28
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 3943
;3943:	monster->s.eType = ET_PLAYER;
ADDRFP4 28
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 1
ASGNI4
line 3944
;3944:	monster->s.eFlags = eFlags;
ADDRFP4 28
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 3945
;3945:	monster->s.groundEntityNum = ENTITYNUM_NONE;
ADDRFP4 28
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 1023
ASGNI4
line 3946
;3946:	monster->s.powerups = 0;
ADDRFP4 28
INDIRP4
CNSTI4 188
ADDP4
CNSTI4 0
ASGNI4
line 3947
;3947:	monster->s.legsAnim = LEGS_IDLE;
ADDRFP4 28
INDIRP4
CNSTI4 196
ADDP4
CNSTI4 22
ASGNI4
line 3948
;3948:	monster->s.torsoAnim = TORSO_STAND2;	// gauntlet anim
ADDRFP4 28
INDIRP4
CNSTI4 200
ADDP4
CNSTI4 12
ASGNI4
line 3949
;3949:	monster->s.event = 0;
ADDRFP4 28
INDIRP4
CNSTI4 180
ADDP4
CNSTI4 0
ASGNI4
line 3950
;3950:	monster->s.loopSound = 0;
ADDRFP4 28
INDIRP4
CNSTI4 156
ADDP4
CNSTI4 0
ASGNI4
line 3951
;3951:	monster->s.otherEntityNum = ENTITYNUM_NONE;
ADDRFP4 28
INDIRP4
CNSTI4 140
ADDP4
CNSTI4 1023
ASGNI4
line 3952
;3952:	monster->s.otherEntityNum2 = ENTITYNUM_NONE;
ADDRFP4 28
INDIRP4
CNSTI4 144
ADDP4
CNSTI4 1023
ASGNI4
line 3955
;3953:
;3954:#if ESCAPE_MODE
;3955:	if (g_gametype.integer != GT_EFH)
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
EQI4 $1983
line 3957
;3956:#endif
;3957:	{
line 3958
;3958:		mi->ps.stats[STAT_EFFECT] = PE_spawn;
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
CNSTI4 0
ASGNI4
line 3959
;3959:		mi->ps.powerups[PW_EFFECT_TIME] = level.time + SPAWNHULL_TIME;
ADDRLP4 0
INDIRP4
CNSTI4 372
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 3960
;3960:	}
LABELV $1983
line 3962
;3961:
;3962:	monster->r.svFlags = 0;
ADDRFP4 28
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 0
ASGNI4
line 3963
;3963:	monster->r.contents = CONTENTS_BODY;
ADDRFP4 28
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 33554432
ASGNI4
line 3964
;3964:	VectorCopy(mins, monster->r.mins);
ADDRFP4 28
INDIRP4
CNSTI4 436
ADDP4
ADDRLP4 20
INDIRB
ASGNB 12
line 3965
;3965:	VectorCopy(maxs, monster->r.maxs);
ADDRFP4 28
INDIRP4
CNSTI4 448
ADDP4
ADDRLP4 32
INDIRB
ASGNB 12
line 3967
;3966:
;3967:	mi->ps.eFlags = eFlags;
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 3968
;3968:	mi->ps.pm_type = PM_NORMAL;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 3969
;3969:	mi->ps.stats[STAT_STRENGTH] = MAX_STRENGTH_VALUE;
ADDRLP4 0
INDIRP4
CNSTI4 220
ADDP4
CNSTI4 18000
ASGNI4
line 3970
;3970:	mi->ps.stats[STAT_TARGET] = -1;
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
CNSTI4 -1
ASGNI4
line 3971
;3971:	mi->ps.persistant[PERS_TEAM] = spawnteam;
ADDRLP4 0
INDIRP4
CNSTI4 268
ADDP4
ADDRFP4 16
INDIRI4
ASGNI4
line 3972
;3972:	mi->ps.clientNum = monster->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
ADDRFP4 28
INDIRP4
INDIRI4
ASGNI4
line 3973
;3973:	mi->ps.pm_flags |= PMF_TIME_KNOCKBACK;
ADDRLP4 60
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
line 3974
;3974:	mi->ps.pm_time = 100;
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
CNSTI4 100
ASGNI4
line 3975
;3975:	mi->ps.torsoAnim = TORSO_STAND2;
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
CNSTI4 12
ASGNI4
line 3976
;3976:	mi->ps.legsAnim = LEGS_IDLE;
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
CNSTI4 22
ASGNI4
line 3977
;3977:	mi->ps.commandTime = level.time - 100;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
SUBI4
ASGNI4
line 3979
;3978:
;3979:	monster->client = NULL;
ADDRFP4 28
INDIRP4
CNSTI4 516
ADDP4
CNSTP4 0
ASGNP4
line 3980
;3980:	monster->touch = 0;
ADDRFP4 28
INDIRP4
CNSTI4 708
ADDP4
CNSTP4 0
ASGNP4
line 3981
;3981:	monster->pain = PainMonster;
ADDRFP4 28
INDIRP4
CNSTI4 716
ADDP4
ADDRGP4 PainMonster
ASGNP4
line 3982
;3982:	monster->nextthink = level.time;
ADDRFP4 28
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 3983
;3983:	monster->think = ThinkMonster;
ADDRFP4 28
INDIRP4
CNSTI4 696
ADDP4
ADDRGP4 ThinkMonster
ASGNP4
line 3984
;3984:	monster->takedamage = qtrue;
ADDRFP4 28
INDIRP4
CNSTI4 740
ADDP4
CNSTI4 1
ASGNI4
line 3985
;3985:	monster->die = MonsterDie;
ADDRFP4 28
INDIRP4
CNSTI4 720
ADDP4
ADDRGP4 MonsterDie
ASGNP4
line 3986
;3986:	monster->clipmask = MASK_PLAYERSOLID;
ADDRFP4 28
INDIRP4
CNSTI4 576
ADDP4
CNSTI4 33619969
ASGNI4
line 3987
;3987:	monster->waterlevel = 0;
ADDRFP4 28
INDIRP4
CNSTI4 792
ADDP4
CNSTI4 0
ASGNI4
line 3988
;3988:	monster->watertype = 0;
ADDRFP4 28
INDIRP4
CNSTI4 788
ADDP4
CNSTI4 0
ASGNI4
line 3989
;3989:	monster->flags = 0;
ADDRFP4 28
INDIRP4
CNSTI4 540
ADDP4
CNSTI4 0
ASGNI4
line 3990
;3990:	monster->damage = 0;
ADDRFP4 28
INDIRP4
CNSTI4 744
ADDP4
CNSTI4 0
ASGNI4
line 3992
;3991:
;3992:	G_SetOrigin(monster, spawnorigin);
ADDRFP4 28
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 3993
;3993:	VectorCopy(spawnorigin, mi->ps.origin);
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 4
INDIRB
ASGNB 12
line 3995
;3994:
;3995:	if (spawn_angles) {
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1989
line 3996
;3996:		VectorCopy(spawn_angles, monster->s.apos.trBase);
ADDRFP4 28
INDIRP4
CNSTI4 60
ADDP4
ADDRFP4 8
INDIRP4
INDIRB
ASGNB 12
line 3997
;3997:	}
ADDRGP4 $1990
JUMPV
LABELV $1989
line 3998
;3998:	else {
line 3999
;3999:		VectorSet(monster->s.apos.trBase, 0, LocallySeededRandom(&mi->seed) % 360, 0);
ADDRFP4 28
INDIRP4
CNSTI4 60
ADDP4
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
ARGP4
ADDRLP4 64
ADDRGP4 LocallySeededRandom
CALLU4
ASGNU4
ADDRLP4 68
ADDRLP4 64
INDIRU4
CNSTU4 360
MODU4
ASGNU4
ADDRFP4 28
INDIRP4
CNSTI4 64
ADDP4
ADDRLP4 68
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 68
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
ASGNF4
ADDRFP4 28
INDIRP4
CNSTI4 68
ADDP4
CNSTF4 0
ASGNF4
line 4000
;4000:	}
LABELV $1990
line 4001
;4001:	VectorClear(monster->s.apos.trDelta);
ADDRLP4 64
ADDRFP4 28
INDIRP4
ASGNP4
ADDRLP4 68
CNSTF4 0
ASGNF4
ADDRLP4 64
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 68
INDIRF4
ASGNF4
ADDRLP4 64
INDIRP4
CNSTI4 76
ADDP4
ADDRLP4 68
INDIRF4
ASGNF4
ADDRLP4 64
INDIRP4
CNSTI4 72
ADDP4
ADDRLP4 68
INDIRF4
ASGNF4
line 4002
;4002:	monster->s.angles2[YAW] = 0;
ADDRFP4 28
INDIRP4
CNSTI4 132
ADDP4
CNSTF4 0
ASGNF4
line 4003
;4003:	monster->s.apos.trType = TR_STATIONARY;
ADDRFP4 28
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 4004
;4004:	monster->s.apos.trTime = 0;
ADDRFP4 28
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 4005
;4005:	monster->s.apos.trDuration = 0;
ADDRFP4 28
INDIRP4
CNSTI4 56
ADDP4
CNSTI4 0
ASGNI4
line 4006
;4006:	VectorCopy(monster->s.apos.trBase, mi->ps.viewangles);
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
ADDRFP4 28
INDIRP4
CNSTI4 60
ADDP4
INDIRB
ASGNB 12
line 4007
;4007:	VectorCopy(monster->s.apos.trBase, mi->cmd.angles);
ADDRLP4 0
INDIRP4
CNSTI4 492
ADDP4
ADDRFP4 28
INDIRP4
CNSTI4 60
ADDP4
INDIRB
ASGNB 12
line 4009
;4008:
;4009:	mi->cmd.serverTime = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 4010
;4010:	mi->nextHealthRefresh = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 536
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 4011
;4011:	mi->lastAIFrame = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 540
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 4012
;4012:	mi->nextAIFrame = level.time + LocallySeededRandom(&mi->seed) % 100;
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
ARGP4
ADDRLP4 76
ADDRGP4 LocallySeededRandom
CALLU4
ASGNU4
ADDRLP4 0
INDIRP4
CNSTI4 544
ADDP4
ADDRGP4 level+32
INDIRI4
CVIU4 4
ADDRLP4 76
INDIRU4
CNSTU4 100
MODU4
ADDU4
CVUI4 4
ASGNI4
line 4013
;4013:	VectorCopy(monster->s.apos.trBase, mi->ideal_view);
ADDRLP4 0
INDIRP4
CNSTI4 624
ADDP4
ADDRFP4 28
INDIRP4
CNSTI4 60
ADDP4
INDIRB
ASGNB 12
line 4014
;4014:	mi->action = action;
ADDRLP4 0
INDIRP4
CNSTI4 548
ADDP4
ADDRFP4 36
INDIRI4
ASGNI4
line 4015
;4015:	mi->nextViewSearch = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 596
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 4016
;4016:	mi->nextDynViewSearch = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 600
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 4017
;4017:	mi->nextEnemySearch = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 604
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 4018
;4018:	mi->nextSpawnPoolCheck = level.time + 1000 + rand() % 1000;
ADDRLP4 80
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 608
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDI4
ADDRLP4 80
INDIRI4
CNSTI4 1000
MODI4
ADDI4
ASGNI4
line 4019
;4019:	VectorCopy(spawnorigin, mi->lastCheckedSpawnPos);
ADDRLP4 0
INDIRP4
CNSTI4 612
ADDP4
ADDRLP4 4
INDIRB
ASGNB 12
line 4020
;4020:	mi->generic1 = generic1;
ADDRLP4 0
INDIRP4
CNSTI4 704
ADDP4
ADDRFP4 40
INDIRI4
ASGNI4
line 4022
;4021:
;4022:	healthScale = G_MonsterHealthScale();
ADDRLP4 84
ADDRGP4 G_MonsterHealthScale
CALLF4
ASGNF4
ADDRLP4 48
ADDRLP4 84
INDIRF4
ASGNF4
line 4024
;4023:
;4024:	switch (type) {
ADDRLP4 88
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 0
EQI4 $2002
ADDRLP4 88
INDIRI4
CNSTI4 1
EQI4 $2009
ADDRLP4 88
INDIRI4
CNSTI4 2
EQI4 $2011
ADDRGP4 $1999
JUMPV
LABELV $2002
LABELV $1999
line 4027
;4025:	case MT_predator:
;4026:	default:
;4027:		monster->classname = "monster predator";
ADDRFP4 28
INDIRP4
CNSTI4 528
ADDP4
ADDRGP4 $2003
ASGNP4
line 4028
;4028:		mi->ps.stats[STAT_WEAPONS] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 200
ADDP4
CNSTI4 0
ASGNI4
line 4029
;4029:		monster->s.weapon = WP_NONE;
ADDRFP4 28
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 0
ASGNI4
line 4030
;4030:		mi->ps.weapon = WP_NONE;
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTI4 0
ASGNI4
line 4031
;4031:		mi->cmd.weapon = WP_NONE;
ADDRLP4 0
INDIRP4
CNSTI4 508
ADDP4
CNSTU1 0
ASGNU1
line 4032
;4032:		mi->ps.ammo[WP_NONE] = -1;
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
CNSTI4 -1
ASGNI4
line 4033
;4033:		if (g_monsterBreeding.integer && g_gametype.integer == GT_STU) {
ADDRGP4 g_monsterBreeding+12
INDIRI4
CNSTI4 0
EQI4 $2000
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
NEI4 $2000
line 4034
;4034:			mi->hibernationWaitTime = 15000 + LocallySeededRandom(&mi->seed) % 30000;
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
ARGP4
ADDRLP4 100
ADDRGP4 LocallySeededRandom
CALLU4
ASGNU4
ADDRLP4 0
INDIRP4
CNSTI4 668
ADDP4
ADDRLP4 100
INDIRU4
CNSTU4 30000
MODU4
CNSTU4 15000
ADDU4
CVUI4 4
ASGNI4
line 4035
;4035:			mi->hibernationTime = level.time + mi->hibernationWaitTime;
ADDRLP4 0
INDIRP4
CNSTI4 664
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 668
ADDP4
INDIRI4
ADDI4
ASGNI4
line 4036
;4036:		}
line 4037
;4037:		break;
ADDRGP4 $2000
JUMPV
LABELV $2009
line 4039
;4038:	case MT_guard:
;4039:		monster->classname = "monster guard";
ADDRFP4 28
INDIRP4
CNSTI4 528
ADDP4
ADDRGP4 $2010
ASGNP4
line 4040
;4040:		mi->ps.stats[STAT_WEAPONS] = (1 << WP_ROCKET_LAUNCHER);
ADDRLP4 0
INDIRP4
CNSTI4 200
ADDP4
CNSTI4 32
ASGNI4
line 4041
;4041:		monster->s.weapon = WP_ROCKET_LAUNCHER;
ADDRFP4 28
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 5
ASGNI4
line 4042
;4042:		mi->ps.weapon = WP_ROCKET_LAUNCHER;
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTI4 5
ASGNI4
line 4043
;4043:		mi->cmd.weapon = WP_ROCKET_LAUNCHER;
ADDRLP4 0
INDIRP4
CNSTI4 508
ADDP4
CNSTU1 5
ASGNU1
line 4044
;4044:		mi->ps.ammo[WP_ROCKET_LAUNCHER] = -1;
ADDRLP4 0
INDIRP4
CNSTI4 404
ADDP4
CNSTI4 -1
ASGNI4
line 4045
;4045:		mi->ps.stats[STAT_ARMOR] = maxHealth;
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
ADDRFP4 32
INDIRI4
ASGNI4
line 4046
;4046:		break;
ADDRGP4 $2000
JUMPV
LABELV $2011
line 4048
;4047:	case MT_titan:
;4048:		monster->classname = "monster titan";
ADDRFP4 28
INDIRP4
CNSTI4 528
ADDP4
ADDRGP4 $2012
ASGNP4
line 4049
;4049:		mi->ps.stats[STAT_WEAPONS] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 200
ADDP4
CNSTI4 0
ASGNI4
line 4050
;4050:		monster->s.weapon = WP_NONE;
ADDRFP4 28
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 0
ASGNI4
line 4051
;4051:		mi->ps.weapon = WP_NONE;
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTI4 0
ASGNI4
line 4052
;4052:		mi->cmd.weapon = WP_NONE;
ADDRLP4 0
INDIRP4
CNSTI4 508
ADDP4
CNSTU1 0
ASGNU1
line 4053
;4053:		mi->ps.ammo[WP_NONE] = -1;
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
CNSTI4 -1
ASGNI4
line 4054
;4054:		break;
LABELV $2000
line 4056
;4055:	}
;4056:	if (maxHealth <= 0) maxHealth = G_MonsterBaseHealth(type, healthScale);
ADDRFP4 32
INDIRI4
CNSTI4 0
GTI4 $2013
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 96
ADDRGP4 G_MonsterBaseHealth
CALLI4
ASGNI4
ADDRFP4 32
ADDRLP4 96
INDIRI4
ASGNI4
LABELV $2013
line 4057
;4057:	if (maxHealth < 1) maxHealth = 1;
ADDRFP4 32
INDIRI4
CNSTI4 1
GEI4 $2015
ADDRFP4 32
CNSTI4 1
ASGNI4
LABELV $2015
line 4058
;4058:	mi->ps.stats[STAT_MAX_HEALTH] = maxHealth;
ADDRLP4 0
INDIRP4
CNSTI4 212
ADDP4
ADDRFP4 32
INDIRI4
ASGNI4
line 4059
;4059:	mi->ps.stats[STAT_HEALTH] = maxHealth;
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
ADDRFP4 32
INDIRI4
ASGNI4
line 4060
;4060:	monster->health = maxHealth;
ADDRFP4 28
INDIRP4
CNSTI4 736
ADDP4
ADDRFP4 32
INDIRI4
ASGNI4
line 4062
;4061:
;4062:	BG_PlayerStateToEntityState(&mi->ps, &monster->s, qtrue);
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BG_PlayerStateToEntityState
CALLV
pop
line 4063
;4063:	G_MonsterCorrectEntityState(monster);
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 G_MonsterCorrectEntityState
CALLV
pop
line 4068
;4064:
;4065:	// JUHOX FIXME: why does this not work correctly?
;4066:	//G_KillBox(monster);
;4067:
;4068:	trap_LinkEntity(monster);
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 4070
;4069:
;4070:	if (!telemorph) {
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $2017
line 4071
;4071:		numMonsters++;
ADDRLP4 100
ADDRGP4 numMonsters
ASGNP4
ADDRLP4 100
INDIRP4
ADDRLP4 100
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4075
;4072:#if !ESCAPE_MODE	// JUHOX: in EFH we want monsters to spawn silently
;4073:		G_TempEntity(spawnorigin, EV_PLAYER_TELEPORT_IN);
;4074:#else
;4075:		if (g_gametype.integer != GT_EFH) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
EQI4 $2019
line 4076
;4076:			G_TempEntity(spawnorigin, EV_PLAYER_TELEPORT_IN);
ADDRLP4 4
ARGP4
CNSTI4 42
ARGI4
ADDRGP4 G_TempEntity
CALLP4
pop
line 4077
;4077:		}
LABELV $2019
line 4079
;4078:#endif
;4079:	}
LABELV $2017
line 4081
;4080:
;4081:	return monster;
ADDRFP4 28
INDIRP4
RETP4
LABELV $1971
endproc G_SpawnMonster 108 12
export G_MonsterSpawning
proc G_MonsterSpawning 128 44
line 4091
;4082:}
;4083:#endif
;4084:
;4085:/*
;4086:===============
;4087:JUHOX: G_MonsterSpawning
;4088:===============
;4089:*/
;4090:#if MONSTER_MODE
;4091:void G_MonsterSpawning(void) {
line 4105
;4092:	vec3_t mins, maxs;
;4093:	vec3_t spawnorigin;
;4094:	monsterspawnmode_t spawnmode;
;4095:	vec3_t spawnattractor;
;4096:	team_t spawnteam;
;4097:	int owner;
;4098:	int numMonstersOfOwner;
;4099:	int removeTime;
;4100:	gentity_t* monster;
;4101:	monsterType_t type;
;4102:	localseed_t localseed;
;4103:	localseed_t monsterseed;
;4104:
;4105:	if (level.meeting) return;
ADDRGP4 level+24092
INDIRI4
CNSTI4 0
EQI4 $2023
ADDRGP4 $2022
JUMPV
LABELV $2023
line 4108
;4106:
;4107:#if ESCAPE_MODE
;4108:	if (g_gametype.integer == GT_EFH) return;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
NEI4 $2026
ADDRGP4 $2022
JUMPV
LABELV $2026
line 4115
;4109:#endif
;4110:
;4111:#if SCREENSHOT_TOOLS
;4112:	if (level.stopTime) return;
;4113:#endif
;4114:
;4115:	if (level.endPhase > 0) return;
ADDRGP4 level+23012
INDIRI4
CNSTI4 0
LEI4 $2029
ADDRGP4 $2022
JUMPV
LABELV $2029
line 4117
;4116:
;4117:	if (nextMonsterSpawnTime > level.time) return;
ADDRGP4 nextMonsterSpawnTime
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $2032
ADDRGP4 $2022
JUMPV
LABELV $2032
line 4119
;4118:
;4119:	if (nextMonsterSpawnTime < 0) {
ADDRGP4 nextMonsterSpawnTime
INDIRI4
CNSTI4 0
GEI4 $2035
line 4120
;4120:		nextMonsterSpawnTime = level.startTime + 5000;
ADDRGP4 nextMonsterSpawnTime
ADDRGP4 level+40
INDIRI4
CNSTI4 5000
ADDI4
ASGNI4
line 4121
;4121:		return;
ADDRGP4 $2022
JUMPV
LABELV $2035
line 4124
;4122:	}
;4123:
;4124:	InitLocalSeed(GST_monsterSpawning, &localseed);
CNSTI4 0
ARGI4
ADDRLP4 12
ARGP4
ADDRGP4 InitLocalSeed
CALLV
pop
line 4127
;4125:
;4126:	// JUHOX FIXME: don't trust monster counting
;4127:	{
line 4130
;4128:		int i;
;4129:
;4130:		numMonsters = 0;
ADDRGP4 numMonsters
CNSTI4 0
ASGNI4
line 4131
;4131:		for (i = MAX_CLIENTS; i < level.num_entities; i++) {
ADDRLP4 108
CNSTI4 64
ASGNI4
ADDRGP4 $2041
JUMPV
LABELV $2038
line 4134
;4132:			gentity_t* ent;
;4133:
;4134:			ent = &g_entities[i];
ADDRLP4 112
ADDRLP4 108
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 4135
;4135:			if (!ent->inuse) continue;
ADDRLP4 112
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2043
ADDRGP4 $2039
JUMPV
LABELV $2043
line 4136
;4136:			if (ent->s.eType != ET_PLAYER) continue;
ADDRLP4 112
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 1
EQI4 $2045
ADDRGP4 $2039
JUMPV
LABELV $2045
line 4137
;4137:			if (!ent->monster) continue;
ADDRLP4 112
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2047
ADDRGP4 $2039
JUMPV
LABELV $2047
line 4138
;4138:			if (ent->health <= 0) continue;
ADDRLP4 112
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
GTI4 $2049
ADDRGP4 $2039
JUMPV
LABELV $2049
line 4140
;4139:
;4140:			numMonsters++;
ADDRLP4 116
ADDRGP4 numMonsters
ASGNP4
ADDRLP4 116
INDIRP4
ADDRLP4 116
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4141
;4141:		}
LABELV $2039
line 4131
ADDRLP4 108
ADDRLP4 108
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2041
ADDRLP4 108
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $2038
line 4142
;4142:	}
line 4144
;4143:
;4144:	if (firstMonsterTrap != lastMonsterTrap) {
ADDRGP4 firstMonsterTrap
INDIRI4
ADDRGP4 lastMonsterTrap
INDIRI4
EQI4 $2051
line 4145
;4145:		nextMonsterSpawnTime = level.time + 200;
ADDRGP4 nextMonsterSpawnTime
ADDRGP4 level+32
INDIRI4
CNSTI4 200
ADDI4
ASGNI4
line 4147
;4146:
;4147:		spawnmode = MSM_nearOrigin;
ADDRLP4 96
CNSTI4 1
ASGNI4
line 4148
;4148:		VectorCopy(monsterTraps[firstMonsterTrap].origin, spawnattractor);
ADDRLP4 44
ADDRGP4 firstMonsterTrap
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 monsterTraps
ADDP4
INDIRB
ASGNB 12
line 4149
;4149:		spawnteam = TEAM_FREE;
ADDRLP4 100
CNSTI4 0
ASGNI4
line 4150
;4150:		owner = -1;
ADDRLP4 0
CNSTI4 -1
ASGNI4
line 4151
;4151:		numMonstersOfOwner = -1;
ADDRLP4 4
CNSTI4 -1
ASGNI4
line 4152
;4152:		removeTime = 0;
ADDRLP4 104
CNSTI4 0
ASGNI4
line 4154
;4153:
;4154:		monsterTraps[firstMonsterTrap].numMonsters--;
ADDRLP4 108
ADDRGP4 firstMonsterTrap
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 monsterTraps+12
ADDP4
ASGNP4
ADDRLP4 108
INDIRP4
ADDRLP4 108
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 4155
;4155:		if (monsterTraps[firstMonsterTrap].numMonsters <= 0) {
ADDRGP4 firstMonsterTrap
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 monsterTraps+12
ADDP4
INDIRI4
CNSTI4 0
GTI4 $2052
line 4156
;4156:			firstMonsterTrap = (firstMonsterTrap + 1) % MAX_MONSTER_TRAPS;
ADDRLP4 112
ADDRGP4 firstMonsterTrap
ASGNP4
ADDRLP4 112
INDIRP4
ADDRLP4 112
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 20
MODI4
ASGNI4
line 4157
;4157:		}
line 4158
;4158:	}
ADDRGP4 $2052
JUMPV
LABELV $2051
line 4159
;4159:	else if (firstMonsterSeed != lastMonsterSeed) {
ADDRGP4 firstMonsterSeed
INDIRI4
ADDRGP4 lastMonsterSeed
INDIRI4
EQI4 $2058
line 4163
;4160:		gentity_t* seed;
;4161:		int i;
;4162:
;4163:		nextMonsterSpawnTime = level.time + 200;
ADDRGP4 nextMonsterSpawnTime
ADDRGP4 level+32
INDIRI4
CNSTI4 200
ADDI4
ASGNI4
line 4165
;4164:
;4165:		spawnmode = MSM_atOrigin;
ADDRLP4 96
CNSTI4 2
ASGNI4
line 4166
;4166:		seed = monsterSeeds[firstMonsterSeed].seed;
ADDRLP4 112
ADDRGP4 firstMonsterSeed
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 monsterSeeds+12
ADDP4
INDIRP4
ASGNP4
line 4167
;4167:		owner = seed->r.ownerNum;
ADDRLP4 0
ADDRLP4 112
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
ASGNI4
line 4168
;4168:		if (owner < 0 || owner >= MAX_CLIENTS) return;
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $2064
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $2062
LABELV $2064
ADDRGP4 $2022
JUMPV
LABELV $2062
line 4169
;4169:		G_FreeEntity(seed);
ADDRLP4 112
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 4170
;4170:		spawnteam = level.clients[owner].sess.sessionTeam;
ADDRLP4 100
ADDRLP4 0
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 696
ADDP4
INDIRI4
ASGNI4
line 4171
;4171:		VectorCopy(monsterSeeds[firstMonsterSeed].origin, spawnattractor);
ADDRLP4 44
ADDRGP4 firstMonsterSeed
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 monsterSeeds
ADDP4
INDIRB
ASGNB 12
line 4172
;4172:		firstMonsterSeed = (firstMonsterSeed + 1) % MAX_MONSTER_SEEDS;
ADDRLP4 120
ADDRGP4 firstMonsterSeed
ASGNP4
ADDRLP4 120
INDIRP4
ADDRLP4 120
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 200
MODI4
ASGNI4
line 4174
;4173:
;4174:		numMonstersOfOwner = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 4175
;4175:		for (i = 0; i < level.num_entities; i++) {
ADDRLP4 108
CNSTI4 0
ASGNI4
ADDRGP4 $2068
JUMPV
LABELV $2065
line 4178
;4176:			gentity_t* ent;
;4177:
;4178:			ent = &g_entities[i];
ADDRLP4 124
ADDRLP4 108
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 4179
;4179:			if (!ent->inuse) continue;
ADDRLP4 124
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2070
ADDRGP4 $2066
JUMPV
LABELV $2070
line 4180
;4180:			if (ent->s.eType != ET_PLAYER) continue;
ADDRLP4 124
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 1
EQI4 $2072
ADDRGP4 $2066
JUMPV
LABELV $2072
line 4181
;4181:			if (!ent->monster) continue;
ADDRLP4 124
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2074
ADDRGP4 $2066
JUMPV
LABELV $2074
line 4182
;4182:			if (ent->health <= 0) continue;
ADDRLP4 124
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
GTI4 $2076
ADDRGP4 $2066
JUMPV
LABELV $2076
line 4183
;4183:			if (ent->monster->owner != owner) continue;
ADDRLP4 124
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 484
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
EQI4 $2078
ADDRGP4 $2066
JUMPV
LABELV $2078
line 4185
;4184:
;4185:			numMonstersOfOwner++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4186
;4186:		}
LABELV $2066
line 4175
ADDRLP4 108
ADDRLP4 108
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2068
ADDRLP4 108
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $2065
line 4188
;4187:
;4188:		removeTime = level.time + 30000;
ADDRLP4 104
ADDRGP4 level+32
INDIRI4
CNSTI4 30000
ADDI4
ASGNI4
line 4189
;4189:	}
ADDRGP4 $2059
JUMPV
LABELV $2058
line 4190
;4190:	else if (g_gametype.integer == GT_STU) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
NEI4 $2022
line 4191
;4191:		if (numMonsters >= g_minMonsters.integer - 1 && g_monsterSpawnDelay.integer > 200) {
ADDRGP4 numMonsters
INDIRI4
ADDRGP4 g_minMonsters+12
INDIRI4
CNSTI4 1
SUBI4
LTI4 $2084
ADDRGP4 g_monsterSpawnDelay+12
INDIRI4
CNSTI4 200
LEI4 $2084
line 4192
;4192:			nextMonsterSpawnTime = level.time + g_monsterSpawnDelay.integer;
ADDRGP4 nextMonsterSpawnTime
ADDRGP4 level+32
INDIRI4
ADDRGP4 g_monsterSpawnDelay+12
INDIRI4
ADDI4
ASGNI4
line 4193
;4193:		}
ADDRGP4 $2085
JUMPV
LABELV $2084
line 4194
;4194:		else {
line 4195
;4195:			nextMonsterSpawnTime = level.time + 200;
ADDRGP4 nextMonsterSpawnTime
ADDRGP4 level+32
INDIRI4
CNSTI4 200
ADDI4
ASGNI4
line 4196
;4196:		}
LABELV $2085
line 4198
;4197:
;4198:		spawnmode = MSM_random;
ADDRLP4 96
CNSTI4 0
ASGNI4
line 4199
;4199:		VectorClear(spawnattractor);
ADDRLP4 108
CNSTF4 0
ASGNF4
ADDRLP4 44+8
ADDRLP4 108
INDIRF4
ASGNF4
ADDRLP4 44+4
ADDRLP4 108
INDIRF4
ASGNF4
ADDRLP4 44
ADDRLP4 108
INDIRF4
ASGNF4
line 4200
;4200:		spawnteam = TEAM_FREE;
ADDRLP4 100
CNSTI4 0
ASGNI4
line 4201
;4201:		owner = -1;
ADDRLP4 0
CNSTI4 -1
ASGNI4
line 4202
;4202:		numMonstersOfOwner = -1;
ADDRLP4 4
CNSTI4 -1
ASGNI4
line 4203
;4203:		removeTime = 0;
ADDRLP4 104
CNSTI4 0
ASGNI4
line 4204
;4204:	}
line 4205
;4205:	else {
line 4206
;4206:		return;
LABELV $2082
LABELV $2059
LABELV $2052
line 4209
;4207:	}
;4208:
;4209:	DeriveLocalSeed(&localseed, &monsterseed);
ADDRLP4 12
ARGP4
ADDRLP4 80
ARGP4
ADDRGP4 DeriveLocalSeed
CALLV
pop
line 4211
;4210:
;4211:	switch (g_gametype.integer) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
EQI4 $2096
ADDRGP4 $2093
JUMPV
LABELV $2096
line 4213
;4212:	case GT_STU:
;4213:		type = G_MonsterType(&localseed);
ADDRLP4 12
ARGP4
ADDRLP4 108
ADDRGP4 G_MonsterType
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 108
INDIRI4
ASGNI4
line 4214
;4214:		break;
ADDRGP4 $2094
JUMPV
LABELV $2093
line 4216
;4215:	default:
;4216:		type = MT_predator;
ADDRLP4 40
CNSTI4 0
ASGNI4
line 4217
;4217:		break;
LABELV $2094
line 4220
;4218:	}
;4219:
;4220:	G_GetMonsterBounds(type, mins, maxs);
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 56
ARGP4
ADDRLP4 68
ARGP4
ADDRGP4 G_GetMonsterBounds
CALLV
pop
line 4222
;4221:
;4222:	if (!G_GetMonsterSpawnPoint(mins, maxs, &localseed, spawnorigin, spawnmode, spawnattractor)) return;
ADDRLP4 56
ARGP4
ADDRLP4 68
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 28
ARGP4
ADDRLP4 96
INDIRI4
ARGI4
ADDRLP4 44
ARGP4
ADDRLP4 108
ADDRGP4 G_GetMonsterSpawnPoint
CALLI4
ASGNI4
ADDRLP4 108
INDIRI4
CNSTI4 0
NEI4 $2097
ADDRGP4 $2022
JUMPV
LABELV $2097
line 4224
;4223:
;4224:	monster = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 4226
;4225:	if (
;4226:		numMonsters >= g_maxMonsters.integer ||
ADDRLP4 112
ADDRGP4 numMonsters
INDIRI4
ASGNI4
ADDRLP4 112
INDIRI4
ADDRGP4 g_maxMonsters+12
INDIRI4
GEI4 $2108
ADDRLP4 112
INDIRI4
CNSTI4 200
GEI4 $2108
ADDRGP4 freeMonster
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2108
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $2099
ADDRLP4 4
INDIRI4
ADDRGP4 g_maxMonsters+12
INDIRI4
ADDRGP4 level+96
INDIRI4
DIVI4
GEI4 $2108
ADDRLP4 4
INDIRI4
CNSTI4 200
ADDRGP4 level+96
INDIRI4
DIVI4
LTI4 $2099
LABELV $2108
line 4236
;4227:		numMonsters >= MAX_MONSTERS ||
;4228:		!freeMonster ||
;4229:		(
;4230:			owner >= 0 &&
;4231:			(
;4232:				numMonstersOfOwner >= g_maxMonsters.integer / level.numPlayingClients ||
;4233:				numMonstersOfOwner >= MAX_MONSTERS / level.numPlayingClients
;4234:			)
;4235:		)
;4236:	) {
line 4237
;4237:		monster = RandomWaitingMonster(&localseed, owner);
ADDRLP4 12
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 120
ADDRGP4 RandomWaitingMonster
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 120
INDIRP4
ASGNP4
line 4238
;4238:		if (!monster) return;
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2109
ADDRGP4 $2022
JUMPV
LABELV $2109
line 4239
;4239:		if (!monster->monster) return;
ADDRLP4 8
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2111
ADDRGP4 $2022
JUMPV
LABELV $2111
line 4240
;4240:		TeleportPlayer(monster, spawnorigin, vec3_origin);
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 28
ARGP4
ADDRGP4 vec3_origin
ARGP4
ADDRGP4 TeleportPlayer
CALLV
pop
line 4241
;4241:	}
LABELV $2099
line 4243
;4242:
;4243:	G_SpawnMonster(
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 28
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 104
INDIRI4
ARGI4
ADDRLP4 100
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 80
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 -1
ARGI4
ADDRGP4 G_SpawnMonster
CALLP4
pop
line 4246
;4244:		type, spawnorigin, NULL, removeTime, spawnteam, owner, &monsterseed, monster, 0, MA_waiting, -1
;4245:	);
;4246:}
LABELV $2022
endproc G_MonsterSpawning 128 44
export G_GetEntityPlayerState
proc G_GetEntityPlayerState 0 0
line 4254
;4247:#endif
;4248:
;4249:/*
;4250:===============
;4251:JUHOX: G_GetEntityPlayerState
;4252:===============
;4253:*/
;4254:playerState_t* G_GetEntityPlayerState(const gentity_t* ent) {
line 4255
;4255:	if (ent->client) return &ent->client->ps;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2114
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
RETP4
ADDRGP4 $2113
JUMPV
LABELV $2114
line 4257
;4256:#if MONSTER_MODE
;4257:	if (ent->monster) return &ent->monster->ps;
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2116
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 8
ADDP4
RETP4
ADDRGP4 $2113
JUMPV
LABELV $2116
line 4259
;4258:#endif
;4259:	return NULL;
CNSTP4 0
RETP4
LABELV $2113
endproc G_GetEntityPlayerState 0 0
export G_IsMonsterNearEntity
proc G_IsMonsterNearEntity 72 28
line 4268
;4260:}
;4261:
;4262:/*
;4263:===============
;4264:JUHOX: G_IsMonsterNearEntity
;4265:===============
;4266:*/
;4267:#if MONSTER_MODE
;4268:qboolean G_IsMonsterNearEntity(gentity_t* viewer, gentity_t* ent) {
line 4271
;4269:	int i;
;4270:
;4271:	for (i = 0; i < MAX_MONSTERS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2119
line 4275
;4272:		gmonster_t* mi;
;4273:		trace_t trace;
;4274:
;4275:		mi = &monsterInfo[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 708
MULI4
ADDRGP4 monsterInfo
ADDP4
ASGNP4
line 4276
;4276:		if (!mi->ps.clientNum) continue;
ADDRLP4 4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2123
ADDRGP4 $2120
JUMPV
LABELV $2123
line 4278
;4277:
;4278:		if (DistanceSquared(ent->s.pos.trBase, mi->ps.origin) > 700 * 700) continue;
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 28
ADDP4
ARGP4
ADDRLP4 64
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 64
INDIRF4
CNSTF4 1223639552
LEF4 $2125
ADDRGP4 $2120
JUMPV
LABELV $2125
line 4280
;4279:
;4280:		trap_Trace(&trace, viewer->s.pos.trBase, NULL, NULL, mi->ps.origin, viewer->s.number, MASK_SHOT);
ADDRLP4 8
ARGP4
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 28
ADDP4
ARGP4
ADDRLP4 68
INDIRP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 4281
;4281:		if (trace.fraction >= 1 || trace.entityNum != mi->ps.clientNum) continue;
ADDRLP4 8+8
INDIRF4
CNSTF4 1065353216
GEF4 $2131
ADDRLP4 8+52
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
EQI4 $2127
LABELV $2131
ADDRGP4 $2120
JUMPV
LABELV $2127
line 4283
;4282:
;4283:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2118
JUMPV
LABELV $2120
line 4271
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 200
LTI4 $2119
line 4285
;4284:	}
;4285:	return qfalse;
CNSTI4 0
RETI4
LABELV $2118
endproc G_IsMonsterNearEntity 72 28
export G_IsMonsterSuccessfulAttacking
proc G_IsMonsterSuccessfulAttacking 4 0
line 4295
;4286:}
;4287:#endif
;4288:
;4289:/*
;4290:===============
;4291:JUHOX: G_IsMonsterSuccessfulAttacking
;4292:===============
;4293:*/
;4294:#if MONSTER_MODE
;4295:qboolean G_IsMonsterSuccessfulAttacking(gentity_t* monster, gentity_t* exception) {
line 4298
;4296:	gmonster_t* mi;
;4297:
;4298:	mi = monster->monster;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
ASGNP4
line 4299
;4299:	if (!mi) return qfalse;
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2133
CNSTI4 0
RETI4
ADDRGP4 $2132
JUMPV
LABELV $2133
line 4301
;4300:
;4301:	if (mi->action != MA_attacking) return qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
CNSTI4 2
EQI4 $2135
CNSTI4 0
RETI4
ADDRGP4 $2132
JUMPV
LABELV $2135
line 4302
;4302:	if (mi->lastEnemyHitTime < level.time - 3000) return qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 3000
SUBI4
GEI4 $2137
CNSTI4 0
RETI4
ADDRGP4 $2132
JUMPV
LABELV $2137
line 4304
;4303:
;4304:	if (mi->enemy == exception) return qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 556
ADDP4
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CVPU4 4
NEU4 $2140
CNSTI4 0
RETI4
ADDRGP4 $2132
JUMPV
LABELV $2140
line 4306
;4305:
;4306:	return qtrue;
CNSTI4 1
RETI4
LABELV $2132
endproc G_IsMonsterSuccessfulAttacking 4 0
export G_ChargeMonsters
proc G_ChargeMonsters 16 0
line 4316
;4307:}
;4308:#endif
;4309:
;4310:/*
;4311:===============
;4312:JUHOX: G_ChargeMonsters
;4313:===============
;4314:*/
;4315:#if MONSTER_MODE
;4316:void G_ChargeMonsters(int msec, int chargePerSec) {
line 4319
;4317:	int i;
;4318:
;4319:	for (i = 0; i < MAX_MONSTERS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2143
line 4323
;4320:		gmonster_t* mi;
;4321:		int charge;
;4322:
;4323:		mi = &monsterInfo[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 708
MULI4
ADDRGP4 monsterInfo
ADDP4
ASGNP4
line 4324
;4324:		if (!mi->ps.clientNum) continue;
ADDRLP4 4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2147
ADDRGP4 $2144
JUMPV
LABELV $2147
line 4325
;4325:		if (!mi->entity) continue;
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2149
ADDRGP4 $2144
JUMPV
LABELV $2149
line 4327
;4326:
;4327:		charge = msec * (rand() % chargePerSec) / 500;
ADDRLP4 12
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 8
ADDRFP4 0
INDIRI4
ADDRLP4 12
INDIRI4
ADDRFP4 4
INDIRI4
MODI4
MULI4
CNSTI4 500
DIVI4
ASGNI4
line 4328
;4328:		if (mi->type == MT_guard) charge *= 2;	// otherwise it would last too long to kill it
ADDRLP4 4
INDIRP4
CNSTI4 476
ADDP4
INDIRI4
CNSTI4 1
NEI4 $2151
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
LABELV $2151
line 4329
;4329:		if (mi->type == MT_titan) charge *= 3;
ADDRLP4 4
INDIRP4
CNSTI4 476
ADDP4
INDIRI4
CNSTI4 2
NEI4 $2153
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 3
MULI4
ASGNI4
LABELV $2153
line 4330
;4330:		if (mi->ps.powerups[PW_CHARGE] > level.time) {
ADDRLP4 4
INDIRP4
CNSTI4 360
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $2155
line 4331
;4331:			charge += mi->ps.powerups[PW_CHARGE] - level.time;
ADDRLP4 8
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 360
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
SUBI4
ADDI4
ASGNI4
line 4332
;4332:		}
LABELV $2155
line 4333
;4333:		mi->ps.powerups[PW_CHARGE] = level.time + charge;
ADDRLP4 4
INDIRP4
CNSTI4 360
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 8
INDIRI4
ADDI4
ASGNI4
line 4335
;4334:		//mi->entity->s.time2 = mi->ps.powerups[PW_CHARGE];
;4335:	}
LABELV $2144
line 4319
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 200
LTI4 $2143
line 4336
;4336:}
LABELV $2142
endproc G_ChargeMonsters 16 0
export G_IsAttackingGuard
proc G_IsAttackingGuard 8 0
line 4345
;4337:#endif
;4338:
;4339:/*
;4340:===============
;4341:JUHOX: G_IsAttackingGuard
;4342:===============
;4343:*/
;4344:#if MONSTER_MODE
;4345:qboolean G_IsAttackingGuard(int entnum) {
line 4348
;4346:	const gentity_t* ent;
;4347:
;4348:	if (entnum < 0 || entnum >= ENTITYNUM_WORLD) return qfalse;
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $2163
ADDRLP4 4
INDIRI4
CNSTI4 1022
LTI4 $2161
LABELV $2163
CNSTI4 0
RETI4
ADDRGP4 $2160
JUMPV
LABELV $2161
line 4349
;4349:	ent = &g_entities[entnum];
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 4350
;4350:	if (!ent->inuse) return qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2164
CNSTI4 0
RETI4
ADDRGP4 $2160
JUMPV
LABELV $2164
line 4351
;4351:	if (!ent->monster) return qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2166
CNSTI4 0
RETI4
ADDRGP4 $2160
JUMPV
LABELV $2166
line 4352
;4352:	if (ent->monster->type != MT_guard) return qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 476
ADDP4
INDIRI4
CNSTI4 1
EQI4 $2168
CNSTI4 0
RETI4
ADDRGP4 $2160
JUMPV
LABELV $2168
line 4353
;4353:	if (ent->monster->action != MA_attacking) return qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
CNSTI4 2
EQI4 $2170
CNSTI4 0
RETI4
ADDRGP4 $2160
JUMPV
LABELV $2170
line 4354
;4354:	return qtrue;
CNSTI4 1
RETI4
LABELV $2160
endproc G_IsAttackingGuard 8 0
export G_MonsterOwner
proc G_MonsterOwner 8 0
line 4364
;4355:}
;4356:#endif
;4357:
;4358:/*
;4359:===============
;4360:JUHOX: G_MonsterOwner
;4361:===============
;4362:*/
;4363:#if MONSTER_MODE
;4364:gentity_t* G_MonsterOwner(gentity_t* monster) {
line 4367
;4365:	int ownernum;
;4366:
;4367:	if (!monster->monster) return NULL;
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2173
CNSTP4 0
RETP4
ADDRGP4 $2172
JUMPV
LABELV $2173
line 4368
;4368:	ownernum = monster->monster->owner;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 484
ADDP4
INDIRI4
ASGNI4
line 4369
;4369:	if (ownernum < 0 || ownernum >= level.maxclients) return NULL;
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $2178
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $2175
LABELV $2178
CNSTP4 0
RETP4
ADDRGP4 $2172
JUMPV
LABELV $2175
line 4370
;4370:	return &g_entities[ownernum];
ADDRLP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
RETP4
LABELV $2172
endproc G_MonsterOwner 8 0
export G_IsFriendlyMonster
proc G_IsFriendlyMonster 20 4
line 4380
;4371:}
;4372:#endif
;4373:
;4374:/*
;4375:===============
;4376:JUHOX: G_IsFriendlyMonster
;4377:===============
;4378:*/
;4379:#if MONSTER_MODE
;4380:qboolean G_IsFriendlyMonster(gentity_t* ent1, gentity_t* ent2) {
line 4383
;4381:	playerState_t* ps;
;4382:
;4383:	if (!ent2->monster) {
ADDRFP4 4
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2180
line 4386
;4384:		gentity_t* e;
;4385:
;4386:		if (!ent1->monster) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2182
CNSTI4 0
RETI4
ADDRGP4 $2179
JUMPV
LABELV $2182
line 4388
;4387:
;4388:		e = ent2;
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
line 4389
;4389:		ent2 = ent1;
ADDRFP4 4
ADDRFP4 0
INDIRP4
ASGNP4
line 4390
;4390:		ent1 = e;
ADDRFP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 4391
;4391:	}
LABELV $2180
line 4393
;4392:
;4393:	if (ent1 == ent2) return qtrue;
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CVPU4 4
NEU4 $2184
CNSTI4 1
RETI4
ADDRGP4 $2179
JUMPV
LABELV $2184
line 4395
;4394:
;4395:	ps = G_GetEntityPlayerState(ent1);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 4396
;4396:	if (!ps) return qtrue;	// a monster is "friendly" to everything not a player
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2186
CNSTI4 1
RETI4
ADDRGP4 $2179
JUMPV
LABELV $2186
line 4398
;4397:
;4398:	if (ent2->monster->enemy == ent1) return qfalse;
ADDRFP4 4
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 556
ADDP4
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
NEU4 $2188
CNSTI4 0
RETI4
ADDRGP4 $2179
JUMPV
LABELV $2188
line 4399
;4399:	if (ent1->monster && ent1->monster->enemy == ent2) return qfalse;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2190
ADDRLP4 8
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 556
ADDP4
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CVPU4 4
NEU4 $2190
CNSTI4 0
RETI4
ADDRGP4 $2179
JUMPV
LABELV $2190
line 4401
;4400:
;4401:	if (ent2->monster->type == MT_titan) return qfalse;
ADDRFP4 4
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 476
ADDP4
INDIRI4
CNSTI4 2
NEI4 $2192
CNSTI4 0
RETI4
ADDRGP4 $2179
JUMPV
LABELV $2192
line 4402
;4402:	if (ent1->monster && ent1->monster->type == MT_titan) return qfalse;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2194
ADDRLP4 12
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 476
ADDP4
INDIRI4
CNSTI4 2
NEI4 $2194
CNSTI4 0
RETI4
ADDRGP4 $2179
JUMPV
LABELV $2194
line 4405
;4403:
;4404:	if (
;4405:		g_gametype.integer >= GT_TEAM &&
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $2196
ADDRLP4 0
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
NEI4 $2196
line 4407
;4406:		ps->persistant[PERS_TEAM] == ent2->monster->ps.persistant[PERS_TEAM]
;4407:	) {
line 4408
;4408:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2179
JUMPV
LABELV $2196
line 4411
;4409:	}
;4410:
;4411:	if (ent2->monster->owner == ps->clientNum) return qtrue;
ADDRFP4 4
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 484
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
NEI4 $2199
CNSTI4 1
RETI4
ADDRGP4 $2179
JUMPV
LABELV $2199
line 4412
;4412:	if (ent1->monster && ent1->monster->owner == ent2->monster->owner) return qtrue;
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2201
ADDRLP4 16
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 484
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 484
ADDP4
INDIRI4
NEI4 $2201
CNSTI4 1
RETI4
ADDRGP4 $2179
JUMPV
LABELV $2201
line 4414
;4413:
;4414:	return qfalse;
CNSTI4 0
RETI4
LABELV $2179
endproc G_IsFriendlyMonster 20 4
export G_Constitution
proc G_Constitution 8 0
line 4423
;4415:}
;4416:#endif
;4417:
;4418:/*
;4419:===============
;4420:JUHOX: G_Constitution
;4421:===============
;4422:*/
;4423:int G_Constitution(const gentity_t* ent) {
line 4424
;4424:	if (!ent->inuse) return 0;
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2204
CNSTI4 0
RETI4
ADDRGP4 $2203
JUMPV
LABELV $2204
line 4426
;4425:
;4426:	if (ent->client) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2206
line 4427
;4427:		return (3 * ent->client->ps.stats[STAT_MAX_HEALTH]) / 2;	// assume 50% armor
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 3
MULI4
CNSTI4 2
DIVI4
RETI4
ADDRGP4 $2203
JUMPV
LABELV $2206
line 4431
;4428:	}
;4429:
;4430:#if MONSTER_MODE
;4431:	if (ent->monster) {
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2208
line 4432
;4432:		switch (ent->monster->type) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 476
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $2213
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $2214
ADDRLP4 0
INDIRI4
CNSTI4 2
EQI4 $2215
ADDRGP4 $2210
JUMPV
LABELV $2213
line 4434
;4433:		case MT_predator:
;4434:			return ent->monster->ps.stats[STAT_MAX_HEALTH];
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
RETI4
ADDRGP4 $2203
JUMPV
LABELV $2214
line 4436
;4435:		case MT_guard:
;4436:			return 2 * ent->monster->ps.stats[STAT_MAX_HEALTH];	// consider armor
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 1
LSHI4
RETI4
ADDRGP4 $2203
JUMPV
LABELV $2215
line 4438
;4437:		case MT_titan:
;4438:			return ent->monster->ps.stats[STAT_MAX_HEALTH];
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
RETI4
ADDRGP4 $2203
JUMPV
LABELV $2210
line 4440
;4439:		default:
;4440:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $2203
JUMPV
LABELV $2208
line 4445
;4441:		}
;4442:	}
;4443:#endif
;4444:
;4445:	return 0;
CNSTI4 0
RETI4
LABELV $2203
endproc G_Constitution 8 0
export G_ReleaseTrap
proc G_ReleaseTrap 4 0
line 4454
;4446:}
;4447:
;4448:/*
;4449:===============
;4450:JUHOX: G_ReleaseTrap
;4451:===============
;4452:*/
;4453:#if MONSTER_MODE
;4454:void G_ReleaseTrap(int numMonsters, const vec3_t origin) {
line 4457
;4455:	int nextMonsterTrap;
;4456:
;4457:	if (numMonsters <= 0) return;
ADDRFP4 0
INDIRI4
CNSTI4 0
GTI4 $2217
ADDRGP4 $2216
JUMPV
LABELV $2217
line 4459
;4458:
;4459:	nextMonsterTrap = (lastMonsterTrap + 1) % MAX_MONSTER_TRAPS;
ADDRLP4 0
ADDRGP4 lastMonsterTrap
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 20
MODI4
ASGNI4
line 4460
;4460:	if (nextMonsterTrap == firstMonsterTrap) return;
ADDRLP4 0
INDIRI4
ADDRGP4 firstMonsterTrap
INDIRI4
NEI4 $2219
ADDRGP4 $2216
JUMPV
LABELV $2219
line 4462
;4461:
;4462:	VectorCopy(origin, monsterTraps[lastMonsterTrap].origin);
ADDRGP4 lastMonsterTrap
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 monsterTraps
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 4463
;4463:	monsterTraps[lastMonsterTrap].numMonsters = numMonsters;
ADDRGP4 lastMonsterTrap
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 monsterTraps+12
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 4464
;4464:	lastMonsterTrap = nextMonsterTrap;
ADDRGP4 lastMonsterTrap
ADDRLP4 0
INDIRI4
ASGNI4
line 4466
;4465:
;4466:	if (nextMonsterSpawnTime > level.time + 200) {
ADDRGP4 nextMonsterSpawnTime
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 200
ADDI4
LEI4 $2222
line 4467
;4467:		nextMonsterSpawnTime = level.time;
ADDRGP4 nextMonsterSpawnTime
ADDRGP4 level+32
INDIRI4
ASGNI4
line 4468
;4468:	}
LABELV $2222
line 4469
;4469:}
LABELV $2216
endproc G_ReleaseTrap 4 0
export G_AddMonsterSeed
proc G_AddMonsterSeed 4 0
line 4478
;4470:#endif
;4471:
;4472:/*
;4473:===============
;4474:JUHOX: G_AddMonsterSeed
;4475:===============
;4476:*/
;4477:#if MONSTER_MODE
;4478:qboolean G_AddMonsterSeed(const vec3_t origin, gentity_t* seed) {
line 4481
;4479:	int nextMonsterSeed;
;4480:
;4481:	nextMonsterSeed = (lastMonsterSeed + 1) % MAX_MONSTER_SEEDS;
ADDRLP4 0
ADDRGP4 lastMonsterSeed
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 200
MODI4
ASGNI4
line 4482
;4482:	if (nextMonsterSeed == firstMonsterSeed) return qfalse;
ADDRLP4 0
INDIRI4
ADDRGP4 firstMonsterSeed
INDIRI4
NEI4 $2227
CNSTI4 0
RETI4
ADDRGP4 $2226
JUMPV
LABELV $2227
line 4484
;4483:
;4484:	VectorCopy(origin, monsterSeeds[lastMonsterSeed].origin);
ADDRGP4 lastMonsterSeed
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 monsterSeeds
ADDP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 4485
;4485:	monsterSeeds[lastMonsterSeed].seed = seed;
ADDRGP4 lastMonsterSeed
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 monsterSeeds+12
ADDP4
ADDRFP4 4
INDIRP4
ASGNP4
line 4486
;4486:	lastMonsterSeed = nextMonsterSeed;
ADDRGP4 lastMonsterSeed
ADDRLP4 0
INDIRI4
ASGNI4
line 4488
;4487:
;4488:	if (nextMonsterSpawnTime > level.time + 200) {
ADDRGP4 nextMonsterSpawnTime
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 200
ADDI4
LEI4 $2230
line 4489
;4489:		nextMonsterSpawnTime = level.time;
ADDRGP4 nextMonsterSpawnTime
ADDRGP4 level+32
INDIRI4
ASGNI4
line 4490
;4490:	}
LABELV $2230
line 4491
;4491:	return qtrue;
CNSTI4 1
RETI4
LABELV $2226
endproc G_AddMonsterSeed 4 0
export G_UpdateMonsterCounters
proc G_UpdateMonsterCounters 24 0
line 4501
;4492:}
;4493:#endif
;4494:
;4495:/*
;4496:===============
;4497:JUHOX: G_UpdateMonsterCounters
;4498:===============
;4499:*/
;4500:#if MONSTER_MODE
;4501:void G_UpdateMonsterCounters(void) {
line 4504
;4502:	int i;
;4503:
;4504:	if (g_gametype.integer >= GT_STU) return;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
LTI4 $2235
ADDRGP4 $2234
JUMPV
LABELV $2235
line 4505
;4505:	if (!g_monsterLauncher.integer) return;
ADDRGP4 g_monsterLauncher+12
INDIRI4
CNSTI4 0
NEI4 $2238
ADDRGP4 $2234
JUMPV
LABELV $2238
line 4507
;4506:
;4507:	level.maxMonstersPerPlayer = g_maxMonsters.integer;
ADDRGP4 level+22992
ADDRGP4 g_maxMonsters+12
INDIRI4
ASGNI4
line 4508
;4508:	if (level.numPlayingClients > 0) level.maxMonstersPerPlayer /= level.numPlayingClients;
ADDRGP4 level+96
INDIRI4
CNSTI4 0
LEI4 $2243
ADDRLP4 4
ADDRGP4 level+22992
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
ADDRGP4 level+96
INDIRI4
DIVI4
ASGNI4
LABELV $2243
line 4509
;4509:	if (level.maxMonstersPerPlayer > g_maxMonstersPP.integer) {
ADDRGP4 level+22992
INDIRI4
ADDRGP4 g_maxMonstersPP+12
INDIRI4
LEI4 $2248
line 4510
;4510:		level.maxMonstersPerPlayer = g_maxMonstersPP.integer;
ADDRGP4 level+22992
ADDRGP4 g_maxMonstersPP+12
INDIRI4
ASGNI4
line 4511
;4511:	}
LABELV $2248
line 4513
;4512:
;4513:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2257
JUMPV
LABELV $2254
line 4514
;4514:		level.clients[i].monstersAvailable = level.maxMonstersPerPlayer;
ADDRLP4 0
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 964
ADDP4
ADDRGP4 level+22992
INDIRI4
ASGNI4
line 4515
;4515:	}
LABELV $2255
line 4513
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2257
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $2254
line 4517
;4516:
;4517:	for (i = MAX_CLIENTS; i < level.num_entities; i++) {
ADDRLP4 0
CNSTI4 64
ASGNI4
ADDRGP4 $2263
JUMPV
LABELV $2260
line 4522
;4518:		gentity_t* ent;
;4519:		gmonster_t* mi;
;4520:		gclient_t* client;
;4521:
;4522:		ent = &g_entities[i];
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 4523
;4523:		if (!ent->inuse) continue;
ADDRLP4 8
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2265
ADDRGP4 $2261
JUMPV
LABELV $2265
line 4526
;4524:
;4525:
;4526:		mi = ent->monster;
ADDRLP4 12
ADDRLP4 8
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
ASGNP4
line 4527
;4527:		if (!mi) {
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2267
line 4528
;4528:			if (ent->s.eType != ET_MISSILE) continue;
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
EQI4 $2269
ADDRGP4 $2261
JUMPV
LABELV $2269
line 4529
;4529:			if (ent->s.weapon != WP_MONSTER_LAUNCHER) continue;
ADDRLP4 8
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 11
EQI4 $2271
ADDRGP4 $2261
JUMPV
LABELV $2271
line 4531
;4530:
;4531:			client = ent->parent->client;
ADDRLP4 16
ADDRLP4 8
INDIRP4
CNSTI4 604
ADDP4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 4532
;4532:			if (!client) continue;
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2268
ADDRGP4 $2261
JUMPV
line 4533
;4533:		}
LABELV $2267
line 4534
;4534:		else {
line 4535
;4535:			if (ent->health <= 0) continue;
ADDRLP4 8
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
GTI4 $2275
ADDRGP4 $2261
JUMPV
LABELV $2275
line 4537
;4536:
;4537:			if (mi->owner < 0) continue;
ADDRLP4 12
INDIRP4
CNSTI4 484
ADDP4
INDIRI4
CNSTI4 0
GEI4 $2277
ADDRGP4 $2261
JUMPV
LABELV $2277
line 4538
;4538:			if (mi->owner >= MAX_CLIENTS) continue;
ADDRLP4 12
INDIRP4
CNSTI4 484
ADDP4
INDIRI4
CNSTI4 64
LTI4 $2279
ADDRGP4 $2261
JUMPV
LABELV $2279
line 4540
;4539:
;4540:			client = &level.clients[mi->owner];
ADDRLP4 16
ADDRLP4 12
INDIRP4
CNSTI4 484
ADDP4
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 4541
;4541:		}
LABELV $2268
line 4543
;4542:
;4543:		client->monstersAvailable--;
ADDRLP4 20
ADDRLP4 16
INDIRP4
CNSTI4 964
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 4544
;4544:	}
LABELV $2261
line 4517
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2263
ADDRLP4 0
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $2260
line 4545
;4545:}
LABELV $2234
endproc G_UpdateMonsterCounters 24 0
export G_CanBeDamaged
proc G_CanBeDamaged 0 0
line 4554
;4546:#endif
;4547:
;4548:/*
;4549:===============
;4550:JUHOX: G_CanBeDamaged
;4551:===============
;4552:*/
;4553:#if MONSTER_MODE
;4554:qboolean G_CanBeDamaged(gentity_t* ent) {
line 4555
;4555:	if (!ent->monster) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2282
CNSTI4 1
RETI4
ADDRGP4 $2281
JUMPV
LABELV $2282
line 4556
;4556:	if (ent->monster->action == MA_sleeping) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
CNSTI4 5
NEI4 $2284
CNSTI4 0
RETI4
ADDRGP4 $2281
JUMPV
LABELV $2284
line 4562
;4557:	/*
;4558:	if (ent->monster->action == MA_hibernation) {
;4559:		if (ent->monster->hibernationPhase >= HP_raising) return qfalse;
;4560:	}
;4561:	*/
;4562:	return qtrue;
CNSTI4 1
RETI4
LABELV $2281
endproc G_CanBeDamaged 0 0
export G_IsMovable
proc G_IsMovable 0 0
line 4572
;4563:}
;4564:#endif
;4565:
;4566:/*
;4567:===============
;4568:JUHOX: G_IsMovable
;4569:===============
;4570:*/
;4571:#if MONSTER_MODE
;4572:qboolean G_IsMovable(gentity_t* ent) {
line 4573
;4573:	if (!ent->monster) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2287
CNSTI4 1
RETI4
ADDRGP4 $2286
JUMPV
LABELV $2287
line 4574
;4574:	if (ent->monster->type != MT_titan) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 476
ADDP4
INDIRI4
CNSTI4 2
EQI4 $2289
CNSTI4 1
RETI4
ADDRGP4 $2286
JUMPV
LABELV $2289
line 4575
;4575:	if (ent->monster->action != MA_sleeping) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
CNSTI4 5
EQI4 $2291
CNSTI4 1
RETI4
ADDRGP4 $2286
JUMPV
LABELV $2291
line 4576
;4576:	return qfalse;
CNSTI4 0
RETI4
LABELV $2286
endproc G_IsMovable 0 0
export G_GetMonsterGeneric1
proc G_GetMonsterGeneric1 0 0
line 4586
;4577:}
;4578:#endif
;4579:
;4580:/*
;4581:===============
;4582:JUHOX: G_GetMonsterGeneric1
;4583:===============
;4584:*/
;4585:#if MONSTER_MODE
;4586:int G_GetMonsterGeneric1(gentity_t* monster) {
line 4587
;4587:	if (!monster->monster) return -1;
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2294
CNSTI4 -1
RETI4
ADDRGP4 $2293
JUMPV
LABELV $2294
line 4588
;4588:	return monster->monster->generic1;
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 704
ADDP4
INDIRI4
RETI4
LABELV $2293
endproc G_GetMonsterGeneric1 0 0
export G_CheckMonsterDamage
proc G_CheckMonsterDamage 12 0
line 4598
;4589:}
;4590:#endif
;4591:
;4592:/*
;4593:===============
;4594:JUHOX: G_CheckMonsterDamage
;4595:===============
;4596:*/
;4597:#if MONSTER_MODE
;4598:void G_CheckMonsterDamage(gentity_t* monster, gentity_t* target, int mod) {
line 4601
;4599:	gmonster_t* mi;
;4600:
;4601:	mi = monster->monster;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
ASGNP4
line 4602
;4602:	if (!mi) return;
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2297
ADDRGP4 $2296
JUMPV
LABELV $2297
line 4604
;4603:
;4604:	if (mi->enemy != target) return;
ADDRLP4 0
INDIRP4
CNSTI4 556
ADDP4
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CVPU4 4
EQU4 $2299
ADDRGP4 $2296
JUMPV
LABELV $2299
line 4606
;4605:
;4606:	switch (mi->type) {
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 476
ADDP4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $2304
ADDRLP4 4
INDIRI4
CNSTI4 1
EQI4 $2307
ADDRLP4 4
INDIRI4
CNSTI4 2
EQI4 $2310
ADDRGP4 $2296
JUMPV
LABELV $2304
line 4608
;4607:	case MT_predator:
;4608:		if (mod != MOD_CLAW) return;
ADDRFP4 8
INDIRI4
CNSTI4 3
EQI4 $2302
ADDRGP4 $2296
JUMPV
line 4609
;4609:		break;
LABELV $2307
line 4611
;4610:	case MT_guard:
;4611:		if (mod != MOD_GUARD) return;
ADDRFP4 8
INDIRI4
CNSTI4 4
EQI4 $2302
ADDRGP4 $2296
JUMPV
line 4612
;4612:		break;
LABELV $2310
line 4614
;4613:	case MT_titan:
;4614:		if (mod != MOD_TITAN) return;
ADDRFP4 8
INDIRI4
CNSTI4 5
EQI4 $2302
ADDRGP4 $2296
JUMPV
line 4615
;4615:		break;
line 4617
;4616:	default:
;4617:		return;
LABELV $2302
line 4620
;4618:	}
;4619:
;4620:	mi->lastEnemyHitTime = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 564
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 4621
;4621:}
LABELV $2296
endproc G_CheckMonsterDamage 12 0
export G_MonsterAction
proc G_MonsterAction 0 0
line 4630
;4622:#endif
;4623:
;4624:/*
;4625:===============
;4626:JUHOX: G_MonsterAction
;4627:===============
;4628:*/
;4629:#if MONSTER_MODE
;4630:monsterAction_t G_MonsterAction(gentity_t* monster) {
line 4631
;4631:	if (!monster->monster) return MA_waiting;
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2315
CNSTI4 0
RETI4
ADDRGP4 $2314
JUMPV
LABELV $2315
line 4633
;4632:
;4633:	return monster->monster->action;
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
RETI4
LABELV $2314
endproc G_MonsterAction 0 0
export IsPlayerFighting
proc IsPlayerFighting 4 0
line 4676
;4634:}
;4635:#endif
;4636:
;4637:/*
;4638:===============
;4639:JUHOX: G_FreezeMonster
;4640:===============
;4641:*/
;4642:#if SCREENSHOT_TOOLS && MONSTER_MODE
;4643:void G_FreezeMonster(gentity_t* monster, int msec) {
;4644:	gmonster_t* mi;
;4645:	
;4646:	mi = monster->monster;
;4647:	if (!mi) return;
;4648:
;4649:	G_FreezePlayerState(&mi->ps, msec);
;4650:
;4651:	if (mi->removeTime) mi->removeTime += msec;
;4652:	mi->lastAIFrame += msec;
;4653:	mi->nextAIFrame += msec;
;4654:	mi->enemyFoundTime += msec;
;4655:	mi->lastEnemyHitTime += msec;
;4656:	mi->nextDodgeTime += msec;
;4657:	mi->nextEnemyVisCheck += msec;
;4658:	mi->nextViewSearch += msec;
;4659:	mi->nextDynViewSearch += msec;
;4660:	mi->nextEnemySearch += msec;
;4661:	mi->lastHurtTime += msec;
;4662:	mi->timeOfBodyCopying += msec;
;4663:	mi->startAvoidPlayerTime += msec;
;4664:	mi->stopAvoidPlayerTime += msec;
;4665:	if (mi->hibernationTime) mi->hibernationTime += msec;
;4666:	if (mi->hibernationWaitTime) mi->hibernationWaitTime += msec;
;4667:	if (mi->lastChargeTime) mi->lastChargeTime += msec;
;4668:}
;4669:#endif
;4670:
;4671:/*
;4672:=================
;4673:JUHOX: IsPlayerFighting
;4674:=================
;4675:*/
;4676:qboolean IsPlayerFighting(int entityNum) {
line 4677
;4677:	if (entityNum < 0 || entityNum >= ENTITYNUM_WORLD) return qfalse;
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $2320
ADDRLP4 0
INDIRI4
CNSTI4 1022
LTI4 $2318
LABELV $2320
CNSTI4 0
RETI4
ADDRGP4 $2317
JUMPV
LABELV $2318
line 4679
;4678:
;4679:	if (!g_entities[entityNum].inuse) return qfalse;
ADDRFP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2321
CNSTI4 0
RETI4
ADDRGP4 $2317
JUMPV
LABELV $2321
line 4680
;4680:	if (g_entities[entityNum].health <= 0) return qfalse;
ADDRFP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+736
ADDP4
INDIRI4
CNSTI4 0
GTI4 $2324
CNSTI4 0
RETI4
ADDRGP4 $2317
JUMPV
LABELV $2324
line 4682
;4681:
;4682:	if (entityNum < MAX_CLIENTS) {
ADDRFP4 0
INDIRI4
CNSTI4 64
GEI4 $2327
line 4683
;4683:		if (level.clients[entityNum].weaponUsageTime > level.time - 3000) return qtrue;
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
LEI4 $2328
CNSTI4 1
RETI4
ADDRGP4 $2317
JUMPV
line 4684
;4684:	}
LABELV $2327
line 4686
;4685:#if MONSTER_MODE
;4686:	else if (g_entities[entityNum].monster) {
ADDRFP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2332
line 4687
;4687:		if (g_entities[entityNum].monster->action == MA_attacking) return qtrue;
ADDRFP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+520
ADDP4
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
CNSTI4 2
NEI4 $2335
CNSTI4 1
RETI4
ADDRGP4 $2317
JUMPV
LABELV $2335
line 4688
;4688:	}
LABELV $2332
LABELV $2328
line 4691
;4689:#endif
;4690:
;4691:	return qfalse;
CNSTI4 0
RETI4
LABELV $2317
endproc IsPlayerFighting 4 0
bss
align 4
LABELV numSourcesOfNoise
skip 4
align 4
LABELV sourcesOfNoise
skip 16384
import podium3
import podium2
import podium1
align 4
LABELV numMonsterSpawnPoolEntries
skip 4
align 4
LABELV monsterSpawnPool
skip 49152
align 4
LABELV freeMonster
skip 4
align 4
LABELV monsterInfo
skip 141600
align 4
LABELV monsterTraps
skip 320
align 4
LABELV lastMonsterTrap
skip 4
align 4
LABELV firstMonsterTrap
skip 4
align 4
LABELV monsterSeeds
skip 3200
align 4
LABELV lastMonsterSeed
skip 4
align 4
LABELV firstMonsterSeed
skip 4
align 4
LABELV nextMonsterSpawnTime
skip 4
align 4
LABELV numMonsters
skip 4
export bot_minplayers
align 4
LABELV bot_minplayers
skip 272
align 4
LABELV botSpawnQueue
skip 128
align 4
LABELV g_arenaInfos
skip 4096
export g_numArenas
align 4
LABELV g_numArenas
skip 4
align 4
LABELV g_botInfos
skip 4096
align 4
LABELV g_numBots
skip 4
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
import BotInterbreedEndMatch
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
LABELV $2012
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 116
byte 1 105
byte 1 116
byte 1 97
byte 1 110
byte 1 0
align 1
LABELV $2010
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 103
byte 1 117
byte 1 97
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $2003
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 112
byte 1 114
byte 1 101
byte 1 100
byte 1 97
byte 1 116
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $631
byte 1 37
byte 1 48
byte 1 51
byte 1 100
byte 1 44
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $587
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $584
byte 1 116
byte 1 114
byte 1 97
byte 1 105
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $581
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 105
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $580
byte 1 49
byte 1 48
byte 1 0
align 1
LABELV $575
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $572
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $569
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $565
byte 1 48
byte 1 0
align 1
LABELV $564
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 109
byte 1 105
byte 1 110
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $555
byte 1 94
byte 1 49
byte 1 73
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $550
byte 1 37
byte 1 105
byte 1 32
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $545
byte 1 46
byte 1 98
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $544
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 115
byte 1 47
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 46
byte 1 116
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $539
byte 1 103
byte 1 95
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 70
byte 1 105
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $527
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
byte 1 37
byte 1 102
byte 1 32
byte 1 102
byte 1 114
byte 1 101
byte 1 101
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $511
byte 1 53
byte 1 0
align 1
LABELV $508
byte 1 49
byte 1 0
align 1
LABELV $504
byte 1 37
byte 1 45
byte 1 49
byte 1 54
byte 1 115
byte 1 32
byte 1 37
byte 1 45
byte 1 49
byte 1 54
byte 1 115
byte 1 32
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 32
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $503
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 47
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 95
byte 1 99
byte 1 46
byte 1 99
byte 1 0
align 1
LABELV $496
byte 1 85
byte 1 110
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 100
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $489
byte 1 94
byte 1 49
byte 1 110
byte 1 97
byte 1 109
byte 1 101
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
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
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
byte 1 97
byte 1 105
byte 1 102
byte 1 105
byte 1 108
byte 1 101
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
byte 1 102
byte 1 117
byte 1 110
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $487
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 114
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $486
byte 1 99
byte 1 108
byte 1 95
byte 1 114
byte 1 117
byte 1 110
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $477
byte 1 85
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 65
byte 1 100
byte 1 100
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 60
byte 1 98
byte 1 111
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 62
byte 1 32
byte 1 91
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 32
byte 1 49
byte 1 45
byte 1 53
byte 1 93
byte 1 32
byte 1 91
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 93
byte 1 32
byte 1 91
byte 1 109
byte 1 115
byte 1 101
byte 1 99
byte 1 32
byte 1 100
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 93
byte 1 32
byte 1 91
byte 1 97
byte 1 108
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 93
byte 1 10
byte 1 0
align 1
LABELV $474
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
LABELV $463
byte 1 37
byte 1 53
byte 1 46
byte 1 50
byte 1 102
byte 1 0
align 1
LABELV $451
byte 1 94
byte 1 49
byte 1 83
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 32
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 39
byte 1 111
byte 1 112
byte 1 101
byte 1 110
byte 1 39
byte 1 32
byte 1 115
byte 1 108
byte 1 111
byte 1 116
byte 1 115
byte 1 32
byte 1 40
byte 1 111
byte 1 114
byte 1 32
byte 1 99
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 111
byte 1 102
byte 1 32
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
byte 1 32
byte 1 99
byte 1 118
byte 1 97
byte 1 114
byte 1 41
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $450
byte 1 94
byte 1 49
byte 1 85
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 97
byte 1 100
byte 1 100
byte 1 32
byte 1 98
byte 1 111
byte 1 116
byte 1 46
byte 1 32
byte 1 32
byte 1 65
byte 1 108
byte 1 108
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 115
byte 1 108
byte 1 111
byte 1 116
byte 1 115
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $447
byte 1 94
byte 1 49
byte 1 69
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 58
byte 1 32
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 97
byte 1 105
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 105
byte 1 102
byte 1 105
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $444
byte 1 97
byte 1 105
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $441
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 50
byte 1 0
align 1
LABELV $440
byte 1 52
byte 1 0
align 1
LABELV $437
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 49
byte 1 0
align 1
LABELV $436
byte 1 115
byte 1 101
byte 1 120
byte 1 0
align 1
LABELV $435
byte 1 109
byte 1 97
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $432
byte 1 103
byte 1 101
byte 1 110
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $431
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $428
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $427
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $426
byte 1 118
byte 1 105
byte 1 115
byte 1 111
byte 1 114
byte 1 47
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $423
byte 1 57
byte 1 48
byte 1 0
align 1
LABELV $420
byte 1 55
byte 1 48
byte 1 0
align 1
LABELV $417
byte 1 53
byte 1 48
byte 1 0
align 1
LABELV $416
byte 1 104
byte 1 97
byte 1 110
byte 1 100
byte 1 105
byte 1 99
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $413
byte 1 37
byte 1 49
byte 1 46
byte 1 50
byte 1 102
byte 1 0
align 1
LABELV $412
byte 1 50
byte 1 48
byte 1 0
align 1
LABELV $411
byte 1 115
byte 1 110
byte 1 97
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $410
byte 1 50
byte 1 53
byte 1 48
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $409
byte 1 114
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $401
byte 1 37
byte 1 115
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $391
byte 1 102
byte 1 117
byte 1 110
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $390
byte 1 94
byte 1 49
byte 1 69
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 58
byte 1 32
byte 1 66
byte 1 111
byte 1 116
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 100
byte 1 101
byte 1 102
byte 1 105
byte 1 110
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $374
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
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $371
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 76
byte 1 111
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $368
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $366
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $364
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 101
byte 1 114
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $354
byte 1 94
byte 1 51
byte 1 85
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 100
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $343
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $236
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $221
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
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $219
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $216
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $213
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $170
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $164
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
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
byte 1 97
byte 1 110
byte 1 110
byte 1 111
byte 1 117
byte 1 110
byte 1 99
byte 1 101
byte 1 47
byte 1 37
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 10
byte 1 0
align 1
LABELV $163
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $157
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $149
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $148
byte 1 110
byte 1 117
byte 1 109
byte 1 0
align 1
LABELV $143
byte 1 37
byte 1 105
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 115
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $142
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 115
byte 1 47
byte 1 0
align 1
LABELV $137
byte 1 46
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 0
align 1
LABELV $136
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $135
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 115
byte 1 47
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 115
byte 1 46
byte 1 116
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $130
byte 1 0
align 1
LABELV $129
byte 1 103
byte 1 95
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 115
byte 1 70
byte 1 105
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $127
byte 1 94
byte 1 49
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 108
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 37
byte 1 105
byte 1 44
byte 1 32
byte 1 109
byte 1 97
byte 1 120
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $124
byte 1 94
byte 1 49
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $118
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $117
byte 1 92
byte 1 110
byte 1 117
byte 1 109
byte 1 92
byte 1 0
align 1
LABELV $116
byte 1 60
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 62
byte 1 0
align 1
LABELV $113
byte 1 125
byte 1 0
align 1
LABELV $110
byte 1 85
byte 1 110
byte 1 101
byte 1 120
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 101
byte 1 110
byte 1 100
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $104
byte 1 77
byte 1 97
byte 1 120
byte 1 32
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 115
byte 1 32
byte 1 101
byte 1 120
byte 1 99
byte 1 101
byte 1 101
byte 1 100
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $101
byte 1 77
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 123
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $100
byte 1 123
byte 1 0
