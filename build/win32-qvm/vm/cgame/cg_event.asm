bss
align 1
LABELV $125
skip 64
export CG_PlaceString
code
proc CG_PlaceString 12 20
file "..\..\..\..\code\cgame\cg_event.c"
line 21
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_event.c -- handle entity events at snapshot or playerstate transitions
;4:
;5:#include "cg_local.h"
;6:
;7:// for the voice chats
;8:#ifdef MISSIONPACK // bk001205
;9:#include "../../ui/menudef.h"
;10:
;11:#endif
;12://==========================================================================
;13:
;14:/*
;15:===================
;16:CG_PlaceString
;17:
;18:Also called by scoreboard drawing
;19:===================
;20:*/
;21:const char	*CG_PlaceString( int rank ) {
line 25
;22:	static char	str[64];
;23:	char	*s, *t;
;24:
;25:	if ( rank & RANK_TIED_FLAG ) {
ADDRFP4 0
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $126
line 26
;26:		rank &= ~RANK_TIED_FLAG;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -16385
BANDI4
ASGNI4
line 27
;27:		t = "Tied for ";
ADDRLP4 4
ADDRGP4 $128
ASGNP4
line 28
;28:	} else {
ADDRGP4 $127
JUMPV
LABELV $126
line 29
;29:		t = "";
ADDRLP4 4
ADDRGP4 $129
ASGNP4
line 30
;30:	}
LABELV $127
line 32
;31:
;32:	if ( rank == 1 ) {
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $130
line 33
;33:		s = S_COLOR_BLUE "1st" S_COLOR_WHITE;		// draw in blue
ADDRLP4 0
ADDRGP4 $132
ASGNP4
line 34
;34:	} else if ( rank == 2 ) {
ADDRGP4 $131
JUMPV
LABELV $130
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $133
line 35
;35:		s = S_COLOR_RED "2nd" S_COLOR_WHITE;		// draw in red
ADDRLP4 0
ADDRGP4 $135
ASGNP4
line 36
;36:	} else if ( rank == 3 ) {
ADDRGP4 $134
JUMPV
LABELV $133
ADDRFP4 0
INDIRI4
CNSTI4 3
NEI4 $136
line 37
;37:		s = S_COLOR_YELLOW "3rd" S_COLOR_WHITE;		// draw in yellow
ADDRLP4 0
ADDRGP4 $138
ASGNP4
line 38
;38:	} else if ( rank == 11 ) {
ADDRGP4 $137
JUMPV
LABELV $136
ADDRFP4 0
INDIRI4
CNSTI4 11
NEI4 $139
line 39
;39:		s = "11th";
ADDRLP4 0
ADDRGP4 $141
ASGNP4
line 40
;40:	} else if ( rank == 12 ) {
ADDRGP4 $140
JUMPV
LABELV $139
ADDRFP4 0
INDIRI4
CNSTI4 12
NEI4 $142
line 41
;41:		s = "12th";
ADDRLP4 0
ADDRGP4 $144
ASGNP4
line 42
;42:	} else if ( rank == 13 ) {
ADDRGP4 $143
JUMPV
LABELV $142
ADDRFP4 0
INDIRI4
CNSTI4 13
NEI4 $145
line 43
;43:		s = "13th";
ADDRLP4 0
ADDRGP4 $147
ASGNP4
line 44
;44:	} else if ( rank % 10 == 1 ) {
ADDRGP4 $146
JUMPV
LABELV $145
ADDRFP4 0
INDIRI4
CNSTI4 10
MODI4
CNSTI4 1
NEI4 $148
line 45
;45:		s = va("%ist", rank);
ADDRGP4 $150
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 46
;46:	} else if ( rank % 10 == 2 ) {
ADDRGP4 $149
JUMPV
LABELV $148
ADDRFP4 0
INDIRI4
CNSTI4 10
MODI4
CNSTI4 2
NEI4 $151
line 47
;47:		s = va("%ind", rank);
ADDRGP4 $153
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 48
;48:	} else if ( rank % 10 == 3 ) {
ADDRGP4 $152
JUMPV
LABELV $151
ADDRFP4 0
INDIRI4
CNSTI4 10
MODI4
CNSTI4 3
NEI4 $154
line 49
;49:		s = va("%ird", rank);
ADDRGP4 $156
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 50
;50:	} else {
ADDRGP4 $155
JUMPV
LABELV $154
line 51
;51:		s = va("%ith", rank);
ADDRGP4 $157
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 52
;52:	}
LABELV $155
LABELV $152
LABELV $149
LABELV $146
LABELV $143
LABELV $140
LABELV $137
LABELV $134
LABELV $131
line 54
;53:
;54:	Com_sprintf( str, sizeof( str ), "%s%s", t, s );
ADDRGP4 $125
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $158
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 55
;55:	return str;
ADDRGP4 $125
RETP4
LABELV $124
endproc CG_PlaceString 12 20
proc CG_Obituary 136 20
line 63
;56:}
;57:
;58:/*
;59:=============
;60:CG_Obituary
;61:=============
;62:*/
;63:static void CG_Obituary( entityState_t *ent ) {
line 75
;64:	int			mod;
;65:	int			target, attacker;
;66:	char		*message;
;67:	char		*message2;
;68:	const char	*targetInfo;
;69:	const char	*attackerInfo;
;70:	char		targetName[32];
;71:	char		attackerName[32];
;72:	gender_t	gender;
;73:	clientInfo_t	*ci;
;74:
;75:	target = ent->otherEntityNum;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 76
;76:	attacker = ent->otherEntityNum2;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ASGNI4
line 77
;77:	mod = ent->eventParm;
ADDRLP4 44
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 79
;78:
;79:	if ( target < 0 || target >= MAX_CLIENTS ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $162
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $160
LABELV $162
line 80
;80:		CG_Error( "CG_Obituary: target out of range" );
ADDRGP4 $163
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 81
;81:	}
LABELV $160
line 82
;82:	ci = &cgs.clientinfo[target];
ADDRLP4 92
ADDRLP4 0
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320
ADDP4
ASGNP4
line 84
;83:
;84:	if ( attacker < 0 || attacker >= MAX_CLIENTS ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $167
ADDRLP4 4
INDIRI4
CNSTI4 64
LTI4 $165
LABELV $167
line 85
;85:		attacker = ENTITYNUM_WORLD;
ADDRLP4 4
CNSTI4 1022
ASGNI4
line 86
;86:		attackerInfo = NULL;
ADDRLP4 52
CNSTP4 0
ASGNP4
line 87
;87:	} else {
ADDRGP4 $166
JUMPV
LABELV $165
line 88
;88:		attackerInfo = CG_ConfigString( CS_PLAYERS + attacker );
ADDRLP4 4
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 108
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 52
ADDRLP4 108
INDIRP4
ASGNP4
line 89
;89:	}
LABELV $166
line 91
;90:
;91:	targetInfo = CG_ConfigString( CS_PLAYERS + target );
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 108
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 48
ADDRLP4 108
INDIRP4
ASGNP4
line 92
;92:	if ( !targetInfo ) {
ADDRLP4 48
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $168
line 93
;93:		return;
ADDRGP4 $159
JUMPV
LABELV $168
line 95
;94:	}
;95:	Q_strncpyz( targetName, Info_ValueForKey( targetInfo, "n" ), sizeof(targetName) - 2);
ADDRLP4 48
INDIRP4
ARGP4
ADDRGP4 $170
ARGP4
ADDRLP4 112
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 8
ARGP4
ADDRLP4 112
INDIRP4
ARGP4
CNSTI4 30
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 96
;96:	strcat( targetName, S_COLOR_WHITE );
ADDRLP4 8
ARGP4
ADDRGP4 $171
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 98
;97:
;98:	trap_S_StartSound(NULL, target, CHAN_WEAPON, cgs.media.silence);	// JUHOX FIXME: to stop long lasting weapon sounds (especially the new BFG sound) JUHOX FIXME: doesn't work with V1.27g
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 cgs+751220+828
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 100
;99:
;100:	message2 = "";
ADDRLP4 88
ADDRGP4 $129
ASGNP4
line 104
;101:
;102:	// check for single client messages
;103:
;104:	switch( mod ) {
ADDRLP4 44
INDIRI4
CNSTI4 3
EQI4 $176
ADDRLP4 44
INDIRI4
CNSTI4 4
EQI4 $178
ADDRLP4 44
INDIRI4
CNSTI4 5
EQI4 $180
ADDRLP4 44
INDIRI4
CNSTI4 3
LTI4 $174
LABELV $198
ADDRLP4 44
INDIRI4
CNSTI4 19
LTI4 $174
ADDRLP4 44
INDIRI4
CNSTI4 27
GTI4 $174
ADDRLP4 44
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $199-76
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $199
address $188
address $190
address $192
address $186
address $174
address $184
address $182
address $194
address $196
code
LABELV $176
line 107
;105:#if MONSTER_MODE
;106:	case MOD_CLAW:
;107:		message = "was lacerated by a predator";
ADDRLP4 40
ADDRGP4 $177
ASGNP4
line 108
;108:		break;
ADDRGP4 $175
JUMPV
LABELV $178
line 110
;109:	case MOD_GUARD:
;110:		message = "received the guard's message";
ADDRLP4 40
ADDRGP4 $179
ASGNP4
line 111
;111:		break;
ADDRGP4 $175
JUMPV
LABELV $180
line 113
;112:	case MOD_TITAN:
;113:		message = "was smashed by a titan";
ADDRLP4 40
ADDRGP4 $181
ASGNP4
line 114
;114:		break;
ADDRGP4 $175
JUMPV
LABELV $182
line 117
;115:#endif
;116:	case MOD_SUICIDE:
;117:		message = "suicides";
ADDRLP4 40
ADDRGP4 $183
ASGNP4
line 118
;118:		break;
ADDRGP4 $175
JUMPV
LABELV $184
line 120
;119:	case MOD_FALLING:
;120:		message = "cratered";
ADDRLP4 40
ADDRGP4 $185
ASGNP4
line 121
;121:		break;
ADDRGP4 $175
JUMPV
LABELV $186
line 123
;122:	case MOD_CRUSH:
;123:		message = "was squished";
ADDRLP4 40
ADDRGP4 $187
ASGNP4
line 124
;124:		break;
ADDRGP4 $175
JUMPV
LABELV $188
line 126
;125:	case MOD_WATER:
;126:		message = "sank like a rock";
ADDRLP4 40
ADDRGP4 $189
ASGNP4
line 127
;127:		break;
ADDRGP4 $175
JUMPV
LABELV $190
line 129
;128:	case MOD_SLIME:
;129:		message = "melted";
ADDRLP4 40
ADDRGP4 $191
ASGNP4
line 130
;130:		break;
ADDRGP4 $175
JUMPV
LABELV $192
line 132
;131:	case MOD_LAVA:
;132:		message = "does a back flip into the lava";
ADDRLP4 40
ADDRGP4 $193
ASGNP4
line 133
;133:		break;
ADDRGP4 $175
JUMPV
LABELV $194
line 135
;134:	case MOD_TARGET_LASER:
;135:		message = "saw the light";
ADDRLP4 40
ADDRGP4 $195
ASGNP4
line 136
;136:		break;
ADDRGP4 $175
JUMPV
LABELV $196
line 138
;137:	case MOD_TRIGGER_HURT:
;138:		message = "was in the wrong place";
ADDRLP4 40
ADDRGP4 $197
ASGNP4
line 139
;139:		break;
ADDRGP4 $175
JUMPV
LABELV $174
line 141
;140:	default:
;141:		message = NULL;
ADDRLP4 40
CNSTP4 0
ASGNP4
line 142
;142:		break;
LABELV $175
line 145
;143:	}
;144:
;145:	if (attacker == target) {
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $201
line 146
;146:		gender = ci->gender;
ADDRLP4 96
ADDRLP4 92
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ASGNI4
line 147
;147:		switch (mod) {
ADDRLP4 44
INDIRI4
CNSTI4 10
EQI4 $213
ADDRLP4 44
INDIRI4
CNSTI4 12
EQI4 $221
ADDRLP4 44
INDIRI4
CNSTI4 14
EQI4 $229
ADDRLP4 44
INDIRI4
CNSTI4 14
GTI4 $247
LABELV $246
ADDRLP4 44
INDIRI4
CNSTI4 6
EQI4 $205
ADDRGP4 $203
JUMPV
LABELV $247
ADDRLP4 44
INDIRI4
CNSTI4 18
EQI4 $237
ADDRGP4 $203
JUMPV
LABELV $205
line 156
;148:#ifdef MISSIONPACK
;149:		case MOD_KAMIKAZE:
;150:			message = "goes out with a bang";
;151:			break;
;152:#endif
;153:		// JUHOX: killed by one's own monster
;154:#if MONSTER_MODE
;155:		case MOD_MONSTER_LAUNCHER:
;156:			if (gender == GENDER_FEMALE)
ADDRLP4 96
INDIRI4
CNSTI4 1
NEI4 $206
line 157
;157:				message = "wasn't nice to her pets";
ADDRLP4 40
ADDRGP4 $208
ASGNP4
ADDRGP4 $204
JUMPV
LABELV $206
line 158
;158:			else if (gender == GENDER_NEUTER)
ADDRLP4 96
INDIRI4
CNSTI4 2
NEI4 $209
line 159
;159:				message = "wasn't nice to its pets";
ADDRLP4 40
ADDRGP4 $211
ASGNP4
ADDRGP4 $204
JUMPV
LABELV $209
line 161
;160:			else
;161:				message = "wasn't nice to his pets";
ADDRLP4 40
ADDRGP4 $212
ASGNP4
line 162
;162:			break;
ADDRGP4 $204
JUMPV
LABELV $213
line 165
;163:#endif
;164:		case MOD_GRENADE_SPLASH:
;165:			if ( gender == GENDER_FEMALE )
ADDRLP4 96
INDIRI4
CNSTI4 1
NEI4 $214
line 166
;166:				message = "tripped on her own grenade";
ADDRLP4 40
ADDRGP4 $216
ASGNP4
ADDRGP4 $204
JUMPV
LABELV $214
line 167
;167:			else if ( gender == GENDER_NEUTER )
ADDRLP4 96
INDIRI4
CNSTI4 2
NEI4 $217
line 168
;168:				message = "tripped on its own grenade";
ADDRLP4 40
ADDRGP4 $219
ASGNP4
ADDRGP4 $204
JUMPV
LABELV $217
line 170
;169:			else
;170:				message = "tripped on his own grenade";
ADDRLP4 40
ADDRGP4 $220
ASGNP4
line 171
;171:			break;
ADDRGP4 $204
JUMPV
LABELV $221
line 173
;172:		case MOD_ROCKET_SPLASH:
;173:			if ( gender == GENDER_FEMALE )
ADDRLP4 96
INDIRI4
CNSTI4 1
NEI4 $222
line 174
;174:				message = "blew herself up";
ADDRLP4 40
ADDRGP4 $224
ASGNP4
ADDRGP4 $204
JUMPV
LABELV $222
line 175
;175:			else if ( gender == GENDER_NEUTER )
ADDRLP4 96
INDIRI4
CNSTI4 2
NEI4 $225
line 176
;176:				message = "blew itself up";
ADDRLP4 40
ADDRGP4 $227
ASGNP4
ADDRGP4 $204
JUMPV
LABELV $225
line 178
;177:			else
;178:				message = "blew himself up";
ADDRLP4 40
ADDRGP4 $228
ASGNP4
line 179
;179:			break;
ADDRGP4 $204
JUMPV
LABELV $229
line 181
;180:		case MOD_PLASMA_SPLASH:
;181:			if ( gender == GENDER_FEMALE )
ADDRLP4 96
INDIRI4
CNSTI4 1
NEI4 $230
line 182
;182:				message = "melted herself";
ADDRLP4 40
ADDRGP4 $232
ASGNP4
ADDRGP4 $204
JUMPV
LABELV $230
line 183
;183:			else if ( gender == GENDER_NEUTER )
ADDRLP4 96
INDIRI4
CNSTI4 2
NEI4 $233
line 184
;184:				message = "melted itself";
ADDRLP4 40
ADDRGP4 $235
ASGNP4
ADDRGP4 $204
JUMPV
LABELV $233
line 186
;185:			else
;186:				message = "melted himself";
ADDRLP4 40
ADDRGP4 $236
ASGNP4
line 187
;187:			break;
ADDRGP4 $204
JUMPV
LABELV $237
line 189
;188:		case MOD_BFG_SPLASH:
;189:			message = "should have used a smaller gun";
ADDRLP4 40
ADDRGP4 $238
ASGNP4
line 190
;190:			break;
ADDRGP4 $204
JUMPV
LABELV $203
line 203
;191:#ifdef MISSIONPACK
;192:		case MOD_PROXIMITY_MINE:
;193:			if( gender == GENDER_FEMALE ) {
;194:				message = "found her prox mine";
;195:			} else if ( gender == GENDER_NEUTER ) {
;196:				message = "found it's prox mine";
;197:			} else {
;198:				message = "found his prox mine";
;199:			}
;200:			break;
;201:#endif
;202:		default:
;203:			if ( gender == GENDER_FEMALE )
ADDRLP4 96
INDIRI4
CNSTI4 1
NEI4 $239
line 204
;204:				message = "killed herself";
ADDRLP4 40
ADDRGP4 $241
ASGNP4
ADDRGP4 $204
JUMPV
LABELV $239
line 205
;205:			else if ( gender == GENDER_NEUTER )
ADDRLP4 96
INDIRI4
CNSTI4 2
NEI4 $242
line 206
;206:				message = "killed itself";
ADDRLP4 40
ADDRGP4 $244
ASGNP4
ADDRGP4 $204
JUMPV
LABELV $242
line 208
;207:			else
;208:				message = "killed himself";
ADDRLP4 40
ADDRGP4 $245
ASGNP4
line 209
;209:			break;
LABELV $204
line 211
;210:		}
;211:	}
LABELV $201
line 213
;212:
;213:	if (message) {
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $248
line 214
;214:		CG_Printf( "%s %s.\n", targetName, message);
ADDRGP4 $250
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 215
;215:		return;
ADDRGP4 $159
JUMPV
LABELV $248
line 219
;216:	}
;217:
;218:	// check for kill messages from the current clientNum
;219:	if ( attacker == cg.snap->ps.clientNum ) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $251
line 222
;220:		char	*s;
;221:
;222:		if ( cgs.gametype < GT_TEAM ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
GEI4 $254
line 223
;223:			s = va("You fragged %s\n%s place with %i", targetName, 
ADDRGP4 cg+36
INDIRP4
CNSTI4 300
ADDP4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 128
ADDRGP4 CG_PlaceString
CALLP4
ASGNP4
ADDRGP4 $257
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
ARGI4
ADDRLP4 132
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 124
ADDRLP4 132
INDIRP4
ASGNP4
line 226
;224:				CG_PlaceString( cg.snap->ps.persistant[PERS_RANK] + 1 ),
;225:				cg.snap->ps.persistant[PERS_SCORE] );
;226:		} else {
ADDRGP4 $255
JUMPV
LABELV $254
line 227
;227:			s = va("You fragged %s", targetName );
ADDRGP4 $260
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 128
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 124
ADDRLP4 128
INDIRP4
ASGNP4
line 228
;228:		}
LABELV $255
line 234
;229:#ifdef MISSIONPACK
;230:		if (!(cg_singlePlayerActive.integer && cg_cameraOrbit.integer)) {
;231:			CG_CenterPrint( s, SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH );
;232:		} 
;233:#else
;234:		CG_CenterPrint( s, SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH );
ADDRLP4 124
INDIRP4
ARGP4
CNSTI4 144
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 238
;235:#endif
;236:
;237:		// print the text message as well
;238:	}
LABELV $251
line 241
;239:
;240:	// check for double client messages
;241:	if ( !attackerInfo ) {
ADDRLP4 52
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $261
line 242
;242:		attacker = ENTITYNUM_WORLD;
ADDRLP4 4
CNSTI4 1022
ASGNI4
line 243
;243:		strcpy( attackerName, "noname" );
ADDRLP4 56
ARGP4
ADDRGP4 $263
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 244
;244:	} else {
ADDRGP4 $262
JUMPV
LABELV $261
line 245
;245:		Q_strncpyz( attackerName, Info_ValueForKey( attackerInfo, "n" ), sizeof(attackerName) - 2);
ADDRLP4 52
INDIRP4
ARGP4
ADDRGP4 $170
ARGP4
ADDRLP4 124
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 56
ARGP4
ADDRLP4 124
INDIRP4
ARGP4
CNSTI4 30
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 246
;246:		strcat( attackerName, S_COLOR_WHITE );
ADDRLP4 56
ARGP4
ADDRGP4 $171
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 248
;247:		// check for kill messages about the current clientNum
;248:		if ( target == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $264
line 249
;249:			Q_strncpyz( cg.killerName, attackerName, sizeof( cg.killerName ) );
ADDRGP4 cg+117636
ARGP4
ADDRLP4 56
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 250
;250:		}
LABELV $264
line 251
;251:	}
LABELV $262
line 253
;252:
;253:	if ( attacker != ENTITYNUM_WORLD ) {
ADDRLP4 4
INDIRI4
CNSTI4 1022
EQI4 $269
line 254
;254:		switch (mod) {
ADDRLP4 44
INDIRI4
CNSTI4 1
LTI4 $271
ADDRLP4 44
INDIRI4
CNSTI4 28
GTI4 $271
ADDRLP4 44
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $310-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $310
address $283
address $275
address $271
address $271
address $271
address $277
address $279
address $281
address $285
address $288
address $291
address $293
address $295
address $298
address $299
address $301
address $303
address $303
address $271
address $271
address $271
address $271
address $306
address $271
address $271
address $271
address $271
address $273
code
LABELV $273
line 256
;255:		case MOD_GRAPPLE:
;256:			message = "was caught by";
ADDRLP4 40
ADDRGP4 $274
ASGNP4
line 257
;257:			break;
ADDRGP4 $272
JUMPV
LABELV $275
line 259
;258:		case MOD_GAUNTLET:
;259:			message = "was pummeled by";
ADDRLP4 40
ADDRGP4 $276
ASGNP4
line 260
;260:			break;
ADDRGP4 $272
JUMPV
LABELV $277
line 264
;261:		// JUHOX: killed by monsters launched from the monster launcher
;262:#if MONSTER_MODE
;263:		case MOD_MONSTER_LAUNCHER:
;264:			message = "was hunted down by";
ADDRLP4 40
ADDRGP4 $278
ASGNP4
line 265
;265:			break;
ADDRGP4 $272
JUMPV
LABELV $279
line 270
;266:#endif
;267:		// JUHOX: new MODs
;268:#if 1
;269:		case MOD_CHARGE:
;270:			message = "was vaporized by";
ADDRLP4 40
ADDRGP4 $280
ASGNP4
line 271
;271:			break;
ADDRGP4 $272
JUMPV
LABELV $281
line 274
;272:#endif
;273:		case MOD_MACHINEGUN:
;274:			message = "was machinegunned by";
ADDRLP4 40
ADDRGP4 $282
ASGNP4
line 275
;275:			break;
ADDRGP4 $272
JUMPV
LABELV $283
line 277
;276:		case MOD_SHOTGUN:
;277:			message = "was gunned down by";
ADDRLP4 40
ADDRGP4 $284
ASGNP4
line 278
;278:			break;
ADDRGP4 $272
JUMPV
LABELV $285
line 280
;279:		case MOD_GRENADE:
;280:			message = "ate";
ADDRLP4 40
ADDRGP4 $286
ASGNP4
line 281
;281:			message2 = "'s grenade";
ADDRLP4 88
ADDRGP4 $287
ASGNP4
line 282
;282:			break;
ADDRGP4 $272
JUMPV
LABELV $288
line 284
;283:		case MOD_GRENADE_SPLASH:
;284:			message = "was shredded by";
ADDRLP4 40
ADDRGP4 $289
ASGNP4
line 285
;285:			message2 = "'s shrapnel";
ADDRLP4 88
ADDRGP4 $290
ASGNP4
line 286
;286:			break;
ADDRGP4 $272
JUMPV
LABELV $291
line 288
;287:		case MOD_ROCKET:
;288:			message = "ate";
ADDRLP4 40
ADDRGP4 $286
ASGNP4
line 289
;289:			message2 = "'s rocket";
ADDRLP4 88
ADDRGP4 $292
ASGNP4
line 290
;290:			break;
ADDRGP4 $272
JUMPV
LABELV $293
line 292
;291:		case MOD_ROCKET_SPLASH:
;292:			message = "almost dodged";
ADDRLP4 40
ADDRGP4 $294
ASGNP4
line 293
;293:			message2 = "'s rocket";
ADDRLP4 88
ADDRGP4 $292
ASGNP4
line 294
;294:			break;
ADDRGP4 $272
JUMPV
LABELV $295
line 296
;295:		case MOD_PLASMA:
;296:			message = "was melted by";
ADDRLP4 40
ADDRGP4 $296
ASGNP4
line 297
;297:			message2 = "'s plasmagun";
ADDRLP4 88
ADDRGP4 $297
ASGNP4
line 298
;298:			break;
ADDRGP4 $272
JUMPV
LABELV $298
line 300
;299:		case MOD_PLASMA_SPLASH:
;300:			message = "was melted by";
ADDRLP4 40
ADDRGP4 $296
ASGNP4
line 301
;301:			message2 = "'s plasmagun";
ADDRLP4 88
ADDRGP4 $297
ASGNP4
line 302
;302:			break;
ADDRGP4 $272
JUMPV
LABELV $299
line 304
;303:		case MOD_RAILGUN:
;304:			message = "was railed by";
ADDRLP4 40
ADDRGP4 $300
ASGNP4
line 305
;305:			break;
ADDRGP4 $272
JUMPV
LABELV $301
line 307
;306:		case MOD_LIGHTNING:
;307:			message = "was electrocuted by";
ADDRLP4 40
ADDRGP4 $302
ASGNP4
line 308
;308:			break;
ADDRGP4 $272
JUMPV
LABELV $303
line 311
;309:		case MOD_BFG:
;310:		case MOD_BFG_SPLASH:
;311:			message = "was blasted by";
ADDRLP4 40
ADDRGP4 $304
ASGNP4
line 312
;312:			message2 = "'s BFG";
ADDRLP4 88
ADDRGP4 $305
ASGNP4
line 313
;313:			break;
ADDRGP4 $272
JUMPV
LABELV $306
line 335
;314:#ifdef MISSIONPACK
;315:		case MOD_NAIL:
;316:			message = "was nailed by";
;317:			break;
;318:		case MOD_CHAINGUN:
;319:			message = "got lead poisoning from";
;320:			message2 = "'s Chaingun";
;321:			break;
;322:		case MOD_PROXIMITY_MINE:
;323:			message = "was too close to";
;324:			message2 = "'s Prox Mine";
;325:			break;
;326:		case MOD_KAMIKAZE:
;327:			message = "falls to";
;328:			message2 = "'s Kamikaze blast";
;329:			break;
;330:		case MOD_JUICED:
;331:			message = "was juiced by";
;332:			break;
;333:#endif
;334:		case MOD_TELEFRAG:
;335:			message = "tried to invade";
ADDRLP4 40
ADDRGP4 $307
ASGNP4
line 336
;336:			message2 = "'s personal space";
ADDRLP4 88
ADDRGP4 $308
ASGNP4
line 337
;337:			break;
ADDRGP4 $272
JUMPV
LABELV $271
line 339
;338:		default:
;339:			message = "was killed by";
ADDRLP4 40
ADDRGP4 $309
ASGNP4
line 340
;340:			break;
LABELV $272
line 343
;341:		}
;342:
;343:		if (message) {
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $312
line 344
;344:			CG_Printf( "%s %s %s%s\n", 
ADDRGP4 $314
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 346
;345:				targetName, message, attackerName, message2);
;346:			return;
ADDRGP4 $159
JUMPV
LABELV $312
line 348
;347:		}
;348:	}
LABELV $269
line 351
;349:
;350:	// we don't know what it was
;351:	CG_Printf( "%s died.\n", targetName );
ADDRGP4 $315
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 352
;352:}
LABELV $159
endproc CG_Obituary 136 20
proc CG_UseItem 32 16
line 361
;353:
;354://==========================================================================
;355:
;356:/*
;357:===============
;358:CG_UseItem
;359:===============
;360:*/
;361:static void CG_UseItem( centity_t *cent ) {
line 367
;362:	clientInfo_t *ci;
;363:	int			itemNum, clientNum;
;364:	gitem_t		*item;
;365:	entityState_t *es;
;366:
;367:	es = &cent->currentState;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
line 369
;368:	
;369:	itemNum = (es->event & ~EV_EVENT_BITS) - EV_USE_ITEM0;
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 -769
BANDI4
CNSTI4 24
SUBI4
ASGNI4
line 370
;370:	if ( itemNum < 0 || itemNum > HI_NUM_HOLDABLE ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $319
ADDRLP4 0
INDIRI4
CNSTI4 6
LEI4 $317
LABELV $319
line 371
;371:		itemNum = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 372
;372:	}
LABELV $317
line 375
;373:
;374:	// print a message if the local player
;375:	if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 4
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $320
line 376
;376:		if ( !itemNum ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $323
line 377
;377:			CG_CenterPrint( "No item to use", SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH );
ADDRGP4 $325
ARGP4
CNSTI4 144
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 378
;378:		} else {
ADDRGP4 $324
JUMPV
LABELV $323
line 379
;379:			item = BG_FindItemForHoldable( itemNum );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 BG_FindItemForHoldable
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 24
INDIRP4
ASGNP4
line 380
;380:			CG_CenterPrint( va("Use %s", item->pickup_name), SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH );
ADDRGP4 $326
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 28
ADDP4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
CNSTI4 144
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 381
;381:		}
LABELV $324
line 382
;382:	}
LABELV $320
line 384
;383:
;384:	switch ( itemNum ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $329
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $328
ADDRLP4 0
INDIRI4
CNSTI4 2
EQI4 $333
ADDRGP4 $327
JUMPV
LABELV $327
LABELV $329
line 387
;385:	default:
;386:	case HI_NONE:
;387:		trap_S_StartSound (NULL, es->number, CHAN_BODY, cgs.media.useNothingSound );
CNSTP4 0
ARGP4
ADDRLP4 4
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+751220+844
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 388
;388:		break;
ADDRGP4 $328
JUMPV
line 391
;389:
;390:	case HI_TELEPORTER:
;391:		break;
LABELV $333
line 394
;392:
;393:	case HI_MEDKIT:
;394:		clientNum = cent->currentState.clientNum;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 395
;395:		if ( clientNum >= 0 && clientNum < MAX_CLIENTS ) {
ADDRLP4 28
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
LTI4 $334
ADDRLP4 28
INDIRI4
CNSTI4 64
GEI4 $334
line 396
;396:			ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 16
ADDRLP4 12
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320
ADDP4
ASGNP4
line 397
;397:			ci->medkitUsageTime = cg.time;
ADDRLP4 16
INDIRP4
CNSTI4 164
ADDP4
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 398
;398:		}
LABELV $334
line 399
;399:		trap_S_StartSound (NULL, es->number, CHAN_BODY, cgs.media.medkitSound );
CNSTP4 0
ARGP4
ADDRLP4 4
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+751220+1364
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 400
;400:		break;
LABELV $328
line 414
;401:
;402:#ifdef MISSIONPACK
;403:	case HI_KAMIKAZE:
;404:		break;
;405:
;406:	case HI_PORTAL:
;407:		break;
;408:	case HI_INVULNERABILITY:
;409:		trap_S_StartSound (NULL, es->number, CHAN_BODY, cgs.media.useInvulnerabilitySound );
;410:		break;
;411:#endif
;412:	}
;413:
;414:}
LABELV $316
endproc CG_UseItem 32 16
proc CG_ItemPickup 0 0
line 423
;415:
;416:/*
;417:================
;418:CG_ItemPickup
;419:
;420:A new item was picked up this frame
;421:================
;422:*/
;423:static void CG_ItemPickup( int itemNum ) {
line 424
;424:	cg.itemPickup = itemNum;
ADDRGP4 cg+127976
ADDRFP4 0
INDIRI4
ASGNI4
line 425
;425:	cg.itemPickupTime = cg.time;
ADDRGP4 cg+127980
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 426
;426:	cg.itemPickupBlendTime = cg.time;
ADDRGP4 cg+127984
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 428
;427:	// see if it should be the grabbed weapon
;428:	if ( bg_itemlist[itemNum].giType == IT_WEAPON ) {
ADDRFP4 0
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist+36
ADDP4
INDIRI4
CNSTI4 1
NEI4 $346
line 430
;429:		// select it immediately
;430:		if ( cg_autoswitch.integer && bg_itemlist[itemNum].giTag != WP_MACHINEGUN ) {
ADDRGP4 cg_autoswitch+12
INDIRI4
CNSTI4 0
EQI4 $349
ADDRFP4 0
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 2
EQI4 $349
line 431
;431:			cg.weaponSelectTime = cg.time;
ADDRGP4 cg+127988
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 432
;432:			cg.weaponSelect = bg_itemlist[itemNum].giTag;
ADDRGP4 cg+109148
ADDRFP4 0
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
ASGNI4
line 433
;433:		}
LABELV $349
line 434
;434:	}
LABELV $346
line 436
;435:
;436:}
LABELV $340
endproc CG_ItemPickup 0 0
export CG_PainEvent
proc CG_PainEvent 12 16
line 446
;437:
;438:
;439:/*
;440:================
;441:CG_PainEvent
;442:
;443:Also called by playerstate transition
;444:================
;445:*/
;446:void CG_PainEvent( centity_t *cent, int health ) {
line 450
;447:	char	*snd;
;448:
;449:	// don't do more than two pain sounds a second
;450:	if ( cg.time - cent->pe.painTime < 500 ) {
ADDRGP4 cg+107656
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 608
ADDP4
INDIRI4
SUBI4
CNSTI4 500
GEI4 $358
line 451
;451:		return;
ADDRGP4 $357
JUMPV
LABELV $358
line 454
;452:	}
;453:
;454:	if ( health < 25 ) {
ADDRFP4 4
INDIRI4
CNSTI4 25
GEI4 $361
line 455
;455:		snd = "*pain25_1.wav";
ADDRLP4 0
ADDRGP4 $363
ASGNP4
line 456
;456:	} else if ( health < 50 ) {
ADDRGP4 $362
JUMPV
LABELV $361
ADDRFP4 4
INDIRI4
CNSTI4 50
GEI4 $364
line 457
;457:		snd = "*pain50_1.wav";
ADDRLP4 0
ADDRGP4 $366
ASGNP4
line 458
;458:	} else if ( health < 75 ) {
ADDRGP4 $365
JUMPV
LABELV $364
ADDRFP4 4
INDIRI4
CNSTI4 75
GEI4 $367
line 459
;459:		snd = "*pain75_1.wav";
ADDRLP4 0
ADDRGP4 $369
ASGNP4
line 460
;460:	} else {
ADDRGP4 $368
JUMPV
LABELV $367
line 461
;461:		snd = "*pain100_1.wav";
ADDRLP4 0
ADDRGP4 $370
ASGNP4
line 462
;462:	}
LABELV $368
LABELV $365
LABELV $362
line 463
;463:	trap_S_StartSound( NULL, cent->currentState.number, CHAN_VOICE, 
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 467
;464:		CG_CustomSound( cent->currentState.number, snd ) );
;465:
;466:	// save pain time for programitic twitch animation
;467:	cent->pe.painTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 608
ADDP4
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 468
;468:	cent->pe.painDirection ^= 1;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 612
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 469
;469:}
LABELV $357
endproc CG_PainEvent 12 16
data
align 4
LABELV $568
byte 4 0
byte 4 0
byte 4 1065353216
export CG_EntityEvent
code
proc CG_EntityEvent 128 48
line 482
;470:
;471:
;472:
;473:/*
;474:==============
;475:CG_EntityEvent
;476:
;477:An entity has an event value
;478:also called by CG_CheckPlayerstateEvents
;479:==============
;480:*/
;481:#define	DEBUGNAME(x) if(cg_debugEvents.integer){CG_Printf(x"\n");}
;482:void CG_EntityEvent( centity_t *cent, vec3_t position ) {
line 490
;483:	entityState_t	*es;
;484:	int				event;
;485:	vec3_t			dir;
;486:	const char		*s;
;487:	int				clientNum;
;488:	clientInfo_t	*ci;
;489:
;490:	es = &cent->currentState;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 491
;491:	event = es->event & ~EV_EVENT_BITS;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 -769
BANDI4
ASGNI4
line 493
;492:
;493:	if ( cg_debugEvents.integer ) {
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $373
line 494
;494:		CG_Printf( "ent:%3i  event:%3i ", es->number, event );
ADDRGP4 $376
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 495
;495:	}
LABELV $373
line 497
;496:
;497:	if ( !event ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $377
line 498
;498:		DEBUGNAME("ZEROEVENT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $372
ADDRGP4 $382
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 499
;499:		return;
ADDRGP4 $372
JUMPV
LABELV $377
line 502
;500:	}
;501:
;502:	clientNum = es->clientNum;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 507
;503:	// JUHOX: accept EXTRA_CLIENTNUMS
;504:#if !MONSTER_MODE
;505:	if ( clientNum < 0 || clientNum >= MAX_CLIENTS ) {
;506:#else
;507:	if (clientNum < 0 || clientNum >= MAX_CLIENTS + EXTRA_CLIENTNUMS) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $385
ADDRLP4 4
INDIRI4
CNSTI4 69
LTI4 $383
LABELV $385
line 509
;508:#endif
;509:		clientNum = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 510
;510:	}
LABELV $383
line 511
;511:	ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 12
ADDRLP4 4
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320
ADDP4
ASGNP4
line 513
;512:
;513:	switch ( event ) {
ADDRLP4 8
INDIRI4
CNSTI4 1
LTI4 $387
ADDRLP4 8
INDIRI4
CNSTI4 95
GTI4 $387
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1285-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1285
address $389
address $405
address $422
address $439
address $452
address $533
address $533
address $533
address $533
address $463
address $485
address $507
address $563
address $575
address $590
address $597
address $604
address $611
address $617
address $635
address $666
address $677
address $684
address $689
address $694
address $699
address $704
address $709
address $714
address $719
address $724
address $729
address $734
address $739
address $744
address $749
address $754
address $759
address $387
address $785
address $778
address $764
address $771
address $793
address $808
address $928
address $937
address $948
address $842
address $837
address $815
address $820
address $825
address $830
address $847
address $387
address $1203
address $1211
address $1211
address $1211
address $1217
address $1222
address $1235
address $1248
address $1261
address $810
address $387
address $387
address $387
address $387
address $387
address $387
address $387
address $387
address $1275
address $1270
address $580
address $387
address $387
address $387
address $387
address $387
address $387
address $1072
address $852
address $1121
address $1138
address $878
address $878
address $878
address $878
address $878
address $1167
address $1175
address $1192
code
LABELV $389
line 518
;514:	//
;515:	// movement generated events
;516:	//
;517:	case EV_FOOTSTEP:
;518:		DEBUGNAME("EV_FOOTSTEP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $390
ADDRGP4 $393
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $390
line 519
;519:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $388
line 520
;520:			trap_S_StartSound (NULL, es->number, CHAN_BODY, 
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 40
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 cgs+751220+852
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 523
;521:				cgs.media.footsteps[ ci->footsteps ][rand()&3] );
;522:#if EARTHQUAKE_SYSTEM	// JUHOX: titan footstep
;523:			if (clientNum == CLIENTNUM_MONSTER_TITAN) {
ADDRLP4 4
INDIRI4
CNSTI4 66
NEI4 $388
line 524
;524:				CG_AddEarthquake(cg_entities[es->number].currentState.pos.trBase, 500, 0.5, 0, 0.5, 200);
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 880
MULI4
ADDRGP4 cg_entities+12+12
ADDP4
ARGP4
CNSTF4 1140457472
ARGF4
CNSTF4 1056964608
ARGF4
CNSTF4 0
ARGF4
CNSTF4 1056964608
ARGF4
CNSTF4 1128792064
ARGF4
ADDRGP4 CG_AddEarthquake
CALLV
pop
line 525
;525:				trap_S_StartSound(NULL, es->number, CHAN_BODY, cgs.media.titanFootstepSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+751220+1244
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 526
;526:			}
line 528
;527:#endif
;528:		}
line 529
;529:		break;
ADDRGP4 $388
JUMPV
LABELV $405
line 531
;530:	case EV_FOOTSTEP_METAL:
;531:		DEBUGNAME("EV_FOOTSTEP_METAL");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $406
ADDRGP4 $409
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $406
line 532
;532:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $388
line 533
;533:			trap_S_StartSound (NULL, es->number, CHAN_BODY, 
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 40
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+751220+852+80
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 536
;534:				cgs.media.footsteps[ FOOTSTEP_METAL ][rand()&3] );
;535:#if EARTHQUAKE_SYSTEM	// JUHOX: titan footstep
;536:			if (clientNum == CLIENTNUM_MONSTER_TITAN) {
ADDRLP4 4
INDIRI4
CNSTI4 66
NEI4 $388
line 537
;537:				CG_AddEarthquake(cg_entities[es->number].currentState.pos.trBase, 500, 0.5, 0, 0.5, 200);
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 880
MULI4
ADDRGP4 cg_entities+12+12
ADDP4
ARGP4
CNSTF4 1140457472
ARGF4
CNSTF4 1056964608
ARGF4
CNSTF4 0
ARGF4
CNSTF4 1056964608
ARGF4
CNSTF4 1128792064
ARGF4
ADDRGP4 CG_AddEarthquake
CALLV
pop
line 538
;538:				trap_S_StartSound(NULL, es->number, CHAN_BODY, cgs.media.titanFootstepSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+751220+1244
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 539
;539:			}
line 541
;540:#endif
;541:		}
line 542
;542:		break;
ADDRGP4 $388
JUMPV
LABELV $422
line 544
;543:	case EV_FOOTSPLASH:
;544:		DEBUGNAME("EV_FOOTSPLASH");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $423
ADDRGP4 $426
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $423
line 545
;545:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $388
line 546
;546:			trap_S_StartSound (NULL, es->number, CHAN_BODY, 
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 40
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+751220+852+96
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 549
;547:				cgs.media.footsteps[ FOOTSTEP_SPLASH ][rand()&3] );
;548:#if EARTHQUAKE_SYSTEM	// JUHOX: titan footstep
;549:			if (clientNum == CLIENTNUM_MONSTER_TITAN) {
ADDRLP4 4
INDIRI4
CNSTI4 66
NEI4 $388
line 550
;550:				CG_AddEarthquake(cg_entities[es->number].currentState.pos.trBase, 500, 0.5, 0, 0.5, 200);
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 880
MULI4
ADDRGP4 cg_entities+12+12
ADDP4
ARGP4
CNSTF4 1140457472
ARGF4
CNSTF4 1056964608
ARGF4
CNSTF4 0
ARGF4
CNSTF4 1056964608
ARGF4
CNSTF4 1128792064
ARGF4
ADDRGP4 CG_AddEarthquake
CALLV
pop
line 551
;551:				trap_S_StartSound(NULL, es->number, CHAN_BODY, cgs.media.titanFootstepSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+751220+1244
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 552
;552:			}
line 554
;553:#endif
;554:		}
line 555
;555:		break;
ADDRGP4 $388
JUMPV
LABELV $439
line 557
;556:	case EV_FOOTWADE:
;557:		DEBUGNAME("EV_FOOTWADE");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $440
ADDRGP4 $443
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $440
line 558
;558:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $388
line 559
;559:			trap_S_StartSound (NULL, es->number, CHAN_BODY, 
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 40
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+751220+852+96
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 561
;560:				cgs.media.footsteps[ FOOTSTEP_SPLASH ][rand()&3] );
;561:				trap_S_StartSound(NULL, es->number, CHAN_BODY, cgs.media.titanFootstepSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+751220+1244
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 562
;562:		}
line 563
;563:		break;
ADDRGP4 $388
JUMPV
LABELV $452
line 565
;564:	case EV_SWIM:
;565:		DEBUGNAME("EV_SWIM");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $453
ADDRGP4 $456
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $453
line 566
;566:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $388
line 567
;567:			trap_S_StartSound (NULL, es->number, CHAN_BODY, 
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 40
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+751220+852+96
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 569
;568:				cgs.media.footsteps[ FOOTSTEP_SPLASH ][rand()&3] );
;569:		}
line 570
;570:		break;
ADDRGP4 $388
JUMPV
LABELV $463
line 574
;571:
;572:
;573:	case EV_FALL_SHORT:
;574:		DEBUGNAME("EV_FALL_SHORT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $464
ADDRGP4 $467
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $464
line 575
;575:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.landSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+751220+1036
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 576
;576:		if ( clientNum == cg.predictedPlayerState.clientNum ) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+107688+140
INDIRI4
NEI4 $470
line 578
;577:			// smooth landing z changes
;578:			cg.landChange = -8;
ADDRGP4 cg+109140
CNSTF4 3238002688
ASGNF4
line 579
;579:			cg.landTime = cg.time;
ADDRGP4 cg+109144
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 580
;580:		}
LABELV $470
line 582
;581:#if EARTHQUAKE_SYSTEM	// JUHOX: titan footstep
;582:		if (clientNum == CLIENTNUM_MONSTER_TITAN) {
ADDRLP4 4
INDIRI4
CNSTI4 66
NEI4 $388
line 583
;583:			CG_AddEarthquake(cg_entities[es->number].currentState.pos.trBase, 700, 0.5, 0, 0.5, 300);
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 880
MULI4
ADDRGP4 cg_entities+12+12
ADDP4
ARGP4
CNSTF4 1143930880
ARGF4
CNSTF4 1056964608
ARGF4
CNSTF4 0
ARGF4
CNSTF4 1056964608
ARGF4
CNSTF4 1133903872
ARGF4
ADDRGP4 CG_AddEarthquake
CALLV
pop
line 584
;584:			trap_S_StartSound(NULL, es->number, CHAN_BODY, cgs.media.titanFootstepSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+751220+1244
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 585
;585:			trap_S_StartSound(NULL, es->number, CHAN_BODY, cgs.media.titanFootstepSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+751220+1244
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 586
;586:		}
line 588
;587:#endif
;588:		break;
ADDRGP4 $388
JUMPV
LABELV $485
line 590
;589:	case EV_FALL_MEDIUM:
;590:		DEBUGNAME("EV_FALL_MEDIUM");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $486
ADDRGP4 $489
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $486
line 592
;591:		// use normal pain sound
;592:		trap_S_StartSound( NULL, es->number, CHAN_VOICE, CG_CustomSound( es->number, "*pain100_1.wav" ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $370
ARGP4
ADDRLP4 40
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 40
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 593
;593:		if ( clientNum == cg.predictedPlayerState.clientNum ) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+107688+140
INDIRI4
NEI4 $490
line 595
;594:			// smooth landing z changes
;595:			cg.landChange = -16;
ADDRGP4 cg+109140
CNSTF4 3246391296
ASGNF4
line 596
;596:			cg.landTime = cg.time;
ADDRGP4 cg+109144
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 597
;597:		}
LABELV $490
line 599
;598:#if EARTHQUAKE_SYSTEM	// JUHOX: titan footstep
;599:		if (clientNum == CLIENTNUM_MONSTER_TITAN) {
ADDRLP4 4
INDIRI4
CNSTI4 66
NEI4 $388
line 600
;600:			CG_AddEarthquake(cg_entities[es->number].currentState.pos.trBase, 800, 0.5, 0, 0.5, 350);
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 880
MULI4
ADDRGP4 cg_entities+12+12
ADDP4
ARGP4
CNSTF4 1145569280
ARGF4
CNSTF4 1056964608
ARGF4
CNSTF4 0
ARGF4
CNSTF4 1056964608
ARGF4
CNSTF4 1135542272
ARGF4
ADDRGP4 CG_AddEarthquake
CALLV
pop
line 601
;601:			trap_S_StartSound(NULL, es->number, CHAN_BODY, cgs.media.titanFootstepSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+751220+1244
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 602
;602:			trap_S_StartSound(NULL, es->number, CHAN_BODY, cgs.media.titanFootstepSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+751220+1244
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 603
;603:			trap_S_StartSound(NULL, es->number, CHAN_BODY, cgs.media.titanFootstepSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+751220+1244
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 604
;604:		}
line 606
;605:#endif
;606:		break;
ADDRGP4 $388
JUMPV
LABELV $507
line 608
;607:	case EV_FALL_FAR:
;608:		DEBUGNAME("EV_FALL_FAR");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $508
ADDRGP4 $511
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $508
line 609
;609:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, CG_CustomSound( es->number, "*fall1.wav" ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $512
ARGP4
ADDRLP4 44
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 610
;610:		cent->pe.painTime = cg.time;	// don't play a pain sound right after this
ADDRFP4 0
INDIRP4
CNSTI4 608
ADDP4
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 611
;611:		if ( clientNum == cg.predictedPlayerState.clientNum ) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+107688+140
INDIRI4
NEI4 $514
line 613
;612:			// smooth landing z changes
;613:			cg.landChange = -24;
ADDRGP4 cg+109140
CNSTF4 3250585600
ASGNF4
line 614
;614:			cg.landTime = cg.time;
ADDRGP4 cg+109144
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 615
;615:		}
LABELV $514
line 617
;616:#if EARTHQUAKE_SYSTEM	// JUHOX: titan footstep
;617:		if (clientNum == CLIENTNUM_MONSTER_TITAN) {
ADDRLP4 4
INDIRI4
CNSTI4 66
NEI4 $388
line 618
;618:			CG_AddEarthquake(cg_entities[es->number].currentState.pos.trBase, 900, 0.5, 0, 0.5, 400);
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 880
MULI4
ADDRGP4 cg_entities+12+12
ADDP4
ARGP4
CNSTF4 1147207680
ARGF4
CNSTF4 1056964608
ARGF4
CNSTF4 0
ARGF4
CNSTF4 1056964608
ARGF4
CNSTF4 1137180672
ARGF4
ADDRGP4 CG_AddEarthquake
CALLV
pop
line 619
;619:			trap_S_StartSound(NULL, es->number, CHAN_BODY, cgs.media.titanFootstepSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+751220+1244
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 620
;620:			trap_S_StartSound(NULL, es->number, CHAN_BODY, cgs.media.titanFootstepSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+751220+1244
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 621
;621:			trap_S_StartSound(NULL, es->number, CHAN_BODY, cgs.media.titanFootstepSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+751220+1244
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 622
;622:			trap_S_StartSound(NULL, es->number, CHAN_BODY, cgs.media.titanFootstepSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+751220+1244
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 623
;623:		}
line 625
;624:#endif
;625:		break;
ADDRGP4 $388
JUMPV
LABELV $533
line 631
;626:
;627:	case EV_STEP_4:
;628:	case EV_STEP_8:
;629:	case EV_STEP_12:
;630:	case EV_STEP_16:		// smooth out step up transitions
;631:		DEBUGNAME("EV_STEP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $534
ADDRGP4 $537
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $534
line 632
;632:	{
line 637
;633:		float	oldStep;
;634:		int		delta;
;635:		int		step;
;636:
;637:		if ( clientNum != cg.predictedPlayerState.clientNum ) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+107688+140
INDIRI4
EQI4 $538
line 638
;638:			break;
ADDRGP4 $388
JUMPV
LABELV $538
line 641
;639:		}
;640:		// if we are interpolating, we don't need to smooth steps
;641:		if ( cg.demoPlayback || (cg.snap->ps.pm_flags & PMF_FOLLOW) ||
ADDRGP4 cg+8
INDIRI4
CNSTI4 0
NEI4 $550
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
NEI4 $550
ADDRGP4 cg_nopredict+12
INDIRI4
CNSTI4 0
NEI4 $550
ADDRGP4 cg_synchronousClients+12
INDIRI4
CNSTI4 0
EQI4 $542
LABELV $550
line 642
;642:			cg_nopredict.integer || cg_synchronousClients.integer ) {
line 643
;643:			break;
ADDRGP4 $388
JUMPV
LABELV $542
line 646
;644:		}
;645:		// check for stepping up before a previous step is completed
;646:		delta = cg.time - cg.stepTime;
ADDRLP4 48
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cg+109128
INDIRI4
SUBI4
ASGNI4
line 647
;647:		if (delta < STEP_TIME) {
ADDRLP4 48
INDIRI4
CNSTI4 200
GEI4 $553
line 648
;648:			oldStep = cg.stepChange * (STEP_TIME - delta) / STEP_TIME;
ADDRLP4 52
ADDRGP4 cg+109124
INDIRF4
CNSTI4 200
ADDRLP4 48
INDIRI4
SUBI4
CVIF4 4
MULF4
CNSTF4 1000593162
MULF4
ASGNF4
line 649
;649:		} else {
ADDRGP4 $554
JUMPV
LABELV $553
line 650
;650:			oldStep = 0;
ADDRLP4 52
CNSTF4 0
ASGNF4
line 651
;651:		}
LABELV $554
line 654
;652:
;653:		// add this amount
;654:		step = 4 * (event - EV_STEP_4 + 1 );
ADDRLP4 56
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
CNSTI4 24
SUBI4
CNSTI4 4
ADDI4
ASGNI4
line 655
;655:		cg.stepChange = oldStep + step;
ADDRGP4 cg+109124
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 656
;656:		if ( cg.stepChange > MAX_STEP_CHANGE ) {
ADDRGP4 cg+109124
INDIRF4
CNSTF4 1107296256
LEF4 $557
line 657
;657:			cg.stepChange = MAX_STEP_CHANGE;
ADDRGP4 cg+109124
CNSTF4 1107296256
ASGNF4
line 658
;658:		}
LABELV $557
line 659
;659:		cg.stepTime = cg.time;
ADDRGP4 cg+109128
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 660
;660:		break;
ADDRGP4 $388
JUMPV
LABELV $563
line 664
;661:	}
;662:
;663:	case EV_JUMP_PAD:
;664:		DEBUGNAME("EV_JUMP_PAD");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $564
ADDRGP4 $567
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $564
line 666
;665://		CG_Printf( "EV_JUMP_PAD w/effect #%i\n", es->eventParm );
;666:		{
line 668
;667:			localEntity_t	*smoke;
;668:			vec3_t			up = {0, 0, 1};
ADDRLP4 48
ADDRGP4 $568
INDIRB
ASGNB 12
line 671
;669:
;670:
;671:			smoke = CG_SmokePuff( cent->lerpOrigin, up, 
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
ARGP4
ADDRLP4 48
ARGP4
CNSTF4 1107296256
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1051260355
ARGF4
CNSTF4 1148846080
ARGF4
ADDRGP4 cg+107656
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 cgs+751220+444
INDIRI4
ARGI4
ADDRLP4 64
ADDRGP4 CG_SmokePuff
CALLP4
ASGNP4
ADDRLP4 60
ADDRLP4 64
INDIRP4
ASGNP4
line 678
;672:						  32, 
;673:						  1, 1, 1, 0.33f,
;674:						  1000, 
;675:						  cg.time, 0,
;676:						  LEF_PUFF_DONT_SCALE, 
;677:						  cgs.media.smokePuffShader );
;678:		}
line 681
;679:
;680:		// boing sound at origin, jump sound on player
;681:		trap_S_StartSound ( cent->lerpOrigin, -1, CHAN_VOICE, cgs.media.jumpPadSound );
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 cgs+751220+1044
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 682
;682:		trap_S_StartSound (NULL, es->number, CHAN_VOICE, CG_CustomSound( es->number, "*jump1.wav" ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $574
ARGP4
ADDRLP4 48
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 683
;683:		break;
ADDRGP4 $388
JUMPV
LABELV $575
line 686
;684:
;685:	case EV_JUMP:
;686:		DEBUGNAME("EV_JUMP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $576
ADDRGP4 $579
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $576
line 687
;687:		trap_S_StartSound (NULL, es->number, CHAN_VOICE, CG_CustomSound( es->number, "*jump1.wav" ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $574
ARGP4
ADDRLP4 52
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 688
;688:		break;
ADDRGP4 $388
JUMPV
LABELV $580
line 690
;689:	case EV_TAUNT:
;690:		DEBUGNAME("EV_TAUNT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $581
ADDRGP4 $584
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $581
line 695
;691:		// JUHOX: guards have special taunt
;692:#if !MONSTER_MODE
;693:		trap_S_StartSound (NULL, es->number, CHAN_VOICE, CG_CustomSound( es->number, "*taunt.wav" ) );
;694:#else
;695:		if (es->clientNum == CLIENTNUM_MONSTER_GUARD) {
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 65
NEI4 $585
line 696
;696:			trap_S_StartSound(NULL, es->number, CHAN_VOICE, cgs.media.guardStartSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 cgs+751220+1140
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 697
;697:		}
ADDRGP4 $388
JUMPV
LABELV $585
line 698
;698:		else {
line 699
;699:			trap_S_StartSound (NULL, es->number, CHAN_VOICE, CG_CustomSound( es->number, "*taunt.wav" ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $589
ARGP4
ADDRLP4 56
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 56
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 700
;700:		}
line 702
;701:#endif
;702:		break;
ADDRGP4 $388
JUMPV
LABELV $590
line 730
;703:#ifdef MISSIONPACK
;704:	case EV_TAUNT_YES:
;705:		DEBUGNAME("EV_TAUNT_YES");
;706:		CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_YES);
;707:		break;
;708:	case EV_TAUNT_NO:
;709:		DEBUGNAME("EV_TAUNT_NO");
;710:		CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_NO);
;711:		break;
;712:	case EV_TAUNT_FOLLOWME:
;713:		DEBUGNAME("EV_TAUNT_FOLLOWME");
;714:		CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_FOLLOWME);
;715:		break;
;716:	case EV_TAUNT_GETFLAG:
;717:		DEBUGNAME("EV_TAUNT_GETFLAG");
;718:		CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_ONGETFLAG);
;719:		break;
;720:	case EV_TAUNT_GUARDBASE:
;721:		DEBUGNAME("EV_TAUNT_GUARDBASE");
;722:		CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_ONDEFENSE);
;723:		break;
;724:	case EV_TAUNT_PATROL:
;725:		DEBUGNAME("EV_TAUNT_PATROL");
;726:		CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_ONPATROL);
;727:		break;
;728:#endif
;729:	case EV_WATER_TOUCH:
;730:		DEBUGNAME("EV_WATER_TOUCH");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $591
ADDRGP4 $594
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $591
line 731
;731:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.watrInSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+751220+1348
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 732
;732:		break;
ADDRGP4 $388
JUMPV
LABELV $597
line 734
;733:	case EV_WATER_LEAVE:
;734:		DEBUGNAME("EV_WATER_LEAVE");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $598
ADDRGP4 $601
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $598
line 735
;735:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.watrOutSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+751220+1352
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 736
;736:		break;
ADDRGP4 $388
JUMPV
LABELV $604
line 738
;737:	case EV_WATER_UNDER:
;738:		DEBUGNAME("EV_WATER_UNDER");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $605
ADDRGP4 $608
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $605
line 739
;739:		trap_S_StartSound (NULL, es->number, /*CHAN_AUTO*/CHAN_VOICE, cgs.media.watrUnSound );	// JUHOX: to stop pant sound
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 cgs+751220+1356
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 740
;740:		break;
ADDRGP4 $388
JUMPV
LABELV $611
line 742
;741:	case EV_WATER_CLEAR:
;742:		DEBUGNAME("EV_WATER_CLEAR");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $612
ADDRGP4 $615
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $612
line 743
;743:		trap_S_StartSound (NULL, es->number, /*CHAN_AUTO*/CHAN_VOICE, CG_CustomSound( es->number, "*gasp.wav" ) );	// JUHOX: to be stoppable by water-under sound
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $616
ARGP4
ADDRLP4 56
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 56
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 744
;744:		break;
ADDRGP4 $388
JUMPV
LABELV $617
line 747
;745:
;746:	case EV_ITEM_PICKUP:
;747:		DEBUGNAME("EV_ITEM_PICKUP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $618
ADDRGP4 $621
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $618
line 748
;748:		{
line 752
;749:			gitem_t	*item;
;750:			int		index;
;751:
;752:			index = es->eventParm;		// player predicted
ADDRLP4 60
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 754
;753:
;754:			if ( index < 1 || index >= bg_numItems ) {
ADDRLP4 68
ADDRLP4 60
INDIRI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 1
LTI4 $624
ADDRLP4 68
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $622
LABELV $624
line 755
;755:				break;
ADDRGP4 $388
JUMPV
LABELV $622
line 757
;756:			}
;757:			item = &bg_itemlist[ index ];
ADDRLP4 64
ADDRLP4 60
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 761
;758:
;759:			// powerups and team items will have a separate global sound, this one
;760:			// will be played at prediction time
;761:			if ( item->giType == IT_POWERUP || item->giType == IT_TEAM) {
ADDRLP4 72
ADDRLP4 64
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 5
EQI4 $627
ADDRLP4 72
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
NEI4 $625
LABELV $627
line 762
;762:				trap_S_StartSound (NULL, es->number, CHAN_AUTO,	cgs.media.n_healthSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+751220+1500
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 763
;763:			} else if (item->giType == IT_PERSISTANT_POWERUP) {
ADDRGP4 $626
JUMPV
LABELV $625
ADDRLP4 64
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 7
NEI4 $630
line 780
;764:#ifdef MISSIONPACK
;765:				switch (item->giTag ) {
;766:					case PW_SCOUT:
;767:						trap_S_StartSound (NULL, es->number, CHAN_AUTO,	cgs.media.scoutSound );
;768:					break;
;769:					case PW_GUARD:
;770:						trap_S_StartSound (NULL, es->number, CHAN_AUTO,	cgs.media.guardSound );
;771:					break;
;772:					case PW_DOUBLER:
;773:						trap_S_StartSound (NULL, es->number, CHAN_AUTO,	cgs.media.doublerSound );
;774:					break;
;775:					case PW_AMMOREGEN:
;776:						trap_S_StartSound (NULL, es->number, CHAN_AUTO,	cgs.media.ammoregenSound );
;777:					break;
;778:				}
;779:#endif
;780:			} else {
ADDRGP4 $631
JUMPV
LABELV $630
line 781
;781:				trap_S_StartSound (NULL, es->number, CHAN_AUTO,	trap_S_RegisterSound( item->pickup_sound, qfalse ) );
ADDRLP4 64
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 76
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 76
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 782
;782:			}
LABELV $631
LABELV $626
line 785
;783:
;784:			// show icon and name on status bar
;785:			if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $388
line 786
;786:				CG_ItemPickup( index );
ADDRLP4 60
INDIRI4
ARGI4
ADDRGP4 CG_ItemPickup
CALLV
pop
line 787
;787:			}
line 788
;788:		}
line 789
;789:		break;
ADDRGP4 $388
JUMPV
LABELV $635
line 792
;790:
;791:	case EV_GLOBAL_ITEM_PICKUP:
;792:		DEBUGNAME("EV_GLOBAL_ITEM_PICKUP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $636
ADDRGP4 $639
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $636
line 793
;793:		{
line 797
;794:			gitem_t	*item;
;795:			int		index;
;796:
;797:			index = es->eventParm;		// player predicted
ADDRLP4 60
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 799
;798:
;799:			if ( index < 1 || index >= bg_numItems ) {
ADDRLP4 68
ADDRLP4 60
INDIRI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 1
LTI4 $642
ADDRLP4 68
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $640
LABELV $642
line 800
;800:				break;
ADDRGP4 $388
JUMPV
LABELV $640
line 802
;801:			}
;802:			item = &bg_itemlist[ index ];
ADDRLP4 64
ADDRLP4 60
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 805
;803:			// powerup pickups are global
;804:#if MONSTER_MODE	// JUHOX: artefact pickup
;805:			if (item->giType == IT_TEAM && item->giTag == PW_QUAD) {
ADDRLP4 72
ADDRLP4 64
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
NEI4 $643
ADDRLP4 72
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 1
NEI4 $643
line 806
;806:				if (es->modelindex) {
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 0
EQI4 $645
line 807
;807:					trap_S_StartLocalSound(cgs.media.lastArtefactSound, CHAN_AUTO);
ADDRGP4 cgs+751220+1136
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 808
;808:					trap_S_StartSound(NULL, cg.snap->ps.clientNum, CHAN_WEAPON, cgs.media.lastArtefactSound);
CNSTP4 0
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 cgs+751220+1136
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 809
;809:				}
LABELV $645
line 810
;810:				cg.earthquakeStartedTime = cg.time;
ADDRGP4 cg+110116
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 811
;811:				cg.earthquakeEndTime = cg.time + 16100;
ADDRGP4 cg+110120
ADDRGP4 cg+107656
INDIRI4
CNSTI4 16100
ADDI4
ASGNI4
line 812
;812:				cg.earthquakeAmplitude = -1;
ADDRGP4 cg+110124
CNSTF4 3212836864
ASGNF4
line 813
;813:				cg.earthquakeSoundCounter = 16;
ADDRGP4 cg+110136
CNSTI4 16
ASGNI4
line 814
;814:				cg.lastEarhquakeSoundStartedTime = cg.time - 1000;
ADDRGP4 cg+110140
ADDRGP4 cg+107656
INDIRI4
CNSTI4 1000
SUBI4
ASGNI4
line 815
;815:			}
ADDRGP4 $644
JUMPV
LABELV $643
line 818
;816:			else
;817:#endif
;818:			if( item->pickup_sound ) {
ADDRLP4 64
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $660
line 819
;819:				trap_S_StartSound (NULL, cg.snap->ps.clientNum, CHAN_AUTO, trap_S_RegisterSound( item->pickup_sound, qfalse ) );
ADDRLP4 64
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 76
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 76
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 820
;820:			}
LABELV $660
LABELV $644
line 823
;821:
;822:			// show icon and name on status bar
;823:			if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $388
line 824
;824:				CG_ItemPickup( index );
ADDRLP4 60
INDIRI4
ARGI4
ADDRGP4 CG_ItemPickup
CALLV
pop
line 825
;825:			}
line 826
;826:		}
line 827
;827:		break;
ADDRGP4 $388
JUMPV
LABELV $666
line 833
;828:
;829:	//
;830:	// weapon events
;831:	//
;832:	case EV_NOAMMO:
;833:		DEBUGNAME("EV_NOAMMO");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $667
ADDRGP4 $670
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $667
line 835
;834://		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.noAmmoSound );
;835:		trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.noAmmoSound);	// JUHOX
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+751220+1024
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 840
;836:		// JUHOX: no out-of-ammo-change with the grapple (special meaning here)
;837:#if 0
;838:		if ( es->number == cg.snap->ps.clientNum ) {
;839:#else
;840:		if (es->number == cg.snap->ps.clientNum && cg.snap->ps.weapon != WP_GRAPPLING_HOOK) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $388
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 10
EQI4 $388
line 842
;841:#endif
;842:			CG_OutOfAmmoChange();
ADDRGP4 CG_OutOfAmmoChange
CALLV
pop
line 843
;843:		}
line 844
;844:		break;
ADDRGP4 $388
JUMPV
LABELV $677
line 846
;845:	case EV_CHANGE_WEAPON:
;846:		DEBUGNAME("EV_CHANGE_WEAPON");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $678
ADDRGP4 $681
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $678
line 847
;847:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.selectSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+751220+840
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 848
;848:		break;
ADDRGP4 $388
JUMPV
LABELV $684
line 850
;849:	case EV_FIRE_WEAPON:
;850:		DEBUGNAME("EV_FIRE_WEAPON");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $685
ADDRGP4 $688
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $685
line 851
;851:		CG_FireWeapon( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_FireWeapon
CALLV
pop
line 852
;852:		break;
ADDRGP4 $388
JUMPV
LABELV $689
line 855
;853:
;854:	case EV_USE_ITEM0:
;855:		DEBUGNAME("EV_USE_ITEM0");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $690
ADDRGP4 $693
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $690
line 856
;856:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 857
;857:		break;
ADDRGP4 $388
JUMPV
LABELV $694
line 859
;858:	case EV_USE_ITEM1:
;859:		DEBUGNAME("EV_USE_ITEM1");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $695
ADDRGP4 $698
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $695
line 860
;860:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 861
;861:		break;
ADDRGP4 $388
JUMPV
LABELV $699
line 863
;862:	case EV_USE_ITEM2:
;863:		DEBUGNAME("EV_USE_ITEM2");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $700
ADDRGP4 $703
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $700
line 864
;864:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 865
;865:		break;
ADDRGP4 $388
JUMPV
LABELV $704
line 867
;866:	case EV_USE_ITEM3:
;867:		DEBUGNAME("EV_USE_ITEM3");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $705
ADDRGP4 $708
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $705
line 868
;868:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 869
;869:		break;
ADDRGP4 $388
JUMPV
LABELV $709
line 871
;870:	case EV_USE_ITEM4:
;871:		DEBUGNAME("EV_USE_ITEM4");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $710
ADDRGP4 $713
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $710
line 872
;872:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 873
;873:		break;
ADDRGP4 $388
JUMPV
LABELV $714
line 875
;874:	case EV_USE_ITEM5:
;875:		DEBUGNAME("EV_USE_ITEM5");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $715
ADDRGP4 $718
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $715
line 876
;876:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 877
;877:		break;
ADDRGP4 $388
JUMPV
LABELV $719
line 879
;878:	case EV_USE_ITEM6:
;879:		DEBUGNAME("EV_USE_ITEM6");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $720
ADDRGP4 $723
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $720
line 880
;880:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 881
;881:		break;
ADDRGP4 $388
JUMPV
LABELV $724
line 883
;882:	case EV_USE_ITEM7:
;883:		DEBUGNAME("EV_USE_ITEM7");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $725
ADDRGP4 $728
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $725
line 884
;884:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 885
;885:		break;
ADDRGP4 $388
JUMPV
LABELV $729
line 887
;886:	case EV_USE_ITEM8:
;887:		DEBUGNAME("EV_USE_ITEM8");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $730
ADDRGP4 $733
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $730
line 888
;888:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 889
;889:		break;
ADDRGP4 $388
JUMPV
LABELV $734
line 891
;890:	case EV_USE_ITEM9:
;891:		DEBUGNAME("EV_USE_ITEM9");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $735
ADDRGP4 $738
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $735
line 892
;892:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 893
;893:		break;
ADDRGP4 $388
JUMPV
LABELV $739
line 895
;894:	case EV_USE_ITEM10:
;895:		DEBUGNAME("EV_USE_ITEM10");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $740
ADDRGP4 $743
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $740
line 896
;896:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 897
;897:		break;
ADDRGP4 $388
JUMPV
LABELV $744
line 899
;898:	case EV_USE_ITEM11:
;899:		DEBUGNAME("EV_USE_ITEM11");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $745
ADDRGP4 $748
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $745
line 900
;900:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 901
;901:		break;
ADDRGP4 $388
JUMPV
LABELV $749
line 903
;902:	case EV_USE_ITEM12:
;903:		DEBUGNAME("EV_USE_ITEM12");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $750
ADDRGP4 $753
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $750
line 904
;904:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 905
;905:		break;
ADDRGP4 $388
JUMPV
LABELV $754
line 907
;906:	case EV_USE_ITEM13:
;907:		DEBUGNAME("EV_USE_ITEM13");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $755
ADDRGP4 $758
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $755
line 908
;908:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 909
;909:		break;
ADDRGP4 $388
JUMPV
LABELV $759
line 911
;910:	case EV_USE_ITEM14:
;911:		DEBUGNAME("EV_USE_ITEM14");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $760
ADDRGP4 $763
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $760
line 912
;912:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 913
;913:		break;
ADDRGP4 $388
JUMPV
LABELV $764
line 921
;914:
;915:	//=================================================================
;916:
;917:	//
;918:	// other events
;919:	//
;920:	case EV_PLAYER_TELEPORT_IN:
;921:		DEBUGNAME("EV_PLAYER_TELEPORT_IN");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $765
ADDRGP4 $768
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $765
line 922
;922:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.teleInSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+751220+1016
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 927
;923:		// JUHOX: only sound for teleport-in effect
;924:#if 0
;925:		CG_SpawnEffect( position);
;926:#endif
;927:		break;
ADDRGP4 $388
JUMPV
LABELV $771
line 930
;928:
;929:	case EV_PLAYER_TELEPORT_OUT:
;930:		DEBUGNAME("EV_PLAYER_TELEPORT_OUT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $772
ADDRGP4 $775
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $772
line 931
;931:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.teleOutSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+751220+1020
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 932
;932:		CG_SpawnEffect(  position);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_SpawnEffect
CALLV
pop
line 933
;933:		break;
ADDRGP4 $388
JUMPV
LABELV $778
line 936
;934:
;935:	case EV_ITEM_POP:
;936:		DEBUGNAME("EV_ITEM_POP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $779
ADDRGP4 $782
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $779
line 937
;937:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.respawnSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+751220+1028
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 938
;938:		break;
ADDRGP4 $388
JUMPV
LABELV $785
line 940
;939:	case EV_ITEM_RESPAWN:
;940:		DEBUGNAME("EV_ITEM_RESPAWN");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $786
ADDRGP4 $789
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $786
line 941
;941:		cent->miscTime = cg.time;	// scale up from this
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 942
;942:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.respawnSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+751220+1028
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 943
;943:		break;
ADDRGP4 $388
JUMPV
LABELV $793
line 946
;944:
;945:	case EV_GRENADE_BOUNCE:
;946:		DEBUGNAME("EV_GRENADE_BOUNCE");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $794
ADDRGP4 $797
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $794
line 949
;947:		// JUHOX: monster launcher seed bounce sound
;948:#if MONSTER_MODE
;949:		if (es->weapon == WP_MONSTER_LAUNCHER) {
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 11
NEI4 $798
line 950
;950:			trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.seedBounceSound[es->eventParm][rand() & 7]);
ADDRLP4 60
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 60
INDIRI4
CNSTI4 7
BANDI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 cgs+751220+1148
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 951
;951:		}
ADDRGP4 $388
JUMPV
LABELV $798
line 954
;952:		else
;953:#endif
;954:		if ( rand() & 1 ) {
ADDRLP4 60
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $802
line 955
;955:			trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.hgrenb1aSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+751220+1504
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 956
;956:		} else {
ADDRGP4 $388
JUMPV
LABELV $802
line 957
;957:			trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.hgrenb2aSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+751220+1508
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 958
;958:		}
line 959
;959:		break;
ADDRGP4 $388
JUMPV
LABELV $808
line 964
;960:
;961:	// JUHOX: cocoon bounce sound
;962:#if MONSTER_MODE
;963:	case EV_COCOON_BOUNCE:
;964:		{
line 967
;965:			int r;
;966:
;967:			r = rand() % 5;
ADDRLP4 68
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 64
ADDRLP4 68
INDIRI4
CNSTI4 5
MODI4
ASGNI4
line 968
;968:			trap_S_StartSound(
ADDRGP4 $809
ARGP4
ADDRLP4 64
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 72
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 72
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 76
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 76
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 974
;969:				NULL, es->number, CHAN_AUTO,
;970:				trap_S_RegisterSound(
;971:					va("sound/cocoon%d.wav", r + 1), qfalse
;972:				)
;973:			);
;974:		}
line 975
;975:		break;
ADDRGP4 $388
JUMPV
LABELV $810
line 1020
;976:#endif
;977:
;978:#ifdef MISSIONPACK
;979:	case EV_PROXIMITY_MINE_STICK:
;980:		DEBUGNAME("EV_PROXIMITY_MINE_STICK");
;981:		if( es->eventParm & SURF_FLESH ) {
;982:			trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.wstbimplSound );
;983:		} else 	if( es->eventParm & SURF_METALSTEPS ) {
;984:			trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.wstbimpmSound );
;985:		} else {
;986:			trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.wstbimpdSound );
;987:		}
;988:		break;
;989:
;990:	case EV_PROXIMITY_MINE_TRIGGER:
;991:		DEBUGNAME("EV_PROXIMITY_MINE_TRIGGER");
;992:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.wstbactvSound );
;993:		break;
;994:	case EV_KAMIKAZE:
;995:		DEBUGNAME("EV_KAMIKAZE");
;996:		CG_KamikazeEffect( cent->lerpOrigin );
;997:		break;
;998:	case EV_OBELISKEXPLODE:
;999:		DEBUGNAME("EV_OBELISKEXPLODE");
;1000:		CG_ObeliskExplode( cent->lerpOrigin, es->eventParm );
;1001:		break;
;1002:	case EV_OBELISKPAIN:
;1003:		DEBUGNAME("EV_OBELISKPAIN");
;1004:		CG_ObeliskPain( cent->lerpOrigin );
;1005:		break;
;1006:	case EV_INVUL_IMPACT:
;1007:		DEBUGNAME("EV_INVUL_IMPACT");
;1008:		CG_InvulnerabilityImpact( cent->lerpOrigin, cent->currentState.angles );
;1009:		break;
;1010:	case EV_JUICED:
;1011:		DEBUGNAME("EV_JUICED");
;1012:		CG_InvulnerabilityJuiced( cent->lerpOrigin );
;1013:		break;
;1014:	case EV_LIGHTNINGBOLT:
;1015:		DEBUGNAME("EV_LIGHTNINGBOLT");
;1016:		CG_LightningBoltBeam(es->origin2, es->pos.trBase);
;1017:		break;
;1018:#endif
;1019:	case EV_SCOREPLUM:
;1020:		DEBUGNAME("EV_SCOREPLUM");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $811
ADDRGP4 $814
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $811
line 1021
;1021:		CG_ScorePlum( cent->currentState.otherEntityNum, cent->lerpOrigin, cent->currentState.time );
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 64
INDIRP4
CNSTI4 728
ADDP4
ARGP4
ADDRLP4 64
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_ScorePlum
CALLV
pop
line 1022
;1022:		break;
ADDRGP4 $388
JUMPV
LABELV $815
line 1028
;1023:
;1024:	//
;1025:	// missile impacts
;1026:	//
;1027:	case EV_MISSILE_HIT:
;1028:		DEBUGNAME("EV_MISSILE_HIT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $816
ADDRGP4 $819
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $816
line 1029
;1029:		ByteToDir( es->eventParm, dir );
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 1030
;1030:		CG_MissileHitPlayer( es->weapon, position, dir, es->otherEntityNum );
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_MissileHitPlayer
CALLV
pop
line 1031
;1031:		break;
ADDRGP4 $388
JUMPV
LABELV $820
line 1034
;1032:
;1033:	case EV_MISSILE_MISS:
;1034:		DEBUGNAME("EV_MISSILE_MISS");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $821
ADDRGP4 $824
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $821
line 1035
;1035:		ByteToDir( es->eventParm, dir );
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 1036
;1036:		CG_MissileHitWall( es->weapon, 0, position, dir, IMPACTSOUND_DEFAULT );
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 CG_MissileHitWall
CALLV
pop
line 1037
;1037:		break;
ADDRGP4 $388
JUMPV
LABELV $825
line 1040
;1038:
;1039:	case EV_MISSILE_MISS_METAL:
;1040:		DEBUGNAME("EV_MISSILE_MISS_METAL");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $826
ADDRGP4 $829
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $826
line 1041
;1041:		ByteToDir( es->eventParm, dir );
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 1042
;1042:		CG_MissileHitWall( es->weapon, 0, position, dir, IMPACTSOUND_METAL );
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 CG_MissileHitWall
CALLV
pop
line 1043
;1043:		break;
ADDRGP4 $388
JUMPV
LABELV $830
line 1046
;1044:
;1045:	case EV_RAILTRAIL:
;1046:		DEBUGNAME("EV_RAILTRAIL");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $831
ADDRGP4 $834
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $831
line 1047
;1047:		cent->currentState.weapon = WP_RAILGUN;
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 7
ASGNI4
line 1049
;1048:		// if the end was on a nomark surface, don't make an explosion
;1049:		CG_RailTrail( ci, es->origin2, es->pos.trBase );
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRGP4 CG_RailTrail
CALLV
pop
line 1050
;1050:		if ( es->eventParm != 255 ) {
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 255
EQI4 $388
line 1051
;1051:			ByteToDir( es->eventParm, dir );
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 1052
;1052:			CG_MissileHitWall( es->weapon, es->clientNum, position, dir, IMPACTSOUND_DEFAULT );
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 CG_MissileHitWall
CALLV
pop
line 1053
;1053:		}
line 1054
;1054:		break;
ADDRGP4 $388
JUMPV
LABELV $837
line 1057
;1055:
;1056:	case EV_BULLET_HIT_WALL:
;1057:		DEBUGNAME("EV_BULLET_HIT_WALL");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $838
ADDRGP4 $841
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $838
line 1058
;1058:		ByteToDir( es->eventParm, dir );
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 1059
;1059:		CG_Bullet( es->pos.trBase, es->otherEntityNum, dir, qfalse, ENTITYNUM_WORLD );
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1022
ARGI4
ADDRGP4 CG_Bullet
CALLV
pop
line 1060
;1060:		break;
ADDRGP4 $388
JUMPV
LABELV $842
line 1063
;1061:
;1062:	case EV_BULLET_HIT_FLESH:
;1063:		DEBUGNAME("EV_BULLET_HIT_FLESH");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $843
ADDRGP4 $846
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $843
line 1068
;1064:		// JUHOX: eventParm sometimes doesn't work, so we use otherEntityNum2
;1065:#if !MONSTER_MODE
;1066:		CG_Bullet( es->pos.trBase, es->otherEntityNum, dir, qtrue, es->eventParm );
;1067:#else
;1068:		CG_Bullet( es->pos.trBase, es->otherEntityNum, dir, qtrue, es->otherEntityNum2);
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Bullet
CALLV
pop
line 1070
;1069:#endif
;1070:		break;
ADDRGP4 $388
JUMPV
LABELV $847
line 1073
;1071:
;1072:	case EV_SHOTGUN:
;1073:		DEBUGNAME("EV_SHOTGUN");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $848
ADDRGP4 $851
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $848
line 1074
;1074:		CG_ShotgunFire( es );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_ShotgunFire
CALLV
pop
line 1075
;1075:		break;
ADDRGP4 $388
JUMPV
LABELV $852
line 1080
;1076:
;1077:	// JUHOX: play short circuit discharge flash sound
;1078:#if 1
;1079:	case EV_DISCHARGE_FLASH:
;1080:		DEBUGNAME("EV_DISCHARGE_FLASH");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $853
ADDRGP4 $856
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $853
line 1082
;1081:		if (
;1082:			es->otherEntityNum >= 0 && es->otherEntityNum < ENTITYNUM_MAX_NORMAL &&
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
CNSTI4 0
LTI4 $857
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
CNSTI4 1022
GEI4 $857
ADDRLP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 0
LTI4 $857
ADDRLP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 1022
GEI4 $857
line 1084
;1083:			es->otherEntityNum2 >= 0 && es->otherEntityNum2 < ENTITYNUM_MAX_NORMAL
;1084:		) {
line 1085
;1085:			CG_Draw3DLine(
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
CNSTI4 880
MULI4
ADDRGP4 cg_entities+728
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 880
MULI4
ADDRGP4 cg_entities+728
ADDP4
ARGP4
ADDRGP4 cgs+751220+260
INDIRI4
ARGI4
ADDRGP4 CG_Draw3DLine
CALLV
pop
line 1090
;1086:				cg_entities[es->otherEntityNum].lerpOrigin,
;1087:				cg_entities[es->otherEntityNum2].lerpOrigin,
;1088:				cgs.media.dischargeFlashShader
;1089:			);
;1090:			trap_S_StartSound(es->pos.trBase, ENTITYNUM_NONE, CHAN_AUTO, cgs.media.dischargeFlashSound);
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+751220+1064
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 1092
;1091:
;1092:			cg_entities[es->otherEntityNum].dischargeTime = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
CNSTI4 880
MULI4
ADDRGP4 cg_entities+752
ADDP4
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 1093
;1093:			cg_entities[es->otherEntityNum2].dischargeTime = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 880
MULI4
ADDRGP4 cg_entities+752
ADDP4
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 1094
;1094:		}
ADDRGP4 $388
JUMPV
LABELV $857
line 1095
;1095:		else {
line 1096
;1096:			trap_S_StartLocalSound(cgs.media.dischargeFlashSound, CHAN_AUTO);
ADDRGP4 cgs+751220+1064
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 1098
;1097:#if MONSTER_MODE
;1098:			if (cgs.gametype == GT_STU) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 8
NEI4 $388
line 1100
;1099:				// Maybe I should better create a new event. But I'm too lazy.
;1100:				cg.endPhaseTime = cg.time;
ADDRGP4 cg+112452
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 1101
;1101:				cg.endPhaseLastDischargeSoundTime = cg.time;
ADDRGP4 cg+112456
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 1102
;1102:			}
line 1104
;1103:#endif
;1104:		}
line 1105
;1105:		break;
ADDRGP4 $388
JUMPV
LABELV $878
line 1115
;1106:#endif
;1107:
;1108:	// JUHOX: display nav aid
;1109:#if 1
;1110:	case EV_NAVAID0:
;1111:	case EV_NAVAID1:
;1112:	case EV_NAVAID2:
;1113:	case EV_NAVAID3:
;1114:	case EV_NAVAID4:
;1115:		DEBUGNAME("EV_NAVAID");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $879
ADDRGP4 $882
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $879
line 1116
;1116:		if (es->time >= cg.navAidLatestUpdateTime) {
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ADDRGP4 cg+162912
INDIRI4
LTI4 $388
line 1120
;1117:			int packet;
;1118:			int i, n;
;1119:
;1120:			packet = event - EV_NAVAID0;
ADDRLP4 92
ADDRLP4 8
INDIRI4
CNSTI4 88
SUBI4
ASGNI4
line 1121
;1121:			if (es->time > cg.navAidLatestUpdateTime) {
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ADDRGP4 cg+162912
INDIRI4
LEI4 $886
line 1122
;1122:				cg.navAidLatestUpdateTime = es->time;
ADDRGP4 cg+162912
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ASGNI4
line 1123
;1123:				cg.navAidGoalEntityNum = es->otherEntityNum;
ADDRGP4 cg+163456
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 1124
;1124:				cg.navAidRetreat = es->otherEntityNum2;
ADDRGP4 cg+162916
ADDRLP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ASGNI4
line 1125
;1125:				if (packet != 0) cg.navAidGoalAvailable = qfalse;
ADDRLP4 92
INDIRI4
CNSTI4 0
EQI4 $892
ADDRGP4 cg+163452
CNSTI4 0
ASGNI4
LABELV $892
line 1126
;1126:			}
LABELV $886
line 1127
;1127:			if (packet == 0) {
ADDRLP4 92
INDIRI4
CNSTI4 0
NEI4 $895
line 1128
;1128:				VectorCopy(es->pos.trDelta, cg.navAidGoal);
ADDRGP4 cg+163440
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRB
ASGNB 12
line 1129
;1129:				cg.navAidGoalAvailable = qtrue;
ADDRGP4 cg+163452
CNSTI4 1
ASGNI4
line 1130
;1130:			}
LABELV $895
line 1131
;1131:			n = 0;
ADDRLP4 96
CNSTI4 0
ASGNI4
line 1132
;1132:			for (i = 0; i < es->time2; i++) {
ADDRLP4 88
CNSTI4 0
ASGNI4
ADDRGP4 $902
JUMPV
LABELV $899
line 1133
;1133:				if (packet == 0 && i == 1) continue;
ADDRLP4 92
INDIRI4
CNSTI4 0
NEI4 $903
ADDRLP4 88
INDIRI4
CNSTI4 1
NEI4 $903
ADDRGP4 $900
JUMPV
LABELV $903
line 1135
;1134:
;1135:				switch (i) {
ADDRLP4 100
ADDRLP4 88
INDIRI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 0
LTI4 $905
ADDRLP4 100
INDIRI4
CNSTI4 7
GTI4 $905
ADDRLP4 100
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $923
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $923
address $907
address $909
address $911
address $913
address $915
address $917
address $919
address $921
code
LABELV $907
line 1137
;1136:				case 0:
;1137:					VectorCopy(es->pos.trBase, cg.navAidPacketPos[packet][n]);
ADDRLP4 96
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 92
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 cg+162960
ADDP4
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 1138
;1138:					break;
ADDRGP4 $906
JUMPV
LABELV $909
line 1140
;1139:				case 1:
;1140:					VectorCopy(es->pos.trDelta, cg.navAidPacketPos[packet][n]);
ADDRLP4 96
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 92
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 cg+162960
ADDP4
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRB
ASGNB 12
line 1141
;1141:					break;
ADDRGP4 $906
JUMPV
LABELV $911
line 1143
;1142:				case 2:
;1143:					VectorCopy(es->apos.trBase, cg.navAidPacketPos[packet][n]);
ADDRLP4 96
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 92
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 cg+162960
ADDP4
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRB
ASGNB 12
line 1144
;1144:					break;
ADDRGP4 $906
JUMPV
LABELV $913
line 1146
;1145:				case 3:
;1146:					VectorCopy(es->apos.trDelta, cg.navAidPacketPos[packet][n]);
ADDRLP4 96
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 92
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 cg+162960
ADDP4
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRB
ASGNB 12
line 1147
;1147:					break;
ADDRGP4 $906
JUMPV
LABELV $915
line 1149
;1148:				case 4:
;1149:					VectorCopy(es->origin, cg.navAidPacketPos[packet][n]);
ADDRLP4 96
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 92
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 cg+162960
ADDP4
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 1150
;1150:					break;
ADDRGP4 $906
JUMPV
LABELV $917
line 1152
;1151:				case 5:
;1152:					VectorCopy(es->origin2, cg.navAidPacketPos[packet][n]);
ADDRLP4 96
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 92
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 cg+162960
ADDP4
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
INDIRB
ASGNB 12
line 1153
;1153:					break;
ADDRGP4 $906
JUMPV
LABELV $919
line 1155
;1154:				case 6:
;1155:					VectorCopy(es->angles, cg.navAidPacketPos[packet][n]);
ADDRLP4 96
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 92
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 cg+162960
ADDP4
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 1156
;1156:					break;
ADDRGP4 $906
JUMPV
LABELV $921
line 1158
;1157:				case 7:
;1158:					VectorCopy(es->angles2, cg.navAidPacketPos[packet][n]);
ADDRLP4 96
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 92
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 cg+162960
ADDP4
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 128
ADDP4
INDIRB
ASGNB 12
line 1159
;1159:					break;
LABELV $905
LABELV $906
line 1161
;1160:				}
;1161:				n++;
ADDRLP4 96
ADDRLP4 96
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1162
;1162:			}
LABELV $900
line 1132
ADDRLP4 88
ADDRLP4 88
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $902
ADDRLP4 88
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
LTI4 $899
line 1163
;1163:			cg.navAidPacketTime[packet] = es->time;
ADDRLP4 92
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+162920
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ASGNI4
line 1164
;1164:			cg.navAidPacketNumPos[packet] = n;
ADDRLP4 92
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+162940
ADDP4
ADDRLP4 96
INDIRI4
ASGNI4
line 1165
;1165:			cg.navAidStopTime = cg.time + 3000;
ADDRGP4 cg+162908
ADDRGP4 cg+107656
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 1166
;1166:		}
line 1167
;1167:		break;
ADDRGP4 $388
JUMPV
LABELV $928
line 1171
;1168:#endif
;1169:
;1170:	case EV_GENERAL_SOUND:
;1171:		DEBUGNAME("EV_GENERAL_SOUND");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $929
ADDRGP4 $932
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $929
line 1172
;1172:		if ( cgs.gameSounds[ es->eventParm ] ) {
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+36172
ADDP4
INDIRI4
CNSTI4 0
EQI4 $933
line 1173
;1173:			trap_S_StartSound (NULL, es->number, CHAN_VOICE, cgs.gameSounds[ es->eventParm ] );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+36172
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 1174
;1174:		} else {
ADDRGP4 $388
JUMPV
LABELV $933
line 1175
;1175:			s = CG_ConfigString( CS_SOUNDS + es->eventParm );
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 288
ADDI4
ARGI4
ADDRLP4 88
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 28
ADDRLP4 88
INDIRP4
ASGNP4
line 1176
;1176:			trap_S_StartSound (NULL, es->number, CHAN_VOICE, CG_CustomSound( es->number, s ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 92
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 92
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 1177
;1177:		}
line 1178
;1178:		break;
ADDRGP4 $388
JUMPV
LABELV $937
line 1181
;1179:
;1180:	case EV_GLOBAL_SOUND:	// play from the player's head so it never diminishes
;1181:		DEBUGNAME("EV_GLOBAL_SOUND");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $938
ADDRGP4 $941
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $938
line 1182
;1182:		if ( cgs.gameSounds[ es->eventParm ] ) {
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+36172
ADDP4
INDIRI4
CNSTI4 0
EQI4 $942
line 1183
;1183:			trap_S_StartSound (NULL, cg.snap->ps.clientNum, CHAN_AUTO, cgs.gameSounds[ es->eventParm ] );
CNSTP4 0
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+36172
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 1184
;1184:		} else {
ADDRGP4 $388
JUMPV
LABELV $942
line 1185
;1185:			s = CG_ConfigString( CS_SOUNDS + es->eventParm );
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 288
ADDI4
ARGI4
ADDRLP4 88
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 28
ADDRLP4 88
INDIRP4
ASGNP4
line 1186
;1186:			trap_S_StartSound (NULL, cg.snap->ps.clientNum, CHAN_AUTO, CG_CustomSound( es->number, s ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 92
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 92
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 1187
;1187:		}
line 1188
;1188:		break;
ADDRGP4 $388
JUMPV
LABELV $948
line 1191
;1189:
;1190:	case EV_GLOBAL_TEAM_SOUND:	// play from the player's head so it never diminishes
;1191:		{
line 1192
;1192:			DEBUGNAME("EV_GLOBAL_TEAM_SOUND");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $949
ADDRGP4 $952
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $949
line 1193
;1193:			switch( es->eventParm ) {
ADDRLP4 88
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 0
LTI4 $388
ADDRLP4 88
INDIRI4
CNSTI4 12
GTI4 $388
ADDRLP4 88
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1071
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1071
address $956
address $966
address $976
address $988
address $1000
address $1020
address $1040
address $1048
address $1056
address $1059
address $1062
address $1065
address $1068
code
LABELV $956
line 1195
;1194:				case GTS_RED_CAPTURE: // CTF: red team captured the blue flag, 1FCTF: red team captured the neutral flag
;1195:					if ( cgs.clientinfo[cg.clientNum].team == TEAM_RED )
ADDRGP4 cg+4
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320+68
ADDP4
INDIRI4
CNSTI4 1
NEI4 $957
line 1196
;1196:						CG_AddBufferedSound( cgs.media.captureYourTeamSound );
ADDRGP4 cgs+751220+1396
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $388
JUMPV
LABELV $957
line 1198
;1197:					else
;1198:						CG_AddBufferedSound( cgs.media.captureOpponentSound );
ADDRGP4 cgs+751220+1400
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1199
;1199:					break;
ADDRGP4 $388
JUMPV
LABELV $966
line 1201
;1200:				case GTS_BLUE_CAPTURE: // CTF: blue team captured the red flag, 1FCTF: blue team captured the neutral flag
;1201:					if ( cgs.clientinfo[cg.clientNum].team == TEAM_BLUE )
ADDRGP4 cg+4
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320+68
ADDP4
INDIRI4
CNSTI4 2
NEI4 $967
line 1202
;1202:						CG_AddBufferedSound( cgs.media.captureYourTeamSound );
ADDRGP4 cgs+751220+1396
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $388
JUMPV
LABELV $967
line 1204
;1203:					else
;1204:						CG_AddBufferedSound( cgs.media.captureOpponentSound );
ADDRGP4 cgs+751220+1400
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1205
;1205:					break;
ADDRGP4 $388
JUMPV
LABELV $976
line 1207
;1206:				case GTS_RED_RETURN: // CTF: blue flag returned, 1FCTF: never used
;1207:					if ( cgs.clientinfo[cg.clientNum].team == TEAM_RED )
ADDRGP4 cg+4
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320+68
ADDP4
INDIRI4
CNSTI4 1
NEI4 $977
line 1208
;1208:						CG_AddBufferedSound( cgs.media.returnYourTeamSound );
ADDRGP4 cgs+751220+1404
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $978
JUMPV
LABELV $977
line 1210
;1209:					else
;1210:						CG_AddBufferedSound( cgs.media.returnOpponentSound );
ADDRGP4 cgs+751220+1408
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
LABELV $978
line 1212
;1211:					//
;1212:					CG_AddBufferedSound( cgs.media.blueFlagReturnedSound );
ADDRGP4 cgs+751220+1424
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1213
;1213:					break;
ADDRGP4 $388
JUMPV
LABELV $988
line 1215
;1214:				case GTS_BLUE_RETURN: // CTF red flag returned, 1FCTF: neutral flag returned
;1215:					if ( cgs.clientinfo[cg.clientNum].team == TEAM_BLUE )
ADDRGP4 cg+4
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320+68
ADDP4
INDIRI4
CNSTI4 2
NEI4 $989
line 1216
;1216:						CG_AddBufferedSound( cgs.media.returnYourTeamSound );
ADDRGP4 cgs+751220+1404
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $990
JUMPV
LABELV $989
line 1218
;1217:					else
;1218:						CG_AddBufferedSound( cgs.media.returnOpponentSound );
ADDRGP4 cgs+751220+1408
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
LABELV $990
line 1220
;1219:					//
;1220:					CG_AddBufferedSound( cgs.media.redFlagReturnedSound );
ADDRGP4 cgs+751220+1420
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1221
;1221:					break;
ADDRGP4 $388
JUMPV
LABELV $1000
line 1225
;1222:
;1223:				case GTS_RED_TAKEN: // CTF: red team took blue flag, 1FCTF: blue team took the neutral flag
;1224:					// if this player picked up the flag then a sound is played in CG_CheckLocalSounds
;1225:					if (cg.snap->ps.powerups[PW_BLUEFLAG] || cg.snap->ps.powerups[PW_NEUTRALFLAG]) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1005
ADDRGP4 cg+36
INDIRP4
CNSTI4 392
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1001
LABELV $1005
line 1226
;1226:					}
ADDRGP4 $388
JUMPV
LABELV $1001
line 1227
;1227:					else {
line 1228
;1228:					if (cgs.clientinfo[cg.clientNum].team == TEAM_BLUE) {
ADDRGP4 cg+4
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320+68
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1006
line 1234
;1229:#ifdef MISSIONPACK
;1230:							if (cgs.gametype == GT_1FCTF) 
;1231:								CG_AddBufferedSound( cgs.media.yourTeamTookTheFlagSound );
;1232:							else
;1233:#endif
;1234:						 	CG_AddBufferedSound( cgs.media.enemyTookYourFlagSound );
ADDRGP4 cgs+751220+1432
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1235
;1235:						}
ADDRGP4 $388
JUMPV
LABELV $1006
line 1236
;1236:						else if (cgs.clientinfo[cg.clientNum].team == TEAM_RED) {
ADDRGP4 cg+4
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320+68
ADDP4
INDIRI4
CNSTI4 1
NEI4 $388
line 1242
;1237:#ifdef MISSIONPACK
;1238:							if (cgs.gametype == GT_1FCTF)
;1239:								CG_AddBufferedSound( cgs.media.enemyTookTheFlagSound );
;1240:							else
;1241:#endif
;1242: 							CG_AddBufferedSound( cgs.media.yourTeamTookEnemyFlagSound );
ADDRGP4 cgs+751220+1440
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1243
;1243:						}
line 1244
;1244:					}
line 1245
;1245:					break;
ADDRGP4 $388
JUMPV
LABELV $1020
line 1248
;1246:				case GTS_BLUE_TAKEN: // CTF: blue team took the red flag, 1FCTF red team took the neutral flag
;1247:					// if this player picked up the flag then a sound is played in CG_CheckLocalSounds
;1248:					if (cg.snap->ps.powerups[PW_REDFLAG] || cg.snap->ps.powerups[PW_NEUTRALFLAG]) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1025
ADDRGP4 cg+36
INDIRP4
CNSTI4 392
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1021
LABELV $1025
line 1249
;1249:					}
ADDRGP4 $388
JUMPV
LABELV $1021
line 1250
;1250:					else {
line 1251
;1251:						if (cgs.clientinfo[cg.clientNum].team == TEAM_RED) {
ADDRGP4 cg+4
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320+68
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1026
line 1257
;1252:#ifdef MISSIONPACK
;1253:							if (cgs.gametype == GT_1FCTF)
;1254:								CG_AddBufferedSound( cgs.media.yourTeamTookTheFlagSound );
;1255:							else
;1256:#endif
;1257:							CG_AddBufferedSound( cgs.media.enemyTookYourFlagSound );
ADDRGP4 cgs+751220+1432
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1258
;1258:						}
ADDRGP4 $388
JUMPV
LABELV $1026
line 1259
;1259:						else if (cgs.clientinfo[cg.clientNum].team == TEAM_BLUE) {
ADDRGP4 cg+4
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320+68
ADDP4
INDIRI4
CNSTI4 2
NEI4 $388
line 1265
;1260:#ifdef MISSIONPACK
;1261:							if (cgs.gametype == GT_1FCTF)
;1262:								CG_AddBufferedSound( cgs.media.enemyTookTheFlagSound );
;1263:							else
;1264:#endif
;1265:							CG_AddBufferedSound( cgs.media.yourTeamTookEnemyFlagSound );
ADDRGP4 cgs+751220+1440
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1266
;1266:						}
line 1267
;1267:					}
line 1268
;1268:					break;
ADDRGP4 $388
JUMPV
LABELV $1040
line 1270
;1269:				case GTS_REDOBELISK_ATTACKED: // Overload: red obelisk is being attacked
;1270:					if (cgs.clientinfo[cg.clientNum].team == TEAM_RED) {
ADDRGP4 cg+4
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320+68
ADDP4
INDIRI4
CNSTI4 1
NEI4 $388
line 1271
;1271:						CG_AddBufferedSound( cgs.media.yourBaseIsUnderAttackSound );
ADDRGP4 cgs+751220+1452
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1272
;1272:					}
line 1273
;1273:					break;
ADDRGP4 $388
JUMPV
LABELV $1048
line 1275
;1274:				case GTS_BLUEOBELISK_ATTACKED: // Overload: blue obelisk is being attacked
;1275:					if (cgs.clientinfo[cg.clientNum].team == TEAM_BLUE) {
ADDRGP4 cg+4
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320+68
ADDP4
INDIRI4
CNSTI4 2
NEI4 $388
line 1276
;1276:						CG_AddBufferedSound( cgs.media.yourBaseIsUnderAttackSound );
ADDRGP4 cgs+751220+1452
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1277
;1277:					}
line 1278
;1278:					break;
ADDRGP4 $388
JUMPV
LABELV $1056
line 1281
;1279:
;1280:				case GTS_REDTEAM_SCORED:
;1281:					CG_AddBufferedSound(cgs.media.redScoredSound);
ADDRGP4 cgs+751220+1376
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1282
;1282:					break;
ADDRGP4 $388
JUMPV
LABELV $1059
line 1284
;1283:				case GTS_BLUETEAM_SCORED:
;1284:					CG_AddBufferedSound(cgs.media.blueScoredSound);
ADDRGP4 cgs+751220+1380
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1285
;1285:					break;
ADDRGP4 $388
JUMPV
LABELV $1062
line 1287
;1286:				case GTS_REDTEAM_TOOK_LEAD:
;1287:					CG_AddBufferedSound(cgs.media.redLeadsSound);
ADDRGP4 cgs+751220+1384
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1288
;1288:					break;
ADDRGP4 $388
JUMPV
LABELV $1065
line 1290
;1289:				case GTS_BLUETEAM_TOOK_LEAD:
;1290:					CG_AddBufferedSound(cgs.media.blueLeadsSound);
ADDRGP4 cgs+751220+1388
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1291
;1291:					break;
ADDRGP4 $388
JUMPV
LABELV $1068
line 1293
;1292:				case GTS_TEAMS_ARE_TIED:
;1293:					CG_AddBufferedSound( cgs.media.teamsTiedSound );
ADDRGP4 cgs+751220+1392
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1294
;1294:					break;
line 1301
;1295:#ifdef MISSIONPACK
;1296:				case GTS_KAMIKAZE:
;1297:					trap_S_StartLocalSound(cgs.media.kamikazeFarSound, CHAN_ANNOUNCER);
;1298:					break;
;1299:#endif
;1300:				default:
;1301:					break;
line 1303
;1302:			}
;1303:			break;
ADDRGP4 $388
JUMPV
LABELV $1072
line 1309
;1304:		}
;1305:
;1306:	// JUHOX: handle overkill event
;1307:#if 1
;1308:	case EV_OVERKILL:
;1309:		DEBUGNAME("EV_OVERKILL");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1073
ADDRGP4 $1076
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1073
line 1310
;1310:		if (cgs.gametype < GT_TEAM) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
GEI4 $1077
line 1311
;1311:			if (cg.snap->ps.clientNum == es->otherEntityNum) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
NEI4 $1080
line 1312
;1312:				trap_S_StartLocalSound(cgs.media.overkillSound, CHAN_ANNOUNCER);
ADDRGP4 cgs+751220+1048
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 1313
;1313:				CG_CenterPrint("Last Man Standing!", 110, GIANT_WIDTH);
ADDRGP4 $1085
ARGP4
CNSTI4 110
ARGI4
CNSTI4 32
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 1314
;1314:			}
ADDRGP4 $388
JUMPV
LABELV $1080
line 1315
;1315:			else {
line 1316
;1316:				trap_S_StartLocalSound(cgs.media.exterminatedSound, CHAN_ANNOUNCER);
ADDRGP4 cgs+751220+1052
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 1317
;1317:				CG_CenterPrint("Extermination", 110, GIANT_WIDTH);
ADDRGP4 $1088
ARGP4
CNSTI4 110
ARGI4
CNSTI4 32
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 1318
;1318:			}
line 1319
;1319:		}
ADDRGP4 $388
JUMPV
LABELV $1077
line 1320
;1320:		else if (cg.snap->ps.persistant[PERS_TEAM] == ci->team) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
NEI4 $1089
line 1321
;1321:			if (cg.snap->ps.clientNum == es->otherEntityNum || es->otherEntityNum == ENTITYNUM_WORLD) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
EQI4 $1095
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
CNSTI4 1022
NEI4 $1092
LABELV $1095
line 1322
;1322:				trap_S_StartLocalSound(cgs.media.exterminatedSound, CHAN_ANNOUNCER);
ADDRGP4 cgs+751220+1052
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 1323
;1323:				CG_CenterPrint("Self-Extermination\nPenalty", 110, GIANT_WIDTH);
ADDRGP4 $1098
ARGP4
CNSTI4 110
ARGI4
CNSTI4 32
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 1324
;1324:			}
ADDRGP4 $388
JUMPV
LABELV $1092
line 1325
;1325:			else if (es->otherEntityNum == ENTITYNUM_NONE) {
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
CNSTI4 1023
NEI4 $1099
line 1326
;1326:				trap_S_StartLocalSound(cgs.media.exterminatedSound, CHAN_ANNOUNCER);
ADDRGP4 cgs+751220+1052
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 1327
;1327:				CG_CenterPrint("Capitulation", 110, GIANT_WIDTH);
ADDRGP4 $1103
ARGP4
CNSTI4 110
ARGI4
CNSTI4 32
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 1328
;1328:			}
ADDRGP4 $388
JUMPV
LABELV $1099
line 1329
;1329:			else {
line 1330
;1330:				trap_S_StartLocalSound(cgs.media.exterminatedSound, CHAN_ANNOUNCER);
ADDRGP4 cgs+751220+1052
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 1331
;1331:				CG_CenterPrint("Exterminated", 110, GIANT_WIDTH);
ADDRGP4 $1106
ARGP4
CNSTI4 110
ARGI4
CNSTI4 32
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 1332
;1332:			}
line 1333
;1333:		}
ADDRGP4 $388
JUMPV
LABELV $1089
line 1334
;1334:		else {
line 1335
;1335:			if (cg.snap->ps.clientNum == es->otherEntityNum) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
NEI4 $1107
line 1336
;1336:				trap_S_StartLocalSound(cgs.media.overkillSound, CHAN_ANNOUNCER);
ADDRGP4 cgs+751220+1048
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 1337
;1337:				CG_CenterPrint("Overkiller Bonus!", 110, GIANT_WIDTH);
ADDRGP4 $1112
ARGP4
CNSTI4 110
ARGI4
CNSTI4 32
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 1338
;1338:			}
ADDRGP4 $388
JUMPV
LABELV $1107
line 1339
;1339:			else if (es->otherEntityNum == ENTITYNUM_NONE) {
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
CNSTI4 1023
NEI4 $1113
line 1340
;1340:				trap_S_StartLocalSound(cgs.media.overkillSound, CHAN_ANNOUNCER);
ADDRGP4 cgs+751220+1048
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 1341
;1341:				CG_CenterPrint("Enemy surrendered!", 110, GIANT_WIDTH);
ADDRGP4 $1117
ARGP4
CNSTI4 110
ARGI4
CNSTI4 32
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 1342
;1342:			}
ADDRGP4 $388
JUMPV
LABELV $1113
line 1343
;1343:			else {
line 1344
;1344:				trap_S_StartLocalSound(cgs.media.overkillSound, CHAN_ANNOUNCER);
ADDRGP4 cgs+751220+1048
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 1345
;1345:				CG_CenterPrint("Overkill!", 110, GIANT_WIDTH);
ADDRGP4 $1120
ARGP4
CNSTI4 110
ARGI4
CNSTI4 32
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 1346
;1346:			}
line 1347
;1347:		}
line 1348
;1348:		break;
ADDRGP4 $388
JUMPV
LABELV $1121
line 1354
;1349:#endif
;1350:
;1351:	// JUHOX: play pant sound
;1352:#if 1
;1353:	case EV_PANT:
;1354:		DEBUGNAME("EV_PANT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1122
ADDRGP4 $1125
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1122
line 1355
;1355:		switch (ci->gender) {
ADDRLP4 88
ADDRLP4 12
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 0
EQI4 $1129
ADDRLP4 88
INDIRI4
CNSTI4 1
EQI4 $1132
ADDRLP4 88
INDIRI4
CNSTI4 2
EQI4 $1135
ADDRGP4 $388
JUMPV
LABELV $1129
line 1357
;1356:		case GENDER_MALE:
;1357:			trap_S_StartSound(NULL, es->number, CHAN_VOICE, cgs.media.malePantSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 cgs+751220+1068
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 1358
;1358:			break;
ADDRGP4 $388
JUMPV
LABELV $1132
line 1360
;1359:		case GENDER_FEMALE:
;1360:			trap_S_StartSound(NULL, es->number, CHAN_VOICE, cgs.media.femalePantSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 cgs+751220+1072
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 1361
;1361:			break;
ADDRGP4 $388
JUMPV
LABELV $1135
line 1363
;1362:		case GENDER_NEUTER:
;1363:			trap_S_StartSound(NULL, es->number, CHAN_VOICE, cgs.media.neuterPantSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 cgs+751220+1076
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 1364
;1364:			break;
line 1366
;1365:		}
;1366:		break;
ADDRGP4 $388
JUMPV
LABELV $1138
line 1371
;1367:#endif
;1368:	// JUHOX: play armor bouncing sound
;1369:#if 1
;1370:	case EV_BOUNCE_ARMOR:
;1371:		DEBUGNAME("EV_BOUNCE_ARMOR");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1139
ADDRGP4 $1142
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1139
line 1372
;1372:		switch (es->eventParm) {
ADDRLP4 96
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
ADDRLP4 96
INDIRI4
CNSTI4 0
EQI4 $1146
ADDRLP4 96
INDIRI4
CNSTI4 1
EQI4 $1153
ADDRLP4 96
INDIRI4
CNSTI4 2
EQI4 $1160
ADDRGP4 $388
JUMPV
LABELV $1146
line 1374
;1373:		case 0:
;1374:			if (rand() & 1) {
ADDRLP4 104
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 104
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1147
line 1375
;1375:				trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.bounceArmorSoundA1);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+751220+1080
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 1376
;1376:			}
ADDRGP4 $388
JUMPV
LABELV $1147
line 1377
;1377:			else {
line 1378
;1378:				trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.bounceArmorSoundB1);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+751220+1092
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 1379
;1379:			}
line 1380
;1380:			break;
ADDRGP4 $388
JUMPV
LABELV $1153
line 1382
;1381:		case 1:
;1382:			if (rand() & 1) {
ADDRLP4 108
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 108
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1154
line 1383
;1383:				trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.bounceArmorSoundA2);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+751220+1084
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 1384
;1384:			}
ADDRGP4 $388
JUMPV
LABELV $1154
line 1385
;1385:			else {
line 1386
;1386:				trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.bounceArmorSoundB2);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+751220+1096
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 1387
;1387:			}
line 1388
;1388:			break;
ADDRGP4 $388
JUMPV
LABELV $1160
line 1390
;1389:		case 2:
;1390:			if (rand() & 1) {
ADDRLP4 112
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 112
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1161
line 1391
;1391:				trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.bounceArmorSoundA3);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+751220+1088
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 1392
;1392:			}
ADDRGP4 $388
JUMPV
LABELV $1161
line 1393
;1393:			else {
line 1394
;1394:				trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.bounceArmorSoundB3);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+751220+1100
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 1395
;1395:			}
line 1396
;1396:			break;
line 1398
;1397:		}
;1398:		break;
ADDRGP4 $388
JUMPV
LABELV $1167
line 1402
;1399:#endif
;1400:#if EARTHQUAKE_SYSTEM	// JUHOX: earthquake event
;1401:	case EV_EARTHQUAKE:
;1402:		CG_AddEarthquake(
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 132
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 128
ADDP4
INDIRF4
ARGF4
ADDRGP4 CG_AddEarthquake
CALLV
pop
line 1407
;1403:			es->origin, es->angles2[1],
;1404:			es->angles[0], es->angles[1], es->angles[2],
;1405:			es->angles2[0]
;1406:		);
;1407:		if (!es->time) {
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 0
NEI4 $388
line 1408
;1408:			cg.earthquakeSoundCounter = (cg.earthquakeEndTime - cg.earthquakeStartedTime) / 200;
ADDRGP4 cg+110136
ADDRGP4 cg+110120
INDIRI4
ADDRGP4 cg+110116
INDIRI4
SUBI4
CNSTI4 200
DIVI4
ASGNI4
line 1409
;1409:			cg.lastEarhquakeSoundStartedTime = cg.time - 1000;
ADDRGP4 cg+110140
ADDRGP4 cg+107656
INDIRI4
CNSTI4 1000
SUBI4
ASGNI4
line 1410
;1410:		}
line 1411
;1411:		break;
ADDRGP4 $388
JUMPV
LABELV $1175
line 1415
;1412:#endif
;1413:#if GRAPPLE_ROPE	// JUHOX: throw hook sound
;1414:	case EV_THROW_HOOK:
;1415:		DEBUGNAME("EV_THROW_HOOK");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1176
ADDRGP4 $1179
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1176
line 1416
;1416:		switch (cgs.hookMode) {
ADDRLP4 108
ADDRGP4 cgs+31868
INDIRI4
ASGNI4
ADDRLP4 108
INDIRI4
CNSTI4 1
LTI4 $388
ADDRLP4 108
INDIRI4
CNSTI4 4
GTI4 $388
ADDRLP4 108
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1190-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1190
address $1184
address $1187
address $1187
address $1184
code
LABELV $1184
line 1419
;1417:		case HM_classic:
;1418:		case HM_combat:
;1419:			trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.grappleShotSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+751220+1104
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 1420
;1420:			break;
ADDRGP4 $388
JUMPV
LABELV $1187
line 1423
;1421:		case HM_tool:
;1422:		case HM_anchor:
;1423:			trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.grappleThrowSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+751220+1108
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 1424
;1424:			break;
line 1426
;1425:		default:
;1426:			break;
line 1428
;1427:		}
;1428:		break;
ADDRGP4 $388
JUMPV
LABELV $1192
line 1432
;1429:#endif
;1430:#if GRAPPLE_ROPE	// JUHOX: handle rope explosion event
;1431:	case EV_ROPE_EXPLOSION:
;1432:		DEBUGNAME("EV_ROPE_EXPLOSION");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1193
ADDRGP4 $1196
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1193
line 1433
;1433:		if (es->eventParm == 0) {
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1197
line 1434
;1434:			trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.ropeExplosionSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+751220+1112
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 1435
;1435:		}
ADDRGP4 $388
JUMPV
LABELV $1197
line 1436
;1436:		else {
line 1437
;1437:			trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.useNothingSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+751220+844
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 1438
;1438:		}
line 1439
;1439:		break;
ADDRGP4 $388
JUMPV
LABELV $1203
line 1445
;1440:#endif
;1441:
;1442:	case EV_PAIN:
;1443:		// local player sounds are triggered in CG_CheckLocalSounds,
;1444:		// so ignore events on the player
;1445:		DEBUGNAME("EV_PAIN");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1204
ADDRGP4 $1207
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1204
line 1446
;1446:		if ( cent->currentState.number != cg.snap->ps.clientNum ) {
ADDRFP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
EQI4 $388
line 1447
;1447:			CG_PainEvent( cent, es->eventParm );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_PainEvent
CALLV
pop
line 1448
;1448:		}
line 1449
;1449:		break;
ADDRGP4 $388
JUMPV
LABELV $1211
line 1454
;1450:
;1451:	case EV_DEATH1:
;1452:	case EV_DEATH2:
;1453:	case EV_DEATH3:
;1454:		DEBUGNAME("EV_DEATHx");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1212
ADDRGP4 $1215
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1212
line 1455
;1455:		trap_S_StartSound( NULL, es->number, CHAN_VOICE, 
ADDRGP4 $1216
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 58
SUBI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 116
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 116
INDIRP4
ARGP4
ADDRLP4 120
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 120
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 1457
;1456:				CG_CustomSound( es->number, va("*death%i.wav", event - EV_DEATH1 + 1) ) );
;1457:		break;
ADDRGP4 $388
JUMPV
LABELV $1217
line 1461
;1458:
;1459:
;1460:	case EV_OBITUARY:
;1461:		DEBUGNAME("EV_OBITUARY");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1218
ADDRGP4 $1221
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1218
line 1462
;1462:		CG_Obituary( es );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Obituary
CALLV
pop
line 1463
;1463:		break;
ADDRGP4 $388
JUMPV
LABELV $1222
line 1469
;1464:
;1465:	//
;1466:	// powerup events
;1467:	//
;1468:	case EV_POWERUP_QUAD:
;1469:		DEBUGNAME("EV_POWERUP_QUAD");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1223
ADDRGP4 $1226
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1223
line 1470
;1470:		if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $1227
line 1471
;1471:			cg.powerupActive = PW_QUAD;
ADDRGP4 cg+127720
CNSTI4 1
ASGNI4
line 1472
;1472:			cg.powerupTime = cg.time;
ADDRGP4 cg+127724
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 1473
;1473:		}
LABELV $1227
line 1474
;1474:		trap_S_StartSound (NULL, es->number, CHAN_ITEM, cgs.media.quadSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 cgs+751220+832
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 1475
;1475:		break;
ADDRGP4 $388
JUMPV
LABELV $1235
line 1477
;1476:	case EV_POWERUP_BATTLESUIT:
;1477:		DEBUGNAME("EV_POWERUP_BATTLESUIT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1236
ADDRGP4 $1239
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1236
line 1478
;1478:		if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $1240
line 1479
;1479:			cg.powerupActive = PW_BATTLESUIT;
ADDRGP4 cg+127720
CNSTI4 2
ASGNI4
line 1480
;1480:			cg.powerupTime = cg.time;
ADDRGP4 cg+127724
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 1481
;1481:		}
LABELV $1240
line 1482
;1482:		trap_S_StartSound (NULL, es->number, CHAN_ITEM, cgs.media.protectSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 cgs+751220+1496
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 1483
;1483:		break;
ADDRGP4 $388
JUMPV
LABELV $1248
line 1485
;1484:	case EV_POWERUP_REGEN:
;1485:		DEBUGNAME("EV_POWERUP_REGEN");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1249
ADDRGP4 $1252
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1249
line 1486
;1486:		if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $1253
line 1487
;1487:			cg.powerupActive = PW_REGEN;
ADDRGP4 cg+127720
CNSTI4 5
ASGNI4
line 1488
;1488:			cg.powerupTime = cg.time;
ADDRGP4 cg+127724
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 1489
;1489:		}
LABELV $1253
line 1490
;1490:		trap_S_StartSound (NULL, es->number, CHAN_ITEM, cgs.media.regenSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 cgs+751220+1492
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 1491
;1491:		break;
ADDRGP4 $388
JUMPV
LABELV $1261
line 1494
;1492:
;1493:	case EV_GIB_PLAYER:
;1494:		DEBUGNAME("EV_GIB_PLAYER");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1262
ADDRGP4 $1265
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1262
line 1498
;1495:		// don't play gib sound when using the kamikaze because it interferes
;1496:		// with the kamikaze sound, downside is that the gib sound will also
;1497:		// not be played when someone is gibbed while just carrying the kamikaze
;1498:		if ( !(es->eFlags & EF_KAMIKAZE) ) {
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
NEI4 $1266
line 1499
;1499:			trap_S_StartSound( NULL, es->number, CHAN_BODY, cgs.media.gibSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+751220+1000
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 1500
;1500:		}
LABELV $1266
line 1505
;1501:		// JUHOX: add new parameter for CG_GibPlayer
;1502:#if !MONSTER_MODE
;1503:		CG_GibPlayer( cent->lerpOrigin );
;1504:#else
;1505:		CG_GibPlayer(cent->lerpOrigin, cent);
ADDRLP4 124
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 124
INDIRP4
CNSTI4 728
ADDP4
ARGP4
ADDRLP4 124
INDIRP4
ARGP4
ADDRGP4 CG_GibPlayer
CALLV
pop
line 1507
;1506:#endif
;1507:		break;
ADDRGP4 $388
JUMPV
LABELV $1270
line 1510
;1508:
;1509:	case EV_STOPLOOPINGSOUND:
;1510:		DEBUGNAME("EV_STOPLOOPINGSOUND");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1271
ADDRGP4 $1274
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1271
line 1511
;1511:		trap_S_StopLoopingSound( es->number );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StopLoopingSound
CALLV
pop
line 1512
;1512:		es->loopSound = 0;
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
CNSTI4 0
ASGNI4
line 1513
;1513:		break;
ADDRGP4 $388
JUMPV
LABELV $1275
line 1516
;1514:
;1515:	case EV_DEBUG_LINE:
;1516:		DEBUGNAME("EV_DEBUG_LINE");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1276
ADDRGP4 $1279
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1276
line 1517
;1517:		CG_Beam( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Beam
CALLV
pop
line 1518
;1518:		break;
ADDRGP4 $388
JUMPV
LABELV $387
line 1521
;1519:
;1520:	default:
;1521:		DEBUGNAME("UNKNOWN");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1280
ADDRGP4 $1283
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1280
line 1522
;1522:		CG_Error( "Unknown event: %i", event );
ADDRGP4 $1284
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 1523
;1523:		break;
LABELV $388
line 1526
;1524:	}
;1525:
;1526:}
LABELV $372
endproc CG_EntityEvent 128 48
export CG_CheckEvents
proc CG_CheckEvents 8 12
line 1535
;1527:
;1528:
;1529:/*
;1530:==============
;1531:CG_CheckEvents
;1532:
;1533:==============
;1534:*/
;1535:void CG_CheckEvents( centity_t *cent ) {
line 1537
;1536:	// check for event-only entities
;1537:	if ( cent->currentState.eType > ET_EVENTS ) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 14
LEI4 $1288
line 1538
;1538:		if ( cent->previousEvent ) {
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1290
line 1539
;1539:			return;	// already fired
ADDRGP4 $1287
JUMPV
LABELV $1290
line 1542
;1540:		}
;1541:		// if this is a player event set the entity number of the client entity number
;1542:		if ( cent->currentState.eFlags & EF_PLAYER_EVENT ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1292
line 1543
;1543:			cent->currentState.number = cent->currentState.otherEntityNum;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 1544
;1544:		}
LABELV $1292
line 1546
;1545:
;1546:		cent->previousEvent = 1;
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
CNSTI4 1
ASGNI4
line 1548
;1547:
;1548:		cent->currentState.event = cent->currentState.eType - ET_EVENTS;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 14
SUBI4
ASGNI4
line 1549
;1549:	} else {
ADDRGP4 $1289
JUMPV
LABELV $1288
line 1551
;1550:		// check for events riding with another entity
;1551:		if ( cent->currentState.event == cent->previousEvent ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 428
ADDP4
INDIRI4
NEI4 $1294
line 1552
;1552:			return;
ADDRGP4 $1287
JUMPV
LABELV $1294
line 1554
;1553:		}
;1554:		cent->previousEvent = cent->currentState.event;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 428
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ASGNI4
line 1555
;1555:		if ( ( cent->currentState.event & ~EV_EVENT_BITS ) == 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 -769
BANDI4
CNSTI4 0
NEI4 $1296
line 1556
;1556:			return;
ADDRGP4 $1287
JUMPV
LABELV $1296
line 1558
;1557:		}
;1558:	}
LABELV $1289
line 1561
;1559:
;1560:	// calculate the position at exactly the frame time
;1561:	BG_EvaluateTrajectory( &cent->currentState.pos, cg.snap->serverTime, cent->lerpOrigin );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 728
ADDP4
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 1562
;1562:	CG_SetEntitySoundPosition( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_SetEntitySoundPosition
CALLV
pop
line 1564
;1563:
;1564:	CG_EntityEvent( cent, cent->lerpOrigin );
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 728
ADDP4
ARGP4
ADDRGP4 CG_EntityEvent
CALLV
pop
line 1565
;1565:}
LABELV $1287
endproc CG_CheckEvents 8 12
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
LABELV $1284
byte 1 85
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $1283
byte 1 85
byte 1 78
byte 1 75
byte 1 78
byte 1 79
byte 1 87
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $1279
byte 1 69
byte 1 86
byte 1 95
byte 1 68
byte 1 69
byte 1 66
byte 1 85
byte 1 71
byte 1 95
byte 1 76
byte 1 73
byte 1 78
byte 1 69
byte 1 10
byte 1 0
align 1
LABELV $1274
byte 1 69
byte 1 86
byte 1 95
byte 1 83
byte 1 84
byte 1 79
byte 1 80
byte 1 76
byte 1 79
byte 1 79
byte 1 80
byte 1 73
byte 1 78
byte 1 71
byte 1 83
byte 1 79
byte 1 85
byte 1 78
byte 1 68
byte 1 10
byte 1 0
align 1
LABELV $1265
byte 1 69
byte 1 86
byte 1 95
byte 1 71
byte 1 73
byte 1 66
byte 1 95
byte 1 80
byte 1 76
byte 1 65
byte 1 89
byte 1 69
byte 1 82
byte 1 10
byte 1 0
align 1
LABELV $1252
byte 1 69
byte 1 86
byte 1 95
byte 1 80
byte 1 79
byte 1 87
byte 1 69
byte 1 82
byte 1 85
byte 1 80
byte 1 95
byte 1 82
byte 1 69
byte 1 71
byte 1 69
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $1239
byte 1 69
byte 1 86
byte 1 95
byte 1 80
byte 1 79
byte 1 87
byte 1 69
byte 1 82
byte 1 85
byte 1 80
byte 1 95
byte 1 66
byte 1 65
byte 1 84
byte 1 84
byte 1 76
byte 1 69
byte 1 83
byte 1 85
byte 1 73
byte 1 84
byte 1 10
byte 1 0
align 1
LABELV $1226
byte 1 69
byte 1 86
byte 1 95
byte 1 80
byte 1 79
byte 1 87
byte 1 69
byte 1 82
byte 1 85
byte 1 80
byte 1 95
byte 1 81
byte 1 85
byte 1 65
byte 1 68
byte 1 10
byte 1 0
align 1
LABELV $1221
byte 1 69
byte 1 86
byte 1 95
byte 1 79
byte 1 66
byte 1 73
byte 1 84
byte 1 85
byte 1 65
byte 1 82
byte 1 89
byte 1 10
byte 1 0
align 1
LABELV $1216
byte 1 42
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $1215
byte 1 69
byte 1 86
byte 1 95
byte 1 68
byte 1 69
byte 1 65
byte 1 84
byte 1 72
byte 1 120
byte 1 10
byte 1 0
align 1
LABELV $1207
byte 1 69
byte 1 86
byte 1 95
byte 1 80
byte 1 65
byte 1 73
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $1196
byte 1 69
byte 1 86
byte 1 95
byte 1 82
byte 1 79
byte 1 80
byte 1 69
byte 1 95
byte 1 69
byte 1 88
byte 1 80
byte 1 76
byte 1 79
byte 1 83
byte 1 73
byte 1 79
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $1179
byte 1 69
byte 1 86
byte 1 95
byte 1 84
byte 1 72
byte 1 82
byte 1 79
byte 1 87
byte 1 95
byte 1 72
byte 1 79
byte 1 79
byte 1 75
byte 1 10
byte 1 0
align 1
LABELV $1142
byte 1 69
byte 1 86
byte 1 95
byte 1 66
byte 1 79
byte 1 85
byte 1 78
byte 1 67
byte 1 69
byte 1 95
byte 1 65
byte 1 82
byte 1 77
byte 1 79
byte 1 82
byte 1 10
byte 1 0
align 1
LABELV $1125
byte 1 69
byte 1 86
byte 1 95
byte 1 80
byte 1 65
byte 1 78
byte 1 84
byte 1 10
byte 1 0
align 1
LABELV $1120
byte 1 79
byte 1 118
byte 1 101
byte 1 114
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 33
byte 1 0
align 1
LABELV $1117
byte 1 69
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 115
byte 1 117
byte 1 114
byte 1 114
byte 1 101
byte 1 110
byte 1 100
byte 1 101
byte 1 114
byte 1 101
byte 1 100
byte 1 33
byte 1 0
align 1
LABELV $1112
byte 1 79
byte 1 118
byte 1 101
byte 1 114
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 114
byte 1 32
byte 1 66
byte 1 111
byte 1 110
byte 1 117
byte 1 115
byte 1 33
byte 1 0
align 1
LABELV $1106
byte 1 69
byte 1 120
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $1103
byte 1 67
byte 1 97
byte 1 112
byte 1 105
byte 1 116
byte 1 117
byte 1 108
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1098
byte 1 83
byte 1 101
byte 1 108
byte 1 102
byte 1 45
byte 1 69
byte 1 120
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 10
byte 1 80
byte 1 101
byte 1 110
byte 1 97
byte 1 108
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $1088
byte 1 69
byte 1 120
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1085
byte 1 76
byte 1 97
byte 1 115
byte 1 116
byte 1 32
byte 1 77
byte 1 97
byte 1 110
byte 1 32
byte 1 83
byte 1 116
byte 1 97
byte 1 110
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 33
byte 1 0
align 1
LABELV $1076
byte 1 69
byte 1 86
byte 1 95
byte 1 79
byte 1 86
byte 1 69
byte 1 82
byte 1 75
byte 1 73
byte 1 76
byte 1 76
byte 1 10
byte 1 0
align 1
LABELV $952
byte 1 69
byte 1 86
byte 1 95
byte 1 71
byte 1 76
byte 1 79
byte 1 66
byte 1 65
byte 1 76
byte 1 95
byte 1 84
byte 1 69
byte 1 65
byte 1 77
byte 1 95
byte 1 83
byte 1 79
byte 1 85
byte 1 78
byte 1 68
byte 1 10
byte 1 0
align 1
LABELV $941
byte 1 69
byte 1 86
byte 1 95
byte 1 71
byte 1 76
byte 1 79
byte 1 66
byte 1 65
byte 1 76
byte 1 95
byte 1 83
byte 1 79
byte 1 85
byte 1 78
byte 1 68
byte 1 10
byte 1 0
align 1
LABELV $932
byte 1 69
byte 1 86
byte 1 95
byte 1 71
byte 1 69
byte 1 78
byte 1 69
byte 1 82
byte 1 65
byte 1 76
byte 1 95
byte 1 83
byte 1 79
byte 1 85
byte 1 78
byte 1 68
byte 1 10
byte 1 0
align 1
LABELV $882
byte 1 69
byte 1 86
byte 1 95
byte 1 78
byte 1 65
byte 1 86
byte 1 65
byte 1 73
byte 1 68
byte 1 10
byte 1 0
align 1
LABELV $856
byte 1 69
byte 1 86
byte 1 95
byte 1 68
byte 1 73
byte 1 83
byte 1 67
byte 1 72
byte 1 65
byte 1 82
byte 1 71
byte 1 69
byte 1 95
byte 1 70
byte 1 76
byte 1 65
byte 1 83
byte 1 72
byte 1 10
byte 1 0
align 1
LABELV $851
byte 1 69
byte 1 86
byte 1 95
byte 1 83
byte 1 72
byte 1 79
byte 1 84
byte 1 71
byte 1 85
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $846
byte 1 69
byte 1 86
byte 1 95
byte 1 66
byte 1 85
byte 1 76
byte 1 76
byte 1 69
byte 1 84
byte 1 95
byte 1 72
byte 1 73
byte 1 84
byte 1 95
byte 1 70
byte 1 76
byte 1 69
byte 1 83
byte 1 72
byte 1 10
byte 1 0
align 1
LABELV $841
byte 1 69
byte 1 86
byte 1 95
byte 1 66
byte 1 85
byte 1 76
byte 1 76
byte 1 69
byte 1 84
byte 1 95
byte 1 72
byte 1 73
byte 1 84
byte 1 95
byte 1 87
byte 1 65
byte 1 76
byte 1 76
byte 1 10
byte 1 0
align 1
LABELV $834
byte 1 69
byte 1 86
byte 1 95
byte 1 82
byte 1 65
byte 1 73
byte 1 76
byte 1 84
byte 1 82
byte 1 65
byte 1 73
byte 1 76
byte 1 10
byte 1 0
align 1
LABELV $829
byte 1 69
byte 1 86
byte 1 95
byte 1 77
byte 1 73
byte 1 83
byte 1 83
byte 1 73
byte 1 76
byte 1 69
byte 1 95
byte 1 77
byte 1 73
byte 1 83
byte 1 83
byte 1 95
byte 1 77
byte 1 69
byte 1 84
byte 1 65
byte 1 76
byte 1 10
byte 1 0
align 1
LABELV $824
byte 1 69
byte 1 86
byte 1 95
byte 1 77
byte 1 73
byte 1 83
byte 1 83
byte 1 73
byte 1 76
byte 1 69
byte 1 95
byte 1 77
byte 1 73
byte 1 83
byte 1 83
byte 1 10
byte 1 0
align 1
LABELV $819
byte 1 69
byte 1 86
byte 1 95
byte 1 77
byte 1 73
byte 1 83
byte 1 83
byte 1 73
byte 1 76
byte 1 69
byte 1 95
byte 1 72
byte 1 73
byte 1 84
byte 1 10
byte 1 0
align 1
LABELV $814
byte 1 69
byte 1 86
byte 1 95
byte 1 83
byte 1 67
byte 1 79
byte 1 82
byte 1 69
byte 1 80
byte 1 76
byte 1 85
byte 1 77
byte 1 10
byte 1 0
align 1
LABELV $809
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 99
byte 1 111
byte 1 99
byte 1 111
byte 1 111
byte 1 110
byte 1 37
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $797
byte 1 69
byte 1 86
byte 1 95
byte 1 71
byte 1 82
byte 1 69
byte 1 78
byte 1 65
byte 1 68
byte 1 69
byte 1 95
byte 1 66
byte 1 79
byte 1 85
byte 1 78
byte 1 67
byte 1 69
byte 1 10
byte 1 0
align 1
LABELV $789
byte 1 69
byte 1 86
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 95
byte 1 82
byte 1 69
byte 1 83
byte 1 80
byte 1 65
byte 1 87
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $782
byte 1 69
byte 1 86
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 95
byte 1 80
byte 1 79
byte 1 80
byte 1 10
byte 1 0
align 1
LABELV $775
byte 1 69
byte 1 86
byte 1 95
byte 1 80
byte 1 76
byte 1 65
byte 1 89
byte 1 69
byte 1 82
byte 1 95
byte 1 84
byte 1 69
byte 1 76
byte 1 69
byte 1 80
byte 1 79
byte 1 82
byte 1 84
byte 1 95
byte 1 79
byte 1 85
byte 1 84
byte 1 10
byte 1 0
align 1
LABELV $768
byte 1 69
byte 1 86
byte 1 95
byte 1 80
byte 1 76
byte 1 65
byte 1 89
byte 1 69
byte 1 82
byte 1 95
byte 1 84
byte 1 69
byte 1 76
byte 1 69
byte 1 80
byte 1 79
byte 1 82
byte 1 84
byte 1 95
byte 1 73
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $763
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 49
byte 1 52
byte 1 10
byte 1 0
align 1
LABELV $758
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 49
byte 1 51
byte 1 10
byte 1 0
align 1
LABELV $753
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 49
byte 1 50
byte 1 10
byte 1 0
align 1
LABELV $748
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 49
byte 1 49
byte 1 10
byte 1 0
align 1
LABELV $743
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 49
byte 1 48
byte 1 10
byte 1 0
align 1
LABELV $738
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 57
byte 1 10
byte 1 0
align 1
LABELV $733
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 56
byte 1 10
byte 1 0
align 1
LABELV $728
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 55
byte 1 10
byte 1 0
align 1
LABELV $723
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 54
byte 1 10
byte 1 0
align 1
LABELV $718
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 53
byte 1 10
byte 1 0
align 1
LABELV $713
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 52
byte 1 10
byte 1 0
align 1
LABELV $708
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 51
byte 1 10
byte 1 0
align 1
LABELV $703
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 50
byte 1 10
byte 1 0
align 1
LABELV $698
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 49
byte 1 10
byte 1 0
align 1
LABELV $693
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 48
byte 1 10
byte 1 0
align 1
LABELV $688
byte 1 69
byte 1 86
byte 1 95
byte 1 70
byte 1 73
byte 1 82
byte 1 69
byte 1 95
byte 1 87
byte 1 69
byte 1 65
byte 1 80
byte 1 79
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $681
byte 1 69
byte 1 86
byte 1 95
byte 1 67
byte 1 72
byte 1 65
byte 1 78
byte 1 71
byte 1 69
byte 1 95
byte 1 87
byte 1 69
byte 1 65
byte 1 80
byte 1 79
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $670
byte 1 69
byte 1 86
byte 1 95
byte 1 78
byte 1 79
byte 1 65
byte 1 77
byte 1 77
byte 1 79
byte 1 10
byte 1 0
align 1
LABELV $639
byte 1 69
byte 1 86
byte 1 95
byte 1 71
byte 1 76
byte 1 79
byte 1 66
byte 1 65
byte 1 76
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 95
byte 1 80
byte 1 73
byte 1 67
byte 1 75
byte 1 85
byte 1 80
byte 1 10
byte 1 0
align 1
LABELV $621
byte 1 69
byte 1 86
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 95
byte 1 80
byte 1 73
byte 1 67
byte 1 75
byte 1 85
byte 1 80
byte 1 10
byte 1 0
align 1
LABELV $616
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
LABELV $615
byte 1 69
byte 1 86
byte 1 95
byte 1 87
byte 1 65
byte 1 84
byte 1 69
byte 1 82
byte 1 95
byte 1 67
byte 1 76
byte 1 69
byte 1 65
byte 1 82
byte 1 10
byte 1 0
align 1
LABELV $608
byte 1 69
byte 1 86
byte 1 95
byte 1 87
byte 1 65
byte 1 84
byte 1 69
byte 1 82
byte 1 95
byte 1 85
byte 1 78
byte 1 68
byte 1 69
byte 1 82
byte 1 10
byte 1 0
align 1
LABELV $601
byte 1 69
byte 1 86
byte 1 95
byte 1 87
byte 1 65
byte 1 84
byte 1 69
byte 1 82
byte 1 95
byte 1 76
byte 1 69
byte 1 65
byte 1 86
byte 1 69
byte 1 10
byte 1 0
align 1
LABELV $594
byte 1 69
byte 1 86
byte 1 95
byte 1 87
byte 1 65
byte 1 84
byte 1 69
byte 1 82
byte 1 95
byte 1 84
byte 1 79
byte 1 85
byte 1 67
byte 1 72
byte 1 10
byte 1 0
align 1
LABELV $589
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
LABELV $584
byte 1 69
byte 1 86
byte 1 95
byte 1 84
byte 1 65
byte 1 85
byte 1 78
byte 1 84
byte 1 10
byte 1 0
align 1
LABELV $579
byte 1 69
byte 1 86
byte 1 95
byte 1 74
byte 1 85
byte 1 77
byte 1 80
byte 1 10
byte 1 0
align 1
LABELV $574
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
LABELV $567
byte 1 69
byte 1 86
byte 1 95
byte 1 74
byte 1 85
byte 1 77
byte 1 80
byte 1 95
byte 1 80
byte 1 65
byte 1 68
byte 1 10
byte 1 0
align 1
LABELV $537
byte 1 69
byte 1 86
byte 1 95
byte 1 83
byte 1 84
byte 1 69
byte 1 80
byte 1 10
byte 1 0
align 1
LABELV $512
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
LABELV $511
byte 1 69
byte 1 86
byte 1 95
byte 1 70
byte 1 65
byte 1 76
byte 1 76
byte 1 95
byte 1 70
byte 1 65
byte 1 82
byte 1 10
byte 1 0
align 1
LABELV $489
byte 1 69
byte 1 86
byte 1 95
byte 1 70
byte 1 65
byte 1 76
byte 1 76
byte 1 95
byte 1 77
byte 1 69
byte 1 68
byte 1 73
byte 1 85
byte 1 77
byte 1 10
byte 1 0
align 1
LABELV $467
byte 1 69
byte 1 86
byte 1 95
byte 1 70
byte 1 65
byte 1 76
byte 1 76
byte 1 95
byte 1 83
byte 1 72
byte 1 79
byte 1 82
byte 1 84
byte 1 10
byte 1 0
align 1
LABELV $456
byte 1 69
byte 1 86
byte 1 95
byte 1 83
byte 1 87
byte 1 73
byte 1 77
byte 1 10
byte 1 0
align 1
LABELV $443
byte 1 69
byte 1 86
byte 1 95
byte 1 70
byte 1 79
byte 1 79
byte 1 84
byte 1 87
byte 1 65
byte 1 68
byte 1 69
byte 1 10
byte 1 0
align 1
LABELV $426
byte 1 69
byte 1 86
byte 1 95
byte 1 70
byte 1 79
byte 1 79
byte 1 84
byte 1 83
byte 1 80
byte 1 76
byte 1 65
byte 1 83
byte 1 72
byte 1 10
byte 1 0
align 1
LABELV $409
byte 1 69
byte 1 86
byte 1 95
byte 1 70
byte 1 79
byte 1 79
byte 1 84
byte 1 83
byte 1 84
byte 1 69
byte 1 80
byte 1 95
byte 1 77
byte 1 69
byte 1 84
byte 1 65
byte 1 76
byte 1 10
byte 1 0
align 1
LABELV $393
byte 1 69
byte 1 86
byte 1 95
byte 1 70
byte 1 79
byte 1 79
byte 1 84
byte 1 83
byte 1 84
byte 1 69
byte 1 80
byte 1 10
byte 1 0
align 1
LABELV $382
byte 1 90
byte 1 69
byte 1 82
byte 1 79
byte 1 69
byte 1 86
byte 1 69
byte 1 78
byte 1 84
byte 1 10
byte 1 0
align 1
LABELV $376
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 37
byte 1 51
byte 1 105
byte 1 32
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 37
byte 1 51
byte 1 105
byte 1 32
byte 1 0
align 1
LABELV $370
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
LABELV $369
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
LABELV $366
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
LABELV $363
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
LABELV $326
byte 1 85
byte 1 115
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $325
byte 1 78
byte 1 111
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $315
byte 1 37
byte 1 115
byte 1 32
byte 1 100
byte 1 105
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $314
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $309
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $308
byte 1 39
byte 1 115
byte 1 32
byte 1 112
byte 1 101
byte 1 114
byte 1 115
byte 1 111
byte 1 110
byte 1 97
byte 1 108
byte 1 32
byte 1 115
byte 1 112
byte 1 97
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $307
byte 1 116
byte 1 114
byte 1 105
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 105
byte 1 110
byte 1 118
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $305
byte 1 39
byte 1 115
byte 1 32
byte 1 66
byte 1 70
byte 1 71
byte 1 0
align 1
LABELV $304
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 98
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $302
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 114
byte 1 111
byte 1 99
byte 1 117
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $300
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $297
byte 1 39
byte 1 115
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $296
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 109
byte 1 101
byte 1 108
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $294
byte 1 97
byte 1 108
byte 1 109
byte 1 111
byte 1 115
byte 1 116
byte 1 32
byte 1 100
byte 1 111
byte 1 100
byte 1 103
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $292
byte 1 39
byte 1 115
byte 1 32
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $290
byte 1 39
byte 1 115
byte 1 32
byte 1 115
byte 1 104
byte 1 114
byte 1 97
byte 1 112
byte 1 110
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $289
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 115
byte 1 104
byte 1 114
byte 1 101
byte 1 100
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $287
byte 1 39
byte 1 115
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $286
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $284
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 103
byte 1 117
byte 1 110
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $282
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 109
byte 1 97
byte 1 99
byte 1 104
byte 1 105
byte 1 110
byte 1 101
byte 1 103
byte 1 117
byte 1 110
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $280
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 118
byte 1 97
byte 1 112
byte 1 111
byte 1 114
byte 1 105
byte 1 122
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $278
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 104
byte 1 117
byte 1 110
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $276
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 112
byte 1 117
byte 1 109
byte 1 109
byte 1 101
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $274
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 99
byte 1 97
byte 1 117
byte 1 103
byte 1 104
byte 1 116
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $263
byte 1 110
byte 1 111
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $260
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 103
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $257
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 103
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 37
byte 1 115
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 99
byte 1 101
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $250
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $245
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $244
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 116
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $241
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $238
byte 1 115
byte 1 104
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 32
byte 1 115
byte 1 109
byte 1 97
byte 1 108
byte 1 108
byte 1 101
byte 1 114
byte 1 32
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $236
byte 1 109
byte 1 101
byte 1 108
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $235
byte 1 109
byte 1 101
byte 1 108
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 116
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $232
byte 1 109
byte 1 101
byte 1 108
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $228
byte 1 98
byte 1 108
byte 1 101
byte 1 119
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 32
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $227
byte 1 98
byte 1 108
byte 1 101
byte 1 119
byte 1 32
byte 1 105
byte 1 116
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 32
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $224
byte 1 98
byte 1 108
byte 1 101
byte 1 119
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 32
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $220
byte 1 116
byte 1 114
byte 1 105
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $219
byte 1 116
byte 1 114
byte 1 105
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 105
byte 1 116
byte 1 115
byte 1 32
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $216
byte 1 116
byte 1 114
byte 1 105
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $212
byte 1 119
byte 1 97
byte 1 115
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 110
byte 1 105
byte 1 99
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 112
byte 1 101
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $211
byte 1 119
byte 1 97
byte 1 115
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 110
byte 1 105
byte 1 99
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 105
byte 1 116
byte 1 115
byte 1 32
byte 1 112
byte 1 101
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $208
byte 1 119
byte 1 97
byte 1 115
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 110
byte 1 105
byte 1 99
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 112
byte 1 101
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $197
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 119
byte 1 114
byte 1 111
byte 1 110
byte 1 103
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $195
byte 1 115
byte 1 97
byte 1 119
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $193
byte 1 100
byte 1 111
byte 1 101
byte 1 115
byte 1 32
byte 1 97
byte 1 32
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 102
byte 1 108
byte 1 105
byte 1 112
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 111
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 108
byte 1 97
byte 1 118
byte 1 97
byte 1 0
align 1
LABELV $191
byte 1 109
byte 1 101
byte 1 108
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $189
byte 1 115
byte 1 97
byte 1 110
byte 1 107
byte 1 32
byte 1 108
byte 1 105
byte 1 107
byte 1 101
byte 1 32
byte 1 97
byte 1 32
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $187
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 115
byte 1 113
byte 1 117
byte 1 105
byte 1 115
byte 1 104
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $185
byte 1 99
byte 1 114
byte 1 97
byte 1 116
byte 1 101
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $183
byte 1 115
byte 1 117
byte 1 105
byte 1 99
byte 1 105
byte 1 100
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $181
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 115
byte 1 109
byte 1 97
byte 1 115
byte 1 104
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 97
byte 1 32
byte 1 116
byte 1 105
byte 1 116
byte 1 97
byte 1 110
byte 1 0
align 1
LABELV $179
byte 1 114
byte 1 101
byte 1 99
byte 1 101
byte 1 105
byte 1 118
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 103
byte 1 117
byte 1 97
byte 1 114
byte 1 100
byte 1 39
byte 1 115
byte 1 32
byte 1 109
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $177
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 108
byte 1 97
byte 1 99
byte 1 101
byte 1 114
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 97
byte 1 32
byte 1 112
byte 1 114
byte 1 101
byte 1 100
byte 1 97
byte 1 116
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $171
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $170
byte 1 110
byte 1 0
align 1
LABELV $163
byte 1 67
byte 1 71
byte 1 95
byte 1 79
byte 1 98
byte 1 105
byte 1 116
byte 1 117
byte 1 97
byte 1 114
byte 1 121
byte 1 58
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 114
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $158
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $157
byte 1 37
byte 1 105
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $156
byte 1 37
byte 1 105
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $153
byte 1 37
byte 1 105
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $150
byte 1 37
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $147
byte 1 49
byte 1 51
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $144
byte 1 49
byte 1 50
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $141
byte 1 49
byte 1 49
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $138
byte 1 94
byte 1 51
byte 1 51
byte 1 114
byte 1 100
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $135
byte 1 94
byte 1 49
byte 1 50
byte 1 110
byte 1 100
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $132
byte 1 94
byte 1 52
byte 1 49
byte 1 115
byte 1 116
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $129
byte 1 0
align 1
LABELV $128
byte 1 84
byte 1 105
byte 1 101
byte 1 100
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 0
