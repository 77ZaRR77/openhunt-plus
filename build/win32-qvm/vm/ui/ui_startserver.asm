data
align 4
LABELV gametype_names
address $97
address $98
address $99
address $100
address $101
address $99
address $99
address $99
address $102
address $103
code
proc ClearTemplate 0 12
file "..\..\..\..\code\q3_ui\ui_startserver.c"
line 149
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:/*
;4:=============================================================================
;5:
;6:START SERVER MENU *****
;7:
;8:=============================================================================
;9:*/
;10:
;11:
;12:#include "ui_local.h"
;13:
;14:
;15:#define GAMESERVER_BACK0		"menu/art/back_0"
;16:#define GAMESERVER_BACK1		"menu/art/back_1"
;17:#define GAMESERVER_NEXT0		"menu/art/next_0"
;18:#define GAMESERVER_NEXT1		"menu/art/next_1"
;19:#if 0	// JUHOX: no frame for map selector
;20:#define GAMESERVER_FRAMEL		"menu/art/frame2_l"
;21:#define GAMESERVER_FRAMER		"menu/art/frame1_r"
;22:#endif
;23:#define GAMESERVER_SELECT		"menu/art/maps_select"
;24:#define GAMESERVER_SELECTED		"menu/art/maps_selected"
;25:#define GAMESERVER_FIGHT0		"menu/art/fight_0"
;26:#define GAMESERVER_FIGHT1		"menu/art/fight_1"
;27:#define GAMESERVER_UNKNOWNMAP	"menu/art/unknownmap"
;28:#define GAMESERVER_ARROWS		"menu/art/gs_arrows_0"
;29:#define GAMESERVER_ARROWSL		"menu/art/gs_arrows_l"
;30:#define GAMESERVER_ARROWSR		"menu/art/gs_arrows_r"
;31:
;32:#if 0	// JUHOX: more maps per page
;33:#define MAX_MAPROWS		2
;34:#define MAX_MAPCOLS		2
;35:#define MAX_MAPSPERPAGE	4
;36:#else
;37:#define MAX_MAPROWS		2
;38:#define MAX_MAPCOLS		4
;39:#define MAX_MAPSPERPAGE 8
;40:#endif
;41:
;42:#define	MAX_SERVERSTEXT	8192
;43:
;44:#define MAX_SERVERMAPS	256	// JUHOX: was 64
;45:#define MAX_NAMELENGTH	16
;46:
;47:#define ID_GAMETYPE				10
;48:#define ID_PICTURES				11	// 12, 13, 14
;49:#define ID_PREVPAGE				15
;50:#define ID_NEXTPAGE				16
;51:#define ID_STARTSERVERBACK		17
;52:#define ID_STARTSERVERNEXT		18
;53:
;54:typedef struct {
;55:	menuframework_s	menu;
;56:
;57:	menutext_s		banner;
;58:#if 0	// JUHOX: no frame for map selector
;59:	menubitmap_s	framel;
;60:	menubitmap_s	framer;
;61:#endif
;62:
;63:#if 0	// JUHOX: game type selection menu instead of spin control
;64:	menulist_s		gametype;
;65:#else
;66:	int				gametype;
;67:	menutext_s		gametitle;
;68:	char			gamename[32];
;69:#endif
;70:	menubitmap_s	mappics[MAX_MAPSPERPAGE];
;71:	menubitmap_s	mapbuttons[MAX_MAPSPERPAGE];
;72:	menubitmap_s	arrows;
;73:	menubitmap_s	prevpage;
;74:	menubitmap_s	nextpage;
;75:	menubitmap_s	back;
;76:	menubitmap_s	next;
;77:
;78:	menutext_s		mapname;
;79:	menubitmap_s	item_null;
;80:
;81:	qboolean		multiplayer;
;82:	int				currentmap;
;83:	int				nummaps;
;84:	int				page;
;85:	int				maxpages;
;86:	char			maplist[MAX_SERVERMAPS][MAX_NAMELENGTH];
;87:	int				mapGamebits[MAX_SERVERMAPS];
;88:
;89:	char			choosenmap[MAX_NAMELENGTH];		// JUHOX: original name
;90:	char			choosenmapname[MAX_NAMELENGTH];	// JUHOX: upper case name
;91:} startserver_t;
;92:
;93:static startserver_t s_startserver;
;94:static int initialGameType;	// JUHOX
;95:
;96:#if 0	// JUHOX: game type selection menu instead of spin control
;97:static const char *gametype_items[] = {
;98:	"Free For All",
;99:	"Team Deathmatch",
;100:	"Tournament",
;101:	"Capture the Flag",
;102:#if MONSTER_MODE	// JUHOX: STU name
;103:	"Save the Universe",
;104:#endif
;105:#if ESCAPE_MODE	// JUHOX: EFH name
;106:	"Escape from Hell",
;107:#endif
;108:	0
;109:};
;110:#endif
;111:
;112:#if 0	// JUHOX: game type selection menu instead of spin control
;113:static int gametype_remap[] = {GT_FFA, GT_TEAM, GT_TOURNAMENT, GT_CTF};
;114:static int gametype_remap2[] = {0, 2, 0, 1, 3};
;115:#else
;116:static const char* gametype_names[] = {
;117:	"Free For All",
;118:	"Tournament",
;119:	"",	// single player
;120:	"Team Deathmatch",
;121:	"Capture the Flag",
;122:	"",	// 1FCTF
;123:	"",	// Obelisk
;124:	"",	// Harvester
;125:#if MONSTER_MODE
;126:	"Save the Universe",
;127:#if ESCAPE_MODE
;128:	"Escape From Hell"
;129:#endif
;130:#endif
;131:};
;132:#endif
;133:
;134:// use ui_servers2.c definition
;135:extern const char* punkbuster_items[];
;136:
;137:static void UI_ServerOptionsMenu( qboolean multiplayer );
;138:
;139:#if 1	// JUHOX: template variables
;140:gametemplate_t gtmpl;
;141:#endif
;142:
;143:
;144:/*
;145:=================
;146:JUHOX: ClearTemplate
;147:=================
;148:*/
;149:static void ClearTemplate(void) {
line 150
;150:	memset(&gtmpl, 0, sizeof(gtmpl));
ADDRGP4 gtmpl
ARGP4
CNSTI4 0
ARGI4
CNSTI4 512
ARGI4
ADDRGP4 memset
CALLP4
pop
line 151
;151:	trap_Cvar_Set("g_template", "");
ADDRGP4 $105
ARGP4
ADDRGP4 $99
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 152
;152:}
LABELV $104
endproc ClearTemplate 0 12
proc GametypeBits 44 8
line 159
;153:
;154:/*
;155:=================
;156:GametypeBits
;157:=================
;158:*/
;159:static int GametypeBits( char *string ) {
line 164
;160:	int		bits;
;161:	char	*p;
;162:	char	*token;
;163:
;164:	bits = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 165
;165:	p = string;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $108
JUMPV
LABELV $107
line 166
;166:	while( 1 ) {
line 167
;167:		token = COM_ParseExt( &p, qfalse );
ADDRLP4 8
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 12
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 12
INDIRP4
ASGNP4
line 168
;168:		if( token[0] == 0 ) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $110
line 169
;169:			break;
ADDRGP4 $109
JUMPV
LABELV $110
line 172
;170:		}
;171:
;172:		if( Q_stricmp( token, "ffa" ) == 0 ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $114
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $112
line 173
;173:			bits |= 1 << GT_FFA;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 175
;174:#if 1	// JUHOX: accept ffa maps for other gametypes too
;175:			bits |= 1 << GT_TOURNAMENT;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 176
;176:			bits |= 1 << GT_TEAM;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 178
;177:#if MONSTER_MODE
;178:			bits |= 1 << GT_STU;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 181
;179:#endif
;180:#endif
;181:			continue;
ADDRGP4 $108
JUMPV
LABELV $112
line 184
;182:		}
;183:
;184:		if( Q_stricmp( token, "tourney" ) == 0 ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $117
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $115
line 185
;185:			bits |= 1 << GT_TOURNAMENT;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 187
;186:#if 1	// JUHOX: accept tourney maps for other gametypes too
;187:			bits |= 1 << GT_FFA;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 188
;188:			bits |= 1 << GT_TEAM;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 190
;189:#if MONSTER_MODE
;190:			bits |= 1 << GT_STU;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 193
;191:#endif
;192:#endif
;193:			continue;
ADDRGP4 $108
JUMPV
LABELV $115
line 196
;194:		}
;195:
;196:		if( Q_stricmp( token, "single" ) == 0 ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $120
ARGP4
ADDRLP4 24
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $118
line 197
;197:			bits |= 1 << GT_SINGLE_PLAYER;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 4
BORI4
ASGNI4
line 198
;198:			continue;
ADDRGP4 $108
JUMPV
LABELV $118
line 201
;199:		}
;200:
;201:		if( Q_stricmp( token, "team" ) == 0 ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $123
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $121
line 202
;202:			bits |= 1 << GT_TEAM;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 204
;203:#if 1	// JUHOX: accept tdm maps for other gametypes too
;204:			bits |= 1 << GT_FFA;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 205
;205:			bits |= 1 << GT_TOURNAMENT;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 207
;206:#if MONSTER_MODE
;207:			bits |= 1 << GT_STU;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 210
;208:#endif
;209:#endif
;210:			continue;
ADDRGP4 $108
JUMPV
LABELV $121
line 213
;211:		}
;212:
;213:		if( Q_stricmp( token, "ctf" ) == 0 ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $126
ARGP4
ADDRLP4 32
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $124
line 214
;214:			bits |= 1 << GT_CTF;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 216
;215:#if 1	// JUHOX: accept ctf maps for other gametypes too
;216:			bits |= 1 << GT_FFA;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 217
;217:			bits |= 1 << GT_TOURNAMENT;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 218
;218:			bits |= 1 << GT_TEAM;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 220
;219:#if MONSTER_MODE
;220:			bits |= 1 << GT_STU;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 223
;221:#endif
;222:#endif
;223:			continue;
ADDRGP4 $108
JUMPV
LABELV $124
line 226
;224:		}
;225:#if MONSTER_MODE	// JUHOX: check for STU map
;226:		if (Q_stricmp(token, "stu") == 0) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $129
ARGP4
ADDRLP4 36
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $127
line 227
;227:			bits |= 1 << GT_STU;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 228
;228:			continue;
ADDRGP4 $108
JUMPV
LABELV $127
line 232
;229:		}
;230:#endif
;231:#if ESCAPE_MODE	// JUHOX: check for EFH map
;232:		if (Q_stricmp(token, "efh") == 0) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $132
ARGP4
ADDRLP4 40
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $130
line 233
;233:			bits |= 1 << GT_EFH;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 512
BORI4
ASGNI4
line 234
;234:			continue;
LABELV $130
line 237
;235:		}
;236:#endif
;237:	}
LABELV $108
line 166
ADDRGP4 $107
JUMPV
LABELV $109
line 239
;238:
;239:	return bits;
ADDRLP4 0
INDIRI4
RETI4
LABELV $106
endproc GametypeBits 44 8
bss
align 1
LABELV $134
skip 512
code
proc StartServer_Update 28 16
line 248
;240:}
;241:
;242:
;243:/*
;244:=================
;245:StartServer_Update
;246:=================
;247:*/
;248:static void StartServer_Update( void ) {
line 253
;249:	int				i;
;250:	int				top;
;251:	static	char	picname[MAX_MAPSPERPAGE][64];
;252:
;253:	top = s_startserver.page*MAX_MAPSPERPAGE;
ADDRLP4 4
ADDRGP4 s_startserver+2624
INDIRI4
CNSTI4 3
LSHI4
ASGNI4
line 255
;254:
;255:	for (i=0; i<MAX_MAPSPERPAGE; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $136
line 256
;256:	{
line 257
;257:		if (top+i >= s_startserver.nummaps)
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ADDRGP4 s_startserver+2620
INDIRI4
LTI4 $140
line 258
;258:			break;
ADDRGP4 $158
JUMPV
LABELV $140
line 260
;259:
;260:		Com_sprintf( picname[i], sizeof(picname[i]), "levelshots/%s", s_startserver.maplist[top+i] );
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 $134
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $143
ARGP4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
CNSTI4 4
LSHI4
ADDRGP4 s_startserver+2632
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 262
;261:
;262:		s_startserver.mappics[i].generic.flags &= ~QMF_HIGHLIGHT;
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_startserver+604+44
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRU4
CNSTU4 4294967231
BANDU4
ASGNU4
line 263
;263:		s_startserver.mappics[i].generic.name   = picname[i];
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_startserver+604+4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 $134
ADDP4
ASGNP4
line 264
;264:		s_startserver.mappics[i].shader         = 0;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_startserver+604+68
ADDP4
CNSTI4 0
ASGNI4
line 267
;265:
;266:		// reset
;267:		s_startserver.mapbuttons[i].generic.flags |= QMF_PULSEIFFOCUS;
ADDRLP4 20
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_startserver+1308+44
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRU4
CNSTU4 256
BORU4
ASGNU4
line 268
;268:		s_startserver.mapbuttons[i].generic.flags &= ~QMF_INACTIVE;
ADDRLP4 24
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_startserver+1308+44
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRU4
CNSTU4 4294950911
BANDU4
ASGNU4
line 269
;269:	}
LABELV $137
line 255
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 8
LTI4 $136
line 271
;270:
;271:	for (; i<MAX_MAPSPERPAGE; i++)
ADDRGP4 $158
JUMPV
LABELV $155
line 272
;272:	{
line 273
;273:		s_startserver.mappics[i].generic.flags &= ~QMF_HIGHLIGHT;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_startserver+604+44
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 4294967231
BANDU4
ASGNU4
line 274
;274:		s_startserver.mappics[i].generic.name   = NULL;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_startserver+604+4
ADDP4
CNSTP4 0
ASGNP4
line 275
;275:		s_startserver.mappics[i].shader         = 0;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_startserver+604+68
ADDP4
CNSTI4 0
ASGNI4
line 278
;276:
;277:		// disable
;278:		s_startserver.mapbuttons[i].generic.flags &= ~QMF_PULSEIFFOCUS;
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_startserver+1308+44
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRU4
CNSTU4 4294967039
BANDU4
ASGNU4
line 279
;279:		s_startserver.mapbuttons[i].generic.flags |= QMF_INACTIVE;
ADDRLP4 16
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_startserver+1308+44
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRU4
CNSTU4 16384
BORU4
ASGNU4
line 280
;280:	}
LABELV $156
line 271
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $158
ADDRLP4 0
INDIRI4
CNSTI4 8
LTI4 $155
line 284
;281:
;282:
;283:	// no servers to start
;284:	if( !s_startserver.nummaps ) {
ADDRGP4 s_startserver+2620
INDIRI4
CNSTI4 0
NEI4 $169
line 285
;285:		s_startserver.next.generic.flags |= QMF_INACTIVE;
ADDRLP4 8
ADDRGP4 s_startserver+2364+44
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 16384
BORU4
ASGNU4
line 288
;286:
;287:		// set the map name
;288:		strcpy( s_startserver.mapname.string, "NO MAPS FOUND" );
ADDRGP4 s_startserver+2452+60
INDIRP4
ARGP4
ADDRGP4 $176
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 289
;289:	}
ADDRGP4 $170
JUMPV
LABELV $169
line 290
;290:	else {
line 292
;291:		// set the highlight
;292:		s_startserver.next.generic.flags &= ~QMF_INACTIVE;
ADDRLP4 8
ADDRGP4 s_startserver+2364+44
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 4294950911
BANDU4
ASGNU4
line 293
;293:		i = s_startserver.currentmap - top;
ADDRLP4 0
ADDRGP4 s_startserver+2616
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
ASGNI4
line 294
;294:		if ( i >=0 && i < MAX_MAPSPERPAGE ) 
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $180
ADDRLP4 0
INDIRI4
CNSTI4 8
GEI4 $180
line 295
;295:		{
line 296
;296:			s_startserver.mappics[i].generic.flags    |= QMF_HIGHLIGHT;
ADDRLP4 16
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_startserver+604+44
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRU4
CNSTU4 64
BORU4
ASGNU4
line 297
;297:			s_startserver.mapbuttons[i].generic.flags &= ~QMF_PULSEIFFOCUS;
ADDRLP4 20
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_startserver+1308+44
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRU4
CNSTU4 4294967039
BANDU4
ASGNU4
line 298
;298:		}
LABELV $180
line 301
;299:
;300:		// set the map name
;301:		strcpy( s_startserver.mapname.string, s_startserver.maplist[s_startserver.currentmap] );
ADDRGP4 s_startserver+2452+60
INDIRP4
ARGP4
ADDRGP4 s_startserver+2616
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 s_startserver+2632
ADDP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 302
;302:	}
LABELV $170
line 304
;303:	
;304:	Q_strupr( s_startserver.mapname.string );
ADDRGP4 s_startserver+2452+60
INDIRP4
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 305
;305:}
LABELV $133
endproc StartServer_Update 28 16
proc StartServer_MapEvent 0 0
line 313
;306:
;307:
;308:/*
;309:=================
;310:StartServer_MapEvent
;311:=================
;312:*/
;313:static void StartServer_MapEvent( void* ptr, int event ) {
line 314
;314:	if( event != QM_ACTIVATED) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $193
line 315
;315:		return;
ADDRGP4 $192
JUMPV
LABELV $193
line 318
;316:	}
;317:
;318:	s_startserver.currentmap = (s_startserver.page*MAX_MAPSPERPAGE) + (((menucommon_s*)ptr)->id - ID_PICTURES);
ADDRGP4 s_startserver+2616
ADDRGP4 s_startserver+2624
INDIRI4
CNSTI4 3
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 11
SUBI4
ADDI4
ASGNI4
line 319
;319:	StartServer_Update();
ADDRGP4 StartServer_Update
CALLV
pop
line 320
;320:}
LABELV $192
endproc StartServer_MapEvent 0 0
proc StartServer_GametypeEvent 44 12
line 328
;321:
;322:
;323:/*
;324:=================
;325:StartServer_GametypeEvent
;326:=================
;327:*/
;328:static void StartServer_GametypeEvent( void* ptr, int event ) {
line 335
;329:	int			i;
;330:	int			count;
;331:	int			gamebits;
;332:	int			matchbits;
;333:	const char	*info;
;334:
;335:	if( event != QM_ACTIVATED) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $198
line 336
;336:		return;
ADDRGP4 $197
JUMPV
LABELV $198
line 339
;337:	}
;338:
;339:	count = UI_GetNumArenas();
ADDRLP4 20
ADDRGP4 UI_GetNumArenas
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 20
INDIRI4
ASGNI4
line 340
;340:	s_startserver.nummaps = 0;
ADDRGP4 s_startserver+2620
CNSTI4 0
ASGNI4
line 347
;341:#if 0	// JUHOX: no game type spin control
;342:	matchbits = 1 << gametype_remap[s_startserver.gametype.curvalue];
;343:	if( gametype_remap[s_startserver.gametype.curvalue] == GT_FFA ) {
;344:		matchbits |= ( 1 << GT_SINGLE_PLAYER );
;345:	}
;346:#else
;347:	matchbits = 1 << s_startserver.gametype;
ADDRLP4 12
CNSTI4 1
ADDRGP4 s_startserver+496
INDIRI4
LSHI4
ASGNI4
line 348
;348:	if(s_startserver.gametype == GT_FFA) matchbits |= (1 << GT_SINGLE_PLAYER);
ADDRGP4 s_startserver+496
INDIRI4
CNSTI4 0
NEI4 $202
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 4
BORI4
ASGNI4
LABELV $202
line 350
;349:#endif
;350:	for( i = 0; i < count; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $208
JUMPV
LABELV $205
line 351
;351:		info = UI_GetArenaInfoByNumber( i );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 UI_GetArenaInfoByNumber
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 24
INDIRP4
ASGNP4
line 353
;352:
;353:		gamebits = GametypeBits( Info_ValueForKey( info, "type") );
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 $209
ARGP4
ADDRLP4 28
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 GametypeBits
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 32
INDIRI4
ASGNI4
line 354
;354:		if( !( gamebits & matchbits ) ) {
ADDRLP4 4
INDIRI4
ADDRLP4 12
INDIRI4
BANDI4
CNSTI4 0
NEI4 $210
line 355
;355:			continue;
ADDRGP4 $206
JUMPV
LABELV $210
line 358
;356:		}
;357:
;358:		Q_strncpyz( s_startserver.maplist[s_startserver.nummaps], Info_ValueForKey( info, "map"), MAX_NAMELENGTH );
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 $214
ARGP4
ADDRLP4 36
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 s_startserver+2620
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 s_startserver+2632
ADDP4
ARGP4
ADDRLP4 36
INDIRP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 359
;359:		Q_strupr( s_startserver.maplist[s_startserver.nummaps] );
ADDRGP4 s_startserver+2620
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 s_startserver+2632
ADDP4
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 360
;360:		s_startserver.mapGamebits[s_startserver.nummaps] = gamebits;
ADDRGP4 s_startserver+2620
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 s_startserver+6728
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 361
;361:		s_startserver.nummaps++;
ADDRLP4 40
ADDRGP4 s_startserver+2620
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 362
;362:	}
LABELV $206
line 350
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $208
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRI4
LTI4 $205
line 363
;363:	s_startserver.maxpages = (s_startserver.nummaps + MAX_MAPSPERPAGE-1)/MAX_MAPSPERPAGE;
ADDRGP4 s_startserver+2628
ADDRGP4 s_startserver+2620
INDIRI4
CNSTI4 8
ADDI4
CNSTI4 1
SUBI4
CNSTI4 8
DIVI4
ASGNI4
line 364
;364:	s_startserver.page = 0;
ADDRGP4 s_startserver+2624
CNSTI4 0
ASGNI4
line 365
;365:	s_startserver.currentmap = 0;
ADDRGP4 s_startserver+2616
CNSTI4 0
ASGNI4
line 367
;366:
;367:	StartServer_Update();
ADDRGP4 StartServer_Update
CALLV
pop
line 368
;368:}
LABELV $197
endproc StartServer_GametypeEvent 44 12
proc StartServer_MenuEvent 12 12
line 376
;369:
;370:
;371:/*
;372:=================
;373:StartServer_MenuEvent
;374:=================
;375:*/
;376:static void StartServer_MenuEvent( void* ptr, int event ) {
line 377
;377:	if( event != QM_ACTIVATED ) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $225
line 378
;378:		return;
ADDRGP4 $224
JUMPV
LABELV $225
line 381
;379:	}
;380:
;381:	switch( ((menucommon_s*)ptr)->id ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 15
LTI4 $227
ADDRLP4 0
INDIRI4
CNSTI4 18
GTI4 $227
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $254-60
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $254
address $230
address $235
address $253
address $241
code
LABELV $230
line 383
;382:	case ID_PREVPAGE:
;383:		if( s_startserver.page > 0 ) {
ADDRGP4 s_startserver+2624
INDIRI4
CNSTI4 0
LEI4 $228
line 384
;384:			s_startserver.page--;
ADDRLP4 8
ADDRGP4 s_startserver+2624
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 385
;385:			StartServer_Update();
ADDRGP4 StartServer_Update
CALLV
pop
line 386
;386:		}
line 387
;387:		break;
ADDRGP4 $228
JUMPV
LABELV $235
line 390
;388:
;389:	case ID_NEXTPAGE:
;390:		if( s_startserver.page < s_startserver.maxpages - 1 ) {
ADDRGP4 s_startserver+2624
INDIRI4
ADDRGP4 s_startserver+2628
INDIRI4
CNSTI4 1
SUBI4
GEI4 $228
line 391
;391:			s_startserver.page++;
ADDRLP4 8
ADDRGP4 s_startserver+2624
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 392
;392:			StartServer_Update();
ADDRGP4 StartServer_Update
CALLV
pop
line 393
;393:		}
line 394
;394:		break;
ADDRGP4 $228
JUMPV
LABELV $241
line 397
;395:
;396:	case ID_STARTSERVERNEXT:
;397:		ClearTemplate();	// JUHOX
ADDRGP4 ClearTemplate
CALLV
pop
line 398
;398:		Q_strncpyz(s_startserver.choosenmap, s_startserver.maplist[s_startserver.currentmap], sizeof(s_startserver.choosenmap));	// JUHOX
ADDRGP4 s_startserver+7752
ARGP4
ADDRGP4 s_startserver+2616
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 s_startserver+2632
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 399
;399:		Q_strncpyz(s_startserver.choosenmapname, s_startserver.mapname.string, sizeof(s_startserver.choosenmapname));	// JUHOX
ADDRGP4 s_startserver+7768
ARGP4
ADDRGP4 s_startserver+2452+60
INDIRP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 403
;400:#if 0	// JUHOX: no game type spin control
;401:		trap_Cvar_SetValue( "g_gameType", gametype_remap[s_startserver.gametype.curvalue] );
;402:#else
;403:		trap_Cvar_SetValue("g_gameType", s_startserver.gametype);
ADDRGP4 $250
ARGP4
ADDRGP4 s_startserver+496
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 405
;404:#endif
;405:		UI_ServerOptionsMenu( s_startserver.multiplayer );
ADDRGP4 s_startserver+2612
INDIRI4
ARGI4
ADDRGP4 UI_ServerOptionsMenu
CALLV
pop
line 406
;406:		break;
ADDRGP4 $228
JUMPV
LABELV $253
line 409
;407:
;408:	case ID_STARTSERVERBACK:
;409:		UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 410
;410:		break;
LABELV $227
LABELV $228
line 412
;411:	}
;412:}
LABELV $224
endproc StartServer_MenuEvent 12 12
proc StartServer_LevelshotDraw 48 20
line 420
;413:
;414:
;415:/*
;416:===============
;417:StartServer_LevelshotDraw
;418:===============
;419:*/
;420:static void StartServer_LevelshotDraw( void *self ) {
line 428
;421:	menubitmap_s	*b;
;422:	int				x;
;423:	int				y;
;424:	int				w;
;425:	int				h;
;426:	int				n;
;427:
;428:	b = (menubitmap_s *)self;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 430
;429:
;430:	if( !b->generic.name ) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $257
line 431
;431:		return;
ADDRGP4 $256
JUMPV
LABELV $257
line 434
;432:	}
;433:
;434:	if( b->generic.name && !b->shader ) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $259
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 0
NEI4 $259
line 435
;435:		b->shader = trap_R_RegisterShaderNoMip( b->generic.name );
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 32
INDIRI4
ASGNI4
line 436
;436:		if( !b->shader && b->errorpic ) {
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 0
NEI4 $261
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $261
line 437
;437:			b->shader = trap_R_RegisterShaderNoMip( b->errorpic );
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 44
INDIRI4
ASGNI4
line 438
;438:		}
LABELV $261
line 439
;439:	}
LABELV $259
line 441
;440:
;441:	if( b->focuspic && !b->focusshader ) {
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $263
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
NEI4 $263
line 442
;442:		b->focusshader = trap_R_RegisterShaderNoMip( b->focuspic );
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
ADDRLP4 36
INDIRI4
ASGNI4
line 443
;443:	}
LABELV $263
line 445
;444:
;445:	x = b->generic.x;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 446
;446:	y = b->generic.y;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 447
;447:	w = b->width;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
ASGNI4
line 448
;448:	h =	b->height;
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
ASGNI4
line 449
;449:	if( b->shader ) {
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 0
EQI4 $265
line 450
;450:		UI_DrawHandlePic( x, y, w, h, b->shader );
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 451
;451:	}
LABELV $265
line 453
;452:
;453:	x = b->generic.x;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 454
;454:	y = b->generic.y + b->height;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
ADDI4
ASGNI4
line 455
;455:	UI_FillRect( x, y, b->width, 28, colorBlack );
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1105199104
ARGF4
ADDRGP4 colorBlack
ARGP4
ADDRGP4 UI_FillRect
CALLV
pop
line 457
;456:
;457:	x += b->width / 2;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 2
DIVI4
ADDI4
ASGNI4
line 458
;458:	y += 4;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 4
ADDI4
ASGNI4
line 459
;459:	n = s_startserver.page * MAX_MAPSPERPAGE + b->generic.id - ID_PICTURES;
ADDRLP4 20
ADDRGP4 s_startserver+2624
INDIRI4
CNSTI4 3
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDI4
CNSTI4 11
SUBI4
ASGNI4
line 460
;460:	UI_DrawString( x, y, s_startserver.maplist[n], UI_CENTER|UI_SMALLFONT, color_orange );
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 20
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 s_startserver+2632
ADDP4
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 color_orange
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 462
;461:
;462:	x = b->generic.x;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 463
;463:	y = b->generic.y;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 464
;464:	w = b->width;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
ASGNI4
line 465
;465:	h =	b->height + 28;
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 28
ADDI4
ASGNI4
line 466
;466:	if( b->generic.flags & QMF_HIGHLIGHT ) {	
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 64
BANDU4
CNSTU4 0
EQU4 $269
line 467
;467:		UI_DrawHandlePic( x, y, w, h, b->focusshader );
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 468
;468:	}
LABELV $269
line 469
;469:}
LABELV $256
endproc StartServer_LevelshotDraw 48 20
bss
align 1
LABELV $272
skip 64
code
proc StartServer_MenuInit 20 12
line 477
;470:
;471:
;472:/*
;473:=================
;474:StartServer_MenuInit
;475:=================
;476:*/
;477:static void StartServer_MenuInit( void ) {
line 484
;478:	int	i;
;479:	int	x;
;480:	int	y;
;481:	static char mapnamebuffer[64];
;482:
;483:	// zero set all our globals
;484:	memset( &s_startserver, 0 ,sizeof(startserver_t) );
ADDRGP4 s_startserver
ARGP4
CNSTI4 0
ARGI4
CNSTI4 7784
ARGI4
ADDRGP4 memset
CALLP4
pop
line 485
;485:	ClearTemplate();	// JUHOX
ADDRGP4 ClearTemplate
CALLV
pop
line 486
;486:	s_startserver.gametype = initialGameType;	// JUHOX
ADDRGP4 s_startserver+496
ADDRGP4 initialGameType
INDIRI4
ASGNI4
line 488
;487:
;488:	StartServer_Cache();
ADDRGP4 StartServer_Cache
CALLV
pop
line 490
;489:
;490:	s_startserver.menu.wrapAround = qtrue;
ADDRGP4 s_startserver+404
CNSTI4 1
ASGNI4
line 491
;491:	s_startserver.menu.fullscreen = qtrue;
ADDRGP4 s_startserver+408
CNSTI4 1
ASGNI4
line 493
;492:
;493:	s_startserver.banner.generic.type  = MTYPE_BTEXT;
ADDRGP4 s_startserver+424
CNSTI4 10
ASGNI4
line 494
;494:	s_startserver.banner.generic.x	   = 320;
ADDRGP4 s_startserver+424+12
CNSTI4 320
ASGNI4
line 495
;495:	s_startserver.banner.generic.y	   = 16;
ADDRGP4 s_startserver+424+16
CNSTI4 16
ASGNI4
line 496
;496:	s_startserver.banner.string        = "GAME SERVER";
ADDRGP4 s_startserver+424+60
ADDRGP4 $283
ASGNP4
line 497
;497:	s_startserver.banner.color         = color_white;
ADDRGP4 s_startserver+424+68
ADDRGP4 color_white
ASGNP4
line 498
;498:	s_startserver.banner.style         = UI_CENTER;
ADDRGP4 s_startserver+424+64
CNSTI4 1
ASGNI4
line 501
;499:
;500:#if 1	// JUHOX: add game title
;501:	Q_strncpyz(s_startserver.gamename, gametype_names[s_startserver.gametype], sizeof(s_startserver.gamename));
ADDRGP4 s_startserver+572
ARGP4
ADDRGP4 s_startserver+496
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gametype_names
ADDP4
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 502
;502:	s_startserver.gametitle.generic.type	= MTYPE_PTEXT;
ADDRGP4 s_startserver+500
CNSTI4 9
ASGNI4
line 503
;503:	s_startserver.gametitle.generic.x		= 320;
ADDRGP4 s_startserver+500+12
CNSTI4 320
ASGNI4
line 504
;504:	s_startserver.gametitle.generic.y		= 57;
ADDRGP4 s_startserver+500+16
CNSTI4 57
ASGNI4
line 505
;505:	s_startserver.gametitle.string			= s_startserver.gamename;
ADDRGP4 s_startserver+500+60
ADDRGP4 s_startserver+572
ASGNP4
line 506
;506:	s_startserver.gametitle.color			= colorWhite;
ADDRGP4 s_startserver+500+68
ADDRGP4 colorWhite
ASGNP4
line 507
;507:	s_startserver.gametitle.style			= UI_CENTER;
ADDRGP4 s_startserver+500+64
CNSTI4 1
ASGNI4
line 508
;508:	Menu_AddItem(&s_startserver.menu, &s_startserver.gametitle);
ADDRGP4 s_startserver
ARGP4
ADDRGP4 s_startserver+500
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 541
;509:#endif
;510:
;511:
;512:#if 0	// JUHOX: no frame for map selector
;513:	s_startserver.framel.generic.type  = MTYPE_BITMAP;
;514:	s_startserver.framel.generic.name  = GAMESERVER_FRAMEL;
;515:	s_startserver.framel.generic.flags = QMF_INACTIVE;
;516:	s_startserver.framel.generic.x	   = 0;  
;517:	s_startserver.framel.generic.y	   = 78;
;518:	s_startserver.framel.width  	   = 256;
;519:	s_startserver.framel.height  	   = 329;
;520:
;521:	s_startserver.framer.generic.type  = MTYPE_BITMAP;
;522:	s_startserver.framer.generic.name  = GAMESERVER_FRAMER;
;523:	s_startserver.framer.generic.flags = QMF_INACTIVE;
;524:	s_startserver.framer.generic.x	   = 376;
;525:	s_startserver.framer.generic.y	   = 76;
;526:	s_startserver.framer.width  	   = 256;
;527:	s_startserver.framer.height  	   = 334;
;528:#endif
;529:
;530:#if 0	// JUHOX: no game type spin control
;531:	s_startserver.gametype.generic.type		= MTYPE_SPINCONTROL;
;532:	s_startserver.gametype.generic.name		= "Game Type:";
;533:	s_startserver.gametype.generic.flags	= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
;534:	s_startserver.gametype.generic.callback	= StartServer_GametypeEvent;
;535:	s_startserver.gametype.generic.id		= ID_GAMETYPE;
;536:	s_startserver.gametype.generic.x		= 320 - 24;
;537:	s_startserver.gametype.generic.y		= 368;
;538:	s_startserver.gametype.itemnames		= gametype_items;
;539:#endif
;540:
;541:	for (i=0; i<MAX_MAPSPERPAGE; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $304
line 542
;542:	{
line 547
;543:#if 0	// JUHOX: adapt map selector position
;544:		x =	(i % MAX_MAPCOLS) * (128+8) + 188;
;545:		y = (i / MAX_MAPROWS) * (128+8) + 96;
;546:#else
;547:		x = (i % MAX_MAPCOLS) * (128+8) + 320 - (64+4)*MAX_MAPCOLS + 4;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 4
MODI4
CNSTI4 136
MULI4
CNSTI4 320
ADDI4
CNSTI4 272
SUBI4
CNSTI4 4
ADDI4
ASGNI4
line 548
;548:		y = (i / MAX_MAPCOLS) * (128+8) + 96;	// JUHOX BUGFIX: MAX_MAPROWS is wrong!
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 4
DIVI4
CNSTI4 136
MULI4
CNSTI4 96
ADDI4
ASGNI4
line 551
;549:#endif
;550:
;551:		s_startserver.mappics[i].generic.type   = MTYPE_BITMAP;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_startserver+604
ADDP4
CNSTI4 6
ASGNI4
line 552
;552:		s_startserver.mappics[i].generic.flags  = QMF_LEFT_JUSTIFY|QMF_INACTIVE;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_startserver+604+44
ADDP4
CNSTU4 16388
ASGNU4
line 553
;553:		s_startserver.mappics[i].generic.x	    = x;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_startserver+604+12
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 554
;554:		s_startserver.mappics[i].generic.y	    = y;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_startserver+604+16
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 555
;555:		s_startserver.mappics[i].generic.id		= ID_PICTURES+i;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_startserver+604+8
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 11
ADDI4
ASGNI4
line 556
;556:		s_startserver.mappics[i].width  		= 128;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_startserver+604+76
ADDP4
CNSTI4 128
ASGNI4
line 557
;557:		s_startserver.mappics[i].height  	    = 96;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_startserver+604+80
ADDP4
CNSTI4 96
ASGNI4
line 558
;558:		s_startserver.mappics[i].focuspic       = GAMESERVER_SELECTED;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_startserver+604+60
ADDP4
ADDRGP4 $323
ASGNP4
line 559
;559:		s_startserver.mappics[i].errorpic       = GAMESERVER_UNKNOWNMAP;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_startserver+604+64
ADDP4
ADDRGP4 $326
ASGNP4
line 560
;560:		s_startserver.mappics[i].generic.ownerdraw = StartServer_LevelshotDraw;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_startserver+604+56
ADDP4
ADDRGP4 StartServer_LevelshotDraw
ASGNP4
line 562
;561:
;562:		s_startserver.mapbuttons[i].generic.type     = MTYPE_BITMAP;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_startserver+1308
ADDP4
CNSTI4 6
ASGNI4
line 563
;563:		s_startserver.mapbuttons[i].generic.flags    = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_NODEFAULTINIT;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_startserver+1308+44
ADDP4
CNSTU4 33028
ASGNU4
line 564
;564:		s_startserver.mapbuttons[i].generic.id       = ID_PICTURES+i;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_startserver+1308+8
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 11
ADDI4
ASGNI4
line 565
;565:		s_startserver.mapbuttons[i].generic.callback = StartServer_MapEvent;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_startserver+1308+48
ADDP4
ADDRGP4 StartServer_MapEvent
ASGNP4
line 566
;566:		s_startserver.mapbuttons[i].generic.x	     = x - 30;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_startserver+1308+12
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 30
SUBI4
ASGNI4
line 567
;567:		s_startserver.mapbuttons[i].generic.y	     = y - 32;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_startserver+1308+16
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 32
SUBI4
ASGNI4
line 568
;568:		s_startserver.mapbuttons[i].width  		     = 256;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_startserver+1308+76
ADDP4
CNSTI4 256
ASGNI4
line 569
;569:		s_startserver.mapbuttons[i].height  	     = 248;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_startserver+1308+80
ADDP4
CNSTI4 248
ASGNI4
line 570
;570:		s_startserver.mapbuttons[i].generic.left     = x;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_startserver+1308+20
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 571
;571:		s_startserver.mapbuttons[i].generic.top  	 = y;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_startserver+1308+24
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 572
;572:		s_startserver.mapbuttons[i].generic.right    = x + 128;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_startserver+1308+28
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 128
ADDI4
ASGNI4
line 573
;573:		s_startserver.mapbuttons[i].generic.bottom   = y + 128;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_startserver+1308+32
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 128
ADDI4
ASGNI4
line 574
;574:		s_startserver.mapbuttons[i].focuspic         = GAMESERVER_SELECT;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_startserver+1308+60
ADDP4
ADDRGP4 $354
ASGNP4
line 575
;575:	}
LABELV $305
line 541
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 8
LTI4 $304
line 577
;576:
;577:	s_startserver.arrows.generic.type  = MTYPE_BITMAP;
ADDRGP4 s_startserver+2012
CNSTI4 6
ASGNI4
line 578
;578:	s_startserver.arrows.generic.name  = GAMESERVER_ARROWS;
ADDRGP4 s_startserver+2012+4
ADDRGP4 $358
ASGNP4
line 579
;579:	s_startserver.arrows.generic.flags = QMF_INACTIVE;
ADDRGP4 s_startserver+2012+44
CNSTU4 16384
ASGNU4
line 580
;580:	s_startserver.arrows.generic.x	   = 260;
ADDRGP4 s_startserver+2012+12
CNSTI4 260
ASGNI4
line 581
;581:	s_startserver.arrows.generic.y	   = 400;
ADDRGP4 s_startserver+2012+16
CNSTI4 400
ASGNI4
line 582
;582:	s_startserver.arrows.width  	   = 128;
ADDRGP4 s_startserver+2012+76
CNSTI4 128
ASGNI4
line 583
;583:	s_startserver.arrows.height  	   = 32;
ADDRGP4 s_startserver+2012+80
CNSTI4 32
ASGNI4
line 585
;584:
;585:	s_startserver.prevpage.generic.type	    = MTYPE_BITMAP;
ADDRGP4 s_startserver+2100
CNSTI4 6
ASGNI4
line 586
;586:	s_startserver.prevpage.generic.flags    = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_startserver+2100+44
CNSTU4 260
ASGNU4
line 587
;587:	s_startserver.prevpage.generic.callback = StartServer_MenuEvent;
ADDRGP4 s_startserver+2100+48
ADDRGP4 StartServer_MenuEvent
ASGNP4
line 588
;588:	s_startserver.prevpage.generic.id	    = ID_PREVPAGE;
ADDRGP4 s_startserver+2100+8
CNSTI4 15
ASGNI4
line 589
;589:	s_startserver.prevpage.generic.x		= 260;
ADDRGP4 s_startserver+2100+12
CNSTI4 260
ASGNI4
line 590
;590:	s_startserver.prevpage.generic.y		= 400;
ADDRGP4 s_startserver+2100+16
CNSTI4 400
ASGNI4
line 591
;591:	s_startserver.prevpage.width  		    = 64;
ADDRGP4 s_startserver+2100+76
CNSTI4 64
ASGNI4
line 592
;592:	s_startserver.prevpage.height  		    = 32;
ADDRGP4 s_startserver+2100+80
CNSTI4 32
ASGNI4
line 593
;593:	s_startserver.prevpage.focuspic         = GAMESERVER_ARROWSL;
ADDRGP4 s_startserver+2100+60
ADDRGP4 $386
ASGNP4
line 595
;594:
;595:	s_startserver.nextpage.generic.type	    = MTYPE_BITMAP;
ADDRGP4 s_startserver+2188
CNSTI4 6
ASGNI4
line 596
;596:	s_startserver.nextpage.generic.flags    = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_startserver+2188+44
CNSTU4 260
ASGNU4
line 597
;597:	s_startserver.nextpage.generic.callback = StartServer_MenuEvent;
ADDRGP4 s_startserver+2188+48
ADDRGP4 StartServer_MenuEvent
ASGNP4
line 598
;598:	s_startserver.nextpage.generic.id	    = ID_NEXTPAGE;
ADDRGP4 s_startserver+2188+8
CNSTI4 16
ASGNI4
line 599
;599:	s_startserver.nextpage.generic.x		= 321;
ADDRGP4 s_startserver+2188+12
CNSTI4 321
ASGNI4
line 600
;600:	s_startserver.nextpage.generic.y		= 400;
ADDRGP4 s_startserver+2188+16
CNSTI4 400
ASGNI4
line 601
;601:	s_startserver.nextpage.width  		    = 64;
ADDRGP4 s_startserver+2188+76
CNSTI4 64
ASGNI4
line 602
;602:	s_startserver.nextpage.height  		    = 32;
ADDRGP4 s_startserver+2188+80
CNSTI4 32
ASGNI4
line 603
;603:	s_startserver.nextpage.focuspic         = GAMESERVER_ARROWSR;
ADDRGP4 s_startserver+2188+60
ADDRGP4 $404
ASGNP4
line 605
;604:
;605:	s_startserver.mapname.generic.type  = MTYPE_PTEXT;
ADDRGP4 s_startserver+2452
CNSTI4 9
ASGNI4
line 606
;606:	s_startserver.mapname.generic.flags = QMF_CENTER_JUSTIFY|QMF_INACTIVE;
ADDRGP4 s_startserver+2452+44
CNSTU4 16392
ASGNU4
line 607
;607:	s_startserver.mapname.generic.x	    = 320;
ADDRGP4 s_startserver+2452+12
CNSTI4 320
ASGNI4
line 608
;608:	s_startserver.mapname.generic.y	    = 440;
ADDRGP4 s_startserver+2452+16
CNSTI4 440
ASGNI4
line 609
;609:	s_startserver.mapname.string        = mapnamebuffer;
ADDRGP4 s_startserver+2452+60
ADDRGP4 $272
ASGNP4
line 610
;610:	s_startserver.mapname.style         = UI_CENTER|UI_BIGFONT;
ADDRGP4 s_startserver+2452+64
CNSTI4 33
ASGNI4
line 611
;611:	s_startserver.mapname.color         = text_color_normal;
ADDRGP4 s_startserver+2452+68
ADDRGP4 text_color_normal
ASGNP4
line 613
;612:
;613:	s_startserver.back.generic.type	    = MTYPE_BITMAP;
ADDRGP4 s_startserver+2276
CNSTI4 6
ASGNI4
line 614
;614:	s_startserver.back.generic.name     = GAMESERVER_BACK0;
ADDRGP4 s_startserver+2276+4
ADDRGP4 $421
ASGNP4
line 615
;615:	s_startserver.back.generic.flags    = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_startserver+2276+44
CNSTU4 260
ASGNU4
line 616
;616:	s_startserver.back.generic.callback = StartServer_MenuEvent;
ADDRGP4 s_startserver+2276+48
ADDRGP4 StartServer_MenuEvent
ASGNP4
line 617
;617:	s_startserver.back.generic.id	    = ID_STARTSERVERBACK;
ADDRGP4 s_startserver+2276+8
CNSTI4 17
ASGNI4
line 618
;618:	s_startserver.back.generic.x		= 0;
ADDRGP4 s_startserver+2276+12
CNSTI4 0
ASGNI4
line 619
;619:	s_startserver.back.generic.y		= 480-64;
ADDRGP4 s_startserver+2276+16
CNSTI4 416
ASGNI4
line 620
;620:	s_startserver.back.width  		    = 128;
ADDRGP4 s_startserver+2276+76
CNSTI4 128
ASGNI4
line 621
;621:	s_startserver.back.height  		    = 64;
ADDRGP4 s_startserver+2276+80
CNSTI4 64
ASGNI4
line 622
;622:	s_startserver.back.focuspic         = GAMESERVER_BACK1;
ADDRGP4 s_startserver+2276+60
ADDRGP4 $438
ASGNP4
line 624
;623:
;624:	s_startserver.next.generic.type	    = MTYPE_BITMAP;
ADDRGP4 s_startserver+2364
CNSTI4 6
ASGNI4
line 625
;625:	s_startserver.next.generic.name     = GAMESERVER_NEXT0;
ADDRGP4 s_startserver+2364+4
ADDRGP4 $442
ASGNP4
line 626
;626:	s_startserver.next.generic.flags    = QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_startserver+2364+44
CNSTU4 272
ASGNU4
line 627
;627:	s_startserver.next.generic.callback = StartServer_MenuEvent;
ADDRGP4 s_startserver+2364+48
ADDRGP4 StartServer_MenuEvent
ASGNP4
line 628
;628:	s_startserver.next.generic.id	    = ID_STARTSERVERNEXT;
ADDRGP4 s_startserver+2364+8
CNSTI4 18
ASGNI4
line 629
;629:	s_startserver.next.generic.x		= 640;
ADDRGP4 s_startserver+2364+12
CNSTI4 640
ASGNI4
line 630
;630:	s_startserver.next.generic.y		= 480-64;
ADDRGP4 s_startserver+2364+16
CNSTI4 416
ASGNI4
line 631
;631:	s_startserver.next.width  		    = 128;
ADDRGP4 s_startserver+2364+76
CNSTI4 128
ASGNI4
line 632
;632:	s_startserver.next.height  		    = 64;
ADDRGP4 s_startserver+2364+80
CNSTI4 64
ASGNI4
line 633
;633:	s_startserver.next.focuspic         = GAMESERVER_NEXT1;
ADDRGP4 s_startserver+2364+60
ADDRGP4 $459
ASGNP4
line 635
;634:
;635:	s_startserver.item_null.generic.type	= MTYPE_BITMAP;
ADDRGP4 s_startserver+2524
CNSTI4 6
ASGNI4
line 636
;636:	s_startserver.item_null.generic.flags	= QMF_LEFT_JUSTIFY|QMF_MOUSEONLY|QMF_SILENT;
ADDRGP4 s_startserver+2524+44
CNSTU4 1050628
ASGNU4
line 637
;637:	s_startserver.item_null.generic.x		= 0;
ADDRGP4 s_startserver+2524+12
CNSTI4 0
ASGNI4
line 638
;638:	s_startserver.item_null.generic.y		= 0;
ADDRGP4 s_startserver+2524+16
CNSTI4 0
ASGNI4
line 639
;639:	s_startserver.item_null.width			= 640;
ADDRGP4 s_startserver+2524+76
CNSTI4 640
ASGNI4
line 640
;640:	s_startserver.item_null.height			= 480;
ADDRGP4 s_startserver+2524+80
CNSTI4 480
ASGNI4
line 642
;641:
;642:	Menu_AddItem( &s_startserver.menu, &s_startserver.banner );
ADDRGP4 s_startserver
ARGP4
ADDRGP4 s_startserver+424
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 651
;643:#if 0	// JUHOX: no frame for map selector
;644:	Menu_AddItem( &s_startserver.menu, &s_startserver.framel );
;645:	Menu_AddItem( &s_startserver.menu, &s_startserver.framer );
;646:#endif
;647:
;648:#if 0	// JUHOX: no game type spin control
;649:	Menu_AddItem( &s_startserver.menu, &s_startserver.gametype );
;650:#endif
;651:	for (i=0; i<MAX_MAPSPERPAGE; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $472
line 652
;652:	{
line 653
;653:		Menu_AddItem( &s_startserver.menu, &s_startserver.mappics[i] );
ADDRGP4 s_startserver
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_startserver+604
ADDP4
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 654
;654:		Menu_AddItem( &s_startserver.menu, &s_startserver.mapbuttons[i] );
ADDRGP4 s_startserver
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_startserver+1308
ADDP4
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 655
;655:	}
LABELV $473
line 651
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 8
LTI4 $472
line 657
;656:
;657:	Menu_AddItem( &s_startserver.menu, &s_startserver.arrows );
ADDRGP4 s_startserver
ARGP4
ADDRGP4 s_startserver+2012
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 658
;658:	Menu_AddItem( &s_startserver.menu, &s_startserver.prevpage );
ADDRGP4 s_startserver
ARGP4
ADDRGP4 s_startserver+2100
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 659
;659:	Menu_AddItem( &s_startserver.menu, &s_startserver.nextpage );
ADDRGP4 s_startserver
ARGP4
ADDRGP4 s_startserver+2188
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 660
;660:	Menu_AddItem( &s_startserver.menu, &s_startserver.back );
ADDRGP4 s_startserver
ARGP4
ADDRGP4 s_startserver+2276
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 661
;661:	Menu_AddItem( &s_startserver.menu, &s_startserver.next );
ADDRGP4 s_startserver
ARGP4
ADDRGP4 s_startserver+2364
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 662
;662:	Menu_AddItem( &s_startserver.menu, &s_startserver.mapname );
ADDRGP4 s_startserver
ARGP4
ADDRGP4 s_startserver+2452
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 663
;663:	Menu_AddItem( &s_startserver.menu, &s_startserver.item_null );
ADDRGP4 s_startserver
ARGP4
ADDRGP4 s_startserver+2524
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 665
;664:
;665:	StartServer_GametypeEvent( NULL, QM_ACTIVATED );
CNSTP4 0
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 StartServer_GametypeEvent
CALLV
pop
line 666
;666:}
LABELV $271
endproc StartServer_MenuInit 20 12
export StartServer_Cache
proc StartServer_Cache 104 16
line 675
;667:
;668:
;669:/*
;670:=================
;671:StartServer_Cache
;672:=================
;673:*/
;674:void StartServer_Cache( void )
;675:{
line 681
;676:	int				i;
;677:	const char		*info;
;678:	qboolean		precache;
;679:	char			picname[64];
;680:
;681:	trap_R_RegisterShaderNoMip( GAMESERVER_BACK0 );	
ADDRGP4 $421
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 682
;682:	trap_R_RegisterShaderNoMip( GAMESERVER_BACK1 );	
ADDRGP4 $438
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 683
;683:	trap_R_RegisterShaderNoMip( GAMESERVER_NEXT0 );	
ADDRGP4 $442
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 684
;684:	trap_R_RegisterShaderNoMip( GAMESERVER_NEXT1 );	
ADDRGP4 $459
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 696
;685:#if 0	// JUHOX: no frame for map selector
;686:	trap_R_RegisterShaderNoMip( GAMESERVER_FRAMEL );	
;687:	trap_R_RegisterShaderNoMip( GAMESERVER_FRAMER );	
;688:	trap_R_RegisterShaderNoMip( GAMESERVER_SELECT );	
;689:	trap_R_RegisterShaderNoMip( GAMESERVER_SELECTED );	
;690:	trap_R_RegisterShaderNoMip( GAMESERVER_UNKNOWNMAP );
;691:	trap_R_RegisterShaderNoMip( GAMESERVER_ARROWS );
;692:	trap_R_RegisterShaderNoMip( GAMESERVER_ARROWSL );
;693:	trap_R_RegisterShaderNoMip( GAMESERVER_ARROWSR );
;694:#endif
;695:
;696:	precache = trap_Cvar_VariableValue("com_buildscript");
ADDRGP4 $486
ARGP4
ADDRLP4 76
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 72
ADDRLP4 76
INDIRF4
CVFI4 4
ASGNI4
line 698
;697:#if 1	// JUHOX: precaching
;698:	precache |= (int) trap_Cvar_VariableValue("ui_precache");
ADDRGP4 $487
ARGP4
ADDRLP4 80
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 72
ADDRLP4 72
INDIRI4
ADDRLP4 80
INDIRF4
CVFI4 4
BORI4
ASGNI4
line 701
;699:#endif
;700:
;701:	s_startserver.nummaps = UI_GetNumArenas();
ADDRLP4 84
ADDRGP4 UI_GetNumArenas
CALLI4
ASGNI4
ADDRGP4 s_startserver+2620
ADDRLP4 84
INDIRI4
ASGNI4
line 703
;702:
;703:	for( i = 0; i < s_startserver.nummaps; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $492
JUMPV
LABELV $489
line 704
;704:		info = UI_GetArenaInfoByNumber( i );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 88
ADDRGP4 UI_GetArenaInfoByNumber
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 88
INDIRP4
ASGNP4
line 706
;705:
;706:		Q_strncpyz( s_startserver.maplist[i], Info_ValueForKey( info, "map"), MAX_NAMELENGTH );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $214
ARGP4
ADDRLP4 92
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 s_startserver+2632
ADDP4
ARGP4
ADDRLP4 92
INDIRP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 707
;707:		Q_strupr( s_startserver.maplist[i] );
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 s_startserver+2632
ADDP4
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 708
;708:		s_startserver.mapGamebits[i] = GametypeBits( Info_ValueForKey( info, "type") );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $209
ARGP4
ADDRLP4 96
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 96
INDIRP4
ARGP4
ADDRLP4 100
ADDRGP4 GametypeBits
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 s_startserver+6728
ADDP4
ADDRLP4 100
INDIRI4
ASGNI4
line 710
;709:
;710:		if( precache ) {
ADDRLP4 72
INDIRI4
CNSTI4 0
EQI4 $497
line 711
;711:			Com_sprintf( picname, sizeof(picname), "levelshots/%s", s_startserver.maplist[i] );
ADDRLP4 8
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $143
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 s_startserver+2632
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 712
;712:			trap_R_RegisterShaderNoMip(picname);
ADDRLP4 8
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 713
;713:		}
LABELV $497
line 714
;714:	}
LABELV $490
line 703
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $492
ADDRLP4 0
INDIRI4
ADDRGP4 s_startserver+2620
INDIRI4
LTI4 $489
line 716
;715:
;716:	s_startserver.maxpages = (s_startserver.nummaps + MAX_MAPSPERPAGE-1)/MAX_MAPSPERPAGE;
ADDRGP4 s_startserver+2628
ADDRGP4 s_startserver+2620
INDIRI4
CNSTI4 8
ADDI4
CNSTI4 1
SUBI4
CNSTI4 8
DIVI4
ASGNI4
line 717
;717:}
LABELV $485
endproc StartServer_Cache 104 16
export UI_StartServerMenu
proc UI_StartServerMenu 0 4
line 725
;718:
;719:
;720:/*
;721:=================
;722:UI_StartServerMenu
;723:=================
;724:*/
;725:void UI_StartServerMenu( qboolean multiplayer ) {
line 726
;726:	StartServer_MenuInit();
ADDRGP4 StartServer_MenuInit
CALLV
pop
line 727
;727:	s_startserver.multiplayer = multiplayer;
ADDRGP4 s_startserver+2612
ADDRFP4 0
INDIRI4
ASGNI4
line 728
;728:	UI_PushMenu( &s_startserver.menu );
ADDRGP4 s_startserver
ARGP4
ADDRGP4 UI_PushMenu
CALLV
pop
line 729
;729:}
LABELV $502
endproc UI_StartServerMenu 0 4
data
align 4
LABELV dedicated_list
address $505
address $506
address $507
byte 4 0
align 4
LABELV playerType_list
address $508
address $509
address $510
byte 4 0
align 4
LABELV playerTeam_list
address $511
address $512
byte 4 0
align 4
LABELV botSkill_list
address $513
address $514
address $515
address $516
address $517
byte 4 0
code
proc BotAlreadySelected 8 8
line 877
;730:
;731:
;732:
;733:/*
;734:=============================================================================
;735:
;736:SERVER OPTIONS MENU *****
;737:
;738:=============================================================================
;739:*/
;740:
;741:#define ID_PLAYER_TYPE			20
;742:#define ID_MAXCLIENTS			21
;743:#define ID_DEDICATED			22
;744:#define ID_GO					23
;745:#define ID_BACK					24
;746:
;747:#define PLAYER_SLOTS			12
;748:
;749:
;750:typedef struct {
;751:	menuframework_s		menu;
;752:
;753:	menutext_s			banner;
;754:
;755:	menubitmap_s		mappic;
;756:	menubitmap_s		picframe;
;757:
;758:	menulist_s			dedicated;
;759:	menufield_s			timelimit;
;760:	menufield_s			fraglimit;
;761:	menufield_s			flaglimit;
;762:	// JUHOX: artefacts menu field definition
;763:#if MONSTER_MODE
;764:	menufield_s			artefacts;
;765:#endif
;766:	// JUHOX: distanceLimit menu field definition
;767:#if ESCAPE_MODE
;768:	menufield_s			distanceLimit;
;769:#endif
;770:	menuradiobutton_s	friendlyfire;
;771:	menutext_s			advOptions;	// JUHOX
;772:	int					respawnDelay;	// JUHOX
;773:	qboolean			respawnAtPOD;
;774:	qboolean			tss;	// JUHOX
;775:	qboolean			tssSafetyMode;	// JUHOX
;776:	qboolean			armorFragments;	// JUHOX
;777:	qboolean			stamina;	// JUHOX
;778:	int					baseHealth;	// JUHOX
;779:	int					lightningDamageLimit;	// JUHOX
;780:#if GRAPPLE_ROPE
;781:	qboolean			grapple;	// JUHOX
;782:#endif
;783:	qboolean			noItems;	// JUHOX
;784:	qboolean			noHealthRegen;	// JUHOX
;785:	qboolean			unlimitedAmmo;	// JUHOX
;786:	qboolean			cloakingDevice;	// JUHOX
;787:	int					weaponLimit;	// JUHOX
;788:#if MONSTER_MODE	// JUHOX: server variable definitions for STU
;789:	qboolean			monsterLauncher;
;790:	int					minMonsters;
;791:	int					maxMonsters;
;792:	int					maxMonstersPerPlayer;
;793:	int					monstersPerTrap;
;794:	int					monsterSpawnDelay;
;795:	int					monsterGuards;
;796:	int					monsterTitans;
;797:	int					monsterHealthScale;
;798:	int					monsterProgression;
;799:	qboolean			monsterBreeding;
;800:	char				monsterModel1[32];
;801:	char				monsterModel2[32];
;802:	char				monsterModel3[32];
;803:	qboolean			skipEndSequence;
;804:	int					scoreMode;
;805:#endif
;806:#if ESCAPE_MODE	// JUHOX: server variable definitions for EFH
;807:	int					monsterLoad;
;808:	qboolean			challengingEnv;
;809:#endif
;810:	menufield_s			hostname;
;811:	menuradiobutton_s	pure;
;812:	menulist_s			botSkill;
;813:	menufield_s			additionalSlots;	// JUHOX
;814:	menufield_s			gameseed;			// JUHOX
;815:#if MEETING
;816:	menuradiobutton_s	meeting;			// JUHOX
;817:#endif
;818:
;819:	menutext_s			player0;
;820:	menulist_s			playerType[PLAYER_SLOTS];
;821:	menutext_s			playerName[PLAYER_SLOTS];
;822:	menulist_s			playerTeam[PLAYER_SLOTS];
;823:
;824:	menubitmap_s		go;
;825:	menubitmap_s		next;
;826:	menubitmap_s		back;
;827:
;828:	qboolean			multiplayer;
;829:	int					gametype;
;830:	char				mapnamebuffer[32];
;831:	char				playerNameBuffers[PLAYER_SLOTS][16];
;832:
;833:	qboolean			newBot;
;834:	int					newBotIndex;
;835:	char				newBotName[16];
;836:	
;837:	menulist_s		punkbuster;
;838:} serveroptions_t;
;839:
;840:static serveroptions_t s_serveroptions;
;841:
;842:static const char *dedicated_list[] = {
;843:	"No",
;844:	"LAN",
;845:	"Internet",
;846:	0
;847:};
;848:
;849:static const char *playerType_list[] = {
;850:	"Open",
;851:	"Bot",
;852:	"----",
;853:	0
;854:};
;855:
;856:static const char *playerTeam_list[] = {
;857:	"Blue",
;858:	"Red",
;859:	0
;860:};
;861:
;862:static const char *botSkill_list[] = {
;863:	"I Can Win",
;864:	"Bring It On",
;865:	"Hurt Me Plenty",
;866:	"Hardcore",
;867:	"Nightmare!",
;868:	0
;869:};
;870:
;871:
;872:/*
;873:=================
;874:BotAlreadySelected
;875:=================
;876:*/
;877:static qboolean BotAlreadySelected( const char *checkName ) {
line 880
;878:	int		n;
;879:
;880:	for( n = 1; n < PLAYER_SLOTS; n++ ) {
ADDRLP4 0
CNSTI4 1
ASGNI4
LABELV $519
line 881
;881:		if( s_serveroptions.playerType[n].curvalue != 1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 s_serveroptions+4068+64
ADDP4
INDIRI4
CNSTI4 1
EQI4 $523
line 882
;882:			continue;
ADDRGP4 $520
JUMPV
LABELV $523
line 884
;883:		}
;884:		if( (s_serveroptions.gametype >= GT_TEAM) &&
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 3
LTI4 $527
ADDRLP4 0
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 s_serveroptions+6084+64
ADDP4
INDIRI4
ADDRGP4 s_serveroptions+7736
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 s_serveroptions+6084+64
ADDP4
INDIRI4
EQI4 $527
line 885
;885:			(s_serveroptions.playerTeam[n].curvalue != s_serveroptions.playerTeam[s_serveroptions.newBotIndex].curvalue ) ) {
line 886
;886:			continue;
ADDRGP4 $520
JUMPV
LABELV $527
line 888
;887:		}
;888:		if( Q_stricmp( checkName, s_serveroptions.playerNameBuffers[n] ) == 0 ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 s_serveroptions+7540
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $535
line 889
;889:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $518
JUMPV
LABELV $535
line 891
;890:		}
;891:	}
LABELV $520
line 880
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 12
LTI4 $519
line 893
;892:
;893:	return qfalse;
CNSTI4 0
RETI4
LABELV $518
endproc BotAlreadySelected 8 8
proc ServerOptions_Start 352 24
line 902
;894:}
;895:
;896:
;897:/*
;898:=================
;899:ServerOptions_Start
;900:=================
;901:*/
;902:static void ServerOptions_Start( void ) {
line 940
;903:	int		timelimit;
;904:	int		fraglimit;
;905:	int		respawndelay;	// JUHOX
;906:	int		respawnAtPOD;	// JUHOX
;907:	int		tss;			// JUHOX
;908:	int		tssSafetyMode;	// JUHOX
;909:	int		armorFragments;	// JUHOX
;910:	int		maxclients;
;911:	int		dedicated;
;912:	int		friendlyfire;
;913:	int		flaglimit;
;914:	int		pure;
;915:	int		skill;
;916:	int		additionalSlots;	// JUHOX
;917:	int		gameseed;			// JUHOX
;918:#if MEETING
;919:	int		meeting;			// JUHOX
;920:#endif
;921:	int		noItems;			// JUHOX
;922:	int		noHealthRegen;		// JUHOX
;923:	int		unlimitedAmmo;		// JUHOX
;924:	int		cloakingDevice;		// JUHOX
;925:	int		weaponLimit;		// JUHOX
;926:#if MONSTER_MODE
;927:	qboolean monsterLauncher;	// JUHOX
;928:	int		maxMonsters;		// JUHOX
;929:	int		maxMonstersPP;		// JUHOX
;930:	int		minMonsters;		// JUHOX
;931:	int		monsterHealth;		// JUHOX
;932:	char*	monsterModel1;		// JUHOX
;933:	char*	monsterModel2;		// JUHOX
;934:	char*	monsterModel3;		// JUHOX
;935:#endif
;936:	int		n;
;937:	char	buf[64];
;938:
;939:
;940:	timelimit	 = atoi( s_serveroptions.timelimit.field.buffer );
ADDRGP4 s_serveroptions+768+60+12
ARGP4
ADDRLP4 184
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 76
ADDRLP4 184
INDIRI4
ASGNI4
line 941
;941:	fraglimit	 = atoi( s_serveroptions.fraglimit.field.buffer );
ADDRGP4 s_serveroptions+1100+60+12
ARGP4
ADDRLP4 188
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 80
ADDRLP4 188
INDIRI4
ASGNI4
line 942
;942:	flaglimit	 = atoi( s_serveroptions.flaglimit.field.buffer );
ADDRGP4 s_serveroptions+1432+60+12
ARGP4
ADDRLP4 192
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 84
ADDRLP4 192
INDIRI4
ASGNI4
line 943
;943:	respawndelay = s_serveroptions.respawnDelay;	// JUHOX
ADDRLP4 132
ADDRGP4 s_serveroptions+2564
INDIRI4
ASGNI4
line 944
;944:	respawnAtPOD = s_serveroptions.respawnAtPOD;	// JUHOX
ADDRLP4 152
ADDRGP4 s_serveroptions+2568
INDIRI4
ASGNI4
line 945
;945:	tss			 = s_serveroptions.tss;	// JUHOX
ADDRLP4 96
ADDRGP4 s_serveroptions+2572
INDIRI4
ASGNI4
line 946
;946:	tssSafetyMode = s_serveroptions.tssSafetyMode;	// JUHOX
ADDRLP4 156
ADDRGP4 s_serveroptions+2576
INDIRI4
ASGNI4
line 947
;947:	armorFragments = s_serveroptions.armorFragments;	// JUHOX
ADDRLP4 160
ADDRGP4 s_serveroptions+2580
INDIRI4
ASGNI4
line 948
;948:	dedicated	 = s_serveroptions.dedicated.curvalue;
ADDRLP4 88
ADDRGP4 s_serveroptions+672+64
INDIRI4
ASGNI4
line 949
;949:	friendlyfire = s_serveroptions.friendlyfire.curvalue;
ADDRLP4 140
ADDRGP4 s_serveroptions+2428+60
INDIRI4
ASGNI4
line 950
;950:	pure		 = s_serveroptions.pure.curvalue;
ADDRLP4 164
ADDRGP4 s_serveroptions+3108+60
INDIRI4
ASGNI4
line 951
;951:	skill		 = s_serveroptions.botSkill.curvalue + 1;
ADDRLP4 72
ADDRGP4 s_serveroptions+3172+64
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 952
;952:	additionalSlots = atoi(s_serveroptions.additionalSlots.field.buffer);	// JUHOX
ADDRGP4 s_serveroptions+3268+60+12
ARGP4
ADDRLP4 196
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 92
ADDRLP4 196
INDIRI4
ASGNI4
line 953
;953:	gameseed = atoi(s_serveroptions.gameseed.field.buffer) & 0xffff;	// JUHOX
ADDRGP4 s_serveroptions+3600+60+12
ARGP4
ADDRLP4 200
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 100
ADDRLP4 200
INDIRI4
CNSTI4 65535
BANDI4
ASGNI4
line 955
;954:#if MEETING
;955:	meeting = s_serveroptions.meeting.curvalue;	// JUHOX
ADDRLP4 148
ADDRGP4 s_serveroptions+3932+60
INDIRI4
ASGNI4
line 957
;956:#endif
;957:	noItems = s_serveroptions.noItems;	// JUHOX
ADDRLP4 104
ADDRGP4 s_serveroptions+2600
INDIRI4
ASGNI4
line 958
;958:	noHealthRegen = s_serveroptions.noHealthRegen;	// JUHOX
ADDRLP4 108
ADDRGP4 s_serveroptions+2604
INDIRI4
ASGNI4
line 959
;959:	unlimitedAmmo = s_serveroptions.unlimitedAmmo;	// JUHOX
ADDRLP4 112
ADDRGP4 s_serveroptions+2608
INDIRI4
ASGNI4
line 960
;960:	cloakingDevice = s_serveroptions.cloakingDevice;	// JUHOX
ADDRLP4 116
ADDRGP4 s_serveroptions+2612
INDIRI4
ASGNI4
line 961
;961:	weaponLimit = s_serveroptions.weaponLimit;	// JUHOX
ADDRLP4 120
ADDRGP4 s_serveroptions+2616
INDIRI4
ASGNI4
line 963
;962:#if MONSTER_MODE
;963:	monsterLauncher = Com_Clamp(0, 1, s_serveroptions.monsterLauncher);	// JUHOX
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 s_serveroptions+2620
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 204
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRLP4 124
ADDRLP4 204
INDIRF4
CVFI4 4
ASGNI4
line 964
;964:	maxMonstersPP = Com_Clamp(1, MAX_MONSTERS, s_serveroptions.maxMonstersPerPlayer);	// JUHOX
CNSTF4 1065353216
ARGF4
CNSTF4 1128792064
ARGF4
ADDRGP4 s_serveroptions+2632
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 208
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRLP4 144
ADDRLP4 208
INDIRF4
CVFI4 4
ASGNI4
line 965
;965:	maxMonsters = Com_Clamp(1, MAX_MONSTERS, s_serveroptions.maxMonsters);	// JUHOX
CNSTF4 1065353216
ARGF4
CNSTF4 1128792064
ARGF4
ADDRGP4 s_serveroptions+2628
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 212
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRLP4 136
ADDRLP4 212
INDIRF4
CVFI4 4
ASGNI4
line 966
;966:	minMonsters = Com_Clamp(0, MAX_MONSTERS, s_serveroptions.minMonsters);	// JUHOX
CNSTF4 0
ARGF4
CNSTF4 1128792064
ARGF4
ADDRGP4 s_serveroptions+2624
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 216
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRLP4 180
ADDRLP4 216
INDIRF4
CVFI4 4
ASGNI4
line 967
;967:	monsterHealth = Com_Clamp(1, 1000, s_serveroptions.monsterHealthScale);	// JUHOX
CNSTF4 1065353216
ARGF4
CNSTF4 1148846080
ARGF4
ADDRGP4 s_serveroptions+2652
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 220
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRLP4 128
ADDRLP4 220
INDIRF4
CVFI4 4
ASGNI4
line 968
;968:	monsterModel1 = s_serveroptions.monsterModel1;	// JUHOX
ADDRLP4 168
ADDRGP4 s_serveroptions+2664
ASGNP4
line 969
;969:	monsterModel2 = s_serveroptions.monsterModel2;	// JUHOX
ADDRLP4 172
ADDRGP4 s_serveroptions+2696
ASGNP4
line 970
;970:	monsterModel3 = s_serveroptions.monsterModel3;	// JUHOX
ADDRLP4 176
ADDRGP4 s_serveroptions+2728
ASGNP4
line 974
;971:#endif
;972:
;973:	//set maxclients
;974:	for( n = 0, maxclients = 0; n < PLAYER_SLOTS; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRLP4 68
CNSTI4 0
ASGNI4
ADDRGP4 $585
JUMPV
LABELV $582
line 975
;975:		if( s_serveroptions.playerType[n].curvalue == 2 ) {
ADDRLP4 0
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 s_serveroptions+4068+64
ADDP4
INDIRI4
CNSTI4 2
NEI4 $586
line 976
;976:			continue;
ADDRGP4 $583
JUMPV
LABELV $586
line 978
;977:		}
;978:		if( (s_serveroptions.playerType[n].curvalue == 1) && (s_serveroptions.playerNameBuffers[n][0] == 0) ) {
ADDRLP4 0
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 s_serveroptions+4068+64
ADDP4
INDIRI4
CNSTI4 1
NEI4 $590
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 s_serveroptions+7540
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $590
line 979
;979:			continue;
ADDRGP4 $583
JUMPV
LABELV $590
line 981
;980:		}
;981:		maxclients++;
ADDRLP4 68
ADDRLP4 68
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 982
;982:	}
LABELV $583
line 974
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $585
ADDRLP4 0
INDIRI4
CNSTI4 12
LTI4 $582
line 983
;983:	maxclients += additionalSlots;	// JUHOX
ADDRLP4 68
ADDRLP4 68
INDIRI4
ADDRLP4 92
INDIRI4
ADDI4
ASGNI4
line 985
;984:
;985:	switch( s_serveroptions.gametype ) {
ADDRLP4 224
ADDRGP4 s_serveroptions+7504
INDIRI4
ASGNI4
ADDRLP4 224
INDIRI4
CNSTI4 0
LTI4 $595
ADDRLP4 224
INDIRI4
CNSTI4 9
GTI4 $595
ADDRLP4 224
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $748
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $748
address $598
address $613
address $595
address $627
address $644
address $595
address $595
address $595
address $661
address $711
code
LABELV $598
LABELV $595
line 988
;986:	case GT_FFA:
;987:	default:
;988:		trap_Cvar_SetValue( "ui_ffa_fraglimit", fraglimit );
ADDRGP4 $599
ARGP4
ADDRLP4 80
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 989
;989:		trap_Cvar_SetValue( "ui_ffa_timelimit", timelimit );
ADDRGP4 $600
ARGP4
ADDRLP4 76
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 990
;990:		trap_Cvar_SetValue("ui_ffa_respawndelay", respawndelay);	// JUHOX
ADDRGP4 $601
ARGP4
ADDRLP4 132
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 991
;991:		trap_Cvar_SetValue("ui_ffa_gameseed", gameseed);	// JUHOX
ADDRGP4 $602
ARGP4
ADDRLP4 100
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 992
;992:		tss = qfalse;
ADDRLP4 96
CNSTI4 0
ASGNI4
line 993
;993:		trap_Cvar_SetValue("ui_ffa_noItems", noItems);	// JUHOX
ADDRGP4 $603
ARGP4
ADDRLP4 104
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 994
;994:		trap_Cvar_SetValue("ui_ffa_noHealthRegen", noHealthRegen);	// JUHOX
ADDRGP4 $604
ARGP4
ADDRLP4 108
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 995
;995:		trap_Cvar_SetValue("ui_ffa_unlimitedAmmo", unlimitedAmmo);	// JUHOX
ADDRGP4 $605
ARGP4
ADDRLP4 112
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 996
;996:		trap_Cvar_SetValue("ui_ffa_cloakingDevice", cloakingDevice);	// JUHOX
ADDRGP4 $606
ARGP4
ADDRLP4 116
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 997
;997:		trap_Cvar_SetValue("ui_ffa_weaponLimit", weaponLimit);	// JUHOX
ADDRGP4 $607
ARGP4
ADDRLP4 120
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 999
;998:#if MONSTER_MODE
;999:		trap_Cvar_SetValue("ui_ffa_monsterLauncher", monsterLauncher);	// JUHOX
ADDRGP4 $608
ARGP4
ADDRLP4 124
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1000
;1000:		trap_Cvar_SetValue("ui_ffa_maxMonsters", maxMonsters);	// JUHOX
ADDRGP4 $609
ARGP4
ADDRLP4 136
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1001
;1001:		trap_Cvar_SetValue("ui_ffa_maxMonstersPP", maxMonstersPP);	// JUHOX
ADDRGP4 $610
ARGP4
ADDRLP4 144
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1002
;1002:		trap_Cvar_SetValue("ui_ffa_monsterHealthScale", monsterHealth);	// JUHOX
ADDRGP4 $611
ARGP4
ADDRLP4 128
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1005
;1003:#endif
;1004:#if MEETING
;1005:		trap_Cvar_SetValue("ui_ffa_meeting", meeting);	// JUHOX
ADDRGP4 $612
ARGP4
ADDRLP4 148
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1007
;1006:#endif
;1007:		break;
ADDRGP4 $596
JUMPV
LABELV $613
line 1010
;1008:
;1009:	case GT_TOURNAMENT:
;1010:		trap_Cvar_SetValue( "ui_tourney_fraglimit", fraglimit );
ADDRGP4 $614
ARGP4
ADDRLP4 80
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1011
;1011:		trap_Cvar_SetValue( "ui_tourney_timelimit", timelimit );
ADDRGP4 $615
ARGP4
ADDRLP4 76
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1012
;1012:		respawndelay = 0;	// JUHOX
ADDRLP4 132
CNSTI4 0
ASGNI4
line 1013
;1013:		trap_Cvar_SetValue("ui_tourney_gameseed", gameseed);	// JUHOX
ADDRGP4 $616
ARGP4
ADDRLP4 100
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1014
;1014:		tss = qfalse;
ADDRLP4 96
CNSTI4 0
ASGNI4
line 1015
;1015:		trap_Cvar_SetValue("ui_tourney_noItems", noItems);	// JUHOX
ADDRGP4 $617
ARGP4
ADDRLP4 104
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1016
;1016:		trap_Cvar_SetValue("ui_tourney_noHealthRegen", noHealthRegen);	// JUHOX
ADDRGP4 $618
ARGP4
ADDRLP4 108
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1017
;1017:		trap_Cvar_SetValue("ui_tourney_unlimitedAmmo", unlimitedAmmo);	// JUHOX
ADDRGP4 $619
ARGP4
ADDRLP4 112
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1018
;1018:		trap_Cvar_SetValue("ui_tourney_cloakingDevice", cloakingDevice);	// JUHOX
ADDRGP4 $620
ARGP4
ADDRLP4 116
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1019
;1019:		trap_Cvar_SetValue("ui_tourney_weaponLimit", weaponLimit);	// JUHOX
ADDRGP4 $621
ARGP4
ADDRLP4 120
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1021
;1020:#if MONSTER_MODE
;1021:		trap_Cvar_SetValue("ui_tourney_monsterLauncher", monsterLauncher);	// JUHOX
ADDRGP4 $622
ARGP4
ADDRLP4 124
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1022
;1022:		trap_Cvar_SetValue("ui_tourney_maxMonsters", maxMonsters);	// JUHOX
ADDRGP4 $623
ARGP4
ADDRLP4 136
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1023
;1023:		trap_Cvar_SetValue("ui_tourney_maxMonstersPP", maxMonstersPP);	// JUHOX
ADDRGP4 $624
ARGP4
ADDRLP4 144
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1024
;1024:		trap_Cvar_SetValue("ui_tourney_monsterHealthScale", monsterHealth);	// JUHOX
ADDRGP4 $625
ARGP4
ADDRLP4 128
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1027
;1025:#endif
;1026:#if MEETING
;1027:		trap_Cvar_SetValue("ui_tourney_meeting", meeting);	// JUHOX
ADDRGP4 $626
ARGP4
ADDRLP4 148
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1029
;1028:#endif
;1029:		break;
ADDRGP4 $596
JUMPV
LABELV $627
line 1032
;1030:
;1031:	case GT_TEAM:
;1032:		trap_Cvar_SetValue( "ui_team_fraglimit", fraglimit );
ADDRGP4 $628
ARGP4
ADDRLP4 80
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1033
;1033:		trap_Cvar_SetValue( "ui_team_timelimit", timelimit );
ADDRGP4 $629
ARGP4
ADDRLP4 76
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1034
;1034:		trap_Cvar_SetValue( "ui_team_friendly", friendlyfire );	// JUHOX BUGFIX: was "ui_team_friendlt"
ADDRGP4 $630
ARGP4
ADDRLP4 140
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1035
;1035:		trap_Cvar_SetValue("ui_team_respawndelay", respawndelay);	// JUHOX
ADDRGP4 $631
ARGP4
ADDRLP4 132
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1036
;1036:		trap_Cvar_SetValue("ui_team_gameseed", gameseed);	// JUHOX
ADDRGP4 $632
ARGP4
ADDRLP4 100
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1037
;1037:		trap_Cvar_SetValue("ui_team_tss", tss);	// JUHOX
ADDRGP4 $633
ARGP4
ADDRLP4 96
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1038
;1038:		trap_Cvar_SetValue("ui_team_noItems", noItems);	// JUHOX
ADDRGP4 $634
ARGP4
ADDRLP4 104
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1039
;1039:		trap_Cvar_SetValue("ui_team_noHealthRegen", noHealthRegen);	// JUHOX
ADDRGP4 $635
ARGP4
ADDRLP4 108
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1040
;1040:		trap_Cvar_SetValue("ui_team_unlimitedAmmo", unlimitedAmmo);	// JUHOX
ADDRGP4 $636
ARGP4
ADDRLP4 112
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1041
;1041:		trap_Cvar_SetValue("ui_team_cloakingDevice", cloakingDevice);	// JUHOX
ADDRGP4 $637
ARGP4
ADDRLP4 116
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1042
;1042:		trap_Cvar_SetValue("ui_team_weaponLimit", weaponLimit);	// JUHOX
ADDRGP4 $638
ARGP4
ADDRLP4 120
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1044
;1043:#if MONSTER_MODE
;1044:		trap_Cvar_SetValue("ui_team_monsterLauncher", monsterLauncher);	// JUHOX
ADDRGP4 $639
ARGP4
ADDRLP4 124
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1045
;1045:		trap_Cvar_SetValue("ui_team_maxMonsters", maxMonsters);	// JUHOX
ADDRGP4 $640
ARGP4
ADDRLP4 136
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1046
;1046:		trap_Cvar_SetValue("ui_team_maxMonstersPP", maxMonstersPP);	// JUHOX
ADDRGP4 $641
ARGP4
ADDRLP4 144
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1047
;1047:		trap_Cvar_SetValue("ui_team_monsterHealthScale", monsterHealth);	// JUHOX
ADDRGP4 $642
ARGP4
ADDRLP4 128
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1050
;1048:#endif
;1049:#if MEETING
;1050:		trap_Cvar_SetValue("ui_team_meeting", meeting);	// JUHOX
ADDRGP4 $643
ARGP4
ADDRLP4 148
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1052
;1051:#endif
;1052:		break;
ADDRGP4 $596
JUMPV
LABELV $644
line 1055
;1053:
;1054:	case GT_CTF:
;1055:		trap_Cvar_SetValue( "ui_ctf_capturelimit", flaglimit );	// JUHOX BUGFIX: was "ui_ctf_fraglimit" and 'fraglimit'
ADDRGP4 $645
ARGP4
ADDRLP4 84
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1056
;1056:		trap_Cvar_SetValue( "ui_ctf_timelimit", timelimit );
ADDRGP4 $646
ARGP4
ADDRLP4 76
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1057
;1057:		trap_Cvar_SetValue( "ui_ctf_friendly", friendlyfire );	// JUHOX BUGFIX: was "ui_ctf_friendlt"
ADDRGP4 $647
ARGP4
ADDRLP4 140
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1058
;1058:		trap_Cvar_SetValue("ui_ctf_respawndelay", respawndelay);	// JUHOX
ADDRGP4 $648
ARGP4
ADDRLP4 132
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1059
;1059:		trap_Cvar_SetValue("ui_ctf_gameseed", gameseed);	// JUHOX
ADDRGP4 $649
ARGP4
ADDRLP4 100
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1060
;1060:		trap_Cvar_SetValue("ui_ctf_tss", tss);	// JUHOX
ADDRGP4 $650
ARGP4
ADDRLP4 96
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1061
;1061:		trap_Cvar_SetValue("ui_ctf_noItems", noItems);	// JUHOX
ADDRGP4 $651
ARGP4
ADDRLP4 104
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1062
;1062:		trap_Cvar_SetValue("ui_ctf_noHealthRegen", noHealthRegen);	// JUHOX
ADDRGP4 $652
ARGP4
ADDRLP4 108
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1063
;1063:		trap_Cvar_SetValue("ui_ctf_unlimitedAmmo", unlimitedAmmo);	// JUHOX
ADDRGP4 $653
ARGP4
ADDRLP4 112
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1064
;1064:		trap_Cvar_SetValue("ui_ctf_cloakingDevice", cloakingDevice);	// JUHOX
ADDRGP4 $654
ARGP4
ADDRLP4 116
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1065
;1065:		trap_Cvar_SetValue("ui_ctf_weaponLimit", weaponLimit);	// JUHOX
ADDRGP4 $655
ARGP4
ADDRLP4 120
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1067
;1066:#if MONSTER_MODE
;1067:		trap_Cvar_SetValue("ui_ctf_monsterLauncher", monsterLauncher);	// JUHOX
ADDRGP4 $656
ARGP4
ADDRLP4 124
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1068
;1068:		trap_Cvar_SetValue("ui_ctf_maxMonsters", maxMonsters);	// JUHOX
ADDRGP4 $657
ARGP4
ADDRLP4 136
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1069
;1069:		trap_Cvar_SetValue("ui_ctf_maxMonstersPP", maxMonstersPP);	// JUHOX
ADDRGP4 $658
ARGP4
ADDRLP4 144
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1070
;1070:		trap_Cvar_SetValue("ui_ctf_monsterHealthScale", monsterHealth);	// JUHOX
ADDRGP4 $659
ARGP4
ADDRLP4 128
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1073
;1071:#endif
;1072:#if MEETING
;1073:		trap_Cvar_SetValue("ui_ctf_meeting", meeting);	// JUHOX
ADDRGP4 $660
ARGP4
ADDRLP4 148
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1075
;1074:#endif
;1075:		break;
ADDRGP4 $596
JUMPV
LABELV $661
line 1079
;1076:
;1077:#if MONSTER_MODE	// JUHOX: set STU ui cvars
;1078:	case GT_STU:
;1079:		trap_Cvar_SetValue("ui_stu_fraglimit", fraglimit);
ADDRGP4 $662
ARGP4
ADDRLP4 80
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1080
;1080:		trap_Cvar_SetValue("ui_stu_timelimit", timelimit);
ADDRGP4 $663
ARGP4
ADDRLP4 76
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1081
;1081:		trap_Cvar_SetValue("ui_stu_friendly", friendlyfire);
ADDRGP4 $664
ARGP4
ADDRLP4 140
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1082
;1082:		trap_Cvar_SetValue("ui_stu_respawndelay", respawndelay);
ADDRGP4 $665
ARGP4
ADDRLP4 132
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1083
;1083:		trap_Cvar_SetValue("ui_stu_gameseed", gameseed);
ADDRGP4 $666
ARGP4
ADDRLP4 100
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1085
;1084:		//trap_Cvar_SetValue("ui_stu_tss", tss);
;1085:		tss = qfalse;
ADDRLP4 96
CNSTI4 0
ASGNI4
line 1086
;1086:		monsterLauncher = qfalse;
ADDRLP4 124
CNSTI4 0
ASGNI4
line 1087
;1087:		trap_Cvar_SetValue("ui_stu_noItems", noItems);
ADDRGP4 $667
ARGP4
ADDRLP4 104
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1088
;1088:		trap_Cvar_SetValue("ui_stu_noHealthRegen", noHealthRegen);
ADDRGP4 $668
ARGP4
ADDRLP4 108
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1089
;1089:		trap_Cvar_SetValue("ui_stu_unlimitedAmmo", unlimitedAmmo);
ADDRGP4 $669
ARGP4
ADDRLP4 112
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1090
;1090:		trap_Cvar_SetValue("ui_stu_cloakingDevice", cloakingDevice);
ADDRGP4 $670
ARGP4
ADDRLP4 116
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1091
;1091:		trap_Cvar_SetValue("ui_stu_weaponLimit", weaponLimit);
ADDRGP4 $671
ARGP4
ADDRLP4 120
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1093
;1092:
;1093:		trap_Cvar_SetValue("ui_stu_maxMonsters", maxMonsters);
ADDRGP4 $672
ARGP4
ADDRLP4 136
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1095
;1094:
;1095:		trap_Cvar_SetValue("ui_stu_minMonsters", minMonsters);
ADDRGP4 $673
ARGP4
ADDRLP4 180
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1096
;1096:		trap_Cvar_SetValue("g_minMonsters", minMonsters);
ADDRGP4 $674
ARGP4
ADDRLP4 180
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1098
;1097:
;1098:		trap_Cvar_SetValue("ui_stu_monstersPerTrap", Com_Clamp(0, MAX_MONSTERS, s_serveroptions.monstersPerTrap));
CNSTF4 0
ARGF4
CNSTF4 1128792064
ARGF4
ADDRGP4 s_serveroptions+2636
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 228
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $675
ARGP4
ADDRLP4 228
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1099
;1099:		trap_Cvar_SetValue("g_monstersPerTrap", Com_Clamp(0, MAX_MONSTERS, s_serveroptions.monstersPerTrap));
CNSTF4 0
ARGF4
CNSTF4 1128792064
ARGF4
ADDRGP4 s_serveroptions+2636
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 232
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $677
ARGP4
ADDRLP4 232
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1101
;1100:
;1101:		trap_Cvar_SetValue("ui_stu_monsterSpawnDelay", Com_Clamp(200, 999999, s_serveroptions.monsterSpawnDelay));
CNSTF4 1128792064
ARGF4
CNSTF4 1232348144
ARGF4
ADDRGP4 s_serveroptions+2640
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 236
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $679
ARGP4
ADDRLP4 236
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1102
;1102:		trap_Cvar_SetValue("g_monsterSpawnDelay", Com_Clamp(200, 999999, s_serveroptions.monsterSpawnDelay));
CNSTF4 1128792064
ARGF4
CNSTF4 1232348144
ARGF4
ADDRGP4 s_serveroptions+2640
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 240
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $681
ARGP4
ADDRLP4 240
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1104
;1103:
;1104:		trap_Cvar_SetValue("ui_stu_monsterHealthScale", monsterHealth);
ADDRGP4 $683
ARGP4
ADDRLP4 128
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1106
;1105:
;1106:		trap_Cvar_SetValue("ui_stu_monsterProgression", Com_Clamp(0, 1000, s_serveroptions.monsterProgression));
CNSTF4 0
ARGF4
CNSTF4 1148846080
ARGF4
ADDRGP4 s_serveroptions+2656
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 244
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $684
ARGP4
ADDRLP4 244
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1107
;1107:		trap_Cvar_SetValue("g_monsterProgression", Com_Clamp(0, 1000, s_serveroptions.monsterProgression));
CNSTF4 0
ARGF4
CNSTF4 1148846080
ARGF4
ADDRGP4 s_serveroptions+2656
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 248
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $686
ARGP4
ADDRLP4 248
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1109
;1108:
;1109:		trap_Cvar_SetValue("ui_stu_monsterGuards", Com_Clamp(0, 100, s_serveroptions.monsterGuards));
CNSTF4 0
ARGF4
CNSTF4 1120403456
ARGF4
ADDRGP4 s_serveroptions+2644
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 252
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $688
ARGP4
ADDRLP4 252
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1110
;1110:		trap_Cvar_SetValue("g_monsterGuards", Com_Clamp(0, 100, s_serveroptions.monsterGuards));
CNSTF4 0
ARGF4
CNSTF4 1120403456
ARGF4
ADDRGP4 s_serveroptions+2644
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 256
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $690
ARGP4
ADDRLP4 256
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1112
;1111:
;1112:		trap_Cvar_SetValue("ui_stu_monsterTitans", Com_Clamp(0, 100, s_serveroptions.monsterTitans));
CNSTF4 0
ARGF4
CNSTF4 1120403456
ARGF4
ADDRGP4 s_serveroptions+2648
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 260
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $692
ARGP4
ADDRLP4 260
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1113
;1113:		trap_Cvar_SetValue("g_monsterTitans", Com_Clamp(0, 100, s_serveroptions.monsterTitans));
CNSTF4 0
ARGF4
CNSTF4 1120403456
ARGF4
ADDRGP4 s_serveroptions+2648
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 264
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $694
ARGP4
ADDRLP4 264
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1115
;1114:
;1115:		trap_Cvar_SetValue("ui_stu_monsterBreeding", Com_Clamp(0, 1, s_serveroptions.monsterBreeding));
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 s_serveroptions+2660
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 268
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $696
ARGP4
ADDRLP4 268
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1116
;1116:		trap_Cvar_SetValue("g_monsterBreeding", Com_Clamp(0, 1, s_serveroptions.monsterBreeding));
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 s_serveroptions+2660
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 272
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $698
ARGP4
ADDRLP4 272
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1118
;1117:
;1118:		trap_Cvar_SetValue("ui_stu_artefacts", Com_Clamp(0, 999, atoi(s_serveroptions.artefacts.field.buffer)));
ADDRGP4 s_serveroptions+1764+60+12
ARGP4
ADDRLP4 276
ADDRGP4 atoi
CALLI4
ASGNI4
CNSTF4 0
ARGF4
CNSTF4 1148829696
ARGF4
ADDRLP4 276
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 280
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $700
ARGP4
ADDRLP4 280
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1119
;1119:		trap_Cvar_SetValue("g_artefacts", Com_Clamp(0, 999, atoi(s_serveroptions.artefacts.field.buffer)));
ADDRGP4 s_serveroptions+1764+60+12
ARGP4
ADDRLP4 284
ADDRGP4 atoi
CALLI4
ASGNI4
CNSTF4 0
ARGF4
CNSTF4 1148829696
ARGF4
ADDRLP4 284
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 288
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $704
ARGP4
ADDRLP4 288
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1121
;1120:
;1121:		trap_Cvar_SetValue("g_skipEndSequence", Com_Clamp(0, 1, s_serveroptions.skipEndSequence));
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 s_serveroptions+2760
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 292
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $708
ARGP4
ADDRLP4 292
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1123
;1122:#if MEETING
;1123:		trap_Cvar_SetValue("ui_stu_meeting", meeting);	// JUHOX
ADDRGP4 $710
ARGP4
ADDRLP4 148
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1125
;1124:#endif
;1125:		break;
ADDRGP4 $596
JUMPV
LABELV $711
line 1130
;1126:#endif
;1127:
;1128:#if ESCAPE_MODE	// JUHOX: set EFH ui cvars
;1129:	case GT_EFH:
;1130:		trap_Cvar_SetValue("ui_efh_fraglimit", fraglimit);
ADDRGP4 $712
ARGP4
ADDRLP4 80
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1131
;1131:		trap_Cvar_SetValue("ui_efh_timelimit", timelimit);
ADDRGP4 $713
ARGP4
ADDRLP4 76
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1132
;1132:		trap_Cvar_SetValue("ui_efh_distancelimit", (int)(1000.0 * Com_Clamp(0, 100, atof(s_serveroptions.distanceLimit.field.buffer))));
ADDRGP4 s_serveroptions+2096+60+12
ARGP4
ADDRLP4 296
ADDRGP4 atof
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1120403456
ARGF4
ADDRLP4 296
INDIRF4
ARGF4
ADDRLP4 300
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $714
ARGP4
ADDRLP4 300
INDIRF4
CNSTF4 1148846080
MULF4
CVFI4 4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1133
;1133:		trap_Cvar_SetValue("distancelimit", (int)(1000.0 * Com_Clamp(0, 100, atof(s_serveroptions.distanceLimit.field.buffer))));
ADDRGP4 s_serveroptions+2096+60+12
ARGP4
ADDRLP4 304
ADDRGP4 atof
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1120403456
ARGF4
ADDRLP4 304
INDIRF4
ARGF4
ADDRLP4 308
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $718
ARGP4
ADDRLP4 308
INDIRF4
CNSTF4 1148846080
MULF4
CVFI4 4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1134
;1134:		trap_Cvar_SetValue("ui_efh_friendly", friendlyfire);
ADDRGP4 $722
ARGP4
ADDRLP4 140
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1135
;1135:		trap_Cvar_SetValue("ui_efh_gameseed", gameseed);
ADDRGP4 $723
ARGP4
ADDRLP4 100
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1136
;1136:		tss = qfalse;
ADDRLP4 96
CNSTI4 0
ASGNI4
line 1137
;1137:		monsterLauncher = qfalse;
ADDRLP4 124
CNSTI4 0
ASGNI4
line 1138
;1138:		trap_Cvar_SetValue("ui_efh_noItems", noItems);
ADDRGP4 $724
ARGP4
ADDRLP4 104
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1139
;1139:		trap_Cvar_SetValue("ui_efh_noHealthRegen", noHealthRegen);
ADDRGP4 $725
ARGP4
ADDRLP4 108
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1140
;1140:		trap_Cvar_SetValue("ui_efh_unlimitedAmmo", unlimitedAmmo);
ADDRGP4 $726
ARGP4
ADDRLP4 112
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1141
;1141:		trap_Cvar_SetValue("ui_efh_cloakingDevice", cloakingDevice);
ADDRGP4 $727
ARGP4
ADDRLP4 116
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1142
;1142:		trap_Cvar_SetValue("ui_efh_weaponLimit", weaponLimit);
ADDRGP4 $728
ARGP4
ADDRLP4 120
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1144
;1143:
;1144:		trap_Cvar_SetValue("ui_efh_monsterLoad", (int)Com_Clamp(0, 1000, s_serveroptions.monsterLoad));
CNSTF4 0
ARGF4
CNSTF4 1148846080
ARGF4
ADDRGP4 s_serveroptions+2768
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 312
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $729
ARGP4
ADDRLP4 312
INDIRF4
CVFI4 4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1145
;1145:		trap_Cvar_SetValue("g_monsterLoad", (int)Com_Clamp(0, 1000, s_serveroptions.monsterLoad));
CNSTF4 0
ARGF4
CNSTF4 1148846080
ARGF4
ADDRGP4 s_serveroptions+2768
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 316
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $731
ARGP4
ADDRLP4 316
INDIRF4
CVFI4 4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1147
;1146:
;1147:		trap_Cvar_SetValue("ui_efh_challengingEnv", (int)Com_Clamp(0, 1, s_serveroptions.challengingEnv));
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 s_serveroptions+2772
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 320
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $733
ARGP4
ADDRLP4 320
INDIRF4
CVFI4 4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1148
;1148:		trap_Cvar_SetValue("g_challengingEnv", (int)Com_Clamp(0, 1, s_serveroptions.challengingEnv));
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 s_serveroptions+2772
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 324
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $735
ARGP4
ADDRLP4 324
INDIRF4
CVFI4 4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1150
;1149:
;1150:		trap_Cvar_SetValue("ui_efh_monsterGuards", Com_Clamp(0, 100, s_serveroptions.monsterGuards));
CNSTF4 0
ARGF4
CNSTF4 1120403456
ARGF4
ADDRGP4 s_serveroptions+2644
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 328
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $737
ARGP4
ADDRLP4 328
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1151
;1151:		trap_Cvar_SetValue("g_monsterGuards", Com_Clamp(0, 100, s_serveroptions.monsterGuards));
CNSTF4 0
ARGF4
CNSTF4 1120403456
ARGF4
ADDRGP4 s_serveroptions+2644
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 332
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $690
ARGP4
ADDRLP4 332
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1153
;1152:
;1153:		trap_Cvar_SetValue("ui_efh_monsterTitans", Com_Clamp(0, 100, s_serveroptions.monsterTitans));
CNSTF4 0
ARGF4
CNSTF4 1120403456
ARGF4
ADDRGP4 s_serveroptions+2648
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 336
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $740
ARGP4
ADDRLP4 336
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1154
;1154:		trap_Cvar_SetValue("g_monsterTitans", Com_Clamp(0, 100, s_serveroptions.monsterTitans));
CNSTF4 0
ARGF4
CNSTF4 1120403456
ARGF4
ADDRGP4 s_serveroptions+2648
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 340
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $694
ARGP4
ADDRLP4 340
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1156
;1155:
;1156:		trap_Cvar_SetValue("ui_efh_monsterHealthScale", monsterHealth);
ADDRGP4 $743
ARGP4
ADDRLP4 128
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1158
;1157:
;1158:		trap_Cvar_SetValue("ui_efh_monsterProgression", Com_Clamp(0, 1000, s_serveroptions.monsterProgression));
CNSTF4 0
ARGF4
CNSTF4 1148846080
ARGF4
ADDRGP4 s_serveroptions+2656
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 344
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $744
ARGP4
ADDRLP4 344
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1159
;1159:		trap_Cvar_SetValue("g_monsterProgression", Com_Clamp(0, 1000, s_serveroptions.monsterProgression));
CNSTF4 0
ARGF4
CNSTF4 1148846080
ARGF4
ADDRGP4 s_serveroptions+2656
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 348
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $686
ARGP4
ADDRLP4 348
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1161
;1160:#if MEETING
;1161:		trap_Cvar_SetValue("ui_efh_meeting", meeting);	// JUHOX
ADDRGP4 $747
ARGP4
ADDRLP4 148
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1163
;1162:#endif
;1163:		break;
LABELV $596
line 1168
;1164:#endif
;1165:	}
;1166:
;1167:#if MONSTER_MODE	// JUHOX: cvars (also) needed for monster launcher/efh
;1168:	trap_Cvar_SetValue("g_monsterLauncher", monsterLauncher);
ADDRGP4 $749
ARGP4
ADDRLP4 124
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1169
;1169:	trap_Cvar_SetValue("g_maxMonsters", maxMonsters);
ADDRGP4 $750
ARGP4
ADDRLP4 136
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1170
;1170:	trap_Cvar_SetValue("g_maxMonstersPP", maxMonstersPP);
ADDRGP4 $751
ARGP4
ADDRLP4 144
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1171
;1171:	trap_Cvar_SetValue("g_monsterHealthScale", monsterHealth);
ADDRGP4 $752
ARGP4
ADDRLP4 128
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1172
;1172:	trap_Cvar_Set("monsterModel1", monsterModel1);
ADDRGP4 $753
ARGP4
ADDRLP4 168
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1173
;1173:	trap_Cvar_Set("monsterModel2", monsterModel2);
ADDRGP4 $754
ARGP4
ADDRLP4 172
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1174
;1174:	trap_Cvar_Set("monsterModel3", monsterModel3);
ADDRGP4 $755
ARGP4
ADDRLP4 176
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1175
;1175:	trap_Cvar_SetValue("g_scoreMode", Com_Clamp(0, 1, s_serveroptions.scoreMode));	// JUHOX
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 s_serveroptions+2764
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 228
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $756
ARGP4
ADDRLP4 228
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1178
;1176:#endif
;1177:
;1178:	trap_Cvar_SetValue("g_armorFragments", Com_Clamp(0, 1, armorFragments));	// JUHOX
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 160
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 232
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $758
ARGP4
ADDRLP4 232
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1179
;1179:	trap_Cvar_SetValue("ui_additionalSlots", Com_Clamp(0, MAX_CLIENTS, additionalSlots));	// JUHOX
CNSTF4 0
ARGF4
CNSTF4 1115684864
ARGF4
ADDRLP4 92
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 236
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $759
ARGP4
ADDRLP4 236
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1180
;1180:	trap_Cvar_SetValue( "sv_maxclients", Com_Clamp( 0, /*12*/MAX_CLIENTS, maxclients ) );	// JUHOX
CNSTF4 0
ARGF4
CNSTF4 1115684864
ARGF4
ADDRLP4 68
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 240
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $760
ARGP4
ADDRLP4 240
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1181
;1181:	trap_Cvar_SetValue( "dedicated", Com_Clamp( 0, 2, dedicated ) );
CNSTF4 0
ARGF4
CNSTF4 1073741824
ARGF4
ADDRLP4 88
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 244
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $761
ARGP4
ADDRLP4 244
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1183
;1182:#if MAPLENSFLARES	// JUHOX: reset edit mode
;1183:	trap_Cvar_SetValue("g_editmode", 0);
ADDRGP4 $762
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1185
;1184:#endif
;1185:	trap_Cvar_SetValue ("timelimit", Com_Clamp( 0, timelimit, timelimit ) );
CNSTF4 0
ARGF4
ADDRLP4 248
ADDRLP4 76
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 248
INDIRF4
ARGF4
ADDRLP4 248
INDIRF4
ARGF4
ADDRLP4 252
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $763
ARGP4
ADDRLP4 252
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1186
;1186:	trap_Cvar_SetValue ("fraglimit", Com_Clamp( 0, fraglimit, fraglimit ) );
CNSTF4 0
ARGF4
ADDRLP4 256
ADDRLP4 80
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 256
INDIRF4
ARGF4
ADDRLP4 256
INDIRF4
ARGF4
ADDRLP4 260
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $764
ARGP4
ADDRLP4 260
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1187
;1187:	trap_Cvar_SetValue ("capturelimit", Com_Clamp( 0, flaglimit, flaglimit ) );
CNSTF4 0
ARGF4
ADDRLP4 264
ADDRLP4 84
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 264
INDIRF4
ARGF4
ADDRLP4 264
INDIRF4
ARGF4
ADDRLP4 268
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $765
ARGP4
ADDRLP4 268
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1188
;1188:	trap_Cvar_SetValue( "respawnDelay", Com_Clamp( 0, 999, respawndelay ) );	// JUHOX
CNSTF4 0
ARGF4
CNSTF4 1148829696
ARGF4
ADDRLP4 132
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 272
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $766
ARGP4
ADDRLP4 272
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1189
;1189:	trap_Cvar_SetValue( "respawnAtPOD", respawnAtPOD );	// JUHOX
ADDRGP4 $767
ARGP4
ADDRLP4 152
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1190
;1190:	trap_Cvar_SetValue("tss", tss);	// JUHOX
ADDRGP4 $768
ARGP4
ADDRLP4 96
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1191
;1191:	trap_Cvar_SetValue("tssSafetyModeAllowed", tssSafetyMode);	// JUHOX
ADDRGP4 $769
ARGP4
ADDRLP4 156
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1192
;1192:	trap_Cvar_SetValue("g_stamina", s_serveroptions.stamina);	// JUHOX
ADDRGP4 $770
ARGP4
ADDRGP4 s_serveroptions+2584
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1193
;1193:	trap_Cvar_SetValue("g_baseHealth", s_serveroptions.baseHealth);	// JUHOX
ADDRGP4 $772
ARGP4
ADDRGP4 s_serveroptions+2588
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1194
;1194:	trap_Cvar_SetValue("g_lightningDamageLimit", s_serveroptions.lightningDamageLimit);	// JUHOX
ADDRGP4 $774
ARGP4
ADDRGP4 s_serveroptions+2592
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1196
;1195:#if GRAPPLE_ROPE
;1196:	trap_Cvar_SetValue("g_grapple", s_serveroptions.grapple);	// JUHOX
ADDRGP4 $776
ARGP4
ADDRGP4 s_serveroptions+2596
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1198
;1197:#endif
;1198:	trap_Cvar_SetValue("g_noItems", noItems);	// JUHOX
ADDRGP4 $778
ARGP4
ADDRLP4 104
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1199
;1199:	trap_Cvar_SetValue("g_noHealthRegen", noHealthRegen);	// JUHOX
ADDRGP4 $779
ARGP4
ADDRLP4 108
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1200
;1200:	trap_Cvar_SetValue("g_unlimitedAmmo", unlimitedAmmo);	// JUHOX
ADDRGP4 $780
ARGP4
ADDRLP4 112
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1201
;1201:	trap_Cvar_SetValue("g_cloakingDevice", cloakingDevice);	// JUHOX
ADDRGP4 $781
ARGP4
ADDRLP4 116
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1202
;1202:	trap_Cvar_SetValue("g_weaponLimit", weaponLimit);	// JUHOX
ADDRGP4 $782
ARGP4
ADDRLP4 120
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1203
;1203:	trap_Cvar_SetValue( "g_friendlyfire", friendlyfire );
ADDRGP4 $783
ARGP4
ADDRLP4 140
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1204
;1204:	trap_Cvar_SetValue( "sv_pure", pure );
ADDRGP4 $784
ARGP4
ADDRLP4 164
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1205
;1205:	trap_Cvar_SetValue("g_gameSeed", gameseed);	// JUHOX
ADDRGP4 $785
ARGP4
ADDRLP4 100
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1207
;1206:#if MEETING	// JUHOX: set g_meeting
;1207:	if (s_serveroptions.multiplayer) {
ADDRGP4 s_serveroptions+7500
INDIRI4
CNSTI4 0
EQI4 $786
line 1208
;1208:		trap_Cvar_SetValue("g_meeting", meeting);
ADDRGP4 $789
ARGP4
ADDRLP4 148
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1209
;1209:	}
ADDRGP4 $787
JUMPV
LABELV $786
line 1210
;1210:	else {
line 1211
;1211:		trap_Cvar_Set("g_meeting", "0");
ADDRGP4 $789
ARGP4
ADDRGP4 $790
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1212
;1212:	}
LABELV $787
line 1214
;1213:#endif
;1214:	trap_Cvar_Set("sv_hostname", s_serveroptions.hostname.field.buffer );
ADDRGP4 $791
ARGP4
ADDRGP4 s_serveroptions+2776+60+12
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1216
;1215:
;1216:	trap_Cvar_SetValue( "sv_punkbuster", s_serveroptions.punkbuster.curvalue );
ADDRGP4 $795
ARGP4
ADDRGP4 s_serveroptions+7756+64
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1219
;1217:
;1218:	// the wait commands will allow the dedicated to take effect
;1219:	trap_Cmd_ExecuteText( EXEC_APPEND, va( "wait ; wait ; map %s\n", /*s_startserver.maplist[s_startserver.currentmap]*/s_startserver.choosenmap ) );	// JUHOX
ADDRGP4 $798
ARGP4
ADDRGP4 s_startserver+7752
ARGP4
ADDRLP4 276
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 276
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 1222
;1220:
;1221:	// add bots
;1222:	trap_Cmd_ExecuteText( EXEC_APPEND, "wait 3\n" );
CNSTI4 2
ARGI4
ADDRGP4 $800
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 1223
;1223:	for( n = 1; n < PLAYER_SLOTS; n++ ) {
ADDRLP4 0
CNSTI4 1
ASGNI4
LABELV $801
line 1224
;1224:		if( s_serveroptions.playerType[n].curvalue != 1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 s_serveroptions+4068+64
ADDP4
INDIRI4
CNSTI4 1
EQI4 $805
line 1225
;1225:			continue;
ADDRGP4 $802
JUMPV
LABELV $805
line 1227
;1226:		}
;1227:		if( s_serveroptions.playerNameBuffers[n][0] == 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 s_serveroptions+7540
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $809
line 1228
;1228:			continue;
ADDRGP4 $802
JUMPV
LABELV $809
line 1230
;1229:		}
;1230:		if( s_serveroptions.playerNameBuffers[n][0] == '-' ) {
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 s_serveroptions+7540
ADDP4
INDIRI1
CVII4 1
CNSTI4 45
NEI4 $812
line 1231
;1231:			continue;
ADDRGP4 $802
JUMPV
LABELV $812
line 1233
;1232:		}
;1233:		if( s_serveroptions.gametype >= GT_TEAM ) {
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 3
LTI4 $815
line 1234
;1234:			Com_sprintf( buf, sizeof(buf), "addbot %s %i %s\n", s_serveroptions.playerNameBuffers[n], skill,
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $818
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 s_serveroptions+7540
ADDP4
ARGP4
ADDRLP4 72
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 s_serveroptions+6084+64
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 playerTeam_list
ADDP4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1236
;1235:				playerTeam_list[s_serveroptions.playerTeam[n].curvalue] );
;1236:		}
ADDRGP4 $816
JUMPV
LABELV $815
line 1237
;1237:		else {
line 1238
;1238:			Com_sprintf( buf, sizeof(buf), "addbot %s %i\n", s_serveroptions.playerNameBuffers[n], skill );
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $822
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 s_serveroptions+7540
ADDP4
ARGP4
ADDRLP4 72
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1239
;1239:		}
LABELV $816
line 1240
;1240:		trap_Cmd_ExecuteText( EXEC_APPEND, buf );
CNSTI4 2
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 1241
;1241:	}
LABELV $802
line 1223
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 12
LTI4 $801
line 1244
;1242:
;1243:	// set player's team
;1244:	if( dedicated == 0 && s_serveroptions.gametype >= GT_TEAM ) {
ADDRLP4 88
INDIRI4
CNSTI4 0
NEI4 $824
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 3
LTI4 $824
line 1245
;1245:		trap_Cmd_ExecuteText( EXEC_APPEND, va( "wait 5; team %s\n", playerTeam_list[s_serveroptions.playerTeam[0].curvalue] ) );
ADDRGP4 $827
ARGP4
ADDRGP4 s_serveroptions+6084+64
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 playerTeam_list
ADDP4
INDIRP4
ARGP4
ADDRLP4 280
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 280
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 1246
;1246:	}
LABELV $824
line 1247
;1247:}
LABELV $538
endproc ServerOptions_Start 352 24
proc ServerOptions_InitPlayerItems 12 12
line 1255
;1248:
;1249:
;1250:/*
;1251:=================
;1252:ServerOptions_InitPlayerItems
;1253:=================
;1254:*/
;1255:static void ServerOptions_InitPlayerItems( void ) {
line 1260
;1256:	int		n;
;1257:	int		v;
;1258:
;1259:	// init types
;1260:	if( s_serveroptions.multiplayer ) {
ADDRGP4 s_serveroptions+7500
INDIRI4
CNSTI4 0
EQI4 $831
line 1261
;1261:		v = 0;	// open
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1262
;1262:	}
ADDRGP4 $832
JUMPV
LABELV $831
line 1263
;1263:	else {
line 1264
;1264:		v = 1;	// bot
ADDRLP4 4
CNSTI4 1
ASGNI4
line 1265
;1265:	}
LABELV $832
line 1267
;1266:#if ESCAPE_MODE	// JUHOX: no bots in EFH
;1267:	if (s_serveroptions.gametype == GT_EFH) {
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 9
NEI4 $834
line 1268
;1268:		v = 0;	// open
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1269
;1269:	}
LABELV $834
line 1272
;1270:#endif
;1271:	
;1272:	for( n = 0; n < PLAYER_SLOTS; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $837
line 1273
;1273:		s_serveroptions.playerType[n].curvalue = v;
ADDRLP4 0
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 s_serveroptions+4068+64
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 1274
;1274:	}
LABELV $838
line 1272
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 12
LTI4 $837
line 1276
;1275:
;1276:	if( s_serveroptions.multiplayer && (s_serveroptions.gametype < GT_TEAM) ) {
ADDRGP4 s_serveroptions+7500
INDIRI4
CNSTI4 0
EQI4 $843
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 3
GEI4 $843
line 1277
;1277:		for( n = 8; n < PLAYER_SLOTS; n++ ) {
ADDRLP4 0
CNSTI4 8
ASGNI4
LABELV $847
line 1278
;1278:			s_serveroptions.playerType[n].curvalue = 2;
ADDRLP4 0
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 s_serveroptions+4068+64
ADDP4
CNSTI4 2
ASGNI4
line 1279
;1279:		}
LABELV $848
line 1277
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 12
LTI4 $847
line 1280
;1280:	}
LABELV $843
line 1283
;1281:
;1282:	// if not a dedicated server, first slot is reserved for the human on the server
;1283:	if( s_serveroptions.dedicated.curvalue == 0 ) {
ADDRGP4 s_serveroptions+672+64
INDIRI4
CNSTI4 0
NEI4 $853
line 1285
;1284:		// human
;1285:		s_serveroptions.playerType[0].generic.flags |= QMF_INACTIVE;
ADDRLP4 8
ADDRGP4 s_serveroptions+4068+44
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 16384
BORU4
ASGNU4
line 1286
;1286:		s_serveroptions.playerType[0].curvalue = 0;
ADDRGP4 s_serveroptions+4068+64
CNSTI4 0
ASGNI4
line 1287
;1287:		trap_Cvar_VariableStringBuffer( "name", s_serveroptions.playerNameBuffers[0], sizeof(s_serveroptions.playerNameBuffers[0]) );
ADDRGP4 $861
ARGP4
ADDRGP4 s_serveroptions+7540
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1288
;1288:		Q_CleanStr( s_serveroptions.playerNameBuffers[0] );
ADDRGP4 s_serveroptions+7540
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 1289
;1289:	}
LABELV $853
line 1293
;1290:
;1291:	// init teams
;1292:#if MONSTER_MODE	// JUHOX: hide team selector for STU & EFH
;1293:	if (s_serveroptions.gametype >= GT_STU) {
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 8
LTI4 $865
line 1294
;1294:		for (n = 0; n < PLAYER_SLOTS; n++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $868
line 1295
;1295:			s_serveroptions.playerTeam[n].curvalue = 1;	// 0=blue, 1=red
ADDRLP4 0
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 s_serveroptions+6084+64
ADDP4
CNSTI4 1
ASGNI4
line 1296
;1296:			s_serveroptions.playerTeam[n].generic.flags |= (QMF_INACTIVE|QMF_HIDDEN);
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 s_serveroptions+6084+44
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 20480
BORU4
ASGNU4
line 1297
;1297:		}
LABELV $869
line 1294
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 12
LTI4 $868
line 1298
;1298:	}
ADDRGP4 $866
JUMPV
LABELV $865
line 1301
;1299:	else
;1300:#endif
;1301:	if( s_serveroptions.gametype >= GT_TEAM ) {
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 3
LTI4 $876
line 1302
;1302:		for( n = 0; n < (PLAYER_SLOTS / 2); n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $879
line 1303
;1303:			s_serveroptions.playerTeam[n].curvalue = 0;
ADDRLP4 0
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 s_serveroptions+6084+64
ADDP4
CNSTI4 0
ASGNI4
line 1304
;1304:		}
LABELV $880
line 1302
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 6
LTI4 $879
line 1305
;1305:		for( ; n < PLAYER_SLOTS; n++ ) {
ADDRGP4 $888
JUMPV
LABELV $885
line 1306
;1306:			s_serveroptions.playerTeam[n].curvalue = 1;
ADDRLP4 0
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 s_serveroptions+6084+64
ADDP4
CNSTI4 1
ASGNI4
line 1307
;1307:		}
LABELV $886
line 1305
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $888
ADDRLP4 0
INDIRI4
CNSTI4 12
LTI4 $885
line 1308
;1308:	}
ADDRGP4 $877
JUMPV
LABELV $876
line 1309
;1309:	else {
line 1310
;1310:		for( n = 0; n < PLAYER_SLOTS; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $891
line 1311
;1311:			s_serveroptions.playerTeam[n].generic.flags |= (QMF_INACTIVE|QMF_HIDDEN);
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 s_serveroptions+6084+44
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 20480
BORU4
ASGNU4
line 1312
;1312:		}
LABELV $892
line 1310
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 12
LTI4 $891
line 1313
;1313:	}
LABELV $877
LABELV $866
line 1314
;1314:}
LABELV $830
endproc ServerOptions_InitPlayerItems 12 12
proc ServerOptions_SetPlayerItems 12 0
line 1322
;1315:
;1316:
;1317:/*
;1318:=================
;1319:ServerOptions_SetPlayerItems
;1320:=================
;1321:*/
;1322:static void ServerOptions_SetPlayerItems( void ) {
line 1334
;1323:	int		start;
;1324:	int		n;
;1325:
;1326:	// types
;1327://	for( n = 0; n < PLAYER_SLOTS; n++ ) {
;1328://		if( (!s_serveroptions.multiplayer) && (n > 0) && (s_serveroptions.playerType[n].curvalue == 0) ) {
;1329://			s_serveroptions.playerType[n].curvalue = 1;
;1330://		}
;1331://	}
;1332:
;1333:	// names
;1334:	if( s_serveroptions.dedicated.curvalue == 0 ) {
ADDRGP4 s_serveroptions+672+64
INDIRI4
CNSTI4 0
NEI4 $898
line 1335
;1335:		s_serveroptions.player0.string = "Human";
ADDRGP4 s_serveroptions+3996+60
ADDRGP4 $904
ASGNP4
line 1336
;1336:		s_serveroptions.playerName[0].generic.flags &= ~QMF_HIDDEN;
ADDRLP4 8
ADDRGP4 s_serveroptions+5220+44
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 4294963199
BANDU4
ASGNU4
line 1338
;1337:
;1338:		start = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 1339
;1339:	}
ADDRGP4 $899
JUMPV
LABELV $898
line 1340
;1340:	else {
line 1341
;1341:		s_serveroptions.player0.string = "Open";
ADDRGP4 s_serveroptions+3996+60
ADDRGP4 $508
ASGNP4
line 1342
;1342:		start = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1343
;1343:	}
LABELV $899
line 1344
;1344:	for( n = start; n < PLAYER_SLOTS; n++ ) {
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
ADDRGP4 $912
JUMPV
LABELV $909
line 1347
;1345:#if ESCAPE_MODE	// JUHOX: no bots in EFH
;1346:		if (
;1347:			s_serveroptions.gametype == GT_EFH &&
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 9
NEI4 $913
ADDRLP4 0
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 s_serveroptions+4068+64
ADDP4
INDIRI4
CNSTI4 1
NEI4 $913
line 1349
;1348:			s_serveroptions.playerType[n].curvalue == 1
;1349:		) {
line 1350
;1350:			s_serveroptions.playerType[n].curvalue = 2;	// closed
ADDRLP4 0
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 s_serveroptions+4068+64
ADDP4
CNSTI4 2
ASGNI4
line 1351
;1351:		}
LABELV $913
line 1353
;1352:#endif
;1353:		if( s_serveroptions.playerType[n].curvalue == 1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 s_serveroptions+4068+64
ADDP4
INDIRI4
CNSTI4 1
NEI4 $920
line 1354
;1354:			s_serveroptions.playerName[n].generic.flags &= ~(QMF_INACTIVE|QMF_HIDDEN);
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 s_serveroptions+5220+44
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 4294946815
BANDU4
ASGNU4
line 1355
;1355:		}
ADDRGP4 $921
JUMPV
LABELV $920
line 1356
;1356:		else {
line 1357
;1357:			s_serveroptions.playerName[n].generic.flags |= (QMF_INACTIVE|QMF_HIDDEN);
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 s_serveroptions+5220+44
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 20480
BORU4
ASGNU4
line 1358
;1358:		}
LABELV $921
line 1359
;1359:	}
LABELV $910
line 1344
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $912
ADDRLP4 0
INDIRI4
CNSTI4 12
LTI4 $909
line 1362
;1360:
;1361:	// teams
;1362:	if( s_serveroptions.gametype < GT_TEAM ) {
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 3
GEI4 $928
line 1363
;1363:		return;
ADDRGP4 $897
JUMPV
LABELV $928
line 1366
;1364:	}
;1365:#if MONSTER_MODE	// JUHOX: don't change team selector's hidden status for STU & EFH
;1366:	if (s_serveroptions.gametype >= GT_STU) {
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 8
LTI4 $931
line 1367
;1367:		return;
ADDRGP4 $897
JUMPV
LABELV $931
line 1370
;1368:	}
;1369:#endif
;1370:	for( n = start; n < PLAYER_SLOTS; n++ ) {
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
ADDRGP4 $937
JUMPV
LABELV $934
line 1371
;1371:		if( s_serveroptions.playerType[n].curvalue == 2 ) {
ADDRLP4 0
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 s_serveroptions+4068+64
ADDP4
INDIRI4
CNSTI4 2
NEI4 $938
line 1372
;1372:			s_serveroptions.playerTeam[n].generic.flags |= (QMF_INACTIVE|QMF_HIDDEN);
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 s_serveroptions+6084+44
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 20480
BORU4
ASGNU4
line 1373
;1373:		}
ADDRGP4 $939
JUMPV
LABELV $938
line 1374
;1374:		else {
line 1375
;1375:			s_serveroptions.playerTeam[n].generic.flags &= ~(QMF_INACTIVE|QMF_HIDDEN);
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 s_serveroptions+6084+44
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 4294946815
BANDU4
ASGNU4
line 1376
;1376:		}
LABELV $939
line 1377
;1377:	}
LABELV $935
line 1370
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $937
ADDRLP4 0
INDIRI4
CNSTI4 12
LTI4 $934
line 1378
;1378:}
LABELV $897
endproc ServerOptions_SetPlayerItems 12 0
proc ServerOptions_Event 8 0
line 1386
;1379:
;1380:
;1381:/*
;1382:=================
;1383:ServerOptions_Event
;1384:=================
;1385:*/
;1386:static void ServerOptions_Event( void* ptr, int event ) {
line 1387
;1387:	switch( ((menucommon_s*)ptr)->id ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 18
LTI4 $947
ADDRLP4 0
INDIRI4
CNSTI4 24
GTI4 $947
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $963-72
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $963
address $957
address $947
address $950
address $953
address $953
address $954
address $960
code
LABELV $950
line 1393
;1388:	
;1389:	//if( event != QM_ACTIVATED && event != QM_LOSTFOCUS) {
;1390:	//	return;
;1391:	//}
;1392:	case ID_PLAYER_TYPE:
;1393:		if( event != QM_ACTIVATED ) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $951
line 1394
;1394:			break;
ADDRGP4 $948
JUMPV
LABELV $951
line 1396
;1395:		}
;1396:		ServerOptions_SetPlayerItems();
ADDRGP4 ServerOptions_SetPlayerItems
CALLV
pop
line 1397
;1397:		break;
ADDRGP4 $948
JUMPV
LABELV $953
line 1401
;1398:
;1399:	case ID_MAXCLIENTS:
;1400:	case ID_DEDICATED:
;1401:		ServerOptions_SetPlayerItems();
ADDRGP4 ServerOptions_SetPlayerItems
CALLV
pop
line 1402
;1402:		break;
ADDRGP4 $948
JUMPV
LABELV $954
line 1404
;1403:	case ID_GO:
;1404:		if( event != QM_ACTIVATED ) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $955
line 1405
;1405:			break;
ADDRGP4 $948
JUMPV
LABELV $955
line 1407
;1406:		}
;1407:		ServerOptions_Start();
ADDRGP4 ServerOptions_Start
CALLV
pop
line 1408
;1408:		break;
ADDRGP4 $948
JUMPV
LABELV $957
line 1411
;1409:
;1410:	case ID_STARTSERVERNEXT:
;1411:		if( event != QM_ACTIVATED ) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $948
line 1412
;1412:			break;
ADDRGP4 $948
JUMPV
line 1414
;1413:		}
;1414:		break;
LABELV $960
line 1416
;1415:	case ID_BACK:
;1416:		if( event != QM_ACTIVATED ) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $961
line 1417
;1417:			break;
ADDRGP4 $948
JUMPV
LABELV $961
line 1419
;1418:		}
;1419:		UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 1420
;1420:		break;
LABELV $947
LABELV $948
line 1422
;1421:	}
;1422:}
LABELV $946
endproc ServerOptions_Event 8 0
proc ServerOptions_PlayerNameEvent 4 4
line 1425
;1423:
;1424:
;1425:static void ServerOptions_PlayerNameEvent( void* ptr, int event ) {
line 1428
;1426:	int		n;
;1427:
;1428:	if( event != QM_ACTIVATED ) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $966
line 1429
;1429:		return;
ADDRGP4 $965
JUMPV
LABELV $966
line 1431
;1430:	}
;1431:	n = ((menutext_s*)ptr)->generic.id;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1432
;1432:	s_serveroptions.newBotIndex = n;
ADDRGP4 s_serveroptions+7736
ADDRLP4 0
INDIRI4
ASGNI4
line 1433
;1433:	UI_BotSelectMenu( s_serveroptions.playerNameBuffers[n] );
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 s_serveroptions+7540
ADDP4
ARGP4
ADDRGP4 UI_BotSelectMenu
CALLV
pop
line 1434
;1434:}
LABELV $965
endproc ServerOptions_PlayerNameEvent 4 4
proc ServerOptions_StatusBar 8 20
line 1442
;1435:
;1436:
;1437:/*
;1438:=================
;1439:ServerOptions_StatusBar
;1440:=================
;1441:*/
;1442:static void ServerOptions_StatusBar( void* ptr ) {
line 1443
;1443:	switch( ((menucommon_s*)ptr)->id ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $971
JUMPV
LABELV $971
line 1449
;1444:	default:
;1445:		// JUHOX: in STU & EFH move server options status bar a bit lower
;1446:#if !MONSTER_MODE
;1447:		UI_DrawString( /*320*/420, /*440*/400, /*"0 = NO LIMIT"*/"0 = no limit", UI_CENTER|UI_SMALLFONT, colorWhite );	// JUHOX
;1448:#else
;1449:		{
line 1452
;1450:			int y;
;1451:
;1452:			y = 400;
ADDRLP4 4
CNSTI4 400
ASGNI4
line 1453
;1453:			if (s_serveroptions.gametype >= GT_STU && s_serveroptions.multiplayer) {
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 8
LTI4 $974
ADDRGP4 s_serveroptions+7500
INDIRI4
CNSTI4 0
EQI4 $974
line 1454
;1454:				y += SMALLCHAR_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 1455
;1455:			}
LABELV $974
line 1456
;1456:			UI_DrawString(420, y, "0 = no limit", UI_CENTER|UI_SMALLFONT, colorWhite);
CNSTI4 420
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 $978
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 1457
;1457:		}
line 1459
;1458:#endif
;1459:		break;
LABELV $972
line 1461
;1460:	}
;1461:}
LABELV $970
endproc ServerOptions_StatusBar 8 20
proc ServerOptions_PureServerStatusBar 0 0
line 1468
;1462:
;1463:/*
;1464:=================
;1465:JUHOX: ServerOptions_PureServerStatusBar
;1466:=================
;1467:*/
;1468:static void ServerOptions_PureServerStatusBar(void* ptr) {
line 1469
;1469:	if (s_serveroptions.gametype < GT_TEAM) return;
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 3
GEI4 $980
ADDRGP4 $979
JUMPV
LABELV $980
line 1472
;1470:	// JUHOX: no TSS with STU & EFH
;1471:#if MONSTER_MODE
;1472:	if (s_serveroptions.gametype >= GT_STU) return;
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 8
LTI4 $983
LABELV $983
line 1481
;1473:#endif
;1474:
;1475:#if !TSSINCVAR
;1476:	if (s_serveroptions.pure.curvalue) {
;1477:		//s_serveroptions.tss = qfalse;	// JUHOX FIXME: unusual place for this
;1478:		UI_DrawString(420, 400, "NOTE: No TSS on pure servers!", UI_CENTER|UI_SMALLFONT, colorWhite);
;1479:	}
;1480:#endif
;1481:}
LABELV $979
endproc ServerOptions_PureServerStatusBar 0 0
proc ServerOptions_ArtefactsStatusBar 4 20
line 1489
;1482:
;1483:/*
;1484:=================
;1485:JUHOX: ServerOptions_ArtefactsStatusBar
;1486:=================
;1487:*/
;1488:#if MONSTER_MODE
;1489:static void ServerOptions_ArtefactsStatusBar(void* ptr) {
line 1492
;1490:	int y;
;1491:
;1492:	y = 400;
ADDRLP4 0
CNSTI4 400
ASGNI4
line 1493
;1493:	if (s_serveroptions.multiplayer) {
ADDRGP4 s_serveroptions+7500
INDIRI4
CNSTI4 0
EQI4 $987
line 1494
;1494:		y += SMALLCHAR_HEIGHT;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 1495
;1495:	}
LABELV $987
line 1496
;1496:	UI_DrawString(420, y, "0 ... 998, 999 = unlimited", UI_CENTER|UI_SMALLFONT, colorWhite);
CNSTI4 420
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $990
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 1497
;1497:}
LABELV $986
endproc ServerOptions_ArtefactsStatusBar 4 20
proc ServerOptions_LevelshotDraw 16 20
line 1505
;1498:#endif
;1499:
;1500:/*
;1501:===============
;1502:ServerOptions_LevelshotDraw
;1503:===============
;1504:*/
;1505:static void ServerOptions_LevelshotDraw( void *self ) {
line 1511
;1506:	menubitmap_s	*b;
;1507:	int				x;
;1508:	int				y;
;1509:
;1510:	// strange place for this, but it works
;1511:	if( s_serveroptions.newBot ) {
ADDRGP4 s_serveroptions+7732
INDIRI4
CNSTI4 0
EQI4 $992
line 1512
;1512:		Q_strncpyz( s_serveroptions.playerNameBuffers[s_serveroptions.newBotIndex], s_serveroptions.newBotName, 16 );
ADDRGP4 s_serveroptions+7736
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 s_serveroptions+7540
ADDP4
ARGP4
ADDRGP4 s_serveroptions+7740
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1513
;1513:		s_serveroptions.newBot = qfalse;
ADDRGP4 s_serveroptions+7732
CNSTI4 0
ASGNI4
line 1514
;1514:	}
LABELV $992
line 1516
;1515:
;1516:	b = (menubitmap_s *)self;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 1518
;1517:
;1518:	Bitmap_Draw( b );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Bitmap_Draw
CALLV
pop
line 1520
;1519:
;1520:	x = b->generic.x;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1521
;1521:	y = b->generic.y + b->height;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
ADDI4
ASGNI4
line 1522
;1522:	UI_FillRect( x, y, b->width, 40, colorBlack );
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1109393408
ARGF4
ADDRGP4 colorBlack
ARGP4
ADDRGP4 UI_FillRect
CALLV
pop
line 1524
;1523:
;1524:	x += b->width / 2;
ADDRLP4 8
ADDRLP4 8
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 2
DIVI4
ADDI4
ASGNI4
line 1525
;1525:	y += 4;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 4
ADDI4
ASGNI4
line 1526
;1526:	UI_DrawString( x, y, s_serveroptions.mapnamebuffer, UI_CENTER|UI_SMALLFONT, color_orange );
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 s_serveroptions+7508
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 color_orange
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 1528
;1527:
;1528:	y += SMALLCHAR_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 1532
;1529:#if 0	// JUHOX: get game name without remapping
;1530:	UI_DrawString( x, y, gametype_items[gametype_remap2[s_serveroptions.gametype]], UI_CENTER|UI_SMALLFONT, color_orange );
;1531:#else
;1532:	UI_DrawString(x, y, gametype_names[s_serveroptions.gametype], UI_CENTER|UI_SMALLFONT, color_orange);
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gametype_names
ADDP4
INDIRP4
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 color_orange
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 1534
;1533:#endif
;1534:}
LABELV $991
endproc ServerOptions_LevelshotDraw 16 20
data
align 4
LABELV $1093
address $1094
address $1095
address $1096
address $1097
address $1098
address $1099
address $1100
address $1101
address $1102
address $1103
address $1104
address $1105
code
proc ServerOptions_InitBotNames 1076 16
line 1537
;1535:
;1536:
;1537:static void ServerOptions_InitBotNames( void ) {
line 1547
;1538:	int			count;
;1539:	int			n;
;1540:	const char	*arenaInfo;
;1541:	const char	*botInfo;
;1542:	char		*p;
;1543:	char		*bot;
;1544:	char		bots[MAX_INFO_STRING];
;1545:
;1546:#if ESCAPE_MODE	// JUHOX: no bots in EFH
;1547:	if (s_serveroptions.gametype == GT_EFH) {
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 9
NEI4 $1002
line 1548
;1548:		count = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 1549
;1549:		goto CloseSuperfluousSlots;
ADDRGP4 $1005
JUMPV
LABELV $1002
line 1556
;1550:	}
;1551:#endif
;1552:
;1553:#if !MONSTER_MODE	// JUHOX: initialize bot name in STU like in FFA
;1554:	if( s_serveroptions.gametype >= GT_TEAM ) {
;1555:#else
;1556:	count = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 1557
;1557:	if (s_serveroptions.gametype == GT_STU) goto Init;
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 8
NEI4 $1006
ADDRGP4 $1009
JUMPV
LABELV $1006
line 1558
;1558:	if (s_serveroptions.gametype >= GT_TEAM) {
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 3
LTI4 $1010
line 1560
;1559:#endif
;1560:		Q_strncpyz( s_serveroptions.playerNameBuffers[1], "grunt", 16 );
ADDRGP4 s_serveroptions+7540+16
ARGP4
ADDRGP4 $1015
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1561
;1561:		Q_strncpyz( s_serveroptions.playerNameBuffers[2], "major", 16 );
ADDRGP4 s_serveroptions+7540+32
ARGP4
ADDRGP4 $1018
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1562
;1562:		if( s_serveroptions.gametype == GT_TEAM ) {
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 3
NEI4 $1019
line 1563
;1563:			Q_strncpyz( s_serveroptions.playerNameBuffers[3], "visor", 16 );
ADDRGP4 s_serveroptions+7540+48
ARGP4
ADDRGP4 $1024
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1564
;1564:		}
ADDRGP4 $1020
JUMPV
LABELV $1019
line 1565
;1565:		else {
line 1566
;1566:			s_serveroptions.playerType[3].curvalue = 2;
ADDRGP4 s_serveroptions+4068+288+64
CNSTI4 2
ASGNI4
line 1567
;1567:		}
LABELV $1020
line 1568
;1568:		s_serveroptions.playerType[4].curvalue = 2;
ADDRGP4 s_serveroptions+4068+384+64
CNSTI4 2
ASGNI4
line 1569
;1569:		s_serveroptions.playerType[5].curvalue = 2;
ADDRGP4 s_serveroptions+4068+480+64
CNSTI4 2
ASGNI4
line 1571
;1570:
;1571:		Q_strncpyz( s_serveroptions.playerNameBuffers[6], "sarge", 16 );
ADDRGP4 s_serveroptions+7540+96
ARGP4
ADDRGP4 $1036
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1572
;1572:		Q_strncpyz( s_serveroptions.playerNameBuffers[7], "grunt", 16 );
ADDRGP4 s_serveroptions+7540+112
ARGP4
ADDRGP4 $1015
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1573
;1573:		Q_strncpyz( s_serveroptions.playerNameBuffers[8], "major", 16 );
ADDRGP4 s_serveroptions+7540+128
ARGP4
ADDRGP4 $1018
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1574
;1574:		if( s_serveroptions.gametype == GT_TEAM ) {
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 3
NEI4 $1041
line 1575
;1575:			Q_strncpyz( s_serveroptions.playerNameBuffers[9], "visor", 16 );
ADDRGP4 s_serveroptions+7540+144
ARGP4
ADDRGP4 $1024
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1576
;1576:		}
ADDRGP4 $1042
JUMPV
LABELV $1041
line 1577
;1577:		else {
line 1578
;1578:			s_serveroptions.playerType[9].curvalue = 2;
ADDRGP4 s_serveroptions+4068+864+64
CNSTI4 2
ASGNI4
line 1579
;1579:		}
LABELV $1042
line 1580
;1580:		s_serveroptions.playerType[10].curvalue = 2;
ADDRGP4 s_serveroptions+4068+960+64
CNSTI4 2
ASGNI4
line 1581
;1581:		s_serveroptions.playerType[11].curvalue = 2;
ADDRGP4 s_serveroptions+4068+1056+64
CNSTI4 2
ASGNI4
line 1584
;1582:
;1583:#if	1	// JUHOX: add more bot names1
;1584:		Q_strncpyz( s_serveroptions.playerNameBuffers[3], "visor", 16 );
ADDRGP4 s_serveroptions+7540+48
ARGP4
ADDRGP4 $1024
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1585
;1585:		Q_strncpyz( s_serveroptions.playerNameBuffers[4], "anarki", 16 );
ADDRGP4 s_serveroptions+7540+64
ARGP4
ADDRGP4 $1059
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1586
;1586:		Q_strncpyz( s_serveroptions.playerNameBuffers[5], "xaero", 16 );
ADDRGP4 s_serveroptions+7540+80
ARGP4
ADDRGP4 $1062
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1587
;1587:		Q_strncpyz( s_serveroptions.playerNameBuffers[9], "visor", 16 );
ADDRGP4 s_serveroptions+7540+144
ARGP4
ADDRGP4 $1024
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1588
;1588:		Q_strncpyz( s_serveroptions.playerNameBuffers[10], "anarki", 16 );
ADDRGP4 s_serveroptions+7540+160
ARGP4
ADDRGP4 $1059
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1589
;1589:		Q_strncpyz( s_serveroptions.playerNameBuffers[11], "xaero", 16 );
ADDRGP4 s_serveroptions+7540+176
ARGP4
ADDRGP4 $1062
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1591
;1590:#endif
;1591:		return;
ADDRGP4 $1001
JUMPV
LABELV $1010
line 1594
;1592:	}
;1593:
;1594:	count = 1;	// skip the first slot, reserved for a human
ADDRLP4 4
CNSTI4 1
ASGNI4
line 1597
;1595:
;1596:	// get info for this map
;1597:	arenaInfo = UI_GetArenaInfoByMap( s_serveroptions.mapnamebuffer );
ADDRGP4 s_serveroptions+7508
ARGP4
ADDRLP4 1048
ADDRGP4 UI_GetArenaInfoByMap
CALLP4
ASGNP4
ADDRLP4 1044
ADDRLP4 1048
INDIRP4
ASGNP4
line 1600
;1598:
;1599:	// get the bot info - we'll seed with them if any are listed
;1600:	Q_strncpyz( bots, Info_ValueForKey( arenaInfo, "bots" ), sizeof(bots) );
ADDRLP4 1044
INDIRP4
ARGP4
ADDRGP4 $1070
ARGP4
ADDRLP4 1052
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 20
ARGP4
ADDRLP4 1052
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1601
;1601:	p = &bots[0];
ADDRLP4 0
ADDRLP4 20
ASGNP4
ADDRGP4 $1072
JUMPV
line 1602
;1602:	while( *p && count < PLAYER_SLOTS ) {
LABELV $1074
line 1604
;1603:		//skip spaces
;1604:		while( *p && *p == ' ' ) {
line 1605
;1605:			p++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1606
;1606:		}
LABELV $1075
line 1604
ADDRLP4 1056
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
EQI4 $1077
ADDRLP4 1056
INDIRI4
CNSTI4 32
EQI4 $1074
LABELV $1077
line 1607
;1607:		if( !p ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1078
line 1608
;1608:			break;
ADDRGP4 $1073
JUMPV
LABELV $1078
line 1612
;1609:		}
;1610:
;1611:		// mark start of bot name
;1612:		bot = p;
ADDRLP4 12
ADDRLP4 0
INDIRP4
ASGNP4
ADDRGP4 $1081
JUMPV
LABELV $1080
line 1615
;1613:
;1614:		// skip until space of null
;1615:		while( *p && *p != ' ' ) {
line 1616
;1616:			p++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1617
;1617:		}
LABELV $1081
line 1615
ADDRLP4 1060
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1060
INDIRI4
CNSTI4 0
EQI4 $1083
ADDRLP4 1060
INDIRI4
CNSTI4 32
NEI4 $1080
LABELV $1083
line 1618
;1618:		if( *p ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1084
line 1619
;1619:			*p++ = 0;
ADDRLP4 1064
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 1064
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 1064
INDIRP4
CNSTI1 0
ASGNI1
line 1620
;1620:		}
LABELV $1084
line 1622
;1621:
;1622:		botInfo = UI_GetBotInfoByName( bot );
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 1064
ADDRGP4 UI_GetBotInfoByName
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 1064
INDIRP4
ASGNP4
line 1623
;1623:		bot = Info_ValueForKey( botInfo, "name" );
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 $861
ARGP4
ADDRLP4 1068
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 1068
INDIRP4
ASGNP4
line 1625
;1624:
;1625:		Q_strncpyz( s_serveroptions.playerNameBuffers[count], bot, sizeof(s_serveroptions.playerNameBuffers[count]) );
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 s_serveroptions+7540
ADDP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1626
;1626:		count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1627
;1627:	}
LABELV $1072
line 1602
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1088
ADDRLP4 4
INDIRI4
CNSTI4 12
LTI4 $1075
LABELV $1088
LABELV $1073
LABELV $1009
line 1637
;1628:
;1629:	// JUHOX: initialize bot slots with names
;1630:#if 0
;1631:	// set the rest of the bot slots to "---"
;1632:	for( n = count; n < PLAYER_SLOTS; n++ ) {
;1633:		strcpy( s_serveroptions.playerNameBuffers[n], "--------" );
;1634:	}
;1635:#else
;1636:	Init:
;1637:	for (n = count; n < PLAYER_SLOTS; n++) {
ADDRLP4 8
ADDRLP4 4
INDIRI4
ASGNI4
ADDRGP4 $1092
JUMPV
LABELV $1089
line 1644
;1638:		static const char* const names[PLAYER_SLOTS] = {
;1639:			"Sarge", "Grunt", "Major", "Visor",
;1640:			"Anarki", "Xaero", "Harpy", "Sorlag",
;1641:			"TankJr", "Uriel", "Bones", "Orbb"
;1642:		};
;1643:		
;1644:		strcpy(s_serveroptions.playerNameBuffers[n], names[n]);
ADDRLP4 8
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 s_serveroptions+7540
ADDP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1093
ADDP4
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1645
;1645:	}
LABELV $1090
line 1637
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1092
ADDRLP4 8
INDIRI4
CNSTI4 12
LTI4 $1089
LABELV $1005
line 1656
;1646:#endif
;1647:
;1648:	// JUHOX: check "maxplayers" for # of open slots
;1649:#if 0
;1650:	// pad up to #8 as open slots
;1651:	for( ;count < 8; count++ ) {
;1652:		s_serveroptions.playerType[count].curvalue = 0;
;1653:	}
;1654:#else
;1655:	CloseSuperfluousSlots:
;1656:	{
line 1659
;1657:		int openSlots;
;1658:
;1659:		openSlots = gtmpl.maxplayers;
ADDRLP4 1056
ADDRGP4 gtmpl+140
INDIRI4
ASGNI4
line 1660
;1660:		if (openSlots > 0 && openSlots <= PLAYER_SLOTS) {
ADDRLP4 1056
INDIRI4
CNSTI4 0
LEI4 $1108
ADDRLP4 1056
INDIRI4
CNSTI4 12
GTI4 $1108
line 1661
;1661:			s_serveroptions.additionalSlots.generic.flags |= QMF_GRAYED;
ADDRLP4 1064
ADDRGP4 s_serveroptions+3268+44
ASGNP4
ADDRLP4 1064
INDIRP4
ADDRLP4 1064
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
line 1663
;1662:
;1663:			for (n = openSlots; n < PLAYER_SLOTS; n++) {
ADDRLP4 8
ADDRLP4 1056
INDIRI4
ASGNI4
ADDRGP4 $1115
JUMPV
LABELV $1112
line 1664
;1664:				s_serveroptions.playerType[n].generic.flags |= QMF_GRAYED;
ADDRLP4 1068
ADDRLP4 8
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 s_serveroptions+4068+44
ADDP4
ASGNP4
ADDRLP4 1068
INDIRP4
ADDRLP4 1068
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
line 1665
;1665:				s_serveroptions.playerName[n].generic.flags |= QMF_GRAYED;
ADDRLP4 1072
ADDRLP4 8
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 s_serveroptions+5220+44
ADDP4
ASGNP4
ADDRLP4 1072
INDIRP4
ADDRLP4 1072
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
line 1666
;1666:			}
LABELV $1113
line 1663
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1115
ADDRLP4 8
INDIRI4
CNSTI4 12
LTI4 $1112
line 1667
;1667:		}
LABELV $1108
line 1669
;1668:
;1669:		if (openSlots < 1) openSlots = 8;
ADDRLP4 1056
INDIRI4
CNSTI4 1
GEI4 $1120
ADDRLP4 1056
CNSTI4 8
ASGNI4
LABELV $1120
line 1670
;1670:		if (openSlots > MAX_CLIENTS) openSlots = MAX_CLIENTS;
ADDRLP4 1056
INDIRI4
CNSTI4 64
LEI4 $1122
ADDRLP4 1056
CNSTI4 64
ASGNI4
LABELV $1122
line 1672
;1671:
;1672:		n = openSlots;
ADDRLP4 8
ADDRLP4 1056
INDIRI4
ASGNI4
line 1673
;1673:		if (n > PLAYER_SLOTS) n = PLAYER_SLOTS;
ADDRLP4 8
INDIRI4
CNSTI4 12
LEI4 $1129
ADDRLP4 8
CNSTI4 12
ASGNI4
line 1674
;1674:		for (; count < n; count++) {
ADDRGP4 $1129
JUMPV
LABELV $1126
line 1675
;1675:			s_serveroptions.playerType[count].curvalue = 0;
ADDRLP4 4
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 s_serveroptions+4068+64
ADDP4
CNSTI4 0
ASGNI4
line 1676
;1676:		}
LABELV $1127
line 1674
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1129
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $1126
line 1678
;1677:		
;1678:		if (gtmpl.tksMaxplayers > TKS_missing) {
ADDRGP4 gtmpl+144
INDIRI4
CNSTI4 0
LEI4 $1150
line 1679
;1679:			for (n = openSlots; n < PLAYER_SLOTS; n++) {
ADDRLP4 8
ADDRLP4 1056
INDIRI4
ASGNI4
ADDRGP4 $1138
JUMPV
LABELV $1135
line 1680
;1680:				s_serveroptions.playerType[n].curvalue = 2;
ADDRLP4 8
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 s_serveroptions+4068+64
ADDP4
CNSTI4 2
ASGNI4
line 1681
;1681:			}
LABELV $1136
line 1679
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1138
ADDRLP4 8
INDIRI4
CNSTI4 12
LTI4 $1135
line 1683
;1682:
;1683:			n = openSlots - PLAYER_SLOTS;
ADDRLP4 8
ADDRLP4 1056
INDIRI4
CNSTI4 12
SUBI4
ASGNI4
line 1684
;1684:			if (n < 0) n = 0;
ADDRLP4 8
INDIRI4
CNSTI4 0
GEI4 $1141
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $1141
line 1685
;1685:			Com_sprintf(s_serveroptions.additionalSlots.field.buffer, 3, "%i", n);
ADDRGP4 s_serveroptions+3268+60+12
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $1146
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1686
;1686:		}
line 1687
;1687:	}
line 1691
;1688:#endif
;1689:
;1690:	// close off the rest by default
;1691:	for( ;count < PLAYER_SLOTS; count++ ) {
ADDRGP4 $1150
JUMPV
LABELV $1147
line 1692
;1692:		if( s_serveroptions.playerType[count].curvalue == 1 ) {
ADDRLP4 4
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 s_serveroptions+4068+64
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1151
line 1693
;1693:			s_serveroptions.playerType[count].curvalue = 2;
ADDRLP4 4
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 s_serveroptions+4068+64
ADDP4
CNSTI4 2
ASGNI4
line 1694
;1694:		}
LABELV $1151
line 1695
;1695:	}
LABELV $1148
line 1691
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1150
ADDRLP4 4
INDIRI4
CNSTI4 12
LTI4 $1147
line 1696
;1696:}
LABELV $1001
endproc ServerOptions_InitBotNames 1076 16
bss
align 1
LABELV $1158
skip 64
code
proc ServerOptions_SetMenuItems 800 16
line 1704
;1697:
;1698:
;1699:/*
;1700:=================
;1701:ServerOptions_SetMenuItems
;1702:=================
;1703:*/
;1704:static void ServerOptions_SetMenuItems( void ) {
line 1707
;1705:	static char picname[64];
;1706:
;1707:	switch( s_serveroptions.gametype ) {
ADDRLP4 0
ADDRGP4 s_serveroptions+7504
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1159
ADDRLP4 0
INDIRI4
CNSTI4 9
GTI4 $1159
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1328
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1328
address $1162
address $1184
address $1159
address $1205
address $1231
address $1159
address $1159
address $1159
address $1256
address $1297
code
LABELV $1162
LABELV $1159
line 1710
;1708:	case GT_FFA:
;1709:	default:
;1710:		Com_sprintf( s_serveroptions.fraglimit.field.buffer, 4, "%i", (int)Com_Clamp( 0, 999, trap_Cvar_VariableValue( "ui_ffa_fraglimit" ) ) );
ADDRGP4 $599
ARGP4
ADDRLP4 4
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1148829696
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+1100+60+12
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 $1146
ARGP4
ADDRLP4 8
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1711
;1711:		Com_sprintf( s_serveroptions.timelimit.field.buffer, 4, "%i", (int)Com_Clamp( 0, 999, trap_Cvar_VariableValue( "ui_ffa_timelimit" ) ) );
ADDRGP4 $600
ARGP4
ADDRLP4 12
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1148829696
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 16
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+768+60+12
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 $1146
ARGP4
ADDRLP4 16
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1712
;1712:		Com_sprintf(s_serveroptions.gameseed.field.buffer, 6, "%i", (int)Com_Clamp(0, 65535, trap_Cvar_VariableValue("ui_ffa_gameseed")));	// JUHOX
ADDRGP4 $602
ARGP4
ADDRLP4 20
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1199570688
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 24
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+3600+60+12
ARGP4
CNSTI4 6
ARGI4
ADDRGP4 $1146
ARGP4
ADDRLP4 24
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1713
;1713:		s_serveroptions.respawnDelay = (int) Com_Clamp(0, 999, trap_Cvar_VariableValue("ui_ffa_respawndelay"));	// JUHOX
ADDRGP4 $601
ARGP4
ADDRLP4 28
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1148829696
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 32
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2564
ADDRLP4 32
INDIRF4
CVFI4 4
ASGNI4
line 1714
;1714:		s_serveroptions.noItems = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_ffa_noItems"));	// JUHOX
ADDRGP4 $603
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
ADDRGP4 s_serveroptions+2600
ADDRLP4 40
INDIRF4
CVFI4 4
ASGNI4
line 1715
;1715:		s_serveroptions.noHealthRegen = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_ffa_noHealthRegen"));	// JUHOX
ADDRGP4 $604
ARGP4
ADDRLP4 44
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 44
INDIRF4
ARGF4
ADDRLP4 48
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2604
ADDRLP4 48
INDIRF4
CVFI4 4
ASGNI4
line 1716
;1716:		s_serveroptions.unlimitedAmmo = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_ffa_unlimitedAmmo"));	// JUHOX
ADDRGP4 $605
ARGP4
ADDRLP4 52
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 52
INDIRF4
ARGF4
ADDRLP4 56
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2608
ADDRLP4 56
INDIRF4
CVFI4 4
ASGNI4
line 1717
;1717:		s_serveroptions.cloakingDevice = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_ffa_cloakingDevice"));	// JUHOX
ADDRGP4 $606
ARGP4
ADDRLP4 60
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 64
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2612
ADDRLP4 64
INDIRF4
CVFI4 4
ASGNI4
line 1718
;1718:		s_serveroptions.weaponLimit = (int) Com_Clamp(0, MAX_WEAPONS, trap_Cvar_VariableValue("ui_ffa_weaponLimit"));	// JUHOX
ADDRGP4 $607
ARGP4
ADDRLP4 68
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1098907648
ARGF4
ADDRLP4 68
INDIRF4
ARGF4
ADDRLP4 72
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2616
ADDRLP4 72
INDIRF4
CVFI4 4
ASGNI4
line 1720
;1719:#if MONSTER_MODE
;1720:		s_serveroptions.monsterLauncher = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_ffa_monsterLauncher"));	// JUHOX
ADDRGP4 $608
ARGP4
ADDRLP4 76
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 76
INDIRF4
ARGF4
ADDRLP4 80
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2620
ADDRLP4 80
INDIRF4
CVFI4 4
ASGNI4
line 1721
;1721:		s_serveroptions.maxMonsters = (int) Com_Clamp(1, MAX_MONSTERS, trap_Cvar_VariableValue("ui_ffa_maxMonsters"));	// JUHOX
ADDRGP4 $609
ARGP4
ADDRLP4 84
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 1065353216
ARGF4
CNSTF4 1128792064
ARGF4
ADDRLP4 84
INDIRF4
ARGF4
ADDRLP4 88
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2628
ADDRLP4 88
INDIRF4
CVFI4 4
ASGNI4
line 1722
;1722:		s_serveroptions.maxMonstersPerPlayer = (int) Com_Clamp(1, MAX_MONSTERS, trap_Cvar_VariableValue("ui_ffa_maxMonstersPP"));	// JUHOX
ADDRGP4 $610
ARGP4
ADDRLP4 92
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 1065353216
ARGF4
CNSTF4 1128792064
ARGF4
ADDRLP4 92
INDIRF4
ARGF4
ADDRLP4 96
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2632
ADDRLP4 96
INDIRF4
CVFI4 4
ASGNI4
line 1723
;1723:		s_serveroptions.monsterHealthScale = (int) Com_Clamp(1, 1000, trap_Cvar_VariableValue("ui_ffa_monsterHealthScale"));	// JUHOX
ADDRGP4 $611
ARGP4
ADDRLP4 100
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 1065353216
ARGF4
CNSTF4 1148846080
ARGF4
ADDRLP4 100
INDIRF4
ARGF4
ADDRLP4 104
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2652
ADDRLP4 104
INDIRF4
CVFI4 4
ASGNI4
line 1726
;1724:#endif
;1725:#if MEETING
;1726:		s_serveroptions.meeting.curvalue = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_ffa_meeting"));	// JUHOX
ADDRGP4 $612
ARGP4
ADDRLP4 108
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 108
INDIRF4
ARGF4
ADDRLP4 112
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+3932+60
ADDRLP4 112
INDIRF4
CVFI4 4
ASGNI4
line 1728
;1727:#endif
;1728:		break;
ADDRGP4 $1160
JUMPV
LABELV $1184
line 1731
;1729:
;1730:	case GT_TOURNAMENT:
;1731:		Com_sprintf( s_serveroptions.fraglimit.field.buffer, 4, "%i", (int)Com_Clamp( 0, 999, trap_Cvar_VariableValue( "ui_tourney_fraglimit" ) ) );
ADDRGP4 $614
ARGP4
ADDRLP4 116
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1148829696
ARGF4
ADDRLP4 116
INDIRF4
ARGF4
ADDRLP4 120
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+1100+60+12
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 $1146
ARGP4
ADDRLP4 120
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1732
;1732:		Com_sprintf( s_serveroptions.timelimit.field.buffer, 4, "%i", (int)Com_Clamp( 0, 999, trap_Cvar_VariableValue( "ui_tourney_timelimit" ) ) );
ADDRGP4 $615
ARGP4
ADDRLP4 124
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1148829696
ARGF4
ADDRLP4 124
INDIRF4
ARGF4
ADDRLP4 128
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+768+60+12
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 $1146
ARGP4
ADDRLP4 128
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1733
;1733:		Com_sprintf(s_serveroptions.gameseed.field.buffer, 6, "%i", (int)Com_Clamp(0, 65535, trap_Cvar_VariableValue("ui_tourney_gameseed")));	// JUHOX
ADDRGP4 $616
ARGP4
ADDRLP4 132
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1199570688
ARGF4
ADDRLP4 132
INDIRF4
ARGF4
ADDRLP4 136
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+3600+60+12
ARGP4
CNSTI4 6
ARGI4
ADDRGP4 $1146
ARGP4
ADDRLP4 136
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1734
;1734:		s_serveroptions.noItems = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_tourney_noItems"));	// JUHOX
ADDRGP4 $617
ARGP4
ADDRLP4 140
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 140
INDIRF4
ARGF4
ADDRLP4 144
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2600
ADDRLP4 144
INDIRF4
CVFI4 4
ASGNI4
line 1735
;1735:		s_serveroptions.noHealthRegen = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_tourney_noHealthRegen"));	// JUHOX
ADDRGP4 $618
ARGP4
ADDRLP4 148
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 148
INDIRF4
ARGF4
ADDRLP4 152
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2604
ADDRLP4 152
INDIRF4
CVFI4 4
ASGNI4
line 1736
;1736:		s_serveroptions.unlimitedAmmo = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_tourney_unlimitedAmmo"));	// JUHOX
ADDRGP4 $619
ARGP4
ADDRLP4 156
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 156
INDIRF4
ARGF4
ADDRLP4 160
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2608
ADDRLP4 160
INDIRF4
CVFI4 4
ASGNI4
line 1737
;1737:		s_serveroptions.cloakingDevice = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_tourney_cloakingDevice"));	// JUHOX
ADDRGP4 $620
ARGP4
ADDRLP4 164
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 164
INDIRF4
ARGF4
ADDRLP4 168
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2612
ADDRLP4 168
INDIRF4
CVFI4 4
ASGNI4
line 1738
;1738:		s_serveroptions.weaponLimit = (int) Com_Clamp(0, MAX_WEAPONS, trap_Cvar_VariableValue("ui_tourney_weaponLimit"));	// JUHOX
ADDRGP4 $621
ARGP4
ADDRLP4 172
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1098907648
ARGF4
ADDRLP4 172
INDIRF4
ARGF4
ADDRLP4 176
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2616
ADDRLP4 176
INDIRF4
CVFI4 4
ASGNI4
line 1740
;1739:#if MONSTER_MODE
;1740:		s_serveroptions.monsterLauncher = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_tourney_monsterLauncher"));	// JUHOX
ADDRGP4 $622
ARGP4
ADDRLP4 180
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 180
INDIRF4
ARGF4
ADDRLP4 184
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2620
ADDRLP4 184
INDIRF4
CVFI4 4
ASGNI4
line 1741
;1741:		s_serveroptions.maxMonsters = (int) Com_Clamp(1, MAX_MONSTERS, trap_Cvar_VariableValue("ui_tourney_maxMonsters"));	// JUHOX
ADDRGP4 $623
ARGP4
ADDRLP4 188
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 1065353216
ARGF4
CNSTF4 1128792064
ARGF4
ADDRLP4 188
INDIRF4
ARGF4
ADDRLP4 192
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2628
ADDRLP4 192
INDIRF4
CVFI4 4
ASGNI4
line 1742
;1742:		s_serveroptions.maxMonstersPerPlayer = (int) Com_Clamp(1, MAX_MONSTERS, trap_Cvar_VariableValue("ui_tourney_maxMonstersPP"));	// JUHOX
ADDRGP4 $624
ARGP4
ADDRLP4 196
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 1065353216
ARGF4
CNSTF4 1128792064
ARGF4
ADDRLP4 196
INDIRF4
ARGF4
ADDRLP4 200
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2632
ADDRLP4 200
INDIRF4
CVFI4 4
ASGNI4
line 1743
;1743:		s_serveroptions.monsterHealthScale = (int) Com_Clamp(1, 1000, trap_Cvar_VariableValue("ui_tourney_monsterHealthScale"));	// JUHOX
ADDRGP4 $625
ARGP4
ADDRLP4 204
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 1065353216
ARGF4
CNSTF4 1148846080
ARGF4
ADDRLP4 204
INDIRF4
ARGF4
ADDRLP4 208
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2652
ADDRLP4 208
INDIRF4
CVFI4 4
ASGNI4
line 1746
;1744:#endif
;1745:#if MEETING
;1746:		s_serveroptions.meeting.curvalue = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_tourney_meeting"));	// JUHOX
ADDRGP4 $626
ARGP4
ADDRLP4 212
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 212
INDIRF4
ARGF4
ADDRLP4 216
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+3932+60
ADDRLP4 216
INDIRF4
CVFI4 4
ASGNI4
line 1748
;1747:#endif
;1748:		break;
ADDRGP4 $1160
JUMPV
LABELV $1205
line 1751
;1749:
;1750:	case GT_TEAM:
;1751:		Com_sprintf( s_serveroptions.fraglimit.field.buffer, 4, "%i", (int)Com_Clamp( 0, 999, trap_Cvar_VariableValue( "ui_team_fraglimit" ) ) );
ADDRGP4 $628
ARGP4
ADDRLP4 220
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1148829696
ARGF4
ADDRLP4 220
INDIRF4
ARGF4
ADDRLP4 224
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+1100+60+12
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 $1146
ARGP4
ADDRLP4 224
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1752
;1752:		Com_sprintf( s_serveroptions.timelimit.field.buffer, 4, "%i", (int)Com_Clamp( 0, 999, trap_Cvar_VariableValue( "ui_team_timelimit" ) ) );
ADDRGP4 $629
ARGP4
ADDRLP4 228
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1148829696
ARGF4
ADDRLP4 228
INDIRF4
ARGF4
ADDRLP4 232
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+768+60+12
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 $1146
ARGP4
ADDRLP4 232
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1753
;1753:		s_serveroptions.friendlyfire.curvalue = (int)Com_Clamp( 0, 1, trap_Cvar_VariableValue( "ui_team_friendly" ) );
ADDRGP4 $630
ARGP4
ADDRLP4 236
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 236
INDIRF4
ARGF4
ADDRLP4 240
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2428+60
ADDRLP4 240
INDIRF4
CVFI4 4
ASGNI4
line 1754
;1754:		Com_sprintf(s_serveroptions.gameseed.field.buffer, 6, "%i", (int)Com_Clamp(0, 65535, trap_Cvar_VariableValue("ui_team_gameseed")));	// JUHOX
ADDRGP4 $632
ARGP4
ADDRLP4 244
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1199570688
ARGF4
ADDRLP4 244
INDIRF4
ARGF4
ADDRLP4 248
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+3600+60+12
ARGP4
CNSTI4 6
ARGI4
ADDRGP4 $1146
ARGP4
ADDRLP4 248
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1755
;1755:		s_serveroptions.respawnDelay = (int) Com_Clamp(0, 999, trap_Cvar_VariableValue("ui_team_respawnDelay"));	// JUHOX
ADDRGP4 $1218
ARGP4
ADDRLP4 252
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1148829696
ARGF4
ADDRLP4 252
INDIRF4
ARGF4
ADDRLP4 256
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2564
ADDRLP4 256
INDIRF4
CVFI4 4
ASGNI4
line 1756
;1756:		s_serveroptions.tss = (int)Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_team_tss"));	// JUHOX
ADDRGP4 $633
ARGP4
ADDRLP4 260
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 260
INDIRF4
ARGF4
ADDRLP4 264
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2572
ADDRLP4 264
INDIRF4
CVFI4 4
ASGNI4
line 1757
;1757:		s_serveroptions.noItems = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_team_noItems"));	// JUHOX
ADDRGP4 $634
ARGP4
ADDRLP4 268
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 268
INDIRF4
ARGF4
ADDRLP4 272
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2600
ADDRLP4 272
INDIRF4
CVFI4 4
ASGNI4
line 1758
;1758:		s_serveroptions.noHealthRegen = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_team_noHealthRegen"));	// JUHOX
ADDRGP4 $635
ARGP4
ADDRLP4 276
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 276
INDIRF4
ARGF4
ADDRLP4 280
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2604
ADDRLP4 280
INDIRF4
CVFI4 4
ASGNI4
line 1759
;1759:		s_serveroptions.unlimitedAmmo = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_team_unlimitedAmmo"));	// JUHOX
ADDRGP4 $636
ARGP4
ADDRLP4 284
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 284
INDIRF4
ARGF4
ADDRLP4 288
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2608
ADDRLP4 288
INDIRF4
CVFI4 4
ASGNI4
line 1760
;1760:		s_serveroptions.cloakingDevice = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_team_cloakingDevice"));	// JUHOX
ADDRGP4 $637
ARGP4
ADDRLP4 292
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 292
INDIRF4
ARGF4
ADDRLP4 296
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2612
ADDRLP4 296
INDIRF4
CVFI4 4
ASGNI4
line 1761
;1761:		s_serveroptions.weaponLimit = (int) Com_Clamp(0, MAX_WEAPONS, trap_Cvar_VariableValue("ui_team_weaponLimit"));	// JUHOX
ADDRGP4 $638
ARGP4
ADDRLP4 300
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1098907648
ARGF4
ADDRLP4 300
INDIRF4
ARGF4
ADDRLP4 304
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2616
ADDRLP4 304
INDIRF4
CVFI4 4
ASGNI4
line 1763
;1762:#if MONSTER_MODE
;1763:		s_serveroptions.monsterLauncher = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_team_monsterLauncher"));	// JUHOX
ADDRGP4 $639
ARGP4
ADDRLP4 308
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 308
INDIRF4
ARGF4
ADDRLP4 312
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2620
ADDRLP4 312
INDIRF4
CVFI4 4
ASGNI4
line 1764
;1764:		s_serveroptions.maxMonsters = (int) Com_Clamp(1, MAX_MONSTERS, trap_Cvar_VariableValue("ui_team_maxMonsters"));	// JUHOX
ADDRGP4 $640
ARGP4
ADDRLP4 316
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 1065353216
ARGF4
CNSTF4 1128792064
ARGF4
ADDRLP4 316
INDIRF4
ARGF4
ADDRLP4 320
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2628
ADDRLP4 320
INDIRF4
CVFI4 4
ASGNI4
line 1765
;1765:		s_serveroptions.maxMonstersPerPlayer = (int) Com_Clamp(1, MAX_MONSTERS, trap_Cvar_VariableValue("ui_team_maxMonstersPP"));	// JUHOX
ADDRGP4 $641
ARGP4
ADDRLP4 324
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 1065353216
ARGF4
CNSTF4 1128792064
ARGF4
ADDRLP4 324
INDIRF4
ARGF4
ADDRLP4 328
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2632
ADDRLP4 328
INDIRF4
CVFI4 4
ASGNI4
line 1766
;1766:		s_serveroptions.monsterHealthScale = (int) Com_Clamp(1, 1000, trap_Cvar_VariableValue("ui_team_monsterHealthScale"));	// JUHOX
ADDRGP4 $642
ARGP4
ADDRLP4 332
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 1065353216
ARGF4
CNSTF4 1148846080
ARGF4
ADDRLP4 332
INDIRF4
ARGF4
ADDRLP4 336
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2652
ADDRLP4 336
INDIRF4
CVFI4 4
ASGNI4
line 1769
;1767:#endif
;1768:#if MEETING
;1769:		s_serveroptions.meeting.curvalue = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_team_meeting"));	// JUHOX
ADDRGP4 $643
ARGP4
ADDRLP4 340
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 340
INDIRF4
ARGF4
ADDRLP4 344
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+3932+60
ADDRLP4 344
INDIRF4
CVFI4 4
ASGNI4
line 1771
;1770:#endif
;1771:		break;
ADDRGP4 $1160
JUMPV
LABELV $1231
line 1774
;1772:
;1773:	case GT_CTF:
;1774:		Com_sprintf( s_serveroptions.flaglimit.field.buffer, 4, "%i", (int)Com_Clamp( 0, 100, trap_Cvar_VariableValue( "ui_ctf_capturelimit" ) ) );
ADDRGP4 $645
ARGP4
ADDRLP4 348
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1120403456
ARGF4
ADDRLP4 348
INDIRF4
ARGF4
ADDRLP4 352
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+1432+60+12
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 $1146
ARGP4
ADDRLP4 352
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1775
;1775:		Com_sprintf( s_serveroptions.timelimit.field.buffer, 4, "%i", (int)Com_Clamp( 0, 999, trap_Cvar_VariableValue( "ui_ctf_timelimit" ) ) );
ADDRGP4 $646
ARGP4
ADDRLP4 356
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1148829696
ARGF4
ADDRLP4 356
INDIRF4
ARGF4
ADDRLP4 360
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+768+60+12
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 $1146
ARGP4
ADDRLP4 360
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1776
;1776:		s_serveroptions.friendlyfire.curvalue = (int)Com_Clamp( 0, 1, trap_Cvar_VariableValue( "ui_ctf_friendly" ) );
ADDRGP4 $647
ARGP4
ADDRLP4 364
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 364
INDIRF4
ARGF4
ADDRLP4 368
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2428+60
ADDRLP4 368
INDIRF4
CVFI4 4
ASGNI4
line 1777
;1777:		Com_sprintf(s_serveroptions.gameseed.field.buffer, 6, "%i", (int)Com_Clamp(0, 65535, trap_Cvar_VariableValue("ui_ctf_gameseed")));	// JUHOX
ADDRGP4 $649
ARGP4
ADDRLP4 372
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1199570688
ARGF4
ADDRLP4 372
INDIRF4
ARGF4
ADDRLP4 376
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+3600+60+12
ARGP4
CNSTI4 6
ARGI4
ADDRGP4 $1146
ARGP4
ADDRLP4 376
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1778
;1778:		s_serveroptions.respawnDelay = (int) Com_Clamp(0, 999, trap_Cvar_VariableValue("ui_ctf_respawndelay"));	// JUHOX
ADDRGP4 $648
ARGP4
ADDRLP4 380
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1148829696
ARGF4
ADDRLP4 380
INDIRF4
ARGF4
ADDRLP4 384
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2564
ADDRLP4 384
INDIRF4
CVFI4 4
ASGNI4
line 1779
;1779:		s_serveroptions.tss = (int)Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_ctf_tss"));	// JUHOX
ADDRGP4 $650
ARGP4
ADDRLP4 388
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 388
INDIRF4
ARGF4
ADDRLP4 392
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2572
ADDRLP4 392
INDIRF4
CVFI4 4
ASGNI4
line 1780
;1780:		s_serveroptions.noItems = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_ctf_noItems"));	// JUHOX
ADDRGP4 $651
ARGP4
ADDRLP4 396
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 396
INDIRF4
ARGF4
ADDRLP4 400
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2600
ADDRLP4 400
INDIRF4
CVFI4 4
ASGNI4
line 1781
;1781:		s_serveroptions.noHealthRegen = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_ctf_noHealthRegen"));	// JUHOX
ADDRGP4 $652
ARGP4
ADDRLP4 404
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 404
INDIRF4
ARGF4
ADDRLP4 408
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2604
ADDRLP4 408
INDIRF4
CVFI4 4
ASGNI4
line 1782
;1782:		s_serveroptions.unlimitedAmmo = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_ctf_unlimitedAmmo"));	// JUHOX
ADDRGP4 $653
ARGP4
ADDRLP4 412
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 412
INDIRF4
ARGF4
ADDRLP4 416
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2608
ADDRLP4 416
INDIRF4
CVFI4 4
ASGNI4
line 1783
;1783:		s_serveroptions.cloakingDevice = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_ctf_cloakingDevice"));	// JUHOX
ADDRGP4 $654
ARGP4
ADDRLP4 420
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 420
INDIRF4
ARGF4
ADDRLP4 424
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2612
ADDRLP4 424
INDIRF4
CVFI4 4
ASGNI4
line 1784
;1784:		s_serveroptions.weaponLimit = (int) Com_Clamp(0, MAX_WEAPONS, trap_Cvar_VariableValue("ui_ctf_weaponLimit"));	// JUHOX
ADDRGP4 $655
ARGP4
ADDRLP4 428
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1098907648
ARGF4
ADDRLP4 428
INDIRF4
ARGF4
ADDRLP4 432
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2616
ADDRLP4 432
INDIRF4
CVFI4 4
ASGNI4
line 1786
;1785:#if MONSTER_MODE
;1786:		s_serveroptions.monsterLauncher = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_ctf_monsterLauncher"));	// JUHOX
ADDRGP4 $656
ARGP4
ADDRLP4 436
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 436
INDIRF4
ARGF4
ADDRLP4 440
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2620
ADDRLP4 440
INDIRF4
CVFI4 4
ASGNI4
line 1787
;1787:		s_serveroptions.maxMonsters = (int) Com_Clamp(1, MAX_MONSTERS, trap_Cvar_VariableValue("ui_ctf_maxMonsters"));	// JUHOX
ADDRGP4 $657
ARGP4
ADDRLP4 444
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 1065353216
ARGF4
CNSTF4 1128792064
ARGF4
ADDRLP4 444
INDIRF4
ARGF4
ADDRLP4 448
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2628
ADDRLP4 448
INDIRF4
CVFI4 4
ASGNI4
line 1788
;1788:		s_serveroptions.maxMonstersPerPlayer = (int) Com_Clamp(1, MAX_MONSTERS, trap_Cvar_VariableValue("ui_ctf_maxMonstersPP"));	// JUHOX
ADDRGP4 $658
ARGP4
ADDRLP4 452
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 1065353216
ARGF4
CNSTF4 1128792064
ARGF4
ADDRLP4 452
INDIRF4
ARGF4
ADDRLP4 456
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2632
ADDRLP4 456
INDIRF4
CVFI4 4
ASGNI4
line 1789
;1789:		s_serveroptions.monsterHealthScale = (int) Com_Clamp(1, 1000, trap_Cvar_VariableValue("ui_ctf_monsterHealthScale"));	// JUHOX
ADDRGP4 $659
ARGP4
ADDRLP4 460
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 1065353216
ARGF4
CNSTF4 1148846080
ARGF4
ADDRLP4 460
INDIRF4
ARGF4
ADDRLP4 464
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2652
ADDRLP4 464
INDIRF4
CVFI4 4
ASGNI4
line 1792
;1790:#endif
;1791:#if MEETING
;1792:		s_serveroptions.meeting.curvalue = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_ctf_meeting"));	// JUHOX
ADDRGP4 $660
ARGP4
ADDRLP4 468
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 468
INDIRF4
ARGF4
ADDRLP4 472
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+3932+60
ADDRLP4 472
INDIRF4
CVFI4 4
ASGNI4
line 1794
;1793:#endif
;1794:		break;
ADDRGP4 $1160
JUMPV
LABELV $1256
line 1798
;1795:	
;1796:#if MONSTER_MODE	// JUHOX: read STU ui cvars
;1797:	case GT_STU:
;1798:		Com_sprintf(s_serveroptions.fraglimit.field.buffer, 4, "%i", (int)Com_Clamp(0, 999, trap_Cvar_VariableValue("ui_stu_fraglimit")));
ADDRGP4 $662
ARGP4
ADDRLP4 476
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1148829696
ARGF4
ADDRLP4 476
INDIRF4
ARGF4
ADDRLP4 480
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+1100+60+12
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 $1146
ARGP4
ADDRLP4 480
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1799
;1799:		Com_sprintf(s_serveroptions.timelimit.field.buffer, 4, "%i", (int)Com_Clamp(0, 999, trap_Cvar_VariableValue("ui_stu_timelimit")));
ADDRGP4 $663
ARGP4
ADDRLP4 484
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1148829696
ARGF4
ADDRLP4 484
INDIRF4
ARGF4
ADDRLP4 488
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+768+60+12
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 $1146
ARGP4
ADDRLP4 488
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1800
;1800:		Com_sprintf(s_serveroptions.artefacts.field.buffer, 4, "%i", (int)Com_Clamp(0, 999, trap_Cvar_VariableValue("ui_stu_artefacts")));
ADDRGP4 $700
ARGP4
ADDRLP4 492
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1148829696
ARGF4
ADDRLP4 492
INDIRF4
ARGF4
ADDRLP4 496
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+1764+60+12
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 $1146
ARGP4
ADDRLP4 496
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1801
;1801:		s_serveroptions.friendlyfire.curvalue = (int)Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_stu_friendly"));
ADDRGP4 $664
ARGP4
ADDRLP4 500
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 500
INDIRF4
ARGF4
ADDRLP4 504
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2428+60
ADDRLP4 504
INDIRF4
CVFI4 4
ASGNI4
line 1802
;1802:		Com_sprintf(s_serveroptions.gameseed.field.buffer, 6, "%i", (int)Com_Clamp(0, 65535, trap_Cvar_VariableValue("ui_stu_gameseed")));
ADDRGP4 $666
ARGP4
ADDRLP4 508
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1199570688
ARGF4
ADDRLP4 508
INDIRF4
ARGF4
ADDRLP4 512
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+3600+60+12
ARGP4
CNSTI4 6
ARGI4
ADDRGP4 $1146
ARGP4
ADDRLP4 512
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1803
;1803:		s_serveroptions.respawnDelay = (int) Com_Clamp(0, 999, trap_Cvar_VariableValue("ui_stu_respawnDelay"));
ADDRGP4 $1272
ARGP4
ADDRLP4 516
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1148829696
ARGF4
ADDRLP4 516
INDIRF4
ARGF4
ADDRLP4 520
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2564
ADDRLP4 520
INDIRF4
CVFI4 4
ASGNI4
line 1804
;1804:		s_serveroptions.tss = (int)Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_stu_tss"));
ADDRGP4 $1274
ARGP4
ADDRLP4 524
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 524
INDIRF4
ARGF4
ADDRLP4 528
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2572
ADDRLP4 528
INDIRF4
CVFI4 4
ASGNI4
line 1805
;1805:		s_serveroptions.noItems = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_stu_noItems"));
ADDRGP4 $667
ARGP4
ADDRLP4 532
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 532
INDIRF4
ARGF4
ADDRLP4 536
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2600
ADDRLP4 536
INDIRF4
CVFI4 4
ASGNI4
line 1806
;1806:		s_serveroptions.noHealthRegen = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_stu_noHealthRegen"));
ADDRGP4 $668
ARGP4
ADDRLP4 540
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 540
INDIRF4
ARGF4
ADDRLP4 544
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2604
ADDRLP4 544
INDIRF4
CVFI4 4
ASGNI4
line 1807
;1807:		s_serveroptions.unlimitedAmmo = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_stu_unlimitedAmmo"));
ADDRGP4 $669
ARGP4
ADDRLP4 548
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 548
INDIRF4
ARGF4
ADDRLP4 552
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2608
ADDRLP4 552
INDIRF4
CVFI4 4
ASGNI4
line 1808
;1808:		s_serveroptions.cloakingDevice = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_stu_cloakingDevice"));
ADDRGP4 $670
ARGP4
ADDRLP4 556
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 556
INDIRF4
ARGF4
ADDRLP4 560
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2612
ADDRLP4 560
INDIRF4
CVFI4 4
ASGNI4
line 1809
;1809:		s_serveroptions.weaponLimit = (int) Com_Clamp(0, MAX_WEAPONS, trap_Cvar_VariableValue("ui_stu_weaponLimit"));
ADDRGP4 $671
ARGP4
ADDRLP4 564
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1098907648
ARGF4
ADDRLP4 564
INDIRF4
ARGF4
ADDRLP4 568
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2616
ADDRLP4 568
INDIRF4
CVFI4 4
ASGNI4
line 1811
;1810:
;1811:		s_serveroptions.maxMonsters = (int) Com_Clamp(1, MAX_MONSTERS, trap_Cvar_VariableValue("ui_stu_maxMonsters"));
ADDRGP4 $672
ARGP4
ADDRLP4 572
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 1065353216
ARGF4
CNSTF4 1128792064
ARGF4
ADDRLP4 572
INDIRF4
ARGF4
ADDRLP4 576
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2628
ADDRLP4 576
INDIRF4
CVFI4 4
ASGNI4
line 1812
;1812:		s_serveroptions.minMonsters = (int) Com_Clamp(0, MAX_MONSTERS, trap_Cvar_VariableValue("ui_stu_minMonsters"));
ADDRGP4 $673
ARGP4
ADDRLP4 580
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1128792064
ARGF4
ADDRLP4 580
INDIRF4
ARGF4
ADDRLP4 584
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2624
ADDRLP4 584
INDIRF4
CVFI4 4
ASGNI4
line 1813
;1813:		s_serveroptions.monstersPerTrap = (int) Com_Clamp(0, MAX_MONSTERS, trap_Cvar_VariableValue("ui_stu_monstersPerTrap"));
ADDRGP4 $675
ARGP4
ADDRLP4 588
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1128792064
ARGF4
ADDRLP4 588
INDIRF4
ARGF4
ADDRLP4 592
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2636
ADDRLP4 592
INDIRF4
CVFI4 4
ASGNI4
line 1814
;1814:		s_serveroptions.monsterSpawnDelay = (int) Com_Clamp(1, 999999, trap_Cvar_VariableValue("ui_stu_monsterSpawnDelay"));
ADDRGP4 $679
ARGP4
ADDRLP4 596
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 1065353216
ARGF4
CNSTF4 1232348144
ARGF4
ADDRLP4 596
INDIRF4
ARGF4
ADDRLP4 600
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2640
ADDRLP4 600
INDIRF4
CVFI4 4
ASGNI4
line 1815
;1815:		if (s_serveroptions.monsterSpawnDelay < 200) s_serveroptions.monsterSpawnDelay *= 1000;	// JUHOX FIXME: to support old values
ADDRGP4 s_serveroptions+2640
INDIRI4
CNSTI4 200
GEI4 $1284
ADDRLP4 604
ADDRGP4 s_serveroptions+2640
ASGNP4
ADDRLP4 604
INDIRP4
ADDRLP4 604
INDIRP4
INDIRI4
CNSTI4 1000
MULI4
ASGNI4
LABELV $1284
line 1816
;1816:		s_serveroptions.monsterGuards = (int) Com_Clamp(0, 100, trap_Cvar_VariableValue("ui_stu_monsterGuards"));
ADDRGP4 $688
ARGP4
ADDRLP4 608
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1120403456
ARGF4
ADDRLP4 608
INDIRF4
ARGF4
ADDRLP4 612
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2644
ADDRLP4 612
INDIRF4
CVFI4 4
ASGNI4
line 1817
;1817:		s_serveroptions.monsterTitans = (int) Com_Clamp(0, 100, trap_Cvar_VariableValue("ui_stu_monsterTitans"));
ADDRGP4 $692
ARGP4
ADDRLP4 616
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1120403456
ARGF4
ADDRLP4 616
INDIRF4
ARGF4
ADDRLP4 620
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2648
ADDRLP4 620
INDIRF4
CVFI4 4
ASGNI4
line 1818
;1818:		s_serveroptions.monsterHealthScale = (int) Com_Clamp(1, 1000, trap_Cvar_VariableValue("ui_stu_monsterHealthScale"));
ADDRGP4 $683
ARGP4
ADDRLP4 624
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 1065353216
ARGF4
CNSTF4 1148846080
ARGF4
ADDRLP4 624
INDIRF4
ARGF4
ADDRLP4 628
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2652
ADDRLP4 628
INDIRF4
CVFI4 4
ASGNI4
line 1819
;1819:		s_serveroptions.monsterProgression = (int) Com_Clamp(0, 1000, trap_Cvar_VariableValue("ui_stu_monsterProgression"));
ADDRGP4 $684
ARGP4
ADDRLP4 632
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1148846080
ARGF4
ADDRLP4 632
INDIRF4
ARGF4
ADDRLP4 636
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2656
ADDRLP4 636
INDIRF4
CVFI4 4
ASGNI4
line 1820
;1820:		s_serveroptions.monsterBreeding = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_stu_monsterBreeding"));
ADDRGP4 $696
ARGP4
ADDRLP4 640
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 640
INDIRF4
ARGF4
ADDRLP4 644
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2660
ADDRLP4 644
INDIRF4
CVFI4 4
ASGNI4
line 1821
;1821:		s_serveroptions.skipEndSequence = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("g_skipEndSequence"));
ADDRGP4 $708
ARGP4
ADDRLP4 648
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 648
INDIRF4
ARGF4
ADDRLP4 652
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2760
ADDRLP4 652
INDIRF4
CVFI4 4
ASGNI4
line 1822
;1822:		s_serveroptions.monsterLauncher = qfalse;
ADDRGP4 s_serveroptions+2620
CNSTI4 0
ASGNI4
line 1824
;1823:#if MEETING
;1824:		s_serveroptions.meeting.curvalue = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_stu_meeting"));	// JUHOX
ADDRGP4 $710
ARGP4
ADDRLP4 656
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 656
INDIRF4
ARGF4
ADDRLP4 660
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+3932+60
ADDRLP4 660
INDIRF4
CVFI4 4
ASGNI4
line 1826
;1825:#endif
;1826:		break;
ADDRGP4 $1160
JUMPV
LABELV $1297
line 1831
;1827:#endif
;1828:
;1829:#if ESCAPE_MODE	// JUHOX: read EFH ui cvars
;1830:	case GT_EFH:
;1831:		Com_sprintf(s_serveroptions.fraglimit.field.buffer, 4, "%i", (int)Com_Clamp(0, 999, trap_Cvar_VariableValue("ui_efh_fraglimit")));
ADDRGP4 $712
ARGP4
ADDRLP4 664
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1148829696
ARGF4
ADDRLP4 664
INDIRF4
ARGF4
ADDRLP4 668
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+1100+60+12
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 $1146
ARGP4
ADDRLP4 668
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1832
;1832:		Com_sprintf(s_serveroptions.timelimit.field.buffer, 4, "%i", (int)Com_Clamp(0, 999, trap_Cvar_VariableValue("ui_efh_timelimit")));
ADDRGP4 $713
ARGP4
ADDRLP4 672
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1148829696
ARGF4
ADDRLP4 672
INDIRF4
ARGF4
ADDRLP4 676
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+768+60+12
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 $1146
ARGP4
ADDRLP4 676
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1833
;1833:		Com_sprintf(s_serveroptions.distanceLimit.field.buffer, 10, "%f", Com_Clamp(0, 100, 0.001 * trap_Cvar_VariableValue("ui_efh_distancelimit")));
ADDRGP4 $714
ARGP4
ADDRLP4 680
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1120403456
ARGF4
ADDRLP4 680
INDIRF4
CNSTF4 981668463
MULF4
ARGF4
ADDRLP4 684
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2096+60+12
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $1307
ARGP4
ADDRLP4 684
INDIRF4
ARGF4
ADDRGP4 Com_sprintf
CALLV
pop
line 1834
;1834:		s_serveroptions.friendlyfire.curvalue = (int)Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_efh_friendly"));
ADDRGP4 $722
ARGP4
ADDRLP4 688
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 688
INDIRF4
ARGF4
ADDRLP4 692
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2428+60
ADDRLP4 692
INDIRF4
CVFI4 4
ASGNI4
line 1835
;1835:		Com_sprintf(s_serveroptions.gameseed.field.buffer, 6, "%i", (int)Com_Clamp(0, 65535, trap_Cvar_VariableValue("ui_efh_gameseed")));
ADDRGP4 $723
ARGP4
ADDRLP4 696
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1199570688
ARGF4
ADDRLP4 696
INDIRF4
ARGF4
ADDRLP4 700
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+3600+60+12
ARGP4
CNSTI4 6
ARGI4
ADDRGP4 $1146
ARGP4
ADDRLP4 700
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1836
;1836:		s_serveroptions.tss = qfalse;
ADDRGP4 s_serveroptions+2572
CNSTI4 0
ASGNI4
line 1837
;1837:		s_serveroptions.monsterLauncher = qfalse;
ADDRGP4 s_serveroptions+2620
CNSTI4 0
ASGNI4
line 1838
;1838:		s_serveroptions.noItems = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_efh_noItems"));
ADDRGP4 $724
ARGP4
ADDRLP4 704
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 704
INDIRF4
ARGF4
ADDRLP4 708
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2600
ADDRLP4 708
INDIRF4
CVFI4 4
ASGNI4
line 1839
;1839:		s_serveroptions.noHealthRegen = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_efh_noHealthRegen"));
ADDRGP4 $725
ARGP4
ADDRLP4 712
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 712
INDIRF4
ARGF4
ADDRLP4 716
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2604
ADDRLP4 716
INDIRF4
CVFI4 4
ASGNI4
line 1840
;1840:		s_serveroptions.unlimitedAmmo = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_efh_unlimitedAmmo"));
ADDRGP4 $726
ARGP4
ADDRLP4 720
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 720
INDIRF4
ARGF4
ADDRLP4 724
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2608
ADDRLP4 724
INDIRF4
CVFI4 4
ASGNI4
line 1841
;1841:		s_serveroptions.cloakingDevice = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_efh_cloakingDevice"));
ADDRGP4 $727
ARGP4
ADDRLP4 728
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 728
INDIRF4
ARGF4
ADDRLP4 732
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2612
ADDRLP4 732
INDIRF4
CVFI4 4
ASGNI4
line 1842
;1842:		s_serveroptions.weaponLimit = (int) Com_Clamp(0, MAX_WEAPONS, trap_Cvar_VariableValue("ui_efh_weaponLimit"));
ADDRGP4 $728
ARGP4
ADDRLP4 736
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1098907648
ARGF4
ADDRLP4 736
INDIRF4
ARGF4
ADDRLP4 740
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2616
ADDRLP4 740
INDIRF4
CVFI4 4
ASGNI4
line 1843
;1843:		s_serveroptions.monsterLoad = (int) Com_Clamp(0, 1000, trap_Cvar_VariableValue("ui_efh_monsterLoad"));
ADDRGP4 $729
ARGP4
ADDRLP4 744
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1148846080
ARGF4
ADDRLP4 744
INDIRF4
ARGF4
ADDRLP4 748
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2768
ADDRLP4 748
INDIRF4
CVFI4 4
ASGNI4
line 1844
;1844:		s_serveroptions.challengingEnv = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_efh_challengingEnv"));
ADDRGP4 $733
ARGP4
ADDRLP4 752
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 752
INDIRF4
ARGF4
ADDRLP4 756
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2772
ADDRLP4 756
INDIRF4
CVFI4 4
ASGNI4
line 1845
;1845:		s_serveroptions.monsterGuards = (int) Com_Clamp(0, 100, trap_Cvar_VariableValue("ui_efh_monsterGuards"));
ADDRGP4 $737
ARGP4
ADDRLP4 760
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1120403456
ARGF4
ADDRLP4 760
INDIRF4
ARGF4
ADDRLP4 764
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2644
ADDRLP4 764
INDIRF4
CVFI4 4
ASGNI4
line 1846
;1846:		s_serveroptions.monsterTitans = (int) Com_Clamp(0, 100, trap_Cvar_VariableValue("ui_efh_monsterTitans"));
ADDRGP4 $740
ARGP4
ADDRLP4 768
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1120403456
ARGF4
ADDRLP4 768
INDIRF4
ARGF4
ADDRLP4 772
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2648
ADDRLP4 772
INDIRF4
CVFI4 4
ASGNI4
line 1847
;1847:		s_serveroptions.monsterHealthScale = (int) Com_Clamp(1, 1000, trap_Cvar_VariableValue("ui_efh_monsterHealthScale"));
ADDRGP4 $743
ARGP4
ADDRLP4 776
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 1065353216
ARGF4
CNSTF4 1148846080
ARGF4
ADDRLP4 776
INDIRF4
ARGF4
ADDRLP4 780
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2652
ADDRLP4 780
INDIRF4
CVFI4 4
ASGNI4
line 1848
;1848:		s_serveroptions.monsterProgression = (int) Com_Clamp(0, 1000, trap_Cvar_VariableValue("ui_efh_monsterProgression"));
ADDRGP4 $744
ARGP4
ADDRLP4 784
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1148846080
ARGF4
ADDRLP4 784
INDIRF4
ARGF4
ADDRLP4 788
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2656
ADDRLP4 788
INDIRF4
CVFI4 4
ASGNI4
line 1850
;1849:#if MEETING
;1850:		s_serveroptions.meeting.curvalue = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_efh_meeting"));	// JUHOX
ADDRGP4 $747
ARGP4
ADDRLP4 792
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 792
INDIRF4
ARGF4
ADDRLP4 796
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+3932+60
ADDRLP4 796
INDIRF4
CVFI4 4
ASGNI4
line 1852
;1851:#endif
;1852:		break;
LABELV $1160
line 1857
;1853:#endif
;1854:	}
;1855:
;1856:#if MONSTER_MODE	// JUHOX: cvars (also) needed for monster launcher & EFH
;1857:	trap_Cvar_VariableStringBuffer("monsterModel1", s_serveroptions.monsterModel1, sizeof(s_serveroptions.monsterModel1));
ADDRGP4 $753
ARGP4
ADDRGP4 s_serveroptions+2664
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1858
;1858:	trap_Cvar_VariableStringBuffer("monsterModel2", s_serveroptions.monsterModel2, sizeof(s_serveroptions.monsterModel2));
ADDRGP4 $754
ARGP4
ADDRGP4 s_serveroptions+2696
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1859
;1859:	trap_Cvar_VariableStringBuffer("monsterModel3", s_serveroptions.monsterModel3, sizeof(s_serveroptions.monsterModel3));
ADDRGP4 $755
ARGP4
ADDRGP4 s_serveroptions+2728
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1860
;1860:	s_serveroptions.scoreMode = (int)Com_Clamp(0, 1, trap_Cvar_VariableValue("g_scoreMode"));
ADDRGP4 $756
ARGP4
ADDRLP4 4
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2764
ADDRLP4 8
INDIRF4
CVFI4 4
ASGNI4
line 1863
;1861:#endif
;1862:
;1863:	s_serveroptions.respawnAtPOD = (int)Com_Clamp(0, 1, trap_Cvar_VariableValue("respawnAtPOD"));	// JUHOX
ADDRGP4 $767
ARGP4
ADDRLP4 12
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 16
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2568
ADDRLP4 16
INDIRF4
CVFI4 4
ASGNI4
line 1864
;1864:	s_serveroptions.tssSafetyMode = (int)Com_Clamp(0, 1, trap_Cvar_VariableValue("tssSafetyModeAllowed"));	// JUHOX
ADDRGP4 $769
ARGP4
ADDRLP4 20
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 24
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2576
ADDRLP4 24
INDIRF4
CVFI4 4
ASGNI4
line 1865
;1865:	s_serveroptions.armorFragments = (int)Com_Clamp(0, 1, trap_Cvar_VariableValue("g_armorFragments"));	// JUHOX
ADDRGP4 $758
ARGP4
ADDRLP4 28
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 32
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2580
ADDRLP4 32
INDIRF4
CVFI4 4
ASGNI4
line 1866
;1866:	s_serveroptions.stamina = (int)Com_Clamp(0, 1, trap_Cvar_VariableValue("g_stamina"));	// JUHOX
ADDRGP4 $770
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
ADDRGP4 s_serveroptions+2584
ADDRLP4 40
INDIRF4
CVFI4 4
ASGNI4
line 1867
;1867:	s_serveroptions.baseHealth = (int)Com_Clamp(1, 1000, trap_Cvar_VariableValue("g_baseHealth"));	// JUHOX
ADDRGP4 $772
ARGP4
ADDRLP4 44
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 1065353216
ARGF4
CNSTF4 1148846080
ARGF4
ADDRLP4 44
INDIRF4
ARGF4
ADDRLP4 48
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2588
ADDRLP4 48
INDIRF4
CVFI4 4
ASGNI4
line 1868
;1868:	s_serveroptions.lightningDamageLimit = (int)Com_Clamp(0, 999, trap_Cvar_VariableValue("g_lightningDamageLimit"));	// JUHOX
ADDRGP4 $774
ARGP4
ADDRLP4 52
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1148829696
ARGF4
ADDRLP4 52
INDIRF4
ARGF4
ADDRLP4 56
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2592
ADDRLP4 56
INDIRF4
CVFI4 4
ASGNI4
line 1870
;1869:#if GRAPPLE_ROPE
;1870:	s_serveroptions.grapple = (int)Com_Clamp(0, HM_num_modes-1, trap_Cvar_VariableValue("g_grapple"));	// JUHOX
ADDRGP4 $776
ARGP4
ADDRLP4 60
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1082130432
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 64
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2596
ADDRLP4 64
INDIRF4
CVFI4 4
ASGNI4
line 1872
;1871:#endif
;1872:	Com_sprintf(s_serveroptions.additionalSlots.field.buffer, 3, "%i", (int)Com_Clamp(0, MAX_CLIENTS, trap_Cvar_VariableValue("ui_additionalSlots")));	// JUHOX
ADDRGP4 $759
ARGP4
ADDRLP4 68
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1115684864
ARGF4
ADDRLP4 68
INDIRF4
ARGF4
ADDRLP4 72
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+3268+60+12
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $1146
ARGP4
ADDRLP4 72
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1874
;1873:	
;1874:	Q_strncpyz( s_serveroptions.hostname.field.buffer, UI_Cvar_VariableString( "sv_hostname" ), sizeof( s_serveroptions.hostname.field.buffer ) );
ADDRGP4 $791
ARGP4
ADDRLP4 76
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 s_serveroptions+2776+60+12
ARGP4
ADDRLP4 76
INDIRP4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1875
;1875:	s_serveroptions.pure.curvalue = Com_Clamp( 0, 1, trap_Cvar_VariableValue( "sv_pure" ) );
ADDRGP4 $784
ARGP4
ADDRLP4 80
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 80
INDIRF4
ARGF4
ADDRLP4 84
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+3108+60
ADDRLP4 84
INDIRF4
CVFI4 4
ASGNI4
line 1881
;1876:#if !TSSINCVAR	// JUHOX: if tss is activated, let sv_pure default to 0
;1877:	if (s_serveroptions.gametype >= GT_TEAM && s_serveroptions.tss) s_serveroptions.pure.curvalue = 0;
;1878:#endif
;1879:
;1880:	// set the map pic
;1881:	Com_sprintf( picname, 64, "levelshots/%s", /*s_startserver.maplist[s_startserver.currentmap]*/s_startserver.choosenmap );	// JUHOX
ADDRGP4 $1158
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $143
ARGP4
ADDRGP4 s_startserver+7752
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1882
;1882:	s_serveroptions.mappic.generic.name = picname;
ADDRGP4 s_serveroptions+496+4
ADDRGP4 $1158
ASGNP4
line 1885
;1883:
;1884:	// set the map name
;1885:	strcpy( s_serveroptions.mapnamebuffer, /*s_startserver.mapname.string*/s_startserver.choosenmapname );	// JUHOX
ADDRGP4 s_serveroptions+7508
ARGP4
ADDRGP4 s_startserver+7768
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1886
;1886:	Q_strupr( s_serveroptions.mapnamebuffer );
ADDRGP4 s_serveroptions+7508
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 1889
;1887:
;1888:	// get the player selections initialized
;1889:	ServerOptions_InitPlayerItems();
ADDRGP4 ServerOptions_InitPlayerItems
CALLV
pop
line 1890
;1890:	ServerOptions_SetPlayerItems();
ADDRGP4 ServerOptions_SetPlayerItems
CALLV
pop
line 1893
;1891:
;1892:	// seed bot names
;1893:	ServerOptions_InitBotNames();
ADDRGP4 ServerOptions_InitBotNames
CALLV
pop
line 1894
;1894:	ServerOptions_SetPlayerItems();
ADDRGP4 ServerOptions_SetPlayerItems
CALLV
pop
line 1895
;1895:}
LABELV $1157
endproc ServerOptions_SetMenuItems 800 16
proc PlayerName_Draw 36 20
line 1902
;1896:
;1897:/*
;1898:=================
;1899:PlayerName_Draw
;1900:=================
;1901:*/
;1902:static void PlayerName_Draw( void *item ) {
line 1909
;1903:	menutext_s	*s;
;1904:	float		*color;
;1905:	int			x, y;
;1906:	int			style;
;1907:	qboolean	focus;
;1908:
;1909:	s = (menutext_s *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 1911
;1910:
;1911:	x = s->generic.x;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1912
;1912:	y =	s->generic.y;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 1914
;1913:
;1914:	style = UI_SMALLFONT;
ADDRLP4 16
CNSTI4 16
ASGNI4
line 1915
;1915:	focus = (s->generic.parent->cursor == s->generic.menuPosition);
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
NEI4 $1362
ADDRLP4 24
CNSTI4 1
ASGNI4
ADDRGP4 $1363
JUMPV
LABELV $1362
ADDRLP4 24
CNSTI4 0
ASGNI4
LABELV $1363
ADDRLP4 20
ADDRLP4 24
INDIRI4
ASGNI4
line 1917
;1916:
;1917:	if ( s->generic.flags & QMF_GRAYED )
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 8192
BANDU4
CNSTU4 0
EQU4 $1364
line 1918
;1918:		color = text_color_disabled;
ADDRLP4 4
ADDRGP4 text_color_disabled
ASGNP4
ADDRGP4 $1365
JUMPV
LABELV $1364
line 1919
;1919:	else if ( focus )
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $1366
line 1920
;1920:	{
line 1921
;1921:		color = text_color_highlight;
ADDRLP4 4
ADDRGP4 text_color_highlight
ASGNP4
line 1922
;1922:		style |= UI_PULSE;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
line 1923
;1923:	}
ADDRGP4 $1367
JUMPV
LABELV $1366
line 1924
;1924:	else if ( s->generic.flags & QMF_BLINK )
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 1
BANDU4
CNSTU4 0
EQU4 $1368
line 1925
;1925:	{
line 1926
;1926:		color = text_color_highlight;
ADDRLP4 4
ADDRGP4 text_color_highlight
ASGNP4
line 1927
;1927:		style |= UI_BLINK;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 4096
BORI4
ASGNI4
line 1928
;1928:	}
ADDRGP4 $1369
JUMPV
LABELV $1368
line 1930
;1929:	else
;1930:		color = text_color_normal;
ADDRLP4 4
ADDRGP4 text_color_normal
ASGNP4
LABELV $1369
LABELV $1367
LABELV $1365
line 1932
;1931:
;1932:	if ( focus )
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $1370
line 1933
;1933:	{
line 1935
;1934:		// draw cursor
;1935:		UI_FillRect( s->generic.left, s->generic.top, s->generic.right-s->generic.left+1, s->generic.bottom-s->generic.top+1, listbar_color ); 
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
SUBI4
CNSTI4 1
ADDI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
SUBI4
CNSTI4 1
ADDI4
CVIF4 4
ARGF4
ADDRGP4 listbar_color
ARGP4
ADDRGP4 UI_FillRect
CALLV
pop
line 1936
;1936:		UI_DrawChar( x, y, 13, UI_CENTER|UI_BLINK|UI_SMALLFONT, color);
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
CNSTI4 13
ARGI4
CNSTI4 4113
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 UI_DrawChar
CALLV
pop
line 1937
;1937:	}
LABELV $1370
line 1939
;1938:
;1939:	UI_DrawString( x - SMALLCHAR_WIDTH, y, s->generic.name, style|UI_RIGHT, color );
ADDRLP4 8
INDIRI4
CNSTI4 8
SUBI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
INDIRI4
CNSTI4 2
BORI4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 1940
;1940:	UI_DrawString( x + SMALLCHAR_WIDTH, y, s->string, style|UI_LEFT, color );
ADDRLP4 8
INDIRI4
CNSTI4 8
ADDI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 1941
;1941:}
LABELV $1360
endproc PlayerName_Draw 36 20
proc ServerOptions_AdvancedOptions 0 0
line 1950
;1942:
;1943:
;1944:/*
;1945:=================
;1946:JUHOX: ServerOptions_AdvancedOptions
;1947:=================
;1948:*/
;1949:void UI_AdvOptMenu(void);
;1950:static void ServerOptions_AdvancedOptions(void* ptr, int event) {
line 1951
;1951:	if( event != QM_ACTIVATED ) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $1373
line 1952
;1952:		return;
ADDRGP4 $1372
JUMPV
LABELV $1373
line 1955
;1953:	}
;1954:
;1955:	UI_AdvOptMenu();
ADDRGP4 UI_AdvOptMenu
CALLV
pop
line 1956
;1956:}
LABELV $1372
endproc ServerOptions_AdvancedOptions 0 0
proc ServerOptions_MenuInit 52 12
line 1965
;1957:
;1958:/*
;1959:=================
;1960:ServerOptions_MenuInit
;1961:=================
;1962:*/
;1963:#define OPTIONS_X	456
;1964:
;1965:static void ServerOptions_MenuInit( qboolean multiplayer ) {
line 1969
;1966:	int		y;
;1967:	int		n;
;1968:
;1969:	memset( &s_serveroptions, 0 ,sizeof(serveroptions_t) );
ADDRGP4 s_serveroptions
ARGP4
CNSTI4 0
ARGI4
CNSTI4 7852
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1970
;1970:	s_serveroptions.multiplayer = multiplayer;
ADDRGP4 s_serveroptions+7500
ADDRFP4 0
INDIRI4
ASGNI4
line 1975
;1971:
;1972:#if !MONSTER_MODE	// JUHOX: also accept GT_STU
;1973:	s_serveroptions.gametype = (int)Com_Clamp( 0, 5, trap_Cvar_VariableValue( "g_gameType" ) );
;1974:#else
;1975:	s_serveroptions.gametype = (int)Com_Clamp( 0, GT_MAX_GAME_TYPE-1, trap_Cvar_VariableValue( "g_gameType" ) );
ADDRGP4 $250
ARGP4
ADDRLP4 8
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1091567616
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+7504
ADDRLP4 12
INDIRF4
CVFI4 4
ASGNI4
line 1977
;1976:#endif
;1977:	s_serveroptions.punkbuster.curvalue = Com_Clamp( 0, 1, trap_Cvar_VariableValue( "sv_punkbuster" ) );
ADDRGP4 $795
ARGP4
ADDRLP4 16
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 20
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+7756+64
ADDRLP4 20
INDIRF4
CVFI4 4
ASGNI4
line 1979
;1978:
;1979:	ServerOptions_Cache();
ADDRGP4 ServerOptions_Cache
CALLV
pop
line 1981
;1980:
;1981:	s_serveroptions.menu.wrapAround = qtrue;
ADDRGP4 s_serveroptions+404
CNSTI4 1
ASGNI4
line 1982
;1982:	s_serveroptions.menu.fullscreen = qtrue;
ADDRGP4 s_serveroptions+408
CNSTI4 1
ASGNI4
line 1984
;1983:
;1984:	s_serveroptions.banner.generic.type			= MTYPE_BTEXT;
ADDRGP4 s_serveroptions+424
CNSTI4 10
ASGNI4
line 1985
;1985:	s_serveroptions.banner.generic.x			= 320;
ADDRGP4 s_serveroptions+424+12
CNSTI4 320
ASGNI4
line 1986
;1986:	s_serveroptions.banner.generic.y			= 16;
ADDRGP4 s_serveroptions+424+16
CNSTI4 16
ASGNI4
line 1987
;1987:	s_serveroptions.banner.string  				= "GAME SERVER";
ADDRGP4 s_serveroptions+424+60
ADDRGP4 $283
ASGNP4
line 1988
;1988:	s_serveroptions.banner.color  				= color_white;
ADDRGP4 s_serveroptions+424+68
ADDRGP4 color_white
ASGNP4
line 1989
;1989:	s_serveroptions.banner.style  				= UI_CENTER;
ADDRGP4 s_serveroptions+424+64
CNSTI4 1
ASGNI4
line 1991
;1990:
;1991:	s_serveroptions.mappic.generic.type			= MTYPE_BITMAP;
ADDRGP4 s_serveroptions+496
CNSTI4 6
ASGNI4
line 1992
;1992:	s_serveroptions.mappic.generic.flags		= QMF_LEFT_JUSTIFY|QMF_INACTIVE;
ADDRGP4 s_serveroptions+496+44
CNSTU4 16388
ASGNU4
line 1993
;1993:	s_serveroptions.mappic.generic.x			= 352;
ADDRGP4 s_serveroptions+496+12
CNSTI4 352
ASGNI4
line 1994
;1994:	s_serveroptions.mappic.generic.y			= 80;
ADDRGP4 s_serveroptions+496+16
CNSTI4 80
ASGNI4
line 1995
;1995:	s_serveroptions.mappic.width				= 160;
ADDRGP4 s_serveroptions+496+76
CNSTI4 160
ASGNI4
line 1996
;1996:	s_serveroptions.mappic.height				= 120;
ADDRGP4 s_serveroptions+496+80
CNSTI4 120
ASGNI4
line 1997
;1997:	s_serveroptions.mappic.errorpic				= GAMESERVER_UNKNOWNMAP;
ADDRGP4 s_serveroptions+496+64
ADDRGP4 $326
ASGNP4
line 1998
;1998:	s_serveroptions.mappic.generic.ownerdraw	= ServerOptions_LevelshotDraw;
ADDRGP4 s_serveroptions+496+56
ADDRGP4 ServerOptions_LevelshotDraw
ASGNP4
line 2000
;1999:
;2000:	s_serveroptions.picframe.generic.type		= MTYPE_BITMAP;
ADDRGP4 s_serveroptions+584
CNSTI4 6
ASGNI4
line 2001
;2001:	s_serveroptions.picframe.generic.flags		= QMF_LEFT_JUSTIFY|QMF_INACTIVE|QMF_HIGHLIGHT;
ADDRGP4 s_serveroptions+584+44
CNSTU4 16452
ASGNU4
line 2002
;2002:	s_serveroptions.picframe.generic.x			= 352 - 38;
ADDRGP4 s_serveroptions+584+12
CNSTI4 314
ASGNI4
line 2003
;2003:	s_serveroptions.picframe.generic.y			= 80 - 40;
ADDRGP4 s_serveroptions+584+16
CNSTI4 40
ASGNI4
line 2004
;2004:	s_serveroptions.picframe.width  			= 320;
ADDRGP4 s_serveroptions+584+76
CNSTI4 320
ASGNI4
line 2005
;2005:	s_serveroptions.picframe.height  			= 320;
ADDRGP4 s_serveroptions+584+80
CNSTI4 320
ASGNI4
line 2006
;2006:	s_serveroptions.picframe.focuspic			= GAMESERVER_SELECT;
ADDRGP4 s_serveroptions+584+60
ADDRGP4 $354
ASGNP4
line 2008
;2007:
;2008:	y = 272;
ADDRLP4 4
CNSTI4 272
ASGNI4
line 2009
;2009:	if( s_serveroptions.gametype != GT_CTF ) {
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 4
EQI4 $1421
line 2010
;2010:		s_serveroptions.fraglimit.generic.type       = MTYPE_FIELD;
ADDRGP4 s_serveroptions+1100
CNSTI4 4
ASGNI4
line 2011
;2011:		s_serveroptions.fraglimit.generic.name       = "Frag Limit:";
ADDRGP4 s_serveroptions+1100+4
ADDRGP4 $1427
ASGNP4
line 2012
;2012:		s_serveroptions.fraglimit.generic.flags      = QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 s_serveroptions+1100+44
CNSTU4 290
ASGNU4
line 2013
;2013:		s_serveroptions.fraglimit.generic.x	         = OPTIONS_X;
ADDRGP4 s_serveroptions+1100+12
CNSTI4 456
ASGNI4
line 2014
;2014:		s_serveroptions.fraglimit.generic.y	         = y;
ADDRGP4 s_serveroptions+1100+16
ADDRLP4 4
INDIRI4
ASGNI4
line 2015
;2015:		s_serveroptions.fraglimit.generic.statusbar  = ServerOptions_StatusBar;
ADDRGP4 s_serveroptions+1100+52
ADDRGP4 ServerOptions_StatusBar
ASGNP4
line 2016
;2016:		s_serveroptions.fraglimit.field.widthInChars = /*3*/4;	// JUHOX
ADDRGP4 s_serveroptions+1100+60+8
CNSTI4 4
ASGNI4
line 2017
;2017:		s_serveroptions.fraglimit.field.maxchars     = 3;
ADDRGP4 s_serveroptions+1100+60+268
CNSTI4 3
ASGNI4
line 2018
;2018:	}
ADDRGP4 $1422
JUMPV
LABELV $1421
line 2019
;2019:	else {
line 2020
;2020:		s_serveroptions.flaglimit.generic.type       = MTYPE_FIELD;
ADDRGP4 s_serveroptions+1432
CNSTI4 4
ASGNI4
line 2021
;2021:		s_serveroptions.flaglimit.generic.name       = "Capture Limit:";
ADDRGP4 s_serveroptions+1432+4
ADDRGP4 $1445
ASGNP4
line 2022
;2022:		s_serveroptions.flaglimit.generic.flags      = QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 s_serveroptions+1432+44
CNSTU4 290
ASGNU4
line 2023
;2023:		s_serveroptions.flaglimit.generic.x	         = OPTIONS_X;
ADDRGP4 s_serveroptions+1432+12
CNSTI4 456
ASGNI4
line 2024
;2024:		s_serveroptions.flaglimit.generic.y	         = y;
ADDRGP4 s_serveroptions+1432+16
ADDRLP4 4
INDIRI4
ASGNI4
line 2025
;2025:		s_serveroptions.flaglimit.generic.statusbar  = ServerOptions_StatusBar;
ADDRGP4 s_serveroptions+1432+52
ADDRGP4 ServerOptions_StatusBar
ASGNP4
line 2026
;2026:		s_serveroptions.flaglimit.field.widthInChars = /*3*/4;	// JUHOX
ADDRGP4 s_serveroptions+1432+60+8
CNSTI4 4
ASGNI4
line 2027
;2027:		s_serveroptions.flaglimit.field.maxchars     = 3;
ADDRGP4 s_serveroptions+1432+60+268
CNSTI4 3
ASGNI4
line 2028
;2028:	}
LABELV $1422
line 2030
;2029:
;2030:	y += BIGCHAR_HEIGHT+2;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 2031
;2031:	s_serveroptions.timelimit.generic.type       = MTYPE_FIELD;
ADDRGP4 s_serveroptions+768
CNSTI4 4
ASGNI4
line 2032
;2032:	s_serveroptions.timelimit.generic.name       = "Time Limit:";
ADDRGP4 s_serveroptions+768+4
ADDRGP4 $1463
ASGNP4
line 2033
;2033:	s_serveroptions.timelimit.generic.flags      = QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 s_serveroptions+768+44
CNSTU4 290
ASGNU4
line 2034
;2034:	s_serveroptions.timelimit.generic.x	         = OPTIONS_X;
ADDRGP4 s_serveroptions+768+12
CNSTI4 456
ASGNI4
line 2035
;2035:	s_serveroptions.timelimit.generic.y	         = y;
ADDRGP4 s_serveroptions+768+16
ADDRLP4 4
INDIRI4
ASGNI4
line 2036
;2036:	s_serveroptions.timelimit.generic.statusbar  = ServerOptions_StatusBar;
ADDRGP4 s_serveroptions+768+52
ADDRGP4 ServerOptions_StatusBar
ASGNP4
line 2037
;2037:	s_serveroptions.timelimit.field.widthInChars = /*3*/4;	// JUHOX
ADDRGP4 s_serveroptions+768+60+8
CNSTI4 4
ASGNI4
line 2038
;2038:	s_serveroptions.timelimit.field.maxchars     = 3;
ADDRGP4 s_serveroptions+768+60+268
CNSTI4 3
ASGNI4
line 2041
;2039:
;2040:#if MONSTER_MODE	// JUHOX: init the artefacts menu field
;2041:	if (s_serveroptions.gametype == GT_STU) {
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 8
NEI4 $1478
line 2042
;2042:		y += BIGCHAR_HEIGHT+2;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 2043
;2043:		s_serveroptions.artefacts.generic.type			= MTYPE_FIELD;
ADDRGP4 s_serveroptions+1764
CNSTI4 4
ASGNI4
line 2044
;2044:		s_serveroptions.artefacts.generic.name			= "Artefacts:";
ADDRGP4 s_serveroptions+1764+4
ADDRGP4 $1484
ASGNP4
line 2045
;2045:		s_serveroptions.artefacts.generic.flags			= QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 s_serveroptions+1764+44
CNSTU4 290
ASGNU4
line 2046
;2046:		s_serveroptions.artefacts.generic.x				= OPTIONS_X;
ADDRGP4 s_serveroptions+1764+12
CNSTI4 456
ASGNI4
line 2047
;2047:		s_serveroptions.artefacts.generic.y				= y;
ADDRGP4 s_serveroptions+1764+16
ADDRLP4 4
INDIRI4
ASGNI4
line 2048
;2048:		s_serveroptions.artefacts.generic.statusbar		= ServerOptions_ArtefactsStatusBar;
ADDRGP4 s_serveroptions+1764+52
ADDRGP4 ServerOptions_ArtefactsStatusBar
ASGNP4
line 2049
;2049:		s_serveroptions.artefacts.field.widthInChars	= 4;
ADDRGP4 s_serveroptions+1764+60+8
CNSTI4 4
ASGNI4
line 2050
;2050:		s_serveroptions.artefacts.field.maxchars		= 3;
ADDRGP4 s_serveroptions+1764+60+268
CNSTI4 3
ASGNI4
line 2051
;2051:	}
LABELV $1478
line 2055
;2052:#endif
;2053:
;2054:#if ESCAPE_MODE	// JUHOX: init the distanceLimit menu field
;2055:	if (s_serveroptions.gametype == GT_EFH) {
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 9
NEI4 $1499
line 2056
;2056:		y += BIGCHAR_HEIGHT+2;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 2057
;2057:		s_serveroptions.distanceLimit.generic.type			= MTYPE_FIELD;
ADDRGP4 s_serveroptions+2096
CNSTI4 4
ASGNI4
line 2058
;2058:		s_serveroptions.distanceLimit.generic.name			= "Distance [km]:";
ADDRGP4 s_serveroptions+2096+4
ADDRGP4 $1505
ASGNP4
line 2059
;2059:		s_serveroptions.distanceLimit.generic.flags			= QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 s_serveroptions+2096+44
CNSTU4 290
ASGNU4
line 2060
;2060:		s_serveroptions.distanceLimit.generic.x				= OPTIONS_X;
ADDRGP4 s_serveroptions+2096+12
CNSTI4 456
ASGNI4
line 2061
;2061:		s_serveroptions.distanceLimit.generic.y				= y;
ADDRGP4 s_serveroptions+2096+16
ADDRLP4 4
INDIRI4
ASGNI4
line 2062
;2062:		s_serveroptions.distanceLimit.field.widthInChars	= 10;
ADDRGP4 s_serveroptions+2096+60+8
CNSTI4 10
ASGNI4
line 2063
;2063:		s_serveroptions.distanceLimit.field.maxchars		= 9;
ADDRGP4 s_serveroptions+2096+60+268
CNSTI4 9
ASGNI4
line 2064
;2064:	}
LABELV $1499
line 2067
;2065:#endif
;2066:
;2067:	if( s_serveroptions.gametype >= GT_TEAM ) {
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 3
LTI4 $1518
line 2068
;2068:		y += BIGCHAR_HEIGHT+2;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 2069
;2069:		s_serveroptions.friendlyfire.generic.type     = MTYPE_RADIOBUTTON;
ADDRGP4 s_serveroptions+2428
CNSTI4 5
ASGNI4
line 2070
;2070:		s_serveroptions.friendlyfire.generic.flags    = QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 s_serveroptions+2428+44
CNSTU4 258
ASGNU4
line 2071
;2071:		s_serveroptions.friendlyfire.generic.x	      = OPTIONS_X;
ADDRGP4 s_serveroptions+2428+12
CNSTI4 456
ASGNI4
line 2072
;2072:		s_serveroptions.friendlyfire.generic.y	      = y;
ADDRGP4 s_serveroptions+2428+16
ADDRLP4 4
INDIRI4
ASGNI4
line 2073
;2073:		s_serveroptions.friendlyfire.generic.name	  = "Friendly Fire:";
ADDRGP4 s_serveroptions+2428+4
ADDRGP4 $1530
ASGNP4
line 2074
;2074:	}
LABELV $1518
line 2076
;2075:
;2076:	y += BIGCHAR_HEIGHT+2;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 2077
;2077:	s_serveroptions.pure.generic.type			= MTYPE_RADIOBUTTON;
ADDRGP4 s_serveroptions+3108
CNSTI4 5
ASGNI4
line 2078
;2078:	s_serveroptions.pure.generic.flags			= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 s_serveroptions+3108+44
CNSTU4 258
ASGNU4
line 2079
;2079:	s_serveroptions.pure.generic.x				= OPTIONS_X;
ADDRGP4 s_serveroptions+3108+12
CNSTI4 456
ASGNI4
line 2080
;2080:	s_serveroptions.pure.generic.y				= y;
ADDRGP4 s_serveroptions+3108+16
ADDRLP4 4
INDIRI4
ASGNI4
line 2081
;2081:	s_serveroptions.pure.generic.name			= "Pure Server:";
ADDRGP4 s_serveroptions+3108+4
ADDRGP4 $1540
ASGNP4
line 2082
;2082:	s_serveroptions.pure.generic.statusbar		= ServerOptions_PureServerStatusBar;	// JUHOX
ADDRGP4 s_serveroptions+3108+52
ADDRGP4 ServerOptions_PureServerStatusBar
ASGNP4
line 2084
;2083:
;2084:	if( s_serveroptions.multiplayer ) {
ADDRGP4 s_serveroptions+7500
INDIRI4
CNSTI4 0
EQI4 $1543
line 2085
;2085:		y += BIGCHAR_HEIGHT+2;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 2086
;2086:		s_serveroptions.dedicated.generic.type		= MTYPE_SPINCONTROL;
ADDRGP4 s_serveroptions+672
CNSTI4 3
ASGNI4
line 2087
;2087:		s_serveroptions.dedicated.generic.id		= ID_DEDICATED;
ADDRGP4 s_serveroptions+672+8
CNSTI4 22
ASGNI4
line 2088
;2088:		s_serveroptions.dedicated.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 s_serveroptions+672+44
CNSTU4 258
ASGNU4
line 2089
;2089:		s_serveroptions.dedicated.generic.callback	= ServerOptions_Event;
ADDRGP4 s_serveroptions+672+48
ADDRGP4 ServerOptions_Event
ASGNP4
line 2090
;2090:		s_serveroptions.dedicated.generic.x			= OPTIONS_X;
ADDRGP4 s_serveroptions+672+12
CNSTI4 456
ASGNI4
line 2091
;2091:		s_serveroptions.dedicated.generic.y			= y;
ADDRGP4 s_serveroptions+672+16
ADDRLP4 4
INDIRI4
ASGNI4
line 2092
;2092:		s_serveroptions.dedicated.generic.name		= "Dedicated:";
ADDRGP4 s_serveroptions+672+4
ADDRGP4 $1559
ASGNP4
line 2093
;2093:		s_serveroptions.dedicated.itemnames			= dedicated_list;
ADDRGP4 s_serveroptions+672+76
ADDRGP4 dedicated_list
ASGNP4
line 2094
;2094:	}
LABELV $1543
line 2096
;2095:
;2096:	if( s_serveroptions.multiplayer ) {
ADDRGP4 s_serveroptions+7500
INDIRI4
CNSTI4 0
EQI4 $1562
line 2097
;2097:		y += BIGCHAR_HEIGHT+2;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 2098
;2098:		s_serveroptions.hostname.generic.type       = MTYPE_FIELD;
ADDRGP4 s_serveroptions+2776
CNSTI4 4
ASGNI4
line 2099
;2099:		s_serveroptions.hostname.generic.name       = "Hostname:";
ADDRGP4 s_serveroptions+2776+4
ADDRGP4 $1568
ASGNP4
line 2100
;2100:		s_serveroptions.hostname.generic.flags      = QMF_SMALLFONT;
ADDRGP4 s_serveroptions+2776+44
CNSTU4 2
ASGNU4
line 2101
;2101:		s_serveroptions.hostname.generic.x          = OPTIONS_X;
ADDRGP4 s_serveroptions+2776+12
CNSTI4 456
ASGNI4
line 2102
;2102:		s_serveroptions.hostname.generic.y	        = y;
ADDRGP4 s_serveroptions+2776+16
ADDRLP4 4
INDIRI4
ASGNI4
line 2103
;2103:		s_serveroptions.hostname.field.widthInChars = 18;
ADDRGP4 s_serveroptions+2776+60+8
CNSTI4 18
ASGNI4
line 2104
;2104:		s_serveroptions.hostname.field.maxchars     = 64;
ADDRGP4 s_serveroptions+2776+60+268
CNSTI4 64
ASGNI4
line 2105
;2105:	}
LABELV $1562
line 2107
;2106:
;2107:	y += BIGCHAR_HEIGHT+2;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 2108
;2108:	s_serveroptions.punkbuster.generic.type			= MTYPE_SPINCONTROL;
ADDRGP4 s_serveroptions+7756
CNSTI4 3
ASGNI4
line 2109
;2109:	s_serveroptions.punkbuster.generic.name			= "Punkbuster:";
ADDRGP4 s_serveroptions+7756+4
ADDRGP4 $1584
ASGNP4
line 2110
;2110:	s_serveroptions.punkbuster.generic.flags			= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 s_serveroptions+7756+44
CNSTU4 258
ASGNU4
line 2111
;2111:	s_serveroptions.punkbuster.generic.id			= 0;
ADDRGP4 s_serveroptions+7756+8
CNSTI4 0
ASGNI4
line 2112
;2112:	s_serveroptions.punkbuster.generic.x				= OPTIONS_X;
ADDRGP4 s_serveroptions+7756+12
CNSTI4 456
ASGNI4
line 2113
;2113:	s_serveroptions.punkbuster.generic.y				= y;
ADDRGP4 s_serveroptions+7756+16
ADDRLP4 4
INDIRI4
ASGNI4
line 2114
;2114:	s_serveroptions.punkbuster.itemnames				= punkbuster_items;
ADDRGP4 s_serveroptions+7756+76
ADDRGP4 punkbuster_items
ASGNP4
line 2116
;2115:	
;2116:	y = 80;
ADDRLP4 4
CNSTI4 80
ASGNI4
line 2118
;2117:#if ESCAPE_MODE	// JUHOX: no bots in EFH
;2118:	if (s_serveroptions.gametype != GT_EFH) {
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 9
EQI4 $1595
line 2120
;2119:#endif
;2120:	s_serveroptions.botSkill.generic.type			= MTYPE_SPINCONTROL;
ADDRGP4 s_serveroptions+3172
CNSTI4 3
ASGNI4
line 2121
;2121:	s_serveroptions.botSkill.generic.flags			= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 s_serveroptions+3172+44
CNSTU4 258
ASGNU4
line 2122
;2122:	s_serveroptions.botSkill.generic.name			= "Bot Skill:  ";
ADDRGP4 s_serveroptions+3172+4
ADDRGP4 $1603
ASGNP4
line 2123
;2123:	s_serveroptions.botSkill.generic.x				= 32 + (strlen(s_serveroptions.botSkill.generic.name) + 2 ) * SMALLCHAR_WIDTH;
ADDRGP4 s_serveroptions+3172+4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRGP4 s_serveroptions+3172+12
ADDRLP4 24
INDIRI4
CNSTI4 3
LSHI4
CNSTI4 16
ADDI4
CNSTI4 32
ADDI4
ASGNI4
line 2124
;2124:	s_serveroptions.botSkill.generic.y				= y;
ADDRGP4 s_serveroptions+3172+16
ADDRLP4 4
INDIRI4
ASGNI4
line 2125
;2125:	s_serveroptions.botSkill.itemnames				= botSkill_list;
ADDRGP4 s_serveroptions+3172+76
ADDRGP4 botSkill_list
ASGNP4
line 2126
;2126:	s_serveroptions.botSkill.curvalue				= 1;
ADDRGP4 s_serveroptions+3172+64
CNSTI4 1
ASGNI4
line 2128
;2127:#if MONSTER_MODE	// JUHOX: in STU default bot skill is nightmare
;2128:	if (s_serveroptions.gametype == GT_STU) {
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 8
NEI4 $1614
line 2129
;2129:		s_serveroptions.botSkill.curvalue = 4;
ADDRGP4 s_serveroptions+3172+64
CNSTI4 4
ASGNI4
line 2130
;2130:	}
LABELV $1614
line 2133
;2131:#endif
;2132:#if ESCAPE_MODE	// JUHOX: no bots in EFH
;2133:	}
LABELV $1595
line 2136
;2134:#endif
;2135:
;2136:	y += ( 2 * SMALLCHAR_HEIGHT );
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 32
ADDI4
ASGNI4
line 2137
;2137:	s_serveroptions.player0.generic.type			= MTYPE_TEXT;
ADDRGP4 s_serveroptions+3996
CNSTI4 7
ASGNI4
line 2138
;2138:	s_serveroptions.player0.generic.flags			= QMF_SMALLFONT;
ADDRGP4 s_serveroptions+3996+44
CNSTU4 2
ASGNU4
line 2139
;2139:	s_serveroptions.player0.generic.x				= 32 + SMALLCHAR_WIDTH;
ADDRGP4 s_serveroptions+3996+12
CNSTI4 40
ASGNI4
line 2140
;2140:	s_serveroptions.player0.generic.y				= y;
ADDRGP4 s_serveroptions+3996+16
ADDRLP4 4
INDIRI4
ASGNI4
line 2141
;2141:	s_serveroptions.player0.color					= color_orange;
ADDRGP4 s_serveroptions+3996+68
ADDRGP4 color_orange
ASGNP4
line 2142
;2142:	s_serveroptions.player0.style					= UI_LEFT|UI_SMALLFONT;
ADDRGP4 s_serveroptions+3996+64
CNSTI4 16
ASGNI4
line 2144
;2143:
;2144:	for( n = 0; n < PLAYER_SLOTS; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1630
line 2145
;2145:		s_serveroptions.playerType[n].generic.type		= MTYPE_SPINCONTROL;
ADDRLP4 0
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 s_serveroptions+4068
ADDP4
CNSTI4 3
ASGNI4
line 2146
;2146:		s_serveroptions.playerType[n].generic.flags		= QMF_SMALLFONT;
ADDRLP4 0
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 s_serveroptions+4068+44
ADDP4
CNSTU4 2
ASGNU4
line 2147
;2147:		s_serveroptions.playerType[n].generic.id		= ID_PLAYER_TYPE;
ADDRLP4 0
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 s_serveroptions+4068+8
ADDP4
CNSTI4 20
ASGNI4
line 2148
;2148:		s_serveroptions.playerType[n].generic.callback	= ServerOptions_Event;
ADDRLP4 0
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 s_serveroptions+4068+48
ADDP4
ADDRGP4 ServerOptions_Event
ASGNP4
line 2149
;2149:		s_serveroptions.playerType[n].generic.x			= 32;
ADDRLP4 0
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 s_serveroptions+4068+12
ADDP4
CNSTI4 32
ASGNI4
line 2150
;2150:		s_serveroptions.playerType[n].generic.y			= y;
ADDRLP4 0
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 s_serveroptions+4068+16
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 2151
;2151:		s_serveroptions.playerType[n].itemnames			= playerType_list;
ADDRLP4 0
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 s_serveroptions+4068+76
ADDP4
ADDRGP4 playerType_list
ASGNP4
line 2153
;2152:
;2153:		s_serveroptions.playerName[n].generic.type		= MTYPE_TEXT;
ADDRLP4 0
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 s_serveroptions+5220
ADDP4
CNSTI4 7
ASGNI4
line 2154
;2154:		s_serveroptions.playerName[n].generic.flags		= QMF_SMALLFONT;
ADDRLP4 0
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 s_serveroptions+5220+44
ADDP4
CNSTU4 2
ASGNU4
line 2155
;2155:		s_serveroptions.playerName[n].generic.x			= 96;
ADDRLP4 0
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 s_serveroptions+5220+12
ADDP4
CNSTI4 96
ASGNI4
line 2156
;2156:		s_serveroptions.playerName[n].generic.y			= y;
ADDRLP4 0
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 s_serveroptions+5220+16
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 2157
;2157:		s_serveroptions.playerName[n].generic.callback	= ServerOptions_PlayerNameEvent;
ADDRLP4 0
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 s_serveroptions+5220+48
ADDP4
ADDRGP4 ServerOptions_PlayerNameEvent
ASGNP4
line 2158
;2158:		s_serveroptions.playerName[n].generic.id		= n;
ADDRLP4 0
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 s_serveroptions+5220+8
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 2159
;2159:		s_serveroptions.playerName[n].generic.ownerdraw	= PlayerName_Draw;
ADDRLP4 0
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 s_serveroptions+5220+56
ADDP4
ADDRGP4 PlayerName_Draw
ASGNP4
line 2160
;2160:		s_serveroptions.playerName[n].color				= color_orange;
ADDRLP4 0
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 s_serveroptions+5220+68
ADDP4
ADDRGP4 color_orange
ASGNP4
line 2161
;2161:		s_serveroptions.playerName[n].style				= UI_SMALLFONT;
ADDRLP4 0
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 s_serveroptions+5220+64
ADDP4
CNSTI4 16
ASGNI4
line 2162
;2162:		s_serveroptions.playerName[n].string			= s_serveroptions.playerNameBuffers[n];
ADDRLP4 0
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 s_serveroptions+5220+60
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 s_serveroptions+7540
ADDP4
ASGNP4
line 2163
;2163:		s_serveroptions.playerName[n].generic.top		= s_serveroptions.playerName[n].generic.y;
ADDRLP4 0
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 s_serveroptions+5220+24
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 s_serveroptions+5220+16
ADDP4
INDIRI4
ASGNI4
line 2164
;2164:		s_serveroptions.playerName[n].generic.bottom	= s_serveroptions.playerName[n].generic.y + SMALLCHAR_HEIGHT;
ADDRLP4 0
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 s_serveroptions+5220+32
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 s_serveroptions+5220+16
ADDP4
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 2165
;2165:		s_serveroptions.playerName[n].generic.left		= s_serveroptions.playerName[n].generic.x - SMALLCHAR_HEIGHT/ 2;
ADDRLP4 0
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 s_serveroptions+5220+20
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 s_serveroptions+5220+12
ADDP4
INDIRI4
CNSTI4 8
SUBI4
ASGNI4
line 2166
;2166:		s_serveroptions.playerName[n].generic.right		= s_serveroptions.playerName[n].generic.x + 16 * SMALLCHAR_WIDTH;
ADDRLP4 0
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 s_serveroptions+5220+28
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 s_serveroptions+5220+12
ADDP4
INDIRI4
CNSTI4 128
ADDI4
ASGNI4
line 2168
;2167:
;2168:		s_serveroptions.playerTeam[n].generic.type		= MTYPE_SPINCONTROL;
ADDRLP4 0
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 s_serveroptions+6084
ADDP4
CNSTI4 3
ASGNI4
line 2169
;2169:		s_serveroptions.playerTeam[n].generic.flags		= QMF_SMALLFONT;
ADDRLP4 0
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 s_serveroptions+6084+44
ADDP4
CNSTU4 2
ASGNU4
line 2170
;2170:		s_serveroptions.playerTeam[n].generic.x			= 240;
ADDRLP4 0
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 s_serveroptions+6084+12
ADDP4
CNSTI4 240
ASGNI4
line 2171
;2171:		s_serveroptions.playerTeam[n].generic.y			= y;
ADDRLP4 0
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 s_serveroptions+6084+16
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 2172
;2172:		s_serveroptions.playerTeam[n].itemnames			= playerTeam_list;
ADDRLP4 0
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 s_serveroptions+6084+76
ADDP4
ADDRGP4 playerTeam_list
ASGNP4
line 2174
;2173:
;2174:		y += ( SMALLCHAR_HEIGHT + 4 );
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 20
ADDI4
ASGNI4
line 2175
;2175:	}
LABELV $1631
line 2144
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 12
LTI4 $1630
line 2178
;2176:
;2177:#if 1	// JUHOX: init the additional slots menu field
;2178:	y += SMALLCHAR_HEIGHT + 4;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 20
ADDI4
ASGNI4
line 2179
;2179:	s_serveroptions.additionalSlots.generic.type		= MTYPE_FIELD;
ADDRGP4 s_serveroptions+3268
CNSTI4 4
ASGNI4
line 2180
;2180:	s_serveroptions.additionalSlots.generic.name		= "Additional Open Slots:";
ADDRGP4 s_serveroptions+3268+4
ADDRGP4 $1695
ASGNP4
line 2181
;2181:	s_serveroptions.additionalSlots.generic.flags		= QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 s_serveroptions+3268+44
CNSTU4 290
ASGNU4
line 2182
;2182:	s_serveroptions.additionalSlots.generic.x			= 240;
ADDRGP4 s_serveroptions+3268+12
CNSTI4 240
ASGNI4
line 2183
;2183:	s_serveroptions.additionalSlots.generic.y			= y;
ADDRGP4 s_serveroptions+3268+16
ADDRLP4 4
INDIRI4
ASGNI4
line 2185
;2184:	//s_serveroptions.additionalSlots.generic.statusbar	= ServerOptions_StatusBar;
;2185:	s_serveroptions.additionalSlots.field.widthInChars	= 3;
ADDRGP4 s_serveroptions+3268+60+8
CNSTI4 3
ASGNI4
line 2186
;2186:	s_serveroptions.additionalSlots.field.maxchars		= 2;
ADDRGP4 s_serveroptions+3268+60+268
CNSTI4 2
ASGNI4
line 2190
;2187:#endif
;2188:
;2189:#if 1	// JUHOX: init the game seed menu field
;2190:	y += SMALLCHAR_HEIGHT + 4;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 20
ADDI4
ASGNI4
line 2191
;2191:	s_serveroptions.gameseed.generic.type		= MTYPE_FIELD;
ADDRGP4 s_serveroptions+3600
CNSTI4 4
ASGNI4
line 2192
;2192:	s_serveroptions.gameseed.generic.name		= "Game Seed:";
ADDRGP4 s_serveroptions+3600+4
ADDRGP4 $1711
ASGNP4
line 2193
;2193:	s_serveroptions.gameseed.generic.flags		= QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 s_serveroptions+3600+44
CNSTU4 290
ASGNU4
line 2194
;2194:	s_serveroptions.gameseed.generic.x			= 240;
ADDRGP4 s_serveroptions+3600+12
CNSTI4 240
ASGNI4
line 2195
;2195:	s_serveroptions.gameseed.generic.y			= y;
ADDRGP4 s_serveroptions+3600+16
ADDRLP4 4
INDIRI4
ASGNI4
line 2197
;2196:	//s_serveroptions.gameseed.generic.statusbar	= ServerOptions_StatusBar;
;2197:	s_serveroptions.gameseed.field.widthInChars	= 6;
ADDRGP4 s_serveroptions+3600+60+8
CNSTI4 6
ASGNI4
line 2198
;2198:	s_serveroptions.gameseed.field.maxchars		= 5;
ADDRGP4 s_serveroptions+3600+60+268
CNSTI4 5
ASGNI4
line 2202
;2199:#endif
;2200:
;2201:#if MEETING	// JUHOX: init the meeting menu field
;2202:	y += SMALLCHAR_HEIGHT + 4;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 20
ADDI4
ASGNI4
line 2203
;2203:	s_serveroptions.meeting.generic.type			= MTYPE_RADIOBUTTON;
ADDRGP4 s_serveroptions+3932
CNSTI4 5
ASGNI4
line 2204
;2204:	s_serveroptions.meeting.generic.flags			= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 s_serveroptions+3932+44
CNSTU4 258
ASGNU4
line 2205
;2205:	s_serveroptions.meeting.generic.x				= 240;
ADDRGP4 s_serveroptions+3932+12
CNSTI4 240
ASGNI4
line 2206
;2206:	s_serveroptions.meeting.generic.y				= y;
ADDRGP4 s_serveroptions+3932+16
ADDRLP4 4
INDIRI4
ASGNI4
line 2207
;2207:	s_serveroptions.meeting.generic.name			= "Meeting:";
ADDRGP4 s_serveroptions+3932+4
ADDRGP4 $1733
ASGNP4
line 2211
;2208:#endif
;2209:
;2210:#if 1	// JUHOX: init the advanced options menu field
;2211:	s_serveroptions.advOptions.generic.type		= MTYPE_PTEXT;
ADDRGP4 s_serveroptions+2492
CNSTI4 9
ASGNI4
line 2212
;2212:	s_serveroptions.advOptions.generic.flags	= QMF_SMALLFONT|QMF_PULSEIFFOCUS|QMF_CENTER_JUSTIFY;
ADDRGP4 s_serveroptions+2492+44
CNSTU4 266
ASGNU4
line 2213
;2213:	s_serveroptions.advOptions.generic.x		= 320;
ADDRGP4 s_serveroptions+2492+12
CNSTI4 320
ASGNI4
line 2214
;2214:	s_serveroptions.advOptions.generic.y		= 440;
ADDRGP4 s_serveroptions+2492+16
CNSTI4 440
ASGNI4
line 2215
;2215:	s_serveroptions.advOptions.generic.callback	= ServerOptions_AdvancedOptions;
ADDRGP4 s_serveroptions+2492+48
ADDRGP4 ServerOptions_AdvancedOptions
ASGNP4
line 2216
;2216:	s_serveroptions.advOptions.color			= color_red;
ADDRGP4 s_serveroptions+2492+68
ADDRGP4 color_red
ASGNP4
line 2217
;2217:	s_serveroptions.advOptions.style			= UI_SMALLFONT|UI_CENTER;
ADDRGP4 s_serveroptions+2492+64
CNSTI4 17
ASGNI4
line 2218
;2218:	s_serveroptions.advOptions.string			= "Advanced Options";
ADDRGP4 s_serveroptions+2492+60
ADDRGP4 $1749
ASGNP4
line 2221
;2219:#endif
;2220:
;2221:	s_serveroptions.back.generic.type	  = MTYPE_BITMAP;
ADDRGP4 s_serveroptions+7412
CNSTI4 6
ASGNI4
line 2222
;2222:	s_serveroptions.back.generic.name     = GAMESERVER_BACK0;
ADDRGP4 s_serveroptions+7412+4
ADDRGP4 $421
ASGNP4
line 2223
;2223:	s_serveroptions.back.generic.flags    = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_serveroptions+7412+44
CNSTU4 260
ASGNU4
line 2224
;2224:	s_serveroptions.back.generic.callback = ServerOptions_Event;
ADDRGP4 s_serveroptions+7412+48
ADDRGP4 ServerOptions_Event
ASGNP4
line 2225
;2225:	s_serveroptions.back.generic.id	      = ID_BACK;
ADDRGP4 s_serveroptions+7412+8
CNSTI4 24
ASGNI4
line 2226
;2226:	s_serveroptions.back.generic.x		  = 0;
ADDRGP4 s_serveroptions+7412+12
CNSTI4 0
ASGNI4
line 2227
;2227:	s_serveroptions.back.generic.y		  = 480-64;
ADDRGP4 s_serveroptions+7412+16
CNSTI4 416
ASGNI4
line 2228
;2228:	s_serveroptions.back.width  		  = 128;
ADDRGP4 s_serveroptions+7412+76
CNSTI4 128
ASGNI4
line 2229
;2229:	s_serveroptions.back.height  		  = 64;
ADDRGP4 s_serveroptions+7412+80
CNSTI4 64
ASGNI4
line 2230
;2230:	s_serveroptions.back.focuspic         = GAMESERVER_BACK1;
ADDRGP4 s_serveroptions+7412+60
ADDRGP4 $438
ASGNP4
line 2232
;2231:
;2232:	s_serveroptions.next.generic.type	  = MTYPE_BITMAP;
ADDRGP4 s_serveroptions+7324
CNSTI4 6
ASGNI4
line 2233
;2233:	s_serveroptions.next.generic.name     = GAMESERVER_NEXT0;
ADDRGP4 s_serveroptions+7324+4
ADDRGP4 $442
ASGNP4
line 2234
;2234:	s_serveroptions.next.generic.flags    = QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_INACTIVE|QMF_GRAYED|QMF_HIDDEN;
ADDRGP4 s_serveroptions+7324+44
CNSTU4 28944
ASGNU4
line 2235
;2235:	s_serveroptions.next.generic.callback = ServerOptions_Event;
ADDRGP4 s_serveroptions+7324+48
ADDRGP4 ServerOptions_Event
ASGNP4
line 2236
;2236:	s_serveroptions.next.generic.id	      = ID_STARTSERVERNEXT;
ADDRGP4 s_serveroptions+7324+8
CNSTI4 18
ASGNI4
line 2237
;2237:	s_serveroptions.next.generic.x		  = 640;
ADDRGP4 s_serveroptions+7324+12
CNSTI4 640
ASGNI4
line 2238
;2238:	s_serveroptions.next.generic.y		  = 480-64-72;
ADDRGP4 s_serveroptions+7324+16
CNSTI4 344
ASGNI4
line 2239
;2239:	s_serveroptions.next.generic.statusbar  = ServerOptions_StatusBar;
ADDRGP4 s_serveroptions+7324+52
ADDRGP4 ServerOptions_StatusBar
ASGNP4
line 2240
;2240:	s_serveroptions.next.width  		  = 128;
ADDRGP4 s_serveroptions+7324+76
CNSTI4 128
ASGNI4
line 2241
;2241:	s_serveroptions.next.height  		  = 64;
ADDRGP4 s_serveroptions+7324+80
CNSTI4 64
ASGNI4
line 2242
;2242:	s_serveroptions.next.focuspic         = GAMESERVER_NEXT1;
ADDRGP4 s_serveroptions+7324+60
ADDRGP4 $459
ASGNP4
line 2244
;2243:
;2244:	s_serveroptions.go.generic.type	    = MTYPE_BITMAP;
ADDRGP4 s_serveroptions+7236
CNSTI4 6
ASGNI4
line 2245
;2245:	s_serveroptions.go.generic.name     = GAMESERVER_FIGHT0;
ADDRGP4 s_serveroptions+7236+4
ADDRGP4 $1793
ASGNP4
line 2246
;2246:	s_serveroptions.go.generic.flags    = QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_serveroptions+7236+44
CNSTU4 272
ASGNU4
line 2247
;2247:	s_serveroptions.go.generic.callback = ServerOptions_Event;
ADDRGP4 s_serveroptions+7236+48
ADDRGP4 ServerOptions_Event
ASGNP4
line 2248
;2248:	s_serveroptions.go.generic.id	    = ID_GO;
ADDRGP4 s_serveroptions+7236+8
CNSTI4 23
ASGNI4
line 2249
;2249:	s_serveroptions.go.generic.x		= 640;
ADDRGP4 s_serveroptions+7236+12
CNSTI4 640
ASGNI4
line 2250
;2250:	s_serveroptions.go.generic.y		= 480-64;
ADDRGP4 s_serveroptions+7236+16
CNSTI4 416
ASGNI4
line 2251
;2251:	s_serveroptions.go.width  		    = 128;
ADDRGP4 s_serveroptions+7236+76
CNSTI4 128
ASGNI4
line 2252
;2252:	s_serveroptions.go.height  		    = 64;
ADDRGP4 s_serveroptions+7236+80
CNSTI4 64
ASGNI4
line 2253
;2253:	s_serveroptions.go.focuspic         = GAMESERVER_FIGHT1;
ADDRGP4 s_serveroptions+7236+60
ADDRGP4 $1810
ASGNP4
line 2256
;2254:
;2255:#if 1	// JUHOX: gray out variables that are set by the template
;2256:	if (gtmpl.tksGameseed == TKS_fixedValue) s_serveroptions.gameseed.generic.flags |= QMF_GRAYED;
ADDRGP4 gtmpl+228
INDIRI4
CNSTI4 2
NEI4 $1811
ADDRLP4 24
ADDRGP4 s_serveroptions+3600+44
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
LABELV $1811
line 2257
;2257:	if (gtmpl.tksFraglimit == TKS_fixedValue) {
ADDRGP4 gtmpl+236
INDIRI4
CNSTI4 2
NEI4 $1816
line 2258
;2258:		s_serveroptions.flaglimit.generic.flags |= QMF_GRAYED;
ADDRLP4 28
ADDRGP4 s_serveroptions+1432+44
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
line 2259
;2259:		s_serveroptions.fraglimit.generic.flags |= QMF_GRAYED;
ADDRLP4 32
ADDRGP4 s_serveroptions+1100+44
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
line 2260
;2260:	}
LABELV $1816
line 2261
;2261:	if (gtmpl.tksTimelimit == TKS_fixedValue) s_serveroptions.timelimit.generic.flags |= QMF_GRAYED;
ADDRGP4 gtmpl+244
INDIRI4
CNSTI4 2
NEI4 $1823
ADDRLP4 28
ADDRGP4 s_serveroptions+768+44
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
LABELV $1823
line 2263
;2262:#if MONSTER_MODE
;2263:	if (gtmpl.tksArtefacts == TKS_fixedValue) s_serveroptions.artefacts.generic.flags |= QMF_GRAYED;
ADDRGP4 gtmpl+260
INDIRI4
CNSTI4 2
NEI4 $1828
ADDRLP4 32
ADDRGP4 s_serveroptions+1764+44
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
LABELV $1828
line 2266
;2264:#endif
;2265:#if ESCAPE_MODE
;2266:	if (gtmpl.tksDistancelimit == TKS_fixedValue) s_serveroptions.distanceLimit.generic.flags |= QMF_GRAYED;
ADDRGP4 gtmpl+252
INDIRI4
CNSTI4 2
NEI4 $1833
ADDRLP4 36
ADDRGP4 s_serveroptions+2096+44
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
LABELV $1833
line 2268
;2267:#endif
;2268:	if (gtmpl.tksFriendlyfire == TKS_fixedValue) s_serveroptions.friendlyfire.generic.flags |= QMF_GRAYED;
ADDRGP4 gtmpl+388
INDIRI4
CNSTI4 2
NEI4 $1838
ADDRLP4 40
ADDRGP4 s_serveroptions+2428+44
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
LABELV $1838
line 2269
;2269:	if (gtmpl.tksHighscoretype != TKS_missing) s_serveroptions.pure.generic.flags |= QMF_GRAYED;
ADDRGP4 gtmpl+152
INDIRI4
CNSTI4 0
EQI4 $1843
ADDRLP4 44
ADDRGP4 s_serveroptions+3108+44
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
LABELV $1843
line 2272
;2270:#endif
;2271:
;2272:	Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.banner );
ADDRGP4 s_serveroptions
ARGP4
ADDRGP4 s_serveroptions+424
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 2274
;2273:
;2274:	Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.mappic );
ADDRGP4 s_serveroptions
ARGP4
ADDRGP4 s_serveroptions+496
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 2275
;2275:	Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.picframe );
ADDRGP4 s_serveroptions
ARGP4
ADDRGP4 s_serveroptions+584
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 2278
;2276:
;2277:#if ESCAPE_MODE	// JUHOX: no bots in EFH
;2278:	if (s_serveroptions.gametype != GT_EFH)
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 9
EQI4 $1851
line 2280
;2279:#endif
;2280:	Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.botSkill );
ADDRGP4 s_serveroptions
ARGP4
ADDRGP4 s_serveroptions+3172
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
LABELV $1851
line 2281
;2281:	Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.player0 );
ADDRGP4 s_serveroptions
ARGP4
ADDRGP4 s_serveroptions+3996
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 2282
;2282:	for( n = 0; n < PLAYER_SLOTS; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1856
line 2283
;2283:		if( n != 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1860
line 2284
;2284:			Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.playerType[n] );
ADDRGP4 s_serveroptions
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 s_serveroptions+4068
ADDP4
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 2285
;2285:		}
LABELV $1860
line 2286
;2286:		Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.playerName[n] );
ADDRGP4 s_serveroptions
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 s_serveroptions+5220
ADDP4
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 2291
;2287:		// JUHOX: don't add team selector for STU
;2288:#if !MONSTER_MODE
;2289:		if( s_serveroptions.gametype >= GT_TEAM ) {
;2290:#else
;2291:		if (s_serveroptions.gametype >= GT_TEAM && s_serveroptions.gametype != GT_STU) {
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 3
LTI4 $1864
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 8
EQI4 $1864
line 2293
;2292:#endif
;2293:			Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.playerTeam[n] );
ADDRGP4 s_serveroptions
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 s_serveroptions+6084
ADDP4
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 2294
;2294:		}
LABELV $1864
line 2295
;2295:	}
LABELV $1857
line 2282
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 12
LTI4 $1856
line 2297
;2296:
;2297:	if( s_serveroptions.gametype != GT_CTF ) {
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 4
EQI4 $1869
line 2298
;2298:		Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.fraglimit );
ADDRGP4 s_serveroptions
ARGP4
ADDRGP4 s_serveroptions+1100
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 2299
;2299:	}
ADDRGP4 $1870
JUMPV
LABELV $1869
line 2300
;2300:	else {
line 2301
;2301:		Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.flaglimit );
ADDRGP4 s_serveroptions
ARGP4
ADDRGP4 s_serveroptions+1432
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 2302
;2302:	}
LABELV $1870
line 2303
;2303:	Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.timelimit );
ADDRGP4 s_serveroptions
ARGP4
ADDRGP4 s_serveroptions+768
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 2305
;2304:#if MONSTER_MODE	// JUHOX: add the artefacts menu field
;2305:	if (s_serveroptions.gametype == GT_STU) {
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 8
NEI4 $1875
line 2306
;2306:		Menu_AddItem(&s_serveroptions.menu, &s_serveroptions.artefacts);
ADDRGP4 s_serveroptions
ARGP4
ADDRGP4 s_serveroptions+1764
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 2307
;2307:	}
LABELV $1875
line 2310
;2308:#endif
;2309:#if ESCAPE_MODE	// JUHOX add the distanceLimit menu field
;2310:	if (s_serveroptions.gametype == GT_EFH) {
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 9
NEI4 $1879
line 2311
;2311:		Menu_AddItem(&s_serveroptions.menu, &s_serveroptions.distanceLimit);
ADDRGP4 s_serveroptions
ARGP4
ADDRGP4 s_serveroptions+2096
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 2312
;2312:	}
LABELV $1879
line 2314
;2313:#endif
;2314:	if( s_serveroptions.gametype >= GT_TEAM ) {
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 3
LTI4 $1883
line 2315
;2315:		Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.friendlyfire );
ADDRGP4 s_serveroptions
ARGP4
ADDRGP4 s_serveroptions+2428
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 2316
;2316:	}
LABELV $1883
line 2317
;2317:	Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.pure );
ADDRGP4 s_serveroptions
ARGP4
ADDRGP4 s_serveroptions+3108
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 2318
;2318:	if( s_serveroptions.multiplayer ) {
ADDRGP4 s_serveroptions+7500
INDIRI4
CNSTI4 0
EQI4 $1888
line 2319
;2319:		Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.dedicated );
ADDRGP4 s_serveroptions
ARGP4
ADDRGP4 s_serveroptions+672
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 2320
;2320:	}
LABELV $1888
line 2321
;2321:	if( s_serveroptions.multiplayer ) {
ADDRGP4 s_serveroptions+7500
INDIRI4
CNSTI4 0
EQI4 $1892
line 2322
;2322:		Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.hostname );
ADDRGP4 s_serveroptions
ARGP4
ADDRGP4 s_serveroptions+2776
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 2323
;2323:	}
LABELV $1892
line 2324
;2324:	Menu_AddItem(&s_serveroptions.menu, &s_serveroptions.additionalSlots);	// JUHOX
ADDRGP4 s_serveroptions
ARGP4
ADDRGP4 s_serveroptions+3268
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 2325
;2325:	Menu_AddItem(&s_serveroptions.menu, &s_serveroptions.gameseed);	// JUHOX
ADDRGP4 s_serveroptions
ARGP4
ADDRGP4 s_serveroptions+3600
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 2327
;2326:#if MEETING
;2327:	if (s_serveroptions.multiplayer) {
ADDRGP4 s_serveroptions+7500
INDIRI4
CNSTI4 0
EQI4 $1898
line 2328
;2328:		Menu_AddItem(&s_serveroptions.menu, &s_serveroptions.meeting);	// JUHOX
ADDRGP4 s_serveroptions
ARGP4
ADDRGP4 s_serveroptions+3932
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 2329
;2329:	}
LABELV $1898
line 2331
;2330:#endif
;2331:	Menu_AddItem(&s_serveroptions.menu, &s_serveroptions.advOptions);	// JUHOX
ADDRGP4 s_serveroptions
ARGP4
ADDRGP4 s_serveroptions+2492
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 2332
;2332:	s_serveroptions.advOptions.generic.flags &= ~QMF_INACTIVE;	// JUHOX
ADDRLP4 48
ADDRGP4 s_serveroptions+2492+44
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRU4
CNSTU4 4294950911
BANDU4
ASGNU4
line 2334
;2333:
;2334:	Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.back );
ADDRGP4 s_serveroptions
ARGP4
ADDRGP4 s_serveroptions+7412
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 2335
;2335:	Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.next );
ADDRGP4 s_serveroptions
ARGP4
ADDRGP4 s_serveroptions+7324
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 2336
;2336:	Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.go );
ADDRGP4 s_serveroptions
ARGP4
ADDRGP4 s_serveroptions+7236
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 2338
;2337:
;2338:	Menu_AddItem( &s_serveroptions.menu, (void*) &s_serveroptions.punkbuster );
ADDRGP4 s_serveroptions
ARGP4
ADDRGP4 s_serveroptions+7756
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 2340
;2339:	
;2340:	ServerOptions_SetMenuItems();
ADDRGP4 ServerOptions_SetMenuItems
CALLV
pop
line 2341
;2341:}
LABELV $1375
endproc ServerOptions_MenuInit 52 12
export ServerOptions_Cache
proc ServerOptions_Cache 0 4
line 2348
;2342:
;2343:/*
;2344:=================
;2345:ServerOptions_Cache
;2346:=================
;2347:*/
;2348:void ServerOptions_Cache( void ) {
line 2349
;2349:	trap_R_RegisterShaderNoMip( GAMESERVER_BACK0 );
ADDRGP4 $421
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 2350
;2350:	trap_R_RegisterShaderNoMip( GAMESERVER_BACK1 );
ADDRGP4 $438
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 2351
;2351:	trap_R_RegisterShaderNoMip( GAMESERVER_FIGHT0 );
ADDRGP4 $1793
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 2352
;2352:	trap_R_RegisterShaderNoMip( GAMESERVER_FIGHT1 );
ADDRGP4 $1810
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 2353
;2353:	trap_R_RegisterShaderNoMip( GAMESERVER_SELECT );
ADDRGP4 $354
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 2354
;2354:	trap_R_RegisterShaderNoMip( GAMESERVER_UNKNOWNMAP );
ADDRGP4 $326
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 2355
;2355:}
LABELV $1909
endproc ServerOptions_Cache 0 4
proc UI_ServerOptionsMenu 0 4
line 2363
;2356:
;2357:
;2358:/*
;2359:=================
;2360:UI_ServerOptionsMenu
;2361:=================
;2362:*/
;2363:static void UI_ServerOptionsMenu( qboolean multiplayer ) {
line 2364
;2364:	ServerOptions_MenuInit( multiplayer );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 ServerOptions_MenuInit
CALLV
pop
line 2365
;2365:	UI_PushMenu( &s_serveroptions.menu );
ADDRGP4 s_serveroptions
ARGP4
ADDRGP4 UI_PushMenu
CALLV
pop
line 2366
;2366:}
LABELV $1910
endproc UI_ServerOptionsMenu 0 4
proc UI_BotSelectMenu_SortCompare 44 8
line 2427
;2367:
;2368:
;2369:
;2370:/*
;2371:=============================================================================
;2372:
;2373:BOT SELECT MENU *****
;2374:
;2375:=============================================================================
;2376:*/
;2377:
;2378:
;2379:#define BOTSELECT_BACK0			"menu/art/back_0"
;2380:#define BOTSELECT_BACK1			"menu/art/back_1"
;2381:#define BOTSELECT_ACCEPT0		"menu/art/accept_0"
;2382:#define BOTSELECT_ACCEPT1		"menu/art/accept_1"
;2383:#define BOTSELECT_SELECT		"menu/art/opponents_select"
;2384:#define BOTSELECT_SELECTED		"menu/art/opponents_selected"
;2385:#define BOTSELECT_ARROWS		"menu/art/gs_arrows_0"
;2386:#define BOTSELECT_ARROWSL		"menu/art/gs_arrows_l"
;2387:#define BOTSELECT_ARROWSR		"menu/art/gs_arrows_r"
;2388:
;2389:#define PLAYERGRID_COLS			4
;2390:#define PLAYERGRID_ROWS			4
;2391:#define MAX_MODELSPERPAGE		(PLAYERGRID_ROWS * PLAYERGRID_COLS)
;2392:
;2393:
;2394:typedef struct {
;2395:	menuframework_s	menu;
;2396:
;2397:	menutext_s		banner;
;2398:
;2399:	menubitmap_s	pics[MAX_MODELSPERPAGE];
;2400:	menubitmap_s	picbuttons[MAX_MODELSPERPAGE];
;2401:	menutext_s		picnames[MAX_MODELSPERPAGE];
;2402:
;2403:	menubitmap_s	arrows;
;2404:	menubitmap_s	left;
;2405:	menubitmap_s	right;
;2406:
;2407:	menubitmap_s	go;
;2408:	menubitmap_s	back;
;2409:
;2410:	int				numBots;
;2411:	int				modelpage;
;2412:	int				numpages;
;2413:	int				selectedmodel;
;2414:	int				sortedBotNums[MAX_BOTS];
;2415:	char			boticons[MAX_MODELSPERPAGE][MAX_QPATH];
;2416:	char			botnames[MAX_MODELSPERPAGE][16];
;2417:} botSelectInfo_t;
;2418:
;2419:static botSelectInfo_t	botSelectInfo;
;2420:
;2421:
;2422:/*
;2423:=================
;2424:UI_BotSelectMenu_SortCompare
;2425:=================
;2426:*/
;2427:static int QDECL UI_BotSelectMenu_SortCompare( const void *arg1, const void *arg2 ) {
line 2432
;2428:	int			num1, num2;
;2429:	const char	*info1, *info2;
;2430:	const char	*name1, *name2;
;2431:
;2432:	num1 = *(int *)arg1;
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 2433
;2433:	num2 = *(int *)arg2;
ADDRLP4 4
ADDRFP4 4
INDIRP4
INDIRI4
ASGNI4
line 2435
;2434:
;2435:	info1 = UI_GetBotInfoByNumber( num1 );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 UI_GetBotInfoByNumber
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 24
INDIRP4
ASGNP4
line 2436
;2436:	info2 = UI_GetBotInfoByNumber( num2 );
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 UI_GetBotInfoByNumber
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 28
INDIRP4
ASGNP4
line 2438
;2437:
;2438:	name1 = Info_ValueForKey( info1, "name" );
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 $861
ARGP4
ADDRLP4 32
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 32
INDIRP4
ASGNP4
line 2439
;2439:	name2 = Info_ValueForKey( info2, "name" );
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 $861
ARGP4
ADDRLP4 36
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 36
INDIRP4
ASGNP4
line 2441
;2440:
;2441:	return Q_stricmp( name1, name2 );
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
RETI4
LABELV $1912
endproc UI_BotSelectMenu_SortCompare 44 8
proc UI_BotSelectMenu_BuildList 12 16
line 2450
;2442:}
;2443:
;2444:
;2445:/*
;2446:=================
;2447:UI_BotSelectMenu_BuildList
;2448:=================
;2449:*/
;2450:static void UI_BotSelectMenu_BuildList( void ) {
line 2453
;2451:	int		n;
;2452:
;2453:	botSelectInfo.modelpage = 0;
ADDRGP4 botSelectInfo+4908
CNSTI4 0
ASGNI4
line 2454
;2454:	botSelectInfo.numBots = UI_GetNumBots();
ADDRLP4 4
ADDRGP4 UI_GetNumBots
CALLI4
ASGNI4
ADDRGP4 botSelectInfo+4904
ADDRLP4 4
INDIRI4
ASGNI4
line 2455
;2455:	botSelectInfo.numpages = botSelectInfo.numBots / MAX_MODELSPERPAGE;
ADDRGP4 botSelectInfo+4912
ADDRGP4 botSelectInfo+4904
INDIRI4
CNSTI4 16
DIVI4
ASGNI4
line 2456
;2456:	if( botSelectInfo.numBots % MAX_MODELSPERPAGE ) {
ADDRGP4 botSelectInfo+4904
INDIRI4
CNSTI4 16
MODI4
CNSTI4 0
EQI4 $1918
line 2457
;2457:		botSelectInfo.numpages++;
ADDRLP4 8
ADDRGP4 botSelectInfo+4912
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2458
;2458:	}
LABELV $1918
line 2461
;2459:
;2460:	// initialize the array
;2461:	for( n = 0; n < botSelectInfo.numBots; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1925
JUMPV
LABELV $1922
line 2462
;2462:		botSelectInfo.sortedBotNums[n] = n;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botSelectInfo+4920
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 2463
;2463:	}
LABELV $1923
line 2461
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1925
ADDRLP4 0
INDIRI4
ADDRGP4 botSelectInfo+4904
INDIRI4
LTI4 $1922
line 2466
;2464:
;2465:	// now sort it
;2466:	qsort( botSelectInfo.sortedBotNums, botSelectInfo.numBots, sizeof(botSelectInfo.sortedBotNums[0]), UI_BotSelectMenu_SortCompare );
ADDRGP4 botSelectInfo+4920
ARGP4
ADDRGP4 botSelectInfo+4904
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 UI_BotSelectMenu_SortCompare
ARGP4
ADDRGP4 qsort
CALLV
pop
line 2467
;2467:}
LABELV $1913
endproc UI_BotSelectMenu_BuildList 12 16
proc ServerPlayerIcon 80 20
line 2475
;2468:
;2469:
;2470:/*
;2471:=================
;2472:ServerPlayerIcon
;2473:=================
;2474:*/
;2475:static void ServerPlayerIcon( const char *modelAndSkin, char *iconName, int iconNameMaxSize ) {
line 2479
;2476:	char	*skin;
;2477:	char	model[MAX_QPATH];
;2478:
;2479:	Q_strncpyz( model, modelAndSkin, sizeof(model));
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
line 2480
;2480:	skin = Q_strrchr( model, '/' );
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
line 2481
;2481:	if ( skin ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1932
line 2482
;2482:		*skin++ = '\0';
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
line 2483
;2483:	}
ADDRGP4 $1933
JUMPV
LABELV $1932
line 2484
;2484:	else {
line 2485
;2485:		skin = "default";
ADDRLP4 0
ADDRGP4 $1934
ASGNP4
line 2486
;2486:	}
LABELV $1933
line 2488
;2487:
;2488:	Com_sprintf(iconName, iconNameMaxSize, "models/players/%s/icon_%s.tga", model, skin );
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 $1935
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 2490
;2489:
;2490:	if( !trap_R_RegisterShaderNoMip( iconName ) && Q_stricmp( skin, "default" ) != 0 ) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 72
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
NEI4 $1936
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $1934
ARGP4
ADDRLP4 76
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
EQI4 $1936
line 2491
;2491:		Com_sprintf(iconName, iconNameMaxSize, "models/players/%s/icon_default.tga", model );
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 $1938
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 2492
;2492:	}
LABELV $1936
line 2493
;2493:}
LABELV $1931
endproc ServerPlayerIcon 80 20
proc UI_BotSelectMenu_UpdateGrid 36 12
line 2501
;2494:
;2495:
;2496:/*
;2497:=================
;2498:UI_BotSelectMenu_UpdateGrid
;2499:=================
;2500:*/
;2501:static void UI_BotSelectMenu_UpdateGrid( void ) {
line 2506
;2502:	const char	*info;
;2503:	int			i;
;2504:    int			j;
;2505:
;2506:	j = botSelectInfo.modelpage * MAX_MODELSPERPAGE;
ADDRLP4 4
ADDRGP4 botSelectInfo+4908
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 2507
;2507:	for( i = 0; i < (PLAYERGRID_ROWS * PLAYERGRID_COLS); i++, j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1941
line 2508
;2508:		if( j < botSelectInfo.numBots ) { 
ADDRLP4 4
INDIRI4
ADDRGP4 botSelectInfo+4904
INDIRI4
GEI4 $1945
line 2509
;2509:			info = UI_GetBotInfoByNumber( botSelectInfo.sortedBotNums[j] );
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botSelectInfo+4920
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 UI_GetBotInfoByNumber
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 12
INDIRP4
ASGNP4
line 2510
;2510:			ServerPlayerIcon( Info_ValueForKey( info, "model" ), botSelectInfo.boticons[i], MAX_QPATH );
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 $1949
ARGP4
ADDRLP4 16
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 botSelectInfo+9016
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 ServerPlayerIcon
CALLV
pop
line 2511
;2511:			Q_strncpyz( botSelectInfo.botnames[i], Info_ValueForKey( info, "name" ), 16 );
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 $861
ARGP4
ADDRLP4 20
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 botSelectInfo+10040
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
line 2512
;2512:			Q_CleanStr( botSelectInfo.botnames[i] );
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 botSelectInfo+10040
ADDP4
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 2513
;2513: 			botSelectInfo.pics[i].generic.name = botSelectInfo.boticons[i];
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 botSelectInfo+496+4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 botSelectInfo+9016
ADDP4
ASGNP4
line 2514
;2514:			if( BotAlreadySelected( botSelectInfo.botnames[i] ) ) {
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 botSelectInfo+10040
ADDP4
ARGP4
ADDRLP4 28
ADDRGP4 BotAlreadySelected
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $1956
line 2515
;2515:				botSelectInfo.picnames[i].color = color_red;
ADDRLP4 0
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 botSelectInfo+3312+68
ADDP4
ADDRGP4 color_red
ASGNP4
line 2516
;2516:			}
ADDRGP4 $1957
JUMPV
LABELV $1956
line 2517
;2517:			else {
line 2518
;2518:				botSelectInfo.picnames[i].color = color_orange;
ADDRLP4 0
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 botSelectInfo+3312+68
ADDP4
ADDRGP4 color_orange
ASGNP4
line 2519
;2519:			}
LABELV $1957
line 2520
;2520:			botSelectInfo.picbuttons[i].generic.flags &= ~QMF_INACTIVE;
ADDRLP4 32
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 botSelectInfo+1904+44
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRU4
CNSTU4 4294950911
BANDU4
ASGNU4
line 2521
;2521:		}
ADDRGP4 $1946
JUMPV
LABELV $1945
line 2522
;2522:		else {
line 2524
;2523:			// dead slot
;2524: 			botSelectInfo.pics[i].generic.name         = NULL;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 botSelectInfo+496+4
ADDP4
CNSTP4 0
ASGNP4
line 2525
;2525:			botSelectInfo.picbuttons[i].generic.flags |= QMF_INACTIVE;
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 botSelectInfo+1904+44
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRU4
CNSTU4 16384
BORU4
ASGNU4
line 2526
;2526:			botSelectInfo.botnames[i][0] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 botSelectInfo+10040
ADDP4
CNSTI1 0
ASGNI1
line 2527
;2527:		}
LABELV $1946
line 2529
;2528:
;2529: 		botSelectInfo.pics[i].generic.flags       &= ~QMF_HIGHLIGHT;
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 botSelectInfo+496+44
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRU4
CNSTU4 4294967231
BANDU4
ASGNU4
line 2530
;2530: 		botSelectInfo.pics[i].shader               = 0;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 botSelectInfo+496+68
ADDP4
CNSTI4 0
ASGNI4
line 2531
;2531: 		botSelectInfo.picbuttons[i].generic.flags |= QMF_PULSEIFFOCUS;
ADDRLP4 16
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 botSelectInfo+1904+44
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRU4
CNSTU4 256
BORU4
ASGNU4
line 2532
;2532:	}
LABELV $1942
line 2507
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $1941
line 2535
;2533:
;2534:	// set selected model
;2535:	i = botSelectInfo.selectedmodel % MAX_MODELSPERPAGE;
ADDRLP4 0
ADDRGP4 botSelectInfo+4916
INDIRI4
CNSTI4 16
MODI4
ASGNI4
line 2536
;2536:	botSelectInfo.pics[i].generic.flags |= QMF_HIGHLIGHT;
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 botSelectInfo+496+44
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRU4
CNSTU4 64
BORU4
ASGNU4
line 2537
;2537:	botSelectInfo.picbuttons[i].generic.flags &= ~QMF_PULSEIFFOCUS;
ADDRLP4 16
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 botSelectInfo+1904+44
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRU4
CNSTU4 4294967039
BANDU4
ASGNU4
line 2539
;2538:
;2539:	if( botSelectInfo.numpages > 1 ) {
ADDRGP4 botSelectInfo+4912
INDIRI4
CNSTI4 1
LEI4 $1981
line 2540
;2540:		if( botSelectInfo.modelpage > 0 ) {
ADDRGP4 botSelectInfo+4908
INDIRI4
CNSTI4 0
LEI4 $1984
line 2541
;2541:			botSelectInfo.left.generic.flags &= ~QMF_INACTIVE;
ADDRLP4 20
ADDRGP4 botSelectInfo+4552+44
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRU4
CNSTU4 4294950911
BANDU4
ASGNU4
line 2542
;2542:		}
ADDRGP4 $1985
JUMPV
LABELV $1984
line 2543
;2543:		else {
line 2544
;2544:			botSelectInfo.left.generic.flags |= QMF_INACTIVE;
ADDRLP4 20
ADDRGP4 botSelectInfo+4552+44
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRU4
CNSTU4 16384
BORU4
ASGNU4
line 2545
;2545:		}
LABELV $1985
line 2547
;2546:
;2547:		if( botSelectInfo.modelpage < (botSelectInfo.numpages - 1) ) {
ADDRGP4 botSelectInfo+4908
INDIRI4
ADDRGP4 botSelectInfo+4912
INDIRI4
CNSTI4 1
SUBI4
GEI4 $1991
line 2548
;2548:			botSelectInfo.right.generic.flags &= ~QMF_INACTIVE;
ADDRLP4 20
ADDRGP4 botSelectInfo+4640+44
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRU4
CNSTU4 4294950911
BANDU4
ASGNU4
line 2549
;2549:		}
ADDRGP4 $1982
JUMPV
LABELV $1991
line 2550
;2550:		else {
line 2551
;2551:			botSelectInfo.right.generic.flags |= QMF_INACTIVE;
ADDRLP4 20
ADDRGP4 botSelectInfo+4640+44
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRU4
CNSTU4 16384
BORU4
ASGNU4
line 2552
;2552:		}
line 2553
;2553:	}
ADDRGP4 $1982
JUMPV
LABELV $1981
line 2554
;2554:	else {
line 2556
;2555:		// hide left/right markers
;2556:		botSelectInfo.left.generic.flags |= QMF_INACTIVE;
ADDRLP4 20
ADDRGP4 botSelectInfo+4552+44
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRU4
CNSTU4 16384
BORU4
ASGNU4
line 2557
;2557:		botSelectInfo.right.generic.flags |= QMF_INACTIVE;
ADDRLP4 24
ADDRGP4 botSelectInfo+4640+44
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRU4
CNSTU4 16384
BORU4
ASGNU4
line 2558
;2558:	}
LABELV $1982
line 2559
;2559:}
LABELV $1939
endproc UI_BotSelectMenu_UpdateGrid 36 12
proc UI_BotSelectMenu_Default 28 8
line 2567
;2560:
;2561:
;2562:/*
;2563:=================
;2564:UI_BotSelectMenu_Default
;2565:=================
;2566:*/
;2567:static void UI_BotSelectMenu_Default( char *bot ) {
line 2573
;2568:	const char	*botInfo;
;2569:	const char	*test;
;2570:	int			n;
;2571:	int			i;
;2572:
;2573:	for( n = 0; n < botSelectInfo.numBots; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2007
JUMPV
LABELV $2004
line 2574
;2574:		botInfo = UI_GetBotInfoByNumber( n );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 UI_GetBotInfoByNumber
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 16
INDIRP4
ASGNP4
line 2575
;2575:		test = Info_ValueForKey( botInfo, "name" );
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 $861
ARGP4
ADDRLP4 20
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 20
INDIRP4
ASGNP4
line 2576
;2576:		if( Q_stricmp( bot, test ) == 0 ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $2009
line 2577
;2577:			break;
ADDRGP4 $2006
JUMPV
LABELV $2009
line 2579
;2578:		}
;2579:	}
LABELV $2005
line 2573
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2007
ADDRLP4 0
INDIRI4
ADDRGP4 botSelectInfo+4904
INDIRI4
LTI4 $2004
LABELV $2006
line 2580
;2580:	if( n == botSelectInfo.numBots ) {
ADDRLP4 0
INDIRI4
ADDRGP4 botSelectInfo+4904
INDIRI4
NEI4 $2011
line 2581
;2581:		botSelectInfo.selectedmodel = 0;
ADDRGP4 botSelectInfo+4916
CNSTI4 0
ASGNI4
line 2582
;2582:		return;
ADDRGP4 $2003
JUMPV
LABELV $2011
line 2585
;2583:	}
;2584:
;2585:	for( i = 0; i < botSelectInfo.numBots; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $2018
JUMPV
LABELV $2015
line 2586
;2586:		if( botSelectInfo.sortedBotNums[i] == n ) {
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botSelectInfo+4920
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $2020
line 2587
;2587:			break;
ADDRGP4 $2017
JUMPV
LABELV $2020
line 2589
;2588:		}
;2589:	}
LABELV $2016
line 2585
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2018
ADDRLP4 4
INDIRI4
ADDRGP4 botSelectInfo+4904
INDIRI4
LTI4 $2015
LABELV $2017
line 2590
;2590:	if( i == botSelectInfo.numBots ) {
ADDRLP4 4
INDIRI4
ADDRGP4 botSelectInfo+4904
INDIRI4
NEI4 $2023
line 2591
;2591:		botSelectInfo.selectedmodel = 0;
ADDRGP4 botSelectInfo+4916
CNSTI4 0
ASGNI4
line 2592
;2592:		return;
ADDRGP4 $2003
JUMPV
LABELV $2023
line 2595
;2593:	}
;2594:
;2595:	botSelectInfo.selectedmodel = i;
ADDRGP4 botSelectInfo+4916
ADDRLP4 4
INDIRI4
ASGNI4
line 2596
;2596:}
LABELV $2003
endproc UI_BotSelectMenu_Default 28 8
proc UI_BotSelectMenu_LeftEvent 4 0
line 2604
;2597:
;2598:
;2599:/*
;2600:=================
;2601:UI_BotSelectMenu_LeftEvent
;2602:=================
;2603:*/
;2604:static void UI_BotSelectMenu_LeftEvent( void* ptr, int event ) {
line 2605
;2605:	if( event != QM_ACTIVATED ) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $2029
line 2606
;2606:		return;
ADDRGP4 $2028
JUMPV
LABELV $2029
line 2608
;2607:	}
;2608:	if( botSelectInfo.modelpage > 0 ) {
ADDRGP4 botSelectInfo+4908
INDIRI4
CNSTI4 0
LEI4 $2031
line 2609
;2609:		botSelectInfo.modelpage--;
ADDRLP4 0
ADDRGP4 botSelectInfo+4908
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2610
;2610:		botSelectInfo.selectedmodel = botSelectInfo.modelpage * MAX_MODELSPERPAGE;
ADDRGP4 botSelectInfo+4916
ADDRGP4 botSelectInfo+4908
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 2611
;2611:		UI_BotSelectMenu_UpdateGrid();
ADDRGP4 UI_BotSelectMenu_UpdateGrid
CALLV
pop
line 2612
;2612:	}
LABELV $2031
line 2613
;2613:}
LABELV $2028
endproc UI_BotSelectMenu_LeftEvent 4 0
proc UI_BotSelectMenu_RightEvent 4 0
line 2621
;2614:
;2615:
;2616:/*
;2617:=================
;2618:UI_BotSelectMenu_RightEvent
;2619:=================
;2620:*/
;2621:static void UI_BotSelectMenu_RightEvent( void* ptr, int event ) {
line 2622
;2622:	if( event != QM_ACTIVATED ) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $2038
line 2623
;2623:		return;
ADDRGP4 $2037
JUMPV
LABELV $2038
line 2625
;2624:	}
;2625:	if( botSelectInfo.modelpage < botSelectInfo.numpages - 1 ) {
ADDRGP4 botSelectInfo+4908
INDIRI4
ADDRGP4 botSelectInfo+4912
INDIRI4
CNSTI4 1
SUBI4
GEI4 $2040
line 2626
;2626:		botSelectInfo.modelpage++;
ADDRLP4 0
ADDRGP4 botSelectInfo+4908
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2627
;2627:		botSelectInfo.selectedmodel = botSelectInfo.modelpage * MAX_MODELSPERPAGE;
ADDRGP4 botSelectInfo+4916
ADDRGP4 botSelectInfo+4908
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 2628
;2628:		UI_BotSelectMenu_UpdateGrid();
ADDRGP4 UI_BotSelectMenu_UpdateGrid
CALLV
pop
line 2629
;2629:	}
LABELV $2040
line 2630
;2630:}
LABELV $2037
endproc UI_BotSelectMenu_RightEvent 4 0
proc UI_BotSelectMenu_BotEvent 12 0
line 2638
;2631:
;2632:
;2633:/*
;2634:=================
;2635:UI_BotSelectMenu_BotEvent
;2636:=================
;2637:*/
;2638:static void UI_BotSelectMenu_BotEvent( void* ptr, int event ) {
line 2641
;2639:	int		i;
;2640:
;2641:	if( event != QM_ACTIVATED ) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $2048
line 2642
;2642:		return;
ADDRGP4 $2047
JUMPV
LABELV $2048
line 2645
;2643:	}
;2644:
;2645:	for( i = 0; i < (PLAYERGRID_ROWS * PLAYERGRID_COLS); i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2050
line 2646
;2646: 		botSelectInfo.pics[i].generic.flags &= ~QMF_HIGHLIGHT;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 botSelectInfo+496+44
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRU4
CNSTU4 4294967231
BANDU4
ASGNU4
line 2647
;2647: 		botSelectInfo.picbuttons[i].generic.flags |= QMF_PULSEIFFOCUS;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 botSelectInfo+1904+44
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 256
BORU4
ASGNU4
line 2648
;2648:	}
LABELV $2051
line 2645
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $2050
line 2651
;2649:
;2650:	// set selected
;2651:	i = ((menucommon_s*)ptr)->id;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 2652
;2652:	botSelectInfo.pics[i].generic.flags |= QMF_HIGHLIGHT;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 botSelectInfo+496+44
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRU4
CNSTU4 64
BORU4
ASGNU4
line 2653
;2653:	botSelectInfo.picbuttons[i].generic.flags &= ~QMF_PULSEIFFOCUS;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 botSelectInfo+1904+44
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 4294967039
BANDU4
ASGNU4
line 2654
;2654:	botSelectInfo.selectedmodel = botSelectInfo.modelpage * MAX_MODELSPERPAGE + i;
ADDRGP4 botSelectInfo+4916
ADDRGP4 botSelectInfo+4908
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 2655
;2655:}
LABELV $2047
endproc UI_BotSelectMenu_BotEvent 12 0
proc UI_BotSelectMenu_BackEvent 0 0
line 2663
;2656:
;2657:
;2658:/*
;2659:=================
;2660:UI_BotSelectMenu_BackEvent
;2661:=================
;2662:*/
;2663:static void UI_BotSelectMenu_BackEvent( void* ptr, int event ) {
line 2664
;2664:	if( event != QM_ACTIVATED ) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $2065
line 2665
;2665:		return;
ADDRGP4 $2064
JUMPV
LABELV $2065
line 2667
;2666:	}
;2667:	UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 2668
;2668:}
LABELV $2064
endproc UI_BotSelectMenu_BackEvent 0 0
proc UI_BotSelectMenu_SelectEvent 0 12
line 2676
;2669:
;2670:
;2671:/*
;2672:=================
;2673:UI_BotSelectMenu_SelectEvent
;2674:=================
;2675:*/
;2676:static void UI_BotSelectMenu_SelectEvent( void* ptr, int event ) {
line 2677
;2677:	if( event != QM_ACTIVATED ) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $2068
line 2678
;2678:		return;
ADDRGP4 $2067
JUMPV
LABELV $2068
line 2680
;2679:	}
;2680:	UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 2682
;2681:
;2682:	s_serveroptions.newBot = qtrue;
ADDRGP4 s_serveroptions+7732
CNSTI4 1
ASGNI4
line 2683
;2683:	Q_strncpyz( s_serveroptions.newBotName, botSelectInfo.botnames[botSelectInfo.selectedmodel % MAX_MODELSPERPAGE], 16 );
ADDRGP4 s_serveroptions+7740
ARGP4
ADDRGP4 botSelectInfo+4916
INDIRI4
CNSTI4 16
MODI4
CNSTI4 4
LSHI4
ADDRGP4 botSelectInfo+10040
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 2684
;2684:}
LABELV $2067
endproc UI_BotSelectMenu_SelectEvent 0 12
export UI_BotSelectMenu_Cache
proc UI_BotSelectMenu_Cache 0 4
line 2692
;2685:
;2686:
;2687:/*
;2688:=================
;2689:UI_BotSelectMenu_Cache
;2690:=================
;2691:*/
;2692:void UI_BotSelectMenu_Cache( void ) {
line 2693
;2693:	trap_R_RegisterShaderNoMip( BOTSELECT_BACK0 );
ADDRGP4 $421
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 2694
;2694:	trap_R_RegisterShaderNoMip( BOTSELECT_BACK1 );
ADDRGP4 $438
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 2695
;2695:	trap_R_RegisterShaderNoMip( BOTSELECT_ACCEPT0 );
ADDRGP4 $2075
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 2696
;2696:	trap_R_RegisterShaderNoMip( BOTSELECT_ACCEPT1 );
ADDRGP4 $2076
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 2697
;2697:	trap_R_RegisterShaderNoMip( BOTSELECT_SELECT );
ADDRGP4 $2077
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 2698
;2698:	trap_R_RegisterShaderNoMip( BOTSELECT_SELECTED );
ADDRGP4 $2078
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 2699
;2699:	trap_R_RegisterShaderNoMip( BOTSELECT_ARROWS );
ADDRGP4 $358
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 2700
;2700:	trap_R_RegisterShaderNoMip( BOTSELECT_ARROWSL );
ADDRGP4 $386
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 2701
;2701:	trap_R_RegisterShaderNoMip( BOTSELECT_ARROWSR );
ADDRGP4 $404
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 2702
;2702:}
LABELV $2074
endproc UI_BotSelectMenu_Cache 0 4
proc UI_BotSelectMenu_Init 32 12
line 2705
;2703:
;2704:
;2705:static void UI_BotSelectMenu_Init( char *bot ) {
line 2709
;2706:	int		i, j, k;
;2707:	int		x, y;
;2708:
;2709:	memset( &botSelectInfo, 0 ,sizeof(botSelectInfo) );
ADDRGP4 botSelectInfo
ARGP4
CNSTI4 0
ARGI4
CNSTI4 10296
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2710
;2710:	botSelectInfo.menu.wrapAround = qtrue;
ADDRGP4 botSelectInfo+404
CNSTI4 1
ASGNI4
line 2711
;2711:	botSelectInfo.menu.fullscreen = qtrue;
ADDRGP4 botSelectInfo+408
CNSTI4 1
ASGNI4
line 2713
;2712:
;2713:	UI_BotSelectMenu_Cache();
ADDRGP4 UI_BotSelectMenu_Cache
CALLV
pop
line 2715
;2714:
;2715:	botSelectInfo.banner.generic.type	= MTYPE_BTEXT;
ADDRGP4 botSelectInfo+424
CNSTI4 10
ASGNI4
line 2716
;2716:	botSelectInfo.banner.generic.x		= 320;
ADDRGP4 botSelectInfo+424+12
CNSTI4 320
ASGNI4
line 2717
;2717:	botSelectInfo.banner.generic.y		= 16;
ADDRGP4 botSelectInfo+424+16
CNSTI4 16
ASGNI4
line 2718
;2718:	botSelectInfo.banner.string			= "SELECT BOT";
ADDRGP4 botSelectInfo+424+60
ADDRGP4 $2089
ASGNP4
line 2719
;2719:	botSelectInfo.banner.color			= color_white;
ADDRGP4 botSelectInfo+424+68
ADDRGP4 color_white
ASGNP4
line 2720
;2720:	botSelectInfo.banner.style			= UI_CENTER;
ADDRGP4 botSelectInfo+424+64
CNSTI4 1
ASGNI4
line 2722
;2721:
;2722:	y =	80;
ADDRLP4 8
CNSTI4 80
ASGNI4
line 2723
;2723:	for( i = 0, k = 0; i < PLAYERGRID_ROWS; i++) {
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2097
JUMPV
LABELV $2094
line 2724
;2724:		x =	180;
ADDRLP4 4
CNSTI4 180
ASGNI4
line 2725
;2725:		for( j = 0; j < PLAYERGRID_COLS; j++, k++ ) {
ADDRLP4 12
CNSTI4 0
ASGNI4
LABELV $2098
line 2726
;2726:			botSelectInfo.pics[k].generic.type				= MTYPE_BITMAP;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 botSelectInfo+496
ADDP4
CNSTI4 6
ASGNI4
line 2727
;2727:			botSelectInfo.pics[k].generic.flags				= QMF_LEFT_JUSTIFY|QMF_INACTIVE;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 botSelectInfo+496+44
ADDP4
CNSTU4 16388
ASGNU4
line 2728
;2728:			botSelectInfo.pics[k].generic.x					= x;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 botSelectInfo+496+12
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 2729
;2729:			botSelectInfo.pics[k].generic.y					= y;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 botSelectInfo+496+16
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 2730
;2730: 			botSelectInfo.pics[k].generic.name				= botSelectInfo.boticons[k];
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 botSelectInfo+496+4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 botSelectInfo+9016
ADDP4
ASGNP4
line 2731
;2731:			botSelectInfo.pics[k].width						= 64;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 botSelectInfo+496+76
ADDP4
CNSTI4 64
ASGNI4
line 2732
;2732:			botSelectInfo.pics[k].height					= 64;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 botSelectInfo+496+80
ADDP4
CNSTI4 64
ASGNI4
line 2733
;2733:			botSelectInfo.pics[k].focuspic					= BOTSELECT_SELECTED;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 botSelectInfo+496+60
ADDP4
ADDRGP4 $2078
ASGNP4
line 2734
;2734:			botSelectInfo.pics[k].focuscolor				= colorRed;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 botSelectInfo+496+84
ADDP4
ADDRGP4 colorRed
ASGNP4
line 2736
;2735:
;2736:			botSelectInfo.picbuttons[k].generic.type		= MTYPE_BITMAP;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 botSelectInfo+1904
ADDP4
CNSTI4 6
ASGNI4
line 2737
;2737:			botSelectInfo.picbuttons[k].generic.flags		= QMF_LEFT_JUSTIFY|QMF_NODEFAULTINIT|QMF_PULSEIFFOCUS;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 botSelectInfo+1904+44
ADDP4
CNSTU4 33028
ASGNU4
line 2738
;2738:			botSelectInfo.picbuttons[k].generic.callback	= UI_BotSelectMenu_BotEvent;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 botSelectInfo+1904+48
ADDP4
ADDRGP4 UI_BotSelectMenu_BotEvent
ASGNP4
line 2739
;2739:			botSelectInfo.picbuttons[k].generic.id			= k;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 botSelectInfo+1904+8
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 2740
;2740:			botSelectInfo.picbuttons[k].generic.x			= x - 16;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 botSelectInfo+1904+12
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 16
SUBI4
ASGNI4
line 2741
;2741:			botSelectInfo.picbuttons[k].generic.y			= y - 16;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 botSelectInfo+1904+16
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 16
SUBI4
ASGNI4
line 2742
;2742:			botSelectInfo.picbuttons[k].generic.left		= x;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 botSelectInfo+1904+20
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 2743
;2743:			botSelectInfo.picbuttons[k].generic.top			= y;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 botSelectInfo+1904+24
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 2744
;2744:			botSelectInfo.picbuttons[k].generic.right		= x + 64;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 botSelectInfo+1904+28
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 64
ADDI4
ASGNI4
line 2745
;2745:			botSelectInfo.picbuttons[k].generic.bottom		= y + 64;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 botSelectInfo+1904+32
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 64
ADDI4
ASGNI4
line 2746
;2746:			botSelectInfo.picbuttons[k].width				= 128;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 botSelectInfo+1904+76
ADDP4
CNSTI4 128
ASGNI4
line 2747
;2747:			botSelectInfo.picbuttons[k].height				= 128;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 botSelectInfo+1904+80
ADDP4
CNSTI4 128
ASGNI4
line 2748
;2748:			botSelectInfo.picbuttons[k].focuspic			= BOTSELECT_SELECT;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 botSelectInfo+1904+60
ADDP4
ADDRGP4 $2077
ASGNP4
line 2749
;2749:			botSelectInfo.picbuttons[k].focuscolor			= colorRed;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 botSelectInfo+1904+84
ADDP4
ADDRGP4 colorRed
ASGNP4
line 2751
;2750:
;2751:			botSelectInfo.picnames[k].generic.type			= MTYPE_TEXT;
ADDRLP4 0
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 botSelectInfo+3312
ADDP4
CNSTI4 7
ASGNI4
line 2752
;2752:			botSelectInfo.picnames[k].generic.flags			= QMF_SMALLFONT;
ADDRLP4 0
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 botSelectInfo+3312+44
ADDP4
CNSTU4 2
ASGNU4
line 2753
;2753:			botSelectInfo.picnames[k].generic.x				= x + 32;
ADDRLP4 0
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 botSelectInfo+3312+12
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 32
ADDI4
ASGNI4
line 2754
;2754:			botSelectInfo.picnames[k].generic.y				= y + 64;
ADDRLP4 0
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 botSelectInfo+3312+16
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 64
ADDI4
ASGNI4
line 2755
;2755:			botSelectInfo.picnames[k].string				= botSelectInfo.botnames[k];
ADDRLP4 0
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 botSelectInfo+3312+60
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 botSelectInfo+10040
ADDP4
ASGNP4
line 2756
;2756:			botSelectInfo.picnames[k].color					= color_orange;
ADDRLP4 0
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 botSelectInfo+3312+68
ADDP4
ADDRGP4 color_orange
ASGNP4
line 2757
;2757:			botSelectInfo.picnames[k].style					= UI_CENTER|UI_SMALLFONT;
ADDRLP4 0
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 botSelectInfo+3312+64
ADDP4
CNSTI4 17
ASGNI4
line 2759
;2758:
;2759:			x += (64 + 6);
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 70
ADDI4
ASGNI4
line 2760
;2760:		}
LABELV $2099
line 2725
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 4
LTI4 $2098
line 2761
;2761:		y += (64 + SMALLCHAR_HEIGHT + 6);
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 86
ADDI4
ASGNI4
line 2762
;2762:	}
LABELV $2095
line 2723
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2097
ADDRLP4 16
INDIRI4
CNSTI4 4
LTI4 $2094
line 2764
;2763:
;2764:	botSelectInfo.arrows.generic.type		= MTYPE_BITMAP;
ADDRGP4 botSelectInfo+4464
CNSTI4 6
ASGNI4
line 2765
;2765:	botSelectInfo.arrows.generic.name		= BOTSELECT_ARROWS;
ADDRGP4 botSelectInfo+4464+4
ADDRGP4 $358
ASGNP4
line 2766
;2766:	botSelectInfo.arrows.generic.flags		= QMF_INACTIVE;
ADDRGP4 botSelectInfo+4464+44
CNSTU4 16384
ASGNU4
line 2767
;2767:	botSelectInfo.arrows.generic.x			= 260;
ADDRGP4 botSelectInfo+4464+12
CNSTI4 260
ASGNI4
line 2768
;2768:	botSelectInfo.arrows.generic.y			= 440;
ADDRGP4 botSelectInfo+4464+16
CNSTI4 440
ASGNI4
line 2769
;2769:	botSelectInfo.arrows.width				= 128;
ADDRGP4 botSelectInfo+4464+76
CNSTI4 128
ASGNI4
line 2770
;2770:	botSelectInfo.arrows.height				= 32;
ADDRGP4 botSelectInfo+4464+80
CNSTI4 32
ASGNI4
line 2772
;2771:
;2772:	botSelectInfo.left.generic.type			= MTYPE_BITMAP;
ADDRGP4 botSelectInfo+4552
CNSTI4 6
ASGNI4
line 2773
;2773:	botSelectInfo.left.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 botSelectInfo+4552+44
CNSTU4 260
ASGNU4
line 2774
;2774:	botSelectInfo.left.generic.callback		= UI_BotSelectMenu_LeftEvent;
ADDRGP4 botSelectInfo+4552+48
ADDRGP4 UI_BotSelectMenu_LeftEvent
ASGNP4
line 2775
;2775:	botSelectInfo.left.generic.x			= 260;
ADDRGP4 botSelectInfo+4552+12
CNSTI4 260
ASGNI4
line 2776
;2776:	botSelectInfo.left.generic.y			= 440;
ADDRGP4 botSelectInfo+4552+16
CNSTI4 440
ASGNI4
line 2777
;2777:	botSelectInfo.left.width  				= 64;
ADDRGP4 botSelectInfo+4552+76
CNSTI4 64
ASGNI4
line 2778
;2778:	botSelectInfo.left.height  				= 32;
ADDRGP4 botSelectInfo+4552+80
CNSTI4 32
ASGNI4
line 2779
;2779:	botSelectInfo.left.focuspic				= BOTSELECT_ARROWSL;
ADDRGP4 botSelectInfo+4552+60
ADDRGP4 $386
ASGNP4
line 2781
;2780:
;2781:	botSelectInfo.right.generic.type	    = MTYPE_BITMAP;
ADDRGP4 botSelectInfo+4640
CNSTI4 6
ASGNI4
line 2782
;2782:	botSelectInfo.right.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 botSelectInfo+4640+44
CNSTU4 260
ASGNU4
line 2783
;2783:	botSelectInfo.right.generic.callback	= UI_BotSelectMenu_RightEvent;
ADDRGP4 botSelectInfo+4640+48
ADDRGP4 UI_BotSelectMenu_RightEvent
ASGNP4
line 2784
;2784:	botSelectInfo.right.generic.x			= 321;
ADDRGP4 botSelectInfo+4640+12
CNSTI4 321
ASGNI4
line 2785
;2785:	botSelectInfo.right.generic.y			= 440;
ADDRGP4 botSelectInfo+4640+16
CNSTI4 440
ASGNI4
line 2786
;2786:	botSelectInfo.right.width  				= 64;
ADDRGP4 botSelectInfo+4640+76
CNSTI4 64
ASGNI4
line 2787
;2787:	botSelectInfo.right.height  		    = 32;
ADDRGP4 botSelectInfo+4640+80
CNSTI4 32
ASGNI4
line 2788
;2788:	botSelectInfo.right.focuspic			= BOTSELECT_ARROWSR;
ADDRGP4 botSelectInfo+4640+60
ADDRGP4 $404
ASGNP4
line 2790
;2789:
;2790:	botSelectInfo.back.generic.type		= MTYPE_BITMAP;
ADDRGP4 botSelectInfo+4816
CNSTI4 6
ASGNI4
line 2791
;2791:	botSelectInfo.back.generic.name		= BOTSELECT_BACK0;
ADDRGP4 botSelectInfo+4816+4
ADDRGP4 $421
ASGNP4
line 2792
;2792:	botSelectInfo.back.generic.flags	= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 botSelectInfo+4816+44
CNSTU4 260
ASGNU4
line 2793
;2793:	botSelectInfo.back.generic.callback	= UI_BotSelectMenu_BackEvent;
ADDRGP4 botSelectInfo+4816+48
ADDRGP4 UI_BotSelectMenu_BackEvent
ASGNP4
line 2794
;2794:	botSelectInfo.back.generic.x		= 0;
ADDRGP4 botSelectInfo+4816+12
CNSTI4 0
ASGNI4
line 2795
;2795:	botSelectInfo.back.generic.y		= 480-64;
ADDRGP4 botSelectInfo+4816+16
CNSTI4 416
ASGNI4
line 2796
;2796:	botSelectInfo.back.width			= 128;
ADDRGP4 botSelectInfo+4816+76
CNSTI4 128
ASGNI4
line 2797
;2797:	botSelectInfo.back.height			= 64;
ADDRGP4 botSelectInfo+4816+80
CNSTI4 64
ASGNI4
line 2798
;2798:	botSelectInfo.back.focuspic			= BOTSELECT_BACK1;
ADDRGP4 botSelectInfo+4816+60
ADDRGP4 $438
ASGNP4
line 2800
;2799:
;2800:	botSelectInfo.go.generic.type		= MTYPE_BITMAP;
ADDRGP4 botSelectInfo+4728
CNSTI4 6
ASGNI4
line 2801
;2801:	botSelectInfo.go.generic.name		= BOTSELECT_ACCEPT0;
ADDRGP4 botSelectInfo+4728+4
ADDRGP4 $2075
ASGNP4
line 2802
;2802:	botSelectInfo.go.generic.flags		= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 botSelectInfo+4728+44
CNSTU4 272
ASGNU4
line 2803
;2803:	botSelectInfo.go.generic.callback	= UI_BotSelectMenu_SelectEvent;
ADDRGP4 botSelectInfo+4728+48
ADDRGP4 UI_BotSelectMenu_SelectEvent
ASGNP4
line 2804
;2804:	botSelectInfo.go.generic.x			= 640;
ADDRGP4 botSelectInfo+4728+12
CNSTI4 640
ASGNI4
line 2805
;2805:	botSelectInfo.go.generic.y			= 480-64;
ADDRGP4 botSelectInfo+4728+16
CNSTI4 416
ASGNI4
line 2806
;2806:	botSelectInfo.go.width				= 128;
ADDRGP4 botSelectInfo+4728+76
CNSTI4 128
ASGNI4
line 2807
;2807:	botSelectInfo.go.height				= 64;
ADDRGP4 botSelectInfo+4728+80
CNSTI4 64
ASGNI4
line 2808
;2808:	botSelectInfo.go.focuspic			= BOTSELECT_ACCEPT1;
ADDRGP4 botSelectInfo+4728+60
ADDRGP4 $2076
ASGNP4
line 2810
;2809:
;2810:	Menu_AddItem( &botSelectInfo.menu, &botSelectInfo.banner );
ADDRGP4 botSelectInfo
ARGP4
ADDRGP4 botSelectInfo+424
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 2811
;2811:	for( i = 0; i < MAX_MODELSPERPAGE; i++ ) {
ADDRLP4 16
CNSTI4 0
ASGNI4
LABELV $2239
line 2812
;2812:		Menu_AddItem( &botSelectInfo.menu,	&botSelectInfo.pics[i] );
ADDRGP4 botSelectInfo
ARGP4
ADDRLP4 16
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 botSelectInfo+496
ADDP4
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 2813
;2813:		Menu_AddItem( &botSelectInfo.menu,	&botSelectInfo.picbuttons[i] );
ADDRGP4 botSelectInfo
ARGP4
ADDRLP4 16
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 botSelectInfo+1904
ADDP4
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 2814
;2814:		Menu_AddItem( &botSelectInfo.menu,	&botSelectInfo.picnames[i] );
ADDRGP4 botSelectInfo
ARGP4
ADDRLP4 16
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 botSelectInfo+3312
ADDP4
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 2815
;2815:	}
LABELV $2240
line 2811
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 16
LTI4 $2239
line 2816
;2816:	Menu_AddItem( &botSelectInfo.menu, &botSelectInfo.arrows );
ADDRGP4 botSelectInfo
ARGP4
ADDRGP4 botSelectInfo+4464
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 2817
;2817:	Menu_AddItem( &botSelectInfo.menu, &botSelectInfo.left );
ADDRGP4 botSelectInfo
ARGP4
ADDRGP4 botSelectInfo+4552
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 2818
;2818:	Menu_AddItem( &botSelectInfo.menu, &botSelectInfo.right );
ADDRGP4 botSelectInfo
ARGP4
ADDRGP4 botSelectInfo+4640
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 2819
;2819:	Menu_AddItem( &botSelectInfo.menu, &botSelectInfo.back );
ADDRGP4 botSelectInfo
ARGP4
ADDRGP4 botSelectInfo+4816
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 2820
;2820:	Menu_AddItem( &botSelectInfo.menu, &botSelectInfo.go );
ADDRGP4 botSelectInfo
ARGP4
ADDRGP4 botSelectInfo+4728
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 2822
;2821:
;2822:	UI_BotSelectMenu_BuildList();
ADDRGP4 UI_BotSelectMenu_BuildList
CALLV
pop
line 2823
;2823:	UI_BotSelectMenu_Default( bot );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 UI_BotSelectMenu_Default
CALLV
pop
line 2824
;2824:	botSelectInfo.modelpage = botSelectInfo.selectedmodel / MAX_MODELSPERPAGE;
ADDRGP4 botSelectInfo+4908
ADDRGP4 botSelectInfo+4916
INDIRI4
CNSTI4 16
DIVI4
ASGNI4
line 2825
;2825:	UI_BotSelectMenu_UpdateGrid();
ADDRGP4 UI_BotSelectMenu_UpdateGrid
CALLV
pop
line 2826
;2826:}
LABELV $2079
endproc UI_BotSelectMenu_Init 32 12
export UI_BotSelectMenu
proc UI_BotSelectMenu 0 4
line 2834
;2827:
;2828:
;2829:/*
;2830:=================
;2831:UI_BotSelectMenu
;2832:=================
;2833:*/
;2834:void UI_BotSelectMenu( char *bot ) {
line 2835
;2835:	UI_BotSelectMenu_Init( bot );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 UI_BotSelectMenu_Init
CALLV
pop
line 2836
;2836:	UI_PushMenu( &botSelectInfo.menu );
ADDRGP4 botSelectInfo
ARGP4
ADDRGP4 UI_PushMenu
CALLV
pop
line 2837
;2837:}
LABELV $2253
endproc UI_BotSelectMenu 0 4
data
align 4
LABELV hookMode_items
address $2258
address $2259
address $2260
address $2261
address $2262
byte 4 0
code
proc UI_AdvOptGameMenu_SetMenuItems 0 16
line 2977
;2838:
;2839:
;2840:
;2841:/*
;2842:=============================================================================
;2843:
;2844:JUHOX: ADVANCED OPTIONS MENU *****
;2845:
;2846:=============================================================================
;2847:*/
;2848:
;2849:
;2850:#define ADVOPT_BACK0			"menu/art/back_0"
;2851:#define ADVOPT_BACK1			"menu/art/back_1"
;2852:
;2853:#define ADVOPTIONS_X 400
;2854:#define ADVOPTIONS_MAINMENU_SPACING 60
;2855:
;2856:#define ID_ADVOPT_GAME		100
;2857:#define ID_ADVOPT_EQUIPMENT	101
;2858:#define ID_ADVOPT_MONSTERS	102
;2859:
;2860:typedef struct {
;2861:	menuframework_s	menu;
;2862:
;2863:	menutext_s		banner;
;2864:
;2865:	menutext_s		game;
;2866:	menutext_s		equipment;
;2867:#if MONSTER_MODE
;2868:	menutext_s		monsters;
;2869:#endif
;2870:
;2871:#if MONSTER_MODE
;2872:#endif
;2873:
;2874:	menubitmap_s	back;
;2875:} advancedOptionsMainInfo_t;
;2876:
;2877:typedef struct {
;2878:	menuframework_s	menu;
;2879:
;2880:	menutext_s		banner;
;2881:
;2882:	menufield_s			respawnDelay;
;2883:	menuradiobutton_s	respawnAtPOD;
;2884:	menuradiobutton_s	tss;
;2885:	menuradiobutton_s	tssSafetyMode;
;2886:	menuradiobutton_s	stamina;
;2887:	menufield_s			baseHealth;
;2888:	menuradiobutton_s	noItems;
;2889:	menuradiobutton_s	noHealthRegen;
;2890:	menuradiobutton_s	armorFragments;
;2891:#if MONSTER_MODE
;2892:	menuradiobutton_s	skipEndSequence;
;2893:	menuradiobutton_s	scoreMode;
;2894:#endif
;2895:#if ESCAPE_MODE
;2896:	menuradiobutton_s	challengingEnv;
;2897:#endif
;2898:
;2899:	menubitmap_s	back;
;2900:} advancedOptionsGameInfo_t;
;2901:
;2902:typedef struct {
;2903:	menuframework_s	menu;
;2904:
;2905:	menutext_s		banner;
;2906:
;2907:	menuradiobutton_s	cloakingDevice;
;2908:	menufield_s			weaponLimit;
;2909:	menuradiobutton_s	unlimitedAmmo;
;2910:	menulist_s			grapple;
;2911:	menufield_s			lightningDamageLimit;
;2912:#if MONSTER_MODE
;2913:	menuradiobutton_s	monsterLauncher;
;2914:	menufield_s			maxMonstersPP;
;2915:#endif
;2916:
;2917:	menubitmap_s	back;
;2918:} advancedOptionsEquipmentInfo_t;
;2919:
;2920:#if MONSTER_MODE
;2921:typedef struct {
;2922:	menuframework_s	menu;
;2923:
;2924:	menutext_s		banner;
;2925:
;2926:	menufield_s			minMonsters;
;2927:	menufield_s			maxMonsters;
;2928:	menufield_s			monstersPerTrap;
;2929:	menufield_s			monsterSpawnDelay;
;2930:	menufield_s			monsterHealthScale;
;2931:	menufield_s			monsterProgression;
;2932:	menufield_s			monsterGuards;
;2933:	menufield_s			monsterTitans;
;2934:	menuradiobutton_s	monsterBreeding;
;2935:	menutext_s			monsterModel1;
;2936:	menutext_s			monsterModel2;
;2937:	menutext_s			monsterModel3;
;2938:#if ESCAPE_MODE
;2939:	menufield_s			monsterLoad;
;2940:#endif
;2941:
;2942:	menubitmap_s	back;
;2943:} advancedOptionsMonstersInfo_t;
;2944:#endif
;2945:
;2946:static advancedOptionsMainInfo_t		advOptMainInfo;
;2947:static advancedOptionsGameInfo_t		advOptGameInfo;
;2948:static advancedOptionsEquipmentInfo_t	advOptEquipInfo;
;2949:static advancedOptionsMonstersInfo_t	advOptMonInfo;
;2950:
;2951:
;2952:static const char *hookMode_items[] = {
;2953:	"disabled",
;2954:	"classic",
;2955:#if GRAPPLE_ROPE
;2956:	"tool",
;2957:	"anchor",
;2958:	"combat",
;2959:#endif
;2960:	0
;2961:};
;2962:
;2963:
;2964:
;2965:
;2966:/*
;2967:=============================================================================
;2968:JUHOX: ADVANCED OPTIONS MENU ***** GAME
;2969:=============================================================================
;2970:*/
;2971:
;2972:/*
;2973:=================
;2974:JUHOX: UI_AdvOptGameMenu_SetMenuItems
;2975:=================
;2976:*/
;2977:static void UI_AdvOptGameMenu_SetMenuItems(void) {
line 2978
;2978:	Com_sprintf(advOptGameInfo.respawnDelay.field.buffer, 4, "%d", s_serveroptions.respawnDelay);
ADDRGP4 advOptGameInfo+496+60+12
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 $2267
ARGP4
ADDRGP4 s_serveroptions+2564
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 2979
;2979:	advOptGameInfo.respawnAtPOD.curvalue = s_serveroptions.respawnAtPOD;
ADDRGP4 advOptGameInfo+828+60
ADDRGP4 s_serveroptions+2568
INDIRI4
ASGNI4
line 2980
;2980:	advOptGameInfo.tss.curvalue = s_serveroptions.tss;
ADDRGP4 advOptGameInfo+892+60
ADDRGP4 s_serveroptions+2572
INDIRI4
ASGNI4
line 2981
;2981:	advOptGameInfo.tssSafetyMode.curvalue = s_serveroptions.tssSafetyMode;
ADDRGP4 advOptGameInfo+956+60
ADDRGP4 s_serveroptions+2576
INDIRI4
ASGNI4
line 2982
;2982:	advOptGameInfo.stamina.curvalue = s_serveroptions.stamina;
ADDRGP4 advOptGameInfo+1020+60
ADDRGP4 s_serveroptions+2584
INDIRI4
ASGNI4
line 2983
;2983:	Com_sprintf(advOptGameInfo.baseHealth.field.buffer, 5, "%d", s_serveroptions.baseHealth);
ADDRGP4 advOptGameInfo+1084+60+12
ARGP4
CNSTI4 5
ARGI4
ADDRGP4 $2267
ARGP4
ADDRGP4 s_serveroptions+2588
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 2984
;2984:	advOptGameInfo.noItems.curvalue = s_serveroptions.noItems;
ADDRGP4 advOptGameInfo+1416+60
ADDRGP4 s_serveroptions+2600
INDIRI4
ASGNI4
line 2985
;2985:	advOptGameInfo.noHealthRegen.curvalue = s_serveroptions.noHealthRegen;
ADDRGP4 advOptGameInfo+1480+60
ADDRGP4 s_serveroptions+2604
INDIRI4
ASGNI4
line 2986
;2986:	advOptGameInfo.armorFragments.curvalue = s_serveroptions.armorFragments;
ADDRGP4 advOptGameInfo+1544+60
ADDRGP4 s_serveroptions+2580
INDIRI4
ASGNI4
line 2988
;2987:#if MONSTER_MODE
;2988:	advOptGameInfo.skipEndSequence.curvalue = s_serveroptions.skipEndSequence;
ADDRGP4 advOptGameInfo+1608+60
ADDRGP4 s_serveroptions+2760
INDIRI4
ASGNI4
line 2989
;2989:	advOptGameInfo.scoreMode.curvalue = s_serveroptions.scoreMode;
ADDRGP4 advOptGameInfo+1672+60
ADDRGP4 s_serveroptions+2764
INDIRI4
ASGNI4
line 2992
;2990:#endif
;2991:#if ESCAPE_MODE
;2992:	advOptGameInfo.challengingEnv.curvalue = s_serveroptions.challengingEnv;
ADDRGP4 advOptGameInfo+1736+60
ADDRGP4 s_serveroptions+2772
INDIRI4
ASGNI4
line 2994
;2993:#endif
;2994:}
LABELV $2263
endproc UI_AdvOptGameMenu_SetMenuItems 0 16
proc UI_AdvOptGameMenu_BackEvent 16 12
line 3001
;2995:
;2996:/*
;2997:=================
;2998:JUHOX: UI_AdvOptGameMenu_BackEvent
;2999:=================
;3000:*/
;3001:static void UI_AdvOptGameMenu_BackEvent(void* ptr, int event) {
line 3002
;3002:	if (event != QM_ACTIVATED) return;
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $2304
ADDRGP4 $2303
JUMPV
LABELV $2304
line 3004
;3003:
;3004:	s_serveroptions.respawnDelay = (int)Com_Clamp(0, 999, atoi(advOptGameInfo.respawnDelay.field.buffer));
ADDRGP4 advOptGameInfo+496+60+12
ARGP4
ADDRLP4 0
ADDRGP4 atoi
CALLI4
ASGNI4
CNSTF4 0
ARGF4
CNSTF4 1148829696
ARGF4
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 4
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2564
ADDRLP4 4
INDIRF4
CVFI4 4
ASGNI4
line 3005
;3005:	s_serveroptions.respawnAtPOD = advOptGameInfo.respawnAtPOD.curvalue;
ADDRGP4 s_serveroptions+2568
ADDRGP4 advOptGameInfo+828+60
INDIRI4
ASGNI4
line 3006
;3006:	s_serveroptions.tss = advOptGameInfo.tss.curvalue;
ADDRGP4 s_serveroptions+2572
ADDRGP4 advOptGameInfo+892+60
INDIRI4
ASGNI4
line 3007
;3007:	s_serveroptions.tssSafetyMode = advOptGameInfo.tssSafetyMode.curvalue;
ADDRGP4 s_serveroptions+2576
ADDRGP4 advOptGameInfo+956+60
INDIRI4
ASGNI4
line 3008
;3008:	s_serveroptions.stamina = advOptGameInfo.stamina.curvalue;
ADDRGP4 s_serveroptions+2584
ADDRGP4 advOptGameInfo+1020+60
INDIRI4
ASGNI4
line 3009
;3009:	s_serveroptions.baseHealth = (int)Com_Clamp(1, 1000, atoi(advOptGameInfo.baseHealth.field.buffer));
ADDRGP4 advOptGameInfo+1084+60+12
ARGP4
ADDRLP4 8
ADDRGP4 atoi
CALLI4
ASGNI4
CNSTF4 1065353216
ARGF4
CNSTF4 1148846080
ARGF4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2588
ADDRLP4 12
INDIRF4
CVFI4 4
ASGNI4
line 3010
;3010:	s_serveroptions.noItems = advOptGameInfo.noItems.curvalue;
ADDRGP4 s_serveroptions+2600
ADDRGP4 advOptGameInfo+1416+60
INDIRI4
ASGNI4
line 3011
;3011:	s_serveroptions.noHealthRegen = advOptGameInfo.noHealthRegen.curvalue;
ADDRGP4 s_serveroptions+2604
ADDRGP4 advOptGameInfo+1480+60
INDIRI4
ASGNI4
line 3012
;3012:	s_serveroptions.armorFragments = advOptGameInfo.armorFragments.curvalue;
ADDRGP4 s_serveroptions+2580
ADDRGP4 advOptGameInfo+1544+60
INDIRI4
ASGNI4
line 3014
;3013:#if MONSTER_MODE
;3014:	s_serveroptions.skipEndSequence = advOptGameInfo.skipEndSequence.curvalue;
ADDRGP4 s_serveroptions+2760
ADDRGP4 advOptGameInfo+1608+60
INDIRI4
ASGNI4
line 3015
;3015:	s_serveroptions.scoreMode = advOptGameInfo.scoreMode.curvalue;
ADDRGP4 s_serveroptions+2764
ADDRGP4 advOptGameInfo+1672+60
INDIRI4
ASGNI4
line 3018
;3016:#endif
;3017:#if ESCAPE_MODE
;3018:	s_serveroptions.challengingEnv = advOptGameInfo.challengingEnv.curvalue;
ADDRGP4 s_serveroptions+2772
ADDRGP4 advOptGameInfo+1736+60
INDIRI4
ASGNI4
line 3021
;3019:#endif
;3020:
;3021:	UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 3022
;3022:}
LABELV $2303
endproc UI_AdvOptGameMenu_BackEvent 16 12
proc UI_AdvOptGameMenu_RespawnDelayStatusBar 0 20
line 3029
;3023:
;3024:/*
;3025:=================
;3026:JUHOX: UI_AdvOptGameMenu_RespawnDelayStatusBar
;3027:=================
;3028:*/
;3029:static void UI_AdvOptGameMenu_RespawnDelayStatusBar(void* ptr) {
line 3030
;3030:	UI_DrawString(320, 440, "in seconds", UI_CENTER|UI_SMALLFONT, colorWhite);
CNSTI4 320
ARGI4
CNSTI4 440
ARGI4
ADDRGP4 $2345
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 3031
;3031:}
LABELV $2344
endproc UI_AdvOptGameMenu_RespawnDelayStatusBar 0 20
proc UI_AdvOptGameMenu_TSSStatusBar 0 0
line 3039
;3032:
;3033:/*
;3034:=================
;3035:JUHOX: UI_AdvOptGameMenu_TSSStatusBar
;3036:TSS = Tactical Support System
;3037:=================
;3038:*/
;3039:static void UI_AdvOptGameMenu_TSSStatusBar(void* ptr) {
line 3045
;3040:#if !TSSINCVAR
;3041:	if (advOptGameInfo.tss.curvalue) {
;3042:		UI_DrawString(320, 440, "NOTE: TSS only on unpure servers!", UI_CENTER|UI_SMALLFONT, colorWhite);
;3043:	}
;3044:#endif
;3045:}
LABELV $2346
endproc UI_AdvOptGameMenu_TSSStatusBar 0 0
proc UI_AdvOptGameMenu_ChallEnvStatusBar 0 20
line 3053
;3046:
;3047:/*
;3048:=================
;3049:JUHOX: UI_AdvOptGameMenu_ChallEnvStatusBar
;3050:=================
;3051:*/
;3052:#if ESCAPE_MODE
;3053:static void UI_AdvOptGameMenu_ChallEnvStatusBar(void* ptr) {
line 3054
;3054:	UI_DrawString(
CNSTI4 320
ARGI4
CNSTI4 440
ARGI4
ADDRGP4 $2348
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 3058
;3055:		320, 440, "Enable/disable parts that have been marked as \"possibly frustrating\"",
;3056:		UI_CENTER|UI_SMALLFONT, colorWhite
;3057:	);
;3058:}
LABELV $2347
endproc UI_AdvOptGameMenu_ChallEnvStatusBar 0 20
proc UI_AdvOptGameMenu_Init 28 12
line 3066
;3059:#endif
;3060:
;3061:/*
;3062:=================
;3063:JUHOX: UI_AdvOptGameMenu_Init
;3064:=================
;3065:*/
;3066:static void UI_AdvOptGameMenu_Init(void) {
line 3069
;3067:	int y;
;3068:
;3069:	memset(&advOptGameInfo, 0, sizeof(advOptGameInfo));
ADDRGP4 advOptGameInfo
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1888
ARGI4
ADDRGP4 memset
CALLP4
pop
line 3070
;3070:	advOptGameInfo.menu.wrapAround = qtrue;
ADDRGP4 advOptGameInfo+404
CNSTI4 1
ASGNI4
line 3071
;3071:	advOptGameInfo.menu.fullscreen = qtrue;
ADDRGP4 advOptGameInfo+408
CNSTI4 1
ASGNI4
line 3075
;3072:
;3073:	//UI_AdvOptGameMenu_Cache();
;3074:
;3075:	advOptGameInfo.banner.generic.type	= MTYPE_BTEXT;
ADDRGP4 advOptGameInfo+424
CNSTI4 10
ASGNI4
line 3076
;3076:	advOptGameInfo.banner.generic.x		= 320;
ADDRGP4 advOptGameInfo+424+12
CNSTI4 320
ASGNI4
line 3077
;3077:	advOptGameInfo.banner.generic.y		= 16;
ADDRGP4 advOptGameInfo+424+16
CNSTI4 16
ASGNI4
line 3078
;3078:	advOptGameInfo.banner.string		= "ADVANCED OPTIONS";
ADDRGP4 advOptGameInfo+424+60
ADDRGP4 $2359
ASGNP4
line 3079
;3079:	advOptGameInfo.banner.color			= color_white;
ADDRGP4 advOptGameInfo+424+68
ADDRGP4 color_white
ASGNP4
line 3080
;3080:	advOptGameInfo.banner.style			= UI_CENTER;
ADDRGP4 advOptGameInfo+424+64
CNSTI4 1
ASGNI4
line 3081
;3081:	Menu_AddItem(&advOptGameInfo.menu, &advOptGameInfo.banner);
ADDRGP4 advOptGameInfo
ARGP4
ADDRGP4 advOptGameInfo+424
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 3083
;3082:
;3083:	y =	80;
ADDRLP4 0
CNSTI4 80
ASGNI4
line 3085
;3084:
;3085:	advOptGameInfo.baseHealth.generic.type			= MTYPE_FIELD;
ADDRGP4 advOptGameInfo+1084
CNSTI4 4
ASGNI4
line 3086
;3086:	advOptGameInfo.baseHealth.generic.name			= "Base Health:";
ADDRGP4 advOptGameInfo+1084+4
ADDRGP4 $2368
ASGNP4
line 3087
;3087:	advOptGameInfo.baseHealth.generic.flags			= QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 advOptGameInfo+1084+44
CNSTU4 290
ASGNU4
line 3088
;3088:	advOptGameInfo.baseHealth.generic.x				= ADVOPTIONS_X;
ADDRGP4 advOptGameInfo+1084+12
CNSTI4 400
ASGNI4
line 3089
;3089:	advOptGameInfo.baseHealth.generic.y				= y;
ADDRGP4 advOptGameInfo+1084+16
ADDRLP4 0
INDIRI4
ASGNI4
line 3090
;3090:	advOptGameInfo.baseHealth.field.widthInChars	= 5;
ADDRGP4 advOptGameInfo+1084+60+8
CNSTI4 5
ASGNI4
line 3091
;3091:	advOptGameInfo.baseHealth.field.maxchars		= 4;
ADDRGP4 advOptGameInfo+1084+60+268
CNSTI4 4
ASGNI4
line 3092
;3092:	if (gtmpl.tksBasehealth == TKS_fixedValue) advOptGameInfo.baseHealth.generic.flags |= QMF_GRAYED;
ADDRGP4 gtmpl+276
INDIRI4
CNSTI4 2
NEI4 $2381
ADDRLP4 4
ADDRGP4 advOptGameInfo+1084+44
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
LABELV $2381
line 3093
;3093:	Menu_AddItem(&advOptGameInfo.menu, &advOptGameInfo.baseHealth);
ADDRGP4 advOptGameInfo
ARGP4
ADDRGP4 advOptGameInfo+1084
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 3094
;3094:	y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 3097
;3095:
;3096:#if ESCAPE_MODE
;3097:	if (s_serveroptions.gametype == GT_EFH) {
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 9
NEI4 $2387
line 3098
;3098:		advOptGameInfo.challengingEnv.generic.type			= MTYPE_RADIOBUTTON;
ADDRGP4 advOptGameInfo+1736
CNSTI4 5
ASGNI4
line 3099
;3099:		advOptGameInfo.challengingEnv.generic.name			= "Challenging Environment:";
ADDRGP4 advOptGameInfo+1736+4
ADDRGP4 $2393
ASGNP4
line 3100
;3100:		advOptGameInfo.challengingEnv.generic.flags			= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 advOptGameInfo+1736+44
CNSTU4 258
ASGNU4
line 3101
;3101:		advOptGameInfo.challengingEnv.generic.x				= ADVOPTIONS_X;
ADDRGP4 advOptGameInfo+1736+12
CNSTI4 400
ASGNI4
line 3102
;3102:		advOptGameInfo.challengingEnv.generic.y				= y;
ADDRGP4 advOptGameInfo+1736+16
ADDRLP4 0
INDIRI4
ASGNI4
line 3103
;3103:		advOptGameInfo.challengingEnv.generic.statusbar		= UI_AdvOptGameMenu_ChallEnvStatusBar;
ADDRGP4 advOptGameInfo+1736+52
ADDRGP4 UI_AdvOptGameMenu_ChallEnvStatusBar
ASGNP4
line 3104
;3104:		if (gtmpl.tksChallengingEnv == TKS_fixedValue) advOptGameInfo.challengingEnv.generic.flags |= QMF_GRAYED;
ADDRGP4 gtmpl+284
INDIRI4
CNSTI4 2
NEI4 $2402
ADDRLP4 8
ADDRGP4 advOptGameInfo+1736+44
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
LABELV $2402
line 3105
;3105:		Menu_AddItem(&advOptGameInfo.menu, &advOptGameInfo.challengingEnv);
ADDRGP4 advOptGameInfo
ARGP4
ADDRGP4 advOptGameInfo+1736
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 3106
;3106:		y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 3107
;3107:	}
LABELV $2387
line 3111
;3108:#endif
;3109:
;3110:	if (
;3111:		s_serveroptions.gametype != GT_TOURNAMENT
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 1
EQI4 $2408
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 9
EQI4 $2408
line 3115
;3112:#if ESCAPE_MODE
;3113:		&& s_serveroptions.gametype != GT_EFH
;3114:#endif
;3115:	) {
line 3116
;3116:		advOptGameInfo.respawnDelay.generic.type		= MTYPE_FIELD;
ADDRGP4 advOptGameInfo+496
CNSTI4 4
ASGNI4
line 3117
;3117:		advOptGameInfo.respawnDelay.generic.name		= "Respawn Delay:";
ADDRGP4 advOptGameInfo+496+4
ADDRGP4 $2415
ASGNP4
line 3118
;3118:		advOptGameInfo.respawnDelay.generic.flags		= QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 advOptGameInfo+496+44
CNSTU4 290
ASGNU4
line 3119
;3119:		advOptGameInfo.respawnDelay.generic.x			= ADVOPTIONS_X;
ADDRGP4 advOptGameInfo+496+12
CNSTI4 400
ASGNI4
line 3120
;3120:		advOptGameInfo.respawnDelay.generic.y			= y;
ADDRGP4 advOptGameInfo+496+16
ADDRLP4 0
INDIRI4
ASGNI4
line 3121
;3121:		advOptGameInfo.respawnDelay.generic.statusbar	= UI_AdvOptGameMenu_RespawnDelayStatusBar;
ADDRGP4 advOptGameInfo+496+52
ADDRGP4 UI_AdvOptGameMenu_RespawnDelayStatusBar
ASGNP4
line 3122
;3122:		advOptGameInfo.respawnDelay.field.widthInChars	= 4;
ADDRGP4 advOptGameInfo+496+60+8
CNSTI4 4
ASGNI4
line 3123
;3123:		advOptGameInfo.respawnDelay.field.maxchars		= 3;
ADDRGP4 advOptGameInfo+496+60+268
CNSTI4 3
ASGNI4
line 3124
;3124:		if (gtmpl.tksRespawndelay == TKS_fixedValue) advOptGameInfo.respawnDelay.generic.flags |= QMF_GRAYED;
ADDRGP4 gtmpl+268
INDIRI4
CNSTI4 2
NEI4 $2430
ADDRLP4 8
ADDRGP4 advOptGameInfo+496+44
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
LABELV $2430
line 3125
;3125:		Menu_AddItem(&advOptGameInfo.menu, &advOptGameInfo.respawnDelay);
ADDRGP4 advOptGameInfo
ARGP4
ADDRGP4 advOptGameInfo+496
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 3126
;3126:		y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 3127
;3127:	}
LABELV $2408
line 3133
;3128:
;3129:#if !MONSTER_MODE	// JUHOX: no TSS with STU & EFH
;3130:	if (s_serveroptions.gametype >= GT_TEAM) {
;3131:#else
;3132:	if (
;3133:		s_serveroptions.gametype >= GT_TEAM &&
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 3
LTI4 $2436
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 8
GEI4 $2436
line 3135
;3134:		s_serveroptions.gametype < GT_STU
;3135:	) {
line 3137
;3136:#endif
;3137:		advOptGameInfo.tss.generic.type			= MTYPE_RADIOBUTTON;
ADDRGP4 advOptGameInfo+892
CNSTI4 5
ASGNI4
line 3138
;3138:		advOptGameInfo.tss.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 advOptGameInfo+892+44
CNSTU4 258
ASGNU4
line 3139
;3139:		advOptGameInfo.tss.generic.x			= ADVOPTIONS_X;
ADDRGP4 advOptGameInfo+892+12
CNSTI4 400
ASGNI4
line 3140
;3140:		advOptGameInfo.tss.generic.y			= y;
ADDRGP4 advOptGameInfo+892+16
ADDRLP4 0
INDIRI4
ASGNI4
line 3141
;3141:		advOptGameInfo.tss.generic.name			= "Tactical Support System:";
ADDRGP4 advOptGameInfo+892+4
ADDRGP4 $2449
ASGNP4
line 3142
;3142:		advOptGameInfo.tss.generic.statusbar	= UI_AdvOptGameMenu_TSSStatusBar;
ADDRGP4 advOptGameInfo+892+52
ADDRGP4 UI_AdvOptGameMenu_TSSStatusBar
ASGNP4
line 3143
;3143:		if (gtmpl.tksTss == TKS_fixedValue) advOptGameInfo.tss.generic.flags |= QMF_GRAYED;
ADDRGP4 gtmpl+436
INDIRI4
CNSTI4 2
NEI4 $2452
ADDRLP4 8
ADDRGP4 advOptGameInfo+892+44
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
LABELV $2452
line 3144
;3144:		Menu_AddItem(&advOptGameInfo.menu, &advOptGameInfo.tss);
ADDRGP4 advOptGameInfo
ARGP4
ADDRGP4 advOptGameInfo+892
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 3145
;3145:		y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 3147
;3146:
;3147:		advOptGameInfo.tssSafetyMode.generic.type	= MTYPE_RADIOBUTTON;
ADDRGP4 advOptGameInfo+956
CNSTI4 5
ASGNI4
line 3148
;3148:		advOptGameInfo.tssSafetyMode.generic.flags	= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 advOptGameInfo+956+44
CNSTU4 258
ASGNU4
line 3149
;3149:		advOptGameInfo.tssSafetyMode.generic.x		= ADVOPTIONS_X;
ADDRGP4 advOptGameInfo+956+12
CNSTI4 400
ASGNI4
line 3150
;3150:		advOptGameInfo.tssSafetyMode.generic.y		= y;
ADDRGP4 advOptGameInfo+956+16
ADDRLP4 0
INDIRI4
ASGNI4
line 3151
;3151:		advOptGameInfo.tssSafetyMode.generic.name	= "Allow Mission Leader Safety Mode:";
ADDRGP4 advOptGameInfo+956+4
ADDRGP4 $2467
ASGNP4
line 3152
;3152:		if (gtmpl.tksTsssafetymode == TKS_fixedValue) advOptGameInfo.tssSafetyMode.generic.flags |= QMF_GRAYED;
ADDRGP4 gtmpl+444
INDIRI4
CNSTI4 2
NEI4 $2468
ADDRLP4 12
ADDRGP4 advOptGameInfo+956+44
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
LABELV $2468
line 3153
;3153:		Menu_AddItem(&advOptGameInfo.menu, &advOptGameInfo.tssSafetyMode);
ADDRGP4 advOptGameInfo
ARGP4
ADDRGP4 advOptGameInfo+956
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 3154
;3154:		y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 3155
;3155:	}
LABELV $2436
line 3158
;3156:
;3157:#if MONSTER_MODE
;3158:	if (s_serveroptions.gametype >= GT_STU) {
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 8
LTI4 $2474
line 3159
;3159:		advOptGameInfo.scoreMode.generic.type	= MTYPE_RADIOBUTTON;
ADDRGP4 advOptGameInfo+1672
CNSTI4 5
ASGNI4
line 3160
;3160:		advOptGameInfo.scoreMode.generic.name	= "Score Adapts To Monster Constitution:";
ADDRGP4 advOptGameInfo+1672+4
ADDRGP4 $2480
ASGNP4
line 3161
;3161:		advOptGameInfo.scoreMode.generic.flags	= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 advOptGameInfo+1672+44
CNSTU4 258
ASGNU4
line 3162
;3162:		advOptGameInfo.scoreMode.generic.x		= ADVOPTIONS_X;
ADDRGP4 advOptGameInfo+1672+12
CNSTI4 400
ASGNI4
line 3163
;3163:		advOptGameInfo.scoreMode.generic.y		= y;
ADDRGP4 advOptGameInfo+1672+16
ADDRLP4 0
INDIRI4
ASGNI4
line 3164
;3164:		if (gtmpl.tksScoremode == TKS_fixedValue) advOptGameInfo.scoreMode.generic.flags |= QMF_GRAYED;
ADDRGP4 gtmpl+292
INDIRI4
CNSTI4 2
NEI4 $2487
ADDRLP4 8
ADDRGP4 advOptGameInfo+1672+44
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
LABELV $2487
line 3165
;3165:		Menu_AddItem(&advOptGameInfo.menu, &advOptGameInfo.scoreMode);
ADDRGP4 advOptGameInfo
ARGP4
ADDRGP4 advOptGameInfo+1672
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 3166
;3166:		y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 3167
;3167:	}
LABELV $2474
line 3170
;3168:#endif
;3169:
;3170:	advOptGameInfo.stamina.generic.type		= MTYPE_RADIOBUTTON;
ADDRGP4 advOptGameInfo+1020
CNSTI4 5
ASGNI4
line 3171
;3171:	advOptGameInfo.stamina.generic.name		= "Limited Stamina:";
ADDRGP4 advOptGameInfo+1020+4
ADDRGP4 $2496
ASGNP4
line 3172
;3172:	advOptGameInfo.stamina.generic.flags	= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 advOptGameInfo+1020+44
CNSTU4 258
ASGNU4
line 3173
;3173:	advOptGameInfo.stamina.generic.x		= ADVOPTIONS_X;
ADDRGP4 advOptGameInfo+1020+12
CNSTI4 400
ASGNI4
line 3174
;3174:	advOptGameInfo.stamina.generic.y		= y;
ADDRGP4 advOptGameInfo+1020+16
ADDRLP4 0
INDIRI4
ASGNI4
line 3175
;3175:	if (gtmpl.tksStamina == TKS_fixedValue) advOptGameInfo.stamina.generic.flags |= QMF_GRAYED;
ADDRGP4 gtmpl+396
INDIRI4
CNSTI4 2
NEI4 $2503
ADDRLP4 8
ADDRGP4 advOptGameInfo+1020+44
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
LABELV $2503
line 3176
;3176:	Menu_AddItem(&advOptGameInfo.menu, &advOptGameInfo.stamina);
ADDRGP4 advOptGameInfo
ARGP4
ADDRGP4 advOptGameInfo+1020
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 3177
;3177:	y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 3179
;3178:
;3179:	advOptGameInfo.noItems.generic.type		= MTYPE_RADIOBUTTON;
ADDRGP4 advOptGameInfo+1416
CNSTI4 5
ASGNI4
line 3180
;3180:	advOptGameInfo.noItems.generic.name		= "No Items:";
ADDRGP4 advOptGameInfo+1416+4
ADDRGP4 $2512
ASGNP4
line 3181
;3181:	advOptGameInfo.noItems.generic.flags	= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 advOptGameInfo+1416+44
CNSTU4 258
ASGNU4
line 3182
;3182:	advOptGameInfo.noItems.generic.x		= ADVOPTIONS_X;
ADDRGP4 advOptGameInfo+1416+12
CNSTI4 400
ASGNI4
line 3183
;3183:	advOptGameInfo.noItems.generic.y		= y;
ADDRGP4 advOptGameInfo+1416+16
ADDRLP4 0
INDIRI4
ASGNI4
line 3184
;3184:	if (gtmpl.tksNoitems == TKS_fixedValue) advOptGameInfo.noItems.generic.flags |= QMF_GRAYED;
ADDRGP4 gtmpl+404
INDIRI4
CNSTI4 2
NEI4 $2519
ADDRLP4 12
ADDRGP4 advOptGameInfo+1416+44
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
LABELV $2519
line 3185
;3185:	Menu_AddItem(&advOptGameInfo.menu, &advOptGameInfo.noItems);
ADDRGP4 advOptGameInfo
ARGP4
ADDRGP4 advOptGameInfo+1416
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 3186
;3186:	y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 3188
;3187:
;3188:	advOptGameInfo.noHealthRegen.generic.type	= MTYPE_RADIOBUTTON;
ADDRGP4 advOptGameInfo+1480
CNSTI4 5
ASGNI4
line 3189
;3189:	advOptGameInfo.noHealthRegen.generic.name	= "Neither Health Nor Armour Regeneration:";
ADDRGP4 advOptGameInfo+1480+4
ADDRGP4 $2528
ASGNP4
line 3190
;3190:	advOptGameInfo.noHealthRegen.generic.flags	= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 advOptGameInfo+1480+44
CNSTU4 258
ASGNU4
line 3191
;3191:	advOptGameInfo.noHealthRegen.generic.x		= ADVOPTIONS_X;
ADDRGP4 advOptGameInfo+1480+12
CNSTI4 400
ASGNI4
line 3192
;3192:	advOptGameInfo.noHealthRegen.generic.y		= y;
ADDRGP4 advOptGameInfo+1480+16
ADDRLP4 0
INDIRI4
ASGNI4
line 3193
;3193:	if (gtmpl.tksNohealthregen == TKS_fixedValue) advOptGameInfo.noHealthRegen.generic.flags |= QMF_GRAYED;
ADDRGP4 gtmpl+412
INDIRI4
CNSTI4 2
NEI4 $2535
ADDRLP4 16
ADDRGP4 advOptGameInfo+1480+44
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
LABELV $2535
line 3194
;3194:	Menu_AddItem(&advOptGameInfo.menu, &advOptGameInfo.noHealthRegen);
ADDRGP4 advOptGameInfo
ARGP4
ADDRGP4 advOptGameInfo+1480
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 3195
;3195:	y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 3197
;3196:
;3197:	advOptGameInfo.armorFragments.generic.type	= MTYPE_RADIOBUTTON;
ADDRGP4 advOptGameInfo+1544
CNSTI4 5
ASGNI4
line 3198
;3198:	advOptGameInfo.armorFragments.generic.name	= "Generate Armour Fragments:";
ADDRGP4 advOptGameInfo+1544+4
ADDRGP4 $2544
ASGNP4
line 3199
;3199:	advOptGameInfo.armorFragments.generic.flags	= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 advOptGameInfo+1544+44
CNSTU4 258
ASGNU4
line 3200
;3200:	advOptGameInfo.armorFragments.generic.x		= ADVOPTIONS_X;
ADDRGP4 advOptGameInfo+1544+12
CNSTI4 400
ASGNI4
line 3201
;3201:	advOptGameInfo.armorFragments.generic.y		= y;
ADDRGP4 advOptGameInfo+1544+16
ADDRLP4 0
INDIRI4
ASGNI4
line 3202
;3202:	if (gtmpl.tksArmorfragments == TKS_fixedValue) advOptGameInfo.armorFragments.generic.flags |= QMF_GRAYED;
ADDRGP4 gtmpl+460
INDIRI4
CNSTI4 2
NEI4 $2551
ADDRLP4 20
ADDRGP4 advOptGameInfo+1544+44
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
LABELV $2551
line 3203
;3203:	Menu_AddItem(&advOptGameInfo.menu, &advOptGameInfo.armorFragments);
ADDRGP4 advOptGameInfo
ARGP4
ADDRGP4 advOptGameInfo+1544
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 3204
;3204:	y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 3206
;3205:
;3206:	if (s_serveroptions.gametype == GT_CTF) {
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 4
NEI4 $2557
line 3207
;3207:		advOptGameInfo.respawnAtPOD.generic.type	= MTYPE_RADIOBUTTON;
ADDRGP4 advOptGameInfo+828
CNSTI4 5
ASGNI4
line 3208
;3208:		advOptGameInfo.respawnAtPOD.generic.name	= "Allow Respawn At Place Of Death:";
ADDRGP4 advOptGameInfo+828+4
ADDRGP4 $2563
ASGNP4
line 3209
;3209:		advOptGameInfo.respawnAtPOD.generic.flags	= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 advOptGameInfo+828+44
CNSTU4 258
ASGNU4
line 3210
;3210:		advOptGameInfo.respawnAtPOD.generic.x		= ADVOPTIONS_X;
ADDRGP4 advOptGameInfo+828+12
CNSTI4 400
ASGNI4
line 3211
;3211:		advOptGameInfo.respawnAtPOD.generic.y		= y;
ADDRGP4 advOptGameInfo+828+16
ADDRLP4 0
INDIRI4
ASGNI4
line 3212
;3212:		if (gtmpl.tksRespawnatpod == TKS_fixedValue) advOptGameInfo.respawnAtPOD.generic.flags |= QMF_GRAYED;
ADDRGP4 gtmpl+452
INDIRI4
CNSTI4 2
NEI4 $2570
ADDRLP4 24
ADDRGP4 advOptGameInfo+828+44
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
LABELV $2570
line 3213
;3213:		Menu_AddItem(&advOptGameInfo.menu, &advOptGameInfo.respawnAtPOD);
ADDRGP4 advOptGameInfo
ARGP4
ADDRGP4 advOptGameInfo+828
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 3214
;3214:		y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 3215
;3215:	}
LABELV $2557
line 3218
;3216:
;3217:#if MONSTER_MODE
;3218:	if (s_serveroptions.gametype == GT_STU) {
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 8
NEI4 $2576
line 3219
;3219:		advOptGameInfo.skipEndSequence.generic.type		= MTYPE_RADIOBUTTON;
ADDRGP4 advOptGameInfo+1608
CNSTI4 5
ASGNI4
line 3220
;3220:		advOptGameInfo.skipEndSequence.generic.name		= "Skip End Sequence";
ADDRGP4 advOptGameInfo+1608+4
ADDRGP4 $2582
ASGNP4
line 3221
;3221:		advOptGameInfo.skipEndSequence.generic.flags	= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 advOptGameInfo+1608+44
CNSTU4 258
ASGNU4
line 3222
;3222:		advOptGameInfo.skipEndSequence.generic.x		= ADVOPTIONS_X;
ADDRGP4 advOptGameInfo+1608+12
CNSTI4 400
ASGNI4
line 3223
;3223:		advOptGameInfo.skipEndSequence.generic.y		= y;
ADDRGP4 advOptGameInfo+1608+16
ADDRLP4 0
INDIRI4
ASGNI4
line 3224
;3224:		Menu_AddItem(&advOptGameInfo.menu, &advOptGameInfo.skipEndSequence);
ADDRGP4 advOptGameInfo
ARGP4
ADDRGP4 advOptGameInfo+1608
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 3225
;3225:		y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 3226
;3226:	}
LABELV $2576
line 3229
;3227:#endif
;3228:
;3229:	advOptGameInfo.back.generic.type		= MTYPE_BITMAP;
ADDRGP4 advOptGameInfo+1800
CNSTI4 6
ASGNI4
line 3230
;3230:	advOptGameInfo.back.generic.name		= ADVOPT_BACK0;
ADDRGP4 advOptGameInfo+1800+4
ADDRGP4 $421
ASGNP4
line 3231
;3231:	advOptGameInfo.back.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 advOptGameInfo+1800+44
CNSTU4 260
ASGNU4
line 3232
;3232:	advOptGameInfo.back.generic.callback	= UI_AdvOptGameMenu_BackEvent;
ADDRGP4 advOptGameInfo+1800+48
ADDRGP4 UI_AdvOptGameMenu_BackEvent
ASGNP4
line 3233
;3233:	advOptGameInfo.back.generic.x			= 0;
ADDRGP4 advOptGameInfo+1800+12
CNSTI4 0
ASGNI4
line 3234
;3234:	advOptGameInfo.back.generic.y			= 480-64;
ADDRGP4 advOptGameInfo+1800+16
CNSTI4 416
ASGNI4
line 3235
;3235:	advOptGameInfo.back.width				= 128;
ADDRGP4 advOptGameInfo+1800+76
CNSTI4 128
ASGNI4
line 3236
;3236:	advOptGameInfo.back.height				= 64;
ADDRGP4 advOptGameInfo+1800+80
CNSTI4 64
ASGNI4
line 3237
;3237:	advOptGameInfo.back.focuspic			= ADVOPT_BACK1;
ADDRGP4 advOptGameInfo+1800+60
ADDRGP4 $438
ASGNP4
line 3238
;3238:	Menu_AddItem(&advOptGameInfo.menu, &advOptGameInfo.back);
ADDRGP4 advOptGameInfo
ARGP4
ADDRGP4 advOptGameInfo+1800
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 3240
;3239:
;3240:	UI_AdvOptGameMenu_SetMenuItems();
ADDRGP4 UI_AdvOptGameMenu_SetMenuItems
CALLV
pop
line 3241
;3241:}
LABELV $2349
endproc UI_AdvOptGameMenu_Init 28 12
proc UI_AdvOptGameMenu 0 4
line 3248
;3242:
;3243:/*
;3244:=================
;3245:JUHOX: UI_AdvOptGameMenu
;3246:=================
;3247:*/
;3248:static void UI_AdvOptGameMenu(void) {
line 3249
;3249:	UI_AdvOptGameMenu_Init();
ADDRGP4 UI_AdvOptGameMenu_Init
CALLV
pop
line 3250
;3250:	UI_PushMenu(&advOptGameInfo.menu);
ADDRGP4 advOptGameInfo
ARGP4
ADDRGP4 UI_PushMenu
CALLV
pop
line 3251
;3251:}
LABELV $2608
endproc UI_AdvOptGameMenu 0 4
proc UI_AdvOptEquipMenu_SetMenuItems 0 16
line 3272
;3252:
;3253:
;3254:
;3255:
;3256:
;3257:
;3258:
;3259:
;3260:
;3261:/*
;3262:=============================================================================
;3263:JUHOX: ADVANCED OPTIONS MENU ***** EQUIPMENT
;3264:=============================================================================
;3265:*/
;3266:
;3267:/*
;3268:=================
;3269:JUHOX: UI_AdvOptEquipMenu_SetMenuItems
;3270:=================
;3271:*/
;3272:static void UI_AdvOptEquipMenu_SetMenuItems(void) {
line 3273
;3273:	advOptEquipInfo.cloakingDevice.curvalue = s_serveroptions.cloakingDevice;
ADDRGP4 advOptEquipInfo+496+60
ADDRGP4 s_serveroptions+2612
INDIRI4
ASGNI4
line 3274
;3274:	Com_sprintf(advOptEquipInfo.weaponLimit.field.buffer, 5, "%d", s_serveroptions.weaponLimit);
ADDRGP4 advOptEquipInfo+560+60+12
ARGP4
CNSTI4 5
ARGI4
ADDRGP4 $2267
ARGP4
ADDRGP4 s_serveroptions+2616
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 3275
;3275:	advOptEquipInfo.unlimitedAmmo.curvalue = s_serveroptions.unlimitedAmmo;
ADDRGP4 advOptEquipInfo+892+60
ADDRGP4 s_serveroptions+2608
INDIRI4
ASGNI4
line 3276
;3276:	Com_sprintf(advOptEquipInfo.lightningDamageLimit.field.buffer, 5, "%d", s_serveroptions.lightningDamageLimit);
ADDRGP4 advOptEquipInfo+1052+60+12
ARGP4
CNSTI4 5
ARGI4
ADDRGP4 $2267
ARGP4
ADDRGP4 s_serveroptions+2592
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 3277
;3277:	advOptEquipInfo.grapple.curvalue = s_serveroptions.grapple;
ADDRGP4 advOptEquipInfo+956+64
ADDRGP4 s_serveroptions+2596
INDIRI4
ASGNI4
line 3279
;3278:#if MONSTER_MODE
;3279:	advOptEquipInfo.monsterLauncher.curvalue = s_serveroptions.monsterLauncher;
ADDRGP4 advOptEquipInfo+1384+60
ADDRGP4 s_serveroptions+2620
INDIRI4
ASGNI4
line 3280
;3280:	Com_sprintf(advOptEquipInfo.maxMonstersPP.field.buffer, 5, "%d", s_serveroptions.maxMonstersPerPlayer);
ADDRGP4 advOptEquipInfo+1448+60+12
ARGP4
CNSTI4 5
ARGI4
ADDRGP4 $2267
ARGP4
ADDRGP4 s_serveroptions+2632
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 3282
;3281:#endif
;3282:}
LABELV $2609
endproc UI_AdvOptEquipMenu_SetMenuItems 0 16
proc UI_AdvOptEquipMenu_BackEvent 24 12
line 3289
;3283:
;3284:/*
;3285:=================
;3286:JUHOX: UI_AdvOptEquipMenu_BackEvent
;3287:=================
;3288:*/
;3289:static void UI_AdvOptEquipMenu_BackEvent(void* ptr, int event) {
line 3290
;3290:	if (event != QM_ACTIVATED) return;
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $2635
ADDRGP4 $2634
JUMPV
LABELV $2635
line 3292
;3291:
;3292:	s_serveroptions.cloakingDevice = advOptEquipInfo.cloakingDevice.curvalue;
ADDRGP4 s_serveroptions+2612
ADDRGP4 advOptEquipInfo+496+60
INDIRI4
ASGNI4
line 3293
;3293:	s_serveroptions.weaponLimit = (int) Com_Clamp(0, MAX_WEAPONS, atoi(advOptEquipInfo.weaponLimit.field.buffer));
ADDRGP4 advOptEquipInfo+560+60+12
ARGP4
ADDRLP4 0
ADDRGP4 atoi
CALLI4
ASGNI4
CNSTF4 0
ARGF4
CNSTF4 1098907648
ARGF4
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 4
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2616
ADDRLP4 4
INDIRF4
CVFI4 4
ASGNI4
line 3294
;3294:	s_serveroptions.unlimitedAmmo = advOptEquipInfo.unlimitedAmmo.curvalue;
ADDRGP4 s_serveroptions+2608
ADDRGP4 advOptEquipInfo+892+60
INDIRI4
ASGNI4
line 3295
;3295:	s_serveroptions.lightningDamageLimit = (int)Com_Clamp(0, 999, atoi(advOptEquipInfo.lightningDamageLimit.field.buffer));
ADDRGP4 advOptEquipInfo+1052+60+12
ARGP4
ADDRLP4 8
ADDRGP4 atoi
CALLI4
ASGNI4
CNSTF4 0
ARGF4
CNSTF4 1148829696
ARGF4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2592
ADDRLP4 12
INDIRF4
CVFI4 4
ASGNI4
line 3297
;3296:#if GRAPPLE_ROPE
;3297:	s_serveroptions.grapple = advOptEquipInfo.grapple.curvalue;
ADDRGP4 s_serveroptions+2596
ADDRGP4 advOptEquipInfo+956+64
INDIRI4
ASGNI4
line 3300
;3298:#endif
;3299:#if MONSTER_MODE
;3300:	s_serveroptions.monsterLauncher = advOptEquipInfo.monsterLauncher.curvalue;
ADDRGP4 s_serveroptions+2620
ADDRGP4 advOptEquipInfo+1384+60
INDIRI4
ASGNI4
line 3301
;3301:	s_serveroptions.maxMonstersPerPlayer = (int) Com_Clamp(1, MAX_MONSTERS, atoi(advOptEquipInfo.maxMonstersPP.field.buffer));
ADDRGP4 advOptEquipInfo+1448+60+12
ARGP4
ADDRLP4 16
ADDRGP4 atoi
CALLI4
ASGNI4
CNSTF4 1065353216
ARGF4
CNSTF4 1128792064
ARGF4
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 20
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2632
ADDRLP4 20
INDIRF4
CVFI4 4
ASGNI4
line 3304
;3302:#endif
;3303:
;3304:	UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 3305
;3305:}
LABELV $2634
endproc UI_AdvOptEquipMenu_BackEvent 24 12
proc UI_AdvOptEquipMenu_LDLStatusBar 0 20
line 3313
;3306:
;3307:/*
;3308:=================
;3309:JUHOX: UI_AdvOptEquipMenu_LDLStatusBar
;3310:LDL = Lightning gun Damage Limit
;3311:=================
;3312:*/
;3313:static void UI_AdvOptEquipMenu_LDLStatusBar(void* ptr) {
line 3314
;3314:	UI_DrawString(320, 440, "0 = no limit", UI_CENTER|UI_SMALLFONT, colorWhite);
CNSTI4 320
ARGI4
CNSTI4 440
ARGI4
ADDRGP4 $978
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 3315
;3315:}
LABELV $2661
endproc UI_AdvOptEquipMenu_LDLStatusBar 0 20
proc UI_AdvOptEquipMenu_MaxMonPPStatusBar 4 20
line 3323
;3316:
;3317:/*
;3318:=================
;3319:JUHOX: UI_AdvOptEquipMenu_MaxMonPPStatusBar
;3320:=================
;3321:*/
;3322:#if MONSTER_MODE
;3323:static void UI_AdvOptEquipMenu_MaxMonPPStatusBar(void* ptr) {
line 3324
;3324:	UI_DrawString(320, 440, va("1 ... %d", MAX_MONSTERS), UI_CENTER|UI_SMALLFONT, colorWhite);
ADDRGP4 $2663
ARGP4
CNSTI4 200
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 320
ARGI4
CNSTI4 440
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 3325
;3325:	UI_DrawString(320, 460, "limits the capacity of the monster launcher", UI_CENTER|UI_SMALLFONT, colorWhite);
CNSTI4 320
ARGI4
CNSTI4 460
ARGI4
ADDRGP4 $2664
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 3326
;3326:}
LABELV $2662
endproc UI_AdvOptEquipMenu_MaxMonPPStatusBar 4 20
proc UI_AdvOptEquipMenu_MaxWeapStatusBar 0 20
line 3334
;3327:#endif
;3328:
;3329:/*
;3330:=================
;3331:JUHOX: UI_AdvOptEquipMenu_MaxWeapStatusBar
;3332:=================
;3333:*/
;3334:static void UI_AdvOptEquipMenu_MaxWeapStatusBar(void* ptr) {
line 3335
;3335:	UI_DrawString(320, 440, "0 = no limit", UI_CENTER|UI_SMALLFONT, colorWhite);
CNSTI4 320
ARGI4
CNSTI4 440
ARGI4
ADDRGP4 $978
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 3336
;3336:}
LABELV $2665
endproc UI_AdvOptEquipMenu_MaxWeapStatusBar 0 20
proc UI_AdvOptEquipMenu_Init 16 12
line 3343
;3337:
;3338:/*
;3339:=================
;3340:JUHOX: UI_AdvOptEquipMenu_Init
;3341:=================
;3342:*/
;3343:static void UI_AdvOptEquipMenu_Init(void) {
line 3346
;3344:	int y;
;3345:
;3346:	memset(&advOptEquipInfo, 0, sizeof(advOptEquipInfo));
ADDRGP4 advOptEquipInfo
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1868
ARGI4
ADDRGP4 memset
CALLP4
pop
line 3347
;3347:	advOptEquipInfo.menu.wrapAround = qtrue;
ADDRGP4 advOptEquipInfo+404
CNSTI4 1
ASGNI4
line 3348
;3348:	advOptEquipInfo.menu.fullscreen = qtrue;
ADDRGP4 advOptEquipInfo+408
CNSTI4 1
ASGNI4
line 3352
;3349:
;3350:	//UI_AdvOptMenu_Cache();
;3351:
;3352:	advOptEquipInfo.banner.generic.type	= MTYPE_BTEXT;
ADDRGP4 advOptEquipInfo+424
CNSTI4 10
ASGNI4
line 3353
;3353:	advOptEquipInfo.banner.generic.x	= 320;
ADDRGP4 advOptEquipInfo+424+12
CNSTI4 320
ASGNI4
line 3354
;3354:	advOptEquipInfo.banner.generic.y	= 16;
ADDRGP4 advOptEquipInfo+424+16
CNSTI4 16
ASGNI4
line 3355
;3355:	advOptEquipInfo.banner.string		= "ADVANCED OPTIONS";
ADDRGP4 advOptEquipInfo+424+60
ADDRGP4 $2359
ASGNP4
line 3356
;3356:	advOptEquipInfo.banner.color		= color_white;
ADDRGP4 advOptEquipInfo+424+68
ADDRGP4 color_white
ASGNP4
line 3357
;3357:	advOptEquipInfo.banner.style		= UI_CENTER;
ADDRGP4 advOptEquipInfo+424+64
CNSTI4 1
ASGNI4
line 3358
;3358:	Menu_AddItem(&advOptEquipInfo.menu, &advOptEquipInfo.banner);
ADDRGP4 advOptEquipInfo
ARGP4
ADDRGP4 advOptEquipInfo+424
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 3360
;3359:
;3360:	y =	80;
ADDRLP4 0
CNSTI4 80
ASGNI4
line 3362
;3361:
;3362:	advOptEquipInfo.cloakingDevice.generic.type			= MTYPE_RADIOBUTTON;
ADDRGP4 advOptEquipInfo+496
CNSTI4 5
ASGNI4
line 3363
;3363:	advOptEquipInfo.cloakingDevice.generic.name			= "Cloaking Device:";
ADDRGP4 advOptEquipInfo+496+4
ADDRGP4 $2684
ASGNP4
line 3364
;3364:	advOptEquipInfo.cloakingDevice.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 advOptEquipInfo+496+44
CNSTU4 258
ASGNU4
line 3365
;3365:	advOptEquipInfo.cloakingDevice.generic.x			= ADVOPTIONS_X;
ADDRGP4 advOptEquipInfo+496+12
CNSTI4 400
ASGNI4
line 3366
;3366:	advOptEquipInfo.cloakingDevice.generic.y			= y;
ADDRGP4 advOptEquipInfo+496+16
ADDRLP4 0
INDIRI4
ASGNI4
line 3367
;3367:	Menu_AddItem(&advOptEquipInfo.menu, &advOptEquipInfo.cloakingDevice);
ADDRGP4 advOptEquipInfo
ARGP4
ADDRGP4 advOptEquipInfo+496
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 3368
;3368:	if (gtmpl.tksCloakingdevice == TKS_fixedValue) advOptEquipInfo.cloakingDevice.generic.flags |= QMF_GRAYED;
ADDRGP4 gtmpl+420
INDIRI4
CNSTI4 2
NEI4 $2692
ADDRLP4 4
ADDRGP4 advOptEquipInfo+496+44
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
LABELV $2692
line 3369
;3369:	y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 3371
;3370:
;3371:	advOptEquipInfo.weaponLimit.generic.type			= MTYPE_FIELD;
ADDRGP4 advOptEquipInfo+560
CNSTI4 4
ASGNI4
line 3372
;3372:	advOptEquipInfo.weaponLimit.generic.name			= "Max. # of Weapons per Player:";
ADDRGP4 advOptEquipInfo+560+4
ADDRGP4 $2700
ASGNP4
line 3373
;3373:	advOptEquipInfo.weaponLimit.generic.flags			= QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 advOptEquipInfo+560+44
CNSTU4 290
ASGNU4
line 3374
;3374:	advOptEquipInfo.weaponLimit.generic.x				= ADVOPTIONS_X;
ADDRGP4 advOptEquipInfo+560+12
CNSTI4 400
ASGNI4
line 3375
;3375:	advOptEquipInfo.weaponLimit.generic.y				= y;
ADDRGP4 advOptEquipInfo+560+16
ADDRLP4 0
INDIRI4
ASGNI4
line 3376
;3376:	advOptEquipInfo.weaponLimit.field.widthInChars		= 3;
ADDRGP4 advOptEquipInfo+560+60+8
CNSTI4 3
ASGNI4
line 3377
;3377:	advOptEquipInfo.weaponLimit.field.maxchars			= 2;
ADDRGP4 advOptEquipInfo+560+60+268
CNSTI4 2
ASGNI4
line 3378
;3378:	advOptEquipInfo.weaponLimit.generic.statusbar		= UI_AdvOptEquipMenu_MaxWeapStatusBar;
ADDRGP4 advOptEquipInfo+560+52
ADDRGP4 UI_AdvOptEquipMenu_MaxWeapStatusBar
ASGNP4
line 3379
;3379:	Menu_AddItem(&advOptEquipInfo.menu, &advOptEquipInfo.weaponLimit);
ADDRGP4 advOptEquipInfo
ARGP4
ADDRGP4 advOptEquipInfo+560
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 3380
;3380:	y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 3382
;3381:
;3382:	advOptEquipInfo.unlimitedAmmo.generic.type			= MTYPE_RADIOBUTTON;
ADDRGP4 advOptEquipInfo+892
CNSTI4 5
ASGNI4
line 3383
;3383:	advOptEquipInfo.unlimitedAmmo.generic.name			= "Unlimited Ammunition:";
ADDRGP4 advOptEquipInfo+892+4
ADDRGP4 $2719
ASGNP4
line 3384
;3384:	advOptEquipInfo.unlimitedAmmo.generic.flags			= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 advOptEquipInfo+892+44
CNSTU4 258
ASGNU4
line 3385
;3385:	advOptEquipInfo.unlimitedAmmo.generic.x				= ADVOPTIONS_X;
ADDRGP4 advOptEquipInfo+892+12
CNSTI4 400
ASGNI4
line 3386
;3386:	advOptEquipInfo.unlimitedAmmo.generic.y				= y;
ADDRGP4 advOptEquipInfo+892+16
ADDRLP4 0
INDIRI4
ASGNI4
line 3387
;3387:	Menu_AddItem(&advOptEquipInfo.menu, &advOptEquipInfo.unlimitedAmmo);
ADDRGP4 advOptEquipInfo
ARGP4
ADDRGP4 advOptEquipInfo+892
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 3388
;3388:	if (gtmpl.tksUnlimitedammo == TKS_fixedValue) advOptEquipInfo.unlimitedAmmo.generic.flags |= QMF_GRAYED;
ADDRGP4 gtmpl+428
INDIRI4
CNSTI4 2
NEI4 $2727
ADDRLP4 8
ADDRGP4 advOptEquipInfo+892+44
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
LABELV $2727
line 3389
;3389:	y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 3392
;3390:
;3391:#if MONSTER_MODE
;3392:	if (s_serveroptions.gametype < GT_STU) {
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 8
GEI4 $2732
line 3393
;3393:		advOptEquipInfo.monsterLauncher.generic.type	= MTYPE_RADIOBUTTON;
ADDRGP4 advOptEquipInfo+1384
CNSTI4 5
ASGNI4
line 3394
;3394:		advOptEquipInfo.monsterLauncher.generic.flags	= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 advOptEquipInfo+1384+44
CNSTU4 258
ASGNU4
line 3395
;3395:		advOptEquipInfo.monsterLauncher.generic.x		= ADVOPTIONS_X;
ADDRGP4 advOptEquipInfo+1384+12
CNSTI4 400
ASGNI4
line 3396
;3396:		advOptEquipInfo.monsterLauncher.generic.y		= y;
ADDRGP4 advOptEquipInfo+1384+16
ADDRLP4 0
INDIRI4
ASGNI4
line 3397
;3397:		advOptEquipInfo.monsterLauncher.generic.name	= "Monster Launcher:";
ADDRGP4 advOptEquipInfo+1384+4
ADDRGP4 $2744
ASGNP4
line 3398
;3398:		if (gtmpl.tksMonsterlauncher == TKS_fixedValue) advOptEquipInfo.monsterLauncher.generic.flags |= QMF_GRAYED;
ADDRGP4 gtmpl+300
INDIRI4
CNSTI4 2
NEI4 $2745
ADDRLP4 12
ADDRGP4 advOptEquipInfo+1384+44
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
LABELV $2745
line 3399
;3399:		Menu_AddItem(&advOptEquipInfo.menu, &advOptEquipInfo.monsterLauncher);
ADDRGP4 advOptEquipInfo
ARGP4
ADDRGP4 advOptEquipInfo+1384
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 3400
;3400:		y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 3402
;3401:
;3402:		advOptEquipInfo.maxMonstersPP.generic.type			= MTYPE_FIELD;
ADDRGP4 advOptEquipInfo+1448
CNSTI4 4
ASGNI4
line 3403
;3403:		advOptEquipInfo.maxMonstersPP.generic.name			= "Max. # of Monsters per Player:";
ADDRGP4 advOptEquipInfo+1448+4
ADDRGP4 $2754
ASGNP4
line 3404
;3404:		advOptEquipInfo.maxMonstersPP.generic.flags			= QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 advOptEquipInfo+1448+44
CNSTU4 290
ASGNU4
line 3405
;3405:		advOptEquipInfo.maxMonstersPP.generic.x				= ADVOPTIONS_X;
ADDRGP4 advOptEquipInfo+1448+12
CNSTI4 400
ASGNI4
line 3406
;3406:		advOptEquipInfo.maxMonstersPP.generic.y				= y;
ADDRGP4 advOptEquipInfo+1448+16
ADDRLP4 0
INDIRI4
ASGNI4
line 3407
;3407:		advOptEquipInfo.maxMonstersPP.field.widthInChars	= 4;
ADDRGP4 advOptEquipInfo+1448+60+8
CNSTI4 4
ASGNI4
line 3408
;3408:		advOptEquipInfo.maxMonstersPP.field.maxchars		= 3;
ADDRGP4 advOptEquipInfo+1448+60+268
CNSTI4 3
ASGNI4
line 3409
;3409:		advOptEquipInfo.maxMonstersPP.generic.statusbar		= UI_AdvOptEquipMenu_MaxMonPPStatusBar;
ADDRGP4 advOptEquipInfo+1448+52
ADDRGP4 UI_AdvOptEquipMenu_MaxMonPPStatusBar
ASGNP4
line 3410
;3410:		Menu_AddItem(&advOptEquipInfo.menu, &advOptEquipInfo.maxMonstersPP);
ADDRGP4 advOptEquipInfo
ARGP4
ADDRGP4 advOptEquipInfo+1448
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 3411
;3411:		y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 3412
;3412:	}
LABELV $2732
line 3416
;3413:#endif
;3414:
;3415:#if ESCAPE_MODE
;3416:	if (s_serveroptions.gametype != GT_EFH)
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 9
EQI4 $2770
line 3418
;3417:#endif
;3418:	{
line 3419
;3419:		advOptEquipInfo.grapple.generic.type	= MTYPE_SPINCONTROL;
ADDRGP4 advOptEquipInfo+956
CNSTI4 3
ASGNI4
line 3420
;3420:		advOptEquipInfo.grapple.generic.name	= "Grappling Hook Mode:";
ADDRGP4 advOptEquipInfo+956+4
ADDRGP4 $2776
ASGNP4
line 3421
;3421:		advOptEquipInfo.grapple.generic.flags	= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 advOptEquipInfo+956+44
CNSTU4 258
ASGNU4
line 3422
;3422:		advOptEquipInfo.grapple.generic.x		= ADVOPTIONS_X;
ADDRGP4 advOptEquipInfo+956+12
CNSTI4 400
ASGNI4
line 3423
;3423:		advOptEquipInfo.grapple.generic.y		= y;
ADDRGP4 advOptEquipInfo+956+16
ADDRLP4 0
INDIRI4
ASGNI4
line 3424
;3424:		advOptEquipInfo.grapple.itemnames		= hookMode_items;
ADDRGP4 advOptEquipInfo+956+76
ADDRGP4 hookMode_items
ASGNP4
line 3425
;3425:		if (gtmpl.tksGrapple == TKS_fixedValue) advOptEquipInfo.grapple.generic.flags |= QMF_GRAYED;
ADDRGP4 gtmpl+476
INDIRI4
CNSTI4 2
NEI4 $2785
ADDRLP4 12
ADDRGP4 advOptEquipInfo+956+44
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
LABELV $2785
line 3426
;3426:		Menu_AddItem(&advOptEquipInfo.menu, &advOptEquipInfo.grapple);
ADDRGP4 advOptEquipInfo
ARGP4
ADDRGP4 advOptEquipInfo+956
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 3427
;3427:		y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 3428
;3428:	}
LABELV $2770
line 3430
;3429:
;3430:	advOptEquipInfo.lightningDamageLimit.generic.type		= MTYPE_FIELD;
ADDRGP4 advOptEquipInfo+1052
CNSTI4 4
ASGNI4
line 3431
;3431:	advOptEquipInfo.lightningDamageLimit.generic.name		= "Lightning Gun Damage Limit [per Second]:";
ADDRGP4 advOptEquipInfo+1052+4
ADDRGP4 $2794
ASGNP4
line 3432
;3432:	advOptEquipInfo.lightningDamageLimit.generic.flags		= QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 advOptEquipInfo+1052+44
CNSTU4 290
ASGNU4
line 3433
;3433:	advOptEquipInfo.lightningDamageLimit.generic.x			= ADVOPTIONS_X;
ADDRGP4 advOptEquipInfo+1052+12
CNSTI4 400
ASGNI4
line 3434
;3434:	advOptEquipInfo.lightningDamageLimit.generic.y			= y;
ADDRGP4 advOptEquipInfo+1052+16
ADDRLP4 0
INDIRI4
ASGNI4
line 3435
;3435:	advOptEquipInfo.lightningDamageLimit.generic.statusbar	= UI_AdvOptEquipMenu_LDLStatusBar;
ADDRGP4 advOptEquipInfo+1052+52
ADDRGP4 UI_AdvOptEquipMenu_LDLStatusBar
ASGNP4
line 3436
;3436:	advOptEquipInfo.lightningDamageLimit.field.widthInChars	= 4;
ADDRGP4 advOptEquipInfo+1052+60+8
CNSTI4 4
ASGNI4
line 3437
;3437:	advOptEquipInfo.lightningDamageLimit.field.maxchars		= 3;
ADDRGP4 advOptEquipInfo+1052+60+268
CNSTI4 3
ASGNI4
line 3438
;3438:	if (gtmpl.tksLightningdamagelimit == TKS_fixedValue) advOptEquipInfo.lightningDamageLimit.generic.flags |= QMF_GRAYED;
ADDRGP4 gtmpl+468
INDIRI4
CNSTI4 2
NEI4 $2809
ADDRLP4 12
ADDRGP4 advOptEquipInfo+1052+44
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
LABELV $2809
line 3439
;3439:	Menu_AddItem(&advOptEquipInfo.menu, &advOptEquipInfo.lightningDamageLimit);
ADDRGP4 advOptEquipInfo
ARGP4
ADDRGP4 advOptEquipInfo+1052
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 3440
;3440:	y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 3442
;3441:
;3442:	advOptEquipInfo.back.generic.type		= MTYPE_BITMAP;
ADDRGP4 advOptEquipInfo+1780
CNSTI4 6
ASGNI4
line 3443
;3443:	advOptEquipInfo.back.generic.name		= ADVOPT_BACK0;
ADDRGP4 advOptEquipInfo+1780+4
ADDRGP4 $421
ASGNP4
line 3444
;3444:	advOptEquipInfo.back.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 advOptEquipInfo+1780+44
CNSTU4 260
ASGNU4
line 3445
;3445:	advOptEquipInfo.back.generic.callback	= UI_AdvOptEquipMenu_BackEvent;
ADDRGP4 advOptEquipInfo+1780+48
ADDRGP4 UI_AdvOptEquipMenu_BackEvent
ASGNP4
line 3446
;3446:	advOptEquipInfo.back.generic.x			= 0;
ADDRGP4 advOptEquipInfo+1780+12
CNSTI4 0
ASGNI4
line 3447
;3447:	advOptEquipInfo.back.generic.y			= 480-64;
ADDRGP4 advOptEquipInfo+1780+16
CNSTI4 416
ASGNI4
line 3448
;3448:	advOptEquipInfo.back.width				= 128;
ADDRGP4 advOptEquipInfo+1780+76
CNSTI4 128
ASGNI4
line 3449
;3449:	advOptEquipInfo.back.height				= 64;
ADDRGP4 advOptEquipInfo+1780+80
CNSTI4 64
ASGNI4
line 3450
;3450:	advOptEquipInfo.back.focuspic			= ADVOPT_BACK1;
ADDRGP4 advOptEquipInfo+1780+60
ADDRGP4 $438
ASGNP4
line 3451
;3451:	Menu_AddItem(&advOptEquipInfo.menu, &advOptEquipInfo.back);
ADDRGP4 advOptEquipInfo
ARGP4
ADDRGP4 advOptEquipInfo+1780
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 3453
;3452:
;3453:	UI_AdvOptEquipMenu_SetMenuItems();
ADDRGP4 UI_AdvOptEquipMenu_SetMenuItems
CALLV
pop
line 3454
;3454:}
LABELV $2666
endproc UI_AdvOptEquipMenu_Init 16 12
proc UI_AdvOptEquipMenu 0 4
line 3461
;3455:
;3456:/*
;3457:=================
;3458:JUHOX: UI_AdvOptEquipMenu
;3459:=================
;3460:*/
;3461:static void UI_AdvOptEquipMenu(void) {
line 3462
;3462:	UI_AdvOptEquipMenu_Init();
ADDRGP4 UI_AdvOptEquipMenu_Init
CALLV
pop
line 3463
;3463:	UI_PushMenu(&advOptEquipInfo.menu);
ADDRGP4 advOptEquipInfo
ARGP4
ADDRGP4 UI_PushMenu
CALLV
pop
line 3464
;3464:}
LABELV $2833
endproc UI_AdvOptEquipMenu 0 4
proc UI_AdvOptMonMenu_SetMenuItems 0 16
line 3485
;3465:
;3466:
;3467:
;3468:
;3469:
;3470:
;3471:
;3472:
;3473:/*
;3474:=============================================================================
;3475:JUHOX: ADVANCED OPTIONS MENU ***** MONSTERS
;3476:=============================================================================
;3477:*/
;3478:
;3479:/*
;3480:=================
;3481:JUHOX: UI_AdvOptMonMenu_SetMenuItems
;3482:=================
;3483:*/
;3484:#if MONSTER_MODE
;3485:static void UI_AdvOptMonMenu_SetMenuItems(void) {
line 3486
;3486:	Com_sprintf(advOptMonInfo.minMonsters.field.buffer, 5, "%d", s_serveroptions.minMonsters);
ADDRGP4 advOptMonInfo+496+60+12
ARGP4
CNSTI4 5
ARGI4
ADDRGP4 $2267
ARGP4
ADDRGP4 s_serveroptions+2624
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 3487
;3487:	Com_sprintf(advOptMonInfo.maxMonsters.field.buffer, 5, "%d", s_serveroptions.maxMonsters);
ADDRGP4 advOptMonInfo+828+60+12
ARGP4
CNSTI4 5
ARGI4
ADDRGP4 $2267
ARGP4
ADDRGP4 s_serveroptions+2628
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 3488
;3488:	Com_sprintf(advOptMonInfo.monstersPerTrap.field.buffer, 5, "%d", s_serveroptions.monstersPerTrap);
ADDRGP4 advOptMonInfo+1160+60+12
ARGP4
CNSTI4 5
ARGI4
ADDRGP4 $2267
ARGP4
ADDRGP4 s_serveroptions+2636
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 3489
;3489:	Com_sprintf(advOptMonInfo.monsterSpawnDelay.field.buffer, 8, "%.3f", s_serveroptions.monsterSpawnDelay / 1000.0);
ADDRGP4 advOptMonInfo+1492+60+12
ARGP4
CNSTI4 8
ARGI4
ADDRGP4 $2850
ARGP4
ADDRGP4 s_serveroptions+2640
INDIRI4
CVIF4 4
CNSTF4 981668463
MULF4
ARGF4
ADDRGP4 Com_sprintf
CALLV
pop
line 3490
;3490:	Com_sprintf(advOptMonInfo.monsterGuards.field.buffer, 5, "%d", s_serveroptions.monsterGuards);
ADDRGP4 advOptMonInfo+2488+60+12
ARGP4
CNSTI4 5
ARGI4
ADDRGP4 $2267
ARGP4
ADDRGP4 s_serveroptions+2644
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 3491
;3491:	Com_sprintf(advOptMonInfo.monsterTitans.field.buffer, 5, "%d", s_serveroptions.monsterTitans);
ADDRGP4 advOptMonInfo+2820+60+12
ARGP4
CNSTI4 5
ARGI4
ADDRGP4 $2267
ARGP4
ADDRGP4 s_serveroptions+2648
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 3492
;3492:	Com_sprintf(advOptMonInfo.monsterHealthScale.field.buffer, 5, "%d", s_serveroptions.monsterHealthScale);
ADDRGP4 advOptMonInfo+1824+60+12
ARGP4
CNSTI4 5
ARGI4
ADDRGP4 $2267
ARGP4
ADDRGP4 s_serveroptions+2652
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 3493
;3493:	Com_sprintf(advOptMonInfo.monsterProgression.field.buffer, 5, "%d", s_serveroptions.monsterProgression);
ADDRGP4 advOptMonInfo+2156+60+12
ARGP4
CNSTI4 5
ARGI4
ADDRGP4 $2267
ARGP4
ADDRGP4 s_serveroptions+2656
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 3494
;3494:	advOptMonInfo.monsterBreeding.curvalue = s_serveroptions.monsterBreeding;
ADDRGP4 advOptMonInfo+3152+60
ADDRGP4 s_serveroptions+2660
INDIRI4
ASGNI4
line 3496
;3495:#if ESCAPE_MODE
;3496:	Com_sprintf(advOptMonInfo.monsterLoad.field.buffer, 5, "%d", s_serveroptions.monsterLoad);
ADDRGP4 advOptMonInfo+3432+60+12
ARGP4
CNSTI4 5
ARGI4
ADDRGP4 $2267
ARGP4
ADDRGP4 s_serveroptions+2768
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 3498
;3497:#endif
;3498:}
LABELV $2834
endproc UI_AdvOptMonMenu_SetMenuItems 0 16
proc UI_AdvOptMonMenu_BackEvent 72 12
line 3507
;3499:#endif
;3500:
;3501:/*
;3502:=================
;3503:JUHOX: UI_AdvOptMonMenu_BackEvent
;3504:=================
;3505:*/
;3506:#if MONSTER_MODE
;3507:static void UI_AdvOptMonMenu_BackEvent(void* ptr, int event) {
line 3508
;3508:	if (event != QM_ACTIVATED) return;
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $2876
ADDRGP4 $2875
JUMPV
LABELV $2876
line 3510
;3509:
;3510:	s_serveroptions.minMonsters = (int) Com_Clamp(0, MAX_MONSTERS, atoi(advOptMonInfo.minMonsters.field.buffer));
ADDRGP4 advOptMonInfo+496+60+12
ARGP4
ADDRLP4 0
ADDRGP4 atoi
CALLI4
ASGNI4
CNSTF4 0
ARGF4
CNSTF4 1128792064
ARGF4
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 4
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2624
ADDRLP4 4
INDIRF4
CVFI4 4
ASGNI4
line 3511
;3511:	s_serveroptions.maxMonsters = (int) Com_Clamp(1, MAX_MONSTERS, atoi(advOptMonInfo.maxMonsters.field.buffer));
ADDRGP4 advOptMonInfo+828+60+12
ARGP4
ADDRLP4 8
ADDRGP4 atoi
CALLI4
ASGNI4
CNSTF4 1065353216
ARGF4
CNSTF4 1128792064
ARGF4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2628
ADDRLP4 12
INDIRF4
CVFI4 4
ASGNI4
line 3512
;3512:	s_serveroptions.monstersPerTrap = (int) Com_Clamp(0, MAX_MONSTERS, atoi(advOptMonInfo.monstersPerTrap.field.buffer));
ADDRGP4 advOptMonInfo+1160+60+12
ARGP4
ADDRLP4 16
ADDRGP4 atoi
CALLI4
ASGNI4
CNSTF4 0
ARGF4
CNSTF4 1128792064
ARGF4
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 20
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2636
ADDRLP4 20
INDIRF4
CVFI4 4
ASGNI4
line 3513
;3513:	s_serveroptions.monsterSpawnDelay = (int) Com_Clamp(200, 999999, 1000 * atof(advOptMonInfo.monsterSpawnDelay.field.buffer));
ADDRGP4 advOptMonInfo+1492+60+12
ARGP4
ADDRLP4 24
ADDRGP4 atof
CALLF4
ASGNF4
CNSTF4 1128792064
ARGF4
CNSTF4 1232348144
ARGF4
ADDRLP4 24
INDIRF4
CNSTF4 1148846080
MULF4
ARGF4
ADDRLP4 28
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2640
ADDRLP4 28
INDIRF4
CVFI4 4
ASGNI4
line 3514
;3514:	s_serveroptions.monsterGuards = (int) Com_Clamp(0, 100, atoi(advOptMonInfo.monsterGuards.field.buffer));
ADDRGP4 advOptMonInfo+2488+60+12
ARGP4
ADDRLP4 32
ADDRGP4 atoi
CALLI4
ASGNI4
CNSTF4 0
ARGF4
CNSTF4 1120403456
ARGF4
ADDRLP4 32
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 36
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2644
ADDRLP4 36
INDIRF4
CVFI4 4
ASGNI4
line 3515
;3515:	s_serveroptions.monsterTitans = (int) Com_Clamp(0, 100, atoi(advOptMonInfo.monsterTitans.field.buffer));
ADDRGP4 advOptMonInfo+2820+60+12
ARGP4
ADDRLP4 40
ADDRGP4 atoi
CALLI4
ASGNI4
CNSTF4 0
ARGF4
CNSTF4 1120403456
ARGF4
ADDRLP4 40
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 44
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2648
ADDRLP4 44
INDIRF4
CVFI4 4
ASGNI4
line 3516
;3516:	s_serveroptions.monsterHealthScale = (int) Com_Clamp(1, 1000, atoi(advOptMonInfo.monsterHealthScale.field.buffer));
ADDRGP4 advOptMonInfo+1824+60+12
ARGP4
ADDRLP4 48
ADDRGP4 atoi
CALLI4
ASGNI4
CNSTF4 1065353216
ARGF4
CNSTF4 1148846080
ARGF4
ADDRLP4 48
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 52
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2652
ADDRLP4 52
INDIRF4
CVFI4 4
ASGNI4
line 3517
;3517:	s_serveroptions.monsterProgression = (int) Com_Clamp(0, 1000, atoi(advOptMonInfo.monsterProgression.field.buffer));
ADDRGP4 advOptMonInfo+2156+60+12
ARGP4
ADDRLP4 56
ADDRGP4 atoi
CALLI4
ASGNI4
CNSTF4 0
ARGF4
CNSTF4 1148846080
ARGF4
ADDRLP4 56
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 60
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2656
ADDRLP4 60
INDIRF4
CVFI4 4
ASGNI4
line 3518
;3518:	s_serveroptions.monsterBreeding = advOptMonInfo.monsterBreeding.curvalue;
ADDRGP4 s_serveroptions+2660
ADDRGP4 advOptMonInfo+3152+60
INDIRI4
ASGNI4
line 3520
;3519:#if ESCAPE_MODE
;3520:	s_serveroptions.monsterLoad = (int) Com_Clamp(0, 1000, atoi(advOptMonInfo.monsterLoad.field.buffer));
ADDRGP4 advOptMonInfo+3432+60+12
ARGP4
ADDRLP4 64
ADDRGP4 atoi
CALLI4
ASGNI4
CNSTF4 0
ARGF4
CNSTF4 1148846080
ARGF4
ADDRLP4 64
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 68
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2768
ADDRLP4 68
INDIRF4
CVFI4 4
ASGNI4
line 3523
;3521:#endif
;3522:
;3523:	UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 3524
;3524:}
LABELV $2875
endproc UI_AdvOptMonMenu_BackEvent 72 12
proc UI_AdvOptMonMenu_MonsterModel_Draw 36 20
line 3535
;3525:#endif
;3526:
;3527:/*
;3528:=================
;3529:JUHOX: UI_AdvOptMonMenu_MonsterModel_Draw
;3530:
;3531:derived from PlayerName_Draw()
;3532:=================
;3533:*/
;3534:#if MONSTER_MODE
;3535:static void UI_AdvOptMonMenu_MonsterModel_Draw(void* item) {
line 3542
;3536:	menutext_s* s;
;3537:	float* color;
;3538:	int x, y;
;3539:	int style;
;3540:	qboolean focus;
;3541:
;3542:	s = (menutext_s*) item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 3544
;3543:
;3544:	x = s->generic.x;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 3545
;3545:	y =	s->generic.y;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 3547
;3546:
;3547:	style = UI_SMALLFONT;
ADDRLP4 16
CNSTI4 16
ASGNI4
line 3548
;3548:	focus = (s->generic.parent->cursor == s->generic.menuPosition);
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
NEI4 $2919
ADDRLP4 24
CNSTI4 1
ASGNI4
ADDRGP4 $2920
JUMPV
LABELV $2919
ADDRLP4 24
CNSTI4 0
ASGNI4
LABELV $2920
ADDRLP4 20
ADDRLP4 24
INDIRI4
ASGNI4
line 3550
;3549:
;3550:	if (s->generic.flags & QMF_GRAYED)
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 8192
BANDU4
CNSTU4 0
EQU4 $2921
line 3551
;3551:	{
line 3552
;3552:		color = text_color_disabled;
ADDRLP4 4
ADDRGP4 text_color_disabled
ASGNP4
line 3553
;3553:	}
ADDRGP4 $2922
JUMPV
LABELV $2921
line 3554
;3554:	else if (focus)
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $2923
line 3555
;3555:	{
line 3556
;3556:		color = text_color_highlight;
ADDRLP4 4
ADDRGP4 text_color_highlight
ASGNP4
line 3557
;3557:		style |= UI_PULSE;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
line 3558
;3558:	}
ADDRGP4 $2924
JUMPV
LABELV $2923
line 3559
;3559:	else if (s->generic.flags & QMF_BLINK)
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 1
BANDU4
CNSTU4 0
EQU4 $2925
line 3560
;3560:	{
line 3561
;3561:		color = text_color_highlight;
ADDRLP4 4
ADDRGP4 text_color_highlight
ASGNP4
line 3562
;3562:		style |= UI_BLINK;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 4096
BORI4
ASGNI4
line 3563
;3563:	}
ADDRGP4 $2926
JUMPV
LABELV $2925
line 3565
;3564:	else
;3565:	{
line 3566
;3566:		color = text_color_normal;
ADDRLP4 4
ADDRGP4 text_color_normal
ASGNP4
line 3567
;3567:	}
LABELV $2926
LABELV $2924
LABELV $2922
line 3569
;3568:
;3569:	if (focus)
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $2927
line 3570
;3570:	{
line 3572
;3571:		// draw cursor
;3572:		UI_FillRect(s->generic.left, s->generic.top, s->generic.right-s->generic.left+1, s->generic.bottom-s->generic.top+1, listbar_color); 
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
SUBI4
CNSTI4 1
ADDI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
SUBI4
CNSTI4 1
ADDI4
CVIF4 4
ARGF4
ADDRGP4 listbar_color
ARGP4
ADDRGP4 UI_FillRect
CALLV
pop
line 3573
;3573:		UI_DrawChar(x, y, 13, UI_CENTER|UI_BLINK|UI_SMALLFONT, color);
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
CNSTI4 13
ARGI4
CNSTI4 4113
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 UI_DrawChar
CALLV
pop
line 3574
;3574:	}
LABELV $2927
line 3576
;3575:
;3576:	UI_DrawString(x - SMALLCHAR_WIDTH, y, s->generic.name, style|UI_RIGHT, color);
ADDRLP4 8
INDIRI4
CNSTI4 8
SUBI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
INDIRI4
CNSTI4 2
BORI4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 3577
;3577:	UI_DrawString(x + SMALLCHAR_WIDTH, y, s->string, style|UI_LEFT, color);
ADDRLP4 8
INDIRI4
CNSTI4 8
ADDI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 3578
;3578:}
LABELV $2917
endproc UI_AdvOptMonMenu_MonsterModel_Draw 36 20
proc UI_AdvOptMonMenu_PredatorModel_Callback 0 36
line 3587
;3579:#endif
;3580:
;3581:/*
;3582:=================
;3583:JUHOX: UI_AdvOptMonMenu_PredatorModel_Callback
;3584:=================
;3585:*/
;3586:#if MONSTER_MODE
;3587:static void UI_AdvOptMonMenu_PredatorModel_Callback(void* ptr, int event) {
line 3588
;3588:	if (event != QM_ACTIVATED) return;
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $2930
ADDRGP4 $2929
JUMPV
LABELV $2930
line 3590
;3589:
;3590:	UI_PlayerModelMenu(
ADDRGP4 $2932
ARGP4
ADDRGP4 $99
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 s_serveroptions+2664
ARGP4
CNSTI4 32
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 UI_PlayerModelMenu
CALLV
pop
line 3596
;3591:		"PREDATOR MODEL", "",
;3592:		NULL, NULL, NULL, NULL,
;3593:		s_serveroptions.monsterModel1, sizeof(s_serveroptions.monsterModel1),
;3594:		WP_NONE
;3595:	);
;3596:}
LABELV $2929
endproc UI_AdvOptMonMenu_PredatorModel_Callback 0 36
proc UI_AdvOptMonMenu_GuardModel_Callback 0 36
line 3605
;3597:#endif
;3598:
;3599:/*
;3600:=================
;3601:JUHOX: UI_AdvOptMonMenu_GuardModel_Callback
;3602:=================
;3603:*/
;3604:#if MONSTER_MODE
;3605:static void UI_AdvOptMonMenu_GuardModel_Callback(void* ptr, int event) {
line 3606
;3606:	if (event != QM_ACTIVATED) return;
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $2936
ADDRGP4 $2935
JUMPV
LABELV $2936
line 3608
;3607:
;3608:	UI_PlayerModelMenu(
ADDRGP4 $2938
ARGP4
ADDRGP4 $99
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 s_serveroptions+2696
ARGP4
CNSTI4 32
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 UI_PlayerModelMenu
CALLV
pop
line 3614
;3609:		"GUARD MODEL", "",
;3610:		NULL, NULL, NULL, NULL,
;3611:		s_serveroptions.monsterModel2, sizeof(s_serveroptions.monsterModel2),
;3612:		WP_ROCKET_LAUNCHER
;3613:	);
;3614:}
LABELV $2935
endproc UI_AdvOptMonMenu_GuardModel_Callback 0 36
proc UI_AdvOptMonMenu_TitansModel_Callback 0 36
line 3623
;3615:#endif
;3616:
;3617:/*
;3618:=================
;3619:JUHOX: UI_AdvOptMonMenu_TitansModel_Callback
;3620:=================
;3621:*/
;3622:#if MONSTER_MODE
;3623:static void UI_AdvOptMonMenu_TitansModel_Callback(void* ptr, int event) {
line 3624
;3624:	if (event != QM_ACTIVATED) return;
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $2942
ADDRGP4 $2941
JUMPV
LABELV $2942
line 3626
;3625:
;3626:	UI_PlayerModelMenu(
ADDRGP4 $2944
ARGP4
ADDRGP4 $99
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 s_serveroptions+2728
ARGP4
CNSTI4 32
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 UI_PlayerModelMenu
CALLV
pop
line 3632
;3627:		"TITANS MODEL", "",
;3628:		NULL, NULL, NULL, NULL,
;3629:		s_serveroptions.monsterModel3, sizeof(s_serveroptions.monsterModel3),
;3630:		WP_NONE
;3631:	);
;3632:}
LABELV $2941
endproc UI_AdvOptMonMenu_TitansModel_Callback 0 36
proc UI_AdvOptMonMenu_MinMonStatusBar 4 20
line 3641
;3633:#endif
;3634:
;3635:/*
;3636:=================
;3637:JUHOX: UI_AdvOptMonMenu_MinMonStatusBar
;3638:=================
;3639:*/
;3640:#if MONSTER_MODE
;3641:static void UI_AdvOptMonMenu_MinMonStatusBar(void* ptr) {
line 3642
;3642:	UI_DrawString(320, 440, va("0 ... %d", MAX_MONSTERS), UI_CENTER|UI_SMALLFONT, colorWhite);
ADDRGP4 $2948
ARGP4
CNSTI4 200
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 320
ARGI4
CNSTI4 440
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 3643
;3643:}
LABELV $2947
endproc UI_AdvOptMonMenu_MinMonStatusBar 4 20
proc UI_AdvOptMonMenu_MaxMonStatusBar 4 20
line 3652
;3644:#endif
;3645:
;3646:/*
;3647:=================
;3648:JUHOX: UI_AdvOptMonMenu_MaxMonStatusBar
;3649:=================
;3650:*/
;3651:#if MONSTER_MODE
;3652:static void UI_AdvOptMonMenu_MaxMonStatusBar(void* ptr) {
line 3653
;3653:	UI_DrawString(320, 440, va("1 ... %d", MAX_MONSTERS), UI_CENTER|UI_SMALLFONT, colorWhite);
ADDRGP4 $2663
ARGP4
CNSTI4 200
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 320
ARGI4
CNSTI4 440
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 3654
;3654:	if (s_serveroptions.gametype < GT_STU) {
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 8
GEI4 $2950
line 3655
;3655:		UI_DrawString(320, 460, "all players get an equal share of this", UI_CENTER|UI_SMALLFONT, colorWhite);
CNSTI4 320
ARGI4
CNSTI4 460
ARGI4
ADDRGP4 $2953
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 3656
;3656:	}
LABELV $2950
line 3657
;3657:}
LABELV $2949
endproc UI_AdvOptMonMenu_MaxMonStatusBar 4 20
proc UI_AdvOptMonMenu_MonLoadStatusBar 0 20
line 3666
;3658:#endif
;3659:
;3660:/*
;3661:=================
;3662:JUHOX: UI_AdvOptMonMenu_MonLoadStatusBar
;3663:=================
;3664:*/
;3665:#if ESCAPE_MODE
;3666:static void UI_AdvOptMonMenu_MonLoadStatusBar(void* ptr) {
line 3667
;3667:	UI_DrawString(320, 440, "0% ... 1000%", UI_CENTER|UI_SMALLFONT, colorWhite);
CNSTI4 320
ARGI4
CNSTI4 440
ARGI4
ADDRGP4 $2955
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 3668
;3668:}
LABELV $2954
endproc UI_AdvOptMonMenu_MonLoadStatusBar 0 20
proc UI_AdvOptMonMenu_MSDStatusBar 0 20
line 3678
;3669:#endif
;3670:
;3671:/*
;3672:=================
;3673:JUHOX: UI_AdvOptMonMenu_MSDStatusBar
;3674:MSD = Monster Spawn Delay
;3675:=================
;3676:*/
;3677:#if MONSTER_MODE
;3678:static void UI_AdvOptMonMenu_MSDStatusBar(void* ptr) {
line 3679
;3679:	UI_DrawString(320, 440, "0.2 ... 999 seconds", UI_CENTER|UI_SMALLFONT, colorWhite);
CNSTI4 320
ARGI4
CNSTI4 440
ARGI4
ADDRGP4 $2957
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 3680
;3680:}
LABELV $2956
endproc UI_AdvOptMonMenu_MSDStatusBar 0 20
proc UI_AdvOptMonMenu_GuardsStatusBar 0 20
line 3689
;3681:#endif
;3682:
;3683:/*
;3684:=================
;3685:JUHOX: UI_AdvOptMonMenu_GuardsStatusBar
;3686:=================
;3687:*/
;3688:#if MONSTER_MODE
;3689:static void UI_AdvOptMonMenu_GuardsStatusBar(void* ptr) {
line 3690
;3690:	UI_DrawString(320, 440, "0 ... 100%", UI_CENTER|UI_SMALLFONT, colorWhite);
CNSTI4 320
ARGI4
CNSTI4 440
ARGI4
ADDRGP4 $2959
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 3691
;3691:}
LABELV $2958
endproc UI_AdvOptMonMenu_GuardsStatusBar 0 20
proc UI_AdvOptMonMenu_MonHealthStatusBar 0 20
line 3700
;3692:#endif
;3693:
;3694:/*
;3695:=================
;3696:JUHOX: UI_AdvOptMonMenu_MonHealthStatusBar
;3697:=================
;3698:*/
;3699:#if MONSTER_MODE
;3700:static void UI_AdvOptMonMenu_MonHealthStatusBar(void* ptr) {
line 3701
;3701:	UI_DrawString(320, 440, "1% ... 1000% (\"very easy\" ... \"very hard\")", UI_CENTER|UI_SMALLFONT, colorWhite);
CNSTI4 320
ARGI4
CNSTI4 440
ARGI4
ADDRGP4 $2961
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 3702
;3702:}
LABELV $2960
endproc UI_AdvOptMonMenu_MonHealthStatusBar 0 20
proc UI_AdvOptMonMenu_MonProgStatusBar 0 20
line 3711
;3703:#endif
;3704:
;3705:/*
;3706:=================
;3707:JUHOX: UI_AdvOptMonMenu_MonProgStatusBar
;3708:=================
;3709:*/
;3710:#if MONSTER_MODE
;3711:static void UI_AdvOptMonMenu_MonProgStatusBar(void* ptr) {
line 3712
;3712:	UI_DrawString(320, 440, "0 ... 1000 (\"very easy\" ... \"very hard\")", UI_CENTER|UI_SMALLFONT, colorWhite);
CNSTI4 320
ARGI4
CNSTI4 440
ARGI4
ADDRGP4 $2963
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 3713
;3713:}
LABELV $2962
endproc UI_AdvOptMonMenu_MonProgStatusBar 0 20
proc UI_AdvOptMonMenu_Init 40 12
line 3722
;3714:#endif
;3715:
;3716:/*
;3717:=================
;3718:JUHOX: UI_AdvOptMonMenu_Init
;3719:=================
;3720:*/
;3721:#if MONSTER_MODE
;3722:static void UI_AdvOptMonMenu_Init(void) {
line 3725
;3723:	int y;
;3724:
;3725:	memset(&advOptMonInfo, 0, sizeof(advOptMonInfo));
ADDRGP4 advOptMonInfo
ARGP4
CNSTI4 0
ARGI4
CNSTI4 3852
ARGI4
ADDRGP4 memset
CALLP4
pop
line 3726
;3726:	advOptMonInfo.menu.wrapAround = qtrue;
ADDRGP4 advOptMonInfo+404
CNSTI4 1
ASGNI4
line 3727
;3727:	advOptMonInfo.menu.fullscreen = qtrue;
ADDRGP4 advOptMonInfo+408
CNSTI4 1
ASGNI4
line 3731
;3728:
;3729:	//UI_AdvOptMenu_Cache();
;3730:
;3731:	advOptMonInfo.banner.generic.type	= MTYPE_BTEXT;
ADDRGP4 advOptMonInfo+424
CNSTI4 10
ASGNI4
line 3732
;3732:	advOptMonInfo.banner.generic.x		= 320;
ADDRGP4 advOptMonInfo+424+12
CNSTI4 320
ASGNI4
line 3733
;3733:	advOptMonInfo.banner.generic.y		= 16;
ADDRGP4 advOptMonInfo+424+16
CNSTI4 16
ASGNI4
line 3734
;3734:	advOptMonInfo.banner.string			= "ADVANCED OPTIONS";
ADDRGP4 advOptMonInfo+424+60
ADDRGP4 $2359
ASGNP4
line 3735
;3735:	advOptMonInfo.banner.color			= color_white;
ADDRGP4 advOptMonInfo+424+68
ADDRGP4 color_white
ASGNP4
line 3736
;3736:	advOptMonInfo.banner.style			= UI_CENTER;
ADDRGP4 advOptMonInfo+424+64
CNSTI4 1
ASGNI4
line 3737
;3737:	Menu_AddItem(&advOptMonInfo.menu, &advOptMonInfo.banner);
ADDRGP4 advOptMonInfo
ARGP4
ADDRGP4 advOptMonInfo+424
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 3739
;3738:
;3739:	y =	80;
ADDRLP4 0
CNSTI4 80
ASGNI4
line 3742
;3740:
;3741:#if MONSTER_MODE
;3742:	if (s_serveroptions.gametype == GT_STU) {
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 8
NEI4 $2979
line 3743
;3743:		advOptMonInfo.minMonsters.generic.type			= MTYPE_FIELD;
ADDRGP4 advOptMonInfo+496
CNSTI4 4
ASGNI4
line 3744
;3744:		advOptMonInfo.minMonsters.generic.name			= "Min. # of Monsters:";
ADDRGP4 advOptMonInfo+496+4
ADDRGP4 $2985
ASGNP4
line 3745
;3745:		advOptMonInfo.minMonsters.generic.flags			= QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 advOptMonInfo+496+44
CNSTU4 290
ASGNU4
line 3746
;3746:		advOptMonInfo.minMonsters.generic.x				= ADVOPTIONS_X;
ADDRGP4 advOptMonInfo+496+12
CNSTI4 400
ASGNI4
line 3747
;3747:		advOptMonInfo.minMonsters.generic.y				= y;
ADDRGP4 advOptMonInfo+496+16
ADDRLP4 0
INDIRI4
ASGNI4
line 3748
;3748:		advOptMonInfo.minMonsters.field.widthInChars	= 4;
ADDRGP4 advOptMonInfo+496+60+8
CNSTI4 4
ASGNI4
line 3749
;3749:		advOptMonInfo.minMonsters.field.maxchars		= 3;
ADDRGP4 advOptMonInfo+496+60+268
CNSTI4 3
ASGNI4
line 3750
;3750:		advOptMonInfo.minMonsters.generic.statusbar	= UI_AdvOptMonMenu_MinMonStatusBar;
ADDRGP4 advOptMonInfo+496+52
ADDRGP4 UI_AdvOptMonMenu_MinMonStatusBar
ASGNP4
line 3751
;3751:		if (gtmpl.tksMinmonsters == TKS_fixedValue) advOptMonInfo.minMonsters.generic.flags |= QMF_GRAYED;
ADDRGP4 gtmpl+316
INDIRI4
CNSTI4 2
NEI4 $3000
ADDRLP4 4
ADDRGP4 advOptMonInfo+496+44
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
LABELV $3000
line 3752
;3752:		Menu_AddItem(&advOptMonInfo.menu, &advOptMonInfo.minMonsters);
ADDRGP4 advOptMonInfo
ARGP4
ADDRGP4 advOptMonInfo+496
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 3753
;3753:		y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 3754
;3754:	}
LABELV $2979
line 3757
;3755:
;3756:#if ESCAPE_MODE
;3757:	if (s_serveroptions.gametype != GT_EFH)
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 9
EQI4 $3006
line 3759
;3758:#endif
;3759:	{
line 3760
;3760:		advOptMonInfo.maxMonsters.generic.type			= MTYPE_FIELD;
ADDRGP4 advOptMonInfo+828
CNSTI4 4
ASGNI4
line 3761
;3761:		advOptMonInfo.maxMonsters.generic.name			= "Max. # of Monsters:";
ADDRGP4 advOptMonInfo+828+4
ADDRGP4 $3012
ASGNP4
line 3762
;3762:		advOptMonInfo.maxMonsters.generic.flags			= QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 advOptMonInfo+828+44
CNSTU4 290
ASGNU4
line 3763
;3763:		advOptMonInfo.maxMonsters.generic.x				= ADVOPTIONS_X;
ADDRGP4 advOptMonInfo+828+12
CNSTI4 400
ASGNI4
line 3764
;3764:		advOptMonInfo.maxMonsters.generic.y				= y;
ADDRGP4 advOptMonInfo+828+16
ADDRLP4 0
INDIRI4
ASGNI4
line 3765
;3765:		advOptMonInfo.maxMonsters.field.widthInChars	= 4;
ADDRGP4 advOptMonInfo+828+60+8
CNSTI4 4
ASGNI4
line 3766
;3766:		advOptMonInfo.maxMonsters.field.maxchars		= 3;
ADDRGP4 advOptMonInfo+828+60+268
CNSTI4 3
ASGNI4
line 3767
;3767:		advOptMonInfo.maxMonsters.generic.statusbar	= UI_AdvOptMonMenu_MaxMonStatusBar;
ADDRGP4 advOptMonInfo+828+52
ADDRGP4 UI_AdvOptMonMenu_MaxMonStatusBar
ASGNP4
line 3768
;3768:		if (gtmpl.tksMaxmonsters == TKS_fixedValue) advOptMonInfo.maxMonsters.generic.flags |= QMF_GRAYED;
ADDRGP4 gtmpl+324
INDIRI4
CNSTI4 2
NEI4 $3027
ADDRLP4 4
ADDRGP4 advOptMonInfo+828+44
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
LABELV $3027
line 3769
;3769:		Menu_AddItem(&advOptMonInfo.menu, &advOptMonInfo.maxMonsters);
ADDRGP4 advOptMonInfo
ARGP4
ADDRGP4 advOptMonInfo+828
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 3770
;3770:		y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 3771
;3771:	}
LABELV $3006
line 3774
;3772:
;3773:#if ESCAPE_MODE
;3774:	if (s_serveroptions.gametype == GT_EFH) {
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 9
NEI4 $3033
line 3775
;3775:		advOptMonInfo.monsterLoad.generic.type			= MTYPE_FIELD;
ADDRGP4 advOptMonInfo+3432
CNSTI4 4
ASGNI4
line 3776
;3776:		advOptMonInfo.monsterLoad.generic.name			= "Monster Load [%]:";
ADDRGP4 advOptMonInfo+3432+4
ADDRGP4 $3039
ASGNP4
line 3777
;3777:		advOptMonInfo.monsterLoad.generic.flags			= QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 advOptMonInfo+3432+44
CNSTU4 290
ASGNU4
line 3778
;3778:		advOptMonInfo.monsterLoad.generic.x				= ADVOPTIONS_X;
ADDRGP4 advOptMonInfo+3432+12
CNSTI4 400
ASGNI4
line 3779
;3779:		advOptMonInfo.monsterLoad.generic.y				= y;
ADDRGP4 advOptMonInfo+3432+16
ADDRLP4 0
INDIRI4
ASGNI4
line 3780
;3780:		advOptMonInfo.monsterLoad.field.widthInChars	= 4;
ADDRGP4 advOptMonInfo+3432+60+8
CNSTI4 4
ASGNI4
line 3781
;3781:		advOptMonInfo.monsterLoad.field.maxchars		= 3;
ADDRGP4 advOptMonInfo+3432+60+268
CNSTI4 3
ASGNI4
line 3782
;3782:		advOptMonInfo.monsterLoad.generic.statusbar	= UI_AdvOptMonMenu_MonLoadStatusBar;
ADDRGP4 advOptMonInfo+3432+52
ADDRGP4 UI_AdvOptMonMenu_MonLoadStatusBar
ASGNP4
line 3783
;3783:		if (gtmpl.tksMonsterload == TKS_fixedValue) advOptMonInfo.monsterLoad.generic.flags |= QMF_GRAYED;
ADDRGP4 gtmpl+308
INDIRI4
CNSTI4 2
NEI4 $3054
ADDRLP4 4
ADDRGP4 advOptMonInfo+3432+44
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
LABELV $3054
line 3784
;3784:		Menu_AddItem(&advOptMonInfo.menu, &advOptMonInfo.monsterLoad);
ADDRGP4 advOptMonInfo
ARGP4
ADDRGP4 advOptMonInfo+3432
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 3785
;3785:		y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 3786
;3786:	}
LABELV $3033
line 3789
;3787:#endif
;3788:
;3789:	if (s_serveroptions.gametype == GT_STU) {
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 8
NEI4 $3060
line 3790
;3790:		advOptMonInfo.monstersPerTrap.generic.type			= MTYPE_FIELD;
ADDRGP4 advOptMonInfo+1160
CNSTI4 4
ASGNI4
line 3791
;3791:		advOptMonInfo.monstersPerTrap.generic.name			= "# of Monsters Spawned on Artefacts:";
ADDRGP4 advOptMonInfo+1160+4
ADDRGP4 $3066
ASGNP4
line 3792
;3792:		advOptMonInfo.monstersPerTrap.generic.flags			= QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 advOptMonInfo+1160+44
CNSTU4 290
ASGNU4
line 3793
;3793:		advOptMonInfo.monstersPerTrap.generic.x				= ADVOPTIONS_X;
ADDRGP4 advOptMonInfo+1160+12
CNSTI4 400
ASGNI4
line 3794
;3794:		advOptMonInfo.monstersPerTrap.generic.y				= y;
ADDRGP4 advOptMonInfo+1160+16
ADDRLP4 0
INDIRI4
ASGNI4
line 3795
;3795:		advOptMonInfo.monstersPerTrap.field.widthInChars	= 4;
ADDRGP4 advOptMonInfo+1160+60+8
CNSTI4 4
ASGNI4
line 3796
;3796:		advOptMonInfo.monstersPerTrap.field.maxchars		= 3;
ADDRGP4 advOptMonInfo+1160+60+268
CNSTI4 3
ASGNI4
line 3797
;3797:		advOptMonInfo.monstersPerTrap.generic.statusbar	= UI_AdvOptMonMenu_MinMonStatusBar;
ADDRGP4 advOptMonInfo+1160+52
ADDRGP4 UI_AdvOptMonMenu_MinMonStatusBar
ASGNP4
line 3798
;3798:		if (gtmpl.tksMonsterspertrap == TKS_fixedValue) advOptMonInfo.monstersPerTrap.generic.flags |= QMF_GRAYED;
ADDRGP4 gtmpl+332
INDIRI4
CNSTI4 2
NEI4 $3081
ADDRLP4 4
ADDRGP4 advOptMonInfo+1160+44
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
LABELV $3081
line 3799
;3799:		Menu_AddItem(&advOptMonInfo.menu, &advOptMonInfo.monstersPerTrap);
ADDRGP4 advOptMonInfo
ARGP4
ADDRGP4 advOptMonInfo+1160
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 3800
;3800:		y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 3802
;3801:
;3802:		advOptMonInfo.monsterSpawnDelay.generic.type		= MTYPE_FIELD;
ADDRGP4 advOptMonInfo+1492
CNSTI4 4
ASGNI4
line 3803
;3803:		advOptMonInfo.monsterSpawnDelay.generic.name		= "Monster Spawn Delay:";
ADDRGP4 advOptMonInfo+1492+4
ADDRGP4 $3090
ASGNP4
line 3804
;3804:		advOptMonInfo.monsterSpawnDelay.generic.flags		= QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 advOptMonInfo+1492+44
CNSTU4 290
ASGNU4
line 3805
;3805:		advOptMonInfo.monsterSpawnDelay.generic.x			= ADVOPTIONS_X;
ADDRGP4 advOptMonInfo+1492+12
CNSTI4 400
ASGNI4
line 3806
;3806:		advOptMonInfo.monsterSpawnDelay.generic.y			= y;
ADDRGP4 advOptMonInfo+1492+16
ADDRLP4 0
INDIRI4
ASGNI4
line 3807
;3807:		advOptMonInfo.monsterSpawnDelay.field.widthInChars	= 8;
ADDRGP4 advOptMonInfo+1492+60+8
CNSTI4 8
ASGNI4
line 3808
;3808:		advOptMonInfo.monsterSpawnDelay.field.maxchars		= 7;
ADDRGP4 advOptMonInfo+1492+60+268
CNSTI4 7
ASGNI4
line 3809
;3809:		advOptMonInfo.monsterSpawnDelay.generic.statusbar	= UI_AdvOptMonMenu_MSDStatusBar;
ADDRGP4 advOptMonInfo+1492+52
ADDRGP4 UI_AdvOptMonMenu_MSDStatusBar
ASGNP4
line 3810
;3810:		if (gtmpl.tksMonsterspawndelay == TKS_fixedValue) advOptMonInfo.monsterSpawnDelay.generic.flags |= QMF_GRAYED;
ADDRGP4 gtmpl+340
INDIRI4
CNSTI4 2
NEI4 $3105
ADDRLP4 8
ADDRGP4 advOptMonInfo+1492+44
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
LABELV $3105
line 3811
;3811:		Menu_AddItem(&advOptMonInfo.menu, &advOptMonInfo.monsterSpawnDelay);
ADDRGP4 advOptMonInfo
ARGP4
ADDRGP4 advOptMonInfo+1492
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 3812
;3812:		y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 3813
;3813:	}
LABELV $3060
line 3815
;3814:
;3815:	advOptMonInfo.monsterHealthScale.generic.type			= MTYPE_FIELD;
ADDRGP4 advOptMonInfo+1824
CNSTI4 4
ASGNI4
line 3816
;3816:	advOptMonInfo.monsterHealthScale.generic.name			= "Monster Constitution [%]:";
ADDRGP4 advOptMonInfo+1824+4
ADDRGP4 $3114
ASGNP4
line 3817
;3817:	advOptMonInfo.monsterHealthScale.generic.flags			= QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 advOptMonInfo+1824+44
CNSTU4 290
ASGNU4
line 3818
;3818:	advOptMonInfo.monsterHealthScale.generic.x				= ADVOPTIONS_X;
ADDRGP4 advOptMonInfo+1824+12
CNSTI4 400
ASGNI4
line 3819
;3819:	advOptMonInfo.monsterHealthScale.generic.y				= y;
ADDRGP4 advOptMonInfo+1824+16
ADDRLP4 0
INDIRI4
ASGNI4
line 3820
;3820:	advOptMonInfo.monsterHealthScale.field.widthInChars		= 5;
ADDRGP4 advOptMonInfo+1824+60+8
CNSTI4 5
ASGNI4
line 3821
;3821:	advOptMonInfo.monsterHealthScale.field.maxchars			= 4;
ADDRGP4 advOptMonInfo+1824+60+268
CNSTI4 4
ASGNI4
line 3822
;3822:	advOptMonInfo.monsterHealthScale.generic.statusbar		= UI_AdvOptMonMenu_MonHealthStatusBar;
ADDRGP4 advOptMonInfo+1824+52
ADDRGP4 UI_AdvOptMonMenu_MonHealthStatusBar
ASGNP4
line 3823
;3823:	if (gtmpl.tksMonsterhealthscale == TKS_fixedValue) advOptMonInfo.monsterHealthScale.generic.flags |= QMF_GRAYED;
ADDRGP4 gtmpl+348
INDIRI4
CNSTI4 2
NEI4 $3129
ADDRLP4 4
ADDRGP4 advOptMonInfo+1824+44
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
LABELV $3129
line 3824
;3824:	Menu_AddItem(&advOptMonInfo.menu, &advOptMonInfo.monsterHealthScale);
ADDRGP4 advOptMonInfo
ARGP4
ADDRGP4 advOptMonInfo+1824
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 3825
;3825:	y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 3828
;3826:
;3827:	if (
;3828:		s_serveroptions.gametype == GT_STU
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 8
EQI4 $3139
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 9
NEI4 $3135
LABELV $3139
line 3832
;3829:#if ESCAPE_MODE
;3830:		|| s_serveroptions.gametype == GT_EFH
;3831:#endif
;3832:	) {
line 3833
;3833:		advOptMonInfo.monsterProgression.generic.type			= MTYPE_FIELD;
ADDRGP4 advOptMonInfo+2156
CNSTI4 4
ASGNI4
line 3834
;3834:		advOptMonInfo.monsterProgression.generic.name			= "Monster Constitution Progression [%/min]:";
ADDRGP4 advOptMonInfo+2156+4
ADDRGP4 $3143
ASGNP4
line 3835
;3835:		advOptMonInfo.monsterProgression.generic.flags			= QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 advOptMonInfo+2156+44
CNSTU4 290
ASGNU4
line 3836
;3836:		advOptMonInfo.monsterProgression.generic.x				= ADVOPTIONS_X;
ADDRGP4 advOptMonInfo+2156+12
CNSTI4 400
ASGNI4
line 3837
;3837:		advOptMonInfo.monsterProgression.generic.y				= y;
ADDRGP4 advOptMonInfo+2156+16
ADDRLP4 0
INDIRI4
ASGNI4
line 3838
;3838:		advOptMonInfo.monsterProgression.field.widthInChars		= 5;
ADDRGP4 advOptMonInfo+2156+60+8
CNSTI4 5
ASGNI4
line 3839
;3839:		advOptMonInfo.monsterProgression.field.maxchars			= 4;
ADDRGP4 advOptMonInfo+2156+60+268
CNSTI4 4
ASGNI4
line 3840
;3840:		advOptMonInfo.monsterProgression.generic.statusbar		= UI_AdvOptMonMenu_MonProgStatusBar;
ADDRGP4 advOptMonInfo+2156+52
ADDRGP4 UI_AdvOptMonMenu_MonProgStatusBar
ASGNP4
line 3841
;3841:		if (gtmpl.tksMonsterprogessivehealth == TKS_fixedValue) advOptMonInfo.monsterProgression.generic.flags |= QMF_GRAYED;
ADDRGP4 gtmpl+356
INDIRI4
CNSTI4 2
NEI4 $3158
ADDRLP4 8
ADDRGP4 advOptMonInfo+2156+44
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
LABELV $3158
line 3842
;3842:		Menu_AddItem(&advOptMonInfo.menu, &advOptMonInfo.monsterProgression);
ADDRGP4 advOptMonInfo
ARGP4
ADDRGP4 advOptMonInfo+2156
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 3843
;3843:		y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 3844
;3844:	}
LABELV $3135
line 3846
;3845:
;3846:	if (s_serveroptions.gametype == GT_STU) {
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 8
NEI4 $3164
line 3847
;3847:		advOptMonInfo.monsterBreeding.generic.type		= MTYPE_RADIOBUTTON;
ADDRGP4 advOptMonInfo+3152
CNSTI4 5
ASGNI4
line 3848
;3848:		advOptMonInfo.monsterBreeding.generic.name		= "Predators Breeding Monsters:";
ADDRGP4 advOptMonInfo+3152+4
ADDRGP4 $3170
ASGNP4
line 3849
;3849:		advOptMonInfo.monsterBreeding.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 advOptMonInfo+3152+44
CNSTU4 258
ASGNU4
line 3850
;3850:		advOptMonInfo.monsterBreeding.generic.x			= ADVOPTIONS_X;
ADDRGP4 advOptMonInfo+3152+12
CNSTI4 400
ASGNI4
line 3851
;3851:		advOptMonInfo.monsterBreeding.generic.y			= y;
ADDRGP4 advOptMonInfo+3152+16
ADDRLP4 0
INDIRI4
ASGNI4
line 3852
;3852:		if (gtmpl.tksMonsterbreeding == TKS_fixedValue) advOptMonInfo.monsterBreeding.generic.flags |= QMF_GRAYED;
ADDRGP4 gtmpl+380
INDIRI4
CNSTI4 2
NEI4 $3177
ADDRLP4 8
ADDRGP4 advOptMonInfo+3152+44
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
LABELV $3177
line 3853
;3853:		Menu_AddItem(&advOptMonInfo.menu, &advOptMonInfo.monsterBreeding);
ADDRGP4 advOptMonInfo
ARGP4
ADDRGP4 advOptMonInfo+3152
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 3854
;3854:		y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 3855
;3855:	}
LABELV $3164
line 3857
;3856:
;3857:	advOptMonInfo.monsterModel1.generic.type		= MTYPE_TEXT;
ADDRGP4 advOptMonInfo+3216
CNSTI4 7
ASGNI4
line 3858
;3858:	advOptMonInfo.monsterModel1.generic.name		= "Monster Model \"Predator\":";
ADDRGP4 advOptMonInfo+3216+4
ADDRGP4 $3186
ASGNP4
line 3859
;3859:	advOptMonInfo.monsterModel1.generic.flags		= QMF_SMALLFONT;
ADDRGP4 advOptMonInfo+3216+44
CNSTU4 2
ASGNU4
line 3860
;3860:	advOptMonInfo.monsterModel1.generic.x			= ADVOPTIONS_X;
ADDRGP4 advOptMonInfo+3216+12
CNSTI4 400
ASGNI4
line 3861
;3861:	advOptMonInfo.monsterModel1.generic.y			= y;
ADDRGP4 advOptMonInfo+3216+16
ADDRLP4 0
INDIRI4
ASGNI4
line 3862
;3862:	advOptMonInfo.monsterModel1.generic.callback	= UI_AdvOptMonMenu_PredatorModel_Callback;
ADDRGP4 advOptMonInfo+3216+48
ADDRGP4 UI_AdvOptMonMenu_PredatorModel_Callback
ASGNP4
line 3863
;3863:	advOptMonInfo.monsterModel1.generic.ownerdraw	= UI_AdvOptMonMenu_MonsterModel_Draw;
ADDRGP4 advOptMonInfo+3216+56
ADDRGP4 UI_AdvOptMonMenu_MonsterModel_Draw
ASGNP4
line 3864
;3864:	advOptMonInfo.monsterModel1.color				= color_orange;
ADDRGP4 advOptMonInfo+3216+68
ADDRGP4 color_orange
ASGNP4
line 3865
;3865:	advOptMonInfo.monsterModel1.style				= UI_SMALLFONT;
ADDRGP4 advOptMonInfo+3216+64
CNSTI4 16
ASGNI4
line 3866
;3866:	advOptMonInfo.monsterModel1.string				= s_serveroptions.monsterModel1;
ADDRGP4 advOptMonInfo+3216+60
ADDRGP4 s_serveroptions+2664
ASGNP4
line 3867
;3867:	advOptMonInfo.monsterModel1.generic.top			= advOptMonInfo.monsterModel1.generic.y;
ADDRGP4 advOptMonInfo+3216+24
ADDRGP4 advOptMonInfo+3216+16
INDIRI4
ASGNI4
line 3868
;3868:	advOptMonInfo.monsterModel1.generic.bottom		= advOptMonInfo.monsterModel1.generic.y + SMALLCHAR_HEIGHT;
ADDRGP4 advOptMonInfo+3216+32
ADDRGP4 advOptMonInfo+3216+16
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 3869
;3869:	advOptMonInfo.monsterModel1.generic.left		= advOptMonInfo.monsterModel1.generic.x - (strlen(advOptMonInfo.monsterModel1.generic.name)+1) * SMALLCHAR_WIDTH;
ADDRGP4 advOptMonInfo+3216+4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRGP4 advOptMonInfo+3216+20
ADDRGP4 advOptMonInfo+3216+12
INDIRI4
ADDRLP4 8
INDIRI4
CNSTI4 3
LSHI4
CNSTI4 8
ADDI4
SUBI4
ASGNI4
line 3870
;3870:	advOptMonInfo.monsterModel1.generic.right		= advOptMonInfo.monsterModel1.generic.x + 32 * SMALLCHAR_WIDTH;
ADDRGP4 advOptMonInfo+3216+28
ADDRGP4 advOptMonInfo+3216+12
INDIRI4
CNSTI4 256
ADDI4
ASGNI4
line 3871
;3871:	Menu_AddItem(&advOptMonInfo.menu, &advOptMonInfo.monsterModel1);
ADDRGP4 advOptMonInfo
ARGP4
ADDRGP4 advOptMonInfo+3216
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 3872
;3872:	advOptMonInfo.monsterModel1.generic.flags &= ~QMF_INACTIVE;
ADDRLP4 12
ADDRGP4 advOptMonInfo+3216+44
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRU4
CNSTU4 4294950911
BANDU4
ASGNU4
line 3873
;3873:	y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 3875
;3874:
;3875:	if (s_serveroptions.gametype >= GT_STU) {
ADDRGP4 s_serveroptions+7504
INDIRI4
CNSTI4 8
LTI4 $3225
line 3876
;3876:		advOptMonInfo.monsterModel2.generic.type		= MTYPE_TEXT;
ADDRGP4 advOptMonInfo+3288
CNSTI4 7
ASGNI4
line 3877
;3877:		advOptMonInfo.monsterModel2.generic.name		= "Monster Model \"Guard\":";
ADDRGP4 advOptMonInfo+3288+4
ADDRGP4 $3231
ASGNP4
line 3878
;3878:		advOptMonInfo.monsterModel2.generic.flags		= QMF_SMALLFONT;
ADDRGP4 advOptMonInfo+3288+44
CNSTU4 2
ASGNU4
line 3879
;3879:		advOptMonInfo.monsterModel2.generic.x			= ADVOPTIONS_X;
ADDRGP4 advOptMonInfo+3288+12
CNSTI4 400
ASGNI4
line 3880
;3880:		advOptMonInfo.monsterModel2.generic.y			= y;
ADDRGP4 advOptMonInfo+3288+16
ADDRLP4 0
INDIRI4
ASGNI4
line 3881
;3881:		advOptMonInfo.monsterModel2.generic.callback	= UI_AdvOptMonMenu_GuardModel_Callback;
ADDRGP4 advOptMonInfo+3288+48
ADDRGP4 UI_AdvOptMonMenu_GuardModel_Callback
ASGNP4
line 3882
;3882:		advOptMonInfo.monsterModel2.generic.ownerdraw	= UI_AdvOptMonMenu_MonsterModel_Draw;
ADDRGP4 advOptMonInfo+3288+56
ADDRGP4 UI_AdvOptMonMenu_MonsterModel_Draw
ASGNP4
line 3883
;3883:		advOptMonInfo.monsterModel2.color				= color_orange;
ADDRGP4 advOptMonInfo+3288+68
ADDRGP4 color_orange
ASGNP4
line 3884
;3884:		advOptMonInfo.monsterModel2.style				= UI_SMALLFONT;
ADDRGP4 advOptMonInfo+3288+64
CNSTI4 16
ASGNI4
line 3885
;3885:		advOptMonInfo.monsterModel2.string				= s_serveroptions.monsterModel2;
ADDRGP4 advOptMonInfo+3288+60
ADDRGP4 s_serveroptions+2696
ASGNP4
line 3886
;3886:		advOptMonInfo.monsterModel2.generic.top			= advOptMonInfo.monsterModel2.generic.y;
ADDRGP4 advOptMonInfo+3288+24
ADDRGP4 advOptMonInfo+3288+16
INDIRI4
ASGNI4
line 3887
;3887:		advOptMonInfo.monsterModel2.generic.bottom		= advOptMonInfo.monsterModel2.generic.y + SMALLCHAR_HEIGHT;
ADDRGP4 advOptMonInfo+3288+32
ADDRGP4 advOptMonInfo+3288+16
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 3888
;3888:		advOptMonInfo.monsterModel2.generic.left		= advOptMonInfo.monsterModel2.generic.x - (strlen(advOptMonInfo.monsterModel2.generic.name)+1) * SMALLCHAR_WIDTH;
ADDRGP4 advOptMonInfo+3288+4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRGP4 advOptMonInfo+3288+20
ADDRGP4 advOptMonInfo+3288+12
INDIRI4
ADDRLP4 16
INDIRI4
CNSTI4 3
LSHI4
CNSTI4 8
ADDI4
SUBI4
ASGNI4
line 3889
;3889:		advOptMonInfo.monsterModel2.generic.right		= advOptMonInfo.monsterModel2.generic.x + 32 * SMALLCHAR_WIDTH;
ADDRGP4 advOptMonInfo+3288+28
ADDRGP4 advOptMonInfo+3288+12
INDIRI4
CNSTI4 256
ADDI4
ASGNI4
line 3890
;3890:		Menu_AddItem(&advOptMonInfo.menu, &advOptMonInfo.monsterModel2);
ADDRGP4 advOptMonInfo
ARGP4
ADDRGP4 advOptMonInfo+3288
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 3891
;3891:		advOptMonInfo.monsterModel2.generic.flags &= ~QMF_INACTIVE;
ADDRLP4 20
ADDRGP4 advOptMonInfo+3288+44
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRU4
CNSTU4 4294950911
BANDU4
ASGNU4
line 3892
;3892:		y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 3894
;3893:
;3894:		advOptMonInfo.monsterModel3.generic.type		= MTYPE_TEXT;
ADDRGP4 advOptMonInfo+3360
CNSTI4 7
ASGNI4
line 3895
;3895:		advOptMonInfo.monsterModel3.generic.name		= "Monster Model \"Titan\":";
ADDRGP4 advOptMonInfo+3360+4
ADDRGP4 $3273
ASGNP4
line 3896
;3896:		advOptMonInfo.monsterModel3.generic.flags		= QMF_SMALLFONT;
ADDRGP4 advOptMonInfo+3360+44
CNSTU4 2
ASGNU4
line 3897
;3897:		advOptMonInfo.monsterModel3.generic.x			= ADVOPTIONS_X;
ADDRGP4 advOptMonInfo+3360+12
CNSTI4 400
ASGNI4
line 3898
;3898:		advOptMonInfo.monsterModel3.generic.y			= y;
ADDRGP4 advOptMonInfo+3360+16
ADDRLP4 0
INDIRI4
ASGNI4
line 3899
;3899:		advOptMonInfo.monsterModel3.generic.callback	= UI_AdvOptMonMenu_TitansModel_Callback;
ADDRGP4 advOptMonInfo+3360+48
ADDRGP4 UI_AdvOptMonMenu_TitansModel_Callback
ASGNP4
line 3900
;3900:		advOptMonInfo.monsterModel3.generic.ownerdraw	= UI_AdvOptMonMenu_MonsterModel_Draw;
ADDRGP4 advOptMonInfo+3360+56
ADDRGP4 UI_AdvOptMonMenu_MonsterModel_Draw
ASGNP4
line 3901
;3901:		advOptMonInfo.monsterModel3.color				= color_orange;
ADDRGP4 advOptMonInfo+3360+68
ADDRGP4 color_orange
ASGNP4
line 3902
;3902:		advOptMonInfo.monsterModel3.style				= UI_SMALLFONT;
ADDRGP4 advOptMonInfo+3360+64
CNSTI4 16
ASGNI4
line 3903
;3903:		advOptMonInfo.monsterModel3.string				= s_serveroptions.monsterModel3;
ADDRGP4 advOptMonInfo+3360+60
ADDRGP4 s_serveroptions+2728
ASGNP4
line 3904
;3904:		advOptMonInfo.monsterModel3.generic.top			= advOptMonInfo.monsterModel3.generic.y;
ADDRGP4 advOptMonInfo+3360+24
ADDRGP4 advOptMonInfo+3360+16
INDIRI4
ASGNI4
line 3905
;3905:		advOptMonInfo.monsterModel3.generic.bottom		= advOptMonInfo.monsterModel3.generic.y + SMALLCHAR_HEIGHT;
ADDRGP4 advOptMonInfo+3360+32
ADDRGP4 advOptMonInfo+3360+16
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 3906
;3906:		advOptMonInfo.monsterModel3.generic.left		= advOptMonInfo.monsterModel3.generic.x - (strlen(advOptMonInfo.monsterModel3.generic.name)+1) * SMALLCHAR_WIDTH;
ADDRGP4 advOptMonInfo+3360+4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRGP4 advOptMonInfo+3360+20
ADDRGP4 advOptMonInfo+3360+12
INDIRI4
ADDRLP4 24
INDIRI4
CNSTI4 3
LSHI4
CNSTI4 8
ADDI4
SUBI4
ASGNI4
line 3907
;3907:		advOptMonInfo.monsterModel3.generic.right		= advOptMonInfo.monsterModel3.generic.x + 32 * SMALLCHAR_WIDTH;
ADDRGP4 advOptMonInfo+3360+28
ADDRGP4 advOptMonInfo+3360+12
INDIRI4
CNSTI4 256
ADDI4
ASGNI4
line 3908
;3908:		Menu_AddItem(&advOptMonInfo.menu, &advOptMonInfo.monsterModel3);
ADDRGP4 advOptMonInfo
ARGP4
ADDRGP4 advOptMonInfo+3360
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 3909
;3909:		advOptMonInfo.monsterModel3.generic.flags &= ~QMF_INACTIVE;
ADDRLP4 28
ADDRGP4 advOptMonInfo+3360+44
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRU4
CNSTU4 4294950911
BANDU4
ASGNU4
line 3910
;3910:		y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 3912
;3911:
;3912:		advOptMonInfo.monsterGuards.generic.type		= MTYPE_FIELD;
ADDRGP4 advOptMonInfo+2488
CNSTI4 4
ASGNI4
line 3913
;3913:		advOptMonInfo.monsterGuards.generic.name		= "Avg. Part of Monsters Spawning as Guards [%]:";
ADDRGP4 advOptMonInfo+2488+4
ADDRGP4 $3315
ASGNP4
line 3914
;3914:		advOptMonInfo.monsterGuards.generic.flags		= QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 advOptMonInfo+2488+44
CNSTU4 290
ASGNU4
line 3915
;3915:		advOptMonInfo.monsterGuards.generic.x			= ADVOPTIONS_X;
ADDRGP4 advOptMonInfo+2488+12
CNSTI4 400
ASGNI4
line 3916
;3916:		advOptMonInfo.monsterGuards.generic.y			= y;
ADDRGP4 advOptMonInfo+2488+16
ADDRLP4 0
INDIRI4
ASGNI4
line 3917
;3917:		advOptMonInfo.monsterGuards.field.widthInChars	= 4;
ADDRGP4 advOptMonInfo+2488+60+8
CNSTI4 4
ASGNI4
line 3918
;3918:		advOptMonInfo.monsterGuards.field.maxchars		= 3;
ADDRGP4 advOptMonInfo+2488+60+268
CNSTI4 3
ASGNI4
line 3919
;3919:		advOptMonInfo.monsterGuards.generic.statusbar	= UI_AdvOptMonMenu_GuardsStatusBar;
ADDRGP4 advOptMonInfo+2488+52
ADDRGP4 UI_AdvOptMonMenu_GuardsStatusBar
ASGNP4
line 3920
;3920:		if (gtmpl.tksGuards == TKS_fixedValue) advOptMonInfo.monsterGuards.generic.flags |= QMF_GRAYED;
ADDRGP4 gtmpl+364
INDIRI4
CNSTI4 2
NEI4 $3330
ADDRLP4 32
ADDRGP4 advOptMonInfo+2488+44
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
LABELV $3330
line 3921
;3921:		Menu_AddItem(&advOptMonInfo.menu, &advOptMonInfo.monsterGuards);
ADDRGP4 advOptMonInfo
ARGP4
ADDRGP4 advOptMonInfo+2488
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 3922
;3922:		y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 3924
;3923:
;3924:		advOptMonInfo.monsterTitans.generic.type		= MTYPE_FIELD;
ADDRGP4 advOptMonInfo+2820
CNSTI4 4
ASGNI4
line 3925
;3925:		advOptMonInfo.monsterTitans.generic.name		= "Avg. Part of Monsters Spawning as Titans [%]:";
ADDRGP4 advOptMonInfo+2820+4
ADDRGP4 $3339
ASGNP4
line 3926
;3926:		advOptMonInfo.monsterTitans.generic.flags		= QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 advOptMonInfo+2820+44
CNSTU4 290
ASGNU4
line 3927
;3927:		advOptMonInfo.monsterTitans.generic.x			= ADVOPTIONS_X;
ADDRGP4 advOptMonInfo+2820+12
CNSTI4 400
ASGNI4
line 3928
;3928:		advOptMonInfo.monsterTitans.generic.y			= y;
ADDRGP4 advOptMonInfo+2820+16
ADDRLP4 0
INDIRI4
ASGNI4
line 3929
;3929:		advOptMonInfo.monsterTitans.field.widthInChars	= 4;
ADDRGP4 advOptMonInfo+2820+60+8
CNSTI4 4
ASGNI4
line 3930
;3930:		advOptMonInfo.monsterTitans.field.maxchars		= 3;
ADDRGP4 advOptMonInfo+2820+60+268
CNSTI4 3
ASGNI4
line 3931
;3931:		advOptMonInfo.monsterTitans.generic.statusbar	= UI_AdvOptMonMenu_GuardsStatusBar;
ADDRGP4 advOptMonInfo+2820+52
ADDRGP4 UI_AdvOptMonMenu_GuardsStatusBar
ASGNP4
line 3932
;3932:		if (gtmpl.tksTitans == TKS_fixedValue) advOptMonInfo.monsterTitans.generic.flags |= QMF_GRAYED;
ADDRGP4 gtmpl+372
INDIRI4
CNSTI4 2
NEI4 $3354
ADDRLP4 36
ADDRGP4 advOptMonInfo+2820+44
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
LABELV $3354
line 3933
;3933:		Menu_AddItem(&advOptMonInfo.menu, &advOptMonInfo.monsterTitans);
ADDRGP4 advOptMonInfo
ARGP4
ADDRGP4 advOptMonInfo+2820
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 3934
;3934:		y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 3935
;3935:	}
LABELV $3225
line 3938
;3936:#endif
;3937:
;3938:	advOptMonInfo.back.generic.type		= MTYPE_BITMAP;
ADDRGP4 advOptMonInfo+3764
CNSTI4 6
ASGNI4
line 3939
;3939:	advOptMonInfo.back.generic.name		= ADVOPT_BACK0;
ADDRGP4 advOptMonInfo+3764+4
ADDRGP4 $421
ASGNP4
line 3940
;3940:	advOptMonInfo.back.generic.flags	= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 advOptMonInfo+3764+44
CNSTU4 260
ASGNU4
line 3941
;3941:	advOptMonInfo.back.generic.callback	= UI_AdvOptMonMenu_BackEvent;
ADDRGP4 advOptMonInfo+3764+48
ADDRGP4 UI_AdvOptMonMenu_BackEvent
ASGNP4
line 3942
;3942:	advOptMonInfo.back.generic.x		= 0;
ADDRGP4 advOptMonInfo+3764+12
CNSTI4 0
ASGNI4
line 3943
;3943:	advOptMonInfo.back.generic.y		= 480-64;
ADDRGP4 advOptMonInfo+3764+16
CNSTI4 416
ASGNI4
line 3944
;3944:	advOptMonInfo.back.width			= 128;
ADDRGP4 advOptMonInfo+3764+76
CNSTI4 128
ASGNI4
line 3945
;3945:	advOptMonInfo.back.height			= 64;
ADDRGP4 advOptMonInfo+3764+80
CNSTI4 64
ASGNI4
line 3946
;3946:	advOptMonInfo.back.focuspic			= ADVOPT_BACK1;
ADDRGP4 advOptMonInfo+3764+60
ADDRGP4 $438
ASGNP4
line 3947
;3947:	Menu_AddItem(&advOptMonInfo.menu, &advOptMonInfo.back);
ADDRGP4 advOptMonInfo
ARGP4
ADDRGP4 advOptMonInfo+3764
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 3949
;3948:
;3949:	UI_AdvOptMonMenu_SetMenuItems();
ADDRGP4 UI_AdvOptMonMenu_SetMenuItems
CALLV
pop
line 3950
;3950:}
LABELV $2964
endproc UI_AdvOptMonMenu_Init 40 12
proc UI_AdvOptMonMenu 0 4
line 3959
;3951:#endif
;3952:
;3953:/*
;3954:=================
;3955:JUHOX: UI_AdvOptMonMenu
;3956:=================
;3957:*/
;3958:#if MONSTER_MODE
;3959:static void UI_AdvOptMonMenu(void) {
line 3960
;3960:	UI_AdvOptMonMenu_Init();
ADDRGP4 UI_AdvOptMonMenu_Init
CALLV
pop
line 3961
;3961:	UI_PushMenu(&advOptMonInfo.menu);
ADDRGP4 advOptMonInfo
ARGP4
ADDRGP4 UI_PushMenu
CALLV
pop
line 3962
;3962:}
LABELV $3378
endproc UI_AdvOptMonMenu 0 4
export UI_AdvOptMainMenu_Cache
proc UI_AdvOptMainMenu_Cache 0 4
line 3983
;3963:#endif
;3964:
;3965:
;3966:
;3967:
;3968:
;3969:
;3970:
;3971:
;3972:/*
;3973:=============================================================================
;3974:JUHOX: ADVANCED OPTIONS MENU ***** MAIN
;3975:=============================================================================
;3976:*/
;3977:
;3978:/*
;3979:=================
;3980:JUHOX: UI_AdvOptMainMenu_Cache
;3981:=================
;3982:*/
;3983:void UI_AdvOptMainMenu_Cache(void) {
line 3984
;3984:	trap_R_RegisterShaderNoMip(ADVOPT_BACK0);
ADDRGP4 $421
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 3985
;3985:	trap_R_RegisterShaderNoMip(ADVOPT_BACK1);
ADDRGP4 $438
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 3986
;3986:}
LABELV $3379
endproc UI_AdvOptMainMenu_Cache 0 4
export UI_AdvOptMainMenu_BackEvent
proc UI_AdvOptMainMenu_BackEvent 0 0
line 3993
;3987:
;3988:/*
;3989:=================
;3990:JUHOX: UI_AdvOptMainMenu_BackEvent
;3991:=================
;3992:*/
;3993:void UI_AdvOptMainMenu_BackEvent(void* ptr, int event) {
line 3994
;3994:	if (event != QM_ACTIVATED) return;
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $3381
ADDRGP4 $3380
JUMPV
LABELV $3381
line 3996
;3995:
;3996:	UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 3997
;3997:}
LABELV $3380
endproc UI_AdvOptMainMenu_BackEvent 0 0
proc UI_AdvOptMainMenu_Event 8 0
line 4004
;3998:
;3999:/*
;4000:=================
;4001:JUHOX: UI_AdvOptMainMenu_Event
;4002:=================
;4003:*/
;4004:static void UI_AdvOptMainMenu_Event(void* ptr, int event) {
line 4005
;4005:	if (event != QM_ACTIVATED) return;
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $3384
ADDRGP4 $3383
JUMPV
LABELV $3384
line 4007
;4006:
;4007:	switch (((menucommon_s *)ptr)->id) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 100
EQI4 $3389
ADDRLP4 0
INDIRI4
CNSTI4 101
EQI4 $3390
ADDRLP4 0
INDIRI4
CNSTI4 102
EQI4 $3391
ADDRGP4 $3386
JUMPV
LABELV $3389
line 4009
;4008:	case ID_ADVOPT_GAME:
;4009:		UI_AdvOptGameMenu();
ADDRGP4 UI_AdvOptGameMenu
CALLV
pop
line 4010
;4010:		break;
ADDRGP4 $3387
JUMPV
LABELV $3390
line 4012
;4011:	case ID_ADVOPT_EQUIPMENT:
;4012:		UI_AdvOptEquipMenu();
ADDRGP4 UI_AdvOptEquipMenu
CALLV
pop
line 4013
;4013:		break;
ADDRGP4 $3387
JUMPV
LABELV $3391
line 4016
;4014:#if MONSTER_MODE
;4015:	case ID_ADVOPT_MONSTERS:
;4016:		UI_AdvOptMonMenu();
ADDRGP4 UI_AdvOptMonMenu
CALLV
pop
line 4017
;4017:		break;
LABELV $3386
LABELV $3387
line 4020
;4018:	}
;4019:#endif
;4020:}
LABELV $3383
endproc UI_AdvOptMainMenu_Event 8 0
proc UI_AdvOptMainMenu_Init 4 12
line 4026
;4021:/*
;4022:=================
;4023:JUHOX: UI_AdvOptMainMenu_Init
;4024:=================
;4025:*/
;4026:static void UI_AdvOptMainMenu_Init(void) {
line 4029
;4027:	int y;
;4028:
;4029:	memset(&advOptMainInfo, 0, sizeof(advOptMainInfo));
ADDRGP4 advOptMainInfo
ARGP4
CNSTI4 0
ARGI4
CNSTI4 800
ARGI4
ADDRGP4 memset
CALLP4
pop
line 4030
;4030:	advOptMainInfo.menu.wrapAround = qtrue;
ADDRGP4 advOptMainInfo+404
CNSTI4 1
ASGNI4
line 4031
;4031:	advOptMainInfo.menu.fullscreen = qtrue;
ADDRGP4 advOptMainInfo+408
CNSTI4 1
ASGNI4
line 4033
;4032:
;4033:	UI_AdvOptMainMenu_Cache();
ADDRGP4 UI_AdvOptMainMenu_Cache
CALLV
pop
line 4035
;4034:
;4035:	advOptMainInfo.banner.generic.type	= MTYPE_BTEXT;
ADDRGP4 advOptMainInfo+424
CNSTI4 10
ASGNI4
line 4036
;4036:	advOptMainInfo.banner.generic.x		= 320;
ADDRGP4 advOptMainInfo+424+12
CNSTI4 320
ASGNI4
line 4037
;4037:	advOptMainInfo.banner.generic.y		= 16;
ADDRGP4 advOptMainInfo+424+16
CNSTI4 16
ASGNI4
line 4038
;4038:	advOptMainInfo.banner.string		= "ADVANCED OPTIONS";
ADDRGP4 advOptMainInfo+424+60
ADDRGP4 $2359
ASGNP4
line 4039
;4039:	advOptMainInfo.banner.color			= color_white;
ADDRGP4 advOptMainInfo+424+68
ADDRGP4 color_white
ASGNP4
line 4040
;4040:	advOptMainInfo.banner.style			= UI_CENTER;
ADDRGP4 advOptMainInfo+424+64
CNSTI4 1
ASGNI4
line 4041
;4041:	Menu_AddItem(&advOptMainInfo.menu, &advOptMainInfo.banner);
ADDRGP4 advOptMainInfo
ARGP4
ADDRGP4 advOptMainInfo+424
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 4043
;4042:
;4043:	y = 180;
ADDRLP4 0
CNSTI4 180
ASGNI4
line 4045
;4044:
;4045:	advOptMainInfo.game.generic.type		= MTYPE_PTEXT;
ADDRGP4 advOptMainInfo+496
CNSTI4 9
ASGNI4
line 4046
;4046:	advOptMainInfo.game.generic.x			= 320;
ADDRGP4 advOptMainInfo+496+12
CNSTI4 320
ASGNI4
line 4047
;4047:	advOptMainInfo.game.generic.y			= y;
ADDRGP4 advOptMainInfo+496+16
ADDRLP4 0
INDIRI4
ASGNI4
line 4048
;4048:	advOptMainInfo.game.generic.flags		= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 advOptMainInfo+496+44
CNSTU4 264
ASGNU4
line 4049
;4049:	advOptMainInfo.game.generic.id			= ID_ADVOPT_GAME;
ADDRGP4 advOptMainInfo+496+8
CNSTI4 100
ASGNI4
line 4050
;4050:	advOptMainInfo.game.generic.callback	= UI_AdvOptMainMenu_Event;
ADDRGP4 advOptMainInfo+496+48
ADDRGP4 UI_AdvOptMainMenu_Event
ASGNP4
line 4051
;4051:	advOptMainInfo.game.color				= color_red;
ADDRGP4 advOptMainInfo+496+68
ADDRGP4 color_red
ASGNP4
line 4052
;4052:	advOptMainInfo.game.style				= UI_CENTER|UI_DROPSHADOW;
ADDRGP4 advOptMainInfo+496+64
CNSTI4 2049
ASGNI4
line 4053
;4053:	advOptMainInfo.game.string				= "GAMEPLAY";
ADDRGP4 advOptMainInfo+496+60
ADDRGP4 $3424
ASGNP4
line 4054
;4054:	Menu_AddItem(&advOptMainInfo.menu, &advOptMainInfo.game);
ADDRGP4 advOptMainInfo
ARGP4
ADDRGP4 advOptMainInfo+496
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 4055
;4055:	y += ADVOPTIONS_MAINMENU_SPACING;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 60
ADDI4
ASGNI4
line 4057
;4056:
;4057:	advOptMainInfo.equipment.generic.type		= MTYPE_PTEXT;
ADDRGP4 advOptMainInfo+568
CNSTI4 9
ASGNI4
line 4058
;4058:	advOptMainInfo.equipment.generic.x			= 320;
ADDRGP4 advOptMainInfo+568+12
CNSTI4 320
ASGNI4
line 4059
;4059:	advOptMainInfo.equipment.generic.y			= y;
ADDRGP4 advOptMainInfo+568+16
ADDRLP4 0
INDIRI4
ASGNI4
line 4060
;4060:	advOptMainInfo.equipment.generic.flags		= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 advOptMainInfo+568+44
CNSTU4 264
ASGNU4
line 4061
;4061:	advOptMainInfo.equipment.generic.id			= ID_ADVOPT_EQUIPMENT;
ADDRGP4 advOptMainInfo+568+8
CNSTI4 101
ASGNI4
line 4062
;4062:	advOptMainInfo.equipment.generic.callback	= UI_AdvOptMainMenu_Event;
ADDRGP4 advOptMainInfo+568+48
ADDRGP4 UI_AdvOptMainMenu_Event
ASGNP4
line 4063
;4063:	advOptMainInfo.equipment.color				= color_red;
ADDRGP4 advOptMainInfo+568+68
ADDRGP4 color_red
ASGNP4
line 4064
;4064:	advOptMainInfo.equipment.style				= UI_CENTER|UI_DROPSHADOW;
ADDRGP4 advOptMainInfo+568+64
CNSTI4 2049
ASGNI4
line 4065
;4065:	advOptMainInfo.equipment.string				= "EQUIPMENT";
ADDRGP4 advOptMainInfo+568+60
ADDRGP4 $3443
ASGNP4
line 4066
;4066:	Menu_AddItem(&advOptMainInfo.menu, &advOptMainInfo.equipment);
ADDRGP4 advOptMainInfo
ARGP4
ADDRGP4 advOptMainInfo+568
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 4067
;4067:	y += ADVOPTIONS_MAINMENU_SPACING;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 60
ADDI4
ASGNI4
line 4070
;4068:
;4069:#if MONSTER_MODE
;4070:	advOptMainInfo.monsters.generic.type		= MTYPE_PTEXT;
ADDRGP4 advOptMainInfo+640
CNSTI4 9
ASGNI4
line 4071
;4071:	advOptMainInfo.monsters.generic.x			= 320;
ADDRGP4 advOptMainInfo+640+12
CNSTI4 320
ASGNI4
line 4072
;4072:	advOptMainInfo.monsters.generic.y			= y;
ADDRGP4 advOptMainInfo+640+16
ADDRLP4 0
INDIRI4
ASGNI4
line 4073
;4073:	advOptMainInfo.monsters.generic.flags		= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 advOptMainInfo+640+44
CNSTU4 264
ASGNU4
line 4074
;4074:	advOptMainInfo.monsters.generic.id			= ID_ADVOPT_MONSTERS;
ADDRGP4 advOptMainInfo+640+8
CNSTI4 102
ASGNI4
line 4075
;4075:	advOptMainInfo.monsters.generic.callback	= UI_AdvOptMainMenu_Event;
ADDRGP4 advOptMainInfo+640+48
ADDRGP4 UI_AdvOptMainMenu_Event
ASGNP4
line 4076
;4076:	advOptMainInfo.monsters.color				= color_red;
ADDRGP4 advOptMainInfo+640+68
ADDRGP4 color_red
ASGNP4
line 4077
;4077:	advOptMainInfo.monsters.style				= UI_CENTER|UI_DROPSHADOW;
ADDRGP4 advOptMainInfo+640+64
CNSTI4 2049
ASGNI4
line 4078
;4078:	advOptMainInfo.monsters.string				= "MONSTERS";
ADDRGP4 advOptMainInfo+640+60
ADDRGP4 $3462
ASGNP4
line 4079
;4079:	Menu_AddItem(&advOptMainInfo.menu, &advOptMainInfo.monsters);
ADDRGP4 advOptMainInfo
ARGP4
ADDRGP4 advOptMainInfo+640
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 4080
;4080:	y += ADVOPTIONS_MAINMENU_SPACING;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 60
ADDI4
ASGNI4
line 4083
;4081:#endif
;4082:
;4083:	advOptMainInfo.back.generic.type		= MTYPE_BITMAP;
ADDRGP4 advOptMainInfo+712
CNSTI4 6
ASGNI4
line 4084
;4084:	advOptMainInfo.back.generic.name		= ADVOPT_BACK0;
ADDRGP4 advOptMainInfo+712+4
ADDRGP4 $421
ASGNP4
line 4085
;4085:	advOptMainInfo.back.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 advOptMainInfo+712+44
CNSTU4 260
ASGNU4
line 4086
;4086:	advOptMainInfo.back.generic.callback	= UI_AdvOptMainMenu_BackEvent;
ADDRGP4 advOptMainInfo+712+48
ADDRGP4 UI_AdvOptMainMenu_BackEvent
ASGNP4
line 4087
;4087:	advOptMainInfo.back.generic.x			= 0;
ADDRGP4 advOptMainInfo+712+12
CNSTI4 0
ASGNI4
line 4088
;4088:	advOptMainInfo.back.generic.y			= 480-64;
ADDRGP4 advOptMainInfo+712+16
CNSTI4 416
ASGNI4
line 4089
;4089:	advOptMainInfo.back.width				= 128;
ADDRGP4 advOptMainInfo+712+76
CNSTI4 128
ASGNI4
line 4090
;4090:	advOptMainInfo.back.height				= 64;
ADDRGP4 advOptMainInfo+712+80
CNSTI4 64
ASGNI4
line 4091
;4091:	advOptMainInfo.back.focuspic			= ADVOPT_BACK1;
ADDRGP4 advOptMainInfo+712+60
ADDRGP4 $438
ASGNP4
line 4092
;4092:	Menu_AddItem(&advOptMainInfo.menu, &advOptMainInfo.back);
ADDRGP4 advOptMainInfo
ARGP4
ADDRGP4 advOptMainInfo+712
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 4093
;4093:}
LABELV $3392
endproc UI_AdvOptMainMenu_Init 4 12
export UI_AdvOptMenu
proc UI_AdvOptMenu 0 4
line 4100
;4094:
;4095:/*
;4096:=================
;4097:JUHOX: UI_AdvOptMenu
;4098:=================
;4099:*/
;4100:void UI_AdvOptMenu(void) {
line 4101
;4101:	UI_AdvOptMainMenu_Init();
ADDRGP4 UI_AdvOptMainMenu_Init
CALLV
pop
line 4102
;4102:	UI_PushMenu(&advOptMainInfo.menu);
ADDRGP4 advOptMainInfo
ARGP4
ADDRGP4 UI_PushMenu
CALLV
pop
line 4103
;4103:}
LABELV $3482
endproc UI_AdvOptMenu 0 4
data
align 4
LABELV remote_items
address $3484
address $3485
byte 4 0
code
proc UI_TemplateMenu_Error 0 12
line 4190
;4104:
;4105:
;4106:
;4107:
;4108:
;4109:/*
;4110:=============================================================================
;4111:
;4112:JUHOX: TEMPLATES MENU *****
;4113:
;4114:=============================================================================
;4115:*/
;4116:
;4117:#define TEMPL_BACK0			"menu/art/back_0"
;4118:#define TEMPL_BACK1			"menu/art/back_1"
;4119:#define TEMPL_NEXT0			"menu/art/next_0"
;4120:#define TEMPL_NEXT1			"menu/art/next_1"
;4121:#define TEMPL_VOTE0			"menu/art/vote_0"
;4122:#define TEMPL_VOTE1			"menu/art/vote_1"
;4123:#define TEMPL_DEL0			"menu/art/delete_0"
;4124:#define TEMPL_DEL1			"menu/art/delete_1"
;4125:#define TEMPL_SAVE0			"menu/art/save_0"
;4126:#define TEMPL_SAVE1			"menu/art/save_1"
;4127:#define TEMPL_ARROWS		"menu/art/gs_arrows_0"
;4128:#define TEMPL_ARROWSL		"menu/art/gs_arrows_l"
;4129:#define TEMPL_ARROWSR		"menu/art/gs_arrows_r"
;4130:
;4131:#define NUM_TEMPLATES_PER_PAGE 14
;4132:
;4133:typedef struct {
;4134:	menuframework_s	menu;
;4135:
;4136:	menutext_s		banner;
;4137:
;4138:	menufield_s		name;
;4139:	char			oldName[256];
;4140:
;4141:	menulist_s remote;
;4142:
;4143:	menutext_s		page;
;4144:	menubitmap_s	arrows;
;4145:	menubitmap_s	prevpage;
;4146:	menubitmap_s	nextpage;
;4147:
;4148:	menubitmap_s	back;
;4149:	menubitmap_s	next;
;4150:	menubitmap_s	del;
;4151:	menubitmap_s	save;
;4152:
;4153:	menuaction_s	templateLine[NUM_TEMPLATES_PER_PAGE];
;4154:
;4155:	char error[128];
;4156:	int errorTime;
;4157:	qboolean inGame;
;4158:	qboolean multiplayer;
;4159:	qboolean remoteServer;
;4160:	gametemplatelist_t svList;
;4161:	gametemplatelist_t* currentList;
;4162:	int firstTemplate;
;4163:	int savedFirstTemplate;
;4164:	int selectedTemplate;
;4165:	int gametype;
;4166:	char highscoreLine1[256];
;4167:	char highscoreLine2[MAX_STRING_CHARS];
;4168:	int highscoreLineSetTime;
;4169:	long svlistChecksum;
;4170:	char allChecksums[MAX_GAMETEMPLATES];
;4171:	int lastMsgTime;
;4172:	qboolean isActive;
;4173:	qboolean errorDetected;
;4174:} templateInfo_t;
;4175:
;4176:static templateInfo_t templateInfo;
;4177:
;4178:static const char* remote_items[] = {
;4179:	"local templates",
;4180:	"server's templates",
;4181:	0
;4182:};
;4183:
;4184:
;4185:/*
;4186:=================
;4187:JUHOX: UI_TemplateMenu_Error
;4188:=================
;4189:*/
;4190:static void UI_TemplateMenu_Error(const char* msg) {
line 4191
;4191:	Q_strncpyz(templateInfo.error, msg, sizeof(templateInfo.error));
ADDRGP4 templateInfo+2708
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 4192
;4192:	templateInfo.errorTime = uis.realtime + 5000;
ADDRGP4 templateInfo+2836
ADDRGP4 uis+4
INDIRI4
CNSTI4 5000
ADDI4
ASGNI4
line 4193
;4193:}
LABELV $3486
endproc UI_TemplateMenu_Error 0 12
proc UI_SendTemplateListCommand 12 12
line 4201
;4194:
;4195:/*
;4196:=================
;4197:JUHOX: UI_SendTemplateListCommand
;4198:=================
;4199:*/
;4200:static int tmplcmdCounter;
;4201:static void UI_SendTemplateListCommand(const char* cmd) {
line 4202
;4202:	tmplcmdCounter++;
ADDRLP4 0
ADDRGP4 tmplcmdCounter
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4203
;4203:	tmplcmdCounter &= 15;
ADDRLP4 4
ADDRGP4 tmplcmdCounter
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 15
BANDI4
ASGNI4
line 4205
;4204:
;4205:	trap_Cvar_Set("tmplcmd", va("%c%s", tmplcmdCounter + 'A', cmd));
ADDRGP4 $3493
ARGP4
ADDRGP4 tmplcmdCounter
INDIRI4
CNSTI4 65
ADDI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $3492
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4206
;4206:	templateInfo.lastMsgTime = uis.realtime;
ADDRGP4 templateInfo+86704
ADDRGP4 uis+4
INDIRI4
ASGNI4
line 4207
;4207:}
LABELV $3491
endproc UI_SendTemplateListCommand 12 12
proc UI_Send_TemplateList_Request 4 12
line 4214
;4208:
;4209:/*
;4210:=================
;4211:JUHOX: UI_Send_TemplateList_Request
;4212:=================
;4213:*/
;4214:static void UI_Send_TemplateList_Request(void) {
line 4215
;4215:	if (templateInfo.inGame && templateInfo.remoteServer) {
ADDRGP4 templateInfo+2840
INDIRI4
CNSTI4 0
EQI4 $3497
ADDRGP4 templateInfo+2848
INDIRI4
CNSTI4 0
EQI4 $3497
line 4216
;4216:		UI_SendTemplateListCommand(
ADDRGP4 $3501
ARGP4
ADDRGP4 templateInfo+2852+81540
INDIRI4
ARGI4
ADDRGP4 templateInfo+85700
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 UI_SendTemplateListCommand
CALLV
pop
line 4219
;4217:			va("templatelist_request %d %d\n", templateInfo.svList.numEntries, templateInfo.svlistChecksum)
;4218:		);
;4219:	}
LABELV $3497
line 4220
;4220:}
LABELV $3496
endproc UI_Send_TemplateList_Request 4 12
proc UI_Send_TemplateList_Stop 0 4
line 4227
;4221:
;4222:/*
;4223:=================
;4224:JUHOX: UI_Send_TemplateList_Stop
;4225:=================
;4226:*/
;4227:static void UI_Send_TemplateList_Stop(void) {
line 4228
;4228:	if (templateInfo.inGame && templateInfo.remoteServer) UI_SendTemplateListCommand("templatelist_stop\n");
ADDRGP4 templateInfo+2840
INDIRI4
CNSTI4 0
EQI4 $3506
ADDRGP4 templateInfo+2848
INDIRI4
CNSTI4 0
EQI4 $3506
ADDRGP4 $3510
ARGP4
ADDRGP4 UI_SendTemplateListCommand
CALLV
pop
LABELV $3506
line 4229
;4229:}
LABELV $3505
endproc UI_Send_TemplateList_Stop 0 4
proc UI_Send_TemplateList_Error 1036 8
line 4236
;4230:
;4231:/*
;4232:=================
;4233:JUHOX: UI_Send_TemplateList_Error
;4234:=================
;4235:*/
;4236:static void UI_Send_TemplateList_Error(void) {
line 4237
;4237:	if (templateInfo.inGame && templateInfo.remoteServer) {
ADDRGP4 templateInfo+2840
INDIRI4
CNSTI4 0
EQI4 $3512
ADDRGP4 templateInfo+2848
INDIRI4
CNSTI4 0
EQI4 $3512
line 4241
;4238:		char checksums[MAX_STRING_CHARS];
;4239:		int i;
;4240:
;4241:		for (i = 0; i < templateInfo.svList.numEntries; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3519
JUMPV
LABELV $3516
line 4242
;4242:			checksums[i] = templateInfo.allChecksums[i];
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
ADDRLP4 0
INDIRI4
ADDRGP4 templateInfo+85704
ADDP4
INDIRI1
ASGNI1
line 4243
;4243:		}
LABELV $3517
line 4241
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3519
ADDRLP4 0
INDIRI4
ADDRGP4 templateInfo+2852+81540
INDIRI4
LTI4 $3516
line 4244
;4244:		if (i == 0) checksums[i++] = '*';
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $3523
ADDRLP4 1028
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 0
ADDRLP4 1028
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 1028
INDIRI4
ADDRLP4 4
ADDP4
CNSTI1 42
ASGNI1
LABELV $3523
line 4245
;4245:		checksums[i] = 0;
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
CNSTI1 0
ASGNI1
line 4247
;4246:
;4247:		UI_SendTemplateListCommand(va("templatelist_error \"%s\"", checksums));
ADDRGP4 $3525
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 1032
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1032
INDIRP4
ARGP4
ADDRGP4 UI_SendTemplateListCommand
CALLV
pop
line 4248
;4248:	}
LABELV $3512
line 4249
;4249:}
LABELV $3511
endproc UI_Send_TemplateList_Error 1036 8
proc UI_TemplateMenu_Exit 0 8
line 4256
;4250:
;4251:/*
;4252:=================
;4253:JUHOX: UI_TemplateMenu_Exit
;4254:=================
;4255:*/
;4256:static void UI_TemplateMenu_Exit(void) {
line 4257
;4257:	trap_Cvar_Set("tmplcmd", "");	
ADDRGP4 $3492
ARGP4
ADDRGP4 $99
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4258
;4258:	templateInfo.isActive = qfalse;
ADDRGP4 templateInfo+86708
CNSTI4 0
ASGNI4
line 4259
;4259:}
LABELV $3526
endproc UI_TemplateMenu_Exit 0 8
proc UI_TemplateMenu_ComputeChecksums 2188 16
line 4266
;4260:
;4261:/*
;4262:=================
;4263:JUHOX: UI_TemplateMenu_ComputeChecksums
;4264:=================
;4265:*/
;4266:static void UI_TemplateMenu_ComputeChecksums(void) {
line 4269
;4267:	int i;
;4268:
;4269:	memset(templateInfo.allChecksums, '*', sizeof(templateInfo.allChecksums));
ADDRGP4 templateInfo+85704
ARGP4
CNSTI4 42
ARGI4
CNSTI4 1000
ARGI4
ADDRGP4 memset
CALLP4
pop
line 4271
;4270:
;4271:	templateInfo.svlistChecksum = 0;
ADDRGP4 templateInfo+85700
CNSTI4 0
ASGNI4
line 4272
;4272:	for (i = 0; i < templateInfo.svList.numEntries; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3535
JUMPV
LABELV $3532
line 4280
;4273:		char info[MAX_INFO_STRING];
;4274:		char name[64];
;4275:		int highscoreType;
;4276:		char highscore[32];
;4277:		char descriptor[MAX_INFO_STRING];
;4278:		long checksum;
;4279:
;4280:		trap_Cvar_VariableStringBuffer(templateInfo.svList.entries[i].cvar, info, sizeof(info));
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 templateInfo+2852+65540
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 4281
;4281:		Q_strncpyz(name, Info_ValueForKey(info, "name"), sizeof(name));
ADDRLP4 4
ARGP4
ADDRGP4 $861
ARGP4
ADDRLP4 2156
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
ARGP4
ADDRLP4 2156
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 4282
;4282:		highscoreType = atoi(Info_ValueForKey(info, "ht"));
ADDRLP4 4
ARGP4
ADDRGP4 $3540
ARGP4
ADDRLP4 2160
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 2160
INDIRP4
ARGP4
ADDRLP4 2164
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 2152
ADDRLP4 2164
INDIRI4
ASGNI4
line 4283
;4283:		Q_strncpyz(highscore, Info_ValueForKey(info, "h"), sizeof(highscore));
ADDRLP4 4
ARGP4
ADDRGP4 $3541
ARGP4
ADDRLP4 2168
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1092
ARGP4
ADDRLP4 2168
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 4284
;4284:		Q_strncpyz(descriptor, Info_ValueForKey(info, "d"), sizeof(descriptor));
ADDRLP4 4
ARGP4
ADDRGP4 $3542
ARGP4
ADDRLP4 2172
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1124
ARGP4
ADDRLP4 2172
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 4285
;4285:		checksum = BG_TemplateChecksum(name, highscoreType, highscore, descriptor);
ADDRLP4 1028
ARGP4
ADDRLP4 2152
INDIRI4
ARGI4
ADDRLP4 1092
ARGP4
ADDRLP4 1124
ARGP4
ADDRLP4 2176
ADDRGP4 BG_TemplateChecksum
CALLI4
ASGNI4
ADDRLP4 2148
ADDRLP4 2176
INDIRI4
ASGNI4
line 4286
;4286:		templateInfo.svlistChecksum += checksum;
ADDRLP4 2180
ADDRGP4 templateInfo+85700
ASGNP4
ADDRLP4 2180
INDIRP4
ADDRLP4 2180
INDIRP4
INDIRI4
ADDRLP4 2148
INDIRI4
ADDI4
ASGNI4
line 4287
;4287:		templateInfo.allChecksums[i] = BG_ChecksumChar(checksum);
ADDRLP4 2148
INDIRI4
ARGI4
ADDRLP4 2184
ADDRGP4 BG_ChecksumChar
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRGP4 templateInfo+85704
ADDP4
ADDRLP4 2184
INDIRI4
CVII1 4
ASGNI1
line 4288
;4288:	}
LABELV $3533
line 4272
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3535
ADDRLP4 0
INDIRI4
ADDRGP4 templateInfo+2852+81540
INDIRI4
LTI4 $3532
line 4289
;4289:}
LABELV $3528
endproc UI_TemplateMenu_ComputeChecksums 2188 16
proc UI_TemplateMenu_InitTemplates 8 16
line 4296
;4290:
;4291:/*
;4292:=================
;4293:JUHOX: UI_TemplateMenu_InitTemplates
;4294:=================
;4295:*/
;4296:static void UI_TemplateMenu_InitTemplates(void) {
line 4297
;4297:	if (uis.templateList.numEntries <= 0) {
ADDRGP4 uis+13556+81540
INDIRI4
CNSTI4 0
GTI4 $3546
line 4298
;4298:		BG_GetGameTemplateList(&uis.templateList, uis.numTemplateFiles, uis.templateFileList, qtrue);
ADDRGP4 uis+13556
ARGP4
ADDRGP4 uis+13552
INDIRI4
ARGI4
ADDRGP4 uis+12528
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BG_GetGameTemplateList
CALLV
pop
line 4299
;4299:	}
LABELV $3546
line 4300
;4300:	templateInfo.remoteServer = !trap_Cvar_VariableValue("sv_running");
ADDRGP4 $3554
ARGP4
ADDRLP4 4
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
INDIRF4
CNSTF4 0
NEF4 $3556
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $3557
JUMPV
LABELV $3556
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $3557
ADDRGP4 templateInfo+2848
ADDRLP4 0
INDIRI4
ASGNI4
line 4301
;4301:	if (templateInfo.inGame && templateInfo.remoteServer) {
ADDRGP4 templateInfo+2840
INDIRI4
CNSTI4 0
EQI4 $3558
ADDRGP4 templateInfo+2848
INDIRI4
CNSTI4 0
EQI4 $3558
line 4302
;4302:		BG_GetGameTemplateList(&templateInfo.svList, 0, NULL, qtrue);
ADDRGP4 templateInfo+2852
ARGP4
CNSTI4 0
ARGI4
CNSTP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BG_GetGameTemplateList
CALLV
pop
line 4303
;4303:		UI_TemplateMenu_ComputeChecksums();
ADDRGP4 UI_TemplateMenu_ComputeChecksums
CALLV
pop
line 4304
;4304:		UI_Send_TemplateList_Request();
ADDRGP4 UI_Send_TemplateList_Request
CALLV
pop
line 4305
;4305:		templateInfo.currentList = &templateInfo.svList;
ADDRGP4 templateInfo+84396
ADDRGP4 templateInfo+2852
ASGNP4
line 4306
;4306:	}
ADDRGP4 $3559
JUMPV
LABELV $3558
line 4307
;4307:	else {
line 4308
;4308:		templateInfo.currentList = &uis.templateList;
ADDRGP4 templateInfo+84396
ADDRGP4 uis+13556
ASGNP4
line 4309
;4309:	}
LABELV $3559
line 4310
;4310:}
LABELV $3545
endproc UI_TemplateMenu_InitTemplates 8 16
proc UI_TemplateMenu_Cache 0 4
line 4317
;4311:
;4312:/*
;4313:=================
;4314:JUHOX: UI_TemplateMenu_Cache
;4315:=================
;4316:*/
;4317:static void UI_TemplateMenu_Cache(void) {
line 4318
;4318:	trap_R_RegisterShaderNoMip(TEMPL_BACK0);
ADDRGP4 $421
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 4319
;4319:	trap_R_RegisterShaderNoMip(TEMPL_BACK1);
ADDRGP4 $438
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 4320
;4320:	if (templateInfo.inGame) {
ADDRGP4 templateInfo+2840
INDIRI4
CNSTI4 0
EQI4 $3568
line 4321
;4321:		trap_R_RegisterShaderNoMip(TEMPL_VOTE0);
ADDRGP4 $3571
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 4322
;4322:		trap_R_RegisterShaderNoMip(TEMPL_VOTE1);
ADDRGP4 $3572
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 4323
;4323:		trap_R_RegisterShaderNoMip(TEMPL_SAVE0);
ADDRGP4 $3573
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 4324
;4324:		trap_R_RegisterShaderNoMip(TEMPL_SAVE1);
ADDRGP4 $3574
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 4325
;4325:	}
ADDRGP4 $3569
JUMPV
LABELV $3568
line 4326
;4326:	else {
line 4327
;4327:		trap_R_RegisterShaderNoMip(TEMPL_NEXT0);
ADDRGP4 $442
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 4328
;4328:		trap_R_RegisterShaderNoMip(TEMPL_NEXT1);
ADDRGP4 $459
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 4329
;4329:		trap_R_RegisterShaderNoMip(TEMPL_DEL0);
ADDRGP4 $3575
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 4330
;4330:		trap_R_RegisterShaderNoMip(TEMPL_DEL1);
ADDRGP4 $3576
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 4331
;4331:	}
LABELV $3569
line 4332
;4332:}
LABELV $3567
endproc UI_TemplateMenu_Cache 0 4
bss
align 1
LABELV $3578
skip 256
code
proc HighscoreName 24 12
line 4339
;4333:
;4334:/*
;4335:==================
;4336:JUHOX: HighscoreName
;4337:==================
;4338:*/
;4339:static const char* HighscoreName(const char* highscorename, const char* templatename) {
line 4344
;4340:	static char name[256];
;4341:	int i;
;4342:	int len;
;4343:
;4344:	Q_strncpyz(name, highscorename, sizeof(name));
ADDRGP4 $3578
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 4345
;4345:	if (!name[0]) {
ADDRGP4 $3578
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3579
line 4346
;4346:		Q_strncpyz(name, templatename, sizeof(name));
ADDRGP4 $3578
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 4347
;4347:	}
LABELV $3579
line 4349
;4348:
;4349:	len = strlen(name);
ADDRGP4 $3578
ARGP4
ADDRLP4 8
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 4350
;4350:	for (i = 0; i < len; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3584
JUMPV
LABELV $3581
line 4351
;4351:		if (name[i] >= 'a' && name[i] <= 'z') continue;
ADDRLP4 12
ADDRLP4 0
INDIRI4
ADDRGP4 $3578
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 97
LTI4 $3585
ADDRLP4 12
INDIRI4
CNSTI4 122
GTI4 $3585
ADDRGP4 $3582
JUMPV
LABELV $3585
line 4352
;4352:		if (name[i] >= 'A' && name[i] <= 'Z') continue;
ADDRLP4 16
ADDRLP4 0
INDIRI4
ADDRGP4 $3578
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 65
LTI4 $3587
ADDRLP4 16
INDIRI4
CNSTI4 90
GTI4 $3587
ADDRGP4 $3582
JUMPV
LABELV $3587
line 4353
;4353:		if (name[i] >= '0' && name[i] <= '9') continue;
ADDRLP4 20
ADDRLP4 0
INDIRI4
ADDRGP4 $3578
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 48
LTI4 $3589
ADDRLP4 20
INDIRI4
CNSTI4 57
GTI4 $3589
ADDRGP4 $3582
JUMPV
LABELV $3589
line 4354
;4354:		name[i] = '_';
ADDRLP4 0
INDIRI4
ADDRGP4 $3578
ADDP4
CNSTI1 95
ASGNI1
line 4355
;4355:	}
LABELV $3582
line 4350
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3584
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $3581
line 4356
;4356:	return name;
ADDRGP4 $3578
RETP4
LABELV $3577
endproc HighscoreName 24 12
proc UI_TemplateMenu_SetHighscore 3716 24
line 4364
;4357:}
;4358:
;4359:/*
;4360:=================
;4361:JUHOX: UI_TemplateMenu_SetHighscore
;4362:=================
;4363:*/
;4364:static void UI_TemplateMenu_SetHighscore(void) {
line 4375
;4365:	const char* templateVarName;
;4366:	char info[MAX_INFO_STRING];
;4367:	char highscoreVarName[64];
;4368:	int highscoreType;
;4369:	char highscore[32];
;4370:	char line1[256];
;4371:	char line2[MAX_INFO_STRING];
;4372:	char oldLine1[256];
;4373:	char oldLine2[MAX_STRING_CHARS];
;4374:
;4375:	Q_strncpyz(oldLine1, templateInfo.highscoreLine1, sizeof(oldLine1));
ADDRLP4 2048
ARGP4
ADDRGP4 templateInfo+84416
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 4376
;4376:	Q_strncpyz(oldLine2, templateInfo.highscoreLine2, sizeof(oldLine2));
ADDRLP4 2304
ARGP4
ADDRGP4 templateInfo+84672
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 4377
;4377:	memset(templateInfo.highscoreLine1, 0, sizeof(templateInfo.highscoreLine1));
ADDRGP4 templateInfo+84416
ARGP4
CNSTI4 0
ARGI4
CNSTI4 256
ARGI4
ADDRGP4 memset
CALLP4
pop
line 4378
;4378:	memset(templateInfo.highscoreLine2, 0, sizeof(templateInfo.highscoreLine2));
ADDRGP4 templateInfo+84672
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1024
ARGI4
ADDRGP4 memset
CALLP4
pop
line 4381
;4379:
;4380:	if (
;4381:		templateInfo.selectedTemplate < 0 ||
ADDRGP4 templateInfo+84408
INDIRI4
CNSTI4 0
LTI4 $3603
ADDRGP4 templateInfo+84408
INDIRI4
ADDRGP4 templateInfo+84396
INDIRP4
CNSTI4 81540
ADDP4
INDIRI4
LTI4 $3598
LABELV $3603
line 4383
;4382:		templateInfo.selectedTemplate >= templateInfo.currentList->numEntries
;4383:	) {
line 4384
;4384:		return;
ADDRGP4 $3591
JUMPV
LABELV $3598
line 4387
;4385:	}
;4386:
;4387:	templateVarName = templateInfo.currentList->entries[templateInfo.selectedTemplate].cvar;
ADDRLP4 3616
ADDRGP4 templateInfo+84408
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 templateInfo+84396
INDIRP4
CNSTI4 65540
ADDP4
ADDP4
INDIRP4
ASGNP4
line 4388
;4388:	trap_Cvar_VariableStringBuffer(templateVarName, info, sizeof(info));
ADDRLP4 3616
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 4389
;4389:	highscoreType = atoi(Info_ValueForKey(info, "ht"));
ADDRLP4 0
ARGP4
ADDRGP4 $3540
ARGP4
ADDRLP4 3688
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 3688
INDIRP4
ARGP4
ADDRLP4 3692
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 3684
ADDRLP4 3692
INDIRI4
ASGNI4
line 4390
;4390:	if (templateInfo.inGame && templateInfo.remoteServer) {
ADDRGP4 templateInfo+2840
INDIRI4
CNSTI4 0
EQI4 $3606
ADDRGP4 templateInfo+2848
INDIRI4
CNSTI4 0
EQI4 $3606
line 4391
;4391:		Q_strncpyz(highscore, Info_ValueForKey(info, "h"), sizeof(highscore));
ADDRLP4 0
ARGP4
ADDRGP4 $3541
ARGP4
ADDRLP4 3696
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 3584
ARGP4
ADDRLP4 3696
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 4392
;4392:		Q_strncpyz(line2, Info_ValueForKey(info, "d"), sizeof(line2));
ADDRLP4 0
ARGP4
ADDRGP4 $3542
ARGP4
ADDRLP4 3700
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1024
ARGP4
ADDRLP4 3700
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 4393
;4393:	}
ADDRGP4 $3607
JUMPV
LABELV $3606
line 4394
;4394:	else {
line 4395
;4395:		Q_strncpyz(highscoreVarName, HighscoreName(Info_ValueForKey(info, "hn"), templateVarName), sizeof(highscoreVarName));
ADDRLP4 0
ARGP4
ADDRGP4 $3610
ARGP4
ADDRLP4 3696
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 3696
INDIRP4
ARGP4
ADDRLP4 3616
INDIRP4
ARGP4
ADDRLP4 3700
ADDRGP4 HighscoreName
CALLP4
ASGNP4
ADDRLP4 3620
ARGP4
ADDRLP4 3700
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 4396
;4396:		if (!highscoreVarName[0]) return;
ADDRLP4 3620
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3611
ADDRGP4 $3591
JUMPV
LABELV $3611
line 4397
;4397:		trap_Cvar_VariableStringBuffer(va("%s0", highscoreVarName), highscore, sizeof(highscore));
ADDRGP4 $3613
ARGP4
ADDRLP4 3620
ARGP4
ADDRLP4 3704
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 3704
INDIRP4
ARGP4
ADDRLP4 3584
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 4398
;4398:		trap_Cvar_VariableStringBuffer(va("%s1", highscoreVarName), line2, sizeof(line2));
ADDRGP4 $3614
ARGP4
ADDRLP4 3620
ARGP4
ADDRLP4 3708
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 3708
INDIRP4
ARGP4
ADDRLP4 1024
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 4399
;4399:	}
LABELV $3607
line 4400
;4400:	switch (highscoreType) {
ADDRLP4 3696
ADDRLP4 3684
INDIRI4
ASGNI4
ADDRLP4 3696
INDIRI4
CNSTI4 1
LTI4 $3591
ADDRLP4 3696
INDIRI4
CNSTI4 4
GTI4 $3591
ADDRLP4 3696
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $3637-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $3637
address $3617
address $3622
address $3627
address $3632
code
LABELV $3617
line 4402
;4401:	case GC_score:
;4402:		if (highscore[0]) {
ADDRLP4 3584
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $3618
line 4403
;4403:			Com_sprintf(line1, sizeof(line1), "HIGHSCORE %d", atoi(highscore));
ADDRLP4 3584
ARGP4
ADDRLP4 3700
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 3328
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $3620
ARGP4
ADDRLP4 3700
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 4404
;4404:		}
ADDRGP4 $3616
JUMPV
LABELV $3618
line 4405
;4405:		else {
line 4406
;4406:			Q_strncpyz(line1, "Play to set the first highscore!", sizeof(line1));
ADDRLP4 3328
ARGP4
ADDRGP4 $3621
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 4407
;4407:			line2[0] = 0;
ADDRLP4 1024
CNSTI1 0
ASGNI1
line 4408
;4408:		}
line 4409
;4409:		break;
ADDRGP4 $3616
JUMPV
LABELV $3622
line 4411
;4410:	case GC_time:
;4411:		if (highscore[0]) {
ADDRLP4 3584
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $3623
line 4414
;4412:			int minutes, seconds, msecs;
;4413:
;4414:			msecs = atoi(highscore);
ADDRLP4 3584
ARGP4
ADDRLP4 3712
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 3704
ADDRLP4 3712
INDIRI4
ASGNI4
line 4415
;4415:			seconds = msecs / 1000;
ADDRLP4 3700
ADDRLP4 3704
INDIRI4
CNSTI4 1000
DIVI4
ASGNI4
line 4416
;4416:			minutes = seconds / 60;
ADDRLP4 3708
ADDRLP4 3700
INDIRI4
CNSTI4 60
DIVI4
ASGNI4
line 4417
;4417:			Com_sprintf(
ADDRLP4 3328
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $3625
ARGP4
ADDRLP4 3708
INDIRI4
ARGI4
ADDRLP4 3700
INDIRI4
CNSTI4 60
MODI4
ARGI4
ADDRLP4 3704
INDIRI4
CNSTI4 1000
MODI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 4421
;4418:				line1, sizeof(line1), "RECORD TIME %d:%02d.%03d",
;4419:				minutes, seconds % 60, msecs % 1000
;4420:			);
;4421:		}
ADDRGP4 $3616
JUMPV
LABELV $3623
line 4422
;4422:		else {
line 4423
;4423:			Q_strncpyz(line1, "Play to set the first record time!", sizeof(line1));
ADDRLP4 3328
ARGP4
ADDRGP4 $3626
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 4424
;4424:			line2[0] = 0;
ADDRLP4 1024
CNSTI1 0
ASGNI1
line 4425
;4425:		}
line 4426
;4426:		break;
ADDRGP4 $3616
JUMPV
LABELV $3627
line 4428
;4427:	case GC_distance:
;4428:		if (highscore[0]) {
ADDRLP4 3584
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $3628
line 4431
;4429:			int metres;
;4430:
;4431:			metres = atoi(highscore);
ADDRLP4 3584
ARGP4
ADDRLP4 3704
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 3700
ADDRLP4 3704
INDIRI4
ASGNI4
line 4432
;4432:			Com_sprintf(
ADDRLP4 3328
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $3630
ARGP4
ADDRLP4 3708
ADDRLP4 3700
INDIRI4
ASGNI4
ADDRLP4 3708
INDIRI4
CNSTI4 1000
DIVI4
ARGI4
ADDRLP4 3708
INDIRI4
CNSTI4 1000
MODI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 4436
;4433:				line1, sizeof(line1), "RECORD DISTANCE %d.%03dkm",
;4434:				metres / 1000, metres % 1000
;4435:			);
;4436:		}
ADDRGP4 $3616
JUMPV
LABELV $3628
line 4437
;4437:		else {
line 4438
;4438:			Q_strncpyz(line1, "Play to set the first record distance!", sizeof(line1));
ADDRLP4 3328
ARGP4
ADDRGP4 $3631
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 4439
;4439:			line2[0] = 0;
ADDRLP4 1024
CNSTI1 0
ASGNI1
line 4440
;4440:		}
line 4441
;4441:		break;
ADDRGP4 $3616
JUMPV
LABELV $3632
line 4443
;4442:	case GC_speed:
;4443:		if (highscore[0]) {
ADDRLP4 3584
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $3633
line 4446
;4444:			int speed;
;4445:
;4446:			speed = atoi(highscore);
ADDRLP4 3584
ARGP4
ADDRLP4 3704
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 3700
ADDRLP4 3704
INDIRI4
ASGNI4
line 4447
;4447:			Com_sprintf(
ADDRLP4 3328
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $3635
ARGP4
ADDRLP4 3708
ADDRLP4 3700
INDIRI4
ASGNI4
ADDRLP4 3708
INDIRI4
CNSTI4 1000
DIVI4
ARGI4
ADDRLP4 3708
INDIRI4
CNSTI4 1000
MODI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 4451
;4448:				line1, sizeof(line1), "RECORD SPEED %d.%03d metres per minute",
;4449:				speed / 1000, speed % 1000
;4450:			);
;4451:		}
ADDRGP4 $3616
JUMPV
LABELV $3633
line 4452
;4452:		else {
line 4453
;4453:			Q_strncpyz(line1, "Play to set the first record speed!", sizeof(line1));
ADDRLP4 3328
ARGP4
ADDRGP4 $3636
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 4454
;4454:			line2[0] = 0;
ADDRLP4 1024
CNSTI1 0
ASGNI1
line 4455
;4455:		}
line 4456
;4456:		break;
line 4458
;4457:	default:
;4458:		return;
LABELV $3616
line 4460
;4459:	}
;4460:	Q_strncpyz(templateInfo.highscoreLine1, line1, sizeof(templateInfo.highscoreLine1));
ADDRGP4 templateInfo+84416
ARGP4
ADDRLP4 3328
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 4461
;4461:	Q_strncpyz(templateInfo.highscoreLine2, line2, sizeof(templateInfo.highscoreLine2));
ADDRGP4 templateInfo+84672
ARGP4
ADDRLP4 1024
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 4462
;4462:	if (strcmp(line1, oldLine1) || strcmp(line2, oldLine2)) {
ADDRLP4 3328
ARGP4
ADDRLP4 2048
ARGP4
ADDRLP4 3700
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3700
INDIRI4
CNSTI4 0
NEI4 $3645
ADDRLP4 1024
ARGP4
ADDRLP4 2304
ARGP4
ADDRLP4 3704
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3704
INDIRI4
CNSTI4 0
EQI4 $3643
LABELV $3645
line 4463
;4463:		templateInfo.highscoreLineSetTime = uis.realtime;
ADDRGP4 templateInfo+85696
ADDRGP4 uis+4
INDIRI4
ASGNI4
line 4464
;4464:	}
LABELV $3643
line 4465
;4465:}
LABELV $3591
endproc UI_TemplateMenu_SetHighscore 3716 24
proc UI_TemplateMenu_SetGametype 1036 12
line 4472
;4466:
;4467:/*
;4468:=================
;4469:JUHOX: UI_TemplateMenu_SetGametype
;4470:=================
;4471:*/
;4472:static void UI_TemplateMenu_SetGametype(void) {
line 4476
;4473:	const char* templateVarName;
;4474:	char info[MAX_INFO_STRING];
;4475:
;4476:	if (templateInfo.inGame) return;
ADDRGP4 templateInfo+2840
INDIRI4
CNSTI4 0
EQI4 $3649
ADDRGP4 $3648
JUMPV
LABELV $3649
line 4479
;4477:
;4478:	if (
;4479:		templateInfo.selectedTemplate < 0 ||
ADDRGP4 templateInfo+84408
INDIRI4
CNSTI4 0
LTI4 $3657
ADDRGP4 templateInfo+84408
INDIRI4
ADDRGP4 templateInfo+84396
INDIRP4
CNSTI4 81540
ADDP4
INDIRI4
LTI4 $3652
LABELV $3657
line 4481
;4480:		templateInfo.selectedTemplate >= templateInfo.currentList->numEntries
;4481:	) {
line 4482
;4482:		return;
ADDRGP4 $3648
JUMPV
LABELV $3652
line 4485
;4483:	}
;4484:
;4485:	templateVarName = templateInfo.currentList->entries[templateInfo.selectedTemplate].cvar;
ADDRLP4 1024
ADDRGP4 templateInfo+84408
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 templateInfo+84396
INDIRP4
CNSTI4 65540
ADDP4
ADDP4
INDIRP4
ASGNP4
line 4486
;4486:	trap_Cvar_VariableStringBuffer(templateVarName, info, sizeof(info));
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
line 4488
;4487:
;4488:	templateInfo.gametype = atoi(Info_ValueForKey(info, "gt"));
ADDRLP4 0
ARGP4
ADDRGP4 $3661
ARGP4
ADDRLP4 1028
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRLP4 1032
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 templateInfo+84412
ADDRLP4 1032
INDIRI4
ASGNI4
line 4489
;4489:}
LABELV $3648
endproc UI_TemplateMenu_SetGametype 1036 12
bss
align 1
LABELV $3663
skip 32
code
proc UI_Template_SetMenuItems 20 20
line 4496
;4490:
;4491:/*
;4492:=================
;4493:JUHOX: UI_Template_SetMenuItems
;4494:=================
;4495:*/
;4496:static void UI_Template_SetMenuItems(void) {
line 4500
;4497:	int i;
;4498:	static char pagename[32];
;4499:
;4500:	if (!templateInfo.inGame) {
ADDRGP4 templateInfo+2840
INDIRI4
CNSTI4 0
NEI4 $3664
line 4501
;4501:		templateInfo.currentList = &uis.templateList;
ADDRGP4 templateInfo+84396
ADDRGP4 uis+13556
ASGNP4
line 4502
;4502:	}
ADDRGP4 $3665
JUMPV
LABELV $3664
line 4503
;4503:	else if (templateInfo.remoteServer && templateInfo.remote.curvalue) {
ADDRGP4 templateInfo+2848
INDIRI4
CNSTI4 0
EQI4 $3669
ADDRGP4 templateInfo+1084+64
INDIRI4
CNSTI4 0
EQI4 $3669
line 4504
;4504:		templateInfo.currentList = &templateInfo.svList;
ADDRGP4 templateInfo+84396
ADDRGP4 templateInfo+2852
ASGNP4
line 4505
;4505:	}
ADDRGP4 $3670
JUMPV
LABELV $3669
line 4506
;4506:	else {
line 4507
;4507:		templateInfo.currentList = &uis.templateList;
ADDRGP4 templateInfo+84396
ADDRGP4 uis+13556
ASGNP4
line 4508
;4508:	}
LABELV $3670
LABELV $3665
line 4510
;4509:
;4510:	for (i = 0; i < NUM_TEMPLATES_PER_PAGE; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $3678
line 4511
;4511:	{
line 4514
;4512:		int line;
;4513:
;4514:		line = templateInfo.firstTemplate + i;
ADDRLP4 4
ADDRGP4 templateInfo+84400
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 4516
;4515:
;4516:		if (line >= 0 && line < templateInfo.currentList->numEntries) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3683
ADDRLP4 4
INDIRI4
ADDRGP4 templateInfo+84396
INDIRP4
CNSTI4 81540
ADDP4
INDIRI4
GEI4 $3683
line 4517
;4517:			templateInfo.templateLine[i].generic.flags &= ~(QMF_INACTIVE|QMF_HIDDEN);
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 60
MULI4
ADDRGP4 templateInfo+1868+44
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRU4
CNSTU4 4294946815
BANDU4
ASGNU4
line 4519
;4518:
;4519:			if (templateInfo.inGame && templateInfo.remoteServer && !templateInfo.remote.curvalue) {
ADDRGP4 templateInfo+2840
INDIRI4
CNSTI4 0
EQI4 $3688
ADDRGP4 templateInfo+2848
INDIRI4
CNSTI4 0
EQI4 $3688
ADDRGP4 templateInfo+1084+64
INDIRI4
CNSTI4 0
NEI4 $3688
line 4520
;4520:				templateInfo.templateLine[i].generic.flags |= QMF_GRAYED|QMF_INACTIVE;
ADDRLP4 16
ADDRLP4 0
INDIRI4
CNSTI4 60
MULI4
ADDRGP4 templateInfo+1868+44
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRU4
CNSTU4 24576
BORU4
ASGNU4
line 4521
;4521:			}
ADDRGP4 $3684
JUMPV
LABELV $3688
line 4522
;4522:			else {
line 4523
;4523:				templateInfo.templateLine[i].generic.flags &= ~(QMF_GRAYED|QMF_INACTIVE);
ADDRLP4 16
ADDRLP4 0
INDIRI4
CNSTI4 60
MULI4
ADDRGP4 templateInfo+1868+44
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRU4
CNSTU4 4294942719
BANDU4
ASGNU4
line 4524
;4524:			}
line 4525
;4525:		}
ADDRGP4 $3684
JUMPV
LABELV $3683
line 4526
;4526:		else {
line 4527
;4527:			templateInfo.templateLine[i].generic.flags |= QMF_INACTIVE|QMF_HIDDEN;
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 60
MULI4
ADDRGP4 templateInfo+1868+44
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRU4
CNSTU4 20480
BORU4
ASGNU4
line 4528
;4528:		}
LABELV $3684
line 4529
;4529:	}
LABELV $3679
line 4510
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 14
LTI4 $3678
line 4532
;4530:
;4531:	if (
;4532:		templateInfo.selectedTemplate >= 0 &&
ADDRGP4 templateInfo+84408
INDIRI4
CNSTI4 0
LTI4 $3700
ADDRGP4 templateInfo+84408
INDIRI4
ADDRGP4 templateInfo+84396
INDIRP4
CNSTI4 81540
ADDP4
INDIRI4
GEI4 $3700
ADDRGP4 templateInfo+84408
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 templateInfo+84396
INDIRP4
CNSTI4 65540
ADDP4
ADDP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
EQI4 $3700
ADDRGP4 templateInfo+2840
INDIRI4
CNSTI4 0
EQI4 $3712
ADDRGP4 templateInfo+2848
INDIRI4
CNSTI4 0
EQI4 $3712
ADDRGP4 templateInfo+1084+64
INDIRI4
CNSTI4 0
EQI4 $3700
LABELV $3712
line 4538
;4533:		templateInfo.selectedTemplate < templateInfo.currentList->numEntries &&
;4534:		templateInfo.currentList->entries[templateInfo.selectedTemplate].deletable &&
;4535:		NOT (
;4536:			templateInfo.inGame && templateInfo.remoteServer && !templateInfo.remote.curvalue
;4537:		)
;4538:	) {
line 4539
;4539:		templateInfo.del.generic.flags &= ~(QMF_INACTIVE|QMF_HIDDEN);
ADDRLP4 4
ADDRGP4 templateInfo+1692+44
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRU4
CNSTU4 4294946815
BANDU4
ASGNU4
line 4540
;4540:	}
ADDRGP4 $3701
JUMPV
LABELV $3700
line 4541
;4541:	else {
line 4542
;4542:		templateInfo.del.generic.flags |= QMF_INACTIVE|QMF_HIDDEN;
ADDRLP4 4
ADDRGP4 templateInfo+1692+44
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRU4
CNSTU4 20480
BORU4
ASGNU4
line 4543
;4543:	}
LABELV $3701
line 4545
;4544:
;4545:	if (templateInfo.inGame) {
ADDRGP4 templateInfo+2840
INDIRI4
CNSTI4 0
EQI4 $3717
line 4548
;4546:		qboolean enable;
;4547:
;4548:		enable = qfalse;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 4550
;4549:		if (
;4550:			templateInfo.name.field.buffer[0] &&
ADDRGP4 templateInfo+496+60+12
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $3720
ADDRGP4 templateInfo+496+60+12
ARGP4
ADDRLP4 8
ADDRGP4 Info_Validate
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $3720
line 4552
;4551:			Info_Validate(templateInfo.name.field.buffer)
;4552:		) {
line 4553
;4553:			for (i = 0; i < uis.templateList.numEntries; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3731
JUMPV
LABELV $3728
line 4554
;4554:				if (!Q_stricmp(templateInfo.name.field.buffer, uis.templateList.entries[i].name)) break;
ADDRGP4 templateInfo+496+60+12
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 uis+13556+65540+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $3734
ADDRGP4 $3730
JUMPV
LABELV $3734
line 4555
;4555:			}
LABELV $3729
line 4553
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3731
ADDRLP4 0
INDIRI4
ADDRGP4 uis+13556+81540
INDIRI4
LTI4 $3728
LABELV $3730
line 4556
;4556:			if (i >= uis.templateList.numEntries) enable = qtrue;
ADDRLP4 0
INDIRI4
ADDRGP4 uis+13556+81540
INDIRI4
LTI4 $3742
ADDRLP4 4
CNSTI4 1
ASGNI4
LABELV $3742
line 4557
;4557:		}
LABELV $3720
line 4559
;4558:
;4559:		if (enable) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $3746
line 4560
;4560:			templateInfo.save.generic.flags &= ~(QMF_GRAYED|QMF_INACTIVE);
ADDRLP4 12
ADDRGP4 templateInfo+1780+44
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRU4
CNSTU4 4294942719
BANDU4
ASGNU4
line 4561
;4561:		}
ADDRGP4 $3747
JUMPV
LABELV $3746
line 4562
;4562:		else {
line 4563
;4563:			templateInfo.save.generic.flags |= (QMF_GRAYED|QMF_INACTIVE);
ADDRLP4 12
ADDRGP4 templateInfo+1780+44
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRU4
CNSTU4 24576
BORU4
ASGNU4
line 4564
;4564:		}
LABELV $3747
line 4565
;4565:	}
LABELV $3717
line 4568
;4566:
;4567:	if (
;4568:		templateInfo.currentList->numEntries > 0 &&
ADDRGP4 templateInfo+84396
INDIRP4
CNSTI4 81540
ADDP4
INDIRI4
CNSTI4 0
LEI4 $3752
ADDRGP4 templateInfo+2840
INDIRI4
CNSTI4 0
EQI4 $3760
ADDRGP4 templateInfo+2848
INDIRI4
CNSTI4 0
EQI4 $3760
ADDRGP4 templateInfo+1084+64
INDIRI4
CNSTI4 0
EQI4 $3752
LABELV $3760
line 4572
;4569:		NOT (
;4570:			templateInfo.inGame && templateInfo.remoteServer && !templateInfo.remote.curvalue
;4571:		)
;4572:	) {
line 4573
;4573:		templateInfo.next.generic.flags &= ~(QMF_GRAYED|QMF_INACTIVE);
ADDRLP4 4
ADDRGP4 templateInfo+1604+44
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRU4
CNSTU4 4294942719
BANDU4
ASGNU4
line 4574
;4574:	}
ADDRGP4 $3753
JUMPV
LABELV $3752
line 4575
;4575:	else {
line 4576
;4576:		templateInfo.next.generic.flags |= QMF_GRAYED|QMF_INACTIVE;
ADDRLP4 4
ADDRGP4 templateInfo+1604+44
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRU4
CNSTU4 24576
BORU4
ASGNU4
line 4577
;4577:	}
LABELV $3753
line 4579
;4578:
;4579:	Com_sprintf(
ADDRGP4 $3663
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $3765
ARGP4
ADDRGP4 templateInfo+84400
INDIRI4
CNSTI4 14
DIVI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 templateInfo+84396
INDIRP4
CNSTI4 81540
ADDP4
INDIRI4
CNSTI4 0
GTI4 $3770
ADDRLP4 4
CNSTI4 1
ASGNI4
ADDRGP4 $3771
JUMPV
LABELV $3770
ADDRLP4 4
ADDRGP4 templateInfo+84396
INDIRP4
CNSTI4 81540
ADDP4
INDIRI4
CNSTI4 1
SUBI4
CNSTI4 14
DIVI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3771
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 4586
;4580:		pagename, sizeof(pagename), "Page %d/%d",
;4581:		templateInfo.firstTemplate / NUM_TEMPLATES_PER_PAGE + 1,
;4582:		templateInfo.currentList->numEntries <= 0?
;4583:			1 :
;4584:			(templateInfo.currentList->numEntries - 1) / NUM_TEMPLATES_PER_PAGE + 1
;4585:	);
;4586:	templateInfo.page.string = pagename;
ADDRGP4 templateInfo+1180+60
ADDRGP4 $3663
ASGNP4
line 4588
;4587:
;4588:	UI_TemplateMenu_SetHighscore();
ADDRGP4 UI_TemplateMenu_SetHighscore
CALLV
pop
line 4589
;4589:	UI_TemplateMenu_SetGametype();
ADDRGP4 UI_TemplateMenu_SetGametype
CALLV
pop
line 4590
;4590:}
LABELV $3662
endproc UI_Template_SetMenuItems 20 20
proc UI_TemplateMenu_BackEvent 0 0
line 4597
;4591:
;4592:/*
;4593:=================
;4594:JUHOX: UI_TemplateMenu_BackEvent
;4595:=================
;4596:*/
;4597:static void UI_TemplateMenu_BackEvent(void* ptr, int event) {
line 4598
;4598:	if (event != QM_ACTIVATED) return;
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $3775
ADDRGP4 $3774
JUMPV
LABELV $3775
line 4600
;4599:
;4600:	UI_Send_TemplateList_Stop();
ADDRGP4 UI_Send_TemplateList_Stop
CALLV
pop
line 4601
;4601:	UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 4602
;4602:	templateInfo.isActive = qfalse;
ADDRGP4 templateInfo+86708
CNSTI4 0
ASGNI4
line 4604
;4603:	//UI_TemplateMenu_Exit();
;4604:}
LABELV $3774
endproc UI_TemplateMenu_BackEvent 0 0
proc UI_TemplateMenu_DelEvent 1300 12
line 4611
;4605:
;4606:/*
;4607:=================
;4608:JUHOX: UI_TemplateMenu_DelEvent
;4609:=================
;4610:*/
;4611:static void UI_TemplateMenu_DelEvent(void* ptr, int event) {
line 4614
;4612:	const char* templateVarName;
;4613:
;4614:	if (event != QM_ACTIVATED) return;
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $3779
ADDRGP4 $3778
JUMPV
LABELV $3779
line 4617
;4615:
;4616:	if (
;4617:		templateInfo.selectedTemplate < 0 ||
ADDRGP4 templateInfo+84408
INDIRI4
CNSTI4 0
LTI4 $3787
ADDRGP4 templateInfo+84408
INDIRI4
ADDRGP4 uis+13556+81540
INDIRI4
LTI4 $3781
LABELV $3787
line 4619
;4618:		templateInfo.selectedTemplate >= uis.templateList.numEntries
;4619:	) {
line 4620
;4620:		return;
ADDRGP4 $3778
JUMPV
LABELV $3781
line 4623
;4621:	}
;4622:
;4623:	if (!uis.templateList.entries[templateInfo.selectedTemplate].deletable) return;
ADDRGP4 templateInfo+84408
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 uis+13556+65540+12
ADDP4
INDIRI4
CNSTI4 0
NEI4 $3788
ADDRGP4 $3778
JUMPV
LABELV $3788
line 4625
;4624:
;4625:	templateVarName = uis.templateList.entries[templateInfo.selectedTemplate].cvar;
ADDRLP4 0
ADDRGP4 templateInfo+84408
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 uis+13556+65540
ADDP4
INDIRP4
ASGNP4
line 4627
;4626:
;4627:	{	// delete the highscore
line 4631
;4628:		char info[MAX_INFO_STRING];
;4629:		char highscoreVarName[256];
;4630:
;4631:		trap_Cvar_VariableStringBuffer(templateVarName, info, sizeof(info));
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 260
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 4632
;4632:		Q_strncpyz(highscoreVarName, HighscoreName(Info_ValueForKey(info, "hn"), templateVarName), sizeof(highscoreVarName));
ADDRLP4 260
ARGP4
ADDRGP4 $3610
ARGP4
ADDRLP4 1284
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1284
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1288
ADDRGP4 HighscoreName
CALLP4
ASGNP4
ADDRLP4 4
ARGP4
ADDRLP4 1288
INDIRP4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 4633
;4633:		if (highscoreVarName[0]) {
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $3797
line 4634
;4634:			trap_Cvar_Set(va("%s0", highscoreVarName), "");
ADDRGP4 $3613
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 1292
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1292
INDIRP4
ARGP4
ADDRGP4 $99
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4635
;4635:			trap_Cvar_Set(va("%s1", highscoreVarName), "");
ADDRGP4 $3614
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 1296
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1296
INDIRP4
ARGP4
ADDRGP4 $99
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4636
;4636:		}
LABELV $3797
line 4637
;4637:	}
line 4639
;4638:
;4639:	trap_Cvar_Set(templateVarName, "");
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $99
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4640
;4640:	uis.templateList.numEntries = 0;
ADDRGP4 uis+13556+81540
CNSTI4 0
ASGNI4
line 4641
;4641:	UI_TemplateMenu_InitTemplates();
ADDRGP4 UI_TemplateMenu_InitTemplates
CALLV
pop
line 4643
;4642:
;4643:	if (templateInfo.selectedTemplate >= uis.templateList.numEntries) {
ADDRGP4 templateInfo+84408
INDIRI4
ADDRGP4 uis+13556+81540
INDIRI4
LTI4 $3801
line 4644
;4644:		templateInfo.selectedTemplate = uis.templateList.numEntries - 1;
ADDRGP4 templateInfo+84408
ADDRGP4 uis+13556+81540
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 4645
;4645:	}
LABELV $3801
line 4646
;4646:	if (templateInfo.selectedTemplate < 0) {
ADDRGP4 templateInfo+84408
INDIRI4
CNSTI4 0
GEI4 $3809
line 4647
;4647:		templateInfo.selectedTemplate = 0;
ADDRGP4 templateInfo+84408
CNSTI4 0
ASGNI4
line 4648
;4648:	}
LABELV $3809
line 4649
;4649:	if (templateInfo.firstTemplate >= uis.templateList.numEntries) {
ADDRGP4 templateInfo+84400
INDIRI4
ADDRGP4 uis+13556+81540
INDIRI4
LTI4 $3813
line 4650
;4650:		templateInfo.firstTemplate = uis.templateList.numEntries - 1;
ADDRGP4 templateInfo+84400
ADDRGP4 uis+13556+81540
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 4651
;4651:	}
LABELV $3813
line 4652
;4652:	if (templateInfo.firstTemplate < 0) {
ADDRGP4 templateInfo+84400
INDIRI4
CNSTI4 0
GEI4 $3821
line 4653
;4653:		templateInfo.firstTemplate = 0;
ADDRGP4 templateInfo+84400
CNSTI4 0
ASGNI4
line 4654
;4654:	}
LABELV $3821
line 4656
;4655:
;4656:	UI_Template_SetMenuItems();
ADDRGP4 UI_Template_SetMenuItems
CALLV
pop
line 4657
;4657:}
LABELV $3778
endproc UI_TemplateMenu_DelEvent 1300 12
proc UI_TemplateMenu_SaveEvent 3108 20
line 4664
;4658:
;4659:/*
;4660:=================
;4661:JUHOX: UI_TemplateMenu_SaveEvent
;4662:=================
;4663:*/
;4664:static void UI_TemplateMenu_SaveEvent(void* ptr, int event) {
line 4669
;4665:	char gs[MAX_INFO_STRING];
;4666:	char info[MAX_INFO_STRING];
;4667:	int i;
;4668:
;4669:	if (event != QM_ACTIVATED) return;
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $3826
ADDRGP4 $3825
JUMPV
LABELV $3826
line 4671
;4670:
;4671:	trap_GetConfigString(CS_GAMESETTINGS, gs, sizeof(gs));
CNSTI4 711
ARGI4
ADDRLP4 1028
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigString
CALLI4
pop
line 4673
;4672:
;4673:	Com_sprintf(info, sizeof(info), "name\\%s\\%s", templateInfo.name.field.buffer, gs);
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $3828
ARGP4
ADDRGP4 templateInfo+496+60+12
ARGP4
ADDRLP4 1028
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 4675
;4674:
;4675:	for (i = 0; i < MAX_GAMETEMPLATES; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $3832
line 4679
;4676:		char buf[MAX_STRING_CHARS];
;4677:		char name[32];
;4678:
;4679:		Com_sprintf(name, sizeof(name), "saved%03d", i);
ADDRLP4 2052
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $3836
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 4680
;4680:		trap_Cvar_VariableStringBuffer(name, buf, sizeof(buf));
ADDRLP4 2052
ARGP4
ADDRLP4 2084
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 4681
;4681:		if (!buf[0]) {
ADDRLP4 2084
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3837
line 4682
;4682:			trap_Cvar_Register(NULL, name, "", CVAR_ARCHIVE);
CNSTP4 0
ARGP4
ADDRLP4 2052
ARGP4
ADDRGP4 $99
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 4683
;4683:			trap_Cvar_Set(name, info);
ADDRLP4 2052
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4684
;4684:			uis.templateList.numEntries = 0;
ADDRGP4 uis+13556+81540
CNSTI4 0
ASGNI4
line 4685
;4685:			UI_TemplateMenu_InitTemplates();
ADDRGP4 UI_TemplateMenu_InitTemplates
CALLV
pop
line 4686
;4686:			UI_Template_SetMenuItems();
ADDRGP4 UI_Template_SetMenuItems
CALLV
pop
line 4687
;4687:			return;
ADDRGP4 $3825
JUMPV
LABELV $3837
line 4689
;4688:		}
;4689:	}
LABELV $3833
line 4675
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1000
LTI4 $3832
line 4690
;4690:}
LABELV $3825
endproc UI_TemplateMenu_SaveEvent 3108 20
proc UI_TemplateMenu_NextEvent 1044 12
line 4697
;4691:
;4692:/*
;4693:=================
;4694:JUHOX: UI_TemplateMenu_NextEvent
;4695:=================
;4696:*/
;4697:static void UI_TemplateMenu_NextEvent(void* ptr, int event) {
line 4701
;4698:	const char* templateVar;
;4699:	char info[MAX_INFO_STRING];
;4700:
;4701:	if (event != QM_ACTIVATED) return;
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $3842
ADDRGP4 $3841
JUMPV
LABELV $3842
line 4703
;4702:
;4703:	if (templateInfo.inGame) {
ADDRGP4 templateInfo+2840
INDIRI4
CNSTI4 0
EQI4 $3844
line 4704
;4704:		UI_TemplateMenu_Exit();
ADDRGP4 UI_TemplateMenu_Exit
CALLV
pop
line 4705
;4705:		trap_Cmd_ExecuteText(
ADDRGP4 $3847
ARGP4
ADDRGP4 templateInfo+84408
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 templateInfo+84396
INDIRP4
CNSTI4 65540
ADDP4
ADDP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 1028
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 4712
;4706:			EXEC_APPEND,
;4707:			va(
;4708:				"callvote template %d",
;4709:				templateInfo.currentList->entries[templateInfo.selectedTemplate].originalIndex
;4710:			)
;4711:		);
;4712:		UI_ForceMenuOff();
ADDRGP4 UI_ForceMenuOff
CALLV
pop
line 4713
;4713:		return;
ADDRGP4 $3841
JUMPV
LABELV $3844
line 4716
;4714:	}
;4715:
;4716:	templateVar = templateInfo.currentList->entries[templateInfo.selectedTemplate].cvar;
ADDRLP4 0
ADDRGP4 templateInfo+84408
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 templateInfo+84396
INDIRP4
CNSTI4 65540
ADDP4
ADDP4
INDIRP4
ASGNP4
line 4718
;4717:	
;4718:	trap_Cvar_VariableStringBuffer(templateVar, info, sizeof(info));
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 4720
;4719:
;4720:	if (!BG_ParseGameTemplate(info, &gtmpl)) {
ADDRLP4 4
ARGP4
ADDRGP4 gtmpl
ARGP4
ADDRLP4 1028
ADDRGP4 BG_ParseGameTemplate
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 0
NEI4 $3852
line 4721
;4721:		UI_TemplateMenu_Error("Invalid template.");
ADDRGP4 $3854
ARGP4
ADDRGP4 UI_TemplateMenu_Error
CALLV
pop
line 4722
;4722:		return;
ADDRGP4 $3841
JUMPV
LABELV $3852
line 4725
;4723:	}
;4724:
;4725:	if (gtmpl.mapName[0] && !UI_GetArenaInfoByMap(gtmpl.mapName)) {
ADDRGP4 gtmpl+68
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $3855
ADDRGP4 gtmpl+68
ARGP4
ADDRLP4 1032
ADDRGP4 UI_GetArenaInfoByMap
CALLP4
ASGNP4
ADDRLP4 1032
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3855
line 4726
;4726:		UI_TemplateMenu_Error(va("Unknown map '%s'.", gtmpl.mapName));
ADDRGP4 $3859
ARGP4
ADDRGP4 gtmpl+68
ARGP4
ADDRLP4 1036
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1036
INDIRP4
ARGP4
ADDRGP4 UI_TemplateMenu_Error
CALLV
pop
line 4727
;4727:		return;
ADDRGP4 $3841
JUMPV
LABELV $3855
line 4730
;4728:	}
;4729:
;4730:	trap_Cvar_Set("g_template", templateVar);
ADDRGP4 $105
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4731
;4731:	trap_Cvar_SetValue("g_gameType", gtmpl.gametype);
ADDRGP4 $250
ARGP4
ADDRGP4 gtmpl+64
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 4733
;4732:
;4733:	Q_strncpyz(s_startserver.choosenmap, gtmpl.mapName, sizeof(s_startserver.choosenmap));
ADDRGP4 s_startserver+7752
ARGP4
ADDRGP4 gtmpl+68
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 4734
;4734:	Q_strncpyz(s_startserver.choosenmapname, gtmpl.mapName, sizeof(s_startserver.choosenmapname));
ADDRGP4 s_startserver+7768
ARGP4
ADDRGP4 gtmpl+68
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 4735
;4735:	Q_strupr(s_startserver.choosenmapname);
ADDRGP4 s_startserver+7768
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 4737
;4736:
;4737:	if (gtmpl.tksArmorfragments) trap_Cvar_SetValue("g_armorFragments", gtmpl.armorfragments);
ADDRGP4 gtmpl+460
INDIRI4
CNSTI4 0
EQI4 $3869
ADDRGP4 $758
ARGP4
ADDRGP4 gtmpl+456
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $3869
line 4738
;4738:	if (gtmpl.tksBasehealth) trap_Cvar_SetValue("g_baseHealth", gtmpl.basehealth);
ADDRGP4 gtmpl+276
INDIRI4
CNSTI4 0
EQI4 $3873
ADDRGP4 $772
ARGP4
ADDRGP4 gtmpl+272
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $3873
line 4739
;4739:	if (gtmpl.tksStamina) trap_Cvar_SetValue("g_stamina", gtmpl.stamina);
ADDRGP4 gtmpl+396
INDIRI4
CNSTI4 0
EQI4 $3877
ADDRGP4 $770
ARGP4
ADDRGP4 gtmpl+392
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $3877
line 4740
;4740:	if (gtmpl.tksLightningdamagelimit) trap_Cvar_SetValue("g_lightningDamageLimit", gtmpl.lightningdamagelimit);
ADDRGP4 gtmpl+468
INDIRI4
CNSTI4 0
EQI4 $3881
ADDRGP4 $774
ARGP4
ADDRGP4 gtmpl+464
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $3881
line 4741
;4741:	if (gtmpl.tksDmflags) trap_Cvar_SetValue("dmflags", gtmpl.dmflags);
ADDRGP4 gtmpl+484
INDIRI4
CNSTI4 0
EQI4 $3885
ADDRGP4 $3888
ARGP4
ADDRGP4 gtmpl+480
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $3885
line 4742
;4742:	if (gtmpl.tksSpeed) trap_Cvar_SetValue("g_speed", gtmpl.speed);
ADDRGP4 gtmpl+492
INDIRI4
CNSTI4 0
EQI4 $3890
ADDRGP4 $3893
ARGP4
ADDRGP4 gtmpl+488
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $3890
line 4743
;4743:	if (gtmpl.tksKnockback) trap_Cvar_SetValue("g_knockback", gtmpl.knockback);
ADDRGP4 gtmpl+500
INDIRI4
CNSTI4 0
EQI4 $3895
ADDRGP4 $3898
ARGP4
ADDRGP4 gtmpl+496
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $3895
line 4744
;4744:	if (gtmpl.tksGravity) trap_Cvar_SetValue("g_gravityLatch", gtmpl.gravity);
ADDRGP4 gtmpl+508
INDIRI4
CNSTI4 0
EQI4 $3900
ADDRGP4 $3903
ARGP4
ADDRGP4 gtmpl+504
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
ADDRGP4 $3901
JUMPV
LABELV $3900
line 4745
;4745:	else trap_Cvar_Set("g_gravityLatch", "");
ADDRGP4 $3903
ARGP4
ADDRGP4 $99
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
LABELV $3901
line 4746
;4746:	if (gtmpl.tksTsssafetymode) trap_Cvar_SetValue("tssSafetyModeAllowed", gtmpl.tsssafetymode);
ADDRGP4 gtmpl+444
INDIRI4
CNSTI4 0
EQI4 $3905
ADDRGP4 $769
ARGP4
ADDRGP4 gtmpl+440
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $3905
line 4747
;4747:	if (gtmpl.tksHighscoretype) trap_Cvar_SetValue("sv_pure", 1);
ADDRGP4 gtmpl+152
INDIRI4
CNSTI4 0
EQI4 $3909
ADDRGP4 $784
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $3909
line 4748
;4748:	if (gtmpl.tksGrapple) trap_Cvar_SetValue("g_grapple", gtmpl.grapple);
ADDRGP4 gtmpl+476
INDIRI4
CNSTI4 0
EQI4 $3912
ADDRGP4 $776
ARGP4
ADDRGP4 gtmpl+472
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $3912
line 4750
;4749:#if MONSTER_MODE
;4750:	if (gtmpl.tksScoremode) trap_Cvar_SetValue("g_scoreMode", gtmpl.scoremode);
ADDRGP4 gtmpl+292
INDIRI4
CNSTI4 0
EQI4 $3916
ADDRGP4 $756
ARGP4
ADDRGP4 gtmpl+296
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $3916
line 4753
;4751:#endif
;4752:	
;4753:	switch(gtmpl.gametype) {
ADDRLP4 1036
ADDRGP4 gtmpl+64
INDIRI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
LTI4 $3920
ADDRLP4 1036
INDIRI4
CNSTI4 9
GTI4 $3920
ADDRLP4 1036
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $4232
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $4232
address $3924
address $3961
address $3920
address $3995
address $4040
address $3920
address $3920
address $3920
address $4086
address $4165
code
LABELV $3924
LABELV $3920
line 4756
;4754:	case GT_FFA:
;4755:	default:
;4756:		if (gtmpl.tksFraglimit) trap_Cvar_SetValue("ui_ffa_fraglimit", gtmpl.fraglimit);
ADDRGP4 gtmpl+236
INDIRI4
CNSTI4 0
EQI4 $3925
ADDRGP4 $599
ARGP4
ADDRGP4 gtmpl+232
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $3925
line 4757
;4757:		if (gtmpl.tksTimelimit) trap_Cvar_SetValue("ui_ffa_timelimit", gtmpl.timelimit);
ADDRGP4 gtmpl+244
INDIRI4
CNSTI4 0
EQI4 $3929
ADDRGP4 $600
ARGP4
ADDRGP4 gtmpl+240
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $3929
line 4758
;4758:		if (gtmpl.tksRespawndelay) trap_Cvar_SetValue("ui_ffa_respawndelay", gtmpl.respawndelay);
ADDRGP4 gtmpl+268
INDIRI4
CNSTI4 0
EQI4 $3933
ADDRGP4 $601
ARGP4
ADDRGP4 gtmpl+264
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $3933
line 4759
;4759:		if (gtmpl.tksGameseed) trap_Cvar_SetValue("ui_ffa_gameseed", gtmpl.gameseed);
ADDRGP4 gtmpl+228
INDIRI4
CNSTI4 0
EQI4 $3937
ADDRGP4 $602
ARGP4
ADDRGP4 gtmpl+224
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $3937
line 4760
;4760:		if (gtmpl.tksNoitems) trap_Cvar_SetValue("ui_ffa_noItems", gtmpl.noitems);
ADDRGP4 gtmpl+404
INDIRI4
CNSTI4 0
EQI4 $3941
ADDRGP4 $603
ARGP4
ADDRGP4 gtmpl+400
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $3941
line 4761
;4761:		if (gtmpl.tksNohealthregen) trap_Cvar_SetValue("ui_ffa_noHealthRegen", gtmpl.nohealthregen);
ADDRGP4 gtmpl+412
INDIRI4
CNSTI4 0
EQI4 $3945
ADDRGP4 $604
ARGP4
ADDRGP4 gtmpl+408
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $3945
line 4762
;4762:		if (gtmpl.tksCloakingdevice) trap_Cvar_SetValue("ui_ffa_cloakingDevice", gtmpl.cloakingdevice);
ADDRGP4 gtmpl+420
INDIRI4
CNSTI4 0
EQI4 $3949
ADDRGP4 $606
ARGP4
ADDRGP4 gtmpl+416
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $3949
line 4763
;4763:		if (gtmpl.tksUnlimitedammo) trap_Cvar_SetValue("ui_ffa_unlimitedAmmo", gtmpl.unlimitedammo);
ADDRGP4 gtmpl+428
INDIRI4
CNSTI4 0
EQI4 $3953
ADDRGP4 $605
ARGP4
ADDRGP4 gtmpl+424
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $3953
line 4765
;4764:#if MONSTER_MODE
;4765:		if (gtmpl.tksMonsterlauncher) trap_Cvar_SetValue("ui_ffa_monsterLauncher", gtmpl.monsterLauncher);
ADDRGP4 gtmpl+300
INDIRI4
CNSTI4 0
EQI4 $3921
ADDRGP4 $608
ARGP4
ADDRGP4 gtmpl+288
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 4767
;4766:#endif
;4767:		break;
ADDRGP4 $3921
JUMPV
LABELV $3961
line 4770
;4768:
;4769:	case GT_TOURNAMENT:
;4770:		if (gtmpl.tksFraglimit) trap_Cvar_SetValue("ui_tourney_fraglimit", gtmpl.fraglimit);
ADDRGP4 gtmpl+236
INDIRI4
CNSTI4 0
EQI4 $3962
ADDRGP4 $614
ARGP4
ADDRGP4 gtmpl+232
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $3962
line 4771
;4771:		if (gtmpl.tksTimelimit) trap_Cvar_SetValue("ui_tourney_timelimit", gtmpl.timelimit);
ADDRGP4 gtmpl+244
INDIRI4
CNSTI4 0
EQI4 $3966
ADDRGP4 $615
ARGP4
ADDRGP4 gtmpl+240
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $3966
line 4772
;4772:		if (gtmpl.tksGameseed) trap_Cvar_SetValue("ui_tourney_gamessed", gtmpl.gameseed);
ADDRGP4 gtmpl+228
INDIRI4
CNSTI4 0
EQI4 $3970
ADDRGP4 $3973
ARGP4
ADDRGP4 gtmpl+224
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $3970
line 4773
;4773:		if (gtmpl.tksNoitems) trap_Cvar_SetValue("ui_tourney_noItems", gtmpl.noitems);
ADDRGP4 gtmpl+404
INDIRI4
CNSTI4 0
EQI4 $3975
ADDRGP4 $617
ARGP4
ADDRGP4 gtmpl+400
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $3975
line 4774
;4774:		if (gtmpl.tksNohealthregen) trap_Cvar_SetValue("ui_tourney_noHealthRegen", gtmpl.nohealthregen);
ADDRGP4 gtmpl+412
INDIRI4
CNSTI4 0
EQI4 $3979
ADDRGP4 $618
ARGP4
ADDRGP4 gtmpl+408
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $3979
line 4775
;4775:		if (gtmpl.tksCloakingdevice) trap_Cvar_SetValue("ui_tourney_cloakingDevice", gtmpl.cloakingdevice);
ADDRGP4 gtmpl+420
INDIRI4
CNSTI4 0
EQI4 $3983
ADDRGP4 $620
ARGP4
ADDRGP4 gtmpl+416
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $3983
line 4776
;4776:		if (gtmpl.tksUnlimitedammo) trap_Cvar_SetValue("ui_tourney_unlimitedAmmo", gtmpl.unlimitedammo);
ADDRGP4 gtmpl+428
INDIRI4
CNSTI4 0
EQI4 $3987
ADDRGP4 $619
ARGP4
ADDRGP4 gtmpl+424
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $3987
line 4778
;4777:#if MONSTER_MODE
;4778:		if (gtmpl.tksMonsterlauncher) trap_Cvar_SetValue("ui_tourney_monsterLauncher", gtmpl.monsterLauncher);
ADDRGP4 gtmpl+300
INDIRI4
CNSTI4 0
EQI4 $3921
ADDRGP4 $622
ARGP4
ADDRGP4 gtmpl+288
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 4780
;4779:#endif
;4780:		break;
ADDRGP4 $3921
JUMPV
LABELV $3995
line 4783
;4781:
;4782:	case GT_TEAM:
;4783:		if (gtmpl.tksFraglimit) trap_Cvar_SetValue("ui_team_fraglimit", gtmpl.fraglimit);
ADDRGP4 gtmpl+236
INDIRI4
CNSTI4 0
EQI4 $3996
ADDRGP4 $628
ARGP4
ADDRGP4 gtmpl+232
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $3996
line 4784
;4784:		if (gtmpl.tksTimelimit) trap_Cvar_SetValue("ui_team_timelimit", gtmpl.timelimit);
ADDRGP4 gtmpl+244
INDIRI4
CNSTI4 0
EQI4 $4000
ADDRGP4 $629
ARGP4
ADDRGP4 gtmpl+240
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4000
line 4785
;4785:		if (gtmpl.tksFriendlyfire) trap_Cvar_SetValue("ui_team_friendly", gtmpl.friendlyfire);
ADDRGP4 gtmpl+388
INDIRI4
CNSTI4 0
EQI4 $4004
ADDRGP4 $630
ARGP4
ADDRGP4 gtmpl+384
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4004
line 4786
;4786:		if (gtmpl.tksRespawndelay) trap_Cvar_SetValue("ui_team_respawndelay", gtmpl.respawndelay);
ADDRGP4 gtmpl+268
INDIRI4
CNSTI4 0
EQI4 $4008
ADDRGP4 $631
ARGP4
ADDRGP4 gtmpl+264
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4008
line 4787
;4787:		if (gtmpl.tksGameseed) trap_Cvar_SetValue("ui_team_gameseed", gtmpl.gameseed);
ADDRGP4 gtmpl+228
INDIRI4
CNSTI4 0
EQI4 $4012
ADDRGP4 $632
ARGP4
ADDRGP4 gtmpl+224
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4012
line 4788
;4788:		if (gtmpl.tksTss) trap_Cvar_SetValue("ui_team_tss", gtmpl.tss);
ADDRGP4 gtmpl+436
INDIRI4
CNSTI4 0
EQI4 $4016
ADDRGP4 $633
ARGP4
ADDRGP4 gtmpl+432
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4016
line 4789
;4789:		if (gtmpl.tksNoitems) trap_Cvar_SetValue("ui_team_noItems", gtmpl.noitems);
ADDRGP4 gtmpl+404
INDIRI4
CNSTI4 0
EQI4 $4020
ADDRGP4 $634
ARGP4
ADDRGP4 gtmpl+400
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4020
line 4790
;4790:		if (gtmpl.tksNohealthregen) trap_Cvar_SetValue("ui_team_noHealthRegen", gtmpl.nohealthregen);
ADDRGP4 gtmpl+412
INDIRI4
CNSTI4 0
EQI4 $4024
ADDRGP4 $635
ARGP4
ADDRGP4 gtmpl+408
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4024
line 4791
;4791:		if (gtmpl.tksCloakingdevice) trap_Cvar_SetValue("ui_team_cloakingDevice", gtmpl.cloakingdevice);
ADDRGP4 gtmpl+420
INDIRI4
CNSTI4 0
EQI4 $4028
ADDRGP4 $637
ARGP4
ADDRGP4 gtmpl+416
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4028
line 4792
;4792:		if (gtmpl.tksUnlimitedammo) trap_Cvar_SetValue("ui_team_unlimitedAmmo", gtmpl.unlimitedammo);
ADDRGP4 gtmpl+428
INDIRI4
CNSTI4 0
EQI4 $4032
ADDRGP4 $636
ARGP4
ADDRGP4 gtmpl+424
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4032
line 4794
;4793:#if MONSTER_MODE
;4794:		if (gtmpl.tksMonsterlauncher) trap_Cvar_SetValue("ui_team_monsterLauncher", gtmpl.monsterLauncher);
ADDRGP4 gtmpl+300
INDIRI4
CNSTI4 0
EQI4 $3921
ADDRGP4 $639
ARGP4
ADDRGP4 gtmpl+288
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 4796
;4795:#endif
;4796:		break;
ADDRGP4 $3921
JUMPV
LABELV $4040
line 4799
;4797:
;4798:	case GT_CTF:
;4799:		if (gtmpl.tksFraglimit) trap_Cvar_SetValue("ui_ctf_capturelimit", gtmpl.fraglimit);
ADDRGP4 gtmpl+236
INDIRI4
CNSTI4 0
EQI4 $4041
ADDRGP4 $645
ARGP4
ADDRGP4 gtmpl+232
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4041
line 4800
;4800:		if (gtmpl.tksTimelimit) trap_Cvar_SetValue("ui_ctf_timelimit", gtmpl.timelimit);
ADDRGP4 gtmpl+244
INDIRI4
CNSTI4 0
EQI4 $4045
ADDRGP4 $646
ARGP4
ADDRGP4 gtmpl+240
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4045
line 4801
;4801:		if (gtmpl.tksFriendlyfire) trap_Cvar_SetValue("ui_ctf_friendlyfire", gtmpl.friendlyfire);
ADDRGP4 gtmpl+388
INDIRI4
CNSTI4 0
EQI4 $4049
ADDRGP4 $4052
ARGP4
ADDRGP4 gtmpl+384
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4049
line 4802
;4802:		if (gtmpl.tksRespawndelay) trap_Cvar_SetValue("ui_ctf_respawndelay", gtmpl.respawndelay);
ADDRGP4 gtmpl+268
INDIRI4
CNSTI4 0
EQI4 $4054
ADDRGP4 $648
ARGP4
ADDRGP4 gtmpl+264
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4054
line 4803
;4803:		if (gtmpl.tksGameseed) trap_Cvar_SetValue("ui_ctf_gameseed", gtmpl.gameseed);
ADDRGP4 gtmpl+228
INDIRI4
CNSTI4 0
EQI4 $4058
ADDRGP4 $649
ARGP4
ADDRGP4 gtmpl+224
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4058
line 4804
;4804:		if (gtmpl.tksTss) trap_Cvar_SetValue("ui_ctf_tss", gtmpl.tss);
ADDRGP4 gtmpl+436
INDIRI4
CNSTI4 0
EQI4 $4062
ADDRGP4 $650
ARGP4
ADDRGP4 gtmpl+432
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4062
line 4805
;4805:		if (gtmpl.tksNoitems) trap_Cvar_SetValue("ui_ctf_noItems", gtmpl.noitems);
ADDRGP4 gtmpl+404
INDIRI4
CNSTI4 0
EQI4 $4066
ADDRGP4 $651
ARGP4
ADDRGP4 gtmpl+400
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4066
line 4806
;4806:		if (gtmpl.tksNohealthregen) trap_Cvar_SetValue("ui_ctf_noHealthRegen", gtmpl.nohealthregen);
ADDRGP4 gtmpl+412
INDIRI4
CNSTI4 0
EQI4 $4070
ADDRGP4 $652
ARGP4
ADDRGP4 gtmpl+408
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4070
line 4807
;4807:		if (gtmpl.tksCloakingdevice) trap_Cvar_SetValue("ui_ctf_cloakingDevice", gtmpl.cloakingdevice);
ADDRGP4 gtmpl+420
INDIRI4
CNSTI4 0
EQI4 $4074
ADDRGP4 $654
ARGP4
ADDRGP4 gtmpl+416
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4074
line 4808
;4808:		if (gtmpl.tksUnlimitedammo) trap_Cvar_SetValue("ui_ctf_unlimitedAmmo", gtmpl.unlimitedammo);
ADDRGP4 gtmpl+428
INDIRI4
CNSTI4 0
EQI4 $4078
ADDRGP4 $653
ARGP4
ADDRGP4 gtmpl+424
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4078
line 4810
;4809:#if MONSTER_MODE
;4810:		if (gtmpl.tksMonsterlauncher) trap_Cvar_SetValue("ui_ctf_monsterLauncher", gtmpl.monsterLauncher);
ADDRGP4 gtmpl+300
INDIRI4
CNSTI4 0
EQI4 $3921
ADDRGP4 $656
ARGP4
ADDRGP4 gtmpl+288
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 4812
;4811:#endif
;4812:		break;
ADDRGP4 $3921
JUMPV
LABELV $4086
line 4816
;4813:
;4814:#if MONSTER_MODE	// JUHOX: set STU ui cvars
;4815:	case GT_STU:
;4816:		if (gtmpl.tksFraglimit) trap_Cvar_SetValue("ui_stu_fraglimit", gtmpl.fraglimit);
ADDRGP4 gtmpl+236
INDIRI4
CNSTI4 0
EQI4 $4087
ADDRGP4 $662
ARGP4
ADDRGP4 gtmpl+232
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4087
line 4817
;4817:		if (gtmpl.tksTimelimit) trap_Cvar_SetValue("ui_stu_timelimit", gtmpl.timelimit);
ADDRGP4 gtmpl+244
INDIRI4
CNSTI4 0
EQI4 $4091
ADDRGP4 $663
ARGP4
ADDRGP4 gtmpl+240
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4091
line 4818
;4818:		if (gtmpl.tksArtefacts) trap_Cvar_SetValue("ui_stu_artefacts", gtmpl.artefacts);
ADDRGP4 gtmpl+260
INDIRI4
CNSTI4 0
EQI4 $4095
ADDRGP4 $700
ARGP4
ADDRGP4 gtmpl+256
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4095
line 4819
;4819:		if (gtmpl.tksFriendlyfire) trap_Cvar_SetValue("ui_stu_friendly", gtmpl.friendlyfire);
ADDRGP4 gtmpl+388
INDIRI4
CNSTI4 0
EQI4 $4099
ADDRGP4 $664
ARGP4
ADDRGP4 gtmpl+384
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4099
line 4820
;4820:		if (gtmpl.tksRespawndelay) trap_Cvar_SetValue("ui_stu_respawndelay", gtmpl.respawndelay);
ADDRGP4 gtmpl+268
INDIRI4
CNSTI4 0
EQI4 $4103
ADDRGP4 $665
ARGP4
ADDRGP4 gtmpl+264
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4103
line 4821
;4821:		if (gtmpl.tksGameseed) trap_Cvar_SetValue("ui_stu_gameseed", gtmpl.gameseed);
ADDRGP4 gtmpl+228
INDIRI4
CNSTI4 0
EQI4 $4107
ADDRGP4 $666
ARGP4
ADDRGP4 gtmpl+224
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4107
line 4822
;4822:		if (gtmpl.tksNoitems) trap_Cvar_SetValue("ui_stu_noItems", gtmpl.noitems);
ADDRGP4 gtmpl+404
INDIRI4
CNSTI4 0
EQI4 $4111
ADDRGP4 $667
ARGP4
ADDRGP4 gtmpl+400
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4111
line 4823
;4823:		if (gtmpl.tksNohealthregen) trap_Cvar_SetValue("ui_stu_noHealthRegen", gtmpl.nohealthregen);
ADDRGP4 gtmpl+412
INDIRI4
CNSTI4 0
EQI4 $4115
ADDRGP4 $668
ARGP4
ADDRGP4 gtmpl+408
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4115
line 4824
;4824:		if (gtmpl.tksCloakingdevice) trap_Cvar_SetValue("ui_stu_cloakingDevice", gtmpl.cloakingdevice);
ADDRGP4 gtmpl+420
INDIRI4
CNSTI4 0
EQI4 $4119
ADDRGP4 $670
ARGP4
ADDRGP4 gtmpl+416
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4119
line 4825
;4825:		if (gtmpl.tksUnlimitedammo) trap_Cvar_SetValue("ui_stu_unlimitedAmmo", gtmpl.unlimitedammo);
ADDRGP4 gtmpl+428
INDIRI4
CNSTI4 0
EQI4 $4123
ADDRGP4 $669
ARGP4
ADDRGP4 gtmpl+424
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4123
line 4827
;4826:
;4827:		if (gtmpl.tksMinmonsters) trap_Cvar_SetValue("ui_stu_minmonsters", gtmpl.minmonsters);
ADDRGP4 gtmpl+316
INDIRI4
CNSTI4 0
EQI4 $4127
ADDRGP4 $4130
ARGP4
ADDRGP4 gtmpl+312
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4127
line 4828
;4828:		if (gtmpl.tksMaxmonsters) trap_Cvar_SetValue("ui_stu_maxmonsters", gtmpl.maxmonsters);
ADDRGP4 gtmpl+324
INDIRI4
CNSTI4 0
EQI4 $4132
ADDRGP4 $4135
ARGP4
ADDRGP4 gtmpl+320
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4132
line 4829
;4829:		if (gtmpl.tksMonsterspertrap) trap_Cvar_SetValue("ui_stu_monstersPerTrap", gtmpl.monsterspertrap);
ADDRGP4 gtmpl+332
INDIRI4
CNSTI4 0
EQI4 $4137
ADDRGP4 $675
ARGP4
ADDRGP4 gtmpl+328
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4137
line 4830
;4830:		if (gtmpl.tksMonsterspawndelay) trap_Cvar_SetValue("ui_stu_monsterSpawnDelay", gtmpl.monsterspawndelay);
ADDRGP4 gtmpl+340
INDIRI4
CNSTI4 0
EQI4 $4141
ADDRGP4 $679
ARGP4
ADDRGP4 gtmpl+336
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4141
line 4831
;4831:		if (gtmpl.tksMonsterhealthscale) trap_Cvar_SetValue("ui_stu_monsterHealthScale", gtmpl.monsterhealthscale);
ADDRGP4 gtmpl+348
INDIRI4
CNSTI4 0
EQI4 $4145
ADDRGP4 $683
ARGP4
ADDRGP4 gtmpl+344
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4145
line 4832
;4832:		if (gtmpl.tksMonsterprogessivehealth) trap_Cvar_SetValue("ui_stu_monsterProgression", gtmpl.monsterprogressivehealth);
ADDRGP4 gtmpl+356
INDIRI4
CNSTI4 0
EQI4 $4149
ADDRGP4 $684
ARGP4
ADDRGP4 gtmpl+352
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4149
line 4833
;4833:		if (gtmpl.tksGuards) trap_Cvar_SetValue("ui_stu_monsterGuards", gtmpl.guards);
ADDRGP4 gtmpl+364
INDIRI4
CNSTI4 0
EQI4 $4153
ADDRGP4 $688
ARGP4
ADDRGP4 gtmpl+360
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4153
line 4834
;4834:		if (gtmpl.tksTitans) trap_Cvar_SetValue("ui_stu_monsterTitans", gtmpl.titans);
ADDRGP4 gtmpl+372
INDIRI4
CNSTI4 0
EQI4 $4157
ADDRGP4 $692
ARGP4
ADDRGP4 gtmpl+368
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4157
line 4835
;4835:		if (gtmpl.tksMonsterbreeding) trap_Cvar_SetValue("ui_stu_monsterBreeding", gtmpl.monsterbreeding);
ADDRGP4 gtmpl+380
INDIRI4
CNSTI4 0
EQI4 $3921
ADDRGP4 $696
ARGP4
ADDRGP4 gtmpl+376
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 4836
;4836:		break;
ADDRGP4 $3921
JUMPV
LABELV $4165
line 4841
;4837:#endif
;4838:
;4839:#if ESCAPE_MODE	// JUHOX: set EFH ui cvars
;4840:	case GT_EFH:
;4841:		if (gtmpl.tksFraglimit) trap_Cvar_SetValue("ui_efh_fraglimit", gtmpl.fraglimit);
ADDRGP4 gtmpl+236
INDIRI4
CNSTI4 0
EQI4 $4166
ADDRGP4 $712
ARGP4
ADDRGP4 gtmpl+232
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4166
line 4842
;4842:		if (gtmpl.tksTimelimit) trap_Cvar_SetValue("ui_efh_timelimit", gtmpl.timelimit);
ADDRGP4 gtmpl+244
INDIRI4
CNSTI4 0
EQI4 $4170
ADDRGP4 $713
ARGP4
ADDRGP4 gtmpl+240
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4170
line 4843
;4843:		if (gtmpl.tksDistancelimit) trap_Cvar_SetValue("ui_efh_distancelimit", gtmpl.distancelimit);
ADDRGP4 gtmpl+252
INDIRI4
CNSTI4 0
EQI4 $4174
ADDRGP4 $714
ARGP4
ADDRGP4 gtmpl+248
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4174
line 4844
;4844:		if (gtmpl.tksFriendlyfire) trap_Cvar_SetValue("ui_efh_friendly", gtmpl.friendlyfire);
ADDRGP4 gtmpl+388
INDIRI4
CNSTI4 0
EQI4 $4178
ADDRGP4 $722
ARGP4
ADDRGP4 gtmpl+384
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4178
line 4845
;4845:		if (gtmpl.tksRespawndelay) trap_Cvar_SetValue("ui_efh_respawndelay", gtmpl.respawndelay);
ADDRGP4 gtmpl+268
INDIRI4
CNSTI4 0
EQI4 $4182
ADDRGP4 $4185
ARGP4
ADDRGP4 gtmpl+264
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4182
line 4846
;4846:		if (gtmpl.tksChallengingEnv) trap_Cvar_SetValue("ui_efh_challengingenv", gtmpl.challengingEnv);
ADDRGP4 gtmpl+284
INDIRI4
CNSTI4 0
EQI4 $4187
ADDRGP4 $4190
ARGP4
ADDRGP4 gtmpl+280
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4187
line 4847
;4847:		if (gtmpl.tksGameseed) trap_Cvar_SetValue("ui_efh_gameseed", gtmpl.gameseed);
ADDRGP4 gtmpl+228
INDIRI4
CNSTI4 0
EQI4 $4192
ADDRGP4 $723
ARGP4
ADDRGP4 gtmpl+224
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4192
line 4848
;4848:		if (gtmpl.tksNoitems) trap_Cvar_SetValue("ui_efh_noItems", gtmpl.noitems);
ADDRGP4 gtmpl+404
INDIRI4
CNSTI4 0
EQI4 $4196
ADDRGP4 $724
ARGP4
ADDRGP4 gtmpl+400
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4196
line 4849
;4849:		if (gtmpl.tksNohealthregen) trap_Cvar_SetValue("ui_efh_noHealthRegen", gtmpl.nohealthregen);
ADDRGP4 gtmpl+412
INDIRI4
CNSTI4 0
EQI4 $4200
ADDRGP4 $725
ARGP4
ADDRGP4 gtmpl+408
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4200
line 4850
;4850:		if (gtmpl.tksCloakingdevice) trap_Cvar_SetValue("ui_efh_cloakingDevice", gtmpl.cloakingdevice);
ADDRGP4 gtmpl+420
INDIRI4
CNSTI4 0
EQI4 $4204
ADDRGP4 $727
ARGP4
ADDRGP4 gtmpl+416
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4204
line 4851
;4851:		if (gtmpl.tksUnlimitedammo) trap_Cvar_SetValue("ui_efh_unlimitedAmmo", gtmpl.unlimitedammo);
ADDRGP4 gtmpl+428
INDIRI4
CNSTI4 0
EQI4 $4208
ADDRGP4 $726
ARGP4
ADDRGP4 gtmpl+424
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4208
line 4853
;4852:
;4853:		if (gtmpl.tksMonsterload) trap_Cvar_SetValue("ui_efh_monsterLoad", gtmpl.monsterLoad);
ADDRGP4 gtmpl+308
INDIRI4
CNSTI4 0
EQI4 $4212
ADDRGP4 $729
ARGP4
ADDRGP4 gtmpl+304
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4212
line 4854
;4854:		if (gtmpl.tksMonsterhealthscale) trap_Cvar_SetValue("ui_efh_monsterHealthScale", gtmpl.monsterhealthscale);
ADDRGP4 gtmpl+348
INDIRI4
CNSTI4 0
EQI4 $4216
ADDRGP4 $743
ARGP4
ADDRGP4 gtmpl+344
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4216
line 4855
;4855:		if (gtmpl.tksMonsterprogessivehealth) trap_Cvar_SetValue("ui_efh_monsterProgression", gtmpl.monsterprogressivehealth);
ADDRGP4 gtmpl+356
INDIRI4
CNSTI4 0
EQI4 $4220
ADDRGP4 $744
ARGP4
ADDRGP4 gtmpl+352
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4220
line 4856
;4856:		if (gtmpl.tksGuards) trap_Cvar_SetValue("ui_efh_monsterGuards", gtmpl.guards);
ADDRGP4 gtmpl+364
INDIRI4
CNSTI4 0
EQI4 $4224
ADDRGP4 $737
ARGP4
ADDRGP4 gtmpl+360
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
LABELV $4224
line 4857
;4857:		if (gtmpl.tksTitans) trap_Cvar_SetValue("ui_efh_monsterTitans", gtmpl.titans);
ADDRGP4 gtmpl+372
INDIRI4
CNSTI4 0
EQI4 $3921
ADDRGP4 $740
ARGP4
ADDRGP4 gtmpl+368
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 4858
;4858:		break;
LABELV $3921
line 4862
;4859:#endif
;4860:	}
;4861:
;4862:	if (gtmpl.mapName[0]) {
ADDRGP4 gtmpl+68
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $4233
line 4863
;4863:		UI_ServerOptionsMenu(templateInfo.multiplayer);
ADDRGP4 templateInfo+2844
INDIRI4
ARGI4
ADDRGP4 UI_ServerOptionsMenu
CALLV
pop
line 4864
;4864:	}
ADDRGP4 $4234
JUMPV
LABELV $4233
line 4865
;4865:	else {
line 4866
;4866:		initialGameType = gtmpl.gametype;
ADDRGP4 initialGameType
ADDRGP4 gtmpl+64
INDIRI4
ASGNI4
line 4867
;4867:		UI_StartServerMenu(templateInfo.multiplayer);	
ADDRGP4 templateInfo+2844
INDIRI4
ARGI4
ADDRGP4 UI_StartServerMenu
CALLV
pop
line 4868
;4868:	}
LABELV $4234
line 4869
;4869:	UI_TemplateMenu_Exit();
ADDRGP4 UI_TemplateMenu_Exit
CALLV
pop
line 4870
;4870:}
LABELV $3841
endproc UI_TemplateMenu_NextEvent 1044 12
proc UI_TemplateMenu_TemplateLineDraw 52 20
line 4878
;4871:
;4872:/*
;4873:=================
;4874:JUHOX: UI_TemplateMenu_TemplateLineDraw
;4875:=================
;4876:*/
;4877:static void UI_TemplateMenu_TemplateLineDraw(void* self)
;4878:{
line 4886
;4879:	int x, y;
;4880:	menuaction_s* item;
;4881:	int line;
;4882:	qboolean hasFocus;
;4883:	vec4_t color;
;4884:	int style;
;4885:
;4886:	item = (menuaction_s*) self;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 4887
;4887:	x = item->generic.x;
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 4888
;4888:	y = item->generic.y;
ADDRLP4 24
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 4889
;4889:	hasFocus = item->generic.parent->cursor == item->generic.menuPosition;
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
NEI4 $4241
ADDRLP4 40
CNSTI4 1
ASGNI4
ADDRGP4 $4242
JUMPV
LABELV $4241
ADDRLP4 40
CNSTI4 0
ASGNI4
LABELV $4242
ADDRLP4 36
ADDRLP4 40
INDIRI4
ASGNI4
line 4890
;4890:	line = templateInfo.firstTemplate + item->generic.id;
ADDRLP4 20
ADDRGP4 templateInfo+84400
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDI4
ASGNI4
line 4891
;4891:	if (line < 0 || line >= templateInfo.currentList->numEntries) return;
ADDRLP4 20
INDIRI4
CNSTI4 0
LTI4 $4247
ADDRLP4 20
INDIRI4
ADDRGP4 templateInfo+84396
INDIRP4
CNSTI4 81540
ADDP4
INDIRI4
LTI4 $4244
LABELV $4247
ADDRGP4 $4239
JUMPV
LABELV $4244
line 4893
;4892:
;4893:	style = 0;
ADDRLP4 28
CNSTI4 0
ASGNI4
line 4894
;4894:	if (item->generic.flags & QMF_GRAYED) {
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 8192
BANDU4
CNSTU4 0
EQU4 $4248
line 4895
;4895:		Vector4Copy(text_color_disabled, color);
ADDRLP4 4
ADDRGP4 text_color_disabled
INDIRF4
ASGNF4
ADDRLP4 4+4
ADDRGP4 text_color_disabled+4
INDIRF4
ASGNF4
ADDRLP4 4+8
ADDRGP4 text_color_disabled+8
INDIRF4
ASGNF4
ADDRLP4 4+12
ADDRGP4 text_color_disabled+12
INDIRF4
ASGNF4
line 4896
;4896:	}
ADDRGP4 $4249
JUMPV
LABELV $4248
line 4897
;4897:	else {
line 4898
;4898:		if (hasFocus) {
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $4256
line 4899
;4899:			Vector4Copy(text_color_highlight, color);
ADDRLP4 4
ADDRGP4 text_color_highlight
INDIRF4
ASGNF4
ADDRLP4 4+4
ADDRGP4 text_color_highlight+4
INDIRF4
ASGNF4
ADDRLP4 4+8
ADDRGP4 text_color_highlight+8
INDIRF4
ASGNF4
ADDRLP4 4+12
ADDRGP4 text_color_highlight+12
INDIRF4
ASGNF4
line 4900
;4900:			style = UI_PULSE;
ADDRLP4 28
CNSTI4 16384
ASGNI4
line 4901
;4901:		}
ADDRGP4 $4257
JUMPV
LABELV $4256
line 4902
;4902:		else {
line 4903
;4903:			Vector4Copy(text_color_normal, color);
ADDRLP4 4
ADDRGP4 text_color_normal
INDIRF4
ASGNF4
ADDRLP4 4+4
ADDRGP4 text_color_normal+4
INDIRF4
ASGNF4
ADDRLP4 4+8
ADDRGP4 text_color_normal+8
INDIRF4
ASGNF4
ADDRLP4 4+12
ADDRGP4 text_color_normal+12
INDIRF4
ASGNF4
line 4904
;4904:		}
LABELV $4257
line 4906
;4905:
;4906:		if (line == templateInfo.selectedTemplate) {
ADDRLP4 20
INDIRI4
ADDRGP4 templateInfo+84408
INDIRI4
NEI4 $4270
line 4907
;4907:			UI_FillRect(0, y, 640, SMALLCHAR_HEIGHT, listbar_color);
CNSTF4 0
ARGF4
ADDRLP4 24
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1142947840
ARGF4
CNSTF4 1098907648
ARGF4
ADDRGP4 listbar_color
ARGP4
ADDRGP4 UI_FillRect
CALLV
pop
line 4908
;4908:			Vector4Copy(colorWhite, color);
ADDRLP4 4
ADDRGP4 colorWhite
INDIRF4
ASGNF4
ADDRLP4 4+4
ADDRGP4 colorWhite+4
INDIRF4
ASGNF4
ADDRLP4 4+8
ADDRGP4 colorWhite+8
INDIRF4
ASGNF4
ADDRLP4 4+12
ADDRGP4 colorWhite+12
INDIRF4
ASGNF4
line 4909
;4909:		}
LABELV $4270
line 4910
;4910:	}
LABELV $4249
line 4911
;4911:	UI_DrawString(x + 40, y, templateInfo.currentList->entries[line].name, UI_SMALLFONT | style, color);
ADDRLP4 32
INDIRI4
CNSTI4 40
ADDI4
ARGI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 20
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 templateInfo+84396
INDIRP4
CNSTI4 65540
ADDP4
ADDP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 28
INDIRI4
CNSTI4 16
BORI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 4912
;4912:}
LABELV $4239
endproc UI_TemplateMenu_TemplateLineDraw 52 20
proc UI_TemplateMenu_TemplateLineEvent 0 0
line 4920
;4913:
;4914:/*
;4915:=================
;4916:JUHOX: UI_TemplateMenu_TemplateLineEvent
;4917:=================
;4918:*/
;4919:static void UI_TemplateMenu_TemplateLineEvent(void* ptr, int event)
;4920:{
line 4921
;4921:	if (event == QM_ACTIVATED)
ADDRFP4 4
INDIRI4
CNSTI4 3
NEI4 $4281
line 4922
;4922:	{
line 4923
;4923:		templateInfo.selectedTemplate = templateInfo.firstTemplate + ((menucommon_s*)ptr)->id;
ADDRGP4 templateInfo+84408
ADDRGP4 templateInfo+84400
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDI4
ASGNI4
line 4924
;4924:		UI_Template_SetMenuItems();
ADDRGP4 UI_Template_SetMenuItems
CALLV
pop
line 4925
;4925:	}
LABELV $4281
line 4926
;4926:}
LABELV $4280
endproc UI_TemplateMenu_TemplateLineEvent 0 0
proc UI_TemplateMenu_PrevPageEvent 8 0
line 4933
;4927:
;4928:/*
;4929:=================
;4930:JUHOX: UI_TemplateMenu_PrevPageEvent
;4931:=================
;4932:*/
;4933:static void UI_TemplateMenu_PrevPageEvent(void* ptr, int event) {
line 4934
;4934:	if (event == QM_ACTIVATED)
ADDRFP4 4
INDIRI4
CNSTI4 3
NEI4 $4286
line 4935
;4935:	{
line 4936
;4936:		if (templateInfo.firstTemplate >= NUM_TEMPLATES_PER_PAGE) {
ADDRGP4 templateInfo+84400
INDIRI4
CNSTI4 14
LTI4 $4288
line 4937
;4937:			templateInfo.firstTemplate -= NUM_TEMPLATES_PER_PAGE;
ADDRLP4 0
ADDRGP4 templateInfo+84400
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 14
SUBI4
ASGNI4
line 4940
;4938:
;4939:			if (
;4940:				!templateInfo.inGame ||
ADDRGP4 templateInfo+2840
INDIRI4
CNSTI4 0
EQI4 $4299
ADDRGP4 templateInfo+2848
INDIRI4
CNSTI4 0
EQI4 $4299
ADDRGP4 templateInfo+1084+64
INDIRI4
CNSTI4 0
EQI4 $4292
LABELV $4299
line 4943
;4941:				!templateInfo.remoteServer ||
;4942:				templateInfo.remote.curvalue
;4943:			) {
line 4944
;4944:				templateInfo.selectedTemplate -= NUM_TEMPLATES_PER_PAGE;
ADDRLP4 4
ADDRGP4 templateInfo+84408
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 14
SUBI4
ASGNI4
line 4945
;4945:				if (templateInfo.selectedTemplate < 0) templateInfo.selectedTemplate = 0;
ADDRGP4 templateInfo+84408
INDIRI4
CNSTI4 0
GEI4 $4301
ADDRGP4 templateInfo+84408
CNSTI4 0
ASGNI4
LABELV $4301
line 4946
;4946:			}
LABELV $4292
line 4947
;4947:		}
LABELV $4288
line 4948
;4948:		UI_Template_SetMenuItems();
ADDRGP4 UI_Template_SetMenuItems
CALLV
pop
line 4949
;4949:	}
LABELV $4286
line 4950
;4950:}
LABELV $4285
endproc UI_TemplateMenu_PrevPageEvent 8 0
proc UI_TemplateMenu_NextPageEvent 8 0
line 4957
;4951:
;4952:/*
;4953:=================
;4954:JUHOX: UI_TemplateMenu_NextPageEvent
;4955:=================
;4956:*/
;4957:static void UI_TemplateMenu_NextPageEvent(void* ptr, int event) {
line 4958
;4958:	if (event == QM_ACTIVATED)
ADDRFP4 4
INDIRI4
CNSTI4 3
NEI4 $4306
line 4959
;4959:	{
line 4960
;4960:		if (templateInfo.firstTemplate < templateInfo.currentList->numEntries - NUM_TEMPLATES_PER_PAGE) {
ADDRGP4 templateInfo+84400
INDIRI4
ADDRGP4 templateInfo+84396
INDIRP4
CNSTI4 81540
ADDP4
INDIRI4
CNSTI4 14
SUBI4
GEI4 $4308
line 4961
;4961:			templateInfo.firstTemplate += NUM_TEMPLATES_PER_PAGE;
ADDRLP4 0
ADDRGP4 templateInfo+84400
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 14
ADDI4
ASGNI4
line 4964
;4962:
;4963:			if (
;4964:				!templateInfo.inGame ||
ADDRGP4 templateInfo+2840
INDIRI4
CNSTI4 0
EQI4 $4320
ADDRGP4 templateInfo+2848
INDIRI4
CNSTI4 0
EQI4 $4320
ADDRGP4 templateInfo+1084+64
INDIRI4
CNSTI4 0
EQI4 $4313
LABELV $4320
line 4967
;4965:				!templateInfo.remoteServer ||
;4966:				templateInfo.remote.curvalue
;4967:			) {
line 4968
;4968:				templateInfo.selectedTemplate += NUM_TEMPLATES_PER_PAGE;
ADDRLP4 4
ADDRGP4 templateInfo+84408
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 14
ADDI4
ASGNI4
line 4969
;4969:				if (templateInfo.selectedTemplate >= templateInfo.currentList->numEntries) {
ADDRGP4 templateInfo+84408
INDIRI4
ADDRGP4 templateInfo+84396
INDIRP4
CNSTI4 81540
ADDP4
INDIRI4
LTI4 $4322
line 4970
;4970:					templateInfo.selectedTemplate = templateInfo.currentList->numEntries - 1;
ADDRGP4 templateInfo+84408
ADDRGP4 templateInfo+84396
INDIRP4
CNSTI4 81540
ADDP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 4971
;4971:				}
LABELV $4322
line 4972
;4972:			}
LABELV $4313
line 4973
;4973:		}
LABELV $4308
line 4974
;4974:		UI_Template_SetMenuItems();
ADDRGP4 UI_Template_SetMenuItems
CALLV
pop
line 4975
;4975:	}
LABELV $4306
line 4976
;4976:}
LABELV $4305
endproc UI_TemplateMenu_NextPageEvent 8 0
proc UI_TemplateMenu_RemoteEvent 4 0
line 4983
;4977:
;4978:/*
;4979:=================
;4980:JUHOX: UI_TemplateMenu_RemoteEvent
;4981:=================
;4982:*/
;4983:static void UI_TemplateMenu_RemoteEvent(void* ptr, int event) {
line 4986
;4984:	int t;
;4985:
;4986:	if (event != QM_ACTIVATED) return;
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $4329
ADDRGP4 $4328
JUMPV
LABELV $4329
line 4988
;4987:
;4988:	t = templateInfo.firstTemplate;
ADDRLP4 0
ADDRGP4 templateInfo+84400
INDIRI4
ASGNI4
line 4989
;4989:	templateInfo.firstTemplate = templateInfo.savedFirstTemplate;
ADDRGP4 templateInfo+84400
ADDRGP4 templateInfo+84404
INDIRI4
ASGNI4
line 4990
;4990:	templateInfo.savedFirstTemplate = t;
ADDRGP4 templateInfo+84404
ADDRLP4 0
INDIRI4
ASGNI4
line 4992
;4991:
;4992:	UI_Template_SetMenuItems();
ADDRGP4 UI_Template_SetMenuItems
CALLV
pop
line 4993
;4993:}
LABELV $4328
endproc UI_TemplateMenu_RemoteEvent 4 0
data
align 4
LABELV $4336
byte 4 0
byte 4 0
byte 4 0
byte 4 1061158912
code
proc UI_TemplateMenu_Draw 16 20
line 5001
;4994:
;4995:/*
;4996:=================
;4997:JUHOX: UI_TemplateMenu_Draw
;4998:=================
;4999:*/
;5000:#define SCROLL_SPEED 50.0	// pixels per second
;5001:static void UI_TemplateMenu_Draw(void) {
line 5005
;5002:	static const vec4_t backgroundColor = {0, 0, 0, 0.75};
;5003:	int w;
;5004:
;5005:	if (templateInfo.inGame) {
ADDRGP4 templateInfo+2840
INDIRI4
CNSTI4 0
EQI4 $4337
line 5006
;5006:		UI_FillRect(0, 0, 640, 480, backgroundColor);
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 1142947840
ARGF4
CNSTF4 1139802112
ARGF4
ADDRGP4 $4336
ARGP4
ADDRGP4 UI_FillRect
CALLV
pop
line 5007
;5007:	}
LABELV $4337
line 5009
;5008:
;5009:	if (NOT(templateInfo.inGame && templateInfo.remoteServer && !templateInfo.remote.curvalue)) {
ADDRGP4 templateInfo+2840
INDIRI4
CNSTI4 0
EQI4 $4347
ADDRGP4 templateInfo+2848
INDIRI4
CNSTI4 0
EQI4 $4347
ADDRGP4 templateInfo+1084+64
INDIRI4
CNSTI4 0
EQI4 $4340
LABELV $4347
line 5010
;5010:		UI_DrawString(320, 360, templateInfo.highscoreLine1, UI_SMALLFONT | UI_CENTER, colorWhite);
CNSTI4 320
ARGI4
CNSTI4 360
ARGI4
ADDRGP4 templateInfo+84416
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 5012
;5011:		
;5012:		w = UI_DrawStrlen(templateInfo.highscoreLine2) * SMALLCHAR_WIDTH;
ADDRGP4 templateInfo+84672
ARGP4
ADDRLP4 4
ADDRGP4 UI_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 3
LSHI4
ASGNI4
line 5013
;5013:		if (w <= 640) {
ADDRLP4 0
INDIRI4
CNSTI4 640
GTI4 $4350
line 5014
;5014:			UI_DrawString(320, 377, templateInfo.highscoreLine2, UI_SMALLFONT | UI_CENTER, colorWhite);
CNSTI4 320
ARGI4
CNSTI4 377
ARGI4
ADDRGP4 templateInfo+84672
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 5015
;5015:		}
ADDRGP4 $4351
JUMPV
LABELV $4350
line 5016
;5016:		else {
line 5019
;5017:			float x;	
;5018:	
;5019:			w += 120;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 120
ADDI4
ASGNI4
line 5020
;5020:			x = SCROLL_SPEED * (3.0 + (templateInfo.highscoreLineSetTime - uis.realtime) / 1000.0);
ADDRLP4 8
ADDRGP4 templateInfo+85696
INDIRI4
ADDRGP4 uis+4
INDIRI4
SUBI4
CVIF4 4
CNSTF4 981668463
MULF4
CNSTF4 1077936128
ADDF4
CNSTF4 1112014848
MULF4
ASGNF4
line 5021
;5021:			if (x + w < 640) {
ADDRLP4 8
INDIRF4
ADDRLP4 0
INDIRI4
CVIF4 4
ADDF4
CNSTF4 1142947840
GEF4 $4355
line 5024
;5022:				int n;
;5023:	
;5024:				n = (int) (x / w);
ADDRLP4 12
ADDRLP4 8
INDIRF4
ADDRLP4 0
INDIRI4
CVIF4 4
DIVF4
CVFI4 4
ASGNI4
line 5025
;5025:				x -= w * n;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRLP4 0
INDIRI4
ADDRLP4 12
INDIRI4
MULI4
CVIF4 4
SUBF4
ASGNF4
line 5026
;5026:				UI_DrawString(x + w, 377, templateInfo.highscoreLine2, UI_SMALLFONT, colorWhite);
ADDRLP4 8
INDIRF4
ADDRLP4 0
INDIRI4
CVIF4 4
ADDF4
CVFI4 4
ARGI4
CNSTI4 377
ARGI4
ADDRGP4 templateInfo+84672
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 5027
;5027:			}
LABELV $4355
line 5028
;5028:			UI_DrawString(x, 377, templateInfo.highscoreLine2, UI_SMALLFONT, colorWhite);
ADDRLP4 8
INDIRF4
CVFI4 4
ARGI4
CNSTI4 377
ARGI4
ADDRGP4 templateInfo+84672
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 5029
;5029:		}
LABELV $4351
line 5030
;5030:	}
LABELV $4340
line 5032
;5031:
;5032:	if (Q_stricmp(templateInfo.name.field.buffer, templateInfo.oldName)) {
ADDRGP4 templateInfo+496+60+12
ARGP4
ADDRGP4 templateInfo+828
ARGP4
ADDRLP4 4
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $4359
line 5033
;5033:		Q_strncpyz(templateInfo.oldName, templateInfo.name.field.buffer, sizeof(templateInfo.oldName));
ADDRGP4 templateInfo+828
ARGP4
ADDRGP4 templateInfo+496+60+12
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 5035
;5034:
;5035:		UI_Template_SetMenuItems();
ADDRGP4 UI_Template_SetMenuItems
CALLV
pop
line 5036
;5036:	}
LABELV $4359
line 5038
;5037:
;5038:	Menu_Draw(&templateInfo.menu);
ADDRGP4 templateInfo
ARGP4
ADDRGP4 Menu_Draw
CALLV
pop
line 5040
;5039:
;5040:	if (templateInfo.errorDetected) {
ADDRGP4 templateInfo+86712
INDIRI4
CNSTI4 0
EQI4 $4370
line 5041
;5041:		if (templateInfo.lastMsgTime < uis.realtime - 2000) {
ADDRGP4 templateInfo+86704
INDIRI4
ADDRGP4 uis+4
INDIRI4
CNSTI4 2000
SUBI4
GEI4 $4371
line 5042
;5042:			UI_Send_TemplateList_Error();
ADDRGP4 UI_Send_TemplateList_Error
CALLV
pop
line 5043
;5043:		}
line 5044
;5044:	}
ADDRGP4 $4371
JUMPV
LABELV $4370
line 5046
;5045:	else if (
;5046:		templateInfo.inGame &&
ADDRGP4 templateInfo+2840
INDIRI4
CNSTI4 0
EQI4 $4377
ADDRGP4 templateInfo+2848
INDIRI4
CNSTI4 0
EQI4 $4377
ADDRGP4 templateInfo+86704
INDIRI4
ADDRGP4 uis+4
INDIRI4
CNSTI4 2000
SUBI4
GEI4 $4377
line 5049
;5047:		templateInfo.remoteServer &&
;5048:		templateInfo.lastMsgTime < uis.realtime - 2000
;5049:	) {
line 5050
;5050:		UI_Send_TemplateList_Request();
ADDRGP4 UI_Send_TemplateList_Request
CALLV
pop
line 5051
;5051:	}
LABELV $4377
LABELV $4371
line 5053
;5052:
;5053:	if (!templateInfo.inGame) {
ADDRGP4 templateInfo+2840
INDIRI4
CNSTI4 0
NEI4 $4383
line 5054
;5054:		UI_DrawString(320, 440, gametype_names[templateInfo.gametype], UI_CENTER, colorWhite);
CNSTI4 320
ARGI4
CNSTI4 440
ARGI4
ADDRGP4 templateInfo+84412
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gametype_names
ADDP4
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 5055
;5055:	}
LABELV $4383
line 5057
;5056:
;5057:	if (templateInfo.errorTime && uis.realtime < templateInfo.errorTime) {
ADDRGP4 templateInfo+2836
INDIRI4
CNSTI4 0
EQI4 $4387
ADDRGP4 uis+4
INDIRI4
ADDRGP4 templateInfo+2836
INDIRI4
GEI4 $4387
line 5058
;5058:		UI_DrawString(320, 462, templateInfo.error, UI_SMALLFONT | UI_CENTER, colorWhite);
CNSTI4 320
ARGI4
CNSTI4 462
ARGI4
ADDRGP4 templateInfo+2708
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 5059
;5059:	}
LABELV $4387
line 5060
;5060:}
LABELV $4335
endproc UI_TemplateMenu_Draw 16 20
proc UI_TemplateMenu_Init 16 12
line 5067
;5061:
;5062:/*
;5063:=================
;5064:JUHOX: UI_TemplateMenu_Init
;5065:=================
;5066:*/
;5067:static void UI_TemplateMenu_Init(qboolean inGame, qboolean multiplayer) {
line 5068
;5068:	memset(&templateInfo, 0, sizeof(templateInfo));
ADDRGP4 templateInfo
ARGP4
CNSTI4 0
ARGI4
CNSTI4 86716
ARGI4
ADDRGP4 memset
CALLP4
pop
line 5069
;5069:	templateInfo.inGame = inGame;
ADDRGP4 templateInfo+2840
ADDRFP4 0
INDIRI4
ASGNI4
line 5070
;5070:	templateInfo.multiplayer = multiplayer;
ADDRGP4 templateInfo+2844
ADDRFP4 4
INDIRI4
ASGNI4
line 5071
;5071:	templateInfo.menu.wrapAround = qtrue;
ADDRGP4 templateInfo+404
CNSTI4 1
ASGNI4
line 5072
;5072:	templateInfo.menu.fullscreen = !inGame;
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $4399
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $4400
JUMPV
LABELV $4399
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $4400
ADDRGP4 templateInfo+408
ADDRLP4 0
INDIRI4
ASGNI4
line 5073
;5073:	templateInfo.menu.draw = UI_TemplateMenu_Draw;
ADDRGP4 templateInfo+396
ADDRGP4 UI_TemplateMenu_Draw
ASGNP4
line 5075
;5074:
;5075:	UI_TemplateMenu_InitTemplates();
ADDRGP4 UI_TemplateMenu_InitTemplates
CALLV
pop
line 5077
;5076:
;5077:	UI_TemplateMenu_Cache();
ADDRGP4 UI_TemplateMenu_Cache
CALLV
pop
line 5079
;5078:
;5079:	templateInfo.banner.generic.type	= MTYPE_BTEXT;
ADDRGP4 templateInfo+424
CNSTI4 10
ASGNI4
line 5080
;5080:	templateInfo.banner.generic.x		= 320;
ADDRGP4 templateInfo+424+12
CNSTI4 320
ASGNI4
line 5081
;5081:	templateInfo.banner.generic.y		= 16;
ADDRGP4 templateInfo+424+16
CNSTI4 16
ASGNI4
line 5082
;5082:	templateInfo.banner.string			= "GAME TEMPLATES";
ADDRGP4 templateInfo+424+60
ADDRGP4 $4409
ASGNP4
line 5083
;5083:	templateInfo.banner.color			= colorWhite;
ADDRGP4 templateInfo+424+68
ADDRGP4 colorWhite
ASGNP4
line 5084
;5084:	templateInfo.banner.style			= UI_CENTER;
ADDRGP4 templateInfo+424+64
CNSTI4 1
ASGNI4
line 5085
;5085:	Menu_AddItem(&templateInfo.menu, &templateInfo.banner);
ADDRGP4 templateInfo
ARGP4
ADDRGP4 templateInfo+424
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 5087
;5086:
;5087:	templateInfo.page.generic.type	= MTYPE_PTEXT;
ADDRGP4 templateInfo+1180
CNSTI4 9
ASGNI4
line 5088
;5088:	templateInfo.page.generic.x		= 170;
ADDRGP4 templateInfo+1180+12
CNSTI4 170
ASGNI4
line 5089
;5089:	templateInfo.page.generic.y		= 60;
ADDRGP4 templateInfo+1180+16
CNSTI4 60
ASGNI4
line 5090
;5090:	templateInfo.page.string		= "";
ADDRGP4 templateInfo+1180+60
ADDRGP4 $99
ASGNP4
line 5091
;5091:	templateInfo.page.color			= colorLtGrey;
ADDRGP4 templateInfo+1180+68
ADDRGP4 colorLtGrey
ASGNP4
line 5092
;5092:	templateInfo.page.style			= UI_LEFT;
ADDRGP4 templateInfo+1180+64
CNSTI4 0
ASGNI4
line 5093
;5093:	Menu_AddItem(&templateInfo.menu, &templateInfo.page);
ADDRGP4 templateInfo
ARGP4
ADDRGP4 templateInfo+1180
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 5095
;5094:
;5095:	templateInfo.arrows.generic.type		= MTYPE_BITMAP;
ADDRGP4 templateInfo+1252
CNSTI4 6
ASGNI4
line 5096
;5096:	templateInfo.arrows.generic.name		= TEMPL_ARROWS;
ADDRGP4 templateInfo+1252+4
ADDRGP4 $358
ASGNP4
line 5097
;5097:	templateInfo.arrows.generic.flags		= QMF_INACTIVE;
ADDRGP4 templateInfo+1252+44
CNSTU4 16384
ASGNU4
line 5098
;5098:	templateInfo.arrows.generic.x			= 30;
ADDRGP4 templateInfo+1252+12
CNSTI4 30
ASGNI4
line 5099
;5099:	templateInfo.arrows.generic.y			= 60;
ADDRGP4 templateInfo+1252+16
CNSTI4 60
ASGNI4
line 5100
;5100:	templateInfo.arrows.width				= 128;
ADDRGP4 templateInfo+1252+76
CNSTI4 128
ASGNI4
line 5101
;5101:	templateInfo.arrows.height				= 32;
ADDRGP4 templateInfo+1252+80
CNSTI4 32
ASGNI4
line 5102
;5102:	Menu_AddItem(&templateInfo.menu, &templateInfo.arrows);
ADDRGP4 templateInfo
ARGP4
ADDRGP4 templateInfo+1252
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 5104
;5103:
;5104:	templateInfo.prevpage.generic.type		= MTYPE_BITMAP;
ADDRGP4 templateInfo+1340
CNSTI4 6
ASGNI4
line 5105
;5105:	templateInfo.prevpage.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 templateInfo+1340+44
CNSTU4 260
ASGNU4
line 5106
;5106:	templateInfo.prevpage.generic.callback	= UI_TemplateMenu_PrevPageEvent;
ADDRGP4 templateInfo+1340+48
ADDRGP4 UI_TemplateMenu_PrevPageEvent
ASGNP4
line 5107
;5107:	templateInfo.prevpage.generic.x			= 30;
ADDRGP4 templateInfo+1340+12
CNSTI4 30
ASGNI4
line 5108
;5108:	templateInfo.prevpage.generic.y			= 60;
ADDRGP4 templateInfo+1340+16
CNSTI4 60
ASGNI4
line 5109
;5109:	templateInfo.prevpage.width				= 64;
ADDRGP4 templateInfo+1340+76
CNSTI4 64
ASGNI4
line 5110
;5110:	templateInfo.prevpage.height			= 32;
ADDRGP4 templateInfo+1340+80
CNSTI4 32
ASGNI4
line 5111
;5111:	templateInfo.prevpage.focuspic			= TEMPL_ARROWSL;
ADDRGP4 templateInfo+1340+60
ADDRGP4 $386
ASGNP4
line 5112
;5112:	Menu_AddItem(&templateInfo.menu, &templateInfo.prevpage);
ADDRGP4 templateInfo
ARGP4
ADDRGP4 templateInfo+1340
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 5114
;5113:
;5114:	templateInfo.nextpage.generic.type		= MTYPE_BITMAP;
ADDRGP4 templateInfo+1428
CNSTI4 6
ASGNI4
line 5115
;5115:	templateInfo.nextpage.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 templateInfo+1428+44
CNSTU4 260
ASGNU4
line 5116
;5116:	templateInfo.nextpage.generic.callback	= UI_TemplateMenu_NextPageEvent;
ADDRGP4 templateInfo+1428+48
ADDRGP4 UI_TemplateMenu_NextPageEvent
ASGNP4
line 5117
;5117:	templateInfo.nextpage.generic.x			= 30+65;
ADDRGP4 templateInfo+1428+12
CNSTI4 95
ASGNI4
line 5118
;5118:	templateInfo.nextpage.generic.y			= 60;
ADDRGP4 templateInfo+1428+16
CNSTI4 60
ASGNI4
line 5119
;5119:	templateInfo.nextpage.width				= 64;
ADDRGP4 templateInfo+1428+76
CNSTI4 64
ASGNI4
line 5120
;5120:	templateInfo.nextpage.height			= 32;
ADDRGP4 templateInfo+1428+80
CNSTI4 32
ASGNI4
line 5121
;5121:	templateInfo.nextpage.focuspic			= TEMPL_ARROWSR;
ADDRGP4 templateInfo+1428+60
ADDRGP4 $404
ASGNP4
line 5122
;5122:	Menu_AddItem(&templateInfo.menu, &templateInfo.nextpage);
ADDRGP4 templateInfo
ARGP4
ADDRGP4 templateInfo+1428
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 5124
;5123:
;5124:	if (templateInfo.inGame && templateInfo.remoteServer) {
ADDRGP4 templateInfo+2840
INDIRI4
CNSTI4 0
EQI4 $4473
ADDRGP4 templateInfo+2848
INDIRI4
CNSTI4 0
EQI4 $4473
line 5125
;5125:		templateInfo.remote.generic.type		= MTYPE_SPINCONTROL;
ADDRGP4 templateInfo+1084
CNSTI4 3
ASGNI4
line 5126
;5126:		templateInfo.remote.generic.name		= "Show";
ADDRGP4 templateInfo+1084+4
ADDRGP4 $4480
ASGNP4
line 5127
;5127:		templateInfo.remote.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 templateInfo+1084+44
CNSTU4 258
ASGNU4
line 5128
;5128:		templateInfo.remote.generic.x			= 450;
ADDRGP4 templateInfo+1084+12
CNSTI4 450
ASGNI4
line 5129
;5129:		templateInfo.remote.generic.y			= 67;
ADDRGP4 templateInfo+1084+16
CNSTI4 67
ASGNI4
line 5130
;5130:		templateInfo.remote.generic.callback	= UI_TemplateMenu_RemoteEvent;
ADDRGP4 templateInfo+1084+48
ADDRGP4 UI_TemplateMenu_RemoteEvent
ASGNP4
line 5131
;5131:		templateInfo.remote.itemnames			= remote_items;
ADDRGP4 templateInfo+1084+76
ADDRGP4 remote_items
ASGNP4
line 5132
;5132:		templateInfo.remote.curvalue			= qtrue;
ADDRGP4 templateInfo+1084+64
CNSTI4 1
ASGNI4
line 5133
;5133:		Menu_AddItem(&templateInfo.menu, &templateInfo.remote);
ADDRGP4 templateInfo
ARGP4
ADDRGP4 templateInfo+1084
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 5134
;5134:	}
LABELV $4473
line 5136
;5135:
;5136:	{
line 5140
;5137:		int y;
;5138:		int i;
;5139:
;5140:		y = 100;
ADDRLP4 8
CNSTI4 100
ASGNI4
line 5141
;5141:		for (i = 0; i < NUM_TEMPLATES_PER_PAGE; i++)
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $4494
line 5142
;5142:		{
line 5143
;5143:			templateInfo.templateLine[i].generic.type		= MTYPE_ACTION;
ADDRLP4 4
INDIRI4
CNSTI4 60
MULI4
ADDRGP4 templateInfo+1868
ADDP4
CNSTI4 2
ASGNI4
line 5144
;5144:			templateInfo.templateLine[i].generic.y			= y;
ADDRLP4 4
INDIRI4
CNSTI4 60
MULI4
ADDRGP4 templateInfo+1868+16
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 5145
;5145:			templateInfo.templateLine[i].generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_INACTIVE|QMF_HIDDEN;
ADDRLP4 4
INDIRI4
CNSTI4 60
MULI4
ADDRGP4 templateInfo+1868+44
ADDP4
CNSTU4 20740
ASGNU4
line 5146
;5146:			templateInfo.templateLine[i].generic.callback	= UI_TemplateMenu_TemplateLineEvent;
ADDRLP4 4
INDIRI4
CNSTI4 60
MULI4
ADDRGP4 templateInfo+1868+48
ADDP4
ADDRGP4 UI_TemplateMenu_TemplateLineEvent
ASGNP4
line 5147
;5147:			templateInfo.templateLine[i].generic.ownerdraw	= UI_TemplateMenu_TemplateLineDraw;
ADDRLP4 4
INDIRI4
CNSTI4 60
MULI4
ADDRGP4 templateInfo+1868+56
ADDP4
ADDRGP4 UI_TemplateMenu_TemplateLineDraw
ASGNP4
line 5148
;5148:			templateInfo.templateLine[i].generic.id			= i;
ADDRLP4 4
INDIRI4
CNSTI4 60
MULI4
ADDRGP4 templateInfo+1868+8
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 5149
;5149:			Menu_AddItem(&templateInfo.menu, &templateInfo.templateLine[i]);
ADDRGP4 templateInfo
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 60
MULI4
ADDRGP4 templateInfo+1868
ADDP4
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 5150
;5150:			templateInfo.templateLine[i].generic.top		= y;
ADDRLP4 4
INDIRI4
CNSTI4 60
MULI4
ADDRGP4 templateInfo+1868+24
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 5151
;5151:			templateInfo.templateLine[i].generic.bottom		= y + SMALLCHAR_HEIGHT;
ADDRLP4 4
INDIRI4
CNSTI4 60
MULI4
ADDRGP4 templateInfo+1868+32
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 5152
;5152:			templateInfo.templateLine[i].generic.right		= 640;
ADDRLP4 4
INDIRI4
CNSTI4 60
MULI4
ADDRGP4 templateInfo+1868+28
ADDP4
CNSTI4 640
ASGNI4
line 5154
;5153:
;5154:			y += SMALLCHAR_HEIGHT + 1;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 17
ADDI4
ASGNI4
line 5155
;5155:		}
LABELV $4495
line 5141
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 14
LTI4 $4494
line 5156
;5156:	}
line 5158
;5157:
;5158:	templateInfo.back.generic.type		= MTYPE_BITMAP;
ADDRGP4 templateInfo+1516
CNSTI4 6
ASGNI4
line 5159
;5159:	templateInfo.back.generic.name		= TEMPL_BACK0;
ADDRGP4 templateInfo+1516+4
ADDRGP4 $421
ASGNP4
line 5160
;5160:	templateInfo.back.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 templateInfo+1516+44
CNSTU4 260
ASGNU4
line 5161
;5161:	templateInfo.back.generic.callback	= UI_TemplateMenu_BackEvent;
ADDRGP4 templateInfo+1516+48
ADDRGP4 UI_TemplateMenu_BackEvent
ASGNP4
line 5162
;5162:	templateInfo.back.generic.x			= 0;
ADDRGP4 templateInfo+1516+12
CNSTI4 0
ASGNI4
line 5163
;5163:	templateInfo.back.generic.y			= 480-64;
ADDRGP4 templateInfo+1516+16
CNSTI4 416
ASGNI4
line 5164
;5164:	templateInfo.back.width				= 128;
ADDRGP4 templateInfo+1516+76
CNSTI4 128
ASGNI4
line 5165
;5165:	templateInfo.back.height			= 64;
ADDRGP4 templateInfo+1516+80
CNSTI4 64
ASGNI4
line 5166
;5166:	templateInfo.back.focuspic			= TEMPL_BACK1;
ADDRGP4 templateInfo+1516+60
ADDRGP4 $438
ASGNP4
line 5167
;5167:	Menu_AddItem(&templateInfo.menu, &templateInfo.back);
ADDRGP4 templateInfo
ARGP4
ADDRGP4 templateInfo+1516
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 5169
;5168:
;5169:	templateInfo.del.generic.type		= MTYPE_BITMAP;
ADDRGP4 templateInfo+1692
CNSTI4 6
ASGNI4
line 5170
;5170:	templateInfo.del.generic.name		= TEMPL_DEL0;
ADDRGP4 templateInfo+1692+4
ADDRGP4 $3575
ASGNP4
line 5171
;5171:	templateInfo.del.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_INACTIVE|QMF_HIDDEN;
ADDRGP4 templateInfo+1692+44
CNSTU4 20740
ASGNU4
line 5172
;5172:	templateInfo.del.generic.callback	= UI_TemplateMenu_DelEvent;
ADDRGP4 templateInfo+1692+48
ADDRGP4 UI_TemplateMenu_DelEvent
ASGNP4
line 5173
;5173:	templateInfo.del.generic.x			= 100;
ADDRGP4 templateInfo+1692+12
CNSTI4 100
ASGNI4
line 5174
;5174:	templateInfo.del.generic.y			= 480-64;
ADDRGP4 templateInfo+1692+16
CNSTI4 416
ASGNI4
line 5175
;5175:	templateInfo.del.width				= 128;
ADDRGP4 templateInfo+1692+76
CNSTI4 128
ASGNI4
line 5176
;5176:	templateInfo.del.height				= 64;
ADDRGP4 templateInfo+1692+80
CNSTI4 64
ASGNI4
line 5177
;5177:	templateInfo.del.focuspic			= TEMPL_DEL1;
ADDRGP4 templateInfo+1692+60
ADDRGP4 $3576
ASGNP4
line 5178
;5178:	Menu_AddItem(&templateInfo.menu, &templateInfo.del);
ADDRGP4 templateInfo
ARGP4
ADDRGP4 templateInfo+1692
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 5180
;5179:
;5180:	if (templateInfo.inGame) {
ADDRGP4 templateInfo+2840
INDIRI4
CNSTI4 0
EQI4 $4552
line 5181
;5181:		templateInfo.name.generic.type			= MTYPE_FIELD;
ADDRGP4 templateInfo+496
CNSTI4 4
ASGNI4
line 5182
;5182:		templateInfo.name.generic.name			= "Save Current Settings As:";
ADDRGP4 templateInfo+496+4
ADDRGP4 $4558
ASGNP4
line 5183
;5183:		templateInfo.name.generic.flags			= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 templateInfo+496+44
CNSTU4 258
ASGNU4
line 5184
;5184:		templateInfo.name.generic.x				= 250;
ADDRGP4 templateInfo+496+12
CNSTI4 250
ASGNI4
line 5185
;5185:		templateInfo.name.generic.y				= 396;
ADDRGP4 templateInfo+496+16
CNSTI4 396
ASGNI4
line 5186
;5186:		templateInfo.name.field.widthInChars	= 32;
ADDRGP4 templateInfo+496+60+8
CNSTI4 32
ASGNI4
line 5187
;5187:		templateInfo.name.field.maxchars		= 60;
ADDRGP4 templateInfo+496+60+268
CNSTI4 60
ASGNI4
line 5188
;5188:		Menu_AddItem(&templateInfo.menu, &templateInfo.name);
ADDRGP4 templateInfo
ARGP4
ADDRGP4 templateInfo+496
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 5189
;5189:	}
LABELV $4552
line 5191
;5190:
;5191:	if (templateInfo.inGame) {
ADDRGP4 templateInfo+2840
INDIRI4
CNSTI4 0
EQI4 $4572
line 5192
;5192:		templateInfo.save.generic.type		= MTYPE_BITMAP;
ADDRGP4 templateInfo+1780
CNSTI4 6
ASGNI4
line 5193
;5193:		templateInfo.save.generic.name		= TEMPL_SAVE0;
ADDRGP4 templateInfo+1780+4
ADDRGP4 $3573
ASGNP4
line 5194
;5194:		templateInfo.save.generic.flags		= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED;
ADDRGP4 templateInfo+1780+44
CNSTU4 8464
ASGNU4
line 5195
;5195:		templateInfo.save.generic.callback	= UI_TemplateMenu_SaveEvent;
ADDRGP4 templateInfo+1780+48
ADDRGP4 UI_TemplateMenu_SaveEvent
ASGNP4
line 5196
;5196:		templateInfo.save.generic.x			= 510;
ADDRGP4 templateInfo+1780+12
CNSTI4 510
ASGNI4
line 5197
;5197:		templateInfo.save.generic.y			= 480-64;
ADDRGP4 templateInfo+1780+16
CNSTI4 416
ASGNI4
line 5198
;5198:		templateInfo.save.width				= 128;
ADDRGP4 templateInfo+1780+76
CNSTI4 128
ASGNI4
line 5199
;5199:		templateInfo.save.height			= 64;
ADDRGP4 templateInfo+1780+80
CNSTI4 64
ASGNI4
line 5200
;5200:		templateInfo.save.focuspic			= TEMPL_SAVE1;
ADDRGP4 templateInfo+1780+60
ADDRGP4 $3574
ASGNP4
line 5201
;5201:		Menu_AddItem(&templateInfo.menu, &templateInfo.save);
ADDRGP4 templateInfo
ARGP4
ADDRGP4 templateInfo+1780
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 5202
;5202:	}
LABELV $4572
line 5204
;5203:
;5204:	templateInfo.next.generic.type		= MTYPE_BITMAP;
ADDRGP4 templateInfo+1604
CNSTI4 6
ASGNI4
line 5205
;5205:	templateInfo.next.generic.name		= templateInfo.inGame? TEMPL_VOTE0 : TEMPL_NEXT0;
ADDRGP4 templateInfo+2840
INDIRI4
CNSTI4 0
EQI4 $4598
ADDRLP4 4
ADDRGP4 $3571
ASGNP4
ADDRGP4 $4599
JUMPV
LABELV $4598
ADDRLP4 4
ADDRGP4 $442
ASGNP4
LABELV $4599
ADDRGP4 templateInfo+1604+4
ADDRLP4 4
INDIRP4
ASGNP4
line 5206
;5206:	templateInfo.next.generic.flags		= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_INACTIVE;
ADDRGP4 templateInfo+1604+44
CNSTU4 24848
ASGNU4
line 5207
;5207:	templateInfo.next.generic.callback	= UI_TemplateMenu_NextEvent;
ADDRGP4 templateInfo+1604+48
ADDRGP4 UI_TemplateMenu_NextEvent
ASGNP4
line 5208
;5208:	templateInfo.next.generic.x			= 640;
ADDRGP4 templateInfo+1604+12
CNSTI4 640
ASGNI4
line 5209
;5209:	templateInfo.next.generic.y			= 480-64;
ADDRGP4 templateInfo+1604+16
CNSTI4 416
ASGNI4
line 5210
;5210:	templateInfo.next.width				= 128;
ADDRGP4 templateInfo+1604+76
CNSTI4 128
ASGNI4
line 5211
;5211:	templateInfo.next.height			= 64;
ADDRGP4 templateInfo+1604+80
CNSTI4 64
ASGNI4
line 5212
;5212:	templateInfo.next.focuspic			= templateInfo.inGame? TEMPL_VOTE1 : TEMPL_NEXT1;
ADDRGP4 templateInfo+2840
INDIRI4
CNSTI4 0
EQI4 $4616
ADDRLP4 8
ADDRGP4 $3572
ASGNP4
ADDRGP4 $4617
JUMPV
LABELV $4616
ADDRLP4 8
ADDRGP4 $459
ASGNP4
LABELV $4617
ADDRGP4 templateInfo+1604+60
ADDRLP4 8
INDIRP4
ASGNP4
line 5213
;5213:	Menu_AddItem(&templateInfo.menu, &templateInfo.next);
ADDRGP4 templateInfo
ARGP4
ADDRGP4 templateInfo+1604
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 5215
;5214:
;5215:	UI_Template_SetMenuItems();
ADDRGP4 UI_Template_SetMenuItems
CALLV
pop
line 5216
;5216:}
LABELV $4393
endproc UI_TemplateMenu_Init 16 12
export UI_TemplateMenu
proc UI_TemplateMenu 0 8
line 5223
;5217:
;5218:/*
;5219:=================
;5220:JUHOX: UI_TemplateMenu
;5221:=================
;5222:*/
;5223:void UI_TemplateMenu(qboolean inGame, qboolean multiplayer) {
line 5224
;5224:	UI_TemplateMenu_Init(inGame, multiplayer);
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 UI_TemplateMenu_Init
CALLV
pop
line 5225
;5225:	UI_PushMenu(&templateInfo.menu);
ADDRGP4 templateInfo
ARGP4
ADDRGP4 UI_PushMenu
CALLV
pop
line 5226
;5226:	templateInfo.isActive = qtrue;
ADDRGP4 templateInfo+86708
CNSTI4 1
ASGNI4
line 5227
;5227:}
LABELV $4619
endproc UI_TemplateMenu 0 8
export UI_TemplateList_SvTemplate
proc UI_TemplateList_SvTemplate 36 20
line 5236
;5228:
;5229:/*
;5230:=================
;5231:JUHOX: UI_TemplateList_SvTemplate
;5232:=================
;5233:*/
;5234:void UI_TemplateList_SvTemplate(
;5235:	int n, const char* name, int highscoreType, const char* highscore, const char* descriptor
;5236:) {
line 5239
;5237:	char varName[32];
;5238:
;5239:	Com_sprintf(varName, sizeof(varName), "svtmpl%03d", n);
ADDRLP4 0
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $4622
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 5240
;5240:	trap_Cvar_Register(NULL, varName, "", CVAR_ROM | CVAR_NORESTART);
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 $99
ARGP4
CNSTI4 1088
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5241
;5241:	trap_Cvar_Set(varName, va("name\\%s\\ht\\%d\\h\\%s\\d\\%s", name, highscoreType, highscore, descriptor));
ADDRGP4 $4623
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 5244
;5242:	
;5243:	// update menu
;5244:	if (templateInfo.isActive) {
ADDRGP4 templateInfo+86708
INDIRI4
CNSTI4 0
EQI4 $4624
line 5245
;5245:		BG_GetGameTemplateList(&templateInfo.svList, 0, NULL, qtrue);
ADDRGP4 templateInfo+2852
ARGP4
CNSTI4 0
ARGI4
CNSTP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BG_GetGameTemplateList
CALLV
pop
line 5246
;5246:		UI_TemplateMenu_ComputeChecksums();
ADDRGP4 UI_TemplateMenu_ComputeChecksums
CALLV
pop
line 5247
;5247:		UI_Template_SetMenuItems();
ADDRGP4 UI_Template_SetMenuItems
CALLV
pop
line 5248
;5248:	}
ADDRGP4 $4625
JUMPV
LABELV $4624
line 5249
;5249:	else {
line 5250
;5250:		UI_Send_TemplateList_Stop();
ADDRGP4 UI_Send_TemplateList_Stop
CALLV
pop
line 5251
;5251:	}
LABELV $4625
line 5252
;5252:	templateInfo.errorDetected = qfalse;
ADDRGP4 templateInfo+86712
CNSTI4 0
ASGNI4
line 5253
;5253:}
LABELV $4621
endproc UI_TemplateList_SvTemplate 36 20
export UI_TemplateList_Complete
proc UI_TemplateList_Complete 1060 16
line 5260
;5254:
;5255:/*
;5256:=================
;5257:JUHOX: UI_TemplateList_Complete
;5258:=================
;5259:*/
;5260:void UI_TemplateList_Complete(int number, long checksum) {
line 5263
;5261:	int i;
;5262:
;5263:	templateInfo.errorDetected = qfalse;
ADDRGP4 templateInfo+86712
CNSTI4 0
ASGNI4
line 5264
;5264:	if (!templateInfo.isActive) return;
ADDRGP4 templateInfo+86708
INDIRI4
CNSTI4 0
NEI4 $4631
ADDRGP4 $4629
JUMPV
LABELV $4631
line 5267
;5265:
;5266:	// delete superfluous templates
;5267:	for (i = number; i < MAX_GAMETEMPLATES; i++) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRGP4 $4637
JUMPV
LABELV $4634
line 5271
;5268:		char varName[32];
;5269:		char buf[MAX_STRING_CHARS];
;5270:
;5271:		Com_sprintf(varName, sizeof(varName), "svtmpl%03d", i);
ADDRLP4 4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $4622
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 5272
;5272:		trap_Cvar_VariableStringBuffer(varName, buf, sizeof(buf));
ADDRLP4 4
ARGP4
ADDRLP4 36
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 5273
;5273:		if (buf[0]) trap_Cvar_Set(varName, "");
ADDRLP4 36
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $4638
ADDRLP4 4
ARGP4
ADDRGP4 $99
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
LABELV $4638
line 5274
;5274:	}
LABELV $4635
line 5267
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $4637
ADDRLP4 0
INDIRI4
CNSTI4 1000
LTI4 $4634
line 5276
;5275:
;5276:	BG_GetGameTemplateList(&templateInfo.svList, 0, NULL, qtrue);
ADDRGP4 templateInfo+2852
ARGP4
CNSTI4 0
ARGI4
CNSTP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BG_GetGameTemplateList
CALLV
pop
line 5277
;5277:	UI_TemplateMenu_ComputeChecksums();
ADDRGP4 UI_TemplateMenu_ComputeChecksums
CALLV
pop
line 5278
;5278:	UI_Template_SetMenuItems();
ADDRGP4 UI_Template_SetMenuItems
CALLV
pop
line 5280
;5279:
;5280:	if (checksum != templateInfo.svlistChecksum || number != templateInfo.svList.numEntries) {
ADDRFP4 4
INDIRI4
ADDRGP4 templateInfo+85700
INDIRI4
NEI4 $4646
ADDRFP4 0
INDIRI4
ADDRGP4 templateInfo+2852+81540
INDIRI4
EQI4 $4641
LABELV $4646
line 5283
;5281:		// JUHOX FIXME: the error command doesn't reach the server if send here and sv_floodprotect is 1
;5282:		//UI_Send_TemplateList_Error();
;5283:		templateInfo.errorDetected = qtrue;
ADDRGP4 templateInfo+86712
CNSTI4 1
ASGNI4
line 5284
;5284:		templateInfo.lastMsgTime = uis.realtime;
ADDRGP4 templateInfo+86704
ADDRGP4 uis+4
INDIRI4
ASGNI4
line 5285
;5285:	}
LABELV $4641
line 5286
;5286:}
LABELV $4629
endproc UI_TemplateList_Complete 1060 16
export UI_GTS_Cache
proc UI_GTS_Cache 0 4
line 5340
;5287:
;5288:
;5289:
;5290:
;5291:/*
;5292:=============================================================================
;5293:
;5294:JUHOX: GAME TYPE SELECTION MENU *****
;5295:
;5296:=============================================================================
;5297:*/
;5298:
;5299:#define GTS_BACK0			"menu/art/back_0"
;5300:#define GTS_BACK1			"menu/art/back_1"
;5301:
;5302:typedef struct {
;5303:	menuframework_s	menu;
;5304:
;5305:	menutext_s		banner;
;5306:
;5307:	qboolean		multiplayer;
;5308:
;5309:	menutext_s		templateMenuDescr;
;5310:	menutext_s		templateMenu;
;5311:
;5312:	menutext_s		singleDescr;
;5313:	menutext_s		ffa;
;5314:	menutext_s		tourney;
;5315:
;5316:	menutext_s		teamDescr;
;5317:	menutext_s		tdm;
;5318:	menutext_s		ctf;
;5319:
;5320:	menutext_s		coopDescr;
;5321:#if MONSTER_MODE
;5322:	menutext_s		stu;
;5323:#endif
;5324:#if ESCAPE_MODE
;5325:	menutext_s		efh;
;5326:#endif
;5327:
;5328:	menubitmap_s	back;
;5329:} gameTypeSelectionInfo_t;
;5330:
;5331:static gameTypeSelectionInfo_t	gtsInfo;
;5332:
;5333:
;5334:
;5335:/*
;5336:=================
;5337:JUHOX: UI_GTS_Cache
;5338:=================
;5339:*/
;5340:void UI_GTS_Cache(void) {
line 5341
;5341:	trap_R_RegisterShaderNoMip(GTS_BACK0);
ADDRGP4 $421
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 5342
;5342:	trap_R_RegisterShaderNoMip(GTS_BACK1);
ADDRGP4 $438
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 5343
;5343:}
LABELV $4651
endproc UI_GTS_Cache 0 4
proc UI_GTS_BackEvent 0 0
line 5350
;5344:
;5345:/*
;5346:=================
;5347:JUHOX: UI_GTS_BackEvent
;5348:=================
;5349:*/
;5350:static void UI_GTS_BackEvent(void* ptr, int event) {
line 5351
;5351:	if(event != QM_ACTIVATED) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $4653
line 5352
;5352:		return;
ADDRGP4 $4652
JUMPV
LABELV $4653
line 5355
;5353:	}
;5354:
;5355:	UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 5356
;5356:}
LABELV $4652
endproc UI_GTS_BackEvent 0 0
proc UI_GTS_TemplateEvent 0 8
line 5363
;5357:
;5358:/*
;5359:=================
;5360:JUHOX: UI_GTS_TemplateEvent
;5361:=================
;5362:*/
;5363:static void UI_GTS_TemplateEvent(void* ptr, int event) {
line 5364
;5364:	if(event != QM_ACTIVATED) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $4656
line 5365
;5365:		return;
ADDRGP4 $4655
JUMPV
LABELV $4656
line 5368
;5366:	}
;5367:
;5368:	UI_TemplateMenu(qfalse, gtsInfo.multiplayer);
CNSTI4 0
ARGI4
ADDRGP4 gtsInfo+496
INDIRI4
ARGI4
ADDRGP4 UI_TemplateMenu
CALLV
pop
line 5369
;5369:}
LABELV $4655
endproc UI_GTS_TemplateEvent 0 8
proc UI_GTS_Event 0 4
line 5376
;5370:
;5371:/*
;5372:=================
;5373:JUHOX: UI_GTS_Event
;5374:=================
;5375:*/
;5376:static void UI_GTS_Event(void* ptr, int event) {
line 5377
;5377:	if( event != QM_ACTIVATED ) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $4660
line 5378
;5378:		return;
ADDRGP4 $4659
JUMPV
LABELV $4660
line 5381
;5379:	}
;5380:
;5381:	initialGameType = ((menucommon_s*)ptr)->id;
ADDRGP4 initialGameType
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 5382
;5382:	UI_StartServerMenu(gtsInfo.multiplayer);
ADDRGP4 gtsInfo+496
INDIRI4
ARGI4
ADDRGP4 UI_StartServerMenu
CALLV
pop
line 5383
;5383:}
LABELV $4659
endproc UI_GTS_Event 0 4
data
align 4
LABELV $4664
byte 4 1058642330
byte 4 1058642330
byte 4 1058642330
byte 4 1065353216
code
proc UI_GTS_Init 4 12
line 5390
;5384:
;5385:/*
;5386:=================
;5387:JUHOX: UI_GTS_Init
;5388:=================
;5389:*/
;5390:static void UI_GTS_Init(qboolean multiplayer) {
line 5396
;5391:	int y;
;5392:	static vec4_t descrColor = {
;5393:		0.6, 0.6, 0.6, 1.0
;5394:	};
;5395:
;5396:	memset(&gtsInfo, 0, sizeof(gtsInfo));
ADDRGP4 gtsInfo
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1380
ARGI4
ADDRGP4 memset
CALLP4
pop
line 5397
;5397:	gtsInfo.menu.wrapAround = qtrue;
ADDRGP4 gtsInfo+404
CNSTI4 1
ASGNI4
line 5398
;5398:	gtsInfo.menu.fullscreen = qtrue;
ADDRGP4 gtsInfo+408
CNSTI4 1
ASGNI4
line 5400
;5399:	//gtsInfo.menu.draw = UI_TemplateMenu_Draw;
;5400:	gtsInfo.multiplayer = multiplayer;
ADDRGP4 gtsInfo+496
ADDRFP4 0
INDIRI4
ASGNI4
line 5402
;5401:
;5402:	UI_GTS_Cache();
ADDRGP4 UI_GTS_Cache
CALLV
pop
line 5404
;5403:
;5404:	gtsInfo.banner.generic.type	= MTYPE_BTEXT;
ADDRGP4 gtsInfo+424
CNSTI4 10
ASGNI4
line 5405
;5405:	gtsInfo.banner.generic.x	= 320;
ADDRGP4 gtsInfo+424+12
CNSTI4 320
ASGNI4
line 5406
;5406:	gtsInfo.banner.generic.y	= 16;
ADDRGP4 gtsInfo+424+16
CNSTI4 16
ASGNI4
line 5407
;5407:	gtsInfo.banner.string		= "GAME SELECTION";
ADDRGP4 gtsInfo+424+60
ADDRGP4 $4675
ASGNP4
line 5408
;5408:	gtsInfo.banner.color		= colorWhite;
ADDRGP4 gtsInfo+424+68
ADDRGP4 colorWhite
ASGNP4
line 5409
;5409:	gtsInfo.banner.style		= UI_CENTER;
ADDRGP4 gtsInfo+424+64
CNSTI4 1
ASGNI4
line 5410
;5410:	Menu_AddItem(&gtsInfo.menu, &gtsInfo.banner);
ADDRGP4 gtsInfo
ARGP4
ADDRGP4 gtsInfo+424
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 5412
;5411:
;5412:	gtsInfo.back.generic.type		= MTYPE_BITMAP;
ADDRGP4 gtsInfo+1292
CNSTI4 6
ASGNI4
line 5413
;5413:	gtsInfo.back.generic.name		= GTS_BACK0;
ADDRGP4 gtsInfo+1292+4
ADDRGP4 $421
ASGNP4
line 5414
;5414:	gtsInfo.back.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 gtsInfo+1292+44
CNSTU4 260
ASGNU4
line 5415
;5415:	gtsInfo.back.generic.callback	= UI_GTS_BackEvent;
ADDRGP4 gtsInfo+1292+48
ADDRGP4 UI_GTS_BackEvent
ASGNP4
line 5416
;5416:	gtsInfo.back.generic.x			= 0;
ADDRGP4 gtsInfo+1292+12
CNSTI4 0
ASGNI4
line 5417
;5417:	gtsInfo.back.generic.y			= 480-64;
ADDRGP4 gtsInfo+1292+16
CNSTI4 416
ASGNI4
line 5418
;5418:	gtsInfo.back.width				= 128;
ADDRGP4 gtsInfo+1292+76
CNSTI4 128
ASGNI4
line 5419
;5419:	gtsInfo.back.height				= 64;
ADDRGP4 gtsInfo+1292+80
CNSTI4 64
ASGNI4
line 5420
;5420:	gtsInfo.back.focuspic			= GTS_BACK1;
ADDRGP4 gtsInfo+1292+60
ADDRGP4 $438
ASGNP4
line 5421
;5421:	Menu_AddItem(&gtsInfo.menu, &gtsInfo.back);
ADDRGP4 gtsInfo
ARGP4
ADDRGP4 gtsInfo+1292
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 5423
;5422:
;5423:	y = 80;
ADDRLP4 0
CNSTI4 80
ASGNI4
line 5425
;5424:
;5425:	gtsInfo.templateMenuDescr.generic.type	= MTYPE_TEXT;
ADDRGP4 gtsInfo+500
CNSTI4 7
ASGNI4
line 5426
;5426:	gtsInfo.templateMenuDescr.generic.flags	= QMF_LEFT_JUSTIFY|QMF_SMALLFONT;
ADDRGP4 gtsInfo+500+44
CNSTU4 6
ASGNU4
line 5427
;5427:	gtsInfo.templateMenuDescr.generic.x		= 50;
ADDRGP4 gtsInfo+500+12
CNSTI4 50
ASGNI4
line 5428
;5428:	gtsInfo.templateMenuDescr.generic.y		= y;
ADDRGP4 gtsInfo+500+16
ADDRLP4 0
INDIRI4
ASGNI4
line 5429
;5429:	gtsInfo.templateMenuDescr.string		= "prefabs";
ADDRGP4 gtsInfo+500+60
ADDRGP4 $4708
ASGNP4
line 5430
;5430:	gtsInfo.templateMenuDescr.color			= descrColor;
ADDRGP4 gtsInfo+500+68
ADDRGP4 $4664
ASGNP4
line 5431
;5431:	gtsInfo.templateMenuDescr.style			= UI_LEFT|UI_SMALLFONT;
ADDRGP4 gtsInfo+500+64
CNSTI4 16
ASGNI4
line 5432
;5432:	Menu_AddItem(&gtsInfo.menu, &gtsInfo.templateMenuDescr);
ADDRGP4 gtsInfo
ARGP4
ADDRGP4 gtsInfo+500
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 5434
;5433:
;5434:	gtsInfo.templateMenu.generic.type		= MTYPE_PTEXT;
ADDRGP4 gtsInfo+572
CNSTI4 9
ASGNI4
line 5435
;5435:	gtsInfo.templateMenu.generic.flags		= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 gtsInfo+572+44
CNSTU4 272
ASGNU4
line 5436
;5436:	gtsInfo.templateMenu.generic.x			= 590;
ADDRGP4 gtsInfo+572+12
CNSTI4 590
ASGNI4
line 5437
;5437:	gtsInfo.templateMenu.generic.y			= y;
ADDRGP4 gtsInfo+572+16
ADDRLP4 0
INDIRI4
ASGNI4
line 5438
;5438:	gtsInfo.templateMenu.generic.callback	= UI_GTS_TemplateEvent; 
ADDRGP4 gtsInfo+572+48
ADDRGP4 UI_GTS_TemplateEvent
ASGNP4
line 5439
;5439:	gtsInfo.templateMenu.string				= "Game Templates";
ADDRGP4 gtsInfo+572+60
ADDRGP4 $4725
ASGNP4
line 5440
;5440:	gtsInfo.templateMenu.color				= color_red;
ADDRGP4 gtsInfo+572+68
ADDRGP4 color_red
ASGNP4
line 5441
;5441:	gtsInfo.templateMenu.style				= UI_RIGHT|UI_DROPSHADOW;
ADDRGP4 gtsInfo+572+64
CNSTI4 2050
ASGNI4
line 5442
;5442:	Menu_AddItem(&gtsInfo.menu, &gtsInfo.templateMenu);
ADDRGP4 gtsInfo
ARGP4
ADDRGP4 gtsInfo+572
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 5443
;5443:	y += 34;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 34
ADDI4
ASGNI4
line 5445
;5444:
;5445:	y += 24;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 24
ADDI4
ASGNI4
line 5447
;5446:
;5447:	gtsInfo.singleDescr.generic.type	= MTYPE_TEXT;
ADDRGP4 gtsInfo+644
CNSTI4 7
ASGNI4
line 5448
;5448:	gtsInfo.singleDescr.generic.flags	= QMF_LEFT_JUSTIFY|QMF_SMALLFONT;
ADDRGP4 gtsInfo+644+44
CNSTU4 6
ASGNU4
line 5449
;5449:	gtsInfo.singleDescr.generic.x		= 50;
ADDRGP4 gtsInfo+644+12
CNSTI4 50
ASGNI4
line 5450
;5450:	gtsInfo.singleDescr.generic.y		= y;
ADDRGP4 gtsInfo+644+16
ADDRLP4 0
INDIRI4
ASGNI4
line 5451
;5451:	gtsInfo.singleDescr.string			= "ego games";
ADDRGP4 gtsInfo+644+60
ADDRGP4 $4740
ASGNP4
line 5452
;5452:	gtsInfo.singleDescr.color			= descrColor;
ADDRGP4 gtsInfo+644+68
ADDRGP4 $4664
ASGNP4
line 5453
;5453:	gtsInfo.singleDescr.style			= UI_LEFT|UI_SMALLFONT;
ADDRGP4 gtsInfo+644+64
CNSTI4 16
ASGNI4
line 5454
;5454:	Menu_AddItem(&gtsInfo.menu, &gtsInfo.singleDescr);
ADDRGP4 gtsInfo
ARGP4
ADDRGP4 gtsInfo+644
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 5456
;5455:
;5456:	gtsInfo.ffa.generic.type		= MTYPE_PTEXT;
ADDRGP4 gtsInfo+716
CNSTI4 9
ASGNI4
line 5457
;5457:	gtsInfo.ffa.generic.flags		= QMF_PULSEIFFOCUS|QMF_RIGHT_JUSTIFY;
ADDRGP4 gtsInfo+716+44
CNSTU4 272
ASGNU4
line 5458
;5458:	gtsInfo.ffa.generic.x			= 590;
ADDRGP4 gtsInfo+716+12
CNSTI4 590
ASGNI4
line 5459
;5459:	gtsInfo.ffa.generic.y			= y;
ADDRGP4 gtsInfo+716+16
ADDRLP4 0
INDIRI4
ASGNI4
line 5460
;5460:	gtsInfo.ffa.generic.id			= GT_FFA;
ADDRGP4 gtsInfo+716+8
CNSTI4 0
ASGNI4
line 5461
;5461:	gtsInfo.ffa.generic.callback	= UI_GTS_Event;
ADDRGP4 gtsInfo+716+48
ADDRGP4 UI_GTS_Event
ASGNP4
line 5462
;5462:	gtsInfo.ffa.color				= color_red;
ADDRGP4 gtsInfo+716+68
ADDRGP4 color_red
ASGNP4
line 5463
;5463:	gtsInfo.ffa.style				= UI_RIGHT|UI_DROPSHADOW;
ADDRGP4 gtsInfo+716+64
CNSTI4 2050
ASGNI4
line 5464
;5464:	gtsInfo.ffa.string				= "Free For All";
ADDRGP4 gtsInfo+716+60
ADDRGP4 $97
ASGNP4
line 5465
;5465:	Menu_AddItem(&gtsInfo.menu, &gtsInfo.ffa);
ADDRGP4 gtsInfo
ARGP4
ADDRGP4 gtsInfo+716
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 5466
;5466:	y += 34;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 34
ADDI4
ASGNI4
line 5468
;5467:	
;5468:	gtsInfo.tourney.generic.type		= MTYPE_PTEXT;
ADDRGP4 gtsInfo+788
CNSTI4 9
ASGNI4
line 5469
;5469:	gtsInfo.tourney.generic.flags		= QMF_PULSEIFFOCUS|QMF_RIGHT_JUSTIFY;
ADDRGP4 gtsInfo+788+44
CNSTU4 272
ASGNU4
line 5470
;5470:	gtsInfo.tourney.generic.x			= 590;
ADDRGP4 gtsInfo+788+12
CNSTI4 590
ASGNI4
line 5471
;5471:	gtsInfo.tourney.generic.y			= y;
ADDRGP4 gtsInfo+788+16
ADDRLP4 0
INDIRI4
ASGNI4
line 5472
;5472:	gtsInfo.tourney.generic.id			= GT_TOURNAMENT;
ADDRGP4 gtsInfo+788+8
CNSTI4 1
ASGNI4
line 5473
;5473:	gtsInfo.tourney.generic.callback	= UI_GTS_Event;
ADDRGP4 gtsInfo+788+48
ADDRGP4 UI_GTS_Event
ASGNP4
line 5474
;5474:	gtsInfo.tourney.color				= color_red;
ADDRGP4 gtsInfo+788+68
ADDRGP4 color_red
ASGNP4
line 5475
;5475:	gtsInfo.tourney.style				= UI_RIGHT|UI_DROPSHADOW;
ADDRGP4 gtsInfo+788+64
CNSTI4 2050
ASGNI4
line 5476
;5476:	gtsInfo.tourney.string				= "Tournament";
ADDRGP4 gtsInfo+788+60
ADDRGP4 $98
ASGNP4
line 5477
;5477:	Menu_AddItem(&gtsInfo.menu, &gtsInfo.tourney);
ADDRGP4 gtsInfo
ARGP4
ADDRGP4 gtsInfo+788
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 5478
;5478:	y += 34;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 34
ADDI4
ASGNI4
line 5480
;5479:
;5480:	y += 24;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 24
ADDI4
ASGNI4
line 5482
;5481:
;5482:	gtsInfo.teamDescr.generic.type	= MTYPE_TEXT;
ADDRGP4 gtsInfo+860
CNSTI4 7
ASGNI4
line 5483
;5483:	gtsInfo.teamDescr.generic.flags	= QMF_LEFT_JUSTIFY|QMF_SMALLFONT;
ADDRGP4 gtsInfo+860+44
CNSTU4 6
ASGNU4
line 5484
;5484:	gtsInfo.teamDescr.generic.x		= 50;
ADDRGP4 gtsInfo+860+12
CNSTI4 50
ASGNI4
line 5485
;5485:	gtsInfo.teamDescr.generic.y		= y;
ADDRGP4 gtsInfo+860+16
ADDRLP4 0
INDIRI4
ASGNI4
line 5486
;5486:	gtsInfo.teamDescr.string		= "team games";
ADDRGP4 gtsInfo+860+60
ADDRGP4 $4791
ASGNP4
line 5487
;5487:	gtsInfo.teamDescr.color			= descrColor;
ADDRGP4 gtsInfo+860+68
ADDRGP4 $4664
ASGNP4
line 5488
;5488:	gtsInfo.teamDescr.style			= UI_LEFT|UI_SMALLFONT;
ADDRGP4 gtsInfo+860+64
CNSTI4 16
ASGNI4
line 5489
;5489:	Menu_AddItem(&gtsInfo.menu, &gtsInfo.teamDescr);
ADDRGP4 gtsInfo
ARGP4
ADDRGP4 gtsInfo+860
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 5491
;5490:
;5491:	gtsInfo.tdm.generic.type		= MTYPE_PTEXT;
ADDRGP4 gtsInfo+932
CNSTI4 9
ASGNI4
line 5492
;5492:	gtsInfo.tdm.generic.flags		= QMF_PULSEIFFOCUS|QMF_RIGHT_JUSTIFY;
ADDRGP4 gtsInfo+932+44
CNSTU4 272
ASGNU4
line 5493
;5493:	gtsInfo.tdm.generic.x			= 590;
ADDRGP4 gtsInfo+932+12
CNSTI4 590
ASGNI4
line 5494
;5494:	gtsInfo.tdm.generic.y			= y;
ADDRGP4 gtsInfo+932+16
ADDRLP4 0
INDIRI4
ASGNI4
line 5495
;5495:	gtsInfo.tdm.generic.id			= GT_TEAM;
ADDRGP4 gtsInfo+932+8
CNSTI4 3
ASGNI4
line 5496
;5496:	gtsInfo.tdm.generic.callback	= UI_GTS_Event;
ADDRGP4 gtsInfo+932+48
ADDRGP4 UI_GTS_Event
ASGNP4
line 5497
;5497:	gtsInfo.tdm.color				= color_red;
ADDRGP4 gtsInfo+932+68
ADDRGP4 color_red
ASGNP4
line 5498
;5498:	gtsInfo.tdm.style				= UI_RIGHT|UI_DROPSHADOW;
ADDRGP4 gtsInfo+932+64
CNSTI4 2050
ASGNI4
line 5499
;5499:	gtsInfo.tdm.string				= "Team Deathmatch";
ADDRGP4 gtsInfo+932+60
ADDRGP4 $100
ASGNP4
line 5500
;5500:	Menu_AddItem(&gtsInfo.menu, &gtsInfo.tdm);
ADDRGP4 gtsInfo
ARGP4
ADDRGP4 gtsInfo+932
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 5501
;5501:	y += 34;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 34
ADDI4
ASGNI4
line 5503
;5502:	
;5503:	gtsInfo.ctf.generic.type		= MTYPE_PTEXT;
ADDRGP4 gtsInfo+1004
CNSTI4 9
ASGNI4
line 5504
;5504:	gtsInfo.ctf.generic.flags		= QMF_PULSEIFFOCUS|QMF_RIGHT_JUSTIFY;
ADDRGP4 gtsInfo+1004+44
CNSTU4 272
ASGNU4
line 5505
;5505:	gtsInfo.ctf.generic.x			= 590;
ADDRGP4 gtsInfo+1004+12
CNSTI4 590
ASGNI4
line 5506
;5506:	gtsInfo.ctf.generic.y			= y;
ADDRGP4 gtsInfo+1004+16
ADDRLP4 0
INDIRI4
ASGNI4
line 5507
;5507:	gtsInfo.ctf.generic.id			= GT_CTF;
ADDRGP4 gtsInfo+1004+8
CNSTI4 4
ASGNI4
line 5508
;5508:	gtsInfo.ctf.generic.callback	= UI_GTS_Event;
ADDRGP4 gtsInfo+1004+48
ADDRGP4 UI_GTS_Event
ASGNP4
line 5509
;5509:	gtsInfo.ctf.color				= color_red;
ADDRGP4 gtsInfo+1004+68
ADDRGP4 color_red
ASGNP4
line 5510
;5510:	gtsInfo.ctf.style				= UI_RIGHT|UI_DROPSHADOW;
ADDRGP4 gtsInfo+1004+64
CNSTI4 2050
ASGNI4
line 5511
;5511:	gtsInfo.ctf.string				= "Capture the Flag";
ADDRGP4 gtsInfo+1004+60
ADDRGP4 $101
ASGNP4
line 5512
;5512:	Menu_AddItem(&gtsInfo.menu, &gtsInfo.ctf);
ADDRGP4 gtsInfo
ARGP4
ADDRGP4 gtsInfo+1004
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 5513
;5513:	y += 34;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 34
ADDI4
ASGNI4
line 5516
;5514:
;5515:#if MONSTER_MODE	
;5516:	y += 24;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 24
ADDI4
ASGNI4
line 5518
;5517:
;5518:	gtsInfo.coopDescr.generic.type	= MTYPE_TEXT;
ADDRGP4 gtsInfo+1076
CNSTI4 7
ASGNI4
line 5519
;5519:	gtsInfo.coopDescr.generic.flags	= QMF_LEFT_JUSTIFY|QMF_SMALLFONT;
ADDRGP4 gtsInfo+1076+44
CNSTU4 6
ASGNU4
line 5520
;5520:	gtsInfo.coopDescr.generic.x		= 50;
ADDRGP4 gtsInfo+1076+12
CNSTI4 50
ASGNI4
line 5521
;5521:	gtsInfo.coopDescr.generic.y		= y;
ADDRGP4 gtsInfo+1076+16
ADDRLP4 0
INDIRI4
ASGNI4
line 5522
;5522:	gtsInfo.coopDescr.string		= "co-op games";
ADDRGP4 gtsInfo+1076+60
ADDRGP4 $4842
ASGNP4
line 5523
;5523:	gtsInfo.coopDescr.color			= descrColor;
ADDRGP4 gtsInfo+1076+68
ADDRGP4 $4664
ASGNP4
line 5524
;5524:	gtsInfo.coopDescr.style			= UI_LEFT|UI_SMALLFONT;
ADDRGP4 gtsInfo+1076+64
CNSTI4 16
ASGNI4
line 5525
;5525:	Menu_AddItem(&gtsInfo.menu, &gtsInfo.coopDescr);
ADDRGP4 gtsInfo
ARGP4
ADDRGP4 gtsInfo+1076
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 5527
;5526:
;5527:	gtsInfo.stu.generic.type		= MTYPE_PTEXT;
ADDRGP4 gtsInfo+1148
CNSTI4 9
ASGNI4
line 5528
;5528:	gtsInfo.stu.generic.flags		= QMF_PULSEIFFOCUS|QMF_RIGHT_JUSTIFY;
ADDRGP4 gtsInfo+1148+44
CNSTU4 272
ASGNU4
line 5529
;5529:	gtsInfo.stu.generic.x			= 590;
ADDRGP4 gtsInfo+1148+12
CNSTI4 590
ASGNI4
line 5530
;5530:	gtsInfo.stu.generic.y			= y;
ADDRGP4 gtsInfo+1148+16
ADDRLP4 0
INDIRI4
ASGNI4
line 5531
;5531:	gtsInfo.stu.generic.id			= GT_STU;
ADDRGP4 gtsInfo+1148+8
CNSTI4 8
ASGNI4
line 5532
;5532:	gtsInfo.stu.generic.callback	= UI_GTS_Event;
ADDRGP4 gtsInfo+1148+48
ADDRGP4 UI_GTS_Event
ASGNP4
line 5533
;5533:	gtsInfo.stu.color				= color_red;
ADDRGP4 gtsInfo+1148+68
ADDRGP4 color_red
ASGNP4
line 5534
;5534:	gtsInfo.stu.style				= UI_RIGHT|UI_DROPSHADOW;
ADDRGP4 gtsInfo+1148+64
CNSTI4 2050
ASGNI4
line 5535
;5535:	gtsInfo.stu.string				= "Save the Universe";
ADDRGP4 gtsInfo+1148+60
ADDRGP4 $102
ASGNP4
line 5536
;5536:	Menu_AddItem(&gtsInfo.menu, &gtsInfo.stu);
ADDRGP4 gtsInfo
ARGP4
ADDRGP4 gtsInfo+1148
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 5537
;5537:	y += 34;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 34
ADDI4
ASGNI4
line 5541
;5538:#endif
;5539:
;5540:#if ESCAPE_MODE
;5541:	gtsInfo.efh.generic.type		= MTYPE_PTEXT;
ADDRGP4 gtsInfo+1220
CNSTI4 9
ASGNI4
line 5542
;5542:	gtsInfo.efh.generic.flags		= QMF_PULSEIFFOCUS|QMF_RIGHT_JUSTIFY;
ADDRGP4 gtsInfo+1220+44
CNSTU4 272
ASGNU4
line 5543
;5543:	gtsInfo.efh.generic.x			= 590;
ADDRGP4 gtsInfo+1220+12
CNSTI4 590
ASGNI4
line 5544
;5544:	gtsInfo.efh.generic.y			= y;
ADDRGP4 gtsInfo+1220+16
ADDRLP4 0
INDIRI4
ASGNI4
line 5545
;5545:	gtsInfo.efh.generic.id			= GT_EFH;
ADDRGP4 gtsInfo+1220+8
CNSTI4 9
ASGNI4
line 5546
;5546:	gtsInfo.efh.generic.callback	= UI_GTS_Event;
ADDRGP4 gtsInfo+1220+48
ADDRGP4 UI_GTS_Event
ASGNP4
line 5547
;5547:	gtsInfo.efh.color				= color_red;
ADDRGP4 gtsInfo+1220+68
ADDRGP4 color_red
ASGNP4
line 5548
;5548:	gtsInfo.efh.style				= UI_RIGHT|UI_DROPSHADOW;
ADDRGP4 gtsInfo+1220+64
CNSTI4 2050
ASGNI4
line 5549
;5549:	gtsInfo.efh.string				= "Escape from Hell";
ADDRGP4 gtsInfo+1220+60
ADDRGP4 $4883
ASGNP4
line 5550
;5550:	Menu_AddItem(&gtsInfo.menu, &gtsInfo.efh);
ADDRGP4 gtsInfo
ARGP4
ADDRGP4 gtsInfo+1220
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 5551
;5551:	y += 34;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 34
ADDI4
ASGNI4
line 5553
;5552:#endif
;5553:}
LABELV $4663
endproc UI_GTS_Init 4 12
export UI_GTS_Menu
proc UI_GTS_Menu 0 4
line 5560
;5554:
;5555:/*
;5556:=================
;5557:JUHOX: UI_GTS_Menu
;5558:=================
;5559:*/
;5560:void UI_GTS_Menu(qboolean multiplayer) {
line 5561
;5561:	UI_GTS_Init(multiplayer);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 UI_GTS_Init
CALLV
pop
line 5562
;5562:	UI_PushMenu(&gtsInfo.menu);
ADDRGP4 gtsInfo
ARGP4
ADDRGP4 UI_PushMenu
CALLV
pop
line 5563
;5563:}
LABELV $4885
endproc UI_GTS_Menu 0 4
bss
align 4
LABELV gtsInfo
skip 1380
align 4
LABELV tmplcmdCounter
skip 4
align 4
LABELV templateInfo
skip 86716
align 4
LABELV advOptMonInfo
skip 3852
align 4
LABELV advOptEquipInfo
skip 1868
align 4
LABELV advOptGameInfo
skip 1888
align 4
LABELV advOptMainInfo
skip 800
align 4
LABELV botSelectInfo
skip 10296
align 4
LABELV s_serveroptions
skip 7852
export gtmpl
align 4
LABELV gtmpl
skip 512
import punkbuster_items
align 4
LABELV initialGameType
skip 4
align 4
LABELV s_startserver
skip 7784
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
import ArenaServers_Cache
import UI_ArenaServersMenu
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
LABELV $4883
byte 1 69
byte 1 115
byte 1 99
byte 1 97
byte 1 112
byte 1 101
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 72
byte 1 101
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $4842
byte 1 99
byte 1 111
byte 1 45
byte 1 111
byte 1 112
byte 1 32
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $4791
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $4740
byte 1 101
byte 1 103
byte 1 111
byte 1 32
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $4725
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 84
byte 1 101
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $4708
byte 1 112
byte 1 114
byte 1 101
byte 1 102
byte 1 97
byte 1 98
byte 1 115
byte 1 0
align 1
LABELV $4675
byte 1 71
byte 1 65
byte 1 77
byte 1 69
byte 1 32
byte 1 83
byte 1 69
byte 1 76
byte 1 69
byte 1 67
byte 1 84
byte 1 73
byte 1 79
byte 1 78
byte 1 0
align 1
LABELV $4623
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 104
byte 1 116
byte 1 92
byte 1 37
byte 1 100
byte 1 92
byte 1 104
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 100
byte 1 92
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $4622
byte 1 115
byte 1 118
byte 1 116
byte 1 109
byte 1 112
byte 1 108
byte 1 37
byte 1 48
byte 1 51
byte 1 100
byte 1 0
align 1
LABELV $4558
byte 1 83
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 67
byte 1 117
byte 1 114
byte 1 114
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 83
byte 1 101
byte 1 116
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 115
byte 1 32
byte 1 65
byte 1 115
byte 1 58
byte 1 0
align 1
LABELV $4480
byte 1 83
byte 1 104
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $4409
byte 1 71
byte 1 65
byte 1 77
byte 1 69
byte 1 32
byte 1 84
byte 1 69
byte 1 77
byte 1 80
byte 1 76
byte 1 65
byte 1 84
byte 1 69
byte 1 83
byte 1 0
align 1
LABELV $4190
byte 1 117
byte 1 105
byte 1 95
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 99
byte 1 104
byte 1 97
byte 1 108
byte 1 108
byte 1 101
byte 1 110
byte 1 103
byte 1 105
byte 1 110
byte 1 103
byte 1 101
byte 1 110
byte 1 118
byte 1 0
align 1
LABELV $4185
byte 1 117
byte 1 105
byte 1 95
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 100
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $4135
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $4130
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 109
byte 1 105
byte 1 110
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $4052
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
byte 1 102
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 108
byte 1 121
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $3973
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 115
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $3903
byte 1 103
byte 1 95
byte 1 103
byte 1 114
byte 1 97
byte 1 118
byte 1 105
byte 1 116
byte 1 121
byte 1 76
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $3898
byte 1 103
byte 1 95
byte 1 107
byte 1 110
byte 1 111
byte 1 99
byte 1 107
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $3893
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $3888
byte 1 100
byte 1 109
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $3859
byte 1 85
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 46
byte 1 0
align 1
LABELV $3854
byte 1 73
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 116
byte 1 101
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 101
byte 1 46
byte 1 0
align 1
LABELV $3847
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 116
byte 1 101
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $3836
byte 1 115
byte 1 97
byte 1 118
byte 1 101
byte 1 100
byte 1 37
byte 1 48
byte 1 51
byte 1 100
byte 1 0
align 1
LABELV $3828
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $3765
byte 1 80
byte 1 97
byte 1 103
byte 1 101
byte 1 32
byte 1 37
byte 1 100
byte 1 47
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $3661
byte 1 103
byte 1 116
byte 1 0
align 1
LABELV $3636
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 105
byte 1 114
byte 1 115
byte 1 116
byte 1 32
byte 1 114
byte 1 101
byte 1 99
byte 1 111
byte 1 114
byte 1 100
byte 1 32
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 33
byte 1 0
align 1
LABELV $3635
byte 1 82
byte 1 69
byte 1 67
byte 1 79
byte 1 82
byte 1 68
byte 1 32
byte 1 83
byte 1 80
byte 1 69
byte 1 69
byte 1 68
byte 1 32
byte 1 37
byte 1 100
byte 1 46
byte 1 37
byte 1 48
byte 1 51
byte 1 100
byte 1 32
byte 1 109
byte 1 101
byte 1 116
byte 1 114
byte 1 101
byte 1 115
byte 1 32
byte 1 112
byte 1 101
byte 1 114
byte 1 32
byte 1 109
byte 1 105
byte 1 110
byte 1 117
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $3631
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 105
byte 1 114
byte 1 115
byte 1 116
byte 1 32
byte 1 114
byte 1 101
byte 1 99
byte 1 111
byte 1 114
byte 1 100
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 116
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 33
byte 1 0
align 1
LABELV $3630
byte 1 82
byte 1 69
byte 1 67
byte 1 79
byte 1 82
byte 1 68
byte 1 32
byte 1 68
byte 1 73
byte 1 83
byte 1 84
byte 1 65
byte 1 78
byte 1 67
byte 1 69
byte 1 32
byte 1 37
byte 1 100
byte 1 46
byte 1 37
byte 1 48
byte 1 51
byte 1 100
byte 1 107
byte 1 109
byte 1 0
align 1
LABELV $3626
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 105
byte 1 114
byte 1 115
byte 1 116
byte 1 32
byte 1 114
byte 1 101
byte 1 99
byte 1 111
byte 1 114
byte 1 100
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 33
byte 1 0
align 1
LABELV $3625
byte 1 82
byte 1 69
byte 1 67
byte 1 79
byte 1 82
byte 1 68
byte 1 32
byte 1 84
byte 1 73
byte 1 77
byte 1 69
byte 1 32
byte 1 37
byte 1 100
byte 1 58
byte 1 37
byte 1 48
byte 1 50
byte 1 100
byte 1 46
byte 1 37
byte 1 48
byte 1 51
byte 1 100
byte 1 0
align 1
LABELV $3621
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 105
byte 1 114
byte 1 115
byte 1 116
byte 1 32
byte 1 104
byte 1 105
byte 1 103
byte 1 104
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 33
byte 1 0
align 1
LABELV $3620
byte 1 72
byte 1 73
byte 1 71
byte 1 72
byte 1 83
byte 1 67
byte 1 79
byte 1 82
byte 1 69
byte 1 32
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $3614
byte 1 37
byte 1 115
byte 1 49
byte 1 0
align 1
LABELV $3613
byte 1 37
byte 1 115
byte 1 48
byte 1 0
align 1
LABELV $3610
byte 1 104
byte 1 110
byte 1 0
align 1
LABELV $3576
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
LABELV $3575
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
LABELV $3574
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
byte 1 97
byte 1 118
byte 1 101
byte 1 95
byte 1 49
byte 1 0
align 1
LABELV $3573
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
byte 1 97
byte 1 118
byte 1 101
byte 1 95
byte 1 48
byte 1 0
align 1
LABELV $3572
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 95
byte 1 49
byte 1 0
align 1
LABELV $3571
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 95
byte 1 48
byte 1 0
align 1
LABELV $3554
byte 1 115
byte 1 118
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
LABELV $3542
byte 1 100
byte 1 0
align 1
LABELV $3541
byte 1 104
byte 1 0
align 1
LABELV $3540
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $3525
byte 1 116
byte 1 101
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 95
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 0
align 1
LABELV $3510
byte 1 116
byte 1 101
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 95
byte 1 115
byte 1 116
byte 1 111
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $3501
byte 1 116
byte 1 101
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 95
byte 1 114
byte 1 101
byte 1 113
byte 1 117
byte 1 101
byte 1 115
byte 1 116
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $3493
byte 1 37
byte 1 99
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $3492
byte 1 116
byte 1 109
byte 1 112
byte 1 108
byte 1 99
byte 1 109
byte 1 100
byte 1 0
align 1
LABELV $3485
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 39
byte 1 115
byte 1 32
byte 1 116
byte 1 101
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $3484
byte 1 108
byte 1 111
byte 1 99
byte 1 97
byte 1 108
byte 1 32
byte 1 116
byte 1 101
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $3462
byte 1 77
byte 1 79
byte 1 78
byte 1 83
byte 1 84
byte 1 69
byte 1 82
byte 1 83
byte 1 0
align 1
LABELV $3443
byte 1 69
byte 1 81
byte 1 85
byte 1 73
byte 1 80
byte 1 77
byte 1 69
byte 1 78
byte 1 84
byte 1 0
align 1
LABELV $3424
byte 1 71
byte 1 65
byte 1 77
byte 1 69
byte 1 80
byte 1 76
byte 1 65
byte 1 89
byte 1 0
align 1
LABELV $3339
byte 1 65
byte 1 118
byte 1 103
byte 1 46
byte 1 32
byte 1 80
byte 1 97
byte 1 114
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 77
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 97
byte 1 115
byte 1 32
byte 1 84
byte 1 105
byte 1 116
byte 1 97
byte 1 110
byte 1 115
byte 1 32
byte 1 91
byte 1 37
byte 1 93
byte 1 58
byte 1 0
align 1
LABELV $3315
byte 1 65
byte 1 118
byte 1 103
byte 1 46
byte 1 32
byte 1 80
byte 1 97
byte 1 114
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 77
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 97
byte 1 115
byte 1 32
byte 1 71
byte 1 117
byte 1 97
byte 1 114
byte 1 100
byte 1 115
byte 1 32
byte 1 91
byte 1 37
byte 1 93
byte 1 58
byte 1 0
align 1
LABELV $3273
byte 1 77
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 32
byte 1 34
byte 1 84
byte 1 105
byte 1 116
byte 1 97
byte 1 110
byte 1 34
byte 1 58
byte 1 0
align 1
LABELV $3231
byte 1 77
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 32
byte 1 34
byte 1 71
byte 1 117
byte 1 97
byte 1 114
byte 1 100
byte 1 34
byte 1 58
byte 1 0
align 1
LABELV $3186
byte 1 77
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 32
byte 1 34
byte 1 80
byte 1 114
byte 1 101
byte 1 100
byte 1 97
byte 1 116
byte 1 111
byte 1 114
byte 1 34
byte 1 58
byte 1 0
align 1
LABELV $3170
byte 1 80
byte 1 114
byte 1 101
byte 1 100
byte 1 97
byte 1 116
byte 1 111
byte 1 114
byte 1 115
byte 1 32
byte 1 66
byte 1 114
byte 1 101
byte 1 101
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 77
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 58
byte 1 0
align 1
LABELV $3143
byte 1 77
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 67
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 105
byte 1 116
byte 1 117
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 80
byte 1 114
byte 1 111
byte 1 103
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 91
byte 1 37
byte 1 47
byte 1 109
byte 1 105
byte 1 110
byte 1 93
byte 1 58
byte 1 0
align 1
LABELV $3114
byte 1 77
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 67
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 105
byte 1 116
byte 1 117
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 91
byte 1 37
byte 1 93
byte 1 58
byte 1 0
align 1
LABELV $3090
byte 1 77
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 32
byte 1 68
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 58
byte 1 0
align 1
LABELV $3066
byte 1 35
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 77
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 65
byte 1 114
byte 1 116
byte 1 101
byte 1 102
byte 1 97
byte 1 99
byte 1 116
byte 1 115
byte 1 58
byte 1 0
align 1
LABELV $3039
byte 1 77
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 91
byte 1 37
byte 1 93
byte 1 58
byte 1 0
align 1
LABELV $3012
byte 1 77
byte 1 97
byte 1 120
byte 1 46
byte 1 32
byte 1 35
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 77
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 58
byte 1 0
align 1
LABELV $2985
byte 1 77
byte 1 105
byte 1 110
byte 1 46
byte 1 32
byte 1 35
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 77
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 58
byte 1 0
align 1
LABELV $2963
byte 1 48
byte 1 32
byte 1 46
byte 1 46
byte 1 46
byte 1 32
byte 1 49
byte 1 48
byte 1 48
byte 1 48
byte 1 32
byte 1 40
byte 1 34
byte 1 118
byte 1 101
byte 1 114
byte 1 121
byte 1 32
byte 1 101
byte 1 97
byte 1 115
byte 1 121
byte 1 34
byte 1 32
byte 1 46
byte 1 46
byte 1 46
byte 1 32
byte 1 34
byte 1 118
byte 1 101
byte 1 114
byte 1 121
byte 1 32
byte 1 104
byte 1 97
byte 1 114
byte 1 100
byte 1 34
byte 1 41
byte 1 0
align 1
LABELV $2961
byte 1 49
byte 1 37
byte 1 32
byte 1 46
byte 1 46
byte 1 46
byte 1 32
byte 1 49
byte 1 48
byte 1 48
byte 1 48
byte 1 37
byte 1 32
byte 1 40
byte 1 34
byte 1 118
byte 1 101
byte 1 114
byte 1 121
byte 1 32
byte 1 101
byte 1 97
byte 1 115
byte 1 121
byte 1 34
byte 1 32
byte 1 46
byte 1 46
byte 1 46
byte 1 32
byte 1 34
byte 1 118
byte 1 101
byte 1 114
byte 1 121
byte 1 32
byte 1 104
byte 1 97
byte 1 114
byte 1 100
byte 1 34
byte 1 41
byte 1 0
align 1
LABELV $2959
byte 1 48
byte 1 32
byte 1 46
byte 1 46
byte 1 46
byte 1 32
byte 1 49
byte 1 48
byte 1 48
byte 1 37
byte 1 0
align 1
LABELV $2957
byte 1 48
byte 1 46
byte 1 50
byte 1 32
byte 1 46
byte 1 46
byte 1 46
byte 1 32
byte 1 57
byte 1 57
byte 1 57
byte 1 32
byte 1 115
byte 1 101
byte 1 99
byte 1 111
byte 1 110
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $2955
byte 1 48
byte 1 37
byte 1 32
byte 1 46
byte 1 46
byte 1 46
byte 1 32
byte 1 49
byte 1 48
byte 1 48
byte 1 48
byte 1 37
byte 1 0
align 1
LABELV $2953
byte 1 97
byte 1 108
byte 1 108
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 97
byte 1 110
byte 1 32
byte 1 101
byte 1 113
byte 1 117
byte 1 97
byte 1 108
byte 1 32
byte 1 115
byte 1 104
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 116
byte 1 104
byte 1 105
byte 1 115
byte 1 0
align 1
LABELV $2948
byte 1 48
byte 1 32
byte 1 46
byte 1 46
byte 1 46
byte 1 32
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $2944
byte 1 84
byte 1 73
byte 1 84
byte 1 65
byte 1 78
byte 1 83
byte 1 32
byte 1 77
byte 1 79
byte 1 68
byte 1 69
byte 1 76
byte 1 0
align 1
LABELV $2938
byte 1 71
byte 1 85
byte 1 65
byte 1 82
byte 1 68
byte 1 32
byte 1 77
byte 1 79
byte 1 68
byte 1 69
byte 1 76
byte 1 0
align 1
LABELV $2932
byte 1 80
byte 1 82
byte 1 69
byte 1 68
byte 1 65
byte 1 84
byte 1 79
byte 1 82
byte 1 32
byte 1 77
byte 1 79
byte 1 68
byte 1 69
byte 1 76
byte 1 0
align 1
LABELV $2850
byte 1 37
byte 1 46
byte 1 51
byte 1 102
byte 1 0
align 1
LABELV $2794
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
byte 1 32
byte 1 68
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 32
byte 1 76
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 32
byte 1 91
byte 1 112
byte 1 101
byte 1 114
byte 1 32
byte 1 83
byte 1 101
byte 1 99
byte 1 111
byte 1 110
byte 1 100
byte 1 93
byte 1 58
byte 1 0
align 1
LABELV $2776
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
byte 1 32
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 58
byte 1 0
align 1
LABELV $2754
byte 1 77
byte 1 97
byte 1 120
byte 1 46
byte 1 32
byte 1 35
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 77
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 112
byte 1 101
byte 1 114
byte 1 32
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 58
byte 1 0
align 1
LABELV $2744
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
byte 1 58
byte 1 0
align 1
LABELV $2719
byte 1 85
byte 1 110
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 65
byte 1 109
byte 1 109
byte 1 117
byte 1 110
byte 1 105
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 58
byte 1 0
align 1
LABELV $2700
byte 1 77
byte 1 97
byte 1 120
byte 1 46
byte 1 32
byte 1 35
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 87
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 32
byte 1 112
byte 1 101
byte 1 114
byte 1 32
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 58
byte 1 0
align 1
LABELV $2684
byte 1 67
byte 1 108
byte 1 111
byte 1 97
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 68
byte 1 101
byte 1 118
byte 1 105
byte 1 99
byte 1 101
byte 1 58
byte 1 0
align 1
LABELV $2664
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 115
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 99
byte 1 97
byte 1 112
byte 1 97
byte 1 99
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 108
byte 1 97
byte 1 117
byte 1 110
byte 1 99
byte 1 104
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $2663
byte 1 49
byte 1 32
byte 1 46
byte 1 46
byte 1 46
byte 1 32
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $2582
byte 1 83
byte 1 107
byte 1 105
byte 1 112
byte 1 32
byte 1 69
byte 1 110
byte 1 100
byte 1 32
byte 1 83
byte 1 101
byte 1 113
byte 1 117
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $2563
byte 1 65
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 32
byte 1 82
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 32
byte 1 65
byte 1 116
byte 1 32
byte 1 80
byte 1 108
byte 1 97
byte 1 99
byte 1 101
byte 1 32
byte 1 79
byte 1 102
byte 1 32
byte 1 68
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 58
byte 1 0
align 1
LABELV $2544
byte 1 71
byte 1 101
byte 1 110
byte 1 101
byte 1 114
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 65
byte 1 114
byte 1 109
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 70
byte 1 114
byte 1 97
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 58
byte 1 0
align 1
LABELV $2528
byte 1 78
byte 1 101
byte 1 105
byte 1 116
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 32
byte 1 78
byte 1 111
byte 1 114
byte 1 32
byte 1 65
byte 1 114
byte 1 109
byte 1 111
byte 1 117
byte 1 114
byte 1 32
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
byte 1 58
byte 1 0
align 1
LABELV $2512
byte 1 78
byte 1 111
byte 1 32
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 58
byte 1 0
align 1
LABELV $2496
byte 1 76
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 83
byte 1 116
byte 1 97
byte 1 109
byte 1 105
byte 1 110
byte 1 97
byte 1 58
byte 1 0
align 1
LABELV $2480
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 65
byte 1 100
byte 1 97
byte 1 112
byte 1 116
byte 1 115
byte 1 32
byte 1 84
byte 1 111
byte 1 32
byte 1 77
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 67
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 105
byte 1 116
byte 1 117
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 58
byte 1 0
align 1
LABELV $2467
byte 1 65
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 32
byte 1 77
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 76
byte 1 101
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 32
byte 1 83
byte 1 97
byte 1 102
byte 1 101
byte 1 116
byte 1 121
byte 1 32
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 58
byte 1 0
align 1
LABELV $2449
byte 1 84
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 99
byte 1 97
byte 1 108
byte 1 32
byte 1 83
byte 1 117
byte 1 112
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 32
byte 1 83
byte 1 121
byte 1 115
byte 1 116
byte 1 101
byte 1 109
byte 1 58
byte 1 0
align 1
LABELV $2415
byte 1 82
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 32
byte 1 68
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 58
byte 1 0
align 1
LABELV $2393
byte 1 67
byte 1 104
byte 1 97
byte 1 108
byte 1 108
byte 1 101
byte 1 110
byte 1 103
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 69
byte 1 110
byte 1 118
byte 1 105
byte 1 114
byte 1 111
byte 1 110
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 0
align 1
LABELV $2368
byte 1 66
byte 1 97
byte 1 115
byte 1 101
byte 1 32
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 58
byte 1 0
align 1
LABELV $2359
byte 1 65
byte 1 68
byte 1 86
byte 1 65
byte 1 78
byte 1 67
byte 1 69
byte 1 68
byte 1 32
byte 1 79
byte 1 80
byte 1 84
byte 1 73
byte 1 79
byte 1 78
byte 1 83
byte 1 0
align 1
LABELV $2348
byte 1 69
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 47
byte 1 100
byte 1 105
byte 1 115
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 116
byte 1 115
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 98
byte 1 101
byte 1 101
byte 1 110
byte 1 32
byte 1 109
byte 1 97
byte 1 114
byte 1 107
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 115
byte 1 32
byte 1 34
byte 1 112
byte 1 111
byte 1 115
byte 1 115
byte 1 105
byte 1 98
byte 1 108
byte 1 121
byte 1 32
byte 1 102
byte 1 114
byte 1 117
byte 1 115
byte 1 116
byte 1 114
byte 1 97
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 34
byte 1 0
align 1
LABELV $2345
byte 1 105
byte 1 110
byte 1 32
byte 1 115
byte 1 101
byte 1 99
byte 1 111
byte 1 110
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $2267
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $2262
byte 1 99
byte 1 111
byte 1 109
byte 1 98
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $2261
byte 1 97
byte 1 110
byte 1 99
byte 1 104
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $2260
byte 1 116
byte 1 111
byte 1 111
byte 1 108
byte 1 0
align 1
LABELV $2259
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 105
byte 1 99
byte 1 0
align 1
LABELV $2258
byte 1 100
byte 1 105
byte 1 115
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $2089
byte 1 83
byte 1 69
byte 1 76
byte 1 69
byte 1 67
byte 1 84
byte 1 32
byte 1 66
byte 1 79
byte 1 84
byte 1 0
align 1
LABELV $2078
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 111
byte 1 112
byte 1 112
byte 1 111
byte 1 110
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 95
byte 1 115
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $2077
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 111
byte 1 112
byte 1 112
byte 1 111
byte 1 110
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 95
byte 1 115
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $2076
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
byte 1 99
byte 1 99
byte 1 101
byte 1 112
byte 1 116
byte 1 95
byte 1 49
byte 1 0
align 1
LABELV $2075
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
byte 1 99
byte 1 99
byte 1 101
byte 1 112
byte 1 116
byte 1 95
byte 1 48
byte 1 0
align 1
LABELV $1949
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $1938
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 95
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1935
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1934
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $1810
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
LABELV $1793
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
LABELV $1749
byte 1 65
byte 1 100
byte 1 118
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 100
byte 1 32
byte 1 79
byte 1 112
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $1733
byte 1 77
byte 1 101
byte 1 101
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 58
byte 1 0
align 1
LABELV $1711
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 83
byte 1 101
byte 1 101
byte 1 100
byte 1 58
byte 1 0
align 1
LABELV $1695
byte 1 65
byte 1 100
byte 1 100
byte 1 105
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 97
byte 1 108
byte 1 32
byte 1 79
byte 1 112
byte 1 101
byte 1 110
byte 1 32
byte 1 83
byte 1 108
byte 1 111
byte 1 116
byte 1 115
byte 1 58
byte 1 0
align 1
LABELV $1603
byte 1 66
byte 1 111
byte 1 116
byte 1 32
byte 1 83
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 58
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $1584
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
byte 1 58
byte 1 0
align 1
LABELV $1568
byte 1 72
byte 1 111
byte 1 115
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 58
byte 1 0
align 1
LABELV $1559
byte 1 68
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 58
byte 1 0
align 1
LABELV $1540
byte 1 80
byte 1 117
byte 1 114
byte 1 101
byte 1 32
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 58
byte 1 0
align 1
LABELV $1530
byte 1 70
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 108
byte 1 121
byte 1 32
byte 1 70
byte 1 105
byte 1 114
byte 1 101
byte 1 58
byte 1 0
align 1
LABELV $1505
byte 1 68
byte 1 105
byte 1 115
byte 1 116
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 32
byte 1 91
byte 1 107
byte 1 109
byte 1 93
byte 1 58
byte 1 0
align 1
LABELV $1484
byte 1 65
byte 1 114
byte 1 116
byte 1 101
byte 1 102
byte 1 97
byte 1 99
byte 1 116
byte 1 115
byte 1 58
byte 1 0
align 1
LABELV $1463
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 32
byte 1 76
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 58
byte 1 0
align 1
LABELV $1445
byte 1 67
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 32
byte 1 76
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 58
byte 1 0
align 1
LABELV $1427
byte 1 70
byte 1 114
byte 1 97
byte 1 103
byte 1 32
byte 1 76
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 58
byte 1 0
align 1
LABELV $1307
byte 1 37
byte 1 102
byte 1 0
align 1
LABELV $1274
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 116
byte 1 115
byte 1 115
byte 1 0
align 1
LABELV $1272
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 68
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $1218
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 68
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $1146
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $1105
byte 1 79
byte 1 114
byte 1 98
byte 1 98
byte 1 0
align 1
LABELV $1104
byte 1 66
byte 1 111
byte 1 110
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $1103
byte 1 85
byte 1 114
byte 1 105
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $1102
byte 1 84
byte 1 97
byte 1 110
byte 1 107
byte 1 74
byte 1 114
byte 1 0
align 1
LABELV $1101
byte 1 83
byte 1 111
byte 1 114
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $1100
byte 1 72
byte 1 97
byte 1 114
byte 1 112
byte 1 121
byte 1 0
align 1
LABELV $1099
byte 1 88
byte 1 97
byte 1 101
byte 1 114
byte 1 111
byte 1 0
align 1
LABELV $1098
byte 1 65
byte 1 110
byte 1 97
byte 1 114
byte 1 107
byte 1 105
byte 1 0
align 1
LABELV $1097
byte 1 86
byte 1 105
byte 1 115
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $1096
byte 1 77
byte 1 97
byte 1 106
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $1095
byte 1 71
byte 1 114
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $1094
byte 1 83
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $1070
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $1062
byte 1 120
byte 1 97
byte 1 101
byte 1 114
byte 1 111
byte 1 0
align 1
LABELV $1059
byte 1 97
byte 1 110
byte 1 97
byte 1 114
byte 1 107
byte 1 105
byte 1 0
align 1
LABELV $1036
byte 1 115
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $1024
byte 1 118
byte 1 105
byte 1 115
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $1018
byte 1 109
byte 1 97
byte 1 106
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $1015
byte 1 103
byte 1 114
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $990
byte 1 48
byte 1 32
byte 1 46
byte 1 46
byte 1 46
byte 1 32
byte 1 57
byte 1 57
byte 1 56
byte 1 44
byte 1 32
byte 1 57
byte 1 57
byte 1 57
byte 1 32
byte 1 61
byte 1 32
byte 1 117
byte 1 110
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $978
byte 1 48
byte 1 32
byte 1 61
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $904
byte 1 72
byte 1 117
byte 1 109
byte 1 97
byte 1 110
byte 1 0
align 1
LABELV $861
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $827
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 32
byte 1 53
byte 1 59
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $822
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
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $818
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
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $800
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 32
byte 1 51
byte 1 10
byte 1 0
align 1
LABELV $798
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 32
byte 1 59
byte 1 32
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 32
byte 1 59
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $795
byte 1 115
byte 1 118
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
LABELV $791
byte 1 115
byte 1 118
byte 1 95
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
LABELV $790
byte 1 48
byte 1 0
align 1
LABELV $789
byte 1 103
byte 1 95
byte 1 109
byte 1 101
byte 1 101
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $785
byte 1 103
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 83
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $784
byte 1 115
byte 1 118
byte 1 95
byte 1 112
byte 1 117
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $783
byte 1 103
byte 1 95
byte 1 102
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 108
byte 1 121
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $782
byte 1 103
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 76
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $781
byte 1 103
byte 1 95
byte 1 99
byte 1 108
byte 1 111
byte 1 97
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 68
byte 1 101
byte 1 118
byte 1 105
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $780
byte 1 103
byte 1 95
byte 1 117
byte 1 110
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 101
byte 1 100
byte 1 65
byte 1 109
byte 1 109
byte 1 111
byte 1 0
align 1
LABELV $779
byte 1 103
byte 1 95
byte 1 110
byte 1 111
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 82
byte 1 101
byte 1 103
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $778
byte 1 103
byte 1 95
byte 1 110
byte 1 111
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $776
byte 1 103
byte 1 95
byte 1 103
byte 1 114
byte 1 97
byte 1 112
byte 1 112
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $774
byte 1 103
byte 1 95
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 68
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 76
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $772
byte 1 103
byte 1 95
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $770
byte 1 103
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 109
byte 1 105
byte 1 110
byte 1 97
byte 1 0
align 1
LABELV $769
byte 1 116
byte 1 115
byte 1 115
byte 1 83
byte 1 97
byte 1 102
byte 1 101
byte 1 116
byte 1 121
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 65
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $768
byte 1 116
byte 1 115
byte 1 115
byte 1 0
align 1
LABELV $767
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 65
byte 1 116
byte 1 80
byte 1 79
byte 1 68
byte 1 0
align 1
LABELV $766
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 68
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $765
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $764
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
LABELV $763
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
LABELV $762
byte 1 103
byte 1 95
byte 1 101
byte 1 100
byte 1 105
byte 1 116
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $761
byte 1 100
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $760
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
LABELV $759
byte 1 117
byte 1 105
byte 1 95
byte 1 97
byte 1 100
byte 1 100
byte 1 105
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 97
byte 1 108
byte 1 83
byte 1 108
byte 1 111
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $758
byte 1 103
byte 1 95
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 70
byte 1 114
byte 1 97
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $756
byte 1 103
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $755
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 51
byte 1 0
align 1
LABELV $754
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 50
byte 1 0
align 1
LABELV $753
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 49
byte 1 0
align 1
LABELV $752
byte 1 103
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 83
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $751
byte 1 103
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 77
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 80
byte 1 80
byte 1 0
align 1
LABELV $750
byte 1 103
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 77
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $749
byte 1 103
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
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
LABELV $747
byte 1 117
byte 1 105
byte 1 95
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 109
byte 1 101
byte 1 101
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $744
byte 1 117
byte 1 105
byte 1 95
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 80
byte 1 114
byte 1 111
byte 1 103
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $743
byte 1 117
byte 1 105
byte 1 95
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 83
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $740
byte 1 117
byte 1 105
byte 1 95
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 84
byte 1 105
byte 1 116
byte 1 97
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $737
byte 1 117
byte 1 105
byte 1 95
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 71
byte 1 117
byte 1 97
byte 1 114
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $735
byte 1 103
byte 1 95
byte 1 99
byte 1 104
byte 1 97
byte 1 108
byte 1 108
byte 1 101
byte 1 110
byte 1 103
byte 1 105
byte 1 110
byte 1 103
byte 1 69
byte 1 110
byte 1 118
byte 1 0
align 1
LABELV $733
byte 1 117
byte 1 105
byte 1 95
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 99
byte 1 104
byte 1 97
byte 1 108
byte 1 108
byte 1 101
byte 1 110
byte 1 103
byte 1 105
byte 1 110
byte 1 103
byte 1 69
byte 1 110
byte 1 118
byte 1 0
align 1
LABELV $731
byte 1 103
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $729
byte 1 117
byte 1 105
byte 1 95
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $728
byte 1 117
byte 1 105
byte 1 95
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 76
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $727
byte 1 117
byte 1 105
byte 1 95
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 99
byte 1 108
byte 1 111
byte 1 97
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 68
byte 1 101
byte 1 118
byte 1 105
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $726
byte 1 117
byte 1 105
byte 1 95
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 117
byte 1 110
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 101
byte 1 100
byte 1 65
byte 1 109
byte 1 109
byte 1 111
byte 1 0
align 1
LABELV $725
byte 1 117
byte 1 105
byte 1 95
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 110
byte 1 111
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 82
byte 1 101
byte 1 103
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $724
byte 1 117
byte 1 105
byte 1 95
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 110
byte 1 111
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $723
byte 1 117
byte 1 105
byte 1 95
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $722
byte 1 117
byte 1 105
byte 1 95
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 102
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 108
byte 1 121
byte 1 0
align 1
LABELV $718
byte 1 100
byte 1 105
byte 1 115
byte 1 116
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $714
byte 1 117
byte 1 105
byte 1 95
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 100
byte 1 105
byte 1 115
byte 1 116
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $713
byte 1 117
byte 1 105
byte 1 95
byte 1 101
byte 1 102
byte 1 104
byte 1 95
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
LABELV $712
byte 1 117
byte 1 105
byte 1 95
byte 1 101
byte 1 102
byte 1 104
byte 1 95
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
LABELV $710
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 109
byte 1 101
byte 1 101
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $708
byte 1 103
byte 1 95
byte 1 115
byte 1 107
byte 1 105
byte 1 112
byte 1 69
byte 1 110
byte 1 100
byte 1 83
byte 1 101
byte 1 113
byte 1 117
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $704
byte 1 103
byte 1 95
byte 1 97
byte 1 114
byte 1 116
byte 1 101
byte 1 102
byte 1 97
byte 1 99
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $700
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 97
byte 1 114
byte 1 116
byte 1 101
byte 1 102
byte 1 97
byte 1 99
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $698
byte 1 103
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 66
byte 1 114
byte 1 101
byte 1 101
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $696
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 66
byte 1 114
byte 1 101
byte 1 101
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $694
byte 1 103
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 84
byte 1 105
byte 1 116
byte 1 97
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $692
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 84
byte 1 105
byte 1 116
byte 1 97
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $690
byte 1 103
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 71
byte 1 117
byte 1 97
byte 1 114
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $688
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 71
byte 1 117
byte 1 97
byte 1 114
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $686
byte 1 103
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 80
byte 1 114
byte 1 111
byte 1 103
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $684
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 80
byte 1 114
byte 1 111
byte 1 103
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $683
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 83
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $681
byte 1 103
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 68
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $679
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 68
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $677
byte 1 103
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 80
byte 1 101
byte 1 114
byte 1 84
byte 1 114
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $675
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 80
byte 1 101
byte 1 114
byte 1 84
byte 1 114
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $674
byte 1 103
byte 1 95
byte 1 109
byte 1 105
byte 1 110
byte 1 77
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $673
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 109
byte 1 105
byte 1 110
byte 1 77
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $672
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 77
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $671
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 76
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $670
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 99
byte 1 108
byte 1 111
byte 1 97
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 68
byte 1 101
byte 1 118
byte 1 105
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $669
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 117
byte 1 110
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 101
byte 1 100
byte 1 65
byte 1 109
byte 1 109
byte 1 111
byte 1 0
align 1
LABELV $668
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 110
byte 1 111
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 82
byte 1 101
byte 1 103
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $667
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 110
byte 1 111
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $666
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $665
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 100
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $664
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 102
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 108
byte 1 121
byte 1 0
align 1
LABELV $663
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
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
LABELV $662
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
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
LABELV $660
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
byte 1 109
byte 1 101
byte 1 101
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $659
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 83
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $658
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 77
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 80
byte 1 80
byte 1 0
align 1
LABELV $657
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 77
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $656
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
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
LABELV $655
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 76
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $654
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
byte 1 99
byte 1 108
byte 1 111
byte 1 97
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 68
byte 1 101
byte 1 118
byte 1 105
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $653
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
byte 1 117
byte 1 110
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 101
byte 1 100
byte 1 65
byte 1 109
byte 1 109
byte 1 111
byte 1 0
align 1
LABELV $652
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
byte 1 110
byte 1 111
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 82
byte 1 101
byte 1 103
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $651
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
byte 1 110
byte 1 111
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $650
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
byte 1 116
byte 1 115
byte 1 115
byte 1 0
align 1
LABELV $649
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $648
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 100
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $647
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
byte 1 102
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 108
byte 1 121
byte 1 0
align 1
LABELV $646
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
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
LABELV $645
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $643
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 109
byte 1 101
byte 1 101
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $642
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 83
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $641
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 77
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 80
byte 1 80
byte 1 0
align 1
LABELV $640
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 77
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $639
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
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
LABELV $638
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 76
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $637
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 99
byte 1 108
byte 1 111
byte 1 97
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 68
byte 1 101
byte 1 118
byte 1 105
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $636
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 117
byte 1 110
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 101
byte 1 100
byte 1 65
byte 1 109
byte 1 109
byte 1 111
byte 1 0
align 1
LABELV $635
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 110
byte 1 111
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 82
byte 1 101
byte 1 103
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $634
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 110
byte 1 111
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $633
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 116
byte 1 115
byte 1 115
byte 1 0
align 1
LABELV $632
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $631
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 100
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $630
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 102
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 108
byte 1 121
byte 1 0
align 1
LABELV $629
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
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
LABELV $628
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
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
LABELV $626
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 95
byte 1 109
byte 1 101
byte 1 101
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $625
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 83
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $624
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 77
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 80
byte 1 80
byte 1 0
align 1
LABELV $623
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 77
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $622
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
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
LABELV $621
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 76
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $620
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 95
byte 1 99
byte 1 108
byte 1 111
byte 1 97
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 68
byte 1 101
byte 1 118
byte 1 105
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $619
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 95
byte 1 117
byte 1 110
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 101
byte 1 100
byte 1 65
byte 1 109
byte 1 109
byte 1 111
byte 1 0
align 1
LABELV $618
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 95
byte 1 110
byte 1 111
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 82
byte 1 101
byte 1 103
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $617
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 95
byte 1 110
byte 1 111
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $616
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $615
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 95
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
LABELV $614
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 95
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
LABELV $612
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 102
byte 1 97
byte 1 95
byte 1 109
byte 1 101
byte 1 101
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $611
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 102
byte 1 97
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 83
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $610
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 102
byte 1 97
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 77
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 80
byte 1 80
byte 1 0
align 1
LABELV $609
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 102
byte 1 97
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 77
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $608
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 102
byte 1 97
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
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
LABELV $607
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 102
byte 1 97
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 76
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $606
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 102
byte 1 97
byte 1 95
byte 1 99
byte 1 108
byte 1 111
byte 1 97
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 68
byte 1 101
byte 1 118
byte 1 105
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $605
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 102
byte 1 97
byte 1 95
byte 1 117
byte 1 110
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 101
byte 1 100
byte 1 65
byte 1 109
byte 1 109
byte 1 111
byte 1 0
align 1
LABELV $604
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 102
byte 1 97
byte 1 95
byte 1 110
byte 1 111
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 82
byte 1 101
byte 1 103
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $603
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 102
byte 1 97
byte 1 95
byte 1 110
byte 1 111
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $602
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 102
byte 1 97
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $601
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 102
byte 1 97
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 100
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $600
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 102
byte 1 97
byte 1 95
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
LABELV $599
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 102
byte 1 97
byte 1 95
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
LABELV $517
byte 1 78
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 109
byte 1 97
byte 1 114
byte 1 101
byte 1 33
byte 1 0
align 1
LABELV $516
byte 1 72
byte 1 97
byte 1 114
byte 1 100
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $515
byte 1 72
byte 1 117
byte 1 114
byte 1 116
byte 1 32
byte 1 77
byte 1 101
byte 1 32
byte 1 80
byte 1 108
byte 1 101
byte 1 110
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $514
byte 1 66
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 73
byte 1 116
byte 1 32
byte 1 79
byte 1 110
byte 1 0
align 1
LABELV $513
byte 1 73
byte 1 32
byte 1 67
byte 1 97
byte 1 110
byte 1 32
byte 1 87
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $512
byte 1 82
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $511
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $510
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 0
align 1
LABELV $509
byte 1 66
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $508
byte 1 79
byte 1 112
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $507
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
LABELV $506
byte 1 76
byte 1 65
byte 1 78
byte 1 0
align 1
LABELV $505
byte 1 78
byte 1 111
byte 1 0
align 1
LABELV $487
byte 1 117
byte 1 105
byte 1 95
byte 1 112
byte 1 114
byte 1 101
byte 1 99
byte 1 97
byte 1 99
byte 1 104
byte 1 101
byte 1 0
align 1
LABELV $486
byte 1 99
byte 1 111
byte 1 109
byte 1 95
byte 1 98
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 0
align 1
LABELV $459
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 95
byte 1 49
byte 1 0
align 1
LABELV $442
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 95
byte 1 48
byte 1 0
align 1
LABELV $438
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
LABELV $421
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
LABELV $404
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 103
byte 1 115
byte 1 95
byte 1 97
byte 1 114
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 95
byte 1 114
byte 1 0
align 1
LABELV $386
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 103
byte 1 115
byte 1 95
byte 1 97
byte 1 114
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 95
byte 1 108
byte 1 0
align 1
LABELV $358
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 103
byte 1 115
byte 1 95
byte 1 97
byte 1 114
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 95
byte 1 48
byte 1 0
align 1
LABELV $354
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 109
byte 1 97
byte 1 112
byte 1 115
byte 1 95
byte 1 115
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $326
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
LABELV $323
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 109
byte 1 97
byte 1 112
byte 1 115
byte 1 95
byte 1 115
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $283
byte 1 71
byte 1 65
byte 1 77
byte 1 69
byte 1 32
byte 1 83
byte 1 69
byte 1 82
byte 1 86
byte 1 69
byte 1 82
byte 1 0
align 1
LABELV $250
byte 1 103
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 84
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $214
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $209
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $176
byte 1 78
byte 1 79
byte 1 32
byte 1 77
byte 1 65
byte 1 80
byte 1 83
byte 1 32
byte 1 70
byte 1 79
byte 1 85
byte 1 78
byte 1 68
byte 1 0
align 1
LABELV $143
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
byte 1 0
align 1
LABELV $132
byte 1 101
byte 1 102
byte 1 104
byte 1 0
align 1
LABELV $129
byte 1 115
byte 1 116
byte 1 117
byte 1 0
align 1
LABELV $126
byte 1 99
byte 1 116
byte 1 102
byte 1 0
align 1
LABELV $123
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $120
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $117
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 0
align 1
LABELV $114
byte 1 102
byte 1 102
byte 1 97
byte 1 0
align 1
LABELV $105
byte 1 103
byte 1 95
byte 1 116
byte 1 101
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $103
byte 1 69
byte 1 115
byte 1 99
byte 1 97
byte 1 112
byte 1 101
byte 1 32
byte 1 70
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 72
byte 1 101
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $102
byte 1 83
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 85
byte 1 110
byte 1 105
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $101
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
LABELV $100
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
LABELV $99
byte 1 0
align 1
LABELV $98
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
LABELV $97
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
