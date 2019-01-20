export UI_Alloc
code
proc UI_Alloc 8 0
file "..\..\..\..\code\q3_ui\ui_gameinfo.c"
line 38
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3://
;4:// gameinfo.c
;5://
;6:
;7:#include "ui_local.h"
;8:
;9:
;10://
;11:// arena and bot info
;12://
;13:
;14:// JUHOX: larger pool size (as with the missionpack)
;15:#if 0
;16:#define POOLSIZE	128 * 1024
;17:#else
;18:#define POOLSIZE	1024 * 1024
;19:#endif
;20:
;21:int				ui_numBots;
;22:static char		*ui_botInfos[MAX_BOTS];
;23:
;24:static int		ui_numArenas;
;25:static char		*ui_arenaInfos[MAX_ARENAS];
;26:
;27:static int		ui_numSinglePlayerArenas;
;28:static int		ui_numSpecialSinglePlayerArenas;
;29:
;30:static char		memoryPool[POOLSIZE];
;31:static int		allocPoint, outOfMemory;
;32:
;33:/*
;34:===============
;35:UI_Alloc
;36:===============
;37:*/
;38:void *UI_Alloc( int size ) {
line 41
;39:	char	*p;
;40:
;41:	if ( allocPoint + size > POOLSIZE ) {
ADDRGP4 allocPoint
INDIRI4
ADDRFP4 0
INDIRI4
ADDI4
CNSTI4 1048576
LEI4 $97
line 42
;42:		outOfMemory = qtrue;
ADDRGP4 outOfMemory
CNSTI4 1
ASGNI4
line 43
;43:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $96
JUMPV
LABELV $97
line 46
;44:	}
;45:
;46:	p = &memoryPool[allocPoint];
ADDRLP4 0
ADDRGP4 allocPoint
INDIRI4
ADDRGP4 memoryPool
ADDP4
ASGNP4
line 48
;47:
;48:	allocPoint += ( size + 31 ) & ~31;
ADDRLP4 4
ADDRGP4 allocPoint
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
ADDRFP4 0
INDIRI4
CNSTI4 31
ADDI4
CNSTI4 -32
BANDI4
ADDI4
ASGNI4
line 50
;49:
;50:	return p;
ADDRLP4 0
INDIRP4
RETP4
LABELV $96
endproc UI_Alloc 8 0
export UI_InitMemory
proc UI_InitMemory 0 0
line 58
;51:}
;52:
;53:/*
;54:===============
;55:UI_InitMemory
;56:===============
;57:*/
;58:void UI_InitMemory( void ) {
line 59
;59:	allocPoint = 0;
ADDRGP4 allocPoint
CNSTI4 0
ASGNI4
line 60
;60:	outOfMemory = qfalse;
ADDRGP4 outOfMemory
CNSTI4 0
ASGNI4
line 61
;61:}
LABELV $99
endproc UI_InitMemory 0 0
export UI_ParseInfos
proc UI_ParseInfos 2084 12
line 68
;62:
;63:/*
;64:===============
;65:UI_ParseInfos
;66:===============
;67:*/
;68:int UI_ParseInfos( char *buf, int max, char *infos[] ) {
line 74
;69:	char	*token;
;70:	int		count;
;71:	char	key[MAX_TOKEN_CHARS];
;72:	char	info[MAX_INFO_STRING];
;73:
;74:	count = 0;
ADDRLP4 2052
CNSTI4 0
ASGNI4
ADDRGP4 $102
JUMPV
LABELV $101
line 76
;75:
;76:	while ( 1 ) {
line 77
;77:		token = COM_Parse( &buf );
ADDRFP4 0
ARGP4
ADDRLP4 2056
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 2056
INDIRP4
ASGNP4
line 78
;78:		if ( !token[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $104
line 79
;79:			break;
ADDRGP4 $103
JUMPV
LABELV $104
line 81
;80:		}
;81:		if ( strcmp( token, "{" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $108
ARGP4
ADDRLP4 2060
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 2060
INDIRI4
CNSTI4 0
EQI4 $106
line 82
;82:			Com_Printf( "Missing { in info file\n" );
ADDRGP4 $109
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 83
;83:			break;
ADDRGP4 $103
JUMPV
LABELV $106
line 86
;84:		}
;85:
;86:		if ( count == max ) {
ADDRLP4 2052
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $110
line 87
;87:			Com_Printf( "Max infos exceeded\n" );
ADDRGP4 $112
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 88
;88:			break;
ADDRGP4 $103
JUMPV
LABELV $110
line 91
;89:		}
;90:
;91:		info[0] = '\0';
ADDRLP4 1028
CNSTI1 0
ASGNI1
ADDRGP4 $114
JUMPV
LABELV $113
line 92
;92:		while ( 1 ) {
line 93
;93:			token = COM_ParseExt( &buf, qtrue );
ADDRFP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 2064
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 2064
INDIRP4
ASGNP4
line 94
;94:			if ( !token[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $116
line 95
;95:				Com_Printf( "Unexpected end of info file\n" );
ADDRGP4 $118
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 96
;96:				break;
ADDRGP4 $115
JUMPV
LABELV $116
line 98
;97:			}
;98:			if ( !strcmp( token, "}" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $121
ARGP4
ADDRLP4 2068
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 2068
INDIRI4
CNSTI4 0
NEI4 $119
line 99
;99:				break;
ADDRGP4 $115
JUMPV
LABELV $119
line 101
;100:			}
;101:			Q_strncpyz( key, token, sizeof( key ) );
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 103
;102:
;103:			token = COM_ParseExt( &buf, qfalse );
ADDRFP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 2072
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 2072
INDIRP4
ASGNP4
line 104
;104:			if ( !token[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $122
line 105
;105:				strcpy( token, "<NULL>" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $124
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 106
;106:			}
LABELV $122
line 107
;107:			Info_SetValueForKey( info, key, token );
ADDRLP4 1028
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 108
;108:		}
LABELV $114
line 92
ADDRGP4 $113
JUMPV
LABELV $115
line 110
;109:		//NOTE: extra space for arena number
;110:		infos[count] = UI_Alloc(strlen(info) + strlen("\\num\\") + strlen(va("%d", MAX_ARENAS)) + 1);
ADDRLP4 1028
ARGP4
ADDRLP4 2064
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRGP4 $125
ARGP4
ADDRLP4 2068
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRGP4 $126
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 2072
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 2072
INDIRP4
ARGP4
ADDRLP4 2076
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 2064
INDIRI4
ADDRLP4 2068
INDIRI4
ADDI4
ADDRLP4 2076
INDIRI4
ADDI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 2080
ADDRGP4 UI_Alloc
CALLP4
ASGNP4
ADDRLP4 2052
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
ADDRLP4 2080
INDIRP4
ASGNP4
line 111
;111:		if (infos[count]) {
ADDRLP4 2052
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $127
line 112
;112:			strcpy(infos[count], info);
ADDRLP4 2052
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 1028
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 113
;113:			count++;
ADDRLP4 2052
ADDRLP4 2052
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 114
;114:		}
LABELV $127
line 115
;115:	}
LABELV $102
line 76
ADDRGP4 $101
JUMPV
LABELV $103
line 116
;116:	return count;
ADDRLP4 2052
INDIRI4
RETI4
LABELV $100
endproc UI_ParseInfos 2084 12
proc UI_LoadArenasFromFile 8216 16
line 124
;117:}
;118:
;119:/*
;120:===============
;121:UI_LoadArenasFromFile
;122:===============
;123:*/
;124:static void UI_LoadArenasFromFile( char *filename ) {
line 129
;125:	int				len;
;126:	fileHandle_t	f;
;127:	char			buf[MAX_ARENAS_TEXT];
;128:
;129:	len = trap_FS_FOpenFile( filename, &f, FS_READ );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8200
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8200
INDIRI4
ASGNI4
line 130
;130:	if ( !f ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $130
line 131
;131:		trap_Print( va( S_COLOR_RED "file not found: %s\n", filename ) );
ADDRGP4 $132
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8204
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8204
INDIRP4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 132
;132:		return;
ADDRGP4 $129
JUMPV
LABELV $130
line 134
;133:	}
;134:	if ( len >= MAX_ARENAS_TEXT ) {
ADDRLP4 0
INDIRI4
CNSTI4 8192
LTI4 $133
line 135
;135:		trap_Print( va( S_COLOR_RED "file too large: %s is %i, max allowed is %i", filename, len, MAX_ARENAS_TEXT ) );
ADDRGP4 $135
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 8192
ARGI4
ADDRLP4 8204
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8204
INDIRP4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 136
;136:		trap_FS_FCloseFile( f );
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 137
;137:		return;
ADDRGP4 $129
JUMPV
LABELV $133
line 140
;138:	}
;139:
;140:	trap_FS_Read( buf, len, f );
ADDRLP4 8
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 141
;141:	buf[len] = 0;
ADDRLP4 0
INDIRI4
ADDRLP4 8
ADDP4
CNSTI1 0
ASGNI1
line 142
;142:	trap_FS_FCloseFile( f );
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 144
;143:
;144:	ui_numArenas += UI_ParseInfos( buf, MAX_ARENAS - ui_numArenas, &ui_arenaInfos[ui_numArenas] );
ADDRLP4 8
ARGP4
ADDRLP4 8204
ADDRGP4 ui_numArenas
ASGNP4
ADDRLP4 8208
ADDRLP4 8204
INDIRP4
INDIRI4
ASGNI4
CNSTI4 1024
ADDRLP4 8208
INDIRI4
SUBI4
ARGI4
ADDRLP4 8208
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 ui_arenaInfos
ADDP4
ARGP4
ADDRLP4 8212
ADDRGP4 UI_ParseInfos
CALLI4
ASGNI4
ADDRLP4 8204
INDIRP4
ADDRLP4 8208
INDIRI4
ADDRLP4 8212
INDIRI4
ADDI4
ASGNI4
line 145
;145:}
LABELV $129
endproc UI_LoadArenasFromFile 8216 16
proc UI_LoadArenas 8660 16
line 152
;146:
;147:/*
;148:===============
;149:UI_LoadArenas
;150:===============
;151:*/
;152:static void UI_LoadArenas( void ) {
line 164
;153:	int			numdirs;
;154:	vmCvar_t	arenasFile;
;155:	char		filename[128];
;156:	char		dirlist[/*1024*/8192];	// JUHOX
;157:	char*		dirptr;
;158:	int			i, n;
;159:	int			dirlen;
;160:	char		*type;
;161:	char		*tag;
;162:	int			singlePlayerNum, specialNum, otherNum;
;163:
;164:	ui_numArenas = 0;
ADDRGP4 ui_numArenas
CNSTI4 0
ASGNI4
line 166
;165:
;166:	trap_Cvar_Register( &arenasFile, "g_arenasFile", "", CVAR_INIT|CVAR_ROM );
ADDRLP4 8360
ARGP4
ADDRGP4 $137
ARGP4
ADDRGP4 $138
ARGP4
CNSTI4 80
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 167
;167:	if( *arenasFile.string ) {
ADDRLP4 8360+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $139
line 168
;168:		UI_LoadArenasFromFile(arenasFile.string);
ADDRLP4 8360+16
ARGP4
ADDRGP4 UI_LoadArenasFromFile
CALLV
pop
line 169
;169:	}
ADDRGP4 $140
JUMPV
LABELV $139
line 170
;170:	else {
line 171
;171:		UI_LoadArenasFromFile("scripts/arenas.txt");
ADDRGP4 $143
ARGP4
ADDRGP4 UI_LoadArenasFromFile
CALLV
pop
line 172
;172:	}
LABELV $140
line 175
;173:
;174:	// get all arenas from .arena files
;175:	numdirs = trap_FS_GetFileList("scripts", ".arena", dirlist, /*1024*/sizeof(dirlist) );	// JUHOX
ADDRGP4 $144
ARGP4
ADDRGP4 $145
ARGP4
ADDRLP4 168
ARGP4
CNSTI4 8192
ARGI4
ADDRLP4 8632
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRLP4 152
ADDRLP4 8632
INDIRI4
ASGNI4
line 176
;176:	dirptr  = dirlist;
ADDRLP4 8
ADDRLP4 168
ASGNP4
line 177
;177:	for (i = 0; i < numdirs; i++, dirptr += dirlen+1) {
ADDRLP4 140
CNSTI4 0
ASGNI4
ADDRGP4 $149
JUMPV
LABELV $146
line 178
;178:		dirlen = strlen(dirptr);
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8636
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 144
ADDRLP4 8636
INDIRI4
ASGNI4
line 179
;179:		strcpy(filename, "scripts/");
ADDRLP4 12
ARGP4
ADDRGP4 $150
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 180
;180:		strcat(filename, dirptr);
ADDRLP4 12
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 181
;181:		UI_LoadArenasFromFile(filename);
ADDRLP4 12
ARGP4
ADDRGP4 UI_LoadArenasFromFile
CALLV
pop
line 182
;182:	}
LABELV $147
line 177
ADDRLP4 140
ADDRLP4 140
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 8
ADDRLP4 144
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 8
INDIRP4
ADDP4
ASGNP4
LABELV $149
ADDRLP4 140
INDIRI4
ADDRLP4 152
INDIRI4
LTI4 $146
line 183
;183:	trap_Print( va( "%i arenas parsed\n", ui_numArenas ) );
ADDRGP4 $151
ARGP4
ADDRGP4 ui_numArenas
INDIRI4
ARGI4
ADDRLP4 8636
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8636
INDIRP4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 184
;184:	if (outOfMemory) trap_Print(S_COLOR_YELLOW"WARNING: not anough memory in pool to load all arenas\n");
ADDRGP4 outOfMemory
INDIRI4
CNSTI4 0
EQI4 $152
ADDRGP4 $154
ARGP4
ADDRGP4 trap_Print
CALLV
pop
LABELV $152
line 187
;185:
;186:	// set initial numbers
;187:	for( n = 0; n < ui_numArenas; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $158
JUMPV
LABELV $155
line 188
;188:		Info_SetValueForKey( ui_arenaInfos[n], "num", va( "%i", n ) );
ADDRGP4 $160
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 8640
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 ui_arenaInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $159
ARGP4
ADDRLP4 8640
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 189
;189:	}
LABELV $156
line 187
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $158
ADDRLP4 0
INDIRI4
ADDRGP4 ui_numArenas
INDIRI4
LTI4 $155
line 192
;190:
;191:	// go through and count single players levels
;192:	ui_numSinglePlayerArenas = 0;
ADDRGP4 ui_numSinglePlayerArenas
CNSTI4 0
ASGNI4
line 193
;193:	ui_numSpecialSinglePlayerArenas = 0;
ADDRGP4 ui_numSpecialSinglePlayerArenas
CNSTI4 0
ASGNI4
line 194
;194:	for( n = 0; n < ui_numArenas; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $164
JUMPV
LABELV $161
line 196
;195:		// determine type
;196:		type = Info_ValueForKey( ui_arenaInfos[n], "type" );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 ui_arenaInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $165
ARGP4
ADDRLP4 8640
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8640
INDIRP4
ASGNP4
line 199
;197:
;198:		// if no type specified, it will be treated as "ffa"
;199:		if( !*type ) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $166
line 200
;200:			continue;
ADDRGP4 $162
JUMPV
LABELV $166
line 203
;201:		}
;202:
;203:		if( strstr( type, "single" ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $170
ARGP4
ADDRLP4 8644
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 8644
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $168
line 205
;204:			// check for special single player arenas (training, final)
;205:			tag = Info_ValueForKey( ui_arenaInfos[n], "special" );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 ui_arenaInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $171
ARGP4
ADDRLP4 8648
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 148
ADDRLP4 8648
INDIRP4
ASGNP4
line 206
;206:			if( *tag ) {
ADDRLP4 148
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $172
line 207
;207:				ui_numSpecialSinglePlayerArenas++;
ADDRLP4 8652
ADDRGP4 ui_numSpecialSinglePlayerArenas
ASGNP4
ADDRLP4 8652
INDIRP4
ADDRLP4 8652
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 208
;208:				continue;
ADDRGP4 $162
JUMPV
LABELV $172
line 211
;209:			}
;210:
;211:			ui_numSinglePlayerArenas++;
ADDRLP4 8652
ADDRGP4 ui_numSinglePlayerArenas
ASGNP4
ADDRLP4 8652
INDIRP4
ADDRLP4 8652
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 212
;212:		}
LABELV $168
line 213
;213:	}
LABELV $162
line 194
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $164
ADDRLP4 0
INDIRI4
ADDRGP4 ui_numArenas
INDIRI4
LTI4 $161
line 215
;214:
;215:	n = ui_numSinglePlayerArenas % ARENAS_PER_TIER;
ADDRLP4 0
ADDRGP4 ui_numSinglePlayerArenas
INDIRI4
CNSTI4 4
MODI4
ASGNI4
line 216
;216:	if( n != 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $174
line 217
;217:		ui_numSinglePlayerArenas -= n;
ADDRLP4 8640
ADDRGP4 ui_numSinglePlayerArenas
ASGNP4
ADDRLP4 8640
INDIRP4
ADDRLP4 8640
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
ASGNI4
line 218
;218:		trap_Print( va( "%i arenas ignored to make count divisible by %i\n", n, ARENAS_PER_TIER ) );
ADDRGP4 $176
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRLP4 8644
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8644
INDIRP4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 219
;219:	}
LABELV $174
line 222
;220:
;221:	// go through once more and assign number to the levels
;222:	singlePlayerNum = 0;
ADDRLP4 160
CNSTI4 0
ASGNI4
line 223
;223:	specialNum = singlePlayerNum + ui_numSinglePlayerArenas;
ADDRLP4 164
ADDRLP4 160
INDIRI4
ADDRGP4 ui_numSinglePlayerArenas
INDIRI4
ADDI4
ASGNI4
line 224
;224:	otherNum = specialNum + ui_numSpecialSinglePlayerArenas;
ADDRLP4 156
ADDRLP4 164
INDIRI4
ADDRGP4 ui_numSpecialSinglePlayerArenas
INDIRI4
ADDI4
ASGNI4
line 225
;225:	for( n = 0; n < ui_numArenas; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $180
JUMPV
LABELV $177
line 227
;226:		// determine type
;227:		type = Info_ValueForKey( ui_arenaInfos[n], "type" );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 ui_arenaInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $165
ARGP4
ADDRLP4 8640
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8640
INDIRP4
ASGNP4
line 230
;228:
;229:		// if no type specified, it will be treated as "ffa"
;230:		if( *type ) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $181
line 231
;231:			if( strstr( type, "single" ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $170
ARGP4
ADDRLP4 8644
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 8644
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $183
line 233
;232:				// check for special single player arenas (training, final)
;233:				tag = Info_ValueForKey( ui_arenaInfos[n], "special" );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 ui_arenaInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $171
ARGP4
ADDRLP4 8648
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 148
ADDRLP4 8648
INDIRP4
ASGNP4
line 234
;234:				if( *tag ) {
ADDRLP4 148
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $185
line 235
;235:					Info_SetValueForKey( ui_arenaInfos[n], "num", va( "%i", specialNum++ ) );
ADDRGP4 $160
ARGP4
ADDRLP4 8652
ADDRLP4 164
INDIRI4
ASGNI4
ADDRLP4 164
ADDRLP4 8652
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 8652
INDIRI4
ARGI4
ADDRLP4 8656
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 ui_arenaInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $159
ARGP4
ADDRLP4 8656
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 236
;236:					continue;
ADDRGP4 $178
JUMPV
LABELV $185
line 239
;237:				}
;238:
;239:				Info_SetValueForKey( ui_arenaInfos[n], "num", va( "%i", singlePlayerNum++ ) );
ADDRGP4 $160
ARGP4
ADDRLP4 8652
ADDRLP4 160
INDIRI4
ASGNI4
ADDRLP4 160
ADDRLP4 8652
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 8652
INDIRI4
ARGI4
ADDRLP4 8656
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 ui_arenaInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $159
ARGP4
ADDRLP4 8656
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 240
;240:				continue;
ADDRGP4 $178
JUMPV
LABELV $183
line 242
;241:			}
;242:		}
LABELV $181
line 244
;243:
;244:		Info_SetValueForKey( ui_arenaInfos[n], "num", va( "%i", otherNum++ ) );
ADDRGP4 $160
ARGP4
ADDRLP4 8644
ADDRLP4 156
INDIRI4
ASGNI4
ADDRLP4 156
ADDRLP4 8644
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 8644
INDIRI4
ARGI4
ADDRLP4 8648
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 ui_arenaInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $159
ARGP4
ADDRLP4 8648
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 245
;245:	}
LABELV $178
line 225
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $180
ADDRLP4 0
INDIRI4
ADDRGP4 ui_numArenas
INDIRI4
LTI4 $177
line 246
;246:}
LABELV $136
endproc UI_LoadArenas 8660 16
export UI_GetArenaInfoByNumber
proc UI_GetArenaInfoByNumber 24 8
line 253
;247:
;248:/*
;249:===============
;250:UI_GetArenaInfoByNumber
;251:===============
;252:*/
;253:const char *UI_GetArenaInfoByNumber( int num ) {
line 257
;254:	int		n;
;255:	char	*value;
;256:
;257:	if( num < 0 || num >= ui_numArenas ) {
ADDRLP4 8
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $190
ADDRLP4 8
INDIRI4
ADDRGP4 ui_numArenas
INDIRI4
LTI4 $188
LABELV $190
line 258
;258:		trap_Print( va( S_COLOR_RED "Invalid arena number: %i\n", num ) );
ADDRGP4 $191
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 259
;259:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $187
JUMPV
LABELV $188
line 262
;260:	}
;261:
;262:	for( n = 0; n < ui_numArenas; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $195
JUMPV
LABELV $192
line 263
;263:		value = Info_ValueForKey( ui_arenaInfos[n], "num" );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 ui_arenaInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $159
ARGP4
ADDRLP4 12
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 12
INDIRP4
ASGNP4
line 264
;264:		if( *value && atoi(value) == num ) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $196
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $196
line 265
;265:			return ui_arenaInfos[n];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 ui_arenaInfos
ADDP4
INDIRP4
RETP4
ADDRGP4 $187
JUMPV
LABELV $196
line 267
;266:		}
;267:	}
LABELV $193
line 262
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $195
ADDRLP4 0
INDIRI4
ADDRGP4 ui_numArenas
INDIRI4
LTI4 $192
line 269
;268:
;269:	return NULL;
CNSTP4 0
RETP4
LABELV $187
endproc UI_GetArenaInfoByNumber 24 8
export UI_GetArenaInfoByMap
proc UI_GetArenaInfoByMap 12 8
line 278
;270:}
;271:
;272:
;273:/*
;274:===============
;275:UI_GetArenaInfoByNumber
;276:===============
;277:*/
;278:const char *UI_GetArenaInfoByMap( const char *map ) {
line 281
;279:	int			n;
;280:
;281:	for( n = 0; n < ui_numArenas; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $202
JUMPV
LABELV $199
line 282
;282:		if( Q_stricmp( Info_ValueForKey( ui_arenaInfos[n], "map" ), map ) == 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 ui_arenaInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $205
ARGP4
ADDRLP4 4
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $203
line 283
;283:			return ui_arenaInfos[n];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 ui_arenaInfos
ADDP4
INDIRP4
RETP4
ADDRGP4 $198
JUMPV
LABELV $203
line 285
;284:		}
;285:	}
LABELV $200
line 281
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $202
ADDRLP4 0
INDIRI4
ADDRGP4 ui_numArenas
INDIRI4
LTI4 $199
line 287
;286:
;287:	return NULL;
CNSTP4 0
RETP4
LABELV $198
endproc UI_GetArenaInfoByMap 12 8
export UI_GetSpecialArenaInfo
proc UI_GetSpecialArenaInfo 12 8
line 296
;288:}
;289:
;290:
;291:/*
;292:===============
;293:UI_GetSpecialArenaInfo
;294:===============
;295:*/
;296:const char *UI_GetSpecialArenaInfo( const char *tag ) {
line 299
;297:	int			n;
;298:
;299:	for( n = 0; n < ui_numArenas; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $210
JUMPV
LABELV $207
line 300
;300:		if( Q_stricmp( Info_ValueForKey( ui_arenaInfos[n], "special" ), tag ) == 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 ui_arenaInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $171
ARGP4
ADDRLP4 4
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $211
line 301
;301:			return ui_arenaInfos[n];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 ui_arenaInfos
ADDP4
INDIRP4
RETP4
ADDRGP4 $206
JUMPV
LABELV $211
line 303
;302:		}
;303:	}
LABELV $208
line 299
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $210
ADDRLP4 0
INDIRI4
ADDRGP4 ui_numArenas
INDIRI4
LTI4 $207
line 305
;304:
;305:	return NULL;
CNSTP4 0
RETP4
LABELV $206
endproc UI_GetSpecialArenaInfo 12 8
proc UI_LoadBotsFromFile 8216 16
line 313
;306:}
;307:
;308:/*
;309:===============
;310:UI_LoadBotsFromFile
;311:===============
;312:*/
;313:static void UI_LoadBotsFromFile( char *filename ) {
line 318
;314:	int				len;
;315:	fileHandle_t	f;
;316:	char			buf[MAX_BOTS_TEXT];
;317:
;318:	len = trap_FS_FOpenFile( filename, &f, FS_READ );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8200
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8200
INDIRI4
ASGNI4
line 319
;319:	if ( !f ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $214
line 320
;320:		trap_Print( va( S_COLOR_RED "file not found: %s\n", filename ) );
ADDRGP4 $132
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8204
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8204
INDIRP4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 321
;321:		return;
ADDRGP4 $213
JUMPV
LABELV $214
line 323
;322:	}
;323:	if ( len >= MAX_BOTS_TEXT ) {
ADDRLP4 0
INDIRI4
CNSTI4 8192
LTI4 $216
line 324
;324:		trap_Print( va( S_COLOR_RED "file too large: %s is %i, max allowed is %i", filename, len, MAX_BOTS_TEXT ) );
ADDRGP4 $135
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 8192
ARGI4
ADDRLP4 8204
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8204
INDIRP4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 325
;325:		trap_FS_FCloseFile( f );
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 326
;326:		return;
ADDRGP4 $213
JUMPV
LABELV $216
line 329
;327:	}
;328:
;329:	trap_FS_Read( buf, len, f );
ADDRLP4 8
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 330
;330:	buf[len] = 0;
ADDRLP4 0
INDIRI4
ADDRLP4 8
ADDP4
CNSTI1 0
ASGNI1
line 331
;331:	trap_FS_FCloseFile( f );
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 333
;332:
;333:	ui_numBots += UI_ParseInfos( buf, MAX_BOTS - ui_numBots, &ui_botInfos[ui_numBots] );
ADDRLP4 8
ARGP4
ADDRLP4 8204
ADDRGP4 ui_numBots
ASGNP4
ADDRLP4 8208
ADDRLP4 8204
INDIRP4
INDIRI4
ASGNI4
CNSTI4 1024
ADDRLP4 8208
INDIRI4
SUBI4
ARGI4
ADDRLP4 8208
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 ui_botInfos
ADDP4
ARGP4
ADDRLP4 8212
ADDRGP4 UI_ParseInfos
CALLI4
ASGNI4
ADDRLP4 8204
INDIRP4
ADDRLP4 8208
INDIRI4
ADDRLP4 8212
INDIRI4
ADDI4
ASGNI4
line 334
;334:	if (outOfMemory) trap_Print(S_COLOR_YELLOW"WARNING: not anough memory in pool to load all bots\n");
ADDRGP4 outOfMemory
INDIRI4
CNSTI4 0
EQI4 $218
ADDRGP4 $220
ARGP4
ADDRGP4 trap_Print
CALLV
pop
LABELV $218
line 335
;335:}
LABELV $213
endproc UI_LoadBotsFromFile 8216 16
proc UI_LoadBots 8616 16
line 342
;336:
;337:/*
;338:===============
;339:UI_LoadBots
;340:===============
;341:*/
;342:static void UI_LoadBots( void ) {
line 351
;343:	vmCvar_t	botsFile;
;344:	int			numdirs;
;345:	char		filename[128];
;346:	char		dirlist[/*1024*/8192];	// JUHOX
;347:	char*		dirptr;
;348:	int			i;
;349:	int			dirlen;
;350:
;351:	ui_numBots = 0;
ADDRGP4 ui_numBots
CNSTI4 0
ASGNI4
line 353
;352:
;353:	trap_Cvar_Register( &botsFile, "g_botsFile", "", CVAR_INIT|CVAR_ROM );
ADDRLP4 8336
ARGP4
ADDRGP4 $222
ARGP4
ADDRGP4 $138
ARGP4
CNSTI4 80
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 354
;354:	if( *botsFile.string ) {
ADDRLP4 8336+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $223
line 355
;355:		UI_LoadBotsFromFile(botsFile.string);
ADDRLP4 8336+16
ARGP4
ADDRGP4 UI_LoadBotsFromFile
CALLV
pop
line 356
;356:	}
ADDRGP4 $224
JUMPV
LABELV $223
line 357
;357:	else {
line 358
;358:		UI_LoadBotsFromFile("scripts/bots.txt");
ADDRGP4 $227
ARGP4
ADDRGP4 UI_LoadBotsFromFile
CALLV
pop
line 359
;359:	}
LABELV $224
line 362
;360:
;361:	// get all bots from .bot files
;362:	numdirs = trap_FS_GetFileList("scripts", ".bot", dirlist, /*1024*/sizeof(dirlist) );	// JUHOX
ADDRGP4 $144
ARGP4
ADDRGP4 $228
ARGP4
ADDRLP4 144
ARGP4
CNSTI4 8192
ARGI4
ADDRLP4 8608
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRLP4 140
ADDRLP4 8608
INDIRI4
ASGNI4
line 363
;363:	dirptr  = dirlist;
ADDRLP4 0
ADDRLP4 144
ASGNP4
line 364
;364:	for (i = 0; i < numdirs; i++, dirptr += dirlen+1) {
ADDRLP4 132
CNSTI4 0
ASGNI4
ADDRGP4 $232
JUMPV
LABELV $229
line 365
;365:		dirlen = strlen(dirptr);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8612
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 136
ADDRLP4 8612
INDIRI4
ASGNI4
line 366
;366:		strcpy(filename, "scripts/");
ADDRLP4 4
ARGP4
ADDRGP4 $150
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 367
;367:		strcat(filename, dirptr);
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 368
;368:		UI_LoadBotsFromFile(filename);
ADDRLP4 4
ARGP4
ADDRGP4 UI_LoadBotsFromFile
CALLV
pop
line 369
;369:	}
LABELV $230
line 364
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 136
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 0
INDIRP4
ADDP4
ASGNP4
LABELV $232
ADDRLP4 132
INDIRI4
ADDRLP4 140
INDIRI4
LTI4 $229
line 370
;370:	trap_Print( va( "%i bots parsed\n", ui_numBots ) );
ADDRGP4 $233
ARGP4
ADDRGP4 ui_numBots
INDIRI4
ARGI4
ADDRLP4 8612
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8612
INDIRP4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 371
;371:}
LABELV $221
endproc UI_LoadBots 8616 16
export UI_GetBotInfoByNumber
proc UI_GetBotInfoByNumber 8 8
line 379
;372:
;373:
;374:/*
;375:===============
;376:UI_GetBotInfoByNumber
;377:===============
;378:*/
;379:char *UI_GetBotInfoByNumber( int num ) {
line 380
;380:	if( num < 0 || num >= ui_numBots ) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $237
ADDRLP4 0
INDIRI4
ADDRGP4 ui_numBots
INDIRI4
LTI4 $235
LABELV $237
line 381
;381:		trap_Print( va( S_COLOR_RED "Invalid bot number: %i\n", num ) );
ADDRGP4 $238
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 382
;382:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $234
JUMPV
LABELV $235
line 384
;383:	}
;384:	return ui_botInfos[num];
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 ui_botInfos
ADDP4
INDIRP4
RETP4
LABELV $234
endproc UI_GetBotInfoByNumber 8 8
export UI_GetBotInfoByName
proc UI_GetBotInfoByName 16 8
line 393
;385:}
;386:
;387:
;388:/*
;389:===============
;390:UI_GetBotInfoByName
;391:===============
;392:*/
;393:char *UI_GetBotInfoByName( const char *name ) {
line 397
;394:	int		n;
;395:	char	*value;
;396:
;397:	for ( n = 0; n < ui_numBots ; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $243
JUMPV
LABELV $240
line 398
;398:		value = Info_ValueForKey( ui_botInfos[n], "name" );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 ui_botInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $244
ARGP4
ADDRLP4 8
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 399
;399:		if ( !Q_stricmp( value, name ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $245
line 400
;400:			return ui_botInfos[n];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 ui_botInfos
ADDP4
INDIRP4
RETP4
ADDRGP4 $239
JUMPV
LABELV $245
line 402
;401:		}
;402:	}
LABELV $241
line 397
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $243
ADDRLP4 0
INDIRI4
ADDRGP4 ui_numBots
INDIRI4
LTI4 $240
line 404
;403:
;404:	return NULL;
CNSTP4 0
RETP4
LABELV $239
endproc UI_GetBotInfoByName 16 8
export UI_GetBestScore
proc UI_GetBestScore 1080 16
line 419
;405:}
;406:
;407:
;408://
;409:// single player game info
;410://
;411:
;412:/*
;413:===============
;414:UI_GetBestScore
;415:
;416:Returns the player's best finish on a given level, 0 if the have not played the level
;417:===============
;418:*/
;419:void UI_GetBestScore( int level, int *score, int *skill ) {
line 427
;420:	int		n;
;421:	int		skillScore;
;422:	int		bestScore;
;423:	int		bestScoreSkill;
;424:	char	arenaKey[16];
;425:	char	scores[MAX_INFO_VALUE];
;426:
;427:	if( !score || !skill ) {
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $250
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $248
LABELV $250
line 428
;428:		return;
ADDRGP4 $247
JUMPV
LABELV $248
line 431
;429:	}
;430:
;431:	if( level < 0 || level > ui_numArenas ) {
ADDRLP4 1056
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
LTI4 $253
ADDRLP4 1056
INDIRI4
ADDRGP4 ui_numArenas
INDIRI4
LEI4 $251
LABELV $253
line 432
;432:		return;
ADDRGP4 $247
JUMPV
LABELV $251
line 435
;433:	}
;434:
;435:	bestScore = 0;
ADDRLP4 24
CNSTI4 0
ASGNI4
line 436
;436:	bestScoreSkill = 0;
ADDRLP4 1052
CNSTI4 0
ASGNI4
line 438
;437:
;438:	for( n = 1; n <= 5; n++ ) {
ADDRLP4 4
CNSTI4 1
ASGNI4
LABELV $254
line 439
;439:		trap_Cvar_VariableStringBuffer( va( "g_spScores%i", n ), scores, MAX_INFO_VALUE );
ADDRGP4 $258
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 1060
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1060
INDIRP4
ARGP4
ADDRLP4 28
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 441
;440:
;441:		Com_sprintf( arenaKey, sizeof( arenaKey ), "l%i", level );
ADDRLP4 8
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $259
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 442
;442:		skillScore = atoi( Info_ValueForKey( scores, arenaKey ) );
ADDRLP4 28
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 1064
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1064
INDIRP4
ARGP4
ADDRLP4 1068
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 1068
INDIRI4
ASGNI4
line 444
;443:
;444:		if( skillScore < 1 || skillScore > 8 ) {
ADDRLP4 0
INDIRI4
CNSTI4 1
LTI4 $262
ADDRLP4 0
INDIRI4
CNSTI4 8
LEI4 $260
LABELV $262
line 445
;445:			continue;
ADDRGP4 $255
JUMPV
LABELV $260
line 448
;446:		}
;447:
;448:		if( !bestScore || skillScore <= bestScore ) {
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $265
ADDRLP4 0
INDIRI4
ADDRLP4 24
INDIRI4
GTI4 $263
LABELV $265
line 449
;449:			bestScore = skillScore;
ADDRLP4 24
ADDRLP4 0
INDIRI4
ASGNI4
line 450
;450:			bestScoreSkill = n;
ADDRLP4 1052
ADDRLP4 4
INDIRI4
ASGNI4
line 451
;451:		}
LABELV $263
line 452
;452:	}
LABELV $255
line 438
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 5
LEI4 $254
line 454
;453:
;454:	*score = bestScore;
ADDRFP4 4
INDIRP4
ADDRLP4 24
INDIRI4
ASGNI4
line 455
;455:	*skill = bestScoreSkill;
ADDRFP4 8
INDIRP4
ADDRLP4 1052
INDIRI4
ASGNI4
line 456
;456:}
LABELV $247
endproc UI_GetBestScore 1080 16
export UI_SetBestScore
proc UI_SetBestScore 1084 16
line 466
;457:
;458:
;459:/*
;460:===============
;461:UI_SetBestScore
;462:
;463:Set the player's best finish for a level
;464:===============
;465:*/
;466:void UI_SetBestScore( int level, int score ) {
line 473
;467:	int		skill;
;468:	int		oldScore;
;469:	char	arenaKey[16];
;470:	char	scores[MAX_INFO_VALUE];
;471:
;472:	// validate score
;473:	if( score < 1 || score > 8 ) {
ADDRLP4 1048
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 1
LTI4 $269
ADDRLP4 1048
INDIRI4
CNSTI4 8
LEI4 $267
LABELV $269
line 474
;474:		return;
ADDRGP4 $266
JUMPV
LABELV $267
line 478
;475:	}
;476:
;477:	// validate skill
;478:	skill = (int)trap_Cvar_VariableValue( "g_spSkill" );
ADDRGP4 $270
ARGP4
ADDRLP4 1052
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 1052
INDIRF4
CVFI4 4
ASGNI4
line 479
;479:	if( skill < 1 || skill > 5 ) {
ADDRLP4 0
INDIRI4
CNSTI4 1
LTI4 $273
ADDRLP4 0
INDIRI4
CNSTI4 5
LEI4 $271
LABELV $273
line 480
;480:		return;
ADDRGP4 $266
JUMPV
LABELV $271
line 484
;481:	}
;482:
;483:	// get scores
;484:	trap_Cvar_VariableStringBuffer( va( "g_spScores%i", skill ), scores, MAX_INFO_VALUE );
ADDRGP4 $258
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1060
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1060
INDIRP4
ARGP4
ADDRLP4 20
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 487
;485:
;486:	// see if this is better
;487:	Com_sprintf( arenaKey, sizeof( arenaKey ), "l%i", level );
ADDRLP4 4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $259
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 488
;488:	oldScore = atoi( Info_ValueForKey( scores, arenaKey ) );
ADDRLP4 20
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 1064
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1064
INDIRP4
ARGP4
ADDRLP4 1068
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1044
ADDRLP4 1068
INDIRI4
ASGNI4
line 489
;489:	if( oldScore && oldScore <= score ) {
ADDRLP4 1044
INDIRI4
CNSTI4 0
EQI4 $274
ADDRLP4 1044
INDIRI4
ADDRFP4 4
INDIRI4
GTI4 $274
line 490
;490:		return;
ADDRGP4 $266
JUMPV
LABELV $274
line 494
;491:	}
;492:
;493:	// update scores
;494:	Info_SetValueForKey( scores, arenaKey, va( "%i", score ) );
ADDRGP4 $160
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 1076
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 20
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 1076
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 495
;495:	trap_Cvar_Set( va( "g_spScores%i", skill ), scores );
ADDRGP4 $258
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1080
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1080
INDIRP4
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 496
;496:}
LABELV $266
endproc UI_SetBestScore 1084 16
export UI_LogAwardData
proc UI_LogAwardData 1056 16
line 504
;497:
;498:
;499:/*
;500:===============
;501:UI_LogAwardData
;502:===============
;503:*/
;504:void UI_LogAwardData( int award, int data ) {
line 509
;505:	char	key[16];
;506:	char	awardData[MAX_INFO_VALUE];
;507:	int		oldValue;
;508:
;509:	if( data == 0 ) {
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $277
line 510
;510:		return;
ADDRGP4 $276
JUMPV
LABELV $277
line 513
;511:	}
;512:
;513:	if( award > AWARD_PERFECT ) {
ADDRFP4 0
INDIRI4
CNSTI4 5
LEI4 $279
line 514
;514:		trap_Print( va( S_COLOR_RED "Bad award %i in UI_LogAwardData\n", award ) );
ADDRGP4 $281
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1044
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1044
INDIRP4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 515
;515:		return;
ADDRGP4 $276
JUMPV
LABELV $279
line 518
;516:	}
;517:
;518:	trap_Cvar_VariableStringBuffer( "g_spAwards", awardData, sizeof(awardData) );
ADDRGP4 $282
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 520
;519:
;520:	Com_sprintf( key, sizeof(key), "a%i", award );
ADDRLP4 1024
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $283
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 521
;521:	oldValue = atoi( Info_ValueForKey( awardData, key ) );
ADDRLP4 0
ARGP4
ADDRLP4 1024
ARGP4
ADDRLP4 1044
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1044
INDIRP4
ARGP4
ADDRLP4 1048
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1040
ADDRLP4 1048
INDIRI4
ASGNI4
line 523
;522:
;523:	Info_SetValueForKey( awardData, key, va( "%i", oldValue + data ) );
ADDRGP4 $160
ARGP4
ADDRLP4 1040
INDIRI4
ADDRFP4 4
INDIRI4
ADDI4
ARGI4
ADDRLP4 1052
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
ADDRLP4 1024
ARGP4
ADDRLP4 1052
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 524
;524:	trap_Cvar_Set( "g_spAwards", awardData );
ADDRGP4 $282
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 525
;525:}
LABELV $276
endproc UI_LogAwardData 1056 16
export UI_GetAwardLevel
proc UI_GetAwardLevel 1048 16
line 533
;526:
;527:
;528:/*
;529:===============
;530:UI_GetAwardLevel
;531:===============
;532:*/
;533:int UI_GetAwardLevel( int award ) {
line 537
;534:	char	key[16];
;535:	char	awardData[MAX_INFO_VALUE];
;536:
;537:	trap_Cvar_VariableStringBuffer( "g_spAwards", awardData, sizeof(awardData) );
ADDRGP4 $282
ARGP4
ADDRLP4 16
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 539
;538:
;539:	Com_sprintf( key, sizeof(key), "a%i", award );
ADDRLP4 0
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $283
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 540
;540:	return atoi( Info_ValueForKey( awardData, key ) );
ADDRLP4 16
ARGP4
ADDRLP4 0
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
ADDRLP4 1044
INDIRI4
RETI4
LABELV $284
endproc UI_GetAwardLevel 1048 16
export UI_TierCompleted
proc UI_TierCompleted 56 12
line 549
;541:}
;542:
;543:
;544:/*
;545:===============
;546:UI_TierCompleted
;547:===============
;548:*/
;549:int UI_TierCompleted( int levelWon ) {
line 557
;550:	int			level;
;551:	int			n;
;552:	int			tier;
;553:	int			score;
;554:	int			skill;
;555:	const char	*info;
;556:
;557:	tier = levelWon / ARENAS_PER_TIER;
ADDRLP4 16
ADDRFP4 0
INDIRI4
CNSTI4 4
DIVI4
ASGNI4
line 558
;558:	level = tier * ARENAS_PER_TIER;
ADDRLP4 0
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
line 560
;559:
;560:	if( tier == UI_GetNumSPTiers() ) {
ADDRLP4 24
ADDRGP4 UI_GetNumSPTiers
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
ADDRLP4 24
INDIRI4
NEI4 $286
line 561
;561:		info = UI_GetSpecialArenaInfo( "training" );
ADDRGP4 $288
ARGP4
ADDRLP4 28
ADDRGP4 UI_GetSpecialArenaInfo
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 28
INDIRP4
ASGNP4
line 562
;562:		if( levelWon == atoi( Info_ValueForKey( info, "num" ) ) ) {
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 $159
ARGP4
ADDRLP4 32
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRFP4 0
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $289
line 563
;563:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $285
JUMPV
LABELV $289
line 565
;564:		}
;565:		info = UI_GetSpecialArenaInfo( "final" );
ADDRGP4 $291
ARGP4
ADDRLP4 40
ADDRGP4 UI_GetSpecialArenaInfo
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 40
INDIRP4
ASGNP4
line 566
;566:		if( !info || levelWon == atoi( Info_ValueForKey( info, "num" ) ) ) {
ADDRLP4 44
ADDRLP4 20
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $294
ADDRLP4 44
INDIRP4
ARGP4
ADDRGP4 $159
ARGP4
ADDRLP4 48
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRFP4 0
INDIRI4
ADDRLP4 52
INDIRI4
NEI4 $292
LABELV $294
line 567
;567:			return tier + 1;
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
RETI4
ADDRGP4 $285
JUMPV
LABELV $292
line 569
;568:		}
;569:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $285
JUMPV
LABELV $286
line 572
;570:	}
;571:
;572:	for( n = 0; n < ARENAS_PER_TIER; n++, level++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $295
line 573
;573:		UI_GetBestScore( level, &score, &skill );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 UI_GetBestScore
CALLV
pop
line 574
;574:		if ( score != 1 ) {
ADDRLP4 8
INDIRI4
CNSTI4 1
EQI4 $299
line 575
;575:			return -1;
CNSTI4 -1
RETI4
ADDRGP4 $285
JUMPV
LABELV $299
line 577
;576:		}
;577:	}
LABELV $296
line 572
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 4
LTI4 $295
line 578
;578:	return tier + 1;
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
RETI4
LABELV $285
endproc UI_TierCompleted 56 12
export UI_ShowTierVideo
proc UI_ShowTierVideo 1052 16
line 587
;579:}
;580:
;581:
;582:/*
;583:===============
;584:UI_ShowTierVideo
;585:===============
;586:*/
;587:qboolean UI_ShowTierVideo( int tier ) {
line 591
;588:	char	key[16];
;589:	char	videos[MAX_INFO_VALUE];
;590:
;591:	if( tier <= 0 ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
GTI4 $302
line 592
;592:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $301
JUMPV
LABELV $302
line 595
;593:	}
;594:
;595:	trap_Cvar_VariableStringBuffer( "g_spVideos", videos, sizeof(videos) );
ADDRGP4 $304
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 597
;596:
;597:	Com_sprintf( key, sizeof(key), "tier%i", tier );
ADDRLP4 1024
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $305
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 598
;598:	if( atoi( Info_ValueForKey( videos, key ) ) ) {
ADDRLP4 0
ARGP4
ADDRLP4 1024
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
ADDRLP4 1044
INDIRI4
CNSTI4 0
EQI4 $306
line 599
;599:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $301
JUMPV
LABELV $306
line 602
;600:	}
;601:
;602:	Info_SetValueForKey( videos, key, va( "%i", 1 ) );
ADDRGP4 $160
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 1048
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
ADDRLP4 1024
ARGP4
ADDRLP4 1048
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 603
;603:	trap_Cvar_Set( "g_spVideos", videos );
ADDRGP4 $304
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 605
;604:
;605:	return qtrue;
CNSTI4 1
RETI4
LABELV $301
endproc UI_ShowTierVideo 1052 16
export UI_CanShowTierVideo
proc UI_CanShowTierVideo 1048 16
line 614
;606:}
;607:
;608:
;609:/*
;610:===============
;611:UI_CanShowTierVideo
;612:===============
;613:*/
;614:qboolean UI_CanShowTierVideo( int tier ) {
line 618
;615:	char	key[16];
;616:	char	videos[MAX_INFO_VALUE];
;617:
;618:	if( !tier ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $309
line 619
;619:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $308
JUMPV
LABELV $309
line 622
;620:	}
;621:
;622:	if( uis.demoversion && tier != 8 ) {
ADDRGP4 uis+11484
INDIRI4
CNSTI4 0
EQI4 $311
ADDRFP4 0
INDIRI4
CNSTI4 8
EQI4 $311
line 623
;623:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $308
JUMPV
LABELV $311
line 626
;624:	}
;625:
;626:	trap_Cvar_VariableStringBuffer( "g_spVideos", videos, sizeof(videos) );
ADDRGP4 $304
ARGP4
ADDRLP4 16
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 628
;627:
;628:	Com_sprintf( key, sizeof(key), "tier%i", tier );
ADDRLP4 0
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $305
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 629
;629:	if( atoi( Info_ValueForKey( videos, key ) ) ) {
ADDRLP4 16
ARGP4
ADDRLP4 0
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
ADDRLP4 1044
INDIRI4
CNSTI4 0
EQI4 $314
line 630
;630:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $308
JUMPV
LABELV $314
line 633
;631:	}
;632:
;633:	return qfalse;
CNSTI4 0
RETI4
LABELV $308
endproc UI_CanShowTierVideo 1048 16
export UI_GetCurrentGame
proc UI_GetCurrentGame 32 12
line 644
;634:}
;635:
;636:
;637:/*
;638:===============
;639:UI_GetCurrentGame
;640:
;641:Returns the next level the player has not won
;642:===============
;643:*/
;644:int UI_GetCurrentGame( void ) {
line 650
;645:	int		level;
;646:	int		rank;
;647:	int		skill;
;648:	const char *info;
;649:
;650:	info = UI_GetSpecialArenaInfo( "training" );
ADDRGP4 $288
ARGP4
ADDRLP4 16
ADDRGP4 UI_GetSpecialArenaInfo
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 16
INDIRP4
ASGNP4
line 651
;651:	if( info ) {
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $317
line 652
;652:		level = atoi( Info_ValueForKey( info, "num" ) );
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 $159
ARGP4
ADDRLP4 20
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 24
INDIRI4
ASGNI4
line 653
;653:		UI_GetBestScore( level, &rank, &skill );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 UI_GetBestScore
CALLV
pop
line 654
;654:		if ( !rank || rank > 1 ) {
ADDRLP4 28
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $321
ADDRLP4 28
INDIRI4
CNSTI4 1
LEI4 $319
LABELV $321
line 655
;655:			return level;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $316
JUMPV
LABELV $319
line 657
;656:		}
;657:	}
LABELV $317
line 659
;658:
;659:	for( level = 0; level < ui_numSinglePlayerArenas; level++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $325
JUMPV
LABELV $322
line 660
;660:		UI_GetBestScore( level, &rank, &skill );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 UI_GetBestScore
CALLV
pop
line 661
;661:		if ( !rank || rank > 1 ) {
ADDRLP4 20
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $328
ADDRLP4 20
INDIRI4
CNSTI4 1
LEI4 $326
LABELV $328
line 662
;662:			return level;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $316
JUMPV
LABELV $326
line 664
;663:		}
;664:	}
LABELV $323
line 659
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $325
ADDRLP4 0
INDIRI4
ADDRGP4 ui_numSinglePlayerArenas
INDIRI4
LTI4 $322
line 666
;665:
;666:	info = UI_GetSpecialArenaInfo( "final" );
ADDRGP4 $291
ARGP4
ADDRLP4 20
ADDRGP4 UI_GetSpecialArenaInfo
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 20
INDIRP4
ASGNP4
line 667
;667:	if( !info ) {
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $329
line 668
;668:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $316
JUMPV
LABELV $329
line 670
;669:	}
;670:	return atoi( Info_ValueForKey( info, "num" ) );
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 $159
ARGP4
ADDRLP4 24
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
RETI4
LABELV $316
endproc UI_GetCurrentGame 32 12
export UI_NewGame
proc UI_NewGame 0 8
line 681
;671:}
;672:
;673:
;674:/*
;675:===============
;676:UI_NewGame
;677:
;678:Clears the scores and sets the difficutly level
;679:===============
;680:*/
;681:void UI_NewGame( void ) {
line 682
;682:	trap_Cvar_Set( "g_spScores1", "" );
ADDRGP4 $332
ARGP4
ADDRGP4 $138
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 683
;683:	trap_Cvar_Set( "g_spScores2", "" );
ADDRGP4 $333
ARGP4
ADDRGP4 $138
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 684
;684:	trap_Cvar_Set( "g_spScores3", "" );
ADDRGP4 $334
ARGP4
ADDRGP4 $138
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 685
;685:	trap_Cvar_Set( "g_spScores4", "" );
ADDRGP4 $335
ARGP4
ADDRGP4 $138
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 686
;686:	trap_Cvar_Set( "g_spScores5", "" );
ADDRGP4 $336
ARGP4
ADDRGP4 $138
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 687
;687:	trap_Cvar_Set( "g_spAwards", "" );
ADDRGP4 $282
ARGP4
ADDRGP4 $138
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 688
;688:	trap_Cvar_Set( "g_spVideos", "" );
ADDRGP4 $304
ARGP4
ADDRGP4 $138
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 689
;689:}
LABELV $331
endproc UI_NewGame 0 8
export UI_GetNumArenas
proc UI_GetNumArenas 0 0
line 697
;690:
;691:
;692:/*
;693:===============
;694:UI_GetNumArenas
;695:===============
;696:*/
;697:int UI_GetNumArenas( void ) {
line 698
;698:	return ui_numArenas;
ADDRGP4 ui_numArenas
INDIRI4
RETI4
LABELV $337
endproc UI_GetNumArenas 0 0
export UI_GetNumSPArenas
proc UI_GetNumSPArenas 0 0
line 707
;699:}
;700:
;701:
;702:/*
;703:===============
;704:UI_GetNumSPArenas
;705:===============
;706:*/
;707:int UI_GetNumSPArenas( void ) {
line 708
;708:	return ui_numSinglePlayerArenas;
ADDRGP4 ui_numSinglePlayerArenas
INDIRI4
RETI4
LABELV $338
endproc UI_GetNumSPArenas 0 0
export UI_GetNumSPTiers
proc UI_GetNumSPTiers 0 0
line 717
;709:}
;710:
;711:
;712:/*
;713:===============
;714:UI_GetNumSPTiers
;715:===============
;716:*/
;717:int UI_GetNumSPTiers( void ) {
line 718
;718:	return ui_numSinglePlayerArenas / ARENAS_PER_TIER;
ADDRGP4 ui_numSinglePlayerArenas
INDIRI4
CNSTI4 4
DIVI4
RETI4
LABELV $339
endproc UI_GetNumSPTiers 0 0
export UI_GetNumBots
proc UI_GetNumBots 0 0
line 727
;719:}
;720:
;721:
;722:/*
;723:===============
;724:UI_GetNumBots
;725:===============
;726:*/
;727:int UI_GetNumBots( void ) {
line 728
;728:	return ui_numBots;
ADDRGP4 ui_numBots
INDIRI4
RETI4
LABELV $340
endproc UI_GetNumBots 0 0
export UI_SPUnlock_f
proc UI_SPUnlock_f 1048 16
line 737
;729:}
;730:
;731:
;732:/*
;733:===============
;734:UI_SPUnlock_f
;735:===============
;736:*/
;737:void UI_SPUnlock_f( void ) {
line 744
;738:	char	arenaKey[16];
;739:	char	scores[MAX_INFO_VALUE];
;740:	int		level;
;741:	int		tier;
;742:
;743:	// get scores for skill 1
;744:	trap_Cvar_VariableStringBuffer( "g_spScores1", scores, MAX_INFO_VALUE );
ADDRGP4 $332
ARGP4
ADDRLP4 24
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 747
;745:
;746:	// update scores
;747:	for( level = 0; level < ui_numSinglePlayerArenas + ui_numSpecialSinglePlayerArenas; level++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $345
JUMPV
LABELV $342
line 748
;748:		Com_sprintf( arenaKey, sizeof( arenaKey ), "l%i", level );
ADDRLP4 8
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $259
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 749
;749:		Info_SetValueForKey( scores, arenaKey, "1" );
ADDRLP4 24
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 $346
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 750
;750:	}
LABELV $343
line 747
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $345
ADDRLP4 0
INDIRI4
ADDRGP4 ui_numSinglePlayerArenas
INDIRI4
ADDRGP4 ui_numSpecialSinglePlayerArenas
INDIRI4
ADDI4
LTI4 $342
line 751
;751:	trap_Cvar_Set( "g_spScores1", scores );
ADDRGP4 $332
ARGP4
ADDRLP4 24
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 754
;752:
;753:	// unlock cinematics
;754:	for( tier = 1; tier <= 8; tier++ ) {
ADDRLP4 4
CNSTI4 1
ASGNI4
LABELV $347
line 755
;755:		UI_ShowTierVideo( tier );
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 UI_ShowTierVideo
CALLI4
pop
line 756
;756:	}
LABELV $348
line 754
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 8
LEI4 $347
line 758
;757:
;758:	trap_Print( "All levels unlocked at skill level 1\n" );
ADDRGP4 $351
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 760
;759:
;760:	UI_SPLevelMenu_ReInit();
ADDRGP4 UI_SPLevelMenu_ReInit
CALLV
pop
line 761
;761:}
LABELV $341
endproc UI_SPUnlock_f 1048 16
export UI_SPUnlockMedals_f
proc UI_SPUnlockMedals_f 1044 16
line 769
;762:
;763:
;764:/*
;765:===============
;766:UI_SPUnlockMedals_f
;767:===============
;768:*/
;769:void UI_SPUnlockMedals_f( void ) {
line 774
;770:	int		n;
;771:	char	key[16];
;772:	char	awardData[MAX_INFO_VALUE];
;773:
;774:	trap_Cvar_VariableStringBuffer( "g_spAwards", awardData, MAX_INFO_VALUE );
ADDRGP4 $282
ARGP4
ADDRLP4 20
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 776
;775:
;776:	for( n = 0; n < 6; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $353
line 777
;777:		Com_sprintf( key, sizeof(key), "a%i", n );
ADDRLP4 4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $283
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 778
;778:		Info_SetValueForKey( awardData, key, "100" );
ADDRLP4 20
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 $357
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 779
;779:	}
LABELV $354
line 776
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 6
LTI4 $353
line 781
;780:
;781:	trap_Cvar_Set( "g_spAwards", awardData );
ADDRGP4 $282
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 783
;782:
;783:	trap_Print( "All levels unlocked at 100\n" );
ADDRGP4 $358
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 784
;784:}
LABELV $352
endproc UI_SPUnlockMedals_f 1044 16
bss
align 1
LABELV $360
skip 65536
code
proc UI_TSS_LoadTssFiles 40 16
line 1013
;785:
;786:
;787:/*
;788:===============
;789:JUHOX: UI_TSS_EnterStrategyFileInStock
;790:===============
;791:*/
;792:#if !TSSINCVAR
;793:static tss_strategySlot_t* UI_TSS_EnterStrategyFileInStock(const char* filename, tss_strategyStock_t* stock) {
;794:	int i;
;795:	int freeSlot;
;796:
;797:	freeSlot = -1;
;798:	for (i = 0; i < TSS_MAX_STRATEGIES; i++) {
;799:		if (stock->slots[i].filename[0]) {
;800:			if (!strcmp(filename, stock->slots[i].filename)) {
;801:				stock->slots[i].id = i;	// mark as valid
;802:				return &stock->slots[i];
;803:			}
;804:		}
;805:		else if (freeSlot < 0) {
;806:			freeSlot = i;
;807:		}
;808:	}
;809:
;810:	if (freeSlot >= 0) {
;811:		trap_Print(va("importing %s at slot #%03d ...\n", filename, freeSlot));
;812:		strcpy(stock->slots[freeSlot].filename, filename);
;813:		stock->slots[freeSlot].id = freeSlot;	// mark as valid
;814:		stock->slots[freeSlot].creationTime = 0;	// set this later
;815:		stock->slots[freeSlot].accessTime = 0;		// never accessed
;816:		return &stock->slots[freeSlot];
;817:	}
;818:	return NULL;
;819:}
;820:#endif
;821:
;822:/*
;823:===============
;824:JUHOX: UI_TSS_ConvertInt
;825:===============
;826:*/
;827:#if !TSSINCVAR
;828:static int UI_TSS_ConvertInt(const void* buf) {
;829:	const unsigned char* p;
;830:	int n;
;831:
;832:	p = (const unsigned char*) buf;
;833:
;834:	n  = p[0] << 24;
;835:	n += p[1] << 16;
;836:	n += p[2] << 8;
;837:	n += p[3];
;838:	return n;
;839:}
;840:#endif
;841:
;842:/*
;843:===============
;844:JUHOX: UI_TSS_GetTSSName
;845:===============
;846:*/
;847:#if !TSSINCVAR
;848:static qboolean UI_TSS_GetTSSName(int gametype, const char* path, tss_strategySlot_t* slot) {
;849:	char filename[64];
;850:	char buf[1024];
;851:	fileHandle_t f;
;852:	int len;
;853:	int g;
;854:	char* tssname;
;855:	qboolean ok;
;856:
;857:	ok = qfalse;
;858:
;859:	Com_sprintf(filename, sizeof(filename), "%s/%s", path, slot->filename);
;860:	len = trap_FS_FOpenFile(filename, &f, FS_READ);
;861:	if (!f) goto Exit;
;862:	if (len < sizeof(buf)) goto Exit;
;863:
;864:	trap_FS_Read(buf, sizeof(buf), f);
;865:	
;866:	g = UI_TSS_ConvertInt(&((tss_strategyHeader_t*)buf)->gametype);
;867:	if (g != gametype) {
;868:		trap_Print(va("%s: wrong gametype %d, expected %d\n", filename, g, gametype));
;869:		goto Exit;
;870:	}
;871:
;872:	tssname = ((tss_strategyHeader_t*)buf)->name;
;873:	tssname[TSS_NAME_SIZE - 1] = 0;
;874:	if (Q_strncmp(slot->tssname, tssname, 999)) {
;875:		trap_Print(va("tss name for slot #%03d set to '%s'\n", slot->id, tssname));
;876:	}
;877:	memset(slot->tssname, 0, sizeof(slot->tssname));
;878:	strcpy(slot->tssname, tssname);
;879:	ok = qtrue;
;880:
;881:	Exit:
;882:	if (f) trap_FS_FCloseFile(f);
;883:	return ok;
;884:}
;885:#endif
;886:
;887:/*
;888:===============
;889:JUHOX: UI_TSS_UpdateStrategyStock
;890:
;891:This sucks! We need to do this here, just because cgame does not have trap_FS_GetFileList()!
;892:===============
;893:*/
;894:#if !TSSINCVAR
;895:static void UI_TSS_UpdateStrategyStock(int gametype) {
;896:	const char* path;
;897:	const char* stockFile;
;898:	static tss_strategyStock_t strategyStock;
;899:	fileHandle_t f;
;900:	int len;
;901:	static char listbuf[32768];
;902:	int numStrategies;
;903:	const char* listptr;
;904:	int i;
;905:	int creationClock;
;906:
;907:	switch (gametype) {
;908:	case GT_TEAM:
;909:		path = "tss/tdm";
;910:		stockFile = "tss/tdm/" TSS_STOCK_FILE;
;911:		break;
;912:	case GT_CTF:
;913:		path = "tss/ctf";
;914:		stockFile = "tss/ctf/" TSS_STOCK_FILE;
;915:		break;
;916:	default:
;917:		return;
;918:	}
;919:
;920:	if (trap_Cvar_VariableValue("sv_pure") > 0) {
;921:		trap_Print(va("can't update %s (sv_pure=1)\n", stockFile));
;922:		return;
;923:	}
;924:
;925:	// some initializations
;926:	memset(&strategyStock, 0, sizeof(strategyStock));
;927:	creationClock = 1;
;928:
;929:	// read the strategy stock
;930:	len = trap_FS_FOpenFile(stockFile, &f, FS_READ);
;931:	if (f && len == sizeof(strategyStock)) {
;932:		trap_FS_Read(&strategyStock, sizeof(strategyStock), f);
;933:		trap_Print(va("reading %s ...\n", stockFile));
;934:	}
;935:	else {
;936:		trap_Print(va("creating %s ...\n", stockFile));
;937:	}
;938:	if (f) trap_FS_FCloseFile(f);
;939:	for (i = 0; i < TSS_MAX_STRATEGIES; i++) {
;940:		strategyStock.slots[i].id = -1;	// this is later used to detect deleted files
;941:		strategyStock.slots[i].flags = 0;
;942:		strategyStock.slots[i].filename[TSS_NAME_SIZE-1] = 0;
;943:	}
;944:
;945:	// add new files
;946:	numStrategies = trap_FS_GetFileList(path, "hst", listbuf, sizeof(listbuf));
;947:	if (numStrategies > TSS_MAX_STRATEGIES) numStrategies = TSS_MAX_STRATEGIES;
;948:	listptr = listbuf;
;949:	for (i = 0; i < numStrategies; i++) {
;950:		len = strlen(listptr);
;951:		if (len < TSS_NAME_SIZE) {
;952:			tss_strategySlot_t* slot;
;953:
;954:			slot = UI_TSS_EnterStrategyFileInStock(listptr, &strategyStock);
;955:			if (slot) {
;956:				if (!UI_TSS_GetTSSName(gametype, path, slot)) {
;957:					slot->id = -1;
;958:				}
;959:			}
;960:		}
;961:		listptr += len + 1;
;962:	}
;963:	
;964:	// remove deleted files
;965:	for (i = 0; i < TSS_MAX_STRATEGIES; i++) {
;966:		if (
;967:			!strategyStock.slots[i].filename[0] ||
;968:			strategyStock.slots[i].id < 0
;969:		) {
;970:			if (strategyStock.slots[i].filename[0]) {
;971:				trap_Print(va("removing %s from stock file\n", strategyStock.slots[i].filename[0]));
;972:			}
;973:			memset(&strategyStock.slots[i], 0, sizeof(tss_strategySlot_t));
;974:		}
;975:
;976:		strategyStock.slots[i].id = i;
;977:	}
;978:
;979:	// get system time
;980:	for (i = 0; i < TSS_MAX_STRATEGIES; i++) {
;981:		if (strategyStock.slots[i].creationTime >= creationClock) {
;982:			creationClock = strategyStock.slots[i].creationTime + 1;
;983:		}
;984:	}
;985:
;986:	// set creation time on new files
;987:	for (i = 0; i < TSS_MAX_STRATEGIES; i++) {
;988:		if (!strategyStock.slots[i].filename[0]) continue;
;989:		if (strategyStock.slots[i].creationTime) continue;
;990:
;991:		strategyStock.slots[i].creationTime = creationClock++;
;992:	}
;993:
;994:	// write the strategy stock file back to disk
;995:	trap_FS_FOpenFile(stockFile, &f, FS_WRITE);
;996:	if (f) {
;997:		trap_FS_Write(&strategyStock, sizeof(strategyStock), f);
;998:		trap_FS_FCloseFile(f);
;999:		trap_Print(va("%s successfully updated\n", stockFile));
;1000:	}
;1001:	else {
;1002:		trap_Print(va(S_COLOR_RED "could not update %s\n", stockFile));
;1003:	}
;1004:}
;1005:#endif
;1006:
;1007:/*
;1008:===============
;1009:JUHOX: UI_TSS_LoadTssFiles
;1010:===============
;1011:*/
;1012:#if TSSINCVAR
;1013:static void UI_TSS_LoadTssFiles(void) {
line 1019
;1014:	static char listbuf[65536];
;1015:	const char* listptr;
;1016:	int numStrategies;
;1017:	int i;
;1018:
;1019:	if (trap_Cvar_VariableValue("tssinit") > 0.5) return;
ADDRGP4 $363
ARGP4
ADDRLP4 12
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 12
INDIRF4
CNSTF4 1056964608
LEF4 $361
ADDRGP4 $359
JUMPV
LABELV $361
line 1021
;1020:
;1021:	trap_Cmd_ExecuteText(EXEC_INSERT, "exec tss/tdm.stk\n");
CNSTI4 1
ARGI4
ADDRGP4 $364
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 1022
;1022:	trap_Cmd_ExecuteText(EXEC_INSERT, "exec tss/ctf.stk\n");
CNSTI4 1
ARGI4
ADDRGP4 $365
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 1024
;1023:
;1024:	numStrategies = trap_FS_GetFileList("tss", "tss", listbuf, sizeof(listbuf));
ADDRLP4 16
ADDRGP4 $366
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 $360
ARGP4
CNSTI4 65536
ARGI4
ADDRLP4 20
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 20
INDIRI4
ASGNI4
line 1025
;1025:	if (numStrategies > TSS_MAX_STRATEGIES) numStrategies = TSS_MAX_STRATEGIES;
ADDRLP4 8
INDIRI4
CNSTI4 1000
LEI4 $367
ADDRLP4 8
CNSTI4 1000
ASGNI4
LABELV $367
line 1026
;1026:	uis.numTssEntries = -1;
ADDRGP4 uis+95100
CNSTI4 -1
ASGNI4
line 1027
;1027:	listptr = listbuf;
ADDRLP4 0
ADDRGP4 $360
ASGNP4
line 1028
;1028:	for (i = 0; i < numStrategies; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $373
JUMPV
LABELV $370
line 1031
;1029:		int len;
;1030:
;1031:		len = strlen(listptr);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 28
INDIRI4
ASGNI4
line 1032
;1032:		if (len < TSS_NAME_SIZE) {
ADDRLP4 24
INDIRI4
CNSTI4 32
GEI4 $374
line 1033
;1033:			trap_Cmd_ExecuteText(EXEC_INSERT, va("set tsstmp \"%s\"; exec tss/%s\n", listptr, listptr));
ADDRGP4 $376
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 1
ARGI4
ADDRLP4 36
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 1034
;1034:		}
LABELV $374
line 1035
;1035:		listptr += len + 1;
ADDRLP4 0
ADDRLP4 24
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 0
INDIRP4
ADDP4
ASGNP4
line 1036
;1036:	}
LABELV $371
line 1028
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $373
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $370
line 1038
;1037:
;1038:	trap_Cvar_Set("tssinit", "1");
ADDRGP4 $363
ARGP4
ADDRGP4 $346
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1039
;1039:}
LABELV $359
endproc UI_TSS_LoadTssFiles 40 16
export UI_InitGameinfo
proc UI_InitGameinfo 4 4
line 1047
;1040:#endif
;1041:
;1042:/*
;1043:===============
;1044:UI_InitGameinfo
;1045:===============
;1046:*/
;1047:void UI_InitGameinfo( void ) {
line 1049
;1048:
;1049:	UI_InitMemory();
ADDRGP4 UI_InitMemory
CALLV
pop
line 1050
;1050:	UI_LoadArenas();
ADDRGP4 UI_LoadArenas
CALLV
pop
line 1051
;1051:	UI_LoadBots();
ADDRGP4 UI_LoadBots
CALLV
pop
line 1056
;1052:#if !TSSINCVAR
;1053:	UI_TSS_UpdateStrategyStock(GT_TEAM);	// JUHOX
;1054:	UI_TSS_UpdateStrategyStock(GT_CTF);		// JUHOX
;1055:#else
;1056:	UI_TSS_LoadTssFiles();	// JUHOX
ADDRGP4 UI_TSS_LoadTssFiles
CALLV
pop
line 1059
;1057:#endif
;1058:
;1059:	if( (trap_Cvar_VariableValue( "fs_restrict" )) || (ui_numSpecialSinglePlayerArenas == 0 && ui_numSinglePlayerArenas == 4) ) {
ADDRGP4 $380
ARGP4
ADDRLP4 0
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 0
INDIRF4
CNSTF4 0
NEF4 $381
ADDRGP4 ui_numSpecialSinglePlayerArenas
INDIRI4
CNSTI4 0
NEI4 $378
ADDRGP4 ui_numSinglePlayerArenas
INDIRI4
CNSTI4 4
NEI4 $378
LABELV $381
line 1060
;1060:		uis.demoversion = qtrue;
ADDRGP4 uis+11484
CNSTI4 1
ASGNI4
line 1061
;1061:	}
ADDRGP4 $379
JUMPV
LABELV $378
line 1062
;1062:	else {
line 1063
;1063:		uis.demoversion = qfalse;
ADDRGP4 uis+11484
CNSTI4 0
ASGNI4
line 1064
;1064:	}
LABELV $379
line 1065
;1065:}
LABELV $377
endproc UI_InitGameinfo 4 4
bss
align 4
LABELV outOfMemory
skip 4
align 4
LABELV allocPoint
skip 4
align 1
LABELV memoryPool
skip 1048576
align 4
LABELV ui_numSpecialSinglePlayerArenas
skip 4
align 4
LABELV ui_numSinglePlayerArenas
skip 4
align 4
LABELV ui_arenaInfos
skip 4096
align 4
LABELV ui_numArenas
skip 4
align 4
LABELV ui_botInfos
skip 4096
export ui_numBots
align 4
LABELV ui_numBots
skip 4
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
LABELV $380
byte 1 102
byte 1 115
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $376
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 116
byte 1 115
byte 1 115
byte 1 116
byte 1 109
byte 1 112
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 59
byte 1 32
byte 1 101
byte 1 120
byte 1 101
byte 1 99
byte 1 32
byte 1 116
byte 1 115
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $366
byte 1 116
byte 1 115
byte 1 115
byte 1 0
align 1
LABELV $365
byte 1 101
byte 1 120
byte 1 101
byte 1 99
byte 1 32
byte 1 116
byte 1 115
byte 1 115
byte 1 47
byte 1 99
byte 1 116
byte 1 102
byte 1 46
byte 1 115
byte 1 116
byte 1 107
byte 1 10
byte 1 0
align 1
LABELV $364
byte 1 101
byte 1 120
byte 1 101
byte 1 99
byte 1 32
byte 1 116
byte 1 115
byte 1 115
byte 1 47
byte 1 116
byte 1 100
byte 1 109
byte 1 46
byte 1 115
byte 1 116
byte 1 107
byte 1 10
byte 1 0
align 1
LABELV $363
byte 1 116
byte 1 115
byte 1 115
byte 1 105
byte 1 110
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $358
byte 1 65
byte 1 108
byte 1 108
byte 1 32
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 115
byte 1 32
byte 1 117
byte 1 110
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 49
byte 1 48
byte 1 48
byte 1 10
byte 1 0
align 1
LABELV $357
byte 1 49
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $351
byte 1 65
byte 1 108
byte 1 108
byte 1 32
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 115
byte 1 32
byte 1 117
byte 1 110
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 32
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 32
byte 1 49
byte 1 10
byte 1 0
align 1
LABELV $346
byte 1 49
byte 1 0
align 1
LABELV $336
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 53
byte 1 0
align 1
LABELV $335
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 52
byte 1 0
align 1
LABELV $334
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 51
byte 1 0
align 1
LABELV $333
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 50
byte 1 0
align 1
LABELV $332
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 49
byte 1 0
align 1
LABELV $305
byte 1 116
byte 1 105
byte 1 101
byte 1 114
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $304
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 86
byte 1 105
byte 1 100
byte 1 101
byte 1 111
byte 1 115
byte 1 0
align 1
LABELV $291
byte 1 102
byte 1 105
byte 1 110
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $288
byte 1 116
byte 1 114
byte 1 97
byte 1 105
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $283
byte 1 97
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $282
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 65
byte 1 119
byte 1 97
byte 1 114
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $281
byte 1 94
byte 1 49
byte 1 66
byte 1 97
byte 1 100
byte 1 32
byte 1 97
byte 1 119
byte 1 97
byte 1 114
byte 1 100
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 85
byte 1 73
byte 1 95
byte 1 76
byte 1 111
byte 1 103
byte 1 65
byte 1 119
byte 1 97
byte 1 114
byte 1 100
byte 1 68
byte 1 97
byte 1 116
byte 1 97
byte 1 10
byte 1 0
align 1
LABELV $270
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
LABELV $259
byte 1 108
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $258
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $244
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $238
byte 1 94
byte 1 49
byte 1 73
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $233
byte 1 37
byte 1 105
byte 1 32
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $228
byte 1 46
byte 1 98
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $227
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 115
byte 1 47
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 46
byte 1 116
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $222
byte 1 103
byte 1 95
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 70
byte 1 105
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $220
byte 1 94
byte 1 51
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 97
byte 1 110
byte 1 111
byte 1 117
byte 1 103
byte 1 104
byte 1 32
byte 1 109
byte 1 101
byte 1 109
byte 1 111
byte 1 114
byte 1 121
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 112
byte 1 111
byte 1 111
byte 1 108
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 32
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $205
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $191
byte 1 94
byte 1 49
byte 1 73
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 32
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $176
byte 1 37
byte 1 105
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 115
byte 1 32
byte 1 105
byte 1 103
byte 1 110
byte 1 111
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 109
byte 1 97
byte 1 107
byte 1 101
byte 1 32
byte 1 99
byte 1 111
byte 1 117
byte 1 110
byte 1 116
byte 1 32
byte 1 100
byte 1 105
byte 1 118
byte 1 105
byte 1 115
byte 1 105
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $171
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 105
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $170
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $165
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $160
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $159
byte 1 110
byte 1 117
byte 1 109
byte 1 0
align 1
LABELV $154
byte 1 94
byte 1 51
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 97
byte 1 110
byte 1 111
byte 1 117
byte 1 103
byte 1 104
byte 1 32
byte 1 109
byte 1 101
byte 1 109
byte 1 111
byte 1 114
byte 1 121
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 112
byte 1 111
byte 1 111
byte 1 108
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $151
byte 1 37
byte 1 105
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 115
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $150
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 115
byte 1 47
byte 1 0
align 1
LABELV $145
byte 1 46
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 0
align 1
LABELV $144
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $143
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 115
byte 1 47
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 115
byte 1 46
byte 1 116
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $138
byte 1 0
align 1
LABELV $137
byte 1 103
byte 1 95
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 115
byte 1 70
byte 1 105
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $135
byte 1 94
byte 1 49
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 108
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 37
byte 1 105
byte 1 44
byte 1 32
byte 1 109
byte 1 97
byte 1 120
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $132
byte 1 94
byte 1 49
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $126
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $125
byte 1 92
byte 1 110
byte 1 117
byte 1 109
byte 1 92
byte 1 0
align 1
LABELV $124
byte 1 60
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 62
byte 1 0
align 1
LABELV $121
byte 1 125
byte 1 0
align 1
LABELV $118
byte 1 85
byte 1 110
byte 1 101
byte 1 120
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 101
byte 1 110
byte 1 100
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $112
byte 1 77
byte 1 97
byte 1 120
byte 1 32
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 115
byte 1 32
byte 1 101
byte 1 120
byte 1 99
byte 1 101
byte 1 101
byte 1 100
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $109
byte 1 77
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 123
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $108
byte 1 123
byte 1 0
