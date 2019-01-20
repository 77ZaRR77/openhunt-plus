code
proc UI_AddBotsMenu_FightEvent 16 20
file "..\..\..\..\code\q3_ui\ui_addbots.c"
line 67
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:/*
;4:=======================================================================
;5:
;6:ADD BOTS MENU
;7:
;8:=======================================================================
;9:*/
;10:
;11:
;12:#include "ui_local.h"
;13:
;14:
;15:#define ART_BACK0			"menu/art/back_0"
;16:#define ART_BACK1			"menu/art/back_1"	
;17:#define ART_FIGHT0			"menu/art/accept_0"
;18:#define ART_FIGHT1			"menu/art/accept_1"
;19:#define ART_BACKGROUND		"menu/art/addbotframe"
;20:#define ART_ARROWS			"menu/art/arrows_vert_0"
;21:#define ART_ARROWUP			"menu/art/arrows_vert_top"
;22:#define ART_ARROWDOWN		"menu/art/arrows_vert_bot"
;23:
;24:#define ID_BACK				10
;25:#define ID_GO				11
;26:#define ID_LIST				12
;27:#define ID_UP				13
;28:#define ID_DOWN				14
;29:#define ID_SKILL			15
;30:#define ID_TEAM				16
;31:#define ID_BOTNAME0			20
;32:#define ID_BOTNAME1			21
;33:#define ID_BOTNAME2			22
;34:#define ID_BOTNAME3			23
;35:#define ID_BOTNAME4			24
;36:#define ID_BOTNAME5			25
;37:#define ID_BOTNAME6			26
;38:
;39:
;40:typedef struct {
;41:	menuframework_s	menu;
;42:	menubitmap_s	arrows;
;43:	menubitmap_s	up;
;44:	menubitmap_s	down;
;45:	menutext_s		bots[7];
;46:	menulist_s		skill;
;47:	menulist_s		team;
;48:	menubitmap_s	go;
;49:	menubitmap_s	back;
;50:
;51:	int				numBots;
;52:	int				delay;
;53:	int				baseBotNum;
;54:	int				selectedBotNum;
;55:	int				sortedBotNums[MAX_BOTS];
;56:	char			botnames[7][32];
;57:} addBotsMenuInfo_t;
;58:
;59:static addBotsMenuInfo_t	addBotsMenuInfo;
;60:
;61:
;62:/*
;63:=================
;64:UI_AddBotsMenu_FightEvent
;65:=================
;66:*/
;67:static void UI_AddBotsMenu_FightEvent( void* ptr, int event ) {
line 71
;68:	const char	*team;
;69:	int			skill;
;70:
;71:	if (event != QM_ACTIVATED) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $98
line 72
;72:		return;
ADDRGP4 $97
JUMPV
LABELV $98
line 75
;73:	}
;74:
;75:	team = addBotsMenuInfo.team.itemnames[addBotsMenuInfo.team.curvalue];
ADDRLP4 0
ADDRGP4 addBotsMenuInfo+1288+64
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 addBotsMenuInfo+1288+76
INDIRP4
ADDP4
INDIRP4
ASGNP4
line 76
;76:	skill = addBotsMenuInfo.skill.curvalue + 1;
ADDRLP4 4
ADDRGP4 addBotsMenuInfo+1192+64
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 78
;77:
;78:	trap_Cmd_ExecuteText( EXEC_APPEND, va("addbot %s %i %s %i\n",
ADDRGP4 $106
ARGP4
ADDRGP4 addBotsMenuInfo+1572
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 addBotsMenuInfo+5672
ADDP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 addBotsMenuInfo+1564
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 81
;79:		addBotsMenuInfo.botnames[addBotsMenuInfo.selectedBotNum], skill, team, addBotsMenuInfo.delay) );
;80:
;81:	addBotsMenuInfo.delay += 1500;
ADDRLP4 12
ADDRGP4 addBotsMenuInfo+1564
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1500
ADDI4
ASGNI4
line 82
;82:}
LABELV $97
endproc UI_AddBotsMenu_FightEvent 16 20
proc UI_AddBotsMenu_BotEvent 0 0
line 90
;83:
;84:
;85:/*
;86:=================
;87:UI_AddBotsMenu_BotEvent
;88:=================
;89:*/
;90:static void UI_AddBotsMenu_BotEvent( void* ptr, int event ) {
line 91
;91:	if (event != QM_ACTIVATED) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $112
line 92
;92:		return;
ADDRGP4 $111
JUMPV
LABELV $112
line 95
;93:	}
;94:
;95:	addBotsMenuInfo.bots[addBotsMenuInfo.selectedBotNum].color = color_orange;
ADDRGP4 addBotsMenuInfo+1572
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 addBotsMenuInfo+688+68
ADDP4
ADDRGP4 color_orange
ASGNP4
line 96
;96:	addBotsMenuInfo.selectedBotNum = ((menucommon_s*)ptr)->id - ID_BOTNAME0;
ADDRGP4 addBotsMenuInfo+1572
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 20
SUBI4
ASGNI4
line 97
;97:	addBotsMenuInfo.bots[addBotsMenuInfo.selectedBotNum].color = color_white;
ADDRGP4 addBotsMenuInfo+1572
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 addBotsMenuInfo+688+68
ADDP4
ADDRGP4 color_white
ASGNP4
line 98
;98:}
LABELV $111
endproc UI_AddBotsMenu_BotEvent 0 0
proc UI_AddBotsMenu_BackEvent 0 0
line 106
;99:
;100:
;101:/*
;102:=================
;103:UI_AddBotsMenu_BackEvent
;104:=================
;105:*/
;106:static void UI_AddBotsMenu_BackEvent( void* ptr, int event ) {
line 107
;107:	if (event != QM_ACTIVATED) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $122
line 108
;108:		return;
ADDRGP4 $121
JUMPV
LABELV $122
line 110
;109:	}
;110:	UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 111
;111:}
LABELV $121
endproc UI_AddBotsMenu_BackEvent 0 0
proc UI_AddBotsMenu_SetBotNames 16 12
line 119
;112:
;113:
;114:/*
;115:=================
;116:UI_AddBotsMenu_SetBotNames
;117:=================
;118:*/
;119:static void UI_AddBotsMenu_SetBotNames( void ) {
line 123
;120:	int			n;
;121:	const char	*info;
;122:
;123:	for ( n = 0; n < 7; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $125
line 124
;124:		info = UI_GetBotInfoByNumber( addBotsMenuInfo.sortedBotNums[addBotsMenuInfo.baseBotNum + n] );
ADDRGP4 addBotsMenuInfo+1568
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
CNSTI4 2
LSHI4
ADDRGP4 addBotsMenuInfo+1576
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 UI_GetBotInfoByNumber
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 125
;125:		Q_strncpyz( addBotsMenuInfo.botnames[n], Info_ValueForKey( info, "name" ), sizeof(addBotsMenuInfo.botnames[n]) );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $132
ARGP4
ADDRLP4 12
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 addBotsMenuInfo+5672
ADDP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 126
;126:	}
LABELV $126
line 123
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 7
LTI4 $125
line 128
;127:
;128:}
LABELV $124
endproc UI_AddBotsMenu_SetBotNames 16 12
proc UI_AddBotsMenu_UpEvent 4 0
line 136
;129:
;130:
;131:/*
;132:=================
;133:UI_AddBotsMenu_UpEvent
;134:=================
;135:*/
;136:static void UI_AddBotsMenu_UpEvent( void* ptr, int event ) {
line 137
;137:	if (event != QM_ACTIVATED) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $135
line 138
;138:		return;
ADDRGP4 $134
JUMPV
LABELV $135
line 141
;139:	}
;140:
;141:	if( addBotsMenuInfo.baseBotNum > 0 ) {
ADDRGP4 addBotsMenuInfo+1568
INDIRI4
CNSTI4 0
LEI4 $137
line 142
;142:		addBotsMenuInfo.baseBotNum--;
ADDRLP4 0
ADDRGP4 addBotsMenuInfo+1568
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 143
;143:		UI_AddBotsMenu_SetBotNames();
ADDRGP4 UI_AddBotsMenu_SetBotNames
CALLV
pop
line 144
;144:	}
LABELV $137
line 145
;145:}
LABELV $134
endproc UI_AddBotsMenu_UpEvent 4 0
proc UI_AddBotsMenu_DownEvent 4 0
line 153
;146:
;147:
;148:/*
;149:=================
;150:UI_AddBotsMenu_DownEvent
;151:=================
;152:*/
;153:static void UI_AddBotsMenu_DownEvent( void* ptr, int event ) {
line 154
;154:	if (event != QM_ACTIVATED) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $142
line 155
;155:		return;
ADDRGP4 $141
JUMPV
LABELV $142
line 158
;156:	}
;157:
;158:	if( addBotsMenuInfo.baseBotNum + 7 < addBotsMenuInfo.numBots ) {
ADDRGP4 addBotsMenuInfo+1568
INDIRI4
CNSTI4 7
ADDI4
ADDRGP4 addBotsMenuInfo+1560
INDIRI4
GEI4 $144
line 159
;159:		addBotsMenuInfo.baseBotNum++;
ADDRLP4 0
ADDRGP4 addBotsMenuInfo+1568
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 160
;160:		UI_AddBotsMenu_SetBotNames();
ADDRGP4 UI_AddBotsMenu_SetBotNames
CALLV
pop
line 161
;161:	}
LABELV $144
line 162
;162:}
LABELV $141
endproc UI_AddBotsMenu_DownEvent 4 0
proc UI_AddBotsMenu_SortCompare 44 8
line 170
;163:
;164:
;165:/*
;166:=================
;167:UI_AddBotsMenu_GetSortedBotNums
;168:=================
;169:*/
;170:static int QDECL UI_AddBotsMenu_SortCompare( const void *arg1, const void *arg2 ) {
line 175
;171:	int			num1, num2;
;172:	const char	*info1, *info2;
;173:	const char	*name1, *name2;
;174:
;175:	num1 = *(int *)arg1;
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 176
;176:	num2 = *(int *)arg2;
ADDRLP4 4
ADDRFP4 4
INDIRP4
INDIRI4
ASGNI4
line 178
;177:
;178:	info1 = UI_GetBotInfoByNumber( num1 );
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
line 179
;179:	info2 = UI_GetBotInfoByNumber( num2 );
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
line 181
;180:
;181:	name1 = Info_ValueForKey( info1, "name" );
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 $132
ARGP4
ADDRLP4 32
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 32
INDIRP4
ASGNP4
line 182
;182:	name2 = Info_ValueForKey( info2, "name" );
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 $132
ARGP4
ADDRLP4 36
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 36
INDIRP4
ASGNP4
line 184
;183:
;184:	return Q_stricmp( name1, name2 );
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
LABELV $149
endproc UI_AddBotsMenu_SortCompare 44 8
proc UI_AddBotsMenu_GetSortedBotNums 8 16
line 187
;185:}
;186:
;187:static void UI_AddBotsMenu_GetSortedBotNums( void ) {
line 191
;188:	int		n;
;189:
;190:	// initialize the array
;191:	for( n = 0; n < addBotsMenuInfo.numBots; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $154
JUMPV
LABELV $151
line 192
;192:		addBotsMenuInfo.sortedBotNums[n] = n;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 addBotsMenuInfo+1576
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 193
;193:	}
LABELV $152
line 191
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $154
ADDRLP4 0
INDIRI4
ADDRGP4 addBotsMenuInfo+1560
INDIRI4
LTI4 $151
line 195
;194:
;195:	qsort( addBotsMenuInfo.sortedBotNums, addBotsMenuInfo.numBots, sizeof(addBotsMenuInfo.sortedBotNums[0]), UI_AddBotsMenu_SortCompare );
ADDRGP4 addBotsMenuInfo+1576
ARGP4
ADDRGP4 addBotsMenuInfo+1560
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 UI_AddBotsMenu_SortCompare
ARGP4
ADDRGP4 qsort
CALLV
pop
line 196
;196:}
LABELV $150
endproc UI_AddBotsMenu_GetSortedBotNums 8 16
proc UI_AddBotsMenu_Draw 0 20
line 204
;197:
;198:
;199:/*
;200:=================
;201:UI_AddBotsMenu_Draw
;202:=================
;203:*/
;204:static void UI_AddBotsMenu_Draw( void ) {
line 205
;205:	UI_DrawBannerString( 320, 16, "ADD BOTS", UI_CENTER, color_white );
CNSTI4 320
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 $161
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawBannerString
CALLV
pop
line 206
;206:	UI_DrawNamedPic( 320-233, 240-166, 466, 332, ART_BACKGROUND );
CNSTF4 1118699520
ARGF4
CNSTF4 1116995584
ARGF4
CNSTF4 1139343360
ARGF4
CNSTF4 1134952448
ARGF4
ADDRGP4 $162
ARGP4
ADDRGP4 UI_DrawNamedPic
CALLV
pop
line 209
;207:
;208:	// standard menu drawing
;209:	Menu_Draw( &addBotsMenuInfo.menu );
ADDRGP4 addBotsMenuInfo
ARGP4
ADDRGP4 Menu_Draw
CALLV
pop
line 210
;210:}
LABELV $160
endproc UI_AddBotsMenu_Draw 0 20
data
align 4
LABELV skillNames
address $163
address $164
address $165
address $166
address $167
byte 4 0
align 4
LABELV teamNames1
address $168
byte 4 0
align 4
LABELV teamNames2
address $169
address $170
byte 4 0
align 4
LABELV teamNames3
address $171
byte 4 0
code
proc UI_AddBotsMenu_Init 1064 12
line 245
;211:
;212:	
;213:/*
;214:=================
;215:UI_AddBotsMenu_Init
;216:=================
;217:*/
;218:static const char *skillNames[] = {
;219:	"I Can Win",
;220:	"Bring It On",
;221:	"Hurt Me Plenty",
;222:	"Hardcore",
;223:	"Nightmare!",
;224:	0
;225:};
;226:
;227:static const char *teamNames1[] = {
;228:	"Free",
;229:	0
;230:};
;231:
;232:static const char *teamNames2[] = {
;233:	"Red",
;234:	"Blue",
;235:	0
;236:};
;237:
;238:#if MONSTER_MODE	// JUHOX: bot team names for STU
;239:static const char* teamNames3[] = {
;240:	"Hunters",
;241:	0
;242:};
;243:#endif
;244:
;245:static void UI_AddBotsMenu_Init( void ) {
line 252
;246:	int		n;
;247:	int		y;
;248:	int		gametype;
;249:	int		count;
;250:	char	info[MAX_INFO_STRING];
;251:
;252:	trap_GetConfigString(CS_SERVERINFO, info, MAX_INFO_STRING);   
CNSTI4 0
ARGI4
ADDRLP4 16
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigString
CALLI4
pop
line 253
;253:	gametype = atoi( Info_ValueForKey( info,"g_gametype" ) );
ADDRLP4 16
ARGP4
ADDRGP4 $173
ARGP4
ADDRLP4 1040
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 1044
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 1044
INDIRI4
ASGNI4
line 255
;254:
;255:	memset( &addBotsMenuInfo, 0 ,sizeof(addBotsMenuInfo) );
ADDRGP4 addBotsMenuInfo
ARGP4
CNSTI4 0
ARGI4
CNSTI4 5896
ARGI4
ADDRGP4 memset
CALLP4
pop
line 256
;256:	addBotsMenuInfo.menu.draw = UI_AddBotsMenu_Draw;
ADDRGP4 addBotsMenuInfo+396
ADDRGP4 UI_AddBotsMenu_Draw
ASGNP4
line 257
;257:	addBotsMenuInfo.menu.fullscreen = qfalse;
ADDRGP4 addBotsMenuInfo+408
CNSTI4 0
ASGNI4
line 258
;258:	addBotsMenuInfo.menu.wrapAround = qtrue;
ADDRGP4 addBotsMenuInfo+404
CNSTI4 1
ASGNI4
line 259
;259:	addBotsMenuInfo.delay = 1000;
ADDRGP4 addBotsMenuInfo+1564
CNSTI4 1000
ASGNI4
line 261
;260:
;261:	UI_AddBots_Cache();
ADDRGP4 UI_AddBots_Cache
CALLV
pop
line 263
;262:
;263:	addBotsMenuInfo.numBots = UI_GetNumBots();
ADDRLP4 1048
ADDRGP4 UI_GetNumBots
CALLI4
ASGNI4
ADDRGP4 addBotsMenuInfo+1560
ADDRLP4 1048
INDIRI4
ASGNI4
line 264
;264:	count = addBotsMenuInfo.numBots < 7 ? addBotsMenuInfo.numBots : 7;
ADDRGP4 addBotsMenuInfo+1560
INDIRI4
CNSTI4 7
GEI4 $182
ADDRLP4 1052
ADDRGP4 addBotsMenuInfo+1560
INDIRI4
ASGNI4
ADDRGP4 $183
JUMPV
LABELV $182
ADDRLP4 1052
CNSTI4 7
ASGNI4
LABELV $183
ADDRLP4 8
ADDRLP4 1052
INDIRI4
ASGNI4
line 266
;265:
;266:	addBotsMenuInfo.arrows.generic.type  = MTYPE_BITMAP;
ADDRGP4 addBotsMenuInfo+424
CNSTI4 6
ASGNI4
line 267
;267:	addBotsMenuInfo.arrows.generic.name  = ART_ARROWS;
ADDRGP4 addBotsMenuInfo+424+4
ADDRGP4 $187
ASGNP4
line 268
;268:	addBotsMenuInfo.arrows.generic.flags = QMF_INACTIVE;
ADDRGP4 addBotsMenuInfo+424+44
CNSTU4 16384
ASGNU4
line 269
;269:	addBotsMenuInfo.arrows.generic.x	 = 200;
ADDRGP4 addBotsMenuInfo+424+12
CNSTI4 200
ASGNI4
line 270
;270:	addBotsMenuInfo.arrows.generic.y	 = 128;
ADDRGP4 addBotsMenuInfo+424+16
CNSTI4 128
ASGNI4
line 271
;271:	addBotsMenuInfo.arrows.width  	     = 64;
ADDRGP4 addBotsMenuInfo+424+76
CNSTI4 64
ASGNI4
line 272
;272:	addBotsMenuInfo.arrows.height  	     = 128;
ADDRGP4 addBotsMenuInfo+424+80
CNSTI4 128
ASGNI4
line 274
;273:
;274:	addBotsMenuInfo.up.generic.type	    = MTYPE_BITMAP;
ADDRGP4 addBotsMenuInfo+512
CNSTI4 6
ASGNI4
line 275
;275:	addBotsMenuInfo.up.generic.flags    = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 addBotsMenuInfo+512+44
CNSTU4 260
ASGNU4
line 276
;276:	addBotsMenuInfo.up.generic.x		= 200;
ADDRGP4 addBotsMenuInfo+512+12
CNSTI4 200
ASGNI4
line 277
;277:	addBotsMenuInfo.up.generic.y		= 128;
ADDRGP4 addBotsMenuInfo+512+16
CNSTI4 128
ASGNI4
line 278
;278:	addBotsMenuInfo.up.generic.id	    = ID_UP;
ADDRGP4 addBotsMenuInfo+512+8
CNSTI4 13
ASGNI4
line 279
;279:	addBotsMenuInfo.up.generic.callback = UI_AddBotsMenu_UpEvent;
ADDRGP4 addBotsMenuInfo+512+48
ADDRGP4 UI_AddBotsMenu_UpEvent
ASGNP4
line 280
;280:	addBotsMenuInfo.up.width  		    = 64;
ADDRGP4 addBotsMenuInfo+512+76
CNSTI4 64
ASGNI4
line 281
;281:	addBotsMenuInfo.up.height  		    = 64;
ADDRGP4 addBotsMenuInfo+512+80
CNSTI4 64
ASGNI4
line 282
;282:	addBotsMenuInfo.up.focuspic         = ART_ARROWUP;
ADDRGP4 addBotsMenuInfo+512+60
ADDRGP4 $215
ASGNP4
line 284
;283:
;284:	addBotsMenuInfo.down.generic.type	  = MTYPE_BITMAP;
ADDRGP4 addBotsMenuInfo+600
CNSTI4 6
ASGNI4
line 285
;285:	addBotsMenuInfo.down.generic.flags    = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 addBotsMenuInfo+600+44
CNSTU4 260
ASGNU4
line 286
;286:	addBotsMenuInfo.down.generic.x		  = 200;
ADDRGP4 addBotsMenuInfo+600+12
CNSTI4 200
ASGNI4
line 287
;287:	addBotsMenuInfo.down.generic.y		  = 128+64;
ADDRGP4 addBotsMenuInfo+600+16
CNSTI4 192
ASGNI4
line 288
;288:	addBotsMenuInfo.down.generic.id	      = ID_DOWN;
ADDRGP4 addBotsMenuInfo+600+8
CNSTI4 14
ASGNI4
line 289
;289:	addBotsMenuInfo.down.generic.callback = UI_AddBotsMenu_DownEvent;
ADDRGP4 addBotsMenuInfo+600+48
ADDRGP4 UI_AddBotsMenu_DownEvent
ASGNP4
line 290
;290:	addBotsMenuInfo.down.width  		  = 64;
ADDRGP4 addBotsMenuInfo+600+76
CNSTI4 64
ASGNI4
line 291
;291:	addBotsMenuInfo.down.height  		  = 64;
ADDRGP4 addBotsMenuInfo+600+80
CNSTI4 64
ASGNI4
line 292
;292:	addBotsMenuInfo.down.focuspic         = ART_ARROWDOWN;
ADDRGP4 addBotsMenuInfo+600+60
ADDRGP4 $233
ASGNP4
line 294
;293:
;294:	for( n = 0, y = 120; n < count; n++, y += 20 ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRLP4 4
CNSTI4 120
ASGNI4
ADDRGP4 $237
JUMPV
LABELV $234
line 295
;295:		addBotsMenuInfo.bots[n].generic.type		= MTYPE_PTEXT;
ADDRLP4 0
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 addBotsMenuInfo+688
ADDP4
CNSTI4 9
ASGNI4
line 296
;296:		addBotsMenuInfo.bots[n].generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRLP4 0
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 addBotsMenuInfo+688+44
ADDP4
CNSTU4 260
ASGNU4
line 297
;297:		addBotsMenuInfo.bots[n].generic.id			= ID_BOTNAME0 + n;
ADDRLP4 0
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 addBotsMenuInfo+688+8
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 20
ADDI4
ASGNI4
line 298
;298:		addBotsMenuInfo.bots[n].generic.x			= 320 - 56;
ADDRLP4 0
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 addBotsMenuInfo+688+12
ADDP4
CNSTI4 264
ASGNI4
line 299
;299:		addBotsMenuInfo.bots[n].generic.y			= y;
ADDRLP4 0
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 addBotsMenuInfo+688+16
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 300
;300:		addBotsMenuInfo.bots[n].generic.callback	= UI_AddBotsMenu_BotEvent;
ADDRLP4 0
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 addBotsMenuInfo+688+48
ADDP4
ADDRGP4 UI_AddBotsMenu_BotEvent
ASGNP4
line 301
;301:		addBotsMenuInfo.bots[n].string				= addBotsMenuInfo.botnames[n];
ADDRLP4 0
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 addBotsMenuInfo+688+60
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 addBotsMenuInfo+5672
ADDP4
ASGNP4
line 302
;302:		addBotsMenuInfo.bots[n].color				= color_orange;
ADDRLP4 0
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 addBotsMenuInfo+688+68
ADDP4
ADDRGP4 color_orange
ASGNP4
line 303
;303:		addBotsMenuInfo.bots[n].style				= UI_LEFT|UI_SMALLFONT;
ADDRLP4 0
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 addBotsMenuInfo+688+64
ADDP4
CNSTI4 16
ASGNI4
line 304
;304:	}
LABELV $235
line 294
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 20
ADDI4
ASGNI4
LABELV $237
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $234
line 306
;305:
;306:	y += 12;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 12
ADDI4
ASGNI4
line 307
;307:	addBotsMenuInfo.skill.generic.type		= MTYPE_SPINCONTROL;
ADDRGP4 addBotsMenuInfo+1192
CNSTI4 3
ASGNI4
line 308
;308:	addBotsMenuInfo.skill.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 addBotsMenuInfo+1192+44
CNSTU4 258
ASGNU4
line 309
;309:	addBotsMenuInfo.skill.generic.x			= 320;
ADDRGP4 addBotsMenuInfo+1192+12
CNSTI4 320
ASGNI4
line 310
;310:	addBotsMenuInfo.skill.generic.y			= y;
ADDRGP4 addBotsMenuInfo+1192+16
ADDRLP4 4
INDIRI4
ASGNI4
line 311
;311:	addBotsMenuInfo.skill.generic.name		= "Skill:";
ADDRGP4 addBotsMenuInfo+1192+4
ADDRGP4 $265
ASGNP4
line 312
;312:	addBotsMenuInfo.skill.generic.id		= ID_SKILL;
ADDRGP4 addBotsMenuInfo+1192+8
CNSTI4 15
ASGNI4
line 313
;313:	addBotsMenuInfo.skill.itemnames			= skillNames;
ADDRGP4 addBotsMenuInfo+1192+76
ADDRGP4 skillNames
ASGNP4
line 314
;314:	addBotsMenuInfo.skill.curvalue			= Com_Clamp( 0, 4, (int)trap_Cvar_VariableValue( "g_spSkill" ) - 1 );
ADDRGP4 $272
ARGP4
ADDRLP4 1056
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1082130432
ARGF4
ADDRLP4 1056
INDIRF4
CVFI4 4
CNSTI4 1
SUBI4
CVIF4 4
ARGF4
ADDRLP4 1060
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 addBotsMenuInfo+1192+64
ADDRLP4 1060
INDIRF4
CVFI4 4
ASGNI4
line 316
;315:
;316:	y += SMALLCHAR_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 317
;317:	addBotsMenuInfo.team.generic.type		= MTYPE_SPINCONTROL;
ADDRGP4 addBotsMenuInfo+1288
CNSTI4 3
ASGNI4
line 318
;318:	addBotsMenuInfo.team.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 addBotsMenuInfo+1288+44
CNSTU4 258
ASGNU4
line 319
;319:	addBotsMenuInfo.team.generic.x			= 320;
ADDRGP4 addBotsMenuInfo+1288+12
CNSTI4 320
ASGNI4
line 320
;320:	addBotsMenuInfo.team.generic.y			= y;
ADDRGP4 addBotsMenuInfo+1288+16
ADDRLP4 4
INDIRI4
ASGNI4
line 321
;321:	addBotsMenuInfo.team.generic.name		= "Team: ";
ADDRGP4 addBotsMenuInfo+1288+4
ADDRGP4 $282
ASGNP4
line 322
;322:	addBotsMenuInfo.team.generic.id			= ID_TEAM;
ADDRGP4 addBotsMenuInfo+1288+8
CNSTI4 16
ASGNI4
line 324
;323:#if MONSTER_MODE	// JUHOX: use other bot team names in STU
;324:	if (gametype >= GT_STU) {
ADDRLP4 12
INDIRI4
CNSTI4 8
LTI4 $285
line 325
;325:		addBotsMenuInfo.team.itemnames		= teamNames3;
ADDRGP4 addBotsMenuInfo+1288+76
ADDRGP4 teamNames3
ASGNP4
line 326
;326:		addBotsMenuInfo.team.generic.flags	= QMF_GRAYED;
ADDRGP4 addBotsMenuInfo+1288+44
CNSTU4 8192
ASGNU4
line 327
;327:	}
ADDRGP4 $286
JUMPV
LABELV $285
line 330
;328:	else
;329:#endif
;330:	if( gametype >= GT_TEAM ) {
ADDRLP4 12
INDIRI4
CNSTI4 3
LTI4 $291
line 331
;331:		addBotsMenuInfo.team.itemnames		= teamNames2;
ADDRGP4 addBotsMenuInfo+1288+76
ADDRGP4 teamNames2
ASGNP4
line 332
;332:	}
ADDRGP4 $292
JUMPV
LABELV $291
line 333
;333:	else {
line 334
;334:		addBotsMenuInfo.team.itemnames		= teamNames1;
ADDRGP4 addBotsMenuInfo+1288+76
ADDRGP4 teamNames1
ASGNP4
line 335
;335:		addBotsMenuInfo.team.generic.flags	= QMF_GRAYED;
ADDRGP4 addBotsMenuInfo+1288+44
CNSTU4 8192
ASGNU4
line 336
;336:	}
LABELV $292
LABELV $286
line 338
;337:
;338:	addBotsMenuInfo.go.generic.type			= MTYPE_BITMAP;
ADDRGP4 addBotsMenuInfo+1384
CNSTI4 6
ASGNI4
line 339
;339:	addBotsMenuInfo.go.generic.name			= ART_FIGHT0;
ADDRGP4 addBotsMenuInfo+1384+4
ADDRGP4 $302
ASGNP4
line 340
;340:	addBotsMenuInfo.go.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 addBotsMenuInfo+1384+44
CNSTU4 260
ASGNU4
line 341
;341:	addBotsMenuInfo.go.generic.id			= ID_GO;
ADDRGP4 addBotsMenuInfo+1384+8
CNSTI4 11
ASGNI4
line 342
;342:	addBotsMenuInfo.go.generic.callback		= UI_AddBotsMenu_FightEvent;
ADDRGP4 addBotsMenuInfo+1384+48
ADDRGP4 UI_AddBotsMenu_FightEvent
ASGNP4
line 343
;343:	addBotsMenuInfo.go.generic.x			= 320+128-128;
ADDRGP4 addBotsMenuInfo+1384+12
CNSTI4 320
ASGNI4
line 344
;344:	addBotsMenuInfo.go.generic.y			= 256+128-64;
ADDRGP4 addBotsMenuInfo+1384+16
CNSTI4 320
ASGNI4
line 345
;345:	addBotsMenuInfo.go.width  				= 128;
ADDRGP4 addBotsMenuInfo+1384+76
CNSTI4 128
ASGNI4
line 346
;346:	addBotsMenuInfo.go.height  				= 64;
ADDRGP4 addBotsMenuInfo+1384+80
CNSTI4 64
ASGNI4
line 347
;347:	addBotsMenuInfo.go.focuspic				= ART_FIGHT1;
ADDRGP4 addBotsMenuInfo+1384+60
ADDRGP4 $319
ASGNP4
line 349
;348:
;349:	addBotsMenuInfo.back.generic.type		= MTYPE_BITMAP;
ADDRGP4 addBotsMenuInfo+1472
CNSTI4 6
ASGNI4
line 350
;350:	addBotsMenuInfo.back.generic.name		= ART_BACK0;
ADDRGP4 addBotsMenuInfo+1472+4
ADDRGP4 $323
ASGNP4
line 351
;351:	addBotsMenuInfo.back.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 addBotsMenuInfo+1472+44
CNSTU4 260
ASGNU4
line 352
;352:	addBotsMenuInfo.back.generic.id			= ID_BACK;
ADDRGP4 addBotsMenuInfo+1472+8
CNSTI4 10
ASGNI4
line 353
;353:	addBotsMenuInfo.back.generic.callback	= UI_AddBotsMenu_BackEvent;
ADDRGP4 addBotsMenuInfo+1472+48
ADDRGP4 UI_AddBotsMenu_BackEvent
ASGNP4
line 354
;354:	addBotsMenuInfo.back.generic.x			= 320-128;
ADDRGP4 addBotsMenuInfo+1472+12
CNSTI4 192
ASGNI4
line 355
;355:	addBotsMenuInfo.back.generic.y			= 256+128-64;
ADDRGP4 addBotsMenuInfo+1472+16
CNSTI4 320
ASGNI4
line 356
;356:	addBotsMenuInfo.back.width				= 128;
ADDRGP4 addBotsMenuInfo+1472+76
CNSTI4 128
ASGNI4
line 357
;357:	addBotsMenuInfo.back.height				= 64;
ADDRGP4 addBotsMenuInfo+1472+80
CNSTI4 64
ASGNI4
line 358
;358:	addBotsMenuInfo.back.focuspic			= ART_BACK1;
ADDRGP4 addBotsMenuInfo+1472+60
ADDRGP4 $340
ASGNP4
line 360
;359:
;360:	addBotsMenuInfo.baseBotNum = 0;
ADDRGP4 addBotsMenuInfo+1568
CNSTI4 0
ASGNI4
line 361
;361:	addBotsMenuInfo.selectedBotNum = 0;
ADDRGP4 addBotsMenuInfo+1572
CNSTI4 0
ASGNI4
line 362
;362:	addBotsMenuInfo.bots[0].color = color_white;
ADDRGP4 addBotsMenuInfo+688+68
ADDRGP4 color_white
ASGNP4
line 364
;363:
;364:	UI_AddBotsMenu_GetSortedBotNums();
ADDRGP4 UI_AddBotsMenu_GetSortedBotNums
CALLV
pop
line 365
;365:	UI_AddBotsMenu_SetBotNames();
ADDRGP4 UI_AddBotsMenu_SetBotNames
CALLV
pop
line 367
;366:
;367:	Menu_AddItem( &addBotsMenuInfo.menu, &addBotsMenuInfo.arrows );
ADDRGP4 addBotsMenuInfo
ARGP4
ADDRGP4 addBotsMenuInfo+424
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 369
;368:
;369:	Menu_AddItem( &addBotsMenuInfo.menu, &addBotsMenuInfo.up );
ADDRGP4 addBotsMenuInfo
ARGP4
ADDRGP4 addBotsMenuInfo+512
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 370
;370:	Menu_AddItem( &addBotsMenuInfo.menu, &addBotsMenuInfo.down );
ADDRGP4 addBotsMenuInfo
ARGP4
ADDRGP4 addBotsMenuInfo+600
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 371
;371:	for( n = 0; n < count; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $351
JUMPV
LABELV $348
line 372
;372:		Menu_AddItem( &addBotsMenuInfo.menu, &addBotsMenuInfo.bots[n] );
ADDRGP4 addBotsMenuInfo
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 72
MULI4
ADDRGP4 addBotsMenuInfo+688
ADDP4
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 373
;373:	}
LABELV $349
line 371
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $351
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $348
line 374
;374:	Menu_AddItem( &addBotsMenuInfo.menu, &addBotsMenuInfo.skill );
ADDRGP4 addBotsMenuInfo
ARGP4
ADDRGP4 addBotsMenuInfo+1192
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 375
;375:	Menu_AddItem( &addBotsMenuInfo.menu, &addBotsMenuInfo.team );
ADDRGP4 addBotsMenuInfo
ARGP4
ADDRGP4 addBotsMenuInfo+1288
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 376
;376:	Menu_AddItem( &addBotsMenuInfo.menu, &addBotsMenuInfo.go );
ADDRGP4 addBotsMenuInfo
ARGP4
ADDRGP4 addBotsMenuInfo+1384
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 377
;377:	Menu_AddItem( &addBotsMenuInfo.menu, &addBotsMenuInfo.back );
ADDRGP4 addBotsMenuInfo
ARGP4
ADDRGP4 addBotsMenuInfo+1472
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 378
;378:}
LABELV $172
endproc UI_AddBotsMenu_Init 1064 12
export UI_AddBots_Cache
proc UI_AddBots_Cache 0 4
line 386
;379:
;380:
;381:/*
;382:=================
;383:UI_AddBots_Cache
;384:=================
;385:*/
;386:void UI_AddBots_Cache( void ) {
line 387
;387:	trap_R_RegisterShaderNoMip( ART_BACK0 );
ADDRGP4 $323
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 388
;388:	trap_R_RegisterShaderNoMip( ART_BACK1 );
ADDRGP4 $340
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 389
;389:	trap_R_RegisterShaderNoMip( ART_FIGHT0 );
ADDRGP4 $302
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 390
;390:	trap_R_RegisterShaderNoMip( ART_FIGHT1 );
ADDRGP4 $319
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 391
;391:	trap_R_RegisterShaderNoMip( ART_BACKGROUND );
ADDRGP4 $162
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 392
;392:	trap_R_RegisterShaderNoMip( ART_ARROWS );
ADDRGP4 $187
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 393
;393:	trap_R_RegisterShaderNoMip( ART_ARROWUP );
ADDRGP4 $215
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 394
;394:	trap_R_RegisterShaderNoMip( ART_ARROWDOWN );
ADDRGP4 $233
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 395
;395:}
LABELV $357
endproc UI_AddBots_Cache 0 4
export UI_AddBotsMenu
proc UI_AddBotsMenu 0 4
line 403
;396:
;397:
;398:/*
;399:=================
;400:UI_AddBotsMenu
;401:=================
;402:*/
;403:void UI_AddBotsMenu( void ) {
line 404
;404:	UI_AddBotsMenu_Init();
ADDRGP4 UI_AddBotsMenu_Init
CALLV
pop
line 405
;405:	UI_PushMenu( &addBotsMenuInfo.menu );
ADDRGP4 addBotsMenuInfo
ARGP4
ADDRGP4 UI_PushMenu
CALLV
pop
line 406
;406:}
LABELV $358
endproc UI_AddBotsMenu 0 4
bss
align 4
LABELV addBotsMenuInfo
skip 5896
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
LABELV $340
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
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 95
byte 1 48
byte 1 0
align 1
LABELV $319
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
LABELV $302
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
LABELV $282
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 58
byte 1 32
byte 1 0
align 1
LABELV $272
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $265
byte 1 83
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 58
byte 1 0
align 1
LABELV $233
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
LABELV $215
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
LABELV $187
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
LABELV $173
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
LABELV $171
byte 1 72
byte 1 117
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $170
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $169
byte 1 82
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $168
byte 1 70
byte 1 114
byte 1 101
byte 1 101
byte 1 0
align 1
LABELV $167
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
LABELV $166
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
LABELV $165
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
LABELV $164
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
LABELV $163
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
LABELV $162
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
LABELV $161
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
LABELV $132
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $106
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
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
