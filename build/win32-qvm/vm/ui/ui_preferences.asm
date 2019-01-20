data
align 4
LABELV teamoverlay_names
address $97
address $98
address $99
address $100
byte 4 0
align 4
LABELV musicmode_names
address $101
address $102
address $103
byte 4 0
code
proc Preferences_SetMenuItems 124 12
file "..\..\..\..\code\q3_ui\ui_preferences.c"
line 97
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:/*
;4:=======================================================================
;5:
;6:GAME OPTIONS MENU
;7:
;8:=======================================================================
;9:*/
;10:
;11:
;12:#include "ui_local.h"
;13:
;14:
;15:#define ART_FRAMEL				"menu/art/frame2_l"
;16:#define ART_FRAMER				"menu/art/frame1_r"
;17:#define ART_BACK0				"menu/art/back_0"
;18:#define ART_BACK1				"menu/art/back_1"
;19:
;20:#define PREFERENCES_X_POS		360
;21:
;22:#define ID_CROSSHAIR			127
;23:#define ID_SIMPLEITEMS			128
;24:#define ID_HIGHQUALITYSKY		129
;25:#define ID_EJECTINGBRASS		130
;26:#define ID_WALLMARKS			131
;27:#define ID_DYNAMICLIGHTS		132
;28:#define ID_IDENTIFYTARGET		133
;29:#define ID_SYNCEVERYFRAME		134
;30:#define ID_FORCEMODEL			135
;31:#define ID_DRAWTEAMOVERLAY		136
;32:#define ID_ALLOWDOWNLOAD			137
;33:#define ID_BACK					138
;34:#define ID_GLASSCLOAKING		139	// JUHOX
;35:#define ID_LENSFLARE			140	// JUHOX
;36:#define ID_AUTOGLC				141	// JUHOX
;37:#define ID_BFGSUPEREXPL			142	// JUHOX
;38:#if PLAYLIST
;39:#define ID_MUSICMODE			143	// JUHOX
;40:#endif
;41:
;42:#define	NUM_CROSSHAIRS			10
;43:
;44:
;45:typedef struct {
;46:	menuframework_s		menu;
;47:
;48:	menutext_s			banner;
;49:	menubitmap_s		framel;
;50:	menubitmap_s		framer;
;51:
;52:	menulist_s			crosshair;
;53:	menuradiobutton_s	simpleitems;
;54:	menuradiobutton_s	brass;
;55:	menuradiobutton_s	wallmarks;
;56:	menuradiobutton_s	dynamiclights;
;57:	menuradiobutton_s	identifytarget;
;58:	menuradiobutton_s	highqualitysky;
;59:	menuradiobutton_s	glassCloaking;	// JUHOX
;60:	menuradiobutton_s	lensFlare;		// JUHOX
;61:	menuradiobutton_s	bfgSuperExpl;	// JUHOX
;62:	menuradiobutton_s	synceveryframe;
;63:	menuradiobutton_s	forcemodel;
;64:	menulist_s			drawteamoverlay;
;65:#if PLAYLIST
;66:	menulist_s			musicmode;			// JUHOX
;67:#endif
;68:	menuradiobutton_s	autoglc;	// JUHOX
;69:	menuradiobutton_s	allowdownload;
;70:	menubitmap_s		back;
;71:
;72:	qhandle_t			crosshairShader[NUM_CROSSHAIRS];
;73:} preferences_t;
;74:
;75:static preferences_t s_preferences;
;76:
;77:static const char *teamoverlay_names[] =
;78:{
;79:	"off",
;80:	"upper right",
;81:	"lower right",
;82:	"lower left",
;83:	0
;84:};
;85:
;86:// JUHOX: music mode names
;87:#if PLAYLIST
;88:static const char* musicmode_names[] =
;89:{
;90:	"none",
;91:	"default",
;92:	"playlist",
;93:	0
;94:};
;95:#endif
;96:
;97:static void Preferences_SetMenuItems( void ) {
line 98
;98:	s_preferences.crosshair.curvalue		= (int)trap_Cvar_VariableValue( "cg_drawCrosshair" ) % NUM_CROSSHAIRS;
ADDRGP4 $107
ARGP4
ADDRLP4 0
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRGP4 s_preferences+672+64
ADDRLP4 0
INDIRF4
CVFI4 4
CNSTI4 10
MODI4
ASGNI4
line 99
;99:	s_preferences.simpleitems.curvalue		= trap_Cvar_VariableValue( "cg_simpleItems" ) != 0;
ADDRGP4 $110
ARGP4
ADDRLP4 8
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 8
INDIRF4
CNSTF4 0
EQF4 $112
ADDRLP4 4
CNSTI4 1
ASGNI4
ADDRGP4 $113
JUMPV
LABELV $112
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $113
ADDRGP4 s_preferences+768+60
ADDRLP4 4
INDIRI4
ASGNI4
line 100
;100:	s_preferences.brass.curvalue			= trap_Cvar_VariableValue( "cg_brassTime" ) != 0;
ADDRGP4 $116
ARGP4
ADDRLP4 16
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 16
INDIRF4
CNSTF4 0
EQF4 $118
ADDRLP4 12
CNSTI4 1
ASGNI4
ADDRGP4 $119
JUMPV
LABELV $118
ADDRLP4 12
CNSTI4 0
ASGNI4
LABELV $119
ADDRGP4 s_preferences+832+60
ADDRLP4 12
INDIRI4
ASGNI4
line 101
;101:	s_preferences.wallmarks.curvalue		= trap_Cvar_VariableValue( "cg_marks" ) != 0;
ADDRGP4 $122
ARGP4
ADDRLP4 24
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 24
INDIRF4
CNSTF4 0
EQF4 $124
ADDRLP4 20
CNSTI4 1
ASGNI4
ADDRGP4 $125
JUMPV
LABELV $124
ADDRLP4 20
CNSTI4 0
ASGNI4
LABELV $125
ADDRGP4 s_preferences+896+60
ADDRLP4 20
INDIRI4
ASGNI4
line 102
;102:	s_preferences.identifytarget.curvalue	= trap_Cvar_VariableValue( "cg_drawCrosshairNames" ) != 0;
ADDRGP4 $128
ARGP4
ADDRLP4 32
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 32
INDIRF4
CNSTF4 0
EQF4 $130
ADDRLP4 28
CNSTI4 1
ASGNI4
ADDRGP4 $131
JUMPV
LABELV $130
ADDRLP4 28
CNSTI4 0
ASGNI4
LABELV $131
ADDRGP4 s_preferences+1024+60
ADDRLP4 28
INDIRI4
ASGNI4
line 103
;103:	s_preferences.dynamiclights.curvalue	= trap_Cvar_VariableValue( "r_dynamiclight" ) != 0;
ADDRGP4 $134
ARGP4
ADDRLP4 40
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 40
INDIRF4
CNSTF4 0
EQF4 $136
ADDRLP4 36
CNSTI4 1
ASGNI4
ADDRGP4 $137
JUMPV
LABELV $136
ADDRLP4 36
CNSTI4 0
ASGNI4
LABELV $137
ADDRGP4 s_preferences+960+60
ADDRLP4 36
INDIRI4
ASGNI4
line 104
;104:	s_preferences.highqualitysky.curvalue	= trap_Cvar_VariableValue ( "r_fastsky" ) == 0;
ADDRGP4 $140
ARGP4
ADDRLP4 48
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 48
INDIRF4
CNSTF4 0
NEF4 $142
ADDRLP4 44
CNSTI4 1
ASGNI4
ADDRGP4 $143
JUMPV
LABELV $142
ADDRLP4 44
CNSTI4 0
ASGNI4
LABELV $143
ADDRGP4 s_preferences+1088+60
ADDRLP4 44
INDIRI4
ASGNI4
line 105
;105:	s_preferences.synceveryframe.curvalue	= trap_Cvar_VariableValue( "r_finish" ) != 0;
ADDRGP4 $146
ARGP4
ADDRLP4 56
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 56
INDIRF4
CNSTF4 0
EQF4 $148
ADDRLP4 52
CNSTI4 1
ASGNI4
ADDRGP4 $149
JUMPV
LABELV $148
ADDRLP4 52
CNSTI4 0
ASGNI4
LABELV $149
ADDRGP4 s_preferences+1344+60
ADDRLP4 52
INDIRI4
ASGNI4
line 106
;106:	s_preferences.forcemodel.curvalue		= trap_Cvar_VariableValue( "cg_forcemodel" ) != 0;
ADDRGP4 $152
ARGP4
ADDRLP4 64
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 64
INDIRF4
CNSTF4 0
EQF4 $154
ADDRLP4 60
CNSTI4 1
ASGNI4
ADDRGP4 $155
JUMPV
LABELV $154
ADDRLP4 60
CNSTI4 0
ASGNI4
LABELV $155
ADDRGP4 s_preferences+1408+60
ADDRLP4 60
INDIRI4
ASGNI4
line 107
;107:	s_preferences.drawteamoverlay.curvalue	= Com_Clamp( 0, 3, trap_Cvar_VariableValue( "cg_drawTeamOverlay" ) );
ADDRGP4 $158
ARGP4
ADDRLP4 68
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1077936128
ARGF4
ADDRLP4 68
INDIRF4
ARGF4
ADDRLP4 72
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_preferences+1472+64
ADDRLP4 72
INDIRF4
CVFI4 4
ASGNI4
line 109
;108:#if PLAYLIST
;109:	s_preferences.musicmode.curvalue		= Com_Clamp(0, 2, trap_Cvar_VariableValue("cg_music"));	// JUHOX
ADDRGP4 $161
ARGP4
ADDRLP4 76
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1073741824
ARGF4
ADDRLP4 76
INDIRF4
ARGF4
ADDRLP4 80
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_preferences+1568+64
ADDRLP4 80
INDIRF4
CVFI4 4
ASGNI4
line 111
;110:#endif
;111:	s_preferences.allowdownload.curvalue	= trap_Cvar_VariableValue( "cl_allowDownload" ) != 0;
ADDRGP4 $164
ARGP4
ADDRLP4 88
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 88
INDIRF4
CNSTF4 0
EQF4 $166
ADDRLP4 84
CNSTI4 1
ASGNI4
ADDRGP4 $167
JUMPV
LABELV $166
ADDRLP4 84
CNSTI4 0
ASGNI4
LABELV $167
ADDRGP4 s_preferences+1728+60
ADDRLP4 84
INDIRI4
ASGNI4
line 112
;112:	s_preferences.glassCloaking.curvalue	= trap_Cvar_VariableValue("cg_glassCloaking") != 0;	// JUHOX
ADDRGP4 $170
ARGP4
ADDRLP4 96
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 96
INDIRF4
CNSTF4 0
EQF4 $172
ADDRLP4 92
CNSTI4 1
ASGNI4
ADDRGP4 $173
JUMPV
LABELV $172
ADDRLP4 92
CNSTI4 0
ASGNI4
LABELV $173
ADDRGP4 s_preferences+1152+60
ADDRLP4 92
INDIRI4
ASGNI4
line 113
;113:	s_preferences.lensFlare.curvalue		= trap_Cvar_VariableValue("cg_lensFlare") != 0;	// JUHOX
ADDRGP4 $176
ARGP4
ADDRLP4 104
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 104
INDIRF4
CNSTF4 0
EQF4 $178
ADDRLP4 100
CNSTI4 1
ASGNI4
ADDRGP4 $179
JUMPV
LABELV $178
ADDRLP4 100
CNSTI4 0
ASGNI4
LABELV $179
ADDRGP4 s_preferences+1216+60
ADDRLP4 100
INDIRI4
ASGNI4
line 114
;114:	s_preferences.bfgSuperExpl.curvalue		= trap_Cvar_VariableValue("cg_bfgSuperExpl") != 0;	// JUHOX
ADDRGP4 $182
ARGP4
ADDRLP4 112
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 112
INDIRF4
CNSTF4 0
EQF4 $184
ADDRLP4 108
CNSTI4 1
ASGNI4
ADDRGP4 $185
JUMPV
LABELV $184
ADDRLP4 108
CNSTI4 0
ASGNI4
LABELV $185
ADDRGP4 s_preferences+1280+60
ADDRLP4 108
INDIRI4
ASGNI4
line 115
;115:	s_preferences.autoglc.curvalue			= trap_Cvar_VariableValue("cg_autoglc") != 0;	// JUHOX
ADDRGP4 $188
ARGP4
ADDRLP4 120
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 120
INDIRF4
CNSTF4 0
EQF4 $190
ADDRLP4 116
CNSTI4 1
ASGNI4
ADDRGP4 $191
JUMPV
LABELV $190
ADDRLP4 116
CNSTI4 0
ASGNI4
LABELV $191
ADDRGP4 s_preferences+1664+60
ADDRLP4 116
INDIRI4
ASGNI4
line 116
;116:}
LABELV $104
endproc Preferences_SetMenuItems 124 12
proc Preferences_Event 16 8
line 119
;117:
;118:
;119:static void Preferences_Event( void* ptr, int notification ) {
line 120
;120:	if( notification != QM_ACTIVATED ) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $193
line 121
;121:		return;
ADDRGP4 $192
JUMPV
LABELV $193
line 124
;122:	}
;123:
;124:	switch( ((menucommon_s*)ptr)->id ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 127
LTI4 $195
ADDRLP4 0
INDIRI4
CNSTI4 143
GTI4 $195
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $264-508
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $264
address $198
address $209
address $212
address $218
address $223
address $226
address $229
address $232
address $235
address $238
address $244
address $250
address $251
address $254
address $260
address $257
address $241
code
LABELV $198
line 126
;125:	case ID_CROSSHAIR:
;126:		s_preferences.crosshair.curvalue++;
ADDRLP4 8
ADDRGP4 s_preferences+672+64
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 127
;127:		if( s_preferences.crosshair.curvalue == NUM_CROSSHAIRS ) {
ADDRGP4 s_preferences+672+64
INDIRI4
CNSTI4 10
NEI4 $201
line 128
;128:			s_preferences.crosshair.curvalue = 0;
ADDRGP4 s_preferences+672+64
CNSTI4 0
ASGNI4
line 129
;129:		}
LABELV $201
line 130
;130:		trap_Cvar_SetValue( "cg_drawCrosshair", s_preferences.crosshair.curvalue );
ADDRGP4 $107
ARGP4
ADDRGP4 s_preferences+672+64
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 131
;131:		break;
ADDRGP4 $196
JUMPV
LABELV $209
line 134
;132:
;133:	case ID_SIMPLEITEMS:
;134:		trap_Cvar_SetValue( "cg_simpleItems", s_preferences.simpleitems.curvalue );
ADDRGP4 $110
ARGP4
ADDRGP4 s_preferences+768+60
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 135
;135:		break;
ADDRGP4 $196
JUMPV
LABELV $212
line 138
;136:
;137:	case ID_HIGHQUALITYSKY:
;138:		trap_Cvar_SetValue( "r_fastsky", !s_preferences.highqualitysky.curvalue );
ADDRGP4 $140
ARGP4
ADDRGP4 s_preferences+1088+60
INDIRI4
CNSTI4 0
NEI4 $216
ADDRLP4 12
CNSTI4 1
ASGNI4
ADDRGP4 $217
JUMPV
LABELV $216
ADDRLP4 12
CNSTI4 0
ASGNI4
LABELV $217
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 139
;139:		break;
ADDRGP4 $196
JUMPV
LABELV $218
line 142
;140:
;141:	case ID_EJECTINGBRASS:
;142:		if ( s_preferences.brass.curvalue )
ADDRGP4 s_preferences+832+60
INDIRI4
CNSTI4 0
EQI4 $219
line 143
;143:			trap_Cvar_Reset( "cg_brassTime" );
ADDRGP4 $116
ARGP4
ADDRGP4 trap_Cvar_Reset
CALLV
pop
ADDRGP4 $196
JUMPV
LABELV $219
line 145
;144:		else
;145:			trap_Cvar_SetValue( "cg_brassTime", 0 );
ADDRGP4 $116
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 146
;146:		break;
ADDRGP4 $196
JUMPV
LABELV $223
line 149
;147:
;148:	case ID_WALLMARKS:
;149:		trap_Cvar_SetValue( "cg_marks", s_preferences.wallmarks.curvalue );
ADDRGP4 $122
ARGP4
ADDRGP4 s_preferences+896+60
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 150
;150:		break;
ADDRGP4 $196
JUMPV
LABELV $226
line 153
;151:
;152:	case ID_DYNAMICLIGHTS:
;153:		trap_Cvar_SetValue( "r_dynamiclight", s_preferences.dynamiclights.curvalue );
ADDRGP4 $134
ARGP4
ADDRGP4 s_preferences+960+60
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 154
;154:		break;		
ADDRGP4 $196
JUMPV
LABELV $229
line 157
;155:
;156:	case ID_IDENTIFYTARGET:
;157:		trap_Cvar_SetValue( "cg_drawCrosshairNames", s_preferences.identifytarget.curvalue );
ADDRGP4 $128
ARGP4
ADDRGP4 s_preferences+1024+60
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 158
;158:		break;
ADDRGP4 $196
JUMPV
LABELV $232
line 161
;159:
;160:	case ID_SYNCEVERYFRAME:
;161:		trap_Cvar_SetValue( "r_finish", s_preferences.synceveryframe.curvalue );
ADDRGP4 $146
ARGP4
ADDRGP4 s_preferences+1344+60
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 162
;162:		break;
ADDRGP4 $196
JUMPV
LABELV $235
line 165
;163:
;164:	case ID_FORCEMODEL:
;165:		trap_Cvar_SetValue( "cg_forcemodel", s_preferences.forcemodel.curvalue );
ADDRGP4 $152
ARGP4
ADDRGP4 s_preferences+1408+60
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 166
;166:		break;
ADDRGP4 $196
JUMPV
LABELV $238
line 169
;167:
;168:	case ID_DRAWTEAMOVERLAY:
;169:		trap_Cvar_SetValue( "cg_drawTeamOverlay", s_preferences.drawteamoverlay.curvalue );
ADDRGP4 $158
ARGP4
ADDRGP4 s_preferences+1472+64
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 170
;170:		break;
ADDRGP4 $196
JUMPV
LABELV $241
line 174
;171:
;172:#if PLAYLIST	// JUHOX: handle musicmode menu item
;173:	case ID_MUSICMODE:
;174:		trap_Cvar_SetValue("cg_music", s_preferences.musicmode.curvalue);
ADDRGP4 $161
ARGP4
ADDRGP4 s_preferences+1568+64
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 175
;175:		break;
ADDRGP4 $196
JUMPV
LABELV $244
line 179
;176:#endif
;177:
;178:	case ID_ALLOWDOWNLOAD:
;179:		trap_Cvar_SetValue( "cl_allowDownload", s_preferences.allowdownload.curvalue );
ADDRGP4 $164
ARGP4
ADDRGP4 s_preferences+1728+60
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 180
;180:		trap_Cvar_SetValue( "sv_allowDownload", s_preferences.allowdownload.curvalue );
ADDRGP4 $247
ARGP4
ADDRGP4 s_preferences+1728+60
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 181
;181:		break;
ADDRGP4 $196
JUMPV
LABELV $250
line 184
;182:
;183:	case ID_BACK:
;184:		UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 185
;185:		break;
ADDRGP4 $196
JUMPV
LABELV $251
line 188
;186:#if 1	// JUHOX: handle "glass cloaking" menu field
;187:	case ID_GLASSCLOAKING:
;188:		trap_Cvar_SetValue("cg_glassCloaking", s_preferences.glassCloaking.curvalue);
ADDRGP4 $170
ARGP4
ADDRGP4 s_preferences+1152+60
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 189
;189:		break;
ADDRGP4 $196
JUMPV
LABELV $254
line 193
;190:#endif
;191:#if 1	// JUHOX: handle "lens flare" menu field
;192:	case ID_LENSFLARE:
;193:		trap_Cvar_SetValue("cg_lensFlare", s_preferences.lensFlare.curvalue);
ADDRGP4 $176
ARGP4
ADDRGP4 s_preferences+1216+60
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 194
;194:		break;
ADDRGP4 $196
JUMPV
LABELV $257
line 198
;195:#endif
;196:#if 1	// JUHOX: handle "bfg super explosion" menu field
;197:	case ID_BFGSUPEREXPL:
;198:		trap_Cvar_SetValue("cg_bfgSuperExpl", s_preferences.bfgSuperExpl.curvalue);
ADDRGP4 $182
ARGP4
ADDRGP4 s_preferences+1280+60
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 199
;199:		break;
ADDRGP4 $196
JUMPV
LABELV $260
line 203
;200:#endif
;201:#if 1	// JUHOX: handle "auto group leader command" menu field
;202:	case ID_AUTOGLC:
;203:		trap_Cvar_SetValue("cg_autoGLC", s_preferences.autoglc.curvalue);
ADDRGP4 $261
ARGP4
ADDRGP4 s_preferences+1664+60
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 204
;204:		break;
LABELV $195
LABELV $196
line 207
;205:#endif
;206:	}
;207:}
LABELV $192
endproc Preferences_Event 16 8
proc Crosshair_Draw 36 20
line 215
;208:
;209:
;210:/*
;211:=================
;212:Crosshair_Draw
;213:=================
;214:*/
;215:static void Crosshair_Draw( void *self ) {
line 222
;216:	menulist_s	*s;
;217:	float		*color;
;218:	int			x, y;
;219:	int			style;
;220:	qboolean	focus;
;221:
;222:	s = (menulist_s *)self;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 223
;223:	x = s->generic.x;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 224
;224:	y =	s->generic.y;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 226
;225:
;226:	style = UI_SMALLFONT;
ADDRLP4 20
CNSTI4 16
ASGNI4
line 227
;227:	focus = (s->generic.parent->cursor == s->generic.menuPosition);
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
NEI4 $268
ADDRLP4 24
CNSTI4 1
ASGNI4
ADDRGP4 $269
JUMPV
LABELV $268
ADDRLP4 24
CNSTI4 0
ASGNI4
LABELV $269
ADDRLP4 16
ADDRLP4 24
INDIRI4
ASGNI4
line 229
;228:
;229:	if ( s->generic.flags & QMF_GRAYED )
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 8192
BANDU4
CNSTU4 0
EQU4 $270
line 230
;230:		color = text_color_disabled;
ADDRLP4 12
ADDRGP4 text_color_disabled
ASGNP4
ADDRGP4 $271
JUMPV
LABELV $270
line 231
;231:	else if ( focus )
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $272
line 232
;232:	{
line 233
;233:		color = text_color_highlight;
ADDRLP4 12
ADDRGP4 text_color_highlight
ASGNP4
line 234
;234:		style |= UI_PULSE;
ADDRLP4 20
ADDRLP4 20
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
line 235
;235:	}
ADDRGP4 $273
JUMPV
LABELV $272
line 236
;236:	else if ( s->generic.flags & QMF_BLINK )
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 1
BANDU4
CNSTU4 0
EQU4 $274
line 237
;237:	{
line 238
;238:		color = text_color_highlight;
ADDRLP4 12
ADDRGP4 text_color_highlight
ASGNP4
line 239
;239:		style |= UI_BLINK;
ADDRLP4 20
ADDRLP4 20
INDIRI4
CNSTI4 4096
BORI4
ASGNI4
line 240
;240:	}
ADDRGP4 $275
JUMPV
LABELV $274
line 242
;241:	else
;242:		color = text_color_normal;
ADDRLP4 12
ADDRGP4 text_color_normal
ASGNP4
LABELV $275
LABELV $273
LABELV $271
line 244
;243:
;244:	if ( focus )
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $276
line 245
;245:	{
line 247
;246:		// draw cursor
;247:		UI_FillRect( s->generic.left, s->generic.top, s->generic.right-s->generic.left+1, s->generic.bottom-s->generic.top+1, listbar_color ); 
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
line 248
;248:		UI_DrawChar( x, y, 13, UI_CENTER|UI_BLINK|UI_SMALLFONT, color);
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
CNSTI4 13
ARGI4
CNSTI4 4113
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 UI_DrawChar
CALLV
pop
line 249
;249:	}
LABELV $276
line 251
;250:
;251:	UI_DrawString( x - SMALLCHAR_WIDTH, y, s->generic.name, style|UI_RIGHT, color );
ADDRLP4 4
INDIRI4
CNSTI4 8
SUBI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
INDIRI4
CNSTI4 2
BORI4
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 252
;252:	if( !s->curvalue ) {
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
CNSTI4 0
NEI4 $278
line 253
;253:		return;
ADDRGP4 $266
JUMPV
LABELV $278
line 255
;254:	}
;255:	UI_DrawHandlePic( x + SMALLCHAR_WIDTH, y - 4, 24, 24, s_preferences.crosshairShader[s->curvalue] );
ADDRLP4 4
INDIRI4
CNSTI4 8
ADDI4
CVIF4 4
ARGF4
ADDRLP4 8
INDIRI4
CNSTI4 4
SUBI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
CNSTF4 1103101952
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 s_preferences+1880
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 256
;256:}
LABELV $266
endproc Crosshair_Draw 36 20
proc Preferences_MenuInit 8 12
line 259
;257:
;258:
;259:static void Preferences_MenuInit( void ) {
line 262
;260:	int				y;
;261:
;262:	memset( &s_preferences, 0 ,sizeof(preferences_t) );
ADDRGP4 s_preferences
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1920
ARGI4
ADDRGP4 memset
CALLP4
pop
line 264
;263:
;264:	Preferences_Cache();
ADDRGP4 Preferences_Cache
CALLV
pop
line 266
;265:
;266:	s_preferences.menu.wrapAround = qtrue;
ADDRGP4 s_preferences+404
CNSTI4 1
ASGNI4
line 267
;267:	s_preferences.menu.fullscreen = qtrue;
ADDRGP4 s_preferences+408
CNSTI4 1
ASGNI4
line 269
;268:
;269:	s_preferences.banner.generic.type  = MTYPE_BTEXT;
ADDRGP4 s_preferences+424
CNSTI4 10
ASGNI4
line 270
;270:	s_preferences.banner.generic.x	   = 320;
ADDRGP4 s_preferences+424+12
CNSTI4 320
ASGNI4
line 271
;271:	s_preferences.banner.generic.y	   = 16;
ADDRGP4 s_preferences+424+16
CNSTI4 16
ASGNI4
line 272
;272:	s_preferences.banner.string		   = "GAME OPTIONS";
ADDRGP4 s_preferences+424+60
ADDRGP4 $291
ASGNP4
line 273
;273:	s_preferences.banner.color         = color_white;
ADDRGP4 s_preferences+424+68
ADDRGP4 color_white
ASGNP4
line 274
;274:	s_preferences.banner.style         = UI_CENTER;
ADDRGP4 s_preferences+424+64
CNSTI4 1
ASGNI4
line 276
;275:
;276:	s_preferences.framel.generic.type  = MTYPE_BITMAP;
ADDRGP4 s_preferences+496
CNSTI4 6
ASGNI4
line 277
;277:	s_preferences.framel.generic.name  = ART_FRAMEL;
ADDRGP4 s_preferences+496+4
ADDRGP4 $299
ASGNP4
line 278
;278:	s_preferences.framel.generic.flags = QMF_INACTIVE;
ADDRGP4 s_preferences+496+44
CNSTU4 16384
ASGNU4
line 279
;279:	s_preferences.framel.generic.x	   = 0;
ADDRGP4 s_preferences+496+12
CNSTI4 0
ASGNI4
line 280
;280:	s_preferences.framel.generic.y	   = 78;
ADDRGP4 s_preferences+496+16
CNSTI4 78
ASGNI4
line 281
;281:	s_preferences.framel.width  	   = 256;
ADDRGP4 s_preferences+496+76
CNSTI4 256
ASGNI4
line 282
;282:	s_preferences.framel.height  	   = 329;
ADDRGP4 s_preferences+496+80
CNSTI4 329
ASGNI4
line 284
;283:
;284:	s_preferences.framer.generic.type  = MTYPE_BITMAP;
ADDRGP4 s_preferences+584
CNSTI4 6
ASGNI4
line 285
;285:	s_preferences.framer.generic.name  = ART_FRAMER;
ADDRGP4 s_preferences+584+4
ADDRGP4 $313
ASGNP4
line 286
;286:	s_preferences.framer.generic.flags = QMF_INACTIVE;
ADDRGP4 s_preferences+584+44
CNSTU4 16384
ASGNU4
line 287
;287:	s_preferences.framer.generic.x	   = 376;
ADDRGP4 s_preferences+584+12
CNSTI4 376
ASGNI4
line 288
;288:	s_preferences.framer.generic.y	   = 76;
ADDRGP4 s_preferences+584+16
CNSTI4 76
ASGNI4
line 289
;289:	s_preferences.framer.width  	   = 256;
ADDRGP4 s_preferences+584+76
CNSTI4 256
ASGNI4
line 290
;290:	s_preferences.framer.height  	   = 334;
ADDRGP4 s_preferences+584+80
CNSTI4 334
ASGNI4
line 296
;291:
;292:	// JUHOX: adjust menu position to attend for 5 new entries
;293:#if 0
;294:	y = 144;
;295:#else
;296:	y = 144 - 2.5 * (BIGCHAR_HEIGHT+2);
ADDRLP4 0
CNSTI4 99
ASGNI4
line 298
;297:#endif
;298:	s_preferences.crosshair.generic.type		= MTYPE_TEXT;
ADDRGP4 s_preferences+672
CNSTI4 7
ASGNI4
line 299
;299:	s_preferences.crosshair.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT|QMF_NODEFAULTINIT|QMF_OWNERDRAW;
ADDRGP4 s_preferences+672+44
CNSTU4 98562
ASGNU4
line 300
;300:	s_preferences.crosshair.generic.x			= PREFERENCES_X_POS;
ADDRGP4 s_preferences+672+12
CNSTI4 360
ASGNI4
line 301
;301:	s_preferences.crosshair.generic.y			= y;
ADDRGP4 s_preferences+672+16
ADDRLP4 0
INDIRI4
ASGNI4
line 302
;302:	s_preferences.crosshair.generic.name		= "Crosshair:";
ADDRGP4 s_preferences+672+4
ADDRGP4 $333
ASGNP4
line 303
;303:	s_preferences.crosshair.generic.callback	= Preferences_Event;
ADDRGP4 s_preferences+672+48
ADDRGP4 Preferences_Event
ASGNP4
line 304
;304:	s_preferences.crosshair.generic.ownerdraw	= Crosshair_Draw;
ADDRGP4 s_preferences+672+56
ADDRGP4 Crosshair_Draw
ASGNP4
line 305
;305:	s_preferences.crosshair.generic.id			= ID_CROSSHAIR;
ADDRGP4 s_preferences+672+8
CNSTI4 127
ASGNI4
line 306
;306:	s_preferences.crosshair.generic.top			= y - 4;
ADDRGP4 s_preferences+672+24
ADDRLP4 0
INDIRI4
CNSTI4 4
SUBI4
ASGNI4
line 307
;307:	s_preferences.crosshair.generic.bottom		= y + 20;
ADDRGP4 s_preferences+672+32
ADDRLP4 0
INDIRI4
CNSTI4 20
ADDI4
ASGNI4
line 308
;308:	s_preferences.crosshair.generic.left		= PREFERENCES_X_POS - ( ( strlen(s_preferences.crosshair.generic.name) + 1 ) * SMALLCHAR_WIDTH );
ADDRGP4 s_preferences+672+4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRGP4 s_preferences+672+20
CNSTI4 360
ADDRLP4 4
INDIRI4
CNSTI4 3
LSHI4
CNSTI4 8
ADDI4
SUBI4
ASGNI4
line 309
;309:	s_preferences.crosshair.generic.right		= PREFERENCES_X_POS + 48;
ADDRGP4 s_preferences+672+28
CNSTI4 408
ASGNI4
line 311
;310:
;311:	y += BIGCHAR_HEIGHT+2+4;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 22
ADDI4
ASGNI4
line 312
;312:	s_preferences.simpleitems.generic.type        = MTYPE_RADIOBUTTON;
ADDRGP4 s_preferences+768
CNSTI4 5
ASGNI4
line 313
;313:	s_preferences.simpleitems.generic.name	      = "Simple Items:";
ADDRGP4 s_preferences+768+4
ADDRGP4 $353
ASGNP4
line 314
;314:	s_preferences.simpleitems.generic.flags	      = QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 s_preferences+768+44
CNSTU4 258
ASGNU4
line 315
;315:	s_preferences.simpleitems.generic.callback    = Preferences_Event;
ADDRGP4 s_preferences+768+48
ADDRGP4 Preferences_Event
ASGNP4
line 316
;316:	s_preferences.simpleitems.generic.id          = ID_SIMPLEITEMS;
ADDRGP4 s_preferences+768+8
CNSTI4 128
ASGNI4
line 317
;317:	s_preferences.simpleitems.generic.x	          = PREFERENCES_X_POS;
ADDRGP4 s_preferences+768+12
CNSTI4 360
ASGNI4
line 318
;318:	s_preferences.simpleitems.generic.y	          = y;
ADDRGP4 s_preferences+768+16
ADDRLP4 0
INDIRI4
ASGNI4
line 320
;319:
;320:	y += BIGCHAR_HEIGHT;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 321
;321:	s_preferences.wallmarks.generic.type          = MTYPE_RADIOBUTTON;
ADDRGP4 s_preferences+896
CNSTI4 5
ASGNI4
line 322
;322:	s_preferences.wallmarks.generic.name	      = "Marks on Walls:";
ADDRGP4 s_preferences+896+4
ADDRGP4 $367
ASGNP4
line 323
;323:	s_preferences.wallmarks.generic.flags	      = QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 s_preferences+896+44
CNSTU4 258
ASGNU4
line 324
;324:	s_preferences.wallmarks.generic.callback      = Preferences_Event;
ADDRGP4 s_preferences+896+48
ADDRGP4 Preferences_Event
ASGNP4
line 325
;325:	s_preferences.wallmarks.generic.id            = ID_WALLMARKS;
ADDRGP4 s_preferences+896+8
CNSTI4 131
ASGNI4
line 326
;326:	s_preferences.wallmarks.generic.x	          = PREFERENCES_X_POS;
ADDRGP4 s_preferences+896+12
CNSTI4 360
ASGNI4
line 327
;327:	s_preferences.wallmarks.generic.y	          = y;
ADDRGP4 s_preferences+896+16
ADDRLP4 0
INDIRI4
ASGNI4
line 329
;328:
;329:	y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 330
;330:	s_preferences.brass.generic.type              = MTYPE_RADIOBUTTON;
ADDRGP4 s_preferences+832
CNSTI4 5
ASGNI4
line 331
;331:	s_preferences.brass.generic.name	          = "Ejecting Brass:";
ADDRGP4 s_preferences+832+4
ADDRGP4 $381
ASGNP4
line 332
;332:	s_preferences.brass.generic.flags	          = QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 s_preferences+832+44
CNSTU4 258
ASGNU4
line 333
;333:	s_preferences.brass.generic.callback          = Preferences_Event;
ADDRGP4 s_preferences+832+48
ADDRGP4 Preferences_Event
ASGNP4
line 334
;334:	s_preferences.brass.generic.id                = ID_EJECTINGBRASS;
ADDRGP4 s_preferences+832+8
CNSTI4 130
ASGNI4
line 335
;335:	s_preferences.brass.generic.x	              = PREFERENCES_X_POS;
ADDRGP4 s_preferences+832+12
CNSTI4 360
ASGNI4
line 336
;336:	s_preferences.brass.generic.y	              = y;
ADDRGP4 s_preferences+832+16
ADDRLP4 0
INDIRI4
ASGNI4
line 338
;337:
;338:	y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 339
;339:	s_preferences.dynamiclights.generic.type      = MTYPE_RADIOBUTTON;
ADDRGP4 s_preferences+960
CNSTI4 5
ASGNI4
line 340
;340:	s_preferences.dynamiclights.generic.name	  = "Dynamic Lights:";
ADDRGP4 s_preferences+960+4
ADDRGP4 $395
ASGNP4
line 341
;341:	s_preferences.dynamiclights.generic.flags     = QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 s_preferences+960+44
CNSTU4 258
ASGNU4
line 342
;342:	s_preferences.dynamiclights.generic.callback  = Preferences_Event;
ADDRGP4 s_preferences+960+48
ADDRGP4 Preferences_Event
ASGNP4
line 343
;343:	s_preferences.dynamiclights.generic.id        = ID_DYNAMICLIGHTS;
ADDRGP4 s_preferences+960+8
CNSTI4 132
ASGNI4
line 344
;344:	s_preferences.dynamiclights.generic.x	      = PREFERENCES_X_POS;
ADDRGP4 s_preferences+960+12
CNSTI4 360
ASGNI4
line 345
;345:	s_preferences.dynamiclights.generic.y	      = y;
ADDRGP4 s_preferences+960+16
ADDRLP4 0
INDIRI4
ASGNI4
line 347
;346:
;347:	y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 348
;348:	s_preferences.identifytarget.generic.type     = MTYPE_RADIOBUTTON;
ADDRGP4 s_preferences+1024
CNSTI4 5
ASGNI4
line 349
;349:	s_preferences.identifytarget.generic.name	  = "Identify Target:";
ADDRGP4 s_preferences+1024+4
ADDRGP4 $409
ASGNP4
line 350
;350:	s_preferences.identifytarget.generic.flags    = QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 s_preferences+1024+44
CNSTU4 258
ASGNU4
line 351
;351:	s_preferences.identifytarget.generic.callback = Preferences_Event;
ADDRGP4 s_preferences+1024+48
ADDRGP4 Preferences_Event
ASGNP4
line 352
;352:	s_preferences.identifytarget.generic.id       = ID_IDENTIFYTARGET;
ADDRGP4 s_preferences+1024+8
CNSTI4 133
ASGNI4
line 353
;353:	s_preferences.identifytarget.generic.x	      = PREFERENCES_X_POS;
ADDRGP4 s_preferences+1024+12
CNSTI4 360
ASGNI4
line 354
;354:	s_preferences.identifytarget.generic.y	      = y;
ADDRGP4 s_preferences+1024+16
ADDRLP4 0
INDIRI4
ASGNI4
line 356
;355:
;356:	y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 357
;357:	s_preferences.highqualitysky.generic.type     = MTYPE_RADIOBUTTON;
ADDRGP4 s_preferences+1088
CNSTI4 5
ASGNI4
line 358
;358:	s_preferences.highqualitysky.generic.name	  = "High Quality Sky:";
ADDRGP4 s_preferences+1088+4
ADDRGP4 $423
ASGNP4
line 359
;359:	s_preferences.highqualitysky.generic.flags	  = QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 s_preferences+1088+44
CNSTU4 258
ASGNU4
line 360
;360:	s_preferences.highqualitysky.generic.callback = Preferences_Event;
ADDRGP4 s_preferences+1088+48
ADDRGP4 Preferences_Event
ASGNP4
line 361
;361:	s_preferences.highqualitysky.generic.id       = ID_HIGHQUALITYSKY;
ADDRGP4 s_preferences+1088+8
CNSTI4 129
ASGNI4
line 362
;362:	s_preferences.highqualitysky.generic.x	      = PREFERENCES_X_POS;
ADDRGP4 s_preferences+1088+12
CNSTI4 360
ASGNI4
line 363
;363:	s_preferences.highqualitysky.generic.y	      = y;
ADDRGP4 s_preferences+1088+16
ADDRLP4 0
INDIRI4
ASGNI4
line 367
;364:
;365:	// JUHOX: init "glass cloaking" menu field
;366:#if 1
;367:	y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 368
;368:	s_preferences.glassCloaking.generic.type		= MTYPE_RADIOBUTTON;
ADDRGP4 s_preferences+1152
CNSTI4 5
ASGNI4
line 369
;369:	s_preferences.glassCloaking.generic.name		= "Glass Cloaking:";
ADDRGP4 s_preferences+1152+4
ADDRGP4 $437
ASGNP4
line 370
;370:	s_preferences.glassCloaking.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 s_preferences+1152+44
CNSTU4 258
ASGNU4
line 371
;371:	s_preferences.glassCloaking.generic.callback	= Preferences_Event;
ADDRGP4 s_preferences+1152+48
ADDRGP4 Preferences_Event
ASGNP4
line 372
;372:	s_preferences.glassCloaking.generic.id			= ID_GLASSCLOAKING;
ADDRGP4 s_preferences+1152+8
CNSTI4 139
ASGNI4
line 373
;373:	s_preferences.glassCloaking.generic.x			= PREFERENCES_X_POS;
ADDRGP4 s_preferences+1152+12
CNSTI4 360
ASGNI4
line 374
;374:	s_preferences.glassCloaking.generic.y			= y;
ADDRGP4 s_preferences+1152+16
ADDRLP4 0
INDIRI4
ASGNI4
line 379
;375:#endif
;376:
;377:	// JUHOX: init "lens flare" menu field
;378:#if 1
;379:	y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 380
;380:	s_preferences.lensFlare.generic.type		= MTYPE_RADIOBUTTON;
ADDRGP4 s_preferences+1216
CNSTI4 5
ASGNI4
line 381
;381:	s_preferences.lensFlare.generic.name		= "Lens Flare:";
ADDRGP4 s_preferences+1216+4
ADDRGP4 $451
ASGNP4
line 382
;382:	s_preferences.lensFlare.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 s_preferences+1216+44
CNSTU4 258
ASGNU4
line 383
;383:	s_preferences.lensFlare.generic.callback	= Preferences_Event;
ADDRGP4 s_preferences+1216+48
ADDRGP4 Preferences_Event
ASGNP4
line 384
;384:	s_preferences.lensFlare.generic.id			= ID_LENSFLARE;
ADDRGP4 s_preferences+1216+8
CNSTI4 140
ASGNI4
line 385
;385:	s_preferences.lensFlare.generic.x			= PREFERENCES_X_POS;
ADDRGP4 s_preferences+1216+12
CNSTI4 360
ASGNI4
line 386
;386:	s_preferences.lensFlare.generic.y			= y;
ADDRGP4 s_preferences+1216+16
ADDRLP4 0
INDIRI4
ASGNI4
line 391
;387:#endif
;388:
;389:	// JUHOX: init "bfg super explosion" menu field
;390:#if 1
;391:	y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 392
;392:	s_preferences.bfgSuperExpl.generic.type		= MTYPE_RADIOBUTTON;
ADDRGP4 s_preferences+1280
CNSTI4 5
ASGNI4
line 393
;393:	s_preferences.bfgSuperExpl.generic.name		= "High Quality BFG Explosion:";
ADDRGP4 s_preferences+1280+4
ADDRGP4 $465
ASGNP4
line 394
;394:	s_preferences.bfgSuperExpl.generic.flags	= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 s_preferences+1280+44
CNSTU4 258
ASGNU4
line 395
;395:	s_preferences.bfgSuperExpl.generic.callback	= Preferences_Event;
ADDRGP4 s_preferences+1280+48
ADDRGP4 Preferences_Event
ASGNP4
line 396
;396:	s_preferences.bfgSuperExpl.generic.id		= ID_BFGSUPEREXPL;
ADDRGP4 s_preferences+1280+8
CNSTI4 142
ASGNI4
line 397
;397:	s_preferences.bfgSuperExpl.generic.x		= PREFERENCES_X_POS;
ADDRGP4 s_preferences+1280+12
CNSTI4 360
ASGNI4
line 398
;398:	s_preferences.bfgSuperExpl.generic.y		= y;
ADDRGP4 s_preferences+1280+16
ADDRLP4 0
INDIRI4
ASGNI4
line 401
;399:#endif
;400:
;401:	y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 402
;402:	s_preferences.synceveryframe.generic.type     = MTYPE_RADIOBUTTON;
ADDRGP4 s_preferences+1344
CNSTI4 5
ASGNI4
line 403
;403:	s_preferences.synceveryframe.generic.name	  = "Sync Every Frame:";
ADDRGP4 s_preferences+1344+4
ADDRGP4 $479
ASGNP4
line 404
;404:	s_preferences.synceveryframe.generic.flags	  = QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 s_preferences+1344+44
CNSTU4 258
ASGNU4
line 405
;405:	s_preferences.synceveryframe.generic.callback = Preferences_Event;
ADDRGP4 s_preferences+1344+48
ADDRGP4 Preferences_Event
ASGNP4
line 406
;406:	s_preferences.synceveryframe.generic.id       = ID_SYNCEVERYFRAME;
ADDRGP4 s_preferences+1344+8
CNSTI4 134
ASGNI4
line 407
;407:	s_preferences.synceveryframe.generic.x	      = PREFERENCES_X_POS;
ADDRGP4 s_preferences+1344+12
CNSTI4 360
ASGNI4
line 408
;408:	s_preferences.synceveryframe.generic.y	      = y;
ADDRGP4 s_preferences+1344+16
ADDRLP4 0
INDIRI4
ASGNI4
line 410
;409:
;410:	y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 411
;411:	s_preferences.forcemodel.generic.type     = MTYPE_RADIOBUTTON;
ADDRGP4 s_preferences+1408
CNSTI4 5
ASGNI4
line 412
;412:	s_preferences.forcemodel.generic.name	  = "Force Player Models:";
ADDRGP4 s_preferences+1408+4
ADDRGP4 $493
ASGNP4
line 413
;413:	s_preferences.forcemodel.generic.flags	  = QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 s_preferences+1408+44
CNSTU4 258
ASGNU4
line 414
;414:	s_preferences.forcemodel.generic.callback = Preferences_Event;
ADDRGP4 s_preferences+1408+48
ADDRGP4 Preferences_Event
ASGNP4
line 415
;415:	s_preferences.forcemodel.generic.id       = ID_FORCEMODEL;
ADDRGP4 s_preferences+1408+8
CNSTI4 135
ASGNI4
line 416
;416:	s_preferences.forcemodel.generic.x	      = PREFERENCES_X_POS;
ADDRGP4 s_preferences+1408+12
CNSTI4 360
ASGNI4
line 417
;417:	s_preferences.forcemodel.generic.y	      = y;
ADDRGP4 s_preferences+1408+16
ADDRLP4 0
INDIRI4
ASGNI4
line 419
;418:
;419:	y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 420
;420:	s_preferences.drawteamoverlay.generic.type     = MTYPE_SPINCONTROL;
ADDRGP4 s_preferences+1472
CNSTI4 3
ASGNI4
line 421
;421:	s_preferences.drawteamoverlay.generic.name	   = "Draw Team Overlay:";
ADDRGP4 s_preferences+1472+4
ADDRGP4 $507
ASGNP4
line 422
;422:	s_preferences.drawteamoverlay.generic.flags	   = QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 s_preferences+1472+44
CNSTU4 258
ASGNU4
line 423
;423:	s_preferences.drawteamoverlay.generic.callback = Preferences_Event;
ADDRGP4 s_preferences+1472+48
ADDRGP4 Preferences_Event
ASGNP4
line 424
;424:	s_preferences.drawteamoverlay.generic.id       = ID_DRAWTEAMOVERLAY;
ADDRGP4 s_preferences+1472+8
CNSTI4 136
ASGNI4
line 425
;425:	s_preferences.drawteamoverlay.generic.x	       = PREFERENCES_X_POS;
ADDRGP4 s_preferences+1472+12
CNSTI4 360
ASGNI4
line 426
;426:	s_preferences.drawteamoverlay.generic.y	       = y;
ADDRGP4 s_preferences+1472+16
ADDRLP4 0
INDIRI4
ASGNI4
line 427
;427:	s_preferences.drawteamoverlay.itemnames			= teamoverlay_names;
ADDRGP4 s_preferences+1472+76
ADDRGP4 teamoverlay_names
ASGNP4
line 431
;428:
;429:	// JUHOX: init musicmode menu item
;430:#if PLAYLIST
;431:	y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 432
;432:	s_preferences.musicmode.generic.type		= MTYPE_SPINCONTROL;
ADDRGP4 s_preferences+1568
CNSTI4 3
ASGNI4
line 433
;433:	s_preferences.musicmode.generic.name		= "In-Game Music:";
ADDRGP4 s_preferences+1568+4
ADDRGP4 $523
ASGNP4
line 434
;434:	s_preferences.musicmode.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 s_preferences+1568+44
CNSTU4 258
ASGNU4
line 435
;435:	s_preferences.musicmode.generic.callback	= Preferences_Event;
ADDRGP4 s_preferences+1568+48
ADDRGP4 Preferences_Event
ASGNP4
line 436
;436:	s_preferences.musicmode.generic.id			= ID_MUSICMODE;
ADDRGP4 s_preferences+1568+8
CNSTI4 143
ASGNI4
line 437
;437:	s_preferences.musicmode.generic.x			= PREFERENCES_X_POS;
ADDRGP4 s_preferences+1568+12
CNSTI4 360
ASGNI4
line 438
;438:	s_preferences.musicmode.generic.y			= y;
ADDRGP4 s_preferences+1568+16
ADDRLP4 0
INDIRI4
ASGNI4
line 439
;439:	s_preferences.musicmode.itemnames			= musicmode_names;
ADDRGP4 s_preferences+1568+76
ADDRGP4 musicmode_names
ASGNP4
line 444
;440:#endif
;441:
;442:	// JUHOX: init "auto group leader command" menu field
;443:#if 1
;444:	y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 445
;445:	s_preferences.autoglc.generic.type		= MTYPE_RADIOBUTTON;
ADDRGP4 s_preferences+1664
CNSTI4 5
ASGNI4
line 446
;446:	s_preferences.autoglc.generic.name		= "Auto Group Leader Command:";
ADDRGP4 s_preferences+1664+4
ADDRGP4 $539
ASGNP4
line 447
;447:	s_preferences.autoglc.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 s_preferences+1664+44
CNSTU4 258
ASGNU4
line 448
;448:	s_preferences.autoglc.generic.callback	= Preferences_Event;
ADDRGP4 s_preferences+1664+48
ADDRGP4 Preferences_Event
ASGNP4
line 449
;449:	s_preferences.autoglc.generic.id		= ID_AUTOGLC;
ADDRGP4 s_preferences+1664+8
CNSTI4 141
ASGNI4
line 450
;450:	s_preferences.autoglc.generic.x			= PREFERENCES_X_POS;
ADDRGP4 s_preferences+1664+12
CNSTI4 360
ASGNI4
line 451
;451:	s_preferences.autoglc.generic.y			= y;
ADDRGP4 s_preferences+1664+16
ADDRLP4 0
INDIRI4
ASGNI4
line 454
;452:#endif
;453:
;454:	y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 455
;455:	s_preferences.allowdownload.generic.type     = MTYPE_RADIOBUTTON;
ADDRGP4 s_preferences+1728
CNSTI4 5
ASGNI4
line 456
;456:	s_preferences.allowdownload.generic.name	   = "Automatic Downloading:";
ADDRGP4 s_preferences+1728+4
ADDRGP4 $553
ASGNP4
line 457
;457:	s_preferences.allowdownload.generic.flags	   = QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 s_preferences+1728+44
CNSTU4 258
ASGNU4
line 458
;458:	s_preferences.allowdownload.generic.callback = Preferences_Event;
ADDRGP4 s_preferences+1728+48
ADDRGP4 Preferences_Event
ASGNP4
line 459
;459:	s_preferences.allowdownload.generic.id       = ID_ALLOWDOWNLOAD;
ADDRGP4 s_preferences+1728+8
CNSTI4 137
ASGNI4
line 460
;460:	s_preferences.allowdownload.generic.x	       = PREFERENCES_X_POS;
ADDRGP4 s_preferences+1728+12
CNSTI4 360
ASGNI4
line 461
;461:	s_preferences.allowdownload.generic.y	       = y;
ADDRGP4 s_preferences+1728+16
ADDRLP4 0
INDIRI4
ASGNI4
line 463
;462:
;463:	y += BIGCHAR_HEIGHT+2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 464
;464:	s_preferences.back.generic.type	    = MTYPE_BITMAP;
ADDRGP4 s_preferences+1792
CNSTI4 6
ASGNI4
line 465
;465:	s_preferences.back.generic.name     = ART_BACK0;
ADDRGP4 s_preferences+1792+4
ADDRGP4 $567
ASGNP4
line 466
;466:	s_preferences.back.generic.flags    = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_preferences+1792+44
CNSTU4 260
ASGNU4
line 467
;467:	s_preferences.back.generic.callback = Preferences_Event;
ADDRGP4 s_preferences+1792+48
ADDRGP4 Preferences_Event
ASGNP4
line 468
;468:	s_preferences.back.generic.id	    = ID_BACK;
ADDRGP4 s_preferences+1792+8
CNSTI4 138
ASGNI4
line 469
;469:	s_preferences.back.generic.x		= 0;
ADDRGP4 s_preferences+1792+12
CNSTI4 0
ASGNI4
line 470
;470:	s_preferences.back.generic.y		= 480-64;
ADDRGP4 s_preferences+1792+16
CNSTI4 416
ASGNI4
line 471
;471:	s_preferences.back.width  		    = 128;
ADDRGP4 s_preferences+1792+76
CNSTI4 128
ASGNI4
line 472
;472:	s_preferences.back.height  		    = 64;
ADDRGP4 s_preferences+1792+80
CNSTI4 64
ASGNI4
line 473
;473:	s_preferences.back.focuspic         = ART_BACK1;
ADDRGP4 s_preferences+1792+60
ADDRGP4 $584
ASGNP4
line 475
;474:
;475:	Menu_AddItem( &s_preferences.menu, &s_preferences.banner );
ADDRGP4 s_preferences
ARGP4
ADDRGP4 s_preferences+424
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 476
;476:	Menu_AddItem( &s_preferences.menu, &s_preferences.framel );
ADDRGP4 s_preferences
ARGP4
ADDRGP4 s_preferences+496
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 477
;477:	Menu_AddItem( &s_preferences.menu, &s_preferences.framer );
ADDRGP4 s_preferences
ARGP4
ADDRGP4 s_preferences+584
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 479
;478:
;479:	Menu_AddItem( &s_preferences.menu, &s_preferences.crosshair );
ADDRGP4 s_preferences
ARGP4
ADDRGP4 s_preferences+672
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 480
;480:	Menu_AddItem( &s_preferences.menu, &s_preferences.simpleitems );
ADDRGP4 s_preferences
ARGP4
ADDRGP4 s_preferences+768
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 481
;481:	Menu_AddItem( &s_preferences.menu, &s_preferences.wallmarks );
ADDRGP4 s_preferences
ARGP4
ADDRGP4 s_preferences+896
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 482
;482:	Menu_AddItem( &s_preferences.menu, &s_preferences.brass );
ADDRGP4 s_preferences
ARGP4
ADDRGP4 s_preferences+832
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 483
;483:	Menu_AddItem( &s_preferences.menu, &s_preferences.dynamiclights );
ADDRGP4 s_preferences
ARGP4
ADDRGP4 s_preferences+960
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 484
;484:	Menu_AddItem( &s_preferences.menu, &s_preferences.identifytarget );
ADDRGP4 s_preferences
ARGP4
ADDRGP4 s_preferences+1024
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 485
;485:	Menu_AddItem( &s_preferences.menu, &s_preferences.highqualitysky );
ADDRGP4 s_preferences
ARGP4
ADDRGP4 s_preferences+1088
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 486
;486:	Menu_AddItem( &s_preferences.menu, &s_preferences.glassCloaking );	// JUHOX
ADDRGP4 s_preferences
ARGP4
ADDRGP4 s_preferences+1152
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 487
;487:	Menu_AddItem( &s_preferences.menu, &s_preferences.lensFlare);	// JUHOX
ADDRGP4 s_preferences
ARGP4
ADDRGP4 s_preferences+1216
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 488
;488:	Menu_AddItem( &s_preferences.menu, &s_preferences.bfgSuperExpl);	// JUHOX
ADDRGP4 s_preferences
ARGP4
ADDRGP4 s_preferences+1280
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 489
;489:	Menu_AddItem( &s_preferences.menu, &s_preferences.synceveryframe );
ADDRGP4 s_preferences
ARGP4
ADDRGP4 s_preferences+1344
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 490
;490:	Menu_AddItem( &s_preferences.menu, &s_preferences.forcemodel );
ADDRGP4 s_preferences
ARGP4
ADDRGP4 s_preferences+1408
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 491
;491:	Menu_AddItem( &s_preferences.menu, &s_preferences.drawteamoverlay );
ADDRGP4 s_preferences
ARGP4
ADDRGP4 s_preferences+1472
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 493
;492:#if PLAYLIST
;493:	Menu_AddItem( &s_preferences.menu, &s_preferences.musicmode );	// JUHOX
ADDRGP4 s_preferences
ARGP4
ADDRGP4 s_preferences+1568
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 495
;494:#endif
;495:	Menu_AddItem( &s_preferences.menu, &s_preferences.autoglc );	// JUHOX
ADDRGP4 s_preferences
ARGP4
ADDRGP4 s_preferences+1664
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 496
;496:	Menu_AddItem( &s_preferences.menu, &s_preferences.allowdownload );
ADDRGP4 s_preferences
ARGP4
ADDRGP4 s_preferences+1728
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 498
;497:
;498:	Menu_AddItem( &s_preferences.menu, &s_preferences.back );
ADDRGP4 s_preferences
ARGP4
ADDRGP4 s_preferences+1792
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 500
;499:
;500:	Preferences_SetMenuItems();
ADDRGP4 Preferences_SetMenuItems
CALLV
pop
line 501
;501:}
LABELV $281
endproc Preferences_MenuInit 8 12
export Preferences_Cache
proc Preferences_Cache 16 8
line 509
;502:
;503:
;504:/*
;505:===============
;506:Preferences_Cache
;507:===============
;508:*/
;509:void Preferences_Cache( void ) {
line 512
;510:	int		n;
;511:
;512:	trap_R_RegisterShaderNoMip( ART_FRAMEL );
ADDRGP4 $299
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 513
;513:	trap_R_RegisterShaderNoMip( ART_FRAMER );
ADDRGP4 $313
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 514
;514:	trap_R_RegisterShaderNoMip( ART_BACK0 );
ADDRGP4 $567
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 515
;515:	trap_R_RegisterShaderNoMip( ART_BACK1 );
ADDRGP4 $584
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 516
;516:	for( n = 0; n < NUM_CROSSHAIRS; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $606
line 517
;517:		s_preferences.crosshairShader[n] = trap_R_RegisterShaderNoMip( va("gfx/2d/crosshair%c", 'a' + n ) );
ADDRGP4 $611
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 97
ADDI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 s_preferences+1880
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 518
;518:	}
LABELV $607
line 516
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 10
LTI4 $606
line 519
;519:}
LABELV $605
endproc Preferences_Cache 16 8
export UI_PreferencesMenu
proc UI_PreferencesMenu 0 4
line 527
;520:
;521:
;522:/*
;523:===============
;524:UI_PreferencesMenu
;525:===============
;526:*/
;527:void UI_PreferencesMenu( void ) {
line 528
;528:	Preferences_MenuInit();
ADDRGP4 Preferences_MenuInit
CALLV
pop
line 529
;529:	UI_PushMenu( &s_preferences.menu );
ADDRGP4 s_preferences
ARGP4
ADDRGP4 UI_PushMenu
CALLV
pop
line 530
;530:}
LABELV $612
endproc UI_PreferencesMenu 0 4
bss
align 4
LABELV s_preferences
skip 1920
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
LABELV $611
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 37
byte 1 99
byte 1 0
align 1
LABELV $584
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
LABELV $567
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
LABELV $553
byte 1 65
byte 1 117
byte 1 116
byte 1 111
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 99
byte 1 32
byte 1 68
byte 1 111
byte 1 119
byte 1 110
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 58
byte 1 0
align 1
LABELV $539
byte 1 65
byte 1 117
byte 1 116
byte 1 111
byte 1 32
byte 1 71
byte 1 114
byte 1 111
byte 1 117
byte 1 112
byte 1 32
byte 1 76
byte 1 101
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 32
byte 1 67
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 58
byte 1 0
align 1
LABELV $523
byte 1 73
byte 1 110
byte 1 45
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 77
byte 1 117
byte 1 115
byte 1 105
byte 1 99
byte 1 58
byte 1 0
align 1
LABELV $507
byte 1 68
byte 1 114
byte 1 97
byte 1 119
byte 1 32
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 79
byte 1 118
byte 1 101
byte 1 114
byte 1 108
byte 1 97
byte 1 121
byte 1 58
byte 1 0
align 1
LABELV $493
byte 1 70
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 32
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 58
byte 1 0
align 1
LABELV $479
byte 1 83
byte 1 121
byte 1 110
byte 1 99
byte 1 32
byte 1 69
byte 1 118
byte 1 101
byte 1 114
byte 1 121
byte 1 32
byte 1 70
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 58
byte 1 0
align 1
LABELV $465
byte 1 72
byte 1 105
byte 1 103
byte 1 104
byte 1 32
byte 1 81
byte 1 117
byte 1 97
byte 1 108
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 66
byte 1 70
byte 1 71
byte 1 32
byte 1 69
byte 1 120
byte 1 112
byte 1 108
byte 1 111
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 58
byte 1 0
align 1
LABELV $451
byte 1 76
byte 1 101
byte 1 110
byte 1 115
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 114
byte 1 101
byte 1 58
byte 1 0
align 1
LABELV $437
byte 1 71
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 32
byte 1 67
byte 1 108
byte 1 111
byte 1 97
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 58
byte 1 0
align 1
LABELV $423
byte 1 72
byte 1 105
byte 1 103
byte 1 104
byte 1 32
byte 1 81
byte 1 117
byte 1 97
byte 1 108
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 83
byte 1 107
byte 1 121
byte 1 58
byte 1 0
align 1
LABELV $409
byte 1 73
byte 1 100
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 102
byte 1 121
byte 1 32
byte 1 84
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 58
byte 1 0
align 1
LABELV $395
byte 1 68
byte 1 121
byte 1 110
byte 1 97
byte 1 109
byte 1 105
byte 1 99
byte 1 32
byte 1 76
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 115
byte 1 58
byte 1 0
align 1
LABELV $381
byte 1 69
byte 1 106
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 66
byte 1 114
byte 1 97
byte 1 115
byte 1 115
byte 1 58
byte 1 0
align 1
LABELV $367
byte 1 77
byte 1 97
byte 1 114
byte 1 107
byte 1 115
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 87
byte 1 97
byte 1 108
byte 1 108
byte 1 115
byte 1 58
byte 1 0
align 1
LABELV $353
byte 1 83
byte 1 105
byte 1 109
byte 1 112
byte 1 108
byte 1 101
byte 1 32
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 58
byte 1 0
align 1
LABELV $333
byte 1 67
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 58
byte 1 0
align 1
LABELV $313
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
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 49
byte 1 95
byte 1 114
byte 1 0
align 1
LABELV $299
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
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 50
byte 1 95
byte 1 108
byte 1 0
align 1
LABELV $291
byte 1 71
byte 1 65
byte 1 77
byte 1 69
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
LABELV $261
byte 1 99
byte 1 103
byte 1 95
byte 1 97
byte 1 117
byte 1 116
byte 1 111
byte 1 71
byte 1 76
byte 1 67
byte 1 0
align 1
LABELV $247
byte 1 115
byte 1 118
byte 1 95
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 68
byte 1 111
byte 1 119
byte 1 110
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $188
byte 1 99
byte 1 103
byte 1 95
byte 1 97
byte 1 117
byte 1 116
byte 1 111
byte 1 103
byte 1 108
byte 1 99
byte 1 0
align 1
LABELV $182
byte 1 99
byte 1 103
byte 1 95
byte 1 98
byte 1 102
byte 1 103
byte 1 83
byte 1 117
byte 1 112
byte 1 101
byte 1 114
byte 1 69
byte 1 120
byte 1 112
byte 1 108
byte 1 0
align 1
LABELV $176
byte 1 99
byte 1 103
byte 1 95
byte 1 108
byte 1 101
byte 1 110
byte 1 115
byte 1 70
byte 1 108
byte 1 97
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $170
byte 1 99
byte 1 103
byte 1 95
byte 1 103
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 67
byte 1 108
byte 1 111
byte 1 97
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $164
byte 1 99
byte 1 108
byte 1 95
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 68
byte 1 111
byte 1 119
byte 1 110
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $161
byte 1 99
byte 1 103
byte 1 95
byte 1 109
byte 1 117
byte 1 115
byte 1 105
byte 1 99
byte 1 0
align 1
LABELV $158
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 79
byte 1 118
byte 1 101
byte 1 114
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $152
byte 1 99
byte 1 103
byte 1 95
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $146
byte 1 114
byte 1 95
byte 1 102
byte 1 105
byte 1 110
byte 1 105
byte 1 115
byte 1 104
byte 1 0
align 1
LABELV $140
byte 1 114
byte 1 95
byte 1 102
byte 1 97
byte 1 115
byte 1 116
byte 1 115
byte 1 107
byte 1 121
byte 1 0
align 1
LABELV $134
byte 1 114
byte 1 95
byte 1 100
byte 1 121
byte 1 110
byte 1 97
byte 1 109
byte 1 105
byte 1 99
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $128
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 67
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $122
byte 1 99
byte 1 103
byte 1 95
byte 1 109
byte 1 97
byte 1 114
byte 1 107
byte 1 115
byte 1 0
align 1
LABELV $116
byte 1 99
byte 1 103
byte 1 95
byte 1 98
byte 1 114
byte 1 97
byte 1 115
byte 1 115
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $110
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 105
byte 1 109
byte 1 112
byte 1 108
byte 1 101
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $107
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 67
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 0
align 1
LABELV $103
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $102
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $101
byte 1 110
byte 1 111
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $100
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 32
byte 1 108
byte 1 101
byte 1 102
byte 1 116
byte 1 0
align 1
LABELV $99
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 32
byte 1 114
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $98
byte 1 117
byte 1 112
byte 1 112
byte 1 101
byte 1 114
byte 1 32
byte 1 114
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $97
byte 1 111
byte 1 102
byte 1 102
byte 1 0
