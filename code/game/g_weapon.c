// Copyright (C) 1999-2000 Id Software, Inc.
//
// g_weapon.c
// perform the server side effects of a weapon firing

#include "g_local.h"

static	float	s_quadFactor;
static	vec3_t	forward, right, up;
static	vec3_t	muzzle;

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
	AngleVectors(G_GetEntityPlayerState(ent)->viewangles, forward, right, up);

	CalcMuzzlePoint ( ent, forward, right, up, muzzle );

	VectorMA(muzzle, 32 + fabs(forward[2]) * 20, forward, end);

	trap_Trace (&tr, muzzle, NULL, NULL, end, ent->s.number, MASK_SHOT);
	if ( tr.surfaceFlags & SURF_NOIMPACT ) {
		return qfalse;
	}

	traceEnt = &g_entities[ tr.entityNum ];

	// send blood impact
	// JUHOX: the new gauntlet is so fast, not every hit should give a blood impact
	// JUHOX BUGFIX: let bleed corpses too (& monsters)

	if (
		traceEnt->takedamage &&
		traceEnt->s.eType == ET_PLAYER &&
		( ent->monster || random() < 0.05 )	) {
            tent = G_TempEntity( tr.endpos, EV_MISSILE_HIT );
            tent->s.otherEntityNum = traceEnt->s.number;
            tent->s.eventParm = DirToByte( tr.plane.normal );
            tent->s.weapon = ent->s.weapon;
	}

	if ( !traceEnt->takedamage) {
		return qfalse;
	}

	// JUHOX: don't let monsters hit other monsters
	if (
		ent->monster &&
		traceEnt->monster &&
		G_IsFriendlyMonster(ent, traceEnt)
	) return qfalse;

	s_quadFactor = 1;

	damage = 10;	// note that the gauntlet is much faster now

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

	return qtrue;
}

/*
===============
JUHOX: CheckTitanAttack
===============
*/
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
void SnapVectorTowards(vec3_t v, const vec3_t to) {
	int	i;

	for ( i = 0 ; i < 3 ; i++ ) {
		if ( to[i] <= v[i] ) {
			v[i] = (int)v[i];
		} else {
			v[i] = (int)v[i] + 1;
		}
	}
}

#define MACHINEGUN_SPREAD	200
#define	MACHINEGUN_DAMAGE	7
#define	MACHINEGUN_TEAM_DAMAGE	5		// wimpier MG in teamplay

void Bullet_Fire (gentity_t *ent, float spread, int damage ) {
	trace_t		tr;
	vec3_t		end;
	gentity_t	*tent;
	gentity_t	*traceEnt;
	int			i, passent;

	// JUHOX: more machine gun damage
	damage = 20;
	damage *= s_quadFactor;

	VectorMA(muzzle, 8192*16, forward, end);

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
		if (traceEnt->takedamage && traceEnt->s.eType == ET_PLAYER) {
			tent = G_TempEntity( tr.endpos, EV_BULLET_HIT_FLESH );

			tent->s.otherEntityNum2 = traceEnt->s.number;

			if( LogAccuracyHit( traceEnt, ent ) ) {
				ent->client->accuracy_hits++;
			}
		} else {
			tent = G_TempEntity( tr.endpos, EV_BULLET_HIT_WALL );
			tent->s.eventParm = DirToByte( tr.plane.normal );
		}
		tent->s.otherEntityNum = ent->s.number;

		if ( traceEnt->takedamage) {
				G_Damage( traceEnt, ent, ent, forward, tr.endpos,
					damage, 0, MOD_MACHINEGUN);
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
			G_Damage( traceEnt, ent, ent, forward, tr.endpos,	damage, 0, MOD_SHOTGUN);
				if( LogAccuracyHit( traceEnt, ent ) ) {
					return qtrue;
				}
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
}

/*
======================================================================

JUHOX: MONSTER LAUNCHER

======================================================================
*/
void weapon_monsterlauncher_fire(gentity_t* ent) {
	gentity_t* m;

	// extra vertical velocity
	forward[2] += 0.2f;
	VectorNormalize(forward);

	m = fire_monster_seed(ent, muzzle, forward);
}


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

VectorAdd( m->s.pos.trDelta, ent->client->ps.velocity, m->s.pos.trDelta );	// "real" physics
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
	trace_t		trace;
	gentity_t	*tent;
	gentity_t	*traceEnt;
	int			damage;
	int			i;
	int			hits;
	int			unlinked;
	int			passent;
	gentity_t	*unlinkedEntities[MAX_RAIL_HITS];

	damage = 200;

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
				if( LogAccuracyHit( traceEnt, ent ) ) {
					hits++;
				}
				G_Damage (traceEnt, ent, ent, forward, trace.endpos, damage, 0, MOD_RAILGUN);
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

	// JUHOX: no rewards in STU
	if (g_gametype.integer >= GT_STU) return;

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
	if (g_grapple.integer <= HM_disabled || g_grapple.integer >= HM_num_modes) return;	// JUHOX

	if (!ent->client->hook) {
		ent->client->offHandHook = qfalse;
		fire_grapple(ent, muzzle, forward);
	}

	ent->client->fireHeld = qtrue;
}

void CalcMuzzlePointOrigin(gentity_t *ent, vec3_t origin, vec3_t forward, vec3_t right, vec3_t up, vec3_t muzzlePoint);
/*
================
JUHOX: Weapon_GrapplingHook_Throw
================
*/
void Weapon_GrapplingHook_Throw(gentity_t* ent) {

	if (g_grapple.integer <= HM_disabled || g_grapple.integer >= HM_num_modes) return;
	if (g_gametype.integer == GT_EFH) return;

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
		//client->ps.stats[STAT_GRAPPLE_STATE] = GST_unused;
		SET_STAT_GRAPPLESTATE (&client->ps, GST_unused);

		client->hook = NULL;
		client->ps.pm_flags &= ~PMF_GRAPPLE_PULL;
	}
	G_FreeEntity(ent);
}

void Weapon_HookThink (gentity_t *ent)
{
	// JUHOX: update position of the hook attaching to a mover
	if (ent->enemy && ent->enemy->s.number >= MAX_CLIENTS) {
		vec3_t pos;

		VectorAdd(ent->enemy->r.currentOrigin, ent->movedir, pos);	// JUHOX FIXME: movedir abused
		G_SetOrigin(ent, pos);
	}
	else

	if (ent->enemy) {
		vec3_t v, oldorigin;

        // JUHOX BUGFIX: remove hook when player attached to dies
		if (ent->enemy->health <= 0) {
			Weapon_HookFree(ent);
			return;
		}

		VectorCopy(ent->r.currentOrigin, oldorigin);
		v[0] = ent->enemy->r.currentOrigin[0] + (ent->enemy->r.mins[0] + ent->enemy->r.maxs[0]) * 0.5;
		v[1] = ent->enemy->r.currentOrigin[1] + (ent->enemy->r.mins[1] + ent->enemy->r.maxs[1]) * 0.5;
		v[2] = ent->enemy->r.currentOrigin[2] + (ent->enemy->r.mins[2] + ent->enemy->r.maxs[2]) * 0.5;
		SnapVectorTowards( v, oldorigin );	// save net bandwidth

		G_SetOrigin( ent, v );
	}

	VectorCopy( ent->r.currentOrigin, ent->parent->client->ps.grapplePoint);
	// JUHOX BUGFIX: make hook think function called again next time
	ent->nextthink = level.time + FRAMETIME;
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
		if (!G_CanBeDamaged(other)) continue;

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

	int t;
	playerState_t* ps;

	target = GetLightningTarget(ent);
	if (!target) return;

	if (LogAccuracyHit(target, ent)) {
		ent->client->accuracy_hits++;
	}

	// minimum damage for feedback
	if (target->client) {
		target->client->lasthurt_client = ent->s.number;
		target->client->lasthurt_mod = MOD_LIGHTNING;
		target->client->lasthurt_time = level.time;	// JUHOX
	}

	// charge the target
	t = 500;

	if (g_gametype.integer >= GT_STU) t = 2000;

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

	muzzlePoint[2] += G_GetEntityPlayerState(ent)->viewheight;

	if (
		ent->s.weapon != WP_MACHINEGUN &&
		ent->s.weapon != WP_SHOTGUN &&
		ent->s.weapon != WP_LIGHTNING &&
		ent->s.weapon != WP_RAILGUN
	) {
		VectorMA(muzzlePoint, 14, forward, muzzlePoint);
	}

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

	muzzlePoint[2] += G_GetEntityPlayerState(ent)->viewheight;

	if (
		ent->s.weapon != WP_MACHINEGUN &&
		ent->s.weapon != WP_SHOTGUN &&
		ent->s.weapon != WP_LIGHTNING &&
		ent->s.weapon != WP_RAILGUN
	) {
		VectorMA(muzzlePoint, 14, forward, muzzlePoint);
	}

	// snap to integer coordinates for more efficient network bandwidth usage
	SnapVector( muzzlePoint );
}



/*
===============
FireWeapon
===============
*/
void FireWeapon( gentity_t *ent ) {
	s_quadFactor = 1;

	// track shots taken for accuracy tracking.  Grapple is not a weapon and gauntet is just not tracked
	if( ent->s.weapon != WP_GRAPPLING_HOOK && ent->s.weapon != WP_GAUNTLET ) {
		ent->client->accuracy_shots++;
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
	case WP_MONSTER_LAUNCHER:
		weapon_monsterlauncher_fire(ent);
		break;
	default:
		break;
	}
}
