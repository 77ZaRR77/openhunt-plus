data
align 4
LABELV playerMins
byte 4 3245342720
byte 4 3245342720
byte 4 3250585600
align 4
LABELV playerMaxs
byte 4 1097859072
byte 4 1097859072
byte 4 1107296256
export SP_info_player_deathmatch
code
proc SP_info_player_deathmatch 8 12
file "..\..\..\..\code\game\g_client.c"
line 17
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:#include "g_local.h"
;4:
;5:// g_client.c -- client functions that don't happen every frame
;6:
;7:static vec3_t	playerMins = {-15, -15, -24};
;8:static vec3_t	playerMaxs = {15, 15, 32};
;9:
;10:/*QUAKED info_player_deathmatch (1 0 1) (-16 -16 -24) (16 16 32) initial
;11:potential spawning position for deathmatch games.
;12:The first time a player enters the game, they will be at an 'initial' spot.
;13:Targets will be fired when someone spawns in on them.
;14:"nobots" will prevent bots from using this spot.
;15:"nohumans" will prevent non-bots from using this spot.
;16:*/
;17:void SP_info_player_deathmatch( gentity_t *ent ) {
line 20
;18:	int		i;
;19:
;20:	G_SpawnInt( "nobots", "0", &i);
ADDRGP4 $88
ARGP4
ADDRGP4 $89
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnInt
CALLI4
pop
line 21
;21:	if ( i ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $90
line 22
;22:		ent->flags |= FL_NO_BOTS;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 540
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 8192
BORI4
ASGNI4
line 23
;23:	}
LABELV $90
line 24
;24:	G_SpawnInt( "nohumans", "0", &i );
ADDRGP4 $92
ARGP4
ADDRGP4 $89
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnInt
CALLI4
pop
line 25
;25:	if ( i ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $93
line 26
;26:		ent->flags |= FL_NO_HUMANS;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 540
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
line 27
;27:	}
LABELV $93
line 29
;28:#if 1	// JUHOX: new name for initial spawn points
;29:	if (ent->spawnflags & 1) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $95
line 30
;30:		ent->classname = "info_player_initial";
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
ADDRGP4 $97
ASGNP4
line 31
;31:	}
LABELV $95
line 34
;32:#endif
;33:#if ESCAPE_MODE	// JUHOX: set entity class
;34:	ent->entClass = GEC_info_player_deathmatch;
ADDRFP4 0
INDIRP4
CNSTI4 824
ADDP4
CNSTI4 3
ASGNI4
line 36
;35:#endif
;36:}
LABELV $87
endproc SP_info_player_deathmatch 8 12
export SP_info_player_start
proc SP_info_player_start 0 4
line 41
;37:
;38:/*QUAKED info_player_start (1 0 0) (-16 -16 -24) (16 16 32)
;39:equivelant to info_player_deathmatch
;40:*/
;41:void SP_info_player_start(gentity_t *ent) {
line 42
;42:	ent->classname = "info_player_deathmatch";
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
ADDRGP4 $99
ASGNP4
line 43
;43:	SP_info_player_deathmatch( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 SP_info_player_deathmatch
CALLV
pop
line 44
;44:}
LABELV $98
endproc SP_info_player_start 0 4
export SP_info_player_intermission
proc SP_info_player_intermission 0 0
line 49
;45:
;46:/*QUAKED info_player_intermission (1 0 1) (-16 -16 -24) (16 16 32)
;47:The intermission will be viewed from this point.  Target an info_notnull for the view direction.
;48:*/
;49:void SP_info_player_intermission( gentity_t *ent ) {
line 51
;50:#if ESCAPE_MODE	// JUHOX: set entity class
;51:	ent->entClass = GEC_info_player_intermission;
ADDRFP4 0
INDIRP4
CNSTI4 824
ADDP4
CNSTI4 4
ASGNI4
line 53
;52:#endif
;53:}
LABELV $100
endproc SP_info_player_intermission 0 0
export SpotWouldTelefrag
proc SpotWouldTelefrag 4144 16
line 71
;54:
;55:
;56:
;57:/*
;58:=======================================================================
;59:
;60:  SelectSpawnPoint
;61:
;62:=======================================================================
;63:*/
;64:
;65:/*
;66:================
;67:SpotWouldTelefrag
;68:
;69:================
;70:*/
;71:qboolean SpotWouldTelefrag( gentity_t *spot ) {
line 77
;72:	int			i, num;
;73:	int			touch[MAX_GENTITIES];
;74:	gentity_t	*hit;
;75:	vec3_t		mins, maxs;
;76:
;77:	VectorAdd( spot->s.origin, playerMins, mins );
ADDRLP4 4132
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4108
ADDRLP4 4132
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ADDRGP4 playerMins
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4108+4
ADDRLP4 4132
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ADDRGP4 playerMins+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4108+8
ADDRFP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ADDRGP4 playerMins+8
INDIRF4
ADDF4
ASGNF4
line 78
;78:	VectorAdd( spot->s.origin, playerMaxs, maxs );
ADDRLP4 4136
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4120
ADDRLP4 4136
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ADDRGP4 playerMaxs
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4120+4
ADDRLP4 4136
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ADDRGP4 playerMaxs+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4120+8
ADDRFP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ADDRGP4 playerMaxs+8
INDIRF4
ADDF4
ASGNF4
line 79
;79:	num = trap_EntitiesInBox( mins, maxs, touch, MAX_GENTITIES );
ADDRLP4 4108
ARGP4
ADDRLP4 4120
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 4140
ADDRGP4 trap_EntitiesInBox
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 4140
INDIRI4
ASGNI4
line 81
;80:
;81:	for (i=0 ; i<num ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $113
JUMPV
LABELV $110
line 82
;82:		hit = &g_entities[touch[i]];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 84
;83:		//if ( hit->client && hit->client->ps.stats[STAT_HEALTH] > 0 ) {
;84:		if ( hit->client) {
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $114
line 85
;85:			if (hit->client->ps.stats[STAT_HEALTH] <= 0) continue;	// JUHOX
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $116
ADDRGP4 $111
JUMPV
LABELV $116
line 86
;86:			if (hit->client->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR) continue;	// JUHOX
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 3
NEI4 $118
ADDRGP4 $111
JUMPV
LABELV $118
line 87
;87:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $101
JUMPV
LABELV $114
line 97
;88:		}
;89:		// -JUHOX: don't telefrag monsters
;90:#if 0//MONSTER_MODE
;91:		if (hit->s.eType == ET_PLAYER && hit->s.clientNum >= CLIENTNUM_MONSTERS) {
;92:			if (hit->health <= 0) continue;
;93:			return qtrue;
;94:		}
;95:#endif
;96:
;97:	}
LABELV $111
line 81
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $113
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $110
line 99
;98:
;99:	return qfalse;
CNSTI4 0
RETI4
LABELV $101
endproc SpotWouldTelefrag 4144 16
export PositionWouldTelefrag
proc PositionWouldTelefrag 4160 16
line 109
;100:}
;101:
;102:/*
;103:================
;104:JUHOX: PositionWouldTelefrag
;105:
;106:originally from 'SpotWouldTelefrag()'
;107:================
;108:*/
;109:qboolean PositionWouldTelefrag(const vec3_t position, const vec3_t pmins, const vec3_t pmaxs) {
line 115
;110:	int			i, num;
;111:	int			touch[MAX_GENTITIES];
;112:	gentity_t	*hit;
;113:	vec3_t		mins, maxs;
;114:
;115:	VectorAdd(position, pmins, mins);
ADDRLP4 4132
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4136
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4108
ADDRLP4 4132
INDIRP4
INDIRF4
ADDRLP4 4136
INDIRP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4108+4
ADDRLP4 4132
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 4136
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4108+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
ASGNF4
line 116
;116:	VectorAdd(position, pmaxs, maxs );
ADDRLP4 4140
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4144
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 4120
ADDRLP4 4140
INDIRP4
INDIRF4
ADDRLP4 4144
INDIRP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4120+4
ADDRLP4 4140
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 4144
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4120+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
ASGNF4
line 117
;117:	num = trap_EntitiesInBox(mins, maxs, touch, MAX_GENTITIES);
ADDRLP4 4108
ARGP4
ADDRLP4 4120
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 4148
ADDRGP4 trap_EntitiesInBox
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 4148
INDIRI4
ASGNI4
line 119
;118:
;119:	for (i = 0; i < num; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $128
JUMPV
LABELV $125
line 122
;120:		playerState_t* ps;
;121:
;122:		hit = &g_entities[touch[i]];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 123
;123:		ps = G_GetEntityPlayerState(hit);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4156
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 4152
ADDRLP4 4156
INDIRP4
ASGNP4
line 124
;124:		if (!ps) continue;
ADDRLP4 4152
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $129
ADDRGP4 $126
JUMPV
LABELV $129
line 125
;125:		if (ps->stats[STAT_HEALTH] <= 0) continue;
ADDRLP4 4152
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $131
ADDRGP4 $126
JUMPV
LABELV $131
line 126
;126:		if (ps->persistant[PERS_TEAM] == TEAM_SPECTATOR) continue;
ADDRLP4 4152
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 3
NEI4 $133
ADDRGP4 $126
JUMPV
LABELV $133
line 127
;127:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $120
JUMPV
LABELV $126
line 119
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $128
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $125
line 129
;128:	}
;129:	return qfalse;
CNSTI4 0
RETI4
LABELV $120
endproc PositionWouldTelefrag 4160 16
data
align 4
LABELV $197
byte 4 3245342720
byte 4 3245342720
byte 4 3250585600
align 4
LABELV $198
byte 4 1097859072
byte 4 1097859072
byte 4 1097859072
bss
align 4
LABELV $199
skip 844
code
proc SelectSpawnPointFromList 1012 28
line 173
;130:}
;131:
;132:/*
;133:================
;134:SelectNearestDeathmatchSpawnPoint
;135:
;136:Find the spot that we DON'T want to use
;137:================
;138:*/
;139:#if 0	// JUHOX: SelectNearestDeathmatchSpawnPoint() no longer used
;140:#define	MAX_SPAWN_POINTS	128
;141:gentity_t *SelectNearestDeathmatchSpawnPoint( vec3_t from ) {
;142:	gentity_t	*spot;
;143:	vec3_t		delta;
;144:	float		dist, nearestDist;
;145:	gentity_t	*nearestSpot;
;146:
;147:	nearestDist = 999999;
;148:	nearestSpot = NULL;
;149:	spot = NULL;
;150:
;151:	while ((spot = G_Find (spot, FOFS(classname), "info_player_deathmatch")) != NULL) {
;152:
;153:		VectorSubtract( spot->s.origin, from, delta );
;154:		dist = VectorLength( delta );
;155:		if ( dist < nearestDist ) {
;156:			nearestDist = dist;
;157:			nearestSpot = spot;
;158:		}
;159:	}
;160:
;161:	return nearestSpot;
;162:}
;163:#endif
;164:
;165:
;166:/*
;167:================
;168:JUHOX: SelectSpawnPointFromList
;169:================
;170:*/
;171:static gentity_t* SelectSpawnPointFromList(
;172:	const char* const* names, const vec3_t avoidPoint, localseed_t* seed, qboolean acceptAny, qboolean emergency
;173:) {
line 184
;174:	qboolean useAvoidPoint;
;175:	int i;
;176:	float limit;
;177:	int numSpots1;
;178:	int numSpots2;
;179:	gentity_t* selected1;
;180:	gentity_t* selected2;
;181:	localseed_t seed1;
;182:	localseed_t seed2;
;183:
;184:	useAvoidPoint = !acceptAny && avoidPoint && VectorLengthSquared(avoidPoint) > 0.0001;
ADDRFP4 12
INDIRI4
CNSTI4 0
NEI4 $137
ADDRLP4 64
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $137
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 68
INDIRF4
CNSTF4 953267991
LEF4 $137
ADDRLP4 60
CNSTI4 1
ASGNI4
ADDRGP4 $138
JUMPV
LABELV $137
ADDRLP4 60
CNSTI4 0
ASGNI4
LABELV $138
ADDRLP4 36
ADDRLP4 60
INDIRI4
ASGNI4
line 187
;185:
;186:	// set the distance limit
;187:	limit = 0;
ADDRLP4 16
CNSTF4 0
ASGNF4
line 188
;188:	if (useAvoidPoint) {
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $139
line 189
;189:		for (i = MAX_CLIENTS; i < level.num_entities; i++) {
ADDRLP4 0
CNSTI4 64
ASGNI4
ADDRGP4 $144
JUMPV
LABELV $141
line 194
;190:			gentity_t* ent;
;191:			const char* const* name;
;192:			float distance;
;193:
;194:			ent = &g_entities[i];
ADDRLP4 76
ADDRLP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 195
;195:			if (!ent->inuse) continue;
ADDRLP4 76
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $146
ADDRGP4 $142
JUMPV
LABELV $146
line 197
;196:
;197:			name = names;
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $149
JUMPV
LABELV $148
line 198
;198:			while (*name) {
line 199
;199:				if (!Q_stricmp(*name, ent->classname)) break;
ADDRLP4 72
INDIRP4
INDIRP4
ARGP4
ADDRLP4 76
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ARGP4
ADDRLP4 84
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
NEI4 $151
ADDRGP4 $150
JUMPV
LABELV $151
line 200
;200:				name++;
ADDRLP4 72
ADDRLP4 72
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
line 201
;201:			}
LABELV $149
line 198
ADDRLP4 72
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $148
LABELV $150
line 202
;202:			if (!*name) continue;
ADDRLP4 72
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $153
ADDRGP4 $142
JUMPV
LABELV $153
line 204
;203:
;204:			distance = Distance(ent->s.origin, avoidPoint);
ADDRLP4 76
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 84
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRLP4 80
ADDRLP4 84
INDIRF4
ASGNF4
line 205
;205:			if (distance > limit) limit = distance;
ADDRLP4 80
INDIRF4
ADDRLP4 16
INDIRF4
LEF4 $155
ADDRLP4 16
ADDRLP4 80
INDIRF4
ASGNF4
LABELV $155
line 206
;206:		}
LABELV $142
line 189
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $144
ADDRLP4 0
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $141
line 208
;207:
;208:		limit /= 2;
ADDRLP4 16
ADDRLP4 16
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 209
;209:		if (limit < 400) limit = 400;
ADDRLP4 16
INDIRF4
CNSTF4 1137180672
GEF4 $157
ADDRLP4 16
CNSTF4 1137180672
ASGNF4
LABELV $157
line 210
;210:	}
LABELV $139
line 212
;211:
;212:	numSpots1 = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 213
;213:	numSpots2 = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 214
;214:	selected1 = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 215
;215:	selected2 = NULL;
ADDRLP4 56
CNSTP4 0
ASGNP4
line 217
;216:
;217:	DeriveLocalSeed(seed, &seed1);
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 DeriveLocalSeed
CALLV
pop
line 218
;218:	DeriveLocalSeed(seed, &seed2);
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 40
ARGP4
ADDRGP4 DeriveLocalSeed
CALLV
pop
line 220
;219:
;220:	for (i = MAX_CLIENTS; i < level.num_entities; i++) {
ADDRLP4 0
CNSTI4 64
ASGNI4
ADDRGP4 $162
JUMPV
LABELV $159
line 224
;221:		gentity_t* ent;
;222:		const char* const* name;
;223:
;224:		ent = &g_entities[i];
ADDRLP4 76
ADDRLP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 225
;225:		if (!ent->inuse) continue;
ADDRLP4 76
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $164
ADDRGP4 $160
JUMPV
LABELV $164
line 227
;226:
;227:		name = names;
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $167
JUMPV
LABELV $166
line 228
;228:		while (*name) {
line 229
;229:			if (!Q_stricmp(*name, ent->classname)) break;
ADDRLP4 72
INDIRP4
INDIRP4
ARGP4
ADDRLP4 76
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ARGP4
ADDRLP4 80
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 0
NEI4 $169
ADDRGP4 $168
JUMPV
LABELV $169
line 230
;230:			name++;
ADDRLP4 72
ADDRLP4 72
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
line 231
;231:		}
LABELV $167
line 228
ADDRLP4 72
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $166
LABELV $168
line 232
;232:		if (!*name) continue;
ADDRLP4 72
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $171
ADDRGP4 $160
JUMPV
LABELV $171
line 234
;233:
;234:		numSpots1++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 235
;235:		if (LocallySeededRandom(&seed1) % numSpots1 == 0) selected1 = ent;
ADDRLP4 20
ARGP4
ADDRLP4 80
ADDRGP4 LocallySeededRandom
CALLU4
ASGNU4
ADDRLP4 80
INDIRU4
ADDRLP4 4
INDIRI4
CVIU4 4
MODU4
CNSTU4 0
NEU4 $173
ADDRLP4 8
ADDRLP4 76
INDIRP4
ASGNP4
LABELV $173
line 237
;236:
;237:		if (useAvoidPoint && Distance(ent->s.origin, avoidPoint) < limit) {
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $175
ADDRLP4 76
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 84
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRLP4 84
INDIRF4
ADDRLP4 16
INDIRF4
GEF4 $175
line 238
;238:			if (selected1 == ent) selected1 = NULL;
ADDRLP4 8
INDIRP4
CVPU4 4
ADDRLP4 76
INDIRP4
CVPU4 4
NEU4 $160
ADDRLP4 8
CNSTP4 0
ASGNP4
line 239
;239:			continue;
ADDRGP4 $160
JUMPV
LABELV $175
line 242
;240:		}
;241:
;242:		if (!acceptAny && SpotWouldTelefrag(ent)) {
ADDRFP4 12
INDIRI4
CNSTI4 0
NEI4 $179
ADDRLP4 76
INDIRP4
ARGP4
ADDRLP4 88
ADDRGP4 SpotWouldTelefrag
CALLI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 0
EQI4 $179
line 243
;243:			if (selected1 == ent) selected1 = NULL;
ADDRLP4 8
INDIRP4
CVPU4 4
ADDRLP4 76
INDIRP4
CVPU4 4
NEU4 $160
ADDRLP4 8
CNSTP4 0
ASGNP4
line 244
;244:			continue;
ADDRGP4 $160
JUMPV
LABELV $179
line 247
;245:		}
;246:
;247:		numSpots2++;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 248
;248:		if (LocallySeededRandom(&seed2) % numSpots2 == 0) selected2 = ent;
ADDRLP4 40
ARGP4
ADDRLP4 92
ADDRGP4 LocallySeededRandom
CALLU4
ASGNU4
ADDRLP4 92
INDIRU4
ADDRLP4 12
INDIRI4
CVIU4 4
MODU4
CNSTU4 0
NEU4 $183
ADDRLP4 56
ADDRLP4 76
INDIRP4
ASGNP4
LABELV $183
line 249
;249:	}
LABELV $160
line 220
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $162
ADDRLP4 0
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $159
line 250
;250:	if (!selected1) selected1 = selected2;
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $185
ADDRLP4 8
ADDRLP4 56
INDIRP4
ASGNP4
LABELV $185
line 252
;251:
;252:	if ((!selected1 || acceptAny) && emergency) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $189
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $187
LABELV $189
ADDRFP4 16
INDIRI4
CNSTI4 0
EQI4 $187
line 253
;253:		if (!selected1) numSpots1 = 0;
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $190
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $190
line 254
;254:		for (i = 0; i < level.numEmergencySpawnPoints; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $195
JUMPV
LABELV $192
line 263
;255:			static vec3_t mins = { -15, -15, -24 };
;256:			static vec3_t maxs = {  15,  15,  15 };
;257:			static gentity_t spawnpoint;
;258:			vec3_t start;
;259:			vec3_t end;
;260:			trace_t trace;
;261:			gentity_t testpoint;
;262:
;263:			VectorCopy(level.emergencySpawnPoints[i], start);
ADDRLP4 128
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 level+10704
ADDP4
INDIRB
ASGNB 12
line 264
;264:			start[2] += 9;
ADDRLP4 128+8
ADDRLP4 128+8
INDIRF4
CNSTF4 1091567616
ADDF4
ASGNF4
line 265
;265:			VectorCopy(start, end);
ADDRLP4 140
ADDRLP4 128
INDIRB
ASGNB 12
line 266
;266:			end[2] -= 8000;
ADDRLP4 140+8
ADDRLP4 140+8
INDIRF4
CNSTF4 1174011904
SUBF4
ASGNF4
line 268
;267:
;268:			trap_Trace(&trace, start, mins, maxs, end, -1, MASK_PLAYERSOLID|CONTENTS_TRIGGER|CONTENTS_LAVA|CONTENTS_SLIME);
ADDRLP4 72
ARGP4
ADDRLP4 128
ARGP4
ADDRGP4 $197
ARGP4
ADDRGP4 $198
ARGP4
ADDRLP4 140
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 1107361817
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 270
;269:			if (
;270:				trace.allsolid ||
ADDRLP4 72
INDIRI4
CNSTI4 0
NEI4 $210
ADDRLP4 72+4
INDIRI4
CNSTI4 0
NEI4 $210
ADDRLP4 72+8
INDIRF4
CNSTF4 1065353216
GEF4 $210
ADDRLP4 72+48
INDIRI4
CNSTI4 1073741848
BANDI4
CNSTI4 0
EQI4 $203
LABELV $210
line 274
;271:				trace.startsolid ||
;272:				trace.fraction >= 1 ||
;273:				(trace.contents & (CONTENTS_TRIGGER|CONTENTS_LAVA|CONTENTS_SLIME))
;274:			) continue;
ADDRGP4 $193
JUMPV
LABELV $203
line 276
;275:
;276:			if (trap_PointContents(trace.endpos, -1) & (CONTENTS_TRIGGER|CONTENTS_LAVA|CONTENTS_SLIME)) continue;
ADDRLP4 72+12
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 996
ADDRGP4 trap_PointContents
CALLI4
ASGNI4
ADDRLP4 996
INDIRI4
CNSTI4 1073741848
BANDI4
CNSTI4 0
EQI4 $211
ADDRGP4 $193
JUMPV
LABELV $211
line 278
;277:
;278:			VectorCopy(trace.endpos, testpoint.s.origin);
ADDRLP4 152+92
ADDRLP4 72+12
INDIRB
ASGNB 12
line 279
;279:			if (!acceptAny && SpotWouldTelefrag(&testpoint)) continue;
ADDRFP4 12
INDIRI4
CNSTI4 0
NEI4 $216
ADDRLP4 152
ARGP4
ADDRLP4 1000
ADDRGP4 SpotWouldTelefrag
CALLI4
ASGNI4
ADDRLP4 1000
INDIRI4
CNSTI4 0
EQI4 $216
ADDRGP4 $193
JUMPV
LABELV $216
line 281
;280:
;281:			numSpots1++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 282
;282:			if (LocallySeededRandom(&seed1) % numSpots1 == 0) {
ADDRLP4 20
ARGP4
ADDRLP4 1004
ADDRGP4 LocallySeededRandom
CALLU4
ASGNU4
ADDRLP4 1004
INDIRU4
ADDRLP4 4
INDIRI4
CVIU4 4
MODU4
CNSTU4 0
NEU4 $218
line 283
;283:				VectorCopy(trace.endpos, spawnpoint.s.origin);
ADDRGP4 $199+92
ADDRLP4 72+12
INDIRB
ASGNB 12
line 284
;284:				spawnpoint.s.angles[YAW] = 360 * random();
ADDRLP4 1008
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRGP4 $199+116+4
ADDRLP4 1008
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 1008
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1135869952
MULF4
ASGNF4
line 285
;285:				spawnpoint.s.angles[PITCH] = 0;
ADDRGP4 $199+116
CNSTF4 0
ASGNF4
line 286
;286:				spawnpoint.s.angles[ROLL] = 0;
ADDRGP4 $199+116+8
CNSTF4 0
ASGNF4
line 287
;287:				selected1 = &spawnpoint;
ADDRLP4 8
ADDRGP4 $199
ASGNP4
line 288
;288:			}
LABELV $218
line 289
;289:		}
LABELV $193
line 254
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $195
ADDRLP4 0
INDIRI4
ADDRGP4 level+10700
INDIRI4
LTI4 $192
line 290
;290:	}
LABELV $187
line 292
;291:
;292:	return selected1;
ADDRLP4 8
INDIRP4
RETP4
LABELV $135
endproc SelectSpawnPointFromList 1012 28
data
align 4
LABELV $228
address $99
address $97
address $229
address $230
address $231
address $232
byte 4 0
align 4
LABELV $233
address $97
address $229
address $230
byte 4 0
align 4
LABELV $234
address $99
address $97
byte 4 0
align 4
LABELV $235
address $97
byte 4 0
align 4
LABELV $236
address $229
address $231
byte 4 0
align 4
LABELV $237
address $229
byte 4 0
align 4
LABELV $238
address $230
address $232
byte 4 0
align 4
LABELV $239
address $230
byte 4 0
export SelectAppropriateSpawnPoint
code
proc SelectAppropriateSpawnPoint 168 20
line 300
;293:}
;294:
;295:/*
;296:================
;297:JUHOX: SelectAppropriateSpawnPoint
;298:================
;299:*/
;300:gentity_t* SelectAppropriateSpawnPoint(team_t team, const vec3_t avoidPoint, qboolean initialSpawn) {
line 346
;301:	static const char* const anyList[] = {
;302:		"info_player_deathmatch",
;303:		"info_player_initial",
;304:		"team_CTF_redplayer",
;305:		"team_CTF_blueplayer",
;306:		"team_CTF_redspawn",
;307:		"team_CTF_bluespawn",
;308:		NULL
;309:	};
;310:	static const char* const anyInitialList[] = {
;311:		"info_player_initial",
;312:		"team_CTF_redplayer",
;313:		"team_CTF_blueplayer",
;314:		NULL
;315:	};
;316:	static const char* const nonTeamList[] = {
;317:		"info_player_deathmatch",
;318:		"info_player_initial",
;319:		NULL
;320:	};
;321:	static const char* const nonTeamInitialList[] = {
;322:		"info_player_initial",
;323:		NULL
;324:	};
;325:	static const char* const teamRedList[] = {
;326:		"team_CTF_redplayer",
;327:		"team_CTF_redspawn",
;328:		NULL
;329:	};
;330:	static const char* const teamRedInitialList[] = {
;331:		"team_CTF_redplayer",
;332:		NULL
;333:	};
;334:	static const char* const teamBlueList[] = {
;335:		"team_CTF_blueplayer",
;336:		"team_CTF_bluespawn",
;337:		NULL
;338:	};
;339:	static const char* const teamBlueInitialList[] = {
;340:		"team_CTF_blueplayer",
;341:		NULL
;342:	};
;343:	localseed_t seed1, seed2, seed3, seed4, seed5, seed6;
;344:	gentity_t* spot;
;345:
;346:	spot = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
line 348
;347:#if ESCAPE_MODE
;348:	if (g_gametype.integer == GT_EFH) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
NEI4 $240
line 355
;349:		int i;
;350:		vec3_t spaceMins;
;351:		vec3_t spaceMaxs;
;352:		long bestWayLength;
;353:		int numSpots;
;354:
;355:		G_EFH_SpaceExtent(spaceMins, spaceMaxs);
ADDRLP4 104
ARGP4
ADDRLP4 116
ARGP4
ADDRGP4 G_EFH_SpaceExtent
CALLV
pop
line 356
;356:		InitLocalSeed(GST_playerSpawning, &seed1);
CNSTI4 2
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 InitLocalSeed
CALLV
pop
line 357
;357:		numSpots = 0;
ADDRLP4 128
CNSTI4 0
ASGNI4
line 358
;358:		bestWayLength = 0;
ADDRLP4 132
CNSTI4 0
ASGNI4
line 360
;359:
;360:		for (i = MAX_CLIENTS; i < level.num_entities; i++) {
ADDRLP4 100
CNSTI4 64
ASGNI4
ADDRGP4 $246
JUMPV
LABELV $243
line 365
;361:			gentity_t* ent;
;362:			const char* const* name;
;363:			long wayLength;
;364:
;365:			ent = &g_entities[i];
ADDRLP4 140
ADDRLP4 100
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 366
;366:			if (!ent->inuse) continue;
ADDRLP4 140
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $248
ADDRGP4 $244
JUMPV
LABELV $248
line 368
;367:
;368:			name = anyList;
ADDRLP4 136
ADDRGP4 $228
ASGNP4
ADDRGP4 $251
JUMPV
LABELV $250
line 369
;369:			while (*name) {
line 370
;370:				if (!Q_stricmp(*name, ent->classname)) break;
ADDRLP4 136
INDIRP4
INDIRP4
ARGP4
ADDRLP4 140
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ARGP4
ADDRLP4 148
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $253
ADDRGP4 $252
JUMPV
LABELV $253
line 371
;371:				name++;
ADDRLP4 136
ADDRLP4 136
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
line 372
;372:			}
LABELV $251
line 369
ADDRLP4 136
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $250
LABELV $252
line 373
;373:			if (!*name) continue;
ADDRLP4 136
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $255
ADDRGP4 $244
JUMPV
LABELV $255
line 376
;374:
;375:			if (
;376:				ent->s.origin[0] <= spaceMins[0] ||
ADDRLP4 140
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ADDRLP4 104
INDIRF4
LEF4 $267
ADDRLP4 140
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ADDRLP4 116
INDIRF4
GEF4 $267
ADDRLP4 140
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ADDRLP4 104+4
INDIRF4
LEF4 $267
ADDRLP4 140
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ADDRLP4 116+4
INDIRF4
GEF4 $267
ADDRLP4 140
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ADDRLP4 104+8
INDIRF4
LEF4 $267
ADDRLP4 140
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ADDRLP4 116+8
INDIRF4
LTF4 $257
LABELV $267
line 382
;377:				ent->s.origin[0] >= spaceMaxs[0] ||
;378:				ent->s.origin[1] <= spaceMins[1] ||
;379:				ent->s.origin[1] >= spaceMaxs[1] ||
;380:				ent->s.origin[2] <= spaceMins[2] ||
;381:				ent->s.origin[2] >= spaceMaxs[2]
;382:			) {
line 383
;383:				continue;
ADDRGP4 $244
JUMPV
LABELV $257
line 385
;384:			}
;385:			if (G_FindSegment(ent->s.origin, NULL) < 0) continue;
ADDRLP4 140
INDIRP4
CNSTI4 92
ADDP4
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 152
ADDRGP4 G_FindSegment
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
GEI4 $268
ADDRGP4 $244
JUMPV
LABELV $268
line 387
;386:
;387:			if (SpotWouldTelefrag(ent)) continue;
ADDRLP4 140
INDIRP4
ARGP4
ADDRLP4 156
ADDRGP4 SpotWouldTelefrag
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
EQI4 $270
ADDRGP4 $244
JUMPV
LABELV $270
line 389
;388:
;389:			wayLength = G_GetTotalWayLength(ent);
ADDRLP4 140
INDIRP4
ARGP4
ADDRLP4 160
ADDRGP4 G_GetTotalWayLength
CALLI4
ASGNI4
ADDRLP4 144
ADDRLP4 160
INDIRI4
ASGNI4
line 391
;390:
;391:			if (spot) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $272
line 392
;392:				if (level.intermissiontime) {
ADDRGP4 level+9144
INDIRI4
CNSTI4 0
EQI4 $274
line 393
;393:					if (wayLength < bestWayLength + 32) continue;
ADDRLP4 144
INDIRI4
ADDRLP4 132
INDIRI4
CNSTI4 32
ADDI4
GEI4 $277
ADDRGP4 $244
JUMPV
LABELV $277
line 394
;394:					if (wayLength < bestWayLength - 32) {
ADDRLP4 144
INDIRI4
ADDRLP4 132
INDIRI4
CNSTI4 32
SUBI4
GEI4 $273
line 395
;395:						numSpots = 0;
ADDRLP4 128
CNSTI4 0
ASGNI4
line 396
;396:						bestWayLength = wayLength;
ADDRLP4 132
ADDRLP4 144
INDIRI4
ASGNI4
line 397
;397:					}
line 398
;398:				}
ADDRGP4 $273
JUMPV
LABELV $274
line 399
;399:				else {
line 400
;400:					if (wayLength > bestWayLength - 32) continue;
ADDRLP4 144
INDIRI4
ADDRLP4 132
INDIRI4
CNSTI4 32
SUBI4
LEI4 $281
ADDRGP4 $244
JUMPV
LABELV $281
line 401
;401:					if (wayLength > bestWayLength + 32) {
ADDRLP4 144
INDIRI4
ADDRLP4 132
INDIRI4
CNSTI4 32
ADDI4
LEI4 $273
line 402
;402:						numSpots = 0;
ADDRLP4 128
CNSTI4 0
ASGNI4
line 403
;403:						bestWayLength = wayLength;
ADDRLP4 132
ADDRLP4 144
INDIRI4
ASGNI4
line 404
;404:					}
line 405
;405:				}
line 406
;406:			}
ADDRGP4 $273
JUMPV
LABELV $272
line 407
;407:			else {
line 408
;408:				bestWayLength = wayLength;
ADDRLP4 132
ADDRLP4 144
INDIRI4
ASGNI4
line 409
;409:			}
LABELV $273
line 411
;410:
;411:			numSpots++;
ADDRLP4 128
ADDRLP4 128
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 412
;412:			if (LocallySeededRandom(&seed1) % numSpots) continue;
ADDRLP4 4
ARGP4
ADDRLP4 164
ADDRGP4 LocallySeededRandom
CALLU4
ASGNU4
ADDRLP4 164
INDIRU4
ADDRLP4 128
INDIRI4
CVIU4 4
MODU4
CNSTU4 0
EQU4 $285
ADDRGP4 $244
JUMPV
LABELV $285
line 414
;413:
;414:			spot = ent;
ADDRLP4 0
ADDRLP4 140
INDIRP4
ASGNP4
line 415
;415:		}
LABELV $244
line 360
ADDRLP4 100
ADDRLP4 100
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $246
ADDRLP4 100
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $243
line 417
;416:
;417:		initialSpawn = qfalse;
ADDRFP4 8
CNSTI4 0
ASGNI4
line 418
;418:		avoidPoint = NULL;
ADDRFP4 4
CNSTP4 0
ASGNP4
line 419
;419:	}
ADDRGP4 $241
JUMPV
LABELV $240
line 422
;420:	else
;421:#endif
;422:	if (g_gametype.integer >= GT_TEAM && g_gametype.integer <= GT_CTF) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $287
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
GTI4 $287
line 424
;423:		// team games
;424:		switch (team) {
ADDRLP4 100
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 1
EQI4 $294
ADDRLP4 100
INDIRI4
CNSTI4 2
EQI4 $301
ADDRGP4 $308
JUMPV
LABELV $294
line 426
;425:		case TEAM_RED:
;426:			InitLocalSeed(GST_redPlayerSpawning, &seed1);
CNSTI4 3
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 InitLocalSeed
CALLV
pop
line 427
;427:			InitLocalSeed(GST_redPlayerSpawning, &seed2);
CNSTI4 3
ARGI4
ADDRLP4 68
ARGP4
ADDRGP4 InitLocalSeed
CALLV
pop
line 428
;428:			InitLocalSeed(GST_redPlayerSpawning, &seed3);
CNSTI4 3
ARGI4
ADDRLP4 84
ARGP4
ADDRGP4 InitLocalSeed
CALLV
pop
line 429
;429:			InitLocalSeed(GST_redPlayerSpawning, &seed4);
CNSTI4 3
ARGI4
ADDRLP4 36
ARGP4
ADDRGP4 InitLocalSeed
CALLV
pop
line 430
;430:			InitLocalSeed(GST_redPlayerSpawning, &seed5);
CNSTI4 3
ARGI4
ADDRLP4 52
ARGP4
ADDRGP4 InitLocalSeed
CALLV
pop
line 431
;431:			InitLocalSeed(GST_redPlayerSpawning, &seed6);
CNSTI4 3
ARGI4
ADDRLP4 20
ARGP4
ADDRGP4 InitLocalSeed
CALLV
pop
line 433
;432:
;433:			if (initialSpawn) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $295
line 434
;434:				spot = SelectSpawnPointFromList(teamRedInitialList, avoidPoint, &seed1, qfalse, qfalse);
ADDRGP4 $237
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 108
ADDRGP4 SelectSpawnPointFromList
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 108
INDIRP4
ASGNP4
line 435
;435:			}
LABELV $295
line 436
;436:			if (!spot) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $288
line 437
;437:				spot = SelectSpawnPointFromList(teamRedList, avoidPoint, &seed2, qfalse, qfalse);
ADDRGP4 $236
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 68
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 108
ADDRGP4 SelectSpawnPointFromList
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 108
INDIRP4
ASGNP4
line 438
;438:				if (!spot && avoidPoint) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $288
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $288
line 439
;439:					spot = SelectSpawnPointFromList(teamRedList, NULL, &seed3, qfalse, qfalse);
ADDRGP4 $236
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 84
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 112
ADDRGP4 SelectSpawnPointFromList
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 112
INDIRP4
ASGNP4
line 440
;440:				}
line 441
;441:			}
line 442
;442:			break;
ADDRGP4 $288
JUMPV
LABELV $301
line 444
;443:		case TEAM_BLUE:
;444:			InitLocalSeed(GST_bluePlayerSpawning, &seed1);
CNSTI4 4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 InitLocalSeed
CALLV
pop
line 445
;445:			InitLocalSeed(GST_bluePlayerSpawning, &seed2);
CNSTI4 4
ARGI4
ADDRLP4 68
ARGP4
ADDRGP4 InitLocalSeed
CALLV
pop
line 446
;446:			InitLocalSeed(GST_bluePlayerSpawning, &seed3);
CNSTI4 4
ARGI4
ADDRLP4 84
ARGP4
ADDRGP4 InitLocalSeed
CALLV
pop
line 447
;447:			InitLocalSeed(GST_bluePlayerSpawning, &seed4);
CNSTI4 4
ARGI4
ADDRLP4 36
ARGP4
ADDRGP4 InitLocalSeed
CALLV
pop
line 448
;448:			InitLocalSeed(GST_bluePlayerSpawning, &seed5);
CNSTI4 4
ARGI4
ADDRLP4 52
ARGP4
ADDRGP4 InitLocalSeed
CALLV
pop
line 449
;449:			InitLocalSeed(GST_bluePlayerSpawning, &seed6);
CNSTI4 4
ARGI4
ADDRLP4 20
ARGP4
ADDRGP4 InitLocalSeed
CALLV
pop
line 451
;450:
;451:			if (initialSpawn) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $302
line 452
;452:				spot = SelectSpawnPointFromList(teamBlueInitialList, avoidPoint, &seed1, qfalse, qfalse);
ADDRGP4 $239
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 108
ADDRGP4 SelectSpawnPointFromList
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 108
INDIRP4
ASGNP4
line 453
;453:			}
LABELV $302
line 454
;454:			if (!spot) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $288
line 455
;455:				spot = SelectSpawnPointFromList(teamBlueList, avoidPoint, &seed2, qfalse, qfalse);
ADDRGP4 $238
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 68
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 108
ADDRGP4 SelectSpawnPointFromList
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 108
INDIRP4
ASGNP4
line 456
;456:				if (!spot && avoidPoint) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $288
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $288
line 457
;457:					spot = SelectSpawnPointFromList(teamBlueList, NULL, &seed3, qfalse, qfalse);
ADDRGP4 $238
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 84
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 112
ADDRGP4 SelectSpawnPointFromList
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 112
INDIRP4
ASGNP4
line 458
;458:				}
line 459
;459:			}
line 460
;460:			break;
line 462
;461:		default:
;462:			goto NonTeamSpawn;
line 464
;463:		}
;464:	}
ADDRGP4 $288
JUMPV
LABELV $287
line 465
;465:	else {
LABELV $308
line 468
;466:		// non-team games
;467:		NonTeamSpawn:
;468:		InitLocalSeed(GST_playerSpawning, &seed1);
CNSTI4 2
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 InitLocalSeed
CALLV
pop
line 469
;469:		InitLocalSeed(GST_playerSpawning, &seed2);
CNSTI4 2
ARGI4
ADDRLP4 68
ARGP4
ADDRGP4 InitLocalSeed
CALLV
pop
line 470
;470:		InitLocalSeed(GST_playerSpawning, &seed3);
CNSTI4 2
ARGI4
ADDRLP4 84
ARGP4
ADDRGP4 InitLocalSeed
CALLV
pop
line 471
;471:		InitLocalSeed(GST_playerSpawning, &seed4);
CNSTI4 2
ARGI4
ADDRLP4 36
ARGP4
ADDRGP4 InitLocalSeed
CALLV
pop
line 472
;472:		InitLocalSeed(GST_playerSpawning, &seed5);
CNSTI4 2
ARGI4
ADDRLP4 52
ARGP4
ADDRGP4 InitLocalSeed
CALLV
pop
line 473
;473:		InitLocalSeed(GST_playerSpawning, &seed6);
CNSTI4 2
ARGI4
ADDRLP4 20
ARGP4
ADDRGP4 InitLocalSeed
CALLV
pop
line 475
;474:
;475:		if (initialSpawn) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $309
line 476
;476:			spot = SelectSpawnPointFromList(nonTeamInitialList, avoidPoint, &seed1, qfalse, qfalse);
ADDRGP4 $235
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 100
ADDRGP4 SelectSpawnPointFromList
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 100
INDIRP4
ASGNP4
line 477
;477:		}
LABELV $309
line 478
;478:		if (!spot) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $311
line 479
;479:			spot = SelectSpawnPointFromList(nonTeamList, avoidPoint, &seed2, qfalse, qfalse);
ADDRGP4 $234
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 68
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 100
ADDRGP4 SelectSpawnPointFromList
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 100
INDIRP4
ASGNP4
line 480
;480:			if (!spot && avoidPoint) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $313
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $313
line 481
;481:				spot = SelectSpawnPointFromList(nonTeamList, NULL, &seed3, qfalse, qfalse);
ADDRGP4 $234
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 84
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 104
ADDRGP4 SelectSpawnPointFromList
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 104
INDIRP4
ASGNP4
line 482
;482:			}
LABELV $313
line 483
;483:		}
LABELV $311
line 484
;484:	}
LABELV $288
LABELV $241
line 486
;485:
;486:	if (!spot && initialSpawn) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $315
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $315
line 487
;487:		spot = SelectSpawnPointFromList(anyInitialList, avoidPoint, &seed4, qfalse, qfalse);
ADDRGP4 $233
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 36
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 100
ADDRGP4 SelectSpawnPointFromList
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 100
INDIRP4
ASGNP4
line 488
;488:	}
LABELV $315
line 489
;489:	if (!spot) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $317
line 490
;490:		spot = SelectSpawnPointFromList(anyList, avoidPoint, &seed5, qfalse, qfalse);
ADDRGP4 $228
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 52
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 100
ADDRGP4 SelectSpawnPointFromList
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 100
INDIRP4
ASGNP4
line 491
;491:		if (!spot && avoidPoint) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $319
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $319
line 492
;492:			spot = SelectSpawnPointFromList(anyList, NULL, &seed6, qfalse, qfalse);
ADDRGP4 $228
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 20
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 104
ADDRGP4 SelectSpawnPointFromList
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 104
INDIRP4
ASGNP4
line 493
;493:		}
LABELV $319
line 494
;494:		if (!spot) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $321
line 495
;495:			spot = SelectSpawnPointFromList(anyList, NULL, &seed6, qfalse, qtrue);
ADDRGP4 $228
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 20
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 104
ADDRGP4 SelectSpawnPointFromList
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 104
INDIRP4
ASGNP4
line 496
;496:		}
LABELV $321
line 497
;497:		if (!spot) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $323
line 498
;498:			spot = SelectSpawnPointFromList(anyList, NULL, &seed6, qtrue, qtrue);
ADDRGP4 $228
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 20
ARGP4
CNSTI4 1
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 104
ADDRGP4 SelectSpawnPointFromList
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 104
INDIRP4
ASGNP4
line 499
;499:		}
LABELV $323
line 500
;500:	}
LABELV $317
line 502
;501:
;502:	return spot;
ADDRLP4 0
INDIRP4
RETP4
LABELV $227
endproc SelectAppropriateSpawnPoint 168 20
export SelectRandomFurthestSpawnPoint
proc SelectRandomFurthestSpawnPoint 12 12
line 547
;503:}
;504:
;505:/*
;506:================
;507:SelectRandomDeathmatchSpawnPoint
;508:
;509:go to a random point that doesn't telefrag
;510:================
;511:*/
;512:#if 0	// JUHOX: SelectRandomDeathmatchSpawnPoint() no longer used
;513:#define	MAX_SPAWN_POINTS	128
;514:gentity_t *SelectRandomDeathmatchSpawnPoint( void ) {
;515:	gentity_t	*spot;
;516:	int			count;
;517:	int			selection;
;518:	gentity_t	*spots[MAX_SPAWN_POINTS];
;519:
;520:	count = 0;
;521:	spot = NULL;
;522:
;523:	while ((spot = G_Find (spot, FOFS(classname), "info_player_deathmatch")) != NULL) {
;524:		if ( SpotWouldTelefrag( spot ) ) {
;525:			continue;
;526:		}
;527:		spots[ count ] = spot;
;528:		count++;
;529:	}
;530:
;531:	if ( !count ) {	// no spots that won't telefrag
;532:		return G_Find( NULL, FOFS(classname), "info_player_deathmatch");
;533:	}
;534:
;535:	selection = rand() % count;
;536:	return spots[ selection ];
;537:}
;538:#endif
;539:
;540:/*
;541:===========
;542:SelectRandomFurthestSpawnPoint
;543:
;544:Chooses a player start, deathmatch start, etc
;545:============
;546:*/
;547:gentity_t *SelectRandomFurthestSpawnPoint ( vec3_t avoidPoint, vec3_t origin, vec3_t angles ) {
line 608
;548:#if 0	// JUHOX: use new spawn logic
;549:	gentity_t	*spot;
;550:	vec3_t		delta;
;551:	float		dist;
;552:	float		list_dist[64];
;553:	gentity_t	*list_spot[64];
;554:	int			numSpots, rnd, i, j;
;555:
;556:	numSpots = 0;
;557:	spot = NULL;
;558:
;559:	while ((spot = G_Find (spot, FOFS(classname), "info_player_deathmatch")) != NULL) {
;560:		if ( SpotWouldTelefrag( spot ) ) {
;561:			continue;
;562:		}
;563:		VectorSubtract( spot->s.origin, avoidPoint, delta );
;564:		dist = VectorLength( delta );
;565:		for (i = 0; i < numSpots; i++) {
;566:			if ( dist > list_dist[i] ) {
;567:				if ( numSpots >= 64 )
;568:					numSpots = 64-1;
;569:				for (j = numSpots; j > i; j--) {
;570:					list_dist[j] = list_dist[j-1];
;571:					list_spot[j] = list_spot[j-1];
;572:				}
;573:				list_dist[i] = dist;
;574:				list_spot[i] = spot;
;575:				numSpots++;
;576:				if (numSpots > 64)
;577:					numSpots = 64;
;578:				break;
;579:			}
;580:		}
;581:		if (i >= numSpots && numSpots < 64) {
;582:			list_dist[numSpots] = dist;
;583:			list_spot[numSpots] = spot;
;584:			numSpots++;
;585:		}
;586:	}
;587:	if (!numSpots) {
;588:		spot = G_Find( NULL, FOFS(classname), "info_player_deathmatch");
;589:		if (!spot)
;590:			G_Error( "Couldn't find a spawn point" );
;591:		VectorCopy (spot->s.origin, origin);
;592:		origin[2] += 9;
;593:		VectorCopy (spot->s.angles, angles);
;594:		return spot;
;595:	}
;596:
;597:	// select a random spot from the spawn points furthest away
;598:	rnd = random() * (numSpots / 2);
;599:
;600:	VectorCopy (list_spot[rnd]->s.origin, origin);
;601:	origin[2] += 9;
;602:	VectorCopy (list_spot[rnd]->s.angles, angles);
;603:
;604:	return list_spot[rnd];
;605:#else
;606:	gentity_t* spot;
;607:
;608:	spot = SelectAppropriateSpawnPoint(TEAM_FREE, avoidPoint, qfalse);
CNSTI4 0
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 4
ADDRGP4 SelectAppropriateSpawnPoint
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 609
;609:	if (spot) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $326
line 610
;610:		VectorCopy(spot->s.origin, origin);
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 611
;611:		origin[2] += 9;
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
CNSTF4 1091567616
ADDF4
ASGNF4
line 612
;612:		VectorCopy(spot->s.angles, angles);
ADDRFP4 8
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 613
;613:	}
LABELV $326
line 614
;614:	return spot;
ADDRLP4 0
INDIRP4
RETP4
LABELV $325
endproc SelectRandomFurthestSpawnPoint 12 12
export SelectSpawnPoint
proc SelectSpawnPoint 4 12
line 625
;615:#endif
;616:}
;617:
;618:/*
;619:===========
;620:SelectSpawnPoint
;621:
;622:Chooses a player start, deathmatch start, etc
;623:============
;624:*/
;625:gentity_t *SelectSpawnPoint ( vec3_t avoidPoint, vec3_t origin, vec3_t angles ) {
line 626
;626:	return SelectRandomFurthestSpawnPoint( avoidPoint, origin, angles );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 SelectRandomFurthestSpawnPoint
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
RETP4
LABELV $328
endproc SelectSpawnPoint 4 12
export SelectInitialSpawnPoint
proc SelectInitialSpawnPoint 12 12
line 665
;627:
;628:	/*
;629:	gentity_t	*spot;
;630:	gentity_t	*nearestSpot;
;631:
;632:	nearestSpot = SelectNearestDeathmatchSpawnPoint( avoidPoint );
;633:
;634:	spot = SelectRandomDeathmatchSpawnPoint ( );
;635:	if ( spot == nearestSpot ) {
;636:		// roll again if it would be real close to point of death
;637:		spot = SelectRandomDeathmatchSpawnPoint ( );
;638:		if ( spot == nearestSpot ) {
;639:			// last try
;640:			spot = SelectRandomDeathmatchSpawnPoint ( );
;641:		}		
;642:	}
;643:
;644:	// find a single player start spot
;645:	if (!spot) {
;646:		G_Error( "Couldn't find a spawn point" );
;647:	}
;648:
;649:	VectorCopy (spot->s.origin, origin);
;650:	origin[2] += 9;
;651:	VectorCopy (spot->s.angles, angles);
;652:
;653:	return spot;
;654:	*/
;655:}
;656:
;657:/*
;658:===========
;659:SelectInitialSpawnPoint
;660:
;661:Try to find a spawn point marked 'initial', otherwise
;662:use normal spawn selection.
;663:============
;664:*/
;665:gentity_t *SelectInitialSpawnPoint( vec3_t origin, vec3_t angles ) {
line 688
;666:#if 0	// JUHOX: use new spawn logic
;667:	gentity_t	*spot;
;668:
;669:	spot = NULL;
;670:	while ((spot = G_Find (spot, FOFS(classname), "info_player_deathmatch")) != NULL) {
;671:		if ( spot->spawnflags & 1 ) {
;672:			break;
;673:		}
;674:	}
;675:
;676:	if ( !spot || SpotWouldTelefrag( spot ) ) {
;677:		return SelectSpawnPoint( vec3_origin, origin, angles );
;678:	}
;679:
;680:	VectorCopy (spot->s.origin, origin);
;681:	origin[2] += 9;
;682:	VectorCopy (spot->s.angles, angles);
;683:
;684:	return spot;
;685:#else
;686:	gentity_t* spot;
;687:
;688:	spot = SelectAppropriateSpawnPoint(TEAM_FREE, NULL, qtrue);
CNSTI4 0
ARGI4
CNSTP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 4
ADDRGP4 SelectAppropriateSpawnPoint
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 689
;689:	if (spot) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $330
line 690
;690:		VectorCopy(spot->s.origin, origin);
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 691
;691:		origin[2] += 9;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CNSTF4 1091567616
ADDF4
ASGNF4
line 692
;692:		VectorCopy(spot->s.angles, angles);
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 693
;693:	}
LABELV $330
line 694
;694:	return spot;	
ADDRLP4 0
INDIRP4
RETP4
LABELV $329
endproc SelectInitialSpawnPoint 12 12
export SelectSpectatorSpawnPoint
proc SelectSpectatorSpawnPoint 0 0
line 704
;695:#endif
;696:}
;697:
;698:/*
;699:===========
;700:SelectSpectatorSpawnPoint
;701:
;702:============
;703:*/
;704:gentity_t *SelectSpectatorSpawnPoint( vec3_t origin, vec3_t angles ) {
line 705
;705:	FindIntermissionPoint();
ADDRGP4 FindIntermissionPoint
CALLV
pop
line 707
;706:
;707:	VectorCopy( level.intermission_origin, origin );
ADDRFP4 0
INDIRP4
ADDRGP4 level+9160
INDIRB
ASGNB 12
line 708
;708:	VectorCopy( level.intermission_angle, angles );
ADDRFP4 4
INDIRP4
ADDRGP4 level+9172
INDIRB
ASGNB 12
line 710
;709:
;710:	return NULL;
CNSTP4 0
RETP4
LABELV $332
endproc SelectSpectatorSpawnPoint 0 0
export InitBodyQue
proc InitBodyQue 12 0
line 726
;711:}
;712:
;713:/*
;714:=======================================================================
;715:
;716:BODYQUE
;717:
;718:=======================================================================
;719:*/
;720:
;721:/*
;722:===============
;723:InitBodyQue
;724:===============
;725:*/
;726:void InitBodyQue (void) {
line 730
;727:	int		i;
;728:	gentity_t	*ent;
;729:
;730:	level.bodyQueIndex = 0;
ADDRGP4 level+9192
CNSTI4 0
ASGNI4
line 731
;731:	for (i=0; i<BODY_QUEUE_SIZE ; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $337
line 732
;732:		ent = G_Spawn();
ADDRLP4 8
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 733
;733:		ent->classname = "bodyque";
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
ADDRGP4 $341
ASGNP4
line 734
;734:		ent->neverFree = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 536
ADDP4
CNSTI4 1
ASGNI4
line 735
;735:		level.bodyQue[i] = ent;
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+9196
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 736
;736:	}
LABELV $338
line 731
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 16
LTI4 $337
line 737
;737:}
LABELV $335
endproc InitBodyQue 12 0
export BodySink
proc BodySink 12 4
line 746
;738:
;739:/*
;740:=============
;741:BodySink
;742:
;743:After sitting around for five seconds, fall into the ground and dissapear
;744:=============
;745:*/
;746:void BodySink( gentity_t *ent ) {
line 759
;747:#if 0	// JUHOX: new, predictable method of body sinking
;748:	if ( level.time - ent->timestamp > 6500 ) {
;749:		// the body ques are never actually freed, they are just unlinked
;750:		trap_UnlinkEntity( ent );
;751:		ent->physicsObject = qfalse;
;752:		return;	
;753:	}
;754:	ent->nextthink = level.time + 100;
;755:	ent->s.pos.trBase[2] -= 1;
;756:#else
;757:	int sinktime;
;758:
;759:	if (ent->s.pos.trType == TR_LINEAR_STOP) {
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 3
NEI4 $344
line 760
;760:		trap_UnlinkEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 761
;761:		ent->physicsObject = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 568
ADDP4
CNSTI4 0
ASGNI4
line 762
;762:		return;
ADDRGP4 $343
JUMPV
LABELV $344
line 765
;763:	}
;764:
;765:	sinktime = 3000;
ADDRLP4 0
CNSTI4 3000
ASGNI4
line 767
;766:#if MONSTER_MODE
;767:	switch (ent->s.clientNum) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 65
EQI4 $349
ADDRLP4 4
INDIRI4
CNSTI4 66
EQI4 $350
ADDRGP4 $346
JUMPV
LABELV $349
line 769
;768:	case CLIENTNUM_MONSTER_GUARD:
;769:		sinktime *= MONSTER_GUARD_SCALE;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1073741824
MULF4
CVFI4 4
ASGNI4
line 770
;770:		break;
ADDRGP4 $347
JUMPV
LABELV $350
line 772
;771:	case CLIENTNUM_MONSTER_TITAN:
;772:		sinktime *= MONSTER_TITAN_SCALE;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1080033280
MULF4
CVFI4 4
ASGNI4
line 773
;773:		break;
LABELV $346
LABELV $347
line 776
;774:	}
;775:#endif
;776:	ent->nextthink = level.time + sinktime;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 778
;777:
;778:	ent->s.pos.trType = TR_LINEAR_STOP;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 3
ASGNI4
line 779
;779:	ent->s.pos.trTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 780
;780:	ent->s.pos.trDuration = sinktime;
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 781
;781:	VectorSet(ent->s.pos.trDelta, 0, 0, -10);
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 0
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 0
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
CNSTF4 3240099840
ASGNF4
line 782
;782:	trap_LinkEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 784
;783:#endif
;784:}
LABELV $343
endproc BodySink 12 4
export CopyToBodyQue
proc CopyToBodyQue 48 8
line 794
;785:
;786:/*
;787:=============
;788:CopyToBodyQue
;789:
;790:A player is respawning, so make an entity that looks
;791:just like the existing corpse to leave behind.
;792:=============
;793:*/
;794:void CopyToBodyQue( gentity_t *ent ) {
line 803
;795:#ifdef MISSIONPACK
;796:	gentity_t	*e;
;797:	int i;
;798:#endif
;799:	gentity_t		*body;
;800:	int			contents;
;801:
;802:#if 1	// JUHOX: check the 'corpseProduced' flag
;803:	if (ent->client) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $354
line 804
;804:		if (ent->client->corpseProduced) return;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 980
ADDP4
INDIRI4
CNSTI4 0
EQI4 $356
ADDRGP4 $353
JUMPV
LABELV $356
line 805
;805:		ent->client->corpseProduced = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 980
ADDP4
CNSTI4 1
ASGNI4
line 806
;806:	}
LABELV $354
line 809
;807:#endif
;808:
;809:	trap_UnlinkEntity (ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 812
;810:
;811:	// if client is in a nodrop area, don't leave the body
;812:	contents = trap_PointContents( ent->s.origin, -1 );
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 8
ADDRGP4 trap_PointContents
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 813
;813:	if ( contents & CONTENTS_NODROP ) {
ADDRLP4 4
INDIRI4
CVIU4 4
CNSTU4 2147483648
BANDU4
CNSTU4 0
EQU4 $358
line 814
;814:		return;
ADDRGP4 $353
JUMPV
LABELV $358
line 818
;815:	}
;816:
;817:	// grab a body que and cycle to the next one
;818:	body = level.bodyQue[ level.bodyQueIndex ];
ADDRLP4 0
ADDRGP4 level+9192
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+9196
ADDP4
INDIRP4
ASGNP4
line 819
;819:	level.bodyQueIndex = (level.bodyQueIndex + 1) % BODY_QUEUE_SIZE;
ADDRGP4 level+9192
ADDRGP4 level+9192
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 16
MODI4
ASGNI4
line 821
;820:
;821:	trap_UnlinkEntity (body);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 827
;822:
;823:#if 0	// JUHOX: toggle teleport flag
;824:	body->s = ent->s;
;825:	body->s.eFlags = EF_DEAD;		// clear EF_TALK, etc
;826:#else
;827:	{
line 830
;828:		int oldEFlags;
;829:
;830:		oldEFlags = body->s.eFlags;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 831
;831:		body->s = ent->s;
ADDRLP4 0
INDIRP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 208
line 832
;832:		body->s.eFlags = oldEFlags & ~EF_TELEPORT_BIT;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 12
INDIRI4
CNSTI4 -5
BANDI4
ASGNI4
line 833
;833:		body->s.eFlags ^= EF_TELEPORT_BIT;
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 4
BXORI4
ASGNI4
line 834
;834:		body->s.eFlags |= EF_DEAD;
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 835
;835:	}
line 855
;836:#endif
;837:#ifdef MISSIONPACK
;838:	if ( ent->s.eFlags & EF_KAMIKAZE ) {
;839:		body->s.eFlags |= EF_KAMIKAZE;
;840:
;841:		// check if there is a kamikaze timer around for this owner
;842:		for (i = 0; i < MAX_GENTITIES; i++) {
;843:			e = &g_entities[i];
;844:			if (!e->inuse)
;845:				continue;
;846:			if (e->activator != ent)
;847:				continue;
;848:			if (strcmp(e->classname, "kamikaze timer"))
;849:				continue;
;850:			e->activator = body;
;851:			break;
;852:		}
;853:	}
;854:#endif
;855:	body->s.powerups = 0;	// clear powerups
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
CNSTI4 0
ASGNI4
line 856
;856:	body->s.loopSound = 0;	// clear lava burning
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
CNSTI4 0
ASGNI4
line 857
;857:	body->s.number = body - g_entities;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ASGNI4
line 858
;858:	body->timestamp = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 644
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 859
;859:	body->physicsObject = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 568
ADDP4
CNSTI4 1
ASGNI4
line 860
;860:	body->physicsBounce = 0;		// don't bounce
ADDRLP4 0
INDIRP4
CNSTI4 572
ADDP4
CNSTF4 0
ASGNF4
line 861
;861:	if ( body->s.groundEntityNum == ENTITYNUM_NONE ) {
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 1023
NEI4 $365
line 862
;862:		body->s.pos.trType = TR_GRAVITY;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 5
ASGNI4
line 863
;863:		body->s.pos.trTime = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 864
;864:		VectorCopy( ent->client->ps.velocity, body->s.pos.trDelta );
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRB
ASGNB 12
line 865
;865:	} else {
ADDRGP4 $366
JUMPV
LABELV $365
line 866
;866:		body->s.pos.trType = TR_STATIONARY;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 867
;867:	}
LABELV $366
line 868
;868:	body->s.event = 0;
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
CNSTI4 0
ASGNI4
line 872
;869:
;870:	// change the animation to the last-frame only, so the sequence
;871:	// doesn't repeat anew for the body
;872:	switch ( body->s.legsAnim & ~ANIM_TOGGLEBIT ) {
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
LTI4 $368
ADDRLP4 16
INDIRI4
CNSTI4 5
GTI4 $368
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $374
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $374
address $371
address $371
address $372
address $372
address $373
address $373
code
LABELV $371
line 875
;873:	case BOTH_DEATH1:
;874:	case BOTH_DEAD1:
;875:		body->s.torsoAnim = body->s.legsAnim = BOTH_DEAD1;
ADDRLP4 28
CNSTI4 1
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 200
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 876
;876:		break;
ADDRGP4 $369
JUMPV
LABELV $372
line 879
;877:	case BOTH_DEATH2:
;878:	case BOTH_DEAD2:
;879:		body->s.torsoAnim = body->s.legsAnim = BOTH_DEAD2;
ADDRLP4 36
CNSTI4 3
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 36
INDIRI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 200
ADDP4
ADDRLP4 36
INDIRI4
ASGNI4
line 880
;880:		break;
ADDRGP4 $369
JUMPV
LABELV $373
LABELV $368
line 884
;881:	case BOTH_DEATH3:
;882:	case BOTH_DEAD3:
;883:	default:
;884:		body->s.torsoAnim = body->s.legsAnim = BOTH_DEAD3;
ADDRLP4 44
CNSTI4 5
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 44
INDIRI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 200
ADDP4
ADDRLP4 44
INDIRI4
ASGNI4
line 885
;885:		break;
LABELV $369
line 888
;886:	}
;887:
;888:	body->r.svFlags = ent->r.svFlags;
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
ASGNI4
line 889
;889:	VectorCopy (ent->r.mins, body->r.mins);
ADDRLP4 0
INDIRP4
CNSTI4 436
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRB
ASGNB 12
line 890
;890:	VectorCopy (ent->r.maxs, body->r.maxs);
ADDRLP4 0
INDIRP4
CNSTI4 448
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 448
ADDP4
INDIRB
ASGNB 12
line 891
;891:	VectorCopy (ent->r.absmin, body->r.absmin);
ADDRLP4 0
INDIRP4
CNSTI4 464
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 464
ADDP4
INDIRB
ASGNB 12
line 892
;892:	VectorCopy (ent->r.absmax, body->r.absmax);
ADDRLP4 0
INDIRP4
CNSTI4 476
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 476
ADDP4
INDIRB
ASGNB 12
line 894
;893:
;894:	body->clipmask = CONTENTS_SOLID | CONTENTS_PLAYERCLIP;
ADDRLP4 0
INDIRP4
CNSTI4 576
ADDP4
CNSTI4 65537
ASGNI4
line 895
;895:	body->r.contents = CONTENTS_CORPSE;
ADDRLP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 67108864
ASGNI4
line 896
;896:	body->r.ownerNum = ent->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 898
;897:
;898:	body->nextthink = level.time + 5000;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 5000
ADDI4
ASGNI4
line 899
;899:	body->think = BodySink;
ADDRLP4 0
INDIRP4
CNSTI4 696
ADDP4
ADDRGP4 BodySink
ASGNP4
line 901
;900:
;901:	body->die = body_die;
ADDRLP4 0
INDIRP4
CNSTI4 720
ADDP4
ADDRGP4 body_die
ASGNP4
line 904
;902:
;903:	// don't take more damage if already gibbed
;904:	if ( ent->health <= GIB_HEALTH ) {
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 -40
GTI4 $376
line 905
;905:		body->takedamage = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
CNSTI4 0
ASGNI4
line 906
;906:	} else {
ADDRGP4 $377
JUMPV
LABELV $376
line 907
;907:		body->takedamage = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
CNSTI4 1
ASGNI4
line 908
;908:	}
LABELV $377
line 911
;909:
;910:#if ESCAPE_MODE
;911:	body->worldSegment = ent->worldSegment;	// JUHOX
ADDRLP4 0
INDIRP4
CNSTI4 820
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
ASGNI4
line 914
;912:#endif
;913:
;914:	VectorCopy ( body->s.pos.trBase, body->r.currentOrigin );
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 915
;915:	trap_LinkEntity (body);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 916
;916:}
LABELV $353
endproc CopyToBodyQue 48 8
export ForceRespawn
proc ForceRespawn 12 0
line 926
;917:
;918://======================================================================
;919:
;920:
;921:/*
;922:================
;923:JUHOX: ForceRespawn
;924:================
;925:*/
;926:void ForceRespawn(gentity_t* ent) {
line 928
;927:#if RESPAWN_DELAY
;928:	if (!ent->inuse) return;
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $379
ADDRGP4 $378
JUMPV
LABELV $379
line 929
;929:	if (!ent->client) return;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $381
ADDRGP4 $378
JUMPV
LABELV $381
line 930
;930:	if (ent->client->pers.connected != CON_CONNECTED) return;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $383
ADDRGP4 $378
JUMPV
LABELV $383
line 931
;931:	if (ent->client->sess.sessionTeam == TEAM_SPECTATOR) return;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 3
NEI4 $385
ADDRGP4 $378
JUMPV
LABELV $385
line 933
;932:
;933:	if (ent->client->ps.stats[STAT_HEALTH] <= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $387
line 934
;934:		if (ent->client->respawnDelay > 0) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 836
ADDP4
INDIRI4
CNSTI4 0
LEI4 $388
line 935
;935:			ent->client->respawnDelay = -1;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 836
ADDP4
CNSTI4 -1
ASGNI4
line 936
;936:			ent->client->respawnTime = level.time + 1700;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 832
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1700
ADDI4
ASGNI4
line 937
;937:		}
line 938
;938:	}
ADDRGP4 $388
JUMPV
LABELV $387
line 940
;939:#if MONSTER_MODE
;940:	else if (g_gametype.integer >= GT_STU) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
LTI4 $392
line 941
;941:		return;
ADDRGP4 $378
JUMPV
LABELV $392
line 944
;942:	}
;943:#endif
;944:	else if (ent->client->ps.stats[STAT_HEALTH] < ent->client->ps.stats[STAT_MAX_HEALTH] + 25) {
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
CNSTI4 25
ADDI4
GEI4 $395
line 945
;945:		ent->client->ps.stats[STAT_HEALTH] = ent->client->ps.stats[STAT_MAX_HEALTH] + 25;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 25
ADDI4
ASGNI4
line 946
;946:		ent->health = ent->client->ps.stats[STAT_HEALTH];
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 736
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 947
;947:	}
LABELV $395
LABELV $388
line 949
;948:#endif
;949:}
LABELV $378
endproc ForceRespawn 12 0
export SetClientViewAngle
proc SetClientViewAngle 16 0
line 957
;950:
;951:/*
;952:==================
;953:SetClientViewAngle
;954:
;955:==================
;956:*/
;957:void SetClientViewAngle( gentity_t *ent, vec3_t angle ) {
line 961
;958:	int			i;
;959:
;960:	// set the delta angle
;961:	for (i=0 ; i<3 ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $398
line 964
;962:		int		cmdAngle;
;963:
;964:		cmdAngle = ANGLE2SHORT(angle[i]);
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
CNSTF4 1127615329
MULF4
CVFI4 4
CNSTI4 65535
BANDI4
ASGNI4
line 965
;965:		ent->client->ps.delta_angles[i] = cmdAngle - ent->client->pers.cmd.angles[i];
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 56
ADDP4
ADDP4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 476
ADDP4
ADDP4
INDIRI4
SUBI4
ASGNI4
line 966
;966:	}
LABELV $399
line 961
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $398
line 973
;967:	// JUHOX BUGFIX(?): view angles should be put into entityState_t.apos.trBase
;968:	// entityState_t.angles is now used to store movementDir (see BG_PlayerStateToEntityState())
;969:#if 0
;970:	VectorCopy( angle, ent->s.angles );
;971:	VectorCopy (ent->s.angles, ent->client->ps.viewangles);
;972:#else
;973:	VectorCopy(angle, ent->s.apos.trBase);
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 974
;974:	VectorCopy(angle, ent->client->ps.viewangles);
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 152
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 976
;975:#endif
;976:}
LABELV $397
endproc SetClientViewAngle 16 0
export respawn
proc respawn 8 8
line 983
;977:
;978:/*
;979:================
;980:respawn
;981:================
;982:*/
;983:void respawn( gentity_t *ent ) {
line 990
;984:	gentity_t	*tent;
;985:
;986:	// JUHOX: 'CopyToBodyQue()' is now done earlier (in 'ClientThink_real()'), so dead spectators can see their corpse
;987:#if 0
;988:	CopyToBodyQue (ent);
;989:#endif
;990:	ClientSpawn(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 ClientSpawn
CALLV
pop
line 991
;991:	if (ent->client->ps.stats[STAT_HEALTH] <= 0) return;	// JUHOX: spawning failed
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $403
ADDRGP4 $402
JUMPV
LABELV $403
line 992
;992:	if (level.meeting) return;	// JUHOX: no teleportation effect during meeting
ADDRGP4 level+24092
INDIRI4
CNSTI4 0
EQI4 $405
ADDRGP4 $402
JUMPV
LABELV $405
line 995
;993:
;994:	// add a teleportation effect
;995:	tent = G_TempEntity( ent->client->ps.origin, EV_PLAYER_TELEPORT_IN );
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
CNSTI4 42
ARGI4
ADDRLP4 4
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 996
;996:	tent->s.clientNum = ent->s.clientNum;
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 997
;997:}
LABELV $402
endproc respawn 8 8
export TeamCount
proc TeamCount 8 0
line 1006
;998:
;999:/*
;1000:================
;1001:TeamCount
;1002:
;1003:Returns number of players on a team
;1004:================
;1005:*/
;1006:team_t TeamCount( int ignoreClientNum, int team ) {
line 1008
;1007:	int		i;
;1008:	int		count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1010
;1009:
;1010:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $412
JUMPV
LABELV $409
line 1011
;1011:		if ( i == ignoreClientNum ) {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $414
line 1012
;1012:			continue;
ADDRGP4 $410
JUMPV
LABELV $414
line 1014
;1013:		}
;1014:		if ( level.clients[i].pers.connected == CON_DISCONNECTED ) {
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
NEI4 $416
line 1015
;1015:			continue;
ADDRGP4 $410
JUMPV
LABELV $416
line 1017
;1016:		}
;1017:		if ( level.clients[i].sess.sessionTeam == team ) {
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
ADDRFP4 4
INDIRI4
NEI4 $418
line 1018
;1018:			count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1019
;1019:		}
LABELV $418
line 1020
;1020:	}
LABELV $410
line 1010
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $412
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $409
line 1022
;1021:
;1022:	return count;
ADDRLP4 4
INDIRI4
RETI4
LABELV $408
endproc TeamCount 8 0
export TeamLeader
proc TeamLeader 4 0
line 1032
;1023:}
;1024:
;1025:/*
;1026:================
;1027:TeamLeader
;1028:
;1029:Returns the client number of the team leader
;1030:================
;1031:*/
;1032:int TeamLeader( int team ) {
line 1035
;1033:	int		i;
;1034:
;1035:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $424
JUMPV
LABELV $421
line 1036
;1036:		if ( level.clients[i].pers.connected == CON_DISCONNECTED ) {
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
NEI4 $426
line 1037
;1037:			continue;
ADDRGP4 $422
JUMPV
LABELV $426
line 1039
;1038:		}
;1039:		if ( level.clients[i].sess.sessionTeam == team ) {
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
ADDRFP4 0
INDIRI4
NEI4 $428
line 1040
;1040:			if ( level.clients[i].sess.teamLeader )
ADDRLP4 0
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 720
ADDP4
INDIRI4
CNSTI4 0
EQI4 $430
line 1041
;1041:				return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $420
JUMPV
LABELV $430
line 1042
;1042:		}
LABELV $428
line 1043
;1043:	}
LABELV $422
line 1035
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $424
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $421
line 1045
;1044:
;1045:	return -1;
CNSTI4 -1
RETI4
LABELV $420
endproc TeamLeader 4 0
export PickTeam
proc PickTeam 24 8
line 1055
;1046:}
;1047:
;1048:
;1049:/*
;1050:================
;1051:PickTeam
;1052:
;1053:================
;1054:*/
;1055:team_t PickTeam( int ignoreClientNum ) {
line 1059
;1056:	int		counts[TEAM_NUM_TEAMS];
;1057:
;1058:#if MONSTER_MODE	// JUHOX: in STU always pick the red team
;1059:	if (g_gametype.integer >= GT_STU) return TEAM_RED;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
LTI4 $433
CNSTI4 1
RETI4
ADDRGP4 $432
JUMPV
LABELV $433
line 1062
;1060:#endif
;1061:
;1062:	counts[TEAM_BLUE] = TeamCount( ignoreClientNum, TEAM_BLUE );
ADDRFP4 0
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 16
ADDRGP4 TeamCount
CALLI4
ASGNI4
ADDRLP4 0+8
ADDRLP4 16
INDIRI4
ASGNI4
line 1063
;1063:	counts[TEAM_RED] = TeamCount( ignoreClientNum, TEAM_RED );
ADDRFP4 0
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 20
ADDRGP4 TeamCount
CALLI4
ASGNI4
ADDRLP4 0+4
ADDRLP4 20
INDIRI4
ASGNI4
line 1065
;1064:
;1065:	if ( counts[TEAM_BLUE] > counts[TEAM_RED] ) {
ADDRLP4 0+8
INDIRI4
ADDRLP4 0+4
INDIRI4
LEI4 $438
line 1066
;1066:		return TEAM_RED;
CNSTI4 1
RETI4
ADDRGP4 $432
JUMPV
LABELV $438
line 1068
;1067:	}
;1068:	if ( counts[TEAM_RED] > counts[TEAM_BLUE] ) {
ADDRLP4 0+4
INDIRI4
ADDRLP4 0+8
INDIRI4
LEI4 $442
line 1069
;1069:		return TEAM_BLUE;
CNSTI4 2
RETI4
ADDRGP4 $432
JUMPV
LABELV $442
line 1072
;1070:	}
;1071:	// equal team count, so join the team with the lowest score
;1072:	if ( level.teamScores[TEAM_BLUE] > level.teamScores[TEAM_RED] ) {
ADDRGP4 level+44+8
INDIRI4
ADDRGP4 level+44+4
INDIRI4
LEI4 $446
line 1073
;1073:		return TEAM_RED;
CNSTI4 1
RETI4
ADDRGP4 $432
JUMPV
LABELV $446
line 1075
;1074:	}
;1075:	return TEAM_BLUE;
CNSTI4 2
RETI4
LABELV $432
endproc PickTeam 24 8
proc ClientCleanName 36 12
line 1104
;1076:}
;1077:
;1078:/*
;1079:===========
;1080:ForceClientSkin
;1081:
;1082:Forces a client's skin (for teamplay)
;1083:===========
;1084:*/
;1085:/*
;1086:static void ForceClientSkin( gclient_t *client, char *model, const char *skin ) {
;1087:	char *p;
;1088:
;1089:	if ((p = Q_strrchr(model, '/')) != 0) {
;1090:		*p = 0;
;1091:	}
;1092:
;1093:	Q_strcat(model, MAX_QPATH, "/");
;1094:	Q_strcat(model, MAX_QPATH, skin);
;1095:}
;1096:*/
;1097:
;1098:
;1099:/*
;1100:===========
;1101:ClientCheckName
;1102:============
;1103:*/
;1104:static void ClientCleanName( const char *in, char *out, int outSize ) {
line 1111
;1105:	int		len, colorlessLen;
;1106:	char	ch;
;1107:	char	*p;
;1108:	int		spaces;
;1109:
;1110:	//save room for trailing null byte
;1111:	outSize--;
ADDRFP4 8
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1113
;1112:
;1113:	len = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1114
;1114:	colorlessLen = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 1115
;1115:	p = out;
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
line 1116
;1116:	*p = 0;
ADDRLP4 12
INDIRP4
CNSTI1 0
ASGNI1
line 1117
;1117:	spaces = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $454
JUMPV
LABELV $453
line 1119
;1118:
;1119:	while( 1 ) {
line 1120
;1120:		ch = *in++;
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 20
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
INDIRI1
ASGNI1
line 1121
;1121:		if( !ch ) {
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $456
line 1122
;1122:			break;
ADDRGP4 $455
JUMPV
LABELV $456
line 1126
;1123:		}
;1124:
;1125:		// don't allow leading spaces
;1126:		if( !*p && ch == ' ' ) {
ADDRLP4 12
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $458
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 32
NEI4 $458
line 1127
;1127:			continue;
ADDRGP4 $454
JUMPV
LABELV $458
line 1131
;1128:		}
;1129:
;1130:		// check colors
;1131:		if( ch == Q_COLOR_ESCAPE ) {
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $460
line 1133
;1132:			// solo trailing carat is not a color prefix
;1133:			if( !*in ) {
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $462
line 1134
;1134:				break;
ADDRGP4 $455
JUMPV
LABELV $462
line 1138
;1135:			}
;1136:
;1137:			// don't allow black in a name, period
;1138:			if( ColorIndex(*in) == 0 ) {
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 48
SUBI4
CNSTI4 7
BANDI4
CNSTI4 0
NEI4 $464
line 1139
;1139:				in++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1140
;1140:				continue;
ADDRGP4 $454
JUMPV
LABELV $464
line 1144
;1141:			}
;1142:
;1143:			// make sure room in dest for both chars
;1144:			if( len > outSize - 2 ) {
ADDRLP4 4
INDIRI4
ADDRFP4 8
INDIRI4
CNSTI4 2
SUBI4
LEI4 $466
line 1145
;1145:				break;
ADDRGP4 $455
JUMPV
LABELV $466
line 1148
;1146:			}
;1147:
;1148:			*out++ = ch;
ADDRLP4 24
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 4
ADDRLP4 24
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 0
INDIRI1
ASGNI1
line 1149
;1149:			*out++ = *in++;
ADDRLP4 28
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 4
ADDRLP4 28
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 32
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI1
ASGNI1
line 1150
;1150:			len += 2;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 1151
;1151:			continue;
ADDRGP4 $454
JUMPV
LABELV $460
line 1155
;1152:		}
;1153:
;1154:		// don't allow too many consecutive spaces
;1155:		if( ch == ' ' ) {
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 32
NEI4 $468
line 1156
;1156:			spaces++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1157
;1157:			if( spaces > 3 ) {
ADDRLP4 8
INDIRI4
CNSTI4 3
LEI4 $469
line 1158
;1158:				continue;
ADDRGP4 $454
JUMPV
line 1160
;1159:			}
;1160:		}
LABELV $468
line 1161
;1161:		else {
line 1162
;1162:			spaces = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 1163
;1163:		}
LABELV $469
line 1165
;1164:
;1165:		if( len > outSize - 1 ) {
ADDRLP4 4
INDIRI4
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
LEI4 $472
line 1166
;1166:			break;
ADDRGP4 $455
JUMPV
LABELV $472
line 1169
;1167:		}
;1168:
;1169:		*out++ = ch;
ADDRLP4 24
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 4
ADDRLP4 24
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 0
INDIRI1
ASGNI1
line 1170
;1170:		colorlessLen++;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1171
;1171:		len++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1172
;1172:	}
LABELV $454
line 1119
ADDRGP4 $453
JUMPV
LABELV $455
line 1173
;1173:	*out = 0;
ADDRFP4 4
INDIRP4
CNSTI1 0
ASGNI1
line 1176
;1174:
;1175:	// don't allow empty names
;1176:	if( *p == 0 || colorlessLen == 0 ) {
ADDRLP4 12
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $476
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $474
LABELV $476
line 1177
;1177:		Q_strncpyz( p, "UnnamedPlayer", outSize );
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 $477
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1178
;1178:	}
LABELV $474
line 1179
;1179:}
LABELV $452
endproc ClientCleanName 36 12
export ClientUserinfoChanged
proc ClientUserinfoChanged 6412 60
line 1193
;1180:
;1181:
;1182:/*
;1183:===========
;1184:ClientUserInfoChanged
;1185:
;1186:Called from ClientConnect when the player first connects and
;1187:directly by the server system when the player updates a userinfo variable.
;1188:
;1189:The game can override any of the settings and call trap_SetUserinfo
;1190:if desired.
;1191:============
;1192:*/
;1193:void ClientUserinfoChanged( int clientNum ) {
line 1207
;1194:	gentity_t *ent;
;1195:	int		teamTask, teamLeader, team, health;
;1196:	char	*s;
;1197:	char	model[MAX_QPATH];
;1198:	char	headModel[MAX_QPATH];
;1199:	char	oldname[MAX_STRING_CHARS];
;1200:	gclient_t	*client;
;1201:	char	c1[MAX_INFO_STRING];
;1202:	char	c2[MAX_INFO_STRING];
;1203:	char	redTeam[MAX_INFO_STRING];
;1204:	char	blueTeam[MAX_INFO_STRING];
;1205:	char	userinfo[MAX_INFO_STRING];
;1206:
;1207:	ent = g_entities + clientNum;
ADDRLP4 1032
ADDRFP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1208
;1208:	client = ent->client;
ADDRLP4 0
ADDRLP4 1032
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 1210
;1209:
;1210:	trap_GetUserinfo( clientNum, userinfo, sizeof( userinfo ) );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 1213
;1211:
;1212:	// check for malformed or illegal info strings
;1213:	if ( !Info_Validate(userinfo) ) {
ADDRLP4 4
ARGP4
ADDRLP4 6300
ADDRGP4 Info_Validate
CALLI4
ASGNI4
ADDRLP4 6300
INDIRI4
CNSTI4 0
NEI4 $479
line 1214
;1214:		strcpy (userinfo, "\\name\\badinfo");
ADDRLP4 4
ARGP4
ADDRGP4 $481
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1215
;1215:	}
LABELV $479
line 1218
;1216:
;1217:	// check for local client
;1218:	s = Info_ValueForKey( userinfo, "ip" );
ADDRLP4 4
ARGP4
ADDRGP4 $482
ARGP4
ADDRLP4 6304
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 6304
INDIRP4
ASGNP4
line 1219
;1219:	if ( !strcmp( s, "localhost" ) ) {
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 $485
ARGP4
ADDRLP4 6308
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 6308
INDIRI4
CNSTI4 0
NEI4 $483
line 1220
;1220:		client->pers.localClient = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
CNSTI4 1
ASGNI4
line 1221
;1221:	}
LABELV $483
line 1224
;1222:
;1223:	// check the item prediction
;1224:	s = Info_ValueForKey( userinfo, "cg_predictItems" );
ADDRLP4 4
ARGP4
ADDRGP4 $486
ARGP4
ADDRLP4 6312
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 6312
INDIRP4
ASGNP4
line 1225
;1225:	if ( !atoi( s ) ) {
ADDRLP4 1028
INDIRP4
ARGP4
ADDRLP4 6316
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 6316
INDIRI4
CNSTI4 0
NEI4 $487
line 1226
;1226:		client->pers.predictItemPickup = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 504
ADDP4
CNSTI4 0
ASGNI4
line 1227
;1227:	} else {
ADDRGP4 $488
JUMPV
LABELV $487
line 1228
;1228:		client->pers.predictItemPickup = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 504
ADDP4
CNSTI4 1
ASGNI4
line 1229
;1229:	}
LABELV $488
line 1232
;1230:
;1231:	// set name
;1232:	Q_strncpyz ( oldname, client->pers.netname, sizeof( oldname ) );
ADDRLP4 1168
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1233
;1233:	s = Info_ValueForKey (userinfo, "name");
ADDRLP4 4
ARGP4
ADDRGP4 $489
ARGP4
ADDRLP4 6320
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 6320
INDIRP4
ASGNP4
line 1234
;1234:	ClientCleanName( s, client->pers.netname, sizeof(client->pers.netname) );
ADDRLP4 1028
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientCleanName
CALLV
pop
line 1236
;1235:
;1236:	if ( client->sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRLP4 0
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 3
NEI4 $490
line 1237
;1237:		if ( client->sess.spectatorState == SPECTATOR_SCOREBOARD ) {
ADDRLP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRI4
CNSTI4 3
NEI4 $492
line 1238
;1238:			Q_strncpyz( client->pers.netname, "scoreboard", sizeof(client->pers.netname) );
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRGP4 $494
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1239
;1239:		}
LABELV $492
line 1240
;1240:	}
LABELV $490
line 1242
;1241:
;1242:	if ( client->pers.connected == CON_CONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $495
line 1243
;1243:		if ( strcmp( oldname, client->pers.netname ) ) {
ADDRLP4 1168
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 6324
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 6324
INDIRI4
CNSTI4 0
EQI4 $497
line 1244
;1244:			trap_SendServerCommand( -1, va("print \"%s" S_COLOR_WHITE " renamed to %s\n\"", oldname, 
ADDRGP4 $499
ARGP4
ADDRLP4 1168
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 6328
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 6328
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1246
;1245:				client->pers.netname) );
;1246:		}
LABELV $497
line 1247
;1247:	}
LABELV $495
line 1261
;1248:
;1249:	// set max health
;1250:#ifdef MISSIONPACK
;1251:	if (client->ps.powerups[PW_GUARD]) {
;1252:		client->pers.maxHealth = 200;
;1253:	} else {
;1254:		health = atoi( Info_ValueForKey( userinfo, "handicap" ) );
;1255:		client->pers.maxHealth = health;
;1256:		if ( client->pers.maxHealth < 1 || client->pers.maxHealth > 100 ) {
;1257:			client->pers.maxHealth = 100;
;1258:		}
;1259:	}
;1260:#else
;1261:	health = atoi( Info_ValueForKey( userinfo, "handicap" ) );
ADDRLP4 4
ARGP4
ADDRGP4 $500
ARGP4
ADDRLP4 6324
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 6324
INDIRP4
ARGP4
ADDRLP4 6328
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 2196
ADDRLP4 6328
INDIRI4
ASGNI4
line 1262
;1262:	client->pers.maxHealth = health;
ADDRLP4 0
INDIRP4
CNSTI4 548
ADDP4
ADDRLP4 2196
INDIRI4
ASGNI4
line 1263
;1263:	if ( client->pers.maxHealth < 1 || client->pers.maxHealth > 100 ) {
ADDRLP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
CNSTI4 1
LTI4 $503
ADDRLP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
CNSTI4 100
LEI4 $501
LABELV $503
line 1264
;1264:		client->pers.maxHealth = 100;
ADDRLP4 0
INDIRP4
CNSTI4 548
ADDP4
CNSTI4 100
ASGNI4
line 1265
;1265:	}
LABELV $501
line 1270
;1266:#endif
;1267:#if 0	// JUHOX: set max. health
;1268:	client->ps.stats[STAT_MAX_HEALTH] = client->pers.maxHealth;
;1269:#else
;1270:	client->ps.stats[STAT_MAX_HEALTH] = g_baseHealth.value * (client->pers.maxHealth / 100.0);
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
ADDRGP4 g_baseHealth+8
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1008981770
MULF4
MULF4
CVFI4 4
ASGNI4
line 1271
;1271:	if (client->ps.stats[STAT_MAX_HEALTH] < 1) client->ps.stats[STAT_MAX_HEALTH] = 1;
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 1
GEI4 $505
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
CNSTI4 1
ASGNI4
LABELV $505
line 1275
;1272:#endif
;1273:
;1274:	// set model
;1275:	if( g_gametype.integer >= GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $507
line 1276
;1276:		Q_strncpyz( model, Info_ValueForKey (userinfo, "team_model"), sizeof( model ) );
ADDRLP4 4
ARGP4
ADDRGP4 $510
ARGP4
ADDRLP4 6340
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1040
ARGP4
ADDRLP4 6340
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1277
;1277:		Q_strncpyz( headModel, Info_ValueForKey (userinfo, "team_headmodel"), sizeof( headModel ) );
ADDRLP4 4
ARGP4
ADDRGP4 $511
ARGP4
ADDRLP4 6344
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1104
ARGP4
ADDRLP4 6344
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1278
;1278:	} else {
ADDRGP4 $508
JUMPV
LABELV $507
line 1279
;1279:		Q_strncpyz( model, Info_ValueForKey (userinfo, "model"), sizeof( model ) );
ADDRLP4 4
ARGP4
ADDRGP4 $512
ARGP4
ADDRLP4 6340
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1040
ARGP4
ADDRLP4 6340
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1280
;1280:		Q_strncpyz( headModel, Info_ValueForKey (userinfo, "headmodel"), sizeof( headModel ) );
ADDRLP4 4
ARGP4
ADDRGP4 $513
ARGP4
ADDRLP4 6344
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1104
ARGP4
ADDRLP4 6344
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1281
;1281:	}
LABELV $508
line 1284
;1282:
;1283:	// bots set their team a few frames later
;1284:	if (g_gametype.integer >= GT_TEAM && g_entities[clientNum].r.svFlags & SVF_BOT) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $514
ADDRFP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+208+216
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $514
line 1285
;1285:		s = Info_ValueForKey( userinfo, "team" );
ADDRLP4 4
ARGP4
ADDRGP4 $519
ARGP4
ADDRLP4 6340
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 6340
INDIRP4
ASGNP4
line 1286
;1286:		if ( !Q_stricmp( s, "red" ) || !Q_stricmp( s, "r" ) ) {
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 $522
ARGP4
ADDRLP4 6344
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 6344
INDIRI4
CNSTI4 0
EQI4 $524
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 $523
ARGP4
ADDRLP4 6348
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 6348
INDIRI4
CNSTI4 0
NEI4 $520
LABELV $524
line 1287
;1287:			team = TEAM_RED;
ADDRLP4 4248
CNSTI4 1
ASGNI4
line 1288
;1288:		} else if ( !Q_stricmp( s, "blue" ) || !Q_stricmp( s, "b" ) ) {
ADDRGP4 $515
JUMPV
LABELV $520
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 $527
ARGP4
ADDRLP4 6352
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 6352
INDIRI4
CNSTI4 0
EQI4 $529
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 $528
ARGP4
ADDRLP4 6356
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 6356
INDIRI4
CNSTI4 0
NEI4 $525
LABELV $529
line 1289
;1289:			team = TEAM_BLUE;
ADDRLP4 4248
CNSTI4 2
ASGNI4
line 1290
;1290:		} else {
ADDRGP4 $515
JUMPV
LABELV $525
line 1292
;1291:			// pick the team with the least number of players
;1292:			team = PickTeam( clientNum );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 6360
ADDRGP4 PickTeam
CALLI4
ASGNI4
ADDRLP4 4248
ADDRLP4 6360
INDIRI4
ASGNI4
line 1293
;1293:		}
line 1294
;1294:	}
ADDRGP4 $515
JUMPV
LABELV $514
line 1295
;1295:	else {
line 1296
;1296:		team = client->sess.sessionTeam;
ADDRLP4 4248
ADDRLP4 0
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
ASGNI4
line 1297
;1297:	}
LABELV $515
line 1351
;1298:
;1299:#if 0	// JUHOX 1.29h: all model issues done client side
;1300:#if !MONSTER_MODE	// JUHOX: don't force client skins to match the team in STU
;1301:	// team
;1302:	switch( team ) {
;1303:	case TEAM_RED:
;1304:		ForceClientSkin(client, model, "red");
;1305:		ForceClientSkin(client, headModel, "red");
;1306:		break;
;1307:	case TEAM_BLUE:
;1308:		ForceClientSkin(client, model, "blue");
;1309:		ForceClientSkin(client, headModel, "blue");
;1310:		break;
;1311:	}
;1312:	// don't ever use a default skin in teamplay, it would just waste memory
;1313:	// however bots will always join a team but they spawn in as spectator
;1314:	if ( g_gametype.integer >= GT_TEAM && team == TEAM_SPECTATOR) {
;1315:		ForceClientSkin(client, model, "red");
;1316:		ForceClientSkin(client, headModel, "red");
;1317:	}
;1318:#else
;1319:	if (g_gametype.integer < GT_STU) {
;1320:		switch(team) {
;1321:		case TEAM_RED:
;1322:			ForceClientSkin(client, model, "red");
;1323:			ForceClientSkin(client, headModel, "red");
;1324:			break;
;1325:		case TEAM_BLUE:
;1326:			ForceClientSkin(client, model, "blue");
;1327:			ForceClientSkin(client, headModel, "blue");
;1328:			break;
;1329:		}
;1330:		if (g_gametype.integer >= GT_TEAM && team == TEAM_SPECTATOR) {
;1331:			ForceClientSkin(client, model, "red");
;1332:			ForceClientSkin(client, headModel, "red");
;1333:		}
;1334:	}
;1335:#endif
;1336:#endif
;1337:
;1338:#ifdef MISSIONPACK
;1339:	if (g_gametype.integer >= GT_TEAM) {
;1340:		client->pers.teamInfo = qtrue;
;1341:	} else {
;1342:		s = Info_ValueForKey( userinfo, "teamoverlay" );
;1343:		if ( ! *s || atoi( s ) != 0 ) {
;1344:			client->pers.teamInfo = qtrue;
;1345:		} else {
;1346:			client->pers.teamInfo = qfalse;
;1347:		}
;1348:	}
;1349:#else
;1350:	// teamInfo
;1351:	s = Info_ValueForKey( userinfo, "teamoverlay" );
ADDRLP4 4
ARGP4
ADDRGP4 $530
ARGP4
ADDRLP4 6340
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 6340
INDIRP4
ASGNP4
line 1352
;1352:	if ( ! *s || atoi( s ) != 0 ) {
ADDRLP4 1028
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $533
ADDRLP4 1028
INDIRP4
ARGP4
ADDRLP4 6348
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 6348
INDIRI4
CNSTI4 0
EQI4 $531
LABELV $533
line 1353
;1353:		client->pers.teamInfo = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 612
ADDP4
CNSTI4 1
ASGNI4
line 1354
;1354:	} else {
ADDRGP4 $532
JUMPV
LABELV $531
line 1355
;1355:		client->pers.teamInfo = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 612
ADDP4
CNSTI4 0
ASGNI4
line 1356
;1356:	}
LABELV $532
line 1369
;1357:#endif
;1358:	/*
;1359:	s = Info_ValueForKey( userinfo, "cg_pmove_fixed" );
;1360:	if ( !*s || atoi( s ) == 0 ) {
;1361:		client->pers.pmoveFixed = qfalse;
;1362:	}
;1363:	else {
;1364:		client->pers.pmoveFixed = qtrue;
;1365:	}
;1366:	*/
;1367:
;1368:	// team task (0 = none, 1 = offence, 2 = defence)
;1369:	teamTask = atoi(Info_ValueForKey(userinfo, "teamtask"));
ADDRLP4 4
ARGP4
ADDRGP4 $534
ARGP4
ADDRLP4 6352
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 6352
INDIRP4
ARGP4
ADDRLP4 6356
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 2192
ADDRLP4 6356
INDIRI4
ASGNI4
line 1371
;1370:	// team Leader (1 = leader, 0 is normal player)
;1371:	teamLeader = client->sess.teamLeader;
ADDRLP4 1036
ADDRLP4 0
INDIRP4
CNSTI4 720
ADDP4
INDIRI4
ASGNI4
line 1374
;1372:
;1373:#if 1	// JUHOX: if a mission leader in safety mode looses his leadership, stop safety mode
;1374:	if (!teamLeader && client->tssSafetyMode) {
ADDRLP4 1036
INDIRI4
CNSTI4 0
NEI4 $535
ADDRLP4 0
INDIRP4
CNSTI4 768
ADDP4
INDIRI4
CNSTI4 0
EQI4 $535
line 1375
;1375:		client->tssSafetyMode = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 768
ADDP4
CNSTI4 0
ASGNI4
line 1376
;1376:	}
LABELV $535
line 1380
;1377:#endif
;1378:
;1379:#if 1	// JUHOX: get class cloaking activation state
;1380:	client->pers.glassCloakingEnabled = atoi(Info_ValueForKey(userinfo, "cg_glassCloaking"))? qtrue : qfalse;
ADDRLP4 4
ARGP4
ADDRGP4 $537
ARGP4
ADDRLP4 6364
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 6364
INDIRP4
ARGP4
ADDRLP4 6368
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 6368
INDIRI4
CNSTI4 0
EQI4 $539
ADDRLP4 6360
CNSTI4 1
ASGNI4
ADDRGP4 $540
JUMPV
LABELV $539
ADDRLP4 6360
CNSTI4 0
ASGNI4
LABELV $540
ADDRLP4 0
INDIRP4
CNSTI4 620
ADDP4
ADDRLP4 6360
INDIRI4
ASGNI4
line 1384
;1381:#endif
;1382:
;1383:#if 1	// JUHOX: check whether crouching cuts the grapple rope
;1384:	client->pers.crouchingCutsRope = atoi(Info_ValueForKey(userinfo, "crouchCutsRope"))? qtrue : qfalse;
ADDRLP4 4
ARGP4
ADDRGP4 $541
ARGP4
ADDRLP4 6376
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 6376
INDIRP4
ARGP4
ADDRLP4 6380
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 6380
INDIRI4
CNSTI4 0
EQI4 $543
ADDRLP4 6372
CNSTI4 1
ASGNI4
ADDRGP4 $544
JUMPV
LABELV $543
ADDRLP4 6372
CNSTI4 0
ASGNI4
LABELV $544
ADDRLP4 0
INDIRP4
CNSTI4 624
ADDP4
ADDRLP4 6372
INDIRI4
ASGNI4
line 1388
;1385:#endif
;1386:
;1387:	// colors
;1388:	strcpy(c1, Info_ValueForKey( userinfo, "color1" ));
ADDRLP4 4
ARGP4
ADDRGP4 $545
ARGP4
ADDRLP4 6384
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 2200
ARGP4
ADDRLP4 6384
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1389
;1389:	strcpy(c2, Info_ValueForKey( userinfo, "color2" ));
ADDRLP4 4
ARGP4
ADDRGP4 $546
ARGP4
ADDRLP4 6388
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 3224
ARGP4
ADDRLP4 6388
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1391
;1390:
;1391:	strcpy(redTeam, Info_ValueForKey( userinfo, "g_redteam" ));
ADDRLP4 4
ARGP4
ADDRGP4 $547
ARGP4
ADDRLP4 6392
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4252
ARGP4
ADDRLP4 6392
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1392
;1392:	strcpy(blueTeam, Info_ValueForKey( userinfo, "g_blueteam" ));
ADDRLP4 4
ARGP4
ADDRGP4 $548
ARGP4
ADDRLP4 6396
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 5276
ARGP4
ADDRLP4 6396
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1408
;1393:
;1394:	// send over a subset of the userinfo keys so other clients can
;1395:	// print scoreboards, display models, and play custom sounds
;1396:#if 0	// JUHOX: add some userinfo keys to be send to all clients
;1397:	if ( ent->r.svFlags & SVF_BOT ) {
;1398:		s = va("n\\%s\\t\\%i\\model\\%s\\hmodel\\%s\\c1\\%s\\c2\\%s\\hc\\%i\\w\\%i\\l\\%i\\skill\\%s\\tt\\%d\\tl\\%d",
;1399:			client->pers.netname, team, model, headModel, c1, c2,
;1400:			client->pers.maxHealth, client->sess.wins, client->sess.losses,
;1401:			Info_ValueForKey( userinfo, "skill" ), teamTask, teamLeader );
;1402:	} else {
;1403:		s = va("n\\%s\\t\\%i\\model\\%s\\hmodel\\%s\\g_redteam\\%s\\g_blueteam\\%s\\c1\\%s\\c2\\%s\\hc\\%i\\w\\%i\\l\\%i\\tt\\%d\\tl\\%d",
;1404:			client->pers.netname, client->sess.sessionTeam, model, headModel, redTeam, blueTeam, c1, c2,
;1405:			client->pers.maxHealth, client->sess.wins, client->sess.losses, teamTask, teamLeader);
;1406:	}
;1407:#else
;1408:	if ( ent->r.svFlags & SVF_BOT ) {
ADDRLP4 1032
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $549
line 1409
;1409:		s = va(
ADDRLP4 4
ARGP4
ADDRGP4 $552
ARGP4
ADDRLP4 6400
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $551
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 4248
INDIRI4
ARGI4
ADDRLP4 1040
ARGP4
ADDRLP4 1104
ARGP4
ADDRLP4 2200
ARGP4
ADDRLP4 3224
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 712
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRI4
ARGI4
ADDRLP4 6400
INDIRP4
ARGP4
ADDRLP4 2192
INDIRI4
ARGI4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 620
ADDP4
INDIRI4
ARGI4
ADDRLP4 6408
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 6408
INDIRP4
ASGNP4
line 1419
;1410:			"n\\%s\\t\\%i\\model\\%s\\hmodel\\%s\\c1\\%s\\c2\\%s"
;1411:			"\\hc\\%i\\w\\%i\\l\\%i"
;1412:			"\\skill\\%s\\tt\\%d\\tl\\%d"
;1413:			"\\gc\\%d",
;1414:			client->pers.netname, team, model, headModel, c1, c2,
;1415:			client->pers.maxHealth, client->sess.wins, client->sess.losses,
;1416:			Info_ValueForKey(userinfo, "skill"), teamTask, teamLeader,
;1417:			client->pers.glassCloakingEnabled
;1418:		);
;1419:	} else {
ADDRGP4 $550
JUMPV
LABELV $549
line 1420
;1420:		s = va(
ADDRGP4 $553
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
ARGI4
ADDRLP4 1040
ARGP4
ADDRLP4 1104
ARGP4
ADDRLP4 4252
ARGP4
ADDRLP4 5276
ARGP4
ADDRLP4 2200
ARGP4
ADDRLP4 3224
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 712
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRI4
ARGI4
ADDRLP4 2192
INDIRI4
ARGI4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 620
ADDP4
INDIRI4
ARGI4
ADDRLP4 6404
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 6404
INDIRP4
ASGNP4
line 1430
;1421:			"n\\%s\\t\\%i\\model\\%s\\hmodel\\%s\\g_redteam\\%s\\g_blueteam\\%s\\c1\\%s\\c2\\%s"
;1422:			"\\hc\\%i\\w\\%i\\l\\%i"
;1423:			"\\tt\\%d\\tl\\%d"
;1424:			"\\gc\\%d",
;1425:			client->pers.netname, client->sess.sessionTeam, model, headModel, redTeam, blueTeam, c1, c2,
;1426:			client->pers.maxHealth, client->sess.wins, client->sess.losses,
;1427:			teamTask, teamLeader,
;1428:			client->pers.glassCloakingEnabled
;1429:		);
;1430:	}
LABELV $550
line 1433
;1431:#endif
;1432:
;1433:	trap_SetConfigstring( CS_PLAYERS+clientNum, s );
ADDRFP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1436
;1434:
;1435:	// this is not the userinfo, more like the configstring actually
;1436:	G_LogPrintf( "ClientUserinfoChanged: %i %s\n", clientNum, s );
ADDRGP4 $554
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1437
;1437:}
LABELV $478
endproc ClientUserinfoChanged 6412 60
export ClientConnect
proc ClientConnect 1060 12
line 1460
;1438:
;1439:
;1440:/*
;1441:===========
;1442:ClientConnect
;1443:
;1444:Called when a player begins connecting to the server.
;1445:Called again for every map change or tournement restart.
;1446:
;1447:The session information will be valid after exit.
;1448:
;1449:Return NULL if the client should be allowed, otherwise return
;1450:a string with the reason for denial.
;1451:
;1452:Otherwise, the client will be sent the current gamestate
;1453:and will eventually get to ClientBegin.
;1454:
;1455:firstTime will be qtrue the very first time a client connects
;1456:to the server machine, but qfalse on map changes and tournement
;1457:restarts.
;1458:============
;1459:*/
;1460:char *ClientConnect( int clientNum, qboolean firstTime, qboolean isBot ) {
line 1468
;1461:	char		*value;
;1462://	char		*areabits;
;1463:	gclient_t	*client;
;1464:	char		userinfo[MAX_INFO_STRING];
;1465:	gentity_t	*ent;
;1466:
;1467:#if MEETING	// JUHOX: no connection during game with meeting activated
;1468:	if (!level.meeting && g_meeting.integer) return "Game in progress, retry later";
ADDRGP4 level+24092
INDIRI4
CNSTI4 0
NEI4 $556
ADDRGP4 g_meeting+12
INDIRI4
CNSTI4 0
EQI4 $556
ADDRGP4 $560
RETP4
ADDRGP4 $555
JUMPV
LABELV $556
line 1471
;1469:#endif
;1470:
;1471:	ent = &g_entities[ clientNum ];
ADDRLP4 4
ADDRFP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1473
;1472:
;1473:	trap_GetUserinfo( clientNum, userinfo, sizeof( userinfo ) );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 1479
;1474:
;1475: 	// IP filtering
;1476: 	// https://zerowing.idsoftware.com/bugzilla/show_bug.cgi?id=500
;1477: 	// recommanding PB based IP / GUID banning, the builtin system is pretty limited
;1478:	// check to see if they are on the banned IP list
;1479:	value = Info_ValueForKey (userinfo, "ip");
ADDRLP4 12
ARGP4
ADDRGP4 $482
ARGP4
ADDRLP4 1036
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 1036
INDIRP4
ASGNP4
line 1480
;1480:	if ( G_FilterPacket( value ) ) {
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 1040
ADDRGP4 G_FilterPacket
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
EQI4 $561
line 1481
;1481:		return "You are banned from this server.";
ADDRGP4 $563
RETP4
ADDRGP4 $555
JUMPV
LABELV $561
line 1487
;1482:	}
;1483:
;1484:  // we don't check password for bots and local client
;1485:  // NOTE: local client <-> "ip" "localhost"
;1486:  //   this means this client is not running in our current process
;1487:	if ( !( ent->r.svFlags & SVF_BOT ) && (strcmp(value, "localhost") != 0)) {
ADDRLP4 4
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $564
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 $485
ARGP4
ADDRLP4 1044
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
EQI4 $564
line 1489
;1488:	// check for a password
;1489:	value = Info_ValueForKey (userinfo, "password");
ADDRLP4 12
ARGP4
ADDRGP4 $566
ARGP4
ADDRLP4 1048
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 1048
INDIRP4
ASGNP4
line 1490
;1490:	if ( g_password.string[0] && Q_stricmp( g_password.string, "none" ) &&
ADDRGP4 g_password+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $567
ADDRGP4 g_password+16
ARGP4
ADDRGP4 $571
ARGP4
ADDRLP4 1052
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 0
EQI4 $567
ADDRGP4 g_password+16
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 1056
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
EQI4 $567
line 1491
;1491:		strcmp( g_password.string, value) != 0) {
line 1492
;1492:		return "Invalid password";
ADDRGP4 $573
RETP4
ADDRGP4 $555
JUMPV
LABELV $567
line 1494
;1493:	}
;1494:	}
LABELV $564
line 1497
;1495:
;1496:	// they can connect
;1497:	ent->client = level.clients + clientNum;
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
ADDRFP4 0
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 1498
;1498:	client = ent->client;
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 1502
;1499:
;1500://	areabits = client->areabits;
;1501:
;1502:	memset( client, 0, sizeof(*client) );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 5604
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1504
;1503:
;1504:	client->pers.connected = CON_CONNECTING;
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
CNSTI4 1
ASGNI4
line 1507
;1505:
;1506:#if ESCAPE_MODE	// JUHOX: set reference origin (has been cleared above)
;1507:	if (g_gametype.integer == GT_EFH) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
NEI4 $574
line 1508
;1508:		G_SetPlayerRefOrigin(&client->ps);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_SetPlayerRefOrigin
CALLV
pop
line 1509
;1509:	}
LABELV $574
line 1513
;1510:#endif
;1511:
;1512:	// read or initialize the session data
;1513:	if ( firstTime || level.newSession ) {
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $580
ADDRGP4 level+80
INDIRI4
CNSTI4 0
EQI4 $577
LABELV $580
line 1514
;1514:		G_InitSessionData( client, userinfo );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 G_InitSessionData
CALLV
pop
line 1515
;1515:	}
LABELV $577
line 1516
;1516:	G_ReadSessionData( client );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_ReadSessionData
CALLV
pop
line 1518
;1517:
;1518:	if( isBot ) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $581
line 1519
;1519:		ent->r.svFlags |= SVF_BOT;
ADDRLP4 1048
ADDRLP4 4
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 1048
INDIRP4
ADDRLP4 1048
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 1520
;1520:		ent->inuse = qtrue;
ADDRLP4 4
INDIRP4
CNSTI4 524
ADDP4
CNSTI4 1
ASGNI4
line 1521
;1521:		if( !G_BotConnect( clientNum, !firstTime ) ) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $586
ADDRLP4 1052
CNSTI4 1
ASGNI4
ADDRGP4 $587
JUMPV
LABELV $586
ADDRLP4 1052
CNSTI4 0
ASGNI4
LABELV $587
ADDRLP4 1052
INDIRI4
ARGI4
ADDRLP4 1056
ADDRGP4 G_BotConnect
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
NEI4 $583
line 1522
;1522:			return "BotConnectfailed";
ADDRGP4 $588
RETP4
ADDRGP4 $555
JUMPV
LABELV $583
line 1524
;1523:		}
;1524:	}
LABELV $581
line 1527
;1525:
;1526:	// get and distribute relevent paramters
;1527:	G_LogPrintf( "ClientConnect: %i\n", clientNum );
ADDRGP4 $589
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1528
;1528:	ClientUserinfoChanged( clientNum );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 ClientUserinfoChanged
CALLV
pop
line 1531
;1529:
;1530:	// don't do the "xxx connected" messages if they were caried over from previous level
;1531:	if ( firstTime ) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $590
line 1532
;1532:		trap_SendServerCommand( -1, va("print \"%s" S_COLOR_WHITE " connected\n\"", client->pers.netname) );
ADDRGP4 $592
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 1048
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 1048
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1533
;1533:	}
LABELV $590
line 1535
;1534:
;1535:	if ( g_gametype.integer >= GT_TEAM &&
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $593
ADDRLP4 0
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 3
EQI4 $593
line 1536
;1536:		client->sess.sessionTeam != TEAM_SPECTATOR ) {
line 1537
;1537:		BroadcastTeamChange( client, -1 );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 BroadcastTeamChange
CALLV
pop
line 1538
;1538:	}
LABELV $593
line 1541
;1539:
;1540:	// count current clients and rank for scoreboard
;1541:	CalculateRanks();
ADDRGP4 CalculateRanks
CALLV
pop
line 1548
;1542:
;1543:	// for statistics
;1544://	client->areabits = areabits;
;1545://	if ( !client->areabits )
;1546://		client->areabits = G_Alloc( (trap_AAS_PointReachabilityAreaIndex( NULL ) + 7) / 8 );
;1547:
;1548:	return NULL;
CNSTP4 0
RETP4
LABELV $555
endproc ClientConnect 1060 12
export ClientBegin
proc ClientBegin 28 12
line 1560
;1549:}
;1550:
;1551:/*
;1552:===========
;1553:ClientBegin
;1554:
;1555:called when a client has finished connecting, and is ready
;1556:to be placed into the level.  This will happen every level load,
;1557:and on transition between teams, but doesn't happen on respawns
;1558:============
;1559:*/
;1560:void ClientBegin( int clientNum ) {
line 1566
;1561:	gentity_t	*ent;
;1562:	gclient_t	*client;
;1563:	gentity_t	*tent;
;1564:	int			flags;
;1565:
;1566:	ent = g_entities + clientNum;
ADDRLP4 4
ADDRFP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1568
;1567:
;1568:	client = level.clients + clientNum;
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 1570
;1569:
;1570:	if ( ent->r.linked ) {
ADDRLP4 4
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
CNSTI4 0
EQI4 $597
line 1571
;1571:		trap_UnlinkEntity( ent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 1572
;1572:	}
LABELV $597
line 1573
;1573:	G_InitGentity( ent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_InitGentity
CALLV
pop
line 1574
;1574:	ent->touch = 0;
ADDRLP4 4
INDIRP4
CNSTI4 708
ADDP4
CNSTP4 0
ASGNP4
line 1575
;1575:	ent->pain = 0;
ADDRLP4 4
INDIRP4
CNSTI4 716
ADDP4
CNSTP4 0
ASGNP4
line 1576
;1576:	ent->client = client;
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 1578
;1577:
;1578:	client->pers.connected = CON_CONNECTED;
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
CNSTI4 2
ASGNI4
line 1579
;1579:	client->pers.enterTime = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 552
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1580
;1580:	client->pers.teamState.state = TEAM_BEGIN;
ADDRLP4 0
INDIRP4
CNSTI4 556
ADDP4
CNSTI4 0
ASGNI4
line 1581
;1581:	client->pers.lastUsedWeapon = WP_NONE;	// JUHOX
ADDRLP4 0
INDIRP4
CNSTI4 616
ADDP4
CNSTI4 0
ASGNI4
line 1582
;1582:	client->lasthurt_client = -1;	// JUHOX
ADDRLP4 0
INDIRP4
CNSTI4 820
ADDP4
CNSTI4 -1
ASGNI4
line 1589
;1583:
;1584:	// save eflags around this, because changing teams will
;1585:	// cause this to happen with a valid entity, and we
;1586:	// want to make sure the teleport bit is set right
;1587:	// so the viewpoint doesn't interpolate through the
;1588:	// world to the new position
;1589:	flags = client->ps.eFlags;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
ASGNI4
line 1590
;1590:	memset( &client->ps, 0, sizeof( client->ps ) );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 468
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1591
;1591:	client->ps.eFlags = flags;
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 1592
;1592:	BG_TSS_SetPlayerInfo(&client->ps, TSSPI_navAid, qtrue);
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 11
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BG_TSS_SetPlayerInfo
CALLV
pop
line 1596
;1593:
;1594:	// JUHOX: initialize first client position (JUHOX FIXME: still needed?)
;1595:#if 1
;1596:	VectorCopy(level.intermission_origin, client->ps.origin);
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRGP4 level+9160
INDIRB
ASGNB 12
line 1597
;1597:	VectorCopy(level.intermission_angle, client->ps.viewangles);
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
ADDRGP4 level+9172
INDIRB
ASGNB 12
line 1601
;1598:#endif
;1599:
;1600:	// locate ent at a spawn point
;1601:	ClientSpawn( ent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 ClientSpawn
CALLV
pop
line 1603
;1602:
;1603:	if ( client->sess.sessionTeam != TEAM_SPECTATOR ) {
ADDRLP4 0
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 3
EQI4 $602
line 1610
;1604:		// send event
;1605:		// JUHOX: don't send teleport event for dead respawn
;1606:#if 0
;1607:		tent = G_TempEntity( ent->client->ps.origin, EV_PLAYER_TELEPORT_IN );
;1608:		tent->s.clientNum = ent->s.clientNum;
;1609:#else
;1610:		if (client->ps.stats[STAT_HEALTH] > 0 && !level.meeting) {
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
LEI4 $604
ADDRGP4 level+24092
INDIRI4
CNSTI4 0
NEI4 $604
line 1611
;1611:			tent = G_TempEntity( ent->client->ps.origin, EV_PLAYER_TELEPORT_IN );
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
CNSTI4 42
ARGI4
ADDRLP4 16
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 16
INDIRP4
ASGNP4
line 1612
;1612:			tent->s.clientNum = ent->s.clientNum;
ADDRLP4 12
INDIRP4
CNSTI4 168
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 1613
;1613:		}
LABELV $604
line 1616
;1614:#endif
;1615:
;1616:		if ( g_gametype.integer != GT_TOURNAMENT  ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
EQI4 $607
line 1617
;1617:			trap_SendServerCommand( -1, va("print \"%s" S_COLOR_WHITE " entered the game\n\"", client->pers.netname) );
ADDRGP4 $610
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1618
;1618:		}
LABELV $607
line 1622
;1619:		// JUHOX FIXME: set team leader
;1620:#if 1
;1621:		if (
;1622:			g_gametype.integer >= GT_TEAM
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $611
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
EQI4 $611
line 1626
;1623:#if ESCAPE_MODE
;1624:			&& g_gametype.integer != GT_EFH	// no bots in EFH, so there's no need to set the teamleader
;1625:#endif
;1626:		) {
line 1629
;1627:			int teamleader;
;1628:
;1629:			teamleader = TeamLeader(client->sess.sessionTeam);
ADDRLP4 0
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 TeamLeader
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 20
INDIRI4
ASGNI4
line 1631
;1630:			if (
;1631:				teamleader < 0 ||
ADDRLP4 24
ADDRLP4 16
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
LTI4 $621
ADDRFP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+208+216
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $615
ADDRLP4 24
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+208+216
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $615
LABELV $621
line 1636
;1632:				(
;1633:					!(g_entities[clientNum].r.svFlags & SVF_BOT) &&
;1634:					(g_entities[teamleader].r.svFlags & SVF_BOT)
;1635:				)
;1636:			) {
line 1637
;1637:				SetLeader(client->sess.sessionTeam, clientNum);
ADDRLP4 0
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 SetLeader
CALLV
pop
line 1638
;1638:			}
LABELV $615
line 1639
;1639:		}
LABELV $611
line 1641
;1640:#endif
;1641:	}
LABELV $602
line 1642
;1642:	G_LogPrintf( "ClientBegin: %i\n", clientNum );
ADDRGP4 $622
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1645
;1643:
;1644:	// count current clients and rank for scoreboard
;1645:	CalculateRanks();
ADDRGP4 CalculateRanks
CALLV
pop
line 1646
;1646:}
LABELV $596
endproc ClientBegin 28 12
export GetRespawnLocationType
proc GetRespawnLocationType 92 28
line 1706
;1647:
;1648:/*
;1649:===========
;1650:JUHOX: GoAwayFromWall
;1651:============
;1652:*/
;1653:/*
;1654:static qboolean GoAwayFromWall(int clientNum, vec3_t origin, int* start) {
;1655:	trace_t trace;
;1656:	int i;
;1657:
;1658:	i = -1;
;1659:	if (start) i = *start;
;1660:	for (; i < 27; i++) {
;1661:		vec3_t pos;
;1662:
;1663:		VectorCopy(origin, pos);
;1664:		if (i >= 0) {
;1665:			switch (i % 3) {
;1666:			case 0:
;1667:				pos[0] -= 12;
;1668:				break;
;1669:			case 2:
;1670:				pos[0] += 12;
;1671:				break;
;1672:			}
;1673:			switch ((i/3) % 3) {
;1674:			case 0:
;1675:				pos[1] -= 12;
;1676:				break;
;1677:			case 2:
;1678:				pos[1] += 12;
;1679:				break;
;1680:			}
;1681:			switch ((i/9) % 3) {
;1682:			case 0:
;1683:				pos[2] -= 29;
;1684:				break;
;1685:			case 2:
;1686:				pos[2] += 21;
;1687:				break;
;1688:			}
;1689:		}
;1690:		trap_Trace(&trace, pos, playerMins, playerMaxs, pos, clientNum, MASK_PLAYERSOLID);
;1691:		if (!trace.allsolid) {
;1692:			VectorCopy(pos, origin);
;1693:			if (start) *start = i;
;1694:			return qtrue;
;1695:		}
;1696:	}
;1697:	return qfalse;
;1698:}
;1699:*/
;1700:
;1701:/*
;1702:===========
;1703:JUHOX: GetRespawnLocationType
;1704:============
;1705:*/
;1706:respawnLocationType_t GetRespawnLocationType(gentity_t* ent, int msec) {
line 1712
;1707:	vec3_t origin;
;1708:	vec3_t end;
;1709:	trace_t trace;
;1710:	respawnLocationType_t rlt;
;1711:
;1712:	if (!ent->client) return RLT_invalid;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $624
CNSTI4 3
RETI4
ADDRGP4 $623
JUMPV
LABELV $624
line 1713
;1713:	if (ent->client->ps.stats[STAT_HEALTH] > 0) return RLT_invalid;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
LEI4 $626
CNSTI4 3
RETI4
ADDRGP4 $623
JUMPV
LABELV $626
line 1715
;1714:#if MONSTER_MODE
;1715:	if (g_gametype.integer >= GT_STU) return RLT_regular;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
LTI4 $628
CNSTI4 2
RETI4
ADDRGP4 $623
JUMPV
LABELV $628
line 1717
;1716:#endif
;1717:	if (g_gametype.integer < GT_TEAM) return RLT_regular;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
GEI4 $631
CNSTI4 2
RETI4
ADDRGP4 $623
JUMPV
LABELV $631
line 1718
;1718:	if (g_respawnDelay.integer < 10) return RLT_regular;
ADDRGP4 g_respawnDelay+12
INDIRI4
CNSTI4 10
GEI4 $634
CNSTI4 2
RETI4
ADDRGP4 $623
JUMPV
LABELV $634
line 1720
;1719:
;1720:	if (msec >= 0) {
ADDRFP4 4
INDIRI4
CNSTI4 0
LTI4 $637
line 1721
;1721:		if (ent->r.svFlags & SVF_BOT) return RLT_invalid;
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $639
CNSTI4 3
RETI4
ADDRGP4 $623
JUMPV
LABELV $639
line 1722
;1722:		ent->client->timeResidual += msec;
ADDRLP4 84
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
ADDRFP4 4
INDIRI4
ADDI4
ASGNI4
line 1723
;1723:		if (ent->client->timeResidual < 500) return ent->client->ps.stats[STAT_RESPAWN_INFO] & 3;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 500
GEI4 $641
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 3
BANDI4
RETI4
ADDRGP4 $623
JUMPV
LABELV $641
line 1724
;1724:	}
LABELV $637
line 1725
;1725:	ent->client->timeResidual = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 892
ADDP4
CNSTI4 0
ASGNI4
line 1727
;1726:
;1727:	if (ent->client->ps.persistant[PERS_SPAWN_COUNT] == 0) return RLT_invalid;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 264
ADDP4
INDIRI4
CNSTI4 0
NEI4 $643
CNSTI4 3
RETI4
ADDRGP4 $623
JUMPV
LABELV $643
line 1728
;1728:	if (ent->client->respawnDelay < 0) return RLT_invalid;	// overkill / capture condition: don't show respawn position hint
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 836
ADDP4
INDIRI4
CNSTI4 0
GEI4 $645
CNSTI4 3
RETI4
ADDRGP4 $623
JUMPV
LABELV $645
line 1730
;1729:
;1730:	if (ent->client->buttons & BUTTON_USE_HOLDABLE) return RLT_regular;	// player wants to use a regular spawn point
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $647
CNSTI4 2
RETI4
ADDRGP4 $623
JUMPV
LABELV $647
line 1732
;1731:
;1732:	rlt = RLT_here;
ADDRLP4 80
CNSTI4 0
ASGNI4
line 1733
;1733:	VectorCopy(ent->client->ps.origin, origin);
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 1734
;1734:	if (g_gametype.integer == GT_CTF) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $649
line 1735
;1735:		if (!NearHomeBase(ent->client->sess.sessionTeam, ent->client->ps.origin, 1)) {
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
ARGI4
ADDRLP4 84
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRLP4 88
ADDRGP4 NearHomeBase
CALLI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 0
NEI4 $652
line 1736
;1736:			if (!g_respawnAtPOD.integer) return RLT_regular;
ADDRGP4 g_respawnAtPOD+12
INDIRI4
CNSTI4 0
NEI4 $654
CNSTI4 2
RETI4
ADDRGP4 $623
JUMPV
LABELV $654
line 1737
;1737:			if (!ent->client->mayRespawnAtDeathOrigin) return RLT_regular;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 984
ADDP4
INDIRI4
CNSTI4 0
NEI4 $657
CNSTI4 2
RETI4
ADDRGP4 $623
JUMPV
LABELV $657
line 1738
;1738:			rlt = RLT_atPOD;
ADDRLP4 80
CNSTI4 1
ASGNI4
line 1739
;1739:			VectorCopy(ent->client->deathOrigin, origin);
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 988
ADDP4
INDIRB
ASGNB 12
line 1740
;1740:		}
LABELV $652
line 1741
;1741:	}
LABELV $649
line 1742
;1742:	VectorCopy(origin, end);
ADDRLP4 68
ADDRLP4 56
INDIRB
ASGNB 12
line 1743
;1743:	end[2] -= 10000;
ADDRLP4 68+8
ADDRLP4 68+8
INDIRF4
CNSTF4 1176256512
SUBF4
ASGNF4
line 1744
;1744:	trap_Trace(
ADDRLP4 0
ARGP4
ADDRLP4 56
ARGP4
ADDRGP4 playerMins
ARGP4
ADDRGP4 playerMaxs
ARGP4
ADDRLP4 68
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
CNSTU4 2147549209
CVUI4 4
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1748
;1745:		&trace, origin, playerMins, playerMaxs, end, ent->client->ps.clientNum,
;1746:		(int)(CONTENTS_SOLID|CONTENTS_PLAYERCLIP|CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_NODROP)
;1747:	);
;1748:	if (trace.startsolid || trace.allsolid) return RLT_regular;
ADDRLP4 0+4
INDIRI4
CNSTI4 0
NEI4 $663
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $660
LABELV $663
CNSTI4 2
RETI4
ADDRGP4 $623
JUMPV
LABELV $660
line 1749
;1749:	if (trace.fraction >= 0.99) return RLT_regular;
ADDRLP4 0+8
INDIRF4
CNSTF4 1065185444
LTF4 $664
CNSTI4 2
RETI4
ADDRGP4 $623
JUMPV
LABELV $664
line 1750
;1750:	if (trace.contents & (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_NODROP)) return RLT_regular;
ADDRLP4 0+48
INDIRI4
CVIU4 4
CNSTU4 2147483672
BANDU4
CNSTU4 0
EQU4 $667
CNSTI4 2
RETI4
ADDRGP4 $623
JUMPV
LABELV $667
line 1751
;1751:	VectorCopy(trace.endpos, origin);
ADDRLP4 56
ADDRLP4 0+12
INDIRB
ASGNB 12
line 1753
;1752:
;1753:	if (PositionWouldTelefrag(origin, playerMins, playerMaxs)) return RLT_regular;
ADDRLP4 56
ARGP4
ADDRGP4 playerMins
ARGP4
ADDRGP4 playerMaxs
ARGP4
ADDRLP4 84
ADDRGP4 PositionWouldTelefrag
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
EQI4 $671
CNSTI4 2
RETI4
ADDRGP4 $623
JUMPV
LABELV $671
line 1755
;1754:
;1755:	if (msec < 0) {
ADDRFP4 4
INDIRI4
CNSTI4 0
GEI4 $673
line 1756
;1756:		VectorCopy(origin, ent->client->ps.origin);
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 56
INDIRB
ASGNB 12
line 1757
;1757:	}
LABELV $673
line 1759
;1758:
;1759:	return rlt;
ADDRLP4 80
INDIRI4
RETI4
LABELV $623
endproc GetRespawnLocationType 92 28
export CheckFreeSpawn
proc CheckFreeSpawn 16 8
line 1768
;1760:}
;1761:
;1762:/*
;1763:===========
;1764:JUHOX: CheckFreeSpawn
;1765:check if the entity may spawn at its current origin
;1766:============
;1767:*/
;1768:qboolean CheckFreeSpawn(gentity_t* ent) {
line 1769
;1769:	switch (GetRespawnLocationType(ent, -1)) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 4
ADDRGP4 GetRespawnLocationType
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $676
ADDRLP4 0
INDIRI4
CNSTI4 3
GTI4 $676
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $682
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $682
address $680
address $681
address $679
address $679
code
LABELV $679
LABELV $676
line 1773
;1770:	case RLT_invalid:
;1771:	case RLT_regular:
;1772:	default:
;1773:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $675
JUMPV
LABELV $680
line 1775
;1774:	case RLT_here:
;1775:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $675
JUMPV
LABELV $681
line 1777
;1776:	case RLT_atPOD:
;1777:		VectorCopy(ent->client->deathAngles, ent->client->ps.viewangles);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 152
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1000
ADDP4
INDIRB
ASGNB 12
line 1778
;1778:		return qtrue;
CNSTI4 1
RETI4
LABELV $675
endproc CheckFreeSpawn 16 8
export ClientSpawn
proc ClientSpawn 1628 16
line 1791
;1779:	}
;1780:}
;1781:
;1782:/*
;1783:===========
;1784:ClientSpawn
;1785:
;1786:Called every time a client is placed fresh in the world:
;1787:after the first ClientBegin, and after each respawn
;1788:Initializes all non-persistant parts of playerState
;1789:============
;1790:*/
;1791:void ClientSpawn(gentity_t *ent) {
line 1813
;1792:	int		index;
;1793:	vec3_t	spawn_origin, spawn_angles;
;1794:	gclient_t	*client;
;1795:	int		i;
;1796:	clientPersistant_t	saved;
;1797:	clientSession_t		savedSess;
;1798:	int		persistant[MAX_PERSISTANT];
;1799:	int		savedAmmo[MAX_WEAPONS];	// JUHOX
;1800:	float	savedAmmoFraction[MAX_WEAPONS];	// JUHOX
;1801:	int		savedStrength;	// JUHOX
;1802:	int		savedPowerups[16 - PW_NUM_POWERUPS];	// JUHOX
;1803:	gentity_t	*spawnPoint;
;1804:	int		flags;
;1805:	int		savedPing;
;1806://	char	*savedAreaBits;
;1807:	int		accuracy_hits, accuracy_shots;
;1808:	int		eventSequence;
;1809:	char	userinfo[MAX_INFO_STRING];
;1810:	qboolean deadSpawn;	// JUHOX
;1811:	qboolean overkillSpawn;	// JUHOX
;1812:
;1813:	index = ent - g_entities;
ADDRLP4 228
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ASGNI4
line 1814
;1814:	client = ent->client;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 1815
;1815:	deadSpawn = qfalse;	// JUHOX
ADDRLP4 232
CNSTI4 0
ASGNI4
line 1816
;1816:	overkillSpawn = (client->respawnDelay < 0);	// JUHOX
ADDRLP4 4
INDIRP4
CNSTI4 836
ADDP4
INDIRI4
CNSTI4 0
GEI4 $685
ADDRLP4 1556
CNSTI4 1
ASGNI4
ADDRGP4 $686
JUMPV
LABELV $685
ADDRLP4 1556
CNSTI4 0
ASGNI4
LABELV $686
ADDRLP4 1552
ADDRLP4 1556
INDIRI4
ASGNI4
line 1817
;1817:	client->tssNavAidTimeResidual = rand() % 1000;	// JUHOX
ADDRLP4 1560
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 896
ADDP4
ADDRLP4 1560
INDIRI4
CNSTI4 1000
MODI4
ASGNI4
line 1818
;1818:	if (client->podMarker) G_FreeEntity(client->podMarker);	// JUHOX
ADDRLP4 4
INDIRP4
CNSTI4 1012
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $687
ADDRLP4 4
INDIRP4
CNSTI4 1012
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
LABELV $687
line 1823
;1819:
;1820:	// find a spawn point
;1821:	// do it before setting health back up, so farthest
;1822:	// ranging doesn't count this client
;1823:	if ( client->sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRLP4 4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 3
NEI4 $689
line 1824
;1824:		spawnPoint = SelectSpectatorSpawnPoint ( 
ADDRLP4 204
ARGP4
ADDRLP4 216
ARGP4
ADDRLP4 1564
ADDRGP4 SelectSpectatorSpawnPoint
CALLP4
ASGNP4
ADDRLP4 200
ADDRLP4 1564
INDIRP4
ASGNP4
line 1829
;1825:						spawn_origin, spawn_angles);
;1826:#if !MONSTER_MODE	// JUHOX: don't respawn at CTF spawn points in STU
;1827:	} else if (g_gametype.integer >= GT_CTF ) {
;1828:#else
;1829:	}
ADDRGP4 $690
JUMPV
LABELV $689
line 1830
;1830:	else if (g_gametype.integer >= GT_TEAM && g_gametype.integer < GT_STU) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $691
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
GEI4 $691
line 1833
;1831:#endif
;1832:#if 1	// JUHOX: check if a free spawn is possible
;1833:		if (CheckFreeSpawn(ent)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1564
ADDRGP4 CheckFreeSpawn
CALLI4
ASGNI4
ADDRLP4 1564
INDIRI4
CNSTI4 0
EQI4 $695
line 1834
;1834:			spawnPoint = NULL;
ADDRLP4 200
CNSTP4 0
ASGNP4
line 1835
;1835:			VectorCopy(client->ps.origin, spawn_origin);
ADDRLP4 204
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 1836
;1836:			VectorCopy(client->ps.viewangles, spawn_angles);
ADDRLP4 216
ADDRLP4 4
INDIRP4
CNSTI4 152
ADDP4
INDIRB
ASGNB 12
line 1837
;1837:			goto SpawnPointChoosen;
ADDRGP4 $697
JUMPV
LABELV $695
line 1841
;1838:		}
;1839:#endif
;1840:		// all base oriented team games use the CTF spawn points
;1841:		spawnPoint = SelectCTFSpawnPoint ( 
ADDRLP4 4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
ARGI4
ADDRLP4 204
ARGP4
ADDRLP4 216
ARGP4
ADDRLP4 1572
ADDRGP4 SelectCTFSpawnPoint
CALLP4
ASGNP4
ADDRLP4 200
ADDRLP4 1572
INDIRP4
ASGNP4
line 1845
;1842:						client->sess.sessionTeam, 
;1843:						client->pers.teamState.state, 
;1844:						spawn_origin, spawn_angles);
;1845:	} else {
ADDRGP4 $692
JUMPV
LABELV $691
line 1847
;1846:#if 1	// JUHOX: check if a free spawn is possible
;1847:		if (CheckFreeSpawn(ent)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1564
ADDRGP4 CheckFreeSpawn
CALLI4
ASGNI4
ADDRLP4 1564
INDIRI4
CNSTI4 0
EQI4 $698
line 1848
;1848:			spawnPoint = NULL;
ADDRLP4 200
CNSTP4 0
ASGNP4
line 1849
;1849:			VectorCopy(client->ps.origin, spawn_origin);
ADDRLP4 204
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 1850
;1850:			VectorCopy(client->ps.viewangles, spawn_angles);
ADDRLP4 216
ADDRLP4 4
INDIRP4
CNSTI4 152
ADDP4
INDIRB
ASGNB 12
line 1851
;1851:			goto SpawnPointChoosen;
ADDRGP4 $697
JUMPV
LABELV $698
LABELV $700
line 1854
;1852:		}
;1853:#endif
;1854:		do {
line 1857
;1855:			// the first spawn should be at a good looking spot
;1856:#if MONSTER_MODE	// JUHOX: in STU use level.time to check for initial spawn
;1857:			if (g_gametype.integer >= GT_STU /*&& level.time < level.startTime + 5000*/) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
LTI4 $703
line 1858
;1858:				client->pers.initialSpawn = qtrue;
ADDRLP4 4
INDIRP4
CNSTI4 500
ADDP4
CNSTI4 1
ASGNI4
line 1859
;1859:				spawnPoint = SelectSpawnPoint(NULL, spawn_origin, spawn_angles);
CNSTP4 0
ARGP4
ADDRLP4 204
ARGP4
ADDRLP4 216
ARGP4
ADDRLP4 1568
ADDRGP4 SelectSpawnPoint
CALLP4
ASGNP4
ADDRLP4 200
ADDRLP4 1568
INDIRP4
ASGNP4
line 1860
;1860:			}
ADDRGP4 $704
JUMPV
LABELV $703
line 1863
;1861:			else
;1862:#endif
;1863:			if ( !client->pers.initialSpawn && client->pers.localClient ) {
ADDRLP4 4
INDIRP4
CNSTI4 500
ADDP4
INDIRI4
CNSTI4 0
NEI4 $706
ADDRLP4 4
INDIRP4
CNSTI4 496
ADDP4
INDIRI4
CNSTI4 0
EQI4 $706
line 1864
;1864:				client->pers.initialSpawn = qtrue;
ADDRLP4 4
INDIRP4
CNSTI4 500
ADDP4
CNSTI4 1
ASGNI4
line 1865
;1865:				spawnPoint = SelectInitialSpawnPoint( spawn_origin, spawn_angles );
ADDRLP4 204
ARGP4
ADDRLP4 216
ARGP4
ADDRLP4 1572
ADDRGP4 SelectInitialSpawnPoint
CALLP4
ASGNP4
ADDRLP4 200
ADDRLP4 1572
INDIRP4
ASGNP4
line 1866
;1866:			} else {
ADDRGP4 $707
JUMPV
LABELV $706
line 1868
;1867:				// don't spawn near existing origin if possible
;1868:				spawnPoint = SelectSpawnPoint ( 
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 204
ARGP4
ADDRLP4 216
ARGP4
ADDRLP4 1572
ADDRGP4 SelectSpawnPoint
CALLP4
ASGNP4
ADDRLP4 200
ADDRLP4 1572
INDIRP4
ASGNP4
line 1871
;1869:					client->ps.origin, 
;1870:					spawn_origin, spawn_angles);
;1871:			}
LABELV $707
LABELV $704
line 1873
;1872:
;1873:			if (!spawnPoint) return;	// JUHOX
ADDRLP4 200
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $708
ADDRGP4 $683
JUMPV
LABELV $708
line 1877
;1874:
;1875:			// Tim needs to prevent bots from spawning at the initial point
;1876:			// on q3dm0...
;1877:			if ( ( spawnPoint->flags & FL_NO_BOTS ) && ( ent->r.svFlags & SVF_BOT ) ) {
ADDRLP4 200
INDIRP4
CNSTI4 540
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $710
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $710
line 1878
;1878:				continue;	// try again
ADDRGP4 $701
JUMPV
LABELV $710
line 1881
;1879:			}
;1880:			// just to be symetric, we have a nohumans option...
;1881:			if ( ( spawnPoint->flags & FL_NO_HUMANS ) && !( ent->r.svFlags & SVF_BOT ) ) {
ADDRLP4 200
INDIRP4
CNSTI4 540
ADDP4
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $702
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $702
line 1882
;1882:				continue;	// try again
line 1885
;1883:			}
;1884:
;1885:			break;
LABELV $701
line 1887
;1886:
;1887:		} while ( 1 );
ADDRGP4 $700
JUMPV
LABELV $702
line 1888
;1888:	}
LABELV $692
LABELV $690
line 1890
;1889:#if 1	// JUHOX: spawn at current position if spawn point would telefrag
;1890:	if (client->sess.sessionTeam != TEAM_SPECTATOR && SpotWouldTelefrag(spawnPoint)) {
ADDRLP4 4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 3
EQI4 $714
ADDRLP4 200
INDIRP4
ARGP4
ADDRLP4 1564
ADDRGP4 SpotWouldTelefrag
CALLI4
ASGNI4
ADDRLP4 1564
INDIRI4
CNSTI4 0
EQI4 $714
line 1891
;1891:		if (client->ps.persistant[PERS_SPAWN_COUNT] != 0) return;
ADDRLP4 4
INDIRP4
CNSTI4 264
ADDP4
INDIRI4
CNSTI4 0
EQI4 $716
ADDRGP4 $683
JUMPV
LABELV $716
line 1893
;1892:		// this is the first spawn. make it a dead spawn.
;1893:		VectorCopy(level.intermission_origin, client->ps.origin);
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
ADDRGP4 level+9160
INDIRB
ASGNB 12
line 1894
;1894:		VectorCopy(level.intermission_angle, client->ps.viewangles);
ADDRLP4 4
INDIRP4
CNSTI4 152
ADDP4
ADDRGP4 level+9172
INDIRB
ASGNB 12
line 1895
;1895:		deadSpawn = qtrue;
ADDRLP4 232
CNSTI4 1
ASGNI4
line 1896
;1896:	}
LABELV $714
LABELV $697
line 1899
;1897:#endif
;1898:	SpawnPointChoosen:	// JUHOX
;1899:	client->pers.teamState.state = TEAM_ACTIVE;
ADDRLP4 4
INDIRP4
CNSTI4 556
ADDP4
CNSTI4 1
ASGNI4
line 1902
;1900:
;1901:	// always clear the kamikaze flag
;1902:	ent->s.eFlags &= ~EF_KAMIKAZE;
ADDRLP4 1568
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 1568
INDIRP4
ADDRLP4 1568
INDIRP4
INDIRI4
CNSTI4 -513
BANDI4
ASGNI4
line 1906
;1903:
;1904:	// toggle the teleport bit so the client knows to not lerp
;1905:	// and never clear the voted flag
;1906:	flags = ent->client->ps.eFlags & (EF_TELEPORT_BIT | EF_VOTED | EF_TEAMVOTED);
ADDRLP4 236
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
CNSTI4 16390
BANDI4
ASGNI4
line 1907
;1907:	flags ^= EF_TELEPORT_BIT;
ADDRLP4 236
ADDRLP4 236
INDIRI4
CNSTI4 4
BXORI4
ASGNI4
line 1911
;1908:
;1909:	// clear everything but the persistant data
;1910:
;1911:	saved = client->pers;
ADDRLP4 1264
ADDRLP4 4
INDIRP4
CNSTI4 468
ADDP4
INDIRB
ASGNB 228
line 1912
;1912:	savedSess = client->sess;
ADDRLP4 1492
ADDRLP4 4
INDIRP4
CNSTI4 696
ADDP4
INDIRB
ASGNB 28
line 1913
;1913:	savedPing = client->ps.ping;
ADDRLP4 1536
ADDRLP4 4
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
ASGNI4
line 1915
;1914://	savedAreaBits = client->areabits;
;1915:	accuracy_hits = client->accuracy_hits;
ADDRLP4 1540
ADDRLP4 4
INDIRP4
CNSTI4 812
ADDP4
INDIRI4
ASGNI4
line 1916
;1916:	accuracy_shots = client->accuracy_shots;
ADDRLP4 1544
ADDRLP4 4
INDIRP4
CNSTI4 808
ADDP4
INDIRI4
ASGNI4
line 1917
;1917:	for ( i = 0 ; i < MAX_PERSISTANT ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $720
line 1918
;1918:		persistant[i] = client->ps.persistant[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 248
ADDP4
ADDP4
INDIRI4
ASGNI4
line 1919
;1919:	}
LABELV $721
line 1917
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $720
line 1920
;1920:	eventSequence = client->ps.eventSequence;
ADDRLP4 1548
ADDRLP4 4
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
ASGNI4
line 1922
;1921:#if 1	// JUHOX: save ammo
;1922:	for (i = 0; i < MAX_WEAPONS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $724
line 1923
;1923:		savedAmmo[i] = client->ps.ammo[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 72
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
ASGNI4
line 1924
;1924:		savedAmmoFraction[i] = client->ammoFraction[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 136
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 900
ADDP4
ADDP4
INDIRF4
ASGNF4
line 1925
;1925:	}
LABELV $725
line 1922
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $724
line 1927
;1926:#endif
;1927:	savedStrength = client->ps.stats[STAT_STRENGTH];	// JUHOX
ADDRLP4 1520
ADDRLP4 4
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ASGNI4
line 1928
;1928:	memcpy(savedPowerups, &client->ps.powerups[PW_NUM_POWERUPS], (16-PW_NUM_POWERUPS) * sizeof(int));	// JUHOX
ADDRLP4 1524
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 364
ADDP4
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1930
;1929:
;1930:	memset (client, 0, sizeof(*client)); // bk FIXME: Com_Memset?
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 5604
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1932
;1931:
;1932:	client->pers = saved;
ADDRLP4 4
INDIRP4
CNSTI4 468
ADDP4
ADDRLP4 1264
INDIRB
ASGNB 228
line 1933
;1933:	client->sess = savedSess;
ADDRLP4 4
INDIRP4
CNSTI4 696
ADDP4
ADDRLP4 1492
INDIRB
ASGNB 28
line 1934
;1934:	client->ps.ping = savedPing;
ADDRLP4 4
INDIRP4
CNSTI4 452
ADDP4
ADDRLP4 1536
INDIRI4
ASGNI4
line 1936
;1935://	client->areabits = savedAreaBits;
;1936:	client->accuracy_hits = accuracy_hits;
ADDRLP4 4
INDIRP4
CNSTI4 812
ADDP4
ADDRLP4 1540
INDIRI4
ASGNI4
line 1937
;1937:	client->accuracy_shots = accuracy_shots;
ADDRLP4 4
INDIRP4
CNSTI4 808
ADDP4
ADDRLP4 1544
INDIRI4
ASGNI4
line 1938
;1938:	client->lastkilled_client = -1;
ADDRLP4 4
INDIRP4
CNSTI4 816
ADDP4
CNSTI4 -1
ASGNI4
line 1940
;1939:
;1940:	for ( i = 0 ; i < MAX_PERSISTANT ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $728
line 1941
;1941:		client->ps.persistant[i] = persistant[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 248
ADDP4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
INDIRI4
ASGNI4
line 1942
;1942:	}
LABELV $729
line 1940
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $728
line 1944
;1943:#if 1	// JUHOX: restore ammo
;1944:	for (i = 0; i < MAX_WEAPONS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $732
line 1945
;1945:		client->ps.ammo[i] = savedAmmo[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 72
ADDP4
INDIRI4
ASGNI4
line 1946
;1946:		client->ammoFraction[i] = savedAmmoFraction[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 900
ADDP4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 136
ADDP4
INDIRF4
ASGNF4
line 1947
;1947:	}
LABELV $733
line 1944
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $732
line 1949
;1948:#endif
;1949:	client->ps.stats[STAT_STRENGTH] = savedStrength;	// JUHOX
ADDRLP4 4
INDIRP4
CNSTI4 212
ADDP4
ADDRLP4 1520
INDIRI4
ASGNI4
line 1950
;1950:	memcpy(&client->ps.powerups[PW_NUM_POWERUPS], savedPowerups, (16-PW_NUM_POWERUPS) * sizeof(int));	// JUHOX
ADDRLP4 4
INDIRP4
CNSTI4 364
ADDP4
ARGP4
ADDRLP4 1524
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1966
;1951:#if 0	// -JUHOX: activate shield on first spawn and on overkill
;1952:	if (client->sess.sessionTeam == TEAM_SPECTATOR) {
;1953:		if (client->ps.persistant[PERS_SPAWN_COUNT] == 0 || overkillSpawn) {
;1954:			client->ps.powerups[PW_SHIELD] = level.time + 10000;
;1955:		}
;1956:		/*
;1957:		else if (g_gametype.integer >= GT_CTF) {
;1958:			if (!NearHomeBase(client->sess.sessionTeam, spawn_origin, 1)) {
;1959:				client->ps.powerups[PW_QUAD] = level.time + 5000;
;1960:			}
;1961:		}
;1962:		*/
;1963:	}
;1964:#endif
;1965:#if 1	// JUHOX: add shield
;1966:	if (client->sess.sessionTeam != TEAM_SPECTATOR) {
ADDRLP4 4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 3
EQI4 $736
line 1967
;1967:		client->ps.powerups[PW_SHIELD] = level.time + 400;	// JUHOX
ADDRLP4 4
INDIRP4
CNSTI4 356
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 400
ADDI4
ASGNI4
line 1969
;1968:#if MONSTER_MODE	// JUHOX: activate shield in STU
;1969:		if (g_gametype.integer == GT_STU) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
NEI4 $739
line 1970
;1970:			client->ps.powerups[PW_SHIELD] = level.time + 5000;
ADDRLP4 4
INDIRP4
CNSTI4 356
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 5000
ADDI4
ASGNI4
line 1971
;1971:		}
LABELV $739
line 1973
;1972:#endif
;1973:	}
LABELV $736
line 1975
;1974:#endif
;1975:	client->ps.eventSequence = eventSequence;
ADDRLP4 4
INDIRP4
CNSTI4 108
ADDP4
ADDRLP4 1548
INDIRI4
ASGNI4
line 1977
;1976:	// increment the spawncount so the client will detect the respawn
;1977:	client->ps.persistant[PERS_SPAWN_COUNT]++;
ADDRLP4 1572
ADDRLP4 4
INDIRP4
CNSTI4 264
ADDP4
ASGNP4
ADDRLP4 1572
INDIRP4
ADDRLP4 1572
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1978
;1978:	client->ps.persistant[PERS_TEAM] = client->sess.sessionTeam;
ADDRLP4 4
INDIRP4
CNSTI4 260
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
ASGNI4
line 1980
;1979:#if ESCAPE_MODE	// JUHOX: set reference origin
;1980:	if (g_gametype.integer == GT_EFH) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
NEI4 $743
line 1981
;1981:		G_SetPlayerRefOrigin(&client->ps);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_SetPlayerRefOrigin
CALLV
pop
line 1982
;1982:	}
LABELV $743
line 1985
;1983:#endif
;1984:
;1985:	client->airOutTime = level.time + 12000;
ADDRLP4 4
INDIRP4
CNSTI4 868
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 12000
ADDI4
ASGNI4
line 1987
;1986:
;1987:	trap_GetUserinfo( index, userinfo, sizeof(userinfo) );
ADDRLP4 228
INDIRI4
ARGI4
ADDRLP4 240
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 1989
;1988:	// set max health
;1989:	client->pers.maxHealth = atoi( Info_ValueForKey( userinfo, "handicap" ) );
ADDRLP4 240
ARGP4
ADDRGP4 $500
ARGP4
ADDRLP4 1580
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1580
INDIRP4
ARGP4
ADDRLP4 1584
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 548
ADDP4
ADDRLP4 1584
INDIRI4
ASGNI4
line 1990
;1990:	if ( client->pers.maxHealth < 1 || client->pers.maxHealth > 100 ) {
ADDRLP4 4
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
CNSTI4 1
LTI4 $749
ADDRLP4 4
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
CNSTI4 100
LEI4 $747
LABELV $749
line 1991
;1991:		client->pers.maxHealth = 100;
ADDRLP4 4
INDIRP4
CNSTI4 548
ADDP4
CNSTI4 100
ASGNI4
line 1992
;1992:	}
LABELV $747
line 1997
;1993:	// clear entity values
;1994:#if 0	// JUHOX: set max. health
;1995:	client->ps.stats[STAT_MAX_HEALTH] = client->pers.maxHealth;
;1996:#else
;1997:	client->ps.stats[STAT_MAX_HEALTH] = g_baseHealth.value * (client->pers.maxHealth / 100.0);
ADDRLP4 4
INDIRP4
CNSTI4 204
ADDP4
ADDRGP4 g_baseHealth+8
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1008981770
MULF4
MULF4
CVFI4 4
ASGNI4
line 1998
;1998:	if (client->ps.stats[STAT_MAX_HEALTH] < 1) client->ps.stats[STAT_MAX_HEALTH] = 1;
ADDRLP4 4
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 1
GEI4 $751
ADDRLP4 4
INDIRP4
CNSTI4 204
ADDP4
CNSTI4 1
ASGNI4
LABELV $751
line 2000
;1999:#endif
;2000:	client->ps.eFlags = flags;
ADDRLP4 4
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 236
INDIRI4
ASGNI4
line 2002
;2001:
;2002:	ent->s.groundEntityNum = ENTITYNUM_NONE;
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 1023
ASGNI4
line 2003
;2003:	ent->client = &level.clients[index];
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
ADDRLP4 228
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 2004
;2004:	ent->takedamage = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
CNSTI4 1
ASGNI4
line 2005
;2005:	ent->inuse = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
CNSTI4 1
ASGNI4
line 2006
;2006:	ent->classname = "player";
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
ADDRGP4 $753
ASGNP4
line 2007
;2007:	ent->r.contents = CONTENTS_BODY;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 33554432
ASGNI4
line 2008
;2008:	ent->clipmask = MASK_PLAYERSOLID;
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
CNSTI4 33619969
ASGNI4
line 2009
;2009:	ent->die = player_die;
ADDRFP4 0
INDIRP4
CNSTI4 720
ADDP4
ADDRGP4 player_die
ASGNP4
line 2010
;2010:	ent->waterlevel = 0;
ADDRFP4 0
INDIRP4
CNSTI4 792
ADDP4
CNSTI4 0
ASGNI4
line 2011
;2011:	ent->watertype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 788
ADDP4
CNSTI4 0
ASGNI4
line 2012
;2012:	ent->flags = 0;
ADDRFP4 0
INDIRP4
CNSTI4 540
ADDP4
CNSTI4 0
ASGNI4
line 2014
;2013:	
;2014:	VectorCopy (playerMins, ent->r.mins);
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
ADDRGP4 playerMins
INDIRB
ASGNB 12
line 2015
;2015:	VectorCopy (playerMaxs, ent->r.maxs);
ADDRFP4 0
INDIRP4
CNSTI4 448
ADDP4
ADDRGP4 playerMaxs
INDIRB
ASGNB 12
line 2017
;2016:
;2017:	client->ps.clientNum = index;
ADDRLP4 4
INDIRP4
CNSTI4 140
ADDP4
ADDRLP4 228
INDIRI4
ASGNI4
line 2033
;2018:
;2019:#if 0	// JUHOX: weapon initialization done later
;2020:	client->ps.stats[STAT_WEAPONS] = ( 1 << WP_MACHINEGUN );
;2021:	if ( g_gametype.integer == GT_TEAM ) {
;2022:		client->ps.ammo[WP_MACHINEGUN] = 50;
;2023:	} else {
;2024:		client->ps.ammo[WP_MACHINEGUN] = 100;
;2025:	}
;2026:
;2027:	client->ps.stats[STAT_WEAPONS] |= ( 1 << WP_GAUNTLET );
;2028:	client->ps.ammo[WP_GAUNTLET] = -1;
;2029:	client->ps.ammo[WP_GRAPPLING_HOOK] = -1;
;2030:#endif
;2031:
;2032:	// health will count down towards max_health
;2033:	ent->health = client->ps.stats[STAT_HEALTH] = client->ps.stats[STAT_MAX_HEALTH] + 25;
ADDRLP4 1600
ADDRLP4 4
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 25
ADDI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 1600
INDIRI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
ADDRLP4 1600
INDIRI4
ASGNI4
line 2035
;2034:
;2035:	G_SetOrigin( ent, spawn_origin );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 204
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 2036
;2036:	VectorCopy( spawn_origin, client->ps.origin );
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 204
INDIRB
ASGNB 12
line 2039
;2037:
;2038:	// the respawned flag will be cleared after the attack and jump keys come up
;2039:	client->ps.pm_flags |= PMF_RESPAWNED;
ADDRLP4 1604
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 1604
INDIRP4
ADDRLP4 1604
INDIRP4
INDIRI4
CNSTI4 512
BORI4
ASGNI4
line 2041
;2040:
;2041:	trap_GetUsercmd( client - level.clients, &ent->client->pers.cmd );
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRGP4 level
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 5604
DIVI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 472
ADDP4
ARGP4
ADDRGP4 trap_GetUsercmd
CALLV
pop
line 2042
;2042:	SetClientViewAngle( ent, spawn_angles );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 216
ARGP4
ADDRGP4 SetClientViewAngle
CALLV
pop
line 2047
;2043:
;2044:#if 0	// JUHOX: don't KillBox() on dead spawn
;2045:	if ( ent->client->sess.sessionTeam == TEAM_SPECTATOR ) {
;2046:#else
;2047:	if ( deadSpawn || ent->client->sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRLP4 232
INDIRI4
CNSTI4 0
NEI4 $756
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 3
NEI4 $754
LABELV $756
line 2050
;2048:#endif
;2049:
;2050:	} else {
ADDRGP4 $755
JUMPV
LABELV $754
line 2051
;2051:		G_KillBox( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_KillBox
CALLV
pop
line 2052
;2052:		trap_LinkEntity (ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 2055
;2053:
;2054:		// force the base weapon up
;2055:		client->ps.weapon = WP_MACHINEGUN;
ADDRLP4 4
INDIRP4
CNSTI4 144
ADDP4
CNSTI4 2
ASGNI4
line 2056
;2056:		client->ps.weaponstate = WEAPON_READY;
ADDRLP4 4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 2058
;2057:
;2058:	}
LABELV $755
line 2061
;2059:
;2060:	// don't allow full run speed for a bit
;2061:	client->ps.pm_flags |= PMF_TIME_KNOCKBACK;
ADDRLP4 1608
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 1608
INDIRP4
ADDRLP4 1608
INDIRP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
line 2062
;2062:	client->ps.pm_time = 100;
ADDRLP4 4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 100
ASGNI4
line 2064
;2063:
;2064:	client->respawnTime = level.time;
ADDRLP4 4
INDIRP4
CNSTI4 832
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 2065
;2065:	client->inactivityTime = level.time + g_inactivity.integer * 1000;
ADDRLP4 4
INDIRP4
CNSTI4 840
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRGP4 g_inactivity+12
INDIRI4
CNSTI4 1000
MULI4
ADDI4
ASGNI4
line 2066
;2066:	client->latched_buttons = 0;
ADDRLP4 4
INDIRP4
CNSTI4 744
ADDP4
CNSTI4 0
ASGNI4
line 2069
;2067:
;2068:	// set default animations
;2069:	client->ps.torsoAnim = TORSO_STAND;
ADDRLP4 4
INDIRP4
CNSTI4 84
ADDP4
CNSTI4 11
ASGNI4
line 2070
;2070:	client->ps.legsAnim = LEGS_IDLE;
ADDRLP4 4
INDIRP4
CNSTI4 76
ADDP4
CNSTI4 22
ASGNI4
line 2072
;2071:
;2072:	if ( level.intermissiontime ) {
ADDRGP4 level+9144
INDIRI4
CNSTI4 0
EQI4 $760
line 2073
;2073:		MoveClientToIntermission( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 MoveClientToIntermission
CALLV
pop
line 2074
;2074:	} else {
ADDRGP4 $761
JUMPV
LABELV $760
line 2076
;2075:		// fire the targets of the spawn point
;2076:		G_UseTargets( spawnPoint, ent );
ADDRLP4 200
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_UseTargets
CALLV
pop
line 2080
;2077:
;2078:		// select the highest weapon number available, after any
;2079:		// spawn given items have fired
;2080:		client->ps.weapon = 1;
ADDRLP4 4
INDIRP4
CNSTI4 144
ADDP4
CNSTI4 1
ASGNI4
line 2081
;2081:		for ( i = WP_NUM_WEAPONS - 1 ; i > 0 ; i-- ) {
ADDRLP4 0
CNSTI4 11
ASGNI4
LABELV $763
line 2082
;2082:			if ( client->ps.stats[STAT_WEAPONS] & ( 1 << i ) ) {
ADDRLP4 4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $767
line 2083
;2083:				client->ps.weapon = i;
ADDRLP4 4
INDIRP4
CNSTI4 144
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 2084
;2084:				break;
ADDRGP4 $765
JUMPV
LABELV $767
line 2086
;2085:			}
;2086:		}
LABELV $764
line 2081
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
GTI4 $763
LABELV $765
line 2087
;2087:	}
LABELV $761
line 2090
;2088:
;2089:#if 1	// JUHOX: new default equipment
;2090:	client->ps.stats[STAT_WEAPONS] =
ADDRLP4 4
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 1022
ASGNI4
line 2097
;2091:		(1<<WP_GAUNTLET) | (1<<WP_MACHINEGUN) | (1<<WP_SHOTGUN) |
;2092:		(1<<WP_GRENADE_LAUNCHER) | (1<<WP_ROCKET_LAUNCHER) |
;2093:		(1<<WP_LIGHTNING) | (1<<WP_RAILGUN) | (1<<WP_PLASMAGUN) |
;2094:		(1<<WP_BFG);
;2095:
;2096:#if MONSTER_MODE
;2097:	if (g_gametype.integer < GT_STU && g_monsterLauncher.integer) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
GEI4 $769
ADDRGP4 g_monsterLauncher+12
INDIRI4
CNSTI4 0
EQI4 $769
line 2098
;2098:		client->ps.stats[STAT_WEAPONS] |= (1<<WP_MONSTER_LAUNCHER);
ADDRLP4 1612
ADDRLP4 4
INDIRP4
CNSTI4 192
ADDP4
ASGNP4
ADDRLP4 1612
INDIRP4
ADDRLP4 1612
INDIRP4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
line 2099
;2099:	}
LABELV $769
line 2103
;2100:#endif
;2101:
;2102:	if (
;2103:		g_weaponLimit.integer > 0 &&
ADDRGP4 g_weaponLimit+12
INDIRI4
CNSTI4 0
LEI4 $773
ADDRLP4 4
INDIRP4
CNSTI4 628
ADDP4
INDIRI4
ADDRGP4 g_weaponLimit+12
INDIRI4
LTI4 $773
line 2105
;2104:		client->pers.numChoosenWeapons >= g_weaponLimit.integer
;2105:	) {
line 2107
;2106:		// restrict to choosen weapons
;2107:		client->ps.stats[STAT_WEAPONS] = 0;
ADDRLP4 4
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 0
ASGNI4
line 2108
;2108:		for (i = 0; i < client->pers.numChoosenWeapons; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $780
JUMPV
LABELV $777
line 2109
;2109:			client->ps.stats[STAT_WEAPONS] |= 1 << client->pers.choosenWeapons[i];
ADDRLP4 1616
ADDRLP4 4
INDIRP4
CNSTI4 192
ADDP4
ASGNP4
ADDRLP4 1616
INDIRP4
ADDRLP4 1616
INDIRP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 632
ADDP4
ADDP4
INDIRI4
LSHI4
BORI4
ASGNI4
line 2110
;2110:		}
LABELV $778
line 2108
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $780
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 628
ADDP4
INDIRI4
LTI4 $777
line 2111
;2111:	}
LABELV $773
line 2116
;2112:
;2113:#if GRAPPLE_ROPE
;2114:	if (
;2115:#if ESCAPE_MODE
;2116:		g_gametype.integer != GT_EFH &&
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
EQI4 $781
ADDRGP4 g_grapple+12
INDIRI4
CNSTI4 0
LEI4 $781
ADDRGP4 g_grapple+12
INDIRI4
CNSTI4 5
GEI4 $781
line 2120
;2117:#endif
;2118:		g_grapple.integer > HM_disabled &&
;2119:		g_grapple.integer < HM_num_modes
;2120:	) {
line 2121
;2121:		client->ps.stats[STAT_WEAPONS] |= (1<<WP_GRAPPLING_HOOK);
ADDRLP4 1612
ADDRLP4 4
INDIRP4
CNSTI4 192
ADDP4
ASGNP4
ADDRLP4 1612
INDIRP4
ADDRLP4 1612
INDIRP4
INDIRI4
CNSTI4 1024
BORI4
ASGNI4
line 2122
;2122:	}
LABELV $781
line 2125
;2123:#endif
;2124:
;2125:	if (client->ps.persistant[PERS_SPAWN_COUNT] == 1) {
ADDRLP4 4
INDIRP4
CNSTI4 264
ADDP4
INDIRI4
CNSTI4 1
NEI4 $786
line 2126
;2126:		if (g_unlimitedAmmo.integer) {
ADDRGP4 g_unlimitedAmmo+12
INDIRI4
CNSTI4 0
EQI4 $788
line 2127
;2127:			client->ps.ammo[WP_GAUNTLET] = -1;
ADDRLP4 4
INDIRP4
CNSTI4 380
ADDP4
CNSTI4 -1
ASGNI4
line 2128
;2128:			client->ps.ammo[WP_MACHINEGUN] = -1;
ADDRLP4 4
INDIRP4
CNSTI4 384
ADDP4
CNSTI4 -1
ASGNI4
line 2129
;2129:			client->ps.ammo[WP_SHOTGUN] = -1;
ADDRLP4 4
INDIRP4
CNSTI4 388
ADDP4
CNSTI4 -1
ASGNI4
line 2130
;2130:			client->ps.ammo[WP_GRENADE_LAUNCHER] = -1;
ADDRLP4 4
INDIRP4
CNSTI4 392
ADDP4
CNSTI4 -1
ASGNI4
line 2131
;2131:			client->ps.ammo[WP_ROCKET_LAUNCHER] = -1;
ADDRLP4 4
INDIRP4
CNSTI4 396
ADDP4
CNSTI4 -1
ASGNI4
line 2132
;2132:			client->ps.ammo[WP_LIGHTNING] = -1;
ADDRLP4 4
INDIRP4
CNSTI4 400
ADDP4
CNSTI4 -1
ASGNI4
line 2133
;2133:			client->ps.ammo[WP_RAILGUN] = -1;
ADDRLP4 4
INDIRP4
CNSTI4 404
ADDP4
CNSTI4 -1
ASGNI4
line 2134
;2134:			client->ps.ammo[WP_PLASMAGUN] = -1;
ADDRLP4 4
INDIRP4
CNSTI4 408
ADDP4
CNSTI4 -1
ASGNI4
line 2135
;2135:			client->ps.ammo[WP_BFG] = -1;
ADDRLP4 4
INDIRP4
CNSTI4 412
ADDP4
CNSTI4 -1
ASGNI4
line 2136
;2136:			client->ps.ammo[WP_GRAPPLING_HOOK] = -1;
ADDRLP4 4
INDIRP4
CNSTI4 416
ADDP4
CNSTI4 -1
ASGNI4
line 2138
;2137:#if MONSTER_MODE
;2138:			client->ps.ammo[WP_MONSTER_LAUNCHER] = WP_MONSTER_LAUNCHER_MAX_AMMO;
ADDRLP4 4
INDIRP4
CNSTI4 420
ADDP4
CNSTI4 0
ASGNI4
line 2140
;2139:#endif
;2140:		}
ADDRGP4 $789
JUMPV
LABELV $788
line 2141
;2141:		else {
line 2142
;2142:			client->ps.ammo[WP_GAUNTLET] = WP_GAUNTLET_MAX_AMMO;
ADDRLP4 4
INDIRP4
CNSTI4 380
ADDP4
CNSTI4 -1
ASGNI4
line 2143
;2143:			client->ps.ammo[WP_MACHINEGUN] = WP_MACHINEGUN_MAX_AMMO;
ADDRLP4 4
INDIRP4
CNSTI4 384
ADDP4
CNSTI4 200
ASGNI4
line 2144
;2144:			client->ps.ammo[WP_SHOTGUN] = WP_SHOTGUN_MAX_AMMO;
ADDRLP4 4
INDIRP4
CNSTI4 388
ADDP4
CNSTI4 50
ASGNI4
line 2145
;2145:			client->ps.ammo[WP_GRENADE_LAUNCHER] = WP_GRENADE_LAUNCHER_MAX_AMMO;
ADDRLP4 4
INDIRP4
CNSTI4 392
ADDP4
CNSTI4 100
ASGNI4
line 2146
;2146:			client->ps.ammo[WP_ROCKET_LAUNCHER] = WP_ROCKET_LAUNCHER_MAX_AMMO;
ADDRLP4 4
INDIRP4
CNSTI4 396
ADDP4
CNSTI4 40
ASGNI4
line 2147
;2147:			client->ps.ammo[WP_LIGHTNING] = WP_LIGHTNING_MAX_AMMO;
ADDRLP4 4
INDIRP4
CNSTI4 400
ADDP4
CNSTI4 800
ASGNI4
line 2148
;2148:			client->ps.ammo[WP_RAILGUN] = WP_RAILGUN_MAX_AMMO;
ADDRLP4 4
INDIRP4
CNSTI4 404
ADDP4
CNSTI4 6
ASGNI4
line 2149
;2149:			client->ps.ammo[WP_PLASMAGUN] = WP_PLASMAGUN_MAX_AMMO;
ADDRLP4 4
INDIRP4
CNSTI4 408
ADDP4
CNSTI4 400
ASGNI4
line 2150
;2150:			client->ps.ammo[WP_BFG] = WP_BFG_MAX_AMMO;
ADDRLP4 4
INDIRP4
CNSTI4 412
ADDP4
CNSTI4 5
ASGNI4
line 2151
;2151:			client->ps.ammo[WP_GRAPPLING_HOOK] = WP_GRAPPLING_HOOK_MAX_AMMO;
ADDRLP4 4
INDIRP4
CNSTI4 416
ADDP4
CNSTI4 -1
ASGNI4
line 2153
;2152:#if MONSTER_MODE
;2153:			client->ps.ammo[WP_MONSTER_LAUNCHER] = WP_MONSTER_LAUNCHER_MAX_AMMO;
ADDRLP4 4
INDIRP4
CNSTI4 420
ADDP4
CNSTI4 0
ASGNI4
line 2155
;2154:#endif
;2155:		}
LABELV $789
line 2157
;2156:
;2157:		client->ps.stats[STAT_STRENGTH] = MAX_STRENGTH_VALUE;
ADDRLP4 4
INDIRP4
CNSTI4 212
ADDP4
CNSTI4 18000
ASGNI4
line 2158
;2158:	}
LABELV $786
line 2159
;2159:	if (client->pers.lastUsedWeapon <= WP_NONE || client->pers.lastUsedWeapon >= WP_NUM_WEAPONS) {
ADDRLP4 4
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 0
LEI4 $793
ADDRLP4 4
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 12
LTI4 $791
LABELV $793
line 2160
;2160:		client->ps.weapon = WP_MACHINEGUN;
ADDRLP4 4
INDIRP4
CNSTI4 144
ADDP4
CNSTI4 2
ASGNI4
line 2161
;2161:	}
ADDRGP4 $792
JUMPV
LABELV $791
line 2162
;2162:	else {
line 2163
;2163:		client->ps.weapon = client->pers.lastUsedWeapon;
ADDRLP4 4
INDIRP4
CNSTI4 144
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
ASGNI4
line 2164
;2164:	}
LABELV $792
line 2165
;2165:	client->ps.stats[STAT_TARGET] = -1;
ADDRLP4 4
INDIRP4
CNSTI4 208
ADDP4
CNSTI4 -1
ASGNI4
line 2167
;2166:
;2167:	client->ps.weaponTime = 250;
ADDRLP4 4
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 250
ASGNI4
line 2168
;2168:	client->ps.weaponstate = WEAPON_READY;
ADDRLP4 4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 2171
;2169:#endif
;2170:
;2171:	client->ps.generic1 = rand() & 255;	// JUHOX: randomize weapon shaking
ADDRLP4 1616
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 440
ADDP4
ADDRLP4 1616
INDIRI4
CNSTI4 255
BANDI4
ASGNI4
line 2175
;2172:
;2173:	// run a client frame to drop exactly to the floor,
;2174:	// initialize animations and other things
;2175:	client->ps.commandTime = level.time - 100;
ADDRLP4 4
INDIRP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
SUBI4
ASGNI4
line 2176
;2176:	ent->client->pers.cmd.serverTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 472
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 2177
;2177:	ClientThink( ent-g_entities );
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
ADDRGP4 ClientThink
CALLV
pop
line 2180
;2178:
;2179:#if 1	// JUHOX: make ClientThink() init viewmode next frame
;2180:	client->viewMode = -1;
ADDRLP4 4
INDIRP4
CNSTI4 5592
ADDP4
CNSTI4 -1
ASGNI4
line 2184
;2181:#endif
;2182:
;2183:#if 1	// JUHOX: spawn effect
;2184:	client->ps.stats[STAT_EFFECT] = PE_spawn;
ADDRLP4 4
INDIRP4
CNSTI4 220
ADDP4
CNSTI4 0
ASGNI4
line 2185
;2185:	client->ps.powerups[PW_EFFECT_TIME] = level.time + SPAWNHULL_TIME;
ADDRLP4 4
INDIRP4
CNSTI4 364
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 2186
;2186:	client->weaponUsageTime = level.time - 5000;
ADDRLP4 4
INDIRP4
CNSTI4 860
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 5000
SUBI4
ASGNI4
line 2187
;2187:	client->grappleUsageTime = level.time - 5000;
ADDRLP4 4
INDIRP4
CNSTI4 864
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 5000
SUBI4
ASGNI4
line 2188
;2188:	if (g_cloakingDevice.integer) {
ADDRGP4 g_cloakingDevice+12
INDIRI4
CNSTI4 0
EQI4 $799
line 2189
;2189:		client->ps.powerups[PW_INVIS] = level.time + 1000000000;
ADDRLP4 4
INDIRP4
CNSTI4 328
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000000000
ADDI4
ASGNI4
line 2190
;2190:	}
LABELV $799
line 2194
;2191:#endif
;2192:
;2193:#if 1	// JUHOX: spawn dead if the spawn point would telefrag someone
;2194:	if (deadSpawn) {
ADDRLP4 232
INDIRI4
CNSTI4 0
EQI4 $803
line 2195
;2195:		client->ps.pm_type = PM_SPECTATOR;
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 2
ASGNI4
line 2196
;2196:		client->ps.stats[STAT_HEALTH] = 0;
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 0
ASGNI4
line 2197
;2197:		ent->health = 0;
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 0
ASGNI4
line 2198
;2198:		client->ps.stats[STAT_RESPAWN_INFO] = 0;
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
CNSTI4 0
ASGNI4
line 2199
;2199:		client->ps.weapon = WP_NONE;
ADDRLP4 4
INDIRP4
CNSTI4 144
ADDP4
CNSTI4 0
ASGNI4
line 2200
;2200:		client->ps.stats[STAT_WEAPONS] = 0;
ADDRLP4 4
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 0
ASGNI4
line 2201
;2201:		client->respawnDelay = -1;
ADDRLP4 4
INDIRP4
CNSTI4 836
ADDP4
CNSTI4 -1
ASGNI4
line 2202
;2202:		ent->s.eFlags |= EF_NODRAW;
ADDRLP4 1620
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 1620
INDIRP4
ADDRLP4 1620
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 2203
;2203:		client->ps.eFlags |= EF_NODRAW;
ADDRLP4 1624
ADDRLP4 4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 1624
INDIRP4
ADDRLP4 1624
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 2204
;2204:		ent->takedamage = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
CNSTI4 0
ASGNI4
line 2205
;2205:		ent->r.contents = CONTENTS_CORPSE;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 67108864
ASGNI4
line 2206
;2206:	}
LABELV $803
line 2210
;2207:#endif
;2208:
;2209:	// positively link the client, even if the command times are weird
;2210:	if ( ent->client->sess.sessionTeam != TEAM_SPECTATOR ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 3
EQI4 $805
line 2211
;2211:		BG_PlayerStateToEntityState( &client->ps, &ent->s, qtrue );
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BG_PlayerStateToEntityState
CALLV
pop
line 2212
;2212:		VectorCopy( ent->client->ps.origin, ent->r.currentOrigin );
ADDRLP4 1620
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1620
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 1620
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 2213
;2213:		trap_LinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 2214
;2214:	}
LABELV $805
line 2217
;2215:
;2216:	// run the presend to set anything else
;2217:	ClientEndFrame( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 ClientEndFrame
CALLV
pop
line 2220
;2218:
;2219:	// clear entity state values
;2220:	BG_PlayerStateToEntityState( &client->ps, &ent->s, qtrue );
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BG_PlayerStateToEntityState
CALLV
pop
line 2221
;2221:}
LABELV $683
endproc ClientSpawn 1628 16
export ClientDisconnect
proc ClientDisconnect 20 8
line 2236
;2222:
;2223:
;2224:/*
;2225:===========
;2226:ClientDisconnect
;2227:
;2228:Called when a player drops from the server.
;2229:Will not be called between levels.
;2230:
;2231:This should NOT be called directly by any game logic,
;2232:call trap_DropClient(), which will call this and do
;2233:server system housekeeping.
;2234:============
;2235:*/
;2236:void ClientDisconnect( int clientNum ) {
line 2243
;2237:	gentity_t	*ent;
;2238:	gentity_t	*tent;
;2239:	int			i;
;2240:
;2241:	// cleanup if we are kicking a bot that
;2242:	// hasn't spawned yet
;2243:	G_RemoveQueuedBotBegin( clientNum );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 G_RemoveQueuedBotBegin
CALLV
pop
line 2245
;2244:
;2245:	ent = g_entities + clientNum;
ADDRLP4 4
ADDRFP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 2246
;2246:	if ( !ent->client ) {
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $808
line 2247
;2247:		return;
ADDRGP4 $807
JUMPV
LABELV $808
line 2251
;2248:	}
;2249:
;2250:	// stop any following clients
;2251:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $813
JUMPV
LABELV $810
line 2252
;2252:		if ( level.clients[i].sess.sessionTeam == TEAM_SPECTATOR
ADDRLP4 16
ADDRGP4 level
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 5604
MULI4
ADDRLP4 16
INDIRP4
ADDP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 3
NEI4 $815
ADDRLP4 0
INDIRI4
CNSTI4 5604
MULI4
ADDRLP4 16
INDIRP4
ADDP4
CNSTI4 704
ADDP4
INDIRI4
CNSTI4 2
NEI4 $815
ADDRLP4 0
INDIRI4
CNSTI4 5604
MULI4
ADDRLP4 16
INDIRP4
ADDP4
CNSTI4 708
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $815
line 2254
;2253:			&& level.clients[i].sess.spectatorState == SPECTATOR_FOLLOW
;2254:			&& level.clients[i].sess.spectatorClient == clientNum ) {
line 2255
;2255:			StopFollowing( &g_entities[i] );
ADDRLP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRGP4 StopFollowing
CALLV
pop
line 2256
;2256:		}
LABELV $815
line 2257
;2257:	}
LABELV $811
line 2251
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $813
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $810
line 2260
;2258:
;2259:	// send effect if they were completely connected
;2260:	if ( ent->client->pers.connected == CON_CONNECTED 
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $817
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 3
EQI4 $817
line 2261
;2261:		&& ent->client->sess.sessionTeam != TEAM_SPECTATOR ) {
line 2262
;2262:		tent = G_TempEntity( ent->client->ps.origin, EV_PLAYER_TELEPORT_OUT );
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
CNSTI4 43
ARGI4
ADDRLP4 16
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 16
INDIRP4
ASGNP4
line 2263
;2263:		tent->s.clientNum = ent->s.clientNum;
ADDRLP4 8
INDIRP4
CNSTI4 168
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 2267
;2264:
;2265:		// They don't get to take powerups with them!
;2266:		// Especially important for stuff like CTF flags
;2267:		TossClientItems( ent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 TossClientItems
CALLV
pop
line 2275
;2268:#ifdef MISSIONPACK
;2269:		TossClientPersistantPowerups( ent );
;2270:		if( g_gametype.integer == GT_HARVESTER ) {
;2271:			TossClientCubes( ent );
;2272:		}
;2273:#endif
;2274:
;2275:	}
LABELV $817
line 2277
;2276:
;2277:	G_LogPrintf( "ClientDisconnect: %i\n", clientNum );
ADDRGP4 $819
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 2280
;2278:
;2279:	// if we are playing in tourney mode and losing, give a win to the other player
;2280:	if ( (g_gametype.integer == GT_TOURNAMENT )
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
NEI4 $820
ADDRGP4 level+9144
INDIRI4
CNSTI4 0
NEI4 $820
ADDRGP4 level+16
INDIRI4
CNSTI4 0
NEI4 $820
ADDRGP4 level+100+4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $820
line 2282
;2281:		&& !level.intermissiontime
;2282:		&& !level.warmupTime && level.sortedClients[1] == clientNum ) {
line 2283
;2283:		level.clients[ level.sortedClients[0] ].sess.wins++;
ADDRLP4 16
ADDRGP4 level+100
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 712
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2284
;2284:		ClientUserinfoChanged( level.sortedClients[0] );
ADDRGP4 level+100
INDIRI4
ARGI4
ADDRGP4 ClientUserinfoChanged
CALLV
pop
line 2285
;2285:	}
LABELV $820
line 2287
;2286:
;2287:	trap_UnlinkEntity (ent);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 2288
;2288:	ent->s.modelindex = 0;
ADDRLP4 4
INDIRP4
CNSTI4 160
ADDP4
CNSTI4 0
ASGNI4
line 2289
;2289:	ent->inuse = qfalse;
ADDRLP4 4
INDIRP4
CNSTI4 524
ADDP4
CNSTI4 0
ASGNI4
line 2290
;2290:	ent->classname = "disconnected";
ADDRLP4 4
INDIRP4
CNSTI4 528
ADDP4
ADDRGP4 $829
ASGNP4
line 2291
;2291:	ent->client->pers.connected = CON_DISCONNECTED;
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 468
ADDP4
CNSTI4 0
ASGNI4
line 2292
;2292:	ent->client->ps.persistant[PERS_TEAM] = TEAM_FREE;
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 260
ADDP4
CNSTI4 0
ASGNI4
line 2293
;2293:	ent->client->sess.sessionTeam = TEAM_FREE;
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
CNSTI4 0
ASGNI4
line 2295
;2294:
;2295:	trap_SetConfigstring( CS_PLAYERS + clientNum, "");
ADDRFP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRGP4 $830
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 2297
;2296:
;2297:	CalculateRanks();
ADDRGP4 CalculateRanks
CALLV
pop
line 2299
;2298:
;2299:	if ( ent->r.svFlags & SVF_BOT ) {
ADDRLP4 4
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $831
line 2300
;2300:		BotAIShutdownClient( clientNum, qfalse );
ADDRFP4 0
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 BotAIShutdownClient
CALLI4
pop
line 2301
;2301:	}
LABELV $831
line 2304
;2302:
;2303:#if MEETING	// JUHOX: end match if the last human player left the game
;2304:	if (g_meeting.integer && !level.meeting) {
ADDRGP4 g_meeting+12
INDIRI4
CNSTI4 0
EQI4 $833
ADDRGP4 level+24092
INDIRI4
CNSTI4 0
NEI4 $833
line 2307
;2305:		int numHumanPlayers;
;2306:
;2307:		numHumanPlayers = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 2308
;2308:		for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $840
JUMPV
LABELV $837
line 2309
;2309:			if (level.clients[i].pers.connected != CON_CONNECTED) continue;
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
EQI4 $842
ADDRGP4 $838
JUMPV
LABELV $842
line 2310
;2310:			if (g_entities[i].r.svFlags & SVF_BOT) continue;
ADDRLP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+208+216
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $844
ADDRGP4 $838
JUMPV
LABELV $844
line 2312
;2311:
;2312:			numHumanPlayers++;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2313
;2313:		}
LABELV $838
line 2308
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $840
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $837
line 2315
;2314:
;2315:		if (numHumanPlayers <= 0) {
ADDRLP4 16
INDIRI4
CNSTI4 0
GTI4 $848
line 2316
;2316:			level.endTime = level.time;
ADDRGP4 level+23028
ADDRGP4 level+32
INDIRI4
ASGNI4
line 2317
;2317:			LogExit("no human players");
ADDRGP4 $852
ARGP4
ADDRGP4 LogExit
CALLV
pop
line 2318
;2318:		}
LABELV $848
line 2319
;2319:	}
LABELV $833
line 2321
;2320:#endif
;2321:}
LABELV $807
endproc ClientDisconnect 20 8
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
import ClientCommand
import ClientSetPlayerClass
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
import DeathmatchScoreboardMessage
import G_SetStats
import MoveClientToIntermission
import FireWeapon
import G_FilterPacket
import G_ProcessIPBans
import ConsoleCommand
import CalculateRanks
import AddScore
import player_die
import InitClientResp
import InitClientPersistant
import BeginIntermission
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
import G_Say
import Cmd_FollowCycle_f
import SetTeam
import BroadcastTeamChange
import StopFollowing
import Cmd_Score_f
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
LABELV $852
byte 1 110
byte 1 111
byte 1 32
byte 1 104
byte 1 117
byte 1 109
byte 1 97
byte 1 110
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $830
byte 1 0
align 1
LABELV $829
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
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $819
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 68
byte 1 105
byte 1 115
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $753
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $622
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 66
byte 1 101
byte 1 103
byte 1 105
byte 1 110
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $610
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $592
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $589
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 67
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $588
byte 1 66
byte 1 111
byte 1 116
byte 1 67
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $573
byte 1 73
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 112
byte 1 97
byte 1 115
byte 1 115
byte 1 119
byte 1 111
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $571
byte 1 110
byte 1 111
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $566
byte 1 112
byte 1 97
byte 1 115
byte 1 115
byte 1 119
byte 1 111
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $563
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 98
byte 1 97
byte 1 110
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
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
byte 1 0
align 1
LABELV $560
byte 1 71
byte 1 97
byte 1 109
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
byte 1 44
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 114
byte 1 121
byte 1 32
byte 1 108
byte 1 97
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $554
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 85
byte 1 115
byte 1 101
byte 1 114
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 67
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 100
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $553
byte 1 110
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 116
byte 1 92
byte 1 37
byte 1 105
byte 1 92
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 104
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 103
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 92
byte 1 37
byte 1 115
byte 1 92
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
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 99
byte 1 49
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 99
byte 1 50
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 104
byte 1 99
byte 1 92
byte 1 37
byte 1 105
byte 1 92
byte 1 119
byte 1 92
byte 1 37
byte 1 105
byte 1 92
byte 1 108
byte 1 92
byte 1 37
byte 1 105
byte 1 92
byte 1 116
byte 1 116
byte 1 92
byte 1 37
byte 1 100
byte 1 92
byte 1 116
byte 1 108
byte 1 92
byte 1 37
byte 1 100
byte 1 92
byte 1 103
byte 1 99
byte 1 92
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $552
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $551
byte 1 110
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 116
byte 1 92
byte 1 37
byte 1 105
byte 1 92
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 104
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 99
byte 1 49
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 99
byte 1 50
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 104
byte 1 99
byte 1 92
byte 1 37
byte 1 105
byte 1 92
byte 1 119
byte 1 92
byte 1 37
byte 1 105
byte 1 92
byte 1 108
byte 1 92
byte 1 37
byte 1 105
byte 1 92
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 116
byte 1 116
byte 1 92
byte 1 37
byte 1 100
byte 1 92
byte 1 116
byte 1 108
byte 1 92
byte 1 37
byte 1 100
byte 1 92
byte 1 103
byte 1 99
byte 1 92
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $548
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
LABELV $547
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
LABELV $546
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 50
byte 1 0
align 1
LABELV $545
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 49
byte 1 0
align 1
LABELV $541
byte 1 99
byte 1 114
byte 1 111
byte 1 117
byte 1 99
byte 1 104
byte 1 67
byte 1 117
byte 1 116
byte 1 115
byte 1 82
byte 1 111
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $537
byte 1 99
byte 1 103
byte 1 95
byte 1 103
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 67
byte 1 108
byte 1 111
byte 1 97
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $534
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
LABELV $530
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $528
byte 1 98
byte 1 0
align 1
LABELV $527
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $523
byte 1 114
byte 1 0
align 1
LABELV $522
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $519
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $513
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
LABELV $512
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $511
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
LABELV $510
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
LABELV $500
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
LABELV $499
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $494
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
LABELV $489
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $486
byte 1 99
byte 1 103
byte 1 95
byte 1 112
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $485
byte 1 108
byte 1 111
byte 1 99
byte 1 97
byte 1 108
byte 1 104
byte 1 111
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $482
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $481
byte 1 92
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 92
byte 1 98
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 0
align 1
LABELV $477
byte 1 85
byte 1 110
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 100
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $341
byte 1 98
byte 1 111
byte 1 100
byte 1 121
byte 1 113
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $232
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $231
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $230
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $229
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $99
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 95
byte 1 100
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
LABELV $97
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 95
byte 1 105
byte 1 110
byte 1 105
byte 1 116
byte 1 105
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $92
byte 1 110
byte 1 111
byte 1 104
byte 1 117
byte 1 109
byte 1 97
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $89
byte 1 48
byte 1 0
align 1
LABELV $88
byte 1 110
byte 1 111
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 0
