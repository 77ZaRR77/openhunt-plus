export ScorePlum
code
proc ScorePlum 12 8
file "..\..\..\..\code\game\g_combat.c"
line 13
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// g_combat.c
;4:
;5:#include "g_local.h"
;6:
;7:
;8:/*
;9:============
;10:ScorePlum
;11:============
;12:*/
;13:void ScorePlum( gentity_t *ent, vec3_t origin, int score ) {
line 16
;14:	gentity_t *plum;
;15:
;16:	plum = G_TempEntity( origin, EV_SCOREPLUM );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 66
ARGI4
ADDRLP4 4
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 18
;17:	// only send this temp entity to a single client
;18:	plum->r.svFlags |= SVF_SINGLECLIENT;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 19
;19:	plum->r.singleClient = ent->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 428
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 21
;20:	//
;21:	plum->s.otherEntityNum = ent->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 22
;22:	plum->s.time = score;
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 23
;23:}
LABELV $87
endproc ScorePlum 12 8
export AddScore
proc AddScore 8 12
line 32
;24:
;25:/*
;26:============
;27:AddScore
;28:
;29:Adds score to both the client and his team
;30:============
;31:*/
;32:void AddScore( gentity_t *ent, vec3_t origin, int score ) {
line 33
;33:	if ( !ent->client ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $89
line 34
;34:		return;
ADDRGP4 $88
JUMPV
LABELV $89
line 36
;35:	}
;36:	if (!score) return;	// JUHOX
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $91
ADDRGP4 $88
JUMPV
LABELV $91
line 38
;37:	// no scoring during pre-match warmup
;38:	if ( level.warmupTime ) {
ADDRGP4 level+16
INDIRI4
CNSTI4 0
EQI4 $93
line 39
;39:		return;
ADDRGP4 $88
JUMPV
LABELV $93
line 42
;40:	}
;41:#if MEETING	// JUHOX: no scoring during meeting
;42:	if (level.meeting) return;
ADDRGP4 level+24092
INDIRI4
CNSTI4 0
EQI4 $96
ADDRGP4 $88
JUMPV
LABELV $96
line 45
;43:#endif
;44:	// show score plum
;45:	ScorePlum(ent, origin, score);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 ScorePlum
CALLV
pop
line 47
;46:	//
;47:	ent->client->ps.persistant[PERS_SCORE] += score;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 248
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRFP4 8
INDIRI4
ADDI4
ASGNI4
line 52
;48:#if !MONSTER_MODE	// JUHOX: use team score for STU too
;49:	if ( g_gametype.integer == GT_TEAM )
;50:		level.teamScores[ ent->client->ps.persistant[PERS_TEAM] ] += score;
;51:#else
;52:	if (g_gametype.integer == GT_TEAM || g_gametype.integer >= GT_STU) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
EQI4 $103
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
LTI4 $99
LABELV $103
line 53
;53:		level.teamScores[ent->client->ps.persistant[PERS_TEAM]] += score;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+44
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
ADDRFP4 8
INDIRI4
ADDI4
ASGNI4
line 54
;54:	}
LABELV $99
line 56
;55:#endif
;56:	CalculateRanks();
ADDRGP4 CalculateRanks
CALLV
pop
line 57
;57:}
LABELV $88
endproc AddScore 8 12
export TossClientItems
proc TossClientItems 24 12
line 66
;58:
;59:/*
;60:=================
;61:TossClientItems
;62:
;63:Toss the weapon and powerups for the killed player
;64:=================
;65:*/
;66:void TossClientItems( gentity_t *self ) {
line 127
;67:	// JUHOX: only toss team items (i.e. flags)
;68:#if 0
;69:	gitem_t		*item;
;70:	int			weapon;
;71:	float		angle;
;72:	int			i;
;73:	gentity_t	*drop;
;74:
;75:	// drop the weapon if not a gauntlet or machinegun
;76:	weapon = self->s.weapon;
;77:
;78:	// make a special check to see if they are changing to a new
;79:	// weapon that isn't the mg or gauntlet.  Without this, a client
;80:	// can pick up a weapon, be killed, and not drop the weapon because
;81:	// their weapon change hasn't completed yet and they are still holding the MG.
;82:	if ( weapon == WP_MACHINEGUN || weapon == WP_GRAPPLING_HOOK ) {
;83:		if ( self->client->ps.weaponstate == WEAPON_DROPPING ) {
;84:			weapon = self->client->pers.cmd.weapon;
;85:		}
;86:		if ( !( self->client->ps.stats[STAT_WEAPONS] & ( 1 << weapon ) ) ) {
;87:			weapon = WP_NONE;
;88:		}
;89:	}
;90:
;91:	if ( weapon > WP_MACHINEGUN && weapon != WP_GRAPPLING_HOOK && 
;92:		self->client->ps.ammo[ weapon ] ) {
;93:		// find the item type for this weapon
;94:		item = BG_FindItemForWeapon( weapon );
;95:
;96:		// spawn the item
;97:		Drop_Item( self, item, 0 );
;98:	}
;99:
;100:	// drop all the powerups if not in teamplay
;101:	if ( g_gametype.integer != GT_TEAM ) {
;102:		angle = 45;
;103:		for ( i = 1 ; i < PW_NUM_POWERUPS ; i++ ) {
;104:			if ( self->client->ps.powerups[ i ] > level.time ) {
;105:				item = BG_FindItemForPowerup( i );
;106:				if ( !item ) {
;107:					continue;
;108:				}
;109:				drop = Drop_Item( self, item, angle );
;110:				if (!drop) continue;	// JUHOX BUGFIX
;111:				// decide how many seconds it has left
;112:				drop->count = ( self->client->ps.powerups[ i ] - level.time ) / 1000;
;113:				if ( drop->count < 1 ) {
;114:					drop->count = 1;
;115:				}
;116:				angle += 45;
;117:			}
;118:		}
;119:	}
;120:#else
;121:	gitem_t		*item;
;122:	float		angle;
;123:	int			i;
;124:	gentity_t	*drop;
;125:
;126:	// drop the powerups
;127:	angle = 0;
ADDRLP4 12
CNSTF4 0
ASGNF4
line 128
;128:	for (i = 1; i < PW_NUM_POWERUPS; i++) {
ADDRLP4 0
CNSTI4 1
ASGNI4
LABELV $106
line 129
;129:		if (i == PW_CHARGE) continue;
ADDRLP4 0
INDIRI4
CNSTI4 10
NEI4 $110
ADDRGP4 $107
JUMPV
LABELV $110
line 130
;130:		if (i == PW_SHIELD) continue;
ADDRLP4 0
INDIRI4
CNSTI4 11
NEI4 $112
ADDRGP4 $107
JUMPV
LABELV $112
line 131
;131:		if (i == PW_BFG_RELOADING) continue;
ADDRLP4 0
INDIRI4
CNSTI4 12
NEI4 $114
ADDRGP4 $107
JUMPV
LABELV $114
line 132
;132:		if (i == PW_INVIS) continue;
ADDRLP4 0
INDIRI4
CNSTI4 4
NEI4 $116
ADDRGP4 $107
JUMPV
LABELV $116
line 133
;133:		if (i == PW_BATTLESUIT) continue;
ADDRLP4 0
INDIRI4
CNSTI4 2
NEI4 $118
ADDRGP4 $107
JUMPV
LABELV $118
line 134
;134:		if (self->client->ps.powerups[i] > level.time) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $120
line 135
;135:			item = BG_FindItemForPowerup(i);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 16
INDIRP4
ASGNP4
line 136
;136:			if (!item) continue;
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $123
ADDRGP4 $107
JUMPV
LABELV $123
line 137
;137:			drop = Drop_Item(self, item, angle);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 20
ADDRGP4 Drop_Item
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 20
INDIRP4
ASGNP4
line 138
;138:			if (!drop) continue;
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $125
ADDRGP4 $107
JUMPV
LABELV $125
line 140
;139:			// decide how many seconds it has left
;140:			drop->count = (self->client->ps.powerups[i] - level.time) / 1000;
ADDRLP4 4
INDIRP4
CNSTI4 764
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
SUBI4
CNSTI4 1000
DIVI4
ASGNI4
line 141
;141:			if (drop->count < 1) {
ADDRLP4 4
INDIRP4
CNSTI4 764
ADDP4
INDIRI4
CNSTI4 1
GEI4 $128
line 142
;142:				drop->count = 1;
ADDRLP4 4
INDIRP4
CNSTI4 764
ADDP4
CNSTI4 1
ASGNI4
line 143
;143:			}
LABELV $128
line 144
;144:			angle += 45;
ADDRLP4 12
ADDRLP4 12
INDIRF4
CNSTF4 1110704128
ADDF4
ASGNF4
line 145
;145:		}
LABELV $120
line 146
;146:		self->client->ps.powerups[i] = 0;	// we don't have it anymore
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
CNSTI4 0
ASGNI4
line 147
;147:	}
LABELV $107
line 128
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 13
LTI4 $106
line 149
;148:#endif
;149:}
LABELV $105
endproc TossClientItems 24 12
export TossArmorFragments
proc TossArmorFragments 104 16
line 276
;150:
;151:#ifdef MISSIONPACK
;152:
;153:/*
;154:=================
;155:TossClientCubes
;156:=================
;157:*/
;158:extern gentity_t	*neutralObelisk;
;159:
;160:void TossClientCubes( gentity_t *self ) {
;161:	gitem_t		*item;
;162:	gentity_t	*drop;
;163:	vec3_t		velocity;
;164:	vec3_t		angles;
;165:	vec3_t		origin;
;166:
;167:	self->client->ps.generic1 = 0;
;168:
;169:	// this should never happen but we should never
;170:	// get the server to crash due to skull being spawned in
;171:	if (!G_EntitiesFree()) {
;172:		return;
;173:	}
;174:
;175:	if( self->client->sess.sessionTeam == TEAM_RED ) {
;176:		item = BG_FindItem( "Red Cube" );
;177:	}
;178:	else {
;179:		item = BG_FindItem( "Blue Cube" );
;180:	}
;181:
;182:	angles[YAW] = (float)(level.time % 360);
;183:	angles[PITCH] = 0;	// always forward
;184:	angles[ROLL] = 0;
;185:
;186:	AngleVectors( angles, velocity, NULL, NULL );
;187:	VectorScale( velocity, 150, velocity );
;188:	velocity[2] += 200 + crandom() * 50;
;189:
;190:	if( neutralObelisk ) {
;191:		VectorCopy( neutralObelisk->s.pos.trBase, origin );
;192:		origin[2] += 44;
;193:	} else {
;194:		VectorClear( origin ) ;
;195:	}
;196:
;197:	drop = LaunchItem( item, origin, velocity );
;198:
;199:	drop->nextthink = level.time + g_cubeTimeout.integer * 1000;
;200:	drop->think = G_FreeEntity;
;201:	drop->spawnflags = self->client->sess.sessionTeam;
;202:}
;203:
;204:
;205:/*
;206:=================
;207:TossClientPersistantPowerups
;208:=================
;209:*/
;210:void TossClientPersistantPowerups( gentity_t *ent ) {
;211:	gentity_t	*powerup;
;212:
;213:	if( !ent->client ) {
;214:		return;
;215:	}
;216:
;217:	if( !ent->client->persistantPowerup ) {
;218:		return;
;219:	}
;220:
;221:	powerup = ent->client->persistantPowerup;
;222:
;223:	powerup->r.svFlags &= ~SVF_NOCLIENT;
;224:	powerup->s.eFlags &= ~EF_NODRAW;
;225:	powerup->r.contents = CONTENTS_TRIGGER;
;226:	trap_LinkEntity( powerup );
;227:
;228:	ent->client->ps.stats[STAT_PERSISTANT_POWERUP] = 0;
;229:	ent->client->persistantPowerup = NULL;
;230:}
;231:#endif
;232:
;233://static int numArmorFragments = 0;
;234:
;235:/*
;236:===============
;237:JUHOX: TouchArmorFragment
;238:===============
;239:*/
;240:/*
;241:static void TouchArmorFragment(gentity_t* ent, gentity_t* other, trace_t* trace) {
;242:	if (!other->client) return;
;243:	if (other->health < 1) return;
;244:	if (!BG_CanItemBeGrabbed(g_gametype.integer, &ent->s, &other->client->ps)) return;
;245:
;246:	numArmorFragments--;
;247:	if (numArmorFragments < 0) {
;248:		G_Printf(S_COLOR_RED "TouchArmorFragment(): armor fragment count underflow\n");
;249:		numArmorFragments = 0;
;250:	}
;251:	Touch_Item(ent, other, trace);
;252:}
;253:*/
;254:
;255:/*
;256:===============
;257:JUHOX: ThinkArmorFragment
;258:===============
;259:*/
;260:/*
;261:static void ThinkArmorFragment(gentity_t* ent) {
;262:	numArmorFragments--;
;263:	if (numArmorFragments < 0) {
;264:		G_Printf(S_COLOR_RED "ThinkArmorFragment(): armor fragment count underflow\n");
;265:		numArmorFragments = 0;
;266:	}
;267:	G_FreeEntity(ent); 
;268:}
;269:*/
;270:
;271:/*
;272:===============
;273:JUHOX: TossArmorFragments
;274:===============
;275:*/
;276:void TossArmorFragments(gentity_t* ent, int amount) {
line 284
;277:	vec3_t angles, pos, vel;
;278:	gitem_t* armorFragment5;
;279:	//gitem_t* armorFragment25;
;280:	gentity_t* fragment;
;281:	playerState_t* ps;
;282:	int numArmorFragments;
;283:
;284:	if (!g_armorFragments.integer) return;
ADDRGP4 g_armorFragments+12
INDIRI4
CNSTI4 0
NEI4 $131
ADDRGP4 $130
JUMPV
LABELV $131
line 285
;285:	if (amount < 5) return;
ADDRFP4 4
INDIRI4
CNSTI4 5
GEI4 $134
ADDRGP4 $130
JUMPV
LABELV $134
line 286
;286:	armorFragment5 = BG_FindItem("Armor Fragment 5");
ADDRGP4 $136
ARGP4
ADDRLP4 52
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 44
ADDRLP4 52
INDIRP4
ASGNP4
line 287
;287:	if (!armorFragment5) return;
ADDRLP4 44
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $137
ADDRGP4 $130
JUMPV
LABELV $137
line 293
;288:	/*
;289:	armorFragment25 = BG_FindItem("Armor Fragment 25");
;290:	if (!armorFragment25) return;
;291:	*/
;292:
;293:	{	// JUHOX FIXME
line 296
;294:		int i;
;295:
;296:		numArmorFragments = 0;
ADDRLP4 28
CNSTI4 0
ASGNI4
line 297
;297:		for (i = MAX_CLIENTS; i < level.num_entities; i++) {
ADDRLP4 56
CNSTI4 64
ASGNI4
ADDRGP4 $142
JUMPV
LABELV $139
line 300
;298:			gentity_t* ent;
;299:
;300:			ent = &g_entities[i];
ADDRLP4 60
ADDRLP4 56
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 301
;301:			if (!ent->inuse) continue;
ADDRLP4 60
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $144
ADDRGP4 $140
JUMPV
LABELV $144
line 302
;302:			if (ent->item != armorFragment5) continue;
ADDRLP4 60
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 44
INDIRP4
CVPU4 4
EQU4 $146
ADDRGP4 $140
JUMPV
LABELV $146
line 304
;303:
;304:			numArmorFragments++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 305
;305:		}
LABELV $140
line 297
ADDRLP4 56
ADDRLP4 56
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $142
ADDRLP4 56
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $139
line 306
;306:	}
line 308
;307:
;308:	ps = G_GetEntityPlayerState(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 48
ADDRLP4 56
INDIRP4
ASGNP4
line 310
;309:
;310:	amount = rand() % (amount + 1);
ADDRLP4 60
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 4
ADDRLP4 60
INDIRI4
ADDRFP4 4
INDIRI4
CNSTI4 1
ADDI4
MODI4
ASGNI4
ADDRGP4 $149
JUMPV
LABELV $148
line 311
;311:	while (amount >= 5) {
line 314
;312:		gitem_t* armor;
;313:
;314:		if (numArmorFragments >= 200) return;
ADDRLP4 28
INDIRI4
CNSTI4 200
LTI4 $151
ADDRGP4 $130
JUMPV
LABELV $151
line 315
;315:		if (G_NumEntitiesFree() < 300) return;
ADDRLP4 68
ADDRGP4 G_NumEntitiesFree
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 300
GEI4 $153
ADDRGP4 $130
JUMPV
LABELV $153
line 317
;316:
;317:		/*if (amount >= 25) {
line 322
;318:			armor = armorFragment25;
;319:			amount -= 25;
;320:		}
;321:		else*/ {
;322:			armor = armorFragment5;
ADDRLP4 64
ADDRLP4 44
INDIRP4
ASGNP4
line 323
;323:			amount -= 5;
ADDRFP4 4
ADDRFP4 4
INDIRI4
CNSTI4 5
SUBI4
ASGNI4
line 324
;324:		}
line 325
;325:		VectorSet(angles, -80 * random(), 360 * random(), 0);	// NOTE: a negative pitch means upward
ADDRLP4 72
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 16
ADDRLP4 72
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 72
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 3265265664
MULF4
ASGNF4
ADDRLP4 76
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 16+4
ADDRLP4 76
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 76
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
ADDRLP4 16+8
CNSTF4 0
ASGNF4
line 327
;326:		// the following is originally from CalcMuzzlePoint()
;327:		AngleVectors(angles, vel, NULL, NULL);
ADDRLP4 16
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
line 328
;328:		VectorCopy(ent->s.pos.trBase, pos);
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 329
;329:		if (ps) pos[2] += ps->viewheight;
ADDRLP4 48
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $157
ADDRLP4 32+8
ADDRLP4 32+8
INDIRF4
ADDRLP4 48
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
LABELV $157
line 334
;330:		//VectorMA(pos, 35, vel, pos);
;331:		// snap to integer coordinates for more efficient network bandwidth usage
;332:		//SnapVector(pos);
;333:
;334:		VectorScale(vel, 150 + 600 * random(), vel);
ADDRLP4 80
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 80
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 80
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1142292480
MULF4
CNSTF4 1125515264
ADDF4
MULF4
ASGNF4
ADDRLP4 84
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
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
CNSTF4 1142292480
MULF4
CNSTF4 1125515264
ADDF4
MULF4
ASGNF4
ADDRLP4 88
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 88
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 88
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1142292480
MULF4
CNSTF4 1125515264
ADDF4
MULF4
ASGNF4
line 335
;335:		fragment = LaunchItem(armor, pos, vel);
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 32
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 92
ADDRGP4 LaunchItem
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 92
INDIRP4
ASGNP4
line 336
;336:		if (fragment) {
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $164
line 337
;337:			numArmorFragments++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 339
;338:
;339:			fragment->physicsBounce = 0.5;
ADDRLP4 12
INDIRP4
CNSTI4 572
ADDP4
CNSTF4 1056964608
ASGNF4
line 340
;340:			fragment->clipmask = 0;
ADDRLP4 12
INDIRP4
CNSTI4 576
ADDP4
CNSTI4 0
ASGNI4
line 341
;341:			fragment->s.apos.trType = TR_STATIONARY;
ADDRLP4 12
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 342
;342:			VectorClear(fragment->s.apos.trDelta);
ADDRLP4 100
CNSTF4 0
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 100
INDIRF4
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 76
ADDP4
ADDRLP4 100
INDIRF4
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 72
ADDP4
ADDRLP4 100
INDIRF4
ASGNF4
line 343
;343:			fragment->s.apos.trTime = 0;
ADDRLP4 12
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 344
;344:			fragment->s.apos.trDuration = 0;
ADDRLP4 12
INDIRP4
CNSTI4 56
ADDP4
CNSTI4 0
ASGNI4
line 345
;345:			G_BounceItemRotation(fragment);
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 G_BounceItemRotation
CALLV
pop
line 347
;346:			//fragment->touch = TouchArmorFragment;
;347:			fragment->think = G_FreeEntity;	//ThinkArmorFragment;
ADDRLP4 12
INDIRP4
CNSTI4 696
ADDP4
ADDRGP4 G_FreeEntity
ASGNP4
line 348
;348:			fragment->nextthink = level.time + 30000;
ADDRLP4 12
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 30000
ADDI4
ASGNI4
line 349
;349:		}
LABELV $164
line 350
;350:	}
LABELV $149
line 311
ADDRFP4 4
INDIRI4
CNSTI4 5
GEI4 $148
line 351
;351:}
LABELV $130
endproc TossArmorFragments 104 16
export LookAtKiller
proc LookAtKiller 28 4
line 359
;352:
;353:
;354:/*
;355:==================
;356:LookAtKiller
;357:==================
;358:*/
;359:void LookAtKiller( gentity_t *self, gentity_t *inflictor, gentity_t *attacker ) {
line 363
;360:	vec3_t		dir;
;361:	//vec3_t		angles;	// JUHOX: no longer needed
;362:
;363:	if ( attacker && attacker != self ) {
ADDRLP4 12
ADDRFP4 8
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 12
INDIRU4
CNSTU4 0
EQU4 $168
ADDRLP4 12
INDIRU4
ADDRFP4 0
INDIRP4
CVPU4 4
EQU4 $168
line 364
;364:		VectorSubtract (attacker->s.pos.trBase, self->s.pos.trBase, dir);
ADDRLP4 16
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 16
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
SUBF4
ASGNF4
line 365
;365:	} else if ( inflictor && inflictor != self ) {
ADDRGP4 $169
JUMPV
LABELV $168
ADDRLP4 16
ADDRFP4 4
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 16
INDIRU4
CNSTU4 0
EQU4 $172
ADDRLP4 16
INDIRU4
ADDRFP4 0
INDIRP4
CVPU4 4
EQU4 $172
line 366
;366:		VectorSubtract (inflictor->s.pos.trBase, self->s.pos.trBase, dir);
ADDRLP4 20
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 20
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
SUBF4
ASGNF4
line 367
;367:	} else {
ADDRGP4 $173
JUMPV
LABELV $172
line 371
;368:#if 0	// JUHOX: replace STAT_DEAD_YAW
;369:		self->client->ps.stats[STAT_DEAD_YAW] = self->s.angles[YAW];
;370:#else
;371:		self->client->deadYaw = self->client->ps.viewangles[YAW];
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 772
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
line 373
;372:#endif
;373:		return;
ADDRGP4 $167
JUMPV
LABELV $173
LABELV $169
line 383
;374:	}
;375:
;376:#if 0	// JUHOX: replace STAT_DEAD_YAW
;377:	self->client->ps.stats[STAT_DEAD_YAW] = vectoyaw ( dir );
;378:
;379:	angles[YAW] = vectoyaw ( dir );
;380:	angles[PITCH] = 0; 
;381:	angles[ROLL] = 0;
;382:#else
;383:	self->client->deadYaw = vectoyaw(dir);
ADDRLP4 0
ARGP4
ADDRLP4 20
ADDRGP4 vectoyaw
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 772
ADDP4
ADDRLP4 20
INDIRF4
ASGNF4
line 385
;384:#endif
;385:}
LABELV $167
endproc LookAtKiller 28 4
export GibEntity
proc GibEntity 12 12
line 392
;386:
;387:/*
;388:==================
;389:GibEntity
;390:==================
;391:*/
;392:void GibEntity( gentity_t *self, int killer ) {
line 397
;393:	gentity_t *ent;
;394:	int i;
;395:
;396:	//if this entity still has kamikaze
;397:	if (self->s.eFlags & EF_KAMIKAZE) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $177
line 399
;398:		// check if there is a kamikaze timer around for this owner
;399:		for (i = 0; i < MAX_GENTITIES; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $179
line 400
;400:			ent = &g_entities[i];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 401
;401:			if (!ent->inuse)
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $183
line 402
;402:				continue;
ADDRGP4 $180
JUMPV
LABELV $183
line 403
;403:			if (ent->activator != self)
ADDRLP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
EQU4 $185
line 404
;404:				continue;
ADDRGP4 $180
JUMPV
LABELV $185
line 405
;405:			if (strcmp(ent->classname, "kamikaze timer"))
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ARGP4
ADDRGP4 $189
ARGP4
ADDRLP4 8
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $187
line 406
;406:				continue;
ADDRGP4 $180
JUMPV
LABELV $187
line 407
;407:			G_FreeEntity(ent);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 408
;408:			break;
ADDRGP4 $181
JUMPV
LABELV $180
line 399
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 1024
LTI4 $179
LABELV $181
line 410
;409:		}
;410:	}
LABELV $177
line 411
;411:	G_AddEvent( self, EV_GIB_PLAYER, killer );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 65
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 412
;412:	self->takedamage = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
CNSTI4 0
ASGNI4
line 413
;413:	self->s.eType = ET_INVISIBLE;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 10
ASGNI4
line 414
;414:	self->r.contents = 0;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 0
ASGNI4
line 415
;415:}
LABELV $176
endproc GibEntity 12 12
export body_die
proc body_die 0 8
line 422
;416:
;417:/*
;418:==================
;419:body_die
;420:==================
;421:*/
;422:void body_die( gentity_t *self, gentity_t *inflictor, gentity_t *attacker, int damage, int meansOfDeath ) {
line 423
;423:	if ( self->health > GIB_HEALTH ) {
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 -40
LEI4 $191
line 424
;424:		return;
ADDRGP4 $190
JUMPV
LABELV $191
line 426
;425:	}
;426:	if ( !g_blood.integer ) {
ADDRGP4 g_blood+12
INDIRI4
CNSTI4 0
NEI4 $193
line 427
;427:		self->health = GIB_HEALTH+1;
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 -39
ASGNI4
line 428
;428:		return;
ADDRGP4 $190
JUMPV
LABELV $193
line 431
;429:	}
;430:
;431:	GibEntity( self, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 GibEntity
CALLV
pop
line 432
;432:}
LABELV $190
endproc body_die 0 8
export DoOverkill
proc DoOverkill 24 8
line 443
;433:
;434:
;435:/*
;436:==================
;437:JUHOX: DoOverkill
;438:
;439:inflictor: may be ENTITYNUM_NONE (surrendering), or ENTITYNUM_WORLD (suicide)
;440:'killedTeam' only needed if 'lastKilled' == NULL
;441:==================
;442:*/
;443:void DoOverkill(gclient_t* lastKilled, int killedTeam, int inflictor) {
line 448
;444:	int i;
;445:	gclient_t* cl;
;446:	gentity_t* te;
;447:
;448:	for (i = 0; i < g_maxclients.integer; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $200
JUMPV
LABELV $197
line 449
;449:		cl = level.clients + i;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 450
;450:		if (cl->pers.connected != CON_CONNECTED) continue;
ADDRLP4 4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $202
ADDRGP4 $198
JUMPV
LABELV $202
line 452
;451:
;452:		if (!lastKilled) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $204
line 453
;453:			if (cl->ps.persistant[PERS_TEAM] == killedTeam && cl->ps.stats[STAT_HEALTH] > 0) {
ADDRLP4 4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $206
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
LEI4 $206
line 454
;454:				lastKilled = cl;
ADDRFP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 455
;455:			}
LABELV $206
line 456
;456:		}
LABELV $204
line 457
;457:		ForceRespawn(&g_entities[i]);
ADDRLP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRGP4 ForceRespawn
CALLV
pop
line 458
;458:	}
LABELV $198
line 448
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $200
ADDRLP4 0
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $197
line 460
;459:
;460:	te = G_TempEntity(vec3_origin, EV_OVERKILL);
ADDRGP4 vec3_origin
ARGP4
CNSTI4 84
ARGI4
ADDRLP4 12
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 12
INDIRP4
ASGNP4
line 461
;461:	if (!te) return;
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $208
ADDRGP4 $196
JUMPV
LABELV $208
line 462
;462:	te->s.clientNum = lastKilled? lastKilled->ps.clientNum : -1;
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $211
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $212
JUMPV
LABELV $211
ADDRLP4 16
CNSTI4 -1
ASGNI4
LABELV $212
ADDRLP4 8
INDIRP4
CNSTI4 168
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 463
;463:	te->s.otherEntityNum = inflictor;
ADDRLP4 8
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 464
;464:	te->r.svFlags |= SVF_BROADCAST;
ADDRLP4 20
ADDRLP4 8
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 465
;465:}
LABELV $196
endproc DoOverkill 24 8
proc CheckForOverkill 20 12
line 475
;466:
;467:/*
;468:==================
;469:JUHOX: CheckForOverkill
;470:
;471:returns qtrue if the whole team of 'self' has been killed
;472:also forces any dead client to respawn
;473:==================
;474:*/
;475:static qboolean CheckForOverkill(gentity_t* self, gentity_t* attacker) {
line 479
;476:	int i;
;477:	gclient_t* cl;
;478:
;479:	if (g_respawnDelay.integer <= 0) return qfalse;
ADDRGP4 g_respawnDelay+12
INDIRI4
CNSTI4 0
GTI4 $214
CNSTI4 0
RETI4
ADDRGP4 $213
JUMPV
LABELV $214
line 480
;480:	if (g_gametype.integer == GT_TOURNAMENT) return qfalse;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
NEI4 $217
CNSTI4 0
RETI4
ADDRGP4 $213
JUMPV
LABELV $217
line 481
;481:	if (g_gametype.integer == GT_CTF) return qfalse;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $220
CNSTI4 0
RETI4
ADDRGP4 $213
JUMPV
LABELV $220
line 483
;482:
;483:	if (g_gametype.integer >= GT_TEAM) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $223
line 484
;484:		if (!self->client) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $226
CNSTI4 0
RETI4
ADDRGP4 $213
JUMPV
LABELV $226
line 486
;485:
;486:		for (i = 0; i < g_maxclients.integer; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $231
JUMPV
LABELV $228
line 487
;487:			cl = level.clients + i;
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 488
;488:			if (cl->pers.connected != CON_CONNECTED) continue;
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $233
ADDRGP4 $229
JUMPV
LABELV $233
line 489
;489:			if (cl->ps.persistant[PERS_TEAM] != self->client->ps.persistant[PERS_TEAM]) continue;
ADDRLP4 0
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
EQI4 $235
ADDRGP4 $229
JUMPV
LABELV $235
line 492
;490:			
;491:			if (
;492:				cl->ps.stats[STAT_HEALTH] > 0 &&
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
LEI4 $237
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $237
line 494
;493:				cl->ps.pm_type != PM_SPECTATOR	// don't count mission leaders in safety mode as alive
;494:			) return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $213
JUMPV
LABELV $237
line 496
;495:			//if (cl->respawnDelay <= 0) return qfalse;
;496:		}
LABELV $229
line 486
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $231
ADDRLP4 4
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $228
line 498
;497:
;498:		DoOverkill(self->client, 0, (attacker && attacker->client)? attacker->client->ps.clientNum : ENTITYNUM_WORLD);
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $240
ADDRLP4 12
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $240
ADDRLP4 8
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $241
JUMPV
LABELV $240
ADDRLP4 8
CNSTI4 1022
ASGNI4
LABELV $241
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 DoOverkill
CALLV
pop
line 499
;499:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $213
JUMPV
LABELV $223
line 501
;500:	}
;501:	else {
line 505
;502:		int lastManStanding;
;503:		int numPlayersAlive;
;504:
;505:		lastManStanding = -1;
ADDRLP4 8
CNSTI4 -1
ASGNI4
line 506
;506:		numPlayersAlive = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 507
;507:		for (i = 0; i < g_maxclients.integer; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $245
JUMPV
LABELV $242
line 508
;508:			cl = level.clients + i;
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 509
;509:			if (cl->pers.connected != CON_CONNECTED) continue;
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $247
ADDRGP4 $243
JUMPV
LABELV $247
line 510
;510:			if (cl->ps.stats[STAT_HEALTH] <= 0) continue;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $249
ADDRGP4 $243
JUMPV
LABELV $249
line 512
;511:
;512:			lastManStanding = i;
ADDRLP4 8
ADDRLP4 4
INDIRI4
ASGNI4
line 513
;513:			numPlayersAlive++;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 514
;514:		}
LABELV $243
line 507
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $245
ADDRLP4 4
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $242
line 516
;515:
;516:		if (numPlayersAlive <= 1) {
ADDRLP4 12
INDIRI4
CNSTI4 1
GTI4 $251
line 517
;517:			if (lastManStanding >= 0) {
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $253
line 518
;518:				if (&g_entities[lastManStanding] == attacker) {
ADDRLP4 8
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
CVPU4 4
ADDRFP4 4
INDIRP4
CVPU4 4
NEU4 $255
line 519
;519:					AddScore(attacker, self->r.currentOrigin, 5);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 5
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 520
;520:				}
ADDRGP4 $256
JUMPV
LABELV $255
line 521
;521:				else {
line 522
;522:					AddScore(&g_entities[lastManStanding], g_entities[lastManStanding].r.currentOrigin, 5);
ADDRLP4 8
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+208+280
ADDP4
ARGP4
CNSTI4 5
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 523
;523:				}
LABELV $256
line 524
;524:			}
LABELV $253
line 525
;525:			DoOverkill(NULL, -1, lastManStanding);
CNSTP4 0
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 DoOverkill
CALLV
pop
line 526
;526:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $213
JUMPV
LABELV $251
line 528
;527:		}
;528:	}
line 529
;529:	return qfalse;
CNSTI4 0
RETI4
LABELV $213
endproc CheckForOverkill 20 12
data
export modNames
align 4
LABELV modNames
address $259
address $260
address $261
address $262
address $263
address $264
address $265
address $266
address $267
address $268
address $269
address $270
address $271
address $272
address $273
address $274
address $275
address $276
address $277
address $278
address $279
address $280
address $281
address $282
address $283
address $284
address $285
address $286
address $287
export CheckAlmostCapture
code
proc CheckAlmostCapture 52 12
line 611
;530:}
;531:
;532:// these are just for logging, the client prints its own messages
;533:char	*modNames[] = {
;534:	"MOD_UNKNOWN",
;535:	"MOD_SHOTGUN",
;536:	"MOD_GAUNTLET",
;537:#if MONSTER_MODE
;538:	"MOD_CLAW",				// JUHOX
;539:	"MOD_GUARD",			// JUHOX
;540:	"MOD_TITAN",			// JUHOX
;541:	"MOD_MONSTER_LAUNCHER",	// JUHOX
;542:#endif
;543:	"MOD_CHARGE",			// JUHOX
;544:	"MOD_MACHINEGUN",
;545:	"MOD_GRENADE",
;546:	"MOD_GRENADE_SPLASH",
;547:	"MOD_ROCKET",
;548:	"MOD_ROCKET_SPLASH",
;549:	"MOD_PLASMA",
;550:	"MOD_PLASMA_SPLASH",
;551:	"MOD_RAILGUN",
;552:	"MOD_LIGHTNING",
;553:	"MOD_BFG",
;554:	"MOD_BFG_SPLASH",
;555:	"MOD_WATER",
;556:	"MOD_SLIME",
;557:	"MOD_LAVA",
;558:	"MOD_CRUSH",
;559:	"MOD_TELEFRAG",
;560:	"MOD_FALLING",
;561:	"MOD_SUICIDE",
;562:	"MOD_TARGET_LASER",
;563:	"MOD_TRIGGER_HURT",
;564:#ifdef MISSIONPACK
;565:	"MOD_NAIL",
;566:	"MOD_CHAINGUN",
;567:	"MOD_PROXIMITY_MINE",
;568:	"MOD_KAMIKAZE",
;569:	"MOD_JUICED",
;570:#endif
;571:	"MOD_GRAPPLE"
;572:};
;573:
;574:#ifdef MISSIONPACK
;575:/*
;576:==================
;577:Kamikaze_DeathActivate
;578:==================
;579:*/
;580:void Kamikaze_DeathActivate( gentity_t *ent ) {
;581:	G_StartKamikaze(ent);
;582:	G_FreeEntity(ent);
;583:}
;584:
;585:/*
;586:==================
;587:Kamikaze_DeathTimer
;588:==================
;589:*/
;590:void Kamikaze_DeathTimer( gentity_t *self ) {
;591:	gentity_t *ent;
;592:
;593:	ent = G_Spawn();
;594:	if (!ent) return;	// JUHOX BUGFIX
;595:	ent->classname = "kamikaze timer";
;596:	VectorCopy(self->s.pos.trBase, ent->s.pos.trBase);
;597:	ent->r.svFlags |= SVF_NOCLIENT;
;598:	ent->think = Kamikaze_DeathActivate;
;599:	ent->nextthink = level.time + 5 * 1000;
;600:
;601:	ent->activator = self;
;602:}
;603:
;604:#endif
;605:
;606:/*
;607:==================
;608:CheckAlmostCapture
;609:==================
;610:*/
;611:void CheckAlmostCapture( gentity_t *self, gentity_t *attacker ) {
line 617
;612:	gentity_t	*ent;
;613:	vec3_t		dir;
;614:	char		*classname;
;615:
;616:	// if this player was carrying a flag
;617:	if ( self->client->ps.powerups[PW_REDFLAG] ||
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
NEI4 $292
ADDRLP4 20
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
NEI4 $292
ADDRLP4 20
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
CNSTI4 0
EQI4 $289
LABELV $292
line 619
;618:		self->client->ps.powerups[PW_BLUEFLAG] ||
;619:		self->client->ps.powerups[PW_NEUTRALFLAG] ) {
line 621
;620:		// get the goal flag this player should have been going for
;621:		if ( g_gametype.integer == GT_CTF ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $293
line 622
;622:			if ( self->client->sess.sessionTeam == TEAM_BLUE ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 2
NEI4 $296
line 623
;623:				classname = "team_CTF_blueflag";
ADDRLP4 4
ADDRGP4 $298
ASGNP4
line 624
;624:			}
ADDRGP4 $294
JUMPV
LABELV $296
line 625
;625:			else {
line 626
;626:				classname = "team_CTF_redflag";
ADDRLP4 4
ADDRGP4 $299
ASGNP4
line 627
;627:			}
line 628
;628:		}
ADDRGP4 $294
JUMPV
LABELV $293
line 629
;629:		else {
line 630
;630:			if ( self->client->sess.sessionTeam == TEAM_BLUE ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 2
NEI4 $300
line 631
;631:				classname = "team_CTF_redflag";
ADDRLP4 4
ADDRGP4 $299
ASGNP4
line 632
;632:			}
ADDRGP4 $301
JUMPV
LABELV $300
line 633
;633:			else {
line 634
;634:				classname = "team_CTF_blueflag";
ADDRLP4 4
ADDRGP4 $298
ASGNP4
line 635
;635:			}
LABELV $301
line 636
;636:		}
LABELV $294
line 637
;637:		ent = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
LABELV $302
line 639
;638:		do
;639:		{
line 640
;640:			ent = G_Find(ent, FOFS(classname), classname);
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 528
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 24
INDIRP4
ASGNP4
line 641
;641:		} while (ent && (ent->flags & FL_DROPPED_ITEM));
LABELV $303
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $305
ADDRLP4 0
INDIRP4
CNSTI4 540
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
NEI4 $302
LABELV $305
line 643
;642:		// if we found the destination flag and it's not picked up
;643:		if (ent && !(ent->r.svFlags & SVF_NOCLIENT) ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $306
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $306
line 645
;644:			// if the player was *very* close
;645:			VectorSubtract( self->client->ps.origin, ent->s.origin, dir );
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 32
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8+4
ADDRLP4 32
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8+8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ASGNF4
line 646
;646:			if ( VectorLength(dir) < 200 ) {
ADDRLP4 8
ARGP4
ADDRLP4 40
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 40
INDIRF4
CNSTF4 1128792064
GEF4 $310
line 647
;647:				self->client->ps.persistant[PERS_PLAYEREVENTS] ^= PLAYEREVENT_HOLYSHIT;
ADDRLP4 44
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 268
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 4
BXORI4
ASGNI4
line 648
;648:				if ( attacker->client ) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $312
line 649
;649:					attacker->client->ps.persistant[PERS_PLAYEREVENTS] ^= PLAYEREVENT_HOLYSHIT;
ADDRLP4 48
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 268
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 4
BXORI4
ASGNI4
line 650
;650:				}
LABELV $312
line 651
;651:			}
LABELV $310
line 652
;652:		}
LABELV $306
line 653
;653:	}
LABELV $289
line 654
;654:}
LABELV $288
endproc CheckAlmostCapture 52 12
export CheckAlmostScored
proc CheckAlmostScored 0 0
line 661
;655:
;656:/*
;657:==================
;658:CheckAlmostScored
;659:==================
;660:*/
;661:void CheckAlmostScored( gentity_t *self, gentity_t *attacker ) {
line 689
;662:#ifdef MISSIONPACK
;663:	gentity_t	*ent;
;664:	vec3_t		dir;
;665:	char		*classname;
;666:
;667:	// if the player was carrying cubes
;668:	if ( self->client->ps.generic1 ) {
;669:		if ( self->client->sess.sessionTeam == TEAM_BLUE ) {
;670:			classname = "team_redobelisk";
;671:		}
;672:		else {
;673:			classname = "team_blueobelisk";
;674:		}
;675:		ent = G_Find(NULL, FOFS(classname), classname);
;676:		// if we found the destination obelisk
;677:		if ( ent ) {
;678:			// if the player was *very* close
;679:			VectorSubtract( self->client->ps.origin, ent->s.origin, dir );
;680:			if ( VectorLength(dir) < 200 ) {
;681:				self->client->ps.persistant[PERS_PLAYEREVENTS] ^= PLAYEREVENT_HOLYSHIT;
;682:				if ( attacker->client ) {
;683:					attacker->client->ps.persistant[PERS_PLAYEREVENTS] ^= PLAYEREVENT_HOLYSHIT;
;684:				}
;685:			}
;686:		}
;687:	}
;688:#endif
;689:}
LABELV $314
endproc CheckAlmostScored 0 0
bss
align 4
LABELV $443
skip 4
export player_die
code
proc player_die 192 28
line 696
;690:
;691:/*
;692:==================
;693:player_die
;694:==================
;695:*/
;696:void player_die( gentity_t *self, gentity_t *inflictor, gentity_t *attacker, int damage, int meansOfDeath ) {
line 705
;697:	gentity_t	*ent;
;698:	int			anim;
;699:	int			contents;
;700:	int			killer;
;701:	int			i;
;702:	char		*killerName, *obit;
;703:	int			score;	// JUHOX
;704:
;705:	if ( self->client->ps.pm_type == PM_DEAD ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $316
line 706
;706:		return;
ADDRGP4 $315
JUMPV
LABELV $316
line 708
;707:	}
;708:	if (self->client->ps.pm_type == PM_SPECTATOR) return;	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $318
ADDRGP4 $315
JUMPV
LABELV $318
line 710
;709:
;710:	if ( level.intermissiontime ) {
ADDRGP4 level+9144
INDIRI4
CNSTI4 0
EQI4 $320
line 711
;711:		return;
ADDRGP4 $315
JUMPV
LABELV $320
line 715
;712:	}
;713:
;714:#if MEETING	// JUHOX: no kills during meeting
;715:	if (level.meeting) return;	// JUHOX
ADDRGP4 level+24092
INDIRI4
CNSTI4 0
EQI4 $323
ADDRGP4 $315
JUMPV
LABELV $323
line 719
;716:#endif
;717:
;718:	// check for an almost capture
;719:	CheckAlmostCapture( self, attacker );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 CheckAlmostCapture
CALLV
pop
line 721
;720:	// check for a player that almost brought in cubes
;721:	CheckAlmostScored( self, attacker );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 CheckAlmostScored
CALLV
pop
line 723
;722:
;723:	if (self->client && self->client->hook) {
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $326
ADDRLP4 32
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 884
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $326
line 724
;724:		Weapon_HookFree(self->client->hook);
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
line 725
;725:	}
LABELV $326
line 733
;726:#ifdef MISSIONPACK
;727:	if ((self->client->ps.eFlags & EF_TICKING) && self->activator) {
;728:		self->client->ps.eFlags &= ~EF_TICKING;
;729:		self->activator->think = G_FreeEntity;
;730:		self->activator->nextthink = level.time;
;731:	}
;732:#endif
;733:	self->client->ps.pm_type = PM_DEAD;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 3
ASGNI4
line 734
;734:	self->client->ps.stats[STAT_RESPAWN_INFO] = -1;	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 196
ADDP4
CNSTI4 -1
ASGNI4
line 735
;735:	self->client->corpseProduced = qfalse;	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 980
ADDP4
CNSTI4 0
ASGNI4
line 738
;736:#if 1	// JUHOX: save death origin if allowed to
;737:	if (
;738:		g_gametype.integer == GT_CTF &&
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $328
ADDRGP4 g_respawnAtPOD+12
INDIRI4
CNSTI4 0
EQI4 $328
ADDRGP4 g_respawnDelay+12
INDIRI4
CNSTI4 10
LTI4 $328
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 316
ADDP4
INDIRI4
CNSTI4 0
NEI4 $328
ADDRLP4 36
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRLP4 40
ADDRGP4 NearHomeBase
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $328
line 743
;739:		g_respawnAtPOD.integer &&
;740:		g_respawnDelay.integer >= 10 &&
;741:		!self->client->ps.powerups[PW_QUAD] &&
;742:		!NearHomeBase(self->client->sess.sessionTeam, self->client->ps.origin, 1)
;743:	) {
line 744
;744:		self->client->mayRespawnAtDeathOrigin = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 984
ADDP4
CNSTI4 1
ASGNI4
line 745
;745:		VectorCopy(self->client->ps.origin, self->client->deathOrigin);
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 988
ADDP4
ADDRLP4 44
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 746
;746:		VectorCopy(self->client->ps.viewangles, self->client->deathAngles);
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1000
ADDP4
ADDRLP4 48
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 152
ADDP4
INDIRB
ASGNB 12
line 747
;747:	}
ADDRGP4 $329
JUMPV
LABELV $328
line 748
;748:	else {
line 749
;749:		self->client->mayRespawnAtDeathOrigin = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 984
ADDP4
CNSTI4 0
ASGNI4
line 750
;750:	}
LABELV $329
line 756
;751:#endif
;752:
;753:#if 1	// JUHOX: if there's enough charge, it'll gib the player
;754:	if (
;755:		//meansOfDeath == MOD_CHARGE &&
;756:		self->client->ps.powerups[PW_CHARGE] - level.time >= 8500 / CHARGE_DAMAGE_PER_SECOND
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 352
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
SUBI4
CVIF4 4
CNSTF4 1174720512
LTF4 $333
line 757
;757:	) {
line 758
;758:		self->health = GIB_HEALTH;
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 -40
ASGNI4
line 759
;759:	}
LABELV $333
line 762
;760:#endif
;761:
;762:	if ( attacker ) {
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $336
line 763
;763:		killer = attacker->s.number;
ADDRLP4 4
ADDRFP4 8
INDIRP4
INDIRI4
ASGNI4
line 764
;764:		if ( attacker->client ) {
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $338
line 765
;765:			killerName = attacker->client->pers.netname;
ADDRLP4 20
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ASGNP4
line 766
;766:		} else {
ADDRGP4 $337
JUMPV
LABELV $338
line 767
;767:			killerName = "<non-client>";
ADDRLP4 20
ADDRGP4 $340
ASGNP4
line 768
;768:		}
line 769
;769:	} else {
ADDRGP4 $337
JUMPV
LABELV $336
line 770
;770:		killer = ENTITYNUM_WORLD;
ADDRLP4 4
CNSTI4 1022
ASGNI4
line 771
;771:		killerName = "<world>";
ADDRLP4 20
ADDRGP4 $341
ASGNP4
line 772
;772:	}
LABELV $337
line 774
;773:
;774:	if ( killer < 0 || killer >= MAX_CLIENTS ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $344
ADDRLP4 4
INDIRI4
CNSTI4 64
LTI4 $342
LABELV $344
line 775
;775:		killer = ENTITYNUM_WORLD;
ADDRLP4 4
CNSTI4 1022
ASGNI4
line 776
;776:		killerName = "<world>";
ADDRLP4 20
ADDRGP4 $341
ASGNP4
line 777
;777:	}
LABELV $342
line 779
;778:
;779:	if ( meansOfDeath < 0 || meansOfDeath >= sizeof( modNames ) / sizeof( modNames[0] ) ) {
ADDRLP4 48
ADDRFP4 16
INDIRI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
LTI4 $347
ADDRLP4 48
INDIRI4
CVIU4 4
CNSTU4 29
LTU4 $345
LABELV $347
line 780
;780:		obit = "<bad obituary>";
ADDRLP4 24
ADDRGP4 $348
ASGNP4
line 781
;781:	} else {
ADDRGP4 $346
JUMPV
LABELV $345
line 782
;782:		obit = modNames[ meansOfDeath ];
ADDRLP4 24
ADDRFP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 modNames
ADDP4
INDIRP4
ASGNP4
line 783
;783:	}
LABELV $346
line 785
;784:
;785:	G_LogPrintf("Kill: %i %i %i: %s killed %s by %s\n", 
ADDRGP4 $349
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
INDIRI4
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 52
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 790
;786:		killer, self->s.number, meansOfDeath, killerName, 
;787:		self->client->pers.netname, obit );
;788:
;789:	// broadcast the death event to everyone
;790:	ent = G_TempEntity( self->r.currentOrigin, EV_OBITUARY );
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 61
ARGI4
ADDRLP4 56
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 56
INDIRP4
ASGNP4
line 791
;791:	ent->s.eventParm = meansOfDeath;
ADDRLP4 8
INDIRP4
CNSTI4 184
ADDP4
ADDRFP4 16
INDIRI4
ASGNI4
line 792
;792:	ent->s.otherEntityNum = self->s.number;
ADDRLP4 8
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 793
;793:	ent->s.otherEntityNum2 = killer;
ADDRLP4 8
INDIRP4
CNSTI4 144
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 794
;794:	ent->r.svFlags = SVF_BROADCAST;	// send to everyone
ADDRLP4 8
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 32
ASGNI4
line 797
;795:
;796:#if 1	// JUHOX: create POD marker if needed
;797:	if (self->client->mayRespawnAtDeathOrigin) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 984
ADDP4
INDIRI4
CNSTI4 0
EQI4 $350
line 800
;798:		gitem_t* item;
;799:
;800:		item = BG_FindItem("POD marker");
ADDRGP4 $352
ARGP4
ADDRLP4 64
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 60
ADDRLP4 64
INDIRP4
ASGNP4
line 801
;801:		if (item) {
ADDRLP4 60
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $353
line 805
;802:			trace_t trace;
;803:			vec3_t mins, maxs, dest;
;804:
;805:			VectorSet(mins, -ITEM_RADIUS, -ITEM_RADIUS, -ITEM_RADIUS);
ADDRLP4 124
CNSTF4 3245342720
ASGNF4
ADDRLP4 124+4
CNSTF4 3245342720
ASGNF4
ADDRLP4 124+8
CNSTF4 3245342720
ASGNF4
line 806
;806:			VectorSet(maxs, ITEM_RADIUS, ITEM_RADIUS, ITEM_RADIUS);
ADDRLP4 136
CNSTF4 1097859072
ASGNF4
ADDRLP4 136+4
CNSTF4 1097859072
ASGNF4
ADDRLP4 136+8
CNSTF4 1097859072
ASGNF4
line 807
;807:			VectorCopy(self->client->deathOrigin, dest);
ADDRLP4 148
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 988
ADDP4
INDIRB
ASGNB 12
line 808
;808:			dest[2] -= 10000;
ADDRLP4 148+8
ADDRLP4 148+8
INDIRF4
CNSTF4 1176256512
SUBF4
ASGNF4
line 809
;809:			trap_Trace(
ADDRLP4 68
ARGP4
ADDRLP4 160
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 160
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 988
ADDP4
ARGP4
ADDRLP4 124
ARGP4
ADDRLP4 136
ARGP4
ADDRLP4 148
ARGP4
ADDRLP4 160
INDIRP4
INDIRI4
ARGI4
CNSTU4 2147549209
CVUI4 4
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 814
;810:				&trace, self->client->deathOrigin, mins, maxs, dest, self->s.number,
;811:				(int)(CONTENTS_SOLID|CONTENTS_PLAYERCLIP|CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_NODROP)
;812:			);
;813:			if (
;814:				!trace.startsolid &&
ADDRLP4 68+4
INDIRI4
CNSTI4 0
NEI4 $360
ADDRLP4 68
INDIRI4
CNSTI4 0
NEI4 $360
ADDRLP4 68+8
INDIRF4
CNSTF4 1065185444
GEF4 $360
ADDRLP4 68+48
INDIRI4
CVIU4 4
CNSTU4 2147483672
BANDU4
CNSTU4 0
NEU4 $360
line 818
;815:				!trace.allsolid &&
;816:				trace.fraction < 0.99 &&
;817:				!(trace.contents & (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_NODROP))
;818:			) {
line 821
;819:				gentity_t* marker;
;820:
;821:				marker = LaunchItem(item, trace.endpos, vec3_origin);
ADDRLP4 60
INDIRP4
ARGP4
ADDRLP4 68+12
ARGP4
ADDRGP4 vec3_origin
ARGP4
ADDRLP4 168
ADDRGP4 LaunchItem
CALLP4
ASGNP4
ADDRLP4 164
ADDRLP4 168
INDIRP4
ASGNP4
line 822
;822:				if (marker) {
ADDRLP4 164
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $366
line 823
;823:					marker->nextthink = 0;
ADDRLP4 164
INDIRP4
CNSTI4 692
ADDP4
CNSTI4 0
ASGNI4
line 824
;824:					marker->s.time = level.time + 1000 * g_respawnDelay.integer + 1700;
ADDRLP4 164
INDIRP4
CNSTI4 84
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRGP4 g_respawnDelay+12
INDIRI4
CNSTI4 1000
MULI4
ADDI4
CNSTI4 1700
ADDI4
ASGNI4
line 825
;825:					marker->s.otherEntityNum = self->s.number;
ADDRLP4 164
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 826
;826:					marker->s.otherEntityNum2 = self->client->sess.sessionTeam;
ADDRLP4 164
INDIRP4
CNSTI4 144
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
ASGNI4
line 827
;827:					marker->s.pos.trType = TR_STATIONARY;
ADDRLP4 164
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 828
;828:					marker->s.apos.trType = TR_LINEAR;
ADDRLP4 164
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 2
ASGNI4
line 829
;829:					VectorClear(marker->s.apos.trBase);
ADDRLP4 172
ADDRLP4 164
INDIRP4
ASGNP4
ADDRLP4 176
CNSTF4 0
ASGNF4
ADDRLP4 172
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 176
INDIRF4
ASGNF4
ADDRLP4 172
INDIRP4
CNSTI4 64
ADDP4
ADDRLP4 176
INDIRF4
ASGNF4
ADDRLP4 172
INDIRP4
CNSTI4 60
ADDP4
ADDRLP4 176
INDIRF4
ASGNF4
line 830
;830:					VectorClear(marker->s.apos.trDelta);
ADDRLP4 180
ADDRLP4 164
INDIRP4
ASGNP4
ADDRLP4 184
CNSTF4 0
ASGNF4
ADDRLP4 180
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 184
INDIRF4
ASGNF4
ADDRLP4 180
INDIRP4
CNSTI4 76
ADDP4
ADDRLP4 184
INDIRF4
ASGNF4
ADDRLP4 180
INDIRP4
CNSTI4 72
ADDP4
ADDRLP4 184
INDIRF4
ASGNF4
line 831
;831:					marker->s.apos.trTime = level.time;
ADDRLP4 164
INDIRP4
CNSTI4 52
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 832
;832:					marker->s.apos.trBase[YAW] = 360 * random();
ADDRLP4 188
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 164
INDIRP4
CNSTI4 64
ADDP4
ADDRLP4 188
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 188
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
line 833
;833:					self->client->podMarker = marker;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1012
ADDP4
ADDRLP4 164
INDIRP4
ASGNP4
line 834
;834:				}
LABELV $366
line 835
;835:			}
LABELV $360
line 836
;836:		}
LABELV $353
line 837
;837:		if (!self->client->podMarker) self->client->mayRespawnAtDeathOrigin = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1012
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $371
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 984
ADDP4
CNSTI4 0
ASGNI4
LABELV $371
line 838
;838:	}
LABELV $350
line 841
;839:#endif
;840:
;841:	self->enemy = attacker;
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
ADDRFP4 8
INDIRP4
ASGNP4
line 843
;842:
;843:	self->client->ps.persistant[PERS_KILLED]++;
ADDRLP4 60
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 280
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 844
;844:	self->client->respawnDelay = 1000 * g_respawnDelay.integer;	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 836
ADDP4
ADDRGP4 g_respawnDelay+12
INDIRI4
CNSTI4 1000
MULI4
ASGNI4
line 845
;845:	if (g_gametype.integer == GT_TOURNAMENT) self->client->respawnDelay = 0;	// JUHOX
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
NEI4 $374
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 836
ADDP4
CNSTI4 0
ASGNI4
LABELV $374
line 848
;846:
;847:#if 1	// JUHOX: check overkill
;848:	score = 1;
ADDRLP4 16
CNSTI4 1
ASGNI4
line 849
;849:	if (CheckForOverkill(self, attacker)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 CheckForOverkill
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
EQI4 $377
line 850
;850:		score = 5;
ADDRLP4 16
CNSTI4 5
ASGNI4
line 851
;851:		if (g_gametype.integer < GT_TEAM) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
GEI4 $379
line 854
;852:			// the last man standing is already rewarded by CheckForOverkill()
;853:			// now check if the target is to be punished for suiciding
;854:			score = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 855
;855:			if (attacker == self || !attacker || !attacker->client) score = 1;	// will be subtracted below
ADDRLP4 68
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 72
ADDRLP4 68
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 72
INDIRU4
ADDRFP4 0
INDIRP4
CVPU4 4
EQU4 $385
ADDRLP4 72
INDIRU4
CNSTU4 0
EQU4 $385
ADDRLP4 68
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $382
LABELV $385
ADDRLP4 16
CNSTI4 1
ASGNI4
LABELV $382
line 856
;856:		}
LABELV $379
line 858
;857:#if MONSTER_MODE
;858:		level.overkilled = qtrue;
ADDRGP4 level+22996
CNSTI4 1
ASGNI4
line 860
;859:#endif
;860:		G_LogPrintf("Overkill!\n");
ADDRGP4 $387
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 861
;861:	}
LABELV $377
line 865
;862:#endif
;863:
;864:#if MONSTER_MODE	// JUHOX: in STU all player deaths count for the blue team (monsters)
;865:	if (g_gametype.integer >= GT_STU) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
LTI4 $388
line 866
;866:		if (!level.warmupTime) {
ADDRGP4 level+16
INDIRI4
CNSTI4 0
NEI4 $389
line 867
;867:			level.teamScores[TEAM_BLUE] += score;
ADDRLP4 68
ADDRGP4 level+44+8
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRI4
ADDRLP4 16
INDIRI4
ADDI4
ASGNI4
line 868
;868:			CalculateRanks();
ADDRGP4 CalculateRanks
CALLV
pop
line 869
;869:		}
line 870
;870:	}
ADDRGP4 $389
JUMPV
LABELV $388
line 873
;871:	else
;872:#endif
;873:	if (attacker && attacker->client) {
ADDRLP4 68
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $396
ADDRLP4 68
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $396
line 874
;874:		attacker->client->lastkilled_client = self->s.number;
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 816
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 876
;875:
;876:		if ( attacker == self || OnSameTeam (self, attacker ) ) {
ADDRLP4 72
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CVPU4 4
ADDRLP4 76
INDIRP4
CVPU4 4
EQU4 $400
ADDRLP4 76
INDIRP4
ARGP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRLP4 80
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 0
EQI4 $398
LABELV $400
line 877
;877:			AddScore( attacker, self->r.currentOrigin, /*-1*/-score );	// JUHOX
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 16
INDIRI4
NEGI4
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 878
;878:		} else {
ADDRGP4 $397
JUMPV
LABELV $398
line 879
;879:			AddScore( attacker, self->r.currentOrigin, /*1*/score );	// JUHOX
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 16
INDIRI4
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 881
;880:
;881:			if( meansOfDeath == MOD_GAUNTLET ) {
ADDRFP4 16
INDIRI4
CNSTI4 2
NEI4 $401
line 884
;882:				
;883:				// play humiliation on player
;884:				attacker->client->ps.persistant[PERS_GAUNTLET_FRAG_COUNT]++;
ADDRLP4 84
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 300
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 887
;885:
;886:				// add the sprite over the player's head
;887:				attacker->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
ADDRLP4 88
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 888
;888:				attacker->client->ps.eFlags |= EF_AWARD_GAUNTLET;
ADDRLP4 92
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
line 889
;889:				attacker->client->rewardTime = level.time + REWARD_SPRITE_TIME;
ADDRFP4 8
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
line 892
;890:
;891:				// also play humiliation on target
;892:				self->client->ps.persistant[PERS_PLAYEREVENTS] ^= PLAYEREVENT_GAUNTLETREWARD;
ADDRLP4 96
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 268
ADDP4
ASGNP4
ADDRLP4 96
INDIRP4
ADDRLP4 96
INDIRP4
INDIRI4
CNSTI4 2
BXORI4
ASGNI4
line 893
;893:			}
LABELV $401
line 897
;894:
;895:			// check for two kills in a short amount of time
;896:			// if this is close enough to the last kill, give a reward sound
;897:			if ( level.time - attacker->client->lastKillTime < CARNAGE_REWARD_TIME ) {
ADDRGP4 level+32
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 872
ADDP4
INDIRI4
SUBI4
CNSTI4 3000
GEI4 $404
line 899
;898:				// play excellent on player
;899:				attacker->client->ps.persistant[PERS_EXCELLENT_COUNT]++;
ADDRLP4 84
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 288
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 902
;900:
;901:				// add the sprite over the player's head
;902:				attacker->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
ADDRLP4 88
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 903
;903:				attacker->client->ps.eFlags |= EF_AWARD_EXCELLENT;
ADDRLP4 92
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 904
;904:				attacker->client->rewardTime = level.time + REWARD_SPRITE_TIME;
ADDRFP4 8
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
line 905
;905:			}
LABELV $404
line 906
;906:			attacker->client->lastKillTime = level.time;
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 872
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 908
;907:
;908:		}
line 909
;909:	} else {
ADDRGP4 $397
JUMPV
LABELV $396
line 910
;910:		AddScore( self, self->r.currentOrigin, /*-1*/-score );	// JUHOX
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRLP4 72
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 16
INDIRI4
NEGI4
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 911
;911:	}
LABELV $397
LABELV $389
line 914
;912:
;913:	// Add team bonuses
;914:	Team_FragBonuses(self, inflictor, attacker);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Team_FragBonuses
CALLV
pop
line 917
;915:
;916:	// if I committed suicide, the flag does not fall, it returns.
;917:	if (meansOfDeath == MOD_SUICIDE) {
ADDRFP4 16
INDIRI4
CNSTI4 25
NEI4 $409
line 918
;918:		if ( self->client->ps.powerups[PW_NEUTRALFLAG] ) {		// only happens in One Flag CTF
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
CNSTI4 0
EQI4 $411
line 919
;919:			Team_ReturnFlag( TEAM_FREE );
CNSTI4 0
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 920
;920:			self->client->ps.powerups[PW_NEUTRALFLAG] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 348
ADDP4
CNSTI4 0
ASGNI4
line 921
;921:		}
ADDRGP4 $412
JUMPV
LABELV $411
line 922
;922:		else if ( self->client->ps.powerups[PW_REDFLAG] ) {		// only happens in standard CTF
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
EQI4 $413
line 923
;923:			Team_ReturnFlag( TEAM_RED );
CNSTI4 1
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 924
;924:			self->client->ps.powerups[PW_REDFLAG] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 340
ADDP4
CNSTI4 0
ASGNI4
line 925
;925:		}
ADDRGP4 $414
JUMPV
LABELV $413
line 926
;926:		else if ( self->client->ps.powerups[PW_BLUEFLAG] ) {	// only happens in standard CTF
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
EQI4 $415
line 927
;927:			Team_ReturnFlag( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 928
;928:			self->client->ps.powerups[PW_BLUEFLAG] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 344
ADDP4
CNSTI4 0
ASGNI4
line 929
;929:		}
LABELV $415
LABELV $414
LABELV $412
line 930
;930:	}
LABELV $409
line 933
;931:
;932:	// if client is in a nodrop area, don't drop anything (but return CTF flags!)
;933:	contents = trap_PointContents( self->r.currentOrigin, -1 );
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 72
ADDRGP4 trap_PointContents
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 72
INDIRI4
ASGNI4
line 934
;934:	if ( !( contents & CONTENTS_NODROP )) {
ADDRLP4 12
INDIRI4
CVIU4 4
CNSTU4 2147483648
BANDU4
CNSTU4 0
NEU4 $417
line 935
;935:		TossClientItems( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 TossClientItems
CALLV
pop
line 936
;936:	}
ADDRGP4 $418
JUMPV
LABELV $417
line 937
;937:	else {
line 938
;938:		if ( self->client->ps.powerups[PW_NEUTRALFLAG] ) {		// only happens in One Flag CTF
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
CNSTI4 0
EQI4 $419
line 939
;939:			Team_ReturnFlag( TEAM_FREE );
CNSTI4 0
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 940
;940:		}
ADDRGP4 $420
JUMPV
LABELV $419
line 941
;941:		else if ( self->client->ps.powerups[PW_REDFLAG] ) {		// only happens in standard CTF
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
EQI4 $421
line 942
;942:			Team_ReturnFlag( TEAM_RED );
CNSTI4 1
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 943
;943:		}
ADDRGP4 $422
JUMPV
LABELV $421
line 944
;944:		else if ( self->client->ps.powerups[PW_BLUEFLAG] ) {	// only happens in standard CTF
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
EQI4 $423
line 945
;945:			Team_ReturnFlag( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 946
;946:		}
LABELV $423
LABELV $422
LABELV $420
line 947
;947:	}
LABELV $418
line 955
;948:#ifdef MISSIONPACK
;949:	TossClientPersistantPowerups( self );
;950:	if( g_gametype.integer == GT_HARVESTER ) {
;951:		TossClientCubes( self );
;952:	}
;953:#endif
;954:
;955:	Cmd_Score_f( self );		// show scores
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Cmd_Score_f
CALLV
pop
line 958
;956:	// send updated scores to any clients that are following this one,
;957:	// or they would get stale scoreboards
;958:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $428
JUMPV
LABELV $425
line 961
;959:		gclient_t	*client;
;960:
;961:		client = &level.clients[i];
ADDRLP4 76
ADDRLP4 0
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 962
;962:		if ( client->pers.connected != CON_CONNECTED ) {
ADDRLP4 76
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $430
line 963
;963:			continue;
ADDRGP4 $426
JUMPV
LABELV $430
line 965
;964:		}
;965:		if ( client->sess.sessionTeam != TEAM_SPECTATOR ) {
ADDRLP4 76
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 3
EQI4 $432
line 966
;966:			continue;
ADDRGP4 $426
JUMPV
LABELV $432
line 968
;967:		}
;968:		if ( client->sess.spectatorClient == self->s.number ) {
ADDRLP4 76
INDIRP4
CNSTI4 708
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
INDIRI4
NEI4 $434
line 969
;969:			Cmd_Score_f( g_entities + i );
ADDRLP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRGP4 Cmd_Score_f
CALLV
pop
line 970
;970:		}
LABELV $434
line 971
;971:	}
LABELV $426
line 958
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $428
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $425
line 973
;972:
;973:	self->takedamage = qtrue;	// can still be gibbed
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
CNSTI4 1
ASGNI4
line 975
;974:
;975:	self->client->pers.lastUsedWeapon = self->s.weapon;	// JUHOX: keep track of the weapon used when killed
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 616
ADDP4
ADDRLP4 76
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ASGNI4
line 976
;976:	self->s.weapon = WP_NONE;
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 0
ASGNI4
line 977
;977:	self->s.powerups = 0;
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
CNSTI4 0
ASGNI4
line 978
;978:	self->r.contents = CONTENTS_CORPSE;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 67108864
ASGNI4
line 980
;979:
;980:	self->s.angles[0] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
CNSTF4 0
ASGNF4
line 981
;981:	self->s.angles[2] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
CNSTF4 0
ASGNF4
line 982
;982:	LookAtKiller (self, inflictor, attacker);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 LookAtKiller
CALLV
pop
line 984
;983:
;984:	VectorCopy( self->s.angles, self->client->ps.viewangles );
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 152
ADDP4
ADDRLP4 80
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 986
;985:
;986:	self->s.loopSound = 0;
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
CNSTI4 0
ASGNI4
line 988
;987:
;988:	self->r.maxs[2] = -8;
ADDRFP4 0
INDIRP4
CNSTI4 456
ADDP4
CNSTF4 3238002688
ASGNF4
line 992
;989:
;990:	// don't allow respawn until the death anim is done
;991:	// g_forcerespawn may force spawning at some later time
;992:	self->client->respawnTime = level.time + 1700;
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
line 999
;993:
;994:	// remove powerups
;995:	// JUHOX: remove only the real powerups
;996:#if 0
;997:	memset( self->client->ps.powerups, 0, sizeof(self->client->ps.powerups) );
;998:#else
;999:	memset(self->client->ps.powerups, 0, PW_NUM_POWERUPS * sizeof(int));
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 52
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1003
;1000:#endif
;1001:
;1002:	// never gib in a nodrop
;1003:	if ( (self->health <= GIB_HEALTH && !(contents & CONTENTS_NODROP) && g_blood.integer) || meansOfDeath == MOD_SUICIDE) {
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 -40
GTI4 $442
ADDRLP4 12
INDIRI4
CVIU4 4
CNSTU4 2147483648
BANDU4
CNSTU4 0
NEU4 $442
ADDRGP4 g_blood+12
INDIRI4
CNSTI4 0
NEI4 $440
LABELV $442
ADDRFP4 16
INDIRI4
CNSTI4 25
NEI4 $437
LABELV $440
line 1005
;1004:		// gib death
;1005:		GibEntity( self, killer );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 GibEntity
CALLV
pop
line 1006
;1006:	} else {
ADDRGP4 $438
JUMPV
LABELV $437
line 1010
;1007:		// normal death
;1008:		static int i;
;1009:
;1010:		switch ( i ) {
ADDRLP4 84
ADDRGP4 $443
INDIRI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
EQI4 $446
ADDRLP4 84
INDIRI4
CNSTI4 1
EQI4 $447
ADDRLP4 84
INDIRI4
CNSTI4 2
EQI4 $448
ADDRGP4 $444
JUMPV
LABELV $446
line 1012
;1011:		case 0:
;1012:			anim = BOTH_DEATH1;
ADDRLP4 28
CNSTI4 0
ASGNI4
line 1013
;1013:			break;
ADDRGP4 $445
JUMPV
LABELV $447
line 1015
;1014:		case 1:
;1015:			anim = BOTH_DEATH2;
ADDRLP4 28
CNSTI4 2
ASGNI4
line 1016
;1016:			break;
ADDRGP4 $445
JUMPV
LABELV $448
LABELV $444
line 1019
;1017:		case 2:
;1018:		default:
;1019:			anim = BOTH_DEATH3;
ADDRLP4 28
CNSTI4 4
ASGNI4
line 1020
;1020:			break;
LABELV $445
line 1025
;1021:		}
;1022:
;1023:		// for the no-blood option, we need to prevent the health
;1024:		// from going to gib level
;1025:		if ( self->health <= GIB_HEALTH ) {
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 -40
GTI4 $449
line 1026
;1026:			self->health = GIB_HEALTH+1;
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 -39
ASGNI4
line 1027
;1027:		}
LABELV $449
line 1029
;1028:
;1029:		self->client->ps.legsAnim = 
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 76
ADDP4
ADDRLP4 88
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 128
BXORI4
ADDRLP4 28
INDIRI4
BORI4
ASGNI4
line 1031
;1030:			( ( self->client->ps.legsAnim & ANIM_TOGGLEBIT ) ^ ANIM_TOGGLEBIT ) | anim;
;1031:		self->client->ps.torsoAnim = 
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 84
ADDP4
ADDRLP4 92
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 128
BXORI4
ADDRLP4 28
INDIRI4
BORI4
ASGNI4
line 1034
;1032:			( ( self->client->ps.torsoAnim & ANIM_TOGGLEBIT ) ^ ANIM_TOGGLEBIT ) | anim;
;1033:
;1034:		G_AddEvent( self, EV_DEATH1 + i, killer );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $443
INDIRI4
CNSTI4 58
ADDI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 1037
;1035:
;1036:		// the body can still be gibbed
;1037:		self->die = body_die;
ADDRFP4 0
INDIRP4
CNSTI4 720
ADDP4
ADDRGP4 body_die
ASGNP4
line 1040
;1038:
;1039:		// globally cycle through the different death animations
;1040:		i = ( i + 1 ) % 3;
ADDRLP4 96
ADDRGP4 $443
ASGNP4
ADDRLP4 96
INDIRP4
ADDRLP4 96
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 3
MODI4
ASGNI4
line 1047
;1041:
;1042:#ifdef MISSIONPACK
;1043:		if (self->s.eFlags & EF_KAMIKAZE) {
;1044:			Kamikaze_DeathTimer( self );
;1045:		}
;1046:#endif
;1047:	}
LABELV $438
line 1049
;1048:
;1049:	trap_LinkEntity (self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 1051
;1050:
;1051:}
LABELV $315
endproc player_die 192 28
export CheckArmor
proc CheckArmor 24 4
line 1060
;1052:
;1053:
;1054:/*
;1055:================
;1056:CheckArmor
;1057:================
;1058:*/
;1059:int CheckArmor (gentity_t *ent, int damage, int dflags)
;1060:{
line 1094
;1061:	// JUHOX: check armor also for monsters
;1062:#if !MONSTER_MODE
;1063:	gclient_t	*client;
;1064:	int			save;
;1065:	int			count;
;1066:
;1067:	if (!damage)
;1068:		return 0;
;1069:
;1070:	client = ent->client;
;1071:
;1072:	if (!client)
;1073:		return 0;
;1074:
;1075:	if (dflags & DAMAGE_NO_ARMOR)
;1076:		return 0;
;1077:
;1078:	// armor
;1079:	count = client->ps.stats[STAT_ARMOR];
;1080:	save = ceil( damage * ARMOR_PROTECTION );
;1081:	if (save >= count)
;1082:		save = count;
;1083:
;1084:	if (!save)
;1085:		return 0;
;1086:
;1087:	client->ps.stats[STAT_ARMOR] -= save;
;1088:
;1089:	return save;
;1090:#else
;1091:	int save, count;
;1092:	playerState_t* ps;
;1093:
;1094:	if (dflags & DAMAGE_NO_ARMOR) return 0;
ADDRFP4 8
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $452
CNSTI4 0
RETI4
ADDRGP4 $451
JUMPV
LABELV $452
line 1095
;1095:	if (!damage) return 0;
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $454
CNSTI4 0
RETI4
ADDRGP4 $451
JUMPV
LABELV $454
line 1097
;1096:
;1097:	ps = G_GetEntityPlayerState(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 12
INDIRP4
ASGNP4
line 1098
;1098:	if (!ps) return 0;
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $456
CNSTI4 0
RETI4
ADDRGP4 $451
JUMPV
LABELV $456
line 1100
;1099:
;1100:	count = ps->stats[STAT_ARMOR];
ADDRLP4 8
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
line 1101
;1101:	save = ceil(damage * ARMOR_PROTECTION);
ADDRFP4 4
INDIRI4
CVIF4 4
CNSTF4 1059648963
MULF4
ARGF4
ADDRLP4 16
ADDRGP4 ceil
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 16
INDIRF4
CVFI4 4
ASGNI4
line 1102
;1102:	if (save >= count) save = count;
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $458
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
LABELV $458
line 1104
;1103:
;1104:	ps->stats[STAT_ARMOR] -= save;
ADDRLP4 20
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
ASGNI4
line 1105
;1105:	return save;
ADDRLP4 0
INDIRI4
RETI4
LABELV $451
endproc CheckArmor 24 4
export RaySphereIntersections
proc RaySphereIntersections 56 4
line 1114
;1106:#endif
;1107:}
;1108:
;1109:/*
;1110:================
;1111:RaySphereIntersections
;1112:================
;1113:*/
;1114:int RaySphereIntersections( vec3_t origin, float radius, vec3_t point, vec3_t dir, vec3_t intersections[2] ) {
line 1123
;1115:	float b, c, d, t;
;1116:
;1117:	//	| origin - (point + t * dir) | = radius
;1118:	//	a = dir[0]^2 + dir[1]^2 + dir[2]^2;
;1119:	//	b = 2 * (dir[0] * (point[0] - origin[0]) + dir[1] * (point[1] - origin[1]) + dir[2] * (point[2] - origin[2]));
;1120:	//	c = (point[0] - origin[0])^2 + (point[1] - origin[1])^2 + (point[2] - origin[2])^2 - radius^2;
;1121:
;1122:	// normalize dir so a = 1
;1123:	VectorNormalize(dir);
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 1124
;1124:	b = 2 * (dir[0] * (point[0] - origin[0]) + dir[1] * (point[1] - origin[1]) + dir[2] * (point[2] - origin[2]));
ADDRLP4 16
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 20
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRP4
INDIRF4
ADDRLP4 20
INDIRP4
INDIRF4
ADDRLP4 24
INDIRP4
INDIRF4
SUBF4
MULF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
MULF4
ADDF4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
MULF4
ADDF4
CNSTF4 1073741824
MULF4
ASGNF4
line 1125
;1125:	c = (point[0] - origin[0]) * (point[0] - origin[0]) +
ADDRLP4 28
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 32
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 40
ADDRFP4 4
INDIRF4
ASGNF4
ADDRLP4 12
ADDRLP4 36
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
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
MULF4
ADDF4
ADDRLP4 28
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ADDRLP4 28
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
MULF4
ADDF4
ADDRLP4 40
INDIRF4
ADDRLP4 40
INDIRF4
MULF4
SUBF4
ASGNF4
line 1130
;1126:		(point[1] - origin[1]) * (point[1] - origin[1]) +
;1127:		(point[2] - origin[2]) * (point[2] - origin[2]) -
;1128:		radius * radius;
;1129:
;1130:	d = b * b - 4 * c;
ADDRLP4 8
ADDRLP4 4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ADDRLP4 12
INDIRF4
CNSTF4 1082130432
MULF4
SUBF4
ASGNF4
line 1131
;1131:	if (d > 0) {
ADDRLP4 8
INDIRF4
CNSTF4 0
LEF4 $461
line 1132
;1132:		t = (- b + sqrt(d)) / 2;
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 48
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
NEGF4
ADDRLP4 48
INDIRF4
ADDF4
CNSTF4 1056964608
MULF4
ASGNF4
line 1133
;1133:		VectorMA(point, t, dir, intersections[0]);
ADDRFP4 16
INDIRP4
ADDRFP4 8
INDIRP4
INDIRF4
ADDRFP4 12
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRFP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
line 1134
;1134:		t = (- b - sqrt(d)) / 2;
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 52
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
NEGF4
ADDRLP4 52
INDIRF4
SUBF4
CNSTF4 1056964608
MULF4
ASGNF4
line 1135
;1135:		VectorMA(point, t, dir, intersections[1]);
ADDRFP4 16
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 8
INDIRP4
INDIRF4
ADDRFP4 12
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRFP4 16
INDIRP4
CNSTI4 16
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRFP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRFP4 16
INDIRP4
CNSTI4 20
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
line 1136
;1136:		return 2;
CNSTI4 2
RETI4
ADDRGP4 $460
JUMPV
LABELV $461
line 1138
;1137:	}
;1138:	else if (d == 0) {
ADDRLP4 8
INDIRF4
CNSTF4 0
NEF4 $463
line 1139
;1139:		t = (- b ) / 2;
ADDRLP4 0
ADDRLP4 4
INDIRF4
NEGF4
CNSTF4 1056964608
MULF4
ASGNF4
line 1140
;1140:		VectorMA(point, t, dir, intersections[0]);
ADDRFP4 16
INDIRP4
ADDRFP4 8
INDIRP4
INDIRF4
ADDRFP4 12
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRFP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
line 1141
;1141:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $460
JUMPV
LABELV $463
line 1143
;1142:	}
;1143:	return 0;
CNSTI4 0
RETI4
LABELV $460
endproc RaySphereIntersections 56 4
export G_Damage
proc G_Damage 100 24
line 1210
;1144:}
;1145:
;1146:#ifdef MISSIONPACK
;1147:/*
;1148:================
;1149:G_InvulnerabilityEffect
;1150:================
;1151:*/
;1152:int G_InvulnerabilityEffect( gentity_t *targ, vec3_t dir, vec3_t point, vec3_t impactpoint, vec3_t bouncedir ) {
;1153:	gentity_t	*impact;
;1154:	vec3_t		intersections[2], vec;
;1155:	int			n;
;1156:
;1157:	if ( !targ->client ) {
;1158:		return qfalse;
;1159:	}
;1160:	VectorCopy(dir, vec);
;1161:	VectorInverse(vec);
;1162:	// sphere model radius = 42 units
;1163:	n = RaySphereIntersections( targ->client->ps.origin, 42, point, vec, intersections);
;1164:	if (n > 0) {
;1165:		impact = G_TempEntity( targ->client->ps.origin, EV_INVUL_IMPACT );
;1166:		VectorSubtract(intersections[0], targ->client->ps.origin, vec);
;1167:		vectoangles(vec, impact->s.angles);
;1168:		impact->s.angles[0] += 90;
;1169:		if (impact->s.angles[0] > 360)
;1170:			impact->s.angles[0] -= 360;
;1171:		if ( impactpoint ) {
;1172:			VectorCopy( intersections[0], impactpoint );
;1173:		}
;1174:		if ( bouncedir ) {
;1175:			VectorCopy( vec, bouncedir );
;1176:			VectorNormalize( bouncedir );
;1177:		}
;1178:		return qtrue;
;1179:	}
;1180:	else {
;1181:		return qfalse;
;1182:	}
;1183:}
;1184:#endif
;1185:/*
;1186:============
;1187:T_Damage
;1188:
;1189:targ		entity that is being damaged
;1190:inflictor	entity that is causing the damage
;1191:attacker	entity that caused the inflictor to damage targ
;1192:	example: targ=monster, inflictor=rocket, attacker=player
;1193:
;1194:dir			direction of the attack for knockback
;1195:point		point at which the damage is being inflicted, used for headshots
;1196:damage		amount of damage being inflicted
;1197:knockback	force to be applied against targ as a result of the damage
;1198:
;1199:inflictor, attacker, dir, and point can be NULL for environmental effects
;1200:
;1201:dflags		these flags are used to control how T_Damage works
;1202:	DAMAGE_RADIUS			damage was indirect (from a nearby explosion)
;1203:	DAMAGE_NO_ARMOR			armor does not protect from this damage
;1204:	DAMAGE_NO_KNOCKBACK		do not affect velocity, just view angles
;1205:	DAMAGE_NO_PROTECTION	kills godmode, armor, everything
;1206:============
;1207:*/
;1208:
;1209:void G_Damage( gentity_t *targ, gentity_t *inflictor, gentity_t *attacker,
;1210:			   vec3_t dir, vec3_t point, int damage, int dflags, int mod ) {
line 1221
;1211:	gclient_t	*client;
;1212:	int			take;
;1213:	int			save;
;1214:	int			asave;
;1215:	int			knockback;
;1216:	int			max;
;1217:#ifdef MISSIONPACK
;1218:	vec3_t		bouncedir, impactpoint;
;1219:#endif
;1220:
;1221:	if (!targ->takedamage) {
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
CNSTI4 0
NEI4 $466
line 1222
;1222:		return;
ADDRGP4 $465
JUMPV
LABELV $466
line 1227
;1223:	}
;1224:
;1225:	// the intermission has allready been qualified for, so don't
;1226:	// allow any extra scoring
;1227:	if ( level.intermissionQueued ) {
ADDRGP4 level+9140
INDIRI4
CNSTI4 0
EQI4 $468
line 1228
;1228:		return;
ADDRGP4 $465
JUMPV
LABELV $468
line 1240
;1229:	}
;1230:#ifdef MISSIONPACK
;1231:	if ( targ->client && mod != MOD_JUICED) {
;1232:		if ( targ->client->invulnerabilityTime > level.time) {
;1233:			if ( dir && point ) {
;1234:				G_InvulnerabilityEffect( targ, dir, point, impactpoint, bouncedir );
;1235:			}
;1236:			return;
;1237:		}
;1238:	}
;1239:#endif
;1240:	if ( !inflictor ) {
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $471
line 1241
;1241:		inflictor = &g_entities[ENTITYNUM_WORLD];
ADDRFP4 4
ADDRGP4 g_entities+862568
ASGNP4
line 1242
;1242:	}
LABELV $471
line 1243
;1243:	if ( !attacker ) {
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $474
line 1244
;1244:		attacker = &g_entities[ENTITYNUM_WORLD];
ADDRFP4 8
ADDRGP4 g_entities+862568
ASGNP4
line 1245
;1245:	}
LABELV $474
line 1248
;1246:
;1247:	// shootable doors / buttons don't actually have any health
;1248:	if ( targ->s.eType == ET_MOVER ) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 4
NEI4 $477
line 1249
;1249:		if ( targ->use && targ->moverState == MOVER_POS1 ) {
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 712
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $465
ADDRLP4 24
INDIRP4
CNSTI4 580
ADDP4
INDIRI4
CNSTI4 0
NEI4 $465
line 1250
;1250:			targ->use( targ, inflictor, attacker );
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 28
INDIRP4
CNSTI4 712
ADDP4
INDIRP4
CALLV
pop
line 1251
;1251:		}
line 1252
;1252:		return;
ADDRGP4 $465
JUMPV
LABELV $477
line 1265
;1253:	}
;1254:#ifdef MISSIONPACK
;1255:	if( g_gametype.integer == GT_OBELISK && CheckObeliskAttack( targ, attacker ) ) {
;1256:		return;
;1257:	}
;1258:#endif
;1259:	// reduce damage by the attacker's handicap value
;1260:	// unless they are rocket jumping
;1261:	// JUHOX: don't apply handicap to charge damage (already applied during charging)
;1262:#if 0
;1263:	if ( attacker->client && attacker != targ ) {
;1264:#else
;1265:	if (attacker->client && attacker != targ && mod != MOD_CHARGE) {
ADDRLP4 24
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $481
ADDRLP4 24
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
EQU4 $481
ADDRFP4 28
INDIRI4
CNSTI4 7
EQI4 $481
line 1267
;1266:#endif
;1267:		max = attacker->client->ps.stats[STAT_MAX_HEALTH];
ADDRLP4 20
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
ASGNI4
line 1277
;1268:#ifdef MISSIONPACK
;1269:		if( bg_itemlist[attacker->client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_GUARD ) {
;1270:			max /= 2;
;1271:		}
;1272:#endif
;1273:		// JUHOX: consider variable max health
;1274:#if 0
;1275:		damage = damage * max / 100;
;1276:#else
;1277:		if (g_baseHealth.integer > 1) {
ADDRGP4 g_baseHealth+12
INDIRI4
CNSTI4 1
LEI4 $483
line 1278
;1278:			damage = damage * max / g_baseHealth.integer;
ADDRFP4 20
ADDRFP4 20
INDIRI4
ADDRLP4 20
INDIRI4
MULI4
ADDRGP4 g_baseHealth+12
INDIRI4
DIVI4
ASGNI4
line 1279
;1279:		}
LABELV $483
line 1281
;1280:#endif
;1281:	}
LABELV $481
line 1283
;1282:
;1283:	client = targ->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 1285
;1284:
;1285:	if ( client ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $487
line 1286
;1286:		if ( client->noclip ) {
ADDRLP4 0
INDIRP4
CNSTI4 728
ADDP4
INDIRI4
CNSTI4 0
EQI4 $489
line 1287
;1287:			return;
ADDRGP4 $465
JUMPV
LABELV $489
line 1291
;1288:		}
;1289:		// JUHOX: check for shield protection
;1290:#if 1
;1291:		if (client->ps.powerups[PW_SHIELD] && !(dflags & DAMAGE_NO_PROTECTION)) {
ADDRLP4 0
INDIRP4
CNSTI4 356
ADDP4
INDIRI4
CNSTI4 0
EQI4 $491
ADDRFP4 24
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $491
line 1292
;1292:			return;
ADDRGP4 $465
JUMPV
LABELV $491
line 1295
;1293:		}
;1294:#endif
;1295:	}
LABELV $487
line 1297
;1296:
;1297:	if ( !dir ) {
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $493
line 1298
;1298:		dflags |= DAMAGE_NO_KNOCKBACK;
ADDRFP4 24
ADDRFP4 24
INDIRI4
CNSTI4 4
BORI4
ASGNI4
line 1299
;1299:	} else {
ADDRGP4 $494
JUMPV
LABELV $493
line 1300
;1300:		VectorNormalize(dir);
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 1301
;1301:	}
LABELV $494
line 1303
;1302:
;1303:	knockback = damage;
ADDRLP4 8
ADDRFP4 20
INDIRI4
ASGNI4
line 1304
;1304:	if ( knockback > 200 ) {
ADDRLP4 8
INDIRI4
CNSTI4 200
LEI4 $495
line 1305
;1305:		knockback = 200;
ADDRLP4 8
CNSTI4 200
ASGNI4
line 1306
;1306:	}
LABELV $495
line 1307
;1307:	if ( targ->flags & FL_NO_KNOCKBACK ) {
ADDRFP4 0
INDIRP4
CNSTI4 540
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $497
line 1308
;1308:		knockback = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 1309
;1309:	}
LABELV $497
line 1310
;1310:	if ( dflags & DAMAGE_NO_KNOCKBACK ) {
ADDRFP4 24
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $499
line 1311
;1311:		knockback = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 1312
;1312:	}
LABELV $499
line 1350
;1313:
;1314:	// figure momentum add, even if the damage won't be taken
;1315:	// JUHOX: knock back monsters too
;1316:#if !MONSTER_MODE
;1317:	if ( knockback && targ->client ) {
;1318:		vec3_t	kvel;
;1319:		float	mass;
;1320:
;1321:		mass = 200;
;1322:		// JUHOX: give gauntlet a stronger knockback
;1323:#if 1
;1324:		if (mod == MOD_GAUNTLET) {
;1325:			mass = 100;	// lower mass results in stronger knockback
;1326:		}
;1327:#endif
;1328:
;1329:		VectorScale (dir, g_knockback.value * (float)knockback / mass, kvel);
;1330:		VectorAdd (targ->client->ps.velocity, kvel, targ->client->ps.velocity);
;1331:
;1332:		// set the timer so that the other client can't cancel
;1333:		// out the movement immediately
;1334:		if ( !targ->client->ps.pm_time ) {
;1335:			int		t;
;1336:
;1337:			t = knockback * 2;
;1338:			if ( t < 50 ) {
;1339:				t = 50;
;1340:			}
;1341:			if ( t > 200 ) {
;1342:				t = 200;
;1343:			}
;1344:			targ->client->ps.pm_time = t;
;1345:			targ->client->ps.pm_flags |= PMF_TIME_KNOCKBACK;
;1346:		}
;1347:	}
;1348:#else
;1349:	if (
;1350:		knockback &&
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $501
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $501
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 G_IsMovable
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $501
line 1353
;1351:		G_GetEntityPlayerState(targ) &&
;1352:		G_IsMovable(targ)
;1353:	) {
line 1358
;1354:		playerState_t* ps;
;1355:		vec3_t	kvel;
;1356:		float	mass;
;1357:
;1358:		ps = G_GetEntityPlayerState(targ);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 36
ADDRLP4 56
INDIRP4
ASGNP4
line 1359
;1359:		mass = 200;
ADDRLP4 52
CNSTF4 1128792064
ASGNF4
line 1360
;1360:		if (mod == MOD_GAUNTLET) {
ADDRFP4 28
INDIRI4
CNSTI4 2
NEI4 $503
line 1361
;1361:			mass = 100;	// lower mass results in stronger knockback
ADDRLP4 52
CNSTF4 1120403456
ASGNF4
line 1362
;1362:		}
LABELV $503
line 1364
;1363:
;1364:		switch (targ->s.clientNum) {
ADDRLP4 60
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 65
EQI4 $508
ADDRLP4 60
INDIRI4
CNSTI4 66
EQI4 $509
ADDRGP4 $505
JUMPV
LABELV $508
line 1366
;1365:		case CLIENTNUM_MONSTER_GUARD:
;1366:			mass *= Square(MONSTER_GUARD_SCALE);
ADDRLP4 52
ADDRLP4 52
INDIRF4
CNSTF4 1082130432
MULF4
ASGNF4
line 1367
;1367:			break;
ADDRGP4 $506
JUMPV
LABELV $509
line 1369
;1368:		case CLIENTNUM_MONSTER_TITAN:
;1369:			mass *= Square(MONSTER_TITAN_SCALE);
ADDRLP4 52
ADDRLP4 52
INDIRF4
CNSTF4 1094975488
MULF4
ASGNF4
line 1370
;1370:			break;
LABELV $505
LABELV $506
line 1373
;1371:		}
;1372:		
;1373:		if (mod == MOD_TITAN) {
ADDRFP4 28
INDIRI4
CNSTI4 5
NEI4 $510
line 1374
;1374:			mass *= 0.2;
ADDRLP4 52
ADDRLP4 52
INDIRF4
CNSTF4 1045220557
MULF4
ASGNF4
line 1375
;1375:		}
LABELV $510
line 1377
;1376:
;1377:		VectorScale(dir, g_knockback.value * (float)knockback / mass, kvel);
ADDRLP4 68
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 72
ADDRLP4 8
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 76
ADDRLP4 52
INDIRF4
ASGNF4
ADDRLP4 40
ADDRLP4 68
INDIRP4
INDIRF4
ADDRGP4 g_knockback+8
INDIRF4
ADDRLP4 72
INDIRF4
MULF4
ADDRLP4 76
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 40+4
ADDRLP4 68
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 g_knockback+8
INDIRF4
ADDRLP4 72
INDIRF4
MULF4
ADDRLP4 76
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 40+8
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 g_knockback+8
INDIRF4
ADDRLP4 8
INDIRI4
CVIF4 4
MULF4
ADDRLP4 52
INDIRF4
DIVF4
MULF4
ASGNF4
line 1378
;1378:		VectorAdd(ps->velocity, kvel, ps->velocity);
ADDRLP4 36
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 36
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 40
INDIRF4
ADDF4
ASGNF4
ADDRLP4 36
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 36
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 40+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 36
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 36
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 40+8
INDIRF4
ADDF4
ASGNF4
line 1382
;1379:
;1380:		// set the timer so that the other client can't cancel
;1381:		// out the movement immediately
;1382:		if (!ps->pm_time) {
ADDRLP4 36
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 0
NEI4 $519
line 1385
;1383:			int		t;
;1384:
;1385:			t = knockback * 2;
ADDRLP4 92
ADDRLP4 8
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
line 1386
;1386:			if ( t < 50 ) {
ADDRLP4 92
INDIRI4
CNSTI4 50
GEI4 $521
line 1387
;1387:				t = 50;
ADDRLP4 92
CNSTI4 50
ASGNI4
line 1388
;1388:			}
LABELV $521
line 1389
;1389:			if ( t > 200 ) {
ADDRLP4 92
INDIRI4
CNSTI4 200
LEI4 $523
line 1390
;1390:				t = 200;
ADDRLP4 92
CNSTI4 200
ASGNI4
line 1391
;1391:			}
LABELV $523
line 1392
;1392:			ps->pm_time = t;
ADDRLP4 36
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 92
INDIRI4
ASGNI4
line 1393
;1393:			ps->pm_flags |= PMF_TIME_KNOCKBACK;
ADDRLP4 96
ADDRLP4 36
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 96
INDIRP4
ADDRLP4 96
INDIRP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
line 1394
;1394:		}
LABELV $519
line 1395
;1395:	}
LABELV $501
line 1399
;1396:#endif
;1397:
;1398:	// check for completely getting out of the damage
;1399:	if ( !(dflags & DAMAGE_NO_PROTECTION) ) {
ADDRFP4 24
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $525
line 1410
;1400:
;1401:		// if TF_NO_FRIENDLY_FIRE is set, don't do damage to the target
;1402:		// if the attacker was on the same team
;1403:#ifdef MISSIONPACK
;1404:		if ( mod != MOD_JUICED && targ != attacker && !(dflags & DAMAGE_NO_TEAM_PROTECTION) && OnSameTeam (targ, attacker)  ) {
;1405:#else	
;1406:		// JUHOX: ignore friendly fire setting on monsters (always do damage)
;1407:#if !MONSTER_MODE
;1408:		if ( targ != attacker && OnSameTeam (targ, attacker)  ) {
;1409:#else
;1410:		if (targ != attacker && OnSameTeam(targ, attacker) && !targ->monster) {
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CVPU4 4
ADDRLP4 40
INDIRP4
CVPU4 4
EQU4 $527
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $527
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $527
line 1413
;1411:#endif
;1412:#endif
;1413:			if ( !g_friendlyFire.integer ) {
ADDRGP4 g_friendlyFire+12
INDIRI4
CNSTI4 0
NEI4 $529
line 1414
;1414:				return;
ADDRGP4 $465
JUMPV
LABELV $529
line 1416
;1415:			}
;1416:		}
LABELV $527
line 1429
;1417:#ifdef MISSIONPACK
;1418:		if (mod == MOD_PROXIMITY_MINE) {
;1419:			if (inflictor && inflictor->parent && OnSameTeam(targ, inflictor->parent)) {
;1420:				return;
;1421:			}
;1422:			if (targ == attacker) {
;1423:				return;
;1424:			}
;1425:		}
;1426:#endif
;1427:
;1428:		// check for godmode
;1429:		if ( targ->flags & FL_GODMODE ) {
ADDRFP4 0
INDIRP4
CNSTI4 540
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $532
line 1430
;1430:			return;
ADDRGP4 $465
JUMPV
LABELV $532
line 1432
;1431:		}
;1432:	}
LABELV $525
line 1448
;1433:
;1434:	// JUHOX: ignore battlesuit protection
;1435:#if 0
;1436:	// battlesuit protects from all radius damage (but takes knockback)
;1437:	// and protects 50% against all damage
;1438:	if ( client && client->ps.powerups[PW_BATTLESUIT] ) {
;1439:		G_AddEvent( targ, EV_POWERUP_BATTLESUIT, 0 );
;1440:		if ( ( dflags & DAMAGE_RADIUS ) || ( mod == MOD_FALLING ) ) {
;1441:			return;
;1442:		}
;1443:		damage *= 0.5;
;1444:	}
;1445:#endif
;1446:
;1447:	// add to the attacker's hit counter (if the target isn't a general entity like a prox mine)
;1448:	if ( attacker->client && targ != attacker && targ->health > 0
ADDRLP4 36
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $534
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CVPU4 4
ADDRLP4 36
INDIRP4
CVPU4 4
EQU4 $534
ADDRLP4 40
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
LEI4 $534
ADDRFP4 28
INDIRI4
CNSTI4 7
EQI4 $534
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
EQI4 $534
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $534
line 1451
;1449:			&& mod != MOD_CHARGE	// JUHOX: don't count charge hits (it's only indirect damage)
;1450:			&& targ->s.eType != ET_MISSILE
;1451:			&& targ->s.eType != ET_GENERAL) {
line 1452
;1452:		if ( OnSameTeam( targ, attacker ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $536
line 1453
;1453:			attacker->client->ps.persistant[PERS_HITS]--;
ADDRLP4 48
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 252
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1454
;1454:		} else {
ADDRGP4 $537
JUMPV
LABELV $536
line 1455
;1455:			attacker->client->ps.persistant[PERS_HITS]++;
ADDRLP4 48
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 252
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1456
;1456:		}
LABELV $537
line 1457
;1457:		attacker->client->ps.persistant[PERS_ATTACKEE_ARMOR] = (targ->health<<8)|(client->ps.stats[STAT_ARMOR]);
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 276
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 8
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
BORI4
ASGNI4
line 1458
;1458:	}
LABELV $534
line 1468
;1459:
;1460:	// always give half damage if hurting self
;1461:	// calculated after knockback, so rocket jumping works
;1462:	// JUHOX: do not reduce damage if hurting self with the BFG
;1463:#if 0
;1464:	if ( targ == attacker) {
;1465:		damage *= 0.5;
;1466:	}
;1467:#else
;1468:	if (targ == attacker && mod != MOD_BFG && mod != MOD_BFG_SPLASH) {
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRFP4 8
INDIRP4
CVPU4 4
NEU4 $538
ADDRLP4 44
ADDRFP4 28
INDIRI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 17
EQI4 $538
ADDRLP4 44
INDIRI4
CNSTI4 18
EQI4 $538
line 1469
;1469:		damage *= 0.5;
ADDRFP4 20
ADDRFP4 20
INDIRI4
CVIF4 4
CNSTF4 1056964608
MULF4
CVFI4 4
ASGNI4
line 1470
;1470:	}
LABELV $538
line 1473
;1471:#endif
;1472:
;1473:	if ( damage < 1 ) {
ADDRFP4 20
INDIRI4
CNSTI4 1
GEI4 $540
line 1474
;1474:		damage = 1;
ADDRFP4 20
CNSTI4 1
ASGNI4
line 1475
;1475:	}
LABELV $540
line 1476
;1476:	take = damage;
ADDRLP4 4
ADDRFP4 20
INDIRI4
ASGNI4
line 1477
;1477:	save = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 1480
;1478:
;1479:	// save some from armor
;1480:	asave = CheckArmor (targ, take, dflags);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRFP4 24
INDIRI4
ARGI4
ADDRLP4 48
ADDRGP4 CheckArmor
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 48
INDIRI4
ASGNI4
line 1481
;1481:	TossArmorFragments(targ, asave);	// JUHOX
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 TossArmorFragments
CALLV
pop
line 1482
;1482:	take -= asave;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 12
INDIRI4
SUBI4
ASGNI4
line 1484
;1483:
;1484:	if ( g_debugDamage.integer ) {
ADDRGP4 g_debugDamage+12
INDIRI4
CNSTI4 0
EQI4 $542
line 1485
;1485:		G_Printf( "%i: client:%i health:%i damage:%i armor:%i\n", level.time, targ->s.number,
ADDRGP4 $545
ARGP4
ADDRGP4 level+32
INDIRI4
ARGI4
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
INDIRI4
ARGI4
ADDRLP4 52
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 1487
;1486:			targ->health, take, asave );
;1487:	}
LABELV $542
line 1490
;1488:
;1489:#if MONSTER_MODE
;1490:	G_CheckMonsterDamage(attacker, targ, mod);	// JUHOX
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 28
INDIRI4
ARGI4
ADDRGP4 G_CheckMonsterDamage
CALLV
pop
line 1496
;1491:#endif
;1492:
;1493:	// add to the damage inflicted on a player this frame
;1494:	// the total will be turned into screen blends and view angle kicks
;1495:	// at the end of the frame
;1496:	if ( client ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $547
line 1497
;1497:		if ( attacker ) {
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $549
line 1498
;1498:			client->ps.persistant[PERS_ATTACKER] = attacker->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 272
ADDP4
ADDRFP4 8
INDIRP4
INDIRI4
ASGNI4
line 1499
;1499:		} else {
ADDRGP4 $550
JUMPV
LABELV $549
line 1500
;1500:			client->ps.persistant[PERS_ATTACKER] = ENTITYNUM_WORLD;
ADDRLP4 0
INDIRP4
CNSTI4 272
ADDP4
CNSTI4 1022
ASGNI4
line 1501
;1501:		}
LABELV $550
line 1502
;1502:		client->damage_armor += asave;
ADDRLP4 52
ADDRLP4 0
INDIRP4
CNSTI4 776
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
ADDI4
ASGNI4
line 1503
;1503:		client->damage_blood += take;
ADDRLP4 56
ADDRLP4 0
INDIRP4
CNSTI4 780
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 1504
;1504:		client->damage_knockback += knockback;
ADDRLP4 60
ADDRLP4 0
INDIRP4
CNSTI4 784
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRI4
ADDRLP4 8
INDIRI4
ADDI4
ASGNI4
line 1505
;1505:		if ( dir ) {
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $551
line 1506
;1506:			VectorCopy ( dir, client->damage_from );
ADDRLP4 0
INDIRP4
CNSTI4 788
ADDP4
ADDRFP4 12
INDIRP4
INDIRB
ASGNB 12
line 1507
;1507:			client->damage_fromWorld = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 800
ADDP4
CNSTI4 0
ASGNI4
line 1508
;1508:		} else {
ADDRGP4 $552
JUMPV
LABELV $551
line 1509
;1509:			VectorCopy ( targ->r.currentOrigin, client->damage_from );
ADDRLP4 0
INDIRP4
CNSTI4 788
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 1510
;1510:			client->damage_fromWorld = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 800
ADDP4
CNSTI4 1
ASGNI4
line 1511
;1511:		}
LABELV $552
line 1512
;1512:	}
LABELV $547
line 1518
;1513:
;1514:	// See if it's the player hurting the emeny flag carrier
;1515:#ifdef MISSIONPACK
;1516:	if( g_gametype.integer == GT_CTF || g_gametype.integer == GT_1FCTF ) {
;1517:#else	
;1518:	if( g_gametype.integer == GT_CTF) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $553
line 1520
;1519:#endif
;1520:		Team_CheckHurtCarrier(targ, attacker);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Team_CheckHurtCarrier
CALLV
pop
line 1521
;1521:	}
LABELV $553
line 1528
;1522:
;1523:	// JUHOX: don't let the fast charge damage overwrite any other attack
;1524:#if 0
;1525:	if (targ->client) {
;1526:#else
;1527:	if (
;1528:		targ->client &&
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $556
ADDRLP4 52
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $559
ADDRLP4 52
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $556
LABELV $559
ADDRFP4 28
INDIRI4
CNSTI4 7
NEI4 $561
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 828
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
SUBI4
LTI4 $561
ADDRLP4 56
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
GTI4 $556
LABELV $561
line 1539
;1529:#if !MONSTER_MODE
;1530:		attacker->client &&
;1531:#else
;1532:		(attacker->client || attacker->monster) &&
;1533:#endif
;1534:		(
;1535:			mod != MOD_CHARGE ||
;1536:			targ->client->lasthurt_time < level.time - 1000 ||
;1537:			targ->health <= take
;1538:		)
;1539:	) {
line 1542
;1540:#endif
;1541:		// set the last client who damaged the target
;1542:		targ->client->lasthurt_client = attacker->s.number;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 820
ADDP4
ADDRFP4 8
INDIRP4
INDIRI4
ASGNI4
line 1543
;1543:		targ->client->lasthurt_mod = mod;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 824
ADDP4
ADDRFP4 28
INDIRI4
ASGNI4
line 1544
;1544:		targ->client->lasthurt_time = level.time;	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 828
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1545
;1545:	}
LABELV $556
line 1548
;1546:
;1547:	// do the damage
;1548:	if (take) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $563
line 1550
;1549:#if MONSTER_MODE
;1550:		if (!G_CanBeDamaged(targ) && !(dflags & DAMAGE_NO_PROTECTION)) take = 0;	// JUHOX
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 G_CanBeDamaged
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
NEI4 $565
ADDRFP4 24
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $565
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $565
line 1552
;1551:#endif
;1552:		targ->health = targ->health - take;
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 736
ADDP4
ADDRLP4 64
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
ASGNI4
line 1559
;1553:		// JUHOX: update monster playerState_t too
;1554:#if !MONSTER_MODE
;1555:		if ( targ->client ) {
;1556:			targ->client->ps.stats[STAT_HEALTH] = targ->health;
;1557:		}
;1558:#else
;1559:		{
line 1562
;1560:			playerState_t* ps;
;1561:
;1562:			ps = G_GetEntityPlayerState(targ);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 72
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 68
ADDRLP4 72
INDIRP4
ASGNP4
line 1563
;1563:			if (ps) ps->stats[STAT_HEALTH] = targ->health;
ADDRLP4 68
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $567
ADDRLP4 68
INDIRP4
CNSTI4 184
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
ASGNI4
LABELV $567
line 1564
;1564:		}
line 1567
;1565:#endif
;1566:			
;1567:		if ( targ->health <= 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
GTI4 $569
line 1568
;1568:			if ( client )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $571
line 1569
;1569:				targ->flags |= FL_NO_KNOCKBACK;
ADDRLP4 68
ADDRFP4 0
INDIRP4
CNSTI4 540
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
LABELV $571
line 1571
;1570:
;1571:			if (targ->health < -999)
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 -999
GEI4 $573
line 1572
;1572:				targ->health = -999;
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 -999
ASGNI4
LABELV $573
line 1574
;1573:
;1574:			targ->enemy = attacker;
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
ADDRFP4 8
INDIRP4
ASGNP4
line 1575
;1575:			targ->die (targ, inflictor, attacker, take, mod);
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRFP4 28
INDIRI4
ARGI4
ADDRLP4 72
INDIRP4
CNSTI4 720
ADDP4
INDIRP4
CALLV
pop
line 1576
;1576:			return;
ADDRGP4 $465
JUMPV
LABELV $569
line 1577
;1577:		} else if ( targ->pain ) {
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $575
line 1578
;1578:			targ->pain (targ, attacker, take);
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 68
INDIRP4
CNSTI4 716
ADDP4
INDIRP4
CALLV
pop
line 1579
;1579:		}
LABELV $575
line 1580
;1580:	}
LABELV $563
line 1583
;1581:
;1582:#if 1	// JUHOX: if the target is invisible mark it by a battlesuit flash
;1583:	if (client && client->ps.powerups[PW_INVIS] && mod != MOD_WATER) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $577
ADDRLP4 0
INDIRP4
CNSTI4 328
ADDP4
INDIRI4
CNSTI4 0
EQI4 $577
ADDRFP4 28
INDIRI4
CNSTI4 19
EQI4 $577
line 1584
;1584:		client->ps.powerups[PW_BATTLESUIT] = level.time + 500;
ADDRLP4 0
INDIRP4
CNSTI4 320
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 1585
;1585:	}
LABELV $577
line 1587
;1586:#endif
;1587:}
LABELV $465
endproc G_Damage 100 24
export DropHealth
proc DropHealth 40 16
line 1595
;1588:
;1589:
;1590:/*
;1591:===============
;1592:JUHOX: DropHealth
;1593:===============
;1594:*/
;1595:void DropHealth(gentity_t* ent) {
line 1598
;1596:	vec3_t pos, vel;
;1597:
;1598:	if (!ent->client) return;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $581
ADDRGP4 $580
JUMPV
LABELV $581
line 1599
;1599:	if (ent->health <= 5) return;
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 5
GTI4 $583
ADDRGP4 $580
JUMPV
LABELV $583
line 1602
;1600:	
;1601:	// the following is originally from CalcMuzzlePoint()
;1602:	AngleVectors(ent->s.apos.trBase, vel, NULL, NULL);
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
ARGP4
ADDRLP4 12
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 1603
;1603:	VectorCopy(ent->s.pos.trBase, pos);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 1604
;1604:	pos[2] += ent->client->ps.viewheight;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1605
;1605:	VectorMA(pos, 35, vel, pos);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 12
INDIRF4
CNSTF4 1108082688
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 12+4
INDIRF4
CNSTF4 1108082688
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 12+8
INDIRF4
CNSTF4 1108082688
MULF4
ADDF4
ASGNF4
line 1607
;1606:	// snap to integer coordinates for more efficient network bandwidth usage
;1607:	SnapVector(pos);
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
line 1609
;1608:
;1609:	VectorScale(vel, 200, vel);
ADDRLP4 12
ADDRLP4 12
INDIRF4
CNSTF4 1128792064
MULF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
CNSTF4 1128792064
MULF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
CNSTF4 1128792064
MULF4
ASGNF4
line 1610
;1610:	if (LaunchItem(BG_FindItem("5 Health"), pos, vel)) {
ADDRGP4 $602
ARGP4
ADDRLP4 24
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 28
ADDRGP4 LaunchItem
CALLP4
ASGNP4
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $600
line 1611
;1611:		ent->health -= 5;
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 5
SUBI4
ASGNI4
line 1612
;1612:		ent->client->ps.stats[STAT_HEALTH] = ent->health;
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 36
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
ASGNI4
line 1613
;1613:	}
LABELV $600
line 1614
;1614:}
LABELV $580
endproc DropHealth 40 16
export DropArmor
proc DropArmor 36 16
line 1622
;1615:
;1616:
;1617:/*
;1618:===============
;1619:JUHOX: DropArmor
;1620:===============
;1621:*/
;1622:void DropArmor(gentity_t* ent) {
line 1625
;1623:	vec3_t pos, vel;
;1624:
;1625:	if (!ent->client) return;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $604
ADDRGP4 $603
JUMPV
LABELV $604
line 1626
;1626:	if (ent->client->ps.stats[STAT_ARMOR] < 5) return;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 5
GEI4 $606
ADDRGP4 $603
JUMPV
LABELV $606
line 1629
;1627:	
;1628:	// the following is originally from CalcMuzzlePoint()
;1629:	AngleVectors(ent->s.apos.trBase, vel, NULL, NULL);
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
ARGP4
ADDRLP4 12
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 1630
;1630:	VectorCopy(ent->s.pos.trBase, pos);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 1631
;1631:	pos[2] += ent->client->ps.viewheight;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1632
;1632:	VectorMA(pos, 35, vel, pos);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 12
INDIRF4
CNSTF4 1108082688
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 12+4
INDIRF4
CNSTF4 1108082688
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 12+8
INDIRF4
CNSTF4 1108082688
MULF4
ADDF4
ASGNF4
line 1634
;1633:	// snap to integer coordinates for more efficient network bandwidth usage
;1634:	SnapVector(pos);
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
line 1636
;1635:
;1636:	VectorScale(vel, 200, vel);
ADDRLP4 12
ADDRLP4 12
INDIRF4
CNSTF4 1128792064
MULF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
CNSTF4 1128792064
MULF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
CNSTF4 1128792064
MULF4
ASGNF4
line 1637
;1637:	if (LaunchItem(BG_FindItem("Armor Shard"), pos, vel)) {
ADDRGP4 $625
ARGP4
ADDRLP4 24
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 28
ADDRGP4 LaunchItem
CALLP4
ASGNP4
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $623
line 1638
;1638:		ent->client->ps.stats[STAT_ARMOR] -= 5;
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 196
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 5
SUBI4
ASGNI4
line 1639
;1639:	}
LABELV $623
line 1640
;1640:}
LABELV $603
endproc DropArmor 36 16
export CanDamage
proc CanDamage 108 28
line 1651
;1641:
;1642:
;1643:/*
;1644:============
;1645:CanDamage
;1646:
;1647:Returns qtrue if the inflictor can directly damage the target.  Used for
;1648:explosions and melee attacks.
;1649:============
;1650:*/
;1651:qboolean CanDamage (gentity_t *targ, vec3_t origin) {
line 1658
;1652:	vec3_t	dest;
;1653:	trace_t	tr;
;1654:	vec3_t	midpoint;
;1655:
;1656:	// use the midpoint of the bounds instead of the origin, because
;1657:	// bmodels may have their origin is 0,0,0
;1658:	VectorAdd (targ->r.absmin, targ->r.absmax, midpoint);
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 80
INDIRP4
CNSTI4 464
ADDP4
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 476
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 80
INDIRP4
CNSTI4 468
ADDP4
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 480
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12+8
ADDRLP4 84
INDIRP4
CNSTI4 472
ADDP4
INDIRF4
ADDRLP4 84
INDIRP4
CNSTI4 484
ADDP4
INDIRF4
ADDF4
ASGNF4
line 1659
;1659:	VectorScale (midpoint, 0.5, midpoint);
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
line 1661
;1660:
;1661:	VectorCopy (midpoint, dest);
ADDRLP4 0
ADDRLP4 12
INDIRB
ASGNB 12
line 1662
;1662:	trap_Trace ( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID);
ADDRLP4 24
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 88
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1663
;1663:	if (tr.fraction == 1.0 || tr.entityNum == targ->s.number)
ADDRLP4 24+8
INDIRF4
CNSTF4 1065353216
EQF4 $637
ADDRLP4 24+52
INDIRI4
ADDRFP4 0
INDIRP4
INDIRI4
NEI4 $633
LABELV $637
line 1664
;1664:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $626
JUMPV
LABELV $633
line 1668
;1665:
;1666:	// this should probably check in the plane of projection, 
;1667:	// rather than in world coordinate, and also include Z
;1668:	VectorCopy (midpoint, dest);
ADDRLP4 0
ADDRLP4 12
INDIRB
ASGNB 12
line 1669
;1669:	dest[0] += 15.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1097859072
ADDF4
ASGNF4
line 1670
;1670:	dest[1] += 15.0;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
CNSTF4 1097859072
ADDF4
ASGNF4
line 1671
;1671:	trap_Trace ( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID);
ADDRLP4 24
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 92
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 92
INDIRP4
ARGP4
ADDRLP4 92
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1672
;1672:	if (tr.fraction == 1.0)
ADDRLP4 24+8
INDIRF4
CNSTF4 1065353216
NEF4 $639
line 1673
;1673:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $626
JUMPV
LABELV $639
line 1675
;1674:
;1675:	VectorCopy (midpoint, dest);
ADDRLP4 0
ADDRLP4 12
INDIRB
ASGNB 12
line 1676
;1676:	dest[0] += 15.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1097859072
ADDF4
ASGNF4
line 1677
;1677:	dest[1] -= 15.0;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
CNSTF4 1097859072
SUBF4
ASGNF4
line 1678
;1678:	trap_Trace ( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID);
ADDRLP4 24
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 96
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 96
INDIRP4
ARGP4
ADDRLP4 96
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1679
;1679:	if (tr.fraction == 1.0)
ADDRLP4 24+8
INDIRF4
CNSTF4 1065353216
NEF4 $643
line 1680
;1680:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $626
JUMPV
LABELV $643
line 1682
;1681:
;1682:	VectorCopy (midpoint, dest);
ADDRLP4 0
ADDRLP4 12
INDIRB
ASGNB 12
line 1683
;1683:	dest[0] -= 15.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1097859072
SUBF4
ASGNF4
line 1684
;1684:	dest[1] += 15.0;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
CNSTF4 1097859072
ADDF4
ASGNF4
line 1685
;1685:	trap_Trace ( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID);
ADDRLP4 24
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 100
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1686
;1686:	if (tr.fraction == 1.0)
ADDRLP4 24+8
INDIRF4
CNSTF4 1065353216
NEF4 $647
line 1687
;1687:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $626
JUMPV
LABELV $647
line 1689
;1688:
;1689:	VectorCopy (midpoint, dest);
ADDRLP4 0
ADDRLP4 12
INDIRB
ASGNB 12
line 1690
;1690:	dest[0] -= 15.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1097859072
SUBF4
ASGNF4
line 1691
;1691:	dest[1] -= 15.0;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
CNSTF4 1097859072
SUBF4
ASGNF4
line 1692
;1692:	trap_Trace ( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID);
ADDRLP4 24
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 104
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 104
INDIRP4
ARGP4
ADDRLP4 104
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1693
;1693:	if (tr.fraction == 1.0)
ADDRLP4 24+8
INDIRF4
CNSTF4 1065353216
NEF4 $651
line 1694
;1694:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $626
JUMPV
LABELV $651
line 1697
;1695:
;1696:
;1697:	return qfalse;
CNSTI4 0
RETI4
LABELV $626
endproc CanDamage 108 28
export G_RadiusDamage
proc G_RadiusDamage 4196 32
line 1707
;1698:}
;1699:
;1700:
;1701:/*
;1702:============
;1703:G_RadiusDamage
;1704:============
;1705:*/
;1706:qboolean G_RadiusDamage ( vec3_t origin, gentity_t *attacker, float damage, float radius,
;1707:					 gentity_t *ignore, int mod) {
line 1716
;1708:	float		points, dist;
;1709:	gentity_t	*ent;
;1710:	int			entityList[MAX_GENTITIES];
;1711:	int			numListedEntities;
;1712:	vec3_t		mins, maxs;
;1713:	vec3_t		v;
;1714:	vec3_t		dir;
;1715:	int			i, e;
;1716:	qboolean	hitClient = qfalse;
ADDRLP4 4168
CNSTI4 0
ASGNI4
line 1718
;1717:
;1718:	if ( radius < 1 ) {
ADDRFP4 12
INDIRF4
CNSTF4 1065353216
GEF4 $655
line 1719
;1719:		radius = 1;
ADDRFP4 12
CNSTF4 1065353216
ASGNF4
line 1720
;1720:	}
LABELV $655
line 1722
;1721:
;1722:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $657
line 1723
;1723:		mins[i] = origin[i] - radius;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4144
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRFP4 12
INDIRF4
SUBF4
ASGNF4
line 1724
;1724:		maxs[i] = origin[i] + radius;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4156
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRFP4 12
INDIRF4
ADDF4
ASGNF4
line 1725
;1725:	}
LABELV $658
line 1722
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $657
line 1727
;1726:
;1727:	numListedEntities = trap_EntitiesInBox( mins, maxs, entityList, MAX_GENTITIES );
ADDRLP4 4144
ARGP4
ADDRLP4 4156
ARGP4
ADDRLP4 44
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 4172
ADDRGP4 trap_EntitiesInBox
CALLI4
ASGNI4
ADDRLP4 4140
ADDRLP4 4172
INDIRI4
ASGNI4
line 1729
;1728:
;1729:	for ( e = 0 ; e < numListedEntities ; e++ ) {
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRGP4 $664
JUMPV
LABELV $661
line 1730
;1730:		ent = &g_entities[entityList[ e ]];
ADDRLP4 4
ADDRLP4 20
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 44
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1732
;1731:
;1732:		if (ent == ignore)
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRFP4 16
INDIRP4
CVPU4 4
NEU4 $665
line 1733
;1733:			continue;
ADDRGP4 $662
JUMPV
LABELV $665
line 1734
;1734:		if (!ent->takedamage)
ADDRLP4 4
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
CNSTI4 0
NEI4 $667
line 1735
;1735:			continue;
ADDRGP4 $662
JUMPV
LABELV $667
line 1738
;1736:
;1737:		// find the distance from the edge of the bounding box
;1738:		for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $669
line 1739
;1739:			if ( origin[i] < ent->r.absmin[i] ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 464
ADDP4
ADDP4
INDIRF4
GEF4 $673
line 1740
;1740:				v[i] = ent->r.absmin[i] - origin[i];
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
CNSTI4 464
ADDP4
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
SUBF4
ASGNF4
line 1741
;1741:			} else if ( origin[i] > ent->r.absmax[i] ) {
ADDRGP4 $674
JUMPV
LABELV $673
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 476
ADDP4
ADDP4
INDIRF4
LEF4 $675
line 1742
;1742:				v[i] = origin[i] - ent->r.absmax[i];
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
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 476
ADDP4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1743
;1743:			} else {
ADDRGP4 $676
JUMPV
LABELV $675
line 1744
;1744:				v[i] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
CNSTF4 0
ASGNF4
line 1745
;1745:			}
LABELV $676
LABELV $674
line 1746
;1746:		}
LABELV $670
line 1738
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $669
line 1748
;1747:
;1748:		dist = VectorLength( v );
ADDRLP4 8
ARGP4
ADDRLP4 4176
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 24
ADDRLP4 4176
INDIRF4
ASGNF4
line 1749
;1749:		if ( dist >= radius ) {
ADDRLP4 24
INDIRF4
ADDRFP4 12
INDIRF4
LTF4 $677
line 1750
;1750:			continue;
ADDRGP4 $662
JUMPV
LABELV $677
line 1753
;1751:		}
;1752:
;1753:		points = damage * ( 1.0 - dist / radius );
ADDRLP4 40
ADDRFP4 8
INDIRF4
CNSTF4 1065353216
ADDRLP4 24
INDIRF4
ADDRFP4 12
INDIRF4
DIVF4
SUBF4
MULF4
ASGNF4
line 1755
;1754:
;1755:		if( CanDamage (ent, origin) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4180
ADDRGP4 CanDamage
CALLI4
ASGNI4
ADDRLP4 4180
INDIRI4
CNSTI4 0
EQI4 $679
line 1756
;1756:			if( LogAccuracyHit( ent, attacker ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4184
ADDRGP4 LogAccuracyHit
CALLI4
ASGNI4
ADDRLP4 4184
INDIRI4
CNSTI4 0
EQI4 $681
line 1757
;1757:				hitClient = qtrue;
ADDRLP4 4168
CNSTI4 1
ASGNI4
line 1758
;1758:			}
LABELV $681
line 1759
;1759:			VectorSubtract (ent->r.currentOrigin, origin, dir);
ADDRLP4 4192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 4
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 4192
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 28+4
ADDRLP4 4
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 4192
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 28+8
ADDRLP4 4
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1762
;1760:			// push the center of mass higher than the origin so players
;1761:			// get knocked into the air more
;1762:			dir[2] += 24;
ADDRLP4 28+8
ADDRLP4 28+8
INDIRF4
CNSTF4 1103101952
ADDF4
ASGNF4
line 1763
;1763:			G_Damage (ent, NULL, attacker, dir, origin, (int)points, DAMAGE_RADIUS, mod);
ADDRLP4 4
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 28
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 40
INDIRF4
CVFI4 4
ARGI4
CNSTI4 1
ARGI4
ADDRFP4 20
INDIRI4
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 1764
;1764:		}
LABELV $679
line 1765
;1765:	}
LABELV $662
line 1729
ADDRLP4 20
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $664
ADDRLP4 20
INDIRI4
ADDRLP4 4140
INDIRI4
LTI4 $661
line 1767
;1766:
;1767:	return hitClient;
ADDRLP4 4168
INDIRI4
RETI4
LABELV $654
endproc G_RadiusDamage 4196 32
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
import fire_monster_seed
import fire_grapple
import fire_bfg
import fire_rocket
import fire_grenade
import fire_plasma
import fire_blaster
import G_RunMissile
import TossClientCubes
import G_InvulnerabilityEffect
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
LABELV $625
byte 1 65
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 32
byte 1 83
byte 1 104
byte 1 97
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $602
byte 1 53
byte 1 32
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $545
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 58
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $387
byte 1 79
byte 1 118
byte 1 101
byte 1 114
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $352
byte 1 80
byte 1 79
byte 1 68
byte 1 32
byte 1 109
byte 1 97
byte 1 114
byte 1 107
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $349
byte 1 75
byte 1 105
byte 1 108
byte 1 108
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $348
byte 1 60
byte 1 98
byte 1 97
byte 1 100
byte 1 32
byte 1 111
byte 1 98
byte 1 105
byte 1 116
byte 1 117
byte 1 97
byte 1 114
byte 1 121
byte 1 62
byte 1 0
align 1
LABELV $341
byte 1 60
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 62
byte 1 0
align 1
LABELV $340
byte 1 60
byte 1 110
byte 1 111
byte 1 110
byte 1 45
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 62
byte 1 0
align 1
LABELV $299
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
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $298
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
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $287
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 71
byte 1 82
byte 1 65
byte 1 80
byte 1 80
byte 1 76
byte 1 69
byte 1 0
align 1
LABELV $286
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 84
byte 1 82
byte 1 73
byte 1 71
byte 1 71
byte 1 69
byte 1 82
byte 1 95
byte 1 72
byte 1 85
byte 1 82
byte 1 84
byte 1 0
align 1
LABELV $285
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 84
byte 1 65
byte 1 82
byte 1 71
byte 1 69
byte 1 84
byte 1 95
byte 1 76
byte 1 65
byte 1 83
byte 1 69
byte 1 82
byte 1 0
align 1
LABELV $284
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 83
byte 1 85
byte 1 73
byte 1 67
byte 1 73
byte 1 68
byte 1 69
byte 1 0
align 1
LABELV $283
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 70
byte 1 65
byte 1 76
byte 1 76
byte 1 73
byte 1 78
byte 1 71
byte 1 0
align 1
LABELV $282
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 84
byte 1 69
byte 1 76
byte 1 69
byte 1 70
byte 1 82
byte 1 65
byte 1 71
byte 1 0
align 1
LABELV $281
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 67
byte 1 82
byte 1 85
byte 1 83
byte 1 72
byte 1 0
align 1
LABELV $280
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 76
byte 1 65
byte 1 86
byte 1 65
byte 1 0
align 1
LABELV $279
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 83
byte 1 76
byte 1 73
byte 1 77
byte 1 69
byte 1 0
align 1
LABELV $278
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 87
byte 1 65
byte 1 84
byte 1 69
byte 1 82
byte 1 0
align 1
LABELV $277
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 66
byte 1 70
byte 1 71
byte 1 95
byte 1 83
byte 1 80
byte 1 76
byte 1 65
byte 1 83
byte 1 72
byte 1 0
align 1
LABELV $276
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 66
byte 1 70
byte 1 71
byte 1 0
align 1
LABELV $275
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 76
byte 1 73
byte 1 71
byte 1 72
byte 1 84
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 0
align 1
LABELV $274
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 82
byte 1 65
byte 1 73
byte 1 76
byte 1 71
byte 1 85
byte 1 78
byte 1 0
align 1
LABELV $273
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 80
byte 1 76
byte 1 65
byte 1 83
byte 1 77
byte 1 65
byte 1 95
byte 1 83
byte 1 80
byte 1 76
byte 1 65
byte 1 83
byte 1 72
byte 1 0
align 1
LABELV $272
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 80
byte 1 76
byte 1 65
byte 1 83
byte 1 77
byte 1 65
byte 1 0
align 1
LABELV $271
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 82
byte 1 79
byte 1 67
byte 1 75
byte 1 69
byte 1 84
byte 1 95
byte 1 83
byte 1 80
byte 1 76
byte 1 65
byte 1 83
byte 1 72
byte 1 0
align 1
LABELV $270
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 82
byte 1 79
byte 1 67
byte 1 75
byte 1 69
byte 1 84
byte 1 0
align 1
LABELV $269
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 71
byte 1 82
byte 1 69
byte 1 78
byte 1 65
byte 1 68
byte 1 69
byte 1 95
byte 1 83
byte 1 80
byte 1 76
byte 1 65
byte 1 83
byte 1 72
byte 1 0
align 1
LABELV $268
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 71
byte 1 82
byte 1 69
byte 1 78
byte 1 65
byte 1 68
byte 1 69
byte 1 0
align 1
LABELV $267
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 77
byte 1 65
byte 1 67
byte 1 72
byte 1 73
byte 1 78
byte 1 69
byte 1 71
byte 1 85
byte 1 78
byte 1 0
align 1
LABELV $266
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 67
byte 1 72
byte 1 65
byte 1 82
byte 1 71
byte 1 69
byte 1 0
align 1
LABELV $265
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 77
byte 1 79
byte 1 78
byte 1 83
byte 1 84
byte 1 69
byte 1 82
byte 1 95
byte 1 76
byte 1 65
byte 1 85
byte 1 78
byte 1 67
byte 1 72
byte 1 69
byte 1 82
byte 1 0
align 1
LABELV $264
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 84
byte 1 73
byte 1 84
byte 1 65
byte 1 78
byte 1 0
align 1
LABELV $263
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 71
byte 1 85
byte 1 65
byte 1 82
byte 1 68
byte 1 0
align 1
LABELV $262
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 67
byte 1 76
byte 1 65
byte 1 87
byte 1 0
align 1
LABELV $261
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 71
byte 1 65
byte 1 85
byte 1 78
byte 1 84
byte 1 76
byte 1 69
byte 1 84
byte 1 0
align 1
LABELV $260
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 83
byte 1 72
byte 1 79
byte 1 84
byte 1 71
byte 1 85
byte 1 78
byte 1 0
align 1
LABELV $259
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 85
byte 1 78
byte 1 75
byte 1 78
byte 1 79
byte 1 87
byte 1 78
byte 1 0
align 1
LABELV $189
byte 1 107
byte 1 97
byte 1 109
byte 1 105
byte 1 107
byte 1 97
byte 1 122
byte 1 101
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $136
byte 1 65
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 32
byte 1 70
byte 1 114
byte 1 97
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 53
byte 1 0
