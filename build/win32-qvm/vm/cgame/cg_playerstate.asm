export CG_CheckAmmo
code
proc CG_CheckAmmo 0 0
file "..\..\..\..\code\cgame\cg_playerstate.c"
line 17
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_playerstate.c -- this file acts on changes in a new playerState_t
;4:// With normal play, this will be done after local prediction, but when
;5:// following another player or playing back a demo, it will be checked
;6:// when the snapshot transitions like all the other entities
;7:
;8:#include "cg_local.h"
;9:
;10:/*
;11:==============
;12:CG_CheckAmmo
;13:
;14:If the ammo has gone low enough to generate the warning, play a sound
;15:==============
;16:*/
;17:void CG_CheckAmmo( void ) {
line 65
;18:	// JUHOX: ammo checks done elsewhere
;19:#if 0
;20:	int		i;
;21:	int		total;
;22:	int		previous;
;23:	int		weapons;
;24:
;25:	// see about how many seconds of ammo we have remaining
;26:	weapons = cg.snap->ps.stats[ STAT_WEAPONS ];
;27:	total = 0;
;28:	for ( i = WP_MACHINEGUN ; i < WP_NUM_WEAPONS ; i++ ) {
;29:		if ( ! ( weapons & ( 1 << i ) ) ) {
;30:			continue;
;31:		}
;32:		switch ( i ) {
;33:		case WP_ROCKET_LAUNCHER:
;34:		case WP_GRENADE_LAUNCHER:
;35:		case WP_RAILGUN:
;36:		case WP_SHOTGUN:
;37:#ifdef MISSIONPACK
;38:		case WP_PROX_LAUNCHER:
;39:#endif
;40:			total += cg.snap->ps.ammo[i] * 1000;
;41:			break;
;42:		default:
;43:			total += cg.snap->ps.ammo[i] * 200;
;44:			break;
;45:		}
;46:		if ( total >= 5000 ) {
;47:			cg.lowAmmoWarning = 0;
;48:			return;
;49:		}
;50:	}
;51:
;52:	previous = cg.lowAmmoWarning;
;53:
;54:	if ( total == 0 ) {
;55:		cg.lowAmmoWarning = 2;
;56:	} else {
;57:		cg.lowAmmoWarning = 1;
;58:	}
;59:
;60:	// play a sound on transitions
;61:	if ( cg.lowAmmoWarning != previous ) {
;62:		trap_S_StartLocalSound( cgs.media.noAmmoSound, CHAN_LOCAL_SOUND );
;63:	}
;64:#endif
;65:}
LABELV $124
endproc CG_CheckAmmo 0 0
export CG_DamageFeedback
proc CG_DamageFeedback 64 16
line 72
;66:
;67:/*
;68:==============
;69:CG_DamageFeedback
;70:==============
;71:*/
;72:void CG_DamageFeedback( int yawByte, int pitchByte, int damage ) {
line 83
;73:	float		left, front, up;
;74:	float		kick;
;75:	int			health;
;76:	float		scale;
;77:	vec3_t		dir;
;78:	vec3_t		angles;
;79:	float		dist;
;80:	float		yaw, pitch;
;81:
;82:	// show the attacking player's head and name in corner
;83:	cg.attackerTime = cg.time;
ADDRGP4 cg+127728
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 86
;84:
;85:	// the lower on health you are, the greater the view kick will be
;86:	health = cg.snap->ps.stats[STAT_HEALTH];
ADDRLP4 20
ADDRGP4 cg+36
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ASGNI4
line 87
;87:	if ( health < 40 ) {
ADDRLP4 20
INDIRI4
CNSTI4 40
GEI4 $129
line 88
;88:		scale = 1;
ADDRLP4 28
CNSTF4 1065353216
ASGNF4
line 89
;89:	} else {
ADDRGP4 $130
JUMPV
LABELV $129
line 90
;90:		scale = 40.0 / health;
ADDRLP4 28
CNSTF4 1109393408
ADDRLP4 20
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 91
;91:	}
LABELV $130
line 92
;92:	kick = damage * scale;
ADDRLP4 12
ADDRFP4 8
INDIRI4
CVIF4 4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 94
;93:
;94:	if (kick < 5)
ADDRLP4 12
INDIRF4
CNSTF4 1084227584
GEF4 $131
line 95
;95:		kick = 5;
ADDRLP4 12
CNSTF4 1084227584
ASGNF4
LABELV $131
line 96
;96:	if (kick > 10)
ADDRLP4 12
INDIRF4
CNSTF4 1092616192
LEF4 $133
line 97
;97:		kick = 10;
ADDRLP4 12
CNSTF4 1092616192
ASGNF4
LABELV $133
line 100
;98:
;99:	// if yaw and pitch are both 255, make the damage always centered (falling, etc)
;100:	if ( yawByte == 255 && pitchByte == 255 ) {
ADDRFP4 0
INDIRI4
CNSTI4 255
NEI4 $135
ADDRFP4 4
INDIRI4
CNSTI4 255
NEI4 $135
line 101
;101:		cg.damageX = 0;
ADDRGP4 cg+128004
CNSTF4 0
ASGNF4
line 102
;102:		cg.damageY = 0;
ADDRGP4 cg+128008
CNSTF4 0
ASGNF4
line 103
;103:		cg.v_dmg_roll = 0;
ADDRGP4 cg+128052
CNSTF4 0
ASGNF4
line 104
;104:		cg.v_dmg_pitch = -kick;
ADDRGP4 cg+128048
ADDRLP4 12
INDIRF4
NEGF4
ASGNF4
line 105
;105:	} else {
ADDRGP4 $136
JUMPV
LABELV $135
line 107
;106:		// positional
;107:		pitch = pitchByte / 255.0 * 360;
ADDRLP4 56
ADDRFP4 4
INDIRI4
CVIF4 4
CNSTF4 1068807349
MULF4
ASGNF4
line 108
;108:		yaw = yawByte / 255.0 * 360;
ADDRLP4 52
ADDRFP4 0
INDIRI4
CVIF4 4
CNSTF4 1068807349
MULF4
ASGNF4
line 110
;109:
;110:		angles[PITCH] = pitch;
ADDRLP4 32
ADDRLP4 56
INDIRF4
ASGNF4
line 111
;111:		angles[YAW] = yaw;
ADDRLP4 32+4
ADDRLP4 52
INDIRF4
ASGNF4
line 112
;112:		angles[ROLL] = 0;
ADDRLP4 32+8
CNSTF4 0
ASGNF4
line 114
;113:
;114:		AngleVectors( angles, dir, NULL, NULL );
ADDRLP4 32
ARGP4
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 115
;115:		VectorSubtract( vec3_origin, dir, dir );
ADDRLP4 0
ADDRGP4 vec3_origin
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRGP4 vec3_origin+4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRGP4 vec3_origin+8
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 117
;116:
;117:		front = DotProduct (dir, cg.refdef.viewaxis[0] );
ADDRLP4 16
ADDRLP4 0
INDIRF4
ADDRGP4 cg+109260+36
INDIRF4
MULF4
ADDRLP4 0+4
INDIRF4
ADDRGP4 cg+109260+36+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+8
INDIRF4
ADDRGP4 cg+109260+36+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 118
;118:		left = DotProduct (dir, cg.refdef.viewaxis[1] );
ADDRLP4 24
ADDRLP4 0
INDIRF4
ADDRGP4 cg+109260+36+12
INDIRF4
MULF4
ADDRLP4 0+4
INDIRF4
ADDRGP4 cg+109260+36+12+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+8
INDIRF4
ADDRGP4 cg+109260+36+12+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 119
;119:		up = DotProduct (dir, cg.refdef.viewaxis[2] );
ADDRLP4 48
ADDRLP4 0
INDIRF4
ADDRGP4 cg+109260+36+24
INDIRF4
MULF4
ADDRLP4 0+4
INDIRF4
ADDRGP4 cg+109260+36+24+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+8
INDIRF4
ADDRGP4 cg+109260+36+24+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 121
;120:
;121:		dir[0] = front;
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 122
;122:		dir[1] = left;
ADDRLP4 0+4
ADDRLP4 24
INDIRF4
ASGNF4
line 123
;123:		dir[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 124
;124:		dist = VectorLength( dir );
ADDRLP4 0
ARGP4
ADDRLP4 60
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 44
ADDRLP4 60
INDIRF4
ASGNF4
line 125
;125:		if ( dist < 0.1 ) {
ADDRLP4 44
INDIRF4
CNSTF4 1036831949
GEF4 $187
line 126
;126:			dist = 0.1f;
ADDRLP4 44
CNSTF4 1036831949
ASGNF4
line 127
;127:		}
LABELV $187
line 129
;128:
;129:		cg.v_dmg_roll = kick * left;
ADDRGP4 cg+128052
ADDRLP4 12
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ASGNF4
line 131
;130:		
;131:		cg.v_dmg_pitch = -kick * front;
ADDRGP4 cg+128048
ADDRLP4 12
INDIRF4
NEGF4
ADDRLP4 16
INDIRF4
MULF4
ASGNF4
line 133
;132:
;133:		if ( front <= 0.1 ) {
ADDRLP4 16
INDIRF4
CNSTF4 1036831949
GTF4 $191
line 134
;134:			front = 0.1f;
ADDRLP4 16
CNSTF4 1036831949
ASGNF4
line 135
;135:		}
LABELV $191
line 136
;136:		cg.damageX = -left / front;
ADDRGP4 cg+128004
ADDRLP4 24
INDIRF4
NEGF4
ADDRLP4 16
INDIRF4
DIVF4
ASGNF4
line 137
;137:		cg.damageY = up / dist;
ADDRGP4 cg+128008
ADDRLP4 48
INDIRF4
ADDRLP4 44
INDIRF4
DIVF4
ASGNF4
line 138
;138:	}
LABELV $136
line 141
;139:
;140:	// clamp the position
;141:	if ( cg.damageX > 1.0 ) {
ADDRGP4 cg+128004
INDIRF4
CNSTF4 1065353216
LEF4 $195
line 142
;142:		cg.damageX = 1.0;
ADDRGP4 cg+128004
CNSTF4 1065353216
ASGNF4
line 143
;143:	}
LABELV $195
line 144
;144:	if ( cg.damageX < - 1.0 ) {
ADDRGP4 cg+128004
INDIRF4
CNSTF4 3212836864
GEF4 $199
line 145
;145:		cg.damageX = -1.0;
ADDRGP4 cg+128004
CNSTF4 3212836864
ASGNF4
line 146
;146:	}
LABELV $199
line 148
;147:
;148:	if ( cg.damageY > 1.0 ) {
ADDRGP4 cg+128008
INDIRF4
CNSTF4 1065353216
LEF4 $203
line 149
;149:		cg.damageY = 1.0;
ADDRGP4 cg+128008
CNSTF4 1065353216
ASGNF4
line 150
;150:	}
LABELV $203
line 151
;151:	if ( cg.damageY < - 1.0 ) {
ADDRGP4 cg+128008
INDIRF4
CNSTF4 3212836864
GEF4 $207
line 152
;152:		cg.damageY = -1.0;
ADDRGP4 cg+128008
CNSTF4 3212836864
ASGNF4
line 153
;153:	}
LABELV $207
line 156
;154:
;155:	// don't let the screen flashes vary as much
;156:	if ( kick > 10 ) {
ADDRLP4 12
INDIRF4
CNSTF4 1092616192
LEF4 $211
line 157
;157:		kick = 10;
ADDRLP4 12
CNSTF4 1092616192
ASGNF4
line 158
;158:	}
LABELV $211
line 159
;159:	cg.damageValue = kick;
ADDRGP4 cg+128012
ADDRLP4 12
INDIRF4
ASGNF4
line 160
;160:	cg.v_dmg_time = cg.time + DAMAGE_TIME;
ADDRGP4 cg+128044
ADDRGP4 cg+107656
INDIRI4
CNSTI4 500
ADDI4
CVIF4 4
ASGNF4
line 161
;161:	cg.damageTime = cg.snap->serverTime;
ADDRGP4 cg+128000
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 162
;162:}
LABELV $125
endproc CG_DamageFeedback 64 16
export CG_Respawn
proc CG_Respawn 0 0
line 174
;163:
;164:
;165:
;166:
;167:/*
;168:================
;169:CG_Respawn
;170:
;171:A respawn happened this snapshot
;172:================
;173:*/
;174:void CG_Respawn( void ) {
line 176
;175:	// no error decay on player movement
;176:	cg.thisFrameTeleport = qtrue;
ADDRGP4 cg+107644
CNSTI4 1
ASGNI4
line 179
;177:
;178:	// display weapons available
;179:	cg.weaponSelectTime = cg.time;
ADDRGP4 cg+127988
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 182
;180:
;181:	// select the weapon the server says we are using
;182:	cg.weaponSelect = cg.snap->ps.weapon;
ADDRGP4 cg+109148
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ASGNI4
line 183
;183:}
LABELV $218
endproc CG_Respawn 0 0
export CG_CheckPlayerstateEvents
proc CG_CheckPlayerstateEvents 32 8
line 192
;184:
;185:extern char *eventnames[];
;186:
;187:/*
;188:==============
;189:CG_CheckPlayerstateEvents
;190:==============
;191:*/
;192:void CG_CheckPlayerstateEvents( playerState_t *ps, playerState_t *ops ) {
line 197
;193:	int			i;
;194:	int			event;
;195:	centity_t	*cent;
;196:
;197:	if ( ps->externalEvent && ps->externalEvent != ops->externalEvent ) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 128
ADDP4
INDIRI4
CNSTI4 0
EQI4 $225
ADDRLP4 12
INDIRP4
CNSTI4 128
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 128
ADDP4
INDIRI4
EQI4 $225
line 198
;198:		cent = &cg_entities[ ps->clientNum ];
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
CNSTI4 880
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 199
;199:		cent->currentState.event = ps->externalEvent;
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
INDIRI4
ASGNI4
line 200
;200:		cent->currentState.eventParm = ps->externalEventParm;
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 132
ADDP4
INDIRI4
ASGNI4
line 201
;201:		CG_EntityEvent( cent, cent->lerpOrigin );
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
line 202
;202:	}
LABELV $225
line 204
;203:
;204:	cent = &cg.predictedPlayerEntity; // cg_entities[ ps->clientNum ];
ADDRLP4 4
ADDRGP4 cg+108156
ASGNP4
line 206
;205:	// go through the predictable events buffer
;206:	for ( i = ps->eventSequence - MAX_PS_EVENTS ; i < ps->eventSequence ; i++ ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
ADDRGP4 $231
JUMPV
LABELV $228
line 208
;207:		// if we have a new predictable event
;208:		if ( i >= ops->eventSequence
ADDRLP4 20
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
ADDRLP4 20
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
GEI4 $234
ADDRLP4 0
INDIRI4
ADDRLP4 20
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
CNSTI4 2
SUBI4
LEI4 $232
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 2
LSHI4
ADDRLP4 20
INDIRP4
CNSTI4 112
ADDP4
ADDP4
INDIRI4
EQI4 $232
LABELV $234
line 211
;209:			// or the server told us to play another event instead of a predicted event we already issued
;210:			// or something the server told us changed our prediction causing a different event
;211:			|| (i > ops->eventSequence - MAX_PS_EVENTS && ps->events[i & (MAX_PS_EVENTS-1)] != ops->events[i & (MAX_PS_EVENTS-1)]) ) {
line 213
;212:
;213:			event = ps->events[ i & (MAX_PS_EVENTS-1) ];
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDP4
INDIRI4
ASGNI4
line 214
;214:			cent->currentState.event = event;
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 215
;215:			cent->currentState.eventParm = ps->eventParms[ i & (MAX_PS_EVENTS-1) ];
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
ADDP4
INDIRI4
ASGNI4
line 216
;216:			CG_EntityEvent( cent, cent->lerpOrigin );
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
line 218
;217:
;218:			cg.predictableEvents[ i & (MAX_PREDICTED_EVENTS-1) ] = event;
ADDRLP4 0
INDIRI4
CNSTI4 15
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cg+109060
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 220
;219:
;220:			cg.eventSequence++;
ADDRLP4 28
ADDRGP4 cg+109056
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 221
;221:		}
LABELV $232
line 222
;222:	}
LABELV $229
line 206
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $231
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
LTI4 $228
line 223
;223:}
LABELV $224
endproc CG_CheckPlayerstateEvents 32 8
export CG_CheckChangedPredictableEvents
proc CG_CheckChangedPredictableEvents 20 8
line 230
;224:
;225:/*
;226:==================
;227:CG_CheckChangedPredictableEvents
;228:==================
;229:*/
;230:void CG_CheckChangedPredictableEvents( playerState_t *ps ) {
line 235
;231:	int i;
;232:	int event;
;233:	centity_t	*cent;
;234:
;235:	cent = &cg.predictedPlayerEntity;
ADDRLP4 4
ADDRGP4 cg+108156
ASGNP4
line 236
;236:	for ( i = ps->eventSequence - MAX_PS_EVENTS ; i < ps->eventSequence ; i++ ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
ADDRGP4 $242
JUMPV
LABELV $239
line 238
;237:		//
;238:		if (i >= cg.eventSequence) {
ADDRLP4 0
INDIRI4
ADDRGP4 cg+109056
INDIRI4
LTI4 $243
line 239
;239:			continue;
ADDRGP4 $240
JUMPV
LABELV $243
line 242
;240:		}
;241:		// if this event is not further back in than the maximum predictable events we remember
;242:		if (i > cg.eventSequence - MAX_PREDICTED_EVENTS) {
ADDRLP4 0
INDIRI4
ADDRGP4 cg+109056
INDIRI4
CNSTI4 16
SUBI4
LEI4 $246
line 244
;243:			// if the new playerstate event is different from a previously predicted one
;244:			if ( ps->events[i & (MAX_PS_EVENTS-1)] != cg.predictableEvents[i & (MAX_PREDICTED_EVENTS-1) ] ) {
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 15
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cg+109060
ADDP4
INDIRI4
EQI4 $249
line 246
;245:
;246:				event = ps->events[ i & (MAX_PS_EVENTS-1) ];
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDP4
INDIRI4
ASGNI4
line 247
;247:				cent->currentState.event = event;
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 248
;248:				cent->currentState.eventParm = ps->eventParms[ i & (MAX_PS_EVENTS-1) ];
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
ADDP4
INDIRI4
ASGNI4
line 249
;249:				CG_EntityEvent( cent, cent->lerpOrigin );
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
line 251
;250:
;251:				cg.predictableEvents[ i & (MAX_PREDICTED_EVENTS-1) ] = event;
ADDRLP4 0
INDIRI4
CNSTI4 15
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cg+109060
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 253
;252:
;253:				if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $253
line 254
;254:					CG_Printf("WARNING: changed predicted event\n");
ADDRGP4 $256
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 255
;255:				}
LABELV $253
line 256
;256:			}
LABELV $249
line 257
;257:		}
LABELV $246
line 258
;258:	}
LABELV $240
line 236
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $242
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
LTI4 $239
line 259
;259:}
LABELV $237
endproc CG_CheckChangedPredictableEvents 20 8
proc pushReward 4 0
line 266
;260:
;261:/*
;262:==================
;263:pushReward
;264:==================
;265:*/
;266:static void pushReward(sfxHandle_t sfx, qhandle_t shader, int rewardCount) {
line 267
;267:	if (cg.rewardStack < (MAX_REWARDSTACK-1)) {
ADDRGP4 cg+127736
INDIRI4
CNSTI4 9
GEI4 $258
line 268
;268:		cg.rewardStack++;
ADDRLP4 0
ADDRGP4 cg+127736
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 269
;269:		cg.rewardSound[cg.rewardStack] = sfx;
ADDRGP4 cg+127736
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+127824
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 270
;270:		cg.rewardShader[cg.rewardStack] = shader;
ADDRGP4 cg+127736
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+127784
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 271
;271:		cg.rewardCount[cg.rewardStack] = rewardCount;
ADDRGP4 cg+127736
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+127744
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 272
;272:	}
LABELV $258
line 273
;273:}
LABELV $257
endproc pushReward 4 0
export CG_CheckLocalSounds
proc CG_CheckLocalSounds 32 12
line 280
;274:
;275:/*
;276:==================
;277:CG_CheckLocalSounds
;278:==================
;279:*/
;280:void CG_CheckLocalSounds( playerState_t *ps, playerState_t *ops ) {
line 285
;281:	int			highScore, health, armor, reward;
;282:	sfxHandle_t sfx;
;283:
;284:	// don't play the sounds if the player just changed teams
;285:	if ( ps->persistant[PERS_TEAM] != ops->persistant[PERS_TEAM] ) {
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
EQI4 $269
line 286
;286:		return;
ADDRGP4 $268
JUMPV
LABELV $269
line 290
;287:	}
;288:
;289:	// hit changes
;290:	if ( ps->persistant[PERS_HITS] > ops->persistant[PERS_HITS] ) {
ADDRFP4 0
INDIRP4
CNSTI4 252
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 252
ADDP4
INDIRI4
LEI4 $271
line 291
;291:		armor  = ps->persistant[PERS_ATTACKEE_ARMOR] & 0xff;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 255
BANDI4
ASGNI4
line 292
;292:		health = ps->persistant[PERS_ATTACKEE_ARMOR] >> 8;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 8
RSHI4
ASGNI4
line 305
;293:#ifdef MISSIONPACK
;294:		if (armor > 50 ) {
;295:			trap_S_StartLocalSound( cgs.media.hitSoundHighArmor, CHAN_LOCAL_SOUND );
;296:		} else if (armor || health > 100) {
;297:			trap_S_StartLocalSound( cgs.media.hitSoundLowArmor, CHAN_LOCAL_SOUND );
;298:		} else {
;299:			trap_S_StartLocalSound( cgs.media.hitSound, CHAN_LOCAL_SOUND );
;300:		}
;301:#else
;302:#if !MONSTER_MODE	// JUHOX: no hit sound in STU
;303:		trap_S_StartLocalSound( cgs.media.hitSound, CHAN_LOCAL_SOUND );
;304:#else
;305:		if (cgs.gametype < GT_STU) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 8
GEI4 $272
line 306
;306:			trap_S_StartLocalSound( cgs.media.hitSound, CHAN_LOCAL_SOUND );
ADDRGP4 cgs+751220+1272
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 307
;307:		}
line 310
;308:#endif
;309:#endif
;310:	} else if ( ps->persistant[PERS_HITS] < ops->persistant[PERS_HITS] ) {
ADDRGP4 $272
JUMPV
LABELV $271
ADDRFP4 0
INDIRP4
CNSTI4 252
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 252
ADDP4
INDIRI4
GEI4 $278
line 311
;311:		trap_S_StartLocalSound( cgs.media.hitTeamSound, CHAN_LOCAL_SOUND );
ADDRGP4 cgs+751220+1284
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 312
;312:	}
LABELV $278
LABELV $272
line 315
;313:
;314:	// health changes of more than -1 should make pain sounds
;315:	if ( ps->stats[STAT_HEALTH] < ops->stats[STAT_HEALTH] - 1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 1
SUBI4
GEI4 $282
line 316
;316:		if ( ps->stats[STAT_HEALTH] > 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
LEI4 $284
line 317
;317:			CG_PainEvent( &cg.predictedPlayerEntity, ps->stats[STAT_HEALTH] );
ADDRGP4 cg+108156
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_PainEvent
CALLV
pop
line 318
;318:		}
LABELV $284
line 319
;319:	}
LABELV $282
line 323
;320:
;321:
;322:	// if we are going into the intermission, don't start any voices
;323:	if ( cg.intermissionStarted ) {
ADDRGP4 cg+24
INDIRI4
CNSTI4 0
EQI4 $287
line 324
;324:		return;
ADDRGP4 $268
JUMPV
LABELV $287
line 328
;325:	}
;326:
;327:	// reward sounds
;328:	reward = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 331
;329:	// JUHOX: in STU don't count rewards
;330:#if MONSTER_MODE
;331:	if (cgs.gametype >= GT_STU) goto RewardsChecked;
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 8
LTI4 $290
ADDRGP4 $293
JUMPV
LABELV $290
line 333
;332:#endif
;333:	if (ps->persistant[PERS_CAPTURES] != ops->persistant[PERS_CAPTURES]) {
ADDRFP4 0
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
EQI4 $294
line 334
;334:		pushReward(cgs.media.captureAwardSound, cgs.media.medalCapture, ps->persistant[PERS_CAPTURES]);
ADDRGP4 cgs+751220+1372
INDIRI4
ARGI4
ADDRGP4 cgs+751220+776
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
ARGI4
ADDRGP4 pushReward
CALLV
pop
line 335
;335:		reward = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 337
;336:		//Com_Printf("capture\n");
;337:	}
LABELV $294
line 338
;338:	if (ps->persistant[PERS_IMPRESSIVE_COUNT] != ops->persistant[PERS_IMPRESSIVE_COUNT]) {
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
EQI4 $300
line 346
;339:#ifdef MISSIONPACK
;340:		if (ps->persistant[PERS_IMPRESSIVE_COUNT] == 1) {
;341:			sfx = cgs.media.firstImpressiveSound;
;342:		} else {
;343:			sfx = cgs.media.impressiveSound;
;344:		}
;345:#else
;346:		sfx = cgs.media.impressiveSound;
ADDRLP4 4
ADDRGP4 cgs+751220+1288
INDIRI4
ASGNI4
line 348
;347:#endif
;348:		pushReward(sfx, cgs.media.medalImpressive, ps->persistant[PERS_IMPRESSIVE_COUNT]);
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 cgs+751220+756
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
ARGI4
ADDRGP4 pushReward
CALLV
pop
line 349
;349:		reward = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 351
;350:		//Com_Printf("impressive\n");
;351:	}
LABELV $300
line 352
;352:	if (ps->persistant[PERS_EXCELLENT_COUNT] != ops->persistant[PERS_EXCELLENT_COUNT]) {
ADDRFP4 0
INDIRP4
CNSTI4 288
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 288
ADDP4
INDIRI4
EQI4 $306
line 360
;353:#ifdef MISSIONPACK
;354:		if (ps->persistant[PERS_EXCELLENT_COUNT] == 1) {
;355:			sfx = cgs.media.firstExcellentSound;
;356:		} else {
;357:			sfx = cgs.media.excellentSound;
;358:		}
;359:#else
;360:		sfx = cgs.media.excellentSound;
ADDRLP4 4
ADDRGP4 cgs+751220+1292
INDIRI4
ASGNI4
line 362
;361:#endif
;362:		pushReward(sfx, cgs.media.medalExcellent, ps->persistant[PERS_EXCELLENT_COUNT]);
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 cgs+751220+760
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 288
ADDP4
INDIRI4
ARGI4
ADDRGP4 pushReward
CALLV
pop
line 363
;363:		reward = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 365
;364:		//Com_Printf("excellent\n");
;365:	}
LABELV $306
line 366
;366:	if (ps->persistant[PERS_GAUNTLET_FRAG_COUNT] != ops->persistant[PERS_GAUNTLET_FRAG_COUNT]) {
ADDRFP4 0
INDIRP4
CNSTI4 300
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 300
ADDP4
INDIRI4
EQI4 $312
line 374
;367:#ifdef MISSIONPACK
;368:		if (ops->persistant[PERS_GAUNTLET_FRAG_COUNT] == 1) {
;369:			sfx = cgs.media.firstHumiliationSound;
;370:		} else {
;371:			sfx = cgs.media.humiliationSound;
;372:		}
;373:#else
;374:		sfx = cgs.media.humiliationSound;
ADDRLP4 4
ADDRGP4 cgs+751220+1300
INDIRI4
ASGNI4
line 376
;375:#endif
;376:		pushReward(sfx, cgs.media.medalGauntlet, ps->persistant[PERS_GAUNTLET_FRAG_COUNT]);
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 cgs+751220+764
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 300
ADDP4
INDIRI4
ARGI4
ADDRGP4 pushReward
CALLV
pop
line 377
;377:		reward = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 379
;378:		//Com_Printf("guantlet frag\n");
;379:	}
LABELV $312
line 380
;380:	if (ps->persistant[PERS_DEFEND_COUNT] != ops->persistant[PERS_DEFEND_COUNT]) {
ADDRFP4 0
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
EQI4 $318
line 381
;381:		pushReward(cgs.media.defendSound, cgs.media.medalDefend, ps->persistant[PERS_DEFEND_COUNT]);
ADDRGP4 cgs+751220+1308
INDIRI4
ARGI4
ADDRGP4 cgs+751220+768
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
ARGI4
ADDRGP4 pushReward
CALLV
pop
line 382
;382:		reward = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 384
;383:		//Com_Printf("defend\n");
;384:	}
LABELV $318
line 385
;385:	if (ps->persistant[PERS_ASSIST_COUNT] != ops->persistant[PERS_ASSIST_COUNT]) {
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 296
ADDP4
INDIRI4
EQI4 $324
line 386
;386:		pushReward(cgs.media.assistSound, cgs.media.medalAssist, ps->persistant[PERS_ASSIST_COUNT]);
ADDRGP4 cgs+751220+1304
INDIRI4
ARGI4
ADDRGP4 cgs+751220+772
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRI4
ARGI4
ADDRGP4 pushReward
CALLV
pop
line 387
;387:		reward = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 389
;388:		//Com_Printf("assist\n");
;389:	}
LABELV $324
LABELV $293
line 394
;390:#if MONSTER_MODE
;391:	RewardsChecked:	// JUHOX
;392:#endif
;393:	// if any of the player event bits changed
;394:	if (ps->persistant[PERS_PLAYEREVENTS] != ops->persistant[PERS_PLAYEREVENTS]) {
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
EQI4 $330
line 395
;395:		if ((ps->persistant[PERS_PLAYEREVENTS] & PLAYEREVENT_DENIEDREWARD) !=
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
CNSTI4 1
BANDI4
ADDRFP4 4
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
CNSTI4 1
BANDI4
EQI4 $332
line 396
;396:				(ops->persistant[PERS_PLAYEREVENTS] & PLAYEREVENT_DENIEDREWARD)) {
line 397
;397:			trap_S_StartLocalSound( cgs.media.deniedSound, CHAN_ANNOUNCER );
ADDRGP4 cgs+751220+1296
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 398
;398:		}
ADDRGP4 $333
JUMPV
LABELV $332
line 399
;399:		else if ((ps->persistant[PERS_PLAYEREVENTS] & PLAYEREVENT_GAUNTLETREWARD) !=
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
CNSTI4 2
BANDI4
ADDRFP4 4
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
CNSTI4 2
BANDI4
EQI4 $336
line 400
;400:				(ops->persistant[PERS_PLAYEREVENTS] & PLAYEREVENT_GAUNTLETREWARD)) {
line 401
;401:			trap_S_StartLocalSound( cgs.media.humiliationSound, CHAN_ANNOUNCER );
ADDRGP4 cgs+751220+1300
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 402
;402:		}
ADDRGP4 $337
JUMPV
LABELV $336
line 403
;403:		else if ((ps->persistant[PERS_PLAYEREVENTS] & PLAYEREVENT_HOLYSHIT) !=
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
CNSTI4 4
BANDI4
ADDRFP4 4
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
CNSTI4 4
BANDI4
EQI4 $340
line 404
;404:				(ops->persistant[PERS_PLAYEREVENTS] & PLAYEREVENT_HOLYSHIT)) {
line 405
;405:			trap_S_StartLocalSound( cgs.media.holyShitSound, CHAN_ANNOUNCER );
ADDRGP4 cgs+751220+1456
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 406
;406:		}
LABELV $340
LABELV $337
LABELV $333
line 407
;407:		reward = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 408
;408:	}
LABELV $330
line 411
;409:
;410:	// check for flag pickup
;411:	if ( cgs.gametype >= GT_TEAM ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $344
line 412
;412:		if ((ps->powerups[PW_REDFLAG] != ops->powerups[PW_REDFLAG] && ps->powerups[PW_REDFLAG]) ||
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
EQI4 $350
ADDRLP4 20
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
NEI4 $351
LABELV $350
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
EQI4 $352
ADDRLP4 24
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
NEI4 $351
LABELV $352
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
EQI4 $347
ADDRLP4 28
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
CNSTI4 0
EQI4 $347
LABELV $351
line 415
;413:			(ps->powerups[PW_BLUEFLAG] != ops->powerups[PW_BLUEFLAG] && ps->powerups[PW_BLUEFLAG]) ||
;414:			(ps->powerups[PW_NEUTRALFLAG] != ops->powerups[PW_NEUTRALFLAG] && ps->powerups[PW_NEUTRALFLAG]) )
;415:		{
line 416
;416:			trap_S_StartLocalSound( cgs.media.youHaveFlagSound, CHAN_ANNOUNCER );
ADDRGP4 cgs+751220+1448
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 417
;417:		}
LABELV $347
line 418
;418:	}
LABELV $344
line 421
;419:
;420:	// lead changes
;421:	if (!reward) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $355
line 423
;422:		//
;423:		if ( !cg.warmup ) {
ADDRGP4 cg+127968
INDIRI4
CNSTI4 0
NEI4 $357
line 425
;424:			// never play lead changes during warmup
;425:			if ( ps->persistant[PERS_RANK] != ops->persistant[PERS_RANK] ) {
ADDRFP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
EQI4 $360
line 426
;426:				if ( cgs.gametype < GT_TEAM) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
GEI4 $362
line 427
;427:					if (  ps->persistant[PERS_RANK] == 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
CNSTI4 0
NEI4 $365
line 428
;428:						CG_AddBufferedSound(cgs.media.takenLeadSound);
ADDRGP4 cgs+751220+1324
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 429
;429:					} else if ( ps->persistant[PERS_RANK] == RANK_TIED_FLAG ) {
ADDRGP4 $366
JUMPV
LABELV $365
ADDRFP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
CNSTI4 16384
NEI4 $369
line 430
;430:						CG_AddBufferedSound(cgs.media.tiedLeadSound);
ADDRGP4 cgs+751220+1328
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 431
;431:					} else if ( ( ops->persistant[PERS_RANK] & ~RANK_TIED_FLAG ) == 0 ) {
ADDRGP4 $370
JUMPV
LABELV $369
ADDRFP4 4
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
CNSTI4 -16385
BANDI4
CNSTI4 0
NEI4 $373
line 432
;432:						CG_AddBufferedSound(cgs.media.lostLeadSound);
ADDRGP4 cgs+751220+1332
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 433
;433:					}
LABELV $373
LABELV $370
LABELV $366
line 434
;434:				}
LABELV $362
line 435
;435:			}
LABELV $360
line 436
;436:		}
LABELV $357
line 437
;437:	}
LABELV $355
line 440
;438:
;439:	// timelimit warnings
;440:	if ( cgs.timelimit > 0 ) {
ADDRGP4 cgs+31476
INDIRI4
CNSTI4 0
LEI4 $377
line 443
;441:		int		msec;
;442:
;443:		msec = cg.time - cgs.levelStartTime;
ADDRLP4 20
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cgs+35120
INDIRI4
SUBI4
ASGNI4
line 444
;444:		if ( !( cg.timelimitWarnings & 4 ) && msec > ( cgs.timelimit * 60 + 2 ) * 1000 ) {
ADDRGP4 cg+107668
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
NEI4 $382
ADDRLP4 20
INDIRI4
ADDRGP4 cgs+31476
INDIRI4
CNSTI4 60
MULI4
CNSTI4 1000
MULI4
CNSTI4 2000
ADDI4
LEI4 $382
line 445
;445:			cg.timelimitWarnings |= 1 | 2 | 4;
ADDRLP4 24
ADDRGP4 cg+107668
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 7
BORI4
ASGNI4
line 446
;446:			trap_S_StartLocalSound( cgs.media.suddenDeathSound, CHAN_ANNOUNCER );
ADDRGP4 cgs+751220+1256
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 447
;447:		}
ADDRGP4 $383
JUMPV
LABELV $382
line 448
;448:		else if ( !( cg.timelimitWarnings & 2 ) && msec > (cgs.timelimit - 1) * 60 * 1000 ) {
ADDRGP4 cg+107668
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $389
ADDRLP4 20
INDIRI4
ADDRGP4 cgs+31476
INDIRI4
CNSTI4 60
MULI4
CNSTI4 1000
MULI4
CNSTI4 60000
SUBI4
LEI4 $389
line 449
;449:			cg.timelimitWarnings |= 1 | 2;
ADDRLP4 24
ADDRGP4 cg+107668
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 3
BORI4
ASGNI4
line 450
;450:			trap_S_StartLocalSound( cgs.media.oneMinuteSound, CHAN_ANNOUNCER );
ADDRGP4 cgs+751220+1248
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 451
;451:		}
ADDRGP4 $390
JUMPV
LABELV $389
line 452
;452:		else if ( cgs.timelimit > 5 && !( cg.timelimitWarnings & 1 ) && msec > (cgs.timelimit - 5) * 60 * 1000 ) {
ADDRGP4 cgs+31476
INDIRI4
CNSTI4 5
LEI4 $396
ADDRGP4 cg+107668
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $396
ADDRLP4 20
INDIRI4
ADDRGP4 cgs+31476
INDIRI4
CNSTI4 60
MULI4
CNSTI4 1000
MULI4
CNSTI4 300000
SUBI4
LEI4 $396
line 453
;453:			cg.timelimitWarnings |= 1;
ADDRLP4 24
ADDRGP4 cg+107668
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 454
;454:			trap_S_StartLocalSound( cgs.media.fiveMinuteSound, CHAN_ANNOUNCER );
ADDRGP4 cgs+751220+1252
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 455
;455:		}
LABELV $396
LABELV $390
LABELV $383
line 456
;456:	}
LABELV $377
line 459
;457:
;458:	// fraglimit warnings
;459:	if ( cgs.fraglimit > 0 && cgs.gametype < GT_CTF) {
ADDRGP4 cgs+31468
INDIRI4
CNSTI4 0
LEI4 $404
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
GEI4 $404
line 460
;460:		highScore = cgs.scores1;
ADDRLP4 8
ADDRGP4 cgs+35124
INDIRI4
ASGNI4
line 461
;461:		if (cgs.gametype >= GT_TEAM && cgs.scores2 > highScore) highScore = cgs.scores2;	// JUHOX BUGFIX
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $409
ADDRGP4 cgs+35128
INDIRI4
ADDRLP4 8
INDIRI4
LEI4 $409
ADDRLP4 8
ADDRGP4 cgs+35128
INDIRI4
ASGNI4
LABELV $409
line 463
;462:#if MONSTER_MODE	// JUHOX: in STU the fraglimit only applies to the blue team
;463:		if (cgs.gametype >= GT_STU) highScore = cgs.scores2;
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 8
LTI4 $414
ADDRLP4 8
ADDRGP4 cgs+35128
INDIRI4
ASGNI4
LABELV $414
line 465
;464:#endif
;465:		if ( !( cg.fraglimitWarnings & 4 ) && highScore == (cgs.fraglimit - 1) ) {
ADDRGP4 cg+107672
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
NEI4 $418
ADDRLP4 8
INDIRI4
ADDRGP4 cgs+31468
INDIRI4
CNSTI4 1
SUBI4
NEI4 $418
line 466
;466:			cg.fraglimitWarnings |= 1 | 2 | 4;
ADDRLP4 20
ADDRGP4 cg+107672
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 7
BORI4
ASGNI4
line 467
;467:			CG_AddBufferedSound(cgs.media.oneFragSound);
ADDRGP4 cgs+751220+1268
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 468
;468:		}
ADDRGP4 $419
JUMPV
LABELV $418
line 469
;469:		else if ( cgs.fraglimit > 2 && !( cg.fraglimitWarnings & 2 ) && highScore == (cgs.fraglimit - 2) ) {
ADDRGP4 cgs+31468
INDIRI4
CNSTI4 2
LEI4 $425
ADDRGP4 cg+107672
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $425
ADDRLP4 8
INDIRI4
ADDRGP4 cgs+31468
INDIRI4
CNSTI4 2
SUBI4
NEI4 $425
line 470
;470:			cg.fraglimitWarnings |= 1 | 2;
ADDRLP4 20
ADDRGP4 cg+107672
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 3
BORI4
ASGNI4
line 471
;471:			CG_AddBufferedSound(cgs.media.twoFragSound);
ADDRGP4 cgs+751220+1264
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 472
;472:		}
ADDRGP4 $426
JUMPV
LABELV $425
line 473
;473:		else if ( cgs.fraglimit > 3 && !( cg.fraglimitWarnings & 1 ) && highScore == (cgs.fraglimit - 3) ) {
ADDRGP4 cgs+31468
INDIRI4
CNSTI4 3
LEI4 $433
ADDRGP4 cg+107672
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $433
ADDRLP4 8
INDIRI4
ADDRGP4 cgs+31468
INDIRI4
CNSTI4 3
SUBI4
NEI4 $433
line 474
;474:			cg.fraglimitWarnings |= 1;
ADDRLP4 20
ADDRGP4 cg+107672
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 475
;475:			CG_AddBufferedSound(cgs.media.threeFragSound);
ADDRGP4 cgs+751220+1260
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 476
;476:		}
LABELV $433
LABELV $426
LABELV $419
line 477
;477:	}
LABELV $404
line 478
;478:}
LABELV $268
endproc CG_CheckLocalSounds 32 12
export CG_TransitionPlayerState
proc CG_TransitionPlayerState 8 12
line 486
;479:
;480:/*
;481:===============
;482:CG_TransitionPlayerState
;483:
;484:===============
;485:*/
;486:void CG_TransitionPlayerState( playerState_t *ps, playerState_t *ops ) {
line 488
;487:	// check for changing follow mode
;488:	if ( ps->clientNum != ops->clientNum ) {
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
EQI4 $442
line 489
;489:		cg.thisFrameTeleport = qtrue;
ADDRGP4 cg+107644
CNSTI4 1
ASGNI4
line 491
;490:		// make sure we don't get any unwanted transition effects
;491:		*ops = *ps;
ADDRFP4 4
INDIRP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 468
line 492
;492:	}
LABELV $442
line 495
;493:
;494:	// damage events (player is getting wounded)
;495:	if ( ps->damageEvent != ops->damageEvent && ps->damageCount ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
EQI4 $445
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 0
EQI4 $445
line 496
;496:		CG_DamageFeedback( ps->damageYaw, ps->damagePitch, ps->damageCount );
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DamageFeedback
CALLV
pop
line 497
;497:	}
LABELV $445
line 500
;498:
;499:	// respawning
;500:	if ( ps->persistant[PERS_SPAWN_COUNT] != ops->persistant[PERS_SPAWN_COUNT] ) {
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 264
ADDP4
INDIRI4
EQI4 $447
line 501
;501:		CG_Respawn();
ADDRGP4 CG_Respawn
CALLV
pop
line 502
;502:	}
LABELV $447
line 505
;503:
;504:#if MEETING	// JUHOX: do "fight" sound when leaving meeting
;505:	if (ops->pm_type == PM_MEETING && ps->pm_type != PM_MEETING) {
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 7
NEI4 $449
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 7
EQI4 $449
line 506
;506:		trap_S_StartLocalSound( cgs.media.countFightSound, CHAN_ANNOUNCER );
ADDRGP4 cgs+751220+1472
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 507
;507:		CG_CenterPrint( "FIGHT!", 120, GIANTCHAR_WIDTH*2 );
ADDRGP4 $453
ARGP4
CNSTI4 120
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 508
;508:	}
LABELV $449
line 511
;509:#endif
;510:
;511:	if ( cg.mapRestart ) {
ADDRGP4 cg+107676
INDIRI4
CNSTI4 0
EQI4 $454
line 512
;512:		CG_Respawn();
ADDRGP4 CG_Respawn
CALLV
pop
line 513
;513:		cg.mapRestart = qfalse;
ADDRGP4 cg+107676
CNSTI4 0
ASGNI4
line 514
;514:	}
LABELV $454
line 516
;515:
;516:	if ( cg.snap->ps.pm_type != PM_INTERMISSION 
ADDRGP4 cg+36
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 5
EQI4 $458
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 3
EQI4 $458
line 517
;517:		&& ps->persistant[PERS_TEAM] != TEAM_SPECTATOR ) {
line 518
;518:		CG_CheckLocalSounds( ps, ops );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_CheckLocalSounds
CALLV
pop
line 519
;519:	}
LABELV $458
line 522
;520:
;521:	// check for going low on ammo
;522:	CG_CheckAmmo();
ADDRGP4 CG_CheckAmmo
CALLV
pop
line 525
;523:
;524:	// run events
;525:	CG_CheckPlayerstateEvents( ps, ops );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_CheckPlayerstateEvents
CALLV
pop
line 528
;526:
;527:	// smooth the ducking viewheight change
;528:	if ( ps->viewheight != ops->viewheight ) {
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
EQI4 $461
line 529
;529:		cg.duckChange = ps->viewheight - ops->viewheight;
ADDRGP4 cg+109132
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 530
;530:		cg.duckTime = cg.time;
ADDRGP4 cg+109136
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 531
;531:	}
LABELV $461
line 532
;532:}
LABELV $441
endproc CG_TransitionPlayerState 8 12
import eventnames
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
LABELV $453
byte 1 70
byte 1 73
byte 1 71
byte 1 72
byte 1 84
byte 1 33
byte 1 0
align 1
LABELV $256
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 100
byte 1 32
byte 1 112
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
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
