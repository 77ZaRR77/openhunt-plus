data
export cg_customSoundNames
align 4
LABELV cg_customSoundNames
address $124
address $125
address $126
address $127
address $128
address $129
address $130
address $131
address $132
address $133
address $134
address $135
address $136
skip 76
export CG_CustomSound
code
proc CG_CustomSound 16 8
file "..\..\..\..\code\cgame\cg_players.c"
line 29
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_players.c -- handle the media and animation for player entities
;4:#include "cg_local.h"
;5:
;6:char	*cg_customSoundNames[MAX_CUSTOM_SOUNDS] = {
;7:	"*death1.wav",
;8:	"*death2.wav",
;9:	"*death3.wav",
;10:	"*jump1.wav",
;11:	"*pain25_1.wav",
;12:	"*pain50_1.wav",
;13:	"*pain75_1.wav",
;14:	"*pain100_1.wav",
;15:	"*falling1.wav",
;16:	"*gasp.wav",
;17:	"*drown.wav",
;18:	"*fall1.wav",
;19:	"*taunt.wav"
;20:};
;21:
;22:
;23:/*
;24:================
;25:CG_CustomSound
;26:
;27:================
;28:*/
;29:sfxHandle_t	CG_CustomSound( int clientNum, const char *soundName ) {
line 33
;30:	clientInfo_t *ci;
;31:	int			i;
;32:
;33:	if ( soundName[0] != '*' ) {
ADDRFP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 42
EQI4 $138
line 34
;34:		return trap_S_RegisterSound( soundName, qfalse );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
ADDRGP4 $137
JUMPV
LABELV $138
line 44
;35:	}
;36:
;37:	// JUHOX: accept EXTRA_CLIENTNUMS
;38:#if !MONSTER_MODE
;39:	if ( clientNum < 0 || clientNum >= MAX_CLIENTS ) {
;40:		clientNum = 0;
;41:	}
;42:	ci = &cgs.clientinfo[ clientNum ];
;43:#else
;44:	if (clientNum < 0 || clientNum >= ENTITYNUM_MAX_NORMAL) {
ADDRLP4 8
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $142
ADDRLP4 8
INDIRI4
CNSTI4 1022
LTI4 $140
LABELV $142
line 45
;45:		clientNum = 0;
ADDRFP4 0
CNSTI4 0
ASGNI4
line 46
;46:	}
LABELV $140
line 47
;47:	if (clientNum >= MAX_CLIENTS) {
ADDRFP4 0
INDIRI4
CNSTI4 64
LTI4 $143
line 48
;48:		clientNum = cg_entities[clientNum].currentState.clientNum;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 880
MULI4
ADDRGP4 cg_entities+168
ADDP4
INDIRI4
ASGNI4
line 49
;49:		if (clientNum < 0 || clientNum >= MAX_CLIENTS + EXTRA_CLIENTNUMS) {
ADDRLP4 12
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
LTI4 $148
ADDRLP4 12
INDIRI4
CNSTI4 69
LTI4 $146
LABELV $148
line 50
;50:			clientNum = CLIENTNUM_MONSTER_PREDATOR;
ADDRFP4 0
CNSTI4 64
ASGNI4
line 51
;51:		}
LABELV $146
line 52
;52:	}
LABELV $143
line 53
;53:	ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 4
ADDRFP4 0
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320
ADDP4
ASGNP4
line 54
;54:	if (!ci->infoValid) ci = &cgs.clientinfo[0];
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $150
ADDRLP4 4
ADDRGP4 cgs+41320
ASGNP4
LABELV $150
line 57
;55:#endif
;56:
;57:	for ( i = 0 ; i < MAX_CUSTOM_SOUNDS && cg_customSoundNames[i] ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $156
JUMPV
LABELV $153
line 58
;58:		if ( !strcmp( soundName, cg_customSoundNames[i] ) ) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_customSoundNames
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $157
line 59
;59:			return ci->sounds[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 1600
ADDP4
ADDP4
INDIRI4
RETI4
ADDRGP4 $137
JUMPV
LABELV $157
line 61
;60:		}
;61:	}
LABELV $154
line 57
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $156
ADDRLP4 0
INDIRI4
CNSTI4 32
GEI4 $159
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_customSoundNames
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $153
LABELV $159
line 63
;62:
;63:	CG_Error( "Unknown custom sound: %s", soundName );
ADDRGP4 $160
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 64
;64:	return 0;
CNSTI4 0
RETI4
LABELV $137
endproc CG_CustomSound 16 8
proc CG_ParseAnimationFile 20084 12
line 85
;65:}
;66:
;67:
;68:
;69:/*
;70:=============================================================================
;71:
;72:CLIENT INFO
;73:
;74:=============================================================================
;75:*/
;76:
;77:/*
;78:======================
;79:CG_ParseAnimationFile
;80:
;81:Read a configuration file containing animation coutns and rates
;82:models/players/visor/animation.cfg, etc
;83:======================
;84:*/
;85:static qboolean	CG_ParseAnimationFile( const char *filename, clientInfo_t *ci ) {
line 96
;86:	char		*text_p, *prev;
;87:	int			len;
;88:	int			i;
;89:	char		*token;
;90:	float		fps;
;91:	int			skip;
;92:	char		text[20000];
;93:	fileHandle_t	f;
;94:	animation_t *animations;
;95:
;96:	animations = ci->animations;
ADDRLP4 8
ADDRFP4 4
INDIRP4
CNSTI4 564
ADDP4
ASGNP4
line 99
;97:
;98:	// load the file
;99:	len = trap_FS_FOpenFile( filename, &f, FS_READ );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20032
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 20036
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 20036
INDIRI4
ASGNI4
line 100
;100:	if ( len <= 0 ) {
ADDRLP4 28
INDIRI4
CNSTI4 0
GTI4 $162
line 101
;101:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $161
JUMPV
LABELV $162
line 103
;102:	}
;103:	if ( len >= sizeof( text ) - 1 ) {
ADDRLP4 28
INDIRI4
CVIU4 4
CNSTU4 19999
LTU4 $164
line 104
;104:		CG_Printf( "File %s too long\n", filename );
ADDRGP4 $166
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 105
;105:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $161
JUMPV
LABELV $164
line 107
;106:	}
;107:	trap_FS_Read( text, len, f );
ADDRLP4 32
ARGP4
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 20032
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 108
;108:	text[len] = 0;
ADDRLP4 28
INDIRI4
ADDRLP4 32
ADDP4
CNSTI1 0
ASGNI1
line 109
;109:	trap_FS_FCloseFile( f );
ADDRLP4 20032
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 112
;110:
;111:	// parse the text
;112:	text_p = text;
ADDRLP4 12
ADDRLP4 32
ASGNP4
line 113
;113:	skip = 0;	// quite the compiler warning
ADDRLP4 24
CNSTI4 0
ASGNI4
line 115
;114:
;115:	ci->footsteps = FOOTSTEP_NORMAL;
ADDRFP4 4
INDIRP4
CNSTI4 528
ADDP4
CNSTI4 0
ASGNI4
line 116
;116:	VectorClear( ci->headOffset );
ADDRLP4 20040
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 20044
CNSTF4 0
ASGNF4
ADDRLP4 20040
INDIRP4
CNSTI4 524
ADDP4
ADDRLP4 20044
INDIRF4
ASGNF4
ADDRLP4 20040
INDIRP4
CNSTI4 520
ADDP4
ADDRLP4 20044
INDIRF4
ASGNF4
ADDRLP4 20040
INDIRP4
CNSTI4 516
ADDP4
ADDRLP4 20044
INDIRF4
ASGNF4
line 117
;117:	ci->gender = GENDER_MALE;
ADDRFP4 4
INDIRP4
CNSTI4 532
ADDP4
CNSTI4 0
ASGNI4
line 118
;118:	ci->fixedlegs = qfalse;
ADDRFP4 4
INDIRP4
CNSTI4 508
ADDP4
CNSTI4 0
ASGNI4
line 119
;119:	ci->fixedtorso = qfalse;
ADDRFP4 4
INDIRP4
CNSTI4 512
ADDP4
CNSTI4 0
ASGNI4
ADDRGP4 $168
JUMPV
LABELV $167
line 122
;120:
;121:	// read optional parameters
;122:	while ( 1 ) {
line 123
;123:		prev = text_p;	// so we can unget
ADDRLP4 20
ADDRLP4 12
INDIRP4
ASGNP4
line 124
;124:		token = COM_Parse( &text_p );
ADDRLP4 12
ARGP4
ADDRLP4 20048
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20048
INDIRP4
ASGNP4
line 125
;125:		if ( !token ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $170
line 126
;126:			break;
ADDRGP4 $169
JUMPV
LABELV $170
line 128
;127:		}
;128:		if ( !Q_stricmp( token, "footsteps" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $174
ARGP4
ADDRLP4 20052
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20052
INDIRI4
CNSTI4 0
NEI4 $172
line 129
;129:			token = COM_Parse( &text_p );
ADDRLP4 12
ARGP4
ADDRLP4 20056
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20056
INDIRP4
ASGNP4
line 130
;130:			if ( !token ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $175
line 131
;131:				break;
ADDRGP4 $169
JUMPV
LABELV $175
line 133
;132:			}
;133:			if ( !Q_stricmp( token, "default" ) || !Q_stricmp( token, "normal" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $179
ARGP4
ADDRLP4 20060
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20060
INDIRI4
CNSTI4 0
EQI4 $181
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $180
ARGP4
ADDRLP4 20064
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20064
INDIRI4
CNSTI4 0
NEI4 $177
LABELV $181
line 134
;134:				ci->footsteps = FOOTSTEP_NORMAL;
ADDRFP4 4
INDIRP4
CNSTI4 528
ADDP4
CNSTI4 0
ASGNI4
line 135
;135:			} else if ( !Q_stricmp( token, "boot" ) ) {
ADDRGP4 $168
JUMPV
LABELV $177
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $184
ARGP4
ADDRLP4 20068
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20068
INDIRI4
CNSTI4 0
NEI4 $182
line 136
;136:				ci->footsteps = FOOTSTEP_BOOT;
ADDRFP4 4
INDIRP4
CNSTI4 528
ADDP4
CNSTI4 1
ASGNI4
line 137
;137:			} else if ( !Q_stricmp( token, "flesh" ) ) {
ADDRGP4 $168
JUMPV
LABELV $182
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $187
ARGP4
ADDRLP4 20072
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20072
INDIRI4
CNSTI4 0
NEI4 $185
line 138
;138:				ci->footsteps = FOOTSTEP_FLESH;
ADDRFP4 4
INDIRP4
CNSTI4 528
ADDP4
CNSTI4 2
ASGNI4
line 139
;139:			} else if ( !Q_stricmp( token, "mech" ) ) {
ADDRGP4 $168
JUMPV
LABELV $185
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $190
ARGP4
ADDRLP4 20076
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20076
INDIRI4
CNSTI4 0
NEI4 $188
line 140
;140:				ci->footsteps = FOOTSTEP_MECH;
ADDRFP4 4
INDIRP4
CNSTI4 528
ADDP4
CNSTI4 3
ASGNI4
line 141
;141:			} else if ( !Q_stricmp( token, "energy" ) ) {
ADDRGP4 $168
JUMPV
LABELV $188
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $193
ARGP4
ADDRLP4 20080
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20080
INDIRI4
CNSTI4 0
NEI4 $191
line 142
;142:				ci->footsteps = FOOTSTEP_ENERGY;
ADDRFP4 4
INDIRP4
CNSTI4 528
ADDP4
CNSTI4 4
ASGNI4
line 143
;143:			} else {
ADDRGP4 $168
JUMPV
LABELV $191
line 144
;144:				CG_Printf( "Bad footsteps parm in %s: %s\n", filename, token );
ADDRGP4 $194
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 145
;145:			}
line 146
;146:			continue;
ADDRGP4 $168
JUMPV
LABELV $172
line 147
;147:		} else if ( !Q_stricmp( token, "headoffset" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $197
ARGP4
ADDRLP4 20056
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20056
INDIRI4
CNSTI4 0
NEI4 $195
line 148
;148:			for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $198
line 149
;149:				token = COM_Parse( &text_p );
ADDRLP4 12
ARGP4
ADDRLP4 20060
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20060
INDIRP4
ASGNP4
line 150
;150:				if ( !token ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $202
line 151
;151:					break;
ADDRGP4 $168
JUMPV
LABELV $202
line 153
;152:				}
;153:				ci->headOffset[i] = atof( token );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20064
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
ADDP4
ADDRLP4 20064
INDIRF4
ASGNF4
line 154
;154:			}
LABELV $199
line 148
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 3
LTI4 $198
line 155
;155:			continue;
ADDRGP4 $168
JUMPV
LABELV $195
line 156
;156:		} else if ( !Q_stricmp( token, "sex" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $206
ARGP4
ADDRLP4 20060
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20060
INDIRI4
CNSTI4 0
NEI4 $204
line 157
;157:			token = COM_Parse( &text_p );
ADDRLP4 12
ARGP4
ADDRLP4 20064
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20064
INDIRP4
ASGNP4
line 158
;158:			if ( !token ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $207
line 159
;159:				break;
ADDRGP4 $169
JUMPV
LABELV $207
line 161
;160:			}
;161:			if ( token[0] == 'f' || token[0] == 'F' ) {
ADDRLP4 20068
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 20068
INDIRI4
CNSTI4 102
EQI4 $211
ADDRLP4 20068
INDIRI4
CNSTI4 70
NEI4 $209
LABELV $211
line 162
;162:				ci->gender = GENDER_FEMALE;
ADDRFP4 4
INDIRP4
CNSTI4 532
ADDP4
CNSTI4 1
ASGNI4
line 163
;163:			} else if ( token[0] == 'n' || token[0] == 'N' ) {
ADDRGP4 $168
JUMPV
LABELV $209
ADDRLP4 20072
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 20072
INDIRI4
CNSTI4 110
EQI4 $214
ADDRLP4 20072
INDIRI4
CNSTI4 78
NEI4 $212
LABELV $214
line 164
;164:				ci->gender = GENDER_NEUTER;
ADDRFP4 4
INDIRP4
CNSTI4 532
ADDP4
CNSTI4 2
ASGNI4
line 165
;165:			} else {
ADDRGP4 $168
JUMPV
LABELV $212
line 166
;166:				ci->gender = GENDER_MALE;
ADDRFP4 4
INDIRP4
CNSTI4 532
ADDP4
CNSTI4 0
ASGNI4
line 167
;167:			}
line 168
;168:			continue;
ADDRGP4 $168
JUMPV
LABELV $204
line 169
;169:		} else if ( !Q_stricmp( token, "fixedlegs" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $217
ARGP4
ADDRLP4 20064
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20064
INDIRI4
CNSTI4 0
NEI4 $215
line 170
;170:			ci->fixedlegs = qtrue;
ADDRFP4 4
INDIRP4
CNSTI4 508
ADDP4
CNSTI4 1
ASGNI4
line 171
;171:			continue;
ADDRGP4 $168
JUMPV
LABELV $215
line 172
;172:		} else if ( !Q_stricmp( token, "fixedtorso" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $220
ARGP4
ADDRLP4 20068
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20068
INDIRI4
CNSTI4 0
NEI4 $218
line 173
;173:			ci->fixedtorso = qtrue;
ADDRFP4 4
INDIRP4
CNSTI4 512
ADDP4
CNSTI4 1
ASGNI4
line 174
;174:			continue;
ADDRGP4 $168
JUMPV
LABELV $218
line 178
;175:		}
;176:
;177:		// if it is a number, start parsing animations
;178:		if ( token[0] >= '0' && token[0] <= '9' ) {
ADDRLP4 20072
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 20072
INDIRI4
CNSTI4 48
LTI4 $221
ADDRLP4 20072
INDIRI4
CNSTI4 57
GTI4 $221
line 179
;179:			text_p = prev;	// unget the token
ADDRLP4 12
ADDRLP4 20
INDIRP4
ASGNP4
line 180
;180:			break;
ADDRGP4 $169
JUMPV
LABELV $221
line 182
;181:		}
;182:		Com_Printf( "unknown token '%s' is %s\n", token, filename );
ADDRGP4 $223
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 183
;183:	}
LABELV $168
line 122
ADDRGP4 $167
JUMPV
LABELV $169
line 186
;184:
;185:	// read information for each frame
;186:	for ( i = 0 ; i < MAX_ANIMATIONS ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $224
line 188
;187:
;188:		token = COM_Parse( &text_p );
ADDRLP4 12
ARGP4
ADDRLP4 20048
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20048
INDIRP4
ASGNP4
line 189
;189:		if ( !*token ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $228
line 190
;190:			if( i >= TORSO_GETFLAG && i <= TORSO_NEGATIVE ) {
ADDRLP4 4
INDIRI4
CNSTI4 25
LTI4 $226
ADDRLP4 4
INDIRI4
CNSTI4 30
GTI4 $226
line 191
;191:				animations[i].firstFrame = animations[TORSO_GESTURE].firstFrame;
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 192
;192:				animations[i].frameLerp = animations[TORSO_GESTURE].frameLerp;
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 12
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ASGNI4
line 193
;193:				animations[i].initialLerp = animations[TORSO_GESTURE].initialLerp;
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 16
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 194
;194:				animations[i].loopFrames = animations[TORSO_GESTURE].loopFrames;
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 8
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ASGNI4
line 195
;195:				animations[i].numFrames = animations[TORSO_GESTURE].numFrames;
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 4
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
ASGNI4
line 196
;196:				animations[i].reversed = qfalse;
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 20
ADDP4
CNSTI4 0
ASGNI4
line 197
;197:				animations[i].flipflop = qfalse;
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 24
ADDP4
CNSTI4 0
ASGNI4
line 198
;198:				continue;
ADDRGP4 $225
JUMPV
line 200
;199:			}
;200:			break;
LABELV $228
line 202
;201:		}
;202:		animations[i].firstFrame = atoi( token );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20052
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
ADDRLP4 20052
INDIRI4
ASGNI4
line 204
;203:		// leg only frames are adjusted to not count the upper body only frames
;204:		if ( i == LEGS_WALKCR ) {
ADDRLP4 4
INDIRI4
CNSTI4 13
NEI4 $232
line 205
;205:			skip = animations[LEGS_WALKCR].firstFrame - animations[TORSO_GESTURE].firstFrame;
ADDRLP4 24
ADDRLP4 8
INDIRP4
CNSTI4 364
ADDP4
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
SUBI4
ASGNI4
line 206
;206:		}
LABELV $232
line 207
;207:		if ( i >= LEGS_WALKCR && i<TORSO_GETFLAG) {
ADDRLP4 4
INDIRI4
CNSTI4 13
LTI4 $234
ADDRLP4 4
INDIRI4
CNSTI4 25
GEI4 $234
line 208
;208:			animations[i].firstFrame -= skip;
ADDRLP4 20060
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
ASGNP4
ADDRLP4 20060
INDIRP4
ADDRLP4 20060
INDIRP4
INDIRI4
ADDRLP4 24
INDIRI4
SUBI4
ASGNI4
line 209
;209:		}
LABELV $234
line 211
;210:
;211:		token = COM_Parse( &text_p );
ADDRLP4 12
ARGP4
ADDRLP4 20060
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20060
INDIRP4
ASGNP4
line 212
;212:		if ( !*token ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $236
line 213
;213:			break;
ADDRGP4 $226
JUMPV
LABELV $236
line 215
;214:		}
;215:		animations[i].numFrames = atoi( token );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20064
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 4
ADDP4
ADDRLP4 20064
INDIRI4
ASGNI4
line 217
;216:
;217:		animations[i].reversed = qfalse;
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 20
ADDP4
CNSTI4 0
ASGNI4
line 218
;218:		animations[i].flipflop = qfalse;
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 24
ADDP4
CNSTI4 0
ASGNI4
line 220
;219:		// if numFrames is negative the animation is reversed
;220:		if (animations[i].numFrames < 0) {
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 0
GEI4 $238
line 221
;221:			animations[i].numFrames = -animations[i].numFrames;
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 4
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 4
ADDP4
INDIRI4
NEGI4
ASGNI4
line 222
;222:			animations[i].reversed = qtrue;
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 20
ADDP4
CNSTI4 1
ASGNI4
line 223
;223:		}
LABELV $238
line 225
;224:
;225:		token = COM_Parse( &text_p );
ADDRLP4 12
ARGP4
ADDRLP4 20068
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20068
INDIRP4
ASGNP4
line 226
;226:		if ( !*token ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $240
line 227
;227:			break;
ADDRGP4 $226
JUMPV
LABELV $240
line 229
;228:		}
;229:		animations[i].loopFrames = atoi( token );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20072
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 8
ADDP4
ADDRLP4 20072
INDIRI4
ASGNI4
line 231
;230:
;231:		token = COM_Parse( &text_p );
ADDRLP4 12
ARGP4
ADDRLP4 20076
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20076
INDIRP4
ASGNP4
line 232
;232:		if ( !*token ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $242
line 233
;233:			break;
ADDRGP4 $226
JUMPV
LABELV $242
line 235
;234:		}
;235:		fps = atof( token );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20080
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 20080
INDIRF4
ASGNF4
line 236
;236:		if ( fps == 0 ) {
ADDRLP4 16
INDIRF4
CNSTF4 0
NEF4 $244
line 237
;237:			fps = 1;
ADDRLP4 16
CNSTF4 1065353216
ASGNF4
line 238
;238:		}
LABELV $244
line 239
;239:		animations[i].frameLerp = 1000 / fps;
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 12
ADDP4
CNSTF4 1148846080
ADDRLP4 16
INDIRF4
DIVF4
CVFI4 4
ASGNI4
line 240
;240:		animations[i].initialLerp = 1000 / fps;
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 16
ADDP4
CNSTF4 1148846080
ADDRLP4 16
INDIRF4
DIVF4
CVFI4 4
ASGNI4
line 241
;241:	}
LABELV $225
line 186
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 31
LTI4 $224
LABELV $226
line 243
;242:
;243:	if ( i != MAX_ANIMATIONS ) {
ADDRLP4 4
INDIRI4
CNSTI4 31
EQI4 $246
line 244
;244:		CG_Printf( "Error parsing animation file: %s", filename );
ADDRGP4 $248
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 245
;245:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $161
JUMPV
LABELV $246
line 249
;246:	}
;247:
;248:	// crouch backward animation
;249:	memcpy(&animations[LEGS_BACKCR], &animations[LEGS_WALKCR], sizeof(animation_t));
ADDRLP4 8
INDIRP4
CNSTI4 896
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 364
ADDP4
ARGP4
CNSTI4 28
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 250
;250:	animations[LEGS_BACKCR].reversed = qtrue;
ADDRLP4 8
INDIRP4
CNSTI4 916
ADDP4
CNSTI4 1
ASGNI4
line 252
;251:	// walk backward animation
;252:	memcpy(&animations[LEGS_BACKWALK], &animations[LEGS_WALK], sizeof(animation_t));
ADDRLP4 8
INDIRP4
CNSTI4 924
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 392
ADDP4
ARGP4
CNSTI4 28
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 253
;253:	animations[LEGS_BACKWALK].reversed = qtrue;
ADDRLP4 8
INDIRP4
CNSTI4 944
ADDP4
CNSTI4 1
ASGNI4
line 255
;254:	// flag moving fast
;255:	animations[FLAG_RUN].firstFrame = 0;
ADDRLP4 8
INDIRP4
CNSTI4 952
ADDP4
CNSTI4 0
ASGNI4
line 256
;256:	animations[FLAG_RUN].numFrames = 16;
ADDRLP4 8
INDIRP4
CNSTI4 956
ADDP4
CNSTI4 16
ASGNI4
line 257
;257:	animations[FLAG_RUN].loopFrames = 16;
ADDRLP4 8
INDIRP4
CNSTI4 960
ADDP4
CNSTI4 16
ASGNI4
line 258
;258:	animations[FLAG_RUN].frameLerp = 1000 / 15;
ADDRLP4 8
INDIRP4
CNSTI4 964
ADDP4
CNSTI4 66
ASGNI4
line 259
;259:	animations[FLAG_RUN].initialLerp = 1000 / 15;
ADDRLP4 8
INDIRP4
CNSTI4 968
ADDP4
CNSTI4 66
ASGNI4
line 260
;260:	animations[FLAG_RUN].reversed = qfalse;
ADDRLP4 8
INDIRP4
CNSTI4 972
ADDP4
CNSTI4 0
ASGNI4
line 262
;261:	// flag not moving or moving slowly
;262:	animations[FLAG_STAND].firstFrame = 16;
ADDRLP4 8
INDIRP4
CNSTI4 980
ADDP4
CNSTI4 16
ASGNI4
line 263
;263:	animations[FLAG_STAND].numFrames = 5;
ADDRLP4 8
INDIRP4
CNSTI4 984
ADDP4
CNSTI4 5
ASGNI4
line 264
;264:	animations[FLAG_STAND].loopFrames = 0;
ADDRLP4 8
INDIRP4
CNSTI4 988
ADDP4
CNSTI4 0
ASGNI4
line 265
;265:	animations[FLAG_STAND].frameLerp = 1000 / 20;
ADDRLP4 8
INDIRP4
CNSTI4 992
ADDP4
CNSTI4 50
ASGNI4
line 266
;266:	animations[FLAG_STAND].initialLerp = 1000 / 20;
ADDRLP4 8
INDIRP4
CNSTI4 996
ADDP4
CNSTI4 50
ASGNI4
line 267
;267:	animations[FLAG_STAND].reversed = qfalse;
ADDRLP4 8
INDIRP4
CNSTI4 1000
ADDP4
CNSTI4 0
ASGNI4
line 269
;268:	// flag speeding up
;269:	animations[FLAG_STAND2RUN].firstFrame = 16;
ADDRLP4 8
INDIRP4
CNSTI4 1008
ADDP4
CNSTI4 16
ASGNI4
line 270
;270:	animations[FLAG_STAND2RUN].numFrames = 5;
ADDRLP4 8
INDIRP4
CNSTI4 1012
ADDP4
CNSTI4 5
ASGNI4
line 271
;271:	animations[FLAG_STAND2RUN].loopFrames = 1;
ADDRLP4 8
INDIRP4
CNSTI4 1016
ADDP4
CNSTI4 1
ASGNI4
line 272
;272:	animations[FLAG_STAND2RUN].frameLerp = 1000 / 15;
ADDRLP4 8
INDIRP4
CNSTI4 1020
ADDP4
CNSTI4 66
ASGNI4
line 273
;273:	animations[FLAG_STAND2RUN].initialLerp = 1000 / 15;
ADDRLP4 8
INDIRP4
CNSTI4 1024
ADDP4
CNSTI4 66
ASGNI4
line 274
;274:	animations[FLAG_STAND2RUN].reversed = qtrue;
ADDRLP4 8
INDIRP4
CNSTI4 1028
ADDP4
CNSTI4 1
ASGNI4
line 284
;275:	//
;276:	// new anims changes
;277:	//
;278://	animations[TORSO_GETFLAG].flipflop = qtrue;
;279://	animations[TORSO_GUARDBASE].flipflop = qtrue;
;280://	animations[TORSO_PATROL].flipflop = qtrue;
;281://	animations[TORSO_AFFIRMATIVE].flipflop = qtrue;
;282://	animations[TORSO_NEGATIVE].flipflop = qtrue;
;283:	//
;284:	return qtrue;
CNSTI4 1
RETI4
LABELV $161
endproc CG_ParseAnimationFile 20084 12
proc CG_FileExists 12 12
line 292
;285:}
;286:
;287:/*
;288:==========================
;289:CG_FileExists
;290:==========================
;291:*/
;292:static qboolean	CG_FileExists(const char *filename) {
line 298
;293:	int len;
;294:
;295:#if 0	// JUHOX: make it compatible to version 1.27g
;296:	len = trap_FS_FOpenFile( filename, 0, FS_READ );
;297:#else
;298:	{
line 301
;299:		fileHandle_t f;
;300:
;301:		len = trap_FS_FOpenFile(filename, &f, FS_READ);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 302
;302:		if (f) trap_FS_FCloseFile(f);
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $250
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
LABELV $250
line 303
;303:	}
line 305
;304:#endif
;305:	if (len>0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $252
line 306
;306:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $249
JUMPV
LABELV $252
line 308
;307:	}
;308:	return qfalse;
CNSTI4 0
RETI4
LABELV $249
endproc CG_FileExists 12 12
proc CG_FindClientModelFile 28 40
line 316
;309:}
;310:
;311:/*
;312:==========================
;313:CG_FindClientModelFile
;314:==========================
;315:*/
;316:static qboolean	CG_FindClientModelFile( char *filename, int length, clientInfo_t *ci, const char *teamName, const char *modelName, const char *skinName, const char *base, const char *ext ) {
line 323
;317:	char *team, *charactersFolder;
;318:	int i;
;319:
;320:#if !MONSTER_MODE	// JUHOX: use default skin in STU
;321:	if ( cgs.gametype >= GT_TEAM ) {
;322:#else
;323:	if (cgs.gametype >= GT_TEAM && cgs.gametype < GT_STU) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $255
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 8
GEI4 $255
line 325
;324:#endif
;325:		switch ( ci->team ) {
ADDRLP4 12
ADDRFP4 8
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 2
EQI4 $262
ADDRGP4 $259
JUMPV
LABELV $262
line 326
;326:			case TEAM_BLUE: {
line 327
;327:				team = "blue";
ADDRLP4 8
ADDRGP4 $263
ASGNP4
line 328
;328:				break;
ADDRGP4 $256
JUMPV
LABELV $259
line 330
;329:			}
;330:			default: {
line 331
;331:				team = "red";
ADDRLP4 8
ADDRGP4 $264
ASGNP4
line 332
;332:				break;
line 335
;333:			}
;334:		}
;335:	}
ADDRGP4 $256
JUMPV
LABELV $255
line 336
;336:	else {
line 337
;337:		team = "default";
ADDRLP4 8
ADDRGP4 $179
ASGNP4
line 338
;338:	}
LABELV $256
line 339
;339:	charactersFolder = "";
ADDRLP4 4
ADDRGP4 $265
ASGNP4
ADDRGP4 $267
JUMPV
LABELV $266
line 340
;340:	while(1) {
line 341
;341:		for ( i = 0; i < 2; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $269
line 342
;342:			if ( i == 0 && teamName && *teamName ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $273
ADDRLP4 12
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $273
ADDRLP4 12
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $273
line 344
;343:				//								"models/players/characters/james/stroggs/lower_lily_red.skin"
;344:				Com_sprintf( filename, length, "models/players/%s%s/%s%s_%s_%s.%s", charactersFolder, modelName, teamName, base, skinName, team, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $275
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 345
;345:			}
ADDRGP4 $274
JUMPV
LABELV $273
line 346
;346:			else {
line 348
;347:				//								"models/players/characters/james/lower_lily_red.skin"
;348:				Com_sprintf( filename, length, "models/players/%s%s/%s_%s_%s.%s", charactersFolder, modelName, base, skinName, team, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $276
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 349
;349:			}
LABELV $274
line 350
;350:			if ( CG_FileExists( filename ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $277
line 351
;351:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $254
JUMPV
LABELV $277
line 356
;352:			}
;353:#if !MONSTER_MODE	// JUHOX: use default skin in STU
;354:			if ( cgs.gametype >= GT_TEAM ) {
;355:#else
;356:			if (cgs.gametype >= GT_TEAM && cgs.gametype < GT_STU) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $279
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 8
GEI4 $279
line 358
;357:#endif
;358:				if ( i == 0 && teamName && *teamName ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $283
ADDRLP4 20
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $283
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $283
line 360
;359:					//								"models/players/characters/james/stroggs/lower_red.skin"
;360:					Com_sprintf( filename, length, "models/players/%s%s/%s%s_%s.%s", charactersFolder, modelName, teamName, base, team, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $285
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 361
;361:				}
ADDRGP4 $280
JUMPV
LABELV $283
line 362
;362:				else {
line 364
;363:					//								"models/players/characters/james/lower_red.skin"
;364:					Com_sprintf( filename, length, "models/players/%s%s/%s_%s.%s", charactersFolder, modelName, base, team, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $286
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 365
;365:				}
line 366
;366:			}
ADDRGP4 $280
JUMPV
LABELV $279
line 367
;367:			else {
line 368
;368:				if ( i == 0 && teamName && *teamName ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $287
ADDRLP4 20
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $287
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $287
line 370
;369:					//								"models/players/characters/james/stroggs/lower_lily.skin"
;370:					Com_sprintf( filename, length, "models/players/%s%s/%s%s_%s.%s", charactersFolder, modelName, teamName, base, skinName, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $285
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 371
;371:				}
ADDRGP4 $288
JUMPV
LABELV $287
line 372
;372:				else {
line 374
;373:					//								"models/players/characters/james/lower_lily.skin"
;374:					Com_sprintf( filename, length, "models/players/%s%s/%s_%s.%s", charactersFolder, modelName, base, skinName, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $286
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 375
;375:				}
LABELV $288
line 376
;376:			}
LABELV $280
line 377
;377:			if ( CG_FileExists( filename ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $289
line 378
;378:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $254
JUMPV
LABELV $289
line 380
;379:			}
;380:			if ( !teamName || !*teamName ) {
ADDRLP4 24
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $293
ADDRLP4 24
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $291
LABELV $293
line 381
;381:				break;
ADDRGP4 $271
JUMPV
LABELV $291
line 383
;382:			}
;383:		}
LABELV $270
line 341
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LTI4 $269
LABELV $271
line 385
;384:		// if tried the heads folder first
;385:		if ( charactersFolder[0] ) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $294
line 386
;386:			break;
ADDRGP4 $268
JUMPV
LABELV $294
line 388
;387:		}
;388:		charactersFolder = "characters/";
ADDRLP4 4
ADDRGP4 $296
ASGNP4
line 389
;389:	}
LABELV $267
line 340
ADDRGP4 $266
JUMPV
LABELV $268
line 391
;390:
;391:	return qfalse;
CNSTI4 0
RETI4
LABELV $254
endproc CG_FindClientModelFile 28 40
proc CG_FindClientHeadFile 28 40
line 399
;392:}
;393:
;394:/*
;395:==========================
;396:CG_FindClientHeadFile
;397:==========================
;398:*/
;399:static qboolean	CG_FindClientHeadFile( char *filename, int length, clientInfo_t *ci, const char *teamName, const char *headModelName, const char *headSkinName, const char *base, const char *ext ) {
line 406
;400:	char *team, *headsFolder;
;401:	int i;
;402:
;403:#if !MONSTER_MODE	// JUHOX: use default skin in STU
;404:	if ( cgs.gametype >= GT_TEAM ) {
;405:#else
;406:	if (cgs.gametype >= GT_TEAM && cgs.gametype < GT_STU) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $298
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 8
GEI4 $298
line 408
;407:#endif
;408:		switch ( ci->team ) {
ADDRLP4 12
ADDRFP4 8
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 2
EQI4 $305
ADDRGP4 $302
JUMPV
LABELV $305
line 409
;409:			case TEAM_BLUE: {
line 410
;410:				team = "blue";
ADDRLP4 8
ADDRGP4 $263
ASGNP4
line 411
;411:				break;
ADDRGP4 $299
JUMPV
LABELV $302
line 413
;412:			}
;413:			default: {
line 414
;414:				team = "red";
ADDRLP4 8
ADDRGP4 $264
ASGNP4
line 415
;415:				break;
line 418
;416:			}
;417:		}
;418:	}
ADDRGP4 $299
JUMPV
LABELV $298
line 419
;419:	else {
line 420
;420:		team = "default";
ADDRLP4 8
ADDRGP4 $179
ASGNP4
line 421
;421:	}
LABELV $299
line 423
;422:
;423:	if ( headModelName[0] == '*' ) {
ADDRFP4 16
INDIRP4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $306
line 424
;424:		headsFolder = "heads/";
ADDRLP4 4
ADDRGP4 $308
ASGNP4
line 425
;425:		headModelName++;
ADDRFP4 16
ADDRFP4 16
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 426
;426:	}
ADDRGP4 $310
JUMPV
LABELV $306
line 427
;427:	else {
line 428
;428:		headsFolder = "";
ADDRLP4 4
ADDRGP4 $265
ASGNP4
line 429
;429:	}
ADDRGP4 $310
JUMPV
LABELV $309
line 430
;430:	while(1) {
line 431
;431:		for ( i = 0; i < 2; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $312
line 432
;432:			if ( i == 0 && teamName && *teamName ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $316
ADDRLP4 12
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $316
ADDRLP4 12
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $316
line 433
;433:				Com_sprintf( filename, length, "models/players/%s%s/%s/%s%s_%s.%s", headsFolder, headModelName, headSkinName, teamName, base, team, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $318
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 434
;434:			}
ADDRGP4 $317
JUMPV
LABELV $316
line 435
;435:			else {
line 436
;436:				Com_sprintf( filename, length, "models/players/%s%s/%s/%s_%s.%s", headsFolder, headModelName, headSkinName, base, team, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $319
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 437
;437:			}
LABELV $317
line 438
;438:			if ( CG_FileExists( filename ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $320
line 439
;439:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $297
JUMPV
LABELV $320
line 444
;440:			}
;441:#if !MONSTER_MODE	// JUHOX: use default skin in STU
;442:			if ( cgs.gametype >= GT_TEAM ) {
;443:#else
;444:			if (cgs.gametype >= GT_TEAM && cgs.gametype < GT_STU) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $322
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 8
GEI4 $322
line 446
;445:#endif
;446:				if ( i == 0 &&  teamName && *teamName ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $326
ADDRLP4 20
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $326
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $326
line 447
;447:					Com_sprintf( filename, length, "models/players/%s%s/%s%s_%s.%s", headsFolder, headModelName, teamName, base, team, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $285
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 448
;448:				}
ADDRGP4 $323
JUMPV
LABELV $326
line 449
;449:				else {
line 450
;450:					Com_sprintf( filename, length, "models/players/%s%s/%s_%s.%s", headsFolder, headModelName, base, team, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $286
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 451
;451:				}
line 452
;452:			}
ADDRGP4 $323
JUMPV
LABELV $322
line 453
;453:			else {
line 454
;454:				if ( i == 0 && teamName && *teamName ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $328
ADDRLP4 20
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $328
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $328
line 455
;455:					Com_sprintf( filename, length, "models/players/%s%s/%s%s_%s.%s", headsFolder, headModelName, teamName, base, headSkinName, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $285
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 456
;456:				}
ADDRGP4 $329
JUMPV
LABELV $328
line 457
;457:				else {
line 458
;458:					Com_sprintf( filename, length, "models/players/%s%s/%s_%s.%s", headsFolder, headModelName, base, headSkinName, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $286
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 459
;459:				}
LABELV $329
line 460
;460:			}
LABELV $323
line 461
;461:			if ( CG_FileExists( filename ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $330
line 462
;462:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $297
JUMPV
LABELV $330
line 464
;463:			}
;464:			if ( !teamName || !*teamName ) {
ADDRLP4 24
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $334
ADDRLP4 24
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $332
LABELV $334
line 465
;465:				break;
ADDRGP4 $314
JUMPV
LABELV $332
line 467
;466:			}
;467:		}
LABELV $313
line 431
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LTI4 $312
LABELV $314
line 469
;468:		// if tried the heads folder first
;469:		if ( headsFolder[0] ) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $335
line 470
;470:			break;
ADDRGP4 $311
JUMPV
LABELV $335
line 472
;471:		}
;472:		headsFolder = "heads/";
ADDRLP4 4
ADDRGP4 $308
ASGNP4
line 473
;473:	}
LABELV $310
line 430
ADDRGP4 $309
JUMPV
LABELV $311
line 475
;474:
;475:	return qfalse;
CNSTI4 0
RETI4
LABELV $297
endproc CG_FindClientHeadFile 28 40
proc CG_RegisterClientSkin 80 32
line 483
;476:}
;477:
;478:/*
;479:==========================
;480:CG_RegisterClientSkin
;481:==========================
;482:*/
;483:static qboolean	CG_RegisterClientSkin( clientInfo_t *ci, const char *teamName, const char *modelName, const char *skinName, const char *headModelName, const char *headSkinName ) {
line 508
;484:	char filename[MAX_QPATH];
;485:
;486:	/*
;487:	Com_sprintf( filename, sizeof( filename ), "models/players/%s/%slower_%s.skin", modelName, teamName, skinName );
;488:	ci->legsSkin = trap_R_RegisterSkin( filename );
;489:	if (!ci->legsSkin) {
;490:		Com_sprintf( filename, sizeof( filename ), "models/players/characters/%s/%slower_%s.skin", modelName, teamName, skinName );
;491:		ci->legsSkin = trap_R_RegisterSkin( filename );
;492:		if (!ci->legsSkin) {
;493:			Com_Printf( "Leg skin load failure: %s\n", filename );
;494:		}
;495:	}
;496:
;497:
;498:	Com_sprintf( filename, sizeof( filename ), "models/players/%s/%supper_%s.skin", modelName, teamName, skinName );
;499:	ci->torsoSkin = trap_R_RegisterSkin( filename );
;500:	if (!ci->torsoSkin) {
;501:		Com_sprintf( filename, sizeof( filename ), "models/players/characters/%s/%supper_%s.skin", modelName, teamName, skinName );
;502:		ci->torsoSkin = trap_R_RegisterSkin( filename );
;503:		if (!ci->torsoSkin) {
;504:			Com_Printf( "Torso skin load failure: %s\n", filename );
;505:		}
;506:	}
;507:	*/
;508:	if ( CG_FindClientModelFile( filename, sizeof(filename), ci, teamName, modelName, skinName, "lower", "skin" ) ) {
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 $340
ARGP4
ADDRGP4 $341
ARGP4
ADDRLP4 64
ADDRGP4 CG_FindClientModelFile
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
EQI4 $338
line 509
;509:		ci->legsSkin = trap_R_RegisterSkin( filename );
ADDRLP4 0
ARGP4
ADDRLP4 68
ADDRGP4 trap_R_RegisterSkin
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 540
ADDP4
ADDRLP4 68
INDIRI4
ASGNI4
line 510
;510:	}
LABELV $338
line 511
;511:	if (!ci->legsSkin) {
ADDRFP4 0
INDIRP4
CNSTI4 540
ADDP4
INDIRI4
CNSTI4 0
NEI4 $342
line 512
;512:		Com_Printf( "Leg skin load failure: %s\n", filename );
ADDRGP4 $344
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 513
;513:	}
LABELV $342
line 515
;514:
;515:	if ( CG_FindClientModelFile( filename, sizeof(filename), ci, teamName, modelName, skinName, "upper", "skin" ) ) {
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 $347
ARGP4
ADDRGP4 $341
ARGP4
ADDRLP4 68
ADDRGP4 CG_FindClientModelFile
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $345
line 516
;516:		ci->torsoSkin = trap_R_RegisterSkin( filename );
ADDRLP4 0
ARGP4
ADDRLP4 72
ADDRGP4 trap_R_RegisterSkin
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
ADDRLP4 72
INDIRI4
ASGNI4
line 517
;517:	}
LABELV $345
line 518
;518:	if (!ci->torsoSkin) {
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
CNSTI4 0
NEI4 $348
line 519
;519:		Com_Printf( "Torso skin load failure: %s\n", filename );
ADDRGP4 $350
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 520
;520:	}
LABELV $348
line 522
;521:
;522:	if ( CG_FindClientHeadFile( filename, sizeof(filename), ci, teamName, headModelName, headSkinName, "head", "skin" ) ) {
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRGP4 $353
ARGP4
ADDRGP4 $341
ARGP4
ADDRLP4 72
ADDRGP4 CG_FindClientHeadFile
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
EQI4 $351
line 523
;523:		ci->headSkin = trap_R_RegisterSkin( filename );
ADDRLP4 0
ARGP4
ADDRLP4 76
ADDRGP4 trap_R_RegisterSkin
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 556
ADDP4
ADDRLP4 76
INDIRI4
ASGNI4
line 524
;524:	}
LABELV $351
line 525
;525:	if (!ci->headSkin) {
ADDRFP4 0
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
CNSTI4 0
NEI4 $354
line 526
;526:		Com_Printf( "Head skin load failure: %s\n", filename );
ADDRGP4 $356
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 527
;527:	}
LABELV $354
line 530
;528:
;529:	// if any skins failed to load
;530:	if ( !ci->legsSkin || !ci->torsoSkin || !ci->headSkin ) {
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 540
ADDP4
INDIRI4
CNSTI4 0
EQI4 $360
ADDRLP4 76
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
CNSTI4 0
EQI4 $360
ADDRLP4 76
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
CNSTI4 0
NEI4 $357
LABELV $360
line 531
;531:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $337
JUMPV
LABELV $357
line 533
;532:	}
;533:	return qtrue;
CNSTI4 1
RETI4
LABELV $337
endproc CG_RegisterClientSkin 80 32
proc CG_RegisterClientModelname 296 32
line 541
;534:}
;535:
;536:/*
;537:==========================
;538:CG_RegisterClientModelname
;539:==========================
;540:*/
;541:static qboolean CG_RegisterClientModelname( clientInfo_t *ci, const char *modelName, const char *skinName, const char *headModelName, const char *headSkinName, const char *teamName ) {
line 546
;542:	char	filename[MAX_QPATH*2];
;543:	const char		*headName;
;544:	char newTeamName[MAX_QPATH*2];
;545:
;546:	if ( headModelName[0] == '\0' ) {
ADDRFP4 12
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $362
line 547
;547:		headName = modelName;
ADDRLP4 128
ADDRFP4 4
INDIRP4
ASGNP4
line 548
;548:	}
ADDRGP4 $363
JUMPV
LABELV $362
line 549
;549:	else {
line 550
;550:		headName = headModelName;
ADDRLP4 128
ADDRFP4 12
INDIRP4
ASGNP4
line 551
;551:	}
LABELV $363
line 552
;552:	Com_sprintf( filename, sizeof( filename ), "models/players/%s/lower.md3", modelName );
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $364
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 553
;553:	ci->legsModel = trap_R_RegisterModel( filename );
ADDRLP4 0
ARGP4
ADDRLP4 260
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
ADDRLP4 260
INDIRI4
ASGNI4
line 554
;554:	if ( !ci->legsModel ) {
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 0
NEI4 $365
line 555
;555:		Com_sprintf( filename, sizeof( filename ), "models/players/characters/%s/lower.md3", modelName );
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $367
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 556
;556:		ci->legsModel = trap_R_RegisterModel( filename );
ADDRLP4 0
ARGP4
ADDRLP4 264
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
ADDRLP4 264
INDIRI4
ASGNI4
line 557
;557:		if ( !ci->legsModel ) {
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 0
NEI4 $368
line 558
;558:			Com_Printf( "Failed to load model file %s\n", filename );
ADDRGP4 $370
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 559
;559:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $361
JUMPV
LABELV $368
line 561
;560:		}
;561:	}
LABELV $365
line 563
;562:
;563:	Com_sprintf( filename, sizeof( filename ), "models/players/%s/upper.md3", modelName );
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $371
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 564
;564:	ci->torsoModel = trap_R_RegisterModel( filename );
ADDRLP4 0
ARGP4
ADDRLP4 264
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
ADDRLP4 264
INDIRI4
ASGNI4
line 565
;565:	if ( !ci->torsoModel ) {
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
CNSTI4 0
NEI4 $372
line 566
;566:		Com_sprintf( filename, sizeof( filename ), "models/players/characters/%s/upper.md3", modelName );
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $374
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 567
;567:		ci->torsoModel = trap_R_RegisterModel( filename );
ADDRLP4 0
ARGP4
ADDRLP4 268
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
ADDRLP4 268
INDIRI4
ASGNI4
line 568
;568:		if ( !ci->torsoModel ) {
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
CNSTI4 0
NEI4 $375
line 569
;569:			Com_Printf( "Failed to load model file %s\n", filename );
ADDRGP4 $370
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 570
;570:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $361
JUMPV
LABELV $375
line 572
;571:		}
;572:	}
LABELV $372
line 574
;573:
;574:	if( headName[0] == '*' ) {
ADDRLP4 128
INDIRP4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $377
line 575
;575:		Com_sprintf( filename, sizeof( filename ), "models/players/heads/%s/%s.md3", &headModelName[1], &headModelName[1] );
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $379
ARGP4
ADDRLP4 268
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 268
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 268
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 576
;576:	}
ADDRGP4 $378
JUMPV
LABELV $377
line 577
;577:	else {
line 578
;578:		Com_sprintf( filename, sizeof( filename ), "models/players/%s/head.md3", headName );
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $380
ARGP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 579
;579:	}
LABELV $378
line 580
;580:	ci->headModel = trap_R_RegisterModel( filename );
ADDRLP4 0
ARGP4
ADDRLP4 268
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 552
ADDP4
ADDRLP4 268
INDIRI4
ASGNI4
line 582
;581:	// if the head model could not be found and we didn't load from the heads folder try to load from there
;582:	if ( !ci->headModel && headName[0] != '*' ) {
ADDRFP4 0
INDIRP4
CNSTI4 552
ADDP4
INDIRI4
CNSTI4 0
NEI4 $381
ADDRLP4 128
INDIRP4
INDIRI1
CVII4 1
CNSTI4 42
EQI4 $381
line 583
;583:		Com_sprintf( filename, sizeof( filename ), "models/players/heads/%s/%s.md3", headModelName, headModelName );
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $379
ARGP4
ADDRLP4 272
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 272
INDIRP4
ARGP4
ADDRLP4 272
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 584
;584:		ci->headModel = trap_R_RegisterModel( filename );
ADDRLP4 0
ARGP4
ADDRLP4 276
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 552
ADDP4
ADDRLP4 276
INDIRI4
ASGNI4
line 585
;585:	}
LABELV $381
line 586
;586:	if ( !ci->headModel ) {
ADDRFP4 0
INDIRP4
CNSTI4 552
ADDP4
INDIRI4
CNSTI4 0
NEI4 $383
line 587
;587:		Com_Printf( "Failed to load model file %s\n", filename );
ADDRGP4 $370
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 588
;588:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $361
JUMPV
LABELV $383
line 592
;589:	}
;590:
;591:	// if any skins failed to load, return failure
;592:	if ( !CG_RegisterClientSkin( ci, teamName, modelName, skinName, headName, headSkinName ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 272
ADDRGP4 CG_RegisterClientSkin
CALLI4
ASGNI4
ADDRLP4 272
INDIRI4
CNSTI4 0
NEI4 $385
line 593
;593:		if ( teamName && *teamName) {
ADDRLP4 276
ADDRFP4 20
INDIRP4
ASGNP4
ADDRLP4 276
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $387
ADDRLP4 276
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $387
line 594
;594:			Com_Printf( "Failed to load skin file: %s : %s : %s, %s : %s\n", teamName, modelName, skinName, headName, headSkinName );
ADDRGP4 $389
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 595
;595:			if( ci->team == TEAM_BLUE ) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
NEI4 $390
line 596
;596:				Com_sprintf(newTeamName, sizeof(newTeamName), "%s/", DEFAULT_BLUETEAM_NAME);
ADDRLP4 132
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $392
ARGP4
ADDRGP4 $393
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 597
;597:			}
ADDRGP4 $391
JUMPV
LABELV $390
line 598
;598:			else {
line 599
;599:				Com_sprintf(newTeamName, sizeof(newTeamName), "%s/", DEFAULT_REDTEAM_NAME);
ADDRLP4 132
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $392
ARGP4
ADDRGP4 $394
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 600
;600:			}
LABELV $391
line 601
;601:			if ( !CG_RegisterClientSkin( ci, newTeamName, modelName, skinName, headName, headSkinName ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 132
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 280
ADDRGP4 CG_RegisterClientSkin
CALLI4
ASGNI4
ADDRLP4 280
INDIRI4
CNSTI4 0
NEI4 $388
line 602
;602:				Com_Printf( "Failed to load skin file: %s : %s : %s, %s : %s\n", newTeamName, modelName, skinName, headName, headSkinName );
ADDRGP4 $389
ARGP4
ADDRLP4 132
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 603
;603:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $361
JUMPV
line 605
;604:			}
;605:		} else {
LABELV $387
line 606
;606:			Com_Printf( "Failed to load skin file: %s : %s, %s : %s\n", modelName, skinName, headName, headSkinName );
ADDRGP4 $397
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 607
;607:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $361
JUMPV
LABELV $388
line 609
;608:		}
;609:	}
LABELV $385
line 612
;610:
;611:	// load the animations
;612:	Com_sprintf( filename, sizeof( filename ), "models/players/%s/animation.cfg", modelName );
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $398
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 613
;613:	if ( !CG_ParseAnimationFile( filename, ci ) ) {
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 276
ADDRGP4 CG_ParseAnimationFile
CALLI4
ASGNI4
ADDRLP4 276
INDIRI4
CNSTI4 0
NEI4 $399
line 614
;614:		Com_sprintf( filename, sizeof( filename ), "models/players/characters/%s/animation.cfg", modelName );
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $401
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 615
;615:		if ( !CG_ParseAnimationFile( filename, ci ) ) {
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 280
ADDRGP4 CG_ParseAnimationFile
CALLI4
ASGNI4
ADDRLP4 280
INDIRI4
CNSTI4 0
NEI4 $402
line 616
;616:			Com_Printf( "Failed to load animation file %s\n", filename );
ADDRGP4 $404
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 617
;617:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $361
JUMPV
LABELV $402
line 619
;618:		}
;619:	}
LABELV $399
line 621
;620:
;621:	if ( CG_FindClientHeadFile( filename, sizeof(filename), ci, teamName, headName, headSkinName, "icon", "skin" ) ) {
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 $407
ARGP4
ADDRGP4 $341
ARGP4
ADDRLP4 280
ADDRGP4 CG_FindClientHeadFile
CALLI4
ASGNI4
ADDRLP4 280
INDIRI4
CNSTI4 0
EQI4 $405
line 622
;622:		ci->modelIcon = trap_R_RegisterShaderNoMip( filename );
ADDRLP4 0
ARGP4
ADDRLP4 284
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 560
ADDP4
ADDRLP4 284
INDIRI4
ASGNI4
line 623
;623:	}
ADDRGP4 $406
JUMPV
LABELV $405
line 624
;624:	else if ( CG_FindClientHeadFile( filename, sizeof(filename), ci, teamName, headName, headSkinName, "icon", "tga" ) ) {
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 $407
ARGP4
ADDRGP4 $410
ARGP4
ADDRLP4 284
ADDRGP4 CG_FindClientHeadFile
CALLI4
ASGNI4
ADDRLP4 284
INDIRI4
CNSTI4 0
EQI4 $408
line 625
;625:		ci->modelIcon = trap_R_RegisterShaderNoMip( filename );
ADDRLP4 0
ARGP4
ADDRLP4 288
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 560
ADDP4
ADDRLP4 288
INDIRI4
ASGNI4
line 626
;626:	}
LABELV $408
LABELV $406
line 628
;627:
;628:	if ( !ci->modelIcon ) {
ADDRFP4 0
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
CNSTI4 0
NEI4 $411
line 629
;629:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $361
JUMPV
LABELV $411
line 632
;630:	}
;631:#if 1	// JUHOX: fix some badly choosen gender characteristics (needed for correct panting)
;632:	if (!Q_stricmp(headName, "bones")) {
ADDRLP4 128
INDIRP4
ARGP4
ADDRGP4 $415
ARGP4
ADDRLP4 288
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 288
INDIRI4
CNSTI4 0
NEI4 $413
line 633
;633:		ci->gender = GENDER_NEUTER;
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
CNSTI4 2
ASGNI4
line 634
;634:	}
ADDRGP4 $414
JUMPV
LABELV $413
line 635
;635:	else if (!Q_stricmp(headName, "sorlag")) {
ADDRLP4 128
INDIRP4
ARGP4
ADDRGP4 $418
ARGP4
ADDRLP4 292
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 292
INDIRI4
CNSTI4 0
NEI4 $416
line 636
;636:		ci->gender = GENDER_NEUTER;
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
CNSTI4 2
ASGNI4
line 637
;637:	}
LABELV $416
LABELV $414
line 640
;638:#endif
;639:
;640:	return qtrue;
CNSTI4 1
RETI4
LABELV $361
endproc CG_RegisterClientModelname 296 32
proc CG_ColorFromString 20 4
line 649
;641:}
;642:
;643:
;644:/*
;645:====================
;646:CG_ColorFromString
;647:====================
;648:*/
;649:static void CG_ColorFromString( const char *v, vec3_t color ) {
line 652
;650:	int val;
;651:
;652:	VectorClear( color );
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 8
CNSTF4 0
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
ADDRLP4 4
INDIRP4
ADDRLP4 8
INDIRF4
ASGNF4
line 654
;653:
;654:	val = atoi( v );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 656
;655:
;656:	if ( val < 1 || val > 7 ) {
ADDRLP4 0
INDIRI4
CNSTI4 1
LTI4 $422
ADDRLP4 0
INDIRI4
CNSTI4 7
LEI4 $420
LABELV $422
line 657
;657:		VectorSet( color, 1, 1, 1 );
ADDRFP4 4
INDIRP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 1065353216
ASGNF4
line 658
;658:		return;
ADDRGP4 $419
JUMPV
LABELV $420
line 661
;659:	}
;660:
;661:	if ( val & 1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $423
line 662
;662:		color[2] = 1.0f;
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 1065353216
ASGNF4
line 663
;663:	}
LABELV $423
line 664
;664:	if ( val & 2 ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $425
line 665
;665:		color[1] = 1.0f;
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 1065353216
ASGNF4
line 666
;666:	}
LABELV $425
line 667
;667:	if ( val & 4 ) {
ADDRLP4 0
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $427
line 668
;668:		color[0] = 1.0f;
ADDRFP4 4
INDIRP4
CNSTF4 1065353216
ASGNF4
line 669
;669:	}
LABELV $427
line 670
;670:}
LABELV $419
endproc CG_ColorFromString 20 4
proc CG_LoadClientInfo 148 24
line 683
;671:
;672:/*
;673:===================
;674:CG_LoadClientInfo
;675:
;676:Load it now, taking the disk hits.
;677:This will usually be deferred to a safe time
;678:===================
;679:*/
;680:#if 0	// JUHOX: additional parameter for CG_LoadClientInfo()
;681:static void CG_LoadClientInfo( clientInfo_t *ci ) {
;682:#else
;683:static void CG_LoadClientInfo(clientInfo_t *ci, const char* defaultModel) {
line 691
;684:#endif
;685:	const char	*dir, *fallback;
;686:	int			i, modelloaded;
;687:	const char	*s;
;688:	int			clientNum;
;689:	char		teamname[MAX_QPATH];
;690:
;691:	teamname[0] = 0;
ADDRLP4 24
CNSTI1 0
ASGNI1
line 704
;692:#ifdef MISSIONPACK
;693:	if( cgs.gametype >= GT_TEAM) {
;694:		if( ci->team == TEAM_BLUE ) {
;695:			Q_strncpyz(teamname, cg_blueTeamName.string, sizeof(teamname) );
;696:		} else {
;697:			Q_strncpyz(teamname, cg_redTeamName.string, sizeof(teamname) );
;698:		}
;699:	}
;700:	if( teamname[0] ) {
;701:		strcat( teamname, "/" );
;702:	}
;703:#endif
;704:	modelloaded = qtrue;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 705
;705:	if ( !CG_RegisterClientModelname( ci, ci->modelName, ci->skinName, ci->headModelName, ci->headSkinName, teamname ) ) {
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRLP4 88
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 88
INDIRP4
CNSTI4 244
ADDP4
ARGP4
ADDRLP4 88
INDIRP4
CNSTI4 308
ADDP4
ARGP4
ADDRLP4 88
INDIRP4
CNSTI4 372
ADDP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 92
ADDRGP4 CG_RegisterClientModelname
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 0
NEI4 $430
line 707
;706:		
;707:		if ( cg_buildScript.integer ) {
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $432
line 708
;708:			CG_Error( "CG_RegisterClientModelname( %s, %s, %s, %s %s ) failed", ci->modelName, ci->skinName, ci->headModelName, ci->headSkinName, teamname );
ADDRGP4 $435
ARGP4
ADDRLP4 96
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 96
INDIRP4
CNSTI4 244
ADDP4
ARGP4
ADDRLP4 96
INDIRP4
CNSTI4 308
ADDP4
ARGP4
ADDRLP4 96
INDIRP4
CNSTI4 372
ADDP4
ARGP4
ADDRLP4 24
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 709
;709:		}
LABELV $432
line 713
;710:
;711:		// fall back
;712:#if MONSTER_MODE	// JUHOX: use default skin as fall back
;713:		if (defaultModel) {
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $436
line 714
;714:			if (cgs.gametype >= GT_TEAM && cgs.gametype < GT_STU) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $438
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 8
GEI4 $438
line 715
;715:				if (!CG_RegisterClientModelname(ci, defaultModel, ci->skinName, defaultModel, ci->skinName, teamname)) {
ADDRLP4 96
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
ARGP4
ADDRLP4 100
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRLP4 96
INDIRP4
CNSTI4 244
ADDP4
ARGP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRLP4 96
INDIRP4
CNSTI4 244
ADDP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 104
ADDRGP4 CG_RegisterClientModelname
CALLI4
ASGNI4
ADDRLP4 104
INDIRI4
CNSTI4 0
NEI4 $437
line 716
;716:					CG_Error("default model / skin (%s/%s) failed to register", defaultModel, ci->skinName);
ADDRGP4 $444
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 244
ADDP4
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 717
;717:				}
line 718
;718:			}
ADDRGP4 $437
JUMPV
LABELV $438
line 719
;719:			else {
line 720
;720:				if (!CG_RegisterClientModelname(ci, defaultModel, "default", defaultModel, "default", teamname)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 96
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
ARGP4
ADDRLP4 100
ADDRGP4 $179
ASGNP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRLP4 96
INDIRP4
ARGP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 104
ADDRGP4 CG_RegisterClientModelname
CALLI4
ASGNI4
ADDRLP4 104
INDIRI4
CNSTI4 0
NEI4 $437
line 721
;721:					CG_Error("default model / skin (%s/%s) failed to register", defaultModel, ci->skinName);
ADDRGP4 $444
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 244
ADDP4
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 722
;722:				}
line 723
;723:			}
line 724
;724:		}
ADDRGP4 $437
JUMPV
LABELV $436
line 730
;725:		else
;726:#endif
;727:#if !MONSTER_MODE	// JUHOX: use default skin in STU
;728:		if( cgs.gametype >= GT_TEAM) {
;729:#else
;730:		if (cgs.gametype >= GT_TEAM && cgs.gametype < GT_STU) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $447
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 8
GEI4 $447
line 733
;731:#endif
;732:			// keep skin name
;733:			if ( !CG_RegisterClientModelname( ci, DEFAULT_TEAM_MODEL, ci->skinName, DEFAULT_TEAM_HEAD, ci->skinName, teamname ) ) {
ADDRLP4 96
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
ARGP4
ADDRLP4 100
ADDRGP4 $453
ASGNP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRLP4 96
INDIRP4
CNSTI4 244
ADDP4
ARGP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRLP4 96
INDIRP4
CNSTI4 244
ADDP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 104
ADDRGP4 CG_RegisterClientModelname
CALLI4
ASGNI4
ADDRLP4 104
INDIRI4
CNSTI4 0
NEI4 $448
line 734
;734:				CG_Error( "DEFAULT_TEAM_MODEL / skin (%s/%s) failed to register", DEFAULT_TEAM_MODEL, ci->skinName );
ADDRGP4 $454
ARGP4
ADDRGP4 $453
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 244
ADDP4
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 735
;735:			}
line 736
;736:		} else {
ADDRGP4 $448
JUMPV
LABELV $447
line 737
;737:			if ( !CG_RegisterClientModelname( ci, DEFAULT_MODEL, "default", DEFAULT_MODEL, "default", teamname ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 96
ADDRGP4 $453
ASGNP4
ADDRLP4 96
INDIRP4
ARGP4
ADDRLP4 100
ADDRGP4 $179
ASGNP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRLP4 96
INDIRP4
ARGP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 104
ADDRGP4 CG_RegisterClientModelname
CALLI4
ASGNI4
ADDRLP4 104
INDIRI4
CNSTI4 0
NEI4 $455
line 738
;738:				CG_Error( "DEFAULT_MODEL (%s) failed to register", DEFAULT_MODEL );
ADDRGP4 $457
ARGP4
ADDRGP4 $453
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 739
;739:			}
LABELV $455
line 740
;740:		}
LABELV $448
LABELV $437
line 741
;741:		modelloaded = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 742
;742:	}
LABELV $430
line 744
;743:
;744:	ci->newAnims = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 504
ADDP4
CNSTI4 0
ASGNI4
line 745
;745:	if ( ci->torsoModel ) {
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
CNSTI4 0
EQI4 $458
line 748
;746:		orientation_t tag;
;747:		// if the torso model has the "tag_flag"
;748:		if ( trap_R_LerpTag( &tag, ci->torsoModel, 0, 0, 1, "tag_flag" ) ) {
ADDRLP4 96
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTF4 1065353216
ARGF4
ADDRGP4 $462
ARGP4
ADDRLP4 144
ADDRGP4 trap_R_LerpTag
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $460
line 749
;749:			ci->newAnims = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 504
ADDP4
CNSTI4 1
ASGNI4
line 750
;750:		}
LABELV $460
line 751
;751:	}
LABELV $458
line 754
;752:
;753:	// sounds
;754:	dir = ci->modelName;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
ASGNP4
line 758
;755:#if !MONSTER_MODE	// JUHOX: use DEFAULT_MODEL sounds as fall back in STU
;756:	fallback = (cgs.gametype >= GT_TEAM) ? DEFAULT_TEAM_MODEL : DEFAULT_MODEL;
;757:#else
;758:	fallback = defaultModel;
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
line 759
;759:	if (!fallback) {
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $463
line 760
;760:		fallback = (cgs.gametype >= GT_TEAM && cgs.gametype < GT_STU) ? DEFAULT_TEAM_MODEL : DEFAULT_MODEL;
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $468
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 8
GEI4 $468
ADDRLP4 96
ADDRGP4 $453
ASGNP4
ADDRGP4 $469
JUMPV
LABELV $468
ADDRLP4 96
ADDRGP4 $453
ASGNP4
LABELV $469
ADDRLP4 16
ADDRLP4 96
INDIRP4
ASGNP4
line 761
;761:	}
LABELV $463
line 764
;762:#endif
;763:
;764:	for ( i = 0 ; i < MAX_CUSTOM_SOUNDS ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $470
line 765
;765:		s = cg_customSoundNames[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_customSoundNames
ADDP4
INDIRP4
ASGNP4
line 766
;766:		if ( !s ) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $474
line 767
;767:			break;
ADDRGP4 $472
JUMPV
LABELV $474
line 769
;768:		}
;769:		ci->sounds[i] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 1600
ADDP4
ADDP4
CNSTI4 0
ASGNI4
line 771
;770:		// if the model didn't load use the sounds of the default model
;771:		if (modelloaded) {
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $476
line 772
;772:			ci->sounds[i] = trap_S_RegisterSound( va("sound/player/%s/%s", dir, s + 1), qfalse );
ADDRGP4 $478
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 96
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 96
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 100
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 1600
ADDP4
ADDP4
ADDRLP4 100
INDIRI4
ASGNI4
line 773
;773:		}
LABELV $476
line 774
;774:		if ( !ci->sounds[i] ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 1600
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $479
line 775
;775:			ci->sounds[i] = trap_S_RegisterSound( va("sound/player/%s/%s", fallback, s + 1), qfalse );
ADDRGP4 $478
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 96
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 96
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 100
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 1600
ADDP4
ADDP4
ADDRLP4 100
INDIRI4
ASGNI4
line 776
;776:		}
LABELV $479
line 777
;777:	}
LABELV $471
line 764
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $470
LABELV $472
line 779
;778:
;779:	ci->deferred = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 500
ADDP4
CNSTI4 0
ASGNI4
line 783
;780:
;781:	// reset any existing players and bodies, because they might be in bad
;782:	// frames for this new model
;783:	clientNum = ci - cgs.clientinfo;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 cgs+41320
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 1728
DIVI4
ASGNI4
line 784
;784:	for ( i = 0 ; i < MAX_GENTITIES ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $482
line 785
;785:		if ( cg_entities[i].currentState.clientNum == clientNum
ADDRLP4 0
INDIRI4
CNSTI4 880
MULI4
ADDRGP4 cg_entities+168
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $486
ADDRLP4 0
INDIRI4
CNSTI4 880
MULI4
ADDRGP4 cg_entities+4
ADDP4
INDIRI4
CNSTI4 1
NEI4 $486
line 786
;786:			&& cg_entities[i].currentState.eType == ET_PLAYER ) {
line 787
;787:			CG_ResetPlayerEntity( &cg_entities[i] );
ADDRLP4 0
INDIRI4
CNSTI4 880
MULI4
ADDRGP4 cg_entities
ADDP4
ARGP4
ADDRGP4 CG_ResetPlayerEntity
CALLV
pop
line 788
;788:		}
LABELV $486
line 789
;789:	}
LABELV $483
line 784
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1024
LTI4 $482
line 790
;790:}
LABELV $429
endproc CG_LoadClientInfo 148 24
proc CG_CopyClientInfoModel 0 12
line 797
;791:
;792:/*
;793:======================
;794:CG_CopyClientInfoModel
;795:======================
;796:*/
;797:static void CG_CopyClientInfoModel( clientInfo_t *from, clientInfo_t *to ) {
line 798
;798:	VectorCopy( from->headOffset, to->headOffset );
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRB
ASGNB 12
line 799
;799:	to->footsteps = from->footsteps;
ADDRFP4 4
INDIRP4
CNSTI4 528
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
ASGNI4
line 800
;800:	to->gender = from->gender;
ADDRFP4 4
INDIRP4
CNSTI4 532
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ASGNI4
line 802
;801:
;802:	to->legsModel = from->legsModel;
ADDRFP4 4
INDIRP4
CNSTI4 536
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
ASGNI4
line 803
;803:	to->legsSkin = from->legsSkin;
ADDRFP4 4
INDIRP4
CNSTI4 540
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 540
ADDP4
INDIRI4
ASGNI4
line 804
;804:	to->torsoModel = from->torsoModel;
ADDRFP4 4
INDIRP4
CNSTI4 544
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
ASGNI4
line 805
;805:	to->torsoSkin = from->torsoSkin;
ADDRFP4 4
INDIRP4
CNSTI4 548
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
ASGNI4
line 806
;806:	to->headModel = from->headModel;
ADDRFP4 4
INDIRP4
CNSTI4 552
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 552
ADDP4
INDIRI4
ASGNI4
line 807
;807:	to->headSkin = from->headSkin;
ADDRFP4 4
INDIRP4
CNSTI4 556
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
ASGNI4
line 808
;808:	to->modelIcon = from->modelIcon;
ADDRFP4 4
INDIRP4
CNSTI4 560
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
ASGNI4
line 810
;809:
;810:	to->newAnims = from->newAnims;
ADDRFP4 4
INDIRP4
CNSTI4 504
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 504
ADDP4
INDIRI4
ASGNI4
line 812
;811:
;812:	memcpy( to->animations, from->animations, sizeof( to->animations ) );
ADDRFP4 4
INDIRP4
CNSTI4 564
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 564
ADDP4
ARGP4
CNSTI4 1036
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 813
;813:	memcpy( to->sounds, from->sounds, sizeof( to->sounds ) );
ADDRFP4 4
INDIRP4
CNSTI4 1600
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 1600
ADDP4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 814
;814:}
LABELV $490
endproc CG_CopyClientInfoModel 0 12
proc CG_ScanForExistingClientInfo 32 8
line 821
;815:
;816:/*
;817:======================
;818:CG_ScanForExistingClientInfo
;819:======================
;820:*/
;821:static qboolean CG_ScanForExistingClientInfo( clientInfo_t *ci ) {
line 825
;822:	int		i;
;823:	clientInfo_t	*match;
;824:
;825:	for ( i = 0 ; i < cgs.maxclients ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $495
JUMPV
LABELV $492
line 826
;826:		match = &cgs.clientinfo[ i ];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320
ADDP4
ASGNP4
line 827
;827:		if ( !match->infoValid ) {
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $498
line 828
;828:			continue;
ADDRGP4 $493
JUMPV
LABELV $498
line 830
;829:		}
;830:		if ( match->deferred ) {
ADDRLP4 0
INDIRP4
CNSTI4 500
ADDP4
INDIRI4
CNSTI4 0
EQI4 $500
line 831
;831:			continue;
ADDRGP4 $493
JUMPV
LABELV $500
line 833
;832:		}
;833:		if ( !Q_stricmp( ci->modelName, match->modelName )
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $502
ADDRFP4 0
INDIRP4
CNSTI4 244
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 244
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $502
ADDRFP4 0
INDIRP4
CNSTI4 308
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 308
ADDP4
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $502
ADDRFP4 0
INDIRP4
CNSTI4 372
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 372
ADDP4
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $502
ADDRFP4 0
INDIRP4
CNSTI4 468
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
ARGP4
ADDRLP4 24
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $502
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 436
ADDP4
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $502
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $507
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 8
GEI4 $507
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
NEI4 $502
LABELV $507
line 843
;834:			&& !Q_stricmp( ci->skinName, match->skinName )
;835:			&& !Q_stricmp( ci->headModelName, match->headModelName )
;836:			&& !Q_stricmp( ci->headSkinName, match->headSkinName ) 
;837:			&& !Q_stricmp( ci->blueTeam, match->blueTeam ) 
;838:			&& !Q_stricmp( ci->redTeam, match->redTeam )
;839:			// JUHOX: in STU all teams use their normal skins
;840:#if !MONSTER_MODE
;841:			&& (cgs.gametype < GT_TEAM || ci->team == match->team) ) {
;842:#else
;843:			&& (cgs.gametype < GT_TEAM || cgs.gametype >= GT_STU || ci->team == match->team)) {
line 847
;844:#endif
;845:			// this clientinfo is identical, so use it's handles
;846:
;847:			ci->deferred = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 500
ADDP4
CNSTI4 0
ASGNI4
line 849
;848:
;849:			CG_CopyClientInfoModel( match, ci );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_CopyClientInfoModel
CALLV
pop
line 851
;850:
;851:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $491
JUMPV
LABELV $502
line 853
;852:		}
;853:	}
LABELV $493
line 825
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $495
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+31480
INDIRI4
LTI4 $492
line 856
;854:
;855:	// nothing matches, so defer the load
;856:	return qfalse;
CNSTI4 0
RETI4
LABELV $491
endproc CG_ScanForExistingClientInfo 32 8
proc CG_SetDeferredClientInfo 20 8
line 867
;857:}
;858:
;859:/*
;860:======================
;861:CG_SetDeferredClientInfo
;862:
;863:We aren't going to load it now, so grab some other
;864:client's info to use until we have some spare time.
;865:======================
;866:*/
;867:static void CG_SetDeferredClientInfo( clientInfo_t *ci ) {
line 873
;868:	int		i;
;869:	clientInfo_t	*match;
;870:
;871:	// JUHOX: don't care about client models in lens flare editor
;872:#if MAPLENSFLARES
;873:	if (cgs.editMode == EM_mlf) return;
ADDRGP4 cgs+31684
INDIRI4
CNSTI4 1
NEI4 $509
ADDRGP4 $508
JUMPV
LABELV $509
line 878
;874:#endif
;875:
;876:	// if someone else is already the same models and skins we
;877:	// can just load the client info
;878:	for ( i = 0 ; i < cgs.maxclients ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $515
JUMPV
LABELV $512
line 879
;879:		match = &cgs.clientinfo[ i ];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320
ADDP4
ASGNP4
line 880
;880:		if ( !match->infoValid || match->deferred ) {
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $520
ADDRLP4 0
INDIRP4
CNSTI4 500
ADDP4
INDIRI4
CNSTI4 0
EQI4 $518
LABELV $520
line 881
;881:			continue;
ADDRGP4 $513
JUMPV
LABELV $518
line 883
;882:		}
;883:		if ( Q_stricmp( ci->skinName, match->skinName ) ||
ADDRFP4 0
INDIRP4
CNSTI4 244
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 244
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $526
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $526
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $521
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 8
GEI4 $521
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
EQI4 $521
LABELV $526
line 894
;884:			 Q_stricmp( ci->modelName, match->modelName ) ||
;885:			 // JUHOX: 1.29h
;886:#if 0
;887:			 Q_stricmp( ci->headModelName, match->headModelName ) ||
;888:			 Q_stricmp( ci->headSkinName, match->headSkinName ) ) {
;889:#else
;890:			 // JUHOX: in STU all teams use their normal skins
;891:#if !MONSTER_MODE
;892:			 (cgs.gametype >= GT_TEAM && ci->team != match->team) ) {
;893:#else
;894:			 (cgs.gametype >= GT_TEAM && cgs.gametype < GT_STU && ci->team != match->team) ) {
line 897
;895:#endif
;896:#endif
;897:			continue;
ADDRGP4 $513
JUMPV
LABELV $521
line 905
;898:		}
;899:		// just load the real info cause it uses the same models and skins
;900:
;901:		// JUHOX: additional parameter for CG_LoacClientInfo()
;902:#if 0
;903:		CG_LoadClientInfo( ci );
;904:#else
;905:		CG_LoadClientInfo(ci, NULL);
ADDRFP4 0
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 CG_LoadClientInfo
CALLV
pop
line 907
;906:#endif
;907:		return;
ADDRGP4 $508
JUMPV
LABELV $513
line 878
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $515
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+31480
INDIRI4
LTI4 $512
line 915
;908:	}
;909:
;910:	// if we are in teamplay, only grab a model if the skin is correct
;911:	// JUHOX: don't need to check skin in STU
;912:#if !MONSTER_MODE
;913:	if ( cgs.gametype >= GT_TEAM ) {
;914:#else
;915:	if (cgs.gametype >= GT_TEAM && cgs.gametype < GT_STU) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $527
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 8
GEI4 $527
line 917
;916:#endif
;917:		for ( i = 0 ; i < cgs.maxclients ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $534
JUMPV
LABELV $531
line 918
;918:			match = &cgs.clientinfo[ i ];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320
ADDP4
ASGNP4
line 919
;919:			if ( !match->infoValid || match->deferred ) {
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $539
ADDRLP4 0
INDIRP4
CNSTI4 500
ADDP4
INDIRI4
CNSTI4 0
EQI4 $537
LABELV $539
line 920
;920:				continue;
ADDRGP4 $532
JUMPV
LABELV $537
line 922
;921:			}
;922:			if ( Q_stricmp( ci->skinName, match->skinName ) ||
ADDRFP4 0
INDIRP4
CNSTI4 244
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 244
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $543
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $540
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
EQI4 $540
LABELV $543
line 923
;923:				(cgs.gametype >= GT_TEAM && ci->team != match->team) ) {
line 924
;924:				continue;
ADDRGP4 $532
JUMPV
LABELV $540
line 926
;925:			}
;926:			ci->deferred = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 500
ADDP4
CNSTI4 1
ASGNI4
line 927
;927:			CG_CopyClientInfoModel( match, ci );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_CopyClientInfoModel
CALLV
pop
line 928
;928:			return;
ADDRGP4 $508
JUMPV
LABELV $532
line 917
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $534
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+31480
INDIRI4
LTI4 $531
line 938
;929:		}
;930:		// load the full model, because we don't ever want to show
;931:		// an improper team skin.  This will cause a hitch for the first
;932:		// player, when the second enters.  Combat shouldn't be going on
;933:		// yet, so it shouldn't matter
;934:		// JUHOX: additional parameter for CG_LoacClientInfo()
;935:#if 0
;936:		CG_LoadClientInfo( ci );
;937:#else
;938:		CG_LoadClientInfo(ci, NULL);
ADDRFP4 0
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 CG_LoadClientInfo
CALLV
pop
line 940
;939:#endif
;940:		return;
ADDRGP4 $508
JUMPV
LABELV $527
line 944
;941:	}
;942:
;943:	// find the first valid clientinfo and grab its stuff
;944:	for ( i = 0 ; i < cgs.maxclients ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $547
JUMPV
LABELV $544
line 945
;945:		match = &cgs.clientinfo[ i ];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320
ADDP4
ASGNP4
line 946
;946:		if ( !match->infoValid ) {
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $550
line 947
;947:			continue;
ADDRGP4 $545
JUMPV
LABELV $550
line 950
;948:		}
;949:
;950:		ci->deferred = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 500
ADDP4
CNSTI4 1
ASGNI4
line 951
;951:		CG_CopyClientInfoModel( match, ci );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_CopyClientInfoModel
CALLV
pop
line 952
;952:		return;
ADDRGP4 $508
JUMPV
LABELV $545
line 944
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $547
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+31480
INDIRI4
LTI4 $544
line 956
;953:	}
;954:
;955:	// we should never get here...
;956:	CG_Printf( "CG_SetDeferredClientInfo: no valid clients!\n" );
ADDRGP4 $552
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 962
;957:
;958:	// JUHOX: additional parameter for CG_LoacClientInfo()
;959:#if 0
;960:	CG_LoadClientInfo( ci );
;961:#else
;962:	CG_LoadClientInfo(ci, NULL);
ADDRFP4 0
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 CG_LoadClientInfo
CALLV
pop
line 964
;963:#endif
;964:}
LABELV $508
endproc CG_SetDeferredClientInfo 20 8
export CG_NewClientInfo
proc CG_NewClientInfo 1916 12
line 972
;965:
;966:
;967:/*
;968:======================
;969:CG_NewClientInfo
;970:======================
;971:*/
;972:void CG_NewClientInfo( int clientNum ) {
line 979
;973:	clientInfo_t *ci;
;974:	clientInfo_t newInfo;
;975:	const char	*configstring;
;976:	const char	*v;
;977:	char		*slash;
;978:
;979:	ci = &cgs.clientinfo[clientNum];
ADDRLP4 1740
ADDRFP4 0
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320
ADDP4
ASGNP4
line 981
;980:
;981:	configstring = CG_ConfigString( clientNum + CS_PLAYERS );
ADDRFP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 1744
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 1732
ADDRLP4 1744
INDIRP4
ASGNP4
line 982
;982:	if ( !configstring[0] ) {
ADDRLP4 1732
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $555
line 983
;983:		memset( ci, 0, sizeof( *ci ) );
ADDRLP4 1740
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1728
ARGI4
ADDRGP4 memset
CALLP4
pop
line 984
;984:		return;		// player just left
ADDRGP4 $553
JUMPV
LABELV $555
line 989
;985:	}
;986:
;987:	// build into a temp buffer so the defer checks can use
;988:	// the old value
;989:	memset( &newInfo, 0, sizeof( newInfo ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1728
ARGI4
ADDRGP4 memset
CALLP4
pop
line 991
;990:
;991:	newInfo.group = -1;			// JUHOX
ADDRLP4 0+72
CNSTI4 -1
ASGNI4
line 992
;992:	newInfo.memberStatus = -1;	// JUHOX
ADDRLP4 0+76
CNSTI4 -1
ASGNI4
line 995
;993:
;994:	// isolate the player's name
;995:	v = Info_ValueForKey(configstring, "n");
ADDRLP4 1732
INDIRP4
ARGP4
ADDRGP4 $559
ARGP4
ADDRLP4 1748
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1728
ADDRLP4 1748
INDIRP4
ASGNP4
line 996
;996:	Q_strncpyz( newInfo.name, v, sizeof( newInfo.name ) );
ADDRLP4 0+4
ARGP4
ADDRLP4 1728
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 999
;997:
;998:	// colors
;999:	v = Info_ValueForKey( configstring, "c1" );
ADDRLP4 1732
INDIRP4
ARGP4
ADDRGP4 $562
ARGP4
ADDRLP4 1752
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1728
ADDRLP4 1752
INDIRP4
ASGNP4
line 1000
;1000:	CG_ColorFromString( v, newInfo.color1 );
ADDRLP4 1728
INDIRP4
ARGP4
ADDRLP4 0+96
ARGP4
ADDRGP4 CG_ColorFromString
CALLV
pop
line 1002
;1001:
;1002:	v = Info_ValueForKey( configstring, "c2" );
ADDRLP4 1732
INDIRP4
ARGP4
ADDRGP4 $564
ARGP4
ADDRLP4 1756
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1728
ADDRLP4 1756
INDIRP4
ASGNP4
line 1003
;1003:	CG_ColorFromString( v, newInfo.color2 );
ADDRLP4 1728
INDIRP4
ARGP4
ADDRLP4 0+108
ARGP4
ADDRGP4 CG_ColorFromString
CALLV
pop
line 1006
;1004:
;1005:	// bot skill
;1006:	v = Info_ValueForKey( configstring, "skill" );
ADDRLP4 1732
INDIRP4
ARGP4
ADDRGP4 $566
ARGP4
ADDRLP4 1760
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1728
ADDRLP4 1760
INDIRP4
ASGNP4
line 1007
;1007:	newInfo.botSkill = atoi( v );
ADDRLP4 1728
INDIRP4
ARGP4
ADDRLP4 1764
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0+92
ADDRLP4 1764
INDIRI4
ASGNI4
line 1010
;1008:
;1009:	// handicap
;1010:	v = Info_ValueForKey( configstring, "hc" );
ADDRLP4 1732
INDIRP4
ARGP4
ADDRGP4 $568
ARGP4
ADDRLP4 1768
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1728
ADDRLP4 1768
INDIRP4
ASGNP4
line 1011
;1011:	newInfo.handicap = atoi( v );
ADDRLP4 1728
INDIRP4
ARGP4
ADDRLP4 1772
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0+140
ADDRLP4 1772
INDIRI4
ASGNI4
line 1014
;1012:
;1013:	// wins
;1014:	v = Info_ValueForKey( configstring, "w" );
ADDRLP4 1732
INDIRP4
ARGP4
ADDRGP4 $570
ARGP4
ADDRLP4 1776
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1728
ADDRLP4 1776
INDIRP4
ASGNP4
line 1015
;1015:	newInfo.wins = atoi( v );
ADDRLP4 1728
INDIRP4
ARGP4
ADDRLP4 1780
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0+144
ADDRLP4 1780
INDIRI4
ASGNI4
line 1018
;1016:
;1017:	// losses
;1018:	v = Info_ValueForKey( configstring, "l" );
ADDRLP4 1732
INDIRP4
ARGP4
ADDRGP4 $572
ARGP4
ADDRLP4 1784
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1728
ADDRLP4 1784
INDIRP4
ASGNP4
line 1019
;1019:	newInfo.losses = atoi( v );
ADDRLP4 1728
INDIRP4
ARGP4
ADDRLP4 1788
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0+148
ADDRLP4 1788
INDIRI4
ASGNI4
line 1023
;1020:
;1021:	// JUHOX: client info: glass cloaking
;1022:#if 1
;1023:	v = Info_ValueForKey(configstring, "gc");
ADDRLP4 1732
INDIRP4
ARGP4
ADDRGP4 $574
ARGP4
ADDRLP4 1792
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1728
ADDRLP4 1792
INDIRP4
ASGNP4
line 1024
;1024:	newInfo.usesGlassCloaking = atoi(v);
ADDRLP4 1728
INDIRP4
ARGP4
ADDRLP4 1796
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0+84
ADDRLP4 1796
INDIRI4
ASGNI4
line 1028
;1025:#endif
;1026:
;1027:	// team
;1028:	v = Info_ValueForKey( configstring, "t" );
ADDRLP4 1732
INDIRP4
ARGP4
ADDRGP4 $576
ARGP4
ADDRLP4 1800
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1728
ADDRLP4 1800
INDIRP4
ASGNP4
line 1029
;1029:	newInfo.team = atoi( v );
ADDRLP4 1728
INDIRP4
ARGP4
ADDRLP4 1804
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0+68
ADDRLP4 1804
INDIRI4
ASGNI4
line 1032
;1030:
;1031:	// team task
;1032:	v = Info_ValueForKey( configstring, "tt" );
ADDRLP4 1732
INDIRP4
ARGP4
ADDRGP4 $578
ARGP4
ADDRLP4 1808
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1728
ADDRLP4 1808
INDIRP4
ASGNP4
line 1033
;1033:	newInfo.teamTask = atoi(v);
ADDRLP4 1728
INDIRP4
ARGP4
ADDRLP4 1812
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0+152
ADDRLP4 1812
INDIRI4
ASGNI4
line 1036
;1034:
;1035:	// team leader
;1036:	v = Info_ValueForKey( configstring, "tl" );
ADDRLP4 1732
INDIRP4
ARGP4
ADDRGP4 $580
ARGP4
ADDRLP4 1816
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1728
ADDRLP4 1816
INDIRP4
ASGNP4
line 1037
;1037:	newInfo.teamLeader = atoi(v);
ADDRLP4 1728
INDIRP4
ARGP4
ADDRLP4 1820
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0+156
ADDRLP4 1820
INDIRI4
ASGNI4
line 1039
;1038:
;1039:	v = Info_ValueForKey( configstring, "g_redteam" );
ADDRLP4 1732
INDIRP4
ARGP4
ADDRGP4 $582
ARGP4
ADDRLP4 1824
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1728
ADDRLP4 1824
INDIRP4
ASGNP4
line 1040
;1040:	Q_strncpyz(newInfo.redTeam, v, MAX_TEAMNAME);
ADDRLP4 0+436
ARGP4
ADDRLP4 1728
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1042
;1041:
;1042:	v = Info_ValueForKey( configstring, "g_blueteam" );
ADDRLP4 1732
INDIRP4
ARGP4
ADDRGP4 $584
ARGP4
ADDRLP4 1828
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1728
ADDRLP4 1828
INDIRP4
ASGNP4
line 1043
;1043:	Q_strncpyz(newInfo.blueTeam, v, MAX_TEAMNAME);
ADDRLP4 0+468
ARGP4
ADDRLP4 1728
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1046
;1044:
;1045:	// model
;1046:	v = Info_ValueForKey( configstring, "model" );
ADDRLP4 1732
INDIRP4
ARGP4
ADDRGP4 $586
ARGP4
ADDRLP4 1832
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1728
ADDRLP4 1832
INDIRP4
ASGNP4
line 1047
;1047:	if ( cg_forceModel.integer ) {
ADDRGP4 cg_forceModel+12
INDIRI4
CNSTI4 0
EQI4 $587
line 1057
;1048:		// forcemodel makes everyone use a single model
;1049:		// to prevent load hitches
;1050:		char modelStr[MAX_QPATH];
;1051:		char *skin;
;1052:
;1053:		// JUHOX: use default skin in STU
;1054:#if !MONSTER_MODE
;1055:		if( cgs.gametype >= GT_TEAM ) {
;1056:#else
;1057:		if (cgs.gametype >= GT_TEAM && cgs.gametype < GT_STU) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $590
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 8
GEI4 $590
line 1059
;1058:#endif
;1059:			Q_strncpyz( newInfo.modelName, DEFAULT_TEAM_MODEL, sizeof( newInfo.modelName ) );
ADDRLP4 0+180
ARGP4
ADDRGP4 $453
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1060
;1060:			Q_strncpyz( newInfo.skinName, "default", sizeof( newInfo.skinName ) );
ADDRLP4 0+244
ARGP4
ADDRGP4 $179
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1061
;1061:		} else {
ADDRGP4 $591
JUMPV
LABELV $590
line 1062
;1062:			trap_Cvar_VariableStringBuffer( "model", modelStr, sizeof( modelStr ) );
ADDRGP4 $586
ARGP4
ADDRLP4 1836
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1063
;1063:			if ( ( skin = strchr( modelStr, '/' ) ) == NULL) {
ADDRLP4 1836
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 1904
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 1900
ADDRLP4 1904
INDIRP4
ASGNP4
ADDRLP4 1904
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $598
line 1064
;1064:				skin = "default";
ADDRLP4 1900
ADDRGP4 $179
ASGNP4
line 1065
;1065:			} else {
ADDRGP4 $599
JUMPV
LABELV $598
line 1066
;1066:				*skin++ = 0;
ADDRLP4 1908
ADDRLP4 1900
INDIRP4
ASGNP4
ADDRLP4 1900
ADDRLP4 1908
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 1908
INDIRP4
CNSTI1 0
ASGNI1
line 1067
;1067:			}
LABELV $599
line 1069
;1068:
;1069:			Q_strncpyz( newInfo.skinName, skin, sizeof( newInfo.skinName ) );
ADDRLP4 0+244
ARGP4
ADDRLP4 1900
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1070
;1070:			Q_strncpyz( newInfo.modelName, modelStr, sizeof( newInfo.modelName ) );
ADDRLP4 0+180
ARGP4
ADDRLP4 1836
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1071
;1071:		}
LABELV $591
line 1077
;1072:
;1073:		// JUHOX: use default skin in STU
;1074:#if !MONSTER_MODE
;1075:		if ( cgs.gametype >= GT_TEAM ) {
;1076:#else
;1077:		if (cgs.gametype >= GT_TEAM && cgs.gametype < GT_STU) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $588
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 8
GEI4 $588
line 1080
;1078:#endif
;1079:			// keep skin name
;1080:			slash = strchr( v, '/' );
ADDRLP4 1728
INDIRP4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 1904
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 1736
ADDRLP4 1904
INDIRP4
ASGNP4
line 1081
;1081:			if ( slash ) {
ADDRLP4 1736
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $588
line 1082
;1082:				Q_strncpyz( newInfo.skinName, slash + 1, sizeof( newInfo.skinName ) );
ADDRLP4 0+244
ARGP4
ADDRLP4 1736
INDIRP4
CNSTI4 1
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1083
;1083:			}
line 1084
;1084:		}
line 1085
;1085:	} else {
ADDRGP4 $588
JUMPV
LABELV $587
line 1086
;1086:		Q_strncpyz( newInfo.modelName, v, sizeof( newInfo.modelName ) );
ADDRLP4 0+180
ARGP4
ADDRLP4 1728
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1088
;1087:
;1088:		slash = strchr( newInfo.modelName, '/' );
ADDRLP4 0+180
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 1836
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 1736
ADDRLP4 1836
INDIRP4
ASGNP4
line 1089
;1089:		if ( !slash ) {
ADDRLP4 1736
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $615
line 1091
;1090:			// modelName didn not include a skin name
;1091:			Q_strncpyz( newInfo.skinName, "default", sizeof( newInfo.skinName ) );
ADDRLP4 0+244
ARGP4
ADDRGP4 $179
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1092
;1092:		} else {
ADDRGP4 $616
JUMPV
LABELV $615
line 1093
;1093:			Q_strncpyz( newInfo.skinName, slash + 1, sizeof( newInfo.skinName ) );
ADDRLP4 0+244
ARGP4
ADDRLP4 1736
INDIRP4
CNSTI4 1
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1095
;1094:			// truncate modelName
;1095:			*slash = 0;
ADDRLP4 1736
INDIRP4
CNSTI1 0
ASGNI1
line 1096
;1096:		}
LABELV $616
line 1097
;1097:	}
LABELV $588
line 1100
;1098:
;1099:	// head model
;1100:	v = Info_ValueForKey( configstring, "hmodel" );
ADDRLP4 1732
INDIRP4
ARGP4
ADDRGP4 $621
ARGP4
ADDRLP4 1836
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1728
ADDRLP4 1836
INDIRP4
ASGNP4
line 1101
;1101:	if ( cg_forceModel.integer ) {
ADDRGP4 cg_forceModel+12
INDIRI4
CNSTI4 0
EQI4 $622
line 1111
;1102:		// forcemodel makes everyone use a single model
;1103:		// to prevent load hitches
;1104:		char modelStr[MAX_QPATH];
;1105:		char *skin;
;1106:
;1107:		// JUHOX: use default skin in STU
;1108:#if !MONSTER_MODE
;1109:		if( cgs.gametype >= GT_TEAM ) {
;1110:#else
;1111:		if (cgs.gametype >= GT_TEAM && cgs.gametype < GT_STU) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $625
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 8
GEI4 $625
line 1113
;1112:#endif
;1113:			Q_strncpyz( newInfo.headModelName, DEFAULT_TEAM_MODEL, sizeof( newInfo.headModelName ) );
ADDRLP4 0+308
ARGP4
ADDRGP4 $453
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1114
;1114:			Q_strncpyz( newInfo.headSkinName, "default", sizeof( newInfo.headSkinName ) );
ADDRLP4 0+372
ARGP4
ADDRGP4 $179
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1115
;1115:		} else {
ADDRGP4 $626
JUMPV
LABELV $625
line 1116
;1116:			trap_Cvar_VariableStringBuffer( "headmodel", modelStr, sizeof( modelStr ) );
ADDRGP4 $633
ARGP4
ADDRLP4 1840
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1117
;1117:			if ( ( skin = strchr( modelStr, '/' ) ) == NULL) {
ADDRLP4 1840
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 1908
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 1904
ADDRLP4 1908
INDIRP4
ASGNP4
ADDRLP4 1908
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $634
line 1118
;1118:				skin = "default";
ADDRLP4 1904
ADDRGP4 $179
ASGNP4
line 1119
;1119:			} else {
ADDRGP4 $635
JUMPV
LABELV $634
line 1120
;1120:				*skin++ = 0;
ADDRLP4 1912
ADDRLP4 1904
INDIRP4
ASGNP4
ADDRLP4 1904
ADDRLP4 1912
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 1912
INDIRP4
CNSTI1 0
ASGNI1
line 1121
;1121:			}
LABELV $635
line 1123
;1122:
;1123:			Q_strncpyz( newInfo.headSkinName, skin, sizeof( newInfo.headSkinName ) );
ADDRLP4 0+372
ARGP4
ADDRLP4 1904
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1124
;1124:			Q_strncpyz( newInfo.headModelName, modelStr, sizeof( newInfo.headModelName ) );
ADDRLP4 0+308
ARGP4
ADDRLP4 1840
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1125
;1125:		}
LABELV $626
line 1131
;1126:
;1127:		// JUHOX: use default skin in STU
;1128:#if !MONSTER_MODE
;1129:		if ( cgs.gametype >= GT_TEAM ) {
;1130:#else
;1131:		if (cgs.gametype >= GT_TEAM && cgs.gametype < GT_STU) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $623
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 8
GEI4 $623
line 1134
;1132:#endif
;1133:			// keep skin name
;1134:			slash = strchr( v, '/' );
ADDRLP4 1728
INDIRP4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 1908
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 1736
ADDRLP4 1908
INDIRP4
ASGNP4
line 1135
;1135:			if ( slash ) {
ADDRLP4 1736
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $623
line 1136
;1136:				Q_strncpyz( newInfo.headSkinName, slash + 1, sizeof( newInfo.headSkinName ) );
ADDRLP4 0+372
ARGP4
ADDRLP4 1736
INDIRP4
CNSTI4 1
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1137
;1137:			}
line 1138
;1138:		}
line 1139
;1139:	} else {
ADDRGP4 $623
JUMPV
LABELV $622
line 1140
;1140:		Q_strncpyz( newInfo.headModelName, v, sizeof( newInfo.headModelName ) );
ADDRLP4 0+308
ARGP4
ADDRLP4 1728
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1142
;1141:
;1142:		slash = strchr( newInfo.headModelName, '/' );
ADDRLP4 0+308
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 1840
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 1736
ADDRLP4 1840
INDIRP4
ASGNP4
line 1143
;1143:		if ( !slash ) {
ADDRLP4 1736
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $651
line 1145
;1144:			// modelName didn not include a skin name
;1145:			Q_strncpyz( newInfo.headSkinName, "default", sizeof( newInfo.headSkinName ) );
ADDRLP4 0+372
ARGP4
ADDRGP4 $179
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1146
;1146:		} else {
ADDRGP4 $652
JUMPV
LABELV $651
line 1147
;1147:			Q_strncpyz( newInfo.headSkinName, slash + 1, sizeof( newInfo.headSkinName ) );
ADDRLP4 0+372
ARGP4
ADDRLP4 1736
INDIRP4
CNSTI4 1
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1149
;1148:			// truncate modelName
;1149:			*slash = 0;
ADDRLP4 1736
INDIRP4
CNSTI1 0
ASGNI1
line 1150
;1150:		}
LABELV $652
line 1151
;1151:	}
LABELV $623
line 1155
;1152:
;1153:	// scan for an existing clientinfo that matches this modelname
;1154:	// so we can avoid loading checks if possible
;1155:	if ( !CG_ScanForExistingClientInfo( &newInfo ) ) {
ADDRLP4 0
ARGP4
ADDRLP4 1840
ADDRGP4 CG_ScanForExistingClientInfo
CALLI4
ASGNI4
ADDRLP4 1840
INDIRI4
CNSTI4 0
NEI4 $657
line 1158
;1156:		qboolean	forceDefer;
;1157:
;1158:		forceDefer = trap_MemoryRemaining() < 4000000;
ADDRLP4 1852
ADDRGP4 trap_MemoryRemaining
CALLI4
ASGNI4
ADDRLP4 1852
INDIRI4
CNSTI4 4000000
GEI4 $660
ADDRLP4 1848
CNSTI4 1
ASGNI4
ADDRGP4 $661
JUMPV
LABELV $660
ADDRLP4 1848
CNSTI4 0
ASGNI4
LABELV $661
ADDRLP4 1844
ADDRLP4 1848
INDIRI4
ASGNI4
line 1161
;1159:
;1160:		// if we are defering loads, just have it pick the first valid
;1161:		if ( forceDefer || ( cg_deferPlayers.integer && !cg_buildScript.integer && !cg.loading ) ) {
ADDRLP4 1844
INDIRI4
CNSTI4 0
NEI4 $667
ADDRGP4 cg_deferPlayers+12
INDIRI4
CNSTI4 0
EQI4 $662
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
NEI4 $662
ADDRGP4 cg+20
INDIRI4
CNSTI4 0
NEI4 $662
LABELV $667
line 1163
;1162:			// keep whatever they had if it won't violate team skins
;1163:			CG_SetDeferredClientInfo( &newInfo );
ADDRLP4 0
ARGP4
ADDRGP4 CG_SetDeferredClientInfo
CALLV
pop
line 1165
;1164:			// if we are low on memory, leave them with this model
;1165:			if ( forceDefer ) {
ADDRLP4 1844
INDIRI4
CNSTI4 0
EQI4 $663
line 1166
;1166:				CG_Printf( "Memory is low.  Using deferred model.\n" );
ADDRGP4 $670
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1167
;1167:				newInfo.deferred = qfalse;
ADDRLP4 0+500
CNSTI4 0
ASGNI4
line 1168
;1168:			}
line 1169
;1169:		} else {
ADDRGP4 $663
JUMPV
LABELV $662
line 1174
;1170:			// JUHOX: additional parameter for CG_LoadClientInfo()
;1171:#if 0
;1172:			CG_LoadClientInfo( &newInfo );
;1173:#else
;1174:			CG_LoadClientInfo(&newInfo, NULL);
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 CG_LoadClientInfo
CALLV
pop
line 1176
;1175:#endif
;1176:		}
LABELV $663
line 1177
;1177:	}
LABELV $657
line 1180
;1178:
;1179:	// replace whatever was there with the new one
;1180:	newInfo.infoValid = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1181
;1181:	*ci = newInfo;
ADDRLP4 1740
INDIRP4
ADDRLP4 0
INDIRB
ASGNB 1728
line 1182
;1182:}
LABELV $553
endproc CG_NewClientInfo 1916 12
export CG_InitMonsterClientInfo
proc CG_InitMonsterClientInfo 1760 12
line 1192
;1183:
;1184:/*
;1185:======================
;1186:JUHOX: CG_InitMonsterClientInfo
;1187:
;1188:derived from 'CG_NewClientInfo()' (see above)
;1189:======================
;1190:*/
;1191:#if MONSTER_MODE
;1192:void CG_InitMonsterClientInfo(int clientNum) {
line 1199
;1193:	clientInfo_t* ci;
;1194:	clientInfo_t newInfo;
;1195:	const char* configstring;
;1196:	const char* modelCvar;
;1197:	const char* defaultModel;
;1198:
;1199:	configstring = CG_ConfigString(CS_SERVERINFO);
CNSTI4 0
ARGI4
ADDRLP4 1744
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 1732
ADDRLP4 1744
INDIRP4
ASGNP4
line 1201
;1200:
;1201:	ci = &cgs.clientinfo[clientNum];
ADDRLP4 1728
ADDRFP4 0
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320
ADDP4
ASGNP4
line 1205
;1202:
;1203:	// build into a temp buffer so the defer checks can use
;1204:	// the old value
;1205:	memset(&newInfo, 0, sizeof(newInfo));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1728
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1207
;1206:
;1207:	newInfo.group = -1;
ADDRLP4 0+72
CNSTI4 -1
ASGNI4
line 1208
;1208:	newInfo.memberStatus = -1;
ADDRLP4 0+76
CNSTI4 -1
ASGNI4
line 1210
;1209:
;1210:	VectorSet(newInfo.color1, 1, 1, 1);
ADDRLP4 0+96
CNSTF4 1065353216
ASGNF4
ADDRLP4 0+96+4
CNSTF4 1065353216
ASGNF4
ADDRLP4 0+96+8
CNSTF4 1065353216
ASGNF4
line 1211
;1211:	VectorSet(newInfo.color2, 1, 1, 1);
ADDRLP4 0+108
CNSTF4 1065353216
ASGNF4
ADDRLP4 0+108+4
CNSTF4 1065353216
ASGNF4
ADDRLP4 0+108+8
CNSTF4 1065353216
ASGNF4
line 1213
;1212:
;1213:	newInfo.botSkill = 3;
ADDRLP4 0+92
CNSTI4 3
ASGNI4
line 1215
;1214:
;1215:	newInfo.handicap = 100;
ADDRLP4 0+140
CNSTI4 100
ASGNI4
line 1217
;1216:
;1217:	switch (clientNum) {
ADDRLP4 1748
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 1748
INDIRI4
CNSTI4 64
LTI4 $672
ADDRLP4 1748
INDIRI4
CNSTI4 68
GTI4 $672
ADDRLP4 1748
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $725-256
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $725
address $690
address $697
address $707
address $717
address $721
code
LABELV $690
line 1219
;1218:	case CLIENTNUM_MONSTER_PREDATOR:
;1219:		Q_strncpyz(newInfo.name, "Predator", sizeof(newInfo.name));
ADDRLP4 0+4
ARGP4
ADDRGP4 $692
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1220
;1220:		modelCvar = "monsterModel1";
ADDRLP4 1736
ADDRGP4 $694
ASGNP4
line 1221
;1221:		defaultModel = "klesk";
ADDRLP4 1740
ADDRGP4 $695
ASGNP4
line 1222
;1222:		newInfo.team = TEAM_FREE;
ADDRLP4 0+68
CNSTI4 0
ASGNI4
line 1223
;1223:		break;
ADDRGP4 $689
JUMPV
LABELV $697
line 1225
;1224:	case CLIENTNUM_MONSTER_GUARD:
;1225:		Q_strncpyz(newInfo.name, "Guard", sizeof(newInfo.name));
ADDRLP4 0+4
ARGP4
ADDRGP4 $699
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1226
;1226:		modelCvar = "monsterModel2";
ADDRLP4 1736
ADDRGP4 $701
ASGNP4
line 1227
;1227:		defaultModel = "tankjr";
ADDRLP4 1740
ADDRGP4 $702
ASGNP4
line 1228
;1228:		newInfo.team = TEAM_FREE;
ADDRLP4 0+68
CNSTI4 0
ASGNI4
line 1230
;1229:
;1230:		cgs.media.guardStartSound = trap_S_RegisterSound("sound/weapons/guard_start.wav", qfalse);
ADDRGP4 $706
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 1752
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1140
ADDRLP4 1752
INDIRI4
ASGNI4
line 1231
;1231:		break;
ADDRGP4 $689
JUMPV
LABELV $707
line 1233
;1232:	case CLIENTNUM_MONSTER_TITAN:
;1233:		Q_strncpyz(newInfo.name, "Titan", sizeof(newInfo.name));
ADDRLP4 0+4
ARGP4
ADDRGP4 $709
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1234
;1234:		modelCvar = "monsterModel3";
ADDRLP4 1736
ADDRGP4 $711
ASGNP4
line 1235
;1235:		defaultModel = "uriel";
ADDRLP4 1740
ADDRGP4 $712
ASGNP4
line 1236
;1236:		newInfo.team = TEAM_FREE;
ADDRLP4 0+68
CNSTI4 0
ASGNI4
line 1238
;1237:
;1238:		cgs.media.titanFootstepSound = trap_S_RegisterSound("sound/big_footstep.wav", qfalse);
ADDRGP4 $716
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 1756
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1244
ADDRLP4 1756
INDIRI4
ASGNI4
line 1239
;1239:		break;
ADDRGP4 $689
JUMPV
LABELV $717
line 1241
;1240:	case CLIENTNUM_MONSTER_PREDATOR_RED:
;1241:		Q_strncpyz(newInfo.name, "Predator", sizeof(newInfo.name));
ADDRLP4 0+4
ARGP4
ADDRGP4 $692
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1242
;1242:		modelCvar = "monsterModel1";
ADDRLP4 1736
ADDRGP4 $694
ASGNP4
line 1243
;1243:		defaultModel = "klesk";
ADDRLP4 1740
ADDRGP4 $695
ASGNP4
line 1244
;1244:		newInfo.team = TEAM_RED;
ADDRLP4 0+68
CNSTI4 1
ASGNI4
line 1245
;1245:		break;
ADDRGP4 $689
JUMPV
LABELV $721
line 1247
;1246:	case CLIENTNUM_MONSTER_PREDATOR_BLUE:
;1247:		Q_strncpyz(newInfo.name, "Predator", sizeof(newInfo.name));
ADDRLP4 0+4
ARGP4
ADDRGP4 $692
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1248
;1248:		modelCvar = "monsterModel1";
ADDRLP4 1736
ADDRGP4 $694
ASGNP4
line 1249
;1249:		defaultModel = "klesk";
ADDRLP4 1740
ADDRGP4 $695
ASGNP4
line 1250
;1250:		newInfo.team = TEAM_BLUE;
ADDRLP4 0+68
CNSTI4 2
ASGNI4
line 1251
;1251:		break;
line 1253
;1252:	default:
;1253:		return;
LABELV $689
line 1256
;1254:	}
;1255:
;1256:	if (cg_forceModel.integer) {
ADDRGP4 cg_forceModel+12
INDIRI4
CNSTI4 0
EQI4 $727
line 1257
;1257:		trap_Cvar_VariableStringBuffer(modelCvar, newInfo.modelName, sizeof(newInfo.modelName));
ADDRLP4 1736
INDIRP4
ARGP4
ADDRLP4 0+180
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1258
;1258:	}
ADDRGP4 $728
JUMPV
LABELV $727
line 1259
;1259:	else {
line 1260
;1260:		Q_strncpyz(newInfo.modelName, Info_ValueForKey(configstring, modelCvar), sizeof(newInfo.modelName));
ADDRLP4 1732
INDIRP4
ARGP4
ADDRLP4 1736
INDIRP4
ARGP4
ADDRLP4 1752
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0+180
ARGP4
ADDRLP4 1752
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1261
;1261:	}
LABELV $728
line 1264
;1262:
;1263:	//CG_LoadingString(newInfo.modelName);
;1264:	CG_LoadingClient(clientNum);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 CG_LoadingClient
CALLV
pop
line 1266
;1265:
;1266:	{
line 1269
;1267:		char* slash;
;1268:
;1269:		slash = strchr( newInfo.modelName, '/' );
ADDRLP4 0+180
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 1756
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 1752
ADDRLP4 1756
INDIRP4
ASGNP4
line 1270
;1270:		if ( !slash ) {
ADDRLP4 1752
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $735
line 1272
;1271:			// modelName didn not include a skin name
;1272:			Q_strncpyz( newInfo.skinName, "default", sizeof( newInfo.skinName ) );
ADDRLP4 0+244
ARGP4
ADDRGP4 $179
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1273
;1273:		} else {
ADDRGP4 $736
JUMPV
LABELV $735
line 1274
;1274:			Q_strncpyz( newInfo.skinName, slash + 1, sizeof( newInfo.skinName ) );
ADDRLP4 0+244
ARGP4
ADDRLP4 1752
INDIRP4
CNSTI4 1
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1276
;1275:			// truncate modelName
;1276:			*slash = 0;
ADDRLP4 1752
INDIRP4
CNSTI1 0
ASGNI1
line 1277
;1277:		}
LABELV $736
line 1278
;1278:	}
line 1281
;1279:
;1280:	// head model
;1281:	Q_strncpyz(newInfo.headModelName, newInfo.modelName, sizeof(newInfo.headModelName));
ADDRLP4 0+308
ARGP4
ADDRLP4 0+180
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1282
;1282:	Q_strncpyz(newInfo.headSkinName, newInfo.skinName, sizeof(newInfo.headSkinName));
ADDRLP4 0+372
ARGP4
ADDRLP4 0+244
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1300
;1283:	/*
;1284:	v = Info_ValueForKey( configstring, "hmodel" );
;1285:	{
;1286:		Q_strncpyz( newInfo.headModelName, v, sizeof( newInfo.headModelName ) );
;1287:
;1288:		slash = strchr( newInfo.headModelName, '/' );
;1289:		if ( !slash ) {
;1290:			// modelName didn not include a skin name
;1291:			Q_strncpyz( newInfo.headSkinName, "default", sizeof( newInfo.headSkinName ) );
;1292:		} else {
;1293:			Q_strncpyz( newInfo.headSkinName, slash + 1, sizeof( newInfo.headSkinName ) );
;1294:			// truncate modelName
;1295:			*slash = 0;
;1296:		}
;1297:	}
;1298:	*/
;1299:
;1300:	CG_LoadClientInfo(&newInfo, defaultModel);
ADDRLP4 0
ARGP4
ADDRLP4 1740
INDIRP4
ARGP4
ADDRGP4 CG_LoadClientInfo
CALLV
pop
line 1303
;1301:
;1302:	// replace whatever was there with the new one
;1303:	newInfo.infoValid = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1304
;1304:	*ci = newInfo;
ADDRLP4 1728
INDIRP4
ADDRLP4 0
INDIRB
ASGNB 1728
line 1305
;1305:}
LABELV $672
endproc CG_InitMonsterClientInfo 1760 12
export CG_LoadDeferredPlayers
proc CG_LoadDeferredPlayers 16 8
line 1319
;1306:#endif
;1307:
;1308:
;1309:
;1310:/*
;1311:======================
;1312:CG_LoadDeferredPlayers
;1313:
;1314:Called each frame when a player is dead
;1315:and the scoreboard is up
;1316:so deferred players can be loaded
;1317:======================
;1318:*/
;1319:void CG_LoadDeferredPlayers( void ) {
line 1324
;1320:	int		i;
;1321:	clientInfo_t	*ci;
;1322:
;1323:	// scan for a deferred player to load
;1324:	for ( i = 0, ci = cgs.clientinfo ; i < cgs.maxclients ; i++, ci++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
ADDRGP4 cgs+41320
ASGNP4
ADDRGP4 $751
JUMPV
LABELV $748
line 1325
;1325:		if ( ci->infoValid && ci->deferred ) {
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $754
ADDRLP4 0
INDIRP4
CNSTI4 500
ADDP4
INDIRI4
CNSTI4 0
EQI4 $754
line 1327
;1326:			// if we are low on memory, leave it deferred
;1327:			if ( trap_MemoryRemaining() < 4000000 ) {
ADDRLP4 12
ADDRGP4 trap_MemoryRemaining
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 4000000
GEI4 $756
line 1328
;1328:				CG_Printf( "Memory is low.  Using deferred model.\n" );
ADDRGP4 $670
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1329
;1329:				ci->deferred = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 500
ADDP4
CNSTI4 0
ASGNI4
line 1330
;1330:				continue;
ADDRGP4 $749
JUMPV
LABELV $756
line 1336
;1331:			}
;1332:			// JUHOX: additional parameter for CG_LoadClientInfo()
;1333:#if 0
;1334:			CG_LoadClientInfo( ci );
;1335:#else
;1336:			CG_LoadClientInfo(ci, NULL);
ADDRLP4 0
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 CG_LoadClientInfo
CALLV
pop
line 1339
;1337:#endif
;1338://			break;
;1339:		}
LABELV $754
line 1340
;1340:	}
LABELV $749
line 1324
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1728
ADDP4
ASGNP4
LABELV $751
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+31480
INDIRI4
LTI4 $748
line 1341
;1341:}
LABELV $747
endproc CG_LoadDeferredPlayers 16 8
proc CG_SetLerpFrameAnimation 12 8
line 1359
;1342:
;1343:/*
;1344:=============================================================================
;1345:
;1346:PLAYER ANIMATION
;1347:
;1348:=============================================================================
;1349:*/
;1350:
;1351:
;1352:/*
;1353:===============
;1354:CG_SetLerpFrameAnimation
;1355:
;1356:may include ANIM_TOGGLEBIT
;1357:===============
;1358:*/
;1359:static void CG_SetLerpFrameAnimation( clientInfo_t *ci, lerpFrame_t *lf, int newAnimation ) {
line 1362
;1360:	animation_t	*anim;
;1361:
;1362:	lf->animationNumber = newAnimation;
ADDRFP4 4
INDIRP4
CNSTI4 36
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 1363
;1363:	newAnimation &= ~ANIM_TOGGLEBIT;
ADDRFP4 8
ADDRFP4 8
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 1365
;1364:
;1365:	if ( newAnimation < 0 || newAnimation >= MAX_TOTALANIMATIONS ) {
ADDRLP4 4
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $761
ADDRLP4 4
INDIRI4
CNSTI4 37
LTI4 $759
LABELV $761
line 1366
;1366:		CG_Error( "Bad animation number: %i", newAnimation );
ADDRGP4 $762
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 1367
;1367:	}
LABELV $759
line 1369
;1368:
;1369:	anim = &ci->animations[ newAnimation ];
ADDRLP4 0
ADDRFP4 8
INDIRI4
CNSTI4 28
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 564
ADDP4
ADDP4
ASGNP4
line 1371
;1370:
;1371:	lf->animation = anim;
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 1372
;1372:	lf->animationTime = lf->frameTime + anim->initialLerp;
ADDRLP4 8
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ADDI4
ASGNI4
line 1374
;1373:
;1374:	if ( cg_debugAnim.integer ) {
ADDRGP4 cg_debugAnim+12
INDIRI4
CNSTI4 0
EQI4 $763
line 1375
;1375:		CG_Printf( "Anim: %i\n", newAnimation );
ADDRGP4 $766
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 1376
;1376:	}
LABELV $763
line 1377
;1377:}
LABELV $758
endproc CG_SetLerpFrameAnimation 12 8
proc CG_RunLerpFrame 52 12
line 1387
;1378:
;1379:/*
;1380:===============
;1381:CG_RunLerpFrame
;1382:
;1383:Sets cg.snap, cg.oldFrame, and cg.backlerp
;1384:cg.time should be between oldFrameTime and frameTime after exit
;1385:===============
;1386:*/
;1387:static void CG_RunLerpFrame( clientInfo_t *ci, lerpFrame_t *lf, int newAnimation, float speedScale ) {
line 1392
;1388:	int			f, numFrames;
;1389:	animation_t	*anim;
;1390:
;1391:	// debugging tool to get no animations
;1392:	if ( cg_animSpeed.integer == 0 ) {
ADDRGP4 cg_animSpeed+12
INDIRI4
CNSTI4 0
NEI4 $768
line 1393
;1393:		lf->oldFrame = lf->frame = lf->backlerp = 0;
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 16
CNSTF4 0
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 20
ADDRLP4 16
INDIRF4
CVFI4 4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
ADDRLP4 12
INDIRP4
ADDRLP4 20
INDIRI4
ASGNI4
line 1394
;1394:		return;
ADDRGP4 $767
JUMPV
LABELV $768
line 1402
;1395:	}
;1396:
;1397:#if SCREENSHOT_TOOLS	// JUHOX
;1398:	if (cg.stopTime) speedScale = 0;
;1399:#endif
;1400:
;1401:#if 1	// JUHOX: update local animation clock
;1402:	lf->clock += cg.frametime * speedScale;
ADDRLP4 12
ADDRFP4 4
INDIRP4
CNSTI4 48
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 cg+107652
INDIRI4
CVIF4 4
ADDRFP4 12
INDIRF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 1406
;1403:#endif
;1404:
;1405:	// see if the animation sequence is switching
;1406:	if ( newAnimation != lf->animationNumber || !lf->animation ) {
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 8
INDIRI4
ADDRLP4 16
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
NEI4 $774
ADDRLP4 16
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $772
LABELV $774
line 1407
;1407:		CG_SetLerpFrameAnimation( ci, lf, newAnimation );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 CG_SetLerpFrameAnimation
CALLV
pop
line 1408
;1408:	}
LABELV $772
line 1412
;1409:
;1410:	// if we have passed the current frame, move it to
;1411:	// oldFrame and calculate a new frame
;1412:	if ( /*cg.time*/lf->clock >= lf->frameTime ) {	// JUHOX
ADDRLP4 20
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
ADDRLP4 20
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
LTI4 $775
line 1413
;1413:		lf->oldFrame = lf->frame;
ADDRLP4 24
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1414
;1414:		lf->oldFrameTime = lf->frameTime;
ADDRLP4 28
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 28
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1417
;1415:
;1416:		// get the next frame based on the animation
;1417:		anim = lf->animation;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
ASGNP4
line 1418
;1418:		if ( !anim->frameLerp ) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
NEI4 $777
line 1419
;1419:			return;		// shouldn't happen
ADDRGP4 $767
JUMPV
LABELV $777
line 1421
;1420:		}
;1421:		if ( /*cg.time*/lf->clock < lf->animationTime ) {	// JUHOX
ADDRLP4 32
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
ADDRLP4 32
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
GEI4 $779
line 1422
;1422:			lf->frameTime = lf->animationTime;		// initial lerp
ADDRLP4 36
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 36
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ASGNI4
line 1423
;1423:		} else {
ADDRGP4 $780
JUMPV
LABELV $779
line 1424
;1424:			lf->frameTime = lf->oldFrameTime + anim->frameLerp;
ADDRLP4 36
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 36
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDI4
ASGNI4
line 1425
;1425:		}
LABELV $780
line 1430
;1426:#if 0	// JUHOX BUGFIX: improve precision
;1427:		f = ( lf->frameTime - lf->animationTime ) / anim->frameLerp;
;1428:		f *= speedScale;		// adjust for haste, etc
;1429:#else
;1430:		f = (lf->frameTime - lf->animationTime) / anim->frameLerp;
ADDRLP4 36
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 36
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 36
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
SUBI4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
DIVI4
ASGNI4
line 1433
;1431:#endif
;1432:
;1433:		numFrames = anim->numFrames;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1434
;1434:		if (anim->flipflop) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 0
EQI4 $781
line 1435
;1435:			numFrames *= 2;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
line 1436
;1436:		}
LABELV $781
line 1437
;1437:		if ( f >= numFrames ) {
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $783
line 1438
;1438:			f -= numFrames;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ASGNI4
line 1439
;1439:			if ( anim->loopFrames ) {
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 0
EQI4 $785
line 1440
;1440:				f %= anim->loopFrames;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MODI4
ASGNI4
line 1441
;1441:				f += anim->numFrames - anim->loopFrames;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
SUBI4
ADDI4
ASGNI4
line 1442
;1442:			} else {
ADDRGP4 $786
JUMPV
LABELV $785
line 1443
;1443:				f = numFrames - 1;
ADDRLP4 4
ADDRLP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1446
;1444:				// the animation is stuck at the end, so it
;1445:				// can immediately transition to another sequence
;1446:				lf->frameTime = /*cg.time*/lf->clock;	// JUHOX
ADDRLP4 40
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 40
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
ASGNI4
line 1447
;1447:			}
LABELV $786
line 1448
;1448:		}
LABELV $783
line 1449
;1449:		if ( anim->reversed ) {
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 0
EQI4 $787
line 1450
;1450:			lf->frame = anim->firstFrame + anim->numFrames - 1 - f;
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDI4
CNSTI4 1
SUBI4
ADDRLP4 4
INDIRI4
SUBI4
ASGNI4
line 1451
;1451:		}
ADDRGP4 $788
JUMPV
LABELV $787
line 1452
;1452:		else if (anim->flipflop && f>=anim->numFrames) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 0
EQI4 $789
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
LTI4 $789
line 1453
;1453:			lf->frame = anim->firstFrame + anim->numFrames - 1 - (f%anim->numFrames);
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDI4
CNSTI4 1
SUBI4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
MODI4
SUBI4
ASGNI4
line 1454
;1454:		}
ADDRGP4 $790
JUMPV
LABELV $789
line 1455
;1455:		else {
line 1456
;1456:			lf->frame = anim->firstFrame + f;
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 1457
;1457:		}
LABELV $790
LABELV $788
line 1458
;1458:		if ( /*cg.time*/lf->clock > lf->frameTime ) {	// JUHOX
ADDRLP4 44
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
ADDRLP4 44
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
LEI4 $791
line 1459
;1459:			lf->frameTime = /*cg.time*/lf->clock;		// JUHOX
ADDRLP4 48
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 48
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
ASGNI4
line 1460
;1460:			if ( cg_debugAnim.integer ) {
ADDRGP4 cg_debugAnim+12
INDIRI4
CNSTI4 0
EQI4 $793
line 1461
;1461:				CG_Printf( "Clamp lf->frameTime\n");
ADDRGP4 $796
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1462
;1462:			}
LABELV $793
line 1463
;1463:		}
LABELV $791
line 1464
;1464:	}
LABELV $775
line 1466
;1465:
;1466:	if ( lf->frameTime > /*cg.time*/lf->clock + 200 ) {	// JUHOX
ADDRLP4 24
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 24
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 200
ADDI4
LEI4 $797
line 1467
;1467:		lf->frameTime = /*cg.time*/lf->clock;			// JUHOX
ADDRLP4 28
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 28
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
ASGNI4
line 1468
;1468:	}
LABELV $797
line 1470
;1469:
;1470:	if ( lf->oldFrameTime > /*cg.time*/lf->clock ) {	// JUHOX
ADDRLP4 28
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 28
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
LEI4 $799
line 1471
;1471:		lf->oldFrameTime = /*cg.time*/lf->clock;		// JUHOX
ADDRLP4 32
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 32
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
ASGNI4
line 1472
;1472:	}
LABELV $799
line 1474
;1473:	// calculate current lerp value
;1474:	if ( lf->frameTime == lf->oldFrameTime ) {
ADDRLP4 32
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
NEI4 $801
line 1475
;1475:		lf->backlerp = 0;
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
CNSTF4 0
ASGNF4
line 1476
;1476:	} else {
ADDRGP4 $802
JUMPV
LABELV $801
line 1477
;1477:		lf->backlerp = 1.0 - (float)( /*cg.time*/lf->clock - lf->oldFrameTime ) / ( lf->frameTime - lf->oldFrameTime );	// JUHOX
ADDRLP4 36
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 16
ADDP4
CNSTF4 1065353216
ADDRLP4 36
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
ADDRLP4 36
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 36
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 36
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
SUBI4
CVIF4 4
DIVF4
SUBF4
ASGNF4
line 1478
;1478:	}
LABELV $802
line 1479
;1479:}
LABELV $767
endproc CG_RunLerpFrame 52 12
proc CG_ClearLerpFrame 16 12
line 1487
;1480:
;1481:
;1482:/*
;1483:===============
;1484:CG_ClearLerpFrame
;1485:===============
;1486:*/
;1487:static void CG_ClearLerpFrame( clientInfo_t *ci, lerpFrame_t *lf, int animationNumber ) {
line 1488
;1488:	lf->frameTime = lf->oldFrameTime = /*cg.time*/lf->clock;	// JUHOX
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 1489
;1489:	CG_SetLerpFrameAnimation( ci, lf, animationNumber );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 CG_SetLerpFrameAnimation
CALLV
pop
line 1490
;1490:	lf->oldFrame = lf->frame = lf->animation->firstFrame;
ADDRLP4 8
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 8
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 8
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
line 1491
;1491:}
LABELV $803
endproc CG_ClearLerpFrame 16 12
proc CG_PlayerAnimation 36 16
line 1500
;1492:
;1493:
;1494:/*
;1495:===============
;1496:CG_PlayerAnimation
;1497:===============
;1498:*/
;1499:static void CG_PlayerAnimation( centity_t *cent, int *legsOld, int *legs, float *legsBackLerp,
;1500:						int *torsoOld, int *torso, float *torsoBackLerp ) {
line 1505
;1501:	clientInfo_t	*ci;
;1502:	int				clientNum;
;1503:	float			speedScale;
;1504:
;1505:	clientNum = cent->currentState.clientNum;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 1507
;1506:
;1507:	if ( cg_noPlayerAnims.integer ) {
ADDRGP4 cg_noPlayerAnims+12
INDIRI4
CNSTI4 0
EQI4 $805
line 1508
;1508:		*legsOld = *legs = *torsoOld = *torso = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRFP4 20
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
ADDRFP4 16
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
line 1509
;1509:		return;
ADDRGP4 $804
JUMPV
LABELV $805
line 1520
;1510:	}
;1511:
;1512:	// JUHOX: adapt animation speed to player speed
;1513:#if 0
;1514:	if ( cent->currentState.powerups & ( 1 << PW_HASTE ) ) {
;1515:		speedScale = 1.5;
;1516:	} else {
;1517:		speedScale = 1;
;1518:	}
;1519:#else
;1520:	{
line 1523
;1521:		qboolean forceFullSpeed;
;1522:
;1523:		forceFullSpeed = qfalse;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 1524
;1524:		speedScale = VectorLength(cent->currentState.pos.trDelta) / 320.0;
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ARGP4
ADDRLP4 16
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 16
INDIRF4
CNSTF4 994888909
MULF4
ASGNF4
line 1525
;1525:		switch (cent->currentState.legsAnim & ~ANIM_TOGGLEBIT) {
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
LTI4 $808
ADDRLP4 20
INDIRI4
CNSTI4 23
GTI4 $814
ADDRLP4 20
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $815
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $815
address $812
address $812
address $812
address $812
address $812
address $812
address $808
address $808
address $808
address $808
address $808
address $808
address $808
address $811
address $811
address $808
address $808
address $808
address $812
address $812
address $812
address $812
address $813
address $813
code
LABELV $814
ADDRLP4 20
INDIRI4
CNSTI4 32
EQI4 $811
ADDRLP4 20
INDIRI4
CNSTI4 33
EQI4 $811
ADDRGP4 $808
JUMPV
LABELV $811
line 1530
;1526:		case LEGS_WALK:
;1527:		case LEGS_WALKCR:
;1528:		case LEGS_BACKWALK:
;1529:		case LEGS_BACKCR:
;1530:			speedScale *= 2;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1073741824
MULF4
ASGNF4
line 1541
;1531:			/*
;1532:			switch (clientNum) {
;1533:			case CLIENTNUM_MONSTER_GUARD:
;1534:				speedScale /= MONSTER_GUARD_SCALE;
;1535:				break;
;1536:			case CLIENTNUM_MONSTER_TITAN:
;1537:				speedScale /= MONSTER_TITAN_SCALE;
;1538:				break;
;1539:			}
;1540:			*/
;1541:			break;
ADDRGP4 $809
JUMPV
LABELV $812
line 1552
;1542:		case BOTH_DEATH1:
;1543:		case BOTH_DEAD1:
;1544:		case BOTH_DEATH2:
;1545:		case BOTH_DEAD2:
;1546:		case BOTH_DEATH3:
;1547:		case BOTH_DEAD3:
;1548:		case LEGS_JUMP:
;1549:		case LEGS_LAND:
;1550:		case LEGS_JUMPB:
;1551:		case LEGS_LANDB:
;1552:			forceFullSpeed = qtrue;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 1553
;1553:			speedScale = 1;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 1554
;1554:			break;
ADDRGP4 $809
JUMPV
LABELV $813
line 1557
;1555:		case LEGS_IDLE:
;1556:		case LEGS_IDLECR:
;1557:			speedScale = 1;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 1558
;1558:			break;
LABELV $808
LABELV $809
line 1561
;1559:		}
;1560:#if MONSTER_MODE	// JUHOX: adapt animation speed to monster size
;1561:		if (!forceFullSpeed) switch (clientNum) {	// NOTE: death animation must not change speed or sound will be async
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $816
ADDRLP4 8
INDIRI4
CNSTI4 65
EQI4 $820
ADDRLP4 8
INDIRI4
CNSTI4 66
EQI4 $821
ADDRGP4 $818
JUMPV
LABELV $820
line 1563
;1562:		case CLIENTNUM_MONSTER_GUARD:
;1563:			speedScale /= MONSTER_GUARD_SCALE;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 1564
;1564:			break;
ADDRGP4 $819
JUMPV
LABELV $821
line 1566
;1565:		case CLIENTNUM_MONSTER_TITAN:
;1566:			speedScale /= MONSTER_TITAN_SCALE;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1049774373
MULF4
ASGNF4
line 1567
;1567:			break;
LABELV $818
LABELV $819
LABELV $816
line 1570
;1568:		}
;1569:#endif
;1570:		if (speedScale < 0.2) speedScale = 0.2;
ADDRLP4 0
INDIRF4
CNSTF4 1045220557
GEF4 $822
ADDRLP4 0
CNSTF4 1045220557
ASGNF4
LABELV $822
line 1571
;1571:	}
line 1575
;1572:#endif
;1573:
;1574:
;1575:	ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 4
ADDRLP4 8
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320
ADDP4
ASGNP4
line 1579
;1576:
;1577:#if MONSTER_MODE	// JUHOX: sleeping titan doesn't get animated
;1578:	if (
;1579:		clientNum == CLIENTNUM_MONSTER_TITAN &&
ADDRLP4 8
INDIRI4
CNSTI4 66
NEI4 $825
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 0
EQI4 $825
line 1581
;1580:		cent->currentState.otherEntityNum2
;1581:	) {
line 1582
;1582:		CG_ClearLerpFrame(ci, &cent->pe.legs, cent->currentState.legsAnim);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 452
ADDP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_ClearLerpFrame
CALLV
pop
line 1583
;1583:		CG_ClearLerpFrame(ci, &cent->pe.torso, cent->currentState.torsoAnim);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 504
ADDP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_ClearLerpFrame
CALLV
pop
line 1585
;1584:
;1585:		*legsOld = cent->pe.legs.oldFrame;
ADDRFP4 4
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
ASGNI4
line 1586
;1586:		*legs = cent->pe.legs.frame;
ADDRFP4 8
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
INDIRI4
ASGNI4
line 1587
;1587:		*legsBackLerp = cent->pe.legs.backlerp;
ADDRFP4 12
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRF4
ASGNF4
line 1589
;1588:
;1589:		*torsoOld = cent->pe.torso.oldFrame;
ADDRFP4 16
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 504
ADDP4
INDIRI4
ASGNI4
line 1590
;1590:		*torso = cent->pe.torso.frame;
ADDRFP4 20
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
ASGNI4
line 1591
;1591:		*torsoBackLerp = cent->pe.torso.backlerp;
ADDRFP4 24
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRF4
ASGNF4
line 1592
;1592:		return;
ADDRGP4 $804
JUMPV
LABELV $825
line 1597
;1593:	}
;1594:#endif
;1595:
;1596:	// do the shuffle turn frames locally
;1597:	if ( cent->pe.legs.yawing && ( cent->currentState.legsAnim & ~ANIM_TOGGLEBIT ) == LEGS_IDLE ) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 476
ADDP4
INDIRI4
CNSTI4 0
EQI4 $827
ADDRLP4 12
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
CNSTI4 22
NEI4 $827
line 1598
;1598:		CG_RunLerpFrame( ci, &cent->pe.legs, LEGS_TURN, speedScale );
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 452
ADDP4
ARGP4
CNSTI4 24
ARGI4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 CG_RunLerpFrame
CALLV
pop
line 1599
;1599:	} else {
ADDRGP4 $828
JUMPV
LABELV $827
line 1600
;1600:		CG_RunLerpFrame( ci, &cent->pe.legs, cent->currentState.legsAnim, speedScale );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 452
ADDP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 CG_RunLerpFrame
CALLV
pop
line 1601
;1601:	}
LABELV $828
line 1603
;1602:
;1603:	*legsOld = cent->pe.legs.oldFrame;
ADDRFP4 4
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
ASGNI4
line 1604
;1604:	*legs = cent->pe.legs.frame;
ADDRFP4 8
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
INDIRI4
ASGNI4
line 1605
;1605:	*legsBackLerp = cent->pe.legs.backlerp;
ADDRFP4 12
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRF4
ASGNF4
line 1619
;1606:
;1607:#if 1	// JUHOX: make sure attack and gesture animation plays full speed independent from movement
;1608:	/*
;1609:	switch (cent->currentState.torsoAnim & ~ANIM_TOGGLEBIT) {
;1610:	case TORSO_ATTACK:
;1611:	case TORSO_ATTACK2:
;1612:	case TORSO_GESTURE:
;1613:	case TORSO_DROP:
;1614:	case TORSO_RAISE:
;1615:		speedScale = 1;
;1616:		break;
;1617:	}
;1618:	*/
;1619:	speedScale = 1;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 1622
;1620:#endif
;1621:
;1622:	CG_RunLerpFrame( ci, &cent->pe.torso, cent->currentState.torsoAnim, speedScale );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 504
ADDP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 CG_RunLerpFrame
CALLV
pop
line 1624
;1623:
;1624:	*torsoOld = cent->pe.torso.oldFrame;
ADDRFP4 16
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 504
ADDP4
INDIRI4
ASGNI4
line 1625
;1625:	*torso = cent->pe.torso.frame;
ADDRFP4 20
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
ASGNI4
line 1626
;1626:	*torsoBackLerp = cent->pe.torso.backlerp;
ADDRFP4 24
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRF4
ASGNF4
line 1627
;1627:}
LABELV $804
endproc CG_PlayerAnimation 36 16
proc CG_SwingAngles 28 8
line 1643
;1628:
;1629:/*
;1630:=============================================================================
;1631:
;1632:PLAYER ANGLES
;1633:
;1634:=============================================================================
;1635:*/
;1636:
;1637:/*
;1638:==================
;1639:CG_SwingAngles
;1640:==================
;1641:*/
;1642:static void CG_SwingAngles( float destination, float swingTolerance, float clampTolerance,
;1643:					float speed, float *angle, qboolean *swinging ) {
line 1648
;1644:	float	swing;
;1645:	float	move;
;1646:	float	scale;
;1647:
;1648:	if ( !*swinging ) {
ADDRFP4 20
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $830
line 1650
;1649:		// see if a swing should be started
;1650:		swing = AngleSubtract( *angle, destination );
ADDRFP4 16
INDIRP4
INDIRF4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ASGNF4
line 1651
;1651:		if ( swing > swingTolerance || swing < -swingTolerance ) {
ADDRLP4 20
ADDRFP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRF4
ADDRLP4 20
INDIRF4
GTF4 $834
ADDRLP4 0
INDIRF4
ADDRLP4 20
INDIRF4
NEGF4
GEF4 $832
LABELV $834
line 1652
;1652:			*swinging = qtrue;
ADDRFP4 20
INDIRP4
CNSTI4 1
ASGNI4
line 1653
;1653:		}
LABELV $832
line 1654
;1654:	}
LABELV $830
line 1656
;1655:
;1656:	if ( !*swinging ) {
ADDRFP4 20
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $835
line 1657
;1657:		return;
ADDRGP4 $829
JUMPV
LABELV $835
line 1662
;1658:	}
;1659:	
;1660:	// modify the speed depending on the delta
;1661:	// so it doesn't seem so linear
;1662:	swing = AngleSubtract( destination, *angle );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ASGNF4
line 1663
;1663:	scale = fabs( swing );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 16
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 16
INDIRF4
ASGNF4
line 1664
;1664:	if ( scale < swingTolerance * 0.5 ) {
ADDRLP4 4
INDIRF4
ADDRFP4 4
INDIRF4
CNSTF4 1056964608
MULF4
GEF4 $837
line 1665
;1665:		scale = 0.5;
ADDRLP4 4
CNSTF4 1056964608
ASGNF4
line 1666
;1666:	} else if ( scale < swingTolerance ) {
ADDRGP4 $838
JUMPV
LABELV $837
ADDRLP4 4
INDIRF4
ADDRFP4 4
INDIRF4
GEF4 $839
line 1667
;1667:		scale = 1.0;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 1668
;1668:	} else {
ADDRGP4 $840
JUMPV
LABELV $839
line 1669
;1669:		scale = 2.0;
ADDRLP4 4
CNSTF4 1073741824
ASGNF4
line 1670
;1670:	}
LABELV $840
LABELV $838
line 1673
;1671:
;1672:	// swing towards the destination angle
;1673:	if ( swing >= 0 ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
LTF4 $841
line 1674
;1674:		move = cg.frametime * scale * speed;
ADDRLP4 8
ADDRGP4 cg+107652
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRF4
MULF4
ADDRFP4 12
INDIRF4
MULF4
ASGNF4
line 1675
;1675:		if ( move >= swing ) {
ADDRLP4 8
INDIRF4
ADDRLP4 0
INDIRF4
LTF4 $844
line 1676
;1676:			move = swing;
ADDRLP4 8
ADDRLP4 0
INDIRF4
ASGNF4
line 1677
;1677:			*swinging = qfalse;
ADDRFP4 20
INDIRP4
CNSTI4 0
ASGNI4
line 1678
;1678:		}
LABELV $844
line 1679
;1679:		*angle = AngleMod( *angle + move );
ADDRLP4 20
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
INDIRF4
ADDRLP4 8
INDIRF4
ADDF4
ARGF4
ADDRLP4 24
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 20
INDIRP4
ADDRLP4 24
INDIRF4
ASGNF4
line 1680
;1680:	} else if ( swing < 0 ) {
ADDRGP4 $842
JUMPV
LABELV $841
ADDRLP4 0
INDIRF4
CNSTF4 0
GEF4 $846
line 1681
;1681:		move = cg.frametime * scale * -speed;
ADDRLP4 8
ADDRGP4 cg+107652
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRF4
MULF4
ADDRFP4 12
INDIRF4
NEGF4
MULF4
ASGNF4
line 1682
;1682:		if ( move <= swing ) {
ADDRLP4 8
INDIRF4
ADDRLP4 0
INDIRF4
GTF4 $849
line 1683
;1683:			move = swing;
ADDRLP4 8
ADDRLP4 0
INDIRF4
ASGNF4
line 1684
;1684:			*swinging = qfalse;
ADDRFP4 20
INDIRP4
CNSTI4 0
ASGNI4
line 1685
;1685:		}
LABELV $849
line 1686
;1686:		*angle = AngleMod( *angle + move );
ADDRLP4 20
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
INDIRF4
ADDRLP4 8
INDIRF4
ADDF4
ARGF4
ADDRLP4 24
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 20
INDIRP4
ADDRLP4 24
INDIRF4
ASGNF4
line 1687
;1687:	}
LABELV $846
LABELV $842
line 1690
;1688:
;1689:	// clamp to no more than tolerance
;1690:	swing = AngleSubtract( destination, *angle );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 20
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 20
INDIRF4
ASGNF4
line 1691
;1691:	if ( swing > clampTolerance ) {
ADDRLP4 0
INDIRF4
ADDRFP4 8
INDIRF4
LEF4 $851
line 1692
;1692:		*angle = AngleMod( destination - (clampTolerance - 1) );
ADDRFP4 0
INDIRF4
ADDRFP4 8
INDIRF4
CNSTF4 1065353216
SUBF4
SUBF4
ARGF4
ADDRLP4 24
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRFP4 16
INDIRP4
ADDRLP4 24
INDIRF4
ASGNF4
line 1693
;1693:	} else if ( swing < -clampTolerance ) {
ADDRGP4 $852
JUMPV
LABELV $851
ADDRLP4 0
INDIRF4
ADDRFP4 8
INDIRF4
NEGF4
GEF4 $853
line 1694
;1694:		*angle = AngleMod( destination + (clampTolerance - 1) );
ADDRFP4 0
INDIRF4
ADDRFP4 8
INDIRF4
CNSTF4 1065353216
SUBF4
ADDF4
ARGF4
ADDRLP4 24
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRFP4 16
INDIRP4
ADDRLP4 24
INDIRF4
ASGNF4
line 1695
;1695:	}
LABELV $853
LABELV $852
line 1696
;1696:}
LABELV $829
endproc CG_SwingAngles 28 8
proc CG_AddPainTwitch 12 0
line 1703
;1697:
;1698:/*
;1699:=================
;1700:CG_AddPainTwitch
;1701:=================
;1702:*/
;1703:static void CG_AddPainTwitch( centity_t *cent, vec3_t torsoAngles ) {
line 1707
;1704:	int		t;
;1705:	float	f;
;1706:
;1707:	t = cg.time - cent->pe.painTime;
ADDRLP4 0
ADDRGP4 cg+107656
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 608
ADDP4
INDIRI4
SUBI4
ASGNI4
line 1708
;1708:	if ( t >= PAIN_TWITCH_TIME ) {
ADDRLP4 0
INDIRI4
CNSTI4 200
LTI4 $857
line 1709
;1709:		return;
ADDRGP4 $855
JUMPV
LABELV $857
line 1712
;1710:	}
;1711:
;1712:	f = 1.0 - (float)t / PAIN_TWITCH_TIME;
ADDRLP4 4
CNSTF4 1065353216
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1000593162
MULF4
SUBF4
ASGNF4
line 1714
;1713:
;1714:	if ( cent->pe.painDirection ) {
ADDRFP4 0
INDIRP4
CNSTI4 612
ADDP4
INDIRI4
CNSTI4 0
EQI4 $859
line 1715
;1715:		torsoAngles[ROLL] += 20 * f;
ADDRLP4 8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
CNSTF4 1101004800
MULF4
ADDF4
ASGNF4
line 1716
;1716:	} else {
ADDRGP4 $860
JUMPV
LABELV $859
line 1717
;1717:		torsoAngles[ROLL] -= 20 * f;
ADDRLP4 8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
CNSTF4 1101004800
MULF4
SUBF4
ASGNF4
line 1718
;1718:	}
LABELV $860
line 1719
;1719:}
LABELV $855
endproc CG_AddPainTwitch 12 0
data
align 4
LABELV $862
byte 4 0
byte 4 22
byte 4 45
byte 4 -22
byte 4 0
byte 4 22
byte 4 -45
byte 4 -22
code
proc CG_PlayerAngles 144 24
line 1736
;1720:
;1721:
;1722:/*
;1723:===============
;1724:CG_PlayerAngles
;1725:
;1726:Handles seperate torso motion
;1727:
;1728:  legs pivot based on direction of movement
;1729:
;1730:  head always looks exactly at cent->lerpAngles
;1731:
;1732:  if motion < 20 degrees, show in head only
;1733:  if < 45 degrees, also show in torso
;1734:===============
;1735:*/
;1736:static void CG_PlayerAngles( centity_t *cent, vec3_t legs[3], vec3_t torso[3], vec3_t head[3] ) {
line 1745
;1737:	vec3_t		legsAngles, torsoAngles, headAngles;
;1738:	float		dest;
;1739:	static	int	movementOffsets[8] = { 0, 22, 45, -22, 0, 22, -45, -22 };
;1740:	vec3_t		velocity;
;1741:	float		speed;
;1742:	int			dir, clientNum;
;1743:	clientInfo_t	*ci;
;1744:
;1745:	VectorCopy( cent->lerpAngles, headAngles );
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
INDIRB
ASGNB 12
line 1746
;1746:	headAngles[YAW] = AngleMod( headAngles[YAW] );
ADDRLP4 24+4
INDIRF4
ARGF4
ADDRLP4 68
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 68
INDIRF4
ASGNF4
line 1747
;1747:	VectorClear( legsAngles );
ADDRLP4 72
CNSTF4 0
ASGNF4
ADDRLP4 12+8
ADDRLP4 72
INDIRF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 72
INDIRF4
ASGNF4
ADDRLP4 12
ADDRLP4 72
INDIRF4
ASGNF4
line 1748
;1748:	VectorClear( torsoAngles );
ADDRLP4 76
CNSTF4 0
ASGNF4
ADDRLP4 0+8
ADDRLP4 76
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 76
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 76
INDIRF4
ASGNF4
line 1753
;1749:
;1750:	// --------- yaw -------------
;1751:
;1752:	// allow yaw to drift a bit
;1753:	if ( ( cent->currentState.legsAnim & ~ANIM_TOGGLEBIT ) != LEGS_IDLE 
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
CNSTI4 22
NEI4 $871
ADDRLP4 80
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
CNSTI4 11
EQI4 $869
ADDRLP4 80
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
CNSTI4 12
EQI4 $869
LABELV $871
line 1761
;1754:#if 0	// JUHOX BUGFIX: TORSO_STAND2 also means standing still
;1755:		|| ( cent->currentState.torsoAnim & ~ANIM_TOGGLEBIT ) != TORSO_STAND  ) {
;1756:#else
;1757:		|| (
;1758:			(cent->currentState.torsoAnim & ~ANIM_TOGGLEBIT) != TORSO_STAND &&
;1759:			(cent->currentState.torsoAnim & ~ANIM_TOGGLEBIT) != TORSO_STAND2
;1760:		)
;1761:	) {
line 1764
;1762:#endif
;1763:		// if not standing still, always point all in the same direction
;1764:		cent->pe.torso.yawing = qtrue;	// always center
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
CNSTI4 1
ASGNI4
line 1765
;1765:		cent->pe.torso.pitching = qtrue;	// always center
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
CNSTI4 1
ASGNI4
line 1766
;1766:		cent->pe.legs.yawing = qtrue;	// always center
ADDRFP4 0
INDIRP4
CNSTI4 476
ADDP4
CNSTI4 1
ASGNI4
line 1767
;1767:	}
LABELV $869
line 1770
;1768:
;1769:	// adjust legs for movement dir
;1770:	if ( cent->currentState.eFlags & EF_DEAD ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $872
line 1772
;1771:		// don't let dead bodies twitch
;1772:		dir = 0;
ADDRLP4 52
CNSTI4 0
ASGNI4
line 1773
;1773:	} else {
ADDRGP4 $873
JUMPV
LABELV $872
line 1776
;1774:		// -JUHOX: get movementDir from entityState_t.angles[YAW]
;1775:#if 1
;1776:		dir = cent->currentState.angles2[YAW];
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 132
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 1780
;1777:#else
;1778:		dir = cent->currentState.angles[YAW];
;1779:#endif
;1780:		if ( dir < 0 || dir > 7 ) {
ADDRLP4 52
INDIRI4
CNSTI4 0
LTI4 $876
ADDRLP4 52
INDIRI4
CNSTI4 7
LEI4 $874
LABELV $876
line 1781
;1781:			CG_Error( "Bad player movement angle" );
ADDRGP4 $877
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 1782
;1782:		}
LABELV $874
line 1783
;1783:	}
LABELV $873
line 1784
;1784:	legsAngles[YAW] = headAngles[YAW] + movementOffsets[ dir ];
ADDRLP4 12+4
ADDRLP4 24+4
INDIRF4
ADDRLP4 52
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $862
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1785
;1785:	torsoAngles[YAW] = headAngles[YAW] + 0.25 * movementOffsets[ dir ];
ADDRLP4 0+4
ADDRLP4 24+4
INDIRF4
ADDRLP4 52
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $862
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1048576000
MULF4
ADDF4
ASGNF4
line 1788
;1786:
;1787:	// torso
;1788:	CG_SwingAngles( torsoAngles[YAW], 25, 90, cg_swingSpeed.value, &cent->pe.torso.yawAngle, &cent->pe.torso.yawing );
ADDRLP4 0+4
INDIRF4
ARGF4
CNSTF4 1103626240
ARGF4
CNSTF4 1119092736
ARGF4
ADDRGP4 cg_swingSpeed+8
INDIRF4
ARGF4
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 524
ADDP4
ARGP4
ADDRLP4 84
INDIRP4
CNSTI4 528
ADDP4
ARGP4
ADDRGP4 CG_SwingAngles
CALLV
pop
line 1789
;1789:	CG_SwingAngles( legsAngles[YAW], 40, 90, cg_swingSpeed.value, &cent->pe.legs.yawAngle, &cent->pe.legs.yawing );
ADDRLP4 12+4
INDIRF4
ARGF4
CNSTF4 1109393408
ARGF4
CNSTF4 1119092736
ARGF4
ADDRGP4 cg_swingSpeed+8
INDIRF4
ARGF4
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 472
ADDP4
ARGP4
ADDRLP4 88
INDIRP4
CNSTI4 476
ADDP4
ARGP4
ADDRGP4 CG_SwingAngles
CALLV
pop
line 1791
;1790:
;1791:	torsoAngles[YAW] = cent->pe.torso.yawAngle;
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRF4
ASGNF4
line 1792
;1792:	legsAngles[YAW] = cent->pe.legs.yawAngle;
ADDRLP4 12+4
ADDRFP4 0
INDIRP4
CNSTI4 472
ADDP4
INDIRF4
ASGNF4
line 1797
;1793:
;1794:	// --------- pitch -------------
;1795:
;1796:	// only show a fraction of the pitch angle in the torso
;1797:	if ( headAngles[PITCH] > 180 ) {
ADDRLP4 24
INDIRF4
CNSTF4 1127481344
LEF4 $888
line 1798
;1798:		dest = (-360 + headAngles[PITCH]) * 0.75f;
ADDRLP4 60
ADDRLP4 24
INDIRF4
CNSTF4 3283353600
ADDF4
CNSTF4 1061158912
MULF4
ASGNF4
line 1799
;1799:	} else {
ADDRGP4 $889
JUMPV
LABELV $888
line 1800
;1800:		dest = headAngles[PITCH] * 0.75f;
ADDRLP4 60
ADDRLP4 24
INDIRF4
CNSTF4 1061158912
MULF4
ASGNF4
line 1801
;1801:	}
LABELV $889
line 1802
;1802:	CG_SwingAngles( dest, 15, 30, 0.1f, &cent->pe.torso.pitchAngle, &cent->pe.torso.pitching );
ADDRLP4 60
INDIRF4
ARGF4
CNSTF4 1097859072
ARGF4
CNSTF4 1106247680
ARGF4
CNSTF4 1036831949
ARGF4
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 532
ADDP4
ARGP4
ADDRLP4 92
INDIRP4
CNSTI4 536
ADDP4
ARGP4
ADDRGP4 CG_SwingAngles
CALLV
pop
line 1803
;1803:	torsoAngles[PITCH] = cent->pe.torso.pitchAngle;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRF4
ASGNF4
line 1806
;1804:
;1805:	//
;1806:	clientNum = cent->currentState.clientNum;
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 1811
;1807:	// JUHOX: handle monsters too
;1808:#if !MONSTER_MODE
;1809:	if ( clientNum >= 0 && clientNum < MAX_CLIENTS ) {
;1810:#else
;1811:	if (clientNum >= 0 && clientNum < MAX_CLIENTS+EXTRA_CLIENTNUMS) {
ADDRLP4 36
INDIRI4
CNSTI4 0
LTI4 $890
ADDRLP4 36
INDIRI4
CNSTI4 69
GEI4 $890
line 1813
;1812:#endif
;1813:		ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 64
ADDRLP4 36
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320
ADDP4
ASGNP4
line 1814
;1814:		if ( ci->fixedtorso ) {
ADDRLP4 64
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
CNSTI4 0
EQI4 $893
line 1815
;1815:			torsoAngles[PITCH] = 0.0f;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 1816
;1816:		}
LABELV $893
line 1817
;1817:	}
LABELV $890
line 1823
;1818:
;1819:	// --------- roll -------------
;1820:
;1821:
;1822:	// lean towards the direction of travel
;1823:	VectorCopy( cent->currentState.pos.trDelta, velocity );
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRB
ASGNB 12
line 1824
;1824:	speed = VectorNormalize( velocity );
ADDRLP4 40
ARGP4
ADDRLP4 100
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 56
ADDRLP4 100
INDIRF4
ASGNF4
line 1825
;1825:	if ( speed ) {
ADDRLP4 56
INDIRF4
CNSTF4 0
EQF4 $895
line 1829
;1826:		vec3_t	axis[3];
;1827:		float	side;
;1828:
;1829:		speed *= 0.05f;
ADDRLP4 56
ADDRLP4 56
INDIRF4
CNSTF4 1028443341
MULF4
ASGNF4
line 1831
;1830:
;1831:		AnglesToAxis( legsAngles, axis );
ADDRLP4 12
ARGP4
ADDRLP4 104
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1832
;1832:		side = speed * DotProduct( velocity, axis[1] );
ADDRLP4 140
ADDRLP4 56
INDIRF4
ADDRLP4 40
INDIRF4
ADDRLP4 104+12
INDIRF4
MULF4
ADDRLP4 40+4
INDIRF4
ADDRLP4 104+12+4
INDIRF4
MULF4
ADDF4
ADDRLP4 40+8
INDIRF4
ADDRLP4 104+12+8
INDIRF4
MULF4
ADDF4
MULF4
ASGNF4
line 1833
;1833:		legsAngles[ROLL] -= side;
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
ADDRLP4 140
INDIRF4
SUBF4
ASGNF4
line 1835
;1834:
;1835:		side = speed * DotProduct( velocity, axis[0] );
ADDRLP4 140
ADDRLP4 56
INDIRF4
ADDRLP4 40
INDIRF4
ADDRLP4 104
INDIRF4
MULF4
ADDRLP4 40+4
INDIRF4
ADDRLP4 104+4
INDIRF4
MULF4
ADDF4
ADDRLP4 40+8
INDIRF4
ADDRLP4 104+8
INDIRF4
MULF4
ADDF4
MULF4
ASGNF4
line 1836
;1836:		legsAngles[PITCH] += side;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 140
INDIRF4
ADDF4
ASGNF4
line 1837
;1837:	}
LABELV $895
line 1840
;1838:
;1839:	//
;1840:	clientNum = cent->currentState.clientNum;
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 1845
;1841:	// JUHOX: handle monsters too
;1842:#if !MONSTER_MODE
;1843:	if ( clientNum >= 0 && clientNum < MAX_CLIENTS ) {
;1844:#else
;1845:	if (clientNum >= 0 && clientNum < MAX_CLIENTS+EXTRA_CLIENTNUMS) {
ADDRLP4 36
INDIRI4
CNSTI4 0
LTI4 $909
ADDRLP4 36
INDIRI4
CNSTI4 69
GEI4 $909
line 1847
;1846:#endif
;1847:		ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 64
ADDRLP4 36
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320
ADDP4
ASGNP4
line 1848
;1848:		if ( ci->fixedlegs ) {
ADDRLP4 64
INDIRP4
CNSTI4 508
ADDP4
INDIRI4
CNSTI4 0
EQI4 $912
line 1849
;1849:			legsAngles[YAW] = torsoAngles[YAW];
ADDRLP4 12+4
ADDRLP4 0+4
INDIRF4
ASGNF4
line 1850
;1850:			legsAngles[PITCH] = 0.0f;
ADDRLP4 12
CNSTF4 0
ASGNF4
line 1851
;1851:			legsAngles[ROLL] = 0.0f;
ADDRLP4 12+8
CNSTF4 0
ASGNF4
line 1852
;1852:		}
LABELV $912
line 1853
;1853:	}
LABELV $909
line 1856
;1854:
;1855:	// pain twitch
;1856:	CG_AddPainTwitch( cent, torsoAngles );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_AddPainTwitch
CALLV
pop
line 1859
;1857:
;1858:	// pull the angles back out of the hierarchial chain
;1859:	AnglesSubtract( headAngles, torsoAngles, headAngles );
ADDRLP4 24
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 24
ARGP4
ADDRGP4 AnglesSubtract
CALLV
pop
line 1860
;1860:	AnglesSubtract( torsoAngles, legsAngles, torsoAngles );
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 AnglesSubtract
CALLV
pop
line 1861
;1861:	AnglesToAxis( legsAngles, legs );
ADDRLP4 12
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1862
;1862:	AnglesToAxis( torsoAngles, torso );
ADDRLP4 0
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1863
;1863:	AnglesToAxis( headAngles, head );
ADDRLP4 24
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1864
;1864:}
LABELV $861
endproc CG_PlayerAngles 144 24
proc CG_HasteTrail 32 48
line 1874
;1865:
;1866:
;1867://==========================================================================
;1868:
;1869:/*
;1870:===============
;1871:CG_HasteTrail
;1872:===============
;1873:*/
;1874:static void CG_HasteTrail( centity_t *cent ) {
line 1879
;1875:	localEntity_t	*smoke;
;1876:	vec3_t			origin;
;1877:	int				anim;
;1878:
;1879:	if ( cent->trailTime > cg.time ) {
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRI4
ADDRGP4 cg+107656
INDIRI4
LEI4 $918
line 1880
;1880:		return;
ADDRGP4 $917
JUMPV
LABELV $918
line 1882
;1881:	}
;1882:	anim = cent->pe.legs.animationNumber & ~ANIM_TOGGLEBIT;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 1883
;1883:	if ( anim != LEGS_RUN && anim != LEGS_BACK ) {
ADDRLP4 12
INDIRI4
CNSTI4 15
EQI4 $921
ADDRLP4 12
INDIRI4
CNSTI4 16
EQI4 $921
line 1884
;1884:		return;
ADDRGP4 $917
JUMPV
LABELV $921
line 1887
;1885:	}
;1886:
;1887:	cent->trailTime += 100;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 1888
;1888:	if ( cent->trailTime < cg.time ) {
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRI4
ADDRGP4 cg+107656
INDIRI4
GEI4 $923
line 1889
;1889:		cent->trailTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 1890
;1890:	}
LABELV $923
line 1892
;1891:
;1892:	VectorCopy( cent->lerpOrigin, origin );
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
INDIRB
ASGNB 12
line 1893
;1893:	origin[2] -= 16;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 1895
;1894:
;1895:	smoke = CG_SmokePuff( origin, vec3_origin, 
ADDRLP4 0
ARGP4
ADDRGP4 vec3_origin
ARGP4
CNSTF4 1090519040
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1140457472
ARGF4
ADDRGP4 cg+107656
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+751220+632
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 CG_SmokePuff
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 28
INDIRP4
ASGNP4
line 1905
;1896:				  8, 
;1897:				  1, 1, 1, 1,
;1898:				  500, 
;1899:				  cg.time,
;1900:				  0,
;1901:				  0,
;1902:				  cgs.media.hastePuffShader );
;1903:
;1904:	// use the optimized local entity add
;1905:	smoke->leType = LE_SCALE_FADE;
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 7
ASGNI4
line 1906
;1906:}
LABELV $917
endproc CG_HasteTrail 32 48
proc CG_TrailItem 188 12
line 2001
;1907:
;1908:#ifdef MISSIONPACK
;1909:/*
;1910:===============
;1911:CG_BreathPuffs
;1912:===============
;1913:*/
;1914:static void CG_BreathPuffs( centity_t *cent, refEntity_t *head) {
;1915:	clientInfo_t *ci;
;1916:	vec3_t up, origin;
;1917:	int contents;
;1918:
;1919:	ci = &cgs.clientinfo[ cent->currentState.number ];
;1920:
;1921:	if (!cg_enableBreath.integer) {
;1922:		return;
;1923:	}
;1924:	if ( cent->currentState.number == cg.snap->ps.clientNum && !cg.renderingThirdPerson) {
;1925:		return;
;1926:	}
;1927:	if ( cent->currentState.eFlags & EF_DEAD ) {
;1928:		return;
;1929:	}
;1930:	contents = trap_CM_PointContents( head->origin, 0 );
;1931:	if ( contents & ( CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA ) ) {
;1932:		return;
;1933:	}
;1934:	if ( ci->breathPuffTime > cg.time ) {
;1935:		return;
;1936:	}
;1937:
;1938:	VectorSet( up, 0, 0, 8 );
;1939:	VectorMA(head->origin, 8, head->axis[0], origin);
;1940:	VectorMA(origin, -4, head->axis[2], origin);
;1941:	CG_SmokePuff( origin, up, 16, 1, 1, 1, 0.66f, 1500, cg.time, cg.time + 400, LEF_PUFF_DONT_SCALE, cgs.media.shotgunSmokePuffShader );
;1942:	ci->breathPuffTime = cg.time + 2000;
;1943:}
;1944:
;1945:/*
;1946:===============
;1947:CG_DustTrail
;1948:===============
;1949:*/
;1950:static void CG_DustTrail( centity_t *cent ) {
;1951:	int				anim;
;1952:	localEntity_t	*dust;
;1953:	vec3_t end, vel;
;1954:	trace_t tr;
;1955:
;1956:	if (!cg_enableDust.integer)
;1957:		return;
;1958:
;1959:	if ( cent->dustTrailTime > cg.time ) {
;1960:		return;
;1961:	}
;1962:
;1963:	anim = cent->pe.legs.animationNumber & ~ANIM_TOGGLEBIT;
;1964:	if ( anim != LEGS_LANDB && anim != LEGS_LAND ) {
;1965:		return;
;1966:	}
;1967:
;1968:	cent->dustTrailTime += 40;
;1969:	if ( cent->dustTrailTime < cg.time ) {
;1970:		cent->dustTrailTime = cg.time;
;1971:	}
;1972:
;1973:	VectorCopy(cent->currentState.pos.trBase, end);
;1974:	end[2] -= 64;
;1975:	CG_Trace( &tr, cent->currentState.pos.trBase, NULL, NULL, end, cent->currentState.number, MASK_PLAYERSOLID );
;1976:
;1977:	if ( !(tr.surfaceFlags & SURF_DUST) )
;1978:		return;
;1979:
;1980:	VectorCopy( cent->currentState.pos.trBase, end );
;1981:	end[2] -= 16;
;1982:
;1983:	VectorSet(vel, 0, 0, -30);
;1984:	dust = CG_SmokePuff( end, vel,
;1985:				  24,
;1986:				  .8f, .8f, 0.7f, 0.33f,
;1987:				  500,
;1988:				  cg.time,
;1989:				  0,
;1990:				  0,
;1991:				  cgs.media.dustPuffShader );
;1992:}
;1993:
;1994:#endif
;1995:
;1996:/*
;1997:===============
;1998:CG_TrailItem
;1999:===============
;2000:*/
;2001:static void CG_TrailItem( centity_t *cent, qhandle_t hModel ) {
line 2006
;2002:	refEntity_t		ent;
;2003:	vec3_t			angles;
;2004:	vec3_t			axis[3];
;2005:
;2006:	VectorCopy( cent->lerpAngles, angles );
ADDRLP4 140
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
INDIRB
ASGNB 12
line 2007
;2007:	angles[PITCH] = 0;
ADDRLP4 140
CNSTF4 0
ASGNF4
line 2008
;2008:	angles[ROLL] = 0;
ADDRLP4 140+8
CNSTF4 0
ASGNF4
line 2009
;2009:	AnglesToAxis( angles, axis );
ADDRLP4 140
ARGP4
ADDRLP4 152
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 2011
;2010:
;2011:	memset( &ent, 0, sizeof( ent ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2012
;2012:	VectorMA( cent->lerpOrigin, -16, axis[0], ent.origin );
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
INDIRF4
ADDRLP4 152
INDIRF4
CNSTF4 3246391296
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+4
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRF4
ADDRLP4 152+4
INDIRF4
CNSTF4 3246391296
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+8
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRF4
ADDRLP4 152+8
INDIRF4
CNSTF4 3246391296
MULF4
ADDF4
ASGNF4
line 2013
;2013:	ent.origin[2] += 16;
ADDRLP4 0+68+8
ADDRLP4 0+68+8
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 2014
;2014:	angles[YAW] += 90;
ADDRLP4 140+4
ADDRLP4 140+4
INDIRF4
CNSTF4 1119092736
ADDF4
ASGNF4
line 2015
;2015:	AnglesToAxis( angles, ent.axis );
ADDRLP4 140
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 2017
;2016:
;2017:	ent.hModel = hModel;
ADDRLP4 0+8
ADDRFP4 4
INDIRI4
ASGNI4
line 2018
;2018:	trap_R_AddRefEntityToScene( &ent );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2019
;2019:}
LABELV $931
endproc CG_TrailItem 188 12
proc CG_PlayerFlag 356 24
line 2027
;2020:
;2021:
;2022:/*
;2023:===============
;2024:CG_PlayerFlag
;2025:===============
;2026:*/
;2027:static void CG_PlayerFlag( centity_t *cent, qhandle_t hSkin, refEntity_t *torso ) {
line 2036
;2028:	clientInfo_t	*ci;
;2029:	refEntity_t	pole;
;2030:	refEntity_t	flag;
;2031:	vec3_t		angles, dir;
;2032:	int			legsAnim, flagAnim, updateangles;
;2033:	float		angle, d;
;2034:
;2035:	// show the flag pole model
;2036:	memset( &pole, 0, sizeof(pole) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2037
;2037:	pole.hModel = cgs.media.flagPoleModel;
ADDRLP4 0+8
ADDRGP4 cgs+751220+140
INDIRI4
ASGNI4
line 2038
;2038:	VectorCopy( torso->lightingOrigin, pole.lightingOrigin );
ADDRLP4 0+12
ADDRFP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRB
ASGNB 12
line 2039
;2039:	pole.shadowPlane = torso->shadowPlane;
ADDRLP4 0+24
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 2040
;2040:	pole.renderfx = torso->renderfx;
ADDRLP4 0+4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 2041
;2041:	CG_PositionEntityOnTag( &pole, torso, torso->hModel, "tag_flag" );
ADDRLP4 0
ARGP4
ADDRLP4 328
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 328
INDIRP4
ARGP4
ADDRLP4 328
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 $462
ARGP4
ADDRGP4 CG_PositionEntityOnTag
CALLV
pop
line 2042
;2042:	trap_R_AddRefEntityToScene( &pole );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2045
;2043:
;2044:	// show the flag model
;2045:	memset( &flag, 0, sizeof(flag) );
ADDRLP4 140
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2046
;2046:	flag.hModel = cgs.media.flagFlapModel;
ADDRLP4 140+8
ADDRGP4 cgs+751220+144
INDIRI4
ASGNI4
line 2047
;2047:	flag.customSkin = hSkin;
ADDRLP4 140+108
ADDRFP4 4
INDIRI4
ASGNI4
line 2048
;2048:	VectorCopy( torso->lightingOrigin, flag.lightingOrigin );
ADDRLP4 140+12
ADDRFP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRB
ASGNB 12
line 2049
;2049:	flag.shadowPlane = torso->shadowPlane;
ADDRLP4 140+24
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 2050
;2050:	flag.renderfx = torso->renderfx;
ADDRLP4 140+4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 2052
;2051:
;2052:	VectorClear(angles);
ADDRLP4 332
CNSTF4 0
ASGNF4
ADDRLP4 280+8
ADDRLP4 332
INDIRF4
ASGNF4
ADDRLP4 280+4
ADDRLP4 332
INDIRF4
ASGNF4
ADDRLP4 280
ADDRLP4 332
INDIRF4
ASGNF4
line 2054
;2053:
;2054:	updateangles = qfalse;
ADDRLP4 312
CNSTI4 0
ASGNI4
line 2055
;2055:	legsAnim = cent->currentState.legsAnim & ~ANIM_TOGGLEBIT;
ADDRLP4 304
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 2056
;2056:	if( legsAnim == LEGS_IDLE || legsAnim == LEGS_IDLECR ) {
ADDRLP4 304
INDIRI4
CNSTI4 22
EQI4 $963
ADDRLP4 304
INDIRI4
CNSTI4 23
NEI4 $961
LABELV $963
line 2057
;2057:		flagAnim = FLAG_STAND;
ADDRLP4 320
CNSTI4 35
ASGNI4
line 2058
;2058:	} else if ( legsAnim == LEGS_WALK || legsAnim == LEGS_WALKCR ) {
ADDRGP4 $962
JUMPV
LABELV $961
ADDRLP4 304
INDIRI4
CNSTI4 14
EQI4 $966
ADDRLP4 304
INDIRI4
CNSTI4 13
NEI4 $964
LABELV $966
line 2059
;2059:		flagAnim = FLAG_STAND;
ADDRLP4 320
CNSTI4 35
ASGNI4
line 2060
;2060:		updateangles = qtrue;
ADDRLP4 312
CNSTI4 1
ASGNI4
line 2061
;2061:	} else {
ADDRGP4 $965
JUMPV
LABELV $964
line 2062
;2062:		flagAnim = FLAG_RUN;
ADDRLP4 320
CNSTI4 34
ASGNI4
line 2063
;2063:		updateangles = qtrue;
ADDRLP4 312
CNSTI4 1
ASGNI4
line 2064
;2064:	}
LABELV $965
LABELV $962
line 2066
;2065:
;2066:	if ( updateangles ) {
ADDRLP4 312
INDIRI4
CNSTI4 0
EQI4 $967
line 2068
;2067:
;2068:		VectorCopy( cent->currentState.pos.trDelta, dir );
ADDRLP4 292
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRB
ASGNB 12
line 2070
;2069:		// add gravity
;2070:		dir[2] += 100;
ADDRLP4 292+8
ADDRLP4 292+8
INDIRF4
CNSTF4 1120403456
ADDF4
ASGNF4
line 2071
;2071:		VectorNormalize( dir );
ADDRLP4 292
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 2072
;2072:		d = DotProduct(pole.axis[2], dir);
ADDRLP4 308
ADDRLP4 0+28+24
INDIRF4
ADDRLP4 292
INDIRF4
MULF4
ADDRLP4 0+28+24+4
INDIRF4
ADDRLP4 292+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+28+24+8
INDIRF4
ADDRLP4 292+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 2074
;2073:		// if there is anough movement orthogonal to the flag pole
;2074:		if (fabs(d) < 0.9) {
ADDRLP4 308
INDIRF4
ARGF4
ADDRLP4 344
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 344
INDIRF4
CNSTF4 1063675494
GEF4 $980
line 2076
;2075:			//
;2076:			d = DotProduct(pole.axis[0], dir);
ADDRLP4 308
ADDRLP4 0+28
INDIRF4
ADDRLP4 292
INDIRF4
MULF4
ADDRLP4 0+28+4
INDIRF4
ADDRLP4 292+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+28+8
INDIRF4
ADDRLP4 292+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 2077
;2077:			if (d > 1.0f) {
ADDRLP4 308
INDIRF4
CNSTF4 1065353216
LEF4 $989
line 2078
;2078:				d = 1.0f;
ADDRLP4 308
CNSTF4 1065353216
ASGNF4
line 2079
;2079:			}
ADDRGP4 $990
JUMPV
LABELV $989
line 2080
;2080:			else if (d < -1.0f) {
ADDRLP4 308
INDIRF4
CNSTF4 3212836864
GEF4 $991
line 2081
;2081:				d = -1.0f;
ADDRLP4 308
CNSTF4 3212836864
ASGNF4
line 2082
;2082:			}
LABELV $991
LABELV $990
line 2083
;2083:			angle = acos(d);
ADDRLP4 308
INDIRF4
ARGF4
ADDRLP4 348
ADDRGP4 acos
CALLF4
ASGNF4
ADDRLP4 324
ADDRLP4 348
INDIRF4
ASGNF4
line 2085
;2084:
;2085:			d = DotProduct(pole.axis[1], dir);
ADDRLP4 308
ADDRLP4 0+28+12
INDIRF4
ADDRLP4 292
INDIRF4
MULF4
ADDRLP4 0+28+12+4
INDIRF4
ADDRLP4 292+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+28+12+8
INDIRF4
ADDRLP4 292+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 2086
;2086:			if (d < 0) {
ADDRLP4 308
INDIRF4
CNSTF4 0
GEF4 $1003
line 2087
;2087:				angles[YAW] = 360 - angle * 180 / M_PI;
ADDRLP4 280+4
CNSTF4 1135869952
ADDRLP4 324
INDIRF4
CNSTF4 1113927393
MULF4
SUBF4
ASGNF4
line 2088
;2088:			}
ADDRGP4 $1004
JUMPV
LABELV $1003
line 2089
;2089:			else {
line 2090
;2090:				angles[YAW] = angle * 180 / M_PI;
ADDRLP4 280+4
ADDRLP4 324
INDIRF4
CNSTF4 1113927393
MULF4
ASGNF4
line 2091
;2091:			}
LABELV $1004
line 2092
;2092:			if (angles[YAW] < 0)
ADDRLP4 280+4
INDIRF4
CNSTF4 0
GEF4 $1007
line 2093
;2093:				angles[YAW] += 360;
ADDRLP4 280+4
ADDRLP4 280+4
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
LABELV $1007
line 2094
;2094:			if (angles[YAW] > 360)
ADDRLP4 280+4
INDIRF4
CNSTF4 1135869952
LEF4 $1011
line 2095
;2095:				angles[YAW] -= 360;
ADDRLP4 280+4
ADDRLP4 280+4
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
LABELV $1011
line 2100
;2096:
;2097:			//vectoangles( cent->currentState.pos.trDelta, tmpangles );
;2098:			//angles[YAW] = tmpangles[YAW] + 45 - cent->pe.torso.yawAngle;
;2099:			// change the yaw angle
;2100:			CG_SwingAngles( angles[YAW], 25, 90, 0.15f, &cent->pe.flag.yawAngle, &cent->pe.flag.yawing );
ADDRLP4 280+4
INDIRF4
ARGF4
CNSTF4 1103626240
ARGF4
CNSTF4 1119092736
ARGF4
CNSTF4 1041865114
ARGF4
ADDRLP4 352
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 352
INDIRP4
CNSTI4 576
ADDP4
ARGP4
ADDRLP4 352
INDIRP4
CNSTI4 580
ADDP4
ARGP4
ADDRGP4 CG_SwingAngles
CALLV
pop
line 2101
;2101:		}
LABELV $980
line 2121
;2102:
;2103:		/*
;2104:		d = DotProduct(pole.axis[2], dir);
;2105:		angle = Q_acos(d);
;2106:
;2107:		d = DotProduct(pole.axis[1], dir);
;2108:		if (d < 0) {
;2109:			angle = 360 - angle * 180 / M_PI;
;2110:		}
;2111:		else {
;2112:			angle = angle * 180 / M_PI;
;2113:		}
;2114:		if (angle > 340 && angle < 20) {
;2115:			flagAnim = FLAG_RUNUP;
;2116:		}
;2117:		if (angle > 160 && angle < 200) {
;2118:			flagAnim = FLAG_RUNDOWN;
;2119:		}
;2120:		*/
;2121:	}
LABELV $967
line 2124
;2122:
;2123:	// set the yaw angle
;2124:	angles[YAW] = cent->pe.flag.yawAngle;
ADDRLP4 280+4
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRF4
ASGNF4
line 2126
;2125:	// lerp the flag animation frames
;2126:	ci = &cgs.clientinfo[ cent->currentState.clientNum ];
ADDRLP4 316
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320
ADDP4
ASGNP4
line 2127
;2127:	CG_RunLerpFrame( ci, &cent->pe.flag, flagAnim, 1 );
ADDRLP4 316
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 556
ADDP4
ARGP4
ADDRLP4 320
INDIRI4
ARGI4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_RunLerpFrame
CALLV
pop
line 2128
;2128:	flag.oldframe = cent->pe.flag.oldFrame;
ADDRLP4 140+96
ADDRFP4 0
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
ASGNI4
line 2129
;2129:	flag.frame = cent->pe.flag.frame;
ADDRLP4 140+80
ADDRFP4 0
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
ASGNI4
line 2130
;2130:	flag.backlerp = cent->pe.flag.backlerp;
ADDRLP4 140+100
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRF4
ASGNF4
line 2132
;2131:
;2132:	AnglesToAxis( angles, flag.axis );
ADDRLP4 280
ARGP4
ADDRLP4 140+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 2133
;2133:	CG_PositionRotatedEntityOnTag( &flag, &pole, pole.hModel, "tag_flag" );
ADDRLP4 140
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 $462
ARGP4
ADDRGP4 CG_PositionRotatedEntityOnTag
CALLV
pop
line 2135
;2134:
;2135:	trap_R_AddRefEntityToScene( &flag );
ADDRLP4 140
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2136
;2136:}
LABELV $945
endproc CG_PlayerFlag 356 24
proc CG_PlayerPowerups 12 20
line 2212
;2137:
;2138:
;2139:#ifdef MISSIONPACK // bk001204
;2140:/*
;2141:===============
;2142:CG_PlayerTokens
;2143:===============
;2144:*/
;2145:static void CG_PlayerTokens( centity_t *cent, int renderfx ) {
;2146:	int			tokens, i, j;
;2147:	float		angle;
;2148:	refEntity_t	ent;
;2149:	vec3_t		dir, origin;
;2150:	skulltrail_t *trail;
;2151:	trail = &cg.skulltrails[cent->currentState.number];
;2152:	tokens = cent->currentState.generic1;
;2153:	if ( !tokens ) {
;2154:		trail->numpositions = 0;
;2155:		return;
;2156:	}
;2157:
;2158:	if ( tokens > MAX_SKULLTRAIL ) {
;2159:		tokens = MAX_SKULLTRAIL;
;2160:	}
;2161:
;2162:	// add skulls if there are more than last time
;2163:	for (i = 0; i < tokens - trail->numpositions; i++) {
;2164:		for (j = trail->numpositions; j > 0; j--) {
;2165:			VectorCopy(trail->positions[j-1], trail->positions[j]);
;2166:		}
;2167:		VectorCopy(cent->lerpOrigin, trail->positions[0]);
;2168:	}
;2169:	trail->numpositions = tokens;
;2170:
;2171:	// move all the skulls along the trail
;2172:	VectorCopy(cent->lerpOrigin, origin);
;2173:	for (i = 0; i < trail->numpositions; i++) {
;2174:		VectorSubtract(trail->positions[i], origin, dir);
;2175:		if (VectorNormalize(dir) > 30) {
;2176:			VectorMA(origin, 30, dir, trail->positions[i]);
;2177:		}
;2178:		VectorCopy(trail->positions[i], origin);
;2179:	}
;2180:
;2181:	memset( &ent, 0, sizeof( ent ) );
;2182:	if( cgs.clientinfo[ cent->currentState.clientNum ].team == TEAM_BLUE ) {
;2183:		ent.hModel = cgs.media.redCubeModel;
;2184:	} else {
;2185:		ent.hModel = cgs.media.blueCubeModel;
;2186:	}
;2187:	ent.renderfx = renderfx;
;2188:
;2189:	VectorCopy(cent->lerpOrigin, origin);
;2190:	for (i = 0; i < trail->numpositions; i++) {
;2191:		VectorSubtract(origin, trail->positions[i], ent.axis[0]);
;2192:		ent.axis[0][2] = 0;
;2193:		VectorNormalize(ent.axis[0]);
;2194:		VectorSet(ent.axis[2], 0, 0, 1);
;2195:		CrossProduct(ent.axis[0], ent.axis[2], ent.axis[1]);
;2196:
;2197:		VectorCopy(trail->positions[i], ent.origin);
;2198:		angle = (((cg.time + 500 * MAX_SKULLTRAIL - 500 * i) / 16) & 255) * (M_PI * 2) / 255;
;2199:		ent.origin[2] += sin(angle) * 10;
;2200:		trap_R_AddRefEntityToScene( &ent );
;2201:		VectorCopy(trail->positions[i], origin);
;2202:	}
;2203:}
;2204:#endif
;2205:
;2206:
;2207:/*
;2208:===============
;2209:CG_PlayerPowerups
;2210:===============
;2211:*/
;2212:static void CG_PlayerPowerups( centity_t *cent, refEntity_t *torso ) {
line 2218
;2213:	int		powerups;
;2214:	clientInfo_t	*ci;
;2215:
;2216:	// JUHOX FIXME: no dlights in EFH
;2217:#if ESCAPE_MODE
;2218:	if (cgs.gametype == GT_EFH) return;
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 9
NEI4 $1024
ADDRGP4 $1023
JUMPV
LABELV $1024
line 2221
;2219:#endif
;2220:
;2221:	powerups = cent->currentState.powerups;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ASGNI4
line 2222
;2222:	if ( !powerups ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1027
line 2223
;2223:		return;
ADDRGP4 $1023
JUMPV
LABELV $1027
line 2228
;2224:	}
;2225:
;2226:	// JUHOX: moved to here from below
;2227:#if 1
;2228:	ci = &cgs.clientinfo[ cent->currentState.clientNum ];
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320
ADDP4
ASGNP4
line 2231
;2229:#endif
;2230:	// quad gives a dlight
;2231:	if ( powerups & ( 1 << PW_QUAD ) ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1030
line 2236
;2232:		// JUHOX: consider team color for the quad light color
;2233:#if 0
;2234:		trap_R_AddLightToScene( cent->lerpOrigin, 200 + (rand()&31), 0.2f, 0.2f, 1 );
;2235:#else
;2236:		if (ci->team == TEAM_RED) {
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1032
line 2237
;2237:			trap_R_AddLightToScene( cent->lerpOrigin, 200 + (rand()&31), 1, 0.2f, 0.2f );
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 31
BANDI4
CNSTI4 200
ADDI4
CVIF4 4
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1045220557
ARGF4
CNSTF4 1045220557
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 2238
;2238:		}
ADDRGP4 $1033
JUMPV
LABELV $1032
line 2239
;2239:		else {
line 2240
;2240:			trap_R_AddLightToScene( cent->lerpOrigin, 200 + (rand()&31), 0.2f, 0.2f, 1 );
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 31
BANDI4
CNSTI4 200
ADDI4
CVIF4 4
ARGF4
CNSTF4 1045220557
ARGF4
CNSTF4 1045220557
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 2241
;2241:		}
LABELV $1033
line 2243
;2242:#endif
;2243:	}
LABELV $1030
line 2246
;2244:
;2245:	// flight plays a looped sound
;2246:	if ( powerups & ( 1 << PW_FLIGHT ) ) {
ADDRLP4 0
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $1034
line 2247
;2247:		trap_S_AddLoopingSound( cent->currentState.number, cent->lerpOrigin, vec3_origin, cgs.media.flightSound );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 728
ADDP4
ARGP4
ADDRGP4 vec3_origin
ARGP4
ADDRGP4 cgs+751220+1360
INDIRI4
ARGI4
ADDRGP4 trap_S_AddLoopingSound_fixed
CALLV
pop
line 2248
;2248:	}
LABELV $1034
line 2255
;2249:
;2250:	// JUHOX: we need this earlier
;2251:#if 0
;2252:	ci = &cgs.clientinfo[ cent->currentState.clientNum ];
;2253:#endif
;2254:	// redflag
;2255:	if ( powerups & ( 1 << PW_REDFLAG ) ) {
ADDRLP4 0
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $1038
line 2256
;2256:		if (ci->newAnims) {
ADDRLP4 4
INDIRP4
CNSTI4 504
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1040
line 2257
;2257:			CG_PlayerFlag( cent, cgs.media.redFlagFlapSkin, torso );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+751220+148
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_PlayerFlag
CALLV
pop
line 2258
;2258:		}
ADDRGP4 $1041
JUMPV
LABELV $1040
line 2259
;2259:		else {
line 2260
;2260:			CG_TrailItem( cent, cgs.media.redFlagModel );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+751220+88
INDIRI4
ARGI4
ADDRGP4 CG_TrailItem
CALLV
pop
line 2261
;2261:		}
LABELV $1041
line 2262
;2262:		trap_R_AddLightToScene( cent->lerpOrigin, 200 + (rand()&31), 1.0, 0.2f, 0.2f );
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 31
BANDI4
CNSTI4 200
ADDI4
CVIF4 4
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1045220557
ARGF4
CNSTF4 1045220557
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 2263
;2263:	}
LABELV $1038
line 2266
;2264:
;2265:	// blueflag
;2266:	if ( powerups & ( 1 << PW_BLUEFLAG ) ) {
ADDRLP4 0
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $1046
line 2267
;2267:		if (ci->newAnims){
ADDRLP4 4
INDIRP4
CNSTI4 504
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1048
line 2268
;2268:			CG_PlayerFlag( cent, cgs.media.blueFlagFlapSkin, torso );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+751220+152
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_PlayerFlag
CALLV
pop
line 2269
;2269:		}
ADDRGP4 $1049
JUMPV
LABELV $1048
line 2270
;2270:		else {
line 2271
;2271:			CG_TrailItem( cent, cgs.media.blueFlagModel );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+751220+92
INDIRI4
ARGI4
ADDRGP4 CG_TrailItem
CALLV
pop
line 2272
;2272:		}
LABELV $1049
line 2273
;2273:		trap_R_AddLightToScene( cent->lerpOrigin, 200 + (rand()&31), 0.2f, 0.2f, 1.0 );
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 31
BANDI4
CNSTI4 200
ADDI4
CVIF4 4
ARGF4
CNSTF4 1045220557
ARGF4
CNSTF4 1045220557
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 2274
;2274:	}
LABELV $1046
line 2277
;2275:
;2276:	// neutralflag
;2277:	if ( powerups & ( 1 << PW_NEUTRALFLAG ) ) {
ADDRLP4 0
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $1054
line 2278
;2278:		if (ci->newAnims) {
ADDRLP4 4
INDIRP4
CNSTI4 504
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1056
line 2279
;2279:			CG_PlayerFlag( cent, cgs.media.neutralFlagFlapSkin, torso );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+751220+156
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_PlayerFlag
CALLV
pop
line 2280
;2280:		}
ADDRGP4 $1057
JUMPV
LABELV $1056
line 2281
;2281:		else {
line 2282
;2282:			CG_TrailItem( cent, cgs.media.neutralFlagModel );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+751220+96
INDIRI4
ARGI4
ADDRGP4 CG_TrailItem
CALLV
pop
line 2283
;2283:		}
LABELV $1057
line 2284
;2284:		trap_R_AddLightToScene( cent->lerpOrigin, 200 + (rand()&31), 1.0, 1.0, 1.0 );
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 31
BANDI4
CNSTI4 200
ADDI4
CVIF4 4
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 2285
;2285:	}
LABELV $1054
line 2304
;2286:	// -JUHOX: PW_CHARGE lighting
;2287:#if 0
;2288:	if (powerups & (1 << PW_CHARGE)) {
;2289:		float intensity;
;2290:
;2291:		intensity = cent->currentState.time2 - cg.time;
;2292:		if (intensity > 0) {
;2293:			if (intensity > 10000) intensity = 10000;
;2294:			trap_R_AddLightToScene(
;2295:				cent->lerpOrigin,
;2296:				(intensity / 10000.0) * (200 + (rand()&63)),
;2297:				1.0, 1.0, 1.0
;2298:			);
;2299:		}
;2300:	}
;2301:#endif
;2302:
;2303:	// haste leaves smoke trails
;2304:	if ( powerups & ( 1 << PW_HASTE ) ) {
ADDRLP4 0
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $1062
line 2305
;2305:		CG_HasteTrail( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_HasteTrail
CALLV
pop
line 2306
;2306:	}
LABELV $1062
line 2307
;2307:}
LABELV $1023
endproc CG_PlayerPowerups 12 20
proc CG_PlayerFloatSprite 144 12
line 2317
;2308:
;2309:
;2310:/*
;2311:===============
;2312:CG_PlayerFloatSprite
;2313:
;2314:Float a sprite over the player's head
;2315:===============
;2316:*/
;2317:static void CG_PlayerFloatSprite( centity_t *cent, qhandle_t shader ) {
line 2321
;2318:	int				rf;
;2319:	refEntity_t		ent;
;2320:
;2321:	if ( cent->currentState.number == cg.snap->ps.clientNum && !cg.renderingThirdPerson ) {
ADDRFP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $1065
ADDRGP4 cg+107680
INDIRI4
CNSTI4 0
NEI4 $1065
line 2322
;2322:		rf = RF_THIRD_PERSON;		// only show in mirrors
ADDRLP4 140
CNSTI4 2
ASGNI4
line 2323
;2323:	} else {
ADDRGP4 $1066
JUMPV
LABELV $1065
line 2324
;2324:		rf = 0;
ADDRLP4 140
CNSTI4 0
ASGNI4
line 2325
;2325:	}
LABELV $1066
line 2327
;2326:
;2327:	memset( &ent, 0, sizeof( ent ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2328
;2328:	VectorCopy( cent->lerpOrigin, ent.origin );
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
INDIRB
ASGNB 12
line 2329
;2329:	ent.origin[2] += 48;
ADDRLP4 0+68+8
ADDRLP4 0+68+8
INDIRF4
CNSTF4 1111490560
ADDF4
ASGNF4
line 2330
;2330:	ent.reType = RT_SPRITE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 2331
;2331:	ent.customShader = shader;
ADDRLP4 0+112
ADDRFP4 4
INDIRI4
ASGNI4
line 2332
;2332:	ent.radius = 10;
ADDRLP4 0+132
CNSTF4 1092616192
ASGNF4
line 2333
;2333:	ent.renderfx = rf;
ADDRLP4 0+4
ADDRLP4 140
INDIRI4
ASGNI4
line 2334
;2334:	ent.shaderRGBA[0] = 255;
ADDRLP4 0+116
CNSTU1 255
ASGNU1
line 2335
;2335:	ent.shaderRGBA[1] = 255;
ADDRLP4 0+116+1
CNSTU1 255
ASGNU1
line 2336
;2336:	ent.shaderRGBA[2] = 255;
ADDRLP4 0+116+2
CNSTU1 255
ASGNU1
line 2337
;2337:	ent.shaderRGBA[3] = 255;
ADDRLP4 0+116+3
CNSTU1 255
ASGNU1
line 2338
;2338:	trap_R_AddRefEntityToScene( &ent );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2339
;2339:}
LABELV $1064
endproc CG_PlayerFloatSprite 144 12
proc CG_PlayerGroupSprite 144 12
line 2346
;2340:
;2341:/*
;2342:===============
;2343:JUHOX: CG_PlayerGroupSprite
;2344:===============
;2345:*/
;2346:static void CG_PlayerGroupSprite(centity_t *cent, qhandle_t shader, int rgb) {
line 2350
;2347:	int				rf;
;2348:	refEntity_t		ent;
;2349:
;2350:	if ( cent->currentState.number == cg.snap->ps.clientNum && !cg.renderingThirdPerson ) {
ADDRFP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $1083
ADDRGP4 cg+107680
INDIRI4
CNSTI4 0
NEI4 $1083
line 2351
;2351:		rf = RF_THIRD_PERSON;		// only show in mirrors
ADDRLP4 140
CNSTI4 2
ASGNI4
line 2352
;2352:	} else {
ADDRGP4 $1084
JUMPV
LABELV $1083
line 2353
;2353:		rf = 0;
ADDRLP4 140
CNSTI4 0
ASGNI4
line 2354
;2354:	}
LABELV $1084
line 2356
;2355:
;2356:	memset(&ent, 0, sizeof(ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2357
;2357:	VectorCopy(cent->lerpOrigin, ent.origin);
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
INDIRB
ASGNB 12
line 2358
;2358:	ent.origin[2] += 48;
ADDRLP4 0+68+8
ADDRLP4 0+68+8
INDIRF4
CNSTF4 1111490560
ADDF4
ASGNF4
line 2359
;2359:	ent.reType = RT_SPRITE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 2360
;2360:	ent.customShader = shader;
ADDRLP4 0+112
ADDRFP4 4
INDIRI4
ASGNI4
line 2361
;2361:	ent.radius = 10;
ADDRLP4 0+132
CNSTF4 1092616192
ASGNF4
line 2362
;2362:	ent.renderfx = rf;
ADDRLP4 0+4
ADDRLP4 140
INDIRI4
ASGNI4
line 2363
;2363:	ent.shaderRGBA[0] = (rgb >> 16) & 255;
ADDRLP4 0+116
ADDRFP4 8
INDIRI4
CNSTI4 16
RSHI4
CNSTI4 255
BANDI4
CVIU4 4
CVUU1 4
ASGNU1
line 2364
;2364:	ent.shaderRGBA[1] = (rgb >>  8) & 255;
ADDRLP4 0+116+1
ADDRFP4 8
INDIRI4
CNSTI4 8
RSHI4
CNSTI4 255
BANDI4
CVIU4 4
CVUU1 4
ASGNU1
line 2365
;2365:	ent.shaderRGBA[2] = (rgb      ) & 255;
ADDRLP4 0+116+2
ADDRFP4 8
INDIRI4
CNSTI4 255
BANDI4
CVIU4 4
CVUU1 4
ASGNU1
line 2366
;2366:	ent.shaderRGBA[3] = 255;
ADDRLP4 0+116+3
CNSTU1 255
ASGNU1
line 2367
;2367:	trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2368
;2368:}
LABELV $1082
endproc CG_PlayerGroupSprite 144 12
proc CG_PlayerSprites 52 12
line 2377
;2369:
;2370:/*
;2371:===============
;2372:CG_PlayerSprites
;2373:
;2374:Float sprites over the player's head
;2375:===============
;2376:s*/
;2377:static void CG_PlayerSprites( centity_t *cent ) {
line 2380
;2378:	int		team;
;2379:
;2380:	if ( cent->currentState.eFlags & EF_CONNECTION ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $1101
line 2381
;2381:		CG_PlayerFloatSprite( cent, cgs.media.connectionShader );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+751220+376
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2382
;2382:		return;
ADDRGP4 $1100
JUMPV
LABELV $1101
line 2385
;2383:	}
;2384:
;2385:	if ( cent->currentState.eFlags & EF_TALK ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $1105
line 2386
;2386:		CG_PlayerFloatSprite( cent, cgs.media.balloonShader );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+751220+372
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2387
;2387:		return;
ADDRGP4 $1100
JUMPV
LABELV $1105
line 2390
;2388:	}
;2389:
;2390:	if ( cent->currentState.eFlags & EF_AWARD_IMPRESSIVE ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $1109
line 2391
;2391:		CG_PlayerFloatSprite( cent, cgs.media.medalImpressive );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+751220+756
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2392
;2392:		return;
ADDRGP4 $1100
JUMPV
LABELV $1109
line 2395
;2393:	}
;2394:
;2395:	if ( cent->currentState.eFlags & EF_AWARD_EXCELLENT ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $1113
line 2396
;2396:		CG_PlayerFloatSprite( cent, cgs.media.medalExcellent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+751220+760
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2397
;2397:		return;
ADDRGP4 $1100
JUMPV
LABELV $1113
line 2400
;2398:	}
;2399:
;2400:	if ( cent->currentState.eFlags & EF_AWARD_GAUNTLET ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $1117
line 2401
;2401:		CG_PlayerFloatSprite( cent, cgs.media.medalGauntlet );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+751220+764
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2402
;2402:		return;
ADDRGP4 $1100
JUMPV
LABELV $1117
line 2405
;2403:	}
;2404:
;2405:	if ( cent->currentState.eFlags & EF_AWARD_DEFEND ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 65536
BANDI4
CNSTI4 0
EQI4 $1121
line 2406
;2406:		CG_PlayerFloatSprite( cent, cgs.media.medalDefend );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+751220+768
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2407
;2407:		return;
ADDRGP4 $1100
JUMPV
LABELV $1121
line 2410
;2408:	}
;2409:
;2410:	if ( cent->currentState.eFlags & EF_AWARD_ASSIST ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 131072
BANDI4
CNSTI4 0
EQI4 $1125
line 2411
;2411:		CG_PlayerFloatSprite( cent, cgs.media.medalAssist );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+751220+772
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2412
;2412:		return;
ADDRGP4 $1100
JUMPV
LABELV $1125
line 2415
;2413:	}
;2414:
;2415:	if ( cent->currentState.eFlags & EF_AWARD_CAP ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $1129
line 2416
;2416:		CG_PlayerFloatSprite( cent, cgs.media.medalCapture );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+751220+776
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2417
;2417:		return;
ADDRGP4 $1100
JUMPV
LABELV $1129
line 2422
;2418:	}
;2419:
;2420:#if MONSTER_MODE	// JUHOX: mark monsters created by our client
;2421:	if (
;2422:		cgs.gametype < GT_STU &&
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 8
GEI4 $1133
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $1133
ADDRLP4 4
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 64
LTI4 $1133
ADDRLP4 4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $1133
line 2426
;2423:		!(cent->currentState.eFlags & EF_DEAD) &&
;2424:		cent->currentState.clientNum >= MAX_CLIENTS &&
;2425:		cent->currentState.otherEntityNum == cg.snap->ps.clientNum
;2426:	) {
line 2427
;2427:		CG_PlayerFloatSprite(cent, cgs.media.friendShader);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+751220+368
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2428
;2428:		return;
ADDRGP4 $1100
JUMPV
LABELV $1133
line 2432
;2429:	}
;2430:#endif
;2431:
;2432:	team = cgs.clientinfo[ cent->currentState.clientNum ].team;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320+68
ADDP4
INDIRI4
ASGNI4
line 2433
;2433:	if ( !(cent->currentState.eFlags & EF_DEAD) && 
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $1141
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $1141
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $1141
line 2435
;2434:		cg.snap->ps.persistant[PERS_TEAM] == team &&
;2435:		cgs.gametype >= GT_TEAM) {
line 2436
;2436:		if (cg_drawFriend.integer) {
ADDRGP4 cg_drawFriend+12
INDIRI4
CNSTI4 0
EQI4 $1100
line 2440
;2437:#if 0	// JUHOX: draw group mark sprites
;2438:			CG_PlayerFloatSprite( cent, cgs.media.friendShader );
;2439:#else
;2440:			if (BG_TSS_GetPlayerEntityInfo(&cent->currentState, TSSPI_isValid)) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8
ADDRGP4 BG_TSS_GetPlayerEntityInfo
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $1100
line 2447
;2441:				tss_groupMemberStatus_t gms;
;2442:				int group;
;2443:				qhandle_t backShader;
;2444:				int backColor;
;2445:				int frontColor;
;2446:
;2447:				gms = BG_TSS_GetPlayerEntityInfo(&cent->currentState, TSSPI_groupMemberStatus);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 32
ADDRGP4 BG_TSS_GetPlayerEntityInfo
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 32
INDIRI4
ASGNI4
line 2448
;2448:				switch (gms) {
ADDRLP4 36
ADDRLP4 20
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
LTI4 $1150
ADDRLP4 36
INDIRI4
CNSTI4 4
GTI4 $1150
ADDRLP4 36
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1168
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1168
address $1153
address $1156
address $1159
address $1162
address $1165
code
LABELV $1153
line 2450
;2449:				case TSSGMS_retreating:
;2450:					backShader = cgs.media.groupTemporary;
ADDRLP4 16
ADDRGP4 cgs+751220+780
INDIRI4
ASGNI4
line 2451
;2451:					backColor = TSSGROUPCOLOR_BLACK;
ADDRLP4 24
CNSTI4 0
ASGNI4
line 2452
;2452:					frontColor = TSSGROUPCOLOR_MINT;
ADDRLP4 28
CNSTI4 12648384
ASGNI4
line 2453
;2453:					break;
ADDRGP4 $1151
JUMPV
LABELV $1156
line 2455
;2454:				case TSSGMS_temporaryFighter:
;2455:					backShader = cgs.media.groupTemporary;
ADDRLP4 16
ADDRGP4 cgs+751220+780
INDIRI4
ASGNI4
line 2456
;2456:					backColor = TSSGROUPCOLOR_WHITE;
ADDRLP4 24
CNSTI4 16777215
ASGNI4
line 2457
;2457:					frontColor = TSSGROUPCOLOR_BLACK;
ADDRLP4 28
CNSTI4 0
ASGNI4
line 2458
;2458:					break;
ADDRGP4 $1151
JUMPV
LABELV $1159
line 2460
;2459:				case TSSGMS_designatedFighter:
;2460:					backShader = cgs.media.groupDesignated;
ADDRLP4 16
ADDRGP4 cgs+751220+784
INDIRI4
ASGNI4
line 2461
;2461:					backColor = TSSGROUPCOLOR_WHITE;
ADDRLP4 24
CNSTI4 16777215
ASGNI4
line 2462
;2462:					frontColor = TSSGROUPCOLOR_BLACK;
ADDRLP4 28
CNSTI4 0
ASGNI4
line 2463
;2463:					break;
ADDRGP4 $1151
JUMPV
LABELV $1162
line 2465
;2464:				case TSSGMS_temporaryLeader:
;2465:					backShader = cgs.media.groupTemporary;
ADDRLP4 16
ADDRGP4 cgs+751220+780
INDIRI4
ASGNI4
line 2466
;2466:					backColor = TSSGROUPCOLOR_YELLOW;
ADDRLP4 24
CNSTI4 16758817
ASGNI4
line 2467
;2467:					frontColor = TSSGROUPCOLOR_BLACK;
ADDRLP4 28
CNSTI4 0
ASGNI4
line 2468
;2468:					break;
ADDRGP4 $1151
JUMPV
LABELV $1165
line 2470
;2469:				case TSSGMS_designatedLeader:
;2470:					backShader = cgs.media.groupDesignated;
ADDRLP4 16
ADDRGP4 cgs+751220+784
INDIRI4
ASGNI4
line 2471
;2471:					backColor = TSSGROUPCOLOR_YELLOW;
ADDRLP4 24
CNSTI4 16758817
ASGNI4
line 2472
;2472:					frontColor = TSSGROUPCOLOR_BLACK;
ADDRLP4 28
CNSTI4 0
ASGNI4
line 2473
;2473:					break;
ADDRGP4 $1151
JUMPV
LABELV $1150
line 2475
;2474:				default:
;2475:					backShader = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 2476
;2476:					backColor = 0;
ADDRLP4 24
CNSTI4 0
ASGNI4
line 2477
;2477:					frontColor = 0;
ADDRLP4 28
CNSTI4 0
ASGNI4
line 2478
;2478:					break;
LABELV $1151
line 2481
;2479:				}
;2480:				
;2481:				group = BG_TSS_GetPlayerEntityInfo(&cent->currentState, TSSPI_group);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 44
ADDRGP4 BG_TSS_GetPlayerEntityInfo
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 44
INDIRI4
ASGNI4
line 2482
;2482:				if (group >= 0 && group < MAX_GROUPS && backShader) {
ADDRLP4 48
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
LTI4 $1100
ADDRLP4 48
INDIRI4
CNSTI4 10
GEI4 $1100
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $1100
line 2483
;2483:					CG_PlayerGroupSprite(cent, backShader, backColor);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRGP4 CG_PlayerGroupSprite
CALLV
pop
line 2484
;2484:					CG_PlayerGroupSprite(cent, cgs.media.groupMarks[group], frontColor);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+751220+788
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
INDIRI4
ARGI4
ADDRGP4 CG_PlayerGroupSprite
CALLV
pop
line 2485
;2485:				}
line 2486
;2486:			}
line 2488
;2487:#endif
;2488:		}
line 2489
;2489:		return;
LABELV $1141
line 2491
;2490:	}
;2491:}
LABELV $1100
endproc CG_PlayerSprites 52 12
data
align 4
LABELV $1174
byte 4 3245342720
byte 4 3245342720
byte 4 0
align 4
LABELV $1175
byte 4 1097859072
byte 4 1097859072
byte 4 1073741824
code
proc CG_PlayerShadow 112 44
line 2503
;2492:
;2493:/*
;2494:===============
;2495:CG_PlayerShadow
;2496:
;2497:Returns the Z component of the surface being shadowed
;2498:
;2499:  should it return a full plane instead of a Z?
;2500:===============
;2501:*/
;2502:#define	SHADOW_DISTANCE		128
;2503:static qboolean CG_PlayerShadow( centity_t *cent, float *shadowPlane ) {
line 2504
;2504:	vec3_t		end, mins = {-15, -15, 0}, maxs = {15, 15, 2};
ADDRLP4 80
ADDRGP4 $1174
INDIRB
ASGNB 12
ADDRLP4 92
ADDRGP4 $1175
INDIRB
ASGNB 12
line 2513
;2505:	trace_t		trace;
;2506:	float		alpha;
;2507:	// JUHOX: vars needed to adapt player shadow to guard monsters
;2508:#if MONSTER_MODE
;2509:	float shadowDistance;
;2510:	float radius;
;2511:#endif
;2512:
;2513:	*shadowPlane = 0;
ADDRFP4 4
INDIRP4
CNSTF4 0
ASGNF4
line 2515
;2514:
;2515:	if ( cg_shadows.integer == 0 ) {
ADDRGP4 cg_shadows+12
INDIRI4
CNSTI4 0
NEI4 $1176
line 2516
;2516:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1173
JUMPV
LABELV $1176
line 2521
;2517:	}
;2518:
;2519:	// JUHOX FIXME: no shadows for monsters (might exceed internal limits of the Quake engine)
;2520:#if MONSTER_MODE
;2521:	if (cent->currentState.clientNum >= CLIENTNUM_MONSTERS) {
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 64
LTI4 $1179
line 2522
;2522:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1173
JUMPV
LABELV $1179
line 2527
;2523:	}
;2524:#endif
;2525:
;2526:	// no shadows when invisible
;2527:	if ( cent->currentState.powerups & ( 1 << PW_INVIS ) ) {
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1181
line 2528
;2528:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1173
JUMPV
LABELV $1181
line 2533
;2529:	}
;2530:
;2531:	// JUHOX: compute vars needed to adapt player shadow to guard monsters
;2532:#if MONSTER_MODE
;2533:	shadowDistance = SHADOW_DISTANCE;
ADDRLP4 72
CNSTF4 1124073472
ASGNF4
line 2534
;2534:	radius = 24;
ADDRLP4 76
CNSTF4 1103101952
ASGNF4
line 2536
;2535:
;2536:	switch (cent->currentState.clientNum) {
ADDRLP4 104
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
ADDRLP4 104
INDIRI4
CNSTI4 65
EQI4 $1186
ADDRGP4 $1183
JUMPV
LABELV $1186
line 2538
;2537:	case CLIENTNUM_MONSTER_GUARD:
;2538:		shadowDistance *= MONSTER_GUARD_SCALE;
ADDRLP4 72
ADDRLP4 72
INDIRF4
CNSTF4 1073741824
MULF4
ASGNF4
line 2539
;2539:		radius *= MONSTER_GUARD_SCALE;
ADDRLP4 76
ADDRLP4 76
INDIRF4
CNSTF4 1073741824
MULF4
ASGNF4
line 2540
;2540:		break;
LABELV $1183
LABELV $1184
line 2545
;2541:	}
;2542:#endif
;2543:
;2544:	// send a trace down from the player to the ground
;2545:	VectorCopy( cent->lerpOrigin, end );
ADDRLP4 60
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
INDIRB
ASGNB 12
line 2550
;2546:	// JUHOX: adapt shadow distance to guard monsters
;2547:#if !MONSTER_MODE
;2548:	end[2] -= SHADOW_DISTANCE;
;2549:#else
;2550:	end[2] -= shadowDistance;
ADDRLP4 60+8
ADDRLP4 60+8
INDIRF4
ADDRLP4 72
INDIRF4
SUBF4
ASGNF4
line 2553
;2551:#endif
;2552:
;2553:	trap_CM_BoxTrace( &trace, cent->lerpOrigin, end, mins, maxs, 0, MASK_PLAYERSOLID );
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
ARGP4
ADDRLP4 60
ARGP4
ADDRLP4 80
ARGP4
ADDRLP4 92
ARGP4
CNSTI4 0
ARGI4
CNSTI4 33619969
ARGI4
ADDRGP4 trap_CM_BoxTrace
CALLV
pop
line 2556
;2554:
;2555:	// no shadow if too high
;2556:	if ( trace.fraction == 1.0 || trace.startsolid || trace.allsolid ) {
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
EQF4 $1193
ADDRLP4 0+4
INDIRI4
CNSTI4 0
NEI4 $1193
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1188
LABELV $1193
line 2557
;2557:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1173
JUMPV
LABELV $1188
line 2560
;2558:	}
;2559:
;2560:	*shadowPlane = trace.endpos[2] + 1;
ADDRFP4 4
INDIRP4
ADDRLP4 0+12+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2562
;2561:
;2562:	if ( cg_shadows.integer != 1 ) {	// no mark for stencil or projection shadows
ADDRGP4 cg_shadows+12
INDIRI4
CNSTI4 1
EQI4 $1196
line 2563
;2563:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1173
JUMPV
LABELV $1196
line 2567
;2564:	}
;2565:
;2566:	// fade the shadow out with height
;2567:	alpha = 1.0 - trace.fraction;
ADDRLP4 56
CNSTF4 1065353216
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 2579
;2568:
;2569:	// bk0101022 - hack / FPE - bogus planes?
;2570:	//assert( DotProduct( trace.plane.normal, trace.plane.normal ) != 0.0f ) 
;2571:
;2572:	// add the mark as a temporary, so it goes directly to the renderer
;2573:	// without taking a spot in the cg_marks array
;2574:	// JUHOX: adapt shadow radius to guard monsters
;2575:#if !MONSTER_MODE
;2576:	CG_ImpactMark( cgs.media.shadowMarkShader, trace.endpos, trace.plane.normal, 
;2577:		cent->pe.legs.yawAngle, alpha,alpha,alpha,1, qfalse, 24, qtrue );
;2578:#else
;2579:	CG_ImpactMark(
ADDRGP4 cgs+751220+552
INDIRI4
ARGI4
ADDRLP4 0+12
ARGP4
ADDRLP4 0+24
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 472
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 76
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 CG_ImpactMark
CALLV
pop
line 2585
;2580:		cgs.media.shadowMarkShader, trace.endpos, trace.plane.normal,
;2581:		cent->pe.legs.yawAngle, alpha,alpha,alpha, 1, qfalse, radius, qtrue
;2582:	);
;2583:#endif
;2584:
;2585:	return qtrue;
CNSTI4 1
RETI4
LABELV $1173
endproc CG_PlayerShadow 112 44
proc CG_PlayerSplash 204 28
line 2596
;2586:}
;2587:
;2588:
;2589:/*
;2590:===============
;2591:CG_PlayerSplash
;2592:
;2593:Draw a mark at the water surface
;2594:===============
;2595:*/
;2596:static void CG_PlayerSplash( centity_t *cent ) {
line 2608
;2597:	vec3_t		start, end;
;2598:	trace_t		trace;
;2599:	int			contents;
;2600:	polyVert_t	verts[4];
;2601:	// JUHOX: vars needed to adapt player splash to guard monsters;
;2602:#if MONSTER_MODE
;2603:	float top_size;
;2604:	float bottom_size;
;2605:	float width;
;2606:#endif
;2607:
;2608:	if ( !cg_shadows.integer ) {
ADDRGP4 cg_shadows+12
INDIRI4
CNSTI4 0
NEI4 $1205
line 2609
;2609:		return;
ADDRGP4 $1204
JUMPV
LABELV $1205
line 2614
;2610:	}
;2611:
;2612:	// JUHOX: compute vars needed to adapt player splash to guard monsters
;2613:#if MONSTER_MODE
;2614:	top_size = 32;
ADDRLP4 184
CNSTF4 1107296256
ASGNF4
line 2615
;2615:	bottom_size = 24;
ADDRLP4 188
CNSTF4 1103101952
ASGNF4
line 2616
;2616:	width = 32;
ADDRLP4 96
CNSTF4 1107296256
ASGNF4
line 2617
;2617:	switch (cent->currentState.clientNum) {
ADDRLP4 192
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
ADDRLP4 192
INDIRI4
CNSTI4 65
EQI4 $1211
ADDRGP4 $1208
JUMPV
LABELV $1211
line 2619
;2618:	case CLIENTNUM_MONSTER_GUARD:
;2619:		top_size *= MONSTER_GUARD_SCALE;
ADDRLP4 184
ADDRLP4 184
INDIRF4
CNSTF4 1073741824
MULF4
ASGNF4
line 2620
;2620:		bottom_size *= MONSTER_GUARD_SCALE;
ADDRLP4 188
ADDRLP4 188
INDIRF4
CNSTF4 1073741824
MULF4
ASGNF4
line 2621
;2621:		width *= MONSTER_GUARD_SCALE;
ADDRLP4 96
ADDRLP4 96
INDIRF4
CNSTF4 1073741824
MULF4
ASGNF4
line 2622
;2622:		break;
LABELV $1208
LABELV $1209
line 2626
;2623:	}
;2624:#endif
;2625:
;2626:	VectorCopy( cent->lerpOrigin, end );
ADDRLP4 168
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
INDIRB
ASGNB 12
line 2631
;2627:	// JUHOX: adapt player bottom size of guard monsters for player splash
;2628:#if !MONSTER_MODE
;2629:	end[2] -= 24;
;2630:#else
;2631:	end[2] -= bottom_size;
ADDRLP4 168+8
ADDRLP4 168+8
INDIRF4
ADDRLP4 188
INDIRF4
SUBF4
ASGNF4
line 2636
;2632:#endif
;2633:
;2634:	// if the feet aren't in liquid, don't make a mark
;2635:	// this won't handle moving water brushes, but they wouldn't draw right anyway...
;2636:	contents = trap_CM_PointContents( end, 0 );
ADDRLP4 168
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 196
ADDRGP4 trap_CM_PointContents
CALLI4
ASGNI4
ADDRLP4 180
ADDRLP4 196
INDIRI4
ASGNI4
line 2637
;2637:	if ( !( contents & ( CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA ) ) ) {
ADDRLP4 180
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
NEI4 $1213
line 2638
;2638:		return;
ADDRGP4 $1204
JUMPV
LABELV $1213
line 2641
;2639:	}
;2640:
;2641:	VectorCopy( cent->lerpOrigin, start );
ADDRLP4 156
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
INDIRB
ASGNB 12
line 2646
;2642:	// JUHOX: adapt player top size of guard monsters for player splash
;2643:#if !MONSTER_MODE
;2644:	start[2] += 32;
;2645:#else
;2646:	start[2] += top_size;
ADDRLP4 156+8
ADDRLP4 156+8
INDIRF4
ADDRLP4 184
INDIRF4
ADDF4
ASGNF4
line 2650
;2647:#endif
;2648:
;2649:	// if the head isn't out of liquid, don't make a mark
;2650:	contents = trap_CM_PointContents( start, 0 );
ADDRLP4 156
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 200
ADDRGP4 trap_CM_PointContents
CALLI4
ASGNI4
ADDRLP4 180
ADDRLP4 200
INDIRI4
ASGNI4
line 2651
;2651:	if ( contents & ( CONTENTS_SOLID | CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA ) ) {
ADDRLP4 180
INDIRI4
CNSTI4 57
BANDI4
CNSTI4 0
EQI4 $1216
line 2652
;2652:		return;
ADDRGP4 $1204
JUMPV
LABELV $1216
line 2656
;2653:	}
;2654:
;2655:	// trace down to find the surface
;2656:	trap_CM_BoxTrace( &trace, start, end, NULL, NULL, 0, ( CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA ) );
ADDRLP4 100
ARGP4
ADDRLP4 156
ARGP4
ADDRLP4 168
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 56
ARGI4
ADDRGP4 trap_CM_BoxTrace
CALLV
pop
line 2658
;2657:
;2658:	if ( trace.fraction == 1.0 ) {
ADDRLP4 100+8
INDIRF4
CNSTF4 1065353216
NEF4 $1218
line 2659
;2659:		return;
ADDRGP4 $1204
JUMPV
LABELV $1218
line 2663
;2660:	}
;2661:
;2662:	// create a mark polygon
;2663:	VectorCopy( trace.endpos, verts[0].xyz );
ADDRLP4 0
ADDRLP4 100+12
INDIRB
ASGNB 12
line 2669
;2664:	// JUHOX: adapt player width of guard monsters for player splash
;2665:#if !MONSTER_MODE
;2666:	verts[0].xyz[0] -= 32;
;2667:	verts[0].xyz[1] -= 32;
;2668:#else
;2669:	verts[0].xyz[0] -= width;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 96
INDIRF4
SUBF4
ASGNF4
line 2670
;2670:	verts[0].xyz[1] -= width;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 96
INDIRF4
SUBF4
ASGNF4
line 2672
;2671:#endif
;2672:	verts[0].st[0] = 0;
ADDRLP4 0+12
CNSTF4 0
ASGNF4
line 2673
;2673:	verts[0].st[1] = 0;
ADDRLP4 0+12+4
CNSTF4 0
ASGNF4
line 2674
;2674:	verts[0].modulate[0] = 255;
ADDRLP4 0+20
CNSTU1 255
ASGNU1
line 2675
;2675:	verts[0].modulate[1] = 255;
ADDRLP4 0+20+1
CNSTU1 255
ASGNU1
line 2676
;2676:	verts[0].modulate[2] = 255;
ADDRLP4 0+20+2
CNSTU1 255
ASGNU1
line 2677
;2677:	verts[0].modulate[3] = 255;
ADDRLP4 0+20+3
CNSTU1 255
ASGNU1
line 2679
;2678:
;2679:	VectorCopy( trace.endpos, verts[1].xyz );
ADDRLP4 0+24
ADDRLP4 100+12
INDIRB
ASGNB 12
line 2685
;2680:	// JUHOX: adapt player width of guard monsters for player splash
;2681:#if !MONSTER_MODE
;2682:	verts[1].xyz[0] -= 32;
;2683:	verts[1].xyz[1] += 32;
;2684:#else
;2685:	verts[1].xyz[0] -= width;
ADDRLP4 0+24
ADDRLP4 0+24
INDIRF4
ADDRLP4 96
INDIRF4
SUBF4
ASGNF4
line 2686
;2686:	verts[1].xyz[1] += width;
ADDRLP4 0+24+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 96
INDIRF4
ADDF4
ASGNF4
line 2688
;2687:#endif
;2688:	verts[1].st[0] = 0;
ADDRLP4 0+24+12
CNSTF4 0
ASGNF4
line 2689
;2689:	verts[1].st[1] = 1;
ADDRLP4 0+24+12+4
CNSTF4 1065353216
ASGNF4
line 2690
;2690:	verts[1].modulate[0] = 255;
ADDRLP4 0+24+20
CNSTU1 255
ASGNU1
line 2691
;2691:	verts[1].modulate[1] = 255;
ADDRLP4 0+24+20+1
CNSTU1 255
ASGNU1
line 2692
;2692:	verts[1].modulate[2] = 255;
ADDRLP4 0+24+20+2
CNSTU1 255
ASGNU1
line 2693
;2693:	verts[1].modulate[3] = 255;
ADDRLP4 0+24+20+3
CNSTU1 255
ASGNU1
line 2695
;2694:
;2695:	VectorCopy( trace.endpos, verts[2].xyz );
ADDRLP4 0+48
ADDRLP4 100+12
INDIRB
ASGNB 12
line 2701
;2696:	// JUHOX: adapt player width of guard monsters for player splash
;2697:#if !MONSTER_MODE
;2698:	verts[2].xyz[0] += 32;
;2699:	verts[2].xyz[1] += 32;
;2700:#else
;2701:	verts[2].xyz[0] += width;
ADDRLP4 0+48
ADDRLP4 0+48
INDIRF4
ADDRLP4 96
INDIRF4
ADDF4
ASGNF4
line 2702
;2702:	verts[2].xyz[1] += width;
ADDRLP4 0+48+4
ADDRLP4 0+48+4
INDIRF4
ADDRLP4 96
INDIRF4
ADDF4
ASGNF4
line 2704
;2703:#endif
;2704:	verts[2].st[0] = 1;
ADDRLP4 0+48+12
CNSTF4 1065353216
ASGNF4
line 2705
;2705:	verts[2].st[1] = 1;
ADDRLP4 0+48+12+4
CNSTF4 1065353216
ASGNF4
line 2706
;2706:	verts[2].modulate[0] = 255;
ADDRLP4 0+48+20
CNSTU1 255
ASGNU1
line 2707
;2707:	verts[2].modulate[1] = 255;
ADDRLP4 0+48+20+1
CNSTU1 255
ASGNU1
line 2708
;2708:	verts[2].modulate[2] = 255;
ADDRLP4 0+48+20+2
CNSTU1 255
ASGNU1
line 2709
;2709:	verts[2].modulate[3] = 255;
ADDRLP4 0+48+20+3
CNSTU1 255
ASGNU1
line 2711
;2710:
;2711:	VectorCopy( trace.endpos, verts[3].xyz );
ADDRLP4 0+72
ADDRLP4 100+12
INDIRB
ASGNB 12
line 2717
;2712:	// JUHOX: adapt player width of guard monsters for player splash
;2713:#if !MONSTER_MODE
;2714:	verts[3].xyz[0] += 32;
;2715:	verts[3].xyz[1] -= 32;
;2716:#else
;2717:	verts[3].xyz[0] += width;
ADDRLP4 0+72
ADDRLP4 0+72
INDIRF4
ADDRLP4 96
INDIRF4
ADDF4
ASGNF4
line 2718
;2718:	verts[3].xyz[1] -= width;
ADDRLP4 0+72+4
ADDRLP4 0+72+4
INDIRF4
ADDRLP4 96
INDIRF4
SUBF4
ASGNF4
line 2720
;2719:#endif
;2720:	verts[3].st[0] = 1;
ADDRLP4 0+72+12
CNSTF4 1065353216
ASGNF4
line 2721
;2721:	verts[3].st[1] = 0;
ADDRLP4 0+72+12+4
CNSTF4 0
ASGNF4
line 2722
;2722:	verts[3].modulate[0] = 255;
ADDRLP4 0+72+20
CNSTU1 255
ASGNU1
line 2723
;2723:	verts[3].modulate[1] = 255;
ADDRLP4 0+72+20+1
CNSTU1 255
ASGNU1
line 2724
;2724:	verts[3].modulate[2] = 255;
ADDRLP4 0+72+20+2
CNSTU1 255
ASGNU1
line 2725
;2725:	verts[3].modulate[3] = 255;
ADDRLP4 0+72+20+3
CNSTU1 255
ASGNU1
line 2727
;2726:
;2727:	trap_R_AddPolyToScene( cgs.media.wakeMarkShader, 4, verts );
ADDRGP4 cgs+751220+576
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddPolyToScene
CALLV
pop
line 2728
;2728:}
LABELV $1204
endproc CG_PlayerSplash 204 28
export CG_GetSpawnEffectParameters
proc CG_GetSpawnEffectParameters 52 4
line 2740
;2729:
;2730:
;2731:/*
;2732:===============
;2733:JUHOX: CG_GetSpawnEffectParameters
;2734:===============
;2735:*/
;2736:qboolean CG_GetSpawnEffectParameters(
;2737:	entityState_t* state,
;2738:	float* intensity, qboolean* skipOthers, int* powerups,
;2739:	refEntity_t* refEnt
;2740:) {
line 2748
;2741:	int startTime;
;2742:	int effectTime;
;2743:	float effectDuration;
;2744:	qboolean dummy1;
;2745:	int dummy2;
;2746:	playerEffect_t effect;
;2747:
;2748:	if (!state->time) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1299
CNSTI4 0
RETI4
ADDRGP4 $1298
JUMPV
LABELV $1299
line 2749
;2749:	if (cg.time >= state->time) return qfalse;
ADDRGP4 cg+107656
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
LTI4 $1301
CNSTI4 0
RETI4
ADDRGP4 $1298
JUMPV
LABELV $1301
line 2750
;2750:	effect = state->frame;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
ASGNI4
line 2751
;2751:	switch (effect) {
ADDRLP4 24
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
LTI4 $1304
ADDRLP4 24
INDIRI4
CNSTI4 4
GTI4 $1304
ADDRLP4 24
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1308
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1308
address $1305
address $1305
address $1305
address $1305
address $1305
code
line 2757
;2752:	case PE_spawn:
;2753:	case PE_fade_in:
;2754:	case PE_fade_out:
;2755:	case PE_hibernation:
;2756:	case PE_titan_awaking:
;2757:		break;
LABELV $1304
line 2759
;2758:	default:
;2759:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1298
JUMPV
LABELV $1305
line 2762
;2760:	}
;2761:
;2762:	if (!skipOthers) skipOthers = &dummy1;
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1309
ADDRFP4 8
ADDRLP4 16
ASGNP4
LABELV $1309
line 2763
;2763:	if (!powerups) powerups = &dummy2;
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1311
ADDRFP4 12
ADDRLP4 20
ASGNP4
LABELV $1311
line 2765
;2764:
;2765:	startTime = state->time - SPAWNHULL_TIME;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 1000
SUBI4
ASGNI4
line 2766
;2766:	effectTime = cg.time - startTime;
ADDRLP4 0
ADDRGP4 cg+107656
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ASGNI4
line 2767
;2767:	if (effectTime < 0) effectTime = 0;
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $1314
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1314
line 2769
;2768:
;2769:	if (effectTime <= SPAWNHULL_FADEIN_TIME) {
ADDRLP4 0
INDIRI4
CNSTI4 500
GTI4 $1316
line 2770
;2770:		effectDuration = SPAWNHULL_FADEIN_TIME;
ADDRLP4 12
CNSTF4 1140457472
ASGNF4
line 2771
;2771:		switch (effect) {
ADDRLP4 32
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
LTI4 $1317
ADDRLP4 32
INDIRI4
CNSTI4 4
GTI4 $1317
ADDRLP4 32
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1328
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1328
address $1321
address $1322
address $1323
address $1323
address $1324
code
LABELV $1321
line 2773
;2772:		case PE_spawn:
;2773:			*skipOthers = qtrue;
ADDRFP4 8
INDIRP4
CNSTI4 1
ASGNI4
line 2774
;2774:			break;
ADDRGP4 $1317
JUMPV
LABELV $1322
line 2776
;2775:		case PE_fade_in:
;2776:			*skipOthers = qfalse;
ADDRFP4 8
INDIRP4
CNSTI4 0
ASGNI4
line 2777
;2777:			*powerups |= 1 << PW_INVIS;
ADDRLP4 40
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 2778
;2778:			break;
ADDRGP4 $1317
JUMPV
LABELV $1323
line 2781
;2779:		case PE_fade_out:
;2780:		case PE_hibernation:
;2781:			*skipOthers = qfalse;
ADDRFP4 8
INDIRP4
CNSTI4 0
ASGNI4
line 2782
;2782:			*powerups &= ~(1 << PW_INVIS);
ADDRLP4 44
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 -17
BANDI4
ASGNI4
line 2783
;2783:			break;
ADDRGP4 $1317
JUMPV
LABELV $1324
line 2785
;2784:		case PE_titan_awaking:
;2785:			if (refEnt) {
ADDRFP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1325
line 2786
;2786:				refEnt->customShader = trap_R_RegisterShader("stone");
ADDRGP4 $1327
ARGP4
ADDRLP4 48
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRFP4 16
INDIRP4
CNSTI4 112
ADDP4
ADDRLP4 48
INDIRI4
ASGNI4
line 2787
;2787:				trap_R_AddRefEntityToScene(refEnt);
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2788
;2788:				refEnt->customShader = 0;
ADDRFP4 16
INDIRP4
CNSTI4 112
ADDP4
CNSTI4 0
ASGNI4
line 2789
;2789:			}
LABELV $1325
line 2790
;2790:			*skipOthers = qtrue;
ADDRFP4 8
INDIRP4
CNSTI4 1
ASGNI4
line 2791
;2791:			break;
line 2793
;2792:		}
;2793:	}
ADDRGP4 $1317
JUMPV
LABELV $1316
line 2794
;2794:	else {
line 2795
;2795:		effectTime = SPAWNHULL_TIME - effectTime;
ADDRLP4 0
CNSTI4 1000
ADDRLP4 0
INDIRI4
SUBI4
ASGNI4
line 2796
;2796:		effectDuration = SPAWNHULL_FADEOUT_TIME;
ADDRLP4 12
CNSTF4 1140457472
ASGNF4
line 2797
;2797:		*skipOthers = qfalse;
ADDRFP4 8
INDIRP4
CNSTI4 0
ASGNI4
line 2798
;2798:		switch (effect) {
ADDRLP4 32
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
LTI4 $1329
ADDRLP4 32
INDIRI4
CNSTI4 4
GTI4 $1329
ADDRLP4 32
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1337
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1337
address $1330
address $1333
address $1334
address $1335
address $1330
code
line 2800
;2799:		case PE_spawn:
;2800:			break;
LABELV $1333
line 2802
;2801:		case PE_fade_in:
;2802:			*powerups &= ~(1 << PW_INVIS);
ADDRLP4 40
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 -17
BANDI4
ASGNI4
line 2803
;2803:			break;
ADDRGP4 $1330
JUMPV
LABELV $1334
line 2805
;2804:		case PE_fade_out:
;2805:			*powerups |= 1 << PW_INVIS;
ADDRLP4 44
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 2806
;2806:			break;
ADDRGP4 $1330
JUMPV
LABELV $1335
line 2808
;2807:		case PE_hibernation:
;2808:			*skipOthers = qtrue;
ADDRFP4 8
INDIRP4
CNSTI4 1
ASGNI4
line 2809
;2809:			break;
line 2811
;2810:		case PE_titan_awaking:
;2811:			break;
LABELV $1329
LABELV $1330
line 2813
;2812:		}
;2813:	}
LABELV $1317
line 2814
;2814:	*intensity = (float)effectTime / effectDuration;
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRI4
CVIF4 4
ADDRLP4 12
INDIRF4
DIVF4
ASGNF4
line 2815
;2815:	return qtrue;
CNSTI4 1
RETI4
LABELV $1298
endproc CG_GetSpawnEffectParameters 52 4
export CG_AddRefEntityWithPowerups
proc CG_AddRefEntityWithPowerups 36 20
line 2826
;2816:}
;2817:
;2818:/*
;2819:===============
;2820:CG_AddRefEntityWithPowerups
;2821:
;2822:Adds a piece with modifications or duplications for powerups
;2823:Also called by CG_Missile for quad rockets, but nobody can tell...
;2824:===============
;2825:*/
;2826:void CG_AddRefEntityWithPowerups( refEntity_t *ent, entityState_t *state, int team ) {
line 2831
;2827:	int powerups;	// JUHOX
;2828:
;2829:	// JUHOX: set corrected lighting origin for EFH
;2830:#if ESCAPE_MODE
;2831:	if (cgs.gametype == GT_EFH) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 9
NEI4 $1339
line 2832
;2832:		ent->renderfx |= RF_LIGHTING_ORIGIN;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 2833
;2833:		VectorCopy(state->origin, ent->lightingOrigin);
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 2834
;2834:	}
LABELV $1339
line 2839
;2835:#endif
;2836:
;2837:	// JUHOX: draw spawn hull
;2838:#if 1
;2839:	powerups = state->powerups;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ASGNI4
line 2841
;2840:
;2841:	{
line 2845
;2842:		float intensity;
;2843:		qboolean skipOthers;
;2844:
;2845:		if (CG_GetSpawnEffectParameters(state, &intensity, &skipOthers, &powerups, ent)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 CG_GetSpawnEffectParameters
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $1342
line 2846
;2846:			ent->customShader = cgs.media.spawnHullShader;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+751220+288
INDIRI4
ASGNI4
line 2847
;2847:			ent->shaderRGBA[3] = 255 * intensity;
ADDRLP4 20
ADDRLP4 4
INDIRF4
CNSTF4 1132396544
MULF4
ASGNF4
ADDRLP4 24
CNSTF4 1325400064
ASGNF4
ADDRLP4 20
INDIRF4
ADDRLP4 24
INDIRF4
LTF4 $1347
ADDRLP4 16
ADDRLP4 20
INDIRF4
ADDRLP4 24
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1348
JUMPV
LABELV $1347
ADDRLP4 16
ADDRLP4 20
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1348
ADDRFP4 0
INDIRP4
CNSTI4 119
ADDP4
ADDRLP4 16
INDIRU4
CVUU1 4
ASGNU1
line 2848
;2848:			trap_R_AddRefEntityToScene(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2850
;2849:
;2850:			if (ent->shaderRGBA[3] > 128) {
ADDRFP4 0
INDIRP4
CNSTI4 119
ADDP4
INDIRU1
CVUI4 1
CNSTI4 128
LEI4 $1349
line 2851
;2851:				ent->shaderRGBA[3] -= 128;
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 119
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRU1
CVUI4 1
CNSTI4 128
SUBI4
CVIU4 4
CVUU1 4
ASGNU1
line 2852
;2852:				ent->shaderRGBA[3] >>= 3;
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 119
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRU1
CVUI4 1
CNSTI4 3
RSHI4
CVIU4 4
CVUU1 4
ASGNU1
line 2853
;2853:				ent->customShader = cgs.media.spawnHullGlow1Shader;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+751220+292
INDIRI4
ASGNI4
line 2854
;2854:				trap_R_AddRefEntityToScene(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2856
;2855:
;2856:				ent->customShader = cgs.media.spawnHullGlow2Shader;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+751220+296
INDIRI4
ASGNI4
line 2857
;2857:				trap_R_AddRefEntityToScene(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2859
;2858:
;2859:				ent->customShader = cgs.media.spawnHullGlow3Shader;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+751220+300
INDIRI4
ASGNI4
line 2860
;2860:				trap_R_AddRefEntityToScene(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2862
;2861:
;2862:				ent->customShader = cgs.media.spawnHullGlow4Shader;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+751220+304
INDIRI4
ASGNI4
line 2863
;2863:				trap_R_AddRefEntityToScene(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2864
;2864:			}
LABELV $1349
line 2866
;2865:
;2866:			if (skipOthers) return;
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $1359
ADDRGP4 $1338
JUMPV
LABELV $1359
line 2868
;2867:
;2868:			ent->customShader = 0;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
CNSTI4 0
ASGNI4
line 2869
;2869:		}
LABELV $1342
line 2870
;2870:	}
line 2876
;2871:#endif
;2872:
;2873:	// JUHOX: draw monster glow
;2874:#if MONSTER_MODE
;2875:	if (
;2876:		cg.viewMode == VIEW_scanner &&
ADDRGP4 cg+107628
INDIRI4
CNSTI4 1
NEI4 $1361
ADDRGP4 cg+107636
INDIRI4
CNSTI4 0
EQI4 $1361
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1361
ADDRLP4 4
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 64
LTI4 $1361
ADDRLP4 4
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 69
GEI4 $1361
ADDRLP4 4
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 66
NEI4 $1365
ADDRLP4 4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1361
LABELV $1365
line 2885
;2877:		cg.scannerActivationTime &&
;2878:		state->eType == ET_PLAYER &&
;2879:		state->clientNum >= CLIENTNUM_MONSTERS &&
;2880:		state->clientNum < MAX_CLIENTS + EXTRA_CLIENTNUMS &&
;2881:		(
;2882:			state->clientNum != CLIENTNUM_MONSTER_TITAN ||
;2883:			!state->otherEntityNum2	// qtrue if titan is sleeping
;2884:		)
;2885:	) {
line 2889
;2886:		centity_t* cent;
;2887:		int color;
;2888:
;2889:		cent = &cg_entities[state->number];
ADDRLP4 12
ADDRFP4 4
INDIRP4
INDIRI4
CNSTI4 880
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 2890
;2890:		color = 255;
ADDRLP4 8
CNSTI4 255
ASGNI4
line 2891
;2891:		if (cent->deathTime) {
ADDRLP4 12
INDIRP4
CNSTI4 756
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1366
line 2894
;2892:			#define SCANNER_DEATH_FADE_TIME 5000
;2893:
;2894:			if (cg.time < cent->deathTime + SCANNER_DEATH_FADE_TIME) {
ADDRGP4 cg+107656
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 756
ADDP4
INDIRI4
CNSTI4 5000
ADDI4
GEI4 $1368
line 2895
;2895:				color = 255 - (255 * (cg.time - cent->deathTime)) / SCANNER_DEATH_FADE_TIME;
ADDRLP4 8
CNSTI4 255
ADDRGP4 cg+107656
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 756
ADDP4
INDIRI4
SUBI4
CNSTI4 255
MULI4
CNSTI4 5000
DIVI4
SUBI4
ASGNI4
line 2896
;2896:				if (color < 0) color = 0;
ADDRLP4 8
INDIRI4
CNSTI4 0
GEI4 $1372
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $1372
line 2897
;2897:				if (color > 255) color = 255;
ADDRLP4 8
INDIRI4
CNSTI4 255
LEI4 $1369
ADDRLP4 8
CNSTI4 255
ASGNI4
line 2898
;2898:			}
ADDRGP4 $1369
JUMPV
LABELV $1368
line 2899
;2899:			else {
line 2900
;2900:				color = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2901
;2901:			}
LABELV $1369
line 2902
;2902:		}
LABELV $1366
line 2903
;2903:		if (cg.time < cg.scannerActivationTime + SCANNER_DEATH_FADE_TIME) {
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cg+107636
INDIRI4
CNSTI4 5000
ADDI4
GEI4 $1376
line 2904
;2904:			color = (color * (cg.time - cg.scannerActivationTime)) / SCANNER_DEATH_FADE_TIME;
ADDRLP4 8
ADDRLP4 8
INDIRI4
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cg+107636
INDIRI4
SUBI4
MULI4
CNSTI4 5000
DIVI4
ASGNI4
line 2905
;2905:		}
LABELV $1376
line 2906
;2906:		if (color > 0) {
ADDRLP4 8
INDIRI4
CNSTI4 0
LEI4 $1382
line 2907
;2907:			ent->customShader = trap_R_RegisterShader("monsterGlow");
ADDRGP4 $1384
ARGP4
ADDRLP4 16
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 2908
;2908:			ent->shaderRGBA[0] = color;
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
ADDRLP4 8
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 2909
;2909:			ent->shaderRGBA[1] = color;
ADDRFP4 0
INDIRP4
CNSTI4 117
ADDP4
ADDRLP4 8
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 2910
;2910:			ent->shaderRGBA[2] = color;
ADDRFP4 0
INDIRP4
CNSTI4 118
ADDP4
ADDRLP4 8
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 2911
;2911:			ent->shaderRGBA[3] = 255;
ADDRFP4 0
INDIRP4
CNSTI4 119
ADDP4
CNSTU1 255
ASGNU1
line 2912
;2912:			ent->shaderTime = state->number * 1.731;
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
ADDRFP4 4
INDIRP4
INDIRI4
CVIF4 4
CNSTF4 1071485288
MULF4
ASGNF4
line 2913
;2913:			trap_R_AddRefEntityToScene(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2914
;2914:			ent->customShader = 0;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
CNSTI4 0
ASGNI4
line 2915
;2915:		}
LABELV $1382
line 2916
;2916:	}
LABELV $1361
line 2923
;2917:#endif
;2918:
;2919:	// JUHOX: powerups may be redefined by CG_GetSpawnEffectParameters()
;2920:#if 0
;2921:	if ( state->powerups & ( 1 << PW_INVIS ) ) {
;2922:#else
;2923:	if (powerups & (1 << PW_INVIS)) {
ADDRLP4 0
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1385
line 2932
;2924:#endif
;2925:		// JUHOX: draw the marks even if the entity is invisible
;2926:#if 0
;2927:		ent->customShader = cgs.media.invisShader;
;2928:		trap_R_AddRefEntityToScene( ent );
;2929:#else
;2930:		qboolean drawInvisShader;
;2931:
;2932:		drawInvisShader = qtrue;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 2934
;2933:		if (
;2934:			cgs.gametype >= GT_TEAM &&
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $1387
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 8
GEI4 $1392
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
ADDRFP4 8
INDIRI4
NEI4 $1387
LABELV $1392
line 2941
;2935:			(
;2936:#if MONSTER_MODE
;2937:				cgs.gametype >= GT_STU ||
;2938:#endif
;2939:				cg.snap->ps.persistant[PERS_TEAM] == team
;2940:			)
;2941:		) {
line 2942
;2942:			if (team == TEAM_RED)
ADDRFP4 8
INDIRI4
CNSTI4 1
NEI4 $1393
line 2943
;2943:				ent->customShader = cgs.media.redInvis;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+751220+656
INDIRI4
ASGNI4
ADDRGP4 $1394
JUMPV
LABELV $1393
line 2945
;2944:			else
;2945:				ent->customShader = cgs.media.blueInvis;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+751220+652
INDIRI4
ASGNI4
LABELV $1394
line 2946
;2946:			trap_R_AddRefEntityToScene(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2947
;2947:			drawInvisShader = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2949
;2948:
;2949:			if (state->powerups & (1<<PW_REGEN)) {
ADDRFP4 4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $1399
line 2950
;2950:				if (((cg.time / 100) % 10) == 1) {
ADDRGP4 cg+107656
INDIRI4
CNSTI4 100
DIVI4
CNSTI4 10
MODI4
CNSTI4 1
NEI4 $1401
line 2951
;2951:					ent->customShader = cgs.media.regenShader;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+751220+620
INDIRI4
ASGNI4
line 2952
;2952:					trap_R_AddRefEntityToScene(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2953
;2953:				}
LABELV $1401
line 2954
;2954:			}
LABELV $1399
line 2955
;2955:		}
LABELV $1387
line 2956
;2956:		if (state->powerups & (1 << PW_CHARGE)) {
ADDRFP4 4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $1406
line 2957
;2957:			ent->customShader = cgs.media.chargeShader;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+751220+644
INDIRI4
ASGNI4
line 2958
;2958:			ent->shaderRGBA[3] = 64;
ADDRFP4 0
INDIRP4
CNSTI4 119
ADDP4
CNSTU1 64
ASGNU1
line 2959
;2959:			trap_R_AddRefEntityToScene(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2960
;2960:			drawInvisShader = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2961
;2961:		}
LABELV $1406
line 2962
;2962:		if (state->powerups & (1 << PW_BATTLESUIT)) {
ADDRFP4 4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $1410
line 2963
;2963:			ent->customShader = cgs.media.battleSuitShader;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+751220+624
INDIRI4
ASGNI4
line 2964
;2964:			trap_R_AddRefEntityToScene(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2965
;2965:			drawInvisShader = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2966
;2966:		}
LABELV $1410
line 2967
;2967:		if (state->powerups & (1 << PW_SHIELD)) {
ADDRFP4 4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $1414
line 2968
;2968:			ent->customShader = cgs.media.shieldShader;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+751220+668
INDIRI4
ASGNI4
line 2969
;2969:			trap_R_AddRefEntityToScene(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2970
;2970:			drawInvisShader = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2971
;2971:		}
LABELV $1414
line 2973
;2972:		// invisibility shader not needed if any marker drawn
;2973:		if (drawInvisShader || cg_glassCloaking.integer) {
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $1421
ADDRGP4 cg_glassCloaking+12
INDIRI4
CNSTI4 0
EQI4 $1386
LABELV $1421
line 2974
;2974:			if (cg_glassCloaking.integer) {
ADDRGP4 cg_glassCloaking+12
INDIRI4
CNSTI4 0
EQI4 $1422
line 2975
;2975:				ent->customShader = cgs.media.glassCloakingShader;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+751220+280
INDIRI4
ASGNI4
line 2976
;2976:				trap_R_AddRefEntityToScene(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 3000
;2977:
;2978:				/*
;2979:				if (drawInvisShader) {
;2980:					if (cg.clientNum == state->number) {
;2981:						ent->customShader = cgs.media.glassCloakingSpecShader;
;2982:						ent->shaderRGBA[3] = 255;
;2983:						trap_R_AddRefEntityToScene(ent);
;2984:					}
;2985:					else {
;2986:						float distance;
;2987:
;2988:						distance = Distance(cg.snap->ps.origin, state->pos.trBase);
;2989:						if (distance < GLASSCLOAKINGSPECSHADER_MAXDISTANCE) {
;2990:							ent->customShader = cgs.media.glassCloakingSpecShader;
;2991:							ent->shaderRGBA[3] =
;2992:								GLASSCLOAKINGSPECSHADER_MAXALPHA *
;2993:								(1.0 - distance / GLASSCLOAKINGSPECSHADER_MAXDISTANCE);
;2994:							trap_R_AddRefEntityToScene(ent);
;2995:						}
;2996:
;2997:					}
;2998:				}
;2999:				*/
;3000:			}
ADDRGP4 $1386
JUMPV
LABELV $1422
line 3001
;3001:			else {
line 3002
;3002:				ent->customShader = cgs.media.invisShader;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+751220+616
INDIRI4
ASGNI4
line 3003
;3003:				trap_R_AddRefEntityToScene(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 3004
;3004:			}
line 3005
;3005:		}
line 3007
;3006:#endif
;3007:	} else {
ADDRGP4 $1386
JUMPV
LABELV $1385
line 3009
;3008:#if MONSTER_MODE	// JUHOX: titan's stone skin
;3009:		if (state->clientNum == CLIENTNUM_MONSTER_TITAN && state->otherEntityNum2) {
ADDRLP4 8
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 66
NEI4 $1429
ADDRLP4 8
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1429
line 3010
;3010:			ent->customShader = trap_R_RegisterShader("stone");
ADDRGP4 $1327
ARGP4
ADDRLP4 12
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 3011
;3011:		}
LABELV $1429
line 3022
;3012:#endif
;3013:		/*
;3014:		if ( state->eFlags & EF_KAMIKAZE ) {
;3015:			if (team == TEAM_BLUE)
;3016:				ent->customShader = cgs.media.blueKamikazeShader;
;3017:			else
;3018:				ent->customShader = cgs.media.redKamikazeShader;
;3019:			trap_R_AddRefEntityToScene( ent );
;3020:		}
;3021:		else {*/
;3022:			trap_R_AddRefEntityToScene( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 3025
;3023:		//}
;3024:
;3025:		if ( state->powerups & ( 1 << PW_QUAD ) )
ADDRFP4 4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1431
line 3026
;3026:		{
line 3027
;3027:			if (team == TEAM_RED)
ADDRFP4 8
INDIRI4
CNSTI4 1
NEI4 $1433
line 3028
;3028:				ent->customShader = cgs.media.redQuadShader;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+751220+608
INDIRI4
ASGNI4
ADDRGP4 $1434
JUMPV
LABELV $1433
line 3030
;3029:			else
;3030:				ent->customShader = cgs.media.quadShader;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+751220+604
INDIRI4
ASGNI4
LABELV $1434
line 3031
;3031:			trap_R_AddRefEntityToScene( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 3032
;3032:		}
LABELV $1431
line 3033
;3033:		if ( state->powerups & ( 1 << PW_REGEN ) ) {
ADDRFP4 4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $1439
line 3034
;3034:			if ( ( ( cg.time / 100 ) % 10 ) == 1 ) {
ADDRGP4 cg+107656
INDIRI4
CNSTI4 100
DIVI4
CNSTI4 10
MODI4
CNSTI4 1
NEI4 $1441
line 3035
;3035:				ent->customShader = cgs.media.regenShader;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+751220+620
INDIRI4
ASGNI4
line 3036
;3036:				trap_R_AddRefEntityToScene( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 3037
;3037:			}
LABELV $1441
line 3038
;3038:		}
LABELV $1439
line 3039
;3039:		if ( state->powerups & ( 1 << PW_BATTLESUIT ) ) {
ADDRFP4 4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $1446
line 3040
;3040:			ent->customShader = cgs.media.battleSuitShader;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+751220+624
INDIRI4
ASGNI4
line 3041
;3041:			trap_R_AddRefEntityToScene( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 3042
;3042:		}
LABELV $1446
line 3045
;3043:		// JUHOX: draw the shield shader
;3044:#if 1
;3045:		if (state->powerups & (1 << PW_SHIELD)) {
ADDRFP4 4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $1450
line 3046
;3046:			ent->customShader = cgs.media.shieldShader;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+751220+668
INDIRI4
ASGNI4
line 3047
;3047:			trap_R_AddRefEntityToScene(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 3048
;3048:		}
LABELV $1450
line 3052
;3049:#endif
;3050:		// JUHOX: draw the charge shader
;3051:#if 1
;3052:		if (state->powerups & (1 << PW_CHARGE)) {
ADDRFP4 4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $1454
line 3053
;3053:			ent->customShader = cgs.media.chargeShader;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+751220+644
INDIRI4
ASGNI4
line 3054
;3054:			ent->shaderRGBA[3] = 128;
ADDRFP4 0
INDIRP4
CNSTI4 119
ADDP4
CNSTU1 128
ASGNU1
line 3055
;3055:			trap_R_AddRefEntityToScene(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 3056
;3056:		}
LABELV $1454
line 3058
;3057:#endif
;3058:	}
LABELV $1386
line 3062
;3059:	// JUHOX: users of the gauntlet get the target marked
;3060:#if 1
;3061:	if (
;3062:		cg.snap->ps.weapon == WP_GAUNTLET &&
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1458
ADDRGP4 cg+36
INDIRP4
CNSTI4 252
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
INDIRI4
NEI4 $1458
line 3064
;3063:		cg.snap->ps.stats[STAT_TARGET] == state->number
;3064:	) {
line 3065
;3065:		ent->customShader = cgs.media.targetMarker;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+751220+660
INDIRI4
ASGNI4
line 3066
;3066:		trap_R_AddRefEntityToScene(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 3067
;3067:	}
LABELV $1458
line 3069
;3068:#endif
;3069:}
LABELV $1338
endproc CG_AddRefEntityWithPowerups 36 20
export AddDischargeFlash
proc AddDischargeFlash 184 28
line 3100
;3070:
;3071:/*
;3072:===============
;3073:JUHOX: GetDischargeStartPoint
;3074:===============
;3075:*/
;3076:/*
;3077:static void GetDischargeStartPoint(const centity_t* cent, vec3_t pos, vec3_t dir) {
;3078:	vec3_t angles;
;3079:
;3080:	VectorCopy(cent->lerpOrigin, pos);
;3081:	pos[0] += 15 * crandom();
;3082:	pos[1] += 15 * crandom();
;3083:	pos[2] += 28 * crandom() + 4;
;3084:
;3085:	angles[0] = 360.0 * random();
;3086:	angles[1] = 360.0 * random();
;3087:	angles[2] = 360.0 * random();
;3088:	AngleVectors(angles, dir, NULL, NULL);
;3089:}
;3090:*/
;3091:
;3092:/*
;3093:===============
;3094:JUHOX: AddDischargeFlash
;3095:===============
;3096:*/
;3097:void AddDischargeFlash(
;3098:	const vec3_t origin, const vec3_t startAngles, dischargeFlash_t* flash, int entnum,
;3099:	const vec3_t mins, const vec3_t maxs, qhandle_t shader
;3100:) {
line 3109
;3101:	localseed_t seed;
;3102:	float f;
;3103:	int i;
;3104:	vec3_t startPoint;
;3105:	vec3_t endPoint;
;3106:	vec3_t angles;
;3107:	float totalLen;
;3108:
;3109:	if (cg.time >= flash->nextChangeTime) {
ADDRGP4 cg+107656
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
LTI4 $1465
line 3110
;3110:		flash->seed = lrand();
ADDRLP4 64
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRFP4 8
INDIRP4
ADDRLP4 64
INDIRU4
ASGNU4
line 3111
;3111:		flash->lastChangeTime = cg.time;
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 3112
;3112:		flash->nextChangeTime = cg.time + lrand() % DISCHARGE_MAX_DURATION;
ADDRLP4 68
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
ADDRGP4 cg+107656
INDIRI4
CVIU4 4
ADDRLP4 68
INDIRU4
CNSTU4 500
MODU4
ADDU4
CVUI4 4
ASGNI4
line 3113
;3113:	}
LABELV $1465
line 3115
;3114:
;3115:	seed.seed0 = flash->seed;
ADDRLP4 0
ADDRFP4 8
INDIRP4
INDIRU4
ASGNU4
line 3116
;3116:	seed.seed1 = entnum;
ADDRLP4 0+4
ADDRFP4 12
INDIRI4
CVIU4 4
ASGNU4
line 3117
;3117:	seed.seed2 = 0;
ADDRLP4 0+8
CNSTU4 0
ASGNU4
line 3118
;3118:	seed.seed3 = 0;
ADDRLP4 0+12
CNSTU4 0
ASGNU4
line 3120
;3119:
;3120:	f = (float)(cg.time - flash->lastChangeTime) / (float)DISCHARGE_MAX_DURATION;
ADDRLP4 28
ADDRGP4 cg+107656
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
SUBI4
CVIF4 4
CNSTF4 990057071
MULF4
ASGNF4
line 3122
;3121:
;3122:	VectorCopy(origin, startPoint);
ADDRLP4 16
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 3124
;3123:
;3124:	if (startAngles) {
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1474
line 3125
;3125:		VectorCopy(startAngles, angles);
ADDRLP4 44
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 3126
;3126:	}
ADDRGP4 $1475
JUMPV
LABELV $1474
line 3127
;3127:	else {
line 3128
;3128:		angles[0] = 360.0 * local_random(&seed);
ADDRLP4 0
ARGP4
ADDRLP4 64
ADDRGP4 local_random
CALLF4
ASGNF4
ADDRLP4 44
ADDRLP4 64
INDIRF4
CNSTF4 1135869952
MULF4
ASGNF4
line 3129
;3129:		angles[1] = 360.0 * local_random(&seed);
ADDRLP4 0
ARGP4
ADDRLP4 68
ADDRGP4 local_random
CALLF4
ASGNF4
ADDRLP4 44+4
ADDRLP4 68
INDIRF4
CNSTF4 1135869952
MULF4
ASGNF4
line 3131
;3130:
;3131:		startPoint[0] += mins[0] + (maxs[0] - mins[0]) * local_random(&seed);
ADDRLP4 0
ARGP4
ADDRLP4 72
ADDRGP4 local_random
CALLF4
ASGNF4
ADDRLP4 76
ADDRFP4 16
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 16
ADDRLP4 16
INDIRF4
ADDRLP4 76
INDIRF4
ADDRFP4 20
INDIRP4
INDIRF4
ADDRLP4 76
INDIRF4
SUBF4
ADDRLP4 72
INDIRF4
MULF4
ADDF4
ADDF4
ASGNF4
line 3132
;3132:		startPoint[1] += mins[1] + (maxs[1] - mins[1]) * local_random(&seed);
ADDRLP4 0
ARGP4
ADDRLP4 80
ADDRGP4 local_random
CALLF4
ASGNF4
ADDRLP4 84
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 16+4
ADDRLP4 16+4
INDIRF4
ADDRLP4 84
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRFP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 84
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ADDRLP4 80
INDIRF4
MULF4
ADDF4
ADDF4
ASGNF4
line 3133
;3133:		startPoint[2] += mins[2] + (maxs[2] - mins[2]) * local_random(&seed);
ADDRLP4 0
ARGP4
ADDRLP4 88
ADDRGP4 local_random
CALLF4
ASGNF4
ADDRLP4 92
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 16+8
ADDRLP4 16+8
INDIRF4
ADDRLP4 92
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 20
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 92
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ADDRLP4 88
INDIRF4
MULF4
ADDF4
ADDF4
ASGNF4
line 3134
;3134:	}
LABELV $1475
line 3136
;3135:
;3136:	totalLen = 0;
ADDRLP4 60
CNSTF4 0
ASGNF4
line 3137
;3137:	for (i = 0; i < 15; i++) {
ADDRLP4 56
CNSTI4 0
ASGNI4
LABELV $1479
line 3143
;3138:		float a;
;3139:		float b;
;3140:		vec3_t dir;
;3141:		trace_t trace;
;3142:
;3143:		a = DISCHARGE_MAX_ANGLE_DIFF * local_crandom(&seed);
ADDRLP4 0
ARGP4
ADDRLP4 140
ADDRGP4 local_crandom
CALLF4
ASGNF4
ADDRLP4 64
ADDRLP4 140
INDIRF4
CNSTF4 1109393408
MULF4
ASGNF4
line 3144
;3144:		b = DISCHARGE_MAX_ANGLE_DIFF * local_crandom(&seed);
ADDRLP4 0
ARGP4
ADDRLP4 144
ADDRGP4 local_crandom
CALLF4
ASGNF4
ADDRLP4 68
ADDRLP4 144
INDIRF4
CNSTF4 1109393408
MULF4
ASGNF4
line 3145
;3145:		angles[0] += a + (b - a) * f;
ADDRLP4 44
ADDRLP4 44
INDIRF4
ADDRLP4 64
INDIRF4
ADDRLP4 68
INDIRF4
ADDRLP4 64
INDIRF4
SUBF4
ADDRLP4 28
INDIRF4
MULF4
ADDF4
ADDF4
ASGNF4
line 3146
;3146:		a = DISCHARGE_MAX_ANGLE_DIFF * local_crandom(&seed);
ADDRLP4 0
ARGP4
ADDRLP4 152
ADDRGP4 local_crandom
CALLF4
ASGNF4
ADDRLP4 64
ADDRLP4 152
INDIRF4
CNSTF4 1109393408
MULF4
ASGNF4
line 3147
;3147:		b = DISCHARGE_MAX_ANGLE_DIFF * local_crandom(&seed);
ADDRLP4 0
ARGP4
ADDRLP4 156
ADDRGP4 local_crandom
CALLF4
ASGNF4
ADDRLP4 68
ADDRLP4 156
INDIRF4
CNSTF4 1109393408
MULF4
ASGNF4
line 3148
;3148:		angles[1] += a + (b - a) * f;
ADDRLP4 44+4
ADDRLP4 44+4
INDIRF4
ADDRLP4 64
INDIRF4
ADDRLP4 68
INDIRF4
ADDRLP4 64
INDIRF4
SUBF4
ADDRLP4 28
INDIRF4
MULF4
ADDF4
ADDF4
ASGNF4
line 3149
;3149:		AngleVectors(angles, dir, NULL, NULL);
ADDRLP4 44
ARGP4
ADDRLP4 72
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 3151
;3150:	
;3151:		a = DISCHARGE_MIN_LEN + DISCHARGE_MAX_ADD * local_random(&seed);
ADDRLP4 0
ARGP4
ADDRLP4 164
ADDRGP4 local_random
CALLF4
ASGNF4
ADDRLP4 64
ADDRLP4 164
INDIRF4
CNSTF4 1106247680
MULF4
CNSTF4 1097859072
ADDF4
ASGNF4
line 3152
;3152:		b = DISCHARGE_MIN_LEN + DISCHARGE_MAX_ADD * local_random(&seed);
ADDRLP4 0
ARGP4
ADDRLP4 168
ADDRGP4 local_random
CALLF4
ASGNF4
ADDRLP4 68
ADDRLP4 168
INDIRF4
CNSTF4 1106247680
MULF4
CNSTF4 1097859072
ADDF4
ASGNF4
line 3153
;3153:		VectorMA(startPoint, a + (b - a) * f, dir, endPoint);
ADDRLP4 176
ADDRLP4 64
INDIRF4
ADDRLP4 68
INDIRF4
ADDRLP4 64
INDIRF4
SUBF4
ADDRLP4 28
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 32
ADDRLP4 16
INDIRF4
ADDRLP4 72
INDIRF4
ADDRLP4 176
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 32+4
ADDRLP4 16+4
INDIRF4
ADDRLP4 72+4
INDIRF4
ADDRLP4 176
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 32+8
ADDRLP4 16+8
INDIRF4
ADDRLP4 72+8
INDIRF4
ADDRLP4 64
INDIRF4
ADDRLP4 68
INDIRF4
ADDRLP4 64
INDIRF4
SUBF4
ADDRLP4 28
INDIRF4
MULF4
ADDF4
MULF4
ADDF4
ASGNF4
line 3155
;3154:		
;3155:		if (cg_noTrace.integer) {
ADDRGP4 cg_noTrace+12
INDIRI4
CNSTI4 0
EQI4 $1490
line 3156
;3156:			CG_Draw3DLine(startPoint, endPoint, shader);
ADDRLP4 16
ARGP4
ADDRLP4 32
ARGP4
ADDRFP4 24
INDIRI4
ARGI4
ADDRGP4 CG_Draw3DLine
CALLV
pop
line 3157
;3157:		}
ADDRGP4 $1491
JUMPV
LABELV $1490
line 3158
;3158:		else {
line 3159
;3159:			CG_Trace(&trace, startPoint, NULL, NULL, endPoint, entnum, MASK_SHOT);
ADDRLP4 84
ARGP4
ADDRLP4 16
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 32
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 3160
;3160:			CG_Draw3DLine(startPoint, trace.endpos, shader);
ADDRLP4 16
ARGP4
ADDRLP4 84+12
ARGP4
ADDRFP4 24
INDIRI4
ARGI4
ADDRGP4 CG_Draw3DLine
CALLV
pop
line 3161
;3161:			if (trace.fraction < 1) return;
ADDRLP4 84+8
INDIRF4
CNSTF4 1065353216
GEF4 $1494
ADDRGP4 $1464
JUMPV
LABELV $1494
line 3162
;3162:		}
LABELV $1491
line 3164
;3163:
;3164:		VectorCopy(endPoint, startPoint);
ADDRLP4 16
ADDRLP4 32
INDIRB
ASGNB 12
line 3165
;3165:	}
LABELV $1480
line 3137
ADDRLP4 56
ADDRLP4 56
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 15
LTI4 $1479
line 3166
;3166:}
LABELV $1464
endproc AddDischargeFlash 184 28
proc CG_AddDischarges 52 28
line 3173
;3167:
;3168:/*
;3169:===============
;3170:JUHOX: CG_AddDischarges
;3171:===============
;3172:*/
;3173:static void CG_AddDischarges(centity_t* cent) {
line 3238
;3174:#if 0
;3175:	trace_t		trace;
;3176:	vec3_t		angles;
;3177:	vec3_t		dir;
;3178:	vec3_t		startPoint, endPoint;
;3179:	int i, n;
;3180:	qboolean multiFlashes;
;3181:	float charge;
;3182:
;3183:	GetDischargeStartPoint(cent, startPoint, dir);
;3184:
;3185:	if (cent->currentState.number == cg.snap->ps.clientNum) {
;3186:		charge = (cg.snap->ps.powerups[PW_CHARGE] - cg.time) / 1000.0;
;3187:	}
;3188:	else {
;3189:		charge = (cent->currentState.time2 - cg.time) / 1000.0;
;3190:	}
;3191:	if (charge <= 0) return;
;3192:	if (charge > 20) charge = 20;
;3193:	if (charge > 10) {
;3194:		n = charge;
;3195:		charge -= n;
;3196:		if (random() < charge) n++;
;3197:		multiFlashes = qtrue;
;3198:	}
;3199:	else {
;3200:		if (10 * random() > charge) return;
;3201:		n = 10;
;3202:		multiFlashes = qfalse;
;3203:	}
;3204:	for (i = 0; i < n; i++) {
;3205:		vec3_t angles;
;3206:
;3207:		vectoangles(dir, angles);
;3208:		angles[0] += 30.0 * crandom();
;3209:		angles[1] += 30.0 * crandom();
;3210:		//angles[2] += 30.0 * crandom();
;3211:		AngleVectors(angles, dir, NULL, NULL);
;3212:	
;3213:		VectorMA(startPoint, /*15 + 50*random()*/25.0, dir, endPoint);
;3214:	
;3215:		// see if it hit a wall
;3216:		CG_Trace(&trace, startPoint, vec3_origin, vec3_origin, endPoint, cent->currentState.number, MASK_SHOT);
;3217:	
;3218:		CG_Draw3DLine(startPoint, trace.endpos, cgs.media.dischargeFlashShader);
;3219:
;3220:		if (trace.fraction >= 1) {
;3221:			// continue the flash
;3222:			VectorCopy(trace.endpos, startPoint);
;3223:		}
;3224:		else {
;3225:			// begin a new flash
;3226:			if (!multiFlashes) return;
;3227:			GetDischargeStartPoint(cent, startPoint, dir);
;3228:		}
;3229:	}
;3230:#else
;3231:
;3232:	float charge;
;3233:	int i;
;3234:	int n;
;3235:	vec3_t mins;
;3236:	vec3_t maxs;
;3237:
;3238:	if (cent->currentState.number == cg.snap->ps.clientNum) {
ADDRFP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $1498
line 3239
;3239:		charge = (cg.snap->ps.powerups[PW_CHARGE] - cg.time) / 1000.0;
ADDRLP4 32
ADDRGP4 cg+36
INDIRP4
CNSTI4 396
ADDP4
INDIRI4
ADDRGP4 cg+107656
INDIRI4
SUBI4
CVIF4 4
CNSTF4 981668463
MULF4
ASGNF4
line 3240
;3240:	}
ADDRGP4 $1499
JUMPV
LABELV $1498
line 3241
;3241:	else {
line 3242
;3242:		charge = (cent->currentState.time2 - cg.time) / 1000.0;
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
ADDRGP4 cg+107656
INDIRI4
SUBI4
CVIF4 4
CNSTF4 981668463
MULF4
ASGNF4
line 3243
;3243:	}
LABELV $1499
line 3244
;3244:	if (charge <= 0) return;
ADDRLP4 32
INDIRF4
CNSTF4 0
GTF4 $1504
ADDRGP4 $1497
JUMPV
LABELV $1504
line 3246
;3245:
;3246:	charge *= 0.25;	
ADDRLP4 32
ADDRLP4 32
INDIRF4
CNSTF4 1048576000
MULF4
ASGNF4
line 3247
;3247:	n = charge;
ADDRLP4 4
ADDRLP4 32
INDIRF4
CVFI4 4
ASGNI4
line 3248
;3248:	charge -= n;
ADDRLP4 32
ADDRLP4 32
INDIRF4
ADDRLP4 4
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 3249
;3249:	if (random() < charge) n++;
ADDRLP4 36
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 36
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 36
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
ADDRLP4 32
INDIRF4
GEF4 $1506
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1506
line 3251
;3250:
;3251:	if (n > MAX_DISCHARGE_FLASHES_PER_ENTITY) {
ADDRLP4 4
INDIRI4
CNSTI4 8
LEI4 $1508
line 3252
;3252:		n = MAX_DISCHARGE_FLASHES_PER_ENTITY;
ADDRLP4 4
CNSTI4 8
ASGNI4
line 3253
;3253:	}
LABELV $1508
line 3255
;3254:
;3255:	switch (cent->currentState.clientNum) {
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 64
LTI4 $1510
ADDRLP4 40
INDIRI4
CNSTI4 68
GTI4 $1510
ADDRLP4 40
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1538-256
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1538
address $1513
address $1524
address $1529
address $1513
address $1513
code
LABELV $1513
line 3259
;3256:	case CLIENTNUM_MONSTER_PREDATOR:
;3257:	case CLIENTNUM_MONSTER_PREDATOR_RED:
;3258:	case CLIENTNUM_MONSTER_PREDATOR_BLUE:
;3259:		if (cent->currentState.modelindex & PFMI_HIBERNATION_MORPHED) {
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1514
line 3260
;3260:			VectorSet(mins, 0, 0, 0);
ADDRLP4 8
CNSTF4 0
ASGNF4
ADDRLP4 8+4
CNSTF4 0
ASGNF4
ADDRLP4 8+8
CNSTF4 0
ASGNF4
line 3261
;3261:			VectorSet(maxs, 0, 0, 0);
ADDRLP4 20
CNSTF4 0
ASGNF4
ADDRLP4 20+4
CNSTF4 0
ASGNF4
ADDRLP4 20+8
CNSTF4 0
ASGNF4
line 3262
;3262:		}
ADDRGP4 $1511
JUMPV
LABELV $1514
line 3263
;3263:		else {
line 3264
;3264:			VectorSet(mins, -15, -15, -24);
ADDRLP4 8
CNSTF4 3245342720
ASGNF4
ADDRLP4 8+4
CNSTF4 3245342720
ASGNF4
ADDRLP4 8+8
CNSTF4 3250585600
ASGNF4
line 3265
;3265:			VectorSet(maxs, +15, +15, +32);
ADDRLP4 20
CNSTF4 1097859072
ASGNF4
ADDRLP4 20+4
CNSTF4 1097859072
ASGNF4
ADDRLP4 20+8
CNSTF4 1107296256
ASGNF4
line 3266
;3266:		}
line 3267
;3267:		break;
ADDRGP4 $1511
JUMPV
LABELV $1524
line 3269
;3268:	case CLIENTNUM_MONSTER_GUARD:
;3269:		VectorSet(mins, -15*MONSTER_GUARD_SCALE, -15*MONSTER_GUARD_SCALE, -24*MONSTER_GUARD_SCALE);
ADDRLP4 8
CNSTF4 3253731328
ASGNF4
ADDRLP4 8+4
CNSTF4 3253731328
ASGNF4
ADDRLP4 8+8
CNSTF4 3258974208
ASGNF4
line 3270
;3270:		VectorSet(maxs, +15*MONSTER_GUARD_SCALE, +15*MONSTER_GUARD_SCALE, +32*MONSTER_GUARD_SCALE);
ADDRLP4 20
CNSTF4 1106247680
ASGNF4
ADDRLP4 20+4
CNSTF4 1106247680
ASGNF4
ADDRLP4 20+8
CNSTF4 1115684864
ASGNF4
line 3271
;3271:		break;
ADDRGP4 $1511
JUMPV
LABELV $1529
line 3273
;3272:	case CLIENTNUM_MONSTER_TITAN:
;3273:		VectorSet(mins, -15*MONSTER_TITAN_SCALE, -15*MONSTER_TITAN_SCALE, -24*MONSTER_TITAN_SCALE);
ADDRLP4 8
CNSTF4 3260153856
ASGNF4
ADDRLP4 8+4
CNSTF4 3260153856
ASGNF4
ADDRLP4 8+8
CNSTF4 3265789952
ASGNF4
line 3274
;3274:		VectorSet(maxs, +15*MONSTER_TITAN_SCALE, +15*MONSTER_TITAN_SCALE, +32*MONSTER_TITAN_SCALE);
ADDRLP4 20
CNSTF4 1112670208
ASGNF4
ADDRLP4 20+4
CNSTF4 1112670208
ASGNF4
ADDRLP4 20+8
CNSTF4 1121976320
ASGNF4
line 3275
;3275:		break;
ADDRGP4 $1511
JUMPV
LABELV $1510
line 3277
;3276:	default:
;3277:		VectorSet(mins, -15, -15, -24);
ADDRLP4 8
CNSTF4 3245342720
ASGNF4
ADDRLP4 8+4
CNSTF4 3245342720
ASGNF4
ADDRLP4 8+8
CNSTF4 3250585600
ASGNF4
line 3278
;3278:		VectorSet(maxs, +15, +15, +32);
ADDRLP4 20
CNSTF4 1097859072
ASGNF4
ADDRLP4 20+4
CNSTF4 1097859072
ASGNF4
ADDRLP4 20+8
CNSTF4 1107296256
ASGNF4
line 3279
;3279:		break;
LABELV $1511
line 3282
;3280:	}
;3281:
;3282:	for (i = 0; i < n; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1543
JUMPV
LABELV $1540
line 3283
;3283:		AddDischargeFlash(
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 728
ADDP4
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 48
INDIRP4
CNSTI4 760
ADDP4
ADDP4
ARGP4
ADDRLP4 48
INDIRP4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 cgs+751220+260
INDIRI4
ARGI4
ADDRGP4 AddDischargeFlash
CALLV
pop
line 3287
;3284:			cent->lerpOrigin, NULL, &cent->flashes[i], cent->currentState.number,
;3285:			mins, maxs, cgs.media.dischargeFlashShader
;3286:		);
;3287:	}
LABELV $1541
line 3282
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1543
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $1540
line 3290
;3288:
;3289:#endif
;3290:}
LABELV $1497
endproc CG_AddDischarges 52 28
export CG_LightVerts
proc CG_LightVerts 88 16
line 3298
;3291:
;3292:/*
;3293:=================
;3294:CG_LightVerts
;3295:=================
;3296:*/
;3297:int CG_LightVerts( vec3_t normal, int numVerts, polyVert_t *verts )
;3298:{
line 3305
;3299:	int				i, j;
;3300:	float			incoming;
;3301:	vec3_t			ambientLight;
;3302:	vec3_t			lightDir;
;3303:	vec3_t			directedLight;
;3304:
;3305:	trap_R_LightForPoint( verts[0].xyz, ambientLight, directedLight, lightDir );
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 24
ARGP4
ADDRGP4 trap_R_LightForPoint
CALLI4
pop
line 3307
;3306:
;3307:	for (i = 0; i < numVerts; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $1550
JUMPV
LABELV $1547
line 3308
;3308:		incoming = DotProduct (normal, lightDir);
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 48
INDIRP4
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ADDRLP4 48
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 24+4
INDIRF4
MULF4
ADDF4
ADDRLP4 48
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 24+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 3309
;3309:		if ( incoming <= 0 ) {
ADDRLP4 8
INDIRF4
CNSTF4 0
GTF4 $1553
line 3310
;3310:			verts[i].modulate[0] = ambientLight[0];
ADDRLP4 56
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 60
CNSTF4 1325400064
ASGNF4
ADDRLP4 56
INDIRF4
ADDRLP4 60
INDIRF4
LTF4 $1556
ADDRLP4 52
ADDRLP4 56
INDIRF4
ADDRLP4 60
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1557
JUMPV
LABELV $1556
ADDRLP4 52
ADDRLP4 56
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1557
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 20
ADDP4
ADDRLP4 52
INDIRU4
CVUU1 4
ASGNU1
line 3311
;3311:			verts[i].modulate[1] = ambientLight[1];
ADDRLP4 68
ADDRLP4 12+4
INDIRF4
ASGNF4
ADDRLP4 72
CNSTF4 1325400064
ASGNF4
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
LTF4 $1560
ADDRLP4 64
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1561
JUMPV
LABELV $1560
ADDRLP4 64
ADDRLP4 68
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1561
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 21
ADDP4
ADDRLP4 64
INDIRU4
CVUU1 4
ASGNU1
line 3312
;3312:			verts[i].modulate[2] = ambientLight[2];
ADDRLP4 80
ADDRLP4 12+8
INDIRF4
ASGNF4
ADDRLP4 84
CNSTF4 1325400064
ASGNF4
ADDRLP4 80
INDIRF4
ADDRLP4 84
INDIRF4
LTF4 $1564
ADDRLP4 76
ADDRLP4 80
INDIRF4
ADDRLP4 84
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1565
JUMPV
LABELV $1564
ADDRLP4 76
ADDRLP4 80
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1565
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 22
ADDP4
ADDRLP4 76
INDIRU4
CVUU1 4
ASGNU1
line 3313
;3313:			verts[i].modulate[3] = 255;
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 23
ADDP4
CNSTU1 255
ASGNU1
line 3314
;3314:			continue;
ADDRGP4 $1548
JUMPV
LABELV $1553
line 3316
;3315:		} 
;3316:		j = ( ambientLight[0] + incoming * directedLight[0] );
ADDRLP4 0
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 3317
;3317:		if ( j > 255 ) {
ADDRLP4 0
INDIRI4
CNSTI4 255
LEI4 $1566
line 3318
;3318:			j = 255;
ADDRLP4 0
CNSTI4 255
ASGNI4
line 3319
;3319:		}
LABELV $1566
line 3320
;3320:		verts[i].modulate[0] = j;
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 20
ADDP4
ADDRLP4 0
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 3322
;3321:
;3322:		j = ( ambientLight[1] + incoming * directedLight[1] );
ADDRLP4 0
ADDRLP4 12+4
INDIRF4
ADDRLP4 8
INDIRF4
ADDRLP4 36+4
INDIRF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 3323
;3323:		if ( j > 255 ) {
ADDRLP4 0
INDIRI4
CNSTI4 255
LEI4 $1570
line 3324
;3324:			j = 255;
ADDRLP4 0
CNSTI4 255
ASGNI4
line 3325
;3325:		}
LABELV $1570
line 3326
;3326:		verts[i].modulate[1] = j;
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 21
ADDP4
ADDRLP4 0
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 3328
;3327:
;3328:		j = ( ambientLight[2] + incoming * directedLight[2] );
ADDRLP4 0
ADDRLP4 12+8
INDIRF4
ADDRLP4 8
INDIRF4
ADDRLP4 36+8
INDIRF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 3329
;3329:		if ( j > 255 ) {
ADDRLP4 0
INDIRI4
CNSTI4 255
LEI4 $1574
line 3330
;3330:			j = 255;
ADDRLP4 0
CNSTI4 255
ASGNI4
line 3331
;3331:		}
LABELV $1574
line 3332
;3332:		verts[i].modulate[2] = j;
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 22
ADDP4
ADDRLP4 0
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 3334
;3333:
;3334:		verts[i].modulate[3] = 255;
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 23
ADDP4
CNSTU1 255
ASGNU1
line 3335
;3335:	}
LABELV $1548
line 3307
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1550
ADDRLP4 4
INDIRI4
ADDRFP4 4
INDIRI4
LTI4 $1547
line 3336
;3336:	return qtrue;
CNSTI4 1
RETI4
LABELV $1546
endproc CG_LightVerts 88 16
export CG_Player
proc CG_Player 608 28
line 3344
;3337:}
;3338:
;3339:/*
;3340:===============
;3341:CG_Player
;3342:===============
;3343:*/
;3344:void CG_Player( centity_t *cent ) {
line 3365
;3345:	clientInfo_t	*ci;
;3346:	refEntity_t		legs;
;3347:	refEntity_t		torso;
;3348:	refEntity_t		head;
;3349:	int				clientNum;
;3350:	int				renderfx;
;3351:	qboolean		shadow;
;3352:	float			shadowPlane;
;3353:#ifdef MISSIONPACK
;3354:	refEntity_t		skull;
;3355:	refEntity_t		powerup;
;3356:	int				t;
;3357:	float			c;
;3358:	float			angle;
;3359:	vec3_t			dir, angles;
;3360:#endif
;3361:
;3362:	// the client number is stored in clientNum.  It can't be derived
;3363:	// from the entity number, because a single client may have
;3364:	// multiple corpses on the level using the same clientinfo
;3365:	clientNum = cent->currentState.clientNum;
ADDRLP4 424
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 3370
;3366:	// JUHOX: accept EXTRA_CLIENTNUMS
;3367:#if !MONSTER_MODE
;3368:	if ( clientNum < 0 || clientNum >= MAX_CLIENTS ) {
;3369:#else
;3370:	if (clientNum < 0 || clientNum >= MAX_CLIENTS + EXTRA_CLIENTNUMS) {
ADDRLP4 424
INDIRI4
CNSTI4 0
LTI4 $1579
ADDRLP4 424
INDIRI4
CNSTI4 69
LTI4 $1577
LABELV $1579
line 3372
;3371:#endif
;3372:		CG_Error( "Bad clientNum on player entity");
ADDRGP4 $1580
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 3373
;3373:	}
LABELV $1577
line 3374
;3374:	ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 140
ADDRLP4 424
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320
ADDP4
ASGNP4
line 3379
;3375:
;3376:	//if (clientNum >= MAX_CLIENTS) CG_Printf("%d: type=%d\n", cent->currentState.number, clientNum);	// JUHOX DEBUG
;3377:	// it is possible to see corpses from disconnected players that may
;3378:	// not have valid clientinfo
;3379:	if ( !ci->infoValid ) {
ADDRLP4 140
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $1582
line 3380
;3380:		return;
ADDRGP4 $1576
JUMPV
LABELV $1582
line 3385
;3381:	}
;3382:
;3383:	// JUHOX: note death time
;3384:#if 1
;3385:	if (cent->currentState.eFlags & EF_DEAD) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1584
line 3386
;3386:		if (!cent->deathTime) {
ADDRFP4 0
INDIRP4
CNSTI4 756
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1585
line 3387
;3387:			cent->deathTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 756
ADDP4
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 3389
;3388:			// NOTE: above may be slightly wrong if the player died while not in this client's snapshot
;3389:		}
line 3390
;3390:	}
ADDRGP4 $1585
JUMPV
LABELV $1584
line 3391
;3391:	else {
line 3392
;3392:		cent->deathTime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 756
ADDP4
CNSTI4 0
ASGNI4
line 3393
;3393:	}
LABELV $1585
line 3398
;3394:#endif
;3395:
;3396:#if ESCAPE_MODE	// JUHOX: check if this player is in a visible segment
;3397:	if (
;3398:		cgs.gametype == GT_EFH &&
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 9
NEI4 $1589
ADDRLP4 424
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
EQI4 $1589
ADDRLP4 444
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 444
INDIRP4
CNSTI4 152
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
LTI4 $1595
ADDRLP4 444
INDIRP4
CNSTI4 152
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
LEI4 $1589
LABELV $1595
line 3404
;3399:		clientNum != cg.snap->ps.clientNum &&
;3400:		(
;3401:			cent->currentState.constantLight < cg.snap->ps.persistant[PERS_MIN_SEGMENT] ||
;3402:			cent->currentState.constantLight > cg.snap->ps.persistant[PERS_MAX_SEGMENT]
;3403:		)
;3404:	) {
line 3405
;3405:		return;
ADDRGP4 $1576
JUMPV
LABELV $1589
line 3412
;3406:	}
;3407:#endif
;3408:
;3409:	// JUHOX: extract tss player info
;3410:#if 1
;3411:	if (
;3412:		cgs.gametype >= GT_TEAM &&
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $1596
ADDRLP4 140
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
NEI4 $1596
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 448
ADDRGP4 BG_TSS_GetPlayerEntityInfo
CALLI4
ASGNI4
ADDRLP4 448
INDIRI4
CNSTI4 0
EQI4 $1596
line 3415
;3413:		ci->team == cg.snap->ps.persistant[PERS_TEAM] &&
;3414:		BG_TSS_GetPlayerEntityInfo(&cent->currentState, TSSPI_isValid)
;3415:	) {
line 3416
;3416:		ci->group = BG_TSS_GetPlayerEntityInfo(&cent->currentState, TSSPI_group);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 452
ADDRGP4 BG_TSS_GetPlayerEntityInfo
CALLI4
ASGNI4
ADDRLP4 140
INDIRP4
CNSTI4 72
ADDP4
ADDRLP4 452
INDIRI4
ASGNI4
line 3417
;3417:		ci->memberStatus = BG_TSS_GetPlayerEntityInfo(&cent->currentState, TSSPI_groupMemberStatus);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 456
ADDRGP4 BG_TSS_GetPlayerEntityInfo
CALLI4
ASGNI4
ADDRLP4 140
INDIRP4
CNSTI4 76
ADDP4
ADDRLP4 456
INDIRI4
ASGNI4
line 3418
;3418:	}
ADDRGP4 $1597
JUMPV
LABELV $1596
line 3419
;3419:	else {
line 3420
;3420:		ci->group = -1;
ADDRLP4 140
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 -1
ASGNI4
line 3421
;3421:		ci->memberStatus = -1;
ADDRLP4 140
INDIRP4
CNSTI4 76
ADDP4
CNSTI4 -1
ASGNI4
line 3422
;3422:	}
LABELV $1597
line 3427
;3423:#endif
;3424:
;3425:	// JUHOX: save the pfmi
;3426:#if 1
;3427:	ci->pfmi = cent->currentState.modelindex;
ADDRLP4 140
INDIRP4
CNSTI4 80
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ASGNI4
line 3430
;3428:#endif
;3429:
;3430:	if (cent->currentState.eFlags & EF_NODRAW) return;	// JUHOX: for dead spectators
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $1600
ADDRGP4 $1576
JUMPV
LABELV $1600
line 3433
;3431:
;3432:	// get the player model information
;3433:	renderfx = 0;
ADDRLP4 428
CNSTI4 0
ASGNI4
line 3434
;3434:	if ( cent->currentState.number == cg.snap->ps.clientNum) {
ADDRFP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $1602
line 3435
;3435:		if (!cg.renderingThirdPerson) {
ADDRGP4 cg+107680
INDIRI4
CNSTI4 0
NEI4 $1605
line 3436
;3436:			renderfx = RF_THIRD_PERSON;			// only draw in mirrors
ADDRLP4 428
CNSTI4 2
ASGNI4
line 3437
;3437:		} else {
ADDRGP4 $1606
JUMPV
LABELV $1605
line 3438
;3438:			if (cg_cameraMode.integer) {
ADDRGP4 cg_cameraMode+12
INDIRI4
CNSTI4 0
EQI4 $1608
line 3439
;3439:				return;
ADDRGP4 $1576
JUMPV
LABELV $1608
line 3441
;3440:			}
;3441:		}
LABELV $1606
line 3442
;3442:	}
LABELV $1602
line 3447
;3443:
;3444:	// JUHOX: add discharge beams to charged players
;3445:#if 1
;3446:	if (
;3447:		(cent->currentState.powerups & (1 << PW_CHARGE)) /*&&
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $1611
line 3449
;3448:		cent->dischargeTime < cg.time - 100*/
;3449:	) {
line 3450
;3450:		CG_AddDischarges(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_AddDischarges
CALLV
pop
line 3451
;3451:	}
LABELV $1611
line 3455
;3452:#endif
;3453:
;3454:
;3455:	memset( &legs, 0, sizeof(legs) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 3456
;3456:	memset( &torso, 0, sizeof(torso) );
ADDRLP4 144
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 3457
;3457:	memset( &head, 0, sizeof(head) );
ADDRLP4 284
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 3460
;3458:
;3459:	// get the rotation information
;3460:	CG_PlayerAngles( cent, legs.axis, torso.axis, head.axis );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+28
ARGP4
ADDRLP4 144+28
ARGP4
ADDRLP4 284+28
ARGP4
ADDRGP4 CG_PlayerAngles
CALLV
pop
line 3464
;3461:	
;3462:	// JUHOX: make monster guard (visually) bigger
;3463:#if MONSTER_MODE
;3464:	switch (clientNum) {
ADDRLP4 424
INDIRI4
CNSTI4 65
EQI4 $1618
ADDRLP4 424
INDIRI4
CNSTI4 66
EQI4 $1662
ADDRGP4 $1616
JUMPV
LABELV $1618
line 3466
;3465:	case CLIENTNUM_MONSTER_GUARD:
;3466:		VectorScale(legs.axis[0], MONSTER_GUARD_SCALE, legs.axis[0]);
ADDRLP4 0+28
ADDRLP4 0+28
INDIRF4
CNSTF4 1073741824
MULF4
ASGNF4
ADDRLP4 0+28+4
ADDRLP4 0+28+4
INDIRF4
CNSTF4 1073741824
MULF4
ASGNF4
ADDRLP4 0+28+8
ADDRLP4 0+28+8
INDIRF4
CNSTF4 1073741824
MULF4
ASGNF4
line 3467
;3467:		VectorScale(legs.axis[1], MONSTER_GUARD_SCALE, legs.axis[1]);
ADDRLP4 0+28+12
ADDRLP4 0+28+12
INDIRF4
CNSTF4 1073741824
MULF4
ASGNF4
ADDRLP4 0+28+12+4
ADDRLP4 0+28+12+4
INDIRF4
CNSTF4 1073741824
MULF4
ASGNF4
ADDRLP4 0+28+12+8
ADDRLP4 0+28+12+8
INDIRF4
CNSTF4 1073741824
MULF4
ASGNF4
line 3468
;3468:		VectorScale(legs.axis[2], MONSTER_GUARD_SCALE, legs.axis[2]);
ADDRLP4 0+28+24
ADDRLP4 0+28+24
INDIRF4
CNSTF4 1073741824
MULF4
ASGNF4
ADDRLP4 0+28+24+4
ADDRLP4 0+28+24+4
INDIRF4
CNSTF4 1073741824
MULF4
ASGNF4
ADDRLP4 0+28+24+8
ADDRLP4 0+28+24+8
INDIRF4
CNSTF4 1073741824
MULF4
ASGNF4
line 3469
;3469:		legs.nonNormalizedAxes = qtrue;
ADDRLP4 0+64
CNSTI4 1
ASGNI4
line 3470
;3470:		break;
ADDRGP4 $1617
JUMPV
LABELV $1662
line 3472
;3471:	case CLIENTNUM_MONSTER_TITAN:
;3472:		VectorScale(legs.axis[0], MONSTER_TITAN_SCALE * 0.95, legs.axis[0]);
ADDRLP4 0+28
ADDRLP4 0+28
INDIRF4
CNSTF4 1079299277
MULF4
ASGNF4
ADDRLP4 0+28+4
ADDRLP4 0+28+4
INDIRF4
CNSTF4 1079299277
MULF4
ASGNF4
ADDRLP4 0+28+8
ADDRLP4 0+28+8
INDIRF4
CNSTF4 1079299277
MULF4
ASGNF4
line 3473
;3473:		VectorScale(legs.axis[1], MONSTER_TITAN_SCALE * 0.95, legs.axis[1]);
ADDRLP4 0+28+12
ADDRLP4 0+28+12
INDIRF4
CNSTF4 1079299277
MULF4
ASGNF4
ADDRLP4 0+28+12+4
ADDRLP4 0+28+12+4
INDIRF4
CNSTF4 1079299277
MULF4
ASGNF4
ADDRLP4 0+28+12+8
ADDRLP4 0+28+12+8
INDIRF4
CNSTF4 1079299277
MULF4
ASGNF4
line 3474
;3474:		VectorScale(legs.axis[2], MONSTER_TITAN_SCALE * 0.95, legs.axis[2]);
ADDRLP4 0+28+24
ADDRLP4 0+28+24
INDIRF4
CNSTF4 1079299277
MULF4
ASGNF4
ADDRLP4 0+28+24+4
ADDRLP4 0+28+24+4
INDIRF4
CNSTF4 1079299277
MULF4
ASGNF4
ADDRLP4 0+28+24+8
ADDRLP4 0+28+24+8
INDIRF4
CNSTF4 1079299277
MULF4
ASGNF4
line 3475
;3475:		legs.nonNormalizedAxes = qtrue;
ADDRLP4 0+64
CNSTI4 1
ASGNI4
line 3476
;3476:		break;
LABELV $1616
LABELV $1617
line 3481
;3477:	}
;3478:#endif
;3479:
;3480:	// get the animation state (after rotation, to allow feet shuffle)
;3481:	CG_PlayerAnimation( cent, &legs.oldframe, &legs.frame, &legs.backlerp,
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+96
ARGP4
ADDRLP4 0+80
ARGP4
ADDRLP4 0+100
ARGP4
ADDRLP4 144+96
ARGP4
ADDRLP4 144+80
ARGP4
ADDRLP4 144+100
ARGP4
ADDRGP4 CG_PlayerAnimation
CALLV
pop
line 3485
;3482:		 &torso.oldframe, &torso.frame, &torso.backlerp );
;3483:
;3484:	// add the talk baloon or disconnect icon
;3485:	CG_PlayerSprites( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_PlayerSprites
CALLV
pop
line 3489
;3486:
;3487:	// JUHOX FIXME: no dlights in EFH
;3488:#if ESCAPE_MODE
;3489:	if (cgs.gametype != GT_EFH)
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 9
EQI4 $1712
line 3493
;3490:#endif
;3491:	// JUHOX: add spawn effect light
;3492:#if 1
;3493:	{
line 3496
;3494:		float intensity;
;3495:
;3496:		if (CG_GetSpawnEffectParameters(&cent->currentState, &intensity, NULL, NULL, NULL)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 456
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 460
ADDRGP4 CG_GetSpawnEffectParameters
CALLI4
ASGNI4
ADDRLP4 460
INDIRI4
CNSTI4 0
EQI4 $1715
line 3497
;3497:			trap_R_AddLightToScene(cent->lerpOrigin, 200, intensity, intensity, intensity);		
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
ARGP4
CNSTF4 1128792064
ARGF4
ADDRLP4 464
ADDRLP4 456
INDIRF4
ASGNF4
ADDRLP4 464
INDIRF4
ARGF4
ADDRLP4 464
INDIRF4
ARGF4
ADDRLP4 464
INDIRF4
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 3498
;3498:		}
LABELV $1715
line 3499
;3499:	}
LABELV $1712
line 3503
;3500:#endif
;3501:
;3502:	// add the shadow
;3503:	shadow = CG_PlayerShadow( cent, &shadowPlane );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 432
ARGP4
ADDRLP4 456
ADDRGP4 CG_PlayerShadow
CALLI4
ASGNI4
ADDRLP4 436
ADDRLP4 456
INDIRI4
ASGNI4
line 3506
;3504:
;3505:	// add a water splash if partially in and out of water
;3506:	CG_PlayerSplash( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_PlayerSplash
CALLV
pop
line 3508
;3507:
;3508:	if ( cg_shadows.integer == 3 && shadow ) {
ADDRGP4 cg_shadows+12
INDIRI4
CNSTI4 3
NEI4 $1717
ADDRLP4 436
INDIRI4
CNSTI4 0
EQI4 $1717
line 3509
;3509:		renderfx |= RF_SHADOW_PLANE;
ADDRLP4 428
ADDRLP4 428
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 3510
;3510:	}
LABELV $1717
line 3511
;3511:	renderfx |= RF_LIGHTING_ORIGIN;			// use the same origin for all
ADDRLP4 428
ADDRLP4 428
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 3520
;3512:#ifdef MISSIONPACK
;3513:	if( cgs.gametype == GT_HARVESTER ) {
;3514:		CG_PlayerTokens( cent, renderfx );
;3515:	}
;3516:#endif
;3517:	//
;3518:	// add the legs
;3519:	//
;3520:	legs.hModel = ci->legsModel;
ADDRLP4 0+8
ADDRLP4 140
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
ASGNI4
line 3521
;3521:	legs.customSkin = ci->legsSkin;
ADDRLP4 0+108
ADDRLP4 140
INDIRP4
CNSTI4 540
ADDP4
INDIRI4
ASGNI4
line 3523
;3522:
;3523:	VectorCopy( cent->lerpOrigin, legs.origin );
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
INDIRB
ASGNB 12
line 3527
;3524:
;3525:	// JUHOX: draw hibernation items
;3526:#if MONSTER_MODE
;3527:	if (cent->currentState.modelindex & PFMI_HIBERNATION_MODE) {	// CAUTION: don't use ci->pfmi
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1723
line 3528
;3528:		if (cent->currentState.modelindex & PFMI_HIBERNATION_DRAW_SEED) {	// CAUTION: don't use ci->pfmi
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $1725
line 3529
;3529:			const float radius = 4;
ADDRLP4 600
CNSTF4 1082130432
ASGNF4
line 3532
;3530:			refEntity_t seed;
;3531:
;3532:			memset(&seed, 0, sizeof(seed));
ADDRLP4 460
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 3534
;3533:
;3534:			seed.hModel = trap_R_RegisterModel("models/powerups/health/small_sphere.md3");
ADDRGP4 $1728
ARGP4
ADDRLP4 604
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 460+8
ADDRLP4 604
INDIRI4
ASGNI4
line 3535
;3535:			seed.customShader = cgs.media.monsterSeedMetalShader;
ADDRLP4 460+112
ADDRGP4 cgs+751220+720
INDIRI4
ASGNI4
line 3538
;3536:			//seed.renderfx |= RF_NOSHADOW;
;3537:
;3538:			VectorCopy(cent->lerpOrigin, seed.origin);
ADDRLP4 460+68
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
INDIRB
ASGNB 12
line 3539
;3539:			if (!(cent->currentState.modelindex & PFMI_HIBERNATION_MORPHED)) {	// CAUTION: don't use ci->pfmi
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $1733
line 3540
;3540:				seed.origin[2] += DEFAULT_VIEWHEIGHT;
ADDRLP4 460+68+8
ADDRLP4 460+68+8
INDIRF4
CNSTF4 1104150528
ADDF4
ASGNF4
line 3541
;3541:			}
LABELV $1733
line 3542
;3542:			VectorCopy(seed.origin, seed.lightingOrigin);
ADDRLP4 460+12
ADDRLP4 460+68
INDIRB
ASGNB 12
line 3544
;3543:
;3544:			seed.origin[2] -= 0.5 * radius;
ADDRLP4 460+68+8
ADDRLP4 460+68+8
INDIRF4
ADDRLP4 600
INDIRF4
CNSTF4 1056964608
MULF4
SUBF4
ASGNF4
line 3545
;3545:			seed.axis[0][0] = 0.1 * radius;
ADDRLP4 460+28
ADDRLP4 600
INDIRF4
CNSTF4 1036831949
MULF4
ASGNF4
line 3546
;3546:			seed.axis[1][1] = 0.1 * radius;
ADDRLP4 460+28+12+4
ADDRLP4 600
INDIRF4
CNSTF4 1036831949
MULF4
ASGNF4
line 3547
;3547:			seed.axis[2][2] = 0.1 * radius;
ADDRLP4 460+28+24+8
ADDRLP4 600
INDIRF4
CNSTF4 1036831949
MULF4
ASGNF4
line 3548
;3548:			seed.nonNormalizedAxes = qtrue;
ADDRLP4 460+64
CNSTI4 1
ASGNI4
line 3549
;3549:			trap_R_AddRefEntityToScene(&seed);
ADDRLP4 460
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 3550
;3550:		}
LABELV $1725
line 3552
;3551:		
;3552:		if (cent->currentState.modelindex & PFMI_HIBERNATION_DRAW_THREAD) {	// CAUTION: don't use ci->pfmi
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $1749
line 3555
;3553:			refEntity_t thread;
;3554:
;3555:			VectorCopy(cent->lerpOrigin, thread.origin);
ADDRLP4 460+68
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
INDIRB
ASGNB 12
line 3556
;3556:			if (!(cent->currentState.modelindex & PFMI_HIBERNATION_MORPHED)) {	// CAUTION: don't use ci->pfmi
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $1752
line 3557
;3557:				thread.origin[2] += DEFAULT_VIEWHEIGHT;
ADDRLP4 460+68+8
ADDRLP4 460+68+8
INDIRF4
CNSTF4 1104150528
ADDF4
ASGNF4
line 3558
;3558:			}
LABELV $1752
line 3559
;3559:			VectorCopy(cent->currentState.origin2, thread.oldorigin);
ADDRLP4 460+84
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
INDIRB
ASGNB 12
line 3560
;3560:			thread.reType = RT_LIGHTNING;
ADDRLP4 460
CNSTI4 6
ASGNI4
line 3561
;3561:			thread.customShader = trap_R_RegisterShader("thread");
ADDRGP4 $1758
ARGP4
ADDRLP4 600
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 460+112
ADDRLP4 600
INDIRI4
ASGNI4
line 3562
;3562:			trap_R_AddRefEntityToScene(&thread);
ADDRLP4 460
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 3563
;3563:		}
LABELV $1749
line 3565
;3564:
;3565:		if (!cent->currentState.time || cent->currentState.time <= cg.time) return;
ADDRLP4 460
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 460
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1762
ADDRLP4 460
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ADDRGP4 cg+107656
INDIRI4
GTI4 $1759
LABELV $1762
ADDRGP4 $1576
JUMPV
LABELV $1759
line 3566
;3566:	}
LABELV $1723
line 3569
;3567:#endif
;3568:
;3569:	VectorCopy( cent->lerpOrigin, legs.lightingOrigin );
ADDRLP4 0+12
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
INDIRB
ASGNB 12
line 3570
;3570:	legs.shadowPlane = shadowPlane;
ADDRLP4 0+24
ADDRLP4 432
INDIRF4
ASGNF4
line 3571
;3571:	legs.renderfx = renderfx;
ADDRLP4 0+4
ADDRLP4 428
INDIRI4
ASGNI4
line 3574
;3572:
;3573:#if 1	// JUHOX: correct origin for scaled models (hack)
;3574:	switch (clientNum) {
ADDRLP4 424
INDIRI4
CNSTI4 66
EQI4 $1768
ADDRGP4 $1766
JUMPV
LABELV $1768
line 3576
;3575:	case CLIENTNUM_MONSTER_TITAN:
;3576:		legs.origin[2] -= 5;
ADDRLP4 0+68+8
ADDRLP4 0+68+8
INDIRF4
CNSTF4 1084227584
SUBF4
ASGNF4
line 3577
;3577:		break;
LABELV $1766
LABELV $1767
line 3581
;3578:	}
;3579:#endif
;3580:
;3581:	VectorCopy (legs.origin, legs.oldorigin);	// don't positionally lerp at all
ADDRLP4 0+84
ADDRLP4 0+68
INDIRB
ASGNB 12
line 3583
;3582:
;3583:	CG_AddRefEntityWithPowerups( &legs, &cent->currentState, ci->team );
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_AddRefEntityWithPowerups
CALLV
pop
line 3587
;3584:
;3585:
;3586:	// if the model failed, allow the default nullmodel to be displayed
;3587:	if (!legs.hModel) {
ADDRLP4 0+8
INDIRI4
CNSTI4 0
NEI4 $1773
line 3588
;3588:		return;
ADDRGP4 $1576
JUMPV
LABELV $1773
line 3594
;3589:	}
;3590:
;3591:	//
;3592:	// add the torso
;3593:	//
;3594:	torso.hModel = ci->torsoModel;
ADDRLP4 144+8
ADDRLP4 140
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
ASGNI4
line 3595
;3595:	if (!torso.hModel) {
ADDRLP4 144+8
INDIRI4
CNSTI4 0
NEI4 $1777
line 3596
;3596:		return;
ADDRGP4 $1576
JUMPV
LABELV $1777
line 3599
;3597:	}
;3598:
;3599:	torso.customSkin = ci->torsoSkin;
ADDRLP4 144+108
ADDRLP4 140
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
ASGNI4
line 3601
;3600:
;3601:	VectorCopy( cent->lerpOrigin, torso.lightingOrigin );
ADDRLP4 144+12
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
INDIRB
ASGNB 12
line 3603
;3602:
;3603:	CG_PositionRotatedEntityOnTag( &torso, &legs, ci->legsModel, "tag_torso");
ADDRLP4 144
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 140
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
ARGI4
ADDRGP4 $1782
ARGP4
ADDRGP4 CG_PositionRotatedEntityOnTag
CALLV
pop
line 3605
;3604:
;3605:	torso.shadowPlane = shadowPlane;
ADDRLP4 144+24
ADDRLP4 432
INDIRF4
ASGNF4
line 3606
;3606:	torso.renderfx = renderfx;
ADDRLP4 144+4
ADDRLP4 428
INDIRI4
ASGNI4
line 3608
;3607:
;3608:	CG_AddRefEntityWithPowerups( &torso, &cent->currentState, ci->team );
ADDRLP4 144
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_AddRefEntityWithPowerups
CALLV
pop
line 3817
;3609:
;3610:#ifdef MISSIONPACK
;3611:	if ( cent->currentState.eFlags & EF_KAMIKAZE ) {
;3612:
;3613:		memset( &skull, 0, sizeof(skull) );
;3614:
;3615:		VectorCopy( cent->lerpOrigin, skull.lightingOrigin );
;3616:		skull.shadowPlane = shadowPlane;
;3617:		skull.renderfx = renderfx;
;3618:
;3619:		if ( cent->currentState.eFlags & EF_DEAD ) {
;3620:			// one skull bobbing above the dead body
;3621:			angle = ((cg.time / 7) & 255) * (M_PI * 2) / 255;
;3622:			if (angle > M_PI * 2)
;3623:				angle -= (float)M_PI * 2;
;3624:			dir[0] = sin(angle) * 20;
;3625:			dir[1] = cos(angle) * 20;
;3626:			angle = ((cg.time / 4) & 255) * (M_PI * 2) / 255;
;3627:			dir[2] = 15 + sin(angle) * 8;
;3628:			VectorAdd(torso.origin, dir, skull.origin);
;3629:			
;3630:			dir[2] = 0;
;3631:			VectorCopy(dir, skull.axis[1]);
;3632:			VectorNormalize(skull.axis[1]);
;3633:			VectorSet(skull.axis[2], 0, 0, 1);
;3634:			CrossProduct(skull.axis[1], skull.axis[2], skull.axis[0]);
;3635:
;3636:			skull.hModel = cgs.media.kamikazeHeadModel;
;3637:			trap_R_AddRefEntityToScene( &skull );
;3638:			skull.hModel = cgs.media.kamikazeHeadTrail;
;3639:			trap_R_AddRefEntityToScene( &skull );
;3640:		}
;3641:		else {
;3642:			// three skulls spinning around the player
;3643:			angle = ((cg.time / 4) & 255) * (M_PI * 2) / 255;
;3644:			dir[0] = cos(angle) * 20;
;3645:			dir[1] = sin(angle) * 20;
;3646:			dir[2] = cos(angle) * 20;
;3647:			VectorAdd(torso.origin, dir, skull.origin);
;3648:
;3649:			angles[0] = sin(angle) * 30;
;3650:			angles[1] = (angle * 180 / M_PI) + 90;
;3651:			if (angles[1] > 360)
;3652:				angles[1] -= 360;
;3653:			angles[2] = 0;
;3654:			AnglesToAxis( angles, skull.axis );
;3655:
;3656:			/*
;3657:			dir[2] = 0;
;3658:			VectorInverse(dir);
;3659:			VectorCopy(dir, skull.axis[1]);
;3660:			VectorNormalize(skull.axis[1]);
;3661:			VectorSet(skull.axis[2], 0, 0, 1);
;3662:			CrossProduct(skull.axis[1], skull.axis[2], skull.axis[0]);
;3663:			*/
;3664:
;3665:			skull.hModel = cgs.media.kamikazeHeadModel;
;3666:			trap_R_AddRefEntityToScene( &skull );
;3667:			// flip the trail because this skull is spinning in the other direction
;3668:			VectorInverse(skull.axis[1]);
;3669:			skull.hModel = cgs.media.kamikazeHeadTrail;
;3670:			trap_R_AddRefEntityToScene( &skull );
;3671:
;3672:			angle = ((cg.time / 4) & 255) * (M_PI * 2) / 255 + M_PI;
;3673:			if (angle > M_PI * 2)
;3674:				angle -= (float)M_PI * 2;
;3675:			dir[0] = sin(angle) * 20;
;3676:			dir[1] = cos(angle) * 20;
;3677:			dir[2] = cos(angle) * 20;
;3678:			VectorAdd(torso.origin, dir, skull.origin);
;3679:
;3680:			angles[0] = cos(angle - 0.5 * M_PI) * 30;
;3681:			angles[1] = 360 - (angle * 180 / M_PI);
;3682:			if (angles[1] > 360)
;3683:				angles[1] -= 360;
;3684:			angles[2] = 0;
;3685:			AnglesToAxis( angles, skull.axis );
;3686:
;3687:			/*
;3688:			dir[2] = 0;
;3689:			VectorCopy(dir, skull.axis[1]);
;3690:			VectorNormalize(skull.axis[1]);
;3691:			VectorSet(skull.axis[2], 0, 0, 1);
;3692:			CrossProduct(skull.axis[1], skull.axis[2], skull.axis[0]);
;3693:			*/
;3694:
;3695:			skull.hModel = cgs.media.kamikazeHeadModel;
;3696:			trap_R_AddRefEntityToScene( &skull );
;3697:			skull.hModel = cgs.media.kamikazeHeadTrail;
;3698:			trap_R_AddRefEntityToScene( &skull );
;3699:
;3700:			angle = ((cg.time / 3) & 255) * (M_PI * 2) / 255 + 0.5 * M_PI;
;3701:			if (angle > M_PI * 2)
;3702:				angle -= (float)M_PI * 2;
;3703:			dir[0] = sin(angle) * 20;
;3704:			dir[1] = cos(angle) * 20;
;3705:			dir[2] = 0;
;3706:			VectorAdd(torso.origin, dir, skull.origin);
;3707:			
;3708:			VectorCopy(dir, skull.axis[1]);
;3709:			VectorNormalize(skull.axis[1]);
;3710:			VectorSet(skull.axis[2], 0, 0, 1);
;3711:			CrossProduct(skull.axis[1], skull.axis[2], skull.axis[0]);
;3712:
;3713:			skull.hModel = cgs.media.kamikazeHeadModel;
;3714:			trap_R_AddRefEntityToScene( &skull );
;3715:			skull.hModel = cgs.media.kamikazeHeadTrail;
;3716:			trap_R_AddRefEntityToScene( &skull );
;3717:		}
;3718:	}
;3719:
;3720:	if ( cent->currentState.powerups & ( 1 << PW_GUARD ) ) {
;3721:		memcpy(&powerup, &torso, sizeof(torso));
;3722:		powerup.hModel = cgs.media.guardPowerupModel;
;3723:		powerup.frame = 0;
;3724:		powerup.oldframe = 0;
;3725:		powerup.customSkin = 0;
;3726:		trap_R_AddRefEntityToScene( &powerup );
;3727:	}
;3728:	if ( cent->currentState.powerups & ( 1 << PW_SCOUT ) ) {
;3729:		memcpy(&powerup, &torso, sizeof(torso));
;3730:		powerup.hModel = cgs.media.scoutPowerupModel;
;3731:		powerup.frame = 0;
;3732:		powerup.oldframe = 0;
;3733:		powerup.customSkin = 0;
;3734:		trap_R_AddRefEntityToScene( &powerup );
;3735:	}
;3736:	if ( cent->currentState.powerups & ( 1 << PW_DOUBLER ) ) {
;3737:		memcpy(&powerup, &torso, sizeof(torso));
;3738:		powerup.hModel = cgs.media.doublerPowerupModel;
;3739:		powerup.frame = 0;
;3740:		powerup.oldframe = 0;
;3741:		powerup.customSkin = 0;
;3742:		trap_R_AddRefEntityToScene( &powerup );
;3743:	}
;3744:	if ( cent->currentState.powerups & ( 1 << PW_AMMOREGEN ) ) {
;3745:		memcpy(&powerup, &torso, sizeof(torso));
;3746:		powerup.hModel = cgs.media.ammoRegenPowerupModel;
;3747:		powerup.frame = 0;
;3748:		powerup.oldframe = 0;
;3749:		powerup.customSkin = 0;
;3750:		trap_R_AddRefEntityToScene( &powerup );
;3751:	}
;3752:	if ( cent->currentState.powerups & ( 1 << PW_INVULNERABILITY ) ) {
;3753:		if ( !ci->invulnerabilityStartTime ) {
;3754:			ci->invulnerabilityStartTime = cg.time;
;3755:		}
;3756:		ci->invulnerabilityStopTime = cg.time;
;3757:	}
;3758:	else {
;3759:		ci->invulnerabilityStartTime = 0;
;3760:	}
;3761:	if ( (cent->currentState.powerups & ( 1 << PW_INVULNERABILITY ) ) ||
;3762:		cg.time - ci->invulnerabilityStopTime < 250 ) {
;3763:
;3764:		memcpy(&powerup, &torso, sizeof(torso));
;3765:		powerup.hModel = cgs.media.invulnerabilityPowerupModel;
;3766:		powerup.customSkin = 0;
;3767:		// always draw
;3768:		powerup.renderfx &= ~RF_THIRD_PERSON;
;3769:		VectorCopy(cent->lerpOrigin, powerup.origin);
;3770:
;3771:		if ( cg.time - ci->invulnerabilityStartTime < 250 ) {
;3772:			c = (float) (cg.time - ci->invulnerabilityStartTime) / 250;
;3773:		}
;3774:		else if (cg.time - ci->invulnerabilityStopTime < 250 ) {
;3775:			c = (float) (250 - (cg.time - ci->invulnerabilityStopTime)) / 250;
;3776:		}
;3777:		else {
;3778:			c = 1;
;3779:		}
;3780:		VectorSet( powerup.axis[0], c, 0, 0 );
;3781:		VectorSet( powerup.axis[1], 0, c, 0 );
;3782:		VectorSet( powerup.axis[2], 0, 0, c );
;3783:		trap_R_AddRefEntityToScene( &powerup );
;3784:	}
;3785:
;3786:	t = cg.time - ci->medkitUsageTime;
;3787:	if ( ci->medkitUsageTime && t < 500 ) {
;3788:		memcpy(&powerup, &torso, sizeof(torso));
;3789:		powerup.hModel = cgs.media.medkitUsageModel;
;3790:		powerup.customSkin = 0;
;3791:		// always draw
;3792:		powerup.renderfx &= ~RF_THIRD_PERSON;
;3793:		VectorClear(angles);
;3794:		AnglesToAxis(angles, powerup.axis);
;3795:		VectorCopy(cent->lerpOrigin, powerup.origin);
;3796:		powerup.origin[2] += -24 + (float) t * 80 / 500;
;3797:		if ( t > 400 ) {
;3798:			c = (float) (t - 1000) * 0xff / 100;
;3799:			powerup.shaderRGBA[0] = 0xff - c;
;3800:			powerup.shaderRGBA[1] = 0xff - c;
;3801:			powerup.shaderRGBA[2] = 0xff - c;
;3802:			powerup.shaderRGBA[3] = 0xff - c;
;3803:		}
;3804:		else {
;3805:			powerup.shaderRGBA[0] = 0xff;
;3806:			powerup.shaderRGBA[1] = 0xff;
;3807:			powerup.shaderRGBA[2] = 0xff;
;3808:			powerup.shaderRGBA[3] = 0xff;
;3809:		}
;3810:		trap_R_AddRefEntityToScene( &powerup );
;3811:	}
;3812:#endif // MISSIONPACK
;3813:
;3814:	//
;3815:	// add the head
;3816:	//
;3817:	head.hModel = ci->headModel;
ADDRLP4 284+8
ADDRLP4 140
INDIRP4
CNSTI4 552
ADDP4
INDIRI4
ASGNI4
line 3818
;3818:	if (!head.hModel) {
ADDRLP4 284+8
INDIRI4
CNSTI4 0
NEI4 $1786
line 3819
;3819:		return;
ADDRGP4 $1576
JUMPV
LABELV $1786
line 3821
;3820:	}
;3821:	head.customSkin = ci->headSkin;
ADDRLP4 284+108
ADDRLP4 140
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
ASGNI4
line 3823
;3822:
;3823:	VectorCopy( cent->lerpOrigin, head.lightingOrigin );
ADDRLP4 284+12
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
INDIRB
ASGNB 12
line 3825
;3824:
;3825:	CG_PositionRotatedEntityOnTag( &head, &torso, ci->torsoModel, "tag_head");
ADDRLP4 284
ARGP4
ADDRLP4 144
ARGP4
ADDRLP4 140
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
ARGI4
ADDRGP4 $1791
ARGP4
ADDRGP4 CG_PositionRotatedEntityOnTag
CALLV
pop
line 3827
;3826:
;3827:	head.shadowPlane = shadowPlane;
ADDRLP4 284+24
ADDRLP4 432
INDIRF4
ASGNF4
line 3828
;3828:	head.renderfx = renderfx;
ADDRLP4 284+4
ADDRLP4 428
INDIRI4
ASGNI4
line 3830
;3829:
;3830:	CG_AddRefEntityWithPowerups( &head, &cent->currentState, ci->team );
ADDRLP4 284
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_AddRefEntityWithPowerups
CALLV
pop
line 3841
;3831:
;3832:#ifdef MISSIONPACK
;3833:	CG_BreathPuffs(cent, &head);
;3834:
;3835:	CG_DustTrail(cent);
;3836:#endif
;3837:
;3838:	//
;3839:	// add the gun / barrel / flash
;3840:	//
;3841:	CG_AddPlayerWeapon( &torso, NULL, cent, ci->team );
ADDRLP4 144
ARGP4
CNSTP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_AddPlayerWeapon
CALLV
pop
line 3844
;3842:
;3843:	// add powerups floating behind the player
;3844:	CG_PlayerPowerups( cent, &torso );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 144
ARGP4
ADDRGP4 CG_PlayerPowerups
CALLV
pop
line 3848
;3845:
;3846:	// JUHOX: add grapple sounds
;3847:#if GRAPPLE_ROPE
;3848:	switch (cent->currentState.modelindex2) {
ADDRLP4 460
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
ASGNI4
ADDRLP4 460
INDIRI4
CNSTI4 0
LTI4 $1794
ADDRLP4 460
INDIRI4
CNSTI4 6
GTI4 $1794
ADDRLP4 460
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1810
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1810
address $1795
address $1795
address $1795
address $1798
address $1801
address $1804
address $1807
code
line 3852
;3849:	case GST_unused:
;3850:	case GST_silent:
;3851:	case GST_fixed:
;3852:		break;
LABELV $1798
line 3854
;3853:	case GST_windoff:
;3854:		trap_S_AddLoopingSound(cent->currentState.number, cent->lerpOrigin, vec3_origin, cgs.media.grappleWindOffSound);
ADDRLP4 468
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 468
INDIRP4
INDIRI4
ARGI4
ADDRLP4 468
INDIRP4
CNSTI4 728
ADDP4
ARGP4
ADDRGP4 vec3_origin
ARGP4
ADDRGP4 cgs+751220+1116
INDIRI4
ARGI4
ADDRGP4 trap_S_AddLoopingSound_fixed
CALLV
pop
line 3855
;3855:		break;
ADDRGP4 $1795
JUMPV
LABELV $1801
line 3857
;3856:	case GST_rewind:
;3857:		trap_S_AddLoopingSound(cent->currentState.number, cent->lerpOrigin, vec3_origin, cgs.media.grappleRewindSound);
ADDRLP4 472
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 472
INDIRP4
INDIRI4
ARGI4
ADDRLP4 472
INDIRP4
CNSTI4 728
ADDP4
ARGP4
ADDRGP4 vec3_origin
ARGP4
ADDRGP4 cgs+751220+1120
INDIRI4
ARGI4
ADDRGP4 trap_S_AddLoopingSound_fixed
CALLV
pop
line 3858
;3858:		break;
ADDRGP4 $1795
JUMPV
LABELV $1804
line 3860
;3859:	case GST_pulling:
;3860:		trap_S_AddLoopingSound(cent->currentState.number, cent->lerpOrigin, vec3_origin, cgs.media.grapplePullingSound);
ADDRLP4 476
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 476
INDIRP4
INDIRI4
ARGI4
ADDRLP4 476
INDIRP4
CNSTI4 728
ADDP4
ARGP4
ADDRGP4 vec3_origin
ARGP4
ADDRGP4 cgs+751220+1124
INDIRI4
ARGI4
ADDRGP4 trap_S_AddLoopingSound_fixed
CALLV
pop
line 3861
;3861:		break;
ADDRGP4 $1795
JUMPV
LABELV $1807
line 3863
;3862:	case GST_blocked:
;3863:		trap_S_AddLoopingSound(cent->currentState.number, cent->lerpOrigin, vec3_origin, cgs.media.grappleBlockingSound);
ADDRLP4 480
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 480
INDIRP4
INDIRI4
ARGI4
ADDRLP4 480
INDIRP4
CNSTI4 728
ADDP4
ARGP4
ADDRGP4 vec3_origin
ARGP4
ADDRGP4 cgs+751220+1128
INDIRI4
ARGI4
ADDRGP4 trap_S_AddLoopingSound_fixed
CALLV
pop
line 3864
;3864:		break;
LABELV $1794
LABELV $1795
line 3867
;3865:	}
;3866:#endif
;3867:}
LABELV $1576
endproc CG_Player 608 28
export CG_ResetPlayerEntity
proc CG_ResetPlayerEntity 40 12
line 3879
;3868:
;3869:
;3870://=====================================================================
;3871:
;3872:/*
;3873:===============
;3874:CG_ResetPlayerEntity
;3875:
;3876:A player just came into view or teleported, so reset all animation info
;3877:===============
;3878:*/
;3879:void CG_ResetPlayerEntity( centity_t *cent ) {
line 3880
;3880:	cent->errorTime = -99999;		// guarantee no error decay added
ADDRFP4 0
INDIRP4
CNSTI4 660
ADDP4
CNSTI4 -99999
ASGNI4
line 3881
;3881:	cent->extrapolated = qfalse;	
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
CNSTI4 0
ASGNI4
line 3883
;3882:
;3883:	CG_ClearLerpFrame( &cgs.clientinfo[ cent->currentState.clientNum ], &cent->pe.legs, cent->currentState.legsAnim );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 452
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_ClearLerpFrame
CALLV
pop
line 3884
;3884:	CG_ClearLerpFrame( &cgs.clientinfo[ cent->currentState.clientNum ], &cent->pe.torso, cent->currentState.torsoAnim );
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 504
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_ClearLerpFrame
CALLV
pop
line 3886
;3885:
;3886:	BG_EvaluateTrajectory( &cent->currentState.pos, cg.time, cent->lerpOrigin );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 cg+107656
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 728
ADDP4
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 3887
;3887:	BG_EvaluateTrajectory( &cent->currentState.apos, cg.time, cent->lerpAngles );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRGP4 cg+107656
INDIRI4
ARGI4
ADDRLP4 12
INDIRP4
CNSTI4 740
ADDP4
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 3889
;3888:
;3889:	VectorCopy( cent->lerpOrigin, cent->rawOrigin );
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 692
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 728
ADDP4
INDIRB
ASGNB 12
line 3890
;3890:	VectorCopy( cent->lerpAngles, cent->rawAngles );
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 704
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 740
ADDP4
INDIRB
ASGNB 12
line 3892
;3891:
;3892:	memset( &cent->pe.legs, 0, sizeof( cent->pe.legs ) );
ADDRFP4 0
INDIRP4
CNSTI4 452
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 52
ARGI4
ADDRGP4 memset
CALLP4
pop
line 3893
;3893:	cent->pe.legs.yawAngle = cent->rawAngles[YAW];
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 472
ADDP4
ADDRLP4 24
INDIRP4
CNSTI4 708
ADDP4
INDIRF4
ASGNF4
line 3894
;3894:	cent->pe.legs.yawing = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 476
ADDP4
CNSTI4 0
ASGNI4
line 3895
;3895:	cent->pe.legs.pitchAngle = 0;
ADDRFP4 0
INDIRP4
CNSTI4 480
ADDP4
CNSTF4 0
ASGNF4
line 3896
;3896:	cent->pe.legs.pitching = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 484
ADDP4
CNSTI4 0
ASGNI4
line 3897
;3897:	cent->pe.legs.clock = cg.time;	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 500
ADDP4
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 3899
;3898:
;3899:	memset( &cent->pe.torso, 0, sizeof( cent->pe.legs ) );
ADDRFP4 0
INDIRP4
CNSTI4 504
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 52
ARGI4
ADDRGP4 memset
CALLP4
pop
line 3900
;3900:	cent->pe.torso.yawAngle = cent->rawAngles[YAW];
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 524
ADDP4
ADDRLP4 28
INDIRP4
CNSTI4 708
ADDP4
INDIRF4
ASGNF4
line 3901
;3901:	cent->pe.torso.yawing = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
CNSTI4 0
ASGNI4
line 3902
;3902:	cent->pe.torso.pitchAngle = cent->rawAngles[PITCH];
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 532
ADDP4
ADDRLP4 32
INDIRP4
CNSTI4 704
ADDP4
INDIRF4
ASGNF4
line 3903
;3903:	cent->pe.torso.pitching = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
CNSTI4 0
ASGNI4
line 3904
;3904:	cent->pe.torso.clock = cg.time;	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 552
ADDP4
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 3906
;3905:
;3906:	if ( cg_debugPosition.integer ) {
ADDRGP4 cg_debugPosition+12
INDIRI4
CNSTI4 0
EQI4 $1818
line 3907
;3907:		CG_Printf("%i ResetPlayerEntity yaw=%i\n", cent->currentState.number, cent->pe.torso.yawAngle );
ADDRGP4 $1821
ARGP4
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
INDIRI4
ARGI4
ADDRLP4 36
INDIRP4
CNSTI4 524
ADDP4
INDIRF4
ARGF4
ADDRGP4 CG_Printf
CALLV
pop
line 3908
;3908:	}
LABELV $1818
line 3909
;3909:}
LABELV $1811
endproc CG_ResetPlayerEntity 40 12
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
import CG_DrawInformation
import CG_LoadingClient
import CG_LoadingItem
import CG_LoadingString
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
import CG_PredictPlayerState
import CG_SmoothTrace
import CG_Trace
import CG_PointContents
import CG_BuildSolidList
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
LABELV $1821
byte 1 37
byte 1 105
byte 1 32
byte 1 82
byte 1 101
byte 1 115
byte 1 101
byte 1 116
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 69
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 121
byte 1 97
byte 1 119
byte 1 61
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $1791
byte 1 116
byte 1 97
byte 1 103
byte 1 95
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $1782
byte 1 116
byte 1 97
byte 1 103
byte 1 95
byte 1 116
byte 1 111
byte 1 114
byte 1 115
byte 1 111
byte 1 0
align 1
LABELV $1758
byte 1 116
byte 1 104
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $1728
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 47
byte 1 115
byte 1 109
byte 1 97
byte 1 108
byte 1 108
byte 1 95
byte 1 115
byte 1 112
byte 1 104
byte 1 101
byte 1 114
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1580
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
byte 1 78
byte 1 117
byte 1 109
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $1384
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 71
byte 1 108
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $1327
byte 1 115
byte 1 116
byte 1 111
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $877
byte 1 66
byte 1 97
byte 1 100
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 97
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $796
byte 1 67
byte 1 108
byte 1 97
byte 1 109
byte 1 112
byte 1 32
byte 1 108
byte 1 102
byte 1 45
byte 1 62
byte 1 102
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $766
byte 1 65
byte 1 110
byte 1 105
byte 1 109
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $762
byte 1 66
byte 1 97
byte 1 100
byte 1 32
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
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
byte 1 0
align 1
LABELV $716
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 98
byte 1 105
byte 1 103
byte 1 95
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $712
byte 1 117
byte 1 114
byte 1 105
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $711
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
LABELV $709
byte 1 84
byte 1 105
byte 1 116
byte 1 97
byte 1 110
byte 1 0
align 1
LABELV $706
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 103
byte 1 117
byte 1 97
byte 1 114
byte 1 100
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $702
byte 1 116
byte 1 97
byte 1 110
byte 1 107
byte 1 106
byte 1 114
byte 1 0
align 1
LABELV $701
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
LABELV $699
byte 1 71
byte 1 117
byte 1 97
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $695
byte 1 107
byte 1 108
byte 1 101
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $694
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
LABELV $692
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
LABELV $670
byte 1 77
byte 1 101
byte 1 109
byte 1 111
byte 1 114
byte 1 121
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 108
byte 1 111
byte 1 119
byte 1 46
byte 1 32
byte 1 32
byte 1 85
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 114
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $633
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
LABELV $621
byte 1 104
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $586
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $584
byte 1 103
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $582
byte 1 103
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $580
byte 1 116
byte 1 108
byte 1 0
align 1
LABELV $578
byte 1 116
byte 1 116
byte 1 0
align 1
LABELV $576
byte 1 116
byte 1 0
align 1
LABELV $574
byte 1 103
byte 1 99
byte 1 0
align 1
LABELV $572
byte 1 108
byte 1 0
align 1
LABELV $570
byte 1 119
byte 1 0
align 1
LABELV $568
byte 1 104
byte 1 99
byte 1 0
align 1
LABELV $566
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $564
byte 1 99
byte 1 50
byte 1 0
align 1
LABELV $562
byte 1 99
byte 1 49
byte 1 0
align 1
LABELV $559
byte 1 110
byte 1 0
align 1
LABELV $552
byte 1 67
byte 1 71
byte 1 95
byte 1 83
byte 1 101
byte 1 116
byte 1 68
byte 1 101
byte 1 102
byte 1 101
byte 1 114
byte 1 114
byte 1 101
byte 1 100
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 73
byte 1 110
byte 1 102
byte 1 111
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $478
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
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $462
byte 1 116
byte 1 97
byte 1 103
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $457
byte 1 68
byte 1 69
byte 1 70
byte 1 65
byte 1 85
byte 1 76
byte 1 84
byte 1 95
byte 1 77
byte 1 79
byte 1 68
byte 1 69
byte 1 76
byte 1 32
byte 1 40
byte 1 37
byte 1 115
byte 1 41
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 114
byte 1 101
byte 1 103
byte 1 105
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $454
byte 1 68
byte 1 69
byte 1 70
byte 1 65
byte 1 85
byte 1 76
byte 1 84
byte 1 95
byte 1 84
byte 1 69
byte 1 65
byte 1 77
byte 1 95
byte 1 77
byte 1 79
byte 1 68
byte 1 69
byte 1 76
byte 1 32
byte 1 47
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 40
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 41
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 114
byte 1 101
byte 1 103
byte 1 105
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $453
byte 1 115
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $444
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 32
byte 1 47
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 40
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 41
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 114
byte 1 101
byte 1 103
byte 1 105
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $435
byte 1 67
byte 1 71
byte 1 95
byte 1 82
byte 1 101
byte 1 103
byte 1 105
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 40
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 41
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $418
byte 1 115
byte 1 111
byte 1 114
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $415
byte 1 98
byte 1 111
byte 1 110
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $410
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $407
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $404
byte 1 70
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
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
byte 1 110
byte 1 105
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $401
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
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 0
align 1
LABELV $398
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
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 0
align 1
LABELV $397
byte 1 70
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $394
byte 1 83
byte 1 116
byte 1 114
byte 1 111
byte 1 103
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $393
byte 1 80
byte 1 97
byte 1 103
byte 1 97
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $392
byte 1 37
byte 1 115
byte 1 47
byte 1 0
align 1
LABELV $389
byte 1 70
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $380
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
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $379
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
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $374
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
byte 1 117
byte 1 112
byte 1 112
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $371
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
byte 1 117
byte 1 112
byte 1 112
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $370
byte 1 70
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $367
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
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $364
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
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $356
byte 1 72
byte 1 101
byte 1 97
byte 1 100
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 117
byte 1 114
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $353
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $350
byte 1 84
byte 1 111
byte 1 114
byte 1 115
byte 1 111
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 117
byte 1 114
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $347
byte 1 117
byte 1 112
byte 1 112
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $344
byte 1 76
byte 1 101
byte 1 103
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 117
byte 1 114
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $341
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $340
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $319
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
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $318
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
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $308
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 115
byte 1 47
byte 1 0
align 1
LABELV $296
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
byte 1 0
align 1
LABELV $286
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
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $285
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
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $276
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
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $275
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
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $265
byte 1 0
align 1
LABELV $264
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $263
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $248
byte 1 69
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $223
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $220
byte 1 102
byte 1 105
byte 1 120
byte 1 101
byte 1 100
byte 1 116
byte 1 111
byte 1 114
byte 1 115
byte 1 111
byte 1 0
align 1
LABELV $217
byte 1 102
byte 1 105
byte 1 120
byte 1 101
byte 1 100
byte 1 108
byte 1 101
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $206
byte 1 115
byte 1 101
byte 1 120
byte 1 0
align 1
LABELV $197
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 111
byte 1 102
byte 1 102
byte 1 115
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $194
byte 1 66
byte 1 97
byte 1 100
byte 1 32
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 109
byte 1 32
byte 1 105
byte 1 110
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
LABELV $193
byte 1 101
byte 1 110
byte 1 101
byte 1 114
byte 1 103
byte 1 121
byte 1 0
align 1
LABELV $190
byte 1 109
byte 1 101
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $187
byte 1 102
byte 1 108
byte 1 101
byte 1 115
byte 1 104
byte 1 0
align 1
LABELV $184
byte 1 98
byte 1 111
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $180
byte 1 110
byte 1 111
byte 1 114
byte 1 109
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $179
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $174
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $166
byte 1 70
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 108
byte 1 111
byte 1 110
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $160
byte 1 85
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 99
byte 1 117
byte 1 115
byte 1 116
byte 1 111
byte 1 109
byte 1 32
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $136
byte 1 42
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $135
byte 1 42
byte 1 102
byte 1 97
byte 1 108
byte 1 108
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $134
byte 1 42
byte 1 100
byte 1 114
byte 1 111
byte 1 119
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $133
byte 1 42
byte 1 103
byte 1 97
byte 1 115
byte 1 112
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $132
byte 1 42
byte 1 102
byte 1 97
byte 1 108
byte 1 108
byte 1 105
byte 1 110
byte 1 103
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $131
byte 1 42
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 49
byte 1 48
byte 1 48
byte 1 95
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $130
byte 1 42
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 55
byte 1 53
byte 1 95
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $129
byte 1 42
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 53
byte 1 48
byte 1 95
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $128
byte 1 42
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 50
byte 1 53
byte 1 95
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $127
byte 1 42
byte 1 106
byte 1 117
byte 1 109
byte 1 112
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $126
byte 1 42
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $125
byte 1 42
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $124
byte 1 42
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
