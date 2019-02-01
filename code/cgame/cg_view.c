// Copyright (C) 1999-2000 Id Software, Inc.
//
// cg_view.c -- setup all the parameters (position, angle, etc)
// for a 3D rendering
#include "cg_local.h"

/*
=============================================================================

  MODEL TESTING

The viewthing and gun positioning tools from Q2 have been integrated and
enhanced into a single model testing facility.

Model viewing can begin with either "testmodel <modelname>" or "testgun <modelname>".

The names must be the full pathname after the basedir, like
"models/weapons/v_launch/tris.md3" or "players/male/tris.md3"

Testmodel will create a fake entity 100 units in front of the current view
position, directly facing the viewer.  It will remain immobile, so you can
move around it to view it from different angles.

Testgun will cause the model to follow the player around and supress the real
view weapon model.  The default frame 0 of most guns is completely off screen,
so you will probably have to cycle a couple frames to see it.

"nextframe", "prevframe", "nextskin", and "prevskin" commands will change the
frame or skin of the testmodel.  These are bound to F5, F6, F7, and F8 in
q3default.cfg.

If a gun is being tested, the "gun_x", "gun_y", and "gun_z" variables will let
you adjust the positioning.

Note that none of the model testing features update while the game is paused, so
it may be convenient to test with deathmatch set to 1 so that bringing down the
console doesn't pause the game.

=============================================================================
*/

/*
=================
CG_TestModel_f

Creates an entity in front of the current position, which
can then be moved around
=================
*/
void CG_TestModel_f (void) {
	vec3_t		angles;

	memset( &cg.testModelEntity, 0, sizeof(cg.testModelEntity) );
	if ( trap_Argc() < 2 ) return;

	Q_strncpyz (cg.testModelName, CG_Argv( 1 ), MAX_QPATH );
	cg.testModelEntity.hModel = trap_R_RegisterModel( cg.testModelName );

	if ( trap_Argc() == 3 ) {
		cg.testModelEntity.backlerp = atof( CG_Argv( 2 ) );
		cg.testModelEntity.frame = 1;
		cg.testModelEntity.oldframe = 0;
	}
	if (! cg.testModelEntity.hModel ) {
		CG_Printf( "Can't register model\n" );
		return;
	}

	VectorMA( cg.refdef.vieworg, 100, cg.refdef.viewaxis[0], cg.testModelEntity.origin );

	angles[PITCH] = 0;
	angles[YAW] = 180 + cg.refdefViewAngles[1];
	angles[ROLL] = 0;

	AnglesToAxis( angles, cg.testModelEntity.axis );

	cg.testGun = qfalse;
}

/*
=================
CG_TestGun_f

Replaces the current view weapon with the given model
=================
*/
void CG_TestGun_f (void) {
	CG_TestModel_f();
	cg.testGun = qtrue;
	cg.testModelEntity.renderfx = RF_MINLIGHT | RF_DEPTHHACK | RF_FIRST_PERSON;
}


void CG_TestModelNextFrame_f (void) {
	cg.testModelEntity.frame++;
	CG_Printf( "frame %i\n", cg.testModelEntity.frame );
}

void CG_TestModelPrevFrame_f (void) {
	cg.testModelEntity.frame--;
	if ( cg.testModelEntity.frame < 0 ) {
		cg.testModelEntity.frame = 0;
	}
	CG_Printf( "frame %i\n", cg.testModelEntity.frame );
}

void CG_TestModelNextSkin_f (void) {
	cg.testModelEntity.skinNum++;
	CG_Printf( "skin %i\n", cg.testModelEntity.skinNum );
}

void CG_TestModelPrevSkin_f (void) {
	cg.testModelEntity.skinNum--;
	if ( cg.testModelEntity.skinNum < 0 ) {
		cg.testModelEntity.skinNum = 0;
	}
	CG_Printf( "skin %i\n", cg.testModelEntity.skinNum );
}

static void CG_AddTestModel (void) {
	int		i;

	// re-register the model, because the level may have changed
	cg.testModelEntity.hModel = trap_R_RegisterModel( cg.testModelName );
	if (! cg.testModelEntity.hModel ) {
		CG_Printf ("Can't register model\n");
		return;
	}

	// if testing a gun, set the origin reletive to the view origin
	if ( cg.testGun ) {
		VectorCopy( cg.refdef.vieworg, cg.testModelEntity.origin );
		VectorCopy( cg.refdef.viewaxis[0], cg.testModelEntity.axis[0] );
		VectorCopy( cg.refdef.viewaxis[1], cg.testModelEntity.axis[1] );
		VectorCopy( cg.refdef.viewaxis[2], cg.testModelEntity.axis[2] );

		// allow the position to be adjusted
		for (i=0 ; i<3 ; i++) {
			cg.testModelEntity.origin[i] += cg.refdef.viewaxis[0][i] * cg_gun_x.value;
			cg.testModelEntity.origin[i] += cg.refdef.viewaxis[1][i] * cg_gun_y.value;
			cg.testModelEntity.origin[i] += cg.refdef.viewaxis[2][i] * cg_gun_z.value;
		}
	}

	trap_R_AddRefEntityToScene( &cg.testModelEntity );
}



//============================================================================


/*
=================
CG_CalcVrect

Sets the coordinates of the rendered window
=================
*/
static void CG_CalcVrect (void) {
	int		size;

	// the intermission should allways be full screen
	if ( cg.snap->ps.pm_type == PM_INTERMISSION ) {
		size = 100;
	} else {
		// bound normal viewsize
		if (cg_viewsize.integer < 30) {
			trap_Cvar_Set ("cg_viewsize","30");
			size = 30;
		} else if (cg_viewsize.integer > 100) {
			trap_Cvar_Set ("cg_viewsize","100");
			size = 100;
		} else {
			size = cg_viewsize.integer;
		}

	}
	cg.refdef.width = cgs.glconfig.vidWidth*size/100;
	cg.refdef.width &= ~1;

	cg.refdef.height = cgs.glconfig.vidHeight*size/100;
	cg.refdef.height &= ~1;

	cg.refdef.x = (cgs.glconfig.vidWidth - cg.refdef.width)/2;
	cg.refdef.y = (cgs.glconfig.vidHeight - cg.refdef.height)/2;
}

//==============================================================================


/*
===============
CG_OffsetThirdPersonView

===============
*/
#define	FOCUS_DISTANCE	512
static void CG_OffsetThirdPersonView( void ) {
	vec3_t		forward, right, up;
	vec3_t		view;
	vec3_t		focusAngles;
	trace_t		trace;
	static vec3_t	mins = { -4, -4, -4 };
	static vec3_t	maxs = { 4, 4, 4 };
	vec3_t		focusPoint;
	float		focusDist;
	float		forwardScale, sideScale;

	cg.refdef.vieworg[2] += cg.predictedPlayerState.viewheight;

	VectorCopy( cg.refdefViewAngles, focusAngles );

	if ( focusAngles[PITCH] > 45 ) focusAngles[PITCH] = 45;		// don't go too far overhead

	AngleVectors( focusAngles, forward, NULL, NULL );

	VectorMA( cg.refdef.vieworg, FOCUS_DISTANCE, forward, focusPoint );

	VectorCopy( cg.refdef.vieworg, view );

	view[2] += 8;

	cg.refdefViewAngles[PITCH] *= 0.5;

	AngleVectors( cg.refdefViewAngles, forward, right, up );

	forwardScale = cos( cg_thirdPersonAngle.value / 180 * M_PI );
	sideScale = sin( cg_thirdPersonAngle.value / 180 * M_PI );
	VectorMA( view, -cg_thirdPersonRange.value * forwardScale, forward, view );
	VectorMA( view, -cg_thirdPersonRange.value * sideScale, right, view );


	// trace a ray from the origin to the viewpoint to make sure the view isn't
	// in a solid block.  Use an 8 by 8 block to prevent the view from near clipping anything

	if (!cg_cameraMode.integer) {
		CG_Trace( &trace, cg.refdef.vieworg, mins, maxs, view, cg.predictedPlayerState.clientNum, MASK_SOLID );

		if ( trace.fraction != 1.0 ) {
			VectorCopy( trace.endpos, view );
			view[2] += (1.0 - trace.fraction) * 32;
			// try another trace to this position, because a tunnel may have the ceiling
			// close enogh that this is poking out

			CG_Trace( &trace, cg.refdef.vieworg, mins, maxs, view, cg.predictedPlayerState.clientNum, MASK_SOLID );
			VectorCopy( trace.endpos, view );
		}
	}


	VectorCopy( view, cg.refdef.vieworg );

	// select pitch to look at focus point from vieword
	VectorSubtract( focusPoint, cg.refdef.vieworg, focusPoint );
	focusDist = sqrt( focusPoint[0] * focusPoint[0] + focusPoint[1] * focusPoint[1] );
	if ( focusDist < 1 ) {
		focusDist = 1;	// should never happen
	}
	cg.refdefViewAngles[PITCH] = -180 / M_PI * atan2( focusPoint[2], focusDist );
	cg.refdefViewAngles[YAW] -= cg_thirdPersonAngle.value;
}


// this causes a compiler bug on mac MrC compiler
static void CG_StepOffset( void ) {
	int		timeDelta;

	// smooth out stair climbing
	timeDelta = cg.time - cg.stepTime;
	if ( timeDelta < STEP_TIME ) {
		cg.refdef.vieworg[2] -= cg.stepChange * (STEP_TIME - timeDelta) / STEP_TIME;
	}
}

/*
===============
CG_OffsetFirstPersonView

===============
*/
static void CG_OffsetFirstPersonView( void ) {
	float			*origin;
	float			*angles;
	float			bob;
	float			ratio;
	float			delta;
	float			speed;
	float			f;
	vec3_t			predictedVelocity;
	int				timeDelta;

	if ( cg.snap->ps.pm_type == PM_INTERMISSION ) return;

	// JUHOX: no view offsets for dead spectators
	if ( cg.snap->ps.pm_type == PM_SPECTATOR ) return;

	origin = cg.refdef.vieworg;
	angles = cg.refdefViewAngles;

	// if dead, fix the angle and don't add any kick
	if ( cg.snap->ps.stats[STAT_HEALTH] <= 0 ) {
		angles[ROLL] = 40;
		angles[PITCH] = -15;
		origin[2] += cg.predictedPlayerState.viewheight;
		return;
	}

	// add angles based on weapon kick
	VectorAdd (angles, cg.kick_angles, angles);

	// add angles based on damage kick
	if ( cg.damageTime ) {
		ratio = cg.time - cg.damageTime;
		if ( ratio < DAMAGE_DEFLECT_TIME ) {
			ratio /= DAMAGE_DEFLECT_TIME;
			angles[PITCH] += ratio * cg.v_dmg_pitch;
			angles[ROLL] += ratio * cg.v_dmg_roll;
		} else {
			ratio = 1.0 - ( ratio - DAMAGE_DEFLECT_TIME ) / DAMAGE_RETURN_TIME;
			if ( ratio > 0 ) {
				angles[PITCH] += ratio * cg.v_dmg_pitch;
				angles[ROLL] += ratio * cg.v_dmg_roll;
			}
		}
	}

	// add angles based on velocity
	VectorCopy( cg.predictedPlayerState.velocity, predictedVelocity );

	delta = DotProduct ( predictedVelocity, cg.refdef.viewaxis[0]);
	angles[PITCH] += delta * cg_runpitch.value;

	delta = DotProduct ( predictedVelocity, cg.refdef.viewaxis[1]);
	angles[ROLL] -= delta * cg_runroll.value;

	// make sure the bob is visible even at low speeds
	speed = cg.xyspeed > 200 ? cg.xyspeed : 200;

	delta = cg.bobfracsin * cg_bobpitch.value * speed;
	if (cg.predictedPlayerState.pm_flags & PMF_DUCKED)
		delta *= 3;		// crouching
	angles[PITCH] += delta;
	delta = cg.bobfracsin * cg_bobroll.value * speed;
	if (cg.predictedPlayerState.pm_flags & PMF_DUCKED)
		delta *= 3;		// crouching accentuates roll
	if (cg.bobcycle & 1)
		delta = -delta;
	angles[ROLL] += delta;

//===================================

	// add view height
	origin[2] += cg.predictedPlayerState.viewheight;

	// smooth out duck height changes
	// JUHOX: don't smooth out duck height changes for spectators

	if (cg.snap->ps.persistant[PERS_TEAM] != TEAM_SPECTATOR) {
		timeDelta = cg.time - cg.duckTime;
		if ( timeDelta < DUCK_TIME) {
			cg.refdef.vieworg[2] -= cg.duckChange
				* (DUCK_TIME - timeDelta) / DUCK_TIME;
		}
	}

	// add bob height
	bob = cg.bobfracsin * cg.xyspeed * cg_bobup.value;
	if (bob > 6) bob = 6;

	origin[2] += bob;

	// add fall height
	delta = cg.time - cg.landTime;
	if ( delta < LAND_DEFLECT_TIME ) {
		f = delta / LAND_DEFLECT_TIME;
		cg.refdef.vieworg[2] += cg.landChange * f;
	} else if ( delta < LAND_DEFLECT_TIME + LAND_RETURN_TIME ) {
		delta -= LAND_DEFLECT_TIME;
		f = 1.0 - ( delta / LAND_RETURN_TIME );
		cg.refdef.vieworg[2] += cg.landChange * f;
	}

	// add step offset
	CG_StepOffset();

	// add kick offset
	VectorAdd (origin, cg.kick_origin, origin);
}

//======================================================================

void CG_ZoomDown_f( void ) {
	if ( cg.zoomed ) {
		return;
	}
	cg.zoomed = qtrue;
	cg.zoomTime = cg.time;
}

void CG_ZoomUp_f( void ) {
	if ( !cg.zoomed ) {
		return;
	}
	cg.zoomed = qfalse;
	cg.zoomTime = cg.time;
}


/*
====================
CG_CalcFov

Fixed fov at intermissions, otherwise account for fov variable and zooms.
====================
*/
#define	WAVE_AMPLITUDE	1
#define	WAVE_FREQUENCY	0.4

static int CG_CalcFov( void ) {
	float	x;
	float	phase;
	float	v;
	int		contents;
	float	fov_x, fov_y;
	float	zoomFov;
	float	f;
	int		inwater;

	if ( cg.predictedPlayerState.pm_type == PM_INTERMISSION ) {
		// if in intermission, use a fixed value
		fov_x = 90;
	} else {
		// user selectable
			fov_x = cg_fov.value;
			if ( fov_x < 30 ) {
				fov_x = 30;
			} else if ( fov_x > 160 ) {
				fov_x = 160;
			}
		}

		// account for zooms
		zoomFov = cg_zoomFov.value;
		if ( zoomFov < 1 ) {
			zoomFov = 1;
		} else if ( zoomFov > 160 ) {
			zoomFov = 160;
		}

		if ( cg.zoomed ) {
			f = ( cg.time - cg.zoomTime ) / (float)ZOOM_TIME;
			if ( f > 1.0 ) {
				fov_x = zoomFov;
			} else {
				fov_x = fov_x + f * ( zoomFov - fov_x );
			}
		} else {
			f = ( cg.time - cg.zoomTime ) / (float)ZOOM_TIME;
			if ( f > 1.0 ) {
				fov_x = fov_x;
			} else {
				fov_x = zoomFov + f * ( fov_x - zoomFov );
			}
		}

		// JUHOX: gauntlet provides wider fov
		if (cg.predictedPlayerState.weapon == WP_GAUNTLET) {
			float wideFov;

			wideFov = fov_x * 1.1;

			switch (cg.predictedPlayerState.weaponstate) {
			case WEAPON_DROPPING:
				f = cg.predictedPlayerState.weaponTime / 200.0;
				if (f < 0) f = 0;
				if (f > 1) f = 1;
				fov_x += f * (wideFov - fov_x);
				break;
			case WEAPON_RAISING:
				f = 1.0 - cg.predictedPlayerState.weaponTime / 250.0;
				if (f < 0) f = 0;
				if (f > 1) f = 1;
				fov_x += f * (wideFov - fov_x);
				break;
			default:
				fov_x = wideFov;
				break;
			}
		}

	x = cg.refdef.width / tan( fov_x / 360 * M_PI );
	fov_y = atan2( cg.refdef.height, x );
	fov_y = fov_y * 360 / M_PI;

	// warp if underwater
	contents = CG_PointContents( cg.refdef.vieworg, -1 );
	if ( contents & ( CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA ) ){
		phase = cg.time / 1000.0 * WAVE_FREQUENCY * M_PI * 2;
		v = WAVE_AMPLITUDE * sin( phase );
		fov_x += v;
		fov_y -= v;
		inwater = qtrue;
	}
	else {
		inwater = qfalse;
	}

	// set it
	cg.refdef.fov_x = fov_x;
	cg.refdef.fov_y = fov_y;

	if ( !cg.zoomed ) {
		cg.zoomSensitivity = 1;
	} else {
		cg.zoomSensitivity = cg.refdef.fov_y / 75.0;
	}

	return inwater;
}



/*
===============
CG_DamageBlendBlob

===============
*/
static void CG_DamageBlendBlob( void ) {
	int			t;
	int			maxTime;
	refEntity_t		ent;

	if ( !cg.damageValue ) return;

	// ragePro systems can't fade blends, so don't obscure the screen
	if ( cgs.glconfig.hardwareType == GLHW_RAGEPRO ) return;

	maxTime = DAMAGE_TIME;
	t = cg.time - cg.damageTime;
	if ( t <= 0 || t >= maxTime ) return;

	memset( &ent, 0, sizeof( ent ) );
	ent.reType = RT_SPRITE;
	ent.renderfx = RF_FIRST_PERSON;

	VectorMA( cg.refdef.vieworg, 8, cg.refdef.viewaxis[0], ent.origin );
	VectorMA( ent.origin, cg.damageX * -8, cg.refdef.viewaxis[1], ent.origin );
	VectorMA( ent.origin, cg.damageY * 8, cg.refdef.viewaxis[2], ent.origin );

	ent.radius = cg.damageValue * 3;
	ent.customShader = cgs.media.viewBloodShader;
	ent.shaderRGBA[0] = 255;
	ent.shaderRGBA[1] = 255;
	ent.shaderRGBA[2] = 255;
	ent.shaderRGBA[3] = 200 * ( 1.0 - ((float)t / maxTime) );
	trap_R_AddRefEntityToScene( &ent );
}

/*
===============
JUHOX: CG_AddEarthquake
===============
*/
void CG_AddEarthquake(
	const vec3_t origin, float radius,
	float duration, float fadeIn, float fadeOut,	// in seconds
	float amplitude
) {
	int i;

	if (duration <= 0) {
		float a;

		a = amplitude / 100;

		if (radius > 0) {
			float distance;

			distance = Distance(cg.refdef.vieworg, origin);
			if (distance >= radius) return;

			a *= 1 - (distance / radius);
		}

		cg.additionalTremble += a;
		return;
	}

	for (i = 0; i < MAX_EARTHQUAKES; i++) {
		earthquake_t* quake;

		quake = &cg.earthquakes[i];
		if (quake->startTime) continue;

		quake->startTime = cg.time;
		quake->endTime = (int) floor(cg.time + 1000 * duration + 0.5);
		quake->fadeInTime = (int) floor(1000 * fadeIn + 0.5);
		quake->fadeOutTime = (int) floor(1000 * fadeOut + 0.5);
		quake->amplitude = amplitude;
		VectorCopy(origin, quake->origin);
		quake->radius = radius;
		break;
	}
}


/*
===============
JUHOX: CG_AdjustEarthquakes
===============
*/
void CG_AdjustEarthquakes(const vec3_t delta) {
	int i;

	for (i = 0; i < MAX_EARTHQUAKES; i++) {
		earthquake_t* quake;

		quake = &cg.earthquakes[i];
		if (!quake->startTime) continue;
		if (quake->radius <= 0) continue;

		VectorAdd(quake->origin, delta, quake->origin);
	}
}

/*
===============
JUHOX: AddEarthquakeTremble
===============
*/
static void AddEarthquakeTremble(earthquake_t* quake) {
	int time;
	float a;
	const float offsetAmplitude = 0.2;
	const float angleAmplitude = 0.2;

	if (quake) {
		if (cg.time >= quake->endTime) {
			memset(quake, 0, sizeof(*quake));
			return;
		}

		if (quake->radius > 0) {
			float distance;

			distance = Distance(cg.refdef.vieworg, quake->origin);
			if (distance >= quake->radius) return;

			a = 1 - (distance / quake->radius);
		}
		else {
			a = 1;
		}

		time = cg.time - quake->startTime;
		a *= quake->amplitude / 100;
		if (time < quake->fadeInTime) {
			a *= (float)time / (float)(quake->fadeInTime);
		}
		else if (cg.time > quake->endTime - quake->fadeOutTime) {
			a *= (float)(quake->endTime - cg.time) / (float)(quake->fadeOutTime);
		}
	}
	else {
		a = cg.additionalTremble;
	}

	cg.refdef.vieworg[0] += offsetAmplitude * a * crandom();
	cg.refdef.vieworg[1] += offsetAmplitude * a * crandom();
	cg.refdef.vieworg[2] += offsetAmplitude * a * crandom();
	cg.refdefViewAngles[YAW] += angleAmplitude * a * crandom();
	cg.refdefViewAngles[PITCH] += angleAmplitude * a * crandom();
	cg.refdefViewAngles[ROLL] += angleAmplitude * a * crandom();
}

/*
===============
CG_CalcViewValues

Sets cg.refdef view values
===============
*/
static int CG_CalcViewValues( void ) {
	playerState_t	*ps;

	memset( &cg.refdef, 0, sizeof( cg.refdef ) );

	// calculate size of 3D view
	CG_CalcVrect();

	ps = &cg.predictedPlayerState;

	// intermission view
	if ( ps->pm_type == PM_INTERMISSION ) {
		VectorCopy( ps->origin, cg.refdef.vieworg );
		VectorCopy( ps->viewangles, cg.refdefViewAngles );
		AnglesToAxis( cg.refdefViewAngles, cg.refdef.viewaxis );
		return CG_CalcFov();
	}

	cg.bobcycle = ( ps->bobCycle & 128 ) >> 7;
	cg.bobfracsin = fabs( sin( ( ps->bobCycle & 127 ) / 127.0 * M_PI ) );
	cg.xyspeed = sqrt( ps->velocity[0] * ps->velocity[0] +
		ps->velocity[1] * ps->velocity[1] );


	VectorCopy( ps->origin, cg.refdef.vieworg );
	VectorCopy( ps->viewangles, cg.refdefViewAngles );

	if (cg_cameraOrbit.integer) {
		if (cg.time > cg.nextOrbitTime) {
			cg.nextOrbitTime = cg.time + cg_cameraOrbitDelay.integer;
			cg_thirdPersonAngle.value += cg_cameraOrbit.value;
		}
	}

	// add error decay
	if ( cg_errorDecay.value > 0 ) {
		int		t;
		float	f;

		t = cg.time - cg.predictedErrorTime;
		f = ( cg_errorDecay.value - t ) / cg_errorDecay.value;
		if ( f > 0 && f < 1 ) {
			VectorMA( cg.refdef.vieworg, f, cg.predictedError, cg.refdef.vieworg );
		} else {
			cg.predictedErrorTime = 0;
		}
	}

	if ( cg.renderingThirdPerson ) {
		// back away from character
		CG_OffsetThirdPersonView();
	} else {
		// offset for local bobbing and kicks
		CG_OffsetFirstPersonView();
	}

	// JUHOX: do earthquake
	if (
		cg.earthquakeStartedTime &&
		cg.time < cg.earthquakeEndTime
	) {
		static const struct {
			int time;
			float amplitude;
		} envelope[] = {
			{    0, 0.0},
			{ 1554, 0.7},
			{ 2775, 1.0},
			{ 3664, 0.8},
			{ 4774, 1.0},
			{ 7106, 0.8},
			{ 8938, 0.7},
			{10548, 0.5},
			{16100, 0.0},
			{99999, 0.0}
		};
		int time;
		float f;
		float a;
		const float offsetAmplitude = 0.2;
		const float angleAmplitude = 0.2;

		time = cg.time - cg.earthquakeStartedTime;
		if (cg.earthquakeAmplitude <= 0) {
			int i;

			i = 0;
			while (envelope[i+1].time < time) i++;
			f = (float)(time - envelope[i].time) / (envelope[i+1].time - envelope[i].time);
			a = (1-f) * envelope[i].amplitude + f * envelope[i+1].amplitude;
		}
		else {
			a = cg.earthquakeAmplitude / 100;
			if (time < cg.earthquakeFadeInTime) {
				a *= (float)time / (float)(cg.earthquakeFadeInTime);
			}
			else if (cg.time > cg.earthquakeEndTime - cg.earthquakeFadeOutTime) {
				a *= (float)(cg.earthquakeEndTime - cg.time) / (float)(cg.earthquakeFadeOutTime);
			}
		}
		cg.refdef.vieworg[0] += offsetAmplitude * a * crandom();
		cg.refdef.vieworg[1] += offsetAmplitude * a * crandom();
		cg.refdef.vieworg[2] += offsetAmplitude * a * crandom();
		cg.refdefViewAngles[YAW] += angleAmplitude * a * crandom();
		cg.refdefViewAngles[PITCH] += angleAmplitude * a * crandom();
		cg.refdefViewAngles[ROLL] += angleAmplitude * a * crandom();
	}

// JUHOX: add earthquakes
	{
		int i;

		for (i = 0; i < MAX_EARTHQUAKES; i++) {
			earthquake_t* quake;

			quake = &cg.earthquakes[i];
			if (!quake->startTime) continue;

			AddEarthquakeTremble(quake);
		}
		AddEarthquakeTremble(NULL);	// additional tremble
	}

	// position eye reletive to origin
	AnglesToAxis( cg.refdefViewAngles, cg.refdef.viewaxis );

	// JUHOX: offset vieworg for lens flare editor fine move mode

	if ( cgs.editMode == EM_mlf && cg.lfEditor.selectedLFEnt &&	cg.lfEditor.editMode > LFEEM_none && cg.lfEditor.moveMode == LFEMM_fine	) {
		vec3_t cursor;

		CG_LFEntOrigin(cg.lfEditor.selectedLFEnt, cursor);
		if (cg.lfEditor.editMode == LFEEM_pos) {
			VectorAdd(cg.refdef.vieworg, cg.lfEditor.fmm_offset, cursor);
			CG_SetLFEntOrigin(cg.lfEditor.selectedLFEnt, cursor);
		}
		VectorMA(cursor, -cg.lfEditor.fmm_distance, cg.refdef.viewaxis[0], cg.refdef.vieworg);
	}

	if ( cg.hyperspace ) {
		cg.refdef.rdflags |= RDF_NOWORLDMODEL | RDF_HYPERSPACE;
	}

	// field of view
	return CG_CalcFov();
}


/*
=====================
CG_PowerupTimerSounds
=====================
*/
static void CG_PowerupTimerSounds( void ) {
	int		i;
	int		t;

	// powerup timers going away
	for ( i = 0 ; i < PW_NUM_POWERUPS ; i++ ) {	// JUHOX
		t = cg.snap->ps.powerups[i];
		if ( t <= cg.time ) continue;

		// JUHOX: don't play timer sounds for misused powerups
		if ( i == PW_HASTE || i == PW_BATTLESUIT ||	i == PW_CHARGE || i == PW_BFG_RELOADING	) continue;

		if ( t - cg.time >= POWERUP_BLINKS * POWERUP_BLINK_TIME ) continue;

		if ( ( t - cg.time ) / POWERUP_BLINK_TIME != ( t - cg.oldTime ) / POWERUP_BLINK_TIME ) {
			trap_S_StartSound( NULL, cg.snap->ps.clientNum, CHAN_ITEM, cgs.media.wearOffSound );
		}
	}
}

/*
=====================
CG_AddBufferedSound
=====================
*/
void CG_AddBufferedSound( sfxHandle_t sfx ) {
	if ( !sfx )
		return;
	cg.soundBuffer[cg.soundBufferIn] = sfx;
	cg.soundBufferIn = (cg.soundBufferIn + 1) % MAX_SOUNDBUFFER;
	if (cg.soundBufferIn == cg.soundBufferOut) {
		cg.soundBufferOut++;
	}
}

/*
=====================
CG_PlayBufferedSounds
=====================
*/
static void CG_PlayBufferedSounds( void ) {
	if ( cg.soundTime < cg.time ) {
		if (cg.soundBufferOut != cg.soundBufferIn && cg.soundBuffer[cg.soundBufferOut]) {
			trap_S_StartLocalSound(cg.soundBuffer[cg.soundBufferOut], CHAN_ANNOUNCER);
			cg.soundBuffer[cg.soundBufferOut] = 0;
			cg.soundBufferOut = (cg.soundBufferOut + 1) % MAX_SOUNDBUFFER;
			cg.soundTime = cg.time + 750;
		}
	}
}

/*
===============
JUHOX: CG_DrawMapLensFlare
===============
*/
static void CG_DrawMapLensFlare(
	const lensFlare_t* lf,
	float distance,
	vec3_t center, vec3_t dir, vec3_t angles,
	float alpha, float visibleLight
) {
	refEntity_t ent;
	float radius;

	memset(&ent, 0, sizeof(ent));

	radius = lf->size;

	switch (lf->mode) {
	case LFM_reflexion:
		alpha *= 0.2 * lf->rgba[3];

		radius *= cg.refdef.fov_x / 90;	// lens flares do not change size through zooming

		break;
	case LFM_glare:
		alpha *= 0.14 * lf->rgba[3];
		radius *= visibleLight * 1000000.0 / Square(distance);
		break;
	case LFM_star:
		alpha *= lf->rgba[3];
		radius *= visibleLight * 40000.0 / (distance * sqrt(distance) * sqrt(sqrt(sqrt(distance))));
		break;
	}

	alpha *= visibleLight;
	if (alpha > 255) alpha = 255;

	ent.reType = RT_SPRITE;
	ent.customShader = lf->shader;
	ent.shaderRGBA[0] = lf->rgba[0];
	ent.shaderRGBA[1] = lf->rgba[1];
	ent.shaderRGBA[2] = lf->rgba[2];
	ent.shaderRGBA[3] = alpha;
	ent.radius = radius;

	ent.rotation =
		lf->rotationOffset +
		lf->rotationYawFactor * angles[YAW] +
		lf->rotationPitchFactor * angles[PITCH] +
		lf->rotationRollFactor * angles[ROLL];

	VectorMA(center, lf->pos, dir, ent.origin);
	trap_R_AddRefEntityToScene(&ent);
}


/*
=====================
JUHOX: CG_AddLensFlareMarker
=====================
*/
static void CG_AddLensFlareMarker(int lfe) {
	const lensFlareEntity_t* lfent;
	float radius;
	refEntity_t ent;
	vec3_t origin;

	lfent = &cgs.lensFlareEntities[lfe];

	memset(&ent, 0, sizeof(ent));
	ent.reType = RT_MODEL;
	ent.hModel = trap_R_RegisterModel("models/powerups/health/small_sphere.md3");
	ent.customShader = trap_R_RegisterShader("lfeditorcursor");
	radius = lfent->radius;
	ent.shaderRGBA[0] = 0x00;
	ent.shaderRGBA[1] = 0x80;
	ent.shaderRGBA[2] = 0x00;
	if (lfent->angle >= 0) {
		ent.shaderRGBA[0] = 0x00;
		ent.shaderRGBA[1] = 0x00;
		ent.shaderRGBA[2] = 0x80;
	}
	if (
		!cg.lfEditor.selectedLFEnt &&
		lfe == cg.lfEditor.markedLFEnt
	) {
		int c;

		c = 0x40 * (1 + sin(0.01 * cg.time));
		ent.shaderRGBA[0] += c;
		ent.shaderRGBA[1] += c;
		ent.shaderRGBA[2] += c;
	}
	else if (cg.lfEditor.selectedLFEnt == lfent) {
		ent.shaderRGBA[0] = 0xff;
		ent.shaderRGBA[1] >>= 1;
		ent.shaderRGBA[2] >>= 1;
		if (cg.lfEditor.editMode == LFEEM_radius) {
			radius = cg.lfEditor.selectedLFEnt->lightRadius;
		}
		else if (cg.lfEditor.cursorSize == LFECS_small) {
			radius = 2;
		}
		else if (cg.lfEditor.cursorSize == LFECS_lightRadius) {
			radius = cg.lfEditor.selectedLFEnt->lightRadius;
		}
		else {
			radius = cg.lfEditor.selectedLFEnt->radius;
		}
	}
	CG_LFEntOrigin(lfent, origin);
	VectorCopy(origin, ent.origin);

	ent.origin[2] -= 0.5 * radius;

	ent.axis[0][0] = 0.1 * radius;
	ent.axis[1][1] = 0.1 * radius;
	ent.axis[2][2] = 0.1 * radius;
	ent.nonNormalizedAxes = qtrue;
	trap_R_AddRefEntityToScene(&ent);

	if (lfent->angle >= 0) {
		float len;
		vec3_t end;

		len = 2 * lfent->radius + 10;
		VectorMA(origin, len, lfent->dir, end);
		CG_Draw3DLine(origin, end, trap_R_RegisterShader("dischargeFlash"));

		if (lfent->angle < 70) {
			float size;
			vec3_t right, up;
			vec3_t p1, p2;

			size = len * tan(DEG2RAD(lfent->angle));
			MakeNormalVectors(lfent->dir, right, up);

			VectorMA(end, size, right, p1);
			VectorMA(end, -size, right, p2);
			CG_Draw3DLine(p1, p2, trap_R_RegisterShader("dischargeFlash"));

			VectorMA(end, size, up, p1);
			VectorMA(end, -size, up, p2);
			CG_Draw3DLine(p1, p2, trap_R_RegisterShader("dischargeFlash"));
		}
	}
}


/*
=====================
JUHOX: CG_IsLFVisible
=====================
*/
static qboolean CG_IsLFVisible(const vec3_t origin, const vec3_t pos, float lfradius) {
	trace_t trace;
	CG_SmoothTrace(&trace, cg.refdef.vieworg, NULL, NULL, pos, cg.snap->ps.clientNum, MASK_OPAQUE|CONTENTS_BODY);
	return Distance(trace.endpos, origin) <= lfradius;
}


/*
=====================
JUHOX: CG_ComputeVisibleLightSample
=====================
*/
#define NUMVISSAMPLES 50
static float CG_ComputeVisibleLightSample(
	lensFlareEntity_t* lfent,
	const vec3_t origin,		// redundant, but we have this already
	float distance,				// ditto
	vec3_t visOrigin,
	int quality
) {

	vec3_t vx, vy;
	int visCount;
	int i;

	if (lfent->lightRadius <= 1 || quality < 2) {
		VectorCopy(origin, visOrigin);
		return CG_IsLFVisible(origin, origin, lfent->radius);
	}

	visCount = 0;
	for (i = 0; i < 8; i++) {
		vec3_t corner;

		VectorCopy(origin, corner);
		corner[0] += i&1? lfent->lightRadius : -lfent->lightRadius;
		corner[1] += i&2? lfent->lightRadius : -lfent->lightRadius;
		corner[2] += i&4? lfent->lightRadius : -lfent->lightRadius;
		if (!CG_IsLFVisible(origin, corner, 1.8 * lfent->radius)) continue;	// 1.8 = rough approx. of sqrt(3)
		visCount++;
	}
	if (visCount == 0) {
		VectorClear(visOrigin);
		return 0;
	}
	else if (visCount == 8) {
		VectorCopy(origin, visOrigin);
		return 1;
	}

	{
		vec3_t vz;

		VectorSubtract(origin, cg.refdef.vieworg, vz);
		VectorNormalize(vz);
		CrossProduct(vz, axisDefault[2], vx);
		VectorNormalize(vx);
		CrossProduct(vz, vx, vy);	// NOTE: the handedness of (vx, vy, vz) is not important
	}

	visCount = 0;
	VectorClear(visOrigin);

	for (i = 0; i < NUMVISSAMPLES; i++) {
		vec3_t end;

		VectorCopy(origin, end);
		{
			float angle;
			float radius;
			float x, y;

			angle = (2*M_PI) *i / (float)NUMVISSAMPLES;
			radius = 0.95 * lfent->lightRadius * sqrt(random());

			x = radius * cos(angle);
			y = radius * sin(angle);

			VectorMA(end, x, vx, end);
			VectorMA(end, y, vy, end);
		}

		if (!CG_IsLFVisible(origin, end, lfent->radius)) continue;

		VectorAdd(visOrigin, end, visOrigin);
		visCount++;
	}

	if (visCount > 0) {
		_VectorScale(visOrigin, 1.0 / visCount, visOrigin);
	}

	return (float)visCount / (float)NUMVISSAMPLES;
}


/*
=====================
JUHOX: CG_SetVisibleLightSample
=====================
*/
static void CG_SetVisibleLightSample(lensFlareEntity_t* lfent, float visibleLight, const vec3_t visibleOrigin) {
	vec3_t vorg;

	lfent->lib[lfent->libPos].light = visibleLight;
	VectorCopy(visibleOrigin, vorg);

	if (cgs.gametype == GT_EFH) {
		vorg[0] += cg.currentReferenceX;
		vorg[1] += cg.currentReferenceY;
		vorg[2] += cg.currentReferenceZ;
	}

	VectorCopy(vorg, lfent->lib[lfent->libPos].origin);
	lfent->libPos++;
	if (lfent->libPos >= LIGHT_INTEGRATION_BUFFER_SIZE) {
		lfent->libPos = 0;
	}
	lfent->libNumEntries++;
}


/*
=====================
JUHOX: CG_GetVisibleLight
=====================
*/
static float CG_GetVisibleLight(lensFlareEntity_t* lfent, vec3_t visibleOrigin) {
	int maxLibEntries;
	int i;
	float visLight;
	vec3_t visOrigin;
	int numVisPoints;

	if (lfent->lightRadius < 1) {
		maxLibEntries = 1;
	}
	else if (cg.viewMovement > 1 || lfent->lock) {
		maxLibEntries = LIGHT_INTEGRATION_BUFFER_SIZE / 2;
	}
	else {
		maxLibEntries = LIGHT_INTEGRATION_BUFFER_SIZE;
	}

	if (lfent->libNumEntries > maxLibEntries) {
		lfent->libNumEntries = maxLibEntries;
	}

	visLight = 0;
	VectorClear(visOrigin);
	numVisPoints = 0;
	for (i = 1; i <= lfent->libNumEntries; i++) {
		const lightSample_t* sample;

		sample = &lfent->lib[(lfent->libPos - i) & (LIGHT_INTEGRATION_BUFFER_SIZE - 1)];
		if (sample->light > 0) {
			vec3_t sorg;

			visLight += sample->light;
			VectorCopy(sample->origin, sorg);

			if (cgs.gametype == GT_EFH) {
				sorg[0] -= cg.currentReferenceX;
				sorg[1] -= cg.currentReferenceY;
				sorg[2] -= cg.currentReferenceZ;
			}

			VectorAdd(visOrigin, sorg, visOrigin);
			numVisPoints++;
		}
	}
	if (lfent->libNumEntries > 0) visLight /= lfent->libNumEntries;
	if (numVisPoints > 0) {
		VectorScale(visOrigin, 1.0 / numVisPoints, visibleOrigin);
	}
	else {
		VectorCopy(visOrigin, visibleOrigin);
	}
	return visLight;
}


/*
=====================
JUHOX: CG_AddMapLensFlares
=====================
*/
#define SPRITE_DISTANCE 8
static void CG_AddMapLensFlares(void) {
	int i;

	cg.viewMovement = Distance(cg.refdef.vieworg, cg.lastViewOrigin);
	if (cg.viewMovement > 0) {
		cg.numFramesWithoutViewMovement = 0;
	}
	else {
		cg.numFramesWithoutViewMovement++;
	}

	if (cgs.editMode == EM_mlf) {
		if (cg.lfEditor.drawMode == LFEDM_none) {
			if (!cg.lfEditor.selectedLFEnt && cg.lfEditor.markedLFEnt >= 0) {
				CG_AddLensFlareMarker(cg.lfEditor.markedLFEnt);
			}
			return;
		}
		if (cg.lfEditor.drawMode == LFEDM_marks) {
			int selectedLFEntNum;

			selectedLFEntNum = cg.lfEditor.selectedLFEnt - cgs.lensFlareEntities;
			for (i = 0; i < cgs.numLensFlareEntities; i++) {
				if (i == selectedLFEntNum) continue;

				CG_AddLensFlareMarker(i);
			}
			return;
		}
	}
	else if (
		!cg_lensFlare.integer ||
		(
			!cg_mapFlare.integer &&
			!cg_sunFlare.integer
		)
	) {
		return;
	}

	if (cg.viewMode == VIEW_scanner) return;
	if (cg.clientFrame < 5) return;

	for (i = -1; i < cgs.numLensFlareEntities; i++) {
		lensFlareEntity_t* lfent;
		const lensFlareEffect_t* lfeff;
		vec3_t origin;
		int quality;
		float distanceSqr;
		float distance;
		vec3_t dir;
		vec3_t angles;
		float cosViewAngle;
		float viewAngle;
		float angleToLightSource;
		vec3_t virtualOrigin;
		vec3_t visibleOrigin;
		float visibleLight;
		float alpha;
		vec3_t center;
		int j;

		if (i < 0) {
			if (!cg_sunFlare.integer && cgs.editMode != EM_mlf) continue;

			lfent = &cgs.sunFlare;
			lfeff = lfent->lfeff;
			if (!lfeff) continue;

			VectorAdd(lfent->origin, cg.refdef.vieworg, origin);

			quality = cg_sunFlare.integer;
		}
		else {
			if (!cg_mapFlare.integer && cgs.editMode != EM_mlf) continue;

			lfent = &cgs.lensFlareEntities[i];
			lfeff = lfent->lfeff;
			if (!lfeff) continue;

			CG_LFEntOrigin(lfent, origin);
			quality = cg_mapFlare.integer;
		}

		distanceSqr = DistanceSquared(origin, cg.refdef.vieworg);
		if (lfeff->range > 0 && distanceSqr >= lfeff->rangeSqr) {
			SkipLF:
			lfent->libNumEntries = 0;
			continue;
		}
		if (distanceSqr < Square(16)) goto SkipLF;

		VectorSubtract(origin, cg.refdef.vieworg, dir);

		distance = VectorNormalize(dir);
		cosViewAngle = DotProduct(dir, cg.refdef.viewaxis[0]);
		viewAngle = acos(cosViewAngle) * (180.0 / M_PI);
		if (viewAngle >= 89.99) goto SkipLF;

		// for spotlights
		angleToLightSource = acos(-DotProduct(dir, lfent->dir)) * (180.0 / M_PI);
		if (angleToLightSource > lfent->maxVisAngle) goto SkipLF;

		if (
			cg.numFramesWithoutViewMovement <= LIGHT_INTEGRATION_BUFFER_SIZE ||
			lfent->lock ||
			lfent->libNumEntries <= 0
		) {
			float vls;

			vls = CG_ComputeVisibleLightSample(lfent, origin, distance, visibleOrigin, quality);
			CG_SetVisibleLightSample(lfent, vls, visibleOrigin);
		}

		VectorCopy(origin, visibleOrigin);
		visibleLight = CG_GetVisibleLight(lfent, visibleOrigin);
		if (visibleLight <= 0) continue;

		VectorSubtract(visibleOrigin, cg.refdef.vieworg, dir);
		VectorNormalize(dir);
		vectoangles(dir, angles);
		angles[YAW] = AngleSubtract(angles[YAW], cg.predictedPlayerState.viewangles[YAW]);
		angles[PITCH] = AngleSubtract(angles[PITCH], cg.predictedPlayerState.viewangles[PITCH]);

		VectorMA(cg.refdef.vieworg, SPRITE_DISTANCE / cosViewAngle, dir, virtualOrigin);
		if (lfeff->range < 0) {
			alpha = -lfeff->range / distance;
		}
		else {
			alpha = 1.0 - distance / lfeff->range;
		}

		if (viewAngle > 0.5 * cg.refdef.fov_x) {
			alpha *= 1.0 - (viewAngle - 0.5 * cg.refdef.fov_x) / (90 - 0.5 * cg.refdef.fov_x);
		}

		VectorMA(cg.refdef.vieworg, SPRITE_DISTANCE, cg.refdef.viewaxis[0], center);
		VectorSubtract(virtualOrigin, center, dir);

		{
			vec3_t v;

			VectorRotate(dir, cg.refdef.viewaxis, v);
			angles[ROLL] = 90.0 - atan2(v[2], v[1]) * (180.0/M_PI);
		}

		for (j = 0; j < lfeff->numLensFlares; j++) {
			float a;
			float vl;
			const lensFlare_t* lf;

			a = alpha;
			vl = visibleLight;
			lf = &lfeff->lensFlares[j];
			if (lfent->angle >= 0) {
				float innerAngle;

				innerAngle = lfent->angle * lf->entityAngleFactor;
				if (angleToLightSource > innerAngle) {
					float fadeAngle;

					fadeAngle = lfeff->fadeAngle * lf->fadeAngleFactor;
					if (fadeAngle < 0.1) continue;
					if (angleToLightSource >= innerAngle + fadeAngle) continue;

					vl *= 1.0 - (angleToLightSource - innerAngle) / fadeAngle;
				}
			}
			if (lf->intensityThreshold > 0) {
				float threshold;
				float intensity;

				threshold = lf->intensityThreshold;
				intensity = a * vl;
				if (intensity < threshold) continue;
				intensity -= threshold;
				if (lfeff->range >= 0) intensity /= 1 - threshold;
				a = intensity / vl;
			}
			CG_DrawMapLensFlare(lf, distance, center, dir, angles, a, vl);
		}
	}

	VectorCopy(cg.refdef.vieworg, cg.lastViewOrigin);
}


/*
=====================
JUHOX: CG_AddLFEditorCursor
=====================
*/
void CG_AddLFEditorCursor(void) {
	trace_t trace;
	vec3_t end;
	refEntity_t ent;

	if (cgs.editMode != EM_mlf) return;

	cg.lfEditor.markedLFEnt = -1;
	if (!cg.lfEditor.selectedLFEnt) {
		int i;
		float lowestWeight;

		lowestWeight = 10000000.0;
		for (i = 0; i < cgs.numLensFlareEntities; i++) {
			const lensFlareEntity_t* lfent;
			vec3_t origin;
			vec3_t dir;
			float distance;
			float alpha;
			float weight;

			lfent = &cgs.lensFlareEntities[i];
			if (!lfent->lfeff) continue;

			CG_LFEntOrigin(lfent, origin);
			VectorSubtract(origin, cg.refdef.vieworg, dir);
			distance = VectorNormalize(dir);
			if (distance > 2000) continue;

			alpha = acos(DotProduct(dir, cg.refdef.viewaxis[0])) * (180.0 / M_PI);
			if (alpha > 10.0) continue;

			weight = alpha * distance;
			if (weight >= lowestWeight) continue;

			lowestWeight = weight;
			cg.lfEditor.markedLFEnt = i;
		}
		return;
	}

	if (cg.lfEditor.editMode == LFEEM_pos) {
		if (cg.lfEditor.moveMode == LFEMM_coarse) {
			vec3_t cursor;

			VectorMA(cg.refdef.vieworg, 10000, cg.refdef.viewaxis[0], end);
			CG_SmoothTrace(&trace, cg.refdef.vieworg, NULL, NULL, end, -1, MASK_OPAQUE|CONTENTS_BODY);
			VectorMA(trace.endpos, -1, cg.refdef.viewaxis[0], cursor);
			CG_SetLFEntOrigin(cg.lfEditor.selectedLFEnt, cursor);
		}
		// NOTE: LFEMM_fine handled in CG_CalcViewValues()
	}

	CG_AddLensFlareMarker(cg.lfEditor.selectedLFEnt - cgs.lensFlareEntities);

	{
		int i;

		for (i = 0; i < 50; i++) {
			vec3_t dir;
			float len;
			int grey;

			dir[0] = crandom();
			dir[1] = crandom();
			dir[2] = crandom();
			len = VectorNormalize(dir);
			if (len > 1 || len < 0.01) continue;

			CG_LFEntOrigin(cg.lfEditor.selectedLFEnt, end);
			VectorMA(end, cg.lfEditor.selectedLFEnt->radius, dir, end);
			CG_SmoothTrace(&trace, cg.refdef.vieworg, NULL, NULL, end, -1, MASK_OPAQUE|CONTENTS_BODY);
			if (trace.fraction < 1) continue;

			VectorSubtract(end, cg.refdef.vieworg, dir);
			VectorNormalize(dir);
			VectorMA(cg.refdef.vieworg, 8, dir, end);

			memset(&ent, 0, sizeof(ent));
			ent.reType = RT_SPRITE;
			VectorCopy(end, ent.origin);
			ent.customShader = trap_R_RegisterShader("tssgroupTemporary");
			grey = rand() & 0xff;
			ent.shaderRGBA[0] = grey;
			ent.shaderRGBA[1] = grey;
			ent.shaderRGBA[2] = grey;
			ent.shaderRGBA[3] = 0xff;
			ent.radius = 0.05;
			trap_R_AddRefEntityToScene(&ent);
		}
	}
}

//=========================================================================

/*
=================
CG_DrawActiveFrame

Generates and draws a game scene and status information at the given time.
=================
*/
void CG_DrawActiveFrame( int serverTime, stereoFrame_t stereoView, qboolean demoPlayback ) {
	int		inwater;

#if SCREENSHOT_TOOLS	// JUHOX
	cg.stopTime = atoi(CG_ConfigString(CS_STOPTIME));
	if (cg.stopTime) {
		cg.timeOffset = serverTime - cg.time;
	}
	else {
		cg.timeOffset = 0;
	}
#endif

	cg.time = serverTime;
	cg.demoPlayback = demoPlayback;

	// update cvars
	CG_UpdateCvars();

	// if we are only updating the screen as a loading
	// pacifier, don't even try to read snapshots
	if ( cg.infoScreenText[0] != 0 ) {
		CG_DrawInformation();
		return;
	}

	// any looped sounds will be respecified as entities
	// are added to the render list
	trap_S_ClearLoopingSounds(qfalse);

	// clear all the render lists
	trap_R_ClearScene();

	// set up cg.snap and possibly cg.nextSnap
	CG_ProcessSnapshots();

	// if we haven't received any snapshots yet, all
	// we can draw is the information screen
	if ( !cg.snap || ( cg.snap->snapFlags & SNAPFLAG_NOT_ACTIVE ) ) {
		CG_DrawInformation();
		return;
	}

	// let the client system know what our weapon and zoom settings are
	CG_AutoSwitchToBestWeapon();
	if (cg.weaponSelect == WP_NONE) cg.weaponSelect = cg.snap->ps.weapon;
	trap_SetUserCmdValue(cg.weaponSelect==WP_NONE? WP_MACHINEGUN : cg.weaponSelect, cg.zoomSensitivity );

	// this counter will be bumped for every valid scene we generate
	cg.clientFrame++;

	// update cg.predictedPlayerState
	CG_PredictPlayerState();

#if MEETING	// JUHOX: draw meeting screen
	if (
		atoi(CG_ConfigString(CS_MEETING)) ||
		cg.predictedPlayerState.pm_type == PM_MEETING
	) {
		qhandle_t levelshot;

		CG_FillRect(0, 0, 640, 480, colorBlack);
		levelshot = trap_R_RegisterShaderNoMip(
			va("levelshots/%s.tga", Info_ValueForKey(CG_ConfigString(CS_SERVERINFO), "mapname"))
		);
		if (!levelshot) {
			levelshot = trap_R_RegisterShaderNoMip("menu/art/unknownmap");
		}
		trap_R_SetColor(NULL);
		CG_DrawPic(160, 180, 320, 240, levelshot);

		cg.scoreFadeTime = cg.time;
		cg.scoreBoardShowing = CG_DrawOldScoreboard();

		if (
			!cg.scoresRequestTime ||
			cg.scoresRequestTime + 2000 < cg.time
		) {
			cg.scoresRequestTime = cg.time;
			trap_SendClientCommand("score");
		}

		CG_DrawVote();
		CG_DrawTeamVote();
		return;
	}
#endif


	cg.renderingThirdPerson = (cg_thirdPerson.integer || (cg.snap->ps.stats[STAT_HEALTH] <= 0)) && cg.snap->ps.pm_type != PM_SPECTATOR;

	// build cg.refdef
	inwater = CG_CalcViewValues();

	cg.additionalTremble = 0;	// JUHOX

	// JUHOX: fill framebuffer with the picture to show on cloaked players
	if (cg_glassCloaking.integer) {
		qboolean cloakedPlayers;

		// are there any cloaked players to draw?
		cloakedPlayers = cg.snap->ps.powerups[PW_INVIS]? qtrue : qfalse;
		if (!cloakedPlayers) {
			int i;

			for (i = 0; i < cg.snap->numEntities; i++) {
				centity_t* cent;

				cent = &cg_entities[cg.snap->entities[i].number];
				if (cent->currentState.eType != ET_PLAYER) continue;
				if (!(cent->currentState.powerups & (1 << PW_INVIS))) continue;

				cloakedPlayers = qtrue;
				break;
			}
		}

		if (cloakedPlayers) {
			float fov_x;
			float fov_y;
			vec3_t vieworg;
			vec3_t forward, right, up;

			fov_x = cg.refdef.fov_x;
			fov_y = cg.refdef.fov_y;
			cg.refdef.fov_x *= 0.95;
			cg.refdef.fov_y *= 0.95;

			VectorCopy(cg.refdef.vieworg, vieworg);
			AngleVectors(cg.refdefViewAngles, forward, right, up);
			VectorMA(cg.refdef.vieworg, 8, forward, cg.refdef.vieworg);

			if (!cg.hyperspace) {
				CG_AddPacketEntitiesForGlassLook();
				CG_AddNearbox();
			}

			cg.refdef.time = cg.time;
			memcpy(cg.refdef.areamask, cg.snap->areamask, sizeof(cg.refdef.areamask));

			trap_R_RenderScene(&cg.refdef);

			trap_R_ClearScene();	// it seems trap_R_RenderScene() does this too, so we can't optimize :(

			cg.refdef.fov_x = fov_x;
			cg.refdef.fov_y = fov_y;
			VectorCopy(vieworg, cg.refdef.vieworg);
		}
	}

	// first person blend blobs, done after AnglesToAxis
	if ( !cg.renderingThirdPerson ) {
		CG_DamageBlendBlob();
	}

	// build the render lists
	if ( !cg.hyperspace ) {
		CG_AddNearbox();	// JUHOX
		CG_AddPacketEntities();			// adter calcViewValues, so predicted player state is correct
		CG_AddMarks();

        // JUHOX: add the end sequence lightning marks
		if (cgs.gametype == GT_STU && cg.endPhaseTime > 0 && cg.time - cg.endPhaseTime < 20000) {
			int time;

			time = cg.time - cg.endPhaseTime;
			if (time > 10000) time = 20000 - time;
			CG_AddLightningMarks(time / 750);

			if (random() < 0.0005 * time * 0.001 * (cg.time - cg.endPhaseLastDischargeSoundTime)) {
				cg.endPhaseLastDischargeSoundTime = cg.time;

				trap_S_StartLocalSound(cgs.media.dischargeFlashSound, CHAN_AUTO);
			}
		}

		CG_AddParticles ();
		CG_AddLocalEntities();
		CG_AddMapLensFlares();
	}

	CG_AddViewWeapon( &cg.predictedPlayerState );

	// add buffered sounds
	CG_PlayBufferedSounds();

	// play buffered voice chats
	CG_PlayBufferedVoiceChats();

	// finish up the rest of the refdef
	if ( cg.testModelEntity.hModel ) CG_AddTestModel();

	cg.refdef.time = cg.time;
	memcpy( cg.refdef.areamask, cg.snap->areamask, sizeof( cg.refdef.areamask ) );

	// warning sounds when powerup is wearing off
	CG_PowerupTimerSounds();

	// update audio positions
	/*
    vec3_t worldOrigin;
    VectorAdd(cg.refdef.vieworg, currentReference, worldOrigin);
    trap_S_Respatialize(cg.snap->ps.clientNum, worldOrigin, cg.refdef.viewaxis, inwater);
    */
	// JUHOX: start the earthquake sound
	if (cg.earthquakeSoundCounter > 0) {
		if (cg.lastEarhquakeSoundStartedTime < cg.time - 200) {
			cg.earthquakeSoundCounter--;
			trap_S_StartLocalSound(cgs.media.earthquakeSound, CHAN_VOICE);
			cg.lastEarhquakeSoundStartedTime = cg.time + rand() % 20 - 10;
		}
	}

	// JUHOX: check artefact detector
	if (!cg.lastDetectorCheckTime) {
		// initializing
		cg.lastDetectorCheckTime = cg.time;
		cg.detector = 0;
	}
	else if (cg.predictedPlayerState.pm_type == PM_NORMAL) {
		float msec;
		int dist;

		msec = cg.time - cg.lastDetectorCheckTime;
		cg.lastDetectorCheckTime = cg.time;

		dist = cg.snap->ps.stats[STAT_DETECTOR];
		if (dist >= 100 && dist < 3000) {
			cg.detector += msec / dist;
			if (cg.detector >= 1) {
				trap_S_StartLocalSound(cgs.media.detectorBeepSound, CHAN_ITEM);

				cg.detectorBeepTime = cg.time;

				cg.detector -= (int) cg.detector;
			}
		}
	}


	// make sure the lagometerSample and frame timing isn't done twice when in stereo
	if ( stereoView != STEREO_RIGHT ) {
		cg.frametime = cg.time - cg.oldTime;
		if ( cg.frametime < 0 ) {
			cg.frametime = 0;
		}
		cg.oldTime = cg.time;
		CG_AddLagometerFrameInfo();
	}
	if (cg_timescale.value != cg_timescaleFadeEnd.value) {
		if (cg_timescale.value < cg_timescaleFadeEnd.value) {
			cg_timescale.value += cg_timescaleFadeSpeed.value * ((float)cg.frametime) / 1000;
			if (cg_timescale.value > cg_timescaleFadeEnd.value)
				cg_timescale.value = cg_timescaleFadeEnd.value;
		}
		else {
			cg_timescale.value -= cg_timescaleFadeSpeed.value * ((float)cg.frametime) / 1000;
			if (cg_timescale.value < cg_timescaleFadeEnd.value)
				cg_timescale.value = cg_timescaleFadeEnd.value;
		}
		if (cg_timescaleFadeSpeed.value) {
			trap_Cvar_Set("timescale", va("%f", cg_timescale.value));
		}
	}

	// actually issue the rendering calls
	CG_DrawActive( stereoView );

	CG_RunPlayListFrame();	// JUHOX

	if ( cg_stats.integer ) {
		CG_Printf( "cg.clientFrame:%i\n", cg.clientFrame );
	}

}
