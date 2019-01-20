code
proc MainMenu_ExitAction 0 0
file "..\..\..\..\code\q3_ui\ui_menu.c"
line 61
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:/*
;4:=======================================================================
;5:
;6:MAIN MENU
;7:
;8:=======================================================================
;9:*/
;10:
;11:
;12:#include "ui_local.h"
;13:
;14:
;15:#define ID_SINGLEPLAYER			10
;16:#define ID_MULTIPLAYER			11
;17:#define ID_SETUP				12
;18:#define ID_DEMOS				13
;19:#define ID_CINEMATICS			14
;20:#define ID_TEAMARENA		15
;21:#define ID_MODS					16
;22:#define ID_EXIT					17
;23:#define ID_CREDITS				18	// JUHOX
;24:
;25:#define MAIN_BANNER_MODEL				"models/mapobjects/banner/banner5.md3"
;26:#define MAIN_MENU_VERTICAL_SPACING		34
;27:
;28:
;29:typedef struct {
;30:	menuframework_s	menu;
;31:
;32:	menutext_s		singleplayer;
;33:	menutext_s		multiplayer;
;34:	menutext_s		setup;
;35:	menutext_s		demos;
;36:	menutext_s		cinematics;
;37:	menutext_s		teamArena;
;38:	menutext_s		mods;
;39:	menutext_s		exit;
;40:	menutext_s		credits;	// JUHOX
;41:
;42:	qhandle_t		bannerModel;
;43:} mainmenu_t;
;44:
;45:
;46:static mainmenu_t s_main;
;47:
;48:typedef struct {
;49:	menuframework_s menu;	
;50:	char errorMessage[4096];
;51:} errorMessage_t;
;52:
;53:static errorMessage_t s_errorMessage;
;54:
;55:
;56:/*
;57:=================
;58:MainMenu_ExitAction
;59:=================
;60:*/
;61:static void MainMenu_ExitAction( qboolean result ) {
line 62
;62:	if( !result ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $99
line 63
;63:		return;
ADDRGP4 $98
JUMPV
LABELV $99
line 65
;64:	}
;65:	UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 66
;66:	UI_CreditMenu();
ADDRGP4 UI_CreditMenu
CALLV
pop
line 67
;67:}
LABELV $98
endproc MainMenu_ExitAction 0 0
export Main_MenuEvent
proc Main_MenuEvent 8 12
line 76
;68:
;69:
;70:
;71:/*
;72:=================
;73:Main_MenuEvent
;74:=================
;75:*/
;76:void Main_MenuEvent (void* ptr, int event) {
line 77
;77:	if( event != QM_ACTIVATED ) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $102
line 78
;78:		return;
ADDRGP4 $101
JUMPV
LABELV $102
line 81
;79:	}
;80:
;81:	switch( ((menucommon_s*)ptr)->id ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 10
LTI4 $104
ADDRLP4 0
INDIRI4
CNSTI4 18
GTI4 $104
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $120-40
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $120
address $107
address $108
address $109
address $110
address $111
address $113
address $112
address $117
address $119
code
LABELV $107
line 87
;82:	case ID_SINGLEPLAYER:
;83:#if 0	// JUHOX: skip single player menu
;84:		UI_SPLevelMenu();
;85:#else
;86:		//UI_StartServerMenu(qfalse);
;87:		UI_GTS_Menu(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 UI_GTS_Menu
CALLV
pop
line 89
;88:#endif
;89:		break;
ADDRGP4 $105
JUMPV
LABELV $108
line 92
;90:
;91:	case ID_MULTIPLAYER:
;92:		UI_ArenaServersMenu();
ADDRGP4 UI_ArenaServersMenu
CALLV
pop
line 93
;93:		break;
ADDRGP4 $105
JUMPV
LABELV $109
line 96
;94:
;95:	case ID_SETUP:
;96:		UI_SetupMenu();
ADDRGP4 UI_SetupMenu
CALLV
pop
line 97
;97:		break;
ADDRGP4 $105
JUMPV
LABELV $110
line 100
;98:
;99:	case ID_DEMOS:
;100:		UI_DemosMenu();
ADDRGP4 UI_DemosMenu
CALLV
pop
line 101
;101:		break;
ADDRGP4 $105
JUMPV
LABELV $111
line 104
;102:
;103:	case ID_CINEMATICS:
;104:		UI_CinematicsMenu();
ADDRGP4 UI_CinematicsMenu
CALLV
pop
line 105
;105:		break;
ADDRGP4 $105
JUMPV
LABELV $112
line 108
;106:
;107:	case ID_MODS:
;108:		UI_ModsMenu();
ADDRGP4 UI_ModsMenu
CALLV
pop
line 109
;109:		break;
ADDRGP4 $105
JUMPV
LABELV $113
line 112
;110:
;111:	case ID_TEAMARENA:
;112:		trap_Cvar_Set( "fs_game", "missionpack");
ADDRGP4 $114
ARGP4
ADDRGP4 $115
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 113
;113:		trap_Cmd_ExecuteText( EXEC_APPEND, "vid_restart;" );
CNSTI4 2
ARGI4
ADDRGP4 $116
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 114
;114:		break;
ADDRGP4 $105
JUMPV
LABELV $117
line 117
;115:
;116:	case ID_EXIT:
;117:		UI_ConfirmMenu( "EXIT GAME?", NULL, MainMenu_ExitAction );
ADDRGP4 $118
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 MainMenu_ExitAction
ARGP4
ADDRGP4 UI_ConfirmMenu
CALLV
pop
line 118
;118:		break;
ADDRGP4 $105
JUMPV
LABELV $119
line 122
;119:	
;120:#if 1	// JUHOX: handle credits button
;121:	case ID_CREDITS:
;122:		UI_Hunt_Credits();
ADDRGP4 UI_Hunt_Credits
CALLV
pop
line 123
;123:		break;
LABELV $104
LABELV $105
line 126
;124:#endif
;125:	}
;126:}
LABELV $101
endproc Main_MenuEvent 8 12
export MainMenu_Cache
proc MainMenu_Cache 0 0
line 134
;127:
;128:
;129:/*
;130:===============
;131:MainMenu_Cache
;132:===============
;133:*/
;134:void MainMenu_Cache( void ) {
line 141
;135:#if 0	// JUHOX: we don't use the banner model
;136:	s_main.bannerModel = trap_R_RegisterModel( MAIN_BANNER_MODEL );
;137:#endif
;138:#if 0	// -JUHOX: cache the title music
;139:	trap_S_RegisterSound("music music/hunt.wav", qfalse);
;140:#endif
;141:}
LABELV $122
endproc MainMenu_Cache 0 0
export ErrorMessage_Key
proc ErrorMessage_Key 0 8
line 145
;142:
;143:
;144:sfxHandle_t ErrorMessage_Key(int key)
;145:{
line 146
;146:	trap_Cvar_Set( "com_errorMessage", "" );
ADDRGP4 $124
ARGP4
ADDRGP4 $125
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 147
;147:	UI_MainMenu();
ADDRGP4 UI_MainMenu
CALLV
pop
line 148
;148:	return (menu_null_sound);
ADDRGP4 menu_null_sound
INDIRI4
RETI4
LABELV $123
endproc ErrorMessage_Key 0 8
data
align 4
LABELV $127
byte 4 1056964608
byte 4 0
byte 4 0
byte 4 1065353216
code
proc Main_MenuDraw 20 28
line 157
;149:}
;150:
;151:/*
;152:===============
;153:Main_MenuDraw
;154:TTimo: this function is common to the main menu and errorMessage menu
;155:===============
;156:*/
;157:static void Main_MenuDraw( void ) {
line 214
;158:#if 0	// JUHOX: don't draw the standard menu background
;159:	refdef_t		refdef;
;160:	refEntity_t		ent;
;161:	vec3_t			origin;
;162:	vec3_t			angles;
;163:	float			adjust;
;164:	float			x, y, w, h;
;165:	vec4_t			color = {0.5, 0, 0, 1};
;166:
;167:	// setup the refdef
;168:
;169:	memset( &refdef, 0, sizeof( refdef ) );
;170:
;171:	refdef.rdflags = RDF_NOWORLDMODEL;
;172:
;173:	AxisClear( refdef.viewaxis );
;174:
;175:	x = 0;
;176:	y = 0;
;177:	w = 640;
;178:	h = 120;
;179:	UI_AdjustFrom640( &x, &y, &w, &h );
;180:	refdef.x = x;
;181:	refdef.y = y;
;182:	refdef.width = w;
;183:	refdef.height = h;
;184:
;185:	adjust = 0; // JDC: Kenneth asked me to stop this 1.0 * sin( (float)uis.realtime / 1000 );
;186:	refdef.fov_x = 60 + adjust;
;187:	refdef.fov_y = 19.6875 + adjust;
;188:
;189:	refdef.time = uis.realtime;
;190:
;191:	origin[0] = 300;
;192:	origin[1] = 0;
;193:	origin[2] = -32;
;194:
;195:	trap_R_ClearScene();
;196:
;197:	// add the model
;198:
;199:	memset( &ent, 0, sizeof(ent) );
;200:
;201:	adjust = 5.0 * sin( (float)uis.realtime / 5000 );
;202:	VectorSet( angles, 0, 180 + adjust, 0 );
;203:	AnglesToAxis( angles, ent.axis );
;204:	ent.hModel = s_main.bannerModel;
;205:	VectorCopy( origin, ent.origin );
;206:	VectorCopy( origin, ent.lightingOrigin );
;207:	ent.renderfx = RF_LIGHTING_ORIGIN | RF_NOSHADOW;
;208:	VectorCopy( ent.origin, ent.oldorigin );
;209:
;210:	trap_R_AddRefEntityToScene( &ent );
;211:
;212:	trap_R_RenderScene( &refdef );
;213:#else
;214:	vec4_t			color = {0.5, 0, 0, 1};
ADDRLP4 0
ADDRGP4 $127
INDIRB
ASGNB 16
line 217
;215:#endif
;216:
;217:	if (strlen(s_errorMessage.errorMessage))
ADDRGP4 s_errorMessage+424
ARGP4
ADDRLP4 16
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $128
line 218
;218:	{
line 219
;219:		UI_DrawProportionalString_AutoWrapped( 320, 192, 600, 20, s_errorMessage.errorMessage, UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, menu_text_color );
CNSTI4 320
ARGI4
CNSTI4 192
ARGI4
CNSTI4 600
ARGI4
CNSTI4 20
ARGI4
ADDRGP4 s_errorMessage+424
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 menu_text_color
ARGP4
ADDRGP4 UI_DrawProportionalString_AutoWrapped
CALLV
pop
line 220
;220:	}
ADDRGP4 $129
JUMPV
LABELV $128
line 222
;221:	else
;222:	{
line 225
;223:		// standard menu drawing
;224:
;225:		Menu_Draw( &s_main.menu );
ADDRGP4 s_main
ARGP4
ADDRGP4 Menu_Draw
CALLV
pop
line 226
;226:	}
LABELV $129
line 228
;227:
;228:	if (uis.demoversion) {
ADDRGP4 uis+11484
INDIRI4
CNSTI4 0
EQI4 $132
line 229
;229:		UI_DrawProportionalString( 320, 372, "DEMO      FOR MATURE AUDIENCES      DEMO", UI_CENTER|UI_SMALLFONT, color );
CNSTI4 320
ARGI4
CNSTI4 372
ARGI4
ADDRGP4 $135
ARGP4
CNSTI4 17
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 230
;230:		UI_DrawString( 320, 400, "Quake III Arena(c) 1999-2000, Id Software, Inc.  All Rights Reserved", UI_CENTER|UI_SMALLFONT, color );
CNSTI4 320
ARGI4
CNSTI4 400
ARGI4
ADDRGP4 $136
ARGP4
CNSTI4 17
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 231
;231:	} else {
ADDRGP4 $133
JUMPV
LABELV $132
line 232
;232:		UI_DrawString( 320, 450, "Quake III Arena(c) 1999-2000, Id Software, Inc.  All Rights Reserved", UI_CENTER|UI_SMALLFONT, color );
CNSTI4 320
ARGI4
CNSTI4 450
ARGI4
ADDRGP4 $136
ARGP4
CNSTI4 17
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 234
;233:#if 1	// JUHOX: draw the Hunt banner
;234:		color[0] = 0.4;
ADDRLP4 0
CNSTF4 1053609165
ASGNF4
line 235
;235:		color[1] = 0.4;
ADDRLP4 0+4
CNSTF4 1053609165
ASGNF4
line 236
;236:		color[2] = 0.4;
ADDRLP4 0+8
CNSTF4 1053609165
ASGNF4
line 237
;237:		UI_DrawString(320, 430, "OpenHunt Mod - " __DATE__ "             www.planetquake.com/modifia",  UI_CENTER|UI_SMALLFONT, color);
CNSTI4 320
ARGI4
CNSTI4 430
ARGI4
ADDRGP4 $139
ARGP4
CNSTI4 17
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 239
;238:#endif
;239:	}
LABELV $133
line 242
;240:
;241:#if 1	// JUHOX: start title music
;242:	if (uis.startTitleMusic) {
ADDRGP4 uis+95108
INDIRI4
CNSTI4 0
EQI4 $140
line 243
;243:		trap_S_StartBackgroundTrack("music/hunt.wav", "");
ADDRGP4 $143
ARGP4
ADDRGP4 $125
ARGP4
ADDRGP4 trap_S_StartBackgroundTrack
CALLV
pop
line 244
;244:		uis.startTitleMusic = qfalse;
ADDRGP4 uis+95108
CNSTI4 0
ASGNI4
line 245
;245:	}
LABELV $140
line 247
;246:#endif
;247:}
LABELV $126
endproc Main_MenuDraw 20 28
proc UI_TeamArenaExists 2084 16
line 255
;248:
;249:
;250:/*
;251:===============
;252:UI_TeamArenaExists
;253:===============
;254:*/
;255:static qboolean UI_TeamArenaExists( void ) {
line 263
;256:	int		numdirs;
;257:	char	dirlist[2048];
;258:	char	*dirptr;
;259:  char  *descptr;
;260:	int		i;
;261:	int		dirlen;
;262:
;263:	numdirs = trap_FS_GetFileList( "$modlist", "", dirlist, sizeof(dirlist) );
ADDRGP4 $146
ARGP4
ADDRGP4 $125
ARGP4
ADDRLP4 20
ARGP4
CNSTI4 2048
ARGI4
ADDRLP4 2068
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 2068
INDIRI4
ASGNI4
line 264
;264:	dirptr  = dirlist;
ADDRLP4 0
ADDRLP4 20
ASGNP4
line 265
;265:	for( i = 0; i < numdirs; i++ ) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $150
JUMPV
LABELV $147
line 266
;266:		dirlen = strlen( dirptr ) + 1;
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 2072
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 2072
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 267
;267:    descptr = dirptr + dirlen;
ADDRLP4 12
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
ADDP4
ASGNP4
line 268
;268:		if (Q_stricmp(dirptr, "missionpack") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $115
ARGP4
ADDRLP4 2076
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2076
INDIRI4
CNSTI4 0
NEI4 $151
line 269
;269:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $145
JUMPV
LABELV $151
line 271
;270:		}
;271:    dirptr += dirlen + strlen(descptr) + 1;
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 2080
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ADDRLP4 2080
INDIRI4
ADDI4
CNSTI4 1
ADDI4
ADDRLP4 0
INDIRP4
ADDP4
ASGNP4
line 272
;272:	}
LABELV $148
line 265
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $150
ADDRLP4 8
INDIRI4
ADDRLP4 16
INDIRI4
LTI4 $147
line 273
;273:	return qfalse;
CNSTI4 0
RETI4
LABELV $145
endproc UI_TeamArenaExists 2084 16
export UI_MainMenu
proc UI_MainMenu 36 12
line 286
;274:}
;275:
;276:
;277:/*
;278:===============
;279:UI_MainMenu
;280:
;281:The main menu only comes up when not in a game,
;282:so make sure that the attract loop server is down
;283:and that local cinematics are killed
;284:===============
;285:*/
;286:void UI_MainMenu( void ) {
line 288
;287:	int		y;
;288:	qboolean teamArena = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 289
;289:	int		style = /*UI_CENTER*/UI_RIGHT | UI_DROPSHADOW;	// JUHOX
ADDRLP4 4
CNSTI4 2050
ASGNI4
line 291
;290:
;291:	trap_Cvar_Set( "sv_killserver", "1" );
ADDRGP4 $154
ARGP4
ADDRGP4 $155
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 293
;292:
;293:	if( !uis.demoversion && !ui_cdkeychecked.integer ) {
ADDRGP4 uis+11484
INDIRI4
CNSTI4 0
NEI4 $156
ADDRGP4 ui_cdkeychecked+12
INDIRI4
CNSTI4 0
NEI4 $156
line 296
;294:		char	key[17];
;295:
;296:		trap_GetCDKey( key, sizeof(key) );
ADDRLP4 12
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 trap_GetCDKey
CALLV
pop
line 297
;297:		if( trap_VerifyCDKey( key, NULL ) == qfalse ) {
ADDRLP4 12
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 32
ADDRGP4 trap_VerifyCDKey
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $160
line 298
;298:			UI_CDKeyMenu();
ADDRGP4 UI_CDKeyMenu
CALLV
pop
line 299
;299:			return;
ADDRGP4 $153
JUMPV
LABELV $160
line 301
;300:		}
;301:	}
LABELV $156
line 305
;302:
;303:#if 1	// JUHOX: load complete menu system
;304:	if (
;305:		!trap_Cvar_VariableValue("ui_init") &&
ADDRGP4 $164
ARGP4
ADDRLP4 12
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 12
INDIRF4
CNSTF4 0
NEF4 $162
ADDRGP4 $165
ARGP4
ADDRLP4 16
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 16
INDIRF4
CNSTF4 0
EQF4 $162
line 307
;306:		trap_Cvar_VariableValue("ui_precache")
;307:	) {
line 308
;308:		uis.precaching = 1;
ADDRGP4 uis+95104
CNSTI4 1
ASGNI4
line 309
;309:		trap_Cvar_Set("ui_init", "1");
ADDRGP4 $164
ARGP4
ADDRGP4 $155
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 310
;310:	}
LABELV $162
line 314
;311:#endif
;312:
;313:#if MAPLENSFLARES	// JUHOX: reset g_editmode
;314:	trap_Cvar_Set("g_editmode", "0");
ADDRGP4 $167
ARGP4
ADDRGP4 $168
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 317
;315:#endif
;316:
;317:	memset( &s_main, 0 ,sizeof(mainmenu_t) );
ADDRGP4 s_main
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1076
ARGI4
ADDRGP4 memset
CALLP4
pop
line 318
;318:	memset( &s_errorMessage, 0 ,sizeof(errorMessage_t) );
ADDRGP4 s_errorMessage
ARGP4
CNSTI4 0
ARGI4
CNSTI4 4520
ARGI4
ADDRGP4 memset
CALLP4
pop
line 321
;319:
;320:	// com_errorMessage would need that too
;321:	MainMenu_Cache();
ADDRGP4 MainMenu_Cache
CALLV
pop
line 323
;322:
;323:	trap_Cvar_VariableStringBuffer( "com_errorMessage", s_errorMessage.errorMessage, sizeof(s_errorMessage.errorMessage) );
ADDRGP4 $124
ARGP4
ADDRGP4 s_errorMessage+424
ARGP4
CNSTI4 4096
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 324
;324:	if (strlen(s_errorMessage.errorMessage))
ADDRGP4 s_errorMessage+424
ARGP4
ADDRLP4 20
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $171
line 325
;325:	{	
line 326
;326:		s_errorMessage.menu.draw = Main_MenuDraw;
ADDRGP4 s_errorMessage+396
ADDRGP4 Main_MenuDraw
ASGNP4
line 327
;327:		s_errorMessage.menu.key = ErrorMessage_Key;
ADDRGP4 s_errorMessage+400
ADDRGP4 ErrorMessage_Key
ASGNP4
line 328
;328:		s_errorMessage.menu.fullscreen = qtrue;
ADDRGP4 s_errorMessage+408
CNSTI4 1
ASGNI4
line 329
;329:		s_errorMessage.menu.wrapAround = qtrue;
ADDRGP4 s_errorMessage+404
CNSTI4 1
ASGNI4
line 330
;330:		s_errorMessage.menu.showlogo = qtrue;		
ADDRGP4 s_errorMessage+412
CNSTI4 1
ASGNI4
line 332
;331:
;332:		trap_Key_SetCatcher( KEYCATCH_UI );
CNSTI4 2
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 333
;333:		uis.menusp = 0;
ADDRGP4 uis+16
CNSTI4 0
ASGNI4
line 334
;334:		UI_PushMenu ( &s_errorMessage.menu );
ADDRGP4 s_errorMessage
ARGP4
ADDRGP4 UI_PushMenu
CALLV
pop
line 336
;335:		
;336:		return;
ADDRGP4 $153
JUMPV
LABELV $171
line 339
;337:	}
;338:
;339:	s_main.menu.draw = Main_MenuDraw;
ADDRGP4 s_main+396
ADDRGP4 Main_MenuDraw
ASGNP4
line 340
;340:	s_main.menu.fullscreen = qtrue;
ADDRGP4 s_main+408
CNSTI4 1
ASGNI4
line 341
;341:	s_main.menu.wrapAround = qtrue;
ADDRGP4 s_main+404
CNSTI4 1
ASGNI4
line 342
;342:	s_main.menu.showlogo = qtrue;
ADDRGP4 s_main+412
CNSTI4 1
ASGNI4
line 344
;343:
;344:	y = 134;
ADDRLP4 0
CNSTI4 134
ASGNI4
line 345
;345:	y -= 1.5 * MAIN_MENU_VERTICAL_SPACING;	// JUHOX
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1112276992
SUBF4
CVFI4 4
ASGNI4
line 346
;346:	s_main.singleplayer.generic.type		= MTYPE_PTEXT;
ADDRGP4 s_main+424
CNSTI4 9
ASGNI4
line 347
;347:	s_main.singleplayer.generic.flags		= /*QMF_CENTER_JUSTIFY*/QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;	// JUHOX
ADDRGP4 s_main+424+44
CNSTU4 272
ASGNU4
line 348
;348:	s_main.singleplayer.generic.x			= /*320*/620;	// JUHOX
ADDRGP4 s_main+424+12
CNSTI4 620
ASGNI4
line 349
;349:	s_main.singleplayer.generic.y			= y;
ADDRGP4 s_main+424+16
ADDRLP4 0
INDIRI4
ASGNI4
line 350
;350:	s_main.singleplayer.generic.id			= ID_SINGLEPLAYER;
ADDRGP4 s_main+424+8
CNSTI4 10
ASGNI4
line 351
;351:	s_main.singleplayer.generic.callback	= Main_MenuEvent; 
ADDRGP4 s_main+424+48
ADDRGP4 Main_MenuEvent
ASGNP4
line 352
;352:	s_main.singleplayer.string				= "SINGLE PLAYER";
ADDRGP4 s_main+424+60
ADDRGP4 $197
ASGNP4
line 353
;353:	s_main.singleplayer.color				= color_red;
ADDRGP4 s_main+424+68
ADDRGP4 color_red
ASGNP4
line 354
;354:	s_main.singleplayer.style				= style;
ADDRGP4 s_main+424+64
ADDRLP4 4
INDIRI4
ASGNI4
line 356
;355:
;356:	y += MAIN_MENU_VERTICAL_SPACING;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 34
ADDI4
ASGNI4
line 357
;357:	s_main.multiplayer.generic.type			= MTYPE_PTEXT;
ADDRGP4 s_main+496
CNSTI4 9
ASGNI4
line 358
;358:	s_main.multiplayer.generic.flags		= /*QMF_CENTER_JUSTIFY*/QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;	// JUHOX
ADDRGP4 s_main+496+44
CNSTU4 272
ASGNU4
line 359
;359:	s_main.multiplayer.generic.x			= /*320*/620;	// JUHOX
ADDRGP4 s_main+496+12
CNSTI4 620
ASGNI4
line 360
;360:	s_main.multiplayer.generic.y			= y;
ADDRGP4 s_main+496+16
ADDRLP4 0
INDIRI4
ASGNI4
line 361
;361:	s_main.multiplayer.generic.id			= ID_MULTIPLAYER;
ADDRGP4 s_main+496+8
CNSTI4 11
ASGNI4
line 362
;362:	s_main.multiplayer.generic.callback		= Main_MenuEvent; 
ADDRGP4 s_main+496+48
ADDRGP4 Main_MenuEvent
ASGNP4
line 363
;363:	s_main.multiplayer.string				= "MULTIPLAYER";
ADDRGP4 s_main+496+60
ADDRGP4 $215
ASGNP4
line 364
;364:	s_main.multiplayer.color				= color_red;
ADDRGP4 s_main+496+68
ADDRGP4 color_red
ASGNP4
line 365
;365:	s_main.multiplayer.style				= style;
ADDRGP4 s_main+496+64
ADDRLP4 4
INDIRI4
ASGNI4
line 367
;366:
;367:	y += MAIN_MENU_VERTICAL_SPACING;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 34
ADDI4
ASGNI4
line 368
;368:	y += 1.5 * MAIN_MENU_VERTICAL_SPACING;	// JUHOX
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1112276992
ADDF4
CVFI4 4
ASGNI4
line 369
;369:	s_main.setup.generic.type				= MTYPE_PTEXT;
ADDRGP4 s_main+568
CNSTI4 9
ASGNI4
line 370
;370:	s_main.setup.generic.flags				= /*QMF_CENTER_JUSTIFY*/QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;	// JUHOX
ADDRGP4 s_main+568+44
CNSTU4 272
ASGNU4
line 371
;371:	s_main.setup.generic.x					= /*320*/620;	// JUHOX
ADDRGP4 s_main+568+12
CNSTI4 620
ASGNI4
line 372
;372:	s_main.setup.generic.y					= y;
ADDRGP4 s_main+568+16
ADDRLP4 0
INDIRI4
ASGNI4
line 373
;373:	s_main.setup.generic.id					= ID_SETUP;
ADDRGP4 s_main+568+8
CNSTI4 12
ASGNI4
line 374
;374:	s_main.setup.generic.callback			= Main_MenuEvent; 
ADDRGP4 s_main+568+48
ADDRGP4 Main_MenuEvent
ASGNP4
line 375
;375:	s_main.setup.string						= "SETUP";
ADDRGP4 s_main+568+60
ADDRGP4 $233
ASGNP4
line 376
;376:	s_main.setup.color						= color_red;
ADDRGP4 s_main+568+68
ADDRGP4 color_red
ASGNP4
line 377
;377:	s_main.setup.style						= style;
ADDRGP4 s_main+568+64
ADDRLP4 4
INDIRI4
ASGNI4
line 379
;378:
;379:	y += MAIN_MENU_VERTICAL_SPACING;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 34
ADDI4
ASGNI4
line 380
;380:	s_main.demos.generic.type				= MTYPE_PTEXT;
ADDRGP4 s_main+640
CNSTI4 9
ASGNI4
line 381
;381:	s_main.demos.generic.flags				= /*QMF_CENTER_JUSTIFY*/QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;	// JUHOX
ADDRGP4 s_main+640+44
CNSTU4 272
ASGNU4
line 382
;382:	s_main.demos.generic.x					= /*320*/620;	// JUHOX
ADDRGP4 s_main+640+12
CNSTI4 620
ASGNI4
line 383
;383:	s_main.demos.generic.y					= y;
ADDRGP4 s_main+640+16
ADDRLP4 0
INDIRI4
ASGNI4
line 384
;384:	s_main.demos.generic.id					= ID_DEMOS;
ADDRGP4 s_main+640+8
CNSTI4 13
ASGNI4
line 385
;385:	s_main.demos.generic.callback			= Main_MenuEvent; 
ADDRGP4 s_main+640+48
ADDRGP4 Main_MenuEvent
ASGNP4
line 386
;386:	s_main.demos.string						= "DEMOS";
ADDRGP4 s_main+640+60
ADDRGP4 $251
ASGNP4
line 387
;387:	s_main.demos.color						= color_red;
ADDRGP4 s_main+640+68
ADDRGP4 color_red
ASGNP4
line 388
;388:	s_main.demos.style						= style;
ADDRGP4 s_main+640+64
ADDRLP4 4
INDIRI4
ASGNI4
line 390
;389:
;390:	y += MAIN_MENU_VERTICAL_SPACING;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 34
ADDI4
ASGNI4
line 391
;391:	y += 3.5 * MAIN_MENU_VERTICAL_SPACING;	// JUHOX
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1122893824
ADDF4
CVFI4 4
ASGNI4
line 392
;392:	s_main.cinematics.generic.type			= MTYPE_PTEXT;
ADDRGP4 s_main+712
CNSTI4 9
ASGNI4
line 393
;393:	s_main.cinematics.generic.flags			= /*QMF_CENTER_JUSTIFY*/QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;	// JUHOX
ADDRGP4 s_main+712+44
CNSTU4 272
ASGNU4
line 394
;394:	s_main.cinematics.generic.x				= /*320*/620;	// JUHOX
ADDRGP4 s_main+712+12
CNSTI4 620
ASGNI4
line 395
;395:	s_main.cinematics.generic.y				= y;
ADDRGP4 s_main+712+16
ADDRLP4 0
INDIRI4
ASGNI4
line 396
;396:	s_main.cinematics.generic.id			= ID_CINEMATICS;
ADDRGP4 s_main+712+8
CNSTI4 14
ASGNI4
line 397
;397:	s_main.cinematics.generic.callback		= Main_MenuEvent; 
ADDRGP4 s_main+712+48
ADDRGP4 Main_MenuEvent
ASGNP4
line 398
;398:	s_main.cinematics.string				= "CINEMATICS";
ADDRGP4 s_main+712+60
ADDRGP4 $269
ASGNP4
line 399
;399:	s_main.cinematics.color					= color_red;
ADDRGP4 s_main+712+68
ADDRGP4 color_red
ASGNP4
line 400
;400:	s_main.cinematics.style					= style;
ADDRGP4 s_main+712+64
ADDRLP4 4
INDIRI4
ASGNI4
line 404
;401:
;402:	// JUHOX: init credits button
;403:#if 1
;404:	s_main.credits.generic.type			= MTYPE_PTEXT;
ADDRGP4 s_main+1000
CNSTI4 9
ASGNI4
line 405
;405:	s_main.credits.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_main+1000+44
CNSTU4 260
ASGNU4
line 406
;406:	s_main.credits.generic.x			= 20;
ADDRGP4 s_main+1000+12
CNSTI4 20
ASGNI4
line 407
;407:	s_main.credits.generic.y			= y;
ADDRGP4 s_main+1000+16
ADDRLP4 0
INDIRI4
ASGNI4
line 408
;408:	s_main.credits.generic.id			= ID_CREDITS;
ADDRGP4 s_main+1000+8
CNSTI4 18
ASGNI4
line 409
;409:	s_main.credits.generic.callback		= Main_MenuEvent; 
ADDRGP4 s_main+1000+48
ADDRGP4 Main_MenuEvent
ASGNP4
line 410
;410:	s_main.credits.string				= "CREDITS";
ADDRGP4 s_main+1000+60
ADDRGP4 $287
ASGNP4
line 411
;411:	s_main.credits.color				= color_red;
ADDRGP4 s_main+1000+68
ADDRGP4 color_red
ASGNP4
line 412
;412:	s_main.credits.style				= UI_LEFT | UI_DROPSHADOW;
ADDRGP4 s_main+1000+64
CNSTI4 2048
ASGNI4
line 415
;413:#endif
;414:
;415:	y -= 4.5 * MAIN_MENU_VERTICAL_SPACING;	// JUHOX
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1125711872
SUBF4
CVFI4 4
ASGNI4
line 417
;416:
;417:	if (UI_TeamArenaExists()) {
ADDRLP4 24
ADDRGP4 UI_TeamArenaExists
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $292
line 418
;418:		teamArena = qtrue;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 419
;419:		y += MAIN_MENU_VERTICAL_SPACING;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 34
ADDI4
ASGNI4
line 420
;420:		s_main.teamArena.generic.type			= MTYPE_PTEXT;
ADDRGP4 s_main+784
CNSTI4 9
ASGNI4
line 421
;421:		s_main.teamArena.generic.flags			= /*QMF_CENTER_JUSTIFY*/QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;	// JUHOX
ADDRGP4 s_main+784+44
CNSTU4 272
ASGNU4
line 422
;422:		s_main.teamArena.generic.x				= /*320*/620;	// JUHOX
ADDRGP4 s_main+784+12
CNSTI4 620
ASGNI4
line 423
;423:		s_main.teamArena.generic.y				= y;
ADDRGP4 s_main+784+16
ADDRLP4 0
INDIRI4
ASGNI4
line 424
;424:		s_main.teamArena.generic.id				= ID_TEAMARENA;
ADDRGP4 s_main+784+8
CNSTI4 15
ASGNI4
line 425
;425:		s_main.teamArena.generic.callback		= Main_MenuEvent; 
ADDRGP4 s_main+784+48
ADDRGP4 Main_MenuEvent
ASGNP4
line 426
;426:		s_main.teamArena.string					= "TEAM ARENA";
ADDRGP4 s_main+784+60
ADDRGP4 $307
ASGNP4
line 427
;427:		s_main.teamArena.color					= color_red;
ADDRGP4 s_main+784+68
ADDRGP4 color_red
ASGNP4
line 428
;428:		s_main.teamArena.style					= style;
ADDRGP4 s_main+784+64
ADDRLP4 4
INDIRI4
ASGNI4
line 429
;429:	}
LABELV $292
line 431
;430:
;431:	y += MAIN_MENU_VERTICAL_SPACING;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 34
ADDI4
ASGNI4
line 432
;432:	s_main.mods.generic.type			= MTYPE_PTEXT;
ADDRGP4 s_main+856
CNSTI4 9
ASGNI4
line 433
;433:	s_main.mods.generic.flags			= /*QMF_CENTER_JUSTIFY*/QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;	// JUHOX
ADDRGP4 s_main+856+44
CNSTU4 272
ASGNU4
line 434
;434:	s_main.mods.generic.x				= /*320*/620;	// JUHOX
ADDRGP4 s_main+856+12
CNSTI4 620
ASGNI4
line 435
;435:	s_main.mods.generic.y				= y;
ADDRGP4 s_main+856+16
ADDRLP4 0
INDIRI4
ASGNI4
line 436
;436:	s_main.mods.generic.id				= ID_MODS;
ADDRGP4 s_main+856+8
CNSTI4 16
ASGNI4
line 437
;437:	s_main.mods.generic.callback		= Main_MenuEvent; 
ADDRGP4 s_main+856+48
ADDRGP4 Main_MenuEvent
ASGNP4
line 438
;438:	s_main.mods.string					= "MODS";
ADDRGP4 s_main+856+60
ADDRGP4 $325
ASGNP4
line 439
;439:	s_main.mods.color					= color_red;
ADDRGP4 s_main+856+68
ADDRGP4 color_red
ASGNP4
line 440
;440:	s_main.mods.style					= style;
ADDRGP4 s_main+856+64
ADDRLP4 4
INDIRI4
ASGNI4
line 442
;441:
;442:	y += MAIN_MENU_VERTICAL_SPACING;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 34
ADDI4
ASGNI4
line 443
;443:	s_main.exit.generic.type				= MTYPE_PTEXT;
ADDRGP4 s_main+928
CNSTI4 9
ASGNI4
line 444
;444:	s_main.exit.generic.flags				= /*QMF_CENTER_JUSTIFY*/QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;	// JUHOX
ADDRGP4 s_main+928+44
CNSTU4 272
ASGNU4
line 445
;445:	s_main.exit.generic.x					= /*320*/620;	// JUHOX
ADDRGP4 s_main+928+12
CNSTI4 620
ASGNI4
line 446
;446:	s_main.exit.generic.y					= y;
ADDRGP4 s_main+928+16
ADDRLP4 0
INDIRI4
ASGNI4
line 447
;447:	s_main.exit.generic.id					= ID_EXIT;
ADDRGP4 s_main+928+8
CNSTI4 17
ASGNI4
line 448
;448:	s_main.exit.generic.callback			= Main_MenuEvent; 
ADDRGP4 s_main+928+48
ADDRGP4 Main_MenuEvent
ASGNP4
line 449
;449:	s_main.exit.string						= "EXIT";
ADDRGP4 s_main+928+60
ADDRGP4 $343
ASGNP4
line 450
;450:	s_main.exit.color						= color_red;
ADDRGP4 s_main+928+68
ADDRGP4 color_red
ASGNP4
line 451
;451:	s_main.exit.style						= style;
ADDRGP4 s_main+928+64
ADDRLP4 4
INDIRI4
ASGNI4
line 453
;452:
;453:	Menu_AddItem( &s_main.menu,	&s_main.singleplayer );
ADDRGP4 s_main
ARGP4
ADDRGP4 s_main+424
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 454
;454:	Menu_AddItem( &s_main.menu,	&s_main.multiplayer );
ADDRGP4 s_main
ARGP4
ADDRGP4 s_main+496
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 455
;455:	Menu_AddItem( &s_main.menu,	&s_main.setup );
ADDRGP4 s_main
ARGP4
ADDRGP4 s_main+568
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 456
;456:	Menu_AddItem( &s_main.menu,	&s_main.demos );
ADDRGP4 s_main
ARGP4
ADDRGP4 s_main+640
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 465
;457:#if 0	// JUHOX: attend to new menu item order for proper keyboard selection
;458:	Menu_AddItem( &s_main.menu,	&s_main.cinematics );
;459:	if (teamArena) {
;460:		Menu_AddItem( &s_main.menu,	&s_main.teamArena );
;461:	}
;462:	Menu_AddItem( &s_main.menu,	&s_main.mods );
;463:	Menu_AddItem( &s_main.menu,	&s_main.exit );             
;464:#else
;465:	if (teamArena) {
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $352
line 466
;466:		Menu_AddItem(&s_main.menu, &s_main.teamArena);
ADDRGP4 s_main
ARGP4
ADDRGP4 s_main+784
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 467
;467:	}
LABELV $352
line 468
;468:	Menu_AddItem( &s_main.menu,	&s_main.mods );
ADDRGP4 s_main
ARGP4
ADDRGP4 s_main+856
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 469
;469:	Menu_AddItem( &s_main.menu,	&s_main.exit );             
ADDRGP4 s_main
ARGP4
ADDRGP4 s_main+928
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 470
;470:	Menu_AddItem( &s_main.menu,	&s_main.cinematics );
ADDRGP4 s_main
ARGP4
ADDRGP4 s_main+712
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 474
;471:#endif
;472:
;473:#if 1	// JUHOX: add credits button
;474:	Menu_AddItem(&s_main.menu, &s_main.credits);
ADDRGP4 s_main
ARGP4
ADDRGP4 s_main+1000
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 477
;475:#endif
;476:
;477:	trap_Key_SetCatcher( KEYCATCH_UI );
CNSTI4 2
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 478
;478:	uis.menusp = 0;
ADDRGP4 uis+16
CNSTI4 0
ASGNI4
line 479
;479:	UI_PushMenu ( &s_main.menu );
ADDRGP4 s_main
ARGP4
ADDRGP4 UI_PushMenu
CALLV
pop
line 482
;480:#if 1	// JUHOX: play the title music
;481:	//trap_S_StartBackgroundTrack("music/hunt.wav", "");
;482:	uis.startTitleMusic = qtrue;
ADDRGP4 uis+95108
CNSTI4 1
ASGNI4
line 485
;483:#endif
;484:
;485:}
LABELV $153
endproc UI_MainMenu 36 12
bss
align 4
LABELV s_errorMessage
skip 4520
align 4
LABELV s_main
skip 1076
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
LABELV $343
byte 1 69
byte 1 88
byte 1 73
byte 1 84
byte 1 0
align 1
LABELV $325
byte 1 77
byte 1 79
byte 1 68
byte 1 83
byte 1 0
align 1
LABELV $307
byte 1 84
byte 1 69
byte 1 65
byte 1 77
byte 1 32
byte 1 65
byte 1 82
byte 1 69
byte 1 78
byte 1 65
byte 1 0
align 1
LABELV $287
byte 1 67
byte 1 82
byte 1 69
byte 1 68
byte 1 73
byte 1 84
byte 1 83
byte 1 0
align 1
LABELV $269
byte 1 67
byte 1 73
byte 1 78
byte 1 69
byte 1 77
byte 1 65
byte 1 84
byte 1 73
byte 1 67
byte 1 83
byte 1 0
align 1
LABELV $251
byte 1 68
byte 1 69
byte 1 77
byte 1 79
byte 1 83
byte 1 0
align 1
LABELV $233
byte 1 83
byte 1 69
byte 1 84
byte 1 85
byte 1 80
byte 1 0
align 1
LABELV $215
byte 1 77
byte 1 85
byte 1 76
byte 1 84
byte 1 73
byte 1 80
byte 1 76
byte 1 65
byte 1 89
byte 1 69
byte 1 82
byte 1 0
align 1
LABELV $197
byte 1 83
byte 1 73
byte 1 78
byte 1 71
byte 1 76
byte 1 69
byte 1 32
byte 1 80
byte 1 76
byte 1 65
byte 1 89
byte 1 69
byte 1 82
byte 1 0
align 1
LABELV $168
byte 1 48
byte 1 0
align 1
LABELV $167
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
LABELV $165
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
LABELV $164
byte 1 117
byte 1 105
byte 1 95
byte 1 105
byte 1 110
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $155
byte 1 49
byte 1 0
align 1
LABELV $154
byte 1 115
byte 1 118
byte 1 95
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $146
byte 1 36
byte 1 109
byte 1 111
byte 1 100
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $143
byte 1 109
byte 1 117
byte 1 115
byte 1 105
byte 1 99
byte 1 47
byte 1 104
byte 1 117
byte 1 110
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $139
byte 1 79
byte 1 112
byte 1 101
byte 1 110
byte 1 72
byte 1 117
byte 1 110
byte 1 116
byte 1 32
byte 1 77
byte 1 111
byte 1 100
byte 1 32
byte 1 45
byte 1 32
byte 1 74
byte 1 97
byte 1 110
byte 1 32
byte 1 50
byte 1 48
byte 1 32
byte 1 50
byte 1 48
byte 1 49
byte 1 57
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
byte 1 119
byte 1 119
byte 1 119
byte 1 46
byte 1 112
byte 1 108
byte 1 97
byte 1 110
byte 1 101
byte 1 116
byte 1 113
byte 1 117
byte 1 97
byte 1 107
byte 1 101
byte 1 46
byte 1 99
byte 1 111
byte 1 109
byte 1 47
byte 1 109
byte 1 111
byte 1 100
byte 1 105
byte 1 102
byte 1 105
byte 1 97
byte 1 0
align 1
LABELV $136
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
byte 1 40
byte 1 99
byte 1 41
byte 1 32
byte 1 49
byte 1 57
byte 1 57
byte 1 57
byte 1 45
byte 1 50
byte 1 48
byte 1 48
byte 1 48
byte 1 44
byte 1 32
byte 1 73
byte 1 100
byte 1 32
byte 1 83
byte 1 111
byte 1 102
byte 1 116
byte 1 119
byte 1 97
byte 1 114
byte 1 101
byte 1 44
byte 1 32
byte 1 73
byte 1 110
byte 1 99
byte 1 46
byte 1 32
byte 1 32
byte 1 65
byte 1 108
byte 1 108
byte 1 32
byte 1 82
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 115
byte 1 32
byte 1 82
byte 1 101
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $135
byte 1 68
byte 1 69
byte 1 77
byte 1 79
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 70
byte 1 79
byte 1 82
byte 1 32
byte 1 77
byte 1 65
byte 1 84
byte 1 85
byte 1 82
byte 1 69
byte 1 32
byte 1 65
byte 1 85
byte 1 68
byte 1 73
byte 1 69
byte 1 78
byte 1 67
byte 1 69
byte 1 83
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 68
byte 1 69
byte 1 77
byte 1 79
byte 1 0
align 1
LABELV $125
byte 1 0
align 1
LABELV $124
byte 1 99
byte 1 111
byte 1 109
byte 1 95
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 77
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $118
byte 1 69
byte 1 88
byte 1 73
byte 1 84
byte 1 32
byte 1 71
byte 1 65
byte 1 77
byte 1 69
byte 1 63
byte 1 0
align 1
LABELV $116
byte 1 118
byte 1 105
byte 1 100
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 59
byte 1 0
align 1
LABELV $115
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $114
byte 1 102
byte 1 115
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 0
