export Com_Error
code
proc Com_Error 1032 12
file "..\..\..\..\code\q3_ui\ui_atoms.c"
line 16
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:/**********************************************************************
;4:	UI_ATOMS.C
;5:
;6:	User interface building blocks and support functions.
;7:**********************************************************************/
;8:#include "ui_local.h"
;9:
;10:uiStatic_t		uis;
;11:qboolean		m_entersound;		// after a frame, so caching won't disrupt the sound
;12:
;13:// these are here so the functions in q_shared.c can link
;14:#ifndef UI_HARD_LINKED
;15:
;16:void QDECL Com_Error( int level, const char *error, ... ) {
line 20
;17:	va_list		argptr;
;18:	char		text[1024];
;19:
;20:	va_start (argptr, error);
ADDRLP4 0
ADDRFP4 4+4
ASGNP4
line 21
;21:	vsprintf (text, error, argptr);
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
line 22
;22:	va_end (argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 24
;23:
;24:	trap_Error( va("%s", text) );
ADDRGP4 $98
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 1028
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 trap_Error
CALLV
pop
line 25
;25:}
LABELV $96
endproc Com_Error 1032 12
export Com_Printf
proc Com_Printf 1032 12
line 27
;26:
;27:void QDECL Com_Printf( const char *msg, ... ) {
line 31
;28:	va_list		argptr;
;29:	char		text[1024];
;30:
;31:	va_start (argptr, msg);
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 32
;32:	vsprintf (text, msg, argptr);
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 vsprintf
CALLI4
pop
line 33
;33:	va_end (argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 35
;34:
;35:	trap_Print( va("%s", text) );
ADDRGP4 $98
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 1028
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 36
;36:}
LABELV $99
endproc Com_Printf 1032 12
export UI_ClampCvar
proc UI_ClampCvar 0 0
line 46
;37:
;38:#endif
;39:
;40:/*
;41:=================
;42:UI_ClampCvar
;43:=================
;44:*/
;45:float UI_ClampCvar( float min, float max, float value )
;46:{
line 47
;47:	if ( value < min ) return min;
ADDRFP4 8
INDIRF4
ADDRFP4 0
INDIRF4
GEF4 $102
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $101
JUMPV
LABELV $102
line 48
;48:	if ( value > max ) return max;
ADDRFP4 8
INDIRF4
ADDRFP4 4
INDIRF4
LEF4 $104
ADDRFP4 4
INDIRF4
RETF4
ADDRGP4 $101
JUMPV
LABELV $104
line 49
;49:	return value;
ADDRFP4 8
INDIRF4
RETF4
LABELV $101
endproc UI_ClampCvar 0 0
export UI_StartDemoLoop
proc UI_StartDemoLoop 0 8
line 57
;50:}
;51:
;52:/*
;53:=================
;54:UI_StartDemoLoop
;55:=================
;56:*/
;57:void UI_StartDemoLoop( void ) {
line 58
;58:	trap_Cmd_ExecuteText( EXEC_APPEND, "d1\n" );
CNSTI4 2
ARGI4
ADDRGP4 $107
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 59
;59:}
LABELV $106
endproc UI_StartDemoLoop 0 8
export UI_PushMenu
proc UI_PushMenu 16 8
line 67
;60:
;61:/*
;62:=================
;63:UI_PushMenu
;64:=================
;65:*/
;66:void UI_PushMenu( menuframework_s *menu )
;67:{
line 72
;68:	int				i;
;69:	menucommon_s*	item;
;70:
;71:	// avoid stacking menus invoked by hotkeys
;72:	for (i=0 ; i<uis.menusp ; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $112
JUMPV
LABELV $109
line 73
;73:	{
line 74
;74:		if (uis.stack[i] == menu)
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uis+24
ADDP4
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
NEU4 $114
line 75
;75:		{
line 76
;76:			uis.menusp = i;
ADDRGP4 uis+16
ADDRLP4 0
INDIRI4
ASGNI4
line 77
;77:			break;
ADDRGP4 $111
JUMPV
LABELV $114
line 79
;78:		}
;79:	}
LABELV $110
line 72
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $112
ADDRLP4 0
INDIRI4
ADDRGP4 uis+16
INDIRI4
LTI4 $109
LABELV $111
line 81
;80:
;81:	if (i == uis.menusp)
ADDRLP4 0
INDIRI4
ADDRGP4 uis+16
INDIRI4
NEI4 $118
line 82
;82:	{
line 83
;83:		if (uis.menusp >= MAX_MENUDEPTH)
ADDRGP4 uis+16
INDIRI4
CNSTI4 8
LTI4 $121
line 84
;84:			trap_Error("UI_PushMenu: menu stack overflow");
ADDRGP4 $124
ARGP4
ADDRGP4 trap_Error
CALLV
pop
LABELV $121
line 86
;85:
;86:		uis.stack[uis.menusp++] = menu;
ADDRLP4 12
ADDRGP4 uis+16
ASGNP4
ADDRLP4 8
ADDRLP4 12
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRP4
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uis+24
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 87
;87:	}
LABELV $118
line 89
;88:
;89:	uis.activemenu = menu;
ADDRGP4 uis+20
ADDRFP4 0
INDIRP4
ASGNP4
line 92
;90:
;91:	// default cursor position
;92:	menu->cursor      = 0;
ADDRFP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 93
;93:	menu->cursor_prev = 0;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 0
ASGNI4
line 95
;94:
;95:	m_entersound = qtrue;
ADDRGP4 m_entersound
CNSTI4 1
ASGNI4
line 97
;96:
;97:	trap_Key_SetCatcher( KEYCATCH_UI );
CNSTI4 2
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 100
;98:
;99:	// force first available item to have focus
;100:	for (i=0; i<menu->nitems; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $131
JUMPV
LABELV $128
line 101
;101:	{
line 102
;102:		item = (menucommon_s *)menu->items[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDP4
INDIRP4
ASGNP4
line 103
;103:		if (!(item->flags & (QMF_GRAYED|QMF_MOUSEONLY|QMF_INACTIVE)))
ADDRLP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 26624
BANDU4
CNSTU4 0
NEU4 $132
line 104
;104:		{
line 105
;105:			menu->cursor_prev = -1;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 -1
ASGNI4
line 106
;106:			Menu_SetCursor( menu, i );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Menu_SetCursor
CALLV
pop
line 107
;107:			break;
ADDRGP4 $130
JUMPV
LABELV $132
line 109
;108:		}
;109:	}
LABELV $129
line 100
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $131
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
LTI4 $128
LABELV $130
line 111
;110:
;111:	uis.firstdraw = qtrue;
ADDRGP4 uis+11488
CNSTI4 1
ASGNI4
line 112
;112:}
LABELV $108
endproc UI_PushMenu 16 8
export UI_PopMenu
proc UI_PopMenu 4 8
line 120
;113:
;114:/*
;115:=================
;116:UI_PopMenu
;117:=================
;118:*/
;119:void UI_PopMenu (void)
;120:{
line 121
;121:	trap_S_StartLocalSound( menu_out_sound, CHAN_LOCAL_SOUND );
ADDRGP4 menu_out_sound
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 123
;122:
;123:	uis.menusp--;
ADDRLP4 0
ADDRGP4 uis+16
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 125
;124:
;125:	if (uis.menusp < 0)
ADDRGP4 uis+16
INDIRI4
CNSTI4 0
GEI4 $137
line 126
;126:		trap_Error ("UI_PopMenu: menu stack underflow");
ADDRGP4 $140
ARGP4
ADDRGP4 trap_Error
CALLV
pop
LABELV $137
line 128
;127:
;128:	if (uis.menusp) {
ADDRGP4 uis+16
INDIRI4
CNSTI4 0
EQI4 $141
line 129
;129:		uis.activemenu = uis.stack[uis.menusp-1];
ADDRGP4 uis+20
ADDRGP4 uis+16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uis+24-4
ADDP4
INDIRP4
ASGNP4
line 130
;130:		uis.firstdraw = qtrue;
ADDRGP4 uis+11488
CNSTI4 1
ASGNI4
line 131
;131:	}
ADDRGP4 $142
JUMPV
LABELV $141
line 132
;132:	else {
line 133
;133:		UI_ForceMenuOff ();
ADDRGP4 UI_ForceMenuOff
CALLV
pop
line 134
;134:	}
LABELV $142
line 135
;135:}
LABELV $135
endproc UI_PopMenu 4 8
export UI_ForceMenuOff
proc UI_ForceMenuOff 4 8
line 138
;136:
;137:void UI_ForceMenuOff (void)
;138:{
line 139
;139:	uis.menusp     = 0;
ADDRGP4 uis+16
CNSTI4 0
ASGNI4
line 140
;140:	uis.activemenu = NULL;
ADDRGP4 uis+20
CNSTP4 0
ASGNP4
line 142
;141:
;142:	trap_Key_SetCatcher( trap_Key_GetCatcher() & ~KEYCATCH_UI );
ADDRLP4 0
ADDRGP4 trap_Key_GetCatcher
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 -3
BANDI4
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 143
;143:	trap_Key_ClearStates();
ADDRGP4 trap_Key_ClearStates
CALLV
pop
line 144
;144:	trap_Cvar_Set( "cl_paused", "0" );
ADDRGP4 $152
ARGP4
ADDRGP4 $153
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 145
;145:}
LABELV $149
endproc UI_ForceMenuOff 4 8
export UI_LerpColor
proc UI_LerpColor 12 0
line 153
;146:
;147:/*
;148:=================
;149:UI_LerpColor
;150:=================
;151:*/
;152:void UI_LerpColor(vec4_t a, vec4_t b, vec4_t c, float t)
;153:{
line 157
;154:	int i;
;155:
;156:	// lerp and clamp each component
;157:	for (i=0; i<4; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $155
line 158
;158:	{
line 159
;159:		c[i] = a[i] + t*(b[i]-a[i]);
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
ADDP4
INDIRF4
ADDRFP4 12
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
ADDP4
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 160
;160:		if (c[i] < 0)
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRF4
CNSTF4 0
GEF4 $159
line 161
;161:			c[i] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 $160
JUMPV
LABELV $159
line 162
;162:		else if (c[i] > 1.0)
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRF4
CNSTF4 1065353216
LEF4 $161
line 163
;163:			c[i] = 1.0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTF4 1065353216
ASGNF4
LABELV $161
LABELV $160
line 164
;164:	}
LABELV $156
line 157
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $155
line 165
;165:}
LABELV $154
endproc UI_LerpColor 12 0
data
align 4
LABELV propMap
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 8
byte 4 11
byte 4 122
byte 4 7
byte 4 154
byte 4 181
byte 4 14
byte 4 55
byte 4 122
byte 4 17
byte 4 79
byte 4 122
byte 4 18
byte 4 101
byte 4 122
byte 4 23
byte 4 153
byte 4 122
byte 4 18
byte 4 9
byte 4 93
byte 4 7
byte 4 207
byte 4 122
byte 4 8
byte 4 230
byte 4 122
byte 4 9
byte 4 177
byte 4 122
byte 4 18
byte 4 30
byte 4 152
byte 4 18
byte 4 85
byte 4 181
byte 4 7
byte 4 34
byte 4 93
byte 4 11
byte 4 110
byte 4 181
byte 4 6
byte 4 130
byte 4 152
byte 4 14
byte 4 22
byte 4 64
byte 4 17
byte 4 41
byte 4 64
byte 4 12
byte 4 58
byte 4 64
byte 4 17
byte 4 78
byte 4 64
byte 4 18
byte 4 98
byte 4 64
byte 4 19
byte 4 120
byte 4 64
byte 4 18
byte 4 141
byte 4 64
byte 4 18
byte 4 204
byte 4 64
byte 4 16
byte 4 162
byte 4 64
byte 4 17
byte 4 182
byte 4 64
byte 4 18
byte 4 59
byte 4 181
byte 4 7
byte 4 35
byte 4 181
byte 4 7
byte 4 203
byte 4 152
byte 4 14
byte 4 56
byte 4 93
byte 4 14
byte 4 228
byte 4 152
byte 4 14
byte 4 177
byte 4 181
byte 4 18
byte 4 28
byte 4 122
byte 4 22
byte 4 5
byte 4 4
byte 4 18
byte 4 27
byte 4 4
byte 4 18
byte 4 48
byte 4 4
byte 4 18
byte 4 69
byte 4 4
byte 4 17
byte 4 90
byte 4 4
byte 4 13
byte 4 106
byte 4 4
byte 4 13
byte 4 121
byte 4 4
byte 4 18
byte 4 143
byte 4 4
byte 4 17
byte 4 164
byte 4 4
byte 4 8
byte 4 175
byte 4 4
byte 4 16
byte 4 195
byte 4 4
byte 4 18
byte 4 216
byte 4 4
byte 4 12
byte 4 230
byte 4 4
byte 4 23
byte 4 6
byte 4 34
byte 4 18
byte 4 27
byte 4 34
byte 4 18
byte 4 48
byte 4 34
byte 4 18
byte 4 68
byte 4 34
byte 4 18
byte 4 90
byte 4 34
byte 4 17
byte 4 110
byte 4 34
byte 4 18
byte 4 130
byte 4 34
byte 4 14
byte 4 146
byte 4 34
byte 4 18
byte 4 166
byte 4 34
byte 4 19
byte 4 185
byte 4 34
byte 4 29
byte 4 215
byte 4 34
byte 4 18
byte 4 234
byte 4 34
byte 4 18
byte 4 5
byte 4 64
byte 4 14
byte 4 60
byte 4 152
byte 4 7
byte 4 106
byte 4 151
byte 4 13
byte 4 83
byte 4 152
byte 4 7
byte 4 128
byte 4 122
byte 4 17
byte 4 4
byte 4 152
byte 4 21
byte 4 134
byte 4 181
byte 4 5
byte 4 5
byte 4 4
byte 4 18
byte 4 27
byte 4 4
byte 4 18
byte 4 48
byte 4 4
byte 4 18
byte 4 69
byte 4 4
byte 4 17
byte 4 90
byte 4 4
byte 4 13
byte 4 106
byte 4 4
byte 4 13
byte 4 121
byte 4 4
byte 4 18
byte 4 143
byte 4 4
byte 4 17
byte 4 164
byte 4 4
byte 4 8
byte 4 175
byte 4 4
byte 4 16
byte 4 195
byte 4 4
byte 4 18
byte 4 216
byte 4 4
byte 4 12
byte 4 230
byte 4 4
byte 4 23
byte 4 6
byte 4 34
byte 4 18
byte 4 27
byte 4 34
byte 4 18
byte 4 48
byte 4 34
byte 4 18
byte 4 68
byte 4 34
byte 4 18
byte 4 90
byte 4 34
byte 4 17
byte 4 110
byte 4 34
byte 4 18
byte 4 130
byte 4 34
byte 4 14
byte 4 146
byte 4 34
byte 4 18
byte 4 166
byte 4 34
byte 4 19
byte 4 185
byte 4 34
byte 4 29
byte 4 215
byte 4 34
byte 4 18
byte 4 234
byte 4 34
byte 4 18
byte 4 5
byte 4 64
byte 4 14
byte 4 153
byte 4 152
byte 4 13
byte 4 11
byte 4 181
byte 4 5
byte 4 180
byte 4 152
byte 4 13
byte 4 79
byte 4 93
byte 4 17
byte 4 0
byte 4 0
byte 4 -1
align 4
LABELV propMapB
byte 4 11
byte 4 12
byte 4 33
byte 4 49
byte 4 12
byte 4 31
byte 4 85
byte 4 12
byte 4 31
byte 4 120
byte 4 12
byte 4 30
byte 4 156
byte 4 12
byte 4 21
byte 4 183
byte 4 12
byte 4 21
byte 4 207
byte 4 12
byte 4 32
byte 4 13
byte 4 55
byte 4 30
byte 4 49
byte 4 55
byte 4 13
byte 4 66
byte 4 55
byte 4 29
byte 4 101
byte 4 55
byte 4 31
byte 4 135
byte 4 55
byte 4 21
byte 4 158
byte 4 55
byte 4 40
byte 4 204
byte 4 55
byte 4 32
byte 4 12
byte 4 97
byte 4 31
byte 4 48
byte 4 97
byte 4 31
byte 4 82
byte 4 97
byte 4 30
byte 4 118
byte 4 97
byte 4 30
byte 4 153
byte 4 97
byte 4 30
byte 4 185
byte 4 97
byte 4 25
byte 4 213
byte 4 97
byte 4 30
byte 4 11
byte 4 139
byte 4 32
byte 4 42
byte 4 139
byte 4 51
byte 4 93
byte 4 139
byte 4 32
byte 4 126
byte 4 139
byte 4 31
byte 4 158
byte 4 139
byte 4 25
code
proc UI_DrawBannerString2 52 36
line 326
;166:
;167:/*
;168:=================
;169:UI_DrawProportionalString2
;170:=================
;171:*/
;172:static int	propMap[128][3] = {
;173:{0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1},
;174:{0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1},
;175:
;176:{0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1},
;177:{0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1},
;178:
;179:{0, 0, PROP_SPACE_WIDTH},		// SPACE
;180:{11, 122, 7},	// !
;181:{154, 181, 14},	// "
;182:{55, 122, 17},	// #
;183:{79, 122, 18},	// $
;184:{101, 122, 23},	// %
;185:{153, 122, 18},	// &
;186:{9, 93, 7},		// '
;187:{207, 122, 8},	// (
;188:{230, 122, 9},	// )
;189:{177, 122, 18},	// *
;190:{30, 152, 18},	// +
;191:{85, 181, 7},	// ,
;192:{34, 93, 11},	// -
;193:{110, 181, 6},	// .
;194:{130, 152, 14},	// /
;195:
;196:{22, 64, 17},	// 0
;197:{41, 64, 12},	// 1
;198:{58, 64, 17},	// 2
;199:{78, 64, 18},	// 3
;200:{98, 64, 19},	// 4
;201:{120, 64, 18},	// 5
;202:{141, 64, 18},	// 6
;203:{204, 64, 16},	// 7
;204:{162, 64, 17},	// 8
;205:{182, 64, 18},	// 9
;206:{59, 181, 7},	// :
;207:{35,181, 7},	// ;
;208:{203, 152, 14},	// <
;209:{56, 93, 14},	// =
;210:{228, 152, 14},	// >
;211:{177, 181, 18},	// ?
;212:
;213:{28, 122, 22},	// @
;214:{5, 4, 18},		// A
;215:{27, 4, 18},	// B
;216:{48, 4, 18},	// C
;217:{69, 4, 17},	// D
;218:{90, 4, 13},	// E
;219:{106, 4, 13},	// F
;220:{121, 4, 18},	// G
;221:{143, 4, 17},	// H
;222:{164, 4, 8},	// I
;223:{175, 4, 16},	// J
;224:{195, 4, 18},	// K
;225:{216, 4, 12},	// L
;226:{230, 4, 23},	// M
;227:{6, 34, 18},	// N
;228:{27, 34, 18},	// O
;229:
;230:{48, 34, 18},	// P
;231:{68, 34, 18},	// Q
;232:{90, 34, 17},	// R
;233:{110, 34, 18},	// S
;234:{130, 34, 14},	// T
;235:{146, 34, 18},	// U
;236:{166, 34, 19},	// V
;237:{185, 34, 29},	// W
;238:{215, 34, 18},	// X
;239:{234, 34, 18},	// Y
;240:{5, 64, 14},	// Z
;241:{60, 152, 7},	// [
;242:{106, 151, 13},	// '\'
;243:{83, 152, 7},	// ]
;244:{128, 122, 17},	// ^
;245:{4, 152, 21},	// _
;246:
;247:{134, 181, 5},	// '
;248:{5, 4, 18},		// A
;249:{27, 4, 18},	// B
;250:{48, 4, 18},	// C
;251:{69, 4, 17},	// D
;252:{90, 4, 13},	// E
;253:{106, 4, 13},	// F
;254:{121, 4, 18},	// G
;255:{143, 4, 17},	// H
;256:{164, 4, 8},	// I
;257:{175, 4, 16},	// J
;258:{195, 4, 18},	// K
;259:{216, 4, 12},	// L
;260:{230, 4, 23},	// M
;261:{6, 34, 18},	// N
;262:{27, 34, 18},	// O
;263:
;264:{48, 34, 18},	// P
;265:{68, 34, 18},	// Q
;266:{90, 34, 17},	// R
;267:{110, 34, 18},	// S
;268:{130, 34, 14},	// T
;269:{146, 34, 18},	// U
;270:{166, 34, 19},	// V
;271:{185, 34, 29},	// W
;272:{215, 34, 18},	// X
;273:{234, 34, 18},	// Y
;274:{5, 64, 14},	// Z
;275:{153, 152, 13},	// {
;276:{11, 181, 5},	// |
;277:{180, 152, 13},	// }
;278:{79, 93, 17},	// ~
;279:{0, 0, -1}		// DEL
;280:};
;281:
;282:static int propMapB[26][3] = {
;283:{11, 12, 33},
;284:{49, 12, 31},
;285:{85, 12, 31},
;286:{120, 12, 30},
;287:{156, 12, 21},
;288:{183, 12, 21},
;289:{207, 12, 32},
;290:
;291:{13, 55, 30},
;292:{49, 55, 13},
;293:{66, 55, 29},
;294:{101, 55, 31},
;295:{135, 55, 21},
;296:{158, 55, 40},
;297:{204, 55, 32},
;298:
;299:{12, 97, 31},
;300:{48, 97, 31},
;301:{82, 97, 30},
;302:{118, 97, 30},
;303:{153, 97, 30},
;304:{185, 97, 25},
;305:{213, 97, 30},
;306:
;307:{11, 139, 32},
;308:{42, 139, 51},
;309:{93, 139, 32},
;310:{126, 139, 31},
;311:{158, 139, 25},
;312:};
;313:
;314:#define PROPB_GAP_WIDTH		4
;315:#define PROPB_SPACE_WIDTH	12
;316:#define PROPB_HEIGHT		36
;317:
;318:// bk001205 - code below duplicated in cgame/cg_drawtools.c
;319:// bk001205 - FIXME: does this belong in ui_shared.c?
;320:/*
;321:=================
;322:UI_DrawBannerString
;323:=================
;324:*/
;325:static void UI_DrawBannerString2( int x, int y, const char* str, vec4_t color )
;326:{
line 339
;327:	const char* s;
;328:	unsigned char	ch; // bk001204 - unsigned
;329:	float	ax;
;330:	float	ay;
;331:	float	aw;
;332:	float	ah;
;333:	float	frow;
;334:	float	fcol;
;335:	float	fwidth;
;336:	float	fheight;
;337:
;338:	// draw the colored text
;339:	trap_R_SetColor( color );
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 346
;340:	
;341:	// JUHOX: apply the new scaling
;342:#if 0
;343:	ax = x * uis.scale + uis.bias;
;344:	ay = y * uis.scale;
;345:#else
;346:	ax = x * uis.scaleX;
ADDRLP4 8
ADDRFP4 0
INDIRI4
CVIF4 4
ADDRGP4 uis+11476
INDIRF4
MULF4
ASGNF4
line 347
;347:	ay = y * uis.scaleY;
ADDRLP4 36
ADDRFP4 4
INDIRI4
CVIF4 4
ADDRGP4 uis+11480
INDIRF4
MULF4
ASGNF4
line 350
;348:#endif
;349:
;350:	s = str;
ADDRLP4 4
ADDRFP4 8
INDIRP4
ASGNP4
ADDRGP4 $167
JUMPV
LABELV $166
line 352
;351:	while ( *s )
;352:	{
line 353
;353:		ch = *s & 127;
ADDRLP4 0
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 127
BANDI4
CVIU4 4
CVUU1 4
ASGNU1
line 354
;354:		if ( ch == ' ' ) {
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 32
NEI4 $169
line 359
;355:			// JUHOX: apply the new scaling
;356:#if 0
;357:			ax += ((float)PROPB_SPACE_WIDTH + (float)PROPB_GAP_WIDTH)* uis.scale;
;358:#else
;359:			ax += ((float)PROPB_SPACE_WIDTH + (float)PROPB_GAP_WIDTH)* uis.scaleX;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRGP4 uis+11476
INDIRF4
CNSTF4 1098907648
MULF4
ADDF4
ASGNF4
line 361
;360:#endif
;361:		}
ADDRGP4 $170
JUMPV
LABELV $169
line 362
;362:		else if ( ch >= 'A' && ch <= 'Z' ) {
ADDRLP4 40
ADDRLP4 0
INDIRU1
CVUI4 1
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 65
LTI4 $172
ADDRLP4 40
INDIRI4
CNSTI4 90
GTI4 $172
line 363
;363:			ch -= 'A';
ADDRLP4 0
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 65
SUBI4
CVIU4 4
CVUU1 4
ASGNU1
line 364
;364:			fcol = (float)propMapB[ch][0] / 256.0f;
ADDRLP4 20
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 12
MULI4
ADDRGP4 propMapB
ADDP4
INDIRI4
CVIF4 4
CNSTF4 998244352
MULF4
ASGNF4
line 365
;365:			frow = (float)propMapB[ch][1] / 256.0f;
ADDRLP4 16
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 12
MULI4
ADDRGP4 propMapB+4
ADDP4
INDIRI4
CVIF4 4
CNSTF4 998244352
MULF4
ASGNF4
line 366
;366:			fwidth = (float)propMapB[ch][2] / 256.0f;
ADDRLP4 28
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 12
MULI4
ADDRGP4 propMapB+8
ADDP4
INDIRI4
CVIF4 4
CNSTF4 998244352
MULF4
ASGNF4
line 367
;367:			fheight = (float)PROPB_HEIGHT / 256.0f;
ADDRLP4 32
CNSTF4 1041235968
ASGNF4
line 373
;368:			// JUHOX: apply the new scaling
;369:#if 0
;370:			aw = (float)propMapB[ch][2] * uis.scale;
;371:			ah = (float)PROPB_HEIGHT * uis.scale;
;372:#else
;373:			aw = (float)propMapB[ch][2] * uis.scaleX;
ADDRLP4 12
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 12
MULI4
ADDRGP4 propMapB+8
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 uis+11476
INDIRF4
MULF4
ASGNF4
line 374
;374:			ah = (float)PROPB_HEIGHT * uis.scaleY;
ADDRLP4 24
ADDRGP4 uis+11480
INDIRF4
CNSTF4 1108344832
MULF4
ASGNF4
line 376
;375:#endif
;376:			trap_R_DrawStretchPic( ax, ay, aw, ah, fcol, frow, fcol+fwidth, frow+fheight, uis.charsetPropB );
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ADDRLP4 28
INDIRF4
ADDF4
ARGF4
ADDRLP4 16
INDIRF4
ADDRLP4 32
INDIRF4
ADDF4
ARGF4
ADDRGP4 uis+11444
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 381
;377:			// JUHOX: apply the new scaling
;378:#if 0
;379:			ax += (aw + (float)PROPB_GAP_WIDTH * uis.scale);
;380:#else
;381:			ax += (aw + (float)PROPB_GAP_WIDTH * uis.scaleX);
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRLP4 12
INDIRF4
ADDRGP4 uis+11476
INDIRF4
CNSTF4 1082130432
MULF4
ADDF4
ADDF4
ASGNF4
line 383
;382:#endif
;383:		}
LABELV $172
LABELV $170
line 384
;384:		s++;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 385
;385:	}
LABELV $167
line 351
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $166
line 387
;386:
;387:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 388
;388:}
LABELV $163
endproc UI_DrawBannerString2 52 36
export UI_DrawBannerString
proc UI_DrawBannerString 40 16
line 390
;389:
;390:void UI_DrawBannerString( int x, int y, const char* str, int style, vec4_t color ) {
line 397
;391:	const char *	s;
;392:	int				ch;
;393:	int				width;
;394:	vec4_t			drawcolor;
;395:
;396:	// find the width of the drawn text
;397:	s = str;
ADDRLP4 4
ADDRFP4 8
INDIRP4
ASGNP4
line 398
;398:	width = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $183
JUMPV
LABELV $182
line 399
;399:	while ( *s ) {
line 400
;400:		ch = *s;
ADDRLP4 0
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 401
;401:		if ( ch == ' ' ) {
ADDRLP4 0
INDIRI4
CNSTI4 32
NEI4 $185
line 402
;402:			width += PROPB_SPACE_WIDTH;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 12
ADDI4
ASGNI4
line 403
;403:		}
ADDRGP4 $186
JUMPV
LABELV $185
line 404
;404:		else if ( ch >= 'A' && ch <= 'Z' ) {
ADDRLP4 0
INDIRI4
CNSTI4 65
LTI4 $187
ADDRLP4 0
INDIRI4
CNSTI4 90
GTI4 $187
line 405
;405:			width += propMapB[ch - 'A'][2] + PROPB_GAP_WIDTH;
ADDRLP4 8
ADDRLP4 8
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 propMapB-780+8
ADDP4
INDIRI4
CNSTI4 4
ADDI4
ADDI4
ASGNI4
line 406
;406:		}
LABELV $187
LABELV $186
line 407
;407:		s++;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 408
;408:	}
LABELV $183
line 399
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $182
line 409
;409:	width -= PROPB_GAP_WIDTH;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 4
SUBI4
ASGNI4
line 411
;410:
;411:	switch( style & UI_FORMATMASK ) {
ADDRLP4 28
ADDRFP4 12
INDIRI4
CNSTI4 7
BANDI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $192
ADDRLP4 28
INDIRI4
CNSTI4 1
EQI4 $194
ADDRLP4 28
INDIRI4
CNSTI4 2
EQI4 $195
ADDRGP4 $192
JUMPV
LABELV $194
line 413
;412:		case UI_CENTER:
;413:			x -= width / 2;
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRLP4 8
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ASGNI4
line 414
;414:			break;
ADDRGP4 $192
JUMPV
LABELV $195
line 417
;415:
;416:		case UI_RIGHT:
;417:			x -= width;
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ASGNI4
line 418
;418:			break;
line 422
;419:
;420:		case UI_LEFT:
;421:		default:
;422:			break;
LABELV $192
line 425
;423:	}
;424:
;425:	if ( style & UI_DROPSHADOW ) {
ADDRFP4 12
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $197
line 426
;426:		drawcolor[0] = drawcolor[1] = drawcolor[2] = 0;
ADDRLP4 36
CNSTF4 0
ASGNF4
ADDRLP4 12+8
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 12
ADDRLP4 36
INDIRF4
ASGNF4
line 427
;427:		drawcolor[3] = color[3];
ADDRLP4 12+12
ADDRFP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 428
;428:		UI_DrawBannerString2( x+2, y+2, str, drawcolor );
ADDRFP4 0
INDIRI4
CNSTI4 2
ADDI4
ARGI4
ADDRFP4 4
INDIRI4
CNSTI4 2
ADDI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 UI_DrawBannerString2
CALLV
pop
line 429
;429:	}
LABELV $197
line 431
;430:
;431:	UI_DrawBannerString2( x, y, str, color );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 UI_DrawBannerString2
CALLV
pop
line 432
;432:}
LABELV $181
endproc UI_DrawBannerString 40 16
export UI_ProportionalStringWidth
proc UI_ProportionalStringWidth 16 0
line 435
;433:
;434:
;435:int UI_ProportionalStringWidth( const char* str ) {
line 441
;436:	const char *	s;
;437:	int				ch;
;438:	int				charWidth;
;439:	int				width;
;440:
;441:	s = str;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 442
;442:	width = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 $204
JUMPV
LABELV $203
line 443
;443:	while ( *s ) {
line 444
;444:		ch = *s & 127;
ADDRLP4 8
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 127
BANDI4
ASGNI4
line 445
;445:		charWidth = propMap[ch][2];
ADDRLP4 4
ADDRLP4 8
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 propMap+8
ADDP4
INDIRI4
ASGNI4
line 446
;446:		if ( charWidth != -1 ) {
ADDRLP4 4
INDIRI4
CNSTI4 -1
EQI4 $207
line 447
;447:			width += charWidth;
ADDRLP4 12
ADDRLP4 12
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 448
;448:			width += PROP_GAP_WIDTH;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 3
ADDI4
ASGNI4
line 449
;449:		}
LABELV $207
line 450
;450:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 451
;451:	}
LABELV $204
line 443
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $203
line 453
;452:
;453:	width -= PROP_GAP_WIDTH;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 3
SUBI4
ASGNI4
line 454
;454:	return width;
ADDRLP4 12
INDIRI4
RETI4
LABELV $202
endproc UI_ProportionalStringWidth 16 0
proc UI_DrawProportionalString2 48 36
line 458
;455:}
;456:
;457:static void UI_DrawProportionalString2( int x, int y, const char* str, vec4_t color, float sizeScale, qhandle_t charset )
;458:{
line 463
;459:	const char* s;
;460:	unsigned char	ch; // bk001204 - unsigned
;461:	float	ax;
;462:	float	ay;
;463:	float	aw = 0; // bk001204 - init
ADDRLP4 8
CNSTF4 0
ASGNF4
line 471
;464:	float	ah;
;465:	float	frow;
;466:	float	fcol;
;467:	float	fwidth;
;468:	float	fheight;
;469:
;470:	// draw the colored text
;471:	trap_R_SetColor( color );
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 478
;472:
;473:	// JUHOX: apply the new scaling
;474:#if 0	
;475:	ax = x * uis.scale + uis.bias;
;476:	ay = y * uis.scale;
;477:#else
;478:	ax = x * uis.scaleX;
ADDRLP4 12
ADDRFP4 0
INDIRI4
CVIF4 4
ADDRGP4 uis+11476
INDIRF4
MULF4
ASGNF4
line 479
;479:	ay = y * uis.scaleY;
ADDRLP4 36
ADDRFP4 4
INDIRI4
CVIF4 4
ADDRGP4 uis+11480
INDIRF4
MULF4
ASGNF4
line 482
;480:#endif
;481:
;482:	s = str;
ADDRLP4 4
ADDRFP4 8
INDIRP4
ASGNP4
ADDRGP4 $213
JUMPV
LABELV $212
line 484
;483:	while ( *s )
;484:	{
line 485
;485:		ch = *s & 127;
ADDRLP4 0
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 127
BANDI4
CVIU4 4
CVUU1 4
ASGNU1
line 486
;486:		if ( ch == ' ' ) {
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 32
NEI4 $215
line 491
;487:			// JUHOX: apply the new scaling
;488:#if 0
;489:			aw = (float)PROP_SPACE_WIDTH * uis.scale * sizeScale;
;490:#else
;491:			aw = (float)PROP_SPACE_WIDTH * uis.scaleX * sizeScale;
ADDRLP4 8
ADDRGP4 uis+11476
INDIRF4
CNSTF4 1090519040
MULF4
ADDRFP4 16
INDIRF4
MULF4
ASGNF4
line 493
;492:#endif
;493:		}
ADDRGP4 $216
JUMPV
LABELV $215
line 494
;494:		else if ( propMap[ch][2] != -1 ) {
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 12
MULI4
ADDRGP4 propMap+8
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $218
line 495
;495:			fcol = (float)propMap[ch][0] / 256.0f;
ADDRLP4 20
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 12
MULI4
ADDRGP4 propMap
ADDP4
INDIRI4
CVIF4 4
CNSTF4 998244352
MULF4
ASGNF4
line 496
;496:			frow = (float)propMap[ch][1] / 256.0f;
ADDRLP4 16
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 12
MULI4
ADDRGP4 propMap+4
ADDP4
INDIRI4
CVIF4 4
CNSTF4 998244352
MULF4
ASGNF4
line 497
;497:			fwidth = (float)propMap[ch][2] / 256.0f;
ADDRLP4 28
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 12
MULI4
ADDRGP4 propMap+8
ADDP4
INDIRI4
CVIF4 4
CNSTF4 998244352
MULF4
ASGNF4
line 498
;498:			fheight = (float)PROP_HEIGHT / 256.0f;
ADDRLP4 32
CNSTF4 1037565952
ASGNF4
line 504
;499:			// JUHOX: apply the new scaling
;500:#if 0
;501:			aw = (float)propMap[ch][2] * uis.scale * sizeScale;
;502:			ah = (float)PROP_HEIGHT * uis.scale * sizeScale;
;503:#else
;504:			aw = (float)propMap[ch][2] * uis.scaleX * sizeScale;
ADDRLP4 8
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 12
MULI4
ADDRGP4 propMap+8
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 uis+11476
INDIRF4
MULF4
ADDRFP4 16
INDIRF4
MULF4
ASGNF4
line 505
;505:			ah = (float)PROP_HEIGHT * uis.scaleY * sizeScale;
ADDRLP4 24
ADDRGP4 uis+11480
INDIRF4
CNSTF4 1104674816
MULF4
ADDRFP4 16
INDIRF4
MULF4
ASGNF4
line 507
;506:#endif
;507:			trap_R_DrawStretchPic( ax, ay, aw, ah, fcol, frow, fcol+fwidth, frow+fheight, charset );
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ADDRLP4 28
INDIRF4
ADDF4
ARGF4
ADDRLP4 16
INDIRF4
ADDRLP4 32
INDIRF4
ADDF4
ARGF4
ADDRFP4 20
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 508
;508:		}
LABELV $218
LABELV $216
line 514
;509:
;510:		// JUHOX: apply the new scaling
;511:#if 0
;512:		ax += (aw + (float)PROP_GAP_WIDTH * uis.scale * sizeScale);
;513:#else
;514:		ax += (aw + (float)PROP_GAP_WIDTH * uis.scaleX * sizeScale);
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
ADDRGP4 uis+11476
INDIRF4
CNSTF4 1077936128
MULF4
ADDRFP4 16
INDIRF4
MULF4
ADDF4
ADDF4
ASGNF4
line 516
;515:#endif
;516:		s++;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 517
;517:	}
LABELV $213
line 483
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $212
line 519
;518:
;519:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 520
;520:}
LABELV $209
endproc UI_DrawProportionalString2 48 36
export UI_ProportionalSizeScale
proc UI_ProportionalSizeScale 0 0
line 527
;521:
;522:/*
;523:=================
;524:UI_ProportionalSizeScale
;525:=================
;526:*/
;527:float UI_ProportionalSizeScale( int style ) {
line 528
;528:	if(  style & UI_SMALLFONT ) {
ADDRFP4 0
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $228
line 529
;529:		return PROP_SMALL_SIZE_SCALE;
CNSTF4 1061158912
RETF4
ADDRGP4 $227
JUMPV
LABELV $228
line 532
;530:	}
;531:
;532:	return 1.00;
CNSTF4 1065353216
RETF4
LABELV $227
endproc UI_ProportionalSizeScale 0 0
export UI_DrawProportionalString
proc UI_DrawProportionalString 44 24
line 541
;533:}
;534:
;535:
;536:/*
;537:=================
;538:UI_DrawProportionalString
;539:=================
;540:*/
;541:void UI_DrawProportionalString( int x, int y, const char* str, int style, vec4_t color ) {
line 546
;542:	vec4_t	drawcolor;
;543:	int		width;
;544:	float	sizeScale;
;545:
;546:	sizeScale = UI_ProportionalSizeScale( style );
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 UI_ProportionalSizeScale
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 24
INDIRF4
ASGNF4
line 548
;547:
;548:	switch( style & UI_FORMATMASK ) {
ADDRLP4 28
ADDRFP4 12
INDIRI4
CNSTI4 7
BANDI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $232
ADDRLP4 28
INDIRI4
CNSTI4 1
EQI4 $234
ADDRLP4 28
INDIRI4
CNSTI4 2
EQI4 $235
ADDRGP4 $232
JUMPV
LABELV $234
line 550
;549:		case UI_CENTER:
;550:			width = UI_ProportionalStringWidth( str ) * sizeScale;
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 UI_ProportionalStringWidth
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 36
INDIRI4
CVIF4 4
ADDRLP4 16
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 551
;551:			x -= width / 2;
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRLP4 20
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ASGNI4
line 552
;552:			break;
ADDRGP4 $232
JUMPV
LABELV $235
line 555
;553:
;554:		case UI_RIGHT:
;555:			width = UI_ProportionalStringWidth( str ) * sizeScale;
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 UI_ProportionalStringWidth
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 40
INDIRI4
CVIF4 4
ADDRLP4 16
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 556
;556:			x -= width;
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRLP4 20
INDIRI4
SUBI4
ASGNI4
line 557
;557:			break;
line 561
;558:
;559:		case UI_LEFT:
;560:		default:
;561:			break;
LABELV $232
line 564
;562:	}
;563:
;564:	if ( style & UI_DROPSHADOW ) {
ADDRFP4 12
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $237
line 565
;565:		drawcolor[0] = drawcolor[1] = drawcolor[2] = 0;
ADDRLP4 36
CNSTF4 0
ASGNF4
ADDRLP4 0+8
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 36
INDIRF4
ASGNF4
line 566
;566:		drawcolor[3] = color[3];
ADDRLP4 0+12
ADDRFP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 567
;567:		UI_DrawProportionalString2( x+2, y+2, str, drawcolor, sizeScale, uis.charsetProp );
ADDRFP4 0
INDIRI4
CNSTI4 2
ADDI4
ARGI4
ADDRFP4 4
INDIRI4
CNSTI4 2
ADDI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 16
INDIRF4
ARGF4
ADDRGP4 uis+11436
INDIRI4
ARGI4
ADDRGP4 UI_DrawProportionalString2
CALLV
pop
line 568
;568:	}
LABELV $237
line 570
;569:
;570:	if ( style & UI_INVERSE ) {
ADDRFP4 12
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $243
line 571
;571:		drawcolor[0] = color[0] * 0.7;
ADDRLP4 0
ADDRFP4 16
INDIRP4
INDIRF4
CNSTF4 1060320051
MULF4
ASGNF4
line 572
;572:		drawcolor[1] = color[1] * 0.7;
ADDRLP4 0+4
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1060320051
MULF4
ASGNF4
line 573
;573:		drawcolor[2] = color[2] * 0.7;
ADDRLP4 0+8
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1060320051
MULF4
ASGNF4
line 574
;574:		drawcolor[3] = color[3];
ADDRLP4 0+12
ADDRFP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 575
;575:		UI_DrawProportionalString2( x, y, str, drawcolor, sizeScale, uis.charsetProp );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 16
INDIRF4
ARGF4
ADDRGP4 uis+11436
INDIRI4
ARGI4
ADDRGP4 UI_DrawProportionalString2
CALLV
pop
line 576
;576:		return;
ADDRGP4 $230
JUMPV
LABELV $243
line 579
;577:	}
;578:
;579:	if ( style & UI_PULSE ) {
ADDRFP4 12
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $249
line 580
;580:		drawcolor[0] = color[0] * 0.7;
ADDRLP4 0
ADDRFP4 16
INDIRP4
INDIRF4
CNSTF4 1060320051
MULF4
ASGNF4
line 581
;581:		drawcolor[1] = color[1] * 0.7;
ADDRLP4 0+4
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1060320051
MULF4
ASGNF4
line 582
;582:		drawcolor[2] = color[2] * 0.7;
ADDRLP4 0+8
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1060320051
MULF4
ASGNF4
line 583
;583:		drawcolor[3] = color[3];
ADDRLP4 0+12
ADDRFP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 584
;584:		UI_DrawProportionalString2( x, y, str, color, sizeScale, uis.charsetProp );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 16
INDIRF4
ARGF4
ADDRGP4 uis+11436
INDIRI4
ARGI4
ADDRGP4 UI_DrawProportionalString2
CALLV
pop
line 586
;585:
;586:		drawcolor[0] = color[0];
ADDRLP4 0
ADDRFP4 16
INDIRP4
INDIRF4
ASGNF4
line 587
;587:		drawcolor[1] = color[1];
ADDRLP4 0+4
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 588
;588:		drawcolor[2] = color[2];
ADDRLP4 0+8
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ASGNF4
line 589
;589:		drawcolor[3] = 0.5 + 0.5 * sin( uis.realtime / PULSE_DIVISOR );
ADDRGP4 uis+4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 36
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 0+12
ADDRLP4 36
INDIRF4
CNSTF4 1056964608
MULF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 590
;590:		UI_DrawProportionalString2( x, y, str, drawcolor, sizeScale, uis.charsetPropGlow );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 16
INDIRF4
ARGF4
ADDRGP4 uis+11440
INDIRI4
ARGI4
ADDRGP4 UI_DrawProportionalString2
CALLV
pop
line 591
;591:		return;
ADDRGP4 $230
JUMPV
LABELV $249
line 594
;592:	}
;593:
;594:	UI_DrawProportionalString2( x, y, str, color, sizeScale, uis.charsetProp );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 16
INDIRF4
ARGF4
ADDRGP4 uis+11436
INDIRI4
ARGI4
ADDRGP4 UI_DrawProportionalString2
CALLV
pop
line 595
;595:}
LABELV $230
endproc UI_DrawProportionalString 44 24
export UI_DrawProportionalString_AutoWrapped
proc UI_DrawProportionalString_AutoWrapped 1064 20
line 602
;596:
;597:/*
;598:=================
;599:UI_DrawProportionalString_Wrapped
;600:=================
;601:*/
;602:void UI_DrawProportionalString_AutoWrapped( int x, int y, int xmax, int ystep, const char* str, int style, vec4_t color ) {
line 609
;603:	int width;
;604:	char *s1,*s2,*s3;
;605:	char c_bcp;
;606:	char buf[1024];
;607:	float   sizeScale;
;608:
;609:	if (!str || str[0]=='\0')
ADDRLP4 1048
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 1048
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $264
ADDRLP4 1048
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $262
LABELV $264
line 610
;610:		return;
ADDRGP4 $261
JUMPV
LABELV $262
line 612
;611:	
;612:	sizeScale = UI_ProportionalSizeScale( style );
ADDRFP4 20
INDIRI4
ARGI4
ADDRLP4 1052
ADDRGP4 UI_ProportionalSizeScale
CALLF4
ASGNF4
ADDRLP4 20
ADDRLP4 1052
INDIRF4
ASGNF4
line 614
;613:	
;614:	Q_strncpyz(buf, str, sizeof(buf));
ADDRLP4 24
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 615
;615:	s1 = s2 = s3 = buf;
ADDRLP4 0
ADDRLP4 24
ASGNP4
ADDRLP4 4
ADDRLP4 24
ASGNP4
ADDRLP4 12
ADDRLP4 24
ASGNP4
ADDRGP4 $266
JUMPV
LABELV $265
line 617
;616:
;617:	while (1) {
LABELV $268
line 618
;618:		do {
line 619
;619:			s3++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 620
;620:		} while (*s3!=' ' && *s3!='\0');
LABELV $269
ADDRLP4 1056
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 32
EQI4 $271
ADDRLP4 1056
INDIRI4
CNSTI4 0
NEI4 $268
LABELV $271
line 621
;621:		c_bcp = *s3;
ADDRLP4 8
ADDRLP4 0
INDIRP4
INDIRI1
ASGNI1
line 622
;622:		*s3 = '\0';
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 623
;623:		width = UI_ProportionalStringWidth(s1) * sizeScale;
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 1060
ADDRGP4 UI_ProportionalStringWidth
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 1060
INDIRI4
CVIF4 4
ADDRLP4 20
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 624
;624:		*s3 = c_bcp;
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI1
ASGNI1
line 625
;625:		if (width > xmax) {
ADDRLP4 16
INDIRI4
ADDRFP4 8
INDIRI4
LEI4 $272
line 626
;626:			if (s1==s2)
ADDRLP4 12
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRP4
CVPU4 4
NEU4 $274
line 627
;627:			{
line 629
;628:				// fuck, don't have a clean cut, we'll overflow
;629:				s2 = s3;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
line 630
;630:			}
LABELV $274
line 631
;631:			*s2 = '\0';
ADDRLP4 4
INDIRP4
CNSTI1 0
ASGNI1
line 632
;632:			UI_DrawProportionalString(x, y, s1, style, color);
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
ADDRFP4 20
INDIRI4
ARGI4
ADDRFP4 24
INDIRP4
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 633
;633:			y += ystep;
ADDRFP4 4
ADDRFP4 4
INDIRI4
ADDRFP4 12
INDIRI4
ADDI4
ASGNI4
line 634
;634:			if (c_bcp == '\0')
ADDRLP4 8
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $276
line 635
;635:      {
line 640
;636:        // that was the last word
;637:        // we could start a new loop, but that wouldn't be much use
;638:        // even if the word is too long, we would overflow it (see above)
;639:        // so just print it now if needed
;640:        s2++;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 641
;641:        if (*s2 != '\0') // if we are printing an overflowing line we have s2 == s3
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $267
line 642
;642:          UI_DrawProportionalString(x, y, s2, style, color);
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 20
INDIRI4
ARGI4
ADDRFP4 24
INDIRP4
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 643
;643:				break; 
ADDRGP4 $267
JUMPV
LABELV $276
line 645
;644:      }
;645:			s2++;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 646
;646:			s1 = s2;
ADDRLP4 12
ADDRLP4 4
INDIRP4
ASGNP4
line 647
;647:			s3 = s2;
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 648
;648:		}
ADDRGP4 $273
JUMPV
LABELV $272
line 650
;649:		else
;650:		{
line 651
;651:			s2 = s3;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
line 652
;652:			if (c_bcp == '\0') // we reached the end
ADDRLP4 8
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $280
line 653
;653:			{
line 654
;654:				UI_DrawProportionalString(x, y, s1, style, color);
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
ADDRFP4 20
INDIRI4
ARGI4
ADDRFP4 24
INDIRP4
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 655
;655:				break;
ADDRGP4 $267
JUMPV
LABELV $280
line 657
;656:			}
;657:		}
LABELV $273
line 658
;658:	}
LABELV $266
line 617
ADDRGP4 $265
JUMPV
LABELV $267
line 659
;659:}
LABELV $261
endproc UI_DrawProportionalString_AutoWrapped 1064 20
proc UI_DrawString2 80 36
line 667
;660:
;661:/*
;662:=================
;663:UI_DrawString2
;664:=================
;665:*/
;666:static void UI_DrawString2( int x, int y, const char* str, vec4_t color, int charw, int charh )
;667:{
line 670
;668:	const char* s;
;669:	char	ch;
;670:	int forceColor = qfalse; //APSFIXME;
ADDRLP4 40
CNSTI4 0
ASGNI4
line 679
;671:	vec4_t	tempcolor;
;672:	float	ax;
;673:	float	ay;
;674:	float	aw;
;675:	float	ah;
;676:	float	frow;
;677:	float	fcol;
;678:
;679:	if (y < -charh)
ADDRFP4 4
INDIRI4
ADDRFP4 20
INDIRI4
NEGI4
GEI4 $283
line 681
;680:		// offscreen
;681:		return;
ADDRGP4 $282
JUMPV
LABELV $283
line 684
;682:
;683:	// draw the colored text
;684:	trap_R_SetColor( color );
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 693
;685:
;686:	// JUHOX: apply the new scaling
;687:#if 0	
;688:	ax = x * uis.scale + uis.bias;
;689:	ay = y * uis.scale;
;690:	aw = charw * uis.scale;
;691:	ah = charh * uis.scale;
;692:#else
;693:	ax = x * uis.scaleX;
ADDRLP4 8
ADDRFP4 0
INDIRI4
CVIF4 4
ADDRGP4 uis+11476
INDIRF4
MULF4
ASGNF4
line 694
;694:	ay = y * uis.scaleY;
ADDRLP4 44
ADDRFP4 4
INDIRI4
CVIF4 4
ADDRGP4 uis+11480
INDIRF4
MULF4
ASGNF4
line 695
;695:	aw = charw * uis.scaleX;
ADDRLP4 12
ADDRFP4 16
INDIRI4
CVIF4 4
ADDRGP4 uis+11476
INDIRF4
MULF4
ASGNF4
line 696
;696:	ah = charh * uis.scaleY;
ADDRLP4 48
ADDRFP4 20
INDIRI4
CVIF4 4
ADDRGP4 uis+11480
INDIRF4
MULF4
ASGNF4
line 699
;697:#endif
;698:
;699:	s = str;
ADDRLP4 0
ADDRFP4 8
INDIRP4
ASGNP4
ADDRGP4 $290
JUMPV
LABELV $289
line 701
;700:	while ( *s )
;701:	{
line 702
;702:		if ( Q_IsColorString( s ) )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $292
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $292
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $292
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 94
EQI4 $292
line 703
;703:		{
line 704
;704:			if ( !forceColor )
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $294
line 705
;705:			{
line 706
;706:				memcpy( tempcolor, g_color_table[ColorIndex(s[1])], sizeof( tempcolor ) );
ADDRLP4 24
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 48
SUBI4
CNSTI4 7
BANDI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 707
;707:				tempcolor[3] = color[3];
ADDRLP4 24+12
ADDRFP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 708
;708:				trap_R_SetColor( tempcolor );
ADDRLP4 24
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 709
;709:			}
LABELV $294
line 710
;710:			s += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 711
;711:			continue;
ADDRGP4 $290
JUMPV
LABELV $292
line 714
;712:		}
;713:
;714:		ch = *s & 255;
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 255
BANDI4
CVII1 4
ASGNI1
line 715
;715:		if (ch != ' ')
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 32
EQI4 $297
line 716
;716:		{
line 726
;717:			// JUHOX: we've now more than one charsetShader
;718:#if 0
;719:			frow = (ch>>4)*0.0625;
;720:			fcol = (ch&15)*0.0625;
;721:			trap_R_DrawStretchPic( ax, ay, aw, ah, fcol, frow, fcol + 0.0625, frow + 0.0625, uis.charset );
;722:#else
;723:			qhandle_t charset;
;724:			int col, row;
;725:
;726:			charset = uis.charsetShaders[((ch&8)>>3) + ((ch&192)>>5)];
ADDRLP4 68
ADDRLP4 4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 56
ADDRLP4 68
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 3
RSHI4
ADDRLP4 68
INDIRI4
CNSTI4 192
BANDI4
CNSTI4 5
RSHI4
ADDI4
CNSTI4 2
LSHI4
ADDRGP4 uis+11404
ADDP4
INDIRI4
ASGNI4
line 728
;727:
;728:			col = ch & 7;
ADDRLP4 60
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 7
BANDI4
ASGNI4
line 729
;729:			row = (ch & 48) >> 4;
ADDRLP4 64
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 48
BANDI4
CNSTI4 4
RSHI4
ASGNI4
line 731
;730:
;731:			fcol = col * 0.125 + 1.0/168.0;
ADDRLP4 20
ADDRLP4 60
INDIRI4
CVIF4 4
CNSTF4 1040187392
MULF4
CNSTF4 1002638385
ADDF4
ASGNF4
line 732
;732:			frow = row * 0.25 + 1.0/192.0;
ADDRLP4 16
ADDRLP4 64
INDIRI4
CVIF4 4
CNSTF4 1048576000
MULF4
CNSTF4 1001040555
ADDF4
ASGNF4
line 734
;733:
;734:			trap_R_DrawStretchPic(
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 44
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
CNSTF4 1040187392
ADDF4
CNSTF4 1011026993
SUBF4
ARGF4
ADDRLP4 16
INDIRF4
CNSTF4 1048576000
ADDF4
CNSTF4 1009429163
SUBF4
ARGF4
ADDRLP4 56
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 740
;735:				ax, ay, aw, ah,
;736:				fcol, frow, fcol+0.125-(2.0/168.0), frow+0.25-(2.0/192.0),
;737:				charset
;738:			);
;739:#endif
;740:		}
LABELV $297
line 742
;741:
;742:		ax += aw;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ASGNF4
line 743
;743:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 744
;744:	}
LABELV $290
line 700
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $289
line 746
;745:
;746:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 747
;747:}
LABELV $282
endproc UI_DrawString2 80 36
export UI_DrawStrlen
proc UI_DrawStrlen 12 0
line 757
;748:
;749:/*
;750:=================
;751:JUHOX: UI_DrawStrlen
;752:
;753:Returns character count, skiping color escape codes
;754:Exact copy of CG_DrawStrlen()
;755:=================
;756:*/
;757:int UI_DrawStrlen(const char *str) {
line 758
;758:	const char *s = str;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 759
;759:	int count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $302
JUMPV
LABELV $301
line 761
;760:
;761:	while (*s) {
line 762
;762:		if (Q_IsColorString(s)) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $304
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $304
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $304
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 94
EQI4 $304
line 763
;763:			s += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 764
;764:		} else {
ADDRGP4 $305
JUMPV
LABELV $304
line 765
;765:			count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 766
;766:			s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 767
;767:		}
LABELV $305
line 768
;768:	}
LABELV $302
line 761
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $301
line 770
;769:
;770:	return count;
ADDRLP4 4
INDIRI4
RETI4
LABELV $300
endproc UI_DrawStrlen 12 0
export UI_DrawString
proc UI_DrawString 80 24
line 779
;771:}
;772:
;773:/*
;774:=================
;775:UI_DrawString
;776:=================
;777:*/
;778:void UI_DrawString( int x, int y, const char* str, int style, vec4_t color )
;779:{
line 788
;780:	int		len;
;781:	int		charw;
;782:	int		charh;
;783:	vec4_t	newcolor;
;784:	vec4_t	lowlight;
;785:	float	*drawcolor;
;786:	vec4_t	dropcolor;
;787:
;788:	if( !str ) {
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $307
line 789
;789:		return;
ADDRGP4 $306
JUMPV
LABELV $307
line 792
;790:	}
;791:
;792:	if ((style & UI_BLINK) && ((uis.realtime/BLINK_DIVISOR) & 1))
ADDRFP4 12
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $309
ADDRGP4 uis+4
INDIRI4
CNSTI4 200
DIVI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $309
line 793
;793:		return;
ADDRGP4 $306
JUMPV
LABELV $309
line 795
;794:
;795:	if (style & UI_SMALLFONT)
ADDRFP4 12
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $312
line 796
;796:	{
line 797
;797:		charw =	SMALLCHAR_WIDTH;
ADDRLP4 0
CNSTI4 8
ASGNI4
line 798
;798:		charh =	SMALLCHAR_HEIGHT;
ADDRLP4 4
CNSTI4 16
ASGNI4
line 799
;799:	}
ADDRGP4 $313
JUMPV
LABELV $312
line 800
;800:	else if (style & UI_GIANTFONT)
ADDRFP4 12
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $314
line 801
;801:	{
line 802
;802:		charw =	GIANTCHAR_WIDTH;
ADDRLP4 0
CNSTI4 32
ASGNI4
line 803
;803:		charh =	GIANTCHAR_HEIGHT;
ADDRLP4 4
CNSTI4 48
ASGNI4
line 804
;804:	}
ADDRGP4 $315
JUMPV
LABELV $314
line 806
;805:	else
;806:	{
line 807
;807:		charw =	BIGCHAR_WIDTH;
ADDRLP4 0
CNSTI4 16
ASGNI4
line 808
;808:		charh =	BIGCHAR_HEIGHT;
ADDRLP4 4
CNSTI4 16
ASGNI4
line 809
;809:	}
LABELV $315
LABELV $313
line 811
;810:
;811:	if (style & UI_PULSE)
ADDRFP4 12
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $316
line 812
;812:	{
line 813
;813:		lowlight[0] = 0.8*color[0]; 
ADDRLP4 8
ADDRFP4 16
INDIRP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 814
;814:		lowlight[1] = 0.8*color[1];
ADDRLP4 8+4
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 815
;815:		lowlight[2] = 0.8*color[2];
ADDRLP4 8+8
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 816
;816:		lowlight[3] = 0.8*color[3];
ADDRLP4 8+12
ADDRFP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 817
;817:		UI_LerpColor(color,lowlight,newcolor,0.5+0.5*sin(uis.realtime/PULSE_DIVISOR));
ADDRGP4 uis+4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 64
ADDRGP4 sin
CALLF4
ASGNF4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 44
ARGP4
ADDRLP4 64
INDIRF4
CNSTF4 1056964608
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 UI_LerpColor
CALLV
pop
line 818
;818:		drawcolor = newcolor;
ADDRLP4 24
ADDRLP4 44
ASGNP4
line 819
;819:	}	
ADDRGP4 $317
JUMPV
LABELV $316
line 821
;820:	else
;821:		drawcolor = color;
ADDRLP4 24
ADDRFP4 16
INDIRP4
ASGNP4
LABELV $317
line 823
;822:
;823:	switch (style & UI_FORMATMASK)
ADDRLP4 64
ADDRFP4 12
INDIRI4
CNSTI4 7
BANDI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 1
EQI4 $325
ADDRLP4 64
INDIRI4
CNSTI4 2
EQI4 $326
ADDRGP4 $323
JUMPV
line 824
;824:	{
LABELV $325
line 831
;825:		case UI_CENTER:
;826:			// center justify at x
;827:			// JUHOX: use UI_DrawStrlen() instead of strlen
;828:#if 0
;829:			len = strlen(str);
;830:#else
;831:			len = UI_DrawStrlen(str);
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 72
ADDRGP4 UI_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 60
ADDRLP4 72
INDIRI4
ASGNI4
line 833
;832:#endif
;833:			x   = x - len*charw/2;
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRLP4 60
INDIRI4
ADDRLP4 0
INDIRI4
MULI4
CNSTI4 2
DIVI4
SUBI4
ASGNI4
line 834
;834:			break;
ADDRGP4 $323
JUMPV
LABELV $326
line 842
;835:
;836:		case UI_RIGHT:
;837:			// right justify at x
;838:			// JUHOX: use UI_DrawStrlen() instead of strlen
;839:#if 0
;840:			len = strlen(str);
;841:#else
;842:			len = UI_DrawStrlen(str);
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 76
ADDRGP4 UI_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 60
ADDRLP4 76
INDIRI4
ASGNI4
line 844
;843:#endif
;844:			x   = x - len*charw;
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRLP4 60
INDIRI4
ADDRLP4 0
INDIRI4
MULI4
SUBI4
ASGNI4
line 845
;845:			break;
line 849
;846:
;847:		default:
;848:			// left justify at x
;849:			break;
LABELV $323
line 852
;850:	}
;851:
;852:	if ( style & UI_DROPSHADOW )
ADDRFP4 12
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $327
line 853
;853:	{
line 854
;854:		dropcolor[0] = dropcolor[1] = dropcolor[2] = 0;
ADDRLP4 72
CNSTF4 0
ASGNF4
ADDRLP4 28+8
ADDRLP4 72
INDIRF4
ASGNF4
ADDRLP4 28+4
ADDRLP4 72
INDIRF4
ASGNF4
ADDRLP4 28
ADDRLP4 72
INDIRF4
ASGNF4
line 855
;855:		dropcolor[3] = drawcolor[3];
ADDRLP4 28+12
ADDRLP4 24
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 856
;856:		UI_DrawString2(x+2,y+2,str,dropcolor,charw,charh);
ADDRFP4 0
INDIRI4
CNSTI4 2
ADDI4
ARGI4
ADDRFP4 4
INDIRI4
CNSTI4 2
ADDI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 28
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 UI_DrawString2
CALLV
pop
line 857
;857:	}
LABELV $327
line 859
;858:
;859:	UI_DrawString2(x,y,str,drawcolor,charw,charh);
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 UI_DrawString2
CALLV
pop
line 860
;860:}
LABELV $306
endproc UI_DrawString 80 24
export UI_DrawChar
proc UI_DrawChar 2 20
line 868
;861:
;862:/*
;863:=================
;864:UI_DrawChar
;865:=================
;866:*/
;867:void UI_DrawChar( int x, int y, int ch, int style, vec4_t color )
;868:{
line 871
;869:	char	buff[2];
;870:
;871:	buff[0] = ch;
ADDRLP4 0
ADDRFP4 8
INDIRI4
CVII1 4
ASGNI1
line 872
;872:	buff[1] = '\0';
ADDRLP4 0+1
CNSTI1 0
ASGNI1
line 874
;873:
;874:	UI_DrawString( x, y, buff, style, color );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 875
;875:}
LABELV $332
endproc UI_DrawChar 2 20
export UI_IsFullscreen
proc UI_IsFullscreen 4 0
line 877
;876:
;877:qboolean UI_IsFullscreen( void ) {
line 878
;878:	if ( uis.activemenu && ( trap_Key_GetCatcher() & KEYCATCH_UI ) ) {
ADDRGP4 uis+20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $335
ADDRLP4 0
ADDRGP4 trap_Key_GetCatcher
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $335
line 879
;879:		return uis.activemenu->fullscreen;
ADDRGP4 uis+20
INDIRP4
CNSTI4 408
ADDP4
INDIRI4
RETI4
ADDRGP4 $334
JUMPV
LABELV $335
line 882
;880:	}
;881:
;882:	return qfalse;
CNSTI4 0
RETI4
LABELV $334
endproc UI_IsFullscreen 4 0
proc NeedCDAction 0 8
line 885
;883:}
;884:
;885:static void NeedCDAction( qboolean result ) {
line 886
;886:	if ( !result ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $340
line 887
;887:		trap_Cmd_ExecuteText( EXEC_APPEND, "quit\n" );
CNSTI4 2
ARGI4
ADDRGP4 $342
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 888
;888:	}
LABELV $340
line 889
;889:}
LABELV $339
endproc NeedCDAction 0 8
proc NeedCDKeyAction 0 8
line 891
;890:
;891:static void NeedCDKeyAction( qboolean result ) {
line 892
;892:	if ( !result ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $344
line 893
;893:		trap_Cmd_ExecuteText( EXEC_APPEND, "quit\n" );
CNSTI4 2
ARGI4
ADDRGP4 $342
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 894
;894:	}
LABELV $344
line 895
;895:}
LABELV $343
endproc NeedCDKeyAction 0 8
export UI_SetActiveMenu
proc UI_SetActiveMenu 8 12
line 897
;896:
;897:void UI_SetActiveMenu( uiMenuCommand_t menu ) {
line 900
;898:	// this should be the ONLY way the menu system is brought up
;899:	// enusure minumum menu data is cached
;900:	Menu_Cache();
ADDRGP4 Menu_Cache
CALLV
pop
line 902
;901:
;902:	switch ( menu ) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $347
ADDRLP4 0
INDIRI4
CNSTI4 6
GTI4 $347
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $360
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $360
address $350
address $351
address $356
address $352
address $354
address $358
address $358
code
LABELV $350
line 904
;903:	case UIMENU_NONE:
;904:		UI_ForceMenuOff();
ADDRGP4 UI_ForceMenuOff
CALLV
pop
line 905
;905:		return;
ADDRGP4 $346
JUMPV
LABELV $351
line 907
;906:	case UIMENU_MAIN:
;907:		UI_MainMenu();
ADDRGP4 UI_MainMenu
CALLV
pop
line 908
;908:		return;
ADDRGP4 $346
JUMPV
LABELV $352
line 910
;909:	case UIMENU_NEED_CD:
;910:		UI_ConfirmMenu( "Insert the CD", (voidfunc_f)NULL, NeedCDAction );
ADDRGP4 $353
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 NeedCDAction
ARGP4
ADDRGP4 UI_ConfirmMenu
CALLV
pop
line 911
;911:		return;
ADDRGP4 $346
JUMPV
LABELV $354
line 913
;912:	case UIMENU_BAD_CD_KEY:
;913:		UI_ConfirmMenu( "Bad CD Key", (voidfunc_f)NULL, NeedCDKeyAction );
ADDRGP4 $355
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 NeedCDKeyAction
ARGP4
ADDRGP4 UI_ConfirmMenu
CALLV
pop
line 914
;914:		return;
ADDRGP4 $346
JUMPV
LABELV $356
line 921
;915:	case UIMENU_INGAME:
;916:		/*
;917:		//GRank
;918:		UI_RankingsMenu();
;919:		return;
;920:		*/
;921:		trap_Cvar_Set( "cl_paused", "1" );
ADDRGP4 $152
ARGP4
ADDRGP4 $357
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 922
;922:		UI_InGameMenu();
ADDRGP4 UI_InGameMenu
CALLV
pop
line 923
;923:		return;
ADDRGP4 $346
JUMPV
LABELV $358
LABELV $347
line 929
;924:	// bk001204
;925:	case UIMENU_TEAM:
;926:	case UIMENU_POSTGAME:
;927:	default:
;928:#ifndef NDEBUG
;929:	  Com_Printf("UI_SetActiveMenu: bad enum %d\n", menu );
ADDRGP4 $359
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 931
;930:#endif
;931:	  break;
LABELV $348
line 933
;932:	}
;933:}
LABELV $346
endproc UI_SetActiveMenu 8 12
proc UITSSI_InitEventBuffer 0 12
line 958
;934:
;935:// JUHOX: definitions for event buffer
;936:#if 1
;937:typedef struct {
;938:	int sequence;
;939:	int data1;
;940:	int data2;
;941:} ui_tssiEvent_t;
;942:#define TSSI_EVENTBUFFER_SIZE 10
;943:typedef struct {
;944:	const char* cvar;
;945:	int sequenceCounter;
;946:	ui_tssiEvent_t events[TSSI_EVENTBUFFER_SIZE];
;947:} ui_tssiEventBuffer_t;
;948:#endif
;949:
;950:static ui_tssiEventBuffer_t tssiKeyEvents;	// JUHOX
;951:static ui_tssiEventBuffer_t tssiMouseEvents;	// JUHOX
;952:
;953:/*
;954:=================
;955:JUHOX: UITSSI_InitEventBuffer
;956:=================
;957:*/
;958:static void UITSSI_InitEventBuffer(ui_tssiEventBuffer_t* buffer, const char* cvar) {
line 959
;959:	buffer->cvar = cvar;
ADDRFP4 0
INDIRP4
ADDRFP4 4
INDIRP4
ASGNP4
line 960
;960:	buffer->sequenceCounter = 0;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 0
ASGNI4
line 961
;961:	memset(&buffer->events, -1, sizeof(buffer->events));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 120
ARGI4
ADDRGP4 memset
CALLP4
pop
line 962
;962:	trap_Cvar_Set(cvar, "");
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $364
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 963
;963:}
LABELV $363
endproc UITSSI_InitEventBuffer 0 12
proc UITSSI_AddEventToBuffer 1108 24
line 970
;964:
;965:/*
;966:=================
;967:JUHOX: UITSSI_AddEventToBuffer
;968:=================
;969:*/
;970:static void UITSSI_AddEventToBuffer(ui_tssiEventBuffer_t* buffer, int data1, int data2) {
line 975
;971:	ui_tssiEvent_t* event;
;972:	int i;
;973:	char varbuf[1024];
;974:
;975:	if (!buffer->cvar) return;
ADDRFP4 0
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $366
ADDRGP4 $365
JUMPV
LABELV $366
line 977
;976:
;977:	event = &buffer->events[buffer->sequenceCounter % TSSI_EVENTBUFFER_SIZE];
ADDRLP4 1032
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 1032
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 10
MODI4
CNSTI4 12
MULI4
ADDRLP4 1032
INDIRP4
CNSTI4 8
ADDP4
ADDP4
ASGNP4
line 979
;978:	
;979:	event->sequence = buffer->sequenceCounter;
ADDRLP4 0
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 980
;980:	event->data1 = data1;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 981
;981:	event->data2 = data2;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 983
;982:
;983:	Com_sprintf(varbuf, sizeof(varbuf), "%d/", buffer->sequenceCounter);	// so the client detects the modification
ADDRLP4 8
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $368
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 985
;984:
;985:	for (i = 0; i < TSSI_EVENTBUFFER_SIZE; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $369
line 988
;986:		char s[64];
;987:
;988:		event = &buffer->events[(buffer->sequenceCounter + i + 1) % TSSI_EVENTBUFFER_SIZE];
ADDRLP4 1100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 1100
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
CNSTI4 1
ADDI4
CNSTI4 10
MODI4
CNSTI4 12
MULI4
ADDRLP4 1100
INDIRP4
CNSTI4 8
ADDP4
ADDP4
ASGNP4
line 990
;989:
;990:		Com_sprintf(s, sizeof(s), "%d/%d/%d/", event->sequence, event->data1, event->data2);
ADDRLP4 1036
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $373
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 992
;991:
;992:		Q_strcat(varbuf, sizeof(varbuf), s);
ADDRLP4 8
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1036
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 993
;993:	}
LABELV $370
line 985
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 10
LTI4 $369
line 994
;994:	trap_Cvar_Set(buffer->cvar, varbuf);
ADDRFP4 0
INDIRP4
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 995
;995:	buffer->sequenceCounter++;
ADDRLP4 1036
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 1036
INDIRP4
ADDRLP4 1036
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 996
;996:}
LABELV $365
endproc UITSSI_AddEventToBuffer 1108 24
proc UI_CloseTSSInterface 4 8
line 1003
;997:
;998:/*
;999:=================
;1000:JUHOX: UI_CloseTSSInterface
;1001:=================
;1002:*/
;1003:static void UI_CloseTSSInterface(void) {
line 1004
;1004:	uis.tssInterfaceOpen = qfalse;
ADDRGP4 uis+11492
CNSTI4 0
ASGNI4
line 1005
;1005:	trap_Cvar_Set("tssi_mouse", "*");
ADDRGP4 $376
ARGP4
ADDRGP4 $377
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1006
;1006:	trap_Cvar_Set("tssi_key", "*");
ADDRGP4 $378
ARGP4
ADDRGP4 $377
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1007
;1007:	if (!uis.activemenu) trap_Key_SetCatcher(trap_Key_GetCatcher() & ~KEYCATCH_UI);
ADDRGP4 uis+20
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $379
ADDRLP4 0
ADDRGP4 trap_Key_GetCatcher
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 -3
BANDI4
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
LABELV $379
line 1008
;1008:}
LABELV $374
endproc UI_CloseTSSInterface 4 8
proc UI_OpenTSSInterface 4 8
line 1015
;1009:
;1010:/*
;1011:=================
;1012:JUHOX: UI_OpenTSSInterface
;1013:=================
;1014:*/
;1015:static void UI_OpenTSSInterface(void) {
line 1016
;1016:	UITSSI_InitEventBuffer(&tssiMouseEvents, "tssi_mouse");
ADDRGP4 tssiMouseEvents
ARGP4
ADDRGP4 $376
ARGP4
ADDRGP4 UITSSI_InitEventBuffer
CALLV
pop
line 1017
;1017:	UITSSI_InitEventBuffer(&tssiKeyEvents, "tssi_key");
ADDRGP4 tssiKeyEvents
ARGP4
ADDRGP4 $378
ARGP4
ADDRGP4 UITSSI_InitEventBuffer
CALLV
pop
line 1019
;1018:
;1019:	uis.tssInterfaceOpen = qtrue;
ADDRGP4 uis+11492
CNSTI4 1
ASGNI4
line 1020
;1020:	trap_Key_SetCatcher(trap_Key_GetCatcher() | KEYCATCH_UI);
ADDRLP4 0
ADDRGP4 trap_Key_GetCatcher
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
BORI4
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 1021
;1021:}
LABELV $382
endproc UI_OpenTSSInterface 4 8
export UI_KeyEvent
proc UI_KeyEvent 16 12
line 1028
;1022:
;1023:/*
;1024:=================
;1025:UI_KeyEvent
;1026:=================
;1027:*/
;1028:void UI_KeyEvent( int key, int down ) {
line 1033
;1029:	sfxHandle_t		s;
;1030:
;1031:	// JUHOX: send key events to cgame when TSS Interface open
;1032:#if 1
;1033:	if (uis.tssInterfaceOpen) {
ADDRGP4 uis+11492
INDIRI4
CNSTI4 0
EQI4 $385
line 1034
;1034:		if (key == K_ESCAPE && down) {
ADDRFP4 0
INDIRI4
CNSTI4 27
NEI4 $388
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $388
line 1035
;1035:			UI_CloseTSSInterface();
ADDRGP4 UI_CloseTSSInterface
CALLV
pop
line 1036
;1036:			return;
ADDRGP4 $384
JUMPV
LABELV $388
line 1038
;1037:		}
;1038:		UITSSI_AddEventToBuffer(&tssiKeyEvents, key, down);
ADDRGP4 tssiKeyEvents
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 UITSSI_AddEventToBuffer
CALLV
pop
line 1039
;1039:		return;
ADDRGP4 $384
JUMPV
LABELV $385
line 1043
;1040:	}
;1041:#endif
;1042:
;1043:	if (!uis.activemenu) {
ADDRGP4 uis+20
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $390
line 1044
;1044:		return;
ADDRGP4 $384
JUMPV
LABELV $390
line 1047
;1045:	}
;1046:
;1047:	if (!down) {
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $393
line 1048
;1048:		return;
ADDRGP4 $384
JUMPV
LABELV $393
line 1051
;1049:	}
;1050:
;1051:	if (uis.activemenu->key)
ADDRGP4 uis+20
INDIRP4
CNSTI4 400
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $395
line 1052
;1052:		s = uis.activemenu->key( key );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 uis+20
INDIRP4
CNSTI4 400
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
ADDRGP4 $396
JUMPV
LABELV $395
line 1054
;1053:	else
;1054:		s = Menu_DefaultKey( uis.activemenu, key );
ADDRGP4 uis+20
INDIRP4
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 Menu_DefaultKey
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
LABELV $396
line 1056
;1055:
;1056:	if ((s > 0) && (s != menu_null_sound))
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $400
ADDRLP4 0
INDIRI4
ADDRGP4 menu_null_sound
INDIRI4
EQI4 $400
line 1057
;1057:		trap_S_StartLocalSound( s, CHAN_LOCAL_SOUND );
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
LABELV $400
line 1058
;1058:}
LABELV $384
endproc UI_KeyEvent 16 12
export UI_MouseEvent
proc UI_MouseEvent 24 12
line 1066
;1059:
;1060:/*
;1061:=================
;1062:UI_MouseEvent
;1063:=================
;1064:*/
;1065:void UI_MouseEvent( int dx, int dy )
;1066:{
line 1072
;1067:	int				i;
;1068:	menucommon_s*	m;
;1069:
;1070:	// JUHOX: send mouse events to cgame when TSS Interface open
;1071:#if 1
;1072:	if (uis.tssInterfaceOpen) {
ADDRGP4 uis+11492
INDIRI4
CNSTI4 0
EQI4 $403
line 1073
;1073:		UITSSI_AddEventToBuffer(&tssiMouseEvents, dx, dy);
ADDRGP4 tssiMouseEvents
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 UITSSI_AddEventToBuffer
CALLV
pop
line 1074
;1074:		return;
ADDRGP4 $402
JUMPV
LABELV $403
line 1078
;1075:	}
;1076:#endif
;1077:
;1078:	if (!uis.activemenu)
ADDRGP4 uis+20
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $406
line 1079
;1079:		return;
ADDRGP4 $402
JUMPV
LABELV $406
line 1082
;1080:
;1081:	// update mouse screen position
;1082:	uis.cursorx += dx;
ADDRLP4 8
ADDRGP4 uis+8
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
ADDRFP4 0
INDIRI4
ADDI4
ASGNI4
line 1083
;1083:	if (uis.cursorx < 0)
ADDRGP4 uis+8
INDIRI4
CNSTI4 0
GEI4 $410
line 1084
;1084:		uis.cursorx = 0;
ADDRGP4 uis+8
CNSTI4 0
ASGNI4
ADDRGP4 $411
JUMPV
LABELV $410
line 1085
;1085:	else if (uis.cursorx > SCREEN_WIDTH)
ADDRGP4 uis+8
INDIRI4
CNSTI4 640
LEI4 $414
line 1086
;1086:		uis.cursorx = SCREEN_WIDTH;
ADDRGP4 uis+8
CNSTI4 640
ASGNI4
LABELV $414
LABELV $411
line 1088
;1087:
;1088:	uis.cursory += dy;
ADDRLP4 12
ADDRGP4 uis+12
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
ADDRFP4 4
INDIRI4
ADDI4
ASGNI4
line 1089
;1089:	if (uis.cursory < 0)
ADDRGP4 uis+12
INDIRI4
CNSTI4 0
GEI4 $419
line 1090
;1090:		uis.cursory = 0;
ADDRGP4 uis+12
CNSTI4 0
ASGNI4
ADDRGP4 $420
JUMPV
LABELV $419
line 1091
;1091:	else if (uis.cursory > SCREEN_HEIGHT)
ADDRGP4 uis+12
INDIRI4
CNSTI4 480
LEI4 $423
line 1092
;1092:		uis.cursory = SCREEN_HEIGHT;
ADDRGP4 uis+12
CNSTI4 480
ASGNI4
LABELV $423
LABELV $420
line 1095
;1093:
;1094:	// region test the active menu items
;1095:	for (i=0; i<uis.activemenu->nitems; i++)
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $430
JUMPV
LABELV $427
line 1096
;1096:	{
line 1097
;1097:		m = (menucommon_s*)uis.activemenu->items[i];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uis+20
INDIRP4
CNSTI4 12
ADDP4
ADDP4
INDIRP4
ASGNP4
line 1099
;1098:
;1099:		if (m->flags & (QMF_GRAYED|QMF_INACTIVE))
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 24576
BANDU4
CNSTU4 0
EQU4 $433
line 1100
;1100:			continue;
ADDRGP4 $428
JUMPV
LABELV $433
line 1102
;1101:
;1102:		if ((uis.cursorx < m->left) ||
ADDRGP4 uis+8
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
LTI4 $443
ADDRGP4 uis+8
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
GTI4 $443
ADDRGP4 uis+12
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
LTI4 $443
ADDRGP4 uis+12
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
LEI4 $435
LABELV $443
line 1106
;1103:			(uis.cursorx > m->right) ||
;1104:			(uis.cursory < m->top) ||
;1105:			(uis.cursory > m->bottom))
;1106:		{
line 1108
;1107:			// cursor out of item bounds
;1108:			continue;
ADDRGP4 $428
JUMPV
LABELV $435
line 1112
;1109:		}
;1110:
;1111:		// set focus to item at cursor
;1112:		if (uis.activemenu->cursor != i)
ADDRGP4 uis+20
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $444
line 1113
;1113:		{
line 1114
;1114:			Menu_SetCursor( uis.activemenu, i );
ADDRGP4 uis+20
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 Menu_SetCursor
CALLV
pop
line 1115
;1115:			((menucommon_s*)(uis.activemenu->items[uis.activemenu->cursor_prev]))->flags &= ~QMF_HASMOUSEFOCUS;
ADDRLP4 20
ADDRGP4 uis+20
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uis+20
INDIRP4
CNSTI4 12
ADDP4
ADDP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRU4
CNSTU4 4294966783
BANDU4
ASGNU4
line 1117
;1116:
;1117:			if ( !(((menucommon_s*)(uis.activemenu->items[uis.activemenu->cursor]))->flags & QMF_SILENT ) ) {
ADDRGP4 uis+20
INDIRP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uis+20
INDIRP4
CNSTI4 12
ADDP4
ADDP4
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 1048576
BANDU4
CNSTU4 0
NEU4 $450
line 1118
;1118:				trap_S_StartLocalSound( menu_move_sound, CHAN_LOCAL_SOUND );
ADDRGP4 menu_move_sound
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 1119
;1119:			}
LABELV $450
line 1120
;1120:		}
LABELV $444
line 1122
;1121:
;1122:		((menucommon_s*)(uis.activemenu->items[uis.activemenu->cursor]))->flags |= QMF_HASMOUSEFOCUS;
ADDRLP4 20
ADDRGP4 uis+20
INDIRP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uis+20
INDIRP4
CNSTI4 12
ADDP4
ADDP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRU4
CNSTU4 512
BORU4
ASGNU4
line 1123
;1123:		return;
ADDRGP4 $402
JUMPV
LABELV $428
line 1095
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $430
ADDRLP4 4
INDIRI4
ADDRGP4 uis+20
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
LTI4 $427
line 1126
;1124:	}  
;1125:
;1126:	if (uis.activemenu->nitems > 0) {
ADDRGP4 uis+20
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 0
LEI4 $456
line 1128
;1127:		// out of any region
;1128:		((menucommon_s*)(uis.activemenu->items[uis.activemenu->cursor]))->flags &= ~QMF_HASMOUSEFOCUS;
ADDRLP4 16
ADDRGP4 uis+20
INDIRP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uis+20
INDIRP4
CNSTI4 12
ADDP4
ADDP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRU4
CNSTU4 4294966783
BANDU4
ASGNU4
line 1129
;1129:	}
LABELV $456
line 1130
;1130:}
LABELV $402
endproc UI_MouseEvent 24 12
bss
align 1
LABELV $462
skip 1024
export UI_Argv
code
proc UI_Argv 0 12
line 1132
;1131:
;1132:char *UI_Argv( int arg ) {
line 1135
;1133:	static char	buffer[MAX_STRING_CHARS];
;1134:
;1135:	trap_Argv( arg, buffer, sizeof( buffer ) );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $462
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1137
;1136:
;1137:	return buffer;
ADDRGP4 $462
RETP4
LABELV $461
endproc UI_Argv 0 12
bss
align 1
LABELV $464
skip 1024
export UI_Cvar_VariableString
code
proc UI_Cvar_VariableString 0 12
line 1141
;1138:}
;1139:
;1140:
;1141:char *UI_Cvar_VariableString( const char *var_name ) {
line 1144
;1142:	static char	buffer[MAX_STRING_CHARS];
;1143:
;1144:	trap_Cvar_VariableStringBuffer( var_name, buffer, sizeof( buffer ) );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $464
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1146
;1145:
;1146:	return buffer;
ADDRGP4 $464
RETP4
LABELV $463
endproc UI_Cvar_VariableString 0 12
export UI_Cache_f
proc UI_Cache_f 0 0
line 1155
;1147:}
;1148:
;1149:
;1150:/*
;1151:=================
;1152:UI_Cache
;1153:=================
;1154:*/
;1155:void UI_Cache_f( void ) {
line 1156
;1156:	MainMenu_Cache();
ADDRGP4 MainMenu_Cache
CALLV
pop
line 1157
;1157:	InGame_Cache();
ADDRGP4 InGame_Cache
CALLV
pop
line 1158
;1158:	ConfirmMenu_Cache();
ADDRGP4 ConfirmMenu_Cache
CALLV
pop
line 1159
;1159:	PlayerModel_Cache();
ADDRGP4 PlayerModel_Cache
CALLV
pop
line 1160
;1160:	PlayerSettings_Cache();
ADDRGP4 PlayerSettings_Cache
CALLV
pop
line 1161
;1161:	Controls_Cache();
ADDRGP4 Controls_Cache
CALLV
pop
line 1162
;1162:	Demos_Cache();
ADDRGP4 Demos_Cache
CALLV
pop
line 1163
;1163:	UI_CinematicsMenu_Cache();
ADDRGP4 UI_CinematicsMenu_Cache
CALLV
pop
line 1164
;1164:	Preferences_Cache();
ADDRGP4 Preferences_Cache
CALLV
pop
line 1165
;1165:	ServerInfo_Cache();
ADDRGP4 ServerInfo_Cache
CALLV
pop
line 1166
;1166:	SpecifyServer_Cache();
ADDRGP4 SpecifyServer_Cache
CALLV
pop
line 1167
;1167:	ArenaServers_Cache();
ADDRGP4 ArenaServers_Cache
CALLV
pop
line 1168
;1168:	StartServer_Cache();
ADDRGP4 StartServer_Cache
CALLV
pop
line 1169
;1169:	ServerOptions_Cache();
ADDRGP4 ServerOptions_Cache
CALLV
pop
line 1170
;1170:	DriverInfo_Cache();
ADDRGP4 DriverInfo_Cache
CALLV
pop
line 1171
;1171:	GraphicsOptions_Cache();
ADDRGP4 GraphicsOptions_Cache
CALLV
pop
line 1172
;1172:	UI_DisplayOptionsMenu_Cache();
ADDRGP4 UI_DisplayOptionsMenu_Cache
CALLV
pop
line 1173
;1173:	UI_SoundOptionsMenu_Cache();
ADDRGP4 UI_SoundOptionsMenu_Cache
CALLV
pop
line 1174
;1174:	UI_NetworkOptionsMenu_Cache();
ADDRGP4 UI_NetworkOptionsMenu_Cache
CALLV
pop
line 1175
;1175:	UI_SPLevelMenu_Cache();
ADDRGP4 UI_SPLevelMenu_Cache
CALLV
pop
line 1176
;1176:	UI_SPSkillMenu_Cache();
ADDRGP4 UI_SPSkillMenu_Cache
CALLV
pop
line 1177
;1177:	UI_SPPostgameMenu_Cache();
ADDRGP4 UI_SPPostgameMenu_Cache
CALLV
pop
line 1178
;1178:	TeamMain_Cache();
ADDRGP4 TeamMain_Cache
CALLV
pop
line 1179
;1179:	UI_AddBots_Cache();
ADDRGP4 UI_AddBots_Cache
CALLV
pop
line 1180
;1180:	UI_RemoveBots_Cache();
ADDRGP4 UI_RemoveBots_Cache
CALLV
pop
line 1181
;1181:	UI_SetupMenu_Cache();
ADDRGP4 UI_SetupMenu_Cache
CALLV
pop
line 1184
;1182://	UI_LoadConfig_Cache();
;1183://	UI_SaveConfigMenu_Cache();
;1184:	UI_BotSelectMenu_Cache();
ADDRGP4 UI_BotSelectMenu_Cache
CALLV
pop
line 1185
;1185:	UI_CDKeyMenu_Cache();
ADDRGP4 UI_CDKeyMenu_Cache
CALLV
pop
line 1186
;1186:	UI_ModsMenu_Cache();
ADDRGP4 UI_ModsMenu_Cache
CALLV
pop
line 1188
;1187:
;1188:}
LABELV $465
endproc UI_Cache_f 0 0
proc UI_SvTemplate_f 1148 20
line 1196
;1189:
;1190:
;1191:/*
;1192:=================
;1193:JUHOX: UI_SvTemplate_f
;1194:=================
;1195:*/
;1196:static void UI_SvTemplate_f(void) {
line 1203
;1197:	int number;
;1198:	int highscoreType;
;1199:	char name[64];
;1200:	char highscore[32];
;1201:	char descriptor[MAX_STRING_CHARS];
;1202:
;1203:	if (trap_Argc() != 6) return;
ADDRLP4 1128
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 1128
INDIRI4
CNSTI4 6
EQI4 $467
ADDRGP4 $466
JUMPV
LABELV $467
line 1205
;1204:
;1205:	number = atoi(UI_Argv(1));
CNSTI4 1
ARGI4
ADDRLP4 1132
ADDRGP4 UI_Argv
CALLP4
ASGNP4
ADDRLP4 1132
INDIRP4
ARGP4
ADDRLP4 1136
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1120
ADDRLP4 1136
INDIRI4
ASGNI4
line 1206
;1206:	trap_Argv(2, name, sizeof(name));
CNSTI4 2
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1207
;1207:	highscoreType = atoi(UI_Argv(3));
CNSTI4 3
ARGI4
ADDRLP4 1140
ADDRGP4 UI_Argv
CALLP4
ASGNP4
ADDRLP4 1140
INDIRP4
ARGP4
ADDRLP4 1144
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1124
ADDRLP4 1144
INDIRI4
ASGNI4
line 1208
;1208:	trap_Argv(4, highscore, sizeof(highscore));
CNSTI4 4
ARGI4
ADDRLP4 64
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1209
;1209:	trap_Argv(5, descriptor, sizeof(descriptor));
CNSTI4 5
ARGI4
ADDRLP4 96
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1211
;1210:
;1211:	UI_TemplateList_SvTemplate(number, name, highscoreType, highscore, descriptor);
ADDRLP4 1120
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1124
INDIRI4
ARGI4
ADDRLP4 64
ARGP4
ADDRLP4 96
ARGP4
ADDRGP4 UI_TemplateList_SvTemplate
CALLV
pop
line 1212
;1212:}
LABELV $466
endproc UI_SvTemplate_f 1148 20
proc UI_TemplateList_Complete_f 28 8
line 1219
;1213:
;1214:/*
;1215:=================
;1216:JUHOX: UI_TemplateList_Complete_f
;1217:=================
;1218:*/
;1219:static void UI_TemplateList_Complete_f(void) {
line 1223
;1220:	int number;
;1221:	long checksum;
;1222:
;1223:	if (trap_Argc() != 3) return;
ADDRLP4 8
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 3
EQI4 $470
ADDRGP4 $469
JUMPV
LABELV $470
line 1225
;1224:
;1225:	number = atoi(UI_Argv(1));
CNSTI4 1
ARGI4
ADDRLP4 12
ADDRGP4 UI_Argv
CALLP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 16
INDIRI4
ASGNI4
line 1226
;1226:	checksum = atoi(UI_Argv(2));
CNSTI4 2
ARGI4
ADDRLP4 20
ADDRGP4 UI_Argv
CALLP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 24
INDIRI4
ASGNI4
line 1228
;1227:
;1228:	UI_TemplateList_Complete(number, checksum);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 UI_TemplateList_Complete
CALLV
pop
line 1229
;1229:}
LABELV $469
endproc UI_TemplateList_Complete_f 28 8
proc UI_TmplName_f 20 12
line 1236
;1230:
;1231:/*
;1232:=================
;1233:JUHOX: UI_TmplName_f
;1234:=================
;1235:*/
;1236:static void UI_TmplName_f(void) {
line 1239
;1237:	int len;
;1238:
;1239:	uis.templateName[0] = 0;
ADDRGP4 uis+11500
CNSTI1 0
ASGNI1
line 1240
;1240:	uis.templateCounter = 0;
ADDRGP4 uis+12524
CNSTI4 0
ASGNI4
line 1242
;1241:
;1242:	if (!uis.loadingTemplates) return;
ADDRGP4 uis+11496
INDIRI4
CNSTI4 0
NEI4 $475
ADDRGP4 $472
JUMPV
LABELV $475
line 1243
;1243:	if (trap_Argc() != 2) return;
ADDRLP4 4
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 2
EQI4 $478
ADDRGP4 $472
JUMPV
LABELV $478
line 1245
;1244:
;1245:	Q_strncpyz(uis.templateName, UI_Argv(1), sizeof(uis.templateName));
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 UI_Argv
CALLP4
ASGNP4
ADDRGP4 uis+11500
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1246
;1246:	len = strlen(uis.templateName);
ADDRGP4 uis+11500
ARGP4
ADDRLP4 12
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 1247
;1247:	if (len >= 5) {
ADDRLP4 0
INDIRI4
CNSTI4 5
LTI4 $483
line 1248
;1248:		if (!Q_stricmp(&uis.templateName[len-5], ".tmpl")) {
ADDRLP4 0
INDIRI4
ADDRGP4 uis+11500-5
ADDP4
ARGP4
ADDRGP4 $489
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $485
line 1249
;1249:			uis.templateName[len-5] = 0;
ADDRLP4 0
INDIRI4
ADDRGP4 uis+11500-5
ADDP4
CNSTI1 0
ASGNI1
line 1250
;1250:		}
LABELV $485
line 1251
;1251:	}
LABELV $483
line 1252
;1252:}
LABELV $472
endproc UI_TmplName_f 20 12
proc UI_DefTemplate_f 1052 20
line 1259
;1253:
;1254:/*
;1255:=================
;1256:JUHOX: UI_DefTemplate_f
;1257:=================
;1258:*/
;1259:static void UI_DefTemplate_f(void) {
line 1264
;1260:	char cvarName[MAX_STRING_CHARS];
;1261:	char* tmpl;
;1262:	char* name;
;1263:
;1264:	if (!uis.loadingTemplates) return;
ADDRGP4 uis+11496
INDIRI4
CNSTI4 0
NEI4 $493
ADDRGP4 $492
JUMPV
LABELV $493
line 1265
;1265:	if (!uis.templateName[0]) return;
ADDRGP4 uis+11500
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $496
ADDRGP4 $492
JUMPV
LABELV $496
line 1266
;1266:	if (trap_Argc() != 2) return;
ADDRLP4 1032
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 2
EQI4 $499
ADDRGP4 $492
JUMPV
LABELV $499
line 1268
;1267:
;1268:	tmpl = UI_Argv(1);
CNSTI4 1
ARGI4
ADDRLP4 1036
ADDRGP4 UI_Argv
CALLP4
ASGNP4
ADDRLP4 1024
ADDRLP4 1036
INDIRP4
ASGNP4
line 1269
;1269:	if (!Info_Validate(tmpl)) return;
ADDRLP4 1024
INDIRP4
ARGP4
ADDRLP4 1040
ADDRGP4 Info_Validate
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $501
ADDRGP4 $492
JUMPV
LABELV $501
line 1270
;1270:	name = Info_ValueForKey(tmpl, "name");
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $503
ARGP4
ADDRLP4 1044
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 1044
INDIRP4
ASGNP4
line 1271
;1271:	if (!name[0]) return;
ADDRLP4 1028
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $504
ADDRGP4 $492
JUMPV
LABELV $504
line 1273
;1272:
;1273:	Com_sprintf(cvarName, sizeof(cvarName), "%s%03d", uis.templateName, uis.templateCounter);
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $506
ARGP4
ADDRGP4 uis+11500
ARGP4
ADDRGP4 uis+12524
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1274
;1274:	trap_Cvar_Register(NULL, cvarName, "", CVAR_ROM | CVAR_NORESTART);
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 $364
ARGP4
CNSTI4 1088
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1275
;1275:	trap_Cvar_Set(cvarName, tmpl);
ADDRLP4 0
ARGP4
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1277
;1276:	
;1277:	uis.templateCounter++;
ADDRLP4 1048
ADDRGP4 uis+12524
ASGNP4
ADDRLP4 1048
INDIRP4
ADDRLP4 1048
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1278
;1278:}
LABELV $492
endproc UI_DefTemplate_f 1052 20
proc UI_TemplatesComplete_f 0 0
line 1285
;1279:
;1280:/*
;1281:=================
;1282:JUHOX: UI_TemplatesComplete_f
;1283:=================
;1284:*/
;1285:static void UI_TemplatesComplete_f(void) {
line 1286
;1286:	uis.loadingTemplates = qfalse;
ADDRGP4 uis+11496
CNSTI4 0
ASGNI4
line 1287
;1287:}
LABELV $510
endproc UI_TemplatesComplete_f 0 0
proc UI_LFEdit_f 16 8
line 1295
;1288:
;1289:/*
;1290:=================
;1291:JUHOX: UI_LFEdit_f
;1292:=================
;1293:*/
;1294:#if MAPLENSFLARES
;1295:static void UI_LFEdit_f(void) {
line 1298
;1296:	const char* mapname;
;1297:
;1298:	if (trap_Argc() != 2) return;
ADDRLP4 4
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 2
EQI4 $513
ADDRGP4 $512
JUMPV
LABELV $513
line 1300
;1299:
;1300:	mapname = UI_Argv(1);
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 UI_Argv
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 1301
;1301:	if (!mapname) return;
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $515
ADDRGP4 $512
JUMPV
LABELV $515
line 1302
;1302:	if (!mapname[0]) return;
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $517
ADDRGP4 $512
JUMPV
LABELV $517
line 1304
;1303:
;1304:	trap_Cvar_SetValue("sv_maxclients", 1);
ADDRGP4 $519
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1305
;1305:	trap_Cvar_SetValue("dedicated", 0);
ADDRGP4 $520
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1306
;1306:	trap_Cvar_SetValue("sv_pure", 0);
ADDRGP4 $521
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1307
;1307:	trap_Cvar_SetValue("g_editmode", EM_mlf);
ADDRGP4 $522
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1308
;1308:	trap_Cvar_SetValue("g_gametype", 0);
ADDRGP4 $523
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1311
;1309:
;1310:	// the wait commands will allow the dedicated to take effect
;1311:	trap_Cmd_ExecuteText(EXEC_APPEND, va( "wait ; wait ; devmap %s\n", mapname));
ADDRGP4 $524
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 1312
;1312:}
LABELV $512
endproc UI_LFEdit_f 16 8
proc UI_TSSData_f 84 20
line 1321
;1313:#endif
;1314:
;1315:/*
;1316:=================
;1317:JUHOX: UI_TSSData_f
;1318:=================
;1319:*/
;1320:#if TSSINCVAR
;1321:static void UI_TSSData_f(void) {
line 1325
;1322:	int index;
;1323:	char cvarName[32];
;1324:
;1325:	if (trap_Argc() != 3) return;
ADDRLP4 36
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 3
EQI4 $526
ADDRGP4 $525
JUMPV
LABELV $526
line 1327
;1326:
;1327:	index = atoi(UI_Argv(1));
CNSTI4 1
ARGI4
ADDRLP4 40
ADDRGP4 UI_Argv
CALLP4
ASGNP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 32
ADDRLP4 44
INDIRI4
ASGNI4
line 1328
;1328:	if (index == 0) {
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $528
line 1331
;1329:		char filename[TSS_NAME_SIZE];
;1330:
;1331:		uis.numTssEntries++;
ADDRLP4 80
ADDRGP4 uis+95100
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1332
;1332:		trap_Cvar_VariableStringBuffer("tsstmp", filename, sizeof(filename));
ADDRGP4 $531
ARGP4
ADDRLP4 48
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1333
;1333:		if (!filename[0]) return;
ADDRLP4 48
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $532
ADDRGP4 $525
JUMPV
LABELV $532
line 1334
;1334:		Com_sprintf(cvarName, sizeof(cvarName), "tsspak%03dn", uis.numTssEntries);
ADDRLP4 0
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $534
ARGP4
ADDRGP4 uis+95100
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1335
;1335:		trap_Cvar_Register(NULL, cvarName, "", CVAR_ROM);
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 $364
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1336
;1336:		trap_Cvar_Set(cvarName, filename);
ADDRLP4 0
ARGP4
ADDRLP4 48
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1337
;1337:	}
LABELV $528
line 1339
;1338:
;1339:	if (uis.numTssEntries < 0) return;
ADDRGP4 uis+95100
INDIRI4
CNSTI4 0
GEI4 $536
ADDRGP4 $525
JUMPV
LABELV $536
line 1340
;1340:	if (uis.numTssEntries >= TSS_MAX_STRATEGIES) return;
ADDRGP4 uis+95100
INDIRI4
CNSTI4 1000
LTI4 $539
ADDRGP4 $525
JUMPV
LABELV $539
line 1342
;1341:
;1342:	Com_sprintf(cvarName, sizeof(cvarName), "tsspak%03d%d", uis.numTssEntries, index);
ADDRLP4 0
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $542
ARGP4
ADDRGP4 uis+95100
INDIRI4
ARGI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1343
;1343:	trap_Cvar_Register(NULL, cvarName, "", CVAR_ROM);
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 $364
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1344
;1344:	trap_Cvar_Set(cvarName, UI_Argv(2));
CNSTI4 2
ARGI4
ADDRLP4 48
ADDRGP4 UI_Argv
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1345
;1345:}
LABELV $525
endproc UI_TSSData_f 84 20
proc UI_AddTrack_f 1324 24
line 1354
;1346:#endif
;1347:
;1348:/*
;1349:=================
;1350:JUHOX: UI_AddTrack_f
;1351:=================
;1352:*/
;1353:#if PLAYLIST
;1354:static void UI_AddTrack_f(void) {
line 1361
;1355:	char introPart[128];
;1356:	char mainPart[128];
;1357:	int rep;
;1358:	char name[16];
;1359:	char info[MAX_INFO_STRING];
;1360:
;1361:	if (!uis.loadPlayList) return;
ADDRGP4 uis+95112
INDIRI4
CNSTI4 0
NEI4 $545
ADDRGP4 $544
JUMPV
LABELV $545
line 1362
;1362:	if (uis.currentTrack >= MAX_PLAYLIST_ENTRIES) return;
ADDRGP4 uis+95116
INDIRI4
CNSTI4 100
LTI4 $548
ADDRGP4 $544
JUMPV
LABELV $548
line 1364
;1363:
;1364:	Q_strncpyz(introPart, UI_Argv(1), sizeof(introPart));
CNSTI4 1
ARGI4
ADDRLP4 1300
ADDRGP4 UI_Argv
CALLP4
ASGNP4
ADDRLP4 144
ARGP4
ADDRLP4 1300
INDIRP4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1365
;1365:	Q_strncpyz(mainPart, UI_Argv(2), sizeof(mainPart));
CNSTI4 2
ARGI4
ADDRLP4 1304
ADDRGP4 UI_Argv
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
ADDRLP4 1304
INDIRP4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1366
;1366:	rep = atoi(UI_Argv(3));
CNSTI4 3
ARGI4
ADDRLP4 1308
ADDRGP4 UI_Argv
CALLP4
ASGNP4
ADDRLP4 1308
INDIRP4
ARGP4
ADDRLP4 1312
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 272
ADDRLP4 1312
INDIRI4
ASGNI4
line 1367
;1367:	if (!UI_Argv(3)[0]) rep = 1;
CNSTI4 3
ARGI4
ADDRLP4 1316
ADDRGP4 UI_Argv
CALLP4
ASGNP4
ADDRLP4 1316
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $551
ADDRLP4 272
CNSTI4 1
ASGNI4
LABELV $551
line 1368
;1368:	if (!mainPart[0]) rep = 1;
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $553
ADDRLP4 272
CNSTI4 1
ASGNI4
LABELV $553
line 1369
;1369:	Com_sprintf(info, sizeof(info), "intro\\%s\\main\\%s\\rep\\%d", introPart, mainPart, rep);
ADDRLP4 276
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $555
ARGP4
ADDRLP4 144
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 272
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1371
;1370:
;1371:	Com_sprintf(name, sizeof(name), "playlist%02d", uis.currentTrack);
ADDRLP4 128
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $556
ARGP4
ADDRGP4 uis+95116
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1373
;1372:
;1373:	trap_Cvar_Register(NULL, name, "", CVAR_ROM);
CNSTP4 0
ARGP4
ADDRLP4 128
ARGP4
ADDRGP4 $364
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1374
;1374:	trap_Cvar_Set(name, info);
ADDRLP4 128
ARGP4
ADDRLP4 276
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1376
;1375:
;1376:	uis.currentTrack++;
ADDRLP4 1320
ADDRGP4 uis+95116
ASGNP4
ADDRLP4 1320
INDIRP4
ADDRLP4 1320
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1377
;1377:}
LABELV $544
endproc UI_AddTrack_f 1324 24
proc UI_PlayListComplete_f 0 0
line 1386
;1378:#endif
;1379:
;1380:/*
;1381:=================
;1382:JUHOX: UI_PlayListComplete_f
;1383:=================
;1384:*/
;1385:#if PLAYLIST
;1386:static void UI_PlayListComplete_f(void) {
line 1387
;1387:	uis.loadPlayList = qfalse;
ADDRGP4 uis+95112
CNSTI4 0
ASGNI4
line 1388
;1388:}
LABELV $559
endproc UI_PlayListComplete_f 0 0
export UI_ConsoleCommand
proc UI_ConsoleCommand 72 8
line 1396
;1389:#endif
;1390:
;1391:/*
;1392:=================
;1393:UI_ConsoleCommand
;1394:=================
;1395:*/
;1396:qboolean UI_ConsoleCommand( int realTime ) {
line 1399
;1397:	char	*cmd;
;1398:
;1399:	cmd = UI_Argv( 0 );
CNSTI4 0
ARGI4
ADDRLP4 4
ADDRGP4 UI_Argv
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 1402
;1400:
;1401:	// ensure minimum menu data is available
;1402:	Menu_Cache();
ADDRGP4 Menu_Cache
CALLV
pop
line 1404
;1403:
;1404:	if ( Q_stricmp (cmd, "levelselect") == 0 ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $564
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $562
line 1405
;1405:		UI_SPLevelMenu_f();
ADDRGP4 UI_SPLevelMenu_f
CALLV
pop
line 1406
;1406:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $561
JUMPV
LABELV $562
line 1409
;1407:	}
;1408:
;1409:	if ( Q_stricmp (cmd, "postgame") == 0 ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $567
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $565
line 1410
;1410:		UI_SPPostgameMenu_f();
ADDRGP4 UI_SPPostgameMenu_f
CALLV
pop
line 1411
;1411:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $561
JUMPV
LABELV $565
line 1414
;1412:	}
;1413:
;1414:	if ( Q_stricmp (cmd, "ui_cache") == 0 ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $570
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $568
line 1415
;1415:		UI_Cache_f();
ADDRGP4 UI_Cache_f
CALLV
pop
line 1416
;1416:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $561
JUMPV
LABELV $568
line 1419
;1417:	}
;1418:
;1419:	if ( Q_stricmp (cmd, "ui_cinematics") == 0 ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $573
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $571
line 1420
;1420:		UI_CinematicsMenu_f();
ADDRGP4 UI_CinematicsMenu_f
CALLV
pop
line 1421
;1421:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $561
JUMPV
LABELV $571
line 1424
;1422:	}
;1423:
;1424:	if ( Q_stricmp (cmd, "ui_teamOrders") == 0 ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $576
ARGP4
ADDRLP4 24
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $574
line 1425
;1425:		UI_TeamOrdersMenu_f();
ADDRGP4 UI_TeamOrdersMenu_f
CALLV
pop
line 1426
;1426:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $561
JUMPV
LABELV $574
line 1429
;1427:	}
;1428:
;1429:	if ( Q_stricmp (cmd, "iamacheater") == 0 ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $579
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $577
line 1430
;1430:		UI_SPUnlock_f();
ADDRGP4 UI_SPUnlock_f
CALLV
pop
line 1431
;1431:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $561
JUMPV
LABELV $577
line 1434
;1432:	}
;1433:
;1434:	if ( Q_stricmp (cmd, "iamamonkey") == 0 ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $582
ARGP4
ADDRLP4 32
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $580
line 1435
;1435:		UI_SPUnlockMedals_f();
ADDRGP4 UI_SPUnlockMedals_f
CALLV
pop
line 1436
;1436:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $561
JUMPV
LABELV $580
line 1439
;1437:	}
;1438:
;1439:	if ( Q_stricmp (cmd, "ui_cdkey") == 0 ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $585
ARGP4
ADDRLP4 36
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $583
line 1440
;1440:		UI_CDKeyMenu_f();
ADDRGP4 UI_CDKeyMenu_f
CALLV
pop
line 1441
;1441:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $561
JUMPV
LABELV $583
line 1445
;1442:	}
;1443:
;1444:#if 1	// JUHOX: TSS Interface commands
;1445:	if (Q_stricmp(cmd, "tssiopen") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $588
ARGP4
ADDRLP4 40
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $586
line 1446
;1446:		UI_OpenTSSInterface();
ADDRGP4 UI_OpenTSSInterface
CALLV
pop
line 1447
;1447:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $561
JUMPV
LABELV $586
line 1449
;1448:	}
;1449:	if (Q_stricmp(cmd, "tssiclose") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $591
ARGP4
ADDRLP4 44
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $589
line 1450
;1450:		UI_CloseTSSInterface();
ADDRGP4 UI_CloseTSSInterface
CALLV
pop
line 1451
;1451:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $561
JUMPV
LABELV $589
line 1456
;1452:	}
;1453:#endif
;1454:
;1455:#if 1	// JUHOX: template list commands
;1456:	if (Q_stricmp(cmd, "sv_template_ui") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $594
ARGP4
ADDRLP4 48
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
NEI4 $592
line 1457
;1457:		UI_SvTemplate_f();
ADDRGP4 UI_SvTemplate_f
CALLV
pop
line 1458
;1458:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $561
JUMPV
LABELV $592
line 1460
;1459:	}
;1460:	if (Q_stricmp(cmd, "templatelist_complete_ui") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $597
ARGP4
ADDRLP4 52
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $595
line 1461
;1461:		UI_TemplateList_Complete_f();
ADDRGP4 UI_TemplateList_Complete_f
CALLV
pop
line 1462
;1462:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $561
JUMPV
LABELV $595
line 1467
;1463:	}
;1464:#endif
;1465:
;1466:#if 1	// JUHOX: template load commands
;1467:	if (uis.loadingTemplates) {
ADDRGP4 uis+11496
INDIRI4
CNSTI4 0
EQI4 $598
line 1468
;1468:		if (Q_stricmp(cmd, "tmplname") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $603
ARGP4
ADDRLP4 56
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
NEI4 $601
line 1469
;1469:			UI_TmplName_f();
ADDRGP4 UI_TmplName_f
CALLV
pop
line 1470
;1470:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $561
JUMPV
LABELV $601
line 1472
;1471:		}
;1472:		if (Q_stricmp(cmd, "deftemplate") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $606
ARGP4
ADDRLP4 60
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
NEI4 $604
line 1473
;1473:			UI_DefTemplate_f();
ADDRGP4 UI_DefTemplate_f
CALLV
pop
line 1474
;1474:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $561
JUMPV
LABELV $604
line 1476
;1475:		}
;1476:		if (Q_stricmp(cmd, "templatescomplete") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $609
ARGP4
ADDRLP4 64
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
NEI4 $607
line 1477
;1477:			UI_TemplatesComplete_f();
ADDRGP4 UI_TemplatesComplete_f
CALLV
pop
line 1478
;1478:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $561
JUMPV
LABELV $607
line 1480
;1479:		}
;1480:	}
LABELV $598
line 1484
;1481:#endif
;1482:
;1483:#if MAPLENSFLARES	// JUHOX: commands for map lens flares
;1484:	if (Q_stricmp(cmd, "lfedit") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $612
ARGP4
ADDRLP4 56
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
NEI4 $610
line 1485
;1485:		UI_LFEdit_f();
ADDRGP4 UI_LFEdit_f
CALLV
pop
line 1486
;1486:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $561
JUMPV
LABELV $610
line 1491
;1487:	}
;1488:#endif
;1489:
;1490:#if TSSINCVAR	// JUHOX: commands for loading TSS files
;1491:	if (Q_stricmp(cmd, "tssdata") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $615
ARGP4
ADDRLP4 60
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
NEI4 $613
line 1492
;1492:		UI_TSSData_f();
ADDRGP4 UI_TSSData_f
CALLV
pop
line 1493
;1493:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $561
JUMPV
LABELV $613
line 1498
;1494:	}
;1495:#endif
;1496:
;1497:#if PLAYLIST	// JUHOX: playlist commands
;1498:	if (Q_stricmp(cmd, "addtrack") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $618
ARGP4
ADDRLP4 64
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
NEI4 $616
line 1499
;1499:		UI_AddTrack_f();
ADDRGP4 UI_AddTrack_f
CALLV
pop
line 1500
;1500:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $561
JUMPV
LABELV $616
line 1502
;1501:	}
;1502:	if (Q_stricmp(cmd, "playlistcomplete") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $621
ARGP4
ADDRLP4 68
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
NEI4 $619
line 1503
;1503:		UI_PlayListComplete_f();
ADDRGP4 UI_PlayListComplete_f
CALLV
pop
line 1504
;1504:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $561
JUMPV
LABELV $619
line 1508
;1505:	}
;1506:#endif
;1507:
;1508:	return qfalse;
CNSTI4 0
RETI4
LABELV $561
endproc UI_ConsoleCommand 72 8
export UI_Shutdown
proc UI_Shutdown 0 0
line 1516
;1509:}
;1510:
;1511:/*
;1512:=================
;1513:UI_Shutdown
;1514:=================
;1515:*/
;1516:void UI_Shutdown( void ) {
line 1517
;1517:}
LABELV $622
endproc UI_Shutdown 0 0
proc UI_LoadGameTemplates 1060 16
line 1524
;1518:
;1519:/*
;1520:=================
;1521:JUHOX: UI_LoadGameTemplates
;1522:=================
;1523:*/
;1524:static void UI_LoadGameTemplates(void) {
line 1530
;1525:	int i;
;1526:	const char* name;
;1527:	char buf[MAX_STRING_CHARS];
;1528:	char* p;
;1529:
;1530:	trap_Cvar_VariableStringBuffer("tmplfiles", buf, sizeof(buf));
ADDRGP4 $624
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1532
;1531:	//if (!trap_Cvar_VariableValue("sv_running")) {
;1532:	if (!buf[0]) {
ADDRLP4 12
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $625
line 1533
;1533:		uis.numTemplateFiles = trap_FS_GetFileList("templates", ".tmpl", uis.templateFileList, sizeof(uis.templateFileList));
ADDRGP4 $628
ARGP4
ADDRGP4 $489
ARGP4
ADDRGP4 uis+12528
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1036
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRGP4 uis+13552
ADDRLP4 1036
INDIRI4
ASGNI4
line 1535
;1534:
;1535:		p = buf;
ADDRLP4 4
ADDRLP4 12
ASGNP4
line 1536
;1536:		name = uis.templateFileList;
ADDRLP4 0
ADDRGP4 uis+12528
ASGNP4
line 1537
;1537:		trap_Cmd_ExecuteText(EXEC_INSERT, "templatescomplete\n");
CNSTI4 1
ARGI4
ADDRGP4 $632
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 1538
;1538:		for (i = 0; i < uis.numTemplateFiles; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $636
JUMPV
LABELV $633
line 1541
;1539:			int n;
;1540:
;1541:			uis.loadingTemplates = qtrue;
ADDRGP4 uis+11496
CNSTI4 1
ASGNI4
line 1542
;1542:			trap_Cmd_ExecuteText(EXEC_INSERT, va("tmplname %s; exec templates/%s\n", name, name));
ADDRGP4 $639
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1048
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 1
ARGI4
ADDRLP4 1048
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 1543
;1543:			n = strlen(name);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1052
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1040
ADDRLP4 1052
INDIRI4
ASGNI4
line 1544
;1544:			if (i > 0) *(p++) = '\\';
ADDRLP4 8
INDIRI4
CNSTI4 0
LEI4 $640
ADDRLP4 1056
ADDRLP4 4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 1056
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 1056
INDIRP4
CNSTI1 92
ASGNI1
LABELV $640
line 1545
;1545:			strcpy(p, name);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1546
;1546:			p += n;
ADDRLP4 4
ADDRLP4 1040
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
ASGNP4
line 1547
;1547:			name += n + 1;
ADDRLP4 0
ADDRLP4 1040
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 0
INDIRP4
ADDP4
ASGNP4
line 1548
;1548:		}
LABELV $634
line 1538
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $636
ADDRLP4 8
INDIRI4
ADDRGP4 uis+13552
INDIRI4
LTI4 $633
line 1549
;1549:		if (!buf[0]) Q_strncpyz(buf, "*", sizeof(buf));
ADDRLP4 12
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $642
ADDRLP4 12
ARGP4
ADDRGP4 $377
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
LABELV $642
line 1550
;1550:		trap_Cvar_Set("tmplfiles", buf);
ADDRGP4 $624
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1551
;1551:	}
ADDRGP4 $626
JUMPV
LABELV $625
line 1552
;1552:	else if (buf[0] != '*') {
ADDRLP4 12
INDIRI1
CVII4 1
CNSTI4 42
EQI4 $644
line 1554
;1553:		//trap_Cvar_VariableStringBuffer("tmplfiles", uis.templateFileList, sizeof(uis.templateFileList));
;1554:		Q_strncpyz(uis.templateFileList, buf, sizeof(uis.templateFileList));
ADDRGP4 uis+12528
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1555
;1555:		p = uis.templateFileList;
ADDRLP4 4
ADDRGP4 uis+12528
ASGNP4
line 1556
;1556:		uis.numTemplateFiles = 0;
ADDRGP4 uis+13552
CNSTI4 0
ASGNI4
ADDRGP4 $651
JUMPV
LABELV $650
line 1557
;1557:		while (*p) {
line 1558
;1558:			if (*p == '\\') {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 92
NEI4 $653
line 1559
;1559:				*p = 0;
ADDRLP4 4
INDIRP4
CNSTI1 0
ASGNI1
line 1560
;1560:				uis.numTemplateFiles++;
ADDRLP4 1036
ADDRGP4 uis+13552
ASGNP4
ADDRLP4 1036
INDIRP4
ADDRLP4 1036
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1561
;1561:			}
LABELV $653
line 1562
;1562:			p++;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1563
;1563:		}
LABELV $651
line 1557
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $650
line 1564
;1564:		if (p > uis.templateFileList) uis.numTemplateFiles++;
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRGP4 uis+12528
CVPU4 4
LEU4 $656
ADDRLP4 1036
ADDRGP4 uis+13552
ASGNP4
ADDRLP4 1036
INDIRP4
ADDRLP4 1036
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $656
line 1565
;1565:	}
LABELV $644
LABELV $626
line 1566
;1566:}
LABELV $623
endproc UI_LoadGameTemplates 1060 16
export UI_Init
proc UI_Init 76 16
line 1573
;1567:
;1568:/*
;1569:=================
;1570:UI_Init
;1571:=================
;1572:*/
;1573:void UI_Init( void ) {
line 1574
;1574:	UI_RegisterCvars();
ADDRGP4 UI_RegisterCvars
CALLV
pop
line 1578
;1575:
;1576:	// JUHOX: make sure cg_weaponOrderXXX cvars are up to date
;1577:#if MONSTER_MODE
;1578:	{
line 1581
;1579:		int i;
;1580:
;1581:		for (i = 0; i < 6; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $661
line 1585
;1582:			char name[32];
;1583:			char buf[32];
;1584:
;1585:			Com_sprintf(name, sizeof(name), "cg_weaponOrder%d", i);
ADDRLP4 4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $665
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1586
;1586:			trap_Cvar_VariableStringBuffer(name, buf, sizeof(buf));
ADDRLP4 4
ARGP4
ADDRLP4 36
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1587
;1587:			if (strlen(buf) < 10) {
ADDRLP4 36
ARGP4
ADDRLP4 68
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 10
GEI4 $666
line 1588
;1588:				trap_Cvar_Reset(name);
ADDRLP4 4
ARGP4
ADDRGP4 trap_Cvar_Reset
CALLV
pop
line 1589
;1589:				trap_Cvar_Reset(va("cg_weaponOrder%dName", i));
ADDRGP4 $668
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 72
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Reset
CALLV
pop
line 1590
;1590:			}
LABELV $666
line 1591
;1591:		}
LABELV $662
line 1581
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 6
LTI4 $661
line 1592
;1592:	}
line 1595
;1593:#endif
;1594:
;1595:	UI_InitGameinfo();
ADDRGP4 UI_InitGameinfo
CALLV
pop
line 1598
;1596:
;1597:	// cache redundant calulations
;1598:	trap_GetGlconfig( &uis.glconfig );
ADDRGP4 uis+56
ARGP4
ADDRGP4 trap_GetGlconfig
CALLV
pop
line 1613
;1599:
;1600:	// for 640x480 virtualized screen
;1601:	// JUHOX: wide screen option not very helpful; instead scale X & Y independent from each other
;1602:#if 0
;1603:	uis.scale = uis.glconfig.vidHeight * (1.0/480.0);
;1604:	if ( uis.glconfig.vidWidth * 480 > uis.glconfig.vidHeight * 640 ) {
;1605:		// wide screen
;1606:		uis.bias = 0.5 * ( uis.glconfig.vidWidth - ( uis.glconfig.vidHeight * (640.0/480.0) ) );
;1607:	}
;1608:	else {
;1609:		// no wide screen
;1610:		uis.bias = 0;
;1611:	}
;1612:#else
;1613:	uis.scaleX = uis.glconfig.vidWidth / 640.0;
ADDRGP4 uis+11476
ADDRGP4 uis+56+11304
INDIRI4
CVIF4 4
CNSTF4 986500301
MULF4
ASGNF4
line 1614
;1614:	uis.scaleY = uis.glconfig.vidHeight / 480.0;
ADDRGP4 uis+11480
ADDRGP4 uis+56+11308
INDIRI4
CVIF4 4
CNSTF4 990414985
MULF4
ASGNF4
line 1618
;1615:#endif
;1616:
;1617:	// initialize the menu system
;1618:	Menu_Cache();
ADDRGP4 Menu_Cache
CALLV
pop
line 1620
;1619:
;1620:	uis.activemenu = NULL;
ADDRGP4 uis+20
CNSTP4 0
ASGNP4
line 1621
;1621:	uis.menusp     = 0;
ADDRGP4 uis+16
CNSTI4 0
ASGNI4
line 1623
;1622:
;1623:	UI_LoadGameTemplates();	// JUHOX
ADDRGP4 UI_LoadGameTemplates
CALLV
pop
line 1627
;1624:
;1625:	// JUHOX: load playlist
;1626:#if PLAYLIST
;1627:	uis.loadPlayList = qtrue;
ADDRGP4 uis+95112
CNSTI4 1
ASGNI4
line 1628
;1628:	uis.currentTrack = 0;
ADDRGP4 uis+95116
CNSTI4 0
ASGNI4
line 1629
;1629:	trap_Cmd_ExecuteText(EXEC_INSERT, "exec playlist.cfg; playlistcomplete\n");
CNSTI4 1
ARGI4
ADDRGP4 $680
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 1631
;1630:#endif
;1631:}
LABELV $660
endproc UI_Init 76 16
export UI_AdjustFrom640
proc UI_AdjustFrom640 16 0
line 1640
;1632:
;1633:/*
;1634:================
;1635:UI_AdjustFrom640
;1636:
;1637:Adjusted for resolution and screen aspect ratio
;1638:================
;1639:*/
;1640:void UI_AdjustFrom640( float *x, float *y, float *w, float *h ) {
line 1649
;1641:	// expect valid pointers
;1642:	// JUHOX: apply the new scaling
;1643:#if 0
;1644:	*x = *x * uis.scale + uis.bias;
;1645:	*y *= uis.scale;
;1646:	*w *= uis.scale;
;1647:	*h *= uis.scale;
;1648:#else
;1649:	*x *= uis.scaleX;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRGP4 uis+11476
INDIRF4
MULF4
ASGNF4
line 1650
;1650:	*y *= uis.scaleY;
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRGP4 uis+11480
INDIRF4
MULF4
ASGNF4
line 1651
;1651:	*w *= uis.scaleX;
ADDRLP4 8
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
ADDRGP4 uis+11476
INDIRF4
MULF4
ASGNF4
line 1652
;1652:	*h *= uis.scaleY;
ADDRLP4 12
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
ADDRGP4 uis+11480
INDIRF4
MULF4
ASGNF4
line 1654
;1653:#endif
;1654:}
LABELV $681
endproc UI_AdjustFrom640 16 0
export UI_DrawNamedPic
proc UI_DrawNamedPic 8 36
line 1656
;1655:
;1656:void UI_DrawNamedPic( float x, float y, float width, float height, const char *picname ) {
line 1659
;1657:	qhandle_t	hShader;
;1658:
;1659:	hShader = trap_R_RegisterShaderNoMip( picname );
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 1660
;1660:	UI_AdjustFrom640( &x, &y, &width, &height );
ADDRFP4 0
ARGP4
ADDRFP4 4
ARGP4
ADDRFP4 8
ARGP4
ADDRFP4 12
ARGP4
ADDRGP4 UI_AdjustFrom640
CALLV
pop
line 1661
;1661:	trap_R_DrawStretchPic( x, y, width, height, 0, 0, 1, 1, hShader );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 1662
;1662:}
LABELV $686
endproc UI_DrawNamedPic 8 36
export UI_DrawHandlePic
proc UI_DrawHandlePic 16 36
line 1664
;1663:
;1664:void UI_DrawHandlePic( float x, float y, float w, float h, qhandle_t hShader ) {
line 1670
;1665:	float	s0;
;1666:	float	s1;
;1667:	float	t0;
;1668:	float	t1;
;1669:
;1670:	if( w < 0 ) {	// flip about vertical
ADDRFP4 8
INDIRF4
CNSTF4 0
GEF4 $688
line 1671
;1671:		w  = -w;
ADDRFP4 8
ADDRFP4 8
INDIRF4
NEGF4
ASGNF4
line 1672
;1672:		s0 = 1;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 1673
;1673:		s1 = 0;
ADDRLP4 4
CNSTF4 0
ASGNF4
line 1674
;1674:	}
ADDRGP4 $689
JUMPV
LABELV $688
line 1675
;1675:	else {
line 1676
;1676:		s0 = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 1677
;1677:		s1 = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 1678
;1678:	}
LABELV $689
line 1680
;1679:
;1680:	if( h < 0 ) {	// flip about horizontal
ADDRFP4 12
INDIRF4
CNSTF4 0
GEF4 $690
line 1681
;1681:		h  = -h;
ADDRFP4 12
ADDRFP4 12
INDIRF4
NEGF4
ASGNF4
line 1682
;1682:		t0 = 1;
ADDRLP4 8
CNSTF4 1065353216
ASGNF4
line 1683
;1683:		t1 = 0;
ADDRLP4 12
CNSTF4 0
ASGNF4
line 1684
;1684:	}
ADDRGP4 $691
JUMPV
LABELV $690
line 1685
;1685:	else {
line 1686
;1686:		t0 = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 1687
;1687:		t1 = 1;
ADDRLP4 12
CNSTF4 1065353216
ASGNF4
line 1688
;1688:	}
LABELV $691
line 1690
;1689:	
;1690:	UI_AdjustFrom640( &x, &y, &w, &h );
ADDRFP4 0
ARGP4
ADDRFP4 4
ARGP4
ADDRFP4 8
ARGP4
ADDRFP4 12
ARGP4
ADDRGP4 UI_AdjustFrom640
CALLV
pop
line 1691
;1691:	trap_R_DrawStretchPic( x, y, w, h, s0, t0, s1, t1, hShader );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 1692
;1692:}
LABELV $687
endproc UI_DrawHandlePic 16 36
export UI_FillRect
proc UI_FillRect 0 36
line 1701
;1693:
;1694:/*
;1695:================
;1696:UI_FillRect
;1697:
;1698:Coordinates are 640*480 virtual values
;1699:=================
;1700:*/
;1701:void UI_FillRect( float x, float y, float width, float height, const float *color ) {
line 1702
;1702:	trap_R_SetColor( color );
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1704
;1703:
;1704:	UI_AdjustFrom640( &x, &y, &width, &height );
ADDRFP4 0
ARGP4
ADDRFP4 4
ARGP4
ADDRFP4 8
ARGP4
ADDRFP4 12
ARGP4
ADDRGP4 UI_AdjustFrom640
CALLV
pop
line 1705
;1705:	trap_R_DrawStretchPic( x, y, width, height, 0, 0, 0, 0, uis.whiteShader );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 uis+11392
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 1707
;1706:
;1707:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1708
;1708:}
LABELV $692
endproc UI_FillRect 0 36
export UI_DrawRect
proc UI_DrawRect 0 36
line 1717
;1709:
;1710:/*
;1711:================
;1712:UI_DrawRect
;1713:
;1714:Coordinates are 640*480 virtual values
;1715:=================
;1716:*/
;1717:void UI_DrawRect( float x, float y, float width, float height, const float *color ) {
line 1718
;1718:	trap_R_SetColor( color );
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1720
;1719:
;1720:	UI_AdjustFrom640( &x, &y, &width, &height );
ADDRFP4 0
ARGP4
ADDRFP4 4
ARGP4
ADDRFP4 8
ARGP4
ADDRFP4 12
ARGP4
ADDRGP4 UI_AdjustFrom640
CALLV
pop
line 1722
;1721:
;1722:	trap_R_DrawStretchPic( x, y, width, 1, 0, 0, 0, 0, uis.whiteShader );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 uis+11392
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 1723
;1723:	trap_R_DrawStretchPic( x, y, 1, height, 0, 0, 0, 0, uis.whiteShader );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 uis+11392
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 1724
;1724:	trap_R_DrawStretchPic( x, y + height - 1, width, 1, 0, 0, 0, 0, uis.whiteShader );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ADDRFP4 12
INDIRF4
ADDF4
CNSTF4 1065353216
SUBF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 uis+11392
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 1725
;1725:	trap_R_DrawStretchPic( x + width - 1, y, 1, height, 0, 0, 0, 0, uis.whiteShader );
ADDRFP4 0
INDIRF4
ADDRFP4 8
INDIRF4
ADDF4
CNSTF4 1065353216
SUBF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 uis+11392
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 1727
;1726:
;1727:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1728
;1728:}
LABELV $694
endproc UI_DrawRect 0 36
export UI_SetColor
proc UI_SetColor 0 4
line 1730
;1729:
;1730:void UI_SetColor( const float *rgba ) {
line 1731
;1731:	trap_R_SetColor( rgba );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1732
;1732:}
LABELV $699
endproc UI_SetColor 0 4
export UI_UpdateScreen
proc UI_UpdateScreen 0 0
line 1734
;1733:
;1734:void UI_UpdateScreen( void ) {
line 1735
;1735:	trap_UpdateScreen();
ADDRGP4 trap_UpdateScreen
CALLV
pop
line 1736
;1736:}
LABELV $700
endproc UI_UpdateScreen 0 0
export UI_DrawBackPic
proc UI_DrawBackPic 16 36
line 1743
;1737:
;1738:/*
;1739:=================
;1740:JUHOX: UI_DrawBackPic
;1741:=================
;1742:*/
;1743:void UI_DrawBackPic(qboolean drawPic) {
line 1746
;1744:	float x, y, w, h;
;1745:
;1746:	if (!drawPic) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $702
line 1747
;1747:		UI_FillRect(0, 0, 640, 480, colorBlack);
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 1142947840
ARGF4
CNSTF4 1139802112
ARGF4
ADDRGP4 colorBlack
ARGP4
ADDRGP4 UI_FillRect
CALLV
pop
line 1748
;1748:	}
ADDRGP4 $703
JUMPV
LABELV $702
line 1749
;1749:	else {
line 1750
;1750:		x = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 1751
;1751:		y = 0;
ADDRLP4 4
CNSTF4 0
ASGNF4
line 1752
;1752:		w = 640;
ADDRLP4 8
CNSTF4 1142947840
ASGNF4
line 1753
;1753:		h = 480;
ADDRLP4 12
CNSTF4 1139802112
ASGNF4
line 1754
;1754:		UI_AdjustFrom640(&x, &y, &w, &h);
ADDRLP4 0
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 UI_AdjustFrom640
CALLV
pop
line 1755
;1755:		trap_R_DrawStretchPic(x, y, w, h, 0, 0, 1, 768.0/1024.0, uis.menuBackShader);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1061158912
ARGF4
ADDRGP4 uis+11396
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 1756
;1756:	}
LABELV $703
line 1757
;1757:}
LABELV $701
endproc UI_DrawBackPic 16 36
proc UI_LensFlare 32 36
line 1764
;1758:
;1759:/*
;1760:=================
;1761:JUHOX: UI_LensFlare
;1762:=================
;1763:*/
;1764:static void UI_LensFlare(float pos, qhandle_t shader, float radius, float r, float g, float b, float alpha) {
line 1768
;1765:	vec4_t color;
;1766:	float x, y, w, h;
;1767:
;1768:	color[0] = r;
ADDRLP4 0
ADDRFP4 12
INDIRF4
ASGNF4
line 1769
;1769:	color[1] = g;
ADDRLP4 0+4
ADDRFP4 16
INDIRF4
ASGNF4
line 1770
;1770:	color[2] = b;
ADDRLP4 0+8
ADDRFP4 20
INDIRF4
ASGNF4
line 1771
;1771:	color[3] = alpha / radius;
ADDRLP4 0+12
ADDRFP4 24
INDIRF4
ADDRFP4 8
INDIRF4
DIVF4
ASGNF4
line 1772
;1772:	if (color[3] > 1) color[3] = 1;
ADDRLP4 0+12
INDIRF4
CNSTF4 1065353216
LEF4 $709
ADDRLP4 0+12
CNSTF4 1065353216
ASGNF4
LABELV $709
line 1773
;1773:	trap_R_SetColor(color);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1775
;1774:
;1775:	radius *= 64;
ADDRFP4 8
ADDRFP4 8
INDIRF4
CNSTF4 1115684864
MULF4
ASGNF4
line 1776
;1776:	x = 320 + pos * (uis.cursorx - 320) - 0.5 * radius;
ADDRLP4 16
ADDRFP4 0
INDIRF4
ADDRGP4 uis+8
INDIRI4
CNSTI4 320
SUBI4
CVIF4 4
MULF4
CNSTF4 1134559232
ADDF4
ADDRFP4 8
INDIRF4
CNSTF4 1056964608
MULF4
SUBF4
ASGNF4
line 1777
;1777:	y = 240 + pos * (uis.cursory - 240) - 0.5 * radius;
ADDRLP4 20
ADDRFP4 0
INDIRF4
ADDRGP4 uis+12
INDIRI4
CNSTI4 240
SUBI4
CVIF4 4
MULF4
CNSTF4 1131413504
ADDF4
ADDRFP4 8
INDIRF4
CNSTF4 1056964608
MULF4
SUBF4
ASGNF4
line 1778
;1778:	w = radius;
ADDRLP4 24
ADDRFP4 8
INDIRF4
ASGNF4
line 1779
;1779:	h = radius;
ADDRLP4 28
ADDRFP4 8
INDIRF4
ASGNF4
line 1780
;1780:	UI_AdjustFrom640(&x, &y, &w, &h);
ADDRLP4 16
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 28
ARGP4
ADDRGP4 UI_AdjustFrom640
CALLV
pop
line 1781
;1781:	trap_R_DrawStretchPic(x, y, w, h, 0, 0, 1, 1, shader);
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 1782
;1782:}
LABELV $705
endproc UI_LensFlare 32 36
proc UI_CursorLensFlares 4 28
line 1789
;1783:
;1784:/*
;1785:=================
;1786:JUHOX: UI_CursorLensFlares
;1787:=================
;1788:*/
;1789:static void UI_CursorLensFlares(void) {
line 1790
;1790:	const float alpha = 0.09;
ADDRLP4 0
CNSTF4 1035489772
ASGNF4
line 1792
;1791:
;1792:	UI_LensFlare(3, uis.lfRing, 1.7, 1, 1, 1, alpha);
CNSTF4 1077936128
ARGF4
ADDRGP4 uis+11460
INDIRI4
ARGI4
CNSTF4 1071225242
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 UI_LensFlare
CALLV
pop
line 1793
;1793:	UI_LensFlare(1.5, uis.lfDisc, 0.9, 1, 0.667, 0.667, alpha);
CNSTF4 1069547520
ARGF4
ADDRGP4 uis+11464
INDIRI4
ARGI4
CNSTF4 1063675494
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1059766403
ARGF4
CNSTF4 1059766403
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 UI_LensFlare
CALLV
pop
line 1794
;1794:	UI_LensFlare(1, uis.lfGlare, 0.5, 1, 1, 1, 2.5 * alpha);
CNSTF4 1065353216
ARGF4
ADDRGP4 uis+11468
INDIRI4
ARGI4
CNSTF4 1056964608
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 0
INDIRF4
CNSTF4 1075838976
MULF4
ARGF4
ADDRGP4 UI_LensFlare
CALLV
pop
line 1800
;1795:	/*
;1796:	UI_LensFlare(1, uis.cursorCore1, 0.5, 1, 1, 1, 0.15 * alpha);
;1797:	UI_LensFlare(1, uis.cursorCore2, 0.5, 1, 1, 1, 0.15 * alpha);
;1798:	UI_LensFlare(1, uis.cursorCore3, 0.5, 1, 1, 1, 0.15 * alpha);
;1799:	*/
;1800:	UI_LensFlare(1, uis.lfGlare, 0.8, 0.5, 0.7, 1, 5 * alpha);
CNSTF4 1065353216
ARGF4
ADDRGP4 uis+11468
INDIRI4
ARGI4
CNSTF4 1061997773
ARGF4
CNSTF4 1056964608
ARGF4
CNSTF4 1060320051
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 0
INDIRF4
CNSTF4 1084227584
MULF4
ARGF4
ADDRGP4 UI_LensFlare
CALLV
pop
line 1801
;1801:	UI_LensFlare(1, uis.lfGlare, 2, 1, 1, 1, 5 * alpha);
CNSTF4 1065353216
ARGF4
ADDRGP4 uis+11468
INDIRI4
ARGI4
CNSTF4 1073741824
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 0
INDIRF4
CNSTF4 1084227584
MULF4
ARGF4
ADDRGP4 UI_LensFlare
CALLV
pop
line 1802
;1802:	UI_LensFlare(1, uis.lfStar, 1.5, 1, 1, 1, 5 * alpha);
CNSTF4 1065353216
ARGF4
ADDRGP4 uis+11472
INDIRI4
ARGI4
CNSTF4 1069547520
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 0
INDIRF4
CNSTF4 1084227584
MULF4
ARGF4
ADDRGP4 UI_LensFlare
CALLV
pop
line 1803
;1803:	UI_LensFlare(0.5, uis.lfDisc, 1.5, 0.667, 1, 1, alpha);
CNSTF4 1056964608
ARGF4
ADDRGP4 uis+11464
INDIRI4
ARGI4
CNSTF4 1069547520
ARGF4
CNSTF4 1059766403
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 UI_LensFlare
CALLV
pop
line 1804
;1804:	UI_LensFlare(0.3, uis.lfRing, 1, 0.75, 1, 0.75, alpha);
CNSTF4 1050253722
ARGF4
ADDRGP4 uis+11460
INDIRI4
ARGI4
CNSTF4 1065353216
ARGF4
CNSTF4 1061158912
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1061158912
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 UI_LensFlare
CALLV
pop
line 1805
;1805:	UI_LensFlare(0.07, uis.lfDisc, 0.7, 0.82, 1, 0.92, alpha);
CNSTF4 1032805417
ARGF4
ADDRGP4 uis+11464
INDIRI4
ARGI4
CNSTF4 1060320051
ARGF4
CNSTF4 1062333317
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1064011039
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 UI_LensFlare
CALLV
pop
line 1806
;1806:	UI_LensFlare(-0.25, uis.lfRing, 1.4, 0.9, 1, 1, alpha);
CNSTF4 3196059648
ARGF4
ADDRGP4 uis+11460
INDIRI4
ARGI4
CNSTF4 1068708659
ARGF4
CNSTF4 1063675494
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 UI_LensFlare
CALLV
pop
line 1807
;1807:	UI_LensFlare(-0.45, uis.lfDisc, 0.2, 0.75, 1, 1, alpha);
CNSTF4 3202770534
ARGF4
ADDRGP4 uis+11464
INDIRI4
ARGI4
CNSTF4 1045220557
ARGF4
CNSTF4 1061158912
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 UI_LensFlare
CALLV
pop
line 1808
;1808:	UI_LensFlare(-0.6, uis.lfDisc, 0.4, 1, 0.78, 1, alpha);
CNSTF4 3206125978
ARGF4
ADDRGP4 uis+11464
INDIRI4
ARGI4
CNSTF4 1053609165
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1061662228
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 UI_LensFlare
CALLV
pop
line 1809
;1809:	UI_LensFlare(-0.72, uis.lfDisc, 1.1, 1, 0.78, 0.667, alpha);
CNSTF4 3208139244
ARGF4
ADDRGP4 uis+11464
INDIRI4
ARGI4
CNSTF4 1066192077
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1061662228
ARGF4
CNSTF4 1059766403
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 UI_LensFlare
CALLV
pop
line 1810
;1810:	UI_LensFlare(-1.0, uis.lfRing, 2, 1, 1, 0.5, alpha);
CNSTF4 3212836864
ARGF4
ADDRGP4 uis+11460
INDIRI4
ARGI4
CNSTF4 1073741824
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1056964608
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 UI_LensFlare
CALLV
pop
line 1811
;1811:	UI_LensFlare(-3.4, uis.lfDisc, 1.3, 0.92, 0.96, 1, alpha);
CNSTF4 3227097498
ARGF4
ADDRGP4 uis+11464
INDIRI4
ARGI4
CNSTF4 1067869798
ARGF4
CNSTF4 1064011039
ARGF4
CNSTF4 1064682127
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 UI_LensFlare
CALLV
pop
line 1813
;1812:
;1813:	trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1814
;1814:}
LABELV $715
endproc UI_CursorLensFlares 4 28
data
align 4
LABELV $767
byte 4 0
byte 4 0
byte 4 0
byte 4 1057803469
export UI_Refresh
code
proc UI_Refresh 8 20
line 1822
;1815:
;1816:/*
;1817:=================
;1818:UI_Refresh
;1819:=================
;1820:*/
;1821:void UI_Refresh( int realtime )
;1822:{
line 1823
;1823:	uis.frametime = realtime - uis.realtime;
ADDRGP4 uis
ADDRFP4 0
INDIRI4
ADDRGP4 uis+4
INDIRI4
SUBI4
ASGNI4
line 1824
;1824:	uis.realtime  = realtime;
ADDRGP4 uis+4
ADDRFP4 0
INDIRI4
ASGNI4
line 1826
;1825:
;1826:	if ( !( trap_Key_GetCatcher() & KEYCATCH_UI ) ) {
ADDRLP4 0
ADDRGP4 trap_Key_GetCatcher
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $734
line 1827
;1827:		return;
ADDRGP4 $731
JUMPV
LABELV $734
line 1832
;1828:	}
;1829:
;1830:	// JUHOX: draw precaching pacifier
;1831:#if 1
;1832:	if (uis.precaching) {
ADDRGP4 uis+95104
INDIRI4
CNSTI4 0
EQI4 $736
line 1833
;1833:		UI_FillRect(0, 0, 640, 480, colorBlack);
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 1142947840
ARGF4
CNSTF4 1139802112
ARGF4
ADDRGP4 colorBlack
ARGP4
ADDRGP4 UI_FillRect
CALLV
pop
line 1834
;1834:		UI_DrawString(320, 180, "PRECACHING...", UI_CENTER, colorWhite);
CNSTI4 320
ARGI4
CNSTI4 180
ARGI4
ADDRGP4 $739
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 1835
;1835:		switch (uis.precaching) {
ADDRLP4 4
ADDRGP4 uis+95104
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 1
EQI4 $743
ADDRLP4 4
INDIRI4
CNSTI4 2
EQI4 $745
ADDRGP4 $731
JUMPV
LABELV $743
line 1837
;1836:		case 1:
;1837:			uis.precaching = 2;
ADDRGP4 uis+95104
CNSTI4 2
ASGNI4
line 1838
;1838:			break;
ADDRGP4 $731
JUMPV
LABELV $745
line 1840
;1839:		case 2:
;1840:			uis.precaching = 0;
ADDRGP4 uis+95104
CNSTI4 0
ASGNI4
line 1841
;1841:			UI_Cache_f();
ADDRGP4 UI_Cache_f
CALLV
pop
line 1842
;1842:			break;
line 1844
;1843:		}
;1844:		return;
ADDRGP4 $731
JUMPV
LABELV $736
line 1850
;1845:	}
;1846:#endif
;1847:
;1848:	// JUHOX: no UI drawing with TSS Interface open
;1849:#if 1
;1850:	if (uis.tssInterfaceOpen) {
ADDRGP4 uis+11492
INDIRI4
CNSTI4 0
EQI4 $747
line 1851
;1851:		if (uis.activemenu) {
ADDRGP4 uis+20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $731
line 1852
;1852:			UI_CloseTSSInterface();
ADDRGP4 UI_CloseTSSInterface
CALLV
pop
line 1853
;1853:		}
line 1854
;1854:		return;
ADDRGP4 $731
JUMPV
LABELV $747
line 1858
;1855:	}
;1856:#endif
;1857:
;1858:	UI_UpdateCvars();
ADDRGP4 UI_UpdateCvars
CALLV
pop
line 1860
;1859:
;1860:	if ( uis.activemenu )
ADDRGP4 uis+20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $753
line 1861
;1861:	{
line 1862
;1862:		if (uis.activemenu->fullscreen)
ADDRGP4 uis+20
INDIRP4
CNSTI4 408
ADDP4
INDIRI4
CNSTI4 0
EQI4 $756
line 1863
;1863:		{
line 1874
;1864:			// draw the background
;1865:			// JUHOX: new background
;1866:#if 0
;1867:			if( uis.activemenu->showlogo ) {
;1868:				UI_DrawHandlePic( 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, uis.menuBackShader );
;1869:			}
;1870:			else {
;1871:				UI_DrawHandlePic( 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, uis.menuBackNoLogoShader );
;1872:			}
;1873:#else
;1874:			UI_DrawBackPic(!uis.activemenu->blackBack);
ADDRGP4 uis+20
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
CNSTI4 0
NEI4 $761
ADDRLP4 4
CNSTI4 1
ASGNI4
ADDRGP4 $762
JUMPV
LABELV $761
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $762
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 UI_DrawBackPic
CALLV
pop
line 1876
;1875:
;1876:			if (uis.activemenu->showlogo) {
ADDRGP4 uis+20
INDIRP4
CNSTI4 412
ADDP4
INDIRI4
CNSTI4 0
EQI4 $763
line 1877
;1877:				UI_DrawHandlePic(30, 35, 580, 36, uis.menuBackTitleShader);	// "H U N T"
CNSTF4 1106247680
ARGF4
CNSTF4 1108082688
ARGF4
CNSTF4 1141964800
ARGF4
CNSTF4 1108344832
ARGF4
ADDRGP4 uis+11400
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1878
;1878:			}
ADDRGP4 $764
JUMPV
LABELV $763
line 1879
;1879:			else {
line 1882
;1880:				static float darken[4] = {0, 0, 0, 0.55};
;1881:
;1882:				UI_FillRect(0, 0, 640, 480, darken);
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 1142947840
ARGF4
CNSTF4 1139802112
ARGF4
ADDRGP4 $767
ARGP4
ADDRGP4 UI_FillRect
CALLV
pop
line 1883
;1883:			}
LABELV $764
line 1885
;1884:#endif
;1885:		}
LABELV $756
line 1887
;1886:
;1887:		if (uis.activemenu->draw)
ADDRGP4 uis+20
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $768
line 1888
;1888:			uis.activemenu->draw();
ADDRGP4 uis+20
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
CALLV
pop
ADDRGP4 $769
JUMPV
LABELV $768
line 1890
;1889:		else
;1890:			Menu_Draw( uis.activemenu );
ADDRGP4 uis+20
INDIRP4
ARGP4
ADDRGP4 Menu_Draw
CALLV
pop
LABELV $769
line 1892
;1891:
;1892:		if( uis.firstdraw ) {
ADDRGP4 uis+11488
INDIRI4
CNSTI4 0
EQI4 $773
line 1893
;1893:			UI_MouseEvent( 0, 0 );
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 UI_MouseEvent
CALLV
pop
line 1894
;1894:			uis.firstdraw = qfalse;
ADDRGP4 uis+11488
CNSTI4 0
ASGNI4
line 1895
;1895:		}
LABELV $773
line 1896
;1896:	}
LABELV $753
line 1904
;1897:
;1898:	// draw cursor
;1899:	// JUHOX: draw lens flare cursor
;1900:#if 0
;1901:	UI_SetColor( NULL );
;1902:	UI_DrawHandlePic( uis.cursorx-16, uis.cursory-16, 32, 32, uis.cursor);
;1903:#else
;1904:	if (uis.activemenu && uis.activemenu->noCursor) {
ADDRGP4 uis+20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $777
ADDRGP4 uis+20
INDIRP4
CNSTI4 420
ADDP4
INDIRI4
CNSTI4 0
EQI4 $777
line 1906
;1905:		// no cursor
;1906:	}
ADDRGP4 $778
JUMPV
LABELV $777
line 1907
;1907:	else if (ui_lensFlare.integer) {
ADDRGP4 ui_lensFlare+12
INDIRI4
CNSTI4 0
EQI4 $781
line 1908
;1908:		UI_CursorLensFlares();
ADDRGP4 UI_CursorLensFlares
CALLV
pop
line 1909
;1909:	}
ADDRGP4 $782
JUMPV
LABELV $781
line 1911
;1910:	else
;1911:	{
line 1912
;1912:		UI_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 UI_SetColor
CALLV
pop
line 1913
;1913:		UI_DrawHandlePic( uis.cursorx-16, uis.cursory-16, 32, 32, uis.cursor);
ADDRGP4 uis+8
INDIRI4
CNSTI4 16
SUBI4
CVIF4 4
ARGF4
ADDRGP4 uis+12
INDIRI4
CNSTI4 16
SUBI4
CVIF4 4
ARGF4
CNSTF4 1107296256
ARGF4
CNSTF4 1107296256
ARGF4
ADDRGP4 uis+11448
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1914
;1914:	}
LABELV $782
LABELV $778
line 1918
;1915:#endif
;1916:
;1917:#ifndef NDEBUG
;1918:	if (uis.debug)
ADDRGP4 uis+11388
INDIRI4
CNSTI4 0
EQI4 $787
line 1919
;1919:	{
line 1921
;1920:		// cursor coordinates
;1921:		UI_DrawString( 0, 0, va("(%d,%d)",uis.cursorx,uis.cursory), UI_LEFT|UI_SMALLFONT, colorRed );
ADDRGP4 $790
ARGP4
ADDRGP4 uis+8
INDIRI4
ARGI4
ADDRGP4 uis+12
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 colorRed
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 1922
;1922:	}
LABELV $787
line 1928
;1923:#endif
;1924:
;1925:	// delay playing the enter sound until after the
;1926:	// menu has been drawn, to avoid delay while
;1927:	// caching images
;1928:	if (m_entersound)
ADDRGP4 m_entersound
INDIRI4
CNSTI4 0
EQI4 $793
line 1929
;1929:	{
line 1930
;1930:		trap_S_StartLocalSound( menu_in_sound, CHAN_LOCAL_SOUND );
ADDRGP4 menu_in_sound
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 1931
;1931:		m_entersound = qfalse;
ADDRGP4 m_entersound
CNSTI4 0
ASGNI4
line 1932
;1932:	}
LABELV $793
line 1933
;1933:}
LABELV $731
endproc UI_Refresh 8 20
export UI_DrawTextBox
proc UI_DrawTextBox 0 20
line 1936
;1934:
;1935:void UI_DrawTextBox (int x, int y, int width, int lines)
;1936:{
line 1937
;1937:	UI_FillRect( x + BIGCHAR_WIDTH/2, y + BIGCHAR_HEIGHT/2, ( width + 1 ) * BIGCHAR_WIDTH, ( lines + 1 ) * BIGCHAR_HEIGHT, colorBlack );
ADDRFP4 0
INDIRI4
CNSTI4 8
ADDI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CNSTI4 8
ADDI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 16
ADDI4
CVIF4 4
ARGF4
ADDRFP4 12
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 16
ADDI4
CVIF4 4
ARGF4
ADDRGP4 colorBlack
ARGP4
ADDRGP4 UI_FillRect
CALLV
pop
line 1938
;1938:	UI_DrawRect( x + BIGCHAR_WIDTH/2, y + BIGCHAR_HEIGHT/2, ( width + 1 ) * BIGCHAR_WIDTH, ( lines + 1 ) * BIGCHAR_HEIGHT, colorWhite );
ADDRFP4 0
INDIRI4
CNSTI4 8
ADDI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CNSTI4 8
ADDI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 16
ADDI4
CVIF4 4
ARGF4
ADDRFP4 12
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 16
ADDI4
CVIF4 4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawRect
CALLV
pop
line 1939
;1939:}
LABELV $795
endproc UI_DrawTextBox 0 20
export UI_CursorInRect
proc UI_CursorInRect 8 0
line 1942
;1940:
;1941:qboolean UI_CursorInRect (int x, int y, int width, int height)
;1942:{
line 1943
;1943:	if (uis.cursorx < x ||
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRGP4 uis+8
INDIRI4
ADDRLP4 0
INDIRI4
LTI4 $805
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRGP4 uis+12
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $805
ADDRGP4 uis+8
INDIRI4
ADDRLP4 0
INDIRI4
ADDRFP4 8
INDIRI4
ADDI4
GTI4 $805
ADDRGP4 uis+12
INDIRI4
ADDRLP4 4
INDIRI4
ADDRFP4 12
INDIRI4
ADDI4
LEI4 $797
LABELV $805
line 1947
;1944:		uis.cursory < y ||
;1945:		uis.cursorx > x+width ||
;1946:		uis.cursory > y+height)
;1947:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $796
JUMPV
LABELV $797
line 1949
;1948:
;1949:	return qtrue;
CNSTI4 1
RETI4
LABELV $796
endproc UI_CursorInRect 8 0
bss
align 4
LABELV tssiMouseEvents
skip 128
align 4
LABELV tssiKeyEvents
skip 128
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
export uis
align 4
LABELV uis
skip 95120
export m_entersound
align 4
LABELV m_entersound
skip 4
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
LABELV $790
byte 1 40
byte 1 37
byte 1 100
byte 1 44
byte 1 37
byte 1 100
byte 1 41
byte 1 0
align 1
LABELV $739
byte 1 80
byte 1 82
byte 1 69
byte 1 67
byte 1 65
byte 1 67
byte 1 72
byte 1 73
byte 1 78
byte 1 71
byte 1 46
byte 1 46
byte 1 46
byte 1 0
align 1
LABELV $680
byte 1 101
byte 1 120
byte 1 101
byte 1 99
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 59
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 108
byte 1 101
byte 1 116
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $668
byte 1 99
byte 1 103
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 79
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 37
byte 1 100
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $665
byte 1 99
byte 1 103
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 79
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $639
byte 1 116
byte 1 109
byte 1 112
byte 1 108
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 59
byte 1 32
byte 1 101
byte 1 120
byte 1 101
byte 1 99
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
byte 1 47
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $632
byte 1 116
byte 1 101
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 101
byte 1 115
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 108
byte 1 101
byte 1 116
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $628
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
LABELV $624
byte 1 116
byte 1 109
byte 1 112
byte 1 108
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $621
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 108
byte 1 101
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $618
byte 1 97
byte 1 100
byte 1 100
byte 1 116
byte 1 114
byte 1 97
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $615
byte 1 116
byte 1 115
byte 1 115
byte 1 100
byte 1 97
byte 1 116
byte 1 97
byte 1 0
align 1
LABELV $612
byte 1 108
byte 1 102
byte 1 101
byte 1 100
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $609
byte 1 116
byte 1 101
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 101
byte 1 115
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 108
byte 1 101
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $606
byte 1 100
byte 1 101
byte 1 102
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
LABELV $603
byte 1 116
byte 1 109
byte 1 112
byte 1 108
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $597
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
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 108
byte 1 101
byte 1 116
byte 1 101
byte 1 95
byte 1 117
byte 1 105
byte 1 0
align 1
LABELV $594
byte 1 115
byte 1 118
byte 1 95
byte 1 116
byte 1 101
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 101
byte 1 95
byte 1 117
byte 1 105
byte 1 0
align 1
LABELV $591
byte 1 116
byte 1 115
byte 1 115
byte 1 105
byte 1 99
byte 1 108
byte 1 111
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $588
byte 1 116
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 112
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $585
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 100
byte 1 107
byte 1 101
byte 1 121
byte 1 0
align 1
LABELV $582
byte 1 105
byte 1 97
byte 1 109
byte 1 97
byte 1 109
byte 1 111
byte 1 110
byte 1 107
byte 1 101
byte 1 121
byte 1 0
align 1
LABELV $579
byte 1 105
byte 1 97
byte 1 109
byte 1 97
byte 1 99
byte 1 104
byte 1 101
byte 1 97
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $576
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 79
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $573
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 105
byte 1 110
byte 1 101
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 99
byte 1 115
byte 1 0
align 1
LABELV $570
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 97
byte 1 99
byte 1 104
byte 1 101
byte 1 0
align 1
LABELV $567
byte 1 112
byte 1 111
byte 1 115
byte 1 116
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $564
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 115
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $556
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 37
byte 1 48
byte 1 50
byte 1 100
byte 1 0
align 1
LABELV $555
byte 1 105
byte 1 110
byte 1 116
byte 1 114
byte 1 111
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 109
byte 1 97
byte 1 105
byte 1 110
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 114
byte 1 101
byte 1 112
byte 1 92
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $542
byte 1 116
byte 1 115
byte 1 115
byte 1 112
byte 1 97
byte 1 107
byte 1 37
byte 1 48
byte 1 51
byte 1 100
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $534
byte 1 116
byte 1 115
byte 1 115
byte 1 112
byte 1 97
byte 1 107
byte 1 37
byte 1 48
byte 1 51
byte 1 100
byte 1 110
byte 1 0
align 1
LABELV $531
byte 1 116
byte 1 115
byte 1 115
byte 1 116
byte 1 109
byte 1 112
byte 1 0
align 1
LABELV $524
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
byte 1 100
byte 1 101
byte 1 118
byte 1 109
byte 1 97
byte 1 112
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $523
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
LABELV $522
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
LABELV $521
byte 1 115
byte 1 118
byte 1 95
byte 1 112
byte 1 117
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $520
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
LABELV $519
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
LABELV $506
byte 1 37
byte 1 115
byte 1 37
byte 1 48
byte 1 51
byte 1 100
byte 1 0
align 1
LABELV $503
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $489
byte 1 46
byte 1 116
byte 1 109
byte 1 112
byte 1 108
byte 1 0
align 1
LABELV $378
byte 1 116
byte 1 115
byte 1 115
byte 1 105
byte 1 95
byte 1 107
byte 1 101
byte 1 121
byte 1 0
align 1
LABELV $377
byte 1 42
byte 1 0
align 1
LABELV $376
byte 1 116
byte 1 115
byte 1 115
byte 1 105
byte 1 95
byte 1 109
byte 1 111
byte 1 117
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $373
byte 1 37
byte 1 100
byte 1 47
byte 1 37
byte 1 100
byte 1 47
byte 1 37
byte 1 100
byte 1 47
byte 1 0
align 1
LABELV $368
byte 1 37
byte 1 100
byte 1 47
byte 1 0
align 1
LABELV $364
byte 1 0
align 1
LABELV $359
byte 1 85
byte 1 73
byte 1 95
byte 1 83
byte 1 101
byte 1 116
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 101
byte 1 77
byte 1 101
byte 1 110
byte 1 117
byte 1 58
byte 1 32
byte 1 98
byte 1 97
byte 1 100
byte 1 32
byte 1 101
byte 1 110
byte 1 117
byte 1 109
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $357
byte 1 49
byte 1 0
align 1
LABELV $355
byte 1 66
byte 1 97
byte 1 100
byte 1 32
byte 1 67
byte 1 68
byte 1 32
byte 1 75
byte 1 101
byte 1 121
byte 1 0
align 1
LABELV $353
byte 1 73
byte 1 110
byte 1 115
byte 1 101
byte 1 114
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 67
byte 1 68
byte 1 0
align 1
LABELV $342
byte 1 113
byte 1 117
byte 1 105
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $153
byte 1 48
byte 1 0
align 1
LABELV $152
byte 1 99
byte 1 108
byte 1 95
byte 1 112
byte 1 97
byte 1 117
byte 1 115
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $140
byte 1 85
byte 1 73
byte 1 95
byte 1 80
byte 1 111
byte 1 112
byte 1 77
byte 1 101
byte 1 110
byte 1 117
byte 1 58
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 115
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 117
byte 1 110
byte 1 100
byte 1 101
byte 1 114
byte 1 102
byte 1 108
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $124
byte 1 85
byte 1 73
byte 1 95
byte 1 80
byte 1 117
byte 1 115
byte 1 104
byte 1 77
byte 1 101
byte 1 110
byte 1 117
byte 1 58
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 115
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 102
byte 1 108
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $107
byte 1 100
byte 1 49
byte 1 10
byte 1 0
align 1
LABELV $98
byte 1 37
byte 1 115
byte 1 0
