export CG_BuildSolidList
code
proc CG_BuildSolidList 24 0
file "..\..\..\..\code\cgame\cg_predict.c"
line 26
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_predict.c -- this file generates cg.predictedPlayerState by either
;4:// interpolating between snapshots from the server or locally predicting
;5:// ahead the client's movement.
;6:// It also handles local physics interaction, like fragments bouncing off walls
;7:
;8:#include "cg_local.h"
;9:
;10:static	pmove_t		cg_pmove;
;11:
;12:static	int			cg_numSolidEntities;
;13:static	centity_t	*cg_solidEntities[MAX_ENTITIES_IN_SNAPSHOT];
;14:static	int			cg_numTriggerEntities;
;15:static	centity_t	*cg_triggerEntities[MAX_ENTITIES_IN_SNAPSHOT];
;16:
;17:/*
;18:====================
;19:CG_BuildSolidList
;20:
;21:When a new cg.snap has been set, this function builds a sublist
;22:of the entities that are actually solid, to make for more
;23:efficient collision detection
;24:====================
;25:*/
;26:void CG_BuildSolidList( void ) {
line 32
;27:	int			i;
;28:	centity_t	*cent;
;29:	snapshot_t	*snap;
;30:	entityState_t	*ent;
;31:
;32:	cg_numSolidEntities = 0;
ADDRGP4 cg_numSolidEntities
CNSTI4 0
ASGNI4
line 33
;33:	cg_numTriggerEntities = 0;
ADDRGP4 cg_numTriggerEntities
CNSTI4 0
ASGNI4
line 35
;34:
;35:	if ( cg.nextSnap && !cg.nextFrameTeleport && !cg.thisFrameTeleport ) {
ADDRGP4 cg+40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $125
ADDRGP4 cg+107648
INDIRI4
CNSTI4 0
NEI4 $125
ADDRGP4 cg+107644
INDIRI4
CNSTI4 0
NEI4 $125
line 36
;36:		snap = cg.nextSnap;
ADDRLP4 12
ADDRGP4 cg+40
INDIRP4
ASGNP4
line 37
;37:	} else {
ADDRGP4 $126
JUMPV
LABELV $125
line 38
;38:		snap = cg.snap;
ADDRLP4 12
ADDRGP4 cg+36
INDIRP4
ASGNP4
line 39
;39:	}
LABELV $126
line 41
;40:
;41:	for ( i = 0 ; i < snap->numEntities ; i++ ) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $135
JUMPV
LABELV $132
line 42
;42:		cent = &cg_entities[ snap->entities[ i ].number ];
ADDRLP4 0
ADDRLP4 8
INDIRI4
CNSTI4 208
MULI4
ADDRLP4 12
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
line 43
;43:		ent = &cent->currentState;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
line 45
;44:
;45:		if ( ent->eType == ET_ITEM || ent->eType == ET_PUSH_TRIGGER || ent->eType == ET_TELEPORT_TRIGGER ) {
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $139
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 8
EQI4 $139
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 9
NEI4 $136
LABELV $139
line 46
;46:			cg_triggerEntities[cg_numTriggerEntities] = cent;
ADDRGP4 cg_numTriggerEntities
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_triggerEntities
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 47
;47:			cg_numTriggerEntities++;
ADDRLP4 20
ADDRGP4 cg_numTriggerEntities
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 48
;48:			continue;
ADDRGP4 $133
JUMPV
LABELV $136
line 51
;49:		}
;50:
;51:		if ( cent->nextState.solid ) {
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 0
EQI4 $140
line 52
;52:			cg_solidEntities[cg_numSolidEntities] = cent;
ADDRGP4 cg_numSolidEntities
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_solidEntities
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 53
;53:			cg_numSolidEntities++;
ADDRLP4 20
ADDRGP4 cg_numSolidEntities
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 54
;54:			continue;
LABELV $140
line 56
;55:		}
;56:	}
LABELV $133
line 41
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $135
ADDRLP4 8
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
LTI4 $132
line 57
;57:}
LABELV $124
endproc CG_BuildSolidList 24 0
proc CG_ClipMoveToEntities 144 36
line 66
;58:
;59:/*
;60:====================
;61:CG_ClipMoveToEntities
;62:
;63:====================
;64:*/
;65:static void CG_ClipMoveToEntities ( const vec3_t start, const vec3_t mins, const vec3_t maxs, const vec3_t end,
;66:							int skipNumber, int mask, trace_t *tr ) {
line 75
;67:	int			i, x, zd, zu;
;68:	trace_t		trace;
;69:	entityState_t	*ent;
;70:	clipHandle_t 	cmodel;
;71:	vec3_t		bmins, bmaxs;
;72:	vec3_t		origin, angles;
;73:	centity_t	*cent;
;74:
;75:	for ( i = 0 ; i < cg_numSolidEntities ; i++ ) {
ADDRLP4 64
CNSTI4 0
ASGNI4
ADDRGP4 $146
JUMPV
LABELV $143
line 76
;76:		cent = cg_solidEntities[ i ];
ADDRLP4 60
ADDRLP4 64
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_solidEntities
ADDP4
INDIRP4
ASGNP4
line 77
;77:		ent = &cent->currentState;
ADDRLP4 0
ADDRLP4 60
INDIRP4
ASGNP4
line 79
;78:
;79:		if ( ent->number == skipNumber ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRFP4 16
INDIRI4
NEI4 $147
line 80
;80:			continue;
ADDRGP4 $144
JUMPV
LABELV $147
line 83
;81:		}
;82:
;83:		if ( ent->solid == SOLID_BMODEL ) {
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 16777215
NEI4 $149
line 85
;84:			// special value for bmodel
;85:			cmodel = trap_CM_InlineModel( ent->modelindex );
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ARGI4
ADDRLP4 132
ADDRGP4 trap_CM_InlineModel
CALLI4
ASGNI4
ADDRLP4 68
ADDRLP4 132
INDIRI4
ASGNI4
line 86
;86:			VectorCopy( cent->lerpAngles, angles );
ADDRLP4 108
ADDRLP4 60
INDIRP4
CNSTI4 740
ADDP4
INDIRB
ASGNB 12
line 87
;87:			BG_EvaluateTrajectory( &cent->currentState.pos, cg.physicsTime, origin );
ADDRLP4 60
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 cg+107664
INDIRI4
ARGI4
ADDRLP4 96
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 88
;88:		} else {
ADDRGP4 $150
JUMPV
LABELV $149
line 90
;89:			// encoded bbox
;90:			x = (ent->solid & 255);
ADDRLP4 120
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 255
BANDI4
ASGNI4
line 91
;91:			zd = ((ent->solid>>8) & 255);
ADDRLP4 124
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 8
RSHI4
CNSTI4 255
BANDI4
ASGNI4
line 92
;92:			zu = ((ent->solid>>16) & 255) - 32;
ADDRLP4 128
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 16
RSHI4
CNSTI4 255
BANDI4
CNSTI4 32
SUBI4
ASGNI4
line 94
;93:
;94:			bmins[0] = bmins[1] = -x;
ADDRLP4 132
ADDRLP4 120
INDIRI4
NEGI4
CVIF4 4
ASGNF4
ADDRLP4 72+4
ADDRLP4 132
INDIRF4
ASGNF4
ADDRLP4 72
ADDRLP4 132
INDIRF4
ASGNF4
line 95
;95:			bmaxs[0] = bmaxs[1] = x;
ADDRLP4 136
ADDRLP4 120
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 84+4
ADDRLP4 136
INDIRF4
ASGNF4
ADDRLP4 84
ADDRLP4 136
INDIRF4
ASGNF4
line 96
;96:			bmins[2] = -zd;
ADDRLP4 72+8
ADDRLP4 124
INDIRI4
NEGI4
CVIF4 4
ASGNF4
line 97
;97:			bmaxs[2] = zu;
ADDRLP4 84+8
ADDRLP4 128
INDIRI4
CVIF4 4
ASGNF4
line 99
;98:
;99:			cmodel = trap_CM_TempBoxModel( bmins, bmaxs );
ADDRLP4 72
ARGP4
ADDRLP4 84
ARGP4
ADDRLP4 140
ADDRGP4 trap_CM_TempBoxModel
CALLI4
ASGNI4
ADDRLP4 68
ADDRLP4 140
INDIRI4
ASGNI4
line 100
;100:			VectorCopy( vec3_origin, angles );
ADDRLP4 108
ADDRGP4 vec3_origin
INDIRB
ASGNB 12
line 101
;101:			VectorCopy( cent->lerpOrigin, origin );
ADDRLP4 96
ADDRLP4 60
INDIRP4
CNSTI4 728
ADDP4
INDIRB
ASGNB 12
line 102
;102:		}
LABELV $150
line 105
;103:
;104:
;105:		trap_CM_TransformedBoxTrace ( &trace, start, end,
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 68
INDIRI4
ARGI4
ADDRFP4 20
INDIRI4
ARGI4
ADDRLP4 96
ARGP4
ADDRLP4 108
ARGP4
ADDRGP4 trap_CM_TransformedBoxTrace
CALLV
pop
line 108
;106:			mins, maxs, cmodel,  mask, origin, angles);
;107:
;108:		if (trace.allsolid || trace.fraction < tr->fraction) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $159
ADDRLP4 4+8
INDIRF4
ADDRFP4 24
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
GEF4 $156
LABELV $159
line 109
;109:			trace.entityNum = ent->number;
ADDRLP4 4+52
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 110
;110:			*tr = trace;
ADDRFP4 24
INDIRP4
ADDRLP4 4
INDIRB
ASGNB 56
line 111
;111:		} else if (trace.startsolid) {
ADDRGP4 $157
JUMPV
LABELV $156
ADDRLP4 4+4
INDIRI4
CNSTI4 0
EQI4 $161
line 112
;112:			tr->startsolid = qtrue;
ADDRFP4 24
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 1
ASGNI4
line 113
;113:		}
LABELV $161
LABELV $157
line 114
;114:		if ( tr->allsolid ) {
ADDRFP4 24
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $164
line 115
;115:			return;
ADDRGP4 $142
JUMPV
LABELV $164
line 117
;116:		}
;117:	}
LABELV $144
line 75
ADDRLP4 64
ADDRLP4 64
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $146
ADDRLP4 64
INDIRI4
ADDRGP4 cg_numSolidEntities
INDIRI4
LTI4 $143
line 118
;118:}
LABELV $142
endproc CG_ClipMoveToEntities 144 36
export CG_Trace
proc CG_Trace 60 28
line 126
;119:
;120:/*
;121:================
;122:CG_Trace
;123:================
;124:*/
;125:void	CG_Trace( trace_t *result, const vec3_t start, const vec3_t mins, const vec3_t maxs, const vec3_t end, 
;126:					 int skipNumber, int mask ) {
line 129
;127:	trace_t	t;
;128:
;129:	trap_CM_BoxTrace ( &t, start, end, mins, maxs, 0, mask);
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRFP4 24
INDIRI4
ARGI4
ADDRGP4 trap_CM_BoxTrace
CALLV
pop
line 130
;130:	t.entityNum = t.fraction != 1.0 ? ENTITYNUM_WORLD : ENTITYNUM_NONE;
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
EQF4 $170
ADDRLP4 56
CNSTI4 1022
ASGNI4
ADDRGP4 $171
JUMPV
LABELV $170
ADDRLP4 56
CNSTI4 1023
ASGNI4
LABELV $171
ADDRLP4 0+52
ADDRLP4 56
INDIRI4
ASGNI4
line 132
;131:	// check all other solid models
;132:	CG_ClipMoveToEntities (start, mins, maxs, end, skipNumber, mask, &t);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 20
INDIRI4
ARGI4
ADDRFP4 24
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 CG_ClipMoveToEntities
CALLV
pop
line 134
;133:
;134:	*result = t;
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRB
ASGNB 56
line 135
;135:}
LABELV $166
endproc CG_Trace 60 28
export CG_SmoothTrace
proc CG_SmoothTrace 4 28
line 146
;136:
;137:/*
;138:================
;139:JUHOX: CG_SmoothTrace
;140:================
;141:*/
;142:void CG_SmoothTrace(
;143:	trace_t *result,
;144:	const vec3_t start, const vec3_t mins, const vec3_t maxs, const vec3_t end, 
;145:	int skipNumber, int mask
;146:) {
line 149
;147:	int physicsTime;
;148:
;149:	physicsTime = cg.physicsTime;
ADDRLP4 0
ADDRGP4 cg+107664
INDIRI4
ASGNI4
line 150
;150:	cg.physicsTime = cg.time;
ADDRGP4 cg+107664
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 151
;151:	CG_Trace(result, start, mins, maxs, end, skipNumber, mask);
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
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 20
INDIRI4
ARGI4
ADDRFP4 24
INDIRI4
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 152
;152:	cg.physicsTime = cg.time;
ADDRGP4 cg+107664
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 153
;153:}
LABELV $172
endproc CG_SmoothTrace 4 28
export CG_PointContents
proc CG_PointContents 36 16
line 160
;154:
;155:/*
;156:================
;157:CG_PointContents
;158:================
;159:*/
;160:int		CG_PointContents( const vec3_t point, int passEntityNum ) {
line 167
;161:	int			i;
;162:	entityState_t	*ent;
;163:	centity_t	*cent;
;164:	clipHandle_t cmodel;
;165:	int			contents;
;166:
;167:	contents = trap_CM_PointContents (point, 0);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 20
ADDRGP4 trap_CM_PointContents
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 20
INDIRI4
ASGNI4
line 169
;168:
;169:	for ( i = 0 ; i < cg_numSolidEntities ; i++ ) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $182
JUMPV
LABELV $179
line 170
;170:		cent = cg_solidEntities[ i ];
ADDRLP4 4
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_solidEntities
ADDP4
INDIRP4
ASGNP4
line 172
;171:
;172:		ent = &cent->currentState;
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 174
;173:
;174:		if ( ent->number == passEntityNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $183
line 175
;175:			continue;
ADDRGP4 $180
JUMPV
LABELV $183
line 178
;176:		}
;177:
;178:		if (ent->solid != SOLID_BMODEL) { // special value for bmodel
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 16777215
EQI4 $185
line 179
;179:			continue;
ADDRGP4 $180
JUMPV
LABELV $185
line 182
;180:		}
;181:
;182:		cmodel = trap_CM_InlineModel( ent->modelindex );
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 trap_CM_InlineModel
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 24
INDIRI4
ASGNI4
line 183
;183:		if ( !cmodel ) {
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $187
line 184
;184:			continue;
ADDRGP4 $180
JUMPV
LABELV $187
line 190
;185:		}
;186:
;187:#if 0	// JUHOX: consider moving entities
;188:		contents |= trap_CM_TransformedPointContents( point, cmodel, ent->origin, ent->angles );
;189:#else
;190:		contents |= trap_CM_TransformedPointContents(point, cmodel, cent->lerpOrigin, cent->lerpAngles);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 728
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 740
ADDP4
ARGP4
ADDRLP4 32
ADDRGP4 trap_CM_TransformedPointContents
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 16
INDIRI4
ADDRLP4 32
INDIRI4
BORI4
ASGNI4
line 192
;191:#endif
;192:	}
LABELV $180
line 169
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $182
ADDRLP4 8
INDIRI4
ADDRGP4 cg_numSolidEntities
INDIRI4
LTI4 $179
line 194
;193:
;194:	return contents;
ADDRLP4 16
INDIRI4
RETI4
LABELV $178
endproc CG_PointContents 36 16
proc CG_InterpolatePlayerState 52 12
line 206
;195:}
;196:
;197:
;198:/*
;199:========================
;200:CG_InterpolatePlayerState
;201:
;202:Generates cg.predictedPlayerState by interpolating between
;203:cg.snap->player_state and cg.nextFrame->player_state
;204:========================
;205:*/
;206:static void CG_InterpolatePlayerState( qboolean grabAngles ) {
line 212
;207:	float			f;
;208:	int				i;
;209:	playerState_t	*out;
;210:	snapshot_t		*prev, *next;
;211:
;212:	out = &cg.predictedPlayerState;
ADDRLP4 12
ADDRGP4 cg+107688
ASGNP4
line 213
;213:	prev = cg.snap;
ADDRLP4 4
ADDRGP4 cg+36
INDIRP4
ASGNP4
line 214
;214:	next = cg.nextSnap;
ADDRLP4 8
ADDRGP4 cg+40
INDIRP4
ASGNP4
line 216
;215:
;216:	*out = cg.snap->ps;
ADDRLP4 12
INDIRP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
INDIRB
ASGNB 468
line 219
;217:
;218:	// if we are still allowing local input, short circuit the view angles
;219:	if ( grabAngles ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $194
line 223
;220:		usercmd_t	cmd;
;221:		int			cmdNum;
;222:
;223:		cmdNum = trap_GetCurrentCmdNumber();
ADDRLP4 48
ADDRGP4 trap_GetCurrentCmdNumber
CALLI4
ASGNI4
ADDRLP4 44
ADDRLP4 48
INDIRI4
ASGNI4
line 224
;224:		trap_GetUserCmd( cmdNum, &cmd );
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 20
ARGP4
ADDRGP4 trap_GetUserCmd
CALLI4
pop
line 226
;225:
;226:		PM_UpdateViewAngles( out, &cmd );
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 PM_UpdateViewAngles
CALLV
pop
line 227
;227:	}
LABELV $194
line 230
;228:
;229:	// if the next frame is a teleport, we can't lerp to it
;230:	if ( cg.nextFrameTeleport ) {
ADDRGP4 cg+107648
INDIRI4
CNSTI4 0
EQI4 $196
line 231
;231:		return;
ADDRGP4 $189
JUMPV
LABELV $196
line 234
;232:	}
;233:
;234:	if ( !next || next->serverTime <= prev->serverTime ) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $201
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
GTI4 $199
LABELV $201
line 235
;235:		return;
ADDRGP4 $189
JUMPV
LABELV $199
line 238
;236:	}
;237:
;238:	f = (float)( cg.time - prev->serverTime ) / ( next->serverTime - prev->serverTime );
ADDRLP4 16
ADDRGP4 cg+107656
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
SUBI4
CVIF4 4
DIVF4
ASGNF4
line 240
;239:
;240:	i = next->ps.bobCycle;
ADDRLP4 0
ADDRLP4 8
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
ASGNI4
line 241
;241:	if ( i < prev->ps.bobCycle ) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
GEI4 $203
line 242
;242:		i += 256;		// handle wraparound
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 256
ADDI4
ASGNI4
line 243
;243:	}
LABELV $203
line 244
;244:	out->bobCycle = prev->ps.bobCycle + f * ( i - prev->ps.bobCycle );
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 16
INDIRF4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
SUBI4
CVIF4 4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 246
;245:
;246:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $205
line 251
;247:		// JUHOX: consider reference
;248:#if !ESCAPE_MODE
;249:		out->origin[i] = prev->ps.origin[i] + f * (next->ps.origin[i] - prev->ps.origin[i] );
;250:#else
;251:		out->origin[i] = prev->ps.origin[i] + f * (next->ps.origin[i] + cg.referenceDelta[i] - prev->ps.origin[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
CNSTI4 20
ADDP4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 64
ADDP4
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 64
ADDP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+107612
ADDP4
INDIRF4
ADDF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 64
ADDP4
ADDP4
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 253
;252:#endif
;253:		if ( !grabAngles ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $210
line 254
;254:			out->viewangles[i] = LerpAngle( 
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 196
ADDP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 44
ADDRGP4 LerpAngle
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
CNSTI4 152
ADDP4
ADDP4
ADDRLP4 44
INDIRF4
ASGNF4
line 256
;255:				prev->ps.viewangles[i], next->ps.viewangles[i], f );
;256:		}
LABELV $210
line 257
;257:		out->velocity[i] = prev->ps.velocity[i] + 
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
CNSTI4 32
ADDP4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 76
ADDP4
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 76
ADDP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 76
ADDP4
ADDP4
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 259
;258:			f * (next->ps.velocity[i] - prev->ps.velocity[i] );
;259:	}
LABELV $206
line 246
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $205
line 261
;260:
;261:}
LABELV $189
endproc CG_InterpolatePlayerState 52 12
proc CG_TouchItem 20 12
line 268
;262:
;263:/*
;264:===================
;265:CG_TouchItem
;266:===================
;267:*/
;268:static void CG_TouchItem( centity_t *cent ) {
line 271
;269:	gitem_t		*item;
;270:
;271:	if ( !cg_predictItems.integer ) {
ADDRGP4 cg_predictItems+12
INDIRI4
CNSTI4 0
NEI4 $213
line 272
;272:		return;
ADDRGP4 $212
JUMPV
LABELV $213
line 274
;273:	}
;274:	if ( !BG_PlayerTouchesItem( &cg.predictedPlayerState, &cent->currentState, cg.time ) ) {
ADDRGP4 cg+107688
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cg+107656
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 BG_PlayerTouchesItem
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $216
line 275
;275:		return;
ADDRGP4 $212
JUMPV
LABELV $216
line 279
;276:	}
;277:
;278:	// never pick an item up twice in a prediction
;279:	if ( cent->miscTime == cg.time ) {
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
INDIRI4
ADDRGP4 cg+107656
INDIRI4
NEI4 $220
line 280
;280:		return;
ADDRGP4 $212
JUMPV
LABELV $220
line 283
;281:	}
;282:
;283:	if ( !BG_CanItemBeGrabbed( cgs.gametype, &cent->currentState, &cg.predictedPlayerState ) ) {
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cg+107688
ARGP4
ADDRLP4 8
ADDRGP4 BG_CanItemBeGrabbed
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $223
line 284
;284:		return;		// can't hold it
ADDRGP4 $212
JUMPV
LABELV $223
line 287
;285:	}
;286:
;287:	item = &bg_itemlist[ cent->currentState.modelindex ];
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 299
;288:
;289:	// Special case for flags.  
;290:	// We don't predict touching our own flag
;291:#ifdef MISSIONPACK
;292:	if( cgs.gametype == GT_1FCTF ) {
;293:		if( item->giTag != PW_NEUTRALFLAG ) {
;294:			return;
;295:		}
;296:	}
;297:	if( cgs.gametype == GT_CTF || cgs.gametype == GT_HARVESTER ) {
;298:#else
;299:	if( cgs.gametype == GT_CTF ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
NEI4 $227
line 301
;300:#endif
;301:		if (cg.predictedPlayerState.persistant[PERS_TEAM] == TEAM_RED &&
ADDRGP4 cg+107688+248+12
INDIRI4
CNSTI4 1
NEI4 $230
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 7
NEI4 $230
line 303
;302:			item->giTag == PW_REDFLAG)
;303:			return;
ADDRGP4 $212
JUMPV
LABELV $230
line 304
;304:		if (cg.predictedPlayerState.persistant[PERS_TEAM] == TEAM_BLUE &&
ADDRGP4 cg+107688+248+12
INDIRI4
CNSTI4 2
NEI4 $235
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 8
NEI4 $235
line 306
;305:			item->giTag == PW_BLUEFLAG)
;306:			return;
ADDRGP4 $212
JUMPV
LABELV $235
line 307
;307:	}
LABELV $227
line 310
;308:
;309:	// grab it
;310:	BG_AddPredictableEventToPlayerstate( EV_ITEM_PICKUP, cent->currentState.modelindex , &cg.predictedPlayerState);
CNSTI4 19
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+107688
ARGP4
ADDRGP4 BG_AddPredictableEventToPlayerstate
CALLV
pop
line 313
;311:
;312:	// remove it from the frame so it won't be drawn
;313:	cent->currentState.eFlags |= EF_NODRAW;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 316
;314:
;315:	// don't touch it again this prediction
;316:	cent->miscTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 319
;317:
;318:	// if its a weapon, give them some predicted ammo so the autoswitch will work
;319:	if ( item->giType == IT_WEAPON ) {
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 1
NEI4 $242
line 320
;320:		cg.predictedPlayerState.stats[ STAT_WEAPONS ] |= 1 << item->giTag;
ADDRLP4 16
ADDRGP4 cg+107688+184+8
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
LSHI4
BORI4
ASGNI4
line 321
;321:		if ( !cg.predictedPlayerState.ammo[ item->giTag ] ) {
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+107688+376
ADDP4
INDIRI4
CNSTI4 0
NEI4 $247
line 322
;322:			cg.predictedPlayerState.ammo[ item->giTag ] = 1;
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+107688+376
ADDP4
CNSTI4 1
ASGNI4
line 323
;323:		}
LABELV $247
line 324
;324:	}
LABELV $242
line 325
;325:}
LABELV $212
endproc CG_TouchItem 20 12
proc CG_TouchTriggerPrediction 84 28
line 335
;326:
;327:
;328:/*
;329:=========================
;330:CG_TouchTriggerPrediction
;331:
;332:Predict push triggers and items
;333:=========================
;334:*/
;335:static void CG_TouchTriggerPrediction( void ) {
line 344
;336:	int			i;
;337:	trace_t		trace;
;338:	entityState_t	*ent;
;339:	clipHandle_t cmodel;
;340:	centity_t	*cent;
;341:	qboolean	spectator;
;342:
;343:	// dead clients don't activate triggers
;344:	if ( cg.predictedPlayerState.stats[STAT_HEALTH] <= 0 ) {
ADDRGP4 cg+107688+184
INDIRI4
CNSTI4 0
GTI4 $254
line 345
;345:		return;
ADDRGP4 $253
JUMPV
LABELV $254
line 350
;346:	}
;347:
;348:	// JUHOX: don't touch triggers in lens flare editor
;349:#if MAPLENSFLARES
;350:	if (cgs.editMode == EM_mlf) return;
ADDRGP4 cgs+31684
INDIRI4
CNSTI4 1
NEI4 $258
ADDRGP4 $253
JUMPV
LABELV $258
line 353
;351:#endif
;352:
;353:	spectator = ( cg.predictedPlayerState.pm_type == PM_SPECTATOR );
ADDRGP4 cg+107688+4
INDIRI4
CNSTI4 2
NEI4 $264
ADDRLP4 76
CNSTI4 1
ASGNI4
ADDRGP4 $265
JUMPV
LABELV $264
ADDRLP4 76
CNSTI4 0
ASGNI4
LABELV $265
ADDRLP4 72
ADDRLP4 76
INDIRI4
ASGNI4
line 355
;354:
;355:	if ( cg.predictedPlayerState.pm_type != PM_NORMAL && !spectator ) {
ADDRGP4 cg+107688+4
INDIRI4
CNSTI4 0
EQI4 $266
ADDRLP4 72
INDIRI4
CNSTI4 0
NEI4 $266
line 356
;356:		return;
ADDRGP4 $253
JUMPV
LABELV $266
line 359
;357:	}
;358:
;359:	for ( i = 0 ; i < cg_numTriggerEntities ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $273
JUMPV
LABELV $270
line 360
;360:		cent = cg_triggerEntities[ i ];
ADDRLP4 12
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_triggerEntities
ADDP4
INDIRP4
ASGNP4
line 361
;361:		ent = &cent->currentState;
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 363
;362:
;363:		if ( ent->eType == ET_ITEM && !spectator ) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $274
ADDRLP4 72
INDIRI4
CNSTI4 0
NEI4 $274
line 364
;364:			CG_TouchItem( cent );
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 CG_TouchItem
CALLV
pop
line 365
;365:			continue;
ADDRGP4 $271
JUMPV
LABELV $274
line 368
;366:		}
;367:
;368:		if ( ent->solid != SOLID_BMODEL ) {
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 16777215
EQI4 $276
line 369
;369:			continue;
ADDRGP4 $271
JUMPV
LABELV $276
line 372
;370:		}
;371:
;372:		cmodel = trap_CM_InlineModel( ent->modelindex );
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ARGI4
ADDRLP4 80
ADDRGP4 trap_CM_InlineModel
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 80
INDIRI4
ASGNI4
line 373
;373:		if ( !cmodel ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $278
line 374
;374:			continue;
ADDRGP4 $271
JUMPV
LABELV $278
line 377
;375:		}
;376:
;377:		trap_CM_BoxTrace( &trace, cg.predictedPlayerState.origin, cg.predictedPlayerState.origin, 
ADDRLP4 16
ARGP4
ADDRGP4 cg+107688+20
ARGP4
ADDRGP4 cg+107688+20
ARGP4
ADDRGP4 cg_pmove+212
ARGP4
ADDRGP4 cg_pmove+224
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
CNSTI4 -1
ARGI4
ADDRGP4 trap_CM_BoxTrace
CALLV
pop
line 380
;378:			cg_pmove.mins, cg_pmove.maxs, cmodel, -1 );
;379:
;380:		if ( !trace.startsolid ) {
ADDRLP4 16+4
INDIRI4
CNSTI4 0
NEI4 $286
line 381
;381:			continue;
ADDRGP4 $271
JUMPV
LABELV $286
line 384
;382:		}
;383:
;384:		if ( ent->eType == ET_TELEPORT_TRIGGER ) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 9
NEI4 $289
line 385
;385:			cg.hyperspace = qtrue;
ADDRGP4 cg+107684
CNSTI4 1
ASGNI4
line 386
;386:		} else if ( ent->eType == ET_PUSH_TRIGGER ) {
ADDRGP4 $290
JUMPV
LABELV $289
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 8
NEI4 $292
line 387
;387:			BG_TouchJumpPad( &cg.predictedPlayerState, ent );
ADDRGP4 cg+107688
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 BG_TouchJumpPad
CALLV
pop
line 388
;388:		}
LABELV $292
LABELV $290
line 389
;389:	}
LABELV $271
line 359
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $273
ADDRLP4 4
INDIRI4
ADDRGP4 cg_numTriggerEntities
INDIRI4
LTI4 $270
line 392
;390:
;391:	// if we didn't touch a jump pad this pmove frame
;392:	if ( cg.predictedPlayerState.jumppad_frame != cg.predictedPlayerState.pmove_framecount ) {
ADDRGP4 cg+107688+460
INDIRI4
ADDRGP4 cg+107688+456
INDIRI4
EQI4 $295
line 393
;393:		cg.predictedPlayerState.jumppad_frame = 0;
ADDRGP4 cg+107688+460
CNSTI4 0
ASGNI4
line 394
;394:		cg.predictedPlayerState.jumppad_ent = 0;
ADDRGP4 cg+107688+448
CNSTI4 0
ASGNI4
line 395
;395:	}
LABELV $295
line 396
;396:}
LABELV $253
endproc CG_TouchTriggerPrediction 84 28
export CG_PredictPlayerState
proc CG_PredictPlayerState 584 20
line 425
;397:
;398:
;399:/*
;400:=================
;401:CG_PredictPlayerState
;402:
;403:Generates cg.predictedPlayerState for the current cg.time
;404:cg.predictedPlayerState is guaranteed to be valid after exiting.
;405:
;406:For demo playback, this will be an interpolation between two valid
;407:playerState_t.
;408:
;409:For normal gameplay, it will be the result of predicted usercmd_t on
;410:top of the most recent playerState_t received from the server.
;411:
;412:Each new snapshot will usually have one or more new usercmd over the last,
;413:but we simulate all unacknowledged commands each time, not just the new ones.
;414:This means that on an internet connection, quite a few pmoves may be issued
;415:each frame.
;416:
;417:OPTIMIZE: don't re-simulate unless the newly arrived snapshot playerState_t
;418:differs from the predicted one.  Would require saving all intermediate
;419:playerState_t during prediction.
;420:
;421:We detect prediction errors and allow them to be decayed off over several frames
;422:to ease the jerk.
;423:=================
;424:*/
;425:void CG_PredictPlayerState( void ) {
line 433
;426:	int			cmdNum, current;
;427:	playerState_t	oldPlayerState;
;428:	qboolean	moved;
;429:	usercmd_t	oldestCmd;
;430:	usercmd_t	latestCmd;
;431:	playerState_t* predictionSource;	// JUHOX
;432:
;433:	cg.hyperspace = qfalse;	// will be set if touching a trigger_teleport
ADDRGP4 cg+107684
CNSTI4 0
ASGNI4
line 438
;434:
;435:	// if this is the first frame we must guarantee
;436:	// predictedPlayerState is valid even if there is some
;437:	// other error condition
;438:	if ( !cg.validPPS ) {
ADDRGP4 cg+109036
INDIRI4
CNSTI4 0
NEI4 $307
line 439
;439:		cg.validPPS = qtrue;
ADDRGP4 cg+109036
CNSTI4 1
ASGNI4
line 440
;440:		cg.predictedPlayerState = cg.snap->ps;
ADDRGP4 cg+107688
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
INDIRB
ASGNB 468
line 441
;441:	}
LABELV $307
line 445
;442:
;443:
;444:	// demo playback just copies the moves
;445:	if ( cg.demoPlayback || (cg.snap->ps.pm_flags & PMF_FOLLOW) ) {
ADDRGP4 cg+8
INDIRI4
CNSTI4 0
NEI4 $317
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $313
LABELV $317
line 446
;446:		CG_InterpolatePlayerState( qfalse );
CNSTI4 0
ARGI4
ADDRGP4 CG_InterpolatePlayerState
CALLV
pop
line 447
;447:		return;
ADDRGP4 $305
JUMPV
LABELV $313
line 451
;448:	}
;449:
;450:	// non-predicting local movement will grab the latest angles
;451:	if ( cg_nopredict.integer || cg_synchronousClients.integer ) {
ADDRGP4 cg_nopredict+12
INDIRI4
CNSTI4 0
NEI4 $322
ADDRGP4 cg_synchronousClients+12
INDIRI4
CNSTI4 0
EQI4 $318
LABELV $322
line 452
;452:		CG_InterpolatePlayerState( qtrue );
CNSTI4 1
ARGI4
ADDRGP4 CG_InterpolatePlayerState
CALLV
pop
line 453
;453:		return;
ADDRGP4 $305
JUMPV
LABELV $318
line 457
;454:	}
;455:
;456:	// prepare for pmove
;457:	cg_pmove.ps = &cg.predictedPlayerState;
ADDRGP4 cg_pmove
ADDRGP4 cg+107688
ASGNP4
line 458
;458:	cg_pmove.trace = CG_Trace;
ADDRGP4 cg_pmove+256
ADDRGP4 CG_Trace
ASGNP4
line 459
;459:	cg_pmove.pointcontents = CG_PointContents;
ADDRGP4 cg_pmove+260
ADDRGP4 CG_PointContents
ASGNP4
line 460
;460:	if ( cg_pmove.ps->pm_type == PM_DEAD ) {
ADDRGP4 cg_pmove
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $326
line 461
;461:		cg_pmove.tracemask = MASK_PLAYERSOLID & ~CONTENTS_BODY;
ADDRGP4 cg_pmove+28
CNSTI4 65537
ASGNI4
line 462
;462:	}
ADDRGP4 $327
JUMPV
LABELV $326
line 463
;463:	else {
line 464
;464:		cg_pmove.tracemask = MASK_PLAYERSOLID;
ADDRGP4 cg_pmove+28
CNSTI4 33619969
ASGNI4
line 465
;465:	}
LABELV $327
line 470
;466:#if 0	// JUHOX: let mission leaders in safety mode behave like spectators
;467:	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR ) {
;468:#else
;469:	if (
;470:		cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR ||
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
EQI4 $335
ADDRGP4 cg+36
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 2
NEI4 $330
ADDRGP4 cg+36
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
LEI4 $330
LABELV $335
line 472
;471:		(cg.snap->ps.pm_type == PM_SPECTATOR && cg.snap->ps.stats[STAT_HEALTH] > 0)
;472:	) {
line 474
;473:#endif
;474:		cg_pmove.tracemask &= ~CONTENTS_BODY;	// spectators can fly through bodies
ADDRLP4 532
ADDRGP4 cg_pmove+28
ASGNP4
ADDRLP4 532
INDIRP4
ADDRLP4 532
INDIRP4
INDIRI4
CNSTI4 -33554433
BANDI4
ASGNI4
line 475
;475:	}
LABELV $330
line 477
;476:#if MAPLENSFLARES	// JUHOX: set player tracemask for lens flare editor
;477:	if (cgs.editMode == EM_mlf) {
ADDRGP4 cgs+31684
INDIRI4
CNSTI4 1
NEI4 $337
line 478
;478:		cg_pmove.tracemask = 0;
ADDRGP4 cg_pmove+28
CNSTI4 0
ASGNI4
line 479
;479:	}
LABELV $337
line 481
;480:#endif
;481:	cg_pmove.noFootsteps = ( cgs.dmflags & DF_NO_FOOTSTEPS ) > 0;
ADDRGP4 cgs+31460
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
LEI4 $344
ADDRLP4 532
CNSTI4 1
ASGNI4
ADDRGP4 $345
JUMPV
LABELV $344
ADDRLP4 532
CNSTI4 0
ASGNI4
LABELV $345
ADDRGP4 cg_pmove+36
ADDRLP4 532
INDIRI4
ASGNI4
line 483
;482:#if GRAPPLE_ROPE	// JUHOX: set hook mode
;483:	cg_pmove.hookMode = cgs.hookMode;
ADDRGP4 cg_pmove+60
ADDRGP4 cgs+31868
INDIRI4
ASGNI4
line 487
;484:#endif
;485:
;486:	// save the state before the pmove so we can detect transitions
;487:	oldPlayerState = cg.predictedPlayerState;
ADDRLP4 4
ADDRGP4 cg+107688
INDIRB
ASGNB 468
line 489
;488:
;489:	current = trap_GetCurrentCmdNumber();
ADDRLP4 536
ADDRGP4 trap_GetCurrentCmdNumber
CALLI4
ASGNI4
ADDRLP4 472
ADDRLP4 536
INDIRI4
ASGNI4
line 494
;490:
;491:	// if we don't have the commands right after the snapshot, we
;492:	// can't accurately predict a current position, so just freeze at
;493:	// the last good position we had
;494:	cmdNum = current - CMD_BACKUP + 1;
ADDRLP4 0
ADDRLP4 472
INDIRI4
CNSTI4 64
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 495
;495:	trap_GetUserCmd( cmdNum, &oldestCmd );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 504
ARGP4
ADDRGP4 trap_GetUserCmd
CALLI4
pop
line 496
;496:	if ( oldestCmd.serverTime > cg.snap->ps.commandTime 
ADDRLP4 540
ADDRLP4 504
INDIRI4
ASGNI4
ADDRLP4 540
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
LEI4 $349
ADDRLP4 540
INDIRI4
ADDRGP4 cg+107656
INDIRI4
GEI4 $349
line 497
;497:		&& oldestCmd.serverTime < cg.time ) {	// special check for map_restart
line 498
;498:		if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $305
line 499
;499:			CG_Printf ("exceeded PACKET_BACKUP on commands\n");
ADDRGP4 $356
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 500
;500:		}
line 501
;501:		return;
ADDRGP4 $305
JUMPV
LABELV $349
line 505
;502:	}
;503:
;504:	// get the latest command so we can know which commands are from previous map_restarts
;505:	trap_GetUserCmd( current, &latestCmd );
ADDRLP4 472
INDIRI4
ARGI4
ADDRLP4 480
ARGP4
ADDRGP4 trap_GetUserCmd
CALLI4
pop
line 511
;506:
;507:	// get the most recent information we have, even if
;508:	// the server time is beyond our current cg.time,
;509:	// because predicted player positions are going to 
;510:	// be ahead of everything else anyway
;511:	if ( cg.nextSnap && !cg.nextFrameTeleport && !cg.thisFrameTeleport ) {
ADDRGP4 cg+40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $357
ADDRGP4 cg+107648
INDIRI4
CNSTI4 0
NEI4 $357
ADDRGP4 cg+107644
INDIRI4
CNSTI4 0
NEI4 $357
line 512
;512:		cg.predictedPlayerState = cg.nextSnap->ps;
ADDRGP4 cg+107688
ADDRGP4 cg+40
INDIRP4
CNSTI4 44
ADDP4
INDIRB
ASGNB 468
line 513
;513:		predictionSource = &cg.nextSnap->ps;	// JUHOX
ADDRLP4 528
ADDRGP4 cg+40
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
line 515
;514:#if ESCAPE_MODE	// JUHOX: make predictedPlayerState compatible with cg.snap->ps
;515:		VectorAdd(cg.predictedPlayerState.origin, cg.referenceDelta, cg.predictedPlayerState.origin);
ADDRGP4 cg+107688+20
ADDRGP4 cg+107688+20
INDIRF4
ADDRGP4 cg+107612
INDIRF4
ADDF4
ASGNF4
ADDRGP4 cg+107688+20+4
ADDRGP4 cg+107688+20+4
INDIRF4
ADDRGP4 cg+107612+4
INDIRF4
ADDF4
ASGNF4
ADDRGP4 cg+107688+20+8
ADDRGP4 cg+107688+20+8
INDIRF4
ADDRGP4 cg+107612+8
INDIRF4
ADDF4
ASGNF4
line 516
;516:		VectorAdd(cg.predictedPlayerState.grapplePoint, cg.referenceDelta, cg.predictedPlayerState.grapplePoint);
ADDRGP4 cg+107688+92
ADDRGP4 cg+107688+92
INDIRF4
ADDRGP4 cg+107612
INDIRF4
ADDF4
ASGNF4
ADDRGP4 cg+107688+92+4
ADDRGP4 cg+107688+92+4
INDIRF4
ADDRGP4 cg+107612+4
INDIRF4
ADDF4
ASGNF4
ADDRGP4 cg+107688+92+8
ADDRGP4 cg+107688+92+8
INDIRF4
ADDRGP4 cg+107612+8
INDIRF4
ADDF4
ASGNF4
line 518
;517:#endif
;518:		cg.physicsTime = cg.nextSnap->serverTime;
ADDRGP4 cg+107664
ADDRGP4 cg+40
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 519
;519:	} else {
ADDRGP4 $358
JUMPV
LABELV $357
line 520
;520:		cg.predictedPlayerState = cg.snap->ps;
ADDRGP4 cg+107688
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
INDIRB
ASGNB 468
line 521
;521:		predictionSource = &cg.snap->ps;	// JUHOX
ADDRLP4 528
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
line 522
;522:		cg.physicsTime = cg.snap->serverTime;
ADDRGP4 cg+107664
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 523
;523:	}
LABELV $358
line 525
;524:
;525:	if ( pmove_msec.integer < 8 ) {
ADDRGP4 pmove_msec+12
INDIRI4
CNSTI4 8
GEI4 $414
line 526
;526:		trap_Cvar_Set("pmove_msec", "8");
ADDRGP4 $417
ARGP4
ADDRGP4 $418
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 527
;527:	}
ADDRGP4 $415
JUMPV
LABELV $414
line 528
;528:	else if (pmove_msec.integer > 33) {
ADDRGP4 pmove_msec+12
INDIRI4
CNSTI4 33
LEI4 $419
line 529
;529:		trap_Cvar_Set("pmove_msec", "33");
ADDRGP4 $417
ARGP4
ADDRGP4 $422
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 530
;530:	}
LABELV $419
LABELV $415
line 532
;531:
;532:	cg_pmove.pmove_fixed = pmove_fixed.integer;// | cg_pmove_fixed.integer;
ADDRGP4 cg_pmove+248
ADDRGP4 pmove_fixed+12
INDIRI4
ASGNI4
line 533
;533:	cg_pmove.pmove_msec = pmove_msec.integer;
ADDRGP4 cg_pmove+252
ADDRGP4 pmove_msec+12
INDIRI4
ASGNI4
line 536
;534:
;535:	// run cmds
;536:	moved = qfalse;
ADDRLP4 476
CNSTI4 0
ASGNI4
line 537
;537:	for ( cmdNum = current - CMD_BACKUP + 1 ; cmdNum <= current ; cmdNum++ ) {
ADDRLP4 0
ADDRLP4 472
INDIRI4
CNSTI4 64
SUBI4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $430
JUMPV
LABELV $427
line 539
;538:		// get the command
;539:		trap_GetUserCmd( cmdNum, &cg_pmove.cmd );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 cg_pmove+4
ARGP4
ADDRGP4 trap_GetUserCmd
CALLI4
pop
line 541
;540:
;541:		if ( cg_pmove.pmove_fixed ) {
ADDRGP4 cg_pmove+248
INDIRI4
CNSTI4 0
EQI4 $432
line 542
;542:			PM_UpdateViewAngles( cg_pmove.ps, &cg_pmove.cmd );
ADDRGP4 cg_pmove
INDIRP4
ARGP4
ADDRGP4 cg_pmove+4
ARGP4
ADDRGP4 PM_UpdateViewAngles
CALLV
pop
line 543
;543:		}
LABELV $432
line 546
;544:
;545:		// don't do anything if the time is before the snapshot player time
;546:		if ( cg_pmove.cmd.serverTime <= cg.predictedPlayerState.commandTime ) {
ADDRGP4 cg_pmove+4
INDIRI4
ADDRGP4 cg+107688
INDIRI4
GTI4 $436
line 547
;547:			continue;
ADDRGP4 $428
JUMPV
LABELV $436
line 551
;548:		}
;549:
;550:		// don't do anything if the command was from a previous map_restart
;551:		if ( cg_pmove.cmd.serverTime > latestCmd.serverTime ) {
ADDRGP4 cg_pmove+4
INDIRI4
ADDRLP4 480
INDIRI4
LEI4 $440
line 552
;552:			continue;
ADDRGP4 $428
JUMPV
LABELV $440
line 560
;553:		}
;554:
;555:		// check for a prediction error from last frame
;556:		// on a lan, this will often be the exact value
;557:		// from the snapshot, but on a wan we will have
;558:		// to predict several commands to get to the point
;559:		// we want to compare
;560:		if ( cg.predictedPlayerState.commandTime == oldPlayerState.commandTime ) {
ADDRGP4 cg+107688
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $443
line 564
;561:			vec3_t	delta;
;562:			float	len;
;563:
;564:			if ( cg.thisFrameTeleport ) {
ADDRGP4 cg+107644
INDIRI4
CNSTI4 0
EQI4 $446
line 566
;565:				// a teleport will not cause an error decay
;566:				VectorClear( cg.predictedError );
ADDRLP4 560
CNSTF4 0
ASGNF4
ADDRGP4 cg+109044+8
ADDRLP4 560
INDIRF4
ASGNF4
ADDRGP4 cg+109044+4
ADDRLP4 560
INDIRF4
ASGNF4
ADDRGP4 cg+109044
ADDRLP4 560
INDIRF4
ASGNF4
line 567
;567:				if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $454
line 568
;568:					CG_Printf( "PredictionTeleport\n" );
ADDRGP4 $457
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 569
;569:				}
LABELV $454
line 570
;570:				cg.thisFrameTeleport = qfalse;
ADDRGP4 cg+107644
CNSTI4 0
ASGNI4
line 571
;571:			} else {
ADDRGP4 $447
JUMPV
LABELV $446
line 573
;572:				vec3_t	adjusted;
;573:				CG_AdjustPositionForMover( cg.predictedPlayerState.origin, 
ADDRGP4 cg+107688+20
ARGP4
ADDRGP4 cg+107688+68
INDIRI4
ARGI4
ADDRGP4 cg+107664
INDIRI4
ARGI4
ADDRGP4 cg+107660
INDIRI4
ARGI4
ADDRLP4 560
ARGP4
ADDRGP4 CG_AdjustPositionForMover
CALLV
pop
line 576
;574:					cg.predictedPlayerState.groundEntityNum, cg.physicsTime, cg.oldTime, adjusted );
;575:
;576:				if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $465
line 577
;577:					if (!VectorCompare( oldPlayerState.origin, adjusted )) {
ADDRLP4 4+20
ARGP4
ADDRLP4 560
ARGP4
ADDRLP4 572
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 572
INDIRI4
CNSTI4 0
NEI4 $468
line 578
;578:						CG_Printf("prediction error\n");
ADDRGP4 $471
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 579
;579:					}
LABELV $468
line 580
;580:				}
LABELV $465
line 581
;581:				VectorSubtract( oldPlayerState.origin, adjusted, delta );
ADDRLP4 544
ADDRLP4 4+20
INDIRF4
ADDRLP4 560
INDIRF4
SUBF4
ASGNF4
ADDRLP4 544+4
ADDRLP4 4+20+4
INDIRF4
ADDRLP4 560+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 544+8
ADDRLP4 4+20+8
INDIRF4
ADDRLP4 560+8
INDIRF4
SUBF4
ASGNF4
line 582
;582:				len = VectorLength( delta );
ADDRLP4 544
ARGP4
ADDRLP4 572
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 556
ADDRLP4 572
INDIRF4
ASGNF4
line 583
;583:				if ( len > 0.1 ) {
ADDRLP4 556
INDIRF4
CNSTF4 1036831949
LEF4 $481
line 584
;584:					if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $483
line 585
;585:						CG_Printf("Prediction miss: %f\n", len);
ADDRGP4 $486
ARGP4
ADDRLP4 556
INDIRF4
ARGF4
ADDRGP4 CG_Printf
CALLV
pop
line 586
;586:					}
LABELV $483
line 587
;587:					if ( cg_errorDecay.integer ) {
ADDRGP4 cg_errorDecay+12
INDIRI4
CNSTI4 0
EQI4 $487
line 591
;588:						int		t;
;589:						float	f;
;590:
;591:						t = cg.time - cg.predictedErrorTime;
ADDRLP4 580
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cg+109040
INDIRI4
SUBI4
ASGNI4
line 592
;592:						f = ( cg_errorDecay.value - t ) / cg_errorDecay.value;
ADDRLP4 576
ADDRGP4 cg_errorDecay+8
INDIRF4
ADDRLP4 580
INDIRI4
CVIF4 4
SUBF4
ADDRGP4 cg_errorDecay+8
INDIRF4
DIVF4
ASGNF4
line 593
;593:						if ( f < 0 ) {
ADDRLP4 576
INDIRF4
CNSTF4 0
GEF4 $494
line 594
;594:							f = 0;
ADDRLP4 576
CNSTF4 0
ASGNF4
line 595
;595:						}
LABELV $494
line 596
;596:						if ( f > 0 && cg_showmiss.integer ) {
ADDRLP4 576
INDIRF4
CNSTF4 0
LEF4 $496
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $496
line 597
;597:							CG_Printf("Double prediction decay: %f\n", f);
ADDRGP4 $499
ARGP4
ADDRLP4 576
INDIRF4
ARGF4
ADDRGP4 CG_Printf
CALLV
pop
line 598
;598:						}
LABELV $496
line 599
;599:						VectorScale( cg.predictedError, f, cg.predictedError );
ADDRGP4 cg+109044
ADDRGP4 cg+109044
INDIRF4
ADDRLP4 576
INDIRF4
MULF4
ASGNF4
ADDRGP4 cg+109044+4
ADDRGP4 cg+109044+4
INDIRF4
ADDRLP4 576
INDIRF4
MULF4
ASGNF4
ADDRGP4 cg+109044+8
ADDRGP4 cg+109044+8
INDIRF4
ADDRLP4 576
INDIRF4
MULF4
ASGNF4
line 600
;600:					} else {
ADDRGP4 $488
JUMPV
LABELV $487
line 601
;601:						VectorClear( cg.predictedError );
ADDRLP4 576
CNSTF4 0
ASGNF4
ADDRGP4 cg+109044+8
ADDRLP4 576
INDIRF4
ASGNF4
ADDRGP4 cg+109044+4
ADDRLP4 576
INDIRF4
ASGNF4
ADDRGP4 cg+109044
ADDRLP4 576
INDIRF4
ASGNF4
line 602
;602:					}
LABELV $488
line 603
;603:					VectorAdd( delta, cg.predictedError, cg.predictedError );
ADDRGP4 cg+109044
ADDRLP4 544
INDIRF4
ADDRGP4 cg+109044
INDIRF4
ADDF4
ASGNF4
ADDRGP4 cg+109044+4
ADDRLP4 544+4
INDIRF4
ADDRGP4 cg+109044+4
INDIRF4
ADDF4
ASGNF4
ADDRGP4 cg+109044+8
ADDRLP4 544+8
INDIRF4
ADDRGP4 cg+109044+8
INDIRF4
ADDF4
ASGNF4
line 604
;604:					cg.predictedErrorTime = cg.oldTime;
ADDRGP4 cg+109040
ADDRGP4 cg+107660
INDIRI4
ASGNI4
line 605
;605:				}
LABELV $481
line 606
;606:			}
LABELV $447
line 607
;607:		}
LABELV $443
line 611
;608:
;609:		// don't predict gauntlet firing, which is only supposed to happen
;610:		// when it actually inflicts damage
;611:		cg_pmove.gauntletHit = qfalse;
ADDRGP4 cg_pmove+40
CNSTI4 0
ASGNI4
line 613
;612:
;613:		if ( cg_pmove.pmove_fixed ) {
ADDRGP4 cg_pmove+248
INDIRI4
CNSTI4 0
EQI4 $530
line 614
;614:			cg_pmove.cmd.serverTime = ((cg_pmove.cmd.serverTime + pmove_msec.integer-1) / pmove_msec.integer) * pmove_msec.integer;
ADDRGP4 cg_pmove+4
ADDRGP4 cg_pmove+4
INDIRI4
ADDRGP4 pmove_msec+12
INDIRI4
ADDI4
CNSTI4 1
SUBI4
ADDRGP4 pmove_msec+12
INDIRI4
DIVI4
ADDRGP4 pmove_msec+12
INDIRI4
MULI4
ASGNI4
line 615
;615:		}
LABELV $530
line 618
;616:
;617:#if MONSTER_MODE	// JUHOX: set player scale factor for client
;618:		cg_pmove.scale = 1;
ADDRGP4 cg_pmove+68
CNSTF4 1065353216
ASGNF4
line 623
;619:#endif
;620:
;621:#if 1	// JUHOX: set target
;622:		if (
;623:			cg.predictedPlayerState.stats[STAT_TARGET] >= 0 &&
ADDRGP4 cg+107688+184+24
INDIRI4
CNSTI4 0
LTI4 $539
ADDRGP4 cg+107688+184+24
INDIRI4
CNSTI4 1022
GEI4 $539
line 625
;624:			cg.predictedPlayerState.stats[STAT_TARGET] < ENTITYNUM_MAX_NORMAL
;625:		) {
line 629
;626:			const centity_t* target;
;627:			float pos;
;628:
;629:			target = &cg_entities[cg.predictedPlayerState.stats[STAT_TARGET]];
ADDRLP4 544
ADDRGP4 cg+107688+184+24
INDIRI4
CNSTI4 880
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 630
;630:			BG_EvaluateTrajectory(&target->currentState.pos, cg.time, cg_pmove.target);
ADDRLP4 544
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 cg+107656
INDIRI4
ARGI4
ADDRGP4 cg_pmove+48
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 631
;631:			switch (cg.predictedPlayerState.weapon) {
ADDRLP4 552
ADDRGP4 cg+107688+144
INDIRI4
ASGNI4
ADDRLP4 552
INDIRI4
CNSTI4 1
EQI4 $556
ADDRLP4 552
INDIRI4
CNSTI4 1
LTI4 $552
LABELV $558
ADDRGP4 cg+107688+144
INDIRI4
CNSTI4 6
EQI4 $557
ADDRGP4 $552
JUMPV
LABELV $556
line 633
;632:			case WP_GAUNTLET:
;633:				pos = GAUNTLET_TARGET_POS;
ADDRLP4 548
CNSTF4 1061158912
ASGNF4
line 634
;634:				break;
ADDRGP4 $553
JUMPV
LABELV $557
line 636
;635:			case WP_LIGHTNING:
;636:				pos = LIGHTNING_TARGET_POS;
ADDRLP4 548
CNSTF4 1056964608
ASGNF4
line 637
;637:				break;
ADDRGP4 $553
JUMPV
LABELV $552
line 640
;638:			default:
;639:				// should not happen
;640:				pos = DEFAULT_TARGET_POS;
ADDRLP4 548
CNSTF4 1056964608
ASGNF4
line 641
;641:				break;
LABELV $553
line 643
;642:			}
;643:			cg_pmove.target[2] += BG_PlayerTargetOffset(&target->currentState, pos);
ADDRLP4 544
INDIRP4
ARGP4
ADDRLP4 548
INDIRF4
ARGF4
ADDRLP4 556
ADDRGP4 BG_PlayerTargetOffset
CALLF4
ASGNF4
ADDRLP4 560
ADDRGP4 cg_pmove+48+8
ASGNP4
ADDRLP4 560
INDIRP4
ADDRLP4 560
INDIRP4
INDIRF4
ADDRLP4 556
INDIRF4
ADDF4
ASGNF4
line 644
;644:		}
LABELV $539
line 649
;645:#endif
;646:
;647:#if MAPLENSFLARES	// JUHOX: lens flare editor movement
;648:		if (
;649:			cgs.editMode == EM_mlf &&
ADDRGP4 cgs+31684
INDIRI4
CNSTI4 1
NEI4 $561
ADDRGP4 cg+109660+256
INDIRI4
CNSTI4 0
NEI4 $561
line 651
;650:			cg.lfEditor.cmdMode == LFECM_main
;651:		) {
line 653
;652:			if (
;653:				!cg.lfEditor.selectedLFEnt &&
ADDRGP4 cg+109660
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $566
ADDRGP4 cg+109660+44
INDIRI4
CNSTI4 0
LTI4 $566
ADDRGP4 cg+109660+236
INDIRI4
ADDRGP4 cg+107656
INDIRI4
CNSTI4 100
SUBI4
GEI4 $566
ADDRGP4 cg+109660+232
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $566
ADDRGP4 cg_pmove+4+16
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $566
line 658
;654:				cg.lfEditor.markedLFEnt >= 0 &&
;655:				cg.lfEditor.lastClick < cg.time - 100 &&
;656:				(cg.lfEditor.oldButtons & BUTTON_ATTACK) == 0 &&
;657:				(cg_pmove.cmd.buttons & BUTTON_ATTACK)
;658:			) {
line 659
;659:				CG_SelectLFEnt(cg.lfEditor.markedLFEnt);
ADDRGP4 cg+109660+44
INDIRI4
ARGI4
ADDRGP4 CG_SelectLFEnt
CALLV
pop
line 660
;660:			}
ADDRGP4 $567
JUMPV
LABELV $566
line 662
;661:			else if (
;662:				cg.lfEditor.selectedLFEnt &&
ADDRGP4 cg+109660
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $580
ADDRGP4 cg+109660+8
INDIRI4
CNSTI4 0
NEI4 $580
ADDRGP4 cg+109660+236
INDIRI4
ADDRGP4 cg+107656
INDIRI4
CNSTI4 100
SUBI4
GEI4 $580
ADDRGP4 cg+109660+232
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $580
ADDRGP4 cg_pmove+4+16
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $580
line 667
;663:				cg.lfEditor.editMode == LFEEM_none &&
;664:				cg.lfEditor.lastClick < cg.time - 100 &&
;665:				(cg.lfEditor.oldButtons & BUTTON_ATTACK) == 0 &&
;666:				(cg_pmove.cmd.buttons & BUTTON_ATTACK)
;667:			) {
line 668
;668:				cg.lfEditor.selectedLFEnt = NULL;
ADDRGP4 cg+109660
CNSTP4 0
ASGNP4
line 669
;669:				CG_SetLFEdMoveMode(LFEMM_coarse);
CNSTI4 0
ARGI4
ADDRGP4 CG_SetLFEdMoveMode
CALLV
pop
line 670
;670:			}
LABELV $580
LABELV $567
line 673
;671:
;672:			if (
;673:				cg.lfEditor.editMode == LFEEM_pos &&
ADDRGP4 cg+109660+8
INDIRI4
CNSTI4 1
NEI4 $593
ADDRGP4 cg+109660+12
INDIRI4
CNSTI4 0
NEI4 $593
ADDRGP4 cg_pmove+4+16
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $593
line 676
;674:				cg.lfEditor.moveMode == LFEMM_coarse &&
;675:				(cg_pmove.cmd.buttons & BUTTON_ATTACK)
;676:			) {
line 677
;677:				CG_SetLFEdMoveMode(LFEMM_fine);
CNSTI4 1
ARGI4
ADDRGP4 CG_SetLFEdMoveMode
CALLV
pop
line 678
;678:			}
LABELV $593
line 681
;679:
;680:			if (
;681:				cg.lfEditor.editMode == LFEEM_pos &&
ADDRGP4 cg+109660+8
INDIRI4
CNSTI4 1
NEI4 $601
ADDRGP4 cg+109660+12
INDIRI4
CNSTI4 1
NEI4 $601
ADDRGP4 cg+109660
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $601
ADDRGP4 cg_pmove+4+16
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $601
line 685
;682:				cg.lfEditor.moveMode == LFEMM_fine &&
;683:				cg.lfEditor.selectedLFEnt &&
;684:				(cg_pmove.cmd.buttons & BUTTON_ATTACK)
;685:			) {
line 688
;686:				float move;
;687:
;688:				move = cg_pmove.cmd.forwardmove * (cg_pmove.cmd.serverTime - cg_pmove.ps->commandTime) / 2000.0;
ADDRLP4 544
ADDRGP4 cg_pmove+4+21
INDIRI1
CVII4 1
ADDRGP4 cg_pmove+4
INDIRI4
ADDRGP4 cg_pmove
INDIRP4
INDIRI4
SUBI4
MULI4
CVIF4 4
CNSTF4 973279855
MULF4
ASGNF4
line 689
;689:				cg.lfEditor.fmm_distance -= move;
ADDRLP4 548
ADDRGP4 cg+109660+20
ASGNP4
ADDRLP4 548
INDIRP4
ADDRLP4 548
INDIRP4
INDIRF4
ADDRLP4 544
INDIRF4
SUBF4
ASGNF4
line 690
;690:				if (cg.lfEditor.fmm_distance < 20) cg.lfEditor.fmm_distance = 20;
ADDRGP4 cg+109660+20
INDIRF4
CNSTF4 1101004800
GEF4 $615
ADDRGP4 cg+109660+20
CNSTF4 1101004800
ASGNF4
LABELV $615
line 691
;691:				if (cg.lfEditor.fmm_distance > 300) cg.lfEditor.fmm_distance = 300;
ADDRGP4 cg+109660+20
INDIRF4
CNSTF4 1133903872
LEF4 $621
ADDRGP4 cg+109660+20
CNSTF4 1133903872
ASGNF4
LABELV $621
line 693
;692:
;693:				move = cg_pmove.cmd.rightmove * (cg_pmove.cmd.serverTime - cg_pmove.ps->commandTime) / 8000.0;
ADDRLP4 544
ADDRGP4 cg_pmove+4+22
INDIRI1
CVII4 1
ADDRGP4 cg_pmove+4
INDIRI4
ADDRGP4 cg_pmove
INDIRP4
INDIRI4
SUBI4
MULI4
CVIF4 4
CNSTF4 956502639
MULF4
ASGNF4
line 694
;694:				cg.lfEditor.selectedLFEnt->radius += move;
ADDRLP4 552
ADDRGP4 cg+109660
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 552
INDIRP4
ADDRLP4 552
INDIRP4
INDIRF4
ADDRLP4 544
INDIRF4
ADDF4
ASGNF4
line 695
;695:				if (cg.lfEditor.selectedLFEnt->radius < 2.5) cg.lfEditor.selectedLFEnt->radius = 2.5;
ADDRGP4 cg+109660
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
CNSTF4 1075838976
GEF4 $631
ADDRGP4 cg+109660
INDIRP4
CNSTI4 16
ADDP4
CNSTF4 1075838976
ASGNF4
LABELV $631
line 696
;696:				if (cg.lfEditor.selectedLFEnt->radius > 100) cg.lfEditor.selectedLFEnt->radius = 100;
ADDRGP4 cg+109660
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
CNSTF4 1120403456
LEF4 $635
ADDRGP4 cg+109660
INDIRP4
CNSTI4 16
ADDP4
CNSTF4 1120403456
ASGNF4
LABELV $635
line 698
;697:
;698:				cg_pmove.cmd.forwardmove = 0;
ADDRGP4 cg_pmove+4+21
CNSTI1 0
ASGNI1
line 699
;699:				cg_pmove.cmd.rightmove = 0;
ADDRGP4 cg_pmove+4+22
CNSTI1 0
ASGNI1
line 700
;700:				cg_pmove.cmd.upmove = 0;
ADDRGP4 cg_pmove+4+23
CNSTI1 0
ASGNI1
line 701
;701:			}
LABELV $601
line 704
;702:
;703:			if (
;704:				cg.lfEditor.editMode == LFEEM_target &&
ADDRGP4 cg+109660+8
INDIRI4
CNSTI4 2
NEI4 $645
ADDRGP4 cg+109660+12
INDIRI4
CNSTI4 1
NEI4 $645
line 706
;705:				cg.lfEditor.moveMode == LFEMM_fine
;706:			) {
line 709
;707:				float move;
;708:
;709:				move = cg_pmove.cmd.forwardmove * (cg_pmove.cmd.serverTime - cg_pmove.ps->commandTime) / 2000.0;
ADDRLP4 544
ADDRGP4 cg_pmove+4+21
INDIRI1
CVII4 1
ADDRGP4 cg_pmove+4
INDIRI4
ADDRGP4 cg_pmove
INDIRP4
INDIRI4
SUBI4
MULI4
CVIF4 4
CNSTF4 973279855
MULF4
ASGNF4
line 710
;710:				cg.lfEditor.fmm_distance -= move;
ADDRLP4 548
ADDRGP4 cg+109660+20
ASGNP4
ADDRLP4 548
INDIRP4
ADDRLP4 548
INDIRP4
INDIRF4
ADDRLP4 544
INDIRF4
SUBF4
ASGNF4
line 711
;711:				if (cg.lfEditor.fmm_distance < 20) cg.lfEditor.fmm_distance = 20;
ADDRGP4 cg+109660+20
INDIRF4
CNSTF4 1101004800
GEF4 $656
ADDRGP4 cg+109660+20
CNSTF4 1101004800
ASGNF4
LABELV $656
line 712
;712:				if (cg.lfEditor.fmm_distance > 300) cg.lfEditor.fmm_distance = 300;
ADDRGP4 cg+109660+20
INDIRF4
CNSTF4 1133903872
LEF4 $662
ADDRGP4 cg+109660+20
CNSTF4 1133903872
ASGNF4
LABELV $662
line 714
;713:
;714:				cg_pmove.cmd.forwardmove = 0;
ADDRGP4 cg_pmove+4+21
CNSTI1 0
ASGNI1
line 715
;715:				cg_pmove.cmd.rightmove = 0;
ADDRGP4 cg_pmove+4+22
CNSTI1 0
ASGNI1
line 716
;716:				cg_pmove.cmd.upmove = 0;
ADDRGP4 cg_pmove+4+23
CNSTI1 0
ASGNI1
line 717
;717:			}
LABELV $645
line 720
;718:
;719:			if (
;720:				cg.lfEditor.selectedLFEnt &&
ADDRGP4 cg+109660
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $674
ADDRGP4 cg+109660+8
INDIRI4
CNSTI4 2
NEI4 $674
ADDRGP4 cg+109660+240
INDIRI4
CNSTI4 0
EQI4 $674
ADDRGP4 cg+109660+236
INDIRI4
ADDRGP4 cg+107656
INDIRI4
CNSTI4 100
SUBI4
GEI4 $674
ADDRGP4 cg+109660+232
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $674
ADDRGP4 cg_pmove+4+16
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $674
line 726
;721:				cg.lfEditor.editMode == LFEEM_target &&
;722:				cg.lfEditor.editTarget &&
;723:				cg.lfEditor.lastClick < cg.time - 100 &&
;724:				(cg.lfEditor.oldButtons & BUTTON_ATTACK) == 0 &&
;725:				(cg_pmove.cmd.buttons & BUTTON_ATTACK)
;726:			) {
line 729
;727:				vec3_t dir;
;728:
;729:				CG_LFEntOrigin(cg.lfEditor.selectedLFEnt, dir);
ADDRGP4 cg+109660
INDIRP4
ARGP4
ADDRLP4 544
ARGP4
ADDRGP4 CG_LFEntOrigin
CALLV
pop
line 730
;730:				VectorSubtract(cg.refdef.vieworg, dir, dir);
ADDRLP4 544
ADDRGP4 cg+109260+24
INDIRF4
ADDRLP4 544
INDIRF4
SUBF4
ASGNF4
ADDRLP4 544+4
ADDRGP4 cg+109260+24+4
INDIRF4
ADDRLP4 544+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 544+8
ADDRGP4 cg+109260+24+8
INDIRF4
ADDRLP4 544+8
INDIRF4
SUBF4
ASGNF4
line 731
;731:				if (VectorNormalize(dir) > 0.1) {
ADDRLP4 544
ARGP4
ADDRLP4 556
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 556
INDIRF4
CNSTF4 1036831949
LEF4 $701
line 732
;732:					VectorCopy(dir, cg.lfEditor.selectedLFEnt->dir);
ADDRGP4 cg+109660
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 544
INDIRB
ASGNB 12
line 733
;733:					CG_ComputeMaxVisAngle(cg.lfEditor.selectedLFEnt);
ADDRGP4 cg+109660
INDIRP4
ARGP4
ADDRGP4 CG_ComputeMaxVisAngle
CALLV
pop
line 734
;734:				}
LABELV $701
line 735
;735:				cg.lfEditor.editTarget = qfalse;
ADDRGP4 cg+109660+240
CNSTI4 0
ASGNI4
line 736
;736:				VectorCopy(cg.refdef.vieworg, cg.lfEditor.targetPosition);
ADDRGP4 cg+109660+244
ADDRGP4 cg+109260+24
INDIRB
ASGNB 12
line 737
;737:			}
ADDRGP4 $675
JUMPV
LABELV $674
line 739
;738:			else if (
;739:				cg.lfEditor.selectedLFEnt &&
ADDRGP4 cg+109660
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $711
ADDRGP4 cg+109660+8
INDIRI4
CNSTI4 2
NEI4 $711
ADDRGP4 cg+109660+240
INDIRI4
CNSTI4 0
NEI4 $711
ADDRGP4 cg+109660+236
INDIRI4
ADDRGP4 cg+107656
INDIRI4
CNSTI4 100
SUBI4
GEI4 $711
ADDRGP4 cg+109660+232
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $711
ADDRGP4 cg_pmove+4+16
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $711
line 745
;740:				cg.lfEditor.editMode == LFEEM_target &&
;741:				!cg.lfEditor.editTarget &&
;742:				cg.lfEditor.lastClick < cg.time - 100 &&
;743:				(cg.lfEditor.oldButtons & BUTTON_ATTACK) == 0 &&
;744:				(cg_pmove.cmd.buttons & BUTTON_ATTACK)
;745:			) {
line 746
;746:				if (Distance(cg.refdef.vieworg, cg.lfEditor.targetPosition) >= 1) {
ADDRGP4 cg+109260+24
ARGP4
ADDRGP4 cg+109660+244
ARGP4
ADDRLP4 544
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRLP4 544
INDIRF4
CNSTF4 1065353216
LTF4 $725
line 750
;747:					vec3_t origin;
;748:					vec3_t dir;
;749:
;750:					CG_LFEntOrigin(cg.lfEditor.selectedLFEnt, origin);
ADDRGP4 cg+109660
INDIRP4
ARGP4
ADDRLP4 560
ARGP4
ADDRGP4 CG_LFEntOrigin
CALLV
pop
line 751
;751:					VectorSubtract(cg.refdef.vieworg, origin, dir);
ADDRLP4 548
ADDRGP4 cg+109260+24
INDIRF4
ADDRLP4 560
INDIRF4
SUBF4
ASGNF4
ADDRLP4 548+4
ADDRGP4 cg+109260+24+4
INDIRF4
ADDRLP4 560+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 548+8
ADDRGP4 cg+109260+24+8
INDIRF4
ADDRLP4 560+8
INDIRF4
SUBF4
ASGNF4
line 752
;752:					if (VectorNormalize(dir) > 0.1) {
ADDRLP4 548
ARGP4
ADDRLP4 572
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 572
INDIRF4
CNSTF4 1036831949
LEF4 $726
line 753
;753:						cg.lfEditor.selectedLFEnt->angle = acos(DotProduct(dir, cg.lfEditor.selectedLFEnt->dir)) * (180.0 / M_PI);
ADDRLP4 548
INDIRF4
ADDRGP4 cg+109660
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
MULF4
ADDRLP4 548+4
INDIRF4
ADDRGP4 cg+109660
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 548+8
INDIRF4
ADDRGP4 cg+109660
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
MULF4
ADDF4
ARGF4
ADDRLP4 576
ADDRGP4 acos
CALLF4
ASGNF4
ADDRGP4 cg+109660
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 576
INDIRF4
CNSTF4 1113927393
MULF4
ASGNF4
line 754
;754:					}
line 755
;755:				}
ADDRGP4 $726
JUMPV
LABELV $725
line 756
;756:				else {
line 757
;757:					cg.lfEditor.selectedLFEnt->angle = -1;
ADDRGP4 cg+109660
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 3212836864
ASGNF4
line 758
;758:				}
LABELV $726
line 759
;759:				CG_ComputeMaxVisAngle(cg.lfEditor.selectedLFEnt);
ADDRGP4 cg+109660
INDIRP4
ARGP4
ADDRGP4 CG_ComputeMaxVisAngle
CALLV
pop
line 760
;760:				cg.lfEditor.editMode = LFEEM_none;
ADDRGP4 cg+109660+8
CNSTI4 0
ASGNI4
line 761
;761:				CG_SetLFEdMoveMode(LFEMM_coarse);
CNSTI4 0
ARGI4
ADDRGP4 CG_SetLFEdMoveMode
CALLV
pop
line 762
;762:			}
LABELV $711
LABELV $675
line 765
;763:
;764:			if (
;765:				cg.lfEditor.selectedLFEnt &&
ADDRGP4 cg+109660
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $756
ADDRGP4 cg+109660+8
INDIRI4
CNSTI4 3
NEI4 $756
line 767
;766:				cg.lfEditor.editMode == LFEEM_radius
;767:			) {
line 770
;768:				float move;
;769:				
;770:				if (cg_pmove.cmd.buttons & BUTTON_ATTACK) {
ADDRGP4 cg_pmove+4+16
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $761
line 771
;771:					move = cg_pmove.cmd.forwardmove * (cg_pmove.cmd.serverTime - cg_pmove.ps->commandTime) / 2000.0;
ADDRLP4 544
ADDRGP4 cg_pmove+4+21
INDIRI1
CVII4 1
ADDRGP4 cg_pmove+4
INDIRI4
ADDRGP4 cg_pmove
INDIRP4
INDIRI4
SUBI4
MULI4
CVIF4 4
CNSTF4 973279855
MULF4
ASGNF4
line 772
;772:					cg.lfEditor.fmm_distance -= move;
ADDRLP4 548
ADDRGP4 cg+109660+20
ASGNP4
ADDRLP4 548
INDIRP4
ADDRLP4 548
INDIRP4
INDIRF4
ADDRLP4 544
INDIRF4
SUBF4
ASGNF4
line 773
;773:					if (cg.lfEditor.fmm_distance < 20) cg.lfEditor.fmm_distance = 20;
ADDRGP4 cg+109660+20
INDIRF4
CNSTF4 1101004800
GEF4 $770
ADDRGP4 cg+109660+20
CNSTF4 1101004800
ASGNF4
LABELV $770
line 774
;774:					if (cg.lfEditor.fmm_distance > 300) cg.lfEditor.fmm_distance = 300;					
ADDRGP4 cg+109660+20
INDIRF4
CNSTF4 1133903872
LEF4 $762
ADDRGP4 cg+109660+20
CNSTF4 1133903872
ASGNF4
line 775
;775:				}
ADDRGP4 $762
JUMPV
LABELV $761
line 776
;776:				else {
line 777
;777:					move = cg_pmove.cmd.forwardmove * (cg_pmove.cmd.serverTime - cg_pmove.ps->commandTime) / 8000.0;
ADDRLP4 544
ADDRGP4 cg_pmove+4+21
INDIRI1
CVII4 1
ADDRGP4 cg_pmove+4
INDIRI4
ADDRGP4 cg_pmove
INDIRP4
INDIRI4
SUBI4
MULI4
CVIF4 4
CNSTF4 956502639
MULF4
ASGNF4
line 778
;778:					cg.lfEditor.selectedLFEnt->lightRadius += move;
ADDRLP4 548
ADDRGP4 cg+109660
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 548
INDIRP4
ADDRLP4 548
INDIRP4
INDIRF4
ADDRLP4 544
INDIRF4
ADDF4
ASGNF4
line 779
;779:					if (cg.lfEditor.selectedLFEnt->lightRadius < 2) {
ADDRGP4 cg+109660
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
CNSTF4 1073741824
GEF4 $786
line 780
;780:						if (move > 0) {
ADDRLP4 544
INDIRF4
CNSTF4 0
LEF4 $789
line 781
;781:							cg.lfEditor.selectedLFEnt->lightRadius = 2;
ADDRGP4 cg+109660
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 1073741824
ASGNF4
line 782
;782:						}
ADDRGP4 $790
JUMPV
LABELV $789
line 783
;783:						else {
line 784
;784:							cg.lfEditor.selectedLFEnt->lightRadius = 0.5;
ADDRGP4 cg+109660
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 1056964608
ASGNF4
line 785
;785:						}
LABELV $790
line 786
;786:					}
LABELV $786
line 787
;787:					if (cg.lfEditor.selectedLFEnt->lightRadius > cg.lfEditor.selectedLFEnt->radius) {
ADDRGP4 cg+109660
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRGP4 cg+109660
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
LEF4 $793
line 788
;788:						cg.lfEditor.selectedLFEnt->lightRadius = cg.lfEditor.selectedLFEnt->radius;
ADDRGP4 cg+109660
INDIRP4
CNSTI4 20
ADDP4
ADDRGP4 cg+109660
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ASGNF4
line 789
;789:					}
LABELV $793
line 791
;790:					
;791:					move = cg_pmove.cmd.rightmove * (cg_pmove.cmd.serverTime - cg_pmove.ps->commandTime) / 8000.0;
ADDRLP4 544
ADDRGP4 cg_pmove+4+22
INDIRI1
CVII4 1
ADDRGP4 cg_pmove+4
INDIRI4
ADDRGP4 cg_pmove
INDIRP4
INDIRI4
SUBI4
MULI4
CVIF4 4
CNSTF4 956502639
MULF4
ASGNF4
line 792
;792:					cg.lfEditor.selectedLFEnt->radius += move;
ADDRLP4 552
ADDRGP4 cg+109660
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 552
INDIRP4
ADDRLP4 552
INDIRP4
INDIRF4
ADDRLP4 544
INDIRF4
ADDF4
ASGNF4
line 793
;793:					if (cg.lfEditor.selectedLFEnt->radius < 2.5) cg.lfEditor.selectedLFEnt->radius = 2.5;
ADDRGP4 cg+109660
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
CNSTF4 1075838976
GEF4 $803
ADDRGP4 cg+109660
INDIRP4
CNSTI4 16
ADDP4
CNSTF4 1075838976
ASGNF4
LABELV $803
line 794
;794:					if (cg.lfEditor.selectedLFEnt->radius > 100) cg.lfEditor.selectedLFEnt->radius = 100;
ADDRGP4 cg+109660
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
CNSTF4 1120403456
LEF4 $807
ADDRGP4 cg+109660
INDIRP4
CNSTI4 16
ADDP4
CNSTF4 1120403456
ASGNF4
LABELV $807
line 795
;795:				}
LABELV $762
line 797
;796:
;797:				cg_pmove.cmd.forwardmove = 0;
ADDRGP4 cg_pmove+4+21
CNSTI1 0
ASGNI1
line 798
;798:				cg_pmove.cmd.rightmove = 0;
ADDRGP4 cg_pmove+4+22
CNSTI1 0
ASGNI1
line 799
;799:				cg_pmove.cmd.upmove = 0;
ADDRGP4 cg_pmove+4+23
CNSTI1 0
ASGNI1
line 800
;800:			}
LABELV $756
line 802
;801:
;802:			if (cg.lfEditor.oldButtons != cg_pmove.cmd.buttons) {
ADDRGP4 cg+109660+232
INDIRI4
ADDRGP4 cg_pmove+4+16
INDIRI4
EQI4 $817
line 803
;803:				cg.lfEditor.lastClick = cg.time;
ADDRGP4 cg+109660+236
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 804
;804:			}
LABELV $817
line 805
;805:			cg.lfEditor.oldButtons = cg_pmove.cmd.buttons;
ADDRGP4 cg+109660+232
ADDRGP4 cg_pmove+4+16
INDIRI4
ASGNI4
line 806
;806:		}
LABELV $561
line 809
;807:#endif
;808:
;809:		cg_pmove.gametype = cgs.gametype;	// JUHOX
ADDRGP4 cg_pmove+64
ADDRGP4 cgs+31456
INDIRI4
ASGNI4
line 811
;810:
;811:		Pmove (&cg_pmove);
ADDRGP4 cg_pmove
ARGP4
ADDRGP4 Pmove
CALLV
pop
line 813
;812:
;813:		moved = qtrue;
ADDRLP4 476
CNSTI4 1
ASGNI4
line 816
;814:
;815:		// add push trigger movement effects
;816:		CG_TouchTriggerPrediction();
ADDRGP4 CG_TouchTriggerPrediction
CALLV
pop
line 820
;817:
;818:		// check for predictable events that changed from previous predictions
;819:		//CG_CheckChangedPredictableEvents(&cg.predictedPlayerState);
;820:	}
LABELV $428
line 537
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $430
ADDRLP4 0
INDIRI4
ADDRLP4 472
INDIRI4
LEI4 $427
line 822
;821:
;822:	if ( cg_showmiss.integer > 1 ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 1
LEI4 $832
line 823
;823:		CG_Printf( "[%i : %i] ", cg_pmove.cmd.serverTime, cg.time );
ADDRGP4 $835
ARGP4
ADDRGP4 cg_pmove+4
INDIRI4
ARGI4
ADDRGP4 cg+107656
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 824
;824:	}
LABELV $832
line 826
;825:
;826:	if ( !moved ) {
ADDRLP4 476
INDIRI4
CNSTI4 0
NEI4 $838
line 827
;827:		if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $305
line 828
;828:			CG_Printf( "not moved\n" );
ADDRGP4 $843
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 829
;829:		}
line 830
;830:		return;
ADDRGP4 $305
JUMPV
LABELV $838
line 834
;831:	}
;832:
;833:	// adjust for the movement of the groundentity
;834:	CG_AdjustPositionForMover( cg.predictedPlayerState.origin, 
ADDRGP4 cg+107688+20
ARGP4
ADDRGP4 cg+107688+68
INDIRI4
ARGI4
ADDRGP4 cg+107664
INDIRI4
ARGI4
ADDRGP4 cg+107656
INDIRI4
ARGI4
ADDRGP4 cg+107688+20
ARGP4
ADDRGP4 CG_AdjustPositionForMover
CALLV
pop
line 838
;835:		cg.predictedPlayerState.groundEntityNum, 
;836:		cg.physicsTime, cg.time, cg.predictedPlayerState.origin );
;837:
;838:	if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $852
line 839
;839:		if (cg.predictedPlayerState.eventSequence > oldPlayerState.eventSequence + MAX_PS_EVENTS) {
ADDRGP4 cg+107688+108
INDIRI4
ADDRLP4 4+108
INDIRI4
CNSTI4 2
ADDI4
LEI4 $855
line 840
;840:			CG_Printf("WARNING: dropped event\n");
ADDRGP4 $860
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 841
;841:		}
LABELV $855
line 842
;842:	}
LABELV $852
line 845
;843:
;844:	// fire events and other transition triggered things
;845:	CG_TransitionPlayerState( &cg.predictedPlayerState, &oldPlayerState );
ADDRGP4 cg+107688
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 CG_TransitionPlayerState
CALLV
pop
line 847
;846:
;847:	if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $862
line 848
;848:		if (cg.eventSequence > cg.predictedPlayerState.eventSequence) {
ADDRGP4 cg+109056
INDIRI4
ADDRGP4 cg+107688+108
INDIRI4
LEI4 $865
line 849
;849:			CG_Printf("WARNING: double event\n");
ADDRGP4 $870
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 850
;850:			cg.eventSequence = cg.predictedPlayerState.eventSequence;
ADDRGP4 cg+109056
ADDRGP4 cg+107688+108
INDIRI4
ASGNI4
line 851
;851:		}
LABELV $865
line 852
;852:	}
LABELV $862
line 855
;853:
;854:#if 1	// JUHOX: make some results of the Pmove persistant
;855:	predictionSource->generic1 = cg.predictedPlayerState.generic1;
ADDRLP4 528
INDIRP4
CNSTI4 440
ADDP4
ADDRGP4 cg+107688+440
INDIRI4
ASGNI4
line 857
;856:#endif
;857:}
LABELV $305
endproc CG_PredictPlayerState 584 20
bss
align 4
LABELV cg_triggerEntities
skip 1024
align 4
LABELV cg_numTriggerEntities
skip 4
align 4
LABELV cg_solidEntities
skip 1024
align 4
LABELV cg_numSolidEntities
skip 4
align 4
LABELV cg_pmove
skip 264
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
import CG_LoadDeferredPlayers
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
LABELV $870
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 100
byte 1 111
byte 1 117
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $860
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $843
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $835
byte 1 91
byte 1 37
byte 1 105
byte 1 32
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 93
byte 1 32
byte 1 0
align 1
LABELV $499
byte 1 68
byte 1 111
byte 1 117
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 112
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 100
byte 1 101
byte 1 99
byte 1 97
byte 1 121
byte 1 58
byte 1 32
byte 1 37
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $486
byte 1 80
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $471
byte 1 112
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 10
byte 1 0
align 1
LABELV $457
byte 1 80
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 84
byte 1 101
byte 1 108
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $422
byte 1 51
byte 1 51
byte 1 0
align 1
LABELV $418
byte 1 56
byte 1 0
align 1
LABELV $417
byte 1 112
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 95
byte 1 109
byte 1 115
byte 1 101
byte 1 99
byte 1 0
align 1
LABELV $356
byte 1 101
byte 1 120
byte 1 99
byte 1 101
byte 1 101
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 80
byte 1 65
byte 1 67
byte 1 75
byte 1 69
byte 1 84
byte 1 95
byte 1 66
byte 1 65
byte 1 67
byte 1 75
byte 1 85
byte 1 80
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 115
byte 1 10
byte 1 0
