code
proc TeamMain_MenuEvent 8 8
file "..\..\..\..\code\q3_ui\ui_team.c"
line 45
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3://
;4:// ui_team.c
;5://
;6:
;7:#include "ui_local.h"
;8:
;9:
;10:#define TEAMMAIN_FRAME	"menu/art/cut_frame"
;11:
;12:#define ID_JOINRED		100
;13:#define ID_JOINBLUE		101
;14:#define ID_JOINGAME		102
;15:#define ID_SPECTATE		103
;16:
;17:
;18:typedef struct
;19:{
;20:	menuframework_s	menu;
;21:	menubitmap_s	frame;
;22:	menutext_s		joinred;
;23:	menutext_s		joinblue;
;24:	menutext_s		joingame;
;25:	menutext_s		spectate;
;26:} teammain_t;
;27:
;28:static teammain_t	s_teammain;
;29:
;30:// bk001204 - unused
;31://static menuframework_s	s_teammain_menu;
;32://static menuaction_s		s_teammain_orders;
;33://static menuaction_s		s_teammain_voice;
;34://static menuaction_s		s_teammain_joinred;
;35://static menuaction_s		s_teammain_joinblue;
;36://static menuaction_s		s_teammain_joingame;
;37://static menuaction_s		s_teammain_spectate;
;38:
;39:
;40:/*
;41:===============
;42:TeamMain_MenuEvent
;43:===============
;44:*/
;45:static void TeamMain_MenuEvent( void* ptr, int event ) {
line 46
;46:	if( event != QM_ACTIVATED ) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $98
line 47
;47:		return;
ADDRGP4 $97
JUMPV
LABELV $98
line 50
;48:	}
;49:
;50:	switch( ((menucommon_s*)ptr)->id ) {
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
LTI4 $100
ADDRLP4 0
INDIRI4
CNSTI4 103
GTI4 $100
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $111-400
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $111
address $103
address $105
address $107
address $109
code
LABELV $103
line 52
;51:	case ID_JOINRED:
;52:		trap_Cmd_ExecuteText( EXEC_APPEND, "cmd team red\n" );
CNSTI4 2
ARGI4
ADDRGP4 $104
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 53
;53:		UI_ForceMenuOff();
ADDRGP4 UI_ForceMenuOff
CALLV
pop
line 54
;54:		break;
ADDRGP4 $101
JUMPV
LABELV $105
line 57
;55:
;56:	case ID_JOINBLUE:
;57:		trap_Cmd_ExecuteText( EXEC_APPEND, "cmd team blue\n" );
CNSTI4 2
ARGI4
ADDRGP4 $106
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 58
;58:		UI_ForceMenuOff();
ADDRGP4 UI_ForceMenuOff
CALLV
pop
line 59
;59:		break;
ADDRGP4 $101
JUMPV
LABELV $107
line 62
;60:
;61:	case ID_JOINGAME:
;62:		trap_Cmd_ExecuteText( EXEC_APPEND, "cmd team free\n" );
CNSTI4 2
ARGI4
ADDRGP4 $108
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 63
;63:		UI_ForceMenuOff();
ADDRGP4 UI_ForceMenuOff
CALLV
pop
line 64
;64:		break;
ADDRGP4 $101
JUMPV
LABELV $109
line 67
;65:
;66:	case ID_SPECTATE:
;67:		trap_Cmd_ExecuteText( EXEC_APPEND, "cmd team spectator\n" );
CNSTI4 2
ARGI4
ADDRGP4 $110
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 68
;68:		UI_ForceMenuOff();
ADDRGP4 UI_ForceMenuOff
CALLV
pop
line 69
;69:		break;
LABELV $100
LABELV $101
line 71
;70:	}
;71:}
LABELV $97
endproc TeamMain_MenuEvent 8 8
export TeamMain_MenuInit
proc TeamMain_MenuInit 1056 12
line 79
;72:
;73:
;74:/*
;75:===============
;76:TeamMain_MenuInit
;77:===============
;78:*/
;79:void TeamMain_MenuInit( void ) {
line 84
;80:	int		y;
;81:	int		gametype;
;82:	char	info[MAX_INFO_STRING];
;83:
;84:	memset( &s_teammain, 0, sizeof(s_teammain) );
ADDRGP4 s_teammain
ARGP4
CNSTI4 0
ARGI4
CNSTI4 800
ARGI4
ADDRGP4 memset
CALLP4
pop
line 86
;85:
;86:	TeamMain_Cache();
ADDRGP4 TeamMain_Cache
CALLV
pop
line 89
;87:
;88:#if 1	// JUHOX: moved from below
;89:	trap_GetConfigString(CS_SERVERINFO, info, MAX_INFO_STRING);   
CNSTI4 0
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigString
CALLI4
pop
line 90
;90:	gametype = atoi( Info_ValueForKey( info,"g_gametype" ) );
ADDRLP4 8
ARGP4
ADDRGP4 $114
ARGP4
ADDRLP4 1032
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1032
INDIRP4
ARGP4
ADDRLP4 1036
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 1036
INDIRI4
ASGNI4
line 93
;91:#endif
;92:
;93:	s_teammain.menu.wrapAround = qtrue;
ADDRGP4 s_teammain+404
CNSTI4 1
ASGNI4
line 94
;94:	s_teammain.menu.fullscreen = qfalse;
ADDRGP4 s_teammain+408
CNSTI4 0
ASGNI4
line 96
;95:
;96:	s_teammain.frame.generic.type   = MTYPE_BITMAP;
ADDRGP4 s_teammain+424
CNSTI4 6
ASGNI4
line 97
;97:	s_teammain.frame.generic.flags	= QMF_INACTIVE;
ADDRGP4 s_teammain+424+44
CNSTU4 16384
ASGNU4
line 98
;98:	s_teammain.frame.generic.name   = TEAMMAIN_FRAME;
ADDRGP4 s_teammain+424+4
ADDRGP4 $122
ASGNP4
line 99
;99:	s_teammain.frame.generic.x		= 142;
ADDRGP4 s_teammain+424+12
CNSTI4 142
ASGNI4
line 100
;100:	s_teammain.frame.generic.y		= 118;
ADDRGP4 s_teammain+424+16
CNSTI4 118
ASGNI4
line 101
;101:	s_teammain.frame.width			= 359;
ADDRGP4 s_teammain+424+76
CNSTI4 359
ASGNI4
line 102
;102:	s_teammain.frame.height			= 256;
ADDRGP4 s_teammain+424+80
CNSTI4 256
ASGNI4
line 104
;103:
;104:	y = 194;
ADDRLP4 0
CNSTI4 194
ASGNI4
line 106
;105:
;106:	s_teammain.joinred.generic.type     = MTYPE_PTEXT;
ADDRGP4 s_teammain+512
CNSTI4 9
ASGNI4
line 107
;107:	s_teammain.joinred.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_teammain+512+44
CNSTU4 264
ASGNU4
line 108
;108:	s_teammain.joinred.generic.id       = ID_JOINRED;
ADDRGP4 s_teammain+512+8
CNSTI4 100
ASGNI4
line 109
;109:	s_teammain.joinred.generic.callback = TeamMain_MenuEvent;
ADDRGP4 s_teammain+512+48
ADDRGP4 TeamMain_MenuEvent
ASGNP4
line 110
;110:	s_teammain.joinred.generic.x        = 320;
ADDRGP4 s_teammain+512+12
CNSTI4 320
ASGNI4
line 111
;111:	s_teammain.joinred.generic.y        = y;
ADDRGP4 s_teammain+512+16
ADDRLP4 0
INDIRI4
ASGNI4
line 112
;112:	s_teammain.joinred.string           = "JOIN RED";
ADDRGP4 s_teammain+512+60
ADDRGP4 $144
ASGNP4
line 113
;113:	s_teammain.joinred.style            = UI_CENTER|UI_SMALLFONT;
ADDRGP4 s_teammain+512+64
CNSTI4 17
ASGNI4
line 114
;114:	s_teammain.joinred.color            = colorRed;
ADDRGP4 s_teammain+512+68
ADDRGP4 colorRed
ASGNP4
line 115
;115:	y += 20;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 20
ADDI4
ASGNI4
line 117
;116:
;117:	s_teammain.joinblue.generic.type     = MTYPE_PTEXT;
ADDRGP4 s_teammain+584
CNSTI4 9
ASGNI4
line 118
;118:	s_teammain.joinblue.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_teammain+584+44
CNSTU4 264
ASGNU4
line 119
;119:	s_teammain.joinblue.generic.id       = ID_JOINBLUE;
ADDRGP4 s_teammain+584+8
CNSTI4 101
ASGNI4
line 120
;120:	s_teammain.joinblue.generic.callback = TeamMain_MenuEvent;
ADDRGP4 s_teammain+584+48
ADDRGP4 TeamMain_MenuEvent
ASGNP4
line 121
;121:	s_teammain.joinblue.generic.x        = 320;
ADDRGP4 s_teammain+584+12
CNSTI4 320
ASGNI4
line 122
;122:	s_teammain.joinblue.generic.y        = y;
ADDRGP4 s_teammain+584+16
ADDRLP4 0
INDIRI4
ASGNI4
line 123
;123:	s_teammain.joinblue.string           = "JOIN BLUE";
ADDRGP4 s_teammain+584+60
ADDRGP4 $162
ASGNP4
line 124
;124:	s_teammain.joinblue.style            = UI_CENTER|UI_SMALLFONT;
ADDRGP4 s_teammain+584+64
CNSTI4 17
ASGNI4
line 125
;125:	s_teammain.joinblue.color            = colorRed;
ADDRGP4 s_teammain+584+68
ADDRGP4 colorRed
ASGNP4
line 126
;126:	y += 20;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 20
ADDI4
ASGNI4
line 128
;127:
;128:	s_teammain.joingame.generic.type     = MTYPE_PTEXT;
ADDRGP4 s_teammain+656
CNSTI4 9
ASGNI4
line 129
;129:	s_teammain.joingame.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_teammain+656+44
CNSTU4 264
ASGNU4
line 130
;130:	s_teammain.joingame.generic.id       = ID_JOINGAME;
ADDRGP4 s_teammain+656+8
CNSTI4 102
ASGNI4
line 131
;131:	s_teammain.joingame.generic.callback = TeamMain_MenuEvent;
ADDRGP4 s_teammain+656+48
ADDRGP4 TeamMain_MenuEvent
ASGNP4
line 132
;132:	s_teammain.joingame.generic.x        = 320;
ADDRGP4 s_teammain+656+12
CNSTI4 320
ASGNI4
line 133
;133:	s_teammain.joingame.generic.y        = y;
ADDRGP4 s_teammain+656+16
ADDRLP4 0
INDIRI4
ASGNI4
line 134
;134:	s_teammain.joingame.string           = "JOIN GAME";
ADDRGP4 s_teammain+656+60
ADDRGP4 $180
ASGNP4
line 135
;135:	s_teammain.joingame.style            = UI_CENTER|UI_SMALLFONT;
ADDRGP4 s_teammain+656+64
CNSTI4 17
ASGNI4
line 136
;136:	s_teammain.joingame.color            = colorRed;
ADDRGP4 s_teammain+656+68
ADDRGP4 colorRed
ASGNP4
line 137
;137:	y += 20;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 20
ADDI4
ASGNI4
line 139
;138:
;139:	s_teammain.spectate.generic.type     = MTYPE_PTEXT;
ADDRGP4 s_teammain+728
CNSTI4 9
ASGNI4
line 140
;140:	s_teammain.spectate.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_teammain+728+44
CNSTU4 264
ASGNU4
line 141
;141:	s_teammain.spectate.generic.id       = ID_SPECTATE;
ADDRGP4 s_teammain+728+8
CNSTI4 103
ASGNI4
line 142
;142:	s_teammain.spectate.generic.callback = TeamMain_MenuEvent;
ADDRGP4 s_teammain+728+48
ADDRGP4 TeamMain_MenuEvent
ASGNP4
line 143
;143:	s_teammain.spectate.generic.x        = 320;
ADDRGP4 s_teammain+728+12
CNSTI4 320
ASGNI4
line 144
;144:	s_teammain.spectate.generic.y        = y;
ADDRGP4 s_teammain+728+16
ADDRLP4 0
INDIRI4
ASGNI4
line 145
;145:	s_teammain.spectate.string           = "SPECTATE";
ADDRGP4 s_teammain+728+60
ADDRGP4 $198
ASGNP4
line 146
;146:	s_teammain.spectate.style            = UI_CENTER|UI_SMALLFONT;
ADDRGP4 s_teammain+728+64
CNSTI4 17
ASGNI4
line 147
;147:	s_teammain.spectate.color            = colorRed;
ADDRGP4 s_teammain+728+68
ADDRGP4 colorRed
ASGNP4
line 148
;148:	y += 20;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 20
ADDI4
ASGNI4
line 156
;149:
;150:#if 0	// JUHOX: moved to the beginning of this function
;151:	trap_GetConfigString(CS_SERVERINFO, info, MAX_INFO_STRING);   
;152:	gametype = atoi( Info_ValueForKey( info,"g_gametype" ) );
;153:#endif
;154:			      
;155:	// set initial states
;156:	switch( gametype ) {
ADDRLP4 1040
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
LTI4 $203
ADDRLP4 1040
INDIRI4
CNSTI4 9
GTI4 $203
ADDRLP4 1040
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $213
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $213
address $205
address $205
address $205
address $210
address $210
address $203
address $203
address $203
address $205
address $205
code
LABELV $205
line 166
;157:	case GT_SINGLE_PLAYER:
;158:	case GT_FFA:
;159:	case GT_TOURNAMENT:
;160:#if MONSTER_MODE	// JUHOX: don't allow "join red" & "join blue" for STU
;161:	case GT_STU:
;162:#endif
;163:#if ESCAPE_MODE	// JUHOX: don't allow "join red" & "join blue" for EFH
;164:	case GT_EFH:
;165:#endif
;166:		s_teammain.joinred.generic.flags  |= QMF_GRAYED;
ADDRLP4 1044
ADDRGP4 s_teammain+512+44
ASGNP4
ADDRLP4 1044
INDIRP4
ADDRLP4 1044
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
line 167
;167:		s_teammain.joinblue.generic.flags |= QMF_GRAYED;
ADDRLP4 1048
ADDRGP4 s_teammain+584+44
ASGNP4
ADDRLP4 1048
INDIRP4
ADDRLP4 1048
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
line 168
;168:		break;
ADDRGP4 $204
JUMPV
LABELV $203
LABELV $210
line 173
;169:
;170:	default:
;171:	case GT_TEAM:
;172:	case GT_CTF:
;173:		s_teammain.joingame.generic.flags |= QMF_GRAYED;
ADDRLP4 1052
ADDRGP4 s_teammain+656+44
ASGNP4
ADDRLP4 1052
INDIRP4
ADDRLP4 1052
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
line 174
;174:		break;
LABELV $204
line 177
;175:	}
;176:
;177:	Menu_AddItem( &s_teammain.menu, (void*) &s_teammain.frame );
ADDRGP4 s_teammain
ARGP4
ADDRGP4 s_teammain+424
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 178
;178:	Menu_AddItem( &s_teammain.menu, (void*) &s_teammain.joinred );
ADDRGP4 s_teammain
ARGP4
ADDRGP4 s_teammain+512
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 179
;179:	Menu_AddItem( &s_teammain.menu, (void*) &s_teammain.joinblue );
ADDRGP4 s_teammain
ARGP4
ADDRGP4 s_teammain+584
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 180
;180:	Menu_AddItem( &s_teammain.menu, (void*) &s_teammain.joingame );
ADDRGP4 s_teammain
ARGP4
ADDRGP4 s_teammain+656
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 181
;181:	Menu_AddItem( &s_teammain.menu, (void*) &s_teammain.spectate );
ADDRGP4 s_teammain
ARGP4
ADDRGP4 s_teammain+728
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 182
;182:}
LABELV $113
endproc TeamMain_MenuInit 1056 12
export TeamMain_Cache
proc TeamMain_Cache 0 4
line 190
;183:
;184:
;185:/*
;186:===============
;187:TeamMain_Cache
;188:===============
;189:*/
;190:void TeamMain_Cache( void ) {
line 191
;191:	trap_R_RegisterShaderNoMip( TEAMMAIN_FRAME );
ADDRGP4 $122
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 192
;192:}
LABELV $219
endproc TeamMain_Cache 0 4
export UI_TeamMainMenu
proc UI_TeamMainMenu 0 4
line 200
;193:
;194:
;195:/*
;196:===============
;197:UI_TeamMainMenu
;198:===============
;199:*/
;200:void UI_TeamMainMenu( void ) {
line 201
;201:	TeamMain_MenuInit();
ADDRGP4 TeamMain_MenuInit
CALLV
pop
line 202
;202:	UI_PushMenu ( &s_teammain.menu );
ADDRGP4 s_teammain
ARGP4
ADDRGP4 UI_PushMenu
CALLV
pop
line 203
;203:}
LABELV $220
endproc UI_TeamMainMenu 0 4
bss
align 4
LABELV s_teammain
skip 800
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
LABELV $198
byte 1 83
byte 1 80
byte 1 69
byte 1 67
byte 1 84
byte 1 65
byte 1 84
byte 1 69
byte 1 0
align 1
LABELV $180
byte 1 74
byte 1 79
byte 1 73
byte 1 78
byte 1 32
byte 1 71
byte 1 65
byte 1 77
byte 1 69
byte 1 0
align 1
LABELV $162
byte 1 74
byte 1 79
byte 1 73
byte 1 78
byte 1 32
byte 1 66
byte 1 76
byte 1 85
byte 1 69
byte 1 0
align 1
LABELV $144
byte 1 74
byte 1 79
byte 1 73
byte 1 78
byte 1 32
byte 1 82
byte 1 69
byte 1 68
byte 1 0
align 1
LABELV $122
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
byte 1 117
byte 1 116
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $114
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
LABELV $110
byte 1 99
byte 1 109
byte 1 100
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 97
byte 1 116
byte 1 111
byte 1 114
byte 1 10
byte 1 0
align 1
LABELV $108
byte 1 99
byte 1 109
byte 1 100
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 102
byte 1 114
byte 1 101
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $106
byte 1 99
byte 1 109
byte 1 100
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $104
byte 1 99
byte 1 109
byte 1 100
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 114
byte 1 101
byte 1 100
byte 1 10
byte 1 0
