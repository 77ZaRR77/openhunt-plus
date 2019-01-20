data
export pm_stopspeed
align 4
LABELV pm_stopspeed
byte 4 1120403456
export pm_duckScale
align 4
LABELV pm_duckScale
byte 4 1048576000
export pm_swimScale
align 4
LABELV pm_swimScale
byte 4 1056964608
export pm_wadeScale
align 4
LABELV pm_wadeScale
byte 4 1060320051
export pm_accelerate
align 4
LABELV pm_accelerate
byte 4 1092616192
export pm_airaccelerate
align 4
LABELV pm_airaccelerate
byte 4 1065353216
export pm_wateraccelerate
align 4
LABELV pm_wateraccelerate
byte 4 1082130432
export pm_flyaccelerate
align 4
LABELV pm_flyaccelerate
byte 4 1090519040
export pm_friction
align 4
LABELV pm_friction
byte 4 1086324736
export pm_waterfriction
align 4
LABELV pm_waterfriction
byte 4 1065353216
export pm_flightfriction
align 4
LABELV pm_flightfriction
byte 4 1077936128
export pm_spectatorfriction
align 4
LABELV pm_spectatorfriction
byte 4 1084227584
export c_pmove
align 4
LABELV c_pmove
byte 4 0
export PM_AddEvent
code
proc PM_AddEvent 0 12
file "..\..\..\..\code\game\bg_pmove.c"
line 38
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// bg_pmove.c -- both games player movement code
;4:// takes a playerstate and a usercmd as input and returns a modifed playerstate
;5:
;6:#include "q_shared.h"
;7:#include "bg_public.h"
;8:#include "bg_local.h"
;9:
;10:pmove_t		*pm;
;11:pml_t		pml;
;12:
;13:// movement parameters
;14:float	pm_stopspeed = 100.0f;
;15:float	pm_duckScale = 0.25f;
;16:float	pm_swimScale = 0.50f;
;17:float	pm_wadeScale = 0.70f;
;18:
;19:float	pm_accelerate = 10.0f;
;20:float	pm_airaccelerate = 1.0f;
;21:float	pm_wateraccelerate = 4.0f;
;22:float	pm_flyaccelerate = 8.0f;
;23:
;24:float	pm_friction = 6.0f;
;25:float	pm_waterfriction = 1.0f;
;26:float	pm_flightfriction = 3.0f;
;27:float	pm_spectatorfriction = 5.0f;
;28:
;29:int		c_pmove = 0;
;30:
;31:
;32:/*
;33:===============
;34:PM_AddEvent
;35:
;36:===============
;37:*/
;38:void PM_AddEvent( int newEvent ) {
line 40
;39:#if 1	// JUHOX BUGFIX: don't add zero event
;40:	if (!newEvent) return;
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $71
ADDRGP4 $70
JUMPV
LABELV $71
line 42
;41:#endif
;42:	BG_AddPredictableEventToPlayerstate( newEvent, 0, pm->ps );
ADDRFP4 0
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 pm
INDIRP4
INDIRP4
ARGP4
ADDRGP4 BG_AddPredictableEventToPlayerstate
CALLV
pop
line 43
;43:}
LABELV $70
endproc PM_AddEvent 0 12
export PM_AddTouchEnt
proc PM_AddTouchEnt 12 0
line 50
;44:
;45:/*
;46:===============
;47:PM_AddTouchEnt
;48:===============
;49:*/
;50:void PM_AddTouchEnt( int entityNum ) {
line 53
;51:	int		i;
;52:
;53:	if ( entityNum == ENTITYNUM_WORLD ) {
ADDRFP4 0
INDIRI4
CNSTI4 1022
NEI4 $74
line 54
;54:		return;
ADDRGP4 $73
JUMPV
LABELV $74
line 56
;55:	}
;56:	if ( pm->numtouch == MAXTOUCH ) {
ADDRGP4 pm
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 32
NEI4 $76
line 57
;57:		return;
ADDRGP4 $73
JUMPV
LABELV $76
line 61
;58:	}
;59:
;60:	// see if it is already added
;61:	for ( i = 0 ; i < pm->numtouch ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $81
JUMPV
LABELV $78
line 62
;62:		if ( pm->touchents[ i ] == entityNum ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 pm
INDIRP4
CNSTI4 84
ADDP4
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $82
line 63
;63:			return;
ADDRGP4 $73
JUMPV
LABELV $82
line 65
;64:		}
;65:	}
LABELV $79
line 61
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $81
ADDRLP4 0
INDIRI4
ADDRGP4 pm
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
LTI4 $78
line 68
;66:
;67:	// add it
;68:	pm->touchents[pm->numtouch] = entityNum;
ADDRLP4 4
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 84
ADDP4
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 69
;69:	pm->numtouch++;
ADDRLP4 8
ADDRGP4 pm
INDIRP4
CNSTI4 80
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
line 75
;70:#if 0	// -JUHOX: if an invisible player touches another player, mark him
;71:	if (entityNum < MAX_CLIENTS && pm->ps->powerups[PW_INVIS]) {
;72:		pm->ps->powerups[PW_BATTLESUIT] = pm->ps->commandTime + 500;
;73:	}
;74:#endif
;75:}
LABELV $73
endproc PM_AddTouchEnt 12 0
proc PM_StartTorsoAnim 4 0
line 82
;76:
;77:/*
;78:===================
;79:PM_StartTorsoAnim
;80:===================
;81:*/
;82:static void PM_StartTorsoAnim( int anim ) {
line 83
;83:	if ( pm->ps->pm_type >= PM_DEAD ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
LTI4 $85
line 84
;84:		return;
ADDRGP4 $84
JUMPV
LABELV $85
line 86
;85:	}
;86:	pm->ps->torsoAnim = ( ( pm->ps->torsoAnim & ANIM_TOGGLEBIT ) ^ ANIM_TOGGLEBIT )
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 128
BXORI4
ADDRFP4 0
INDIRI4
BORI4
ASGNI4
line 88
;87:		| anim;
;88:}
LABELV $84
endproc PM_StartTorsoAnim 4 0
proc PM_StartLegsAnim 4 0
line 89
;89:static void PM_StartLegsAnim( int anim ) {
line 90
;90:	if ( pm->ps->pm_type >= PM_DEAD ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
LTI4 $88
line 91
;91:		return;
ADDRGP4 $87
JUMPV
LABELV $88
line 93
;92:	}
;93:	if ( pm->ps->legsTimer > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
LEI4 $90
line 94
;94:		return;		// a high priority animation is running
ADDRGP4 $87
JUMPV
LABELV $90
line 96
;95:	}
;96:	pm->ps->legsAnim = ( ( pm->ps->legsAnim & ANIM_TOGGLEBIT ) ^ ANIM_TOGGLEBIT )
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 128
BXORI4
ADDRFP4 0
INDIRI4
BORI4
ASGNI4
line 98
;97:		| anim;
;98:}
LABELV $87
endproc PM_StartLegsAnim 4 0
proc PM_ContinueLegsAnim 0 4
line 100
;99:
;100:static void PM_ContinueLegsAnim( int anim ) {
line 101
;101:	if ( ( pm->ps->legsAnim & ~ANIM_TOGGLEBIT ) == anim ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ADDRFP4 0
INDIRI4
NEI4 $93
line 102
;102:		return;
ADDRGP4 $92
JUMPV
LABELV $93
line 104
;103:	}
;104:	if ( pm->ps->legsTimer > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
LEI4 $95
line 105
;105:		return;		// a high priority animation is running
ADDRGP4 $92
JUMPV
LABELV $95
line 107
;106:	}
;107:	PM_StartLegsAnim( anim );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 PM_StartLegsAnim
CALLV
pop
line 108
;108:}
LABELV $92
endproc PM_ContinueLegsAnim 0 4
proc PM_ContinueTorsoAnim 0 4
line 110
;109:
;110:static void PM_ContinueTorsoAnim( int anim ) {
line 111
;111:	if ( ( pm->ps->torsoAnim & ~ANIM_TOGGLEBIT ) == anim ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ADDRFP4 0
INDIRI4
NEI4 $98
line 112
;112:		return;
ADDRGP4 $97
JUMPV
LABELV $98
line 114
;113:	}
;114:	if ( pm->ps->torsoTimer > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
LEI4 $100
line 115
;115:		return;		// a high priority animation is running
ADDRGP4 $97
JUMPV
LABELV $100
line 117
;116:	}
;117:	PM_StartTorsoAnim( anim );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 118
;118:}
LABELV $97
endproc PM_ContinueTorsoAnim 0 4
proc PM_ForceLegsAnim 0 4
line 120
;119:
;120:static void PM_ForceLegsAnim( int anim ) {
line 121
;121:	pm->ps->legsTimer = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 0
ASGNI4
line 122
;122:	PM_StartLegsAnim( anim );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 PM_StartLegsAnim
CALLV
pop
line 123
;123:}
LABELV $102
endproc PM_ForceLegsAnim 0 4
export PM_ClipVelocity
proc PM_ClipVelocity 24 0
line 133
;124:
;125:
;126:/*
;127:==================
;128:PM_ClipVelocity
;129:
;130:Slide off of the impacting surface
;131:==================
;132:*/
;133:void PM_ClipVelocity( vec3_t in, vec3_t normal, vec3_t out, float overbounce ) {
line 138
;134:	float	backoff;
;135:	float	change;
;136:	int		i;
;137:	
;138:	backoff = DotProduct (in, normal);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 12
INDIRP4
INDIRF4
ADDRLP4 16
INDIRP4
INDIRF4
MULF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 140
;139:	
;140:	if ( backoff < 0 ) {
ADDRLP4 8
INDIRF4
CNSTF4 0
GEF4 $104
line 141
;141:		backoff *= overbounce;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRFP4 12
INDIRF4
MULF4
ASGNF4
line 142
;142:	} else {
ADDRGP4 $105
JUMPV
LABELV $104
line 143
;143:		backoff /= overbounce;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRFP4 12
INDIRF4
DIVF4
ASGNF4
line 144
;144:	}
LABELV $105
line 146
;145:
;146:	for ( i=0 ; i<3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $106
line 147
;147:		change = normal[i]*backoff;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
MULF4
ASGNF4
line 148
;148:		out[i] = in[i] - change;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
line 149
;149:	}
LABELV $107
line 146
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $106
line 150
;150:}
LABELV $103
endproc PM_ClipVelocity 24 0
proc PM_Friction 48 4
line 160
;151:
;152:
;153:/*
;154:==================
;155:PM_Friction
;156:
;157:Handles both ground friction and water friction
;158:==================
;159:*/
;160:static void PM_Friction( void ) {
line 166
;161:	vec3_t	vec;
;162:	float	*vel;
;163:	float	speed, newspeed, control;
;164:	float	drop;
;165:	
;166:	vel = pm->ps->velocity;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
line 168
;167:	
;168:	VectorCopy( vel, vec );
ADDRLP4 16
ADDRLP4 0
INDIRP4
INDIRB
ASGNB 12
line 169
;169:	if ( pml.walking ) {
ADDRGP4 pml+44
INDIRI4
CNSTI4 0
EQI4 $111
line 170
;170:		vec[2] = 0;	// ignore slope movement
ADDRLP4 16+8
CNSTF4 0
ASGNF4
line 171
;171:	}
LABELV $111
line 173
;172:
;173:	speed = VectorLength(vec);
ADDRLP4 16
ARGP4
ADDRLP4 32
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 32
INDIRF4
ASGNF4
line 174
;174:	if (speed < 1) {
ADDRLP4 8
INDIRF4
CNSTF4 1065353216
GEF4 $115
line 175
;175:		vel[0] = 0;
ADDRLP4 0
INDIRP4
CNSTF4 0
ASGNF4
line 176
;176:		vel[1] = 0;		// allow sinking underwater
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 0
ASGNF4
line 178
;177:		// FIXME: still have z friction underwater?
;178:		if (pm->ps->pm_type == PM_SPECTATOR) vel[2] = 0;	// JUHOX
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $110
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 0
ASGNF4
line 179
;179:		return;
ADDRGP4 $110
JUMPV
LABELV $115
line 182
;180:	}
;181:
;182:	drop = 0;
ADDRLP4 12
CNSTF4 0
ASGNF4
line 185
;183:
;184:	// apply ground friction
;185:	if ( pm->waterlevel <= 1 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CNSTI4 1
GTI4 $119
line 186
;186:		if ( pml.walking && !(pml.groundTrace.surfaceFlags & SURF_SLICK) ) {
ADDRGP4 pml+44
INDIRI4
CNSTI4 0
EQI4 $121
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $121
line 188
;187:			// if getting knocked back, no friction
;188:			if ( ! (pm->ps->pm_flags & PMF_TIME_KNOCKBACK) ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
NEI4 $126
line 189
;189:				control = speed < pm_stopspeed ? pm_stopspeed : speed;
ADDRLP4 8
INDIRF4
ADDRGP4 pm_stopspeed
INDIRF4
GEF4 $129
ADDRLP4 36
ADDRGP4 pm_stopspeed
INDIRF4
ASGNF4
ADDRGP4 $130
JUMPV
LABELV $129
ADDRLP4 36
ADDRLP4 8
INDIRF4
ASGNF4
LABELV $130
ADDRLP4 28
ADDRLP4 36
INDIRF4
ASGNF4
line 190
;190:				drop += control*pm_friction*pml.frametime;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 28
INDIRF4
ADDRGP4 pm_friction
INDIRF4
MULF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 191
;191:			}
LABELV $126
line 192
;192:		}
LABELV $121
line 193
;193:	}
LABELV $119
line 196
;194:
;195:	// apply water friction even if just wading
;196:	if ( pm->waterlevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CNSTI4 0
EQI4 $132
line 197
;197:		drop += speed*pm_waterfriction*pm->waterlevel*pml.frametime;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
ADDRGP4 pm_waterfriction
INDIRF4
MULF4
ADDRGP4 pm
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CVIF4 4
MULF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 198
;198:	}
LABELV $132
line 201
;199:
;200:	// apply flying friction
;201:	if ( pm->ps->powerups[PW_FLIGHT]) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
CNSTI4 0
EQI4 $135
line 202
;202:		drop += speed*pm_flightfriction*pml.frametime;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
ADDRGP4 pm_flightfriction
INDIRF4
MULF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 203
;203:	}
LABELV $135
line 205
;204:
;205:	if ( pm->ps->pm_type == PM_SPECTATOR) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $138
line 206
;206:		drop += speed*pm_spectatorfriction*pml.frametime;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
ADDRGP4 pm_spectatorfriction
INDIRF4
MULF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 207
;207:	}
LABELV $138
line 210
;208:
;209:#if	1	// JUHOX: scale friction by player size to simulate inertia
;210:	drop /= pm->scale;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRGP4 pm
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
DIVF4
ASGNF4
line 214
;211:#endif
;212:
;213:	// scale the velocity
;214:	newspeed = speed - drop;
ADDRLP4 4
ADDRLP4 8
INDIRF4
ADDRLP4 12
INDIRF4
SUBF4
ASGNF4
line 215
;215:	if (newspeed < 0) {
ADDRLP4 4
INDIRF4
CNSTF4 0
GEF4 $141
line 216
;216:		newspeed = 0;
ADDRLP4 4
CNSTF4 0
ASGNF4
line 217
;217:	}
LABELV $141
line 218
;218:	newspeed /= speed;
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
DIVF4
ASGNF4
line 220
;219:
;220:	vel[0] = vel[0] * newspeed;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 221
;221:	vel[1] = vel[1] * newspeed;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 222
;222:	vel[2] = vel[2] * newspeed;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 223
;223:}
LABELV $110
endproc PM_Friction 48 4
proc PM_Accelerate 32 0
line 233
;224:
;225:
;226:/*
;227:==============
;228:PM_Accelerate
;229:
;230:Handles user intended acceleration
;231:==============
;232:*/
;233:static void PM_Accelerate( vec3_t wishdir, float wishspeed, float accel ) {
line 236
;234:	// JUHOX: players loose speed if near total weariness
;235:#if 1
;236:	if (pm->ps->stats[STAT_STRENGTH] < LOW_STRENGTH_VALUE) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1161527296
GEF4 $144
line 237
;237:		wishspeed *= 0.55 + 0.45 * pm->ps->stats[STAT_STRENGTH] / LOW_STRENGTH_VALUE;
ADDRFP4 4
ADDRFP4 4
INDIRF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CVIF4 4
CNSTF4 958220626
MULF4
CNSTF4 1057803469
ADDF4
MULF4
ASGNF4
line 238
;238:	}
LABELV $144
line 242
;239:#endif
;240:	// JUHOX: spectators have infinite acceleration
;241:#if 1
;242:	if (pm->ps->pm_type == PM_SPECTATOR) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $146
line 243
;243:		VectorScale(wishdir, wishspeed, pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ADDRFP4 0
INDIRP4
INDIRF4
ADDRFP4 4
INDIRF4
MULF4
ASGNF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 36
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRFP4 4
INDIRF4
MULF4
ASGNF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 4
INDIRF4
MULF4
ASGNF4
line 244
;244:		return;
ADDRGP4 $143
JUMPV
LABELV $146
line 247
;245:	}
;246:#endif
;247:	{	// JUHOX: so variable declaration works
line 254
;248:
;249:#if 1
;250:	// q2 style
;251:	int			i;
;252:	float		addspeed, accelspeed, currentspeed;
;253:
;254:	currentspeed = DotProduct (pm->ps->velocity, wishdir);
ADDRLP4 16
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 16
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
INDIRF4
MULF4
ADDRLP4 16
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 16
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 255
;255:	addspeed = wishspeed - currentspeed;
ADDRLP4 8
ADDRFP4 4
INDIRF4
ADDRLP4 12
INDIRF4
SUBF4
ASGNF4
line 256
;256:	if (addspeed <= 0) {
ADDRLP4 8
INDIRF4
CNSTF4 0
GTF4 $148
line 257
;257:		return;
ADDRGP4 $143
JUMPV
LABELV $148
line 259
;258:	}
;259:	accelspeed = accel*pml.frametime*wishspeed;
ADDRLP4 4
ADDRFP4 8
INDIRF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDRFP4 4
INDIRF4
MULF4
ASGNF4
line 261
;260:#if 1	// JUHOX: scale acceleration by size to simulate inertia
;261:	accelspeed /= pm->scale;
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRGP4 pm
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
DIVF4
ASGNF4
line 263
;262:#endif
;263:	if (accelspeed > addspeed) {
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $151
line 264
;264:		accelspeed = addspeed;
ADDRLP4 4
ADDRLP4 8
INDIRF4
ASGNF4
line 265
;265:	}
LABELV $151
line 267
;266:	
;267:	for (i=0 ; i<3 ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $153
line 268
;268:		pm->ps->velocity[i] += accelspeed*wishdir[i];	
ADDRLP4 28
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 269
;269:	}
LABELV $154
line 267
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
line 289
;270:#else
;271:	// proper way (avoids strafe jump maxspeed bug), but feels bad
;272:	vec3_t		wishVelocity;
;273:	vec3_t		pushDir;
;274:	float		pushLen;
;275:	float		canPush;
;276:
;277:	VectorScale( wishdir, wishspeed, wishVelocity );
;278:	VectorSubtract( wishVelocity, pm->ps->velocity, pushDir );
;279:	pushLen = VectorNormalize( pushDir );
;280:
;281:	canPush = accel*pml.frametime*wishspeed;
;282:	if (canPush > pushLen) {
;283:		canPush = pushLen;
;284:	}
;285:
;286:	VectorMA( pm->ps->velocity, canPush, pushDir, pm->ps->velocity );
;287:#endif
;288:
;289:	}	// JUHOX: see above
line 290
;290:}
LABELV $143
endproc PM_Accelerate 32 0
proc PM_CmdScale 32 4
line 303
;291:
;292:
;293:
;294:/*
;295:============
;296:PM_CmdScale
;297:
;298:Returns the scale factor to apply to cmd movements
;299:This allows the clients to use axial -127 to 127 values for all directions
;300:without getting a sqrt(2) distortion in speed.
;301:============
;302:*/
;303:static float PM_CmdScale( usercmd_t *cmd ) {
line 308
;304:	int		max;
;305:	float	total;
;306:	float	scale;
;307:
;308:	max = abs( cmd->forwardmove );
ADDRFP4 0
INDIRP4
CNSTI4 21
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 12
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 309
;309:	if ( abs( cmd->rightmove ) > max ) {
ADDRFP4 0
INDIRP4
CNSTI4 22
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 16
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
ADDRLP4 0
INDIRI4
LEI4 $158
line 310
;310:		max = abs( cmd->rightmove );
ADDRFP4 0
INDIRP4
CNSTI4 22
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 20
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 20
INDIRI4
ASGNI4
line 311
;311:	}
LABELV $158
line 312
;312:	if ( abs( cmd->upmove ) > max ) {
ADDRFP4 0
INDIRP4
CNSTI4 23
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 20
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
ADDRLP4 0
INDIRI4
LEI4 $160
line 313
;313:		max = abs( cmd->upmove );
ADDRFP4 0
INDIRP4
CNSTI4 23
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 24
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 24
INDIRI4
ASGNI4
line 314
;314:	}
LABELV $160
line 315
;315:	if ( !max ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $162
line 316
;316:		return 0;
CNSTF4 0
RETF4
ADDRGP4 $157
JUMPV
LABELV $162
line 319
;317:	}
;318:
;319:	total = sqrt( cmd->forwardmove * cmd->forwardmove
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 21
ADDP4
INDIRI1
CVII4 1
ADDRLP4 24
INDIRP4
CNSTI4 21
ADDP4
INDIRI1
CVII4 1
MULI4
ADDRLP4 24
INDIRP4
CNSTI4 22
ADDP4
INDIRI1
CVII4 1
ADDRLP4 24
INDIRP4
CNSTI4 22
ADDP4
INDIRI1
CVII4 1
MULI4
ADDI4
ADDRLP4 24
INDIRP4
CNSTI4 23
ADDP4
INDIRI1
CVII4 1
ADDRLP4 24
INDIRP4
CNSTI4 23
ADDP4
INDIRI1
CVII4 1
MULI4
ADDI4
CVIF4 4
ARGF4
ADDRLP4 28
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 28
INDIRF4
ASGNF4
line 321
;320:		+ cmd->rightmove * cmd->rightmove + cmd->upmove * cmd->upmove );
;321:	scale = (float)pm->ps->speed * max / ( 127.0 * total );
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 0
INDIRI4
CVIF4 4
MULF4
ADDRLP4 4
INDIRF4
CNSTF4 1123942400
MULF4
DIVF4
ASGNF4
line 323
;322:
;323:	return scale;
ADDRLP4 8
INDIRF4
RETF4
LABELV $157
endproc PM_CmdScale 32 4
proc PM_SetMovementDir 36 0
line 335
;324:}
;325:
;326:
;327:/*
;328:================
;329:PM_SetMovementDir
;330:
;331:Determine the rotation of the legs reletive
;332:to the facing dir
;333:================
;334:*/
;335:static void PM_SetMovementDir( void ) {
line 336
;336:	if ( pm->cmd.forwardmove || pm->cmd.rightmove ) {
ADDRLP4 0
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $167
ADDRLP4 0
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $165
LABELV $167
line 337
;337:		if ( pm->cmd.rightmove == 0 && pm->cmd.forwardmove > 0 ) {
ADDRLP4 4
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $168
ADDRLP4 4
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LEI4 $168
line 338
;338:			pm->ps->movementDir = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 0
ASGNI4
line 339
;339:		} else if ( pm->cmd.rightmove < 0 && pm->cmd.forwardmove > 0 ) {
ADDRGP4 $166
JUMPV
LABELV $168
ADDRLP4 8
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $170
ADDRLP4 8
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LEI4 $170
line 340
;340:			pm->ps->movementDir = 1;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 1
ASGNI4
line 341
;341:		} else if ( pm->cmd.rightmove < 0 && pm->cmd.forwardmove == 0 ) {
ADDRGP4 $166
JUMPV
LABELV $170
ADDRLP4 12
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $172
ADDRLP4 12
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $172
line 342
;342:			pm->ps->movementDir = 2;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 2
ASGNI4
line 343
;343:		} else if ( pm->cmd.rightmove < 0 && pm->cmd.forwardmove < 0 ) {
ADDRGP4 $166
JUMPV
LABELV $172
ADDRLP4 16
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $174
ADDRLP4 16
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $174
line 344
;344:			pm->ps->movementDir = 3;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 3
ASGNI4
line 345
;345:		} else if ( pm->cmd.rightmove == 0 && pm->cmd.forwardmove < 0 ) {
ADDRGP4 $166
JUMPV
LABELV $174
ADDRLP4 20
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $176
ADDRLP4 20
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $176
line 346
;346:			pm->ps->movementDir = 4;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 4
ASGNI4
line 347
;347:		} else if ( pm->cmd.rightmove > 0 && pm->cmd.forwardmove < 0 ) {
ADDRGP4 $166
JUMPV
LABELV $176
ADDRLP4 24
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LEI4 $178
ADDRLP4 24
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $178
line 348
;348:			pm->ps->movementDir = 5;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 5
ASGNI4
line 349
;349:		} else if ( pm->cmd.rightmove > 0 && pm->cmd.forwardmove == 0 ) {
ADDRGP4 $166
JUMPV
LABELV $178
ADDRLP4 28
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LEI4 $180
ADDRLP4 28
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $180
line 350
;350:			pm->ps->movementDir = 6;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 6
ASGNI4
line 351
;351:		} else if ( pm->cmd.rightmove > 0 && pm->cmd.forwardmove > 0 ) {
ADDRGP4 $166
JUMPV
LABELV $180
ADDRLP4 32
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LEI4 $166
ADDRLP4 32
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LEI4 $166
line 352
;352:			pm->ps->movementDir = 7;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 7
ASGNI4
line 353
;353:		}
line 354
;354:	} else {
ADDRGP4 $166
JUMPV
LABELV $165
line 358
;355:		// if they aren't actively going directly sideways,
;356:		// change the animation to the diagonal so they
;357:		// don't stop too crooked
;358:		if ( pm->ps->movementDir == 2 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
CNSTI4 2
NEI4 $184
line 359
;359:			pm->ps->movementDir = 1;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 1
ASGNI4
line 360
;360:		} else if ( pm->ps->movementDir == 6 ) {
ADDRGP4 $185
JUMPV
LABELV $184
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
CNSTI4 6
NEI4 $186
line 361
;361:			pm->ps->movementDir = 7;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 7
ASGNI4
line 362
;362:		} 
LABELV $186
LABELV $185
line 363
;363:	}
LABELV $166
line 364
;364:}
LABELV $164
endproc PM_SetMovementDir 36 0
proc PM_CheckJump 16 4
line 372
;365:
;366:
;367:/*
;368:=============
;369:PM_CheckJump
;370:=============
;371:*/
;372:static qboolean PM_CheckJump( void ) {
line 373
;373:	if ( pm->ps->pm_flags & PMF_RESPAWNED ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $189
line 374
;374:		return qfalse;		// don't allow jump until all buttons are up
CNSTI4 0
RETI4
ADDRGP4 $188
JUMPV
LABELV $189
line 377
;375:	}
;376:
;377:	if ( pm->cmd.upmove < 10 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CNSTI4 10
GEI4 $191
line 379
;378:		// not holding jump
;379:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $188
JUMPV
LABELV $191
line 383
;380:	}
;381:
;382:	// must wait for jump to be released
;383:	if ( pm->ps->pm_flags & PMF_JUMP_HELD ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $193
line 385
;384:		// clear upmove so cmdscale doesn't lower running speed
;385:		pm->cmd.upmove = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
CNSTI1 0
ASGNI1
line 386
;386:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $188
JUMPV
LABELV $193
line 391
;387:	}
;388:
;389:	// JUHOX: calc jump weariness
;390:#if 1
;391:	if (pm->ps->stats[STAT_STRENGTH] > LOW_STRENGTH_VALUE) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1161527296
LEF4 $195
line 392
;392:		pm->ps->stats[STAT_STRENGTH] -= JUMP_STRENGTH_DECREASE;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 212
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CVIF4 4
CNSTF4 1153138688
SUBF4
CVFI4 4
ASGNI4
line 393
;393:	}
ADDRGP4 $196
JUMPV
LABELV $195
line 394
;394:	else {
line 395
;395:		pm->cmd.upmove = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
CNSTI1 0
ASGNI1
line 396
;396:		pm->ps->pm_flags |= PMF_JUMP_HELD;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 397
;397:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $188
JUMPV
LABELV $196
line 401
;398:	}
;399:#endif
;400:
;401:	pml.groundPlane = qfalse;		// jumping away
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 402
;402:	pml.walking = qfalse;
ADDRGP4 pml+44
CNSTI4 0
ASGNI4
line 403
;403:	pm->ps->pm_flags |= PMF_JUMP_HELD;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 405
;404:
;405:	pm->ps->groundEntityNum = ENTITYNUM_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
CNSTI4 1023
ASGNI4
line 406
;406:	pm->ps->velocity[2] = JUMP_VELOCITY;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1132920832
ASGNF4
line 409
;407:	// JUHOX: check for super jump
;408:#if MONSTER_MODE
;409:	pm->ps->velocity[2] *= 1 + (0.25 * (pm->scale - 1));
ADDRLP4 4
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 4
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
CNSTF4 1065353216
SUBF4
CNSTF4 1048576000
MULF4
CNSTF4 1065353216
ADDF4
MULF4
ASGNF4
line 410
;410:	if (pm->superJump) {
ADDRGP4 pm
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
EQI4 $199
line 411
;411:		pm->ps->velocity[2] *= 2;
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
CNSTF4 1073741824
MULF4
ASGNF4
line 412
;412:	}
LABELV $199
line 414
;413:#endif
;414:	PM_AddEvent( EV_JUMP );
CNSTI4 14
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 416
;415:
;416:	if ( pm->cmd.forwardmove >= 0 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LTI4 $201
line 417
;417:		PM_ForceLegsAnim( LEGS_JUMP );
CNSTI4 18
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 418
;418:		pm->ps->pm_flags &= ~PMF_BACKWARDS_JUMP;
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 -9
BANDI4
ASGNI4
line 419
;419:	} else {
ADDRGP4 $202
JUMPV
LABELV $201
line 420
;420:		PM_ForceLegsAnim( LEGS_JUMPB );
CNSTI4 20
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 421
;421:		pm->ps->pm_flags |= PMF_BACKWARDS_JUMP;
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 422
;422:	}
LABELV $202
line 424
;423:
;424:	return qtrue;
CNSTI4 1
RETI4
LABELV $188
endproc PM_CheckJump 16 4
proc PM_CheckWaterJump 52 8
line 432
;425:}
;426:
;427:/*
;428:=============
;429:PM_CheckWaterJump
;430:=============
;431:*/
;432:static qboolean	PM_CheckWaterJump( void ) {
line 437
;433:	vec3_t	spot;
;434:	int		cont;
;435:	vec3_t	flatforward;
;436:
;437:	if (pm->ps->pm_time) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 0
EQI4 $204
line 438
;438:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $203
JUMPV
LABELV $204
line 442
;439:	}
;440:
;441:	// check for water jump
;442:	if ( pm->waterlevel != 2 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CNSTI4 2
EQI4 $206
line 443
;443:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $203
JUMPV
LABELV $206
line 446
;444:	}
;445:
;446:	flatforward[0] = pml.forward[0];
ADDRLP4 12
ADDRGP4 pml
INDIRF4
ASGNF4
line 447
;447:	flatforward[1] = pml.forward[1];
ADDRLP4 12+4
ADDRGP4 pml+4
INDIRF4
ASGNF4
line 448
;448:	flatforward[2] = 0;
ADDRLP4 12+8
CNSTF4 0
ASGNF4
line 449
;449:	VectorNormalize (flatforward);
ADDRLP4 12
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 451
;450:
;451:	VectorMA (pm->ps->origin, 30, flatforward, spot);
ADDRLP4 28
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
CNSTF4 1106247680
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 28
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 12+4
INDIRF4
CNSTF4 1106247680
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 12+8
INDIRF4
CNSTF4 1106247680
MULF4
ADDF4
ASGNF4
line 452
;452:	spot[2] += 4;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1082130432
ADDF4
ASGNF4
line 453
;453:	cont = pm->pointcontents (spot, pm->ps->clientNum );
ADDRLP4 0
ARGP4
ADDRLP4 32
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
ADDRLP4 32
INDIRP4
CNSTI4 260
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 36
INDIRI4
ASGNI4
line 454
;454:	if ( !(cont & CONTENTS_SOLID) ) {
ADDRLP4 24
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $216
line 455
;455:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $203
JUMPV
LABELV $216
line 458
;456:	}
;457:
;458:	spot[2] += 16;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 459
;459:	cont = pm->pointcontents (spot, pm->ps->clientNum );
ADDRLP4 0
ARGP4
ADDRLP4 40
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 44
ADDRLP4 40
INDIRP4
CNSTI4 260
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 44
INDIRI4
ASGNI4
line 463
;460:#if 0	// JUHOX BUGFIX
;461:	if ( cont ) {
;462:#else
;463:	if (cont & (CONTENTS_SOLID | CONTENTS_PLAYERCLIP | CONTENTS_BODY)) {
ADDRLP4 24
INDIRI4
CNSTI4 33619969
BANDI4
CNSTI4 0
EQI4 $219
line 465
;464:#endif
;465:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $203
JUMPV
LABELV $219
line 469
;466:	}
;467:
;468:	// jump out of water
;469:	VectorScale (pml.forward, 200, pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ADDRGP4 pml
INDIRF4
CNSTF4 1128792064
MULF4
ASGNF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 36
ADDP4
ADDRGP4 pml+4
INDIRF4
CNSTF4 1128792064
MULF4
ASGNF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
ADDRGP4 pml+8
INDIRF4
CNSTF4 1128792064
MULF4
ASGNF4
line 470
;470:	pm->ps->velocity[2] = 350;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1135542272
ASGNF4
line 472
;471:
;472:	pm->ps->pm_flags |= PMF_TIME_WATERJUMP;
ADDRLP4 48
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 473
;473:	pm->ps->pm_time = 2000;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 2000
ASGNI4
line 475
;474:
;475:	return qtrue;
CNSTI4 1
RETI4
LABELV $203
endproc PM_CheckWaterJump 52 8
proc PM_WaterJumpMove 12 4
line 488
;476:}
;477:
;478://============================================================================
;479:
;480:
;481:/*
;482:===================
;483:PM_WaterJumpMove
;484:
;485:Flying out of the water
;486:===================
;487:*/
;488:static void PM_WaterJumpMove( void ) {
line 491
;489:	// waterjump has no control, but falls
;490:
;491:	PM_StepSlideMove( qtrue );
CNSTI4 1
ARGI4
ADDRGP4 PM_StepSlideMove
CALLV
pop
line 493
;492:
;493:	pm->ps->velocity[2] -= pm->ps->gravity * pml.frametime;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 pml+36
INDIRF4
MULF4
SUBF4
ASGNF4
line 494
;494:	if (pm->ps->velocity[2] < 0) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
CNSTF4 0
GEF4 $225
line 496
;495:		// cancel as soon as we are falling down again
;496:		pm->ps->pm_flags &= ~PMF_ALL_TIMES;
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 -353
BANDI4
ASGNI4
line 497
;497:		pm->ps->pm_time = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 0
ASGNI4
line 498
;498:	}
LABELV $225
line 499
;499:}
LABELV $223
endproc PM_WaterJumpMove 12 4
proc PM_WaterMove 76 16
line 507
;500:
;501:/*
;502:===================
;503:PM_WaterMove
;504:
;505:===================
;506:*/
;507:static void PM_WaterMove( void ) {
line 515
;508:	int		i;
;509:	vec3_t	wishvel;
;510:	float	wishspeed;
;511:	vec3_t	wishdir;
;512:	float	scale;
;513:	float	vel;
;514:
;515:	if ( PM_CheckWaterJump() ) {
ADDRLP4 40
ADDRGP4 PM_CheckWaterJump
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $228
line 516
;516:		PM_WaterJumpMove();
ADDRGP4 PM_WaterJumpMove
CALLV
pop
line 517
;517:		return;
ADDRGP4 $227
JUMPV
LABELV $228
line 533
;518:	}
;519:#if 0
;520:	// jump = head for surface
;521:	if ( pm->cmd.upmove >= 10 ) {
;522:		if (pm->ps->velocity[2] > -300) {
;523:			if ( pm->watertype == CONTENTS_WATER ) {
;524:				pm->ps->velocity[2] = 100;
;525:			} else if (pm->watertype == CONTENTS_SLIME) {
;526:				pm->ps->velocity[2] = 80;
;527:			} else {
;528:				pm->ps->velocity[2] = 50;
;529:			}
;530:		}
;531:	}
;532:#endif
;533:	PM_Friction ();
ADDRGP4 PM_Friction
CALLV
pop
line 535
;534:
;535:	scale = PM_CmdScale( &pm->cmd );
ADDRGP4 pm
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 44
ADDRGP4 PM_CmdScale
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 44
INDIRF4
ASGNF4
line 539
;536:	//
;537:	// user intentions
;538:	//
;539:	if ( !scale ) {
ADDRLP4 4
INDIRF4
CNSTF4 0
NEF4 $230
line 540
;540:		wishvel[0] = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 541
;541:		wishvel[1] = 0;
ADDRLP4 8+4
CNSTF4 0
ASGNF4
line 542
;542:		wishvel[2] = -60;		// sink towards bottom
ADDRLP4 8+8
CNSTF4 3262119936
ASGNF4
line 543
;543:	} else {
ADDRGP4 $231
JUMPV
LABELV $230
line 544
;544:		for (i=0 ; i<3 ; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $234
line 545
;545:			wishvel[i] = scale * pml.forward[i]*pm->cmd.forwardmove + scale * pml.right[i]*pm->cmd.rightmove;
ADDRLP4 56
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 pml
ADDP4
INDIRF4
MULF4
ADDRLP4 56
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 pml+12
ADDP4
INDIRF4
MULF4
ADDRLP4 56
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDF4
ASGNF4
LABELV $235
line 544
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $234
line 547
;546:
;547:		wishvel[2] += scale * pm->cmd.upmove;
ADDRLP4 8+8
ADDRLP4 8+8
INDIRF4
ADDRLP4 4
INDIRF4
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDF4
ASGNF4
line 548
;548:	}
LABELV $231
line 550
;549:
;550:	VectorCopy (wishvel, wishdir);
ADDRLP4 24
ADDRLP4 8
INDIRB
ASGNB 12
line 551
;551:	wishspeed = VectorNormalize(wishdir);
ADDRLP4 24
ARGP4
ADDRLP4 48
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 20
ADDRLP4 48
INDIRF4
ASGNF4
line 552
;552:	wishspeed *= pm_swimScale;	// JUHOX: bug fix (?)
ADDRLP4 20
ADDRLP4 20
INDIRF4
ADDRGP4 pm_swimScale
INDIRF4
MULF4
ASGNF4
line 554
;553:
;554:	if ( wishspeed > pm->ps->speed * pm_swimScale ) {
ADDRLP4 20
INDIRF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 pm_swimScale
INDIRF4
MULF4
LEF4 $240
line 555
;555:		wishspeed = pm->ps->speed * pm_swimScale;
ADDRLP4 20
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 pm_swimScale
INDIRF4
MULF4
ASGNF4
line 556
;556:	}
LABELV $240
line 558
;557:
;558:	PM_Accelerate (wishdir, wishspeed, pm_wateraccelerate);
ADDRLP4 24
ARGP4
ADDRLP4 20
INDIRF4
ARGF4
ADDRGP4 pm_wateraccelerate
INDIRF4
ARGF4
ADDRGP4 PM_Accelerate
CALLV
pop
line 561
;559:
;560:	// make sure we can go up slopes easily under water
;561:	if ( pml.groundPlane && DotProduct( pm->ps->velocity, pml.groundTrace.plane.normal ) < 0 ) {
ADDRGP4 pml+48
INDIRI4
CNSTI4 0
EQI4 $242
ADDRLP4 52
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRGP4 pml+52+24
INDIRF4
MULF4
ADDRLP4 52
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRGP4 pml+52+24+4
INDIRF4
MULF4
ADDF4
ADDRLP4 52
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRGP4 pml+52+24+8
INDIRF4
MULF4
ADDF4
CNSTF4 0
GEF4 $242
line 562
;562:		vel = VectorLength(pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 56
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 36
ADDRLP4 56
INDIRF4
ASGNF4
line 564
;563:		// slide along the ground plane
;564:		PM_ClipVelocity (pm->ps->velocity, pml.groundTrace.plane.normal, 
ADDRLP4 60
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 pml+52+24
ARGP4
ADDRLP4 60
INDIRP4
CNSTI4 32
ADDP4
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 567
;565:			pm->ps->velocity, OVERCLIP );
;566:
;567:		VectorNormalize(pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 568
;568:		VectorScale(pm->ps->velocity, vel, pm->ps->velocity);
ADDRLP4 64
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 64
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
ASGNF4
ADDRLP4 68
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 68
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
ASGNF4
ADDRLP4 72
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 72
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
ASGNF4
line 569
;569:	}
LABELV $242
line 571
;570:
;571:	PM_SlideMove( qfalse );
CNSTI4 0
ARGI4
ADDRGP4 PM_SlideMove
CALLI4
pop
line 572
;572:}
LABELV $227
endproc PM_WaterMove 76 16
proc PM_FlyMove 52 12
line 597
;573:
;574:#ifdef MISSIONPACK
;575:/*
;576:===================
;577:PM_InvulnerabilityMove
;578:
;579:Only with the invulnerability powerup
;580:===================
;581:*/
;582:static void PM_InvulnerabilityMove( void ) {
;583:	pm->cmd.forwardmove = 0;
;584:	pm->cmd.rightmove = 0;
;585:	pm->cmd.upmove = 0;
;586:	VectorClear(pm->ps->velocity);
;587:}
;588:#endif
;589:
;590:/*
;591:===================
;592:PM_FlyMove
;593:
;594:Only with the flight powerup
;595:===================
;596:*/
;597:static void PM_FlyMove( void ) {
line 605
;598:	int		i;
;599:	vec3_t	wishvel;
;600:	float	wishspeed;
;601:	vec3_t	wishdir;
;602:	float	scale;
;603:
;604:	// normal slowdown
;605:	PM_Friction ();
ADDRGP4 PM_Friction
CALLV
pop
line 607
;606:
;607:	scale = PM_CmdScale( &pm->cmd );
ADDRGP4 pm
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 36
ADDRGP4 PM_CmdScale
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 36
INDIRF4
ASGNF4
line 611
;608:	//
;609:	// user intentions
;610:	//
;611:	if ( !scale ) {
ADDRLP4 4
INDIRF4
CNSTF4 0
NEF4 $256
line 612
;612:		wishvel[0] = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 613
;613:		wishvel[1] = 0;
ADDRLP4 8+4
CNSTF4 0
ASGNF4
line 614
;614:		wishvel[2] = 0;
ADDRLP4 8+8
CNSTF4 0
ASGNF4
line 615
;615:	} else {
ADDRGP4 $257
JUMPV
LABELV $256
line 616
;616:		for (i=0 ; i<3 ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $260
line 617
;617:			wishvel[i] = scale * pml.forward[i]*pm->cmd.forwardmove + scale * pml.right[i]*pm->cmd.rightmove;
ADDRLP4 48
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 pml
ADDP4
INDIRF4
MULF4
ADDRLP4 48
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 pml+12
ADDP4
INDIRF4
MULF4
ADDRLP4 48
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDF4
ASGNF4
line 618
;618:		}
LABELV $261
line 616
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $260
line 620
;619:
;620:		wishvel[2] += scale * pm->cmd.upmove;
ADDRLP4 8+8
ADDRLP4 8+8
INDIRF4
ADDRLP4 4
INDIRF4
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDF4
ASGNF4
line 621
;621:	}
LABELV $257
line 623
;622:
;623:	VectorCopy (wishvel, wishdir);
ADDRLP4 20
ADDRLP4 8
INDIRB
ASGNB 12
line 624
;624:	wishspeed = VectorNormalize(wishdir);
ADDRLP4 20
ARGP4
ADDRLP4 40
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 32
ADDRLP4 40
INDIRF4
ASGNF4
line 626
;625:
;626:	PM_Accelerate (wishdir, wishspeed, pm_flyaccelerate);
ADDRLP4 20
ARGP4
ADDRLP4 32
INDIRF4
ARGF4
ADDRGP4 pm_flyaccelerate
INDIRF4
ARGF4
ADDRGP4 PM_Accelerate
CALLV
pop
line 628
;627:
;628:	PM_StepSlideMove( qfalse );
CNSTI4 0
ARGI4
ADDRGP4 PM_StepSlideMove
CALLV
pop
line 629
;629:}
LABELV $255
endproc PM_FlyMove 52 12
proc PM_AirMove 80 16
line 638
;630:
;631:
;632:/*
;633:===================
;634:PM_AirMove
;635:
;636:===================
;637:*/
;638:static void PM_AirMove( void ) {
line 647
;639:	int			i;
;640:	vec3_t		wishvel;
;641:	float		fmove, smove;
;642:	vec3_t		wishdir;
;643:	float		wishspeed;
;644:	float		scale;
;645:	usercmd_t	cmd;
;646:
;647:	PM_Friction();
ADDRGP4 PM_Friction
CALLV
pop
line 649
;648:
;649:	fmove = pm->cmd.forwardmove;
ADDRLP4 16
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ASGNF4
line 650
;650:	smove = pm->cmd.rightmove;
ADDRLP4 20
ADDRGP4 pm
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ASGNF4
line 652
;651:
;652:	cmd = pm->cmd;
ADDRLP4 44
ADDRGP4 pm
INDIRP4
CNSTI4 4
ADDP4
INDIRB
ASGNB 24
line 653
;653:	scale = PM_CmdScale( &cmd );
ADDRLP4 44
ARGP4
ADDRLP4 68
ADDRGP4 PM_CmdScale
CALLF4
ASGNF4
ADDRLP4 40
ADDRLP4 68
INDIRF4
ASGNF4
line 656
;654:
;655:	// set the movementDir so clients can rotate the legs for strafing
;656:	PM_SetMovementDir();
ADDRGP4 PM_SetMovementDir
CALLV
pop
line 659
;657:
;658:	// project moves down to flat plane
;659:	pml.forward[2] = 0;
ADDRGP4 pml+8
CNSTF4 0
ASGNF4
line 660
;660:	pml.right[2] = 0;
ADDRGP4 pml+12+8
CNSTF4 0
ASGNF4
line 661
;661:	VectorNormalize (pml.forward);
ADDRGP4 pml
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 662
;662:	VectorNormalize (pml.right);
ADDRGP4 pml+12
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 664
;663:
;664:	for ( i = 0 ; i < 2 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $271
line 665
;665:		wishvel[i] = pml.forward[i]*fmove + pml.right[i]*smove;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 pml
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 pml+12
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDF4
ASGNF4
line 666
;666:	}
LABELV $272
line 664
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LTI4 $271
line 667
;667:	wishvel[2] = 0;
ADDRLP4 4+8
CNSTF4 0
ASGNF4
line 669
;668:
;669:	VectorCopy (wishvel, wishdir);
ADDRLP4 24
ADDRLP4 4
INDIRB
ASGNB 12
line 670
;670:	wishspeed = VectorNormalize(wishdir);
ADDRLP4 24
ARGP4
ADDRLP4 72
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 36
ADDRLP4 72
INDIRF4
ASGNF4
line 671
;671:	wishspeed *= scale;
ADDRLP4 36
ADDRLP4 36
INDIRF4
ADDRLP4 40
INDIRF4
MULF4
ASGNF4
line 674
;672:
;673:	// not on ground, so little effect on velocity
;674:	PM_Accelerate (wishdir, wishspeed, pm_airaccelerate);
ADDRLP4 24
ARGP4
ADDRLP4 36
INDIRF4
ARGF4
ADDRGP4 pm_airaccelerate
INDIRF4
ARGF4
ADDRGP4 PM_Accelerate
CALLV
pop
line 679
;675:
;676:	// we may have a ground plane that is very steep, even
;677:	// though we don't have a groundentity
;678:	// slide along the steep plane
;679:	if ( pml.groundPlane ) {
ADDRGP4 pml+48
INDIRI4
CNSTI4 0
EQI4 $277
line 680
;680:		PM_ClipVelocity (pm->ps->velocity, pml.groundTrace.plane.normal, 
ADDRLP4 76
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 pml+52+24
ARGP4
ADDRLP4 76
INDIRP4
CNSTI4 32
ADDP4
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 682
;681:			pm->ps->velocity, OVERCLIP );
;682:	}
LABELV $277
line 694
;683:
;684:#if 0
;685:	//ZOID:  If we are on the grapple, try stair-stepping
;686:	//this allows a player to use the grapple to pull himself
;687:	//over a ledge
;688:	if (pm->ps->pm_flags & PMF_GRAPPLE_PULL)
;689:		PM_StepSlideMove ( qtrue );
;690:	else
;691:		PM_SlideMove ( qtrue );
;692:#endif
;693:
;694:	PM_StepSlideMove ( qtrue );
CNSTI4 1
ARGI4
ADDRGP4 PM_StepSlideMove
CALLV
pop
line 695
;695:}
LABELV $266
endproc PM_AirMove 80 16
proc PM_GrappleMove 80 4
line 703
;696:
;697:/*
;698:===================
;699:PM_GrappleMove
;700:
;701:===================
;702:*/
;703:static void PM_GrappleMove( void ) {
line 723
;704:#if !GRAPPLE_ROPE	// JUHOX: new grapple move
;705:	vec3_t vel, v;
;706:	float vlen;
;707:
;708:	VectorScale(pml.forward, -16, v);
;709:	VectorAdd(pm->ps->grapplePoint, v, v);
;710:	VectorSubtract(v, pm->ps->origin, vel);
;711:	vlen = VectorLength(vel);
;712:	VectorNormalize( vel );
;713:
;714:	if (vlen <= 100)
;715:		VectorScale(vel, 10 * vlen, vel);
;716:	else
;717:		VectorScale(vel, 800, vel);
;718:
;719:	VectorCopy(vel, pm->ps->velocity);
;720:
;721:	pml.groundPlane = qfalse;
;722:#else
;723:	switch (pm->hookMode) {
ADDRLP4 0
ADDRGP4 pm
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
LTI4 $284
ADDRLP4 0
INDIRI4
CNSTI4 4
GTI4 $284
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $335-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $335
address $286
address $310
address $310
address $310
code
LABELV $286
line 725
;724:	case HM_classic:
;725:		{
line 729
;726:			vec3_t vel, v;
;727:			float vlen;
;728:
;729:			VectorScale(pml.forward, -16.0f, v);
ADDRLP4 8
ADDRGP4 pml
INDIRF4
CNSTF4 3246391296
MULF4
ASGNF4
ADDRLP4 8+4
ADDRGP4 pml+4
INDIRF4
CNSTF4 3246391296
MULF4
ASGNF4
ADDRLP4 8+8
ADDRGP4 pml+8
INDIRF4
CNSTF4 3246391296
MULF4
ASGNF4
line 730
;730:			VectorAdd(pm->ps->grapplePoint, v, v);
ADDRLP4 36
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 36
INDIRP4
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
ADDF4
ASGNF4
ADDRLP4 8+4
ADDRLP4 36
INDIRP4
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ADDRLP4 8+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 8+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ADDRLP4 8+8
INDIRF4
ADDF4
ASGNF4
line 731
;731:			VectorSubtract(v, pm->ps->origin, vel);
ADDRLP4 40
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 20
ADDRLP4 8
INDIRF4
ADDRLP4 40
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 20+4
ADDRLP4 8+4
INDIRF4
ADDRLP4 40
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 20+8
ADDRLP4 8+8
INDIRF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
line 732
;732:			vlen = VectorLength(vel);
ADDRLP4 20
ARGP4
ADDRLP4 44
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 32
ADDRLP4 44
INDIRF4
ASGNF4
line 733
;733:			VectorNormalize( vel );
ADDRLP4 20
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 735
;734:	
;735:			if (vlen <= 100.0f)
ADDRLP4 32
INDIRF4
CNSTF4 1120403456
GTF4 $299
line 736
;736:				VectorScale(vel, 10.0f * vlen, vel);
ADDRLP4 48
ADDRLP4 32
INDIRF4
ASGNF4
ADDRLP4 20
ADDRLP4 20
INDIRF4
ADDRLP4 48
INDIRF4
CNSTF4 1092616192
MULF4
MULF4
ASGNF4
ADDRLP4 20+4
ADDRLP4 20+4
INDIRF4
ADDRLP4 48
INDIRF4
CNSTF4 1092616192
MULF4
MULF4
ASGNF4
ADDRLP4 20+8
ADDRLP4 20+8
INDIRF4
ADDRLP4 32
INDIRF4
CNSTF4 1092616192
MULF4
MULF4
ASGNF4
ADDRGP4 $300
JUMPV
LABELV $299
line 738
;737:			else
;738:				VectorScale(vel, GRAPPLE_PULL_SPEED_CLASSIC, vel);
ADDRLP4 20
ADDRLP4 20
INDIRF4
CNSTF4 1145569280
MULF4
ASGNF4
ADDRLP4 20+4
ADDRLP4 20+4
INDIRF4
CNSTF4 1145569280
MULF4
ASGNF4
ADDRLP4 20+8
ADDRLP4 20+8
INDIRF4
CNSTF4 1145569280
MULF4
ASGNF4
LABELV $300
line 740
;739:	
;740:			VectorCopy(vel, pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 20
INDIRB
ASGNB 12
line 742
;741:	
;742:			pml.groundPlane = qfalse;
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 743
;743:		}
line 744
;744:		break;
ADDRGP4 $284
JUMPV
LABELV $310
line 748
;745:	case HM_tool:
;746:	case HM_anchor:
;747:	case HM_combat:
;748:		{
line 753
;749:			vec3_t v;
;750:			float dist;
;751:			float pullSpeed;
;752:
;753:			VectorSubtract(pm->ps->grapplePoint, pm->ps->origin, v);
ADDRLP4 28
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 32
ADDRLP4 28
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 32
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 36
ADDRLP4 28
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 8+4
ADDRLP4 36
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ADDRLP4 36
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 40
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 8+8
ADDRLP4 40
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
line 754
;754:			dist = VectorNormalize(v);
ADDRLP4 8
ARGP4
ADDRLP4 44
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 24
ADDRLP4 44
INDIRF4
ASGNF4
line 756
;755:
;756:			pullSpeed = DotProduct(pm->ps->velocity, v);
ADDRLP4 48
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 20
ADDRLP4 48
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
MULF4
ADDRLP4 48
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 8+4
INDIRF4
MULF4
ADDF4
ADDRLP4 48
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 8+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 757
;757:			if (pm->ps->stats[STAT_GRAPPLE_STATE] == GST_fixed) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 2
NEI4 $315
line 758
;758:				if (dist > ROPE_ELEMENT_SIZE) {
ADDRLP4 24
INDIRF4
CNSTF4 1092616192
LEF4 $284
line 759
;759:					if (pullSpeed < 0) {
ADDRLP4 20
INDIRF4
CNSTF4 0
GEF4 $319
line 760
;760:						VectorScale(pm->ps->velocity, -0.7f, pm->ps->velocity);
ADDRLP4 52
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 52
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
CNSTF4 3207803699
MULF4
ASGNF4
ADDRLP4 56
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 56
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
CNSTF4 3207803699
MULF4
ASGNF4
ADDRLP4 60
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
CNSTF4 3207803699
MULF4
ASGNF4
line 761
;761:					}
LABELV $319
line 762
;762:					VectorMA(pm->ps->velocity, 50.0f * (dist - ROPE_ELEMENT_SIZE) * pml.frametime, v, pm->ps->velocity);
ADDRLP4 52
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 52
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
ADDRLP4 24
INDIRF4
CNSTF4 1092616192
SUBF4
CNSTF4 1112014848
MULF4
ADDRGP4 pml+36
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 56
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 56
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 8+4
INDIRF4
ADDRLP4 24
INDIRF4
CNSTF4 1092616192
SUBF4
CNSTF4 1112014848
MULF4
ADDRGP4 pml+36
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 60
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 8+8
INDIRF4
ADDRLP4 24
INDIRF4
CNSTF4 1092616192
SUBF4
CNSTF4 1112014848
MULF4
ADDRGP4 pml+36
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 763
;763:				}
line 764
;764:			}
ADDRGP4 $284
JUMPV
LABELV $315
line 765
;765:			else {
line 768
;766:				float desiredPullSpeed;
;767:	
;768:				if (pullSpeed < 0) {
ADDRLP4 20
INDIRF4
CNSTF4 0
GEF4 $326
line 769
;769:					pullSpeed = -pullSpeed;
ADDRLP4 20
ADDRLP4 20
INDIRF4
NEGF4
ASGNF4
line 770
;770:					VectorMA(pm->ps->velocity, 2 * pullSpeed, v, pm->ps->velocity);
ADDRLP4 56
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 56
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
ADDRLP4 20
INDIRF4
CNSTF4 1073741824
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 60
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 8+4
INDIRF4
ADDRLP4 20
INDIRF4
CNSTF4 1073741824
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 64
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 64
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 8+8
INDIRF4
ADDRLP4 20
INDIRF4
CNSTF4 1073741824
MULF4
MULF4
ADDF4
ASGNF4
line 771
;771:					VectorScale(pm->ps->velocity, 0.7, pm->ps->velocity);
ADDRLP4 68
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 68
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
CNSTF4 1060320051
MULF4
ASGNF4
ADDRLP4 72
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 72
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
CNSTF4 1060320051
MULF4
ASGNF4
ADDRLP4 76
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 76
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
CNSTF4 1060320051
MULF4
ASGNF4
line 772
;772:				}
LABELV $326
line 774
;773:	
;774:				desiredPullSpeed = pm->ps->stats[STAT_GRAPPLE_SPEED];
ADDRLP4 52
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 775
;775:				pullSpeed = VectorLength(pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 56
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 20
ADDRLP4 56
INDIRF4
ASGNF4
line 776
;776:				if (pullSpeed < desiredPullSpeed) {
ADDRLP4 20
INDIRF4
ADDRLP4 52
INDIRF4
GEF4 $330
line 777
;777:					VectorMA(pm->ps->velocity, (desiredPullSpeed - pullSpeed), v, pm->ps->velocity);
ADDRLP4 60
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
ADDRLP4 52
INDIRF4
ADDRLP4 20
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
ADDRLP4 64
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 64
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 8+4
INDIRF4
ADDRLP4 52
INDIRF4
ADDRLP4 20
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
ADDRLP4 68
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 68
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 8+8
INDIRF4
ADDRLP4 52
INDIRF4
ADDRLP4 20
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 778
;778:				}
LABELV $330
line 780
;779:		
;780:				pml.groundPlane = qfalse;
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 781
;781:			}
line 782
;782:		}
line 783
;783:		break;
line 785
;784:	default:
;785:		break;
LABELV $284
line 788
;786:	}
;787:#endif
;788:}
LABELV $282
endproc PM_GrappleMove 80 4
proc PM_WalkMove 116 16
line 796
;789:
;790:/*
;791:===================
;792:PM_WalkMove
;793:
;794:===================
;795:*/
;796:static void PM_WalkMove( void ) {
line 807
;797:	int			i;
;798:	vec3_t		wishvel;
;799:	float		fmove, smove;
;800:	vec3_t		wishdir;
;801:	float		wishspeed;
;802:	float		scale;
;803:	usercmd_t	cmd;
;804:	float		accelerate;
;805:	float		vel;
;806:
;807:	if ( pm->waterlevel > 2 && DotProduct( pml.forward, pml.groundTrace.plane.normal ) > 0 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CNSTI4 2
LEI4 $338
ADDRGP4 pml
INDIRF4
ADDRGP4 pml+52+24
INDIRF4
MULF4
ADDRGP4 pml+4
INDIRF4
ADDRGP4 pml+52+24+4
INDIRF4
MULF4
ADDF4
ADDRGP4 pml+8
INDIRF4
ADDRGP4 pml+52+24+8
INDIRF4
MULF4
ADDF4
CNSTF4 0
LEF4 $338
line 809
;808:		// begin swimming
;809:		PM_WaterMove();
ADDRGP4 PM_WaterMove
CALLV
pop
line 810
;810:		return;
ADDRGP4 $337
JUMPV
LABELV $338
line 814
;811:	}
;812:
;813:
;814:	if ( PM_CheckJump () ) {
ADDRLP4 76
ADDRGP4 PM_CheckJump
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
EQI4 $350
line 816
;815:		// jumped away
;816:		if ( pm->waterlevel > 1 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CNSTI4 1
LEI4 $352
line 817
;817:			PM_WaterMove();
ADDRGP4 PM_WaterMove
CALLV
pop
line 818
;818:		} else {
ADDRGP4 $337
JUMPV
LABELV $352
line 819
;819:			PM_AirMove();
ADDRGP4 PM_AirMove
CALLV
pop
line 820
;820:		}
line 821
;821:		return;
ADDRGP4 $337
JUMPV
LABELV $350
line 824
;822:	}
;823:
;824:	PM_Friction ();
ADDRGP4 PM_Friction
CALLV
pop
line 826
;825:
;826:	fmove = pm->cmd.forwardmove;
ADDRLP4 16
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ASGNF4
line 827
;827:	smove = pm->cmd.rightmove;
ADDRLP4 20
ADDRGP4 pm
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ASGNF4
line 829
;828:
;829:	cmd = pm->cmd;
ADDRLP4 48
ADDRGP4 pm
INDIRP4
CNSTI4 4
ADDP4
INDIRB
ASGNB 24
line 830
;830:	scale = PM_CmdScale( &cmd );
ADDRLP4 48
ARGP4
ADDRLP4 80
ADDRGP4 PM_CmdScale
CALLF4
ASGNF4
ADDRLP4 44
ADDRLP4 80
INDIRF4
ASGNF4
line 833
;831:
;832:	// set the movementDir so clients can rotate the legs for strafing
;833:	PM_SetMovementDir();
ADDRGP4 PM_SetMovementDir
CALLV
pop
line 836
;834:
;835:	// project moves down to flat plane
;836:	pml.forward[2] = 0;
ADDRGP4 pml+8
CNSTF4 0
ASGNF4
line 837
;837:	pml.right[2] = 0;
ADDRGP4 pml+12+8
CNSTF4 0
ASGNF4
line 840
;838:
;839:	// project the forward and right directions onto the ground plane
;840:	PM_ClipVelocity (pml.forward, pml.groundTrace.plane.normal, pml.forward, OVERCLIP );
ADDRLP4 84
ADDRGP4 pml
ASGNP4
ADDRLP4 84
INDIRP4
ARGP4
ADDRGP4 pml+52+24
ARGP4
ADDRLP4 84
INDIRP4
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 841
;841:	PM_ClipVelocity (pml.right, pml.groundTrace.plane.normal, pml.right, OVERCLIP );
ADDRGP4 pml+12
ARGP4
ADDRGP4 pml+52+24
ARGP4
ADDRGP4 pml+12
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 843
;842:	//
;843:	VectorNormalize (pml.forward);
ADDRGP4 pml
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 844
;844:	VectorNormalize (pml.right);
ADDRGP4 pml+12
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 846
;845:
;846:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $364
line 847
;847:		wishvel[i] = pml.forward[i]*fmove + pml.right[i]*smove;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 pml
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 pml+12
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDF4
ASGNF4
line 848
;848:	}
LABELV $365
line 846
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $364
line 852
;849:	// when going up or down slopes the wish velocity should Not be zero
;850://	wishvel[2] = 0;
;851:
;852:	VectorCopy (wishvel, wishdir);
ADDRLP4 32
ADDRLP4 4
INDIRB
ASGNB 12
line 853
;853:	wishspeed = VectorNormalize(wishdir);
ADDRLP4 32
ARGP4
ADDRLP4 88
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 24
ADDRLP4 88
INDIRF4
ASGNF4
line 854
;854:	wishspeed *= scale;
ADDRLP4 24
ADDRLP4 24
INDIRF4
ADDRLP4 44
INDIRF4
MULF4
ASGNF4
line 857
;855:
;856:	// clamp the speed lower if ducking
;857:	if ( pm->ps->pm_flags & PMF_DUCKED ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $369
line 858
;858:		if ( wishspeed > pm->ps->speed * pm_duckScale ) {
ADDRLP4 24
INDIRF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 pm_duckScale
INDIRF4
MULF4
LEF4 $371
line 859
;859:			wishspeed = pm->ps->speed * pm_duckScale;
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 pm_duckScale
INDIRF4
MULF4
ASGNF4
line 860
;860:		}
LABELV $371
line 861
;861:	}
LABELV $369
line 864
;862:
;863:	// clamp the speed lower if wading or walking on the bottom
;864:	if ( pm->waterlevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CNSTI4 0
EQI4 $373
line 867
;865:		float	waterScale;
;866:
;867:		waterScale = pm->waterlevel / 3.0;
ADDRLP4 92
ADDRGP4 pm
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1051372203
MULF4
ASGNF4
line 868
;868:		waterScale = 1.0 - ( 1.0 - pm_swimScale ) * waterScale;
ADDRLP4 92
CNSTF4 1065353216
CNSTF4 1065353216
ADDRGP4 pm_swimScale
INDIRF4
SUBF4
ADDRLP4 92
INDIRF4
MULF4
SUBF4
ASGNF4
line 869
;869:		if ( wishspeed > pm->ps->speed * waterScale ) {
ADDRLP4 24
INDIRF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 92
INDIRF4
MULF4
LEF4 $375
line 870
;870:			wishspeed = pm->ps->speed * waterScale;
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 92
INDIRF4
MULF4
ASGNF4
line 871
;871:		}
LABELV $375
line 872
;872:	}
LABELV $373
line 876
;873:
;874:	// when a player gets hit, they temporarily lose
;875:	// full control, which allows them to be moved a bit
;876:	if ( ( pml.groundTrace.surfaceFlags & SURF_SLICK ) || pm->ps->pm_flags & PMF_TIME_KNOCKBACK ) {
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $381
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $377
LABELV $381
line 877
;877:		accelerate = pm_airaccelerate;
ADDRLP4 72
ADDRGP4 pm_airaccelerate
INDIRF4
ASGNF4
line 878
;878:	} else {
ADDRGP4 $378
JUMPV
LABELV $377
line 879
;879:		accelerate = pm_accelerate;
ADDRLP4 72
ADDRGP4 pm_accelerate
INDIRF4
ASGNF4
line 880
;880:	}
LABELV $378
line 882
;881:
;882:	PM_Accelerate (wishdir, wishspeed, accelerate);
ADDRLP4 32
ARGP4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 72
INDIRF4
ARGF4
ADDRGP4 PM_Accelerate
CALLV
pop
line 887
;883:
;884:	//Com_Printf("velocity = %1.1f %1.1f %1.1f\n", pm->ps->velocity[0], pm->ps->velocity[1], pm->ps->velocity[2]);
;885:	//Com_Printf("velocity1 = %1.1f\n", VectorLength(pm->ps->velocity));
;886:
;887:	if ( ( pml.groundTrace.surfaceFlags & SURF_SLICK ) || pm->ps->pm_flags & PMF_TIME_KNOCKBACK ) {
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $386
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $382
LABELV $386
line 888
;888:		pm->ps->velocity[2] -= pm->ps->gravity * pml.frametime;
ADDRLP4 92
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 96
ADDRLP4 92
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 96
INDIRP4
ADDRLP4 96
INDIRP4
INDIRF4
ADDRLP4 92
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 pml+36
INDIRF4
MULF4
SUBF4
ASGNF4
line 889
;889:	} else {
LABELV $382
line 892
;890:		// don't reset the z velocity for slopes
;891://		pm->ps->velocity[2] = 0;
;892:	}
LABELV $383
line 894
;893:
;894:	vel = VectorLength(pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 92
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 92
INDIRF4
ASGNF4
line 897
;895:
;896:	// slide along the ground plane
;897:	PM_ClipVelocity (pm->ps->velocity, pml.groundTrace.plane.normal, 
ADDRLP4 96
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 pml+52+24
ARGP4
ADDRLP4 96
INDIRP4
CNSTI4 32
ADDP4
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 901
;898:		pm->ps->velocity, OVERCLIP );
;899:
;900:	// don't decrease velocity when going up or down a slope
;901:	VectorNormalize(pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 902
;902:	VectorScale(pm->ps->velocity, vel, pm->ps->velocity);
ADDRLP4 100
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 100
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
ADDRLP4 104
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 104
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 104
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
ADDRLP4 108
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 108
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 108
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 905
;903:
;904:	// don't do anything if standing still
;905:	if (!pm->ps->velocity[0] && !pm->ps->velocity[1]) {
ADDRLP4 112
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 112
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
CNSTF4 0
NEF4 $390
ADDRLP4 112
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
CNSTF4 0
NEF4 $390
line 906
;906:		return;
ADDRGP4 $337
JUMPV
LABELV $390
line 909
;907:	}
;908:
;909:	PM_StepSlideMove( qfalse );
CNSTI4 0
ARGI4
ADDRGP4 PM_StepSlideMove
CALLV
pop
line 913
;910:
;911:	//Com_Printf("velocity2 = %1.1f\n", VectorLength(pm->ps->velocity));
;912:
;913:}
LABELV $337
endproc PM_WalkMove 116 16
proc PM_DeadMove 20 4
line 921
;914:
;915:
;916:/*
;917:==============
;918:PM_DeadMove
;919:==============
;920:*/
;921:static void PM_DeadMove( void ) {
line 924
;922:	float	forward;
;923:
;924:	if ( !pml.walking ) {
ADDRGP4 pml+44
INDIRI4
CNSTI4 0
NEI4 $393
line 925
;925:		return;
ADDRGP4 $392
JUMPV
LABELV $393
line 930
;926:	}
;927:
;928:	// extra friction
;929:
;930:	forward = VectorLength (pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 931
;931:	forward -= 20;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1101004800
SUBF4
ASGNF4
line 932
;932:	if ( forward <= 0 ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
GTF4 $396
line 933
;933:		VectorClear (pm->ps->velocity);
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 12
CNSTF4 0
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
line 934
;934:	} else {
ADDRGP4 $397
JUMPV
LABELV $396
line 935
;935:		VectorNormalize (pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 936
;936:		VectorScale (pm->ps->velocity, forward, pm->ps->velocity);
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
ADDRLP4 16
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 937
;937:	}
LABELV $397
line 938
;938:}
LABELV $392
endproc PM_DeadMove 20 4
proc PM_NoclipMove 92 12
line 946
;939:
;940:
;941:/*
;942:===============
;943:PM_NoclipMove
;944:===============
;945:*/
;946:static void PM_NoclipMove( void ) {
line 955
;947:	float	speed, drop, friction, control, newspeed;
;948:	int			i;
;949:	vec3_t		wishvel;
;950:	float		fmove, smove;
;951:	vec3_t		wishdir;
;952:	float		wishspeed;
;953:	float		scale;
;954:
;955:	pm->ps->viewheight = DEFAULT_VIEWHEIGHT;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 26
ASGNI4
line 959
;956:
;957:	// friction
;958:
;959:	speed = VectorLength (pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 64
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 24
ADDRLP4 64
INDIRF4
ASGNF4
line 960
;960:	if (speed < 1)
ADDRLP4 24
INDIRF4
CNSTF4 1065353216
GEF4 $399
line 961
;961:	{
line 962
;962:		VectorCopy (vec3_origin, pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ADDRGP4 vec3_origin
INDIRB
ASGNB 12
line 963
;963:	}
ADDRGP4 $400
JUMPV
LABELV $399
line 965
;964:	else
;965:	{
line 966
;966:		drop = 0;
ADDRLP4 52
CNSTF4 0
ASGNF4
line 968
;967:
;968:		friction = pm_friction*1.5;	// extra friction
ADDRLP4 56
ADDRGP4 pm_friction
INDIRF4
CNSTF4 1069547520
MULF4
ASGNF4
line 969
;969:		control = speed < pm_stopspeed ? pm_stopspeed : speed;
ADDRLP4 24
INDIRF4
ADDRGP4 pm_stopspeed
INDIRF4
GEF4 $402
ADDRLP4 68
ADDRGP4 pm_stopspeed
INDIRF4
ASGNF4
ADDRGP4 $403
JUMPV
LABELV $402
ADDRLP4 68
ADDRLP4 24
INDIRF4
ASGNF4
LABELV $403
ADDRLP4 60
ADDRLP4 68
INDIRF4
ASGNF4
line 970
;970:		drop += control*friction*pml.frametime;
ADDRLP4 52
ADDRLP4 52
INDIRF4
ADDRLP4 60
INDIRF4
ADDRLP4 56
INDIRF4
MULF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 973
;971:
;972:		// scale the velocity
;973:		newspeed = speed - drop;
ADDRLP4 28
ADDRLP4 24
INDIRF4
ADDRLP4 52
INDIRF4
SUBF4
ASGNF4
line 974
;974:		if (newspeed < 0)
ADDRLP4 28
INDIRF4
CNSTF4 0
GEF4 $405
line 975
;975:			newspeed = 0;
ADDRLP4 28
CNSTF4 0
ASGNF4
LABELV $405
line 976
;976:		newspeed /= speed;
ADDRLP4 28
ADDRLP4 28
INDIRF4
ADDRLP4 24
INDIRF4
DIVF4
ASGNF4
line 978
;977:
;978:		VectorScale (pm->ps->velocity, newspeed, pm->ps->velocity);
ADDRLP4 72
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 72
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
ADDRLP4 76
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 76
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
ADDRLP4 80
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 80
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 979
;979:	}
LABELV $400
line 982
;980:
;981:	// accelerate
;982:	scale = PM_CmdScale( &pm->cmd );
ADDRGP4 pm
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 68
ADDRGP4 PM_CmdScale
CALLF4
ASGNF4
ADDRLP4 48
ADDRLP4 68
INDIRF4
ASGNF4
line 984
;983:
;984:	fmove = pm->cmd.forwardmove;
ADDRLP4 16
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ASGNF4
line 985
;985:	smove = pm->cmd.rightmove;
ADDRLP4 20
ADDRGP4 pm
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ASGNF4
line 987
;986:	
;987:	for (i=0 ; i<3 ; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $407
line 988
;988:		wishvel[i] = pml.forward[i]*fmove + pml.right[i]*smove;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 pml
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 pml+12
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDF4
ASGNF4
LABELV $408
line 987
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $407
line 989
;989:	wishvel[2] += pm->cmd.upmove;
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ADDF4
ASGNF4
line 991
;990:
;991:	VectorCopy (wishvel, wishdir);
ADDRLP4 32
ADDRLP4 4
INDIRB
ASGNB 12
line 992
;992:	wishspeed = VectorNormalize(wishdir);
ADDRLP4 32
ARGP4
ADDRLP4 76
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 44
ADDRLP4 76
INDIRF4
ASGNF4
line 993
;993:	wishspeed *= scale;
ADDRLP4 44
ADDRLP4 44
INDIRF4
ADDRLP4 48
INDIRF4
MULF4
ASGNF4
line 995
;994:
;995:	PM_Accelerate( wishdir, wishspeed, pm_accelerate );
ADDRLP4 32
ARGP4
ADDRLP4 44
INDIRF4
ARGF4
ADDRGP4 pm_accelerate
INDIRF4
ARGF4
ADDRGP4 PM_Accelerate
CALLV
pop
line 998
;996:
;997:	// move
;998:	VectorMA (pm->ps->origin, pml.frametime, pm->ps->velocity, pm->ps->origin);
ADDRLP4 80
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 80
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 84
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 84
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 84
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 88
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 88
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 88
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 999
;999:}
LABELV $398
endproc PM_NoclipMove 92 12
proc PM_FootstepForSurface 4 0
line 1010
;1000:
;1001://============================================================================
;1002:
;1003:/*
;1004:================
;1005:PM_FootstepForSurface
;1006:
;1007:Returns an event number apropriate for the groundsurface
;1008:================
;1009:*/
;1010:static int PM_FootstepForSurface( void ) {
line 1014
;1011:	// JUHOX BUGFIX: never generate footsteps if walking
;1012:#if 1
;1013:	if (
;1014:		(
ADDRLP4 0
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $419
ADDRLP4 0
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $417
LABELV $419
ADDRGP4 pm
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
CNSTF4 1069547520
GEF4 $417
line 1021
;1015:			(pm->cmd.buttons & (BUTTON_WALKING)) ||
;1016:			(pm->cmd.upmove < 0)
;1017:		)
;1018:#if MONSTER_MODE
;1019:		&& pm->scale < 1.5
;1020:#endif
;1021:	) return 0;
CNSTI4 0
RETI4
ADDRGP4 $416
JUMPV
LABELV $417
line 1023
;1022:#endif
;1023:	if ( pml.groundTrace.surfaceFlags & SURF_NOSTEPS ) {
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $420
line 1024
;1024:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $416
JUMPV
LABELV $420
line 1026
;1025:	}
;1026:	if ( pml.groundTrace.surfaceFlags & SURF_METALSTEPS ) {
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $424
line 1027
;1027:		return EV_FOOTSTEP_METAL;
CNSTI4 2
RETI4
ADDRGP4 $416
JUMPV
LABELV $424
line 1029
;1028:	}
;1029:	return EV_FOOTSTEP;
CNSTI4 1
RETI4
LABELV $416
endproc PM_FootstepForSurface 4 0
proc PM_CrashLand 52 4
line 1040
;1030:}
;1031:
;1032:
;1033:/*
;1034:=================
;1035:PM_CrashLand
;1036:
;1037:Check for hard landings that generate sound events
;1038:=================
;1039:*/
;1040:static void PM_CrashLand( void ) {
line 1049
;1041:	float		delta;
;1042:	float		dist;
;1043:	float		vel, acc;
;1044:	float		t;
;1045:	float		a, b, c, den;
;1046:
;1047:	// JUHOX: hibernation seed landing
;1048:#if MONSTER_MODE
;1049:	if (pm->hibernation) {
ADDRGP4 pm
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 0
EQI4 $429
line 1050
;1050:		PM_AddEvent(EV_COCOON_BOUNCE);
CNSTI4 45
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1051
;1051:		return;
ADDRGP4 $428
JUMPV
LABELV $429
line 1056
;1052:	}
;1053:#endif
;1054:
;1055:	// decide which landing animation to use
;1056:	if ( pm->ps->pm_flags & PMF_BACKWARDS_JUMP ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $431
line 1057
;1057:		PM_ForceLegsAnim( LEGS_LANDB );
CNSTI4 21
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 1058
;1058:	} else {
ADDRGP4 $432
JUMPV
LABELV $431
line 1059
;1059:		PM_ForceLegsAnim( LEGS_LAND );
CNSTI4 19
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 1060
;1060:	}
LABELV $432
line 1062
;1061:
;1062:	pm->ps->legsTimer = TIMER_LAND;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 130
ASGNI4
line 1065
;1063:
;1064:	// calculate the exact velocity on landing
;1065:	dist = pm->ps->origin[2] - pml.previous_origin[2];
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRGP4 pml+112+8
INDIRF4
SUBF4
ASGNF4
line 1066
;1066:	vel = pml.previous_velocity[2];
ADDRLP4 8
ADDRGP4 pml+124+8
INDIRF4
ASGNF4
line 1067
;1067:	acc = -pm->ps->gravity;
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
NEGI4
CVIF4 4
ASGNF4
line 1069
;1068:
;1069:	a = acc / 2;
ADDRLP4 16
ADDRLP4 12
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 1070
;1070:	b = vel;
ADDRLP4 4
ADDRLP4 8
INDIRF4
ASGNF4
line 1071
;1071:	c = -dist;
ADDRLP4 32
ADDRLP4 24
INDIRF4
NEGF4
ASGNF4
line 1073
;1072:
;1073:	den =  b * b - 4 * a * c;
ADDRLP4 20
ADDRLP4 4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ADDRLP4 16
INDIRF4
CNSTF4 1082130432
MULF4
ADDRLP4 32
INDIRF4
MULF4
SUBF4
ASGNF4
line 1074
;1074:	if ( den < 0 ) {
ADDRLP4 20
INDIRF4
CNSTF4 0
GEF4 $437
line 1075
;1075:		return;
ADDRGP4 $428
JUMPV
LABELV $437
line 1077
;1076:	}
;1077:	t = (-b - sqrt( den ) ) / ( 2 * a );
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 40
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 4
INDIRF4
NEGF4
ADDRLP4 40
INDIRF4
SUBF4
ADDRLP4 16
INDIRF4
CNSTF4 1073741824
MULF4
DIVF4
ASGNF4
line 1079
;1078:
;1079:	delta = vel + t * acc;
ADDRLP4 0
ADDRLP4 8
INDIRF4
ADDRLP4 28
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
line 1080
;1080:	delta = delta*delta * 0.0001;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
CNSTF4 953267991
MULF4
ASGNF4
line 1083
;1081:
;1082:	// ducking while falling doubles damage
;1083:	if ( pm->ps->pm_flags & PMF_DUCKED ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $439
line 1084
;1084:		delta *= 2;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1073741824
MULF4
ASGNF4
line 1085
;1085:	}
LABELV $439
line 1088
;1086:
;1087:	// never take falling damage if completely underwater
;1088:	if ( pm->waterlevel == 3 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CNSTI4 3
NEI4 $441
line 1089
;1089:		return;
ADDRGP4 $428
JUMPV
LABELV $441
line 1093
;1090:	}
;1091:
;1092:	// reduce falling damage if there is standing water
;1093:	if ( pm->waterlevel == 2 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CNSTI4 2
NEI4 $443
line 1094
;1094:		delta *= 0.25;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1048576000
MULF4
ASGNF4
line 1095
;1095:	}
LABELV $443
line 1096
;1096:	if ( pm->waterlevel == 1 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CNSTI4 1
NEI4 $445
line 1097
;1097:		delta *= 0.5;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 1098
;1098:	}
LABELV $445
line 1100
;1099:
;1100:	if ( delta < 1 ) {
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
GEF4 $447
line 1101
;1101:		return;
ADDRGP4 $428
JUMPV
LABELV $447
line 1108
;1102:	}
;1103:
;1104:	// create a local entity event to play the sound
;1105:
;1106:	// SURF_NODAMAGE is used for bounce pads where you don't ever
;1107:	// want to take damage or play a crunch sound
;1108:	if ( !(pml.groundTrace.surfaceFlags & SURF_NODAMAGE) )  {
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $449
line 1109
;1109:		if ( delta > 60 ) {
ADDRLP4 0
INDIRF4
CNSTF4 1114636288
LEF4 $453
line 1110
;1110:			PM_AddEvent( EV_FALL_FAR );
CNSTI4 12
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1111
;1111:		} else if ( delta > 40 ) {
ADDRGP4 $454
JUMPV
LABELV $453
ADDRLP4 0
INDIRF4
CNSTF4 1109393408
LEF4 $455
line 1113
;1112:			// this is a pain grunt, so don't play it if dead
;1113:			if ( pm->ps->stats[STAT_HEALTH] > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
LEI4 $456
line 1114
;1114:				PM_AddEvent( EV_FALL_MEDIUM );
CNSTI4 11
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1115
;1115:			}
line 1116
;1116:		} else if ( delta > 7 ) {
ADDRGP4 $456
JUMPV
LABELV $455
ADDRLP4 0
INDIRF4
CNSTF4 1088421888
LEF4 $459
line 1117
;1117:			PM_AddEvent( EV_FALL_SHORT );
CNSTI4 10
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1118
;1118:		} else {
ADDRGP4 $460
JUMPV
LABELV $459
line 1119
;1119:			PM_AddEvent( PM_FootstepForSurface() );
ADDRLP4 48
ADDRGP4 PM_FootstepForSurface
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1120
;1120:		}
LABELV $460
LABELV $456
LABELV $454
line 1121
;1121:	}
LABELV $449
line 1124
;1122:
;1123:	// start footstep cycle over
;1124:	pm->ps->bobCycle = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 0
ASGNI4
line 1125
;1125:}
LABELV $428
endproc PM_CrashLand 52 4
proc PM_CorrectAllSolid 36 28
line 1148
;1126:
;1127:/*
;1128:=============
;1129:PM_CheckStuck
;1130:=============
;1131:*/
;1132:/*
;1133:void PM_CheckStuck(void) {
;1134:	trace_t trace;
;1135:
;1136:	pm->trace (&trace, pm->ps->origin, pm->mins, pm->maxs, pm->ps->origin, pm->ps->clientNum, pm->tracemask);
;1137:	if (trace.allsolid) {
;1138:		//int shit = qtrue;
;1139:	}
;1140:}
;1141:*/
;1142:
;1143:/*
;1144:=============
;1145:PM_CorrectAllSolid
;1146:=============
;1147:*/
;1148:static int PM_CorrectAllSolid( trace_t *trace ) {
line 1152
;1149:	int			i, j, k;
;1150:	vec3_t		point;
;1151:
;1152:	if ( pm->debugLevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $462
line 1153
;1153:		Com_Printf("%i:allsolid\n", c_pmove);
ADDRGP4 $464
ARGP4
ADDRGP4 c_pmove
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 1154
;1154:	}
LABELV $462
line 1157
;1155:
;1156:	// jitter around
;1157:	for (i = -1; i <= 1; i++) {
ADDRLP4 20
CNSTI4 -1
ASGNI4
LABELV $465
line 1158
;1158:		for (j = -1; j <= 1; j++) {
ADDRLP4 16
CNSTI4 -1
ASGNI4
LABELV $469
line 1159
;1159:			for (k = -1; k <= 1; k++) {
ADDRLP4 12
CNSTI4 -1
ASGNI4
LABELV $473
line 1160
;1160:				VectorCopy(pm->ps->origin, point);
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 1161
;1161:				point[0] += (float) i;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 20
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1162
;1162:				point[1] += (float) j;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 16
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1163
;1163:				point[2] += (float) k;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 12
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1164
;1164:				pm->trace (trace, point, pm->mins, pm->maxs, point, pm->ps->clientNum, pm->tracemask);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 24
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 212
ADDP4
ARGP4
ADDRLP4 24
INDIRP4
CNSTI4 224
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 24
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
INDIRP4
CNSTI4 256
ADDP4
INDIRP4
CALLV
pop
line 1165
;1165:				if ( !trace->allsolid ) {
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $479
line 1166
;1166:					point[0] = pm->ps->origin[0];
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ASGNF4
line 1167
;1167:					point[1] = pm->ps->origin[1];
ADDRLP4 0+4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 1168
;1168:					point[2] = pm->ps->origin[2] - 0.25;
ADDRLP4 0+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 1048576000
SUBF4
ASGNF4
line 1170
;1169:
;1170:					pm->trace (trace, pm->ps->origin, pm->mins, pm->maxs, point, pm->ps->clientNum, pm->tracemask);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 32
ADDRLP4 28
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 28
INDIRP4
CNSTI4 212
ADDP4
ARGP4
ADDRLP4 28
INDIRP4
CNSTI4 224
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 32
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
INDIRP4
CNSTI4 256
ADDP4
INDIRP4
CALLV
pop
line 1171
;1171:					pml.groundTrace = *trace;
ADDRGP4 pml+52
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 56
line 1172
;1172:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $461
JUMPV
LABELV $479
line 1174
;1173:				}
;1174:			}
LABELV $474
line 1159
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 1
LEI4 $473
line 1175
;1175:		}
LABELV $470
line 1158
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 1
LEI4 $469
line 1176
;1176:	}
LABELV $466
line 1157
ADDRLP4 20
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 1
LEI4 $465
line 1178
;1177:
;1178:	pm->ps->groundEntityNum = ENTITYNUM_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
CNSTI4 1023
ASGNI4
line 1179
;1179:	pml.groundPlane = qfalse;
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 1180
;1180:	pml.walking = qfalse;
ADDRGP4 pml+44
CNSTI4 0
ASGNI4
line 1182
;1181:
;1182:	return qfalse;
CNSTI4 0
RETI4
LABELV $461
endproc PM_CorrectAllSolid 36 28
proc PM_GroundTraceMissed 80 28
line 1193
;1183:}
;1184:
;1185:
;1186:/*
;1187:=============
;1188:PM_GroundTraceMissed
;1189:
;1190:The ground trace didn't hit a surface, so we are in freefall
;1191:=============
;1192:*/
;1193:static void PM_GroundTraceMissed( void ) {
line 1197
;1194:	trace_t		trace;
;1195:	vec3_t		point;
;1196:
;1197:	if ( pm->ps->groundEntityNum != ENTITYNUM_NONE ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1023
EQI4 $487
line 1199
;1198:		// we just transitioned into freefall
;1199:		if ( pm->debugLevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $489
line 1200
;1200:			Com_Printf("%i:lift\n", c_pmove);
ADDRGP4 $491
ARGP4
ADDRGP4 c_pmove
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 1201
;1201:		}
LABELV $489
line 1205
;1202:
;1203:		// if they aren't in a jumping animation and the ground is a ways away, force into it
;1204:		// if we didn't do the trace, the player would be backflipping down staircases
;1205:		VectorCopy( pm->ps->origin, point );
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 1206
;1206:		point[2] -= 64;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1115684864
SUBF4
ASGNF4
line 1208
;1207:
;1208:		pm->trace (&trace, pm->ps->origin, pm->mins, pm->maxs, point, pm->ps->clientNum, pm->tracemask);
ADDRLP4 12
ARGP4
ADDRLP4 68
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 72
ADDRLP4 68
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 212
ADDP4
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 224
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 72
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
INDIRP4
CNSTI4 256
ADDP4
INDIRP4
CALLV
pop
line 1209
;1209:		if ( trace.fraction == 1.0 ) {
ADDRLP4 12+8
INDIRF4
CNSTF4 1065353216
NEF4 $493
line 1210
;1210:			if ( pm->cmd.forwardmove >= 0 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LTI4 $496
line 1211
;1211:				PM_ForceLegsAnim( LEGS_JUMP );
CNSTI4 18
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 1212
;1212:				pm->ps->pm_flags &= ~PMF_BACKWARDS_JUMP;
ADDRLP4 76
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 -9
BANDI4
ASGNI4
line 1213
;1213:			} else {
ADDRGP4 $497
JUMPV
LABELV $496
line 1214
;1214:				PM_ForceLegsAnim( LEGS_JUMPB );
CNSTI4 20
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 1215
;1215:				pm->ps->pm_flags |= PMF_BACKWARDS_JUMP;
ADDRLP4 76
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 1216
;1216:			}
LABELV $497
line 1217
;1217:		}
LABELV $493
line 1218
;1218:	}
LABELV $487
line 1220
;1219:
;1220:	pm->ps->groundEntityNum = ENTITYNUM_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
CNSTI4 1023
ASGNI4
line 1221
;1221:	pml.groundPlane = qfalse;
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 1222
;1222:	pml.walking = qfalse;
ADDRGP4 pml+44
CNSTI4 0
ASGNI4
line 1223
;1223:}
LABELV $486
endproc PM_GroundTraceMissed 80 28
proc PM_GroundTrace 92 28
line 1231
;1224:
;1225:
;1226:/*
;1227:=============
;1228:PM_GroundTrace
;1229:=============
;1230:*/
;1231:static void PM_GroundTrace( void ) {
line 1238
;1232:	vec3_t		point;
;1233:	trace_t		trace;
;1234:
;1235:	// JUHOX: speed-up for waiting monsters
;1236:#if 1
;1237:	if (
;1238:		pm->ps->groundEntityNum == ENTITYNUM_WORLD &&
ADDRLP4 68
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 72
ADDRLP4 68
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1022
NEI4 $501
ADDRLP4 72
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
CNSTF4 0
NEF4 $501
ADDRLP4 72
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
CNSTF4 0
NEF4 $501
ADDRLP4 72
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
CNSTF4 0
NEF4 $501
ADDRLP4 72
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
NEI4 $501
ADDRLP4 68
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $501
ADDRLP4 68
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $501
ADDRLP4 68
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $501
line 1246
;1239:		pm->ps->velocity[0] == 0 &&
;1240:		pm->ps->velocity[1] == 0 &&
;1241:		pm->ps->velocity[2] == 0 &&
;1242:		!(pm->ps->pm_flags & PMF_TIME_WATERJUMP) &&
;1243:		pm->cmd.forwardmove == 0 &&
;1244:		pm->cmd.rightmove == 0 &&
;1245:		pm->cmd.upmove == 0
;1246:	) {
line 1247
;1247:		pml.groundPlane = qtrue;
ADDRGP4 pml+48
CNSTI4 1
ASGNI4
line 1248
;1248:		pml.walking = qtrue;
ADDRGP4 pml+44
CNSTI4 1
ASGNI4
line 1249
;1249:		pml.groundTrace.plane.normal[2] = 1;
ADDRGP4 pml+52+24+8
CNSTF4 1065353216
ASGNF4
line 1250
;1250:		return;
ADDRGP4 $500
JUMPV
LABELV $501
line 1254
;1251:	}
;1252:#endif
;1253:
;1254:	point[0] = pm->ps->origin[0];
ADDRLP4 56
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ASGNF4
line 1255
;1255:	point[1] = pm->ps->origin[1];
ADDRLP4 56+4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 1256
;1256:	point[2] = pm->ps->origin[2] - 0.25;
ADDRLP4 56+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 1048576000
SUBF4
ASGNF4
line 1258
;1257:
;1258:	pm->trace (&trace, pm->ps->origin, pm->mins, pm->maxs, point, pm->ps->clientNum, pm->tracemask);
ADDRLP4 0
ARGP4
ADDRLP4 76
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 80
ADDRLP4 76
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 76
INDIRP4
CNSTI4 212
ADDP4
ARGP4
ADDRLP4 76
INDIRP4
CNSTI4 224
ADDP4
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 80
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 76
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ARGI4
ADDRLP4 76
INDIRP4
CNSTI4 256
ADDP4
INDIRP4
CALLV
pop
line 1259
;1259:	pml.groundTrace = trace;
ADDRGP4 pml+52
ADDRLP4 0
INDIRB
ASGNB 56
line 1262
;1260:
;1261:	// do something corrective if the trace starts in a solid...
;1262:	if ( trace.allsolid ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $511
line 1263
;1263:		if ( !PM_CorrectAllSolid(&trace) )
ADDRLP4 0
ARGP4
ADDRLP4 84
ADDRGP4 PM_CorrectAllSolid
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
NEI4 $513
line 1264
;1264:			return;
ADDRGP4 $500
JUMPV
LABELV $513
line 1265
;1265:	}
LABELV $511
line 1268
;1266:
;1267:	// if the trace didn't hit anything, we are in free fall
;1268:	if ( trace.fraction == 1.0 ) {
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
NEF4 $515
line 1269
;1269:		PM_GroundTraceMissed();
ADDRGP4 PM_GroundTraceMissed
CALLV
pop
line 1270
;1270:		pml.groundPlane = qfalse;
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 1271
;1271:		pml.walking = qfalse;
ADDRGP4 pml+44
CNSTI4 0
ASGNI4
line 1272
;1272:		return;
ADDRGP4 $500
JUMPV
LABELV $515
line 1276
;1273:	}
;1274:
;1275:	// check if getting thrown off the ground
;1276:	if ( pm->ps->velocity[2] > 0 && DotProduct( pm->ps->velocity, trace.plane.normal ) > 10 ) {
ADDRLP4 84
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
CNSTF4 0
LEF4 $520
ADDRLP4 84
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 0+24
INDIRF4
MULF4
ADDRLP4 84
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 0+24+4
INDIRF4
MULF4
ADDF4
ADDRLP4 84
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 0+24+8
INDIRF4
MULF4
ADDF4
CNSTF4 1092616192
LEF4 $520
line 1277
;1277:		if ( pm->debugLevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $527
line 1278
;1278:			Com_Printf("%i:kickoff\n", c_pmove);
ADDRGP4 $529
ARGP4
ADDRGP4 c_pmove
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 1279
;1279:		}
LABELV $527
line 1281
;1280:		// go into jump animation
;1281:		if ( pm->cmd.forwardmove >= 0 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LTI4 $530
line 1282
;1282:			PM_ForceLegsAnim( LEGS_JUMP );
CNSTI4 18
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 1283
;1283:			pm->ps->pm_flags &= ~PMF_BACKWARDS_JUMP;
ADDRLP4 88
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRI4
CNSTI4 -9
BANDI4
ASGNI4
line 1284
;1284:		} else {
ADDRGP4 $531
JUMPV
LABELV $530
line 1285
;1285:			PM_ForceLegsAnim( LEGS_JUMPB );
CNSTI4 20
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 1286
;1286:			pm->ps->pm_flags |= PMF_BACKWARDS_JUMP;
ADDRLP4 88
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 1287
;1287:		}
LABELV $531
line 1289
;1288:
;1289:		pm->ps->groundEntityNum = ENTITYNUM_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
CNSTI4 1023
ASGNI4
line 1290
;1290:		pml.groundPlane = qfalse;
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 1291
;1291:		pml.walking = qfalse;
ADDRGP4 pml+44
CNSTI4 0
ASGNI4
line 1292
;1292:		return;
ADDRGP4 $500
JUMPV
LABELV $520
line 1296
;1293:	}
;1294:	
;1295:	// slopes that are too steep will not be considered onground
;1296:	if ( trace.plane.normal[2] < MIN_WALK_NORMAL ) {
ADDRLP4 0+24+8
INDIRF4
CNSTF4 1060320051
GEF4 $534
line 1297
;1297:		if ( pm->debugLevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $538
line 1298
;1298:			Com_Printf("%i:steep\n", c_pmove);
ADDRGP4 $540
ARGP4
ADDRGP4 c_pmove
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 1299
;1299:		}
LABELV $538
line 1302
;1300:		// FIXME: if they can't slide down the slope, let them
;1301:		// walk (sharp crevices)
;1302:		pm->ps->groundEntityNum = ENTITYNUM_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
CNSTI4 1023
ASGNI4
line 1303
;1303:		pml.groundPlane = qtrue;
ADDRGP4 pml+48
CNSTI4 1
ASGNI4
line 1304
;1304:		pml.walking = qfalse;
ADDRGP4 pml+44
CNSTI4 0
ASGNI4
line 1305
;1305:		return;
ADDRGP4 $500
JUMPV
LABELV $534
line 1308
;1306:	}
;1307:
;1308:	pml.groundPlane = qtrue;
ADDRGP4 pml+48
CNSTI4 1
ASGNI4
line 1309
;1309:	pml.walking = qtrue;
ADDRGP4 pml+44
CNSTI4 1
ASGNI4
line 1312
;1310:
;1311:	// hitting solid ground will end a waterjump
;1312:	if (pm->ps->pm_flags & PMF_TIME_WATERJUMP)
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $545
line 1313
;1313:	{
line 1314
;1314:		pm->ps->pm_flags &= ~(PMF_TIME_WATERJUMP | PMF_TIME_LAND);
ADDRLP4 88
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRI4
CNSTI4 -289
BANDI4
ASGNI4
line 1315
;1315:		pm->ps->pm_time = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 0
ASGNI4
line 1316
;1316:	}
LABELV $545
line 1318
;1317:
;1318:	if ( pm->ps->groundEntityNum == ENTITYNUM_NONE ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1023
NEI4 $547
line 1320
;1319:		// just hit the ground
;1320:		if ( pm->debugLevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $549
line 1321
;1321:			Com_Printf("%i:Land\n", c_pmove);
ADDRGP4 $551
ARGP4
ADDRGP4 c_pmove
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 1322
;1322:		}
LABELV $549
line 1324
;1323:		
;1324:		PM_CrashLand();
ADDRGP4 PM_CrashLand
CALLV
pop
line 1327
;1325:
;1326:		// don't do landing time if we were just going down a slope
;1327:		if ( pml.previous_velocity[2] < -200 ) {
ADDRGP4 pml+124+8
INDIRF4
CNSTF4 3276275712
GEF4 $552
line 1329
;1328:			// don't allow another jump for a little while
;1329:			pm->ps->pm_flags |= PMF_TIME_LAND;
ADDRLP4 88
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 1330
;1330:			pm->ps->pm_time = 250;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 250
ASGNI4
line 1331
;1331:		}
LABELV $552
line 1332
;1332:	}
LABELV $547
line 1334
;1333:
;1334:	pm->ps->groundEntityNum = trace.entityNum;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 0+52
INDIRI4
ASGNI4
line 1339
;1335:
;1336:	// don't reset the z velocity for slopes
;1337://	pm->ps->velocity[2] = 0;
;1338:
;1339:	PM_AddTouchEnt( trace.entityNum );
ADDRLP4 0+52
INDIRI4
ARGI4
ADDRGP4 PM_AddTouchEnt
CALLV
pop
line 1340
;1340:}
LABELV $500
endproc PM_GroundTrace 92 28
proc PM_SetWaterLevel 64 8
line 1348
;1341:
;1342:
;1343:/*
;1344:=============
;1345:PM_SetWaterLevel	FIXME: avoid this twice?  certainly if not moving
;1346:=============
;1347:*/
;1348:static void PM_SetWaterLevel( void ) {
line 1357
;1349:	vec3_t		point;
;1350:	int			cont;
;1351:	int			sample1;
;1352:	int			sample2;
;1353:
;1354:	//
;1355:	// get waterlevel, accounting for ducking
;1356:	//
;1357:	pm->waterlevel = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 240
ADDP4
CNSTI4 0
ASGNI4
line 1358
;1358:	pm->watertype = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 236
ADDP4
CNSTI4 0
ASGNI4
line 1360
;1359:
;1360:	point[0] = pm->ps->origin[0];
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ASGNF4
line 1361
;1361:	point[1] = pm->ps->origin[1];
ADDRLP4 0+4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 1366
;1362:	// JUHOX: let PM_SetWaterLevel() handle player scale
;1363:#if !MONSTER_MODE
;1364:	point[2] = pm->ps->origin[2] + MINS_Z + 1;	
;1365:#else
;1366:	point[2] = pm->ps->origin[2] + MINS_Z * pm->scale + 1;
ADDRLP4 24
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 24
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
CNSTF4 3250585600
MULF4
ADDF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 1368
;1367:#endif
;1368:	cont = pm->pointcontents( point, pm->ps->clientNum );
ADDRLP4 0
ARGP4
ADDRLP4 28
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 32
ADDRLP4 28
INDIRP4
CNSTI4 260
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 32
INDIRI4
ASGNI4
line 1370
;1369:
;1370:	if ( cont & MASK_WATER ) {
ADDRLP4 12
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $561
line 1375
;1371:	// JUHOX: let PM_SetWaterLevel() handle player scale
;1372:#if !MONSTER_MODE
;1373:		sample2 = pm->ps->viewheight - MINS_Z;
;1374:#else
;1375:		sample2 = pm->ps->viewheight - MINS_Z * pm->scale;
ADDRLP4 36
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 36
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 36
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
CNSTF4 3250585600
MULF4
SUBF4
CVFI4 4
ASGNI4
line 1377
;1376:#endif
;1377:		sample1 = sample2 / 2;
ADDRLP4 20
ADDRLP4 16
INDIRI4
CNSTI4 2
DIVI4
ASGNI4
line 1379
;1378:
;1379:		pm->watertype = cont;
ADDRGP4 pm
INDIRP4
CNSTI4 236
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 1380
;1380:		pm->waterlevel = 1;
ADDRGP4 pm
INDIRP4
CNSTI4 240
ADDP4
CNSTI4 1
ASGNI4
line 1385
;1381:	// JUHOX: let PM_SetWaterLevel() handle player scale
;1382:#if !MONSTER_MODE
;1383:		point[2] = pm->ps->origin[2] + MINS_Z + sample1;
;1384:#else
;1385:		point[2] = pm->ps->origin[2] + MINS_Z * pm->scale + sample1;
ADDRLP4 40
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 40
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
CNSTF4 3250585600
MULF4
ADDF4
ADDRLP4 20
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1387
;1386:#endif
;1387:		cont = pm->pointcontents (point, pm->ps->clientNum );
ADDRLP4 0
ARGP4
ADDRLP4 44
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
ADDRLP4 44
INDIRP4
CNSTI4 260
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 48
INDIRI4
ASGNI4
line 1388
;1388:		if ( cont & MASK_WATER ) {
ADDRLP4 12
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $564
line 1389
;1389:			pm->waterlevel = 2;
ADDRGP4 pm
INDIRP4
CNSTI4 240
ADDP4
CNSTI4 2
ASGNI4
line 1394
;1390:	// JUHOX: let PM_SetWaterLevel() handle player scale
;1391:#if !MONSTER_MODE
;1392:			point[2] = pm->ps->origin[2] + MINS_Z + sample2;
;1393:#else
;1394:			point[2] = pm->ps->origin[2] + MINS_Z * pm->scale + sample2;
ADDRLP4 52
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 52
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
CNSTF4 3250585600
MULF4
ADDF4
ADDRLP4 16
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1396
;1395:#endif
;1396:			cont = pm->pointcontents (point, pm->ps->clientNum );
ADDRLP4 0
ARGP4
ADDRLP4 56
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
ADDRLP4 56
INDIRP4
CNSTI4 260
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 60
INDIRI4
ASGNI4
line 1397
;1397:			if ( cont & MASK_WATER ){
ADDRLP4 12
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $567
line 1398
;1398:				pm->waterlevel = 3;
ADDRGP4 pm
INDIRP4
CNSTI4 240
ADDP4
CNSTI4 3
ASGNI4
line 1399
;1399:			}
LABELV $567
line 1400
;1400:		}
LABELV $564
line 1401
;1401:	}
LABELV $561
line 1403
;1402:
;1403:}
LABELV $558
endproc PM_SetWaterLevel 64 8
proc PM_CheckDuck 108 28
line 1413
;1404:
;1405:/*
;1406:==============
;1407:PM_CheckDuck
;1408:
;1409:Sets mins, maxs, and pm->ps->viewheight
;1410:==============
;1411:*/
;1412:static void PM_CheckDuck (void)
;1413:{
line 1432
;1414:	trace_t	trace;
;1415:
;1416:#if 0	// JUHOX: no invulnerability available
;1417:	if ( pm->ps->powerups[PW_INVULNERABILITY] ) {
;1418:		if ( pm->ps->pm_flags & PMF_INVULEXPAND ) {
;1419:			// invulnerability sphere has a 42 units radius
;1420:			VectorSet( pm->mins, -42, -42, -42 );
;1421:			VectorSet( pm->maxs, 42, 42, 42 );
;1422:		}
;1423:		else {
;1424:			VectorSet( pm->mins, -15, -15, MINS_Z );
;1425:			VectorSet( pm->maxs, 15, 15, 16 );
;1426:		}
;1427:		pm->ps->pm_flags |= PMF_DUCKED;
;1428:		pm->ps->viewheight = CROUCH_VIEWHEIGHT;
;1429:		return;
;1430:	}
;1431:#endif
;1432:	pm->ps->pm_flags &= ~PMF_INVULEXPAND;
ADDRLP4 56
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 -16385
BANDI4
ASGNI4
line 1435
;1433:
;1434:#if MONSTER_MODE	// JUHOX: hibernation mins & maxs
;1435:	if (pm->hibernation) {
ADDRGP4 pm
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 0
EQI4 $570
line 1436
;1436:		VectorSet(pm->mins, -4, -4, -4);
ADDRGP4 pm
INDIRP4
CNSTI4 212
ADDP4
CNSTF4 3229614080
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 216
ADDP4
CNSTF4 3229614080
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 220
ADDP4
CNSTF4 3229614080
ASGNF4
line 1437
;1437:		VectorSet(pm->maxs, +4, +4, +4);
ADDRGP4 pm
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1082130432
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 228
ADDP4
CNSTF4 1082130432
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 232
ADDP4
CNSTF4 1082130432
ASGNF4
line 1438
;1438:		pm->ps->viewheight = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 0
ASGNI4
line 1439
;1439:		return;
ADDRGP4 $569
JUMPV
LABELV $570
line 1443
;1440:	}
;1441:#endif
;1442:
;1443:	pm->mins[0] = -15;
ADDRGP4 pm
INDIRP4
CNSTI4 212
ADDP4
CNSTF4 3245342720
ASGNF4
line 1444
;1444:	pm->mins[1] = -15;
ADDRGP4 pm
INDIRP4
CNSTI4 216
ADDP4
CNSTF4 3245342720
ASGNF4
line 1446
;1445:
;1446:	pm->maxs[0] = 15;
ADDRGP4 pm
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1097859072
ASGNF4
line 1447
;1447:	pm->maxs[1] = 15;
ADDRGP4 pm
INDIRP4
CNSTI4 228
ADDP4
CNSTF4 1097859072
ASGNF4
line 1449
;1448:
;1449:	pm->mins[2] = MINS_Z;
ADDRGP4 pm
INDIRP4
CNSTI4 220
ADDP4
CNSTF4 3250585600
ASGNF4
line 1453
;1450:
;1451:	// JUHOX: apply player scale factor
;1452:#if MONSTER_MODE
;1453:	VectorScale(pm->mins, pm->scale, pm->mins);
ADDRLP4 60
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 212
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 212
ADDP4
INDIRF4
ADDRLP4 60
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 64
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 216
ADDP4
ADDRLP4 64
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ADDRLP4 64
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 68
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 220
ADDP4
ADDRLP4 68
INDIRP4
CNSTI4 220
ADDP4
INDIRF4
ADDRLP4 68
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
MULF4
ASGNF4
line 1454
;1454:	pm->maxs[0] *= pm->scale;
ADDRLP4 72
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 76
ADDRLP4 72
INDIRP4
CNSTI4 224
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRF4
ADDRLP4 72
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
MULF4
ASGNF4
line 1455
;1455:	pm->maxs[1] *= pm->scale;
ADDRLP4 80
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 84
ADDRLP4 80
INDIRP4
CNSTI4 228
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
MULF4
ASGNF4
line 1458
;1456:#endif
;1457:
;1458:	if (pm->ps->pm_type == PM_DEAD)
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $572
line 1459
;1459:	{
line 1460
;1460:		pm->maxs[2] = -8;
ADDRGP4 pm
INDIRP4
CNSTI4 232
ADDP4
CNSTF4 3238002688
ASGNF4
line 1463
;1461:		// JUHOX: apply player scale factor
;1462:#if MONSTER_MODE
;1463:		pm->maxs[2] *= pm->scale;
ADDRLP4 88
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 92
ADDRLP4 88
INDIRP4
CNSTI4 232
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRF4
ADDRLP4 88
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
MULF4
ASGNF4
line 1466
;1464:#endif
;1465:		// JUHOX FIXME: player viewheight should be adapted to player scale factor
;1466:		pm->ps->viewheight = DEAD_VIEWHEIGHT;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 -16
ASGNI4
line 1467
;1467:		return;
ADDRGP4 $569
JUMPV
LABELV $572
line 1470
;1468:	}
;1469:
;1470:	if (pm->cmd.upmove < 0)
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $574
line 1471
;1471:	{	// duck
line 1472
;1472:		pm->ps->pm_flags |= PMF_DUCKED;
ADDRLP4 88
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 1473
;1473:	}
ADDRGP4 $575
JUMPV
LABELV $574
line 1475
;1474:	else
;1475:	{	// stand up if possible
line 1476
;1476:		if (pm->ps->pm_flags & PMF_DUCKED)
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $576
line 1477
;1477:		{
line 1479
;1478:			// try to stand up
;1479:			pm->maxs[2] = 32;
ADDRGP4 pm
INDIRP4
CNSTI4 232
ADDP4
CNSTF4 1107296256
ASGNF4
line 1482
;1480:			// JUHOX: apply player scale factor
;1481:#if MONSTER_MODE
;1482:			pm->maxs[2] *= pm->scale;
ADDRLP4 88
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 92
ADDRLP4 88
INDIRP4
CNSTI4 232
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRF4
ADDRLP4 88
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
MULF4
ASGNF4
line 1484
;1483:#endif
;1484:			pm->trace (&trace, pm->ps->origin, pm->mins, pm->maxs, pm->ps->origin, pm->ps->clientNum, pm->tracemask );
ADDRLP4 0
ARGP4
ADDRLP4 96
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 100
ADDRLP4 96
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 96
INDIRP4
CNSTI4 212
ADDP4
ARGP4
ADDRLP4 96
INDIRP4
CNSTI4 224
ADDP4
ARGP4
ADDRLP4 100
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 100
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 96
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ARGI4
ADDRLP4 96
INDIRP4
CNSTI4 256
ADDP4
INDIRP4
CALLV
pop
line 1485
;1485:			if (!trace.allsolid)
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $578
line 1486
;1486:				pm->ps->pm_flags &= ~PMF_DUCKED;
ADDRLP4 104
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 104
INDIRP4
ADDRLP4 104
INDIRP4
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
LABELV $578
line 1487
;1487:		}
LABELV $576
line 1488
;1488:	}
LABELV $575
line 1490
;1489:
;1490:	if (pm->ps->pm_flags & PMF_DUCKED)
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $580
line 1491
;1491:	{
line 1492
;1492:		pm->maxs[2] = 16;
ADDRGP4 pm
INDIRP4
CNSTI4 232
ADDP4
CNSTF4 1098907648
ASGNF4
line 1493
;1493:		pm->ps->viewheight = CROUCH_VIEWHEIGHT;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 12
ASGNI4
line 1494
;1494:	}
ADDRGP4 $581
JUMPV
LABELV $580
line 1496
;1495:	else
;1496:	{
line 1497
;1497:		pm->maxs[2] = 32;
ADDRGP4 pm
INDIRP4
CNSTI4 232
ADDP4
CNSTF4 1107296256
ASGNF4
line 1498
;1498:		pm->ps->viewheight = DEFAULT_VIEWHEIGHT;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 26
ASGNI4
line 1499
;1499:	}
LABELV $581
line 1502
;1500:	// JUHOX: apply player scale factor
;1501:#if MONSTER_MODE
;1502:	pm->maxs[2] *= pm->scale;
ADDRLP4 88
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 92
ADDRLP4 88
INDIRP4
CNSTI4 232
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRF4
ADDRLP4 88
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
MULF4
ASGNF4
line 1503
;1503:	pm->ps->viewheight = pm->ps->viewheight * pm->scale;
ADDRLP4 96
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 100
ADDRLP4 96
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
CNSTI4 164
ADDP4
ADDRLP4 100
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 96
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 1505
;1504:#endif
;1505:}
LABELV $569
endproc PM_CheckDuck 108 28
proc PM_Footsteps 36 4
line 1517
;1506:
;1507:
;1508:
;1509://===================================================================
;1510:
;1511:
;1512:/*
;1513:===============
;1514:PM_Footsteps
;1515:===============
;1516:*/
;1517:static void PM_Footsteps( void ) {
line 1526
;1518:	float		bobmove;
;1519:	int			old;
;1520:	qboolean	footstep;
;1521:
;1522:	//
;1523:	// calculate speed and cycle to be used for
;1524:	// all cyclic walking effects
;1525:	//
;1526:	pm->xyspeed = sqrt( pm->ps->velocity[0] * pm->ps->velocity[0]
ADDRLP4 12
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 12
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
MULF4
ADDRLP4 16
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
MULF4
ADDF4
ARGF4
ADDRLP4 20
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 244
ADDP4
ADDRLP4 20
INDIRF4
ASGNF4
line 1529
;1527:		+  pm->ps->velocity[1] * pm->ps->velocity[1] );
;1528:
;1529:	if ( pm->ps->groundEntityNum == ENTITYNUM_NONE ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1023
NEI4 $583
line 1538
;1530:
;1531:		// JUHOX: no invulnerability available
;1532:#if 0
;1533:		if ( pm->ps->powerups[PW_INVULNERABILITY] ) {
;1534:			PM_ContinueLegsAnim( LEGS_IDLECR );
;1535:		}
;1536:#endif
;1537:		// airborne leaves position in cycle intact, but doesn't advance
;1538:		if ( pm->waterlevel > 1 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CNSTI4 1
LEI4 $582
line 1539
;1539:			PM_ContinueLegsAnim( LEGS_SWIM );
CNSTI4 17
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1540
;1540:		}
line 1541
;1541:		return;
ADDRGP4 $582
JUMPV
LABELV $583
line 1550
;1542:	}
;1543:
;1544:	// if not trying to move
;1545:	// JUHOX: always use idle animation for grapple move
;1546:#if 0
;1547:	if ( !pm->cmd.forwardmove && !pm->cmd.rightmove ) {
;1548:#else
;1549:	if (
;1550:		(
ADDRLP4 24
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $590
ADDRLP4 24
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $589
LABELV $590
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $587
LABELV $589
line 1555
;1551:			!pm->cmd.forwardmove &&
;1552:			!pm->cmd.rightmove
;1553:		) ||
;1554:		(pm->ps->pm_flags & PMF_GRAPPLE_PULL)
;1555:	) {
line 1557
;1556:#endif
;1557:		if (  pm->xyspeed < 5 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 244
ADDP4
INDIRF4
CNSTF4 1084227584
GEF4 $582
line 1558
;1558:			pm->ps->bobCycle = 0;	// start at beginning of cycle again
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 0
ASGNI4
line 1559
;1559:			if ( pm->ps->pm_flags & PMF_DUCKED ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $593
line 1560
;1560:				PM_ContinueLegsAnim( LEGS_IDLECR );
CNSTI4 23
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1561
;1561:			} else {
ADDRGP4 $582
JUMPV
LABELV $593
line 1562
;1562:				PM_ContinueLegsAnim( LEGS_IDLE );
CNSTI4 22
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1563
;1563:			}
line 1564
;1564:		}
line 1565
;1565:		return;
ADDRGP4 $582
JUMPV
LABELV $587
line 1569
;1566:	}
;1567:	
;1568:
;1569:	footstep = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 1571
;1570:
;1571:	if ( pm->ps->pm_flags & PMF_DUCKED ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $595
line 1572
;1572:		bobmove = 0.5;	// ducked characters bob much faster
ADDRLP4 0
CNSTF4 1056964608
ASGNF4
line 1573
;1573:		if ( pm->ps->pm_flags & PMF_BACKWARDS_RUN ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $597
line 1574
;1574:			PM_ContinueLegsAnim( LEGS_BACKCR );
CNSTI4 32
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1575
;1575:		}
ADDRGP4 $598
JUMPV
LABELV $597
line 1576
;1576:		else {
line 1577
;1577:			PM_ContinueLegsAnim( LEGS_WALKCR );
CNSTI4 13
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1578
;1578:		}
LABELV $598
line 1591
;1579:		// ducked characters never play footsteps
;1580:	/*
;1581:	} else 	if ( pm->ps->pm_flags & PMF_BACKWARDS_RUN ) {
;1582:		if ( !( pm->cmd.buttons & BUTTON_WALKING ) ) {
;1583:			bobmove = 0.4;	// faster speeds bob faster
;1584:			footstep = qtrue;
;1585:		} else {
;1586:			bobmove = 0.3;
;1587:		}
;1588:		PM_ContinueLegsAnim( LEGS_BACK );
;1589:	*/
;1590:#if 1	// JUHOX: adapt bobbing to movement speed
;1591:		bobmove *= VectorLength(pm->ps->velocity) / 160;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 28
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 28
INDIRF4
CNSTF4 1003277517
MULF4
MULF4
ASGNF4
line 1593
;1592:#endif
;1593:	} else {
ADDRGP4 $596
JUMPV
LABELV $595
line 1594
;1594:		if ( !( pm->cmd.buttons & BUTTON_WALKING ) ) {
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $599
line 1595
;1595:			bobmove = 0.4f;	// faster speeds bob faster
ADDRLP4 0
CNSTF4 1053609165
ASGNF4
line 1596
;1596:			if ( pm->ps->pm_flags & PMF_BACKWARDS_RUN ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $601
line 1597
;1597:				PM_ContinueLegsAnim( LEGS_BACK );
CNSTI4 16
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1598
;1598:			}
ADDRGP4 $602
JUMPV
LABELV $601
line 1599
;1599:			else {
line 1600
;1600:				PM_ContinueLegsAnim( LEGS_RUN );
CNSTI4 15
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1601
;1601:			}
LABELV $602
line 1602
;1602:			footstep = qtrue;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 1604
;1603:#if 1	// JUHOX: adapt bobbing to movement speed
;1604:			bobmove *= VectorLength(pm->ps->velocity) / 320;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 28
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 28
INDIRF4
CNSTF4 994888909
MULF4
MULF4
ASGNF4
line 1606
;1605:#endif
;1606:		} else {
ADDRGP4 $600
JUMPV
LABELV $599
line 1607
;1607:			bobmove = 0.3f;	// walking bobs slow
ADDRLP4 0
CNSTF4 1050253722
ASGNF4
line 1608
;1608:			if ( pm->ps->pm_flags & PMF_BACKWARDS_RUN ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $603
line 1609
;1609:				PM_ContinueLegsAnim( LEGS_BACKWALK );
CNSTI4 33
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1610
;1610:			}
ADDRGP4 $604
JUMPV
LABELV $603
line 1611
;1611:			else {
line 1612
;1612:				PM_ContinueLegsAnim( LEGS_WALK );
CNSTI4 14
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1613
;1613:			}
LABELV $604
line 1616
;1614:			// JUHOX: big players always generate footsteps
;1615:#if MONSTER_MODE
;1616:			if (pm->scale >= 1.5) footstep = qtrue;
ADDRGP4 pm
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
CNSTF4 1069547520
LTF4 $605
ADDRLP4 8
CNSTI4 1
ASGNI4
LABELV $605
line 1619
;1617:#endif
;1618:#if 1	// JUHOX: adapt bobbing to movement speed
;1619:			bobmove *= VectorLength(pm->ps->velocity) / 160;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 28
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 28
INDIRF4
CNSTF4 1003277517
MULF4
MULF4
ASGNF4
line 1622
;1620:			//bobmove *= 2;
;1621:#endif
;1622:		}
LABELV $600
line 1623
;1623:	}
LABELV $596
line 1626
;1624:	// JUHOX: slow down bobbing for tired players
;1625:#if 1
;1626:	if (pm->ps->stats[STAT_STRENGTH] < LOW_STRENGTH_VALUE) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1161527296
GEF4 $607
line 1627
;1627:		bobmove *= 0.6 + 0.4 * pm->ps->stats[STAT_STRENGTH] / LOW_STRENGTH_VALUE;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CVIF4 4
CNSTF4 957075301
MULF4
CNSTF4 1058642330
ADDF4
MULF4
ASGNF4
line 1628
;1628:	}
LABELV $607
line 1637
;1629:#endif
;1630:	// JUHOX: slower bobbing for titan
;1631:#if 1
;1632:	/*
;1633:	if (pm->scale == MONSTER_TITAN_SCALE) {	// ouch! evil hack!
;1634:		bobmove *= 0.5;
;1635:	}
;1636:	*/
;1637:	bobmove /= pm->scale;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRGP4 pm
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
DIVF4
ASGNF4
line 1641
;1638:#endif
;1639:
;1640:	// check for footstep / splash sounds
;1641:	old = pm->ps->bobCycle;
ADDRLP4 4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1642
;1642:	pm->ps->bobCycle = (int)( old + bobmove * pml.msec ) & 255;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRLP4 0
INDIRF4
ADDRGP4 pml+40
INDIRI4
CVIF4 4
MULF4
ADDF4
CVFI4 4
CNSTI4 255
BANDI4
ASGNI4
line 1645
;1643:
;1644:	// if we just crossed a cycle boundary, play an apropriate footstep event
;1645:	if ( ( ( old + 64 ) ^ ( pm->ps->bobCycle + 64 ) ) & 128 ) {
ADDRLP4 4
INDIRI4
CNSTI4 64
ADDI4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 64
ADDI4
BXORI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $610
line 1651
;1646:		// JUHOX: no-sound lava/slime hack
;1647:#if !ESCAPE_MODE
;1648:		if ( pm->waterlevel == 0 ) {
;1649:#else
;1650:		if (
;1651:			pm->waterlevel == 0 ||
ADDRLP4 28
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CNSTI4 0
EQI4 $614
ADDRLP4 28
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
CNSTI4 9
NEI4 $612
ADDRLP4 28
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $612
ADDRLP4 28
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
CNSTI4 24
BANDI4
CNSTI4 0
EQI4 $612
LABELV $614
line 1657
;1652:			(
;1653:				pm->gametype == GT_EFH &&
;1654:				(pm->watertype & CONTENTS_WATER) &&
;1655:				(pm->watertype & (CONTENTS_LAVA|CONTENTS_SLIME))
;1656:			)
;1657:		) {
line 1660
;1658:#endif
;1659:			// on ground will only play sounds if running
;1660:			if ( footstep && !pm->noFootsteps ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $613
ADDRGP4 pm
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 0
NEI4 $613
line 1661
;1661:				PM_AddEvent( PM_FootstepForSurface() );
ADDRLP4 32
ADDRGP4 PM_FootstepForSurface
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1662
;1662:			}
line 1663
;1663:		} else if ( pm->waterlevel == 1 ) {
ADDRGP4 $613
JUMPV
LABELV $612
ADDRGP4 pm
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CNSTI4 1
NEI4 $617
line 1665
;1664:			// splashing
;1665:			PM_AddEvent( EV_FOOTSPLASH );
CNSTI4 3
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1666
;1666:		} else if ( pm->waterlevel == 2 ) {
ADDRGP4 $618
JUMPV
LABELV $617
ADDRGP4 pm
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CNSTI4 2
NEI4 $619
line 1668
;1667:			// wading / swimming at surface
;1668:			PM_AddEvent( EV_SWIM );
CNSTI4 5
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1669
;1669:		} else if ( pm->waterlevel == 3 ) {
ADDRGP4 $620
JUMPV
LABELV $619
ADDRGP4 pm
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CNSTI4 3
NEI4 $621
line 1672
;1670:			// no sound when completely underwater
;1671:
;1672:		}
LABELV $621
LABELV $620
LABELV $618
LABELV $613
line 1673
;1673:	}
LABELV $610
line 1674
;1674:}
LABELV $582
endproc PM_Footsteps 36 4
proc PM_WaterEvents 4 4
line 1683
;1675:
;1676:/*
;1677:==============
;1678:PM_WaterEvents
;1679:
;1680:Generate sound events for entering and leaving water
;1681:==============
;1682:*/
;1683:static void PM_WaterEvents( void ) {		// FIXME?
line 1687
;1684:	// JUHOX: no-sound lava/slime hack
;1685:#if ESCAPE_MODE
;1686:	if (
;1687:		pm->gametype == GT_EFH &&
ADDRLP4 0
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
CNSTI4 9
NEI4 $624
ADDRLP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CNSTI4 0
LEI4 $631
ADDRLP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $631
ADDRLP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
CNSTI4 24
BANDI4
CNSTI4 0
NEI4 $629
LABELV $631
ADDRGP4 pml+136
INDIRI4
CNSTI4 0
LEI4 $624
ADDRGP4 pml+140
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $624
ADDRGP4 pml+140
INDIRI4
CNSTI4 24
BANDI4
CNSTI4 0
EQI4 $624
LABELV $629
line 1700
;1688:		(
;1689:			(
;1690:				pm->waterlevel > 0 &&
;1691:				(pm->watertype & CONTENTS_WATER) &&
;1692:				(pm->watertype & (CONTENTS_LAVA|CONTENTS_SLIME))
;1693:			) ||
;1694:			(
;1695:				pml.previous_waterlevel > 0 &&
;1696:				(pml.previous_watertype & CONTENTS_WATER) &&
;1697:				(pml.previous_watertype & (CONTENTS_LAVA|CONTENTS_SLIME))
;1698:			)
;1699:		)
;1700:	) {
line 1701
;1701:		return;
ADDRGP4 $623
JUMPV
LABELV $624
line 1707
;1702:	}
;1703:#endif
;1704:	//
;1705:	// if just entered a water volume, play a sound
;1706:	//
;1707:	if (!pml.previous_waterlevel && pm->waterlevel) {
ADDRGP4 pml+136
INDIRI4
CNSTI4 0
NEI4 $632
ADDRGP4 pm
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CNSTI4 0
EQI4 $632
line 1708
;1708:		PM_AddEvent( EV_WATER_TOUCH );
CNSTI4 15
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1709
;1709:	}
LABELV $632
line 1714
;1710:
;1711:	//
;1712:	// if just completely exited a water volume, play a sound
;1713:	//
;1714:	if (pml.previous_waterlevel && !pm->waterlevel) {
ADDRGP4 pml+136
INDIRI4
CNSTI4 0
EQI4 $635
ADDRGP4 pm
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CNSTI4 0
NEI4 $635
line 1715
;1715:		PM_AddEvent( EV_WATER_LEAVE );
CNSTI4 16
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1716
;1716:	}
LABELV $635
line 1721
;1717:
;1718:	//
;1719:	// check for head just going under water
;1720:	//
;1721:	if (pml.previous_waterlevel != 3 && pm->waterlevel == 3) {
ADDRGP4 pml+136
INDIRI4
CNSTI4 3
EQI4 $638
ADDRGP4 pm
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CNSTI4 3
NEI4 $638
line 1722
;1722:		PM_AddEvent( EV_WATER_UNDER );
CNSTI4 17
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1723
;1723:	}
LABELV $638
line 1728
;1724:
;1725:	//
;1726:	// check for head just coming out of water
;1727:	//
;1728:	if (pml.previous_waterlevel == 3 && pm->waterlevel != 3) {
ADDRGP4 pml+136
INDIRI4
CNSTI4 3
NEI4 $641
ADDRGP4 pm
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CNSTI4 3
EQI4 $641
line 1729
;1729:		PM_AddEvent( EV_WATER_CLEAR );
CNSTI4 18
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1730
;1730:	}
LABELV $641
line 1731
;1731:}
LABELV $623
endproc PM_WaterEvents 4 4
proc PM_BeginWeaponChange 8 4
line 1739
;1732:
;1733:
;1734:/*
;1735:===============
;1736:PM_BeginWeaponChange
;1737:===============
;1738:*/
;1739:static void PM_BeginWeaponChange( int weapon ) {
line 1740
;1740:	if ( weapon <= WP_NONE || weapon >= WP_NUM_WEAPONS ) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $647
ADDRLP4 0
INDIRI4
CNSTI4 12
LTI4 $645
LABELV $647
line 1741
;1741:		return;
ADDRGP4 $644
JUMPV
LABELV $645
line 1744
;1742:	}
;1743:
;1744:	if ( !( pm->ps->stats[STAT_WEAPONS] & ( 1 << weapon ) ) ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 1
ADDRFP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
NEI4 $648
line 1745
;1745:		return;
ADDRGP4 $644
JUMPV
LABELV $648
line 1748
;1746:	}
;1747:	
;1748:	if ( pm->ps->weaponstate == WEAPON_DROPPING ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 2
NEI4 $650
line 1749
;1749:		return;
ADDRGP4 $644
JUMPV
LABELV $650
line 1752
;1750:	}
;1751:
;1752:	PM_AddEvent( EV_CHANGE_WEAPON );
CNSTI4 22
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1753
;1753:	pm->ps->weaponstate = WEAPON_DROPPING;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 2
ASGNI4
line 1754
;1754:	pm->ps->weaponTime += 200;
ADDRLP4 4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 200
ADDI4
ASGNI4
line 1755
;1755:	PM_StartTorsoAnim( TORSO_DROP );
CNSTI4 9
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1756
;1756:}
LABELV $644
endproc PM_BeginWeaponChange 8 4
proc PM_FinishWeaponChange 12 4
line 1764
;1757:
;1758:
;1759:/*
;1760:===============
;1761:PM_FinishWeaponChange
;1762:===============
;1763:*/
;1764:static void PM_FinishWeaponChange( void ) {
line 1767
;1765:	int		weapon;
;1766:
;1767:	weapon = pm->cmd.weapon;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
CNSTI4 24
ADDP4
INDIRU1
CVUI4 1
ASGNI4
line 1768
;1768:	if ( weapon < WP_NONE || weapon >= WP_NUM_WEAPONS ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $655
ADDRLP4 0
INDIRI4
CNSTI4 12
LTI4 $653
LABELV $655
line 1769
;1769:		weapon = WP_NONE;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1770
;1770:	}
LABELV $653
line 1772
;1771:
;1772:	if ( !( pm->ps->stats[STAT_WEAPONS] & ( 1 << weapon ) ) ) {
ADDRGP4 pm
INDIRP4
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
NEI4 $656
line 1773
;1773:		weapon = WP_NONE;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1774
;1774:	}
LABELV $656
line 1776
;1775:
;1776:	pm->ps->weapon = weapon;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1777
;1777:	pm->ps->weaponstate = WEAPON_RAISING;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 1
ASGNI4
line 1778
;1778:	pm->ps->weaponTime += 250;
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 250
ADDI4
ASGNI4
line 1779
;1779:	PM_StartTorsoAnim( TORSO_RAISE );
CNSTI4 10
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1780
;1780:}
LABELV $652
endproc PM_FinishWeaponChange 12 4
proc PM_TorsoAnimation 4 4
line 1789
;1781:
;1782:
;1783:/*
;1784:==============
;1785:PM_TorsoAnimation
;1786:
;1787:==============
;1788:*/
;1789:static void PM_TorsoAnimation( void ) {
line 1793
;1790:	// JUHOX: WEAPON_WIND_UP and WEAPON_WIND_OFF also use TORSO_STAND animation
;1791:#if 1
;1792:	if (
;1793:		pm->ps->weaponstate == WEAPON_WIND_UP ||
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 4
EQI4 $661
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 5
NEI4 $659
LABELV $661
line 1795
;1794:		pm->ps->weaponstate == WEAPON_WIND_OFF
;1795:	) {
line 1796
;1796:		PM_ContinueTorsoAnim(TORSO_STAND);
CNSTI4 11
ARGI4
ADDRGP4 PM_ContinueTorsoAnim
CALLV
pop
line 1797
;1797:		return;
ADDRGP4 $658
JUMPV
LABELV $659
line 1800
;1798:	}
;1799:#endif
;1800:	if ( pm->ps->weaponstate == WEAPON_READY ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 0
NEI4 $662
line 1805
;1801:		// JUHOX: use TORSO_STAND2 also for WP_NONE
;1802:#if 0
;1803:		if ( pm->ps->weapon == WP_GAUNTLET ) {
;1804:#else
;1805:		if (pm->ps->weapon <= WP_GAUNTLET) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 1
GTI4 $664
line 1807
;1806:#endif
;1807:			PM_ContinueTorsoAnim( TORSO_STAND2 );
CNSTI4 12
ARGI4
ADDRGP4 PM_ContinueTorsoAnim
CALLV
pop
line 1808
;1808:		} else {
ADDRGP4 $658
JUMPV
LABELV $664
line 1809
;1809:			PM_ContinueTorsoAnim( TORSO_STAND );
CNSTI4 11
ARGI4
ADDRGP4 PM_ContinueTorsoAnim
CALLV
pop
line 1810
;1810:		}
line 1811
;1811:		return;
LABELV $662
line 1813
;1812:	}
;1813:}
LABELV $658
endproc PM_TorsoAnimation 4 4
proc AngleKick 32 4
line 1822
;1814:
;1815:
;1816:/*
;1817:================
;1818:JUHOX: AngleKick
;1819:================
;1820:*/
;1821:#define ANGLE_KICK_ACC 1000.0	// degrees per second per second
;1822:static float AngleKick(float* kick) {
line 1828
;1823:	float acc;
;1824:	float t;
;1825:	float d;
;1826:	float move;
;1827:
;1828:	if (*kick == 0) return 0;
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 0
NEF4 $667
CNSTF4 0
RETF4
ADDRGP4 $666
JUMPV
LABELV $667
line 1830
;1829:
;1830:	if (*kick < 0) {
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 0
GEF4 $669
line 1831
;1831:		acc = ANGLE_KICK_ACC;
ADDRLP4 4
CNSTF4 1148846080
ASGNF4
line 1832
;1832:	}
ADDRGP4 $670
JUMPV
LABELV $669
line 1833
;1833:	else {
line 1834
;1834:		acc = -ANGLE_KICK_ACC;
ADDRLP4 4
CNSTF4 3296329728
ASGNF4
line 1835
;1835:	}
LABELV $670
line 1837
;1836:
;1837:	t = pml.msec * 0.001;
ADDRLP4 0
ADDRGP4 pml+40
INDIRI4
CVIF4 4
CNSTF4 981668463
MULF4
ASGNF4
line 1838
;1838:	d = acc * t;
ADDRLP4 8
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 1839
;1839:	if (fabs(d) > fabs(*kick)) {
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 16
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
INDIRF4
ARGF4
ADDRLP4 20
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 16
INDIRF4
ADDRLP4 20
INDIRF4
LEF4 $672
line 1840
;1840:		t = *kick / -acc;
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
NEGF4
DIVF4
ASGNF4
line 1841
;1841:		d = -*kick;
ADDRLP4 8
ADDRFP4 0
INDIRP4
INDIRF4
NEGF4
ASGNF4
line 1842
;1842:	}
LABELV $672
line 1844
;1843:
;1844:	move = *kick * t + 0.5 * acc * Square(t);
ADDRLP4 12
ADDRFP4 0
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDRLP4 4
INDIRF4
CNSTF4 1056964608
MULF4
ADDRLP4 0
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 1846
;1845:
;1846:	*kick += d;
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 8
INDIRF4
ADDF4
ASGNF4
line 1848
;1847:
;1848:	return move;
ADDRLP4 12
INDIRF4
RETF4
LABELV $666
endproc AngleKick 32 4
data
align 4
LABELV $676
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 1109393408
byte 4 1109393408
byte 4 75
byte 4 1106247680
byte 4 0
byte 4 0
byte 4 1125515264
byte 4 1128792064
byte 4 200
byte 4 0
byte 4 0
byte 4 0
byte 4 1112014848
byte 4 1120403456
byte 4 100
byte 4 0
byte 4 0
byte 4 0
byte 4 1120403456
byte 4 1128792064
byte 4 200
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 1128792064
byte 4 1142292480
byte 4 200
byte 4 1120403456
byte 4 1120403456
byte 4 200
byte 4 1103626240
byte 4 0
byte 4 0
byte 4 1097859072
byte 4 0
byte 4 0
byte 4 1127481344
byte 4 1133903872
byte 4 200
byte 4 1117126656
byte 4 1112014848
byte 4 200
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 1112014848
byte 4 1120403456
byte 4 100
byte 4 0
byte 4 0
byte 4 0
skip 96
code
proc PM_WeaponShake 56 16
line 1856
;1849:}
;1850:
;1851:/*
;1852:==============
;1853:JUHOX: PM_WeaponShake
;1854:==============
;1855:*/
;1856:static void PM_WeaponShake(playerState_t* ps) {
line 1884
;1857:	static const struct {
;1858:		float viewSpread;
;1859:		float knockback;
;1860:		int knockbackTime;
;1861:		float duckedViewSpread;
;1862:		float duckedKnockback;
;1863:		int duckedKnockbackTime;
;1864:	} weaponShakeCharacteristics[16] = {
;1865:		{0, 0, 0, 0, 0, 0},				// WP_NONE
;1866:		{0, 0, 0, 0, 0, 0},				// WP_GAUNTLET
;1867:		{40, 40, 75, 30, 0, 0},			// WP_MACHINEGUN
;1868:		{150, 200, 200, 0, 0, 0},		// WP_SHOTGUN
;1869:		{50, 100, 100, 0, 0, 0},		// WP_GRENADE_LAUNCHER
;1870:		{100, 200, 200, 0, 0, 0},		// WP_ROCKET_LAUNCHER
;1871:		{0, 0, 0, 0, 0, 0},				// WP_LIGHTNING
;1872:		{200, 600, 200, 100, 100, 200},	// WP_RAILGUN
;1873:		{25, 0, 0, 15, 0, 0},			// WP_PLASMAGUN
;1874:		{180, 300, 200, 75, 50, 200},	// WP_BFG
;1875:		{0, 0, 0, 0, 0, 0},				// WP_GRAPPLING_HOOK
;1876:#if MONSTER_MODE
;1877:		{50, 100, 100, 0, 0, 0},		// WP_MONSTER_LAUNCHER
;1878:#endif
;1879:	};
;1880:	float viewSpread;
;1881:	float knockback;
;1882:	int knockbackTime;
;1883:
;1884:	if (ps->clientNum >= MAX_CLIENTS) return;
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
CNSTI4 64
LTI4 $677
ADDRGP4 $674
JUMPV
LABELV $677
line 1886
;1885:
;1886:	if ((ps->pm_flags & PMF_DUCKED) && ps->groundEntityNum != ENTITYNUM_NONE) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $679
ADDRLP4 12
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1023
EQI4 $679
line 1887
;1887:		viewSpread = weaponShakeCharacteristics[ps->weapon].duckedViewSpread;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 $676+12
ADDP4
INDIRF4
ASGNF4
line 1888
;1888:		knockback = weaponShakeCharacteristics[ps->weapon].duckedKnockback;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 $676+16
ADDP4
INDIRF4
ASGNF4
line 1889
;1889:		knockbackTime = weaponShakeCharacteristics[ps->weapon].duckedKnockbackTime;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 $676+20
ADDP4
INDIRI4
ASGNI4
line 1890
;1890:	}
ADDRGP4 $680
JUMPV
LABELV $679
line 1891
;1891:	else {
line 1892
;1892:		viewSpread = weaponShakeCharacteristics[ps->weapon].viewSpread;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 $676
ADDP4
INDIRF4
ASGNF4
line 1893
;1893:		knockback = weaponShakeCharacteristics[ps->weapon].knockback;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 $676+4
ADDP4
INDIRF4
ASGNF4
line 1894
;1894:		knockbackTime = weaponShakeCharacteristics[ps->weapon].knockbackTime;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 $676+8
ADDP4
INDIRI4
ASGNI4
line 1895
;1895:	}
LABELV $680
line 1897
;1896:
;1897:	if (ps->stats[STAT_STRENGTH] < LOW_STRENGTH_VALUE) {
ADDRFP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1161527296
GEF4 $686
line 1900
;1898:		float wearinessFactor;
;1899:
;1900:		wearinessFactor = 2 - ps->stats[STAT_STRENGTH] / LOW_STRENGTH_VALUE;
ADDRLP4 16
CNSTF4 1073741824
ADDRFP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CVIF4 4
CNSTF4 967754558
MULF4
SUBF4
ASGNF4
line 1901
;1901:		viewSpread *= wearinessFactor;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ASGNF4
line 1902
;1902:		knockbackTime = knockbackTime * wearinessFactor;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRLP4 16
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 1903
;1903:	}
LABELV $686
line 1905
;1904:	
;1905:	viewSpread *= WEAPON_KICK_FACTOR;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1112014848
MULF4
ASGNF4
line 1907
;1906:	if (
;1907:		(ps->pm_flags & PMF_DUCKED) &&
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $688
ADDRLP4 16
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
NEI4 $691
ADDRLP4 16
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $690
LABELV $691
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 8
NEI4 $688
ADDRLP4 20
INDIRP4
CNSTI4 408
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $688
LABELV $690
line 1918
;1908:		(
;1909:			(
;1910:				ps->weapon == WP_MACHINEGUN &&
;1911:				(ps->ammo[WP_MACHINEGUN] & 1)
;1912:			) ||
;1913:			(
;1914:				ps->weapon == WP_PLASMAGUN &&
;1915:				(ps->ammo[WP_PLASMAGUN] & 1)
;1916:			)
;1917:		)
;1918:	) {
line 1919
;1919:		viewSpread = -viewSpread;
ADDRLP4 0
ADDRLP4 0
INDIRF4
NEGF4
ASGNF4
line 1920
;1920:	}
LABELV $688
line 1921
;1921:	ps->stats[STAT_WEAPON_KICK] -= viewSpread;	// negative pitch is upwards
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 200
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CVIF4 4
ADDRLP4 0
INDIRF4
SUBF4
CVFI4 4
ASGNI4
line 1923
;1922:
;1923:	if (knockbackTime) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $692
line 1926
;1924:		vec3_t forward;
;1925:
;1926:		AngleVectors(ps->viewangles, forward, NULL, NULL);	
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRLP4 28
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 1927
;1927:		VectorMA(ps->velocity, -knockback, forward, ps->velocity);
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 40
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 28
INDIRF4
ADDRLP4 8
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 44
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 28+4
INDIRF4
ADDRLP4 8
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 48
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 28+8
INDIRF4
ADDRLP4 8
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 1928
;1928:		if (!ps->pm_time) {
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 0
NEI4 $696
line 1929
;1929:			ps->pm_time = knockbackTime;
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 1930
;1930:			ps->pm_flags |= PMF_TIME_KNOCKBACK;
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
line 1931
;1931:		}
LABELV $696
line 1932
;1932:	}
LABELV $692
line 1933
;1933:}
LABELV $674
endproc PM_WeaponShake 56 16
proc PM_Weapon 56 4
line 1942
;1934:
;1935:/*
;1936:==============
;1937:PM_Weapon
;1938:
;1939:Generates weapon events and modifes the weapon counter
;1940:==============
;1941:*/
;1942:static void PM_Weapon( void ) {
line 1946
;1943:	int		addTime;
;1944:
;1945:	// don't allow attack until all buttons are up
;1946:	if ( pm->ps->pm_flags & PMF_RESPAWNED ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $699
line 1947
;1947:		return;
ADDRGP4 $698
JUMPV
LABELV $699
line 1951
;1948:	}
;1949:
;1950:	// ignore if spectator
;1951:	if ( pm->ps->persistant[PERS_TEAM] == TEAM_SPECTATOR ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 3
NEI4 $701
line 1952
;1952:		return;
ADDRGP4 $698
JUMPV
LABELV $701
line 1956
;1953:	}
;1954:
;1955:	// check for dead player
;1956:	if ( pm->ps->stats[STAT_HEALTH] <= 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $703
line 1957
;1957:		pm->ps->weapon = WP_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
CNSTI4 0
ASGNI4
line 1958
;1958:		return;
ADDRGP4 $698
JUMPV
LABELV $703
line 1962
;1959:	}
;1960:
;1961:	// check for item using
;1962:	if ( pm->cmd.buttons & BUTTON_USE_HOLDABLE ) {
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $705
line 1963
;1963:		if ( ! ( pm->ps->pm_flags & PMF_USE_ITEM_HELD ) ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
NEI4 $706
line 1964
;1964:			if ( bg_itemlist[pm->ps->stats[STAT_HOLDABLE_ITEM]].giTag == HI_MEDKIT
ADDRLP4 4
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 2
NEI4 $709
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 25
ADDI4
LTI4 $709
line 1965
;1965:				&& pm->ps->stats[STAT_HEALTH] >= (pm->ps->stats[STAT_MAX_HEALTH] + 25) ) {
line 1967
;1966:				// don't use medkit if at max health
;1967:			} else {
ADDRGP4 $698
JUMPV
LABELV $709
line 1968
;1968:				pm->ps->pm_flags |= PMF_USE_ITEM_HELD;
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1024
BORI4
ASGNI4
line 1969
;1969:				PM_AddEvent( EV_USE_ITEM0 + bg_itemlist[pm->ps->stats[STAT_HOLDABLE_ITEM]].giTag );
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 24
ADDI4
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1970
;1970:				pm->ps->stats[STAT_HOLDABLE_ITEM] = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 188
ADDP4
CNSTI4 0
ASGNI4
line 1971
;1971:			}
line 1972
;1972:			return;
ADDRGP4 $698
JUMPV
line 1974
;1973:		}
;1974:	} else {
LABELV $705
line 1975
;1975:		pm->ps->pm_flags &= ~PMF_USE_ITEM_HELD;
ADDRLP4 4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -1025
BANDI4
ASGNI4
line 1976
;1976:	}
LABELV $706
line 1980
;1977:
;1978:
;1979:	// make weapon function
;1980:	if ( pm->ps->weaponTime > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
LEI4 $713
line 1981
;1981:		pm->ps->weaponTime -= pml.msec;
ADDRLP4 4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
ADDRGP4 pml+40
INDIRI4
SUBI4
ASGNI4
line 1982
;1982:	}
LABELV $713
line 1985
;1983:
;1984:#if 1	// JUHOX: no fire with shield
;1985:	if (pm->ps->powerups[PW_SHIELD]) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 356
ADDP4
INDIRI4
CNSTI4 0
EQI4 $716
line 1986
;1986:		pm->cmd.buttons &= ~BUTTON_ATTACK;
ADDRLP4 4
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 1987
;1987:	}
LABELV $716
line 1991
;1988:#endif
;1989:
;1990:#if 1	// JUHOX: can't fire lightning gun under water
;1991:	if (pm->ps->weapon == WP_LIGHTNING && pm->waterlevel > 1) {
ADDRLP4 4
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 6
NEI4 $718
ADDRLP4 4
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CNSTI4 1
LEI4 $718
line 1992
;1992:		pm->cmd.buttons &= ~BUTTON_ATTACK;
ADDRLP4 8
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 1993
;1993:		pm->ps->eFlags &= ~EF_FIRING;
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 -257
BANDI4
ASGNI4
line 1994
;1994:	}
LABELV $718
line 2008
;1995:#endif
;1996:
;1997:	// check for weapon change
;1998:	// can't change if weapon is firing, but can change
;1999:	// again if lowering or raising
;2000:#if 0	// JUHOX: can't change weapon during wind up or wind down
;2001:	if ( pm->ps->weaponTime <= 0 || pm->ps->weaponstate != WEAPON_FIRING ) {
;2002:		if ( pm->ps->weapon != pm->cmd.weapon ) {
;2003:			PM_BeginWeaponChange( pm->cmd.weapon );
;2004:		}
;2005:	}
;2006:#else
;2007:	if (
;2008:		pm->ps->weaponstate < WEAPON_FIRING ||
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 3
LTI4 $722
ADDRLP4 8
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 3
NEI4 $720
ADDRLP4 8
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
GTI4 $720
ADDRLP4 8
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
EQI4 $720
LABELV $722
line 2014
;2009:		(
;2010:			pm->ps->weaponstate == WEAPON_FIRING &&
;2011:			pm->ps->weaponTime <= 0 &&
;2012:			pm->ps->weapon != WP_MACHINEGUN
;2013:		)
;2014:	) {
line 2015
;2015:		if (pm->ps->weapon != pm->cmd.weapon) {
ADDRLP4 12
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 24
ADDP4
INDIRU1
CVUI4 1
EQI4 $723
line 2016
;2016:			PM_BeginWeaponChange(pm->cmd.weapon);
ADDRGP4 pm
INDIRP4
CNSTI4 24
ADDP4
INDIRU1
CVUI4 1
ARGI4
ADDRGP4 PM_BeginWeaponChange
CALLV
pop
line 2017
;2017:		}
LABELV $723
line 2018
;2018:	}
LABELV $720
line 2021
;2019:#endif
;2020:
;2021:	if ( pm->ps->weaponTime > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
LEI4 $725
line 2022
;2022:		return;
ADDRGP4 $698
JUMPV
LABELV $725
line 2026
;2023:	}
;2024:
;2025:	// change weapon if time
;2026:	if ( pm->ps->weaponstate == WEAPON_DROPPING ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 2
NEI4 $727
line 2027
;2027:		PM_FinishWeaponChange();
ADDRGP4 PM_FinishWeaponChange
CALLV
pop
line 2028
;2028:		return;
ADDRGP4 $698
JUMPV
LABELV $727
line 2031
;2029:	}
;2030:
;2031:	if ( pm->ps->weaponstate == WEAPON_RAISING ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 1
NEI4 $729
line 2032
;2032:		pm->ps->weaponstate = WEAPON_READY;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 2036
;2033:#if 0	// JUHOX: use TORSO_STAND2 also for WP_NONE
;2034:		if ( pm->ps->weapon == WP_GAUNTLET ) {
;2035:#else
;2036:		if (pm->ps->weapon <= WP_GAUNTLET) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 1
GTI4 $731
line 2038
;2037:#endif
;2038:			PM_StartTorsoAnim( TORSO_STAND2 );
CNSTI4 12
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 2039
;2039:		} else {
ADDRGP4 $698
JUMPV
LABELV $731
line 2040
;2040:			PM_StartTorsoAnim( TORSO_STAND );
CNSTI4 11
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 2041
;2041:		}
line 2042
;2042:		return;
ADDRGP4 $698
JUMPV
LABELV $729
line 2047
;2043:	}
;2044:
;2045:	
;2046:#if 1	// JUHOX: check for new weapon state
;2047:	if (pm->ps->weapon == WP_MACHINEGUN) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
NEI4 $733
line 2049
;2048:		if (
;2049:			pm->ps->weaponstate == WEAPON_WIND_UP ||
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 4
EQI4 $737
ADDRLP4 12
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 3
NEI4 $735
LABELV $737
line 2051
;2050:			pm->ps->weaponstate == WEAPON_FIRING
;2051:		) {
line 2054
;2052:			// ready to fire
;2053:			if (
;2054:				!(pm->cmd.buttons & BUTTON_ATTACK) ||
ADDRLP4 16
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $741
ADDRLP4 20
ADDRLP4 16
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 0
EQI4 $741
ADDRLP4 20
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ADDRLP4 16
INDIRP4
CNSTI4 24
ADDP4
INDIRU1
CVUI4 1
EQI4 $736
LABELV $741
line 2057
;2055:				pm->ps->ammo[WP_MACHINEGUN] == 0 ||
;2056:				pm->ps->weapon != pm->cmd.weapon
;2057:			) {
line 2059
;2058:				if (
;2059:					pm->ps->ammo[WP_MACHINEGUN] == 0 &&
ADDRLP4 24
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 0
NEI4 $742
ADDRLP4 24
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $742
line 2061
;2060:					(pm->cmd.buttons & BUTTON_ATTACK)
;2061:				) {
line 2062
;2062:					PM_AddEvent(EV_NOAMMO);
CNSTI4 21
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 2063
;2063:				}
LABELV $742
line 2064
;2064:				pm->ps->weaponstate = WEAPON_WIND_OFF;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 5
ASGNI4
line 2065
;2065:				pm->ps->weaponTime = MACHINEGUN_WIND_OFF_TIME;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 1000
ASGNI4
line 2066
;2066:				return;
ADDRGP4 $698
JUMPV
line 2068
;2067:			}
;2068:		}
LABELV $735
line 2069
;2069:		else if (pm->ps->weaponstate == WEAPON_WIND_OFF) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 5
NEI4 $744
line 2070
;2070:			pm->ps->weaponstate = WEAPON_READY;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 2071
;2071:			pm->ps->weaponTime = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 0
ASGNI4
line 2072
;2072:			return;
ADDRGP4 $698
JUMPV
LABELV $744
line 2074
;2073:		}
;2074:		else if (pm->cmd.buttons & BUTTON_ATTACK) {
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $746
line 2076
;2075:			// player wants to start the weapon
;2076:			if (pm->ps->ammo[pm->ps->weapon] != 0) {
ADDRLP4 16
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $748
line 2077
;2077:				pm->ps->weaponstate = WEAPON_WIND_UP;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 4
ASGNI4
line 2078
;2078:				pm->ps->weaponTime = MACHINEGUN_WIND_UP_TIME;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 650
ASGNI4
line 2079
;2079:				return;
ADDRGP4 $698
JUMPV
LABELV $748
line 2081
;2080:			}
;2081:		}
LABELV $746
LABELV $736
line 2082
;2082:	}
LABELV $733
line 2086
;2083:#endif
;2084:
;2085:	// check for fire
;2086:	if ( ! (pm->cmd.buttons & BUTTON_ATTACK) ) {
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $750
line 2087
;2087:		pm->ps->weaponTime = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 0
ASGNI4
line 2088
;2088:		pm->ps->weaponstate = WEAPON_READY;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 2089
;2089:		return;
ADDRGP4 $698
JUMPV
LABELV $750
line 2093
;2090:	}
;2091:
;2092:#if GRAPPLE_ROPE	// JUHOX: the grapple can't shoot while used
;2093:	if (pm->ps->weapon == WP_GRAPPLING_HOOK && pm->ps->stats[STAT_GRAPPLE_STATE] != GST_unused) {
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 10
NEI4 $752
ADDRLP4 12
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
EQI4 $752
line 2094
;2094:		pm->ps->weaponTime = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 0
ASGNI4
line 2095
;2095:		pm->ps->weaponstate = WEAPON_READY;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 2096
;2096:		return;
ADDRGP4 $698
JUMPV
LABELV $752
line 2104
;2097:	}
;2098:#endif
;2099:
;2100:	// start the animation even if out of ammo
;2101:#if !MONSTER_MODE	// JUHOX: WP_NONE works like WP_GAUNTLET
;2102:	if ( pm->ps->weapon == WP_GAUNTLET ) {
;2103:#else
;2104:	if (pm->ps->weapon <= WP_GAUNTLET) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 1
GTI4 $754
line 2107
;2105:#endif
;2106:		// the guantlet only "fires" when it actually hits something
;2107:		if ( !pm->gauntletHit ) {
ADDRGP4 pm
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 0
NEI4 $756
line 2108
;2108:			pm->ps->weaponTime = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 0
ASGNI4
line 2109
;2109:			pm->ps->weaponstate = WEAPON_READY;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 2110
;2110:			return;
ADDRGP4 $698
JUMPV
LABELV $756
line 2112
;2111:		}
;2112:		PM_StartTorsoAnim( TORSO_ATTACK2 );
CNSTI4 8
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 2113
;2113:	} else {
ADDRGP4 $755
JUMPV
LABELV $754
line 2114
;2114:		PM_StartTorsoAnim( TORSO_ATTACK );
CNSTI4 7
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 2115
;2115:	}
LABELV $755
line 2117
;2116:
;2117:	pm->ps->weaponstate = WEAPON_FIRING;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 3
ASGNI4
line 2120
;2118:
;2119:	// check for out of ammo
;2120:	if ( ! pm->ps->ammo[ pm->ps->weapon ] ) {
ADDRLP4 16
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $758
line 2121
;2121:		PM_AddEvent( EV_NOAMMO );
CNSTI4 21
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 2122
;2122:		pm->ps->weaponTime += 500;
ADDRLP4 20
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 2123
;2123:		return;
ADDRGP4 $698
JUMPV
LABELV $758
line 2127
;2124:	}
;2125:
;2126:	// take an ammo away if not infinite
;2127:	if ( pm->ps->ammo[ pm->ps->weapon ] /*!= -1*/>0 ) {	// JUHOX
ADDRLP4 20
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
CNSTI4 0
LEI4 $760
line 2128
;2128:		pm->ps->ammo[ pm->ps->weapon ]--;
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 24
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 24
INDIRP4
CNSTI4 376
ADDP4
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2129
;2129:	}
ADDRGP4 $761
JUMPV
LABELV $760
line 2130
;2130:	else pm->ps->ammo[pm->ps->weapon] ^= 1;	// JUHOX: for weapon shaking
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 24
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 24
INDIRP4
CNSTI4 376
ADDP4
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
LABELV $761
line 2133
;2131:
;2132:#if 1	// JUHOX: bump seed for weapon shaking
;2133:	{
line 2136
;2134:		localseed_t seed;
;2135:
;2136:		seed.seed0 = pm->ps->generic1;
ADDRLP4 32
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
CVIU4 4
ASGNU4
line 2137
;2137:		seed.seed1 = pm->ps->clientNum;
ADDRLP4 32+4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
CVIU4 4
ASGNU4
line 2138
;2138:		seed.seed2 = pm->ps->persistant[PERS_SPAWN_COUNT];
ADDRLP4 32+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 264
ADDP4
INDIRI4
CVIU4 4
ASGNU4
line 2139
;2139:		seed.seed3 = pm->ps->ammo[pm->ps->weapon];
ADDRLP4 48
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 32+12
ADDRLP4 48
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 48
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
CVIU4 4
ASGNU4
line 2140
;2140:		pm->ps->generic1 = LocallySeededRandom(&seed) & 255;
ADDRLP4 32
ARGP4
ADDRLP4 52
ADDRGP4 LocallySeededRandom
CALLU4
ASGNU4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 440
ADDP4
ADDRLP4 52
INDIRU4
CNSTU4 255
BANDU4
CVUI4 4
ASGNI4
line 2141
;2141:	}
line 2145
;2142:#endif
;2143:
;2144:	// fire weapon
;2145:	PM_AddEvent( EV_FIRE_WEAPON );
CNSTI4 23
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 2147
;2146:
;2147:	switch( pm->ps->weapon ) {
ADDRLP4 32
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 1
LTI4 $765
ADDRLP4 32
INDIRI4
CNSTI4 11
GTI4 $765
ADDRLP4 32
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $781-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $781
address $768
address $771
address $770
address $772
address $773
address $769
address $777
address $776
address $778
address $779
address $780
code
LABELV $765
line 2150
;2148:	default:
;2149:#if 1	// JUHOX: weapon time for WP_NONE
;2150:		addTime = 400;
ADDRLP4 0
CNSTI4 400
ASGNI4
line 2151
;2151:		break;
ADDRGP4 $766
JUMPV
LABELV $768
line 2154
;2152:#endif
;2153:	case WP_GAUNTLET:
;2154:		addTime = 50;	// JUHOX: 400
ADDRLP4 0
CNSTI4 50
ASGNI4
line 2155
;2155:		break;
ADDRGP4 $766
JUMPV
LABELV $769
line 2157
;2156:	case WP_LIGHTNING:
;2157:		addTime = 50;
ADDRLP4 0
CNSTI4 50
ASGNI4
line 2158
;2158:		break;
ADDRGP4 $766
JUMPV
LABELV $770
line 2160
;2159:	case WP_SHOTGUN:
;2160:		addTime = 1000;
ADDRLP4 0
CNSTI4 1000
ASGNI4
line 2161
;2161:		break;
ADDRGP4 $766
JUMPV
LABELV $771
line 2163
;2162:	case WP_MACHINEGUN:
;2163:		addTime = 100;
ADDRLP4 0
CNSTI4 100
ASGNI4
line 2164
;2164:		break;
ADDRGP4 $766
JUMPV
LABELV $772
line 2166
;2165:	case WP_GRENADE_LAUNCHER:
;2166:		addTime = 300;	// JUHOX: 800
ADDRLP4 0
CNSTI4 300
ASGNI4
line 2167
;2167:		break;
ADDRGP4 $766
JUMPV
LABELV $773
line 2169
;2168:	case WP_ROCKET_LAUNCHER:
;2169:		addTime = 600;	// JUHOX: 800
ADDRLP4 0
CNSTI4 600
ASGNI4
line 2172
;2170:		// JUHOX: monster's (guard's) rocket shoots faster
;2171:#if MONSTER_MODE
;2172:		if (pm->ps->clientNum >= MAX_CLIENTS) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
CNSTI4 64
LTI4 $766
line 2173
;2173:			addTime = 200;
ADDRLP4 0
CNSTI4 200
ASGNI4
line 2174
;2174:		}
line 2176
;2175:#endif
;2176:		break;
ADDRGP4 $766
JUMPV
LABELV $776
line 2178
;2177:	case WP_PLASMAGUN:
;2178:		addTime = 100;
ADDRLP4 0
CNSTI4 100
ASGNI4
line 2179
;2179:		break;
ADDRGP4 $766
JUMPV
LABELV $777
line 2181
;2180:	case WP_RAILGUN:
;2181:		addTime = 1500;
ADDRLP4 0
CNSTI4 1500
ASGNI4
line 2182
;2182:		break;
ADDRGP4 $766
JUMPV
LABELV $778
line 2184
;2183:	case WP_BFG:
;2184:		addTime = 4000;	// JUHOX: 200
ADDRLP4 0
CNSTI4 4000
ASGNI4
line 2185
;2185:		break;
ADDRGP4 $766
JUMPV
LABELV $779
line 2187
;2186:	case WP_GRAPPLING_HOOK:
;2187:		addTime = 400;
ADDRLP4 0
CNSTI4 400
ASGNI4
line 2188
;2188:		break;
ADDRGP4 $766
JUMPV
LABELV $780
line 2202
;2189:#ifdef MISSIONPACK
;2190:	case WP_NAILGUN:
;2191:		addTime = 1000;
;2192:		break;
;2193:	case WP_PROX_LAUNCHER:
;2194:		addTime = 800;
;2195:		break;
;2196:	case WP_CHAINGUN:
;2197:		addTime = 30;
;2198:		break;
;2199:#endif
;2200:#if MONSTER_MODE	// JUHOX: reload time for monster launcher
;2201:	case WP_MONSTER_LAUNCHER:
;2202:		addTime = 300;
ADDRLP4 0
CNSTI4 300
ASGNI4
line 2203
;2203:		break;
LABELV $766
line 2223
;2204:#endif
;2205:	}
;2206:
;2207:#ifdef MISSIONPACK
;2208:	if( bg_itemlist[pm->ps->stats[STAT_PERSISTANT_POWERUP]].giTag == PW_SCOUT ) {
;2209:		addTime /= 1.5;
;2210:	}
;2211:	else
;2212:	if( bg_itemlist[pm->ps->stats[STAT_PERSISTANT_POWERUP]].giTag == PW_AMMOREGEN ) {
;2213:		addTime /= 1.3;
;2214:  }
;2215:  else
;2216:#endif
;2217:#if 0	// JUHOX: no normal haste
;2218:	if ( pm->ps->powerups[PW_HASTE] ) {
;2219:		addTime /= 1.3;
;2220:	}
;2221:#endif
;2222:
;2223:	pm->ps->weaponTime += addTime;
ADDRLP4 40
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 2225
;2224:
;2225:	PM_WeaponShake(pm->ps);	// JUHOX
ADDRGP4 pm
INDIRP4
INDIRP4
ARGP4
ADDRGP4 PM_WeaponShake
CALLV
pop
line 2226
;2226:}
LABELV $698
endproc PM_Weapon 56 4
proc PM_Animate 0 4
line 2234
;2227:
;2228:/*
;2229:================
;2230:PM_Animate
;2231:================
;2232:*/
;2233:
;2234:static void PM_Animate( void ) {
line 2235
;2235:	if ( pm->cmd.buttons & BUTTON_GESTURE ) {
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $784
line 2236
;2236:		if ( pm->ps->torsoTimer == 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
NEI4 $786
line 2237
;2237:			PM_StartTorsoAnim( TORSO_GESTURE );
CNSTI4 6
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 2238
;2238:			pm->ps->torsoTimer = TIMER_GESTURE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
CNSTI4 2294
ASGNI4
line 2239
;2239:			PM_AddEvent( EV_TAUNT );
CNSTI4 77
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 2240
;2240:		}
LABELV $786
line 2273
;2241:#ifdef MISSIONPACK
;2242:	} else if ( pm->cmd.buttons & BUTTON_GETFLAG ) {
;2243:		if ( pm->ps->torsoTimer == 0 ) {
;2244:			PM_StartTorsoAnim( TORSO_GETFLAG );
;2245:			pm->ps->torsoTimer = 600;	//TIMER_GESTURE;
;2246:		}
;2247:	} else if ( pm->cmd.buttons & BUTTON_GUARDBASE ) {
;2248:		if ( pm->ps->torsoTimer == 0 ) {
;2249:			PM_StartTorsoAnim( TORSO_GUARDBASE );
;2250:			pm->ps->torsoTimer = 600;	//TIMER_GESTURE;
;2251:		}
;2252:	} else if ( pm->cmd.buttons & BUTTON_PATROL ) {
;2253:		if ( pm->ps->torsoTimer == 0 ) {
;2254:			PM_StartTorsoAnim( TORSO_PATROL );
;2255:			pm->ps->torsoTimer = 600;	//TIMER_GESTURE;
;2256:		}
;2257:	} else if ( pm->cmd.buttons & BUTTON_FOLLOWME ) {
;2258:		if ( pm->ps->torsoTimer == 0 ) {
;2259:			PM_StartTorsoAnim( TORSO_FOLLOWME );
;2260:			pm->ps->torsoTimer = 600;	//TIMER_GESTURE;
;2261:		}
;2262:	} else if ( pm->cmd.buttons & BUTTON_AFFIRMATIVE ) {
;2263:		if ( pm->ps->torsoTimer == 0 ) {
;2264:			PM_StartTorsoAnim( TORSO_AFFIRMATIVE);
;2265:			pm->ps->torsoTimer = 600;	//TIMER_GESTURE;
;2266:		}
;2267:	} else if ( pm->cmd.buttons & BUTTON_NEGATIVE ) {
;2268:		if ( pm->ps->torsoTimer == 0 ) {
;2269:			PM_StartTorsoAnim( TORSO_NEGATIVE );
;2270:			pm->ps->torsoTimer = 600;	//TIMER_GESTURE;
;2271:		}
;2272:#endif
;2273:	}
LABELV $784
line 2274
;2274:}
LABELV $783
endproc PM_Animate 0 4
proc PM_DropTimers 4 0
line 2282
;2275:
;2276:
;2277:/*
;2278:================
;2279:PM_DropTimers
;2280:================
;2281:*/
;2282:static void PM_DropTimers( void ) {
line 2284
;2283:	// drop misc timing counter
;2284:	if ( pm->ps->pm_time ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 0
EQI4 $789
line 2285
;2285:		if ( pml.msec >= pm->ps->pm_time ) {
ADDRGP4 pml+40
INDIRI4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
LTI4 $791
line 2286
;2286:			pm->ps->pm_flags &= ~PMF_ALL_TIMES;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 -353
BANDI4
ASGNI4
line 2287
;2287:			pm->ps->pm_time = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 0
ASGNI4
line 2288
;2288:		} else {
ADDRGP4 $792
JUMPV
LABELV $791
line 2289
;2289:			pm->ps->pm_time -= pml.msec;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 pml+40
INDIRI4
SUBI4
ASGNI4
line 2290
;2290:		}
LABELV $792
line 2291
;2291:	}
LABELV $789
line 2294
;2292:
;2293:	// drop animation counter
;2294:	if ( pm->ps->legsTimer > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
LEI4 $795
line 2295
;2295:		pm->ps->legsTimer -= pml.msec;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 pml+40
INDIRI4
SUBI4
ASGNI4
line 2296
;2296:		if ( pm->ps->legsTimer < 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
GEI4 $798
line 2297
;2297:			pm->ps->legsTimer = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 0
ASGNI4
line 2298
;2298:		}
LABELV $798
line 2299
;2299:	}
LABELV $795
line 2301
;2300:
;2301:	if ( pm->ps->torsoTimer > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
LEI4 $800
line 2302
;2302:		pm->ps->torsoTimer -= pml.msec;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 pml+40
INDIRI4
SUBI4
ASGNI4
line 2303
;2303:		if ( pm->ps->torsoTimer < 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
GEI4 $803
line 2304
;2304:			pm->ps->torsoTimer = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
CNSTI4 0
ASGNI4
line 2305
;2305:		}
LABELV $803
line 2306
;2306:	}
LABELV $800
line 2307
;2307:}
LABELV $788
endproc PM_DropTimers 4 0
export PM_UpdateViewAngles
proc PM_UpdateViewAngles 64 8
line 2317
;2308:
;2309:/*
;2310:================
;2311:PM_UpdateViewAngles
;2312:
;2313:This can be used as another entry point when only the viewangles
;2314:are being updated isntead of a full move
;2315:================
;2316:*/
;2317:void PM_UpdateViewAngles( playerState_t *ps, const usercmd_t *cmd ) {
line 2321
;2318:	short		temp;
;2319:	int		i;
;2320:
;2321:	if ( ps->pm_type == PM_INTERMISSION || ps->pm_type == PM_SPINTERMISSION) {
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 5
EQI4 $808
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 6
NEI4 $806
LABELV $808
line 2322
;2322:		return;		// no view changes at all
ADDRGP4 $805
JUMPV
LABELV $806
line 2325
;2323:	}
;2324:
;2325:	if ( ps->pm_type != PM_SPECTATOR && ps->stats[STAT_HEALTH] <= 0 ) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $809
ADDRLP4 12
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $809
line 2326
;2326:		return;		// no view changes at all
ADDRGP4 $805
JUMPV
LABELV $809
line 2330
;2327:	}
;2328:
;2329:#if MEETING	// JUHOX: no view changes during meeting
;2330:	if (ps->pm_type == PM_MEETING) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 7
NEI4 $811
line 2331
;2331:		return;
ADDRGP4 $805
JUMPV
LABELV $811
line 2337
;2332:	}
;2333:#endif
;2334:
;2335:#if 1	// JUHOX: gauntlet lock target mechanism
;2336:	if (
;2337:		ps->weapon == WP_GAUNTLET &&
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 1
NEI4 $813
ADDRLP4 16
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
LEI4 $813
ADDRLP4 20
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $813
ADDRLP4 16
INDIRP4
CNSTI4 328
ADDP4
INDIRI4
CNSTI4 0
NEI4 $813
ADDRLP4 20
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $813
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $813
ADDRLP4 16
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 0
LTI4 $813
line 2344
;2338:		ps->stats[STAT_HEALTH] > 0 &&
;2339:		(cmd->buttons & BUTTON_ATTACK) &&
;2340:		!ps->powerups[PW_INVIS] &&
;2341:		!(cmd->buttons & BUTTON_WALKING) &&
;2342:		!(ps->pm_flags & PMF_DUCKED) &&
;2343:		ps->stats[STAT_TARGET] >= 0
;2344:	) {
line 2348
;2345:		vec3_t dir;
;2346:		vec3_t angles;
;2347:
;2348:		VectorSubtract(pm->target, ps->origin, dir);
ADDRLP4 48
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
ADDRLP4 48
INDIRP4
CNSTI4 48
ADDP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 36+4
ADDRLP4 48
INDIRP4
CNSTI4 52
ADDP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 36+8
ADDRGP4 pm
INDIRP4
CNSTI4 56
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2349
;2349:		dir[2] -= ps->viewheight;	// viewers viewheight
ADDRLP4 36+8
ADDRLP4 36+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 2350
;2350:		vectoangles(dir, angles);
ADDRLP4 36
ARGP4
ADDRLP4 24
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2351
;2351:		if (angles[PITCH] > 180) angles[PITCH] -= 360;
ADDRLP4 24
INDIRF4
CNSTF4 1127481344
LEF4 $818
ADDRLP4 24
ADDRLP4 24
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
ADDRGP4 $819
JUMPV
LABELV $818
line 2352
;2352:		else if (angles[PITCH] < -180) angles[PITCH] += 360;
ADDRLP4 24
INDIRF4
CNSTF4 3274964992
GEF4 $820
ADDRLP4 24
ADDRLP4 24
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
LABELV $820
LABELV $819
line 2353
;2353:		for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $822
line 2354
;2354:			if (i == YAW && (angles[PITCH] > 65 || angles[PITCH] < -65)) continue;
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $826
ADDRLP4 56
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 56
INDIRF4
CNSTF4 1115815936
GTF4 $828
ADDRLP4 56
INDIRF4
CNSTF4 3263299584
GEF4 $826
LABELV $828
ADDRGP4 $823
JUMPV
LABELV $826
line 2355
;2355:			ps->delta_angles[i] = ANGLE2SHORT(angles[i]) - cmd->angles[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 24
ADDP4
INDIRF4
CNSTF4 1127615329
MULF4
CVFI4 4
CNSTI4 65535
BANDI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDP4
INDIRI4
SUBI4
ASGNI4
line 2356
;2356:		}
LABELV $823
line 2353
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $822
line 2357
;2357:	}
LABELV $813
line 2361
;2358:#endif
;2359:
;2360:	// circularly clamp the angles with deltas
;2361:	for (i=0 ; i<3 ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $829
line 2362
;2362:		temp = cmd->angles[i] + ps->delta_angles[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
ADDP4
INDIRI4
ADDI4
CVII2 4
ASGNI2
line 2363
;2363:		if ( i == PITCH ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $833
line 2365
;2364:			// don't let the player look up or down more than 90 degrees
;2365:			if ( temp > 16000 ) {
ADDRLP4 4
INDIRI2
CVII4 2
CNSTI4 16000
LEI4 $835
line 2366
;2366:				ps->delta_angles[i] = 16000 - cmd->angles[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
ADDP4
CNSTI4 16000
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDP4
INDIRI4
SUBI4
ASGNI4
line 2367
;2367:				temp = 16000;
ADDRLP4 4
CNSTI2 16000
ASGNI2
line 2368
;2368:			} else if ( temp < -16000 ) {
ADDRGP4 $836
JUMPV
LABELV $835
ADDRLP4 4
INDIRI2
CVII4 2
CNSTI4 -16000
GEI4 $837
line 2369
;2369:				ps->delta_angles[i] = -16000 - cmd->angles[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
ADDP4
CNSTI4 -16000
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDP4
INDIRI4
SUBI4
ASGNI4
line 2370
;2370:				temp = -16000;
ADDRLP4 4
CNSTI2 -16000
ASGNI2
line 2371
;2371:			}
LABELV $837
LABELV $836
line 2372
;2372:		}
LABELV $833
line 2373
;2373:		ps->viewangles[i] = SHORT2ANGLE(temp);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
ADDP4
ADDRLP4 4
INDIRI2
CVII4 2
CVIF4 4
CNSTF4 1001652224
MULF4
ASGNF4
line 2374
;2374:	}
LABELV $830
line 2361
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $829
line 2376
;2375:
;2376:}
LABELV $805
endproc PM_UpdateViewAngles 64 8
export CalcWeariness
proc CalcWeariness 36 4
line 2384
;2377:
;2378:
;2379:/*
;2380:================
;2381:JUHOX: CalcWeariness
;2382:================
;2383:*/
;2384:void CalcWeariness(void) {
line 2386
;2385:#if MONSTER_MODE
;2386:	if (pm->ps->clientNum >= MAX_CLIENTS) return;	// speed up
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
CNSTI4 64
LTI4 $840
ADDRGP4 $839
JUMPV
LABELV $840
line 2388
;2387:#endif
;2388:	if (pm->ps->persistant[PERS_TEAM] != TEAM_SPECTATOR) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 3
EQI4 $842
line 2391
;2389:		qboolean weary;
;2390:
;2391:		weary = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2393
;2392:		if (
;2393:			(
ADDRLP4 4
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 4
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $847
ADDRLP4 4
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CNSTI4 1
GTI4 $847
ADDRLP4 8
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $844
LABELV $847
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 12
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 64
GTI4 $849
ADDRGP4 pm
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 16
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 64
GTI4 $849
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 20
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 64
LEI4 $844
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $844
LABELV $849
line 2403
;2394:				!(pm->ps->pm_flags & PMF_DUCKED) ||
;2395:				pm->waterlevel > 1 ||
;2396:				pm->ps->stats[STAT_HEALTH] <= 0
;2397:			) &&
;2398:			(
;2399:				abs(pm->cmd.forwardmove) > 64 ||
;2400:				abs(pm->cmd.rightmove) > 64 ||
;2401:				(abs(pm->cmd.upmove) > 64 && !(pm->ps->pm_flags & PMF_JUMP_HELD))
;2402:			)
;2403:		) {
line 2405
;2404:			// running
;2405:			pm->ps->stats[STAT_STRENGTH] -= WEARY_ONE_SECOND * pml.frametime;
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 212
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 pml+36
INDIRF4
CNSTF4 1133903872
MULF4
SUBF4
CVFI4 4
ASGNI4
line 2406
;2406:			weary = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 2407
;2407:		}
LABELV $844
line 2409
;2408:		if (
;2409:			pm->waterlevel >= 3 ||
ADDRLP4 24
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CNSTI4 3
GEI4 $853
ADDRLP4 24
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $851
LABELV $853
line 2411
;2410:			(pm->cmd.buttons & BUTTON_HOLD_BREATH)
;2411:		) {
line 2412
;2412:			pm->ps->stats[STAT_STRENGTH] -= 0.5 * WEARY_ONE_SECOND * pml.frametime;
ADDRLP4 28
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 212
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 pml+36
INDIRF4
CNSTF4 1125515264
MULF4
SUBF4
CVFI4 4
ASGNI4
line 2413
;2413:			weary = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 2414
;2414:		}
LABELV $851
line 2417
;2415:	
;2416:		// refreshing
;2417:		if (!weary) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $855
line 2418
;2418:			if (pm->cmd.forwardmove || pm->cmd.rightmove || pm->cmd.upmove) {
ADDRLP4 28
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $860
ADDRLP4 28
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $860
ADDRLP4 28
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $857
LABELV $860
line 2420
;2419:				// walking
;2420:				pm->ps->stats[STAT_STRENGTH] += REFRESH_ONE_SECOND * pml.frametime;
ADDRLP4 32
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 212
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 pml+36
INDIRF4
CNSTF4 1120403456
MULF4
ADDF4
CVFI4 4
ASGNI4
line 2421
;2421:			}
ADDRGP4 $858
JUMPV
LABELV $857
line 2422
;2422:			else {
line 2424
;2423:				// pausing
;2424:				pm->ps->stats[STAT_STRENGTH] += 2 * REFRESH_ONE_SECOND * pml.frametime;
ADDRLP4 32
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 212
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 pml+36
INDIRF4
CNSTF4 1128792064
MULF4
ADDF4
CVFI4 4
ASGNI4
line 2425
;2425:			}
LABELV $858
line 2426
;2426:		}
LABELV $855
line 2428
;2427:
;2428:		if (pm->ps->stats[STAT_STRENGTH] < 0) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 0
GEI4 $863
line 2429
;2429:			pm->ps->stats[STAT_STRENGTH] = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 212
ADDP4
CNSTI4 0
ASGNI4
line 2430
;2430:		}
ADDRGP4 $864
JUMPV
LABELV $863
line 2431
;2431:		else if (pm->ps->stats[STAT_STRENGTH] > MAX_STRENGTH_VALUE) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1183621120
LEF4 $865
line 2432
;2432:			pm->ps->stats[STAT_STRENGTH] = MAX_STRENGTH_VALUE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 212
ADDP4
CNSTI4 18000
ASGNI4
line 2433
;2433:		}
LABELV $865
LABELV $864
line 2434
;2434:	}
LABELV $842
line 2435
;2435:}
LABELV $839
endproc CalcWeariness 36 4
export PmoveSingle
proc PmoveSingle 116 16
line 2445
;2436:
;2437:/*
;2438:================
;2439:PmoveSingle
;2440:
;2441:================
;2442:*/
;2443:void trap_SnapVector( float *v );
;2444:
;2445:void PmoveSingle (pmove_t *pmove) {
line 2449
;2446:	int oldCommandTime;	// JUHOX
;2447:	vec3_t oldOrigin;	// JUHOX
;2448:
;2449:	pm = pmove;
ADDRGP4 pm
ADDRFP4 0
INDIRP4
ASGNP4
line 2450
;2450:	oldCommandTime = pm->ps->commandTime;	// JUHOX
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
INDIRI4
ASGNI4
line 2451
;2451:	VectorCopy(pm->ps->origin, oldOrigin);	// JUHOX
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 2455
;2452:
;2453:	// this counter lets us debug movement problems with a journal
;2454:	// by setting a conditional breakpoint fot the previous frame
;2455:	c_pmove++;
ADDRLP4 16
ADDRGP4 c_pmove
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2458
;2456:
;2457:	// clear results
;2458:	pm->numtouch = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 80
ADDP4
CNSTI4 0
ASGNI4
line 2459
;2459:	pm->watertype = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 236
ADDP4
CNSTI4 0
ASGNI4
line 2460
;2460:	pm->waterlevel = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 240
ADDP4
CNSTI4 0
ASGNI4
line 2462
;2461:
;2462:	if ( pm->ps->stats[STAT_HEALTH] <= 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $868
line 2463
;2463:		pm->tracemask &= ~CONTENTS_BODY;	// corpses can fly through bodies
ADDRLP4 20
ADDRGP4 pm
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 -33554433
BANDI4
ASGNI4
line 2464
;2464:	}
LABELV $868
line 2468
;2465:
;2466:#if 1	// JUHOX: gauntlet attack move
;2467:	if (
;2468:		pm->ps->persistant[PERS_TEAM] != TEAM_SPECTATOR &&
ADDRLP4 20
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 20
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 3
EQI4 $870
ADDRLP4 24
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 1
NEI4 $870
ADDRLP4 24
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
LEI4 $870
ADDRLP4 20
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $870
ADDRLP4 24
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 0
LTI4 $870
line 2473
;2469:		pm->ps->weapon == WP_GAUNTLET &&
;2470:		pm->ps->stats[STAT_HEALTH] > 0 &&
;2471:		(pm->cmd.buttons & BUTTON_ATTACK) &&
;2472:		pm->ps->stats[STAT_TARGET] >= 0
;2473:	) {
line 2474
;2474:		if (pm->cmd.upmove < 0) pm->cmd.upmove = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $872
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
CNSTI1 0
ASGNI1
LABELV $872
line 2475
;2475:		pm->cmd.buttons &= ~BUTTON_WALKING;
ADDRLP4 28
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 -17
BANDI4
ASGNI4
line 2476
;2476:		if (!(pm->ps->pm_flags & PMF_DUCKED)) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $874
line 2477
;2477:			pm->cmd.forwardmove = 127;
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
CNSTI1 127
ASGNI1
line 2478
;2478:			pm->cmd.rightmove = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 26
ADDP4
CNSTI1 0
ASGNI1
line 2479
;2479:		}
LABELV $874
line 2480
;2480:	}
LABELV $870
line 2485
;2481:#endif
;2482:
;2483:	// make sure walking button is clear if they are running, to avoid
;2484:	// proxy no-footsteps cheats
;2485:	if ( abs( pm->cmd.forwardmove ) > 64 || abs( pm->cmd.rightmove ) > 64 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 28
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 64
GTI4 $878
ADDRGP4 pm
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 32
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 64
LEI4 $876
LABELV $878
line 2486
;2486:		pm->cmd.buttons &= ~BUTTON_WALKING;
ADDRLP4 36
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 -17
BANDI4
ASGNI4
line 2487
;2487:	}
LABELV $876
line 2490
;2488:
;2489:	// set the talk balloon flag
;2490:	if ( pm->cmd.buttons & BUTTON_TALK ) {
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $879
line 2491
;2491:		pm->ps->eFlags |= EF_TALK;
ADDRLP4 36
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 4096
BORI4
ASGNI4
line 2492
;2492:	} else {
ADDRGP4 $880
JUMPV
LABELV $879
line 2493
;2493:		pm->ps->eFlags &= ~EF_TALK;
ADDRLP4 36
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 -4097
BANDI4
ASGNI4
line 2494
;2494:	}
LABELV $880
line 2501
;2495:
;2496:	// set the firing flag for continuous beam weapons
;2497:#if 0	// JUHOX: don't set EF_FIRING with shield powerup
;2498:	if ( !(pm->ps->pm_flags & PMF_RESPAWNED) && pm->ps->pm_type != PM_INTERMISSION
;2499:		&& ( pm->cmd.buttons & BUTTON_ATTACK ) && pm->ps->ammo[ pm->ps->weapon ] ) {
;2500:#else
;2501:	if ( !(pm->ps->pm_flags & PMF_RESPAWNED) && pm->ps->pm_type != PM_INTERMISSION
ADDRLP4 36
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 40
ADDRLP4 36
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
NEI4 $881
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 5
EQI4 $881
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 7
EQI4 $881
ADDRLP4 36
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $881
ADDRLP4 40
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 40
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $881
ADDRLP4 40
INDIRP4
CNSTI4 356
ADDP4
INDIRI4
CNSTI4 0
NEI4 $881
ADDRLP4 40
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ADDRLP4 36
INDIRP4
CNSTI4 24
ADDP4
INDIRU1
CVUI4 1
NEI4 $881
ADDRLP4 40
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 2
EQI4 $881
ADDRLP4 40
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 1
EQI4 $881
line 2510
;2502:#if MEETING
;2503:		&& pm->ps->pm_type != PM_MEETING
;2504:#endif
;2505:		&& ( pm->cmd.buttons & BUTTON_ATTACK ) && pm->ps->ammo[ pm->ps->weapon ]
;2506:		&& !pm->ps->powerups[PW_SHIELD]
;2507:		&& pm->ps->weapon == pm->cmd.weapon
;2508:		&& pm->ps->weaponstate != WEAPON_DROPPING
;2509:		&& pm->ps->weaponstate != WEAPON_RAISING
;2510:	) {
line 2512
;2511:#endif
;2512:		pm->ps->eFlags |= EF_FIRING;
ADDRLP4 44
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 2513
;2513:	} else {
ADDRGP4 $882
JUMPV
LABELV $881
line 2514
;2514:		pm->ps->eFlags &= ~EF_FIRING;
ADDRLP4 44
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 -257
BANDI4
ASGNI4
line 2515
;2515:	}
LABELV $882
line 2518
;2516:
;2517:	// clear the respawned flag if attack and use are cleared
;2518:	if ( pm->ps->stats[STAT_HEALTH] > 0 && 
ADDRLP4 44
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
LEI4 $883
ADDRLP4 44
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 5
BANDI4
CNSTI4 0
NEI4 $883
line 2519
;2519:		!( pm->cmd.buttons & (BUTTON_ATTACK | BUTTON_USE_HOLDABLE) ) ) {
line 2520
;2520:		pm->ps->pm_flags &= ~PMF_RESPAWNED;
ADDRLP4 48
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 -513
BANDI4
ASGNI4
line 2521
;2521:	}
LABELV $883
line 2526
;2522:
;2523:	// if talk button is down, dissallow all other input
;2524:	// this is to prevent any possible intercept proxy from
;2525:	// adding fake talk balloons
;2526:	if ( pmove->cmd.buttons & BUTTON_TALK ) {
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $885
line 2529
;2527:		// keep the talk button set tho for when the cmd.serverTime > 66 msec
;2528:		// and the same cmd is used multiple times in Pmove
;2529:		pmove->cmd.buttons = BUTTON_TALK;
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
CNSTI4 2
ASGNI4
line 2530
;2530:		pmove->cmd.forwardmove = 0;
ADDRFP4 0
INDIRP4
CNSTI4 25
ADDP4
CNSTI1 0
ASGNI1
line 2531
;2531:		pmove->cmd.rightmove = 0;
ADDRFP4 0
INDIRP4
CNSTI4 26
ADDP4
CNSTI1 0
ASGNI1
line 2532
;2532:		pmove->cmd.upmove = 0;
ADDRFP4 0
INDIRP4
CNSTI4 27
ADDP4
CNSTI1 0
ASGNI1
line 2533
;2533:	}
LABELV $885
line 2536
;2534:
;2535:	// clear all pmove local vars
;2536:	memset (&pml, 0, sizeof(pml));
ADDRGP4 pml
ARGP4
CNSTI4 0
ARGI4
CNSTI4 144
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2539
;2537:
;2538:	// determine the time
;2539:	pml.msec = pmove->cmd.serverTime - pm->ps->commandTime;
ADDRGP4 pml+40
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRGP4 pm
INDIRP4
INDIRP4
INDIRI4
SUBI4
ASGNI4
line 2540
;2540:	if ( pml.msec < 1 ) {
ADDRGP4 pml+40
INDIRI4
CNSTI4 1
GEI4 $888
line 2541
;2541:		pml.msec = 1;
ADDRGP4 pml+40
CNSTI4 1
ASGNI4
line 2542
;2542:	} else if ( pml.msec > 200 ) {
ADDRGP4 $889
JUMPV
LABELV $888
ADDRGP4 pml+40
INDIRI4
CNSTI4 200
LEI4 $892
line 2543
;2543:		pml.msec = 200;
ADDRGP4 pml+40
CNSTI4 200
ASGNI4
line 2544
;2544:	}
LABELV $892
LABELV $889
line 2545
;2545:	pm->ps->commandTime = pmove->cmd.serverTime;
ADDRGP4 pm
INDIRP4
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 2548
;2546:
;2547:	// save old org in case we get stuck
;2548:	VectorCopy (pm->ps->origin, pml.previous_origin);
ADDRGP4 pml+112
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 2551
;2549:
;2550:	// save old velocity for crashlanding
;2551:	VectorCopy (pm->ps->velocity, pml.previous_velocity);
ADDRGP4 pml+124
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
INDIRB
ASGNB 12
line 2553
;2552:
;2553:	pml.frametime = pml.msec * 0.001;
ADDRGP4 pml+36
ADDRGP4 pml+40
INDIRI4
CVIF4 4
CNSTF4 981668463
MULF4
ASGNF4
line 2556
;2554:
;2555:	// update the viewangles
;2556:	PM_UpdateViewAngles( pm->ps, &pm->cmd );
ADDRLP4 48
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
INDIRP4
ARGP4
ADDRLP4 48
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRGP4 PM_UpdateViewAngles
CALLV
pop
line 2558
;2557:
;2558:	AngleVectors (pm->ps->viewangles, pml.forward, pml.right, pml.up);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRGP4 pml
ARGP4
ADDRGP4 pml+12
ARGP4
ADDRGP4 pml+24
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 2560
;2559:
;2560:	if ( pm->cmd.upmove < 10 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CNSTI4 10
GEI4 $902
line 2562
;2561:		// not holding jump
;2562:		pm->ps->pm_flags &= ~PMF_JUMP_HELD;
ADDRLP4 52
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
CNSTI4 -3
BANDI4
ASGNI4
line 2563
;2563:	}
LABELV $902
line 2566
;2564:
;2565:	// decide if backpedaling animations should be used
;2566:	if ( pm->cmd.forwardmove < 0 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $904
line 2567
;2567:		pm->ps->pm_flags |= PMF_BACKWARDS_RUN;
ADDRLP4 52
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 2568
;2568:	} else if ( pm->cmd.forwardmove > 0 || ( pm->cmd.forwardmove == 0 && pm->cmd.rightmove ) ) {
ADDRGP4 $905
JUMPV
LABELV $904
ADDRLP4 52
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GTI4 $908
ADDRLP4 52
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $906
ADDRLP4 52
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $906
LABELV $908
line 2569
;2569:		pm->ps->pm_flags &= ~PMF_BACKWARDS_RUN;
ADDRLP4 56
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
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
line 2570
;2570:	}
LABELV $906
LABELV $905
line 2572
;2571:
;2572:	if ( pm->ps->pm_type >= PM_DEAD ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
LTI4 $909
line 2573
;2573:		pm->cmd.forwardmove = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
CNSTI1 0
ASGNI1
line 2574
;2574:		pm->cmd.rightmove = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 26
ADDP4
CNSTI1 0
ASGNI1
line 2575
;2575:		pm->cmd.upmove = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
CNSTI1 0
ASGNI1
line 2576
;2576:	}
LABELV $909
line 2578
;2577:
;2578:	if ( pm->ps->pm_type == PM_SPECTATOR ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $911
line 2579
;2579:		PM_CheckDuck ();
ADDRGP4 PM_CheckDuck
CALLV
pop
line 2582
;2580:		// JUHOX: is this a dead player spectating?
;2581:#if 1
;2582:		if (pm->ps->stats[STAT_HEALTH] <= 0) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $913
line 2583
;2583:			pm->ps->stats[STAT_STRENGTH] += REFRESH_ONE_SECOND * pml.frametime;
ADDRLP4 56
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 212
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 pml+36
INDIRF4
CNSTF4 1120403456
MULF4
ADDF4
CVFI4 4
ASGNI4
line 2584
;2584:			if (pm->ps->stats[STAT_STRENGTH] > MAX_STRENGTH_VALUE) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1183621120
LEF4 $916
line 2585
;2585:				pm->ps->stats[STAT_STRENGTH] = MAX_STRENGTH_VALUE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 212
ADDP4
CNSTI4 18000
ASGNI4
line 2586
;2586:			}
LABELV $916
line 2587
;2587:		}
LABELV $913
line 2589
;2588:#endif
;2589:		PM_FlyMove ();
ADDRGP4 PM_FlyMove
CALLV
pop
line 2590
;2590:		PM_DropTimers ();
ADDRGP4 PM_DropTimers
CALLV
pop
line 2591
;2591:		return;
ADDRGP4 $867
JUMPV
LABELV $911
line 2594
;2592:	}
;2593:
;2594:	if ( pm->ps->pm_type == PM_NOCLIP ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 1
NEI4 $918
line 2595
;2595:		PM_NoclipMove ();
ADDRGP4 PM_NoclipMove
CALLV
pop
line 2596
;2596:		PM_DropTimers ();
ADDRGP4 PM_DropTimers
CALLV
pop
line 2597
;2597:		return;
ADDRGP4 $867
JUMPV
LABELV $918
line 2600
;2598:	}
;2599:
;2600:	if (pm->ps->pm_type == PM_FREEZE) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 4
NEI4 $920
line 2601
;2601:		return;		// no movement at all
ADDRGP4 $867
JUMPV
LABELV $920
line 2604
;2602:	}
;2603:
;2604:	if ( pm->ps->pm_type == PM_INTERMISSION || pm->ps->pm_type == PM_SPINTERMISSION) {
ADDRLP4 56
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 5
EQI4 $924
ADDRLP4 56
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 6
NEI4 $922
LABELV $924
line 2605
;2605:		return;		// no movement at all
ADDRGP4 $867
JUMPV
LABELV $922
line 2609
;2606:	}
;2607:
;2608:#if MEETING	// JUHOX: no movement during meeting
;2609:	if (pm->ps->pm_type == PM_MEETING) return;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 7
NEI4 $925
ADDRGP4 $867
JUMPV
LABELV $925
line 2613
;2610:#endif
;2611:
;2612:	// set watertype, and waterlevel
;2613:	PM_SetWaterLevel();
ADDRGP4 PM_SetWaterLevel
CALLV
pop
line 2614
;2614:	pml.previous_waterlevel = pmove->waterlevel;
ADDRGP4 pml+136
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
ASGNI4
line 2615
;2615:	pml.previous_watertype = pmove->watertype;	// JUHOX
ADDRGP4 pml+140
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
ASGNI4
line 2618
;2616:
;2617:	// set mins, maxs, and viewheight
;2618:	PM_CheckDuck ();
ADDRGP4 PM_CheckDuck
CALLV
pop
line 2621
;2619:
;2620:	// set groundentity
;2621:	PM_GroundTrace();
ADDRGP4 PM_GroundTrace
CALLV
pop
line 2623
;2622:
;2623:	if ( pm->ps->pm_type == PM_DEAD ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $929
line 2624
;2624:		PM_DeadMove ();
ADDRGP4 PM_DeadMove
CALLV
pop
line 2625
;2625:	}
LABELV $929
line 2627
;2626:
;2627:	PM_DropTimers();
ADDRGP4 PM_DropTimers
CALLV
pop
line 2629
;2628:
;2629:	CalcWeariness(); // JUHOX: weariness & refreshing
ADDRGP4 CalcWeariness
CALLV
pop
line 2636
;2630:
;2631:#ifdef MISSIONPACK
;2632:	if ( pm->ps->powerups[PW_INVULNERABILITY] ) {
;2633:		PM_InvulnerabilityMove();
;2634:	} else
;2635:#endif
;2636:	if ( pm->ps->powerups[PW_FLIGHT] ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
CNSTI4 0
EQI4 $931
line 2638
;2637:		// flight powerup doesn't allow jump and has different friction
;2638:		PM_FlyMove();
ADDRGP4 PM_FlyMove
CALLV
pop
line 2639
;2639:	} else if (pm->ps->pm_flags & PMF_GRAPPLE_PULL) {
ADDRGP4 $932
JUMPV
LABELV $931
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $933
line 2640
;2640:		PM_GrappleMove();
ADDRGP4 PM_GrappleMove
CALLV
pop
line 2646
;2641:		// JUHOX: with a fixed rope we may walk
;2642:#if !GRAPPLE_ROPE
;2643:		// We can wiggle a bit
;2644:		PM_AirMove();
;2645:#else
;2646:		if (pm->ps->stats[STAT_GRAPPLE_STATE] == GST_fixed && pml.walking) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 2
NEI4 $935
ADDRGP4 pml+44
INDIRI4
CNSTI4 0
EQI4 $935
line 2647
;2647:			PM_WalkMove();
ADDRGP4 PM_WalkMove
CALLV
pop
line 2648
;2648:		}
ADDRGP4 $934
JUMPV
LABELV $935
line 2649
;2649:		else {
line 2650
;2650:			PM_AirMove();
ADDRGP4 PM_AirMove
CALLV
pop
line 2651
;2651:		}
line 2653
;2652:#endif
;2653:	} else if (pm->ps->pm_flags & PMF_TIME_WATERJUMP) {
ADDRGP4 $934
JUMPV
LABELV $933
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $938
line 2654
;2654:		PM_WaterJumpMove();
ADDRGP4 PM_WaterJumpMove
CALLV
pop
line 2655
;2655:	} else if ( pm->waterlevel > 1 ) {
ADDRGP4 $939
JUMPV
LABELV $938
ADDRGP4 pm
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CNSTI4 1
LEI4 $940
line 2657
;2656:		// swimming
;2657:		PM_WaterMove();
ADDRGP4 PM_WaterMove
CALLV
pop
line 2658
;2658:	} else if ( pml.walking ) {
ADDRGP4 $941
JUMPV
LABELV $940
ADDRGP4 pml+44
INDIRI4
CNSTI4 0
EQI4 $942
line 2660
;2659:		// walking on ground
;2660:		PM_WalkMove();
ADDRGP4 PM_WalkMove
CALLV
pop
line 2661
;2661:	} else {
ADDRGP4 $943
JUMPV
LABELV $942
line 2663
;2662:		// airborne
;2663:		PM_AirMove();
ADDRGP4 PM_AirMove
CALLV
pop
line 2664
;2664:	}
LABELV $943
LABELV $941
LABELV $939
LABELV $934
LABELV $932
line 2666
;2665:
;2666:	PM_Animate();
ADDRGP4 PM_Animate
CALLV
pop
line 2673
;2667:
;2668:	// set groundentity, watertype, and waterlevel
;2669:#if 0	// JUHOX: only re-calculate if moved
;2670:	PM_GroundTrace();
;2671:	PM_SetWaterLevel();
;2672:#else
;2673:	if (DistanceSquared(pm->ps->origin, oldOrigin) > 0) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 60
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 60
INDIRF4
CNSTF4 0
LEF4 $945
line 2674
;2674:		PM_GroundTrace();
ADDRGP4 PM_GroundTrace
CALLV
pop
line 2675
;2675:		PM_SetWaterLevel();
ADDRGP4 PM_SetWaterLevel
CALLV
pop
line 2676
;2676:	}
LABELV $945
line 2680
;2677:#endif
;2678:
;2679:	// weapons
;2680:	PM_Weapon();
ADDRGP4 PM_Weapon
CALLV
pop
line 2684
;2681:
;2682:#if 1	// JUHOX: add weapon kick
;2683:	if (
;2684:		pm->ps->clientNum < MAX_CLIENTS &&
ADDRLP4 64
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
CNSTI4 64
GEI4 $947
ADDRLP4 64
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
CNSTI4 0
EQI4 $947
line 2686
;2685:		pm->ps->stats[STAT_WEAPON_KICK] != 0
;2686:	) {
line 2691
;2687:		float kick;
;2688:		float move;
;2689:		localseed_t seed;
;2690:
;2691:		kick = (float)(pm->ps->stats[STAT_WEAPON_KICK]) / (float)WEAPON_KICK_FACTOR;
ADDRLP4 84
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1017370378
MULF4
ASGNF4
line 2692
;2692:		move = AngleKick(&kick);
ADDRLP4 84
ARGP4
ADDRLP4 92
ADDRGP4 AngleKick
CALLF4
ASGNF4
ADDRLP4 88
ADDRLP4 92
INDIRF4
ASGNF4
line 2693
;2693:		pm->ps->stats[STAT_WEAPON_KICK] = (int) (kick * WEAPON_KICK_FACTOR);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 200
ADDP4
ADDRLP4 84
INDIRF4
CNSTF4 1112014848
MULF4
CVFI4 4
ASGNI4
line 2695
;2694:
;2695:		seed.seed0 = pm->ps->clientNum;
ADDRLP4 68
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
CVIU4 4
ASGNU4
line 2696
;2696:		seed.seed1 = pm->ps->ammo[pm->ps->weapon];
ADDRLP4 96
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 68+4
ADDRLP4 96
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 96
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
CVIU4 4
ASGNU4
line 2697
;2697:		seed.seed2 = pm->ps->generic1;
ADDRLP4 68+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
CVIU4 4
ASGNU4
line 2698
;2698:		seed.seed3 = pm->ps->persistant[PERS_SPAWN_COUNT];
ADDRLP4 68+12
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 264
ADDP4
INDIRI4
CVIU4 4
ASGNU4
line 2699
;2699:		pm->ps->delta_angles[YAW] += ANGLE2SHORT(move * local_crandom(&seed));
ADDRLP4 68
ARGP4
ADDRLP4 100
ADDRGP4 local_crandom
CALLF4
ASGNF4
ADDRLP4 104
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 60
ADDP4
ASGNP4
ADDRLP4 104
INDIRP4
ADDRLP4 104
INDIRP4
INDIRI4
ADDRLP4 88
INDIRF4
ADDRLP4 100
INDIRF4
MULF4
CNSTF4 1127615329
MULF4
CVFI4 4
CNSTI4 65535
BANDI4
ADDI4
ASGNI4
line 2700
;2700:		pm->ps->delta_angles[PITCH] += ANGLE2SHORT(move * local_crandom(&seed));
ADDRLP4 68
ARGP4
ADDRLP4 108
ADDRGP4 local_crandom
CALLF4
ASGNF4
ADDRLP4 112
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 56
ADDP4
ASGNP4
ADDRLP4 112
INDIRP4
ADDRLP4 112
INDIRP4
INDIRI4
ADDRLP4 88
INDIRF4
ADDRLP4 108
INDIRF4
MULF4
CNSTF4 1127615329
MULF4
CVFI4 4
CNSTI4 65535
BANDI4
ADDI4
ASGNI4
line 2701
;2701:	}
LABELV $947
line 2705
;2702:#endif
;2703:
;2704:	// torso animation
;2705:	PM_TorsoAnimation();
ADDRGP4 PM_TorsoAnimation
CALLV
pop
line 2708
;2706:
;2707:	// footstep events / legs animations
;2708:	PM_Footsteps();
ADDRGP4 PM_Footsteps
CALLV
pop
line 2711
;2709:
;2710:	// entering / leaving water splashes
;2711:	PM_WaterEvents();
ADDRGP4 PM_WaterEvents
CALLV
pop
line 2716
;2712:
;2713:#if 1	// JUHOX: generate pant events
;2714:	if (
;2715:#if MONSTER_MODE
;2716:		pm->ps->clientNum < MAX_CLIENTS &&	// speed up
ADDRLP4 68
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 72
ADDRLP4 68
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
CNSTI4 64
GEI4 $952
ADDRLP4 72
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 3
EQI4 $952
ADDRLP4 72
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
LEI4 $952
ADDRLP4 68
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CNSTI4 3
GEI4 $952
ADDRGP4 pml+136
INDIRI4
CNSTI4 3
GEI4 $952
ADDRLP4 68
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
NEI4 $952
line 2723
;2717:#endif
;2718:		pm->ps->persistant[PERS_TEAM] != TEAM_SPECTATOR &&
;2719:		pm->ps->stats[STAT_HEALTH] > 0 &&
;2720:		pm->waterlevel < 3 &&
;2721:		pml.previous_waterlevel < 3 &&
;2722:		!(pm->cmd.buttons & BUTTON_HOLD_BREATH)
;2723:	) {
line 2724
;2724:		const int pantCycleTime = 1450;	// in msec
ADDRLP4 76
CNSTI4 1450
ASGNI4
line 2729
;2725:		int pantPhase;
;2726:		qboolean pantCycleComplete;
;2727:		qboolean pantCycle2Complete;
;2728:
;2729:		pantPhase = pm->ps->stats[STAT_PANT_PHASE];
ADDRLP4 80
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
ASGNI4
line 2730
;2730:		if (pantPhase < 0) {
ADDRLP4 80
INDIRI4
CNSTI4 0
GEI4 $955
line 2731
;2731:			pantCycleComplete = qtrue;
ADDRLP4 84
CNSTI4 1
ASGNI4
line 2732
;2732:			pantCycle2Complete = qtrue;
ADDRLP4 88
CNSTI4 1
ASGNI4
line 2733
;2733:			pm->ps->stats[STAT_PANT_PHASE] = pantCycleTime - (pm->ps->commandTime % pantCycleTime);
ADDRLP4 92
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 96
ADDRLP4 76
INDIRI4
ASGNI4
ADDRLP4 92
INDIRP4
CNSTI4 216
ADDP4
ADDRLP4 96
INDIRI4
ADDRLP4 92
INDIRP4
INDIRI4
ADDRLP4 96
INDIRI4
MODI4
SUBI4
ASGNI4
line 2734
;2734:		}
ADDRGP4 $956
JUMPV
LABELV $955
line 2735
;2735:		else {
line 2738
;2736:			int commandTime;
;2737:
;2738:			commandTime = pm->ps->commandTime + pantPhase;
ADDRLP4 92
ADDRGP4 pm
INDIRP4
INDIRP4
INDIRI4
ADDRLP4 80
INDIRI4
ADDI4
ASGNI4
line 2739
;2739:			oldCommandTime += pantPhase;
ADDRLP4 12
ADDRLP4 12
INDIRI4
ADDRLP4 80
INDIRI4
ADDI4
ASGNI4
line 2740
;2740:			pantCycleComplete = (commandTime / pantCycleTime != oldCommandTime / pantCycleTime);
ADDRLP4 100
ADDRLP4 76
INDIRI4
ASGNI4
ADDRLP4 92
INDIRI4
ADDRLP4 100
INDIRI4
DIVI4
ADDRLP4 12
INDIRI4
ADDRLP4 100
INDIRI4
DIVI4
EQI4 $958
ADDRLP4 96
CNSTI4 1
ASGNI4
ADDRGP4 $959
JUMPV
LABELV $958
ADDRLP4 96
CNSTI4 0
ASGNI4
LABELV $959
ADDRLP4 84
ADDRLP4 96
INDIRI4
ASGNI4
line 2741
;2741:			pantCycle2Complete = (commandTime / (2*pantCycleTime) != oldCommandTime / (2*pantCycleTime));
ADDRLP4 108
ADDRLP4 76
INDIRI4
ASGNI4
ADDRLP4 92
INDIRI4
ADDRLP4 108
INDIRI4
CNSTI4 1
LSHI4
DIVI4
ADDRLP4 12
INDIRI4
ADDRLP4 108
INDIRI4
CNSTI4 1
LSHI4
DIVI4
EQI4 $961
ADDRLP4 104
CNSTI4 1
ASGNI4
ADDRGP4 $962
JUMPV
LABELV $961
ADDRLP4 104
CNSTI4 0
ASGNI4
LABELV $962
ADDRLP4 88
ADDRLP4 104
INDIRI4
ASGNI4
line 2742
;2742:		}
LABELV $956
line 2745
;2743:
;2744:		if (
;2745:			(pm->ps->stats[STAT_STRENGTH] < LOW_STRENGTH_VALUE && pantCycleComplete) ||
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1161527296
GEF4 $966
ADDRLP4 84
INDIRI4
CNSTI4 0
NEI4 $965
LABELV $966
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1169915904
GEF4 $963
ADDRLP4 88
INDIRI4
CNSTI4 0
EQI4 $963
LABELV $965
line 2747
;2746:			(pm->ps->stats[STAT_STRENGTH] < 2*LOW_STRENGTH_VALUE && pantCycle2Complete)
;2747:		) {
line 2748
;2748:			PM_AddEvent(EV_PANT);
CNSTI4 86
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 2749
;2749:		}
LABELV $963
line 2750
;2750:	}
LABELV $952
line 2754
;2751:#endif
;2752:
;2753:	// snap some parts of playerstate to save network bandwidth
;2754:	trap_SnapVector( pm->ps->velocity );
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 trap_SnapVector
CALLV
pop
line 2755
;2755:}
LABELV $867
endproc PmoveSingle 116 16
export Pmove
proc Pmove 16 4
line 2765
;2756:
;2757:
;2758:/*
;2759:================
;2760:Pmove
;2761:
;2762:Can be called by either the server or the client
;2763:================
;2764:*/
;2765:void Pmove (pmove_t *pmove) {
line 2768
;2766:	int			finalTime;
;2767:
;2768:	finalTime = pmove->cmd.serverTime;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 2770
;2769:
;2770:	if ( finalTime < pmove->ps->commandTime ) {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
INDIRP4
INDIRI4
GEI4 $968
line 2771
;2771:		return;	// should not happen
ADDRGP4 $967
JUMPV
LABELV $968
line 2774
;2772:	}
;2773:
;2774:	if ( finalTime > pmove->ps->commandTime + 1000 ) {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
INDIRP4
INDIRI4
CNSTI4 1000
ADDI4
LEI4 $970
line 2775
;2775:		pmove->ps->commandTime = finalTime - 1000;
ADDRFP4 0
INDIRP4
INDIRP4
ADDRLP4 0
INDIRI4
CNSTI4 1000
SUBI4
ASGNI4
line 2776
;2776:	}
LABELV $970
line 2778
;2777:
;2778:	pmove->ps->pmove_framecount = (pmove->ps->pmove_framecount+1) & ((1<<PS_PMOVEFRAMECOUNTBITS)-1);
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 456
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 456
ADDP4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 63
BANDI4
ASGNI4
ADDRGP4 $973
JUMPV
LABELV $972
line 2782
;2779:
;2780:	// chop the move up if it is too long, to prevent framerate
;2781:	// dependent behavior
;2782:	while ( pmove->ps->commandTime != finalTime ) {
line 2785
;2783:		int		msec;
;2784:
;2785:		msec = finalTime - pmove->ps->commandTime;
ADDRLP4 8
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
INDIRP4
INDIRI4
SUBI4
ASGNI4
line 2787
;2786:
;2787:		if ( pmove->pmove_fixed ) {
ADDRFP4 0
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
CNSTI4 0
EQI4 $975
line 2788
;2788:			if ( msec > pmove->pmove_msec ) {
ADDRLP4 8
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 252
ADDP4
INDIRI4
LEI4 $976
line 2789
;2789:				msec = pmove->pmove_msec;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 252
ADDP4
INDIRI4
ASGNI4
line 2790
;2790:			}
line 2791
;2791:		}
ADDRGP4 $976
JUMPV
LABELV $975
line 2792
;2792:		else {
line 2793
;2793:			if ( msec > 66 ) {
ADDRLP4 8
INDIRI4
CNSTI4 66
LEI4 $979
line 2794
;2794:				msec = 66;
ADDRLP4 8
CNSTI4 66
ASGNI4
line 2795
;2795:			}
LABELV $979
line 2796
;2796:		}
LABELV $976
line 2797
;2797:		pmove->cmd.serverTime = pmove->ps->commandTime + msec;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 12
INDIRP4
INDIRP4
INDIRI4
ADDRLP4 8
INDIRI4
ADDI4
ASGNI4
line 2798
;2798:		PmoveSingle( pmove );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 PmoveSingle
CALLV
pop
line 2800
;2799:
;2800:		if ( pmove->ps->pm_flags & PMF_JUMP_HELD ) {
ADDRFP4 0
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $981
line 2801
;2801:			pmove->cmd.upmove = 20;
ADDRFP4 0
INDIRP4
CNSTI4 27
ADDP4
CNSTI1 20
ASGNI1
line 2802
;2802:		}
LABELV $981
line 2803
;2803:	}
LABELV $973
line 2782
ADDRFP4 0
INDIRP4
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $972
line 2807
;2804:
;2805:	//PM_CheckStuck();
;2806:
;2807:}
LABELV $967
endproc Pmove 16 4
import trap_SnapVector
import PM_StepSlideMove
import PM_SlideMove
bss
export pml
align 4
LABELV pml
skip 144
export pm
align 4
LABELV pm
skip 4
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
LABELV $551
byte 1 37
byte 1 105
byte 1 58
byte 1 76
byte 1 97
byte 1 110
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $540
byte 1 37
byte 1 105
byte 1 58
byte 1 115
byte 1 116
byte 1 101
byte 1 101
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $529
byte 1 37
byte 1 105
byte 1 58
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 111
byte 1 102
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $491
byte 1 37
byte 1 105
byte 1 58
byte 1 108
byte 1 105
byte 1 102
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $464
byte 1 37
byte 1 105
byte 1 58
byte 1 97
byte 1 108
byte 1 108
byte 1 115
byte 1 111
byte 1 108
byte 1 105
byte 1 100
byte 1 10
byte 1 0
