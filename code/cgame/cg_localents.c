// Copyright (C) 1999-2000 Id Software, Inc.
//

// cg_localents.c -- every frame, generate renderer commands for locally
// processed entities, like smoke puffs, gibs, shells, etc.

#include "cg_local.h"

#define	MAX_LOCAL_ENTITIES	512
localEntity_t	cg_localEntities[MAX_LOCAL_ENTITIES];
localEntity_t	cg_activeLocalEntities;		// double linked list
localEntity_t	*cg_freeLocalEntities;		// single linked list

/*
===================
CG_InitLocalEntities

This is called at startup and for tournement restarts
===================
*/
void	CG_InitLocalEntities( void ) {
	int		i;

	memset( cg_localEntities, 0, sizeof( cg_localEntities ) );
	cg_activeLocalEntities.next = &cg_activeLocalEntities;
	cg_activeLocalEntities.prev = &cg_activeLocalEntities;
	cg_freeLocalEntities = cg_localEntities;
	for ( i = 0 ; i < MAX_LOCAL_ENTITIES - 1 ; i++ ) {
		cg_localEntities[i].next = &cg_localEntities[i+1];
	}
}


/*
==================
CG_FreeLocalEntity
==================
*/
void CG_FreeLocalEntity( localEntity_t *le ) {
	if ( !le->prev ) {
		CG_Error( "CG_FreeLocalEntity: not active" );
	}

	// remove from the doubly linked active list
	le->prev->next = le->next;
	le->next->prev = le->prev;

	// the free list is only singly linked
	le->next = cg_freeLocalEntities;
	cg_freeLocalEntities = le;
}

/*
===================
CG_AllocLocalEntity

Will allways succeed, even if it requires freeing an old active entity
===================
*/
localEntity_t	*CG_AllocLocalEntity( void ) {
	localEntity_t	*le;

	if ( !cg_freeLocalEntities ) {
		// no free entities, so free the one at the end of the chain
		// remove the oldest active entity
		CG_FreeLocalEntity( cg_activeLocalEntities.prev );
	}

	le = cg_freeLocalEntities;
	cg_freeLocalEntities = cg_freeLocalEntities->next;

	memset( le, 0, sizeof( *le ) );

	// link into the active list
	le->next = cg_activeLocalEntities.next;
	le->prev = &cg_activeLocalEntities;
	cg_activeLocalEntities.next->prev = le;
	cg_activeLocalEntities.next = le;
	return le;
}


/*
====================================================================================

FRAGMENT PROCESSING

A fragment localentity interacts with the environment in some way (hitting walls),
or generates more localentities along a trail.

====================================================================================
*/

/*
================
CG_BloodTrail

Leave expanding blood puffs behind gibs
================
*/
void CG_BloodTrail( localEntity_t *le ) {
	int		t;
	int		t2;
	int		step;
	vec3_t	newOrigin;
	localEntity_t	*blood;

	step = 150;
	t = step * ( (cg.time - cg.frametime + step ) / step );
	t2 = step * ( cg.time / step );

	for ( ; t <= t2; t += step ) {
		BG_EvaluateTrajectory( &le->pos, t, newOrigin );

		blood = CG_SmokePuff( newOrigin, vec3_origin,
					  20,		// radius
					  1, 1, 1, 1,	// color
					  // JUHOX: decreased trail time for monster blood trail shader
					  le->leMarkType == LEMT_BLOOD? 2000 : 1000,
					  t,		// startTime
					  0,		// fadeInTime
					  0,		// flags

                      // JUHOX: use monster blood trail shader for monster gibs
					  le->leMarkType == LEMT_BLOOD?
							cgs.media.bloodTrailShader :
							(rand()&1? cgs.media.monsterBloodTrail1Shader : cgs.media.monsterBloodTrail2Shader)
					);

		// use the optimized version
		blood->leType = LE_FALL_SCALE_FADE;
		// drop a total of 40 units over its lifetime
		blood->pos.trDelta[2] = 40;
	}
}


/*
================
CG_FragmentBounceMark
================
*/
void CG_FragmentBounceMark( localEntity_t *le, trace_t *trace ) {
	int			radius;

	if ( le->leMarkType == LEMT_BLOOD ) {

		radius = 16 + (rand()&31);
		CG_ImpactMark( cgs.media.bloodMarkShader, trace->endpos, trace->plane.normal, random()*360,
			1,1,1,1, qtrue, radius, qfalse );
	} else if ( le->leMarkType == LEMT_BURN ) {

		radius = 8 + (rand()&15);
		CG_ImpactMark( cgs.media.burnMarkShader, trace->endpos, trace->plane.normal, random()*360,
			1,1,1,1, qtrue, radius, qfalse );
	}
	// JUHOX: add monster blood mark
	else if (le->leMarkType == LEMT_MONSTER_BLOOD) {
		radius = 16 + (rand()&31);
		CG_ImpactMark(cgs.media.monsterBloodMarkShader, trace->endpos, trace->plane.normal, random()*360,
			1,1,1,1, qtrue, radius, qfalse);
	}


	// don't allow a fragment to make multiple marks, or they
	// pile up while settling
	le->leMarkType = LEMT_NONE;
}

/*
================
CG_FragmentBounceSound
================
*/
void CG_FragmentBounceSound( localEntity_t *le, trace_t *trace ) {
	if ( le->leBounceSoundType == LEBS_BLOOD ) {
		// half the gibs will make splat sounds
		if ( rand() & 1 ) {
			int r = rand()&3;
			sfxHandle_t	s;

			if ( r == 0 ) {
				s = cgs.media.gibBounce1Sound;
			} else if ( r == 1 ) {
				s = cgs.media.gibBounce2Sound;
			} else {
				s = cgs.media.gibBounce3Sound;
			}
			trap_S_StartSound( trace->endpos, ENTITYNUM_WORLD, CHAN_AUTO, s );
		}
	} else if ( le->leBounceSoundType == LEBS_BRASS ) {

	}

	// don't allow a fragment to make multiple bounce sounds,
	// or it gets too noisy as they settle
	le->leBounceSoundType = LEBS_NONE;
}


/*
================
CG_ReflectVelocity
================
*/
void CG_ReflectVelocity( localEntity_t *le, trace_t *trace ) {
	vec3_t	velocity;
	float	dot;
	int		hitTime;

	// reflect the velocity on the trace plane
	hitTime = cg.time - cg.frametime + cg.frametime * trace->fraction;
	BG_EvaluateTrajectoryDelta( &le->pos, hitTime, velocity );
	dot = DotProduct( velocity, trace->plane.normal );
	VectorMA( velocity, -2*dot, trace->plane.normal, le->pos.trDelta );

	VectorScale( le->pos.trDelta, le->bounceFactor, le->pos.trDelta );

	VectorCopy( trace->endpos, le->pos.trBase );
	le->pos.trTime = cg.time;


	// check for stop, making sure that even on low FPS systems it doesn't bobble
	if ( trace->allsolid ||
		( trace->plane.normal[2] > 0 &&
		( le->pos.trDelta[2] < 40 || le->pos.trDelta[2] < -cg.frametime * le->pos.trDelta[2] ) ) ) {
		le->pos.trType = TR_STATIONARY;
	} else {

	}
}

/*
================
CG_AddFragment
================
*/
void CG_AddFragment( localEntity_t *le ) {
	vec3_t	newOrigin;
	trace_t	trace;

	if ( le->pos.trType == TR_STATIONARY ) {
		// sink into the ground if near the removal time
		int		t;
		float	oldZ;

		t = le->endTime - cg.time;
		if ( t < SINK_TIME ) {
			// we must use an explicit lighting origin, otherwise the
			// lighting would be lost as soon as the origin went
			// into the ground
			// JUHOX: correct lighting for EFH
			if (le->lightingBase) {
				VectorSubtract(
					le->refEntity.origin,
					le->lightingBase->lerpOrigin,
					le->refEntity.lightingOrigin
				);
			}
			else {
				VectorCopy( le->refEntity.origin, le->refEntity.lightingOrigin );
			}

			le->refEntity.renderfx |= RF_LIGHTING_ORIGIN;
			oldZ = le->refEntity.origin[2];
			le->refEntity.origin[2] -= 16 * ( 1.0 - (float)t / SINK_TIME );
			trap_R_AddRefEntityToScene( &le->refEntity );
			le->refEntity.origin[2] = oldZ;
		} else {
			// JUHOX: correct lighting for EFH
			if (le->lightingBase) {
				le->refEntity.renderfx |= RF_LIGHTING_ORIGIN;
				VectorSubtract(
					le->refEntity.origin,
					le->lightingBase->lerpOrigin,
					le->refEntity.lightingOrigin
				);
			}
			trap_R_AddRefEntityToScene( &le->refEntity );
		}

		return;
	}

	// calculate new position
	BG_EvaluateTrajectory( &le->pos, cg.time, newOrigin );

	// trace a line from previous position to new position
	CG_Trace( &trace, le->refEntity.origin, NULL, NULL, newOrigin, -1, CONTENTS_SOLID );
	// JUHOX: correct lighting for EFH
	if (cgs.gametype == GT_EFH && le->refEntity.hModel) {
		if (le->lightingBase) {
			// check if it's still valid

			vec3_t absmin, absmax;

			if (!le->lightingBase->currentValid) goto GetNewLightingBase;

			VectorAdd(le->lightingBase->lerpOrigin, le->baseMins, absmin);
			VectorAdd(le->lightingBase->lerpOrigin, le->baseMaxs, absmax);
			if (
				trace.endpos[0] < absmin[0] ||
				trace.endpos[0] > absmax[0] ||
				trace.endpos[1] < absmin[1] ||
				trace.endpos[1] > absmax[1] ||
				trace.endpos[2] < absmin[2] ||
				trace.endpos[2] > absmax[2]
			) {
				le->lightingBase = NULL;
				goto GetNewLightingBase;
			}

			CorrectLighting:

			VectorSubtract(trace.endpos, le->lightingBase->lerpOrigin, le->refEntity.lightingOrigin);
			le->refEntity.renderfx |= RF_LIGHTING_ORIGIN;
		}
		else {
			GetNewLightingBase:

			{
				int i;

				for (i = 0; i < cg.snap->numEntities; i++) {
					entityState_t* es;
					vec3_t mins, maxs;
					vec3_t absmin, absmax;

					es = &cg.snap->entities[i];
					if (es->eType != ET_MOVER) continue;
					if (es->solid != SOLID_BMODEL) continue;

					trap_R_ModelBounds(cgs.inlineDrawModel[es->modelindex], mins, maxs);
					VectorAdd(cg_entities[es->number].lerpOrigin, mins, absmin);
					VectorAdd(cg_entities[es->number].lerpOrigin, maxs, absmax);
					if (
						trace.endpos[0] >= absmin[0] &&
						trace.endpos[0] <= absmax[0] &&
						trace.endpos[1] >= absmin[1] &&
						trace.endpos[1] <= absmax[1] &&
						trace.endpos[2] >= absmin[2] &&
						trace.endpos[2] <= absmax[2]
					) {
						VectorCopy(mins, le->baseMins);
						VectorCopy(maxs, le->baseMaxs);
						le->lightingBase = &cg_entities[es->number];
						goto CorrectLighting;
					}
				}
			}
		}
	}

	if ( trace.fraction == 1.0 ) {
		// still in free fall
		VectorCopy( newOrigin, le->refEntity.origin );

		if ( le->leFlags & LEF_TUMBLE ) {
			vec3_t angles;

			BG_EvaluateTrajectory( &le->angles, cg.time, angles );
			AnglesToAxis( angles, le->refEntity.axis );
		}

		trap_R_AddRefEntityToScene( &le->refEntity );

		// add a blood trail
		if ( le->leBounceSoundType == LEBS_BLOOD ) {
			CG_BloodTrail( le );
		}

		return;
	}

	// if it is in a nodrop zone, remove it
	// this keeps gibs from waiting at the bottom of pits of death
	// and floating levels
	// JUHOX: also check for no-impact surfaces

	if (
		(trace.surfaceFlags & SURF_NOIMPACT) ||
		(trap_CM_PointContents( trace.endpos, 0 ) & CONTENTS_NODROP)
	) {
		CG_FreeLocalEntity( le );
		return;
	}

	// leave a mark
	CG_FragmentBounceMark( le, &trace );

	// do a bouncy sound
	CG_FragmentBounceSound( le, &trace );

	// reflect the velocity on the trace plane
	CG_ReflectVelocity( le, &trace );

	trap_R_AddRefEntityToScene( &le->refEntity );
}

/*
=====================================================================

TRIVIAL LOCAL ENTITIES

These only do simple scaling or modulation before passing to the renderer
=====================================================================
*/

/*
====================
CG_AddFadeRGB
====================
*/
void CG_AddFadeRGB( localEntity_t *le ) {
	refEntity_t *re;
	float c;

	re = &le->refEntity;

	c = ( le->endTime - cg.time ) * le->lifeRate;
	c *= 0xff;

	re->shaderRGBA[0] = le->color[0] * c;
	re->shaderRGBA[1] = le->color[1] * c;
	re->shaderRGBA[2] = le->color[2] * c;
	re->shaderRGBA[3] = le->color[3] * c;

	trap_R_AddRefEntityToScene( re );
}

/*
==================
CG_AddMoveScaleFade
==================
*/
static void CG_AddMoveScaleFade( localEntity_t *le ) {
	refEntity_t	*re;
	float		c;
	vec3_t		delta;
	float		len;

	re = &le->refEntity;

	if ( le->fadeInTime > le->startTime && cg.time < le->fadeInTime ) {
		// fade / grow time
		c = 1.0 - (float) ( le->fadeInTime - cg.time ) / ( le->fadeInTime - le->startTime );
	}
	else {
		// fade / grow time
		c = ( le->endTime - cg.time ) * le->lifeRate;
	}

	re->shaderRGBA[3] = 0xff * c * le->color[3];

	if ( !( le->leFlags & LEF_PUFF_DONT_SCALE ) ) {
		re->radius = le->radius * ( 1.0 - c ) + 8;
	}

	BG_EvaluateTrajectory( &le->pos, cg.time, re->origin );

	// if the view would be "inside" the sprite, kill the sprite
	// so it doesn't add too much overdraw
	VectorSubtract( re->origin, cg.refdef.vieworg, delta );
	len = VectorLength( delta );
	if ( len < le->radius ) {
		CG_FreeLocalEntity( le );
		return;
	}

	trap_R_AddRefEntityToScene( re );
}


/*
===================
CG_AddScaleFade

For rocket smokes that hang in place, fade out, and are
removed if the view passes through them.
There are often many of these, so it needs to be simple.
===================
*/
static void CG_AddScaleFade( localEntity_t *le ) {
	refEntity_t	*re;
	float		c;
	vec3_t		delta;
	float		len;

	re = &le->refEntity;

	// fade / grow time
	c = ( le->endTime - cg.time ) * le->lifeRate;

	re->shaderRGBA[3] = 0xff * c * le->color[3];
	re->radius = le->radius * ( 1.0 - c ) + 8;

	// if the view would be "inside" the sprite, kill the sprite
	// so it doesn't add too much overdraw
	VectorSubtract( re->origin, cg.refdef.vieworg, delta );
	len = VectorLength( delta );
	if ( len < le->radius ) {
		CG_FreeLocalEntity( le );
		return;
	}

	trap_R_AddRefEntityToScene( re );
}


/*
=================
CG_AddFallScaleFade

This is just an optimized CG_AddMoveScaleFade
For blood mists that drift down, fade out, and are
removed if the view passes through them.
There are often 100+ of these, so it needs to be simple.
=================
*/
static void CG_AddFallScaleFade( localEntity_t *le ) {
	refEntity_t	*re;
	float		c;
	vec3_t		delta;
	float		len;

	re = &le->refEntity;

	// fade time
	c = ( le->endTime - cg.time ) * le->lifeRate;

	re->shaderRGBA[3] = 0xff * c * le->color[3];

	re->origin[2] = le->pos.trBase[2] - ( 1.0 - c ) * le->pos.trDelta[2];

	re->radius = le->radius * ( 1.0 - c ) + 16;

	// if the view would be "inside" the sprite, kill the sprite
	// so it doesn't add too much overdraw
	VectorSubtract( re->origin, cg.refdef.vieworg, delta );
	len = VectorLength( delta );
	if ( len < le->radius ) {
		CG_FreeLocalEntity( le );
		return;
	}

	trap_R_AddRefEntityToScene( re );
}



/*
================
CG_AddExplosion
================
*/
static void CG_AddExplosion( localEntity_t *ex ) {
	refEntity_t	*ent;

	ent = &ex->refEntity;

	// add the entity
	trap_R_AddRefEntityToScene(ent);

	// add the dlight
	if ( ex->light ) {
		float		light;

		light = (float)( cg.time - ex->startTime ) / ( ex->endTime - ex->startTime );
		if ( light < 0.5 ) {
			light = 1.0;
		} else {
			light = 1.0 - ( light - 0.5 ) * 2;
		}
		light = ex->light * light;
		trap_R_AddLightToScene(ent->origin, light, ex->lightColor[0], ex->lightColor[1], ex->lightColor[2] );
	}
}

/*
================
CG_AddSpriteExplosion
================
*/
static void CG_AddSpriteExplosion( localEntity_t *le ) {
	refEntity_t	re;
	float c;

	re = le->refEntity;

	c = ( le->endTime - cg.time ) / ( float ) ( le->endTime - le->startTime );
	if ( c > 1 ) {
		c = 1.0;	// can happen during connection problems
	}

	re.shaderRGBA[0] = 0xff;
	re.shaderRGBA[1] = 0xff;
	re.shaderRGBA[2] = 0xff;
	re.shaderRGBA[3] = 0xff * c * 0.33;

	re.reType = RT_SPRITE;
	re.radius = 42 * ( 1.0 - c ) + 30;

	trap_R_AddRefEntityToScene( &re );

	// add the dlight
	if ( le->light ) {
		float		light;

		light = (float)( cg.time - le->startTime ) / ( le->endTime - le->startTime );
		if ( light < 0.5 ) {
			light = 1.0;
		} else {
			light = 1.0 - ( light - 0.5 ) * 2;
		}
		light = le->light * light;
		trap_R_AddLightToScene(re.origin, light, le->lightColor[0], le->lightColor[1], le->lightColor[2] );
	}
}


/*
===================
CG_AddScorePlum
===================
*/
#define NUMBER_SIZE		8

void CG_AddScorePlum( localEntity_t *le ) {
	refEntity_t	*re;
	vec3_t		origin, delta, dir, vec, up = {0, 0, 1};
	float		c, len;
	int			i, score, digits[10], numdigits, negative;

	re = &le->refEntity;

	c = ( le->endTime - cg.time ) * le->lifeRate;

	score = le->radius;
	if (score < 0) {
		re->shaderRGBA[0] = 0xff;
		re->shaderRGBA[1] = 0x11;
		re->shaderRGBA[2] = 0x11;
	}
	else {
		re->shaderRGBA[0] = 0xff;
		re->shaderRGBA[1] = 0xff;
		re->shaderRGBA[2] = 0xff;
	}
	if (c < 0.25)
		re->shaderRGBA[3] = 0xff * 4 * c;
	else
		re->shaderRGBA[3] = 0xff;

	re->radius = NUMBER_SIZE / 2;

	VectorCopy(le->pos.trBase, origin);
	origin[2] += 110 - c * 100;

	VectorSubtract(cg.refdef.vieworg, origin, dir);
	CrossProduct(dir, up, vec);
	VectorNormalize(vec);

	VectorMA(origin, -10 + 20 * sin(c * 2 * M_PI), vec, origin);

	// if the view would be "inside" the sprite, kill the sprite
	// so it doesn't add too much overdraw
	VectorSubtract( origin, cg.refdef.vieworg, delta );
	len = VectorLength( delta );
	if ( len < 20 ) {
		CG_FreeLocalEntity( le );
		return;
	}

	negative = qfalse;
	if (score < 0) {
		negative = qtrue;
		score = -score;
	}

	for (numdigits = 0; !(numdigits && !score); numdigits++) {
		digits[numdigits] = score % 10;
		score = score / 10;
	}

	if (negative) {
		digits[numdigits] = 10;
		numdigits++;
	}

	for (i = 0; i < numdigits; i++) {
		VectorMA(origin, (float) (((float) numdigits / 2) - i) * NUMBER_SIZE, vec, re->origin);
		re->customShader = cgs.media.numberShaders[digits[numdigits-1-i]];
		trap_R_AddRefEntityToScene( re );
	}
}

/*
===================
JUHOX: CG_AddBFGExpl
===================
*/
static void CG_AddBFGExpl(localEntity_t* le) {
	float c;

	c = (le->endTime - cg.time) * le->lifeRate;
	if (c <= 0) return;

	le->refEntity.radius = le->radius * (2.0 - c);
	le->refEntity.shaderRGBA[3] = le->color[3] * c * c;

	CG_AddFragment(le);
}

/*
===================
JUHOX: CG_AddTrailParticle
===================
*/
static void CG_AddTrailParticle(localEntity_t* le) {
	refEntity_t* re;
	float c;
	float t;

	re = &le->refEntity;

	c = (le->endTime - cg.time) * le->lifeRate;

	re->shaderRGBA[3] = 0xff * c * le->color[3];

	t = (cg.time - le->startTime) * le->lifeRate;
	re->radius = le->radius * (1.0 + Square(t));

	BG_EvaluateTrajectory(&le->pos, cg.time, re->origin);

	trap_R_AddRefEntityToScene(re);
}

/*
===================
JUHOX: CG_AddFireballTrailParticle
===================
*/
static void CG_AddFireballTrailParticle(localEntity_t* le) {
	refEntity_t* re;
	float c;

	re = &le->refEntity;

	c = (le->endTime - cg.time) * le->lifeRate;

	re->shaderRGBA[0] = 0xff * c * le->color[0];
	re->shaderRGBA[1] = 0xff * c * le->color[1];
	re->shaderRGBA[2] = 0xff * c * le->color[2];
	re->shaderRGBA[3] = 0xff * Square(c) * le->color[3];

	BG_EvaluateTrajectory(&le->pos, cg.time, re->origin);

	trap_R_AddRefEntityToScene(re);
}

/*
===================
JUHOX: CG_AddMoveScaleRGBFade
===================
*/
static void CG_AddMoveScaleRGBFade(localEntity_t* le) {
	refEntity_t	*re;
	float		c;

	re = &le->refEntity;

	// fade / grow time
	c = (le->endTime - cg.time) * le->lifeRate;

	re->shaderRGBA[3] = 0xff * c * le->color[3];
	re->shaderRGBA[0] = re->shaderRGBA[3];
	re->shaderRGBA[1] = re->shaderRGBA[3];
	re->shaderRGBA[2] = re->shaderRGBA[3];

	re->radius = le->radius * (1.0 - c) + 8;

	BG_EvaluateTrajectory(&le->pos, cg.time, re->origin);

	trap_R_AddRefEntityToScene(re);
}




//==============================================================================

/*
===================
CG_AddLocalEntities

===================
*/
void CG_AddLocalEntities( void ) {
	localEntity_t	*le, *next;

	// walk the list backwards, so any new local entities generated
	// (trails, marks, etc) will be present this frame
	le = cg_activeLocalEntities.prev;
	for ( ; le != &cg_activeLocalEntities ; le = next ) {
		// grab next now, so if the local entity is freed we
		// still have it
		next = le->prev;

		if ( cg.time >= le->endTime ) {
			CG_FreeLocalEntity( le );
			continue;
		}
		switch ( le->leType ) {
		default:
			CG_Error( "Bad leType: %i", le->leType );
			break;

		case LE_MARK:
			break;

		case LE_SPRITE_EXPLOSION:
			CG_AddSpriteExplosion( le );
			break;

		case LE_EXPLOSION:
			CG_AddExplosion( le );
			break;

		case LE_FRAGMENT:			// gibs and brass
			CG_AddFragment( le );
			break;

		case LE_MOVE_SCALE_FADE:		// water bubbles
			CG_AddMoveScaleFade( le );
			break;

		case LE_FADE_RGB:				// teleporters, railtrails
			CG_AddFadeRGB( le );
			break;

		case LE_FALL_SCALE_FADE: // gib blood trails
			CG_AddFallScaleFade( le );
			break;

		case LE_SCALE_FADE:		// rocket trails
			CG_AddScaleFade( le );
			break;

		case LE_SCOREPLUM:
			CG_AddScorePlum( le );
			break;
        // JUHOX: handle new BFG explosion local entity
		case LE_BFGEXPL:
			CG_AddBFGExpl(le);
			break;
        // JUHOX: handle trail particle
		case LE_TRAIL_PARTICLE:
			CG_AddTrailParticle(le);
			break;
        // JUHOX: handle fireball trail
		case LE_FIREBALL_TRAIL_PARTICLE:
			CG_AddFireballTrailParticle(le);
			break;

		case LE_MOVE_SCALE_RGBFADE:
			CG_AddMoveScaleRGBFade(le);
			break;


		}
	}
}

/*
===================
JUHOX: CG_AdjustLocalEntities
===================
*/
void CG_AdjustLocalEntities(const vec3_t delta) {
	localEntity_t* le;

	for (le = cg_activeLocalEntities.next; le != &cg_activeLocalEntities; le = le->next) {
		VectorAdd(le->pos.trBase, delta, le->pos.trBase);
		VectorAdd(le->refEntity.origin, delta, le->refEntity.origin);
		VectorAdd(le->refEntity.oldorigin, delta, le->refEntity.oldorigin);
		//VectorAdd(le->refEntity.lightingOrigin, delta, le->refEntity.lightingOrigin);
	}
}


