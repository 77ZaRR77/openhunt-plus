export SP_info_camp
code
proc SP_info_camp 4 8
file "..\..\..\..\code\game\g_misc.c"
line 16
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// g_misc.c
;4:
;5:#include "g_local.h"
;6:
;7:
;8:/*QUAKED func_group (0 0 0) ?
;9:Used to group brushes together just for editor convenience.  They are turned into normal brushes by the utilities.
;10:*/
;11:
;12:
;13:/*QUAKED info_camp (0 0.5 0) (-4 -4 -4) (4 4 4)
;14:Used as a positional target for calculations in the utilities (spotlights, etc), but removed during gameplay.
;15:*/
;16:void SP_info_camp( gentity_t *self ) {
line 18
;17:#if ESCAPE_MODE	// JUHOX: info_camp not used in EFH
;18:	if (g_gametype.integer == GT_EFH) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
NEI4 $88
line 19
;19:		G_FreeEntity(self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 20
;20:		return;
ADDRGP4 $87
JUMPV
LABELV $88
line 23
;21:	}
;22:#endif
;23:	G_SetOrigin( self, self->s.origin );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 24
;24:}
LABELV $87
endproc SP_info_camp 4 8
export SP_info_null
proc SP_info_null 0 4
line 30
;25:
;26:
;27:/*QUAKED info_null (0 0.5 0) (-4 -4 -4) (4 4 4)
;28:Used as a positional target for calculations in the utilities (spotlights, etc), but removed during gameplay.
;29:*/
;30:void SP_info_null( gentity_t *self ) {
line 31
;31:	G_FreeEntity( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 32
;32:}
LABELV $91
endproc SP_info_null 0 4
export SP_info_notnull
proc SP_info_notnull 4 8
line 39
;33:
;34:
;35:/*QUAKED info_notnull (0 0.5 0) (-4 -4 -4) (4 4 4)
;36:Used as a positional target for in-game calculation, like jumppad targets.
;37:target_position does the same thing
;38:*/
;39:void SP_info_notnull( gentity_t *self ){
line 40
;40:	G_SetOrigin( self, self->s.origin );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 42
;41:#if ESCAPE_MODE	// JUHOX: set entity class
;42:	self->entClass = GEC_info_notnull;
ADDRFP4 0
INDIRP4
CNSTI4 824
ADDP4
CNSTI4 32
ASGNI4
line 44
;43:#endif
;44:}
LABELV $92
endproc SP_info_notnull 4 8
export SP_light
proc SP_light 0 4
line 54
;45:
;46:
;47:/*QUAKED light (0 1 0) (-8 -8 -8) (8 8 8) linear
;48:Non-displayed light.
;49:"light" overrides the default 300 intensity.
;50:Linear checbox gives linear falloff instead of inverse square
;51:Lights pointed at a target will be spotlights.
;52:"radius" overrides the default 64 unit radius of a spotlight at the target point.
;53:*/
;54:void SP_light( gentity_t *self ) {
line 55
;55:	G_FreeEntity( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 56
;56:}
LABELV $93
endproc SP_light 0 4
export TeleportPlayer
proc TeleportPlayer 40 16
line 68
;57:
;58:
;59:
;60:/*
;61:=================================================================================
;62:
;63:TELEPORTERS
;64:
;65:=================================================================================
;66:*/
;67:
;68:void TeleportPlayer( gentity_t *player, vec3_t origin, vec3_t angles ) {
line 153
;69:	// JUHOX: let TeleportPlayer() accept monsters
;70:#if !MONSTER_MODE
;71:	gentity_t	*tent;
;72:	qboolean noAngles;	// JUHOX
;73:
;74:	noAngles = (angles[0] > 999999.0);	// JUHOX: to support the new version of Touch_DoorTriggerSpectator()
;75:	// use temp events at source and destination to prevent the effect
;76:	// from getting dropped by a second player event
;77:// JUHOX: don't play the teleport effect for dead spectators too
;78:#if 0
;79:	if ( player->client->sess.sessionTeam != TEAM_SPECTATOR ) {
;80:#else
;81:	if (player->client->ps.pm_type != PM_SPECTATOR) {
;82:#endif
;83:		tent = G_TempEntity( player->client->ps.origin, EV_PLAYER_TELEPORT_OUT );
;84:		tent->s.clientNum = player->s.clientNum;
;85:
;86:		tent = G_TempEntity( origin, EV_PLAYER_TELEPORT_IN );
;87:		tent->s.clientNum = player->s.clientNum;
;88:	}
;89:
;90:	// unlink to make sure it can't possibly interfere with G_KillBox
;91:	trap_UnlinkEntity (player);
;92:
;93:	VectorCopy ( origin, player->client->ps.origin );
;94:	player->client->ps.origin[2] += 1;
;95:
;96:	// JUHOX: don't change view angles nor velocity if no angles given
;97:#if 0
;98:	// spit the player out
;99:	AngleVectors( angles, player->client->ps.velocity, NULL, NULL );
;100:	VectorScale( player->client->ps.velocity, 400, player->client->ps.velocity );
;101:	player->client->ps.pm_time = 160;		// hold time
;102:	player->client->ps.pm_flags |= PMF_TIME_KNOCKBACK;
;103:
;104:	// toggle the teleport bit so the client knows to not lerp
;105:	player->client->ps.eFlags ^= EF_TELEPORT_BIT;
;106:
;107:	// set angles
;108:	SetClientViewAngle( player, angles );
;109:#else
;110:	if (!noAngles) {
;111:		// spit the player out
;112:		AngleVectors( angles, player->client->ps.velocity, NULL, NULL );
;113:		VectorScale( player->client->ps.velocity, 400, player->client->ps.velocity );
;114:		player->client->ps.pm_time = 160;		// hold time
;115:		player->client->ps.pm_flags |= PMF_TIME_KNOCKBACK;
;116:	
;117:		// set angles
;118:		SetClientViewAngle( player, angles );
;119:	}
;120:	// toggle the teleport bit so the client knows to not lerp
;121:	player->client->ps.eFlags ^= EF_TELEPORT_BIT;
;122:#endif
;123:
;124:	// kill anything at the destination
;125:	// JUHOX: don't kill teleport destination for dead spectators too
;126:#if 0
;127:	if ( player->client->sess.sessionTeam != TEAM_SPECTATOR ) {
;128:#else
;129:	if (player->client->ps.pm_type != PM_SPECTATOR) {
;130:#endif
;131:		G_KillBox (player);
;132:	}
;133:
;134:	// save results of pmove
;135:	BG_PlayerStateToEntityState( &player->client->ps, &player->s, qtrue );
;136:
;137:	// use the precise origin for linking
;138:	VectorCopy( player->client->ps.origin, player->r.currentOrigin );
;139:
;140:	// JUHOX: don't link dead spectators too
;141:#if 0
;142:	if ( player->client->sess.sessionTeam != TEAM_SPECTATOR ) {
;143:#else
;144:	if (player->client->ps.pm_type != PM_SPECTATOR) {
;145:#endif
;146:		trap_LinkEntity (player);
;147:	}
;148:#else	// MONSTER_MODE
;149:	gentity_t	*tent;
;150:	qboolean noAngles;
;151:	playerState_t* ps;
;152:
;153:	ps = G_GetEntityPlayerState(player);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 154
;154:	if (!ps) return;
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $95
ADDRGP4 $94
JUMPV
LABELV $95
line 156
;155:
;156:	noAngles = (angles[0] > 999999.0);
ADDRFP4 8
INDIRP4
INDIRF4
CNSTF4 1232348144
LEF4 $98
ADDRLP4 16
CNSTI4 1
ASGNI4
ADDRGP4 $99
JUMPV
LABELV $98
ADDRLP4 16
CNSTI4 0
ASGNI4
LABELV $99
ADDRLP4 8
ADDRLP4 16
INDIRI4
ASGNI4
line 157
;157:	if (ps->pm_type != PM_SPECTATOR) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $100
line 158
;158:		tent = G_TempEntity(ps->origin, EV_PLAYER_TELEPORT_OUT);
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ARGP4
CNSTI4 43
ARGI4
ADDRLP4 20
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 20
INDIRP4
ASGNP4
line 159
;159:		tent->s.clientNum = player->s.clientNum;
ADDRLP4 4
INDIRP4
CNSTI4 168
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 161
;160:
;161:		tent = G_TempEntity(origin, EV_PLAYER_TELEPORT_IN);
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 42
ARGI4
ADDRLP4 24
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
ASGNP4
line 162
;162:		tent->s.clientNum = player->s.clientNum;
ADDRLP4 4
INDIRP4
CNSTI4 168
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 163
;163:	}
LABELV $100
line 165
;164:
;165:	trap_UnlinkEntity(player);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 167
;166:
;167:	VectorCopy(origin, ps->origin);
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 168
;168:	ps->origin[2] += 1;
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 170
;169:
;170:	if (!noAngles) {
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $102
line 172
;171:		// spit the player out
;172:		AngleVectors(angles, ps->velocity, NULL, NULL);
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 173
;173:		VectorScale(ps->velocity, 400, ps->velocity);
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
CNSTF4 1137180672
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
CNSTF4 1137180672
MULF4
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
CNSTF4 1137180672
MULF4
ASGNF4
line 174
;174:		ps->pm_time = 160;		// hold time
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 160
ASGNI4
line 175
;175:		ps->pm_flags |= PMF_TIME_KNOCKBACK;
ADDRLP4 36
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
line 178
;176:	
;177:		// set angles
;178:		SetClientViewAngle(player, angles);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 SetClientViewAngle
CALLV
pop
line 179
;179:	}
LABELV $102
line 181
;180:	// toggle the teleport bit so the client knows to not lerp
;181:	ps->eFlags ^= EF_TELEPORT_BIT;
ADDRLP4 24
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 4
BXORI4
ASGNI4
line 183
;182:
;183:	if (ps->pm_type != PM_SPECTATOR) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $104
line 184
;184:		G_KillBox(player);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_KillBox
CALLV
pop
line 185
;185:	}
LABELV $104
line 188
;186:
;187:	// save results of pmove
;188:	{
line 191
;189:		int clientNum;
;190:
;191:		clientNum = player->s.clientNum;
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 192
;192:		BG_PlayerStateToEntityState(ps, &player->s, qtrue);
ADDRLP4 0
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
line 193
;193:		player->s.clientNum = clientNum;
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 194
;194:	}
line 197
;195:
;196:	// use the precise origin for linking
;197:	VectorCopy(ps->origin, player->r.currentOrigin);
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 199
;198:
;199:	if (ps->pm_type != PM_SPECTATOR) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $106
line 200
;200:		trap_LinkEntity(player);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 201
;201:	}	
LABELV $106
line 206
;202:#endif
;203:
;204:	// JUHOX: new spawn effect
;205:#if 1
;206:	{
line 209
;207:		playerState_t* ps;
;208:
;209:		ps = G_GetEntityPlayerState(player);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 28
ADDRLP4 32
INDIRP4
ASGNP4
line 210
;210:		if (ps) {
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $108
line 211
;211:			ps->stats[STAT_EFFECT] = PE_spawn;
ADDRLP4 28
INDIRP4
CNSTI4 220
ADDP4
CNSTI4 0
ASGNI4
line 212
;212:			ps->powerups[PW_EFFECT_TIME] = level.time + SPAWNHULL_TIME;
ADDRLP4 28
INDIRP4
CNSTI4 364
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 213
;213:		}
LABELV $108
line 214
;214:	}
line 219
;215:#endif
;216:
;217:	// JUHOX: cut rope when player is teleported
;218:#if GRAPPLE_ROPE
;219:	if (player->client && player->client->hook) {
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $111
ADDRLP4 28
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 884
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $111
line 220
;220:		Weapon_HookFree(player->client->hook);
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
line 221
;221:	}
LABELV $111
line 223
;222:#endif
;223:}
LABELV $94
endproc TeleportPlayer 40 16
export SP_misc_teleporter_dest
proc SP_misc_teleporter_dest 0 0
line 231
;224:
;225:
;226:/*QUAKED misc_teleporter_dest (1 0 0) (-32 -32 -24) (32 32 -16)
;227:Point teleporters at these.
;228:Now that we don't have teleport destination pads, this is just
;229:an info_notnull
;230:*/
;231:void SP_misc_teleporter_dest( gentity_t *ent ) {
line 233
;232:#if ESCAPE_MODE	// JUHOX: set entity class
;233:	ent->entClass = GEC_misc_teleporter_dest;
ADDRFP4 0
INDIRP4
CNSTI4 824
ADDP4
CNSTI4 34
ASGNI4
line 235
;234:#endif
;235:}
LABELV $113
endproc SP_misc_teleporter_dest 0 0
export SP_misc_model
proc SP_misc_model 0 4
line 243
;236:
;237:
;238://===========================================================
;239:
;240:/*QUAKED misc_model (1 0 0) (-16 -16 -16) (16 16 16)
;241:"model"		arbitrary .md3 file to display
;242:*/
;243:void SP_misc_model( gentity_t *ent ) {
line 254
;244:
;245:#if 0
;246:	ent->s.modelindex = G_ModelIndex( ent->model );
;247:	VectorSet (ent->mins, -16, -16, -16);
;248:	VectorSet (ent->maxs, 16, 16, 16);
;249:	trap_LinkEntity (ent);
;250:
;251:	G_SetOrigin( ent, ent->s.origin );
;252:	VectorCopy( ent->s.angles, ent->s.apos.trBase );
;253:#else
;254:	G_FreeEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 256
;255:#endif
;256:}
LABELV $114
endproc SP_misc_model 0 4
export locateCamera
proc locateCamera 44 8
line 260
;257:
;258://===========================================================
;259:
;260:void locateCamera( gentity_t *ent ) {
line 268
;261:	vec3_t		dir;
;262:	gentity_t	*target;
;263:	gentity_t	*owner;
;264:
;265:#if !ESCAPE_MODE	// JUHOX: G_PickTarget() also needs to know the segment
;266:	owner = G_PickTarget( ent->target );
;267:#else
;268:	owner = G_PickTarget(ent->target, ent->worldSegment - 1);
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 652
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRLP4 24
ADDRGP4 G_PickTarget
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 24
INDIRP4
ASGNP4
line 270
;269:#endif
;270:	if ( !owner ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $116
line 271
;271:		G_Printf( "Couldn't find target for misc_partal_surface\n" );
ADDRGP4 $118
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 272
;272:		G_FreeEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 273
;273:		return;
ADDRGP4 $115
JUMPV
LABELV $116
line 275
;274:	}
;275:	ent->r.ownerNum = owner->s.number;
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 278
;276:
;277:	// frame holds the rotate speed
;278:	if ( owner->spawnflags & 1 ) {
ADDRLP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $119
line 279
;279:		ent->s.frame = 25;
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 25
ASGNI4
line 280
;280:	} else if ( owner->spawnflags & 2 ) {
ADDRGP4 $120
JUMPV
LABELV $119
ADDRLP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $121
line 281
;281:		ent->s.frame = 75;
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 75
ASGNI4
line 282
;282:	}
LABELV $121
LABELV $120
line 285
;283:
;284:	// swing camera ?
;285:	if ( owner->spawnflags & 4 ) {
ADDRLP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $123
line 287
;286:	// set to 0 for no rotation at all
;287:		ent->s.powerups = 0;
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
CNSTI4 0
ASGNI4
line 288
;288:	}
ADDRGP4 $124
JUMPV
LABELV $123
line 289
;289:	else {
line 290
;290:	ent->s.powerups = 1;
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
CNSTI4 1
ASGNI4
line 291
;291:	}
LABELV $124
line 294
;292:
;293:	// clientNum holds the rotate offset
;294:	ent->s.clientNum = owner->s.clientNum;
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 296
;295:
;296:	VectorCopy( owner->s.origin, ent->s.origin2 );
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 302
;297:
;298:	// see if the portal_camera has a target
;299:#if !ESCAPE_MODE	// JUHOX: G_PickTarget() also needs to know the segment
;300:	target = G_PickTarget( owner->target );
;301:#else
;302:	target = G_PickTarget(owner->target, owner->worldSegment - 1);
ADDRLP4 0
INDIRP4
CNSTI4 652
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRLP4 32
ADDRGP4 G_PickTarget
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 32
INDIRP4
ASGNP4
line 304
;303:#endif
;304:	if ( target ) {
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $125
line 305
;305:		VectorSubtract( target->s.origin, owner->s.origin, dir );
ADDRLP4 4
ADDRLP4 16
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 16
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 16
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ASGNF4
line 306
;306:		VectorNormalize( dir );
ADDRLP4 4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 307
;307:	} else {
ADDRGP4 $126
JUMPV
LABELV $125
line 308
;308:		G_SetMovedir( owner->s.angles, dir );
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_SetMovedir
CALLV
pop
line 309
;309:	}
LABELV $126
line 311
;310:
;311:	ent->s.eventParm = DirToByte( dir );
ADDRLP4 4
ARGP4
ADDRLP4 36
ADDRGP4 DirToByte
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 36
INDIRI4
ASGNI4
line 312
;312:}
LABELV $115
endproc locateCamera 44 8
export SP_misc_portal_surface
proc SP_misc_portal_surface 20 4
line 318
;313:
;314:/*QUAKED misc_portal_surface (0 0 1) (-8 -8 -8) (8 8 8)
;315:The portal surface nearest this entity will show a view from the targeted misc_portal_camera, or a mirror view if untargeted.
;316:This must be within 64 world units of the surface!
;317:*/
;318:void SP_misc_portal_surface(gentity_t *ent) {
line 319
;319:	VectorClear( ent->r.mins );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 444
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 440
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 436
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 320
;320:	VectorClear( ent->r.maxs );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
CNSTF4 0
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 456
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 452
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 448
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
line 321
;321:	trap_LinkEntity (ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 323
;322:
;323:	ent->r.svFlags = SVF_PORTAL;
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 64
ASGNI4
line 324
;324:	ent->s.eType = ET_PORTAL;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 6
ASGNI4
line 326
;325:
;326:	if ( !ent->target ) {
ADDRFP4 0
INDIRP4
CNSTI4 652
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $130
line 327
;327:		VectorCopy( ent->s.origin, ent->s.origin2 );
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 328
;328:	} else {
ADDRGP4 $131
JUMPV
LABELV $130
line 329
;329:		ent->think = locateCamera;
ADDRFP4 0
INDIRP4
CNSTI4 696
ADDP4
ADDRGP4 locateCamera
ASGNP4
line 330
;330:		ent->nextthink = level.time + 100;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 331
;331:	}
LABELV $131
line 333
;332:#if ESCAPE_MODE	// JUHOX: set entity class
;333:	ent->entClass = GEC_misc_portal_surface;
ADDRFP4 0
INDIRP4
CNSTI4 824
ADDP4
CNSTI4 36
ASGNI4
line 335
;334:#endif
;335:}
LABELV $129
endproc SP_misc_portal_surface 20 4
export SP_misc_portal_camera
proc SP_misc_portal_camera 20 12
line 341
;336:
;337:/*QUAKED misc_portal_camera (0 0 1) (-8 -8 -8) (8 8 8) slowrotate fastrotate noswing
;338:The target for a misc_portal_director.  You can set either angles or target another entity to determine the direction of view.
;339:"roll" an angle modifier to orient the camera around the target vector;
;340:*/
;341:void SP_misc_portal_camera(gentity_t *ent) {
line 344
;342:	float	roll;
;343:
;344:	VectorClear( ent->r.mins );
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
CNSTF4 0
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 444
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 440
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 436
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
line 345
;345:	VectorClear( ent->r.maxs );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
CNSTF4 0
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 456
ADDP4
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 452
ADDP4
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 448
ADDP4
ADDRLP4 16
INDIRF4
ASGNF4
line 346
;346:	trap_LinkEntity (ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 348
;347:
;348:	G_SpawnFloat( "roll", "0", &roll );
ADDRGP4 $134
ARGP4
ADDRGP4 $135
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 350
;349:
;350:	ent->s.clientNum = roll/360.0 * 256;
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
ADDRLP4 0
INDIRF4
CNSTF4 1060506465
MULF4
CVFI4 4
ASGNI4
line 352
;351:#if ESCAPE_MODE	// JUHOX: set entity class
;352:	ent->entClass = GEC_misc_portal_camera;
ADDRFP4 0
INDIRP4
CNSTI4 824
ADDP4
CNSTI4 35
ASGNI4
line 354
;353:#endif
;354:}
LABELV $133
endproc SP_misc_portal_camera 20 12
export Use_Shooter
proc Use_Shooter 76 12
line 364
;355:
;356:/*
;357:======================================================================
;358:
;359:  SHOOTERS
;360:
;361:======================================================================
;362:*/
;363:
;364:void Use_Shooter( gentity_t *ent, gentity_t *other, gentity_t *activator ) {
line 370
;365:	vec3_t		dir;
;366:	float		deg;
;367:	vec3_t		up, right;
;368:
;369:	// see if we have a target
;370:	if ( ent->enemy ) {
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $137
line 371
;371:		VectorSubtract( ent->enemy->r.currentOrigin, ent->s.origin, dir );
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 40
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 40
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 44
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ASGNF4
line 372
;372:		VectorNormalize( dir );
ADDRLP4 0
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 373
;373:	} else {
ADDRGP4 $138
JUMPV
LABELV $137
line 374
;374:		VectorCopy( ent->movedir, dir );
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 680
ADDP4
INDIRB
ASGNB 12
line 375
;375:	}
LABELV $138
line 378
;376:
;377:	// randomize a bit
;378:	PerpendicularVector( up, dir );
ADDRLP4 16
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 PerpendicularVector
CALLV
pop
line 379
;379:	CrossProduct( up, dir, right );
ADDRLP4 16
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 28
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 381
;380:
;381:	deg = crandom() * ent->random;
ADDRLP4 40
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 12
ADDRLP4 40
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 40
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
ASGNF4
line 382
;382:	VectorMA( dir, deg, up, dir );
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 16
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 16+4
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 16+8
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
line 384
;383:
;384:	deg = crandom() * ent->random;
ADDRLP4 48
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 12
ADDRLP4 48
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 48
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
ASGNF4
line 385
;385:	VectorMA( dir, deg, right, dir );
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 28
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 28+4
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 28+8
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
line 387
;386:
;387:	VectorNormalize( dir );
ADDRLP4 0
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 389
;388:
;389:	switch ( ent->s.weapon ) {
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 4
EQI4 $156
ADDRLP4 56
INDIRI4
CNSTI4 5
EQI4 $157
ADDRLP4 56
INDIRI4
CNSTI4 8
EQI4 $158
ADDRGP4 $153
JUMPV
LABELV $156
line 391
;390:	case WP_GRENADE_LAUNCHER:
;391:		fire_grenade( ent, ent->s.origin, dir );
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 fire_grenade
CALLP4
pop
line 392
;392:		break;
ADDRGP4 $154
JUMPV
LABELV $157
line 394
;393:	case WP_ROCKET_LAUNCHER:
;394:		fire_rocket( ent, ent->s.origin, dir );
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 fire_rocket
CALLP4
pop
line 395
;395:		break;
ADDRGP4 $154
JUMPV
LABELV $158
line 397
;396:	case WP_PLASMAGUN:
;397:		fire_plasma( ent, ent->s.origin, dir );
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRLP4 72
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 fire_plasma
CALLP4
pop
line 398
;398:		break;
LABELV $153
LABELV $154
line 401
;399:	}
;400:
;401:	G_AddEvent( ent, EV_FIRE_WEAPON, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 23
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 402
;402:}
LABELV $136
endproc Use_Shooter 76 12
proc InitShooter_Finish 8 8
line 405
;403:
;404:
;405:static void InitShooter_Finish( gentity_t *ent ) {
line 409
;406:#if !ESCAPE_MODE	// JUHOX: G_PickTarget() also needs to know the segment
;407:	ent->enemy = G_PickTarget( ent->target );
;408:#else
;409:	ent->enemy = G_PickTarget(ent->target, ent->worldSegment - 1);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 652
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRLP4 4
ADDRGP4 G_PickTarget
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 772
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 411
;410:#endif
;411:	ent->think = 0;
ADDRFP4 0
INDIRP4
CNSTI4 696
ADDP4
CNSTP4 0
ASGNP4
line 412
;412:	ent->nextthink = 0;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
CNSTI4 0
ASGNI4
line 413
;413:}
LABELV $159
endproc InitShooter_Finish 8 8
export InitShooter
proc InitShooter 16 8
line 415
;414:
;415:void InitShooter( gentity_t *ent, int weapon ) {
line 416
;416:	ent->use = Use_Shooter;
ADDRFP4 0
INDIRP4
CNSTI4 712
ADDP4
ADDRGP4 Use_Shooter
ASGNP4
line 417
;417:	ent->s.weapon = weapon;
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 419
;418:
;419:	RegisterItem( BG_FindItemForWeapon( weapon ) );
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 BG_FindItemForWeapon
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 421
;420:
;421:	G_SetMovedir( ent->s.angles, ent->movedir );
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
line 423
;422:
;423:	if ( !ent->random ) {
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRF4
CNSTF4 0
NEF4 $161
line 424
;424:		ent->random = 1.0;
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
CNSTF4 1065353216
ASGNF4
line 425
;425:	}
LABELV $161
line 426
;426:	ent->random = sin( M_PI * ent->random / 180 );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 804
ADDP4
INDIRF4
CNSTF4 1016003125
MULF4
ARGF4
ADDRLP4 12
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 804
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
line 428
;427:	// target might be a moving object, so we can't set movedir for it
;428:	if ( ent->target ) {
ADDRFP4 0
INDIRP4
CNSTI4 652
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $163
line 429
;429:		ent->think = InitShooter_Finish;
ADDRFP4 0
INDIRP4
CNSTI4 696
ADDP4
ADDRGP4 InitShooter_Finish
ASGNP4
line 430
;430:		ent->nextthink = level.time + 500;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 431
;431:	}
LABELV $163
line 432
;432:	trap_LinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 433
;433:}
LABELV $160
endproc InitShooter 16 8
export SP_shooter_rocket
proc SP_shooter_rocket 0 8
line 439
;434:
;435:/*QUAKED shooter_rocket (1 0 0) (-16 -16 -16) (16 16 16)
;436:Fires at either the target or the current direction.
;437:"random" the number of degrees of deviance from the taget. (1.0 default)
;438:*/
;439:void SP_shooter_rocket( gentity_t *ent ) {
line 440
;440:	InitShooter( ent, WP_ROCKET_LAUNCHER );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 5
ARGI4
ADDRGP4 InitShooter
CALLV
pop
line 442
;441:#if ESCAPE_MODE	// JUHOX: set entity class
;442:	ent->entClass = GEC_shooter_rocket;
ADDRFP4 0
INDIRP4
CNSTI4 824
ADDP4
CNSTI4 37
ASGNI4
line 444
;443:#endif
;444:}
LABELV $166
endproc SP_shooter_rocket 0 8
export SP_shooter_plasma
proc SP_shooter_plasma 0 8
line 450
;445:
;446:/*QUAKED shooter_plasma (1 0 0) (-16 -16 -16) (16 16 16)
;447:Fires at either the target or the current direction.
;448:"random" is the number of degrees of deviance from the taget. (1.0 default)
;449:*/
;450:void SP_shooter_plasma( gentity_t *ent ) {
line 451
;451:	InitShooter( ent, WP_PLASMAGUN);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 8
ARGI4
ADDRGP4 InitShooter
CALLV
pop
line 453
;452:#if ESCAPE_MODE	// JUHOX: set entity class
;453:	ent->entClass = GEC_shooter_plasma;
ADDRFP4 0
INDIRP4
CNSTI4 824
ADDP4
CNSTI4 38
ASGNI4
line 455
;454:#endif
;455:}
LABELV $167
endproc SP_shooter_plasma 0 8
export SP_shooter_grenade
proc SP_shooter_grenade 0 8
line 461
;456:
;457:/*QUAKED shooter_grenade (1 0 0) (-16 -16 -16) (16 16 16)
;458:Fires at either the target or the current direction.
;459:"random" is the number of degrees of deviance from the taget. (1.0 default)
;460:*/
;461:void SP_shooter_grenade( gentity_t *ent ) {
line 462
;462:	InitShooter( ent, WP_GRENADE_LAUNCHER);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 InitShooter
CALLV
pop
line 464
;463:#if ESCAPE_MODE	// JUHOX: set entity class
;464:	ent->entClass = GEC_shooter_grenade;
ADDRFP4 0
INDIRP4
CNSTI4 824
ADDP4
CNSTI4 39
ASGNI4
line 466
;465:#endif
;466:}
LABELV $168
endproc SP_shooter_grenade 0 8
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
LABELV $135
byte 1 48
byte 1 0
align 1
LABELV $134
byte 1 114
byte 1 111
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $118
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
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 95
byte 1 112
byte 1 97
byte 1 114
byte 1 116
byte 1 97
byte 1 108
byte 1 95
byte 1 115
byte 1 117
byte 1 114
byte 1 102
byte 1 97
byte 1 99
byte 1 101
byte 1 10
byte 1 0
