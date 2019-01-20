export InitTrigger
code
proc InitTrigger 12 8
file "..\..\..\..\code\game\g_trigger.c"
line 6
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:#include "g_local.h"
;4:
;5:
;6:void InitTrigger( gentity_t *self ) {
line 7
;7:	if (!VectorCompare (self->s.angles, vec3_origin))
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRGP4 vec3_origin
ARGP4
ADDRLP4 0
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $88
line 8
;8:		G_SetMovedir (self->s.angles, self->movedir);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 680
ADDP4
ARGP4
ADDRGP4 G_SetMovedir
CALLV
pop
LABELV $88
line 10
;9:
;10:	trap_SetBrushModel( self, self->model );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 544
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_SetBrushModel
CALLV
pop
line 11
;11:	self->r.contents = CONTENTS_TRIGGER;		// replaces the -1 from trap_SetBrushModel
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 1073741824
ASGNI4
line 12
;12:	self->r.svFlags = SVF_NOCLIENT;
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 1
ASGNI4
line 13
;13:}
LABELV $87
endproc InitTrigger 12 8
export multi_wait
proc multi_wait 0 0
line 17
;14:
;15:
;16:// the wait time has passed, so set back up for another activation
;17:void multi_wait( gentity_t *ent ) {
line 18
;18:	ent->nextthink = 0;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
CNSTI4 0
ASGNI4
line 19
;19:}
LABELV $90
endproc multi_wait 0 0
export multi_trigger
proc multi_trigger 12 8
line 25
;20:
;21:
;22:// the trigger was just activated
;23:// ent->activator should be set to the activator so it can be held through a delay
;24:// so wait for the delay time before firing
;25:void multi_trigger( gentity_t *ent, gentity_t *activator ) {
line 26
;26:	ent->activator = activator;
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
ADDRFP4 4
INDIRP4
ASGNP4
line 27
;27:	if ( ent->nextthink ) {
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
INDIRI4
CNSTI4 0
EQI4 $92
line 28
;28:		return;		// can't retrigger until the wait is over
ADDRGP4 $91
JUMPV
LABELV $92
line 31
;29:	}
;30:
;31:	if ( activator->client ) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $94
line 32
;32:		if ( ( ent->spawnflags & 1 ) &&
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $96
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 1
EQI4 $96
line 33
;33:			activator->client->sess.sessionTeam != TEAM_RED ) {
line 34
;34:			return;
ADDRGP4 $91
JUMPV
LABELV $96
line 36
;35:		}
;36:		if ( ( ent->spawnflags & 2 ) &&
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $98
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 2
EQI4 $98
line 37
;37:			activator->client->sess.sessionTeam != TEAM_BLUE ) {
line 38
;38:			return;
ADDRGP4 $91
JUMPV
LABELV $98
line 40
;39:		}
;40:	}
LABELV $94
line 42
;41:
;42:	G_UseTargets (ent, ent->activator);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_UseTargets
CALLV
pop
line 44
;43:
;44:	if ( ent->wait > 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 800
ADDP4
INDIRF4
CNSTF4 0
LEF4 $100
line 45
;45:		ent->think = multi_wait;
ADDRFP4 0
INDIRP4
CNSTI4 696
ADDP4
ADDRGP4 multi_wait
ASGNP4
line 46
;46:		ent->nextthink = level.time + ( ent->wait + ent->random * crandom() ) * 1000;
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
CNSTI4 692
ADDP4
ADDRGP4 level+32
INDIRI4
CVIF4 4
ADDRLP4 8
INDIRP4
CNSTI4 800
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 804
ADDP4
INDIRF4
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
CNSTF4 1148846080
MULF4
ADDF4
CVFI4 4
ASGNI4
line 47
;47:	} else {
ADDRGP4 $101
JUMPV
LABELV $100
line 50
;48:		// we can't just remove (self) here, because this is a touch function
;49:		// called while looping through area links...
;50:		ent->touch = 0;
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
CNSTP4 0
ASGNP4
line 51
;51:		ent->nextthink = level.time + FRAMETIME;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 52
;52:		ent->think = G_FreeEntity;
ADDRFP4 0
INDIRP4
CNSTI4 696
ADDP4
ADDRGP4 G_FreeEntity
ASGNP4
line 53
;53:	}
LABELV $101
line 54
;54:}
LABELV $91
endproc multi_trigger 12 8
export Use_Multi
proc Use_Multi 0 8
line 56
;55:
;56:void Use_Multi( gentity_t *ent, gentity_t *other, gentity_t *activator ) {
line 57
;57:	multi_trigger( ent, activator );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 multi_trigger
CALLV
pop
line 58
;58:}
LABELV $104
endproc Use_Multi 0 8
export Touch_Multi
proc Touch_Multi 0 8
line 60
;59:
;60:void Touch_Multi( gentity_t *self, gentity_t *other, trace_t *trace ) {
line 61
;61:	if( !other->client ) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $106
line 62
;62:		return;
ADDRGP4 $105
JUMPV
LABELV $106
line 64
;63:	}
;64:	multi_trigger( self, other );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 multi_trigger
CALLV
pop
line 65
;65:}
LABELV $105
endproc Touch_Multi 0 8
export SP_trigger_multiple
proc SP_trigger_multiple 8 12
line 74
;66:
;67:/*QUAKED trigger_multiple (.5 .5 .5) ?
;68:"wait" : Seconds between triggerings, 0.5 default, -1 = one time only.
;69:"random"	wait variance, default is 0
;70:Variable sized repeatable trigger.  Must be targeted at one or more entities.
;71:so, the basic time between firing is a random time between
;72:(wait - random) and (wait + random)
;73:*/
;74:void SP_trigger_multiple( gentity_t *ent ) {
line 75
;75:	G_SpawnFloat( "wait", "0.5", &ent->wait );
ADDRGP4 $109
ARGP4
ADDRGP4 $110
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 800
ADDP4
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 76
;76:	G_SpawnFloat( "random", "0", &ent->random );
ADDRGP4 $111
ARGP4
ADDRGP4 $112
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 78
;77:
;78:	if ( ent->random >= ent->wait && ent->wait >= 0 ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 800
ADDP4
INDIRF4
LTF4 $113
ADDRLP4 0
INDIRP4
CNSTI4 800
ADDP4
INDIRF4
CNSTF4 0
LTF4 $113
line 79
;79:		ent->random = ent->wait - FRAMETIME;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 804
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 800
ADDP4
INDIRF4
CNSTF4 1120403456
SUBF4
ASGNF4
line 80
;80:		G_Printf( "trigger_multiple has random >= wait\n" );
ADDRGP4 $115
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 81
;81:	}
LABELV $113
line 83
;82:
;83:	ent->touch = Touch_Multi;
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
ADDRGP4 Touch_Multi
ASGNP4
line 84
;84:	ent->use = Use_Multi;
ADDRFP4 0
INDIRP4
CNSTI4 712
ADDP4
ADDRGP4 Use_Multi
ASGNP4
line 86
;85:
;86:	InitTrigger( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 InitTrigger
CALLV
pop
line 87
;87:	trap_LinkEntity (ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 90
;88:
;89:#if ESCAPE_MODE	// JUHOX: set entity class
;90:	ent->entClass = GEC_trigger_multiple;
ADDRFP4 0
INDIRP4
CNSTI4 824
ADDP4
CNSTI4 15
ASGNI4
line 92
;91:#endif
;92:}
LABELV $108
endproc SP_trigger_multiple 8 12
export trigger_always_think
proc trigger_always_think 4 8
line 104
;93:
;94:
;95:
;96:/*
;97:==============================================================================
;98:
;99:trigger_always
;100:
;101:==============================================================================
;102:*/
;103:
;104:void trigger_always_think( gentity_t *ent ) {
line 105
;105:	G_UseTargets(ent, ent);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_UseTargets
CALLV
pop
line 106
;106:	G_FreeEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 107
;107:}
LABELV $116
endproc trigger_always_think 4 8
export SP_trigger_always
proc SP_trigger_always 0 0
line 112
;108:
;109:/*QUAKED trigger_always (.5 .5 .5) (-8 -8 -8) (8 8 8)
;110:This trigger will always fire.  It is activated by the world.
;111:*/
;112:void SP_trigger_always (gentity_t *ent) {
line 114
;113:	// we must have some delay to make sure our use targets are present
;114:	ent->nextthink = level.time + 300;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 300
ADDI4
ASGNI4
line 115
;115:	ent->think = trigger_always_think;
ADDRFP4 0
INDIRP4
CNSTI4 696
ADDP4
ADDRGP4 trigger_always_think
ASGNP4
line 117
;116:#if ESCAPE_MODE	// JUHOX: set entity class
;117:	ent->entClass = GEC_trigger_always;
ADDRFP4 0
INDIRP4
CNSTI4 824
ADDP4
CNSTI4 14
ASGNI4
line 119
;118:#endif
;119:}
LABELV $117
endproc SP_trigger_always 0 0
export trigger_push_touch
proc trigger_push_touch 8 8
line 130
;120:
;121:
;122:/*
;123:==============================================================================
;124:
;125:trigger_push
;126:
;127:==============================================================================
;128:*/
;129:
;130:void trigger_push_touch (gentity_t *self, gentity_t *other, trace_t *trace ) {
line 142
;131:
;132:	// JUHOX: accept monsters on jump pads
;133:#if !MONSTER_MODE
;134:	if ( !other->client ) {
;135:		return;
;136:	}
;137:
;138:	BG_TouchJumpPad( &other->client->ps, &self->s );
;139:#else
;140:	playerState_t* ps;
;141:
;142:	ps = G_GetEntityPlayerState(other);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 143
;143:	if (ps) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $120
line 144
;144:		BG_TouchJumpPad(ps, &self->s);
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BG_TouchJumpPad
CALLV
pop
line 145
;145:	}
LABELV $120
line 147
;146:#endif
;147:}
LABELV $119
endproc trigger_push_touch 8 8
export AimAtTarget
proc AimAtTarget 72 8
line 157
;148:
;149:
;150:/*
;151:=================
;152:AimAtTarget
;153:
;154:Calculate origin2 so the target apogee will be hit
;155:=================
;156:*/
;157:void AimAtTarget( gentity_t *self ) {
line 163
;158:	gentity_t	*ent;
;159:	vec3_t		origin;
;160:	float		height, gravity, time, forward;
;161:	float		dist;
;162:
;163:	VectorAdd( self->r.absmin, self->r.absmax, origin );
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 36
INDIRP4
CNSTI4 464
ADDP4
INDIRF4
ADDRLP4 36
INDIRP4
CNSTI4 476
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 36
INDIRP4
CNSTI4 468
ADDP4
INDIRF4
ADDRLP4 36
INDIRP4
CNSTI4 480
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 40
INDIRP4
CNSTI4 472
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 484
ADDP4
INDIRF4
ADDF4
ASGNF4
line 164
;164:	VectorScale ( origin, 0.5, origin );
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 169
;165:
;166:#if !ESCAPE_MODE	// JUHOX: G_PickTarget() also needs to know the segment
;167:	ent = G_PickTarget( self->target );
;168:#else
;169:	ent = G_PickTarget(self->target, self->worldSegment - 1);
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 652
ADDP4
INDIRP4
ARGP4
ADDRLP4 44
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRLP4 48
ADDRGP4 G_PickTarget
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 48
INDIRP4
ASGNP4
line 171
;170:#endif
;171:	if ( !ent ) {
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $129
line 172
;172:		G_FreeEntity( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 173
;173:		return;
ADDRGP4 $122
JUMPV
LABELV $129
line 176
;174:	}
;175:
;176:	height = ent->s.origin[2] - origin[2];
ADDRLP4 28
ADDRLP4 12
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 181
;177:	// JUHOX: use g_gravity.integer instead of g_gravity.value
;178:#if 0
;179:	gravity = g_gravity.value;
;180:#else
;181:	gravity = g_gravity.integer;
ADDRLP4 24
ADDRGP4 g_gravity+12
INDIRI4
CVIF4 4
ASGNF4
line 183
;182:#endif
;183:	time = sqrt( height / ( .5 * gravity ) );
ADDRLP4 28
INDIRF4
ADDRLP4 24
INDIRF4
CNSTF4 1056964608
MULF4
DIVF4
ARGF4
ADDRLP4 52
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 52
INDIRF4
ASGNF4
line 184
;184:	if ( !time ) {
ADDRLP4 16
INDIRF4
CNSTF4 0
NEF4 $133
line 185
;185:		G_FreeEntity( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 186
;186:		return;
ADDRGP4 $122
JUMPV
LABELV $133
line 190
;187:	}
;188:
;189:	// set s.origin2 to the push velocity
;190:	VectorSubtract ( ent->s.origin, origin, self->s.origin2 );
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 108
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 191
;191:	self->s.origin2[2] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
CNSTF4 0
ASGNF4
line 192
;192:	dist = VectorNormalize( self->s.origin2);
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
ARGP4
ADDRLP4 56
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 32
ADDRLP4 56
INDIRF4
ASGNF4
line 194
;193:
;194:	forward = dist / time;
ADDRLP4 20
ADDRLP4 32
INDIRF4
ADDRLP4 16
INDIRF4
DIVF4
ASGNF4
line 195
;195:	VectorScale( self->s.origin2, forward, self->s.origin2 );
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 104
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ASGNF4
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 108
ADDP4
ADDRLP4 64
INDIRP4
CNSTI4 108
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ASGNF4
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 112
ADDP4
ADDRLP4 68
INDIRP4
CNSTI4 112
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ASGNF4
line 197
;196:
;197:	self->s.origin2[2] = time * gravity;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRLP4 16
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ASGNF4
line 198
;198:}
LABELV $122
endproc AimAtTarget 72 8
export SP_trigger_push
proc SP_trigger_push 8 4
line 205
;199:
;200:
;201:/*QUAKED trigger_push (.5 .5 .5) ?
;202:Must point at a target_position, which will be the apex of the leap.
;203:This will be client side predicted, unlike target_push
;204:*/
;205:void SP_trigger_push( gentity_t *self ) {
line 206
;206:	InitTrigger (self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 InitTrigger
CALLV
pop
line 207
;207:	self->r.contents |= CONTENTS_JUMPPAD;	// JUHOX: to make life easier for the "grenades using jumppads" feature
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 524288
BORI4
ASGNI4
line 210
;208:
;209:	// unlike other triggers, we need to send this one to the client
;210:	self->r.svFlags &= ~SVF_NOCLIENT;
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
CNSTI4 -2
BANDI4
ASGNI4
line 213
;211:
;212:	// make sure the client precaches this sound
;213:	G_SoundIndex("sound/world/jumppad.wav");
ADDRGP4 $138
ARGP4
ADDRGP4 G_SoundIndex
CALLI4
pop
line 215
;214:
;215:	self->s.eType = ET_PUSH_TRIGGER;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 8
ASGNI4
line 216
;216:	self->touch = trigger_push_touch;
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
ADDRGP4 trigger_push_touch
ASGNP4
line 217
;217:	self->think = AimAtTarget;
ADDRFP4 0
INDIRP4
CNSTI4 696
ADDP4
ADDRGP4 AimAtTarget
ASGNP4
line 218
;218:	self->nextthink = level.time + FRAMETIME;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 219
;219:	trap_LinkEntity (self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 221
;220:#if ESCAPE_MODE	// JUHOX: set entity class
;221:	self->entClass = GEC_trigger_push;
ADDRFP4 0
INDIRP4
CNSTI4 824
ADDP4
CNSTI4 16
ASGNI4
line 223
;222:#endif
;223:}
LABELV $137
endproc SP_trigger_push 8 4
export Use_target_push
proc Use_target_push 0 12
line 226
;224:
;225:
;226:void Use_target_push( gentity_t *self, gentity_t *other, gentity_t *activator ) {
line 227
;227:	if ( !activator->client ) {
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $141
line 228
;228:		return;
ADDRGP4 $140
JUMPV
LABELV $141
line 231
;229:	}
;230:
;231:	if ( activator->client->ps.pm_type != PM_NORMAL ) {
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $143
line 232
;232:		return;
ADDRGP4 $140
JUMPV
LABELV $143
line 234
;233:	}
;234:	if ( activator->client->ps.powerups[PW_FLIGHT] ) {
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
CNSTI4 0
EQI4 $145
line 235
;235:		return;
ADDRGP4 $140
JUMPV
LABELV $145
line 238
;236:	}
;237:
;238:	VectorCopy (self->s.origin2, activator->client->ps.velocity);
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 32
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
INDIRB
ASGNB 12
line 241
;239:
;240:	// play fly sound every 1.5 seconds
;241:	if ( activator->fly_sound_debounce_time < level.time ) {
ADDRFP4 8
INDIRP4
CNSTI4 728
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
GEI4 $147
line 242
;242:		activator->fly_sound_debounce_time = level.time + 1500;
ADDRFP4 8
INDIRP4
CNSTI4 728
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1500
ADDI4
ASGNI4
line 243
;243:		G_Sound( activator, CHAN_AUTO, self->noise_index );
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 796
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_Sound
CALLV
pop
line 244
;244:	}
LABELV $147
line 245
;245:}
LABELV $140
endproc Use_target_push 0 12
export SP_target_push
proc SP_target_push 24 8
line 252
;246:
;247:/*QUAKED target_push (.5 .5 .5) (-8 -8 -8) (8 8 8) bouncepad
;248:Pushes the activator in the direction.of angle, or towards a target apex.
;249:"speed"		defaults to 1000
;250:if "bouncepad", play bounce noise instead of windfly
;251:*/
;252:void SP_target_push( gentity_t *self ) {
line 253
;253:	if (!self->speed) {
ADDRFP4 0
INDIRP4
CNSTI4 676
ADDP4
INDIRF4
CNSTF4 0
NEF4 $152
line 254
;254:		self->speed = 1000;
ADDRFP4 0
INDIRP4
CNSTI4 676
ADDP4
CNSTF4 1148846080
ASGNF4
line 255
;255:	}
LABELV $152
line 256
;256:	G_SetMovedir (self->s.angles, self->s.origin2);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ARGP4
ADDRGP4 G_SetMovedir
CALLV
pop
line 257
;257:	VectorScale (self->s.origin2, self->speed, self->s.origin2);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 104
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 676
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 108
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 108
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 676
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 112
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 112
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 676
ADDP4
INDIRF4
MULF4
ASGNF4
line 259
;258:
;259:	if ( self->spawnflags & 1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $154
line 260
;260:		self->noise_index = G_SoundIndex("sound/world/jumppad.wav");
ADDRGP4 $138
ARGP4
ADDRLP4 16
ADDRGP4 G_SoundIndex
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 796
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 261
;261:	} else {
ADDRGP4 $155
JUMPV
LABELV $154
line 262
;262:		self->noise_index = G_SoundIndex("sound/misc/windfly.wav");
ADDRGP4 $156
ARGP4
ADDRLP4 16
ADDRGP4 G_SoundIndex
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 796
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 263
;263:	}
LABELV $155
line 264
;264:	if ( self->target ) {
ADDRFP4 0
INDIRP4
CNSTI4 652
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $157
line 265
;265:		VectorCopy( self->s.origin, self->r.absmin );
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 464
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 266
;266:		VectorCopy( self->s.origin, self->r.absmax );
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 476
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 267
;267:		self->think = AimAtTarget;
ADDRFP4 0
INDIRP4
CNSTI4 696
ADDP4
ADDRGP4 AimAtTarget
ASGNP4
line 268
;268:		self->nextthink = level.time + FRAMETIME;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 269
;269:	}
LABELV $157
line 270
;270:	self->use = Use_target_push;
ADDRFP4 0
INDIRP4
CNSTI4 712
ADDP4
ADDRGP4 Use_target_push
ASGNP4
line 272
;271:#if ESCAPE_MODE	// JUHOX: set entity class
;272:	self->entClass = GEC_target_push;
ADDRFP4 0
INDIRP4
CNSTI4 824
ADDP4
CNSTI4 31
ASGNI4
line 274
;273:#endif
;274:}
LABELV $151
endproc SP_target_push 24 8
export trigger_teleporter_touch
proc trigger_teleporter_touch 16 12
line 284
;275:
;276:/*
;277:==============================================================================
;278:
;279:trigger_teleport
;280:
;281:==============================================================================
;282:*/
;283:
;284:void trigger_teleporter_touch (gentity_t *self, gentity_t *other, trace_t *trace ) {
line 304
;285:	gentity_t	*dest;
;286:
;287:#if !MONSTER_MODE	// JUHOX: let trigger_teleport_touch() accept monsters too
;288:	if ( !other->client ) {
;289:		return;
;290:	}
;291:	if ( other->client->ps.pm_type == PM_DEAD ) {
;292:		return;
;293:	}
;294:	// Spectators only?
;295:	if ( ( self->spawnflags & 1 ) && 
;296:#if 0	// JUHOX: also accept dead spectating players
;297:		other->client->sess.sessionTeam != TEAM_SPECTATOR ) {
;298:#else
;299:		other->client->ps.pm_type != PM_SPECTATOR) {
;300:#endif
;301:		return;
;302:	}
;303:#else	// MONSTER_MODE
;304:	{
line 307
;305:		playerState_t* ps;
;306:
;307:		ps = G_GetEntityPlayerState(other);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 308
;308:		if (!ps) return;
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $161
ADDRGP4 $160
JUMPV
LABELV $161
line 309
;309:		if (ps->pm_type == PM_DEAD) return;
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $163
ADDRGP4 $160
JUMPV
LABELV $163
line 310
;310:		if ((self->spawnflags & 1) && ps->pm_type != PM_SPECTATOR) return;
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $165
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $165
ADDRGP4 $160
JUMPV
LABELV $165
line 311
;311:	}
line 318
;312:#endif
;313:
;314:
;315:#if !ESCAPE_MODE	// JUHOX: G_PickTarget() also needs to know the segment
;316:	dest = 	G_PickTarget( self->target );
;317:#else
;318:	dest = G_PickTarget(self->target, self->worldSegment - 1);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 652
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRLP4 8
ADDRGP4 G_PickTarget
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 320
;319:#endif
;320:	if (!dest) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $167
line 321
;321:		G_Printf ("Couldn't find teleporter destination\n");
ADDRGP4 $169
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 322
;322:		return;
ADDRGP4 $160
JUMPV
LABELV $167
line 325
;323:	}
;324:
;325:	TeleportPlayer( other, dest->s.origin, dest->s.angles );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRGP4 TeleportPlayer
CALLV
pop
line 326
;326:}
LABELV $160
endproc trigger_teleporter_touch 16 12
export SP_trigger_teleport
proc SP_trigger_teleport 8 4
line 337
;327:
;328:
;329:/*QUAKED trigger_teleport (.5 .5 .5) ? SPECTATOR
;330:Allows client side prediction of teleportation events.
;331:Must point at a target_position, which will be the teleport destination.
;332:
;333:If spectator is set, only spectators can use this teleport
;334:Spectator teleporters are not normally placed in the editor, but are created
;335:automatically near doors to allow spectators to move through them
;336:*/
;337:void SP_trigger_teleport( gentity_t *self ) {
line 338
;338:	InitTrigger (self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 InitTrigger
CALLV
pop
line 339
;339:	self->r.contents |= CONTENTS_TELEPORTER;	// JUHOX: to make life easier for the "missiles using teleporters" feature
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 262144
BORI4
ASGNI4
line 343
;340:
;341:	// unlike other triggers, we need to send this one to the client
;342:	// unless is a spectator trigger
;343:	if ( self->spawnflags & 1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $171
line 344
;344:		self->r.svFlags |= SVF_NOCLIENT;
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
CNSTI4 1
BORI4
ASGNI4
line 345
;345:	} else {
ADDRGP4 $172
JUMPV
LABELV $171
line 346
;346:		self->r.svFlags &= ~SVF_NOCLIENT;
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
CNSTI4 -2
BANDI4
ASGNI4
line 347
;347:	}
LABELV $172
line 350
;348:
;349:	// make sure the client precaches this sound
;350:	G_SoundIndex("sound/world/jumppad.wav");
ADDRGP4 $138
ARGP4
ADDRGP4 G_SoundIndex
CALLI4
pop
line 352
;351:
;352:	self->s.eType = ET_TELEPORT_TRIGGER;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 9
ASGNI4
line 353
;353:	self->touch = trigger_teleporter_touch;
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
ADDRGP4 trigger_teleporter_touch
ASGNP4
line 355
;354:
;355:	trap_LinkEntity (self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 357
;356:#if ESCAPE_MODE	// JUHOX: set entity class
;357:	self->entClass = GEC_trigger_teleport;
ADDRFP4 0
INDIRP4
CNSTI4 824
ADDP4
CNSTI4 17
ASGNI4
line 359
;358:#endif
;359:}
LABELV $170
endproc SP_trigger_teleport 8 4
export hurt_use
proc hurt_use 0 4
line 382
;360:
;361:
;362:/*
;363:==============================================================================
;364:
;365:trigger_hurt
;366:
;367:==============================================================================
;368:*/
;369:
;370:/*QUAKED trigger_hurt (.5 .5 .5) ? START_OFF - SILENT NO_PROTECTION SLOW
;371:Any entity that touches this will be hurt.
;372:It does dmg points of damage each server frame
;373:Targeting the trigger will toggle its on / off state.
;374:
;375:SILENT			supresses playing the sound
;376:SLOW			changes the damage rate to once per second
;377:NO_PROTECTION	*nothing* stops the damage
;378:
;379:"dmg"			default 5 (whole numbers only)
;380:
;381:*/
;382:void hurt_use( gentity_t *self, gentity_t *other, gentity_t *activator ) {
line 383
;383:	if ( self->r.linked ) {
ADDRFP4 0
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
CNSTI4 0
EQI4 $174
line 384
;384:		trap_UnlinkEntity( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 385
;385:	} else {
ADDRGP4 $175
JUMPV
LABELV $174
line 386
;386:		trap_LinkEntity( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 387
;387:	}
LABELV $175
line 388
;388:}
LABELV $173
endproc hurt_use 0 4
export hurt_touch
proc hurt_touch 8 32
line 390
;389:
;390:void hurt_touch( gentity_t *self, gentity_t *other, trace_t *trace ) {
line 393
;391:	int		dflags;
;392:
;393:	if ( !other->takedamage ) {
ADDRFP4 4
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
CNSTI4 0
NEI4 $177
line 394
;394:		return;
ADDRGP4 $176
JUMPV
LABELV $177
line 397
;395:	}
;396:
;397:	if ( self->timestamp > level.time ) {
ADDRFP4 0
INDIRP4
CNSTI4 644
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $179
line 398
;398:		return;
ADDRGP4 $176
JUMPV
LABELV $179
line 401
;399:	}
;400:
;401:	if ( self->spawnflags & 16 ) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $182
line 402
;402:		self->timestamp = level.time + 1000;
ADDRFP4 0
INDIRP4
CNSTI4 644
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 403
;403:	} else {
ADDRGP4 $183
JUMPV
LABELV $182
line 404
;404:		self->timestamp = level.time + FRAMETIME;
ADDRFP4 0
INDIRP4
CNSTI4 644
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 405
;405:	}
LABELV $183
line 408
;406:
;407:	// play sound
;408:	if ( !(self->spawnflags & 4) ) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
NEI4 $186
line 409
;409:		G_Sound( other, CHAN_AUTO, self->noise_index );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 796
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_Sound
CALLV
pop
line 410
;410:	}
LABELV $186
line 412
;411:
;412:	if (self->spawnflags & 8)
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $188
line 413
;413:		dflags = DAMAGE_NO_PROTECTION;
ADDRLP4 0
CNSTI4 8
ASGNI4
ADDRGP4 $189
JUMPV
LABELV $188
line 415
;414:	else
;415:		dflags = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $189
line 416
;416:	G_Damage (other, self, self, NULL, NULL, self->damage, dflags, MOD_TRIGGER_HURT);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 744
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 27
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 417
;417:}
LABELV $176
endproc hurt_touch 8 32
export SP_trigger_hurt
proc SP_trigger_hurt 4 4
line 419
;418:
;419:void SP_trigger_hurt( gentity_t *self ) {
line 420
;420:	InitTrigger (self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 InitTrigger
CALLV
pop
line 422
;421:
;422:	self->noise_index = G_SoundIndex( "sound/world/electro.wav" );
ADDRGP4 $191
ARGP4
ADDRLP4 0
ADDRGP4 G_SoundIndex
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 796
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 423
;423:	self->touch = hurt_touch;
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
ADDRGP4 hurt_touch
ASGNP4
line 425
;424:
;425:	if ( !self->damage ) {
ADDRFP4 0
INDIRP4
CNSTI4 744
ADDP4
INDIRI4
CNSTI4 0
NEI4 $192
line 426
;426:		self->damage = 5;
ADDRFP4 0
INDIRP4
CNSTI4 744
ADDP4
CNSTI4 5
ASGNI4
line 427
;427:	}
LABELV $192
line 429
;428:
;429:	self->r.contents = CONTENTS_TRIGGER;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 1073741824
ASGNI4
line 431
;430:
;431:	if ( self->spawnflags & 2 ) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $194
line 432
;432:		self->use = hurt_use;
ADDRFP4 0
INDIRP4
CNSTI4 712
ADDP4
ADDRGP4 hurt_use
ASGNP4
line 433
;433:	}
LABELV $194
line 436
;434:
;435:	// link in to the world if starting active
;436:	if ( ! (self->spawnflags & 1) ) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $196
line 437
;437:		trap_LinkEntity (self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 438
;438:	}
LABELV $196
line 440
;439:#if ESCAPE_MODE	// JUHOX: set entity class
;440:	self->entClass = GEC_trigger_hurt;
ADDRFP4 0
INDIRP4
CNSTI4 824
ADDP4
CNSTI4 18
ASGNI4
line 442
;441:#endif
;442:}
LABELV $190
endproc SP_trigger_hurt 4 4
export func_timer_think
proc func_timer_think 12 8
line 465
;443:
;444:
;445:/*
;446:==============================================================================
;447:
;448:timer
;449:
;450:==============================================================================
;451:*/
;452:
;453:
;454:/*QUAKED func_timer (0.3 0.1 0.6) (-8 -8 -8) (8 8 8) START_ON
;455:This should be renamed trigger_timer...
;456:Repeatedly fires its targets.
;457:Can be turned on or off by using.
;458:
;459:"wait"			base time between triggering all targets, default is 1
;460:"random"		wait variance, default is 0
;461:so, the basic time between firing is a random time between
;462:(wait - random) and (wait + random)
;463:
;464:*/
;465:void func_timer_think( gentity_t *self ) {
line 466
;466:	G_UseTargets (self, self->activator);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_UseTargets
CALLV
pop
line 468
;467:	// set time before next firing
;468:	self->nextthink = level.time + 1000 * ( self->wait + crandom() * self->random );
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
CNSTI4 692
ADDP4
ADDRGP4 level+32
INDIRI4
CVIF4 4
ADDRLP4 8
INDIRP4
CNSTI4 800
ADDP4
INDIRF4
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
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRF4
MULF4
ADDF4
CNSTF4 1148846080
MULF4
ADDF4
CVFI4 4
ASGNI4
line 469
;469:}
LABELV $198
endproc func_timer_think 12 8
export func_timer_use
proc func_timer_use 0 4
line 471
;470:
;471:void func_timer_use( gentity_t *self, gentity_t *other, gentity_t *activator ) {
line 472
;472:	self->activator = activator;
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
ADDRFP4 8
INDIRP4
ASGNP4
line 475
;473:
;474:	// if on, turn it off
;475:	if ( self->nextthink ) {
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
INDIRI4
CNSTI4 0
EQI4 $201
line 476
;476:		self->nextthink = 0;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
CNSTI4 0
ASGNI4
line 477
;477:		return;
ADDRGP4 $200
JUMPV
LABELV $201
line 481
;478:	}
;479:
;480:	// turn it on
;481:	func_timer_think (self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 func_timer_think
CALLV
pop
line 482
;482:}
LABELV $200
endproc func_timer_use 0 4
export SP_func_timer
proc SP_func_timer 12 12
line 484
;483:
;484:void SP_func_timer( gentity_t *self ) {
line 485
;485:	G_SpawnFloat( "random", "1", &self->random);
ADDRGP4 $111
ARGP4
ADDRGP4 $204
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 486
;486:	G_SpawnFloat( "wait", "1", &self->wait );
ADDRGP4 $109
ARGP4
ADDRGP4 $204
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 800
ADDP4
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 488
;487:
;488:	self->use = func_timer_use;
ADDRFP4 0
INDIRP4
CNSTI4 712
ADDP4
ADDRGP4 func_timer_use
ASGNP4
line 489
;489:	self->think = func_timer_think;
ADDRFP4 0
INDIRP4
CNSTI4 696
ADDP4
ADDRGP4 func_timer_think
ASGNP4
line 491
;490:
;491:	if ( self->random >= self->wait ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 800
ADDP4
INDIRF4
LTF4 $205
line 492
;492:		self->random = self->wait - FRAMETIME;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 804
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 800
ADDP4
INDIRF4
CNSTF4 1120403456
SUBF4
ASGNF4
line 493
;493:		G_Printf( "func_timer at %s has random >= wait\n", vtos( self->s.origin ) );
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 8
ADDRGP4 vtos
CALLP4
ASGNP4
ADDRGP4 $207
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 494
;494:	}
LABELV $205
line 496
;495:
;496:	if ( self->spawnflags & 1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $208
line 497
;497:		self->nextthink = level.time + FRAMETIME;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 498
;498:		self->activator = self;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 776
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 499
;499:	}
LABELV $208
line 501
;500:
;501:	self->r.svFlags = SVF_NOCLIENT;
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 1
ASGNI4
line 503
;502:#if ESCAPE_MODE	// JUHOX: set entity class
;503:	self->entClass = GEC_func_timer;
ADDRFP4 0
INDIRP4
CNSTI4 824
ADDP4
CNSTI4 13
ASGNI4
line 505
;504:#endif
;505:}
LABELV $203
endproc SP_func_timer 12 12
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
import DeathmatchScoreboardMessage
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
LABELV $207
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 114
byte 1 97
byte 1 110
byte 1 100
byte 1 111
byte 1 109
byte 1 32
byte 1 62
byte 1 61
byte 1 32
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $204
byte 1 49
byte 1 0
align 1
LABELV $191
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 47
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 114
byte 1 111
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $169
byte 1 67
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 102
byte 1 105
byte 1 110
byte 1 100
byte 1 32
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 100
byte 1 101
byte 1 115
byte 1 116
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $156
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 119
byte 1 105
byte 1 110
byte 1 100
byte 1 102
byte 1 108
byte 1 121
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $138
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 47
byte 1 106
byte 1 117
byte 1 109
byte 1 112
byte 1 112
byte 1 97
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $115
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 95
byte 1 109
byte 1 117
byte 1 108
byte 1 116
byte 1 105
byte 1 112
byte 1 108
byte 1 101
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 114
byte 1 97
byte 1 110
byte 1 100
byte 1 111
byte 1 109
byte 1 32
byte 1 62
byte 1 61
byte 1 32
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $112
byte 1 48
byte 1 0
align 1
LABELV $111
byte 1 114
byte 1 97
byte 1 110
byte 1 100
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $110
byte 1 48
byte 1 46
byte 1 53
byte 1 0
align 1
LABELV $109
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 0
