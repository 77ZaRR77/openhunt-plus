// Copyright (C) 1999-2000 Id Software, Inc.
//
// bg_pmove.c -- both games player movement code
// takes a playerstate and a usercmd as input and returns a modifed playerstate

#include "q_shared.h"
#include "bg_public.h"
#include "bg_local.h"
#include "bg_promode.h" // SLK

pmove_t		*pm;
pml_t		pml;

// movement parameters
float	pm_stopspeed = 100.0f;
float	pm_duckScale = 0.25f;
float	pm_swimScale = 0.50f;
float	pm_wadeScale = 0.70f;

float	pm_accelerate = 10.0f;
float	pm_airaccelerate = 1.0f;
float	pm_wateraccelerate = 4.0f;
float	pm_flyaccelerate = 8.0f;

float	pm_friction = 6.0f;
float	pm_waterfriction = 1.0f;
float	pm_flightfriction = 3.0f;
float	pm_spectatorfriction = 5.0f;

int		c_pmove = 0;


/*
===============
PM_AddEvent

===============
*/
void PM_AddEvent( int newEvent ) {

	if (!newEvent) return; // JUHOX BUGFIX: don't add zero event
	BG_AddPredictableEventToPlayerstate( newEvent, 0, pm->ps );
}

/*
===============
PM_AddTouchEnt
===============
*/
void PM_AddTouchEnt( int entityNum ) {
	int		i;

	if ( entityNum == ENTITYNUM_WORLD ) return;
	if ( pm->numtouch == MAXTOUCH ) return;

	// see if it is already added
	for ( i = 0 ; i < pm->numtouch ; i++ ) {
		if ( pm->touchents[ i ] == entityNum ) return;
	}

	// add it
	pm->touchents[pm->numtouch] = entityNum;
	pm->numtouch++;
}

/*
===================
PM_StartTorsoAnim
===================
*/
static void PM_StartTorsoAnim( int anim ) {

	if ( pm->ps->pm_type >= PM_DEAD ) return;
	pm->ps->torsoAnim = ( ( pm->ps->torsoAnim & ANIM_TOGGLEBIT ) ^ ANIM_TOGGLEBIT ) | anim;
}

static void PM_StartLegsAnim( int anim ) {

	if ( pm->ps->pm_type >= PM_DEAD ) return;
	if ( pm->ps->legsTimer > 0 ) return;		// a high priority animation is running

	pm->ps->legsAnim = ( ( pm->ps->legsAnim & ANIM_TOGGLEBIT ) ^ ANIM_TOGGLEBIT ) | anim;
}

static void PM_ContinueLegsAnim( int anim ) {

	if ( ( pm->ps->legsAnim & ~ANIM_TOGGLEBIT ) == anim ) return;
	if ( pm->ps->legsTimer > 0 ) return;		// a high priority animation is running

	PM_StartLegsAnim ( anim );
}

static void PM_ContinueTorsoAnim( int anim ) {

	if ( ( pm->ps->torsoAnim & ~ANIM_TOGGLEBIT ) == anim ) return;
	if ( pm->ps->torsoTimer > 0 ) return;		// a high priority animation is running

	PM_StartTorsoAnim ( anim );
}

static void PM_ForceLegsAnim( int anim ) {
	pm->ps->legsTimer = 0;
	PM_StartLegsAnim ( anim );
}


/*
==================
PM_ClipVelocity

Slide off of the impacting surface
==================
*/
void PM_ClipVelocity( vec3_t in, vec3_t normal, vec3_t out, float overbounce ) {
	float	backoff;
	float	change;
	int		i;

	backoff = DotProduct (in, normal);

	if ( backoff < 0 ) {
		backoff *= overbounce;
	} else {
		backoff /= overbounce;
	}

	for ( i=0 ; i<3 ; i++ ) {
		change = normal[i]*backoff;
		out[i] = in[i] - change;
	}
}


/*
==================
PM_Friction

Handles both ground friction and water friction
==================
*/
static void PM_Friction( void ) {
	vec3_t	vec;
	float	*vel;
	float	speed, newspeed, control;
	float	drop;

	vel = pm->ps->velocity;

	VectorCopy( vel, vec );
	if ( pml.walking ) vec[2] = 0;	// ignore slope movement

	speed = VectorLength(vec);
	if (speed < 1) {
		vel[0] = 0;
		vel[1] = 0;		// allow sinking underwater
		// FIXME: still have z friction underwater?
		if (pm->ps->pm_type == PM_SPECTATOR) vel[2] = 0;	// JUHOX
		return;
	}

	drop = 0;

	// apply ground friction
	if ( pm->waterlevel <= 1 ) {
		if ( pml.walking && !(pml.groundTrace.surfaceFlags & SURF_SLICK) ) {
			// if getting knocked back, no friction
			if ( ! (pm->ps->pm_flags & PMF_TIME_KNOCKBACK) ) {
				control = speed < pm_stopspeed ? pm_stopspeed : speed;
				drop += control*pm_friction*pml.frametime;
			}
		}
	}

	// apply water friction even if just wading
	if ( pm->waterlevel ) {
		drop += speed*pm_waterfriction*pm->waterlevel*pml.frametime;
	}

	// apply flying friction
	if ( pm->ps->powerups[PW_FLIGHT]) {
		drop += speed*pm_flightfriction*pml.frametime;
	}

	if ( pm->ps->pm_type == PM_SPECTATOR) {
		drop += speed*pm_spectatorfriction*pml.frametime;
	}

	drop /= pm->scale; // JUHOX: scale friction by player size to simulate inertia

	// scale the velocity
	newspeed = speed - drop;
	if (newspeed < 0) {
		newspeed = 0;
	}
	newspeed /= speed;

	vel[0] = vel[0] * newspeed;
	vel[1] = vel[1] * newspeed;
	vel[2] = vel[2] * newspeed;
}


/*
==============
PM_Accelerate

Handles user intended acceleration
==============
*/
static void PM_Accelerate( vec3_t wishdir, float wishspeed, float accel ) {

	// JUHOX: players loose speed if near total weariness
	if (pm->ps->stats[STAT_STRENGTH] < LOW_STRENGTH_VALUE) {
		wishspeed *= 0.55 + 0.45 * pm->ps->stats[STAT_STRENGTH] / LOW_STRENGTH_VALUE;
	}


	// JUHOX: spectators have infinite acceleration
	if (pm->ps->pm_type == PM_SPECTATOR) {
		VectorScale(wishdir, wishspeed, pm->ps->velocity);
		return;
	}

	{	// JUHOX: so variable declaration works


	// q2 style
	int			i;
	float		addspeed, accelspeed, currentspeed;

	currentspeed = DotProduct (pm->ps->velocity, wishdir);
	addspeed = wishspeed - currentspeed;
	if (addspeed <= 0) {
		return;
	}
	accelspeed = accel*pml.frametime*wishspeed;
	// JUHOX: scale acceleration by size to simulate inertia
	accelspeed /= pm->scale;
	if (accelspeed > addspeed) {
		accelspeed = addspeed;
	}

	for (i=0 ; i<3 ; i++) {
		pm->ps->velocity[i] += accelspeed*wishdir[i];
	}

	}	// JUHOX: see above
}



/*
============
PM_CmdScale

Returns the scale factor to apply to cmd movements
This allows the clients to use axial -127 to 127 values for all directions
without getting a sqrt(2) distortion in speed.
============
*/
static float PM_CmdScale( usercmd_t *cmd ) {
	int		max;
	float	total;
	float	scale;

	max = abs( cmd->forwardmove );
	if ( abs( cmd->rightmove ) > max ) {
		max = abs( cmd->rightmove );
	}
	if ( abs( cmd->upmove ) > max ) {
		max = abs( cmd->upmove );
	}
	if ( !max ) return 0;


	total = sqrt( cmd->forwardmove * cmd->forwardmove + cmd->rightmove * cmd->rightmove + cmd->upmove * cmd->upmove );
	scale = (float)pm->ps->speed * max / ( 127.0 * total );

	return scale;
}


/*
================
PM_SetMovementDir

Determine the rotation of the legs reletive
to the facing dir
================
*/
static void PM_SetMovementDir( void ) {
	if ( pm->cmd.forwardmove || pm->cmd.rightmove ) {
		if ( pm->cmd.rightmove == 0 && pm->cmd.forwardmove > 0 ) {
			pm->ps->movementDir = 0;
		} else if ( pm->cmd.rightmove < 0 && pm->cmd.forwardmove > 0 ) {
			pm->ps->movementDir = 1;
		} else if ( pm->cmd.rightmove < 0 && pm->cmd.forwardmove == 0 ) {
			pm->ps->movementDir = 2;
		} else if ( pm->cmd.rightmove < 0 && pm->cmd.forwardmove < 0 ) {
			pm->ps->movementDir = 3;
		} else if ( pm->cmd.rightmove == 0 && pm->cmd.forwardmove < 0 ) {
			pm->ps->movementDir = 4;
		} else if ( pm->cmd.rightmove > 0 && pm->cmd.forwardmove < 0 ) {
			pm->ps->movementDir = 5;
		} else if ( pm->cmd.rightmove > 0 && pm->cmd.forwardmove == 0 ) {
			pm->ps->movementDir = 6;
		} else if ( pm->cmd.rightmove > 0 && pm->cmd.forwardmove > 0 ) {
			pm->ps->movementDir = 7;
		}
	} else {
		// if they aren't actively going directly sideways,
		// change the animation to the diagonal so they
		// don't stop too crooked
		if ( pm->ps->movementDir == 2 ) {
			pm->ps->movementDir = 1;
		} else if ( pm->ps->movementDir == 6 ) {
			pm->ps->movementDir = 7;
		}
	}
}


/*
=============
PM_CheckJump
=============
*/
static qboolean PM_CheckJump( void ) {

	if ( pm->ps->pm_flags & PMF_RESPAWNED ) return qfalse;		// don't allow jump until all buttons are up

	if ( pm->cmd.upmove < 10 ) return qfalse;	// not holding jump


	// must wait for jump to be released
	if ( pm->ps->pm_flags & PMF_JUMP_HELD ) {
		// clear upmove so cmdscale doesn't lower running speed
		pm->cmd.upmove = 0;
		return qfalse;
	}

	// JUHOX: calc jump weariness
	if (pm->ps->stats[STAT_STRENGTH] > LOW_STRENGTH_VALUE) {
		pm->ps->stats[STAT_STRENGTH] -= JUMP_STRENGTH_DECREASE;
	}
	else {
		pm->cmd.upmove = 0;
		pm->ps->pm_flags |= PMF_JUMP_HELD;
		return qfalse;
	}

	pml.groundPlane = qfalse;		// jumping away
	pml.walking = qfalse;
	pm->ps->pm_flags |= PMF_JUMP_HELD;

	pm->ps->groundEntityNum = ENTITYNUM_NONE;
	pm->ps->velocity[2] = JUMP_VELOCITY;

	// JUHOX: check for super jump
	pm->ps->velocity[2] *= 1 + (0.25 * (pm->scale - 1));
	if (pm->superJump) {
		pm->ps->velocity[2] *= 2;
	}

	// SLK: check for double-jump
		if (cpm_pm_jump_z) {
			if (pm->ps->stats[STAT_JUMPTIME] > 0) {
				pm->ps->velocity[2] += cpm_pm_jump_z;
			}

			pm->ps->stats[STAT_JUMPTIME] = 400;
		}
	// !SLK

	PM_AddEvent( EV_JUMP );

	if ( pm->cmd.forwardmove >= 0 ) {
		PM_ForceLegsAnim( LEGS_JUMP );
		pm->ps->pm_flags &= ~PMF_BACKWARDS_JUMP;
	} else {
		PM_ForceLegsAnim( LEGS_JUMPB );
		pm->ps->pm_flags |= PMF_BACKWARDS_JUMP;
	}

	return qtrue;
}

/*
=============
PM_CheckWaterJump
=============
*/
static qboolean	PM_CheckWaterJump( void ) {
	vec3_t	spot;
	int		cont;
	vec3_t	flatforward;

	if (pm->ps->pm_time) return qfalse;

	// check for water jump
	if ( pm->waterlevel != 2 ) 	return qfalse;

	flatforward[0] = pml.forward[0];
	flatforward[1] = pml.forward[1];
	flatforward[2] = 0;
	VectorNormalize (flatforward);

	VectorMA (pm->ps->origin, 30, flatforward, spot);
	spot[2] += 4;
	cont = pm->pointcontents (spot, pm->ps->clientNum );
	if ( !(cont & CONTENTS_SOLID) ) return qfalse;

	spot[2] += 16;
	cont = pm->pointcontents (spot, pm->ps->clientNum );

	if (cont & (CONTENTS_SOLID | CONTENTS_PLAYERCLIP | CONTENTS_BODY)) return qfalse;

	// jump out of water
	VectorScale (pml.forward, 200, pm->ps->velocity);
	pm->ps->velocity[2] = 350;

	pm->ps->pm_flags |= PMF_TIME_WATERJUMP;
	pm->ps->pm_time = 2000;

	return qtrue;
}

//============================================================================


/*
===================
PM_WaterJumpMove

Flying out of the water
===================
*/
static void PM_WaterJumpMove( void ) {

	// waterjump has no control, but falls
	PM_StepSlideMove( qtrue );

	pm->ps->velocity[2] -= pm->ps->gravity * pml.frametime;
	if (pm->ps->velocity[2] < 0) {
		// cancel as soon as we are falling down again
		pm->ps->pm_flags &= ~PMF_ALL_TIMES;
		pm->ps->pm_time = 0;
	}
}

/*
===================
PM_WaterMove

===================
*/
static void PM_WaterMove( void ) {
	int		i;
	vec3_t	wishvel;
	float	wishspeed;
	vec3_t	wishdir;
	float	scale;
	float	vel;

	if ( PM_CheckWaterJump() ) {
		PM_WaterJumpMove();
		return;
	}

	PM_Friction ();

	scale = PM_CmdScale( &pm->cmd );
	//
	// user intentions
	//
	if ( !scale ) {
		wishvel[0] = 0;
		wishvel[1] = 0;
		wishvel[2] = -60;		// sink towards bottom
	} else {
		for (i=0 ; i<3 ; i++)
			wishvel[i] = scale * pml.forward[i]*pm->cmd.forwardmove + scale * pml.right[i]*pm->cmd.rightmove;

		wishvel[2] += scale * pm->cmd.upmove;
	}

	VectorCopy (wishvel, wishdir);
	wishspeed = VectorNormalize(wishdir);
	wishspeed *= pm_swimScale;	// JUHOX: bug fix (?)

	if ( wishspeed > pm->ps->speed * pm_swimScale ) {
		wishspeed = pm->ps->speed * pm_swimScale;
	}

	PM_Accelerate (wishdir, wishspeed, pm_wateraccelerate);

	// make sure we can go up slopes easily under water
	if ( pml.groundPlane && DotProduct( pm->ps->velocity, pml.groundTrace.plane.normal ) < 0 ) {
		vel = VectorLength(pm->ps->velocity);
		// slide along the ground plane
		PM_ClipVelocity (pm->ps->velocity, pml.groundTrace.plane.normal,
			pm->ps->velocity, OVERCLIP );

		VectorNormalize(pm->ps->velocity);
		VectorScale(pm->ps->velocity, vel, pm->ps->velocity);
	}

	PM_SlideMove( qfalse );
}

/*
===================
PM_FlyMove

Only with the flight powerup
===================
*/
static void PM_FlyMove( void ) {
	int		i;
	vec3_t	wishvel;
	float	wishspeed;
	vec3_t	wishdir;
	float	scale;

	// normal slowdown
	PM_Friction ();

	scale = PM_CmdScale( &pm->cmd );
	//
	// user intentions
	//
	if ( !scale ) {
		wishvel[0] = 0;
		wishvel[1] = 0;
		wishvel[2] = 0;
	} else {
		for (i=0 ; i<3 ; i++) {
			wishvel[i] = scale * pml.forward[i]*pm->cmd.forwardmove + scale * pml.right[i]*pm->cmd.rightmove;
		}

		wishvel[2] += scale * pm->cmd.upmove;
	}

	VectorCopy (wishvel, wishdir);
	wishspeed = VectorNormalize(wishdir);

	PM_Accelerate (wishdir, wishspeed, pm_flyaccelerate);

	PM_StepSlideMove( qfalse );
}


/*
===================
PM_AirMove

===================
*/
static void PM_AirMove( void ) {
	int			i;
	vec3_t		wishvel;
	float		fmove, smove;
	vec3_t		wishdir;
	float		wishspeed;
	float		scale;
	usercmd_t	cmd;

    float		accel; // SLK
	float		wishspeed2; // SLK

	PM_Friction();

	fmove = pm->cmd.forwardmove;
	smove = pm->cmd.rightmove;

	cmd = pm->cmd;
	scale = PM_CmdScale( &cmd );

	// set the movementDir so clients can rotate the legs for strafing
	PM_SetMovementDir();

	// project moves down to flat plane
	pml.forward[2] = 0;
	pml.right[2] = 0;
	VectorNormalize (pml.forward);
	VectorNormalize (pml.right);

	for ( i = 0 ; i < 2 ; i++ ) {
		wishvel[i] = pml.forward[i]*fmove + pml.right[i]*smove;
	}
	wishvel[2] = 0;

	VectorCopy (wishvel, wishdir);
	wishspeed = VectorNormalize(wishdir);
	wishspeed *= scale;

	// SLK: Air Control
	wishspeed2 = wishspeed;
	if (DotProduct(pm->ps->velocity, wishdir) < 0)
		accel = cpm_pm_airstopaccelerate;
	else
		accel = pm_airaccelerate;
	if (pm->ps->movementDir == 2 || pm->ps->movementDir == 6)
	{
		if (wishspeed > cpm_pm_wishspeed)
			wishspeed = cpm_pm_wishspeed;
            accel = cpm_pm_strafeaccelerate;
	}
	// !SLK

	// not on ground, so little effect on velocity
	PM_Accelerate (wishdir, wishspeed, pm_airaccelerate);

	// SLK: Air control
	PM_Accelerate (wishdir, wishspeed, accel);
	if (cpm_pm_aircontrol)
		CPM_PM_Aircontrol (pm, wishdir, wishspeed2);
	// !SLK

	// we may have a ground plane that is very steep, even
	// though we don't have a groundentity
	// slide along the steep plane
	if ( pml.groundPlane ) {
		PM_ClipVelocity (pm->ps->velocity, pml.groundTrace.plane.normal,
			pm->ps->velocity, OVERCLIP );
	}

	PM_StepSlideMove ( qtrue );
}

/*
===================
PM_GrappleMove

===================
*/
static void PM_GrappleMove( void ) {
	switch (pm->hookMode) {
	case HM_classic:
		{
			vec3_t vel, v;
			float vlen;

			VectorScale(pml.forward, -16.0f, v);
			VectorAdd(pm->ps->grapplePoint, v, v);
			VectorSubtract(v, pm->ps->origin, vel);
			vlen = VectorLength(vel);
			VectorNormalize( vel );

			if (vlen <= 100.0f)
				VectorScale(vel, 10.0f * vlen, vel);
			else
				VectorScale(vel, GRAPPLE_PULL_SPEED_CLASSIC, vel);

			VectorCopy(vel, pm->ps->velocity);

			pml.groundPlane = qfalse;
		}
		break;
	case HM_tool:
	case HM_anchor:
	case HM_combat:
		{
			vec3_t v;
			float dist;
			float pullSpeed;

			VectorSubtract(pm->ps->grapplePoint, pm->ps->origin, v);
			dist = VectorNormalize(v);

			pullSpeed = DotProduct(pm->ps->velocity, v);
			//if (pm->ps->stats[STAT_GRAPPLE_STATE] == GST_fixed) {
			if (GET_STAT_GRAPPLESTATE ( pm->ps ) == GST_fixed) {
				if (dist > ROPE_ELEMENT_SIZE) {
					if (pullSpeed < 0) {
						VectorScale(pm->ps->velocity, -0.7f, pm->ps->velocity);
					}
					VectorMA(pm->ps->velocity, 50.0f * (dist - ROPE_ELEMENT_SIZE) * pml.frametime, v, pm->ps->velocity);
				}
			}
			else {
				float desiredPullSpeed;

				if (pullSpeed < 0) {
					pullSpeed = -pullSpeed;
					VectorMA(pm->ps->velocity, 2 * pullSpeed, v, pm->ps->velocity);
					VectorScale(pm->ps->velocity, 0.7, pm->ps->velocity);
				}

				desiredPullSpeed = pm->ps->stats[STAT_GRAPPLE_SPEED];
				pullSpeed = VectorLength(pm->ps->velocity);
				if (pullSpeed < desiredPullSpeed) {
					VectorMA(pm->ps->velocity, (desiredPullSpeed - pullSpeed), v, pm->ps->velocity);
				}

				pml.groundPlane = qfalse;
			}
		}
		break;
	default:
		break;
	}
}

/*
===================
PM_WalkMove

===================
*/
static void PM_WalkMove( void ) {
	int			i;
	vec3_t		wishvel;
	float		fmove, smove;
	vec3_t		wishdir;
	float		wishspeed;
	float		scale;
	usercmd_t	cmd;
	float		accelerate;
	float		vel;

	if ( pm->waterlevel > 2 && DotProduct( pml.forward, pml.groundTrace.plane.normal ) > 0 ) {
		// begin swimming
		PM_WaterMove();
		return;
	}


	if ( PM_CheckJump () ) {
		// jumped away
		if ( pm->waterlevel > 1 ) {
			PM_WaterMove();
		} else {
			PM_AirMove();
		}
		return;
	}

	PM_Friction ();

	fmove = pm->cmd.forwardmove;
	smove = pm->cmd.rightmove;

	cmd = pm->cmd;
	scale = PM_CmdScale( &cmd );

	// set the movementDir so clients can rotate the legs for strafing
	PM_SetMovementDir();

	// project moves down to flat plane
	pml.forward[2] = 0;
	pml.right[2] = 0;

	// project the forward and right directions onto the ground plane
	PM_ClipVelocity (pml.forward, pml.groundTrace.plane.normal, pml.forward, OVERCLIP );
	PM_ClipVelocity (pml.right, pml.groundTrace.plane.normal, pml.right, OVERCLIP );
	//
	VectorNormalize (pml.forward);
	VectorNormalize (pml.right);

	for ( i = 0 ; i < 3 ; i++ ) {
		wishvel[i] = pml.forward[i]*fmove + pml.right[i]*smove;
	}

	// when going up or down slopes the wish velocity should Not be zero
	VectorCopy (wishvel, wishdir);
	wishspeed = VectorNormalize(wishdir);
	wishspeed *= scale;

	// clamp the speed lower if ducking
	if ( pm->ps->pm_flags & PMF_DUCKED ) {
		if ( wishspeed > pm->ps->speed * pm_duckScale ) {
			wishspeed = pm->ps->speed * pm_duckScale;
		}
	}

	// clamp the speed lower if wading or walking on the bottom
	if ( pm->waterlevel ) {
		float	waterScale;

		waterScale = pm->waterlevel / 3.0;
		waterScale = 1.0 - ( 1.0 - pm_swimScale ) * waterScale;
		if ( wishspeed > pm->ps->speed * waterScale ) {
			wishspeed = pm->ps->speed * waterScale;
		}
	}

	// when a player gets hit, they temporarily lose
	// full control, which allows them to be moved a bit
	if ( ( pml.groundTrace.surfaceFlags & SURF_SLICK ) || pm->ps->pm_flags & PMF_TIME_KNOCKBACK ) {
		accelerate = pm_airaccelerate;
	} else {
		accelerate = pm_accelerate;
	}

	PM_Accelerate (wishdir, wishspeed, accelerate);

	if ( ( pml.groundTrace.surfaceFlags & SURF_SLICK ) || pm->ps->pm_flags & PMF_TIME_KNOCKBACK ) {
		pm->ps->velocity[2] -= pm->ps->gravity * pml.frametime;
	}

	vel = VectorLength(pm->ps->velocity);

	// slide along the ground plane
	PM_ClipVelocity (pm->ps->velocity, pml.groundTrace.plane.normal,
		pm->ps->velocity, OVERCLIP );

	// don't decrease velocity when going up or down a slope
	VectorNormalize(pm->ps->velocity);
	VectorScale(pm->ps->velocity, vel, pm->ps->velocity);

	// don't do anything if standing still
	if (!pm->ps->velocity[0] && !pm->ps->velocity[1]) return;

	PM_StepSlideMove( qfalse );

}


/*
==============
PM_DeadMove
==============
*/
static void PM_DeadMove( void ) {
	float	forward;

	if ( !pml.walking ) return;

	// extra friction
	forward = VectorLength (pm->ps->velocity);
	forward -= 20;
	if ( forward <= 0 ) {
		VectorClear (pm->ps->velocity);
	} else {
		VectorNormalize (pm->ps->velocity);
		VectorScale (pm->ps->velocity, forward, pm->ps->velocity);
	}
}


/*
===============
PM_NoclipMove
===============
*/
static void PM_NoclipMove( void ) {
	float	speed, drop, friction, control, newspeed;
	int			i;
	vec3_t		wishvel;
	float		fmove, smove;
	vec3_t		wishdir;
	float		wishspeed;
	float		scale;

	pm->ps->viewheight = DEFAULT_VIEWHEIGHT;

	// friction
	speed = VectorLength (pm->ps->velocity);
	if (speed < 1)
	{
		VectorCopy (vec3_origin, pm->ps->velocity);
	}
	else
	{
		drop = 0;

		friction = pm_friction*1.5;	// extra friction
		control = speed < pm_stopspeed ? pm_stopspeed : speed;
		drop += control*friction*pml.frametime;

		// scale the velocity
		newspeed = speed - drop;
		if (newspeed < 0)
			newspeed = 0;
		newspeed /= speed;

		VectorScale (pm->ps->velocity, newspeed, pm->ps->velocity);
	}

	// accelerate
	scale = PM_CmdScale( &pm->cmd );

	fmove = pm->cmd.forwardmove;
	smove = pm->cmd.rightmove;

	for (i=0 ; i<3 ; i++)
		wishvel[i] = pml.forward[i]*fmove + pml.right[i]*smove;
	wishvel[2] += pm->cmd.upmove;

	VectorCopy (wishvel, wishdir);
	wishspeed = VectorNormalize(wishdir);
	wishspeed *= scale;

	PM_Accelerate( wishdir, wishspeed, pm_accelerate );

	// move
	VectorMA (pm->ps->origin, pml.frametime, pm->ps->velocity, pm->ps->origin);
}

//============================================================================

/*
================
PM_FootstepForSurface

Returns an event number apropriate for the groundsurface
================
*/
static int PM_FootstepForSurface( void ) {
	// JUHOX BUGFIX: never generate footsteps if walking
	if ( ( (pm->cmd.buttons & (BUTTON_WALKING)) || (pm->cmd.upmove < 0)	) && pm->scale < 1.5 ) return 0;

	if ( pml.groundTrace.surfaceFlags & SURF_NOSTEPS ) return 0;
	if ( pml.groundTrace.surfaceFlags & SURF_METALSTEPS ) return EV_FOOTSTEP_METAL;
    // SLK : add flesh sounds, or more?
	return EV_FOOTSTEP;
}


/*
=================
PM_CrashLand

Check for hard landings that generate sound events
=================
*/
static void PM_CrashLand( void ) {
	float		delta;
	float		dist;
	float		vel, acc;
	float		t;
	float		a, b, c, den;

	// JUHOX: hibernation seed landing
	if (pm->hibernation) {
		PM_AddEvent(EV_COCOON_BOUNCE);
		return;
	}

	// decide which landing animation to use
	if ( pm->ps->pm_flags & PMF_BACKWARDS_JUMP ) {
		PM_ForceLegsAnim( LEGS_LANDB );
	} else {
		PM_ForceLegsAnim( LEGS_LAND );
	}

	pm->ps->legsTimer = TIMER_LAND;

	// calculate the exact velocity on landing
	dist = pm->ps->origin[2] - pml.previous_origin[2];
	vel = pml.previous_velocity[2];
	acc = -pm->ps->gravity;

	a = acc / 2;
	b = vel;
	c = -dist;

	den =  b * b - 4 * a * c;
	if ( den < 0 ) return;
	t = (-b - sqrt( den ) ) / ( 2 * a );

	delta = vel + t * acc;
	delta = delta*delta * 0.0001;

	// ducking while falling doubles damage
	if ( pm->ps->pm_flags & PMF_DUCKED ) delta *= 2;

	// never take falling damage if completely underwater
	if ( pm->waterlevel == 3 ) return;

	// reduce falling damage if there is standing water
	if ( pm->waterlevel == 2 ) delta *= 0.25;

	if ( pm->waterlevel == 1 ) delta *= 0.5;

	if ( delta < 1 ) return;

	// create a local entity event to play the sound

	// SURF_NODAMAGE is used for bounce pads where you don't ever
	// want to take damage or play a crunch sound
	if ( !(pml.groundTrace.surfaceFlags & SURF_NODAMAGE) )  {
		if ( delta > 60 ) {
			PM_AddEvent( EV_FALL_FAR );
		} else if ( delta > 40 ) {
			// this is a pain grunt, so don't play it if dead
			if ( pm->ps->stats[STAT_HEALTH] > 0 ) {
				PM_AddEvent( EV_FALL_MEDIUM );
			}
		} else if ( delta > 7 ) {
			PM_AddEvent( EV_FALL_SHORT );
		} else {
			PM_AddEvent( PM_FootstepForSurface() );
		}
	}

	// start footstep cycle over
	pm->ps->bobCycle = 0;
}

/*
=============
PM_CorrectAllSolid
=============
*/
static int PM_CorrectAllSolid( trace_t *trace ) {
	int			i, j, k;
	vec3_t		point;

	if ( pm->debugLevel ) Com_Printf("%i:allsolid\n", c_pmove);

	// jitter around
	for (i = -1; i <= 1; i++) {
		for (j = -1; j <= 1; j++) {
			for (k = -1; k <= 1; k++) {
				VectorCopy(pm->ps->origin, point);
				point[0] += (float) i;
				point[1] += (float) j;
				point[2] += (float) k;
				pm->trace (trace, point, pm->mins, pm->maxs, point, pm->ps->clientNum, pm->tracemask);
				if ( !trace->allsolid ) {
					point[0] = pm->ps->origin[0];
					point[1] = pm->ps->origin[1];
					point[2] = pm->ps->origin[2] - 0.25;

					pm->trace (trace, pm->ps->origin, pm->mins, pm->maxs, point, pm->ps->clientNum, pm->tracemask);
					pml.groundTrace = *trace;
					return qtrue;
				}
			}
		}
	}

	pm->ps->groundEntityNum = ENTITYNUM_NONE;
	pml.groundPlane = qfalse;
	pml.walking = qfalse;

	return qfalse;
}


/*
=============
PM_GroundTraceMissed

The ground trace didn't hit a surface, so we are in freefall
=============
*/
static void PM_GroundTraceMissed( void ) {
	trace_t		trace;
	vec3_t		point;

	if ( pm->ps->groundEntityNum != ENTITYNUM_NONE ) {
		// we just transitioned into freefall
		if ( pm->debugLevel ) {
			Com_Printf("%i:lift\n", c_pmove);
		}

		// if they aren't in a jumping animation and the ground is a ways away, force into it
		// if we didn't do the trace, the player would be backflipping down staircases
		VectorCopy( pm->ps->origin, point );
		point[2] -= 64;

		pm->trace (&trace, pm->ps->origin, pm->mins, pm->maxs, point, pm->ps->clientNum, pm->tracemask);
		if ( trace.fraction == 1.0 ) {
			if ( pm->cmd.forwardmove >= 0 ) {
				PM_ForceLegsAnim( LEGS_JUMP );
				pm->ps->pm_flags &= ~PMF_BACKWARDS_JUMP;
			} else {
				PM_ForceLegsAnim( LEGS_JUMPB );
				pm->ps->pm_flags |= PMF_BACKWARDS_JUMP;
			}
		}
	}

	pm->ps->groundEntityNum = ENTITYNUM_NONE;
	pml.groundPlane = qfalse;
	pml.walking = qfalse;
}


/*
=============
PM_GroundTrace
=============
*/
static void PM_GroundTrace( void ) {
	vec3_t		point;
	trace_t		trace;

	// JUHOX: speed-up for waiting monsters
	if (
		pm->ps->groundEntityNum == ENTITYNUM_WORLD &&
		pm->ps->velocity[0] == 0 &&
		pm->ps->velocity[1] == 0 &&
		pm->ps->velocity[2] == 0 &&
		!(pm->ps->pm_flags & PMF_TIME_WATERJUMP) &&
		pm->cmd.forwardmove == 0 &&
		pm->cmd.rightmove == 0 &&
		pm->cmd.upmove == 0
	) {
		pml.groundPlane = qtrue;
		pml.walking = qtrue;
		pml.groundTrace.plane.normal[2] = 1;
		return;
	}

	point[0] = pm->ps->origin[0];
	point[1] = pm->ps->origin[1];
	point[2] = pm->ps->origin[2] - 0.25;

	pm->trace (&trace, pm->ps->origin, pm->mins, pm->maxs, point, pm->ps->clientNum, pm->tracemask);
	pml.groundTrace = trace;

	// do something corrective if the trace starts in a solid...
	if ( trace.allsolid ) {
		if ( !PM_CorrectAllSolid(&trace) )
			return;
	}

	// if the trace didn't hit anything, we are in free fall
	if ( trace.fraction == 1.0 ) {
		PM_GroundTraceMissed();
		pml.groundPlane = qfalse;
		pml.walking = qfalse;
		return;
	}

	// check if getting thrown off the ground
	if ( pm->ps->velocity[2] > 0 && DotProduct( pm->ps->velocity, trace.plane.normal ) > 10 ) {
		if ( pm->debugLevel ) {
			Com_Printf("%i:kickoff\n", c_pmove);
		}
		// go into jump animation
		if ( pm->cmd.forwardmove >= 0 ) {
			PM_ForceLegsAnim( LEGS_JUMP );
			pm->ps->pm_flags &= ~PMF_BACKWARDS_JUMP;
		} else {
			PM_ForceLegsAnim( LEGS_JUMPB );
			pm->ps->pm_flags |= PMF_BACKWARDS_JUMP;
		}

		pm->ps->groundEntityNum = ENTITYNUM_NONE;
		pml.groundPlane = qfalse;
		pml.walking = qfalse;
		return;
	}

	// slopes that are too steep will not be considered onground
	if ( trace.plane.normal[2] < MIN_WALK_NORMAL ) {
		if ( pm->debugLevel ) {
			Com_Printf("%i:steep\n", c_pmove);
		}
		// FIXME: if they can't slide down the slope, let them
		// walk (sharp crevices)
		pm->ps->groundEntityNum = ENTITYNUM_NONE;
		pml.groundPlane = qtrue;
		pml.walking = qfalse;
		return;
	}

	pml.groundPlane = qtrue;
	pml.walking = qtrue;

	// hitting solid ground will end a waterjump
	if (pm->ps->pm_flags & PMF_TIME_WATERJUMP)
	{
		pm->ps->pm_flags &= ~(PMF_TIME_WATERJUMP | PMF_TIME_LAND);
		pm->ps->pm_time = 0;
	}

	if ( pm->ps->groundEntityNum == ENTITYNUM_NONE ) {
		// just hit the ground
		if ( pm->debugLevel ) {
			Com_Printf("%i:Land\n", c_pmove);
		}

		PM_CrashLand();

		// don't do landing time if we were just going down a slope
		if ( pml.previous_velocity[2] < -200 ) {
			// don't allow another jump for a little while
			pm->ps->pm_flags |= PMF_TIME_LAND;
			pm->ps->pm_time = 250;
		}
	}

	pm->ps->groundEntityNum = trace.entityNum;

	PM_AddTouchEnt( trace.entityNum );

}


/*
=============
PM_SetWaterLevel	FIXME: avoid this twice?  certainly if not moving
=============
*/
static void PM_SetWaterLevel( void ) {
	vec3_t		point;
	int			cont;
	int			sample1;
	int			sample2;

	// get waterlevel, accounting for ducking
	pm->waterlevel = 0;
	pm->watertype = 0;

	point[0] = pm->ps->origin[0];
	point[1] = pm->ps->origin[1];
	// JUHOX: let PM_SetWaterLevel() handle player scale
	point[2] = pm->ps->origin[2] + MINS_Z * pm->scale + 1;

	cont = pm->pointcontents( point, pm->ps->clientNum );

	if ( cont & MASK_WATER ) {
        // JUHOX: let PM_SetWaterLevel() handle player scale
		sample2 = pm->ps->viewheight - MINS_Z * pm->scale;
		sample1 = sample2 / 2;

		pm->watertype = cont;
		pm->waterlevel = 1;
        // JUHOX: let PM_SetWaterLevel() handle player scale
		point[2] = pm->ps->origin[2] + MINS_Z * pm->scale + sample1;

		cont = pm->pointcontents (point, pm->ps->clientNum );
		if ( cont & MASK_WATER ) {
			pm->waterlevel = 2;
            // JUHOX: let PM_SetWaterLevel() handle player scale
			point[2] = pm->ps->origin[2] + MINS_Z * pm->scale + sample2;

			cont = pm->pointcontents (point, pm->ps->clientNum );
			if ( cont & MASK_WATER ) pm->waterlevel = 3;

		}
	}

}

/*
==============
PM_CheckDuck

Sets mins, maxs, and pm->ps->viewheight
==============
*/
static void PM_CheckDuck (void)
{
	trace_t	trace;

	pm->ps->pm_flags &= ~PMF_INVULEXPAND;

	// JUHOX: hibernation mins & maxs
	if (pm->hibernation) {
		VectorSet(pm->mins, -4, -4, -4);
		VectorSet(pm->maxs, +4, +4, +4);
		pm->ps->viewheight = 0;
		return;
	}

	pm->mins[0] = -15;
	pm->mins[1] = -15;

	pm->maxs[0] = 15;
	pm->maxs[1] = 15;

	pm->mins[2] = MINS_Z;

	// JUHOX: apply player scale factor
	VectorScale(pm->mins, pm->scale, pm->mins);
	pm->maxs[0] *= pm->scale;
	pm->maxs[1] *= pm->scale;

	if (pm->ps->pm_type == PM_DEAD)
	{
		pm->maxs[2] = -8;
		// JUHOX: apply player scale factor
		pm->maxs[2] *= pm->scale;

		// JUHOX FIXME: player viewheight should be adapted to player scale factor
		pm->ps->viewheight = DEAD_VIEWHEIGHT;
		return;
	}

	if (pm->cmd.upmove < 0)
	{	// duck
		pm->ps->pm_flags |= PMF_DUCKED;
	}
	else
	{	// stand up if possible
		if (pm->ps->pm_flags & PMF_DUCKED)
		{
			// try to stand up
			pm->maxs[2] = 32;
			// JUHOX: apply player scale factor
			pm->maxs[2] *= pm->scale;
			pm->trace (&trace, pm->ps->origin, pm->mins, pm->maxs, pm->ps->origin, pm->ps->clientNum, pm->tracemask );
			if (!trace.allsolid)
				pm->ps->pm_flags &= ~PMF_DUCKED;
		}
	}

	if (pm->ps->pm_flags & PMF_DUCKED)
	{
		pm->maxs[2] = 16;
		pm->ps->viewheight = CROUCH_VIEWHEIGHT;
	}
	else
	{
		pm->maxs[2] = 32;
		pm->ps->viewheight = DEFAULT_VIEWHEIGHT;
	}
	// JUHOX: apply player scale factor
	pm->maxs[2] *= pm->scale;
	pm->ps->viewheight = pm->ps->viewheight * pm->scale;

}



//===================================================================


/*
===============
PM_Footsteps
===============
*/
static void PM_Footsteps( void ) {
	float		bobmove;
	int			old;
	qboolean	footstep;

	//
	// calculate speed and cycle to be used for
	// all cyclic walking effects
	//
	pm->xyspeed = sqrt( pm->ps->velocity[0] * pm->ps->velocity[0] +  pm->ps->velocity[1] * pm->ps->velocity[1] );

	if ( pm->ps->groundEntityNum == ENTITYNUM_NONE ) {
		// airborne leaves position in cycle intact, but doesn't advance
		if ( pm->waterlevel > 1 ) {
			PM_ContinueLegsAnim( LEGS_SWIM );
		}
		return;
	}

	// if not trying to move
	// JUHOX: always use idle animation for grapple move

	if (( !pm->cmd.forwardmove && !pm->cmd.rightmove ) || (pm->ps->pm_flags & PMF_GRAPPLE_PULL)	) {
		if (  pm->xyspeed < 5 ) {
			pm->ps->bobCycle = 0;	// start at beginning of cycle again
			if ( pm->ps->pm_flags & PMF_DUCKED ) {
				PM_ContinueLegsAnim( LEGS_IDLECR );
			} else {
				PM_ContinueLegsAnim( LEGS_IDLE );
			}
		}
		return;
	}


	footstep = qfalse;

	if ( pm->ps->pm_flags & PMF_DUCKED ) {
		bobmove = 0.5;	// ducked characters bob much faster
		if ( pm->ps->pm_flags & PMF_BACKWARDS_RUN ) {
			PM_ContinueLegsAnim( LEGS_BACKCR );
		}
		else {
			PM_ContinueLegsAnim( LEGS_WALKCR );
		}

        // JUHOX: adapt bobbing to movement speed
		bobmove *= VectorLength(pm->ps->velocity) / 160;

	} else {
		if ( !( pm->cmd.buttons & BUTTON_WALKING ) ) {
			bobmove = 0.4f;	// faster speeds bob faster
			if ( pm->ps->pm_flags & PMF_BACKWARDS_RUN ) {
				PM_ContinueLegsAnim( LEGS_BACK );
			}
			else {
				PM_ContinueLegsAnim( LEGS_RUN );
			}
			footstep = qtrue;
            // JUHOX: adapt bobbing to movement speed
			bobmove *= VectorLength(pm->ps->velocity) / 320;

		} else {
			bobmove = 0.3f;	// walking bobs slow
			if ( pm->ps->pm_flags & PMF_BACKWARDS_RUN ) {
				PM_ContinueLegsAnim( LEGS_BACKWALK );
			}
			else {
				PM_ContinueLegsAnim( LEGS_WALK );
			}
			// JUHOX: big players always generate footsteps

			if (pm->scale >= 1.5) footstep = qtrue;

            // JUHOX: adapt bobbing to movement speed
			bobmove *= VectorLength(pm->ps->velocity) / 160;

		}
	}
	// JUHOX: slow down bobbing for tired players
	if (pm->ps->stats[STAT_STRENGTH] < LOW_STRENGTH_VALUE) {
		bobmove *= 0.6 + 0.4 * pm->ps->stats[STAT_STRENGTH] / LOW_STRENGTH_VALUE;
	}

	// JUHOX: slower bobbing for titan

	bobmove /= pm->scale;

	// check for footstep / splash sounds
	old = pm->ps->bobCycle;
	pm->ps->bobCycle = (int)( old + bobmove * pml.msec ) & 255;

	// if we just crossed a cycle boundary, play an apropriate footstep event
	if ( ( ( old + 64 ) ^ ( pm->ps->bobCycle + 64 ) ) & 128 ) {
		// JUHOX: no-sound lava/slime hack

		if (
			pm->waterlevel == 0 ||
			(
				pm->gametype == GT_EFH &&
				(pm->watertype & CONTENTS_WATER) &&
				(pm->watertype & (CONTENTS_LAVA|CONTENTS_SLIME))
			)
		) {

			// on ground will only play sounds if running
			if ( footstep && !pm->noFootsteps ) {
				PM_AddEvent( PM_FootstepForSurface() );
			}
		} else if ( pm->waterlevel == 1 ) {
			// splashing
			PM_AddEvent( EV_FOOTSPLASH );
		} else if ( pm->waterlevel == 2 ) {
			// wading / swimming at surface
			PM_AddEvent( EV_SWIM );
		} else if ( pm->waterlevel == 3 ) {
			// no sound when completely underwater

		}
	}
}

/*
==============
PM_WaterEvents

Generate sound events for entering and leaving water
==============
*/
static void PM_WaterEvents( void ) {		// FIXME?
	// JUHOX: no-sound lava/slime hack

	if (
		pm->gametype == GT_EFH &&
		(
			(
				pm->waterlevel > 0 &&
				(pm->watertype & CONTENTS_WATER) &&
				(pm->watertype & (CONTENTS_LAVA|CONTENTS_SLIME))
			) ||
			(
				pml.previous_waterlevel > 0 &&
				(pml.previous_watertype & CONTENTS_WATER) &&
				(pml.previous_watertype & (CONTENTS_LAVA|CONTENTS_SLIME))
			)
		)
	) {
		return;
	}

	//
	// if just entered a water volume, play a sound
	//
	if (!pml.previous_waterlevel && pm->waterlevel) PM_AddEvent( EV_WATER_TOUCH );


	//
	// if just completely exited a water volume, play a sound
	//
	if (pml.previous_waterlevel && !pm->waterlevel) PM_AddEvent( EV_WATER_LEAVE );


	//
	// check for head just going under water
	//
	if (pml.previous_waterlevel != 3 && pm->waterlevel == 3) PM_AddEvent( EV_WATER_UNDER );


	//
	// check for head just coming out of water
	//
	if (pml.previous_waterlevel == 3 && pm->waterlevel != 3) PM_AddEvent( EV_WATER_CLEAR );

}


/*
===============
PM_BeginWeaponChange
===============
*/
static void PM_BeginWeaponChange( int weapon ) {

	if ( weapon <= WP_NONE || weapon >= WP_NUM_WEAPONS ) return;
	if ( !( pm->ps->stats[STAT_WEAPONS] & ( 1 << weapon ) ) ) return;
	if ( pm->ps->weaponstate == WEAPON_DROPPING ) return;

	PM_AddEvent( EV_CHANGE_WEAPON );
	pm->ps->weaponstate = WEAPON_DROPPING;
	pm->ps->weaponTime += 200;
	PM_StartTorsoAnim( TORSO_DROP );
}


/*
===============
PM_FinishWeaponChange
===============
*/
static void PM_FinishWeaponChange( void ) {
	int		weapon;

	weapon = pm->cmd.weapon;
	if ( weapon < WP_NONE || weapon >= WP_NUM_WEAPONS ) {
		weapon = WP_NONE;
	}

	if ( !( pm->ps->stats[STAT_WEAPONS] & ( 1 << weapon ) ) ) {
		weapon = WP_NONE;
	}

	pm->ps->weapon = weapon;
	pm->ps->weaponstate = WEAPON_RAISING;
	pm->ps->weaponTime += 250;
	PM_StartTorsoAnim( TORSO_RAISE );
}


/*
==============
PM_TorsoAnimation

==============
*/
static void PM_TorsoAnimation( void ) {

	// JUHOX: WEAPON_WIND_UP and WEAPON_WIND_OFF also use TORSO_STAND animation
	if (
		pm->ps->weaponstate == WEAPON_WIND_UP ||
		pm->ps->weaponstate == WEAPON_WIND_OFF
	) {
		PM_ContinueTorsoAnim(TORSO_STAND);
		return;
	}

	if ( pm->ps->weaponstate == WEAPON_READY ) {
		// JUHOX: use TORSO_STAND2 also for WP_NONE
		if (pm->ps->weapon <= WP_GAUNTLET) {
			PM_ContinueTorsoAnim( TORSO_STAND2 );
		} else {
			PM_ContinueTorsoAnim( TORSO_STAND );
		}
		return;
	}
}


/*
================
JUHOX: AngleKick
================
*/
#define ANGLE_KICK_ACC 1000.0	// degrees per second per second
static float AngleKick(float* kick) {
	float acc;
	float t;
	float d;
	float move;

	if (*kick == 0) return 0;

	if (*kick < 0) {
		acc = ANGLE_KICK_ACC;
	}
	else {
		acc = -ANGLE_KICK_ACC;
	}

	t = pml.msec * 0.001;
	d = acc * t;
	if (fabs(d) > fabs(*kick)) {
		t = *kick / -acc;
		d = -*kick;
	}

	move = *kick * t + 0.5 * acc * Square(t);

	*kick += d;

	return move;
}

/*
==============
JUHOX: PM_WeaponShake
==============
*/
static void PM_WeaponShake(playerState_t* ps) {
	static const struct {
		float viewSpread;
		float knockback;
		int knockbackTime;
		float duckedViewSpread;
		float duckedKnockback;
		int duckedKnockbackTime;
	} weaponShakeCharacteristics[16] = {
		{0, 0, 0, 0, 0, 0},				// WP_NONE
		{0, 0, 0, 0, 0, 0},				// WP_GAUNTLET
		{0, 0, 0, 0, 0, 0},			// WP_MACHINEGUN
		{0, 0, 0, 0, 0, 0},		// WP_SHOTGUN
		{0, 0, 0, 0, 0, 0},		// WP_GRENADE_LAUNCHER
		{0, 0, 0, 0, 0, 0},		// WP_ROCKET_LAUNCHER
		{0, 0, 0, 0, 0, 0},				// WP_LIGHTNING
		{0, 600, 200, 0, 0, 0},	// WP_RAILGUN
		{0, 0, 0, 0, 0, 0},			// WP_PLASMAGUN
		{0, 300, 200, 0, 0, 0},	// WP_BFG
		{0, 0, 0, 0, 0, 0},				// WP_GRAPPLING_HOOK
		{0, 0, 0, 0, 0, 0},		// WP_MONSTER_LAUNCHER //SLK: might use this one as PORTAL GUN for self teleportation?
	};
	float viewSpread;
	float knockback;
	int knockbackTime;

	if (ps->clientNum >= MAX_CLIENTS) return;

	if ((ps->pm_flags & PMF_DUCKED) && ps->groundEntityNum != ENTITYNUM_NONE) {
		viewSpread = weaponShakeCharacteristics[ps->weapon].duckedViewSpread;
		knockback = weaponShakeCharacteristics[ps->weapon].duckedKnockback;
		knockbackTime = weaponShakeCharacteristics[ps->weapon].duckedKnockbackTime;
	}
	else {
		viewSpread = weaponShakeCharacteristics[ps->weapon].viewSpread;
		knockback = weaponShakeCharacteristics[ps->weapon].knockback;
		knockbackTime = weaponShakeCharacteristics[ps->weapon].knockbackTime;
	}

	if (ps->stats[STAT_STRENGTH] < LOW_STRENGTH_VALUE) {
		float wearinessFactor;

		wearinessFactor = 2 - ps->stats[STAT_STRENGTH] / LOW_STRENGTH_VALUE;
		viewSpread *= wearinessFactor;
		knockbackTime = knockbackTime * wearinessFactor;
	}

	viewSpread *= WEAPON_KICK_FACTOR;
	if (
		(ps->pm_flags & PMF_DUCKED) &&
		(
			(
				ps->weapon == WP_MACHINEGUN &&
				(ps->ammo[WP_MACHINEGUN] & 1)
			) ||
			(
				ps->weapon == WP_PLASMAGUN &&
				(ps->ammo[WP_PLASMAGUN] & 1)
			)
		)
	) {
		viewSpread = -viewSpread;
	}
	ps->stats[STAT_WEAPON_KICK] -= viewSpread;	// negative pitch is upwards

	if (knockbackTime) {
		vec3_t forward;

		AngleVectors(ps->viewangles, forward, NULL, NULL);
		VectorMA(ps->velocity, -knockback, forward, ps->velocity);
		if (!ps->pm_time) {
			ps->pm_time = knockbackTime;
			ps->pm_flags |= PMF_TIME_KNOCKBACK;
		}
	}
}

/*
==============
PM_Weapon

Generates weapon events and modifes the weapon counter
==============
*/
static void PM_Weapon( void ) {
	int		addTime;

	// don't allow attack until all buttons are up
	if ( pm->ps->pm_flags & PMF_RESPAWNED ) return;

	// ignore if spectator
	if ( pm->ps->persistant[PERS_TEAM] == TEAM_SPECTATOR ) return;

	// check for dead player
	if ( pm->ps->stats[STAT_HEALTH] <= 0 ) {
		pm->ps->weapon = WP_NONE;
		return;
	}

	// check for item using
	if ( pm->cmd.buttons & BUTTON_USE_HOLDABLE ) {
		if ( ! ( pm->ps->pm_flags & PMF_USE_ITEM_HELD ) ) {
			if ( bg_itemlist[pm->ps->stats[STAT_HOLDABLE_ITEM]].giTag == HI_MEDKIT
				&& pm->ps->stats[STAT_HEALTH] >= (pm->ps->stats[STAT_MAX_HEALTH] + 25) ) {
				// don't use medkit if at max health
			} else {
				pm->ps->pm_flags |= PMF_USE_ITEM_HELD;
				PM_AddEvent( EV_USE_ITEM0 + bg_itemlist[pm->ps->stats[STAT_HOLDABLE_ITEM]].giTag );
				pm->ps->stats[STAT_HOLDABLE_ITEM] = 0;
			}
			return;
		}
	} else {
		pm->ps->pm_flags &= ~PMF_USE_ITEM_HELD;
	}


	// make weapon function
	if ( pm->ps->weaponTime > 0 ) {
		pm->ps->weaponTime -= pml.msec;
	}

	// JUHOX: no fire with shield
	if (pm->ps->powerups[PW_SHIELD]) {
		pm->cmd.buttons &= ~BUTTON_ATTACK;
	}


	// JUHOX: can't fire lightning gun under water
	if (pm->ps->weapon == WP_LIGHTNING && pm->waterlevel > 1) {
		pm->cmd.buttons &= ~BUTTON_ATTACK;
		pm->ps->eFlags &= ~EF_FIRING;
	}

	// check for weapon change
	// can't change if weapon is firing, but can change
	// again if lowering or raising

	if (
		pm->ps->weaponstate < WEAPON_FIRING ||
		(
			pm->ps->weaponstate == WEAPON_FIRING &&
			pm->ps->weaponTime <= 0 &&
			pm->ps->weapon != WP_MACHINEGUN
		)
	) {
		if (pm->ps->weapon != pm->cmd.weapon) {
			PM_BeginWeaponChange(pm->cmd.weapon);
		}
	}

	if ( pm->ps->weaponTime > 0 ) return;

	// change weapon if time
	if ( pm->ps->weaponstate == WEAPON_DROPPING ) {
		PM_FinishWeaponChange();
		return;
	}

	if ( pm->ps->weaponstate == WEAPON_RAISING ) {
		pm->ps->weaponstate = WEAPON_READY;

		if (pm->ps->weapon <= WP_GAUNTLET) {
			PM_StartTorsoAnim( TORSO_STAND2 );
		} else {
			PM_StartTorsoAnim( TORSO_STAND );
		}
		return;
	}


	// JUHOX: check for new weapon state
	if (pm->ps->weapon == WP_MACHINEGUN) {
		if (
			pm->ps->weaponstate == WEAPON_WIND_UP ||
			pm->ps->weaponstate == WEAPON_FIRING
		) {
			// ready to fire
			if (
				!(pm->cmd.buttons & BUTTON_ATTACK) ||
				pm->ps->ammo[WP_MACHINEGUN] == 0 ||
				pm->ps->weapon != pm->cmd.weapon
			) {
				if (
					pm->ps->ammo[WP_MACHINEGUN] == 0 &&
					(pm->cmd.buttons & BUTTON_ATTACK)
				) {
					PM_AddEvent(EV_NOAMMO);
				}
				pm->ps->weaponstate = WEAPON_WIND_OFF;
				pm->ps->weaponTime = MACHINEGUN_WIND_OFF_TIME;
				return;
			}
		}
		else if (pm->ps->weaponstate == WEAPON_WIND_OFF) {
			pm->ps->weaponstate = WEAPON_READY;
			pm->ps->weaponTime = 0;
			return;
		}
		else if (pm->cmd.buttons & BUTTON_ATTACK) {
			// player wants to start the weapon
			if (pm->ps->ammo[pm->ps->weapon] != 0) {
				pm->ps->weaponstate = WEAPON_WIND_UP;
				pm->ps->weaponTime = MACHINEGUN_WIND_UP_TIME;
				return;
			}
		}
	}

	// check for fire
	if ( ! (pm->cmd.buttons & BUTTON_ATTACK) ) {
		pm->ps->weaponTime = 0;
		pm->ps->weaponstate = WEAPON_READY;
		return;
	}

	// JUHOX: the grapple can't shoot while used
	//if (pm->ps->weapon == WP_GRAPPLING_HOOK && pm->ps->stats[STAT_GRAPPLE_STATE] != GST_unused) {
	if ( pm->ps->weapon == WP_GRAPPLING_HOOK && GET_STAT_GRAPPLESTATE ( pm->ps ) != GST_unused) {
		pm->ps->weaponTime = 0;
		pm->ps->weaponstate = WEAPON_READY;
		return;
	}


	// start the animation even if out of ammo
	if (pm->ps->weapon <= WP_GAUNTLET) {
		// the guantlet only "fires" when it actually hits something
		if ( !pm->gauntletHit ) {
			pm->ps->weaponTime = 0;
			pm->ps->weaponstate = WEAPON_READY;
			return;
		}
		PM_StartTorsoAnim( TORSO_ATTACK2 );
	} else {
		PM_StartTorsoAnim( TORSO_ATTACK );
	}

	pm->ps->weaponstate = WEAPON_FIRING;

	// check for out of ammo
	if ( ! pm->ps->ammo[ pm->ps->weapon ] ) {
		PM_AddEvent( EV_NOAMMO );
		pm->ps->weaponTime += 500;
		return;
	}

	// take an ammo away if not infinite
	if ( pm->ps->ammo[ pm->ps->weapon ] /*!= -1*/>0 ) {	// JUHOX
		pm->ps->ammo[ pm->ps->weapon ]--;
	}
	else pm->ps->ammo[pm->ps->weapon] ^= 1;	// JUHOX: for weapon shaking

	// JUHOX: bump seed for weapon shaking
	{
		localseed_t seed;

		seed.seed0 = pm->ps->generic1;
		seed.seed1 = pm->ps->clientNum;
		seed.seed2 = pm->ps->persistant[PERS_SPAWN_COUNT];
		seed.seed3 = pm->ps->ammo[pm->ps->weapon];
		pm->ps->generic1 = LocallySeededRandom(&seed) & 255;
	}

	// fire weapon
	PM_AddEvent( EV_FIRE_WEAPON );

	switch( pm->ps->weapon ) {
	default:
        // JUHOX: weapon time for WP_NONE
		addTime = 400;
		break;
	case WP_GAUNTLET:
		addTime = 50;	// JUHOX: 400
		break;
	case WP_LIGHTNING:
		addTime = 50;
		break;
	case WP_SHOTGUN:
		addTime = 1000;
		break;
	case WP_MACHINEGUN:
		addTime = 100;
		break;
	case WP_GRENADE_LAUNCHER:
		addTime = 300;	// JUHOX: 800
		break;
	case WP_ROCKET_LAUNCHER:
		addTime = 600;	// JUHOX: 800
		// JUHOX: monster's (guard's) rocket shoots faster
		if (pm->ps->clientNum >= MAX_CLIENTS) {
			addTime = 200;
		}
		break;
	case WP_PLASMAGUN:
		addTime = 80;
		break;
	case WP_RAILGUN:
		addTime = 1500;
		break;
	case WP_BFG:
		addTime = 4000;	// JUHOX: 200 // SLK@ZaRR heres your BFG reload if want to change
		break;
	case WP_GRAPPLING_HOOK:
		addTime = 400;
		break;
	// JUHOX: reload time for monster launcher
	case WP_MONSTER_LAUNCHER:
		addTime = 300;
		break;

	}

	pm->ps->weaponTime += addTime;

	PM_WeaponShake(pm->ps);	// JUHOX
}

/*
================
PM_Animate
================
*/

static void PM_Animate( void ) {
	if ( pm->cmd.buttons & BUTTON_GESTURE ) {
		if ( pm->ps->torsoTimer == 0 ) {
			PM_StartTorsoAnim( TORSO_GESTURE );
			pm->ps->torsoTimer = TIMER_GESTURE;
			PM_AddEvent( EV_TAUNT );
		}
	}
}


/*
================
PM_DropTimers
================
*/
static void PM_DropTimers( void ) {
	// drop misc timing counter
	if ( pm->ps->pm_time ) {
		if ( pml.msec >= pm->ps->pm_time ) {
			pm->ps->pm_flags &= ~PMF_ALL_TIMES;
			pm->ps->pm_time = 0;
		} else {
			pm->ps->pm_time -= pml.msec;
		}
	}

	// drop animation counter
	if ( pm->ps->legsTimer > 0 ) {
		pm->ps->legsTimer -= pml.msec;
		if ( pm->ps->legsTimer < 0 ) {
			pm->ps->legsTimer = 0;
		}
	}

	if ( pm->ps->torsoTimer > 0 ) {
		pm->ps->torsoTimer -= pml.msec;
		if ( pm->ps->torsoTimer < 0 ) {
			pm->ps->torsoTimer = 0;
		}
	}
}

/*
================
PM_UpdateViewAngles

This can be used as another entry point when only the viewangles
are being updated isntead of a full move
================
*/
void PM_UpdateViewAngles( playerState_t *ps, const usercmd_t *cmd ) {
	short		temp;
	int		i;

	if ( ps->pm_type == PM_INTERMISSION || ps->pm_type == PM_SPINTERMISSION) return;		// no view changes at all
	if ( ps->pm_type != PM_SPECTATOR && ps->stats[STAT_HEALTH] <= 0 ) return;		// no view changes at all

#if MEETING
	if (ps->pm_type == PM_MEETING) return;      // JUHOX: no view changes during meeting
#endif

	// JUHOX: gauntlet lock target mechanism
	if (
		ps->weapon == WP_GAUNTLET &&
		ps->stats[STAT_HEALTH] > 0 &&
		(cmd->buttons & BUTTON_ATTACK) &&
		!ps->powerups[PW_INVIS] &&
		!(cmd->buttons & BUTTON_WALKING) &&
		!(ps->pm_flags & PMF_DUCKED) &&
		ps->stats[STAT_TARGET] >= 0
	) {
		vec3_t dir;
		vec3_t angles;

		VectorSubtract(pm->target, ps->origin, dir);
		dir[2] -= ps->viewheight;	// viewers viewheight
		vectoangles(dir, angles);
		if (angles[PITCH] > 180) angles[PITCH] -= 360;
		else if (angles[PITCH] < -180) angles[PITCH] += 360;
		for (i = 0; i < 3; i++) {
			if (i == YAW && (angles[PITCH] > 65 || angles[PITCH] < -65)) continue;
			ps->delta_angles[i] = ANGLE2SHORT(angles[i]) - cmd->angles[i];
		}
	}

	// circularly clamp the angles with deltas
	for (i=0 ; i<3 ; i++) {
		temp = cmd->angles[i] + ps->delta_angles[i];
		if ( i == PITCH ) {
			// don't let the player look up or down more than 90 degrees
			if ( temp > 16000 ) {
				ps->delta_angles[i] = 16000 - cmd->angles[i];
				temp = 16000;
			} else if ( temp < -16000 ) {
				ps->delta_angles[i] = -16000 - cmd->angles[i];
				temp = -16000;
			}
		}
		ps->viewangles[i] = SHORT2ANGLE(temp);
	}

}


/*
================
JUHOX: CalcWeariness
================
*/
void CalcWeariness(void) {

	if (pm->ps->clientNum >= MAX_CLIENTS) return;	// speed up
	if (pm->ps->persistant[PERS_TEAM] != TEAM_SPECTATOR) {
		qboolean weary;

		weary = qfalse;
		if (
			(
				!(pm->ps->pm_flags & PMF_DUCKED) ||
				pm->waterlevel > 1 ||
				pm->ps->stats[STAT_HEALTH] <= 0
			) &&
			(
				abs(pm->cmd.forwardmove) > 64 ||
				abs(pm->cmd.rightmove) > 64 ||
				(abs(pm->cmd.upmove) > 64 && !(pm->ps->pm_flags & PMF_JUMP_HELD))
			)
		) {
			// running
			pm->ps->stats[STAT_STRENGTH] -= WEARY_ONE_SECOND * pml.frametime;
			weary = qtrue;
		}
		if (
			pm->waterlevel >= 3 ||
			(pm->cmd.buttons & BUTTON_HOLD_BREATH)
		) {
			pm->ps->stats[STAT_STRENGTH] -= 0.5 * WEARY_ONE_SECOND * pml.frametime;
			weary = qtrue;
		}

		// refreshing
		if (!weary) {
			if (pm->cmd.forwardmove || pm->cmd.rightmove || pm->cmd.upmove) {
				// walking
				pm->ps->stats[STAT_STRENGTH] += REFRESH_ONE_SECOND * pml.frametime;
			}
			else {
				// pausing
				pm->ps->stats[STAT_STRENGTH] += 2 * REFRESH_ONE_SECOND * pml.frametime;
			}
		}

		if (pm->ps->stats[STAT_STRENGTH] < 0) {
			pm->ps->stats[STAT_STRENGTH] = 0;
		}
		else if (pm->ps->stats[STAT_STRENGTH] > MAX_STRENGTH_VALUE) {
			pm->ps->stats[STAT_STRENGTH] = MAX_STRENGTH_VALUE;
		}
	}
}

/*
================
PmoveSingle

================
*/
void trap_SnapVector( float *v );

void PmoveSingle (pmove_t *pmove) {
	int oldCommandTime;	// JUHOX
	vec3_t oldOrigin;	// JUHOX

	pm = pmove;
	oldCommandTime = pm->ps->commandTime;	// JUHOX
	VectorCopy(pm->ps->origin, oldOrigin);	// JUHOX

	// this counter lets us debug movement problems with a journal
	// by setting a conditional breakpoint fot the previous frame
	c_pmove++;

	// clear results
	pm->numtouch = 0;
	pm->watertype = 0;
	pm->waterlevel = 0;

	if ( pm->ps->stats[STAT_HEALTH] <= 0 ) {
		pm->tracemask &= ~CONTENTS_BODY;	// corpses can fly through bodies
	}

	// JUHOX: gauntlet attack move
	if (
		pm->ps->persistant[PERS_TEAM] != TEAM_SPECTATOR &&
		pm->ps->weapon == WP_GAUNTLET &&
		pm->ps->stats[STAT_HEALTH] > 0 &&
		(pm->cmd.buttons & BUTTON_ATTACK) &&
		pm->ps->stats[STAT_TARGET] >= 0
	) {
		if (pm->cmd.upmove < 0) pm->cmd.upmove = 0;
		pm->cmd.buttons &= ~BUTTON_WALKING;
		if (!(pm->ps->pm_flags & PMF_DUCKED)) {
			pm->cmd.forwardmove = 127;
			pm->cmd.rightmove = 0;
		}
	}

	// make sure walking button is clear if they are running, to avoid
	// proxy no-footsteps cheats
	if ( abs( pm->cmd.forwardmove ) > 64 || abs( pm->cmd.rightmove ) > 64 ) {
		pm->cmd.buttons &= ~BUTTON_WALKING;
	}

	// set the talk balloon flag
	if ( pm->cmd.buttons & BUTTON_TALK ) {
		pm->ps->eFlags |= EF_TALK;
	} else {
		pm->ps->eFlags &= ~EF_TALK;
	}

	// set the firing flag for continuous beam weapons
	if ( !(pm->ps->pm_flags & PMF_RESPAWNED) && pm->ps->pm_type != PM_INTERMISSION
#if MEETING
		&& pm->ps->pm_type != PM_MEETING
#endif
		&& ( pm->cmd.buttons & BUTTON_ATTACK ) && pm->ps->ammo[ pm->ps->weapon ]
		&& !pm->ps->powerups[PW_SHIELD]
		&& pm->ps->weapon == pm->cmd.weapon
		&& pm->ps->weaponstate != WEAPON_DROPPING
		&& pm->ps->weaponstate != WEAPON_RAISING
	) {

		pm->ps->eFlags |= EF_FIRING;
	} else {
		pm->ps->eFlags &= ~EF_FIRING;
	}

	// clear the respawned flag if attack and use are cleared
	if ( pm->ps->stats[STAT_HEALTH] > 0 &&
		!( pm->cmd.buttons & (BUTTON_ATTACK | BUTTON_USE_HOLDABLE) ) ) {
		pm->ps->pm_flags &= ~PMF_RESPAWNED;
	}

	// if talk button is down, dissallow all other input
	// this is to prevent any possible intercept proxy from
	// adding fake talk balloons
	if ( pmove->cmd.buttons & BUTTON_TALK ) {
		// keep the talk button set tho for when the cmd.serverTime > 66 msec
		// and the same cmd is used multiple times in Pmove
		pmove->cmd.buttons = BUTTON_TALK;
		pmove->cmd.forwardmove = 0;
		pmove->cmd.rightmove = 0;
		pmove->cmd.upmove = 0;
	}

	// clear all pmove local vars
	memset (&pml, 0, sizeof(pml));

	// determine the time
	pml.msec = pmove->cmd.serverTime - pm->ps->commandTime;
	if ( pml.msec < 1 ) {
		pml.msec = 1;
	} else if ( pml.msec > 200 ) {
		pml.msec = 200;
	}
	pm->ps->commandTime = pmove->cmd.serverTime;

	// save old org in case we get stuck
	VectorCopy (pm->ps->origin, pml.previous_origin);

	// save old velocity for crashlanding
	VectorCopy (pm->ps->velocity, pml.previous_velocity);

	pml.frametime = pml.msec * 0.001;

	// update the viewangles
	PM_UpdateViewAngles( pm->ps, &pm->cmd );

	AngleVectors (pm->ps->viewangles, pml.forward, pml.right, pml.up);

	if ( pm->cmd.upmove < 10 ) {
		// not holding jump
		pm->ps->pm_flags &= ~PMF_JUMP_HELD;
	}

	// decide if backpedaling animations should be used
	if ( pm->cmd.forwardmove < 0 ) {
		pm->ps->pm_flags |= PMF_BACKWARDS_RUN;
	} else if ( pm->cmd.forwardmove > 0 || ( pm->cmd.forwardmove == 0 && pm->cmd.rightmove ) ) {
		pm->ps->pm_flags &= ~PMF_BACKWARDS_RUN;
	}

	if ( pm->ps->pm_type >= PM_DEAD ) {
		pm->cmd.forwardmove = 0;
		pm->cmd.rightmove = 0;
		pm->cmd.upmove = 0;
	}

	if ( pm->ps->pm_type == PM_SPECTATOR ) {
		PM_CheckDuck ();
		// JUHOX: is this a dead player spectating?
		if (pm->ps->stats[STAT_HEALTH] <= 0) {
			pm->ps->stats[STAT_STRENGTH] += REFRESH_ONE_SECOND * pml.frametime;
			if (pm->ps->stats[STAT_STRENGTH] > MAX_STRENGTH_VALUE) {
				pm->ps->stats[STAT_STRENGTH] = MAX_STRENGTH_VALUE;
			}
		}

		PM_FlyMove ();
		PM_DropTimers ();
		return;
	}

	if ( pm->ps->pm_type == PM_NOCLIP ) {
		PM_NoclipMove ();
		PM_DropTimers ();
		return;
	}

	if (pm->ps->pm_type == PM_FREEZE) {
		return;		// no movement at all
	}

	if ( pm->ps->pm_type == PM_INTERMISSION || pm->ps->pm_type == PM_SPINTERMISSION) {
		return;		// no movement at all
	}

#if MEETING	// JUHOX: no movement during meeting
	if (pm->ps->pm_type == PM_MEETING) return;
#endif

	// set watertype, and waterlevel
	PM_SetWaterLevel();
	pml.previous_waterlevel = pmove->waterlevel;
	pml.previous_watertype = pmove->watertype;	// JUHOX

	// set mins, maxs, and viewheight
	PM_CheckDuck ();

	// set groundentity
	PM_GroundTrace();

	if ( pm->ps->pm_type == PM_DEAD ) {
		PM_DeadMove ();
	}

	PM_DropTimers();


	// SLK: Double-jump timer
    if (pm->ps->stats[STAT_JUMPTIME] > 0) pm->ps->stats[STAT_JUMPTIME] -= pml.msec;
	// !SLK


	CalcWeariness(); // JUHOX: weariness & refreshing

	if ( pm->ps->powerups[PW_FLIGHT] ) {
		// flight powerup doesn't allow jump and has different friction
		PM_FlyMove();
	} else if (pm->ps->pm_flags & PMF_GRAPPLE_PULL) {
		PM_GrappleMove();
		// JUHOX: with a fixed rope we may walk
		//if (pm->ps->stats[STAT_GRAPPLE_STATE] == GST_fixed && pml.walking) {
		if (GET_STAT_GRAPPLESTATE (pm->ps) == GST_fixed && pml.walking) {
			PM_WalkMove();
		}
		else {
			PM_AirMove();
		}

	} else if (pm->ps->pm_flags & PMF_TIME_WATERJUMP) {
		PM_WaterJumpMove();
	} else if ( pm->waterlevel > 1 ) {
		// swimming
		PM_WaterMove();
	} else if ( pml.walking ) {
		// walking on ground
		PM_WalkMove();
	} else {
		// airborne
		PM_AirMove();
	}

	PM_Animate();

	// set groundentity, watertype, and waterlevel
	if (DistanceSquared(pm->ps->origin, oldOrigin) > 0) {
		PM_GroundTrace();
		PM_SetWaterLevel();
	}

	// weapons
	PM_Weapon();

	// JUHOX: add weapon kick
	if (
		pm->ps->clientNum < MAX_CLIENTS &&
		pm->ps->stats[STAT_WEAPON_KICK] != 0
	) {
		float kick;
		float move;
		localseed_t seed;

		kick = (float)(pm->ps->stats[STAT_WEAPON_KICK]) / (float)WEAPON_KICK_FACTOR;
		move = AngleKick(&kick);
		pm->ps->stats[STAT_WEAPON_KICK] = (int) (kick * WEAPON_KICK_FACTOR);

		seed.seed0 = pm->ps->clientNum;
		seed.seed1 = pm->ps->ammo[pm->ps->weapon];
		seed.seed2 = pm->ps->generic1;
		seed.seed3 = pm->ps->persistant[PERS_SPAWN_COUNT];
		pm->ps->delta_angles[YAW] += ANGLE2SHORT(move * local_crandom(&seed));
		pm->ps->delta_angles[PITCH] += ANGLE2SHORT(move * local_crandom(&seed));
	}

	// torso animation
	PM_TorsoAnimation();

	// footstep events / legs animations
	PM_Footsteps();

	// entering / leaving water splashes
	PM_WaterEvents();

	// JUHOX: generate pant events
	if (

		pm->ps->clientNum < MAX_CLIENTS &&	// speed up
		pm->ps->persistant[PERS_TEAM] != TEAM_SPECTATOR &&
		pm->ps->stats[STAT_HEALTH] > 0 &&
		pm->waterlevel < 3 &&
		pml.previous_waterlevel < 3 &&
		!(pm->cmd.buttons & BUTTON_HOLD_BREATH)
	) {
		const int pantCycleTime = 1450;	// in msec
		int pantPhase;
		qboolean pantCycleComplete;
		qboolean pantCycle2Complete;

		pantPhase = pm->ps->stats[STAT_PANT_PHASE];
		if (pantPhase < 0) {
			pantCycleComplete = qtrue;
			pantCycle2Complete = qtrue;
			pm->ps->stats[STAT_PANT_PHASE] = pantCycleTime - (pm->ps->commandTime % pantCycleTime);
		}
		else {
			int commandTime;

			commandTime = pm->ps->commandTime + pantPhase;
			oldCommandTime += pantPhase;
			pantCycleComplete = (commandTime / pantCycleTime != oldCommandTime / pantCycleTime);
			pantCycle2Complete = (commandTime / (2*pantCycleTime) != oldCommandTime / (2*pantCycleTime));
		}

		if (
			(pm->ps->stats[STAT_STRENGTH] < LOW_STRENGTH_VALUE && pantCycleComplete) ||
			(pm->ps->stats[STAT_STRENGTH] < 2*LOW_STRENGTH_VALUE && pantCycle2Complete)
		) {
			PM_AddEvent(EV_PANT);
		}
	}

	// snap some parts of playerstate to save network bandwidth
	trap_SnapVector( pm->ps->velocity );
}


/*
================
Pmove

Can be called by either the server or the client
================
*/
void Pmove (pmove_t *pmove) {
	int			finalTime;

	finalTime = pmove->cmd.serverTime;

	if ( finalTime < pmove->ps->commandTime ) return;	// should not happen

	if ( finalTime > pmove->ps->commandTime + 1000 ) {
		pmove->ps->commandTime = finalTime - 1000;
	}

	pmove->ps->pmove_framecount = (pmove->ps->pmove_framecount+1) & ((1<<PS_PMOVEFRAMECOUNTBITS)-1);

	// chop the move up if it is too long, to prevent framerate
	// dependent behavior
	while ( pmove->ps->commandTime != finalTime ) {
		int		msec;

		msec = finalTime - pmove->ps->commandTime;

		if ( pmove->pmove_fixed ) {
			if ( msec > pmove->pmove_msec ) {
				msec = pmove->pmove_msec;
			}
		}
		else {
			if ( msec > 66 ) {
				msec = 66;
			}
		}
		pmove->cmd.serverTime = pmove->ps->commandTime + msec;
		PmoveSingle( pmove );

		if ( pmove->ps->pm_flags & PMF_JUMP_HELD ) {
			pmove->cmd.upmove = 20;
		}
	}

}

