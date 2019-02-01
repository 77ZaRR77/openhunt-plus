// Copyright (C) 1999-2000 Id Software, Inc.
//
#include "g_local.h"

#define	MISSILE_PRESTEP_TIME	50

/*
================
G_BounceMissile

================
*/
void trigger_push_touch(gentity_t *self, gentity_t *other, trace_t *trace);	// JUHOX
void G_BounceMissile( gentity_t *ent, trace_t *trace ) {
	vec3_t	velocity;
	float	dot;
	int		hitTime;

	// reflect the velocity on the trace plane
	hitTime = level.previousTime + ( level.time - level.previousTime ) * trace->fraction;
	BG_EvaluateTrajectoryDelta( &ent->s.pos, hitTime, velocity );
	dot = DotProduct( velocity, trace->plane.normal );
	VectorMA( velocity, -2*dot, trace->plane.normal, ent->s.pos.trDelta );

	// JUHOX: bounce event now done in G_BounceMissile() to add volume parameter for monster seeds
	if (ent->s.weapon == WP_MONSTER_LAUNCHER) {
		float sqrspeed;

		sqrspeed = VectorLengthSquared(ent->s.pos.trDelta);

		if (sqrspeed >= 160*160) {
			G_AddEvent(ent, EV_GRENADE_BOUNCE, 0);
		}
		else if (sqrspeed >= 80*80) {
			G_AddEvent(ent, EV_GRENADE_BOUNCE, 1);
		}
		else if (sqrspeed >= 40*40) {
			G_AddEvent(ent, EV_GRENADE_BOUNCE, 2);
		}
	}
	else {
		G_AddEvent(ent, EV_GRENADE_BOUNCE, 0);
	}

	if ( ent->s.eFlags & EF_BOUNCE_HALF ) {
		VectorScale( ent->s.pos.trDelta, 0.65, ent->s.pos.trDelta );
		// check for stop
		if ( trace->plane.normal[2] > 0.2 && VectorLength( ent->s.pos.trDelta ) < 40 ) {
			G_SetOrigin( ent, trace->endpos );
			ent->s.time = level.time / 4;	// JUHOX: set rotation on stop position (depends on original Q3 code in CG_Missile())
            // JUHOX: monster seed impact code
			if (ent->s.weapon == WP_MONSTER_LAUNCHER && ent->think) {
				ent->think(ent);
			}
			return;
		}
	}

	VectorAdd( ent->r.currentOrigin, trace->plane.normal, ent->r.currentOrigin);
	VectorCopy( ent->r.currentOrigin, ent->s.pos.trBase );
	ent->s.pos.trTime = level.time;

	// JUHOX: in certain cases the jump pad trigger may push the grenade against the jump pad, so re-trigger
	if (ent->s.eType == ET_MISSILE ) {
		if (ent->count >= 0) {
			gentity_t* trigger;

			trigger = &g_entities[ent->count];
			if (
				trigger->inuse &&
				trigger->s.eType == ET_PUSH_TRIGGER &&
				trigger->touch == trigger_push_touch
			) {
				VectorCopy(trigger->s.origin2, ent->s.pos.trDelta);
			}
		}
	}
}


/*
================
JUHOX: CreateBFGCloud
================
*/
#define BFGCLOUD_SIZE 24
static void CreateBFGCloud(gentity_t* seed) {
	static gentity_t* cloud[BFGCLOUD_SIZE];
	int cloudSize;

	if (seed->s.weapon != WP_BFG) return;

	cloud[0] = seed;
	cloudSize = 1;
	while (cloudSize < BFGCLOUD_SIZE) {
		gentity_t* ent;
		gentity_t* parent;
		trace_t tr;
		vec3_t angles, dir, origin;

		parent = cloud[rand() % cloudSize];

		angles[0] = rand() % 360;
		angles[1] = rand() % 360;
		angles[2] = rand() % 360;
		AngleVectors(angles, dir, NULL, NULL);
		VectorMA(parent->r.currentOrigin, seed->splashRadius, dir, origin);
		trap_Trace(&tr, parent->r.currentOrigin, NULL, NULL, origin, -1, MASK_SHOT);

		ent = G_TempEntity(tr.endpos, EV_MISSILE_MISS);
		if (!ent) return;
		ent->s.weapon = WP_BFG;

		ent->s.eventParm = -1;
		cloud[cloudSize++] = ent;

		G_RadiusDamage(tr.endpos, seed->parent, seed->splashDamage, seed->splashRadius, NULL, seed->splashMethodOfDeath);
	}
}


/*
================
G_ExplodeMissile

Explode a missile without an impact
================
*/
void G_ExplodeMissile( gentity_t *ent ) {
	vec3_t		dir;
	vec3_t		origin;

	BG_EvaluateTrajectory( &ent->s.pos, level.time, origin );
	SnapVector( origin );
	G_SetOrigin( ent, origin );

	// we don't have a valid direction, so just point straight up
	dir[0] = dir[1] = 0;
	dir[2] = 1;

	ent->s.eType = ET_GENERAL;
	G_AddEvent( ent, EV_MISSILE_MISS, DirToByte( dir ) );

	ent->freeAfterEvent = qtrue;

	// splash damage
	if ( ent->splashDamage ) {
		if( G_RadiusDamage( ent->r.currentOrigin, ent->parent, ent->splashDamage, ent->splashRadius, ent
			, ent->splashMethodOfDeath ) ) {
			g_entities[ent->r.ownerNum].client->accuracy_hits++;
		}
	}

	trap_LinkEntity( ent );
	CreateBFGCloud(ent);	// JUHOX
}

/*
================
G_MissileImpact
================
*/
void G_MissileImpact( gentity_t *ent, trace_t *trace ) {
	gentity_t		*other;
	qboolean		hitClient = qfalse;
	other = &g_entities[trace->entityNum];

	// check for bounce
	if (
		(
			ent->s.eFlags & (EF_BOUNCE | EF_BOUNCE_HALF)
		) &&
		(
			!other->takedamage ||
			(
				ent->s.weapon == WP_MONSTER_LAUNCHER &&
				!G_GetEntityPlayerState(other)
			)
		)
	) {

		G_BounceMissile( ent, trace );

		return;
	}

	// impact damage
	if (other->takedamage) {
    // JUHOX: seed impact
		if (ent->s.weapon == WP_MONSTER_LAUNCHER) {
			G_SetOrigin(ent, trace->endpos);

			// make sticky
			if (G_GetEntityPlayerState(other)) {
				ent->enemy = other;
				VectorSubtract(trace->endpos, other->r.currentOrigin, ent->movedir);	// JUHOX FIXME: movedir abused
			}

			if (ent->think) ent->think(ent);
			return;
		}

		// FIXME: wrong damage direction?
		if ( ent->damage ) {
			vec3_t	velocity;

			if( LogAccuracyHit( other, &g_entities[ent->r.ownerNum] ) ) {
				g_entities[ent->r.ownerNum].client->accuracy_hits++;
				hitClient = qtrue;
			}
			BG_EvaluateTrajectoryDelta( &ent->s.pos, level.time, velocity );
			if ( VectorLength( velocity ) == 0 ) {
				velocity[2] = 1;	// stepped on a grenade
			}
			G_Damage (other, ent, &g_entities[ent->r.ownerNum], velocity,
				ent->s.origin, ent->damage,
				0, ent->methodOfDeath);
		}
	}


	if (!strcmp(ent->classname, "hook")) {
		gentity_t *nent;
		vec3_t v;

		// JUHOX: new grapple hook impact code
		if (
			g_grapple.integer != HM_classic &&
			trace->entityNum != ENTITYNUM_WORLD &&
			trace->entityNum >= MAX_CLIENTS
		) {
			Weapon_HookFree(ent);
			return;
		}

		nent = G_Spawn();
		if (!nent) return;	// JUHOX BUGFIX
		nent->s.weapon = WP_GRAPPLING_HOOK;	// JUHOX BUGFIX
		if ( other->takedamage && other->client ) {
			G_AddEvent( nent, EV_MISSILE_HIT, DirToByte( trace->plane.normal ) );
			nent->s.otherEntityNum = other->s.number;

			ent->enemy = other;

			v[0] = other->r.currentOrigin[0] + (other->r.mins[0] + other->r.maxs[0]) * 0.5;
			v[1] = other->r.currentOrigin[1] + (other->r.mins[1] + other->r.maxs[1]) * 0.5;
			v[2] = other->r.currentOrigin[2] + (other->r.mins[2] + other->r.maxs[2]) * 0.5;

			SnapVectorTowards( v, ent->s.pos.trBase );	// save net bandwidth
		} else {
			VectorCopy(trace->endpos, v);
			G_AddEvent( nent, EV_MISSILE_MISS, DirToByte( trace->plane.normal ) );
			ent->enemy = NULL;
			// JUHOX: save some data when hook attaches to a mover
			if (trace->entityNum != ENTITYNUM_WORLD) {
				ent->enemy = other;
				VectorSubtract(v, other->r.currentOrigin, ent->movedir);	// JUHOX FIXME: movedir abused
			}
		}

		SnapVectorTowards( v, ent->s.pos.trBase );	// save net bandwidth

		nent->freeAfterEvent = qtrue;
		// change over to a normal entity right at the point of impact
		nent->s.eType = ET_GENERAL;
		ent->s.eType = ET_GRAPPLE;

		G_SetOrigin( ent, v );
		G_SetOrigin( nent, v );

		if (g_grapple.integer != HM_classic) {
			ent->think = Weapon_HookThink;
			ent->nextthink = level.time + FRAMETIME;
		}
		else {
			ent->think = Weapon_HookThink;
			ent->nextthink = level.time + FRAMETIME;

			ent->parent->client->ps.pm_flags |= PMF_GRAPPLE_PULL;
			VectorCopy( ent->r.currentOrigin, ent->parent->client->ps.grapplePoint);
		}

		trap_LinkEntity( ent );
		trap_LinkEntity( nent );


		return;
	}

	// is it cheaper in bandwidth to just remove this ent and create a new
	// one, rather than changing the missile into the explosion?

	if (other->takedamage && other->s.eType == ET_PLAYER) {
		G_AddEvent( ent, EV_MISSILE_HIT, DirToByte( trace->plane.normal ) );
		ent->s.otherEntityNum = other->s.number;
	} else if( trace->surfaceFlags & SURF_METALSTEPS ) {
		G_AddEvent( ent, EV_MISSILE_MISS_METAL, DirToByte( trace->plane.normal ) );
	} else {
		G_AddEvent( ent, EV_MISSILE_MISS, DirToByte( trace->plane.normal ) );
	}

	ent->freeAfterEvent = qtrue;

	// change over to a normal entity right at the point of impact
	ent->s.eType = ET_GENERAL;

	SnapVectorTowards( trace->endpos, ent->s.pos.trBase );	// save net bandwidth

	G_SetOrigin( ent, trace->endpos );

	// splash damage (doesn't apply to person directly hit)
	if ( ent->splashDamage ) {
		if( G_RadiusDamage( trace->endpos, ent->parent, ent->splashDamage, ent->splashRadius,
			other, ent->splashMethodOfDeath ) ) {
			if( !hitClient ) {
				g_entities[ent->r.ownerNum].client->accuracy_hits++;
			}
		}
	}

	trap_LinkEntity( ent );
	CreateBFGCloud(ent);	// JUHOX
}

/*
================
G_RunMissile
================
*/
void G_RunMissile( gentity_t *ent ) {
	vec3_t		origin;
	trace_t		tr;
	int			passent;
	int			clipmask;	// JUHOX

#if MONSTER_LAUNCHER	// JUHOX: monster seeds can be sticky
	if (ent->s.weapon == WP_MONSTER_LAUNCHER && ent->enemy) {
		VectorAdd(ent->enemy->r.currentOrigin, ent->movedir, origin);	// JUHOX FIXME: movedir abused
		G_SetOrigin(ent, origin);
	}
#endif

	// get current position
	BG_EvaluateTrajectory( &ent->s.pos, level.time, origin );

	// if this missile bounced off an invulnerability sphere
	if ( ent->target_ent ) {
		passent = ent->target_ent->s.number;
	}
	else {
		// ignore interactions with the missile owner
		passent = ent->r.ownerNum;
	}
	// JUHOX: get clipmask
	clipmask = ent->clipmask;
	clipmask |= CONTENTS_TELEPORTER;	// this depends on new code in SP_trigger_teleport()
	if (ent->s.weapon == WP_GRENADE_LAUNCHER && ent->count < 0) {
		clipmask |= CONTENTS_JUMPPAD;	// this depends on new code in SP_trigger_push()
	}

	// trace a line from the previous position to the current position
	trap_Trace( &tr, ent->r.currentOrigin, ent->r.mins, ent->r.maxs, origin, passent, clipmask );	// JUHOX

	if ( tr.startsolid || tr.allsolid ) {
		// make sure the tr.entityNum is set to the entity we're stuck in
		trap_Trace( &tr, ent->r.currentOrigin, ent->r.mins, ent->r.maxs, ent->r.currentOrigin, passent, clipmask );	// JUHOX
		tr.fraction = 0;
	}
	else {
		VectorCopy( tr.endpos, ent->r.currentOrigin );
	}

	trap_LinkEntity( ent );

	if ( tr.fraction != 1 ) {
        // JUHOX: check if the missile hit a teleporter or jump pad (only grenades)
		if ( tr.entityNum > 0 && tr.entityNum < ENTITYNUM_MAX_NORMAL ) {
			gentity_t* trigger;

			trigger = &g_entities[tr.entityNum];
			if ( trigger->inuse && trigger->s.eType == ET_TELEPORT_TRIGGER && trigger->touch == trigger_teleporter_touch ) {
				gentity_t* dest;

				dest = G_PickTarget(trigger->target, trigger->worldSegment - 1);

				if (dest) {
					vec3_t origin;

					vec3_t dir;

					if (ent->s.weapon == WP_GRAPPLING_HOOK) {
						Weapon_HookFree(ent);
						return;
					}

					VectorCopy(dest->s.origin, origin);
					origin[2] += 1;	// what's this for? derived from TeleportPlayer()

					// set new origin (derived from G_SetOrigin())
					VectorCopy(origin, ent->s.pos.trBase);
					VectorCopy(origin, ent->r.currentOrigin);

					ent->s.pos.trTime = level.time;

					AngleVectors(dest->s.angles, dir, NULL, NULL);
					// CAUTION: we can't use the VectorScale() macro here (we would need to use a temp var for VectorLength(ent->s.pos.trDelta))
					_VectorScale(dir, VectorLength(ent->s.pos.trDelta), ent->s.pos.trDelta);

					ent->s.eFlags ^= EF_TELEPORT_BIT;	// derived from TeleportPlayer()
				}
				G_RunThink(ent);
				return;
			}
			else if (
				trigger->inuse &&
				trigger->s.eType == ET_PUSH_TRIGGER &&
				trigger->touch == trigger_push_touch &&
				ent->count != tr.entityNum
			) {
				ent->count = tr.entityNum;

				VectorCopy(ent->r.currentOrigin, ent->s.pos.trBase);
				ent->s.pos.trTime = level.time;
				G_AddEvent(ent, EV_GRENADE_BOUNCE, 0);
				VectorCopy(trigger->s.origin2, ent->s.pos.trDelta);
				G_RunThink(ent);
				return;
			}

		}

        // JUHOX: make monster seed bounce on playerclip
		if (
			ent->s.weapon == WP_MONSTER_LAUNCHER &&
			(tr.contents & CONTENTS_PLAYERCLIP)
		) {
			tr.surfaceFlags &= ~SURF_NOIMPACT;
		}

		// never explode or bounce on sky
		if ( tr.surfaceFlags & SURF_NOIMPACT ) {
			// If grapple, reset owner

			if (ent->s.weapon == WP_GRAPPLING_HOOK) {
				Weapon_HookFree(ent);
			}
			else {
				G_FreeEntity(ent);
			}

			return;
		}
		G_MissileImpact( ent, &tr );
		if ( ent->s.eType != ET_MISSILE ) {
			return;		// exploded
		}
	}
	if (ent->s.weapon == WP_GRENADE_LAUNCHER) ent->count = -1;	// JUHOX: reset grenade's last used jump pad
	// check think function after bouncing
	G_RunThink( ent );
}


//=============================================================================

/*
=================
fire_plasma

=================
*/
gentity_t *fire_plasma (gentity_t *self, vec3_t start, vec3_t dir) {
	gentity_t	*bolt;

	VectorNormalize (dir);

	bolt = G_Spawn();
	if (!bolt) return NULL;	// JUHOX BUGFIX
	bolt->classname = "plasma";
	bolt->nextthink = level.time + 10000;
	bolt->think = G_ExplodeMissile;
	bolt->s.eType = ET_MISSILE;
	bolt->r.svFlags = SVF_USE_CURRENT_ORIGIN;
	bolt->s.weapon = WP_PLASMAGUN;
	bolt->r.ownerNum = self->s.number;
	bolt->parent = self;
	bolt->damage = 15;
	bolt->splashDamage = 15;	// JUHOX
	bolt->splashRadius = 20;	// JUHOX
	bolt->methodOfDeath = MOD_PLASMA;
	bolt->splashMethodOfDeath = MOD_PLASMA_SPLASH;
	bolt->clipmask = MASK_SHOT;
	bolt->target_ent = NULL;
	bolt->s.pos.trType = TR_LINEAR;
	bolt->s.pos.trTime = level.time - 20;

	VectorCopy( start, bolt->s.pos.trBase );
	VectorScale( dir, 2000, bolt->s.pos.trDelta );
	SnapVector( bolt->s.pos.trDelta );			// save net bandwidth

	VectorCopy (start, bolt->r.currentOrigin);

	return bolt;
}

//=============================================================================


/*
=================
JUHOX: Grenade_Die
=================
*/
static void Grenade_Die(gentity_t* ent, gentity_t* inflictor, gentity_t* attacker, int damage, int mod) {
	int time;

	time = level.time + (rand() % 300 ) + 1;
	if (ent->nextthink > time) ent->nextthink = time;
}

/*
=================
fire_grenade
=================
*/
gentity_t *fire_grenade (gentity_t *self, vec3_t start, vec3_t dir) {
	gentity_t	*bolt;

	VectorNormalize (dir);

	bolt = G_Spawn();
	if (!bolt) return NULL;	// JUHOX BUGFIX
	bolt->classname = "grenade";
	bolt->nextthink = level.time + 2500;	//ZaRR: as original q3
	bolt->think = G_ExplodeMissile;
	bolt->s.eType = ET_MISSILE;
	bolt->r.svFlags = SVF_USE_CURRENT_ORIGIN;
	bolt->s.weapon = WP_GRENADE_LAUNCHER;
	bolt->s.eFlags = EF_BOUNCE_HALF;
	bolt->r.ownerNum = self->s.number;
	bolt->parent = self;
	bolt->damage = 125;			// ZaRR: original q3 100
	bolt->splashDamage = 125;	// ZaRR: original q3 100
	bolt->splashRadius = /*150*/SPLASH_RADIUS_GRENADE;	// JUHOX
	bolt->methodOfDeath = MOD_GRENADE;
	bolt->splashMethodOfDeath = MOD_GRENADE_SPLASH;
	bolt->clipmask = MASK_SHOT;
	bolt->target_ent = NULL;
	// JUHOX: make grenade damagable
	bolt->takedamage = qtrue;
	bolt->health = 1;
	bolt->die = Grenade_Die;

	bolt->count = -1;	// JUHOX: grenade's last used jump pad

	bolt->s.pos.trType = TR_GRAVITY;
	bolt->s.pos.trTime = level.time - MISSILE_PRESTEP_TIME;		// move a bit on the very first frame
	VectorCopy( start, bolt->s.pos.trBase );
	VectorScale( dir, 700, bolt->s.pos.trDelta );
	SnapVector( bolt->s.pos.trDelta );			// save net bandwidth

	VectorCopy (start, bolt->r.currentOrigin);

	return bolt;
}

/*
=================
JUHOX: G_TriggerMonsterSeed

derived from G_ExplodeMissile()
=================
*/

static void G_TriggerMonsterSeed(gentity_t* seed) {
	vec3_t origin;

	seed->nextthink = 0;
	seed->think = NULL;

	BG_EvaluateTrajectory(&seed->s.pos, level.time, origin);
	origin[2] += 5;
	if (!G_AddMonsterSeed(origin, seed)) {
		G_AddEvent(seed, EV_GRENADE_BOUNCE, 0);
		seed->freeAfterEvent = qtrue;
	}
}


/*
=================
JUHOX: fire_monster_seed

derived of fire_grenade()
=================
*/
gentity_t* fire_monster_seed(gentity_t* self, vec3_t start, vec3_t dir) {
	gentity_t* seed;

	VectorNormalize(dir);

	seed = G_Spawn();
	if (!seed) return NULL;
	seed->classname = "monster_seed";
	seed->nextthink = level.time + 10000;
	seed->think = G_TriggerMonsterSeed;
	seed->s.eType = ET_MISSILE;
	seed->r.svFlags = SVF_USE_CURRENT_ORIGIN;
	seed->s.weapon = WP_MONSTER_LAUNCHER;
	seed->s.eFlags = EF_BOUNCE_HALF;
	seed->r.ownerNum = self->s.number;
	VectorSet(seed->r.mins, -4, -4, -4);
	VectorSet(seed->r.maxs, 4, 4, 4);
	seed->parent = self;
	seed->clipmask = MASK_PLAYERSOLID;
	seed->target_ent = NULL;

	seed->s.pos.trType = TR_GRAVITY;
	seed->s.pos.trTime = level.time - MISSILE_PRESTEP_TIME;		// move a bit on the very first frame
	VectorCopy(start, seed->s.pos.trBase);
	VectorScale(dir, 700, seed->s.pos.trDelta);
	SnapVector(seed->s.pos.trDelta);			// save net bandwidth

	VectorCopy(start, seed->r.currentOrigin);

	return seed;
}


//=============================================================================


/*
=================
fire_bfg
=================
*/
gentity_t *fire_bfg (gentity_t *self, vec3_t start, vec3_t dir) {
	gentity_t	*bolt;

	VectorNormalize (dir);

	bolt = G_Spawn();
	if (!bolt) return NULL;	// JUHOX BUGFIX
	bolt->classname = "bfg";
	bolt->nextthink = level.time + 10000;
	bolt->think = G_ExplodeMissile;
	bolt->s.eType = ET_MISSILE;
	bolt->r.svFlags = SVF_USE_CURRENT_ORIGIN;
	bolt->s.weapon = WP_BFG;
	bolt->r.ownerNum = self->s.number;
	bolt->parent = self;
	bolt->damage = 150;
	bolt->splashDamage = 120;
	bolt->splashRadius = 150;
	bolt->methodOfDeath = MOD_BFG;
	bolt->splashMethodOfDeath = MOD_BFG_SPLASH;
	bolt->clipmask = MASK_SHOT;
	bolt->target_ent = NULL;

	bolt->s.pos.trType = TR_LINEAR;
	bolt->s.pos.trTime = level.time - MISSILE_PRESTEP_TIME;		// move a bit on the very first frame
	VectorCopy( start, bolt->s.pos.trBase );
	VectorScale( dir, 700, bolt->s.pos.trDelta );	// JUHOX
	SnapVector( bolt->s.pos.trDelta );			// save net bandwidth
	VectorCopy (start, bolt->r.currentOrigin);

	return bolt;
}

//=============================================================================


/*
=================
fire_rocket
=================
*/
gentity_t *fire_rocket (gentity_t *self, vec3_t start, vec3_t dir) {
	gentity_t	*bolt;

	VectorNormalize (dir);

	bolt = G_Spawn();
	bolt->classname = "rocket";
	bolt->nextthink = level.time + 15000;
	bolt->think = G_ExplodeMissile;
	bolt->s.eType = ET_MISSILE;
	bolt->r.svFlags = SVF_USE_CURRENT_ORIGIN;
	bolt->s.weapon = WP_ROCKET_LAUNCHER;
	bolt->r.ownerNum = self->s.number;
	bolt->parent = self;
	bolt->damage = 100;
	bolt->splashDamage = 100;
	bolt->splashRadius = /*120*/SPLASH_RADIUS_ROCKET;	// JUHOX
	bolt->methodOfDeath = MOD_ROCKET;
	bolt->splashMethodOfDeath = MOD_ROCKET_SPLASH;
	bolt->clipmask = MASK_SHOT;
	bolt->target_ent = NULL;
	bolt->s.otherEntityNum = self->s.clientNum;	// JUHOX: so client can ceck for fireball

	bolt->s.pos.trType = TR_LINEAR;
	bolt->s.pos.trTime = level.time - MISSILE_PRESTEP_TIME;		// move a bit on the very first frame
	VectorCopy( start, bolt->s.pos.trBase );
	VectorScale( dir, 900, bolt->s.pos.trDelta );
	SnapVector( bolt->s.pos.trDelta );			// save net bandwidth
	VectorCopy (start, bolt->r.currentOrigin);

	return bolt;
}

/*
=================
fire_grapple
=================
*/
gentity_t *fire_grapple (gentity_t *self, vec3_t start, vec3_t dir) {
	gentity_t	*hook;
	float speed;	// JUHOX

	Weapon_HookFree(self->client->hook);	// JUHOX
	self->client->hook = NULL;				// JUHOX

	VectorNormalize (dir);

	hook = G_Spawn();
	if (!hook) return NULL;	// JUHOX BUGFIX
	hook->classname = "hook";
	hook->nextthink = level.time + 20000;	// JUHOX
	hook->think = Weapon_HookFree;
	hook->s.eType = ET_MISSILE;
	hook->r.svFlags = SVF_USE_CURRENT_ORIGIN;
	hook->s.weapon = WP_GRAPPLING_HOOK;
	hook->r.ownerNum = self->s.number;
	hook->methodOfDeath = MOD_GRAPPLE;
	hook->clipmask = MASK_SHOT;
	hook->parent = self;
	hook->target_ent = NULL;
	// JUHOX: the hooks needs some extension
	VectorSet(hook->r.mins, -ROPE_ELEMENT_SIZE, -ROPE_ELEMENT_SIZE, -ROPE_ELEMENT_SIZE);
	VectorSet(hook->r.maxs, ROPE_ELEMENT_SIZE, ROPE_ELEMENT_SIZE, ROPE_ELEMENT_SIZE);

	// JUHOX: let hook fly like a grenade
	switch (g_grapple.integer) {
	case HM_classic:
		hook->s.pos.trType = TR_LINEAR;
		speed = 800;
		break;
	case HM_tool:
	default:
		hook->s.pos.trType = TR_GRAVITY;
		speed = self->client->offHandHook? 800 : 1200;
		break;
	case HM_anchor:
		hook->s.pos.trType = self->client->offHandHook? TR_GRAVITY : TR_LINEAR;
		speed = self->client->offHandHook? 800 : 2000;
		break;
	case HM_combat:
		hook->s.pos.trType = TR_LINEAR;
		speed = 2000;
		break;
	}

	hook->s.pos.trTime = level.time - MISSILE_PRESTEP_TIME;		// move a bit on the very first frame
	hook->s.otherEntityNum = self->s.number; // use to match beam in client
	VectorCopy( start, hook->s.pos.trBase );
	// JUHOX: hook speed made variable
	VectorScale(dir, speed, hook->s.pos.trDelta);
	SnapVector( hook->s.pos.trDelta );			// save net bandwidth
	VectorCopy (start, hook->r.currentOrigin);

	self->client->hook = hook;

	// JUHOX: insert first rope element
	switch (g_grapple.integer) {
	case HM_classic:
		break;
	default:
		self->client->numRopeElements = 1;
		VectorCopy(start, self->client->ropeElements[0].pos);
		VectorCopy(hook->s.pos.trDelta, self->client->ropeElements[0].velocity);
		break;
	}

	self->client->lastTimeWinded = level.time;	// JUHOX

	return hook;
}
