export trap_S_StartSound_fixed
code
proc trap_S_StartSound_fixed 16 16
file "..\..\..\..\code\cgame\cg_ents.c"
line 20
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_ents.c -- present snapshot entities, happens every single frame
;4:
;5:
;6://
;7:// JUHOX: sound fix for EFH
;8://
;9:// CAUTION: This must be done before including "cg_local.h"!
;10://
;11:#include "../game/q_shared.h"
;12:#include "tr_types.h"
;13:#include "../game/bg_public.h"
;14:#if ESCAPE_MODE
;15:vec3_t currentReference;
;16:void trap_S_StartSound(vec3_t origin, int entityNum, int entchannel, sfxHandle_t sfx);
;17:void trap_S_AddLoopingSound(int entityNum, const vec3_t origin, const vec3_t velocity, sfxHandle_t sfx);
;18:void trap_S_AddRealLoopingSound(int entityNum, const vec3_t origin, const vec3_t velocity, sfxHandle_t sfx);
;19:
;20:void trap_S_StartSound_fixed(vec3_t origin, int entityNum, int entchannel, sfxHandle_t sfx) {
line 21
;21:	if (origin) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $79
line 24
;22:		vec3_t worldOrigin;
;23:
;24:		VectorAdd(origin, currentReference, worldOrigin);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
INDIRF4
ADDRGP4 currentReference
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 currentReference+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 currentReference+8
INDIRF4
ADDF4
ASGNF4
line 25
;25:		trap_S_StartSound(worldOrigin, entityNum, entchannel, sfx);
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 26
;26:	}
ADDRGP4 $80
JUMPV
LABELV $79
line 27
;27:	else {
line 28
;28:		trap_S_StartSound(NULL, entityNum, entchannel, sfx);
CNSTP4 0
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 29
;29:	}
LABELV $80
line 30
;30:}
LABELV $78
endproc trap_S_StartSound_fixed 16 16
export trap_S_AddLoopingSound_fixed
proc trap_S_AddLoopingSound_fixed 16 16
line 32
;31:
;32:void trap_S_AddLoopingSound_fixed(int entityNum, const vec3_t origin, const vec3_t velocity, sfxHandle_t sfx) {
line 33
;33:	if (origin) {
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $86
line 36
;34:		vec3_t worldOrigin;
;35:
;36:		VectorAdd(origin, currentReference, worldOrigin);
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
INDIRF4
ADDRGP4 currentReference
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 currentReference+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 currentReference+8
INDIRF4
ADDF4
ASGNF4
line 37
;37:		trap_S_AddLoopingSound(entityNum, worldOrigin, velocity, sfx);
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 trap_S_AddLoopingSound
CALLV
pop
line 38
;38:	}
ADDRGP4 $87
JUMPV
LABELV $86
line 39
;39:	else {
line 40
;40:		trap_S_AddLoopingSound(entityNum, origin, velocity, sfx);
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 trap_S_AddLoopingSound
CALLV
pop
line 41
;41:	}
LABELV $87
line 42
;42:}
LABELV $85
endproc trap_S_AddLoopingSound_fixed 16 16
export trap_S_AddRealLoopingSound_fixed
proc trap_S_AddRealLoopingSound_fixed 16 16
line 44
;43:
;44:void trap_S_AddRealLoopingSound_fixed(int entityNum, const vec3_t origin, const vec3_t velocity, sfxHandle_t sfx) {
line 45
;45:	if (origin) {
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $93
line 48
;46:		vec3_t worldOrigin;
;47:
;48:		VectorAdd(origin, currentReference, worldOrigin);
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
INDIRF4
ADDRGP4 currentReference
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 currentReference+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 currentReference+8
INDIRF4
ADDF4
ASGNF4
line 49
;49:		trap_S_AddRealLoopingSound(entityNum, worldOrigin, velocity, sfx);
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 trap_S_AddRealLoopingSound
CALLV
pop
line 50
;50:	}
ADDRGP4 $94
JUMPV
LABELV $93
line 51
;51:	else {
line 52
;52:		trap_S_AddRealLoopingSound(entityNum, origin, velocity, sfx);
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 trap_S_AddRealLoopingSound
CALLV
pop
line 53
;53:	}
LABELV $94
line 54
;54:}
LABELV $92
endproc trap_S_AddRealLoopingSound_fixed 16 16
export CG_PositionEntityOnTag
proc CG_PositionEntityOnTag 80 24
line 84
;55:#endif
;56:
;57:#include "cg_local.h"
;58:
;59:
;60:// JUHOX: variables & definitions for EFH
;61:#if ESCAPE_MODE
;62:#define MAX_SORTED_MOVERS MAX_ENTITIES_IN_SNAPSHOT
;63:
;64:typedef struct {
;65:	centity_t* cent;
;66:	float distance;
;67:} sortedMover_t;
;68:
;69:static qboolean sortMovers;
;70:static int numSortedMovers;
;71:static sortedMover_t sortedMovers[MAX_SORTED_MOVERS];
;72:#endif
;73:
;74:
;75:/*
;76:======================
;77:CG_PositionEntityOnTag
;78:
;79:Modifies the entities position and axis by the given
;80:tag location
;81:======================
;82:*/
;83:void CG_PositionEntityOnTag( refEntity_t *entity, const refEntity_t *parent, 
;84:							qhandle_t parentModel, char *tagName ) {
line 89
;85:	int				i;
;86:	orientation_t	lerped;
;87:	
;88:	// lerp the tag
;89:	trap_R_LerpTag( &lerped, parentModel, parent->oldframe, parent->frame,
ADDRLP4 4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 52
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 96
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
ARGI4
CNSTF4 1065353216
ADDRLP4 52
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ARGF4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_R_LerpTag
CALLI4
pop
line 93
;90:		1.0 - parent->backlerp, tagName );
;91:
;92:	// FIXME: allow origin offsets along tag?
;93:	VectorCopy( parent->origin, entity->origin );
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRB
ASGNB 12
line 94
;94:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $147
line 95
;95:		VectorMA( entity->origin, lerped.origin[i], parent->axis[i], entity->origin );
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 56
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 72
ADDP4
ADDRLP4 64
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 76
ADDP4
ADDRLP4 72
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 96
;96:	}
LABELV $148
line 94
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $147
line 99
;97:
;98:	// had to cast away the const to avoid compiler problems...
;99:	MatrixMultiply( lerped.axis, ((refEntity_t *)parent)->axis, entity->axis );
ADDRLP4 4+12
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
ARGP4
ADDRGP4 MatrixMultiply
CALLV
pop
line 100
;100:	entity->backlerp = parent->backlerp;
ADDRFP4 0
INDIRP4
CNSTI4 100
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ASGNF4
line 101
;101:}
LABELV $146
endproc CG_PositionEntityOnTag 80 24
export CG_PositionRotatedEntityOnTag
proc CG_PositionRotatedEntityOnTag 116 24
line 113
;102:
;103:
;104:/*
;105:======================
;106:CG_PositionRotatedEntityOnTag
;107:
;108:Modifies the entities position and axis by the given
;109:tag location
;110:======================
;111:*/
;112:void CG_PositionRotatedEntityOnTag( refEntity_t *entity, const refEntity_t *parent, 
;113:							qhandle_t parentModel, char *tagName ) {
line 120
;114:	int				i;
;115:	orientation_t	lerped;
;116:	vec3_t			tempAxis[3];
;117:
;118://AxisClear( entity->axis );
;119:	// lerp the tag
;120:	trap_R_LerpTag( &lerped, parentModel, parent->oldframe, parent->frame,
ADDRLP4 4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 88
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 96
ADDP4
INDIRI4
ARGI4
ADDRLP4 88
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
ARGI4
CNSTF4 1065353216
ADDRLP4 88
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ARGF4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_R_LerpTag
CALLI4
pop
line 124
;121:		1.0 - parent->backlerp, tagName );
;122:
;123:	// FIXME: allow origin offsets along tag?
;124:	VectorCopy( parent->origin, entity->origin );
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRB
ASGNB 12
line 125
;125:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $153
line 126
;126:		VectorMA( entity->origin, lerped.origin[i], parent->axis[i], entity->origin );
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 92
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
CNSTI4 72
ADDP4
ADDRLP4 100
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 108
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 108
INDIRP4
CNSTI4 76
ADDP4
ADDRLP4 108
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 127
;127:	}
LABELV $154
line 125
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $153
line 130
;128:
;129:	// had to cast away the const to avoid compiler problems...
;130:	MatrixMultiply( entity->axis, lerped.axis, tempAxis );
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
ARGP4
ADDRLP4 4+12
ARGP4
ADDRLP4 52
ARGP4
ADDRGP4 MatrixMultiply
CALLV
pop
line 131
;131:	MatrixMultiply( tempAxis, ((refEntity_t *)parent)->axis, entity->axis );
ADDRLP4 52
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
ARGP4
ADDRGP4 MatrixMultiply
CALLV
pop
line 132
;132:}
LABELV $152
endproc CG_PositionRotatedEntityOnTag 116 24
export CG_SetEntitySoundPosition
proc CG_SetEntitySoundPosition 20 8
line 151
;133:
;134:
;135:
;136:/*
;137:==========================================================================
;138:
;139:FUNCTIONS CALLED EACH FRAME
;140:
;141:==========================================================================
;142:*/
;143:
;144:/*
;145:======================
;146:CG_SetEntitySoundPosition
;147:
;148:Also called by event processing code
;149:======================
;150:*/
;151:void CG_SetEntitySoundPosition( centity_t *cent ) {
line 167
;152:	// JUHOX: sound fix for EFH
;153:#if !ESCAPE_MODE
;154:	if ( cent->currentState.solid == SOLID_BMODEL ) {
;155:		vec3_t	origin;
;156:		float	*v;
;157:
;158:		v = cgs.inlineModelMidpoints[ cent->currentState.modelindex ];
;159:		VectorAdd( cent->lerpOrigin, v, origin );
;160:		trap_S_UpdateEntityPosition( cent->currentState.number, origin );
;161:	} else {
;162:		trap_S_UpdateEntityPosition( cent->currentState.number, cent->lerpOrigin );
;163:	}
;164:#else
;165:	vec3_t worldOrigin;
;166:
;167:	VectorAdd(cent->lerpOrigin, currentReference, worldOrigin);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
CNSTI4 728
ADDP4
INDIRF4
ADDRGP4 currentReference
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 12
INDIRP4
CNSTI4 732
ADDP4
INDIRF4
ADDRGP4 currentReference+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRF4
ADDRGP4 currentReference+8
INDIRF4
ADDF4
ASGNF4
line 168
;168:	if (cent->currentState.solid == SOLID_BMODEL) {
ADDRFP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 16777215
NEI4 $163
line 169
;169:		VectorAdd(worldOrigin, cgs.inlineModelMidpoints[cent->currentState.modelindex], worldOrigin);
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 cgs+38224
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 cgs+38224+4
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 cgs+38224+8
ADDP4
INDIRF4
ADDF4
ASGNF4
line 170
;170:	}
LABELV $163
line 171
;171:	trap_S_UpdateEntityPosition(cent->currentState.number, worldOrigin);
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_S_UpdateEntityPosition
CALLV
pop
line 173
;172:#endif
;173:}
LABELV $158
endproc CG_SetEntitySoundPosition 20 8
proc CG_EntityEffects 24 20
line 182
;174:
;175:/*
;176:==================
;177:CG_EntityEffects
;178:
;179:Add continuous entity effects, like local entity emission and lighting
;180:==================
;181:*/
;182:static void CG_EntityEffects( centity_t *cent ) {
line 185
;183:
;184:	// update sound origins
;185:	CG_SetEntitySoundPosition( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_SetEntitySoundPosition
CALLV
pop
line 188
;186:
;187:	// add loop sound
;188:	if ( cent->currentState.loopSound ) {
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRI4
CNSTI4 0
EQI4 $175
line 189
;189:		if (cent->currentState.eType != ET_SPEAKER) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 7
EQI4 $177
line 190
;190:			trap_S_AddLoopingSound( cent->currentState.number, cent->lerpOrigin, vec3_origin, 
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 728
ADDP4
ARGP4
ADDRGP4 vec3_origin
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+36172
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_AddLoopingSound_fixed
CALLV
pop
line 192
;191:				cgs.gameSounds[ cent->currentState.loopSound ] );
;192:		} else {
ADDRGP4 $178
JUMPV
LABELV $177
line 193
;193:			trap_S_AddRealLoopingSound( cent->currentState.number, cent->lerpOrigin, vec3_origin, 
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 728
ADDP4
ARGP4
ADDRGP4 vec3_origin
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+36172
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_AddRealLoopingSound_fixed
CALLV
pop
line 195
;194:				cgs.gameSounds[ cent->currentState.loopSound ] );
;195:		}
LABELV $178
line 196
;196:	}
LABELV $175
line 204
;197:
;198:
;199:	// constant light glow
;200:#if !ESCAPE_MODE	// JUHOX: no constantLight for ET_PLAYER in EFH
;201:	if ( cent->currentState.constantLight ) {
;202:#else
;203:	if (
;204:		cent->currentState.constantLight &&
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
INDIRI4
CNSTI4 0
EQI4 $181
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 1
EQI4 $181
line 206
;205:		cent->currentState.eType != ET_PLAYER
;206:	) {
line 211
;207:#endif
;208:		int		cl;
;209:		int		i, r, g, b;
;210:
;211:		cl = cent->currentState.constantLight;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
INDIRI4
ASGNI4
line 212
;212:		r = cl & 255;
ADDRLP4 12
ADDRLP4 4
INDIRI4
CNSTI4 255
BANDI4
ASGNI4
line 213
;213:		g = ( cl >> 8 ) & 255;
ADDRLP4 16
ADDRLP4 4
INDIRI4
CNSTI4 8
RSHI4
CNSTI4 255
BANDI4
ASGNI4
line 214
;214:		b = ( cl >> 16 ) & 255;
ADDRLP4 20
ADDRLP4 4
INDIRI4
CNSTI4 16
RSHI4
CNSTI4 255
BANDI4
ASGNI4
line 215
;215:		i = ( ( cl >> 24 ) & 255 ) * 4;
ADDRLP4 8
ADDRLP4 4
INDIRI4
CNSTI4 24
RSHI4
CNSTI4 255
BANDI4
CNSTI4 2
LSHI4
ASGNI4
line 216
;216:		trap_R_AddLightToScene( cent->lerpOrigin, i, r, g, b );
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
ARGP4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 217
;217:	}
LABELV $181
line 219
;218:
;219:}
LABELV $174
endproc CG_EntityEffects 24 20
proc CG_General 144 12
line 227
;220:
;221:
;222:/*
;223:==================
;224:CG_General
;225:==================
;226:*/
;227:static void CG_General( centity_t *cent ) {
line 231
;228:	refEntity_t			ent;
;229:	entityState_t		*s1;
;230:
;231:	s1 = &cent->currentState;
ADDRLP4 140
ADDRFP4 0
INDIRP4
ASGNP4
line 234
;232:
;233:	// if set to invisible, skip
;234:	if (!s1->modelindex) {
ADDRLP4 140
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 0
NEI4 $184
line 235
;235:		return;
ADDRGP4 $183
JUMPV
LABELV $184
line 238
;236:	}
;237:
;238:	memset (&ent, 0, sizeof(ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 242
;239:
;240:	// set frame
;241:
;242:	ent.frame = s1->frame;
ADDRLP4 0+80
ADDRLP4 140
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
ASGNI4
line 243
;243:	ent.oldframe = ent.frame;
ADDRLP4 0+96
ADDRLP4 0+80
INDIRI4
ASGNI4
line 244
;244:	ent.backlerp = 0;
ADDRLP4 0+100
CNSTF4 0
ASGNF4
line 246
;245:
;246:	VectorCopy( cent->lerpOrigin, ent.origin);
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
INDIRB
ASGNB 12
line 247
;247:	VectorCopy( cent->lerpOrigin, ent.oldorigin);
ADDRLP4 0+84
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
INDIRB
ASGNB 12
line 249
;248:
;249:	ent.hModel = cgs.gameModels[s1->modelindex];
ADDRLP4 0+8
ADDRLP4 140
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+35148
ADDP4
INDIRI4
ASGNI4
line 252
;250:
;251:	// player model
;252:	if (s1->number == cg.snap->ps.clientNum) {
ADDRLP4 140
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $194
line 253
;253:		ent.renderfx |= RF_THIRD_PERSON;	// only draw from mirrors
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 254
;254:	}
LABELV $194
line 257
;255:
;256:	// convert angles to axis
;257:	AnglesToAxis( cent->lerpAngles, ent.axis );
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 260
;258:
;259:	// add to refresh list
;260:	trap_R_AddRefEntityToScene (&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 261
;261:}
LABELV $183
endproc CG_General 144 12
proc CG_Speaker 12 16
line 270
;262:
;263:/*
;264:==================
;265:CG_Speaker
;266:
;267:Speaker entities can automatically play sounds
;268:==================
;269:*/
;270:static void CG_Speaker( centity_t *cent ) {
line 271
;271:	if ( ! cent->currentState.clientNum ) {	// FIXME: use something other than clientNum...
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 0
NEI4 $200
line 272
;272:		return;		// not auto triggering
ADDRGP4 $199
JUMPV
LABELV $200
line 275
;273:	}
;274:
;275:	if ( cg.time < cent->miscTime ) {
ADDRGP4 cg+107656
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
INDIRI4
GEI4 $202
line 276
;276:		return;
ADDRGP4 $199
JUMPV
LABELV $202
line 279
;277:	}
;278:
;279:	trap_S_StartSound (NULL, cent->currentState.number, CHAN_ITEM, cgs.gameSounds[cent->currentState.eventParm] );
CNSTP4 0
ARGP4
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 4
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
line 283
;280:
;281:	//	ent->s.frame = ent->wait * 10;
;282:	//	ent->s.clientNum = ent->random * 10;
;283:	cent->miscTime = cg.time + cent->currentState.frame * 100 + cent->currentState.clientNum * 100 * crandom();
ADDRLP4 4
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 444
ADDP4
ADDRGP4 cg+107656
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
CNSTI4 100
MULI4
ADDI4
CVIF4 4
ADDRLP4 8
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 100
MULI4
CVIF4 4
ADDRLP4 4
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 4
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 284
;284:}
LABELV $199
endproc CG_Speaker 12 16
proc CG_Item 264 16
line 292
;285:
;286:/*
;287:==================
;288:CG_Item
;289:==================
;290:*/
;291:#define PODMARKER_TIMERSIZE 10.0	// JUHOX
;292:static void CG_Item( centity_t *cent ) {
line 301
;293:	refEntity_t		ent;
;294:	entityState_t	*es;
;295:	gitem_t			*item;
;296:	int				msec;
;297:	float			frac;
;298:	float			scale;
;299:	weaponInfo_t	*wi;
;300:
;301:	es = &cent->currentState;
ADDRLP4 144
ADDRFP4 0
INDIRP4
ASGNP4
line 302
;302:	if ( es->modelindex >= bg_numItems ) {
ADDRLP4 144
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $208
line 303
;303:		CG_Error( "Bad item index %i on entity", es->modelindex );
ADDRGP4 $210
ARGP4
ADDRLP4 144
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 304
;304:	}
LABELV $208
line 307
;305:
;306:	// if set to invisible, skip
;307:	if ( !es->modelindex || ( es->eFlags & EF_NODRAW ) ) {
ADDRLP4 144
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 0
EQI4 $213
ADDRLP4 144
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $211
LABELV $213
line 308
;308:		return;
ADDRGP4 $207
JUMPV
LABELV $211
line 311
;309:	}
;310:
;311:	item = &bg_itemlist[ es->modelindex ];
ADDRLP4 140
ADDRLP4 144
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 317
;312:	// JUHOX: always draw the POD marker skull
;313:#if 0
;314:	if ( cg_simpleItems.integer && item->giType != IT_TEAM ) {
;315:#else
;316:	if (
;317:		cg_simpleItems.integer &&
ADDRGP4 cg_simpleItems+12
INDIRI4
CNSTI4 0
EQI4 $214
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
EQI4 $214
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 9
EQI4 $214
line 320
;318:		item->giType != IT_TEAM &&
;319:		item->giType != IT_POD_MARKER
;320:	) {
line 322
;321:#endif
;322:		memset( &ent, 0, sizeof( ent ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 323
;323:		ent.reType = RT_SPRITE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 324
;324:		VectorCopy( cent->lerpOrigin, ent.origin );
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
INDIRB
ASGNB 12
line 325
;325:		ent.radius = 14;
ADDRLP4 0+132
CNSTF4 1096810496
ASGNF4
line 326
;326:		ent.customShader = cg_items[es->modelindex].icon;
ADDRLP4 0+112
ADDRLP4 144
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 cg_items+20
ADDP4
INDIRI4
ASGNI4
line 327
;327:		ent.shaderRGBA[0] = 255;
ADDRLP4 0+116
CNSTU1 255
ASGNU1
line 328
;328:		ent.shaderRGBA[1] = 255;
ADDRLP4 0+116+1
CNSTU1 255
ASGNU1
line 329
;329:		ent.shaderRGBA[2] = 255;
ADDRLP4 0+116+2
CNSTU1 255
ASGNU1
line 330
;330:		ent.shaderRGBA[3] = 255;
ADDRLP4 0+116+3
CNSTU1 255
ASGNU1
line 331
;331:		trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 332
;332:		return;
ADDRGP4 $207
JUMPV
LABELV $214
line 341
;333:	}
;334:
;335:	// items bob up and down continuously
;336:	// JUHOX: no bobbing for armor fragments or POD markers
;337:#if 0
;338:	scale = 0.005 + cent->currentState.number * 0.00001;
;339:	cent->lerpOrigin[2] += 4 + cos( ( cg.time + 1000 ) *  scale ) * 4;
;340:#else
;341:	if (item->giType == IT_POD_MARKER) {
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 9
NEI4 $228
line 343
;342:		// no bobbing
;343:	}
ADDRGP4 $229
JUMPV
LABELV $228
line 344
;344:	else if (item->giType == IT_ARMOR && item->giTag) {
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 3
NEI4 $230
ADDRLP4 140
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 0
EQI4 $230
line 345
;345:		cent->lerpOrigin[2] -= /*16*/9;
ADDRLP4 176
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
ASGNP4
ADDRLP4 176
INDIRP4
ADDRLP4 176
INDIRP4
INDIRF4
CNSTF4 1091567616
SUBF4
ASGNF4
line 346
;346:	}
ADDRGP4 $231
JUMPV
LABELV $230
line 349
;347:#if ESCAPE_MODE
;348:	else if (
;349:		cgs.gametype == GT_EFH &&
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 9
NEI4 $232
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
NEI4 $232
ADDRLP4 140
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 8
NEI4 $232
line 352
;350:		item->giType == IT_TEAM &&
;351:		item->giTag == PW_BLUEFLAG
;352:	) {
line 354
;353:		// no bobbing
;354:	}
ADDRGP4 $233
JUMPV
LABELV $232
line 356
;355:#endif
;356:	else {
line 357
;357:		scale = 0.005 + cent->currentState.number * 0.00001;
ADDRLP4 160
ADDRFP4 0
INDIRP4
INDIRI4
CVIF4 4
CNSTF4 925353388
MULF4
CNSTF4 1000593162
ADDF4
ASGNF4
line 358
;358:		cent->lerpOrigin[2] += 4 + cos( ( cg.time + 1000 ) *  scale ) * 4;
ADDRGP4 cg+107656
INDIRI4
CNSTI4 1000
ADDI4
CVIF4 4
ADDRLP4 160
INDIRF4
MULF4
ARGF4
ADDRLP4 180
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 184
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
ASGNP4
ADDRLP4 184
INDIRP4
ADDRLP4 184
INDIRP4
INDIRF4
ADDRLP4 180
INDIRF4
CNSTF4 1082130432
MULF4
CNSTF4 1082130432
ADDF4
ADDF4
ASGNF4
line 359
;359:	}
LABELV $233
LABELV $231
LABELV $229
line 362
;360:#endif
;361:
;362:	memset (&ent, 0, sizeof(ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 375
;363:
;364:	// autorotate at one of two speeds
;365:	// JUHOX: no autorotation for armor fragments or POD markers
;366:#if 0
;367:	if ( item->giType == IT_HEALTH ) {
;368:		VectorCopy( cg.autoAnglesFast, cent->lerpAngles );
;369:		AxisCopy( cg.autoAxisFast, ent.axis );
;370:	} else {
;371:		VectorCopy( cg.autoAngles, cent->lerpAngles );
;372:		AxisCopy( cg.autoAxis, ent.axis );
;373:	}
;374:#else
;375:	if ( item->giType == IT_HEALTH ) {
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 4
NEI4 $236
line 376
;376:		VectorCopy( cg.autoAnglesFast, cent->lerpAngles );
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
ADDRGP4 cg+109212
INDIRB
ASGNB 12
line 377
;377:		AxisCopy( cg.autoAxisFast, ent.axis );
ADDRGP4 cg+109224
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 AxisCopy
CALLV
pop
line 378
;378:	}
ADDRGP4 $237
JUMPV
LABELV $236
line 379
;379:	else if (item->giType == IT_POD_MARKER) {
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 9
NEI4 $241
line 381
;380:		// no rotation
;381:		AnglesToAxis(cent->lerpAngles, ent.axis);
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 382
;382:	}
ADDRGP4 $242
JUMPV
LABELV $241
line 383
;383:	else if (item->giType == IT_ARMOR && item->giTag) {
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 3
NEI4 $244
ADDRLP4 140
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 0
EQI4 $244
line 385
;384:		// armor fragment
;385:		if (cent->currentState.apos.trType == TR_STATIONARY) {
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 0
NEI4 $246
line 390
;386:			// stopped
;387:			vec3_t angles;
;388:			vec3_t forward;
;389:
;390:			VectorCopy(cent->currentState.apos.trBase, ent.axis[0]);
ADDRLP4 0+28
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRB
ASGNB 12
line 391
;391:			angles[YAW] = cent->currentState.apos.trDelta[YAW];
ADDRLP4 184+4
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
ASGNF4
line 392
;392:			angles[PITCH] = 0;
ADDRLP4 184
CNSTF4 0
ASGNF4
line 393
;393:			angles[ROLL] = 0;
ADDRLP4 184+8
CNSTF4 0
ASGNF4
line 394
;394:			AngleVectors(angles, forward, NULL, NULL);
ADDRLP4 184
ARGP4
ADDRLP4 196
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 395
;395:			CrossProduct(ent.axis[0], forward, ent.axis[1]);
ADDRLP4 0+28
ARGP4
ADDRLP4 196
ARGP4
ADDRLP4 0+28+12
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 396
;396:			VectorNegate(ent.axis[1], ent.axis[1]);
ADDRLP4 0+28+12
ADDRLP4 0+28+12
INDIRF4
NEGF4
ASGNF4
ADDRLP4 0+28+12+4
ADDRLP4 0+28+12+4
INDIRF4
NEGF4
ASGNF4
ADDRLP4 0+28+12+8
ADDRLP4 0+28+12+8
INDIRF4
NEGF4
ASGNF4
line 397
;397:			CrossProduct(ent.axis[0], ent.axis[1], ent.axis[2]);
ADDRLP4 0+28
ARGP4
ADDRLP4 0+28+12
ARGP4
ADDRLP4 0+28+24
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 398
;398:		}
ADDRGP4 $247
JUMPV
LABELV $246
line 399
;399:		else {
line 401
;400:			// falling
;401:			AnglesToAxis(cent->lerpAngles, ent.axis);
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 402
;402:		}
LABELV $247
line 403
;403:		ent.shaderTime = cg.time / 1000.0;	// no hull
ADDRLP4 0+128
ADDRGP4 cg+107656
INDIRI4
CVIF4 4
CNSTF4 981668463
MULF4
ASGNF4
line 404
;404:	}
ADDRGP4 $245
JUMPV
LABELV $244
line 407
;405:#if ESCAPE_MODE
;406:	else if (
;407:		cgs.gametype == GT_EFH &&
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 9
NEI4 $278
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
NEI4 $278
ADDRLP4 140
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 8
NEI4 $278
line 410
;408:		item->giType == IT_TEAM &&
;409:		item->giTag == PW_BLUEFLAG
;410:	) {
line 412
;411:		// no rotation
;412:		AnglesToAxis(cent->currentState.angles, ent.axis);
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 413
;413:	}
ADDRGP4 $279
JUMPV
LABELV $278
line 415
;414:#endif
;415:	else {
line 416
;416:		VectorCopy( cg.autoAngles, cent->lerpAngles );
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
ADDRGP4 cg+109164
INDIRB
ASGNB 12
line 417
;417:		AxisCopy( cg.autoAxis, ent.axis );
ADDRGP4 cg+109176
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 AxisCopy
CALLV
pop
line 418
;418:	}
LABELV $279
LABELV $245
LABELV $242
LABELV $237
line 421
;419:#endif
;420:
;421:	wi = NULL;
ADDRLP4 152
CNSTP4 0
ASGNP4
line 425
;422:	// the weapons have their origin where they attatch to player
;423:	// models, so we need to offset them or they will rotate
;424:	// eccentricly
;425:	if ( item->giType == IT_WEAPON ) {
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 1
NEI4 $285
line 426
;426:		wi = &cg_weapons[item->giTag];
ADDRLP4 152
ADDRLP4 140
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 136
MULI4
ADDRGP4 cg_weapons
ADDP4
ASGNP4
line 427
;427:		cent->lerpOrigin[0] -= 
ADDRLP4 188
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
ASGNP4
ADDRLP4 188
INDIRP4
ADDRLP4 188
INDIRP4
INDIRF4
ADDRLP4 152
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 0+28
INDIRF4
MULF4
ADDRLP4 152
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 0+28+12
INDIRF4
MULF4
ADDF4
ADDRLP4 152
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 0+28+24
INDIRF4
MULF4
ADDF4
SUBF4
ASGNF4
line 431
;428:			wi->weaponMidpoint[0] * ent.axis[0][0] +
;429:			wi->weaponMidpoint[1] * ent.axis[1][0] +
;430:			wi->weaponMidpoint[2] * ent.axis[2][0];
;431:		cent->lerpOrigin[1] -= 
ADDRLP4 196
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
ASGNP4
ADDRLP4 196
INDIRP4
ADDRLP4 196
INDIRP4
INDIRF4
ADDRLP4 152
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 0+28+4
INDIRF4
MULF4
ADDRLP4 152
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 0+28+12+4
INDIRF4
MULF4
ADDF4
ADDRLP4 152
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 0+28+24+4
INDIRF4
MULF4
ADDF4
SUBF4
ASGNF4
line 435
;432:			wi->weaponMidpoint[0] * ent.axis[0][1] +
;433:			wi->weaponMidpoint[1] * ent.axis[1][1] +
;434:			wi->weaponMidpoint[2] * ent.axis[2][1];
;435:		cent->lerpOrigin[2] -= 
ADDRLP4 204
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
ASGNP4
ADDRLP4 204
INDIRP4
ADDRLP4 204
INDIRP4
INDIRF4
ADDRLP4 152
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 0+28+8
INDIRF4
MULF4
ADDRLP4 152
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 0+28+12+8
INDIRF4
MULF4
ADDF4
ADDRLP4 152
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 0+28+24+8
INDIRF4
MULF4
ADDF4
SUBF4
ASGNF4
line 440
;436:			wi->weaponMidpoint[0] * ent.axis[0][2] +
;437:			wi->weaponMidpoint[1] * ent.axis[1][2] +
;438:			wi->weaponMidpoint[2] * ent.axis[2][2];
;439:
;440:		cent->lerpOrigin[2] += 8;	// an extra height boost
ADDRLP4 212
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
ASGNP4
ADDRLP4 212
INDIRP4
ADDRLP4 212
INDIRP4
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 441
;441:	}
LABELV $285
line 444
;442:	// JUHOX: offset armor fragments for correct rotating
;443:#if 1
;444:	if (item->giType == IT_ARMOR && item->giTag) {
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 3
NEI4 $308
ADDRLP4 140
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 0
EQI4 $308
line 447
;445:		float* midpoint;
;446:
;447:		if (item->quantity == 5) {
ADDRLP4 140
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 5
NEI4 $310
line 448
;448:			midpoint = cgs.smallArmorFragmentMidpoint;
ADDRLP4 192
ADDRGP4 cgs+41296
ASGNP4
line 449
;449:		}
ADDRGP4 $311
JUMPV
LABELV $310
line 450
;450:		else {
line 451
;451:			midpoint = cgs.largeArmorFragmentMidpoint;
ADDRLP4 192
ADDRGP4 cgs+41308
ASGNP4
line 452
;452:		}
LABELV $311
line 453
;453:		cent->lerpOrigin[0] -= 
ADDRLP4 196
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
ASGNP4
ADDRLP4 196
INDIRP4
ADDRLP4 196
INDIRP4
INDIRF4
ADDRLP4 192
INDIRP4
INDIRF4
ADDRLP4 0+28
INDIRF4
MULF4
ADDRLP4 192
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0+28+12
INDIRF4
MULF4
ADDF4
ADDRLP4 192
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0+28+24
INDIRF4
MULF4
ADDF4
SUBF4
ASGNF4
line 457
;454:			midpoint[0] * ent.axis[0][0] +
;455:			midpoint[1] * ent.axis[1][0] +
;456:			midpoint[2] * ent.axis[2][0];
;457:		cent->lerpOrigin[1] -= 
ADDRLP4 204
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
ASGNP4
ADDRLP4 204
INDIRP4
ADDRLP4 204
INDIRP4
INDIRF4
ADDRLP4 192
INDIRP4
INDIRF4
ADDRLP4 0+28+4
INDIRF4
MULF4
ADDRLP4 192
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0+28+12+4
INDIRF4
MULF4
ADDF4
ADDRLP4 192
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0+28+24+4
INDIRF4
MULF4
ADDF4
SUBF4
ASGNF4
line 461
;458:			midpoint[0] * ent.axis[0][1] +
;459:			midpoint[1] * ent.axis[1][1] +
;460:			midpoint[2] * ent.axis[2][1];
;461:		cent->lerpOrigin[2] -= 
ADDRLP4 212
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
ASGNP4
ADDRLP4 212
INDIRP4
ADDRLP4 212
INDIRP4
INDIRF4
ADDRLP4 192
INDIRP4
INDIRF4
ADDRLP4 0+28+8
INDIRF4
MULF4
ADDRLP4 192
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0+28+12+8
INDIRF4
MULF4
ADDF4
ADDRLP4 192
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0+28+24+8
INDIRF4
MULF4
ADDF4
SUBF4
ASGNF4
line 465
;462:			midpoint[0] * ent.axis[0][2] +
;463:			midpoint[1] * ent.axis[1][2] +
;464:			midpoint[2] * ent.axis[2][2];
;465:	}
LABELV $308
line 469
;466:#endif
;467:
;468:
;469:	ent.hModel = cg_items[es->modelindex].models[0];
ADDRLP4 0+8
ADDRLP4 144
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 cg_items+4
ADDP4
INDIRI4
ASGNI4
line 471
;470:
;471:	VectorCopy( cent->lerpOrigin, ent.origin);
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
INDIRB
ASGNB 12
line 472
;472:	VectorCopy( cent->lerpOrigin, ent.oldorigin);
ADDRLP4 0+84
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
INDIRB
ASGNB 12
line 474
;473:
;474:	ent.nonNormalizedAxes = qfalse;
ADDRLP4 0+64
CNSTI4 0
ASGNI4
line 477
;475:
;476:	// if just respawned, slowly scale up
;477:	msec = cg.time - cent->miscTime;
ADDRLP4 156
ADDRGP4 cg+107656
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
INDIRI4
SUBI4
ASGNI4
line 480
;478:	// JUHOX: armor fragments don't scale up and large armor fragment is bigger
;479:#if 1
;480:	if (item->giType == IT_ARMOR && item->giTag) {
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 3
NEI4 $341
ADDRLP4 140
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 0
EQI4 $341
line 481
;481:		frac = 1.0;
ADDRLP4 148
CNSTF4 1065353216
ASGNF4
line 482
;482:		if (item->quantity == 25) {
ADDRLP4 140
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 25
NEI4 $342
line 483
;483:			frac = 1.5;
ADDRLP4 148
CNSTF4 1069547520
ASGNF4
line 484
;484:			VectorScale( ent.axis[0], frac, ent.axis[0] );
ADDRLP4 0+28
ADDRLP4 0+28
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+4
ADDRLP4 0+28+4
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+8
ADDRLP4 0+28+8
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
line 485
;485:			VectorScale( ent.axis[1], frac, ent.axis[1] );
ADDRLP4 0+28+12
ADDRLP4 0+28+12
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+12+4
ADDRLP4 0+28+12+4
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+12+8
ADDRLP4 0+28+12+8
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
line 486
;486:			VectorScale( ent.axis[2], frac, ent.axis[2] );
ADDRLP4 0+28+24
ADDRLP4 0+28+24
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+24+4
ADDRLP4 0+28+24+4
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+24+8
ADDRLP4 0+28+24+8
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
line 487
;487:			ent.nonNormalizedAxes = qtrue;
ADDRLP4 0+64
CNSTI4 1
ASGNI4
line 488
;488:		}
line 489
;489:	}
ADDRGP4 $342
JUMPV
LABELV $341
line 490
;490:	else if (item->giType == IT_POD_MARKER) {
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 9
NEI4 $388
line 491
;491:		frac = 3.0;
ADDRLP4 148
CNSTF4 1077936128
ASGNF4
line 492
;492:		VectorScale( ent.axis[0], frac, ent.axis[0] );
ADDRLP4 0+28
ADDRLP4 0+28
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+4
ADDRLP4 0+28+4
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+8
ADDRLP4 0+28+8
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
line 493
;493:		VectorScale( ent.axis[1], frac, ent.axis[1] );
ADDRLP4 0+28+12
ADDRLP4 0+28+12
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+12+4
ADDRLP4 0+28+12+4
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+12+8
ADDRLP4 0+28+12+8
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
line 494
;494:		VectorScale( ent.axis[2], frac, ent.axis[2] );
ADDRLP4 0+28+24
ADDRLP4 0+28+24
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+24+4
ADDRLP4 0+28+24+4
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+24+8
ADDRLP4 0+28+24+8
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
line 495
;495:		ent.nonNormalizedAxes = qtrue;
ADDRLP4 0+64
CNSTI4 1
ASGNI4
line 496
;496:		ent.customSkin = cgs.media.podSkullSkin;
ADDRLP4 0+108
ADDRGP4 cgs+751220+356
INDIRI4
ASGNI4
line 497
;497:	}
ADDRGP4 $389
JUMPV
LABELV $388
line 500
;498:	else
;499:#endif
;500:	if ( msec >= 0 && msec < ITEM_SCALEUP_TIME ) {
ADDRLP4 196
ADDRLP4 156
INDIRI4
ASGNI4
ADDRLP4 196
INDIRI4
CNSTI4 0
LTI4 $436
ADDRLP4 196
INDIRI4
CNSTI4 1000
GEI4 $436
line 501
;501:		frac = (float)msec / ITEM_SCALEUP_TIME;
ADDRLP4 148
ADDRLP4 156
INDIRI4
CVIF4 4
CNSTF4 981668463
MULF4
ASGNF4
line 502
;502:		VectorScale( ent.axis[0], frac, ent.axis[0] );
ADDRLP4 0+28
ADDRLP4 0+28
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+4
ADDRLP4 0+28+4
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+8
ADDRLP4 0+28+8
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
line 503
;503:		VectorScale( ent.axis[1], frac, ent.axis[1] );
ADDRLP4 0+28+12
ADDRLP4 0+28+12
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+12+4
ADDRLP4 0+28+12+4
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+12+8
ADDRLP4 0+28+12+8
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
line 504
;504:		VectorScale( ent.axis[2], frac, ent.axis[2] );
ADDRLP4 0+28+24
ADDRLP4 0+28+24
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+24+4
ADDRLP4 0+28+24+4
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+24+8
ADDRLP4 0+28+24+8
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
line 505
;505:		ent.nonNormalizedAxes = qtrue;
ADDRLP4 0+64
CNSTI4 1
ASGNI4
line 506
;506:	} else {
ADDRGP4 $437
JUMPV
LABELV $436
line 507
;507:		frac = 1.0;
ADDRLP4 148
CNSTF4 1065353216
ASGNF4
line 508
;508:	}
LABELV $437
LABELV $389
LABELV $342
line 512
;509:
;510:	// items without glow textures need to keep a minimum light value
;511:	// so they are always visible
;512:	if ( ( item->giType == IT_WEAPON ) ||
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 1
EQI4 $484
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 9
EQI4 $484
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 3
NEI4 $481
LABELV $484
line 514
;513:		 ( item->giType == IT_POD_MARKER ) ||	// JUHOX: minlight for POD markers
;514:		 ( item->giType == IT_ARMOR ) ) {
line 515
;515:		ent.renderfx |= RF_MINLIGHT;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 516
;516:	}
LABELV $481
line 519
;517:
;518:	// increase the size of the weapons when they are presented as items
;519:	if ( item->giType == IT_WEAPON ) {
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 1
NEI4 $486
line 520
;520:		VectorScale( ent.axis[0], 1.5, ent.axis[0] );
ADDRLP4 0+28
ADDRLP4 0+28
INDIRF4
CNSTF4 1069547520
MULF4
ASGNF4
ADDRLP4 0+28+4
ADDRLP4 0+28+4
INDIRF4
CNSTF4 1069547520
MULF4
ASGNF4
ADDRLP4 0+28+8
ADDRLP4 0+28+8
INDIRF4
CNSTF4 1069547520
MULF4
ASGNF4
line 521
;521:		VectorScale( ent.axis[1], 1.5, ent.axis[1] );
ADDRLP4 0+28+12
ADDRLP4 0+28+12
INDIRF4
CNSTF4 1069547520
MULF4
ASGNF4
ADDRLP4 0+28+12+4
ADDRLP4 0+28+12+4
INDIRF4
CNSTF4 1069547520
MULF4
ASGNF4
ADDRLP4 0+28+12+8
ADDRLP4 0+28+12+8
INDIRF4
CNSTF4 1069547520
MULF4
ASGNF4
line 522
;522:		VectorScale( ent.axis[2], 1.5, ent.axis[2] );
ADDRLP4 0+28+24
ADDRLP4 0+28+24
INDIRF4
CNSTF4 1069547520
MULF4
ASGNF4
ADDRLP4 0+28+24+4
ADDRLP4 0+28+24+4
INDIRF4
CNSTF4 1069547520
MULF4
ASGNF4
ADDRLP4 0+28+24+8
ADDRLP4 0+28+24+8
INDIRF4
CNSTF4 1069547520
MULF4
ASGNF4
line 523
;523:		ent.nonNormalizedAxes = qtrue;
ADDRLP4 0+64
CNSTI4 1
ASGNI4
line 527
;524:#ifdef MISSIONPACK
;525:		trap_S_AddLoopingSound( cent->currentState.number, cent->lerpOrigin, vec3_origin, cgs.media.weaponHoverSound );
;526:#endif
;527:	}
LABELV $486
line 540
;528:
;529:#ifdef MISSIONPACK
;530:	if ( item->giType == IT_HOLDABLE && item->giTag == HI_KAMIKAZE ) {
;531:		VectorScale( ent.axis[0], 2, ent.axis[0] );
;532:		VectorScale( ent.axis[1], 2, ent.axis[1] );
;533:		VectorScale( ent.axis[2], 2, ent.axis[2] );
;534:		ent.nonNormalizedAxes = qtrue;
;535:	}
;536:#endif
;537:
;538:	// JUHOX: set corrected light origin for EFH
;539:#if ESCAPE_MODE
;540:	if (cgs.gametype == GT_EFH) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 9
NEI4 $531
line 541
;541:		ent.renderfx |= RF_LIGHTING_ORIGIN;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 542
;542:		VectorCopy(es->angles2, ent.lightingOrigin);
ADDRLP4 0+12
ADDRLP4 144
INDIRP4
CNSTI4 128
ADDP4
INDIRB
ASGNB 12
line 543
;543:	}
LABELV $531
line 547
;544:#endif
;545:
;546:	// add to refresh list
;547:	trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 571
;548:
;549:#ifdef MISSIONPACK
;550:	if ( item->giType == IT_WEAPON && wi->barrelModel ) {
;551:		refEntity_t	barrel;
;552:
;553:		memset( &barrel, 0, sizeof( barrel ) );
;554:
;555:		barrel.hModel = wi->barrelModel;
;556:
;557:		VectorCopy( ent.lightingOrigin, barrel.lightingOrigin );
;558:		barrel.shadowPlane = ent.shadowPlane;
;559:		barrel.renderfx = ent.renderfx;
;560:
;561:		CG_PositionRotatedEntityOnTag( &barrel, &ent, wi->weaponModel, "tag_barrel" );
;562:
;563:		AxisCopy( ent.axis, barrel.axis );
;564:		barrel.nonNormalizedAxes = ent.nonNormalizedAxes;
;565:
;566:		trap_R_AddRefEntityToScene( &barrel );
;567:	}
;568:#endif
;569:
;570:	// accompanying rings / spheres for powerups
;571:	if ( !cg_simpleItems.integer ) 
ADDRGP4 cg_simpleItems+12
INDIRI4
CNSTI4 0
NEI4 $536
line 572
;572:	{
line 575
;573:		vec3_t spinAngles;
;574:
;575:		VectorClear( spinAngles );
ADDRLP4 216
CNSTF4 0
ASGNF4
ADDRLP4 204+8
ADDRLP4 216
INDIRF4
ASGNF4
ADDRLP4 204+4
ADDRLP4 216
INDIRF4
ASGNF4
ADDRLP4 204
ADDRLP4 216
INDIRF4
ASGNF4
line 577
;576:
;577:		if ( item->giType == IT_HEALTH || item->giType == IT_POWERUP )
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 4
EQI4 $543
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 5
NEI4 $541
LABELV $543
line 578
;578:		{
line 579
;579:			if ( ( ent.hModel = cg_items[es->modelindex].models[1] ) != 0 )
ADDRLP4 224
ADDRLP4 144
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 cg_items+4+4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0+8
ADDRLP4 224
INDIRI4
ASGNI4
ADDRLP4 224
INDIRI4
CNSTI4 0
EQI4 $544
line 580
;580:			{
line 581
;581:				if ( item->giType == IT_POWERUP )
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 5
NEI4 $549
line 582
;582:				{
line 583
;583:					ent.origin[2] += 12;
ADDRLP4 0+68+8
ADDRLP4 0+68+8
INDIRF4
CNSTF4 1094713344
ADDF4
ASGNF4
line 584
;584:					spinAngles[1] = ( cg.time & 1023 ) * 360 / -1024.0f;
ADDRLP4 204+4
ADDRGP4 cg+107656
INDIRI4
CNSTI4 1023
BANDI4
CNSTI4 360
MULI4
CVIF4 4
CNSTF4 3128950784
MULF4
ASGNF4
line 585
;585:				}
LABELV $549
line 586
;586:				AnglesToAxis( spinAngles, ent.axis );
ADDRLP4 204
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 589
;587:				
;588:				// scale up if respawning
;589:				if ( frac != 1.0 ) {
ADDRLP4 148
INDIRF4
CNSTF4 1065353216
EQF4 $556
line 590
;590:					VectorScale( ent.axis[0], frac, ent.axis[0] );
ADDRLP4 0+28
ADDRLP4 0+28
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+4
ADDRLP4 0+28+4
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+8
ADDRLP4 0+28+8
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
line 591
;591:					VectorScale( ent.axis[1], frac, ent.axis[1] );
ADDRLP4 0+28+12
ADDRLP4 0+28+12
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+12+4
ADDRLP4 0+28+12+4
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+12+8
ADDRLP4 0+28+12+8
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
line 592
;592:					VectorScale( ent.axis[2], frac, ent.axis[2] );
ADDRLP4 0+28+24
ADDRLP4 0+28+24
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+24+4
ADDRLP4 0+28+24+4
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+24+8
ADDRLP4 0+28+24+8
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
line 593
;593:					ent.nonNormalizedAxes = qtrue;
ADDRLP4 0+64
CNSTI4 1
ASGNI4
line 594
;594:				}
LABELV $556
line 595
;595:				trap_R_AddRefEntityToScene( &ent );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 596
;596:			}
LABELV $544
line 597
;597:		}
LABELV $541
line 598
;598:	}
LABELV $536
line 602
;599:
;600:	// JUHOX: add countdown for POD markers (derived from score plum)
;601:#if 1
;602:	if (item->giType == IT_POD_MARKER) {
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 9
NEI4 $601
line 608
;603:		int time;
;604:		char str[16];
;605:		vec3_t origin;
;606:		vec3_t dir;
;607:
;608:		time = (cent->currentState.time - cg.time + 1000) / 1000;
ADDRLP4 244
ADDRFP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ADDRGP4 cg+107656
INDIRI4
SUBI4
CNSTI4 1000
ADDI4
CNSTI4 1000
DIVI4
ASGNI4
line 609
;609:		if (time < 0) time = 0;
ADDRLP4 244
INDIRI4
CNSTI4 0
GEI4 $604
ADDRLP4 244
CNSTI4 0
ASGNI4
LABELV $604
line 610
;610:		Com_sprintf(str, sizeof(str), "%d", time);
ADDRLP4 228
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $606
ARGP4
ADDRLP4 244
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 612
;611:		
;612:		VectorCopy(ent.origin, origin);
ADDRLP4 204
ADDRLP4 0+68
INDIRB
ASGNB 12
line 613
;613:		origin[2] += 30;
ADDRLP4 204+8
ADDRLP4 204+8
INDIRF4
CNSTF4 1106247680
ADDF4
ASGNF4
line 615
;614:
;615:		memset(&ent, 0, sizeof(ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 617
;616:
;617:		ent.reType = RT_SPRITE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 618
;618:		ent.radius = PODMARKER_TIMERSIZE / 2;
ADDRLP4 0+132
CNSTF4 1084227584
ASGNF4
line 619
;619:		ent.shaderRGBA[0] = 0xff;
ADDRLP4 0+116
CNSTU1 255
ASGNU1
line 620
;620:		ent.shaderRGBA[1] = 0xff;
ADDRLP4 0+116+1
CNSTU1 255
ASGNU1
line 621
;621:		ent.shaderRGBA[2] = 0xff;
ADDRLP4 0+116+2
CNSTU1 255
ASGNU1
line 622
;622:		ent.shaderRGBA[3] = 0xff;
ADDRLP4 0+116+3
CNSTU1 255
ASGNU1
line 623
;623:		if (cent->currentState.otherEntityNum != cg.clientNum) {
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ADDRGP4 cg+4
INDIRI4
EQI4 $617
line 624
;624:			switch (cent->currentState.otherEntityNum2) {
ADDRLP4 248
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ASGNI4
ADDRLP4 248
INDIRI4
CNSTI4 1
EQI4 $623
ADDRLP4 248
INDIRI4
CNSTI4 2
EQI4 $628
ADDRGP4 $620
JUMPV
LABELV $623
line 626
;625:			case TEAM_RED:
;626:				ent.shaderRGBA[1] = 0x4c;
ADDRLP4 0+116+1
CNSTU1 76
ASGNU1
line 627
;627:				ent.shaderRGBA[2] = 0x4c;
ADDRLP4 0+116+2
CNSTU1 76
ASGNU1
line 628
;628:				break;
ADDRGP4 $621
JUMPV
LABELV $628
line 630
;629:			case TEAM_BLUE:
;630:				ent.shaderRGBA[0] = 0x4c;
ADDRLP4 0+116
CNSTU1 76
ASGNU1
line 631
;631:				ent.shaderRGBA[1] = 0x4c;
ADDRLP4 0+116+1
CNSTU1 76
ASGNU1
line 632
;632:				break;
ADDRGP4 $621
JUMPV
LABELV $620
line 634
;633:			default:
;634:				ent.shaderRGBA[2] = 0x4c;
ADDRLP4 0+116+2
CNSTU1 76
ASGNU1
line 635
;635:				break;
LABELV $621
line 637
;636:			}
;637:		}
LABELV $617
line 639
;638:
;639:		VectorNegate(cg.refdef.viewaxis[1], dir);
ADDRLP4 216
ADDRGP4 cg+109260+36+12
INDIRF4
NEGF4
ASGNF4
ADDRLP4 216+4
ADDRGP4 cg+109260+36+12+4
INDIRF4
NEGF4
ASGNF4
ADDRLP4 216+8
ADDRGP4 cg+109260+36+12+8
INDIRF4
NEGF4
ASGNF4
line 641
;640:
;641:		if (DistanceSquared(origin, cg.refdef.vieworg) > 20) {
ADDRLP4 204
ARGP4
ADDRGP4 cg+109260+24
ARGP4
ADDRLP4 248
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 248
INDIRF4
CNSTF4 1101004800
LEF4 $647
line 645
;642:			int i;
;643:			int n;
;644:
;645:			n = strlen(str);
ADDRLP4 228
ARGP4
ADDRLP4 260
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 256
ADDRLP4 260
INDIRI4
ASGNI4
line 646
;646:			for (i = 0; i < n; i++) {
ADDRLP4 252
CNSTI4 0
ASGNI4
ADDRGP4 $654
JUMPV
LABELV $651
line 647
;647:				VectorMA(origin, PODMARKER_TIMERSIZE * (i - 0.5 * n + 0.5), dir, ent.origin);
ADDRLP4 0+68
ADDRLP4 204
INDIRF4
ADDRLP4 216
INDIRF4
ADDRLP4 252
INDIRI4
CVIF4 4
ADDRLP4 256
INDIRI4
CVIF4 4
CNSTF4 1056964608
MULF4
SUBF4
CNSTF4 1056964608
ADDF4
CNSTF4 1092616192
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+4
ADDRLP4 204+4
INDIRF4
ADDRLP4 216+4
INDIRF4
ADDRLP4 252
INDIRI4
CVIF4 4
ADDRLP4 256
INDIRI4
CVIF4 4
CNSTF4 1056964608
MULF4
SUBF4
CNSTF4 1056964608
ADDF4
CNSTF4 1092616192
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+8
ADDRLP4 204+8
INDIRF4
ADDRLP4 216+8
INDIRF4
ADDRLP4 252
INDIRI4
CVIF4 4
ADDRLP4 256
INDIRI4
CVIF4 4
CNSTF4 1056964608
MULF4
SUBF4
CNSTF4 1056964608
ADDF4
CNSTF4 1092616192
MULF4
MULF4
ADDF4
ASGNF4
line 648
;648:				ent.customShader = cgs.media.numberShaders[str[i] - '0'];
ADDRLP4 0+112
ADDRLP4 252
INDIRI4
ADDRLP4 228
ADDP4
INDIRI1
CVII4 1
CNSTI4 2
LSHI4
ADDRGP4 cgs+751220+508-192
ADDP4
INDIRI4
ASGNI4
line 649
;649:				trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 650
;650:			}
LABELV $652
line 646
ADDRLP4 252
ADDRLP4 252
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $654
ADDRLP4 252
INDIRI4
ADDRLP4 256
INDIRI4
LTI4 $651
line 651
;651:		}
LABELV $647
line 652
;652:	}
LABELV $601
line 654
;653:#endif
;654:}
LABELV $207
endproc CG_Item 264 16
proc CG_LensFlare 156 12
line 668
;655:
;656://============================================================================
;657:
;658:/*
;659:===============
;660:JUHOX: CG_LensFlare
;661:===============
;662:*/
;663:static void CG_LensFlare(
;664:	vec3_t center, vec3_t dir, float pos, qhandle_t shader,
;665:	float radius,
;666:	int r, int g, int b,
;667:	float alpha, float rotation
;668:) {
line 671
;669:	refEntity_t ent;
;670:
;671:	memset(&ent, 0, sizeof(ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 672
;672:	if (shader != cgs.media.bfgLFStarShader) {
ADDRFP4 12
INDIRI4
ADDRGP4 cgs+751220+496
INDIRI4
EQI4 $669
line 673
;673:		radius *= cg.refdef.fov_x / /*cg_fov.value*/90;	// lens flares do not change size through zooming
ADDRFP4 16
ADDRFP4 16
INDIRF4
ADDRGP4 cg+109260+16
INDIRF4
CNSTF4 1010174817
MULF4
MULF4
ASGNF4
line 674
;674:		alpha /= radius;
ADDRFP4 32
ADDRFP4 32
INDIRF4
ADDRFP4 16
INDIRF4
DIVF4
ASGNF4
line 675
;675:	}
LABELV $669
line 677
;676:	if (
;677:		shader == cgs.media.bfgLFDiscShader ||
ADDRLP4 140
ADDRFP4 12
INDIRI4
ASGNI4
ADDRLP4 140
INDIRI4
ADDRGP4 cgs+751220+484
INDIRI4
EQI4 $681
ADDRLP4 140
INDIRI4
ADDRGP4 cgs+751220+488
INDIRI4
NEI4 $675
LABELV $681
line 679
;678:		shader == cgs.media.bfgLFRingShader
;679:	) {
line 680
;680:		alpha *= 0.25;
ADDRFP4 32
ADDRFP4 32
INDIRF4
CNSTF4 1048576000
MULF4
ASGNF4
line 681
;681:	}
LABELV $675
line 682
;682:	if (alpha > 255) alpha = 255;
ADDRFP4 32
INDIRF4
CNSTF4 1132396544
LEF4 $682
ADDRFP4 32
CNSTF4 1132396544
ASGNF4
LABELV $682
line 684
;683:
;684:	ent.reType = RT_SPRITE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 685
;685:	ent.customShader = shader;
ADDRLP4 0+112
ADDRFP4 12
INDIRI4
ASGNI4
line 686
;686:	ent.shaderRGBA[0] = r;
ADDRLP4 0+116
ADDRFP4 20
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 687
;687:	ent.shaderRGBA[1] = g;
ADDRLP4 0+116+1
ADDRFP4 24
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 688
;688:	ent.shaderRGBA[2] = b;
ADDRLP4 0+116+2
ADDRFP4 28
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 689
;689:	ent.shaderRGBA[3] = alpha;
ADDRLP4 148
ADDRFP4 32
INDIRF4
ASGNF4
ADDRLP4 152
CNSTF4 1325400064
ASGNF4
ADDRLP4 148
INDIRF4
ADDRLP4 152
INDIRF4
LTF4 $693
ADDRLP4 144
ADDRLP4 148
INDIRF4
ADDRLP4 152
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $694
JUMPV
LABELV $693
ADDRLP4 144
ADDRLP4 148
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $694
ADDRLP4 0+116+3
ADDRLP4 144
INDIRU4
CVUU1 4
ASGNU1
line 690
;690:	ent.radius = radius;
ADDRLP4 0+132
ADDRFP4 16
INDIRF4
ASGNF4
line 691
;691:	ent.rotation = rotation;
ADDRLP4 0+136
ADDRFP4 36
INDIRF4
ASGNF4
line 692
;692:	VectorMA(center, pos, dir, ent.origin);
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
INDIRF4
ADDRFP4 4
INDIRP4
INDIRF4
ADDRFP4 8
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRFP4 8
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+8
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
ADDRFP4 8
INDIRF4
MULF4
ADDF4
ASGNF4
line 693
;693:	trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 694
;694:}
LABELV $668
endproc CG_LensFlare 156 12
proc CG_Missile 312 40
line 701
;695:
;696:/*
;697:===============
;698:CG_Missile
;699:===============
;700:*/
;701:static void CG_Missile( centity_t *cent ) {
line 707
;702:	refEntity_t			ent;
;703:	entityState_t		*s1;
;704:	const weaponInfo_t		*weapon;
;705://	int	col;
;706:
;707:	s1 = &cent->currentState;
ADDRLP4 140
ADDRFP4 0
INDIRP4
ASGNP4
line 708
;708:	if ( s1->weapon > WP_NUM_WEAPONS ) {
ADDRLP4 140
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 12
LEI4 $703
line 709
;709:		s1->weapon = 0;
ADDRLP4 140
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 0
ASGNI4
line 710
;710:	}
LABELV $703
line 711
;711:	weapon = &cg_weapons[s1->weapon];
ADDRLP4 144
ADDRLP4 140
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 136
MULI4
ADDRGP4 cg_weapons
ADDP4
ASGNP4
line 714
;712:
;713:#if SPECIAL_VIEW_MODES	// JUHOX: check for strong lights
;714:	switch (s1->weapon) {
ADDRLP4 148
ADDRLP4 140
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 5
EQI4 $708
ADDRLP4 148
INDIRI4
CNSTI4 8
EQI4 $709
ADDRLP4 148
INDIRI4
CNSTI4 9
EQI4 $710
ADDRGP4 $705
JUMPV
LABELV $708
line 716
;715:	case WP_ROCKET_LAUNCHER:
;716:		CG_CheckStrongLight(cent->lerpOrigin, -200, colorWhite);
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
ARGP4
CNSTF4 3276275712
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 CG_CheckStrongLight
CALLV
pop
line 718
;717:#if EARTHQUAKE_SYSTEM
;718:		CG_AddEarthquake(cent->lerpOrigin, 300, -1, -1, -1, 100);
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
ARGP4
CNSTF4 1133903872
ARGF4
CNSTF4 3212836864
ARGF4
CNSTF4 3212836864
ARGF4
CNSTF4 3212836864
ARGF4
CNSTF4 1120403456
ARGF4
ADDRGP4 CG_AddEarthquake
CALLV
pop
line 720
;719:#endif
;720:		break;
ADDRGP4 $706
JUMPV
LABELV $709
line 722
;721:	case WP_PLASMAGUN:
;722:		CG_CheckStrongLight(cent->lerpOrigin, -100, colorWhite);
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
ARGP4
CNSTF4 3267887104
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 CG_CheckStrongLight
CALLV
pop
line 724
;723:#if EARTHQUAKE_SYSTEM
;724:		CG_AddEarthquake(cent->lerpOrigin, 200, -1, -1, -1, 50);
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
ARGP4
CNSTF4 1128792064
ARGF4
CNSTF4 3212836864
ARGF4
CNSTF4 3212836864
ARGF4
CNSTF4 3212836864
ARGF4
CNSTF4 1112014848
ARGF4
ADDRGP4 CG_AddEarthquake
CALLV
pop
line 726
;725:#endif
;726:		break;
ADDRGP4 $706
JUMPV
LABELV $710
line 728
;727:	case WP_BFG:
;728:		CG_CheckStrongLight(cent->lerpOrigin, -350, colorWhite);
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
ARGP4
CNSTF4 3283025920
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 CG_CheckStrongLight
CALLV
pop
line 730
;729:#if EARTHQUAKE_SYSTEM
;730:		CG_AddEarthquake(cent->lerpOrigin, 300, -1, -1, -1, 100);
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
ARGP4
CNSTF4 1133903872
ARGF4
CNSTF4 3212836864
ARGF4
CNSTF4 3212836864
ARGF4
CNSTF4 3212836864
ARGF4
CNSTF4 1120403456
ARGF4
ADDRGP4 CG_AddEarthquake
CALLV
pop
line 732
;731:#endif
;732:		break;
LABELV $705
LABELV $706
line 737
;733:	}
;734:#endif
;735:
;736:	// calculate the axis
;737:	VectorCopy( s1->angles, cent->lerpAngles);
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
ADDRLP4 140
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 740
;738:
;739:	// add trails
;740:	if ( weapon->missileTrailFunc ) 
ADDRLP4 144
INDIRP4
CNSTI4 88
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $711
line 741
;741:	{
line 742
;742:		weapon->missileTrailFunc( cent, weapon );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 144
INDIRP4
ARGP4
ADDRLP4 144
INDIRP4
CNSTI4 88
ADDP4
INDIRP4
CALLV
pop
line 743
;743:	}
LABELV $711
line 762
;744:/*
;745:	if ( cent->currentState.modelindex == TEAM_RED ) {
;746:		col = 1;
;747:	}
;748:	else if ( cent->currentState.modelindex == TEAM_BLUE ) {
;749:		col = 2;
;750:	}
;751:	else {
;752:		col = 0;
;753:	}
;754:
;755:	// add dynamic light
;756:	if ( weapon->missileDlight ) {
;757:		trap_R_AddLightToScene(cent->lerpOrigin, weapon->missileDlight, 
;758:			weapon->missileDlightColor[col][0], weapon->missileDlightColor[col][1], weapon->missileDlightColor[col][2] );
;759:	}
;760:*/
;761:#if ESCAPE_MODE	// JUHOX FIXME: no dlights in EFH
;762:	if (cgs.gametype == GT_EFH) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 9
NEI4 $713
line 764
;763:		// do nothing
;764:	}
ADDRGP4 $714
JUMPV
LABELV $713
line 768
;765:	else
;766:#endif
;767:	// add dynamic light
;768:	if ( weapon->missileDlight ) {
ADDRLP4 144
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
CNSTF4 0
EQF4 $716
line 769
;769:		trap_R_AddLightToScene(cent->lerpOrigin, weapon->missileDlight, 
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
ARGP4
ADDRLP4 144
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ARGF4
ADDRLP4 144
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ARGF4
ADDRLP4 144
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ARGF4
ADDRLP4 144
INDIRP4
CNSTI4 104
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 771
;770:			weapon->missileDlightColor[0], weapon->missileDlightColor[1], weapon->missileDlightColor[2] );
;771:	}
LABELV $716
LABELV $714
line 774
;772:
;773:	// add missile sound
;774:	if ( weapon->missileSound ) {
ADDRLP4 144
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 0
EQI4 $718
line 777
;775:		vec3_t	velocity;
;776:
;777:		BG_EvaluateTrajectoryDelta( &cent->currentState.pos, cg.time, velocity );
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 cg+107656
INDIRI4
ARGI4
ADDRLP4 156
ARGP4
ADDRGP4 BG_EvaluateTrajectoryDelta
CALLV
pop
line 779
;778:
;779:		trap_S_AddLoopingSound( cent->currentState.number, cent->lerpOrigin, velocity, weapon->missileSound );
ADDRLP4 168
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 168
INDIRP4
INDIRI4
ARGI4
ADDRLP4 168
INDIRP4
CNSTI4 728
ADDP4
ARGP4
ADDRLP4 156
ARGP4
ADDRLP4 144
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_AddLoopingSound_fixed
CALLV
pop
line 780
;780:	}
LABELV $718
line 783
;781:
;782:	// create the render entity
;783:	memset (&ent, 0, sizeof(ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 784
;784:	VectorCopy( cent->lerpOrigin, ent.origin);
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
INDIRB
ASGNB 12
line 785
;785:	VectorCopy( cent->lerpOrigin, ent.oldorigin);
ADDRLP4 0+84
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
INDIRB
ASGNB 12
line 791
;786:
;787:#if SCREENSHOT_TOOLS
;788:	if (cg.stopTime) ent.shaderTime = (cg.time - cg.stopTime) / 1000.0;	// JUHOX
;789:#endif
;790:
;791:	if ( cent->currentState.weapon == WP_PLASMAGUN ) {
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 8
NEI4 $723
line 792
;792:		ent.reType = RT_SPRITE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 793
;793:		ent.radius = 16;
ADDRLP4 0+132
CNSTF4 1098907648
ASGNF4
line 794
;794:		ent.rotation = 0;
ADDRLP4 0+136
CNSTF4 0
ASGNF4
line 795
;795:		ent.customShader = cgs.media.plasmaBallShader;
ADDRLP4 0+112
ADDRGP4 cgs+751220+456
INDIRI4
ASGNI4
line 796
;796:		trap_R_AddRefEntityToScene( &ent );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 797
;797:		return;
ADDRGP4 $702
JUMPV
LABELV $723
line 801
;798:	}
;799:
;800:#if 1	// JUHOX: draw new BFG missile lens flare effects
;801:	if (cent->currentState.weapon == WP_BFG) {
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 9
NEI4 $730
line 818
;802:		trace_t trace;
;803:		vec3_t dir;
;804:		float dist;
;805:		vec3_t angles;
;806:		vec3_t virtualOrigin;
;807:		vec3_t center;
;808:		float alpha;
;809:
;810:		/*
;811:		ent.reType = RT_SPRITE;
;812:		ent.radius = 32;
;813:		ent.rotation = 0;
;814:		ent.customShader = cgs.media.plasmaBallShader;
;815:		trap_R_AddRefEntityToScene(&ent);
;816:		*/
;817:
;818:		ent.reType = RT_SPRITE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 819
;819:		ent.radius = 30.0;
ADDRLP4 0+132
CNSTF4 1106247680
ASGNF4
line 820
;820:		ent.rotation = 0;
ADDRLP4 0+136
CNSTF4 0
ASGNF4
line 821
;821:		ent.customShader = cgs.media.bfgLFGlareShader;
ADDRLP4 0+112
ADDRGP4 cgs+751220+480
INDIRI4
ASGNI4
line 822
;822:		ent.shaderRGBA[0] = 255;
ADDRLP4 0+116
CNSTU1 255
ASGNU1
line 823
;823:		ent.shaderRGBA[1] = 255;
ADDRLP4 0+116+1
CNSTU1 255
ASGNU1
line 824
;824:		ent.shaderRGBA[2] = 255;
ADDRLP4 0+116+2
CNSTU1 255
ASGNU1
line 825
;825:		ent.shaderRGBA[3] = 255;
ADDRLP4 0+116+3
CNSTU1 255
ASGNU1
line 826
;826:		trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 828
;827:
;828:		ent.radius = 50.0;
ADDRLP4 0+132
CNSTF4 1112014848
ASGNF4
line 829
;829:		ent.shaderRGBA[0] = 0;
ADDRLP4 0+116
CNSTU1 0
ASGNU1
line 830
;830:		ent.shaderRGBA[1] = 100;
ADDRLP4 0+116+1
CNSTU1 100
ASGNU1
line 831
;831:		ent.shaderRGBA[2] = 255;
ADDRLP4 0+116+2
CNSTU1 255
ASGNU1
line 832
;832:		ent.shaderRGBA[3] = 255;
ADDRLP4 0+116+3
CNSTU1 255
ASGNU1
line 833
;833:		trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 835
;834:
;835:		if (!cg_lensFlare.integer) return;
ADDRGP4 cg_lensFlare+12
INDIRI4
CNSTI4 0
NEI4 $752
ADDRGP4 $702
JUMPV
LABELV $752
line 836
;836:		if (!cg_missileFlare.integer) return;
ADDRGP4 cg_missileFlare+12
INDIRI4
CNSTI4 0
NEI4 $755
ADDRGP4 $702
JUMPV
LABELV $755
line 838
;837:
;838:		CG_Trace(&trace, cg.refdef.vieworg, NULL, NULL, cent->lerpOrigin, cg.clientNum, MASK_OPAQUE|CONTENTS_BODY);
ADDRLP4 212
ARGP4
ADDRGP4 cg+109260+24
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
ARGP4
ADDRGP4 cg+4
INDIRI4
ARGI4
CNSTI4 33554457
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 839
;839:		if (trace.fraction < 1.0) return;
ADDRLP4 212+8
INDIRF4
CNSTF4 1065353216
GEF4 $761
ADDRGP4 $702
JUMPV
LABELV $761
line 841
;840:
;841:		VectorSubtract(cent->lerpOrigin, cg.refdef.vieworg, dir);
ADDRLP4 268
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 156
ADDRLP4 268
INDIRP4
CNSTI4 728
ADDP4
INDIRF4
ADDRGP4 cg+109260+24
INDIRF4
SUBF4
ASGNF4
ADDRLP4 156+4
ADDRLP4 268
INDIRP4
CNSTI4 732
ADDP4
INDIRF4
ADDRGP4 cg+109260+24+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 156+8
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRF4
ADDRGP4 cg+109260+24+8
INDIRF4
SUBF4
ASGNF4
line 842
;842:		dist = VectorNormalize(dir);
ADDRLP4 156
ARGP4
ADDRLP4 272
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 196
ADDRLP4 272
INDIRF4
ASGNF4
line 843
;843:		if (dist < 16) return;
ADDRLP4 196
INDIRF4
CNSTF4 1098907648
GEF4 $774
ADDRGP4 $702
JUMPV
LABELV $774
line 845
;844:
;845:		vectoangles(dir, angles);
ADDRLP4 156
ARGP4
ADDRLP4 184
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 846
;846:		angles[YAW] = AngleSubtract(angles[YAW], cg.predictedPlayerState.viewangles[YAW]);
ADDRLP4 184+4
INDIRF4
ARGF4
ADDRGP4 cg+107688+152+4
INDIRF4
ARGF4
ADDRLP4 276
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 184+4
ADDRLP4 276
INDIRF4
ASGNF4
line 847
;847:		if (angles[YAW] < -0.75 * cg.refdef.fov_x || angles[YAW] > 0.75 * cg.refdef.fov_x) return;
ADDRLP4 184+4
INDIRF4
ADDRGP4 cg+109260+16
INDIRF4
CNSTF4 3208642560
MULF4
LTF4 $789
ADDRLP4 184+4
INDIRF4
ADDRGP4 cg+109260+16
INDIRF4
CNSTF4 1061158912
MULF4
LEF4 $781
LABELV $789
ADDRGP4 $702
JUMPV
LABELV $781
line 848
;848:		angles[PITCH] = AngleSubtract(angles[PITCH], cg.predictedPlayerState.viewangles[PITCH]);
ADDRLP4 184
INDIRF4
ARGF4
ADDRGP4 cg+107688+152
INDIRF4
ARGF4
ADDRLP4 280
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 184
ADDRLP4 280
INDIRF4
ASGNF4
line 849
;849:		if (angles[PITCH] < -0.75 * cg.refdef.fov_y || angles[PITCH] > 0.75 * cg.refdef.fov_y) return;
ADDRLP4 284
ADDRLP4 184
INDIRF4
ASGNF4
ADDRLP4 284
INDIRF4
ADDRGP4 cg+109260+20
INDIRF4
CNSTF4 3208642560
MULF4
LTF4 $798
ADDRLP4 284
INDIRF4
ADDRGP4 cg+109260+20
INDIRF4
CNSTF4 1061158912
MULF4
LEF4 $792
LABELV $798
ADDRGP4 $702
JUMPV
LABELV $792
line 851
;850:
;851:		VectorMA(cg.refdef.vieworg, 8, dir, virtualOrigin);
ADDRLP4 200
ADDRGP4 cg+109260+24
INDIRF4
ADDRLP4 156
INDIRF4
CNSTF4 1090519040
MULF4
ADDF4
ASGNF4
ADDRLP4 200+4
ADDRGP4 cg+109260+24+4
INDIRF4
ADDRLP4 156+4
INDIRF4
CNSTF4 1090519040
MULF4
ADDF4
ASGNF4
ADDRLP4 200+8
ADDRGP4 cg+109260+24+8
INDIRF4
ADDRLP4 156+8
INDIRF4
CNSTF4 1090519040
MULF4
ADDF4
ASGNF4
line 852
;852:		VectorCopy(virtualOrigin, ent.origin);
ADDRLP4 0+68
ADDRLP4 200
INDIRB
ASGNB 12
line 853
;853:		alpha = 255.0 * 220.0 / dist;
ADDRLP4 180
CNSTF4 1197155328
ADDRLP4 196
INDIRF4
DIVF4
ASGNF4
line 855
;854:
;855:		ent.reType = RT_SPRITE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 856
;856:		ent.radius = 20000.0 / dist;
ADDRLP4 0+132
CNSTF4 1184645120
ADDRLP4 196
INDIRF4
DIVF4
ASGNF4
line 857
;857:		ent.shaderRGBA[0] = 255;
ADDRLP4 0+116
CNSTU1 255
ASGNU1
line 858
;858:		ent.shaderRGBA[1] = 255;
ADDRLP4 0+116+1
CNSTU1 255
ASGNU1
line 859
;859:		ent.shaderRGBA[2] = 255;
ADDRLP4 0+116+2
CNSTU1 255
ASGNU1
line 860
;860:		ent.shaderRGBA[3] = 35;
ADDRLP4 0+116+3
CNSTU1 35
ASGNU1
line 861
;861:		trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 863
;862:
;863:		ent.radius = 2000.0 / dist;
ADDRLP4 0+132
CNSTF4 1157234688
ADDRLP4 196
INDIRF4
DIVF4
ASGNF4
line 864
;864:		trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 866
;865:
;866:		VectorMA(cg.refdef.vieworg, 8, cg.refdef.viewaxis[0], center);
ADDRLP4 168
ADDRGP4 cg+109260+24
INDIRF4
ADDRGP4 cg+109260+36
INDIRF4
CNSTF4 1090519040
MULF4
ADDF4
ASGNF4
ADDRLP4 168+4
ADDRGP4 cg+109260+24+4
INDIRF4
ADDRGP4 cg+109260+36+4
INDIRF4
CNSTF4 1090519040
MULF4
ADDF4
ASGNF4
ADDRLP4 168+8
ADDRGP4 cg+109260+24+8
INDIRF4
ADDRGP4 cg+109260+36+8
INDIRF4
CNSTF4 1090519040
MULF4
ADDF4
ASGNF4
line 867
;867:		VectorSubtract(virtualOrigin, center, dir);
ADDRLP4 156
ADDRLP4 200
INDIRF4
ADDRLP4 168
INDIRF4
SUBF4
ASGNF4
ADDRLP4 156+4
ADDRLP4 200+4
INDIRF4
ADDRLP4 168+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 156+8
ADDRLP4 200+8
INDIRF4
ADDRLP4 168+8
INDIRF4
SUBF4
ASGNF4
line 881
;868:
;869:		/*
;870:		CG_LensFlare(
;871:			center, dir, 1.0, cgs.media.bfgLFLineShader, 15.0,
;872:			255, 255, 220,
;873:			alpha, 0.5 * angles[YAW] + 25
;874:		);
;875:		CG_LensFlare(
;876:			center, dir, 1.0, cgs.media.bfgLFLineShader, 15.0,
;877:			255, 220, 255,
;878:			alpha, 0.333 * angles[YAW] - 7
;879:		);
;880:		*/
;881:		CG_LensFlare(
ADDRLP4 168
ARGP4
ADDRLP4 156
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 cgs+751220+492
INDIRI4
ARGI4
CNSTF4 1106247680
ARGF4
CNSTI4 255
ARGI4
CNSTI4 255
ARGI4
CNSTI4 255
ARGI4
ADDRLP4 180
INDIRF4
ARGF4
ADDRLP4 184+4
INDIRF4
CNSTF4 1119092736
ADDF4
ARGF4
ADDRGP4 CG_LensFlare
CALLV
pop
line 887
;882:			center, dir, 1.0, cgs.media.bfgLFLineShader, 30.0,
;883:			255, 255, 255,
;884:			alpha, angles[YAW] + 90
;885:		);
;886:
;887:		CG_LensFlare(center, dir, 3, cgs.media.bfgLFRingShader, 1.7, 255, 255, 255, alpha, 0);
ADDRLP4 168
ARGP4
ADDRLP4 156
ARGP4
CNSTF4 1077936128
ARGF4
ADDRGP4 cgs+751220+488
INDIRI4
ARGI4
CNSTF4 1071225242
ARGF4
CNSTI4 255
ARGI4
CNSTI4 255
ARGI4
CNSTI4 255
ARGI4
ADDRLP4 180
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 CG_LensFlare
CALLV
pop
line 888
;888:		CG_LensFlare(center, dir, 1.5, cgs.media.bfgLFDiscShader, 0.9, 255, 170, 170, alpha, 0);
ADDRLP4 168
ARGP4
ADDRLP4 156
ARGP4
CNSTF4 1069547520
ARGF4
ADDRGP4 cgs+751220+484
INDIRI4
ARGI4
CNSTF4 1063675494
ARGF4
CNSTI4 255
ARGI4
CNSTI4 170
ARGI4
CNSTI4 170
ARGI4
ADDRLP4 180
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 CG_LensFlare
CALLV
pop
line 890
;889:
;890:		CG_LensFlare(center, dir, 1, cgs.media.bfgLFStarShader, 40000 / (dist * sqrt(dist) * sqrt(sqrt(sqrt(dist)))), 255, 255, 255, 255, 3 * angles[YAW]);
ADDRLP4 196
INDIRF4
ARGF4
ADDRLP4 292
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 196
INDIRF4
ARGF4
ADDRLP4 296
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 296
INDIRF4
ARGF4
ADDRLP4 300
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 300
INDIRF4
ARGF4
ADDRLP4 304
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 168
ARGP4
ADDRLP4 156
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 cgs+751220+496
INDIRI4
ARGI4
CNSTF4 1193033728
ADDRLP4 196
INDIRF4
ADDRLP4 292
INDIRF4
MULF4
ADDRLP4 304
INDIRF4
MULF4
DIVF4
ARGF4
CNSTI4 255
ARGI4
CNSTI4 255
ARGI4
CNSTI4 255
ARGI4
CNSTF4 1132396544
ARGF4
ADDRLP4 184+4
INDIRF4
CNSTF4 1077936128
MULF4
ARGF4
ADDRGP4 CG_LensFlare
CALLV
pop
line 892
;891:
;892:		CG_LensFlare(center, dir, 0.5, cgs.media.bfgLFDiscShader, 1.5, 170, 255, 255, alpha, 0);
ADDRLP4 168
ARGP4
ADDRLP4 156
ARGP4
CNSTF4 1056964608
ARGF4
ADDRGP4 cgs+751220+484
INDIRI4
ARGI4
CNSTF4 1069547520
ARGF4
CNSTI4 170
ARGI4
CNSTI4 255
ARGI4
CNSTI4 255
ARGI4
ADDRLP4 180
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 CG_LensFlare
CALLV
pop
line 893
;893:		CG_LensFlare(center, dir, 0.3, cgs.media.bfgLFRingShader, 1, 192, 255, 192, alpha, 0);
ADDRLP4 168
ARGP4
ADDRLP4 156
ARGP4
CNSTF4 1050253722
ARGF4
ADDRGP4 cgs+751220+488
INDIRI4
ARGI4
CNSTF4 1065353216
ARGF4
CNSTI4 192
ARGI4
CNSTI4 255
ARGI4
CNSTI4 192
ARGI4
ADDRLP4 180
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 CG_LensFlare
CALLV
pop
line 894
;894:		CG_LensFlare(center, dir, 0.07, cgs.media.bfgLFDiscShader, 0.7, 210, 255, 235, alpha, 0);
ADDRLP4 168
ARGP4
ADDRLP4 156
ARGP4
CNSTF4 1032805417
ARGF4
ADDRGP4 cgs+751220+484
INDIRI4
ARGI4
CNSTF4 1060320051
ARGF4
CNSTI4 210
ARGI4
CNSTI4 255
ARGI4
CNSTI4 235
ARGI4
ADDRLP4 180
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 CG_LensFlare
CALLV
pop
line 895
;895:		CG_LensFlare(center, dir, -0.25, cgs.media.bfgLFRingShader, 1.4, 230, 255, 255, alpha, 0);
ADDRLP4 168
ARGP4
ADDRLP4 156
ARGP4
CNSTF4 3196059648
ARGF4
ADDRGP4 cgs+751220+488
INDIRI4
ARGI4
CNSTF4 1068708659
ARGF4
CNSTI4 230
ARGI4
CNSTI4 255
ARGI4
CNSTI4 255
ARGI4
ADDRLP4 180
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 CG_LensFlare
CALLV
pop
line 896
;896:		CG_LensFlare(center, dir, -0.45, cgs.media.bfgLFDiscShader, 0.2, 192, 255, 255, alpha, 0);
ADDRLP4 168
ARGP4
ADDRLP4 156
ARGP4
CNSTF4 3202770534
ARGF4
ADDRGP4 cgs+751220+484
INDIRI4
ARGI4
CNSTF4 1045220557
ARGF4
CNSTI4 192
ARGI4
CNSTI4 255
ARGI4
CNSTI4 255
ARGI4
ADDRLP4 180
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 CG_LensFlare
CALLV
pop
line 897
;897:		CG_LensFlare(center, dir, -0.6, cgs.media.bfgLFDiscShader, 0.4, 255, 200, 255, alpha, 0);
ADDRLP4 168
ARGP4
ADDRLP4 156
ARGP4
CNSTF4 3206125978
ARGF4
ADDRGP4 cgs+751220+484
INDIRI4
ARGI4
CNSTF4 1053609165
ARGF4
CNSTI4 255
ARGI4
CNSTI4 200
ARGI4
CNSTI4 255
ARGI4
ADDRLP4 180
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 CG_LensFlare
CALLV
pop
line 898
;898:		CG_LensFlare(center, dir, -0.72, cgs.media.bfgLFDiscShader, 1.1, 255, 200, 170, alpha, 0);
ADDRLP4 168
ARGP4
ADDRLP4 156
ARGP4
CNSTF4 3208139244
ARGF4
ADDRGP4 cgs+751220+484
INDIRI4
ARGI4
CNSTF4 1066192077
ARGF4
CNSTI4 255
ARGI4
CNSTI4 200
ARGI4
CNSTI4 170
ARGI4
ADDRLP4 180
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 CG_LensFlare
CALLV
pop
line 899
;899:		CG_LensFlare(center, dir, -1.0, cgs.media.bfgLFRingShader, 2, 255, 255, 128, alpha, 0);
ADDRLP4 168
ARGP4
ADDRLP4 156
ARGP4
CNSTF4 3212836864
ARGF4
ADDRGP4 cgs+751220+488
INDIRI4
ARGI4
CNSTF4 1073741824
ARGF4
CNSTI4 255
ARGI4
CNSTI4 255
ARGI4
CNSTI4 128
ARGI4
ADDRLP4 180
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 CG_LensFlare
CALLV
pop
line 900
;900:		CG_LensFlare(center, dir, -3.4, cgs.media.bfgLFDiscShader, 1.3, 235, 245, 255, alpha, 0);
ADDRLP4 168
ARGP4
ADDRLP4 156
ARGP4
CNSTF4 3227097498
ARGF4
ADDRGP4 cgs+751220+484
INDIRI4
ARGI4
CNSTF4 1067869798
ARGF4
CNSTI4 235
ARGI4
CNSTI4 245
ARGI4
CNSTI4 255
ARGI4
ADDRLP4 180
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 CG_LensFlare
CALLV
pop
line 902
;901:
;902:		return;
ADDRGP4 $702
JUMPV
LABELV $730
line 908
;903:	}
;904:#endif
;905:
;906:#if MONSTER_MODE	// JUHOX: fireball
;907:	if (
;908:		cent->currentState.weapon == WP_ROCKET_LAUNCHER &&
ADDRLP4 156
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 156
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 5
NEI4 $873
ADDRLP4 156
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
CNSTI4 64
LTI4 $873
line 910
;909:		cent->currentState.otherEntityNum >= MAX_CLIENTS
;910:	) {
line 911
;911:		ent.reType = RT_SPRITE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 912
;912:		ent.radius = 10.0;
ADDRLP4 0+132
CNSTF4 1092616192
ASGNF4
line 913
;913:		ent.customShader = cgs.media.bfgLFGlareShader;
ADDRLP4 0+112
ADDRGP4 cgs+751220+480
INDIRI4
ASGNI4
line 914
;914:		ent.shaderRGBA[0] = 255;
ADDRLP4 0+116
CNSTU1 255
ASGNU1
line 915
;915:		ent.shaderRGBA[1] = 255;
ADDRLP4 0+116+1
CNSTU1 255
ASGNU1
line 916
;916:		ent.shaderRGBA[2] = 255;
ADDRLP4 0+116+2
CNSTU1 255
ASGNU1
line 917
;917:		ent.shaderRGBA[3] = 255;
ADDRLP4 0+116+3
CNSTU1 255
ASGNU1
line 918
;918:		trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 920
;919:
;920:		ent.radius = 20.0;
ADDRLP4 0+132
CNSTF4 1101004800
ASGNF4
line 921
;921:		ent.shaderRGBA[0] = 128;
ADDRLP4 0+116
CNSTU1 128
ASGNU1
line 922
;922:		ent.shaderRGBA[1] = 50;
ADDRLP4 0+116+1
CNSTU1 50
ASGNU1
line 923
;923:		ent.shaderRGBA[2] = 0;
ADDRLP4 0+116+2
CNSTU1 0
ASGNU1
line 924
;924:		trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 926
;925:	
;926:		return;
ADDRGP4 $702
JUMPV
LABELV $873
line 932
;927:	}
;928:#endif
;929:
;930:#if 1	// JUHOX: rocket lens flares
;931:	if (
;932:		cent->currentState.weapon == WP_ROCKET_LAUNCHER &&
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 5
NEI4 $892
ADDRGP4 cg_lensFlare+12
INDIRI4
CNSTI4 0
EQI4 $892
ADDRGP4 cg_missileFlare+12
INDIRI4
CNSTI4 0
EQI4 $892
line 935
;933:		cg_lensFlare.integer &&
;934:		cg_missileFlare.integer
;935:	) {
line 938
;936:		trace_t trace;
;937:
;938:		CG_Trace(&trace, cg.refdef.vieworg, NULL, NULL, cent->lerpOrigin, cg.clientNum, MASK_OPAQUE|CONTENTS_BODY);
ADDRLP4 160
ARGP4
ADDRGP4 cg+109260+24
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
ARGP4
ADDRGP4 cg+4
INDIRI4
ARGI4
CNSTI4 33554457
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 939
;939:		if (trace.fraction >= 1.0) {
ADDRLP4 160+8
INDIRF4
CNSTF4 1065353216
LTF4 $899
line 947
;940:			vec3_t dir;
;941:			float dist;
;942:			vec3_t angles;
;943:			vec3_t virtualOrigin;
;944:			vec3_t center;
;945:			float alpha;
;946:
;947:			VectorSubtract(cent->lerpOrigin, cg.refdef.vieworg, dir);
ADDRLP4 272
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 216
ADDRLP4 272
INDIRP4
CNSTI4 728
ADDP4
INDIRF4
ADDRGP4 cg+109260+24
INDIRF4
SUBF4
ASGNF4
ADDRLP4 216+4
ADDRLP4 272
INDIRP4
CNSTI4 732
ADDP4
INDIRF4
ADDRGP4 cg+109260+24+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 216+8
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRF4
ADDRGP4 cg+109260+24+8
INDIRF4
SUBF4
ASGNF4
line 948
;948:			dist = VectorNormalize(dir);
ADDRLP4 216
ARGP4
ADDRLP4 276
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 240
ADDRLP4 276
INDIRF4
ASGNF4
line 949
;949:			if (dist > 16) {
ADDRLP4 240
INDIRF4
CNSTF4 1098907648
LEF4 $912
line 950
;950:				vectoangles(dir, angles);
ADDRLP4 216
ARGP4
ADDRLP4 228
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 951
;951:				angles[YAW] = AngleSubtract(angles[YAW], cg.predictedPlayerState.viewangles[YAW]);
ADDRLP4 228+4
INDIRF4
ARGF4
ADDRGP4 cg+107688+152+4
INDIRF4
ARGF4
ADDRLP4 280
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 228+4
ADDRLP4 280
INDIRF4
ASGNF4
line 952
;952:				angles[PITCH] = AngleSubtract(angles[PITCH], cg.predictedPlayerState.viewangles[PITCH]);
ADDRLP4 228
INDIRF4
ARGF4
ADDRGP4 cg+107688+152
INDIRF4
ARGF4
ADDRLP4 284
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 228
ADDRLP4 284
INDIRF4
ASGNF4
line 954
;953:				if (
;954:					angles[YAW] >= -0.75 * cg.refdef.fov_x &&
ADDRLP4 228+4
INDIRF4
ADDRGP4 cg+109260+16
INDIRF4
CNSTF4 3208642560
MULF4
LTF4 $921
ADDRLP4 228+4
INDIRF4
ADDRGP4 cg+109260+16
INDIRF4
CNSTF4 1061158912
MULF4
GTF4 $921
ADDRLP4 288
ADDRLP4 228
INDIRF4
ASGNF4
ADDRLP4 288
INDIRF4
ADDRGP4 cg+109260+20
INDIRF4
CNSTF4 3208642560
MULF4
LTF4 $921
ADDRLP4 288
INDIRF4
ADDRGP4 cg+109260+20
INDIRF4
CNSTF4 1061158912
MULF4
GTF4 $921
line 958
;955:					angles[YAW] <= 0.75 * cg.refdef.fov_x &&
;956:					angles[PITCH] >= -0.75 * cg.refdef.fov_y &&
;957:					angles[PITCH] <= 0.75 * cg.refdef.fov_y
;958:				) {
line 959
;959:					VectorMA(cg.refdef.vieworg, 8, dir, virtualOrigin);
ADDRLP4 256
ADDRGP4 cg+109260+24
INDIRF4
ADDRLP4 216
INDIRF4
CNSTF4 1090519040
MULF4
ADDF4
ASGNF4
ADDRLP4 256+4
ADDRGP4 cg+109260+24+4
INDIRF4
ADDRLP4 216+4
INDIRF4
CNSTF4 1090519040
MULF4
ADDF4
ASGNF4
ADDRLP4 256+8
ADDRGP4 cg+109260+24+8
INDIRF4
ADDRLP4 216+8
INDIRF4
CNSTF4 1090519040
MULF4
ADDF4
ASGNF4
line 960
;960:					VectorMA(cg.refdef.vieworg, 8, cg.refdef.viewaxis[0], center);
ADDRLP4 244
ADDRGP4 cg+109260+24
INDIRF4
ADDRGP4 cg+109260+36
INDIRF4
CNSTF4 1090519040
MULF4
ADDF4
ASGNF4
ADDRLP4 244+4
ADDRGP4 cg+109260+24+4
INDIRF4
ADDRGP4 cg+109260+36+4
INDIRF4
CNSTF4 1090519040
MULF4
ADDF4
ASGNF4
ADDRLP4 244+8
ADDRGP4 cg+109260+24+8
INDIRF4
ADDRGP4 cg+109260+36+8
INDIRF4
CNSTF4 1090519040
MULF4
ADDF4
ASGNF4
line 961
;961:					VectorSubtract(virtualOrigin, center, dir);
ADDRLP4 216
ADDRLP4 256
INDIRF4
ADDRLP4 244
INDIRF4
SUBF4
ASGNF4
ADDRLP4 216+4
ADDRLP4 256+4
INDIRF4
ADDRLP4 244+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 216+8
ADDRLP4 256+8
INDIRF4
ADDRLP4 244+8
INDIRF4
SUBF4
ASGNF4
line 962
;962:					alpha = 255.0 * 220.0 / dist;
ADDRLP4 268
CNSTF4 1197155328
ADDRLP4 240
INDIRF4
DIVF4
ASGNF4
line 964
;963:
;964:					CG_LensFlare(center, dir, 1, cgs.media.bfgLFStarShader, 20000.0 / (dist * sqrt(dist) * sqrt(sqrt(sqrt(dist)))), 255, 200, 180, alpha, 0);
ADDRLP4 292
ADDRLP4 240
INDIRF4
ASGNF4
ADDRLP4 292
INDIRF4
ARGF4
ADDRLP4 296
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 240
INDIRF4
ARGF4
ADDRLP4 300
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 300
INDIRF4
ARGF4
ADDRLP4 304
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 304
INDIRF4
ARGF4
ADDRLP4 308
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 244
ARGP4
ADDRLP4 216
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 cgs+751220+496
INDIRI4
ARGI4
CNSTF4 1184645120
ADDRLP4 292
INDIRF4
ADDRLP4 296
INDIRF4
MULF4
ADDRLP4 308
INDIRF4
MULF4
DIVF4
ARGF4
CNSTI4 255
ARGI4
CNSTI4 200
ARGI4
CNSTI4 180
ARGI4
ADDRLP4 268
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 CG_LensFlare
CALLV
pop
line 966
;965:					//CG_LensFlare(center, dir, 1, cgs.media.bfgLFGlareShader, 40000.0 / (dist * sqrt(dist) * sqrt(sqrt(sqrt(dist)))), 255, 200, 180, alpha, 0);
;966:				}
LABELV $921
line 967
;967:			}
LABELV $912
line 968
;968:		}
LABELV $899
line 969
;969:	}
LABELV $892
line 973
;970:#endif
;971:
;972:	// flicker between two skins
;973:	ent.skinNum = cg.clientFrame & 1;
ADDRLP4 0+104
ADDRGP4 cg
INDIRI4
CNSTI4 1
BANDI4
ASGNI4
line 974
;974:	ent.hModel = weapon->missileModel;
ADDRLP4 0+8
ADDRLP4 144
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
ASGNI4
line 975
;975:	ent.renderfx = weapon->missileRenderfx | RF_NOSHADOW;
ADDRLP4 0+4
ADDRLP4 144
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
line 987
;976:
;977:#ifdef MISSIONPACK
;978:	if ( cent->currentState.weapon == WP_PROX_LAUNCHER ) {
;979:		if (s1->generic1 == TEAM_BLUE) {
;980:			ent.hModel = cgs.media.blueProxMine;
;981:		}
;982:	}
;983:#endif
;984:
;985:	// convert direction of travel into axis
;986:#if GRAPPLE_ROPE	// JUHOX: compute hook axis
;987:	if (cent->currentState.weapon == WP_GRAPPLING_HOOK) {
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 10
NEI4 $974
line 988
;988:		BG_EvaluateTrajectoryDelta(&cent->currentState.pos, cg.time, ent.axis[0]);
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 cg+107656
INDIRI4
ARGI4
ADDRLP4 0+28
ARGP4
ADDRGP4 BG_EvaluateTrajectoryDelta
CALLV
pop
line 989
;989:		if (VectorNormalize(ent.axis[0]) == 0) {
ADDRLP4 0+28
ARGP4
ADDRLP4 160
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 160
INDIRF4
CNSTF4 0
NEF4 $975
line 990
;990:			ent.axis[0][2] = 1;
ADDRLP4 0+28+8
CNSTF4 1065353216
ASGNF4
line 991
;991:		}
line 992
;992:	}
ADDRGP4 $975
JUMPV
LABELV $974
line 996
;993:	else
;994:#endif
;995:#if MONSTER_MODE	// JUHOX: add metal shader for monster seed
;996:	if (cent->currentState.weapon == WP_MONSTER_LAUNCHER) {
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 11
NEI4 $983
line 997
;997:		const float radius = 4;
ADDRLP4 160
CNSTF4 1082130432
ASGNF4
line 999
;998:
;999:		ent.customShader = cgs.media.monsterSeedMetalShader;
ADDRLP4 0+112
ADDRGP4 cgs+751220+720
INDIRI4
ASGNI4
line 1001
;1000:
;1001:		ent.origin[2] -= 0.5 * radius;
ADDRLP4 0+68+8
ADDRLP4 0+68+8
INDIRF4
ADDRLP4 160
INDIRF4
CNSTF4 1056964608
MULF4
SUBF4
ASGNF4
line 1004
;1002:
;1003:		
;1004:		ent.axis[0][0] = 0.1 * radius;
ADDRLP4 0+28
ADDRLP4 160
INDIRF4
CNSTF4 1036831949
MULF4
ASGNF4
line 1005
;1005:		ent.axis[1][1] = 0.1 * radius;
ADDRLP4 0+28+12+4
ADDRLP4 160
INDIRF4
CNSTF4 1036831949
MULF4
ASGNF4
line 1006
;1006:		ent.axis[2][2] = 0.1 * radius;
ADDRLP4 0+28+24+8
ADDRLP4 160
INDIRF4
CNSTF4 1036831949
MULF4
ASGNF4
line 1007
;1007:		ent.nonNormalizedAxes = qtrue;
ADDRLP4 0+64
CNSTI4 1
ASGNI4
line 1008
;1008:		trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1010
;1009:		//CG_AddRefEntityWithPowerups(&ent, s1, TEAM_FREE);
;1010:		return;
ADDRGP4 $702
JUMPV
LABELV $983
line 1014
;1011:	}
;1012:	else
;1013:#endif
;1014:	if ( VectorNormalize2( s1->pos.trDelta, ent.axis[0] ) == 0 ) {
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
ARGP4
ADDRLP4 0+28
ARGP4
ADDRLP4 160
ADDRGP4 VectorNormalize2
CALLF4
ASGNF4
ADDRLP4 160
INDIRF4
CNSTF4 0
NEF4 $998
line 1015
;1015:		ent.axis[0][2] = 1;
ADDRLP4 0+28+8
CNSTF4 1065353216
ASGNF4
line 1016
;1016:	}
LABELV $998
LABELV $975
line 1019
;1017:
;1018:	// spin as it moves
;1019:	if ( s1->pos.trType != TR_STATIONARY ) {
ADDRLP4 140
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1003
line 1026
;1020:#if SCREENSHOT_TOOLS	// JUHOX: don't spin missile while game is stopped
;1021:		if (cg.stopTime) {
;1022:			RotateAroundDirection(ent.axis, cg.stopTime / 4);
;1023:		}
;1024:		else
;1025:#endif
;1026:		RotateAroundDirection( ent.axis, cg.time / 4 );
ADDRLP4 0+28
ARGP4
ADDRGP4 cg+107656
INDIRI4
CNSTI4 4
DIVI4
CVIF4 4
ARGF4
ADDRGP4 RotateAroundDirection
CALLV
pop
line 1027
;1027:	} else {
ADDRGP4 $1004
JUMPV
LABELV $1003
line 1034
;1028:#ifdef MISSIONPACK
;1029:		if ( s1->weapon == WP_PROX_LAUNCHER ) {
;1030:			AnglesToAxis( cent->lerpAngles, ent.axis );
;1031:		}
;1032:		else
;1033:#endif
;1034:		{
line 1035
;1035:			RotateAroundDirection( ent.axis, s1->time );
ADDRLP4 0+28
ARGP4
ADDRLP4 140
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 RotateAroundDirection
CALLV
pop
line 1036
;1036:		}
line 1037
;1037:	}
LABELV $1004
line 1040
;1038:
;1039:	// add to refresh list, possibly with quad glow
;1040:	CG_AddRefEntityWithPowerups( &ent, s1, TEAM_FREE );
ADDRLP4 0
ARGP4
ADDRLP4 140
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 CG_AddRefEntityWithPowerups
CALLV
pop
line 1041
;1041:}
LABELV $702
endproc CG_Missile 312 40
proc CG_Grapple 8 8
line 1050
;1042:
;1043:/*
;1044:===============
;1045:CG_Grapple
;1046:
;1047:This is called when the grapple is sitting up against the wall
;1048:===============
;1049:*/
;1050:static void CG_Grapple( centity_t *cent ) {
line 1058
;1051:	// JUHOX: don't draw hook when attached to the wall
;1052:#if !GRAPPLE_ROPE
;1053:	refEntity_t			ent;
;1054:#endif
;1055:	entityState_t		*s1;
;1056:	const weaponInfo_t		*weapon;
;1057:
;1058:	s1 = &cent->currentState;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 1059
;1059:	if ( s1->weapon > WP_NUM_WEAPONS ) {
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 12
LEI4 $1009
line 1060
;1060:		s1->weapon = 0;
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 0
ASGNI4
line 1061
;1061:	}
LABELV $1009
line 1062
;1062:	weapon = &cg_weapons[s1->weapon];
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 136
MULI4
ADDRGP4 cg_weapons
ADDP4
ASGNP4
line 1065
;1063:
;1064:	// calculate the axis
;1065:	VectorCopy( s1->angles, cent->lerpAngles);
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 1075
;1066:
;1067:#if 0 // FIXME add grapple pull sound here..?
;1068:	// add missile sound
;1069:	if ( weapon->missileSound ) {
;1070:		trap_S_AddLoopingSound( cent->currentState.number, cent->lerpOrigin, vec3_origin, weapon->missileSound );
;1071:	}
;1072:#endif
;1073:
;1074:	// Will draw cable if needed
;1075:	CG_GrappleTrail ( cent, weapon );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 CG_GrappleTrail
CALLV
pop
line 1096
;1076:
;1077:	// JUHOX: don't draw hook when attached to the wall
;1078:#if !GRAPPLE_ROPE
;1079:	// create the render entity
;1080:	memset (&ent, 0, sizeof(ent));
;1081:	VectorCopy( cent->lerpOrigin, ent.origin);
;1082:	VectorCopy( cent->lerpOrigin, ent.oldorigin);
;1083:
;1084:	// flicker between two skins
;1085:	ent.skinNum = cg.clientFrame & 1;
;1086:	ent.hModel = weapon->missileModel;
;1087:	ent.renderfx = weapon->missileRenderfx | RF_NOSHADOW;
;1088:
;1089:	// convert direction of travel into axis
;1090:	if ( VectorNormalize2( s1->pos.trDelta, ent.axis[0] ) == 0 ) {
;1091:		ent.axis[0][2] = 1;
;1092:	}
;1093:
;1094:	trap_R_AddRefEntityToScene( &ent );
;1095:#endif
;1096:}
LABELV $1008
endproc CG_Grapple 8 8
proc ScatterRopeSegment 152 16
line 1106
;1097:
;1098:/*
;1099:===============
;1100:JUHOX: ScatterRopeSegment
;1101:===============
;1102:*/
;1103:#if GRAPPLE_ROPE
;1104:#define ROPE_MAX_SCATTER_TIME 1000
;1105:#define ROPE_MAX_SCATTER_ROTATION 1000.0
;1106:static void ScatterRopeSegment(vec3_t v, vec3_t w, int time) {
line 1116
;1107:	vec3_t angles;
;1108:	vec3_t vel;
;1109:	float dist;
;1110:	vec3_t mid;
;1111:	vec3_t matrix[3];
;1112:	vec3_t a;
;1113:	vec3_t b;
;1114:	vec3_t c;
;1115:
;1116:	if (time <= 0) return;
ADDRFP4 8
INDIRI4
CNSTI4 0
GTI4 $1012
ADDRGP4 $1011
JUMPV
LABELV $1012
line 1118
;1117:
;1118:	srand(BG_VectorChecksum(v));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 112
ADDRGP4 BG_VectorChecksum
CALLU4
ASGNU4
ADDRLP4 112
INDIRU4
ARGU4
ADDRGP4 srand
CALLV
pop
line 1119
;1119:	angles[0] = 360 * random();
ADDRLP4 116
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 24
ADDRLP4 116
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 116
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
line 1120
;1120:	angles[1] = 360 * random();
ADDRLP4 120
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 24+4
ADDRLP4 120
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 120
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
line 1121
;1121:	angles[2] = 360 * random();
ADDRLP4 124
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 24+8
ADDRLP4 124
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 124
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
line 1123
;1122:
;1123:	AngleVectors(angles, vel, NULL, NULL);
ADDRLP4 24
ARGP4
ADDRLP4 60
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 1124
;1124:	dist = (300 + 300*random()) * (time / 1000.0);
ADDRLP4 128
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 72
ADDRLP4 128
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 128
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1133903872
MULF4
CNSTF4 1133903872
ADDF4
ADDRFP4 8
INDIRI4
CVIF4 4
CNSTF4 981668463
MULF4
MULF4
ASGNF4
line 1126
;1125:
;1126:	angles[0] = ROPE_MAX_SCATTER_ROTATION * random() * (time / 1000.0);
ADDRLP4 132
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 24
ADDRLP4 132
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 132
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1148846080
MULF4
ADDRFP4 8
INDIRI4
CVIF4 4
CNSTF4 981668463
MULF4
MULF4
ASGNF4
line 1127
;1127:	angles[1] = ROPE_MAX_SCATTER_ROTATION * random() * (time / 1000.0);
ADDRLP4 136
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 24+4
ADDRLP4 136
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 136
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1148846080
MULF4
ADDRFP4 8
INDIRI4
CVIF4 4
CNSTF4 981668463
MULF4
MULF4
ASGNF4
line 1128
;1128:	angles[2] = ROPE_MAX_SCATTER_ROTATION * random() * (time / 1000.0);
ADDRLP4 140
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 24+8
ADDRLP4 140
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 140
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1148846080
MULF4
ADDRFP4 8
INDIRI4
CVIF4 4
CNSTF4 981668463
MULF4
MULF4
ASGNF4
line 1129
;1129:	AnglesToAxis(angles, matrix);
ADDRLP4 24
ARGP4
ADDRLP4 76
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1131
;1130:
;1131:	mid[0] = 0.5 * (v[0] + w[0]);
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRF4
ADDRFP4 4
INDIRP4
INDIRF4
ADDF4
CNSTF4 1056964608
MULF4
ASGNF4
line 1132
;1132:	mid[1] = 0.5 * (v[1] + w[1]);
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDF4
CNSTF4 1056964608
MULF4
ASGNF4
line 1133
;1133:	mid[2] = 0.5 * (v[2] + w[2]);
ADDRLP4 0+8
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
CNSTF4 1056964608
MULF4
ASGNF4
line 1135
;1134:
;1135:	VectorSubtract(v, mid, a);
ADDRLP4 144
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
ADDRLP4 144
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 36+4
ADDRLP4 144
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 36+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 1136
;1136:	VectorRotate(a, matrix, b);
ADDRLP4 36
ARGP4
ADDRLP4 76
ARGP4
ADDRLP4 48
ARGP4
ADDRGP4 VectorRotate
CALLV
pop
line 1137
;1137:	VectorAdd(b, mid, c);
ADDRLP4 12
ADDRLP4 48
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 48+4
INDIRF4
ADDRLP4 0+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 48+8
INDIRF4
ADDRLP4 0+8
INDIRF4
ADDF4
ASGNF4
line 1138
;1138:	VectorMA(c, dist, vel, v);
ADDRFP4 0
INDIRP4
ADDRLP4 12
INDIRF4
ADDRLP4 60
INDIRF4
ADDRLP4 72
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 12+4
INDIRF4
ADDRLP4 60+4
INDIRF4
ADDRLP4 72
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 12+8
INDIRF4
ADDRLP4 60+8
INDIRF4
ADDRLP4 72
INDIRF4
MULF4
ADDF4
ASGNF4
line 1140
;1139:
;1140:	VectorSubtract(w, mid, a);
ADDRLP4 148
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 36
ADDRLP4 148
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 36+4
ADDRLP4 148
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 36+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 1141
;1141:	VectorRotate(a, matrix, b);
ADDRLP4 36
ARGP4
ADDRLP4 76
ARGP4
ADDRLP4 48
ARGP4
ADDRGP4 VectorRotate
CALLV
pop
line 1142
;1142:	VectorAdd(b, mid, c);
ADDRLP4 12
ADDRLP4 48
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 48+4
INDIRF4
ADDRLP4 0+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 48+8
INDIRF4
ADDRLP4 0+8
INDIRF4
ADDF4
ASGNF4
line 1143
;1143:	VectorMA(c, dist, vel, w);
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRF4
ADDRLP4 60
INDIRF4
ADDRLP4 72
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 12+4
INDIRF4
ADDRLP4 60+4
INDIRF4
ADDRLP4 72
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 12+8
INDIRF4
ADDRLP4 60+8
INDIRF4
ADDRLP4 72
INDIRF4
MULF4
ADDF4
ASGNF4
line 1144
;1144:}
LABELV $1011
endproc ScatterRopeSegment 152 16
proc CG_GrappleRope 192 12
line 1153
;1145:#endif
;1146:
;1147:/*
;1148:===============
;1149:JUHOX: CG_GrappleRope
;1150:===============
;1151:*/
;1152:#if GRAPPLE_ROPE
;1153:static void CG_GrappleRope(centity_t* cent) {
line 1161
;1154:	entityState_t* s;
;1155:	int i;
;1156:	int n;
;1157:	qboolean hasLastPos;
;1158:	vec3_t lastPos;
;1159:	int scatterTime;
;1160:
;1161:	s = &cent->currentState;
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
line 1162
;1162:	hasLastPos = qfalse;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1165
;1163:
;1164:	if (
;1165:		s->otherEntityNum != ENTITYNUM_NONE &&
ADDRLP4 20
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
CNSTI4 1023
EQI4 $1049
ADDRLP4 20
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
CNSTI4 880
MULI4
ADDRGP4 cg_entities+420
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1049
line 1167
;1166:		cg_entities[s->otherEntityNum].currentValid
;1167:	) {
line 1168
;1168:		switch (cg_entities[s->otherEntityNum].currentState.eType) {
ADDRLP4 36
ADDRLP4 20
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
CNSTI4 880
MULI4
ADDRGP4 cg_entities+4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 3
EQI4 $1056
ADDRLP4 36
INDIRI4
CNSTI4 3
LTI4 $1052
LABELV $1063
ADDRLP4 36
INDIRI4
CNSTI4 11
EQI4 $1056
ADDRLP4 36
INDIRI4
CNSTI4 12
EQI4 $1058
ADDRGP4 $1052
JUMPV
LABELV $1056
line 1171
;1169:		case ET_GRAPPLE:
;1170:		case ET_MISSILE:
;1171:			VectorCopy(cg_entities[s->otherEntityNum].lerpOrigin, lastPos);
ADDRLP4 8
ADDRLP4 20
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
CNSTI4 880
MULI4
ADDRGP4 cg_entities+728
ADDP4
INDIRB
ASGNB 12
line 1172
;1172:			hasLastPos = qtrue;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 1173
;1173:			break;
ADDRGP4 $1053
JUMPV
LABELV $1058
line 1175
;1174:		case ET_GRAPPLE_ROPE:
;1175:			if (cg_entities[s->otherEntityNum].currentState.modelindex == 8) {
ADDRLP4 20
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
CNSTI4 880
MULI4
ADDRGP4 cg_entities+160
ADDP4
INDIRI4
CNSTI4 8
NEI4 $1053
line 1176
;1176:				VectorCopy(cg_entities[s->otherEntityNum].currentState.angles2, lastPos);
ADDRLP4 8
ADDRLP4 20
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
CNSTI4 880
MULI4
ADDRGP4 cg_entities+128
ADDP4
INDIRB
ASGNB 12
line 1177
;1177:				hasLastPos = qtrue;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 1178
;1178:			}
line 1179
;1179:			break;
LABELV $1052
LABELV $1053
line 1181
;1180:		}
;1181:	}
LABELV $1049
line 1183
;1182:
;1183:	n = s->modelindex;
ADDRLP4 28
ADDRLP4 20
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ASGNI4
line 1184
;1184:	if (n > 8) return;
ADDRLP4 28
INDIRI4
CNSTI4 8
LEI4 $1064
ADDRGP4 $1048
JUMPV
LABELV $1064
line 1186
;1185:
;1186:	if (cent->currentState.time) {
ADDRFP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1066
line 1187
;1187:		scatterTime = cg.time - cent->currentState.time;
ADDRLP4 24
ADDRGP4 cg+107656
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
SUBI4
ASGNI4
line 1188
;1188:		if (scatterTime < 0) scatterTime = 0;
ADDRLP4 24
INDIRI4
CNSTI4 0
GEI4 $1069
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRGP4 $1067
JUMPV
LABELV $1069
line 1189
;1189:		else if (scatterTime > ROPE_MAX_SCATTER_TIME) scatterTime = ROPE_MAX_SCATTER_TIME;
ADDRLP4 24
INDIRI4
CNSTI4 1000
LEI4 $1067
ADDRLP4 24
CNSTI4 1000
ASGNI4
line 1190
;1190:	}
ADDRGP4 $1067
JUMPV
LABELV $1066
line 1191
;1191:	else {
line 1192
;1192:		scatterTime = 0;
ADDRLP4 24
CNSTI4 0
ASGNI4
line 1193
;1193:	}
LABELV $1067
line 1195
;1194:
;1195:	for (i = 0; i < n; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1076
JUMPV
LABELV $1073
line 1198
;1196:		vec3_t pos;
;1197:
;1198:		switch (i) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1077
ADDRLP4 0
INDIRI4
CNSTI4 7
GTI4 $1077
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1087
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1087
address $1079
address $1080
address $1081
address $1082
address $1083
address $1084
address $1085
address $1086
code
LABELV $1079
line 1200
;1199:		case 0:
;1200:			VectorCopy(s->pos.trBase, pos);
ADDRLP4 36
ADDRLP4 20
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 1201
;1201:			break;
ADDRGP4 $1078
JUMPV
LABELV $1080
line 1203
;1202:		case 1:
;1203:			VectorCopy(s->pos.trDelta, pos);
ADDRLP4 36
ADDRLP4 20
INDIRP4
CNSTI4 36
ADDP4
INDIRB
ASGNB 12
line 1204
;1204:			break;
ADDRGP4 $1078
JUMPV
LABELV $1081
line 1206
;1205:		case 2:
;1206:			VectorCopy(s->apos.trBase, pos);
ADDRLP4 36
ADDRLP4 20
INDIRP4
CNSTI4 60
ADDP4
INDIRB
ASGNB 12
line 1207
;1207:			break;
ADDRGP4 $1078
JUMPV
LABELV $1082
line 1209
;1208:		case 3:
;1209:			VectorCopy(s->apos.trDelta, pos);
ADDRLP4 36
ADDRLP4 20
INDIRP4
CNSTI4 72
ADDP4
INDIRB
ASGNB 12
line 1210
;1210:			break;
ADDRGP4 $1078
JUMPV
LABELV $1083
line 1212
;1211:		case 4:
;1212:			VectorCopy(s->origin, pos);
ADDRLP4 36
ADDRLP4 20
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 1213
;1213:			break;
ADDRGP4 $1078
JUMPV
LABELV $1084
line 1215
;1214:		case 5:
;1215:			VectorCopy(s->origin2, pos);
ADDRLP4 36
ADDRLP4 20
INDIRP4
CNSTI4 104
ADDP4
INDIRB
ASGNB 12
line 1216
;1216:			break;
ADDRGP4 $1078
JUMPV
LABELV $1085
line 1218
;1217:		case 6:
;1218:			VectorCopy(s->angles, pos);
ADDRLP4 36
ADDRLP4 20
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 1219
;1219:			break;
ADDRGP4 $1078
JUMPV
LABELV $1086
line 1221
;1220:		case 7:
;1221:			VectorCopy(s->angles2, pos);
ADDRLP4 36
ADDRLP4 20
INDIRP4
CNSTI4 128
ADDP4
INDIRB
ASGNB 12
line 1222
;1222:			break;
LABELV $1077
LABELV $1078
line 1225
;1223:		}
;1224:
;1225:		if (hasLastPos) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $1088
line 1228
;1226:			refEntity_t rope;
;1227:
;1228:			memset(&rope, 0, sizeof(rope));
ADDRLP4 52
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1229
;1229:			VectorCopy(lastPos, rope.oldorigin);
ADDRLP4 52+84
ADDRLP4 8
INDIRB
ASGNB 12
line 1230
;1230:			VectorCopy(pos, rope.origin);
ADDRLP4 52+68
ADDRLP4 36
INDIRB
ASGNB 12
line 1231
;1231:			rope.reType = RT_LIGHTNING;	//RT_RAIL_CORE;
ADDRLP4 52
CNSTI4 6
ASGNI4
line 1232
;1232:			rope.customShader = cgs.media.grappleShader;
ADDRLP4 52+112
ADDRGP4 cgs+751220+256
INDIRI4
ASGNI4
line 1233
;1233:			rope.shaderRGBA[0] = 0xff;
ADDRLP4 52+116
CNSTU1 255
ASGNU1
line 1234
;1234:			rope.shaderRGBA[1] = 0xff;
ADDRLP4 52+116+1
CNSTU1 255
ASGNU1
line 1235
;1235:			rope.shaderRGBA[2] = 0xff;
ADDRLP4 52+116+2
CNSTU1 255
ASGNU1
line 1236
;1236:			rope.shaderRGBA[3] = 0xff;
ADDRLP4 52+116+3
CNSTU1 255
ASGNU1
line 1238
;1237:
;1238:			if (scatterTime > 0) {
ADDRLP4 24
INDIRI4
CNSTI4 0
LEI4 $1102
line 1239
;1239:				rope.shaderRGBA[3] = (int) (0xff * (ROPE_MAX_SCATTER_TIME - scatterTime) / 1000.0);
ADDRLP4 52+116+3
CNSTI4 1000
ADDRLP4 24
INDIRI4
SUBI4
CNSTI4 255
MULI4
CVIF4 4
CNSTF4 981668463
MULF4
CVFI4 4
CVIU4 4
CVUU1 4
ASGNU1
line 1241
;1240:
;1241:				ScatterRopeSegment(rope.origin, rope.oldorigin, scatterTime);
ADDRLP4 52+68
ARGP4
ADDRLP4 52+84
ARGP4
ADDRLP4 24
INDIRI4
ARGI4
ADDRGP4 ScatterRopeSegment
CALLV
pop
line 1242
;1242:			}
LABELV $1102
line 1244
;1243:
;1244:			trap_R_AddRefEntityToScene(&rope);
ADDRLP4 52
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1245
;1245:		}
LABELV $1088
line 1247
;1246:
;1247:		VectorCopy(pos, lastPos);
ADDRLP4 8
ADDRLP4 36
INDIRB
ASGNB 12
line 1248
;1248:		hasLastPos = qtrue;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 1249
;1249:	}
LABELV $1074
line 1195
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1076
ADDRLP4 0
INDIRI4
ADDRLP4 28
INDIRI4
LTI4 $1073
line 1250
;1250:}
LABELV $1048
endproc CG_GrappleRope 192 12
export CG_Mover
proc CG_Mover 224 12
line 1258
;1251:#endif
;1252:
;1253:/*
;1254:===============
;1255:CG_Mover
;1256:===============
;1257:*/
;1258:/*static*/ void CG_Mover( centity_t *cent ) {	// JUHOX: also called from cg_draw.c for lens flare editor
line 1262
;1259:	refEntity_t			ent;
;1260:	entityState_t		*s1;
;1261:
;1262:	s1 = &cent->currentState;
ADDRLP4 140
ADDRFP4 0
INDIRP4
ASGNP4
line 1266
;1263:
;1264:#if ESCAPE_MODE	// JUHOX: only draw movers in the current vis area
;1265:	if (
;1266:		cgs.gametype == GT_EFH &&
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 9
NEI4 $1109
ADDRLP4 140
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
LTI4 $1114
ADDRLP4 140
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
LEI4 $1109
LABELV $1114
line 1271
;1267:		(
;1268:			s1->time < cg.snap->ps.persistant[PERS_MIN_SEGMENT] ||
;1269:			s1->time > cg.snap->ps.persistant[PERS_MAX_SEGMENT]
;1270:		)
;1271:	) {
line 1272
;1272:		return;
ADDRGP4 $1108
JUMPV
LABELV $1109
line 1277
;1273:	}
;1274:#endif
;1275:
;1276:#if ESCAPE_MODE	// JUHOX: sort movers in EFH
;1277:	if (sortMovers && s1->solid == SOLID_BMODEL) {
ADDRGP4 sortMovers
INDIRI4
CNSTI4 0
EQI4 $1115
ADDRLP4 140
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 16777215
NEI4 $1115
line 1284
;1278:		vec3_t origin;
;1279:		vec3_t dir;
;1280:		float distance;
;1281:		int i;
;1282:		int k;
;1283:
;1284:		VectorAdd(cent->lerpOrigin, cgs.inlineModelMidpoints[s1->modelindex], origin);
ADDRLP4 184
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 156
ADDRLP4 184
INDIRP4
CNSTI4 728
ADDP4
INDIRF4
ADDRLP4 140
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 cgs+38224
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 156+4
ADDRLP4 184
INDIRP4
CNSTI4 732
ADDP4
INDIRF4
ADDRLP4 140
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 cgs+38224+4
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 156+8
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRF4
ADDRLP4 140
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 cgs+38224+8
ADDP4
INDIRF4
ADDF4
ASGNF4
line 1285
;1285:		VectorSubtract(origin, cg.refdef.vieworg, dir);
ADDRLP4 172
ADDRLP4 156
INDIRF4
ADDRGP4 cg+109260+24
INDIRF4
SUBF4
ASGNF4
ADDRLP4 172+4
ADDRLP4 156+4
INDIRF4
ADDRGP4 cg+109260+24+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 172+8
ADDRLP4 156+8
INDIRF4
ADDRGP4 cg+109260+24+8
INDIRF4
SUBF4
ASGNF4
line 1286
;1286:		distance = DotProduct(dir, cg.refdef.viewaxis[0]);
ADDRLP4 168
ADDRLP4 172
INDIRF4
ADDRGP4 cg+109260+36
INDIRF4
MULF4
ADDRLP4 172+4
INDIRF4
ADDRGP4 cg+109260+36+4
INDIRF4
MULF4
ADDF4
ADDRLP4 172+8
INDIRF4
ADDRGP4 cg+109260+36+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 1287
;1287:		if (distance < 0) {
ADDRLP4 168
INDIRF4
CNSTF4 0
GEF4 $1146
line 1291
;1288:			vec3_t mins, maxs;
;1289:			float d;
;1290:
;1291:			trap_R_ModelBounds(cgs.inlineDrawModel[s1->modelindex], mins, maxs);
ADDRLP4 140
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+37200
ADDP4
INDIRI4
ARGI4
ADDRLP4 192
ARGP4
ADDRLP4 204
ARGP4
ADDRGP4 trap_R_ModelBounds
CALLV
pop
line 1292
;1292:			for (i = 0; i < 3; i++) {
ADDRLP4 148
CNSTI4 0
ASGNI4
LABELV $1149
line 1293
;1293:				if (cg.refdef.viewaxis[0][i] < 0) {
ADDRLP4 148
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+109260+36
ADDP4
INDIRF4
CNSTF4 0
GEF4 $1153
line 1294
;1294:					origin[i] = mins[i];
ADDRLP4 148
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 156
ADDP4
ADDRLP4 148
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 192
ADDP4
INDIRF4
ASGNF4
line 1295
;1295:				}
ADDRGP4 $1154
JUMPV
LABELV $1153
line 1296
;1296:				else {
line 1297
;1297:					origin[i] = maxs[i];
ADDRLP4 148
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 156
ADDP4
ADDRLP4 148
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 204
ADDP4
INDIRF4
ASGNF4
line 1298
;1298:				}
LABELV $1154
line 1299
;1299:			}
LABELV $1150
line 1292
ADDRLP4 148
ADDRLP4 148
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 3
LTI4 $1149
line 1300
;1300:			VectorAdd(cent->lerpOrigin, origin, origin);
ADDRLP4 220
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 156
ADDRLP4 220
INDIRP4
CNSTI4 728
ADDP4
INDIRF4
ADDRLP4 156
INDIRF4
ADDF4
ASGNF4
ADDRLP4 156+4
ADDRLP4 220
INDIRP4
CNSTI4 732
ADDP4
INDIRF4
ADDRLP4 156+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 156+8
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRF4
ADDRLP4 156+8
INDIRF4
ADDF4
ASGNF4
line 1301
;1301:			VectorSubtract(origin, cg.refdef.vieworg, dir);
ADDRLP4 172
ADDRLP4 156
INDIRF4
ADDRGP4 cg+109260+24
INDIRF4
SUBF4
ASGNF4
ADDRLP4 172+4
ADDRLP4 156+4
INDIRF4
ADDRGP4 cg+109260+24+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 172+8
ADDRLP4 156+8
INDIRF4
ADDRGP4 cg+109260+24+8
INDIRF4
SUBF4
ASGNF4
line 1302
;1302:			d = DotProduct(dir, cg.refdef.viewaxis[0]);
ADDRLP4 216
ADDRLP4 172
INDIRF4
ADDRGP4 cg+109260+36
INDIRF4
MULF4
ADDRLP4 172+4
INDIRF4
ADDRGP4 cg+109260+36+4
INDIRF4
MULF4
ADDF4
ADDRLP4 172+8
INDIRF4
ADDRGP4 cg+109260+36+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 1303
;1303:			if (d < 0) return;	// not visible at all
ADDRLP4 216
INDIRF4
CNSTF4 0
GEF4 $1183
ADDRGP4 $1108
JUMPV
LABELV $1183
line 1304
;1304:		}
LABELV $1146
line 1305
;1305:		for (i = 0; i < numSortedMovers; i++) {
ADDRLP4 148
CNSTI4 0
ASGNI4
ADDRGP4 $1188
JUMPV
LABELV $1185
line 1306
;1306:			if (distance <= sortedMovers[i].distance) break;
ADDRLP4 168
INDIRF4
ADDRLP4 148
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 sortedMovers+4
ADDP4
INDIRF4
GTF4 $1189
ADDRGP4 $1187
JUMPV
LABELV $1189
line 1307
;1307:		}
LABELV $1186
line 1305
ADDRLP4 148
ADDRLP4 148
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1188
ADDRLP4 148
INDIRI4
ADDRGP4 numSortedMovers
INDIRI4
LTI4 $1185
LABELV $1187
line 1309
;1308:
;1309:		for (k = numSortedMovers; k > i; k--) {
ADDRLP4 152
ADDRGP4 numSortedMovers
INDIRI4
ASGNI4
ADDRGP4 $1195
JUMPV
LABELV $1192
line 1310
;1310:			sortedMovers[k] = sortedMovers[k-1];
ADDRLP4 152
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 sortedMovers
ADDP4
ADDRLP4 152
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 sortedMovers-8
ADDP4
INDIRB
ASGNB 8
line 1311
;1311:		}
LABELV $1193
line 1309
ADDRLP4 152
ADDRLP4 152
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $1195
ADDRLP4 152
INDIRI4
ADDRLP4 148
INDIRI4
GTI4 $1192
line 1312
;1312:		sortedMovers[i].cent = cent;
ADDRLP4 148
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 sortedMovers
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 1313
;1313:		sortedMovers[i].distance = distance;
ADDRLP4 148
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 sortedMovers+4
ADDP4
ADDRLP4 168
INDIRF4
ASGNF4
line 1314
;1314:		numSortedMovers++;
ADDRLP4 192
ADDRGP4 numSortedMovers
ASGNP4
ADDRLP4 192
INDIRP4
ADDRLP4 192
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1315
;1315:		return;
ADDRGP4 $1108
JUMPV
LABELV $1115
line 1320
;1316:	}
;1317:#endif
;1318:
;1319:	// create the render entity
;1320:	memset (&ent, 0, sizeof(ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1321
;1321:	VectorCopy( cent->lerpOrigin, ent.origin);
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
INDIRB
ASGNB 12
line 1322
;1322:	VectorCopy( cent->lerpOrigin, ent.oldorigin);
ADDRLP4 0+84
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
INDIRB
ASGNB 12
line 1323
;1323:	AnglesToAxis( cent->lerpAngles, ent.axis );
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1343
;1324:
;1325:	// -JUHOX: mark selected mover
;1326:#if 0//MAPLENSFLARES
;1327:	if (cg.lfEditor.selectedMover == cent && cg.lfEditor.moversStopped) {
;1328:		static int onoff;
;1329:
;1330:		/* JUHOX FIXME: This doesn't work. I don't know why.
;1331:		ent.customShader = trap_R_RegisterShader("lfeditorcursor");
;1332:		ent.shaderRGBA[0] = 0x60;
;1333:		ent.shaderRGBA[1] = 0x00;
;1334:		ent.shaderRGBA[2] = 0x00;
;1335:		ent.shaderRGBA[3] = 0xff;
;1336:		*/
;1337:		//if (cg.time % 200 >= 100) return;
;1338:		onoff = !onoff;
;1339:		if (onoff) return;
;1340:	}
;1341:#endif
;1342:
;1343:	ent.renderfx = RF_NOSHADOW;
ADDRLP4 0+4
CNSTI4 64
ASGNI4
line 1346
;1344:
;1345:	// flicker between two skins (FIXME?)
;1346:	ent.skinNum = ( cg.time >> 6 ) & 1;
ADDRLP4 0+104
ADDRGP4 cg+107656
INDIRI4
CNSTI4 6
RSHI4
CNSTI4 1
BANDI4
ASGNI4
line 1349
;1347:
;1348:	// get the model, either as a bmodel or a modelindex
;1349:	if ( s1->solid == SOLID_BMODEL ) {
ADDRLP4 140
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 16777215
NEI4 $1204
line 1350
;1350:		ent.hModel = cgs.inlineDrawModel[s1->modelindex];
ADDRLP4 0+8
ADDRLP4 140
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+37200
ADDP4
INDIRI4
ASGNI4
line 1360
;1351:		// JUHOX: set corrected lighting origin for bmodels in EFH
;1352:		// JUHOX FIXME: doesn't work, there's still no dynamic lighting
;1353:#if 0//ESCAPE_MODE
;1354:		if (cgs.gametype == GT_EFH) {
;1355:			ent.renderfx |= RF_LIGHTING_ORIGIN;
;1356:			VectorAdd(ent.origin, cgs.inlineModelMidpoints[s1->modelindex], ent.lightingOrigin);
;1357:			//VectorClear(ent.lightingOrigin);
;1358:		}
;1359:#endif
;1360:	} else {
ADDRGP4 $1205
JUMPV
LABELV $1204
line 1363
;1361:		// JUHOX: set corrected light origin for EFH
;1362:#if ESCAPE_MODE
;1363:		if (cgs.gametype == GT_EFH) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 9
NEI4 $1208
line 1364
;1364:			ent.renderfx |= RF_LIGHTING_ORIGIN;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 1365
;1365:			VectorCopy(s1->angles2, ent.lightingOrigin);
ADDRLP4 0+12
ADDRLP4 140
INDIRP4
CNSTI4 128
ADDP4
INDIRB
ASGNB 12
line 1366
;1366:		}
LABELV $1208
line 1369
;1367:#endif
;1368:
;1369:		ent.hModel = cgs.gameModels[s1->modelindex];
ADDRLP4 0+8
ADDRLP4 140
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+35148
ADDP4
INDIRI4
ASGNI4
line 1370
;1370:	}
LABELV $1205
line 1373
;1371:
;1372:	// add to refresh list
;1373:	trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1376
;1374:
;1375:	// add the secondary model
;1376:	if ( s1->modelindex2 ) {
ADDRLP4 140
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1215
line 1377
;1377:		ent.skinNum = 0;
ADDRLP4 0+104
CNSTI4 0
ASGNI4
line 1378
;1378:		ent.hModel = cgs.gameModels[s1->modelindex2];
ADDRLP4 0+8
ADDRLP4 140
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+35148
ADDP4
INDIRI4
ASGNI4
line 1379
;1379:		trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1380
;1380:	}
LABELV $1215
line 1382
;1381:
;1382:}
LABELV $1108
endproc CG_Mover 224 12
proc CG_DrawSortedMovers 4 4
line 1390
;1383:
;1384:/*
;1385:===============
;1386:JUHOX: CG_DrawSortedMovers
;1387:===============
;1388:*/
;1389:#if ESCAPE_MODE
;1390:static void CG_DrawSortedMovers(void) {
line 1393
;1391:	int i;
;1392:
;1393:	sortMovers = qfalse;
ADDRGP4 sortMovers
CNSTI4 0
ASGNI4
line 1394
;1394:	for (i = 0; i < numSortedMovers; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1224
JUMPV
LABELV $1221
line 1395
;1395:		CG_Mover(sortedMovers[i].cent);
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 sortedMovers
ADDP4
INDIRP4
ARGP4
ADDRGP4 CG_Mover
CALLV
pop
line 1396
;1396:	}
LABELV $1222
line 1394
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1224
ADDRLP4 0
INDIRI4
ADDRGP4 numSortedMovers
INDIRI4
LTI4 $1221
line 1397
;1397:}
LABELV $1220
endproc CG_DrawSortedMovers 4 4
export CG_Beam
proc CG_Beam 144 12
line 1407
;1398:#endif
;1399:
;1400:/*
;1401:===============
;1402:CG_Beam
;1403:
;1404:Also called as an event
;1405:===============
;1406:*/
;1407:void CG_Beam( centity_t *cent ) {
line 1411
;1408:	refEntity_t			ent;
;1409:	entityState_t		*s1;
;1410:
;1411:	s1 = &cent->currentState;
ADDRLP4 140
ADDRFP4 0
INDIRP4
ASGNP4
line 1414
;1412:
;1413:	// create the render entity
;1414:	memset (&ent, 0, sizeof(ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1415
;1415:	VectorCopy( s1->pos.trBase, ent.origin );
ADDRLP4 0+68
ADDRLP4 140
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 1416
;1416:	VectorCopy( s1->origin2, ent.oldorigin );
ADDRLP4 0+84
ADDRLP4 140
INDIRP4
CNSTI4 104
ADDP4
INDIRB
ASGNB 12
line 1417
;1417:	AxisClear( ent.axis );
ADDRLP4 0+28
ARGP4
ADDRGP4 AxisClear
CALLV
pop
line 1418
;1418:	ent.reType = RT_BEAM;
ADDRLP4 0
CNSTI4 3
ASGNI4
line 1420
;1419:
;1420:	ent.renderfx = RF_NOSHADOW;
ADDRLP4 0+4
CNSTI4 64
ASGNI4
line 1423
;1421:
;1422:	// add to refresh list
;1423:	trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1424
;1424:}
LABELV $1225
endproc CG_Beam 144 12
proc CG_Portal 144 12
line 1432
;1425:
;1426:
;1427:/*
;1428:===============
;1429:CG_Portal
;1430:===============
;1431:*/
;1432:static void CG_Portal( centity_t *cent ) {
line 1436
;1433:	refEntity_t			ent;
;1434:	entityState_t		*s1;
;1435:
;1436:	s1 = &cent->currentState;
ADDRLP4 140
ADDRFP4 0
INDIRP4
ASGNP4
line 1439
;1437:
;1438:	// create the render entity
;1439:	memset (&ent, 0, sizeof(ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1440
;1440:	VectorCopy( cent->lerpOrigin, ent.origin );
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
INDIRB
ASGNB 12
line 1441
;1441:	VectorCopy( s1->origin2, ent.oldorigin );
ADDRLP4 0+84
ADDRLP4 140
INDIRP4
CNSTI4 104
ADDP4
INDIRB
ASGNB 12
line 1442
;1442:	ByteToDir( s1->eventParm, ent.axis[0] );
ADDRLP4 140
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 0+28
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 1443
;1443:	PerpendicularVector( ent.axis[1], ent.axis[0] );
ADDRLP4 0+28+12
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 PerpendicularVector
CALLV
pop
line 1447
;1444:
;1445:	// negating this tends to get the directions like they want
;1446:	// we really should have a camera roll value
;1447:	VectorSubtract( vec3_origin, ent.axis[1], ent.axis[1] );
ADDRLP4 0+28+12
ADDRGP4 vec3_origin
INDIRF4
ADDRLP4 0+28+12
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+28+12+4
ADDRGP4 vec3_origin+4
INDIRF4
ADDRLP4 0+28+12+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+28+12+8
ADDRGP4 vec3_origin+8
INDIRF4
ADDRLP4 0+28+12+8
INDIRF4
SUBF4
ASGNF4
line 1449
;1448:
;1449:	CrossProduct( ent.axis[0], ent.axis[1], ent.axis[2] );
ADDRLP4 0+28
ARGP4
ADDRLP4 0+28+12
ARGP4
ADDRLP4 0+28+24
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 1450
;1450:	ent.reType = RT_PORTALSURFACE;
ADDRLP4 0
CNSTI4 7
ASGNI4
line 1451
;1451:	ent.oldframe = s1->powerups;
ADDRLP4 0+96
ADDRLP4 140
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ASGNI4
line 1452
;1452:	ent.frame = s1->frame;		// rotation speed
ADDRLP4 0+80
ADDRLP4 140
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
ASGNI4
line 1453
;1453:	ent.skinNum = s1->clientNum/256.0 * 360;	// roll offset
ADDRLP4 0+104
ADDRLP4 140
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1068761088
MULF4
CVFI4 4
ASGNI4
line 1456
;1454:
;1455:	// add to refresh list
;1456:	trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1457
;1457:}
LABELV $1230
endproc CG_Portal 144 12
export CG_AdjustPositionForMover
proc CG_AdjustPositionForMover 80 12
line 1467
;1458:
;1459:
;1460:/*
;1461:=========================
;1462:CG_AdjustPositionForMover
;1463:
;1464:Also called by client movement prediction code
;1465:=========================
;1466:*/
;1467:void CG_AdjustPositionForMover( const vec3_t in, int moverNum, int fromTime, int toTime, vec3_t out ) {
line 1472
;1468:	centity_t	*cent;
;1469:	vec3_t	oldOrigin, origin, deltaOrigin;
;1470:	vec3_t	oldAngles, angles, deltaAngles;
;1471:
;1472:	if ( moverNum <= 0 || moverNum >= ENTITYNUM_MAX_NORMAL ) {
ADDRLP4 76
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
LEI4 $1266
ADDRLP4 76
INDIRI4
CNSTI4 1022
LTI4 $1264
LABELV $1266
line 1473
;1473:		VectorCopy( in, out );
ADDRFP4 16
INDIRP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 1474
;1474:		return;
ADDRGP4 $1263
JUMPV
LABELV $1264
line 1477
;1475:	}
;1476:
;1477:	cent = &cg_entities[ moverNum ];
ADDRLP4 0
ADDRFP4 4
INDIRI4
CNSTI4 880
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 1478
;1478:	if ( cent->currentState.eType != ET_MOVER ) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 4
EQI4 $1267
line 1479
;1479:		VectorCopy( in, out );
ADDRFP4 16
INDIRP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 1480
;1480:		return;
ADDRGP4 $1263
JUMPV
LABELV $1267
line 1483
;1481:	}
;1482:
;1483:	BG_EvaluateTrajectory( &cent->currentState.pos, fromTime, oldOrigin );
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 1484
;1484:	BG_EvaluateTrajectory( &cent->currentState.apos, fromTime, oldAngles );
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 40
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 1486
;1485:
;1486:	BG_EvaluateTrajectory( &cent->currentState.pos, toTime, origin );
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 28
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 1487
;1487:	BG_EvaluateTrajectory( &cent->currentState.apos, toTime, angles );
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 52
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 1489
;1488:
;1489:	VectorSubtract( origin, oldOrigin, deltaOrigin );
ADDRLP4 4
ADDRLP4 28
INDIRF4
ADDRLP4 16
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 28+4
INDIRF4
ADDRLP4 16+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 28+8
INDIRF4
ADDRLP4 16+8
INDIRF4
SUBF4
ASGNF4
line 1490
;1490:	VectorSubtract( angles, oldAngles, deltaAngles );
ADDRLP4 64
ADDRLP4 52
INDIRF4
ADDRLP4 40
INDIRF4
SUBF4
ASGNF4
ADDRLP4 64+4
ADDRLP4 52+4
INDIRF4
ADDRLP4 40+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 64+8
ADDRLP4 52+8
INDIRF4
ADDRLP4 40+8
INDIRF4
SUBF4
ASGNF4
line 1492
;1491:
;1492:	VectorAdd( in, deltaOrigin, out );
ADDRFP4 16
INDIRP4
ADDRFP4 0
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ASGNF4
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 4+4
INDIRF4
ADDF4
ASGNF4
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 4+8
INDIRF4
ADDF4
ASGNF4
line 1495
;1493:
;1494:	// FIXME: origin change when on a rotating object
;1495:}
LABELV $1263
endproc CG_AdjustPositionForMover 80 12
proc CG_InterpolateEntityPosition 44 12
line 1503
;1496:
;1497:
;1498:/*
;1499:=============================
;1500:CG_InterpolateEntityPosition
;1501:=============================
;1502:*/
;1503:static void CG_InterpolateEntityPosition( centity_t *cent ) {
line 1509
;1504:	vec3_t		current, next;
;1505:	float		f;
;1506:
;1507:	// it would be an internal error to find an entity that interpolates without
;1508:	// a snapshot ahead of the current one
;1509:	if ( cg.nextSnap == NULL ) {
ADDRGP4 cg+40
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1284
line 1510
;1510:		CG_Error( "CG_InterpoateEntityPosition: cg.nextSnap == NULL" );
ADDRGP4 $1287
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 1511
;1511:	}
LABELV $1284
line 1513
;1512:
;1513:	f = cg.frameInterpolation;
ADDRLP4 24
ADDRGP4 cg+107640
INDIRF4
ASGNF4
line 1517
;1514:
;1515:	// this will linearize a sine or parabolic curve, but it is important
;1516:	// to not extrapolate player positions if more recent data is available
;1517:	BG_EvaluateTrajectory( &cent->currentState.pos, cg.snap->serverTime, current );
ADDRFP4 0
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
ADDRLP4 12
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 1518
;1518:	BG_EvaluateTrajectory( &cent->nextState.pos, cg.nextSnap->serverTime, next );
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
ARGP4
ADDRGP4 cg+40
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 1520
;1519:#if ESCAPE_MODE
;1520:	VectorAdd(next, cg.referenceDelta, next);	// JUHOX
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRGP4 cg+107612
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRGP4 cg+107612+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRGP4 cg+107612+8
INDIRF4
ADDF4
ASGNF4
line 1523
;1521:#endif
;1522:
;1523:	cent->lerpOrigin[0] = current[0] + f * ( next[0] - current[0] );
ADDRLP4 28
ADDRLP4 12
INDIRF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
ADDRLP4 28
INDIRF4
ADDRLP4 24
INDIRF4
ADDRLP4 0
INDIRF4
ADDRLP4 28
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 1524
;1524:	cent->lerpOrigin[1] = current[1] + f * ( next[1] - current[1] );
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
ADDRLP4 12+4
INDIRF4
ADDRLP4 24
INDIRF4
ADDRLP4 0+4
INDIRF4
ADDRLP4 12+4
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 1525
;1525:	cent->lerpOrigin[2] = current[2] + f * ( next[2] - current[2] );
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
ADDRLP4 12+8
INDIRF4
ADDRLP4 24
INDIRF4
ADDRLP4 0+8
INDIRF4
ADDRLP4 12+8
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 1527
;1526:
;1527:	BG_EvaluateTrajectory( &cent->currentState.apos, cg.snap->serverTime, current );
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 1528
;1528:	BG_EvaluateTrajectory( &cent->nextState.apos, cg.nextSnap->serverTime, next );
ADDRFP4 0
INDIRP4
CNSTI4 256
ADDP4
ARGP4
ADDRGP4 cg+40
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 1530
;1529:
;1530:	cent->lerpAngles[0] = LerpAngle( current[0], next[0], f );
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 32
ADDRGP4 LerpAngle
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
ADDRLP4 32
INDIRF4
ASGNF4
line 1531
;1531:	cent->lerpAngles[1] = LerpAngle( current[1], next[1], f );
ADDRLP4 12+4
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 36
ADDRGP4 LerpAngle
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 744
ADDP4
ADDRLP4 36
INDIRF4
ASGNF4
line 1532
;1532:	cent->lerpAngles[2] = LerpAngle( current[2], next[2], f );
ADDRLP4 12+8
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 40
ADDRGP4 LerpAngle
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 748
ADDP4
ADDRLP4 40
INDIRF4
ASGNF4
line 1534
;1533:
;1534:}
LABELV $1283
endproc CG_InterpolateEntityPosition 44 12
export CG_CalcEntityLerpPositions
proc CG_CalcEntityLerpPositions 20 20
line 1542
;1535:
;1536:/*
;1537:===============
;1538:CG_CalcEntityLerpPositions
;1539:
;1540:===============
;1541:*/
;1542:/*static*/ void CG_CalcEntityLerpPositions( centity_t *cent ) {	// JUHOX: also called from cg_weapons.c
line 1545
;1543:
;1544:	// if this player does not want to see extrapolated players
;1545:	if ( !cg_smoothClients.integer ) {
ADDRGP4 cg_smoothClients+12
INDIRI4
CNSTI4 0
NEI4 $1313
line 1547
;1546:		// make sure the clients use TR_INTERPOLATE
;1547:		if ( cent->currentState.number < MAX_CLIENTS ) {
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 64
GEI4 $1316
line 1548
;1548:			cent->currentState.pos.trType = TR_INTERPOLATE;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 1
ASGNI4
line 1549
;1549:			cent->nextState.pos.trType = TR_INTERPOLATE;
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
CNSTI4 1
ASGNI4
line 1550
;1550:		}
LABELV $1316
line 1551
;1551:	}
LABELV $1313
line 1553
;1552:
;1553:	if ( cent->interpolate && cent->currentState.pos.trType == TR_INTERPOLATE ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1318
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1318
line 1554
;1554:		CG_InterpolateEntityPosition( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_InterpolateEntityPosition
CALLV
pop
line 1555
;1555:		return;
ADDRGP4 $1312
JUMPV
LABELV $1318
line 1560
;1556:	}
;1557:
;1558:	// first see if we can interpolate between two snaps for
;1559:	// linear extrapolated clients
;1560:	if ( cent->interpolate && cent->currentState.pos.trType == TR_LINEAR_STOP &&
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1320
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1320
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 64
GEI4 $1320
line 1561
;1561:											cent->currentState.number < MAX_CLIENTS) {
line 1562
;1562:		CG_InterpolateEntityPosition( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_InterpolateEntityPosition
CALLV
pop
line 1563
;1563:		return;
ADDRGP4 $1312
JUMPV
LABELV $1320
line 1588
;1564:	}
;1565:
;1566:	// -JUHOX: check for stopped movers
;1567:#if 0//MAPLENSFLARES
;1568:	if (
;1569:		cgs.editMode == EM_mlf &&
;1570:		cent->currentState.eType == ET_MOVER &&
;1571:		(
;1572:			cg.lfEditor.moversStopped ||
;1573:			(
;1574:				cg.lfEditor.selectedLFEnt &&
;1575:				cg.lfEditor.selectedLFEnt->lock == cent
;1576:			)
;1577:		)
;1578:	) {
;1579:		return;
;1580:	}
;1581:#endif
;1582:
;1583:#if SCREENSHOT_TOOLS
;1584:	cg.time -= cg.serverOffset;	// JUHOX
;1585:#endif
;1586:
;1587:	// just use the current frame and evaluate as best we can
;1588:	BG_EvaluateTrajectory( &cent->currentState.pos, cg.time, cent->lerpOrigin );
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
line 1589
;1589:	BG_EvaluateTrajectory( &cent->currentState.apos, cg.time, cent->lerpAngles );
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
line 1593
;1590:
;1591:	// adjust for riding a mover if it wasn't rolled into the predicted
;1592:	// player state
;1593:	if ( cent != &cg.predictedPlayerEntity ) {
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 cg+108156
CVPU4 4
EQU4 $1324
line 1594
;1594:		CG_AdjustPositionForMover( cent->lerpOrigin, cent->currentState.groundEntityNum, 
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 728
ADDP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+107656
INDIRI4
ARGI4
ADDRLP4 16
INDIRP4
CNSTI4 728
ADDP4
ARGP4
ADDRGP4 CG_AdjustPositionForMover
CALLV
pop
line 1596
;1595:		cg.snap->serverTime, cg.time, cent->lerpOrigin );
;1596:	}
LABELV $1324
line 1600
;1597:#if SCREENSHOT_TOOLS
;1598:	cg.time += cg.serverOffset;	// JUHOX
;1599:#endif
;1600:}
LABELV $1312
endproc CG_CalcEntityLerpPositions 20 20
proc CG_TeamBase 140 12
line 1607
;1601:
;1602:/*
;1603:===============
;1604:CG_TeamBase
;1605:===============
;1606:*/
;1607:static void CG_TeamBase( centity_t *cent ) {
line 1616
;1608:	refEntity_t model;
;1609:#ifdef MISSIONPACK
;1610:	vec3_t angles;
;1611:	int t, h;
;1612:	float c;
;1613:
;1614:	if ( cgs.gametype == GT_CTF || cgs.gametype == GT_1FCTF ) {
;1615:#else
;1616:	if ( cgs.gametype == GT_CTF) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
NEI4 $1330
line 1619
;1617:#endif
;1618:		// show the flag base
;1619:		memset(&model, 0, sizeof(model));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1620
;1620:		model.reType = RT_MODEL;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1621
;1621:		VectorCopy( cent->lerpOrigin, model.lightingOrigin );
ADDRLP4 0+12
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
INDIRB
ASGNB 12
line 1622
;1622:		VectorCopy( cent->lerpOrigin, model.origin );
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
INDIRB
ASGNB 12
line 1623
;1623:		AnglesToAxis( cent->currentState.angles, model.axis );
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1624
;1624:		if ( cent->currentState.modelindex == TEAM_RED ) {
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1336
line 1625
;1625:			model.hModel = cgs.media.redFlagBaseModel;
ADDRLP4 0+8
ADDRGP4 cgs+751220+160
INDIRI4
ASGNI4
line 1626
;1626:		}
ADDRGP4 $1337
JUMPV
LABELV $1336
line 1627
;1627:		else if ( cent->currentState.modelindex == TEAM_BLUE ) {
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1341
line 1628
;1628:			model.hModel = cgs.media.blueFlagBaseModel;
ADDRLP4 0+8
ADDRGP4 cgs+751220+164
INDIRI4
ASGNI4
line 1629
;1629:		}
ADDRGP4 $1342
JUMPV
LABELV $1341
line 1630
;1630:		else {
line 1631
;1631:			model.hModel = cgs.media.neutralFlagBaseModel;
ADDRLP4 0+8
ADDRGP4 cgs+751220+168
INDIRI4
ASGNI4
line 1632
;1632:		}
LABELV $1342
LABELV $1337
line 1633
;1633:		trap_R_AddRefEntityToScene( &model );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1634
;1634:	}
LABELV $1330
line 1753
;1635:#ifdef MISSIONPACK
;1636:	else if ( cgs.gametype == GT_OBELISK ) {
;1637:		// show the obelisk
;1638:		memset(&model, 0, sizeof(model));
;1639:		model.reType = RT_MODEL;
;1640:		VectorCopy( cent->lerpOrigin, model.lightingOrigin );
;1641:		VectorCopy( cent->lerpOrigin, model.origin );
;1642:		AnglesToAxis( cent->currentState.angles, model.axis );
;1643:
;1644:		model.hModel = cgs.media.overloadBaseModel;
;1645:		trap_R_AddRefEntityToScene( &model );
;1646:		// if hit
;1647:		if ( cent->currentState.frame == 1) {
;1648:			// show hit model
;1649:			// modelindex2 is the health value of the obelisk
;1650:			c = cent->currentState.modelindex2;
;1651:			model.shaderRGBA[0] = 0xff;
;1652:			model.shaderRGBA[1] = c;
;1653:			model.shaderRGBA[2] = c;
;1654:			model.shaderRGBA[3] = 0xff;
;1655:			//
;1656:			model.hModel = cgs.media.overloadEnergyModel;
;1657:			trap_R_AddRefEntityToScene( &model );
;1658:		}
;1659:		// if respawning
;1660:		if ( cent->currentState.frame == 2) {
;1661:			if ( !cent->miscTime ) {
;1662:				cent->miscTime = cg.time;
;1663:			}
;1664:			t = cg.time - cent->miscTime;
;1665:			h = (cg_obeliskRespawnDelay.integer - 5) * 1000;
;1666:			//
;1667:			if (t > h) {
;1668:				c = (float) (t - h) / h;
;1669:				if (c > 1)
;1670:					c = 1;
;1671:			}
;1672:			else {
;1673:				c = 0;
;1674:			}
;1675:			// show the lights
;1676:			AnglesToAxis( cent->currentState.angles, model.axis );
;1677:			//
;1678:			model.shaderRGBA[0] = c * 0xff;
;1679:			model.shaderRGBA[1] = c * 0xff;
;1680:			model.shaderRGBA[2] = c * 0xff;
;1681:			model.shaderRGBA[3] = c * 0xff;
;1682:
;1683:			model.hModel = cgs.media.overloadLightsModel;
;1684:			trap_R_AddRefEntityToScene( &model );
;1685:			// show the target
;1686:			if (t > h) {
;1687:				if ( !cent->muzzleFlashTime ) {
;1688:					trap_S_StartSound (cent->lerpOrigin, ENTITYNUM_NONE, CHAN_BODY,  cgs.media.obeliskRespawnSound);
;1689:					cent->muzzleFlashTime = 1;
;1690:				}
;1691:				VectorCopy(cent->currentState.angles, angles);
;1692:				angles[YAW] += (float) 16 * acos(1-c) * 180 / M_PI;
;1693:				AnglesToAxis( angles, model.axis );
;1694:
;1695:				VectorScale( model.axis[0], c, model.axis[0]);
;1696:				VectorScale( model.axis[1], c, model.axis[1]);
;1697:				VectorScale( model.axis[2], c, model.axis[2]);
;1698:
;1699:				model.shaderRGBA[0] = 0xff;
;1700:				model.shaderRGBA[1] = 0xff;
;1701:				model.shaderRGBA[2] = 0xff;
;1702:				model.shaderRGBA[3] = 0xff;
;1703:				//
;1704:				model.origin[2] += 56;
;1705:				model.hModel = cgs.media.overloadTargetModel;
;1706:				trap_R_AddRefEntityToScene( &model );
;1707:			}
;1708:			else {
;1709:				//FIXME: show animated smoke
;1710:			}
;1711:		}
;1712:		else {
;1713:			cent->miscTime = 0;
;1714:			cent->muzzleFlashTime = 0;
;1715:			// modelindex2 is the health value of the obelisk
;1716:			c = cent->currentState.modelindex2;
;1717:			model.shaderRGBA[0] = 0xff;
;1718:			model.shaderRGBA[1] = c;
;1719:			model.shaderRGBA[2] = c;
;1720:			model.shaderRGBA[3] = 0xff;
;1721:			// show the lights
;1722:			model.hModel = cgs.media.overloadLightsModel;
;1723:			trap_R_AddRefEntityToScene( &model );
;1724:			// show the target
;1725:			model.origin[2] += 56;
;1726:			model.hModel = cgs.media.overloadTargetModel;
;1727:			trap_R_AddRefEntityToScene( &model );
;1728:		}
;1729:	}
;1730:	else if ( cgs.gametype == GT_HARVESTER ) {
;1731:		// show harvester model
;1732:		memset(&model, 0, sizeof(model));
;1733:		model.reType = RT_MODEL;
;1734:		VectorCopy( cent->lerpOrigin, model.lightingOrigin );
;1735:		VectorCopy( cent->lerpOrigin, model.origin );
;1736:		AnglesToAxis( cent->currentState.angles, model.axis );
;1737:
;1738:		if ( cent->currentState.modelindex == TEAM_RED ) {
;1739:			model.hModel = cgs.media.harvesterModel;
;1740:			model.customSkin = cgs.media.harvesterRedSkin;
;1741:		}
;1742:		else if ( cent->currentState.modelindex == TEAM_BLUE ) {
;1743:			model.hModel = cgs.media.harvesterModel;
;1744:			model.customSkin = cgs.media.harvesterBlueSkin;
;1745:		}
;1746:		else {
;1747:			model.hModel = cgs.media.harvesterNeutralModel;
;1748:			model.customSkin = 0;
;1749:		}
;1750:		trap_R_AddRefEntityToScene( &model );
;1751:	}
;1752:#endif
;1753:}
LABELV $1329
endproc CG_TeamBase 140 12
proc CG_AddCEntity 8 8
line 1761
;1754:
;1755:/*
;1756:===============
;1757:CG_AddCEntity
;1758:
;1759:===============
;1760:*/
;1761:static void CG_AddCEntity( centity_t *cent ) {
line 1763
;1762:	// event-only entities will have been dealt with already
;1763:	if ( cent->currentState.eType >= ET_EVENTS ) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 14
LTI4 $1350
line 1764
;1764:		return;
ADDRGP4 $1349
JUMPV
LABELV $1350
line 1768
;1765:	}
;1766:
;1767:#if GRAPPLE_ROPE
;1768:	if (cent->currentState.eType == ET_GRAPPLE_ROPE) {	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 12
NEI4 $1352
line 1769
;1769:		CG_GrappleRope(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_GrappleRope
CALLV
pop
line 1770
;1770:		return;
ADDRGP4 $1349
JUMPV
LABELV $1352
line 1775
;1771:	}
;1772:#endif
;1773:
;1774:	// calculate the current origin
;1775:	CG_CalcEntityLerpPositions( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_CalcEntityLerpPositions
CALLV
pop
line 1778
;1776:
;1777:	// add automatic effects
;1778:	CG_EntityEffects( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_EntityEffects
CALLV
pop
line 1780
;1779:
;1780:	switch ( cent->currentState.eType ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1354
ADDRLP4 0
INDIRI4
CNSTI4 13
GTI4 $1354
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1369
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1369
address $1359
address $1360
address $1361
address $1362
address $1363
address $1364
address $1365
address $1366
address $1355
address $1355
address $1355
address $1367
address $1354
address $1368
code
LABELV $1354
line 1782
;1781:	default:
;1782:		CG_Error( "Bad entity type: %i\n", cent->currentState.eType );
ADDRGP4 $1357
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 1783
;1783:		break;
ADDRGP4 $1355
JUMPV
line 1787
;1784:	case ET_INVISIBLE:
;1785:	case ET_PUSH_TRIGGER:
;1786:	case ET_TELEPORT_TRIGGER:
;1787:		break;
LABELV $1359
line 1789
;1788:	case ET_GENERAL:
;1789:		CG_General( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_General
CALLV
pop
line 1790
;1790:		break;
ADDRGP4 $1355
JUMPV
LABELV $1360
line 1792
;1791:	case ET_PLAYER:
;1792:		CG_Player( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Player
CALLV
pop
line 1793
;1793:		break;
ADDRGP4 $1355
JUMPV
LABELV $1361
line 1795
;1794:	case ET_ITEM:
;1795:		CG_Item( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Item
CALLV
pop
line 1796
;1796:		break;
ADDRGP4 $1355
JUMPV
LABELV $1362
line 1798
;1797:	case ET_MISSILE:
;1798:		CG_Missile( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Missile
CALLV
pop
line 1799
;1799:		break;
ADDRGP4 $1355
JUMPV
LABELV $1363
line 1801
;1800:	case ET_MOVER:
;1801:		CG_Mover( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Mover
CALLV
pop
line 1802
;1802:		break;
ADDRGP4 $1355
JUMPV
LABELV $1364
line 1804
;1803:	case ET_BEAM:
;1804:		CG_Beam( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Beam
CALLV
pop
line 1805
;1805:		break;
ADDRGP4 $1355
JUMPV
LABELV $1365
line 1807
;1806:	case ET_PORTAL:
;1807:		CG_Portal( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Portal
CALLV
pop
line 1808
;1808:		break;
ADDRGP4 $1355
JUMPV
LABELV $1366
line 1810
;1809:	case ET_SPEAKER:
;1810:		CG_Speaker( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Speaker
CALLV
pop
line 1811
;1811:		break;
ADDRGP4 $1355
JUMPV
LABELV $1367
line 1813
;1812:	case ET_GRAPPLE:
;1813:		CG_Grapple( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Grapple
CALLV
pop
line 1814
;1814:		break;
ADDRGP4 $1355
JUMPV
LABELV $1368
line 1816
;1815:	case ET_TEAM:
;1816:		CG_TeamBase( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_TeamBase
CALLV
pop
line 1817
;1817:		break;
LABELV $1355
line 1819
;1818:	}
;1819:}
LABELV $1349
endproc CG_AddCEntity 8 8
export CG_DrawLineSegment
proc CG_DrawLineSegment 152 12
line 1830
;1820:
;1821:/*
;1822:===============
;1823:JUHOX: CG_DrawLineSegment
;1824:===============
;1825:*/
;1826:float CG_DrawLineSegment(
;1827:	const vec3_t start, const vec3_t end,
;1828:	float totalLength, float segmentSize, float scrollspeed,
;1829:	qhandle_t shader
;1830:) {
line 1834
;1831:	float frac;
;1832:	refEntity_t ent;
;1833:
;1834:	frac = totalLength / segmentSize;
ADDRLP4 140
ADDRFP4 8
INDIRF4
ADDRFP4 12
INDIRF4
DIVF4
ASGNF4
line 1835
;1835:	frac -= (int) frac;
ADDRLP4 140
ADDRLP4 140
INDIRF4
ADDRLP4 140
INDIRF4
CVFI4 4
CVIF4 4
SUBF4
ASGNF4
line 1837
;1836:
;1837:	memset(&ent, 0, sizeof(ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1838
;1838:	ent.reType = RT_LIGHTNING;
ADDRLP4 0
CNSTI4 6
ASGNI4
line 1839
;1839:	ent.customShader = shader;
ADDRLP4 0+112
ADDRFP4 20
INDIRI4
ASGNI4
line 1840
;1840:	VectorCopy(start, ent.origin);
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 1841
;1841:	VectorCopy(end, ent.oldorigin);
ADDRLP4 0+84
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 1843
;1842:
;1843:	ent.shaderTime = frac / -scrollspeed;
ADDRLP4 0+128
ADDRLP4 140
INDIRF4
ADDRFP4 16
INDIRF4
NEGF4
DIVF4
ASGNF4
line 1844
;1844:	trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1846
;1845:
;1846:	return totalLength + Distance(start, end);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 148
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRFP4 8
INDIRF4
ADDRLP4 148
INDIRF4
ADDF4
RETF4
LABELV $1370
endproc CG_DrawLineSegment 152 12
proc CG_DisplayNavAid 176 24
line 1854
;1847:}
;1848:
;1849:/*
;1850:===============
;1851:JUHOX: CG_DisplayNavAid
;1852:===============
;1853:*/
;1854:static void CG_DisplayNavAid(void) {
line 1855
;1855:	if (cg.snap->ps.stats[STAT_HEALTH] <= 0) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
GTI4 $1376
line 1856
;1856:		cg.navAidStopTime = 0;
ADDRGP4 cg+162908
CNSTI4 0
ASGNI4
line 1857
;1857:	}
LABELV $1376
line 1858
;1858:	if (cg.navAidStopTime) {
ADDRGP4 cg+162908
INDIRI4
CNSTI4 0
EQI4 $1380
line 1859
;1859:		if (cg.time < cg.navAidStopTime) {
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cg+162908
INDIRI4
GEI4 $1383
line 1866
;1860:			int packet;
;1861:			float totalLength;
;1862:			vec3_t lastPos;
;1863:			qboolean hasLastPos;
;1864:			refEntity_t ent;
;1865:
;1866:			hasLastPos = qfalse;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1867
;1867:			totalLength = 0;
ADDRLP4 20
CNSTF4 0
ASGNF4
line 1868
;1868:			for (packet = 0; packet < NAVAID_PACKETS; packet++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1387
line 1871
;1869:				int i;
;1870:				
;1871:				if (cg.navAidPacketTime[packet] < cg.navAidLatestUpdateTime) continue;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+162920
ADDP4
INDIRI4
ADDRGP4 cg+162912
INDIRI4
GEI4 $1391
ADDRGP4 $1388
JUMPV
LABELV $1391
line 1873
;1872:
;1873:				for (i = 0; i < cg.navAidPacketNumPos[packet]; i++) {
ADDRLP4 164
CNSTI4 0
ASGNI4
ADDRGP4 $1398
JUMPV
LABELV $1395
line 1874
;1874:					if (hasLastPos) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $1400
line 1875
;1875:						totalLength = CG_DrawLineSegment(
ADDRLP4 8
ARGP4
ADDRLP4 164
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 0
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 cg+162960
ADDP4
ADDP4
ARGP4
ADDRLP4 20
INDIRF4
ARGF4
CNSTF4 1132462080
ARGF4
CNSTF4 3212836864
ARGF4
ADDRGP4 cg+162916
INDIRI4
CNSTI4 0
EQI4 $1409
ADDRLP4 168
ADDRGP4 cgs+751220+268
INDIRI4
ASGNI4
ADDRGP4 $1410
JUMPV
LABELV $1409
ADDRLP4 168
ADDRGP4 cgs+751220+264
INDIRI4
ASGNI4
LABELV $1410
ADDRLP4 168
INDIRI4
ARGI4
ADDRLP4 172
ADDRGP4 CG_DrawLineSegment
CALLF4
ASGNF4
ADDRLP4 20
ADDRLP4 172
INDIRF4
ASGNF4
line 1880
;1876:							lastPos, cg.navAidPacketPos[packet][i],
;1877:							totalLength, 256.0, -1.0,
;1878:							cg.navAidRetreat? cgs.media.navaid2Shader : cgs.media.navaidShader
;1879:						);
;1880:					}
LABELV $1400
line 1881
;1881:					VectorCopy(cg.navAidPacketPos[packet][i], lastPos);
ADDRLP4 8
ADDRLP4 164
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 0
INDIRI4
CNSTI4 96
MULI4
ADDRGP4 cg+162960
ADDP4
ADDP4
INDIRB
ASGNB 12
line 1882
;1882:					hasLastPos = qtrue;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 1883
;1883:				}
LABELV $1396
line 1873
ADDRLP4 164
ADDRLP4 164
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1398
ADDRLP4 164
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+162940
ADDP4
INDIRI4
LTI4 $1395
line 1884
;1884:			}
LABELV $1388
line 1868
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 5
LTI4 $1387
line 1886
;1885:
;1886:			memset(&ent, 0, sizeof(ent));
ADDRLP4 24
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1887
;1887:			ent.customShader = cgs.media.navaidGoalShader;
ADDRLP4 24+112
ADDRGP4 cgs+751220+276
INDIRI4
ASGNI4
line 1888
;1888:			if (cg.navAidGoalEntity) {
ADDRGP4 cg+163460
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1415
line 1889
;1889:				VectorCopy(cg.navAidGoalEntity->currentState.pos.trBase, ent.origin);
ADDRLP4 24+68
ADDRGP4 cg+163460
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 1891
;1890:				if (
;1891:					cg.navAidGoalEntityNum >= 0 &&
ADDRGP4 cg+163456
INDIRI4
CNSTI4 0
LTI4 $1416
ADDRGP4 cg+163456
INDIRI4
CNSTI4 64
GEI4 $1416
line 1893
;1892:					cg.navAidGoalEntityNum < MAX_CLIENTS
;1893:				) {
line 1896
;1894:					clientInfo_t* ci;
;1895:
;1896:					ci = &cgs.clientinfo[cg.navAidGoalEntityNum];
ADDRLP4 164
ADDRGP4 cg+163456
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320
ADDP4
ASGNP4
line 1897
;1897:					if (ci->team != cg.snap->ps.persistant[PERS_TEAM]) {
ADDRLP4 164
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
EQI4 $1416
line 1898
;1898:						ent.customShader = cgs.media.navaidTargetShader;
ADDRLP4 24+112
ADDRGP4 cgs+751220+272
INDIRI4
ASGNI4
line 1899
;1899:					}
line 1900
;1900:				}
line 1901
;1901:			}
ADDRGP4 $1416
JUMPV
LABELV $1415
line 1902
;1902:			else if (cg.navAidGoalAvailable) {
ADDRGP4 cg+163452
INDIRI4
CNSTI4 0
EQI4 $1375
line 1903
;1903:				VectorCopy(cg.navAidGoal, ent.origin);
ADDRLP4 24+68
ADDRGP4 cg+163440
INDIRB
ASGNB 12
line 1904
;1904:			}
line 1905
;1905:			else {
line 1906
;1906:				return;
LABELV $1433
LABELV $1416
line 1908
;1907:			}
;1908:			ent.reType = RT_SPRITE;
ADDRLP4 24
CNSTI4 2
ASGNI4
line 1909
;1909:			ent.radius = 16;
ADDRLP4 24+132
CNSTF4 1098907648
ASGNF4
line 1910
;1910:			trap_R_AddRefEntityToScene(&ent);
ADDRLP4 24
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1911
;1911:		}
ADDRGP4 $1384
JUMPV
LABELV $1383
line 1912
;1912:		else {
line 1913
;1913:			cg.navAidStopTime = 0;
ADDRGP4 cg+162908
CNSTI4 0
ASGNI4
line 1914
;1914:		}
LABELV $1384
line 1915
;1915:	}
LABELV $1380
line 1916
;1916:}
LABELV $1375
endproc CG_DisplayNavAid 176 24
export CG_AddPacketEntities
proc CG_AddPacketEntities 16 12
line 1924
;1917:
;1918:/*
;1919:===============
;1920:CG_AddPacketEntities
;1921:
;1922:===============
;1923:*/
;1924:void CG_AddPacketEntities( void ) {
line 1930
;1925:	int					num;
;1926:	centity_t			*cent;
;1927:	playerState_t		*ps;
;1928:
;1929:	// set cg.frameInterpolation
;1930:	if ( cg.nextSnap ) {
ADDRGP4 cg+40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1440
line 1933
;1931:		int		delta;
;1932:
;1933:		delta = (cg.nextSnap->serverTime - cg.snap->serverTime);
ADDRLP4 12
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
SUBI4
ASGNI4
line 1934
;1934:		if ( delta == 0 ) {
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $1445
line 1935
;1935:			cg.frameInterpolation = 0;
ADDRGP4 cg+107640
CNSTF4 0
ASGNF4
line 1936
;1936:		} else {
ADDRGP4 $1441
JUMPV
LABELV $1445
line 1937
;1937:			cg.frameInterpolation = (float)( cg.time - cg.snap->serverTime ) / delta;
ADDRGP4 cg+107640
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 12
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 1938
;1938:		}
line 1939
;1939:	} else {
ADDRGP4 $1441
JUMPV
LABELV $1440
line 1940
;1940:		cg.frameInterpolation = 0;	// actually, it should never be used, because 
ADDRGP4 cg+107640
CNSTF4 0
ASGNF4
line 1942
;1941:									// no entities should be marked as interpolating
;1942:	}
LABELV $1441
line 1945
;1943:
;1944:	// the auto-rotating items will all have the same axis
;1945:	cg.autoAngles[0] = 0;
ADDRGP4 cg+109164
CNSTF4 0
ASGNF4
line 1946
;1946:	cg.autoAngles[1] = ( cg.time & 2047 ) * 360 / 2048.0;
ADDRGP4 cg+109164+4
ADDRGP4 cg+107656
INDIRI4
CNSTI4 2047
BANDI4
CNSTI4 360
MULI4
CVIF4 4
CNSTF4 973078528
MULF4
ASGNF4
line 1947
;1947:	cg.autoAngles[2] = 0;
ADDRGP4 cg+109164+8
CNSTF4 0
ASGNF4
line 1949
;1948:
;1949:	cg.autoAnglesFast[0] = 0;
ADDRGP4 cg+109212
CNSTF4 0
ASGNF4
line 1950
;1950:	cg.autoAnglesFast[1] = ( cg.time & 1023 ) * 360 / 1024.0f;
ADDRGP4 cg+109212+4
ADDRGP4 cg+107656
INDIRI4
CNSTI4 1023
BANDI4
CNSTI4 360
MULI4
CVIF4 4
CNSTF4 981467136
MULF4
ASGNF4
line 1951
;1951:	cg.autoAnglesFast[2] = 0;
ADDRGP4 cg+109212+8
CNSTF4 0
ASGNF4
line 1953
;1952:
;1953:	AnglesToAxis( cg.autoAngles, cg.autoAxis );
ADDRGP4 cg+109164
ARGP4
ADDRGP4 cg+109176
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1954
;1954:	AnglesToAxis( cg.autoAnglesFast, cg.autoAxisFast );
ADDRGP4 cg+109212
ARGP4
ADDRGP4 cg+109224
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1957
;1955:
;1956:	// generate and add the entity from the playerstate
;1957:	ps = &cg.predictedPlayerState;
ADDRLP4 8
ADDRGP4 cg+107688
ASGNP4
line 1958
;1958:	BG_PlayerStateToEntityState( ps, &cg.predictedPlayerEntity.currentState, qfalse );
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 cg+108156
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BG_PlayerStateToEntityState
CALLV
pop
line 1959
;1959:	CG_AddCEntity( &cg.predictedPlayerEntity );
ADDRGP4 cg+108156
ARGP4
ADDRGP4 CG_AddCEntity
CALLV
pop
line 1962
;1960:
;1961:	// lerp the non-predicted value for lightning gun origins
;1962:	CG_CalcEntityLerpPositions( &cg_entities[ cg.snap->ps.clientNum ] );
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
ADDRGP4 CG_CalcEntityLerpPositions
CALLV
pop
line 1966
;1963:
;1964:	// JUHOX: sorted movers for EFH
;1965:#if ESCAPE_MODE
;1966:	numSortedMovers = 0;
ADDRGP4 numSortedMovers
CNSTI4 0
ASGNI4
line 1967
;1967:	sortMovers = (cgs.gametype == GT_EFH);
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 9
NEI4 $1474
ADDRLP4 12
CNSTI4 1
ASGNI4
ADDRGP4 $1475
JUMPV
LABELV $1474
ADDRLP4 12
CNSTI4 0
ASGNI4
LABELV $1475
ADDRGP4 sortMovers
ADDRLP4 12
INDIRI4
ASGNI4
line 1970
;1968:#endif
;1969:
;1970:	cg.navAidGoalEntity = NULL;	// JUHOX
ADDRGP4 cg+163460
CNSTP4 0
ASGNP4
line 1972
;1971:	// add each entity sent over by the server
;1972:	for ( num = 0 ; num < cg.snap->numEntities ; num++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $1480
JUMPV
LABELV $1477
line 1973
;1973:		cent = &cg_entities[ cg.snap->entities[ num ].number ];
ADDRLP4 0
ADDRLP4 4
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
line 1974
;1974:		if (cent->currentState.number == cg.navAidGoalEntityNum) cg.navAidGoalEntity = cent;	// JUHOX
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+163456
INDIRI4
NEI4 $1483
ADDRGP4 cg+163460
ADDRLP4 0
INDIRP4
ASGNP4
LABELV $1483
line 1975
;1975:		CG_AddCEntity( cent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_AddCEntity
CALLV
pop
line 1976
;1976:	}
LABELV $1478
line 1972
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1480
ADDRLP4 4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
LTI4 $1477
line 1980
;1977:
;1978:	// JUHOX: sorted movers for EFH
;1979:#if ESCAPE_MODE
;1980:	if (sortMovers) {
ADDRGP4 sortMovers
INDIRI4
CNSTI4 0
EQI4 $1487
line 1981
;1981:		CG_DrawSortedMovers();
ADDRGP4 CG_DrawSortedMovers
CALLV
pop
line 1982
;1982:	}
LABELV $1487
line 1985
;1983:#endif
;1984:
;1985:	CG_DisplayNavAid();	// JUHOX
ADDRGP4 CG_DisplayNavAid
CALLV
pop
line 1986
;1986:}
LABELV $1439
endproc CG_AddPacketEntities 16 12
proc CG_PrepareEntityForGlassLook 20 20
line 1995
;1987:
;1988:/*
;1989:===============
;1990:JUHOX: CG_PrepareEntityForGlassLook
;1991:
;1992:derived in parts from CG_EntityEffects()
;1993:===============
;1994:*/
;1995:static void CG_PrepareEntityForGlassLook(centity_t* cent) {
line 1996
;1996:	CG_CalcEntityLerpPositions(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_CalcEntityLerpPositions
CALLV
pop
line 1999
;1997:
;1998:	// constant light glow
;1999:	if ( cent->currentState.constantLight ) {
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1490
line 2003
;2000:		int		cl;
;2001:		int		i, r, g, b;
;2002:
;2003:		cl = cent->currentState.constantLight;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
INDIRI4
ASGNI4
line 2004
;2004:		r = cl & 255;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 255
BANDI4
ASGNI4
line 2005
;2005:		g = ( cl >> 8 ) & 255;
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 8
RSHI4
CNSTI4 255
BANDI4
ASGNI4
line 2006
;2006:		b = ( cl >> 16 ) & 255;
ADDRLP4 16
ADDRLP4 0
INDIRI4
CNSTI4 16
RSHI4
CNSTI4 255
BANDI4
ASGNI4
line 2007
;2007:		i = ( ( cl >> 24 ) & 255 ) * 4;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 24
RSHI4
CNSTI4 255
BANDI4
CNSTI4 2
LSHI4
ASGNI4
line 2008
;2008:		trap_R_AddLightToScene( cent->lerpOrigin, i, r, g, b );
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
ARGP4
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 2009
;2009:	}
LABELV $1490
line 2010
;2010:}
LABELV $1489
endproc CG_PrepareEntityForGlassLook 20 20
export CG_AddPacketEntitiesForGlassLook
proc CG_AddPacketEntitiesForGlassLook 20 4
line 2019
;2011:
;2012:/*
;2013:===============
;2014:JUHOX: CG_AddPacketEntitiesForGlassLook
;2015:
;2016:derived from CG_AddPacketEntities()
;2017:===============
;2018:*/
;2019:void CG_AddPacketEntitiesForGlassLook(void) {
line 2024
;2020:	int					num;
;2021:	centity_t			*cent;
;2022:
;2023:	// set cg.frameInterpolation
;2024:	if ( cg.nextSnap ) {
ADDRGP4 cg+40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1493
line 2027
;2025:		int		delta;
;2026:
;2027:		delta = (cg.nextSnap->serverTime - cg.snap->serverTime);
ADDRLP4 8
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
SUBI4
ASGNI4
line 2028
;2028:		if ( delta == 0 ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $1498
line 2029
;2029:			cg.frameInterpolation = 0;
ADDRGP4 cg+107640
CNSTF4 0
ASGNF4
line 2030
;2030:		} else {
ADDRGP4 $1494
JUMPV
LABELV $1498
line 2031
;2031:			cg.frameInterpolation = (float)( cg.time - cg.snap->serverTime ) / delta;
ADDRGP4 cg+107640
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 8
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 2032
;2032:		}
line 2033
;2033:	} else {
ADDRGP4 $1494
JUMPV
LABELV $1493
line 2034
;2034:		cg.frameInterpolation = 0;	// actually, it should never be used, because 
ADDRGP4 cg+107640
CNSTF4 0
ASGNF4
line 2036
;2035:									// no entities should be marked as interpolating
;2036:	}
LABELV $1494
line 2039
;2037:
;2038:#if ESCAPE_MODE
;2039:	numSortedMovers = 0;
ADDRGP4 numSortedMovers
CNSTI4 0
ASGNI4
line 2040
;2040:	sortMovers = (cgs.gametype == GT_EFH);
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 9
NEI4 $1507
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRGP4 $1508
JUMPV
LABELV $1507
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $1508
ADDRGP4 sortMovers
ADDRLP4 8
INDIRI4
ASGNI4
line 2045
;2041:#endif
;2042:
;2043:	// add each mover entity sent over by the server
;2044:	// do not use sound nor lighting(?) effects
;2045:	for (num = 0; num < cg.snap->numEntities; num++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $1512
JUMPV
LABELV $1509
line 2046
;2046:		cent = &cg_entities[cg.snap->entities[num].number];
ADDRLP4 0
ADDRLP4 4
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
line 2048
;2047:
;2048:		switch (cent->currentState.eType) {
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
LTI4 $1515
ADDRLP4 12
INDIRI4
CNSTI4 13
GTI4 $1515
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1529
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1529
address $1518
address $1519
address $1522
address $1515
address $1523
address $1525
address $1527
address $1515
address $1515
address $1515
address $1515
address $1526
address $1528
address $1524
code
LABELV $1518
line 2050
;2049:		case ET_GENERAL:
;2050:			CG_PrepareEntityForGlassLook(cent);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_PrepareEntityForGlassLook
CALLV
pop
line 2051
;2051:			CG_General(cent);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_General
CALLV
pop
line 2052
;2052:			break;
ADDRGP4 $1516
JUMPV
LABELV $1519
line 2054
;2053:		case ET_PLAYER:
;2054:			if (!(cent->currentState.powerups & (1 << PW_INVIS))) {
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $1516
line 2055
;2055:				CG_PrepareEntityForGlassLook(cent);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_PrepareEntityForGlassLook
CALLV
pop
line 2056
;2056:				CG_Player(cent);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Player
CALLV
pop
line 2057
;2057:			}
line 2058
;2058:			break;
ADDRGP4 $1516
JUMPV
LABELV $1522
line 2060
;2059:		case ET_ITEM:
;2060:			CG_PrepareEntityForGlassLook(cent);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_PrepareEntityForGlassLook
CALLV
pop
line 2061
;2061:			CG_Item(cent);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Item
CALLV
pop
line 2062
;2062:			break;
ADDRGP4 $1516
JUMPV
LABELV $1523
line 2064
;2063:		case ET_MOVER:
;2064:			CG_PrepareEntityForGlassLook(cent);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_PrepareEntityForGlassLook
CALLV
pop
line 2065
;2065:			CG_Mover(cent);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Mover
CALLV
pop
line 2066
;2066:			break;
ADDRGP4 $1516
JUMPV
LABELV $1524
line 2068
;2067:		case ET_TEAM:
;2068:			CG_PrepareEntityForGlassLook(cent);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_PrepareEntityForGlassLook
CALLV
pop
line 2069
;2069:			CG_TeamBase(cent);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_TeamBase
CALLV
pop
line 2070
;2070:			break;
ADDRGP4 $1516
JUMPV
LABELV $1525
line 2072
;2071:		case ET_BEAM:
;2072:			CG_PrepareEntityForGlassLook(cent);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_PrepareEntityForGlassLook
CALLV
pop
line 2073
;2073:			CG_Beam(cent);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Beam
CALLV
pop
line 2074
;2074:			break;
ADDRGP4 $1516
JUMPV
LABELV $1526
line 2076
;2075:		case ET_GRAPPLE:
;2076:			CG_PrepareEntityForGlassLook(cent);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_PrepareEntityForGlassLook
CALLV
pop
line 2077
;2077:			CG_Grapple(cent);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Grapple
CALLV
pop
line 2078
;2078:			break;
ADDRGP4 $1516
JUMPV
LABELV $1527
line 2080
;2079:		case ET_PORTAL:
;2080:			CG_PrepareEntityForGlassLook(cent);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_PrepareEntityForGlassLook
CALLV
pop
line 2081
;2081:			CG_Portal(cent);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Portal
CALLV
pop
line 2082
;2082:			break;
ADDRGP4 $1516
JUMPV
LABELV $1528
line 2085
;2083:#if GRAPPLE_ROPE
;2084:		case ET_GRAPPLE_ROPE:
;2085:			CG_GrappleRope(cent);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_GrappleRope
CALLV
pop
line 2086
;2086:			break;
LABELV $1515
LABELV $1516
line 2089
;2087:#endif
;2088:		}
;2089:	}
LABELV $1510
line 2045
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1512
ADDRLP4 4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
LTI4 $1509
line 2092
;2090:
;2091:#if ESCAPE_MODE
;2092:	if (sortMovers) {
ADDRGP4 sortMovers
INDIRI4
CNSTI4 0
EQI4 $1530
line 2093
;2093:		CG_DrawSortedMovers();
ADDRGP4 CG_DrawSortedMovers
CALLV
pop
line 2094
;2094:	}
LABELV $1530
line 2096
;2095:#endif
;2096:}
LABELV $1492
endproc CG_AddPacketEntitiesForGlassLook 20 4
bss
align 4
LABELV sortedMovers
skip 2048
align 4
LABELV numSortedMovers
skip 4
align 4
LABELV sortMovers
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
import trap_S_StopBackgroundTrack
import trap_S_StartBackgroundTrack
import trap_S_RegisterSound
import trap_S_Respatialize
import trap_S_UpdateEntityPosition
import trap_S_ClearLoopingSounds
import trap_S_StartLocalSound
import trap_S_StopLoopingSound
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
import trap_S_AddRealLoopingSound
import trap_S_AddLoopingSound
import trap_S_StartSound
export currentReference
align 4
LABELV currentReference
skip 12
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
LABELV $1357
byte 1 66
byte 1 97
byte 1 100
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $1287
byte 1 67
byte 1 71
byte 1 95
byte 1 73
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 112
byte 1 111
byte 1 97
byte 1 116
byte 1 101
byte 1 69
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 80
byte 1 111
byte 1 115
byte 1 105
byte 1 116
byte 1 105
byte 1 111
byte 1 110
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
LABELV $606
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $210
byte 1 66
byte 1 97
byte 1 100
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 105
byte 1 110
byte 1 100
byte 1 101
byte 1 120
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 0
