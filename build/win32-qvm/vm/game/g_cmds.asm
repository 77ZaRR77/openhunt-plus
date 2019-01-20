export DeathmatchScoreboardMessage
code
proc DeathmatchScoreboardMessage 2484 36
file "..\..\..\..\code\game\g_cmds.c"
line 13
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:#include "g_local.h"
;4:
;5:#include "../../ui/menudef.h"			// for the voice chats
;6:
;7:/*
;8:==================
;9:DeathmatchScoreboardMessage
;10:
;11:==================
;12:*/
;13:void DeathmatchScoreboardMessage( gentity_t *ent ) {
line 22
;14:	char		entry[1024];
;15:	char		string[1400];
;16:	int			stringlength;
;17:	int			i, j;
;18:	gclient_t	*cl;
;19:	int			numSorted, scoreFlags, accuracy, perfect;
;20:
;21:	// send the latest information on all clients
;22:	string[0] = 0;
ADDRLP4 1040
CNSTI1 0
ASGNI1
line 23
;23:	stringlength = 0;
ADDRLP4 1032
CNSTI4 0
ASGNI4
line 24
;24:	scoreFlags = 0;
ADDRLP4 2452
CNSTI4 0
ASGNI4
line 26
;25:
;26:	numSorted = level.numConnectedClients;
ADDRLP4 2440
ADDRGP4 level+88
INDIRI4
ASGNI4
line 28
;27:	
;28:	for (i=0 ; i < numSorted ; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $92
JUMPV
LABELV $89
line 31
;29:		int		ping;
;30:
;31:		cl = &level.clients[level.sortedClients[i]];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+100
ADDP4
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 33
;32:
;33:		if ( cl->pers.connected == CON_CONNECTING ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 1
NEI4 $94
line 34
;34:			ping = -1;
ADDRLP4 2456
CNSTI4 -1
ASGNI4
line 35
;35:		} else {
ADDRGP4 $95
JUMPV
LABELV $94
line 36
;36:			ping = cl->ps.ping < 999 ? cl->ps.ping : 999;
ADDRLP4 0
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
CNSTI4 999
GEI4 $97
ADDRLP4 2460
ADDRLP4 0
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $98
JUMPV
LABELV $97
ADDRLP4 2460
CNSTI4 999
ASGNI4
LABELV $98
ADDRLP4 2456
ADDRLP4 2460
INDIRI4
ASGNI4
line 37
;37:		}
LABELV $95
line 39
;38:
;39:		if( cl->accuracy_shots ) {
ADDRLP4 0
INDIRP4
CNSTI4 808
ADDP4
INDIRI4
CNSTI4 0
EQI4 $99
line 40
;40:			accuracy = cl->accuracy_hits * 100 / cl->accuracy_shots;
ADDRLP4 2444
ADDRLP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRI4
CNSTI4 100
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 808
ADDP4
INDIRI4
DIVI4
ASGNI4
line 41
;41:		}
ADDRGP4 $100
JUMPV
LABELV $99
line 42
;42:		else {
line 43
;43:			accuracy = 0;
ADDRLP4 2444
CNSTI4 0
ASGNI4
line 44
;44:		}
LABELV $100
line 45
;45:		perfect = ( cl->ps.persistant[PERS_RANK] == 0 && cl->ps.persistant[PERS_KILLED] == 0 ) ? 1 : 0;
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
CNSTI4 0
NEI4 $102
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
CNSTI4 0
NEI4 $102
ADDRLP4 2460
CNSTI4 1
ASGNI4
ADDRGP4 $103
JUMPV
LABELV $102
ADDRLP4 2460
CNSTI4 0
ASGNI4
LABELV $103
ADDRLP4 2448
ADDRLP4 2460
INDIRI4
ASGNI4
line 60
;46:
;47:#if 0	// JUHOX: also send 'killed'-count and respawn timer
;48:		Com_sprintf (entry, sizeof(entry),
;49:			" %i %i %i %i %i %i %i %i %i %i %i %i %i %i", level.sortedClients[i],
;50:			cl->ps.persistant[PERS_SCORE], ping, (level.time - cl->pers.enterTime)/60000,
;51:			scoreFlags, g_entities[level.sortedClients[i]].s.powerups, accuracy, 
;52:			cl->ps.persistant[PERS_IMPRESSIVE_COUNT],
;53:			cl->ps.persistant[PERS_EXCELLENT_COUNT],
;54:			cl->ps.persistant[PERS_GAUNTLET_FRAG_COUNT], 
;55:			cl->ps.persistant[PERS_DEFEND_COUNT], 
;56:			cl->ps.persistant[PERS_ASSIST_COUNT], 
;57:			perfect,
;58:			cl->ps.persistant[PERS_CAPTURES]);
;59:#else
;60:		Com_sprintf (entry, sizeof(entry),
ADDRLP4 8
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $104
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+100
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
ARGI4
ADDRLP4 2456
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $110
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 2
RSHI4
CNSTI4 0
LEI4 $110
ADDRLP4 2468
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 2
RSHI4
NEGI4
ASGNI4
ADDRGP4 $111
JUMPV
LABELV $110
ADDRLP4 2468
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 552
ADDP4
INDIRI4
SUBI4
CNSTI4 60000
DIVI4
ASGNI4
LABELV $111
ADDRLP4 2468
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+100
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+188
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 76
;61:			" %i %i %i %i %i %i", level.sortedClients[i],
;62:			cl->ps.persistant[PERS_SCORE], cl->ps.persistant[PERS_KILLED], ping,
;63:			cl->ps.stats[STAT_HEALTH] <= 0 && (cl->ps.stats[STAT_RESPAWN_INFO] >> 2) > 0?
;64:				-(cl->ps.stats[STAT_RESPAWN_INFO] >> 2) :
;65:				(level.time - cl->pers.enterTime)/60000,
;66:			/*scoreFlags,*/ g_entities[level.sortedClients[i]].s.powerups/*, accuracy,*/
;67:			/* 
;68:			cl->ps.persistant[PERS_IMPRESSIVE_COUNT],
;69:			cl->ps.persistant[PERS_EXCELLENT_COUNT],
;70:			cl->ps.persistant[PERS_GAUNTLET_FRAG_COUNT],
;71:			cl->ps.persistant[PERS_DEFEND_COUNT],
;72:			cl->ps.persistant[PERS_ASSIST_COUNT],
;73:			perfect,
;74:			cl->ps.persistant[PERS_CAPTURES]*/);
;75:#endif
;76:		j = strlen(entry);
ADDRLP4 8
ARGP4
ADDRLP4 2480
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1036
ADDRLP4 2480
INDIRI4
ASGNI4
line 77
;77:		if (stringlength + j > 1024)
ADDRLP4 1032
INDIRI4
ADDRLP4 1036
INDIRI4
ADDI4
CNSTI4 1024
LEI4 $112
line 78
;78:			break;
ADDRGP4 $91
JUMPV
LABELV $112
line 79
;79:		strcpy (string + stringlength, entry);
ADDRLP4 1032
INDIRI4
ADDRLP4 1040
ADDP4
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 80
;80:		stringlength += j;
ADDRLP4 1032
ADDRLP4 1032
INDIRI4
ADDRLP4 1036
INDIRI4
ADDI4
ASGNI4
line 81
;81:	}
LABELV $90
line 28
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $92
ADDRLP4 4
INDIRI4
ADDRLP4 2440
INDIRI4
LTI4 $89
LABELV $91
line 83
;82:
;83:	trap_SendServerCommand( ent-g_entities, va("scores %i %i %i%s", i, 
ADDRGP4 $114
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 level+44+4
INDIRI4
ARGI4
ADDRGP4 level+44+8
INDIRI4
ARGI4
ADDRLP4 1040
ARGP4
ADDRLP4 2456
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRLP4 2456
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 86
;84:		level.teamScores[TEAM_RED], level.teamScores[TEAM_BLUE],
;85:		string ) );
;86:}
LABELV $87
endproc DeathmatchScoreboardMessage 2484 36
export Cmd_Score_f
proc Cmd_Score_f 0 4
line 96
;87:
;88:
;89:/*
;90:==================
;91:Cmd_Score_f
;92:
;93:Request current scoreboard information
;94:==================
;95:*/
;96:void Cmd_Score_f( gentity_t *ent ) {
line 97
;97:	DeathmatchScoreboardMessage( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 DeathmatchScoreboardMessage
CALLV
pop
line 98
;98:}
LABELV $119
endproc Cmd_Score_f 0 4
export CheatsOk
proc CheatsOk 4 8
line 107
;99:
;100:
;101:
;102:/*
;103:==================
;104:CheatsOk
;105:==================
;106:*/
;107:qboolean	CheatsOk( gentity_t *ent ) {
line 108
;108:	if ( !g_cheats.integer ) {
ADDRGP4 g_cheats+12
INDIRI4
CNSTI4 0
NEI4 $121
line 109
;109:		trap_SendServerCommand( ent-g_entities, va("print \"Cheats are not enabled on this server.\n\""));
ADDRGP4 $124
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 110
;110:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $120
JUMPV
LABELV $121
line 112
;111:	}
;112:	if ( ent->health <= 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
GTI4 $125
line 113
;113:		trap_SendServerCommand( ent-g_entities, va("print \"You must be alive to use this command.\n\""));
ADDRGP4 $127
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 114
;114:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $120
JUMPV
LABELV $125
line 116
;115:	}
;116:	return qtrue;
CNSTI4 1
RETI4
LABELV $120
endproc CheatsOk 4 8
bss
align 1
LABELV $129
skip 1024
export ConcatArgs
code
proc ConcatArgs 1048 12
line 125
;117:}
;118:
;119:
;120:/*
;121:==================
;122:ConcatArgs
;123:==================
;124:*/
;125:char	*ConcatArgs( int start ) {
line 131
;126:	int		i, c, tlen;
;127:	static char	line[MAX_STRING_CHARS];
;128:	int		len;
;129:	char	arg[MAX_STRING_CHARS];
;130:
;131:	len = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 132
;132:	c = trap_Argc();
ADDRLP4 1040
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 1036
ADDRLP4 1040
INDIRI4
ASGNI4
line 133
;133:	for ( i = start ; i < c ; i++ ) {
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
ADDRGP4 $133
JUMPV
LABELV $130
line 134
;134:		trap_Argv( i, arg, sizeof( arg ) );
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 135
;135:		tlen = strlen( arg );
ADDRLP4 12
ARGP4
ADDRLP4 1044
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 1044
INDIRI4
ASGNI4
line 136
;136:		if ( len + tlen >= MAX_STRING_CHARS - 1 ) {
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
ADDI4
CNSTI4 1023
LTI4 $134
line 137
;137:			break;
ADDRGP4 $132
JUMPV
LABELV $134
line 139
;138:		}
;139:		memcpy( line + len, arg, tlen );
ADDRLP4 0
INDIRI4
ADDRGP4 $129
ADDP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 140
;140:		len += tlen;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
ADDI4
ASGNI4
line 141
;141:		if ( i != c - 1 ) {
ADDRLP4 4
INDIRI4
ADDRLP4 1036
INDIRI4
CNSTI4 1
SUBI4
EQI4 $136
line 142
;142:			line[len] = ' ';
ADDRLP4 0
INDIRI4
ADDRGP4 $129
ADDP4
CNSTI1 32
ASGNI1
line 143
;143:			len++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 144
;144:		}
LABELV $136
line 145
;145:	}
LABELV $131
line 133
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $133
ADDRLP4 4
INDIRI4
ADDRLP4 1036
INDIRI4
LTI4 $130
LABELV $132
line 147
;146:
;147:	line[len] = 0;
ADDRLP4 0
INDIRI4
ADDRGP4 $129
ADDP4
CNSTI1 0
ASGNI1
line 149
;148:
;149:	return line;
ADDRGP4 $129
RETP4
LABELV $128
endproc ConcatArgs 1048 12
export SanitizeString
proc SanitizeString 12 4
line 159
;150:}
;151:
;152:/*
;153:==================
;154:SanitizeString
;155:
;156:Remove case and control characters
;157:==================
;158:*/
;159:void SanitizeString( char *in, char *out ) {
ADDRGP4 $140
JUMPV
LABELV $139
line 160
;160:	while ( *in ) {
line 161
;161:		if ( *in == 27 ) {
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 27
NEI4 $142
line 162
;162:			in += 2;		// skip color code
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 163
;163:			continue;
ADDRGP4 $140
JUMPV
LABELV $142
line 165
;164:		}
;165:		if ( *in < 32 ) {
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 32
GEI4 $144
line 166
;166:			in++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 167
;167:			continue;
ADDRGP4 $140
JUMPV
LABELV $144
line 169
;168:		}
;169:		*out++ = tolower( *in++ );
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 4
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 8
ADDRGP4 tolower
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
CVII1 4
ASGNI1
line 170
;170:	}
LABELV $140
line 160
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $139
line 172
;171:
;172:	*out = 0;
ADDRFP4 4
INDIRP4
CNSTI1 0
ASGNI1
line 173
;173:}
LABELV $138
endproc SanitizeString 12 4
export ClientNumberFromString
proc ClientNumberFromString 2072 8
line 183
;174:
;175:/*
;176:==================
;177:ClientNumberFromString
;178:
;179:Returns a player number for either a number or name string
;180:Returns -1 if invalid
;181:==================
;182:*/
;183:int ClientNumberFromString( gentity_t *to, char *s ) {
line 190
;184:	gclient_t	*cl;
;185:	int			idnum;
;186:	char		s2[MAX_STRING_CHARS];
;187:	char		n2[MAX_STRING_CHARS];
;188:
;189:	// numeric values are just slot numbers
;190:	if (s[0] >= '0' && s[0] <= '9') {
ADDRLP4 2056
ADDRFP4 4
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 2056
INDIRI4
CNSTI4 48
LTI4 $147
ADDRLP4 2056
INDIRI4
CNSTI4 57
GTI4 $147
line 191
;191:		idnum = atoi( s );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 2060
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 2060
INDIRI4
ASGNI4
line 192
;192:		if ( idnum < 0 || idnum >= level.maxclients ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $152
ADDRLP4 4
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $149
LABELV $152
line 193
;193:			trap_SendServerCommand( to-g_entities, va("print \"Bad client slot: %i\n\"", idnum));
ADDRGP4 $153
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 2068
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRLP4 2068
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 194
;194:			return -1;
CNSTI4 -1
RETI4
ADDRGP4 $146
JUMPV
LABELV $149
line 197
;195:		}
;196:
;197:		cl = &level.clients[idnum];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 198
;198:		if ( cl->pers.connected != CON_CONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $154
line 199
;199:			trap_SendServerCommand( to-g_entities, va("print \"Client %i is not active\n\"", idnum));
ADDRGP4 $156
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 2068
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRLP4 2068
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 200
;200:			return -1;
CNSTI4 -1
RETI4
ADDRGP4 $146
JUMPV
LABELV $154
line 202
;201:		}
;202:		return idnum;
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $146
JUMPV
LABELV $147
line 206
;203:	}
;204:
;205:	// check for a name match
;206:	SanitizeString( s, s2 );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1032
ARGP4
ADDRGP4 SanitizeString
CALLV
pop
line 207
;207:	for ( idnum=0,cl=level.clients ; idnum < level.maxclients ; idnum++,cl++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
ADDRGP4 level
INDIRP4
ASGNP4
ADDRGP4 $160
JUMPV
LABELV $157
line 208
;208:		if ( cl->pers.connected != CON_CONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $162
line 209
;209:			continue;
ADDRGP4 $158
JUMPV
LABELV $162
line 211
;210:		}
;211:		SanitizeString( cl->pers.netname, n2 );
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 SanitizeString
CALLV
pop
line 212
;212:		if ( !strcmp( n2, s2 ) ) {
ADDRLP4 8
ARGP4
ADDRLP4 1032
ARGP4
ADDRLP4 2060
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 2060
INDIRI4
CNSTI4 0
NEI4 $164
line 213
;213:			return idnum;
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $146
JUMPV
LABELV $164
line 215
;214:		}
;215:	}
LABELV $158
line 207
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 5604
ADDP4
ASGNP4
LABELV $160
ADDRLP4 4
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $157
line 217
;216:
;217:	trap_SendServerCommand( to-g_entities, va("print \"User %s is not on the server\n\"", s));
ADDRGP4 $166
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 2060
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRLP4 2060
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 218
;218:	return -1;
CNSTI4 -1
RETI4
LABELV $146
endproc ClientNumberFromString 2072 8
export Cmd_Give_f
proc Cmd_Give_f 132 12
line 229
;219:}
;220:
;221:/*
;222:==================
;223:Cmd_Give_f
;224:
;225:Give items to a client
;226:==================
;227:*/
;228:void Cmd_Give_f (gentity_t *ent)
;229:{
line 237
;230:	char		*name;
;231:	gitem_t		*it;
;232:	int			i;
;233:	qboolean	give_all;
;234:	gentity_t		*it_ent;
;235:	trace_t		trace;
;236:
;237:	if ( !CheatsOk( ent ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 76
ADDRGP4 CheatsOk
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
NEI4 $168
line 238
;238:		return;
ADDRGP4 $167
JUMPV
LABELV $168
line 241
;239:	}
;240:
;241:	name = ConcatArgs( 1 );
CNSTI4 1
ARGI4
ADDRLP4 80
ADDRGP4 ConcatArgs
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 80
INDIRP4
ASGNP4
line 243
;242:
;243:	if (Q_stricmp(name, "all") == 0)
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $172
ARGP4
ADDRLP4 84
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
NEI4 $170
line 244
;244:		give_all = qtrue;
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRGP4 $171
JUMPV
LABELV $170
line 246
;245:	else
;246:		give_all = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $171
line 248
;247:
;248:	if (give_all || Q_stricmp( name, "health") == 0)
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $176
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $175
ARGP4
ADDRLP4 88
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 0
NEI4 $173
LABELV $176
line 249
;249:	{
line 250
;250:		ent->health = ent->client->ps.stats[STAT_MAX_HEALTH];
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 736
ADDP4
ADDRLP4 92
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
ASGNI4
line 251
;251:		if (!give_all)
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $177
line 252
;252:			return;
ADDRGP4 $167
JUMPV
LABELV $177
line 253
;253:	}
LABELV $173
line 255
;254:
;255:	if (give_all || Q_stricmp(name, "weapons") == 0)
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $182
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $181
ARGP4
ADDRLP4 92
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 0
NEI4 $179
LABELV $182
line 256
;256:	{
line 257
;257:		ent->client->ps.stats[STAT_WEAPONS] = (1 << WP_NUM_WEAPONS) - 1 - 
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 3070
ASGNI4
line 259
;258:			( 1 << WP_GRAPPLING_HOOK ) - ( 1 << WP_NONE );
;259:		if (!give_all)
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $183
line 260
;260:			return;
ADDRGP4 $167
JUMPV
LABELV $183
line 261
;261:	}
LABELV $179
line 263
;262:
;263:	if (give_all || Q_stricmp(name, "ammo") == 0)
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $188
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $187
ARGP4
ADDRLP4 96
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 96
INDIRI4
CNSTI4 0
NEI4 $185
LABELV $188
line 264
;264:	{
line 265
;265:		for ( i = 0 ; i < MAX_WEAPONS ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $189
line 266
;266:			ent->client->ps.ammo[i] = 999;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
CNSTI4 999
ASGNI4
line 267
;267:		}
LABELV $190
line 265
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $189
line 268
;268:		if (!give_all)
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $193
line 269
;269:			return;
ADDRGP4 $167
JUMPV
LABELV $193
line 270
;270:	}
LABELV $185
line 272
;271:
;272:	if (give_all || Q_stricmp(name, "armor") == 0)
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $198
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $197
ARGP4
ADDRLP4 100
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 0
NEI4 $195
LABELV $198
line 273
;273:	{
line 274
;274:		ent->client->ps.stats[STAT_ARMOR] = 200;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 196
ADDP4
CNSTI4 200
ASGNI4
line 276
;275:
;276:		if (!give_all)
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $199
line 277
;277:			return;
ADDRGP4 $167
JUMPV
LABELV $199
line 278
;278:	}
LABELV $195
line 280
;279:
;280:	if (Q_stricmp(name, "excellent") == 0) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $203
ARGP4
ADDRLP4 104
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 104
INDIRI4
CNSTI4 0
NEI4 $201
line 281
;281:		ent->client->ps.persistant[PERS_EXCELLENT_COUNT]++;
ADDRLP4 108
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 288
ADDP4
ASGNP4
ADDRLP4 108
INDIRP4
ADDRLP4 108
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 282
;282:		return;
ADDRGP4 $167
JUMPV
LABELV $201
line 284
;283:	}
;284:	if (Q_stricmp(name, "impressive") == 0) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $206
ARGP4
ADDRLP4 108
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 108
INDIRI4
CNSTI4 0
NEI4 $204
line 285
;285:		ent->client->ps.persistant[PERS_IMPRESSIVE_COUNT]++;
ADDRLP4 112
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 284
ADDP4
ASGNP4
ADDRLP4 112
INDIRP4
ADDRLP4 112
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 286
;286:		return;
ADDRGP4 $167
JUMPV
LABELV $204
line 288
;287:	}
;288:	if (Q_stricmp(name, "gauntletaward") == 0) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $209
ARGP4
ADDRLP4 112
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 112
INDIRI4
CNSTI4 0
NEI4 $207
line 289
;289:		ent->client->ps.persistant[PERS_GAUNTLET_FRAG_COUNT]++;
ADDRLP4 116
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 300
ADDP4
ASGNP4
ADDRLP4 116
INDIRP4
ADDRLP4 116
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 290
;290:		return;
ADDRGP4 $167
JUMPV
LABELV $207
line 292
;291:	}
;292:	if (Q_stricmp(name, "defend") == 0) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $212
ARGP4
ADDRLP4 116
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 116
INDIRI4
CNSTI4 0
NEI4 $210
line 293
;293:		ent->client->ps.persistant[PERS_DEFEND_COUNT]++;
ADDRLP4 120
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 292
ADDP4
ASGNP4
ADDRLP4 120
INDIRP4
ADDRLP4 120
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 294
;294:		return;
ADDRGP4 $167
JUMPV
LABELV $210
line 296
;295:	}
;296:	if (Q_stricmp(name, "assist") == 0) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $215
ARGP4
ADDRLP4 120
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 120
INDIRI4
CNSTI4 0
NEI4 $213
line 297
;297:		ent->client->ps.persistant[PERS_ASSIST_COUNT]++;
ADDRLP4 124
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 296
ADDP4
ASGNP4
ADDRLP4 124
INDIRP4
ADDRLP4 124
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 298
;298:		return;
ADDRGP4 $167
JUMPV
LABELV $213
line 302
;299:	}
;300:
;301:	// spawn a specific item right on the player
;302:	if ( !give_all ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $216
line 303
;303:		it = BG_FindItem (name);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 124
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 124
INDIRP4
ASGNP4
line 304
;304:		if (!it) {
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $218
line 305
;305:			return;
ADDRGP4 $167
JUMPV
LABELV $218
line 308
;306:		}
;307:
;308:		it_ent = G_Spawn();
ADDRLP4 128
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 128
INDIRP4
ASGNP4
line 309
;309:		if (!it_ent) return;	// JUHOX BUGFIX
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $220
ADDRGP4 $167
JUMPV
LABELV $220
line 310
;310:		VectorCopy( ent->r.currentOrigin, it_ent->s.origin );
ADDRLP4 12
INDIRP4
CNSTI4 92
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 311
;311:		it_ent->classname = it->classname;
ADDRLP4 12
INDIRP4
CNSTI4 528
ADDP4
ADDRLP4 16
INDIRP4
INDIRP4
ASGNP4
line 312
;312:		G_SpawnItem (it_ent, it);
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 G_SpawnItem
CALLV
pop
line 313
;313:		FinishSpawningItem(it_ent );
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 FinishSpawningItem
CALLV
pop
line 314
;314:		memset( &trace, 0, sizeof( trace ) );
ADDRLP4 20
ARGP4
CNSTI4 0
ARGI4
CNSTI4 56
ARGI4
ADDRGP4 memset
CALLP4
pop
line 315
;315:		Touch_Item (it_ent, ent, &trace);
ADDRLP4 12
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 Touch_Item
CALLV
pop
line 316
;316:		if (it_ent->inuse) {
ADDRLP4 12
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
EQI4 $222
line 317
;317:			G_FreeEntity( it_ent );
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 318
;318:		}
LABELV $222
line 319
;319:	}
LABELV $216
line 320
;320:}
LABELV $167
endproc Cmd_Give_f 132 12
export Cmd_God_f
proc Cmd_God_f 16 8
line 333
;321:
;322:
;323:/*
;324:==================
;325:Cmd_God_f
;326:
;327:Sets client to godmode
;328:
;329:argv(0) god
;330:==================
;331:*/
;332:void Cmd_God_f (gentity_t *ent)
;333:{
line 336
;334:	char	*msg;
;335:
;336:	if ( !CheatsOk( ent ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 CheatsOk
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $225
line 337
;337:		return;
ADDRGP4 $224
JUMPV
LABELV $225
line 340
;338:	}
;339:
;340:	ent->flags ^= FL_GODMODE;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 540
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 16
BXORI4
ASGNI4
line 341
;341:	if (!(ent->flags & FL_GODMODE) )
ADDRFP4 0
INDIRP4
CNSTI4 540
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $227
line 342
;342:		msg = "godmode OFF\n";
ADDRLP4 0
ADDRGP4 $229
ASGNP4
ADDRGP4 $228
JUMPV
LABELV $227
line 344
;343:	else
;344:		msg = "godmode ON\n";
ADDRLP4 0
ADDRGP4 $230
ASGNP4
LABELV $228
line 346
;345:
;346:	trap_SendServerCommand( ent-g_entities, va("print \"%s\"", msg));
ADDRGP4 $231
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 347
;347:}
LABELV $224
endproc Cmd_God_f 16 8
export Cmd_Notarget_f
proc Cmd_Notarget_f 16 8
line 359
;348:
;349:
;350:/*
;351:==================
;352:Cmd_Notarget_f
;353:
;354:Sets client to notarget
;355:
;356:argv(0) notarget
;357:==================
;358:*/
;359:void Cmd_Notarget_f( gentity_t *ent ) {
line 362
;360:	char	*msg;
;361:
;362:	if ( !CheatsOk( ent ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 CheatsOk
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $233
line 363
;363:		return;
ADDRGP4 $232
JUMPV
LABELV $233
line 366
;364:	}
;365:
;366:	ent->flags ^= FL_NOTARGET;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 540
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 32
BXORI4
ASGNI4
line 367
;367:	if (!(ent->flags & FL_NOTARGET) )
ADDRFP4 0
INDIRP4
CNSTI4 540
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
NEI4 $235
line 368
;368:		msg = "notarget OFF\n";
ADDRLP4 0
ADDRGP4 $237
ASGNP4
ADDRGP4 $236
JUMPV
LABELV $235
line 370
;369:	else
;370:		msg = "notarget ON\n";
ADDRLP4 0
ADDRGP4 $238
ASGNP4
LABELV $236
line 372
;371:
;372:	trap_SendServerCommand( ent-g_entities, va("print \"%s\"", msg));
ADDRGP4 $231
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 373
;373:}
LABELV $232
endproc Cmd_Notarget_f 16 8
export Cmd_Noclip_f
proc Cmd_Noclip_f 20 8
line 383
;374:
;375:
;376:/*
;377:==================
;378:Cmd_Noclip_f
;379:
;380:argv(0) noclip
;381:==================
;382:*/
;383:void Cmd_Noclip_f( gentity_t *ent ) {
line 386
;384:	char	*msg;
;385:
;386:	if ( !CheatsOk( ent ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 CheatsOk
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $240
line 387
;387:		return;
ADDRGP4 $239
JUMPV
LABELV $240
line 390
;388:	}
;389:
;390:	if ( ent->client->noclip ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 728
ADDP4
INDIRI4
CNSTI4 0
EQI4 $242
line 391
;391:		msg = "noclip OFF\n";
ADDRLP4 0
ADDRGP4 $244
ASGNP4
line 392
;392:	} else {
ADDRGP4 $243
JUMPV
LABELV $242
line 393
;393:		msg = "noclip ON\n";
ADDRLP4 0
ADDRGP4 $245
ASGNP4
line 394
;394:	}
LABELV $243
line 395
;395:	ent->client->noclip = !ent->client->noclip;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 728
ADDP4
INDIRI4
CNSTI4 0
NEI4 $247
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRGP4 $248
JUMPV
LABELV $247
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $248
ADDRLP4 12
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 728
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 397
;396:
;397:	trap_SendServerCommand( ent-g_entities, va("print \"%s\"", msg));
ADDRGP4 $231
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 398
;398:}
LABELV $239
endproc Cmd_Noclip_f 20 8
export Cmd_LevelShot_f
proc Cmd_LevelShot_f 4 8
line 411
;399:
;400:
;401:/*
;402:==================
;403:Cmd_LevelShot_f
;404:
;405:This is just to help generate the level pictures
;406:for the menus.  It goes to the intermission immediately
;407:and sends over a command to the client to resize the view,
;408:hide the scoreboard, and take a special screenshot
;409:==================
;410:*/
;411:void Cmd_LevelShot_f( gentity_t *ent ) {
line 412
;412:	if ( !CheatsOk( ent ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 CheatsOk
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $250
line 413
;413:		return;
ADDRGP4 $249
JUMPV
LABELV $250
line 417
;414:	}
;415:
;416:	// doesn't work in single player
;417:	if ( g_gametype.integer != 0 ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 0
EQI4 $252
line 418
;418:		trap_SendServerCommand( ent-g_entities, 
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRGP4 $255
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 420
;419:			"print \"Must be in g_gametype 0 for levelshot\n\"" );
;420:		return;
ADDRGP4 $249
JUMPV
LABELV $252
line 423
;421:	}
;422:
;423:	BeginIntermission();
ADDRGP4 BeginIntermission
CALLV
pop
line 424
;424:	trap_SendServerCommand( ent-g_entities, "clientLevelShot" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRGP4 $256
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 425
;425:}
LABELV $249
endproc Cmd_LevelShot_f 4 8
export Cmd_TeamTask_f
proc Cmd_TeamTask_f 2068 12
line 438
;426:
;427:
;428:/*
;429:==================
;430:Cmd_LevelShot_f
;431:
;432:This is just to help generate the level pictures
;433:for the menus.  It goes to the intermission immediately
;434:and sends over a command to the client to resize the view,
;435:hide the scoreboard, and take a special screenshot
;436:==================
;437:*/
;438:void Cmd_TeamTask_f( gentity_t *ent ) {
line 442
;439:	char userinfo[MAX_INFO_STRING];
;440:	char		arg[MAX_TOKEN_CHARS];
;441:	int task;
;442:	int client = ent->client - level.clients;
ADDRLP4 1024
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 level
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 5604
DIVI4
ASGNI4
line 444
;443:
;444:	if ( trap_Argc() != 2 ) {
ADDRLP4 2056
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 2056
INDIRI4
CNSTI4 2
EQI4 $258
line 445
;445:		return;
ADDRGP4 $257
JUMPV
LABELV $258
line 447
;446:	}
;447:	trap_Argv( 1, arg, sizeof( arg ) );
CNSTI4 1
ARGI4
ADDRLP4 1028
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 448
;448:	task = atoi( arg );
ADDRLP4 1028
ARGP4
ADDRLP4 2060
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 2052
ADDRLP4 2060
INDIRI4
ASGNI4
line 450
;449:
;450:	trap_GetUserinfo(client, userinfo, sizeof(userinfo));
ADDRLP4 1024
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 451
;451:	Info_SetValueForKey(userinfo, "teamtask", va("%d", task));
ADDRGP4 $261
ARGP4
ADDRLP4 2052
INDIRI4
ARGI4
ADDRLP4 2064
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
ADDRGP4 $260
ARGP4
ADDRLP4 2064
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 452
;452:	trap_SetUserinfo(client, userinfo);
ADDRLP4 1024
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_SetUserinfo
CALLV
pop
line 453
;453:	ClientUserinfoChanged(client);
ADDRLP4 1024
INDIRI4
ARGI4
ADDRGP4 ClientUserinfoChanged
CALLV
pop
line 454
;454:}
LABELV $257
endproc Cmd_TeamTask_f 2068 12
export Cmd_Kill_f
proc Cmd_Kill_f 16 20
line 463
;455:
;456:
;457:
;458:/*
;459:=================
;460:Cmd_Kill_f
;461:=================
;462:*/
;463:void Cmd_Kill_f( gentity_t *ent ) {
line 464
;464:	if ( ent->client->sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 3
NEI4 $263
line 465
;465:		return;
ADDRGP4 $262
JUMPV
LABELV $263
line 467
;466:	}
;467:	if (ent->health <= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
GTI4 $265
line 468
;468:		return;
ADDRGP4 $262
JUMPV
LABELV $265
line 470
;469:	}
;470:	ent->flags &= ~FL_GODMODE;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 540
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 -17
BANDI4
ASGNI4
line 471
;471:	ent->client->ps.stats[STAT_HEALTH] = ent->health = -999;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
CNSTI4 -999
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 736
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 472
;472:	player_die (ent, ent, ent, 100000, MOD_SUICIDE);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
CNSTI4 100000
ARGI4
CNSTI4 25
ARGI4
ADDRGP4 player_die
CALLV
pop
line 473
;473:}
LABELV $262
endproc Cmd_Kill_f 16 20
export BroadcastTeamChange
proc BroadcastTeamChange 4 8
line 483
;474:
;475:/*
;476:=================
;477:BroadCastTeamChange
;478:
;479:Let everyone know about a team change
;480:=================
;481:*/
;482:void BroadcastTeamChange( gclient_t *client, int oldTeam )
;483:{
line 485
;484:#if MONSTER_MODE	// JUHOX: in STU there's only one team
;485:	if (g_gametype.integer >= GT_STU) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
LTI4 $268
line 486
;486:		trap_SendServerCommand(-1, va("cp \"%s" S_COLOR_WHITE " joined the battle.\n\"", client->pers.netname));
ADDRGP4 $271
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 487
;487:	}
ADDRGP4 $269
JUMPV
LABELV $268
line 490
;488:	else
;489:#endif
;490:	if ( client->sess.sessionTeam == TEAM_RED ) {
ADDRFP4 0
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 1
NEI4 $272
line 491
;491:		trap_SendServerCommand( -1, va("cp \"%s" S_COLOR_WHITE " joined the red team.\n\"",
ADDRGP4 $274
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 493
;492:			client->pers.netname) );
;493:	} else if ( client->sess.sessionTeam == TEAM_BLUE ) {
ADDRGP4 $273
JUMPV
LABELV $272
ADDRFP4 0
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 2
NEI4 $275
line 494
;494:		trap_SendServerCommand( -1, va("cp \"%s" S_COLOR_WHITE " joined the blue team.\n\"",
ADDRGP4 $277
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 496
;495:		client->pers.netname));
;496:	} else if ( client->sess.sessionTeam == TEAM_SPECTATOR && oldTeam != TEAM_SPECTATOR ) {
ADDRGP4 $276
JUMPV
LABELV $275
ADDRFP4 0
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 3
NEI4 $278
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $278
line 497
;497:		trap_SendServerCommand( -1, va("cp \"%s" S_COLOR_WHITE " joined the spectators.\n\"",
ADDRGP4 $280
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 499
;498:		client->pers.netname));
;499:	} else if ( client->sess.sessionTeam == TEAM_FREE ) {
ADDRGP4 $279
JUMPV
LABELV $278
ADDRFP4 0
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 0
NEI4 $281
line 500
;500:		trap_SendServerCommand( -1, va("cp \"%s" S_COLOR_WHITE " joined the battle.\n\"",
ADDRGP4 $271
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 502
;501:		client->pers.netname));
;502:	}
LABELV $281
LABELV $279
LABELV $276
LABELV $273
LABELV $269
line 503
;503:}
LABELV $267
endproc BroadcastTeamChange 4 8
export SetTeam
proc SetTeam 92 20
line 510
;504:
;505:/*
;506:=================
;507:SetTeam
;508:=================
;509:*/
;510:void SetTeam( gentity_t *ent, char *s ) {
line 521
;511:	int					team, oldTeam;
;512:	gclient_t			*client;
;513:	int					clientNum;
;514:	spectatorState_t	specState;
;515:	int					specClient;
;516:	int					teamLeader;
;517:
;518:	//
;519:	// see what change is requested
;520:	//
;521:	client = ent->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 523
;522:
;523:	clientNum = client - level.clients;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRGP4 level
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 5604
DIVI4
ASGNI4
line 524
;524:	specClient = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 525
;525:	specState = SPECTATOR_NOT;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 526
;526:	if ( !Q_stricmp( s, "scoreboard" ) || !Q_stricmp( s, "score" )  ) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $286
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $288
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $287
ARGP4
ADDRLP4 32
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $284
LABELV $288
line 527
;527:		team = TEAM_SPECTATOR;
ADDRLP4 4
CNSTI4 3
ASGNI4
line 528
;528:		specState = SPECTATOR_SCOREBOARD;
ADDRLP4 16
CNSTI4 3
ASGNI4
line 529
;529:	} else if ( !Q_stricmp( s, "follow1" ) ) {
ADDRGP4 $285
JUMPV
LABELV $284
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $291
ARGP4
ADDRLP4 36
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $289
line 530
;530:		team = TEAM_SPECTATOR;
ADDRLP4 4
CNSTI4 3
ASGNI4
line 531
;531:		specState = SPECTATOR_FOLLOW;
ADDRLP4 16
CNSTI4 2
ASGNI4
line 532
;532:		specClient = -1;
ADDRLP4 20
CNSTI4 -1
ASGNI4
line 533
;533:	} else if ( !Q_stricmp( s, "follow2" ) ) {
ADDRGP4 $290
JUMPV
LABELV $289
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $294
ARGP4
ADDRLP4 40
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $292
line 534
;534:		team = TEAM_SPECTATOR;
ADDRLP4 4
CNSTI4 3
ASGNI4
line 535
;535:		specState = SPECTATOR_FOLLOW;
ADDRLP4 16
CNSTI4 2
ASGNI4
line 536
;536:		specClient = -2;
ADDRLP4 20
CNSTI4 -2
ASGNI4
line 537
;537:	} else if ( !Q_stricmp( s, "spectator" ) || !Q_stricmp( s, "s" ) ) {
ADDRGP4 $293
JUMPV
LABELV $292
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $297
ARGP4
ADDRLP4 44
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $299
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $298
ARGP4
ADDRLP4 48
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
NEI4 $295
LABELV $299
line 538
;538:		team = TEAM_SPECTATOR;
ADDRLP4 4
CNSTI4 3
ASGNI4
line 539
;539:		specState = SPECTATOR_FREE;
ADDRLP4 16
CNSTI4 1
ASGNI4
line 541
;540:#if MONSTER_MODE	// JUHOX: don't allow other teams than red in STU
;541:	} else if (g_gametype.integer >= GT_STU) {
ADDRGP4 $296
JUMPV
LABELV $295
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
LTI4 $300
line 542
;542:		specState = SPECTATOR_NOT;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 543
;543:		team = TEAM_RED;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 545
;544:#endif
;545:	} else if ( g_gametype.integer >= GT_TEAM ) {
ADDRGP4 $301
JUMPV
LABELV $300
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $303
line 547
;546:		// if running a team game, assign player to one of the teams
;547:		specState = SPECTATOR_NOT;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 548
;548:		if ( !Q_stricmp( s, "red" ) || !Q_stricmp( s, "r" ) ) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $308
ARGP4
ADDRLP4 52
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $310
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $309
ARGP4
ADDRLP4 56
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
NEI4 $306
LABELV $310
line 549
;549:			team = TEAM_RED;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 550
;550:		} else if ( !Q_stricmp( s, "blue" ) || !Q_stricmp( s, "b" ) ) {
ADDRGP4 $307
JUMPV
LABELV $306
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $313
ARGP4
ADDRLP4 60
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $315
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $314
ARGP4
ADDRLP4 64
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
NEI4 $311
LABELV $315
line 551
;551:			team = TEAM_BLUE;
ADDRLP4 4
CNSTI4 2
ASGNI4
line 552
;552:		} else {
ADDRGP4 $312
JUMPV
LABELV $311
line 554
;553:			// pick the team with the least number of players
;554:			team = PickTeam( clientNum );
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 68
ADDRGP4 PickTeam
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 68
INDIRI4
ASGNI4
line 555
;555:		}
LABELV $312
LABELV $307
line 557
;556:
;557:		if ( g_teamForceBalance.integer  ) {
ADDRGP4 g_teamForceBalance+12
INDIRI4
CNSTI4 0
EQI4 $304
line 560
;558:			int		counts[TEAM_NUM_TEAMS];
;559:
;560:			counts[TEAM_BLUE] = TeamCount( ent->client->ps.clientNum, TEAM_BLUE );
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 84
ADDRGP4 TeamCount
CALLI4
ASGNI4
ADDRLP4 68+8
ADDRLP4 84
INDIRI4
ASGNI4
line 561
;561:			counts[TEAM_RED] = TeamCount( ent->client->ps.clientNum, TEAM_RED );
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 88
ADDRGP4 TeamCount
CALLI4
ASGNI4
ADDRLP4 68+4
ADDRLP4 88
INDIRI4
ASGNI4
line 564
;562:
;563:			// We allow a spread of two
;564:			if ( team == TEAM_RED && counts[TEAM_RED] - counts[TEAM_BLUE] > 1 ) {
ADDRLP4 4
INDIRI4
CNSTI4 1
NEI4 $321
ADDRLP4 68+4
INDIRI4
ADDRLP4 68+8
INDIRI4
SUBI4
CNSTI4 1
LEI4 $321
line 565
;565:				trap_SendServerCommand( ent->client->ps.clientNum, 
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRGP4 $325
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 567
;566:					"cp \"Red team has too many players.\n\"" );
;567:				return; // ignore the request
ADDRGP4 $283
JUMPV
LABELV $321
line 569
;568:			}
;569:			if ( team == TEAM_BLUE && counts[TEAM_BLUE] - counts[TEAM_RED] > 1 ) {
ADDRLP4 4
INDIRI4
CNSTI4 2
NEI4 $304
ADDRLP4 68+8
INDIRI4
ADDRLP4 68+4
INDIRI4
SUBI4
CNSTI4 1
LEI4 $304
line 570
;570:				trap_SendServerCommand( ent->client->ps.clientNum, 
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRGP4 $330
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 572
;571:					"cp \"Blue team has too many players.\n\"" );
;572:				return; // ignore the request
ADDRGP4 $283
JUMPV
line 576
;573:			}
;574:
;575:			// It's ok, the team we are switching to has less or same number of players
;576:		}
line 578
;577:
;578:	} else {
LABELV $303
line 580
;579:		// force them to spectators if there aren't any spots free
;580:		team = TEAM_FREE;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 581
;581:	}
LABELV $304
LABELV $301
LABELV $296
LABELV $293
LABELV $290
LABELV $285
line 584
;582:
;583:	// override decision if limiting the players
;584:	if ( (g_gametype.integer == GT_TOURNAMENT)
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
NEI4 $331
ADDRGP4 level+92
INDIRI4
CNSTI4 2
LTI4 $331
line 585
;585:		&& level.numNonSpectatorClients >= 2 ) {
line 586
;586:		team = TEAM_SPECTATOR;
ADDRLP4 4
CNSTI4 3
ASGNI4
line 587
;587:	} else if ( g_maxGameClients.integer > 0 && 
ADDRGP4 $332
JUMPV
LABELV $331
ADDRGP4 g_maxGameClients+12
INDIRI4
CNSTI4 0
LEI4 $335
ADDRGP4 level+92
INDIRI4
ADDRGP4 g_maxGameClients+12
INDIRI4
LTI4 $335
line 588
;588:		level.numNonSpectatorClients >= g_maxGameClients.integer ) {
line 589
;589:		team = TEAM_SPECTATOR;
ADDRLP4 4
CNSTI4 3
ASGNI4
line 590
;590:	}
LABELV $335
LABELV $332
line 595
;591:
;592:	//
;593:	// decide if we will allow the change
;594:	//
;595:	oldTeam = client->sess.sessionTeam;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
ASGNI4
line 596
;596:	if ( team == oldTeam && team != TEAM_SPECTATOR ) {
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $340
ADDRLP4 4
INDIRI4
CNSTI4 3
EQI4 $340
line 597
;597:		return;
ADDRGP4 $283
JUMPV
LABELV $340
line 605
;598:	}
;599:
;600:	//
;601:	// execute the team change
;602:	//
;603:
;604:	// if the player was dead leave the body
;605:	if ( client->ps.stats[STAT_HEALTH] <= 0 ) {
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $342
line 606
;606:		CopyToBodyQue(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CopyToBodyQue
CALLV
pop
line 607
;607:	}
LABELV $342
line 610
;608:
;609:	// he starts at 'base'
;610:	client->pers.teamState.state = TEAM_BEGIN;
ADDRLP4 0
INDIRP4
CNSTI4 556
ADDP4
CNSTI4 0
ASGNI4
line 611
;611:	if ( oldTeam != TEAM_SPECTATOR ) {
ADDRLP4 8
INDIRI4
CNSTI4 3
EQI4 $344
line 613
;612:		// Kill him (makes sure he loses flags, etc)
;613:		ent->flags &= ~FL_GODMODE;
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 540
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 -17
BANDI4
ASGNI4
line 614
;614:		ent->client->ps.stats[STAT_HEALTH] = ent->health = 0;
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
CNSTI4 0
ASGNI4
ADDRLP4 60
INDIRP4
CNSTI4 736
ADDP4
ADDRLP4 64
INDIRI4
ASGNI4
ADDRLP4 60
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 64
INDIRI4
ASGNI4
line 615
;615:		player_die (ent, ent, ent, 100000, MOD_SUICIDE);
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
CNSTI4 100000
ARGI4
CNSTI4 25
ARGI4
ADDRGP4 player_die
CALLV
pop
line 617
;616:
;617:	}
LABELV $344
line 619
;618:	// they go to the end of the line for tournements
;619:	if ( team == TEAM_SPECTATOR ) {
ADDRLP4 4
INDIRI4
CNSTI4 3
NEI4 $346
line 620
;620:		client->sess.spectatorTime = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 700
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 621
;621:	}
LABELV $346
line 623
;622:
;623:	client->sess.sessionTeam = team;
ADDRLP4 0
INDIRP4
CNSTI4 696
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 624
;624:	client->sess.spectatorState = specState;
ADDRLP4 0
INDIRP4
CNSTI4 704
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 625
;625:	client->sess.spectatorClient = specClient;
ADDRLP4 0
INDIRP4
CNSTI4 708
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
line 627
;626:
;627:	client->sess.teamLeader = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 720
ADDP4
CNSTI4 0
ASGNI4
line 628
;628:	if ( team == TEAM_RED || team == TEAM_BLUE ) {
ADDRLP4 4
INDIRI4
CNSTI4 1
EQI4 $351
ADDRLP4 4
INDIRI4
CNSTI4 2
NEI4 $349
LABELV $351
line 629
;629:		teamLeader = TeamLeader( team );
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 TeamLeader
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 60
INDIRI4
ASGNI4
line 631
;630:		// if there is no team leader or the team leader is a bot and this client is not a bot
;631:		if ( teamLeader == -1 || ( !(g_entities[clientNum].r.svFlags & SVF_BOT) && (g_entities[teamLeader].r.svFlags & SVF_BOT) ) ) {
ADDRLP4 64
ADDRLP4 24
INDIRI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 -1
EQI4 $358
ADDRLP4 12
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+208+216
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $352
ADDRLP4 64
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+208+216
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $352
LABELV $358
line 632
;632:			SetLeader( team, clientNum );
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 SetLeader
CALLV
pop
line 633
;633:		}
LABELV $352
line 634
;634:	}
LABELV $349
line 636
;635:	// make sure there is a team leader on the team the player came from
;636:	if ( oldTeam == TEAM_RED || oldTeam == TEAM_BLUE ) {
ADDRLP4 8
INDIRI4
CNSTI4 1
EQI4 $361
ADDRLP4 8
INDIRI4
CNSTI4 2
NEI4 $359
LABELV $361
line 637
;637:		CheckTeamLeader( oldTeam );
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 CheckTeamLeader
CALLV
pop
line 638
;638:	}
LABELV $359
line 640
;639:
;640:	BroadcastTeamChange( client, oldTeam );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 BroadcastTeamChange
CALLV
pop
line 643
;641:
;642:	// get and distribute relevent paramters
;643:	ClientUserinfoChanged( clientNum );
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 ClientUserinfoChanged
CALLV
pop
line 645
;644:
;645:	ClientBegin( clientNum );
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 ClientBegin
CALLV
pop
line 646
;646:}
LABELV $283
endproc SetTeam 92 20
export StopFollowing
proc StopFollowing 12 0
line 656
;647:
;648:/*
;649:=================
;650:StopFollowing
;651:
;652:If the client being followed leaves the game, or you just want to drop
;653:to free floating spectator mode
;654:=================
;655:*/
;656:void StopFollowing( gentity_t *ent ) {
line 657
;657:	ent->client->ps.persistant[ PERS_TEAM ] = TEAM_SPECTATOR;	
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 260
ADDP4
CNSTI4 3
ASGNI4
line 658
;658:	ent->client->sess.sessionTeam = TEAM_SPECTATOR;	
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
CNSTI4 3
ASGNI4
line 659
;659:	ent->client->sess.spectatorState = SPECTATOR_FREE;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 704
ADDP4
CNSTI4 1
ASGNI4
line 660
;660:	ent->client->ps.pm_flags &= ~PMF_FOLLOW;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 -4097
BANDI4
ASGNI4
line 661
;661:	ent->r.svFlags &= ~SVF_BOT;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -9
BANDI4
ASGNI4
line 662
;662:	ent->client->ps.clientNum = ent - g_entities;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 140
ADDP4
ADDRLP4 8
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ASGNI4
line 663
;663:}
LABELV $362
endproc StopFollowing 12 0
export Cmd_Team_f
proc Cmd_Team_f 1036 12
line 670
;664:
;665:/*
;666:=================
;667:Cmd_Team_f
;668:=================
;669:*/
;670:void Cmd_Team_f( gentity_t *ent ) {
line 674
;671:	int			oldTeam;
;672:	char		s[MAX_TOKEN_CHARS];
;673:
;674:	if ( trap_Argc() != 2 ) {
ADDRLP4 1028
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 2
EQI4 $364
line 675
;675:		oldTeam = ent->client->sess.sessionTeam;
ADDRLP4 1024
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
ASGNI4
line 676
;676:		switch ( oldTeam ) {
ADDRLP4 1032
ADDRLP4 1024
INDIRI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 0
LTI4 $363
ADDRLP4 1032
INDIRI4
CNSTI4 3
GTI4 $363
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $376
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $376
address $372
address $370
address $368
address $374
code
LABELV $368
line 678
;677:		case TEAM_BLUE:
;678:			trap_SendServerCommand( ent-g_entities, "print \"Blue team\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRGP4 $369
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 679
;679:			break;
ADDRGP4 $363
JUMPV
LABELV $370
line 681
;680:		case TEAM_RED:
;681:			trap_SendServerCommand( ent-g_entities, "print \"Red team\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRGP4 $371
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 682
;682:			break;
ADDRGP4 $363
JUMPV
LABELV $372
line 684
;683:		case TEAM_FREE:
;684:			trap_SendServerCommand( ent-g_entities, "print \"Free team\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRGP4 $373
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 685
;685:			break;
ADDRGP4 $363
JUMPV
LABELV $374
line 687
;686:		case TEAM_SPECTATOR:
;687:			trap_SendServerCommand( ent-g_entities, "print \"Spectator team\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRGP4 $375
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 688
;688:			break;
line 690
;689:		}
;690:		return;
ADDRGP4 $363
JUMPV
LABELV $364
line 693
;691:	}
;692:
;693:	if ( ent->client->switchTeamTime > level.time ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $377
line 694
;694:		trap_SendServerCommand( ent-g_entities, "print \"May not switch teams more than once per 5 seconds.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRGP4 $380
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 695
;695:		return;
ADDRGP4 $363
JUMPV
LABELV $377
line 699
;696:	}
;697:
;698:	// if they are playing a tournement game, count as a loss
;699:	if ( (g_gametype.integer == GT_TOURNAMENT )
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
NEI4 $381
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 0
NEI4 $381
line 700
;700:		&& ent->client->sess.sessionTeam == TEAM_FREE ) {
line 701
;701:		ent->client->sess.losses++;
ADDRLP4 1032
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 716
ADDP4
ASGNP4
ADDRLP4 1032
INDIRP4
ADDRLP4 1032
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 702
;702:	}
LABELV $381
line 704
;703:
;704:	trap_Argv( 1, s, sizeof( s ) );
CNSTI4 1
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 706
;705:
;706:	SetTeam( ent, s );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 SetTeam
CALLV
pop
line 708
;707:
;708:	ent->client->switchTeamTime = level.time + 5000;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 888
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 5000
ADDI4
ASGNI4
line 709
;709:}
LABELV $363
endproc Cmd_Team_f 1036 12
export Cmd_Follow_f
proc Cmd_Follow_f 1040 12
line 717
;710:
;711:
;712:/*
;713:=================
;714:Cmd_Follow_f
;715:=================
;716:*/
;717:void Cmd_Follow_f( gentity_t *ent ) {
line 721
;718:	int		i;
;719:	char	arg[MAX_TOKEN_CHARS];
;720:
;721:	if ( trap_Argc() != 2 ) {
ADDRLP4 1028
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 2
EQI4 $386
line 722
;722:		if ( ent->client->sess.spectatorState == SPECTATOR_FOLLOW ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 704
ADDP4
INDIRI4
CNSTI4 2
NEI4 $385
line 723
;723:			StopFollowing( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 StopFollowing
CALLV
pop
line 724
;724:		}
line 725
;725:		return;
ADDRGP4 $385
JUMPV
LABELV $386
line 728
;726:	}
;727:
;728:	trap_Argv( 1, arg, sizeof( arg ) );
CNSTI4 1
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 729
;729:	i = ClientNumberFromString( ent, arg );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 1032
ADDRGP4 ClientNumberFromString
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 1032
INDIRI4
ASGNI4
line 730
;730:	if ( i == -1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $390
line 731
;731:		return;
ADDRGP4 $385
JUMPV
LABELV $390
line 735
;732:	}
;733:
;734:	// can't follow self
;735:	if ( &level.clients[ i ] == ent->client ) {
ADDRLP4 0
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CVPU4 4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
NEU4 $392
line 736
;736:		return;
ADDRGP4 $385
JUMPV
LABELV $392
line 740
;737:	}
;738:
;739:	// can't follow another spectator
;740:	if ( level.clients[ i ].sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRLP4 0
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 3
NEI4 $394
line 741
;741:		return;
ADDRGP4 $385
JUMPV
LABELV $394
line 745
;742:	}
;743:
;744:	// if they are playing a tournement game, count as a loss
;745:	if ( (g_gametype.integer == GT_TOURNAMENT )
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
NEI4 $396
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 0
NEI4 $396
line 746
;746:		&& ent->client->sess.sessionTeam == TEAM_FREE ) {
line 747
;747:		ent->client->sess.losses++;
ADDRLP4 1036
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 716
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
line 748
;748:	}
LABELV $396
line 751
;749:
;750:	// first set them to spectator
;751:	if ( ent->client->sess.sessionTeam != TEAM_SPECTATOR ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 3
EQI4 $399
line 752
;752:		SetTeam( ent, "spectator" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $297
ARGP4
ADDRGP4 SetTeam
CALLV
pop
line 753
;753:	}
LABELV $399
line 755
;754:
;755:	ent->client->sess.spectatorState = SPECTATOR_FOLLOW;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 704
ADDP4
CNSTI4 2
ASGNI4
line 756
;756:	ent->client->sess.spectatorClient = i;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 708
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 757
;757:}
LABELV $385
endproc Cmd_Follow_f 1040 12
export Cmd_FollowCycle_f
proc Cmd_FollowCycle_f 12 8
line 764
;758:
;759:/*
;760:=================
;761:Cmd_FollowCycle_f
;762:=================
;763:*/
;764:void Cmd_FollowCycle_f( gentity_t *ent, int dir ) {
line 769
;765:	int		clientnum;
;766:	int		original;
;767:
;768:	// if they are playing a tournement game, count as a loss
;769:	if ( (g_gametype.integer == GT_TOURNAMENT )
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
NEI4 $402
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 0
NEI4 $402
line 770
;770:		&& ent->client->sess.sessionTeam == TEAM_FREE ) {
line 771
;771:		ent->client->sess.losses++;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 716
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 772
;772:	}
LABELV $402
line 774
;773:	// first set them to spectator
;774:	if ( ent->client->sess.spectatorState == SPECTATOR_NOT ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 704
ADDP4
INDIRI4
CNSTI4 0
NEI4 $405
line 775
;775:		SetTeam( ent, "spectator" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $297
ARGP4
ADDRGP4 SetTeam
CALLV
pop
line 776
;776:	}
LABELV $405
line 778
;777:
;778:	if ( dir != 1 && dir != -1 ) {
ADDRLP4 8
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 1
EQI4 $407
ADDRLP4 8
INDIRI4
CNSTI4 -1
EQI4 $407
line 779
;779:		G_Error( "Cmd_FollowCycle_f: bad dir %i", dir );
ADDRGP4 $409
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 G_Error
CALLV
pop
line 780
;780:	}
LABELV $407
line 782
;781:
;782:	clientnum = ent->client->sess.spectatorClient;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 708
ADDP4
INDIRI4
ASGNI4
line 783
;783:	original = clientnum;
ADDRLP4 4
ADDRLP4 0
INDIRI4
ASGNI4
LABELV $410
line 784
;784:	do {
line 785
;785:		clientnum += dir;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRI4
ADDI4
ASGNI4
line 786
;786:		if ( clientnum >= level.maxclients ) {
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $413
line 787
;787:			clientnum = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 788
;788:		}
LABELV $413
line 789
;789:		if ( clientnum < 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $416
line 790
;790:			clientnum = level.maxclients - 1;
ADDRLP4 0
ADDRGP4 level+24
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 791
;791:		}
LABELV $416
line 794
;792:
;793:		// can only follow connected clients
;794:		if ( level.clients[ clientnum ].pers.connected != CON_CONNECTED ) {
ADDRLP4 0
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $419
line 795
;795:			continue;
ADDRGP4 $411
JUMPV
LABELV $419
line 799
;796:		}
;797:
;798:		// can't follow another spectator
;799:		if ( level.clients[ clientnum ].sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRLP4 0
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 3
NEI4 $421
line 800
;800:			continue;
ADDRGP4 $411
JUMPV
LABELV $421
line 804
;801:		}
;802:
;803:		// this is good, we can use it
;804:		ent->client->sess.spectatorClient = clientnum;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 708
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 805
;805:		ent->client->sess.spectatorState = SPECTATOR_FOLLOW;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 704
ADDP4
CNSTI4 2
ASGNI4
line 806
;806:		return;
ADDRGP4 $401
JUMPV
LABELV $411
line 807
;807:	} while ( clientnum != original );
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $410
line 810
;808:
;809:	// leave it where it was
;810:}
LABELV $401
endproc Cmd_FollowCycle_f 12 8
proc G_SayTo 12 24
line 819
;811:
;812:
;813:/*
;814:==================
;815:G_Say
;816:==================
;817:*/
;818:
;819:static void G_SayTo( gentity_t *ent, gentity_t *other, int mode, int color, const char *name, const char *message ) {
line 820
;820:	if (!other) {
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $424
line 821
;821:		return;
ADDRGP4 $423
JUMPV
LABELV $424
line 823
;822:	}
;823:	if (!other->inuse) {
ADDRFP4 4
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $426
line 824
;824:		return;
ADDRGP4 $423
JUMPV
LABELV $426
line 826
;825:	}
;826:	if (!other->client) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $428
line 827
;827:		return;
ADDRGP4 $423
JUMPV
LABELV $428
line 829
;828:	}
;829:	if ( other->client->pers.connected != CON_CONNECTED ) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $430
line 830
;830:		return;
ADDRGP4 $423
JUMPV
LABELV $430
line 832
;831:	}
;832:	if ( mode == SAY_TEAM  && !OnSameTeam(ent, other) ) {
ADDRFP4 8
INDIRI4
CNSTI4 1
NEI4 $432
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $432
line 833
;833:		return;
ADDRGP4 $423
JUMPV
LABELV $432
line 836
;834:	}
;835:	// no chatting to players in tournements
;836:	if ( (g_gametype.integer == GT_TOURNAMENT )
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
NEI4 $434
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 0
NEI4 $434
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 0
EQI4 $434
line 838
;837:		&& other->client->sess.sessionTeam == TEAM_FREE
;838:		&& ent->client->sess.sessionTeam != TEAM_FREE ) {
line 839
;839:		return;
ADDRGP4 $423
JUMPV
LABELV $434
line 842
;840:	}
;841:
;842:	trap_SendServerCommand( other-g_entities, va("%s \"%s%c%c%s\"", 
ADDRGP4 $437
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 1
NEI4 $441
ADDRLP4 4
ADDRGP4 $438
ASGNP4
ADDRGP4 $442
JUMPV
LABELV $441
ADDRLP4 4
ADDRGP4 $439
ASGNP4
LABELV $442
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
CNSTI4 94
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 20
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 845
;843:		mode == SAY_TEAM ? "tchat" : "chat",
;844:		name, Q_COLOR_ESCAPE, color, message));
;845:}
LABELV $423
endproc G_SayTo 12 24
export G_Say
proc G_Say 312 28
line 849
;846:
;847:#define EC		"\x19"
;848:
;849:void G_Say( gentity_t *ent, gentity_t *target, int mode, const char *chatText ) {
line 858
;850:	int			j;
;851:	gentity_t	*other;
;852:	int			color;
;853:	char		name[64];
;854:	// don't let text be too long for malicious reasons
;855:	char		text[MAX_SAY_TEXT];
;856:	char		location[64];
;857:
;858:	if ( g_gametype.integer < GT_TEAM && mode == SAY_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
GEI4 $444
ADDRFP4 8
INDIRI4
CNSTI4 1
NEI4 $444
line 859
;859:		mode = SAY_ALL;
ADDRFP4 8
CNSTI4 0
ASGNI4
line 860
;860:	}
LABELV $444
line 862
;861:
;862:	switch ( mode ) {
ADDRLP4 292
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 292
INDIRI4
CNSTI4 0
EQI4 $449
ADDRLP4 292
INDIRI4
CNSTI4 1
EQI4 $452
ADDRLP4 292
INDIRI4
CNSTI4 2
EQI4 $458
ADDRGP4 $447
JUMPV
LABELV $447
LABELV $449
line 865
;863:	default:
;864:	case SAY_ALL:
;865:		G_LogPrintf( "say: %s: %s\n", ent->client->pers.netname, chatText );
ADDRGP4 $450
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 866
;866:		Com_sprintf (name, sizeof(name), "%s%c%c"EC": ", ent->client->pers.netname, Q_COLOR_ESCAPE, COLOR_WHITE );
ADDRLP4 158
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $451
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
CNSTI4 94
ARGI4
CNSTI4 55
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 867
;867:		color = COLOR_GREEN;
ADDRLP4 224
CNSTI4 50
ASGNI4
line 868
;868:		break;
ADDRGP4 $448
JUMPV
LABELV $452
line 870
;869:	case SAY_TEAM:
;870:		G_LogPrintf( "sayteam: %s: %s\n", ent->client->pers.netname, chatText );
ADDRGP4 $453
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 871
;871:		if (Team_GetLocationMsg(ent, location, sizeof(location)))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 228
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 296
ADDRGP4 Team_GetLocationMsg
CALLI4
ASGNI4
ADDRLP4 296
INDIRI4
CNSTI4 0
EQI4 $454
line 872
;872:			Com_sprintf (name, sizeof(name), EC"(%s%c%c"EC") (%s)"EC": ", 
ADDRLP4 158
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $456
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
CNSTI4 94
ARGI4
CNSTI4 55
ARGI4
ADDRLP4 228
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
ADDRGP4 $455
JUMPV
LABELV $454
line 875
;873:				ent->client->pers.netname, Q_COLOR_ESCAPE, COLOR_WHITE, location);
;874:		else
;875:			Com_sprintf (name, sizeof(name), EC"(%s%c%c"EC")"EC": ", 
ADDRLP4 158
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $457
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
CNSTI4 94
ARGI4
CNSTI4 55
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
LABELV $455
line 877
;876:				ent->client->pers.netname, Q_COLOR_ESCAPE, COLOR_WHITE );
;877:		color = COLOR_CYAN;
ADDRLP4 224
CNSTI4 53
ASGNI4
line 878
;878:		break;
ADDRGP4 $448
JUMPV
LABELV $458
line 880
;879:	case SAY_TELL:
;880:		if (target && g_gametype.integer >= GT_TEAM &&
ADDRLP4 300
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 300
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $459
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $459
ADDRLP4 304
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 300
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
ADDRLP4 304
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
NEI4 $459
ADDRLP4 304
INDIRP4
ARGP4
ADDRLP4 228
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 308
ADDRGP4 Team_GetLocationMsg
CALLI4
ASGNI4
ADDRLP4 308
INDIRI4
CNSTI4 0
EQI4 $459
line 883
;881:			target->client->sess.sessionTeam == ent->client->sess.sessionTeam &&
;882:			Team_GetLocationMsg(ent, location, sizeof(location)))
;883:			Com_sprintf (name, sizeof(name), EC"[%s%c%c"EC"] (%s)"EC": ", ent->client->pers.netname, Q_COLOR_ESCAPE, COLOR_WHITE, location );
ADDRLP4 158
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $462
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
CNSTI4 94
ARGI4
CNSTI4 55
ARGI4
ADDRLP4 228
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
ADDRGP4 $460
JUMPV
LABELV $459
line 885
;884:		else
;885:			Com_sprintf (name, sizeof(name), EC"[%s%c%c"EC"]"EC": ", ent->client->pers.netname, Q_COLOR_ESCAPE, COLOR_WHITE );
ADDRLP4 158
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $463
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
CNSTI4 94
ARGI4
CNSTI4 55
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
LABELV $460
line 886
;886:		color = COLOR_MAGENTA;
ADDRLP4 224
CNSTI4 54
ASGNI4
line 887
;887:		break;
LABELV $448
line 890
;888:	}
;889:
;890:	Q_strncpyz( text, chatText, sizeof(text) );
ADDRLP4 8
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
CNSTI4 150
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 892
;891:
;892:	if ( target ) {
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $464
line 893
;893:		G_SayTo( ent, target, mode, color, name, text );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 224
INDIRI4
ARGI4
ADDRLP4 158
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 G_SayTo
CALLV
pop
line 894
;894:		return;
ADDRGP4 $443
JUMPV
LABELV $464
line 898
;895:	}
;896:
;897:	// echo the text to the console
;898:	if ( g_dedicated.integer ) {
ADDRGP4 g_dedicated+12
INDIRI4
CNSTI4 0
EQI4 $466
line 899
;899:		G_Printf( "%s%s\n", name, text);
ADDRGP4 $469
ARGP4
ADDRLP4 158
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 900
;900:	}
LABELV $466
line 903
;901:
;902:	// send it to all the apropriate clients
;903:	for (j = 0; j < level.maxclients; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $473
JUMPV
LABELV $470
line 904
;904:		other = &g_entities[j];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 905
;905:		G_SayTo( ent, other, mode, color, name, text );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 224
INDIRI4
ARGI4
ADDRLP4 158
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 G_SayTo
CALLV
pop
line 906
;906:	}
LABELV $471
line 903
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $473
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $470
line 907
;907:}
LABELV $443
endproc G_Say 312 28
proc Cmd_Say_f 12 16
line 915
;908:
;909:
;910:/*
;911:==================
;912:Cmd_Say_f
;913:==================
;914:*/
;915:static void Cmd_Say_f( gentity_t *ent, int mode, qboolean arg0 ) {
line 918
;916:	char		*p;
;917:
;918:	if ( trap_Argc () < 2 && !arg0 ) {
ADDRLP4 4
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 2
GEI4 $476
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $476
line 919
;919:		return;
ADDRGP4 $475
JUMPV
LABELV $476
line 922
;920:	}
;921:
;922:	if (arg0)
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $478
line 923
;923:	{
line 924
;924:		p = ConcatArgs( 0 );
CNSTI4 0
ARGI4
ADDRLP4 8
ADDRGP4 ConcatArgs
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 925
;925:	}
ADDRGP4 $479
JUMPV
LABELV $478
line 927
;926:	else
;927:	{
line 928
;928:		p = ConcatArgs( 1 );
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 ConcatArgs
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 929
;929:	}
LABELV $479
line 931
;930:
;931:	G_Say( ent, NULL, mode, p );
ADDRFP4 0
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_Say
CALLV
pop
line 932
;932:}
LABELV $475
endproc Cmd_Say_f 12 16
proc Cmd_Tell_f 1064 16
line 939
;933:
;934:/*
;935:==================
;936:Cmd_Tell_f
;937:==================
;938:*/
;939:static void Cmd_Tell_f( gentity_t *ent ) {
line 945
;940:	int			targetNum;
;941:	gentity_t	*target;
;942:	char		*p;
;943:	char		arg[MAX_TOKEN_CHARS];
;944:
;945:	if ( trap_Argc () < 2 ) {
ADDRLP4 1036
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 2
GEI4 $481
line 946
;946:		return;
ADDRGP4 $480
JUMPV
LABELV $481
line 949
;947:	}
;948:
;949:	trap_Argv( 1, arg, sizeof( arg ) );
CNSTI4 1
ARGI4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 950
;950:	targetNum = atoi( arg );
ADDRLP4 12
ARGP4
ADDRLP4 1040
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 1040
INDIRI4
ASGNI4
line 951
;951:	if ( targetNum < 0 || targetNum >= level.maxclients ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $486
ADDRLP4 4
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $483
LABELV $486
line 952
;952:		return;
ADDRGP4 $480
JUMPV
LABELV $483
line 955
;953:	}
;954:
;955:	target = &g_entities[targetNum];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 956
;956:	if ( !target || !target->inuse || !target->client ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $490
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
EQI4 $490
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $487
LABELV $490
line 957
;957:		return;
ADDRGP4 $480
JUMPV
LABELV $487
line 960
;958:	}
;959:
;960:	p = ConcatArgs( 2 );
CNSTI4 2
ARGI4
ADDRLP4 1052
ADDRGP4 ConcatArgs
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 1052
INDIRP4
ASGNP4
line 962
;961:
;962:	G_LogPrintf( "tell: %s to %s: %s\n", ent->client->pers.netname, target->client->pers.netname, p );
ADDRGP4 $491
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 963
;963:	G_Say( ent, target, SAY_TELL, p );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 G_Say
CALLV
pop
line 966
;964:	// don't tell to the player self if it was already directed to this player
;965:	// also don't send the chat back to a bot
;966:	if ( ent != target && !(ent->r.svFlags & SVF_BOT)) {
ADDRLP4 1056
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1056
INDIRP4
CVPU4 4
ADDRLP4 0
INDIRP4
CVPU4 4
EQU4 $492
ADDRLP4 1056
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $492
line 967
;967:		G_Say( ent, ent, SAY_TELL, p );
ADDRLP4 1060
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1060
INDIRP4
ARGP4
ADDRLP4 1060
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 G_Say
CALLV
pop
line 968
;968:	}
LABELV $492
line 969
;969:}
LABELV $480
endproc Cmd_Tell_f 1064 16
proc G_VoiceTo 16 24
line 972
;970:
;971:
;972:static void G_VoiceTo( gentity_t *ent, gentity_t *other, int mode, const char *id, qboolean voiceonly ) {
line 976
;973:	int color;
;974:	char *cmd;
;975:
;976:	if (!other) {
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $495
line 977
;977:		return;
ADDRGP4 $494
JUMPV
LABELV $495
line 979
;978:	}
;979:	if (!other->inuse) {
ADDRFP4 4
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $497
line 980
;980:		return;
ADDRGP4 $494
JUMPV
LABELV $497
line 982
;981:	}
;982:	if (!other->client) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $499
line 983
;983:		return;
ADDRGP4 $494
JUMPV
LABELV $499
line 985
;984:	}
;985:	if ( mode == SAY_TEAM && !OnSameTeam(ent, other) ) {
ADDRFP4 8
INDIRI4
CNSTI4 1
NEI4 $501
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $501
line 986
;986:		return;
ADDRGP4 $494
JUMPV
LABELV $501
line 989
;987:	}
;988:	// no chatting to players in tournements
;989:	if ( (g_gametype.integer == GT_TOURNAMENT )) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
NEI4 $503
line 990
;990:		return;
ADDRGP4 $494
JUMPV
LABELV $503
line 993
;991:	}
;992:
;993:	if (mode == SAY_TEAM) {
ADDRFP4 8
INDIRI4
CNSTI4 1
NEI4 $506
line 994
;994:		color = COLOR_CYAN;
ADDRLP4 0
CNSTI4 53
ASGNI4
line 995
;995:		cmd = "vtchat";
ADDRLP4 4
ADDRGP4 $508
ASGNP4
line 996
;996:	}
ADDRGP4 $507
JUMPV
LABELV $506
line 997
;997:	else if (mode == SAY_TELL) {
ADDRFP4 8
INDIRI4
CNSTI4 2
NEI4 $509
line 998
;998:		color = COLOR_MAGENTA;
ADDRLP4 0
CNSTI4 54
ASGNI4
line 999
;999:		cmd = "vtell";
ADDRLP4 4
ADDRGP4 $511
ASGNP4
line 1000
;1000:	}
ADDRGP4 $510
JUMPV
LABELV $509
line 1001
;1001:	else {
line 1002
;1002:		color = COLOR_GREEN;
ADDRLP4 0
CNSTI4 50
ASGNI4
line 1003
;1003:		cmd = "vchat";
ADDRLP4 4
ADDRGP4 $512
ASGNP4
line 1004
;1004:	}
LABELV $510
LABELV $507
line 1006
;1005:
;1006:	trap_SendServerCommand( other-g_entities, va("%s %d %d %d %s", cmd, voiceonly, ent->s.number, color, id));
ADDRGP4 $513
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1007
;1007:}
LABELV $494
endproc G_VoiceTo 16 24
export G_Voice
proc G_Voice 8 20
line 1009
;1008:
;1009:void G_Voice( gentity_t *ent, gentity_t *target, int mode, const char *id, qboolean voiceonly ) {
line 1013
;1010:	int			j;
;1011:	gentity_t	*other;
;1012:
;1013:	if ( g_gametype.integer < GT_TEAM && mode == SAY_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
GEI4 $515
ADDRFP4 8
INDIRI4
CNSTI4 1
NEI4 $515
line 1014
;1014:		mode = SAY_ALL;
ADDRFP4 8
CNSTI4 0
ASGNI4
line 1015
;1015:	}
LABELV $515
line 1017
;1016:
;1017:	if ( target ) {
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $518
line 1018
;1018:		G_VoiceTo( ent, target, mode, id, voiceonly );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 G_VoiceTo
CALLV
pop
line 1019
;1019:		return;
ADDRGP4 $514
JUMPV
LABELV $518
line 1023
;1020:	}
;1021:
;1022:	// echo the text to the console
;1023:	if ( g_dedicated.integer ) {
ADDRGP4 g_dedicated+12
INDIRI4
CNSTI4 0
EQI4 $520
line 1024
;1024:		G_Printf( "voice: %s %s\n", ent->client->pers.netname, id);
ADDRGP4 $523
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 1025
;1025:	}
LABELV $520
line 1028
;1026:
;1027:	// send it to all the apropriate clients
;1028:	for (j = 0; j < level.maxclients; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $527
JUMPV
LABELV $524
line 1029
;1029:		other = &g_entities[j];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1030
;1030:		G_VoiceTo( ent, other, mode, id, voiceonly );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 G_VoiceTo
CALLV
pop
line 1031
;1031:	}
LABELV $525
line 1028
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $527
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $524
line 1032
;1032:}
LABELV $514
endproc G_Voice 8 20
data
align 4
LABELV gc_orders
address $529
address $530
address $531
address $532
address $533
address $534
address $535
export Cmd_GameCommand_f
code
proc Cmd_GameCommand_f 1052 16
line 1186
;1033:
;1034:/*
;1035:==================
;1036:Cmd_Voice_f
;1037:==================
;1038:*/
;1039:#ifdef MISSIONPACK
;1040:static void Cmd_Voice_f( gentity_t *ent, int mode, qboolean arg0, qboolean voiceonly ) {
;1041:	char		*p;
;1042:
;1043:	if ( trap_Argc () < 2 && !arg0 ) {
;1044:		return;
;1045:	}
;1046:
;1047:	if (arg0)
;1048:	{
;1049:		p = ConcatArgs( 0 );
;1050:	}
;1051:	else
;1052:	{
;1053:		p = ConcatArgs( 1 );
;1054:	}
;1055:
;1056:	G_Voice( ent, NULL, mode, p, voiceonly );
;1057:}
;1058:#endif
;1059:
;1060:/*
;1061:==================
;1062:Cmd_VoiceTell_f
;1063:==================
;1064:*/
;1065:#ifdef MISSIONPACK
;1066:static void Cmd_VoiceTell_f( gentity_t *ent, qboolean voiceonly ) {
;1067:	int			targetNum;
;1068:	gentity_t	*target;
;1069:	char		*id;
;1070:	char		arg[MAX_TOKEN_CHARS];
;1071:
;1072:	if ( trap_Argc () < 2 ) {
;1073:		return;
;1074:	}
;1075:
;1076:	trap_Argv( 1, arg, sizeof( arg ) );
;1077:	targetNum = atoi( arg );
;1078:	if ( targetNum < 0 || targetNum >= level.maxclients ) {
;1079:		return;
;1080:	}
;1081:
;1082:	target = &g_entities[targetNum];
;1083:	if ( !target || !target->inuse || !target->client ) {
;1084:		return;
;1085:	}
;1086:
;1087:	id = ConcatArgs( 2 );
;1088:
;1089:	G_LogPrintf( "vtell: %s to %s: %s\n", ent->client->pers.netname, target->client->pers.netname, id );
;1090:	G_Voice( ent, target, SAY_TELL, id, voiceonly );
;1091:	// don't tell to the player self if it was already directed to this player
;1092:	// also don't send the chat back to a bot
;1093:	if ( ent != target && !(ent->r.svFlags & SVF_BOT)) {
;1094:		G_Voice( ent, ent, SAY_TELL, id, voiceonly );
;1095:	}
;1096:}
;1097:#endif
;1098:
;1099:
;1100:/*
;1101:==================
;1102:Cmd_VoiceTaunt_f
;1103:==================
;1104:*/
;1105:#ifdef MISSIONPACK
;1106:static void Cmd_VoiceTaunt_f( gentity_t *ent ) {
;1107:	gentity_t *who;
;1108:	int i;
;1109:
;1110:	if (!ent->client) {
;1111:		return;
;1112:	}
;1113:
;1114:	// insult someone who just killed you
;1115:	if (ent->enemy && ent->enemy->client && ent->enemy->client->lastkilled_client == ent->s.number) {
;1116:		// i am a dead corpse
;1117:		if (!(ent->enemy->r.svFlags & SVF_BOT)) {
;1118:			G_Voice( ent, ent->enemy, SAY_TELL, VOICECHAT_DEATHINSULT, qfalse );
;1119:		}
;1120:		if (!(ent->r.svFlags & SVF_BOT)) {
;1121:			G_Voice( ent, ent,        SAY_TELL, VOICECHAT_DEATHINSULT, qfalse );
;1122:		}
;1123:		ent->enemy = NULL;
;1124:		return;
;1125:	}
;1126:	// insult someone you just killed
;1127:	if (ent->client->lastkilled_client >= 0 && ent->client->lastkilled_client != ent->s.number) {
;1128:		who = g_entities + ent->client->lastkilled_client;
;1129:		if (who->client) {
;1130:			// who is the person I just killed
;1131:			if (who->client->lasthurt_mod == MOD_GAUNTLET) {
;1132:				if (!(who->r.svFlags & SVF_BOT)) {
;1133:					G_Voice( ent, who, SAY_TELL, VOICECHAT_KILLGAUNTLET, qfalse );	// and I killed them with a gauntlet
;1134:				}
;1135:				if (!(ent->r.svFlags & SVF_BOT)) {
;1136:					G_Voice( ent, ent, SAY_TELL, VOICECHAT_KILLGAUNTLET, qfalse );
;1137:				}
;1138:			} else {
;1139:				if (!(who->r.svFlags & SVF_BOT)) {
;1140:					G_Voice( ent, who, SAY_TELL, VOICECHAT_KILLINSULT, qfalse );	// and I killed them with something else
;1141:				}
;1142:				if (!(ent->r.svFlags & SVF_BOT)) {
;1143:					G_Voice( ent, ent, SAY_TELL, VOICECHAT_KILLINSULT, qfalse );
;1144:				}
;1145:			}
;1146:			ent->client->lastkilled_client = -1;
;1147:			return;
;1148:		}
;1149:	}
;1150:
;1151:	if (g_gametype.integer >= GT_TEAM) {
;1152:		// praise a team mate who just got a reward
;1153:		for(i = 0; i < MAX_CLIENTS; i++) {
;1154:			who = g_entities + i;
;1155:			if (who->client && who != ent && who->client->sess.sessionTeam == ent->client->sess.sessionTeam) {
;1156:				if (who->client->rewardTime > level.time) {
;1157:					if (!(who->r.svFlags & SVF_BOT)) {
;1158:						G_Voice( ent, who, SAY_TELL, VOICECHAT_PRAISE, qfalse );
;1159:					}
;1160:					if (!(ent->r.svFlags & SVF_BOT)) {
;1161:						G_Voice( ent, ent, SAY_TELL, VOICECHAT_PRAISE, qfalse );
;1162:					}
;1163:					return;
;1164:				}
;1165:			}
;1166:		}
;1167:	}
;1168:
;1169:	// just say something
;1170:	G_Voice( ent, NULL, SAY_ALL, VOICECHAT_TAUNT, qfalse );
;1171:}
;1172:#endif
;1173:
;1174:
;1175:
;1176:static char	*gc_orders[] = {
;1177:	"hold your position",
;1178:	"hold this position",
;1179:	"come here",
;1180:	"cover me",
;1181:	"guard location",
;1182:	"search and destroy",
;1183:	"report"
;1184:};
;1185:
;1186:void Cmd_GameCommand_f( gentity_t *ent ) {
line 1191
;1187:	int		player;
;1188:	int		order;
;1189:	char	str[MAX_TOKEN_CHARS];
;1190:
;1191:	trap_Argv( 1, str, sizeof( str ) );
CNSTI4 1
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1192
;1192:	player = atoi( str );
ADDRLP4 0
ARGP4
ADDRLP4 1032
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1028
ADDRLP4 1032
INDIRI4
ASGNI4
line 1193
;1193:	trap_Argv( 2, str, sizeof( str ) );
CNSTI4 2
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1194
;1194:	order = atoi( str );
ADDRLP4 0
ARGP4
ADDRLP4 1036
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1024
ADDRLP4 1036
INDIRI4
ASGNI4
line 1196
;1195:
;1196:	if ( player < 0 || player >= MAX_CLIENTS ) {
ADDRLP4 1028
INDIRI4
CNSTI4 0
LTI4 $539
ADDRLP4 1028
INDIRI4
CNSTI4 64
LTI4 $537
LABELV $539
line 1197
;1197:		return;
ADDRGP4 $536
JUMPV
LABELV $537
line 1199
;1198:	}
;1199:	if ( order < 0 || order > sizeof(gc_orders)/sizeof(char *) ) {
ADDRLP4 1024
INDIRI4
CNSTI4 0
LTI4 $542
ADDRLP4 1024
INDIRI4
CVIU4 4
CNSTU4 7
LEU4 $540
LABELV $542
line 1200
;1200:		return;
ADDRGP4 $536
JUMPV
LABELV $540
line 1202
;1201:	}
;1202:	G_Say( ent, &g_entities[player], SAY_TELL, gc_orders[order] );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1028
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 1024
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gc_orders
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_Say
CALLV
pop
line 1203
;1203:	G_Say( ent, ent, SAY_TELL, gc_orders[order] );
ADDRLP4 1048
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1048
INDIRP4
ARGP4
ADDRLP4 1048
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 1024
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gc_orders
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_Say
CALLV
pop
line 1204
;1204:}
LABELV $536
endproc Cmd_GameCommand_f 1052 16
export Cmd_Where_f
proc Cmd_Where_f 8 8
line 1211
;1205:
;1206:/*
;1207:==================
;1208:Cmd_Where_f
;1209:==================
;1210:*/
;1211:void Cmd_Where_f( gentity_t *ent ) {
line 1212
;1212:	trap_SendServerCommand( ent-g_entities, va("print \"%s\n\"", vtos( ent->s.origin ) ) );
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 vtos
CALLP4
ASGNP4
ADDRGP4 $544
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1213
;1213:}
LABELV $543
endproc Cmd_Where_f 8 8
data
align 4
LABELV gameNames
address $545
address $546
address $547
address $548
address $549
address $550
address $551
address $552
address $553
align 4
LABELV $654
address $655
address $656
address $657
address $658
address $659
export Cmd_CallVote_f
code
proc Cmd_CallVote_f 5196 28
line 1235
;1214:
;1215:static const char *gameNames[] = {
;1216:	"Free For All",
;1217:	"Tournament",
;1218:	"Single Player",
;1219:	"Team Deathmatch",
;1220:	"Capture the Flag",
;1221:	"One Flag CTF",
;1222:	"Overload",
;1223:	"Harvester"
;1224:	// JUHOX: add STU game name for the callvote command
;1225:#if MONSTER_MODE
;1226:	, "Save the Universe"
;1227:#endif
;1228:};
;1229:
;1230:/*
;1231:==================
;1232:Cmd_CallVote_f
;1233:==================
;1234:*/
;1235:void Cmd_CallVote_f( gentity_t *ent ) {
line 1242
;1236:	int		i;
;1237:	char	arg1[MAX_STRING_TOKENS];
;1238:	char	arg2[MAX_STRING_TOKENS];
;1239:	char	arg3[MAX_STRING_TOKENS];	// JUHOX
;1240:	char	arg4[MAX_STRING_TOKENS];	// JUHOX
;1241:
;1242:	if ( !g_allowVote.integer ) {
ADDRGP4 g_allowVote+12
INDIRI4
CNSTI4 0
NEI4 $555
line 1243
;1243:		trap_SendServerCommand( ent-g_entities, "print \"Voting not allowed here.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRGP4 $558
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1244
;1244:		return;
ADDRGP4 $554
JUMPV
LABELV $555
line 1247
;1245:	}
;1246:
;1247:	if ( level.voteTime ) {
ADDRGP4 level+2420
INDIRI4
CNSTI4 0
EQI4 $559
line 1248
;1248:		trap_SendServerCommand( ent-g_entities, "print \"A vote is already in progress.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRGP4 $562
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1249
;1249:		return;
ADDRGP4 $554
JUMPV
LABELV $559
line 1251
;1250:	}
;1251:	if ( ent->client->pers.voteCount >= MAX_VOTE_COUNT ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 604
ADDP4
INDIRI4
CNSTI4 3
LTI4 $563
line 1252
;1252:		trap_SendServerCommand( ent-g_entities, "print \"You have called the maximum number of votes.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRGP4 $565
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1253
;1253:		return;
ADDRGP4 $554
JUMPV
LABELV $563
line 1255
;1254:	}
;1255:	if ( ent->client->sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 3
NEI4 $566
line 1256
;1256:		trap_SendServerCommand( ent-g_entities, "print \"Not allowed to call a vote as spectator.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRGP4 $568
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1257
;1257:		return;
ADDRGP4 $554
JUMPV
LABELV $566
line 1261
;1258:	}
;1259:
;1260:	// make sure it is a valid command to vote on
;1261:	trap_Argv( 1, arg1, sizeof( arg1 ) );
CNSTI4 1
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1262
;1262:	trap_Argv( 2, arg2, sizeof( arg2 ) );
CNSTI4 2
ARGI4
ADDRLP4 1028
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1263
;1263:	trap_Argv( 3, arg3, sizeof( arg3 ) );	// JUHOX
CNSTI4 3
ARGI4
ADDRLP4 2052
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1264
;1264:	trap_Argv( 4, arg4, sizeof( arg4 ) );	// JUHOX
CNSTI4 4
ARGI4
ADDRLP4 3076
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1270
;1265:
;1266:	// JUHOX: also check arg3 of the vote command
;1267:#if 0
;1268:	if( strchr( arg1, ';' ) || strchr( arg2, ';' ) ) {
;1269:#else
;1270:	if (strchr(arg1, ';') || strchr(arg2, ';') || strchr(arg3, ';') || strchr(arg4, ';')) {
ADDRLP4 4
ARGP4
CNSTI4 59
ARGI4
ADDRLP4 4100
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 4100
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $573
ADDRLP4 1028
ARGP4
CNSTI4 59
ARGI4
ADDRLP4 4104
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 4104
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $573
ADDRLP4 2052
ARGP4
CNSTI4 59
ARGI4
ADDRLP4 4108
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 4108
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $573
ADDRLP4 3076
ARGP4
CNSTI4 59
ARGI4
ADDRLP4 4112
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 4112
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $569
LABELV $573
line 1272
;1271:#endif
;1272:		trap_SendServerCommand( ent-g_entities, "print \"Invalid vote string.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRGP4 $574
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1273
;1273:		return;
ADDRGP4 $554
JUMPV
LABELV $569
line 1276
;1274:	}
;1275:
;1276:	if ( !Q_stricmp( arg1, "map_restart" ) ) {
ADDRLP4 4
ARGP4
ADDRGP4 $577
ARGP4
ADDRLP4 4116
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4116
INDIRI4
CNSTI4 0
NEI4 $575
line 1277
;1277:	} else if ( !Q_stricmp( arg1, "nextmap" ) ) {
ADDRGP4 $576
JUMPV
LABELV $575
ADDRLP4 4
ARGP4
ADDRGP4 $580
ARGP4
ADDRLP4 4120
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4120
INDIRI4
CNSTI4 0
NEI4 $578
line 1278
;1278:	} else if ( !Q_stricmp( arg1, "map" ) ) {
ADDRGP4 $579
JUMPV
LABELV $578
ADDRLP4 4
ARGP4
ADDRGP4 $583
ARGP4
ADDRLP4 4124
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4124
INDIRI4
CNSTI4 0
NEI4 $581
line 1279
;1279:	} else if ( !Q_stricmp( arg1, "g_gametype" ) ) {
ADDRGP4 $582
JUMPV
LABELV $581
ADDRLP4 4
ARGP4
ADDRGP4 $586
ARGP4
ADDRLP4 4128
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4128
INDIRI4
CNSTI4 0
NEI4 $584
line 1280
;1280:	} else if ( !Q_stricmp( arg1, "kick" ) ) {
ADDRGP4 $585
JUMPV
LABELV $584
ADDRLP4 4
ARGP4
ADDRGP4 $589
ARGP4
ADDRLP4 4132
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4132
INDIRI4
CNSTI4 0
NEI4 $587
line 1281
;1281:	} else if ( !Q_stricmp( arg1, "clientkick" ) ) {
ADDRGP4 $588
JUMPV
LABELV $587
ADDRLP4 4
ARGP4
ADDRGP4 $592
ARGP4
ADDRLP4 4136
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4136
INDIRI4
CNSTI4 0
NEI4 $590
line 1282
;1282:	} else if ( !Q_stricmp( arg1, "g_doWarmup" ) ) {
ADDRGP4 $591
JUMPV
LABELV $590
ADDRLP4 4
ARGP4
ADDRGP4 $595
ARGP4
ADDRLP4 4140
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4140
INDIRI4
CNSTI4 0
NEI4 $593
line 1283
;1283:	} else if ( !Q_stricmp( arg1, "timelimit" ) ) {
ADDRGP4 $594
JUMPV
LABELV $593
ADDRLP4 4
ARGP4
ADDRGP4 $598
ARGP4
ADDRLP4 4144
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4144
INDIRI4
CNSTI4 0
NEI4 $596
line 1284
;1284:	} else if ( !Q_stricmp( arg1, "fraglimit" ) ) {
ADDRGP4 $597
JUMPV
LABELV $596
ADDRLP4 4
ARGP4
ADDRGP4 $601
ARGP4
ADDRLP4 4148
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4148
INDIRI4
CNSTI4 0
NEI4 $599
line 1287
;1285:	// JUHOX: add addbot vote command
;1286:#if 1
;1287:	} else if (!Q_stricmp(arg1, "addbot")) {
ADDRGP4 $600
JUMPV
LABELV $599
ADDRLP4 4
ARGP4
ADDRGP4 $604
ARGP4
ADDRLP4 4152
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4152
INDIRI4
CNSTI4 0
NEI4 $602
line 1291
;1288:#endif
;1289:	// JUHOX: add template vote command
;1290:#if 1
;1291:	} else if (!Q_stricmp(arg1, "template")) {
ADDRGP4 $603
JUMPV
LABELV $602
ADDRLP4 4
ARGP4
ADDRGP4 $607
ARGP4
ADDRLP4 4156
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4156
INDIRI4
CNSTI4 0
NEI4 $605
line 1293
;1292:#endif
;1293:	} else {
ADDRGP4 $606
JUMPV
LABELV $605
line 1294
;1294:		trap_SendServerCommand( ent-g_entities, "print \"Invalid vote string.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRGP4 $574
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1299
;1295:		// JUHOX: add new commands help line
;1296:#if 0
;1297:		trap_SendServerCommand( ent-g_entities, "print \"Vote commands are: map_restart, nextmap, map <mapname>, g_gametype <n>, kick <player>, clientkick <clientnum>, g_doWarmup, timelimit <time>, fraglimit <frags>.\n\"" );
;1298:#else
;1299:		trap_SendServerCommand( ent-g_entities, "print \"Vote commands are: map_restart, nextmap, map <mapname>, g_gametype <n>, kick <player>, clientkick <clientnum>, g_doWarmup, timelimit <time>, fraglimit <frags>, addbot <name> <skill 1-5> [team].\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRGP4 $608
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1301
;1300:#endif
;1301:		return;
ADDRGP4 $554
JUMPV
LABELV $606
LABELV $603
LABELV $600
LABELV $597
LABELV $594
LABELV $591
LABELV $588
LABELV $585
LABELV $582
LABELV $579
LABELV $576
line 1305
;1302:	}
;1303:
;1304:	// if there is still a vote to be executed
;1305:	if ( level.voteExecuteTime ) {
ADDRGP4 level+2424
INDIRI4
CNSTI4 0
EQI4 $609
line 1306
;1306:		level.voteExecuteTime = 0;
ADDRGP4 level+2424
CNSTI4 0
ASGNI4
line 1307
;1307:		trap_SendConsoleCommand( EXEC_APPEND, va("%s\n", level.voteString ) );
ADDRGP4 $613
ARGP4
ADDRGP4 level+372
ARGP4
ADDRLP4 4160
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 4160
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 1308
;1308:	}
LABELV $609
line 1311
;1309:
;1310:	// special case for g_gametype, check for bad values
;1311:	if ( !Q_stricmp( arg1, "g_gametype" ) ) {
ADDRLP4 4
ARGP4
ADDRGP4 $586
ARGP4
ADDRLP4 4160
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4160
INDIRI4
CNSTI4 0
NEI4 $615
line 1312
;1312:		i = atoi( arg2 );
ADDRLP4 1028
ARGP4
ADDRLP4 4164
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4164
INDIRI4
ASGNI4
line 1313
;1313:		if( i == GT_SINGLE_PLAYER || i < GT_FFA || i >= GT_MAX_GAME_TYPE) {
ADDRLP4 0
INDIRI4
CNSTI4 2
EQI4 $620
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $620
ADDRLP4 0
INDIRI4
CNSTI4 10
LTI4 $617
LABELV $620
line 1314
;1314:			trap_SendServerCommand( ent-g_entities, "print \"Invalid gametype.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRGP4 $621
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1315
;1315:			return;
ADDRGP4 $554
JUMPV
LABELV $617
line 1318
;1316:		}
;1317:
;1318:		Com_sprintf( level.voteString, sizeof( level.voteString ), "%s %d", arg1, i );
ADDRGP4 level+372
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $624
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1319
;1319:		Com_sprintf( level.voteDisplayString, sizeof( level.voteDisplayString ), "%s %s", arg1, gameNames[i] );
ADDRGP4 level+1396
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $627
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gameNames
ADDP4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1320
;1320:	} else if ( !Q_stricmp( arg1, "map" ) ) {
ADDRGP4 $616
JUMPV
LABELV $615
ADDRLP4 4
ARGP4
ADDRGP4 $583
ARGP4
ADDRLP4 4164
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4164
INDIRI4
CNSTI4 0
NEI4 $628
line 1325
;1321:		// special case for map changes, we want to reset the nextmap setting
;1322:		// this allows a player to change maps, but not upset the map rotation
;1323:		char	s[MAX_STRING_CHARS];
;1324:
;1325:		trap_Cvar_VariableStringBuffer( "nextmap", s, sizeof(s) );
ADDRGP4 $580
ARGP4
ADDRLP4 4168
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1326
;1326:		if (*s) {
ADDRLP4 4168
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $630
line 1327
;1327:			Com_sprintf( level.voteString, sizeof( level.voteString ), "%s %s; set nextmap \"%s\"", arg1, arg2, s );
ADDRGP4 level+372
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $634
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 1028
ARGP4
ADDRLP4 4168
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1328
;1328:		} else {
ADDRGP4 $631
JUMPV
LABELV $630
line 1329
;1329:			Com_sprintf( level.voteString, sizeof( level.voteString ), "%s %s", arg1, arg2 );
ADDRGP4 level+372
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $627
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 1028
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1330
;1330:		}
LABELV $631
line 1331
;1331:		Com_sprintf( level.voteDisplayString, sizeof( level.voteDisplayString ), "%s", level.voteString );
ADDRGP4 level+1396
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $639
ARGP4
ADDRGP4 level+372
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1332
;1332:	} else if ( !Q_stricmp( arg1, "nextmap" ) ) {
ADDRGP4 $629
JUMPV
LABELV $628
ADDRLP4 4
ARGP4
ADDRGP4 $580
ARGP4
ADDRLP4 4168
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4168
INDIRI4
CNSTI4 0
NEI4 $641
line 1335
;1333:		char	s[MAX_STRING_CHARS];
;1334:
;1335:		trap_Cvar_VariableStringBuffer( "nextmap", s, sizeof(s) );
ADDRGP4 $580
ARGP4
ADDRLP4 4172
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1336
;1336:		if (!*s) {
ADDRLP4 4172
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $643
line 1337
;1337:			trap_SendServerCommand( ent-g_entities, "print \"nextmap not set.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRGP4 $645
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1338
;1338:			return;
ADDRGP4 $554
JUMPV
LABELV $643
line 1340
;1339:		}
;1340:		Com_sprintf( level.voteString, sizeof( level.voteString ), "vstr nextmap");
ADDRGP4 level+372
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $648
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1341
;1341:		Com_sprintf( level.voteDisplayString, sizeof( level.voteDisplayString ), "%s", level.voteString );
ADDRGP4 level+1396
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $639
ARGP4
ADDRGP4 level+372
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1344
;1342:	// JUHOX: special case for addbot vote command: additional arguments
;1343:#if 1
;1344:	} else if (!Q_stricmp(arg1, "addbot")) {
ADDRGP4 $642
JUMPV
LABELV $641
ADDRLP4 4
ARGP4
ADDRGP4 $604
ARGP4
ADDRLP4 4172
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4172
INDIRI4
CNSTI4 0
NEI4 $652
line 1355
;1345:		static const char* const skillnames[] = {
;1346:			"I can win",
;1347:			"Bring it on",
;1348:			"Hurt me plenty",
;1349:			"Hardcore",
;1350:			"Nightmare"
;1351:		};
;1352:		int skill;
;1353:		const char* skillname;
;1354:
;1355:		skill = atoi(arg3);
ADDRLP4 2052
ARGP4
ADDRLP4 4184
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4176
ADDRLP4 4184
INDIRI4
ASGNI4
line 1356
;1356:		if (skill >= 1 && skill <= 5) {
ADDRLP4 4188
ADDRLP4 4176
INDIRI4
ASGNI4
ADDRLP4 4188
INDIRI4
CNSTI4 1
LTI4 $660
ADDRLP4 4188
INDIRI4
CNSTI4 5
GTI4 $660
line 1357
;1357:			skillname = skillnames[skill - 1];
ADDRLP4 4180
ADDRLP4 4176
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $654-4
ADDP4
INDIRP4
ASGNP4
line 1358
;1358:		}
ADDRGP4 $661
JUMPV
LABELV $660
line 1359
;1359:		else {
line 1360
;1360:			skillname = "unknown skill";
ADDRLP4 4180
ADDRGP4 $663
ASGNP4
line 1361
;1361:		}
LABELV $661
line 1362
;1362:		Com_sprintf(level.voteString, sizeof(level.voteString), "%s \"%s\" %s %s", arg1, arg2, arg3, arg4);
ADDRGP4 level+372
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $666
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 1028
ARGP4
ADDRLP4 2052
ARGP4
ADDRLP4 3076
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1363
;1363:		Com_sprintf(level.voteDisplayString, sizeof(level.voteDisplayString), "%s (%s)", level.voteString, skillname);
ADDRGP4 level+1396
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $669
ARGP4
ADDRGP4 level+372
ARGP4
ADDRLP4 4180
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1367
;1364:#endif
;1365:	// JUHOX: special case for template vote command: different display string
;1366:#if 1
;1367:	} else if (!Q_stricmp(arg1, "template")) {
ADDRGP4 $653
JUMPV
LABELV $652
ADDRLP4 4
ARGP4
ADDRGP4 $607
ARGP4
ADDRLP4 4176
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4176
INDIRI4
CNSTI4 0
NEI4 $671
line 1370
;1368:		int n;
;1369:
;1370:		n = atoi(arg2);
ADDRLP4 1028
ARGP4
ADDRLP4 4184
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4180
ADDRLP4 4184
INDIRI4
ASGNI4
line 1371
;1371:		if (n < 0 || n >= templateList.numEntries) return;
ADDRLP4 4188
ADDRLP4 4180
INDIRI4
ASGNI4
ADDRLP4 4188
INDIRI4
CNSTI4 0
LTI4 $676
ADDRLP4 4188
INDIRI4
ADDRGP4 templateList+81540
INDIRI4
LTI4 $673
LABELV $676
ADDRGP4 $554
JUMPV
LABELV $673
line 1372
;1372:		Com_sprintf(level.voteString, sizeof(level.voteString), "%s %s", arg1, arg2);
ADDRGP4 level+372
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $627
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 1028
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1373
;1373:		Com_sprintf(level.voteDisplayString, sizeof(level.voteDisplayString), "play %s", templateList.entries[n].name);
ADDRGP4 level+1396
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $681
ARGP4
ADDRLP4 4180
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 templateList+65540+4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1375
;1374:#endif
;1375:	} else {
ADDRGP4 $672
JUMPV
LABELV $671
line 1376
;1376:		Com_sprintf( level.voteString, sizeof( level.voteString ), "%s \"%s\"", arg1, arg2 );
ADDRGP4 level+372
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $686
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 1028
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1377
;1377:		Com_sprintf( level.voteDisplayString, sizeof( level.voteDisplayString ), "%s", level.voteString );
ADDRGP4 level+1396
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $639
ARGP4
ADDRGP4 level+372
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1378
;1378:	}
LABELV $672
LABELV $653
LABELV $642
LABELV $629
LABELV $616
line 1380
;1379:
;1380:	trap_SendServerCommand( -1, va("print \"%s called a vote.\n\"", ent->client->pers.netname ) );
ADDRGP4 $690
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 4180
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 4180
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1383
;1381:
;1382:	// start the voting, the caller autoamtically votes yes
;1383:	level.voteTime = level.time;
ADDRGP4 level+2420
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1384
;1384:	level.voteYes = 1;
ADDRGP4 level+2428
CNSTI4 1
ASGNI4
line 1385
;1385:	level.voteNo = 0;
ADDRGP4 level+2432
CNSTI4 0
ASGNI4
line 1387
;1386:
;1387:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $698
JUMPV
LABELV $695
line 1388
;1388:		level.clients[i].ps.eFlags &= ~EF_VOTED;
ADDRLP4 4184
ADDRLP4 0
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 4184
INDIRP4
ADDRLP4 4184
INDIRP4
INDIRI4
CNSTI4 -16385
BANDI4
ASGNI4
line 1389
;1389:	}
LABELV $696
line 1387
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $698
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $695
line 1390
;1390:	ent->client->ps.eFlags |= EF_VOTED;
ADDRLP4 4184
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 4184
INDIRP4
ADDRLP4 4184
INDIRP4
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
line 1392
;1391:
;1392:	trap_SetConfigstring( CS_VOTE_TIME, va("%i", level.voteTime ) );
ADDRGP4 $700
ARGP4
ADDRGP4 level+2420
INDIRI4
ARGI4
ADDRLP4 4188
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 8
ARGI4
ADDRLP4 4188
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1393
;1393:	trap_SetConfigstring( CS_VOTE_STRING, level.voteDisplayString );	
CNSTI4 9
ARGI4
ADDRGP4 level+1396
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1394
;1394:	trap_SetConfigstring( CS_VOTE_YES, va("%i", level.voteYes ) );
ADDRGP4 $700
ARGP4
ADDRGP4 level+2428
INDIRI4
ARGI4
ADDRLP4 4192
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 10
ARGI4
ADDRLP4 4192
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1395
;1395:	trap_SetConfigstring( CS_VOTE_NO, va("%i", level.voteNo ) );	
ADDRGP4 $700
ARGP4
ADDRGP4 level+2432
INDIRI4
ARGI4
ADDRLP4 4196
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 11
ARGI4
ADDRLP4 4196
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1396
;1396:}
LABELV $554
endproc Cmd_CallVote_f 5196 28
export Cmd_Vote_f
proc Cmd_Vote_f 76 12
line 1403
;1397:
;1398:/*
;1399:==================
;1400:Cmd_Vote_f
;1401:==================
;1402:*/
;1403:void Cmd_Vote_f( gentity_t *ent ) {
line 1406
;1404:	char		msg[64];
;1405:
;1406:	if ( !level.voteTime ) {
ADDRGP4 level+2420
INDIRI4
CNSTI4 0
NEI4 $706
line 1407
;1407:		trap_SendServerCommand( ent-g_entities, "print \"No vote in progress.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRGP4 $709
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1408
;1408:		return;
ADDRGP4 $705
JUMPV
LABELV $706
line 1410
;1409:	}
;1410:	if ( ent->client->ps.eFlags & EF_VOTED ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $710
line 1411
;1411:		trap_SendServerCommand( ent-g_entities, "print \"Vote already cast.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRGP4 $712
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1412
;1412:		return;
ADDRGP4 $705
JUMPV
LABELV $710
line 1414
;1413:	}
;1414:	if ( ent->client->sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 3
NEI4 $713
line 1415
;1415:		trap_SendServerCommand( ent-g_entities, "print \"Not allowed to vote as spectator.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRGP4 $715
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1416
;1416:		return;
ADDRGP4 $705
JUMPV
LABELV $713
line 1419
;1417:	}
;1418:
;1419:	trap_SendServerCommand( ent-g_entities, "print \"Vote cast.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRGP4 $716
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1421
;1420:
;1421:	ent->client->ps.eFlags |= EF_VOTED;
ADDRLP4 64
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
line 1423
;1422:
;1423:	trap_Argv( 1, msg, sizeof( msg ) );
CNSTI4 1
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1425
;1424:
;1425:	if ( msg[0] == 'y' || msg[1] == 'Y' || msg[1] == '1' ) {
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 121
EQI4 $722
ADDRLP4 0+1
INDIRI1
CVII4 1
CNSTI4 89
EQI4 $722
ADDRLP4 0+1
INDIRI1
CVII4 1
CNSTI4 49
NEI4 $717
LABELV $722
line 1426
;1426:		level.voteYes++;
ADDRLP4 68
ADDRGP4 level+2428
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1427
;1427:		trap_SetConfigstring( CS_VOTE_YES, va("%i", level.voteYes ) );
ADDRGP4 $700
ARGP4
ADDRGP4 level+2428
INDIRI4
ARGI4
ADDRLP4 72
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 10
ARGI4
ADDRLP4 72
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1428
;1428:	} else {
ADDRGP4 $718
JUMPV
LABELV $717
line 1429
;1429:		level.voteNo++;
ADDRLP4 68
ADDRGP4 level+2432
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1430
;1430:		trap_SetConfigstring( CS_VOTE_NO, va("%i", level.voteNo ) );	
ADDRGP4 $700
ARGP4
ADDRGP4 level+2432
INDIRI4
ARGI4
ADDRLP4 72
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 11
ARGI4
ADDRLP4 72
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1431
;1431:	}
LABELV $718
line 1435
;1432:
;1433:	// a majority will be determined in CheckVote, which will also account
;1434:	// for players entering or leaving
;1435:}
LABELV $705
endproc Cmd_Vote_f 76 12
export Cmd_CallTeamVote_f
proc Cmd_CallTeamVote_f 2164 20
line 1442
;1436:
;1437:/*
;1438:==================
;1439:Cmd_CallTeamVote_f
;1440:==================
;1441:*/
;1442:void Cmd_CallTeamVote_f( gentity_t *ent ) {
line 1447
;1443:	int		i, team, cs_offset;
;1444:	char	arg1[MAX_STRING_TOKENS];
;1445:	char	arg2[MAX_STRING_TOKENS];
;1446:
;1447:	if (g_gametype.integer < GT_TEAM) return;	// JUHOX
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
GEI4 $728
ADDRGP4 $727
JUMPV
LABELV $728
line 1448
;1448:	team = ent->client->sess.sessionTeam;
ADDRLP4 1028
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
ASGNI4
line 1449
;1449:	if ( team == TEAM_RED )
ADDRLP4 1028
INDIRI4
CNSTI4 1
NEI4 $731
line 1450
;1450:		cs_offset = 0;
ADDRLP4 1032
CNSTI4 0
ASGNI4
ADDRGP4 $732
JUMPV
LABELV $731
line 1451
;1451:	else if ( team == TEAM_BLUE )
ADDRLP4 1028
INDIRI4
CNSTI4 2
NEI4 $727
line 1452
;1452:		cs_offset = 1;
ADDRLP4 1032
CNSTI4 1
ASGNI4
line 1454
;1453:	else
;1454:		return;
LABELV $734
LABELV $732
line 1456
;1455:
;1456:	if ( !g_allowVote.integer ) {
ADDRGP4 g_allowVote+12
INDIRI4
CNSTI4 0
NEI4 $735
line 1457
;1457:		trap_SendServerCommand( ent-g_entities, "print \"Voting not allowed here.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRGP4 $558
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1458
;1458:		return;
ADDRGP4 $727
JUMPV
LABELV $735
line 1461
;1459:	}
;1460:
;1461:	if ( level.teamVoteTime[cs_offset] ) {
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+4488
ADDP4
INDIRI4
CNSTI4 0
EQI4 $738
line 1462
;1462:		trap_SendServerCommand( ent-g_entities, "print \"A team vote is already in progress.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRGP4 $741
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1463
;1463:		return;
ADDRGP4 $727
JUMPV
LABELV $738
line 1465
;1464:	}
;1465:	if ( ent->client->pers.teamVoteCount >= MAX_VOTE_COUNT ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 608
ADDP4
INDIRI4
CNSTI4 3
LTI4 $742
line 1466
;1466:		trap_SendServerCommand( ent-g_entities, "print \"You have called the maximum number of team votes.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRGP4 $744
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1467
;1467:		return;
ADDRGP4 $727
JUMPV
LABELV $742
line 1469
;1468:	}
;1469:	if ( ent->client->sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 3
NEI4 $745
line 1470
;1470:		trap_SendServerCommand( ent-g_entities, "print \"Not allowed to call a vote as spectator.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRGP4 $568
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1471
;1471:		return;
ADDRGP4 $727
JUMPV
LABELV $745
line 1475
;1472:	}
;1473:
;1474:	// make sure it is a valid command to vote on
;1475:	trap_Argv( 1, arg1, sizeof( arg1 ) );
CNSTI4 1
ARGI4
ADDRLP4 1036
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1476
;1476:	arg2[0] = '\0';
ADDRLP4 4
CNSTI1 0
ASGNI1
line 1477
;1477:	for ( i = 2; i < trap_Argc(); i++ ) {
ADDRLP4 0
CNSTI4 2
ASGNI4
ADDRGP4 $750
JUMPV
LABELV $747
line 1478
;1478:		if (i > 2)
ADDRLP4 0
INDIRI4
CNSTI4 2
LEI4 $751
line 1479
;1479:			strcat(arg2, " ");
ADDRLP4 4
ARGP4
ADDRGP4 $753
ARGP4
ADDRGP4 strcat
CALLP4
pop
LABELV $751
line 1480
;1480:		trap_Argv( i, &arg2[strlen(arg2)], sizeof( arg2 ) - strlen(arg2) );
ADDRLP4 4
ARGP4
ADDRLP4 2060
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
ARGP4
ADDRLP4 2064
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 2060
INDIRI4
ADDRLP4 4
ADDP4
ARGP4
CNSTU4 1024
ADDRLP4 2064
INDIRI4
CVIU4 4
SUBU4
CVUI4 4
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1481
;1481:	}
LABELV $748
line 1477
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $750
ADDRLP4 2060
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 2060
INDIRI4
LTI4 $747
line 1483
;1482:
;1483:	if( strchr( arg1, ';' ) || strchr( arg2, ';' ) ) {
ADDRLP4 1036
ARGP4
CNSTI4 59
ARGI4
ADDRLP4 2064
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 2064
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $756
ADDRLP4 4
ARGP4
CNSTI4 59
ARGI4
ADDRLP4 2068
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 2068
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $754
LABELV $756
line 1484
;1484:		trap_SendServerCommand( ent-g_entities, "print \"Invalid vote string.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRGP4 $574
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1485
;1485:		return;
ADDRGP4 $727
JUMPV
LABELV $754
line 1488
;1486:	}
;1487:
;1488:	if ( !Q_stricmp( arg1, "leader" ) ) {
ADDRLP4 1036
ARGP4
ADDRGP4 $759
ARGP4
ADDRLP4 2072
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2072
INDIRI4
CNSTI4 0
NEI4 $757
line 1491
;1489:		char netname[MAX_NETNAME], leader[MAX_NETNAME];
;1490:
;1491:		if ( !arg2[0] ) {
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $760
line 1492
;1492:			i = ent->client->ps.clientNum;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 1493
;1493:		}
ADDRGP4 $761
JUMPV
LABELV $760
line 1494
;1494:		else {
line 1496
;1495:			// numeric values are just slot numbers
;1496:			for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $762
line 1497
;1497:				if ( !arg2[i] || arg2[i] < '0' || arg2[i] > '9' )
ADDRLP4 2148
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 2148
INDIRI4
CNSTI4 0
EQI4 $769
ADDRLP4 2148
INDIRI4
CNSTI4 48
LTI4 $769
ADDRLP4 2148
INDIRI4
CNSTI4 57
LEI4 $766
LABELV $769
line 1498
;1498:					break;
ADDRGP4 $764
JUMPV
LABELV $766
line 1499
;1499:			}
LABELV $763
line 1496
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $762
LABELV $764
line 1500
;1500:			if ( i >= 3 || !arg2[i]) {
ADDRLP4 0
INDIRI4
CNSTI4 3
GEI4 $772
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $770
LABELV $772
line 1501
;1501:				i = atoi( arg2 );
ADDRLP4 4
ARGP4
ADDRLP4 2152
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 2152
INDIRI4
ASGNI4
line 1502
;1502:				if ( i < 0 || i >= level.maxclients ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $776
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $773
LABELV $776
line 1503
;1503:					trap_SendServerCommand( ent-g_entities, va("print \"Bad client slot: %i\n\"", i) );
ADDRGP4 $153
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 2160
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRLP4 2160
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1504
;1504:					return;
ADDRGP4 $727
JUMPV
LABELV $773
line 1507
;1505:				}
;1506:
;1507:				if ( !g_entities[i].inuse ) {
ADDRLP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $771
line 1508
;1508:					trap_SendServerCommand( ent-g_entities, va("print \"Client %i is not active\n\"", i) );
ADDRGP4 $156
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 2160
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRLP4 2160
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1509
;1509:					return;
ADDRGP4 $727
JUMPV
line 1511
;1510:				}
;1511:			}
LABELV $770
line 1512
;1512:			else {
line 1513
;1513:				Q_strncpyz(leader, arg2, sizeof(leader));
ADDRLP4 2112
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1514
;1514:				Q_CleanStr(leader);
ADDRLP4 2112
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 1515
;1515:				for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $783
JUMPV
LABELV $780
line 1516
;1516:					if ( level.clients[i].pers.connected == CON_DISCONNECTED )
ADDRLP4 0
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 0
NEI4 $785
line 1517
;1517:						continue;
ADDRGP4 $781
JUMPV
LABELV $785
line 1518
;1518:					if (level.clients[i].sess.sessionTeam != team)
ADDRLP4 0
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 696
ADDP4
INDIRI4
ADDRLP4 1028
INDIRI4
EQI4 $787
line 1519
;1519:						continue;
ADDRGP4 $781
JUMPV
LABELV $787
line 1520
;1520:					Q_strncpyz(netname, level.clients[i].pers.netname, sizeof(netname));
ADDRLP4 2076
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 512
ADDP4
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1521
;1521:					Q_CleanStr(netname);
ADDRLP4 2076
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 1522
;1522:					if ( !Q_stricmp(netname, leader) ) {
ADDRLP4 2076
ARGP4
ADDRLP4 2112
ARGP4
ADDRLP4 2152
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2152
INDIRI4
CNSTI4 0
NEI4 $789
line 1523
;1523:						break;
ADDRGP4 $782
JUMPV
LABELV $789
line 1525
;1524:					}
;1525:				}
LABELV $781
line 1515
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $783
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $780
LABELV $782
line 1526
;1526:				if ( i >= level.maxclients ) {
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $791
line 1527
;1527:					trap_SendServerCommand( ent-g_entities, va("print \"%s is not a valid player on your team.\n\"", arg2) );
ADDRGP4 $794
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 2152
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRLP4 2152
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1528
;1528:					return;
ADDRGP4 $727
JUMPV
LABELV $791
line 1530
;1529:				}
;1530:			}
LABELV $771
line 1531
;1531:		}
LABELV $761
line 1532
;1532:		Com_sprintf(arg2, sizeof(arg2), "%d", i);
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $261
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1535
;1533:	// JUHOX: support 'callteamvote surrender'
;1534:#if 1
;1535:	} else if (!Q_stricmp(arg1, "surrender")) {
ADDRGP4 $758
JUMPV
LABELV $757
ADDRLP4 1036
ARGP4
ADDRGP4 $797
ARGP4
ADDRLP4 2076
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2076
INDIRI4
CNSTI4 0
NEI4 $795
line 1536
;1536:		strcpy(arg2, "this round");
ADDRLP4 4
ARGP4
ADDRGP4 $798
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1538
;1537:#endif
;1538:	} else {
ADDRGP4 $796
JUMPV
LABELV $795
line 1539
;1539:		trap_SendServerCommand( ent-g_entities, "print \"Invalid vote string.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRGP4 $574
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1540
;1540:		trap_SendServerCommand( ent-g_entities, "print \"Team vote commands are: leader <player>.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRGP4 $799
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1541
;1541:		return;
ADDRGP4 $727
JUMPV
LABELV $796
LABELV $758
line 1544
;1542:	}
;1543:
;1544:	Com_sprintf( level.teamVoteString[cs_offset], sizeof( level.teamVoteString[cs_offset] ), "%s %s", arg1, arg2 );
ADDRLP4 1032
INDIRI4
CNSTI4 10
LSHI4
ADDRGP4 level+2440
ADDP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $627
ARGP4
ADDRLP4 1036
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1546
;1545:
;1546:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $805
JUMPV
LABELV $802
line 1547
;1547:		if ( level.clients[i].pers.connected == CON_DISCONNECTED )
ADDRLP4 0
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 0
NEI4 $807
line 1548
;1548:			continue;
ADDRGP4 $803
JUMPV
LABELV $807
line 1549
;1549:		if (level.clients[i].sess.sessionTeam == team)
ADDRLP4 0
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 696
ADDP4
INDIRI4
ADDRLP4 1028
INDIRI4
NEI4 $809
line 1550
;1550:			trap_SendServerCommand( i, va("print \"%s called a team vote.\n\"", ent->client->pers.netname ) );
ADDRGP4 $811
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 2080
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 2080
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
LABELV $809
line 1551
;1551:	}
LABELV $803
line 1546
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $805
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $802
line 1554
;1552:
;1553:	// start the voting, the caller autoamtically votes yes
;1554:	level.teamVoteTime[cs_offset] = level.time;
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+4488
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1555
;1555:	level.teamVoteYes[cs_offset] = 1;
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+4496
ADDP4
CNSTI4 1
ASGNI4
line 1556
;1556:	level.teamVoteNo[cs_offset] = 0;
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+4504
ADDP4
CNSTI4 0
ASGNI4
line 1558
;1557:
;1558:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $819
JUMPV
LABELV $816
line 1559
;1559:		if (level.clients[i].sess.sessionTeam == team)
ADDRLP4 0
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 696
ADDP4
INDIRI4
ADDRLP4 1028
INDIRI4
NEI4 $821
line 1560
;1560:			level.clients[i].ps.eFlags &= ~EF_TEAMVOTED;
ADDRLP4 2080
ADDRLP4 0
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 2080
INDIRP4
ADDRLP4 2080
INDIRP4
INDIRI4
CNSTI4 -3
BANDI4
ASGNI4
LABELV $821
line 1561
;1561:	}
LABELV $817
line 1558
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $819
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $816
line 1562
;1562:	ent->client->ps.eFlags |= EF_TEAMVOTED;
ADDRLP4 2080
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 2080
INDIRP4
ADDRLP4 2080
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 1564
;1563:
;1564:	trap_SetConfigstring( CS_TEAMVOTE_TIME + cs_offset, va("%i", level.teamVoteTime[cs_offset] ) );
ADDRGP4 $700
ARGP4
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+4488
ADDP4
INDIRI4
ARGI4
ADDRLP4 2084
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1032
INDIRI4
CNSTI4 12
ADDI4
ARGI4
ADDRLP4 2084
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1565
;1565:	trap_SetConfigstring( CS_TEAMVOTE_STRING + cs_offset, level.teamVoteString[cs_offset] );
ADDRLP4 1032
INDIRI4
CNSTI4 14
ADDI4
ARGI4
ADDRLP4 1032
INDIRI4
CNSTI4 10
LSHI4
ADDRGP4 level+2440
ADDP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1566
;1566:	trap_SetConfigstring( CS_TEAMVOTE_YES + cs_offset, va("%i", level.teamVoteYes[cs_offset] ) );
ADDRGP4 $700
ARGP4
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+4496
ADDP4
INDIRI4
ARGI4
ADDRLP4 2092
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1032
INDIRI4
CNSTI4 16
ADDI4
ARGI4
ADDRLP4 2092
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1567
;1567:	trap_SetConfigstring( CS_TEAMVOTE_NO + cs_offset, va("%i", level.teamVoteNo[cs_offset] ) );
ADDRGP4 $700
ARGP4
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+4504
ADDP4
INDIRI4
ARGI4
ADDRLP4 2096
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1032
INDIRI4
CNSTI4 18
ADDI4
ARGI4
ADDRLP4 2096
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1568
;1568:}
LABELV $727
endproc Cmd_CallTeamVote_f 2164 20
export Cmd_TeamVote_f
proc Cmd_TeamVote_f 84 12
line 1575
;1569:
;1570:/*
;1571:==================
;1572:Cmd_TeamVote_f
;1573:==================
;1574:*/
;1575:void Cmd_TeamVote_f( gentity_t *ent ) {
line 1579
;1576:	int			team, cs_offset;
;1577:	char		msg[64];
;1578:
;1579:	team = ent->client->sess.sessionTeam;
ADDRLP4 68
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
ASGNI4
line 1580
;1580:	if ( team == TEAM_RED )
ADDRLP4 68
INDIRI4
CNSTI4 1
NEI4 $828
line 1581
;1581:		cs_offset = 0;
ADDRLP4 64
CNSTI4 0
ASGNI4
ADDRGP4 $829
JUMPV
LABELV $828
line 1582
;1582:	else if ( team == TEAM_BLUE )
ADDRLP4 68
INDIRI4
CNSTI4 2
NEI4 $827
line 1583
;1583:		cs_offset = 1;
ADDRLP4 64
CNSTI4 1
ASGNI4
line 1585
;1584:	else
;1585:		return;
LABELV $831
LABELV $829
line 1587
;1586:
;1587:	if ( !level.teamVoteTime[cs_offset] ) {
ADDRLP4 64
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+4488
ADDP4
INDIRI4
CNSTI4 0
NEI4 $832
line 1588
;1588:		trap_SendServerCommand( ent-g_entities, "print \"No team vote in progress.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRGP4 $835
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1589
;1589:		return;
ADDRGP4 $827
JUMPV
LABELV $832
line 1591
;1590:	}
;1591:	if ( ent->client->ps.eFlags & EF_TEAMVOTED ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $836
line 1592
;1592:		trap_SendServerCommand( ent-g_entities, "print \"Team vote already cast.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRGP4 $838
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1593
;1593:		return;
ADDRGP4 $827
JUMPV
LABELV $836
line 1595
;1594:	}
;1595:	if ( ent->client->sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 3
NEI4 $839
line 1596
;1596:		trap_SendServerCommand( ent-g_entities, "print \"Not allowed to vote as spectator.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRGP4 $715
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1597
;1597:		return;
ADDRGP4 $827
JUMPV
LABELV $839
line 1600
;1598:	}
;1599:
;1600:	trap_SendServerCommand( ent-g_entities, "print \"Team vote cast.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRGP4 $841
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1602
;1601:
;1602:	ent->client->ps.eFlags |= EF_TEAMVOTED;
ADDRLP4 72
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 1604
;1603:
;1604:	trap_Argv( 1, msg, sizeof( msg ) );
CNSTI4 1
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1606
;1605:
;1606:	if ( msg[0] == 'y' || msg[1] == 'Y' || msg[1] == '1' ) {
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 121
EQI4 $847
ADDRLP4 0+1
INDIRI1
CVII4 1
CNSTI4 89
EQI4 $847
ADDRLP4 0+1
INDIRI1
CVII4 1
CNSTI4 49
NEI4 $842
LABELV $847
line 1607
;1607:		level.teamVoteYes[cs_offset]++;
ADDRLP4 76
ADDRLP4 64
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+4496
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1608
;1608:		trap_SetConfigstring( CS_TEAMVOTE_YES + cs_offset, va("%i", level.teamVoteYes[cs_offset] ) );
ADDRGP4 $700
ARGP4
ADDRLP4 64
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+4496
ADDP4
INDIRI4
ARGI4
ADDRLP4 80
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 64
INDIRI4
CNSTI4 16
ADDI4
ARGI4
ADDRLP4 80
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1609
;1609:	} else {
ADDRGP4 $843
JUMPV
LABELV $842
line 1610
;1610:		level.teamVoteNo[cs_offset]++;
ADDRLP4 76
ADDRLP4 64
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+4504
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1611
;1611:		trap_SetConfigstring( CS_TEAMVOTE_NO + cs_offset, va("%i", level.teamVoteNo[cs_offset] ) );	
ADDRGP4 $700
ARGP4
ADDRLP4 64
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+4504
ADDP4
INDIRI4
ARGI4
ADDRLP4 80
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 64
INDIRI4
CNSTI4 18
ADDI4
ARGI4
ADDRLP4 80
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1612
;1612:	}
LABELV $843
line 1616
;1613:
;1614:	// a majority will be determined in TeamCheckVote, which will also account
;1615:	// for players entering or leaving
;1616:}
LABELV $827
endproc Cmd_TeamVote_f 84 12
export Cmd_SetViewpos_f
proc Cmd_SetViewpos_f 1064 12
line 1624
;1617:
;1618:
;1619:/*
;1620:=================
;1621:Cmd_SetViewpos_f
;1622:=================
;1623:*/
;1624:void Cmd_SetViewpos_f( gentity_t *ent ) {
line 1629
;1625:	vec3_t		origin, angles;
;1626:	char		buffer[MAX_TOKEN_CHARS];
;1627:	int			i;
;1628:
;1629:	if ( !g_cheats.integer ) {
ADDRGP4 g_cheats+12
INDIRI4
CNSTI4 0
NEI4 $853
line 1630
;1630:		trap_SendServerCommand( ent-g_entities, va("print \"Cheats are not enabled on this server.\n\""));
ADDRGP4 $124
ARGP4
ADDRLP4 1052
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRLP4 1052
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1631
;1631:		return;
ADDRGP4 $852
JUMPV
LABELV $853
line 1633
;1632:	}
;1633:	if ( trap_Argc() != 5 ) {
ADDRLP4 1052
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 5
EQI4 $856
line 1634
;1634:		trap_SendServerCommand( ent-g_entities, va("print \"usage: setviewpos x y z yaw\n\""));
ADDRGP4 $858
ARGP4
ADDRLP4 1056
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRLP4 1056
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1635
;1635:		return;
ADDRGP4 $852
JUMPV
LABELV $856
line 1638
;1636:	}
;1637:
;1638:	VectorClear( angles );
ADDRLP4 1056
CNSTF4 0
ASGNF4
ADDRLP4 1040+8
ADDRLP4 1056
INDIRF4
ASGNF4
ADDRLP4 1040+4
ADDRLP4 1056
INDIRF4
ASGNF4
ADDRLP4 1040
ADDRLP4 1056
INDIRF4
ASGNF4
line 1639
;1639:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $861
line 1640
;1640:		trap_Argv( i + 1, buffer, sizeof( buffer ) );
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1641
;1641:		origin[i] = atof( buffer );
ADDRLP4 4
ARGP4
ADDRLP4 1060
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1028
ADDP4
ADDRLP4 1060
INDIRF4
ASGNF4
line 1642
;1642:	}
LABELV $862
line 1639
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $861
line 1644
;1643:
;1644:	trap_Argv( 4, buffer, sizeof( buffer ) );
CNSTI4 4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1645
;1645:	angles[YAW] = atof( buffer );
ADDRLP4 4
ARGP4
ADDRLP4 1060
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 1040+4
ADDRLP4 1060
INDIRF4
ASGNF4
line 1647
;1646:
;1647:	TeleportPlayer( ent, origin, angles );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1028
ARGP4
ADDRLP4 1040
ARGP4
ADDRGP4 TeleportPlayer
CALLV
pop
line 1648
;1648:}
LABELV $852
endproc Cmd_SetViewpos_f 1064 12
export Cmd_Stats_f
proc Cmd_Stats_f 0 0
line 1657
;1649:
;1650:
;1651:
;1652:/*
;1653:=================
;1654:Cmd_Stats_f
;1655:=================
;1656:*/
;1657:void Cmd_Stats_f( gentity_t *ent ) {
line 1672
;1658:/*
;1659:	int max, n, i;
;1660:
;1661:	max = trap_AAS_PointReachabilityAreaIndex( NULL );
;1662:
;1663:	n = 0;
;1664:	for ( i = 0; i < max; i++ ) {
;1665:		if ( ent->client->areabits[i >> 3] & (1 << (i & 7)) )
;1666:			n++;
;1667:	}
;1668:
;1669:	//trap_SendServerCommand( ent-g_entities, va("print \"visited %d of %d areas\n\"", n, max));
;1670:	trap_SendServerCommand( ent-g_entities, va("print \"%d%% level coverage\n\"", n * 100 / max));
;1671:*/
;1672:}
LABELV $866
endproc Cmd_Stats_f 0 0
proc Cmd_ToggleView_f 8 8
line 1680
;1673:
;1674:/*
;1675:=================
;1676:JUHOX: Cmd_ToggleView_f
;1677:=================
;1678:*/
;1679:#if SPECIAL_VIEW_MODES
;1680:static void Cmd_ToggleView_f(gentity_t* ent) {
line 1681
;1681:	if (!ent->client) return;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $868
ADDRGP4 $867
JUMPV
LABELV $868
line 1682
;1682:	if (level.intermissiontime) return;
ADDRGP4 level+9144
INDIRI4
CNSTI4 0
EQI4 $870
ADDRGP4 $867
JUMPV
LABELV $870
line 1683
;1683:	if (level.time < ent->client->viewModeSwitchTime + VIEWMODE_SWITCHING_TIME) {
ADDRGP4 level+32
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 5596
ADDP4
INDIRI4
CNSTI4 200
ADDI4
GEI4 $873
line 1684
;1684:		if (ent->client->numPendingViewToggles < VIEW_num_modes - 1) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 5600
ADDP4
INDIRI4
CNSTI4 2
GEI4 $867
line 1685
;1685:			ent->client->numPendingViewToggles++;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 5600
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1686
;1686:		}
line 1687
;1687:		return;
ADDRGP4 $867
JUMPV
LABELV $873
line 1690
;1688:	}
;1689:
;1690:	ent->client->viewMode++;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 5592
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1691
;1691:	if (ent->client->viewMode >= VIEW_num_modes) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 5592
ADDP4
INDIRI4
CNSTI4 3
LTI4 $878
line 1692
;1692:		ent->client->viewMode = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 5592
ADDP4
CNSTI4 0
ASGNI4
line 1693
;1693:	}
LABELV $878
line 1694
;1694:	ent->client->viewModeSwitchTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 5596
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1696
;1695:
;1696:	trap_SendServerCommand(ent->s.clientNum, va("viewmode %d", ent->client->viewMode));
ADDRGP4 $881
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 5592
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1697
;1697:}
LABELV $867
endproc Cmd_ToggleView_f 8 8
proc Cmd_DropHealth_f 0 4
line 1705
;1698:#endif
;1699:
;1700:/*
;1701:=================
;1702:JUHOX: Cmd_DropHealth_f
;1703:=================
;1704:*/
;1705:static void Cmd_DropHealth_f(gentity_t* ent) {
line 1706
;1706:	if (!ent->client) return;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $883
ADDRGP4 $882
JUMPV
LABELV $883
line 1707
;1707:	if (ent->client->sess.sessionTeam == TEAM_SPECTATOR) return;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 3
NEI4 $885
ADDRGP4 $882
JUMPV
LABELV $885
line 1708
;1708:	if (ent->health <= 5) return;
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 5
GTI4 $887
ADDRGP4 $882
JUMPV
LABELV $887
line 1710
;1709:
;1710:	DropHealth(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 DropHealth
CALLV
pop
line 1711
;1711:}
LABELV $882
endproc Cmd_DropHealth_f 0 4
proc Cmd_DropArmor_f 0 4
line 1718
;1712:
;1713:/*
;1714:=================
;1715:JUHOX: Cmd_DropArmor_f
;1716:=================
;1717:*/
;1718:static void Cmd_DropArmor_f(gentity_t* ent) {
line 1719
;1719:	if (!ent->client) return;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $890
ADDRGP4 $889
JUMPV
LABELV $890
line 1720
;1720:	if (ent->client->sess.sessionTeam == TEAM_SPECTATOR) return;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 3
NEI4 $892
ADDRGP4 $889
JUMPV
LABELV $892
line 1721
;1721:	if (ent->health <= 5) return;
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 5
GTI4 $894
ADDRGP4 $889
JUMPV
LABELV $894
line 1723
;1722:
;1723:	DropArmor(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 DropArmor
CALLV
pop
line 1724
;1724:}
LABELV $889
endproc Cmd_DropArmor_f 0 4
proc Cmd_ThrowHook_f 20 12
line 1731
;1725:
;1726:/*
;1727:=================
;1728:JUHOX: Cmd_ThrowHook_f
;1729:=================
;1730:*/
;1731:static void Cmd_ThrowHook_f(gentity_t* ent) {
line 1732
;1732:	if (!ent->client) return;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $897
ADDRGP4 $896
JUMPV
LABELV $897
line 1733
;1733:	if (ent->client->sess.sessionTeam == TEAM_SPECTATOR) return;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 3
NEI4 $899
ADDRGP4 $896
JUMPV
LABELV $899
line 1734
;1734:	if (ent->health <= 0) return;
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
GTI4 $901
ADDRGP4 $896
JUMPV
LABELV $901
line 1736
;1735:
;1736:	if (trap_Argc() >= 2) {
ADDRLP4 0
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LTI4 $903
line 1739
;1737:		char buf[8];
;1738:
;1739:		trap_Argv(1, buf, sizeof(buf));
CNSTI4 1
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 8
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1740
;1740:		switch (buf[0]) {
ADDRLP4 12
ADDRLP4 4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 43
EQI4 $908
ADDRLP4 12
INDIRI4
CNSTI4 45
EQI4 $911
ADDRGP4 $904
JUMPV
LABELV $908
line 1742
;1741:		case '+':
;1742:			if (!ent->client->hook) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 884
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $904
line 1743
;1743:				Weapon_GrapplingHook_Throw(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Weapon_GrapplingHook_Throw
CALLV
pop
line 1744
;1744:			}
line 1745
;1745:			break;
ADDRGP4 $904
JUMPV
LABELV $911
line 1747
;1746:		case '-':
;1747:			if (ent->client->hook) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 884
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $904
line 1748
;1748:				Weapon_GrapplingHook_Throw(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Weapon_GrapplingHook_Throw
CALLV
pop
line 1749
;1749:			}
line 1750
;1750:			break;
line 1752
;1751:		}
;1752:	}
ADDRGP4 $904
JUMPV
LABELV $903
line 1753
;1753:	else {
line 1755
;1754:		// toggle hook
;1755:		Weapon_GrapplingHook_Throw(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Weapon_GrapplingHook_Throw
CALLV
pop
line 1756
;1756:	}
LABELV $904
line 1757
;1757:}
LABELV $896
endproc Cmd_ThrowHook_f 20 12
proc Cmd_NavAid_f 28 12
line 1764
;1758:
;1759:/*
;1760:=================
;1761:JUHOX: Cmd_NavAid_f
;1762:=================
;1763:*/
;1764:static void Cmd_NavAid_f(gentity_t* ent) {
line 1765
;1765:	if (!ent->client) return;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $915
ADDRGP4 $914
JUMPV
LABELV $915
line 1766
;1766:	if (g_gametype.integer < GT_TEAM) return;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
GEI4 $917
ADDRGP4 $914
JUMPV
LABELV $917
line 1768
;1767:
;1768:	if (trap_Argc() == 2) {
ADDRLP4 0
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
NEI4 $920
line 1771
;1769:		char buf[16];
;1770:
;1771:		trap_Argv(1, buf, sizeof(buf));
CNSTI4 1
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1772
;1772:		BG_TSS_SetPlayerInfo(&ent->client->ps, TSSPI_navAid, atoi(buf) != 0);
ADDRLP4 4
ARGP4
ADDRLP4 24
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $923
ADDRLP4 20
CNSTI4 1
ASGNI4
ADDRGP4 $924
JUMPV
LABELV $923
ADDRLP4 20
CNSTI4 0
ASGNI4
LABELV $924
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
CNSTI4 11
ARGI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRGP4 BG_TSS_SetPlayerInfo
CALLV
pop
line 1773
;1773:	}
ADDRGP4 $921
JUMPV
LABELV $920
line 1774
;1774:	else {
line 1775
;1775:		if (!BG_TSS_GetPlayerInfo(&ent->client->ps, TSSPI_isValid)) return;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 4
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $925
ADDRGP4 $914
JUMPV
LABELV $925
line 1776
;1776:		BG_TSS_SetPlayerInfo(
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
CNSTI4 11
ARGI4
ADDRLP4 8
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
CNSTI4 11
ARGI4
ADDRLP4 8
INDIRI4
CNSTI4 1
BXORI4
ARGI4
ADDRGP4 BG_TSS_SetPlayerInfo
CALLV
pop
line 1780
;1777:			&ent->client->ps, TSSPI_navAid,
;1778:			BG_TSS_GetPlayerInfo(&ent->client->ps, TSSPI_navAid) ^ 1
;1779:		);
;1780:	}
LABELV $921
line 1781
;1781:}
LABELV $914
endproc Cmd_NavAid_f 28 12
export Cmd_GroupFormation_f
proc Cmd_GroupFormation_f 72 12
line 1788
;1782:
;1783:/*
;1784:=================
;1785:JUHOX: Cmd_GroupFormation_f
;1786:=================
;1787:*/
;1788:void Cmd_GroupFormation_f(gentity_t* ent) {
line 1793
;1789:	int group;
;1790:	tss_serverdata_t* tss;
;1791:	char arg[16];
;1792:
;1793:	if (trap_Argc() < 2) return;
ADDRLP4 24
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 2
GEI4 $928
ADDRGP4 $927
JUMPV
LABELV $928
line 1794
;1794:	if (!ent->client) return;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $930
ADDRGP4 $927
JUMPV
LABELV $930
line 1795
;1795:	if (g_gametype.integer < GT_TEAM) return;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
GEI4 $932
ADDRGP4 $927
JUMPV
LABELV $932
line 1797
;1796:
;1797:	switch (ent->client->sess.sessionTeam) {
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 1
EQI4 $938
ADDRLP4 28
INDIRI4
CNSTI4 2
EQI4 $940
ADDRGP4 $927
JUMPV
LABELV $938
line 1799
;1798:	case TEAM_RED:
;1799:		tss = &level.redTSS;
ADDRLP4 4
ADDRGP4 level+9268
ASGNP4
line 1800
;1800:		break;
ADDRGP4 $936
JUMPV
LABELV $940
line 1802
;1801:	case TEAM_BLUE:
;1802:		tss = &level.blueTSS;
ADDRLP4 4
ADDRGP4 level+9984
ASGNP4
line 1803
;1803:		break;
line 1805
;1804:	default:
;1805:		return;
LABELV $936
line 1807
;1806:	}
;1807:	if (!tss->isValid) return;
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $942
ADDRGP4 $927
JUMPV
LABELV $942
line 1808
;1808:	if (!BG_TSS_GetPlayerInfo(&ent->client->ps, TSSPI_isValid)) return;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 36
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $944
ADDRGP4 $927
JUMPV
LABELV $944
line 1809
;1809:	group = BG_TSS_GetPlayerInfo(&ent->client->ps, TSSPI_group);
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 40
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 40
INDIRI4
ASGNI4
line 1810
;1810:	if (group < 0 || group >= MAX_GROUPS) return;
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $948
ADDRLP4 0
INDIRI4
CNSTI4 10
LTI4 $946
LABELV $948
ADDRGP4 $927
JUMPV
LABELV $946
line 1811
;1811:	switch (BG_TSS_GetPlayerInfo(&ent->client->ps, TSSPI_groupMemberStatus)) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 52
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 48
ADDRLP4 52
INDIRI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 3
EQI4 $952
ADDRLP4 48
INDIRI4
CNSTI4 4
EQI4 $952
ADDRGP4 $949
JUMPV
LABELV $952
line 1814
;1812:	case TSSGMS_designatedLeader:
;1813:	case TSSGMS_temporaryLeader:
;1814:		trap_Argv(1, arg, sizeof(arg));
CNSTI4 1
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1815
;1815:		if (!Q_stricmp(arg, "tight")) {
ADDRLP4 8
ARGP4
ADDRGP4 $955
ARGP4
ADDRLP4 60
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
NEI4 $953
line 1816
;1816:			tss->groupFormation[group] = TSSGF_tight;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
ADDP4
CNSTI4 0
ASGNI4
line 1817
;1817:		}
ADDRGP4 $954
JUMPV
LABELV $953
line 1818
;1818:		else if (!Q_stricmp(arg, "loose")) {
ADDRLP4 8
ARGP4
ADDRGP4 $958
ARGP4
ADDRLP4 64
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
NEI4 $956
line 1819
;1819:			tss->groupFormation[group] = TSSGF_loose;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
ADDP4
CNSTI4 1
ASGNI4
line 1820
;1820:		}
ADDRGP4 $957
JUMPV
LABELV $956
line 1821
;1821:		else if (!Q_stricmp(arg, "free")) {
ADDRLP4 8
ARGP4
ADDRGP4 $961
ARGP4
ADDRLP4 68
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
NEI4 $959
line 1822
;1822:			tss->groupFormation[group] = TSSGF_free;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
ADDP4
CNSTI4 2
ASGNI4
line 1823
;1823:		}
LABELV $959
LABELV $957
LABELV $954
line 1825
;1824:		// instant feed back for the client
;1825:		BG_TSS_SetPlayerInfo(&ent->client->ps, TSSPI_groupFormation, tss->groupFormation[group]);
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
CNSTI4 6
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BG_TSS_SetPlayerInfo
CALLV
pop
line 1826
;1826:		break;
LABELV $949
LABELV $950
line 1828
;1827:	}
;1828:}
LABELV $927
endproc Cmd_GroupFormation_f 72 12
proc Cmd_TSSInstructions_f 1072 16
line 1835
;1829:
;1830:/*
;1831:=================
;1832:JUHOX: Cmd_TSSInstructions_f
;1833:=================
;1834:*/
;1835:static void Cmd_TSSInstructions_f(gentity_t* ent) {
line 1840
;1836:	tss_serverdata_t* tss;
;1837:	char cmd[1024];
;1838:	const char* buf;
;1839:
;1840:	if (g_gametype.integer < GT_TEAM) return;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
GEI4 $963
ADDRGP4 $962
JUMPV
LABELV $963
line 1841
;1841:	if (!g_tss.integer) return;
ADDRGP4 g_tss+12
INDIRI4
CNSTI4 0
NEI4 $966
ADDRGP4 $962
JUMPV
LABELV $966
line 1842
;1842:	if (trap_Argc() < 4) return;
ADDRLP4 1032
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 4
GEI4 $969
ADDRGP4 $962
JUMPV
LABELV $969
line 1843
;1843:	if (!ent->client) return;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $971
ADDRGP4 $962
JUMPV
LABELV $971
line 1844
;1844:	if (!ent->client->sess.teamLeader) return;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 720
ADDP4
INDIRI4
CNSTI4 0
NEI4 $973
ADDRGP4 $962
JUMPV
LABELV $973
line 1846
;1845:
;1846:	switch (ent->client->sess.sessionTeam) {
ADDRLP4 1036
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 1
EQI4 $978
ADDRLP4 1036
INDIRI4
CNSTI4 2
EQI4 $980
ADDRGP4 $962
JUMPV
LABELV $978
line 1848
;1847:	case TEAM_RED:
;1848:		tss = &level.redTSS;
ADDRLP4 1024
ADDRGP4 level+9268
ASGNP4
line 1849
;1849:		break;
ADDRGP4 $976
JUMPV
LABELV $980
line 1851
;1850:	case TEAM_BLUE:
;1851:		tss = &level.blueTSS;
ADDRLP4 1024
ADDRGP4 level+9984
ASGNP4
line 1852
;1852:		break;
line 1854
;1853:	default:
;1854:		return;
LABELV $976
line 1857
;1855:	}
;1856:
;1857:	trap_Argv(1, cmd, sizeof(cmd));
CNSTI4 1
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1858
;1858:	tss->rfa_dangerLimit = atoi(cmd);
ADDRLP4 0
ARGP4
ADDRLP4 1044
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1024
INDIRP4
CNSTI4 636
ADDP4
ADDRLP4 1044
INDIRI4
ASGNI4
line 1860
;1859:
;1860:	trap_Argv(2, cmd, sizeof(cmd));
CNSTI4 2
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1861
;1861:	tss->rfd_dangerLimit = atoi(cmd);
ADDRLP4 0
ARGP4
ADDRLP4 1048
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1024
INDIRP4
CNSTI4 640
ADDP4
ADDRLP4 1048
INDIRI4
ASGNI4
line 1863
;1862:
;1863:	trap_Argv(3, cmd, sizeof(cmd));
CNSTI4 3
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1864
;1864:	tss->short_term = atoi(cmd) * g_respawnDelay.integer * 10;
ADDRLP4 0
ARGP4
ADDRLP4 1052
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1024
INDIRP4
CNSTI4 644
ADDP4
ADDRLP4 1052
INDIRI4
ADDRGP4 g_respawnDelay+12
INDIRI4
MULI4
CNSTI4 10
MULI4
ASGNI4
line 1866
;1865:
;1866:	trap_Argv(4, cmd, sizeof(cmd));
CNSTI4 4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1867
;1867:	tss->medium_term = atoi(cmd) * g_respawnDelay.integer * 10;
ADDRLP4 0
ARGP4
ADDRLP4 1056
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1024
INDIRP4
CNSTI4 648
ADDP4
ADDRLP4 1056
INDIRI4
ADDRGP4 g_respawnDelay+12
INDIRI4
MULI4
CNSTI4 10
MULI4
ASGNI4
line 1869
;1868:
;1869:	trap_Argv(5, cmd, sizeof(cmd));
CNSTI4 5
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1870
;1870:	tss->long_term = atoi(cmd) * g_respawnDelay.integer * 10;
ADDRLP4 0
ARGP4
ADDRLP4 1060
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1024
INDIRP4
CNSTI4 652
ADDP4
ADDRLP4 1060
INDIRI4
ADDRGP4 g_respawnDelay+12
INDIRI4
MULI4
CNSTI4 10
MULI4
ASGNI4
line 1872
;1871:
;1872:	memset(&cmd, 0, sizeof(cmd));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1024
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1873
;1873:	trap_Argv(6, cmd, sizeof(cmd));
CNSTI4 6
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1874
;1874:	buf = cmd;
ADDRLP4 1028
ADDRLP4 0
ASGNP4
line 1875
;1875:	tss->isValid = TSS_DecodeInt(&buf, 0, 1);
ADDRLP4 1028
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 1064
ADDRGP4 TSS_DecodeInt
CALLI4
ASGNI4
ADDRLP4 1024
INDIRP4
ADDRLP4 1064
INDIRI4
ASGNI4
line 1876
;1876:	BG_TSS_DecodeInstructions(&buf, &tss->instructions);
ADDRLP4 1028
ARGP4
ADDRLP4 1024
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRGP4 BG_TSS_DecodeInstructions
CALLV
pop
line 1877
;1877:	BG_TSS_DecodeLeadership(
ADDRLP4 1028
ARGP4
ADDRLP4 1024
INDIRP4
CNSTI4 356
ADDP4
ARGP4
ADDRLP4 1024
INDIRP4
CNSTI4 396
ADDP4
ARGP4
ADDRLP4 1024
INDIRP4
CNSTI4 436
ADDP4
ARGP4
ADDRGP4 BG_TSS_DecodeLeadership
CALLV
pop
line 1883
;1878:		&buf,
;1879:		tss->designated1stLeaders,
;1880:		tss->designated2ndLeaders,
;1881:		tss->designated3rdLeaders
;1882:	);
;1883:	tss->lastUpdateTime = level.time;
ADDRLP4 1024
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1884
;1884:}
LABELV $962
endproc Cmd_TSSInstructions_f 1072 16
proc Cmd_TSSSafetyMode_f 20 8
line 1891
;1885:
;1886:/*
;1887:=================
;1888:JUHOX: Cmd_TSSSafetyMode_f
;1889:=================
;1890:*/
;1891:static void Cmd_TSSSafetyMode_f(gentity_t* ent) {
line 1892
;1892:	if (g_gametype.integer < GT_TEAM) return;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
GEI4 $987
ADDRGP4 $986
JUMPV
LABELV $987
line 1893
;1893:	if (!g_tssSafetyMode.integer) return;
ADDRGP4 g_tssSafetyMode+12
INDIRI4
CNSTI4 0
NEI4 $990
ADDRGP4 $986
JUMPV
LABELV $990
line 1894
;1894:	if (!ent->client) return;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $993
ADDRGP4 $986
JUMPV
LABELV $993
line 1895
;1895:	if (!ent->client->sess.teamLeader) return;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 720
ADDP4
INDIRI4
CNSTI4 0
NEI4 $995
ADDRGP4 $986
JUMPV
LABELV $995
line 1896
;1896:	if (ent->client->ps.stats[STAT_HEALTH] < ent->client->ps.stats[STAT_MAX_HEALTH]) return;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
GEI4 $997
ADDRGP4 $986
JUMPV
LABELV $997
line 1897
;1897:	if (ent->client->ps.weaponstate != WEAPON_READY) return;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 0
EQI4 $999
ADDRGP4 $986
JUMPV
LABELV $999
line 1899
;1898:	if (
;1899:		ent->client->sess.sessionTeam != TEAM_RED &&
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 1
EQI4 $1001
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 2
EQI4 $1001
line 1901
;1900:		ent->client->sess.sessionTeam != TEAM_BLUE
;1901:	) {
line 1902
;1902:		return;
ADDRGP4 $986
JUMPV
LABELV $1001
line 1905
;1903:	}
;1904:
;1905:	if (ent->client->tssSafetyMode) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 768
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1003
line 1906
;1906:		ent->client->tssSafetyMode = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 768
ADDP4
CNSTI4 0
ASGNI4
line 1907
;1907:		respawn(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 respawn
CALLV
pop
line 1908
;1908:	}
ADDRGP4 $1004
JUMPV
LABELV $1003
line 1909
;1909:	else {
line 1912
;1910:		gentity_t* tent;
;1911:
;1912:		TossClientItems(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 TossClientItems
CALLV
pop
line 1913
;1913:		tent = G_TempEntity(ent->client->ps.origin, EV_PLAYER_TELEPORT_OUT);
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
CNSTI4 43
ARGI4
ADDRLP4 12
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 12
INDIRP4
ASGNP4
line 1914
;1914:		if (tent) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1005
line 1915
;1915:			tent->s.clientNum = ent->s.clientNum;
ADDRLP4 8
INDIRP4
CNSTI4 168
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 1916
;1916:		}
LABELV $1005
line 1917
;1917:		ent->client->pers.lastUsedWeapon = ent->client->ps.weapon;
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 616
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ASGNI4
line 1918
;1918:		ent->client->ps.weapon = WP_NONE;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 144
ADDP4
CNSTI4 0
ASGNI4
line 1919
;1919:		ent->client->ps.stats[STAT_WEAPONS] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 0
ASGNI4
line 1920
;1920:		ent->client->tssSafetyMode = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 768
ADDP4
CNSTI4 1
ASGNI4
line 1921
;1921:	}
LABELV $1004
line 1922
;1922:	ent->client->ps.stats[STAT_HEALTH] = ent->client->ps.stats[STAT_MAX_HEALTH];
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
ASGNI4
line 1923
;1923:	ent->health = ent->client->ps.stats[STAT_MAX_HEALTH];
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 736
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
ASGNI4
line 1924
;1924:}
LABELV $986
endproc Cmd_TSSSafetyMode_f 20 8
proc Cmd_LFEMM_f 88 12
line 1956
;1925:
;1926:#if JUHOX_BOT_DEBUG
;1927:void BotTeamplayReport(void);
;1928:qboolean BotAI_DebugBot(int clientNum);
;1929:/*
;1930:=================
;1931:JUHOX: Cmd_BotDebug_f
;1932:=================
;1933:*/
;1934:static void Cmd_BotDebug_f(gentity_t* ent) {
;1935:	char arg[8];
;1936:
;1937:	if (trap_Argc() >= 2) {
;1938:		int clientNum;
;1939:
;1940:		trap_Argv(1, arg, sizeof(arg));
;1941:		clientNum = atoi(arg);
;1942:		if (!BotAI_DebugBot(clientNum)) {
;1943:			G_Printf("%d is not a bot\n", clientNum);
;1944:		}
;1945:	}
;1946:	BotTeamplayReport();
;1947:}
;1948:#endif
;1949:
;1950:/*
;1951:=================
;1952:JUHOX: Cmd_LFEMM_f
;1953:=================
;1954:*/
;1955:#if MAPLENSFLARES
;1956:static void Cmd_LFEMM_f(gentity_t* ent) {
line 1959
;1957:	char arg[16];
;1958:
;1959:	if (trap_Argc() < 2) return;
ADDRLP4 16
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 2
GEI4 $1008
ADDRGP4 $1007
JUMPV
LABELV $1008
line 1960
;1960:	if (g_editmode.integer != EM_mlf) return;
ADDRGP4 g_editmode+12
INDIRI4
CNSTI4 1
EQI4 $1010
ADDRGP4 $1007
JUMPV
LABELV $1010
line 1961
;1961:	if (ent->s.number != 0) return;
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $1013
ADDRGP4 $1007
JUMPV
LABELV $1013
line 1963
;1962:
;1963:	trap_Argv(1, arg, sizeof(arg));
CNSTI4 1
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1964
;1964:	level.lfeFMM = atoi(arg);
ADDRLP4 0
ARGP4
ADDRLP4 20
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 level+23056
ADDRLP4 20
INDIRI4
ASGNI4
line 1966
;1965:
;1966:	if (trap_Argc() >= 5) {
ADDRLP4 24
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 5
LTI4 $1016
line 1969
;1967:		vec3_t origin;
;1968:
;1969:		trap_Argv(2, arg, sizeof(arg));
CNSTI4 2
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1970
;1970:		origin[0] = atof(arg);
ADDRLP4 0
ARGP4
ADDRLP4 40
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 40
INDIRF4
ASGNF4
line 1971
;1971:		trap_Argv(3, arg, sizeof(arg));
CNSTI4 3
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1972
;1972:		origin[1] = atof(arg);
ADDRLP4 0
ARGP4
ADDRLP4 44
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 28+4
ADDRLP4 44
INDIRF4
ASGNF4
line 1973
;1973:		trap_Argv(4, arg, sizeof(arg));
CNSTI4 4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1974
;1974:		origin[2] = atof(arg);
ADDRLP4 0
ARGP4
ADDRLP4 48
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 28+8
ADDRLP4 48
INDIRF4
ASGNF4
line 1975
;1975:		G_SetOrigin(ent, origin);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 1976
;1976:		VectorCopy(origin, ent->client->ps.origin);
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 28
INDIRB
ASGNB 12
line 1977
;1977:		ent->client->ps.eFlags ^= EF_TELEPORT_BIT;
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
CNSTI4 4
BXORI4
ASGNI4
line 1979
;1978:
;1979:		if (trap_Argc() >= 8) {
ADDRLP4 56
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 8
LTI4 $1020
line 1982
;1980:			playerState_t* ps;
;1981:
;1982:			ps = &ent->client->ps;
ADDRLP4 60
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 1983
;1983:			trap_Argv(5, arg, sizeof(arg));
CNSTI4 5
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1984
;1984:			ps->delta_angles[0] += ANGLE2SHORT(atof(arg) - ps->viewangles[0]);
ADDRLP4 0
ARGP4
ADDRLP4 64
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 68
ADDRLP4 60
INDIRP4
CNSTI4 56
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRI4
ADDRLP4 64
INDIRF4
ADDRLP4 60
INDIRP4
CNSTI4 152
ADDP4
INDIRF4
SUBF4
CNSTF4 1127615329
MULF4
CVFI4 4
CNSTI4 65535
BANDI4
ADDI4
ASGNI4
line 1985
;1985:			trap_Argv(6, arg, sizeof(arg));
CNSTI4 6
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1986
;1986:			ps->delta_angles[1] += ANGLE2SHORT(atof(arg) - ps->viewangles[1]);
ADDRLP4 0
ARGP4
ADDRLP4 72
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 76
ADDRLP4 60
INDIRP4
CNSTI4 60
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
ADDRLP4 72
INDIRF4
ADDRLP4 60
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
SUBF4
CNSTF4 1127615329
MULF4
CVFI4 4
CNSTI4 65535
BANDI4
ADDI4
ASGNI4
line 1987
;1987:			trap_Argv(7, arg, sizeof(arg));
CNSTI4 7
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1988
;1988:			ps->delta_angles[2] += ANGLE2SHORT(atof(arg) - ps->viewangles[2]);
ADDRLP4 0
ARGP4
ADDRLP4 80
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 84
ADDRLP4 60
INDIRP4
CNSTI4 64
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
ADDRLP4 80
INDIRF4
ADDRLP4 60
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
SUBF4
CNSTF4 1127615329
MULF4
CVFI4 4
CNSTI4 65535
BANDI4
ADDI4
ASGNI4
line 1989
;1989:		}
LABELV $1020
line 1990
;1990:	}
LABELV $1016
line 1991
;1991:}
LABELV $1007
endproc Cmd_LFEMM_f 88 12
proc Cmd_TemplateList_Request_f 76 12
line 1999
;1992:#endif
;1993:
;1994:/*
;1995:=================
;1996:JUHOX: Cmd_TemplateList_Request_f
;1997:=================
;1998:*/
;1999:static void Cmd_TemplateList_Request_f(gentity_t* ent) {
line 2003
;2000:	char arg1[32];
;2001:	char arg2[32];
;2002:
;2003:	if (trap_Argc() != 3) return;
ADDRLP4 64
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 3
EQI4 $1023
ADDRGP4 $1022
JUMPV
LABELV $1023
line 2005
;2004:
;2005:	trap_Argv(1, arg1, sizeof(arg1));
CNSTI4 1
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 2006
;2006:	trap_Argv(2, arg2, sizeof(arg2));
CNSTI4 2
ARGI4
ADDRLP4 32
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 2007
;2007:	G_TemplateList_Request(ent->s.number, atoi(arg1), atoi(arg2));
ADDRLP4 0
ARGP4
ADDRLP4 68
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 32
ARGP4
ADDRLP4 72
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 68
INDIRI4
ARGI4
ADDRLP4 72
INDIRI4
ARGI4
ADDRGP4 G_TemplateList_Request
CALLV
pop
line 2008
;2008:}
LABELV $1022
endproc Cmd_TemplateList_Request_f 76 12
proc Cmd_TemplateList_Stop_f 0 4
line 2015
;2009:
;2010:/*
;2011:=================
;2012:JUHOX: Cmd_TemplateList_Stop_f
;2013:=================
;2014:*/
;2015:static void Cmd_TemplateList_Stop_f(gentity_t* ent) {
line 2016
;2016:	G_TemplateList_Stop(ent->s.number);
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 G_TemplateList_Stop
CALLV
pop
line 2017
;2017:}
LABELV $1025
endproc Cmd_TemplateList_Stop_f 0 4
proc Cmd_TemplateList_Error_f 1024 12
line 2024
;2018:
;2019:/*
;2020:=================
;2021:JUHOX: Cmd_TemplateList_Error_f
;2022:=================
;2023:*/
;2024:static void Cmd_TemplateList_Error_f(gentity_t* ent) {
line 2027
;2025:	char arg1[MAX_STRING_CHARS];
;2026:
;2027:	trap_Argv(1, arg1, sizeof(arg1));
CNSTI4 1
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 2028
;2028:	G_TemplateList_Error(ent->s.number, arg1);
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 G_TemplateList_Error
CALLV
pop
line 2029
;2029:}
LABELV $1026
endproc Cmd_TemplateList_Error_f 1024 12
proc Cmd_EFHDebugSeg_f 20 12
line 2037
;2030:
;2031:/*
;2032:=================
;2033:JUHOX: Cmd_EFHDebugSeg_f
;2034:=================
;2035:*/
;2036:#if ESCAPE_MODE
;2037:static void Cmd_EFHDebugSeg_f(gentity_t* ent) {
line 2040
;2038:	char arg1[16];
;2039:
;2040:	if (!g_debugEFH.integer) return;
ADDRGP4 g_debugEFH+12
INDIRI4
CNSTI4 0
NEI4 $1028
ADDRGP4 $1027
JUMPV
LABELV $1028
line 2042
;2041:
;2042:	trap_Argv(1, arg1, sizeof(arg1));
CNSTI4 1
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 2043
;2043:	G_EFH_NextDebugSegment(atoi(arg1));
ADDRLP4 0
ARGP4
ADDRLP4 16
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRGP4 G_EFH_NextDebugSegment
CALLV
pop
line 2044
;2044:}
LABELV $1027
endproc Cmd_EFHDebugSeg_f 20 12
export ClientCommand
proc ClientCommand 1172 12
line 2072
;2045:#endif
;2046:
;2047:/*
;2048:=================
;2049:JUHOX: Cmd_Stop_f
;2050:=================
;2051:*/
;2052:#if SCREENSHOT_TOOLS
;2053:void Cmd_Stop_f(gentity_t* ent) {
;2054:	if (ent->s.number != 0) return;
;2055:	if (ent->client->sess.sessionTeam != TEAM_SPECTATOR) return;
;2056:
;2057:	if (level.stopTime) {
;2058:		level.stopTime = 0;
;2059:	}
;2060:	else {
;2061:		level.stopTime = level.time;
;2062:	}
;2063:	trap_SetConfigstring(CS_STOPTIME, va("%d", level.stopTime));
;2064:}
;2065:#endif
;2066:
;2067:/*
;2068:=================
;2069:ClientCommand
;2070:=================
;2071:*/
;2072:void ClientCommand( int clientNum ) {
line 2076
;2073:	gentity_t *ent;
;2074:	char	cmd[MAX_TOKEN_CHARS];
;2075:
;2076:	ent = g_entities + clientNum;
ADDRLP4 1024
ADDRFP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 2077
;2077:	if ( !ent->client ) {
ADDRLP4 1024
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1032
line 2078
;2078:		return;		// not fully in game yet
ADDRGP4 $1031
JUMPV
LABELV $1032
line 2081
;2079:	}
;2080:
;2081:	trap_Argv( 0, cmd, sizeof( cmd ) );
CNSTI4 0
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 2084
;2082:
;2083:#if MAPLENSFLARES	// JUHOX: don't accept normal client commands in edit mode
;2084:	if (g_editmode.integer > EM_none) {
ADDRGP4 g_editmode+12
INDIRI4
CNSTI4 0
LEI4 $1034
line 2085
;2085:		if (!Q_stricmp(cmd, "lfemm")) {
ADDRLP4 0
ARGP4
ADDRGP4 $1039
ARGP4
ADDRLP4 1028
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 0
NEI4 $1031
line 2086
;2086:			Cmd_LFEMM_f(ent);
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_LFEMM_f
CALLV
pop
line 2087
;2087:		}
line 2088
;2088:		return;
ADDRGP4 $1031
JUMPV
LABELV $1034
line 2091
;2089:	}
;2090:#endif
;2091:	if (Q_stricmp (cmd, "say") == 0) {
ADDRLP4 0
ARGP4
ADDRGP4 $1042
ARGP4
ADDRLP4 1028
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 0
NEI4 $1040
line 2092
;2092:		Cmd_Say_f (ent, SAY_ALL, qfalse);
ADDRLP4 1024
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Cmd_Say_f
CALLV
pop
line 2093
;2093:		return;
ADDRGP4 $1031
JUMPV
LABELV $1040
line 2095
;2094:	}
;2095:	if (Q_stricmp (cmd, "say_team") == 0) {
ADDRLP4 0
ARGP4
ADDRGP4 $1045
ARGP4
ADDRLP4 1032
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 0
NEI4 $1043
line 2096
;2096:		Cmd_Say_f (ent, SAY_TEAM, qfalse);
ADDRLP4 1024
INDIRP4
ARGP4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Cmd_Say_f
CALLV
pop
line 2097
;2097:		return;
ADDRGP4 $1031
JUMPV
LABELV $1043
line 2099
;2098:	}
;2099:	if (Q_stricmp (cmd, "tell") == 0) {
ADDRLP4 0
ARGP4
ADDRGP4 $1048
ARGP4
ADDRLP4 1036
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
NEI4 $1046
line 2100
;2100:		Cmd_Tell_f ( ent );
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_Tell_f
CALLV
pop
line 2101
;2101:		return;
ADDRGP4 $1031
JUMPV
LABELV $1046
line 2133
;2102:	}
;2103:#if 0	// JUHOX: don't accept voice chat commands
;2104:	if (Q_stricmp (cmd, "vsay") == 0) {
;2105:		Cmd_Voice_f (ent, SAY_ALL, qfalse, qfalse);
;2106:		return;
;2107:	}
;2108:	if (Q_stricmp (cmd, "vsay_team") == 0) {
;2109:		Cmd_Voice_f (ent, SAY_TEAM, qfalse, qfalse);
;2110:		return;
;2111:	}
;2112:	if (Q_stricmp (cmd, "vtell") == 0) {
;2113:		Cmd_VoiceTell_f ( ent, qfalse );
;2114:		return;
;2115:	}
;2116:	if (Q_stricmp (cmd, "vosay") == 0) {
;2117:		Cmd_Voice_f (ent, SAY_ALL, qfalse, qtrue);
;2118:		return;
;2119:	}
;2120:	if (Q_stricmp (cmd, "vosay_team") == 0) {
;2121:		Cmd_Voice_f (ent, SAY_TEAM, qfalse, qtrue);
;2122:		return;
;2123:	}
;2124:	if (Q_stricmp (cmd, "votell") == 0) {
;2125:		Cmd_VoiceTell_f ( ent, qtrue );
;2126:		return;
;2127:	}
;2128:	if (Q_stricmp (cmd, "vtaunt") == 0) {
;2129:		Cmd_VoiceTaunt_f ( ent );
;2130:		return;
;2131:	}
;2132:#endif
;2133:	if (Q_stricmp (cmd, "score") == 0) {
ADDRLP4 0
ARGP4
ADDRGP4 $287
ARGP4
ADDRLP4 1040
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $1049
line 2134
;2134:		Cmd_Score_f (ent);
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_Score_f
CALLV
pop
line 2135
;2135:		return;
ADDRGP4 $1031
JUMPV
LABELV $1049
line 2138
;2136:	}
;2137:#if 1	// JUHOX: add templatelist_xxx commands
;2138:	if (Q_stricmp(cmd, "templatelist_request") == 0) {
ADDRLP4 0
ARGP4
ADDRGP4 $1053
ARGP4
ADDRLP4 1044
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $1051
line 2139
;2139:		Cmd_TemplateList_Request_f(ent);
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_TemplateList_Request_f
CALLV
pop
line 2140
;2140:		return;
ADDRGP4 $1031
JUMPV
LABELV $1051
line 2142
;2141:	}
;2142:	if (Q_stricmp(cmd, "templatelist_stop") == 0) {
ADDRLP4 0
ARGP4
ADDRGP4 $1056
ARGP4
ADDRLP4 1048
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $1054
line 2143
;2143:		Cmd_TemplateList_Stop_f(ent);
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_TemplateList_Stop_f
CALLV
pop
line 2144
;2144:		return;
ADDRGP4 $1031
JUMPV
LABELV $1054
line 2146
;2145:	}
;2146:	if (Q_stricmp(cmd, "templatelist_error") == 0) {
ADDRLP4 0
ARGP4
ADDRGP4 $1059
ARGP4
ADDRLP4 1052
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 0
NEI4 $1057
line 2147
;2147:		Cmd_TemplateList_Error_f(ent);
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_TemplateList_Error_f
CALLV
pop
line 2148
;2148:		return;
ADDRGP4 $1031
JUMPV
LABELV $1057
line 2152
;2149:	}
;2150:#endif
;2151:#if 1	// JUHOX: accept vote commands even if at the intermission
;2152:	if (Q_stricmp (cmd, "callvote") == 0) {
ADDRLP4 0
ARGP4
ADDRGP4 $1062
ARGP4
ADDRLP4 1056
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
NEI4 $1060
line 2153
;2153:		Cmd_CallVote_f (ent);
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_CallVote_f
CALLV
pop
line 2154
;2154:		return;
ADDRGP4 $1031
JUMPV
LABELV $1060
line 2156
;2155:	}
;2156:	if (Q_stricmp (cmd, "vote") == 0) {
ADDRLP4 0
ARGP4
ADDRGP4 $1065
ARGP4
ADDRLP4 1060
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1060
INDIRI4
CNSTI4 0
NEI4 $1063
line 2157
;2157:		Cmd_Vote_f (ent);
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_Vote_f
CALLV
pop
line 2158
;2158:		return;
ADDRGP4 $1031
JUMPV
LABELV $1063
line 2160
;2159:	}
;2160:	if (Q_stricmp (cmd, "callteamvote") == 0) {
ADDRLP4 0
ARGP4
ADDRGP4 $1068
ARGP4
ADDRLP4 1064
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1064
INDIRI4
CNSTI4 0
NEI4 $1066
line 2161
;2161:		Cmd_CallTeamVote_f (ent);
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_CallTeamVote_f
CALLV
pop
line 2162
;2162:		return;
ADDRGP4 $1031
JUMPV
LABELV $1066
line 2164
;2163:	}
;2164:	if (Q_stricmp (cmd, "teamvote") == 0) {
ADDRLP4 0
ARGP4
ADDRGP4 $1071
ARGP4
ADDRLP4 1068
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1068
INDIRI4
CNSTI4 0
NEI4 $1069
line 2165
;2165:		Cmd_TeamVote_f (ent);
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_TeamVote_f
CALLV
pop
line 2166
;2166:		return;
ADDRGP4 $1031
JUMPV
LABELV $1069
line 2171
;2167:	}
;2168:#endif
;2169:
;2170:	// ignore all other commands when at intermission
;2171:	if (level.intermissiontime) {
ADDRGP4 level+9144
INDIRI4
CNSTI4 0
EQI4 $1072
line 2173
;2172:		//Cmd_Say_f (ent, qfalse, qtrue);	// JUHOX: why should we do this?
;2173:		return;
ADDRGP4 $1031
JUMPV
LABELV $1072
line 2176
;2174:	}
;2175:
;2176:	if (Q_stricmp (cmd, "give") == 0)
ADDRLP4 0
ARGP4
ADDRGP4 $1077
ARGP4
ADDRLP4 1072
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1072
INDIRI4
CNSTI4 0
NEI4 $1075
line 2177
;2177:		Cmd_Give_f (ent);
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_Give_f
CALLV
pop
ADDRGP4 $1076
JUMPV
LABELV $1075
line 2178
;2178:	else if (Q_stricmp (cmd, "god") == 0)
ADDRLP4 0
ARGP4
ADDRGP4 $1080
ARGP4
ADDRLP4 1076
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1076
INDIRI4
CNSTI4 0
NEI4 $1078
line 2179
;2179:		Cmd_God_f (ent);
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_God_f
CALLV
pop
ADDRGP4 $1079
JUMPV
LABELV $1078
line 2180
;2180:	else if (Q_stricmp (cmd, "notarget") == 0)
ADDRLP4 0
ARGP4
ADDRGP4 $1083
ARGP4
ADDRLP4 1080
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1080
INDIRI4
CNSTI4 0
NEI4 $1081
line 2181
;2181:		Cmd_Notarget_f (ent);
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_Notarget_f
CALLV
pop
ADDRGP4 $1082
JUMPV
LABELV $1081
line 2182
;2182:	else if (Q_stricmp (cmd, "noclip") == 0)
ADDRLP4 0
ARGP4
ADDRGP4 $1086
ARGP4
ADDRLP4 1084
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1084
INDIRI4
CNSTI4 0
NEI4 $1084
line 2183
;2183:		Cmd_Noclip_f (ent);
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_Noclip_f
CALLV
pop
ADDRGP4 $1085
JUMPV
LABELV $1084
line 2184
;2184:	else if (Q_stricmp (cmd, "kill") == 0)
ADDRLP4 0
ARGP4
ADDRGP4 $1089
ARGP4
ADDRLP4 1088
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1088
INDIRI4
CNSTI4 0
NEI4 $1087
line 2185
;2185:		Cmd_Kill_f (ent);
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_Kill_f
CALLV
pop
ADDRGP4 $1088
JUMPV
LABELV $1087
line 2186
;2186:	else if (Q_stricmp (cmd, "teamtask") == 0)
ADDRLP4 0
ARGP4
ADDRGP4 $260
ARGP4
ADDRLP4 1092
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1092
INDIRI4
CNSTI4 0
NEI4 $1090
line 2187
;2187:		Cmd_TeamTask_f (ent);
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_TeamTask_f
CALLV
pop
ADDRGP4 $1091
JUMPV
LABELV $1090
line 2188
;2188:	else if (Q_stricmp (cmd, "levelshot") == 0)
ADDRLP4 0
ARGP4
ADDRGP4 $1094
ARGP4
ADDRLP4 1096
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1096
INDIRI4
CNSTI4 0
NEI4 $1092
line 2189
;2189:		Cmd_LevelShot_f (ent);
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_LevelShot_f
CALLV
pop
ADDRGP4 $1093
JUMPV
LABELV $1092
line 2191
;2190:#if SPECIAL_VIEW_MODES	// JUHOX: add toggle view command
;2191:	else if (Q_stricmp(cmd, "toggleview") == 0)
ADDRLP4 0
ARGP4
ADDRGP4 $1097
ARGP4
ADDRLP4 1100
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1100
INDIRI4
CNSTI4 0
NEI4 $1095
line 2192
;2192:		Cmd_ToggleView_f(ent);
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_ToggleView_f
CALLV
pop
ADDRGP4 $1096
JUMPV
LABELV $1095
line 2194
;2193:#endif
;2194:	else if (Q_stricmp (cmd, "follow") == 0)
ADDRLP4 0
ARGP4
ADDRGP4 $1100
ARGP4
ADDRLP4 1104
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1104
INDIRI4
CNSTI4 0
NEI4 $1098
line 2195
;2195:		Cmd_Follow_f (ent);
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_Follow_f
CALLV
pop
ADDRGP4 $1099
JUMPV
LABELV $1098
line 2196
;2196:	else if (Q_stricmp (cmd, "follownext") == 0)
ADDRLP4 0
ARGP4
ADDRGP4 $1103
ARGP4
ADDRLP4 1108
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1108
INDIRI4
CNSTI4 0
NEI4 $1101
line 2197
;2197:		Cmd_FollowCycle_f (ent, 1);
ADDRLP4 1024
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Cmd_FollowCycle_f
CALLV
pop
ADDRGP4 $1102
JUMPV
LABELV $1101
line 2198
;2198:	else if (Q_stricmp (cmd, "followprev") == 0)
ADDRLP4 0
ARGP4
ADDRGP4 $1106
ARGP4
ADDRLP4 1112
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1112
INDIRI4
CNSTI4 0
NEI4 $1104
line 2199
;2199:		Cmd_FollowCycle_f (ent, -1);
ADDRLP4 1024
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 Cmd_FollowCycle_f
CALLV
pop
ADDRGP4 $1105
JUMPV
LABELV $1104
line 2200
;2200:	else if (Q_stricmp (cmd, "team") == 0)
ADDRLP4 0
ARGP4
ADDRGP4 $1109
ARGP4
ADDRLP4 1116
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1116
INDIRI4
CNSTI4 0
NEI4 $1107
line 2201
;2201:		Cmd_Team_f (ent);
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_Team_f
CALLV
pop
ADDRGP4 $1108
JUMPV
LABELV $1107
line 2202
;2202:	else if (Q_stricmp (cmd, "where") == 0)
ADDRLP4 0
ARGP4
ADDRGP4 $1112
ARGP4
ADDRLP4 1120
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1120
INDIRI4
CNSTI4 0
NEI4 $1110
line 2203
;2203:		Cmd_Where_f (ent);
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_Where_f
CALLV
pop
ADDRGP4 $1111
JUMPV
LABELV $1110
line 2214
;2204:#if 0	// JUHOX: vote commands now handled above
;2205:	else if (Q_stricmp (cmd, "callvote") == 0)
;2206:		Cmd_CallVote_f (ent);
;2207:	else if (Q_stricmp (cmd, "vote") == 0)
;2208:		Cmd_Vote_f (ent);
;2209:	else if (Q_stricmp (cmd, "callteamvote") == 0)
;2210:		Cmd_CallTeamVote_f (ent);
;2211:	else if (Q_stricmp (cmd, "teamvote") == 0)
;2212:		Cmd_TeamVote_f (ent);
;2213:#endif
;2214:	else if (Q_stricmp (cmd, "gc") == 0)
ADDRLP4 0
ARGP4
ADDRGP4 $1115
ARGP4
ADDRLP4 1124
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1124
INDIRI4
CNSTI4 0
NEI4 $1113
line 2215
;2215:		Cmd_GameCommand_f( ent );
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_GameCommand_f
CALLV
pop
ADDRGP4 $1114
JUMPV
LABELV $1113
line 2216
;2216:	else if (Q_stricmp (cmd, "setviewpos") == 0)
ADDRLP4 0
ARGP4
ADDRGP4 $1118
ARGP4
ADDRLP4 1128
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1128
INDIRI4
CNSTI4 0
NEI4 $1116
line 2217
;2217:		Cmd_SetViewpos_f( ent );
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_SetViewpos_f
CALLV
pop
ADDRGP4 $1117
JUMPV
LABELV $1116
line 2218
;2218:	else if (Q_stricmp (cmd, "stats") == 0)
ADDRLP4 0
ARGP4
ADDRGP4 $1121
ARGP4
ADDRLP4 1132
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1132
INDIRI4
CNSTI4 0
NEI4 $1119
line 2219
;2219:		Cmd_Stats_f( ent );
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_Stats_f
CALLV
pop
ADDRGP4 $1120
JUMPV
LABELV $1119
line 2221
;2220:#if 1	// JUHOX: add drophealth command
;2221:	else if (Q_stricmp (cmd, "drophealth") == 0)
ADDRLP4 0
ARGP4
ADDRGP4 $1124
ARGP4
ADDRLP4 1136
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1136
INDIRI4
CNSTI4 0
NEI4 $1122
line 2222
;2222:		Cmd_DropHealth_f( ent );
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_DropHealth_f
CALLV
pop
ADDRGP4 $1123
JUMPV
LABELV $1122
line 2225
;2223:#endif
;2224:#if 1	// JUHOX: add droparmor command
;2225:	else if (Q_stricmp (cmd, "droparmor") == 0)
ADDRLP4 0
ARGP4
ADDRGP4 $1127
ARGP4
ADDRLP4 1140
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1140
INDIRI4
CNSTI4 0
NEI4 $1125
line 2226
;2226:		Cmd_DropArmor_f( ent );
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_DropArmor_f
CALLV
pop
ADDRGP4 $1126
JUMPV
LABELV $1125
line 2229
;2227:#endif
;2228:#if 1	// JUHOX: throw hook command
;2229:	else if (Q_stricmp(cmd, "throwhook") == 0)
ADDRLP4 0
ARGP4
ADDRGP4 $1130
ARGP4
ADDRLP4 1144
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1144
INDIRI4
CNSTI4 0
NEI4 $1128
line 2230
;2230:		Cmd_ThrowHook_f(ent);
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_ThrowHook_f
CALLV
pop
ADDRGP4 $1129
JUMPV
LABELV $1128
line 2233
;2231:#endif
;2232:#if 1	// JUHOX: add navaid command
;2233:	else if (Q_stricmp(cmd, "navaid") == 0)
ADDRLP4 0
ARGP4
ADDRGP4 $1133
ARGP4
ADDRLP4 1148
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1148
INDIRI4
CNSTI4 0
NEI4 $1131
line 2234
;2234:		Cmd_NavAid_f(ent);
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_NavAid_f
CALLV
pop
ADDRGP4 $1132
JUMPV
LABELV $1131
line 2237
;2235:#endif
;2236:#if 1	// JUHOX: add groupformation command
;2237:	else if (Q_stricmp(cmd, "groupformation") == 0)
ADDRLP4 0
ARGP4
ADDRGP4 $1136
ARGP4
ADDRLP4 1152
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1152
INDIRI4
CNSTI4 0
NEI4 $1134
line 2238
;2238:		Cmd_GroupFormation_f(ent);
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_GroupFormation_f
CALLV
pop
ADDRGP4 $1135
JUMPV
LABELV $1134
line 2241
;2239:#endif
;2240:#if 1	// JUHOX: add tssinstructions command
;2241:	else if (Q_stricmp(cmd, "tssinstructions") == 0)
ADDRLP4 0
ARGP4
ADDRGP4 $1139
ARGP4
ADDRLP4 1156
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1156
INDIRI4
CNSTI4 0
NEI4 $1137
line 2242
;2242:		Cmd_TSSInstructions_f(ent);
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_TSSInstructions_f
CALLV
pop
ADDRGP4 $1138
JUMPV
LABELV $1137
line 2245
;2243:#endif
;2244:#if 1	// JUHOX: add tsssafetymode command
;2245:	else if (Q_stricmp(cmd, "tsssafetymode") == 0)
ADDRLP4 0
ARGP4
ADDRGP4 $1142
ARGP4
ADDRLP4 1160
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1160
INDIRI4
CNSTI4 0
NEI4 $1140
line 2246
;2246:		Cmd_TSSSafetyMode_f(ent);
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_TSSSafetyMode_f
CALLV
pop
ADDRGP4 $1141
JUMPV
LABELV $1140
line 2249
;2247:#endif
;2248:#if ESCAPE_MODE	// JUHOX: add efhdebugseg command
;2249:	else if (Q_stricmp(cmd, "efhdebugseg") == 0)
ADDRLP4 0
ARGP4
ADDRGP4 $1145
ARGP4
ADDRLP4 1164
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1164
INDIRI4
CNSTI4 0
NEI4 $1143
line 2250
;2250:		Cmd_EFHDebugSeg_f(ent);
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_EFHDebugSeg_f
CALLV
pop
ADDRGP4 $1144
JUMPV
LABELV $1143
line 2261
;2251:#endif
;2252:#if JUHOX_BOT_DEBUG	// JUHOX: bot debug command
;2253:	else if (Q_stricmp(cmd, "botdebug") == 0)
;2254:		Cmd_BotDebug_f(ent);
;2255:#endif
;2256:#if SCREENSHOT_TOOLS	// JUHOX: add stop command
;2257:	else if (Q_stricmp(cmd, "stop") == 0)
;2258:		Cmd_Stop_f(ent);
;2259:#endif
;2260:	else
;2261:		trap_SendServerCommand( clientNum, va("print \"unknown cmd %s\n\"", cmd ) );
ADDRGP4 $1146
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 1168
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1168
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
LABELV $1144
LABELV $1141
LABELV $1138
LABELV $1135
LABELV $1132
LABELV $1129
LABELV $1126
LABELV $1123
LABELV $1120
LABELV $1117
LABELV $1114
LABELV $1111
LABELV $1108
LABELV $1105
LABELV $1102
LABELV $1099
LABELV $1096
LABELV $1093
LABELV $1091
LABELV $1088
LABELV $1085
LABELV $1082
LABELV $1079
LABELV $1076
line 2262
;2262:}
LABELV $1031
endproc ClientCommand 1172 12
import trap_SnapVector
import trap_GeneticParentsAndChildSelection
import trap_BotResetWeaponState
import trap_BotFreeWeaponState
import trap_BotAllocWeaponState
import trap_BotLoadWeaponWeights
import trap_BotGetWeaponInfo
import trap_BotChooseBestFightWeapon
import trap_BotAddAvoidSpot
import trap_BotInitMoveState
import trap_BotFreeMoveState
import trap_BotAllocMoveState
import trap_BotPredictVisiblePosition
import trap_BotMovementViewTarget
import trap_BotReachabilityArea
import trap_BotResetLastAvoidReach
import trap_BotResetAvoidReach
import trap_BotMoveInDirection
import trap_BotMoveToGoal
import trap_BotResetMoveState
import trap_BotFreeGoalState
import trap_BotAllocGoalState
import trap_BotMutateGoalFuzzyLogic
import trap_BotSaveGoalFuzzyLogic
import trap_BotInterbreedGoalFuzzyLogic
import trap_BotFreeItemWeights
import trap_BotLoadItemWeights
import trap_BotUpdateEntityItems
import trap_BotInitLevelItems
import trap_BotSetAvoidGoalTime
import trap_BotAvoidGoalTime
import trap_BotGetLevelItemGoal
import trap_BotGetMapLocationGoal
import trap_BotGetNextCampSpotGoal
import trap_BotItemGoalInVisButNotVisible
import trap_BotTouchingGoal
import trap_BotChooseNBGItem
import trap_BotChooseLTGItem
import trap_BotGetSecondGoal
import trap_BotGetTopGoal
import trap_BotGoalName
import trap_BotDumpGoalStack
import trap_BotDumpAvoidGoals
import trap_BotEmptyGoalStack
import trap_BotPopGoal
import trap_BotPushGoal
import trap_BotResetAvoidGoals
import trap_BotRemoveFromAvoidGoals
import trap_BotResetGoalState
import trap_BotSetChatName
import trap_BotSetChatGender
import trap_BotLoadChatFile
import trap_BotReplaceSynonyms
import trap_UnifyWhiteSpaces
import trap_BotMatchVariable
import trap_BotFindMatch
import trap_StringContains
import trap_BotGetChatMessage
import trap_BotEnterChat
import trap_BotChatLength
import trap_BotReplyChat
import trap_BotNumInitialChats
import trap_BotInitialChat
import trap_BotNumConsoleMessages
import trap_BotNextConsoleMessage
import trap_BotRemoveConsoleMessage
import trap_BotQueueConsoleMessage
import trap_BotFreeChatState
import trap_BotAllocChatState
import trap_Characteristic_String
import trap_Characteristic_BInteger
import trap_Characteristic_Integer
import trap_Characteristic_BFloat
import trap_Characteristic_Float
import trap_BotFreeCharacter
import trap_BotLoadCharacter
import trap_EA_ResetInput
import trap_EA_GetInput
import trap_EA_EndRegular
import trap_EA_View
import trap_EA_Move
import trap_EA_DelayedJump
import trap_EA_Jump
import trap_EA_SelectWeapon
import trap_EA_MoveRight
import trap_EA_MoveLeft
import trap_EA_MoveBack
import trap_EA_MoveForward
import trap_EA_MoveDown
import trap_EA_MoveUp
import trap_EA_Crouch
import trap_EA_Respawn
import trap_EA_Use
import trap_EA_Attack
import trap_EA_Talk
import trap_EA_Gesture
import trap_EA_Action
import trap_EA_Command
import trap_EA_SayTeam
import trap_EA_Say
import trap_AAS_PredictClientMovement
import trap_AAS_Swimming
import trap_AAS_AlternativeRouteGoals
import trap_AAS_PredictRoute
import trap_AAS_EnableRoutingArea
import trap_AAS_AreaTravelTimeToGoalArea
import trap_AAS_AreaReachability
import trap_AAS_IntForBSPEpairKey
import trap_AAS_FloatForBSPEpairKey
import trap_AAS_VectorForBSPEpairKey
import trap_AAS_ValueForBSPEpairKey
import trap_AAS_NextBSPEntity
import trap_AAS_PointContents
import trap_AAS_TraceAreas
import trap_AAS_PointReachabilityAreaIndex
import trap_AAS_PointAreaNum
import trap_AAS_Time
import trap_AAS_PresenceTypeBoundingBox
import trap_AAS_Initialized
import trap_AAS_EntityInfo
import trap_AAS_AreaInfo
import trap_AAS_BBoxAreas
import trap_BotUserCommand
import trap_BotGetServerCommand
import trap_BotGetSnapshotEntity
import trap_BotLibTest
import trap_BotLibUpdateEntity
import trap_BotLibLoadMap
import trap_BotLibStartFrame
import trap_BotLibDefine
import trap_BotLibVarGet
import trap_BotLibVarSet
import trap_BotLibShutdown
import trap_BotLibSetup
import trap_DebugPolygonDelete
import trap_DebugPolygonCreate
import trap_GetEntityToken
import trap_GetUsercmd
import trap_BotFreeClient
import trap_BotAllocateClient
import trap_EntityContact
import trap_EntitiesInBox
import trap_UnlinkEntity
import trap_LinkEntity
import trap_AreasConnected
import trap_AdjustAreaPortalState
import trap_InPVSIgnorePortals
import trap_InPVS
import trap_PointContents
import trap_Trace
import trap_SetBrushModel
import trap_GetServerinfo
import trap_SetUserinfo
import trap_GetUserinfo
import trap_GetConfigstring
import trap_SetConfigstring
import trap_SendServerCommand
import trap_DropClient
import trap_LocateGameData
import trap_Cvar_VariableStringBuffer
import trap_Cvar_VariableValue
import trap_Cvar_VariableIntegerValue
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_SendConsoleCommand
import trap_FS_Seek
import trap_FS_GetFileList
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_FS_FOpenFile
import trap_Args
import trap_Argv
import trap_Argc
import trap_Milliseconds
import trap_Error
import trap_Printf
import g_mapName
import g_proxMineTimeout
import g_singlePlayer
import g_enableBreath
import g_enableDust
import g_rankings
import pmove_msec
import pmove_fixed
import g_smoothClients
import g_blueteam
import g_redteam
import g_cubeTimeout
import g_obeliskRespawnDelay
import g_obeliskRegenAmount
import g_obeliskRegenPeriod
import g_obeliskHealth
import g_filterBan
import g_banIPs
import g_teamForceBalance
import g_teamAutoJoin
import g_allowVote
import g_blood
import g_doWarmup
import g_warmup
import g_motd
import g_synchronousClients
import g_weaponTeamRespawn
import g_weaponRespawn
import g_debugDamage
import g_debugAlloc
import g_debugMove
import g_inactivity
import g_forcerespawn
import g_quadfactor
import g_knockback
import g_speed
import g_gravity
import g_needpass
import g_password
import g_friendlyFire
import g_meeting
import g_weaponLimit
import g_cloakingDevice
import g_unlimitedAmmo
import g_noHealthRegen
import g_noItems
import g_grapple
import g_lightningDamageLimit
import g_baseHealth
import g_stamina
import g_armorFragments
import g_tssSafetyMode
import g_tss
import g_respawnAtPOD
import g_respawnDelay
import g_gameSeed
import g_template
import g_debugEFH
import g_challengingEnv
import g_distanceLimit
import g_monsterLoad
import g_scoreMode
import g_monsterProgression
import g_monsterBreeding
import g_maxMonstersPP
import g_monsterLauncher
import g_skipEndSequence
import g_monstersPerTrap
import g_monsterTitans
import g_monsterGuards
import g_monsterHealthScale
import g_monsterSpawnDelay
import g_maxMonsters
import g_minMonsters
import g_artefacts
import g_capturelimit
import g_timelimit
import g_fraglimit
import g_dmflags
import g_restarted
import g_maxGameClients
import g_maxclients
import g_cheats
import g_dedicated
import g_gametype
import g_editmode
import g_entities
import level
import Pickup_Team
import CheckTeamStatus
import TeamplayInfoMessage
import Team_GetLocationMsg
import Team_GetLocation
import SelectCTFSpawnPoint
import Team_FreeEntity
import Team_ReturnFlag
import Team_InitGame
import Team_CheckHurtCarrier
import Team_FragBonuses
import Team_DroppedFlagThink
import AddTeamScore
import TeamColorString
import OtherTeamName
import TeamName
import OtherTeam
import BotTestAAS
import BotAIStartFrame
import BotAIShutdownClient
import BotAISetupClient
import BotAILoadMap
import BotAIShutdown
import BotAISetup
import IsPlayerFighting
import G_Constitution
import G_GetEntityPlayerState
import EntityAudible
import G_MonsterAction
import G_CheckMonsterDamage
import G_GetMonsterGeneric1
import G_IsMovable
import G_CanBeDamaged
import G_UpdateMonsterCounters
import G_AddMonsterSeed
import G_ReleaseTrap
import G_IsFriendlyMonster
import G_MonsterOwner
import G_IsAttackingGuard
import G_ChargeMonsters
import G_IsMonsterSuccessfulAttacking
import G_IsMonsterNearEntity
import IsFightingMonster
import G_MonsterSpawning
import G_SpawnMonster
import G_MonsterType
import G_MonsterBaseHealth
import G_MonsterHealthScale
import G_GetMonsterSpawnPoint
import G_GetMonsterBounds
import G_KillMonster
import G_MonsterScanForNoises
import CheckTouchedMonsters
import G_NumMonsters
import G_UpdateMonsterCS
import G_InitMonsters
import BotInterbreedEndMatch
import Svcmd_BotList_f
import Svcmd_AddBot_f
import G_BotConnect
import G_RemoveQueuedBotBegin
import G_CheckBotSpawn
import G_GetBotInfoByName
import G_GetBotInfoByNumber
import G_InitBots
import Svcmd_AbortPodium_f
import SpawnModelsOnVictoryPads
import UpdateTournamentInfo
import G_WriteSessionData
import G_InitWorldSession
import G_InitSessionData
import G_ReadSessionData
import Svcmd_GameMem_f
import G_InitMemory
import G_Alloc
import CheckObeliskAttack
import Team_GetDroppedOrTakenFlag
import Team_CheckDroppedItem
import OnSameTeam
import Team_GetFlagStatus
import G_RunClient
import ClientEndFrame
import ClientThink
import ClientImpacts
import SetTargetPos
import CheckPlayerDischarge
import TotalChargeDamage
import TSS_Run
import TSS_DangerIndex
import IsPlayerInvolvedInFighting
import NearHomeBase
import ClientBegin
import ClientDisconnect
import ClientUserinfoChanged
import ClientSetPlayerClass
import ClientConnect
import SelectAppropriateSpawnPoint
import LogExit
import G_Error
import G_Printf
import SendScoreboardMessageToAllClients
import G_LogPrintf
import G_RunThink
import G_SetPlayerRefOrigin
import CheckTeamLeader
import SetLeader
import FindIntermissionPoint
import G_SetStats
import MoveClientToIntermission
import FireWeapon
import G_FilterPacket
import G_ProcessIPBans
import ConsoleCommand
import PositionWouldTelefrag
import SpotWouldTelefrag
import CalculateRanks
import AddScore
import player_die
import ClientSpawn
import InitBodyQue
import InitClientResp
import InitClientPersistant
import BeginIntermission
import respawn
import CopyToBodyQue
import SelectSpawnPoint
import SetClientViewAngle
import PickTeam
import TeamLeader
import TeamCount
import GetRespawnLocationType
import ForceRespawn
import Weapon_HookThink
import Weapon_HookFree
import CheckTitanAttack
import CheckGauntletAttack
import SnapVectorTowards
import CalcMuzzlePoint
import LogAccuracyHit
import Weapon_GrapplingHook_Throw
import TeleportPlayer
import trigger_teleporter_touch
import InitMover
import Touch_DoorTrigger
import G_RunMover
import fire_monster_seed
import fire_grapple
import fire_bfg
import fire_rocket
import fire_grenade
import fire_plasma
import fire_blaster
import G_RunMissile
import GibEntity
import ScorePlum
import DropArmor
import DropHealth
import TossClientCubes
import TossClientItems
import body_die
import G_InvulnerabilityEffect
import G_RadiusDamage
import G_Damage
import CanDamage
import DoOverkill
import BuildShaderStateConfig
import AddRemap
import G_SetOrigin
import G_AddEvent
import G_AddPredictableEvent
import vectoyaw
import vtos
import tv
import G_acos
import G_TouchSolids
import G_TouchTriggers
import G_EntitiesFree
import G_FreeEntity
import G_Sound
import G_TempEntity
import G_NumEntitiesFree
import G_Spawn
import G_InitGentity
import G_SetMovedir
import G_UseTargets
import G_PickTarget
import G_Find
import G_KillBox
import G_TeamCommand
import G_SoundIndex
import G_ModelIndex
import SaveRegisteredItems
import RegisterItem
import ClearRegisteredItems
import G_SpawnArtefact
import G_BounceItemRotation
import Touch_Item
import Add_Ammo
import ArmorIndex
import Think_Weapon
import FinishSpawningItem
import G_SpawnItem
import SetRespawn
import LaunchItem
import Drop_Item
import PrecacheItem
import UseHoldableItem
import RespawnItem
import G_RunItem
import G_CheckTeamItems
import G_EFH_NextDebugSegment
import G_EFH_SpaceExtent
import G_UpdateLightingOrigins
import G_GetTotalWayLength
import G_MakeWorldAwareOfMonsterDeath
import G_FindSegment
import G_UpdateWorld
import G_SpawnWorld
import G_InitWorldSystem
import G_NewString
import G_SpawnEntitiesFromString
import G_SpawnVector
import G_SpawnInt
import G_SpawnFloat
import G_SpawnString
import G_PlayTemplate
import G_PrintTemplateList
import G_SendGameTemplate
import G_TemplateList_Error
import G_TemplateList_Stop
import G_TemplateList_Request
import G_RestartGameTemplates
import G_DefineTemplate
import G_SetTemplateName
import G_LoadGameTemplates
import G_InitGameTemplates
import sv_mapChecksum
import templateList
import numTemplateFiles
import templateFileList
import InitLocalSeed
import SeededRandom
import SetGameSeed
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
LABELV $1146
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 99
byte 1 109
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1145
byte 1 101
byte 1 102
byte 1 104
byte 1 100
byte 1 101
byte 1 98
byte 1 117
byte 1 103
byte 1 115
byte 1 101
byte 1 103
byte 1 0
align 1
LABELV $1142
byte 1 116
byte 1 115
byte 1 115
byte 1 115
byte 1 97
byte 1 102
byte 1 101
byte 1 116
byte 1 121
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $1139
byte 1 116
byte 1 115
byte 1 115
byte 1 105
byte 1 110
byte 1 115
byte 1 116
byte 1 114
byte 1 117
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $1136
byte 1 103
byte 1 114
byte 1 111
byte 1 117
byte 1 112
byte 1 102
byte 1 111
byte 1 114
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1133
byte 1 110
byte 1 97
byte 1 118
byte 1 97
byte 1 105
byte 1 100
byte 1 0
align 1
LABELV $1130
byte 1 116
byte 1 104
byte 1 114
byte 1 111
byte 1 119
byte 1 104
byte 1 111
byte 1 111
byte 1 107
byte 1 0
align 1
LABELV $1127
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $1124
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $1121
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $1118
byte 1 115
byte 1 101
byte 1 116
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 112
byte 1 111
byte 1 115
byte 1 0
align 1
LABELV $1115
byte 1 103
byte 1 99
byte 1 0
align 1
LABELV $1112
byte 1 119
byte 1 104
byte 1 101
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $1109
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $1106
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 112
byte 1 114
byte 1 101
byte 1 118
byte 1 0
align 1
LABELV $1103
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $1100
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $1097
byte 1 116
byte 1 111
byte 1 103
byte 1 103
byte 1 108
byte 1 101
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 0
align 1
LABELV $1094
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $1089
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $1086
byte 1 110
byte 1 111
byte 1 99
byte 1 108
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $1083
byte 1 110
byte 1 111
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $1080
byte 1 103
byte 1 111
byte 1 100
byte 1 0
align 1
LABELV $1077
byte 1 103
byte 1 105
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $1071
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $1068
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $1065
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $1062
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $1059
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
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $1056
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
byte 1 115
byte 1 116
byte 1 111
byte 1 112
byte 1 0
align 1
LABELV $1053
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
byte 1 114
byte 1 101
byte 1 113
byte 1 117
byte 1 101
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $1048
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $1045
byte 1 115
byte 1 97
byte 1 121
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $1042
byte 1 115
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $1039
byte 1 108
byte 1 102
byte 1 101
byte 1 109
byte 1 109
byte 1 0
align 1
LABELV $961
byte 1 102
byte 1 114
byte 1 101
byte 1 101
byte 1 0
align 1
LABELV $958
byte 1 108
byte 1 111
byte 1 111
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $955
byte 1 116
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $881
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 32
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $858
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 117
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 112
byte 1 111
byte 1 115
byte 1 32
byte 1 120
byte 1 32
byte 1 121
byte 1 32
byte 1 122
byte 1 32
byte 1 121
byte 1 97
byte 1 119
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $841
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 99
byte 1 97
byte 1 115
byte 1 116
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $838
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 97
byte 1 108
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 121
byte 1 32
byte 1 99
byte 1 97
byte 1 115
byte 1 116
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $835
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 78
byte 1 111
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $811
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 32
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $799
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 115
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 58
byte 1 32
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 32
byte 1 60
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 62
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $798
byte 1 116
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 114
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $797
byte 1 115
byte 1 117
byte 1 114
byte 1 114
byte 1 101
byte 1 110
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $794
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 97
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $759
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $753
byte 1 32
byte 1 0
align 1
LABELV $744
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 109
byte 1 97
byte 1 120
byte 1 105
byte 1 109
byte 1 117
byte 1 109
byte 1 32
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 115
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $741
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 65
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 97
byte 1 108
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 121
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $716
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 86
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 99
byte 1 97
byte 1 115
byte 1 116
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $715
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 78
byte 1 111
byte 1 116
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 97
byte 1 115
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
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $712
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 86
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 97
byte 1 108
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 121
byte 1 32
byte 1 99
byte 1 97
byte 1 115
byte 1 116
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $709
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 78
byte 1 111
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $700
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $690
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 32
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $686
byte 1 37
byte 1 115
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 0
align 1
LABELV $681
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $669
byte 1 37
byte 1 115
byte 1 32
byte 1 40
byte 1 37
byte 1 115
byte 1 41
byte 1 0
align 1
LABELV $666
byte 1 37
byte 1 115
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $663
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $659
byte 1 78
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 109
byte 1 97
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $658
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
LABELV $657
byte 1 72
byte 1 117
byte 1 114
byte 1 116
byte 1 32
byte 1 109
byte 1 101
byte 1 32
byte 1 112
byte 1 108
byte 1 101
byte 1 110
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $656
byte 1 66
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 105
byte 1 116
byte 1 32
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $655
byte 1 73
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 32
byte 1 119
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $648
byte 1 118
byte 1 115
byte 1 116
byte 1 114
byte 1 32
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $645
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 109
byte 1 97
byte 1 112
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $639
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $634
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 59
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 109
byte 1 97
byte 1 112
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 0
align 1
LABELV $627
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $624
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $621
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 73
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $613
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $608
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 86
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 115
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 58
byte 1 32
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
byte 1 44
byte 1 32
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 109
byte 1 97
byte 1 112
byte 1 44
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 32
byte 1 60
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 62
byte 1 44
byte 1 32
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
byte 1 32
byte 1 60
byte 1 110
byte 1 62
byte 1 44
byte 1 32
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 32
byte 1 60
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 62
byte 1 44
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 32
byte 1 60
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 110
byte 1 117
byte 1 109
byte 1 62
byte 1 44
byte 1 32
byte 1 103
byte 1 95
byte 1 100
byte 1 111
byte 1 87
byte 1 97
byte 1 114
byte 1 109
byte 1 117
byte 1 112
byte 1 44
byte 1 32
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
byte 1 60
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 62
byte 1 44
byte 1 32
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
byte 1 60
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 115
byte 1 62
byte 1 44
byte 1 32
byte 1 97
byte 1 100
byte 1 100
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 60
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 62
byte 1 32
byte 1 60
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 32
byte 1 49
byte 1 45
byte 1 53
byte 1 62
byte 1 32
byte 1 91
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 93
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $607
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
LABELV $604
byte 1 97
byte 1 100
byte 1 100
byte 1 98
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $601
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
LABELV $598
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
LABELV $595
byte 1 103
byte 1 95
byte 1 100
byte 1 111
byte 1 87
byte 1 97
byte 1 114
byte 1 109
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $592
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $589
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $586
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
LABELV $583
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $580
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $577
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
byte 1 0
align 1
LABELV $574
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 73
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $568
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 78
byte 1 111
byte 1 116
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 32
byte 1 97
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 97
byte 1 115
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
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $565
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 109
byte 1 97
byte 1 120
byte 1 105
byte 1 109
byte 1 117
byte 1 109
byte 1 32
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 115
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $562
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 65
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 97
byte 1 108
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 121
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $558
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 86
byte 1 111
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 101
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $553
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
LABELV $552
byte 1 72
byte 1 97
byte 1 114
byte 1 118
byte 1 101
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $551
byte 1 79
byte 1 118
byte 1 101
byte 1 114
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $550
byte 1 79
byte 1 110
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 67
byte 1 84
byte 1 70
byte 1 0
align 1
LABELV $549
byte 1 67
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $548
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
LABELV $547
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
LABELV $546
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
LABELV $545
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
LABELV $544
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $535
byte 1 114
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $534
byte 1 115
byte 1 101
byte 1 97
byte 1 114
byte 1 99
byte 1 104
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 100
byte 1 101
byte 1 115
byte 1 116
byte 1 114
byte 1 111
byte 1 121
byte 1 0
align 1
LABELV $533
byte 1 103
byte 1 117
byte 1 97
byte 1 114
byte 1 100
byte 1 32
byte 1 108
byte 1 111
byte 1 99
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $532
byte 1 99
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $531
byte 1 99
byte 1 111
byte 1 109
byte 1 101
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $530
byte 1 104
byte 1 111
byte 1 108
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 112
byte 1 111
byte 1 115
byte 1 105
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $529
byte 1 104
byte 1 111
byte 1 108
byte 1 100
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 112
byte 1 111
byte 1 115
byte 1 105
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $523
byte 1 118
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $513
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $512
byte 1 118
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $511
byte 1 118
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $508
byte 1 118
byte 1 116
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $491
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $469
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $463
byte 1 25
byte 1 91
byte 1 37
byte 1 115
byte 1 37
byte 1 99
byte 1 37
byte 1 99
byte 1 25
byte 1 93
byte 1 25
byte 1 58
byte 1 32
byte 1 0
align 1
LABELV $462
byte 1 25
byte 1 91
byte 1 37
byte 1 115
byte 1 37
byte 1 99
byte 1 37
byte 1 99
byte 1 25
byte 1 93
byte 1 32
byte 1 40
byte 1 37
byte 1 115
byte 1 41
byte 1 25
byte 1 58
byte 1 32
byte 1 0
align 1
LABELV $457
byte 1 25
byte 1 40
byte 1 37
byte 1 115
byte 1 37
byte 1 99
byte 1 37
byte 1 99
byte 1 25
byte 1 41
byte 1 25
byte 1 58
byte 1 32
byte 1 0
align 1
LABELV $456
byte 1 25
byte 1 40
byte 1 37
byte 1 115
byte 1 37
byte 1 99
byte 1 37
byte 1 99
byte 1 25
byte 1 41
byte 1 32
byte 1 40
byte 1 37
byte 1 115
byte 1 41
byte 1 25
byte 1 58
byte 1 32
byte 1 0
align 1
LABELV $453
byte 1 115
byte 1 97
byte 1 121
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $451
byte 1 37
byte 1 115
byte 1 37
byte 1 99
byte 1 37
byte 1 99
byte 1 25
byte 1 58
byte 1 32
byte 1 0
align 1
LABELV $450
byte 1 115
byte 1 97
byte 1 121
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $439
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $438
byte 1 116
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $437
byte 1 37
byte 1 115
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 37
byte 1 99
byte 1 37
byte 1 99
byte 1 37
byte 1 115
byte 1 34
byte 1 0
align 1
LABELV $409
byte 1 67
byte 1 109
byte 1 100
byte 1 95
byte 1 70
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 67
byte 1 121
byte 1 99
byte 1 108
byte 1 101
byte 1 95
byte 1 102
byte 1 58
byte 1 32
byte 1 98
byte 1 97
byte 1 100
byte 1 32
byte 1 100
byte 1 105
byte 1 114
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $380
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 77
byte 1 97
byte 1 121
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 115
byte 1 119
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 115
byte 1 32
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 110
byte 1 32
byte 1 111
byte 1 110
byte 1 99
byte 1 101
byte 1 32
byte 1 112
byte 1 101
byte 1 114
byte 1 32
byte 1 53
byte 1 32
byte 1 115
byte 1 101
byte 1 99
byte 1 111
byte 1 110
byte 1 100
byte 1 115
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $375
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 83
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 97
byte 1 116
byte 1 111
byte 1 114
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $373
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 70
byte 1 114
byte 1 101
byte 1 101
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $371
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $369
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $330
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 109
byte 1 97
byte 1 110
byte 1 121
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $325
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 109
byte 1 97
byte 1 110
byte 1 121
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $314
byte 1 98
byte 1 0
align 1
LABELV $313
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $309
byte 1 114
byte 1 0
align 1
LABELV $308
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $298
byte 1 115
byte 1 0
align 1
LABELV $297
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 97
byte 1 116
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $294
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 50
byte 1 0
align 1
LABELV $291
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 49
byte 1 0
align 1
LABELV $287
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $286
byte 1 115
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
LABELV $280
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 106
byte 1 111
byte 1 105
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
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
byte 1 115
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $277
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 106
byte 1 111
byte 1 105
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $274
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 106
byte 1 111
byte 1 105
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $271
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 106
byte 1 111
byte 1 105
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $261
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $260
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $256
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 76
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 83
byte 1 104
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $255
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 77
byte 1 117
byte 1 115
byte 1 116
byte 1 32
byte 1 98
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 32
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
byte 1 32
byte 1 48
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $245
byte 1 110
byte 1 111
byte 1 99
byte 1 108
byte 1 105
byte 1 112
byte 1 32
byte 1 79
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $244
byte 1 110
byte 1 111
byte 1 99
byte 1 108
byte 1 105
byte 1 112
byte 1 32
byte 1 79
byte 1 70
byte 1 70
byte 1 10
byte 1 0
align 1
LABELV $238
byte 1 110
byte 1 111
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 79
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $237
byte 1 110
byte 1 111
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 79
byte 1 70
byte 1 70
byte 1 10
byte 1 0
align 1
LABELV $231
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 0
align 1
LABELV $230
byte 1 103
byte 1 111
byte 1 100
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 32
byte 1 79
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $229
byte 1 103
byte 1 111
byte 1 100
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 32
byte 1 79
byte 1 70
byte 1 70
byte 1 10
byte 1 0
align 1
LABELV $215
byte 1 97
byte 1 115
byte 1 115
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $212
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $209
byte 1 103
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 116
byte 1 97
byte 1 119
byte 1 97
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $206
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
LABELV $203
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
LABELV $197
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $187
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 0
align 1
LABELV $181
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $175
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $172
byte 1 97
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $166
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 85
byte 1 115
byte 1 101
byte 1 114
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $156
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 101
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $153
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 66
byte 1 97
byte 1 100
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 115
byte 1 108
byte 1 111
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $127
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 109
byte 1 117
byte 1 115
byte 1 116
byte 1 32
byte 1 98
byte 1 101
byte 1 32
byte 1 97
byte 1 108
byte 1 105
byte 1 118
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $124
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 67
byte 1 104
byte 1 101
byte 1 97
byte 1 116
byte 1 115
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 101
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $114
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $104
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 0
