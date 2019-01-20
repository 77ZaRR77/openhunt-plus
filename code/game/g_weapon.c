// Copyright (C) 1999-2000 Id Software, Inc.
//
// g_weapon.c 
// perform the server side effects of a weapon firing

#include "g_local.h"

static	float	s_quadFactor;
static	vec3_t	forward, right, up;
static	vec3_t	muzzle;

#define NUM_NAILSHOTS 15

/*
================
G_BounceProjectile
================
*/
void G_BounceProjectile( vec3_t start, vec3_t impact, vec3_t dir, vec3_t endout ) {
	vec3_t v, newv;
	float dot;

	VectorSubtract( impact, start, v );
	dot = DotProduct( v, dir );
	VectorMA( v, -2*dot, dir, newv );

	VectorNormalize(newv);
	VectorMA(impact, 8192, newv, endout);
}

/*
======================================================================

GAUNTLET

======================================================================
*/

void Weapon_Gauntlet( gentity_t *ent ) {

}

/*
===============
CheckGauntletAttack
===============
*/
qboolean CheckGauntletAttack( gentity_t *ent ) {
	trace_t		tr;
	vec3_t		end;
	gentity_t	*tent;
	gentity_t	*traceEnt;
	int			damage;

	// set aiming directions
#if !MONSTER_MODE	// JUHOX: accept monsters
	AngleVectors (ent->client->ps.viewangles, forward, right, up);
#else
	AngleVectors(G_GetEntityPlayerState(ent)->viewangles, forward, right, up);
#endif

	CalcMuzzlePoint ( ent, forward, right, up, muzzle );

#if 0	// JUHOX: slightly farther range, so you can attack somebody below you
	VectorMA (muzzle, 32, forward, end);
#else
	VectorMA(muzzle, 32 + fabs(forward[2]) * 20, forward, end);
#endif

	trap_Trace (&tr, muzzle, NULL, NULL, end, ent->s.number, MASK_SHOT);
	if ( tr.surfaceFlags & SURF_NOIMPACT ) {
		return qfalse;
	}

	traceEnt = &g_entities[ tr.entityNum ];

	// send blood impact
	// JUHOX: the new gauntlet is so fast, not every hit should give a blood impact
	// JUHOX BUGFIX: let bleed corpses too (& monsters)
#if 0
	if ( traceEnt->takedamage && traceEnt->client ) {
		tent = G_TempEntity( tr.endpos, EV_MISSILE_HIT );
		tent->s.otherEntityNum = traceEnt->s.number;
		tent->s.eventParm = DirToByte( tr.plane.normal );
		tent->s.weapon = ent->s.weapon;
	}
#else
	if (
		traceEnt->takedamage &&
		traceEnt->s.eType == ET_PLAYER &&
		(
#if MONSTER_MODE
			ent->monster ||
#endif
			random() < 0.05
		)
	) {
		tent = G_TempEntity( tr.endpos, EV_MISSILE_HIT );
		tent->s.otherEntityNum = traceEnt->s.number;
		tent->s.eventParm = DirToByte( tr.plane.normal );
		tent->s.weapon = ent->s.weapon;
	}
#endif

	if ( !traceEnt->takedamage) {
		return qfalse;
	}

#if MONSTER_MODE	// JUHOX: don't let monsters hit other monsters
	if (
		ent->monster &&
		traceEnt->monster &&
		G_IsFriendlyMonster(ent, traceEnt)
	) return qfalse;
#endif

#if 0	// JUHOX: ignore quad
	if (ent->client->ps.powerups[PW_QUAD] ) {
		G_AddEvent( ent, EV_POWERUP_QUAD, 0 );
		s_quadFactor = g_quadfactor.value;
	} else {
		s_quadFactor = 1;
	}
#else
	s_quadFactor = 1;
#endif
#ifdef MISSIONPACK
	if( ent->client->persistantPowerup && ent->client->persistantPowerup->item && ent->client->persistantPowerup->item->giTag == PW_DOUBLER ) {
		s_quadFactor *= 2;
	}
#endif

#if 0	// JUHOX: new gauntlet damage
	damage = 50 * s_quadFactor;
#else
	damage = 10;	// note that the gauntlet is much faster now
#endif
#if !MONSTER_MODE	// JUHOX: monsters do a special gauntlet damage
	G_Damage( traceEnt, ent, ent, forward, tr.endpos,
		damage, 0, MOD_GAUNTLET );
#else
	if (ent->monster) {
		gentity_t* owner;

		owner = G_MonsterOwner(ent);
		if (owner) {
			G_Damage(traceEnt, ent, owner, forward, tr.endpos, 25, 0, MOD_MONSTER_LAUNCHER);
		}
		else {
			G_Damage(traceEnt, ent, ent, forward, tr.endpos, 25, 0, MOD_CLAW);
		}
	}
	else {
		G_Damage(traceEnt, ent, ent, forward, tr.endpos, damage, 0, MOD_GAUNTLET);
	}
#endif

	return qtrue;
}

/*
===============
JUHOX: CheckTitanAttack
===============
*/
#if MONSTER_MODE
qboolean CheckTitanAttack(gentity_t *ent) {
	trace_t		tr;
	vec3_t		end;
	gentity_t	*tent;
	gentity_t	*traceEnt;

	// set aiming directions
	AngleVectors(G_GetEntityPlayerState(ent)->viewangles, forward, right, up);

	CalcMuzzlePoint(ent, forward, right, up, muzzle);

	VectorMA(muzzle, 150, forward, end);

	trap_Trace(&tr, muzzle, NULL, NULL, end, ent->s.number, MASK_SHOT);
	if (tr.surfaceFlags & SURF_NOIMPACT) return qfalse;

	traceEnt = &g_entities[tr.entityNum];

	if (!traceEnt->takedamage) return qfalse;

	// send blood impact
	if (traceEnt->s.eType == ET_PLAYER) {
		tent = G_TempEntity(tr.endpos, EV_MISSILE_HIT);
		tent->s.otherEntityNum = traceEnt->s.number;
		tent->s.eventParm = DirToByte(tr.plane.normal);
		tent->s.weapon = ent->s.weapon;
	}

	tent = G_TempEntity(tr.endpos, EV_EARTHQUAKE);
	tent->s.angles[0] = 1.0;	// total time in seconds
	tent->s.angles[1] = 0.0;	// fade in time in seconds
	tent->s.angles[2] = 1.0;	// fade out time in seconds
	tent->s.angles2[0] = 100.0;	// amplitude in percent
	tent->s.angles2[1] = -1;	// radius (negative = global)
	tent->s.time = qtrue;		// no sound (played separately in CG_FireWeapon())

	if (
		ent->monster &&
		traceEnt->monster &&
		G_IsFriendlyMonster(ent, traceEnt)
	) {
		return qfalse;
	}

	G_Damage(traceEnt, ent, ent, forward, tr.endpos, 100, 0, MOD_TITAN);

	return qtrue;
}
#endif


/*
======================================================================

MACHINEGUN

======================================================================
*/

/*
======================
SnapVectorTowards

Round a vector to integers for more efficient network
transmission, but make sure that it rounds towards a given point
rather than blindly truncating.  This prevents it from truncating 
into a wall.
======================
*/
#if 0	// JUHOX: add a "const" to SnapVectorTowards()
void SnapVectorTowards( vec3_t v, vec3_t to ) {
#else
void SnapVectorTowards(vec3_t v, const vec3_t to) {
#endif
	int		i;

	for ( i = 0 ; i < 3 ; i++ ) {
		if ( to[i] <= v[i] ) {
			v[i] = (int)v[i];
		} else {
			v[i] = (int)v[i] + 1;
		}
	}
}

#ifdef MISSIONPACK
#define CHAINGUN_SPREAD		600
#endif
#define MACHINEGUN_SPREAD	200
#define	MACHINEGUN_DAMAGE	7
#define	MACHINEGUN_TEAM_DAMAGE	5		// wimpier MG in teamplay

void Bullet_Fire (gentity_t *ent, float spread, int damage ) {
	trace_t		tr;
	vec3_t		end;
#ifdef MISSIONPACK
	vec3_t		impactpoint, bouncedir;
#endif
	//float		r;	// JUHOX: no longer needed
	//float		u;	// JUHOX: no longer needed
	gentity_t	*tent;
	gentity_t	*traceEnt;
	int			i, passent;

#if 1	// JUHOX: more machine gun damage
	damage = 20;
#endif
	damage *= s_quadFactor;

#if 0	// JUHOX: no machinegun spread
	if (!(ent->client->ps.pm_flags & PMF_DUCKED)) spread *= 3.0;	// JUHOX
	r = random() * M_PI * 2.0f;
	u = sin(r) * crandom() * spread * 16;
	r = cos(r) * crandom() * spread * 16;
	VectorMA (muzzle, 8192*16, forward, end);
	VectorMA (end, r, right, end);
	VectorMA (end, u, up, end);
#else
	VectorMA(muzzle, 8192*16, forward, end);
#endif

	passent = ent->s.number;
	for (i = 0; i < 10; i++) {

		trap_Trace (&tr, muzzle, NULL, NULL, end, passent, MASK_SHOT);
		if ( tr.surfaceFlags & SURF_NOIMPACT ) {
			return;
		}

		traceEnt = &g_entities[ tr.entityNum ];

		// snap the endpos to integers, but nudged towards the line
		SnapVectorTowards( tr.endpos, muzzle );

		// send bullet impact
#if 0	// JUHOX BUGFIX: let corpses bleed too (& monsters)
		if ( traceEnt->takedamage && traceEnt->client ) {
#else
		if (traceEnt->takedamage && traceEnt->s.eType == ET_PLAYER) {
#endif
			tent = G_TempEntity( tr.endpos, EV_BULLET_HIT_FLESH );
#if !MONSTER_MODE	// JUHOX: eventParm sometimes doesn't work correctly, so we use otherEntityNum2
			tent->s.eventParm = traceEnt->s.number;
#else
			tent->s.otherEntityNum2 = traceEnt->s.number;
#endif
			if( LogAccuracyHit( traceEnt, ent ) ) {
				ent->client->accuracy_hits++;
			}
		} else {
			tent = G_TempEntity( tr.endpos, EV_BULLET_HIT_WALL );
			tent->s.eventParm = DirToByte( tr.plane.normal );
		}
		tent->s.otherEntityNum = ent->s.number;

		if ( traceEnt->takedamage) {
#ifdef MISSIONPACK
			if ( traceEnt->client && traceEnt->client->invulnerabilityTime > level.time ) {
				if (G_InvulnerabilityEffect( traceEnt, forward, tr.endpos, impactpoint, bouncedir )) {
					G_BounceProjectile( muzzle, impactpoint, bouncedir, end );
					VectorCopy( impactpoint, muzzle );
					// the player can hit him/herself with the bounced rail
					passent = ENTITYNUM_NONE;
				}
				else {
					VectorCopy( tr.endpos, muzzle );
					passent = traceEnt->s.number;
				}
				continue;
			}
			else {
#endif
				G_Damage( traceEnt, ent, ent, forward, tr.endpos,
					damage, 0, MOD_MACHINEGUN);
#ifdef MISSIONPACK
			}
#endif
		}
		break;
	}
}


/*
======================================================================

BFG

======================================================================
*/

void BFG_Fire ( gentity_t *ent ) {
	gentity_t	*m;

	m = fire_bfg (ent, muzzle, forward);
	m->damage *= s_quadFactor;
	m->splashDamage *= s_quadFactor;

	ent->client->ps.powerups[PW_BFG_RELOADING] = level.time + 4000;	// JUHOX

//	VectorAdd( m->s.pos.trDelta, ent->client->ps.velocity, m->s.pos.trDelta );	// "real" physics
}


/*
======================================================================

SHOTGUN

======================================================================
*/

// DEFAULT_SHOTGUN_SPREAD and DEFAULT_SHOTGUN_COUNT	are in bg_public.h, because
// client predicts same spreads
#define	DEFAULT_SHOTGUN_DAMAGE	12	// JUHOX: was 10

qboolean ShotgunPellet( vec3_t start, vec3_t end, gentity_t *ent ) {
	trace_t		tr;
	int			damage, i, passent;
	gentity_t	*traceEnt;
#ifdef MISSIONPACK
	vec3_t		impactpoint, bouncedir;
#endif
	vec3_t		tr_start, tr_end;

	passent = ent->s.number;
	VectorCopy( start, tr_start );
	VectorCopy( end, tr_end );
	for (i = 0; i < 10; i++) {
		trap_Trace (&tr, tr_start, NULL, NULL, tr_end, passent, MASK_SHOT);
		traceEnt = &g_entities[ tr.entityNum ];

		// send bullet impact
		if (  tr.surfaceFlags & SURF_NOIMPACT ) {
			return qfalse;
		}

		if ( traceEnt->takedamage) {
			damage = DEFAULT_SHOTGUN_DAMAGE * s_quadFactor;
#ifdef MISSIONPACK
			if ( traceEnt->client && traceEnt->client->invulnerabilityTime > level.time ) {
				if (G_InvulnerabilityEffect( traceEnt, forward, tr.endpos, impactpoint, bouncedir )) {
					G_BounceProjectile( tr_start, impactpoint, bouncedir, tr_end );
					VectorCopy( impactpoint, tr_start );
					// the player can hit him/herself with the bounced rail
					passent = ENTITYNUM_NONE;
				}
				else {
					VectorCopy( tr.endpos, tr_start );
					passent = traceEnt->s.number;
				}
				continue;
			}
			else {
				G_Damage( traceEnt, ent, ent, forward, tr.endpos,
					damage, 0, MOD_SHOTGUN);
				if( LogAccuracyHit( traceEnt, ent ) ) {
					return qtrue;
				}
			}
#else
			G_Damage( traceEnt, ent, ent, forward, tr.endpos,	damage, 0, MOD_SHOTGUN);
				if( LogAccuracyHit( traceEnt, ent ) ) {
					return qtrue;
				}
#endif
		}
		return qfalse;
	}
	return qfalse;
}

// this should match CG_ShotgunPattern
void ShotgunPattern( vec3_t origin, vec3_t origin2, int seed, gentity_t *ent ) {
	int			i;
	float		r, u;
	vec3_t		end;
	vec3_t		forward, right, up;
	int			oldScore;
	qboolean	hitClient = qfalse;

	// derive the right and up vectors from the forward vector, because
	// the client won't have any other information
	VectorNormalize2( origin2, forward );
	PerpendicularVector( right, forward );
	CrossProduct( forward, right, up );

	oldScore = ent->client->ps.persistant[PERS_SCORE];

	// generate the "random" spread pattern
	for ( i = 0 ; i < DEFAULT_SHOTGUN_COUNT ; i++ ) {
		r = Q_crandom( &seed ) * DEFAULT_SHOTGUN_SPREAD * 16;
		u = Q_crandom( &seed ) * DEFAULT_SHOTGUN_SPREAD * 16;
		VectorMA( origin, 8192 * 16, forward, end);
		VectorMA (end, r, right, end);
		VectorMA (end, u, up, end);
		if( ShotgunPellet( origin, end, ent ) && !hitClient ) {
			hitClient = qtrue;
			ent->client->accuracy_hits++;
		}
	}
}


void weapon_supershotgun_fire (gentity_t *ent) {
	gentity_t		*tent;

	// send shotgun blast
	tent = G_TempEntity( muzzle, EV_SHOTGUN );
	VectorScale( forward, 4096, tent->s.origin2 );
	SnapVector( tent->s.origin2 );
	tent->s.eventParm = rand() & 255;		// seed for spread pattern
	tent->s.otherEntityNum = ent->s.number;

	ShotgunPattern( tent->s.pos.trBase, tent->s.origin2, tent->s.eventParm, ent );
}


/*
======================================================================

GRENADE LAUNCHER

======================================================================
*/

void weapon_grenadelauncher_fire (gentity_t *ent) {
	gentity_t	*m;

	// extra vertical velocity
	forward[2] += 0.2f;
	VectorNormalize( forward );

	m = fire_grenade (ent, muzzle, forward);
	m->damage *= s_quadFactor;
	m->splashDamage *= s_quadFactor;

//	VectorAdd( m->s.pos.trDelta, ent->client->ps.velocity, m->s.pos.trDelta );	// "real" physics
}

/*
======================================================================

JUHOX: MONSTER LAUNCHER

======================================================================
*/

#if MONSTER_MODE
void weapon_monsterlauncher_fire(gentity_t* ent) {
	gentity_t* m;

	// extra vertical velocity
	forward[2] += 0.2f;
	/*
	{
		float spread;

		spread = 0.2;
		if (ent->client->ps.pm_flags & PMF_DUCKED) spread *= 0.25;
		forward[0] += crandom() * spread;
		forward[1] += crandom() * spread;
		forward[2] += crandom() * spread;
	}
	*/
	VectorNormalize(forward);

	m = fire_monster_seed(ent, muzzle, forward);
}
#endif

/*
======================================================================

ROCKET

======================================================================
*/

void Weapon_RocketLauncher_Fire (gentity_t *ent) {
	gentity_t	*m;

	m = fire_rocket (ent, muzzle, forward);
	m->damage *= s_quadFactor;
	m->splashDamage *= s_quadFactor;

//	VectorAdd( m->s.pos.trDelta, ent->client->ps.velocity, m->s.pos.trDelta );	// "real" physics
}


/*
======================================================================

PLASMA GUN

======================================================================
*/

void Weapon_Plasmagun_Fire (gentity_t *ent) {
	gentity_t	*m;

	m = fire_plasma (ent, muzzle, forward);
	m->damage *= s_quadFactor;
	m->splashDamage *= s_quadFactor;

//	VectorAdd( m->s.pos.trDelta, ent->client->ps.velocity, m->s.pos.trDelta );	// "real" physics
}

/*
======================================================================

RAILGUN

======================================================================
*/


/*
=================
weapon_railgun_fire
=================
*/
#define	MAX_RAIL_HITS	4
void weapon_railgun_fire (gentity_t *ent) {
	vec3_t		end;
#ifdef MISSIONPACK
	vec3_t impactpoint, bouncedir;
#endif
	trace_t		trace;
	gentity_t	*tent;
	gentity_t	*traceEnt;
	int			damage;
	int			i;
	int			hits;
	int			unlinked;
	int			passent;
	gentity_t	*unlinkedEntities[MAX_RAIL_HITS];

#if 0	// JUHOX: more railgun damage
	damage = 100 * s_quadFactor;
#else
	damage = 200;
#endif

	VectorMA (muzzle, 8192, forward, end);

	// trace only against the solids, so the railgun will go through people
	unlinked = 0;
	hits = 0;
	passent = ent->s.number;
	do {
		trap_Trace (&trace, muzzle, NULL, NULL, end, passent, MASK_SHOT );
		if ( trace.entityNum >= ENTITYNUM_MAX_NORMAL ) {
			break;
		}
		traceEnt = &g_entities[ trace.entityNum ];
		if ( traceEnt->takedamage ) {
#ifdef MISSIONPACK
			if ( traceEnt->client && traceEnt->client->invulnerabilityTime > level.time ) {
				if ( G_InvulnerabilityEffect( traceEnt, forward, trace.endpos, impactpoint, bouncedir ) ) {
					G_BounceProjectile( muzzle, impactpoint, bouncedir, end );
					// snap the endpos to integers to save net bandwidth, but nudged towards the line
					SnapVectorTowards( trace.endpos, muzzle );
					// send railgun beam effect
					tent = G_TempEntity( trace.endpos, EV_RAILTRAIL );
					// set player number for custom colors on the railtrail
					tent->s.clientNum = ent->s.clientNum;
					VectorCopy( muzzle, tent->s.origin2 );
					// move origin a bit to come closer to the drawn gun muzzle
					VectorMA( tent->s.origin2, 4, right, tent->s.origin2 );
					VectorMA( tent->s.origin2, -1, up, tent->s.origin2 );
					tent->s.eventParm = 255;	// don't make the explosion at the end
					//
					VectorCopy( impactpoint, muzzle );
					// the player can hit him/herself with the bounced rail
					passent = ENTITYNUM_NONE;
				}
			}
			else {
				if( LogAccuracyHit( traceEnt, ent ) ) {
					hits++;
				}
				G_Damage (traceEnt, ent, ent, forward, trace.endpos, damage, 0, MOD_RAILGUN);
			}
#else
				if( LogAccuracyHit( traceEnt, ent ) ) {
					hits++;
				}
				G_Damage (traceEnt, ent, ent, forward, trace.endpos, damage, 0, MOD_RAILGUN);
#endif
		}
		if ( trace.contents & CONTENTS_SOLID ) {
			break;		// we hit something solid enough to stop the beam
		}
		// unlink this entity, so the next trace will go past it
		trap_UnlinkEntity( traceEnt );
		unlinkedEntities[unlinked] = traceEnt;
		unlinked++;
	} while ( unlinked < MAX_RAIL_HITS );

	// link back in any entities we unlinked
	for ( i = 0 ; i < unlinked ; i++ ) {
		trap_LinkEntity( unlinkedEntities[i] );
	}

	// the final trace endpos will be the terminal point of the rail trail

	// snap the endpos to integers to save net bandwidth, but nudged towards the line
	SnapVectorTowards( trace.endpos, muzzle );

	// send railgun beam effect
	tent = G_TempEntity( trace.endpos, EV_RAILTRAIL );

	// set player number for custom colors on the railtrail
	tent->s.clientNum = ent->s.clientNum;

	VectorCopy( muzzle, tent->s.origin2 );
	// move origin a bit to come closer to the drawn gun muzzle
	VectorMA( tent->s.origin2, 4, right, tent->s.origin2 );
	VectorMA( tent->s.origin2, -1, up, tent->s.origin2 );

	// no explosion at end if SURF_NOIMPACT, but still make the trail
	if ( trace.surfaceFlags & SURF_NOIMPACT ) {
		tent->s.eventParm = 255;	// don't make the explosion at the end
	} else {
		tent->s.eventParm = DirToByte( trace.plane.normal );
	}
	tent->s.clientNum = ent->s.clientNum;

#if MONSTER_MODE	// JUHOX: no rewards in STU
	if (g_gametype.integer >= GT_STU) return;
#endif

	// give the shooter a reward sound if they have made two railgun hits in a row
	if ( hits == 0 ) {
		// complete miss
		ent->client->accurateCount = 0;
	} else {
		// check for "impressive" reward sound
		ent->client->accurateCount += hits;
		if ( ent->client->accurateCount >= 2 ) {
			ent->client->accurateCount -= 2;
			ent->client->ps.persistant[PERS_IMPRESSIVE_COUNT]++;
			// add the sprite over the player's head
			ent->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
			ent->client->ps.eFlags |= EF_AWARD_IMPRESSIVE;
			ent->client->rewardTime = level.time + REWARD_SPRITE_TIME;
		}
		ent->client->accuracy_hits++;
	}

}


/*
======================================================================

GRAPPLING HOOK

======================================================================
*/

void Weapon_GrapplingHook_Fire (gentity_t *ent)
{
#if GRAPPLE_ROPE
	if (g_grapple.integer <= HM_disabled || g_grapple.integer >= HM_num_modes) return;	// JUHOX
#endif

#if 0	// JUHOX: fire grappling hook
	if (/*!ent->client->fireHeld &&*/ !ent->client->hook)	// JUHOX
		fire_grapple (ent, muzzle, forward);
#else
	if (!ent->client->hook) {
		ent->client->offHandHook = qfalse;
		fire_grapple(ent, muzzle, forward);
	}
#endif

	ent->client->fireHeld = qtrue;
}

void CalcMuzzlePointOrigin(gentity_t *ent, vec3_t origin, vec3_t forward, vec3_t right, vec3_t up, vec3_t muzzlePoint);
/*
================
JUHOX: Weapon_GrapplingHook_Throw
================
*/
void Weapon_GrapplingHook_Throw(gentity_t* ent) {
#if GRAPPLE_ROPE
	if (g_grapple.integer <= HM_disabled || g_grapple.integer >= HM_num_modes) return;
#endif
#if ESCAPE_MODE
	if (g_gametype.integer == GT_EFH) return;
#endif

	if (!ent->client->hook) {
		AngleVectors(ent->client->ps.viewangles, forward, right, up);
		CalcMuzzlePointOrigin(ent, ent->client->oldOrigin, forward, right, up, muzzle);
		ent->client->offHandHook = qtrue;
		fire_grapple(ent, muzzle, forward);
		G_AddEvent(ent, EV_THROW_HOOK, 0);
	}
	else {
		Weapon_HookFree(ent->client->hook);
	}
}

void Weapon_HookFree (gentity_t *ent)
{
#if !GRAPPLE_ROPE
	ent->parent->client->hook = NULL;
	ent->parent->client->ps.pm_flags &= ~PMF_GRAPPLE_PULL;
	G_FreeEntity( ent );
#else
	if (!ent) return;
	if (ent->parent && ent->parent->client && ent->parent->client->hook == ent) {
		gclient_t* client;
		int i;

		client = ent->parent->client;
		if (!client->numRopeElements) {
			G_AddEvent(ent->parent, EV_ROPE_EXPLOSION, 1);	// click sound
		}
		for (i = 0; i < MAX_ROPE_ELEMENTS / 8; i++) {
			if (!client->ropeEntities[i]) continue;

			if (client->numRopeElements) {
				client->ropeEntities[i]->think = G_FreeEntity;
				client->ropeEntities[i]->nextthink = level.time + 1000;
				G_AddEvent(client->ropeEntities[i], EV_ROPE_EXPLOSION, 0);
				client->ropeEntities[i]->s.time = level.time;
			}
			else {
				G_FreeEntity(client->ropeEntities[i]);
			}
			client->ropeEntities[i] = NULL;
		}
		client->numRopeElements = 0;
		client->ps.stats[STAT_GRAPPLE_STATE] = GST_unused;

		client->hook = NULL;
		client->ps.pm_flags &= ~PMF_GRAPPLE_PULL;
	}
	G_FreeEntity(ent);
#endif
}

void Weapon_HookThink (gentity_t *ent)
{
#if 1	// JUHOX: update position of the hook attaching to a mover
	if (ent->enemy && ent->enemy->s.number >= MAX_CLIENTS) {
		vec3_t pos;

		VectorAdd(ent->enemy->r.currentOrigin, ent->movedir, pos);	// JUHOX FIXME: movedir abused
		G_SetOrigin(ent, pos);
	}
	else
#endif
	if (ent->enemy) {
		vec3_t v, oldorigin;

#if 1	// JUHOX BUGFIX: remove hook when player attached to dies
		if (ent->enemy->health <= 0) {
			Weapon_HookFree(ent);
			return;
		}
#endif
		VectorCopy(ent->r.currentOrigin, oldorigin);
		v[0] = ent->enemy->r.currentOrigin[0] + (ent->enemy->r.mins[0] + ent->enemy->r.maxs[0]) * 0.5;
		v[1] = ent->enemy->r.currentOrigin[1] + (ent->enemy->r.mins[1] + ent->enemy->r.maxs[1]) * 0.5;
		v[2] = ent->enemy->r.currentOrigin[2] + (ent->enemy->r.mins[2] + ent->enemy->r.maxs[2]) * 0.5;
		SnapVectorTowards( v, oldorigin );	// save net bandwidth

		G_SetOrigin( ent, v );
	}

	VectorCopy( ent->r.currentOrigin, ent->parent->client->ps.grapplePoint);
#if 1	// JUHOX BUGFIX: make hook think function called again next time
	ent->nextthink = level.time + FRAMETIME;
#endif
}

/*
======================================================================

LIGHTNING GUN

======================================================================
*/

/*
================
JUHOX: LightningVisibility
================
*/
static qboolean LightningVisibility(gentity_t* ent, gentity_t* target) {
	vec3_t origin;
	vec3_t forwardDir;
	vec3_t startPoint, endPoint;
	int i, n;
	float dist;
	vec3_t dir;

	VectorCopy(ent->s.pos.trBase, origin);
	origin[2] += 0.5 * DEFAULT_VIEWHEIGHT;
	VectorCopy(origin, startPoint);
	/*
	VectorCopy(target->s.pos.trBase, endPoint);
	endPoint[2] += 0.5 * DEFAULT_VIEWHEIGHT;
	*/
	VectorAdd(target->r.absmin, target->r.absmax, endPoint);
	VectorScale(endPoint, 0.5, endPoint);
	dist = Distance(origin, endPoint);
	VectorScale(forward, dist, forwardDir);
	n = 10;	// NOTE: same approximation as in the client [see CG_LightningBolt()]
	if (dist < 200) {
		n = dist / 20;
		if (n <= 0) n = 1;
	}
	dist /= n;	// segment length
	VectorSubtract(endPoint, startPoint, dir);

	for (i = 0; i < n; i++) {
		float x;
		vec3_t p1, p2;
		trace_t trace;

		x = (float)(i+1) / n;
		VectorMA(origin, x, forwardDir, p1);
		VectorMA(origin, x, dir, p2);
		VectorSubtract(p2, p1, p2);
		VectorMA(p1, x * x * x, p2, endPoint);

		trap_Trace(&trace, startPoint, NULL, NULL, endPoint, ent->s.number, MASK_SHOT);
		if (trace.fraction < 1) {
			return trace.entityNum == target->s.number;
		}

		VectorCopy(endPoint, startPoint);
	}
	return qtrue;
}

/*
================
JUHOX: GetLightningTarget
================
*/
static gentity_t* GetLightningTarget(gentity_t* ent) {
	int i;
	gentity_t* target;
	float totalWeight;
	vec3_t viewdir;

	target = NULL;
	totalWeight = 0;
	AngleVectors(ent->client->ps.viewangles, viewdir, NULL, NULL);
	for (i = 0; i < level.num_entities; i++) {
		gentity_t* other;
		playerState_t* ps;
		vec3_t dir;
		float distance;
		float alpha;
		float weight;

		other = &g_entities[i];
		if (!other->inuse) continue;
		if (!other->r.linked) continue;
		if (other->s.eType != ET_PLAYER) continue;
		ps = G_GetEntityPlayerState(other);
		if (!ps) continue;
		if (ps->pm_type != PM_NORMAL) continue;
		if (ps->stats[STAT_HEALTH] <= 0) continue;
#if MONSTER_MODE
		if (!G_CanBeDamaged(other)) continue;
#endif
		if (other->client) {
			if (other->client->pers.connected != CON_CONNECTED) continue;
			if (other == ent) continue;
		}
		if (
			g_gametype.integer >= GT_TEAM &&
			!g_friendlyFire.integer &&
			ent->client->sess.sessionTeam == ps->persistant[PERS_TEAM]
		) {
			continue;
		}

		VectorSubtract(ps->origin, ent->client->ps.origin, dir);
		distance = VectorNormalize(dir);
		if (distance > LIGHTNING_RANGE) continue;

		alpha = G_acos(DotProduct(dir, viewdir)) * (180.0 / M_PI);
		if (distance < 100) {
			alpha *= distance / 100.0;
		}
		if (alpha >= LIGHTNING_ALPHA_LIMIT) continue;

		if (!LightningVisibility(ent, other)) continue;

		weight = 10000.0/*arbitrary scale*/ / ((alpha + 10.0) * (distance + 100.0));
		totalWeight += weight;
		if (random() <= weight / totalWeight) {
			target = other;
		}
	}

	if (target) {
		ent->client->ps.stats[STAT_TARGET] = target->s.number;
		SetTargetPos(ent);
	}
	else {
		ent->client->ps.stats[STAT_TARGET] = ENTITYNUM_NONE;
	}
	return target;
}

/*
================
JUHOX: Weapon_LightningFire (new version)
================
*/
void Weapon_LightningFire(gentity_t* ent) {
	gentity_t* target;
	//gentity_t* tent;
	int t;
	playerState_t* ps;

	target = GetLightningTarget(ent);
	if (!target) return;

	if (LogAccuracyHit(target, ent)) {
		ent->client->accuracy_hits++;
	}

	// minimum damage for feedback
	//G_Damage(target, ent, ent, forward, target->client->ps.origin, 1, 0, MOD_LIGHTNING);
	if (target->client) {
		target->client->lasthurt_client = ent->s.number;
		target->client->lasthurt_mod = MOD_LIGHTNING;
		target->client->lasthurt_time = level.time;	// JUHOX
	}

	// charge the target
	//t = g_gametype.integer < GT_TEAM? 500 : 1000;
	t = 500;
#if MONSTER_MODE
	if (g_gametype.integer >= GT_STU) t = 2000;
#endif
	if (g_baseHealth.integer > 1) {	// consider handicap
		t = t * ent->client->ps.stats[STAT_MAX_HEALTH] / g_baseHealth.integer;
	}
	ps = G_GetEntityPlayerState(target);
	if (ps) {
		if (ps->powerups[PW_CHARGE]) {
			ps->powerups[PW_CHARGE] += t;
		}
		else {
			ps->powerups[PW_CHARGE] = level.time + t;
		}
		target->s.time2 = ps->powerups[PW_CHARGE];	// NOTE: time2 was unused before
		target->chargeInflictor = ent->s.number;	// for rewarding
	}
}

#if 0	// JUHOX: new version of Weapon_LightningFire() above
void Weapon_LightningFire( gentity_t *ent ) {
	trace_t		tr;
	vec3_t		end;
#ifdef MISSIONPACK
	vec3_t impactpoint, bouncedir;
#endif
	gentity_t	*traceEnt, *tent;
	int			damage, i, passent;

	damage = 8 * s_quadFactor;

	passent = ent->s.number;
	for (i = 0; i < 10; i++) {
		VectorMA( muzzle, LIGHTNING_RANGE, forward, end );

		trap_Trace( &tr, muzzle, NULL, NULL, end, passent, MASK_SHOT );

#ifdef MISSIONPACK
		// if not the first trace (the lightning bounced of an invulnerability sphere)
		if (i) {
			// add bounced off lightning bolt temp entity
			// the first lightning bolt is a cgame only visual
			//
			tent = G_TempEntity( muzzle, EV_LIGHTNINGBOLT );
			VectorCopy( tr.endpos, end );
			SnapVector( end );
			VectorCopy( end, tent->s.origin2 );
		}
#endif
		if ( tr.entityNum == ENTITYNUM_NONE ) {
			return;
		}

		traceEnt = &g_entities[ tr.entityNum ];

		if ( traceEnt->takedamage) {
#ifdef MISSIONPACK
			if ( traceEnt->client && traceEnt->client->invulnerabilityTime > level.time ) {
				if (G_InvulnerabilityEffect( traceEnt, forward, tr.endpos, impactpoint, bouncedir )) {
					G_BounceProjectile( muzzle, impactpoint, bouncedir, end );
					VectorCopy( impactpoint, muzzle );
					VectorSubtract( end, impactpoint, forward );
					VectorNormalize(forward);
					// the player can hit him/herself with the bounced lightning
					passent = ENTITYNUM_NONE;
				}
				else {
					VectorCopy( tr.endpos, muzzle );
					passent = traceEnt->s.number;
				}
				continue;
			}
			else {
				G_Damage( traceEnt, ent, ent, forward, tr.endpos,
					damage, 0, MOD_LIGHTNING);
			}
#else
				G_Damage( traceEnt, ent, ent, forward, tr.endpos,
					damage, 0, MOD_LIGHTNING);
#endif
		}

#if 0	// JUHOX BUGFIX: let corpses bleed too (& monsters)
		if ( traceEnt->takedamage && traceEnt->client ) {
#else
		if (traceEnt->takedamage && traceEnt->s.eType == ET_PLAYER) {
#endif
			tent = G_TempEntity( tr.endpos, EV_MISSILE_HIT );
			tent->s.otherEntityNum = traceEnt->s.number;
			tent->s.eventParm = DirToByte( tr.plane.normal );
			tent->s.weapon = ent->s.weapon;
			if( LogAccuracyHit( traceEnt, ent ) ) {
				ent->client->accuracy_hits++;
			}
		} else if ( !( tr.surfaceFlags & SURF_NOIMPACT ) ) {
			tent = G_TempEntity( tr.endpos, EV_MISSILE_MISS );
			tent->s.eventParm = DirToByte( tr.plane.normal );
		}

		break;
	}
}
#endif

#ifdef MISSIONPACK
/*
======================================================================

NAILGUN

======================================================================
*/

void Weapon_Nailgun_Fire (gentity_t *ent) {
	gentity_t	*m;
	int			count;

	for( count = 0; count < NUM_NAILSHOTS; count++ ) {
		m = fire_nail (ent, muzzle, forward, right, up );
		if (!m) return;	// JUHOX BUGFIX
		m->damage *= s_quadFactor;
		m->splashDamage *= s_quadFactor;
	}

//	VectorAdd( m->s.pos.trDelta, ent->client->ps.velocity, m->s.pos.trDelta );	// "real" physics
}


/*
======================================================================

PROXIMITY MINE LAUNCHER

======================================================================
*/

void weapon_proxlauncher_fire (gentity_t *ent) {
	gentity_t	*m;

	// extra vertical velocity
	forward[2] += 0.2f;
	VectorNormalize( forward );

	m = fire_prox (ent, muzzle, forward);
	if (!m) return;	// JUHOX BUGFIX
	m->damage *= s_quadFactor;
	m->splashDamage *= s_quadFactor;

//	VectorAdd( m->s.pos.trDelta, ent->client->ps.velocity, m->s.pos.trDelta );	// "real" physics
}

#endif

//======================================================================


/*
===============
LogAccuracyHit
===============
*/
qboolean LogAccuracyHit( gentity_t *target, gentity_t *attacker ) {
	if( !target->takedamage ) {
		return qfalse;
	}

	if ( target == attacker ) {
		return qfalse;
	}

	if( !target->client ) {
		return qfalse;
	}

	if( !attacker->client ) {
		return qfalse;
	}

	if( target->client->ps.stats[STAT_HEALTH] <= 0 ) {
		return qfalse;
	}

	if ( OnSameTeam( target, attacker ) ) {
		return qfalse;
	}

	return qtrue;
}


/*
===============
CalcMuzzlePoint

set muzzle location relative to pivoting eye
===============
*/
void CalcMuzzlePoint ( gentity_t *ent, vec3_t forward, vec3_t right, vec3_t up, vec3_t muzzlePoint ) {
	VectorCopy( ent->s.pos.trBase, muzzlePoint );
#if !MONSTER_MODE	// JUHOX: accept monsters
	muzzlePoint[2] += ent->client->ps.viewheight;
#else
	muzzlePoint[2] += G_GetEntityPlayerState(ent)->viewheight;
#endif
#if 0	// JUHOX: don't move muzzle point for hit-scan weapons
	VectorMA( muzzlePoint, 14, forward, muzzlePoint );
#else
	if (
		ent->s.weapon != WP_MACHINEGUN &&
		ent->s.weapon != WP_SHOTGUN &&
		ent->s.weapon != WP_LIGHTNING &&
		ent->s.weapon != WP_RAILGUN
	) {
		VectorMA(muzzlePoint, 14, forward, muzzlePoint);	
	}
#endif
	// snap to integer coordinates for more efficient network bandwidth usage
	SnapVector( muzzlePoint );
}

/*
===============
CalcMuzzlePointOrigin

set muzzle location relative to pivoting eye
===============
*/
void CalcMuzzlePointOrigin ( gentity_t *ent, vec3_t origin, vec3_t forward, vec3_t right, vec3_t up, vec3_t muzzlePoint ) {
	VectorCopy( ent->s.pos.trBase, muzzlePoint );
#if !MONSTER_MODE	// JUHOX: accept monsters
	muzzlePoint[2] += ent->client->ps.viewheight;
#else
	muzzlePoint[2] += G_GetEntityPlayerState(ent)->viewheight;
#endif
#if 0	// JUHOX: don't move muzzle point for hit-scan weapons
	VectorMA( muzzlePoint, 14, forward, muzzlePoint );
#else
	if (
		ent->s.weapon != WP_MACHINEGUN &&
		ent->s.weapon != WP_SHOTGUN &&
		ent->s.weapon != WP_LIGHTNING &&
		ent->s.weapon != WP_RAILGUN
	) {
		VectorMA(muzzlePoint, 14, forward, muzzlePoint);	
	}
#endif
	// snap to integer coordinates for more efficient network bandwidth usage
	SnapVector( muzzlePoint );
}



/*
===============
FireWeapon
===============
*/
void FireWeapon( gentity_t *ent ) {
#if 0	// JUHOX: ignore quad
	if (ent->client->ps.powerups[PW_QUAD] ) {
		s_quadFactor = g_quadfactor.value;
	} else {
		s_quadFactor = 1;
	}
#else
	s_quadFactor = 1;
#endif
#ifdef MISSIONPACK
	if( ent->client->persistantPowerup && ent->client->persistantPowerup->item && ent->client->persistantPowerup->item->giTag == PW_DOUBLER ) {
		s_quadFactor *= 2;
	}
#endif

	// track shots taken for accuracy tracking.  Grapple is not a weapon and gauntet is just not tracked
	if( ent->s.weapon != WP_GRAPPLING_HOOK && ent->s.weapon != WP_GAUNTLET ) {
#ifdef MISSIONPACK
		if( ent->s.weapon == WP_NAILGUN ) {
			ent->client->accuracy_shots += NUM_NAILSHOTS;
		} else {
			ent->client->accuracy_shots++;
		}
#else
		ent->client->accuracy_shots++;
#endif
	}

	// set aiming directions
	AngleVectors (ent->client->ps.viewangles, forward, right, up);

	CalcMuzzlePointOrigin ( ent, ent->client->oldOrigin, forward, right, up, muzzle );

	// fire the specific weapon
	switch( ent->s.weapon ) {
	case WP_GAUNTLET:
		Weapon_Gauntlet( ent );
		break;
	case WP_LIGHTNING:
		Weapon_LightningFire( ent );
		break;
	case WP_SHOTGUN:
		weapon_supershotgun_fire( ent );
		break;
	case WP_MACHINEGUN:
		if ( g_gametype.integer != GT_TEAM ) {
			Bullet_Fire( ent, MACHINEGUN_SPREAD, MACHINEGUN_DAMAGE );
		} else {
			Bullet_Fire( ent, MACHINEGUN_SPREAD, MACHINEGUN_TEAM_DAMAGE );
		}
		break;
	case WP_GRENADE_LAUNCHER:
		weapon_grenadelauncher_fire( ent );
		break;
	case WP_ROCKET_LAUNCHER:
		Weapon_RocketLauncher_Fire( ent );
		break;
	case WP_PLASMAGUN:
		Weapon_Plasmagun_Fire( ent );
		break;
	case WP_RAILGUN:
		weapon_railgun_fire( ent );
		break;
	case WP_BFG:
		BFG_Fire( ent );
		break;
	case WP_GRAPPLING_HOOK:
		Weapon_GrapplingHook_Fire( ent );
		break;
#if MONSTER_MODE	// JUHOX: fire monster launcher
	case WP_MONSTER_LAUNCHER:
		weapon_monsterlauncher_fire(ent);
		break;
#endif
#ifdef MISSIONPACK
	case WP_NAILGUN:
		Weapon_Nailgun_Fire( ent );
		break;
	case WP_PROX_LAUNCHER:
		weapon_proxlauncher_fire( ent );
		break;
	case WP_CHAINGUN:
		Bullet_Fire( ent, CHAINGUN_SPREAD, MACHINEGUN_DAMAGE );
		break;
#endif
	default:
// FIXME		G_Error( "Bad ent->s.weapon" );
		break;
	}
}


#ifdef MISSIONPACK

/*
===============
KamikazeRadiusDamage
===============
*/
static void KamikazeRadiusDamage( vec3_t origin, gentity_t *attacker, float damage, float radius ) {
	float		dist;
	gentity_t	*ent;
	int			entityList[MAX_GENTITIES];
	int			numListedEntities;
	vec3_t		mins, maxs;
	vec3_t		v;
	vec3_t		dir;
	int			i, e;

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

		if (!ent->takedamage) {
			continue;
		}

		// dont hit things we have already hit
		if( ent->kamikazeTime > level.time ) {
			continue;
		}

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

//		if( CanDamage (ent, origin) ) {
			VectorSubtract (ent->r.currentOrigin, origin, dir);
			// push the center of mass higher than the origin so players
			// get knocked into the air more
			dir[2] += 24;
			G_Damage( ent, NULL, attacker, dir, origin, damage, DAMAGE_RADIUS|DAMAGE_NO_TEAM_PROTECTION, MOD_KAMIKAZE );
			ent->kamikazeTime = level.time + 3000;
//		}
	}
}

/*
===============
KamikazeShockWave
===============
*/
static void KamikazeShockWave( vec3_t origin, gentity_t *attacker, float damage, float push, float radius ) {
	float		dist;
	gentity_t	*ent;
	int			entityList[MAX_GENTITIES];
	int			numListedEntities;
	vec3_t		mins, maxs;
	vec3_t		v;
	vec3_t		dir;
	int			i, e;

	if ( radius < 1 )
		radius = 1;

	for ( i = 0 ; i < 3 ; i++ ) {
		mins[i] = origin[i] - radius;
		maxs[i] = origin[i] + radius;
	}

	numListedEntities = trap_EntitiesInBox( mins, maxs, entityList, MAX_GENTITIES );

	for ( e = 0 ; e < numListedEntities ; e++ ) {
		ent = &g_entities[entityList[ e ]];

		// dont hit things we have already hit
		if( ent->kamikazeShockTime > level.time ) {
			continue;
		}

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

//		if( CanDamage (ent, origin) ) {
			VectorSubtract (ent->r.currentOrigin, origin, dir);
			dir[2] += 24;
			G_Damage( ent, NULL, attacker, dir, origin, damage, DAMAGE_RADIUS|DAMAGE_NO_TEAM_PROTECTION, MOD_KAMIKAZE );
			//
			dir[2] = 0;
			VectorNormalize(dir);
			if ( ent->client ) {
				ent->client->ps.velocity[0] = dir[0] * push;
				ent->client->ps.velocity[1] = dir[1] * push;
				ent->client->ps.velocity[2] = 100;
			}
			ent->kamikazeShockTime = level.time + 3000;
//		}
	}
}

/*
===============
KamikazeDamage
===============
*/
static void KamikazeDamage( gentity_t *self ) {
	int i;
	float t;
	gentity_t *ent;
	vec3_t newangles;

	self->count += 100;

	if (self->count >= KAMI_SHOCKWAVE_STARTTIME) {
		// shockwave push back
		t = self->count - KAMI_SHOCKWAVE_STARTTIME;
		KamikazeShockWave(self->s.pos.trBase, self->activator, 25, 400,	(int) (float) t * KAMI_SHOCKWAVE_MAXRADIUS / (KAMI_SHOCKWAVE_ENDTIME - KAMI_SHOCKWAVE_STARTTIME) );
	}
	//
	if (self->count >= KAMI_EXPLODE_STARTTIME) {
		// do our damage
		t = self->count - KAMI_EXPLODE_STARTTIME;
		KamikazeRadiusDamage( self->s.pos.trBase, self->activator, 400,	(int) (float) t * KAMI_BOOMSPHERE_MAXRADIUS / (KAMI_IMPLODE_STARTTIME - KAMI_EXPLODE_STARTTIME) );
	}

	// either cycle or kill self
	if( self->count >= KAMI_SHOCKWAVE_ENDTIME ) {
		G_FreeEntity( self );
		return;
	}
	self->nextthink = level.time + 100;

	// add earth quake effect
	newangles[0] = crandom() * 2;
	newangles[1] = crandom() * 2;
	newangles[2] = 0;
	for (i = 0; i < MAX_CLIENTS; i++)
	{
		ent = &g_entities[i];
		if (!ent->inuse)
			continue;
		if (!ent->client)
			continue;

		if (ent->client->ps.groundEntityNum != ENTITYNUM_NONE) {
			ent->client->ps.velocity[0] += crandom() * 120;
			ent->client->ps.velocity[1] += crandom() * 120;
			ent->client->ps.velocity[2] = 30 + random() * 25;
		}

		ent->client->ps.delta_angles[0] += ANGLE2SHORT(newangles[0] - self->movedir[0]);
		ent->client->ps.delta_angles[1] += ANGLE2SHORT(newangles[1] - self->movedir[1]);
		ent->client->ps.delta_angles[2] += ANGLE2SHORT(newangles[2] - self->movedir[2]);
	}
	VectorCopy(newangles, self->movedir);
}

/*
===============
G_StartKamikaze
===============
*/
void G_StartKamikaze( gentity_t *ent ) {
	gentity_t	*explosion;
	gentity_t	*te;
	vec3_t		snapped;

	// start up the explosion logic
	explosion = G_Spawn();

	explosion->s.eType = ET_EVENTS + EV_KAMIKAZE;
	explosion->eventTime = level.time;

	if ( ent->client ) {
		VectorCopy( ent->s.pos.trBase, snapped );
	}
	else {
		VectorCopy( ent->activator->s.pos.trBase, snapped );
	}
	SnapVector( snapped );		// save network bandwidth
	G_SetOrigin( explosion, snapped );

	explosion->classname = "kamikaze";
	explosion->s.pos.trType = TR_STATIONARY;

	explosion->kamikazeTime = level.time;

	explosion->think = KamikazeDamage;
	explosion->nextthink = level.time + 100;
	explosion->count = 0;
	VectorClear(explosion->movedir);

	trap_LinkEntity( explosion );

	if (ent->client) {
		//
		explosion->activator = ent;
		//
		ent->s.eFlags &= ~EF_KAMIKAZE;
		// nuke the guy that used it
		G_Damage( ent, ent, ent, NULL, NULL, 100000, DAMAGE_NO_PROTECTION, MOD_KAMIKAZE );
	}
	else {
		if ( !strcmp(ent->activator->classname, "bodyque") ) {
			explosion->activator = &g_entities[ent->activator->r.ownerNum];
		}
		else {
			explosion->activator = ent->activator;
		}
	}

	// play global sound at all clients
	te = G_TempEntity(snapped, EV_GLOBAL_TEAM_SOUND );
	te->r.svFlags |= SVF_BROADCAST;
	te->s.eventParm = GTS_KAMIKAZE;
}
#endif
