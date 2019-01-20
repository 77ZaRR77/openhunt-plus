export G_BounceProjectile
code
proc G_BounceProjectile 48 4
file "..\..\..\..\code\game\g_weapon.c"
line 19
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// g_weapon.c 
;4:// perform the server side effects of a weapon firing
;5:
;6:#include "g_local.h"
;7:
;8:static	float	s_quadFactor;
;9:static	vec3_t	forward, right, up;
;10:static	vec3_t	muzzle;
;11:
;12:#define NUM_NAILSHOTS 15
;13:
;14:/*
;15:================
;16:G_BounceProjectile
;17:================
;18:*/
;19:void G_BounceProjectile( vec3_t start, vec3_t impact, vec3_t dir, vec3_t endout ) {
line 23
;20:	vec3_t v, newv;
;21:	float dot;
;22:
;23:	VectorSubtract( impact, start, v );
ADDRLP4 28
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 32
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 28
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 24
;24:	dot = DotProduct( v, dir );
ADDRLP4 36
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 0
INDIRF4
ADDRLP4 36
INDIRP4
INDIRF4
MULF4
ADDRLP4 0+4
INDIRF4
ADDRLP4 36
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+8
INDIRF4
ADDRLP4 36
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 25
;25:	VectorMA( v, -2*dot, dir, newv );
ADDRLP4 40
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 0
INDIRF4
ADDRLP4 40
INDIRP4
INDIRF4
ADDRLP4 24
INDIRF4
CNSTF4 3221225472
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 24
INDIRF4
CNSTF4 3221225472
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 0+8
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 24
INDIRF4
CNSTF4 3221225472
MULF4
MULF4
ADDF4
ASGNF4
line 27
;26:
;27:	VectorNormalize(newv);
ADDRLP4 12
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 28
;28:	VectorMA(impact, 8192, newv, endout);
ADDRFP4 12
INDIRP4
ADDRFP4 4
INDIRP4
INDIRF4
ADDRLP4 12
INDIRF4
CNSTF4 1174405120
MULF4
ADDF4
ASGNF4
ADDRFP4 12
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 12+4
INDIRF4
CNSTF4 1174405120
MULF4
ADDF4
ASGNF4
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 12+8
INDIRF4
CNSTF4 1174405120
MULF4
ADDF4
ASGNF4
line 29
;29:}
LABELV $87
endproc G_BounceProjectile 48 4
export Weapon_Gauntlet
proc Weapon_Gauntlet 0 0
line 39
;30:
;31:/*
;32:======================================================================
;33:
;34:GAUNTLET
;35:
;36:======================================================================
;37:*/
;38:
;39:void Weapon_Gauntlet( gentity_t *ent ) {
line 41
;40:
;41:}
LABELV $98
endproc Weapon_Gauntlet 0 0
export CheckGauntletAttack
proc CheckGauntletAttack 128 32
line 48
;42:
;43:/*
;44:===============
;45:CheckGauntletAttack
;46:===============
;47:*/
;48:qboolean CheckGauntletAttack( gentity_t *ent ) {
line 59
;49:	trace_t		tr;
;50:	vec3_t		end;
;51:	gentity_t	*tent;
;52:	gentity_t	*traceEnt;
;53:	int			damage;
;54:
;55:	// set aiming directions
;56:#if !MONSTER_MODE	// JUHOX: accept monsters
;57:	AngleVectors (ent->client->ps.viewangles, forward, right, up);
;58:#else
;59:	AngleVectors(G_GetEntityPlayerState(ent)->viewangles, forward, right, up);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 80
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRGP4 right
ARGP4
ADDRGP4 up
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 62
;60:#endif
;61:
;62:	CalcMuzzlePoint ( ent, forward, right, up, muzzle );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRGP4 right
ARGP4
ADDRGP4 up
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 CalcMuzzlePoint
CALLV
pop
line 67
;63:
;64:#if 0	// JUHOX: slightly farther range, so you can attack somebody below you
;65:	VectorMA (muzzle, 32, forward, end);
;66:#else
;67:	VectorMA(muzzle, 32 + fabs(forward[2]) * 20, forward, end);
ADDRGP4 forward+8
INDIRF4
ARGF4
ADDRLP4 84
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 60
ADDRGP4 muzzle
INDIRF4
ADDRGP4 forward
INDIRF4
ADDRLP4 84
INDIRF4
CNSTF4 1101004800
MULF4
CNSTF4 1107296256
ADDF4
MULF4
ADDF4
ASGNF4
ADDRGP4 forward+8
INDIRF4
ARGF4
ADDRLP4 88
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 60+4
ADDRGP4 muzzle+4
INDIRF4
ADDRGP4 forward+4
INDIRF4
ADDRLP4 88
INDIRF4
CNSTF4 1101004800
MULF4
CNSTF4 1107296256
ADDF4
MULF4
ADDF4
ASGNF4
ADDRGP4 forward+8
INDIRF4
ARGF4
ADDRLP4 92
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 60+8
ADDRGP4 muzzle+8
INDIRF4
ADDRGP4 forward+8
INDIRF4
ADDRLP4 92
INDIRF4
CNSTF4 1101004800
MULF4
CNSTF4 1107296256
ADDF4
MULF4
ADDF4
ASGNF4
line 70
;68:#endif
;69:
;70:	trap_Trace (&tr, muzzle, NULL, NULL, end, ent->s.number, MASK_SHOT);
ADDRLP4 4
ARGP4
ADDRGP4 muzzle
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 60
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 71
;71:	if ( tr.surfaceFlags & SURF_NOIMPACT ) {
ADDRLP4 4+44
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $109
line 72
;72:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $99
JUMPV
LABELV $109
line 75
;73:	}
;74:
;75:	traceEnt = &g_entities[ tr.entityNum ];
ADDRLP4 0
ADDRLP4 4+52
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 89
;76:
;77:	// send blood impact
;78:	// JUHOX: the new gauntlet is so fast, not every hit should give a blood impact
;79:	// JUHOX BUGFIX: let bleed corpses too (& monsters)
;80:#if 0
;81:	if ( traceEnt->takedamage && traceEnt->client ) {
;82:		tent = G_TempEntity( tr.endpos, EV_MISSILE_HIT );
;83:		tent->s.otherEntityNum = traceEnt->s.number;
;84:		tent->s.eventParm = DirToByte( tr.plane.normal );
;85:		tent->s.weapon = ent->s.weapon;
;86:	}
;87:#else
;88:	if (
;89:		traceEnt->takedamage &&
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
CNSTI4 0
EQI4 $113
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 1
NEI4 $113
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $115
ADDRLP4 100
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 100
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 100
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1028443341
GEF4 $113
LABELV $115
line 97
;90:		traceEnt->s.eType == ET_PLAYER &&
;91:		(
;92:#if MONSTER_MODE
;93:			ent->monster ||
;94:#endif
;95:			random() < 0.05
;96:		)
;97:	) {
line 98
;98:		tent = G_TempEntity( tr.endpos, EV_MISSILE_HIT );
ADDRLP4 4+12
ARGP4
CNSTI4 51
ARGI4
ADDRLP4 104
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 72
ADDRLP4 104
INDIRP4
ASGNP4
line 99
;99:		tent->s.otherEntityNum = traceEnt->s.number;
ADDRLP4 72
INDIRP4
CNSTI4 140
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 100
;100:		tent->s.eventParm = DirToByte( tr.plane.normal );
ADDRLP4 4+24
ARGP4
ADDRLP4 108
ADDRGP4 DirToByte
CALLI4
ASGNI4
ADDRLP4 72
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 108
INDIRI4
ASGNI4
line 101
;101:		tent->s.weapon = ent->s.weapon;
ADDRLP4 72
INDIRP4
CNSTI4 192
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ASGNI4
line 102
;102:	}
LABELV $113
line 105
;103:#endif
;104:
;105:	if ( !traceEnt->takedamage) {
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
CNSTI4 0
NEI4 $118
line 106
;106:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $99
JUMPV
LABELV $118
line 111
;107:	}
;108:
;109:#if MONSTER_MODE	// JUHOX: don't let monsters hit other monsters
;110:	if (
;111:		ent->monster &&
ADDRLP4 104
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 104
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $120
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $120
ADDRLP4 104
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 112
ADDRGP4 G_IsFriendlyMonster
CALLI4
ASGNI4
ADDRLP4 112
INDIRI4
CNSTI4 0
EQI4 $120
line 114
;112:		traceEnt->monster &&
;113:		G_IsFriendlyMonster(ent, traceEnt)
;114:	) return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $99
JUMPV
LABELV $120
line 125
;115:#endif
;116:
;117:#if 0	// JUHOX: ignore quad
;118:	if (ent->client->ps.powerups[PW_QUAD] ) {
;119:		G_AddEvent( ent, EV_POWERUP_QUAD, 0 );
;120:		s_quadFactor = g_quadfactor.value;
;121:	} else {
;122:		s_quadFactor = 1;
;123:	}
;124:#else
;125:	s_quadFactor = 1;
ADDRGP4 s_quadFactor
CNSTF4 1065353216
ASGNF4
line 136
;126:#endif
;127:#ifdef MISSIONPACK
;128:	if( ent->client->persistantPowerup && ent->client->persistantPowerup->item && ent->client->persistantPowerup->item->giTag == PW_DOUBLER ) {
;129:		s_quadFactor *= 2;
;130:	}
;131:#endif
;132:
;133:#if 0	// JUHOX: new gauntlet damage
;134:	damage = 50 * s_quadFactor;
;135:#else
;136:	damage = 10;	// note that the gauntlet is much faster now
ADDRLP4 76
CNSTI4 10
ASGNI4
line 142
;137:#endif
;138:#if !MONSTER_MODE	// JUHOX: monsters do a special gauntlet damage
;139:	G_Damage( traceEnt, ent, ent, forward, tr.endpos,
;140:		damage, 0, MOD_GAUNTLET );
;141:#else
;142:	if (ent->monster) {
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $122
line 145
;143:		gentity_t* owner;
;144:
;145:		owner = G_MonsterOwner(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 120
ADDRGP4 G_MonsterOwner
CALLP4
ASGNP4
ADDRLP4 116
ADDRLP4 120
INDIRP4
ASGNP4
line 146
;146:		if (owner) {
ADDRLP4 116
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $124
line 147
;147:			G_Damage(traceEnt, ent, owner, forward, tr.endpos, 25, 0, MOD_MONSTER_LAUNCHER);
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 116
INDIRP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 4+12
ARGP4
CNSTI4 25
ARGI4
CNSTI4 0
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 148
;148:		}
ADDRGP4 $123
JUMPV
LABELV $124
line 149
;149:		else {
line 150
;150:			G_Damage(traceEnt, ent, ent, forward, tr.endpos, 25, 0, MOD_CLAW);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 124
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 124
INDIRP4
ARGP4
ADDRLP4 124
INDIRP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 4+12
ARGP4
CNSTI4 25
ARGI4
CNSTI4 0
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 151
;151:		}
line 152
;152:	}
ADDRGP4 $123
JUMPV
LABELV $122
line 153
;153:	else {
line 154
;154:		G_Damage(traceEnt, ent, ent, forward, tr.endpos, damage, 0, MOD_GAUNTLET);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 116
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 116
INDIRP4
ARGP4
ADDRLP4 116
INDIRP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 4+12
ARGP4
ADDRLP4 76
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 155
;155:	}
LABELV $123
line 158
;156:#endif
;157:
;158:	return qtrue;
CNSTI4 1
RETI4
LABELV $99
endproc CheckGauntletAttack 128 32
export CheckTitanAttack
proc CheckTitanAttack 100 32
line 167
;159:}
;160:
;161:/*
;162:===============
;163:JUHOX: CheckTitanAttack
;164:===============
;165:*/
;166:#if MONSTER_MODE
;167:qboolean CheckTitanAttack(gentity_t *ent) {
line 174
;168:	trace_t		tr;
;169:	vec3_t		end;
;170:	gentity_t	*tent;
;171:	gentity_t	*traceEnt;
;172:
;173:	// set aiming directions
;174:	AngleVectors(G_GetEntityPlayerState(ent)->viewangles, forward, right, up);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 76
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRGP4 right
ARGP4
ADDRGP4 up
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 176
;175:
;176:	CalcMuzzlePoint(ent, forward, right, up, muzzle);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRGP4 right
ARGP4
ADDRGP4 up
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 CalcMuzzlePoint
CALLV
pop
line 178
;177:
;178:	VectorMA(muzzle, 150, forward, end);
ADDRLP4 64
ADDRGP4 muzzle
INDIRF4
ADDRGP4 forward
INDIRF4
CNSTF4 1125515264
MULF4
ADDF4
ASGNF4
ADDRLP4 64+4
ADDRGP4 muzzle+4
INDIRF4
ADDRGP4 forward+4
INDIRF4
CNSTF4 1125515264
MULF4
ADDF4
ASGNF4
ADDRLP4 64+8
ADDRGP4 muzzle+8
INDIRF4
ADDRGP4 forward+8
INDIRF4
CNSTF4 1125515264
MULF4
ADDF4
ASGNF4
line 180
;179:
;180:	trap_Trace(&tr, muzzle, NULL, NULL, end, ent->s.number, MASK_SHOT);
ADDRLP4 8
ARGP4
ADDRGP4 muzzle
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 64
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 181
;181:	if (tr.surfaceFlags & SURF_NOIMPACT) return qfalse;
ADDRLP4 8+44
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $136
CNSTI4 0
RETI4
ADDRGP4 $129
JUMPV
LABELV $136
line 183
;182:
;183:	traceEnt = &g_entities[tr.entityNum];
ADDRLP4 4
ADDRLP4 8+52
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 185
;184:
;185:	if (!traceEnt->takedamage) return qfalse;
ADDRLP4 4
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
CNSTI4 0
NEI4 $140
CNSTI4 0
RETI4
ADDRGP4 $129
JUMPV
LABELV $140
line 188
;186:
;187:	// send blood impact
;188:	if (traceEnt->s.eType == ET_PLAYER) {
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 1
NEI4 $142
line 189
;189:		tent = G_TempEntity(tr.endpos, EV_MISSILE_HIT);
ADDRLP4 8+12
ARGP4
CNSTI4 51
ARGI4
ADDRLP4 80
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 80
INDIRP4
ASGNP4
line 190
;190:		tent->s.otherEntityNum = traceEnt->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
ADDRLP4 4
INDIRP4
INDIRI4
ASGNI4
line 191
;191:		tent->s.eventParm = DirToByte(tr.plane.normal);
ADDRLP4 8+24
ARGP4
ADDRLP4 84
ADDRGP4 DirToByte
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 84
INDIRI4
ASGNI4
line 192
;192:		tent->s.weapon = ent->s.weapon;
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ASGNI4
line 193
;193:	}
LABELV $142
line 195
;194:
;195:	tent = G_TempEntity(tr.endpos, EV_EARTHQUAKE);
ADDRLP4 8+12
ARGP4
CNSTI4 93
ARGI4
ADDRLP4 80
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 80
INDIRP4
ASGNP4
line 196
;196:	tent->s.angles[0] = 1.0;	// total time in seconds
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
CNSTF4 1065353216
ASGNF4
line 197
;197:	tent->s.angles[1] = 0.0;	// fade in time in seconds
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
CNSTF4 0
ASGNF4
line 198
;198:	tent->s.angles[2] = 1.0;	// fade out time in seconds
ADDRLP4 0
INDIRP4
CNSTI4 124
ADDP4
CNSTF4 1065353216
ASGNF4
line 199
;199:	tent->s.angles2[0] = 100.0;	// amplitude in percent
ADDRLP4 0
INDIRP4
CNSTI4 128
ADDP4
CNSTF4 1120403456
ASGNF4
line 200
;200:	tent->s.angles2[1] = -1;	// radius (negative = global)
ADDRLP4 0
INDIRP4
CNSTI4 132
ADDP4
CNSTF4 3212836864
ASGNF4
line 201
;201:	tent->s.time = qtrue;		// no sound (played separately in CG_FireWeapon())
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
CNSTI4 1
ASGNI4
line 204
;202:
;203:	if (
;204:		ent->monster &&
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $147
ADDRLP4 4
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $147
ADDRLP4 84
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 92
ADDRGP4 G_IsFriendlyMonster
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 0
EQI4 $147
line 207
;205:		traceEnt->monster &&
;206:		G_IsFriendlyMonster(ent, traceEnt)
;207:	) {
line 208
;208:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $129
JUMPV
LABELV $147
line 211
;209:	}
;210:
;211:	G_Damage(traceEnt, ent, ent, forward, tr.endpos, 100, 0, MOD_TITAN);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 96
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
ARGP4
ADDRLP4 96
INDIRP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 8+12
ARGP4
CNSTI4 100
ARGI4
CNSTI4 0
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 213
;212:
;213:	return qtrue;
CNSTI4 1
RETI4
LABELV $129
endproc CheckTitanAttack 100 32
export SnapVectorTowards
proc SnapVectorTowards 16 0
line 239
;214:}
;215:#endif
;216:
;217:
;218:/*
;219:======================================================================
;220:
;221:MACHINEGUN
;222:
;223:======================================================================
;224:*/
;225:
;226:/*
;227:======================
;228:SnapVectorTowards
;229:
;230:Round a vector to integers for more efficient network
;231:transmission, but make sure that it rounds towards a given point
;232:rather than blindly truncating.  This prevents it from truncating 
;233:into a wall.
;234:======================
;235:*/
;236:#if 0	// JUHOX: add a "const" to SnapVectorTowards()
;237:void SnapVectorTowards( vec3_t v, vec3_t to ) {
;238:#else
;239:void SnapVectorTowards(vec3_t v, const vec3_t to) {
line 243
;240:#endif
;241:	int		i;
;242:
;243:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $151
line 244
;244:		if ( to[i] <= v[i] ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
GTF4 $155
line 245
;245:			v[i] = (int)v[i];
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
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 246
;246:		} else {
ADDRGP4 $156
JUMPV
LABELV $155
line 247
;247:			v[i] = (int)v[i] + 1;
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
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
ADDP4
INDIRF4
CVFI4 4
CNSTI4 1
ADDI4
CVIF4 4
ASGNF4
line 248
;248:		}
LABELV $156
line 249
;249:	}
LABELV $152
line 243
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $151
line 250
;250:}
LABELV $150
endproc SnapVectorTowards 16 0
export Bullet_Fire
proc Bullet_Fire 100 32
line 259
;251:
;252:#ifdef MISSIONPACK
;253:#define CHAINGUN_SPREAD		600
;254:#endif
;255:#define MACHINEGUN_SPREAD	200
;256:#define	MACHINEGUN_DAMAGE	7
;257:#define	MACHINEGUN_TEAM_DAMAGE	5		// wimpier MG in teamplay
;258:
;259:void Bullet_Fire (gentity_t *ent, float spread, int damage ) {
line 272
;260:	trace_t		tr;
;261:	vec3_t		end;
;262:#ifdef MISSIONPACK
;263:	vec3_t		impactpoint, bouncedir;
;264:#endif
;265:	//float		r;	// JUHOX: no longer needed
;266:	//float		u;	// JUHOX: no longer needed
;267:	gentity_t	*tent;
;268:	gentity_t	*traceEnt;
;269:	int			i, passent;
;270:
;271:#if 1	// JUHOX: more machine gun damage
;272:	damage = 20;
ADDRFP4 8
CNSTI4 20
ASGNI4
line 274
;273:#endif
;274:	damage *= s_quadFactor;
ADDRFP4 8
ADDRFP4 8
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 285
;275:
;276:#if 0	// JUHOX: no machinegun spread
;277:	if (!(ent->client->ps.pm_flags & PMF_DUCKED)) spread *= 3.0;	// JUHOX
;278:	r = random() * M_PI * 2.0f;
;279:	u = sin(r) * crandom() * spread * 16;
;280:	r = cos(r) * crandom() * spread * 16;
;281:	VectorMA (muzzle, 8192*16, forward, end);
;282:	VectorMA (end, r, right, end);
;283:	VectorMA (end, u, up, end);
;284:#else
;285:	VectorMA(muzzle, 8192*16, forward, end);
ADDRLP4 68
ADDRGP4 muzzle
INDIRF4
ADDRGP4 forward
INDIRF4
CNSTF4 1207959552
MULF4
ADDF4
ASGNF4
ADDRLP4 68+4
ADDRGP4 muzzle+4
INDIRF4
ADDRGP4 forward+4
INDIRF4
CNSTF4 1207959552
MULF4
ADDF4
ASGNF4
ADDRLP4 68+8
ADDRGP4 muzzle+8
INDIRF4
ADDRGP4 forward+8
INDIRF4
CNSTF4 1207959552
MULF4
ADDF4
ASGNF4
line 288
;286:#endif
;287:
;288:	passent = ent->s.number;
ADDRLP4 80
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 289
;289:	for (i = 0; i < 10; i++) {
ADDRLP4 64
CNSTI4 0
ASGNI4
LABELV $164
line 291
;290:
;291:		trap_Trace (&tr, muzzle, NULL, NULL, end, passent, MASK_SHOT);
ADDRLP4 0
ARGP4
ADDRGP4 muzzle
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 68
ARGP4
ADDRLP4 80
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 292
;292:		if ( tr.surfaceFlags & SURF_NOIMPACT ) {
ADDRLP4 0+44
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $168
line 293
;293:			return;
ADDRGP4 $157
JUMPV
LABELV $168
line 296
;294:		}
;295:
;296:		traceEnt = &g_entities[ tr.entityNum ];
ADDRLP4 56
ADDRLP4 0+52
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 299
;297:
;298:		// snap the endpos to integers, but nudged towards the line
;299:		SnapVectorTowards( tr.endpos, muzzle );
ADDRLP4 0+12
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 SnapVectorTowards
CALLV
pop
line 305
;300:
;301:		// send bullet impact
;302:#if 0	// JUHOX BUGFIX: let corpses bleed too (& monsters)
;303:		if ( traceEnt->takedamage && traceEnt->client ) {
;304:#else
;305:		if (traceEnt->takedamage && traceEnt->s.eType == ET_PLAYER) {
ADDRLP4 56
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
CNSTI4 0
EQI4 $173
ADDRLP4 56
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 1
NEI4 $173
line 307
;306:#endif
;307:			tent = G_TempEntity( tr.endpos, EV_BULLET_HIT_FLESH );
ADDRLP4 0+12
ARGP4
CNSTI4 49
ARGI4
ADDRLP4 88
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 60
ADDRLP4 88
INDIRP4
ASGNP4
line 311
;308:#if !MONSTER_MODE	// JUHOX: eventParm sometimes doesn't work correctly, so we use otherEntityNum2
;309:			tent->s.eventParm = traceEnt->s.number;
;310:#else
;311:			tent->s.otherEntityNum2 = traceEnt->s.number;
ADDRLP4 60
INDIRP4
CNSTI4 144
ADDP4
ADDRLP4 56
INDIRP4
INDIRI4
ASGNI4
line 313
;312:#endif
;313:			if( LogAccuracyHit( traceEnt, ent ) ) {
ADDRLP4 56
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 92
ADDRGP4 LogAccuracyHit
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 0
EQI4 $174
line 314
;314:				ent->client->accuracy_hits++;
ADDRLP4 96
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 812
ADDP4
ASGNP4
ADDRLP4 96
INDIRP4
ADDRLP4 96
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 315
;315:			}
line 316
;316:		} else {
ADDRGP4 $174
JUMPV
LABELV $173
line 317
;317:			tent = G_TempEntity( tr.endpos, EV_BULLET_HIT_WALL );
ADDRLP4 0+12
ARGP4
CNSTI4 50
ARGI4
ADDRLP4 88
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 60
ADDRLP4 88
INDIRP4
ASGNP4
line 318
;318:			tent->s.eventParm = DirToByte( tr.plane.normal );
ADDRLP4 0+24
ARGP4
ADDRLP4 92
ADDRGP4 DirToByte
CALLI4
ASGNI4
ADDRLP4 60
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 92
INDIRI4
ASGNI4
line 319
;319:		}
LABELV $174
line 320
;320:		tent->s.otherEntityNum = ent->s.number;
ADDRLP4 60
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 322
;321:
;322:		if ( traceEnt->takedamage) {
ADDRLP4 56
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
CNSTI4 0
EQI4 $166
line 339
;323:#ifdef MISSIONPACK
;324:			if ( traceEnt->client && traceEnt->client->invulnerabilityTime > level.time ) {
;325:				if (G_InvulnerabilityEffect( traceEnt, forward, tr.endpos, impactpoint, bouncedir )) {
;326:					G_BounceProjectile( muzzle, impactpoint, bouncedir, end );
;327:					VectorCopy( impactpoint, muzzle );
;328:					// the player can hit him/herself with the bounced rail
;329:					passent = ENTITYNUM_NONE;
;330:				}
;331:				else {
;332:					VectorCopy( tr.endpos, muzzle );
;333:					passent = traceEnt->s.number;
;334:				}
;335:				continue;
;336:			}
;337:			else {
;338:#endif
;339:				G_Damage( traceEnt, ent, ent, forward, tr.endpos,
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 0+12
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 344
;340:					damage, 0, MOD_MACHINEGUN);
;341:#ifdef MISSIONPACK
;342:			}
;343:#endif
;344:		}
line 345
;345:		break;
ADDRGP4 $166
JUMPV
LABELV $165
line 289
ADDRLP4 64
ADDRLP4 64
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 10
LTI4 $164
LABELV $166
line 347
;346:	}
;347:}
LABELV $157
endproc Bullet_Fire 100 32
export BFG_Fire
proc BFG_Fire 16 12
line 358
;348:
;349:
;350:/*
;351:======================================================================
;352:
;353:BFG
;354:
;355:======================================================================
;356:*/
;357:
;358:void BFG_Fire ( gentity_t *ent ) {
line 361
;359:	gentity_t	*m;
;360:
;361:	m = fire_bfg (ent, muzzle, forward);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 4
ADDRGP4 fire_bfg
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 362
;362:	m->damage *= s_quadFactor;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 744
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 363
;363:	m->splashDamage *= s_quadFactor;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 748
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 365
;364:
;365:	ent->client->ps.powerups[PW_BFG_RELOADING] = level.time + 4000;	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 360
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 4000
ADDI4
ASGNI4
line 368
;366:
;367://	VectorAdd( m->s.pos.trDelta, ent->client->ps.velocity, m->s.pos.trDelta );	// "real" physics
;368:}
LABELV $183
endproc BFG_Fire 16 12
export ShotgunPellet
proc ShotgunPellet 104 32
line 383
;369:
;370:
;371:/*
;372:======================================================================
;373:
;374:SHOTGUN
;375:
;376:======================================================================
;377:*/
;378:
;379:// DEFAULT_SHOTGUN_SPREAD and DEFAULT_SHOTGUN_COUNT	are in bg_public.h, because
;380:// client predicts same spreads
;381:#define	DEFAULT_SHOTGUN_DAMAGE	12	// JUHOX: was 10
;382:
;383:qboolean ShotgunPellet( vec3_t start, vec3_t end, gentity_t *ent ) {
line 392
;384:	trace_t		tr;
;385:	int			damage, i, passent;
;386:	gentity_t	*traceEnt;
;387:#ifdef MISSIONPACK
;388:	vec3_t		impactpoint, bouncedir;
;389:#endif
;390:	vec3_t		tr_start, tr_end;
;391:
;392:	passent = ent->s.number;
ADDRLP4 64
ADDRFP4 8
INDIRP4
INDIRI4
ASGNI4
line 393
;393:	VectorCopy( start, tr_start );
ADDRLP4 68
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 394
;394:	VectorCopy( end, tr_end );
ADDRLP4 80
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 395
;395:	for (i = 0; i < 10; i++) {
ADDRLP4 60
CNSTI4 0
ASGNI4
LABELV $186
line 396
;396:		trap_Trace (&tr, tr_start, NULL, NULL, tr_end, passent, MASK_SHOT);
ADDRLP4 0
ARGP4
ADDRLP4 68
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 80
ARGP4
ADDRLP4 64
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 397
;397:		traceEnt = &g_entities[ tr.entityNum ];
ADDRLP4 56
ADDRLP4 0+52
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 400
;398:
;399:		// send bullet impact
;400:		if (  tr.surfaceFlags & SURF_NOIMPACT ) {
ADDRLP4 0+44
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $191
line 401
;401:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $185
JUMPV
LABELV $191
line 404
;402:		}
;403:
;404:		if ( traceEnt->takedamage) {
ADDRLP4 56
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
CNSTI4 0
EQI4 $194
line 405
;405:			damage = DEFAULT_SHOTGUN_DAMAGE * s_quadFactor;
ADDRLP4 92
ADDRGP4 s_quadFactor
INDIRF4
CNSTF4 1094713344
MULF4
CVFI4 4
ASGNI4
line 428
;406:#ifdef MISSIONPACK
;407:			if ( traceEnt->client && traceEnt->client->invulnerabilityTime > level.time ) {
;408:				if (G_InvulnerabilityEffect( traceEnt, forward, tr.endpos, impactpoint, bouncedir )) {
;409:					G_BounceProjectile( tr_start, impactpoint, bouncedir, tr_end );
;410:					VectorCopy( impactpoint, tr_start );
;411:					// the player can hit him/herself with the bounced rail
;412:					passent = ENTITYNUM_NONE;
;413:				}
;414:				else {
;415:					VectorCopy( tr.endpos, tr_start );
;416:					passent = traceEnt->s.number;
;417:				}
;418:				continue;
;419:			}
;420:			else {
;421:				G_Damage( traceEnt, ent, ent, forward, tr.endpos,
;422:					damage, 0, MOD_SHOTGUN);
;423:				if( LogAccuracyHit( traceEnt, ent ) ) {
;424:					return qtrue;
;425:				}
;426:			}
;427:#else
;428:			G_Damage( traceEnt, ent, ent, forward, tr.endpos,	damage, 0, MOD_SHOTGUN);
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 96
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
ARGP4
ADDRLP4 96
INDIRP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 0+12
ARGP4
ADDRLP4 92
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 429
;429:				if( LogAccuracyHit( traceEnt, ent ) ) {
ADDRLP4 56
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 100
ADDRGP4 LogAccuracyHit
CALLI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 0
EQI4 $197
line 430
;430:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $185
JUMPV
LABELV $197
line 433
;431:				}
;432:#endif
;433:		}
LABELV $194
line 434
;434:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $185
JUMPV
LABELV $187
line 395
ADDRLP4 60
ADDRLP4 60
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 10
LTI4 $186
line 436
;435:	}
;436:	return qfalse;
CNSTI4 0
RETI4
LABELV $185
endproc ShotgunPellet 104 32
export ShotgunPattern
proc ShotgunPattern 96 12
line 440
;437:}
;438:
;439:// this should match CG_ShotgunPattern
;440:void ShotgunPattern( vec3_t origin, vec3_t origin2, int seed, gentity_t *ent ) {
line 446
;441:	int			i;
;442:	float		r, u;
;443:	vec3_t		end;
;444:	vec3_t		forward, right, up;
;445:	int			oldScore;
;446:	qboolean	hitClient = qfalse;
ADDRLP4 60
CNSTI4 0
ASGNI4
line 450
;447:
;448:	// derive the right and up vectors from the forward vector, because
;449:	// the client won't have any other information
;450:	VectorNormalize2( origin2, forward );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 VectorNormalize2
CALLF4
pop
line 451
;451:	PerpendicularVector( right, forward );
ADDRLP4 32
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 PerpendicularVector
CALLV
pop
line 452
;452:	CrossProduct( forward, right, up );
ADDRLP4 20
ARGP4
ADDRLP4 32
ARGP4
ADDRLP4 44
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 454
;453:
;454:	oldScore = ent->client->ps.persistant[PERS_SCORE];
ADDRLP4 64
ADDRFP4 12
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
ASGNI4
line 457
;455:
;456:	// generate the "random" spread pattern
;457:	for ( i = 0 ; i < DEFAULT_SHOTGUN_COUNT ; i++ ) {
ADDRLP4 56
CNSTI4 0
ASGNI4
LABELV $200
line 458
;458:		r = Q_crandom( &seed ) * DEFAULT_SHOTGUN_SPREAD * 16;
ADDRFP4 8
ARGP4
ADDRLP4 68
ADDRGP4 Q_crandom
CALLF4
ASGNF4
ADDRLP4 12
ADDRLP4 68
INDIRF4
CNSTF4 1182400512
MULF4
ASGNF4
line 459
;459:		u = Q_crandom( &seed ) * DEFAULT_SHOTGUN_SPREAD * 16;
ADDRFP4 8
ARGP4
ADDRLP4 72
ADDRGP4 Q_crandom
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 72
INDIRF4
CNSTF4 1182400512
MULF4
ASGNF4
line 460
;460:		VectorMA( origin, 8192 * 16, forward, end);
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 76
INDIRP4
INDIRF4
ADDRLP4 20
INDIRF4
CNSTF4 1207959552
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 76
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 20+4
INDIRF4
CNSTF4 1207959552
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 20+8
INDIRF4
CNSTF4 1207959552
MULF4
ADDF4
ASGNF4
line 461
;461:		VectorMA (end, r, right, end);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 32
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 32+4
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 32+8
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
line 462
;462:		VectorMA (end, u, up, end);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 44
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 44+4
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 44+8
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDF4
ASGNF4
line 463
;463:		if( ShotgunPellet( origin, end, ent ) && !hitClient ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 88
ADDRGP4 ShotgunPellet
CALLI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 0
EQI4 $220
ADDRLP4 60
INDIRI4
CNSTI4 0
NEI4 $220
line 464
;464:			hitClient = qtrue;
ADDRLP4 60
CNSTI4 1
ASGNI4
line 465
;465:			ent->client->accuracy_hits++;
ADDRLP4 92
ADDRFP4 12
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 812
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 466
;466:		}
LABELV $220
line 467
;467:	}
LABELV $201
line 457
ADDRLP4 56
ADDRLP4 56
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 15
LTI4 $200
line 468
;468:}
LABELV $199
endproc ShotgunPattern 96 12
export weapon_supershotgun_fire
proc weapon_supershotgun_fire 20 16
line 471
;469:
;470:
;471:void weapon_supershotgun_fire (gentity_t *ent) {
line 475
;472:	gentity_t		*tent;
;473:
;474:	// send shotgun blast
;475:	tent = G_TempEntity( muzzle, EV_SHOTGUN );
ADDRGP4 muzzle
ARGP4
CNSTI4 55
ARGI4
ADDRLP4 4
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 476
;476:	VectorScale( forward, 4096, tent->s.origin2 );
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ADDRGP4 forward
INDIRF4
CNSTF4 1166016512
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
ADDRGP4 forward+4
INDIRF4
CNSTF4 1166016512
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 forward+8
INDIRF4
CNSTF4 1166016512
MULF4
ASGNF4
line 477
;477:	SnapVector( tent->s.origin2 );
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 478
;478:	tent->s.eventParm = rand() & 255;		// seed for spread pattern
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 255
BANDI4
ASGNI4
line 479
;479:	tent->s.otherEntityNum = ent->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 481
;480:
;481:	ShotgunPattern( tent->s.pos.trBase, tent->s.origin2, tent->s.eventParm, ent );
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 ShotgunPattern
CALLV
pop
line 482
;482:}
LABELV $222
endproc weapon_supershotgun_fire 20 16
export weapon_grenadelauncher_fire
proc weapon_grenadelauncher_fire 20 12
line 493
;483:
;484:
;485:/*
;486:======================================================================
;487:
;488:GRENADE LAUNCHER
;489:
;490:======================================================================
;491:*/
;492:
;493:void weapon_grenadelauncher_fire (gentity_t *ent) {
line 497
;494:	gentity_t	*m;
;495:
;496:	// extra vertical velocity
;497:	forward[2] += 0.2f;
ADDRLP4 4
ADDRGP4 forward+8
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
CNSTF4 1045220557
ADDF4
ASGNF4
line 498
;498:	VectorNormalize( forward );
ADDRGP4 forward
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 500
;499:
;500:	m = fire_grenade (ent, muzzle, forward);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 8
ADDRGP4 fire_grenade
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 501
;501:	m->damage *= s_quadFactor;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 744
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 502
;502:	m->splashDamage *= s_quadFactor;
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 748
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 505
;503:
;504://	VectorAdd( m->s.pos.trDelta, ent->client->ps.velocity, m->s.pos.trDelta );	// "real" physics
;505:}
LABELV $225
endproc weapon_grenadelauncher_fire 20 12
export weapon_monsterlauncher_fire
proc weapon_monsterlauncher_fire 12 12
line 516
;506:
;507:/*
;508:======================================================================
;509:
;510:JUHOX: MONSTER LAUNCHER
;511:
;512:======================================================================
;513:*/
;514:
;515:#if MONSTER_MODE
;516:void weapon_monsterlauncher_fire(gentity_t* ent) {
line 520
;517:	gentity_t* m;
;518:
;519:	// extra vertical velocity
;520:	forward[2] += 0.2f;
ADDRLP4 4
ADDRGP4 forward+8
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
CNSTF4 1045220557
ADDF4
ASGNF4
line 532
;521:	/*
;522:	{
;523:		float spread;
;524:
;525:		spread = 0.2;
;526:		if (ent->client->ps.pm_flags & PMF_DUCKED) spread *= 0.25;
;527:		forward[0] += crandom() * spread;
;528:		forward[1] += crandom() * spread;
;529:		forward[2] += crandom() * spread;
;530:	}
;531:	*/
;532:	VectorNormalize(forward);
ADDRGP4 forward
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 534
;533:
;534:	m = fire_monster_seed(ent, muzzle, forward);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 8
ADDRGP4 fire_monster_seed
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 535
;535:}
LABELV $227
endproc weapon_monsterlauncher_fire 12 12
export Weapon_RocketLauncher_Fire
proc Weapon_RocketLauncher_Fire 16 12
line 546
;536:#endif
;537:
;538:/*
;539:======================================================================
;540:
;541:ROCKET
;542:
;543:======================================================================
;544:*/
;545:
;546:void Weapon_RocketLauncher_Fire (gentity_t *ent) {
line 549
;547:	gentity_t	*m;
;548:
;549:	m = fire_rocket (ent, muzzle, forward);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 4
ADDRGP4 fire_rocket
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 550
;550:	m->damage *= s_quadFactor;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 744
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 551
;551:	m->splashDamage *= s_quadFactor;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 748
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 554
;552:
;553://	VectorAdd( m->s.pos.trDelta, ent->client->ps.velocity, m->s.pos.trDelta );	// "real" physics
;554:}
LABELV $229
endproc Weapon_RocketLauncher_Fire 16 12
export Weapon_Plasmagun_Fire
proc Weapon_Plasmagun_Fire 16 12
line 565
;555:
;556:
;557:/*
;558:======================================================================
;559:
;560:PLASMA GUN
;561:
;562:======================================================================
;563:*/
;564:
;565:void Weapon_Plasmagun_Fire (gentity_t *ent) {
line 568
;566:	gentity_t	*m;
;567:
;568:	m = fire_plasma (ent, muzzle, forward);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 4
ADDRGP4 fire_plasma
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 569
;569:	m->damage *= s_quadFactor;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 744
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 570
;570:	m->splashDamage *= s_quadFactor;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 748
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 573
;571:
;572://	VectorAdd( m->s.pos.trDelta, ent->client->ps.velocity, m->s.pos.trDelta );	// "real" physics
;573:}
LABELV $230
endproc Weapon_Plasmagun_Fire 16 12
export weapon_railgun_fire
proc weapon_railgun_fire 160 32
line 590
;574:
;575:/*
;576:======================================================================
;577:
;578:RAILGUN
;579:
;580:======================================================================
;581:*/
;582:
;583:
;584:/*
;585:=================
;586:weapon_railgun_fire
;587:=================
;588:*/
;589:#define	MAX_RAIL_HITS	4
;590:void weapon_railgun_fire (gentity_t *ent) {
line 608
;591:	vec3_t		end;
;592:#ifdef MISSIONPACK
;593:	vec3_t impactpoint, bouncedir;
;594:#endif
;595:	trace_t		trace;
;596:	gentity_t	*tent;
;597:	gentity_t	*traceEnt;
;598:	int			damage;
;599:	int			i;
;600:	int			hits;
;601:	int			unlinked;
;602:	int			passent;
;603:	gentity_t	*unlinkedEntities[MAX_RAIL_HITS];
;604:
;605:#if 0	// JUHOX: more railgun damage
;606:	damage = 100 * s_quadFactor;
;607:#else
;608:	damage = 200;
ADDRLP4 104
CNSTI4 200
ASGNI4
line 611
;609:#endif
;610:
;611:	VectorMA (muzzle, 8192, forward, end);
ADDRLP4 88
ADDRGP4 muzzle
INDIRF4
ADDRGP4 forward
INDIRF4
CNSTF4 1174405120
MULF4
ADDF4
ASGNF4
ADDRLP4 88+4
ADDRGP4 muzzle+4
INDIRF4
ADDRGP4 forward+4
INDIRF4
CNSTF4 1174405120
MULF4
ADDF4
ASGNF4
ADDRLP4 88+8
ADDRGP4 muzzle+8
INDIRF4
ADDRGP4 forward+8
INDIRF4
CNSTF4 1174405120
MULF4
ADDF4
ASGNF4
line 614
;612:
;613:	// trace only against the solids, so the railgun will go through people
;614:	unlinked = 0;
ADDRLP4 60
CNSTI4 0
ASGNI4
line 615
;615:	hits = 0;
ADDRLP4 108
CNSTI4 0
ASGNI4
line 616
;616:	passent = ent->s.number;
ADDRLP4 100
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
LABELV $238
line 617
;617:	do {
line 618
;618:		trap_Trace (&trace, muzzle, NULL, NULL, end, passent, MASK_SHOT );
ADDRLP4 4
ARGP4
ADDRGP4 muzzle
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 88
ARGP4
ADDRLP4 100
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 619
;619:		if ( trace.entityNum >= ENTITYNUM_MAX_NORMAL ) {
ADDRLP4 4+52
INDIRI4
CNSTI4 1022
LTI4 $241
line 620
;620:			break;
ADDRGP4 $240
JUMPV
LABELV $241
line 622
;621:		}
;622:		traceEnt = &g_entities[ trace.entityNum ];
ADDRLP4 0
ADDRLP4 4+52
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 623
;623:		if ( traceEnt->takedamage ) {
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
CNSTI4 0
EQI4 $245
line 652
;624:#ifdef MISSIONPACK
;625:			if ( traceEnt->client && traceEnt->client->invulnerabilityTime > level.time ) {
;626:				if ( G_InvulnerabilityEffect( traceEnt, forward, trace.endpos, impactpoint, bouncedir ) ) {
;627:					G_BounceProjectile( muzzle, impactpoint, bouncedir, end );
;628:					// snap the endpos to integers to save net bandwidth, but nudged towards the line
;629:					SnapVectorTowards( trace.endpos, muzzle );
;630:					// send railgun beam effect
;631:					tent = G_TempEntity( trace.endpos, EV_RAILTRAIL );
;632:					// set player number for custom colors on the railtrail
;633:					tent->s.clientNum = ent->s.clientNum;
;634:					VectorCopy( muzzle, tent->s.origin2 );
;635:					// move origin a bit to come closer to the drawn gun muzzle
;636:					VectorMA( tent->s.origin2, 4, right, tent->s.origin2 );
;637:					VectorMA( tent->s.origin2, -1, up, tent->s.origin2 );
;638:					tent->s.eventParm = 255;	// don't make the explosion at the end
;639:					//
;640:					VectorCopy( impactpoint, muzzle );
;641:					// the player can hit him/herself with the bounced rail
;642:					passent = ENTITYNUM_NONE;
;643:				}
;644:			}
;645:			else {
;646:				if( LogAccuracyHit( traceEnt, ent ) ) {
;647:					hits++;
;648:				}
;649:				G_Damage (traceEnt, ent, ent, forward, trace.endpos, damage, 0, MOD_RAILGUN);
;650:			}
;651:#else
;652:				if( LogAccuracyHit( traceEnt, ent ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 112
ADDRGP4 LogAccuracyHit
CALLI4
ASGNI4
ADDRLP4 112
INDIRI4
CNSTI4 0
EQI4 $247
line 653
;653:					hits++;
ADDRLP4 108
ADDRLP4 108
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 654
;654:				}
LABELV $247
line 655
;655:				G_Damage (traceEnt, ent, ent, forward, trace.endpos, damage, 0, MOD_RAILGUN);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 116
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 116
INDIRP4
ARGP4
ADDRLP4 116
INDIRP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 4+12
ARGP4
ADDRLP4 104
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 15
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 657
;656:#endif
;657:		}
LABELV $245
line 658
;658:		if ( trace.contents & CONTENTS_SOLID ) {
ADDRLP4 4+48
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $250
line 659
;659:			break;		// we hit something solid enough to stop the beam
ADDRGP4 $240
JUMPV
LABELV $250
line 662
;660:		}
;661:		// unlink this entity, so the next trace will go past it
;662:		trap_UnlinkEntity( traceEnt );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 663
;663:		unlinkedEntities[unlinked] = traceEnt;
ADDRLP4 60
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 664
;664:		unlinked++;
ADDRLP4 60
ADDRLP4 60
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 665
;665:	} while ( unlinked < MAX_RAIL_HITS );
LABELV $239
ADDRLP4 60
INDIRI4
CNSTI4 4
LTI4 $238
LABELV $240
line 668
;666:
;667:	// link back in any entities we unlinked
;668:	for ( i = 0 ; i < unlinked ; i++ ) {
ADDRLP4 64
CNSTI4 0
ASGNI4
ADDRGP4 $256
JUMPV
LABELV $253
line 669
;669:		trap_LinkEntity( unlinkedEntities[i] );
ADDRLP4 64
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 670
;670:	}
LABELV $254
line 668
ADDRLP4 64
ADDRLP4 64
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $256
ADDRLP4 64
INDIRI4
ADDRLP4 60
INDIRI4
LTI4 $253
line 675
;671:
;672:	// the final trace endpos will be the terminal point of the rail trail
;673:
;674:	// snap the endpos to integers to save net bandwidth, but nudged towards the line
;675:	SnapVectorTowards( trace.endpos, muzzle );
ADDRLP4 4+12
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 SnapVectorTowards
CALLV
pop
line 678
;676:
;677:	// send railgun beam effect
;678:	tent = G_TempEntity( trace.endpos, EV_RAILTRAIL );
ADDRLP4 4+12
ARGP4
CNSTI4 54
ARGI4
ADDRLP4 112
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 84
ADDRLP4 112
INDIRP4
ASGNP4
line 681
;679:
;680:	// set player number for custom colors on the railtrail
;681:	tent->s.clientNum = ent->s.clientNum;
ADDRLP4 84
INDIRP4
CNSTI4 168
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 683
;682:
;683:	VectorCopy( muzzle, tent->s.origin2 );
ADDRLP4 84
INDIRP4
CNSTI4 104
ADDP4
ADDRGP4 muzzle
INDIRB
ASGNB 12
line 685
;684:	// move origin a bit to come closer to the drawn gun muzzle
;685:	VectorMA( tent->s.origin2, 4, right, tent->s.origin2 );
ADDRLP4 84
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 84
INDIRP4
CNSTI4 104
ADDP4
INDIRF4
ADDRGP4 right
INDIRF4
CNSTF4 1082130432
MULF4
ADDF4
ASGNF4
ADDRLP4 84
INDIRP4
CNSTI4 108
ADDP4
ADDRLP4 84
INDIRP4
CNSTI4 108
ADDP4
INDIRF4
ADDRGP4 right+4
INDIRF4
CNSTF4 1082130432
MULF4
ADDF4
ASGNF4
ADDRLP4 84
INDIRP4
CNSTI4 112
ADDP4
ADDRLP4 84
INDIRP4
CNSTI4 112
ADDP4
INDIRF4
ADDRGP4 right+8
INDIRF4
CNSTF4 1082130432
MULF4
ADDF4
ASGNF4
line 686
;686:	VectorMA( tent->s.origin2, -1, up, tent->s.origin2 );
ADDRLP4 84
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 84
INDIRP4
CNSTI4 104
ADDP4
INDIRF4
ADDRGP4 up
INDIRF4
CNSTF4 3212836864
MULF4
ADDF4
ASGNF4
ADDRLP4 84
INDIRP4
CNSTI4 108
ADDP4
ADDRLP4 84
INDIRP4
CNSTI4 108
ADDP4
INDIRF4
ADDRGP4 up+4
INDIRF4
CNSTF4 3212836864
MULF4
ADDF4
ASGNF4
ADDRLP4 84
INDIRP4
CNSTI4 112
ADDP4
ADDRLP4 84
INDIRP4
CNSTI4 112
ADDP4
INDIRF4
ADDRGP4 up+8
INDIRF4
CNSTF4 3212836864
MULF4
ADDF4
ASGNF4
line 689
;687:
;688:	// no explosion at end if SURF_NOIMPACT, but still make the trail
;689:	if ( trace.surfaceFlags & SURF_NOIMPACT ) {
ADDRLP4 4+44
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $263
line 690
;690:		tent->s.eventParm = 255;	// don't make the explosion at the end
ADDRLP4 84
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 255
ASGNI4
line 691
;691:	} else {
ADDRGP4 $264
JUMPV
LABELV $263
line 692
;692:		tent->s.eventParm = DirToByte( trace.plane.normal );
ADDRLP4 4+24
ARGP4
ADDRLP4 140
ADDRGP4 DirToByte
CALLI4
ASGNI4
ADDRLP4 84
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 140
INDIRI4
ASGNI4
line 693
;693:	}
LABELV $264
line 694
;694:	tent->s.clientNum = ent->s.clientNum;
ADDRLP4 84
INDIRP4
CNSTI4 168
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 697
;695:
;696:#if MONSTER_MODE	// JUHOX: no rewards in STU
;697:	if (g_gametype.integer >= GT_STU) return;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
LTI4 $267
ADDRGP4 $231
JUMPV
LABELV $267
line 701
;698:#endif
;699:
;700:	// give the shooter a reward sound if they have made two railgun hits in a row
;701:	if ( hits == 0 ) {
ADDRLP4 108
INDIRI4
CNSTI4 0
NEI4 $270
line 703
;702:		// complete miss
;703:		ent->client->accurateCount = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 804
ADDP4
CNSTI4 0
ASGNI4
line 704
;704:	} else {
ADDRGP4 $271
JUMPV
LABELV $270
line 706
;705:		// check for "impressive" reward sound
;706:		ent->client->accurateCount += hits;
ADDRLP4 140
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 804
ADDP4
ASGNP4
ADDRLP4 140
INDIRP4
ADDRLP4 140
INDIRP4
INDIRI4
ADDRLP4 108
INDIRI4
ADDI4
ASGNI4
line 707
;707:		if ( ent->client->accurateCount >= 2 ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 804
ADDP4
INDIRI4
CNSTI4 2
LTI4 $272
line 708
;708:			ent->client->accurateCount -= 2;
ADDRLP4 144
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 804
ADDP4
ASGNP4
ADDRLP4 144
INDIRP4
ADDRLP4 144
INDIRP4
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 709
;709:			ent->client->ps.persistant[PERS_IMPRESSIVE_COUNT]++;
ADDRLP4 148
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 284
ADDP4
ASGNP4
ADDRLP4 148
INDIRP4
ADDRLP4 148
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 711
;710:			// add the sprite over the player's head
;711:			ent->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
ADDRLP4 152
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 152
INDIRP4
ADDRLP4 152
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 712
;712:			ent->client->ps.eFlags |= EF_AWARD_IMPRESSIVE;
ADDRLP4 156
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 156
INDIRP4
ADDRLP4 156
INDIRP4
INDIRI4
CNSTI4 32768
BORI4
ASGNI4
line 713
;713:			ent->client->rewardTime = level.time + REWARD_SPRITE_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 848
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 714
;714:		}
LABELV $272
line 715
;715:		ent->client->accuracy_hits++;
ADDRLP4 144
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 812
ADDP4
ASGNP4
ADDRLP4 144
INDIRP4
ADDRLP4 144
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 716
;716:	}
LABELV $271
line 718
;717:
;718:}
LABELV $231
endproc weapon_railgun_fire 160 32
export Weapon_GrapplingHook_Fire
proc Weapon_GrapplingHook_Fire 0 12
line 730
;719:
;720:
;721:/*
;722:======================================================================
;723:
;724:GRAPPLING HOOK
;725:
;726:======================================================================
;727:*/
;728:
;729:void Weapon_GrapplingHook_Fire (gentity_t *ent)
;730:{
line 732
;731:#if GRAPPLE_ROPE
;732:	if (g_grapple.integer <= HM_disabled || g_grapple.integer >= HM_num_modes) return;	// JUHOX
ADDRGP4 g_grapple+12
INDIRI4
CNSTI4 0
LEI4 $280
ADDRGP4 g_grapple+12
INDIRI4
CNSTI4 5
LTI4 $276
LABELV $280
ADDRGP4 $275
JUMPV
LABELV $276
line 739
;733:#endif
;734:
;735:#if 0	// JUHOX: fire grappling hook
;736:	if (/*!ent->client->fireHeld &&*/ !ent->client->hook)	// JUHOX
;737:		fire_grapple (ent, muzzle, forward);
;738:#else
;739:	if (!ent->client->hook) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 884
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $281
line 740
;740:		ent->client->offHandHook = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 880
ADDP4
CNSTI4 0
ASGNI4
line 741
;741:		fire_grapple(ent, muzzle, forward);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 forward
ARGP4
ADDRGP4 fire_grapple
CALLP4
pop
line 742
;742:	}
LABELV $281
line 745
;743:#endif
;744:
;745:	ent->client->fireHeld = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 876
ADDP4
CNSTI4 1
ASGNI4
line 746
;746:}
LABELV $275
endproc Weapon_GrapplingHook_Fire 0 12
export Weapon_GrapplingHook_Throw
proc Weapon_GrapplingHook_Throw 4 24
line 754
;747:
;748:void CalcMuzzlePointOrigin(gentity_t *ent, vec3_t origin, vec3_t forward, vec3_t right, vec3_t up, vec3_t muzzlePoint);
;749:/*
;750:================
;751:JUHOX: Weapon_GrapplingHook_Throw
;752:================
;753:*/
;754:void Weapon_GrapplingHook_Throw(gentity_t* ent) {
line 756
;755:#if GRAPPLE_ROPE
;756:	if (g_grapple.integer <= HM_disabled || g_grapple.integer >= HM_num_modes) return;
ADDRGP4 g_grapple+12
INDIRI4
CNSTI4 0
LEI4 $288
ADDRGP4 g_grapple+12
INDIRI4
CNSTI4 5
LTI4 $284
LABELV $288
ADDRGP4 $283
JUMPV
LABELV $284
line 759
;757:#endif
;758:#if ESCAPE_MODE
;759:	if (g_gametype.integer == GT_EFH) return;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
NEI4 $289
ADDRGP4 $283
JUMPV
LABELV $289
line 762
;760:#endif
;761:
;762:	if (!ent->client->hook) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 884
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $292
line 763
;763:		AngleVectors(ent->client->ps.viewangles, forward, right, up);
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRGP4 right
ARGP4
ADDRGP4 up
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 764
;764:		CalcMuzzlePointOrigin(ent, ent->client->oldOrigin, forward, right, up, muzzle);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 748
ADDP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRGP4 right
ARGP4
ADDRGP4 up
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 CalcMuzzlePointOrigin
CALLV
pop
line 765
;765:		ent->client->offHandHook = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 880
ADDP4
CNSTI4 1
ASGNI4
line 766
;766:		fire_grapple(ent, muzzle, forward);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 forward
ARGP4
ADDRGP4 fire_grapple
CALLP4
pop
line 767
;767:		G_AddEvent(ent, EV_THROW_HOOK, 0);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 94
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 768
;768:	}
ADDRGP4 $293
JUMPV
LABELV $292
line 769
;769:	else {
line 770
;770:		Weapon_HookFree(ent->client->hook);
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
line 771
;771:	}
LABELV $293
line 772
;772:}
LABELV $283
endproc Weapon_GrapplingHook_Throw 4 24
export Weapon_HookFree
proc Weapon_HookFree 16 12
line 775
;773:
;774:void Weapon_HookFree (gentity_t *ent)
;775:{
line 781
;776:#if !GRAPPLE_ROPE
;777:	ent->parent->client->hook = NULL;
;778:	ent->parent->client->ps.pm_flags &= ~PMF_GRAPPLE_PULL;
;779:	G_FreeEntity( ent );
;780:#else
;781:	if (!ent) return;
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $295
ADDRGP4 $294
JUMPV
LABELV $295
line 782
;782:	if (ent->parent && ent->parent->client && ent->parent->client->hook == ent) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 604
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $297
ADDRLP4 0
INDIRP4
CNSTI4 604
ADDP4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $297
ADDRLP4 0
INDIRP4
CNSTI4 604
ADDP4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 884
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 0
INDIRP4
CVPU4 4
NEU4 $297
line 786
;783:		gclient_t* client;
;784:		int i;
;785:
;786:		client = ent->parent->client;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 604
ADDP4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 787
;787:		if (!client->numRopeElements) {
ADDRLP4 8
INDIRP4
CNSTI4 1020
ADDP4
INDIRI4
CNSTI4 0
NEI4 $299
line 788
;788:			G_AddEvent(ent->parent, EV_ROPE_EXPLOSION, 1);	// click sound
ADDRFP4 0
INDIRP4
CNSTI4 604
ADDP4
INDIRP4
ARGP4
CNSTI4 95
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 789
;789:		}
LABELV $299
line 790
;790:		for (i = 0; i < MAX_ROPE_ELEMENTS / 8; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $301
line 791
;791:			if (!client->ropeEntities[i]) continue;
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 5504
ADDP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $305
ADDRGP4 $302
JUMPV
LABELV $305
line 793
;792:
;793:			if (client->numRopeElements) {
ADDRLP4 8
INDIRP4
CNSTI4 1020
ADDP4
INDIRI4
CNSTI4 0
EQI4 $307
line 794
;794:				client->ropeEntities[i]->think = G_FreeEntity;
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 5504
ADDP4
ADDP4
INDIRP4
CNSTI4 696
ADDP4
ADDRGP4 G_FreeEntity
ASGNP4
line 795
;795:				client->ropeEntities[i]->nextthink = level.time + 1000;
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 5504
ADDP4
ADDP4
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 796
;796:				G_AddEvent(client->ropeEntities[i], EV_ROPE_EXPLOSION, 0);
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 5504
ADDP4
ADDP4
INDIRP4
ARGP4
CNSTI4 95
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 797
;797:				client->ropeEntities[i]->s.time = level.time;
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 5504
ADDP4
ADDP4
INDIRP4
CNSTI4 84
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 798
;798:			}
ADDRGP4 $308
JUMPV
LABELV $307
line 799
;799:			else {
line 800
;800:				G_FreeEntity(client->ropeEntities[i]);
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 5504
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 801
;801:			}
LABELV $308
line 802
;802:			client->ropeEntities[i] = NULL;
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 5504
ADDP4
ADDP4
CNSTP4 0
ASGNP4
line 803
;803:		}
LABELV $302
line 790
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 20
LTI4 $301
line 804
;804:		client->numRopeElements = 0;
ADDRLP4 8
INDIRP4
CNSTI4 1020
ADDP4
CNSTI4 0
ASGNI4
line 805
;805:		client->ps.stats[STAT_GRAPPLE_STATE] = GST_unused;
ADDRLP4 8
INDIRP4
CNSTI4 228
ADDP4
CNSTI4 0
ASGNI4
line 807
;806:
;807:		client->hook = NULL;
ADDRLP4 8
INDIRP4
CNSTI4 884
ADDP4
CNSTP4 0
ASGNP4
line 808
;808:		client->ps.pm_flags &= ~PMF_GRAPPLE_PULL;
ADDRLP4 12
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 -2049
BANDI4
ASGNI4
line 809
;809:	}
LABELV $297
line 810
;810:	G_FreeEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 812
;811:#endif
;812:}
LABELV $294
endproc Weapon_HookFree 16 12
export Weapon_HookThink
proc Weapon_HookThink 40 8
line 815
;813:
;814:void Weapon_HookThink (gentity_t *ent)
;815:{
line 817
;816:#if 1	// JUHOX: update position of the hook attaching to a mover
;817:	if (ent->enemy && ent->enemy->s.number >= MAX_CLIENTS) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $312
ADDRLP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
INDIRI4
CNSTI4 64
LTI4 $312
line 820
;818:		vec3_t pos;
;819:
;820:		VectorAdd(ent->enemy->r.currentOrigin, ent->movedir, pos);	// JUHOX FIXME: movedir abused
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 680
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 16
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 684
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4+8
ADDRLP4 20
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 688
ADDP4
INDIRF4
ADDF4
ASGNF4
line 821
;821:		G_SetOrigin(ent, pos);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 822
;822:	}
ADDRGP4 $313
JUMPV
LABELV $312
line 825
;823:	else
;824:#endif
;825:	if (ent->enemy) {
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $316
line 829
;826:		vec3_t v, oldorigin;
;827:
;828:#if 1	// JUHOX BUGFIX: remove hook when player attached to dies
;829:		if (ent->enemy->health <= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
GTI4 $318
line 830
;830:			Weapon_HookFree(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Weapon_HookFree
CALLV
pop
line 831
;831:			return;
ADDRGP4 $311
JUMPV
LABELV $318
line 834
;832:		}
;833:#endif
;834:		VectorCopy(ent->r.currentOrigin, oldorigin);
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 835
;835:		v[0] = ent->enemy->r.currentOrigin[0] + (ent->enemy->r.mins[0] + ent->enemy->r.maxs[0]) * 0.5;
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 28
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 448
ADDP4
INDIRF4
ADDF4
CNSTF4 1056964608
MULF4
ADDF4
ASGNF4
line 836
;836:		v[1] = ent->enemy->r.currentOrigin[1] + (ent->enemy->r.mins[1] + ent->enemy->r.maxs[1]) * 0.5;
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4+4
ADDRLP4 32
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 440
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 452
ADDP4
INDIRF4
ADDF4
CNSTF4 1056964608
MULF4
ADDF4
ASGNF4
line 837
;837:		v[2] = ent->enemy->r.currentOrigin[2] + (ent->enemy->r.mins[2] + ent->enemy->r.maxs[2]) * 0.5;
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4+8
ADDRLP4 36
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRLP4 36
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 444
ADDP4
INDIRF4
ADDRLP4 36
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
ADDF4
CNSTF4 1056964608
MULF4
ADDF4
ASGNF4
line 838
;838:		SnapVectorTowards( v, oldorigin );	// save net bandwidth
ADDRLP4 4
ARGP4
ADDRLP4 16
ARGP4
ADDRGP4 SnapVectorTowards
CALLV
pop
line 840
;839:
;840:		G_SetOrigin( ent, v );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 841
;841:	}
LABELV $316
LABELV $313
line 843
;842:
;843:	VectorCopy( ent->r.currentOrigin, ent->parent->client->ps.grapplePoint);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 604
ADDP4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 845
;844:#if 1	// JUHOX BUGFIX: make hook think function called again next time
;845:	ent->nextthink = level.time + FRAMETIME;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 847
;846:#endif
;847:}
LABELV $311
endproc Weapon_HookThink 40 8
proc LightningVisibility 196 28
line 862
;848:
;849:/*
;850:======================================================================
;851:
;852:LIGHTNING GUN
;853:
;854:======================================================================
;855:*/
;856:
;857:/*
;858:================
;859:JUHOX: LightningVisibility
;860:================
;861:*/
;862:static qboolean LightningVisibility(gentity_t* ent, gentity_t* target) {
line 870
;863:	vec3_t origin;
;864:	vec3_t forwardDir;
;865:	vec3_t startPoint, endPoint;
;866:	int i, n;
;867:	float dist;
;868:	vec3_t dir;
;869:
;870:	VectorCopy(ent->s.pos.trBase, origin);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 871
;871:	origin[2] += 0.5 * DEFAULT_VIEWHEIGHT;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1095761920
ADDF4
ASGNF4
line 872
;872:	VectorCopy(origin, startPoint);
ADDRLP4 52
ADDRLP4 0
INDIRB
ASGNB 12
line 877
;873:	/*
;874:	VectorCopy(target->s.pos.trBase, endPoint);
;875:	endPoint[2] += 0.5 * DEFAULT_VIEWHEIGHT;
;876:	*/
;877:	VectorAdd(target->r.absmin, target->r.absmax, endPoint);
ADDRLP4 72
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 72
INDIRP4
CNSTI4 464
ADDP4
INDIRF4
ADDRLP4 72
INDIRP4
CNSTI4 476
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 72
INDIRP4
CNSTI4 468
ADDP4
INDIRF4
ADDRLP4 72
INDIRP4
CNSTI4 480
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 76
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12+8
ADDRLP4 76
INDIRP4
CNSTI4 472
ADDP4
INDIRF4
ADDRLP4 76
INDIRP4
CNSTI4 484
ADDP4
INDIRF4
ADDF4
ASGNF4
line 878
;878:	VectorScale(endPoint, 0.5, endPoint);
ADDRLP4 12
ADDRLP4 12
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 879
;879:	dist = Distance(origin, endPoint);
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 80
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRLP4 68
ADDRLP4 80
INDIRF4
ASGNF4
line 880
;880:	VectorScale(forward, dist, forwardDir);
ADDRLP4 24
ADDRGP4 forward
INDIRF4
ADDRLP4 68
INDIRF4
MULF4
ASGNF4
ADDRLP4 24+4
ADDRGP4 forward+4
INDIRF4
ADDRLP4 68
INDIRF4
MULF4
ASGNF4
ADDRLP4 24+8
ADDRGP4 forward+8
INDIRF4
ADDRLP4 68
INDIRF4
MULF4
ASGNF4
line 881
;881:	n = 10;	// NOTE: same approximation as in the client [see CG_LightningBolt()]
ADDRLP4 64
CNSTI4 10
ASGNI4
line 882
;882:	if (dist < 200) {
ADDRLP4 68
INDIRF4
CNSTF4 1128792064
GEF4 $335
line 883
;883:		n = dist / 20;
ADDRLP4 64
ADDRLP4 68
INDIRF4
CNSTF4 1028443341
MULF4
CVFI4 4
ASGNI4
line 884
;884:		if (n <= 0) n = 1;
ADDRLP4 64
INDIRI4
CNSTI4 0
GTI4 $337
ADDRLP4 64
CNSTI4 1
ASGNI4
LABELV $337
line 885
;885:	}
LABELV $335
line 886
;886:	dist /= n;	// segment length
ADDRLP4 68
ADDRLP4 68
INDIRF4
ADDRLP4 64
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 887
;887:	VectorSubtract(endPoint, startPoint, dir);
ADDRLP4 36
ADDRLP4 12
INDIRF4
ADDRLP4 52
INDIRF4
SUBF4
ASGNF4
ADDRLP4 36+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 52+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 36+8
ADDRLP4 12+8
INDIRF4
ADDRLP4 52+8
INDIRF4
SUBF4
ASGNF4
line 889
;888:
;889:	for (i = 0; i < n; i++) {
ADDRLP4 48
CNSTI4 0
ASGNI4
ADDRGP4 $348
JUMPV
LABELV $345
line 894
;890:		float x;
;891:		vec3_t p1, p2;
;892:		trace_t trace;
;893:
;894:		x = (float)(i+1) / n;
ADDRLP4 88
ADDRLP4 48
INDIRI4
CNSTI4 1
ADDI4
CVIF4 4
ADDRLP4 64
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 895
;895:		VectorMA(origin, x, forwardDir, p1);
ADDRLP4 104
ADDRLP4 0
INDIRF4
ADDRLP4 24
INDIRF4
ADDRLP4 88
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 104+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 24+4
INDIRF4
ADDRLP4 88
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 104+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 24+8
INDIRF4
ADDRLP4 88
INDIRF4
MULF4
ADDF4
ASGNF4
line 896
;896:		VectorMA(origin, x, dir, p2);
ADDRLP4 92
ADDRLP4 0
INDIRF4
ADDRLP4 36
INDIRF4
ADDRLP4 88
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 92+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 36+4
INDIRF4
ADDRLP4 88
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 92+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 36+8
INDIRF4
ADDRLP4 88
INDIRF4
MULF4
ADDF4
ASGNF4
line 897
;897:		VectorSubtract(p2, p1, p2);
ADDRLP4 92
ADDRLP4 92
INDIRF4
ADDRLP4 104
INDIRF4
SUBF4
ASGNF4
ADDRLP4 92+4
ADDRLP4 92+4
INDIRF4
ADDRLP4 104+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 92+8
ADDRLP4 92+8
INDIRF4
ADDRLP4 104+8
INDIRF4
SUBF4
ASGNF4
line 898
;898:		VectorMA(p1, x * x * x, p2, endPoint);
ADDRLP4 184
ADDRLP4 88
INDIRF4
ADDRLP4 88
INDIRF4
MULF4
ADDRLP4 88
INDIRF4
MULF4
ASGNF4
ADDRLP4 12
ADDRLP4 104
INDIRF4
ADDRLP4 92
INDIRF4
ADDRLP4 184
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 104+4
INDIRF4
ADDRLP4 92+4
INDIRF4
ADDRLP4 184
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 104+8
INDIRF4
ADDRLP4 92+8
INDIRF4
ADDRLP4 88
INDIRF4
ADDRLP4 88
INDIRF4
MULF4
ADDRLP4 88
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 900
;899:
;900:		trap_Trace(&trace, startPoint, NULL, NULL, endPoint, ent->s.number, MASK_SHOT);
ADDRLP4 116
ARGP4
ADDRLP4 52
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 12
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 901
;901:		if (trace.fraction < 1) {
ADDRLP4 116+8
INDIRF4
CNSTF4 1065353216
GEF4 $373
line 902
;902:			return trace.entityNum == target->s.number;
ADDRLP4 116+52
INDIRI4
ADDRFP4 4
INDIRP4
INDIRI4
NEI4 $378
ADDRLP4 192
CNSTI4 1
ASGNI4
ADDRGP4 $379
JUMPV
LABELV $378
ADDRLP4 192
CNSTI4 0
ASGNI4
LABELV $379
ADDRLP4 192
INDIRI4
RETI4
ADDRGP4 $323
JUMPV
LABELV $373
line 905
;903:		}
;904:
;905:		VectorCopy(endPoint, startPoint);
ADDRLP4 52
ADDRLP4 12
INDIRB
ASGNB 12
line 906
;906:	}
LABELV $346
line 889
ADDRLP4 48
ADDRLP4 48
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $348
ADDRLP4 48
INDIRI4
ADDRLP4 64
INDIRI4
LTI4 $345
line 907
;907:	return qtrue;
CNSTI4 1
RETI4
LABELV $323
endproc LightningVisibility 196 28
proc GetLightningTarget 88 16
line 915
;908:}
;909:
;910:/*
;911:================
;912:JUHOX: GetLightningTarget
;913:================
;914:*/
;915:static gentity_t* GetLightningTarget(gentity_t* ent) {
line 921
;916:	int i;
;917:	gentity_t* target;
;918:	float totalWeight;
;919:	vec3_t viewdir;
;920:
;921:	target = NULL;
ADDRLP4 20
CNSTP4 0
ASGNP4
line 922
;922:	totalWeight = 0;
ADDRLP4 16
CNSTF4 0
ASGNF4
line 923
;923:	AngleVectors(ent->client->ps.viewangles, viewdir, NULL, NULL);
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRLP4 4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 924
;924:	for (i = 0; i < level.num_entities; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $384
JUMPV
LABELV $381
line 932
;925:		gentity_t* other;
;926:		playerState_t* ps;
;927:		vec3_t dir;
;928:		float distance;
;929:		float alpha;
;930:		float weight;
;931:
;932:		other = &g_entities[i];
ADDRLP4 24
ADDRLP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 933
;933:		if (!other->inuse) continue;
ADDRLP4 24
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $386
ADDRGP4 $382
JUMPV
LABELV $386
line 934
;934:		if (!other->r.linked) continue;
ADDRLP4 24
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
CNSTI4 0
NEI4 $388
ADDRGP4 $382
JUMPV
LABELV $388
line 935
;935:		if (other->s.eType != ET_PLAYER) continue;
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 1
EQI4 $390
ADDRGP4 $382
JUMPV
LABELV $390
line 936
;936:		ps = G_GetEntityPlayerState(other);
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 28
ADDRLP4 56
INDIRP4
ASGNP4
line 937
;937:		if (!ps) continue;
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $392
ADDRGP4 $382
JUMPV
LABELV $392
line 938
;938:		if (ps->pm_type != PM_NORMAL) continue;
ADDRLP4 28
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $394
ADDRGP4 $382
JUMPV
LABELV $394
line 939
;939:		if (ps->stats[STAT_HEALTH] <= 0) continue;
ADDRLP4 28
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $396
ADDRGP4 $382
JUMPV
LABELV $396
line 941
;940:#if MONSTER_MODE
;941:		if (!G_CanBeDamaged(other)) continue;
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 G_CanBeDamaged
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
NEI4 $398
ADDRGP4 $382
JUMPV
LABELV $398
line 943
;942:#endif
;943:		if (other->client) {
ADDRLP4 24
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $400
line 944
;944:			if (other->client->pers.connected != CON_CONNECTED) continue;
ADDRLP4 24
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $402
ADDRGP4 $382
JUMPV
LABELV $402
line 945
;945:			if (other == ent) continue;
ADDRLP4 24
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
NEU4 $404
ADDRGP4 $382
JUMPV
LABELV $404
line 946
;946:		}
LABELV $400
line 948
;947:		if (
;948:			g_gametype.integer >= GT_TEAM &&
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $406
ADDRGP4 g_friendlyFire+12
INDIRI4
CNSTI4 0
NEI4 $406
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
ADDRLP4 28
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
NEI4 $406
line 951
;949:			!g_friendlyFire.integer &&
;950:			ent->client->sess.sessionTeam == ps->persistant[PERS_TEAM]
;951:		) {
line 952
;952:			continue;
ADDRGP4 $382
JUMPV
LABELV $406
line 955
;953:		}
;954:
;955:		VectorSubtract(ps->origin, ent->client->ps.origin, dir);
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
ADDRLP4 28
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 68
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 32+4
ADDRLP4 28
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 68
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 32+8
ADDRLP4 28
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
line 956
;956:		distance = VectorNormalize(dir);
ADDRLP4 32
ARGP4
ADDRLP4 72
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 44
ADDRLP4 72
INDIRF4
ASGNF4
line 957
;957:		if (distance > LIGHTNING_RANGE) continue;
ADDRLP4 44
INDIRF4
CNSTF4 1140457472
LEF4 $412
ADDRGP4 $382
JUMPV
LABELV $412
line 959
;958:
;959:		alpha = G_acos(DotProduct(dir, viewdir)) * (180.0 / M_PI);
ADDRLP4 32
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ADDRLP4 32+4
INDIRF4
ADDRLP4 4+4
INDIRF4
MULF4
ADDF4
ADDRLP4 32+8
INDIRF4
ADDRLP4 4+8
INDIRF4
MULF4
ADDF4
ARGF4
ADDRLP4 76
ADDRGP4 G_acos
CALLF4
ASGNF4
ADDRLP4 48
ADDRLP4 76
INDIRF4
CNSTF4 1113927393
MULF4
ASGNF4
line 960
;960:		if (distance < 100) {
ADDRLP4 44
INDIRF4
CNSTF4 1120403456
GEF4 $418
line 961
;961:			alpha *= distance / 100.0;
ADDRLP4 48
ADDRLP4 48
INDIRF4
ADDRLP4 44
INDIRF4
CNSTF4 1008981770
MULF4
MULF4
ASGNF4
line 962
;962:		}
LABELV $418
line 963
;963:		if (alpha >= LIGHTNING_ALPHA_LIMIT) continue;
ADDRLP4 48
INDIRF4
CNSTF4 1101004800
LTF4 $420
ADDRGP4 $382
JUMPV
LABELV $420
line 965
;964:
;965:		if (!LightningVisibility(ent, other)) continue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 80
ADDRGP4 LightningVisibility
CALLI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 0
NEI4 $422
ADDRGP4 $382
JUMPV
LABELV $422
line 967
;966:
;967:		weight = 10000.0/*arbitrary scale*/ / ((alpha + 10.0) * (distance + 100.0));
ADDRLP4 52
CNSTF4 1176256512
ADDRLP4 48
INDIRF4
CNSTF4 1092616192
ADDF4
ADDRLP4 44
INDIRF4
CNSTF4 1120403456
ADDF4
MULF4
DIVF4
ASGNF4
line 968
;968:		totalWeight += weight;
ADDRLP4 16
ADDRLP4 16
INDIRF4
ADDRLP4 52
INDIRF4
ADDF4
ASGNF4
line 969
;969:		if (random() <= weight / totalWeight) {
ADDRLP4 84
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 84
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 84
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
ADDRLP4 52
INDIRF4
ADDRLP4 16
INDIRF4
DIVF4
GTF4 $424
line 970
;970:			target = other;
ADDRLP4 20
ADDRLP4 24
INDIRP4
ASGNP4
line 971
;971:		}
LABELV $424
line 972
;972:	}
LABELV $382
line 924
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $384
ADDRLP4 0
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $381
line 974
;973:
;974:	if (target) {
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $426
line 975
;975:		ent->client->ps.stats[STAT_TARGET] = target->s.number;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 208
ADDP4
ADDRLP4 20
INDIRP4
INDIRI4
ASGNI4
line 976
;976:		SetTargetPos(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 SetTargetPos
CALLV
pop
line 977
;977:	}
ADDRGP4 $427
JUMPV
LABELV $426
line 978
;978:	else {
line 979
;979:		ent->client->ps.stats[STAT_TARGET] = ENTITYNUM_NONE;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 208
ADDP4
CNSTI4 1023
ASGNI4
line 980
;980:	}
LABELV $427
line 981
;981:	return target;
ADDRLP4 20
INDIRP4
RETP4
LABELV $380
endproc GetLightningTarget 88 16
export Weapon_LightningFire
proc Weapon_LightningFire 28 8
line 989
;982:}
;983:
;984:/*
;985:================
;986:JUHOX: Weapon_LightningFire (new version)
;987:================
;988:*/
;989:void Weapon_LightningFire(gentity_t* ent) {
line 995
;990:	gentity_t* target;
;991:	//gentity_t* tent;
;992:	int t;
;993:	playerState_t* ps;
;994:
;995:	target = GetLightningTarget(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 GetLightningTarget
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 996
;996:	if (!target) return;
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $429
ADDRGP4 $428
JUMPV
LABELV $429
line 998
;997:
;998:	if (LogAccuracyHit(target, ent)) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 LogAccuracyHit
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $431
line 999
;999:		ent->client->accuracy_hits++;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 812
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1000
;1000:	}
LABELV $431
line 1004
;1001:
;1002:	// minimum damage for feedback
;1003:	//G_Damage(target, ent, ent, forward, target->client->ps.origin, 1, 0, MOD_LIGHTNING);
;1004:	if (target->client) {
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $433
line 1005
;1005:		target->client->lasthurt_client = ent->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 820
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 1006
;1006:		target->client->lasthurt_mod = MOD_LIGHTNING;
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 824
ADDP4
CNSTI4 16
ASGNI4
line 1007
;1007:		target->client->lasthurt_time = level.time;	// JUHOX
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 828
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1008
;1008:	}
LABELV $433
line 1012
;1009:
;1010:	// charge the target
;1011:	//t = g_gametype.integer < GT_TEAM? 500 : 1000;
;1012:	t = 500;
ADDRLP4 8
CNSTI4 500
ASGNI4
line 1014
;1013:#if MONSTER_MODE
;1014:	if (g_gametype.integer >= GT_STU) t = 2000;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
LTI4 $436
ADDRLP4 8
CNSTI4 2000
ASGNI4
LABELV $436
line 1016
;1015:#endif
;1016:	if (g_baseHealth.integer > 1) {	// consider handicap
ADDRGP4 g_baseHealth+12
INDIRI4
CNSTI4 1
LEI4 $439
line 1017
;1017:		t = t * ent->client->ps.stats[STAT_MAX_HEALTH] / g_baseHealth.integer;
ADDRLP4 8
ADDRLP4 8
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
MULI4
ADDRGP4 g_baseHealth+12
INDIRI4
DIVI4
ASGNI4
line 1018
;1018:	}
LABELV $439
line 1019
;1019:	ps = G_GetEntityPlayerState(target);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 20
INDIRP4
ASGNP4
line 1020
;1020:	if (ps) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $443
line 1021
;1021:		if (ps->powerups[PW_CHARGE]) {
ADDRLP4 4
INDIRP4
CNSTI4 352
ADDP4
INDIRI4
CNSTI4 0
EQI4 $445
line 1022
;1022:			ps->powerups[PW_CHARGE] += t;
ADDRLP4 24
ADDRLP4 4
INDIRP4
CNSTI4 352
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
ADDRLP4 8
INDIRI4
ADDI4
ASGNI4
line 1023
;1023:		}
ADDRGP4 $446
JUMPV
LABELV $445
line 1024
;1024:		else {
line 1025
;1025:			ps->powerups[PW_CHARGE] = level.time + t;
ADDRLP4 4
INDIRP4
CNSTI4 352
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 8
INDIRI4
ADDI4
ASGNI4
line 1026
;1026:		}
LABELV $446
line 1027
;1027:		target->s.time2 = ps->powerups[PW_CHARGE];	// NOTE: time2 was unused before
ADDRLP4 0
INDIRP4
CNSTI4 88
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 352
ADDP4
INDIRI4
ASGNI4
line 1028
;1028:		target->chargeInflictor = ent->s.number;	// for rewarding
ADDRLP4 0
INDIRP4
CNSTI4 816
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 1029
;1029:	}
LABELV $443
line 1030
;1030:}
LABELV $428
endproc Weapon_LightningFire 28 8
export LogAccuracyHit
proc LogAccuracyHit 4 8
line 1174
;1031:
;1032:#if 0	// JUHOX: new version of Weapon_LightningFire() above
;1033:void Weapon_LightningFire( gentity_t *ent ) {
;1034:	trace_t		tr;
;1035:	vec3_t		end;
;1036:#ifdef MISSIONPACK
;1037:	vec3_t impactpoint, bouncedir;
;1038:#endif
;1039:	gentity_t	*traceEnt, *tent;
;1040:	int			damage, i, passent;
;1041:
;1042:	damage = 8 * s_quadFactor;
;1043:
;1044:	passent = ent->s.number;
;1045:	for (i = 0; i < 10; i++) {
;1046:		VectorMA( muzzle, LIGHTNING_RANGE, forward, end );
;1047:
;1048:		trap_Trace( &tr, muzzle, NULL, NULL, end, passent, MASK_SHOT );
;1049:
;1050:#ifdef MISSIONPACK
;1051:		// if not the first trace (the lightning bounced of an invulnerability sphere)
;1052:		if (i) {
;1053:			// add bounced off lightning bolt temp entity
;1054:			// the first lightning bolt is a cgame only visual
;1055:			//
;1056:			tent = G_TempEntity( muzzle, EV_LIGHTNINGBOLT );
;1057:			VectorCopy( tr.endpos, end );
;1058:			SnapVector( end );
;1059:			VectorCopy( end, tent->s.origin2 );
;1060:		}
;1061:#endif
;1062:		if ( tr.entityNum == ENTITYNUM_NONE ) {
;1063:			return;
;1064:		}
;1065:
;1066:		traceEnt = &g_entities[ tr.entityNum ];
;1067:
;1068:		if ( traceEnt->takedamage) {
;1069:#ifdef MISSIONPACK
;1070:			if ( traceEnt->client && traceEnt->client->invulnerabilityTime > level.time ) {
;1071:				if (G_InvulnerabilityEffect( traceEnt, forward, tr.endpos, impactpoint, bouncedir )) {
;1072:					G_BounceProjectile( muzzle, impactpoint, bouncedir, end );
;1073:					VectorCopy( impactpoint, muzzle );
;1074:					VectorSubtract( end, impactpoint, forward );
;1075:					VectorNormalize(forward);
;1076:					// the player can hit him/herself with the bounced lightning
;1077:					passent = ENTITYNUM_NONE;
;1078:				}
;1079:				else {
;1080:					VectorCopy( tr.endpos, muzzle );
;1081:					passent = traceEnt->s.number;
;1082:				}
;1083:				continue;
;1084:			}
;1085:			else {
;1086:				G_Damage( traceEnt, ent, ent, forward, tr.endpos,
;1087:					damage, 0, MOD_LIGHTNING);
;1088:			}
;1089:#else
;1090:				G_Damage( traceEnt, ent, ent, forward, tr.endpos,
;1091:					damage, 0, MOD_LIGHTNING);
;1092:#endif
;1093:		}
;1094:
;1095:#if 0	// JUHOX BUGFIX: let corpses bleed too (& monsters)
;1096:		if ( traceEnt->takedamage && traceEnt->client ) {
;1097:#else
;1098:		if (traceEnt->takedamage && traceEnt->s.eType == ET_PLAYER) {
;1099:#endif
;1100:			tent = G_TempEntity( tr.endpos, EV_MISSILE_HIT );
;1101:			tent->s.otherEntityNum = traceEnt->s.number;
;1102:			tent->s.eventParm = DirToByte( tr.plane.normal );
;1103:			tent->s.weapon = ent->s.weapon;
;1104:			if( LogAccuracyHit( traceEnt, ent ) ) {
;1105:				ent->client->accuracy_hits++;
;1106:			}
;1107:		} else if ( !( tr.surfaceFlags & SURF_NOIMPACT ) ) {
;1108:			tent = G_TempEntity( tr.endpos, EV_MISSILE_MISS );
;1109:			tent->s.eventParm = DirToByte( tr.plane.normal );
;1110:		}
;1111:
;1112:		break;
;1113:	}
;1114:}
;1115:#endif
;1116:
;1117:#ifdef MISSIONPACK
;1118:/*
;1119:======================================================================
;1120:
;1121:NAILGUN
;1122:
;1123:======================================================================
;1124:*/
;1125:
;1126:void Weapon_Nailgun_Fire (gentity_t *ent) {
;1127:	gentity_t	*m;
;1128:	int			count;
;1129:
;1130:	for( count = 0; count < NUM_NAILSHOTS; count++ ) {
;1131:		m = fire_nail (ent, muzzle, forward, right, up );
;1132:		if (!m) return;	// JUHOX BUGFIX
;1133:		m->damage *= s_quadFactor;
;1134:		m->splashDamage *= s_quadFactor;
;1135:	}
;1136:
;1137://	VectorAdd( m->s.pos.trDelta, ent->client->ps.velocity, m->s.pos.trDelta );	// "real" physics
;1138:}
;1139:
;1140:
;1141:/*
;1142:======================================================================
;1143:
;1144:PROXIMITY MINE LAUNCHER
;1145:
;1146:======================================================================
;1147:*/
;1148:
;1149:void weapon_proxlauncher_fire (gentity_t *ent) {
;1150:	gentity_t	*m;
;1151:
;1152:	// extra vertical velocity
;1153:	forward[2] += 0.2f;
;1154:	VectorNormalize( forward );
;1155:
;1156:	m = fire_prox (ent, muzzle, forward);
;1157:	if (!m) return;	// JUHOX BUGFIX
;1158:	m->damage *= s_quadFactor;
;1159:	m->splashDamage *= s_quadFactor;
;1160:
;1161://	VectorAdd( m->s.pos.trDelta, ent->client->ps.velocity, m->s.pos.trDelta );	// "real" physics
;1162:}
;1163:
;1164:#endif
;1165:
;1166://======================================================================
;1167:
;1168:
;1169:/*
;1170:===============
;1171:LogAccuracyHit
;1172:===============
;1173:*/
;1174:qboolean LogAccuracyHit( gentity_t *target, gentity_t *attacker ) {
line 1175
;1175:	if( !target->takedamage ) {
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
CNSTI4 0
NEI4 $449
line 1176
;1176:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $448
JUMPV
LABELV $449
line 1179
;1177:	}
;1178:
;1179:	if ( target == attacker ) {
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CVPU4 4
NEU4 $451
line 1180
;1180:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $448
JUMPV
LABELV $451
line 1183
;1181:	}
;1182:
;1183:	if( !target->client ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $453
line 1184
;1184:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $448
JUMPV
LABELV $453
line 1187
;1185:	}
;1186:
;1187:	if( !attacker->client ) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $455
line 1188
;1188:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $448
JUMPV
LABELV $455
line 1191
;1189:	}
;1190:
;1191:	if( target->client->ps.stats[STAT_HEALTH] <= 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $457
line 1192
;1192:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $448
JUMPV
LABELV $457
line 1195
;1193:	}
;1194:
;1195:	if ( OnSameTeam( target, attacker ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $459
line 1196
;1196:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $448
JUMPV
LABELV $459
line 1199
;1197:	}
;1198:
;1199:	return qtrue;
CNSTI4 1
RETI4
LABELV $448
endproc LogAccuracyHit 4 8
export CalcMuzzlePoint
proc CalcMuzzlePoint 24 4
line 1210
;1200:}
;1201:
;1202:
;1203:/*
;1204:===============
;1205:CalcMuzzlePoint
;1206:
;1207:set muzzle location relative to pivoting eye
;1208:===============
;1209:*/
;1210:void CalcMuzzlePoint ( gentity_t *ent, vec3_t forward, vec3_t right, vec3_t up, vec3_t muzzlePoint ) {
line 1211
;1211:	VectorCopy( ent->s.pos.trBase, muzzlePoint );
ADDRFP4 16
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 1215
;1212:#if !MONSTER_MODE	// JUHOX: accept monsters
;1213:	muzzlePoint[2] += ent->client->ps.viewheight;
;1214:#else
;1215:	muzzlePoint[2] += G_GetEntityPlayerState(ent)->viewheight;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 4
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1221
;1216:#endif
;1217:#if 0	// JUHOX: don't move muzzle point for hit-scan weapons
;1218:	VectorMA( muzzlePoint, 14, forward, muzzlePoint );
;1219:#else
;1220:	if (
;1221:		ent->s.weapon != WP_MACHINEGUN &&
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 2
EQI4 $462
ADDRLP4 8
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 3
EQI4 $462
ADDRLP4 8
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 6
EQI4 $462
ADDRLP4 8
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 7
EQI4 $462
line 1225
;1222:		ent->s.weapon != WP_SHOTGUN &&
;1223:		ent->s.weapon != WP_LIGHTNING &&
;1224:		ent->s.weapon != WP_RAILGUN
;1225:	) {
line 1226
;1226:		VectorMA(muzzlePoint, 14, forward, muzzlePoint);	
ADDRLP4 12
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
ADDRFP4 4
INDIRP4
INDIRF4
CNSTF4 1096810496
MULF4
ADDF4
ASGNF4
ADDRLP4 16
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1096810496
MULF4
ADDF4
ASGNF4
ADDRLP4 20
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1096810496
MULF4
ADDF4
ASGNF4
line 1227
;1227:	}
LABELV $462
line 1230
;1228:#endif
;1229:	// snap to integer coordinates for more efficient network bandwidth usage
;1230:	SnapVector( muzzlePoint );
ADDRLP4 12
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 16
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 20
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 1231
;1231:}
LABELV $461
endproc CalcMuzzlePoint 24 4
export CalcMuzzlePointOrigin
proc CalcMuzzlePointOrigin 24 4
line 1240
;1232:
;1233:/*
;1234:===============
;1235:CalcMuzzlePointOrigin
;1236:
;1237:set muzzle location relative to pivoting eye
;1238:===============
;1239:*/
;1240:void CalcMuzzlePointOrigin ( gentity_t *ent, vec3_t origin, vec3_t forward, vec3_t right, vec3_t up, vec3_t muzzlePoint ) {
line 1241
;1241:	VectorCopy( ent->s.pos.trBase, muzzlePoint );
ADDRFP4 20
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 1245
;1242:#if !MONSTER_MODE	// JUHOX: accept monsters
;1243:	muzzlePoint[2] += ent->client->ps.viewheight;
;1244:#else
;1245:	muzzlePoint[2] += G_GetEntityPlayerState(ent)->viewheight;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 4
ADDRFP4 20
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1251
;1246:#endif
;1247:#if 0	// JUHOX: don't move muzzle point for hit-scan weapons
;1248:	VectorMA( muzzlePoint, 14, forward, muzzlePoint );
;1249:#else
;1250:	if (
;1251:		ent->s.weapon != WP_MACHINEGUN &&
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 2
EQI4 $465
ADDRLP4 8
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 3
EQI4 $465
ADDRLP4 8
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 6
EQI4 $465
ADDRLP4 8
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 7
EQI4 $465
line 1255
;1252:		ent->s.weapon != WP_SHOTGUN &&
;1253:		ent->s.weapon != WP_LIGHTNING &&
;1254:		ent->s.weapon != WP_RAILGUN
;1255:	) {
line 1256
;1256:		VectorMA(muzzlePoint, 14, forward, muzzlePoint);	
ADDRLP4 12
ADDRFP4 20
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
ADDRFP4 8
INDIRP4
INDIRF4
CNSTF4 1096810496
MULF4
ADDF4
ASGNF4
ADDRLP4 16
ADDRFP4 20
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1096810496
MULF4
ADDF4
ASGNF4
ADDRLP4 20
ADDRFP4 20
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1096810496
MULF4
ADDF4
ASGNF4
line 1257
;1257:	}
LABELV $465
line 1260
;1258:#endif
;1259:	// snap to integer coordinates for more efficient network bandwidth usage
;1260:	SnapVector( muzzlePoint );
ADDRLP4 12
ADDRFP4 20
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 16
ADDRFP4 20
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 20
ADDRFP4 20
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 1261
;1261:}
LABELV $464
endproc CalcMuzzlePointOrigin 24 4
export FireWeapon
proc FireWeapon 16 24
line 1270
;1262:
;1263:
;1264:
;1265:/*
;1266:===============
;1267:FireWeapon
;1268:===============
;1269:*/
;1270:void FireWeapon( gentity_t *ent ) {
line 1278
;1271:#if 0	// JUHOX: ignore quad
;1272:	if (ent->client->ps.powerups[PW_QUAD] ) {
;1273:		s_quadFactor = g_quadfactor.value;
;1274:	} else {
;1275:		s_quadFactor = 1;
;1276:	}
;1277:#else
;1278:	s_quadFactor = 1;
ADDRGP4 s_quadFactor
CNSTF4 1065353216
ASGNF4
line 1287
;1279:#endif
;1280:#ifdef MISSIONPACK
;1281:	if( ent->client->persistantPowerup && ent->client->persistantPowerup->item && ent->client->persistantPowerup->item->giTag == PW_DOUBLER ) {
;1282:		s_quadFactor *= 2;
;1283:	}
;1284:#endif
;1285:
;1286:	// track shots taken for accuracy tracking.  Grapple is not a weapon and gauntet is just not tracked
;1287:	if( ent->s.weapon != WP_GRAPPLING_HOOK && ent->s.weapon != WP_GAUNTLET ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 10
EQI4 $468
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 1
EQI4 $468
line 1295
;1288:#ifdef MISSIONPACK
;1289:		if( ent->s.weapon == WP_NAILGUN ) {
;1290:			ent->client->accuracy_shots += NUM_NAILSHOTS;
;1291:		} else {
;1292:			ent->client->accuracy_shots++;
;1293:		}
;1294:#else
;1295:		ent->client->accuracy_shots++;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 808
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1297
;1296:#endif
;1297:	}
LABELV $468
line 1300
;1298:
;1299:	// set aiming directions
;1300:	AngleVectors (ent->client->ps.viewangles, forward, right, up);
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRGP4 right
ARGP4
ADDRGP4 up
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 1302
;1301:
;1302:	CalcMuzzlePointOrigin ( ent, ent->client->oldOrigin, forward, right, up, muzzle );
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 748
ADDP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRGP4 right
ARGP4
ADDRGP4 up
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 CalcMuzzlePointOrigin
CALLV
pop
line 1305
;1303:
;1304:	// fire the specific weapon
;1305:	switch( ent->s.weapon ) {
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 1
LTI4 $471
ADDRLP4 8
INDIRI4
CNSTI4 11
GTI4 $471
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $487-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $487
address $473
address $476
address $475
address $480
address $481
address $474
address $483
address $482
address $484
address $485
address $486
code
LABELV $473
line 1307
;1306:	case WP_GAUNTLET:
;1307:		Weapon_Gauntlet( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Weapon_Gauntlet
CALLV
pop
line 1308
;1308:		break;
ADDRGP4 $471
JUMPV
LABELV $474
line 1310
;1309:	case WP_LIGHTNING:
;1310:		Weapon_LightningFire( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Weapon_LightningFire
CALLV
pop
line 1311
;1311:		break;
ADDRGP4 $471
JUMPV
LABELV $475
line 1313
;1312:	case WP_SHOTGUN:
;1313:		weapon_supershotgun_fire( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 weapon_supershotgun_fire
CALLV
pop
line 1314
;1314:		break;
ADDRGP4 $471
JUMPV
LABELV $476
line 1316
;1315:	case WP_MACHINEGUN:
;1316:		if ( g_gametype.integer != GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
EQI4 $477
line 1317
;1317:			Bullet_Fire( ent, MACHINEGUN_SPREAD, MACHINEGUN_DAMAGE );
ADDRFP4 0
INDIRP4
ARGP4
CNSTF4 1128792064
ARGF4
CNSTI4 7
ARGI4
ADDRGP4 Bullet_Fire
CALLV
pop
line 1318
;1318:		} else {
ADDRGP4 $471
JUMPV
LABELV $477
line 1319
;1319:			Bullet_Fire( ent, MACHINEGUN_SPREAD, MACHINEGUN_TEAM_DAMAGE );
ADDRFP4 0
INDIRP4
ARGP4
CNSTF4 1128792064
ARGF4
CNSTI4 5
ARGI4
ADDRGP4 Bullet_Fire
CALLV
pop
line 1320
;1320:		}
line 1321
;1321:		break;
ADDRGP4 $471
JUMPV
LABELV $480
line 1323
;1322:	case WP_GRENADE_LAUNCHER:
;1323:		weapon_grenadelauncher_fire( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 weapon_grenadelauncher_fire
CALLV
pop
line 1324
;1324:		break;
ADDRGP4 $471
JUMPV
LABELV $481
line 1326
;1325:	case WP_ROCKET_LAUNCHER:
;1326:		Weapon_RocketLauncher_Fire( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Weapon_RocketLauncher_Fire
CALLV
pop
line 1327
;1327:		break;
ADDRGP4 $471
JUMPV
LABELV $482
line 1329
;1328:	case WP_PLASMAGUN:
;1329:		Weapon_Plasmagun_Fire( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Weapon_Plasmagun_Fire
CALLV
pop
line 1330
;1330:		break;
ADDRGP4 $471
JUMPV
LABELV $483
line 1332
;1331:	case WP_RAILGUN:
;1332:		weapon_railgun_fire( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 weapon_railgun_fire
CALLV
pop
line 1333
;1333:		break;
ADDRGP4 $471
JUMPV
LABELV $484
line 1335
;1334:	case WP_BFG:
;1335:		BFG_Fire( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BFG_Fire
CALLV
pop
line 1336
;1336:		break;
ADDRGP4 $471
JUMPV
LABELV $485
line 1338
;1337:	case WP_GRAPPLING_HOOK:
;1338:		Weapon_GrapplingHook_Fire( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Weapon_GrapplingHook_Fire
CALLV
pop
line 1339
;1339:		break;
ADDRGP4 $471
JUMPV
LABELV $486
line 1342
;1340:#if MONSTER_MODE	// JUHOX: fire monster launcher
;1341:	case WP_MONSTER_LAUNCHER:
;1342:		weapon_monsterlauncher_fire(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 weapon_monsterlauncher_fire
CALLV
pop
line 1343
;1343:		break;
line 1358
;1344:#endif
;1345:#ifdef MISSIONPACK
;1346:	case WP_NAILGUN:
;1347:		Weapon_Nailgun_Fire( ent );
;1348:		break;
;1349:	case WP_PROX_LAUNCHER:
;1350:		weapon_proxlauncher_fire( ent );
;1351:		break;
;1352:	case WP_CHAINGUN:
;1353:		Bullet_Fire( ent, CHAINGUN_SPREAD, MACHINEGUN_DAMAGE );
;1354:		break;
;1355:#endif
;1356:	default:
;1357:// FIXME		G_Error( "Bad ent->s.weapon" );
;1358:		break;
LABELV $471
line 1360
;1359:	}
;1360:}
LABELV $467
endproc FireWeapon 16 24
bss
align 4
LABELV muzzle
skip 12
align 4
LABELV up
skip 12
align 4
LABELV right
skip 12
align 4
LABELV forward
skip 12
align 4
LABELV s_quadFactor
skip 4
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
