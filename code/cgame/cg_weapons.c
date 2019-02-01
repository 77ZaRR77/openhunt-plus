// Copyright (C) 1999-2000 Id Software, Inc.
//
// cg_weapons.c -- events and effects dealing with weapons
#include "cg_local.h"

/*
==========================
CG_MachineGunEjectBrass
==========================
*/
static void CG_MachineGunEjectBrass( centity_t *cent ) {
	localEntity_t	*le;
	refEntity_t		*re;
	vec3_t			velocity, xvelocity;
	vec3_t			offset, xoffset;
	float			waterScale = 1.0f;
	vec3_t			v[3];

	if ( cg_brassTime.integer <= 0 ) {
		return;
	}

	le = CG_AllocLocalEntity();
	re = &le->refEntity;

	velocity[0] = 0;
	velocity[1] = -50 + 40 * crandom();
	velocity[2] = 100 + 50 * crandom();

	le->leType = LE_FRAGMENT;
	le->startTime = cg.time;
	le->endTime = le->startTime + cg_brassTime.integer + ( cg_brassTime.integer / 4 ) * random();

	le->pos.trType = TR_GRAVITY;
	le->pos.trTime = cg.time - (rand()&15);

	AnglesToAxis( cent->lerpAngles, v );

	offset[0] = 8;
	offset[1] = -4;
	offset[2] = 24;

	xoffset[0] = offset[0] * v[0][0] + offset[1] * v[1][0] + offset[2] * v[2][0];
	xoffset[1] = offset[0] * v[0][1] + offset[1] * v[1][1] + offset[2] * v[2][1];
	xoffset[2] = offset[0] * v[0][2] + offset[1] * v[1][2] + offset[2] * v[2][2];
	VectorAdd( cent->lerpOrigin, xoffset, re->origin );

	VectorCopy( re->origin, le->pos.trBase );

	if ( CG_PointContents( re->origin, -1 ) & CONTENTS_WATER ) {
		waterScale = 0.10f;
	}

	xvelocity[0] = velocity[0] * v[0][0] + velocity[1] * v[1][0] + velocity[2] * v[2][0];
	xvelocity[1] = velocity[0] * v[0][1] + velocity[1] * v[1][1] + velocity[2] * v[2][1];
	xvelocity[2] = velocity[0] * v[0][2] + velocity[1] * v[1][2] + velocity[2] * v[2][2];
	VectorScale( xvelocity, waterScale, le->pos.trDelta );

	AxisCopy( axisDefault, re->axis );
	re->hModel = cgs.media.machinegunBrassModel;

	le->bounceFactor = 0.4 * waterScale;

	le->angles.trType = TR_LINEAR;
	le->angles.trTime = cg.time;
	le->angles.trBase[0] = rand()&31;
	le->angles.trBase[1] = rand()&31;
	le->angles.trBase[2] = rand()&31;
	le->angles.trDelta[0] = 2;
	le->angles.trDelta[1] = 1;
	le->angles.trDelta[2] = 0;

	le->leFlags = LEF_TUMBLE;
	le->leBounceSoundType = LEBS_BRASS;
	le->leMarkType = LEMT_NONE;
}

/*
==========================
CG_ShotgunEjectBrass
==========================
*/
static void CG_ShotgunEjectBrass( centity_t *cent ) {
	localEntity_t	*le;
	refEntity_t		*re;
	vec3_t			velocity, xvelocity;
	vec3_t			offset, xoffset;
	vec3_t			v[3];
	int				i;

	if ( cg_brassTime.integer <= 0 ) {
		return;
	}

	for ( i = 0; i < 2; i++ ) {
		float	waterScale = 1.0f;

		le = CG_AllocLocalEntity();
		re = &le->refEntity;

		velocity[0] = 60 + 60 * crandom();
		if ( i == 0 ) {
			velocity[1] = 40 + 10 * crandom();
		} else {
			velocity[1] = -40 + 10 * crandom();
		}
		velocity[2] = 100 + 50 * crandom();

		le->leType = LE_FRAGMENT;
		le->startTime = cg.time;
		le->endTime = le->startTime + cg_brassTime.integer*3 + cg_brassTime.integer * random();

		le->pos.trType = TR_GRAVITY;
		le->pos.trTime = cg.time;

		AnglesToAxis( cent->lerpAngles, v );

		offset[0] = 8;
		offset[1] = 0;
		offset[2] = 24;

		xoffset[0] = offset[0] * v[0][0] + offset[1] * v[1][0] + offset[2] * v[2][0];
		xoffset[1] = offset[0] * v[0][1] + offset[1] * v[1][1] + offset[2] * v[2][1];
		xoffset[2] = offset[0] * v[0][2] + offset[1] * v[1][2] + offset[2] * v[2][2];
		VectorAdd( cent->lerpOrigin, xoffset, re->origin );
		VectorCopy( re->origin, le->pos.trBase );
		if ( CG_PointContents( re->origin, -1 ) & CONTENTS_WATER ) {
			waterScale = 0.10f;
		}

		xvelocity[0] = velocity[0] * v[0][0] + velocity[1] * v[1][0] + velocity[2] * v[2][0];
		xvelocity[1] = velocity[0] * v[0][1] + velocity[1] * v[1][1] + velocity[2] * v[2][1];
		xvelocity[2] = velocity[0] * v[0][2] + velocity[1] * v[1][2] + velocity[2] * v[2][2];
		VectorScale( xvelocity, waterScale, le->pos.trDelta );

		AxisCopy( axisDefault, re->axis );
		re->hModel = cgs.media.shotgunBrassModel;
		le->bounceFactor = 0.3f;

		le->angles.trType = TR_LINEAR;
		le->angles.trTime = cg.time;
		le->angles.trBase[0] = rand()&31;
		le->angles.trBase[1] = rand()&31;
		le->angles.trBase[2] = rand()&31;
		le->angles.trDelta[0] = 1;
		le->angles.trDelta[1] = 0.5;
		le->angles.trDelta[2] = 0;

		le->leFlags = LEF_TUMBLE;
		le->leBounceSoundType = LEBS_BRASS;
		le->leMarkType = LEMT_NONE;
	}
}

/*
==========================
CG_RailTrail
==========================
*/
void CG_RailTrail( clientInfo_t *ci, vec3_t start, vec3_t end ) {
	vec3_t axis[36], move, move2, next_move, vec, temp;
	float  len;
	int    i, j, skip;

	localEntity_t	*le;
	refEntity_t		*re;

#define RADIUS   5	// JUHOX: was 4
#define ROTATION 1
#define SPACING  5

	start[2] -= 4;
	VectorCopy (start, move);
	VectorSubtract (end, start, vec);
	len = VectorNormalize (vec);
	PerpendicularVector(temp, vec);
	for (i = 0 ; i < 36; i++) {
		RotatePointAroundVector(axis[i], vec, temp, i * 10);//banshee 2.4 was 10
	}

	le = CG_AllocLocalEntity();
	re = &le->refEntity;

	le->leType = LE_FADE_RGB;
	le->startTime = cg.time;
	le->endTime = cg.time + cg_railTrailTime.value;
	le->lifeRate = 1.0 / ( le->endTime - le->startTime );

	re->shaderTime = cg.time / 1000.0f;
	re->reType = RT_RAIL_CORE;
	re->customShader = cgs.media.railCoreShader;

	VectorCopy( start, re->origin );
	VectorCopy( end, re->oldorigin );

	re->shaderRGBA[0] = ci->color1[0] * 255;
    re->shaderRGBA[1] = ci->color1[1] * 255;
    re->shaderRGBA[2] = ci->color1[2] * 255;
    re->shaderRGBA[3] = 255;

	le->color[0] = ci->color1[0] * 0.75;
	le->color[1] = ci->color1[1] * 0.75;
	le->color[2] = ci->color1[2] * 0.75;
	le->color[3] = 1.0f;

	AxisClear( re->axis );

	VectorMA(move, 20, vec, move);
	VectorCopy(move, next_move);
	VectorScale (vec, SPACING, vec);

	if (cg_oldRail.integer != 0) {
		// nudge down a bit so it isn't exactly in center
		re->origin[2] -= 8;
		re->oldorigin[2] -= 8;
		return;
	}
	skip = -1;

	j = 18;
    for (i = 0; i < len; i += SPACING) {
		if (i != skip) {
			skip = i + SPACING;
	le = CG_AllocLocalEntity();
	re = &le->refEntity;

            le->leFlags = LEF_PUFF_DONT_SCALE;
			le->leType = LE_TRAIL_PARTICLE;	// JUHOX
			le->radius = 1.1f;	// JUHOX
	le->startTime = cg.time;
            le->endTime = cg.time + (i>>1) + 600;
	le->lifeRate = 1.0 / ( le->endTime - le->startTime );

	re->shaderTime = cg.time / 1000.0f;
            re->reType = RT_SPRITE;
            re->radius = 1.1f;
			re->customShader = cgs.media.railRingsShader;

            re->shaderRGBA[0] = ci->color2[0] * 255;
            re->shaderRGBA[1] = ci->color2[1] * 255;
            re->shaderRGBA[2] = ci->color2[2] * 255;
            re->shaderRGBA[3] = 255;

            le->color[0] = ci->color2[0] * 0.75;
            le->color[1] = ci->color2[1] * 0.75;
            le->color[2] = ci->color2[2] * 0.75;
            le->color[3] = 1.0f;

            le->pos.trType = TR_LINEAR;
            le->pos.trTime = cg.time;

			VectorCopy( move, move2);
            VectorMA(move2, RADIUS , axis[j], move2);
            VectorCopy(move2, le->pos.trBase);

            le->pos.trDelta[0] = axis[j][0]*6;
            le->pos.trDelta[1] = axis[j][1]*6;
            le->pos.trDelta[2] = axis[j][2]*6;
		}

        VectorAdd (move, vec, move);

        j = j + ROTATION < 36 ? j + ROTATION : (j + ROTATION) % 36;
	}
}

/*
==========================
JUHOX: CG_FireballTrail
==========================
*/
static void CG_FireballTrail(centity_t *cent, const weaponInfo_t *wi) {
	localEntity_t	*le;
	refEntity_t		*re;
	entityState_t	*es;
	int contents;
	int lastContents;
	int				t, startTime, step;
	vec3_t origin;
	vec3_t lastPos;



	if (!cg_fireballTrail.integer) return;

	es = &cent->currentState;
	startTime = cent->trailTime;

	BG_EvaluateTrajectory(&es->pos, cg.time, origin);
	contents = CG_PointContents(origin, -1);

	// JUHOX: no bubbles with lava/slime hack
	if (
		(contents & (CONTENTS_SLIME | CONTENTS_LAVA)) &&
		(contents & CONTENTS_WATER)
	) {
		contents &= ~(CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA);
	}

	BG_EvaluateTrajectory(&es->pos, cent->trailTime, lastPos);
	lastContents = CG_PointContents(lastPos, -1);

	cent->trailTime = cg.time;

	if (contents & (CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA)) {
		if (contents & lastContents & CONTENTS_WATER) {
			CG_BubbleTrail(lastPos, origin, 8);
		}
		return;
	}

	if (cg_fireballTrail.integer >= 2) {
		step = 50;

		for (t = step * ((startTime + step) / step); t <= cent->trailTime; t += step) {
			BG_EvaluateTrajectory(&es->pos, t, origin);

			le = CG_AllocLocalEntity();
			re = &le->refEntity;

			le->leType = LE_MOVE_SCALE_RGBFADE;

			le->startTime = t;
			le->endTime = le->startTime + 1000;
			le->lifeRate = 1.0 / (le->endTime - le->startTime);

			le->pos.trType = TR_LINEAR;
			le->pos.trTime = le->startTime;
			VectorCopy(origin, le->pos.trBase);
			VectorScale(es->pos.trDelta, 0.1, le->pos.trDelta);

			le->radius = 100;

			AxisCopy(axisDefault, re->axis);
			re->reType = RT_SPRITE;
			re->customShader = cgs.media.hotAirShader;

			re->rotation = 360 * random();

			le->color[3] = 1;
		}
	}

	step = 15;

	for (t = step * ((startTime + step) / step); t <= cent->trailTime; t += step) {
		float speed;
		vec3_t dir0;
		vec3_t dir1;
		vec3_t dir2;
		float angle;
		float radius;
		vec3_t start;
		vec3_t end;

		BG_EvaluateTrajectory(&es->pos, t, origin);

		le = CG_AllocLocalEntity();
		re = &le->refEntity;

		le->leType = LE_FIREBALL_TRAIL_PARTICLE;

		le->startTime = t;
		le->endTime = le->startTime + 200;
		le->lifeRate = 1.0 / (le->endTime - le->startTime);

		VectorCopy(es->pos.trDelta, dir0);
		speed = VectorNormalize(dir0);
		PerpendicularVector(dir1, dir0);
		CrossProduct(dir0, dir1, dir2);
		angle = random() * 2 * M_PI;
		radius = 25 * random();
		VectorMA(origin, radius * sin(angle) * crandom(), dir1, start);
		VectorMA(start, radius * cos(angle) * crandom(), dir2, start);
		VectorMA(origin, 0.25 * 0.001 * (le->endTime - le->startTime) * speed, dir0, end);

		le->pos.trType = TR_LINEAR;
		le->pos.trTime = le->startTime;
		VectorCopy(start, le->pos.trBase);
		VectorSubtract(end, start, le->pos.trDelta);
		VectorScale(le->pos.trDelta, 1000.0 * le->lifeRate, le->pos.trDelta);

		AxisCopy(axisDefault, re->axis);
		re->reType = RT_SPRITE;
		re->radius = 16;

		re->customShader = trap_R_RegisterShader("flame1");
		re->rotation = 360 * random();

		le->color[0] = 0.78 + 0.22 * random();
		le->color[1] = 0.6 * random();
		le->color[2] = 0;
		le->color[3] = 0.75;
	}

}


/*
==========================
CG_RocketTrail
==========================
*/
static void CG_RocketTrail( centity_t *ent, const weaponInfo_t *wi ) {
	int		step;
	vec3_t	origin, lastPos;
	int		t;
	int		startTime, contents;
	int		lastContents;
	entityState_t	*es;
	vec3_t	up;
	localEntity_t	*smoke;

	if (cg_noProjectileTrail.integer) return;

	// JUHOX: fireball trail
	if (ent->currentState.otherEntityNum == CLIENTNUM_MONSTER_GUARD) {
		CG_FireballTrail(ent, wi);
		return;
	}

	up[0] = 0;
	up[1] = 0;
	up[2] = 0;

	step = 50;

	es = &ent->currentState;
	startTime = ent->trailTime;
	t = step * ( (startTime + step) / step );

	BG_EvaluateTrajectory( &es->pos, cg.time, origin );
	contents = CG_PointContents( origin, -1 );

	// if object (e.g. grenade) is stationary, don't toss up smoke
	if ( es->pos.trType == TR_STATIONARY ) {
		ent->trailTime = cg.time;
		return;
	}

	// JUHOX: no bubbles with lava/slime hack
	if ( (contents & (CONTENTS_SLIME | CONTENTS_LAVA)) && (contents & CONTENTS_WATER) ) {
		contents &= ~(CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA);
	}

	BG_EvaluateTrajectory( &es->pos, ent->trailTime, lastPos );
	lastContents = CG_PointContents( lastPos, -1 );

	ent->trailTime = cg.time;

	if ( contents & ( CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA ) ) {
		if ( contents & lastContents & CONTENTS_WATER ) {
			CG_BubbleTrail( lastPos, origin, 8 );
		}
		return;
	}

	for ( ; t <= ent->trailTime ; t += step ) {
		BG_EvaluateTrajectory( &es->pos, t, lastPos );
		smoke = CG_SmokePuff( lastPos, up, wi->trailRadius, 1, 1, 1, 0.33f, wi->wiTrailTime, t, 0, 0, cgs.media.smokePuffShader );
		// use the optimized local entity add
		smoke->leType = LE_SCALE_FADE;
	}
}

/*
==========================
CG_PlasmaTrail
==========================
*/
static void CG_PlasmaTrail( centity_t *cent, const weaponInfo_t *wi ) {
	// JUHOX: new plasma trail
	localEntity_t	*le;
	refEntity_t		*re;
	entityState_t	*es;
	vec3_t			origin;
	int				t, startTime, step;

	if ( cg_noProjectileTrail.integer || cg_oldPlasma.integer ) return;

	step = 20;

	es = &cent->currentState;
	startTime = cent->trailTime;
	t = step * ( (startTime + step) / step );

	cent->trailTime = cg.time;

	for (; t <= cent->trailTime; t += step) {
		BG_EvaluateTrajectory(&es->pos, t - 20, origin);

		le = CG_AllocLocalEntity();
		re = &le->refEntity;

		le->leType = LE_TRAIL_PARTICLE;

		le->startTime = t;
		le->endTime = le->startTime + 600;
		le->lifeRate = 1.0 / (le->endTime - le->startTime);

		le->pos.trType = TR_LINEAR;
		le->pos.trTime = le->startTime;
		VectorCopy(origin, le->pos.trBase);
		VectorScale(es->pos.trDelta, 0.1, le->pos.trDelta);
		le->pos.trDelta[0] += 50 * crandom();
		le->pos.trDelta[1] += 50 * crandom();
		le->pos.trDelta[2] += 50 * crandom();

		AxisCopy(axisDefault, re->axis);
		re->reType = RT_SPRITE;
		re->radius = 8;
		re->customShader = cgs.media.railRingsShader;

		re->shaderRGBA[0] = wi->flashDlightColor[0] * 63;
		re->shaderRGBA[1] = wi->flashDlightColor[1] * 63;
		re->shaderRGBA[2] = wi->flashDlightColor[2] * 63;
		re->shaderRGBA[3] = 63;

		le->color[3] = 1;
	}
}

/*
==========================
CG_GrappleTrail
==========================
*/
void CG_GrappleTrail( centity_t *ent, const weaponInfo_t *wi ) {
	vec3_t	origin;
	entityState_t	*es;
	vec3_t			forward, up;
	refEntity_t		beam;

	// JUHOX: don't draw normal grapple trail with the new hook
	if (cgs.hookMode != HM_classic) return;

	es = &ent->currentState;

	BG_EvaluateTrajectory( &es->pos, cg.time, origin );
	ent->trailTime = cg.time;

	memset( &beam, 0, sizeof( beam ) );
	//FIXME adjust for muzzle position
	VectorCopy ( cg_entities[ ent->currentState.otherEntityNum ].lerpOrigin, beam.origin );
	beam.origin[2] += 26;
	AngleVectors( cg_entities[ ent->currentState.otherEntityNum ].lerpAngles, forward, NULL, up );
	VectorMA( beam.origin, -6, up, beam.origin );
	VectorCopy( origin, beam.oldorigin );

	if (Distance( beam.origin, beam.oldorigin ) < 64 )
		return; // Don't draw if close

	// JUHOX: draw grapple rope
	beam.reType = RT_LIGHTNING;
	beam.customShader = cgs.media.grappleShader;

	AxisClear( beam.axis );
	beam.shaderRGBA[0] = 0xff;
	beam.shaderRGBA[1] = 0xff;
	beam.shaderRGBA[2] = 0xff;
	beam.shaderRGBA[3] = 0xff;
	trap_R_AddRefEntityToScene( &beam );
}

/*
==========================
CG_GrenadeTrail
==========================
*/
static void CG_GrenadeTrail( centity_t *ent, const weaponInfo_t *wi ) {
	CG_RocketTrail( ent, wi );
}


/*
=================
CG_RegisterWeapon

The server says this item is used on this level
=================
*/
void CG_RegisterWeapon( int weaponNum ) {
	weaponInfo_t	*weaponInfo;
	gitem_t			*item, *ammo;
	char			path[MAX_QPATH];
	vec3_t			mins, maxs;
	int				i;

	weaponInfo = &cg_weapons[weaponNum];

	if ( weaponNum == 0 ) return;
	if ( weaponInfo->registered ) return;

	memset( weaponInfo, 0, sizeof( *weaponInfo ) );
	weaponInfo->registered = qtrue;

	for ( item = bg_itemlist + 1 ; item->classname ; item++ ) {
		if ( item->giType == IT_WEAPON && item->giTag == weaponNum ) {
			weaponInfo->item = item;
			break;
		}
	}

	if ( !item->classname ) CG_Error( "Couldn't find weapon %i", weaponNum );

	CG_RegisterItemVisuals( item - bg_itemlist );

	// load cmodel before model so filecache works
	weaponInfo->weaponModel = trap_R_RegisterModel( item->world_model[0] );

	// calc midpoint for rotation
	trap_R_ModelBounds( weaponInfo->weaponModel, mins, maxs );
	for ( i = 0 ; i < 3 ; i++ ) {
		weaponInfo->weaponMidpoint[i] = mins[i] + 0.5 * ( maxs[i] - mins[i] );
	}

	weaponInfo->weaponIcon = trap_R_RegisterShader( item->icon );
	weaponInfo->ammoIcon = trap_R_RegisterShader( item->icon );

	for ( ammo = bg_itemlist + 1 ; ammo->classname ; ammo++ ) {
		if ( ammo->giType == IT_AMMO && ammo->giTag == weaponNum ) {
			break;
		}
	}
	if ( ammo->classname && ammo->world_model[0] ) {
		weaponInfo->ammoModel = trap_R_RegisterModel( ammo->world_model[0] );
	}

	strcpy( path, item->world_model[0] );
	COM_StripExtension( path, path );
	strcat( path, "_flash.md3" );
	weaponInfo->flashModel = trap_R_RegisterModel( path );

	strcpy( path, item->world_model[0] );
	COM_StripExtension( path, path );
	strcat( path, "_barrel.md3" );
	weaponInfo->barrelModel = trap_R_RegisterModel( path );

	strcpy( path, item->world_model[0] );
	COM_StripExtension( path, path );
	strcat( path, "_hand.md3" );
	weaponInfo->handsModel = trap_R_RegisterModel( path );

	// SLK this is default hands model, if no other existing
	if ( !weaponInfo->handsModel ) {
		weaponInfo->handsModel = trap_R_RegisterModel( "models/weapons2/shotgun/shotgun_hand.md3" );
	}

	weaponInfo->loopFireSound = qfalse;

	switch ( weaponNum ) {
	case WP_GAUNTLET:
		MAKERGB( weaponInfo->flashDlightColor, 0.6f, 0.6f, 1.0f );
		weaponInfo->firingSound = trap_S_RegisterSound( "sound/weapons/melee/fstrun.wav", qfalse );
		weaponInfo->flashSound[0] = trap_S_RegisterSound( "sound/weapons/melee/fstatck.wav", qfalse );
		break;

	case WP_LIGHTNING:
		MAKERGB( weaponInfo->flashDlightColor, 0.6f, 0.6f, 1.0f );
		weaponInfo->readySound = trap_S_RegisterSound( "sound/weapons/melee/fsthum.wav", qfalse );
		weaponInfo->firingSound = trap_S_RegisterSound( "sound/weapons/lightning/lg_hum.wav", qfalse );

		weaponInfo->flashSound[0] = trap_S_RegisterSound( "sound/weapons/lightning/lg_fire.wav", qfalse );

		cgs.media.lightningShader = trap_R_RegisterShader( "lightningBoltHunt");
		cgs.media.lightningExplosionModel = trap_R_RegisterModel( "models/weaphits/crackle.md3" );
		cgs.media.sfx_lghit1 = trap_S_RegisterSound( "sound/weapons/lightning/lg_hit.wav", qfalse );
		cgs.media.sfx_lghit2 = trap_S_RegisterSound( "sound/weapons/lightning/lg_hit2.wav", qfalse );
		cgs.media.sfx_lghit3 = trap_S_RegisterSound( "sound/weapons/lightning/lg_hit3.wav", qfalse );

		cgs.media.dischargeFlashShader = trap_R_RegisterShader("dischargeflash");
		cgs.media.dischargeFlashSound = trap_S_RegisterSound("sound/discharge.wav", qfalse);
		break;

	case WP_GRAPPLING_HOOK:
		MAKERGB( weaponInfo->flashDlightColor, 0.6f, 0.6f, 1.0f );

		weaponInfo->missileTrailFunc = CG_GrappleTrail;
		weaponInfo->missileModel = trap_R_RegisterModel("models/weapons2/grapple/hook.md3");
		cgs.media.grappleShotSound = trap_S_RegisterSound("sound/weapons/grenade/grenlf1a.wav", qfalse);
		cgs.media.grappleThrowSound = trap_S_RegisterSound("sound/weapons/grapple/throw.wav", qfalse);
		cgs.media.ropeExplosionSound = trap_S_RegisterSound("sound/weapons/grapple/release.wav", qfalse);
		cgs.media.grappleWindOffSound = trap_S_RegisterSound("sound/weapons/grapple/windoff.wav", qfalse);
		cgs.media.grappleRewindSound = trap_S_RegisterSound("sound/weapons/grapple/rewind.wav", qfalse);
		cgs.media.grapplePullingSound = trap_S_RegisterSound("sound/weapons/grapple/pulling.wav", qfalse);
		cgs.media.grappleBlockingSound = trap_S_RegisterSound("sound/weapons/grapple/blocked.wav", qfalse);
		weaponInfo->flashSound[0] = trap_S_RegisterSound("sound/weapons/grenade/grenlf1a.wav", qfalse);
		cgs.media.grappleShader = trap_R_RegisterShader("grappleRope");
		break;

	case WP_MACHINEGUN:
		MAKERGB( weaponInfo->flashDlightColor, 1, 1, 0 );
		weaponInfo->flashSound[0] = trap_S_RegisterSound("sound/weapons/machinegun/mgshot.wav", qfalse);
		weaponInfo->ejectBrassFunc = CG_MachineGunEjectBrass;
		cgs.media.bulletExplosionShader = trap_R_RegisterShader( "bulletExplosion" );
		break;

	case WP_SHOTGUN:
		MAKERGB( weaponInfo->flashDlightColor, 1, 1, 0 );
		weaponInfo->flashSound[0] = trap_S_RegisterSound( "sound/weapons/shotgun/sshotf1b.wav", qfalse );
		weaponInfo->ejectBrassFunc = CG_ShotgunEjectBrass;
		break;

	case WP_ROCKET_LAUNCHER:
		weaponInfo->missileModel = trap_R_RegisterModel( "models/ammo/rocket/rocket.md3" );
		weaponInfo->missileSound = trap_S_RegisterSound( "sound/weapons/rocket/rockfly.wav", qfalse );
		weaponInfo->missileTrailFunc = CG_RocketTrail;
		weaponInfo->missileDlight = 200;
		weaponInfo->wiTrailTime = 2000;
		weaponInfo->trailRadius = 64;

		MAKERGB( weaponInfo->missileDlightColor, 1, 0.75f, 0 );
		MAKERGB( weaponInfo->flashDlightColor, 1, 0.75f, 0 );

		weaponInfo->flashSound[0] = trap_S_RegisterSound( "sound/weapons/rocket/rocklf1a.wav", qfalse );
		cgs.media.rocketExplosionShader = trap_R_RegisterShader( "rocketExplosion" );
		break;

	case WP_GRENADE_LAUNCHER:
		weaponInfo->missileModel = trap_R_RegisterModel( "models/ammo/grenade1.md3" );
		weaponInfo->missileTrailFunc = CG_GrenadeTrail;
		weaponInfo->wiTrailTime = 700;
		weaponInfo->trailRadius = 32;
		MAKERGB( weaponInfo->flashDlightColor, 1, 0.70f, 0 );
		weaponInfo->flashSound[0] = trap_S_RegisterSound( "sound/weapons/grenade/grenlf1a.wav", qfalse );
		cgs.media.grenadeExplosionShader = trap_R_RegisterShader( "grenadeExplosion" );
		break;

        // JUHOX: register monster launcher
	case WP_MONSTER_LAUNCHER:
		weaponInfo->missileModel = trap_R_RegisterModel("models/powerups/health/small_sphere.md3");
		MAKERGB( weaponInfo->flashDlightColor, 1, 0.70f, 0 );
		weaponInfo->flashSound[0] = trap_S_RegisterSound( "sound/weapons/monsterl/monsterlf.wav", qfalse );
		{
			int i, j;
			const char index[] = "ACDEGHJK";

			for (i = 0; i < 3; i++) {
				for (j = 0; j < 8; j++) {
					cgs.media.seedBounceSound[i][j] = trap_S_RegisterSound(
						va("sound/weapons/monsterl/ball%c%d.wav", index[j], i + 1),
						qfalse
					);
				}
			}
		}
		cgs.media.monsterLauncherShader = trap_R_RegisterShader("models/weapons2/monsterl/monsterl.tga");
		cgs.media.monsterSeedMetalShader = trap_R_RegisterShader("models/weapons2/monsterl/seed");
		break;

	case WP_PLASMAGUN:
		weaponInfo->missileTrailFunc = CG_PlasmaTrail;
		weaponInfo->missileSound = trap_S_RegisterSound( "sound/weapons/plasma/lasfly.wav", qfalse );
		MAKERGB( weaponInfo->flashDlightColor, 0.6f, 0.6f, 1.0f );
		weaponInfo->flashSound[0] = trap_S_RegisterSound( "sound/weapons/plasma/hyprbf1a.wav", qfalse );
		cgs.media.plasmaExplosionShader = trap_R_RegisterShader( "plasmaExplosion" );
		cgs.media.railRingsShader = trap_R_RegisterShader("plasmaParticle");
		break;

	case WP_RAILGUN:
		weaponInfo->readySound = trap_S_RegisterSound( "sound/weapons/railgun/rg_hum.wav", qfalse );
		MAKERGB( weaponInfo->flashDlightColor, 1, 0.5f, 0 );
		weaponInfo->flashSound[0] = trap_S_RegisterSound( "sound/weapons/railgun/railgf1a.wav", qfalse );
		cgs.media.railExplosionShader = trap_R_RegisterShader( "railExplosion" );
		cgs.media.plasmaExplosionShader = trap_R_RegisterShader( "plasmaExplosion" );
		cgs.media.railRingsShader = trap_R_RegisterShader("plasmaParticle");
		cgs.media.railCoreShader = trap_R_RegisterShader( "railCore" );
		break;

	case WP_BFG:
		weaponInfo->readySound = trap_S_RegisterSound( "sound/weapons/bfg/bfg_hum.wav", qfalse );
		MAKERGB( weaponInfo->flashDlightColor, 1, 0.7f, 1 );
		weaponInfo->flashSound[0] = trap_S_RegisterSound( "sound/weapons/bfg/bfg_fire.wav", qfalse );
		cgs.media.bfgExplosionShader = trap_R_RegisterShader( "bfgExplosion" );
		cgs.media.bfgLFGlareShader = trap_R_RegisterShader("bfgLFGlare");	// JUHOX
		cgs.media.bfgLFDiscShader = trap_R_RegisterShader("bfgLFDisc");	// JUHOX
		cgs.media.bfgLFRingShader = trap_R_RegisterShader("bfgLFRing");	// JUHOX
		cgs.media.bfgLFStarShader = trap_R_RegisterShader("bfgLFStar");	// JUHOX
		cgs.media.bfgLFLineShader = trap_R_RegisterShader("bfgLFLine");	// JUHOX
		cgs.media.bfgSuperExplShader = trap_R_RegisterShader("bfgSuperExpl");	// JUHOX
		weaponInfo->missileSound = trap_S_RegisterSound( "sound/weapons/rocket/rockfly.wav", qfalse );
		cgs.media.bfgReloadingShader = trap_R_RegisterShader("models/weapons2/bfg/reloading");	// JUHOX
		weaponInfo->missileDlight = 400;	// JUHOX
		MAKERGB(weaponInfo->missileDlightColor, 1, 1, 1);	// JUHOX
		break;

	 default:
		MAKERGB( weaponInfo->flashDlightColor, 1, 1, 1 );
		weaponInfo->flashSound[0] = trap_S_RegisterSound( "sound/weapons/rocket/rocklf1a.wav", qfalse );
		break;
	}
}

/*
=================
CG_RegisterItemVisuals

The server says this item is used on this level
=================
*/
void CG_RegisterItemVisuals( int itemNum ) {
	itemInfo_t		*itemInfo;
	gitem_t			*item;

	if ( itemNum < 0 || itemNum >= bg_numItems ) {
		CG_Error( "CG_RegisterItemVisuals: itemNum %d out of range [0-%d]", itemNum, bg_numItems-1 );
	}

	itemInfo = &cg_items[ itemNum ];
	if ( itemInfo->registered ) return;

	item = &bg_itemlist[ itemNum ];

	memset( itemInfo, 0, sizeof( &itemInfo ) );
	itemInfo->registered = qtrue;

	itemInfo->models[0] = trap_R_RegisterModel( item->world_model[0] );

	itemInfo->icon = trap_R_RegisterShader( item->icon );

	if ( item->giType == IT_WEAPON ) {
		CG_RegisterWeapon( item->giTag );
	}

	//
	// powerups have an accompanying ring or sphere
	//
	if ( item->giType == IT_POWERUP || item->giType == IT_HEALTH ||
		item->giType == IT_ARMOR || item->giType == IT_HOLDABLE ) {
		if ( item->world_model[1] ) {
			itemInfo->models[1] = trap_R_RegisterModel( item->world_model[1] );
		}
	}

	// JUHOX: get midpoint for armor fragments
	if (item->giType == IT_ARMOR && item->giTag) {
		float* midpoint;

		midpoint = NULL;
		if (!Q_stricmp(item->classname, "item_armor_smallfrag")) {
			midpoint = cgs.smallArmorFragmentMidpoint;
		}
		else if (!Q_stricmp(item->classname, "item_armor_largefrag")) {
			midpoint = cgs.largeArmorFragmentMidpoint;
		}

		if (midpoint) {
			vec3_t mins, maxs;

			trap_R_ModelBounds(itemInfo->models[0], mins, maxs);
			VectorSubtract(maxs, mins, maxs);
			VectorMA(mins, 0.5, maxs, midpoint);
			if (midpoint == cgs.largeArmorFragmentMidpoint) {
				VectorScale(midpoint, 1.5, midpoint);
			}
		}
	}
}


/*
========================================================================================

VIEW WEAPON

========================================================================================
*/

/*
=================
CG_MapTorsoToWeaponFrame

=================
*/
static int CG_MapTorsoToWeaponFrame( clientInfo_t *ci, int frame ) {

	// change weapon
	if ( frame >= ci->animations[TORSO_DROP].firstFrame
		&& frame < ci->animations[TORSO_DROP].firstFrame + 9 ) {
		return frame - ci->animations[TORSO_DROP].firstFrame + 6;
	}

	// stand attack
	if ( frame >= ci->animations[TORSO_ATTACK].firstFrame
		&& frame < ci->animations[TORSO_ATTACK].firstFrame + 6 ) {
		return 1 + frame - ci->animations[TORSO_ATTACK].firstFrame;
	}

	// stand attack 2
	if ( frame >= ci->animations[TORSO_ATTACK2].firstFrame
		&& frame < ci->animations[TORSO_ATTACK2].firstFrame + 6 ) {
		return 1 + frame - ci->animations[TORSO_ATTACK2].firstFrame;
	}

	return 0;
}


/*
==============
CG_CalculateWeaponPosition
==============
*/
static void CG_CalculateWeaponPosition( vec3_t origin, vec3_t angles ) {
	float	scale;
	int		delta;
	float	fracsin;

	VectorCopy( cg.refdef.vieworg, origin );
	VectorCopy( cg.refdefViewAngles, angles );

	// on odd legs, invert some angles
	if ( cg.bobcycle & 1 ) {
		scale = -cg.xyspeed;
	} else {
		scale = cg.xyspeed;
	}

	// gun angles from bobbing
	angles[ROLL] += scale * cg.bobfracsin * 0.005;
	angles[YAW] += scale * cg.bobfracsin * 0.01;
	angles[PITCH] += cg.xyspeed * cg.bobfracsin * 0.005;

	// drop the weapon when landing
	delta = cg.time - cg.landTime;
	if ( delta < LAND_DEFLECT_TIME ) {
		origin[2] += cg.landChange*0.25 * delta / LAND_DEFLECT_TIME;
	} else if ( delta < LAND_DEFLECT_TIME + LAND_RETURN_TIME ) {
		origin[2] += cg.landChange*0.25 *
			(LAND_DEFLECT_TIME + LAND_RETURN_TIME - delta) / LAND_RETURN_TIME;
	}

	// idle drift
	scale = cg.xyspeed + 40;
	fracsin = sin( cg.time * 0.001 );
	angles[ROLL] += scale * fracsin * 0.01;
	angles[YAW] += scale * fracsin * 0.01;
	angles[PITCH] += scale * fracsin * 0.01;
}


/*
===============
JUHOX: CG_CurvedLine
===============
*/
static void CG_CurvedLine( const vec3_t start, const vec3_t end, const vec3_t startDir,	qhandle_t shader, float segmentLen, float scrollSpeed ) {
	float dist;
	vec3_t dir1;
	vec3_t dir2;
	int n;
	float totalLength;
	vec3_t currentPos;
	int i;

	VectorSubtract(end, start, dir2);
	dist = VectorLength(dir2);
	VectorScale(startDir, dist, dir1);
	n = dist / 20;
	if (n <= 0) n = 1;
	dist /= n;	// segment length

	totalLength = 0;
	VectorCopy(start, currentPos);
	for (i = 0; i < n; i++) {
		float x;
		vec3_t p1, p2;
		vec3_t nextPos;

		x = (float)(i+1) / n;
		VectorMA(start, x, dir1, p1);
		VectorMA(start, x, dir2, p2);
		VectorSubtract(p2, p1, p2);
		VectorMA(p1, x * x * x, p2, nextPos);

		totalLength = CG_DrawLineSegment( currentPos, nextPos, totalLength, segmentLen, scrollSpeed, shader	);
		VectorCopy(nextPos, currentPos);
	}
}

/*
===============
JUHOX: CG_LightningBolt (new version)
===============
*/
static void CG_LightningBolt(centity_t* cent, vec3_t origin) {
	refEntity_t beam;
	vec3_t startPoint, endPoint;
	vec3_t forward;
	vec3_t right;
	int target;

	if (cent->currentState.weapon != WP_LIGHTNING) return;

	memset(&beam, 0, sizeof(beam));
	AngleVectors(cent->lerpAngles, forward, right, NULL);

	target = cent->currentState.otherEntityNum2;
	if (target >= 0 && target < ENTITYNUM_MAX_NORMAL) {
		centity_t* targetCent;

		targetCent = &cg_entities[target];
		VectorCopy(origin, startPoint);
		if (targetCent->currentValid) {
			CG_CalcEntityLerpPositions(targetCent);
			VectorCopy(targetCent->lerpOrigin, endPoint);

			endPoint[2] += BG_PlayerTargetOffset(&targetCent->currentState, LIGHTNING_TARGET_POS);
		}
		else {
			VectorCopy(cent->currentState.origin2, endPoint);
		}

		{
			int r;
			sfxHandle_t sfx;

			r = rand() & 3;
			if (r < 2) {
				sfx = cgs.media.sfx_lghit2;
			} else if (r == 2) {
				sfx = cgs.media.sfx_lghit1;
			} else {
				sfx = cgs.media.sfx_lghit3;
			}
			trap_S_StartSound(endPoint, target, CHAN_AUTO, sfx);
		}

		CG_CurvedLine(origin, endPoint, forward, cgs.media.lightningShader, 256.0, -2.0);

		// impact flare
		{
			vec3_t angles;
			vec3_t dir;
			vec3_t pos;

			VectorSubtract(endPoint, origin, dir);
			VectorNormalize(dir);
			VectorMA(endPoint, -16, dir, pos);

			memset(&beam, 0, sizeof(beam));
			beam.hModel = cgs.media.lightningExplosionModel;
			VectorCopy(pos, beam.origin);

			// make a random orientation
			angles[0] = rand() % 360;
			angles[1] = rand() % 360;
			angles[2] = rand() % 360;
			AnglesToAxis(angles, beam.axis);
			trap_R_AddRefEntityToScene(&beam);
		}
	}
	else {
		vec3_t start;

		VectorMA(origin, +1.75, right, start);
		AddDischargeFlash(
			start, cent->lerpAngles, &cent->gunFlash1, cent->currentState.number,
			vec3_origin, vec3_origin, cgs.media.dischargeFlashShader
		);

		VectorMA(origin, -1.75, right, start);
		AddDischargeFlash(
			start, cent->lerpAngles, &cent->gunFlash2, cent->currentState.number,
			vec3_origin, vec3_origin, cgs.media.dischargeFlashShader
		);
	}

	// add the impact flare if it hit something
}

/*
===============
JUHOX: CG_Draw3DLine
===============
*/
void CG_Draw3DLine(const vec3_t start, const vec3_t end, qhandle_t shader) {
	refEntity_t line;

	//if (DistanceSquared(start, end) < 10*10) return;
	memset(&line, 0, sizeof(line));
	line.reType = RT_LIGHTNING;
	line.customShader = shader;
	VectorCopy(start, line.origin);
	VectorCopy(end, line.oldorigin);
	trap_R_AddRefEntityToScene(&line);
}


/*
===============
CG_SpawnRailTrail

Origin will be the exact tag point, which is slightly
different than the muzzle point used for determining hits.
===============
*/
static void CG_SpawnRailTrail( centity_t *cent, vec3_t origin ) {
	clientInfo_t	*ci;

	if ( cent->currentState.weapon != WP_RAILGUN ) return;
	if ( !cent->pe.railgunFlash ) return;

	cent->pe.railgunFlash = qtrue;
	ci = &cgs.clientinfo[ cent->currentState.clientNum ];
	CG_RailTrail( ci, origin, cent->pe.railgunImpact );
}


/*
======================
CG_MachinegunSpinAngle
======================
*/
#define		SPIN_SPEED	0.9
#define		COAST_TIME	1000
static float	CG_MachinegunSpinAngle( centity_t *cent ) {
	int		delta;
	float	angle;
	float	speed;

	delta = cg.time - cent->pe.barrelTime;
	if ( cent->pe.barrelSpinning ) {
		angle = cent->pe.barrelAngle + delta * SPIN_SPEED;
	} else {
		if ( delta > COAST_TIME ) {
			delta = COAST_TIME;
		}

		speed = 0.5 * ( SPIN_SPEED + (float)( COAST_TIME - delta ) / COAST_TIME );
		angle = cent->pe.barrelAngle + delta * speed;
	}

	if ( cent->pe.barrelSpinning == !(cent->currentState.eFlags & EF_FIRING) ) {
		cent->pe.barrelTime = cg.time;
		cent->pe.barrelAngle = AngleMod( angle );
		cent->pe.barrelSpinning = !!(cent->currentState.eFlags & EF_FIRING);
	}

	return angle;
}


/*
======================
JUHOX: CG_NewMachinegunSpinAngle
======================
*/
static float CG_NewMachinegunSpinAngle(centity_t *cent) {
	int		delta;
	float	angle;
	qboolean firing;

	angle = cent->pe.mgAngle;
	delta = cg.time - cent->pe.mgTime;
	firing = cent->currentState.eFlags & EF_FIRING? qtrue : qfalse;
	switch (cent->pe.mgPhase) {
	case 0:	// not spinning
		if (firing) {
			cent->pe.mgTime = cg.time;
			cent->pe.mgPhase = 1;
			trap_S_StartSound(NULL, cent->currentState.number, CHAN_WEAPON, trap_S_RegisterSound("sound/weapons/machinegun/mgspin1.wav", qfalse));
		}
		break;
	case 1:	// wind up
		if (delta > MACHINEGUN_WIND_UP_TIME) {
			delta = MACHINEGUN_WIND_UP_TIME;
		}
		angle += 0.5 * (SPIN_SPEED / MACHINEGUN_WIND_UP_TIME) * (delta * delta);
		angle = AngleMod(angle);
		if (delta >= MACHINEGUN_WIND_UP_TIME) {
			cent->pe.mgTime = cg.time;
			cent->pe.mgAngle = angle;
			cent->pe.mgPhase = 2;
		}
		break;
	case 2:	// spinning
		angle += SPIN_SPEED * delta;
		angle = AngleMod(angle);
		if (firing) {
			trap_S_AddLoopingSound(cent->currentState.number, cent->lerpOrigin, vec3_origin, trap_S_RegisterSound("sound/weapons/machinegun/mgspin2.wav", qfalse));
		}
		else {
			cent->pe.mgTime = cg.time;
			cent->pe.mgAngle = angle;
			cent->pe.mgPhase = 3;
			trap_S_StartSound(NULL, cent->currentState.number, CHAN_WEAPON, trap_S_RegisterSound("sound/weapons/machinegun/mgspin3.wav", qfalse));
		}
		break;
	case 3:	// wind down
		if (delta > MACHINEGUN_WIND_OFF_TIME) {
			delta = MACHINEGUN_WIND_OFF_TIME;
		}
		angle += SPIN_SPEED * delta - 0.5 * (SPIN_SPEED / MACHINEGUN_WIND_OFF_TIME) * (delta * delta);
		angle = AngleMod(angle);
		if (delta >= MACHINEGUN_WIND_OFF_TIME) {
			cent->pe.mgTime = cg.time;	// not really needed
			cent->pe.mgAngle = angle;
			cent->pe.mgPhase = 0;
		}
		break;
	}

	return angle;
}


/*
========================
CG_AddWeaponWithPowerups
========================
*/
static void CG_AddWeaponWithPowerups(refEntity_t* gun, entityState_t* state, playerState_t* ps, int team) {
	int powerups;	// to support the old parameter

	powerups = state->powerups;

	// JUHOX: set corrected lighting origin for EFH
	if (cgs.gametype == GT_EFH) {
		gun->renderfx |= RF_LIGHTING_ORIGIN;
		VectorCopy(state->origin, gun->lightingOrigin);
	}

	// JUHOX: draw spawn hull
	{
		float intensity;
		qboolean skipOthers;

		if (CG_GetSpawnEffectParameters(state, &intensity, &skipOthers, &powerups, gun)) {
			qhandle_t oldShader;

			oldShader = gun->customShader;
			gun->customShader = cgs.media.spawnHullShader;
			if (ps) gun->customShader = cgs.media.spawnHullWeaponShader;
			gun->shaderRGBA[3] = 255 * intensity;
			trap_R_AddRefEntityToScene(gun);

			if (gun->shaderRGBA[3] > 128) {
				gun->shaderRGBA[3] -= 128;
				gun->shaderRGBA[3] >>= 3;

				gun->customShader = cgs.media.spawnHullGlow1Shader;
				if (ps) gun->customShader = cgs.media.spawnHullGlow1WeaponShader;
				trap_R_AddRefEntityToScene(gun);

				gun->customShader = cgs.media.spawnHullGlow2Shader;
				if (ps) gun->customShader = cgs.media.spawnHullGlow2WeaponShader;
				trap_R_AddRefEntityToScene(gun);

				gun->customShader = cgs.media.spawnHullGlow3Shader;
				if (ps) gun->customShader = cgs.media.spawnHullGlow3WeaponShader;
				trap_R_AddRefEntityToScene(gun);

				gun->customShader = cgs.media.spawnHullGlow4Shader;
				if (ps) gun->customShader = cgs.media.spawnHullGlow4WeaponShader;
				trap_R_AddRefEntityToScene(gun);
			}

			if (skipOthers) return;

			gun->customShader = oldShader;
		}
	}

	// JUHOX: draw monster glow
	if (
		cg.viewMode == VIEW_scanner &&
		cg.scannerActivationTime &&
		state->eType == ET_PLAYER &&
		state->clientNum >= CLIENTNUM_MONSTERS &&
		state->clientNum < MAX_CLIENTS + EXTRA_CLIENTNUMS
	) {
		centity_t* cent;
		int color;

		cent = &cg_entities[state->number];
		color = 255;
		if (cent->deathTime) {
			#define SCANNER_DEATH_FADE_TIME 5000

			if (cg.time < cent->deathTime + SCANNER_DEATH_FADE_TIME) {
				color = 255 - (255 * (cg.time - cent->deathTime)) / SCANNER_DEATH_FADE_TIME;
				if (color < 0) color = 0;
				if (color > 255) color = 255;
			}
			else {
				color = 0;
			}
		}
		if (cg.time < cg.scannerActivationTime + SCANNER_DEATH_FADE_TIME) {
			color = (color * (cg.time - cg.scannerActivationTime)) / SCANNER_DEATH_FADE_TIME;
		}
		if (color > 0) {
			gun->customShader = trap_R_RegisterShader("monsterGlow");
			gun->shaderRGBA[0] = color;
			gun->shaderRGBA[1] = color;
			gun->shaderRGBA[2] = color;
			gun->shaderRGBA[3] = 255;
			gun->shaderTime = state->number * 1.731;
			trap_R_AddRefEntityToScene(gun);
			gun->customShader = 0;
		}
	}


	// add powerup effects
	if ( powerups & ( 1 << PW_INVIS ) ) {

		qboolean drawInvisShader;
		drawInvisShader = qtrue;
		if ( cgs.gametype >= GT_TEAM &&	( cgs.gametype >= GT_STU || cg.snap->ps.persistant[PERS_TEAM] == team )	) {
			if (team == TEAM_RED)
				gun->customShader = cgs.media.redInvis;
			else
				gun->customShader = cgs.media.blueInvis;
			trap_R_AddRefEntityToScene(gun);
			drawInvisShader = qfalse;
		}
		if (powerups & (1 << PW_BATTLESUIT)) {
			gun->customShader = cgs.media.battleWeaponShader;
			trap_R_AddRefEntityToScene(gun);
			drawInvisShader = qfalse;
		}
		if (powerups & (1 << PW_CHARGE)) {
			gun->customShader = cgs.media.chargeWeaponShader;
			gun->shaderRGBA[3] = 64;
			trap_R_AddRefEntityToScene(gun);
			drawInvisShader = qfalse;
		}
		// - quad currently not used -
		if (powerups & (1 << PW_SHIELD)) {
			gun->customShader = cgs.media.shieldWeaponShader;
			trap_R_AddRefEntityToScene(gun);
			drawInvisShader = qfalse;
		}
		// invisibility shader not needed if any marker drawn
		if (drawInvisShader || cg_glassCloaking.integer) {
			if (cg_glassCloaking.integer) {
				gun->customShader = cgs.media.glassCloakingShader;
				trap_R_AddRefEntityToScene(gun);

				if (drawInvisShader) {
					if (cg.clientNum == state->number) {
						gun->customShader = cgs.media.invisShader;
						trap_R_AddRefEntityToScene(gun);
					}
				}
			}
			else {
				gun->customShader = cgs.media.invisShader;
				trap_R_AddRefEntityToScene(gun);
			}
		}

	} else {
		trap_R_AddRefEntityToScene( gun );

		if ( powerups & ( 1 << PW_BATTLESUIT ) ) {
			gun->customShader = cgs.media.battleWeaponShader;
			trap_R_AddRefEntityToScene( gun );
		}
		if ( powerups & ( 1 << PW_QUAD ) ) {
			gun->customShader = cgs.media.quadWeaponShader;
			trap_R_AddRefEntityToScene( gun );
		}

        // JUHOX: draw the charge shader for the weapon
		if (powerups & (1 << PW_CHARGE)) {
			gun->customShader = cgs.media.chargeWeaponShader;
			gun->shaderRGBA[3] = 128;
			trap_R_AddRefEntityToScene(gun);
		}

        // JUHOX: draw the shield shader for the weapon
		if (powerups & (1 << PW_SHIELD)) {
			gun->customShader = cgs.media.shieldWeaponShader;
			trap_R_AddRefEntityToScene(gun);
		}

        // JUHOX: draw the BFG reloading shader
		if (powerups & (1 << PW_BFG_RELOADING)) {
			gun->customShader = cgs.media.bfgReloadingShader;
			trap_R_AddRefEntityToScene(gun);
		}
	}

	// JUHOX: mark target for gauntlet
	if ( cg.snap->ps.weapon == WP_GAUNTLET && cg.snap->ps.stats[STAT_TARGET] == state->number ) {
		gun->customShader = cgs.media.targetMarker;
		trap_R_AddRefEntityToScene(gun);
	}
}


/*
=============
CG_AddPlayerWeapon

Used for both the view weapon (ps is valid) and the world modelother character models (ps is NULL)
The main player will have this called for BOTH cases, so effects like light and
sound should only be done on the world model case.
=============
*/
void CG_AddPlayerWeapon( refEntity_t *parent, playerState_t *ps, centity_t *cent, int team ) {
	refEntity_t	    gun;
	refEntity_t	    barrel;
	refEntity_t	    flash;
	vec3_t		    angles;
	weapon_t	    weaponNum;
	weaponInfo_t	*weapon;
	centity_t	    *nonPredictedCent;

	weaponNum = cent->currentState.weapon;
	// JUHOX: speed-up for monsters
	if (weaponNum == WP_NONE) return;

	CG_RegisterWeapon( weaponNum );
	weapon = &cg_weapons[weaponNum];

	// add the weapon
	memset( &gun, 0, sizeof( gun ) );
	VectorCopy( parent->lightingOrigin, gun.lightingOrigin );
	gun.shadowPlane = parent->shadowPlane;
	gun.renderfx = parent->renderfx;

	// JUHOX: set custom shading for railgun and bfg refire rate

	if (ps) {
		switch (cg.predictedPlayerState.weapon) {
		case WP_RAILGUN:
			if (cg.predictedPlayerState.weaponstate != WEAPON_FIRING) goto NormalShader;

			{
				float f;

				f = (float)cg.predictedPlayerState.weaponTime / 1500;
				gun.shaderRGBA[1] = 0;
				gun.shaderRGBA[0] =
				gun.shaderRGBA[2] = 255 * ( 1.0 - f );
				gun.shaderRGBA[3] = 255;
			}
			break;
		case WP_BFG:
			if (cg.predictedPlayerState.weaponstate != WEAPON_FIRING) goto NormalShader;

			{
				float f;

				f = (float)cg.predictedPlayerState.weaponTime / 4000;
				gun.shaderRGBA[1] = 0;
				gun.shaderRGBA[0] =
				gun.shaderRGBA[2] = 255 * ( 1.0 - f );
				gun.shaderRGBA[3] = 255;
			}
			break;
		default:
		NormalShader:
			gun.shaderRGBA[0] = 255;
			gun.shaderRGBA[1] = 255;
			gun.shaderRGBA[2] = 255;
			gun.shaderRGBA[3] = 255;
			break;
		}
	}
	else {
		gun.shaderRGBA[0] = 255;
		gun.shaderRGBA[1] = 255;
		gun.shaderRGBA[2] = 255;
		gun.shaderRGBA[3] = 255;
	}

	gun.hModel = weapon->weaponModel;
	if (!gun.hModel) {
		return;
	}
	// JUHOX: set custom shader for monster launcher
	if (weaponNum == WP_MONSTER_LAUNCHER) {
		gun.customShader = cgs.media.monsterLauncherShader;
	}

	if ( !ps ) {
		// add weapon ready sound
		cent->pe.lightningFiring = qfalse;
		if ( ( cent->currentState.eFlags & EF_FIRING ) && weapon->firingSound ) {
			// lightning gun and guantlet make a different sound when fire is held down
			trap_S_AddLoopingSound( cent->currentState.number, cent->lerpOrigin, vec3_origin, weapon->firingSound );
			cent->pe.lightningFiring = qtrue;
		} else if ( weapon->readySound ) {
			trap_S_AddLoopingSound( cent->currentState.number, cent->lerpOrigin, vec3_origin, weapon->readySound );
		}
	}

	CG_PositionEntityOnTag( &gun, parent, parent->hModel, "tag_weapon");
	CG_AddWeaponWithPowerups(&gun, &cent->currentState, ps, team);

	// add the spinning barrel
	if ( weapon->barrelModel ) {
		memset( &barrel, 0, sizeof( barrel ) );
		VectorCopy( parent->lightingOrigin, barrel.lightingOrigin );
		barrel.shadowPlane = parent->shadowPlane;
		barrel.renderfx = parent->renderfx;

		barrel.hModel = weapon->barrelModel;
		angles[YAW] = 0;
		angles[PITCH] = 0;

		// JUHOX: new barrel spinning with machinegun
		if (weaponNum == WP_MACHINEGUN) {
			angles[ROLL] = CG_NewMachinegunSpinAngle(cent);
		}
		else {
			cent->pe.mgPhase = 0;
			angles[ROLL] = CG_MachinegunSpinAngle(cent);
		}

		AnglesToAxis( angles, barrel.axis );

		CG_PositionRotatedEntityOnTag( &barrel, &gun, weapon->weaponModel, "tag_barrel" );


		CG_AddWeaponWithPowerups(&barrel, &cent->currentState, ps, team);

	}
	// JUHOX: reset machinegun while not using it
	else {
		cent->pe.mgPhase = 0;
	}

	// make sure we aren't looking at cg.predictedPlayerEntity for LG
	nonPredictedCent = &cg_entities[cent->currentState.clientNum];

	// if the index of the nonPredictedCent is not the same as the clientNum
	// then this is a fake player (like on teh single player podiums), so
	// go ahead and use the cent
	if( ( nonPredictedCent - cg_entities ) != cent->currentState.clientNum ) {
		nonPredictedCent = cent;
	}

	// add the flash
	// JUHOX: let grappling hook do an impulse flash
	if ( ( weaponNum == WP_LIGHTNING || weaponNum == WP_GAUNTLET ) && ( nonPredictedCent->currentState.eFlags & EF_FIRING ) ) {
		// continuous flash
	} else {
		// impulse flash
		if ( cg.time - cent->muzzleFlashTime > MUZZLE_FLASH_TIME && !cent->pe.railgunFlash ) return;
	}

	memset( &flash, 0, sizeof( flash ) );
	VectorCopy( parent->lightingOrigin, flash.lightingOrigin );
	flash.shadowPlane = parent->shadowPlane;
	flash.renderfx = parent->renderfx;

	flash.hModel = weapon->flashModel;
	if (!flash.hModel) return;

	angles[YAW] = 0;
	angles[PITCH] = 0;
	angles[ROLL] = crandom() * 10;
	AnglesToAxis( angles, flash.axis );

	// colorize the railgun blast
	if ( weaponNum == WP_RAILGUN ) {
		clientInfo_t	*ci;

		ci = &cgs.clientinfo[ cent->currentState.clientNum ];
		flash.shaderRGBA[0] = 255 * ci->color1[0];
		flash.shaderRGBA[1] = 255 * ci->color1[1];
		flash.shaderRGBA[2] = 255 * ci->color1[2];
	}

	CG_PositionRotatedEntityOnTag( &flash, &gun, weapon->weaponModel, "tag_flash");

	// JUHOX: move flash for new machinegun barrel
	if (weaponNum == WP_MACHINEGUN) {
		VectorMA(flash.origin, 9, flash.axis[0], flash.origin);
	}

	trap_R_AddRefEntityToScene( &flash );

	if ( ps || cg.renderingThirdPerson ||
		cent->currentState.number != cg.predictedPlayerState.clientNum ) {
		// add lightning bolt
		CG_LightningBolt( nonPredictedCent, flash.origin );

		// add rail trail
		CG_SpawnRailTrail( cent, flash.origin );
        // JUHOX: check for strong lights
		switch (weaponNum) {
		case WP_MACHINEGUN:
		case WP_PLASMAGUN:
			CG_CheckStrongLight(flash.origin, -200, colorWhite);
			break;
		case WP_GAUNTLET:
		case WP_LIGHTNING:
			CG_CheckStrongLight(flash.origin, -300, colorWhite);
			break;
		default:
			CG_CheckStrongLight(flash.origin, 400, colorWhite);
			break;
		}

		// JUHOX FIXME: no dlights in EFH
		if (cgs.gametype == GT_EFH) {
			// do nothing
		} else if ( weapon->flashDlightColor[0] || weapon->flashDlightColor[1] || weapon->flashDlightColor[2] ) {
			trap_R_AddLightToScene( flash.origin, 300 + (rand()&31), weapon->flashDlightColor[0], weapon->flashDlightColor[1], weapon->flashDlightColor[2] );
		}
	}
}

/*
==============
CG_AddViewWeapon

Add the weapon, and flash for the player's view
==============
*/
void CG_AddViewWeapon( playerState_t *ps ) {
	refEntity_t	hand;
	centity_t	*cent;
	clientInfo_t	*ci;
	float		fovOffset;
	vec3_t		angles;
	weaponInfo_t	*weapon;

	if ( ps->persistant[PERS_TEAM] == TEAM_SPECTATOR ) return;
	if ( ps->pm_type == PM_INTERMISSION ) return;

	// no gun if in third person view
	if ( cg.renderingThirdPerson ) return;

	// allow the gun to be completely removed
	if ( !cg_drawGun.integer ) {
		vec3_t		origin;

		if ( cg.predictedPlayerState.eFlags & EF_FIRING ) {
			// special hack for lightning gun...
			VectorCopy( cg.refdef.vieworg, origin );
			VectorMA( origin, -8, cg.refdef.viewaxis[2], origin );
			CG_LightningBolt( &cg_entities[ps->clientNum], origin );
		}
		return;
	}

	// don't draw if testing a gun model
	if ( cg.testGun ) return;

	// drop gun lower at higher fov
	if ( cg_fov.integer > 90 ) {
		fovOffset = -0.2 * ( cg_fov.integer - 90 );
	} else {
		fovOffset = 0;
	}

	cent = &cg.predictedPlayerEntity;
	CG_RegisterWeapon( ps->weapon );
	weapon = &cg_weapons[ ps->weapon ];

	memset (&hand, 0, sizeof(hand));

	// set up gun position
	CG_CalculateWeaponPosition( hand.origin, angles );

	VectorMA( hand.origin, cg_gun_x.value, cg.refdef.viewaxis[0], hand.origin );
	VectorMA( hand.origin, cg_gun_y.value, cg.refdef.viewaxis[1], hand.origin );
	VectorMA( hand.origin, (cg_gun_z.value+fovOffset), cg.refdef.viewaxis[2], hand.origin );

	AnglesToAxis( angles, hand.axis );

	// map torso animations to weapon animations
	if ( cg_gun_frame.integer ) {
		// development tool
		hand.frame = hand.oldframe = cg_gun_frame.integer;
		hand.backlerp = 0;
	} else {
		// get clientinfo for animation map
		ci = &cgs.clientinfo[ cent->currentState.clientNum ];
		hand.frame = CG_MapTorsoToWeaponFrame( ci, cent->pe.torso.frame );
		hand.oldframe = CG_MapTorsoToWeaponFrame( ci, cent->pe.torso.oldFrame );
		hand.backlerp = cent->pe.torso.backlerp;
	}

	hand.hModel = weapon->handsModel;
	hand.renderfx = RF_DEPTHHACK | RF_FIRST_PERSON | RF_MINLIGHT;

	// add everything onto the hand
	CG_AddPlayerWeapon( &hand, ps, &cg.predictedPlayerEntity, ps->persistant[PERS_TEAM] );
}

/*
==============================================================================

WEAPON SELECTION

==============================================================================
*/

/*
===================
CG_DrawWeaponSelect
===================
*/
void CG_DrawWeaponSelect( void ) {
	int		i;
	int		bits;
	int		count;
	int		x, y, w;
	char	*name;
	float	*color;

	// don't display if dead
	if ( cg.predictedPlayerState.stats[STAT_HEALTH] <= 0 ) return;

	color = CG_FadeColor( cg.weaponSelectTime, WEAPON_SELECT_TIME );
	if ( !color ) {
		return;
	}
	trap_R_SetColor( color );

	// showing weapon select clears pickup item display, but not the blend blob
	cg.itemPickupTime = 0;

	// count the number of weapons owned
	bits = cg.snap->ps.stats[ STAT_WEAPONS ];
	count = 0;
	for ( i = 1 ; i < 16 ; i++ ) {
		if ( bits & ( 1 << i ) ) {
			count++;
		}
	}

	x = 320 - count * 20;
	y = 380;

	for ( i = 1 ; i < 16 ; i++ ) {
		if ( !( bits & ( 1 << i ) ) ) continue;

		CG_RegisterWeapon( i );

		// draw weapon icon
		CG_DrawPic( x, y, 32, 32, cg_weapons[i].weaponIcon );

		// draw selection marker
		if ( i == cg.weaponSelect ) {
			CG_DrawPic( x-4, y-4, 40, 40, cgs.media.selectShader );
		}

		// no ammo cross on top
		if ( !cg.snap->ps.ammo[ i ] ) {
			CG_DrawPic( x, y, 32, 32, cgs.media.noammoShader );
		}

		x += 40;
	}

	// draw the selected name
	if ( cg_weapons[ cg.weaponSelect ].item ) {
		name = cg_weapons[ cg.weaponSelect ].item->pickup_name;
		if ( name ) {
			w = CG_DrawStrlen( name ) * BIGCHAR_WIDTH;
			x = ( SCREEN_WIDTH - w ) / 2;
			CG_DrawBigStringColor(x, y - 22, name, color);
		}
	}

	trap_R_SetColor( NULL );
}


/*
===============
CG_WeaponSelectable
===============
*/
static qboolean CG_WeaponSelectable( int i ) {

	if ( !cg.snap->ps.ammo[i] ) {
		return qfalse;
	}
	if ( ! (cg.snap->ps.stats[ STAT_WEAPONS ] & ( 1 << i ) ) ) {
		return qfalse;
	}

	return qtrue;
}

static qboolean tmpSkipWeapon[16];	// JUHOX

/*
===================
JUHOX: CG_MayAutoSelect
===================
*/
qboolean CG_MayAutoSelect(int weapon) {
	int limit;
	int maxAmmo;

	if (weapon <= WP_NONE || weapon >= WP_NUM_WEAPONS) return qfalse;
	if (!(cg.snap->ps.stats[STAT_WEAPONS] & (1<<weapon))) return qfalse;
	if (tmpSkipWeapon[weapon]) return qfalse;
	if (cg.weaponSelect == weapon) return qtrue;
	if (cg.snap->ps.ammo[weapon] == 0) return qfalse;

	if (cg.snap->ps.ammo[weapon] < 0) return qtrue;
	limit = cg_autoswitchAmmoLimit.integer;
	if (limit < 1 || limit > 100) limit = 50;
	maxAmmo = weaponAmmoCharacteristics[weapon].maxAmmo;

	if (weapon == WP_MONSTER_LAUNCHER) {
		maxAmmo = atoi(CG_ConfigString(CS_NUMMONSTERS)+4);
	}

	if (100 * cg.snap->ps.ammo[weapon] < limit * maxAmmo) return qfalse;

	return qtrue;
}

/*
===============
JUHOX: CG_FindBestWeapon
===============
*/
int CG_FindBestWeapon(int weaponOrder) {
	int i, n;

	if (weaponOrder >= 0 && weaponOrder < NUM_WEAPONORDERS) {
		cg.currentWeaponOrder = weaponOrder;
	}
	n = strlen(cg_weaponOrder[cg.currentWeaponOrder].string);
	for (i = 0; i < n; i++) {
		int weapon;

		weapon = cg_weaponOrder[cg.currentWeaponOrder].string[i] - 'A';
		if (CG_MayAutoSelect(weapon)) return weapon;
	}
	return WP_NONE;
}

/*
===============
JUHOX: CG_AutoSwitchToBestWeapon
===============
*/
void CG_AutoSwitchToBestWeapon(void) {
	if (!cg.snap) return;
	if (cg.snap->ps.pm_flags & PMF_FOLLOW) return;
	if (!cg_autoswitch.integer) return;
	if (!cg.weaponOrderActive) return;
	if (cg.weaponManuallySet) return;
	if (cg.snap->ps.eFlags & EF_FIRING) return;	// don't switch as long as the attack button is pressed
	cg.weaponSelect = CG_FindBestWeapon(-1);
}

/*
===============
JUHOX: CG_ManuallySwitchToBestWeapon
===============
*/
static void CG_ManuallySwitchToBestWeapon(int weaponOrder) {
	int currentWeapon;

	cg.weaponManuallySet = qfalse;
	memset(tmpSkipWeapon, 0, sizeof(tmpSkipWeapon));
	currentWeapon = cg.weaponSelect;
	cg.weaponSelect = WP_NONE;
	cg.weaponSelect = CG_FindBestWeapon(weaponOrder);
	if (cg.weaponSelect == WP_NONE) cg.weaponSelect = currentWeapon;
}

/*
===============
JUHOX: CG_BestWeapon_f
===============
*/
void CG_BestWeapon_f(void) {
	int weaponOrder;

	if (!cg.snap) return;
	if (cg.snap->ps.pm_type == PM_SPECTATOR) return;
	if (cg.snap->ps.pm_flags & PMF_FOLLOW) return;

	weaponOrder = -1;
	if (trap_Argc() >= 2) {
		weaponOrder = atoi(CG_Argv(1));
		cg.weaponOrderActive = qtrue;
	}
	else if (!cg.weaponOrderActive) {
		return;
	}
	CG_ManuallySwitchToBestWeapon(weaponOrder);
}

/*
===============
JUHOX: CG_SkipWeapon_f
===============
*/
void CG_SkipWeapon_f(void) {
	if (!cg.snap) return;
	if (cg.snap->ps.pm_type == PM_SPECTATOR) return;
	if (cg.snap->ps.pm_flags & PMF_FOLLOW) return;
	if (!cg.weaponOrderActive) return;

	if (tmpSkipWeapon[cg.weaponSelect]) {
		cg.weaponOrderActive = qfalse;
		memset(tmpSkipWeapon, 0, sizeof(tmpSkipWeapon));
		cg.currentWeaponOrder = 0;
		return;
	}

	tmpSkipWeapon[cg.weaponSelect] = qtrue;
	cg.weaponManuallySet = qfalse;
	CG_AutoSwitchToBestWeapon();
}

/*
===============
JUHOX: CG_NextWeaponOrder_f
===============
*/
void CG_NextWeaponOrder_f(void) {
	if (!cg.snap) return;

	// JUHOX: select effect in lens flare editor
	if (cgs.editMode == EM_mlf) {
		cg.lfEditor.selectedEffect++;
		if (cg.lfEditor.selectedEffect < 0) cg.lfEditor.selectedEffect = 0;
		if (cg.lfEditor.selectedEffect >= cgs.numLensFlareEffects) {
			cg.lfEditor.selectedEffect = cgs.numLensFlareEffects - 1;
		}
		return;
	}

	// JUHOX: select segment in EFH debug mode
	if (cgs.gametype == GT_EFH && cgs.debugEFH) {
		trap_SendClientCommand("efhdebugseg 1");
		return;
	}

	if (cg.snap->ps.pm_type == PM_SPECTATOR) return;
	if (cg.snap->ps.pm_flags & PMF_FOLLOW) return;

	if (!cg.weaponOrderActive) {
		cg.weaponOrderActive = qtrue;
		cg.currentWeaponOrder = -1;
	}

	cg.currentWeaponOrder++;
	if (cg.currentWeaponOrder >= NUM_WEAPONORDERS) cg.currentWeaponOrder = 0;
	CG_ManuallySwitchToBestWeapon(-1);
}

/*
===============
JUHOX: CG_PrevWeaponOrder_f
===============
*/
void CG_PrevWeaponOrder_f(void) {
	if (!cg.snap) return;

	// JUHOX: select effect in lens flare editor
	if (cgs.editMode == EM_mlf) {
		cg.lfEditor.selectedEffect--;
		if (cg.lfEditor.selectedEffect < 0) cg.lfEditor.selectedEffect = 0;
		if (cg.lfEditor.selectedEffect >= cgs.numLensFlareEffects) {
			cg.lfEditor.selectedEffect = cgs.numLensFlareEffects - 1;
		}
		return;
	}

	// JUHOX: select segment in EFH debug mode
	if (cgs.gametype == GT_EFH && cgs.debugEFH) {
		trap_SendClientCommand("efhdebugseg -1");
		return;
	}

	if (cg.snap->ps.pm_type == PM_SPECTATOR) return;
	if (cg.snap->ps.pm_flags & PMF_FOLLOW) return;

	if (!cg.weaponOrderActive) {
		cg.weaponOrderActive = qtrue;
		cg.currentWeaponOrder = 1;
	}

	cg.currentWeaponOrder--;
	if (cg.currentWeaponOrder < 0) cg.currentWeaponOrder = NUM_WEAPONORDERS-1;
	CG_ManuallySwitchToBestWeapon(-1);
}

/*
===============
CG_NextWeapon_f
===============
*/
void CG_NextWeapon_f( void ) {
	int		i;
	int		original;

	if ( !cg.snap ) return;
	if ( cg.snap->ps.pm_flags & PMF_FOLLOW ) return;

	// JUHOX: select effect in lens flare editor
	if (cgs.editMode == EM_mlf) {
		cg.lfEditor.selectedEffect++;
		if (cg.lfEditor.selectedEffect < 0) cg.lfEditor.selectedEffect = 0;
		if (cg.lfEditor.selectedEffect >= cgs.numLensFlareEffects) {
			cg.lfEditor.selectedEffect = cgs.numLensFlareEffects - 1;
		}
		return;
	}

	// JUHOX: select segment in EFH debug mode
	if (cgs.gametype == GT_EFH && cgs.debugEFH) {
		trap_SendClientCommand("efhdebugseg 1");
		return;
	}

	cg.weaponManuallySet = qtrue;	// JUHOX
	memset(tmpSkipWeapon, 0, sizeof(tmpSkipWeapon));	// JUHOX: not really needed i think

	// JUHOX: this is a workaround to the late server side weapon selection
	if (cg.weaponSelect == WP_NONE) cg.weaponSelect = cg.snap->ps.weapon;

	cg.weaponSelectTime = cg.time;
	original = cg.weaponSelect;

	for ( i = 0 ; i < 16 ; i++ ) {
		cg.weaponSelect++;
		if ( cg.weaponSelect == 16 ) {
			cg.weaponSelect = 0;
		}

		// JUHOX: never cycle to the grappling hook
		// SLK: yes we CAN
		if ( CG_WeaponSelectable( cg.weaponSelect ) ) break;

	}
	if ( i == 16 ) {
		cg.weaponSelect = original;
	}
}

/*
===============
CG_PrevWeapon_f
===============
*/
void CG_PrevWeapon_f( void ) {
	int		i;
	int		original;

	if ( !cg.snap ) {
		return;
	}
	if ( cg.snap->ps.pm_flags & PMF_FOLLOW ) {
		return;
	}

	// JUHOX: select effect in lens flare editor
	if (cgs.editMode == EM_mlf) {
		cg.lfEditor.selectedEffect--;
		if (cg.lfEditor.selectedEffect < 0) cg.lfEditor.selectedEffect = 0;
		if (cg.lfEditor.selectedEffect >= cgs.numLensFlareEffects) {
			cg.lfEditor.selectedEffect = cgs.numLensFlareEffects - 1;
		}
		return;
	}

	// JUHOX: select segment in EFH debug mode
	if (cgs.gametype == GT_EFH && cgs.debugEFH) {
		trap_SendClientCommand("efhdebugseg -1");
		return;
	}

	cg.weaponManuallySet = qtrue;	// JUHOX
	memset(tmpSkipWeapon, 0, sizeof(tmpSkipWeapon));	// JUHOX: not really needed i think

	// JUHOX: this is a workaround to the late server side weapon selection
	if (cg.weaponSelect == WP_NONE) cg.weaponSelect = cg.snap->ps.weapon;

	cg.weaponSelectTime = cg.time;
	original = cg.weaponSelect;

	for ( i = 0 ; i < 16 ; i++ ) {
		cg.weaponSelect--;
		if ( cg.weaponSelect == -1 ) {
			cg.weaponSelect = 15;
		}

		// JUHOX: never cycle to the grappling hook
		if (cg.weaponSelect == WP_GRAPPLING_HOOK) continue;

		if ( CG_WeaponSelectable( cg.weaponSelect ) ) {
			break;
		}
	}
	if ( i == 16 ) {
		cg.weaponSelect = original;
	}
}

/*
===============
JUHOX: CG_AddLensFlareEntity
===============
*/
static lensFlareEntity_t* CG_AddLensFlareEntity(const lensFlareEntity_t* model) {
	int entnum;
	lensFlareEntity_t* lfent;

	if (cgs.numLensFlareEntities >= MAX_LIGHTS_PER_MAP) return NULL;

	entnum = cgs.numLensFlareEntities++;
	lfent = &cgs.lensFlareEntities[entnum];

	memset(lfent, 0, sizeof(*lfent));
	VectorCopy(cg.snap->ps.origin, lfent->origin);
	if (model) {
		lfent->radius = model->radius;
		lfent->lightRadius = model->lightRadius;
		lfent->lfeff = model->lfeff;
		VectorCopy(model->dir, lfent->dir);
		lfent->angle = model->angle;
	}
	else {
		lfent->radius = 5.0;
		lfent->lfeff = &cgs.lensFlareEffects[cg.lfEditor.selectedEffect];
		lfent->dir[0] = 1.0;
		lfent->angle = -1;
	}
	CG_ComputeMaxVisAngle(lfent);

	cg.lfEditor.originalLFEnt = *lfent;

	return lfent;
}


/*
===============
JUHOX: CG_DeleteLensFlareEntity
===============
*/
static void CG_DeleteLensFlareEntity(lensFlareEntity_t* lfent) {
	int lfentnum;
	int i;

	lfentnum = lfent - cgs.lensFlareEntities;
	if (lfentnum < 0) return;
	if (lfentnum >= cgs.numLensFlareEntities) return;

	for (i = lfentnum; i < cgs.numLensFlareEntities-1; i++) {
		cgs.lensFlareEntities[i] = cgs.lensFlareEntities[i+1];
	}
	cgs.numLensFlareEntities--;
}


/*
=========================
JUHOX: CG_FindNextEntityByEffect
=========================
*/
static int CG_FindNextEntityByEffect(void) {
	const lensFlareEffect_t* lfeff;
	int start;
	int i;

	lfeff = &cgs.lensFlareEffects[cg.lfEditor.selectedEffect];
	start = -1;
	if (cg.lfEditor.selectedLFEnt) {
		start = cg.lfEditor.selectedLFEnt - cgs.lensFlareEntities;
	}
	for (i = 1; i <= cgs.numLensFlareEntities; i++) {
		int j;
		const lensFlareEntity_t* lfent;

		j = (start + i) % cgs.numLensFlareEntities;
		lfent = &cgs.lensFlareEntities[j];
		if (lfent->lfeff == lfeff) return j;
	}
	return -1;
}


/*
=========================
JUHOX: CG_EvaluateViewDir
=========================
*/
#define MAX_VIEWTESTS 200
static vec3_t viewDirList[MAX_VIEWTESTS];
static float CG_EvaluateViewDir(const vec3_t viewDir, int listSize) {
	float evaluation;
	int i;

	evaluation = 0;
	for (i = 0; i < listSize; i++) {
		float d;

		d = DotProduct(viewDir, viewDirList[i]);
		if (d <= 0) continue;

		evaluation += d;
	}
	return evaluation;
}


/*
=========================
JUHOX: CG_FindBestViewOrg
=========================
*/
static void CG_FindBestViewOrg(const lensFlareEntity_t* lfent, vec3_t viewOrg) {
	vec3_t origin;
	float viewDistance;
	int i;
	int listSize;
	float bestEvaluation;
	int bestDir;

	CG_LFEntOrigin(lfent, origin);
	VectorCopy(origin, viewOrg);

	viewDistance = 3 * lfent->radius + 100;
	listSize = 0;

	for (i = 0; i < MAX_VIEWTESTS; i++) {
		vec3_t dir;
		vec3_t start;
		vec3_t end;
		trace_t trace;
		vec3_t candidate;

		dir[0] = crandom();
		dir[1] = crandom();
		dir[2] = crandom();
		if (VectorNormalize(dir) < 0.001) continue;

		VectorMA(origin, lfent->radius, dir, start);
		VectorMA(origin, viewDistance, dir, end);
		CG_Trace(&trace, start, NULL, NULL, end, -1, MASK_OPAQUE|CONTENTS_BODY);
		if (trace.fraction < 0.1) continue;

		VectorMA(trace.endpos, -10, dir, candidate);
		CG_Trace(&trace, candidate, NULL, NULL, start, -1, MASK_OPAQUE|CONTENTS_BODY);
		if (trace.fraction < 1) continue;

		VectorSubtract(candidate, origin, viewDirList[listSize]);
		listSize++;	// CAUTION: don't add this to the line above -- VectorSubtract() is a macro!
	}

	bestEvaluation = 0;
	bestDir = -1;
	for (i = 0; i < listSize; i++) {
		float evaluation;

		evaluation = CG_EvaluateViewDir(viewDirList[i], listSize);
		if (evaluation <= bestEvaluation) continue;

		bestEvaluation = evaluation;
		bestDir = i;
	}

	if (bestDir >= 0) {
		VectorAdd(origin, viewDirList[bestDir], viewOrg);
	}
}

/*
=========================
JUHOX: CG_NextMover
=========================
*/
static centity_t* CG_NextMover(centity_t* current) {
	int start, i;

	if (!current) current = &cg_entities[0];

	start = current - cg_entities;
	for (i = 1; i <= MAX_GENTITIES; i++) {
		current = &cg_entities[(start + i) % MAX_GENTITIES];
		if (current->currentState.eType != ET_MOVER) continue;
		if (!current->currentValid) continue;

		return current;
	}
	return NULL;
}


/*
=========================
JUHOX: CG_HandleCopyOptions
=========================
*/
static void CG_HandleCopyOptions(int command) {
	switch (command) {
	case 1:	// cancel
		cg.lfEditor.cmdMode = LFECM_main;
		break;
	case 2:	// effect
		cg.lfEditor.copyOptions ^= LFECO_EFFECT;
		break;
	case 3:	// vis radius
		cg.lfEditor.copyOptions ^= LFECO_VISRADIUS;
		break;
	case 4:	// light radius
		cg.lfEditor.copyOptions ^= LFECO_LIGHTRADIUS;
		break;
	case 5:	// spot light direction
		cg.lfEditor.copyOptions ^= LFECO_SPOT_DIR;
		break;
	case 6:	// spot light entity angle
		cg.lfEditor.copyOptions ^= LFECO_SPOT_ANGLE;
		break;
	}
}

/*
===============
CG_Weapon_f
===============
*/
void CG_Weapon_f( void ) {
	int		num;

	if ( !cg.snap ) {
		return;
	}
	if ( cg.snap->ps.pm_flags & PMF_FOLLOW ) {
		return;
	}

	num = atoi( CG_Argv( 1 ) );

	if ( num < 1 || num > 15 ) {
		return;
	}

	// JUHOX: in lens flare editor weapon chooses a command
	if (cgs.editMode == EM_mlf) {
		if (num != 3) cg.lfEditor.delAck = qfalse;

		if (cg.lfEditor.cmdMode == LFECM_copyOptions) {
			CG_HandleCopyOptions(num);
			return;
		}

		switch (num) {
		case 1:	// cancel
			if (cg.lfEditor.selectedLFEnt) {
				*cg.lfEditor.selectedLFEnt = cg.lfEditor.originalLFEnt;
			}
			cg.lfEditor.selectedLFEnt = NULL;
			cg.lfEditor.editMode = LFEEM_none;
			CG_SetLFEdMoveMode(LFEMM_coarse);
			break;
		case 2:	// add lens flare entity / switch mover state
			if (!(cg.lfEditor.oldButtons & BUTTON_WALKING)) {
				if (cg.lfEditor.editMode == LFEEM_none) {
					cg.lfEditor.selectedLFEnt = CG_AddLensFlareEntity(cg.lfEditor.selectedLFEnt);
					if (cg.lfEditor.selectedLFEnt) {
						cg.lfEditor.editMode = LFEEM_pos;
						CG_SetLFEdMoveMode(LFEMM_coarse);
					}
				}
			}
			else {
				cg.lfEditor.moversStopped = !cg.lfEditor.moversStopped;
			}
			break;
		case 3: // delete lens flare entity / select mover
			if (!(cg.lfEditor.oldButtons & BUTTON_WALKING)) {
				if (cg.lfEditor.selectedLFEnt) {
					if (!cg.lfEditor.delAck) {
						cg.lfEditor.delAck = qtrue;
					}
					else {
						cg.lfEditor.delAck = qfalse;
						CG_DeleteLensFlareEntity(cg.lfEditor.selectedLFEnt);
						cg.lfEditor.selectedLFEnt = NULL;
						cg.lfEditor.editMode = LFEEM_none;
						CG_SetLFEdMoveMode(LFEMM_coarse);
					}
				}
			}
			else if (cg.lfEditor.moversStopped) {
				cg.lfEditor.selectedMover = CG_NextMover(cg.lfEditor.selectedMover);
			}
			break;
		case 4:	// edit position & vis radius / lock to mover
			if (!(cg.lfEditor.oldButtons & BUTTON_WALKING)) {
				if (cg.lfEditor.selectedLFEnt) {
					if (cg.lfEditor.editMode == LFEEM_pos) {
						cg.lfEditor.editMode = LFEEM_none;
						CG_SetLFEdMoveMode(LFEMM_coarse);
					}
					else {
						cg.lfEditor.editMode = LFEEM_pos;
						CG_SetLFEdMoveMode(LFEMM_fine);
					}
				}
			}
			else if (cg.lfEditor.selectedLFEnt) {
				if (cg.lfEditor.selectedLFEnt->lock) {
					VectorAdd(
						cg.lfEditor.selectedLFEnt->origin,
						cg.lfEditor.selectedLFEnt->lock->lerpOrigin,
						cg.lfEditor.selectedLFEnt->origin
					);
					cg.lfEditor.selectedLFEnt->lock = NULL;
				}
				else {
					if (cg.lfEditor.selectedMover && cg.lfEditor.moversStopped) {
						cg.lfEditor.selectedLFEnt->lock = cg.lfEditor.selectedMover;
						VectorSubtract(
							cg.lfEditor.selectedLFEnt->origin,
							cg.lfEditor.selectedLFEnt->lock->lerpOrigin,
							cg.lfEditor.selectedLFEnt->origin
						);
					}
					else {
						CG_Printf("no mover selected\n");
					}
				}
			}
			break;
		case 5:	// edit target & angle / search entity
			if (!(cg.lfEditor.oldButtons & BUTTON_WALKING)) {
				if (cg.lfEditor.selectedLFEnt) {
					if (cg.lfEditor.editMode == LFEEM_target) {
						cg.lfEditor.editMode = LFEEM_none;
						CG_SetLFEdMoveMode(LFEMM_coarse);
					}
					else {
						cg.lfEditor.editMode = LFEEM_target;
						CG_SetLFEdMoveMode(LFEMM_fine);
						cg.lfEditor.editTarget = qtrue;
					}
				}
			}
			else {
				int nextLFEnt;

				nextLFEnt = CG_FindNextEntityByEffect();
				if (nextLFEnt >= 0) {
					const lensFlareEntity_t* lfent;
					vec3_t viewOrg;
					vec3_t dir;
					vec3_t angles;

					CG_SelectLFEnt(nextLFEnt);

					lfent = &cgs.lensFlareEntities[nextLFEnt];
					CG_FindBestViewOrg(lfent, viewOrg);
					CG_LFEntOrigin(lfent, dir);
					VectorSubtract(dir, viewOrg, dir);
					vectoangles(dir, angles);
					trap_SendClientCommand(
						va(
							"lfemm %d %f %f %f %f %f %f",
							cg.lfEditor.moveMode,
							viewOrg[0], viewOrg[1], viewOrg[2],
							angles[0], angles[1], angles[3]
						)
					);
				}
				else {
					CG_Printf("No flare entity found with '%s'\n", cgs.lensFlareEffects[cg.lfEditor.selectedEffect]);
				}
			}
			break;
		case 6:	// edit light size & vis radius / copy options
			if (!(cg.lfEditor.oldButtons & BUTTON_WALKING)) {
				if (cg.lfEditor.selectedLFEnt) {
					if (cg.lfEditor.editMode == LFEEM_radius) {
						cg.lfEditor.editMode = LFEEM_none;
						CG_SetLFEdMoveMode(LFEMM_coarse);
					}
					else {
						cg.lfEditor.editMode = LFEEM_radius;
						CG_SetLFEdMoveMode(LFEMM_fine);
					}
				}
			}
			else {
				cg.lfEditor.cmdMode = LFECM_copyOptions;
			}
			break;
		case 7:	// assign effect / paste lf entity
			if (!(cg.lfEditor.oldButtons & BUTTON_WALKING)) {
				if (
					cg.lfEditor.selectedLFEnt &&
					cg.lfEditor.selectedEffect >= 0 &&
					cg.lfEditor.selectedEffect < cgs.numLensFlareEffects
				) {
					cg.lfEditor.selectedLFEnt->lfeff = &cgs.lensFlareEffects[cg.lfEditor.selectedEffect];
					CG_ComputeMaxVisAngle(cg.lfEditor.selectedLFEnt);
				}
			}
			else if (cg.lfEditor.selectedLFEnt) {
				lensFlareEntity_t* lfent;

				lfent = cg.lfEditor.selectedLFEnt;
				if (cg.lfEditor.copyOptions & LFECO_EFFECT) {
					if (cg.lfEditor.copiedLFEnt.lfeff) {
						lfent->lfeff = cg.lfEditor.copiedLFEnt.lfeff;
						CG_ComputeMaxVisAngle(lfent);
					}
				}
				if (cg.lfEditor.copyOptions & LFECO_VISRADIUS) {
					lfent->radius = cg.lfEditor.copiedLFEnt.radius;
					if (lfent->lightRadius > lfent->radius) {
						lfent->lightRadius = lfent->radius;
					}
				}
				if (cg.lfEditor.copyOptions & LFECO_LIGHTRADIUS) {
					lfent->lightRadius = cg.lfEditor.copiedLFEnt.lightRadius;
					if (lfent->radius < lfent->lightRadius) {
						lfent->radius = lfent->lightRadius;
					}
				}
				if (cg.lfEditor.copyOptions & LFECO_SPOT_DIR) {
					VectorCopy(cg.lfEditor.copiedLFEnt.dir, lfent->dir);
				}
				if (cg.lfEditor.copyOptions & LFECO_SPOT_ANGLE) {
					lfent->angle = cg.lfEditor.copiedLFEnt.angle;
				}
			}
			break;
		case 8:	// note effect / copy lf entity
			if (!(cg.lfEditor.oldButtons & BUTTON_WALKING)) {
				if (
					cg.lfEditor.selectedLFEnt &&
					cg.lfEditor.selectedLFEnt->lfeff &&
					cgs.numLensFlareEffects > 0
				) {
					cg.lfEditor.selectedEffect = cg.lfEditor.selectedLFEnt->lfeff - cgs.lensFlareEffects;
				}
			}
			else {
				if (cg.lfEditor.selectedLFEnt) {
					cg.lfEditor.copiedLFEnt = *(cg.lfEditor.selectedLFEnt);
				}
			}
			break;
		case 9:	// draw mode / cursor size
			if (!(cg.lfEditor.oldButtons & BUTTON_WALKING)) {
				cg.lfEditor.drawMode++;
				if (cg.lfEditor.drawMode < 0 || cg.lfEditor.drawMode > LFEDM_none) {
					cg.lfEditor.drawMode = 0;
				}
			}
			else {
				if (cg.lfEditor.selectedLFEnt) {
					cg.lfEditor.cursorSize++;
					if (cg.lfEditor.cursorSize < 0 || cg.lfEditor.cursorSize > LFECS_visRadius) {
						cg.lfEditor.cursorSize = 0;
					}
				}
			}
			break;
		}
		return;
	}

	cg.weaponSelectTime = cg.time;

	if ( ! ( cg.snap->ps.stats[STAT_WEAPONS] & ( 1 << num ) ) ) return;		// don't have the weapon

	cg.weaponManuallySet = qtrue;	// JUHOX
	memset(tmpSkipWeapon, 0, sizeof(tmpSkipWeapon));	// JUHOX

	cg.weaponSelect = num;
}

/*
===================
CG_OutOfAmmoChange

The current weapon has just run out of ammo
===================
*/
void CG_OutOfAmmoChange( void ) {

	cg.weaponSelectTime = cg.time;
	CG_ManuallySwitchToBestWeapon(-1);

}



/*
===================================================================================================

WEAPON EVENTS

===================================================================================================
*/

/*
================
CG_FireWeapon

Caused by an EV_FIRE_WEAPON event
================
*/
void CG_FireWeapon( centity_t *cent ) {
	entityState_t *ent;
	int				c;
	weaponInfo_t	*weap;

	ent = &cent->currentState;
	// JUHOX: use gauntlet hit sound for predator weapon
	if (ent->eType == ET_PLAYER) {
		switch (ent->clientNum) {
		case CLIENTNUM_MONSTER_PREDATOR:
		case CLIENTNUM_MONSTER_PREDATOR_RED:
		case CLIENTNUM_MONSTER_PREDATOR_BLUE:
			trap_S_StartSound(NULL, ent->number, CHAN_WEAPON, cg_weapons[WP_GAUNTLET].flashSound[0]);
			return;
		case CLIENTNUM_MONSTER_TITAN:
			trap_S_StartSound(NULL, ent->number, CHAN_WEAPON, trap_S_RegisterSound("sound/weapons/rocket/rocklf1a.wav", qfalse));
			trap_S_StartLocalSound(trap_S_RegisterSound("sound/earthquake1000.wav", qfalse), CHAN_WEAPON);
			return;
		}
	}

	if ( ent->weapon == WP_NONE ) {
		return;
	}
	if ( ent->weapon >= WP_NUM_WEAPONS ) {
		CG_Error( "CG_FireWeapon: ent->weapon >= WP_NUM_WEAPONS" );
		return;
	}
	weap = &cg_weapons[ ent->weapon ];

	// mark the entity as muzzle flashing, so when it is added it will
	// append the flash to the weapon model
	cent->muzzleFlashTime = cg.time;

	// lightning gun only does this this on initial press
	if ( ent->weapon == WP_LIGHTNING ) {
		if ( cent->pe.lightningFiring ) {
			return;
		}
	}

	// play a sound
	for ( c = 0 ; c < 4 ; c++ ) {
		if ( !weap->flashSound[c] ) {
			break;
		}
	}
	if ( c > 0 ) {
		c = rand() % c;
		if ( weap->flashSound[c] )
		{
			trap_S_StartSound( NULL, ent->number, CHAN_WEAPON, weap->flashSound[c] );
		}
	}

	// do brass ejection
	if ( weap->ejectBrassFunc && cg_brassTime.integer > 0 ) {
		weap->ejectBrassFunc( cent );
	}
}


/*
=================
CG_MissileHitWall

Caused by an EV_MISSILE_MISS event, or directly by local bullet tracing
=================
*/
void CG_MissileHitWall( int weapon, int clientNum, vec3_t origin, vec3_t dir, impactSound_t soundType ) {
	qhandle_t		mod;
	qhandle_t		mark;
	qhandle_t		shader;
	sfxHandle_t		sfx;
	float			radius;
	float			light;
	vec3_t			lightColor;
	localEntity_t	*le;
	int				r;
	qboolean		alphaFade;
	qboolean		isSprite;
	int				duration;
	vec3_t			sprOrg;
	vec3_t			sprVel;

	mark = 0;
	radius = 32;
	sfx = 0;
	mod = 0;
	shader = 0;
	light = 0;
	lightColor[0] = 1;
	lightColor[1] = 1;
	lightColor[2] = 0;

	// set defaults
	isSprite = qfalse;
	duration = 600;

	switch ( weapon ) {
	// JUHOX: add sound for grapple
	case WP_GRAPPLING_HOOK:
		if (rand() & 1) {
			sfx = cgs.media.hgrenb1aSound;
		} else {
			sfx = cgs.media.hgrenb2aSound;
		}
		break;
	default:

	case WP_LIGHTNING:
		// no explosion at LG impact, it is added with the beam
		r = rand() & 3;
		if ( r < 2 ) {
			sfx = cgs.media.sfx_lghit2;
		} else if ( r == 2 ) {
			sfx = cgs.media.sfx_lghit1;
		} else {
			sfx = cgs.media.sfx_lghit3;
		}
		mark = cgs.media.holeMarkShader;
		radius = 12;
		CG_CheckStrongLight(origin, 200, colorWhite);	// JUHOX
		break;

	case WP_GRENADE_LAUNCHER:
		mod = cgs.media.dishFlashModel;
		shader = cgs.media.grenadeExplosionShader;
		sfx = cgs.media.sfx_rockexp;
		mark = cgs.media.burnMarkShader;
		radius = 64;
		light = 300;
		isSprite = qtrue;
		CG_CheckStrongLight(origin, 600, colorWhite);	// JUHOX
		CG_AddEarthquake(origin, 600, 0.5, 0, 0.5, 200);
		break;
	case WP_ROCKET_LAUNCHER:
		mod = cgs.media.dishFlashModel;
		shader = cgs.media.rocketExplosionShader;
		sfx = cgs.media.sfx_rockexp;
		mark = cgs.media.burnMarkShader;
		radius = 64;
		light = 300;
		isSprite = qtrue;
		duration = 1000;
		lightColor[0] = 1;
		lightColor[1] = 0.75;
		lightColor[2] = 0.0;
		if (cg_oldRocket.integer == 0) {
			// explosion sprite animation
			VectorMA( origin, 24, dir, sprOrg );
			VectorScale( dir, 64, sprVel );

			CG_ParticleExplosion( "explode1", sprOrg, sprVel, 1400, 20, 30 );
		}
		CG_CheckStrongLight(origin, 600, colorWhite);	// JUHOX
		CG_AddEarthquake(origin, 400, 0.4, 0, 0.4, 300);
		break;
	case WP_RAILGUN:
		mod = cgs.media.ringFlashModel;
		shader = cgs.media.railExplosionShader;
		sfx = cgs.media.sfx_plasmaexp;
		mark = cgs.media.energyMarkShader;
		radius = 24;
		CG_CheckStrongLight(origin, 150, colorWhite);	// JUHOX
		CG_AddEarthquake(origin, 400, 0.2, 0, 0.2, 400);
		break;
	case WP_PLASMAGUN:
		mod = cgs.media.ringFlashModel;
		shader = cgs.media.plasmaExplosionShader;
		sfx = cgs.media.sfx_plasmaexp;
		mark = cgs.media.energyMarkShader;
		radius = 16;
		CG_CheckStrongLight(origin, 200, colorWhite);	// JUHOX
		break;
	case WP_BFG:
		mod = cgs.media.dishFlashModel;
		shader = cgs.media.bfgExplosionShader;
		sfx = cgs.media.sfx_rockexp;
		mark = cgs.media.burnMarkShader;
		radius = 32;
		isSprite = qtrue;
		// JUHOX: add light for the bfg explosion
		if (cg_BFGsuperExpl.integer) {
			light = 300;
			lightColor[0] = 0.25;
			lightColor[1] = 1;
			lightColor[2] = 0.5;
		}

		CG_CheckStrongLight(origin, 800, colorWhite);	// JUHOX
		CG_AddEarthquake(origin, 1000, 0.5, 0, 0.5, 400);
		break;
	case WP_SHOTGUN:
		mod = cgs.media.bulletFlashModel;
		shader = cgs.media.bulletExplosionShader;
		mark = cgs.media.bulletMarkShader;
		sfx = 0;
		radius = 4;
		break;

	case WP_MACHINEGUN:
		mod = cgs.media.bulletFlashModel;
		shader = cgs.media.bulletExplosionShader;
		mark = cgs.media.bulletMarkShader;

		r = rand() & 3;
		if ( r == 0 ) {
			sfx = cgs.media.sfx_ric1;
		} else if ( r == 1 ) {
			sfx = cgs.media.sfx_ric2;
		} else {
			sfx = cgs.media.sfx_ric3;
		}

		radius = 8;
		break;
	}

	if ( sfx ) {
		trap_S_StartSound( origin, ENTITYNUM_WORLD, CHAN_AUTO, sfx );
	}


	// create the explosion
	//
	// JUHOX: handle new bfg super explosion
	if (weapon == WP_BFG && cg_BFGsuperExpl.integer) {
		CG_BFGsuperExpl(origin);
	}

	if ( mod ) {
		le = CG_MakeExplosion( origin, dir, mod, shader, duration, isSprite );

        // JUHOX FIXME: no dlights in EFH
        if (cgs.gametype == GT_EFH) {
            light = 0;
        }

		le->light = light;
		VectorCopy( lightColor, le->lightColor );
		if ( weapon == WP_RAILGUN ) {
			// colorize with client color
			VectorCopy( cgs.clientinfo[clientNum].color1, le->color );
		}
	}

	if (!mark) return;	// JUHOX

	//
	// impact mark
	//
	alphaFade = (mark == cgs.media.energyMarkShader);	// plasma fades alpha, all others fade color
	if ( weapon == WP_RAILGUN ) {
		float	*color;

		// colorize with client color
		color = cgs.clientinfo[clientNum].color2;
		CG_ImpactMark( mark, origin, dir, random()*360, color[0],color[1], color[2],1, alphaFade, radius, qfalse );
	} else {
		CG_ImpactMark( mark, origin, dir, random()*360, 1,1,1,1, alphaFade, radius, qfalse );
	}
}


/*
=================
CG_MissileHitPlayer
=================
*/
void CG_MissileHitPlayer( int weapon, vec3_t origin, vec3_t dir, int entityNum ) {
	CG_Bleed( origin, entityNum );

	// some weapons will make an explosion with the blood, while
	// others will just make the blood
	switch ( weapon ) {
	case WP_GRENADE_LAUNCHER:
	case WP_ROCKET_LAUNCHER:
		CG_MissileHitWall( weapon, 0, origin, dir, IMPACTSOUND_FLESH );
		break;
	default:
		break;
	}
}



/*
============================================================================

SHOTGUN TRACING

============================================================================
*/

/*
================
CG_ShotgunPellet
================
*/
static void CG_ShotgunPellet( vec3_t start, vec3_t end, int skipNum ) {
	trace_t		tr;
	int sourceContentType, destContentType;

	CG_Trace( &tr, start, NULL, NULL, end, skipNum, MASK_SHOT );

	sourceContentType = trap_CM_PointContents( start, 0 );
	destContentType = trap_CM_PointContents( tr.endpos, 0 );

	// FIXME: should probably move this cruft into CG_BubbleTrail
	if ( sourceContentType == destContentType ) {
		if ( sourceContentType & CONTENTS_WATER ) {
			CG_BubbleTrail( start, tr.endpos, 32 );
		}
	} else if ( sourceContentType & CONTENTS_WATER ) {
		trace_t trace;

		trap_CM_BoxTrace( &trace, end, start, NULL, NULL, 0, CONTENTS_WATER );
		CG_BubbleTrail( start, trace.endpos, 32 );
	} else if ( destContentType & CONTENTS_WATER ) {
		trace_t trace;

		trap_CM_BoxTrace( &trace, start, end, NULL, NULL, 0, CONTENTS_WATER );
		CG_BubbleTrail( tr.endpos, trace.endpos, 32 );
	}

	if (  tr.surfaceFlags & SURF_NOIMPACT ) {
		return;
	}

	if ( cg_entities[tr.entityNum].currentState.eType == ET_PLAYER ) {
		CG_MissileHitPlayer( WP_SHOTGUN, tr.endpos, tr.plane.normal, tr.entityNum );
	} else {
		if ( tr.surfaceFlags & SURF_NOIMPACT ) {
			// SURF_NOIMPACT will not make a flame puff or a mark
			return;
		}
		if ( tr.surfaceFlags & SURF_METALSTEPS ) {
			CG_MissileHitWall( WP_SHOTGUN, 0, tr.endpos, tr.plane.normal, IMPACTSOUND_METAL );
		} else {
			CG_MissileHitWall( WP_SHOTGUN, 0, tr.endpos, tr.plane.normal, IMPACTSOUND_DEFAULT );
		}
	}
}

/*
================
CG_ShotgunPattern

Perform the same traces the server did to locate the
hit splashes
================
*/
static void CG_ShotgunPattern( vec3_t origin, vec3_t origin2, int seed, int otherEntNum ) {
	int			i;
	float		r, u;
	vec3_t		end;
	vec3_t		forward, right, up;

	// derive the right and up vectors from the forward vector, because
	// the client won't have any other information
	VectorNormalize2( origin2, forward );
	PerpendicularVector( right, forward );
	CrossProduct( forward, right, up );

	// generate the "random" spread pattern
	for ( i = 0 ; i < DEFAULT_SHOTGUN_COUNT ; i++ ) {
		r = Q_crandom( &seed ) * DEFAULT_SHOTGUN_SPREAD * 16;
		u = Q_crandom( &seed ) * DEFAULT_SHOTGUN_SPREAD * 16;
		VectorMA( origin, 8192 * 16, forward, end);
		VectorMA (end, r, right, end);
		VectorMA (end, u, up, end);

		CG_ShotgunPellet( origin, end, otherEntNum );
	}
}

/*
==============
CG_ShotgunFire
==============
*/
void CG_ShotgunFire( entityState_t *es ) {
	vec3_t	v;
	int		contents;

	VectorSubtract( es->origin2, es->pos.trBase, v );
	VectorNormalize( v );
	VectorScale( v, 32, v );
	VectorAdd( es->pos.trBase, v, v );
	if ( cgs.glconfig.hardwareType != GLHW_RAGEPRO ) {
		// ragepro can't alpha fade, so don't even bother with smoke
		vec3_t			up;

		contents = trap_CM_PointContents( es->pos.trBase, 0 );
		if ( !( contents & CONTENTS_WATER ) ) {
			VectorSet( up, 0, 0, 8 );
			CG_SmokePuff( v, up, 32, 1, 1, 1, 0.33f, 900, cg.time, 0, LEF_PUFF_DONT_SCALE, cgs.media.shotgunSmokePuffShader );
		}
	}
	CG_ShotgunPattern( es->pos.trBase, es->origin2, es->eventParm, es->otherEntityNum );
}

/*
============================================================================

BULLETS

============================================================================
*/


/*
===============
CG_Tracer
===============
*/
void CG_Tracer( vec3_t source, vec3_t dest ) {
	vec3_t		forward, right;
	polyVert_t	verts[4];
	vec3_t		line;
	float		len, begin, end;
	vec3_t		start, finish;
	vec3_t		midpoint;

	// tracer
	VectorSubtract( dest, source, forward );
	len = VectorNormalize( forward );

	// start at least a little ways from the muzzle
	if ( len < 100 ) {
		return;
	}
	begin = 50 + random() * (len - 60);
	end = begin + cg_tracerLength.value;
	if ( end > len ) {
		end = len;
	}
	VectorMA( source, begin, forward, start );
	VectorMA( source, end, forward, finish );

	line[0] = DotProduct( forward, cg.refdef.viewaxis[1] );
	line[1] = DotProduct( forward, cg.refdef.viewaxis[2] );

	VectorScale( cg.refdef.viewaxis[1], line[1], right );
	VectorMA( right, -line[0], cg.refdef.viewaxis[2], right );
	VectorNormalize( right );

	VectorMA( finish, cg_tracerWidth.value, right, verts[0].xyz );
	verts[0].st[0] = 0;
	verts[0].st[1] = 1;
	verts[0].modulate[0] = 255;
	verts[0].modulate[1] = 255;
	verts[0].modulate[2] = 255;
	verts[0].modulate[3] = 255;

	VectorMA( finish, -cg_tracerWidth.value, right, verts[1].xyz );
	verts[1].st[0] = 1;
	verts[1].st[1] = 0;
	verts[1].modulate[0] = 255;
	verts[1].modulate[1] = 255;
	verts[1].modulate[2] = 255;
	verts[1].modulate[3] = 255;

	VectorMA( start, -cg_tracerWidth.value, right, verts[2].xyz );
	verts[2].st[0] = 1;
	verts[2].st[1] = 1;
	verts[2].modulate[0] = 255;
	verts[2].modulate[1] = 255;
	verts[2].modulate[2] = 255;
	verts[2].modulate[3] = 255;

	VectorMA( start, cg_tracerWidth.value, right, verts[3].xyz );
	verts[3].st[0] = 0;
	verts[3].st[1] = 0;
	verts[3].modulate[0] = 255;
	verts[3].modulate[1] = 255;
	verts[3].modulate[2] = 255;
	verts[3].modulate[3] = 255;

	trap_R_AddPolyToScene( cgs.media.tracerShader, 4, verts );

	midpoint[0] = ( start[0] + finish[0] ) * 0.5;
	midpoint[1] = ( start[1] + finish[1] ) * 0.5;
	midpoint[2] = ( start[2] + finish[2] ) * 0.5;

	// add the tracer sound
	trap_S_StartSound( midpoint, ENTITYNUM_WORLD, CHAN_AUTO, cgs.media.tracerSound );

}


/*
======================
CG_CalcMuzzlePoint
======================
*/
static qboolean	CG_CalcMuzzlePoint( int entityNum, vec3_t muzzle ) {
	vec3_t		forward;
	centity_t	*cent;
	int			anim;

	if ( entityNum == cg.snap->ps.clientNum ) {
		VectorCopy( cg.snap->ps.origin, muzzle );
		muzzle[2] += cg.snap->ps.viewheight;
		AngleVectors( cg.snap->ps.viewangles, forward, NULL, NULL );
		VectorMA( muzzle, 14, forward, muzzle );
		return qtrue;
	}

	cent = &cg_entities[entityNum];
	if ( !cent->currentValid ) {
		return qfalse;
	}

	VectorCopy( cent->currentState.pos.trBase, muzzle );

	AngleVectors( cent->currentState.apos.trBase, forward, NULL, NULL );
	anim = cent->currentState.legsAnim & ~ANIM_TOGGLEBIT;
	if ( anim == LEGS_WALKCR || anim == LEGS_IDLECR ) {
		muzzle[2] += CROUCH_VIEWHEIGHT;
	} else {
		muzzle[2] += DEFAULT_VIEWHEIGHT;
	}

	VectorMA( muzzle, 14, forward, muzzle );

	return qtrue;

}

/*
======================
CG_Bullet

Renders bullet effects.
======================
*/
void CG_Bullet( vec3_t end, int sourceEntityNum, vec3_t normal, qboolean flesh, int fleshEntityNum ) {
	trace_t trace;
	int sourceContentType, destContentType;
	vec3_t		start;

	// if the shooter is currently valid, calc a source point and possibly
	// do trail effects
	if ( sourceEntityNum >= 0 && cg_tracerChance.value > 0 ) {
		if ( CG_CalcMuzzlePoint( sourceEntityNum, start ) ) {
			sourceContentType = trap_CM_PointContents( start, 0 );
			destContentType = trap_CM_PointContents( end, 0 );

			// do a complete bubble trail if necessary
			if ( ( sourceContentType == destContentType ) && ( sourceContentType & CONTENTS_WATER ) ) {
				CG_BubbleTrail( start, end, 32 );
			}
			// bubble trail from water into air
			else if ( ( sourceContentType & CONTENTS_WATER ) ) {
				trap_CM_BoxTrace( &trace, end, start, NULL, NULL, 0, CONTENTS_WATER );
				CG_BubbleTrail( start, trace.endpos, 32 );
			}
			// bubble trail from air into water
			else if ( ( destContentType & CONTENTS_WATER ) ) {
				trap_CM_BoxTrace( &trace, start, end, NULL, NULL, 0, CONTENTS_WATER );
				CG_BubbleTrail( trace.endpos, end, 32 );
			}

			// draw a tracer
			if ( random() < cg_tracerChance.value ) {
				CG_Tracer( start, end );
			}
		}
	}

	// impact splash and mark
	if ( flesh ) {
		CG_Bleed( end, fleshEntityNum );
	} else {
		CG_MissileHitWall( WP_MACHINEGUN, 0, end, normal, IMPACTSOUND_DEFAULT );
	}

}
