data
align 4
LABELV gamecodetoui
byte 4 4
byte 4 2
byte 4 3
byte 4 0
byte 4 5
byte 4 1
byte 4 6
align 4
LABELV uitogamecode
byte 4 4
byte 4 6
byte 4 2
byte 4 3
byte 4 1
byte 4 5
byte 4 7
align 4
LABELV handicap_items
address $97
address $98
address $99
address $100
address $101
address $102
address $103
address $104
address $105
address $106
address $107
address $108
address $109
address $110
address $111
address $112
address $113
address $114
address $115
address $116
byte 4 0
code
proc PlayerSettings_DrawName 88 20
file "..\..\..\..\code\q3_ui\ui_playersettings.c"
line 87
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:#include "ui_local.h"
;4:
;5:#define ART_FRAMEL			"menu/art/frame2_l"
;6:#define ART_FRAMER			"menu/art/frame1_r"
;7:#define ART_MODEL0			"menu/art/model_0"
;8:#define ART_MODEL1			"menu/art/model_1"
;9:#define ART_BACK0			"menu/art/back_0"
;10:#define ART_BACK1			"menu/art/back_1"
;11:#define ART_FX_BASE			"menu/art/fx_base"
;12:#define ART_FX_BLUE			"menu/art/fx_blue"
;13:#define ART_FX_CYAN			"menu/art/fx_cyan"
;14:#define ART_FX_GREEN		"menu/art/fx_grn"
;15:#define ART_FX_RED			"menu/art/fx_red"
;16:#define ART_FX_TEAL			"menu/art/fx_teal"
;17:#define ART_FX_WHITE		"menu/art/fx_white"
;18:#define ART_FX_YELLOW		"menu/art/fx_yel"
;19:
;20:#define ID_NAME			10
;21:#define ID_HANDICAP		11
;22:#define ID_EFFECTS		12
;23:#define ID_BACK			13
;24:#define ID_MODEL		14
;25:
;26:#define MAX_NAMELENGTH	20
;27:
;28:
;29:typedef struct {
;30:	menuframework_s		menu;
;31:
;32:	menutext_s			banner;
;33:	menubitmap_s		framel;
;34:	menubitmap_s		framer;
;35:	menubitmap_s		player;
;36:
;37:	menufield_s			name;
;38:	menulist_s			handicap;
;39:	menulist_s			effects;
;40:
;41:	menubitmap_s		back;
;42:	menubitmap_s		model;
;43:	menubitmap_s		item_null;
;44:
;45:	qhandle_t			fxBasePic;
;46:	qhandle_t			fxPic[7];
;47:	playerInfo_t		playerinfo;
;48:	int					current_fx;
;49:	char				playerModel[MAX_QPATH];
;50:} playersettings_t;
;51:
;52:static playersettings_t	s_playersettings;
;53:
;54:static int gamecodetoui[] = {4,2,3,0,5,1,6};
;55:static int uitogamecode[] = {4,6,2,3,1,5,7};
;56:
;57:static const char *handicap_items[] = {
;58:	"None",
;59:	"95",
;60:	"90",
;61:	"85",
;62:	"80",
;63:	"75",
;64:	"70",
;65:	"65",
;66:	"60",
;67:	"55",
;68:	"50",
;69:	"45",
;70:	"40",
;71:	"35",
;72:	"30",
;73:	"25",
;74:	"20",
;75:	"15",
;76:	"10",
;77:	"5",
;78:	0
;79:};
;80:
;81:
;82:/*
;83:=================
;84:PlayerSettings_DrawName
;85:=================
;86:*/
;87:static void PlayerSettings_DrawName( void *self ) {
line 98
;88:	menufield_s		*f;
;89:	qboolean		focus;
;90:	int				style;
;91:	char			*txt;
;92:	char			c;
;93:	float			*color;
;94:	int				n;
;95:	int				basex, x, y;
;96:	char			name[32];
;97:
;98:	f = (menufield_s*)self;
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
line 99
;99:	basex = f->generic.x;
ADDRLP4 36
ADDRLP4 32
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 100
;100:	y = f->generic.y;
ADDRLP4 24
ADDRLP4 32
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 101
;101:	focus = (f->generic.parent->cursor == f->generic.menuPosition);
ADDRLP4 32
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
INDIRI4
ADDRLP4 32
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
NEI4 $119
ADDRLP4 72
CNSTI4 1
ASGNI4
ADDRGP4 $120
JUMPV
LABELV $119
ADDRLP4 72
CNSTI4 0
ASGNI4
LABELV $120
ADDRLP4 28
ADDRLP4 72
INDIRI4
ASGNI4
line 103
;102:
;103:	style = UI_LEFT|UI_SMALLFONT;
ADDRLP4 20
CNSTI4 16
ASGNI4
line 104
;104:	color = text_color_normal;
ADDRLP4 12
ADDRGP4 text_color_normal
ASGNP4
line 105
;105:	if( focus ) {
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $121
line 106
;106:		style |= UI_PULSE;
ADDRLP4 20
ADDRLP4 20
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
line 107
;107:		color = text_color_highlight;
ADDRLP4 12
ADDRGP4 text_color_highlight
ASGNP4
line 108
;108:	}
LABELV $121
line 110
;109:
;110:	UI_DrawProportionalString( basex, y, "Name", style, color );
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRGP4 $123
ARGP4
ADDRLP4 20
INDIRI4
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 113
;111:
;112:	// draw the actual name
;113:	basex += 64;
ADDRLP4 36
ADDRLP4 36
INDIRI4
CNSTI4 64
ADDI4
ASGNI4
line 114
;114:	y += PROP_HEIGHT;
ADDRLP4 24
ADDRLP4 24
INDIRI4
CNSTI4 27
ADDI4
ASGNI4
line 115
;115:	txt = f->field.buffer;
ADDRLP4 0
ADDRLP4 32
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
line 116
;116:	color = g_color_table[ColorIndex(COLOR_WHITE)];
ADDRLP4 12
ADDRGP4 g_color_table+112
ASGNP4
line 117
;117:	x = basex;
ADDRLP4 8
ADDRLP4 36
INDIRI4
ASGNI4
ADDRGP4 $126
JUMPV
LABELV $125
line 118
;118:	while ( (c = *txt) != 0 ) {
line 119
;119:		if ( !focus && Q_IsColorString( txt ) ) {
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $128
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $128
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $128
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $128
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 94
EQI4 $128
line 120
;120:			n = ColorIndex( *(txt+1) );
ADDRLP4 16
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
ASGNI4
line 121
;121:			if( n == 0 ) {
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $130
line 122
;122:				n = 7;
ADDRLP4 16
CNSTI4 7
ASGNI4
line 123
;123:			}
LABELV $130
line 124
;124:			color = g_color_table[n];
ADDRLP4 12
ADDRLP4 16
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
ASGNP4
line 125
;125:			txt += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 126
;126:			continue;
ADDRGP4 $126
JUMPV
LABELV $128
line 128
;127:		}
;128:		UI_DrawChar( x, y, c, style, color );
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 UI_DrawChar
CALLV
pop
line 129
;129:		txt++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 130
;130:		x += SMALLCHAR_WIDTH;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 8
ADDI4
ASGNI4
line 131
;131:	}
LABELV $126
line 118
ADDRLP4 80
ADDRLP4 0
INDIRP4
INDIRI1
ASGNI1
ADDRLP4 4
ADDRLP4 80
INDIRI1
ASGNI1
ADDRLP4 80
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $125
line 134
;132:
;133:	// draw cursor if we have focus
;134:	if( focus ) {
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $132
line 135
;135:		if ( trap_Key_GetOverstrikeMode() ) {
ADDRLP4 84
ADDRGP4 trap_Key_GetOverstrikeMode
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
EQI4 $134
line 136
;136:			c = 11;
ADDRLP4 4
CNSTI1 11
ASGNI1
line 137
;137:		} else {
ADDRGP4 $135
JUMPV
LABELV $134
line 138
;138:			c = 10;
ADDRLP4 4
CNSTI1 10
ASGNI1
line 139
;139:		}
LABELV $135
line 141
;140:
;141:		style &= ~UI_PULSE;
ADDRLP4 20
ADDRLP4 20
INDIRI4
CNSTI4 -16385
BANDI4
ASGNI4
line 142
;142:		style |= UI_BLINK;
ADDRLP4 20
ADDRLP4 20
INDIRI4
CNSTI4 4096
BORI4
ASGNI4
line 144
;143:
;144:		UI_DrawChar( basex + f->field.cursor * SMALLCHAR_WIDTH, y, c, style, color_white );
ADDRLP4 36
INDIRI4
ADDRLP4 32
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
CNSTI4 3
LSHI4
ADDI4
ARGI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawChar
CALLV
pop
line 145
;145:	}
LABELV $132
line 148
;146:
;147:	// draw at bottom also using proportional font
;148:	Q_strncpyz( name, f->field.buffer, sizeof(name) );
ADDRLP4 40
ARGP4
ADDRLP4 32
INDIRP4
CNSTI4 72
ADDP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 149
;149:	Q_CleanStr( name );
ADDRLP4 40
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 154
;150:	// JUHOX: don't use proportional font, we want the new charset
;151:#if 0
;152:	UI_DrawProportionalString( 320, 440, name, UI_CENTER|UI_BIGFONT, text_color_normal );
;153:#else
;154:	UI_DrawString(320, 420, name, UI_CENTER|UI_GIANTFONT, text_color_normal);
CNSTI4 320
ARGI4
CNSTI4 420
ARGI4
ADDRLP4 40
ARGP4
CNSTI4 65
ARGI4
ADDRGP4 text_color_normal
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 156
;155:#endif
;156:}
LABELV $117
endproc PlayerSettings_DrawName 88 20
proc PlayerSettings_DrawHandicap 32 20
line 164
;157:
;158:
;159:/*
;160:=================
;161:PlayerSettings_DrawHandicap
;162:=================
;163:*/
;164:static void PlayerSettings_DrawHandicap( void *self ) {
line 170
;165:	menulist_s		*item;
;166:	qboolean		focus;
;167:	int				style;
;168:	float			*color;
;169:
;170:	item = (menulist_s *)self;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 171
;171:	focus = (item->generic.parent->cursor == item->generic.menuPosition);
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
NEI4 $138
ADDRLP4 16
CNSTI4 1
ASGNI4
ADDRGP4 $139
JUMPV
LABELV $138
ADDRLP4 16
CNSTI4 0
ASGNI4
LABELV $139
ADDRLP4 12
ADDRLP4 16
INDIRI4
ASGNI4
line 173
;172:
;173:	style = UI_LEFT|UI_SMALLFONT;
ADDRLP4 4
CNSTI4 16
ASGNI4
line 174
;174:	color = text_color_normal;
ADDRLP4 8
ADDRGP4 text_color_normal
ASGNP4
line 175
;175:	if( focus ) {
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $140
line 176
;176:		style |= UI_PULSE;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
line 177
;177:		color = text_color_highlight;
ADDRLP4 8
ADDRGP4 text_color_highlight
ASGNP4
line 178
;178:	}
LABELV $140
line 180
;179:
;180:	UI_DrawProportionalString( item->generic.x, item->generic.y, "Handicap", style, color );
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRGP4 $142
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 181
;181:	UI_DrawProportionalString( item->generic.x + 64, item->generic.y + PROP_HEIGHT, handicap_items[item->curvalue], style, color );
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 64
ADDI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 27
ADDI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 handicap_items
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 182
;182:}
LABELV $136
endproc PlayerSettings_DrawHandicap 32 20
proc PlayerSettings_DrawEffects 36 20
line 190
;183:
;184:
;185:/*
;186:=================
;187:PlayerSettings_DrawEffects
;188:=================
;189:*/
;190:static void PlayerSettings_DrawEffects( void *self ) {
line 196
;191:	menulist_s		*item;
;192:	qboolean		focus;
;193:	int				style;
;194:	float			*color;
;195:
;196:	item = (menulist_s *)self;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 197
;197:	focus = (item->generic.parent->cursor == item->generic.menuPosition);
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
NEI4 $145
ADDRLP4 16
CNSTI4 1
ASGNI4
ADDRGP4 $146
JUMPV
LABELV $145
ADDRLP4 16
CNSTI4 0
ASGNI4
LABELV $146
ADDRLP4 12
ADDRLP4 16
INDIRI4
ASGNI4
line 199
;198:
;199:	style = UI_LEFT|UI_SMALLFONT;
ADDRLP4 4
CNSTI4 16
ASGNI4
line 200
;200:	color = text_color_normal;
ADDRLP4 8
ADDRGP4 text_color_normal
ASGNP4
line 201
;201:	if( focus ) {
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $147
line 202
;202:		style |= UI_PULSE;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
line 203
;203:		color = text_color_highlight;
ADDRLP4 8
ADDRGP4 text_color_highlight
ASGNP4
line 204
;204:	}
LABELV $147
line 206
;205:
;206:	UI_DrawProportionalString( item->generic.x, item->generic.y, "Effects", style, color );
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRGP4 $149
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 208
;207:
;208:	UI_DrawHandlePic( item->generic.x + 64, item->generic.y + PROP_HEIGHT + 8, 128, 8, s_playersettings.fxBasePic );
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 64
ADDI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 27
ADDI4
CNSTI4 8
ADDI4
CVIF4 4
ARGF4
CNSTF4 1124073472
ARGF4
CNSTF4 1090519040
ARGF4
ADDRGP4 s_playersettings+1548
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 209
;209:	UI_DrawHandlePic( item->generic.x + 64 + item->curvalue * 16 + 8, item->generic.y + PROP_HEIGHT + 6, 16, 12, s_playersettings.fxPic[item->curvalue] );
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 64
ADDI4
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDI4
CNSTI4 8
ADDI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 27
ADDI4
CNSTI4 6
ADDI4
CVIF4 4
ARGF4
CNSTF4 1098907648
ARGF4
CNSTF4 1094713344
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 s_playersettings+1552
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 210
;210:}
LABELV $143
endproc PlayerSettings_DrawEffects 36 20
proc PlayerSettings_DrawPlayer 88 28
line 218
;211:
;212:
;213:/*
;214:=================
;215:PlayerSettings_DrawPlayer
;216:=================
;217:*/
;218:static void PlayerSettings_DrawPlayer( void *self ) {
line 223
;219:	menubitmap_s	*b;
;220:	vec3_t			viewangles;
;221:	char			buf[MAX_QPATH];
;222:
;223:	trap_Cvar_VariableStringBuffer( "model", buf, sizeof( buf ) );
ADDRGP4 $153
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 224
;224:	if ( strcmp( buf, s_playersettings.playerModel ) != 0 ) {
ADDRLP4 4
ARGP4
ADDRGP4 s_playersettings+2692
ARGP4
ADDRLP4 80
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 0
EQI4 $154
line 225
;225:		UI_PlayerInfo_SetModel( &s_playersettings.playerinfo, buf );
ADDRGP4 s_playersettings+1580
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 UI_PlayerInfo_SetModel
CALLV
pop
line 226
;226:		strcpy( s_playersettings.playerModel, buf );
ADDRGP4 s_playersettings+2692
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 228
;227:
;228:		viewangles[YAW]   = 180 - 30;
ADDRLP4 68+4
CNSTF4 1125515264
ASGNF4
line 229
;229:		viewangles[PITCH] = 0;
ADDRLP4 68
CNSTF4 0
ASGNF4
line 230
;230:		viewangles[ROLL]  = 0;
ADDRLP4 68+8
CNSTF4 0
ASGNF4
line 231
;231:		UI_PlayerInfo_SetInfo( &s_playersettings.playerinfo, LEGS_IDLE, TORSO_STAND, viewangles, vec3_origin, WP_MACHINEGUN, qfalse );
ADDRGP4 s_playersettings+1580
ARGP4
CNSTI4 22
ARGI4
CNSTI4 11
ARGI4
ADDRLP4 68
ARGP4
ADDRGP4 vec3_origin
ARGP4
CNSTI4 2
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 UI_PlayerInfo_SetInfo
CALLV
pop
line 232
;232:	}
LABELV $154
line 234
;233:
;234:	b = (menubitmap_s*) self;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 235
;235:	UI_DrawPlayer( b->generic.x, b->generic.y, b->width, b->height, &s_playersettings.playerinfo, uis.realtime/2 );
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
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
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 s_playersettings+1580
ARGP4
ADDRGP4 uis+4
INDIRI4
CNSTI4 2
DIVI4
ARGI4
ADDRGP4 UI_DrawPlayer
CALLV
pop
line 236
;236:}
LABELV $152
endproc PlayerSettings_DrawPlayer 88 28
proc PlayerSettings_SaveChanges 0 8
line 244
;237:
;238:
;239:/*
;240:=================
;241:PlayerSettings_SaveChanges
;242:=================
;243:*/
;244:static void PlayerSettings_SaveChanges( void ) {
line 246
;245:	// name
;246:	trap_Cvar_Set( "name", s_playersettings.name.field.buffer );
ADDRGP4 $165
ARGP4
ADDRGP4 s_playersettings+760+60+12
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 249
;247:
;248:	// handicap
;249:	trap_Cvar_SetValue( "handicap", 100 - s_playersettings.handicap.curvalue * 5 );
ADDRGP4 $169
ARGP4
CNSTI4 100
ADDRGP4 s_playersettings+1092+64
INDIRI4
CNSTI4 5
MULI4
SUBI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 252
;250:
;251:	// effects color
;252:	trap_Cvar_SetValue( "color1", uitogamecode[s_playersettings.effects.curvalue] );
ADDRGP4 $172
ARGP4
ADDRGP4 s_playersettings+1188+64
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uitogamecode
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 253
;253:	trap_Cvar_SetValue( "color2", uitogamecode[s_playersettings.effects.curvalue] );	// JUHOX
ADDRGP4 $175
ARGP4
ADDRGP4 s_playersettings+1188+64
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uitogamecode
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 254
;254:}
LABELV $164
endproc PlayerSettings_SaveChanges 0 8
proc PlayerSettings_MenuKey 8 8
line 262
;255:
;256:
;257:/*
;258:=================
;259:PlayerSettings_MenuKey
;260:=================
;261:*/
;262:static sfxHandle_t PlayerSettings_MenuKey( int key ) {
line 263
;263:	if( key == K_MOUSE2 || key == K_ESCAPE ) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $181
ADDRLP4 0
INDIRI4
CNSTI4 27
NEI4 $179
LABELV $181
line 264
;264:		PlayerSettings_SaveChanges();
ADDRGP4 PlayerSettings_SaveChanges
CALLV
pop
line 265
;265:	}
LABELV $179
line 266
;266:	return Menu_DefaultKey( &s_playersettings.menu, key );
ADDRGP4 s_playersettings
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 Menu_DefaultKey
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
RETI4
LABELV $178
endproc PlayerSettings_MenuKey 8 8
proc PlayerSettings_SetMenuItems 44 28
line 275
;267:}
;268:
;269:
;270:/*
;271:=================
;272:PlayerSettings_SetMenuItems
;273:=================
;274:*/
;275:static void PlayerSettings_SetMenuItems( void ) {
line 281
;276:	vec3_t	viewangles;
;277:	int		c;
;278:	int		h;
;279:
;280:	// name
;281:	Q_strncpyz( s_playersettings.name.field.buffer, UI_Cvar_VariableString("name"), sizeof(s_playersettings.name.field.buffer) );
ADDRGP4 $165
ARGP4
ADDRLP4 20
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 s_playersettings+760+60+12
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 284
;282:
;283:	// effects color
;284:	c = trap_Cvar_VariableValue( "color1" ) - 1;
ADDRGP4 $172
ARGP4
ADDRLP4 24
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 24
INDIRF4
CNSTF4 1065353216
SUBF4
CVFI4 4
ASGNI4
line 285
;285:	if( c < 0 || c > 6 ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $191
ADDRLP4 0
INDIRI4
CNSTI4 6
LEI4 $189
LABELV $191
line 286
;286:		c = 6;
ADDRLP4 0
CNSTI4 6
ASGNI4
line 287
;287:	}
LABELV $189
line 288
;288:	s_playersettings.effects.curvalue = gamecodetoui[c];
ADDRGP4 s_playersettings+1188+64
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gamecodetoui
ADDP4
INDIRI4
ASGNI4
line 291
;289:
;290:	// model/skin
;291:	memset( &s_playersettings.playerinfo, 0, sizeof(playerInfo_t) );
ADDRGP4 s_playersettings+1580
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1108
ARGI4
ADDRGP4 memset
CALLP4
pop
line 293
;292:	
;293:	viewangles[YAW]   = 180 - 30;
ADDRLP4 4+4
CNSTF4 1125515264
ASGNF4
line 294
;294:	viewangles[PITCH] = 0;
ADDRLP4 4
CNSTF4 0
ASGNF4
line 295
;295:	viewangles[ROLL]  = 0;
ADDRLP4 4+8
CNSTF4 0
ASGNF4
line 297
;296:
;297:	UI_PlayerInfo_SetModel( &s_playersettings.playerinfo, UI_Cvar_VariableString( "model" ) );
ADDRGP4 $153
ARGP4
ADDRLP4 32
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 s_playersettings+1580
ARGP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRGP4 UI_PlayerInfo_SetModel
CALLV
pop
line 298
;298:	UI_PlayerInfo_SetInfo( &s_playersettings.playerinfo, LEGS_IDLE, TORSO_STAND, viewangles, vec3_origin, WP_MACHINEGUN, qfalse );
ADDRGP4 s_playersettings+1580
ARGP4
CNSTI4 22
ARGI4
CNSTI4 11
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 vec3_origin
ARGP4
CNSTI4 2
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 UI_PlayerInfo_SetInfo
CALLV
pop
line 302
;299:
;300:
;301:	// handicap
;302:	h = Com_Clamp( 5, 100, trap_Cvar_VariableValue("handicap") );
ADDRGP4 $169
ARGP4
ADDRLP4 36
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 1084227584
ARGF4
CNSTF4 1120403456
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 40
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 40
INDIRF4
CVFI4 4
ASGNI4
line 303
;303:	s_playersettings.handicap.curvalue = 20 - h / 5;
ADDRGP4 s_playersettings+1092+64
CNSTI4 20
ADDRLP4 16
INDIRI4
CNSTI4 5
DIVI4
SUBI4
ASGNI4
line 304
;304:}
LABELV $182
endproc PlayerSettings_SetMenuItems 44 28
proc PlayerSettings_MenuEvent 12 36
line 312
;305:
;306:
;307:/*
;308:=================
;309:PlayerSettings_MenuEvent
;310:=================
;311:*/
;312:static void PlayerSettings_MenuEvent( void* ptr, int event ) {
line 313
;313:	if( event != QM_ACTIVATED ) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $202
line 314
;314:		return;
ADDRGP4 $201
JUMPV
LABELV $202
line 317
;315:	}
;316:
;317:	switch( ((menucommon_s*)ptr)->id ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 11
EQI4 $207
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $219
ADDRLP4 0
INDIRI4
CNSTI4 14
EQI4 $211
ADDRGP4 $204
JUMPV
LABELV $207
line 319
;318:	case ID_HANDICAP:
;319:		trap_Cvar_Set( "handicap", va( "%i", 100 - 25 * s_playersettings.handicap.curvalue ) );
ADDRGP4 $208
ARGP4
CNSTI4 100
ADDRGP4 s_playersettings+1092+64
INDIRI4
CNSTI4 25
MULI4
SUBI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $169
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 320
;320:		break;
ADDRGP4 $205
JUMPV
LABELV $211
line 323
;321:
;322:	case ID_MODEL:
;323:		PlayerSettings_SaveChanges();
ADDRGP4 PlayerSettings_SaveChanges
CALLV
pop
line 328
;324:		// JUHOX: call UI_PlayerModelMenu() with the new parameters
;325:#if !MONSTER_MODE
;326:		UI_PlayerModelMenu();
;327:#else
;328:		UI_PlayerModelMenu(
ADDRGP4 $212
ARGP4
ADDRGP4 s_playersettings+760+60+12
ARGP4
ADDRGP4 $153
ARGP4
ADDRGP4 $216
ARGP4
ADDRGP4 $217
ARGP4
ADDRGP4 $218
ARGP4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 UI_PlayerModelMenu
CALLV
pop
line 336
;329:			"PLAYER MODEL",
;330:			s_playersettings.name.field.buffer,
;331:			"model", "headmodel", "team_model", "team_headmodel",
;332:			NULL, 0,
;333:			WP_MACHINEGUN
;334:		);
;335:#endif
;336:		break;
ADDRGP4 $205
JUMPV
LABELV $219
line 339
;337:
;338:	case ID_BACK:
;339:		PlayerSettings_SaveChanges();
ADDRGP4 PlayerSettings_SaveChanges
CALLV
pop
line 340
;340:		UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 341
;341:		break;
LABELV $204
LABELV $205
line 343
;342:	}
;343:}
LABELV $201
endproc PlayerSettings_MenuEvent 12 36
proc PlayerSettings_MenuInit 4 12
line 351
;344:
;345:
;346:/*
;347:=================
;348:PlayerSettings_MenuInit
;349:=================
;350:*/
;351:static void PlayerSettings_MenuInit( void ) {
line 354
;352:	int		y;
;353:
;354:	memset(&s_playersettings,0,sizeof(playersettings_t));
ADDRGP4 s_playersettings
ARGP4
CNSTI4 0
ARGI4
CNSTI4 2756
ARGI4
ADDRGP4 memset
CALLP4
pop
line 356
;355:
;356:	PlayerSettings_Cache();
ADDRGP4 PlayerSettings_Cache
CALLV
pop
line 358
;357:
;358:	s_playersettings.menu.key        = PlayerSettings_MenuKey;
ADDRGP4 s_playersettings+400
ADDRGP4 PlayerSettings_MenuKey
ASGNP4
line 359
;359:	s_playersettings.menu.wrapAround = qtrue;
ADDRGP4 s_playersettings+404
CNSTI4 1
ASGNI4
line 360
;360:	s_playersettings.menu.fullscreen = qtrue;
ADDRGP4 s_playersettings+408
CNSTI4 1
ASGNI4
line 362
;361:
;362:	s_playersettings.banner.generic.type  = MTYPE_BTEXT;
ADDRGP4 s_playersettings+424
CNSTI4 10
ASGNI4
line 363
;363:	s_playersettings.banner.generic.x     = 320;
ADDRGP4 s_playersettings+424+12
CNSTI4 320
ASGNI4
line 364
;364:	s_playersettings.banner.generic.y     = 16;
ADDRGP4 s_playersettings+424+16
CNSTI4 16
ASGNI4
line 365
;365:	s_playersettings.banner.string        = "PLAYER SETTINGS";
ADDRGP4 s_playersettings+424+60
ADDRGP4 $231
ASGNP4
line 366
;366:	s_playersettings.banner.color         = color_white;
ADDRGP4 s_playersettings+424+68
ADDRGP4 color_white
ASGNP4
line 367
;367:	s_playersettings.banner.style         = UI_CENTER;
ADDRGP4 s_playersettings+424+64
CNSTI4 1
ASGNI4
line 369
;368:
;369:	s_playersettings.framel.generic.type  = MTYPE_BITMAP;
ADDRGP4 s_playersettings+496
CNSTI4 6
ASGNI4
line 370
;370:	s_playersettings.framel.generic.name  = ART_FRAMEL;
ADDRGP4 s_playersettings+496+4
ADDRGP4 $239
ASGNP4
line 371
;371:	s_playersettings.framel.generic.flags = QMF_LEFT_JUSTIFY|QMF_INACTIVE;
ADDRGP4 s_playersettings+496+44
CNSTU4 16388
ASGNU4
line 372
;372:	s_playersettings.framel.generic.x     = 0;
ADDRGP4 s_playersettings+496+12
CNSTI4 0
ASGNI4
line 373
;373:	s_playersettings.framel.generic.y     = 78;
ADDRGP4 s_playersettings+496+16
CNSTI4 78
ASGNI4
line 374
;374:	s_playersettings.framel.width         = 256;
ADDRGP4 s_playersettings+496+76
CNSTI4 256
ASGNI4
line 375
;375:	s_playersettings.framel.height        = 329;
ADDRGP4 s_playersettings+496+80
CNSTI4 329
ASGNI4
line 377
;376:
;377:	s_playersettings.framer.generic.type  = MTYPE_BITMAP;
ADDRGP4 s_playersettings+584
CNSTI4 6
ASGNI4
line 378
;378:	s_playersettings.framer.generic.name  = ART_FRAMER;
ADDRGP4 s_playersettings+584+4
ADDRGP4 $253
ASGNP4
line 379
;379:	s_playersettings.framer.generic.flags = QMF_LEFT_JUSTIFY|QMF_INACTIVE;
ADDRGP4 s_playersettings+584+44
CNSTU4 16388
ASGNU4
line 380
;380:	s_playersettings.framer.generic.x     = 376;
ADDRGP4 s_playersettings+584+12
CNSTI4 376
ASGNI4
line 381
;381:	s_playersettings.framer.generic.y     = 76;
ADDRGP4 s_playersettings+584+16
CNSTI4 76
ASGNI4
line 382
;382:	s_playersettings.framer.width         = 256;
ADDRGP4 s_playersettings+584+76
CNSTI4 256
ASGNI4
line 383
;383:	s_playersettings.framer.height        = 334;
ADDRGP4 s_playersettings+584+80
CNSTI4 334
ASGNI4
line 385
;384:
;385:	y = 144;
ADDRLP4 0
CNSTI4 144
ASGNI4
line 386
;386:	s_playersettings.name.generic.type			= MTYPE_FIELD;
ADDRGP4 s_playersettings+760
CNSTI4 4
ASGNI4
line 387
;387:	s_playersettings.name.generic.flags			= QMF_NODEFAULTINIT;
ADDRGP4 s_playersettings+760+44
CNSTU4 32768
ASGNU4
line 388
;388:	s_playersettings.name.generic.ownerdraw		= PlayerSettings_DrawName;
ADDRGP4 s_playersettings+760+56
ADDRGP4 PlayerSettings_DrawName
ASGNP4
line 389
;389:	s_playersettings.name.field.widthInChars	= MAX_NAMELENGTH;
ADDRGP4 s_playersettings+760+60+8
CNSTI4 20
ASGNI4
line 390
;390:	s_playersettings.name.field.maxchars		= MAX_NAMELENGTH;
ADDRGP4 s_playersettings+760+60+268
CNSTI4 20
ASGNI4
line 391
;391:	s_playersettings.name.generic.x				= 192;
ADDRGP4 s_playersettings+760+12
CNSTI4 192
ASGNI4
line 392
;392:	s_playersettings.name.generic.y				= y;
ADDRGP4 s_playersettings+760+16
ADDRLP4 0
INDIRI4
ASGNI4
line 393
;393:	s_playersettings.name.generic.left			= 192 - 8;
ADDRGP4 s_playersettings+760+20
CNSTI4 184
ASGNI4
line 394
;394:	s_playersettings.name.generic.top			= y - 8;
ADDRGP4 s_playersettings+760+24
ADDRLP4 0
INDIRI4
CNSTI4 8
SUBI4
ASGNI4
line 395
;395:	s_playersettings.name.generic.right			= 192 + 200;
ADDRGP4 s_playersettings+760+28
CNSTI4 392
ASGNI4
line 396
;396:	s_playersettings.name.generic.bottom		= y + 2 * PROP_HEIGHT;
ADDRGP4 s_playersettings+760+32
ADDRLP4 0
INDIRI4
CNSTI4 54
ADDI4
ASGNI4
line 398
;397:
;398:	y += 3 * PROP_HEIGHT;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 81
ADDI4
ASGNI4
line 399
;399:	s_playersettings.handicap.generic.type		= MTYPE_SPINCONTROL;
ADDRGP4 s_playersettings+1092
CNSTI4 3
ASGNI4
line 400
;400:	s_playersettings.handicap.generic.flags		= QMF_NODEFAULTINIT;
ADDRGP4 s_playersettings+1092+44
CNSTU4 32768
ASGNU4
line 401
;401:	s_playersettings.handicap.generic.id		= ID_HANDICAP;
ADDRGP4 s_playersettings+1092+8
CNSTI4 11
ASGNI4
line 402
;402:	s_playersettings.handicap.generic.ownerdraw	= PlayerSettings_DrawHandicap;
ADDRGP4 s_playersettings+1092+56
ADDRGP4 PlayerSettings_DrawHandicap
ASGNP4
line 403
;403:	s_playersettings.handicap.generic.x			= 192;
ADDRGP4 s_playersettings+1092+12
CNSTI4 192
ASGNI4
line 404
;404:	s_playersettings.handicap.generic.y			= y;
ADDRGP4 s_playersettings+1092+16
ADDRLP4 0
INDIRI4
ASGNI4
line 405
;405:	s_playersettings.handicap.generic.left		= 192 - 8;
ADDRGP4 s_playersettings+1092+20
CNSTI4 184
ASGNI4
line 406
;406:	s_playersettings.handicap.generic.top		= y - 8;
ADDRGP4 s_playersettings+1092+24
ADDRLP4 0
INDIRI4
CNSTI4 8
SUBI4
ASGNI4
line 407
;407:	s_playersettings.handicap.generic.right		= 192 + 200;
ADDRGP4 s_playersettings+1092+28
CNSTI4 392
ASGNI4
line 408
;408:	s_playersettings.handicap.generic.bottom	= y + 2 * PROP_HEIGHT;
ADDRGP4 s_playersettings+1092+32
ADDRLP4 0
INDIRI4
CNSTI4 54
ADDI4
ASGNI4
line 409
;409:	s_playersettings.handicap.numitems			= 20;
ADDRGP4 s_playersettings+1092+68
CNSTI4 20
ASGNI4
line 411
;410:
;411:	y += 3 * PROP_HEIGHT;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 81
ADDI4
ASGNI4
line 412
;412:	s_playersettings.effects.generic.type		= MTYPE_SPINCONTROL;
ADDRGP4 s_playersettings+1188
CNSTI4 3
ASGNI4
line 413
;413:	s_playersettings.effects.generic.flags		= QMF_NODEFAULTINIT;
ADDRGP4 s_playersettings+1188+44
CNSTU4 32768
ASGNU4
line 414
;414:	s_playersettings.effects.generic.id			= ID_EFFECTS;
ADDRGP4 s_playersettings+1188+8
CNSTI4 12
ASGNI4
line 415
;415:	s_playersettings.effects.generic.ownerdraw	= PlayerSettings_DrawEffects;
ADDRGP4 s_playersettings+1188+56
ADDRGP4 PlayerSettings_DrawEffects
ASGNP4
line 416
;416:	s_playersettings.effects.generic.x			= 192;
ADDRGP4 s_playersettings+1188+12
CNSTI4 192
ASGNI4
line 417
;417:	s_playersettings.effects.generic.y			= y;
ADDRGP4 s_playersettings+1188+16
ADDRLP4 0
INDIRI4
ASGNI4
line 418
;418:	s_playersettings.effects.generic.left		= 192 - 8;
ADDRGP4 s_playersettings+1188+20
CNSTI4 184
ASGNI4
line 419
;419:	s_playersettings.effects.generic.top		= y - 8;
ADDRGP4 s_playersettings+1188+24
ADDRLP4 0
INDIRI4
CNSTI4 8
SUBI4
ASGNI4
line 420
;420:	s_playersettings.effects.generic.right		= 192 + 200;
ADDRGP4 s_playersettings+1188+28
CNSTI4 392
ASGNI4
line 421
;421:	s_playersettings.effects.generic.bottom		= y + 2* PROP_HEIGHT;
ADDRGP4 s_playersettings+1188+32
ADDRLP4 0
INDIRI4
CNSTI4 54
ADDI4
ASGNI4
line 422
;422:	s_playersettings.effects.numitems			= 7;
ADDRGP4 s_playersettings+1188+68
CNSTI4 7
ASGNI4
line 424
;423:
;424:	s_playersettings.model.generic.type			= MTYPE_BITMAP;
ADDRGP4 s_playersettings+1372
CNSTI4 6
ASGNI4
line 425
;425:	s_playersettings.model.generic.name			= ART_MODEL0;
ADDRGP4 s_playersettings+1372+4
ADDRGP4 $332
ASGNP4
line 426
;426:	s_playersettings.model.generic.flags		= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_playersettings+1372+44
CNSTU4 272
ASGNU4
line 427
;427:	s_playersettings.model.generic.id			= ID_MODEL;
ADDRGP4 s_playersettings+1372+8
CNSTI4 14
ASGNI4
line 428
;428:	s_playersettings.model.generic.callback		= PlayerSettings_MenuEvent;
ADDRGP4 s_playersettings+1372+48
ADDRGP4 PlayerSettings_MenuEvent
ASGNP4
line 429
;429:	s_playersettings.model.generic.x			= 640;
ADDRGP4 s_playersettings+1372+12
CNSTI4 640
ASGNI4
line 430
;430:	s_playersettings.model.generic.y			= 480-64;
ADDRGP4 s_playersettings+1372+16
CNSTI4 416
ASGNI4
line 431
;431:	s_playersettings.model.width				= 128;
ADDRGP4 s_playersettings+1372+76
CNSTI4 128
ASGNI4
line 432
;432:	s_playersettings.model.height				= 64;
ADDRGP4 s_playersettings+1372+80
CNSTI4 64
ASGNI4
line 433
;433:	s_playersettings.model.focuspic				= ART_MODEL1;
ADDRGP4 s_playersettings+1372+60
ADDRGP4 $349
ASGNP4
line 435
;434:
;435:	s_playersettings.player.generic.type		= MTYPE_BITMAP;
ADDRGP4 s_playersettings+672
CNSTI4 6
ASGNI4
line 436
;436:	s_playersettings.player.generic.flags		= QMF_INACTIVE;
ADDRGP4 s_playersettings+672+44
CNSTU4 16384
ASGNU4
line 437
;437:	s_playersettings.player.generic.ownerdraw	= PlayerSettings_DrawPlayer;
ADDRGP4 s_playersettings+672+56
ADDRGP4 PlayerSettings_DrawPlayer
ASGNP4
line 438
;438:	s_playersettings.player.generic.x			= 400;
ADDRGP4 s_playersettings+672+12
CNSTI4 400
ASGNI4
line 439
;439:	s_playersettings.player.generic.y			= -40;
ADDRGP4 s_playersettings+672+16
CNSTI4 -40
ASGNI4
line 440
;440:	s_playersettings.player.width				= 32*10;
ADDRGP4 s_playersettings+672+76
CNSTI4 320
ASGNI4
line 441
;441:	s_playersettings.player.height				= 56*10;
ADDRGP4 s_playersettings+672+80
CNSTI4 560
ASGNI4
line 443
;442:
;443:	s_playersettings.back.generic.type			= MTYPE_BITMAP;
ADDRGP4 s_playersettings+1284
CNSTI4 6
ASGNI4
line 444
;444:	s_playersettings.back.generic.name			= ART_BACK0;
ADDRGP4 s_playersettings+1284+4
ADDRGP4 $366
ASGNP4
line 445
;445:	s_playersettings.back.generic.flags			= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_playersettings+1284+44
CNSTU4 260
ASGNU4
line 446
;446:	s_playersettings.back.generic.id			= ID_BACK;
ADDRGP4 s_playersettings+1284+8
CNSTI4 13
ASGNI4
line 447
;447:	s_playersettings.back.generic.callback		= PlayerSettings_MenuEvent;
ADDRGP4 s_playersettings+1284+48
ADDRGP4 PlayerSettings_MenuEvent
ASGNP4
line 448
;448:	s_playersettings.back.generic.x				= 0;
ADDRGP4 s_playersettings+1284+12
CNSTI4 0
ASGNI4
line 449
;449:	s_playersettings.back.generic.y				= 480-64;
ADDRGP4 s_playersettings+1284+16
CNSTI4 416
ASGNI4
line 450
;450:	s_playersettings.back.width					= 128;
ADDRGP4 s_playersettings+1284+76
CNSTI4 128
ASGNI4
line 451
;451:	s_playersettings.back.height				= 64;
ADDRGP4 s_playersettings+1284+80
CNSTI4 64
ASGNI4
line 452
;452:	s_playersettings.back.focuspic				= ART_BACK1;
ADDRGP4 s_playersettings+1284+60
ADDRGP4 $383
ASGNP4
line 454
;453:
;454:	s_playersettings.item_null.generic.type		= MTYPE_BITMAP;
ADDRGP4 s_playersettings+1460
CNSTI4 6
ASGNI4
line 455
;455:	s_playersettings.item_null.generic.flags	= QMF_LEFT_JUSTIFY|QMF_MOUSEONLY|QMF_SILENT;
ADDRGP4 s_playersettings+1460+44
CNSTU4 1050628
ASGNU4
line 456
;456:	s_playersettings.item_null.generic.x		= 0;
ADDRGP4 s_playersettings+1460+12
CNSTI4 0
ASGNI4
line 457
;457:	s_playersettings.item_null.generic.y		= 0;
ADDRGP4 s_playersettings+1460+16
CNSTI4 0
ASGNI4
line 458
;458:	s_playersettings.item_null.width			= 640;
ADDRGP4 s_playersettings+1460+76
CNSTI4 640
ASGNI4
line 459
;459:	s_playersettings.item_null.height			= 480;
ADDRGP4 s_playersettings+1460+80
CNSTI4 480
ASGNI4
line 461
;460:
;461:	Menu_AddItem( &s_playersettings.menu, &s_playersettings.banner );
ADDRGP4 s_playersettings
ARGP4
ADDRGP4 s_playersettings+424
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 462
;462:	Menu_AddItem( &s_playersettings.menu, &s_playersettings.framel );
ADDRGP4 s_playersettings
ARGP4
ADDRGP4 s_playersettings+496
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 463
;463:	Menu_AddItem( &s_playersettings.menu, &s_playersettings.framer );
ADDRGP4 s_playersettings
ARGP4
ADDRGP4 s_playersettings+584
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 465
;464:
;465:	Menu_AddItem( &s_playersettings.menu, &s_playersettings.name );
ADDRGP4 s_playersettings
ARGP4
ADDRGP4 s_playersettings+760
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 466
;466:	Menu_AddItem( &s_playersettings.menu, &s_playersettings.handicap );
ADDRGP4 s_playersettings
ARGP4
ADDRGP4 s_playersettings+1092
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 467
;467:	Menu_AddItem( &s_playersettings.menu, &s_playersettings.effects );
ADDRGP4 s_playersettings
ARGP4
ADDRGP4 s_playersettings+1188
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 468
;468:	Menu_AddItem( &s_playersettings.menu, &s_playersettings.model );
ADDRGP4 s_playersettings
ARGP4
ADDRGP4 s_playersettings+1372
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 469
;469:	Menu_AddItem( &s_playersettings.menu, &s_playersettings.back );
ADDRGP4 s_playersettings
ARGP4
ADDRGP4 s_playersettings+1284
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 471
;470:
;471:	Menu_AddItem( &s_playersettings.menu, &s_playersettings.player );
ADDRGP4 s_playersettings
ARGP4
ADDRGP4 s_playersettings+672
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 473
;472:
;473:	Menu_AddItem( &s_playersettings.menu, &s_playersettings.item_null );
ADDRGP4 s_playersettings
ARGP4
ADDRGP4 s_playersettings+1460
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 475
;474:
;475:	PlayerSettings_SetMenuItems();
ADDRGP4 PlayerSettings_SetMenuItems
CALLV
pop
line 476
;476:}
LABELV $220
endproc PlayerSettings_MenuInit 4 12
export PlayerSettings_Cache
proc PlayerSettings_Cache 32 4
line 484
;477:
;478:
;479:/*
;480:=================
;481:PlayerSettings_Cache
;482:=================
;483:*/
;484:void PlayerSettings_Cache( void ) {
line 485
;485:	trap_R_RegisterShaderNoMip( ART_FRAMEL );
ADDRGP4 $239
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 486
;486:	trap_R_RegisterShaderNoMip( ART_FRAMER );
ADDRGP4 $253
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 487
;487:	trap_R_RegisterShaderNoMip( ART_MODEL0 );
ADDRGP4 $332
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 488
;488:	trap_R_RegisterShaderNoMip( ART_MODEL1 );
ADDRGP4 $349
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 489
;489:	trap_R_RegisterShaderNoMip( ART_BACK0 );
ADDRGP4 $366
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 490
;490:	trap_R_RegisterShaderNoMip( ART_BACK1 );
ADDRGP4 $383
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 492
;491:
;492:	s_playersettings.fxBasePic = trap_R_RegisterShaderNoMip( ART_FX_BASE );
ADDRGP4 $407
ARGP4
ADDRLP4 0
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 s_playersettings+1548
ADDRLP4 0
INDIRI4
ASGNI4
line 493
;493:	s_playersettings.fxPic[0] = trap_R_RegisterShaderNoMip( ART_FX_RED );
ADDRGP4 $409
ARGP4
ADDRLP4 4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 s_playersettings+1552
ADDRLP4 4
INDIRI4
ASGNI4
line 494
;494:	s_playersettings.fxPic[1] = trap_R_RegisterShaderNoMip( ART_FX_YELLOW );
ADDRGP4 $412
ARGP4
ADDRLP4 8
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 s_playersettings+1552+4
ADDRLP4 8
INDIRI4
ASGNI4
line 495
;495:	s_playersettings.fxPic[2] = trap_R_RegisterShaderNoMip( ART_FX_GREEN );
ADDRGP4 $415
ARGP4
ADDRLP4 12
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 s_playersettings+1552+8
ADDRLP4 12
INDIRI4
ASGNI4
line 496
;496:	s_playersettings.fxPic[3] = trap_R_RegisterShaderNoMip( ART_FX_TEAL );
ADDRGP4 $418
ARGP4
ADDRLP4 16
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 s_playersettings+1552+12
ADDRLP4 16
INDIRI4
ASGNI4
line 497
;497:	s_playersettings.fxPic[4] = trap_R_RegisterShaderNoMip( ART_FX_BLUE );
ADDRGP4 $421
ARGP4
ADDRLP4 20
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 s_playersettings+1552+16
ADDRLP4 20
INDIRI4
ASGNI4
line 498
;498:	s_playersettings.fxPic[5] = trap_R_RegisterShaderNoMip( ART_FX_CYAN );
ADDRGP4 $424
ARGP4
ADDRLP4 24
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 s_playersettings+1552+20
ADDRLP4 24
INDIRI4
ASGNI4
line 499
;499:	s_playersettings.fxPic[6] = trap_R_RegisterShaderNoMip( ART_FX_WHITE );
ADDRGP4 $427
ARGP4
ADDRLP4 28
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 s_playersettings+1552+24
ADDRLP4 28
INDIRI4
ASGNI4
line 500
;500:}
LABELV $405
endproc PlayerSettings_Cache 32 4
export UI_PlayerSettingsMenu
proc UI_PlayerSettingsMenu 0 4
line 508
;501:
;502:
;503:/*
;504:=================
;505:UI_PlayerSettingsMenu
;506:=================
;507:*/
;508:void UI_PlayerSettingsMenu( void ) {
line 509
;509:	PlayerSettings_MenuInit();
ADDRGP4 PlayerSettings_MenuInit
CALLV
pop
line 510
;510:	UI_PushMenu( &s_playersettings.menu );
ADDRGP4 s_playersettings
ARGP4
ADDRGP4 UI_PushMenu
CALLV
pop
line 511
;511:}
LABELV $428
endproc UI_PlayerSettingsMenu 0 4
bss
align 4
LABELV s_playersettings
skip 2756
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
LABELV $427
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
byte 1 120
byte 1 95
byte 1 119
byte 1 104
byte 1 105
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $424
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
byte 1 120
byte 1 95
byte 1 99
byte 1 121
byte 1 97
byte 1 110
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
byte 1 102
byte 1 120
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $418
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
byte 1 120
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $415
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
byte 1 120
byte 1 95
byte 1 103
byte 1 114
byte 1 110
byte 1 0
align 1
LABELV $412
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
byte 1 120
byte 1 95
byte 1 121
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $409
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
byte 1 120
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $407
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
byte 1 120
byte 1 95
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $383
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
LABELV $366
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
LABELV $349
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
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 95
byte 1 49
byte 1 0
align 1
LABELV $332
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
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 95
byte 1 48
byte 1 0
align 1
LABELV $253
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
LABELV $239
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
LABELV $231
byte 1 80
byte 1 76
byte 1 65
byte 1 89
byte 1 69
byte 1 82
byte 1 32
byte 1 83
byte 1 69
byte 1 84
byte 1 84
byte 1 73
byte 1 78
byte 1 71
byte 1 83
byte 1 0
align 1
LABELV $218
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
LABELV $217
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
LABELV $216
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
LABELV $212
byte 1 80
byte 1 76
byte 1 65
byte 1 89
byte 1 69
byte 1 82
byte 1 32
byte 1 77
byte 1 79
byte 1 68
byte 1 69
byte 1 76
byte 1 0
align 1
LABELV $208
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $175
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 50
byte 1 0
align 1
LABELV $172
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 49
byte 1 0
align 1
LABELV $169
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
LABELV $165
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $153
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $149
byte 1 69
byte 1 102
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $142
byte 1 72
byte 1 97
byte 1 110
byte 1 100
byte 1 105
byte 1 99
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $123
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $116
byte 1 53
byte 1 0
align 1
LABELV $115
byte 1 49
byte 1 48
byte 1 0
align 1
LABELV $114
byte 1 49
byte 1 53
byte 1 0
align 1
LABELV $113
byte 1 50
byte 1 48
byte 1 0
align 1
LABELV $112
byte 1 50
byte 1 53
byte 1 0
align 1
LABELV $111
byte 1 51
byte 1 48
byte 1 0
align 1
LABELV $110
byte 1 51
byte 1 53
byte 1 0
align 1
LABELV $109
byte 1 52
byte 1 48
byte 1 0
align 1
LABELV $108
byte 1 52
byte 1 53
byte 1 0
align 1
LABELV $107
byte 1 53
byte 1 48
byte 1 0
align 1
LABELV $106
byte 1 53
byte 1 53
byte 1 0
align 1
LABELV $105
byte 1 54
byte 1 48
byte 1 0
align 1
LABELV $104
byte 1 54
byte 1 53
byte 1 0
align 1
LABELV $103
byte 1 55
byte 1 48
byte 1 0
align 1
LABELV $102
byte 1 55
byte 1 53
byte 1 0
align 1
LABELV $101
byte 1 56
byte 1 48
byte 1 0
align 1
LABELV $100
byte 1 56
byte 1 53
byte 1 0
align 1
LABELV $99
byte 1 57
byte 1 48
byte 1 0
align 1
LABELV $98
byte 1 57
byte 1 53
byte 1 0
align 1
LABELV $97
byte 1 78
byte 1 111
byte 1 110
byte 1 101
byte 1 0
