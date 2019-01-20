code
proc UI_CreditMenu_Key 0 8
file "..\..\..\..\code\q3_ui\ui_credits.c"
line 27
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:/*
;4:=======================================================================
;5:
;6:CREDITS
;7:
;8:=======================================================================
;9:*/
;10:
;11:
;12:#include "ui_local.h"
;13:
;14:
;15:typedef struct {
;16:	menuframework_s	menu;
;17:} creditsmenu_t;
;18:
;19:static creditsmenu_t	s_credits;
;20:
;21:
;22:/*
;23:=================
;24:UI_CreditMenu_Key
;25:=================
;26:*/
;27:static sfxHandle_t UI_CreditMenu_Key( int key ) {
line 28
;28:	if( key & K_CHAR_FLAG ) {
ADDRFP4 0
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $98
line 29
;29:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $97
JUMPV
LABELV $98
line 32
;30:	}
;31:
;32:	trap_Cmd_ExecuteText( EXEC_APPEND, "quit\n" );
CNSTI4 2
ARGI4
ADDRGP4 $100
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 33
;33:	return 0;
CNSTI4 0
RETI4
LABELV $97
endproc UI_CreditMenu_Key 0 8
proc UI_CreditMenu_Draw 4 20
line 42
;34:}
;35:
;36:
;37:/*
;38:===============
;39:UI_CreditMenu_Draw
;40:===============
;41:*/
;42:static void UI_CreditMenu_Draw( void ) {
line 45
;43:	int		y;
;44:
;45:	y = 12;
ADDRLP4 0
CNSTI4 12
ASGNI4
line 46
;46:	UI_DrawProportionalString( 320, y, "id Software is:", UI_CENTER|UI_SMALLFONT, color_white );
CNSTI4 320
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $102
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 48
;47:
;48:	y += 1.42 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1105594941
ADDF4
CVFI4 4
ASGNI4
line 49
;49:	UI_DrawProportionalString( 320, y, "Programming", UI_CENTER|UI_SMALLFONT, color_white );
CNSTI4 320
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $103
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 50
;50:	y += PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1101135872
ADDF4
CVFI4 4
ASGNI4
line 51
;51:	UI_DrawProportionalString( 320, y, "John Carmack, Robert A. Duffy, Jim Dose'", UI_CENTER|UI_SMALLFONT, color_white );
CNSTI4 320
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $104
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 53
;52:
;53:	y += 1.42 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1105594941
ADDF4
CVFI4 4
ASGNI4
line 54
;54:	UI_DrawProportionalString( 320, y, "Art", UI_CENTER|UI_SMALLFONT, color_white );
CNSTI4 320
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $105
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 55
;55:	y += PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1101135872
ADDF4
CVFI4 4
ASGNI4
line 56
;56:	UI_DrawProportionalString( 320, y, "Adrian Carmack, Kevin Cloud,", UI_CENTER|UI_SMALLFONT, color_white );
CNSTI4 320
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $106
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 57
;57:	y += PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1101135872
ADDF4
CVFI4 4
ASGNI4
line 58
;58:	UI_DrawProportionalString( 320, y, "Kenneth Scott, Seneca Menard, Fred Nilsson", UI_CENTER|UI_SMALLFONT, color_white );
CNSTI4 320
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $107
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 60
;59:
;60:	y += 1.42 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1105594941
ADDF4
CVFI4 4
ASGNI4
line 61
;61:	UI_DrawProportionalString( 320, y, "Game Designer", UI_CENTER|UI_SMALLFONT, color_white );
CNSTI4 320
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $108
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 62
;62:	y += PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1101135872
ADDF4
CVFI4 4
ASGNI4
line 63
;63:	UI_DrawProportionalString( 320, y, "Graeme Devine", UI_CENTER|UI_SMALLFONT, color_white );
CNSTI4 320
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $109
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 65
;64:
;65:	y += 1.42 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1105594941
ADDF4
CVFI4 4
ASGNI4
line 66
;66:	UI_DrawProportionalString( 320, y, "Level Design", UI_CENTER|UI_SMALLFONT, color_white );
CNSTI4 320
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $110
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 67
;67:	y += PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1101135872
ADDF4
CVFI4 4
ASGNI4
line 68
;68:	UI_DrawProportionalString( 320, y, "Tim Willits, Christian Antkow, Paul Jaquays", UI_CENTER|UI_SMALLFONT, color_white );
CNSTI4 320
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $111
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 70
;69:
;70:	y += 1.42 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1105594941
ADDF4
CVFI4 4
ASGNI4
line 71
;71:	UI_DrawProportionalString( 320, y, "CEO", UI_CENTER|UI_SMALLFONT, color_white );
CNSTI4 320
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $112
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 72
;72:	y += PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1101135872
ADDF4
CVFI4 4
ASGNI4
line 73
;73:	UI_DrawProportionalString( 320, y, "Todd Hollenshead", UI_CENTER|UI_SMALLFONT, color_white );
CNSTI4 320
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $113
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 75
;74:
;75:	y += 1.42 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1105594941
ADDF4
CVFI4 4
ASGNI4
line 76
;76:	UI_DrawProportionalString( 320, y, "Director of Business Development", UI_CENTER|UI_SMALLFONT, color_white );
CNSTI4 320
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $114
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 77
;77:	y += PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1101135872
ADDF4
CVFI4 4
ASGNI4
line 78
;78:	UI_DrawProportionalString( 320, y, "Marty Stratton", UI_CENTER|UI_SMALLFONT, color_white );
CNSTI4 320
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $115
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 80
;79:
;80:	y += 1.42 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1105594941
ADDF4
CVFI4 4
ASGNI4
line 81
;81:	UI_DrawProportionalString( 320, y, "Biz Assist and id Mom", UI_CENTER|UI_SMALLFONT, color_white );
CNSTI4 320
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $116
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 82
;82:	y += PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1101135872
ADDF4
CVFI4 4
ASGNI4
line 83
;83:	UI_DrawProportionalString( 320, y, "Donna Jackson", UI_CENTER|UI_SMALLFONT, color_white );
CNSTI4 320
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $117
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 85
;84:
;85:	y += 1.42 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1105594941
ADDF4
CVFI4 4
ASGNI4
line 86
;86:	UI_DrawProportionalString( 320, y, "Development Assistance", UI_CENTER|UI_SMALLFONT, color_white );
CNSTI4 320
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $118
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 87
;87:	y += PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1101135872
ADDF4
CVFI4 4
ASGNI4
line 88
;88:	UI_DrawProportionalString( 320, y, "Eric Webb", UI_CENTER|UI_SMALLFONT, color_white );
CNSTI4 320
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $119
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 90
;89:
;90:	y += 1.35 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1104851763
ADDF4
CVFI4 4
ASGNI4
line 91
;91:	UI_DrawString( 320, y, "To order: 1-800-idgames     www.quake3arena.com     www.idsoftware.com", UI_CENTER|UI_SMALLFONT, color_red );
CNSTI4 320
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $120
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 color_red
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 92
;92:	y += SMALLCHAR_HEIGHT;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 93
;93:	UI_DrawString( 320, y, "Quake III Arena(c) 1999-2000, Id Software, Inc.  All Rights Reserved", UI_CENTER|UI_SMALLFONT, color_red );
CNSTI4 320
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $121
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 color_red
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 94
;94:}
LABELV $101
endproc UI_CreditMenu_Draw 4 20
export UI_CreditMenu
proc UI_CreditMenu 0 12
line 102
;95:
;96:
;97:/*
;98:===============
;99:UI_CreditMenu
;100:===============
;101:*/
;102:void UI_CreditMenu( void ) {
line 103
;103:	memset( &s_credits, 0 ,sizeof(s_credits) );
ADDRGP4 s_credits
ARGP4
CNSTI4 0
ARGI4
CNSTI4 424
ARGI4
ADDRGP4 memset
CALLP4
pop
line 105
;104:
;105:	s_credits.menu.draw = UI_CreditMenu_Draw;
ADDRGP4 s_credits+396
ADDRGP4 UI_CreditMenu_Draw
ASGNP4
line 106
;106:	s_credits.menu.key = UI_CreditMenu_Key;
ADDRGP4 s_credits+400
ADDRGP4 UI_CreditMenu_Key
ASGNP4
line 107
;107:	s_credits.menu.fullscreen = qtrue;
ADDRGP4 s_credits+408
CNSTI4 1
ASGNI4
line 108
;108:	UI_PushMenu ( &s_credits.menu );
ADDRGP4 s_credits
ARGP4
ADDRGP4 UI_PushMenu
CALLV
pop
line 109
;109:}
LABELV $122
endproc UI_CreditMenu 0 12
proc UI_Hunt_Credits_Key 0 0
line 116
;110:
;111:/*
;112:=================
;113:JUHOX: UI_Hunt_Credits_Key
;114:=================
;115:*/
;116:static sfxHandle_t UI_Hunt_Credits_Key(int key) {
line 117
;117:	if(key & K_CHAR_FLAG) {
ADDRFP4 0
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $127
line 118
;118:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $126
JUMPV
LABELV $127
line 121
;119:	}
;120:
;121:	trap_S_StopBackgroundTrack();
ADDRGP4 trap_S_StopBackgroundTrack
CALLV
pop
line 122
;122:	UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 123
;123:	return 0;
CNSTI4 0
RETI4
LABELV $126
endproc UI_Hunt_Credits_Key 0 0
data
align 4
LABELV creditsEntries
address $130
byte 4 1068708659
byte 4 1053609165
skip 4
address $131
byte 4 1065353216
byte 4 1060320051
skip 4
address $132
byte 4 1065353216
byte 4 1060320051
skip 4
address $133
byte 4 1065353216
byte 4 1060320051
skip 4
address $134
byte 4 1065353216
byte 4 1060320051
skip 4
address $135
byte 4 1065353216
byte 4 1060320051
skip 4
address $136
byte 4 1065353216
byte 4 1060320051
skip 4
address $137
byte 4 1065353216
byte 4 1060320051
skip 4
address $138
byte 4 1065353216
byte 4 1060320051
skip 4
address $139
byte 4 1060320051
byte 4 1060320051
skip 4
address $140
byte 4 1065353216
byte 4 1060320051
skip 4
address $141
byte 4 1065353216
byte 4 1060320051
skip 4
address $142
byte 4 1065353216
byte 4 1060320051
skip 4
address $143
byte 4 1065353216
byte 4 1060320051
skip 4
byte 4 0
byte 4 0
byte 4 0
skip 4
byte 4 0
byte 4 0
byte 4 0
skip 4
byte 4 0
byte 4 0
byte 4 0
skip 4
byte 4 0
byte 4 0
byte 4 0
skip 4
align 4
LABELV font3D_charWidth
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 15
byte 4 32
byte 4 42
byte 4 42
byte 4 64
byte 4 54
byte 4 14
byte 4 20
byte 4 20
byte 4 26
byte 4 37
byte 4 15
byte 4 20
byte 4 15
byte 4 19
byte 4 41
byte 4 29
byte 4 42
byte 4 41
byte 4 44
byte 4 42
byte 4 41
byte 4 41
byte 4 41
byte 4 41
byte 4 15
byte 4 15
byte 4 39
byte 4 37
byte 4 39
byte 4 38
byte 4 52
byte 4 55
byte 4 46
byte 4 49
byte 4 46
byte 4 42
byte 4 38
byte 4 51
byte 4 48
byte 4 15
byte 4 40
byte 4 53
byte 4 40
byte 4 57
byte 4 48
byte 4 52
byte 4 43
byte 4 54
byte 4 49
byte 4 45
byte 4 47
byte 4 48
byte 4 54
byte 4 70
byte 4 55
byte 4 55
byte 4 48
byte 4 21
byte 4 19
byte 4 21
byte 4 37
byte 4 36
byte 4 17
byte 4 42
byte 4 40
byte 4 42
byte 4 40
byte 4 42
byte 4 29
byte 4 40
byte 4 38
byte 4 14
byte 4 22
byte 4 42
byte 4 14
byte 4 62
byte 4 38
byte 4 42
byte 4 40
byte 4 40
byte 4 28
byte 4 39
byte 4 27
byte 4 38
byte 4 43
byte 4 66
byte 4 46
byte 4 43
byte 4 36
byte 4 25
byte 4 8
byte 4 25
byte 4 39
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 55
byte 4 55
byte 4 55
byte 4 55
byte 4 55
byte 4 55
byte 4 70
byte 4 49
byte 4 42
byte 4 42
byte 4 42
byte 4 42
byte 4 19
byte 4 19
byte 4 25
byte 4 23
byte 4 51
byte 4 48
byte 4 52
byte 4 52
byte 4 52
byte 4 52
byte 4 52
byte 4 37
byte 4 56
byte 4 48
byte 4 48
byte 4 48
byte 4 48
byte 4 55
byte 4 43
byte 4 40
byte 4 42
byte 4 42
byte 4 42
byte 4 42
byte 4 42
byte 4 42
byte 4 66
byte 4 42
byte 4 42
byte 4 42
byte 4 42
byte 4 42
byte 4 18
byte 4 18
byte 4 25
byte 4 23
byte 4 42
byte 4 38
byte 4 42
byte 4 42
byte 4 42
byte 4 42
byte 4 42
byte 4 37
byte 4 42
byte 4 38
byte 4 38
byte 4 38
byte 4 38
byte 4 43
byte 4 40
byte 4 43
code
proc UI_3Dstrlen 8 0
line 426
;124:}
;125:
;126:// JUHOX: definitions for 3D chars
;127:#if 1
;128:#define CHAR3D_SPACE 5.0
;129:#define CHAR3D_SPACE_WIDTH 30.0
;130:#define CHAR3D_HEIGHT 90.0
;131:#define CREDITS_ENTRY_PHASE1 10000	// msec
;132:#define CREDITS_ENTRY_TIME 15000	// msec
;133:
;134:typedef struct {
;135:	const char* text;
;136:	float size;
;137:	float zScale;
;138:	float zOffset;
;139:} creditsEntry_t;
;140:
;141:static int creditsStartTime;
;142:static int creditsEndTime;
;143:
;144:static refdef_t creditsRefdef;
;145:
;146:static creditsEntry_t creditsEntries[] = {
;147:	{ "O   P   E   N\nH   U   N   T", 1.4, 0.4 },
;148:	{ "created by\nJürgen \"Juhox\" Hoffmann", 1, 0.7 },
;149:	{ "coding by\nJürgen Hoffmann\nCraniul", 1, 0.7 },
;150:	{ "artwork & shader scripts by\nJürgen Hoffmann", 1, 0.7 },
;151:	{ "technical assistance by\nMichael \"Padautz\" Hoffmann", 1, 0.7 },
;152:	{ "mapping by\nMichael Hoffmann\nGönenç Giray\nWolfWings", 1, 0.7 },
;153:	{ "lens flare scripts by\nGönenç \"GNC\" Giray\nwww.planetquake.com/gnc", 1, 0.7 },
;154:	{ "hook model by\nIa_Lanky from Ia Clan\nwww.iaclan.com", 1, 0.7 },
;155:	{ "monster launcher skin by\nMajor*Payne", 1, 0.7 },
;156:	{
;157:		"testing & inspiration by\n"
;158:		"Michael Hoffmann\n"
;159:		"Major*Payne\n"
;160:		"Gönenç Giray\n"
;161:		"Syabha\n"
;162:		"Ia_Lanky\n"
;163:		"Jürgen Mersmann\n"
;164:		"Don \"ViPr\" Karam\n"
;165:		"et al.", 0.7, 0.7
;166:	},
;167:	{
;168:		"special thanks to\n"
;169:		"Michael Hoffmann\n"
;170:		"Syabha",
;171:		1, 0.7
;172:	},
;173:	{
;174:		"headache caused by\nMajor*Payne\n:^)", 1, 0.7
;175:	},
;176:	{
;177:		"please visit\n"
;178:		"www.planetquake.com\n"
;179:		"www.planetquake.com/code3arena\n"
;180:		"www.shaderlab.com",
;181:		1, 0.7 },
;182:	{ "www.planetquake.com/modifia", 1, 0.7 },
;183:	{ NULL, 0, 0 },
;184:	{ NULL, 0, 0 },
;185:	{ NULL, 0, 0 },
;186:	{ NULL, 0, 0 }
;187:};
;188:
;189:static qhandle_t font3D_models[256];
;190:
;191:static const int font3D_charWidth[256] = {
;192:0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
;193:0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
;194:0,	// space
;195:15.09375,
;196:32.1875,
;197:42.375,
;198:42.875,
;199:64.09375,
;200:54.75,
;201:14.09375,
;202:20.875,
;203:20.875,
;204:26.984375,
;205:37.78125,
;206:15.09375,
;207:20.484375,
;208:15.09375,
;209:19.875,
;210:41.484375,
;211:29.09375,
;212:42.1875,
;213:41.875,
;214:44.375,
;215:42.1875,
;216:41.78125,
;217:41.09375,
;218:41.484375,
;219:41.78125,
;220:15.09375,
;221:15.09375,
;222:39.375,
;223:37.78125,
;224:39.375,
;225:38.1875,
;226:52.78125,
;227:55.28125,
;228:46.875,
;229:49.28125,
;230:46.6875,
;231:42.6875,
;232:38.6875,
;233:51.6875,
;234:48.59375,
;235:15.6875,
;236:40.78125,
;237:53.78125,
;238:40.1875,
;239:57.09375,
;240:48.59375,
;241:52.59375,
;242:43.09375,
;243:54.484375,
;244:49.875,
;245:45.984375,
;246:47.6875,
;247:48.6875,
;248:54.984375,
;249:70.984375,
;250:55.1875,
;251:55.1875,
;252:48.09375,
;253:21.28125,
;254:19.875,
;255:21.28125,
;256:37.875,
;257:36.28125,
;258:17.6875,
;259:42.34375,
;260:40.484375,
;261:42.484375,
;262:40.484375,
;263:42.59375,
;264:29.09375,
;265:40.515625,
;266:38.78125,
;267:14.09375,
;268:22.375,
;269:42.984375,
;270:14.09375,
;271:62.28125,
;272:38.78125,
;273:42.28125,
;274:40.484375,
;275:40.484375,
;276:28.984375,
;277:39.09375,
;278:27.59375,
;279:38.875,
;280:43.484375,
;281:66.984375,
;282:46.484375,
;283:43.375,
;284:36.59375,
;285:25.875,
;286:8.78125,
;287:25.875,
;288:39.6875,
;289:0, //omitted
;290:0, //omitted
;291:0, //omitted
;292:0, //omitted
;293:0, //omitted
;294:0, //omitted
;295:0, //omitted
;296:0, //omitted
;297:0, //omitted
;298:0, //omitted
;299:0, //omitted
;300:0, //omitted
;301:0, //omitted
;302:0, //omitted
;303:0, //omitted
;304:0, //omitted
;305:0, //omitted
;306:0, //omitted
;307:0, //omitted
;308:0, //omitted
;309:0, //omitted
;310:0, //omitted
;311:0, //omitted
;312:0, //omitted
;313:0, //omitted
;314:0, //omitted
;315:0, //omitted
;316:0, //omitted
;317:0, //omitted
;318:0, //omitted
;319:0, //omitted
;320:0, //omitted
;321:0, //omitted
;322:0, //omitted
;323:0, //omitted
;324:0, //omitted
;325:0, //omitted
;326:0, //omitted
;327:0, //omitted
;328:0, //omitted
;329:0, //omitted
;330:0, //omitted
;331:0, //omitted
;332:0, //omitted
;333:0, //omitted
;334:0, //omitted
;335:0, //omitted
;336:0, //omitted
;337:0, //omitted
;338:0, //omitted
;339:0, //omitted
;340:0, //omitted
;341:0, //omitted
;342:0, //omitted
;343:0, //omitted
;344:0, //omitted
;345:0, //omitted
;346:0, //omitted
;347:0, //omitted
;348:0, //omitted
;349:0, //omitted
;350:0, //omitted
;351:0, //omitted
;352:0, //omitted
;353:0, //omitted
;354:55.28125,
;355:55.28125,
;356:55.28125,
;357:55.28125,
;358:55.28125,
;359:55.28125,
;360:70.984375,
;361:49.28125,
;362:42.6875,
;363:42.6875,
;364:42.6875,
;365:42.6875,
;366:19.375,
;367:19.59375,
;368:25.59375,
;369:23.6875,
;370:51.875,
;371:48.59375,
;372:52.59375,
;373:52.59375,
;374:52.59375,
;375:52.59375,
;376:52.59375,
;377:37.875,
;378:56.625,
;379:48.6875,
;380:48.6875,
;381:48.6875,
;382:48.6875,
;383:55.1875,
;384:43.09375,
;385:40.6875,
;386:42.34375,
;387:42.34375,
;388:42.34375,
;389:42.34375,
;390:42.34375,
;391:42.34375,
;392:66.484375,
;393:42.484375,
;394:42.59375,
;395:42.59375,
;396:42.59375,
;397:42.59375,
;398:18.78125,
;399:18.59375,
;400:25.59375,
;401:23.6875,
;402:42.09375,
;403:38.78125,
;404:42.28125,
;405:42.28125,
;406:42.28125,
;407:42.28125,
;408:42.28125,
;409:37.78125,
;410:42.1875,
;411:38.875,
;412:38.875,
;413:38.875,
;414:38.875,
;415:43.375,
;416:40.484375,
;417:43.375
;418:};
;419:#endif
;420:
;421:/*
;422:=================
;423:JUHOX: UI_3Dstrlen
;424:=================
;425:*/
;426:static float UI_3Dstrlen(const char* s, float scale) {
line 429
;427:	float size;
;428:
;429:	size = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
ADDRGP4 $146
JUMPV
LABELV $145
line 430
;430:	while (*s && *s != '\n') {
line 433
;431:		float width;
;432:
;433:		width = font3D_charWidth[*s & 255];
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 255
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 font3D_charWidth
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 434
;434:		if (width > 0) {
ADDRLP4 4
INDIRF4
CNSTF4 0
LEF4 $148
line 435
;435:			size += width + CHAR3D_SPACE;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 4
INDIRF4
CNSTF4 1084227584
ADDF4
ADDF4
ASGNF4
line 436
;436:		}
ADDRGP4 $149
JUMPV
LABELV $148
line 437
;437:		else if (*s == ' ') {
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 32
NEI4 $150
line 438
;438:			size += CHAR3D_SPACE_WIDTH;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1106247680
ADDF4
ASGNF4
line 439
;439:		}
LABELV $150
LABELV $149
line 440
;440:		s++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 441
;441:	}
LABELV $146
line 430
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $152
ADDRLP4 4
INDIRI4
CNSTI4 10
NEI4 $145
LABELV $152
line 442
;442:	return size * scale;
ADDRLP4 0
INDIRF4
ADDRFP4 4
INDIRF4
MULF4
RETF4
LABELV $144
endproc UI_3Dstrlen 8 0
proc UI_3DMultiLineStrlen 12 0
line 450
;443:}
;444:
;445:/*
;446:=================
;447:JUHOX: UI_3DMultiLineStrlen
;448:=================
;449:*/
;450:static float UI_3DMultiLineStrlen(const char* s, float scale) {
line 454
;451:	float size;
;452:	float maxSize;
;453:
;454:	size = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 455
;455:	maxSize = 0;
ADDRLP4 4
CNSTF4 0
ASGNF4
ADDRGP4 $155
JUMPV
LABELV $154
line 456
;456:	while (*s) {
line 459
;457:		float width;
;458:
;459:		if (*s == '\n') {
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 10
NEI4 $157
line 460
;460:			if (size > maxSize) {
ADDRLP4 0
INDIRF4
ADDRLP4 4
INDIRF4
LEF4 $159
line 461
;461:				maxSize = size;
ADDRLP4 4
ADDRLP4 0
INDIRF4
ASGNF4
line 462
;462:			}
LABELV $159
line 463
;463:			size = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 464
;464:		}
LABELV $157
line 466
;465:
;466:		width = font3D_charWidth[*s & 255];
ADDRLP4 8
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 255
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 font3D_charWidth
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 467
;467:		if (width > 0) {
ADDRLP4 8
INDIRF4
CNSTF4 0
LEF4 $161
line 468
;468:			size += width + CHAR3D_SPACE;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 8
INDIRF4
CNSTF4 1084227584
ADDF4
ADDF4
ASGNF4
line 469
;469:		}
ADDRGP4 $162
JUMPV
LABELV $161
line 470
;470:		else if (*s == ' ') {
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 32
NEI4 $163
line 471
;471:			size += CHAR3D_SPACE_WIDTH;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1106247680
ADDF4
ASGNF4
line 472
;472:		}
LABELV $163
LABELV $162
line 473
;473:		s++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 474
;474:	}
LABELV $155
line 456
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $154
line 475
;475:	if (size > maxSize) {
ADDRLP4 0
INDIRF4
ADDRLP4 4
INDIRF4
LEF4 $165
line 476
;476:		maxSize = size;
ADDRLP4 4
ADDRLP4 0
INDIRF4
ASGNF4
line 477
;477:	}
LABELV $165
line 478
;478:	return maxSize * scale;
ADDRLP4 4
INDIRF4
ADDRFP4 4
INDIRF4
MULF4
RETF4
LABELV $153
endproc UI_3DMultiLineStrlen 12 0
proc UI_Draw3Dchar 172 12
line 486
;479:}
;480:
;481:/*
;482:=================
;483:JUHOX: UI_Draw3Dchar
;484:=================
;485:*/
;486:static void UI_Draw3Dchar(const vec3_t origin, int c, float offset, float scale, float zScale, float yaw) {
line 491
;487:	refEntity_t ent;
;488:	vec3_t charOrg;
;489:	vec3_t angles;
;490:
;491:	memset(&ent, 0, sizeof(ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 493
;492:
;493:	c &= 255;
ADDRFP4 4
ADDRFP4 4
INDIRI4
CNSTI4 255
BANDI4
ASGNI4
line 494
;494:	ent.hModel = font3D_models[c];
ADDRLP4 0+8
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 font3D_models
ADDP4
INDIRI4
ASGNI4
line 496
;495:
;496:	VectorSet(angles, 0, 180 + yaw, 0);
ADDRLP4 152
CNSTF4 0
ASGNF4
ADDRLP4 152+4
ADDRFP4 20
INDIRF4
CNSTF4 1127481344
ADDF4
ASGNF4
ADDRLP4 152+8
CNSTF4 0
ASGNF4
line 497
;497:	AnglesToAxis(angles, ent.axis);
ADDRLP4 152
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 499
;498:
;499:	VectorCopy(origin, charOrg);
ADDRLP4 140
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 500
;500:	offset += 0.5 * (font3D_charWidth[c] + CHAR3D_SPACE) * scale;
ADDRFP4 8
ADDRFP4 8
INDIRF4
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 font3D_charWidth
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1084227584
ADDF4
CNSTF4 1056964608
MULF4
ADDRFP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
line 501
;501:	VectorMA(charOrg, offset, ent.axis[1], charOrg);
ADDRLP4 164
ADDRFP4 8
INDIRF4
ASGNF4
ADDRLP4 140
ADDRLP4 140
INDIRF4
ADDRLP4 0+28+12
INDIRF4
ADDRLP4 164
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 140+4
INDIRF4
ADDRLP4 0+28+12+4
INDIRF4
ADDRLP4 164
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 140+8
INDIRF4
ADDRLP4 0+28+12+8
INDIRF4
ADDRFP4 8
INDIRF4
MULF4
ADDF4
ASGNF4
line 502
;502:	charOrg[2] -= 70.0 * scale * zScale;
ADDRLP4 140+8
ADDRLP4 140+8
INDIRF4
ADDRFP4 12
INDIRF4
CNSTF4 1116471296
MULF4
ADDRFP4 16
INDIRF4
MULF4
SUBF4
ASGNF4
line 511
;503:	//charOrg[1] = -charOrg[1];
;504:
;505:
;506:	/*
;507:	VectorMA(ent.origin, charOrg[0], creditsRefdef.viewaxis[0], ent.origin);
;508:	VectorMA(ent.origin, charOrg[1], creditsRefdef.viewaxis[1], ent.origin);
;509:	VectorMA(ent.origin, charOrg[2], creditsRefdef.viewaxis[2], ent.origin);
;510:	*/
;511:	VectorCopy(charOrg, ent.origin);
ADDRLP4 0+68
ADDRLP4 140
INDIRB
ASGNB 12
line 513
;512:
;513:	VectorCopy(ent.origin, ent.oldorigin);
ADDRLP4 0+84
ADDRLP4 0+68
INDIRB
ASGNB 12
line 514
;514:	VectorCopy(ent.origin, ent.lightingOrigin);
ADDRLP4 0+12
ADDRLP4 0+68
INDIRB
ASGNB 12
line 515
;515:	VectorScale(ent.axis[0], scale, ent.axis[0]);
ADDRLP4 0+28
ADDRLP4 0+28
INDIRF4
ADDRFP4 12
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+4
ADDRLP4 0+28+4
INDIRF4
ADDRFP4 12
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+8
ADDRLP4 0+28+8
INDIRF4
ADDRFP4 12
INDIRF4
MULF4
ASGNF4
line 516
;516:	VectorScale(ent.axis[1], scale, ent.axis[1]);
ADDRLP4 0+28+12
ADDRLP4 0+28+12
INDIRF4
ADDRFP4 12
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+12+4
ADDRLP4 0+28+12+4
INDIRF4
ADDRFP4 12
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+12+8
ADDRLP4 0+28+12+8
INDIRF4
ADDRFP4 12
INDIRF4
MULF4
ASGNF4
line 517
;517:	VectorScale(ent.axis[2], scale * zScale, ent.axis[2]);
ADDRLP4 0+28+24
ADDRLP4 0+28+24
INDIRF4
ADDRFP4 12
INDIRF4
ADDRFP4 16
INDIRF4
MULF4
MULF4
ASGNF4
ADDRLP4 0+28+24+4
ADDRLP4 0+28+24+4
INDIRF4
ADDRFP4 12
INDIRF4
ADDRFP4 16
INDIRF4
MULF4
MULF4
ASGNF4
ADDRLP4 0+28+24+8
ADDRLP4 0+28+24+8
INDIRF4
ADDRFP4 12
INDIRF4
ADDRFP4 16
INDIRF4
MULF4
MULF4
ASGNF4
line 518
;518:	ent.nonNormalizedAxes = qtrue;
ADDRLP4 0+64
CNSTI4 1
ASGNI4
line 519
;519:	ent.renderfx = RF_NOSHADOW | RF_MINLIGHT | RF_LIGHTING_ORIGIN;
ADDRLP4 0+4
CNSTI4 193
ASGNI4
line 521
;520:
;521:	ent.shaderRGBA[3] = 255;
ADDRLP4 0+116+3
CNSTU1 255
ASGNU1
line 522
;522:	if (ent.origin[0] > 1000.0) {
ADDRLP4 0+68
INDIRF4
CNSTF4 1148846080
LEF4 $236
line 525
;523:		float alpha;
;524:
;525:		alpha = 255 * (1 - (ent.origin[0] - 1000.0) / 1000.0);
ADDRLP4 168
CNSTF4 1065353216
ADDRLP4 0+68
INDIRF4
CNSTF4 1148846080
SUBF4
CNSTF4 981668463
MULF4
SUBF4
CNSTF4 1132396544
MULF4
ASGNF4
line 526
;526:		if (alpha < 0) alpha = 0;
ADDRLP4 168
INDIRF4
CNSTF4 0
GEF4 $240
ADDRLP4 168
CNSTF4 0
ASGNF4
LABELV $240
line 527
;527:		ent.shaderRGBA[3] = (int) alpha; 
ADDRLP4 0+116+3
ADDRLP4 168
INDIRF4
CVFI4 4
CVIU4 4
CVUU1 4
ASGNU1
line 528
;528:	}
LABELV $236
line 535
;529:	/*
;530:	ent.shaderRGBA[0] = ent.shaderRGBA[3] >> 1;
;531:	ent.shaderRGBA[1] = ent.shaderRGBA[3] >> 1;
;532:	ent.shaderRGBA[2] = ent.shaderRGBA[3] >> 1;
;533:	*/
;534:
;535:	trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 536
;536:}
LABELV $167
endproc UI_Draw3Dchar 172 12
proc UI_Draw3Dstring 16 24
line 543
;537:
;538:/*
;539:=================
;540:JUHOX: UI_Draw3Dstring
;541:=================
;542:*/
;543:static int UI_Draw3Dstring(const vec3_t origin, const char* s, float scale, float zScale, float yaw) {
line 547
;544:	float offset;
;545:	int n;
;546:
;547:	offset = -0.5 * UI_3Dstrlen(s, scale);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 UI_3Dstrlen
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
CNSTF4 3204448256
MULF4
ASGNF4
line 549
;548:
;549:	n = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $246
JUMPV
LABELV $245
line 550
;550:	while (*s && *s != '\n') {
line 553
;551:		float width;
;552:
;553:		width = font3D_charWidth[*s & 255];
ADDRLP4 12
ADDRFP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 255
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 font3D_charWidth
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 554
;554:		if (width > 0) {
ADDRLP4 12
INDIRF4
CNSTF4 0
LEF4 $248
line 555
;555:			UI_Draw3Dchar(origin, *s, offset, scale, zScale, yaw);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 0
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRFP4 16
INDIRF4
ARGF4
ADDRGP4 UI_Draw3Dchar
CALLV
pop
line 556
;556:			offset += (width + CHAR3D_SPACE) * scale;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 12
INDIRF4
CNSTF4 1084227584
ADDF4
ADDRFP4 8
INDIRF4
MULF4
ADDF4
ASGNF4
line 557
;557:		}
ADDRGP4 $249
JUMPV
LABELV $248
line 558
;558:		else if (*s == ' ') {
ADDRFP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 32
NEI4 $250
line 559
;559:			offset += CHAR3D_SPACE_WIDTH * scale;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 8
INDIRF4
CNSTF4 1106247680
MULF4
ADDF4
ASGNF4
line 560
;560:		}
LABELV $250
LABELV $249
line 561
;561:		s++;
ADDRFP4 4
ADDRFP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 562
;562:		n++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 563
;563:	}
LABELV $246
line 550
ADDRLP4 12
ADDRFP4 4
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $252
ADDRLP4 12
INDIRI4
CNSTI4 10
NEI4 $245
LABELV $252
line 564
;564:	return n;
ADDRLP4 4
INDIRI4
RETI4
LABELV $244
endproc UI_Draw3Dstring 16 24
proc UI_DrawMultiLine3Dstring 24 20
line 572
;565:}
;566:
;567:/*
;568:=================
;569:JUHOX: UI_DrawMultiLine3Dstring
;570:=================
;571:*/
;572:static void UI_DrawMultiLine3Dstring(const vec3_t origin, const char* s, float scale, float zScale, float yaw) {
line 577
;573:	int numLines;
;574:	const char* str;
;575:	vec3_t currentOrigin;
;576:
;577:	numLines = 1;
ADDRLP4 16
CNSTI4 1
ASGNI4
line 578
;578:	str = s;
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRGP4 $255
JUMPV
LABELV $254
line 579
;579:	while (*str) {
line 580
;580:		if (*str == '\n') numLines++;
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 10
NEI4 $257
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $257
line 581
;581:		str++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 582
;582:	}
LABELV $255
line 579
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $254
line 583
;583:	VectorCopy(origin, currentOrigin);
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 584
;584:	numLines &= ~1;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 585
;585:	currentOrigin[2] += 0.5 * CHAR3D_HEIGHT * numLines * scale * zScale;
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
ADDRLP4 16
INDIRI4
CVIF4 4
CNSTF4 1110704128
MULF4
ADDRFP4 8
INDIRF4
MULF4
ADDRFP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
line 587
;586:
;587:	str = s;
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRGP4 $261
JUMPV
LABELV $260
line 588
;588:	while (*str) {
line 589
;589:		str += UI_Draw3Dstring(currentOrigin, str, scale, zScale, yaw);
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRFP4 16
INDIRF4
ARGF4
ADDRLP4 20
ADDRGP4 UI_Draw3Dstring
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 20
INDIRI4
ADDRLP4 0
INDIRP4
ADDP4
ASGNP4
line 590
;590:		if (*str == '\n') str++;
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 10
NEI4 $263
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $263
line 591
;591:		currentOrigin[2] -= CHAR3D_HEIGHT * scale * zScale;
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
ADDRFP4 8
INDIRF4
CNSTF4 1119092736
MULF4
ADDRFP4 12
INDIRF4
MULF4
SUBF4
ASGNF4
line 592
;592:	}
LABELV $261
line 588
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $260
line 593
;593:}
LABELV $253
endproc UI_DrawMultiLine3Dstring 24 20
proc if1 4 0
line 600
;594:
;595:/*
;596:=================
;597:JUHOX: if1
;598:=================
;599:*/
;600:static float if1(float x) {
line 601
;601:	return 1 - (1-x) * (1-x);
ADDRLP4 0
ADDRFP4 0
INDIRF4
ASGNF4
CNSTF4 1065353216
CNSTF4 1065353216
ADDRLP4 0
INDIRF4
SUBF4
CNSTF4 1065353216
ADDRLP4 0
INDIRF4
SUBF4
MULF4
SUBF4
RETF4
LABELV $266
endproc if1 4 0
proc if2 4 0
line 609
;602:}
;603:
;604:/*
;605:=================
;606:JUHOX: if2
;607:=================
;608:*/
;609:static float if2(float x) {
line 610
;610:	return 3 * x * x - 2 * x * x * x;
ADDRLP4 0
ADDRFP4 0
INDIRF4
ASGNF4
ADDRLP4 0
INDIRF4
CNSTF4 1077936128
MULF4
ADDRLP4 0
INDIRF4
MULF4
ADDRLP4 0
INDIRF4
CNSTF4 1073741824
MULF4
ADDRLP4 0
INDIRF4
MULF4
ADDRLP4 0
INDIRF4
MULF4
SUBF4
RETF4
LABELV $267
endproc if2 4 0
proc UI_DrawCreditsEntry 52 20
line 618
;611:}
;612:
;613:/*
;614:=================
;615:JUHOX: UI_DrawCreditsEntry
;616:=================
;617:*/
;618:static void UI_DrawCreditsEntry(int entry) {
line 626
;619:	const creditsEntry_t* ce;
;620:	int entryStartTime;
;621:	float yaw;
;622:	float offset;
;623:	int time;
;624:	vec3_t origin;
;625:
;626:	if (entry < 0) return;
ADDRFP4 0
INDIRI4
CNSTI4 0
GEI4 $269
ADDRGP4 $268
JUMPV
LABELV $269
line 628
;627:
;628:	ce = &creditsEntries[entry];
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 creditsEntries
ADDP4
ASGNP4
line 629
;629:	if (!ce->text) return;
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $271
ADDRGP4 $268
JUMPV
LABELV $271
line 631
;630:
;631:	entryStartTime = entry * CREDITS_ENTRY_TIME;
ADDRLP4 20
ADDRFP4 0
INDIRI4
CNSTI4 15000
MULI4
ASGNI4
line 633
;632:
;633:	offset = 0.5 * UI_3DMultiLineStrlen(ce->text, ce->size);
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
ADDRGP4 UI_3DMultiLineStrlen
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 36
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 635
;634:
;635:	time = creditsRefdef.time - entryStartTime;
ADDRLP4 16
ADDRGP4 creditsRefdef+72
INDIRI4
ADDRLP4 20
INDIRI4
SUBI4
ASGNI4
line 637
;636:
;637:	origin[0] = -50.0 + 600.0 * time / (float)CREDITS_ENTRY_PHASE1;
ADDRLP4 4
ADDRLP4 16
INDIRI4
CVIF4 4
CNSTF4 1031127695
MULF4
CNSTF4 3259498496
ADDF4
ASGNF4
line 638
;638:	origin[1] = 0;
ADDRLP4 4+4
CNSTF4 0
ASGNF4
line 639
;639:	origin[2] = ce->zOffset * ce->size * ce->zScale;
ADDRLP4 4+8
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ASGNF4
line 641
;640:
;641:	if (time > CREDITS_ENTRY_PHASE1) time = CREDITS_ENTRY_PHASE1;
ADDRLP4 16
INDIRI4
CNSTI4 10000
LEI4 $276
ADDRLP4 16
CNSTI4 10000
ASGNI4
LABELV $276
line 642
;642:	yaw = -180.0 + 180.0 * if1((float)time / (float)CREDITS_ENTRY_PHASE1);
ADDRLP4 16
INDIRI4
CVIF4 4
CNSTF4 953267991
MULF4
ARGF4
ADDRLP4 44
ADDRGP4 if1
CALLF4
ASGNF4
ADDRLP4 24
ADDRLP4 44
INDIRF4
CNSTF4 1127481344
MULF4
CNSTF4 3274964992
ADDF4
ASGNF4
line 644
;643:
;644:	UI_DrawMultiLine3Dstring(origin, ce->text, ce->size, ce->zScale, yaw);
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRGP4 UI_DrawMultiLine3Dstring
CALLV
pop
line 646
;645:
;646:	if (!ce[1].text && origin[0] > 2100) {
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $278
ADDRLP4 4
INDIRF4
CNSTF4 1157840896
LEF4 $278
line 647
;647:		creditsEndTime = uis.realtime;
ADDRGP4 creditsEndTime
ADDRGP4 uis+4
INDIRI4
ASGNI4
line 648
;648:	}
LABELV $278
line 649
;649:}
LABELV $268
endproc UI_DrawCreditsEntry 52 20
proc UI_Hunt_Credits_Draw 48 36
line 656
;650:
;651:/*
;652:=================
;653:JUHOX: UI_Hunt_Credits_Draw
;654:=================
;655:*/
;656:static void UI_Hunt_Credits_Draw(void) {
line 660
;657:	float x, y, w, h;
;658:	int entry;
;659:
;660:	if (!creditsStartTime) {
ADDRGP4 creditsStartTime
INDIRI4
CNSTI4 0
NEI4 $282
line 661
;661:		creditsStartTime = uis.realtime + 3000;
ADDRGP4 creditsStartTime
ADDRGP4 uis+4
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 662
;662:		return;
ADDRGP4 $281
JUMPV
LABELV $282
line 665
;663:	}
;664:
;665:	x = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 666
;666:	y = 0;
ADDRLP4 4
CNSTF4 0
ASGNF4
line 667
;667:	w = 640;
ADDRLP4 8
CNSTF4 1142947840
ASGNF4
line 668
;668:	h = 480;
ADDRLP4 12
CNSTF4 1139802112
ASGNF4
line 669
;669:	UI_AdjustFrom640(&x, &y, &w, &h);
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
line 671
;670:
;671:	trap_R_DrawStretchPic(x, y, w, h, 0, 0, 1, 1, trap_R_RegisterShaderNoMip("gfx/credits_bg.tga"));
ADDRGP4 $285
ARGP4
ADDRLP4 20
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
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
CNSTF4 1065353216
ARGF4
ADDRLP4 20
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 673
;672:
;673:	if (uis.realtime < creditsStartTime + 1000) {
ADDRGP4 uis+4
INDIRI4
ADDRGP4 creditsStartTime
INDIRI4
CNSTI4 1000
ADDI4
GEI4 $286
line 676
;674:		vec4_t color;
;675:
;676:		color[0] = 1;
ADDRLP4 24
CNSTF4 1065353216
ASGNF4
line 677
;677:		color[1] = 1;
ADDRLP4 24+4
CNSTF4 1065353216
ASGNF4
line 678
;678:		color[2] = 1;
ADDRLP4 24+8
CNSTF4 1065353216
ASGNF4
line 679
;679:		color[3] = if2((creditsStartTime + 1000 - uis.realtime) / 4000.0);
ADDRGP4 creditsStartTime
INDIRI4
CNSTI4 1000
ADDI4
ADDRGP4 uis+4
INDIRI4
SUBI4
CVIF4 4
CNSTF4 964891247
MULF4
ARGF4
ADDRLP4 40
ADDRGP4 if2
CALLF4
ASGNF4
ADDRLP4 24+12
ADDRLP4 40
INDIRF4
ASGNF4
line 680
;680:		trap_R_SetColor(color);
ADDRLP4 24
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 681
;681:		trap_R_DrawStretchPic(x, y, w, h, 0, 0, 1, 1, trap_R_RegisterShaderNoMip("creditsGlare"));
ADDRGP4 $293
ARGP4
ADDRLP4 44
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
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
CNSTF4 1065353216
ARGF4
ADDRLP4 44
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 682
;682:		trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 683
;683:	}
LABELV $286
line 684
;684:	if (uis.realtime < creditsStartTime) return;
ADDRGP4 uis+4
INDIRI4
ADDRGP4 creditsStartTime
INDIRI4
GEI4 $294
ADDRGP4 $281
JUMPV
LABELV $294
line 686
;685:
;686:	if (creditsEndTime) {
ADDRGP4 creditsEndTime
INDIRI4
CNSTI4 0
EQI4 $297
line 687
;687:		if (uis.realtime > creditsEndTime + 4000) {
ADDRGP4 uis+4
INDIRI4
ADDRGP4 creditsEndTime
INDIRI4
CNSTI4 4000
ADDI4
LEI4 $299
line 688
;688:			trap_S_StopBackgroundTrack();
ADDRGP4 trap_S_StopBackgroundTrack
CALLV
pop
line 689
;689:			UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 690
;690:			return;
ADDRGP4 $281
JUMPV
LABELV $299
line 692
;691:		}
;692:		if (uis.realtime >= creditsEndTime) {
ADDRGP4 uis+4
INDIRI4
ADDRGP4 creditsEndTime
INDIRI4
LTI4 $281
line 695
;693:			vec4_t color;
;694:
;695:			color[0] = 1;
ADDRLP4 24
CNSTF4 1065353216
ASGNF4
line 696
;696:			color[1] = 1;
ADDRLP4 24+4
CNSTF4 1065353216
ASGNF4
line 697
;697:			color[2] = 1;
ADDRLP4 24+8
CNSTF4 1065353216
ASGNF4
line 698
;698:			color[3] = if2((uis.realtime - creditsEndTime) / 4000.0);
ADDRGP4 uis+4
INDIRI4
ADDRGP4 creditsEndTime
INDIRI4
SUBI4
CVIF4 4
CNSTF4 964891247
MULF4
ARGF4
ADDRLP4 40
ADDRGP4 if2
CALLF4
ASGNF4
ADDRLP4 24+12
ADDRLP4 40
INDIRF4
ASGNF4
line 699
;699:			trap_R_SetColor(color);
ADDRLP4 24
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 700
;700:			trap_R_DrawStretchPic(x, y, w, h, 0, 0, 1, 1, trap_R_RegisterShaderNoMip("creditsGlare"));
ADDRGP4 $293
ARGP4
ADDRLP4 44
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
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
CNSTF4 1065353216
ARGF4
ADDRLP4 44
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 701
;701:			trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 702
;702:		}
line 703
;703:		return;
ADDRGP4 $281
JUMPV
LABELV $297
line 706
;704:	}
;705:
;706:	memset(&creditsRefdef, 0, sizeof(creditsRefdef));
ADDRGP4 creditsRefdef
ARGP4
CNSTI4 0
ARGI4
CNSTI4 368
ARGI4
ADDRGP4 memset
CALLP4
pop
line 708
;707:
;708:	creditsRefdef.rdflags = RDF_NOWORLDMODEL;
ADDRGP4 creditsRefdef+76
CNSTI4 1
ASGNI4
line 710
;709:
;710:	AxisClear(creditsRefdef.viewaxis);
ADDRGP4 creditsRefdef+36
ARGP4
ADDRGP4 AxisClear
CALLV
pop
line 712
;711:
;712:	creditsRefdef.x = x;
ADDRGP4 creditsRefdef
ADDRLP4 0
INDIRF4
CVFI4 4
ASGNI4
line 713
;713:	creditsRefdef.y = y;
ADDRGP4 creditsRefdef+4
ADDRLP4 4
INDIRF4
CVFI4 4
ASGNI4
line 714
;714:	creditsRefdef.width = w;
ADDRGP4 creditsRefdef+8
ADDRLP4 8
INDIRF4
CVFI4 4
ASGNI4
line 715
;715:	creditsRefdef.height = h;
ADDRGP4 creditsRefdef+12
ADDRLP4 12
INDIRF4
CVFI4 4
ASGNI4
line 717
;716:
;717:	creditsRefdef.fov_x = 90;
ADDRGP4 creditsRefdef+16
CNSTF4 1119092736
ASGNF4
line 718
;718:	creditsRefdef.fov_y = 90.0 * 480.0 / 640.0;
ADDRGP4 creditsRefdef+20
CNSTF4 1116143616
ASGNF4
line 720
;719:
;720:	creditsRefdef.time = uis.realtime - creditsStartTime;
ADDRGP4 creditsRefdef+72
ADDRGP4 uis+4
INDIRI4
ADDRGP4 creditsStartTime
INDIRI4
SUBI4
ASGNI4
line 722
;721:
;722:	entry = creditsRefdef.time / CREDITS_ENTRY_TIME;
ADDRLP4 16
ADDRGP4 creditsRefdef+72
INDIRI4
CNSTI4 15000
DIVI4
ASGNI4
line 724
;723:
;724:	trap_R_ClearScene();
ADDRGP4 trap_R_ClearScene
CALLV
pop
line 726
;725:
;726:	UI_DrawCreditsEntry(entry);
ADDRLP4 16
INDIRI4
ARGI4
ADDRGP4 UI_DrawCreditsEntry
CALLV
pop
line 728
;727:
;728:	UI_DrawCreditsEntry(entry - 1);
ADDRLP4 16
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRGP4 UI_DrawCreditsEntry
CALLV
pop
line 730
;729:
;730:	UI_DrawCreditsEntry(entry - 2);
ADDRLP4 16
INDIRI4
CNSTI4 2
SUBI4
ARGI4
ADDRGP4 UI_DrawCreditsEntry
CALLV
pop
line 732
;731:
;732:	trap_R_RenderScene(&creditsRefdef);
ADDRGP4 creditsRefdef
ARGP4
ADDRGP4 trap_R_RenderScene
CALLV
pop
line 733
;733:}
LABELV $281
endproc UI_Hunt_Credits_Draw 48 36
export UI_Hunt_Credits
proc UI_Hunt_Credits 16 12
line 740
;734:
;735:/*
;736:===============
;737:JUHOX: UI_Hunt_Credits
;738:===============
;739:*/
;740:void UI_Hunt_Credits(void) {
line 743
;741:	int i;
;742:
;743:	memset(&font3D_models, 0, sizeof(font3D_models));
ADDRGP4 font3D_models
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1024
ARGI4
ADDRGP4 memset
CALLP4
pop
line 744
;744:	for (i = 33; i < 256; i++) {
ADDRLP4 0
CNSTI4 33
ASGNI4
LABELV $320
line 745
;745:		font3D_models[i] = trap_R_RegisterModel(va("models/fonts/hunt1/f_%d.md3", i));
ADDRGP4 $324
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 font3D_models
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 746
;746:	}
LABELV $321
line 744
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 256
LTI4 $320
line 748
;747:
;748:	creditsStartTime = 0;
ADDRGP4 creditsStartTime
CNSTI4 0
ASGNI4
line 749
;749:	creditsEndTime = 0;
ADDRGP4 creditsEndTime
CNSTI4 0
ASGNI4
line 751
;750:
;751:	memset(&s_credits, 0, sizeof(s_credits));
ADDRGP4 s_credits
ARGP4
CNSTI4 0
ARGI4
CNSTI4 424
ARGI4
ADDRGP4 memset
CALLP4
pop
line 753
;752:
;753:	s_credits.menu.key = UI_Hunt_Credits_Key;
ADDRGP4 s_credits+400
ADDRGP4 UI_Hunt_Credits_Key
ASGNP4
line 754
;754:	s_credits.menu.draw = UI_Hunt_Credits_Draw;
ADDRGP4 s_credits+396
ADDRGP4 UI_Hunt_Credits_Draw
ASGNP4
line 755
;755:	s_credits.menu.fullscreen = qtrue;
ADDRGP4 s_credits+408
CNSTI4 1
ASGNI4
line 756
;756:	s_credits.menu.blackBack = qtrue;
ADDRGP4 s_credits+416
CNSTI4 1
ASGNI4
line 757
;757:	s_credits.menu.noCursor = qtrue;
ADDRGP4 s_credits+420
CNSTI4 1
ASGNI4
line 758
;758:	UI_PushMenu(&s_credits.menu);
ADDRGP4 s_credits
ARGP4
ADDRGP4 UI_PushMenu
CALLV
pop
line 760
;759:
;760:	trap_S_StopBackgroundTrack();
ADDRGP4 trap_S_StopBackgroundTrack
CALLV
pop
line 761
;761:	trap_S_StartBackgroundTrack("music/win.wav", "");
ADDRGP4 $330
ARGP4
ADDRGP4 $331
ARGP4
ADDRGP4 trap_S_StartBackgroundTrack
CALLV
pop
line 762
;762:	uis.startTitleMusic = qtrue;
ADDRGP4 uis+95108
CNSTI4 1
ASGNI4
line 763
;763:}
LABELV $319
endproc UI_Hunt_Credits 16 12
bss
align 4
LABELV font3D_models
skip 1024
align 4
LABELV creditsRefdef
skip 368
align 4
LABELV creditsEndTime
skip 4
align 4
LABELV creditsStartTime
skip 4
align 4
LABELV s_credits
skip 424
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
LABELV $331
byte 1 0
align 1
LABELV $330
byte 1 109
byte 1 117
byte 1 115
byte 1 105
byte 1 99
byte 1 47
byte 1 119
byte 1 105
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $324
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 115
byte 1 47
byte 1 104
byte 1 117
byte 1 110
byte 1 116
byte 1 49
byte 1 47
byte 1 102
byte 1 95
byte 1 37
byte 1 100
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $293
byte 1 99
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 116
byte 1 115
byte 1 71
byte 1 108
byte 1 97
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $285
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 99
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 116
byte 1 115
byte 1 95
byte 1 98
byte 1 103
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $143
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
LABELV $142
byte 1 112
byte 1 108
byte 1 101
byte 1 97
byte 1 115
byte 1 101
byte 1 32
byte 1 118
byte 1 105
byte 1 115
byte 1 105
byte 1 116
byte 1 10
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
byte 1 10
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
byte 1 99
byte 1 111
byte 1 100
byte 1 101
byte 1 51
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 10
byte 1 119
byte 1 119
byte 1 119
byte 1 46
byte 1 115
byte 1 104
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 108
byte 1 97
byte 1 98
byte 1 46
byte 1 99
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $141
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 97
byte 1 99
byte 1 104
byte 1 101
byte 1 32
byte 1 99
byte 1 97
byte 1 117
byte 1 115
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 10
byte 1 77
byte 1 97
byte 1 106
byte 1 111
byte 1 114
byte 1 42
byte 1 80
byte 1 97
byte 1 121
byte 1 110
byte 1 101
byte 1 10
byte 1 58
byte 1 94
byte 1 41
byte 1 0
align 1
LABELV $140
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 105
byte 1 97
byte 1 108
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 110
byte 1 107
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 10
byte 1 77
byte 1 105
byte 1 99
byte 1 104
byte 1 97
byte 1 101
byte 1 108
byte 1 32
byte 1 72
byte 1 111
byte 1 102
byte 1 102
byte 1 109
byte 1 97
byte 1 110
byte 1 110
byte 1 10
byte 1 83
byte 1 121
byte 1 97
byte 1 98
byte 1 104
byte 1 97
byte 1 0
align 1
LABELV $139
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 38
byte 1 32
byte 1 105
byte 1 110
byte 1 115
byte 1 112
byte 1 105
byte 1 114
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 98
byte 1 121
byte 1 10
byte 1 77
byte 1 105
byte 1 99
byte 1 104
byte 1 97
byte 1 101
byte 1 108
byte 1 32
byte 1 72
byte 1 111
byte 1 102
byte 1 102
byte 1 109
byte 1 97
byte 1 110
byte 1 110
byte 1 10
byte 1 77
byte 1 97
byte 1 106
byte 1 111
byte 1 114
byte 1 42
byte 1 80
byte 1 97
byte 1 121
byte 1 110
byte 1 101
byte 1 10
byte 1 71
byte 1 246
byte 1 110
byte 1 101
byte 1 110
byte 1 231
byte 1 32
byte 1 71
byte 1 105
byte 1 114
byte 1 97
byte 1 121
byte 1 10
byte 1 83
byte 1 121
byte 1 97
byte 1 98
byte 1 104
byte 1 97
byte 1 10
byte 1 73
byte 1 97
byte 1 95
byte 1 76
byte 1 97
byte 1 110
byte 1 107
byte 1 121
byte 1 10
byte 1 74
byte 1 252
byte 1 114
byte 1 103
byte 1 101
byte 1 110
byte 1 32
byte 1 77
byte 1 101
byte 1 114
byte 1 115
byte 1 109
byte 1 97
byte 1 110
byte 1 110
byte 1 10
byte 1 68
byte 1 111
byte 1 110
byte 1 32
byte 1 34
byte 1 86
byte 1 105
byte 1 80
byte 1 114
byte 1 34
byte 1 32
byte 1 75
byte 1 97
byte 1 114
byte 1 97
byte 1 109
byte 1 10
byte 1 101
byte 1 116
byte 1 32
byte 1 97
byte 1 108
byte 1 46
byte 1 0
align 1
LABELV $138
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
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 98
byte 1 121
byte 1 10
byte 1 77
byte 1 97
byte 1 106
byte 1 111
byte 1 114
byte 1 42
byte 1 80
byte 1 97
byte 1 121
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $137
byte 1 104
byte 1 111
byte 1 111
byte 1 107
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 32
byte 1 98
byte 1 121
byte 1 10
byte 1 73
byte 1 97
byte 1 95
byte 1 76
byte 1 97
byte 1 110
byte 1 107
byte 1 121
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 73
byte 1 97
byte 1 32
byte 1 67
byte 1 108
byte 1 97
byte 1 110
byte 1 10
byte 1 119
byte 1 119
byte 1 119
byte 1 46
byte 1 105
byte 1 97
byte 1 99
byte 1 108
byte 1 97
byte 1 110
byte 1 46
byte 1 99
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $136
byte 1 108
byte 1 101
byte 1 110
byte 1 115
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 115
byte 1 32
byte 1 98
byte 1 121
byte 1 10
byte 1 71
byte 1 246
byte 1 110
byte 1 101
byte 1 110
byte 1 231
byte 1 32
byte 1 34
byte 1 71
byte 1 78
byte 1 67
byte 1 34
byte 1 32
byte 1 71
byte 1 105
byte 1 114
byte 1 97
byte 1 121
byte 1 10
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
byte 1 103
byte 1 110
byte 1 99
byte 1 0
align 1
LABELV $135
byte 1 109
byte 1 97
byte 1 112
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 98
byte 1 121
byte 1 10
byte 1 77
byte 1 105
byte 1 99
byte 1 104
byte 1 97
byte 1 101
byte 1 108
byte 1 32
byte 1 72
byte 1 111
byte 1 102
byte 1 102
byte 1 109
byte 1 97
byte 1 110
byte 1 110
byte 1 10
byte 1 71
byte 1 246
byte 1 110
byte 1 101
byte 1 110
byte 1 231
byte 1 32
byte 1 71
byte 1 105
byte 1 114
byte 1 97
byte 1 121
byte 1 10
byte 1 87
byte 1 111
byte 1 108
byte 1 102
byte 1 87
byte 1 105
byte 1 110
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $134
byte 1 116
byte 1 101
byte 1 99
byte 1 104
byte 1 110
byte 1 105
byte 1 99
byte 1 97
byte 1 108
byte 1 32
byte 1 97
byte 1 115
byte 1 115
byte 1 105
byte 1 115
byte 1 116
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 32
byte 1 98
byte 1 121
byte 1 10
byte 1 77
byte 1 105
byte 1 99
byte 1 104
byte 1 97
byte 1 101
byte 1 108
byte 1 32
byte 1 34
byte 1 80
byte 1 97
byte 1 100
byte 1 97
byte 1 117
byte 1 116
byte 1 122
byte 1 34
byte 1 32
byte 1 72
byte 1 111
byte 1 102
byte 1 102
byte 1 109
byte 1 97
byte 1 110
byte 1 110
byte 1 0
align 1
LABELV $133
byte 1 97
byte 1 114
byte 1 116
byte 1 119
byte 1 111
byte 1 114
byte 1 107
byte 1 32
byte 1 38
byte 1 32
byte 1 115
byte 1 104
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 32
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 115
byte 1 32
byte 1 98
byte 1 121
byte 1 10
byte 1 74
byte 1 252
byte 1 114
byte 1 103
byte 1 101
byte 1 110
byte 1 32
byte 1 72
byte 1 111
byte 1 102
byte 1 102
byte 1 109
byte 1 97
byte 1 110
byte 1 110
byte 1 0
align 1
LABELV $132
byte 1 99
byte 1 111
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 98
byte 1 121
byte 1 10
byte 1 74
byte 1 252
byte 1 114
byte 1 103
byte 1 101
byte 1 110
byte 1 32
byte 1 72
byte 1 111
byte 1 102
byte 1 102
byte 1 109
byte 1 97
byte 1 110
byte 1 110
byte 1 10
byte 1 67
byte 1 114
byte 1 97
byte 1 110
byte 1 105
byte 1 117
byte 1 108
byte 1 0
align 1
LABELV $131
byte 1 99
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 10
byte 1 74
byte 1 252
byte 1 114
byte 1 103
byte 1 101
byte 1 110
byte 1 32
byte 1 34
byte 1 74
byte 1 117
byte 1 104
byte 1 111
byte 1 120
byte 1 34
byte 1 32
byte 1 72
byte 1 111
byte 1 102
byte 1 102
byte 1 109
byte 1 97
byte 1 110
byte 1 110
byte 1 0
align 1
LABELV $130
byte 1 79
byte 1 32
byte 1 32
byte 1 32
byte 1 80
byte 1 32
byte 1 32
byte 1 32
byte 1 69
byte 1 32
byte 1 32
byte 1 32
byte 1 78
byte 1 10
byte 1 72
byte 1 32
byte 1 32
byte 1 32
byte 1 85
byte 1 32
byte 1 32
byte 1 32
byte 1 78
byte 1 32
byte 1 32
byte 1 32
byte 1 84
byte 1 0
align 1
LABELV $121
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
LABELV $120
byte 1 84
byte 1 111
byte 1 32
byte 1 111
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 58
byte 1 32
byte 1 49
byte 1 45
byte 1 56
byte 1 48
byte 1 48
byte 1 45
byte 1 105
byte 1 100
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 32
byte 1 32
byte 1 32
byte 1 32
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
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 46
byte 1 99
byte 1 111
byte 1 109
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 119
byte 1 119
byte 1 119
byte 1 46
byte 1 105
byte 1 100
byte 1 115
byte 1 111
byte 1 102
byte 1 116
byte 1 119
byte 1 97
byte 1 114
byte 1 101
byte 1 46
byte 1 99
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $119
byte 1 69
byte 1 114
byte 1 105
byte 1 99
byte 1 32
byte 1 87
byte 1 101
byte 1 98
byte 1 98
byte 1 0
align 1
LABELV $118
byte 1 68
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 111
byte 1 112
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 65
byte 1 115
byte 1 115
byte 1 105
byte 1 115
byte 1 116
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $117
byte 1 68
byte 1 111
byte 1 110
byte 1 110
byte 1 97
byte 1 32
byte 1 74
byte 1 97
byte 1 99
byte 1 107
byte 1 115
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $116
byte 1 66
byte 1 105
byte 1 122
byte 1 32
byte 1 65
byte 1 115
byte 1 115
byte 1 105
byte 1 115
byte 1 116
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 105
byte 1 100
byte 1 32
byte 1 77
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $115
byte 1 77
byte 1 97
byte 1 114
byte 1 116
byte 1 121
byte 1 32
byte 1 83
byte 1 116
byte 1 114
byte 1 97
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $114
byte 1 68
byte 1 105
byte 1 114
byte 1 101
byte 1 99
byte 1 116
byte 1 111
byte 1 114
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 66
byte 1 117
byte 1 115
byte 1 105
byte 1 110
byte 1 101
byte 1 115
byte 1 115
byte 1 32
byte 1 68
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 111
byte 1 112
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $113
byte 1 84
byte 1 111
byte 1 100
byte 1 100
byte 1 32
byte 1 72
byte 1 111
byte 1 108
byte 1 108
byte 1 101
byte 1 110
byte 1 115
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $112
byte 1 67
byte 1 69
byte 1 79
byte 1 0
align 1
LABELV $111
byte 1 84
byte 1 105
byte 1 109
byte 1 32
byte 1 87
byte 1 105
byte 1 108
byte 1 108
byte 1 105
byte 1 116
byte 1 115
byte 1 44
byte 1 32
byte 1 67
byte 1 104
byte 1 114
byte 1 105
byte 1 115
byte 1 116
byte 1 105
byte 1 97
byte 1 110
byte 1 32
byte 1 65
byte 1 110
byte 1 116
byte 1 107
byte 1 111
byte 1 119
byte 1 44
byte 1 32
byte 1 80
byte 1 97
byte 1 117
byte 1 108
byte 1 32
byte 1 74
byte 1 97
byte 1 113
byte 1 117
byte 1 97
byte 1 121
byte 1 115
byte 1 0
align 1
LABELV $110
byte 1 76
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 32
byte 1 68
byte 1 101
byte 1 115
byte 1 105
byte 1 103
byte 1 110
byte 1 0
align 1
LABELV $109
byte 1 71
byte 1 114
byte 1 97
byte 1 101
byte 1 109
byte 1 101
byte 1 32
byte 1 68
byte 1 101
byte 1 118
byte 1 105
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $108
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 68
byte 1 101
byte 1 115
byte 1 105
byte 1 103
byte 1 110
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $107
byte 1 75
byte 1 101
byte 1 110
byte 1 110
byte 1 101
byte 1 116
byte 1 104
byte 1 32
byte 1 83
byte 1 99
byte 1 111
byte 1 116
byte 1 116
byte 1 44
byte 1 32
byte 1 83
byte 1 101
byte 1 110
byte 1 101
byte 1 99
byte 1 97
byte 1 32
byte 1 77
byte 1 101
byte 1 110
byte 1 97
byte 1 114
byte 1 100
byte 1 44
byte 1 32
byte 1 70
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 78
byte 1 105
byte 1 108
byte 1 115
byte 1 115
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $106
byte 1 65
byte 1 100
byte 1 114
byte 1 105
byte 1 97
byte 1 110
byte 1 32
byte 1 67
byte 1 97
byte 1 114
byte 1 109
byte 1 97
byte 1 99
byte 1 107
byte 1 44
byte 1 32
byte 1 75
byte 1 101
byte 1 118
byte 1 105
byte 1 110
byte 1 32
byte 1 67
byte 1 108
byte 1 111
byte 1 117
byte 1 100
byte 1 44
byte 1 0
align 1
LABELV $105
byte 1 65
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $104
byte 1 74
byte 1 111
byte 1 104
byte 1 110
byte 1 32
byte 1 67
byte 1 97
byte 1 114
byte 1 109
byte 1 97
byte 1 99
byte 1 107
byte 1 44
byte 1 32
byte 1 82
byte 1 111
byte 1 98
byte 1 101
byte 1 114
byte 1 116
byte 1 32
byte 1 65
byte 1 46
byte 1 32
byte 1 68
byte 1 117
byte 1 102
byte 1 102
byte 1 121
byte 1 44
byte 1 32
byte 1 74
byte 1 105
byte 1 109
byte 1 32
byte 1 68
byte 1 111
byte 1 115
byte 1 101
byte 1 39
byte 1 0
align 1
LABELV $103
byte 1 80
byte 1 114
byte 1 111
byte 1 103
byte 1 114
byte 1 97
byte 1 109
byte 1 109
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $102
byte 1 105
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
byte 1 32
byte 1 105
byte 1 115
byte 1 58
byte 1 0
align 1
LABELV $100
byte 1 113
byte 1 117
byte 1 105
byte 1 116
byte 1 10
byte 1 0
