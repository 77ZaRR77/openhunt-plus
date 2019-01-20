data
align 4
LABELV master_items
address $96
address $97
address $98
byte 4 0
align 4
LABELV servertype_items
address $99
address $100
address $101
address $102
address $103
byte 4 0
align 4
LABELV sortkey_items
address $104
address $105
address $106
address $107
address $108
byte 4 0
align 4
LABELV gamenames
address $109
address $110
address $111
address $112
address $113
address $114
address $115
address $116
address $117
address $118
address $119
address $120
address $121
byte 4 0
align 4
LABELV netnames
address $121
address $122
address $123
byte 4 0
lit
align 1
LABELV quake3worldMessage
byte 1 86
byte 1 105
byte 1 115
byte 1 105
byte 1 116
byte 1 32
byte 1 119
byte 1 119
byte 1 119
byte 1 46
byte 1 113
byte 1 117
byte 1 97
byte 1 107
byte 1 101
byte 1 51
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 46
byte 1 99
byte 1 111
byte 1 109
byte 1 32
byte 1 45
byte 1 32
byte 1 78
byte 1 101
byte 1 119
byte 1 115
byte 1 44
byte 1 32
byte 1 67
byte 1 111
byte 1 109
byte 1 109
byte 1 117
byte 1 110
byte 1 105
byte 1 116
byte 1 121
byte 1 44
byte 1 32
byte 1 69
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 44
byte 1 32
byte 1 70
byte 1 105
byte 1 108
byte 1 101
byte 1 115
byte 1 0
data
export punkbuster_items
align 4
LABELV punkbuster_items
address $124
address $125
byte 4 0
export punkbuster_msg
align 4
LABELV punkbuster_msg
address $126
address $127
address $128
address $129
byte 4 0
code
proc ArenaServers_MaxPing 8 4
file "..\..\..\..\code\q3_ui\ui_servers2.c"
line 238
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:/*
;4:=======================================================================
;5:
;6:MULTIPLAYER MENU (SERVER BROWSER)
;7:
;8:=======================================================================
;9:*/
;10:
;11:
;12:#include "ui_local.h"
;13:
;14:
;15:#define MAX_GLOBALSERVERS		128
;16:#define MAX_PINGREQUESTS		32
;17:#define MAX_ADDRESSLENGTH		64
;18:#define MAX_HOSTNAMELENGTH		22
;19:#define MAX_MAPNAMELENGTH		16
;20:#define MAX_LISTBOXITEMS		128
;21:#define MAX_LOCALSERVERS		128
;22:#define MAX_STATUSLENGTH		64
;23:#define MAX_LEAGUELENGTH		28
;24:#define MAX_LISTBOXWIDTH		68
;25:
;26:#define ART_BACK0				"menu/art/back_0"
;27:#define ART_BACK1				"menu/art/back_1"
;28:#define ART_CREATE0				"menu/art/create_0"
;29:#define ART_CREATE1				"menu/art/create_1"
;30:#define ART_SPECIFY0			"menu/art/specify_0"
;31:#define ART_SPECIFY1			"menu/art/specify_1"
;32:#define ART_REFRESH0			"menu/art/refresh_0"
;33:#define ART_REFRESH1			"menu/art/refresh_1"
;34:#define ART_CONNECT0			"menu/art/fight_0"
;35:#define ART_CONNECT1			"menu/art/fight_1"
;36:#define ART_ARROWS0				"menu/art/arrows_vert_0"
;37:#define ART_ARROWS_UP			"menu/art/arrows_vert_top"
;38:#define ART_ARROWS_DOWN			"menu/art/arrows_vert_bot"
;39:#define ART_UNKNOWNMAP			"menu/art/unknownmap"
;40:#define ART_REMOVE0				"menu/art/delete_0"
;41:#define ART_REMOVE1				"menu/art/delete_1"
;42://#define ART_PUNKBUSTER		    "menu/art/pblogo"
;43:
;44:#define ID_MASTER			10
;45:#define ID_GAMETYPE			11
;46:#define ID_SORTKEY			12
;47:#define ID_SHOW_FULL		13
;48:#define ID_SHOW_EMPTY		14
;49:#define ID_LIST				15
;50:#define ID_SCROLL_UP		16
;51:#define ID_SCROLL_DOWN		17
;52:#define ID_BACK				18
;53:#define ID_REFRESH			19
;54:#define ID_SPECIFY			20
;55:#define ID_CREATE			21
;56:#define ID_CONNECT			22
;57:#define ID_REMOVE			23
;58:#define ID_PUNKBUSTER 24
;59:
;60:#define GR_LOGO				30
;61:#define GR_LETTERS			31
;62:
;63:#define AS_LOCAL			0
;64:#define AS_MPLAYER			1
;65:#define AS_GLOBAL			2
;66:#define AS_FAVORITES		3
;67:
;68:#define SORT_HOST			0
;69:#define SORT_MAP			1
;70:#define SORT_CLIENTS		2
;71:#define SORT_GAME			3
;72:#define SORT_PING			4
;73:
;74:#define GAMES_ALL			0
;75:#define GAMES_FFA			1
;76:#define GAMES_TEAMPLAY		2
;77:#define GAMES_TOURNEY		3
;78:#define GAMES_CTF			4
;79:
;80:static const char *master_items[] = {
;81:	"Local",
;82:	"Internet",
;83:	"Favorites",
;84:	0
;85:};
;86:
;87:static const char *servertype_items[] = {	// JUHOX NOTE: index is GAMES_xxx
;88:	"All",
;89:	"Free For All",
;90:	"Team Deathmatch",
;91:	"Tournament",
;92:	"Capture the Flag",
;93:	0
;94:};
;95:
;96:static const char *sortkey_items[] = {
;97:	"Server Name",
;98:	"Map Name",
;99:	"Open Player Spots",
;100:	"Game Type",
;101:	"Ping Time",
;102:	0
;103:};
;104:
;105:static char* gamenames[] = {	// JUHOX NOTE: index is GT_xxx
;106:	"DM ",	// deathmatch
;107:	"1v1",	// tournament
;108:	"SP ",	// single player
;109:	"Team DM",	// team deathmatch
;110:	"CTF",	// capture the flag
;111:	"One Flag CTF",		// one flag ctf
;112:	"OverLoad",				// Overload
;113:	"Harvester",			// Harvester
;114:	"Rocket Arena 3",	// Rocket Arena 3
;115:	"Q3F",						// Q3F
;116:	"Urban Terror",		// Urban Terror
;117:	"OSP",						// Orange Smoothie Productions
;118:	"???",			// unknown
;119:	0
;120:};
;121:
;122:static char* netnames[] = {
;123:	"???",
;124:	"UDP",
;125:	"IPX",
;126:	NULL
;127:};
;128:
;129:static char quake3worldMessage[] = "Visit www.quake3world.com - News, Community, Events, Files";
;130:
;131:const char* punkbuster_items[] = {
;132:	"Disabled",
;133:	"Enabled",
;134:	NULL
;135:};
;136:
;137:const char* punkbuster_msg[] = {
;138:	"PunkBuster will be",
;139:	"disabled the next time",
;140:	"Quake III Arena",
;141:	"is started.",
;142:	NULL
;143:};
;144:
;145:typedef struct {
;146:	char	adrstr[MAX_ADDRESSLENGTH];
;147:	int		start;
;148:} pinglist_t;
;149:
;150:typedef struct servernode_s {
;151:	char	adrstr[MAX_ADDRESSLENGTH];
;152:	char	hostname[MAX_HOSTNAMELENGTH+3];
;153:	char	mapname[MAX_MAPNAMELENGTH];
;154:	int		numclients;
;155:	int		maxclients;
;156:	int		pingtime;
;157:	int		gametype;
;158:	char	gamename[12];
;159:	int		nettype;
;160:	int		minPing;
;161:	int		maxPing;
;162:	qboolean bPB;
;163:
;164:} servernode_t;
;165:
;166:typedef struct {
;167:	char			buff[MAX_LISTBOXWIDTH];
;168:	servernode_t*	servernode;
;169:} table_t;
;170:
;171:typedef struct {
;172:	menuframework_s		menu;
;173:
;174:	menutext_s			banner;
;175:
;176:	menulist_s			master;
;177:	menulist_s			gametype;
;178:	menulist_s			sortkey;
;179:	menuradiobutton_s	showfull;
;180:	menuradiobutton_s	showempty;
;181:
;182:	menulist_s			list;
;183:	menubitmap_s		mappic;
;184:	menubitmap_s		arrows;
;185:	menubitmap_s		up;
;186:	menubitmap_s		down;
;187:	menutext_s			status;
;188:	menutext_s			statusbar;
;189:
;190:	menubitmap_s		remove;
;191:	menubitmap_s		back;
;192:	menubitmap_s		refresh;
;193:	menubitmap_s		specify;
;194:	menubitmap_s		create;
;195:	menubitmap_s		go;
;196:
;197:	pinglist_t			pinglist[MAX_PINGREQUESTS];
;198:	table_t				table[MAX_LISTBOXITEMS];
;199:	char*				items[MAX_LISTBOXITEMS];
;200:	int					numqueriedservers;
;201:	int					*numservers;
;202:	servernode_t		*serverlist;
;203:	int					currentping;
;204:	qboolean			refreshservers;
;205:	int					nextpingtime;
;206:	int					maxservers;
;207:	int					refreshtime;
;208:	char				favoriteaddresses[MAX_FAVORITESERVERS][MAX_ADDRESSLENGTH];
;209:	int					numfavoriteaddresses;
;210:
;211:	menulist_s		punkbuster;
;212:	menubitmap_s	pblogo;
;213:} arenaservers_t;
;214:
;215:static arenaservers_t	g_arenaservers;
;216:
;217:
;218:static servernode_t		g_globalserverlist[MAX_GLOBALSERVERS];
;219:static int				g_numglobalservers;
;220:static servernode_t		g_localserverlist[MAX_LOCALSERVERS];
;221:static int				g_numlocalservers;
;222:static servernode_t		g_favoriteserverlist[MAX_FAVORITESERVERS];
;223:static int				g_numfavoriteservers;
;224:static servernode_t		g_mplayerserverlist[MAX_GLOBALSERVERS];
;225:static int				g_nummplayerservers;
;226:static int				g_servertype;
;227:static int				g_gametype;
;228:static int				g_sortkey;
;229:static int				g_emptyservers;
;230:static int				g_fullservers;
;231:
;232:
;233:/*
;234:=================
;235:ArenaServers_MaxPing
;236:=================
;237:*/
;238:static int ArenaServers_MaxPing( void ) {
line 241
;239:	int		maxPing;
;240:
;241:	maxPing = (int)trap_Cvar_VariableValue( "cl_maxPing" );
ADDRGP4 $134
ARGP4
ADDRLP4 4
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
CVFI4 4
ASGNI4
line 242
;242:	if( maxPing < 100 ) {
ADDRLP4 0
INDIRI4
CNSTI4 100
GEI4 $135
line 243
;243:		maxPing = 100;
ADDRLP4 0
CNSTI4 100
ASGNI4
line 244
;244:	}
LABELV $135
line 245
;245:	return maxPing;
ADDRLP4 0
INDIRI4
RETI4
LABELV $133
endproc ArenaServers_MaxPing 8 4
proc ArenaServers_Compare 40 8
line 254
;246:}
;247:
;248:
;249:/*
;250:=================
;251:ArenaServers_Compare
;252:=================
;253:*/
;254:static int QDECL ArenaServers_Compare( const void *arg1, const void *arg2 ) {
line 260
;255:	float			f1;
;256:	float			f2;
;257:	servernode_t*	t1;
;258:	servernode_t*	t2;
;259:
;260:	t1 = (servernode_t *)arg1;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 261
;261:	t2 = (servernode_t *)arg2;
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
line 263
;262:
;263:	switch( g_sortkey ) {
ADDRLP4 16
ADDRGP4 g_sortkey
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
LTI4 $138
ADDRLP4 16
INDIRI4
CNSTI4 4
GTI4 $138
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $161
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $161
address $140
address $141
address $142
address $151
address $156
code
LABELV $140
line 265
;264:	case SORT_HOST:
;265:		return Q_stricmp( t1->hostname, t2->hostname );
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 64
ADDP4
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
RETI4
ADDRGP4 $137
JUMPV
LABELV $141
line 268
;266:
;267:	case SORT_MAP:
;268:		return Q_stricmp( t1->mapname, t2->mapname );
ADDRLP4 0
INDIRP4
CNSTI4 89
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 89
ADDP4
ARGP4
ADDRLP4 24
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
RETI4
ADDRGP4 $137
JUMPV
LABELV $142
line 271
;269:
;270:	case SORT_CLIENTS:
;271:		f1 = t1->maxclients - t1->numclients;
ADDRLP4 28
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 28
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
ADDRLP4 28
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 272
;272:		if( f1 < 0 ) {
ADDRLP4 8
INDIRF4
CNSTF4 0
GEF4 $143
line 273
;273:			f1 = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 274
;274:		}
LABELV $143
line 276
;275:
;276:		f2 = t2->maxclients - t2->numclients;
ADDRLP4 32
ADDRLP4 4
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 32
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
ADDRLP4 32
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 277
;277:		if( f2 < 0 ) {
ADDRLP4 12
INDIRF4
CNSTF4 0
GEF4 $145
line 278
;278:			f2 = 0;
ADDRLP4 12
CNSTF4 0
ASGNF4
line 279
;279:		}
LABELV $145
line 281
;280:
;281:		if( f1 < f2 ) {
ADDRLP4 8
INDIRF4
ADDRLP4 12
INDIRF4
GEF4 $147
line 282
;282:			return 1;
CNSTI4 1
RETI4
ADDRGP4 $137
JUMPV
LABELV $147
line 284
;283:		}
;284:		if( f1 == f2 ) {
ADDRLP4 8
INDIRF4
ADDRLP4 12
INDIRF4
NEF4 $149
line 285
;285:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $137
JUMPV
LABELV $149
line 287
;286:		}
;287:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $137
JUMPV
LABELV $151
line 290
;288:
;289:	case SORT_GAME:
;290:		if( t1->gametype < t2->gametype ) {
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
GEI4 $152
line 291
;291:			return -1;
CNSTI4 -1
RETI4
ADDRGP4 $137
JUMPV
LABELV $152
line 293
;292:		}
;293:		if( t1->gametype == t2->gametype ) {
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
NEI4 $154
line 294
;294:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $137
JUMPV
LABELV $154
line 296
;295:		}
;296:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $137
JUMPV
LABELV $156
line 299
;297:
;298:	case SORT_PING:
;299:		if( t1->pingtime < t2->pingtime ) {
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
GEI4 $157
line 300
;300:			return -1;
CNSTI4 -1
RETI4
ADDRGP4 $137
JUMPV
LABELV $157
line 302
;301:		}
;302:		if( t1->pingtime > t2->pingtime ) {
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
LEI4 $159
line 303
;303:			return 1;
CNSTI4 1
RETI4
ADDRGP4 $137
JUMPV
LABELV $159
line 305
;304:		}
;305:		return Q_stricmp( t1->hostname, t2->hostname );
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 64
ADDP4
ARGP4
ADDRLP4 36
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
RETI4
ADDRGP4 $137
JUMPV
LABELV $138
line 308
;306:	}
;307:
;308:	return 0;
CNSTI4 0
RETI4
LABELV $137
endproc ArenaServers_Compare 40 8
proc ArenaServers_Go 8 8
line 317
;309:}
;310:
;311:
;312:/*
;313:=================
;314:ArenaServers_Go
;315:=================
;316:*/
;317:static void ArenaServers_Go( void ) {
line 320
;318:	servernode_t*	servernode;
;319:
;320:	servernode = g_arenaservers.table[g_arenaservers.list.curvalue].servernode;
ADDRLP4 0
ADDRGP4 g_arenaservers+912+64
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 g_arenaservers+4208+68
ADDP4
INDIRP4
ASGNP4
line 321
;321:	if( servernode ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $167
line 322
;322:		trap_Cmd_ExecuteText( EXEC_APPEND, va( "connect %s\n", servernode->adrstr ) );
ADDRGP4 $169
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 323
;323:	}
LABELV $167
line 324
;324:}
LABELV $162
endproc ArenaServers_Go 8 8
bss
align 1
LABELV $171
skip 64
code
proc ArenaServers_UpdatePicture 4 16
line 332
;325:
;326:
;327:/*
;328:=================
;329:ArenaServers_UpdatePicture
;330:=================
;331:*/
;332:static void ArenaServers_UpdatePicture( void ) {
line 336
;333:	static char		picname[64];
;334:	servernode_t*	servernodeptr;
;335:
;336:	if( !g_arenaservers.list.numitems ) {
ADDRGP4 g_arenaservers+912+68
INDIRI4
CNSTI4 0
NEI4 $172
line 337
;337:		g_arenaservers.mappic.generic.name = NULL;
ADDRGP4 g_arenaservers+1008+4
CNSTP4 0
ASGNP4
line 338
;338:	}
ADDRGP4 $173
JUMPV
LABELV $172
line 339
;339:	else {
line 340
;340:		servernodeptr = g_arenaservers.table[g_arenaservers.list.curvalue].servernode;
ADDRLP4 0
ADDRGP4 g_arenaservers+912+64
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 g_arenaservers+4208+68
ADDP4
INDIRP4
ASGNP4
line 341
;341:		Com_sprintf( picname, sizeof(picname), "levelshots/%s.tga", servernodeptr->mapname );
ADDRGP4 $171
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $182
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 89
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 342
;342:		g_arenaservers.mappic.generic.name = picname;
ADDRGP4 g_arenaservers+1008+4
ADDRGP4 $171
ASGNP4
line 344
;343:
;344:	}
LABELV $173
line 347
;345:
;346:	// force shader update during draw
;347:	g_arenaservers.mappic.shader = 0;
ADDRGP4 g_arenaservers+1008+68
CNSTI4 0
ASGNI4
line 348
;348:}
LABELV $170
endproc ArenaServers_UpdatePicture 4 16
proc ArenaServers_UpdateMenu 68 48
line 356
;349:
;350:
;351:/*
;352:=================
;353:ArenaServers_UpdateMenu
;354:=================
;355:*/
;356:static void ArenaServers_UpdateMenu( void ) {
line 365
;357:	int				i;
;358:	int				j;
;359:	int				count;
;360:	char*			buff;
;361:	servernode_t*	servernodeptr;
;362:	table_t*		tableptr;
;363:	char			*pingColor;
;364:
;365:	if( g_arenaservers.numqueriedservers > 0 ) {
ADDRGP4 g_arenaservers+13936
INDIRI4
CNSTI4 0
LEI4 $188
line 367
;366:		// servers found
;367:		if( g_arenaservers.refreshservers && ( g_arenaservers.currentping <= g_arenaservers.numqueriedservers ) ) {
ADDRGP4 g_arenaservers+13952
INDIRI4
CNSTI4 0
EQI4 $191
ADDRGP4 g_arenaservers+13948
INDIRI4
ADDRGP4 g_arenaservers+13936
INDIRI4
GTI4 $191
line 369
;368:			// show progress
;369:			Com_sprintf( g_arenaservers.status.string, MAX_STATUSLENGTH, "%d of %d Arena Servers.", g_arenaservers.currentping, g_arenaservers.numqueriedservers);
ADDRGP4 g_arenaservers+1360+60
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $198
ARGP4
ADDRGP4 g_arenaservers+13948
INDIRI4
ARGI4
ADDRGP4 g_arenaservers+13936
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 370
;370:			g_arenaservers.statusbar.string  = "Press SPACE to stop";
ADDRGP4 g_arenaservers+1432+60
ADDRGP4 $203
ASGNP4
line 371
;371:			qsort( g_arenaservers.serverlist, *g_arenaservers.numservers, sizeof( servernode_t ), ArenaServers_Compare);
ADDRGP4 g_arenaservers+13944
INDIRP4
ARGP4
ADDRGP4 g_arenaservers+13940
INDIRP4
INDIRI4
ARGI4
CNSTI4 152
ARGI4
ADDRGP4 ArenaServers_Compare
ARGP4
ADDRGP4 qsort
CALLV
pop
line 372
;372:		}
ADDRGP4 $189
JUMPV
LABELV $191
line 373
;373:		else {
line 375
;374:			// all servers pinged - enable controls
;375:			g_arenaservers.master.generic.flags		&= ~QMF_GRAYED;
ADDRLP4 28
ADDRGP4 g_arenaservers+496+44
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRU4
CNSTU4 4294959103
BANDU4
ASGNU4
line 376
;376:			g_arenaservers.gametype.generic.flags	&= ~QMF_GRAYED;
ADDRLP4 32
ADDRGP4 g_arenaservers+592+44
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRU4
CNSTU4 4294959103
BANDU4
ASGNU4
line 377
;377:			g_arenaservers.sortkey.generic.flags	&= ~QMF_GRAYED;
ADDRLP4 36
ADDRGP4 g_arenaservers+688+44
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRU4
CNSTU4 4294959103
BANDU4
ASGNU4
line 378
;378:			g_arenaservers.showempty.generic.flags	&= ~QMF_GRAYED;
ADDRLP4 40
ADDRGP4 g_arenaservers+848+44
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRU4
CNSTU4 4294959103
BANDU4
ASGNU4
line 379
;379:			g_arenaservers.showfull.generic.flags	&= ~QMF_GRAYED;
ADDRLP4 44
ADDRGP4 g_arenaservers+784+44
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRU4
CNSTU4 4294959103
BANDU4
ASGNU4
line 380
;380:			g_arenaservers.list.generic.flags		&= ~QMF_GRAYED;
ADDRLP4 48
ADDRGP4 g_arenaservers+912+44
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRU4
CNSTU4 4294959103
BANDU4
ASGNU4
line 381
;381:			g_arenaservers.refresh.generic.flags	&= ~QMF_GRAYED;
ADDRLP4 52
ADDRGP4 g_arenaservers+1680+44
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRU4
CNSTU4 4294959103
BANDU4
ASGNU4
line 382
;382:			g_arenaservers.go.generic.flags			&= ~QMF_GRAYED;
ADDRLP4 56
ADDRGP4 g_arenaservers+1944+44
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRU4
CNSTU4 4294959103
BANDU4
ASGNU4
line 383
;383:			g_arenaservers.punkbuster.generic.flags &= ~QMF_GRAYED;
ADDRLP4 60
ADDRGP4 g_arenaservers+14996+44
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRU4
CNSTU4 4294959103
BANDU4
ASGNU4
line 386
;384:
;385:			// update status bar
;386:			if( g_servertype == AS_GLOBAL || g_servertype == AS_MPLAYER ) {
ADDRLP4 64
ADDRGP4 g_servertype
INDIRI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 2
EQI4 $226
ADDRLP4 64
INDIRI4
CNSTI4 1
NEI4 $224
LABELV $226
line 387
;387:				g_arenaservers.statusbar.string = quake3worldMessage;
ADDRGP4 g_arenaservers+1432+60
ADDRGP4 quake3worldMessage
ASGNP4
line 388
;388:			}
ADDRGP4 $189
JUMPV
LABELV $224
line 389
;389:			else {
line 390
;390:				g_arenaservers.statusbar.string = "";
ADDRGP4 g_arenaservers+1432+60
ADDRGP4 $231
ASGNP4
line 391
;391:			}
line 393
;392:
;393:		}
line 394
;394:	}
ADDRGP4 $189
JUMPV
LABELV $188
line 395
;395:	else {
line 397
;396:		// no servers found
;397:		if( g_arenaservers.refreshservers ) {
ADDRGP4 g_arenaservers+13952
INDIRI4
CNSTI4 0
EQI4 $232
line 398
;398:			strcpy( g_arenaservers.status.string,"Scanning For Servers." );
ADDRGP4 g_arenaservers+1360+60
INDIRP4
ARGP4
ADDRGP4 $237
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 399
;399:			g_arenaservers.statusbar.string = "Press SPACE to stop";
ADDRGP4 g_arenaservers+1432+60
ADDRGP4 $203
ASGNP4
line 402
;400:
;401:			// disable controls during refresh
;402:			g_arenaservers.master.generic.flags		|= QMF_GRAYED;
ADDRLP4 28
ADDRGP4 g_arenaservers+496+44
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
line 403
;403:			g_arenaservers.gametype.generic.flags	|= QMF_GRAYED;
ADDRLP4 32
ADDRGP4 g_arenaservers+592+44
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
line 404
;404:			g_arenaservers.sortkey.generic.flags	|= QMF_GRAYED;
ADDRLP4 36
ADDRGP4 g_arenaservers+688+44
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
line 405
;405:			g_arenaservers.showempty.generic.flags	|= QMF_GRAYED;
ADDRLP4 40
ADDRGP4 g_arenaservers+848+44
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
line 406
;406:			g_arenaservers.showfull.generic.flags	|= QMF_GRAYED;
ADDRLP4 44
ADDRGP4 g_arenaservers+784+44
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
line 407
;407:			g_arenaservers.list.generic.flags		|= QMF_GRAYED;
ADDRLP4 48
ADDRGP4 g_arenaservers+912+44
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
line 408
;408:			g_arenaservers.refresh.generic.flags	|= QMF_GRAYED;
ADDRLP4 52
ADDRGP4 g_arenaservers+1680+44
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
line 409
;409:			g_arenaservers.go.generic.flags			|= QMF_GRAYED;
ADDRLP4 56
ADDRGP4 g_arenaservers+1944+44
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
line 410
;410:			g_arenaservers.punkbuster.generic.flags |= QMF_GRAYED;
ADDRLP4 60
ADDRGP4 g_arenaservers+14996+44
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
line 411
;411:		}
ADDRGP4 $233
JUMPV
LABELV $232
line 412
;412:		else {
line 413
;413:			if( g_arenaservers.numqueriedservers < 0 ) {
ADDRGP4 g_arenaservers+13936
INDIRI4
CNSTI4 0
GEI4 $258
line 414
;414:				strcpy(g_arenaservers.status.string,"No Response From Master Server." );
ADDRGP4 g_arenaservers+1360+60
INDIRP4
ARGP4
ADDRGP4 $263
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 415
;415:			}
ADDRGP4 $259
JUMPV
LABELV $258
line 416
;416:			else {
line 417
;417:				strcpy(g_arenaservers.status.string,"No Servers Found." );
ADDRGP4 g_arenaservers+1360+60
INDIRP4
ARGP4
ADDRGP4 $266
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 418
;418:			}
LABELV $259
line 421
;419:
;420:			// update status bar
;421:			if( g_servertype == AS_GLOBAL || g_servertype == AS_MPLAYER ) {
ADDRLP4 28
ADDRGP4 g_servertype
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 2
EQI4 $269
ADDRLP4 28
INDIRI4
CNSTI4 1
NEI4 $267
LABELV $269
line 422
;422:				g_arenaservers.statusbar.string = quake3worldMessage;
ADDRGP4 g_arenaservers+1432+60
ADDRGP4 quake3worldMessage
ASGNP4
line 423
;423:			}
ADDRGP4 $268
JUMPV
LABELV $267
line 424
;424:			else {
line 425
;425:				g_arenaservers.statusbar.string = "";
ADDRGP4 g_arenaservers+1432+60
ADDRGP4 $231
ASGNP4
line 426
;426:			}
LABELV $268
line 429
;427:
;428:			// end of refresh - set control state
;429:			g_arenaservers.master.generic.flags		&= ~QMF_GRAYED;
ADDRLP4 32
ADDRGP4 g_arenaservers+496+44
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRU4
CNSTU4 4294959103
BANDU4
ASGNU4
line 430
;430:			g_arenaservers.gametype.generic.flags	&= ~QMF_GRAYED;
ADDRLP4 36
ADDRGP4 g_arenaservers+592+44
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRU4
CNSTU4 4294959103
BANDU4
ASGNU4
line 431
;431:			g_arenaservers.sortkey.generic.flags	&= ~QMF_GRAYED;
ADDRLP4 40
ADDRGP4 g_arenaservers+688+44
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRU4
CNSTU4 4294959103
BANDU4
ASGNU4
line 432
;432:			g_arenaservers.showempty.generic.flags	&= ~QMF_GRAYED;
ADDRLP4 44
ADDRGP4 g_arenaservers+848+44
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRU4
CNSTU4 4294959103
BANDU4
ASGNU4
line 433
;433:			g_arenaservers.showfull.generic.flags	&= ~QMF_GRAYED;
ADDRLP4 48
ADDRGP4 g_arenaservers+784+44
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRU4
CNSTU4 4294959103
BANDU4
ASGNU4
line 434
;434:			g_arenaservers.list.generic.flags		|= QMF_GRAYED;
ADDRLP4 52
ADDRGP4 g_arenaservers+912+44
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
line 435
;435:			g_arenaservers.refresh.generic.flags	&= ~QMF_GRAYED;
ADDRLP4 56
ADDRGP4 g_arenaservers+1680+44
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRU4
CNSTU4 4294959103
BANDU4
ASGNU4
line 436
;436:			g_arenaservers.go.generic.flags			|= QMF_GRAYED;
ADDRLP4 60
ADDRGP4 g_arenaservers+1944+44
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
line 437
;437:			g_arenaservers.punkbuster.generic.flags &= ~QMF_GRAYED;
ADDRLP4 64
ADDRGP4 g_arenaservers+14996+44
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRU4
CNSTU4 4294959103
BANDU4
ASGNU4
line 438
;438:		}
LABELV $233
line 441
;439:
;440:		// zero out list box
;441:		g_arenaservers.list.numitems = 0;
ADDRGP4 g_arenaservers+912+68
CNSTI4 0
ASGNI4
line 442
;442:		g_arenaservers.list.curvalue = 0;
ADDRGP4 g_arenaservers+912+64
CNSTI4 0
ASGNI4
line 443
;443:		g_arenaservers.list.top      = 0;
ADDRGP4 g_arenaservers+912+72
CNSTI4 0
ASGNI4
line 446
;444:
;445:		// update picture
;446:		ArenaServers_UpdatePicture();
ADDRGP4 ArenaServers_UpdatePicture
CALLV
pop
line 447
;447:		return;
ADDRGP4 $187
JUMPV
LABELV $189
line 451
;448:	}
;449:
;450:	// build list box strings - apply culling filters
;451:	servernodeptr = g_arenaservers.serverlist;
ADDRLP4 0
ADDRGP4 g_arenaservers+13944
INDIRP4
ASGNP4
line 452
;452:	count         = *g_arenaservers.numservers;
ADDRLP4 24
ADDRGP4 g_arenaservers+13940
INDIRP4
INDIRI4
ASGNI4
line 453
;453:	for( i = 0, j = 0; i < count; i++, servernodeptr++ ) {
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $303
JUMPV
LABELV $300
line 454
;454:		tableptr = &g_arenaservers.table[j];
ADDRLP4 4
ADDRLP4 8
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 g_arenaservers+4208
ADDP4
ASGNP4
line 455
;455:		tableptr->servernode = servernodeptr;
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 456
;456:		buff = tableptr->buff;
ADDRLP4 16
ADDRLP4 4
INDIRP4
ASGNP4
line 459
;457:
;458:		// can only cull valid results
;459:		if( !g_emptyservers && !servernodeptr->numclients ) {
ADDRGP4 g_emptyservers
INDIRI4
CNSTI4 0
NEI4 $305
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
CNSTI4 0
NEI4 $305
line 460
;460:			continue;
ADDRGP4 $301
JUMPV
LABELV $305
line 463
;461:		}
;462:
;463:		if( !g_fullservers && ( servernodeptr->numclients == servernodeptr->maxclients ) ) {
ADDRGP4 g_fullservers
INDIRI4
CNSTI4 0
NEI4 $307
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
NEI4 $307
line 464
;464:			continue;
ADDRGP4 $301
JUMPV
LABELV $307
line 467
;465:		}
;466:
;467:		switch( g_gametype ) {
ADDRLP4 32
ADDRGP4 g_gametype
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
LTI4 $309
ADDRLP4 32
INDIRI4
CNSTI4 4
GTI4 $309
ADDRLP4 32
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $324
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $324
address $310
address $312
address $315
address $318
address $321
code
line 469
;468:		case GAMES_ALL:
;469:			break;
LABELV $312
line 472
;470:
;471:		case GAMES_FFA:
;472:			if( servernodeptr->gametype != GT_FFA ) {
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
CNSTI4 0
EQI4 $310
line 473
;473:				continue;
ADDRGP4 $301
JUMPV
line 475
;474:			}
;475:			break;
LABELV $315
line 478
;476:
;477:		case GAMES_TEAMPLAY:
;478:			if( servernodeptr->gametype != GT_TEAM ) {
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
CNSTI4 3
EQI4 $310
line 479
;479:				continue;
ADDRGP4 $301
JUMPV
line 481
;480:			}
;481:			break;
LABELV $318
line 484
;482:
;483:		case GAMES_TOURNEY:
;484:			if( servernodeptr->gametype != GT_TOURNAMENT ) {
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
CNSTI4 1
EQI4 $310
line 485
;485:				continue;
ADDRGP4 $301
JUMPV
line 487
;486:			}
;487:			break;
LABELV $321
line 490
;488:
;489:		case GAMES_CTF:
;490:			if( servernodeptr->gametype != GT_CTF ) {
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
CNSTI4 4
EQI4 $310
line 491
;491:				continue;
ADDRGP4 $301
JUMPV
line 493
;492:			}
;493:			break;
LABELV $309
LABELV $310
line 496
;494:		}
;495:
;496:		if( servernodeptr->pingtime < servernodeptr->minPing ) {
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
GEI4 $325
line 497
;497:			pingColor = S_COLOR_BLUE;
ADDRLP4 20
ADDRGP4 $327
ASGNP4
line 498
;498:		}
ADDRGP4 $326
JUMPV
LABELV $325
line 499
;499:		else if( servernodeptr->maxPing && servernodeptr->pingtime > servernodeptr->maxPing ) {
ADDRLP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 0
EQI4 $328
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
LEI4 $328
line 500
;500:			pingColor = S_COLOR_BLUE;
ADDRLP4 20
ADDRGP4 $327
ASGNP4
line 501
;501:		}
ADDRGP4 $329
JUMPV
LABELV $328
line 502
;502:		else if( servernodeptr->pingtime < 200 ) {
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
CNSTI4 200
GEI4 $330
line 503
;503:			pingColor = S_COLOR_GREEN;
ADDRLP4 20
ADDRGP4 $332
ASGNP4
line 504
;504:		}
ADDRGP4 $331
JUMPV
LABELV $330
line 505
;505:		else if( servernodeptr->pingtime < 400 ) {
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
CNSTI4 400
GEI4 $333
line 506
;506:			pingColor = S_COLOR_YELLOW;
ADDRLP4 20
ADDRGP4 $335
ASGNP4
line 507
;507:		}
ADDRGP4 $334
JUMPV
LABELV $333
line 508
;508:		else {
line 509
;509:			pingColor = S_COLOR_RED;
ADDRLP4 20
ADDRGP4 $336
ASGNP4
line 510
;510:		}
LABELV $334
LABELV $331
LABELV $329
LABELV $326
line 512
;511:
;512:		Com_sprintf( buff, MAX_LISTBOXWIDTH, "%-20.20s %-12.12s %2d/%2d %-8.8s %3s %s%3d " S_COLOR_YELLOW "%s",
ADDRLP4 16
INDIRP4
ARGP4
CNSTI4 68
ARGI4
ADDRGP4 $337
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 89
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 124
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 136
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 netnames
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 0
EQI4 $341
ADDRLP4 44
ADDRGP4 $338
ASGNP4
ADDRGP4 $342
JUMPV
LABELV $341
ADDRLP4 44
ADDRGP4 $339
ASGNP4
LABELV $342
ADDRLP4 44
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 517
;513:			servernodeptr->hostname, servernodeptr->mapname, servernodeptr->numclients,
;514: 			servernodeptr->maxclients, servernodeptr->gamename,
;515:			netnames[servernodeptr->nettype], pingColor, servernodeptr->pingtime, servernodeptr->bPB ? "Yes" : "No" );
;516:
;517:		j++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 518
;518:	}
LABELV $301
line 453
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
ASGNP4
LABELV $303
ADDRLP4 12
INDIRI4
ADDRLP4 24
INDIRI4
LTI4 $300
line 521
;519:
;520:
;521:	g_arenaservers.list.numitems = j;
ADDRGP4 g_arenaservers+912+68
ADDRLP4 8
INDIRI4
ASGNI4
line 522
;522:	g_arenaservers.list.curvalue = 0;
ADDRGP4 g_arenaservers+912+64
CNSTI4 0
ASGNI4
line 523
;523:	g_arenaservers.list.top      = 0;
ADDRGP4 g_arenaservers+912+72
CNSTI4 0
ASGNI4
line 526
;524:
;525:	// update picture
;526:	ArenaServers_UpdatePicture();
ADDRGP4 ArenaServers_UpdatePicture
CALLV
pop
line 527
;527:}
LABELV $187
endproc ArenaServers_UpdateMenu 68 48
proc ArenaServers_Remove 20 12
line 536
;528:
;529:
;530:/*
;531:=================
;532:ArenaServers_Remove
;533:=================
;534:*/
;535:static void ArenaServers_Remove( void )
;536:{
line 541
;537:	int				i;
;538:	servernode_t*	servernodeptr;
;539:	table_t*		tableptr;
;540:
;541:	if (!g_arenaservers.list.numitems)
ADDRGP4 g_arenaservers+912+68
INDIRI4
CNSTI4 0
NEI4 $350
line 542
;542:		return;
ADDRGP4 $349
JUMPV
LABELV $350
line 548
;543:
;544:	// remove selected item from display list
;545:	// items are in scattered order due to sort and cull
;546:	// perform delete on list box contents, resync all lists
;547:
;548:	tableptr      = &g_arenaservers.table[g_arenaservers.list.curvalue];
ADDRLP4 8
ADDRGP4 g_arenaservers+912+64
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 g_arenaservers+4208
ADDP4
ASGNP4
line 549
;549:	servernodeptr = tableptr->servernode;
ADDRLP4 4
ADDRLP4 8
INDIRP4
CNSTI4 68
ADDP4
INDIRP4
ASGNP4
line 552
;550:
;551:	// find address in master list
;552:	for (i=0; i<g_arenaservers.numfavoriteaddresses; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $360
JUMPV
LABELV $357
line 553
;553:		if (!Q_stricmp(g_arenaservers.favoriteaddresses[i],servernodeptr->adrstr))
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 g_arenaservers+13968
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $362
line 554
;554:				break;
ADDRGP4 $359
JUMPV
LABELV $362
LABELV $358
line 552
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $360
ADDRLP4 0
INDIRI4
ADDRGP4 g_arenaservers+14992
INDIRI4
LTI4 $357
LABELV $359
line 557
;555:
;556:	// delete address from master list
;557:	if (i <= g_arenaservers.numfavoriteaddresses-1)
ADDRLP4 0
INDIRI4
ADDRGP4 g_arenaservers+14992
INDIRI4
CNSTI4 1
SUBI4
GTI4 $365
line 558
;558:	{
line 559
;559:		if (i < g_arenaservers.numfavoriteaddresses-1)
ADDRLP4 0
INDIRI4
ADDRGP4 g_arenaservers+14992
INDIRI4
CNSTI4 1
SUBI4
GEI4 $368
line 560
;560:		{
line 562
;561:			// shift items up
;562:			memcpy( &g_arenaservers.favoriteaddresses[i], &g_arenaservers.favoriteaddresses[i+1], (g_arenaservers.numfavoriteaddresses - i - 1)*sizeof(MAX_ADDRESSLENGTH));
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 g_arenaservers+13968
ADDP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 g_arenaservers+13968+64
ADDP4
ARGP4
ADDRGP4 g_arenaservers+14992
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 1
SUBI4
CVIU4 4
CNSTI4 2
LSHU4
CVUI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 563
;563:		}
LABELV $368
line 564
;564:		g_arenaservers.numfavoriteaddresses--;
ADDRLP4 16
ADDRGP4 g_arenaservers+14992
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 565
;565:	}
LABELV $365
line 568
;566:
;567:	// find address in server list
;568:	for (i=0; i<g_numfavoriteservers; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $379
JUMPV
LABELV $376
line 569
;569:		if (&g_favoriteserverlist[i] == servernodeptr)
ADDRLP4 0
INDIRI4
CNSTI4 152
MULI4
ADDRGP4 g_favoriteserverlist
ADDP4
CVPU4 4
ADDRLP4 4
INDIRP4
CVPU4 4
NEU4 $380
line 570
;570:				break;
ADDRGP4 $378
JUMPV
LABELV $380
LABELV $377
line 568
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $379
ADDRLP4 0
INDIRI4
ADDRGP4 g_numfavoriteservers
INDIRI4
LTI4 $376
LABELV $378
line 573
;571:
;572:	// delete address from server list
;573:	if (i <= g_numfavoriteservers-1)
ADDRLP4 0
INDIRI4
ADDRGP4 g_numfavoriteservers
INDIRI4
CNSTI4 1
SUBI4
GTI4 $382
line 574
;574:	{
line 575
;575:		if (i < g_numfavoriteservers-1)
ADDRLP4 0
INDIRI4
ADDRGP4 g_numfavoriteservers
INDIRI4
CNSTI4 1
SUBI4
GEI4 $384
line 576
;576:		{
line 578
;577:			// shift items up
;578:			memcpy( &g_favoriteserverlist[i], &g_favoriteserverlist[i+1], (g_numfavoriteservers - i - 1)*sizeof(servernode_t));
ADDRLP4 0
INDIRI4
CNSTI4 152
MULI4
ADDRGP4 g_favoriteserverlist
ADDP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 152
MULI4
ADDRGP4 g_favoriteserverlist+152
ADDP4
ARGP4
ADDRGP4 g_numfavoriteservers
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 1
SUBI4
CVIU4 4
CNSTU4 152
MULU4
CVUI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 579
;579:		}
LABELV $384
line 580
;580:		g_numfavoriteservers--;
ADDRLP4 16
ADDRGP4 g_numfavoriteservers
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 581
;581:	}
LABELV $382
line 583
;582:
;583:	g_arenaservers.numqueriedservers = g_arenaservers.numfavoriteaddresses;
ADDRGP4 g_arenaservers+13936
ADDRGP4 g_arenaservers+14992
INDIRI4
ASGNI4
line 584
;584:	g_arenaservers.currentping       = g_arenaservers.numfavoriteaddresses;
ADDRGP4 g_arenaservers+13948
ADDRGP4 g_arenaservers+14992
INDIRI4
ASGNI4
line 585
;585:}
LABELV $349
endproc ArenaServers_Remove 20 12
proc ArenaServers_Insert 84 12
line 594
;586:
;587:
;588:/*
;589:=================
;590:ArenaServers_Insert
;591:=================
;592:*/
;593:static void ArenaServers_Insert( char* adrstr, char* info, int pingtime )
;594:{
line 600
;595:	servernode_t*	servernodeptr;
;596:	char*			s;
;597:	int				i;
;598:
;599:
;600:	if ((pingtime >= ArenaServers_MaxPing()) && (g_servertype != AS_FAVORITES))
ADDRLP4 12
ADDRGP4 ArenaServers_MaxPing
CALLI4
ASGNI4
ADDRFP4 8
INDIRI4
ADDRLP4 12
INDIRI4
LTI4 $392
ADDRGP4 g_servertype
INDIRI4
CNSTI4 3
EQI4 $392
line 601
;601:	{
line 603
;602:		// slow global or local servers do not get entered
;603:		return;
ADDRGP4 $391
JUMPV
LABELV $392
line 606
;604:	}
;605:
;606:	if (*g_arenaservers.numservers >= g_arenaservers.maxservers) {
ADDRGP4 g_arenaservers+13940
INDIRP4
INDIRI4
ADDRGP4 g_arenaservers+13960
INDIRI4
LTI4 $394
line 608
;607:		// list full;
;608:		servernodeptr = g_arenaservers.serverlist+(*g_arenaservers.numservers)-1;
ADDRLP4 0
ADDRGP4 g_arenaservers+13940
INDIRP4
INDIRI4
CNSTI4 152
MULI4
ADDRGP4 g_arenaservers+13944
INDIRP4
ADDP4
CNSTI4 -152
ADDP4
ASGNP4
line 609
;609:	} else {
ADDRGP4 $395
JUMPV
LABELV $394
line 611
;610:		// next slot
;611:		servernodeptr = g_arenaservers.serverlist+(*g_arenaservers.numservers);
ADDRLP4 0
ADDRGP4 g_arenaservers+13940
INDIRP4
INDIRI4
CNSTI4 152
MULI4
ADDRGP4 g_arenaservers+13944
INDIRP4
ADDP4
ASGNP4
line 612
;612:		(*g_arenaservers.numservers)++;
ADDRLP4 16
ADDRGP4 g_arenaservers+13940
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 613
;613:	}
LABELV $395
line 615
;614:
;615:	Q_strncpyz( servernodeptr->adrstr, adrstr, MAX_ADDRESSLENGTH );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 617
;616:
;617:	Q_strncpyz( servernodeptr->hostname, Info_ValueForKey( info, "hostname"), MAX_HOSTNAMELENGTH );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $403
ARGP4
ADDRLP4 16
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
CNSTI4 22
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 618
;618:	Q_CleanStr( servernodeptr->hostname );
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 619
;619:	Q_strupr( servernodeptr->hostname );
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 621
;620:
;621:	Q_strncpyz( servernodeptr->mapname, Info_ValueForKey( info, "mapname"), MAX_MAPNAMELENGTH );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $404
ARGP4
ADDRLP4 20
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 89
ADDP4
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 622
;622:	Q_CleanStr( servernodeptr->mapname );
ADDRLP4 0
INDIRP4
CNSTI4 89
ADDP4
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 623
;623:	Q_strupr( servernodeptr->mapname );
ADDRLP4 0
INDIRP4
CNSTI4 89
ADDP4
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 625
;624:
;625:	servernodeptr->numclients = atoi( Info_ValueForKey( info, "clients") );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $405
ARGP4
ADDRLP4 24
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 626
;626:	servernodeptr->maxclients = atoi( Info_ValueForKey( info, "sv_maxclients") );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $406
ARGP4
ADDRLP4 32
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRLP4 36
INDIRI4
ASGNI4
line 627
;627:	servernodeptr->pingtime   = pingtime;
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 628
;628:	servernodeptr->minPing    = atoi( Info_ValueForKey( info, "minPing") );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $407
ARGP4
ADDRLP4 40
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
ADDRLP4 44
INDIRI4
ASGNI4
line 629
;629:	servernodeptr->maxPing    = atoi( Info_ValueForKey( info, "maxPing") );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $408
ARGP4
ADDRLP4 48
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 144
ADDP4
ADDRLP4 52
INDIRI4
ASGNI4
line 630
;630:	servernodeptr->bPB = atoi( Info_ValueForKey( info, "punkbuster") );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $409
ARGP4
ADDRLP4 56
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
ADDRLP4 60
INDIRI4
ASGNI4
line 648
;631:
;632:	/*
;633:	s = Info_ValueForKey( info, "nettype" );
;634:	for (i=0; ;i++)
;635:	{
;636:		if (!netnames[i])
;637:		{
;638:			servernodeptr->nettype = 0;
;639:			break;
;640:		}
;641:		else if (!Q_stricmp( netnames[i], s ))
;642:		{
;643:			servernodeptr->nettype = i;
;644:			break;
;645:		}
;646:	}
;647:	*/
;648:	servernodeptr->nettype = atoi(Info_ValueForKey(info, "nettype"));
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $410
ARGP4
ADDRLP4 64
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 136
ADDP4
ADDRLP4 68
INDIRI4
ASGNI4
line 650
;649:
;650:	s = Info_ValueForKey( info, "game");
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $411
ARGP4
ADDRLP4 72
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 72
INDIRP4
ASGNP4
line 651
;651:	i = atoi( Info_ValueForKey( info, "gametype") );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $412
ARGP4
ADDRLP4 76
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRLP4 80
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 80
INDIRI4
ASGNI4
line 652
;652:	if( i < 0 ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $413
line 653
;653:		i = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 654
;654:	}
ADDRGP4 $414
JUMPV
LABELV $413
line 655
;655:	else if( i > 11 ) {
ADDRLP4 4
INDIRI4
CNSTI4 11
LEI4 $415
line 656
;656:		i = 12;
ADDRLP4 4
CNSTI4 12
ASGNI4
line 657
;657:	}
LABELV $415
LABELV $414
line 658
;658:	if( *s ) {
ADDRLP4 8
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $417
line 659
;659:		servernodeptr->gametype = i;//-1;
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 660
;660:		Q_strncpyz( servernodeptr->gamename, s, sizeof(servernodeptr->gamename) );
ADDRLP4 0
INDIRP4
CNSTI4 124
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 661
;661:	}
ADDRGP4 $418
JUMPV
LABELV $417
line 662
;662:	else {
line 663
;663:		servernodeptr->gametype = i;
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 664
;664:		Q_strncpyz( servernodeptr->gamename, gamenames[i], sizeof(servernodeptr->gamename) );
ADDRLP4 0
INDIRP4
CNSTI4 124
ADDP4
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gamenames
ADDP4
INDIRP4
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 665
;665:	}
LABELV $418
line 666
;666:}
LABELV $391
endproc ArenaServers_Insert 84 12
export ArenaServers_InsertFavorites
proc ArenaServers_InsertFavorites 1040 12
line 677
;667:
;668:
;669:/*
;670:=================
;671:ArenaServers_InsertFavorites
;672:
;673:Insert nonresponsive address book entries into display lists.
;674:=================
;675:*/
;676:void ArenaServers_InsertFavorites( void )
;677:{
line 683
;678:	int		i;
;679:	int		j;
;680:	char	info[MAX_INFO_STRING];
;681:
;682:	// resync existing results with new or deleted cvars
;683:	info[0] = '\0';
ADDRLP4 8
CNSTI1 0
ASGNI1
line 684
;684:	Info_SetValueForKey( info, "hostname", "No Response" );
ADDRLP4 8
ARGP4
ADDRGP4 $403
ARGP4
ADDRGP4 $420
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 685
;685:	for (i=0; i<g_arenaservers.numfavoriteaddresses; i++)
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $424
JUMPV
LABELV $421
line 686
;686:	{
line 688
;687:		// find favorite address in refresh list
;688:		for (j=0; j<g_numfavoriteservers; j++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $429
JUMPV
LABELV $426
line 689
;689:			if (!Q_stricmp(g_arenaservers.favoriteaddresses[i],g_favoriteserverlist[j].adrstr))
ADDRLP4 4
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 g_arenaservers+13968
ADDP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 152
MULI4
ADDRGP4 g_favoriteserverlist
ADDP4
ARGP4
ADDRLP4 1032
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 0
NEI4 $430
line 690
;690:				break;
ADDRGP4 $428
JUMPV
LABELV $430
LABELV $427
line 688
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $429
ADDRLP4 0
INDIRI4
ADDRGP4 g_numfavoriteservers
INDIRI4
LTI4 $426
LABELV $428
line 692
;691:
;692:		if ( j >= g_numfavoriteservers)
ADDRLP4 0
INDIRI4
ADDRGP4 g_numfavoriteservers
INDIRI4
LTI4 $433
line 693
;693:		{
line 695
;694:			// not in list, add it
;695:			ArenaServers_Insert( g_arenaservers.favoriteaddresses[i], info, ArenaServers_MaxPing() );
ADDRLP4 1036
ADDRGP4 ArenaServers_MaxPing
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 g_arenaservers+13968
ADDP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRGP4 ArenaServers_Insert
CALLV
pop
line 696
;696:		}
LABELV $433
line 697
;697:	}
LABELV $422
line 685
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $424
ADDRLP4 4
INDIRI4
ADDRGP4 g_arenaservers+14992
INDIRI4
LTI4 $421
line 698
;698:}
LABELV $419
endproc ArenaServers_InsertFavorites 1040 12
export ArenaServers_LoadFavorites
proc ArenaServers_LoadFavorites 3552 12
line 709
;699:
;700:
;701:/*
;702:=================
;703:ArenaServers_LoadFavorites
;704:
;705:Load cvar address book entries into local lists.
;706:=================
;707:*/
;708:void ArenaServers_LoadFavorites( void )
;709:{
line 718
;710:	int				i;
;711:	int				j;
;712:	int				numtempitems;
;713:	char			emptyinfo[MAX_INFO_STRING];
;714:	char			adrstr[MAX_ADDRESSLENGTH];
;715:	servernode_t	templist[MAX_FAVORITESERVERS];
;716:	qboolean		found;
;717:
;718:	found        = qfalse;
ADDRLP4 2508
CNSTI4 0
ASGNI4
line 719
;719:	emptyinfo[0] = '\0';
ADDRLP4 2512
CNSTI1 0
ASGNI1
line 722
;720:
;721:	// copy the old
;722:	memcpy( templist, g_favoriteserverlist, sizeof(servernode_t)*MAX_FAVORITESERVERS );
ADDRLP4 72
ARGP4
ADDRGP4 g_favoriteserverlist
ARGP4
CNSTI4 2432
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 723
;723:	numtempitems = g_numfavoriteservers;
ADDRLP4 68
ADDRGP4 g_numfavoriteservers
INDIRI4
ASGNI4
line 726
;724:
;725:	// clear the current for sync
;726:	memset( g_favoriteserverlist, 0, sizeof(servernode_t)*MAX_FAVORITESERVERS );
ADDRGP4 g_favoriteserverlist
ARGP4
CNSTI4 0
ARGI4
CNSTI4 2432
ARGI4
ADDRGP4 memset
CALLP4
pop
line 727
;727:	g_numfavoriteservers = 0;
ADDRGP4 g_numfavoriteservers
CNSTI4 0
ASGNI4
line 730
;728:
;729:	// resync existing results with new or deleted cvars
;730:	for (i=0; i<MAX_FAVORITESERVERS; i++)
ADDRLP4 2504
CNSTI4 0
ASGNI4
LABELV $437
line 731
;731:	{
line 732
;732:		trap_Cvar_VariableStringBuffer( va("server%d",i+1), adrstr, MAX_ADDRESSLENGTH );
ADDRGP4 $441
ARGP4
ADDRLP4 2504
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 3536
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 3536
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 733
;733:		if (!adrstr[0])
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $442
line 734
;734:			continue;
ADDRGP4 $438
JUMPV
LABELV $442
line 738
;735:
;736:		// quick sanity check to avoid slow domain name resolving
;737:		// first character must be numeric
;738:		if (adrstr[0] < '0' || adrstr[0] > '9')
ADDRLP4 3540
ADDRLP4 4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 3540
INDIRI4
CNSTI4 48
LTI4 $446
ADDRLP4 3540
INDIRI4
CNSTI4 57
LEI4 $444
LABELV $446
line 739
;739:			continue;
ADDRGP4 $438
JUMPV
LABELV $444
line 744
;740:
;741:		// favorite server addresses must be maintained outside refresh list
;742:		// this mimics local and global netadr's stored in client
;743:		// these can be fetched to fill ping list
;744:		strcpy( g_arenaservers.favoriteaddresses[g_numfavoriteservers], adrstr );
ADDRGP4 g_numfavoriteservers
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 g_arenaservers+13968
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 747
;745:
;746:		// find this server in the old list
;747:		for (j=0; j<numtempitems; j++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $451
JUMPV
LABELV $448
line 748
;748:			if (!Q_stricmp( templist[j].adrstr, adrstr ))
ADDRLP4 0
INDIRI4
CNSTI4 152
MULI4
ADDRLP4 72
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 3544
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 3544
INDIRI4
CNSTI4 0
NEI4 $452
line 749
;749:				break;
ADDRGP4 $450
JUMPV
LABELV $452
LABELV $449
line 747
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $451
ADDRLP4 0
INDIRI4
ADDRLP4 68
INDIRI4
LTI4 $448
LABELV $450
line 751
;750:
;751:		if (j < numtempitems)
ADDRLP4 0
INDIRI4
ADDRLP4 68
INDIRI4
GEI4 $454
line 752
;752:		{
line 754
;753:			// found server - add exisiting results
;754:			memcpy( &g_favoriteserverlist[g_numfavoriteservers], &templist[j], sizeof(servernode_t) );
ADDRGP4 g_numfavoriteservers
INDIRI4
CNSTI4 152
MULI4
ADDRGP4 g_favoriteserverlist
ADDP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 152
MULI4
ADDRLP4 72
ADDP4
ARGP4
CNSTI4 152
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 755
;755:			found = qtrue;
ADDRLP4 2508
CNSTI4 1
ASGNI4
line 756
;756:		}
ADDRGP4 $455
JUMPV
LABELV $454
line 758
;757:		else
;758:		{
line 760
;759:			// add new server
;760:			Q_strncpyz( g_favoriteserverlist[g_numfavoriteservers].adrstr, adrstr, MAX_ADDRESSLENGTH );
ADDRGP4 g_numfavoriteservers
INDIRI4
CNSTI4 152
MULI4
ADDRGP4 g_favoriteserverlist
ADDP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 761
;761:			g_favoriteserverlist[g_numfavoriteservers].pingtime = ArenaServers_MaxPing();
ADDRLP4 3548
ADDRGP4 ArenaServers_MaxPing
CALLI4
ASGNI4
ADDRGP4 g_numfavoriteservers
INDIRI4
CNSTI4 152
MULI4
ADDRGP4 g_favoriteserverlist+116
ADDP4
ADDRLP4 3548
INDIRI4
ASGNI4
line 762
;762:		}
LABELV $455
line 764
;763:
;764:		g_numfavoriteservers++;
ADDRLP4 3548
ADDRGP4 g_numfavoriteservers
ASGNP4
ADDRLP4 3548
INDIRP4
ADDRLP4 3548
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 765
;765:	}
LABELV $438
line 730
ADDRLP4 2504
ADDRLP4 2504
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 2504
INDIRI4
CNSTI4 16
LTI4 $437
line 767
;766:
;767:	g_arenaservers.numfavoriteaddresses = g_numfavoriteservers;
ADDRGP4 g_arenaservers+14992
ADDRGP4 g_numfavoriteservers
INDIRI4
ASGNI4
line 769
;768:
;769:	if (!found)
ADDRLP4 2508
INDIRI4
CNSTI4 0
NEI4 $458
line 770
;770:	{
line 773
;771:		// no results were found, reset server list
;772:		// list will be automatically refreshed when selected
;773:		g_numfavoriteservers = 0;
ADDRGP4 g_numfavoriteservers
CNSTI4 0
ASGNI4
line 774
;774:	}
LABELV $458
line 775
;775:}
LABELV $436
endproc ArenaServers_LoadFavorites 3552 12
proc ArenaServers_StopRefresh 0 16
line 784
;776:
;777:
;778:/*
;779:=================
;780:ArenaServers_StopRefresh
;781:=================
;782:*/
;783:static void ArenaServers_StopRefresh( void )
;784:{
line 785
;785:	if (!g_arenaservers.refreshservers)
ADDRGP4 g_arenaservers+13952
INDIRI4
CNSTI4 0
NEI4 $461
line 787
;786:		// not currently refreshing
;787:		return;
ADDRGP4 $460
JUMPV
LABELV $461
line 789
;788:
;789:	g_arenaservers.refreshservers = qfalse;
ADDRGP4 g_arenaservers+13952
CNSTI4 0
ASGNI4
line 791
;790:
;791:	if (g_servertype == AS_FAVORITES)
ADDRGP4 g_servertype
INDIRI4
CNSTI4 3
NEI4 $465
line 792
;792:	{
line 794
;793:		// nonresponsive favorites must be shown
;794:		ArenaServers_InsertFavorites();
ADDRGP4 ArenaServers_InsertFavorites
CALLV
pop
line 795
;795:	}
LABELV $465
line 798
;796:
;797:	// final tally
;798:	if (g_arenaservers.numqueriedservers >= 0)
ADDRGP4 g_arenaservers+13936
INDIRI4
CNSTI4 0
LTI4 $467
line 799
;799:	{
line 800
;800:		g_arenaservers.currentping       = *g_arenaservers.numservers;
ADDRGP4 g_arenaservers+13948
ADDRGP4 g_arenaservers+13940
INDIRP4
INDIRI4
ASGNI4
line 801
;801:		g_arenaservers.numqueriedservers = *g_arenaservers.numservers;
ADDRGP4 g_arenaservers+13936
ADDRGP4 g_arenaservers+13940
INDIRP4
INDIRI4
ASGNI4
line 802
;802:	}
LABELV $467
line 805
;803:
;804:	// sort
;805:	qsort( g_arenaservers.serverlist, *g_arenaservers.numservers, sizeof( servernode_t ), ArenaServers_Compare);
ADDRGP4 g_arenaservers+13944
INDIRP4
ARGP4
ADDRGP4 g_arenaservers+13940
INDIRP4
INDIRI4
ARGI4
CNSTI4 152
ARGI4
ADDRGP4 ArenaServers_Compare
ARGP4
ADDRGP4 qsort
CALLV
pop
line 807
;806:
;807:	ArenaServers_UpdateMenu();
ADDRGP4 ArenaServers_UpdateMenu
CALLV
pop
line 808
;808:}
LABELV $460
endproc ArenaServers_StopRefresh 0 16
proc ArenaServers_DoRefresh 1120 16
line 817
;809:
;810:
;811:/*
;812:=================
;813:ArenaServers_DoRefresh
;814:=================
;815:*/
;816:static void ArenaServers_DoRefresh( void )
;817:{
line 825
;818:	int		i;
;819:	int		j;
;820:	int		time;
;821:	int		maxPing;
;822:	char	adrstr[MAX_ADDRESSLENGTH];
;823:	char	info[MAX_INFO_STRING];
;824:
;825:	if (uis.realtime < g_arenaservers.refreshtime)
ADDRGP4 uis+4
INDIRI4
ADDRGP4 g_arenaservers+13964
INDIRI4
GEI4 $477
line 826
;826:	{
line 827
;827:	  if (g_servertype != AS_FAVORITES) {
ADDRGP4 g_servertype
INDIRI4
CNSTI4 3
EQI4 $481
line 828
;828:			if (g_servertype == AS_LOCAL) {
ADDRGP4 g_servertype
INDIRI4
CNSTI4 0
NEI4 $483
line 829
;829:				if (!trap_LAN_GetServerCount(g_servertype)) {
ADDRGP4 g_servertype
INDIRI4
ARGI4
ADDRLP4 1104
ADDRGP4 trap_LAN_GetServerCount
CALLI4
ASGNI4
ADDRLP4 1104
INDIRI4
CNSTI4 0
NEI4 $485
line 830
;830:					return;
ADDRGP4 $476
JUMPV
LABELV $485
line 832
;831:				}
;832:			}
LABELV $483
line 833
;833:			if (trap_LAN_GetServerCount(g_servertype) < 0) {
ADDRGP4 g_servertype
INDIRI4
ARGI4
ADDRLP4 1104
ADDRGP4 trap_LAN_GetServerCount
CALLI4
ASGNI4
ADDRLP4 1104
INDIRI4
CNSTI4 0
GEI4 $487
line 835
;834:			  // still waiting for response
;835:			  return;
ADDRGP4 $476
JUMPV
LABELV $487
line 837
;836:			}
;837:	  }
LABELV $481
line 838
;838:	}
LABELV $477
line 840
;839:
;840:	if (uis.realtime < g_arenaservers.nextpingtime)
ADDRGP4 uis+4
INDIRI4
ADDRGP4 g_arenaservers+13956
INDIRI4
GEI4 $489
line 841
;841:	{
line 843
;842:		// wait for time trigger
;843:		return;
ADDRGP4 $476
JUMPV
LABELV $489
line 847
;844:	}
;845:
;846:	// trigger at 10Hz intervals
;847:	g_arenaservers.nextpingtime = uis.realtime + 10;
ADDRGP4 g_arenaservers+13956
ADDRGP4 uis+4
INDIRI4
CNSTI4 10
ADDI4
ASGNI4
line 850
;848:
;849:	// process ping results
;850:	maxPing = ArenaServers_MaxPing();
ADDRLP4 1104
ADDRGP4 ArenaServers_MaxPing
CALLI4
ASGNI4
ADDRLP4 76
ADDRLP4 1104
INDIRI4
ASGNI4
line 851
;851:	for (i=0; i<MAX_PINGREQUESTS; i++)
ADDRLP4 68
CNSTI4 0
ASGNI4
LABELV $495
line 852
;852:	{
line 853
;853:		trap_LAN_GetPing( i, adrstr, MAX_ADDRESSLENGTH, &time );
ADDRLP4 68
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 72
ARGP4
ADDRGP4 trap_LAN_GetPing
CALLV
pop
line 854
;854:		if (!adrstr[0])
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $499
line 855
;855:		{
line 857
;856:			// ignore empty or pending pings
;857:			continue;
ADDRGP4 $496
JUMPV
LABELV $499
line 861
;858:		}
;859:
;860:		// find ping result in our local list
;861:		for (j=0; j<MAX_PINGREQUESTS; j++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $501
line 862
;862:			if (!Q_stricmp( adrstr, g_arenaservers.pinglist[j].adrstr ))
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 68
MULI4
ADDRGP4 g_arenaservers+2032
ADDP4
ARGP4
ADDRLP4 1108
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1108
INDIRI4
CNSTI4 0
NEI4 $505
line 863
;863:				break;
ADDRGP4 $503
JUMPV
LABELV $505
LABELV $502
line 861
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $501
LABELV $503
line 865
;864:
;865:		if (j < MAX_PINGREQUESTS)
ADDRLP4 0
INDIRI4
CNSTI4 32
GEI4 $508
line 866
;866:		{
line 868
;867:			// found it
;868:			if (!time)
ADDRLP4 72
INDIRI4
CNSTI4 0
NEI4 $510
line 869
;869:			{
line 870
;870:				time = uis.realtime - g_arenaservers.pinglist[j].start;
ADDRLP4 72
ADDRGP4 uis+4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 68
MULI4
ADDRGP4 g_arenaservers+2032+64
ADDP4
INDIRI4
SUBI4
ASGNI4
line 871
;871:				if (time < maxPing)
ADDRLP4 72
INDIRI4
ADDRLP4 76
INDIRI4
GEI4 $515
line 872
;872:				{
line 874
;873:					// still waiting
;874:					continue;
ADDRGP4 $496
JUMPV
LABELV $515
line 876
;875:				}
;876:			}
LABELV $510
line 878
;877:
;878:			if (time > maxPing)
ADDRLP4 72
INDIRI4
ADDRLP4 76
INDIRI4
LEI4 $517
line 879
;879:			{
line 881
;880:				// stale it out
;881:				info[0] = '\0';
ADDRLP4 80
CNSTI1 0
ASGNI1
line 882
;882:				time    = maxPing;
ADDRLP4 72
ADDRLP4 76
INDIRI4
ASGNI4
line 883
;883:			}
ADDRGP4 $518
JUMPV
LABELV $517
line 885
;884:			else
;885:			{
line 886
;886:				trap_LAN_GetPingInfo( i, info, MAX_INFO_STRING );
ADDRLP4 68
INDIRI4
ARGI4
ADDRLP4 80
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_LAN_GetPingInfo
CALLV
pop
line 887
;887:			}
LABELV $518
line 890
;888:
;889:			// insert ping results
;890:			ArenaServers_Insert( adrstr, info, time );
ADDRLP4 4
ARGP4
ADDRLP4 80
ARGP4
ADDRLP4 72
INDIRI4
ARGI4
ADDRGP4 ArenaServers_Insert
CALLV
pop
line 893
;891:
;892:			// clear this query from internal list
;893:			g_arenaservers.pinglist[j].adrstr[0] = '\0';
ADDRLP4 0
INDIRI4
CNSTI4 68
MULI4
ADDRGP4 g_arenaservers+2032
ADDP4
CNSTI1 0
ASGNI1
line 894
;894:   		}
LABELV $508
line 897
;895:
;896:		// clear this query from external list
;897:		trap_LAN_ClearPing( i );
ADDRLP4 68
INDIRI4
ARGI4
ADDRGP4 trap_LAN_ClearPing
CALLV
pop
line 898
;898:	}
LABELV $496
line 851
ADDRLP4 68
ADDRLP4 68
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 32
LTI4 $495
line 902
;899:
;900:	// get results of servers query
;901:	// counts can increase as servers respond
;902:	if (g_servertype == AS_FAVORITES) {
ADDRGP4 g_servertype
INDIRI4
CNSTI4 3
NEI4 $520
line 903
;903:	  g_arenaservers.numqueriedservers = g_arenaservers.numfavoriteaddresses;
ADDRGP4 g_arenaservers+13936
ADDRGP4 g_arenaservers+14992
INDIRI4
ASGNI4
line 904
;904:	} else {
ADDRGP4 $521
JUMPV
LABELV $520
line 905
;905:	  g_arenaservers.numqueriedservers = trap_LAN_GetServerCount(g_servertype);
ADDRGP4 g_servertype
INDIRI4
ARGI4
ADDRLP4 1108
ADDRGP4 trap_LAN_GetServerCount
CALLI4
ASGNI4
ADDRGP4 g_arenaservers+13936
ADDRLP4 1108
INDIRI4
ASGNI4
line 906
;906:	}
LABELV $521
line 913
;907:
;908://	if (g_arenaservers.numqueriedservers > g_arenaservers.maxservers)
;909://		g_arenaservers.numqueriedservers = g_arenaservers.maxservers;
;910:
;911:	// send ping requests in reasonable bursts
;912:	// iterate ping through all found servers
;913:	for (i=0; i<MAX_PINGREQUESTS && g_arenaservers.currentping < g_arenaservers.numqueriedservers; i++)
ADDRLP4 68
CNSTI4 0
ASGNI4
ADDRGP4 $528
JUMPV
LABELV $525
line 914
;914:	{
line 915
;915:		if (trap_LAN_GetPingQueueCount() >= MAX_PINGREQUESTS)
ADDRLP4 1108
ADDRGP4 trap_LAN_GetPingQueueCount
CALLI4
ASGNI4
ADDRLP4 1108
INDIRI4
CNSTI4 32
LTI4 $531
line 916
;916:		{
line 918
;917:			// ping queue is full
;918:			break;
ADDRGP4 $527
JUMPV
LABELV $531
line 922
;919:		}
;920:
;921:		// find empty slot
;922:		for (j=0; j<MAX_PINGREQUESTS; j++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $533
line 923
;923:			if (!g_arenaservers.pinglist[j].adrstr[0])
ADDRLP4 0
INDIRI4
CNSTI4 68
MULI4
ADDRGP4 g_arenaservers+2032
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $537
line 924
;924:				break;
ADDRGP4 $535
JUMPV
LABELV $537
LABELV $534
line 922
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $533
LABELV $535
line 926
;925:
;926:		if (j >= MAX_PINGREQUESTS)
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $540
line 928
;927:			// no empty slots available yet - wait for timeout
;928:			break;
ADDRGP4 $527
JUMPV
LABELV $540
line 932
;929:
;930:		// get an address to ping
;931:
;932:		if (g_servertype == AS_FAVORITES) {
ADDRGP4 g_servertype
INDIRI4
CNSTI4 3
NEI4 $542
line 933
;933:		  strcpy( adrstr, g_arenaservers.favoriteaddresses[g_arenaservers.currentping] );
ADDRLP4 4
ARGP4
ADDRGP4 g_arenaservers+13948
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 g_arenaservers+13968
ADDP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 934
;934:		} else {
ADDRGP4 $543
JUMPV
LABELV $542
line 935
;935:		  trap_LAN_GetServerAddressString(g_servertype, g_arenaservers.currentping, adrstr, MAX_ADDRESSLENGTH );
ADDRGP4 g_servertype
INDIRI4
ARGI4
ADDRGP4 g_arenaservers+13948
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_LAN_GetServerAddressString
CALLV
pop
line 936
;936:		}
LABELV $543
line 938
;937:
;938:		strcpy( g_arenaservers.pinglist[j].adrstr, adrstr );
ADDRLP4 0
INDIRI4
CNSTI4 68
MULI4
ADDRGP4 g_arenaservers+2032
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 939
;939:		g_arenaservers.pinglist[j].start = uis.realtime;
ADDRLP4 0
INDIRI4
CNSTI4 68
MULI4
ADDRGP4 g_arenaservers+2032+64
ADDP4
ADDRGP4 uis+4
INDIRI4
ASGNI4
line 941
;940:
;941:		trap_Cmd_ExecuteText( EXEC_NOW, va( "ping %s\n", adrstr )  );
ADDRGP4 $551
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 1112
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 0
ARGI4
ADDRLP4 1112
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 944
;942:
;943:		// advance to next server
;944:		g_arenaservers.currentping++;
ADDRLP4 1116
ADDRGP4 g_arenaservers+13948
ASGNP4
ADDRLP4 1116
INDIRP4
ADDRLP4 1116
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 945
;945:	}
LABELV $526
line 913
ADDRLP4 68
ADDRLP4 68
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $528
ADDRLP4 68
INDIRI4
CNSTI4 32
GEI4 $553
ADDRGP4 g_arenaservers+13948
INDIRI4
ADDRGP4 g_arenaservers+13936
INDIRI4
LTI4 $525
LABELV $553
LABELV $527
line 947
;946:
;947:	if (!trap_LAN_GetPingQueueCount())
ADDRLP4 1108
ADDRGP4 trap_LAN_GetPingQueueCount
CALLI4
ASGNI4
ADDRLP4 1108
INDIRI4
CNSTI4 0
NEI4 $554
line 948
;948:	{
line 950
;949:		// all pings completed
;950:		ArenaServers_StopRefresh();
ADDRGP4 ArenaServers_StopRefresh
CALLV
pop
line 951
;951:		return;
ADDRGP4 $476
JUMPV
LABELV $554
line 955
;952:	}
;953:
;954:	// update the user interface with ping status
;955:	ArenaServers_UpdateMenu();
ADDRGP4 ArenaServers_UpdateMenu
CALLV
pop
line 956
;956:}
LABELV $476
endproc ArenaServers_DoRefresh 1120 16
proc ArenaServers_StartRefresh 88 16
line 965
;957:
;958:
;959:/*
;960:=================
;961:ArenaServers_StartRefresh
;962:=================
;963:*/
;964:static void ArenaServers_StartRefresh( void )
;965:{
line 969
;966:	int		i;
;967:	char	myargs[32], protocol[32];
;968:
;969:	memset( g_arenaservers.serverlist, 0, g_arenaservers.maxservers*sizeof(table_t) );
ADDRGP4 g_arenaservers+13944
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 g_arenaservers+13960
INDIRI4
CVIU4 4
CNSTU4 72
MULU4
CVUI4 4
ARGI4
ADDRGP4 memset
CALLP4
pop
line 971
;970:
;971:	for (i=0; i<MAX_PINGREQUESTS; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $559
line 972
;972:	{
line 973
;973:		g_arenaservers.pinglist[i].adrstr[0] = '\0';
ADDRLP4 0
INDIRI4
CNSTI4 68
MULI4
ADDRGP4 g_arenaservers+2032
ADDP4
CNSTI1 0
ASGNI1
line 974
;974:		trap_LAN_ClearPing( i );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 trap_LAN_ClearPing
CALLV
pop
line 975
;975:	}
LABELV $560
line 971
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $559
line 977
;976:
;977:	g_arenaservers.refreshservers    = qtrue;
ADDRGP4 g_arenaservers+13952
CNSTI4 1
ASGNI4
line 978
;978:	g_arenaservers.currentping       = 0;
ADDRGP4 g_arenaservers+13948
CNSTI4 0
ASGNI4
line 979
;979:	g_arenaservers.nextpingtime      = 0;
ADDRGP4 g_arenaservers+13956
CNSTI4 0
ASGNI4
line 980
;980:	*g_arenaservers.numservers       = 0;
ADDRGP4 g_arenaservers+13940
INDIRP4
CNSTI4 0
ASGNI4
line 981
;981:	g_arenaservers.numqueriedservers = 0;
ADDRGP4 g_arenaservers+13936
CNSTI4 0
ASGNI4
line 984
;982:
;983:	// allow max 5 seconds for responses
;984:	g_arenaservers.refreshtime = uis.realtime + 5000;
ADDRGP4 g_arenaservers+13964
ADDRGP4 uis+4
INDIRI4
CNSTI4 5000
ADDI4
ASGNI4
line 987
;985:
;986:	// place menu in zeroed state
;987:	ArenaServers_UpdateMenu();
ADDRGP4 ArenaServers_UpdateMenu
CALLV
pop
line 989
;988:
;989:	if( g_servertype == AS_LOCAL ) {
ADDRGP4 g_servertype
INDIRI4
CNSTI4 0
NEI4 $571
line 990
;990:		trap_Cmd_ExecuteText( EXEC_APPEND, "localservers\n" );
CNSTI4 2
ARGI4
ADDRGP4 $573
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 991
;991:		return;
ADDRGP4 $556
JUMPV
LABELV $571
line 994
;992:	}
;993:
;994:	if( g_servertype == AS_GLOBAL || g_servertype == AS_MPLAYER ) {
ADDRLP4 68
ADDRGP4 g_servertype
INDIRI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 2
EQI4 $576
ADDRLP4 68
INDIRI4
CNSTI4 1
NEI4 $574
LABELV $576
line 995
;995:		if( g_servertype == AS_GLOBAL ) {
ADDRGP4 g_servertype
INDIRI4
CNSTI4 2
NEI4 $577
line 996
;996:			i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 997
;997:		}
ADDRGP4 $578
JUMPV
LABELV $577
line 998
;998:		else {
line 999
;999:			i = 1;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1000
;1000:		}
LABELV $578
line 1002
;1001:
;1002:		switch( g_arenaservers.gametype.curvalue ) {
ADDRLP4 72
ADDRGP4 g_arenaservers+592+64
INDIRI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
LTI4 $579
ADDRLP4 72
INDIRI4
CNSTI4 4
GTI4 $579
ADDRLP4 72
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $592
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $592
address $583
address $584
address $586
address $588
address $590
code
LABELV $579
LABELV $583
line 1005
;1003:		default:
;1004:		case GAMES_ALL:
;1005:			myargs[0] = 0;
ADDRLP4 36
CNSTI1 0
ASGNI1
line 1006
;1006:			break;
ADDRGP4 $580
JUMPV
LABELV $584
line 1009
;1007:
;1008:		case GAMES_FFA:
;1009:			strcpy( myargs, " ffa" );
ADDRLP4 36
ARGP4
ADDRGP4 $585
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1010
;1010:			break;
ADDRGP4 $580
JUMPV
LABELV $586
line 1013
;1011:
;1012:		case GAMES_TEAMPLAY:
;1013:			strcpy( myargs, " team" );
ADDRLP4 36
ARGP4
ADDRGP4 $587
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1014
;1014:			break;
ADDRGP4 $580
JUMPV
LABELV $588
line 1017
;1015:
;1016:		case GAMES_TOURNEY:
;1017:			strcpy( myargs, " tourney" );
ADDRLP4 36
ARGP4
ADDRGP4 $589
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1018
;1018:			break;
ADDRGP4 $580
JUMPV
LABELV $590
line 1021
;1019:
;1020:		case GAMES_CTF:
;1021:			strcpy( myargs, " ctf" );
ADDRLP4 36
ARGP4
ADDRGP4 $591
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1022
;1022:			break;
LABELV $580
line 1026
;1023:		}
;1024:
;1025:
;1026:		if (g_emptyservers) {
ADDRGP4 g_emptyservers
INDIRI4
CNSTI4 0
EQI4 $593
line 1027
;1027:			strcat(myargs, " empty");
ADDRLP4 36
ARGP4
ADDRGP4 $595
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 1028
;1028:		}
LABELV $593
line 1030
;1029:
;1030:		if (g_fullservers) {
ADDRGP4 g_fullservers
INDIRI4
CNSTI4 0
EQI4 $596
line 1031
;1031:			strcat(myargs, " full");
ADDRLP4 36
ARGP4
ADDRGP4 $598
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 1032
;1032:		}
LABELV $596
line 1034
;1033:
;1034:		protocol[0] = '\0';
ADDRLP4 4
CNSTI1 0
ASGNI1
line 1035
;1035:		trap_Cvar_VariableStringBuffer( "debug_protocol", protocol, sizeof(protocol) );
ADDRGP4 $599
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1036
;1036:		if (strlen(protocol)) {
ADDRLP4 4
ARGP4
ADDRLP4 76
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
EQI4 $600
line 1037
;1037:			trap_Cmd_ExecuteText( EXEC_APPEND, va( "globalservers %d %s%s\n", i, protocol, myargs ));
ADDRGP4 $602
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 80
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 80
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 1038
;1038:		}
ADDRGP4 $601
JUMPV
LABELV $600
line 1039
;1039:		else {
line 1040
;1040:			trap_Cmd_ExecuteText( EXEC_APPEND, va( "globalservers %d %d%s\n", i, (int)trap_Cvar_VariableValue( "protocol" ), myargs ) );
ADDRGP4 $604
ARGP4
ADDRLP4 80
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRGP4 $603
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 80
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 36
ARGP4
ADDRLP4 84
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 84
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 1041
;1041:		}
LABELV $601
line 1042
;1042:	}
LABELV $574
line 1043
;1043:}
LABELV $556
endproc ArenaServers_StartRefresh 88 16
export ArenaServers_SaveChanges
proc ArenaServers_SaveChanges 12 8
line 1052
;1044:
;1045:
;1046:/*
;1047:=================
;1048:ArenaServers_SaveChanges
;1049:=================
;1050:*/
;1051:void ArenaServers_SaveChanges( void )
;1052:{
line 1055
;1053:	int	i;
;1054:
;1055:	for (i=0; i<g_arenaservers.numfavoriteaddresses; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $609
JUMPV
LABELV $606
line 1056
;1056:		trap_Cvar_Set( va("server%d",i+1), g_arenaservers.favoriteaddresses[i] );
ADDRGP4 $441
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 g_arenaservers+13968
ADDP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
LABELV $607
line 1055
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $609
ADDRLP4 0
INDIRI4
ADDRGP4 g_arenaservers+14992
INDIRI4
LTI4 $606
line 1058
;1057:
;1058:	for (; i<MAX_FAVORITESERVERS; i++)
ADDRGP4 $615
JUMPV
LABELV $612
line 1059
;1059:		trap_Cvar_Set( va("server%d",i+1), "" );
ADDRGP4 $441
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 $231
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
LABELV $613
line 1058
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $615
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $612
line 1060
;1060:}
LABELV $605
endproc ArenaServers_SaveChanges 12 8
export ArenaServers_Sort
proc ArenaServers_Sort 0 16
line 1068
;1061:
;1062:
;1063:/*
;1064:=================
;1065:ArenaServers_Sort
;1066:=================
;1067:*/
;1068:void ArenaServers_Sort( int type ) {
line 1069
;1069:	if( g_sortkey == type ) {
ADDRGP4 g_sortkey
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $617
line 1070
;1070:		return;
ADDRGP4 $616
JUMPV
LABELV $617
line 1073
;1071:	}
;1072:
;1073:	g_sortkey = type;
ADDRGP4 g_sortkey
ADDRFP4 0
INDIRI4
ASGNI4
line 1074
;1074:	qsort( g_arenaservers.serverlist, *g_arenaservers.numservers, sizeof( servernode_t ), ArenaServers_Compare);
ADDRGP4 g_arenaservers+13944
INDIRP4
ARGP4
ADDRGP4 g_arenaservers+13940
INDIRP4
INDIRI4
ARGI4
CNSTI4 152
ARGI4
ADDRGP4 ArenaServers_Compare
ARGP4
ADDRGP4 qsort
CALLV
pop
line 1075
;1075:}
LABELV $616
endproc ArenaServers_Sort 0 16
export ArenaServers_SetType
proc ArenaServers_SetType 20 8
line 1084
;1076:
;1077:
;1078:/*
;1079:=================
;1080:ArenaServers_SetType
;1081:=================
;1082:*/
;1083:void ArenaServers_SetType( int type )
;1084:{
line 1085
;1085:	if (g_servertype == type)
ADDRGP4 g_servertype
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $622
line 1086
;1086:		return;
ADDRGP4 $621
JUMPV
LABELV $622
line 1088
;1087:
;1088:	g_servertype = type;
ADDRGP4 g_servertype
ADDRFP4 0
INDIRI4
ASGNI4
line 1090
;1089:
;1090:	switch( type ) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $624
ADDRLP4 0
INDIRI4
CNSTI4 3
GTI4 $624
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $650
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $650
address $626
address $644
address $632
address $638
code
LABELV $624
LABELV $626
line 1093
;1091:	default:
;1092:	case AS_LOCAL:
;1093:		g_arenaservers.remove.generic.flags |= (QMF_INACTIVE|QMF_HIDDEN);
ADDRLP4 4
ADDRGP4 g_arenaservers+1504+44
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRU4
CNSTU4 20480
BORU4
ASGNU4
line 1094
;1094:		g_arenaservers.serverlist = g_localserverlist;
ADDRGP4 g_arenaservers+13944
ADDRGP4 g_localserverlist
ASGNP4
line 1095
;1095:		g_arenaservers.numservers = &g_numlocalservers;
ADDRGP4 g_arenaservers+13940
ADDRGP4 g_numlocalservers
ASGNP4
line 1096
;1096:		g_arenaservers.maxservers = MAX_LOCALSERVERS;
ADDRGP4 g_arenaservers+13960
CNSTI4 128
ASGNI4
line 1097
;1097:		break;
ADDRGP4 $625
JUMPV
LABELV $632
line 1100
;1098:
;1099:	case AS_GLOBAL:
;1100:		g_arenaservers.remove.generic.flags |= (QMF_INACTIVE|QMF_HIDDEN);
ADDRLP4 8
ADDRGP4 g_arenaservers+1504+44
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 20480
BORU4
ASGNU4
line 1101
;1101:		g_arenaservers.serverlist = g_globalserverlist;
ADDRGP4 g_arenaservers+13944
ADDRGP4 g_globalserverlist
ASGNP4
line 1102
;1102:		g_arenaservers.numservers = &g_numglobalservers;
ADDRGP4 g_arenaservers+13940
ADDRGP4 g_numglobalservers
ASGNP4
line 1103
;1103:		g_arenaservers.maxservers = MAX_GLOBALSERVERS;
ADDRGP4 g_arenaservers+13960
CNSTI4 128
ASGNI4
line 1104
;1104:		break;
ADDRGP4 $625
JUMPV
LABELV $638
line 1107
;1105:
;1106:	case AS_FAVORITES:
;1107:		g_arenaservers.remove.generic.flags &= ~(QMF_INACTIVE|QMF_HIDDEN);
ADDRLP4 12
ADDRGP4 g_arenaservers+1504+44
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRU4
CNSTU4 4294946815
BANDU4
ASGNU4
line 1108
;1108:		g_arenaservers.serverlist = g_favoriteserverlist;
ADDRGP4 g_arenaservers+13944
ADDRGP4 g_favoriteserverlist
ASGNP4
line 1109
;1109:		g_arenaservers.numservers = &g_numfavoriteservers;
ADDRGP4 g_arenaservers+13940
ADDRGP4 g_numfavoriteservers
ASGNP4
line 1110
;1110:		g_arenaservers.maxservers = MAX_FAVORITESERVERS;
ADDRGP4 g_arenaservers+13960
CNSTI4 16
ASGNI4
line 1111
;1111:		break;
ADDRGP4 $625
JUMPV
LABELV $644
line 1114
;1112:
;1113:	case AS_MPLAYER:
;1114:		g_arenaservers.remove.generic.flags |= (QMF_INACTIVE|QMF_HIDDEN);
ADDRLP4 16
ADDRGP4 g_arenaservers+1504+44
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRU4
CNSTU4 20480
BORU4
ASGNU4
line 1115
;1115:		g_arenaservers.serverlist = g_mplayerserverlist;
ADDRGP4 g_arenaservers+13944
ADDRGP4 g_mplayerserverlist
ASGNP4
line 1116
;1116:		g_arenaservers.numservers = &g_nummplayerservers;
ADDRGP4 g_arenaservers+13940
ADDRGP4 g_nummplayerservers
ASGNP4
line 1117
;1117:		g_arenaservers.maxservers = MAX_GLOBALSERVERS;
ADDRGP4 g_arenaservers+13960
CNSTI4 128
ASGNI4
line 1118
;1118:		break;
LABELV $625
line 1121
;1119:	}
;1120:
;1121:	if( !*g_arenaservers.numservers ) {
ADDRGP4 g_arenaservers+13940
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $651
line 1122
;1122:		ArenaServers_StartRefresh();
ADDRGP4 ArenaServers_StartRefresh
CALLV
pop
line 1123
;1123:	}
ADDRGP4 $652
JUMPV
LABELV $651
line 1124
;1124:	else {
line 1126
;1125:		// avoid slow operation, use existing results
;1126:		g_arenaservers.currentping       = *g_arenaservers.numservers;
ADDRGP4 g_arenaservers+13948
ADDRGP4 g_arenaservers+13940
INDIRP4
INDIRI4
ASGNI4
line 1127
;1127:		g_arenaservers.numqueriedservers = *g_arenaservers.numservers;
ADDRGP4 g_arenaservers+13936
ADDRGP4 g_arenaservers+13940
INDIRP4
INDIRI4
ASGNI4
line 1128
;1128:		ArenaServers_UpdateMenu();
ADDRGP4 ArenaServers_UpdateMenu
CALLV
pop
line 1129
;1129:	}
LABELV $652
line 1130
;1130:	strcpy(g_arenaservers.status.string,"hit refresh to update");
ADDRGP4 g_arenaservers+1360+60
INDIRP4
ARGP4
ADDRGP4 $660
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1131
;1131:}
LABELV $621
endproc ArenaServers_SetType 20 8
proc Punkbuster_ConfirmEnable 8 12
line 1139
;1132:
;1133:
;1134:/*
;1135:=================
;1136:PunkBuster_Confirm
;1137:=================
;1138:*/
;1139:static void Punkbuster_ConfirmEnable( qboolean result ) {
line 1140
;1140:	if (result)
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $662
line 1141
;1141:	{
line 1143
;1142:		//trap_SetPbClStatus(1);
;1143:	}
LABELV $662
line 1144
;1144:	g_arenaservers.punkbuster.curvalue = Com_Clamp( 0, 1, trap_Cvar_VariableValue( "cl_punkbuster" ) );
ADDRGP4 $666
ARGP4
ADDRLP4 0
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 g_arenaservers+14996+64
ADDRLP4 4
INDIRF4
CVFI4 4
ASGNI4
line 1145
;1145:}
LABELV $661
endproc Punkbuster_ConfirmEnable 8 12
proc Punkbuster_ConfirmDisable 8 12
line 1147
;1146:
;1147:static void Punkbuster_ConfirmDisable( qboolean result ) {
line 1148
;1148:	if (result)
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $668
line 1149
;1149:	{
line 1151
;1150:		//trap_SetPbClStatus(0);
;1151:		UI_Message( punkbuster_msg );
ADDRGP4 punkbuster_msg
ARGP4
ADDRGP4 UI_Message
CALLV
pop
line 1152
;1152:	}
LABELV $668
line 1153
;1153:	g_arenaservers.punkbuster.curvalue = Com_Clamp( 0, 1, trap_Cvar_VariableValue( "cl_punkbuster" ) );
ADDRGP4 $666
ARGP4
ADDRLP4 0
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 g_arenaservers+14996+64
ADDRLP4 4
INDIRF4
CVFI4 4
ASGNI4
line 1154
;1154:}
LABELV $667
endproc Punkbuster_ConfirmDisable 8 12
proc ArenaServers_Event 12 16
line 1161
;1155:
;1156:/*
;1157:=================
;1158:ArenaServers_Event
;1159:=================
;1160:*/
;1161:static void ArenaServers_Event( void* ptr, int event ) {
line 1165
;1162:	int		id;
;1163:	int value;
;1164:
;1165:	id = ((menucommon_s*)ptr)->id;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1167
;1166:
;1167:	if( event != QM_ACTIVATED && id != ID_LIST ) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $673
ADDRLP4 0
INDIRI4
CNSTI4 15
EQI4 $673
line 1168
;1168:		return;
ADDRGP4 $672
JUMPV
LABELV $673
line 1171
;1169:	}
;1170:
;1171:	switch( id ) {
ADDRLP4 0
INDIRI4
CNSTI4 10
LTI4 $675
ADDRLP4 0
INDIRI4
CNSTI4 24
GTI4 $675
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $727-40
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $727
address $677
address $683
address $689
address $695
address $701
address $707
address $710
address $712
address $714
address $715
address $716
address $717
address $718
address $719
address $720
code
LABELV $677
line 1173
;1172:	case ID_MASTER:
;1173:		value = g_arenaservers.master.curvalue;
ADDRLP4 4
ADDRGP4 g_arenaservers+496+64
INDIRI4
ASGNI4
line 1174
;1174:		if (value >= 1)
ADDRLP4 4
INDIRI4
CNSTI4 1
LTI4 $680
line 1175
;1175:		{
line 1176
;1176:			value++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1177
;1177:		}
LABELV $680
line 1178
;1178:		trap_Cvar_SetValue( "ui_browserMaster", value );
ADDRGP4 $682
ARGP4
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1179
;1179:		ArenaServers_SetType( value );
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 ArenaServers_SetType
CALLV
pop
line 1180
;1180:		break;
ADDRGP4 $676
JUMPV
LABELV $683
line 1183
;1181:
;1182:	case ID_GAMETYPE:
;1183:		trap_Cvar_SetValue( "ui_browserGameType", g_arenaservers.gametype.curvalue );
ADDRGP4 $684
ARGP4
ADDRGP4 g_arenaservers+592+64
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1184
;1184:		g_gametype = g_arenaservers.gametype.curvalue;
ADDRGP4 g_gametype
ADDRGP4 g_arenaservers+592+64
INDIRI4
ASGNI4
line 1185
;1185:		ArenaServers_UpdateMenu();
ADDRGP4 ArenaServers_UpdateMenu
CALLV
pop
line 1186
;1186:		break;
ADDRGP4 $676
JUMPV
LABELV $689
line 1189
;1187:
;1188:	case ID_SORTKEY:
;1189:		trap_Cvar_SetValue( "ui_browserSortKey", g_arenaservers.sortkey.curvalue );
ADDRGP4 $690
ARGP4
ADDRGP4 g_arenaservers+688+64
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1190
;1190:		ArenaServers_Sort( g_arenaservers.sortkey.curvalue );
ADDRGP4 g_arenaservers+688+64
INDIRI4
ARGI4
ADDRGP4 ArenaServers_Sort
CALLV
pop
line 1191
;1191:		ArenaServers_UpdateMenu();
ADDRGP4 ArenaServers_UpdateMenu
CALLV
pop
line 1192
;1192:		break;
ADDRGP4 $676
JUMPV
LABELV $695
line 1195
;1193:
;1194:	case ID_SHOW_FULL:
;1195:		trap_Cvar_SetValue( "ui_browserShowFull", g_arenaservers.showfull.curvalue );
ADDRGP4 $696
ARGP4
ADDRGP4 g_arenaservers+784+60
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1196
;1196:		g_fullservers = g_arenaservers.showfull.curvalue;
ADDRGP4 g_fullservers
ADDRGP4 g_arenaservers+784+60
INDIRI4
ASGNI4
line 1197
;1197:		ArenaServers_UpdateMenu();
ADDRGP4 ArenaServers_UpdateMenu
CALLV
pop
line 1198
;1198:		break;
ADDRGP4 $676
JUMPV
LABELV $701
line 1201
;1199:
;1200:	case ID_SHOW_EMPTY:
;1201:		trap_Cvar_SetValue( "ui_browserShowEmpty", g_arenaservers.showempty.curvalue );
ADDRGP4 $702
ARGP4
ADDRGP4 g_arenaservers+848+60
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1202
;1202:		g_emptyservers = g_arenaservers.showempty.curvalue;
ADDRGP4 g_emptyservers
ADDRGP4 g_arenaservers+848+60
INDIRI4
ASGNI4
line 1203
;1203:		ArenaServers_UpdateMenu();
ADDRGP4 ArenaServers_UpdateMenu
CALLV
pop
line 1204
;1204:		break;
ADDRGP4 $676
JUMPV
LABELV $707
line 1207
;1205:
;1206:	case ID_LIST:
;1207:		if( event == QM_GOTFOCUS ) {
ADDRFP4 4
INDIRI4
CNSTI4 1
NEI4 $676
line 1208
;1208:			ArenaServers_UpdatePicture();
ADDRGP4 ArenaServers_UpdatePicture
CALLV
pop
line 1209
;1209:		}
line 1210
;1210:		break;
ADDRGP4 $676
JUMPV
LABELV $710
line 1213
;1211:
;1212:	case ID_SCROLL_UP:
;1213:		ScrollList_Key( &g_arenaservers.list, K_UPARROW );
ADDRGP4 g_arenaservers+912
ARGP4
CNSTI4 132
ARGI4
ADDRGP4 ScrollList_Key
CALLI4
pop
line 1214
;1214:		break;
ADDRGP4 $676
JUMPV
LABELV $712
line 1217
;1215:
;1216:	case ID_SCROLL_DOWN:
;1217:		ScrollList_Key( &g_arenaservers.list, K_DOWNARROW );
ADDRGP4 g_arenaservers+912
ARGP4
CNSTI4 133
ARGI4
ADDRGP4 ScrollList_Key
CALLI4
pop
line 1218
;1218:		break;
ADDRGP4 $676
JUMPV
LABELV $714
line 1221
;1219:
;1220:	case ID_BACK:
;1221:		ArenaServers_StopRefresh();
ADDRGP4 ArenaServers_StopRefresh
CALLV
pop
line 1222
;1222:		ArenaServers_SaveChanges();
ADDRGP4 ArenaServers_SaveChanges
CALLV
pop
line 1223
;1223:		UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 1224
;1224:		break;
ADDRGP4 $676
JUMPV
LABELV $715
line 1227
;1225:
;1226:	case ID_REFRESH:
;1227:		ArenaServers_StartRefresh();
ADDRGP4 ArenaServers_StartRefresh
CALLV
pop
line 1228
;1228:		break;
ADDRGP4 $676
JUMPV
LABELV $716
line 1231
;1229:
;1230:	case ID_SPECIFY:
;1231:		UI_SpecifyServerMenu();
ADDRGP4 UI_SpecifyServerMenu
CALLV
pop
line 1232
;1232:		break;
ADDRGP4 $676
JUMPV
LABELV $717
line 1238
;1233:
;1234:	case ID_CREATE:
;1235:#if 0	// JUHOX: start with game type selection menu
;1236:		UI_StartServerMenu( qtrue );
;1237:#else
;1238:		UI_GTS_Menu(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_GTS_Menu
CALLV
pop
line 1240
;1239:#endif
;1240:		break;
ADDRGP4 $676
JUMPV
LABELV $718
line 1243
;1241:
;1242:	case ID_CONNECT:
;1243:		ArenaServers_Go();
ADDRGP4 ArenaServers_Go
CALLV
pop
line 1244
;1244:		break;
ADDRGP4 $676
JUMPV
LABELV $719
line 1247
;1245:
;1246:	case ID_REMOVE:
;1247:		ArenaServers_Remove();
ADDRGP4 ArenaServers_Remove
CALLV
pop
line 1248
;1248:		ArenaServers_UpdateMenu();
ADDRGP4 ArenaServers_UpdateMenu
CALLV
pop
line 1249
;1249:		break;
ADDRGP4 $676
JUMPV
LABELV $720
line 1252
;1250:
;1251:	case ID_PUNKBUSTER:
;1252:		if (g_arenaservers.punkbuster.curvalue)
ADDRGP4 g_arenaservers+14996+64
INDIRI4
CNSTI4 0
EQI4 $721
line 1253
;1253:		{
line 1254
;1254:			UI_ConfirmMenu_Style( "Enable Punkbuster?",  UI_CENTER|UI_INVERSE|UI_SMALLFONT, (voidfunc_f)NULL, Punkbuster_ConfirmEnable );
ADDRGP4 $725
ARGP4
CNSTI4 8209
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 Punkbuster_ConfirmEnable
ARGP4
ADDRGP4 UI_ConfirmMenu_Style
CALLV
pop
line 1255
;1255:		}
ADDRGP4 $676
JUMPV
LABELV $721
line 1257
;1256:		else
;1257:		{
line 1258
;1258:			UI_ConfirmMenu_Style( "Disable Punkbuster?", UI_CENTER|UI_INVERSE|UI_SMALLFONT, (voidfunc_f)NULL, Punkbuster_ConfirmDisable );
ADDRGP4 $726
ARGP4
CNSTI4 8209
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 Punkbuster_ConfirmDisable
ARGP4
ADDRGP4 UI_ConfirmMenu_Style
CALLV
pop
line 1259
;1259:		}
line 1260
;1260:		break;
LABELV $675
LABELV $676
line 1262
;1261:	}
;1262:}
LABELV $672
endproc ArenaServers_Event 12 16
proc ArenaServers_MenuDraw 0 4
line 1271
;1263:
;1264:
;1265:/*
;1266:=================
;1267:ArenaServers_MenuDraw
;1268:=================
;1269:*/
;1270:static void ArenaServers_MenuDraw( void )
;1271:{
line 1272
;1272:	if (g_arenaservers.refreshservers)
ADDRGP4 g_arenaservers+13952
INDIRI4
CNSTI4 0
EQI4 $730
line 1273
;1273:		ArenaServers_DoRefresh();
ADDRGP4 ArenaServers_DoRefresh
CALLV
pop
LABELV $730
line 1275
;1274:
;1275:	Menu_Draw( &g_arenaservers.menu );
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 Menu_Draw
CALLV
pop
line 1276
;1276:}
LABELV $729
endproc ArenaServers_MenuDraw 0 4
proc ArenaServers_MenuKey 16 8
line 1284
;1277:
;1278:
;1279:/*
;1280:=================
;1281:ArenaServers_MenuKey
;1282:=================
;1283:*/
;1284:static sfxHandle_t ArenaServers_MenuKey( int key ) {
line 1285
;1285:	if( key == K_SPACE  && g_arenaservers.refreshservers ) {
ADDRFP4 0
INDIRI4
CNSTI4 32
NEI4 $734
ADDRGP4 g_arenaservers+13952
INDIRI4
CNSTI4 0
EQI4 $734
line 1286
;1286:		ArenaServers_StopRefresh();
ADDRGP4 ArenaServers_StopRefresh
CALLV
pop
line 1287
;1287:		return menu_move_sound;
ADDRGP4 menu_move_sound
INDIRI4
RETI4
ADDRGP4 $733
JUMPV
LABELV $734
line 1290
;1288:	}
;1289:
;1290:	if( ( key == K_DEL || key == K_KP_DEL ) && ( g_servertype == AS_FAVORITES ) &&
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 140
EQI4 $740
ADDRLP4 0
INDIRI4
CNSTI4 171
NEI4 $737
LABELV $740
ADDRGP4 g_servertype
INDIRI4
CNSTI4 3
NEI4 $737
ADDRGP4 g_arenaservers
ARGP4
ADDRLP4 4
ADDRGP4 Menu_ItemAtCursor
CALLP4
ASGNP4
ADDRGP4 g_arenaservers+912
CVPU4 4
ADDRLP4 4
INDIRP4
CVPU4 4
NEU4 $737
line 1291
;1291:		( Menu_ItemAtCursor( &g_arenaservers.menu) == &g_arenaservers.list ) ) {
line 1292
;1292:		ArenaServers_Remove();
ADDRGP4 ArenaServers_Remove
CALLV
pop
line 1293
;1293:		ArenaServers_UpdateMenu();
ADDRGP4 ArenaServers_UpdateMenu
CALLV
pop
line 1294
;1294:		return menu_move_sound;
ADDRGP4 menu_move_sound
INDIRI4
RETI4
ADDRGP4 $733
JUMPV
LABELV $737
line 1297
;1295:	}
;1296:
;1297:	if( key == K_MOUSE2 || key == K_ESCAPE ) {
ADDRLP4 8
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 179
EQI4 $743
ADDRLP4 8
INDIRI4
CNSTI4 27
NEI4 $741
LABELV $743
line 1298
;1298:		ArenaServers_StopRefresh();
ADDRGP4 ArenaServers_StopRefresh
CALLV
pop
line 1299
;1299:		ArenaServers_SaveChanges();
ADDRGP4 ArenaServers_SaveChanges
CALLV
pop
line 1300
;1300:	}
LABELV $741
line 1303
;1301:
;1302:
;1303:	return Menu_DefaultKey( &g_arenaservers.menu, key );
ADDRGP4 g_arenaservers
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 Menu_DefaultKey
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
RETI4
LABELV $733
endproc ArenaServers_MenuKey 16 8
bss
align 1
LABELV $745
skip 64
code
proc ArenaServers_MenuInit 44 16
line 1312
;1304:}
;1305:
;1306:
;1307:/*
;1308:=================
;1309:ArenaServers_MenuInit
;1310:=================
;1311:*/
;1312:static void ArenaServers_MenuInit( void ) {
line 1320
;1313:	int			i;
;1314:	int			type;
;1315:	int			y;
;1316:	int			value;
;1317:	static char	statusbuffer[MAX_STATUSLENGTH];
;1318:
;1319:	// zero set all our globals
;1320:	memset( &g_arenaservers, 0 ,sizeof(arenaservers_t) );
ADDRGP4 g_arenaservers
ARGP4
CNSTI4 0
ARGI4
CNSTI4 15180
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1322
;1321:
;1322:	ArenaServers_Cache();
ADDRGP4 ArenaServers_Cache
CALLV
pop
line 1324
;1323:
;1324:	g_arenaservers.menu.fullscreen = qtrue;
ADDRGP4 g_arenaservers+408
CNSTI4 1
ASGNI4
line 1325
;1325:	g_arenaservers.menu.wrapAround = qtrue;
ADDRGP4 g_arenaservers+404
CNSTI4 1
ASGNI4
line 1326
;1326:    g_arenaservers.menu.draw       = ArenaServers_MenuDraw;
ADDRGP4 g_arenaservers+396
ADDRGP4 ArenaServers_MenuDraw
ASGNP4
line 1327
;1327:	g_arenaservers.menu.key        = ArenaServers_MenuKey;
ADDRGP4 g_arenaservers+400
ADDRGP4 ArenaServers_MenuKey
ASGNP4
line 1329
;1328:
;1329:	g_arenaservers.banner.generic.type  = MTYPE_BTEXT;
ADDRGP4 g_arenaservers+424
CNSTI4 10
ASGNI4
line 1330
;1330:	g_arenaservers.banner.generic.flags = QMF_CENTER_JUSTIFY;
ADDRGP4 g_arenaservers+424+44
CNSTU4 8
ASGNU4
line 1331
;1331:	g_arenaservers.banner.generic.x	    = 320;
ADDRGP4 g_arenaservers+424+12
CNSTI4 320
ASGNI4
line 1332
;1332:	g_arenaservers.banner.generic.y	    = 16;
ADDRGP4 g_arenaservers+424+16
CNSTI4 16
ASGNI4
line 1333
;1333:	g_arenaservers.banner.string  		= "ARENA SERVERS";
ADDRGP4 g_arenaservers+424+60
ADDRGP4 $759
ASGNP4
line 1334
;1334:	g_arenaservers.banner.style  	    = UI_CENTER;
ADDRGP4 g_arenaservers+424+64
CNSTI4 1
ASGNI4
line 1335
;1335:	g_arenaservers.banner.color  	    = color_white;
ADDRGP4 g_arenaservers+424+68
ADDRGP4 color_white
ASGNP4
line 1337
;1336:
;1337:	y = 80;
ADDRLP4 4
CNSTI4 80
ASGNI4
line 1338
;1338:	g_arenaservers.master.generic.type			= MTYPE_SPINCONTROL;
ADDRGP4 g_arenaservers+496
CNSTI4 3
ASGNI4
line 1339
;1339:	g_arenaservers.master.generic.name			= "Servers:";
ADDRGP4 g_arenaservers+496+4
ADDRGP4 $767
ASGNP4
line 1340
;1340:	g_arenaservers.master.generic.flags			= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 g_arenaservers+496+44
CNSTU4 258
ASGNU4
line 1341
;1341:	g_arenaservers.master.generic.callback		= ArenaServers_Event;
ADDRGP4 g_arenaservers+496+48
ADDRGP4 ArenaServers_Event
ASGNP4
line 1342
;1342:	g_arenaservers.master.generic.id			= ID_MASTER;
ADDRGP4 g_arenaservers+496+8
CNSTI4 10
ASGNI4
line 1343
;1343:	g_arenaservers.master.generic.x				= 320;
ADDRGP4 g_arenaservers+496+12
CNSTI4 320
ASGNI4
line 1344
;1344:	g_arenaservers.master.generic.y				= y;
ADDRGP4 g_arenaservers+496+16
ADDRLP4 4
INDIRI4
ASGNI4
line 1345
;1345:	g_arenaservers.master.itemnames				= master_items;
ADDRGP4 g_arenaservers+496+76
ADDRGP4 master_items
ASGNP4
line 1347
;1346:
;1347:	y += SMALLCHAR_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 1348
;1348:	g_arenaservers.gametype.generic.type		= MTYPE_SPINCONTROL;
ADDRGP4 g_arenaservers+592
CNSTI4 3
ASGNI4
line 1349
;1349:	g_arenaservers.gametype.generic.name		= "Game Type:";
ADDRGP4 g_arenaservers+592+4
ADDRGP4 $783
ASGNP4
line 1350
;1350:	g_arenaservers.gametype.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 g_arenaservers+592+44
CNSTU4 258
ASGNU4
line 1351
;1351:	g_arenaservers.gametype.generic.callback	= ArenaServers_Event;
ADDRGP4 g_arenaservers+592+48
ADDRGP4 ArenaServers_Event
ASGNP4
line 1352
;1352:	g_arenaservers.gametype.generic.id			= ID_GAMETYPE;
ADDRGP4 g_arenaservers+592+8
CNSTI4 11
ASGNI4
line 1353
;1353:	g_arenaservers.gametype.generic.x			= 320;
ADDRGP4 g_arenaservers+592+12
CNSTI4 320
ASGNI4
line 1354
;1354:	g_arenaservers.gametype.generic.y			= y;
ADDRGP4 g_arenaservers+592+16
ADDRLP4 4
INDIRI4
ASGNI4
line 1355
;1355:	g_arenaservers.gametype.itemnames			= servertype_items;
ADDRGP4 g_arenaservers+592+76
ADDRGP4 servertype_items
ASGNP4
line 1357
;1356:
;1357:	y += SMALLCHAR_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 1358
;1358:	g_arenaservers.sortkey.generic.type			= MTYPE_SPINCONTROL;
ADDRGP4 g_arenaservers+688
CNSTI4 3
ASGNI4
line 1359
;1359:	g_arenaservers.sortkey.generic.name			= "Sort By:";
ADDRGP4 g_arenaservers+688+4
ADDRGP4 $799
ASGNP4
line 1360
;1360:	g_arenaservers.sortkey.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 g_arenaservers+688+44
CNSTU4 258
ASGNU4
line 1361
;1361:	g_arenaservers.sortkey.generic.callback		= ArenaServers_Event;
ADDRGP4 g_arenaservers+688+48
ADDRGP4 ArenaServers_Event
ASGNP4
line 1362
;1362:	g_arenaservers.sortkey.generic.id			= ID_SORTKEY;
ADDRGP4 g_arenaservers+688+8
CNSTI4 12
ASGNI4
line 1363
;1363:	g_arenaservers.sortkey.generic.x			= 320;
ADDRGP4 g_arenaservers+688+12
CNSTI4 320
ASGNI4
line 1364
;1364:	g_arenaservers.sortkey.generic.y			= y;
ADDRGP4 g_arenaservers+688+16
ADDRLP4 4
INDIRI4
ASGNI4
line 1365
;1365:	g_arenaservers.sortkey.itemnames			= sortkey_items;
ADDRGP4 g_arenaservers+688+76
ADDRGP4 sortkey_items
ASGNP4
line 1367
;1366:
;1367:	y += SMALLCHAR_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 1368
;1368:	g_arenaservers.showfull.generic.type		= MTYPE_RADIOBUTTON;
ADDRGP4 g_arenaservers+784
CNSTI4 5
ASGNI4
line 1369
;1369:	g_arenaservers.showfull.generic.name		= "Show Full:";
ADDRGP4 g_arenaservers+784+4
ADDRGP4 $815
ASGNP4
line 1370
;1370:	g_arenaservers.showfull.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 g_arenaservers+784+44
CNSTU4 258
ASGNU4
line 1371
;1371:	g_arenaservers.showfull.generic.callback	= ArenaServers_Event;
ADDRGP4 g_arenaservers+784+48
ADDRGP4 ArenaServers_Event
ASGNP4
line 1372
;1372:	g_arenaservers.showfull.generic.id			= ID_SHOW_FULL;
ADDRGP4 g_arenaservers+784+8
CNSTI4 13
ASGNI4
line 1373
;1373:	g_arenaservers.showfull.generic.x			= 320;
ADDRGP4 g_arenaservers+784+12
CNSTI4 320
ASGNI4
line 1374
;1374:	g_arenaservers.showfull.generic.y			= y;
ADDRGP4 g_arenaservers+784+16
ADDRLP4 4
INDIRI4
ASGNI4
line 1376
;1375:
;1376:	y += SMALLCHAR_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 1377
;1377:	g_arenaservers.showempty.generic.type		= MTYPE_RADIOBUTTON;
ADDRGP4 g_arenaservers+848
CNSTI4 5
ASGNI4
line 1378
;1378:	g_arenaservers.showempty.generic.name		= "Show Empty:";
ADDRGP4 g_arenaservers+848+4
ADDRGP4 $829
ASGNP4
line 1379
;1379:	g_arenaservers.showempty.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 g_arenaservers+848+44
CNSTU4 258
ASGNU4
line 1380
;1380:	g_arenaservers.showempty.generic.callback	= ArenaServers_Event;
ADDRGP4 g_arenaservers+848+48
ADDRGP4 ArenaServers_Event
ASGNP4
line 1381
;1381:	g_arenaservers.showempty.generic.id			= ID_SHOW_EMPTY;
ADDRGP4 g_arenaservers+848+8
CNSTI4 14
ASGNI4
line 1382
;1382:	g_arenaservers.showempty.generic.x			= 320;
ADDRGP4 g_arenaservers+848+12
CNSTI4 320
ASGNI4
line 1383
;1383:	g_arenaservers.showempty.generic.y			= y;
ADDRGP4 g_arenaservers+848+16
ADDRLP4 4
INDIRI4
ASGNI4
line 1385
;1384:
;1385:	y += 3 * SMALLCHAR_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 48
ADDI4
ASGNI4
line 1386
;1386:	g_arenaservers.list.generic.type			= MTYPE_SCROLLLIST;
ADDRGP4 g_arenaservers+912
CNSTI4 8
ASGNI4
line 1387
;1387:	g_arenaservers.list.generic.flags			= QMF_HIGHLIGHT_IF_FOCUS;
ADDRGP4 g_arenaservers+912+44
CNSTU4 128
ASGNU4
line 1388
;1388:	g_arenaservers.list.generic.id				= ID_LIST;
ADDRGP4 g_arenaservers+912+8
CNSTI4 15
ASGNI4
line 1389
;1389:	g_arenaservers.list.generic.callback		= ArenaServers_Event;
ADDRGP4 g_arenaservers+912+48
ADDRGP4 ArenaServers_Event
ASGNP4
line 1390
;1390:	g_arenaservers.list.generic.x				= 72;
ADDRGP4 g_arenaservers+912+12
CNSTI4 72
ASGNI4
line 1391
;1391:	g_arenaservers.list.generic.y				= y;
ADDRGP4 g_arenaservers+912+16
ADDRLP4 4
INDIRI4
ASGNI4
line 1392
;1392:	g_arenaservers.list.width					= MAX_LISTBOXWIDTH;
ADDRGP4 g_arenaservers+912+80
CNSTI4 68
ASGNI4
line 1393
;1393:	g_arenaservers.list.height					= 11;
ADDRGP4 g_arenaservers+912+84
CNSTI4 11
ASGNI4
line 1394
;1394:	g_arenaservers.list.itemnames				= (const char **)g_arenaservers.items;
ADDRGP4 g_arenaservers+912+76
ADDRGP4 g_arenaservers+13424
ASGNP4
line 1395
;1395:	for( i = 0; i < MAX_LISTBOXITEMS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $858
line 1396
;1396:		g_arenaservers.items[i] = g_arenaservers.table[i].buff;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_arenaservers+13424
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 g_arenaservers+4208
ADDP4
ASGNP4
line 1397
;1397:	}
LABELV $859
line 1395
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 128
LTI4 $858
line 1399
;1398:
;1399:	g_arenaservers.mappic.generic.type			= MTYPE_BITMAP;
ADDRGP4 g_arenaservers+1008
CNSTI4 6
ASGNI4
line 1400
;1400:	g_arenaservers.mappic.generic.flags			= QMF_LEFT_JUSTIFY|QMF_INACTIVE;
ADDRGP4 g_arenaservers+1008+44
CNSTU4 16388
ASGNU4
line 1401
;1401:	g_arenaservers.mappic.generic.x				= 72;
ADDRGP4 g_arenaservers+1008+12
CNSTI4 72
ASGNI4
line 1402
;1402:	g_arenaservers.mappic.generic.y				= 80;
ADDRGP4 g_arenaservers+1008+16
CNSTI4 80
ASGNI4
line 1403
;1403:	g_arenaservers.mappic.width					= 128;
ADDRGP4 g_arenaservers+1008+76
CNSTI4 128
ASGNI4
line 1404
;1404:	g_arenaservers.mappic.height				= 96;
ADDRGP4 g_arenaservers+1008+80
CNSTI4 96
ASGNI4
line 1405
;1405:	g_arenaservers.mappic.errorpic				= ART_UNKNOWNMAP;
ADDRGP4 g_arenaservers+1008+64
ADDRGP4 $877
ASGNP4
line 1407
;1406:
;1407:	g_arenaservers.arrows.generic.type			= MTYPE_BITMAP;
ADDRGP4 g_arenaservers+1096
CNSTI4 6
ASGNI4
line 1408
;1408:	g_arenaservers.arrows.generic.name			= ART_ARROWS0;
ADDRGP4 g_arenaservers+1096+4
ADDRGP4 $881
ASGNP4
line 1409
;1409:	g_arenaservers.arrows.generic.flags			= QMF_LEFT_JUSTIFY|QMF_INACTIVE;
ADDRGP4 g_arenaservers+1096+44
CNSTU4 16388
ASGNU4
line 1410
;1410:	g_arenaservers.arrows.generic.callback		= ArenaServers_Event;
ADDRGP4 g_arenaservers+1096+48
ADDRGP4 ArenaServers_Event
ASGNP4
line 1411
;1411:	g_arenaservers.arrows.generic.x				= 512+48;
ADDRGP4 g_arenaservers+1096+12
CNSTI4 560
ASGNI4
line 1412
;1412:	g_arenaservers.arrows.generic.y				= 240-64+16;
ADDRGP4 g_arenaservers+1096+16
CNSTI4 192
ASGNI4
line 1413
;1413:	g_arenaservers.arrows.width					= 64;
ADDRGP4 g_arenaservers+1096+76
CNSTI4 64
ASGNI4
line 1414
;1414:	g_arenaservers.arrows.height				= 128;
ADDRGP4 g_arenaservers+1096+80
CNSTI4 128
ASGNI4
line 1416
;1415:
;1416:	g_arenaservers.up.generic.type				= MTYPE_BITMAP;
ADDRGP4 g_arenaservers+1184
CNSTI4 6
ASGNI4
line 1417
;1417:	g_arenaservers.up.generic.flags				= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_MOUSEONLY;
ADDRGP4 g_arenaservers+1184+44
CNSTU4 2308
ASGNU4
line 1418
;1418:	g_arenaservers.up.generic.callback			= ArenaServers_Event;
ADDRGP4 g_arenaservers+1184+48
ADDRGP4 ArenaServers_Event
ASGNP4
line 1419
;1419:	g_arenaservers.up.generic.id				= ID_SCROLL_UP;
ADDRGP4 g_arenaservers+1184+8
CNSTI4 16
ASGNI4
line 1420
;1420:	g_arenaservers.up.generic.x					= 512+48;
ADDRGP4 g_arenaservers+1184+12
CNSTI4 560
ASGNI4
line 1421
;1421:	g_arenaservers.up.generic.y					= 240-64+16;
ADDRGP4 g_arenaservers+1184+16
CNSTI4 192
ASGNI4
line 1422
;1422:	g_arenaservers.up.width						= 64;
ADDRGP4 g_arenaservers+1184+76
CNSTI4 64
ASGNI4
line 1423
;1423:	g_arenaservers.up.height					= 64;
ADDRGP4 g_arenaservers+1184+80
CNSTI4 64
ASGNI4
line 1424
;1424:	g_arenaservers.up.focuspic					= ART_ARROWS_UP;
ADDRGP4 g_arenaservers+1184+60
ADDRGP4 $911
ASGNP4
line 1426
;1425:
;1426:	g_arenaservers.down.generic.type			= MTYPE_BITMAP;
ADDRGP4 g_arenaservers+1272
CNSTI4 6
ASGNI4
line 1427
;1427:	g_arenaservers.down.generic.flags			= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_MOUSEONLY;
ADDRGP4 g_arenaservers+1272+44
CNSTU4 2308
ASGNU4
line 1428
;1428:	g_arenaservers.down.generic.callback		= ArenaServers_Event;
ADDRGP4 g_arenaservers+1272+48
ADDRGP4 ArenaServers_Event
ASGNP4
line 1429
;1429:	g_arenaservers.down.generic.id				= ID_SCROLL_DOWN;
ADDRGP4 g_arenaservers+1272+8
CNSTI4 17
ASGNI4
line 1430
;1430:	g_arenaservers.down.generic.x				= 512+48;
ADDRGP4 g_arenaservers+1272+12
CNSTI4 560
ASGNI4
line 1431
;1431:	g_arenaservers.down.generic.y				= 240+16;
ADDRGP4 g_arenaservers+1272+16
CNSTI4 256
ASGNI4
line 1432
;1432:	g_arenaservers.down.width					= 64;
ADDRGP4 g_arenaservers+1272+76
CNSTI4 64
ASGNI4
line 1433
;1433:	g_arenaservers.down.height					= 64;
ADDRGP4 g_arenaservers+1272+80
CNSTI4 64
ASGNI4
line 1434
;1434:	g_arenaservers.down.focuspic				= ART_ARROWS_DOWN;
ADDRGP4 g_arenaservers+1272+60
ADDRGP4 $929
ASGNP4
line 1436
;1435:
;1436:	y = 376;
ADDRLP4 4
CNSTI4 376
ASGNI4
line 1437
;1437:	g_arenaservers.status.generic.type		= MTYPE_TEXT;
ADDRGP4 g_arenaservers+1360
CNSTI4 7
ASGNI4
line 1438
;1438:	g_arenaservers.status.generic.x			= 320;
ADDRGP4 g_arenaservers+1360+12
CNSTI4 320
ASGNI4
line 1439
;1439:	g_arenaservers.status.generic.y			= y;
ADDRGP4 g_arenaservers+1360+16
ADDRLP4 4
INDIRI4
ASGNI4
line 1440
;1440:	g_arenaservers.status.string			= statusbuffer;
ADDRGP4 g_arenaservers+1360+60
ADDRGP4 $745
ASGNP4
line 1441
;1441:	g_arenaservers.status.style				= UI_CENTER|UI_SMALLFONT;
ADDRGP4 g_arenaservers+1360+64
CNSTI4 17
ASGNI4
line 1442
;1442:	g_arenaservers.status.color				= menu_text_color;
ADDRGP4 g_arenaservers+1360+68
ADDRGP4 menu_text_color
ASGNP4
line 1444
;1443:
;1444:	y += SMALLCHAR_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 1445
;1445:	g_arenaservers.statusbar.generic.type   = MTYPE_TEXT;
ADDRGP4 g_arenaservers+1432
CNSTI4 7
ASGNI4
line 1446
;1446:	g_arenaservers.statusbar.generic.x	    = 320;
ADDRGP4 g_arenaservers+1432+12
CNSTI4 320
ASGNI4
line 1447
;1447:	g_arenaservers.statusbar.generic.y	    = y;
ADDRGP4 g_arenaservers+1432+16
ADDRLP4 4
INDIRI4
ASGNI4
line 1448
;1448:	g_arenaservers.statusbar.string	        = "";
ADDRGP4 g_arenaservers+1432+60
ADDRGP4 $231
ASGNP4
line 1449
;1449:	g_arenaservers.statusbar.style	        = UI_CENTER|UI_SMALLFONT;
ADDRGP4 g_arenaservers+1432+64
CNSTI4 17
ASGNI4
line 1450
;1450:	g_arenaservers.statusbar.color	        = text_color_normal;
ADDRGP4 g_arenaservers+1432+68
ADDRGP4 text_color_normal
ASGNP4
line 1452
;1451:
;1452:	g_arenaservers.remove.generic.type		= MTYPE_BITMAP;
ADDRGP4 g_arenaservers+1504
CNSTI4 6
ASGNI4
line 1453
;1453:	g_arenaservers.remove.generic.name		= ART_REMOVE0;
ADDRGP4 g_arenaservers+1504+4
ADDRGP4 $955
ASGNP4
line 1454
;1454:	g_arenaservers.remove.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 g_arenaservers+1504+44
CNSTU4 260
ASGNU4
line 1455
;1455:	g_arenaservers.remove.generic.callback	= ArenaServers_Event;
ADDRGP4 g_arenaservers+1504+48
ADDRGP4 ArenaServers_Event
ASGNP4
line 1456
;1456:	g_arenaservers.remove.generic.id		= ID_REMOVE;
ADDRGP4 g_arenaservers+1504+8
CNSTI4 23
ASGNI4
line 1457
;1457:	g_arenaservers.remove.generic.x			= 450;
ADDRGP4 g_arenaservers+1504+12
CNSTI4 450
ASGNI4
line 1458
;1458:	g_arenaservers.remove.generic.y			= 86;
ADDRGP4 g_arenaservers+1504+16
CNSTI4 86
ASGNI4
line 1459
;1459:	g_arenaservers.remove.width				= 96;
ADDRGP4 g_arenaservers+1504+76
CNSTI4 96
ASGNI4
line 1460
;1460:	g_arenaservers.remove.height			= 48;
ADDRGP4 g_arenaservers+1504+80
CNSTI4 48
ASGNI4
line 1461
;1461:	g_arenaservers.remove.focuspic			= ART_REMOVE1;
ADDRGP4 g_arenaservers+1504+60
ADDRGP4 $972
ASGNP4
line 1463
;1462:
;1463:	g_arenaservers.back.generic.type		= MTYPE_BITMAP;
ADDRGP4 g_arenaservers+1592
CNSTI4 6
ASGNI4
line 1464
;1464:	g_arenaservers.back.generic.name		= ART_BACK0;
ADDRGP4 g_arenaservers+1592+4
ADDRGP4 $976
ASGNP4
line 1465
;1465:	g_arenaservers.back.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 g_arenaservers+1592+44
CNSTU4 260
ASGNU4
line 1466
;1466:	g_arenaservers.back.generic.callback	= ArenaServers_Event;
ADDRGP4 g_arenaservers+1592+48
ADDRGP4 ArenaServers_Event
ASGNP4
line 1467
;1467:	g_arenaservers.back.generic.id			= ID_BACK;
ADDRGP4 g_arenaservers+1592+8
CNSTI4 18
ASGNI4
line 1468
;1468:	g_arenaservers.back.generic.x			= 0;
ADDRGP4 g_arenaservers+1592+12
CNSTI4 0
ASGNI4
line 1469
;1469:	g_arenaservers.back.generic.y			= 480-64;
ADDRGP4 g_arenaservers+1592+16
CNSTI4 416
ASGNI4
line 1470
;1470:	g_arenaservers.back.width				= 128;
ADDRGP4 g_arenaservers+1592+76
CNSTI4 128
ASGNI4
line 1471
;1471:	g_arenaservers.back.height				= 64;
ADDRGP4 g_arenaservers+1592+80
CNSTI4 64
ASGNI4
line 1472
;1472:	g_arenaservers.back.focuspic			= ART_BACK1;
ADDRGP4 g_arenaservers+1592+60
ADDRGP4 $993
ASGNP4
line 1474
;1473:
;1474:	g_arenaservers.specify.generic.type	    = MTYPE_BITMAP;
ADDRGP4 g_arenaservers+1768
CNSTI4 6
ASGNI4
line 1475
;1475:	g_arenaservers.specify.generic.name		= ART_SPECIFY0;
ADDRGP4 g_arenaservers+1768+4
ADDRGP4 $997
ASGNP4
line 1476
;1476:	g_arenaservers.specify.generic.flags    = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 g_arenaservers+1768+44
CNSTU4 260
ASGNU4
line 1477
;1477:	g_arenaservers.specify.generic.callback = ArenaServers_Event;
ADDRGP4 g_arenaservers+1768+48
ADDRGP4 ArenaServers_Event
ASGNP4
line 1478
;1478:	g_arenaservers.specify.generic.id	    = ID_SPECIFY;
ADDRGP4 g_arenaservers+1768+8
CNSTI4 20
ASGNI4
line 1479
;1479:	g_arenaservers.specify.generic.x		= 128;
ADDRGP4 g_arenaservers+1768+12
CNSTI4 128
ASGNI4
line 1480
;1480:	g_arenaservers.specify.generic.y		= 480-64;
ADDRGP4 g_arenaservers+1768+16
CNSTI4 416
ASGNI4
line 1481
;1481:	g_arenaservers.specify.width  		    = 128;
ADDRGP4 g_arenaservers+1768+76
CNSTI4 128
ASGNI4
line 1482
;1482:	g_arenaservers.specify.height  		    = 64;
ADDRGP4 g_arenaservers+1768+80
CNSTI4 64
ASGNI4
line 1483
;1483:	g_arenaservers.specify.focuspic         = ART_SPECIFY1;
ADDRGP4 g_arenaservers+1768+60
ADDRGP4 $1014
ASGNP4
line 1485
;1484:
;1485:	g_arenaservers.refresh.generic.type		= MTYPE_BITMAP;
ADDRGP4 g_arenaservers+1680
CNSTI4 6
ASGNI4
line 1486
;1486:	g_arenaservers.refresh.generic.name		= ART_REFRESH0;
ADDRGP4 g_arenaservers+1680+4
ADDRGP4 $1018
ASGNP4
line 1487
;1487:	g_arenaservers.refresh.generic.flags	= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 g_arenaservers+1680+44
CNSTU4 260
ASGNU4
line 1488
;1488:	g_arenaservers.refresh.generic.callback	= ArenaServers_Event;
ADDRGP4 g_arenaservers+1680+48
ADDRGP4 ArenaServers_Event
ASGNP4
line 1489
;1489:	g_arenaservers.refresh.generic.id		= ID_REFRESH;
ADDRGP4 g_arenaservers+1680+8
CNSTI4 19
ASGNI4
line 1490
;1490:	g_arenaservers.refresh.generic.x		= 256;
ADDRGP4 g_arenaservers+1680+12
CNSTI4 256
ASGNI4
line 1491
;1491:	g_arenaservers.refresh.generic.y		= 480-64;
ADDRGP4 g_arenaservers+1680+16
CNSTI4 416
ASGNI4
line 1492
;1492:	g_arenaservers.refresh.width			= 128;
ADDRGP4 g_arenaservers+1680+76
CNSTI4 128
ASGNI4
line 1493
;1493:	g_arenaservers.refresh.height			= 64;
ADDRGP4 g_arenaservers+1680+80
CNSTI4 64
ASGNI4
line 1494
;1494:	g_arenaservers.refresh.focuspic			= ART_REFRESH1;
ADDRGP4 g_arenaservers+1680+60
ADDRGP4 $1035
ASGNP4
line 1496
;1495:
;1496:	g_arenaservers.create.generic.type		= MTYPE_BITMAP;
ADDRGP4 g_arenaservers+1856
CNSTI4 6
ASGNI4
line 1497
;1497:	g_arenaservers.create.generic.name		= ART_CREATE0;
ADDRGP4 g_arenaservers+1856+4
ADDRGP4 $1039
ASGNP4
line 1498
;1498:	g_arenaservers.create.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 g_arenaservers+1856+44
CNSTU4 260
ASGNU4
line 1499
;1499:	g_arenaservers.create.generic.callback	= ArenaServers_Event;
ADDRGP4 g_arenaservers+1856+48
ADDRGP4 ArenaServers_Event
ASGNP4
line 1500
;1500:	g_arenaservers.create.generic.id		= ID_CREATE;
ADDRGP4 g_arenaservers+1856+8
CNSTI4 21
ASGNI4
line 1501
;1501:	g_arenaservers.create.generic.x			= 384;
ADDRGP4 g_arenaservers+1856+12
CNSTI4 384
ASGNI4
line 1502
;1502:	g_arenaservers.create.generic.y			= 480-64;
ADDRGP4 g_arenaservers+1856+16
CNSTI4 416
ASGNI4
line 1503
;1503:	g_arenaservers.create.width				= 128;
ADDRGP4 g_arenaservers+1856+76
CNSTI4 128
ASGNI4
line 1504
;1504:	g_arenaservers.create.height			= 64;
ADDRGP4 g_arenaservers+1856+80
CNSTI4 64
ASGNI4
line 1505
;1505:	g_arenaservers.create.focuspic			= ART_CREATE1;
ADDRGP4 g_arenaservers+1856+60
ADDRGP4 $1056
ASGNP4
line 1507
;1506:
;1507:	g_arenaservers.go.generic.type			= MTYPE_BITMAP;
ADDRGP4 g_arenaservers+1944
CNSTI4 6
ASGNI4
line 1508
;1508:	g_arenaservers.go.generic.name			= ART_CONNECT0;
ADDRGP4 g_arenaservers+1944+4
ADDRGP4 $1060
ASGNP4
line 1509
;1509:	g_arenaservers.go.generic.flags			= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 g_arenaservers+1944+44
CNSTU4 272
ASGNU4
line 1510
;1510:	g_arenaservers.go.generic.callback		= ArenaServers_Event;
ADDRGP4 g_arenaservers+1944+48
ADDRGP4 ArenaServers_Event
ASGNP4
line 1511
;1511:	g_arenaservers.go.generic.id			= ID_CONNECT;
ADDRGP4 g_arenaservers+1944+8
CNSTI4 22
ASGNI4
line 1512
;1512:	g_arenaservers.go.generic.x				= 640;
ADDRGP4 g_arenaservers+1944+12
CNSTI4 640
ASGNI4
line 1513
;1513:	g_arenaservers.go.generic.y				= 480-64;
ADDRGP4 g_arenaservers+1944+16
CNSTI4 416
ASGNI4
line 1514
;1514:	g_arenaservers.go.width					= 128;
ADDRGP4 g_arenaservers+1944+76
CNSTI4 128
ASGNI4
line 1515
;1515:	g_arenaservers.go.height				= 64;
ADDRGP4 g_arenaservers+1944+80
CNSTI4 64
ASGNI4
line 1516
;1516:	g_arenaservers.go.focuspic				= ART_CONNECT1;
ADDRGP4 g_arenaservers+1944+60
ADDRGP4 $1077
ASGNP4
line 1536
;1517:/*
;1518:	g_arenaservers.punkbuster.generic.type			= MTYPE_SPINCONTROL;
;1519:	g_arenaservers.punkbuster.generic.name			= "Punkbuster:";
;1520:	g_arenaservers.punkbuster.generic.flags			= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
;1521:	g_arenaservers.punkbuster.generic.callback		= ArenaServers_Event;
;1522:	g_arenaservers.punkbuster.generic.id			= ID_PUNKBUSTER;
;1523:	g_arenaservers.punkbuster.generic.x				= 480+32;
;1524:	g_arenaservers.punkbuster.generic.y				= 144;
;1525:	g_arenaservers.punkbuster.itemnames				= punkbuster_items;
;1526:
;1527:	g_arenaservers.pblogo.generic.type			= MTYPE_BITMAP;
;1528:	g_arenaservers.pblogo.generic.name			= ART_PUNKBUSTER;
;1529:	g_arenaservers.pblogo.generic.flags			= QMF_LEFT_JUSTIFY|QMF_INACTIVE;
;1530:	g_arenaservers.pblogo.generic.x				= 526;
;1531:	g_arenaservers.pblogo.generic.y				= 176;
;1532:	g_arenaservers.pblogo.width					= 32;
;1533:	g_arenaservers.pblogo.height				= 16;
;1534:	g_arenaservers.pblogo.errorpic				= ART_UNKNOWNMAP;
;1535:*/
;1536:	Menu_AddItem( &g_arenaservers.menu, (void*) &g_arenaservers.banner );
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 g_arenaservers+424
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1538
;1537:
;1538:	Menu_AddItem( &g_arenaservers.menu, (void*) &g_arenaservers.master );
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 g_arenaservers+496
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1539
;1539:	Menu_AddItem( &g_arenaservers.menu, (void*) &g_arenaservers.gametype );
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 g_arenaservers+592
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1540
;1540:	Menu_AddItem( &g_arenaservers.menu, (void*) &g_arenaservers.sortkey );
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 g_arenaservers+688
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1541
;1541:	Menu_AddItem( &g_arenaservers.menu, (void*) &g_arenaservers.showfull);
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 g_arenaservers+784
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1542
;1542:	Menu_AddItem( &g_arenaservers.menu, (void*) &g_arenaservers.showempty );
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 g_arenaservers+848
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1544
;1543:
;1544:	Menu_AddItem( &g_arenaservers.menu, (void*) &g_arenaservers.mappic );
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 g_arenaservers+1008
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1545
;1545:	Menu_AddItem( &g_arenaservers.menu, (void*) &g_arenaservers.list );
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 g_arenaservers+912
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1546
;1546:	Menu_AddItem( &g_arenaservers.menu, (void*) &g_arenaservers.status );
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 g_arenaservers+1360
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1547
;1547:	Menu_AddItem( &g_arenaservers.menu, (void*) &g_arenaservers.statusbar );
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 g_arenaservers+1432
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1548
;1548:	Menu_AddItem( &g_arenaservers.menu, (void*) &g_arenaservers.arrows );
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 g_arenaservers+1096
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1549
;1549:	Menu_AddItem( &g_arenaservers.menu, (void*) &g_arenaservers.up );
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 g_arenaservers+1184
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1550
;1550:	Menu_AddItem( &g_arenaservers.menu, (void*) &g_arenaservers.down );
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 g_arenaservers+1272
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1552
;1551:
;1552:	Menu_AddItem( &g_arenaservers.menu, (void*) &g_arenaservers.remove );
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 g_arenaservers+1504
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1553
;1553:	Menu_AddItem( &g_arenaservers.menu, (void*) &g_arenaservers.back );
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 g_arenaservers+1592
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1554
;1554:	Menu_AddItem( &g_arenaservers.menu, (void*) &g_arenaservers.specify );
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 g_arenaservers+1768
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1555
;1555:	Menu_AddItem( &g_arenaservers.menu, (void*) &g_arenaservers.refresh );
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 g_arenaservers+1680
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1556
;1556:	Menu_AddItem( &g_arenaservers.menu, (void*) &g_arenaservers.create );
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 g_arenaservers+1856
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1557
;1557:	Menu_AddItem( &g_arenaservers.menu, (void*) &g_arenaservers.go );
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 g_arenaservers+1944
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1562
;1558:
;1559:	//Menu_AddItem( &g_arenaservers.menu, (void*) &g_arenaservers.punkbuster );
;1560:	//Menu_AddItem( &g_arenaservers.menu, (void*) &g_arenaservers.pblogo );
;1561:
;1562:	ArenaServers_LoadFavorites();
ADDRGP4 ArenaServers_LoadFavorites
CALLV
pop
line 1564
;1563:
;1564:	g_servertype = Com_Clamp( 0, 3, ui_browserMaster.integer );
CNSTF4 0
ARGF4
CNSTF4 1077936128
ARGF4
ADDRGP4 ui_browserMaster+12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 16
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 g_servertype
ADDRLP4 16
INDIRF4
CVFI4 4
ASGNI4
line 1566
;1565:	// hack to get rid of MPlayer stuff
;1566:	value = g_servertype;
ADDRLP4 8
ADDRGP4 g_servertype
INDIRI4
ASGNI4
line 1567
;1567:	if (value >= 1)
ADDRLP4 8
INDIRI4
CNSTI4 1
LTI4 $1098
line 1568
;1568:		value--;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $1098
line 1569
;1569:	g_arenaservers.master.curvalue = value;
ADDRGP4 g_arenaservers+496+64
ADDRLP4 8
INDIRI4
ASGNI4
line 1571
;1570:
;1571:	g_gametype = Com_Clamp( 0, 4, ui_browserGameType.integer );
CNSTF4 0
ARGF4
CNSTF4 1082130432
ARGF4
ADDRGP4 ui_browserGameType+12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 20
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 g_gametype
ADDRLP4 20
INDIRF4
CVFI4 4
ASGNI4
line 1572
;1572:	g_arenaservers.gametype.curvalue = g_gametype;
ADDRGP4 g_arenaservers+592+64
ADDRGP4 g_gametype
INDIRI4
ASGNI4
line 1574
;1573:
;1574:	g_sortkey = Com_Clamp( 0, 4, ui_browserSortKey.integer );
CNSTF4 0
ARGF4
CNSTF4 1082130432
ARGF4
ADDRGP4 ui_browserSortKey+12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 24
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 g_sortkey
ADDRLP4 24
INDIRF4
CVFI4 4
ASGNI4
line 1575
;1575:	g_arenaservers.sortkey.curvalue = g_sortkey;
ADDRGP4 g_arenaservers+688+64
ADDRGP4 g_sortkey
INDIRI4
ASGNI4
line 1577
;1576:
;1577:	g_fullservers = Com_Clamp( 0, 1, ui_browserShowFull.integer );
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 ui_browserShowFull+12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 28
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 g_fullservers
ADDRLP4 28
INDIRF4
CVFI4 4
ASGNI4
line 1578
;1578:	g_arenaservers.showfull.curvalue = g_fullservers;
ADDRGP4 g_arenaservers+784+60
ADDRGP4 g_fullservers
INDIRI4
ASGNI4
line 1580
;1579:
;1580:	g_emptyservers = Com_Clamp( 0, 1, ui_browserShowEmpty.integer );
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 ui_browserShowEmpty+12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 32
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 g_emptyservers
ADDRLP4 32
INDIRF4
CVFI4 4
ASGNI4
line 1581
;1581:	g_arenaservers.showempty.curvalue = g_emptyservers;
ADDRGP4 g_arenaservers+848+60
ADDRGP4 g_emptyservers
INDIRI4
ASGNI4
line 1583
;1582:
;1583:	g_arenaservers.punkbuster.curvalue = Com_Clamp( 0, 1, trap_Cvar_VariableValue( "cl_punkbuster" ) );
ADDRGP4 $666
ARGP4
ADDRLP4 36
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 40
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 g_arenaservers+14996+64
ADDRLP4 40
INDIRF4
CVFI4 4
ASGNI4
line 1586
;1584:
;1585:	// force to initial state and refresh
;1586:	type = g_servertype;
ADDRLP4 12
ADDRGP4 g_servertype
INDIRI4
ASGNI4
line 1587
;1587:	g_servertype = -1;
ADDRGP4 g_servertype
CNSTI4 -1
ASGNI4
line 1588
;1588:	ArenaServers_SetType( type );
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 ArenaServers_SetType
CALLV
pop
line 1590
;1589:
;1590:	trap_Cvar_Register(NULL, "debug_protocol", "", 0 );
CNSTP4 0
ARGP4
ADDRGP4 $599
ARGP4
ADDRGP4 $231
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1591
;1591:}
LABELV $744
endproc ArenaServers_MenuInit 44 16
export ArenaServers_Cache
proc ArenaServers_Cache 0 4
line 1599
;1592:
;1593:
;1594:/*
;1595:=================
;1596:ArenaServers_Cache
;1597:=================
;1598:*/
;1599:void ArenaServers_Cache( void ) {
line 1600
;1600:	trap_R_RegisterShaderNoMip( ART_BACK0 );
ADDRGP4 $976
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1601
;1601:	trap_R_RegisterShaderNoMip( ART_BACK1 );
ADDRGP4 $993
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1602
;1602:	trap_R_RegisterShaderNoMip( ART_CREATE0 );
ADDRGP4 $1039
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1603
;1603:	trap_R_RegisterShaderNoMip( ART_CREATE1 );
ADDRGP4 $1056
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1604
;1604:	trap_R_RegisterShaderNoMip( ART_SPECIFY0 );
ADDRGP4 $997
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1605
;1605:	trap_R_RegisterShaderNoMip( ART_SPECIFY1 );
ADDRGP4 $1014
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1606
;1606:	trap_R_RegisterShaderNoMip( ART_REFRESH0 );
ADDRGP4 $1018
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1607
;1607:	trap_R_RegisterShaderNoMip( ART_REFRESH1 );
ADDRGP4 $1035
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1608
;1608:	trap_R_RegisterShaderNoMip( ART_CONNECT0 );
ADDRGP4 $1060
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1609
;1609:	trap_R_RegisterShaderNoMip( ART_CONNECT1 );
ADDRGP4 $1077
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1610
;1610:	trap_R_RegisterShaderNoMip( ART_ARROWS0  );
ADDRGP4 $881
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1611
;1611:	trap_R_RegisterShaderNoMip( ART_ARROWS_UP );
ADDRGP4 $911
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1612
;1612:	trap_R_RegisterShaderNoMip( ART_ARROWS_DOWN );
ADDRGP4 $929
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1613
;1613:	trap_R_RegisterShaderNoMip( ART_UNKNOWNMAP );
ADDRGP4 $877
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1615
;1614://	trap_R_RegisterShaderNoMip( ART_PUNKBUSTER );
;1615:}
LABELV $1116
endproc ArenaServers_Cache 0 4
export UI_ArenaServersMenu
proc UI_ArenaServersMenu 0 4
line 1623
;1616:
;1617:
;1618:/*
;1619:=================
;1620:UI_ArenaServersMenu
;1621:=================
;1622:*/
;1623:void UI_ArenaServersMenu( void ) {
line 1624
;1624:	ArenaServers_MenuInit();
ADDRGP4 ArenaServers_MenuInit
CALLV
pop
line 1625
;1625:	UI_PushMenu( &g_arenaservers.menu );
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 UI_PushMenu
CALLV
pop
line 1626
;1626:}
LABELV $1117
endproc UI_ArenaServersMenu 0 4
bss
align 4
LABELV g_fullservers
skip 4
align 4
LABELV g_emptyservers
skip 4
align 4
LABELV g_sortkey
skip 4
align 4
LABELV g_gametype
skip 4
align 4
LABELV g_servertype
skip 4
align 4
LABELV g_nummplayerservers
skip 4
align 4
LABELV g_mplayerserverlist
skip 19456
align 4
LABELV g_numfavoriteservers
skip 4
align 4
LABELV g_favoriteserverlist
skip 2432
align 4
LABELV g_numlocalservers
skip 4
align 4
LABELV g_localserverlist
skip 19456
align 4
LABELV g_numglobalservers
skip 4
align 4
LABELV g_globalserverlist
skip 19456
align 4
LABELV g_arenaservers
skip 15180
import UI_RankStatusMenu
import RankStatus_Cache
import UI_SignupMenu
import Signup_Cache
import UI_LoginMenu
import Login_Cache
import UI_RankingsMenu
import Rankings_Cache
import Rankings_DrawPassword
import Rankings_DrawName
import Rankings_DrawText
import UI_InitGameinfo
import UI_SPUnlockMedals_f
import UI_SPUnlock_f
import UI_GetAwardLevel
import UI_LogAwardData
import UI_NewGame
import UI_GetCurrentGame
import UI_CanShowTierVideo
import UI_ShowTierVideo
import UI_TierCompleted
import UI_SetBestScore
import UI_GetBestScore
import UI_GetNumBots
import UI_GetBotInfoByName
import UI_GetBotInfoByNumber
import UI_GetNumSPTiers
import UI_GetNumSPArenas
import UI_GetNumArenas
import UI_GetSpecialArenaInfo
import UI_GetArenaInfoByMap
import UI_GetArenaInfoByNumber
import UI_NetworkOptionsMenu
import UI_NetworkOptionsMenu_Cache
import UI_SoundOptionsMenu
import UI_SoundOptionsMenu_Cache
import UI_DisplayOptionsMenu
import UI_DisplayOptionsMenu_Cache
import UI_SaveConfigMenu
import UI_SaveConfigMenu_Cache
import UI_LoadConfigMenu
import UI_LoadConfig_Cache
import UI_TeamOrdersMenu_Cache
import UI_TeamOrdersMenu_f
import UI_TeamOrdersMenu
import UI_RemoveBotsMenu
import UI_RemoveBots_Cache
import UI_AddBotsMenu
import UI_AddBots_Cache
import trap_SetPbClStatus
import trap_VerifyCDKey
import trap_SetCDKey
import trap_GetCDKey
import trap_MemoryRemaining
import trap_LAN_GetPingInfo
import trap_LAN_GetPing
import trap_LAN_ClearPing
import trap_LAN_ServerStatus
import trap_LAN_GetPingQueueCount
import trap_LAN_GetServerInfo
import trap_LAN_GetServerAddressString
import trap_LAN_GetServerCount
import trap_GetConfigString
import trap_GetGlconfig
import trap_GetClientState
import trap_GetClipboardData
import trap_Key_SetCatcher
import trap_Key_GetCatcher
import trap_Key_ClearStates
import trap_Key_SetOverstrikeMode
import trap_Key_GetOverstrikeMode
import trap_Key_IsDown
import trap_Key_SetBinding
import trap_Key_GetBindingBuf
import trap_Key_KeynumToStringBuf
import trap_S_StartBackgroundTrack
import trap_S_StopBackgroundTrack
import trap_S_RegisterSound
import trap_S_StartLocalSound
import trap_CM_LerpTag
import trap_UpdateScreen
import trap_R_DrawStretchPic
import trap_R_SetColor
import trap_R_RenderScene
import trap_R_AddLightToScene
import trap_R_AddPolyToScene
import trap_R_AddRefEntityToScene
import trap_R_ClearScene
import trap_R_RegisterShaderNoMip
import trap_R_RegisterSkin
import trap_R_RegisterModel
import trap_FS_Seek
import trap_FS_GetFileList
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_FS_FOpenFile
import trap_Cmd_ExecuteText
import trap_Argv
import trap_Argc
import trap_Cvar_InfoStringBuffer
import trap_Cvar_Create
import trap_Cvar_Reset
import trap_Cvar_SetValue
import trap_Cvar_VariableStringBuffer
import trap_Cvar_VariableValue
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_Milliseconds
import trap_Error
import trap_Print
import UI_SPSkillMenu_Cache
import UI_SPSkillMenu
import UI_SPPostgameMenu_f
import UI_SPPostgameMenu_Cache
import UI_SPArena_Start
import UI_SPLevelMenu_ReInit
import UI_SPLevelMenu_f
import UI_SPLevelMenu
import UI_SPLevelMenu_Cache
import uis
import m_entersound
import UI_StartDemoLoop
import UI_DrawBackPic
import UI_Cvar_VariableString
import UI_Argv
import UI_ForceMenuOff
import UI_PopMenu
import UI_PushMenu
import UI_SetActiveMenu
import UI_IsFullscreen
import UI_DrawTextBox
import UI_AdjustFrom640
import UI_CursorInRect
import UI_DrawChar
import UI_DrawString
import UI_DrawStrlen
import UI_ProportionalStringWidth
import UI_DrawProportionalString_AutoWrapped
import UI_DrawProportionalString
import UI_ProportionalSizeScale
import UI_DrawBannerString
import UI_LerpColor
import UI_SetColor
import UI_UpdateScreen
import UI_DrawRect
import UI_FillRect
import UI_DrawHandlePic
import UI_DrawNamedPic
import UI_ClampCvar
import UI_ConsoleCommand
import UI_Refresh
import UI_MouseEvent
import UI_KeyEvent
import UI_Shutdown
import UI_Init
import UI_RegisterClientModelname
import UI_PlayerInfo_SetInfo
import UI_PlayerInfo_SetModel
import UI_DrawPlayer
import DriverInfo_Cache
import GraphicsOptions_Cache
import UI_GraphicsOptionsMenu
import ServerInfo_Cache
import UI_ServerInfoMenu
import UI_GTS_Menu
import UI_TemplateList_Complete
import UI_TemplateList_SvTemplate
import UI_TemplateMenu
import UI_BotSelectMenu_Cache
import UI_BotSelectMenu
import ServerOptions_Cache
import StartServer_Cache
import UI_StartServerMenu
import SpecifyServer_Cache
import UI_SpecifyServerMenu
import SpecifyLeague_Cache
import UI_SpecifyLeagueMenu
import Preferences_Cache
import UI_PreferencesMenu
import PlayerSettings_Cache
import UI_PlayerSettingsMenu
import PlayerModel_Cache
import UI_PlayerModelMenu
import UI_CDKeyMenu_f
import UI_CDKeyMenu_Cache
import UI_CDKeyMenu
import UI_ModsMenu_Cache
import UI_ModsMenu
import UI_CinematicsMenu_Cache
import UI_CinematicsMenu_f
import UI_CinematicsMenu
import Demos_Cache
import UI_DemosMenu
import Controls_Cache
import UI_ControlsMenu
import UI_DrawConnectScreen
import TeamMain_Cache
import UI_TeamMainMenu
import UI_SetupMenu
import UI_SetupMenu_Cache
import UI_Message
import UI_ConfirmMenu_Style
import UI_ConfirmMenu
import ConfirmMenu_Cache
import UI_InGameMenu
import InGame_Cache
import UI_Hunt_Credits
import UI_CreditMenu
import UI_UpdateCvars
import UI_RegisterCvars
import UI_MainMenu
import MainMenu_Cache
import MenuField_Key
import MenuField_Draw
import MenuField_Init
import MField_Draw
import MField_CharEvent
import MField_KeyDownEvent
import MField_Clear
import ui_medalSounds
import ui_medalPicNames
import ui_medalNames
import text_color_highlight
import text_color_normal
import text_color_disabled
import listbar_color
import list_color
import name_color
import color_dim
import color_red
import color_orange
import color_blue
import color_yellow
import color_white
import color_black
import menu_dim_color
import menu_black_color
import menu_red_color
import menu_highlight_color
import menu_dark_color
import menu_grayed_color
import menu_text_color
import weaponChangeSound
import menu_null_sound
import menu_buzz_sound
import menu_out_sound
import menu_move_sound
import menu_in_sound
import ScrollList_Key
import ScrollList_Draw
import Bitmap_Draw
import Bitmap_Init
import Menu_DefaultKey
import Menu_SetCursorToItem
import Menu_SetCursor
import Menu_ActivateItem
import Menu_ItemAtCursor
import Menu_Draw
import Menu_AdjustCursor
import Menu_AddItem
import Menu_Focus
import Menu_Cache
import ui_cdkeychecked
import ui_cdkey
import ui_server16
import ui_server15
import ui_server14
import ui_server13
import ui_server12
import ui_server11
import ui_server10
import ui_server9
import ui_server8
import ui_server7
import ui_server6
import ui_server5
import ui_server4
import ui_server3
import ui_server2
import ui_server1
import ui_hiDetailTitle
import ui_lensFlare
import ui_marks
import ui_drawCrosshairNames
import ui_drawCrosshair
import ui_brassTime
import ui_browserShowEmpty
import ui_browserShowFull
import ui_browserSortKey
import ui_browserGameType
import ui_browserMaster
import ui_spSelection
import ui_spSkill
import ui_spVideos
import ui_spAwards
import ui_spScores5
import ui_spScores4
import ui_spScores3
import ui_spScores2
import ui_spScores1
import ui_botsFile
import ui_arenasFile
import ui_ctf_friendly
import ui_ctf_timelimit
import ui_ctf_capturelimit
import ui_team_friendly
import ui_team_timelimit
import ui_team_fraglimit
import ui_tourney_timelimit
import ui_tourney_fraglimit
import ui_ffa_timelimit
import ui_ffa_fraglimit
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
LABELV $1077
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 102
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 95
byte 1 49
byte 1 0
align 1
LABELV $1060
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 102
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 95
byte 1 48
byte 1 0
align 1
LABELV $1056
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 99
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 101
byte 1 95
byte 1 49
byte 1 0
align 1
LABELV $1039
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 99
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 101
byte 1 95
byte 1 48
byte 1 0
align 1
LABELV $1035
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 114
byte 1 101
byte 1 102
byte 1 114
byte 1 101
byte 1 115
byte 1 104
byte 1 95
byte 1 49
byte 1 0
align 1
LABELV $1018
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 114
byte 1 101
byte 1 102
byte 1 114
byte 1 101
byte 1 115
byte 1 104
byte 1 95
byte 1 48
byte 1 0
align 1
LABELV $1014
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 105
byte 1 102
byte 1 121
byte 1 95
byte 1 49
byte 1 0
align 1
LABELV $997
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 105
byte 1 102
byte 1 121
byte 1 95
byte 1 48
byte 1 0
align 1
LABELV $993
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 95
byte 1 49
byte 1 0
align 1
LABELV $976
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 95
byte 1 48
byte 1 0
align 1
LABELV $972
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 100
byte 1 101
byte 1 108
byte 1 101
byte 1 116
byte 1 101
byte 1 95
byte 1 49
byte 1 0
align 1
LABELV $955
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 100
byte 1 101
byte 1 108
byte 1 101
byte 1 116
byte 1 101
byte 1 95
byte 1 48
byte 1 0
align 1
LABELV $929
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 97
byte 1 114
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 95
byte 1 118
byte 1 101
byte 1 114
byte 1 116
byte 1 95
byte 1 98
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $911
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 97
byte 1 114
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 95
byte 1 118
byte 1 101
byte 1 114
byte 1 116
byte 1 95
byte 1 116
byte 1 111
byte 1 112
byte 1 0
align 1
LABELV $881
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 97
byte 1 114
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 95
byte 1 118
byte 1 101
byte 1 114
byte 1 116
byte 1 95
byte 1 48
byte 1 0
align 1
LABELV $877
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $829
byte 1 83
byte 1 104
byte 1 111
byte 1 119
byte 1 32
byte 1 69
byte 1 109
byte 1 112
byte 1 116
byte 1 121
byte 1 58
byte 1 0
align 1
LABELV $815
byte 1 83
byte 1 104
byte 1 111
byte 1 119
byte 1 32
byte 1 70
byte 1 117
byte 1 108
byte 1 108
byte 1 58
byte 1 0
align 1
LABELV $799
byte 1 83
byte 1 111
byte 1 114
byte 1 116
byte 1 32
byte 1 66
byte 1 121
byte 1 58
byte 1 0
align 1
LABELV $783
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 84
byte 1 121
byte 1 112
byte 1 101
byte 1 58
byte 1 0
align 1
LABELV $767
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 58
byte 1 0
align 1
LABELV $759
byte 1 65
byte 1 82
byte 1 69
byte 1 78
byte 1 65
byte 1 32
byte 1 83
byte 1 69
byte 1 82
byte 1 86
byte 1 69
byte 1 82
byte 1 83
byte 1 0
align 1
LABELV $726
byte 1 68
byte 1 105
byte 1 115
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 80
byte 1 117
byte 1 110
byte 1 107
byte 1 98
byte 1 117
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 63
byte 1 0
align 1
LABELV $725
byte 1 69
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 80
byte 1 117
byte 1 110
byte 1 107
byte 1 98
byte 1 117
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 63
byte 1 0
align 1
LABELV $702
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 101
byte 1 114
byte 1 83
byte 1 104
byte 1 111
byte 1 119
byte 1 69
byte 1 109
byte 1 112
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $696
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 101
byte 1 114
byte 1 83
byte 1 104
byte 1 111
byte 1 119
byte 1 70
byte 1 117
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $690
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 101
byte 1 114
byte 1 83
byte 1 111
byte 1 114
byte 1 116
byte 1 75
byte 1 101
byte 1 121
byte 1 0
align 1
LABELV $684
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 101
byte 1 114
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 84
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $682
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 101
byte 1 114
byte 1 77
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $666
byte 1 99
byte 1 108
byte 1 95
byte 1 112
byte 1 117
byte 1 110
byte 1 107
byte 1 98
byte 1 117
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $660
byte 1 104
byte 1 105
byte 1 116
byte 1 32
byte 1 114
byte 1 101
byte 1 102
byte 1 114
byte 1 101
byte 1 115
byte 1 104
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 117
byte 1 112
byte 1 100
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $604
byte 1 112
byte 1 114
byte 1 111
byte 1 116
byte 1 111
byte 1 99
byte 1 111
byte 1 108
byte 1 0
align 1
LABELV $603
byte 1 103
byte 1 108
byte 1 111
byte 1 98
byte 1 97
byte 1 108
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $602
byte 1 103
byte 1 108
byte 1 111
byte 1 98
byte 1 97
byte 1 108
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $599
byte 1 100
byte 1 101
byte 1 98
byte 1 117
byte 1 103
byte 1 95
byte 1 112
byte 1 114
byte 1 111
byte 1 116
byte 1 111
byte 1 99
byte 1 111
byte 1 108
byte 1 0
align 1
LABELV $598
byte 1 32
byte 1 102
byte 1 117
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $595
byte 1 32
byte 1 101
byte 1 109
byte 1 112
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $591
byte 1 32
byte 1 99
byte 1 116
byte 1 102
byte 1 0
align 1
LABELV $589
byte 1 32
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 0
align 1
LABELV $587
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $585
byte 1 32
byte 1 102
byte 1 102
byte 1 97
byte 1 0
align 1
LABELV $573
byte 1 108
byte 1 111
byte 1 99
byte 1 97
byte 1 108
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $551
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
LABELV $441
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $420
byte 1 78
byte 1 111
byte 1 32
byte 1 82
byte 1 101
byte 1 115
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $412
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
LABELV $411
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $410
byte 1 110
byte 1 101
byte 1 116
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $409
byte 1 112
byte 1 117
byte 1 110
byte 1 107
byte 1 98
byte 1 117
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $408
byte 1 109
byte 1 97
byte 1 120
byte 1 80
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $407
byte 1 109
byte 1 105
byte 1 110
byte 1 80
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $406
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
LABELV $405
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $404
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $403
byte 1 104
byte 1 111
byte 1 115
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $339
byte 1 78
byte 1 111
byte 1 0
align 1
LABELV $338
byte 1 89
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $337
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 46
byte 1 50
byte 1 48
byte 1 115
byte 1 32
byte 1 37
byte 1 45
byte 1 49
byte 1 50
byte 1 46
byte 1 49
byte 1 50
byte 1 115
byte 1 32
byte 1 37
byte 1 50
byte 1 100
byte 1 47
byte 1 37
byte 1 50
byte 1 100
byte 1 32
byte 1 37
byte 1 45
byte 1 56
byte 1 46
byte 1 56
byte 1 115
byte 1 32
byte 1 37
byte 1 51
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 37
byte 1 51
byte 1 100
byte 1 32
byte 1 94
byte 1 51
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $336
byte 1 94
byte 1 49
byte 1 0
align 1
LABELV $335
byte 1 94
byte 1 51
byte 1 0
align 1
LABELV $332
byte 1 94
byte 1 50
byte 1 0
align 1
LABELV $327
byte 1 94
byte 1 52
byte 1 0
align 1
LABELV $266
byte 1 78
byte 1 111
byte 1 32
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 70
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 46
byte 1 0
align 1
LABELV $263
byte 1 78
byte 1 111
byte 1 32
byte 1 82
byte 1 101
byte 1 115
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 101
byte 1 32
byte 1 70
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 77
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 46
byte 1 0
align 1
LABELV $237
byte 1 83
byte 1 99
byte 1 97
byte 1 110
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 70
byte 1 111
byte 1 114
byte 1 32
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 46
byte 1 0
align 1
LABELV $231
byte 1 0
align 1
LABELV $203
byte 1 80
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 32
byte 1 83
byte 1 80
byte 1 65
byte 1 67
byte 1 69
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 115
byte 1 116
byte 1 111
byte 1 112
byte 1 0
align 1
LABELV $198
byte 1 37
byte 1 100
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 65
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 32
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 46
byte 1 0
align 1
LABELV $182
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $169
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $134
byte 1 99
byte 1 108
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 80
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $129
byte 1 105
byte 1 115
byte 1 32
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 101
byte 1 100
byte 1 46
byte 1 0
align 1
LABELV $128
byte 1 81
byte 1 117
byte 1 97
byte 1 107
byte 1 101
byte 1 32
byte 1 73
byte 1 73
byte 1 73
byte 1 32
byte 1 65
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 0
align 1
LABELV $127
byte 1 100
byte 1 105
byte 1 115
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $126
byte 1 80
byte 1 117
byte 1 110
byte 1 107
byte 1 66
byte 1 117
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 119
byte 1 105
byte 1 108
byte 1 108
byte 1 32
byte 1 98
byte 1 101
byte 1 0
align 1
LABELV $125
byte 1 69
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $124
byte 1 68
byte 1 105
byte 1 115
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $123
byte 1 73
byte 1 80
byte 1 88
byte 1 0
align 1
LABELV $122
byte 1 85
byte 1 68
byte 1 80
byte 1 0
align 1
LABELV $121
byte 1 63
byte 1 63
byte 1 63
byte 1 0
align 1
LABELV $120
byte 1 79
byte 1 83
byte 1 80
byte 1 0
align 1
LABELV $119
byte 1 85
byte 1 114
byte 1 98
byte 1 97
byte 1 110
byte 1 32
byte 1 84
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $118
byte 1 81
byte 1 51
byte 1 70
byte 1 0
align 1
LABELV $117
byte 1 82
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 32
byte 1 65
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 32
byte 1 51
byte 1 0
align 1
LABELV $116
byte 1 72
byte 1 97
byte 1 114
byte 1 118
byte 1 101
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $115
byte 1 79
byte 1 118
byte 1 101
byte 1 114
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $114
byte 1 79
byte 1 110
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 67
byte 1 84
byte 1 70
byte 1 0
align 1
LABELV $113
byte 1 67
byte 1 84
byte 1 70
byte 1 0
align 1
LABELV $112
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 68
byte 1 77
byte 1 0
align 1
LABELV $111
byte 1 83
byte 1 80
byte 1 32
byte 1 0
align 1
LABELV $110
byte 1 49
byte 1 118
byte 1 49
byte 1 0
align 1
LABELV $109
byte 1 68
byte 1 77
byte 1 32
byte 1 0
align 1
LABELV $108
byte 1 80
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $107
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 84
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $106
byte 1 79
byte 1 112
byte 1 101
byte 1 110
byte 1 32
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 83
byte 1 112
byte 1 111
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $105
byte 1 77
byte 1 97
byte 1 112
byte 1 32
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $104
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $103
byte 1 67
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $102
byte 1 84
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $101
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 68
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $100
byte 1 70
byte 1 114
byte 1 101
byte 1 101
byte 1 32
byte 1 70
byte 1 111
byte 1 114
byte 1 32
byte 1 65
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $99
byte 1 65
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $98
byte 1 70
byte 1 97
byte 1 118
byte 1 111
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $97
byte 1 73
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 110
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $96
byte 1 76
byte 1 111
byte 1 99
byte 1 97
byte 1 108
byte 1 0
