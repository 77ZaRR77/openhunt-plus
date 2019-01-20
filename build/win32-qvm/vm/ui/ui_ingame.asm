code
proc InGame_RestartAction 4 8
file "..\..\..\..\code\q3_ui\ui_ingame.c"
line 63
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:/*
;4:=======================================================================
;5:
;6:INGAME MENU
;7:
;8:=======================================================================
;9:*/
;10:
;11:
;12:#include "ui_local.h"
;13:
;14:
;15:#define INGAME_FRAME					"menu/art/addbotframe"
;16://#define INGAME_FRAME					"menu/art/cut_frame"
;17:#define INGAME_MENU_VERTICAL_SPACING	28
;18:
;19:#define ID_TEAM					10
;20:#define ID_ADDBOTS				11
;21:#define ID_REMOVEBOTS			12
;22:#define ID_SETUP				13
;23:#define ID_SERVERINFO			14
;24:#define ID_LEAVEARENA			15
;25:#define ID_RESTART				16
;26:#define ID_QUIT					17
;27:#define ID_RESUME				18
;28:	// JUHOX: no team orders menu
;29:#if 0
;30:#define ID_TEAMORDERS			19
;31:#endif
;32:#define ID_GAMETEMPLATES		20	// JUHOX
;33:
;34:
;35:typedef struct {
;36:	menuframework_s	menu;
;37:
;38:	menubitmap_s	frame;
;39:	menutext_s		team;
;40:	menutext_s		gametemplates;	// JUHOX
;41:	menutext_s		setup;
;42:	menutext_s		server;
;43:	menutext_s		leave;
;44:	menutext_s		restart;
;45:	menutext_s		addbots;
;46:	menutext_s		removebots;
;47:	// JUHOX: no team orders menu
;48:#if 0
;49:	menutext_s		teamorders;
;50:#endif
;51:	menutext_s		quit;
;52:	menutext_s		resume;
;53:} ingamemenu_t;
;54:
;55:static ingamemenu_t	s_ingame;
;56:
;57:
;58:/*
;59:=================
;60:InGame_RestartAction
;61:=================
;62:*/
;63:static void InGame_RestartAction( qboolean result ) {
line 64
;64:	if( !result ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $98
line 65
;65:		return;
ADDRGP4 $97
JUMPV
LABELV $98
line 68
;66:	}
;67:
;68:	UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 73
;69:	// JUHOX: callvote for a map_restart if server is non-local
;70:#if 0
;71:	trap_Cmd_ExecuteText( EXEC_APPEND, "map_restart 0\n" );
;72:#else
;73:	if (trap_Cvar_VariableValue( "sv_running")) {
ADDRGP4 $102
ARGP4
ADDRLP4 0
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 0
INDIRF4
CNSTF4 0
EQF4 $100
line 74
;74:		trap_Cmd_ExecuteText(EXEC_APPEND, "map_restart 0\n");
CNSTI4 2
ARGI4
ADDRGP4 $103
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 75
;75:	}
ADDRGP4 $101
JUMPV
LABELV $100
line 76
;76:	else {
line 77
;77:		trap_Cmd_ExecuteText(EXEC_APPEND, "callvote map_restart 0\n");
CNSTI4 2
ARGI4
ADDRGP4 $104
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 78
;78:	}
LABELV $101
line 80
;79:#endif
;80:}
LABELV $97
endproc InGame_RestartAction 4 8
proc InGame_QuitAction 0 0
line 88
;81:
;82:
;83:/*
;84:=================
;85:InGame_QuitAction
;86:=================
;87:*/
;88:static void InGame_QuitAction( qboolean result ) {
line 89
;89:	if( !result ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $106
line 90
;90:		return;
ADDRGP4 $105
JUMPV
LABELV $106
line 92
;91:	}
;92:	UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 93
;93:	UI_CreditMenu();
ADDRGP4 UI_CreditMenu
CALLV
pop
line 94
;94:}
LABELV $105
endproc InGame_QuitAction 0 0
export InGame_Event
proc InGame_Event 8 12
line 102
;95:
;96:
;97:/*
;98:=================
;99:InGame_Event
;100:=================
;101:*/
;102:void InGame_Event( void *ptr, int notification ) {
line 103
;103:	if( notification != QM_ACTIVATED ) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $109
line 104
;104:		return;
ADDRGP4 $108
JUMPV
LABELV $109
line 107
;105:	}
;106:
;107:	switch( ((menucommon_s*)ptr)->id ) {
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
LTI4 $111
ADDRLP4 0
INDIRI4
CNSTI4 20
GTI4 $111
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $129-40
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $129
address $114
address $125
address $126
address $115
address $124
address $116
address $120
address $122
address $127
address $111
address $128
code
LABELV $114
line 109
;108:	case ID_TEAM:
;109:		UI_TeamMainMenu();
ADDRGP4 UI_TeamMainMenu
CALLV
pop
line 110
;110:		break;
ADDRGP4 $112
JUMPV
LABELV $115
line 113
;111:
;112:	case ID_SETUP:
;113:		UI_SetupMenu();
ADDRGP4 UI_SetupMenu
CALLV
pop
line 114
;114:		break;
ADDRGP4 $112
JUMPV
LABELV $116
line 119
;115:
;116:	case ID_LEAVEARENA:
;117:		// JUHOX: reset edit mode
;118:#if MAPLENSFLARES
;119:		trap_Cvar_Set("g_editmode", "0");
ADDRGP4 $117
ARGP4
ADDRGP4 $118
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 121
;120:#endif
;121:		trap_Cmd_ExecuteText( EXEC_APPEND, "disconnect\n" );
CNSTI4 2
ARGI4
ADDRGP4 $119
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 122
;122:		break;
ADDRGP4 $112
JUMPV
LABELV $120
line 125
;123:
;124:	case ID_RESTART:
;125:		UI_ConfirmMenu( "RESTART ARENA?", (voidfunc_f)NULL, InGame_RestartAction );
ADDRGP4 $121
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 InGame_RestartAction
ARGP4
ADDRGP4 UI_ConfirmMenu
CALLV
pop
line 126
;126:		break;
ADDRGP4 $112
JUMPV
LABELV $122
line 129
;127:
;128:	case ID_QUIT:
;129:		UI_ConfirmMenu( "EXIT GAME?", (voidfunc_f)NULL, InGame_QuitAction );
ADDRGP4 $123
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 InGame_QuitAction
ARGP4
ADDRGP4 UI_ConfirmMenu
CALLV
pop
line 130
;130:		break;
ADDRGP4 $112
JUMPV
LABELV $124
line 133
;131:
;132:	case ID_SERVERINFO:
;133:		UI_ServerInfoMenu();
ADDRGP4 UI_ServerInfoMenu
CALLV
pop
line 134
;134:		break;
ADDRGP4 $112
JUMPV
LABELV $125
line 137
;135:
;136:	case ID_ADDBOTS:
;137:		UI_AddBotsMenu();
ADDRGP4 UI_AddBotsMenu
CALLV
pop
line 138
;138:		break;
ADDRGP4 $112
JUMPV
LABELV $126
line 141
;139:
;140:	case ID_REMOVEBOTS:
;141:		UI_RemoveBotsMenu();
ADDRGP4 UI_RemoveBotsMenu
CALLV
pop
line 142
;142:		break;
ADDRGP4 $112
JUMPV
LABELV $127
line 151
;143:
;144:#if 0	// JUHOX: no team orders menu
;145:	case ID_TEAMORDERS:
;146:		UI_TeamOrdersMenu();
;147:		break;
;148:#endif
;149:
;150:	case ID_RESUME:
;151:		UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 152
;152:		break;
ADDRGP4 $112
JUMPV
LABELV $128
line 156
;153:
;154:#if 1	// JUHOX: game templates menu event
;155:	case ID_GAMETEMPLATES:
;156:		UI_TemplateMenu(qtrue, qfalse);
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 UI_TemplateMenu
CALLV
pop
line 157
;157:		break;
LABELV $111
LABELV $112
line 160
;158:#endif
;159:	}
;160:}
LABELV $108
endproc InGame_Event 8 12
export InGame_MenuInit
proc InGame_MenuInit 48 12
line 168
;161:
;162:
;163:/*
;164:=================
;165:InGame_MenuInit
;166:=================
;167:*/
;168:void InGame_MenuInit( void ) {
line 176
;169:	int		y;
;170:#if 0	// JUHOX: no team orders menu
;171:	uiClientState_t	cs;
;172:	char	info[MAX_INFO_STRING];
;173:	int		team;
;174:#endif
;175:
;176:	memset( &s_ingame, 0 ,sizeof(ingamemenu_t) );
ADDRGP4 s_ingame
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1232
ARGI4
ADDRGP4 memset
CALLP4
pop
line 178
;177:
;178:	InGame_Cache();
ADDRGP4 InGame_Cache
CALLV
pop
line 180
;179:
;180:	s_ingame.menu.wrapAround = qtrue;
ADDRGP4 s_ingame+404
CNSTI4 1
ASGNI4
line 181
;181:	s_ingame.menu.fullscreen = qfalse;
ADDRGP4 s_ingame+408
CNSTI4 0
ASGNI4
line 183
;182:
;183:	s_ingame.frame.generic.type			= MTYPE_BITMAP;
ADDRGP4 s_ingame+424
CNSTI4 6
ASGNI4
line 184
;184:	s_ingame.frame.generic.flags		= QMF_INACTIVE;
ADDRGP4 s_ingame+424+44
CNSTU4 16384
ASGNU4
line 185
;185:	s_ingame.frame.generic.name			= INGAME_FRAME;
ADDRGP4 s_ingame+424+4
ADDRGP4 $139
ASGNP4
line 186
;186:	s_ingame.frame.generic.x			= 320-233;//142;
ADDRGP4 s_ingame+424+12
CNSTI4 87
ASGNI4
line 187
;187:	s_ingame.frame.generic.y			= 240-166;//118;
ADDRGP4 s_ingame+424+16
CNSTI4 74
ASGNI4
line 188
;188:	s_ingame.frame.width				= 466;//359;
ADDRGP4 s_ingame+424+76
CNSTI4 466
ASGNI4
line 189
;189:	s_ingame.frame.height				= 332;//256;
ADDRGP4 s_ingame+424+80
CNSTI4 332
ASGNI4
line 192
;190:
;191:	//y = 96;
;192:	y = 88;
ADDRLP4 0
CNSTI4 88
ASGNI4
line 193
;193:	y += 0.5*INGAME_MENU_VERTICAL_SPACING;	// JUHOX: compensate the missing menus
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1096810496
ADDF4
CVFI4 4
ASGNI4
line 194
;194:	s_ingame.team.generic.type			= MTYPE_PTEXT;
ADDRGP4 s_ingame+512
CNSTI4 9
ASGNI4
line 195
;195:	s_ingame.team.generic.flags			= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_ingame+512+44
CNSTU4 264
ASGNU4
line 196
;196:	s_ingame.team.generic.x				= 320;
ADDRGP4 s_ingame+512+12
CNSTI4 320
ASGNI4
line 197
;197:	s_ingame.team.generic.y				= y;
ADDRGP4 s_ingame+512+16
ADDRLP4 0
INDIRI4
ASGNI4
line 198
;198:	s_ingame.team.generic.id			= ID_TEAM;
ADDRGP4 s_ingame+512+8
CNSTI4 10
ASGNI4
line 199
;199:	s_ingame.team.generic.callback		= InGame_Event; 
ADDRGP4 s_ingame+512+48
ADDRGP4 InGame_Event
ASGNP4
line 200
;200:	s_ingame.team.string				= "START";
ADDRGP4 s_ingame+512+60
ADDRGP4 $161
ASGNP4
line 201
;201:	s_ingame.team.color					= color_red;
ADDRGP4 s_ingame+512+68
ADDRGP4 color_red
ASGNP4
line 202
;202:	s_ingame.team.style					= UI_CENTER|UI_SMALLFONT;
ADDRGP4 s_ingame+512+64
CNSTI4 17
ASGNI4
line 205
;203:
;204:#if 1	// JUHOX: init in-game game templates menu item
;205:	y += INGAME_MENU_VERTICAL_SPACING;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 28
ADDI4
ASGNI4
line 206
;206:	s_ingame.gametemplates.generic.type		= MTYPE_PTEXT;
ADDRGP4 s_ingame+584
CNSTI4 9
ASGNI4
line 207
;207:	s_ingame.gametemplates.generic.flags	= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_ingame+584+44
CNSTU4 264
ASGNU4
line 208
;208:	s_ingame.gametemplates.generic.x		= 320;
ADDRGP4 s_ingame+584+12
CNSTI4 320
ASGNI4
line 209
;209:	s_ingame.gametemplates.generic.y		= y;
ADDRGP4 s_ingame+584+16
ADDRLP4 0
INDIRI4
ASGNI4
line 210
;210:	s_ingame.gametemplates.generic.id		= ID_GAMETEMPLATES;
ADDRGP4 s_ingame+584+8
CNSTI4 20
ASGNI4
line 211
;211:	s_ingame.gametemplates.generic.callback	= InGame_Event; 
ADDRGP4 s_ingame+584+48
ADDRGP4 InGame_Event
ASGNP4
line 212
;212:	s_ingame.gametemplates.string			= "GAME TEMPLATES";
ADDRGP4 s_ingame+584+60
ADDRGP4 $179
ASGNP4
line 213
;213:	s_ingame.gametemplates.color			= color_red;
ADDRGP4 s_ingame+584+68
ADDRGP4 color_red
ASGNP4
line 214
;214:	s_ingame.gametemplates.style			= UI_CENTER|UI_SMALLFONT;
ADDRGP4 s_ingame+584+64
CNSTI4 17
ASGNI4
line 217
;215:#endif
;216:
;217:	y += INGAME_MENU_VERTICAL_SPACING;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 28
ADDI4
ASGNI4
line 218
;218:	s_ingame.addbots.generic.type		= MTYPE_PTEXT;
ADDRGP4 s_ingame+944
CNSTI4 9
ASGNI4
line 219
;219:	s_ingame.addbots.generic.flags		= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_ingame+944+44
CNSTU4 264
ASGNU4
line 220
;220:	s_ingame.addbots.generic.x			= 320;
ADDRGP4 s_ingame+944+12
CNSTI4 320
ASGNI4
line 221
;221:	s_ingame.addbots.generic.y			= y;
ADDRGP4 s_ingame+944+16
ADDRLP4 0
INDIRI4
ASGNI4
line 222
;222:	s_ingame.addbots.generic.id			= ID_ADDBOTS;
ADDRGP4 s_ingame+944+8
CNSTI4 11
ASGNI4
line 223
;223:	s_ingame.addbots.generic.callback	= InGame_Event; 
ADDRGP4 s_ingame+944+48
ADDRGP4 InGame_Event
ASGNP4
line 224
;224:	s_ingame.addbots.string				= "ADD BOTS";
ADDRGP4 s_ingame+944+60
ADDRGP4 $197
ASGNP4
line 225
;225:	s_ingame.addbots.color				= color_red;
ADDRGP4 s_ingame+944+68
ADDRGP4 color_red
ASGNP4
line 226
;226:	s_ingame.addbots.style				= UI_CENTER|UI_SMALLFONT;
ADDRGP4 s_ingame+944+64
CNSTI4 17
ASGNI4
line 227
;227:	if( !trap_Cvar_VariableValue( "sv_running" ) || !trap_Cvar_VariableValue( "bot_enable" ) || (trap_Cvar_VariableValue( "g_gametype" ) == GT_SINGLE_PLAYER)) {
ADDRGP4 $102
ARGP4
ADDRLP4 4
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
INDIRF4
CNSTF4 0
EQF4 $207
ADDRGP4 $204
ARGP4
ADDRLP4 8
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 8
INDIRF4
CNSTF4 0
EQF4 $207
ADDRGP4 $205
ARGP4
ADDRLP4 12
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 12
INDIRF4
CNSTF4 1073741824
NEF4 $202
LABELV $207
line 228
;228:		s_ingame.addbots.generic.flags |= QMF_GRAYED;
ADDRLP4 16
ADDRGP4 s_ingame+944+44
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
line 229
;229:	}
LABELV $202
line 231
;230:
;231:	y += INGAME_MENU_VERTICAL_SPACING;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 28
ADDI4
ASGNI4
line 232
;232:	s_ingame.removebots.generic.type		= MTYPE_PTEXT;
ADDRGP4 s_ingame+1016
CNSTI4 9
ASGNI4
line 233
;233:	s_ingame.removebots.generic.flags		= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_ingame+1016+44
CNSTU4 264
ASGNU4
line 234
;234:	s_ingame.removebots.generic.x			= 320;
ADDRGP4 s_ingame+1016+12
CNSTI4 320
ASGNI4
line 235
;235:	s_ingame.removebots.generic.y			= y;
ADDRGP4 s_ingame+1016+16
ADDRLP4 0
INDIRI4
ASGNI4
line 236
;236:	s_ingame.removebots.generic.id			= ID_REMOVEBOTS;
ADDRGP4 s_ingame+1016+8
CNSTI4 12
ASGNI4
line 237
;237:	s_ingame.removebots.generic.callback	= InGame_Event; 
ADDRGP4 s_ingame+1016+48
ADDRGP4 InGame_Event
ASGNP4
line 238
;238:	s_ingame.removebots.string				= "REMOVE BOTS";
ADDRGP4 s_ingame+1016+60
ADDRGP4 $223
ASGNP4
line 239
;239:	s_ingame.removebots.color				= color_red;
ADDRGP4 s_ingame+1016+68
ADDRGP4 color_red
ASGNP4
line 240
;240:	s_ingame.removebots.style				= UI_CENTER|UI_SMALLFONT;
ADDRGP4 s_ingame+1016+64
CNSTI4 17
ASGNI4
line 241
;241:	if( !trap_Cvar_VariableValue( "sv_running" ) || !trap_Cvar_VariableValue( "bot_enable" ) || (trap_Cvar_VariableValue( "g_gametype" ) == GT_SINGLE_PLAYER)) {
ADDRGP4 $102
ARGP4
ADDRLP4 16
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 16
INDIRF4
CNSTF4 0
EQF4 $231
ADDRGP4 $204
ARGP4
ADDRLP4 20
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 20
INDIRF4
CNSTF4 0
EQF4 $231
ADDRGP4 $205
ARGP4
ADDRLP4 24
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 24
INDIRF4
CNSTF4 1073741824
NEF4 $228
LABELV $231
line 242
;242:		s_ingame.removebots.generic.flags |= QMF_GRAYED;
ADDRLP4 28
ADDRGP4 s_ingame+1016+44
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
line 243
;243:	}
LABELV $228
line 269
;244:
;245:#if 0	// JUHOX: no team orders menu
;246:	y += INGAME_MENU_VERTICAL_SPACING;
;247:	s_ingame.teamorders.generic.type		= MTYPE_PTEXT;
;248:	s_ingame.teamorders.generic.flags		= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
;249:	s_ingame.teamorders.generic.x			= 320;
;250:	s_ingame.teamorders.generic.y			= y;
;251:	s_ingame.teamorders.generic.id			= ID_TEAMORDERS;
;252:	s_ingame.teamorders.generic.callback	= InGame_Event; 
;253:	s_ingame.teamorders.string				= "TEAM ORDERS";
;254:	s_ingame.teamorders.color				= color_red;
;255:	s_ingame.teamorders.style				= UI_CENTER|UI_SMALLFONT;
;256:	if( !(trap_Cvar_VariableValue( "g_gametype" ) >= GT_TEAM) ) {
;257:		s_ingame.teamorders.generic.flags |= QMF_GRAYED;
;258:	}
;259:	else {
;260:		trap_GetClientState( &cs );
;261:		trap_GetConfigString( CS_PLAYERS + cs.clientNum, info, MAX_INFO_STRING );
;262:		team = atoi( Info_ValueForKey( info, "t" ) );
;263:		if( team == TEAM_SPECTATOR ) {
;264:			s_ingame.teamorders.generic.flags |= QMF_GRAYED;
;265:		}
;266:	}
;267:#endif
;268:
;269:	y += INGAME_MENU_VERTICAL_SPACING;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 28
ADDI4
ASGNI4
line 270
;270:	s_ingame.setup.generic.type			= MTYPE_PTEXT;
ADDRGP4 s_ingame+656
CNSTI4 9
ASGNI4
line 271
;271:	s_ingame.setup.generic.flags		= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_ingame+656+44
CNSTU4 264
ASGNU4
line 272
;272:	s_ingame.setup.generic.x			= 320;
ADDRGP4 s_ingame+656+12
CNSTI4 320
ASGNI4
line 273
;273:	s_ingame.setup.generic.y			= y;
ADDRGP4 s_ingame+656+16
ADDRLP4 0
INDIRI4
ASGNI4
line 274
;274:	s_ingame.setup.generic.id			= ID_SETUP;
ADDRGP4 s_ingame+656+8
CNSTI4 13
ASGNI4
line 275
;275:	s_ingame.setup.generic.callback		= InGame_Event; 
ADDRGP4 s_ingame+656+48
ADDRGP4 InGame_Event
ASGNP4
line 276
;276:	s_ingame.setup.string				= "SETUP";
ADDRGP4 s_ingame+656+60
ADDRGP4 $247
ASGNP4
line 277
;277:	s_ingame.setup.color				= color_red;
ADDRGP4 s_ingame+656+68
ADDRGP4 color_red
ASGNP4
line 278
;278:	s_ingame.setup.style				= UI_CENTER|UI_SMALLFONT;
ADDRGP4 s_ingame+656+64
CNSTI4 17
ASGNI4
line 280
;279:
;280:	y += INGAME_MENU_VERTICAL_SPACING;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 28
ADDI4
ASGNI4
line 281
;281:	s_ingame.server.generic.type		= MTYPE_PTEXT;
ADDRGP4 s_ingame+728
CNSTI4 9
ASGNI4
line 282
;282:	s_ingame.server.generic.flags		= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_ingame+728+44
CNSTU4 264
ASGNU4
line 283
;283:	s_ingame.server.generic.x			= 320;
ADDRGP4 s_ingame+728+12
CNSTI4 320
ASGNI4
line 284
;284:	s_ingame.server.generic.y			= y;
ADDRGP4 s_ingame+728+16
ADDRLP4 0
INDIRI4
ASGNI4
line 285
;285:	s_ingame.server.generic.id			= ID_SERVERINFO;
ADDRGP4 s_ingame+728+8
CNSTI4 14
ASGNI4
line 286
;286:	s_ingame.server.generic.callback	= InGame_Event; 
ADDRGP4 s_ingame+728+48
ADDRGP4 InGame_Event
ASGNP4
line 287
;287:	s_ingame.server.string				= "SERVER INFO";
ADDRGP4 s_ingame+728+60
ADDRGP4 $265
ASGNP4
line 288
;288:	s_ingame.server.color				= color_red;
ADDRGP4 s_ingame+728+68
ADDRGP4 color_red
ASGNP4
line 289
;289:	s_ingame.server.style				= UI_CENTER|UI_SMALLFONT;
ADDRGP4 s_ingame+728+64
CNSTI4 17
ASGNI4
line 291
;290:
;291:	y += INGAME_MENU_VERTICAL_SPACING;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 28
ADDI4
ASGNI4
line 292
;292:	s_ingame.restart.generic.type		= MTYPE_PTEXT;
ADDRGP4 s_ingame+872
CNSTI4 9
ASGNI4
line 293
;293:	s_ingame.restart.generic.flags		= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_ingame+872+44
CNSTU4 264
ASGNU4
line 294
;294:	s_ingame.restart.generic.x			= 320;
ADDRGP4 s_ingame+872+12
CNSTI4 320
ASGNI4
line 295
;295:	s_ingame.restart.generic.y			= y;
ADDRGP4 s_ingame+872+16
ADDRLP4 0
INDIRI4
ASGNI4
line 296
;296:	s_ingame.restart.generic.id			= ID_RESTART;
ADDRGP4 s_ingame+872+8
CNSTI4 16
ASGNI4
line 297
;297:	s_ingame.restart.generic.callback	= InGame_Event; 
ADDRGP4 s_ingame+872+48
ADDRGP4 InGame_Event
ASGNP4
line 298
;298:	s_ingame.restart.string				= "RESTART ARENA";
ADDRGP4 s_ingame+872+60
ADDRGP4 $283
ASGNP4
line 299
;299:	s_ingame.restart.color				= color_red;
ADDRGP4 s_ingame+872+68
ADDRGP4 color_red
ASGNP4
line 300
;300:	s_ingame.restart.style				= UI_CENTER|UI_SMALLFONT;
ADDRGP4 s_ingame+872+64
CNSTI4 17
ASGNI4
line 307
;301:#if	0	// JUHOX: "restart arena" always available
;302:	if( !trap_Cvar_VariableValue( "sv_running" ) ) {
;303:		s_ingame.restart.generic.flags |= QMF_GRAYED;
;304:	}
;305:#endif
;306:
;307:	y += INGAME_MENU_VERTICAL_SPACING;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 28
ADDI4
ASGNI4
line 308
;308:	s_ingame.resume.generic.type			= MTYPE_PTEXT;
ADDRGP4 s_ingame+1160
CNSTI4 9
ASGNI4
line 309
;309:	s_ingame.resume.generic.flags			= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_ingame+1160+44
CNSTU4 264
ASGNU4
line 310
;310:	s_ingame.resume.generic.x				= 320;
ADDRGP4 s_ingame+1160+12
CNSTI4 320
ASGNI4
line 311
;311:	s_ingame.resume.generic.y				= y;
ADDRGP4 s_ingame+1160+16
ADDRLP4 0
INDIRI4
ASGNI4
line 312
;312:	s_ingame.resume.generic.id				= ID_RESUME;
ADDRGP4 s_ingame+1160+8
CNSTI4 18
ASGNI4
line 313
;313:	s_ingame.resume.generic.callback		= InGame_Event; 
ADDRGP4 s_ingame+1160+48
ADDRGP4 InGame_Event
ASGNP4
line 314
;314:	s_ingame.resume.string					= "RESUME GAME";
ADDRGP4 s_ingame+1160+60
ADDRGP4 $301
ASGNP4
line 315
;315:	s_ingame.resume.color					= color_red;
ADDRGP4 s_ingame+1160+68
ADDRGP4 color_red
ASGNP4
line 316
;316:	s_ingame.resume.style					= UI_CENTER|UI_SMALLFONT;
ADDRGP4 s_ingame+1160+64
CNSTI4 17
ASGNI4
line 318
;317:
;318:	y += INGAME_MENU_VERTICAL_SPACING;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 28
ADDI4
ASGNI4
line 319
;319:	s_ingame.leave.generic.type			= MTYPE_PTEXT;
ADDRGP4 s_ingame+800
CNSTI4 9
ASGNI4
line 320
;320:	s_ingame.leave.generic.flags		= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_ingame+800+44
CNSTU4 264
ASGNU4
line 321
;321:	s_ingame.leave.generic.x			= 320;
ADDRGP4 s_ingame+800+12
CNSTI4 320
ASGNI4
line 322
;322:	s_ingame.leave.generic.y			= y;
ADDRGP4 s_ingame+800+16
ADDRLP4 0
INDIRI4
ASGNI4
line 323
;323:	s_ingame.leave.generic.id			= ID_LEAVEARENA;
ADDRGP4 s_ingame+800+8
CNSTI4 15
ASGNI4
line 324
;324:	s_ingame.leave.generic.callback		= InGame_Event; 
ADDRGP4 s_ingame+800+48
ADDRGP4 InGame_Event
ASGNP4
line 325
;325:	s_ingame.leave.string				= "LEAVE ARENA";
ADDRGP4 s_ingame+800+60
ADDRGP4 $319
ASGNP4
line 326
;326:	s_ingame.leave.color				= color_red;
ADDRGP4 s_ingame+800+68
ADDRGP4 color_red
ASGNP4
line 327
;327:	s_ingame.leave.style				= UI_CENTER|UI_SMALLFONT;
ADDRGP4 s_ingame+800+64
CNSTI4 17
ASGNI4
line 329
;328:
;329:	y += INGAME_MENU_VERTICAL_SPACING;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 28
ADDI4
ASGNI4
line 330
;330:	s_ingame.quit.generic.type			= MTYPE_PTEXT;
ADDRGP4 s_ingame+1088
CNSTI4 9
ASGNI4
line 331
;331:	s_ingame.quit.generic.flags			= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_ingame+1088+44
CNSTU4 264
ASGNU4
line 332
;332:	s_ingame.quit.generic.x				= 320;
ADDRGP4 s_ingame+1088+12
CNSTI4 320
ASGNI4
line 333
;333:	s_ingame.quit.generic.y				= y;
ADDRGP4 s_ingame+1088+16
ADDRLP4 0
INDIRI4
ASGNI4
line 334
;334:	s_ingame.quit.generic.id			= ID_QUIT;
ADDRGP4 s_ingame+1088+8
CNSTI4 17
ASGNI4
line 335
;335:	s_ingame.quit.generic.callback		= InGame_Event; 
ADDRGP4 s_ingame+1088+48
ADDRGP4 InGame_Event
ASGNP4
line 336
;336:	s_ingame.quit.string				= "EXIT GAME";
ADDRGP4 s_ingame+1088+60
ADDRGP4 $337
ASGNP4
line 337
;337:	s_ingame.quit.color					= color_red;
ADDRGP4 s_ingame+1088+68
ADDRGP4 color_red
ASGNP4
line 338
;338:	s_ingame.quit.style					= UI_CENTER|UI_SMALLFONT;
ADDRGP4 s_ingame+1088+64
CNSTI4 17
ASGNI4
line 341
;339:
;340:#if MAPLENSFLARES	// JUHOX: grey out the unneeded menu items in edit mode
;341:	if (trap_Cvar_VariableValue("g_editmode") > 0) {
ADDRGP4 $117
ARGP4
ADDRLP4 28
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 28
INDIRF4
CNSTF4 0
LEF4 $342
line 342
;342:		s_ingame.addbots.generic.flags |= QMF_GRAYED;
ADDRLP4 32
ADDRGP4 s_ingame+944+44
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
line 343
;343:		s_ingame.removebots.generic.flags |= QMF_GRAYED;
ADDRLP4 36
ADDRGP4 s_ingame+1016+44
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
line 344
;344:		s_ingame.gametemplates.generic.flags |= QMF_GRAYED;
ADDRLP4 40
ADDRGP4 s_ingame+584+44
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
line 345
;345:		s_ingame.team.generic.flags |= QMF_GRAYED;
ADDRLP4 44
ADDRGP4 s_ingame+512+44
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
line 346
;346:	}
LABELV $342
line 350
;347:#endif
;348:
;349:#if ESCAPE_MODE	// JUHOX: no bots in EFH
;350:	if (trap_Cvar_VariableValue("g_gametype") == GT_EFH) {
ADDRGP4 $205
ARGP4
ADDRLP4 32
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 32
INDIRF4
CNSTF4 1091567616
NEF4 $352
line 351
;351:		s_ingame.addbots.generic.flags |= QMF_GRAYED;
ADDRLP4 36
ADDRGP4 s_ingame+944+44
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
line 352
;352:		s_ingame.removebots.generic.flags |= QMF_GRAYED;
ADDRLP4 40
ADDRGP4 s_ingame+1016+44
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
line 353
;353:	}
LABELV $352
line 356
;354:#endif
;355:
;356:	Menu_AddItem( &s_ingame.menu, &s_ingame.frame );
ADDRGP4 s_ingame
ARGP4
ADDRGP4 s_ingame+424
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 357
;357:	Menu_AddItem( &s_ingame.menu, &s_ingame.team );
ADDRGP4 s_ingame
ARGP4
ADDRGP4 s_ingame+512
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 358
;358:	Menu_AddItem( &s_ingame.menu, &s_ingame.gametemplates);	// JUHOX
ADDRGP4 s_ingame
ARGP4
ADDRGP4 s_ingame+584
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 359
;359:	Menu_AddItem( &s_ingame.menu, &s_ingame.addbots );
ADDRGP4 s_ingame
ARGP4
ADDRGP4 s_ingame+944
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 360
;360:	Menu_AddItem( &s_ingame.menu, &s_ingame.removebots );
ADDRGP4 s_ingame
ARGP4
ADDRGP4 s_ingame+1016
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 364
;361:#if 0	// JUHOX: no team orders menu
;362:	Menu_AddItem( &s_ingame.menu, &s_ingame.teamorders );
;363:#endif
;364:	Menu_AddItem( &s_ingame.menu, &s_ingame.setup );
ADDRGP4 s_ingame
ARGP4
ADDRGP4 s_ingame+656
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 365
;365:	Menu_AddItem( &s_ingame.menu, &s_ingame.server );
ADDRGP4 s_ingame
ARGP4
ADDRGP4 s_ingame+728
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 366
;366:	Menu_AddItem( &s_ingame.menu, &s_ingame.restart );
ADDRGP4 s_ingame
ARGP4
ADDRGP4 s_ingame+872
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 367
;367:	Menu_AddItem( &s_ingame.menu, &s_ingame.resume );
ADDRGP4 s_ingame
ARGP4
ADDRGP4 s_ingame+1160
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 368
;368:	Menu_AddItem( &s_ingame.menu, &s_ingame.leave );
ADDRGP4 s_ingame
ARGP4
ADDRGP4 s_ingame+800
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 369
;369:	Menu_AddItem( &s_ingame.menu, &s_ingame.quit );
ADDRGP4 s_ingame
ARGP4
ADDRGP4 s_ingame+1088
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 370
;370:}
LABELV $131
endproc InGame_MenuInit 48 12
export InGame_Cache
proc InGame_Cache 0 4
line 378
;371:
;372:
;373:/*
;374:=================
;375:InGame_Cache
;376:=================
;377:*/
;378:void InGame_Cache( void ) {
line 379
;379:	trap_R_RegisterShaderNoMip( INGAME_FRAME );
ADDRGP4 $139
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 380
;380:}
LABELV $369
endproc InGame_Cache 0 4
export UI_InGameMenu
proc UI_InGameMenu 0 4
line 388
;381:
;382:
;383:/*
;384:=================
;385:UI_InGameMenu
;386:=================
;387:*/
;388:void UI_InGameMenu( void ) {
line 390
;389:	// force as top level menu
;390:	uis.menusp = 0;  
ADDRGP4 uis+16
CNSTI4 0
ASGNI4
line 393
;391:
;392:	// set menu cursor to a nice location
;393:	uis.cursorx = 319;
ADDRGP4 uis+8
CNSTI4 319
ASGNI4
line 394
;394:	uis.cursory = 80;
ADDRGP4 uis+12
CNSTI4 80
ASGNI4
line 396
;395:
;396:	InGame_MenuInit();
ADDRGP4 InGame_MenuInit
CALLV
pop
line 397
;397:	UI_PushMenu( &s_ingame.menu );
ADDRGP4 s_ingame
ARGP4
ADDRGP4 UI_PushMenu
CALLV
pop
line 398
;398:}
LABELV $370
endproc UI_InGameMenu 0 4
bss
align 4
LABELV s_ingame
skip 1232
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
LABELV $337
byte 1 69
byte 1 88
byte 1 73
byte 1 84
byte 1 32
byte 1 71
byte 1 65
byte 1 77
byte 1 69
byte 1 0
align 1
LABELV $319
byte 1 76
byte 1 69
byte 1 65
byte 1 86
byte 1 69
byte 1 32
byte 1 65
byte 1 82
byte 1 69
byte 1 78
byte 1 65
byte 1 0
align 1
LABELV $301
byte 1 82
byte 1 69
byte 1 83
byte 1 85
byte 1 77
byte 1 69
byte 1 32
byte 1 71
byte 1 65
byte 1 77
byte 1 69
byte 1 0
align 1
LABELV $283
byte 1 82
byte 1 69
byte 1 83
byte 1 84
byte 1 65
byte 1 82
byte 1 84
byte 1 32
byte 1 65
byte 1 82
byte 1 69
byte 1 78
byte 1 65
byte 1 0
align 1
LABELV $265
byte 1 83
byte 1 69
byte 1 82
byte 1 86
byte 1 69
byte 1 82
byte 1 32
byte 1 73
byte 1 78
byte 1 70
byte 1 79
byte 1 0
align 1
LABELV $247
byte 1 83
byte 1 69
byte 1 84
byte 1 85
byte 1 80
byte 1 0
align 1
LABELV $223
byte 1 82
byte 1 69
byte 1 77
byte 1 79
byte 1 86
byte 1 69
byte 1 32
byte 1 66
byte 1 79
byte 1 84
byte 1 83
byte 1 0
align 1
LABELV $205
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
LABELV $204
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
LABELV $197
byte 1 65
byte 1 68
byte 1 68
byte 1 32
byte 1 66
byte 1 79
byte 1 84
byte 1 83
byte 1 0
align 1
LABELV $179
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
LABELV $161
byte 1 83
byte 1 84
byte 1 65
byte 1 82
byte 1 84
byte 1 0
align 1
LABELV $139
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
byte 1 100
byte 1 100
byte 1 98
byte 1 111
byte 1 116
byte 1 102
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $123
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
LABELV $121
byte 1 82
byte 1 69
byte 1 83
byte 1 84
byte 1 65
byte 1 82
byte 1 84
byte 1 32
byte 1 65
byte 1 82
byte 1 69
byte 1 78
byte 1 65
byte 1 63
byte 1 0
align 1
LABELV $119
byte 1 100
byte 1 105
byte 1 115
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $118
byte 1 48
byte 1 0
align 1
LABELV $117
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
LABELV $104
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 32
byte 1 48
byte 1 10
byte 1 0
align 1
LABELV $103
byte 1 109
byte 1 97
byte 1 112
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 32
byte 1 48
byte 1 10
byte 1 0
align 1
LABELV $102
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
