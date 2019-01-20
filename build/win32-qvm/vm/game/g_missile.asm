export G_BounceMissile
code
proc G_BounceMissile 48 12
file "..\..\..\..\code\game\g_missile.c"
line 14
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:#include "g_local.h"
;4:
;5:#define	MISSILE_PRESTEP_TIME	50
;6:
;7:/*
;8:================
;9:G_BounceMissile
;10:
;11:================
;12:*/
;13:void trigger_push_touch(gentity_t *self, gentity_t *other, trace_t *trace);	// JUHOX
;14:void G_BounceMissile( gentity_t *ent, trace_t *trace ) {
line 20
;15:	vec3_t	velocity;
;16:	float	dot;
;17:	int		hitTime;
;18:
;19:	// reflect the velocity on the trace plane
;20:	hitTime = level.previousTime + ( level.time - level.previousTime ) * trace->fraction;
ADDRLP4 16
ADDRGP4 level+36
INDIRI4
CVIF4 4
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+36
INDIRI4
SUBI4
CVIF4 4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 21
;21:	BG_EvaluateTrajectoryDelta( &ent->s.pos, hitTime, velocity );
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BG_EvaluateTrajectoryDelta
CALLV
pop
line 22
;22:	dot = DotProduct( velocity, trace->plane.normal );
ADDRLP4 20
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 0
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
MULF4
ADDRLP4 0+4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+8
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 23
;23:	VectorMA( velocity, -2*dot, trace->plane.normal, ent->s.pos.trDelta );
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 0
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
CNSTF4 3221225472
MULF4
MULF4
ADDF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 0+4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
CNSTF4 3221225472
MULF4
MULF4
ADDF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 0+8
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
CNSTF4 3221225472
MULF4
MULF4
ADDF4
ASGNF4
line 27
;24:
;25:	// JUHOX: bounce event now done in G_BounceMissile() to add volume parameter for monster seeds
;26:#if MONSTER_MODE
;27:	if (ent->s.weapon == WP_MONSTER_LAUNCHER) {
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 11
NEI4 $95
line 30
;28:		float sqrspeed;
;29:
;30:		sqrspeed = VectorLengthSquared(ent->s.pos.trDelta);
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ARGP4
ADDRLP4 28
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 24
ADDRLP4 28
INDIRF4
ASGNF4
line 32
;31:
;32:		if (sqrspeed >= 160*160) {
ADDRLP4 24
INDIRF4
CNSTF4 1187512320
LTF4 $97
line 33
;33:			G_AddEvent(ent, EV_GRENADE_BOUNCE, 0);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 44
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 34
;34:		}
ADDRGP4 $96
JUMPV
LABELV $97
line 35
;35:		else if (sqrspeed >= 80*80) {
ADDRLP4 24
INDIRF4
CNSTF4 1170735104
LTF4 $99
line 36
;36:			G_AddEvent(ent, EV_GRENADE_BOUNCE, 1);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 44
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 37
;37:		}
ADDRGP4 $96
JUMPV
LABELV $99
line 38
;38:		else if (sqrspeed >= 40*40) {
ADDRLP4 24
INDIRF4
CNSTF4 1153957888
LTF4 $96
line 39
;39:			G_AddEvent(ent, EV_GRENADE_BOUNCE, 2);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 44
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 40
;40:		}
line 41
;41:	}
ADDRGP4 $96
JUMPV
LABELV $95
line 42
;42:	else {
line 43
;43:		G_AddEvent(ent, EV_GRENADE_BOUNCE, 0);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 44
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 44
;44:	}
LABELV $96
line 47
;45:#endif
;46:
;47:	if ( ent->s.eFlags & EF_BOUNCE_HALF ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $103
line 48
;48:		VectorScale( ent->s.pos.trDelta, 0.65, ent->s.pos.trDelta );
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 24
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
CNSTF4 1059481190
MULF4
ASGNF4
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 28
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
CNSTF4 1059481190
MULF4
ASGNF4
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 32
INDIRP4
CNSTI4 44
ADDP4
INDIRF4
CNSTF4 1059481190
MULF4
ASGNF4
line 50
;49:		// check for stop
;50:		if ( trace->plane.normal[2] > 0.2 && VectorLength( ent->s.pos.trDelta ) < 40 ) {
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
CNSTF4 1045220557
LEF4 $105
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ARGP4
ADDRLP4 36
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 36
INDIRF4
CNSTF4 1109393408
GEF4 $105
line 51
;51:			G_SetOrigin( ent, trace->endpos );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 52
;52:			ent->s.time = level.time / 4;	// JUHOX: set rotation on stop position (depends on original Q3 code in CG_Missile())
ADDRFP4 0
INDIRP4
CNSTI4 84
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 4
DIVI4
ASGNI4
line 55
;53:		// JUHOX: monster seed impact code
;54:#if MONSTER_MODE
;55:			if (ent->s.weapon == WP_MONSTER_LAUNCHER && ent->think) {
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 11
NEI4 $87
ADDRLP4 40
INDIRP4
CNSTI4 696
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $87
line 56
;56:				ent->think(ent);
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRLP4 44
INDIRP4
CNSTI4 696
ADDP4
INDIRP4
CALLV
pop
line 57
;57:			}
line 59
;58:#endif
;59:			return;
ADDRGP4 $87
JUMPV
LABELV $105
line 61
;60:		}
;61:	}
LABELV $103
line 63
;62:
;63:	VectorAdd( ent->r.currentOrigin, trace->plane.normal, ent->r.currentOrigin);
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 24
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 492
ADDP4
ADDRLP4 28
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 496
ADDP4
ADDRLP4 32
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDF4
ASGNF4
line 64
;64:	VectorCopy( ent->r.currentOrigin, ent->s.pos.trBase );
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 36
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 65
;65:	ent->s.pos.trTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 69
;66:
;67:	// JUHOX: in certain cases the jump pad trigger may push the grenade against the jump pad, so re-trigger
;68:#if 1
;69:	if (ent->s.eType == ET_MISSILE /*&& ent->s.weapon == WP_GRENADE_LAUNCHER*/) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $111
line 70
;70:		if (ent->count >= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 764
ADDP4
INDIRI4
CNSTI4 0
LTI4 $113
line 73
;71:			gentity_t* trigger;
;72:
;73:			trigger = &g_entities[ent->count];
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 764
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 75
;74:			if (
;75:				trigger->inuse &&
ADDRLP4 44
ADDRLP4 40
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
EQI4 $115
ADDRLP4 44
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 8
NEI4 $115
ADDRLP4 44
INDIRP4
CNSTI4 708
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 trigger_push_touch
CVPU4 4
NEU4 $115
line 78
;76:				trigger->s.eType == ET_PUSH_TRIGGER &&
;77:				trigger->touch == trigger_push_touch
;78:			) {
line 79
;79:				VectorCopy(trigger->s.origin2, ent->s.pos.trDelta);
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 40
INDIRP4
CNSTI4 104
ADDP4
INDIRB
ASGNB 12
line 80
;80:			}
LABELV $115
line 81
;81:		}
LABELV $113
line 82
;82:	}
LABELV $111
line 84
;83:#endif
;84:}
LABELV $87
endproc G_BounceMissile 48 12
bss
align 4
LABELV $118
skip 96
code
proc CreateBFGCloud 140 28
line 93
;85:
;86:
;87:/*
;88:================
;89:JUHOX: CreateBFGCloud
;90:================
;91:*/
;92:#define BFGCLOUD_SIZE 24
;93:static void CreateBFGCloud(gentity_t* seed) {
line 97
;94:	static gentity_t* cloud[BFGCLOUD_SIZE];
;95:	int cloudSize;
;96:
;97:	if (seed->s.weapon != WP_BFG) return;
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 9
EQI4 $119
ADDRGP4 $117
JUMPV
LABELV $119
line 99
;98:
;99:	cloud[0] = seed;
ADDRGP4 $118
ADDRFP4 0
INDIRP4
ASGNP4
line 100
;100:	cloudSize = 1;
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $122
JUMPV
LABELV $121
line 101
;101:	while (cloudSize < BFGCLOUD_SIZE) {
line 107
;102:		gentity_t* ent;
;103:		gentity_t* parent;
;104:		trace_t tr;
;105:		vec3_t angles, dir, origin;
;106:
;107:		parent = cloud[rand() % cloudSize];
ADDRLP4 104
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 104
INDIRI4
ADDRLP4 0
INDIRI4
MODI4
CNSTI4 2
LSHI4
ADDRGP4 $118
ADDP4
INDIRP4
ASGNP4
line 109
;108:
;109:		angles[0] = rand() % 360;
ADDRLP4 108
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 108
INDIRI4
CNSTI4 360
MODI4
CVIF4 4
ASGNF4
line 110
;110:		angles[1] = rand() % 360;
ADDRLP4 112
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12+4
ADDRLP4 112
INDIRI4
CNSTI4 360
MODI4
CVIF4 4
ASGNF4
line 111
;111:		angles[2] = rand() % 360;
ADDRLP4 116
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12+8
ADDRLP4 116
INDIRI4
CNSTI4 360
MODI4
CVIF4 4
ASGNF4
line 112
;112:		AngleVectors(angles, dir, NULL, NULL);
ADDRLP4 12
ARGP4
ADDRLP4 24
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 113
;113:		VectorMA(parent->r.currentOrigin, seed->splashRadius, dir, origin);
ADDRLP4 124
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
ADDRLP4 8
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 24
INDIRF4
ADDRLP4 124
INDIRP4
CNSTI4 752
ADDP4
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
ADDRLP4 36+4
ADDRLP4 8
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 24+4
INDIRF4
ADDRLP4 124
INDIRP4
CNSTI4 752
ADDP4
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
ADDRLP4 36+8
ADDRLP4 8
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRLP4 24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 752
ADDP4
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
line 114
;114:		trap_Trace(&tr, parent->r.currentOrigin, NULL, NULL, origin, -1, MASK_SHOT);
ADDRLP4 48
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 36
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 116
;115:
;116:		ent = G_TempEntity(tr.endpos, EV_MISSILE_MISS);
ADDRLP4 48+12
ARGP4
CNSTI4 52
ARGI4
ADDRLP4 128
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 128
INDIRP4
ASGNP4
line 117
;117:		if (!ent) return;
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $131
ADDRGP4 $117
JUMPV
LABELV $131
line 118
;118:		ent->s.weapon = WP_BFG;
ADDRLP4 4
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 9
ASGNI4
line 127
;119:		/*
;120:		if (tr.fraction < 1.0) {
;121:			ent->s.eventParm = DirToByte(tr.plane.normal);
;122:		}
;123:		else {
;124:			ent->s.eventParm = DirToByte(axisDefault[2]);
;125:		}
;126:		*/
;127:		ent->s.eventParm = -1;
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 -1
ASGNI4
line 128
;128:		cloud[cloudSize++] = ent;
ADDRLP4 132
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 0
ADDRLP4 132
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $118
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 130
;129:
;130:		G_RadiusDamage(tr.endpos, seed->parent, seed->splashDamage, seed->splashRadius, NULL, seed->splashMethodOfDeath);
ADDRLP4 48+12
ARGP4
ADDRLP4 136
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 136
INDIRP4
CNSTI4 604
ADDP4
INDIRP4
ARGP4
ADDRLP4 136
INDIRP4
CNSTI4 748
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 136
INDIRP4
CNSTI4 752
ADDP4
INDIRI4
CVIF4 4
ARGF4
CNSTP4 0
ARGP4
ADDRLP4 136
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_RadiusDamage
CALLI4
pop
line 131
;131:	}
LABELV $122
line 101
ADDRLP4 0
INDIRI4
CNSTI4 24
LTI4 $121
line 132
;132:}
LABELV $117
endproc CreateBFGCloud 140 28
export G_ExplodeMissile
proc G_ExplodeMissile 44 24
line 142
;133:
;134:
;135:/*
;136:================
;137:G_ExplodeMissile
;138:
;139:Explode a missile without an impact
;140:================
;141:*/
;142:void G_ExplodeMissile( gentity_t *ent ) {
line 146
;143:	vec3_t		dir;
;144:	vec3_t		origin;
;145:
;146:	BG_EvaluateTrajectory( &ent->s.pos, level.time, origin );
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 level+32
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 147
;147:	SnapVector( origin );
ADDRLP4 0
ADDRLP4 0
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 148
;148:	G_SetOrigin( ent, origin );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 151
;149:
;150:	// we don't have a valid direction, so just point straight up
;151:	dir[0] = dir[1] = 0;
ADDRLP4 24
CNSTF4 0
ASGNF4
ADDRLP4 12+4
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 12
ADDRLP4 24
INDIRF4
ASGNF4
line 152
;152:	dir[2] = 1;
ADDRLP4 12+8
CNSTF4 1065353216
ASGNF4
line 154
;153:
;154:	ent->s.eType = ET_GENERAL;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 0
ASGNI4
line 155
;155:	G_AddEvent( ent, EV_MISSILE_MISS, DirToByte( dir ) );
ADDRLP4 12
ARGP4
ADDRLP4 28
ADDRGP4 DirToByte
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 52
ARGI4
ADDRLP4 28
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 157
;156:
;157:	ent->freeAfterEvent = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 560
ADDP4
CNSTI4 1
ASGNI4
line 160
;158:
;159:	// splash damage
;160:	if ( ent->splashDamage ) {
ADDRFP4 0
INDIRP4
CNSTI4 748
ADDP4
INDIRI4
CNSTI4 0
EQI4 $142
line 161
;161:		if( G_RadiusDamage( ent->r.currentOrigin, ent->parent, ent->splashDamage, ent->splashRadius, ent
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 32
INDIRP4
CNSTI4 604
ADDP4
INDIRP4
ARGP4
ADDRLP4 32
INDIRP4
CNSTI4 748
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 32
INDIRP4
CNSTI4 752
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 32
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 G_RadiusDamage
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $144
line 162
;162:			, ent->splashMethodOfDeath ) ) {
line 163
;163:			g_entities[ent->r.ownerNum].client->accuracy_hits++;
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 812
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 164
;164:		}
LABELV $144
line 165
;165:	}
LABELV $142
line 167
;166:
;167:	trap_LinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 168
;168:	CreateBFGCloud(ent);	// JUHOX
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CreateBFGCloud
CALLV
pop
line 169
;169:}
LABELV $134
endproc G_ExplodeMissile 44 24
export G_MissileImpact
proc G_MissileImpact 68 32
line 346
;170:
;171:
;172:#ifdef MISSIONPACK
;173:/*
;174:================
;175:ProximityMine_Explode
;176:================
;177:*/
;178:static void ProximityMine_Explode( gentity_t *mine ) {
;179:	G_ExplodeMissile( mine );
;180:	// if the prox mine has a trigger free it
;181:	if (mine->activator) {
;182:		G_FreeEntity(mine->activator);
;183:		mine->activator = NULL;
;184:	}
;185:}
;186:
;187:/*
;188:================
;189:ProximityMine_Die
;190:================
;191:*/
;192:static void ProximityMine_Die( gentity_t *ent, gentity_t *inflictor, gentity_t *attacker, int damage, int mod ) {
;193:	ent->think = ProximityMine_Explode;
;194:	ent->nextthink = level.time + 1;
;195:}
;196:
;197:/*
;198:================
;199:ProximityMine_Trigger
;200:================
;201:*/
;202:void ProximityMine_Trigger( gentity_t *trigger, gentity_t *other, trace_t *trace ) {
;203:	vec3_t		v;
;204:	gentity_t	*mine;
;205:
;206:	if( !other->client ) {
;207:		return;
;208:	}
;209:
;210:	// trigger is a cube, do a distance test now to act as if it's a sphere
;211:	VectorSubtract( trigger->s.pos.trBase, other->s.pos.trBase, v );
;212:	if( VectorLength( v ) > trigger->parent->splashRadius ) {
;213:		return;
;214:	}
;215:
;216:
;217:	if ( g_gametype.integer >= GT_TEAM ) {
;218:		// don't trigger same team mines
;219:		if (trigger->parent->s.generic1 == other->client->sess.sessionTeam) {
;220:			return;
;221:		}
;222:	}
;223:
;224:	// ok, now check for ability to damage so we don't get triggered thru walls, closed doors, etc...
;225:	if( !CanDamage( other, trigger->s.pos.trBase ) ) {
;226:		return;
;227:	}
;228:
;229:	// trigger the mine!
;230:	mine = trigger->parent;
;231:	mine->s.loopSound = 0;
;232:	G_AddEvent( mine, EV_PROXIMITY_MINE_TRIGGER, 0 );
;233:	mine->nextthink = level.time + 500;
;234:
;235:	G_FreeEntity( trigger );
;236:}
;237:
;238:/*
;239:================
;240:ProximityMine_Activate
;241:================
;242:*/
;243:static void ProximityMine_Activate( gentity_t *ent ) {
;244:	gentity_t	*trigger;
;245:	float		r;
;246:
;247:	ent->think = ProximityMine_Explode;
;248:	ent->nextthink = level.time + g_proxMineTimeout.integer;
;249:
;250:	ent->takedamage = qtrue;
;251:	ent->health = 1;
;252:	ent->die = ProximityMine_Die;
;253:
;254:	ent->s.loopSound = G_SoundIndex( "sound/weapons/proxmine/wstbtick.wav" );
;255:
;256:	// build the proximity trigger
;257:	trigger = G_Spawn ();
;258:
;259:	trigger->classname = "proxmine_trigger";
;260:
;261:	r = ent->splashRadius;
;262:	VectorSet( trigger->r.mins, -r, -r, -r );
;263:	VectorSet( trigger->r.maxs, r, r, r );
;264:
;265:	G_SetOrigin( trigger, ent->s.pos.trBase );
;266:
;267:	trigger->parent = ent;
;268:	trigger->r.contents = CONTENTS_TRIGGER;
;269:	trigger->touch = ProximityMine_Trigger;
;270:
;271:	trap_LinkEntity (trigger);
;272:
;273:	// set pointer to trigger so the entity can be freed when the mine explodes
;274:	ent->activator = trigger;
;275:}
;276:
;277:/*
;278:================
;279:ProximityMine_ExplodeOnPlayer
;280:================
;281:*/
;282:static void ProximityMine_ExplodeOnPlayer( gentity_t *mine ) {
;283:	gentity_t	*player;
;284:
;285:	player = mine->enemy;
;286:	player->client->ps.eFlags &= ~EF_TICKING;
;287:
;288:	if ( player->client->invulnerabilityTime > level.time ) {
;289:		G_Damage( player, mine->parent, mine->parent, vec3_origin, mine->s.origin, 1000, DAMAGE_NO_KNOCKBACK, MOD_JUICED );
;290:		player->client->invulnerabilityTime = 0;
;291:		G_TempEntity( player->client->ps.origin, EV_JUICED );
;292:	}
;293:	else {
;294:		G_SetOrigin( mine, player->s.pos.trBase );
;295:		// make sure the explosion gets to the client
;296:		mine->r.svFlags &= ~SVF_NOCLIENT;
;297:		mine->splashMethodOfDeath = MOD_PROXIMITY_MINE;
;298:		G_ExplodeMissile( mine );
;299:	}
;300:}
;301:
;302:/*
;303:================
;304:ProximityMine_Player
;305:================
;306:*/
;307:static void ProximityMine_Player( gentity_t *mine, gentity_t *player ) {
;308:	if( mine->s.eFlags & EF_NODRAW ) {
;309:		return;
;310:	}
;311:
;312:	G_AddEvent( mine, EV_PROXIMITY_MINE_STICK, 0 );
;313:
;314:	if( player->s.eFlags & EF_TICKING ) {
;315:		player->activator->splashDamage += mine->splashDamage;
;316:		player->activator->splashRadius *= 1.50;
;317:		mine->think = G_FreeEntity;
;318:		mine->nextthink = level.time;
;319:		return;
;320:	}
;321:
;322:	player->client->ps.eFlags |= EF_TICKING;
;323:	player->activator = mine;
;324:
;325:	mine->s.eFlags |= EF_NODRAW;
;326:	mine->r.svFlags |= SVF_NOCLIENT;
;327:	mine->s.pos.trType = TR_LINEAR;
;328:	VectorClear( mine->s.pos.trDelta );
;329:
;330:	mine->enemy = player;
;331:	mine->think = ProximityMine_ExplodeOnPlayer;
;332:	if ( player->client->invulnerabilityTime > level.time ) {
;333:		mine->nextthink = level.time + 2 * 1000;
;334:	}
;335:	else {
;336:		mine->nextthink = level.time + 10 * 1000;
;337:	}
;338:}
;339:#endif
;340:
;341:/*
;342:================
;343:G_MissileImpact
;344:================
;345:*/
;346:void G_MissileImpact( gentity_t *ent, trace_t *trace ) {
line 348
;347:	gentity_t		*other;
;348:	qboolean		hitClient = qfalse;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 353
;349:#ifdef MISSIONPACK
;350:	vec3_t			forward, impactpoint, bouncedir;
;351:	int				eFlags;
;352:#endif
;353:	other = &g_entities[trace->entityNum];
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 361
;354:
;355:	// check for bounce
;356:#if !MONSTER_MODE	// JUHOX: monster seeds bounce on all dead things
;357:	if ( !other->takedamage &&
;358:		( ent->s.eFlags & ( EF_BOUNCE | EF_BOUNCE_HALF ) ) ) {
;359:#else
;360:	if (
;361:		(
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 48
BANDI4
CNSTI4 0
EQI4 $148
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
CNSTI4 0
EQI4 $150
ADDRLP4 8
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 11
NEI4 $148
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $148
LABELV $150
line 371
;362:			ent->s.eFlags & (EF_BOUNCE | EF_BOUNCE_HALF)
;363:		) &&
;364:		(
;365:			!other->takedamage ||
;366:			(
;367:				ent->s.weapon == WP_MONSTER_LAUNCHER &&
;368:				!G_GetEntityPlayerState(other)
;369:			)
;370:		)
;371:	) {
line 373
;372:#endif
;373:		G_BounceMissile( ent, trace );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 G_BounceMissile
CALLV
pop
line 377
;374:#if !MONSTER_MODE	// JUHOX: the EV_GRENADE_BOUNCE event is now done in G_BounceMissile()
;375:		G_AddEvent( ent, EV_GRENADE_BOUNCE, 0 );
;376:#endif
;377:		return;
ADDRGP4 $147
JUMPV
LABELV $148
line 401
;378:	}
;379:
;380:#ifdef MISSIONPACK
;381:	if ( other->takedamage ) {
;382:		if ( ent->s.weapon != WP_PROX_LAUNCHER ) {
;383:			if ( other->client && other->client->invulnerabilityTime > level.time ) {
;384:				//
;385:				VectorCopy( ent->s.pos.trDelta, forward );
;386:				VectorNormalize( forward );
;387:				if (G_InvulnerabilityEffect( other, forward, ent->s.pos.trBase, impactpoint, bouncedir )) {
;388:					VectorCopy( bouncedir, trace->plane.normal );
;389:					eFlags = ent->s.eFlags & EF_BOUNCE_HALF;
;390:					ent->s.eFlags &= ~EF_BOUNCE_HALF;
;391:					G_BounceMissile( ent, trace );
;392:					ent->s.eFlags |= eFlags;
;393:				}
;394:				ent->target_ent = other;
;395:				return;
;396:			}
;397:		}
;398:	}
;399:#endif
;400:	// impact damage
;401:	if (other->takedamage) {
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
CNSTI4 0
EQI4 $151
line 403
;402:#if MONSTER_MODE	// JUHOX: seed impact
;403:		if (ent->s.weapon == WP_MONSTER_LAUNCHER) {
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 11
NEI4 $153
line 404
;404:			G_SetOrigin(ent, trace->endpos);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 407
;405:
;406:			// make sticky
;407:			if (G_GetEntityPlayerState(other)) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $155
line 408
;408:				ent->enemy = other;
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 409
;409:				VectorSubtract(trace->endpos, other->r.currentOrigin, ent->movedir);	// JUHOX FIXME: movedir abused
ADDRFP4 0
INDIRP4
CNSTI4 680
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 684
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
SUBF4
ASGNF4
line 410
;410:			}
LABELV $155
line 412
;411:
;412:			if (ent->think) ent->think(ent);
ADDRFP4 0
INDIRP4
CNSTI4 696
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $147
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
CNSTI4 696
ADDP4
INDIRP4
CALLV
pop
line 413
;413:			return;
ADDRGP4 $147
JUMPV
LABELV $153
line 417
;414:		}
;415:#endif
;416:		// FIXME: wrong damage direction?
;417:		if ( ent->damage ) {
ADDRFP4 0
INDIRP4
CNSTI4 744
ADDP4
INDIRI4
CNSTI4 0
EQI4 $159
line 420
;418:			vec3_t	velocity;
;419:
;420:			if( LogAccuracyHit( other, &g_entities[ent->r.ownerNum] ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 32
ADDRGP4 LogAccuracyHit
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $161
line 421
;421:				g_entities[ent->r.ownerNum].client->accuracy_hits++;
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 812
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 422
;422:				hitClient = qtrue;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 423
;423:			}
LABELV $161
line 424
;424:			BG_EvaluateTrajectoryDelta( &ent->s.pos, level.time, velocity );
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 level+32
INDIRI4
ARGI4
ADDRLP4 20
ARGP4
ADDRGP4 BG_EvaluateTrajectoryDelta
CALLV
pop
line 425
;425:			if ( VectorLength( velocity ) == 0 ) {
ADDRLP4 20
ARGP4
ADDRLP4 36
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 36
INDIRF4
CNSTF4 0
NEF4 $165
line 426
;426:				velocity[2] = 1;	// stepped on a grenade
ADDRLP4 20+8
CNSTF4 1065353216
ASGNF4
line 427
;427:			}
LABELV $165
line 428
;428:			G_Damage (other, ent, &g_entities[ent->r.ownerNum], velocity,
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 40
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 40
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 40
INDIRP4
CNSTI4 744
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 40
INDIRP4
CNSTI4 756
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 431
;429:				ent->s.origin, ent->damage, 
;430:				0, ent->methodOfDeath);
;431:		}
LABELV $159
line 432
;432:	}
LABELV $151
line 471
;433:
;434:#ifdef MISSIONPACK
;435:	if( ent->s.weapon == WP_PROX_LAUNCHER ) {
;436:		if( ent->s.pos.trType != TR_GRAVITY ) {
;437:			return;
;438:		}
;439:
;440:		// if it's a player, stick it on to them (flag them and remove this entity)
;441:		if( other->s.eType == ET_PLAYER && other->health > 0 ) {
;442:			ProximityMine_Player( ent, other );
;443:			return;
;444:		}
;445:
;446:		SnapVectorTowards( trace->endpos, ent->s.pos.trBase );
;447:		G_SetOrigin( ent, trace->endpos );
;448:		ent->s.pos.trType = TR_STATIONARY;
;449:		VectorClear( ent->s.pos.trDelta );
;450:
;451:		G_AddEvent( ent, EV_PROXIMITY_MINE_STICK, trace->surfaceFlags );
;452:
;453:		ent->think = ProximityMine_Activate;
;454:		ent->nextthink = level.time + 2000;
;455:
;456:		vectoangles( trace->plane.normal, ent->s.angles );
;457:		ent->s.angles[0] += 90;
;458:
;459:		// link the prox mine to the other entity
;460:		ent->enemy = other;
;461:		ent->die = ProximityMine_Die;
;462:		VectorCopy(trace->plane.normal, ent->movedir);
;463:		VectorSet(ent->r.mins, -4, -4, -4);
;464:		VectorSet(ent->r.maxs, 4, 4, 4);
;465:		trap_LinkEntity(ent);
;466:
;467:		return;
;468:	}
;469:#endif
;470:
;471:	if (!strcmp(ent->classname, "hook")) {
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ARGP4
ADDRGP4 $170
ARGP4
ADDRLP4 20
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $168
line 478
;472:		gentity_t *nent;
;473:		vec3_t v;
;474:
;475:		// JUHOX: new grapple hook impact code
;476:#if GRAPPLE_ROPE
;477:		if (
;478:			g_grapple.integer != HM_classic &&
ADDRGP4 g_grapple+12
INDIRI4
CNSTI4 1
EQI4 $171
ADDRLP4 40
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 1022
EQI4 $171
ADDRLP4 40
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 64
LTI4 $171
line 481
;479:			trace->entityNum != ENTITYNUM_WORLD &&
;480:			trace->entityNum >= MAX_CLIENTS
;481:		) {
line 482
;482:			Weapon_HookFree(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Weapon_HookFree
CALLV
pop
line 483
;483:			return;
ADDRGP4 $147
JUMPV
LABELV $171
line 486
;484:		}
;485:#endif
;486:		nent = G_Spawn();
ADDRLP4 44
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 24
ADDRLP4 44
INDIRP4
ASGNP4
line 487
;487:		if (!nent) return;	// JUHOX BUGFIX
ADDRLP4 24
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $174
ADDRGP4 $147
JUMPV
LABELV $174
line 488
;488:		nent->s.weapon = WP_GRAPPLING_HOOK;	// JUHOX BUGFIX
ADDRLP4 24
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 10
ASGNI4
line 489
;489:		if ( other->takedamage && other->client ) {
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
CNSTI4 0
EQI4 $176
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $176
line 490
;490:			G_AddEvent( nent, EV_MISSILE_HIT, DirToByte( trace->plane.normal ) );
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 52
ADDRGP4 DirToByte
CALLI4
ASGNI4
ADDRLP4 24
INDIRP4
ARGP4
CNSTI4 51
ARGI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 491
;491:			nent->s.otherEntityNum = other->s.number;
ADDRLP4 24
INDIRP4
CNSTI4 140
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 493
;492:
;493:			ent->enemy = other;
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 495
;494:
;495:			v[0] = other->r.currentOrigin[0] + (other->r.mins[0] + other->r.maxs[0]) * 0.5;
ADDRLP4 28
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 448
ADDP4
INDIRF4
ADDF4
CNSTF4 1056964608
MULF4
ADDF4
ASGNF4
line 496
;496:			v[1] = other->r.currentOrigin[1] + (other->r.mins[1] + other->r.maxs[1]) * 0.5;
ADDRLP4 28+4
ADDRLP4 0
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 440
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 452
ADDP4
INDIRF4
ADDF4
CNSTF4 1056964608
MULF4
ADDF4
ASGNF4
line 497
;497:			v[2] = other->r.currentOrigin[2] + (other->r.mins[2] + other->r.maxs[2]) * 0.5;
ADDRLP4 28+8
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 444
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
ADDF4
CNSTF4 1056964608
MULF4
ADDF4
ASGNF4
line 499
;498:
;499:			SnapVectorTowards( v, ent->s.pos.trBase );	// save net bandwidth
ADDRLP4 28
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRGP4 SnapVectorTowards
CALLV
pop
line 500
;500:		} else {
ADDRGP4 $177
JUMPV
LABELV $176
line 501
;501:			VectorCopy(trace->endpos, v);
ADDRLP4 28
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRB
ASGNB 12
line 502
;502:			G_AddEvent( nent, EV_MISSILE_MISS, DirToByte( trace->plane.normal ) );
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 52
ADDRGP4 DirToByte
CALLI4
ASGNI4
ADDRLP4 24
INDIRP4
ARGP4
CNSTI4 52
ARGI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 503
;503:			ent->enemy = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
CNSTP4 0
ASGNP4
line 506
;504:			// JUHOX: save some data when hook attaches to a mover
;505:#if 1
;506:			if (trace->entityNum != ENTITYNUM_WORLD) {
ADDRFP4 4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 1022
EQI4 $180
line 507
;507:				ent->enemy = other;
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 508
;508:				VectorSubtract(v, other->r.currentOrigin, ent->movedir);	// JUHOX FIXME: movedir abused
ADDRFP4 0
INDIRP4
CNSTI4 680
ADDP4
ADDRLP4 28
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 684
ADDP4
ADDRLP4 28+4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRLP4 28+8
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
SUBF4
ASGNF4
line 509
;509:			}
LABELV $180
line 511
;510:#endif
;511:		}
LABELV $177
line 513
;512:
;513:		SnapVectorTowards( v, ent->s.pos.trBase );	// save net bandwidth
ADDRLP4 28
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRGP4 SnapVectorTowards
CALLV
pop
line 515
;514:
;515:		nent->freeAfterEvent = qtrue;
ADDRLP4 24
INDIRP4
CNSTI4 560
ADDP4
CNSTI4 1
ASGNI4
line 517
;516:		// change over to a normal entity right at the point of impact
;517:		nent->s.eType = ET_GENERAL;
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 0
ASGNI4
line 518
;518:		ent->s.eType = ET_GRAPPLE;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 11
ASGNI4
line 520
;519:
;520:		G_SetOrigin( ent, v );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 521
;521:		G_SetOrigin( nent, v );
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 28
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 530
;522:
;523:#if !GRAPPLE_ROPE
;524:		ent->think = /*Weapon_HookThink*/Weapon_HookFree;	// JUHOX
;525:		ent->nextthink = level.time + /*FRAMETIME*/350;	// JUHOX
;526:
;527:		ent->parent->client->ps.pm_flags |= PMF_GRAPPLE_PULL;
;528:		VectorCopy( ent->r.currentOrigin, ent->parent->client->ps.grapplePoint);
;529:#else
;530:		if (g_grapple.integer != HM_classic) {
ADDRGP4 g_grapple+12
INDIRI4
CNSTI4 1
EQI4 $184
line 535
;531:			/*
;532:			ent->think = 0;
;533:			ent->nextthink = 0;
;534:			*/
;535:			ent->think = Weapon_HookThink;
ADDRFP4 0
INDIRP4
CNSTI4 696
ADDP4
ADDRGP4 Weapon_HookThink
ASGNP4
line 536
;536:			ent->nextthink = level.time + FRAMETIME;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 537
;537:		}
ADDRGP4 $185
JUMPV
LABELV $184
line 538
;538:		else {
line 539
;539:			ent->think = Weapon_HookThink;
ADDRFP4 0
INDIRP4
CNSTI4 696
ADDP4
ADDRGP4 Weapon_HookThink
ASGNP4
line 540
;540:			ent->nextthink = level.time + FRAMETIME;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 542
;541:
;542:			ent->parent->client->ps.pm_flags |= PMF_GRAPPLE_PULL;
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 604
ADDP4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
line 543
;543:			VectorCopy( ent->r.currentOrigin, ent->parent->client->ps.grapplePoint);
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 604
ADDP4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 56
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 544
;544:		}
LABELV $185
line 547
;545:#endif
;546:
;547:		trap_LinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 548
;548:		trap_LinkEntity( nent );
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 551
;549:		
;550:
;551:		return;
ADDRGP4 $147
JUMPV
LABELV $168
line 560
;552:	}
;553:
;554:	// is it cheaper in bandwidth to just remove this ent and create a new
;555:	// one, rather than changing the missile into the explosion?
;556:
;557:#if 0	// JUHOX BUGFIX: let corpses bleed too (& monsters)
;558:	if ( other->takedamage && other->client ) {
;559:#else
;560:	if (other->takedamage && other->s.eType == ET_PLAYER) {
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
CNSTI4 0
EQI4 $189
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 1
NEI4 $189
line 562
;561:#endif
;562:		G_AddEvent( ent, EV_MISSILE_HIT, DirToByte( trace->plane.normal ) );
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 28
ADDRGP4 DirToByte
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 51
ARGI4
ADDRLP4 28
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 563
;563:		ent->s.otherEntityNum = other->s.number;
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 564
;564:	} else if( trace->surfaceFlags & SURF_METALSTEPS ) {
ADDRGP4 $190
JUMPV
LABELV $189
ADDRFP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $191
line 565
;565:		G_AddEvent( ent, EV_MISSILE_MISS_METAL, DirToByte( trace->plane.normal ) );
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 28
ADDRGP4 DirToByte
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 53
ARGI4
ADDRLP4 28
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 566
;566:	} else {
ADDRGP4 $192
JUMPV
LABELV $191
line 567
;567:		G_AddEvent( ent, EV_MISSILE_MISS, DirToByte( trace->plane.normal ) );
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 28
ADDRGP4 DirToByte
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 52
ARGI4
ADDRLP4 28
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 568
;568:	}
LABELV $192
LABELV $190
line 570
;569:
;570:	ent->freeAfterEvent = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 560
ADDP4
CNSTI4 1
ASGNI4
line 573
;571:
;572:	// change over to a normal entity right at the point of impact
;573:	ent->s.eType = ET_GENERAL;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 0
ASGNI4
line 575
;574:
;575:	SnapVectorTowards( trace->endpos, ent->s.pos.trBase );	// save net bandwidth
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRGP4 SnapVectorTowards
CALLV
pop
line 577
;576:
;577:	G_SetOrigin( ent, trace->endpos );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 580
;578:
;579:	// splash damage (doesn't apply to person directly hit)
;580:	if ( ent->splashDamage ) {
ADDRFP4 0
INDIRP4
CNSTI4 748
ADDP4
INDIRI4
CNSTI4 0
EQI4 $193
line 581
;581:		if( G_RadiusDamage( trace->endpos, ent->parent, ent->splashDamage, ent->splashRadius, 
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 604
ADDP4
INDIRP4
ARGP4
ADDRLP4 28
INDIRP4
CNSTI4 748
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 752
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 28
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 G_RadiusDamage
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $195
line 582
;582:			other, ent->splashMethodOfDeath ) ) {
line 583
;583:			if( !hitClient ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $197
line 584
;584:				g_entities[ent->r.ownerNum].client->accuracy_hits++;
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 812
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 585
;585:			}
LABELV $197
line 586
;586:		}
LABELV $195
line 587
;587:	}
LABELV $193
line 589
;588:
;589:	trap_LinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 590
;590:	CreateBFGCloud(ent);	// JUHOX
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CreateBFGCloud
CALLV
pop
line 591
;591:}
LABELV $147
endproc G_MissileImpact 68 32
export G_RunMissile
proc G_RunMissile 136 28
line 598
;592:
;593:/*
;594:================
;595:G_RunMissile
;596:================
;597:*/
;598:void G_RunMissile( gentity_t *ent ) {
line 612
;599:	vec3_t		origin;
;600:	trace_t		tr;
;601:	int			passent;
;602:	int			clipmask;	// JUHOX
;603:
;604:#if MONSTER_LAUNCHER	// JUHOX: monster seeds can be sticky
;605:	if (ent->s.weapon == WP_MONSTER_LAUNCHER && ent->enemy) {
;606:		VectorAdd(ent->enemy->r.currentOrigin, ent->movedir, origin);	// JUHOX FIXME: movedir abused
;607:		G_SetOrigin(ent, origin);
;608:	}
;609:#endif
;610:
;611:	// get current position
;612:	BG_EvaluateTrajectory( &ent->s.pos, level.time, origin );
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 level+32
INDIRI4
ARGI4
ADDRLP4 64
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 615
;613:
;614:	// if this missile bounced off an invulnerability sphere
;615:	if ( ent->target_ent ) {
ADDRFP4 0
INDIRP4
CNSTI4 672
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $202
line 616
;616:		passent = ent->target_ent->s.number;
ADDRLP4 60
ADDRFP4 0
INDIRP4
CNSTI4 672
ADDP4
INDIRP4
INDIRI4
ASGNI4
line 617
;617:	}
ADDRGP4 $203
JUMPV
LABELV $202
line 624
;618:#ifdef MISSIONPACK
;619:	// prox mines that left the owner bbox will attach to anything, even the owner
;620:	else if (ent->s.weapon == WP_PROX_LAUNCHER && ent->count) {
;621:		passent = ENTITYNUM_NONE;
;622:	}
;623:#endif
;624:	else {
line 626
;625:		// ignore interactions with the missile owner
;626:		passent = ent->r.ownerNum;
ADDRLP4 60
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
ASGNI4
line 627
;627:	}
LABELV $203
line 630
;628:	// JUHOX: get clipmask
;629:#if 1
;630:	clipmask = ent->clipmask;
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ASGNI4
line 631
;631:	clipmask |= CONTENTS_TELEPORTER;	// this depends on new code in SP_trigger_teleport()
ADDRLP4 56
ADDRLP4 56
INDIRI4
CNSTI4 262144
BORI4
ASGNI4
line 632
;632:	if (ent->s.weapon == WP_GRENADE_LAUNCHER && ent->count < 0) {
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 4
NEI4 $204
ADDRLP4 76
INDIRP4
CNSTI4 764
ADDP4
INDIRI4
CNSTI4 0
GEI4 $204
line 633
;633:		clipmask |= CONTENTS_JUMPPAD;	// this depends on new code in SP_trigger_push()
ADDRLP4 56
ADDRLP4 56
INDIRI4
CNSTI4 524288
BORI4
ASGNI4
line 634
;634:	}
LABELV $204
line 637
;635:#endif
;636:	// trace a line from the previous position to the current position
;637:	trap_Trace( &tr, ent->r.currentOrigin, ent->r.mins, ent->r.maxs, origin, passent, /*ent->*/clipmask );	// JUHOX
ADDRLP4 0
ARGP4
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 80
INDIRP4
CNSTI4 436
ADDP4
ARGP4
ADDRLP4 80
INDIRP4
CNSTI4 448
ADDP4
ARGP4
ADDRLP4 64
ARGP4
ADDRLP4 60
INDIRI4
ARGI4
ADDRLP4 56
INDIRI4
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 639
;638:
;639:	if ( tr.startsolid || tr.allsolid ) {
ADDRLP4 0+4
INDIRI4
CNSTI4 0
NEI4 $209
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $206
LABELV $209
line 641
;640:		// make sure the tr.entityNum is set to the entity we're stuck in
;641:		trap_Trace( &tr, ent->r.currentOrigin, ent->r.mins, ent->r.maxs, ent->r.currentOrigin, passent, /*ent->*/clipmask );	// JUHOX
ADDRLP4 0
ARGP4
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 84
INDIRP4
CNSTI4 436
ADDP4
ARGP4
ADDRLP4 84
INDIRP4
CNSTI4 448
ADDP4
ARGP4
ADDRLP4 84
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 60
INDIRI4
ARGI4
ADDRLP4 56
INDIRI4
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 642
;642:		tr.fraction = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 643
;643:	}
ADDRGP4 $207
JUMPV
LABELV $206
line 644
;644:	else {
line 645
;645:		VectorCopy( tr.endpos, ent->r.currentOrigin );
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 0+12
INDIRB
ASGNB 12
line 646
;646:	}
LABELV $207
line 648
;647:
;648:	trap_LinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 650
;649:
;650:	if ( tr.fraction != 1 ) {
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
EQF4 $212
line 653
;651:#if 1	// JUHOX: check if the missile hit a teleporter or jump pad (only grenades)
;652:		if (
;653:			tr.entityNum > 0 &&
ADDRLP4 0+52
INDIRI4
CNSTI4 0
LEI4 $215
ADDRLP4 0+52
INDIRI4
CNSTI4 1022
GEI4 $215
line 655
;654:			tr.entityNum < ENTITYNUM_MAX_NORMAL
;655:		) {
line 658
;656:			gentity_t* trigger;
;657:
;658:			trigger = &g_entities[tr.entityNum];
ADDRLP4 84
ADDRLP4 0+52
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 660
;659:			if (
;660:				trigger->inuse &&
ADDRLP4 88
ADDRLP4 84
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
EQI4 $220
ADDRLP4 88
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 9
NEI4 $220
ADDRLP4 88
INDIRP4
CNSTI4 708
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 trigger_teleporter_touch
CVPU4 4
NEU4 $220
line 663
;661:				trigger->s.eType == ET_TELEPORT_TRIGGER &&
;662:				trigger->touch == trigger_teleporter_touch
;663:			) {
line 669
;664:				gentity_t* dest;
;665:
;666:#if !ESCAPE_MODE	// JUHOX: G_PickTarget() also needs to know the segment
;667:				dest = G_PickTarget(trigger->target);
;668:#else
;669:				dest = G_PickTarget(trigger->target, trigger->worldSegment - 1);
ADDRLP4 96
ADDRLP4 84
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CNSTI4 652
ADDP4
INDIRP4
ARGP4
ADDRLP4 96
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRLP4 100
ADDRGP4 G_PickTarget
CALLP4
ASGNP4
ADDRLP4 92
ADDRLP4 100
INDIRP4
ASGNP4
line 671
;670:#endif
;671:				if (dest) {
ADDRLP4 92
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $222
line 677
;672:					vec3_t origin;
;673:					//vec3_t angles;
;674:					//float speed;
;675:					vec3_t dir;
;676:
;677:					if (ent->s.weapon == WP_GRAPPLING_HOOK) {
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 10
NEI4 $224
line 678
;678:						Weapon_HookFree(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Weapon_HookFree
CALLV
pop
line 679
;679:						return;
ADDRGP4 $200
JUMPV
LABELV $224
line 682
;680:					}
;681:
;682:					VectorCopy(dest->s.origin, origin);
ADDRLP4 104
ADDRLP4 92
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 683
;683:					origin[2] += 1;	// what's this for? derived from TeleportPlayer()
ADDRLP4 104+8
ADDRLP4 104+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 686
;684:
;685:					// set new origin (derived from G_SetOrigin())
;686:					VectorCopy(origin, ent->s.pos.trBase);
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 104
INDIRB
ASGNB 12
line 687
;687:					VectorCopy(origin, ent->r.currentOrigin);
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 104
INDIRB
ASGNB 12
line 689
;688:
;689:					ent->s.pos.trTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 699
;690:
;691:					// set new velocity vector
;692:					/*
;693:					speed = VectorLength(ent->s.pos.trDelta);
;694:					vectoangles(ent->s.pos.trDelta, angles);
;695:					VectorAdd(angles, dest->s.angles, angles);
;696:					AngleVectors(angles, dir, NULL, NULL);
;697:					VectorScale(dir, speed, ent->s.pos.trDelta);
;698:					*/
;699:					AngleVectors(dest->s.angles, dir, NULL, NULL);
ADDRLP4 92
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRLP4 116
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 701
;700:					// CAUTION: we can't use the VectorScale() macro here (we would need to use a temp var for VectorLength(ent->s.pos.trDelta))
;701:					_VectorScale(dir, VectorLength(ent->s.pos.trDelta), ent->s.pos.trDelta);
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ARGP4
ADDRLP4 128
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 116
ARGP4
ADDRLP4 128
INDIRF4
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ARGP4
ADDRGP4 _VectorScale
CALLV
pop
line 703
;702:
;703:					ent->s.eFlags ^= EF_TELEPORT_BIT;	// derived from TeleportPlayer()
ADDRLP4 132
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 132
INDIRP4
ADDRLP4 132
INDIRP4
INDIRI4
CNSTI4 4
BXORI4
ASGNI4
line 704
;704:				}
LABELV $222
line 705
;705:				G_RunThink(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_RunThink
CALLV
pop
line 706
;706:				return;
ADDRGP4 $200
JUMPV
LABELV $220
line 709
;707:			}
;708:			else if (
;709:				trigger->inuse &&
ADDRLP4 92
ADDRLP4 84
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
EQI4 $228
ADDRLP4 92
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 8
NEI4 $228
ADDRLP4 92
INDIRP4
CNSTI4 708
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 trigger_push_touch
CVPU4 4
NEU4 $228
ADDRFP4 0
INDIRP4
CNSTI4 764
ADDP4
INDIRI4
ADDRLP4 0+52
INDIRI4
EQI4 $228
line 713
;710:				trigger->s.eType == ET_PUSH_TRIGGER &&
;711:				trigger->touch == trigger_push_touch &&
;712:				ent->count != tr.entityNum
;713:			) {
line 714
;714:				ent->count = tr.entityNum;
ADDRFP4 0
INDIRP4
CNSTI4 764
ADDP4
ADDRLP4 0+52
INDIRI4
ASGNI4
line 716
;715:				//G_BounceMissile(ent, &tr);
;716:				VectorCopy(ent->r.currentOrigin, ent->s.pos.trBase);
ADDRLP4 96
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 96
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 717
;717:				ent->s.pos.trTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 718
;718:				G_AddEvent(ent, EV_GRENADE_BOUNCE, 0);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 44
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 720
;719:				//G_AddEvent(ent, EV_JUMP_PAD, 0);
;720:				VectorCopy(trigger->s.origin2, ent->s.pos.trDelta);
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 84
INDIRP4
CNSTI4 104
ADDP4
INDIRB
ASGNB 12
line 721
;721:				G_RunThink(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_RunThink
CALLV
pop
line 722
;722:				return;
ADDRGP4 $200
JUMPV
LABELV $228
line 725
;723:			}
;724:
;725:		}
LABELV $215
line 729
;726:#endif
;727:#if 1	// JUHOX: make monster seed bounce on playerclip
;728:		if (
;729:			ent->s.weapon == WP_MONSTER_LAUNCHER &&
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 11
NEI4 $233
ADDRLP4 0+48
INDIRI4
CNSTI4 65536
BANDI4
CNSTI4 0
EQI4 $233
line 731
;730:			(tr.contents & CONTENTS_PLAYERCLIP)
;731:		) {
line 732
;732:			tr.surfaceFlags &= ~SURF_NOIMPACT;
ADDRLP4 0+44
ADDRLP4 0+44
INDIRI4
CNSTI4 -17
BANDI4
ASGNI4
line 733
;733:		}
LABELV $233
line 736
;734:#endif
;735:		// never explode or bounce on sky
;736:		if ( tr.surfaceFlags & SURF_NOIMPACT ) {
ADDRLP4 0+44
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $237
line 744
;737:			// If grapple, reset owner
;738:#if 0	// JUHOX: use Weapon_HookFree() when grapple hits sky
;739:			if (ent->parent && ent->parent->client && ent->parent->client->hook == ent) {
;740:				ent->parent->client->hook = NULL;
;741:			}
;742:			G_FreeEntity( ent );
;743:#else
;744:			if (ent->s.weapon == WP_GRAPPLING_HOOK) {
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 10
NEI4 $240
line 745
;745:				Weapon_HookFree(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Weapon_HookFree
CALLV
pop
line 746
;746:			}
ADDRGP4 $200
JUMPV
LABELV $240
line 747
;747:			else {
line 748
;748:				G_FreeEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 749
;749:			}
line 751
;750:#endif
;751:			return;
ADDRGP4 $200
JUMPV
LABELV $237
line 753
;752:		}
;753:		G_MissileImpact( ent, &tr );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_MissileImpact
CALLV
pop
line 754
;754:		if ( ent->s.eType != ET_MISSILE ) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
EQI4 $242
line 755
;755:			return;		// exploded
ADDRGP4 $200
JUMPV
LABELV $242
line 757
;756:		}
;757:	}
LABELV $212
line 768
;758:#ifdef MISSIONPACK
;759:	// if the prox mine wasn't yet outside the player body
;760:	if (ent->s.weapon == WP_PROX_LAUNCHER && !ent->count) {
;761:		// check if the prox mine is outside the owner bbox
;762:		trap_Trace( &tr, ent->r.currentOrigin, ent->r.mins, ent->r.maxs, ent->r.currentOrigin, ENTITYNUM_NONE, ent->clipmask );
;763:		if (!tr.startsolid || tr.entityNum != ent->r.ownerNum) {
;764:			ent->count = 1;
;765:		}
;766:	}
;767:#endif
;768:	if (ent->s.weapon == WP_GRENADE_LAUNCHER) ent->count = -1;	// JUHOX: reset grenade's last used jump pad
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 4
NEI4 $244
ADDRFP4 0
INDIRP4
CNSTI4 764
ADDP4
CNSTI4 -1
ASGNI4
LABELV $244
line 770
;769:	// check think function after bouncing
;770:	G_RunThink( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_RunThink
CALLV
pop
line 771
;771:}
LABELV $200
endproc G_RunMissile 136 28
export fire_plasma
proc fire_plasma 20 4
line 782
;772:
;773:
;774://=============================================================================
;775:
;776:/*
;777:=================
;778:fire_plasma
;779:
;780:=================
;781:*/
;782:gentity_t *fire_plasma (gentity_t *self, vec3_t start, vec3_t dir) {
line 785
;783:	gentity_t	*bolt;
;784:
;785:	VectorNormalize (dir);
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 787
;786:
;787:	bolt = G_Spawn();
ADDRLP4 4
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 788
;788:	if (!bolt) return NULL;	// JUHOX BUGFIX
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $247
CNSTP4 0
RETP4
ADDRGP4 $246
JUMPV
LABELV $247
line 789
;789:	bolt->classname = "plasma";
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
ADDRGP4 $249
ASGNP4
line 790
;790:	bolt->nextthink = level.time + 10000;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 10000
ADDI4
ASGNI4
line 791
;791:	bolt->think = G_ExplodeMissile;
ADDRLP4 0
INDIRP4
CNSTI4 696
ADDP4
ADDRGP4 G_ExplodeMissile
ASGNP4
line 792
;792:	bolt->s.eType = ET_MISSILE;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 3
ASGNI4
line 793
;793:	bolt->r.svFlags = SVF_USE_CURRENT_ORIGIN;
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 128
ASGNI4
line 794
;794:	bolt->s.weapon = WP_PLASMAGUN;
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 8
ASGNI4
line 795
;795:	bolt->r.ownerNum = self->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 796
;796:	bolt->parent = self;
ADDRLP4 0
INDIRP4
CNSTI4 604
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 797
;797:	bolt->damage = /*20*/15;	// JUHOX
ADDRLP4 0
INDIRP4
CNSTI4 744
ADDP4
CNSTI4 15
ASGNI4
line 798
;798:	bolt->splashDamage = /*15*/10;	// JUHOX
ADDRLP4 0
INDIRP4
CNSTI4 748
ADDP4
CNSTI4 10
ASGNI4
line 799
;799:	bolt->splashRadius = /*20*/SPLASH_RADIUS_PLASMA;	// JUHOX
ADDRLP4 0
INDIRP4
CNSTI4 752
ADDP4
CNSTI4 100
ASGNI4
line 800
;800:	bolt->methodOfDeath = MOD_PLASMA;
ADDRLP4 0
INDIRP4
CNSTI4 756
ADDP4
CNSTI4 13
ASGNI4
line 801
;801:	bolt->splashMethodOfDeath = MOD_PLASMA_SPLASH;
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
CNSTI4 14
ASGNI4
line 802
;802:	bolt->clipmask = MASK_SHOT;
ADDRLP4 0
INDIRP4
CNSTI4 576
ADDP4
CNSTI4 100663297
ASGNI4
line 803
;803:	bolt->target_ent = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 672
ADDP4
CNSTP4 0
ASGNP4
line 805
;804:
;805:	bolt->s.pos.trType = TR_LINEAR;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 2
ASGNI4
line 809
;806:#if 0	// JUHOX: reduce missile prestep for plasma gun
;807:	bolt->s.pos.trTime = level.time - MISSILE_PRESTEP_TIME;		// move a bit on the very first frame
;808:#else
;809:	bolt->s.pos.trTime = level.time - 20;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 20
SUBI4
ASGNI4
line 811
;810:#endif
;811:	VectorCopy( start, bolt->s.pos.trBase );
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 812
;812:	VectorScale( dir, 2000, bolt->s.pos.trDelta );
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRFP4 8
INDIRP4
INDIRF4
CNSTF4 1157234688
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1157234688
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1157234688
MULF4
ASGNF4
line 813
;813:	SnapVector( bolt->s.pos.trDelta );			// save net bandwidth
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 815
;814:
;815:	VectorCopy (start, bolt->r.currentOrigin);
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 817
;816:
;817:	return bolt;
ADDRLP4 0
INDIRP4
RETP4
LABELV $246
endproc fire_plasma 20 4
proc Grenade_Die 8 0
line 828
;818:}	
;819:
;820://=============================================================================
;821:
;822:
;823:/*
;824:=================
;825:JUHOX: Grenade_Die
;826:=================
;827:*/
;828:static void Grenade_Die(gentity_t* ent, gentity_t* inflictor, gentity_t* attacker, int damage, int mod) {
line 831
;829:	int time;
;830:
;831:	time = level.time + (rand() % 300 ) + 1;
ADDRLP4 4
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
ADDRGP4 level+32
INDIRI4
ADDRLP4 4
INDIRI4
CNSTI4 300
MODI4
ADDI4
CNSTI4 1
ADDI4
ASGNI4
line 832
;832:	if (ent->nextthink > time) ent->nextthink = time;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
LEI4 $254
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
LABELV $254
line 833
;833:}
LABELV $252
endproc Grenade_Die 8 0
export fire_grenade
proc fire_grenade 20 4
line 840
;834:
;835:/*
;836:=================
;837:fire_grenade
;838:=================
;839:*/
;840:gentity_t *fire_grenade (gentity_t *self, vec3_t start, vec3_t dir) {
line 843
;841:	gentity_t	*bolt;
;842:
;843:	VectorNormalize (dir);
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 845
;844:
;845:	bolt = G_Spawn();
ADDRLP4 4
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 846
;846:	if (!bolt) return NULL;	// JUHOX BUGFIX
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $257
CNSTP4 0
RETP4
ADDRGP4 $256
JUMPV
LABELV $257
line 847
;847:	bolt->classname = "grenade";
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
ADDRGP4 $259
ASGNP4
line 848
;848:	bolt->nextthink = level.time + 5000;	// JUHOX: was 2500
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 5000
ADDI4
ASGNI4
line 849
;849:	bolt->think = G_ExplodeMissile;
ADDRLP4 0
INDIRP4
CNSTI4 696
ADDP4
ADDRGP4 G_ExplodeMissile
ASGNP4
line 850
;850:	bolt->s.eType = ET_MISSILE;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 3
ASGNI4
line 851
;851:	bolt->r.svFlags = SVF_USE_CURRENT_ORIGIN;
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 128
ASGNI4
line 852
;852:	bolt->s.weapon = WP_GRENADE_LAUNCHER;
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 4
ASGNI4
line 853
;853:	bolt->s.eFlags = EF_BOUNCE_HALF;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 32
ASGNI4
line 854
;854:	bolt->r.ownerNum = self->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 855
;855:	bolt->parent = self;
ADDRLP4 0
INDIRP4
CNSTI4 604
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 856
;856:	bolt->damage = 50;			// JUHOX: was 100
ADDRLP4 0
INDIRP4
CNSTI4 744
ADDP4
CNSTI4 50
ASGNI4
line 857
;857:	bolt->splashDamage = 50;	// JUHOX: was 100
ADDRLP4 0
INDIRP4
CNSTI4 748
ADDP4
CNSTI4 50
ASGNI4
line 858
;858:	bolt->splashRadius = /*150*/SPLASH_RADIUS_GRENADE;	// JUHOX
ADDRLP4 0
INDIRP4
CNSTI4 752
ADDP4
CNSTI4 200
ASGNI4
line 859
;859:	bolt->methodOfDeath = MOD_GRENADE;
ADDRLP4 0
INDIRP4
CNSTI4 756
ADDP4
CNSTI4 9
ASGNI4
line 860
;860:	bolt->splashMethodOfDeath = MOD_GRENADE_SPLASH;
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
CNSTI4 10
ASGNI4
line 861
;861:	bolt->clipmask = MASK_SHOT;
ADDRLP4 0
INDIRP4
CNSTI4 576
ADDP4
CNSTI4 100663297
ASGNI4
line 862
;862:	bolt->target_ent = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 672
ADDP4
CNSTP4 0
ASGNP4
line 865
;863:	// JUHOX: make grenade damagable
;864:#if 1
;865:	bolt->takedamage = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
CNSTI4 1
ASGNI4
line 866
;866:	bolt->health = 1;
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 1
ASGNI4
line 867
;867:	bolt->die = Grenade_Die;
ADDRLP4 0
INDIRP4
CNSTI4 720
ADDP4
ADDRGP4 Grenade_Die
ASGNP4
line 869
;868:#endif
;869:	bolt->count = -1;	// JUHOX: grenade's last used jump pad
ADDRLP4 0
INDIRP4
CNSTI4 764
ADDP4
CNSTI4 -1
ASGNI4
line 871
;870:
;871:	bolt->s.pos.trType = TR_GRAVITY;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 5
ASGNI4
line 872
;872:	bolt->s.pos.trTime = level.time - MISSILE_PRESTEP_TIME;		// move a bit on the very first frame
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 50
SUBI4
ASGNI4
line 873
;873:	VectorCopy( start, bolt->s.pos.trBase );
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 874
;874:	VectorScale( dir, 700, bolt->s.pos.trDelta );
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRFP4 8
INDIRP4
INDIRF4
CNSTF4 1143930880
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1143930880
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1143930880
MULF4
ASGNF4
line 875
;875:	SnapVector( bolt->s.pos.trDelta );			// save net bandwidth
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 877
;876:
;877:	VectorCopy (start, bolt->r.currentOrigin);
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 879
;878:
;879:	return bolt;
ADDRLP4 0
INDIRP4
RETP4
LABELV $256
endproc fire_grenade 20 4
proc G_TriggerMonsterSeed 16 12
line 890
;880:}
;881:
;882:/*
;883:=================
;884:JUHOX: G_TriggerMonsterSeed
;885:
;886:derived from G_ExplodeMissile()
;887:=================
;888:*/
;889:#if MONSTER_MODE
;890:static void G_TriggerMonsterSeed(gentity_t* seed) {
line 894
;891:	vec3_t origin;
;892:
;893:	//seed->s.eType = ET_GENERAL;
;894:	seed->nextthink = 0;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
CNSTI4 0
ASGNI4
line 895
;895:	seed->think = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 696
ADDP4
CNSTP4 0
ASGNP4
line 897
;896:
;897:	BG_EvaluateTrajectory(&seed->s.pos, level.time, origin);
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 level+32
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 898
;898:	origin[2] += 5;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 899
;899:	if (!G_AddMonsterSeed(origin, seed)) {
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 G_AddMonsterSeed
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $265
line 900
;900:		G_AddEvent(seed, EV_GRENADE_BOUNCE, 0);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 44
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 901
;901:		seed->freeAfterEvent = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 560
ADDP4
CNSTI4 1
ASGNI4
line 902
;902:	}
LABELV $265
line 903
;903:}
LABELV $262
endproc G_TriggerMonsterSeed 16 12
export fire_monster_seed
proc fire_monster_seed 20 4
line 914
;904:#endif
;905:
;906:/*
;907:=================
;908:JUHOX: fire_monster_seed
;909:
;910:derived of fire_grenade()
;911:=================
;912:*/
;913:#if MONSTER_MODE
;914:gentity_t* fire_monster_seed(gentity_t* self, vec3_t start, vec3_t dir) {
line 917
;915:	gentity_t* seed;
;916:
;917:	VectorNormalize(dir);
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 919
;918:
;919:	seed = G_Spawn();
ADDRLP4 4
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 920
;920:	if (!seed) return NULL;
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $268
CNSTP4 0
RETP4
ADDRGP4 $267
JUMPV
LABELV $268
line 921
;921:	seed->classname = "monster_seed";
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
ADDRGP4 $270
ASGNP4
line 922
;922:	seed->nextthink = level.time + 10000;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 10000
ADDI4
ASGNI4
line 923
;923:	seed->think = G_TriggerMonsterSeed;
ADDRLP4 0
INDIRP4
CNSTI4 696
ADDP4
ADDRGP4 G_TriggerMonsterSeed
ASGNP4
line 924
;924:	seed->s.eType = ET_MISSILE;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 3
ASGNI4
line 925
;925:	seed->r.svFlags = SVF_USE_CURRENT_ORIGIN;
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 128
ASGNI4
line 926
;926:	seed->s.weapon = WP_MONSTER_LAUNCHER;
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 11
ASGNI4
line 927
;927:	seed->s.eFlags = EF_BOUNCE_HALF;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 32
ASGNI4
line 928
;928:	seed->r.ownerNum = self->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 929
;929:	VectorSet(seed->r.mins, -4, -4, -4);
ADDRLP4 0
INDIRP4
CNSTI4 436
ADDP4
CNSTF4 3229614080
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 440
ADDP4
CNSTF4 3229614080
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 444
ADDP4
CNSTF4 3229614080
ASGNF4
line 930
;930:	VectorSet(seed->r.maxs, 4, 4, 4);
ADDRLP4 0
INDIRP4
CNSTI4 448
ADDP4
CNSTF4 1082130432
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 452
ADDP4
CNSTF4 1082130432
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 456
ADDP4
CNSTF4 1082130432
ASGNF4
line 931
;931:	seed->parent = self;
ADDRLP4 0
INDIRP4
CNSTI4 604
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 932
;932:	seed->clipmask = /*MASK_SHOT*/MASK_PLAYERSOLID;
ADDRLP4 0
INDIRP4
CNSTI4 576
ADDP4
CNSTI4 33619969
ASGNI4
line 933
;933:	seed->target_ent = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 672
ADDP4
CNSTP4 0
ASGNP4
line 935
;934:
;935:	seed->s.pos.trType = TR_GRAVITY;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 5
ASGNI4
line 936
;936:	seed->s.pos.trTime = level.time - MISSILE_PRESTEP_TIME;		// move a bit on the very first frame
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 50
SUBI4
ASGNI4
line 937
;937:	VectorCopy(start, seed->s.pos.trBase);
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 938
;938:	VectorScale(dir, 700, seed->s.pos.trDelta);
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRFP4 8
INDIRP4
INDIRF4
CNSTF4 1143930880
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1143930880
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1143930880
MULF4
ASGNF4
line 939
;939:	SnapVector(seed->s.pos.trDelta);			// save net bandwidth
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 941
;940:
;941:	VectorCopy(start, seed->r.currentOrigin);
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 943
;942:
;943:	return seed;
ADDRLP4 0
INDIRP4
RETP4
LABELV $267
endproc fire_monster_seed 20 4
export fire_bfg
proc fire_bfg 20 4
line 955
;944:}
;945:#endif
;946:
;947://=============================================================================
;948:
;949:
;950:/*
;951:=================
;952:fire_bfg
;953:=================
;954:*/
;955:gentity_t *fire_bfg (gentity_t *self, vec3_t start, vec3_t dir) {
line 958
;956:	gentity_t	*bolt;
;957:
;958:	VectorNormalize (dir);
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 960
;959:
;960:	bolt = G_Spawn();
ADDRLP4 4
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 961
;961:	if (!bolt) return NULL;	// JUHOX BUGFIX
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $274
CNSTP4 0
RETP4
ADDRGP4 $273
JUMPV
LABELV $274
line 962
;962:	bolt->classname = "bfg";
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
ADDRGP4 $276
ASGNP4
line 963
;963:	bolt->nextthink = level.time + 10000;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 10000
ADDI4
ASGNI4
line 964
;964:	bolt->think = G_ExplodeMissile;
ADDRLP4 0
INDIRP4
CNSTI4 696
ADDP4
ADDRGP4 G_ExplodeMissile
ASGNP4
line 965
;965:	bolt->s.eType = ET_MISSILE;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 3
ASGNI4
line 966
;966:	bolt->r.svFlags = SVF_USE_CURRENT_ORIGIN;
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 128
ASGNI4
line 967
;967:	bolt->s.weapon = WP_BFG;
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 9
ASGNI4
line 968
;968:	bolt->r.ownerNum = self->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 969
;969:	bolt->parent = self;
ADDRLP4 0
INDIRP4
CNSTI4 604
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 970
;970:	bolt->damage = 100;
ADDRLP4 0
INDIRP4
CNSTI4 744
ADDP4
CNSTI4 100
ASGNI4
line 971
;971:	bolt->splashDamage = 100;
ADDRLP4 0
INDIRP4
CNSTI4 748
ADDP4
CNSTI4 100
ASGNI4
line 972
;972:	bolt->splashRadius = 120;
ADDRLP4 0
INDIRP4
CNSTI4 752
ADDP4
CNSTI4 120
ASGNI4
line 973
;973:	bolt->methodOfDeath = MOD_BFG;
ADDRLP4 0
INDIRP4
CNSTI4 756
ADDP4
CNSTI4 17
ASGNI4
line 974
;974:	bolt->splashMethodOfDeath = MOD_BFG_SPLASH;
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
CNSTI4 18
ASGNI4
line 975
;975:	bolt->clipmask = MASK_SHOT;
ADDRLP4 0
INDIRP4
CNSTI4 576
ADDP4
CNSTI4 100663297
ASGNI4
line 976
;976:	bolt->target_ent = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 672
ADDP4
CNSTP4 0
ASGNP4
line 978
;977:
;978:	bolt->s.pos.trType = TR_LINEAR;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 2
ASGNI4
line 979
;979:	bolt->s.pos.trTime = level.time - MISSILE_PRESTEP_TIME;		// move a bit on the very first frame
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 50
SUBI4
ASGNI4
line 980
;980:	VectorCopy( start, bolt->s.pos.trBase );
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 981
;981:	VectorScale( dir, /*2000*/700, bolt->s.pos.trDelta );	// JUHOX
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRFP4 8
INDIRP4
INDIRF4
CNSTF4 1143930880
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1143930880
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1143930880
MULF4
ASGNF4
line 982
;982:	SnapVector( bolt->s.pos.trDelta );			// save net bandwidth
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 983
;983:	VectorCopy (start, bolt->r.currentOrigin);
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 985
;984:
;985:	return bolt;
ADDRLP4 0
INDIRP4
RETP4
LABELV $273
endproc fire_bfg 20 4
export fire_rocket
proc fire_rocket 20 4
line 996
;986:}
;987:
;988://=============================================================================
;989:
;990:
;991:/*
;992:=================
;993:fire_rocket
;994:=================
;995:*/
;996:gentity_t *fire_rocket (gentity_t *self, vec3_t start, vec3_t dir) {
line 999
;997:	gentity_t	*bolt;
;998:
;999:	VectorNormalize (dir);
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 1001
;1000:
;1001:	bolt = G_Spawn();
ADDRLP4 4
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 1002
;1002:	bolt->classname = "rocket";
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
ADDRGP4 $280
ASGNP4
line 1003
;1003:	bolt->nextthink = level.time + 15000;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 15000
ADDI4
ASGNI4
line 1004
;1004:	bolt->think = G_ExplodeMissile;
ADDRLP4 0
INDIRP4
CNSTI4 696
ADDP4
ADDRGP4 G_ExplodeMissile
ASGNP4
line 1005
;1005:	bolt->s.eType = ET_MISSILE;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 3
ASGNI4
line 1006
;1006:	bolt->r.svFlags = SVF_USE_CURRENT_ORIGIN;
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 128
ASGNI4
line 1007
;1007:	bolt->s.weapon = WP_ROCKET_LAUNCHER;
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 5
ASGNI4
line 1008
;1008:	bolt->r.ownerNum = self->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 1009
;1009:	bolt->parent = self;
ADDRLP4 0
INDIRP4
CNSTI4 604
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 1010
;1010:	bolt->damage = 100;
ADDRLP4 0
INDIRP4
CNSTI4 744
ADDP4
CNSTI4 100
ASGNI4
line 1011
;1011:	bolt->splashDamage = 100;
ADDRLP4 0
INDIRP4
CNSTI4 748
ADDP4
CNSTI4 100
ASGNI4
line 1012
;1012:	bolt->splashRadius = /*120*/SPLASH_RADIUS_ROCKET;	// JUHOX
ADDRLP4 0
INDIRP4
CNSTI4 752
ADDP4
CNSTI4 120
ASGNI4
line 1013
;1013:	bolt->methodOfDeath = MOD_ROCKET;
ADDRLP4 0
INDIRP4
CNSTI4 756
ADDP4
CNSTI4 11
ASGNI4
line 1014
;1014:	bolt->splashMethodOfDeath = MOD_ROCKET_SPLASH;
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
CNSTI4 12
ASGNI4
line 1015
;1015:	bolt->clipmask = MASK_SHOT;
ADDRLP4 0
INDIRP4
CNSTI4 576
ADDP4
CNSTI4 100663297
ASGNI4
line 1016
;1016:	bolt->target_ent = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 672
ADDP4
CNSTP4 0
ASGNP4
line 1018
;1017:#if MONSTER_MODE
;1018:	bolt->s.otherEntityNum = self->s.clientNum;	// JUHOX: so client can ceck for fireball
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 1021
;1019:#endif
;1020:
;1021:	bolt->s.pos.trType = TR_LINEAR;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 2
ASGNI4
line 1022
;1022:	bolt->s.pos.trTime = level.time - MISSILE_PRESTEP_TIME;		// move a bit on the very first frame
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 50
SUBI4
ASGNI4
line 1023
;1023:	VectorCopy( start, bolt->s.pos.trBase );
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 1024
;1024:	VectorScale( dir, 900, bolt->s.pos.trDelta );
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRFP4 8
INDIRP4
INDIRF4
CNSTF4 1147207680
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1147207680
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1147207680
MULF4
ASGNF4
line 1025
;1025:	SnapVector( bolt->s.pos.trDelta );			// save net bandwidth
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 1026
;1026:	VectorCopy (start, bolt->r.currentOrigin);
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 1028
;1027:
;1028:	return bolt;
ADDRLP4 0
INDIRP4
RETP4
LABELV $279
endproc fire_rocket 20 4
export fire_grapple
proc fire_grapple 28 4
line 1036
;1029:}
;1030:
;1031:/*
;1032:=================
;1033:fire_grapple
;1034:=================
;1035:*/
;1036:gentity_t *fire_grapple (gentity_t *self, vec3_t start, vec3_t dir) {
line 1042
;1037:	gentity_t	*hook;
;1038:#if GRAPPLE_ROPE
;1039:	float speed;	// JUHOX
;1040:#endif
;1041:
;1042:	Weapon_HookFree(self->client->hook);	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 884
ADDP4
INDIRP4
ARGP4
ADDRGP4 Weapon_HookFree
CALLV
pop
line 1043
;1043:	self->client->hook = NULL;				// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 884
ADDP4
CNSTP4 0
ASGNP4
line 1045
;1044:
;1045:	VectorNormalize (dir);
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 1047
;1046:
;1047:	hook = G_Spawn();
ADDRLP4 8
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 1048
;1048:	if (!hook) return NULL;	// JUHOX BUGFIX
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $284
CNSTP4 0
RETP4
ADDRGP4 $283
JUMPV
LABELV $284
line 1049
;1049:	hook->classname = "hook";
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
ADDRGP4 $170
ASGNP4
line 1050
;1050:	hook->nextthink = level.time + /*10000*/20000;	// JUHOX
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 20000
ADDI4
ASGNI4
line 1051
;1051:	hook->think = Weapon_HookFree;
ADDRLP4 0
INDIRP4
CNSTI4 696
ADDP4
ADDRGP4 Weapon_HookFree
ASGNP4
line 1052
;1052:	hook->s.eType = ET_MISSILE;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 3
ASGNI4
line 1053
;1053:	hook->r.svFlags = SVF_USE_CURRENT_ORIGIN;
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 128
ASGNI4
line 1054
;1054:	hook->s.weapon = WP_GRAPPLING_HOOK;
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 10
ASGNI4
line 1055
;1055:	hook->r.ownerNum = self->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 1056
;1056:	hook->methodOfDeath = MOD_GRAPPLE;
ADDRLP4 0
INDIRP4
CNSTI4 756
ADDP4
CNSTI4 28
ASGNI4
line 1057
;1057:	hook->clipmask = MASK_SHOT;
ADDRLP4 0
INDIRP4
CNSTI4 576
ADDP4
CNSTI4 100663297
ASGNI4
line 1058
;1058:	hook->parent = self;
ADDRLP4 0
INDIRP4
CNSTI4 604
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 1059
;1059:	hook->target_ent = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 672
ADDP4
CNSTP4 0
ASGNP4
line 1062
;1060:	//hook->damage = 25;	// -JUHOX
;1061:#if GRAPPLE_ROPE	// JUHOX: the hooks needs some extension
;1062:	VectorSet(hook->r.mins, -ROPE_ELEMENT_SIZE, -ROPE_ELEMENT_SIZE, -ROPE_ELEMENT_SIZE);
ADDRLP4 0
INDIRP4
CNSTI4 436
ADDP4
CNSTF4 3240099840
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 440
ADDP4
CNSTF4 3240099840
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 444
ADDP4
CNSTF4 3240099840
ASGNF4
line 1063
;1063:	VectorSet(hook->r.maxs, ROPE_ELEMENT_SIZE, ROPE_ELEMENT_SIZE, ROPE_ELEMENT_SIZE);
ADDRLP4 0
INDIRP4
CNSTI4 448
ADDP4
CNSTF4 1092616192
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 452
ADDP4
CNSTF4 1092616192
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 456
ADDP4
CNSTF4 1092616192
ASGNF4
line 1070
;1064:#endif
;1065:
;1066:	// JUHOX: let hook fly like a grenade
;1067:#if !GRAPPLE_ROPE
;1068:	hook->s.pos.trType = TR_LINEAR;
;1069:#else
;1070:	switch (g_grapple.integer) {
ADDRLP4 12
ADDRGP4 g_grapple+12
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 1
LTI4 $287
ADDRLP4 12
INDIRI4
CNSTI4 4
GTI4 $287
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $303-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $303
address $290
address $291
address $295
address $302
code
LABELV $290
line 1072
;1071:	case HM_classic:
;1072:		hook->s.pos.trType = TR_LINEAR;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 2
ASGNI4
line 1073
;1073:		speed = 800;
ADDRLP4 4
CNSTF4 1145569280
ASGNF4
line 1074
;1074:		break;
ADDRGP4 $288
JUMPV
LABELV $291
LABELV $287
line 1077
;1075:	case HM_tool:
;1076:	default:
;1077:		hook->s.pos.trType = TR_GRAVITY;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 5
ASGNI4
line 1078
;1078:		speed = self->client->offHandHook? 800 : 1200;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
CNSTI4 0
EQI4 $293
ADDRLP4 16
CNSTI4 800
ASGNI4
ADDRGP4 $294
JUMPV
LABELV $293
ADDRLP4 16
CNSTI4 1200
ASGNI4
LABELV $294
ADDRLP4 4
ADDRLP4 16
INDIRI4
CVIF4 4
ASGNF4
line 1079
;1079:		break;
ADDRGP4 $288
JUMPV
LABELV $295
line 1081
;1080:	case HM_anchor:
;1081:		hook->s.pos.trType = self->client->offHandHook? TR_GRAVITY : TR_LINEAR;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
CNSTI4 0
EQI4 $297
ADDRLP4 20
CNSTI4 5
ASGNI4
ADDRGP4 $298
JUMPV
LABELV $297
ADDRLP4 20
CNSTI4 2
ASGNI4
LABELV $298
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
line 1082
;1082:		speed = self->client->offHandHook? 800 : 2000;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
CNSTI4 0
EQI4 $300
ADDRLP4 24
CNSTI4 800
ASGNI4
ADDRGP4 $301
JUMPV
LABELV $300
ADDRLP4 24
CNSTI4 2000
ASGNI4
LABELV $301
ADDRLP4 4
ADDRLP4 24
INDIRI4
CVIF4 4
ASGNF4
line 1083
;1083:		break;
ADDRGP4 $288
JUMPV
LABELV $302
line 1085
;1084:	case HM_combat:
;1085:		hook->s.pos.trType = TR_LINEAR;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 2
ASGNI4
line 1086
;1086:		speed = 2000;
ADDRLP4 4
CNSTF4 1157234688
ASGNF4
line 1087
;1087:		break;
LABELV $288
line 1090
;1088:	}
;1089:#endif
;1090:	hook->s.pos.trTime = level.time - MISSILE_PRESTEP_TIME;		// move a bit on the very first frame
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 50
SUBI4
ASGNI4
line 1091
;1091:	hook->s.otherEntityNum = self->s.number; // use to match beam in client
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 1092
;1092:	VectorCopy( start, hook->s.pos.trBase );
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 1097
;1093:	// JUHOX: hook speed made variable
;1094:#if !GRAPPLE_ROPE
;1095:	VectorScale( dir, 800, hook->s.pos.trDelta );
;1096:#else
;1097:	VectorScale(dir, speed, hook->s.pos.trDelta);
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRFP4 8
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 1099
;1098:#endif
;1099:	SnapVector( hook->s.pos.trDelta );			// save net bandwidth
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 1100
;1100:	VectorCopy (start, hook->r.currentOrigin);
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 1102
;1101:
;1102:	self->client->hook = hook;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 884
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 1106
;1103:
;1104:	// JUHOX: insert first rope element
;1105:#if GRAPPLE_ROPE
;1106:	switch (g_grapple.integer) {
ADDRGP4 g_grapple+12
INDIRI4
CNSTI4 1
EQI4 $307
ADDRGP4 $306
JUMPV
line 1108
;1107:	case HM_classic:
;1108:		break;
LABELV $306
line 1110
;1109:	default:
;1110:		self->client->numRopeElements = 1;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1020
ADDP4
CNSTI4 1
ASGNI4
line 1111
;1111:		VectorCopy(start, self->client->ropeElements[0].pos);
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 1112
;1112:		VectorCopy(hook->s.pos.trDelta, self->client->ropeElements[0].velocity);
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1036
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRB
ASGNB 12
line 1113
;1113:		break;
LABELV $307
line 1118
;1114:	}
;1115:#endif
;1116:
;1117:#if GRAPPLE_ROPE
;1118:	self->client->lastTimeWinded = level.time;	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 5588
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1121
;1119:#endif
;1120:
;1121:	return hook;
ADDRLP4 0
INDIRP4
RETP4
LABELV $283
endproc fire_grapple 28 4
import trigger_push_touch
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
import trigger_teleporter_touch
import InitMover
import Touch_DoorTrigger
import G_RunMover
import fire_blaster
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
LABELV $280
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $276
byte 1 98
byte 1 102
byte 1 103
byte 1 0
align 1
LABELV $270
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 95
byte 1 115
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $259
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $249
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 0
align 1
LABELV $170
byte 1 104
byte 1 111
byte 1 111
byte 1 107
byte 1 0
