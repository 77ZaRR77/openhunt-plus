data
align 4
LABELV serverinfo_artlist
address $96
address $97
address $98
address $99
address $100
address $101
address $102
byte 4 0
export Favorites_Add
code
proc Favorites_Add 276 12
file "..\..\..\..\code\q3_ui\ui_serverinfo.c"
line 59
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:#include "ui_local.h"
;4:
;5:#define SERVERINFO_FRAMEL	"menu/art/frame2_l"
;6:#define SERVERINFO_FRAMER	"menu/art/frame1_r"
;7:#define SERVERINFO_BACK0	"menu/art/back_0"
;8:#define SERVERINFO_BACK1	"menu/art/back_1"
;9:#define SERVERINFO_ARROWS	"menu/art/gs_arrows_0"	// JUHOX
;10:#define SERVERINFO_ARROWSL	"menu/art/gs_arrows_l"	// JUHOX
;11:#define SERVERINFO_ARROWSR	"menu/art/gs_arrows_r"	// JUHOX
;12:
;13:static char* serverinfo_artlist[] =
;14:{
;15:	SERVERINFO_FRAMEL,	
;16:	SERVERINFO_FRAMER,
;17:	SERVERINFO_BACK0,
;18:	SERVERINFO_BACK1,
;19:	SERVERINFO_ARROWS,	// JUHOX
;20:	SERVERINFO_ARROWSL,	// JUHOX
;21:	SERVERINFO_ARROWSR,	// JUHOX
;22:	NULL
;23:};
;24:
;25:#define ID_ADD	 100
;26:#define ID_BACK	 101
;27:#define ID_PREVPAGE 102	// JUHOX
;28:#define ID_NEXTPAGE 103	// JUHOX
;29:
;30:#define MAX_LINES_PER_PAGE 16	// JUHOX
;31:
;32:typedef struct
;33:{
;34:	menuframework_s	menu;
;35:	menutext_s		banner;
;36:	menubitmap_s	framel;
;37:	menubitmap_s	framer;
;38:	menubitmap_s	back;
;39:	menubitmap_s	arrows;		// JUHOX
;40:	menubitmap_s	prevpage;	// JUHOX
;41:	menubitmap_s	nextpage;	// JUHOX
;42:	menutext_s		add;
;43:	char			info[MAX_INFO_STRING];
;44:	int				numlines;
;45:	int				firstLine;	// JUHOX
;46:} serverinfo_t;
;47:
;48:static serverinfo_t	s_serverinfo;
;49:
;50:
;51:/*
;52:=================
;53:Favorites_Add
;54:
;55:Add current server to favorites
;56:=================
;57:*/
;58:void Favorites_Add( void )
;59:{
line 65
;60:	char	adrstr[128];
;61:	char	serverbuff[128];
;62:	int		i;
;63:	int		best;
;64:
;65:	trap_Cvar_VariableStringBuffer( "cl_currentServerAddress", serverbuff, sizeof(serverbuff) );
ADDRGP4 $105
ARGP4
ADDRLP4 136
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 66
;66:	if (!serverbuff[0])
ADDRLP4 136
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $106
line 67
;67:		return;
ADDRGP4 $104
JUMPV
LABELV $106
line 69
;68:
;69:	best = 0;
ADDRLP4 132
CNSTI4 0
ASGNI4
line 70
;70:	for (i=0; i<MAX_FAVORITESERVERS; i++)
ADDRLP4 128
CNSTI4 0
ASGNI4
LABELV $108
line 71
;71:	{
line 72
;72:		trap_Cvar_VariableStringBuffer( va("server%d",i+1), adrstr, sizeof(adrstr) );
ADDRGP4 $112
ARGP4
ADDRLP4 128
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 264
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 264
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 73
;73:		if (!Q_stricmp(serverbuff,adrstr))
ADDRLP4 136
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 268
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 268
INDIRI4
CNSTI4 0
NEI4 $113
line 74
;74:		{
line 76
;75:			// already in list
;76:			return;
ADDRGP4 $104
JUMPV
LABELV $113
line 80
;77:		}
;78:		
;79:		// use first empty or non-numeric available slot
;80:		if ((adrstr[0]  < '0' || adrstr[0] > '9' ) && !best)
ADDRLP4 272
ADDRLP4 0
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 272
INDIRI4
CNSTI4 48
LTI4 $117
ADDRLP4 272
INDIRI4
CNSTI4 57
LEI4 $115
LABELV $117
ADDRLP4 132
INDIRI4
CNSTI4 0
NEI4 $115
line 81
;81:			best = i+1;
ADDRLP4 132
ADDRLP4 128
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $115
line 82
;82:	}
LABELV $109
line 70
ADDRLP4 128
ADDRLP4 128
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 128
INDIRI4
CNSTI4 16
LTI4 $108
line 84
;83:
;84:	if (best)
ADDRLP4 132
INDIRI4
CNSTI4 0
EQI4 $118
line 85
;85:		trap_Cvar_Set( va("server%d",best), serverbuff);
ADDRGP4 $112
ARGP4
ADDRLP4 132
INDIRI4
ARGI4
ADDRLP4 264
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 264
INDIRP4
ARGP4
ADDRLP4 136
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
LABELV $118
line 86
;86:}
LABELV $104
endproc Favorites_Add 276 12
proc ServerInfo_Event 16 0
line 95
;87:
;88:
;89:/*
;90:=================
;91:ServerInfo_Event
;92:=================
;93:*/
;94:static void ServerInfo_Event( void* ptr, int event )
;95:{
line 96
;96:	switch (((menucommon_s*)ptr)->id)
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
LTI4 $121
ADDRLP4 0
INDIRI4
CNSTI4 103
GTI4 $121
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $146-400
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $146
address $124
address $127
address $130
address $138
code
line 97
;97:	{
LABELV $124
line 99
;98:		case ID_ADD:
;99:			if (event != QM_ACTIVATED)
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $125
line 100
;100:				break;
ADDRGP4 $122
JUMPV
LABELV $125
line 102
;101:		
;102:			Favorites_Add();
ADDRGP4 Favorites_Add
CALLV
pop
line 103
;103:			UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 104
;104:			break;
ADDRGP4 $122
JUMPV
LABELV $127
line 107
;105:
;106:		case ID_BACK:
;107:			if (event != QM_ACTIVATED)
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $128
line 108
;108:				break;
ADDRGP4 $122
JUMPV
LABELV $128
line 110
;109:
;110:			UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 111
;111:			break;
ADDRGP4 $122
JUMPV
LABELV $130
line 116
;112:
;113:		// JUHOX: handle server info page arrow events
;114:#if 1
;115:		case ID_PREVPAGE:
;116:			if (event != QM_ACTIVATED) break;
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $131
ADDRGP4 $122
JUMPV
LABELV $131
line 117
;117:			s_serverinfo.firstLine -= MAX_LINES_PER_PAGE;
ADDRLP4 8
ADDRGP4 s_serverinfo+2124
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 16
SUBI4
ASGNI4
line 118
;118:			if (s_serverinfo.firstLine < 0) {
ADDRGP4 s_serverinfo+2124
INDIRI4
CNSTI4 0
GEI4 $122
line 119
;119:				s_serverinfo.firstLine = 0;
ADDRGP4 s_serverinfo+2124
CNSTI4 0
ASGNI4
line 120
;120:			}
line 121
;121:			break;
ADDRGP4 $122
JUMPV
LABELV $138
line 124
;122:
;123:		case ID_NEXTPAGE:
;124:			if (event != QM_ACTIVATED) break;
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $139
ADDRGP4 $122
JUMPV
LABELV $139
line 125
;125:			if (s_serverinfo.firstLine < s_serverinfo.numlines - MAX_LINES_PER_PAGE) {
ADDRGP4 s_serverinfo+2124
INDIRI4
ADDRGP4 s_serverinfo+2120
INDIRI4
CNSTI4 16
SUBI4
GEI4 $122
line 126
;126:				s_serverinfo.firstLine += MAX_LINES_PER_PAGE;
ADDRLP4 12
ADDRGP4 s_serverinfo+2124
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 127
;127:			}
line 128
;128:			break;
LABELV $121
LABELV $122
line 132
;129:#endif
;130:
;131:	}
;132:}
LABELV $120
endproc ServerInfo_Event 16 0
proc ServerInfo_MenuDraw 2060 20
line 140
;133:
;134:/*
;135:=================
;136:ServerInfo_MenuDraw
;137:=================
;138:*/
;139:static void ServerInfo_MenuDraw( void )
;140:{
line 145
;141:	const char		*s;
;142:	char			key[MAX_INFO_KEY];
;143:	char			value[MAX_INFO_VALUE];
;144:	int				y;
;145:	int line = -1;	// JUHOX
ADDRLP4 1028
CNSTI4 -1
ASGNI4
line 151
;146:
;147:	// JUHOX: fixed top line
;148:#if 0
;149:	y = SCREEN_HEIGHT/2 - s_serverinfo.numlines*(SMALLCHAR_HEIGHT)/2 - 20;
;150:#else
;151:	y = SCREEN_HEIGHT/2 - MAX_LINES_PER_PAGE * (SMALLCHAR_HEIGHT) / 2 - 20;
ADDRLP4 1024
CNSTI4 92
ASGNI4
line 153
;152:#endif
;153:	s = s_serverinfo.info;
ADDRLP4 1032
ADDRGP4 s_serverinfo+1096
ASGNP4
ADDRGP4 $151
JUMPV
LABELV $150
line 154
;154:	while ( s ) {
line 155
;155:		Info_NextPair( &s, key, value );
ADDRLP4 1032
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 1036
ARGP4
ADDRGP4 Info_NextPair
CALLV
pop
line 156
;156:		if ( !key[0] ) {
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $153
line 157
;157:			break;
ADDRGP4 $152
JUMPV
LABELV $153
line 162
;158:		}
;159:
;160:		// JUHOX: only draw one page of lines
;161:#if 1
;162:		line++;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 163
;163:		if (line < s_serverinfo.firstLine) continue;
ADDRLP4 1028
INDIRI4
ADDRGP4 s_serverinfo+2124
INDIRI4
GEI4 $155
ADDRGP4 $151
JUMPV
LABELV $155
line 164
;164:		if (line >= s_serverinfo.firstLine + MAX_LINES_PER_PAGE) break;
ADDRLP4 1028
INDIRI4
ADDRGP4 s_serverinfo+2124
INDIRI4
CNSTI4 16
ADDI4
LTI4 $158
ADDRGP4 $152
JUMPV
LABELV $158
line 167
;165:#endif
;166:
;167:		Q_strcat( key, MAX_INFO_KEY, ":" ); 
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $161
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 169
;168:
;169:		UI_DrawString(SCREEN_WIDTH*0.50 - 8,y,key,UI_RIGHT|UI_SMALLFONT,color_red);
CNSTI4 312
ARGI4
ADDRLP4 1024
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 18
ARGI4
ADDRGP4 color_red
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 170
;170:		UI_DrawString(SCREEN_WIDTH*0.50 + 8,y,value,UI_LEFT|UI_SMALLFONT,text_color_normal);
CNSTI4 328
ARGI4
ADDRLP4 1024
INDIRI4
ARGI4
ADDRLP4 1036
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 text_color_normal
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 172
;171:
;172:		y += SMALLCHAR_HEIGHT;
ADDRLP4 1024
ADDRLP4 1024
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 173
;173:	}
LABELV $151
line 154
ADDRLP4 1032
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $150
LABELV $152
line 175
;174:
;175:	Menu_Draw( &s_serverinfo.menu );
ADDRGP4 s_serverinfo
ARGP4
ADDRGP4 Menu_Draw
CALLV
pop
line 176
;176:}
LABELV $148
endproc ServerInfo_MenuDraw 2060 20
proc ServerInfo_MenuKey 4 8
line 184
;177:
;178:/*
;179:=================
;180:ServerInfo_MenuKey
;181:=================
;182:*/
;183:static sfxHandle_t ServerInfo_MenuKey( int key )
;184:{
line 185
;185:	return ( Menu_DefaultKey( &s_serverinfo.menu, key ) );
ADDRGP4 s_serverinfo
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 Menu_DefaultKey
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $162
endproc ServerInfo_MenuKey 4 8
export ServerInfo_Cache
proc ServerInfo_Cache 4 4
line 194
;186:}
;187:
;188:/*
;189:=================
;190:ServerInfo_Cache
;191:=================
;192:*/
;193:void ServerInfo_Cache( void )
;194:{
line 198
;195:	int	i;
;196:
;197:	// touch all our pics
;198:	for (i=0; ;i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $164
line 199
;199:	{
line 200
;200:		if (!serverinfo_artlist[i])
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 serverinfo_artlist
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $168
line 201
;201:			break;
ADDRGP4 $166
JUMPV
LABELV $168
line 202
;202:		trap_R_RegisterShaderNoMip(serverinfo_artlist[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 serverinfo_artlist
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 203
;203:	}
LABELV $165
line 198
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $164
JUMPV
LABELV $166
line 204
;204:}
LABELV $163
endproc ServerInfo_Cache 4 4
export UI_ServerInfoMenu
proc UI_ServerInfoMenu 2060 12
line 212
;205:
;206:/*
;207:=================
;208:UI_ServerInfoMenu
;209:=================
;210:*/
;211:void UI_ServerInfoMenu( void )
;212:{
line 218
;213:	const char		*s;
;214:	char			key[MAX_INFO_KEY];
;215:	char			value[MAX_INFO_VALUE];
;216:
;217:	// zero set all our globals
;218:	memset( &s_serverinfo, 0 ,sizeof(serverinfo_t) );
ADDRGP4 s_serverinfo
ARGP4
CNSTI4 0
ARGI4
CNSTI4 2128
ARGI4
ADDRGP4 memset
CALLP4
pop
line 220
;219:
;220:	ServerInfo_Cache();
ADDRGP4 ServerInfo_Cache
CALLV
pop
line 222
;221:
;222:	s_serverinfo.menu.draw       = ServerInfo_MenuDraw;
ADDRGP4 s_serverinfo+396
ADDRGP4 ServerInfo_MenuDraw
ASGNP4
line 223
;223:	s_serverinfo.menu.key        = ServerInfo_MenuKey;
ADDRGP4 s_serverinfo+400
ADDRGP4 ServerInfo_MenuKey
ASGNP4
line 224
;224:	s_serverinfo.menu.wrapAround = qtrue;
ADDRGP4 s_serverinfo+404
CNSTI4 1
ASGNI4
line 225
;225:	s_serverinfo.menu.fullscreen = qtrue;
ADDRGP4 s_serverinfo+408
CNSTI4 1
ASGNI4
line 227
;226:
;227:	s_serverinfo.banner.generic.type  = MTYPE_BTEXT;
ADDRGP4 s_serverinfo+424
CNSTI4 10
ASGNI4
line 228
;228:	s_serverinfo.banner.generic.x	  = 320;
ADDRGP4 s_serverinfo+424+12
CNSTI4 320
ASGNI4
line 229
;229:	s_serverinfo.banner.generic.y	  = 16;
ADDRGP4 s_serverinfo+424+16
CNSTI4 16
ASGNI4
line 230
;230:	s_serverinfo.banner.string		  = "SERVER INFO";
ADDRGP4 s_serverinfo+424+60
ADDRGP4 $182
ASGNP4
line 231
;231:	s_serverinfo.banner.color	      = color_white;
ADDRGP4 s_serverinfo+424+68
ADDRGP4 color_white
ASGNP4
line 232
;232:	s_serverinfo.banner.style	      = UI_CENTER;
ADDRGP4 s_serverinfo+424+64
CNSTI4 1
ASGNI4
line 234
;233:
;234:	s_serverinfo.framel.generic.type  = MTYPE_BITMAP;
ADDRGP4 s_serverinfo+496
CNSTI4 6
ASGNI4
line 235
;235:	s_serverinfo.framel.generic.name  = SERVERINFO_FRAMEL;
ADDRGP4 s_serverinfo+496+4
ADDRGP4 $96
ASGNP4
line 236
;236:	s_serverinfo.framel.generic.flags = QMF_INACTIVE;
ADDRGP4 s_serverinfo+496+44
CNSTU4 16384
ASGNU4
line 237
;237:	s_serverinfo.framel.generic.x	  = 0;  
ADDRGP4 s_serverinfo+496+12
CNSTI4 0
ASGNI4
line 238
;238:	s_serverinfo.framel.generic.y	  = 78;
ADDRGP4 s_serverinfo+496+16
CNSTI4 78
ASGNI4
line 239
;239:	s_serverinfo.framel.width  	      = 256;
ADDRGP4 s_serverinfo+496+76
CNSTI4 256
ASGNI4
line 240
;240:	s_serverinfo.framel.height  	  = 329;
ADDRGP4 s_serverinfo+496+80
CNSTI4 329
ASGNI4
line 242
;241:
;242:	s_serverinfo.framer.generic.type  = MTYPE_BITMAP;
ADDRGP4 s_serverinfo+584
CNSTI4 6
ASGNI4
line 243
;243:	s_serverinfo.framer.generic.name  = SERVERINFO_FRAMER;
ADDRGP4 s_serverinfo+584+4
ADDRGP4 $97
ASGNP4
line 244
;244:	s_serverinfo.framer.generic.flags = QMF_INACTIVE;
ADDRGP4 s_serverinfo+584+44
CNSTU4 16384
ASGNU4
line 245
;245:	s_serverinfo.framer.generic.x	  = 376;
ADDRGP4 s_serverinfo+584+12
CNSTI4 376
ASGNI4
line 246
;246:	s_serverinfo.framer.generic.y	  = 76;
ADDRGP4 s_serverinfo+584+16
CNSTI4 76
ASGNI4
line 247
;247:	s_serverinfo.framer.width  	      = 256;
ADDRGP4 s_serverinfo+584+76
CNSTI4 256
ASGNI4
line 248
;248:	s_serverinfo.framer.height  	  = 334;
ADDRGP4 s_serverinfo+584+80
CNSTI4 334
ASGNI4
line 252
;249:
;250:	// JUHOX: init page arrows
;251:#if 1
;252:	s_serverinfo.arrows.generic.type		= MTYPE_BITMAP;
ADDRGP4 s_serverinfo+760
CNSTI4 6
ASGNI4
line 253
;253:	s_serverinfo.arrows.generic.name		= SERVERINFO_ARROWS;
ADDRGP4 s_serverinfo+760+4
ADDRGP4 $100
ASGNP4
line 254
;254:	s_serverinfo.arrows.generic.flags		= QMF_INACTIVE;
ADDRGP4 s_serverinfo+760+44
CNSTU4 16384
ASGNU4
line 255
;255:	s_serverinfo.arrows.generic.x			= 260;
ADDRGP4 s_serverinfo+760+12
CNSTI4 260
ASGNI4
line 256
;256:	s_serverinfo.arrows.generic.y			= 371;
ADDRGP4 s_serverinfo+760+16
CNSTI4 371
ASGNI4
line 257
;257:	s_serverinfo.arrows.width				= 128;
ADDRGP4 s_serverinfo+760+76
CNSTI4 128
ASGNI4
line 258
;258:	s_serverinfo.arrows.height				= 32;
ADDRGP4 s_serverinfo+760+80
CNSTI4 32
ASGNI4
line 260
;259:
;260:	s_serverinfo.prevpage.generic.type		= MTYPE_BITMAP;
ADDRGP4 s_serverinfo+848
CNSTI4 6
ASGNI4
line 261
;261:	s_serverinfo.prevpage.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_serverinfo+848+44
CNSTU4 260
ASGNU4
line 262
;262:	s_serverinfo.prevpage.generic.callback	= ServerInfo_Event;
ADDRGP4 s_serverinfo+848+48
ADDRGP4 ServerInfo_Event
ASGNP4
line 263
;263:	s_serverinfo.prevpage.generic.id		= ID_PREVPAGE;
ADDRGP4 s_serverinfo+848+8
CNSTI4 102
ASGNI4
line 264
;264:	s_serverinfo.prevpage.generic.x			= 260;
ADDRGP4 s_serverinfo+848+12
CNSTI4 260
ASGNI4
line 265
;265:	s_serverinfo.prevpage.generic.y			= 371;
ADDRGP4 s_serverinfo+848+16
CNSTI4 371
ASGNI4
line 266
;266:	s_serverinfo.prevpage.width				= 64;
ADDRGP4 s_serverinfo+848+76
CNSTI4 64
ASGNI4
line 267
;267:	s_serverinfo.prevpage.height			= 32;
ADDRGP4 s_serverinfo+848+80
CNSTI4 32
ASGNI4
line 268
;268:	s_serverinfo.prevpage.focuspic			= SERVERINFO_ARROWSL;
ADDRGP4 s_serverinfo+848+60
ADDRGP4 $101
ASGNP4
line 270
;269:
;270:	s_serverinfo.nextpage.generic.type		= MTYPE_BITMAP;
ADDRGP4 s_serverinfo+936
CNSTI4 6
ASGNI4
line 271
;271:	s_serverinfo.nextpage.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_serverinfo+936+44
CNSTU4 260
ASGNU4
line 272
;272:	s_serverinfo.nextpage.generic.callback	= ServerInfo_Event;
ADDRGP4 s_serverinfo+936+48
ADDRGP4 ServerInfo_Event
ASGNP4
line 273
;273:	s_serverinfo.nextpage.generic.id		= ID_NEXTPAGE;
ADDRGP4 s_serverinfo+936+8
CNSTI4 103
ASGNI4
line 274
;274:	s_serverinfo.nextpage.generic.x			= 321;
ADDRGP4 s_serverinfo+936+12
CNSTI4 321
ASGNI4
line 275
;275:	s_serverinfo.nextpage.generic.y			= 371;
ADDRGP4 s_serverinfo+936+16
CNSTI4 371
ASGNI4
line 276
;276:	s_serverinfo.nextpage.width				= 64;
ADDRGP4 s_serverinfo+936+76
CNSTI4 64
ASGNI4
line 277
;277:	s_serverinfo.nextpage.height			= 32;
ADDRGP4 s_serverinfo+936+80
CNSTI4 32
ASGNI4
line 278
;278:	s_serverinfo.nextpage.focuspic			= SERVERINFO_ARROWSR;
ADDRGP4 s_serverinfo+936+60
ADDRGP4 $102
ASGNP4
line 281
;279:#endif
;280:
;281:	s_serverinfo.add.generic.type	  = MTYPE_PTEXT;
ADDRGP4 s_serverinfo+1024
CNSTI4 9
ASGNI4
line 282
;282:	s_serverinfo.add.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_serverinfo+1024+44
CNSTU4 264
ASGNU4
line 283
;283:	s_serverinfo.add.generic.callback = ServerInfo_Event;
ADDRGP4 s_serverinfo+1024+48
ADDRGP4 ServerInfo_Event
ASGNP4
line 284
;284:	s_serverinfo.add.generic.id	      = ID_ADD;
ADDRGP4 s_serverinfo+1024+8
CNSTI4 100
ASGNI4
line 285
;285:	s_serverinfo.add.generic.x		  = 320;
ADDRGP4 s_serverinfo+1024+12
CNSTI4 320
ASGNI4
line 286
;286:	s_serverinfo.add.generic.y		  = /*371*/420;	// JUHOX
ADDRGP4 s_serverinfo+1024+16
CNSTI4 420
ASGNI4
line 287
;287:	s_serverinfo.add.string  		  = "ADD TO FAVORITES";
ADDRGP4 s_serverinfo+1024+60
ADDRGP4 $273
ASGNP4
line 288
;288:	s_serverinfo.add.style  		  = UI_CENTER|UI_SMALLFONT;
ADDRGP4 s_serverinfo+1024+64
CNSTI4 17
ASGNI4
line 289
;289:	s_serverinfo.add.color			  =	color_red;
ADDRGP4 s_serverinfo+1024+68
ADDRGP4 color_red
ASGNP4
line 290
;290:	if( trap_Cvar_VariableValue( "sv_running" ) ) {
ADDRGP4 $280
ARGP4
ADDRLP4 2052
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 2052
INDIRF4
CNSTF4 0
EQF4 $278
line 291
;291:		s_serverinfo.add.generic.flags |= QMF_GRAYED;
ADDRLP4 2056
ADDRGP4 s_serverinfo+1024+44
ASGNP4
ADDRLP4 2056
INDIRP4
ADDRLP4 2056
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
line 292
;292:	}
LABELV $278
line 294
;293:
;294:	s_serverinfo.back.generic.type	   = MTYPE_BITMAP;
ADDRGP4 s_serverinfo+672
CNSTI4 6
ASGNI4
line 295
;295:	s_serverinfo.back.generic.name     = SERVERINFO_BACK0;
ADDRGP4 s_serverinfo+672+4
ADDRGP4 $98
ASGNP4
line 296
;296:	s_serverinfo.back.generic.flags    = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_serverinfo+672+44
CNSTU4 260
ASGNU4
line 297
;297:	s_serverinfo.back.generic.callback = ServerInfo_Event;
ADDRGP4 s_serverinfo+672+48
ADDRGP4 ServerInfo_Event
ASGNP4
line 298
;298:	s_serverinfo.back.generic.id	   = ID_BACK;
ADDRGP4 s_serverinfo+672+8
CNSTI4 101
ASGNI4
line 299
;299:	s_serverinfo.back.generic.x		   = 0;
ADDRGP4 s_serverinfo+672+12
CNSTI4 0
ASGNI4
line 300
;300:	s_serverinfo.back.generic.y		   = 480-64;
ADDRGP4 s_serverinfo+672+16
CNSTI4 416
ASGNI4
line 301
;301:	s_serverinfo.back.width  		   = 128;
ADDRGP4 s_serverinfo+672+76
CNSTI4 128
ASGNI4
line 302
;302:	s_serverinfo.back.height  		   = 64;
ADDRGP4 s_serverinfo+672+80
CNSTI4 64
ASGNI4
line 303
;303:	s_serverinfo.back.focuspic         = SERVERINFO_BACK1;
ADDRGP4 s_serverinfo+672+60
ADDRGP4 $99
ASGNP4
line 305
;304:
;305:	trap_GetConfigString( CS_SERVERINFO, s_serverinfo.info, MAX_INFO_STRING );
CNSTI4 0
ARGI4
ADDRGP4 s_serverinfo+1096
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigString
CALLI4
pop
line 307
;306:
;307:	s_serverinfo.numlines = 0;
ADDRGP4 s_serverinfo+2120
CNSTI4 0
ASGNI4
line 308
;308:	s = s_serverinfo.info;
ADDRLP4 0
ADDRGP4 s_serverinfo+1096
ASGNP4
ADDRGP4 $306
JUMPV
LABELV $305
line 309
;309:	while ( s ) {
line 310
;310:		Info_NextPair( &s, key, value );
ADDRLP4 0
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 1028
ARGP4
ADDRGP4 Info_NextPair
CALLV
pop
line 311
;311:		if ( !key[0] ) {
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $308
line 312
;312:			break;
ADDRGP4 $307
JUMPV
LABELV $308
line 314
;313:		}
;314:		s_serverinfo.numlines++;
ADDRLP4 2056
ADDRGP4 s_serverinfo+2120
ASGNP4
ADDRLP4 2056
INDIRP4
ADDRLP4 2056
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 315
;315:	}
LABELV $306
line 309
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $305
LABELV $307
line 323
;316:
;317:	// JUHOX: don't limit s_serverinfo.numlines to 16
;318:#if 0
;319:	if (s_serverinfo.numlines > 16)
;320:		s_serverinfo.numlines = 16;
;321:#endif
;322:
;323:	Menu_AddItem( &s_serverinfo.menu, (void*) &s_serverinfo.banner );
ADDRGP4 s_serverinfo
ARGP4
ADDRGP4 s_serverinfo+424
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 324
;324:	Menu_AddItem( &s_serverinfo.menu, (void*) &s_serverinfo.framel );
ADDRGP4 s_serverinfo
ARGP4
ADDRGP4 s_serverinfo+496
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 325
;325:	Menu_AddItem( &s_serverinfo.menu, (void*) &s_serverinfo.framer );
ADDRGP4 s_serverinfo
ARGP4
ADDRGP4 s_serverinfo+584
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 326
;326:	Menu_AddItem( &s_serverinfo.menu, &s_serverinfo.arrows);		// JUHOX
ADDRGP4 s_serverinfo
ARGP4
ADDRGP4 s_serverinfo+760
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 327
;327:	Menu_AddItem( &s_serverinfo.menu, &s_serverinfo.prevpage);		// JUHOX
ADDRGP4 s_serverinfo
ARGP4
ADDRGP4 s_serverinfo+848
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 328
;328:	Menu_AddItem( &s_serverinfo.menu, &s_serverinfo.nextpage);		// JUHOX
ADDRGP4 s_serverinfo
ARGP4
ADDRGP4 s_serverinfo+936
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 329
;329:	Menu_AddItem( &s_serverinfo.menu, (void*) &s_serverinfo.add );
ADDRGP4 s_serverinfo
ARGP4
ADDRGP4 s_serverinfo+1024
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 330
;330:	Menu_AddItem( &s_serverinfo.menu, (void*) &s_serverinfo.back );
ADDRGP4 s_serverinfo
ARGP4
ADDRGP4 s_serverinfo+672
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 332
;331:
;332:	UI_PushMenu( &s_serverinfo.menu );
ADDRGP4 s_serverinfo
ARGP4
ADDRGP4 UI_PushMenu
CALLV
pop
line 333
;333:}
LABELV $170
endproc UI_ServerInfoMenu 2060 12
bss
align 4
LABELV s_serverinfo
skip 2128
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
LABELV $280
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
LABELV $273
byte 1 65
byte 1 68
byte 1 68
byte 1 32
byte 1 84
byte 1 79
byte 1 32
byte 1 70
byte 1 65
byte 1 86
byte 1 79
byte 1 82
byte 1 73
byte 1 84
byte 1 69
byte 1 83
byte 1 0
align 1
LABELV $182
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
LABELV $161
byte 1 58
byte 1 0
align 1
LABELV $112
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $105
byte 1 99
byte 1 108
byte 1 95
byte 1 99
byte 1 117
byte 1 114
byte 1 114
byte 1 101
byte 1 110
byte 1 116
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 65
byte 1 100
byte 1 100
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 0
align 1
LABELV $102
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
LABELV $101
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
LABELV $100
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
LABELV $99
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
LABELV $98
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
LABELV $97
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
LABELV $96
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
