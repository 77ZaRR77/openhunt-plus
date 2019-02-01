// Copyright (C) 1999-2000 Id Software, Inc.
//
// cg_ents.c -- present snapshot entities, happens every single frame


//
// JUHOX: sound fix for EFH
//
// CAUTION: This must be done before including "cg_local.h"!
//
#include "../game/q_shared.h"
#include "tr_types.h"
#include "../game/bg_public.h"

vec3_t currentReference;
void trap_S_StartSound(vec3_t origin, int entityNum, int entchannel, sfxHandle_t sfx);
void trap_S_AddLoopingSound(int entityNum, const vec3_t origin, const vec3_t velocity, sfxHandle_t sfx);
void trap_S_AddRealLoopingSound(int entityNum, const vec3_t origin, const vec3_t velocity, sfxHandle_t sfx);

void trap_S_StartSound_fixed(vec3_t origin, int entityNum, int entchannel, sfxHandle_t sfx) {
	if (origin) {
		vec3_t worldOrigin;

		VectorAdd(origin, currentReference, worldOrigin);
		trap_S_StartSound(worldOrigin, entityNum, entchannel, sfx);
	}
	else {
		trap_S_StartSound(NULL, entityNum, entchannel, sfx);
	}
}

void trap_S_AddLoopingSound_fixed(int entityNum, const vec3_t origin, const vec3_t velocity, sfxHandle_t sfx) {
	if (origin) {
		vec3_t worldOrigin;

		VectorAdd(origin, currentReference, worldOrigin);
		trap_S_AddLoopingSound(entityNum, worldOrigin, velocity, sfx);
	}
	else {
		trap_S_AddLoopingSound(entityNum, origin, velocity, sfx);
	}
}

void trap_S_AddRealLoopingSound_fixed(int entityNum, const vec3_t origin, const vec3_t velocity, sfxHandle_t sfx) {
	if (origin) {
		vec3_t worldOrigin;

		VectorAdd(origin, currentReference, worldOrigin);
		trap_S_AddRealLoopingSound(entityNum, worldOrigin, velocity, sfx);
	}
	else {
		trap_S_AddRealLoopingSound(entityNum, origin, velocity, sfx);
	}
}


#include "cg_local.h"


// JUHOX: variables & definitions for EFH
#define MAX_SORTED_MOVERS MAX_ENTITIES_IN_SNAPSHOT

typedef struct {
	centity_t* cent;
	float distance;
} sortedMover_t;

static qboolean sortMovers;
static int numSortedMovers;
static sortedMover_t sortedMovers[MAX_SORTED_MOVERS];


/*
======================
CG_PositionEntityOnTag

Modifies the entities position and axis by the given
tag location
======================
*/
void CG_PositionEntityOnTag( refEntity_t *entity, const refEntity_t *parent,
							qhandle_t parentModel, char *tagName ) {
	int				i;
	orientation_t	lerped;

	// lerp the tag
	trap_R_LerpTag( &lerped, parentModel, parent->oldframe, parent->frame,
		1.0 - parent->backlerp, tagName );

	// FIXME: allow origin offsets along tag?
	VectorCopy( parent->origin, entity->origin );
	for ( i = 0 ; i < 3 ; i++ ) {
		VectorMA( entity->origin, lerped.origin[i], parent->axis[i], entity->origin );
	}

	// had to cast away the const to avoid compiler problems...
	MatrixMultiply( lerped.axis, ((refEntity_t *)parent)->axis, entity->axis );
	entity->backlerp = parent->backlerp;
}


/*
======================
CG_PositionRotatedEntityOnTag

Modifies the entities position and axis by the given
tag location
======================
*/
void CG_PositionRotatedEntityOnTag( refEntity_t *entity, const refEntity_t *parent,
							qhandle_t parentModel, char *tagName ) {
	int				i;
	orientation_t	lerped;
	vec3_t			tempAxis[3];

	// lerp the tag
	trap_R_LerpTag( &lerped, parentModel, parent->oldframe, parent->frame,
		1.0 - parent->backlerp, tagName );

	// FIXME: allow origin offsets along tag?
	VectorCopy( parent->origin, entity->origin );
	for ( i = 0 ; i < 3 ; i++ ) {
		VectorMA( entity->origin, lerped.origin[i], parent->axis[i], entity->origin );
	}

	// had to cast away the const to avoid compiler problems...
	MatrixMultiply( entity->axis, lerped.axis, tempAxis );
	MatrixMultiply( tempAxis, ((refEntity_t *)parent)->axis, entity->axis );
}



/*
==========================================================================

FUNCTIONS CALLED EACH FRAME

==========================================================================
*/

/*
======================
CG_SetEntitySoundPosition

Also called by event processing code
======================
*/
void CG_SetEntitySoundPosition( centity_t *cent ) {
	// JUHOX: sound fix for EFH

	vec3_t worldOrigin;

	VectorAdd(cent->lerpOrigin, currentReference, worldOrigin);
	if (cent->currentState.solid == SOLID_BMODEL) {
		VectorAdd(worldOrigin, cgs.inlineModelMidpoints[cent->currentState.modelindex], worldOrigin);
	}
	trap_S_UpdateEntityPosition(cent->currentState.number, worldOrigin);

}

/*
==================
CG_EntityEffects

Add continuous entity effects, like local entity emission and lighting
==================
*/
static void CG_EntityEffects( centity_t *cent ) {

	// update sound origins
	CG_SetEntitySoundPosition( cent );

	// add loop sound
	if ( cent->currentState.loopSound ) {
		if (cent->currentState.eType != ET_SPEAKER) {
			trap_S_AddLoopingSound( cent->currentState.number, cent->lerpOrigin, vec3_origin,
				cgs.gameSounds[ cent->currentState.loopSound ] );
		} else {
			trap_S_AddRealLoopingSound( cent->currentState.number, cent->lerpOrigin, vec3_origin,
				cgs.gameSounds[ cent->currentState.loopSound ] );
		}
	}


	// constant light glow
	if ( cent->currentState.constantLight && cent->currentState.eType != ET_PLAYER ) {
		int		cl;
		int		i, r, g, b;

		cl = cent->currentState.constantLight;
		r = cl & 255;
		g = ( cl >> 8 ) & 255;
		b = ( cl >> 16 ) & 255;
		i = ( ( cl >> 24 ) & 255 ) * 4;
		trap_R_AddLightToScene( cent->lerpOrigin, i, r, g, b );
	}
}


/*
==================
CG_General
==================
*/
static void CG_General( centity_t *cent ) {
	refEntity_t			ent;
	entityState_t		*s1;

	s1 = &cent->currentState;

	// if set to invisible, skip
	if (!s1->modelindex) {
		return;
	}

	memset (&ent, 0, sizeof(ent));

	// set frame
	ent.frame = s1->frame;
	ent.oldframe = ent.frame;
	ent.backlerp = 0;

	VectorCopy( cent->lerpOrigin, ent.origin);
	VectorCopy( cent->lerpOrigin, ent.oldorigin);

	ent.hModel = cgs.gameModels[s1->modelindex];

	// player model
	if (s1->number == cg.snap->ps.clientNum) {
		ent.renderfx |= RF_THIRD_PERSON;	// only draw from mirrors
	}

	// convert angles to axis
	AnglesToAxis( cent->lerpAngles, ent.axis );

	// add to refresh list
	trap_R_AddRefEntityToScene (&ent);
}

/*
==================
CG_Speaker

Speaker entities can automatically play sounds
==================
*/
static void CG_Speaker( centity_t *cent ) {
	if ( ! cent->currentState.clientNum ) {	// FIXME: use something other than clientNum...
		return;		// not auto triggering
	}

	if ( cg.time < cent->miscTime ) {
		return;
	}

	trap_S_StartSound (NULL, cent->currentState.number, CHAN_ITEM, cgs.gameSounds[cent->currentState.eventParm] );

	//	ent->s.frame = ent->wait * 10;
	//	ent->s.clientNum = ent->random * 10;
	cent->miscTime = cg.time + cent->currentState.frame * 100 + cent->currentState.clientNum * 100 * crandom();
}

/*
==================
CG_Item
==================
*/
#define PODMARKER_TIMERSIZE 10.0	// JUHOX
static void CG_Item( centity_t *cent ) {
	refEntity_t		ent;
	entityState_t	*es;
	gitem_t			*item;
	int				msec;
	float			frac;
	float			scale;
	weaponInfo_t	*wi;

	es = &cent->currentState;
	if ( es->modelindex >= bg_numItems ) {
		CG_Error( "Bad item index %i on entity", es->modelindex );
	}

	// if set to invisible, skip
	if ( !es->modelindex || ( es->eFlags & EF_NODRAW ) ) {
		return;
	}

	item = &bg_itemlist[ es->modelindex ];

	// JUHOX: always draw the POD marker skull
	if ( cg_simpleItems.integer && item->giType != IT_TEAM && item->giType != IT_POD_MARKER ) {
		memset( &ent, 0, sizeof( ent ) );
		ent.reType = RT_SPRITE;
		VectorCopy( cent->lerpOrigin, ent.origin );
		ent.radius = 14;
		ent.customShader = cg_items[es->modelindex].icon;
		ent.shaderRGBA[0] = 255;
		ent.shaderRGBA[1] = 255;
		ent.shaderRGBA[2] = 255;
		ent.shaderRGBA[3] = 255;
		trap_R_AddRefEntityToScene(&ent);
		return;
	}

	// items bob up and down continuously
	// JUHOX: no bobbing for armor fragments or POD markers
	if (item->giType == IT_POD_MARKER) {
		// no bobbing
	}
	else if (item->giType == IT_ARMOR && item->giTag) {
		cent->lerpOrigin[2] -= /*16*/9;
	}
	else if (
		cgs.gametype == GT_EFH &&
		item->giType == IT_TEAM &&
		item->giTag == PW_BLUEFLAG
	) {
		// no bobbing
	}

	else {
		scale = 0.005 + cent->currentState.number * 0.00001;
		cent->lerpOrigin[2] += 4 + cos( ( cg.time + 1000 ) *  scale ) * 4;
	}

	memset (&ent, 0, sizeof(ent));

	// autorotate at one of two speeds
	// JUHOX: no autorotation for armor fragments or POD markers
	if ( item->giType == IT_HEALTH ) {
		VectorCopy( cg.autoAnglesFast, cent->lerpAngles );
		AxisCopy( cg.autoAxisFast, ent.axis );
	}
	else if (item->giType == IT_POD_MARKER) {
		// no rotation
		AnglesToAxis(cent->lerpAngles, ent.axis);
	}
	else if (item->giType == IT_ARMOR && item->giTag) {
		// armor fragment
		if (cent->currentState.apos.trType == TR_STATIONARY) {
			// stopped
			vec3_t angles;
			vec3_t forward;

			VectorCopy(cent->currentState.apos.trBase, ent.axis[0]);
			angles[YAW] = cent->currentState.apos.trDelta[YAW];
			angles[PITCH] = 0;
			angles[ROLL] = 0;
			AngleVectors(angles, forward, NULL, NULL);
			CrossProduct(ent.axis[0], forward, ent.axis[1]);
			VectorNegate(ent.axis[1], ent.axis[1]);
			CrossProduct(ent.axis[0], ent.axis[1], ent.axis[2]);
		}
		else {
			// falling
			AnglesToAxis(cent->lerpAngles, ent.axis);
		}
		ent.shaderTime = cg.time / 1000.0;	// no hull
	}
	else if (
		cgs.gametype == GT_EFH &&
		item->giType == IT_TEAM &&
		item->giTag == PW_BLUEFLAG
	) {
		// no rotation
		AnglesToAxis(cent->currentState.angles, ent.axis);
	}
	else {
		VectorCopy( cg.autoAngles, cent->lerpAngles );
		AxisCopy( cg.autoAxis, ent.axis );
	}

	wi = NULL;
	// the weapons have their origin where they attatch to player
	// models, so we need to offset them or they will rotate
	// eccentricly
	if ( item->giType == IT_WEAPON ) {
		wi = &cg_weapons[item->giTag];
		cent->lerpOrigin[0] -=
			wi->weaponMidpoint[0] * ent.axis[0][0] +
			wi->weaponMidpoint[1] * ent.axis[1][0] +
			wi->weaponMidpoint[2] * ent.axis[2][0];
		cent->lerpOrigin[1] -=
			wi->weaponMidpoint[0] * ent.axis[0][1] +
			wi->weaponMidpoint[1] * ent.axis[1][1] +
			wi->weaponMidpoint[2] * ent.axis[2][1];
		cent->lerpOrigin[2] -=
			wi->weaponMidpoint[0] * ent.axis[0][2] +
			wi->weaponMidpoint[1] * ent.axis[1][2] +
			wi->weaponMidpoint[2] * ent.axis[2][2];

		cent->lerpOrigin[2] += 8;	// an extra height boost
	}
	// JUHOX: offset armor fragments for correct rotating
	if (item->giType == IT_ARMOR && item->giTag) {
		float* midpoint;

		if (item->quantity == 5) {
			midpoint = cgs.smallArmorFragmentMidpoint;
		}
		else {
			midpoint = cgs.largeArmorFragmentMidpoint;
		}
		cent->lerpOrigin[0] -=
			midpoint[0] * ent.axis[0][0] +
			midpoint[1] * ent.axis[1][0] +
			midpoint[2] * ent.axis[2][0];
		cent->lerpOrigin[1] -=
			midpoint[0] * ent.axis[0][1] +
			midpoint[1] * ent.axis[1][1] +
			midpoint[2] * ent.axis[2][1];
		cent->lerpOrigin[2] -=
			midpoint[0] * ent.axis[0][2] +
			midpoint[1] * ent.axis[1][2] +
			midpoint[2] * ent.axis[2][2];
	}

	ent.hModel = cg_items[es->modelindex].models[0];

	VectorCopy( cent->lerpOrigin, ent.origin);
	VectorCopy( cent->lerpOrigin, ent.oldorigin);

	ent.nonNormalizedAxes = qfalse;

	// if just respawned, slowly scale up
	msec = cg.time - cent->miscTime;
	// JUHOX: armor fragments don't scale up and large armor fragment is bigger
	if (item->giType == IT_ARMOR && item->giTag) {
		frac = 1.0;
		if (item->quantity == 25) {
			frac = 1.5;
			VectorScale( ent.axis[0], frac, ent.axis[0] );
			VectorScale( ent.axis[1], frac, ent.axis[1] );
			VectorScale( ent.axis[2], frac, ent.axis[2] );
			ent.nonNormalizedAxes = qtrue;
		}
	}
	else if (item->giType == IT_POD_MARKER) {
		frac = 3.0;
		VectorScale( ent.axis[0], frac, ent.axis[0] );
		VectorScale( ent.axis[1], frac, ent.axis[1] );
		VectorScale( ent.axis[2], frac, ent.axis[2] );
		ent.nonNormalizedAxes = qtrue;
		ent.customSkin = cgs.media.podSkullSkin;
	}
	else if ( msec >= 0 && msec < ITEM_SCALEUP_TIME ) {
		frac = (float)msec / ITEM_SCALEUP_TIME;
		VectorScale( ent.axis[0], frac, ent.axis[0] );
		VectorScale( ent.axis[1], frac, ent.axis[1] );
		VectorScale( ent.axis[2], frac, ent.axis[2] );
		ent.nonNormalizedAxes = qtrue;
	} else {
		frac = 1.0;
	}

	// items without glow textures need to keep a minimum light value
	// so they are always visible
	if ( ( item->giType == IT_WEAPON ) ||
		 ( item->giType == IT_POD_MARKER ) ||	// JUHOX: minlight for POD markers
		 ( item->giType == IT_ARMOR ) ) {
		ent.renderfx |= RF_MINLIGHT;
	}

	// increase the size of the weapons when they are presented as items
	if ( item->giType == IT_WEAPON ) {
		VectorScale( ent.axis[0], 1.5, ent.axis[0] );
		VectorScale( ent.axis[1], 1.5, ent.axis[1] );
		VectorScale( ent.axis[2], 1.5, ent.axis[2] );
		ent.nonNormalizedAxes = qtrue;
	}

	// JUHOX: set corrected light origin for EFH
	if (cgs.gametype == GT_EFH) {
		ent.renderfx |= RF_LIGHTING_ORIGIN;
		VectorCopy(es->angles2, ent.lightingOrigin);
	}

	// add to refresh list
	trap_R_AddRefEntityToScene(&ent);

	// accompanying rings / spheres for powerups
	if ( !cg_simpleItems.integer )
	{
		vec3_t spinAngles;

		VectorClear( spinAngles );

		if ( item->giType == IT_HEALTH || item->giType == IT_POWERUP )
		{
			if ( ( ent.hModel = cg_items[es->modelindex].models[1] ) != 0 )
			{
				if ( item->giType == IT_POWERUP )
				{
					ent.origin[2] += 12;
					spinAngles[1] = ( cg.time & 1023 ) * 360 / -1024.0f;
				}
				AnglesToAxis( spinAngles, ent.axis );

				// scale up if respawning
				if ( frac != 1.0 ) {
					VectorScale( ent.axis[0], frac, ent.axis[0] );
					VectorScale( ent.axis[1], frac, ent.axis[1] );
					VectorScale( ent.axis[2], frac, ent.axis[2] );
					ent.nonNormalizedAxes = qtrue;
				}
				trap_R_AddRefEntityToScene( &ent );
			}
		}
	}

	// JUHOX: add countdown for POD markers (derived from score plum)
	if (item->giType == IT_POD_MARKER) {
		int time;
		char str[16];
		vec3_t origin;
		vec3_t dir;

		time = (cent->currentState.time - cg.time + 1000) / 1000;
		if (time < 0) time = 0;
		Com_sprintf(str, sizeof(str), "%d", time);

		VectorCopy(ent.origin, origin);
		origin[2] += 30;

		memset(&ent, 0, sizeof(ent));

		ent.reType = RT_SPRITE;
		ent.radius = PODMARKER_TIMERSIZE / 2;
		ent.shaderRGBA[0] = 0xff;
		ent.shaderRGBA[1] = 0xff;
		ent.shaderRGBA[2] = 0xff;
		ent.shaderRGBA[3] = 0xff;
		if (cent->currentState.otherEntityNum != cg.clientNum) {
			switch (cent->currentState.otherEntityNum2) {
			case TEAM_RED:
				ent.shaderRGBA[1] = 0x4c;
				ent.shaderRGBA[2] = 0x4c;
				break;
			case TEAM_BLUE:
				ent.shaderRGBA[0] = 0x4c;
				ent.shaderRGBA[1] = 0x4c;
				break;
			default:
				ent.shaderRGBA[2] = 0x4c;
				break;
			}
		}

		VectorNegate(cg.refdef.viewaxis[1], dir);

		if (DistanceSquared(origin, cg.refdef.vieworg) > 20) {
			int i;
			int n;

			n = strlen(str);
			for (i = 0; i < n; i++) {
				VectorMA(origin, PODMARKER_TIMERSIZE * (i - 0.5 * n + 0.5), dir, ent.origin);
				ent.customShader = cgs.media.numberShaders[str[i] - '0'];
				trap_R_AddRefEntityToScene(&ent);
			}
		}
	}
}

//============================================================================

/*
===============
JUHOX: CG_LensFlare
===============
*/
static void CG_LensFlare(
	vec3_t center, vec3_t dir, float pos, qhandle_t shader,
	float radius,
	int r, int g, int b,
	float alpha, float rotation
) {
	refEntity_t ent;

	memset(&ent, 0, sizeof(ent));
	if (shader != cgs.media.bfgLFStarShader) {
		radius *= cg.refdef.fov_x / 90;	// lens flares do not change size through zooming
		alpha /= radius;
	}
	if ( shader == cgs.media.bfgLFDiscShader ||	shader == cgs.media.bfgLFRingShader	) {
		alpha *= 0.25;
	}
	if (alpha > 255) alpha = 255;

	ent.reType = RT_SPRITE;
	ent.customShader = shader;
	ent.shaderRGBA[0] = r;
	ent.shaderRGBA[1] = g;
	ent.shaderRGBA[2] = b;
	ent.shaderRGBA[3] = alpha;
	ent.radius = radius;
	ent.rotation = rotation;
	VectorMA(center, pos, dir, ent.origin);
	trap_R_AddRefEntityToScene(&ent);
}

/*
===============
CG_Missile
===============
*/
static void CG_Missile( centity_t *cent ) {
	refEntity_t			ent;
	entityState_t		*s1;
	const weaponInfo_t		*weapon;

	s1 = &cent->currentState;
	if ( s1->weapon > WP_NUM_WEAPONS ) {
		s1->weapon = 0;
	}
	weapon = &cg_weapons[s1->weapon];

	// JUHOX: check for strong lights
	switch (s1->weapon) {
	case WP_ROCKET_LAUNCHER:
		CG_CheckStrongLight(cent->lerpOrigin, -200, colorWhite);
		CG_AddEarthquake(cent->lerpOrigin, 300, -1, -1, -1, 100);
		break;
	case WP_PLASMAGUN:
		CG_CheckStrongLight(cent->lerpOrigin, -100, colorWhite);
		CG_AddEarthquake(cent->lerpOrigin, 200, -1, -1, -1, 50);
		break;
	case WP_BFG:
		CG_CheckStrongLight(cent->lerpOrigin, -350, colorWhite);
		CG_AddEarthquake(cent->lerpOrigin, 300, -1, -1, -1, 100);
		break;
	}

	// calculate the axis
	VectorCopy( s1->angles, cent->lerpAngles);

	// add trails
	if ( weapon->missileTrailFunc )
	{
		weapon->missileTrailFunc( cent, weapon );
	}

    // JUHOX FIXME: no dlights in EFH
	if (cgs.gametype == GT_EFH) {
		// do nothing
	}
	else

	// add dynamic light
	if ( weapon->missileDlight ) {
		trap_R_AddLightToScene(cent->lerpOrigin, weapon->missileDlight,
			weapon->missileDlightColor[0], weapon->missileDlightColor[1], weapon->missileDlightColor[2] );
	}

	// add missile sound
	if ( weapon->missileSound ) {
		vec3_t	velocity;

		BG_EvaluateTrajectoryDelta( &cent->currentState.pos, cg.time, velocity );

		trap_S_AddLoopingSound( cent->currentState.number, cent->lerpOrigin, velocity, weapon->missileSound );
	}

	// create the render entity
	memset (&ent, 0, sizeof(ent));
	VectorCopy( cent->lerpOrigin, ent.origin);
	VectorCopy( cent->lerpOrigin, ent.oldorigin);

	if ( cent->currentState.weapon == WP_PLASMAGUN ) {
		ent.reType = RT_SPRITE;
		ent.radius = 16;
		ent.rotation = 0;
		ent.customShader = cgs.media.plasmaBallShader;
		trap_R_AddRefEntityToScene( &ent );
		return;
	}

	// JUHOX: draw new BFG missile lens flare effects
	if (cent->currentState.weapon == WP_BFG) {
		trace_t trace;
		vec3_t dir;
		float dist;
		vec3_t angles;
		vec3_t virtualOrigin;
		vec3_t center;
		float alpha;

		ent.reType = RT_SPRITE;
		ent.radius = 30.0;
		ent.rotation = 0;
		ent.customShader = cgs.media.bfgLFGlareShader;
		ent.shaderRGBA[0] = 255;
		ent.shaderRGBA[1] = 255;
		ent.shaderRGBA[2] = 255;
		ent.shaderRGBA[3] = 255;
		trap_R_AddRefEntityToScene(&ent);

		ent.radius = 50.0;
		ent.shaderRGBA[0] = 0;
		ent.shaderRGBA[1] = 100;
		ent.shaderRGBA[2] = 255;
		ent.shaderRGBA[3] = 255;
		trap_R_AddRefEntityToScene(&ent);

		if (!cg_lensFlare.integer) return;
		if (!cg_missileFlare.integer) return;

		CG_Trace(&trace, cg.refdef.vieworg, NULL, NULL, cent->lerpOrigin, cg.clientNum, MASK_OPAQUE|CONTENTS_BODY);
		if (trace.fraction < 1.0) return;

		VectorSubtract(cent->lerpOrigin, cg.refdef.vieworg, dir);
		dist = VectorNormalize(dir);
		if (dist < 16) return;

		vectoangles(dir, angles);
		angles[YAW] = AngleSubtract(angles[YAW], cg.predictedPlayerState.viewangles[YAW]);
		if (angles[YAW] < -0.75 * cg.refdef.fov_x || angles[YAW] > 0.75 * cg.refdef.fov_x) return;
		angles[PITCH] = AngleSubtract(angles[PITCH], cg.predictedPlayerState.viewangles[PITCH]);
		if (angles[PITCH] < -0.75 * cg.refdef.fov_y || angles[PITCH] > 0.75 * cg.refdef.fov_y) return;

		VectorMA(cg.refdef.vieworg, 8, dir, virtualOrigin);
		VectorCopy(virtualOrigin, ent.origin);
		alpha = 255.0 * 220.0 / dist;

		ent.reType = RT_SPRITE;
		ent.radius = 20000.0 / dist;
		ent.shaderRGBA[0] = 255;
		ent.shaderRGBA[1] = 255;
		ent.shaderRGBA[2] = 255;
		ent.shaderRGBA[3] = 35;
		trap_R_AddRefEntityToScene(&ent);

		ent.radius = 2000.0 / dist;
		trap_R_AddRefEntityToScene(&ent);

		VectorMA(cg.refdef.vieworg, 8, cg.refdef.viewaxis[0], center);
		VectorSubtract(virtualOrigin, center, dir);

		CG_LensFlare(
			center, dir, 1.0, cgs.media.bfgLFLineShader, 30.0,
			255, 255, 255,
			alpha, angles[YAW] + 90
		);

		CG_LensFlare(center, dir, 3, cgs.media.bfgLFRingShader, 1.7, 255, 255, 255, alpha, 0);
		CG_LensFlare(center, dir, 1.5, cgs.media.bfgLFDiscShader, 0.9, 255, 170, 170, alpha, 0);

		CG_LensFlare(center, dir, 1, cgs.media.bfgLFStarShader, 40000 / (dist * sqrt(dist) * sqrt(sqrt(sqrt(dist)))), 255, 255, 255, 255, 3 * angles[YAW]);

		CG_LensFlare(center, dir, 0.5, cgs.media.bfgLFDiscShader, 1.5, 170, 255, 255, alpha, 0);
		CG_LensFlare(center, dir, 0.3, cgs.media.bfgLFRingShader, 1, 192, 255, 192, alpha, 0);
		CG_LensFlare(center, dir, 0.07, cgs.media.bfgLFDiscShader, 0.7, 210, 255, 235, alpha, 0);
		CG_LensFlare(center, dir, -0.25, cgs.media.bfgLFRingShader, 1.4, 230, 255, 255, alpha, 0);
		CG_LensFlare(center, dir, -0.45, cgs.media.bfgLFDiscShader, 0.2, 192, 255, 255, alpha, 0);
		CG_LensFlare(center, dir, -0.6, cgs.media.bfgLFDiscShader, 0.4, 255, 200, 255, alpha, 0);
		CG_LensFlare(center, dir, -0.72, cgs.media.bfgLFDiscShader, 1.1, 255, 200, 170, alpha, 0);
		CG_LensFlare(center, dir, -1.0, cgs.media.bfgLFRingShader, 2, 255, 255, 128, alpha, 0);
		CG_LensFlare(center, dir, -3.4, cgs.media.bfgLFDiscShader, 1.3, 235, 245, 255, alpha, 0);

		return;
	}


	// JUHOX: fireball
	if (
		cent->currentState.weapon == WP_ROCKET_LAUNCHER &&
		cent->currentState.otherEntityNum >= MAX_CLIENTS
	) {
		ent.reType = RT_SPRITE;
		ent.radius = 10.0;
		ent.customShader = cgs.media.bfgLFGlareShader;
		ent.shaderRGBA[0] = 255;
		ent.shaderRGBA[1] = 255;
		ent.shaderRGBA[2] = 255;
		ent.shaderRGBA[3] = 255;
		trap_R_AddRefEntityToScene(&ent);

		ent.radius = 20.0;
		ent.shaderRGBA[0] = 128;
		ent.shaderRGBA[1] = 50;
		ent.shaderRGBA[2] = 0;
		trap_R_AddRefEntityToScene(&ent);

		return;
	}

	// JUHOX: rocket lens flares
	if (
		cent->currentState.weapon == WP_ROCKET_LAUNCHER &&
		cg_lensFlare.integer &&
		cg_missileFlare.integer
	) {
		trace_t trace;

		CG_Trace(&trace, cg.refdef.vieworg, NULL, NULL, cent->lerpOrigin, cg.clientNum, MASK_OPAQUE|CONTENTS_BODY);
		if (trace.fraction >= 1.0) {
			vec3_t dir;
			float dist;
			vec3_t angles;
			vec3_t virtualOrigin;
			vec3_t center;
			float alpha;

			VectorSubtract(cent->lerpOrigin, cg.refdef.vieworg, dir);
			dist = VectorNormalize(dir);
			if (dist > 16) {
				vectoangles(dir, angles);
				angles[YAW] = AngleSubtract(angles[YAW], cg.predictedPlayerState.viewangles[YAW]);
				angles[PITCH] = AngleSubtract(angles[PITCH], cg.predictedPlayerState.viewangles[PITCH]);
				if (
					angles[YAW] >= -0.75 * cg.refdef.fov_x &&
					angles[YAW] <= 0.75 * cg.refdef.fov_x &&
					angles[PITCH] >= -0.75 * cg.refdef.fov_y &&
					angles[PITCH] <= 0.75 * cg.refdef.fov_y
				) {
					VectorMA(cg.refdef.vieworg, 8, dir, virtualOrigin);
					VectorMA(cg.refdef.vieworg, 8, cg.refdef.viewaxis[0], center);
					VectorSubtract(virtualOrigin, center, dir);
					alpha = 255.0 * 220.0 / dist;

					CG_LensFlare(center, dir, 1, cgs.media.bfgLFStarShader, 20000.0 / (dist * sqrt(dist) * sqrt(sqrt(sqrt(dist)))), 255, 200, 180, alpha, 0);
				}
			}
		}
	}

	// flicker between two skins
	ent.skinNum = cg.clientFrame & 1;
	ent.hModel = weapon->missileModel;
	ent.renderfx = weapon->missileRenderfx | RF_NOSHADOW;

	// convert direction of travel into axis
	// JUHOX: compute hook axis
	if (cent->currentState.weapon == WP_GRAPPLING_HOOK) {
		BG_EvaluateTrajectoryDelta(&cent->currentState.pos, cg.time, ent.axis[0]);
		if (VectorNormalize(ent.axis[0]) == 0) {
			ent.axis[0][2] = 1;
		}
	}
	else

	// JUHOX: add metal shader for monster seed
	if (cent->currentState.weapon == WP_MONSTER_LAUNCHER) {
		const float radius = 4;

		ent.customShader = cgs.media.monsterSeedMetalShader;

		ent.origin[2] -= 0.5 * radius;


		ent.axis[0][0] = 0.1 * radius;
		ent.axis[1][1] = 0.1 * radius;
		ent.axis[2][2] = 0.1 * radius;
		ent.nonNormalizedAxes = qtrue;
		trap_R_AddRefEntityToScene(&ent);
		return;
	}
	else

	if ( VectorNormalize2( s1->pos.trDelta, ent.axis[0] ) == 0 ) {
		ent.axis[0][2] = 1;
	}

	// spin as it moves
	if ( s1->pos.trType != TR_STATIONARY ) {
		RotateAroundDirection( ent.axis, cg.time / 4 );
	} else {
		RotateAroundDirection( ent.axis, s1->time );
	}

	// add to refresh list, possibly with quad glow
	CG_AddRefEntityWithPowerups( &ent, s1, TEAM_FREE );
}

/*
===============
CG_Grapple

This is called when the grapple is sitting up against the wall
===============
*/
static void CG_Grapple( centity_t *cent ) {
	// JUHOX: don't draw hook when attached to the wall
	entityState_t		*s1;
	const weaponInfo_t	*weapon;

	s1 = &cent->currentState;
	if ( s1->weapon > WP_NUM_WEAPONS ) {
		s1->weapon = 0;
	}
	weapon = &cg_weapons[s1->weapon];

	// calculate the axis
	VectorCopy( s1->angles, cent->lerpAngles);

	// Will draw cable if needed
	CG_GrappleTrail ( cent, weapon );
}

/*
===============
JUHOX: ScatterRopeSegment
===============
*/
#define ROPE_MAX_SCATTER_TIME 1000
#define ROPE_MAX_SCATTER_ROTATION 1000.0
static void ScatterRopeSegment(vec3_t v, vec3_t w, int time) {
	vec3_t angles;
	vec3_t vel;
	float dist;
	vec3_t mid;
	vec3_t matrix[3];
	vec3_t a;
	vec3_t b;
	vec3_t c;

	if (time <= 0) return;

	srand(BG_VectorChecksum(v));
	angles[0] = 360 * random();
	angles[1] = 360 * random();
	angles[2] = 360 * random();

	AngleVectors(angles, vel, NULL, NULL);
	dist = (300 + 300*random()) * (time / 1000.0);

	angles[0] = ROPE_MAX_SCATTER_ROTATION * random() * (time / 1000.0);
	angles[1] = ROPE_MAX_SCATTER_ROTATION * random() * (time / 1000.0);
	angles[2] = ROPE_MAX_SCATTER_ROTATION * random() * (time / 1000.0);
	AnglesToAxis(angles, matrix);

	mid[0] = 0.5 * (v[0] + w[0]);
	mid[1] = 0.5 * (v[1] + w[1]);
	mid[2] = 0.5 * (v[2] + w[2]);

	VectorSubtract(v, mid, a);
	VectorRotate(a, matrix, b);
	VectorAdd(b, mid, c);
	VectorMA(c, dist, vel, v);

	VectorSubtract(w, mid, a);
	VectorRotate(a, matrix, b);
	VectorAdd(b, mid, c);
	VectorMA(c, dist, vel, w);
}


/*
===============
JUHOX: CG_GrappleRope
===============
*/
static void CG_GrappleRope(centity_t* cent) {
	entityState_t* s;
	int i;
	int n;
	qboolean hasLastPos;
	vec3_t lastPos;
	int scatterTime;

	s = &cent->currentState;
	hasLastPos = qfalse;

	if (
		s->otherEntityNum != ENTITYNUM_NONE &&
		cg_entities[s->otherEntityNum].currentValid
	) {
		switch (cg_entities[s->otherEntityNum].currentState.eType) {
		case ET_GRAPPLE:
		case ET_MISSILE:
			VectorCopy(cg_entities[s->otherEntityNum].lerpOrigin, lastPos);
			hasLastPos = qtrue;
			break;
		case ET_GRAPPLE_ROPE:
			if (cg_entities[s->otherEntityNum].currentState.modelindex == 8) {
				VectorCopy(cg_entities[s->otherEntityNum].currentState.angles2, lastPos);
				hasLastPos = qtrue;
			}
			break;
		}
	}

	n = s->modelindex;
	if (n > 8) return;

	if (cent->currentState.time) {
		scatterTime = cg.time - cent->currentState.time;
		if (scatterTime < 0) scatterTime = 0;
		else if (scatterTime > ROPE_MAX_SCATTER_TIME) scatterTime = ROPE_MAX_SCATTER_TIME;
	}
	else {
		scatterTime = 0;
	}

	for (i = 0; i < n; i++) {
		vec3_t pos;

		switch (i) {
		case 0:
			VectorCopy(s->pos.trBase, pos);
			break;
		case 1:
			VectorCopy(s->pos.trDelta, pos);
			break;
		case 2:
			VectorCopy(s->apos.trBase, pos);
			break;
		case 3:
			VectorCopy(s->apos.trDelta, pos);
			break;
		case 4:
			VectorCopy(s->origin, pos);
			break;
		case 5:
			VectorCopy(s->origin2, pos);
			break;
		case 6:
			VectorCopy(s->angles, pos);
			break;
		case 7:
			VectorCopy(s->angles2, pos);
			break;
		}

		if (hasLastPos) {
			refEntity_t rope;

			memset(&rope, 0, sizeof(rope));
			VectorCopy(lastPos, rope.oldorigin);
			VectorCopy(pos, rope.origin);
			rope.reType = RT_LIGHTNING;
			rope.customShader = cgs.media.grappleShader;
			rope.shaderRGBA[0] = 0xff;
			rope.shaderRGBA[1] = 0xff;
			rope.shaderRGBA[2] = 0xff;
			rope.shaderRGBA[3] = 0xff;

			if (scatterTime > 0) {
				rope.shaderRGBA[3] = (int) (0xff * (ROPE_MAX_SCATTER_TIME - scatterTime) / 1000.0);

				ScatterRopeSegment(rope.origin, rope.oldorigin, scatterTime);
			}

			trap_R_AddRefEntityToScene(&rope);
		}

		VectorCopy(pos, lastPos);
		hasLastPos = qtrue;
	}
}


/*
===============
CG_Mover
===============
*/
/*static*/ void CG_Mover( centity_t *cent ) {	// JUHOX: also called from cg_draw.c for lens flare editor
	refEntity_t			ent;
	entityState_t		*s1;

	s1 = &cent->currentState;

	// JUHOX: only draw movers in the current vis area
	if ( cgs.gametype == GT_EFH && ( s1->time < cg.snap->ps.persistant[PERS_MIN_SEGMENT] ||	s1->time > cg.snap->ps.persistant[PERS_MAX_SEGMENT]	)) {
		return;
	}


	// JUHOX: sort movers in EFH
	if (sortMovers && s1->solid == SOLID_BMODEL) {
		vec3_t origin;
		vec3_t dir;
		float distance;
		int i;
		int k;

		VectorAdd(cent->lerpOrigin, cgs.inlineModelMidpoints[s1->modelindex], origin);
		VectorSubtract(origin, cg.refdef.vieworg, dir);
		distance = DotProduct(dir, cg.refdef.viewaxis[0]);
		if (distance < 0) {
			vec3_t mins, maxs;
			float d;

			trap_R_ModelBounds(cgs.inlineDrawModel[s1->modelindex], mins, maxs);
			for (i = 0; i < 3; i++) {
				if (cg.refdef.viewaxis[0][i] < 0) {
					origin[i] = mins[i];
				}
				else {
					origin[i] = maxs[i];
				}
			}
			VectorAdd(cent->lerpOrigin, origin, origin);
			VectorSubtract(origin, cg.refdef.vieworg, dir);
			d = DotProduct(dir, cg.refdef.viewaxis[0]);
			if (d < 0) return;	// not visible at all
		}
		for (i = 0; i < numSortedMovers; i++) {
			if (distance <= sortedMovers[i].distance) break;
		}

		for (k = numSortedMovers; k > i; k--) {
			sortedMovers[k] = sortedMovers[k-1];
		}
		sortedMovers[i].cent = cent;
		sortedMovers[i].distance = distance;
		numSortedMovers++;
		return;
	}

	// create the render entity
	memset (&ent, 0, sizeof(ent));
	VectorCopy( cent->lerpOrigin, ent.origin);
	VectorCopy( cent->lerpOrigin, ent.oldorigin);
	AnglesToAxis( cent->lerpAngles, ent.axis );

	ent.renderfx = RF_NOSHADOW;

	// flicker between two skins (FIXME?)
	ent.skinNum = ( cg.time >> 6 ) & 1;

	// get the model, either as a bmodel or a modelindex
	if ( s1->solid == SOLID_BMODEL ) {
		ent.hModel = cgs.inlineDrawModel[s1->modelindex];
	} else {
		// JUHOX: set corrected light origin for EFH
		if (cgs.gametype == GT_EFH) {
			ent.renderfx |= RF_LIGHTING_ORIGIN;
			VectorCopy(s1->angles2, ent.lightingOrigin);
		}

		ent.hModel = cgs.gameModels[s1->modelindex];
	}

	// add to refresh list
	trap_R_AddRefEntityToScene(&ent);

	// add the secondary model
	if ( s1->modelindex2 ) {
		ent.skinNum = 0;
		ent.hModel = cgs.gameModels[s1->modelindex2];
		trap_R_AddRefEntityToScene(&ent);
	}

}

/*
===============
JUHOX: CG_DrawSortedMovers
===============
*/
static void CG_DrawSortedMovers(void) {
	int i;

	sortMovers = qfalse;
	for (i = 0; i < numSortedMovers; i++) {
		CG_Mover(sortedMovers[i].cent);
	}
}

/*
===============
CG_Beam

Also called as an event
===============
*/
void CG_Beam( centity_t *cent ) {
	refEntity_t			ent;
	entityState_t		*s1;

	s1 = &cent->currentState;

	// create the render entity
	memset (&ent, 0, sizeof(ent));
	VectorCopy( s1->pos.trBase, ent.origin );
	VectorCopy( s1->origin2, ent.oldorigin );
	AxisClear( ent.axis );
	ent.reType = RT_BEAM;

	ent.renderfx = RF_NOSHADOW;

	// add to refresh list
	trap_R_AddRefEntityToScene(&ent);
}


/*
===============
CG_Portal
===============
*/
static void CG_Portal( centity_t *cent ) {
	refEntity_t			ent;
	entityState_t		*s1;

	s1 = &cent->currentState;

	// create the render entity
	memset (&ent, 0, sizeof(ent));
	VectorCopy( cent->lerpOrigin, ent.origin );
	VectorCopy( s1->origin2, ent.oldorigin );
	ByteToDir( s1->eventParm, ent.axis[0] );
	PerpendicularVector( ent.axis[1], ent.axis[0] );

	// negating this tends to get the directions like they want
	// we really should have a camera roll value
	VectorSubtract( vec3_origin, ent.axis[1], ent.axis[1] );

	CrossProduct( ent.axis[0], ent.axis[1], ent.axis[2] );
	ent.reType = RT_PORTALSURFACE;
	ent.oldframe = s1->powerups;
	ent.frame = s1->frame;		// rotation speed
	ent.skinNum = s1->clientNum/256.0 * 360;	// roll offset

	// add to refresh list
	trap_R_AddRefEntityToScene(&ent);
}


/*
=========================
CG_AdjustPositionForMover

Also called by client movement prediction code
=========================
*/
void CG_AdjustPositionForMover( const vec3_t in, int moverNum, int fromTime, int toTime, vec3_t out ) {
	centity_t	*cent;
	vec3_t	oldOrigin, origin, deltaOrigin;
	vec3_t	oldAngles, angles, deltaAngles;

	if ( moverNum <= 0 || moverNum >= ENTITYNUM_MAX_NORMAL ) {
		VectorCopy( in, out );
		return;
	}

	cent = &cg_entities[ moverNum ];
	if ( cent->currentState.eType != ET_MOVER ) {
		VectorCopy( in, out );
		return;
	}

	BG_EvaluateTrajectory( &cent->currentState.pos, fromTime, oldOrigin );
	BG_EvaluateTrajectory( &cent->currentState.apos, fromTime, oldAngles );

	BG_EvaluateTrajectory( &cent->currentState.pos, toTime, origin );
	BG_EvaluateTrajectory( &cent->currentState.apos, toTime, angles );

	VectorSubtract( origin, oldOrigin, deltaOrigin );
	VectorSubtract( angles, oldAngles, deltaAngles );

	VectorAdd( in, deltaOrigin, out );

	// FIXME: origin change when on a rotating object
}


/*
=============================
CG_InterpolateEntityPosition
=============================
*/
static void CG_InterpolateEntityPosition( centity_t *cent ) {
	vec3_t		current, next;
	float		f;

	// it would be an internal error to find an entity that interpolates without
	// a snapshot ahead of the current one
	if ( cg.nextSnap == NULL ) {
		CG_Error( "CG_InterpoateEntityPosition: cg.nextSnap == NULL" );
	}

	f = cg.frameInterpolation;

	// this will linearize a sine or parabolic curve, but it is important
	// to not extrapolate player positions if more recent data is available
	BG_EvaluateTrajectory( &cent->currentState.pos, cg.snap->serverTime, current );
	BG_EvaluateTrajectory( &cent->nextState.pos, cg.nextSnap->serverTime, next );

	VectorAdd(next, cg.referenceDelta, next);	// JUHOX

	cent->lerpOrigin[0] = current[0] + f * ( next[0] - current[0] );
	cent->lerpOrigin[1] = current[1] + f * ( next[1] - current[1] );
	cent->lerpOrigin[2] = current[2] + f * ( next[2] - current[2] );

	BG_EvaluateTrajectory( &cent->currentState.apos, cg.snap->serverTime, current );
	BG_EvaluateTrajectory( &cent->nextState.apos, cg.nextSnap->serverTime, next );

	cent->lerpAngles[0] = LerpAngle( current[0], next[0], f );
	cent->lerpAngles[1] = LerpAngle( current[1], next[1], f );
	cent->lerpAngles[2] = LerpAngle( current[2], next[2], f );

}

/*
===============
CG_CalcEntityLerpPositions

===============
*/
void CG_CalcEntityLerpPositions( centity_t *cent ) {	// JUHOX: also called from cg_weapons.c

	// if this player does not want to see extrapolated players
	if ( !cg_smoothClients.integer ) {
		// make sure the clients use TR_INTERPOLATE
		if ( cent->currentState.number < MAX_CLIENTS ) {
			cent->currentState.pos.trType = TR_INTERPOLATE;
			cent->nextState.pos.trType = TR_INTERPOLATE;
		}
	}

	if ( cent->interpolate && cent->currentState.pos.trType == TR_INTERPOLATE ) {
		CG_InterpolateEntityPosition( cent );
		return;
	}

	// first see if we can interpolate between two snaps for
	// linear extrapolated clients
	if ( cent->interpolate && cent->currentState.pos.trType == TR_LINEAR_STOP && cent->currentState.number < MAX_CLIENTS) {
		CG_InterpolateEntityPosition( cent );
		return;
	}

	// just use the current frame and evaluate as best we can
	BG_EvaluateTrajectory( &cent->currentState.pos, cg.time, cent->lerpOrigin );
	BG_EvaluateTrajectory( &cent->currentState.apos, cg.time, cent->lerpAngles );

	// adjust for riding a mover if it wasn't rolled into the predicted
	// player state
	if ( cent != &cg.predictedPlayerEntity ) {
		CG_AdjustPositionForMover( cent->lerpOrigin, cent->currentState.groundEntityNum,
		cg.snap->serverTime, cg.time, cent->lerpOrigin );
	}
}

/*
===============
CG_TeamBase
===============
*/
static void CG_TeamBase( centity_t *cent ) {
	refEntity_t model;

	if ( cgs.gametype == GT_CTF) {
		// show the flag base
		memset(&model, 0, sizeof(model));
		model.reType = RT_MODEL;
		VectorCopy( cent->lerpOrigin, model.lightingOrigin );
		VectorCopy( cent->lerpOrigin, model.origin );
		AnglesToAxis( cent->currentState.angles, model.axis );
		if ( cent->currentState.modelindex == TEAM_RED ) {
			model.hModel = cgs.media.redFlagBaseModel;
		}
		else if ( cent->currentState.modelindex == TEAM_BLUE ) {
			model.hModel = cgs.media.blueFlagBaseModel;
		}
		else {
			model.hModel = cgs.media.neutralFlagBaseModel;
		}
		trap_R_AddRefEntityToScene( &model );
	}

}

/*
===============
CG_AddCEntity

===============
*/
static void CG_AddCEntity( centity_t *cent ) {
	// event-only entities will have been dealt with already
	if ( cent->currentState.eType >= ET_EVENTS ) {
		return;
	}

	if (cent->currentState.eType == ET_GRAPPLE_ROPE) {	// JUHOX
		CG_GrappleRope(cent);
		return;
	}

	// calculate the current origin
	CG_CalcEntityLerpPositions( cent );

	// add automatic effects
	CG_EntityEffects( cent );

	switch ( cent->currentState.eType ) {
	default:
		CG_Error( "Bad entity type: %i\n", cent->currentState.eType );
		break;
	case ET_INVISIBLE:
	case ET_PUSH_TRIGGER:
	case ET_TELEPORT_TRIGGER:
		break;
	case ET_GENERAL:
		CG_General( cent );
		break;
	case ET_PLAYER:
		CG_Player( cent );
		break;
	case ET_ITEM:
		CG_Item( cent );
		break;
	case ET_MISSILE:
		CG_Missile( cent );
		break;
	case ET_MOVER:
		CG_Mover( cent );
		break;
	case ET_BEAM:
		CG_Beam( cent );
		break;
	case ET_PORTAL:
		CG_Portal( cent );
		break;
	case ET_SPEAKER:
		CG_Speaker( cent );
		break;
	case ET_GRAPPLE:
		CG_Grapple( cent );
		break;
	case ET_TEAM:
		CG_TeamBase( cent );
		break;
	}
}

/*
===============
JUHOX: CG_DrawLineSegment
===============
*/
float CG_DrawLineSegment(
	const vec3_t start, const vec3_t end,
	float totalLength, float segmentSize, float scrollspeed,
	qhandle_t shader
) {
	float frac;
	refEntity_t ent;

	frac = totalLength / segmentSize;
	frac -= (int) frac;

	memset(&ent, 0, sizeof(ent));
	ent.reType = RT_LIGHTNING;
	ent.customShader = shader;
	VectorCopy(start, ent.origin);
	VectorCopy(end, ent.oldorigin);

	ent.shaderTime = frac / -scrollspeed;
	trap_R_AddRefEntityToScene(&ent);

	return totalLength + Distance(start, end);
}

/*
===============
JUHOX: CG_DisplayNavAid
===============
*/
static void CG_DisplayNavAid(void) {
	if (cg.snap->ps.stats[STAT_HEALTH] <= 0) {
		cg.navAidStopTime = 0;
	}
	if (cg.navAidStopTime) {
		if (cg.time < cg.navAidStopTime) {
			int packet;
			float totalLength;
			vec3_t lastPos;
			qboolean hasLastPos;
			refEntity_t ent;

			hasLastPos = qfalse;
			totalLength = 0;
			for (packet = 0; packet < NAVAID_PACKETS; packet++) {
				int i;

				if (cg.navAidPacketTime[packet] < cg.navAidLatestUpdateTime) continue;

				for (i = 0; i < cg.navAidPacketNumPos[packet]; i++) {
					if (hasLastPos) {
						totalLength = CG_DrawLineSegment(
							lastPos, cg.navAidPacketPos[packet][i],
							totalLength, 256.0, -1.0,
							cg.navAidRetreat? cgs.media.navaid2Shader : cgs.media.navaidShader
						);
					}
					VectorCopy(cg.navAidPacketPos[packet][i], lastPos);
					hasLastPos = qtrue;
				}
			}

			memset(&ent, 0, sizeof(ent));
			ent.customShader = cgs.media.navaidGoalShader;
			if (cg.navAidGoalEntity) {
				VectorCopy(cg.navAidGoalEntity->currentState.pos.trBase, ent.origin);
				if (
					cg.navAidGoalEntityNum >= 0 &&
					cg.navAidGoalEntityNum < MAX_CLIENTS
				) {
					clientInfo_t* ci;

					ci = &cgs.clientinfo[cg.navAidGoalEntityNum];
					if (ci->team != cg.snap->ps.persistant[PERS_TEAM]) {
						ent.customShader = cgs.media.navaidTargetShader;
					}
				}
			}
			else if (cg.navAidGoalAvailable) {
				VectorCopy(cg.navAidGoal, ent.origin);
			}
			else {
				return;
			}
			ent.reType = RT_SPRITE;
			ent.radius = 16;
			trap_R_AddRefEntityToScene(&ent);
		}
		else {
			cg.navAidStopTime = 0;
		}
	}
}

/*
===============
CG_AddPacketEntities

===============
*/
void CG_AddPacketEntities( void ) {
	int					num;
	centity_t			*cent;
	playerState_t		*ps;

	// set cg.frameInterpolation
	if ( cg.nextSnap ) {
		int		delta;

		delta = (cg.nextSnap->serverTime - cg.snap->serverTime);
		if ( delta == 0 ) {
			cg.frameInterpolation = 0;
		} else {
			cg.frameInterpolation = (float)( cg.time - cg.snap->serverTime ) / delta;
		}
	} else {
		cg.frameInterpolation = 0;	// actually, it should never be used, because
									// no entities should be marked as interpolating
	}

	// the auto-rotating items will all have the same axis
	cg.autoAngles[0] = 0;
	cg.autoAngles[1] = ( cg.time & 2047 ) * 360 / 2048.0;
	cg.autoAngles[2] = 0;

	cg.autoAnglesFast[0] = 0;
	cg.autoAnglesFast[1] = ( cg.time & 1023 ) * 360 / 1024.0f;
	cg.autoAnglesFast[2] = 0;

	AnglesToAxis( cg.autoAngles, cg.autoAxis );
	AnglesToAxis( cg.autoAnglesFast, cg.autoAxisFast );

	// generate and add the entity from the playerstate
	ps = &cg.predictedPlayerState;
	BG_PlayerStateToEntityState( ps, &cg.predictedPlayerEntity.currentState, qfalse );
	CG_AddCEntity( &cg.predictedPlayerEntity );

	// lerp the non-predicted value for lightning gun origins
	CG_CalcEntityLerpPositions( &cg_entities[ cg.snap->ps.clientNum ] );

	// JUHOX: sorted movers for EFH
	numSortedMovers = 0;
	sortMovers = (cgs.gametype == GT_EFH);

	cg.navAidGoalEntity = NULL;	// JUHOX
	// add each entity sent over by the server
	for ( num = 0 ; num < cg.snap->numEntities ; num++ ) {
		cent = &cg_entities[ cg.snap->entities[ num ].number ];
		if (cent->currentState.number == cg.navAidGoalEntityNum) cg.navAidGoalEntity = cent;	// JUHOX
		CG_AddCEntity( cent );
	}

	// JUHOX: sorted movers for EFH
	if (sortMovers) {
		CG_DrawSortedMovers();
	}

	CG_DisplayNavAid();	// JUHOX
}

/*
===============
JUHOX: CG_PrepareEntityForGlassLook

derived in parts from CG_EntityEffects()
===============
*/
static void CG_PrepareEntityForGlassLook(centity_t* cent) {
	CG_CalcEntityLerpPositions(cent);

	// constant light glow
	if ( cent->currentState.constantLight ) {
		int		cl;
		int		i, r, g, b;

		cl = cent->currentState.constantLight;
		r = cl & 255;
		g = ( cl >> 8 ) & 255;
		b = ( cl >> 16 ) & 255;
		i = ( ( cl >> 24 ) & 255 ) * 4;
		trap_R_AddLightToScene( cent->lerpOrigin, i, r, g, b );
	}
}

/*
===============
JUHOX: CG_AddPacketEntitiesForGlassLook

derived from CG_AddPacketEntities()
===============
*/
void CG_AddPacketEntitiesForGlassLook(void) {
	int					num;
	centity_t			*cent;

	// set cg.frameInterpolation
	if ( cg.nextSnap ) {
		int		delta;

		delta = (cg.nextSnap->serverTime - cg.snap->serverTime);
		if ( delta == 0 ) {
			cg.frameInterpolation = 0;
		} else {
			cg.frameInterpolation = (float)( cg.time - cg.snap->serverTime ) / delta;
		}
	} else {
		cg.frameInterpolation = 0;	// actually, it should never be used, because
									// no entities should be marked as interpolating
	}

	numSortedMovers = 0;
	sortMovers = (cgs.gametype == GT_EFH);

	// add each mover entity sent over by the server
	// do not use sound nor lighting(?) effects
	for (num = 0; num < cg.snap->numEntities; num++) {
		cent = &cg_entities[cg.snap->entities[num].number];

		switch (cent->currentState.eType) {
		case ET_GENERAL:
			CG_PrepareEntityForGlassLook(cent);
			CG_General(cent);
			break;
		case ET_PLAYER:
			if (!(cent->currentState.powerups & (1 << PW_INVIS))) {
				CG_PrepareEntityForGlassLook(cent);
				CG_Player(cent);
			}
			break;
		case ET_ITEM:
			CG_PrepareEntityForGlassLook(cent);
			CG_Item(cent);
			break;
		case ET_MOVER:
			CG_PrepareEntityForGlassLook(cent);
			CG_Mover(cent);
			break;
		case ET_TEAM:
			CG_PrepareEntityForGlassLook(cent);
			CG_TeamBase(cent);
			break;
		case ET_BEAM:
			CG_PrepareEntityForGlassLook(cent);
			CG_Beam(cent);
			break;
		case ET_GRAPPLE:
			CG_PrepareEntityForGlassLook(cent);
			CG_Grapple(cent);
			break;
		case ET_PORTAL:
			CG_PrepareEntityForGlassLook(cent);
			CG_Portal(cent);
			break;
		case ET_GRAPPLE_ROPE:
			CG_GrappleRope(cent);
			break;
		}
	}

	if (sortMovers) CG_DrawSortedMovers();
}
