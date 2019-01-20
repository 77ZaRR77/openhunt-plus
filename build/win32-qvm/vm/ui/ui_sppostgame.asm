data
export ui_medalNames
align 4
LABELV ui_medalNames
address $97
address $98
address $99
address $100
address $101
address $102
export ui_medalPicNames
align 4
LABELV ui_medalPicNames
address $103
address $104
address $105
address $106
address $107
address $108
export ui_medalSounds
align 4
LABELV ui_medalSounds
address $109
address $110
address $111
address $112
address $113
address $114
code
proc UI_SPPostgameMenu_AgainEvent 0 8
file "..\..\..\..\code\q3_ui\ui_sppostgame.c"
line 85
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:/*
;4:=============================================================================
;5:
;6:SINGLE PLAYER POSTGAME MENU
;7:
;8:=============================================================================
;9:*/
;10:
;11:#include "ui_local.h"
;12:
;13:#define MAX_SCOREBOARD_CLIENTS		8
;14:
;15:#define AWARD_PRESENTATION_TIME		2000
;16:
;17:#define ART_MENU0		"menu/art/menu_0"
;18:#define ART_MENU1		"menu/art/menu_1"
;19:#define ART_REPLAY0		"menu/art/replay_0"
;20:#define ART_REPLAY1		"menu/art/replay_1"
;21:#define ART_NEXT0		"menu/art/next_0"
;22:#define ART_NEXT1		"menu/art/next_1"
;23:
;24:#define ID_AGAIN		10
;25:#define ID_NEXT			11
;26:#define ID_MENU			12
;27:
;28:typedef struct {
;29:	menuframework_s	menu;
;30:	menubitmap_s	item_again;
;31:	menubitmap_s	item_next;
;32:	menubitmap_s	item_menu;
;33:
;34:	int				phase;
;35:	int				ignoreKeysTime;
;36:	int				starttime;
;37:	int				scoreboardtime;
;38:	int				serverId;
;39:
;40:	int				clientNums[MAX_SCOREBOARD_CLIENTS];
;41:	int				ranks[MAX_SCOREBOARD_CLIENTS];
;42:	int				scores[MAX_SCOREBOARD_CLIENTS];
;43:
;44:	char			placeNames[3][64];
;45:
;46:	int				level;
;47:	int				numClients;
;48:	int				won;
;49:	int				numAwards;
;50:	int				awardsEarned[6];
;51:	int				awardsLevels[6];
;52:	qboolean		playedSound[6];
;53:	int				lastTier;
;54:	sfxHandle_t		winnerSound;
;55:} postgameMenuInfo_t;
;56:
;57:static postgameMenuInfo_t	postgameMenuInfo;
;58:static char					arenainfo[MAX_INFO_VALUE];
;59:
;60:char	*ui_medalNames[] = {"Accuracy", "Impressive", "Excellent", "Gauntlet", "Frags", "Perfect"};
;61:char	*ui_medalPicNames[] = {
;62:	"menu/medals/medal_accuracy",
;63:	"menu/medals/medal_impressive",
;64:	"menu/medals/medal_excellent",
;65:	"menu/medals/medal_gauntlet",
;66:	"menu/medals/medal_frags",
;67:	"menu/medals/medal_victory"
;68:};
;69:char	*ui_medalSounds[] = {
;70:	"sound/feedback/accuracy.wav",
;71:	"sound/feedback/impressive_a.wav",
;72:	"sound/feedback/excellent_a.wav",
;73:	"sound/feedback/gauntlet.wav",
;74:	"sound/feedback/frags.wav",
;75:	"sound/feedback/perfect.wav"
;76:};
;77:
;78:
;79:/*
;80:=================
;81:UI_SPPostgameMenu_AgainEvent
;82:=================
;83:*/
;84:static void UI_SPPostgameMenu_AgainEvent( void* ptr, int event )
;85:{
line 86
;86:	if (event != QM_ACTIVATED) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $116
line 87
;87:		return;
ADDRGP4 $115
JUMPV
LABELV $116
line 89
;88:	}
;89:	UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 90
;90:	trap_Cmd_ExecuteText( EXEC_APPEND, "map_restart 0\n" );
CNSTI4 2
ARGI4
ADDRGP4 $118
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 91
;91:}
LABELV $115
endproc UI_SPPostgameMenu_AgainEvent 0 8
proc UI_SPPostgameMenu_NextEvent 36 4
line 99
;92:
;93:
;94:/*
;95:=================
;96:UI_SPPostgameMenu_NextEvent
;97:=================
;98:*/
;99:static void UI_SPPostgameMenu_NextEvent( void* ptr, int event ) {
line 106
;100:	int			currentSet;
;101:	int			levelSet;
;102:	int			level;
;103:	int			currentLevel;
;104:	const char	*arenaInfo;
;105:
;106:	if (event != QM_ACTIVATED) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $120
line 107
;107:		return;
ADDRGP4 $119
JUMPV
LABELV $120
line 109
;108:	}
;109:	UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 112
;110:
;111:	// handle specially if we just won the training map
;112:	if( postgameMenuInfo.won == 0 ) {
ADDRGP4 postgameMenuInfo+1004
INDIRI4
CNSTI4 0
NEI4 $122
line 113
;113:		level = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 114
;114:	}
ADDRGP4 $123
JUMPV
LABELV $122
line 115
;115:	else {
line 116
;116:		level = postgameMenuInfo.level + 1;
ADDRLP4 4
ADDRGP4 postgameMenuInfo+996
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 117
;117:	}
LABELV $123
line 118
;118:	levelSet = level / ARENAS_PER_TIER;
ADDRLP4 8
ADDRLP4 4
INDIRI4
CNSTI4 4
DIVI4
ASGNI4
line 120
;119:
;120:	currentLevel = UI_GetCurrentGame();
ADDRLP4 20
ADDRGP4 UI_GetCurrentGame
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 20
INDIRI4
ASGNI4
line 121
;121:	if( currentLevel == -1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $126
line 122
;122:		currentLevel = postgameMenuInfo.level;
ADDRLP4 0
ADDRGP4 postgameMenuInfo+996
INDIRI4
ASGNI4
line 123
;123:	}
LABELV $126
line 124
;124:	currentSet = currentLevel / ARENAS_PER_TIER;
ADDRLP4 16
ADDRLP4 0
INDIRI4
CNSTI4 4
DIVI4
ASGNI4
line 126
;125:
;126:	if( levelSet > currentSet || levelSet == UI_GetNumSPTiers() ) {
ADDRLP4 8
INDIRI4
ADDRLP4 16
INDIRI4
GTI4 $131
ADDRLP4 28
ADDRGP4 UI_GetNumSPTiers
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
ADDRLP4 28
INDIRI4
NEI4 $129
LABELV $131
line 127
;127:		level = currentLevel;
ADDRLP4 4
ADDRLP4 0
INDIRI4
ASGNI4
line 128
;128:	}
LABELV $129
line 130
;129:
;130:	arenaInfo = UI_GetArenaInfoByNumber( level );
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 UI_GetArenaInfoByNumber
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 32
INDIRP4
ASGNP4
line 131
;131:	if ( !arenaInfo ) {
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $132
line 132
;132:		return;
ADDRGP4 $119
JUMPV
LABELV $132
line 135
;133:	}
;134:
;135:	UI_SPArena_Start( arenaInfo );
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 UI_SPArena_Start
CALLV
pop
line 136
;136:}
LABELV $119
endproc UI_SPPostgameMenu_NextEvent 36 4
proc UI_SPPostgameMenu_MenuEvent 0 8
line 145
;137:
;138:
;139:/*
;140:=================
;141:UI_SPPostgameMenu_MenuEvent
;142:=================
;143:*/
;144:static void UI_SPPostgameMenu_MenuEvent( void* ptr, int event )
;145:{
line 146
;146:	if (event != QM_ACTIVATED) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $135
line 147
;147:		return;
ADDRGP4 $134
JUMPV
LABELV $135
line 149
;148:	}
;149:	UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 150
;150:	trap_Cmd_ExecuteText( EXEC_APPEND, "disconnect; levelselect\n" );
CNSTI4 2
ARGI4
ADDRGP4 $137
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 151
;151:}
LABELV $134
endproc UI_SPPostgameMenu_MenuEvent 0 8
proc UI_SPPostgameMenu_MenuKey 8 8
line 159
;152:
;153:
;154:/*
;155:=================
;156:UI_SPPostgameMenu_MenuKey
;157:=================
;158:*/
;159:static sfxHandle_t UI_SPPostgameMenu_MenuKey( int key ) {
line 160
;160:	if ( uis.realtime < postgameMenuInfo.ignoreKeysTime ) {
ADDRGP4 uis+4
INDIRI4
ADDRGP4 postgameMenuInfo+692
INDIRI4
GEI4 $139
line 161
;161:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $138
JUMPV
LABELV $139
line 164
;162:	}
;163:
;164:	if( postgameMenuInfo.phase == 1 ) {
ADDRGP4 postgameMenuInfo+688
INDIRI4
CNSTI4 1
NEI4 $143
line 165
;165:		trap_Cmd_ExecuteText( EXEC_APPEND, "abort_podium\n" );
CNSTI4 2
ARGI4
ADDRGP4 $146
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 166
;166:		postgameMenuInfo.phase = 2;
ADDRGP4 postgameMenuInfo+688
CNSTI4 2
ASGNI4
line 167
;167:		postgameMenuInfo.starttime = uis.realtime;
ADDRGP4 postgameMenuInfo+696
ADDRGP4 uis+4
INDIRI4
ASGNI4
line 168
;168:		postgameMenuInfo.ignoreKeysTime	= uis.realtime + 250;
ADDRGP4 postgameMenuInfo+692
ADDRGP4 uis+4
INDIRI4
CNSTI4 250
ADDI4
ASGNI4
line 169
;169:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $138
JUMPV
LABELV $143
line 172
;170:	}
;171:
;172:	if( postgameMenuInfo.phase == 2 ) {
ADDRGP4 postgameMenuInfo+688
INDIRI4
CNSTI4 2
NEI4 $152
line 173
;173:		postgameMenuInfo.phase = 3;
ADDRGP4 postgameMenuInfo+688
CNSTI4 3
ASGNI4
line 174
;174:		postgameMenuInfo.starttime = uis.realtime;
ADDRGP4 postgameMenuInfo+696
ADDRGP4 uis+4
INDIRI4
ASGNI4
line 175
;175:		postgameMenuInfo.ignoreKeysTime	= uis.realtime + 250;
ADDRGP4 postgameMenuInfo+692
ADDRGP4 uis+4
INDIRI4
CNSTI4 250
ADDI4
ASGNI4
line 176
;176:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $138
JUMPV
LABELV $152
line 179
;177:	}
;178:
;179:	if( key == K_ESCAPE || key == K_MOUSE2 ) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 27
EQI4 $162
ADDRLP4 0
INDIRI4
CNSTI4 179
NEI4 $160
LABELV $162
line 180
;180:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $138
JUMPV
LABELV $160
line 183
;181:	}
;182:
;183:	return Menu_DefaultKey( &postgameMenuInfo.menu, key );
ADDRGP4 postgameMenuInfo
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
LABELV $138
endproc UI_SPPostgameMenu_MenuKey 8 8
data
align 4
LABELV medalLocations
byte 4 144
byte 4 448
byte 4 88
byte 4 504
byte 4 32
byte 4 560
code
proc UI_SPPostgameMenu_DrawAwardsMedals 36 20
line 189
;184:}
;185:
;186:
;187:static int medalLocations[6] = {144, 448, 88, 504, 32, 560};
;188:
;189:static void UI_SPPostgameMenu_DrawAwardsMedals( int max ) {
line 196
;190:	int		n;
;191:	int		medal;
;192:	int		amount;
;193:	int		x, y;
;194:	char	buf[16];
;195:
;196:	for( n = 0; n < max; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $167
JUMPV
LABELV $164
line 197
;197:		x = medalLocations[n];
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 medalLocations
ADDP4
INDIRI4
ASGNI4
line 198
;198:		y = 64;
ADDRLP4 12
CNSTI4 64
ASGNI4
line 199
;199:		medal = postgameMenuInfo.awardsEarned[n];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 postgameMenuInfo+1012
ADDP4
INDIRI4
ASGNI4
line 200
;200:		amount = postgameMenuInfo.awardsLevels[n];
ADDRLP4 32
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 postgameMenuInfo+1036
ADDP4
INDIRI4
ASGNI4
line 202
;201:
;202:		UI_DrawNamedPic( x, y, 48, 48, ui_medalPicNames[medal] );
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1111490560
ARGF4
CNSTF4 1111490560
ARGF4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 ui_medalPicNames
ADDP4
INDIRP4
ARGP4
ADDRGP4 UI_DrawNamedPic
CALLV
pop
line 204
;203:
;204:		if( medal == AWARD_ACCURACY ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $170
line 205
;205:			Com_sprintf( buf, sizeof(buf), "%i%%", amount );
ADDRLP4 16
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $172
ARGP4
ADDRLP4 32
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 206
;206:		}
ADDRGP4 $171
JUMPV
LABELV $170
line 207
;207:		else {
line 208
;208:			if( amount == 1 ) {
ADDRLP4 32
INDIRI4
CNSTI4 1
NEI4 $173
line 209
;209:				continue;
ADDRGP4 $165
JUMPV
LABELV $173
line 211
;210:			}
;211:			Com_sprintf( buf, sizeof(buf), "%i", amount );
ADDRLP4 16
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $175
ARGP4
ADDRLP4 32
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 212
;212:		}
LABELV $171
line 214
;213:
;214:		UI_DrawString( x + 24, y + 52, buf, UI_CENTER, color_yellow );
ADDRLP4 8
INDIRI4
CNSTI4 24
ADDI4
ARGI4
ADDRLP4 12
INDIRI4
CNSTI4 52
ADDI4
ARGI4
ADDRLP4 16
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 color_yellow
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 215
;215:	}
LABELV $165
line 196
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $167
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRI4
LTI4 $164
line 216
;216:}
LABELV $163
endproc UI_SPPostgameMenu_DrawAwardsMedals 36 20
proc UI_SPPostgameMenu_DrawAwardsPresentation 32 20
line 219
;217:
;218:
;219:static void UI_SPPostgameMenu_DrawAwardsPresentation( int timer ) {
line 224
;220:	int		awardNum;
;221:	int		atimer;
;222:	vec4_t	color;
;223:
;224:	awardNum = timer / AWARD_PRESENTATION_TIME;
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 2000
DIVI4
ASGNI4
line 225
;225:	atimer = timer % AWARD_PRESENTATION_TIME;
ADDRLP4 20
ADDRFP4 0
INDIRI4
CNSTI4 2000
MODI4
ASGNI4
line 227
;226:
;227:	color[0] = color[1] = color[2] = 1.0f;
ADDRLP4 24
CNSTF4 1065353216
ASGNF4
ADDRLP4 4+8
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 4
ADDRLP4 24
INDIRF4
ASGNF4
line 228
;228:	color[3] = (float)( AWARD_PRESENTATION_TIME - atimer ) / (float)AWARD_PRESENTATION_TIME;
ADDRLP4 4+12
CNSTI4 2000
ADDRLP4 20
INDIRI4
SUBI4
CVIF4 4
CNSTF4 973279855
MULF4
ASGNF4
line 229
;229:	UI_DrawProportionalString( 320, 64, ui_medalNames[postgameMenuInfo.awardsEarned[awardNum]], UI_CENTER, color );
CNSTI4 320
ARGI4
CNSTI4 64
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 postgameMenuInfo+1012
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 ui_medalNames
ADDP4
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 231
;230:
;231:	UI_SPPostgameMenu_DrawAwardsMedals( awardNum + 1 );
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 UI_SPPostgameMenu_DrawAwardsMedals
CALLV
pop
line 233
;232:
;233:	if( !postgameMenuInfo.playedSound[awardNum] ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 postgameMenuInfo+1060
ADDP4
INDIRI4
CNSTI4 0
NEI4 $181
line 234
;234:		postgameMenuInfo.playedSound[awardNum] = qtrue;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 postgameMenuInfo+1060
ADDP4
CNSTI4 1
ASGNI4
line 235
;235:		trap_S_StartLocalSound( trap_S_RegisterSound( ui_medalSounds[postgameMenuInfo.awardsEarned[awardNum]], qfalse ), CHAN_ANNOUNCER );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 postgameMenuInfo+1012
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 ui_medalSounds
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 28
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 236
;236:	}
LABELV $181
line 237
;237:}
LABELV $176
endproc UI_SPPostgameMenu_DrawAwardsPresentation 32 20
proc UI_SPPostgameMenu_MenuDrawScoreLine 1100 20
line 245
;238:
;239:
;240:/*
;241:=================
;242:UI_SPPostgameMenu_MenuDrawScoreLine
;243:=================
;244:*/
;245:static void UI_SPPostgameMenu_MenuDrawScoreLine( int n, int y ) {
line 250
;246:	int		rank;
;247:	char	name[64];
;248:	char	info[MAX_INFO_STRING];
;249:
;250:	if( n > (postgameMenuInfo.numClients + 1) ) {
ADDRFP4 0
INDIRI4
ADDRGP4 postgameMenuInfo+1000
INDIRI4
CNSTI4 1
ADDI4
LEI4 $187
line 251
;251:		n -= (postgameMenuInfo.numClients + 2);
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRGP4 postgameMenuInfo+1000
INDIRI4
CNSTI4 2
ADDI4
SUBI4
ASGNI4
line 252
;252:	}
LABELV $187
line 254
;253:
;254:	if( n >= postgameMenuInfo.numClients ) {
ADDRFP4 0
INDIRI4
ADDRGP4 postgameMenuInfo+1000
INDIRI4
LTI4 $191
line 255
;255:		return;
ADDRGP4 $186
JUMPV
LABELV $191
line 258
;256:	}
;257:
;258:	rank = postgameMenuInfo.ranks[n];
ADDRLP4 64
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 postgameMenuInfo+740
ADDP4
INDIRI4
ASGNI4
line 259
;259:	if( rank & RANK_TIED_FLAG ) {
ADDRLP4 64
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $195
line 260
;260:		UI_DrawString( 640 - 31 * SMALLCHAR_WIDTH, y, "(tie)", UI_LEFT|UI_SMALLFONT, color_white );
CNSTI4 392
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $197
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 261
;261:		rank &= ~RANK_TIED_FLAG;
ADDRLP4 64
ADDRLP4 64
INDIRI4
CNSTI4 -16385
BANDI4
ASGNI4
line 262
;262:	}
LABELV $195
line 263
;263:	trap_GetConfigString( CS_PLAYERS + postgameMenuInfo.clientNums[n], info, MAX_INFO_STRING );
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 postgameMenuInfo+708
ADDP4
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 68
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigString
CALLI4
pop
line 264
;264:	Q_strncpyz( name, Info_ValueForKey( info, "n" ), sizeof(name) );
ADDRLP4 68
ARGP4
ADDRGP4 $199
ARGP4
ADDRLP4 1092
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
ADDRLP4 1092
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 265
;265:	Q_CleanStr( name );
ADDRLP4 0
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 267
;266:
;267:	UI_DrawString( 640 - 25 * SMALLCHAR_WIDTH, y, va( "#%i: %-16s %2i", rank + 1, name, postgameMenuInfo.scores[n] ), UI_LEFT|UI_SMALLFONT, color_white );
ADDRGP4 $200
ARGP4
ADDRLP4 64
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 postgameMenuInfo+772
ADDP4
INDIRI4
ARGI4
ADDRLP4 1096
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 440
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 1096
INDIRP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 268
;268:}
LABELV $186
endproc UI_SPPostgameMenu_MenuDrawScoreLine 1100 20
proc UI_SPPostgameMenu_MenuDraw 1060 20
line 276
;269:
;270:
;271:/*
;272:=================
;273:UI_SPPostgameMenu_MenuDraw
;274:=================
;275:*/
;276:static void UI_SPPostgameMenu_MenuDraw( void ) {
line 282
;277:	int		timer;
;278:	int		serverId;
;279:	int		n;
;280:	char	info[MAX_INFO_STRING];
;281:
;282:	trap_GetConfigString( CS_SYSTEMINFO, info, sizeof(info) );
CNSTI4 1
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigString
CALLI4
pop
line 283
;283:	serverId = atoi( Info_ValueForKey( info, "sv_serverid" ) );
ADDRLP4 8
ARGP4
ADDRGP4 $203
ARGP4
ADDRLP4 1036
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1036
INDIRP4
ARGP4
ADDRLP4 1040
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1032
ADDRLP4 1040
INDIRI4
ASGNI4
line 284
;284:	if( serverId != postgameMenuInfo.serverId ) {
ADDRLP4 1032
INDIRI4
ADDRGP4 postgameMenuInfo+704
INDIRI4
EQI4 $204
line 285
;285:		UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 286
;286:		return;
ADDRGP4 $202
JUMPV
LABELV $204
line 290
;287:	}
;288:
;289:	// phase 1
;290:	if ( postgameMenuInfo.numClients > 2 ) {
ADDRGP4 postgameMenuInfo+1000
INDIRI4
CNSTI4 2
LEI4 $207
line 291
;291:		UI_DrawProportionalString( 510, 480 - 64 - PROP_HEIGHT, postgameMenuInfo.placeNames[2], UI_CENTER, color_white );
CNSTI4 510
ARGI4
CNSTI4 389
ARGI4
ADDRGP4 postgameMenuInfo+804+128
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 292
;292:	}
LABELV $207
line 293
;293:	UI_DrawProportionalString( 130, 480 - 64 - PROP_HEIGHT, postgameMenuInfo.placeNames[1], UI_CENTER, color_white );
CNSTI4 130
ARGI4
CNSTI4 389
ARGI4
ADDRGP4 postgameMenuInfo+804+64
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 294
;294:	UI_DrawProportionalString( 320, 480 - 64 - 2 * PROP_HEIGHT, postgameMenuInfo.placeNames[0], UI_CENTER, color_white );
CNSTI4 320
ARGI4
CNSTI4 362
ARGI4
ADDRGP4 postgameMenuInfo+804
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 296
;295:
;296:	if( postgameMenuInfo.phase == 1 ) {
ADDRGP4 postgameMenuInfo+688
INDIRI4
CNSTI4 1
NEI4 $215
line 297
;297:		timer = uis.realtime - postgameMenuInfo.starttime;
ADDRLP4 0
ADDRGP4 uis+4
INDIRI4
ADDRGP4 postgameMenuInfo+696
INDIRI4
SUBI4
ASGNI4
line 299
;298:
;299:		if( timer >= 1000 && postgameMenuInfo.winnerSound ) {
ADDRLP4 0
INDIRI4
CNSTI4 1000
LTI4 $220
ADDRGP4 postgameMenuInfo+1088
INDIRI4
CNSTI4 0
EQI4 $220
line 300
;300:			trap_S_StartLocalSound( postgameMenuInfo.winnerSound, CHAN_ANNOUNCER );
ADDRGP4 postgameMenuInfo+1088
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 301
;301:			postgameMenuInfo.winnerSound = 0;
ADDRGP4 postgameMenuInfo+1088
CNSTI4 0
ASGNI4
line 302
;302:		}
LABELV $220
line 304
;303:
;304:		if( timer < 5000 ) {
ADDRLP4 0
INDIRI4
CNSTI4 5000
GEI4 $225
line 305
;305:			return;
ADDRGP4 $202
JUMPV
LABELV $225
line 307
;306:		}
;307:		postgameMenuInfo.phase = 2;
ADDRGP4 postgameMenuInfo+688
CNSTI4 2
ASGNI4
line 308
;308:		postgameMenuInfo.starttime = uis.realtime;
ADDRGP4 postgameMenuInfo+696
ADDRGP4 uis+4
INDIRI4
ASGNI4
line 309
;309:	}
LABELV $215
line 312
;310:
;311:	// phase 2
;312:	if( postgameMenuInfo.phase == 2 ) {
ADDRGP4 postgameMenuInfo+688
INDIRI4
CNSTI4 2
NEI4 $230
line 313
;313:		timer = uis.realtime - postgameMenuInfo.starttime;
ADDRLP4 0
ADDRGP4 uis+4
INDIRI4
ADDRGP4 postgameMenuInfo+696
INDIRI4
SUBI4
ASGNI4
line 314
;314:		if( timer >= ( postgameMenuInfo.numAwards * AWARD_PRESENTATION_TIME ) ) {
ADDRLP4 0
INDIRI4
ADDRGP4 postgameMenuInfo+1008
INDIRI4
CNSTI4 2000
MULI4
LTI4 $235
line 316
;315:
;316:			if( timer < 5000 ) {
ADDRLP4 0
INDIRI4
CNSTI4 5000
GEI4 $238
line 317
;317:				return;
ADDRGP4 $202
JUMPV
LABELV $238
line 320
;318:			}
;319:
;320:			postgameMenuInfo.phase = 3;
ADDRGP4 postgameMenuInfo+688
CNSTI4 3
ASGNI4
line 321
;321:			postgameMenuInfo.starttime = uis.realtime;
ADDRGP4 postgameMenuInfo+696
ADDRGP4 uis+4
INDIRI4
ASGNI4
line 322
;322:		}
ADDRGP4 $236
JUMPV
LABELV $235
line 323
;323:		else {
line 324
;324:			UI_SPPostgameMenu_DrawAwardsPresentation( timer );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 UI_SPPostgameMenu_DrawAwardsPresentation
CALLV
pop
line 325
;325:		}
LABELV $236
line 326
;326:	}
LABELV $230
line 329
;327:
;328:	// phase 3
;329:	if( postgameMenuInfo.phase == 3 ) {
ADDRGP4 postgameMenuInfo+688
INDIRI4
CNSTI4 3
NEI4 $243
line 330
;330:		if( uis.demoversion ) {
ADDRGP4 uis+11484
INDIRI4
CNSTI4 0
EQI4 $246
line 331
;331:			if( postgameMenuInfo.won == 1 && UI_ShowTierVideo( 8 )) {
ADDRGP4 postgameMenuInfo+1004
INDIRI4
CNSTI4 1
NEI4 $247
CNSTI4 8
ARGI4
ADDRLP4 1044
ADDRGP4 UI_ShowTierVideo
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
EQI4 $247
line 332
;332:				trap_Cvar_Set( "nextmap", "" );
ADDRGP4 $252
ARGP4
ADDRGP4 $253
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 333
;333:				trap_Cmd_ExecuteText( EXEC_APPEND, "disconnect; cinematic demoEnd.RoQ\n" );
CNSTI4 2
ARGI4
ADDRGP4 $254
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 334
;334:				return;
ADDRGP4 $202
JUMPV
line 336
;335:			}
;336:		}
LABELV $246
line 337
;337:		else if( postgameMenuInfo.won > -1 && UI_ShowTierVideo( postgameMenuInfo.won + 1 )) {
ADDRGP4 postgameMenuInfo+1004
INDIRI4
CNSTI4 -1
LEI4 $255
ADDRGP4 postgameMenuInfo+1004
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 1044
ADDRGP4 UI_ShowTierVideo
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
EQI4 $255
line 338
;338:			if( postgameMenuInfo.won == postgameMenuInfo.lastTier ) {
ADDRGP4 postgameMenuInfo+1004
INDIRI4
ADDRGP4 postgameMenuInfo+1084
INDIRI4
NEI4 $259
line 339
;339:				trap_Cvar_Set( "nextmap", "" );
ADDRGP4 $252
ARGP4
ADDRGP4 $253
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 340
;340:				trap_Cmd_ExecuteText( EXEC_APPEND, "disconnect; cinematic end.RoQ\n" );
CNSTI4 2
ARGI4
ADDRGP4 $263
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 341
;341:				return;
ADDRGP4 $202
JUMPV
LABELV $259
line 344
;342:			}
;343:
;344:			trap_Cvar_SetValue( "ui_spSelection", postgameMenuInfo.won * ARENAS_PER_TIER );
ADDRGP4 $264
ARGP4
ADDRGP4 postgameMenuInfo+1004
INDIRI4
CNSTI4 2
LSHI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 345
;345:			trap_Cvar_Set( "nextmap", "levelselect" );
ADDRGP4 $252
ARGP4
ADDRGP4 $266
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 346
;346:			trap_Cmd_ExecuteText( EXEC_APPEND, va( "disconnect; cinematic tier%i.RoQ\n", postgameMenuInfo.won + 1 ) );
ADDRGP4 $267
ARGP4
ADDRGP4 postgameMenuInfo+1004
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 1048
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1048
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 347
;347:			return;
ADDRGP4 $202
JUMPV
LABELV $255
LABELV $247
line 350
;348:		}
;349:
;350:		postgameMenuInfo.item_again.generic.flags &= ~QMF_INACTIVE;
ADDRLP4 1048
ADDRGP4 postgameMenuInfo+424+44
ASGNP4
ADDRLP4 1048
INDIRP4
ADDRLP4 1048
INDIRP4
INDIRU4
CNSTU4 4294950911
BANDU4
ASGNU4
line 351
;351:		postgameMenuInfo.item_next.generic.flags &= ~QMF_INACTIVE;
ADDRLP4 1052
ADDRGP4 postgameMenuInfo+512+44
ASGNP4
ADDRLP4 1052
INDIRP4
ADDRLP4 1052
INDIRP4
INDIRU4
CNSTU4 4294950911
BANDU4
ASGNU4
line 352
;352:		postgameMenuInfo.item_menu.generic.flags &= ~QMF_INACTIVE;
ADDRLP4 1056
ADDRGP4 postgameMenuInfo+600+44
ASGNP4
ADDRLP4 1056
INDIRP4
ADDRLP4 1056
INDIRP4
INDIRU4
CNSTU4 4294950911
BANDU4
ASGNU4
line 354
;353:
;354:		UI_SPPostgameMenu_DrawAwardsMedals( postgameMenuInfo.numAwards );
ADDRGP4 postgameMenuInfo+1008
INDIRI4
ARGI4
ADDRGP4 UI_SPPostgameMenu_DrawAwardsMedals
CALLV
pop
line 356
;355:
;356:		Menu_Draw( &postgameMenuInfo.menu );
ADDRGP4 postgameMenuInfo
ARGP4
ADDRGP4 Menu_Draw
CALLV
pop
line 357
;357:	}
LABELV $243
line 360
;358:
;359:	// draw the scoreboard
;360:	if( !trap_Cvar_VariableValue( "ui_spScoreboard" ) ) {
ADDRGP4 $278
ARGP4
ADDRLP4 1044
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1044
INDIRF4
CNSTF4 0
NEF4 $276
line 361
;361:		return;
ADDRGP4 $202
JUMPV
LABELV $276
line 364
;362:	}
;363:
;364:	timer = uis.realtime - postgameMenuInfo.scoreboardtime;
ADDRLP4 0
ADDRGP4 uis+4
INDIRI4
ADDRGP4 postgameMenuInfo+700
INDIRI4
SUBI4
ASGNI4
line 365
;365:	if( postgameMenuInfo.numClients <= 3 ) {
ADDRGP4 postgameMenuInfo+1000
INDIRI4
CNSTI4 3
GTI4 $281
line 366
;366:		n = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 367
;367:	}
ADDRGP4 $282
JUMPV
LABELV $281
line 368
;368:	else {
line 369
;369:		n = timer / 1500 % (postgameMenuInfo.numClients + 2);
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 1500
DIVI4
ADDRGP4 postgameMenuInfo+1000
INDIRI4
CNSTI4 2
ADDI4
MODI4
ASGNI4
line 370
;370:	}
LABELV $282
line 371
;371:	UI_SPPostgameMenu_MenuDrawScoreLine( n, 0 );
ADDRLP4 4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 UI_SPPostgameMenu_MenuDrawScoreLine
CALLV
pop
line 372
;372:	UI_SPPostgameMenu_MenuDrawScoreLine( n + 1, 0 + SMALLCHAR_HEIGHT );
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 UI_SPPostgameMenu_MenuDrawScoreLine
CALLV
pop
line 373
;373:	UI_SPPostgameMenu_MenuDrawScoreLine( n + 2, 0 + 2 * SMALLCHAR_HEIGHT );
ADDRLP4 4
INDIRI4
CNSTI4 2
ADDI4
ARGI4
CNSTI4 32
ARGI4
ADDRGP4 UI_SPPostgameMenu_MenuDrawScoreLine
CALLV
pop
line 374
;374:}
LABELV $202
endproc UI_SPPostgameMenu_MenuDraw 1060 20
export UI_SPPostgameMenu_Cache
proc UI_SPPostgameMenu_Cache 12 8
line 382
;375:
;376:
;377:/*
;378:=================
;379:UI_SPPostgameMenu_Cache
;380:=================
;381:*/
;382:void UI_SPPostgameMenu_Cache( void ) {
line 386
;383:	int			n;
;384:	qboolean	buildscript;
;385:
;386:	buildscript = trap_Cvar_VariableValue("com_buildscript");
ADDRGP4 $286
ARGP4
ADDRLP4 8
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 8
INDIRF4
CVFI4 4
ASGNI4
line 392
;387:	// -JUHOX: precaching
;388:#if 0
;389:	buildscript |= (int) trap_Cvar_VariableValue("ui_precache");
;390:#endif
;391:
;392:	trap_R_RegisterShaderNoMip( ART_MENU0 );
ADDRGP4 $287
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 393
;393:	trap_R_RegisterShaderNoMip( ART_MENU1 );
ADDRGP4 $288
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 394
;394:	trap_R_RegisterShaderNoMip( ART_REPLAY0 );
ADDRGP4 $289
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 395
;395:	trap_R_RegisterShaderNoMip( ART_REPLAY1 );
ADDRGP4 $290
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 396
;396:	trap_R_RegisterShaderNoMip( ART_NEXT0 );
ADDRGP4 $291
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 397
;397:	trap_R_RegisterShaderNoMip( ART_NEXT1 );
ADDRGP4 $292
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 398
;398:	for( n = 0; n < 6; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $293
line 399
;399:		trap_R_RegisterShaderNoMip( ui_medalPicNames[n] );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 ui_medalPicNames
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 400
;400:		trap_S_RegisterSound( ui_medalSounds[n], qfalse );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 ui_medalSounds
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_S_RegisterSound
CALLI4
pop
line 401
;401:	}
LABELV $294
line 398
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 6
LTI4 $293
line 403
;402:
;403:	if( buildscript ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $297
line 404
;404:		trap_S_RegisterSound( "music/loss.wav", qfalse );
ADDRGP4 $299
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_S_RegisterSound
CALLI4
pop
line 405
;405:		trap_S_RegisterSound( "music/win.wav", qfalse );
ADDRGP4 $300
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_S_RegisterSound
CALLI4
pop
line 406
;406:		trap_S_RegisterSound( "sound/player/announce/youwin.wav", qfalse );
ADDRGP4 $301
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_S_RegisterSound
CALLI4
pop
line 407
;407:	}
LABELV $297
line 408
;408:}
LABELV $285
endproc UI_SPPostgameMenu_Cache 12 8
proc UI_SPPostgameMenu_Init 0 8
line 416
;409:
;410:
;411:/*
;412:=================
;413:UI_SPPostgameMenu_Init
;414:=================
;415:*/
;416:static void UI_SPPostgameMenu_Init( void ) {
line 417
;417:	postgameMenuInfo.menu.wrapAround	= qtrue;
ADDRGP4 postgameMenuInfo+404
CNSTI4 1
ASGNI4
line 418
;418:	postgameMenuInfo.menu.key			= UI_SPPostgameMenu_MenuKey;
ADDRGP4 postgameMenuInfo+400
ADDRGP4 UI_SPPostgameMenu_MenuKey
ASGNP4
line 419
;419:	postgameMenuInfo.menu.draw			= UI_SPPostgameMenu_MenuDraw;
ADDRGP4 postgameMenuInfo+396
ADDRGP4 UI_SPPostgameMenu_MenuDraw
ASGNP4
line 420
;420:	postgameMenuInfo.ignoreKeysTime		= uis.realtime + 1500;
ADDRGP4 postgameMenuInfo+692
ADDRGP4 uis+4
INDIRI4
CNSTI4 1500
ADDI4
ASGNI4
line 422
;421:
;422:	UI_SPPostgameMenu_Cache();
ADDRGP4 UI_SPPostgameMenu_Cache
CALLV
pop
line 424
;423:
;424:	postgameMenuInfo.item_menu.generic.type			= MTYPE_BITMAP;
ADDRGP4 postgameMenuInfo+600
CNSTI4 6
ASGNI4
line 425
;425:	postgameMenuInfo.item_menu.generic.name			= ART_MENU0;
ADDRGP4 postgameMenuInfo+600+4
ADDRGP4 $287
ASGNP4
line 426
;426:	postgameMenuInfo.item_menu.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_INACTIVE;
ADDRGP4 postgameMenuInfo+600+44
CNSTU4 16644
ASGNU4
line 427
;427:	postgameMenuInfo.item_menu.generic.x			= 0;
ADDRGP4 postgameMenuInfo+600+12
CNSTI4 0
ASGNI4
line 428
;428:	postgameMenuInfo.item_menu.generic.y			= 480-64;
ADDRGP4 postgameMenuInfo+600+16
CNSTI4 416
ASGNI4
line 429
;429:	postgameMenuInfo.item_menu.generic.callback		= UI_SPPostgameMenu_MenuEvent;
ADDRGP4 postgameMenuInfo+600+48
ADDRGP4 UI_SPPostgameMenu_MenuEvent
ASGNP4
line 430
;430:	postgameMenuInfo.item_menu.generic.id			= ID_MENU;
ADDRGP4 postgameMenuInfo+600+8
CNSTI4 12
ASGNI4
line 431
;431:	postgameMenuInfo.item_menu.width				= 128;
ADDRGP4 postgameMenuInfo+600+76
CNSTI4 128
ASGNI4
line 432
;432:	postgameMenuInfo.item_menu.height				= 64;
ADDRGP4 postgameMenuInfo+600+80
CNSTI4 64
ASGNI4
line 433
;433:	postgameMenuInfo.item_menu.focuspic				= ART_MENU1;
ADDRGP4 postgameMenuInfo+600+60
ADDRGP4 $288
ASGNP4
line 435
;434:
;435:	postgameMenuInfo.item_again.generic.type		= MTYPE_BITMAP;
ADDRGP4 postgameMenuInfo+424
CNSTI4 6
ASGNI4
line 436
;436:	postgameMenuInfo.item_again.generic.name		= ART_REPLAY0;
ADDRGP4 postgameMenuInfo+424+4
ADDRGP4 $289
ASGNP4
line 437
;437:	postgameMenuInfo.item_again.generic.flags		= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS|QMF_INACTIVE;
ADDRGP4 postgameMenuInfo+424+44
CNSTU4 16648
ASGNU4
line 438
;438:	postgameMenuInfo.item_again.generic.x			= 320;
ADDRGP4 postgameMenuInfo+424+12
CNSTI4 320
ASGNI4
line 439
;439:	postgameMenuInfo.item_again.generic.y			= 480-64;
ADDRGP4 postgameMenuInfo+424+16
CNSTI4 416
ASGNI4
line 440
;440:	postgameMenuInfo.item_again.generic.callback	= UI_SPPostgameMenu_AgainEvent;
ADDRGP4 postgameMenuInfo+424+48
ADDRGP4 UI_SPPostgameMenu_AgainEvent
ASGNP4
line 441
;441:	postgameMenuInfo.item_again.generic.id			= ID_AGAIN;
ADDRGP4 postgameMenuInfo+424+8
CNSTI4 10
ASGNI4
line 442
;442:	postgameMenuInfo.item_again.width				= 128;
ADDRGP4 postgameMenuInfo+424+76
CNSTI4 128
ASGNI4
line 443
;443:	postgameMenuInfo.item_again.height				= 64;
ADDRGP4 postgameMenuInfo+424+80
CNSTI4 64
ASGNI4
line 444
;444:	postgameMenuInfo.item_again.focuspic			= ART_REPLAY1;
ADDRGP4 postgameMenuInfo+424+60
ADDRGP4 $290
ASGNP4
line 446
;445:
;446:	postgameMenuInfo.item_next.generic.type			= MTYPE_BITMAP;
ADDRGP4 postgameMenuInfo+512
CNSTI4 6
ASGNI4
line 447
;447:	postgameMenuInfo.item_next.generic.name			= ART_NEXT0;
ADDRGP4 postgameMenuInfo+512+4
ADDRGP4 $291
ASGNP4
line 448
;448:	postgameMenuInfo.item_next.generic.flags		= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_INACTIVE;
ADDRGP4 postgameMenuInfo+512+44
CNSTU4 16656
ASGNU4
line 449
;449:	postgameMenuInfo.item_next.generic.x			= 640;
ADDRGP4 postgameMenuInfo+512+12
CNSTI4 640
ASGNI4
line 450
;450:	postgameMenuInfo.item_next.generic.y			= 480-64;
ADDRGP4 postgameMenuInfo+512+16
CNSTI4 416
ASGNI4
line 451
;451:	postgameMenuInfo.item_next.generic.callback		= UI_SPPostgameMenu_NextEvent;
ADDRGP4 postgameMenuInfo+512+48
ADDRGP4 UI_SPPostgameMenu_NextEvent
ASGNP4
line 452
;452:	postgameMenuInfo.item_next.generic.id			= ID_NEXT;
ADDRGP4 postgameMenuInfo+512+8
CNSTI4 11
ASGNI4
line 453
;453:	postgameMenuInfo.item_next.width				= 128;
ADDRGP4 postgameMenuInfo+512+76
CNSTI4 128
ASGNI4
line 454
;454:	postgameMenuInfo.item_next.height				= 64;
ADDRGP4 postgameMenuInfo+512+80
CNSTI4 64
ASGNI4
line 455
;455:	postgameMenuInfo.item_next.focuspic				= ART_NEXT1;
ADDRGP4 postgameMenuInfo+512+60
ADDRGP4 $292
ASGNP4
line 457
;456:
;457:	Menu_AddItem( &postgameMenuInfo.menu, ( void * )&postgameMenuInfo.item_menu );
ADDRGP4 postgameMenuInfo
ARGP4
ADDRGP4 postgameMenuInfo+600
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 458
;458:	Menu_AddItem( &postgameMenuInfo.menu, ( void * )&postgameMenuInfo.item_again );
ADDRGP4 postgameMenuInfo
ARGP4
ADDRGP4 postgameMenuInfo+424
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 459
;459:	Menu_AddItem( &postgameMenuInfo.menu, ( void * )&postgameMenuInfo.item_next );
ADDRGP4 postgameMenuInfo
ARGP4
ADDRGP4 postgameMenuInfo+512
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 460
;460:}
LABELV $302
endproc UI_SPPostgameMenu_Init 0 8
proc Prepname 1104 12
line 463
;461:
;462:
;463:static void Prepname( int index ) {
line 468
;464:	int		len;
;465:	char	name[64];
;466:	char	info[MAX_INFO_STRING];
;467:
;468:	trap_GetConfigString( CS_PLAYERS + postgameMenuInfo.clientNums[index], info, MAX_INFO_STRING );
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 postgameMenuInfo+708
ADDP4
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 68
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigString
CALLI4
pop
line 469
;469:	Q_strncpyz( name, Info_ValueForKey( info, "n" ), sizeof(name) );
ADDRLP4 68
ARGP4
ADDRGP4 $199
ARGP4
ADDRLP4 1092
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
ARGP4
ADDRLP4 1092
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 470
;470:	Q_CleanStr( name );
ADDRLP4 4
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 471
;471:	len = strlen( name );
ADDRLP4 4
ARGP4
ADDRLP4 1096
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 1096
INDIRI4
ASGNI4
ADDRGP4 $371
JUMPV
LABELV $370
line 473
;472:
;473:	while( len && UI_ProportionalStringWidth( name ) > 256 ) {
line 474
;474:		len--;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 475
;475:		name[len] = 0;
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
CNSTI1 0
ASGNI1
line 476
;476:	}
LABELV $371
line 473
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $373
ADDRLP4 4
ARGP4
ADDRLP4 1100
ADDRGP4 UI_ProportionalStringWidth
CALLI4
ASGNI4
ADDRLP4 1100
INDIRI4
CNSTI4 256
GTI4 $370
LABELV $373
line 478
;477:
;478:	Q_strncpyz( postgameMenuInfo.placeNames[index], name, sizeof(postgameMenuInfo.placeNames[index]) );
ADDRFP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 postgameMenuInfo+804
ADDP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 479
;479:}
LABELV $368
endproc Prepname 1104 12
export UI_SPPostgameMenu_f
proc UI_SPPostgameMenu_f 1244 12
line 487
;480:
;481:
;482:/*
;483:=================
;484:UI_SPPostgameMenu_f
;485:=================
;486:*/
;487:void UI_SPPostgameMenu_f( void ) {
line 497
;488:	int			playerGameRank;
;489:	int			playerClientNum;
;490:	int			n;
;491:	int			oldFrags, newFrags;
;492:	const char	*arena;
;493:	int			awardValues[6];
;494:	char		map[MAX_QPATH];
;495:	char		info[MAX_INFO_STRING];
;496:
;497:	memset( &postgameMenuInfo, 0, sizeof(postgameMenuInfo) );
ADDRGP4 postgameMenuInfo
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1092
ARGI4
ADDRGP4 memset
CALLP4
pop
line 499
;498:
;499:	trap_GetConfigString( CS_SYSTEMINFO, info, sizeof(info) );
CNSTI4 1
ARGI4
ADDRLP4 36
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigString
CALLI4
pop
line 500
;500:	postgameMenuInfo.serverId = atoi( Info_ValueForKey( info, "sv_serverid" ) );
ADDRLP4 36
ARGP4
ADDRGP4 $203
ARGP4
ADDRLP4 1136
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1136
INDIRP4
ARGP4
ADDRLP4 1140
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 postgameMenuInfo+704
ADDRLP4 1140
INDIRI4
ASGNI4
line 502
;501:
;502:	trap_GetConfigString( CS_SERVERINFO, info, sizeof(info) );
CNSTI4 0
ARGI4
ADDRLP4 36
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigString
CALLI4
pop
line 503
;503:	Q_strncpyz( map, Info_ValueForKey( info, "mapname" ), sizeof(map) );
ADDRLP4 36
ARGP4
ADDRGP4 $378
ARGP4
ADDRLP4 1144
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1064
ARGP4
ADDRLP4 1144
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 504
;504:	arena = UI_GetArenaInfoByMap( map );
ADDRLP4 1064
ARGP4
ADDRLP4 1148
ADDRGP4 UI_GetArenaInfoByMap
CALLP4
ASGNP4
ADDRLP4 1060
ADDRLP4 1148
INDIRP4
ASGNP4
line 505
;505:	if ( !arena ) {
ADDRLP4 1060
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $379
line 506
;506:		return;
ADDRGP4 $376
JUMPV
LABELV $379
line 508
;507:	}
;508:	Q_strncpyz( arenainfo, arena, sizeof(arenainfo) );
ADDRGP4 arenainfo
ARGP4
ADDRLP4 1060
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 510
;509:
;510:	postgameMenuInfo.level = atoi( Info_ValueForKey( arenainfo, "num" ) );
ADDRGP4 arenainfo
ARGP4
ADDRGP4 $382
ARGP4
ADDRLP4 1152
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1152
INDIRP4
ARGP4
ADDRLP4 1156
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 postgameMenuInfo+996
ADDRLP4 1156
INDIRI4
ASGNI4
line 512
;511:
;512:	postgameMenuInfo.numClients = atoi( UI_Argv( 1 ) );
CNSTI4 1
ARGI4
ADDRLP4 1160
ADDRGP4 UI_Argv
CALLP4
ASGNP4
ADDRLP4 1160
INDIRP4
ARGP4
ADDRLP4 1164
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 postgameMenuInfo+1000
ADDRLP4 1164
INDIRI4
ASGNI4
line 513
;513:	playerClientNum = atoi( UI_Argv( 2 ) );
CNSTI4 2
ARGI4
ADDRLP4 1168
ADDRGP4 UI_Argv
CALLP4
ASGNP4
ADDRLP4 1168
INDIRP4
ARGP4
ADDRLP4 1172
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 1172
INDIRI4
ASGNI4
line 514
;514:	playerGameRank = 8;		// in case they ended game as a spectator
ADDRLP4 32
CNSTI4 8
ASGNI4
line 516
;515:
;516:	if( postgameMenuInfo.numClients > MAX_SCOREBOARD_CLIENTS ) {
ADDRGP4 postgameMenuInfo+1000
INDIRI4
CNSTI4 8
LEI4 $384
line 517
;517:		postgameMenuInfo.numClients = MAX_SCOREBOARD_CLIENTS;
ADDRGP4 postgameMenuInfo+1000
CNSTI4 8
ASGNI4
line 518
;518:	}
LABELV $384
line 520
;519:
;520:	for( n = 0; n < postgameMenuInfo.numClients; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $391
JUMPV
LABELV $388
line 521
;521:		postgameMenuInfo.clientNums[n] = atoi( UI_Argv( 8 + n * 3 + 1 ) );
ADDRLP4 0
INDIRI4
CNSTI4 3
MULI4
CNSTI4 8
ADDI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 1180
ADDRGP4 UI_Argv
CALLP4
ASGNP4
ADDRLP4 1180
INDIRP4
ARGP4
ADDRLP4 1184
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 postgameMenuInfo+708
ADDP4
ADDRLP4 1184
INDIRI4
ASGNI4
line 522
;522:		postgameMenuInfo.ranks[n] = atoi( UI_Argv( 8 + n * 3 + 2 ) );
ADDRLP4 0
INDIRI4
CNSTI4 3
MULI4
CNSTI4 8
ADDI4
CNSTI4 2
ADDI4
ARGI4
ADDRLP4 1192
ADDRGP4 UI_Argv
CALLP4
ASGNP4
ADDRLP4 1192
INDIRP4
ARGP4
ADDRLP4 1196
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 postgameMenuInfo+740
ADDP4
ADDRLP4 1196
INDIRI4
ASGNI4
line 523
;523:		postgameMenuInfo.scores[n] = atoi( UI_Argv( 8 + n * 3 + 3 ) );
ADDRLP4 0
INDIRI4
CNSTI4 3
MULI4
CNSTI4 8
ADDI4
CNSTI4 3
ADDI4
ARGI4
ADDRLP4 1204
ADDRGP4 UI_Argv
CALLP4
ASGNP4
ADDRLP4 1204
INDIRP4
ARGP4
ADDRLP4 1208
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 postgameMenuInfo+772
ADDP4
ADDRLP4 1208
INDIRI4
ASGNI4
line 525
;524:
;525:		if( postgameMenuInfo.clientNums[n] == playerClientNum ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 postgameMenuInfo+708
ADDP4
INDIRI4
ADDRLP4 28
INDIRI4
NEI4 $396
line 526
;526:			playerGameRank = (postgameMenuInfo.ranks[n] & ~RANK_TIED_FLAG) + 1;
ADDRLP4 32
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 postgameMenuInfo+740
ADDP4
INDIRI4
CNSTI4 -16385
BANDI4
CNSTI4 1
ADDI4
ASGNI4
line 527
;527:		}
LABELV $396
line 528
;528:	}
LABELV $389
line 520
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $391
ADDRLP4 0
INDIRI4
ADDRGP4 postgameMenuInfo+1000
INDIRI4
LTI4 $388
line 530
;529:
;530:	UI_SetBestScore( postgameMenuInfo.level, playerGameRank );
ADDRGP4 postgameMenuInfo+996
INDIRI4
ARGI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRGP4 UI_SetBestScore
CALLV
pop
line 533
;531:
;532:	// process award stats and prepare presentation data
;533:	awardValues[AWARD_ACCURACY] = atoi( UI_Argv( 3 ) );
CNSTI4 3
ARGI4
ADDRLP4 1176
ADDRGP4 UI_Argv
CALLP4
ASGNP4
ADDRLP4 1176
INDIRP4
ARGP4
ADDRLP4 1180
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 1180
INDIRI4
ASGNI4
line 534
;534:	awardValues[AWARD_IMPRESSIVE] = atoi( UI_Argv( 4 ) );
CNSTI4 4
ARGI4
ADDRLP4 1184
ADDRGP4 UI_Argv
CALLP4
ASGNP4
ADDRLP4 1184
INDIRP4
ARGP4
ADDRLP4 1188
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4+4
ADDRLP4 1188
INDIRI4
ASGNI4
line 535
;535:	awardValues[AWARD_EXCELLENT] = atoi( UI_Argv( 5 ) );
CNSTI4 5
ARGI4
ADDRLP4 1192
ADDRGP4 UI_Argv
CALLP4
ASGNP4
ADDRLP4 1192
INDIRP4
ARGP4
ADDRLP4 1196
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4+8
ADDRLP4 1196
INDIRI4
ASGNI4
line 536
;536:	awardValues[AWARD_GAUNTLET] = atoi( UI_Argv( 6 ) );
CNSTI4 6
ARGI4
ADDRLP4 1200
ADDRGP4 UI_Argv
CALLP4
ASGNP4
ADDRLP4 1200
INDIRP4
ARGP4
ADDRLP4 1204
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4+12
ADDRLP4 1204
INDIRI4
ASGNI4
line 537
;537:	awardValues[AWARD_FRAGS] = atoi( UI_Argv( 7 ) );
CNSTI4 7
ARGI4
ADDRLP4 1208
ADDRGP4 UI_Argv
CALLP4
ASGNP4
ADDRLP4 1208
INDIRP4
ARGP4
ADDRLP4 1212
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4+16
ADDRLP4 1212
INDIRI4
ASGNI4
line 538
;538:	awardValues[AWARD_PERFECT] = atoi( UI_Argv( 8 ) );
CNSTI4 8
ARGI4
ADDRLP4 1216
ADDRGP4 UI_Argv
CALLP4
ASGNP4
ADDRLP4 1216
INDIRP4
ARGP4
ADDRLP4 1220
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4+20
ADDRLP4 1220
INDIRI4
ASGNI4
line 540
;539:
;540:	postgameMenuInfo.numAwards = 0;
ADDRGP4 postgameMenuInfo+1008
CNSTI4 0
ASGNI4
line 542
;541:
;542:	if( awardValues[AWARD_ACCURACY] >= 50 ) {
ADDRLP4 4
INDIRI4
CNSTI4 50
LTI4 $407
line 543
;543:		UI_LogAwardData( AWARD_ACCURACY, 1 );
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 UI_LogAwardData
CALLV
pop
line 544
;544:		postgameMenuInfo.awardsEarned[postgameMenuInfo.numAwards] = AWARD_ACCURACY;
ADDRGP4 postgameMenuInfo+1008
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 postgameMenuInfo+1012
ADDP4
CNSTI4 0
ASGNI4
line 545
;545:		postgameMenuInfo.awardsLevels[postgameMenuInfo.numAwards] = awardValues[AWARD_ACCURACY];
ADDRGP4 postgameMenuInfo+1008
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 postgameMenuInfo+1036
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 546
;546:		postgameMenuInfo.numAwards++;
ADDRLP4 1224
ADDRGP4 postgameMenuInfo+1008
ASGNP4
ADDRLP4 1224
INDIRP4
ADDRLP4 1224
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 547
;547:	}
LABELV $407
line 549
;548:
;549:	if( awardValues[AWARD_IMPRESSIVE] ) {
ADDRLP4 4+4
INDIRI4
CNSTI4 0
EQI4 $414
line 550
;550:		UI_LogAwardData( AWARD_IMPRESSIVE, awardValues[AWARD_IMPRESSIVE] );
CNSTI4 1
ARGI4
ADDRLP4 4+4
INDIRI4
ARGI4
ADDRGP4 UI_LogAwardData
CALLV
pop
line 551
;551:		postgameMenuInfo.awardsEarned[postgameMenuInfo.numAwards] = AWARD_IMPRESSIVE;
ADDRGP4 postgameMenuInfo+1008
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 postgameMenuInfo+1012
ADDP4
CNSTI4 1
ASGNI4
line 552
;552:		postgameMenuInfo.awardsLevels[postgameMenuInfo.numAwards] = awardValues[AWARD_IMPRESSIVE];
ADDRGP4 postgameMenuInfo+1008
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 postgameMenuInfo+1036
ADDP4
ADDRLP4 4+4
INDIRI4
ASGNI4
line 553
;553:		postgameMenuInfo.numAwards++;
ADDRLP4 1224
ADDRGP4 postgameMenuInfo+1008
ASGNP4
ADDRLP4 1224
INDIRP4
ADDRLP4 1224
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 554
;554:	}
LABELV $414
line 556
;555:
;556:	if( awardValues[AWARD_EXCELLENT] ) {
ADDRLP4 4+8
INDIRI4
CNSTI4 0
EQI4 $424
line 557
;557:		UI_LogAwardData( AWARD_EXCELLENT, awardValues[AWARD_EXCELLENT] );
CNSTI4 2
ARGI4
ADDRLP4 4+8
INDIRI4
ARGI4
ADDRGP4 UI_LogAwardData
CALLV
pop
line 558
;558:		postgameMenuInfo.awardsEarned[postgameMenuInfo.numAwards] = AWARD_EXCELLENT;
ADDRGP4 postgameMenuInfo+1008
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 postgameMenuInfo+1012
ADDP4
CNSTI4 2
ASGNI4
line 559
;559:		postgameMenuInfo.awardsLevels[postgameMenuInfo.numAwards] = awardValues[AWARD_EXCELLENT];
ADDRGP4 postgameMenuInfo+1008
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 postgameMenuInfo+1036
ADDP4
ADDRLP4 4+8
INDIRI4
ASGNI4
line 560
;560:		postgameMenuInfo.numAwards++;
ADDRLP4 1224
ADDRGP4 postgameMenuInfo+1008
ASGNP4
ADDRLP4 1224
INDIRP4
ADDRLP4 1224
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 561
;561:	}
LABELV $424
line 563
;562:
;563:	if( awardValues[AWARD_GAUNTLET] ) {
ADDRLP4 4+12
INDIRI4
CNSTI4 0
EQI4 $434
line 564
;564:		UI_LogAwardData( AWARD_GAUNTLET, awardValues[AWARD_GAUNTLET] );
CNSTI4 3
ARGI4
ADDRLP4 4+12
INDIRI4
ARGI4
ADDRGP4 UI_LogAwardData
CALLV
pop
line 565
;565:		postgameMenuInfo.awardsEarned[postgameMenuInfo.numAwards] = AWARD_GAUNTLET;
ADDRGP4 postgameMenuInfo+1008
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 postgameMenuInfo+1012
ADDP4
CNSTI4 3
ASGNI4
line 566
;566:		postgameMenuInfo.awardsLevels[postgameMenuInfo.numAwards] = awardValues[AWARD_GAUNTLET];
ADDRGP4 postgameMenuInfo+1008
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 postgameMenuInfo+1036
ADDP4
ADDRLP4 4+12
INDIRI4
ASGNI4
line 567
;567:		postgameMenuInfo.numAwards++;
ADDRLP4 1224
ADDRGP4 postgameMenuInfo+1008
ASGNP4
ADDRLP4 1224
INDIRP4
ADDRLP4 1224
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 568
;568:	}
LABELV $434
line 570
;569:
;570:	oldFrags = UI_GetAwardLevel( AWARD_FRAGS ) / 100;
CNSTI4 4
ARGI4
ADDRLP4 1224
ADDRGP4 UI_GetAwardLevel
CALLI4
ASGNI4
ADDRLP4 1132
ADDRLP4 1224
INDIRI4
CNSTI4 100
DIVI4
ASGNI4
line 571
;571:	UI_LogAwardData( AWARD_FRAGS, awardValues[AWARD_FRAGS] );
CNSTI4 4
ARGI4
ADDRLP4 4+16
INDIRI4
ARGI4
ADDRGP4 UI_LogAwardData
CALLV
pop
line 572
;572:	newFrags = UI_GetAwardLevel( AWARD_FRAGS ) / 100;
CNSTI4 4
ARGI4
ADDRLP4 1228
ADDRGP4 UI_GetAwardLevel
CALLI4
ASGNI4
ADDRLP4 1128
ADDRLP4 1228
INDIRI4
CNSTI4 100
DIVI4
ASGNI4
line 573
;573:	if( newFrags > oldFrags ) {
ADDRLP4 1128
INDIRI4
ADDRLP4 1132
INDIRI4
LEI4 $445
line 574
;574:		postgameMenuInfo.awardsEarned[postgameMenuInfo.numAwards] = AWARD_FRAGS;
ADDRGP4 postgameMenuInfo+1008
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 postgameMenuInfo+1012
ADDP4
CNSTI4 4
ASGNI4
line 575
;575:		postgameMenuInfo.awardsLevels[postgameMenuInfo.numAwards] = newFrags * 100;
ADDRGP4 postgameMenuInfo+1008
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 postgameMenuInfo+1036
ADDP4
ADDRLP4 1128
INDIRI4
CNSTI4 100
MULI4
ASGNI4
line 576
;576:		postgameMenuInfo.numAwards++;
ADDRLP4 1232
ADDRGP4 postgameMenuInfo+1008
ASGNP4
ADDRLP4 1232
INDIRP4
ADDRLP4 1232
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 577
;577:	}
LABELV $445
line 579
;578:
;579:	if( awardValues[AWARD_PERFECT] ) {
ADDRLP4 4+20
INDIRI4
CNSTI4 0
EQI4 $452
line 580
;580:		UI_LogAwardData( AWARD_PERFECT, 1 );
CNSTI4 5
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 UI_LogAwardData
CALLV
pop
line 581
;581:		postgameMenuInfo.awardsEarned[postgameMenuInfo.numAwards] = AWARD_PERFECT;
ADDRGP4 postgameMenuInfo+1008
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 postgameMenuInfo+1012
ADDP4
CNSTI4 5
ASGNI4
line 582
;582:		postgameMenuInfo.awardsLevels[postgameMenuInfo.numAwards] = 1;
ADDRGP4 postgameMenuInfo+1008
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 postgameMenuInfo+1036
ADDP4
CNSTI4 1
ASGNI4
line 583
;583:		postgameMenuInfo.numAwards++;
ADDRLP4 1232
ADDRGP4 postgameMenuInfo+1008
ASGNP4
ADDRLP4 1232
INDIRP4
ADDRLP4 1232
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 584
;584:	}
LABELV $452
line 586
;585:
;586:	if ( playerGameRank == 1 ) {
ADDRLP4 32
INDIRI4
CNSTI4 1
NEI4 $460
line 587
;587:		postgameMenuInfo.won = UI_TierCompleted( postgameMenuInfo.level );
ADDRGP4 postgameMenuInfo+996
INDIRI4
ARGI4
ADDRLP4 1232
ADDRGP4 UI_TierCompleted
CALLI4
ASGNI4
ADDRGP4 postgameMenuInfo+1004
ADDRLP4 1232
INDIRI4
ASGNI4
line 588
;588:	}
ADDRGP4 $461
JUMPV
LABELV $460
line 589
;589:	else {
line 590
;590:		postgameMenuInfo.won = -1;
ADDRGP4 postgameMenuInfo+1004
CNSTI4 -1
ASGNI4
line 591
;591:	}
LABELV $461
line 593
;592:
;593:	postgameMenuInfo.starttime = uis.realtime;
ADDRGP4 postgameMenuInfo+696
ADDRGP4 uis+4
INDIRI4
ASGNI4
line 594
;594:	postgameMenuInfo.scoreboardtime = uis.realtime;
ADDRGP4 postgameMenuInfo+700
ADDRGP4 uis+4
INDIRI4
ASGNI4
line 596
;595:
;596:	trap_Key_SetCatcher( KEYCATCH_UI );
CNSTI4 2
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 597
;597:	uis.menusp = 0;
ADDRGP4 uis+16
CNSTI4 0
ASGNI4
line 599
;598:
;599:	UI_SPPostgameMenu_Init();
ADDRGP4 UI_SPPostgameMenu_Init
CALLV
pop
line 600
;600:	UI_PushMenu( &postgameMenuInfo.menu );
ADDRGP4 postgameMenuInfo
ARGP4
ADDRGP4 UI_PushMenu
CALLV
pop
line 602
;601:
;602:	if ( playerGameRank == 1 ) {
ADDRLP4 32
INDIRI4
CNSTI4 1
NEI4 $470
line 603
;603:		Menu_SetCursorToItem( &postgameMenuInfo.menu, &postgameMenuInfo.item_next );
ADDRGP4 postgameMenuInfo
ARGP4
ADDRGP4 postgameMenuInfo+512
ARGP4
ADDRGP4 Menu_SetCursorToItem
CALLV
pop
line 604
;604:	}
ADDRGP4 $471
JUMPV
LABELV $470
line 605
;605:	else {
line 606
;606:		Menu_SetCursorToItem( &postgameMenuInfo.menu, &postgameMenuInfo.item_again );
ADDRGP4 postgameMenuInfo
ARGP4
ADDRGP4 postgameMenuInfo+424
ARGP4
ADDRGP4 Menu_SetCursorToItem
CALLV
pop
line 607
;607:	}
LABELV $471
line 609
;608:
;609:	Prepname( 0 );
CNSTI4 0
ARGI4
ADDRGP4 Prepname
CALLV
pop
line 610
;610:	Prepname( 1 );
CNSTI4 1
ARGI4
ADDRGP4 Prepname
CALLV
pop
line 611
;611:	Prepname( 2 );
CNSTI4 2
ARGI4
ADDRGP4 Prepname
CALLV
pop
line 613
;612:
;613:	if ( playerGameRank != 1 ) {
ADDRLP4 32
INDIRI4
CNSTI4 1
EQI4 $474
line 614
;614:		postgameMenuInfo.winnerSound = trap_S_RegisterSound( va( "sound/player/announce/%s_wins.wav", postgameMenuInfo.placeNames[0] ), qfalse );
ADDRGP4 $477
ARGP4
ADDRGP4 postgameMenuInfo+804
ARGP4
ADDRLP4 1232
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1232
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 1236
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 postgameMenuInfo+1088
ADDRLP4 1236
INDIRI4
ASGNI4
line 615
;615:		trap_Cmd_ExecuteText( EXEC_APPEND, "music music/loss\n" );
CNSTI4 2
ARGI4
ADDRGP4 $479
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 616
;616:	}
ADDRGP4 $475
JUMPV
LABELV $474
line 617
;617:	else {
line 618
;618:		postgameMenuInfo.winnerSound = trap_S_RegisterSound( "sound/player/announce/youwin.wav", qfalse );
ADDRGP4 $301
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 1232
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 postgameMenuInfo+1088
ADDRLP4 1232
INDIRI4
ASGNI4
line 619
;619:		trap_Cmd_ExecuteText( EXEC_APPEND, "music music/win\n" );
CNSTI4 2
ARGI4
ADDRGP4 $481
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 620
;620:	}
LABELV $475
line 622
;621:
;622:	postgameMenuInfo.phase = 1;
ADDRGP4 postgameMenuInfo+688
CNSTI4 1
ASGNI4
line 624
;623:
;624:	postgameMenuInfo.lastTier = UI_GetNumSPTiers();
ADDRLP4 1232
ADDRGP4 UI_GetNumSPTiers
CALLI4
ASGNI4
ADDRGP4 postgameMenuInfo+1084
ADDRLP4 1232
INDIRI4
ASGNI4
line 625
;625:	if ( UI_GetSpecialArenaInfo( "final" ) ) {
ADDRGP4 $486
ARGP4
ADDRLP4 1236
ADDRGP4 UI_GetSpecialArenaInfo
CALLP4
ASGNP4
ADDRLP4 1236
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $484
line 626
;626:		postgameMenuInfo.lastTier++;
ADDRLP4 1240
ADDRGP4 postgameMenuInfo+1084
ASGNP4
ADDRLP4 1240
INDIRP4
ADDRLP4 1240
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 627
;627:	}
LABELV $484
line 628
;628:}
LABELV $376
endproc UI_SPPostgameMenu_f 1244 12
bss
align 1
LABELV arenainfo
skip 1024
align 4
LABELV postgameMenuInfo
skip 1092
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
import UI_MainMenu
import MainMenu_Cache
import MenuField_Key
import MenuField_Draw
import MenuField_Init
import MField_Draw
import MField_CharEvent
import MField_KeyDownEvent
import MField_Clear
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
LABELV $486
byte 1 102
byte 1 105
byte 1 110
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $481
byte 1 109
byte 1 117
byte 1 115
byte 1 105
byte 1 99
byte 1 32
byte 1 109
byte 1 117
byte 1 115
byte 1 105
byte 1 99
byte 1 47
byte 1 119
byte 1 105
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $479
byte 1 109
byte 1 117
byte 1 115
byte 1 105
byte 1 99
byte 1 32
byte 1 109
byte 1 117
byte 1 115
byte 1 105
byte 1 99
byte 1 47
byte 1 108
byte 1 111
byte 1 115
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $477
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
byte 1 95
byte 1 119
byte 1 105
byte 1 110
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $382
byte 1 110
byte 1 117
byte 1 109
byte 1 0
align 1
LABELV $378
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $301
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
byte 1 121
byte 1 111
byte 1 117
byte 1 119
byte 1 105
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $300
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
LABELV $299
byte 1 109
byte 1 117
byte 1 115
byte 1 105
byte 1 99
byte 1 47
byte 1 108
byte 1 111
byte 1 115
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $292
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
LABELV $291
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
LABELV $290
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
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 95
byte 1 49
byte 1 0
align 1
LABELV $289
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
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 95
byte 1 48
byte 1 0
align 1
LABELV $288
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
byte 1 101
byte 1 110
byte 1 117
byte 1 95
byte 1 49
byte 1 0
align 1
LABELV $287
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
byte 1 101
byte 1 110
byte 1 117
byte 1 95
byte 1 48
byte 1 0
align 1
LABELV $286
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
LABELV $278
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 98
byte 1 111
byte 1 97
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $267
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
byte 1 59
byte 1 32
byte 1 99
byte 1 105
byte 1 110
byte 1 101
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 99
byte 1 32
byte 1 116
byte 1 105
byte 1 101
byte 1 114
byte 1 37
byte 1 105
byte 1 46
byte 1 82
byte 1 111
byte 1 81
byte 1 10
byte 1 0
align 1
LABELV $266
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
LABELV $264
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $263
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
byte 1 59
byte 1 32
byte 1 99
byte 1 105
byte 1 110
byte 1 101
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 99
byte 1 32
byte 1 101
byte 1 110
byte 1 100
byte 1 46
byte 1 82
byte 1 111
byte 1 81
byte 1 10
byte 1 0
align 1
LABELV $254
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
byte 1 59
byte 1 32
byte 1 99
byte 1 105
byte 1 110
byte 1 101
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 99
byte 1 32
byte 1 100
byte 1 101
byte 1 109
byte 1 111
byte 1 69
byte 1 110
byte 1 100
byte 1 46
byte 1 82
byte 1 111
byte 1 81
byte 1 10
byte 1 0
align 1
LABELV $253
byte 1 0
align 1
LABELV $252
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $203
byte 1 115
byte 1 118
byte 1 95
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 105
byte 1 100
byte 1 0
align 1
LABELV $200
byte 1 35
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 45
byte 1 49
byte 1 54
byte 1 115
byte 1 32
byte 1 37
byte 1 50
byte 1 105
byte 1 0
align 1
LABELV $199
byte 1 110
byte 1 0
align 1
LABELV $197
byte 1 40
byte 1 116
byte 1 105
byte 1 101
byte 1 41
byte 1 0
align 1
LABELV $175
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $172
byte 1 37
byte 1 105
byte 1 37
byte 1 37
byte 1 0
align 1
LABELV $146
byte 1 97
byte 1 98
byte 1 111
byte 1 114
byte 1 116
byte 1 95
byte 1 112
byte 1 111
byte 1 100
byte 1 105
byte 1 117
byte 1 109
byte 1 10
byte 1 0
align 1
LABELV $137
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
byte 1 59
byte 1 32
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
byte 1 10
byte 1 0
align 1
LABELV $118
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
LABELV $114
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 112
byte 1 101
byte 1 114
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $113
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $112
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 103
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $111
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 101
byte 1 120
byte 1 99
byte 1 101
byte 1 108
byte 1 108
byte 1 101
byte 1 110
byte 1 116
byte 1 95
byte 1 97
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $110
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 105
byte 1 109
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 105
byte 1 118
byte 1 101
byte 1 95
byte 1 97
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $109
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 97
byte 1 99
byte 1 99
byte 1 117
byte 1 114
byte 1 97
byte 1 99
byte 1 121
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $108
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 115
byte 1 47
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 95
byte 1 118
byte 1 105
byte 1 99
byte 1 116
byte 1 111
byte 1 114
byte 1 121
byte 1 0
align 1
LABELV $107
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 115
byte 1 47
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $106
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 115
byte 1 47
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 95
byte 1 103
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $105
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 115
byte 1 47
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 95
byte 1 101
byte 1 120
byte 1 99
byte 1 101
byte 1 108
byte 1 108
byte 1 101
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $104
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 115
byte 1 47
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 95
byte 1 105
byte 1 109
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 105
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $103
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 115
byte 1 47
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 95
byte 1 97
byte 1 99
byte 1 99
byte 1 117
byte 1 114
byte 1 97
byte 1 99
byte 1 121
byte 1 0
align 1
LABELV $102
byte 1 80
byte 1 101
byte 1 114
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $101
byte 1 70
byte 1 114
byte 1 97
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $100
byte 1 71
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $99
byte 1 69
byte 1 120
byte 1 99
byte 1 101
byte 1 108
byte 1 108
byte 1 101
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $98
byte 1 73
byte 1 109
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 105
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $97
byte 1 65
byte 1 99
byte 1 99
byte 1 117
byte 1 114
byte 1 97
byte 1 99
byte 1 121
byte 1 0
