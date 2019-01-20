// Copyright (C) 1999-2000 Id Software, Inc.
//
// g_combat.c

#include "g_local.h"


/*
============
ScorePlum
============
*/
void ScorePlum( gentity_t *ent, vec3_t origin, int score ) {
	gentity_t *plum;

	plum = G_TempEntity( origin, EV_SCOREPLUM );
	// only send this temp entity to a single client
	plum->r.svFlags |= SVF_SINGLECLIENT;
	plum->r.singleClient = ent->s.number;
	//
	plum->s.otherEntityNum = ent->s.number;
	plum->s.time = score;
}

/*
============
AddScore

Adds score to both the client and his team
============
*/
void AddScore( gentity_t *ent, vec3_t origin, int score ) {
	if ( !ent->client ) {
		return;
	}
	if (!score) return;	// JUHOX
	// no scoring during pre-match warmup
	if ( level.warmupTime ) {
		return;
	}
#if MEETING	// JUHOX: no scoring during meeting
	if (level.meeting) return;
#endif
	// show score plum
	ScorePlum(ent, origin, score);
	//
	ent->client->ps.persistant[PERS_SCORE] += score;
#if !MONSTER_MODE	// JUHOX: use team score for STU too
	if ( g_gametype.integer == GT_TEAM )
		level.teamScores[ ent->client->ps.persistant[PERS_TEAM] ] += score;
#else
	if (g_gametype.integer == GT_TEAM || g_gametype.integer >= GT_STU) {
		level.teamScores[ent->client->ps.persistant[PERS_TEAM]] += score;
	}
#endif
	CalculateRanks();
}

/*
=================
TossClientItems

Toss the weapon and powerups for the killed player
=================
*/
void TossClientItems( gentity_t *self ) {
	// JUHOX: only toss team items (i.e. flags)
#if 0
	gitem_t		*item;
	int			weapon;
	float		angle;
	int			i;
	gentity_t	*drop;

	// drop the weapon if not a gauntlet or machinegun
	weapon = self->s.weapon;

	// make a special check to see if they are changing to a new
	// weapon that isn't the mg or gauntlet.  Without this, a client
	// can pick up a weapon, be killed, and not drop the weapon because
	// their weapon change hasn't completed yet and they are still holding the MG.
	if ( weapon == WP_MACHINEGUN || weapon == WP_GRAPPLING_HOOK ) {
		if ( self->client->ps.weaponstate == WEAPON_DROPPING ) {
			weapon = self->client->pers.cmd.weapon;
		}
		if ( !( self->client->ps.stats[STAT_WEAPONS] & ( 1 << weapon ) ) ) {
			weapon = WP_NONE;
		}
	}

	if ( weapon > WP_MACHINEGUN && weapon != WP_GRAPPLING_HOOK && 
		self->client->ps.ammo[ weapon ] ) {
		// find the item type for this weapon
		item = BG_FindItemForWeapon( weapon );

		// spawn the item
		Drop_Item( self, item, 0 );
	}

	// drop all the powerups if not in teamplay
	if ( g_gametype.integer != GT_TEAM ) {
		angle = 45;
		for ( i = 1 ; i < PW_NUM_POWERUPS ; i++ ) {
			if ( self->client->ps.powerups[ i ] > level.time ) {
				item = BG_FindItemForPowerup( i );
				if ( !item ) {
					continue;
				}
				drop = Drop_Item( self, item, angle );
				if (!drop) continue;	// JUHOX BUGFIX
				// decide how many seconds it has left
				drop->count = ( self->client->ps.powerups[ i ] - level.time ) / 1000;
				if ( drop->count < 1 ) {
					drop->count = 1;
				}
				angle += 45;
			}
		}
	}
#else
	gitem_t		*item;
	float		angle;
	int			i;
	gentity_t	*drop;

	// drop the powerups
	angle = 0;
	for (i = 1; i < PW_NUM_POWERUPS; i++) {
		if (i == PW_CHARGE) continue;
		if (i == PW_SHIELD) continue;
		if (i == PW_BFG_RELOADING) continue;
		if (i == PW_INVIS) continue;
		if (i == PW_BATTLESUIT) continue;
		if (self->client->ps.powerups[i] > level.time) {
			item = BG_FindItemForPowerup(i);
			if (!item) continue;
			drop = Drop_Item(self, item, angle);
			if (!drop) continue;
			// decide how many seconds it has left
			drop->count = (self->client->ps.powerups[i] - level.time) / 1000;
			if (drop->count < 1) {
				drop->count = 1;
			}
			angle += 45;
		}
		self->client->ps.powerups[i] = 0;	// we don't have it anymore
	}
#endif
}

#ifdef MISSIONPACK

/*
=================
TossClientCubes
=================
*/
extern gentity_t	*neutralObelisk;

void TossClientCubes( gentity_t *self ) {
	gitem_t		*item;
	gentity_t	*drop;
	vec3_t		velocity;
	vec3_t		angles;
	vec3_t		origin;

	self->client->ps.generic1 = 0;

	// this should never happen but we should never
	// get the server to crash due to skull being spawned in
	if (!G_EntitiesFree()) {
		return;
	}

	if( self->client->sess.sessionTeam == TEAM_RED ) {
		item = BG_FindItem( "Red Cube" );
	}
	else {
		item = BG_FindItem( "Blue Cube" );
	}

	angles[YAW] = (float)(level.time % 360);
	angles[PITCH] = 0;	// always forward
	angles[ROLL] = 0;

	AngleVectors( angles, velocity, NULL, NULL );
	VectorScale( velocity, 150, velocity );
	velocity[2] += 200 + crandom() * 50;

	if( neutralObelisk ) {
		VectorCopy( neutralObelisk->s.pos.trBase, origin );
		origin[2] += 44;
	} else {
		VectorClear( origin ) ;
	}

	drop = LaunchItem( item, origin, velocity );

	drop->nextthink = level.time + g_cubeTimeout.integer * 1000;
	drop->think = G_FreeEntity;
	drop->spawnflags = self->client->sess.sessionTeam;
}


/*
=================
TossClientPersistantPowerups
=================
*/
void TossClientPersistantPowerups( gentity_t *ent ) {
	gentity_t	*powerup;

	if( !ent->client ) {
		return;
	}

	if( !ent->client->persistantPowerup ) {
		return;
	}

	powerup = ent->client->persistantPowerup;

	powerup->r.svFlags &= ~SVF_NOCLIENT;
	powerup->s.eFlags &= ~EF_NODRAW;
	powerup->r.contents = CONTENTS_TRIGGER;
	trap_LinkEntity( powerup );

	ent->client->ps.stats[STAT_PERSISTANT_POWERUP] = 0;
	ent->client->persistantPowerup = NULL;
}
#endif

//static int numArmorFragments = 0;

/*
===============
JUHOX: TouchArmorFragment
===============
*/
/*
static void TouchArmorFragment(gentity_t* ent, gentity_t* other, trace_t* trace) {
	if (!other->client) return;
	if (other->health < 1) return;
	if (!BG_CanItemBeGrabbed(g_gametype.integer, &ent->s, &other->client->ps)) return;

	numArmorFragments--;
	if (numArmorFragments < 0) {
		G_Printf(S_COLOR_RED "TouchArmorFragment(): armor fragment count underflow\n");
		numArmorFragments = 0;
	}
	Touch_Item(ent, other, trace);
}
*/

/*
===============
JUHOX: ThinkArmorFragment
===============
*/
/*
static void ThinkArmorFragment(gentity_t* ent) {
	numArmorFragments--;
	if (numArmorFragments < 0) {
		G_Printf(S_COLOR_RED "ThinkArmorFragment(): armor fragment count underflow\n");
		numArmorFragments = 0;
	}
	G_FreeEntity(ent); 
}
*/

/*
===============
JUHOX: TossArmorFragments
===============
*/
void TossArmorFragments(gentity_t* ent, int amount) {
	vec3_t angles, pos, vel;
	gitem_t* armorFragment5;
	//gitem_t* armorFragment25;
	gentity_t* fragment;
	playerState_t* ps;
	int numArmorFragments;

	if (!g_armorFragments.integer) return;
	if (amount < 5) return;
	armorFragment5 = BG_FindItem("Armor Fragment 5");
	if (!armorFragment5) return;
	/*
	armorFragment25 = BG_FindItem("Armor Fragment 25");
	if (!armorFragment25) return;
	*/

	{	// JUHOX FIXME
		int i;

		numArmorFragments = 0;
		for (i = MAX_CLIENTS; i < level.num_entities; i++) {
			gentity_t* ent;

			ent = &g_entities[i];
			if (!ent->inuse) continue;
			if (ent->item != armorFragment5) continue;

			numArmorFragments++;
		}
	}

	ps = G_GetEntityPlayerState(ent);

	amount = rand() % (amount + 1);
	while (amount >= 5) {
		gitem_t* armor;

		if (numArmorFragments >= 200) return;
		if (G_NumEntitiesFree() < 300) return;

		/*if (amount >= 25) {
			armor = armorFragment25;
			amount -= 25;
		}
		else*/ {
			armor = armorFragment5;
			amount -= 5;
		}
		VectorSet(angles, -80 * random(), 360 * random(), 0);	// NOTE: a negative pitch means upward
		// the following is originally from CalcMuzzlePoint()
		AngleVectors(angles, vel, NULL, NULL);
		VectorCopy(ent->s.pos.trBase, pos);
		if (ps) pos[2] += ps->viewheight;
		//VectorMA(pos, 35, vel, pos);
		// snap to integer coordinates for more efficient network bandwidth usage
		//SnapVector(pos);

		VectorScale(vel, 150 + 600 * random(), vel);
		fragment = LaunchItem(armor, pos, vel);
		if (fragment) {
			numArmorFragments++;

			fragment->physicsBounce = 0.5;
			fragment->clipmask = 0;
			fragment->s.apos.trType = TR_STATIONARY;
			VectorClear(fragment->s.apos.trDelta);
			fragment->s.apos.trTime = 0;
			fragment->s.apos.trDuration = 0;
			G_BounceItemRotation(fragment);
			//fragment->touch = TouchArmorFragment;
			fragment->think = G_FreeEntity;	//ThinkArmorFragment;
			fragment->nextthink = level.time + 30000;
		}
	}
}


/*
==================
LookAtKiller
==================
*/
void LookAtKiller( gentity_t *self, gentity_t *inflictor, gentity_t *attacker ) {
	vec3_t		dir;
	//vec3_t		angles;	// JUHOX: no longer needed

	if ( attacker && attacker != self ) {
		VectorSubtract (attacker->s.pos.trBase, self->s.pos.trBase, dir);
	} else if ( inflictor && inflictor != self ) {
		VectorSubtract (inflictor->s.pos.trBase, self->s.pos.trBase, dir);
	} else {
#if 0	// JUHOX: replace STAT_DEAD_YAW
		self->client->ps.stats[STAT_DEAD_YAW] = self->s.angles[YAW];
#else
		self->client->deadYaw = self->client->ps.viewangles[YAW];
#endif
		return;
	}

#if 0	// JUHOX: replace STAT_DEAD_YAW
	self->client->ps.stats[STAT_DEAD_YAW] = vectoyaw ( dir );

	angles[YAW] = vectoyaw ( dir );
	angles[PITCH] = 0; 
	angles[ROLL] = 0;
#else
	self->client->deadYaw = vectoyaw(dir);
#endif
}

/*
==================
GibEntity
==================
*/
void GibEntity( gentity_t *self, int killer ) {
	gentity_t *ent;
	int i;

	//if this entity still has kamikaze
	if (self->s.eFlags & EF_KAMIKAZE) {
		// check if there is a kamikaze timer around for this owner
		for (i = 0; i < MAX_GENTITIES; i++) {
			ent = &g_entities[i];
			if (!ent->inuse)
				continue;
			if (ent->activator != self)
				continue;
			if (strcmp(ent->classname, "kamikaze timer"))
				continue;
			G_FreeEntity(ent);
			break;
		}
	}
	G_AddEvent( self, EV_GIB_PLAYER, killer );
	self->takedamage = qfalse;
	self->s.eType = ET_INVISIBLE;
	self->r.contents = 0;
}

/*
==================
body_die
==================
*/
void body_die( gentity_t *self, gentity_t *inflictor, gentity_t *attacker, int damage, int meansOfDeath ) {
	if ( self->health > GIB_HEALTH ) {
		return;
	}
	if ( !g_blood.integer ) {
		self->health = GIB_HEALTH+1;
		return;
	}

	GibEntity( self, 0 );
}


/*
==================
JUHOX: DoOverkill

inflictor: may be ENTITYNUM_NONE (surrendering), or ENTITYNUM_WORLD (suicide)
'killedTeam' only needed if 'lastKilled' == NULL
==================
*/
void DoOverkill(gclient_t* lastKilled, int killedTeam, int inflictor) {
	int i;
	gclient_t* cl;
	gentity_t* te;

	for (i = 0; i < g_maxclients.integer; i++) {
		cl = level.clients + i;
		if (cl->pers.connected != CON_CONNECTED) continue;

		if (!lastKilled) {
			if (cl->ps.persistant[PERS_TEAM] == killedTeam && cl->ps.stats[STAT_HEALTH] > 0) {
				lastKilled = cl;
			}
		}
		ForceRespawn(&g_entities[i]);
	}

	te = G_TempEntity(vec3_origin, EV_OVERKILL);
	if (!te) return;
	te->s.clientNum = lastKilled? lastKilled->ps.clientNum : -1;
	te->s.otherEntityNum = inflictor;
	te->r.svFlags |= SVF_BROADCAST;
}

/*
==================
JUHOX: CheckForOverkill

returns qtrue if the whole team of 'self' has been killed
also forces any dead client to respawn
==================
*/
static qboolean CheckForOverkill(gentity_t* self, gentity_t* attacker) {
	int i;
	gclient_t* cl;

	if (g_respawnDelay.integer <= 0) return qfalse;
	if (g_gametype.integer == GT_TOURNAMENT) return qfalse;
	if (g_gametype.integer == GT_CTF) return qfalse;

	if (g_gametype.integer >= GT_TEAM) {
		if (!self->client) return qfalse;

		for (i = 0; i < g_maxclients.integer; i++) {
			cl = level.clients + i;
			if (cl->pers.connected != CON_CONNECTED) continue;
			if (cl->ps.persistant[PERS_TEAM] != self->client->ps.persistant[PERS_TEAM]) continue;
			
			if (
				cl->ps.stats[STAT_HEALTH] > 0 &&
				cl->ps.pm_type != PM_SPECTATOR	// don't count mission leaders in safety mode as alive
			) return qfalse;
			//if (cl->respawnDelay <= 0) return qfalse;
		}

		DoOverkill(self->client, 0, (attacker && attacker->client)? attacker->client->ps.clientNum : ENTITYNUM_WORLD);
		return qtrue;
	}
	else {
		int lastManStanding;
		int numPlayersAlive;

		lastManStanding = -1;
		numPlayersAlive = 0;
		for (i = 0; i < g_maxclients.integer; i++) {
			cl = level.clients + i;
			if (cl->pers.connected != CON_CONNECTED) continue;
			if (cl->ps.stats[STAT_HEALTH] <= 0) continue;

			lastManStanding = i;
			numPlayersAlive++;
		}

		if (numPlayersAlive <= 1) {
			if (lastManStanding >= 0) {
				if (&g_entities[lastManStanding] == attacker) {
					AddScore(attacker, self->r.currentOrigin, 5);
				}
				else {
					AddScore(&g_entities[lastManStanding], g_entities[lastManStanding].r.currentOrigin, 5);
				}
			}
			DoOverkill(NULL, -1, lastManStanding);
			return qtrue;
		}
	}
	return qfalse;
}

// these are just for logging, the client prints its own messages
char	*modNames[] = {
	"MOD_UNKNOWN",
	"MOD_SHOTGUN",
	"MOD_GAUNTLET",
#if MONSTER_MODE
	"MOD_CLAW",				// JUHOX
	"MOD_GUARD",			// JUHOX
	"MOD_TITAN",			// JUHOX
	"MOD_MONSTER_LAUNCHER",	// JUHOX
#endif
	"MOD_CHARGE",			// JUHOX
	"MOD_MACHINEGUN",
	"MOD_GRENADE",
	"MOD_GRENADE_SPLASH",
	"MOD_ROCKET",
	"MOD_ROCKET_SPLASH",
	"MOD_PLASMA",
	"MOD_PLASMA_SPLASH",
	"MOD_RAILGUN",
	"MOD_LIGHTNING",
	"MOD_BFG",
	"MOD_BFG_SPLASH",
	"MOD_WATER",
	"MOD_SLIME",
	"MOD_LAVA",
	"MOD_CRUSH",
	"MOD_TELEFRAG",
	"MOD_FALLING",
	"MOD_SUICIDE",
	"MOD_TARGET_LASER",
	"MOD_TRIGGER_HURT",
#ifdef MISSIONPACK
	"MOD_NAIL",
	"MOD_CHAINGUN",
	"MOD_PROXIMITY_MINE",
	"MOD_KAMIKAZE",
	"MOD_JUICED",
#endif
	"MOD_GRAPPLE"
};

#ifdef MISSIONPACK
/*
==================
Kamikaze_DeathActivate
==================
*/
void Kamikaze_DeathActivate( gentity_t *ent ) {
	G_StartKamikaze(ent);
	G_FreeEntity(ent);
}

/*
==================
Kamikaze_DeathTimer
==================
*/
void Kamikaze_DeathTimer( gentity_t *self ) {
	gentity_t *ent;

	ent = G_Spawn();
	if (!ent) return;	// JUHOX BUGFIX
	ent->classname = "kamikaze timer";
	VectorCopy(self->s.pos.trBase, ent->s.pos.trBase);
	ent->r.svFlags |= SVF_NOCLIENT;
	ent->think = Kamikaze_DeathActivate;
	ent->nextthink = level.time + 5 * 1000;

	ent->activator = self;
}

#endif

/*
==================
CheckAlmostCapture
==================
*/
void CheckAlmostCapture( gentity_t *self, gentity_t *attacker ) {
	gentity_t	*ent;
	vec3_t		dir;
	char		*classname;

	// if this player was carrying a flag
	if ( self->client->ps.powerups[PW_REDFLAG] ||
		self->client->ps.powerups[PW_BLUEFLAG] ||
		self->client->ps.powerups[PW_NEUTRALFLAG] ) {
		// get the goal flag this player should have been going for
		if ( g_gametype.integer == GT_CTF ) {
			if ( self->client->sess.sessionTeam == TEAM_BLUE ) {
				classname = "team_CTF_blueflag";
			}
			else {
				classname = "team_CTF_redflag";
			}
		}
		else {
			if ( self->client->sess.sessionTeam == TEAM_BLUE ) {
				classname = "team_CTF_redflag";
			}
			else {
				classname = "team_CTF_blueflag";
			}
		}
		ent = NULL;
		do
		{
			ent = G_Find(ent, FOFS(classname), classname);
		} while (ent && (ent->flags & FL_DROPPED_ITEM));
		// if we found the destination flag and it's not picked up
		if (ent && !(ent->r.svFlags & SVF_NOCLIENT) ) {
			// if the player was *very* close
			VectorSubtract( self->client->ps.origin, ent->s.origin, dir );
			if ( VectorLength(dir) < 200 ) {
				self->client->ps.persistant[PERS_PLAYEREVENTS] ^= PLAYEREVENT_HOLYSHIT;
				if ( attacker->client ) {
					attacker->client->ps.persistant[PERS_PLAYEREVENTS] ^= PLAYEREVENT_HOLYSHIT;
				}
			}
		}
	}
}

/*
==================
CheckAlmostScored
==================
*/
void CheckAlmostScored( gentity_t *self, gentity_t *attacker ) {
#ifdef MISSIONPACK
	gentity_t	*ent;
	vec3_t		dir;
	char		*classname;

	// if the player was carrying cubes
	if ( self->client->ps.generic1 ) {
		if ( self->client->sess.sessionTeam == TEAM_BLUE ) {
			classname = "team_redobelisk";
		}
		else {
			classname = "team_blueobelisk";
		}
		ent = G_Find(NULL, FOFS(classname), classname);
		// if we found the destination obelisk
		if ( ent ) {
			// if the player was *very* close
			VectorSubtract( self->client->ps.origin, ent->s.origin, dir );
			if ( VectorLength(dir) < 200 ) {
				self->client->ps.persistant[PERS_PLAYEREVENTS] ^= PLAYEREVENT_HOLYSHIT;
				if ( attacker->client ) {
					attacker->client->ps.persistant[PERS_PLAYEREVENTS] ^= PLAYEREVENT_HOLYSHIT;
				}
			}
		}
	}
#endif
}

/*
==================
player_die
==================
*/
void player_die( gentity_t *self, gentity_t *inflictor, gentity_t *attacker, int damage, int meansOfDeath ) {
	gentity_t	*ent;
	int			anim;
	int			contents;
	int			killer;
	int			i;
	char		*killerName, *obit;
	int			score;	// JUHOX

	if ( self->client->ps.pm_type == PM_DEAD ) {
		return;
	}
	if (self->client->ps.pm_type == PM_SPECTATOR) return;	// JUHOX

	if ( level.intermissiontime ) {
		return;
	}

#if MEETING	// JUHOX: no kills during meeting
	if (level.meeting) return;	// JUHOX
#endif

	// check for an almost capture
	CheckAlmostCapture( self, attacker );
	// check for a player that almost brought in cubes
	CheckAlmostScored( self, attacker );

	if (self->client && self->client->hook) {
		Weapon_HookFree(self->client->hook);
	}
#ifdef MISSIONPACK
	if ((self->client->ps.eFlags & EF_TICKING) && self->activator) {
		self->client->ps.eFlags &= ~EF_TICKING;
		self->activator->think = G_FreeEntity;
		self->activator->nextthink = level.time;
	}
#endif
	self->client->ps.pm_type = PM_DEAD;
	self->client->ps.stats[STAT_RESPAWN_INFO] = -1;	// JUHOX
	self->client->corpseProduced = qfalse;	// JUHOX
#if 1	// JUHOX: save death origin if allowed to
	if (
		g_gametype.integer == GT_CTF &&
		g_respawnAtPOD.integer &&
		g_respawnDelay.integer >= 10 &&
		!self->client->ps.powerups[PW_QUAD] &&
		!NearHomeBase(self->client->sess.sessionTeam, self->client->ps.origin, 1)
	) {
		self->client->mayRespawnAtDeathOrigin = qtrue;
		VectorCopy(self->client->ps.origin, self->client->deathOrigin);
		VectorCopy(self->client->ps.viewangles, self->client->deathAngles);
	}
	else {
		self->client->mayRespawnAtDeathOrigin = qfalse;
	}
#endif

#if 1	// JUHOX: if there's enough charge, it'll gib the player
	if (
		//meansOfDeath == MOD_CHARGE &&
		self->client->ps.powerups[PW_CHARGE] - level.time >= 8500 / CHARGE_DAMAGE_PER_SECOND
	) {
		self->health = GIB_HEALTH;
	}
#endif

	if ( attacker ) {
		killer = attacker->s.number;
		if ( attacker->client ) {
			killerName = attacker->client->pers.netname;
		} else {
			killerName = "<non-client>";
		}
	} else {
		killer = ENTITYNUM_WORLD;
		killerName = "<world>";
	}

	if ( killer < 0 || killer >= MAX_CLIENTS ) {
		killer = ENTITYNUM_WORLD;
		killerName = "<world>";
	}

	if ( meansOfDeath < 0 || meansOfDeath >= sizeof( modNames ) / sizeof( modNames[0] ) ) {
		obit = "<bad obituary>";
	} else {
		obit = modNames[ meansOfDeath ];
	}

	G_LogPrintf("Kill: %i %i %i: %s killed %s by %s\n", 
		killer, self->s.number, meansOfDeath, killerName, 
		self->client->pers.netname, obit );

	// broadcast the death event to everyone
	ent = G_TempEntity( self->r.currentOrigin, EV_OBITUARY );
	ent->s.eventParm = meansOfDeath;
	ent->s.otherEntityNum = self->s.number;
	ent->s.otherEntityNum2 = killer;
	ent->r.svFlags = SVF_BROADCAST;	// send to everyone

#if 1	// JUHOX: create POD marker if needed
	if (self->client->mayRespawnAtDeathOrigin) {
		gitem_t* item;

		item = BG_FindItem("POD marker");
		if (item) {
			trace_t trace;
			vec3_t mins, maxs, dest;

			VectorSet(mins, -ITEM_RADIUS, -ITEM_RADIUS, -ITEM_RADIUS);
			VectorSet(maxs, ITEM_RADIUS, ITEM_RADIUS, ITEM_RADIUS);
			VectorCopy(self->client->deathOrigin, dest);
			dest[2] -= 10000;
			trap_Trace(
				&trace, self->client->deathOrigin, mins, maxs, dest, self->s.number,
				(int)(CONTENTS_SOLID|CONTENTS_PLAYERCLIP|CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_NODROP)
			);
			if (
				!trace.startsolid &&
				!trace.allsolid &&
				trace.fraction < 0.99 &&
				!(trace.contents & (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_NODROP))
			) {
				gentity_t* marker;

				marker = LaunchItem(item, trace.endpos, vec3_origin);
				if (marker) {
					marker->nextthink = 0;
					marker->s.time = level.time + 1000 * g_respawnDelay.integer + 1700;
					marker->s.otherEntityNum = self->s.number;
					marker->s.otherEntityNum2 = self->client->sess.sessionTeam;
					marker->s.pos.trType = TR_STATIONARY;
					marker->s.apos.trType = TR_LINEAR;
					VectorClear(marker->s.apos.trBase);
					VectorClear(marker->s.apos.trDelta);
					marker->s.apos.trTime = level.time;
					marker->s.apos.trBase[YAW] = 360 * random();
					self->client->podMarker = marker;
				}
			}
		}
		if (!self->client->podMarker) self->client->mayRespawnAtDeathOrigin = qfalse;
	}
#endif

	self->enemy = attacker;

	self->client->ps.persistant[PERS_KILLED]++;
	self->client->respawnDelay = 1000 * g_respawnDelay.integer;	// JUHOX
	if (g_gametype.integer == GT_TOURNAMENT) self->client->respawnDelay = 0;	// JUHOX

#if 1	// JUHOX: check overkill
	score = 1;
	if (CheckForOverkill(self, attacker)) {
		score = 5;
		if (g_gametype.integer < GT_TEAM) {
			// the last man standing is already rewarded by CheckForOverkill()
			// now check if the target is to be punished for suiciding
			score = 0;
			if (attacker == self || !attacker || !attacker->client) score = 1;	// will be subtracted below
		}
#if MONSTER_MODE
		level.overkilled = qtrue;
#endif
		G_LogPrintf("Overkill!\n");
	}
#endif

#if MONSTER_MODE	// JUHOX: in STU all player deaths count for the blue team (monsters)
	if (g_gametype.integer >= GT_STU) {
		if (!level.warmupTime) {
			level.teamScores[TEAM_BLUE] += score;
			CalculateRanks();
		}
	}
	else
#endif
	if (attacker && attacker->client) {
		attacker->client->lastkilled_client = self->s.number;

		if ( attacker == self || OnSameTeam (self, attacker ) ) {
			AddScore( attacker, self->r.currentOrigin, /*-1*/-score );	// JUHOX
		} else {
			AddScore( attacker, self->r.currentOrigin, /*1*/score );	// JUHOX

			if( meansOfDeath == MOD_GAUNTLET ) {
				
				// play humiliation on player
				attacker->client->ps.persistant[PERS_GAUNTLET_FRAG_COUNT]++;

				// add the sprite over the player's head
				attacker->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
				attacker->client->ps.eFlags |= EF_AWARD_GAUNTLET;
				attacker->client->rewardTime = level.time + REWARD_SPRITE_TIME;

				// also play humiliation on target
				self->client->ps.persistant[PERS_PLAYEREVENTS] ^= PLAYEREVENT_GAUNTLETREWARD;
			}

			// check for two kills in a short amount of time
			// if this is close enough to the last kill, give a reward sound
			if ( level.time - attacker->client->lastKillTime < CARNAGE_REWARD_TIME ) {
				// play excellent on player
				attacker->client->ps.persistant[PERS_EXCELLENT_COUNT]++;

				// add the sprite over the player's head
				attacker->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
				attacker->client->ps.eFlags |= EF_AWARD_EXCELLENT;
				attacker->client->rewardTime = level.time + REWARD_SPRITE_TIME;
			}
			attacker->client->lastKillTime = level.time;

		}
	} else {
		AddScore( self, self->r.currentOrigin, /*-1*/-score );	// JUHOX
	}

	// Add team bonuses
	Team_FragBonuses(self, inflictor, attacker);

	// if I committed suicide, the flag does not fall, it returns.
	if (meansOfDeath == MOD_SUICIDE) {
		if ( self->client->ps.powerups[PW_NEUTRALFLAG] ) {		// only happens in One Flag CTF
			Team_ReturnFlag( TEAM_FREE );
			self->client->ps.powerups[PW_NEUTRALFLAG] = 0;
		}
		else if ( self->client->ps.powerups[PW_REDFLAG] ) {		// only happens in standard CTF
			Team_ReturnFlag( TEAM_RED );
			self->client->ps.powerups[PW_REDFLAG] = 0;
		}
		else if ( self->client->ps.powerups[PW_BLUEFLAG] ) {	// only happens in standard CTF
			Team_ReturnFlag( TEAM_BLUE );
			self->client->ps.powerups[PW_BLUEFLAG] = 0;
		}
	}

	// if client is in a nodrop area, don't drop anything (but return CTF flags!)
	contents = trap_PointContents( self->r.currentOrigin, -1 );
	if ( !( contents & CONTENTS_NODROP )) {
		TossClientItems( self );
	}
	else {
		if ( self->client->ps.powerups[PW_NEUTRALFLAG] ) {		// only happens in One Flag CTF
			Team_ReturnFlag( TEAM_FREE );
		}
		else if ( self->client->ps.powerups[PW_REDFLAG] ) {		// only happens in standard CTF
			Team_ReturnFlag( TEAM_RED );
		}
		else if ( self->client->ps.powerups[PW_BLUEFLAG] ) {	// only happens in standard CTF
			Team_ReturnFlag( TEAM_BLUE );
		}
	}
#ifdef MISSIONPACK
	TossClientPersistantPowerups( self );
	if( g_gametype.integer == GT_HARVESTER ) {
		TossClientCubes( self );
	}
#endif

	Cmd_Score_f( self );		// show scores
	// send updated scores to any clients that are following this one,
	// or they would get stale scoreboards
	for ( i = 0 ; i < level.maxclients ; i++ ) {
		gclient_t	*client;

		client = &level.clients[i];
		if ( client->pers.connected != CON_CONNECTED ) {
			continue;
		}
		if ( client->sess.sessionTeam != TEAM_SPECTATOR ) {
			continue;
		}
		if ( client->sess.spectatorClient == self->s.number ) {
			Cmd_Score_f( g_entities + i );
		}
	}

	self->takedamage = qtrue;	// can still be gibbed

	self->client->pers.lastUsedWeapon = self->s.weapon;	// JUHOX: keep track of the weapon used when killed
	self->s.weapon = WP_NONE;
	self->s.powerups = 0;
	self->r.contents = CONTENTS_CORPSE;

	self->s.angles[0] = 0;
	self->s.angles[2] = 0;
	LookAtKiller (self, inflictor, attacker);

	VectorCopy( self->s.angles, self->client->ps.viewangles );

	self->s.loopSound = 0;

	self->r.maxs[2] = -8;

	// don't allow respawn until the death anim is done
	// g_forcerespawn may force spawning at some later time
	self->client->respawnTime = level.time + 1700;

	// remove powerups
	// JUHOX: remove only the real powerups
#if 0
	memset( self->client->ps.powerups, 0, sizeof(self->client->ps.powerups) );
#else
	memset(self->client->ps.powerups, 0, PW_NUM_POWERUPS * sizeof(int));
#endif

	// never gib in a nodrop
	if ( (self->health <= GIB_HEALTH && !(contents & CONTENTS_NODROP) && g_blood.integer) || meansOfDeath == MOD_SUICIDE) {
		// gib death
		GibEntity( self, killer );
	} else {
		// normal death
		static int i;

		switch ( i ) {
		case 0:
			anim = BOTH_DEATH1;
			break;
		case 1:
			anim = BOTH_DEATH2;
			break;
		case 2:
		default:
			anim = BOTH_DEATH3;
			break;
		}

		// for the no-blood option, we need to prevent the health
		// from going to gib level
		if ( self->health <= GIB_HEALTH ) {
			self->health = GIB_HEALTH+1;
		}

		self->client->ps.legsAnim = 
			( ( self->client->ps.legsAnim & ANIM_TOGGLEBIT ) ^ ANIM_TOGGLEBIT ) | anim;
		self->client->ps.torsoAnim = 
			( ( self->client->ps.torsoAnim & ANIM_TOGGLEBIT ) ^ ANIM_TOGGLEBIT ) | anim;

		G_AddEvent( self, EV_DEATH1 + i, killer );

		// the body can still be gibbed
		self->die = body_die;

		// globally cycle through the different death animations
		i = ( i + 1 ) % 3;

#ifdef MISSIONPACK
		if (self->s.eFlags & EF_KAMIKAZE) {
			Kamikaze_DeathTimer( self );
		}
#endif
	}

	trap_LinkEntity (self);

}


/*
================
CheckArmor
================
*/
int CheckArmor (gentity_t *ent, int damage, int dflags)
{
	// JUHOX: check armor also for monsters
#if !MONSTER_MODE
	gclient_t	*client;
	int			save;
	int			count;

	if (!damage)
		return 0;

	client = ent->client;

	if (!client)
		return 0;

	if (dflags & DAMAGE_NO_ARMOR)
		return 0;

	// armor
	count = client->ps.stats[STAT_ARMOR];
	save = ceil( damage * ARMOR_PROTECTION );
	if (save >= count)
		save = count;

	if (!save)
		return 0;

	client->ps.stats[STAT_ARMOR] -= save;

	return save;
#else
	int save, count;
	playerState_t* ps;

	if (dflags & DAMAGE_NO_ARMOR) return 0;
	if (!damage) return 0;

	ps = G_GetEntityPlayerState(ent);
	if (!ps) return 0;

	count = ps->stats[STAT_ARMOR];
	save = ceil(damage * ARMOR_PROTECTION);
	if (save >= count) save = count;

	ps->stats[STAT_ARMOR] -= save;
	return save;
#endif
}

/*
================
RaySphereIntersections
================
*/
int RaySphereIntersections( vec3_t origin, float radius, vec3_t point, vec3_t dir, vec3_t intersections[2] ) {
	float b, c, d, t;

	//	| origin - (point + t * dir) | = radius
	//	a = dir[0]^2 + dir[1]^2 + dir[2]^2;
	//	b = 2 * (dir[0] * (point[0] - origin[0]) + dir[1] * (point[1] - origin[1]) + dir[2] * (point[2] - origin[2]));
	//	c = (point[0] - origin[0])^2 + (point[1] - origin[1])^2 + (point[2] - origin[2])^2 - radius^2;

	// normalize dir so a = 1
	VectorNormalize(dir);
	b = 2 * (dir[0] * (point[0] - origin[0]) + dir[1] * (point[1] - origin[1]) + dir[2] * (point[2] - origin[2]));
	c = (point[0] - origin[0]) * (point[0] - origin[0]) +
		(point[1] - origin[1]) * (point[1] - origin[1]) +
		(point[2] - origin[2]) * (point[2] - origin[2]) -
		radius * radius;

	d = b * b - 4 * c;
	if (d > 0) {
		t = (- b + sqrt(d)) / 2;
		VectorMA(point, t, dir, intersections[0]);
		t = (- b - sqrt(d)) / 2;
		VectorMA(point, t, dir, intersections[1]);
		return 2;
	}
	else if (d == 0) {
		t = (- b ) / 2;
		VectorMA(point, t, dir, intersections[0]);
		return 1;
	}
	return 0;
}

#ifdef MISSIONPACK
/*
================
G_InvulnerabilityEffect
================
*/
int G_InvulnerabilityEffect( gentity_t *targ, vec3_t dir, vec3_t point, vec3_t impactpoint, vec3_t bouncedir ) {
	gentity_t	*impact;
	vec3_t		intersections[2], vec;
	int			n;

	if ( !targ->client ) {
		return qfalse;
	}
	VectorCopy(dir, vec);
	VectorInverse(vec);
	// sphere model radius = 42 units
	n = RaySphereIntersections( targ->client->ps.origin, 42, point, vec, intersections);
	if (n > 0) {
		impact = G_TempEntity( targ->client->ps.origin, EV_INVUL_IMPACT );
		VectorSubtract(intersections[0], targ->client->ps.origin, vec);
		vectoangles(vec, impact->s.angles);
		impact->s.angles[0] += 90;
		if (impact->s.angles[0] > 360)
			impact->s.angles[0] -= 360;
		if ( impactpoint ) {
			VectorCopy( intersections[0], impactpoint );
		}
		if ( bouncedir ) {
			VectorCopy( vec, bouncedir );
			VectorNormalize( bouncedir );
		}
		return qtrue;
	}
	else {
		return qfalse;
	}
}
#endif
/*
============
T_Damage

targ		entity that is being damaged
inflictor	entity that is causing the damage
attacker	entity that caused the inflictor to damage targ
	example: targ=monster, inflictor=rocket, attacker=player

dir			direction of the attack for knockback
point		point at which the damage is being inflicted, used for headshots
damage		amount of damage being inflicted
knockback	force to be applied against targ as a result of the damage

inflictor, attacker, dir, and point can be NULL for environmental effects

dflags		these flags are used to control how T_Damage works
	DAMAGE_RADIUS			damage was indirect (from a nearby explosion)
	DAMAGE_NO_ARMOR			armor does not protect from this damage
	DAMAGE_NO_KNOCKBACK		do not affect velocity, just view angles
	DAMAGE_NO_PROTECTION	kills godmode, armor, everything
============
*/

void G_Damage( gentity_t *targ, gentity_t *inflictor, gentity_t *attacker,
			   vec3_t dir, vec3_t point, int damage, int dflags, int mod ) {
	gclient_t	*client;
	int			take;
	int			save;
	int			asave;
	int			knockback;
	int			max;
#ifdef MISSIONPACK
	vec3_t		bouncedir, impactpoint;
#endif

	if (!targ->takedamage) {
		return;
	}

	// the intermission has allready been qualified for, so don't
	// allow any extra scoring
	if ( level.intermissionQueued ) {
		return;
	}
#ifdef MISSIONPACK
	if ( targ->client && mod != MOD_JUICED) {
		if ( targ->client->invulnerabilityTime > level.time) {
			if ( dir && point ) {
				G_InvulnerabilityEffect( targ, dir, point, impactpoint, bouncedir );
			}
			return;
		}
	}
#endif
	if ( !inflictor ) {
		inflictor = &g_entities[ENTITYNUM_WORLD];
	}
	if ( !attacker ) {
		attacker = &g_entities[ENTITYNUM_WORLD];
	}

	// shootable doors / buttons don't actually have any health
	if ( targ->s.eType == ET_MOVER ) {
		if ( targ->use && targ->moverState == MOVER_POS1 ) {
			targ->use( targ, inflictor, attacker );
		}
		return;
	}
#ifdef MISSIONPACK
	if( g_gametype.integer == GT_OBELISK && CheckObeliskAttack( targ, attacker ) ) {
		return;
	}
#endif
	// reduce damage by the attacker's handicap value
	// unless they are rocket jumping
	// JUHOX: don't apply handicap to charge damage (already applied during charging)
#if 0
	if ( attacker->client && attacker != targ ) {
#else
	if (attacker->client && attacker != targ && mod != MOD_CHARGE) {
#endif
		max = attacker->client->ps.stats[STAT_MAX_HEALTH];
#ifdef MISSIONPACK
		if( bg_itemlist[attacker->client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_GUARD ) {
			max /= 2;
		}
#endif
		// JUHOX: consider variable max health
#if 0
		damage = damage * max / 100;
#else
		if (g_baseHealth.integer > 1) {
			damage = damage * max / g_baseHealth.integer;
		}
#endif
	}

	client = targ->client;

	if ( client ) {
		if ( client->noclip ) {
			return;
		}
		// JUHOX: check for shield protection
#if 1
		if (client->ps.powerups[PW_SHIELD] && !(dflags & DAMAGE_NO_PROTECTION)) {
			return;
		}
#endif
	}

	if ( !dir ) {
		dflags |= DAMAGE_NO_KNOCKBACK;
	} else {
		VectorNormalize(dir);
	}

	knockback = damage;
	if ( knockback > 200 ) {
		knockback = 200;
	}
	if ( targ->flags & FL_NO_KNOCKBACK ) {
		knockback = 0;
	}
	if ( dflags & DAMAGE_NO_KNOCKBACK ) {
		knockback = 0;
	}

	// figure momentum add, even if the damage won't be taken
	// JUHOX: knock back monsters too
#if !MONSTER_MODE
	if ( knockback && targ->client ) {
		vec3_t	kvel;
		float	mass;

		mass = 200;
		// JUHOX: give gauntlet a stronger knockback
#if 1
		if (mod == MOD_GAUNTLET) {
			mass = 100;	// lower mass results in stronger knockback
		}
#endif

		VectorScale (dir, g_knockback.value * (float)knockback / mass, kvel);
		VectorAdd (targ->client->ps.velocity, kvel, targ->client->ps.velocity);

		// set the timer so that the other client can't cancel
		// out the movement immediately
		if ( !targ->client->ps.pm_time ) {
			int		t;

			t = knockback * 2;
			if ( t < 50 ) {
				t = 50;
			}
			if ( t > 200 ) {
				t = 200;
			}
			targ->client->ps.pm_time = t;
			targ->client->ps.pm_flags |= PMF_TIME_KNOCKBACK;
		}
	}
#else
	if (
		knockback &&
		G_GetEntityPlayerState(targ) &&
		G_IsMovable(targ)
	) {
		playerState_t* ps;
		vec3_t	kvel;
		float	mass;

		ps = G_GetEntityPlayerState(targ);
		mass = 200;
		if (mod == MOD_GAUNTLET) {
			mass = 100;	// lower mass results in stronger knockback
		}

		switch (targ->s.clientNum) {
		case CLIENTNUM_MONSTER_GUARD:
			mass *= Square(MONSTER_GUARD_SCALE);
			break;
		case CLIENTNUM_MONSTER_TITAN:
			mass *= Square(MONSTER_TITAN_SCALE);
			break;
		}
		
		if (mod == MOD_TITAN) {
			mass *= 0.2;
		}

		VectorScale(dir, g_knockback.value * (float)knockback / mass, kvel);
		VectorAdd(ps->velocity, kvel, ps->velocity);

		// set the timer so that the other client can't cancel
		// out the movement immediately
		if (!ps->pm_time) {
			int		t;

			t = knockback * 2;
			if ( t < 50 ) {
				t = 50;
			}
			if ( t > 200 ) {
				t = 200;
			}
			ps->pm_time = t;
			ps->pm_flags |= PMF_TIME_KNOCKBACK;
		}
	}
#endif

	// check for completely getting out of the damage
	if ( !(dflags & DAMAGE_NO_PROTECTION) ) {

		// if TF_NO_FRIENDLY_FIRE is set, don't do damage to the target
		// if the attacker was on the same team
#ifdef MISSIONPACK
		if ( mod != MOD_JUICED && targ != attacker && !(dflags & DAMAGE_NO_TEAM_PROTECTION) && OnSameTeam (targ, attacker)  ) {
#else	
		// JUHOX: ignore friendly fire setting on monsters (always do damage)
#if !MONSTER_MODE
		if ( targ != attacker && OnSameTeam (targ, attacker)  ) {
#else
		if (targ != attacker && OnSameTeam(targ, attacker) && !targ->monster) {
#endif
#endif
			if ( !g_friendlyFire.integer ) {
				return;
			}
		}
#ifdef MISSIONPACK
		if (mod == MOD_PROXIMITY_MINE) {
			if (inflictor && inflictor->parent && OnSameTeam(targ, inflictor->parent)) {
				return;
			}
			if (targ == attacker) {
				return;
			}
		}
#endif

		// check for godmode
		if ( targ->flags & FL_GODMODE ) {
			return;
		}
	}

	// JUHOX: ignore battlesuit protection
#if 0
	// battlesuit protects from all radius damage (but takes knockback)
	// and protects 50% against all damage
	if ( client && client->ps.powerups[PW_BATTLESUIT] ) {
		G_AddEvent( targ, EV_POWERUP_BATTLESUIT, 0 );
		if ( ( dflags & DAMAGE_RADIUS ) || ( mod == MOD_FALLING ) ) {
			return;
		}
		damage *= 0.5;
	}
#endif

	// add to the attacker's hit counter (if the target isn't a general entity like a prox mine)
	if ( attacker->client && targ != attacker && targ->health > 0
			&& mod != MOD_CHARGE	// JUHOX: don't count charge hits (it's only indirect damage)
			&& targ->s.eType != ET_MISSILE
			&& targ->s.eType != ET_GENERAL) {
		if ( OnSameTeam( targ, attacker ) ) {
			attacker->client->ps.persistant[PERS_HITS]--;
		} else {
			attacker->client->ps.persistant[PERS_HITS]++;
		}
		attacker->client->ps.persistant[PERS_ATTACKEE_ARMOR] = (targ->health<<8)|(client->ps.stats[STAT_ARMOR]);
	}

	// always give half damage if hurting self
	// calculated after knockback, so rocket jumping works
	// JUHOX: do not reduce damage if hurting self with the BFG
#if 0
	if ( targ == attacker) {
		damage *= 0.5;
	}
#else
	if (targ == attacker && mod != MOD_BFG && mod != MOD_BFG_SPLASH) {
		damage *= 0.5;
	}
#endif

	if ( damage < 1 ) {
		damage = 1;
	}
	take = damage;
	save = 0;

	// save some from armor
	asave = CheckArmor (targ, take, dflags);
	TossArmorFragments(targ, asave);	// JUHOX
	take -= asave;

	if ( g_debugDamage.integer ) {
		G_Printf( "%i: client:%i health:%i damage:%i armor:%i\n", level.time, targ->s.number,
			targ->health, take, asave );
	}

#if MONSTER_MODE
	G_CheckMonsterDamage(attacker, targ, mod);	// JUHOX
#endif

	// add to the damage inflicted on a player this frame
	// the total will be turned into screen blends and view angle kicks
	// at the end of the frame
	if ( client ) {
		if ( attacker ) {
			client->ps.persistant[PERS_ATTACKER] = attacker->s.number;
		} else {
			client->ps.persistant[PERS_ATTACKER] = ENTITYNUM_WORLD;
		}
		client->damage_armor += asave;
		client->damage_blood += take;
		client->damage_knockback += knockback;
		if ( dir ) {
			VectorCopy ( dir, client->damage_from );
			client->damage_fromWorld = qfalse;
		} else {
			VectorCopy ( targ->r.currentOrigin, client->damage_from );
			client->damage_fromWorld = qtrue;
		}
	}

	// See if it's the player hurting the emeny flag carrier
#ifdef MISSIONPACK
	if( g_gametype.integer == GT_CTF || g_gametype.integer == GT_1FCTF ) {
#else	
	if( g_gametype.integer == GT_CTF) {
#endif
		Team_CheckHurtCarrier(targ, attacker);
	}

	// JUHOX: don't let the fast charge damage overwrite any other attack
#if 0
	if (targ->client) {
#else
	if (
		targ->client &&
#if !MONSTER_MODE
		attacker->client &&
#else
		(attacker->client || attacker->monster) &&
#endif
		(
			mod != MOD_CHARGE ||
			targ->client->lasthurt_time < level.time - 1000 ||
			targ->health <= take
		)
	) {
#endif
		// set the last client who damaged the target
		targ->client->lasthurt_client = attacker->s.number;
		targ->client->lasthurt_mod = mod;
		targ->client->lasthurt_time = level.time;	// JUHOX
	}

	// do the damage
	if (take) {
#if MONSTER_MODE
		if (!G_CanBeDamaged(targ) && !(dflags & DAMAGE_NO_PROTECTION)) take = 0;	// JUHOX
#endif
		targ->health = targ->health - take;
		// JUHOX: update monster playerState_t too
#if !MONSTER_MODE
		if ( targ->client ) {
			targ->client->ps.stats[STAT_HEALTH] = targ->health;
		}
#else
		{
			playerState_t* ps;

			ps = G_GetEntityPlayerState(targ);
			if (ps) ps->stats[STAT_HEALTH] = targ->health;
		}
#endif
			
		if ( targ->health <= 0 ) {
			if ( client )
				targ->flags |= FL_NO_KNOCKBACK;

			if (targ->health < -999)
				targ->health = -999;

			targ->enemy = attacker;
			targ->die (targ, inflictor, attacker, take, mod);
			return;
		} else if ( targ->pain ) {
			targ->pain (targ, attacker, take);
		}
	}

#if 1	// JUHOX: if the target is invisible mark it by a battlesuit flash
	if (client && client->ps.powerups[PW_INVIS] && mod != MOD_WATER) {
		client->ps.powerups[PW_BATTLESUIT] = level.time + 500;
	}
#endif
}


/*
===============
JUHOX: DropHealth
===============
*/
void DropHealth(gentity_t* ent) {
	vec3_t pos, vel;

	if (!ent->client) return;
	if (ent->health <= 5) return;
	
	// the following is originally from CalcMuzzlePoint()
	AngleVectors(ent->s.apos.trBase, vel, NULL, NULL);
	VectorCopy(ent->s.pos.trBase, pos);
	pos[2] += ent->client->ps.viewheight;
	VectorMA(pos, 35, vel, pos);
	// snap to integer coordinates for more efficient network bandwidth usage
	SnapVector(pos);

	VectorScale(vel, 200, vel);
	if (LaunchItem(BG_FindItem("5 Health"), pos, vel)) {
		ent->health -= 5;
		ent->client->ps.stats[STAT_HEALTH] = ent->health;
	}
}


/*
===============
JUHOX: DropArmor
===============
*/
void DropArmor(gentity_t* ent) {
	vec3_t pos, vel;

	if (!ent->client) return;
	if (ent->client->ps.stats[STAT_ARMOR] < 5) return;
	
	// the following is originally from CalcMuzzlePoint()
	AngleVectors(ent->s.apos.trBase, vel, NULL, NULL);
	VectorCopy(ent->s.pos.trBase, pos);
	pos[2] += ent->client->ps.viewheight;
	VectorMA(pos, 35, vel, pos);
	// snap to integer coordinates for more efficient network bandwidth usage
	SnapVector(pos);

	VectorScale(vel, 200, vel);
	if (LaunchItem(BG_FindItem("Armor Shard"), pos, vel)) {
		ent->client->ps.stats[STAT_ARMOR] -= 5;
	}
}


/*
============
CanDamage

Returns qtrue if the inflictor can directly damage the target.  Used for
explosions and melee attacks.
============
*/
qboolean CanDamage (gentity_t *targ, vec3_t origin) {
	vec3_t	dest;
	trace_t	tr;
	vec3_t	midpoint;

	// use the midpoint of the bounds instead of the origin, because
	// bmodels may have their origin is 0,0,0
	VectorAdd (targ->r.absmin, targ->r.absmax, midpoint);
	VectorScale (midpoint, 0.5, midpoint);

	VectorCopy (midpoint, dest);
	trap_Trace ( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID);
	if (tr.fraction == 1.0 || tr.entityNum == targ->s.number)
		return qtrue;

	// this should probably check in the plane of projection, 
	// rather than in world coordinate, and also include Z
	VectorCopy (midpoint, dest);
	dest[0] += 15.0;
	dest[1] += 15.0;
	trap_Trace ( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID);
	if (tr.fraction == 1.0)
		return qtrue;

	VectorCopy (midpoint, dest);
	dest[0] += 15.0;
	dest[1] -= 15.0;
	trap_Trace ( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID);
	if (tr.fraction == 1.0)
		return qtrue;

	VectorCopy (midpoint, dest);
	dest[0] -= 15.0;
	dest[1] += 15.0;
	trap_Trace ( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID);
	if (tr.fraction == 1.0)
		return qtrue;

	VectorCopy (midpoint, dest);
	dest[0] -= 15.0;
	dest[1] -= 15.0;
	trap_Trace ( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID);
	if (tr.fraction == 1.0)
		return qtrue;


	return qfalse;
}


/*
============
G_RadiusDamage
============
*/
qboolean G_RadiusDamage ( vec3_t origin, gentity_t *attacker, float damage, float radius,
					 gentity_t *ignore, int mod) {
	float		points, dist;
	gentity_t	*ent;
	int			entityList[MAX_GENTITIES];
	int			numListedEntities;
	vec3_t		mins, maxs;
	vec3_t		v;
	vec3_t		dir;
	int			i, e;
	qboolean	hitClient = qfalse;

	if ( radius < 1 ) {
		radius = 1;
	}

	for ( i = 0 ; i < 3 ; i++ ) {
		mins[i] = origin[i] - radius;
		maxs[i] = origin[i] + radius;
	}

	numListedEntities = trap_EntitiesInBox( mins, maxs, entityList, MAX_GENTITIES );

	for ( e = 0 ; e < numListedEntities ; e++ ) {
		ent = &g_entities[entityList[ e ]];

		if (ent == ignore)
			continue;
		if (!ent->takedamage)
			continue;

		// find the distance from the edge of the bounding box
		for ( i = 0 ; i < 3 ; i++ ) {
			if ( origin[i] < ent->r.absmin[i] ) {
				v[i] = ent->r.absmin[i] - origin[i];
			} else if ( origin[i] > ent->r.absmax[i] ) {
				v[i] = origin[i] - ent->r.absmax[i];
			} else {
				v[i] = 0;
			}
		}

		dist = VectorLength( v );
		if ( dist >= radius ) {
			continue;
		}

		points = damage * ( 1.0 - dist / radius );

		if( CanDamage (ent, origin) ) {
			if( LogAccuracyHit( ent, attacker ) ) {
				hitClient = qtrue;
			}
			VectorSubtract (ent->r.currentOrigin, origin, dir);
			// push the center of mass higher than the origin so players
			// get knocked into the air more
			dir[2] += 24;
			G_Damage (ent, NULL, attacker, dir, origin, (int)points, DAMAGE_RADIUS, mod);
		}
	}

	return hitClient;
}
