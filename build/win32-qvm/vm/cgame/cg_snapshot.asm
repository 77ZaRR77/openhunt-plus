code
proc CG_ResetEntity 8 4
file "..\..\..\..\code\cgame\cg_snapshot.c"
line 15
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_snapshot.c -- things that happen on snapshot transition,
;4:// not necessarily every single rendered frame
;5:
;6:#include "cg_local.h"
;7:
;8:
;9:
;10:/*
;11:==================
;12:CG_ResetEntity
;13:==================
;14:*/
;15:static void CG_ResetEntity( centity_t *cent ) {
line 18
;16:	// if the previous snapshot this entity was updated in is at least
;17:	// an event window back in time then we can reset the previous event
;18:	if ( cent->snapShotTime < cg.time - EVENT_VALID_MSEC ) {
ADDRFP4 0
INDIRP4
CNSTI4 448
ADDP4
INDIRI4
ADDRGP4 cg+107656
INDIRI4
CNSTI4 300
SUBI4
GEI4 $125
line 19
;19:	cent->previousEvent = 0;
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
CNSTI4 0
ASGNI4
line 20
;20:	}
LABELV $125
line 22
;21:
;22:	cent->trailTime = cg.snap->serverTime;
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 24
;23:
;24:	VectorCopy (cent->currentState.origin, cent->lerpOrigin);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 728
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 25
;25:	VectorCopy (cent->currentState.angles, cent->lerpAngles);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 740
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 26
;26:	if ( cent->currentState.eType == ET_PLAYER ) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 1
NEI4 $129
line 27
;27:		CG_ResetPlayerEntity( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_ResetPlayerEntity
CALLV
pop
line 28
;28:	}
LABELV $129
line 29
;29:}
LABELV $124
endproc CG_ResetEntity 8 4
proc CG_TransitionEntity 4 4
line 38
;30:
;31:/*
;32:===============
;33:CG_TransitionEntity
;34:
;35:cent->nextState is moved to cent->currentState and events are fired
;36:===============
;37:*/
;38:static void CG_TransitionEntity( centity_t *cent ) {
line 39
;39:	cent->currentState = cent->nextState;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRB
ASGNB 208
line 40
;40:	cent->currentValid = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 420
ADDP4
CNSTI4 1
ASGNI4
line 43
;41:
;42:	// reset if the entity wasn't in the last frame or was teleported
;43:	if ( !cent->interpolate ) {
ADDRFP4 0
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
CNSTI4 0
NEI4 $132
line 44
;44:		CG_ResetEntity( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_ResetEntity
CALLV
pop
line 45
;45:	}
LABELV $132
line 48
;46:
;47:	// clear the next state.  if will be set by the next CG_SetNextSnap
;48:	cent->interpolate = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 416
ADDP4
CNSTI4 0
ASGNI4
line 51
;49:
;50:	// check for events
;51:	CG_CheckEvents( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_CheckEvents
CALLV
pop
line 52
;52:}
LABELV $131
endproc CG_TransitionEntity 4 4
export CG_SetInitialSnapshot
proc CG_SetInitialSnapshot 16 12
line 66
;53:
;54:
;55:/*
;56:==================
;57:CG_SetInitialSnapshot
;58:
;59:This will only happen on the very first snapshot, or
;60:on tourney restarts.  All other times will use 
;61:CG_TransitionSnapshot instead.
;62:
;63:FIXME: Also called by map_restart?
;64:==================
;65:*/
;66:void CG_SetInitialSnapshot( snapshot_t *snap ) {
line 71
;67:	int				i;
;68:	centity_t		*cent;
;69:	entityState_t	*state;
;70:
;71:	cg.snap = snap;
ADDRGP4 cg+36
ADDRFP4 0
INDIRP4
ASGNP4
line 73
;72:
;73:	BG_PlayerStateToEntityState( &snap->ps, &cg_entities[ snap->ps.clientNum ].currentState, qfalse );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 44
ADDP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 880
MULI4
ADDRGP4 cg_entities
ADDP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BG_PlayerStateToEntityState
CALLV
pop
line 76
;74:
;75:	// sort out solid entities
;76:	CG_BuildSolidList();
ADDRGP4 CG_BuildSolidList
CALLV
pop
line 78
;77:
;78:	CG_ExecuteNewServerCommands( snap->serverCommandSequence );
ADDRFP4 0
INDIRP4
CNSTI4 53768
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_ExecuteNewServerCommands
CALLV
pop
line 82
;79:
;80:	// set our local weapon selection pointer to
;81:	// what the server has indicated the current weapon is
;82:	CG_Respawn();
ADDRGP4 CG_Respawn
CALLV
pop
line 84
;83:
;84:	for ( i = 0 ; i < cg.snap->numEntities ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $139
JUMPV
LABELV $136
line 85
;85:		state = &cg.snap->entities[ i ];
ADDRLP4 8
ADDRLP4 4
INDIRI4
CNSTI4 208
MULI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 516
ADDP4
ADDP4
ASGNP4
line 86
;86:		cent = &cg_entities[ state->number ];
ADDRLP4 0
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 880
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 88
;87:
;88:		memcpy(&cent->currentState, state, sizeof(entityState_t));
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 208
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 90
;89:		//cent->currentState = *state;
;90:		cent->interpolate = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 416
ADDP4
CNSTI4 0
ASGNI4
line 91
;91:		cent->currentValid = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 420
ADDP4
CNSTI4 1
ASGNI4
line 93
;92:
;93:		CG_ResetEntity( cent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_ResetEntity
CALLV
pop
line 96
;94:
;95:		// check for events
;96:		CG_CheckEvents( cent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_CheckEvents
CALLV
pop
line 97
;97:	}
LABELV $137
line 84
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $139
ADDRLP4 4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
LTI4 $136
line 98
;98:}
LABELV $134
endproc CG_SetInitialSnapshot 16 12
proc GetPlayerRefOrigin 4 0
line 107
;99:
;100:
;101:/*
;102:===================
;103:JUHOX: GetPlayerRefOrigin
;104:===================
;105:*/
;106:#if ESCAPE_MODE
;107:static void GetPlayerRefOrigin(const playerState_t* ps, int* x, int* y, int* z) {
line 110
;108:	int n;
;109:
;110:	n = ps->stats[STAT_REFERENCE_X];
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
ASGNI4
line 111
;111:	if (n & 0x8000) {
ADDRLP4 0
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $143
line 112
;112:		n |= 0xffff0000;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIU4 4
CNSTU4 4294901760
BORU4
CVUI4 4
ASGNI4
line 113
;113:	}
LABELV $143
line 114
;114:	*x = n << REFERENCE_SHIFT;
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRI4
CNSTI4 7
LSHI4
ASGNI4
line 116
;115:
;116:	n = ps->stats[STAT_REFERENCE_Y];
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
ASGNI4
line 117
;117:	if (n & 0x8000) {
ADDRLP4 0
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $145
line 118
;118:		n |= 0xffff0000;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIU4 4
CNSTU4 4294901760
BORU4
CVUI4 4
ASGNI4
line 119
;119:	}
LABELV $145
line 120
;120:	*y = n << REFERENCE_SHIFT;
ADDRFP4 8
INDIRP4
ADDRLP4 0
INDIRI4
CNSTI4 7
LSHI4
ASGNI4
line 122
;121:
;122:	n = ps->stats[STAT_REFERENCE_Z];
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
ASGNI4
line 123
;123:	if (n & 0x8000) {
ADDRLP4 0
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $147
line 124
;124:		n |= 0xffff0000;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIU4 4
CNSTU4 4294901760
BORU4
CVUI4 4
ASGNI4
line 125
;125:	}
LABELV $147
line 126
;126:	*z = n << REFERENCE_SHIFT;
ADDRFP4 12
INDIRP4
ADDRLP4 0
INDIRI4
CNSTI4 7
LSHI4
ASGNI4
line 127
;127:}
LABELV $142
endproc GetPlayerRefOrigin 4 0
proc CG_TransitionSnapshot 48 16
line 137
;128:#endif
;129:
;130:/*
;131:===================
;132:CG_TransitionSnapshot
;133:
;134:The transition point from snap to nextSnap has passed
;135:===================
;136:*/
;137:static void CG_TransitionSnapshot( void ) {
line 142
;138:	centity_t			*cent;
;139:	snapshot_t			*oldFrame;
;140:	int					i;
;141:
;142:	if ( !cg.snap ) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $150
line 143
;143:		CG_Error( "CG_TransitionSnapshot: NULL cg.snap" );
ADDRGP4 $153
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 144
;144:	}
LABELV $150
line 145
;145:	if ( !cg.nextSnap ) {
ADDRGP4 cg+40
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $154
line 146
;146:		CG_Error( "CG_TransitionSnapshot: NULL cg.nextSnap" );
ADDRGP4 $157
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 147
;147:	}
LABELV $154
line 150
;148:
;149:	// execute any server string commands before transitioning entities
;150:	CG_ExecuteNewServerCommands( cg.nextSnap->serverCommandSequence );
ADDRGP4 cg+40
INDIRP4
CNSTI4 53768
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_ExecuteNewServerCommands
CALLV
pop
line 153
;151:
;152:	// if we had a map_restart, set everthing with initial
;153:	if ( !cg.snap ) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $159
line 154
;154:	}
LABELV $159
line 157
;155:
;156:	// clear the currentValid flag for all entities in the existing snapshot
;157:	for ( i = 0 ; i < cg.snap->numEntities ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $165
JUMPV
LABELV $162
line 158
;158:		cent = &cg_entities[ cg.snap->entities[ i ].number ];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 208
MULI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 516
ADDP4
ADDP4
INDIRI4
CNSTI4 880
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 159
;159:		cent->currentValid = qfalse;
ADDRLP4 4
INDIRP4
CNSTI4 420
ADDP4
CNSTI4 0
ASGNI4
line 160
;160:	}
LABELV $163
line 157
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $165
ADDRLP4 0
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
LTI4 $162
line 163
;161:
;162:	// move nextSnap to snap and do the transitions
;163:	oldFrame = cg.snap;
ADDRLP4 8
ADDRGP4 cg+36
INDIRP4
ASGNP4
line 164
;164:	cg.snap = cg.nextSnap;
ADDRGP4 cg+36
ADDRGP4 cg+40
INDIRP4
ASGNP4
line 166
;165:
;166:	BG_PlayerStateToEntityState( &cg.snap->ps, &cg_entities[ cg.snap->ps.clientNum ].currentState, qfalse );
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 880
MULI4
ADDRGP4 cg_entities
ADDP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BG_PlayerStateToEntityState
CALLV
pop
line 167
;167:	cg_entities[ cg.snap->ps.clientNum ].interpolate = qfalse;
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 880
MULI4
ADDRGP4 cg_entities+416
ADDP4
CNSTI4 0
ASGNI4
line 171
;168:
;169:	// JUHOX: set reference origin
;170:#if ESCAPE_MODE
;171:	if (cgs.gametype == GT_EFH) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 9
NEI4 $175
line 179
;172:		int newReferenceX;
;173:		int newReferenceY;
;174:		int newReferenceZ;
;175:		int intDeltaX;
;176:		int intDeltaY;
;177:		int intDeltaZ;
;178:
;179:		GetPlayerRefOrigin(&cg.snap->ps, &newReferenceX, &newReferenceY, &newReferenceZ);
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 GetPlayerRefOrigin
CALLV
pop
line 180
;180:		intDeltaX = cg.currentReferenceX - newReferenceX;
ADDRLP4 24
ADDRGP4 cg+107588
INDIRI4
ADDRLP4 12
INDIRI4
SUBI4
ASGNI4
line 181
;181:		intDeltaY = cg.currentReferenceY - newReferenceY;
ADDRLP4 28
ADDRGP4 cg+107592
INDIRI4
ADDRLP4 16
INDIRI4
SUBI4
ASGNI4
line 182
;182:		intDeltaZ = cg.currentReferenceZ - newReferenceZ;
ADDRLP4 32
ADDRGP4 cg+107596
INDIRI4
ADDRLP4 20
INDIRI4
SUBI4
ASGNI4
line 183
;183:		cg.currentReferenceX = newReferenceX;
ADDRGP4 cg+107588
ADDRLP4 12
INDIRI4
ASGNI4
line 184
;184:		cg.currentReferenceY = newReferenceY;
ADDRGP4 cg+107592
ADDRLP4 16
INDIRI4
ASGNI4
line 185
;185:		cg.currentReferenceZ = newReferenceZ;
ADDRGP4 cg+107596
ADDRLP4 20
INDIRI4
ASGNI4
line 186
;186:		currentReference[0] = newReferenceX;
ADDRGP4 currentReference
ADDRLP4 12
INDIRI4
CVIF4 4
ASGNF4
line 187
;187:		currentReference[1] = newReferenceY;
ADDRGP4 currentReference+4
ADDRLP4 16
INDIRI4
CVIF4 4
ASGNF4
line 188
;188:		currentReference[2] = newReferenceZ;
ADDRGP4 currentReference+8
ADDRLP4 20
INDIRI4
CVIF4 4
ASGNF4
line 190
;189:
;190:		if (intDeltaX || intDeltaY || intDeltaZ) {
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $190
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $190
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $187
LABELV $190
line 193
;191:			vec3_t delta;
;192:
;193:			delta[0] = intDeltaX;
ADDRLP4 36
ADDRLP4 24
INDIRI4
CVIF4 4
ASGNF4
line 194
;194:			delta[1] = intDeltaY;
ADDRLP4 36+4
ADDRLP4 28
INDIRI4
CVIF4 4
ASGNF4
line 195
;195:			delta[2] = intDeltaZ;
ADDRLP4 36+8
ADDRLP4 32
INDIRI4
CVIF4 4
ASGNF4
line 197
;196:
;197:			CG_AdjustLocalEntities(delta);
ADDRLP4 36
ARGP4
ADDRGP4 CG_AdjustLocalEntities
CALLV
pop
line 198
;198:			CG_AdjustParticles(delta);
ADDRLP4 36
ARGP4
ADDRGP4 CG_AdjustParticles
CALLV
pop
line 199
;199:			CG_AdjustEarthquakes(delta);
ADDRLP4 36
ARGP4
ADDRGP4 CG_AdjustEarthquakes
CALLV
pop
line 200
;200:			VectorAdd(cg.predictedPlayerState.origin, delta, cg.predictedPlayerState.origin);
ADDRGP4 cg+107688+20
ADDRGP4 cg+107688+20
INDIRF4
ADDRLP4 36
INDIRF4
ADDF4
ASGNF4
ADDRGP4 cg+107688+20+4
ADDRGP4 cg+107688+20+4
INDIRF4
ADDRLP4 36+4
INDIRF4
ADDF4
ASGNF4
ADDRGP4 cg+107688+20+8
ADDRGP4 cg+107688+20+8
INDIRF4
ADDRLP4 36+8
INDIRF4
ADDF4
ASGNF4
line 201
;201:		}
LABELV $187
line 202
;202:	}
LABELV $175
line 205
;203:#endif
;204:
;205:	for ( i = 0 ; i < cg.snap->numEntities ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $214
JUMPV
LABELV $211
line 206
;206:		cent = &cg_entities[ cg.snap->entities[ i ].number ];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 208
MULI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 516
ADDP4
ADDP4
INDIRI4
CNSTI4 880
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 207
;207:		CG_TransitionEntity( cent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 CG_TransitionEntity
CALLV
pop
line 210
;208:
;209:		// remember time of snapshot this entity was last updated in
;210:		cent->snapShotTime = cg.snap->serverTime;
ADDRLP4 4
INDIRP4
CNSTI4 448
ADDP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 211
;211:	}
LABELV $212
line 205
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $214
ADDRLP4 0
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
LTI4 $211
line 213
;212:
;213:	cg.nextSnap = NULL;
ADDRGP4 cg+40
CNSTP4 0
ASGNP4
line 216
;214:
;215:	// check for playerstate transition events
;216:	if ( oldFrame ) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $219
line 219
;217:		playerState_t	*ops, *ps;
;218:
;219:		ops = &oldFrame->ps;
ADDRLP4 12
ADDRLP4 8
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
line 220
;220:		ps = &cg.snap->ps;
ADDRLP4 16
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
line 222
;221:		// teleporting checks are irrespective of prediction
;222:		if ( ( ps->eFlags ^ ops->eFlags ) & EF_TELEPORT_BIT ) {
ADDRLP4 16
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
BXORI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $222
line 223
;223:			cg.thisFrameTeleport = qtrue;	// will be cleared by prediction code
ADDRGP4 cg+107644
CNSTI4 1
ASGNI4
line 224
;224:		}
LABELV $222
line 228
;225:
;226:		// if we are not doing client side movement prediction for any
;227:		// reason, then the client events and view changes will be issued now
;228:		if ( cg.demoPlayback || (cg.snap->ps.pm_flags & PMF_FOLLOW)
ADDRGP4 cg+8
INDIRI4
CNSTI4 0
NEI4 $233
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
NEI4 $233
ADDRGP4 cg_nopredict+12
INDIRI4
CNSTI4 0
NEI4 $233
ADDRGP4 cg_synchronousClients+12
INDIRI4
CNSTI4 0
EQI4 $225
LABELV $233
line 229
;229:			|| cg_nopredict.integer || cg_synchronousClients.integer ) {
line 230
;230:			CG_TransitionPlayerState( ps, ops );
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 CG_TransitionPlayerState
CALLV
pop
line 231
;231:		}
LABELV $225
line 232
;232:	}
LABELV $219
line 234
;233:
;234:}
LABELV $149
endproc CG_TransitionSnapshot 48 16
proc CG_StopMover 12 0
line 242
;235:
;236:
;237:/*
;238:===================
;239:JUHOX: CG_StopMover
;240:===================
;241:*/
;242:static void CG_StopMover(centity_t* cent) {
line 243
;243:	cent->currentState.pos.trType = TR_STATIONARY;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 244
;244:	VectorCopy(cent->lerpOrigin, cent->currentState.pos.trBase);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 728
ADDP4
INDIRB
ASGNB 12
line 245
;245:	VectorClear(cent->currentState.pos.trDelta);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
CNSTF4 0
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
line 246
;246:}
LABELV $234
endproc CG_StopMover 12 0
proc CG_SetNextSnap 20 16
line 255
;247:
;248:/*
;249:===================
;250:CG_SetNextSnap
;251:
;252:A new snapshot has just been read in from the client system.
;253:===================
;254:*/
;255:static void CG_SetNextSnap( snapshot_t *snap ) {
line 260
;256:	int					num;
;257:	entityState_t		*es;
;258:	centity_t			*cent;
;259:
;260:	cg.nextSnap = snap;
ADDRGP4 cg+40
ADDRFP4 0
INDIRP4
ASGNP4
line 262
;261:
;262:	BG_PlayerStateToEntityState( &snap->ps, &cg_entities[ snap->ps.clientNum ].nextState, qfalse );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 44
ADDP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 880
MULI4
ADDRGP4 cg_entities+208
ADDP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BG_PlayerStateToEntityState
CALLV
pop
line 263
;263:	cg_entities[ cg.snap->ps.clientNum ].interpolate = qtrue;
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 880
MULI4
ADDRGP4 cg_entities+416
ADDP4
CNSTI4 1
ASGNI4
line 267
;264:
;265:	// JUHOX: set reference origin (delta) for new snapshot
;266:#if ESCAPE_MODE
;267:	if (cgs.gametype == GT_EFH) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 9
NEI4 $240
line 268
;268:		GetPlayerRefOrigin(&snap->ps, &cg.nextReferenceX, &cg.nextReferenceY, &cg.nextReferenceZ);
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
ARGP4
ADDRGP4 cg+107600
ARGP4
ADDRGP4 cg+107604
ARGP4
ADDRGP4 cg+107608
ARGP4
ADDRGP4 GetPlayerRefOrigin
CALLV
pop
line 269
;269:		cg.referenceDelta[0] = cg.nextReferenceX - cg.currentReferenceX;
ADDRGP4 cg+107612
ADDRGP4 cg+107600
INDIRI4
ADDRGP4 cg+107588
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 270
;270:		cg.referenceDelta[1] = cg.nextReferenceY - cg.currentReferenceY;
ADDRGP4 cg+107612+4
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+107592
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 271
;271:		cg.referenceDelta[2] = cg.nextReferenceZ - cg.currentReferenceZ;
ADDRGP4 cg+107612+8
ADDRGP4 cg+107608
INDIRI4
ADDRGP4 cg+107596
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 272
;272:	}
LABELV $240
line 276
;273:#endif
;274:
;275:	// check for extrapolation errors
;276:	for ( num = 0 ; num < snap->numEntities ; num++ ) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $260
JUMPV
LABELV $257
line 277
;277:		es = &snap->entities[num];
ADDRLP4 4
ADDRLP4 8
INDIRI4
CNSTI4 208
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
ADDP4
ASGNP4
line 278
;278:		cent = &cg_entities[ es->number ];
ADDRLP4 0
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 880
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 280
;279:
;280:		memcpy(&cent->nextState, es, sizeof(entityState_t));
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 208
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 285
;281:		//cent->nextState = *es;
;282:
;283:		// if this frame is a teleport, or the entity wasn't in the
;284:		// previous frame, don't interpolate
;285:		if ( !cent->currentValid || ( ( cent->currentState.eFlags ^ es->eFlags ) & EF_TELEPORT_BIT )  ) {
ADDRLP4 0
INDIRP4
CNSTI4 420
ADDP4
INDIRI4
CNSTI4 0
EQI4 $263
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
BXORI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $261
LABELV $263
line 286
;286:			cent->interpolate = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 416
ADDP4
CNSTI4 0
ASGNI4
line 287
;287:		} else {
ADDRGP4 $262
JUMPV
LABELV $261
line 288
;288:			cent->interpolate = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 416
ADDP4
CNSTI4 1
ASGNI4
line 289
;289:		}
LABELV $262
line 290
;290:	}
LABELV $258
line 276
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $260
ADDRLP4 8
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
LTI4 $257
line 294
;291:
;292:	// if the next frame is a teleport for the playerstate, we
;293:	// can't interpolate during demos
;294:	if ( cg.snap && ( ( snap->ps.eFlags ^ cg.snap->ps.eFlags ) & EF_TELEPORT_BIT ) ) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $264
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
BXORI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $264
line 295
;295:		cg.nextFrameTeleport = qtrue;
ADDRGP4 cg+107648
CNSTI4 1
ASGNI4
line 296
;296:	} else {
ADDRGP4 $265
JUMPV
LABELV $264
line 297
;297:		cg.nextFrameTeleport = qfalse;
ADDRGP4 cg+107648
CNSTI4 0
ASGNI4
line 298
;298:	}
LABELV $265
line 301
;299:
;300:	// if changing follow mode, don't interpolate
;301:	if ( cg.nextSnap->ps.clientNum != cg.snap->ps.clientNum ) {
ADDRGP4 cg+40
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
EQI4 $270
line 302
;302:		cg.nextFrameTeleport = qtrue;
ADDRGP4 cg+107648
CNSTI4 1
ASGNI4
line 303
;303:	}
LABELV $270
line 306
;304:
;305:	// if changing server restarts, don't interpolate
;306:	if ( ( cg.nextSnap->snapFlags ^ cg.snap->snapFlags ) & SNAPFLAG_SERVERCOUNT ) {
ADDRGP4 cg+40
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
INDIRI4
BXORI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $275
line 307
;307:		cg.nextFrameTeleport = qtrue;
ADDRGP4 cg+107648
CNSTI4 1
ASGNI4
line 308
;308:	}
LABELV $275
line 311
;309:
;310:	// sort out solid entities
;311:	CG_BuildSolidList();
ADDRGP4 CG_BuildSolidList
CALLV
pop
line 312
;312:}
LABELV $235
endproc CG_SetNextSnap 20 16
proc CG_ReadNextSnapshot 16 12
line 325
;313:
;314:
;315:/*
;316:========================
;317:CG_ReadNextSnapshot
;318:
;319:This is the only place new snapshots are requested
;320:This may increment cgs.processedSnapshotNum multiple
;321:times if the client system fails to return a
;322:valid snapshot.
;323:========================
;324:*/
;325:static snapshot_t *CG_ReadNextSnapshot( void ) {
line 329
;326:	qboolean	r;
;327:	snapshot_t	*dest;
;328:
;329:	if ( cg.latestSnapshotNum > cgs.processedSnapshotNum + 1000 ) {
ADDRGP4 cg+28
INDIRI4
ADDRGP4 cgs+31448
INDIRI4
CNSTI4 1000
ADDI4
LEI4 $289
line 330
;330:		CG_Printf( "WARNING: CG_ReadNextSnapshot: way out of range, %i > %i", 
ADDRGP4 $285
ARGP4
ADDRGP4 cg+28
INDIRI4
ARGI4
ADDRGP4 cgs+31448
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 332
;331:			cg.latestSnapshotNum, cgs.processedSnapshotNum );
;332:	}
ADDRGP4 $289
JUMPV
LABELV $288
line 334
;333:
;334:	while ( cgs.processedSnapshotNum < cg.latestSnapshotNum ) {
line 336
;335:		// decide which of the two slots to load it into
;336:		if ( cg.snap == &cg.activeSnapshots[0] ) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
ADDRGP4 cg+44
CVPU4 4
NEU4 $293
line 337
;337:			dest = &cg.activeSnapshots[1];
ADDRLP4 0
ADDRGP4 cg+44+53772
ASGNP4
line 338
;338:		} else {
ADDRGP4 $294
JUMPV
LABELV $293
line 339
;339:			dest = &cg.activeSnapshots[0];
ADDRLP4 0
ADDRGP4 cg+44
ASGNP4
line 340
;340:		}
LABELV $294
line 343
;341:
;342:		// try to read the snapshot from the client system
;343:		cgs.processedSnapshotNum++;
ADDRLP4 8
ADDRGP4 cgs+31448
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 344
;344:		r = trap_GetSnapshot( cgs.processedSnapshotNum, dest );
ADDRGP4 cgs+31448
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 trap_GetSnapshot
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
ASGNI4
line 347
;345:
;346:		// FIXME: why would trap_GetSnapshot return a snapshot with the same server time
;347:		if ( cg.snap && r && dest->serverTime == cg.snap->serverTime ) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $302
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $302
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $302
line 349
;348:			//continue;
;349:		}
LABELV $302
line 352
;350:
;351:		// if it succeeded, return
;352:		if ( r ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $306
line 353
;353:			CG_AddLagometerSnapshotInfo( dest );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_AddLagometerSnapshotInfo
CALLV
pop
line 354
;354:			return dest;
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $280
JUMPV
LABELV $306
line 363
;355:		}
;356:
;357:		// a GetSnapshot will return failure if the snapshot
;358:		// never arrived, or  is so old that its entities
;359:		// have been shoved off the end of the circular
;360:		// buffer in the client system.
;361:
;362:		// record as a dropped packet
;363:		CG_AddLagometerSnapshotInfo( NULL );
CNSTP4 0
ARGP4
ADDRGP4 CG_AddLagometerSnapshotInfo
CALLV
pop
line 367
;364:
;365:		// If there are additional snapshots, continue trying to
;366:		// read them.
;367:	}
LABELV $289
line 334
ADDRGP4 cgs+31448
INDIRI4
ADDRGP4 cg+28
INDIRI4
LTI4 $288
line 370
;368:
;369:	// nothing left to read
;370:	return NULL;
CNSTP4 0
RETP4
LABELV $280
endproc CG_ReadNextSnapshot 16 12
export CG_ProcessSnapshots
proc CG_ProcessSnapshots 16 8
line 393
;371:}
;372:
;373:
;374:/*
;375:============
;376:CG_ProcessSnapshots
;377:
;378:We are trying to set up a renderable view, so determine
;379:what the simulated time is, and try to get snapshots
;380:both before and after that time if available.
;381:
;382:If we don't have a valid cg.snap after exiting this function,
;383:then a 3D game view cannot be rendered.  This should only happen
;384:right after the initial connection.  After cg.snap has been valid
;385:once, it will never turn invalid.
;386:
;387:Even if cg.snap is valid, cg.nextSnap may not be, if the snapshot
;388:hasn't arrived yet (it becomes an extrapolating situation instead
;389:of an interpolating one)
;390:
;391:============
;392:*/
;393:void CG_ProcessSnapshots( void ) {
line 398
;394:	snapshot_t		*snap;
;395:	int				n;
;396:
;397:	// see what the latest snapshot the client system has is
;398:	trap_GetCurrentSnapshotNumber( &n, &cg.latestSnapshotTime );
ADDRLP4 4
ARGP4
ADDRGP4 cg+32
ARGP4
ADDRGP4 trap_GetCurrentSnapshotNumber
CALLV
pop
line 399
;399:	if ( n != cg.latestSnapshotNum ) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+28
INDIRI4
EQI4 $319
line 400
;400:		if ( n < cg.latestSnapshotNum ) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+28
INDIRI4
GEI4 $313
line 402
;401:			// this should never happen
;402:			CG_Error( "CG_ProcessSnapshots: n < cg.latestSnapshotNum" );
ADDRGP4 $316
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 403
;403:		}
LABELV $313
line 404
;404:		cg.latestSnapshotNum = n;
ADDRGP4 cg+28
ADDRLP4 4
INDIRI4
ASGNI4
line 405
;405:	}
ADDRGP4 $319
JUMPV
LABELV $318
line 410
;406:
;407:	// If we have yet to receive a snapshot, check for it.
;408:	// Once we have gotten the first snapshot, cg.snap will
;409:	// always have valid data for the rest of the game
;410:	while ( !cg.snap ) {
line 411
;411:		snap = CG_ReadNextSnapshot();
ADDRLP4 8
ADDRGP4 CG_ReadNextSnapshot
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 412
;412:		if ( !snap ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $322
line 414
;413:			// we can't continue until we get a snapshot
;414:			return;
ADDRGP4 $308
JUMPV
LABELV $322
line 419
;415:		}
;416:
;417:		// set our weapon selection to what
;418:		// the playerstate is currently using
;419:		if ( !( snap->snapFlags & SNAPFLAG_NOT_ACTIVE ) ) {
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $324
line 420
;420:			CG_SetInitialSnapshot( snap );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_SetInitialSnapshot
CALLV
pop
line 421
;421:		}
LABELV $324
line 422
;422:	}
LABELV $319
line 410
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $318
LABELV $326
line 427
;423:
;424:	// loop until we either have a valid nextSnap with a serverTime
;425:	// greater than cg.time to interpolate towards, or we run
;426:	// out of available snapshots
;427:	do {
line 429
;428:		// if we don't have a nextframe, try and read a new one in
;429:		if ( !cg.nextSnap ) {
ADDRGP4 cg+40
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $329
line 430
;430:			snap = CG_ReadNextSnapshot();
ADDRLP4 8
ADDRGP4 CG_ReadNextSnapshot
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 434
;431:
;432:			// if we still don't have a nextframe, we will just have to
;433:			// extrapolate
;434:			if ( !snap ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $332
line 435
;435:				break;
ADDRGP4 $328
JUMPV
LABELV $332
line 438
;436:			}
;437:
;438:			CG_SetNextSnap( snap );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_SetNextSnap
CALLV
pop
line 442
;439:
;440:
;441:			// if time went backwards, we have a level restart
;442:			if ( cg.nextSnap->serverTime < cg.snap->serverTime ) {
ADDRGP4 cg+40
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
GEI4 $334
line 443
;443:				CG_Error( "CG_ProcessSnapshots: Server time went backwards" );
ADDRGP4 $338
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 444
;444:			}
LABELV $334
line 445
;445:		}
LABELV $329
line 448
;446:
;447:		// if our time is < nextFrame's, we have a nice interpolating state
;448:		if ( cg.time >= cg.snap->serverTime && cg.time < cg.nextSnap->serverTime ) {
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
LTI4 $339
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cg+40
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
GEI4 $339
line 449
;449:			break;
ADDRGP4 $328
JUMPV
LABELV $339
line 453
;450:		}
;451:
;452:		// we have passed the transition from nextFrame to frame
;453:		CG_TransitionSnapshot();
ADDRGP4 CG_TransitionSnapshot
CALLV
pop
line 454
;454:	} while ( 1 );
LABELV $327
ADDRGP4 $326
JUMPV
LABELV $328
line 458
;455:
;456:	// JUHOX: stop-movers-mechanism for lens flare editor
;457:#if MAPLENSFLARES
;458:	if (cgs.editMode == EM_mlf) {
ADDRGP4 cgs+31684
INDIRI4
CNSTI4 1
NEI4 $345
line 459
;459:		if (cg.lfEditor.moversStopped) {
ADDRGP4 cg+109660+448
INDIRI4
CNSTI4 0
EQI4 $348
line 462
;460:			int num;
;461:
;462:			for (num = MAX_CLIENTS; num < ENTITYNUM_MAX_NORMAL; num++) {
ADDRLP4 8
CNSTI4 64
ASGNI4
LABELV $352
line 465
;463:				centity_t* cent;
;464:
;465:				cent = &cg_entities[num];
ADDRLP4 12
ADDRLP4 8
INDIRI4
CNSTI4 880
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 466
;466:				if (cent->currentState.eType != ET_MOVER) continue;
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 4
EQI4 $356
ADDRGP4 $353
JUMPV
LABELV $356
line 468
;467:
;468:				CG_StopMover(cent);
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 CG_StopMover
CALLV
pop
line 469
;469:			}
LABELV $353
line 462
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 1022
LTI4 $352
line 470
;470:		}
ADDRGP4 $349
JUMPV
LABELV $348
line 472
;471:		else if (
;472:			cg.lfEditor.selectedLFEnt &&
ADDRGP4 cg+109660
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $358
ADDRGP4 cg+109660
INDIRP4
CNSTI4 12
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $358
line 474
;473:			cg.lfEditor.selectedLFEnt->lock
;474:		) {
line 475
;475:			CG_StopMover(cg.lfEditor.selectedLFEnt->lock);
ADDRGP4 cg+109660
INDIRP4
CNSTI4 12
ADDP4
INDIRP4
ARGP4
ADDRGP4 CG_StopMover
CALLV
pop
line 476
;476:		}
LABELV $358
LABELV $349
line 477
;477:	}
LABELV $345
line 481
;478:#endif
;479:
;480:	// assert our valid conditions upon exiting
;481:	if ( cg.snap == NULL ) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $363
line 482
;482:		CG_Error( "CG_ProcessSnapshots: cg.snap == NULL" );
ADDRGP4 $366
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 483
;483:	}
LABELV $363
line 484
;484:	if ( cg.time < cg.snap->serverTime ) {
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
GEI4 $367
line 486
;485:		// this can happen right after a vid_restart
;486:		cg.time = cg.snap->serverTime;
ADDRGP4 cg+107656
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 487
;487:	}
LABELV $367
line 488
;488:	if ( cg.nextSnap != NULL && cg.nextSnap->serverTime <= cg.time ) {
ADDRGP4 cg+40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $373
ADDRGP4 cg+40
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRGP4 cg+107656
INDIRI4
GTI4 $373
line 489
;489:		CG_Error( "CG_ProcessSnapshots: cg.nextSnap->serverTime <= cg.time" );
ADDRGP4 $378
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 490
;490:	}
LABELV $373
line 492
;491:
;492:}
LABELV $308
endproc CG_ProcessSnapshots 16 8
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
LABELV $378
byte 1 67
byte 1 71
byte 1 95
byte 1 80
byte 1 114
byte 1 111
byte 1 99
byte 1 101
byte 1 115
byte 1 115
byte 1 83
byte 1 110
byte 1 97
byte 1 112
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 115
byte 1 58
byte 1 32
byte 1 99
byte 1 103
byte 1 46
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 83
byte 1 110
byte 1 97
byte 1 112
byte 1 45
byte 1 62
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 32
byte 1 60
byte 1 61
byte 1 32
byte 1 99
byte 1 103
byte 1 46
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $366
byte 1 67
byte 1 71
byte 1 95
byte 1 80
byte 1 114
byte 1 111
byte 1 99
byte 1 101
byte 1 115
byte 1 115
byte 1 83
byte 1 110
byte 1 97
byte 1 112
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 115
byte 1 58
byte 1 32
byte 1 99
byte 1 103
byte 1 46
byte 1 115
byte 1 110
byte 1 97
byte 1 112
byte 1 32
byte 1 61
byte 1 61
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 0
align 1
LABELV $338
byte 1 67
byte 1 71
byte 1 95
byte 1 80
byte 1 114
byte 1 111
byte 1 99
byte 1 101
byte 1 115
byte 1 115
byte 1 83
byte 1 110
byte 1 97
byte 1 112
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 115
byte 1 58
byte 1 32
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 32
byte 1 119
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 119
byte 1 97
byte 1 114
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $316
byte 1 67
byte 1 71
byte 1 95
byte 1 80
byte 1 114
byte 1 111
byte 1 99
byte 1 101
byte 1 115
byte 1 115
byte 1 83
byte 1 110
byte 1 97
byte 1 112
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 115
byte 1 58
byte 1 32
byte 1 110
byte 1 32
byte 1 60
byte 1 32
byte 1 99
byte 1 103
byte 1 46
byte 1 108
byte 1 97
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 83
byte 1 110
byte 1 97
byte 1 112
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 78
byte 1 117
byte 1 109
byte 1 0
align 1
LABELV $285
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 67
byte 1 71
byte 1 95
byte 1 82
byte 1 101
byte 1 97
byte 1 100
byte 1 78
byte 1 101
byte 1 120
byte 1 116
byte 1 83
byte 1 110
byte 1 97
byte 1 112
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 58
byte 1 32
byte 1 119
byte 1 97
byte 1 121
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
byte 1 44
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 62
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $157
byte 1 67
byte 1 71
byte 1 95
byte 1 84
byte 1 114
byte 1 97
byte 1 110
byte 1 115
byte 1 105
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 83
byte 1 110
byte 1 97
byte 1 112
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 58
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 32
byte 1 99
byte 1 103
byte 1 46
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 83
byte 1 110
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $153
byte 1 67
byte 1 71
byte 1 95
byte 1 84
byte 1 114
byte 1 97
byte 1 110
byte 1 115
byte 1 105
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 83
byte 1 110
byte 1 97
byte 1 112
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 58
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 32
byte 1 99
byte 1 103
byte 1 46
byte 1 115
byte 1 110
byte 1 97
byte 1 112
byte 1 0
