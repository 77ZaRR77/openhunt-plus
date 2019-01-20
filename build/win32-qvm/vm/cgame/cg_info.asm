code
proc CG_DrawLoadingIcons 12 20
file "..\..\..\..\code\cgame\cg_info.c"
line 21
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_info.c -- display information while data is being loading
;4:
;5:#include "cg_local.h"
;6:
;7:#define MAX_LOADING_PLAYER_ICONS	16
;8:#define MAX_LOADING_ITEM_ICONS		26
;9:
;10:static int			loadingPlayerIconCount;
;11:static int			loadingItemIconCount;
;12:static qhandle_t	loadingPlayerIcons[MAX_LOADING_PLAYER_ICONS];
;13:static qhandle_t	loadingItemIcons[MAX_LOADING_ITEM_ICONS];
;14:
;15:
;16:/*
;17:===================
;18:CG_DrawLoadingIcons
;19:===================
;20:*/
;21:static void CG_DrawLoadingIcons( void ) {
line 25
;22:	int		n;
;23:	int		x, y;
;24:
;25:	for( n = 0; n < loadingPlayerIconCount; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $128
JUMPV
LABELV $125
line 26
;26:		x = 16 + n * 78;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 78
MULI4
CNSTI4 16
ADDI4
ASGNI4
line 27
;27:		y = 324-40;
ADDRLP4 4
CNSTI4 284
ASGNI4
line 28
;28:		CG_DrawPic( x, y, 64, 64, loadingPlayerIcons[n] );
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1115684864
ARGF4
CNSTF4 1115684864
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 loadingPlayerIcons
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 29
;29:	}
LABELV $126
line 25
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $128
ADDRLP4 0
INDIRI4
ADDRGP4 loadingPlayerIconCount
INDIRI4
LTI4 $125
line 31
;30:
;31:	for( n = 0; n < loadingItemIconCount; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $132
JUMPV
LABELV $129
line 32
;32:		y = 400-40;
ADDRLP4 4
CNSTI4 360
ASGNI4
line 33
;33:		if( n >= 13 ) {
ADDRLP4 0
INDIRI4
CNSTI4 13
LTI4 $133
line 34
;34:			y += 40;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 40
ADDI4
ASGNI4
line 35
;35:		}
LABELV $133
line 36
;36:		x = 16 + n % 13 * 48;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 13
MODI4
CNSTI4 48
MULI4
CNSTI4 16
ADDI4
ASGNI4
line 37
;37:		CG_DrawPic( x, y, 32, 32, loadingItemIcons[n] );
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1107296256
ARGF4
CNSTF4 1107296256
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 loadingItemIcons
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 38
;38:	}
LABELV $130
line 31
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $132
ADDRLP4 0
INDIRI4
ADDRGP4 loadingItemIconCount
INDIRI4
LTI4 $129
line 39
;39:}
LABELV $124
endproc CG_DrawLoadingIcons 12 20
export CG_LoadingString
proc CG_LoadingString 0 12
line 48
;40:
;41:
;42:/*
;43:======================
;44:CG_LoadingString
;45:
;46:======================
;47:*/
;48:void CG_LoadingString( const char *s ) {
line 49
;49:	Q_strncpyz( cg.infoScreenText, s, sizeof( cg.infoScreenText ) );
ADDRGP4 cg+112484
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 51
;50:
;51:	trap_UpdateScreen();
ADDRGP4 trap_UpdateScreen
CALLV
pop
line 52
;52:}
LABELV $135
endproc CG_LoadingString 0 12
export CG_LoadingItem
proc CG_LoadingItem 16 4
line 59
;53:
;54:/*
;55:===================
;56:CG_LoadingItem
;57:===================
;58:*/
;59:void CG_LoadingItem( int itemNum ) {
line 62
;60:	gitem_t		*item;
;61:
;62:	item = &bg_itemlist[itemNum];
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 64
;63:	
;64:	if ( item->icon && loadingItemIconCount < MAX_LOADING_ITEM_ICONS ) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $139
ADDRGP4 loadingItemIconCount
INDIRI4
CNSTI4 26
GEI4 $139
line 65
;65:		loadingItemIcons[loadingItemIconCount++] = trap_R_RegisterShaderNoMip( item->icon );
ADDRLP4 8
ADDRGP4 loadingItemIconCount
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRP4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 loadingItemIcons
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 66
;66:	}
LABELV $139
line 68
;67:
;68:	CG_LoadingString( item->pickup_name );
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRP4
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 69
;69:}
LABELV $138
endproc CG_LoadingItem 16 4
bss
align 1
LABELV $142
skip 1024
export CG_LoadingClient
code
proc CG_LoadingClient 232 20
line 76
;70:
;71:/*
;72:===================
;73:CG_LoadingClient
;74:===================
;75:*/
;76:void CG_LoadingClient( int clientNum ) {
line 86
;77:	const char		*info;
;78:	char			*skin;
;79:	char			personality[MAX_QPATH];
;80:	char			model[MAX_QPATH];
;81:	char			iconName[MAX_QPATH];
;82:
;83:#if !MONSTER_MODE	// JUHOX: handle monsters
;84:	info = CG_ConfigString( CS_PLAYERS + clientNum );
;85:#else
;86:	{
line 89
;87:		static char infoBuf[MAX_INFO_STRING];
;88:
;89:		infoBuf[0] = 0;
ADDRGP4 $142
CNSTI1 0
ASGNI1
line 90
;90:		switch (clientNum) {
ADDRLP4 200
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 200
INDIRI4
CNSTI4 64
LTI4 $143
ADDRLP4 200
INDIRI4
CNSTI4 68
GTI4 $143
ADDRLP4 200
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $156-256
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $156
address $145
address $150
address $153
address $145
address $145
code
LABELV $145
line 94
;91:		case CLIENTNUM_MONSTER_PREDATOR:
;92:		case CLIENTNUM_MONSTER_PREDATOR_RED:
;93:		case CLIENTNUM_MONSTER_PREDATOR_BLUE:
;94:			Info_SetValueForKey(infoBuf, "n", "Predator");
ADDRGP4 $142
ARGP4
ADDRGP4 $146
ARGP4
ADDRGP4 $147
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 95
;95:			Info_SetValueForKey(infoBuf, "model", Info_ValueForKey(CG_ConfigString(CS_SERVERINFO), "monsterModel1"));
CNSTI4 0
ARGI4
ADDRLP4 204
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 204
INDIRP4
ARGP4
ADDRGP4 $149
ARGP4
ADDRLP4 208
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $142
ARGP4
ADDRGP4 $148
ARGP4
ADDRLP4 208
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 96
;96:			info = infoBuf;
ADDRLP4 196
ADDRGP4 $142
ASGNP4
line 97
;97:			break;
ADDRGP4 $144
JUMPV
LABELV $150
line 99
;98:		case CLIENTNUM_MONSTER_GUARD:
;99:			Info_SetValueForKey(infoBuf, "n", "Guard");
ADDRGP4 $142
ARGP4
ADDRGP4 $146
ARGP4
ADDRGP4 $151
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 100
;100:			Info_SetValueForKey(infoBuf, "model", Info_ValueForKey(CG_ConfigString(CS_SERVERINFO), "monsterModel2"));
CNSTI4 0
ARGI4
ADDRLP4 212
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 212
INDIRP4
ARGP4
ADDRGP4 $152
ARGP4
ADDRLP4 216
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $142
ARGP4
ADDRGP4 $148
ARGP4
ADDRLP4 216
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 101
;101:			info = infoBuf;
ADDRLP4 196
ADDRGP4 $142
ASGNP4
line 102
;102:			break;
ADDRGP4 $144
JUMPV
LABELV $153
line 104
;103:		case CLIENTNUM_MONSTER_TITAN:
;104:			Info_SetValueForKey(infoBuf, "n", "Titan");
ADDRGP4 $142
ARGP4
ADDRGP4 $146
ARGP4
ADDRGP4 $154
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 105
;105:			Info_SetValueForKey(infoBuf, "model", Info_ValueForKey(CG_ConfigString(CS_SERVERINFO), "monsterModel3"));
CNSTI4 0
ARGI4
ADDRLP4 220
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 220
INDIRP4
ARGP4
ADDRGP4 $155
ARGP4
ADDRLP4 224
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $142
ARGP4
ADDRGP4 $148
ARGP4
ADDRLP4 224
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 106
;106:			info = infoBuf;
ADDRLP4 196
ADDRGP4 $142
ASGNP4
line 107
;107:			break;
ADDRGP4 $144
JUMPV
LABELV $143
line 109
;108:		default:
;109:			info = CG_ConfigString(CS_PLAYERS + clientNum);
ADDRFP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 228
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 196
ADDRLP4 228
INDIRP4
ASGNP4
line 110
;110:			break;
LABELV $144
line 112
;111:		}
;112:	}
line 115
;113:#endif
;114:
;115:	if ( loadingPlayerIconCount < MAX_LOADING_PLAYER_ICONS ) {
ADDRGP4 loadingPlayerIconCount
INDIRI4
CNSTI4 16
GEI4 $158
line 116
;116:		Q_strncpyz( model, Info_ValueForKey( info, "model" ), sizeof( model ) );
ADDRLP4 196
INDIRP4
ARGP4
ADDRGP4 $148
ARGP4
ADDRLP4 200
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 68
ARGP4
ADDRLP4 200
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 117
;117:		skin = Q_strrchr( model, '/' );
ADDRLP4 68
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 204
ADDRGP4 Q_strrchr
CALLP4
ASGNP4
ADDRLP4 64
ADDRLP4 204
INDIRP4
ASGNP4
line 118
;118:		if ( skin ) {
ADDRLP4 64
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $160
line 119
;119:			*skin++ = '\0';
ADDRLP4 208
ADDRLP4 64
INDIRP4
ASGNP4
ADDRLP4 64
ADDRLP4 208
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 208
INDIRP4
CNSTI1 0
ASGNI1
line 120
;120:		} else {
ADDRGP4 $161
JUMPV
LABELV $160
line 121
;121:			skin = "default";
ADDRLP4 64
ADDRGP4 $162
ASGNP4
line 122
;122:		}
LABELV $161
line 124
;123:
;124:		Com_sprintf( iconName, MAX_QPATH, "models/players/%s/icon_%s.tga", model, skin );
ADDRLP4 132
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $163
ARGP4
ADDRLP4 68
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 126
;125:		
;126:		loadingPlayerIcons[loadingPlayerIconCount] = trap_R_RegisterShaderNoMip( iconName );
ADDRLP4 132
ARGP4
ADDRLP4 208
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 loadingPlayerIconCount
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 loadingPlayerIcons
ADDP4
ADDRLP4 208
INDIRI4
ASGNI4
line 127
;127:		if ( !loadingPlayerIcons[loadingPlayerIconCount] ) {
ADDRGP4 loadingPlayerIconCount
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 loadingPlayerIcons
ADDP4
INDIRI4
CNSTI4 0
NEI4 $164
line 128
;128:			Com_sprintf( iconName, MAX_QPATH, "models/players/characters/%s/icon_%s.tga", model, skin );
ADDRLP4 132
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $166
ARGP4
ADDRLP4 68
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 129
;129:			loadingPlayerIcons[loadingPlayerIconCount] = trap_R_RegisterShaderNoMip( iconName );
ADDRLP4 132
ARGP4
ADDRLP4 212
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 loadingPlayerIconCount
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 loadingPlayerIcons
ADDP4
ADDRLP4 212
INDIRI4
ASGNI4
line 130
;130:		}
LABELV $164
line 131
;131:		if ( !loadingPlayerIcons[loadingPlayerIconCount] ) {
ADDRGP4 loadingPlayerIconCount
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 loadingPlayerIcons
ADDP4
INDIRI4
CNSTI4 0
NEI4 $167
line 132
;132:			Com_sprintf( iconName, MAX_QPATH, "models/players/%s/icon_%s.tga", DEFAULT_MODEL, "default" );
ADDRLP4 132
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $163
ARGP4
ADDRGP4 $169
ARGP4
ADDRGP4 $162
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 133
;133:			loadingPlayerIcons[loadingPlayerIconCount] = trap_R_RegisterShaderNoMip( iconName );
ADDRLP4 132
ARGP4
ADDRLP4 212
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 loadingPlayerIconCount
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 loadingPlayerIcons
ADDP4
ADDRLP4 212
INDIRI4
ASGNI4
line 134
;134:		}
LABELV $167
line 135
;135:		if ( loadingPlayerIcons[loadingPlayerIconCount] ) {
ADDRGP4 loadingPlayerIconCount
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 loadingPlayerIcons
ADDP4
INDIRI4
CNSTI4 0
EQI4 $170
line 136
;136:			loadingPlayerIconCount++;
ADDRLP4 212
ADDRGP4 loadingPlayerIconCount
ASGNP4
ADDRLP4 212
INDIRP4
ADDRLP4 212
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 137
;137:		}
LABELV $170
line 138
;138:	}
LABELV $158
line 140
;139:
;140:	Q_strncpyz( personality, Info_ValueForKey( info, "n" ), sizeof(personality) );
ADDRLP4 196
INDIRP4
ARGP4
ADDRGP4 $146
ARGP4
ADDRLP4 200
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
ADDRLP4 200
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 141
;141:	Q_CleanStr( personality );
ADDRLP4 0
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 143
;142:
;143:	if( cgs.gametype == GT_SINGLE_PLAYER ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 2
NEI4 $172
line 144
;144:		trap_S_RegisterSound( va( "sound/player/announce/%s.wav", personality ), qtrue );
ADDRGP4 $175
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 204
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 204
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 trap_S_RegisterSound
CALLI4
pop
line 145
;145:	}
LABELV $172
line 147
;146:
;147:	CG_LoadingString( personality );
ADDRLP4 0
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 148
;148:}
LABELV $141
endproc CG_LoadingClient 232 20
export CG_DrawInformation
proc CG_DrawInformation 1112 36
line 158
;149:
;150:
;151:/*
;152:====================
;153:CG_DrawInformation
;154:
;155:Draw all the status / pacifier stuff during level loading
;156:====================
;157:*/
;158:void CG_DrawInformation( void ) {
line 168
;159:	const char	*s;
;160:	const char	*info;
;161:	const char	*sysInfo;
;162:	int			y;
;163:	int			value;
;164:	qhandle_t	levelshot;
;165:	qhandle_t	detail;
;166:	char		buf[1024];
;167:
;168:	info = CG_ConfigString( CS_SERVERINFO );
CNSTI4 0
ARGI4
ADDRLP4 1052
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 1036
ADDRLP4 1052
INDIRP4
ASGNP4
line 169
;169:	sysInfo = CG_ConfigString( CS_SYSTEMINFO );
CNSTI4 1
ARGI4
ADDRLP4 1056
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 1044
ADDRLP4 1056
INDIRP4
ASGNP4
line 171
;170:
;171:	s = Info_ValueForKey( info, "mapname" );
ADDRLP4 1036
INDIRP4
ARGP4
ADDRGP4 $177
ARGP4
ADDRLP4 1060
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 1060
INDIRP4
ASGNP4
line 176
;172:	// JUHOX: don't use va() in CG_DrawInformation()
;173:#if 0
;174:	levelshot = trap_R_RegisterShaderNoMip( va( "levelshots/%s.tga", s ) );
;175:#else
;176:	Com_sprintf(buf, sizeof(buf), "levelshots/%s.tga", s);
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $178
ARGP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 177
;177:	levelshot = trap_R_RegisterShaderNoMip(buf);
ADDRLP4 0
ARGP4
ADDRLP4 1064
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 1040
ADDRLP4 1064
INDIRI4
ASGNI4
line 179
;178:#endif
;179:	if ( !levelshot ) {
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $179
line 180
;180:		levelshot = trap_R_RegisterShaderNoMip( "menu/art/unknownmap" );
ADDRGP4 $181
ARGP4
ADDRLP4 1068
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 1040
ADDRLP4 1068
INDIRI4
ASGNI4
line 181
;181:	}
LABELV $179
line 182
;182:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 183
;183:	CG_DrawPic( 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, levelshot );
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 1142947840
ARGF4
CNSTF4 1139802112
ARGF4
ADDRLP4 1040
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 186
;184:
;185:	// blend a detail texture over it
;186:	detail = trap_R_RegisterShader( "levelShotDetail" );
ADDRGP4 $182
ARGP4
ADDRLP4 1068
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 1048
ADDRLP4 1068
INDIRI4
ASGNI4
line 187
;187:	trap_R_DrawStretchPic( 0, 0, cgs.glconfig.vidWidth, cgs.glconfig.vidHeight, 0, 0, 2.5, 2, detail );
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 cgs+20100+11304
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 cgs+20100+11308
INDIRI4
CVIF4 4
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 1075838976
ARGF4
CNSTF4 1073741824
ARGF4
ADDRLP4 1048
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 190
;188:
;189:	// draw the icons of things as they are loaded
;190:	CG_DrawLoadingIcons();
ADDRGP4 CG_DrawLoadingIcons
CALLV
pop
line 194
;191:
;192:	// the first 150 rows are reserved for the client connection
;193:	// screen to write into
;194:	if ( cg.infoScreenText[0] ) {
ADDRGP4 cg+112484
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $187
line 200
;195:		// JUHOX: don't use va() in CG_DrawInformation()
;196:#if 0
;197:		UI_DrawProportionalString( 320, 128/*-32*/-5, va("Loading... %s", cg.infoScreenText),	// JUHOX
;198:			UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
;199:#else
;200:		Com_sprintf(buf, sizeof(buf), /*"Loading... %s"*/"%s", cg.infoScreenText);	// JUHOX
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $190
ARGP4
ADDRGP4 cg+112484
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 201
;201:		UI_DrawProportionalString( 320, 128-5, buf,
CNSTI4 320
ARGI4
CNSTI4 123
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 204
;202:			UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
;203:#endif
;204:	} else {
ADDRGP4 $188
JUMPV
LABELV $187
line 205
;205:		UI_DrawProportionalString( 320, 128/*-32*/-5, "Awaiting snapshot...",	// JUHOX
CNSTI4 320
ARGI4
CNSTI4 123
ARGI4
ADDRGP4 $192
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 207
;206:			UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
;207:	}
LABELV $188
line 208
;208:	CG_DrawPic(30, 53, 580, 36, trap_R_RegisterShaderNoMip("gfx/hunt_name.tga"));	// JUHOX: draw "H U N T"
ADDRGP4 $193
ARGP4
ADDRLP4 1072
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
CNSTF4 1106247680
ARGF4
CNSTF4 1112801280
ARGF4
CNSTF4 1141964800
ARGF4
CNSTF4 1108344832
ARGF4
ADDRLP4 1072
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 212
;209:
;210:	// draw info string information
;211:
;212:	y = 180-32;
ADDRLP4 1024
CNSTI4 148
ASGNI4
line 215
;213:
;214:	// don't print server lines if playing a local game
;215:	trap_Cvar_VariableStringBuffer( "sv_running", buf, sizeof( buf ) );
ADDRGP4 $194
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 216
;216:	if ( !atoi( buf ) ) {
ADDRLP4 0
ARGP4
ADDRLP4 1076
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1076
INDIRI4
CNSTI4 0
NEI4 $195
line 218
;217:		// server hostname
;218:		Q_strncpyz(buf, Info_ValueForKey( info, "sv_hostname" ), 1024);
ADDRLP4 1036
INDIRP4
ARGP4
ADDRGP4 $197
ARGP4
ADDRLP4 1080
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
ADDRLP4 1080
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 219
;219:		Q_CleanStr(buf);
ADDRLP4 0
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 220
;220:		UI_DrawProportionalString( 320, y, buf,
CNSTI4 320
ARGI4
ADDRLP4 1024
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 222
;221:			UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
;222:		y += PROP_HEIGHT;
ADDRLP4 1024
ADDRLP4 1024
INDIRI4
CNSTI4 27
ADDI4
ASGNI4
line 225
;223:
;224:		// pure server
;225:		s = Info_ValueForKey( sysInfo, "sv_pure" );
ADDRLP4 1044
INDIRP4
ARGP4
ADDRGP4 $198
ARGP4
ADDRLP4 1084
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 1084
INDIRP4
ASGNP4
line 226
;226:		if ( s[0] == '1' ) {
ADDRLP4 1028
INDIRP4
INDIRI1
CVII4 1
CNSTI4 49
NEI4 $199
line 227
;227:			UI_DrawProportionalString( 320, y, "Pure Server",
CNSTI4 320
ARGI4
ADDRLP4 1024
INDIRI4
ARGI4
ADDRGP4 $201
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 229
;228:				UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
;229:			y += PROP_HEIGHT;
ADDRLP4 1024
ADDRLP4 1024
INDIRI4
CNSTI4 27
ADDI4
ASGNI4
line 230
;230:		}
LABELV $199
line 233
;231:
;232:		// server-specific message of the day
;233:		s = CG_ConfigString( CS_MOTD );
CNSTI4 4
ARGI4
ADDRLP4 1088
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 1088
INDIRP4
ASGNP4
line 234
;234:		if ( s[0] ) {
ADDRLP4 1028
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $202
line 235
;235:			UI_DrawProportionalString( 320, y, s,
CNSTI4 320
ARGI4
ADDRLP4 1024
INDIRI4
ARGI4
ADDRLP4 1028
INDIRP4
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 237
;236:				UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
;237:			y += PROP_HEIGHT;
ADDRLP4 1024
ADDRLP4 1024
INDIRI4
CNSTI4 27
ADDI4
ASGNI4
line 238
;238:		}
LABELV $202
line 241
;239:
;240:		// some extra space after hostname and motd
;241:		y += 10;
ADDRLP4 1024
ADDRLP4 1024
INDIRI4
CNSTI4 10
ADDI4
ASGNI4
line 242
;242:	}
LABELV $195
line 245
;243:
;244:	// map-specific message (long map name)
;245:	s = CG_ConfigString( CS_MESSAGE );
CNSTI4 3
ARGI4
ADDRLP4 1080
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 1080
INDIRP4
ASGNP4
line 246
;246:	if ( s[0] ) {
ADDRLP4 1028
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $204
line 247
;247:		UI_DrawProportionalString( 320, y, s,
CNSTI4 320
ARGI4
ADDRLP4 1024
INDIRI4
ARGI4
ADDRLP4 1028
INDIRP4
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 249
;248:			UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
;249:		y += PROP_HEIGHT;
ADDRLP4 1024
ADDRLP4 1024
INDIRI4
CNSTI4 27
ADDI4
ASGNI4
line 250
;250:	}
LABELV $204
line 253
;251:
;252:#if MAPLENSFLARES	// JUHOX: lens flare editor message
;253:	if (cgs.editMode == EM_mlf) {
ADDRGP4 cgs+31684
INDIRI4
CNSTI4 1
NEI4 $206
line 254
;254:		UI_DrawProportionalString(320, y, "LENS FLARE EDITOR", UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite);
CNSTI4 320
ARGI4
ADDRLP4 1024
INDIRI4
ARGI4
ADDRGP4 $209
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 255
;255:		return;
ADDRGP4 $176
JUMPV
LABELV $206
line 260
;256:	}
;257:#endif
;258:
;259:	// cheats warning
;260:	s = Info_ValueForKey( sysInfo, "sv_cheats" );
ADDRLP4 1044
INDIRP4
ARGP4
ADDRGP4 $210
ARGP4
ADDRLP4 1084
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 1084
INDIRP4
ASGNP4
line 261
;261:	if ( s[0] == '1' ) {
ADDRLP4 1028
INDIRP4
INDIRI1
CVII4 1
CNSTI4 49
NEI4 $211
line 262
;262:		UI_DrawProportionalString( 320, y, "CHEATS ARE ENABLED",
CNSTI4 320
ARGI4
ADDRLP4 1024
INDIRI4
ARGI4
ADDRGP4 $213
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 264
;263:			UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
;264:		y += PROP_HEIGHT;
ADDRLP4 1024
ADDRLP4 1024
INDIRI4
CNSTI4 27
ADDI4
ASGNI4
line 265
;265:	}
LABELV $211
line 268
;266:
;267:	// game type
;268:	switch ( cgs.gametype ) {
ADDRLP4 1088
ADDRGP4 cgs+31456
INDIRI4
ASGNI4
ADDRLP4 1088
INDIRI4
CNSTI4 0
LTI4 $214
ADDRLP4 1088
INDIRI4
CNSTI4 9
GTI4 $214
ADDRLP4 1088
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $233
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $233
address $218
address $222
address $220
address $224
address $226
address $214
address $214
address $214
address $228
address $230
code
LABELV $218
line 270
;269:	case GT_FFA:
;270:		s = "Free For All";
ADDRLP4 1028
ADDRGP4 $219
ASGNP4
line 271
;271:		break;
ADDRGP4 $215
JUMPV
LABELV $220
line 273
;272:	case GT_SINGLE_PLAYER:
;273:		s = "Single Player";
ADDRLP4 1028
ADDRGP4 $221
ASGNP4
line 274
;274:		break;
ADDRGP4 $215
JUMPV
LABELV $222
line 276
;275:	case GT_TOURNAMENT:
;276:		s = "Tournament";
ADDRLP4 1028
ADDRGP4 $223
ASGNP4
line 277
;277:		break;
ADDRGP4 $215
JUMPV
LABELV $224
line 279
;278:	case GT_TEAM:
;279:		s = "Team Deathmatch";
ADDRLP4 1028
ADDRGP4 $225
ASGNP4
line 280
;280:		break;
ADDRGP4 $215
JUMPV
LABELV $226
line 282
;281:	case GT_CTF:
;282:		s = "Capture The Flag";
ADDRLP4 1028
ADDRGP4 $227
ASGNP4
line 283
;283:		break;
ADDRGP4 $215
JUMPV
LABELV $228
line 297
;284:#ifdef MISSIONPACK
;285:	case GT_1FCTF:
;286:		s = "One Flag CTF";
;287:		break;
;288:	case GT_OBELISK:
;289:		s = "Overload";
;290:		break;
;291:	case GT_HARVESTER:
;292:		s = "Harvester";
;293:		break;
;294:#endif
;295:#if MONSTER_MODE	// JUHOX: STU name for info screen
;296:	case GT_STU:
;297:		s = "Save the Universe";
ADDRLP4 1028
ADDRGP4 $229
ASGNP4
line 298
;298:		break;
ADDRGP4 $215
JUMPV
LABELV $230
line 302
;299:#endif
;300:#if ESCAPE_MODE	// JUHOX: EFH name for info screen
;301:	case GT_EFH:
;302:		s = "Escape from Hell";
ADDRLP4 1028
ADDRGP4 $231
ASGNP4
line 303
;303:		break;
ADDRGP4 $215
JUMPV
LABELV $214
line 306
;304:#endif
;305:	default:
;306:		s = "Unknown Gametype";
ADDRLP4 1028
ADDRGP4 $232
ASGNP4
line 307
;307:		break;
LABELV $215
line 309
;308:	}
;309:	UI_DrawProportionalString( 320, y, s,
CNSTI4 320
ARGI4
ADDRLP4 1024
INDIRI4
ARGI4
ADDRLP4 1028
INDIRP4
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 311
;310:		UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
;311:	y += PROP_HEIGHT;
ADDRLP4 1024
ADDRLP4 1024
INDIRI4
CNSTI4 27
ADDI4
ASGNI4
line 313
;312:		
;313:	value = atoi( Info_ValueForKey( info, "timelimit" ) );
ADDRLP4 1036
INDIRP4
ARGP4
ADDRGP4 $234
ARGP4
ADDRLP4 1096
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1096
INDIRP4
ARGP4
ADDRLP4 1100
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1032
ADDRLP4 1100
INDIRI4
ASGNI4
line 314
;314:	if ( value ) {
ADDRLP4 1032
INDIRI4
CNSTI4 0
EQI4 $235
line 319
;315:#if 0	// JUHOX: don't use va() in CG_DrawInformation()
;316:		UI_DrawProportionalString( 320, y, va( "timelimit %i", value ),
;317:			UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
;318:#else
;319:		Com_sprintf(buf, sizeof(buf), "timelimit %i", value);
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $237
ARGP4
ADDRLP4 1032
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 320
;320:		UI_DrawProportionalString( 320, y, buf,
CNSTI4 320
ARGI4
ADDRLP4 1024
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 323
;321:			UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
;322:#endif
;323:		y += PROP_HEIGHT;
ADDRLP4 1024
ADDRLP4 1024
INDIRI4
CNSTI4 27
ADDI4
ASGNI4
line 324
;324:	}
LABELV $235
line 329
;325:
;326:#if !MONSTER_MODE	// JUHOX: use fraglimit also for STU
;327:	if (cgs.gametype < GT_CTF ) {
;328:#else
;329:	if (cgs.gametype < GT_CTF || cgs.gametype >= GT_STU) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
LTI4 $242
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 8
LTI4 $238
LABELV $242
line 331
;330:#endif
;331:		value = atoi( Info_ValueForKey( info, "fraglimit" ) );
ADDRLP4 1036
INDIRP4
ARGP4
ADDRGP4 $243
ARGP4
ADDRLP4 1104
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1104
INDIRP4
ARGP4
ADDRLP4 1108
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1032
ADDRLP4 1108
INDIRI4
ASGNI4
line 332
;332:		if ( value ) {
ADDRLP4 1032
INDIRI4
CNSTI4 0
EQI4 $244
line 338
;333:		// JUHOX: don't use va() in CG_DrawInformation()
;334:#if 0
;335:			UI_DrawProportionalString( 320, y, va( "fraglimit %i", value ),
;336:				UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
;337:#else
;338:			Com_sprintf(buf, sizeof(buf), "fraglimit %i", value);
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $246
ARGP4
ADDRLP4 1032
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 339
;339:			UI_DrawProportionalString( 320, y, buf,
CNSTI4 320
ARGI4
ADDRLP4 1024
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 342
;340:				UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
;341:#endif
;342:			y += PROP_HEIGHT;
ADDRLP4 1024
ADDRLP4 1024
INDIRI4
CNSTI4 27
ADDI4
ASGNI4
line 343
;343:		}
LABELV $244
line 344
;344:	}
LABELV $238
line 349
;345:
;346:#if !MONSTER_MODE	// JUHOX: don't use capturelimit for STU
;347:	if (cgs.gametype >= GT_CTF) {
;348:#else
;349:	if (cgs.gametype >= GT_CTF && cgs.gametype < GT_STU) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
LTI4 $247
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 8
GEI4 $247
line 351
;350:#endif
;351:		value = atoi( Info_ValueForKey( info, "capturelimit" ) );
ADDRLP4 1036
INDIRP4
ARGP4
ADDRGP4 $251
ARGP4
ADDRLP4 1104
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1104
INDIRP4
ARGP4
ADDRLP4 1108
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1032
ADDRLP4 1108
INDIRI4
ASGNI4
line 352
;352:		if ( value ) {
ADDRLP4 1032
INDIRI4
CNSTI4 0
EQI4 $252
line 358
;353:		// JUHOX: don't use va() in CG_DrawInformation()
;354:#if 0
;355:			UI_DrawProportionalString( 320, y, va( "capturelimit %i", value ),
;356:				UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
;357:#else
;358:			Com_sprintf(buf, sizeof(buf), "capturelimit %i", value);
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $254
ARGP4
ADDRLP4 1032
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 359
;359:			UI_DrawProportionalString( 320, y, buf,
CNSTI4 320
ARGI4
ADDRLP4 1024
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 362
;360:				UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
;361:#endif
;362:			y += PROP_HEIGHT;
ADDRLP4 1024
ADDRLP4 1024
INDIRI4
CNSTI4 27
ADDI4
ASGNI4
line 363
;363:		}
LABELV $252
line 364
;364:	}
LABELV $247
line 367
;365:
;366:#if MONSTER_MODE	// JUHOX: draw artefacts limit
;367:	if (cgs.gametype == GT_STU) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 8
NEI4 $255
line 368
;368:		value = atoi(Info_ValueForKey(info, "g_artefacts"));
ADDRLP4 1036
INDIRP4
ARGP4
ADDRGP4 $258
ARGP4
ADDRLP4 1104
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1104
INDIRP4
ARGP4
ADDRLP4 1108
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1032
ADDRLP4 1108
INDIRI4
ASGNI4
line 369
;369:		if (value == 999) {
ADDRLP4 1032
INDIRI4
CNSTI4 999
NEI4 $259
line 370
;370:			UI_DrawProportionalString(320, y, "unlimited artefacts",
CNSTI4 320
ARGI4
ADDRLP4 1024
INDIRI4
ARGI4
ADDRGP4 $261
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 372
;371:				UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite);
;372:			y += PROP_HEIGHT;			
ADDRLP4 1024
ADDRLP4 1024
INDIRI4
CNSTI4 27
ADDI4
ASGNI4
line 373
;373:		}
ADDRGP4 $260
JUMPV
LABELV $259
line 374
;374:		else if (value) {
ADDRLP4 1032
INDIRI4
CNSTI4 0
EQI4 $262
line 375
;375:			Com_sprintf(buf, sizeof(buf), "artefacts %i", value);
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $264
ARGP4
ADDRLP4 1032
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 376
;376:			UI_DrawProportionalString(320, y, buf,
CNSTI4 320
ARGI4
ADDRLP4 1024
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 378
;377:				UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite);
;378:			y += PROP_HEIGHT;
ADDRLP4 1024
ADDRLP4 1024
INDIRI4
CNSTI4 27
ADDI4
ASGNI4
line 379
;379:		}
LABELV $262
LABELV $260
line 380
;380:	}
LABELV $255
line 382
;381:#endif
;382:}
LABELV $176
endproc CG_DrawInformation 1112 36
bss
align 4
LABELV loadingItemIcons
skip 104
align 4
LABELV loadingPlayerIcons
skip 64
align 4
LABELV loadingItemIconCount
skip 4
align 4
LABELV loadingPlayerIconCount
skip 4
import CG_AdjustParticles
import CG_NewParticleArea
import initparticles
import CG_ParticleExplosion
import CG_ParticleMisc
import CG_ParticleDust
import CG_ParticleSparks
import CG_ParticleBulletDebris
import CG_ParticleSnowFlurry
import CG_AddParticleShrapnel
import CG_ParticleSmoke
import CG_ParticleSnow
import CG_AddParticles
import CG_ClearParticles
import trap_GetEntityToken
import trap_getCameraInfo
import trap_startCamera
import trap_loadCamera
import trap_SnapVector
import trap_CIN_SetExtents
import trap_CIN_DrawCinematic
import trap_CIN_RunCinematic
import trap_CIN_StopCinematic
import trap_CIN_PlayCinematic
import trap_Key_GetKey
import trap_Key_SetCatcher
import trap_Key_GetCatcher
import trap_Key_IsDown
import trap_R_RegisterFont
import trap_MemoryRemaining
import testPrintFloat
import testPrintInt
import trap_SetUserCmdValue
import trap_GetUserCmd
import trap_GetCurrentCmdNumber
import trap_GetServerCommand
import trap_GetSnapshot
import trap_GetCurrentSnapshotNumber
import trap_GetGameState
import trap_GetGlconfig
import trap_R_RemapShader
import trap_R_LerpTag
import trap_R_ModelBounds
import trap_R_DrawStretchPic
import trap_R_SetColor
import trap_R_RenderScene
import trap_R_LightForPoint
import trap_R_AddLightToScene
import trap_R_AddPolysToScene
import trap_R_AddPolyToScene
import trap_R_AddRefEntityToScene
import trap_R_ClearScene
import trap_R_RegisterShaderNoMip
import trap_R_RegisterShader
import trap_R_RegisterSkin
import trap_R_RegisterModel
import trap_R_LoadWorldMap
import trap_S_AddRealLoopingSound_fixed
import trap_S_AddLoopingSound_fixed
import trap_S_StartSound_fixed
import currentReference
import trap_S_StopBackgroundTrack
import trap_S_StartBackgroundTrack
import trap_S_RegisterSound
import trap_S_Respatialize
import trap_S_UpdateEntityPosition
import trap_S_AddRealLoopingSound
import trap_S_AddLoopingSound
import trap_S_ClearLoopingSounds
import trap_S_StartLocalSound
import trap_S_StopLoopingSound
import trap_S_StartSound
import trap_CM_MarkFragments
import trap_CM_TransformedBoxTrace
import trap_CM_BoxTrace
import trap_CM_TransformedPointContents
import trap_CM_PointContents
import trap_CM_TempBoxModel
import trap_CM_InlineModel
import trap_CM_NumInlineModels
import trap_CM_LoadMap
import trap_UpdateScreen
import trap_SendClientCommand
import trap_AddCommand
import trap_SendConsoleCommand
import trap_FS_Seek
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_FS_FOpenFile
import trap_Args
import trap_Argv
import trap_Argc
import trap_Cvar_VariableStringBuffer
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_Milliseconds
import trap_Error
import trap_Print
import CG_RunPlayListFrame
import CG_ResetPlayList
import CG_ContinuePlayList
import CG_StopPlayList
import CG_ParsePlayList
import CG_InitPlayList
import CG_TSS_CheckMouseEvents
import CG_TSS_CheckKeyEvents
import CG_TSS_MouseEvent
import CG_TSS_KeyEvent
import CG_TSS_CloseInterface
import CG_TSS_OpenInterface
import CG_TSS_DrawInterface
import CG_TSS_SPrintTacticalMeasure
import CG_TSS_Update
import CG_TSS_SaveInterface
import CG_TSS_LoadInterface
import CG_TSS_InitInterface
import TSS_SetPalette
import TSS_GetPalette
import CG_TSS_StrategyNameChanged
import CG_TSS_SetSearchPattern
import CG_TSS_CreateNewStrategy
import CG_TSS_FreePaletteSlot
import CG_TSS_SavePaletteSlotIfNeeded
import CG_TSS_LoadPaletteSlot
import CG_TSS_GetSortIndexByID
import CG_TSS_GetSortedSlot
import CG_TSS_GetSlotByName
import CG_TSS_GetSlotByID
import CG_TSS_NumStrategiesInStock
import TSSFS_SaveStrategyStock
import TSSFS_LoadStrategyStock
import TSSFS_LoadStrategy
import TSSFS_SaveStrategy
import CG_CheckChangedPredictableEvents
import CG_TransitionPlayerState
import CG_Respawn
import CG_PlayBufferedVoiceChats
import CG_VoiceChatLocal
import CG_ShaderStateChanged
import CG_LoadVoiceChats
import CG_SetConfigValues
import CG_ParseServerinfo
import CG_ExecuteNewServerCommands
import CG_InitConsoleCommands
import CG_ConsoleCommand
import CG_DrawOldTourneyScoreboard
import CG_DrawOldScoreboard
import CG_ProcessSnapshots
import CG_MakeExplosion
import CG_Bleed
import CG_BigExplode
import CG_BFGsuperExpl
import CG_GibPlayer
import CG_ScorePlum
import CG_SpawnEffect
import CG_BubbleTrail
import CG_SmokePuff
import CG_AdjustLocalEntities
import CG_AddLocalEntities
import CG_AllocLocalEntity
import CG_InitLocalEntities
import CG_DrawLightBlobs
import CG_CheckStrongLight
import CG_AddLightningMarks
import CG_AddNearbox
import CG_ImpactMark
import CG_AddMarks
import CG_InitMarkPolys
import CG_OutOfAmmoChange
import CG_DrawWeaponSelect
import CG_AddPlayerWeapon
import CG_AddViewWeapon
import CG_GrappleTrail
import CG_RailTrail
import CG_Draw3DLine
import CG_Bullet
import CG_ShotgunFire
import CG_MissileHitPlayer
import CG_MissileHitWall
import CG_FireWeapon
import CG_RegisterItemVisuals
import CG_RegisterWeapon
import CG_Weapon_f
import CG_PrevWeapon_f
import CG_NextWeapon_f
import CG_PrevWeaponOrder_f
import CG_NextWeaponOrder_f
import CG_SkipWeapon_f
import CG_BestWeapon_f
import CG_AutoSwitchToBestWeapon
import CG_CalcEntityLerpPositions
import CG_Mover
import CG_AddPacketEntitiesForGlassLook
import CG_PositionRotatedEntityOnTag
import CG_PositionEntityOnTag
import CG_AdjustPositionForMover
import CG_DrawLineSegment
import CG_Beam
import CG_AddPacketEntities
import CG_SetEntitySoundPosition
import CG_PainEvent
import CG_EntityEvent
import CG_PlaceString
import CG_CheckEvents
import CG_LoadDeferredPlayers
import CG_PredictPlayerState
import CG_SmoothTrace
import CG_Trace
import CG_PointContents
import CG_BuildSolidList
import CG_GetSpawnEffectParameters
import CG_InitMonsterClientInfo
import CG_CustomSound
import CG_NewClientInfo
import CG_AddRefEntityWithPowerups
import CG_ResetPlayerEntity
import CG_Player
import AddDischargeFlash
import CG_DrawTeamVote
import CG_DrawVote
import CG_StatusHandle
import CG_OtherTeamHasFlag
import CG_YourTeamHasFlag
import CG_GameTypeString
import CG_CheckOrderPending
import CG_Text_PaintChar
import CG_Draw3DModel
import CG_GetKillerText
import CG_GetGameStatusText
import CG_GetTeamColor
import CG_InitTeamChat
import CG_SetPrintString
import CG_ShowResponseHead
import CG_RunMenuScript
import CG_OwnerDrawVisible
import CG_GetValue
import CG_SelectNextPlayer
import CG_SelectPrevPlayer
import CG_Text_Height
import CG_Text_Width
import CG_Text_Paint
import CG_OwnerDraw
import CG_DrawTeamBackground
import CG_DrawFlagModel
import CG_DrawActive
import CG_DrawHead
import CG_CenterPrint
import CG_AddLagometerSnapshotInfo
import CG_AddLagometerFrameInfo
import teamChat2
import teamChat1
import systemChat
import drawTeamOverlayModificationCount
import numSortedTeamPlayers
import sortedTeamPlayers
import CG_DrawTopBottom
import CG_DrawSides
import CG_DrawRect
import UI_DrawProportionalString
import CG_GetColorForHealth
import CG_ColorForHealth
import CG_TileClear
import CG_TeamColor
import CG_FadeColor
import CG_DrawStrlen
import CG_DrawSmallStringColor
import CG_DrawSmallString
import CG_DrawBigStringColor
import CG_DrawBigString
import CG_DrawStringExt
import CG_DrawString
import CG_DrawPic
import CG_FillRect
import CG_AdjustFrom640
import CG_GetScreenCoordinates
import CG_AddLFEditorCursor
import CG_AdjustEarthquakes
import CG_AddEarthquake
import CG_DrawActiveFrame
import CG_AddBufferedSound
import CG_ZoomUp_f
import CG_ZoomDown_f
import CG_TestModelPrevSkin_f
import CG_TestModelNextSkin_f
import CG_TestModelPrevFrame_f
import CG_TestModelNextFrame_f
import CG_TestGun_f
import CG_TestModel_f
import CG_LoadLensFlareEntities
import CG_ComputeMaxVisAngle
import CG_LoadLensFlares
import CG_SelectLFEnt
import CG_SetLFEdMoveMode
import CG_SetLFEntOrigin
import CG_LFEntOrigin
import CG_BuildSpectatorString
import CG_GetSelectedScore
import CG_SetScoreSelection
import CG_RankRunFrame
import CG_EventHandling
import CG_MouseEvent
import CG_KeyEvent
import CG_LoadMenus
import CG_LastAttacker
import CG_CrosshairPlayer
import CG_UpdateCvars
import CG_StartMusic
import CG_Error
import CG_Printf
import CG_Argv
import CG_ConfigString
import cg_music
import cg_autoGLC
import cg_nearbox
import cg_BFGsuperExpl
import cg_missileFlare
import cg_sunFlare
import cg_mapFlare
import cg_lensFlare
import cg_glassCloaking
import cg_trueLightning
import cg_oldPlasma
import cg_oldRocket
import cg_oldRail
import cg_noProjectileTrail
import cg_noTaunt
import cg_bigFont
import cg_smallFont
import cg_cameraMode
import cg_timescale
import cg_timescaleFadeSpeed
import cg_timescaleFadeEnd
import cg_cameraOrbitDelay
import cg_cameraOrbit
import pmove_msec
import pmove_fixed
import cg_smoothClients
import cg_scorePlum
import cg_noVoiceText
import cg_noVoiceChats
import cg_teamChatsOnly
import cg_drawFriend
import cg_deferPlayers
import cg_predictItems
import cg_blood
import cg_paused
import cg_buildScript
import cg_forceModel
import cg_stats
import cg_teamChatHeight
import cg_teamChatTime
import cg_synchronousClients
import cg_drawAttacker
import cg_lagometer
import cg_stereoSeparation
import cg_thirdPerson
import cg_thirdPersonAngle
import cg_thirdPersonRange
import cg_zoomFov
import cg_fov
import cg_simpleItems
import cg_noTrace
import cg_tssiKey
import cg_tssiMouse
import cg_drawSegment
import cg_fireballTrail
import cg_drawNumMonsters
import cg_ignore
import cg_weaponOrderName
import cg_weaponOrder
import cg_autoswitchAmmoLimit
import cg_autoswitch
import cg_tracerLength
import cg_tracerWidth
import cg_tracerChance
import cg_viewsize
import cg_drawGun
import cg_gun_z
import cg_gun_y
import cg_gun_x
import cg_gun_frame
import cg_brassTime
import cg_addMarks
import cg_footsteps
import cg_showmiss
import cg_noPlayerAnims
import cg_nopredict
import cg_errorDecay
import cg_railTrailTime
import cg_debugEvents
import cg_debugPosition
import cg_debugAnim
import cg_animSpeed
import cg_draw2D
import cg_drawStatus
import cg_crosshairHealth
import cg_crosshairSize
import cg_crosshairY
import cg_crosshairX
import cg_teamOverlayUserinfo
import cg_drawTeamOverlay
import cg_drawRewards
import cg_drawCrosshairNames
import cg_drawCrosshair
import cg_drawAmmoWarning
import cg_drawIcons
import cg_draw3dIcons
import cg_drawSnapshot
import cg_drawFPS
import cg_drawTimer
import cg_gibs
import cg_shadows
import cg_swingSpeed
import cg_bobroll
import cg_bobpitch
import cg_bobup
import cg_runroll
import cg_runpitch
import cg_centertime
import cg_markPolys
import cg_items
import cg_weapons
import cg_entities
import cg
import cgs
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
LABELV $264
byte 1 97
byte 1 114
byte 1 116
byte 1 101
byte 1 102
byte 1 97
byte 1 99
byte 1 116
byte 1 115
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $261
byte 1 117
byte 1 110
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 114
byte 1 116
byte 1 101
byte 1 102
byte 1 97
byte 1 99
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $258
byte 1 103
byte 1 95
byte 1 97
byte 1 114
byte 1 116
byte 1 101
byte 1 102
byte 1 97
byte 1 99
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $254
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $251
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $246
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $243
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $237
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $234
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $232
byte 1 85
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $231
byte 1 69
byte 1 115
byte 1 99
byte 1 97
byte 1 112
byte 1 101
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 72
byte 1 101
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $229
byte 1 83
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 85
byte 1 110
byte 1 105
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $227
byte 1 67
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 32
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $225
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 68
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $223
byte 1 84
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $221
byte 1 83
byte 1 105
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 32
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $219
byte 1 70
byte 1 114
byte 1 101
byte 1 101
byte 1 32
byte 1 70
byte 1 111
byte 1 114
byte 1 32
byte 1 65
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $213
byte 1 67
byte 1 72
byte 1 69
byte 1 65
byte 1 84
byte 1 83
byte 1 32
byte 1 65
byte 1 82
byte 1 69
byte 1 32
byte 1 69
byte 1 78
byte 1 65
byte 1 66
byte 1 76
byte 1 69
byte 1 68
byte 1 0
align 1
LABELV $210
byte 1 115
byte 1 118
byte 1 95
byte 1 99
byte 1 104
byte 1 101
byte 1 97
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $209
byte 1 76
byte 1 69
byte 1 78
byte 1 83
byte 1 32
byte 1 70
byte 1 76
byte 1 65
byte 1 82
byte 1 69
byte 1 32
byte 1 69
byte 1 68
byte 1 73
byte 1 84
byte 1 79
byte 1 82
byte 1 0
align 1
LABELV $201
byte 1 80
byte 1 117
byte 1 114
byte 1 101
byte 1 32
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $198
byte 1 115
byte 1 118
byte 1 95
byte 1 112
byte 1 117
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $197
byte 1 115
byte 1 118
byte 1 95
byte 1 104
byte 1 111
byte 1 115
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $194
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
LABELV $193
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 104
byte 1 117
byte 1 110
byte 1 116
byte 1 95
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $192
byte 1 65
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 115
byte 1 110
byte 1 97
byte 1 112
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 46
byte 1 46
byte 1 46
byte 1 0
align 1
LABELV $190
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $182
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 83
byte 1 104
byte 1 111
byte 1 116
byte 1 68
byte 1 101
byte 1 116
byte 1 97
byte 1 105
byte 1 108
byte 1 0
align 1
LABELV $181
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $178
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $177
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $175
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
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $169
byte 1 115
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $166
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $163
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $162
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $155
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 51
byte 1 0
align 1
LABELV $154
byte 1 84
byte 1 105
byte 1 116
byte 1 97
byte 1 110
byte 1 0
align 1
LABELV $152
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 50
byte 1 0
align 1
LABELV $151
byte 1 71
byte 1 117
byte 1 97
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $149
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 49
byte 1 0
align 1
LABELV $148
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $147
byte 1 80
byte 1 114
byte 1 101
byte 1 100
byte 1 97
byte 1 116
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $146
byte 1 110
byte 1 0
