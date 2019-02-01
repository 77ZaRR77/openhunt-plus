// Copyright (C) 1999-2000 Id Software, Inc.
//
#include "g_local.h"

// g_client.c -- client functions that don't happen every frame

static vec3_t	playerMins = {-15, -15, -24};
static vec3_t	playerMaxs = {15, 15, 32};

/*QUAKED info_player_deathmatch (1 0 1) (-16 -16 -24) (16 16 32) initial
potential spawning position for deathmatch games.
The first time a player enters the game, they will be at an 'initial' spot.
Targets will be fired when someone spawns in on them.
"nobots" will prevent bots from using this spot.
"nohumans" will prevent non-bots from using this spot.
*/
void SP_info_player_deathmatch( gentity_t *ent ) {
	int		i;

	G_SpawnInt( "nobots", "0", &i);
	if ( i ) {
		ent->flags |= FL_NO_BOTS;
	}
	G_SpawnInt( "nohumans", "0", &i );
	if ( i ) {
		ent->flags |= FL_NO_HUMANS;
	}
	// JUHOX: new name for initial spawn points
	if (ent->spawnflags & 1) {
		ent->classname = "info_player_initial";
	}

	// JUHOX: set entity class
	ent->entClass = GEC_info_player_deathmatch;
}

/*QUAKED info_player_start (1 0 0) (-16 -16 -24) (16 16 32)
equivelant to info_player_deathmatch
*/
void SP_info_player_start(gentity_t *ent) {
	ent->classname = "info_player_deathmatch";
	SP_info_player_deathmatch( ent );
}

/*QUAKED info_player_intermission (1 0 1) (-16 -16 -24) (16 16 32)
The intermission will be viewed from this point.  Target an info_notnull for the view direction.
*/
void SP_info_player_intermission( gentity_t *ent ) {
	// JUHOX: set entity class
	ent->entClass = GEC_info_player_intermission;
}



/*
=======================================================================

  SelectSpawnPoint

=======================================================================
*/

/*
================
SpotWouldTelefrag

================
*/
qboolean SpotWouldTelefrag( gentity_t *spot ) {
	int			i, num;
	int			touch[MAX_GENTITIES];
	gentity_t	*hit;
	vec3_t		mins, maxs;

	VectorAdd( spot->s.origin, playerMins, mins );
	VectorAdd( spot->s.origin, playerMaxs, maxs );
	num = trap_EntitiesInBox( mins, maxs, touch, MAX_GENTITIES );

	for (i=0 ; i<num ; i++) {
		hit = &g_entities[touch[i]];
		if ( hit->client) {
			if (hit->client->ps.stats[STAT_HEALTH] <= 0) continue;	// JUHOX
			if (hit->client->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR) continue;	// JUHOX
			return qtrue;
		}
	}

	return qfalse;
}

/*
================
JUHOX: PositionWouldTelefrag

originally from 'SpotWouldTelefrag()'
================
*/
qboolean PositionWouldTelefrag(const vec3_t position, const vec3_t pmins, const vec3_t pmaxs) {
	int			i, num;
	int			touch[MAX_GENTITIES];
	gentity_t	*hit;
	vec3_t		mins, maxs;

	VectorAdd(position, pmins, mins);
	VectorAdd(position, pmaxs, maxs );
	num = trap_EntitiesInBox(mins, maxs, touch, MAX_GENTITIES);

	for (i = 0; i < num; i++) {
		playerState_t* ps;

		hit = &g_entities[touch[i]];
		ps = G_GetEntityPlayerState(hit);
		if (!ps) continue;
		if (ps->stats[STAT_HEALTH] <= 0) continue;
		if (ps->persistant[PERS_TEAM] == TEAM_SPECTATOR) continue;
		return qtrue;
	}
	return qfalse;
}


/*
================
JUHOX: SelectSpawnPointFromList
================
*/
static gentity_t* SelectSpawnPointFromList(
	const char* const* names, const vec3_t avoidPoint, localseed_t* seed, qboolean acceptAny, qboolean emergency
) {
	qboolean useAvoidPoint;
	int i;
	float limit;
	int numSpots1;
	int numSpots2;
	gentity_t* selected1;
	gentity_t* selected2;
	localseed_t seed1;
	localseed_t seed2;

	useAvoidPoint = !acceptAny && avoidPoint && VectorLengthSquared(avoidPoint) > 0.0001;

	// set the distance limit
	limit = 0;
	if (useAvoidPoint) {
		for (i = MAX_CLIENTS; i < level.num_entities; i++) {
			gentity_t* ent;
			const char* const* name;
			float distance;

			ent = &g_entities[i];
			if (!ent->inuse) continue;

			name = names;
			while (*name) {
				if (!Q_stricmp(*name, ent->classname)) break;
				name++;
			}
			if (!*name) continue;

			distance = Distance(ent->s.origin, avoidPoint);
			if (distance > limit) limit = distance;
		}

		limit /= 2;
		if (limit < 400) limit = 400;
	}

	numSpots1 = 0;
	numSpots2 = 0;
	selected1 = NULL;
	selected2 = NULL;

	DeriveLocalSeed(seed, &seed1);
	DeriveLocalSeed(seed, &seed2);

	for (i = MAX_CLIENTS; i < level.num_entities; i++) {
		gentity_t* ent;
		const char* const* name;

		ent = &g_entities[i];
		if (!ent->inuse) continue;

		name = names;
		while (*name) {
			if (!Q_stricmp(*name, ent->classname)) break;
			name++;
		}
		if (!*name) continue;

		numSpots1++;
		if (LocallySeededRandom(&seed1) % numSpots1 == 0) selected1 = ent;

		if (useAvoidPoint && Distance(ent->s.origin, avoidPoint) < limit) {
			if (selected1 == ent) selected1 = NULL;
			continue;
		}

		if (!acceptAny && SpotWouldTelefrag(ent)) {
			if (selected1 == ent) selected1 = NULL;
			continue;
		}

		numSpots2++;
		if (LocallySeededRandom(&seed2) % numSpots2 == 0) selected2 = ent;
	}
	if (!selected1) selected1 = selected2;

	if ((!selected1 || acceptAny) && emergency) {
		if (!selected1) numSpots1 = 0;
		for (i = 0; i < level.numEmergencySpawnPoints; i++) {
			static vec3_t mins = { -15, -15, -24 };
			static vec3_t maxs = {  15,  15,  15 };
			static gentity_t spawnpoint;
			vec3_t start;
			vec3_t end;
			trace_t trace;
			gentity_t testpoint;

			VectorCopy(level.emergencySpawnPoints[i], start);
			start[2] += 9;
			VectorCopy(start, end);
			end[2] -= 8000;

			trap_Trace(&trace, start, mins, maxs, end, -1, MASK_PLAYERSOLID|CONTENTS_TRIGGER|CONTENTS_LAVA|CONTENTS_SLIME);
			if (
				trace.allsolid ||
				trace.startsolid ||
				trace.fraction >= 1 ||
				(trace.contents & (CONTENTS_TRIGGER|CONTENTS_LAVA|CONTENTS_SLIME))
			) continue;

			if (trap_PointContents(trace.endpos, -1) & (CONTENTS_TRIGGER|CONTENTS_LAVA|CONTENTS_SLIME)) continue;

			VectorCopy(trace.endpos, testpoint.s.origin);
			if (!acceptAny && SpotWouldTelefrag(&testpoint)) continue;

			numSpots1++;
			if (LocallySeededRandom(&seed1) % numSpots1 == 0) {
				VectorCopy(trace.endpos, spawnpoint.s.origin);
				spawnpoint.s.angles[YAW] = 360 * random();
				spawnpoint.s.angles[PITCH] = 0;
				spawnpoint.s.angles[ROLL] = 0;
				selected1 = &spawnpoint;
			}
		}
	}

	return selected1;
}

/*
================
JUHOX: SelectAppropriateSpawnPoint
================
*/
gentity_t* SelectAppropriateSpawnPoint(team_t team, const vec3_t avoidPoint, qboolean initialSpawn) {
	static const char* const anyList[] = {
		"info_player_deathmatch",
		"info_player_initial",
		"team_CTF_redplayer",
		"team_CTF_blueplayer",
		"team_CTF_redspawn",
		"team_CTF_bluespawn",
		NULL
	};
	static const char* const anyInitialList[] = {
		"info_player_initial",
		"team_CTF_redplayer",
		"team_CTF_blueplayer",
		NULL
	};
	static const char* const nonTeamList[] = {
		"info_player_deathmatch",
		"info_player_initial",
		NULL
	};
	static const char* const nonTeamInitialList[] = {
		"info_player_initial",
		NULL
	};
	static const char* const teamRedList[] = {
		"team_CTF_redplayer",
		"team_CTF_redspawn",
		NULL
	};
	static const char* const teamRedInitialList[] = {
		"team_CTF_redplayer",
		NULL
	};
	static const char* const teamBlueList[] = {
		"team_CTF_blueplayer",
		"team_CTF_bluespawn",
		NULL
	};
	static const char* const teamBlueInitialList[] = {
		"team_CTF_blueplayer",
		NULL
	};
	localseed_t seed1, seed2, seed3, seed4, seed5, seed6;
	gentity_t* spot;

	spot = NULL;

	if (g_gametype.integer == GT_EFH) {
		int i;
		vec3_t spaceMins;
		vec3_t spaceMaxs;
		long bestWayLength;
		int numSpots;

		G_EFH_SpaceExtent(spaceMins, spaceMaxs);
		InitLocalSeed(GST_playerSpawning, &seed1);
		numSpots = 0;
		bestWayLength = 0;

		for (i = MAX_CLIENTS; i < level.num_entities; i++) {
			gentity_t* ent;
			const char* const* name;
			long wayLength;

			ent = &g_entities[i];
			if (!ent->inuse) continue;

			name = anyList;
			while (*name) {
				if (!Q_stricmp(*name, ent->classname)) break;
				name++;
			}
			if (!*name) continue;

			if (
				ent->s.origin[0] <= spaceMins[0] ||
				ent->s.origin[0] >= spaceMaxs[0] ||
				ent->s.origin[1] <= spaceMins[1] ||
				ent->s.origin[1] >= spaceMaxs[1] ||
				ent->s.origin[2] <= spaceMins[2] ||
				ent->s.origin[2] >= spaceMaxs[2]
			) {
				continue;
			}
			if (G_FindSegment(ent->s.origin, NULL) < 0) continue;

			if (SpotWouldTelefrag(ent)) continue;

			wayLength = G_GetTotalWayLength(ent);

			if (spot) {
				if (level.intermissiontime) {
					if (wayLength < bestWayLength + 32) continue;
					if (wayLength < bestWayLength - 32) {
						numSpots = 0;
						bestWayLength = wayLength;
					}
				}
				else {
					if (wayLength > bestWayLength - 32) continue;
					if (wayLength > bestWayLength + 32) {
						numSpots = 0;
						bestWayLength = wayLength;
					}
				}
			}
			else {
				bestWayLength = wayLength;
			}

			numSpots++;
			if (LocallySeededRandom(&seed1) % numSpots) continue;

			spot = ent;
		}

		initialSpawn = qfalse;
		avoidPoint = NULL;
	}
	else

	if (g_gametype.integer >= GT_TEAM && g_gametype.integer <= GT_CTF) {
		// team games
		switch (team) {
		case TEAM_RED:
			InitLocalSeed(GST_redPlayerSpawning, &seed1);
			InitLocalSeed(GST_redPlayerSpawning, &seed2);
			InitLocalSeed(GST_redPlayerSpawning, &seed3);
			InitLocalSeed(GST_redPlayerSpawning, &seed4);
			InitLocalSeed(GST_redPlayerSpawning, &seed5);
			InitLocalSeed(GST_redPlayerSpawning, &seed6);

			if (initialSpawn) {
				spot = SelectSpawnPointFromList(teamRedInitialList, avoidPoint, &seed1, qfalse, qfalse);
			}
			if (!spot) {
				spot = SelectSpawnPointFromList(teamRedList, avoidPoint, &seed2, qfalse, qfalse);
				if (!spot && avoidPoint) {
					spot = SelectSpawnPointFromList(teamRedList, NULL, &seed3, qfalse, qfalse);
				}
			}
			break;
		case TEAM_BLUE:
			InitLocalSeed(GST_bluePlayerSpawning, &seed1);
			InitLocalSeed(GST_bluePlayerSpawning, &seed2);
			InitLocalSeed(GST_bluePlayerSpawning, &seed3);
			InitLocalSeed(GST_bluePlayerSpawning, &seed4);
			InitLocalSeed(GST_bluePlayerSpawning, &seed5);
			InitLocalSeed(GST_bluePlayerSpawning, &seed6);

			if (initialSpawn) {
				spot = SelectSpawnPointFromList(teamBlueInitialList, avoidPoint, &seed1, qfalse, qfalse);
			}
			if (!spot) {
				spot = SelectSpawnPointFromList(teamBlueList, avoidPoint, &seed2, qfalse, qfalse);
				if (!spot && avoidPoint) {
					spot = SelectSpawnPointFromList(teamBlueList, NULL, &seed3, qfalse, qfalse);
				}
			}
			break;
		default:
			goto NonTeamSpawn;
		}
	}
	else {
		// non-team games
		NonTeamSpawn:
		InitLocalSeed(GST_playerSpawning, &seed1);
		InitLocalSeed(GST_playerSpawning, &seed2);
		InitLocalSeed(GST_playerSpawning, &seed3);
		InitLocalSeed(GST_playerSpawning, &seed4);
		InitLocalSeed(GST_playerSpawning, &seed5);
		InitLocalSeed(GST_playerSpawning, &seed6);

		if (initialSpawn) {
			spot = SelectSpawnPointFromList(nonTeamInitialList, avoidPoint, &seed1, qfalse, qfalse);
		}
		if (!spot) {
			spot = SelectSpawnPointFromList(nonTeamList, avoidPoint, &seed2, qfalse, qfalse);
			if (!spot && avoidPoint) {
				spot = SelectSpawnPointFromList(nonTeamList, NULL, &seed3, qfalse, qfalse);
			}
		}
	}

	if (!spot && initialSpawn) {
		spot = SelectSpawnPointFromList(anyInitialList, avoidPoint, &seed4, qfalse, qfalse);
	}
	if (!spot) {
		spot = SelectSpawnPointFromList(anyList, avoidPoint, &seed5, qfalse, qfalse);
		if (!spot && avoidPoint) {
			spot = SelectSpawnPointFromList(anyList, NULL, &seed6, qfalse, qfalse);
		}
		if (!spot) {
			spot = SelectSpawnPointFromList(anyList, NULL, &seed6, qfalse, qtrue);
		}
		if (!spot) {
			spot = SelectSpawnPointFromList(anyList, NULL, &seed6, qtrue, qtrue);
		}
	}

	return spot;
}


/*
===========
SelectRandomFurthestSpawnPoint

Chooses a player start, deathmatch start, etc
============
*/
gentity_t *SelectRandomFurthestSpawnPoint ( vec3_t avoidPoint, vec3_t origin, vec3_t angles ) {

    // JUHOX: use new spawn logic
	gentity_t* spot;

	spot = SelectAppropriateSpawnPoint(TEAM_FREE, avoidPoint, qfalse);
	if (spot) {
		VectorCopy(spot->s.origin, origin);
		origin[2] += 9;
		VectorCopy(spot->s.angles, angles);
	}
	return spot;

}

/*
===========
SelectSpawnPoint

Chooses a player start, deathmatch start, etc
============
*/
gentity_t *SelectSpawnPoint ( vec3_t avoidPoint, vec3_t origin, vec3_t angles ) {
	return SelectRandomFurthestSpawnPoint( avoidPoint, origin, angles );
}

/*
===========
SelectInitialSpawnPoint

Try to find a spawn point marked 'initial', otherwise
use normal spawn selection.
============
*/
gentity_t *SelectInitialSpawnPoint( vec3_t origin, vec3_t angles ) {
    // JUHOX: use new spawn logic
	gentity_t* spot;

	spot = SelectAppropriateSpawnPoint(TEAM_FREE, NULL, qtrue);
	if (spot) {
		VectorCopy(spot->s.origin, origin);
		origin[2] += 9;
		VectorCopy(spot->s.angles, angles);
	}
	return spot;
}

/*
===========
SelectSpectatorSpawnPoint

============
*/
gentity_t *SelectSpectatorSpawnPoint( vec3_t origin, vec3_t angles ) {
	FindIntermissionPoint();

	VectorCopy( level.intermission_origin, origin );
	VectorCopy( level.intermission_angle, angles );

	return NULL;
}

/*
=======================================================================

BODYQUE

=======================================================================
*/

/*
===============
InitBodyQue
===============
*/
void InitBodyQue (void) {
	int		i;
	gentity_t	*ent;

	level.bodyQueIndex = 0;
	for (i=0; i<BODY_QUEUE_SIZE ; i++) {
		ent = G_Spawn();
		ent->classname = "bodyque";
		ent->neverFree = qtrue;
		level.bodyQue[i] = ent;
	}
}

/*
=============
BodySink

After sitting around for five seconds, fall into the ground and dissapear
=============
*/
void BodySink( gentity_t *ent ) {
    // JUHOX: new, predictable method of body sinking
	int sinktime;

	if (ent->s.pos.trType == TR_LINEAR_STOP) {
		trap_UnlinkEntity(ent);
		ent->physicsObject = qfalse;
		return;
	}

	sinktime = 3000;
	switch (ent->s.clientNum) {
	case CLIENTNUM_MONSTER_GUARD:
		sinktime *= MONSTER_GUARD_SCALE;
		break;
	case CLIENTNUM_MONSTER_TITAN:
		sinktime *= MONSTER_TITAN_SCALE;
		break;
	}

	ent->nextthink = level.time + sinktime;

	ent->s.pos.trType = TR_LINEAR_STOP;
	ent->s.pos.trTime = level.time;
	ent->s.pos.trDuration = sinktime;
	VectorSet(ent->s.pos.trDelta, 0, 0, -10);
	trap_LinkEntity(ent);
}

/*
=============
CopyToBodyQue

A player is respawning, so make an entity that looks
just like the existing corpse to leave behind.
=============
*/
void CopyToBodyQue( gentity_t *ent ) {
	gentity_t		*body;
	int			contents;

	// JUHOX: check the 'corpseProduced' flag
	if (ent->client) {
		if (ent->client->corpseProduced) return;
		ent->client->corpseProduced = qtrue;
	}

	trap_UnlinkEntity (ent);

	// if client is in a nodrop area, don't leave the body
	contents = trap_PointContents( ent->s.origin, -1 );
	if ( contents & CONTENTS_NODROP ) {
		return;
	}

	// grab a body que and cycle to the next one
	body = level.bodyQue[ level.bodyQueIndex ];
	level.bodyQueIndex = (level.bodyQueIndex + 1) % BODY_QUEUE_SIZE;

	trap_UnlinkEntity (body);

	// JUHOX: toggle teleport flag
	{
		int oldEFlags;

		oldEFlags = body->s.eFlags;
		body->s = ent->s;
		body->s.eFlags = oldEFlags & ~EF_TELEPORT_BIT;
		body->s.eFlags ^= EF_TELEPORT_BIT;
		body->s.eFlags |= EF_DEAD;
	}

	body->s.powerups = 0;	// clear powerups
	body->s.loopSound = 0;	// clear lava burning
	body->s.number = body - g_entities;
	body->timestamp = level.time;
	body->physicsObject = qtrue;
	body->physicsBounce = 0;		// don't bounce
	if ( body->s.groundEntityNum == ENTITYNUM_NONE ) {
		body->s.pos.trType = TR_GRAVITY;
		body->s.pos.trTime = level.time;
		VectorCopy( ent->client->ps.velocity, body->s.pos.trDelta );
	} else {
		body->s.pos.trType = TR_STATIONARY;
	}
	body->s.event = 0;

	// change the animation to the last-frame only, so the sequence
	// doesn't repeat anew for the body
	switch ( body->s.legsAnim & ~ANIM_TOGGLEBIT ) {
	case BOTH_DEATH1:
	case BOTH_DEAD1:
		body->s.torsoAnim = body->s.legsAnim = BOTH_DEAD1;
		break;
	case BOTH_DEATH2:
	case BOTH_DEAD2:
		body->s.torsoAnim = body->s.legsAnim = BOTH_DEAD2;
		break;
	case BOTH_DEATH3:
	case BOTH_DEAD3:
	default:
		body->s.torsoAnim = body->s.legsAnim = BOTH_DEAD3;
		break;
	}

	body->r.svFlags = ent->r.svFlags;
	VectorCopy (ent->r.mins, body->r.mins);
	VectorCopy (ent->r.maxs, body->r.maxs);
	VectorCopy (ent->r.absmin, body->r.absmin);
	VectorCopy (ent->r.absmax, body->r.absmax);

	body->clipmask = CONTENTS_SOLID | CONTENTS_PLAYERCLIP;
	body->r.contents = CONTENTS_CORPSE;
	body->r.ownerNum = ent->s.number;

	body->nextthink = level.time + 5000;
	body->think = BodySink;

	body->die = body_die;

	// don't take more damage if already gibbed
	if ( ent->health <= GIB_HEALTH ) {
		body->takedamage = qfalse;
	} else {
		body->takedamage = qtrue;
	}

	body->worldSegment = ent->worldSegment;	// JUHOX

	VectorCopy ( body->s.pos.trBase, body->r.currentOrigin );
	trap_LinkEntity (body);
}

//======================================================================


/*
================
JUHOX: ForceRespawn
================
*/
void ForceRespawn(gentity_t* ent) {
#if RESPAWN_DELAY
	if (!ent->inuse) return;
	if (!ent->client) return;
	if (ent->client->pers.connected != CON_CONNECTED) return;
	if (ent->client->sess.sessionTeam == TEAM_SPECTATOR) return;

	if (ent->client->ps.stats[STAT_HEALTH] <= 0) {
		if (ent->client->respawnDelay > 0) {
			ent->client->respawnDelay = -1;
			ent->client->respawnTime = level.time + 1700;
		}
	}

	else if (g_gametype.integer >= GT_STU) {
		return;
	}

	else if (ent->client->ps.stats[STAT_HEALTH] < ent->client->ps.stats[STAT_MAX_HEALTH] + 25) {
		ent->client->ps.stats[STAT_HEALTH] = ent->client->ps.stats[STAT_MAX_HEALTH] + 25;
		ent->health = ent->client->ps.stats[STAT_HEALTH];
	}
#endif
}

/*
==================
SetClientViewAngle

==================
*/
void SetClientViewAngle( gentity_t *ent, vec3_t angle ) {
	int			i;

	// set the delta angle
	for (i=0 ; i<3 ; i++) {
		int		cmdAngle;

		cmdAngle = ANGLE2SHORT(angle[i]);
		ent->client->ps.delta_angles[i] = cmdAngle - ent->client->pers.cmd.angles[i];
	}
	// JUHOX BUGFIX(?): view angles should be put into entityState_t.apos.trBase
	// entityState_t.angles is now used to store movementDir (see BG_PlayerStateToEntityState())
	VectorCopy(angle, ent->s.apos.trBase);
	VectorCopy(angle, ent->client->ps.viewangles);
}

/*
================
respawn
================
*/
void respawn( gentity_t *ent ) {
	gentity_t	*tent;

	ClientSpawn(ent);
	if (ent->client->ps.stats[STAT_HEALTH] <= 0) return;	// JUHOX: spawning failed
	if (level.meeting) return;	                            // JUHOX: no teleportation effect during meeting

	// add a teleportation effect
	tent = G_TempEntity( ent->client->ps.origin, EV_PLAYER_TELEPORT_IN );
	tent->s.clientNum = ent->s.clientNum;
}

/*
================
TeamCount

Returns number of players on a team
================
*/
team_t TeamCount( int ignoreClientNum, int team ) {
	int	i;
	int	count = 0;

	for ( i = 0 ; i < level.maxclients ; i++ ) {
		if ( i == ignoreClientNum ) {
			continue;
		}
		if ( level.clients[i].pers.connected == CON_DISCONNECTED ) {
			continue;
		}
		if ( level.clients[i].sess.sessionTeam == team ) {
			count++;
		}
	}

	return count;
}

/*
================
TeamLeader

Returns the client number of the team leader
================
*/
int TeamLeader( int team ) {
	int	i;

	for ( i = 0 ; i < level.maxclients ; i++ ) {
		if ( level.clients[i].pers.connected == CON_DISCONNECTED ) {
			continue;
		}
		if ( level.clients[i].sess.sessionTeam == team ) {
			if ( level.clients[i].sess.teamLeader )
				return i;
		}
	}

	return -1;
}


/*
================
PickTeam

================
*/
team_t PickTeam( int ignoreClientNum ) {
	int	counts[TEAM_NUM_TEAMS];

	// JUHOX: in STU always pick the red team
	if (g_gametype.integer >= GT_STU) return TEAM_RED;

	counts[TEAM_BLUE] = TeamCount( ignoreClientNum, TEAM_BLUE );
	counts[TEAM_RED] = TeamCount( ignoreClientNum, TEAM_RED );

	if ( counts[TEAM_BLUE] > counts[TEAM_RED] ) {
		return TEAM_RED;
	}
	if ( counts[TEAM_RED] > counts[TEAM_BLUE] ) {
		return TEAM_BLUE;
	}
	// equal team count, so join the team with the lowest score
	if ( level.teamScores[TEAM_BLUE] > level.teamScores[TEAM_RED] ) {
		return TEAM_RED;
	}
	return TEAM_BLUE;
}


/*
===========
ClientCheckName
============
*/
static void ClientCleanName( const char *in, char *out, int outSize ) {
	int		len, colorlessLen;
	char	ch;
	char	*p;
	int		spaces;

	//save room for trailing null byte
	outSize--;

	len = 0;
	colorlessLen = 0;
	p = out;
	*p = 0;
	spaces = 0;

	while( 1 ) {
		ch = *in++;
		if( !ch ) {
			break;
		}

		// don't allow leading spaces
		if( !*p && ch == ' ' ) {
			continue;
		}

		// check colors
		if( ch == Q_COLOR_ESCAPE ) {
			// solo trailing carat is not a color prefix
			if( !*in ) {
				break;
			}

			// don't allow black in a name, period
			if( ColorIndex(*in) == 0 ) {
				in++;
				continue;
			}

			// make sure room in dest for both chars
			if( len > outSize - 2 ) {
				break;
			}

			*out++ = ch;
			*out++ = *in++;
			len += 2;
			continue;
		}

		// don't allow too many consecutive spaces
		if( ch == ' ' ) {
			spaces++;
			if( spaces > 3 ) {
				continue;
			}
		}
		else {
			spaces = 0;
		}

		if( len > outSize - 1 ) {
			break;
		}

		*out++ = ch;
		colorlessLen++;
		len++;
	}
	*out = 0;

	// don't allow empty names
	if( *p == 0 || colorlessLen == 0 ) {
		Q_strncpyz( p, "UnnamedPlayer", outSize );
	}
}


/*
===========
ClientUserInfoChanged

Called from ClientConnect when the player first connects and
directly by the server system when the player updates a userinfo variable.

The game can override any of the settings and call trap_SetUserinfo
if desired.
============
*/
void ClientUserinfoChanged( int clientNum ) {
	gentity_t *ent;
	int		teamTask, teamLeader, team, health;
	char	*s;
	char	model[MAX_QPATH];
	char	headModel[MAX_QPATH];
	char	oldname[MAX_STRING_CHARS];
	gclient_t	*client;
	char	c1[MAX_INFO_STRING];
	char	c2[MAX_INFO_STRING];
	char	redTeam[MAX_INFO_STRING];
	char	blueTeam[MAX_INFO_STRING];
	char	userinfo[MAX_INFO_STRING];

	ent = g_entities + clientNum;
	client = ent->client;

	trap_GetUserinfo( clientNum, userinfo, sizeof( userinfo ) );

	// check for malformed or illegal info strings
	if ( !Info_Validate(userinfo) ) {
		strcpy (userinfo, "\\name\\badinfo");
	}

	// check for local client
	s = Info_ValueForKey( userinfo, "ip" );
	if ( !strcmp( s, "localhost" ) ) {
		client->pers.localClient = qtrue;
	}

	// check the item prediction
	s = Info_ValueForKey( userinfo, "cg_predictItems" );
	if ( !atoi( s ) ) {
		client->pers.predictItemPickup = qfalse;
	} else {
		client->pers.predictItemPickup = qtrue;
	}

	// set name
	Q_strncpyz ( oldname, client->pers.netname, sizeof( oldname ) );
	s = Info_ValueForKey (userinfo, "name");
	ClientCleanName( s, client->pers.netname, sizeof(client->pers.netname) );

	if ( client->sess.sessionTeam == TEAM_SPECTATOR ) {
		if ( client->sess.spectatorState == SPECTATOR_SCOREBOARD ) {
			Q_strncpyz( client->pers.netname, "scoreboard", sizeof(client->pers.netname) );
		}
	}

	if ( client->pers.connected == CON_CONNECTED ) {
		if ( strcmp( oldname, client->pers.netname ) ) {
			trap_SendServerCommand( -1, va("print \"%s" S_COLOR_WHITE " renamed to %s\n\"", oldname,
				client->pers.netname) );
		}
	}

	// set max health
	health = atoi( Info_ValueForKey( userinfo, "handicap" ) );
	client->pers.maxHealth = health;
	if ( client->pers.maxHealth < 1 || client->pers.maxHealth > 100 ) {
		client->pers.maxHealth = 100;
	}

	client->ps.stats[STAT_MAX_HEALTH] = g_baseHealth.value * (client->pers.maxHealth / 100.0);
	if (client->ps.stats[STAT_MAX_HEALTH] < 1) client->ps.stats[STAT_MAX_HEALTH] = 1;

	// set model
	if( g_gametype.integer >= GT_TEAM ) {
		Q_strncpyz( model, Info_ValueForKey (userinfo, "team_model"), sizeof( model ) );
		Q_strncpyz( headModel, Info_ValueForKey (userinfo, "team_headmodel"), sizeof( headModel ) );
	} else {
		Q_strncpyz( model, Info_ValueForKey (userinfo, "model"), sizeof( model ) );
		Q_strncpyz( headModel, Info_ValueForKey (userinfo, "headmodel"), sizeof( headModel ) );
	}

	// bots set their team a few frames later
	if (g_gametype.integer >= GT_TEAM && g_entities[clientNum].r.svFlags & SVF_BOT) {
		s = Info_ValueForKey( userinfo, "team" );
		if ( !Q_stricmp( s, "red" ) || !Q_stricmp( s, "r" ) ) {
			team = TEAM_RED;
		} else if ( !Q_stricmp( s, "blue" ) || !Q_stricmp( s, "b" ) ) {
			team = TEAM_BLUE;
		} else {
			// pick the team with the least number of players
			team = PickTeam( clientNum );
		}
	}
	else {
		team = client->sess.sessionTeam;
	}

	// teamInfo
	s = Info_ValueForKey( userinfo, "teamoverlay" );
	if ( ! *s || atoi( s ) != 0 ) {
		client->pers.teamInfo = qtrue;
	} else {
		client->pers.teamInfo = qfalse;
	}

	// team task (0 = none, 1 = offence, 2 = defence)
	teamTask = atoi(Info_ValueForKey(userinfo, "teamtask"));
	// team Leader (1 = leader, 0 is normal player)
	teamLeader = client->sess.teamLeader;

	// JUHOX: if a mission leader in safety mode looses his leadership, stop safety mode
	if (!teamLeader && client->tssSafetyMode) {
		client->tssSafetyMode = qfalse;
	}

	// JUHOX: get class cloaking activation state
	client->pers.glassCloakingEnabled = atoi(Info_ValueForKey(userinfo, "cg_glassCloaking"))? qtrue : qfalse;

	// JUHOX: check whether crouching cuts the grapple rope
	client->pers.crouchingCutsRope = atoi(Info_ValueForKey(userinfo, "crouchCutsRope"))? qtrue : qfalse;

	// colors
	strcpy(c1, Info_ValueForKey( userinfo, "color1" ));
	strcpy(c2, Info_ValueForKey( userinfo, "color2" ));

	strcpy(redTeam, Info_ValueForKey( userinfo, "g_redteam" ));
	strcpy(blueTeam, Info_ValueForKey( userinfo, "g_blueteam" ));

	// send over a subset of the userinfo keys so other clients can
	// print scoreboards, display models, and play custom sounds
	if ( ent->r.svFlags & SVF_BOT ) {
		s = va(
			"n\\%s\\t\\%i\\model\\%s\\hmodel\\%s\\c1\\%s\\c2\\%s"
			"\\hc\\%i\\w\\%i\\l\\%i"
			"\\skill\\%s\\tt\\%d\\tl\\%d"
			"\\gc\\%d",
			client->pers.netname, team, model, headModel, c1, c2,
			client->pers.maxHealth, client->sess.wins, client->sess.losses,
			Info_ValueForKey(userinfo, "skill"), teamTask, teamLeader,
			client->pers.glassCloakingEnabled
		);
	} else {
		s = va(
			"n\\%s\\t\\%i\\model\\%s\\hmodel\\%s\\g_redteam\\%s\\g_blueteam\\%s\\c1\\%s\\c2\\%s"
			"\\hc\\%i\\w\\%i\\l\\%i"
			"\\tt\\%d\\tl\\%d"
			"\\gc\\%d",
			client->pers.netname, client->sess.sessionTeam, model, headModel, redTeam, blueTeam, c1, c2,
			client->pers.maxHealth, client->sess.wins, client->sess.losses,
			teamTask, teamLeader,
			client->pers.glassCloakingEnabled
		);
	}

	trap_SetConfigstring( CS_PLAYERS+clientNum, s );

	// this is not the userinfo, more like the configstring actually
	G_LogPrintf( "ClientUserinfoChanged: %i %s\n", clientNum, s );
}


/*
===========
ClientConnect

Called when a player begins connecting to the server.
Called again for every map change or tournement restart.

The session information will be valid after exit.

Return NULL if the client should be allowed, otherwise return
a string with the reason for denial.

Otherwise, the client will be sent the current gamestate
and will eventually get to ClientBegin.

firstTime will be qtrue the very first time a client connects
to the server machine, but qfalse on map changes and tournement
restarts.
============
*/
char *ClientConnect( int clientNum, qboolean firstTime, qboolean isBot ) {
	char		*value;
	gclient_t	*client;
	char		userinfo[MAX_INFO_STRING];
	gentity_t	*ent;

#if MEETING	// JUHOX: no connection during game with meeting activated
	if (!level.meeting && g_meeting.integer) return "Game in progress, retry later";
#endif

	ent = &g_entities[ clientNum ];

	trap_GetUserinfo( clientNum, userinfo, sizeof( userinfo ) );

 	// IP filtering
 	// https://zerowing.idsoftware.com/bugzilla/show_bug.cgi?id=500
 	// recommanding PB based IP / GUID banning, the builtin system is pretty limited
	// check to see if they are on the banned IP list
	value = Info_ValueForKey (userinfo, "ip");
	if ( G_FilterPacket( value ) ) {
		return "You are banned from this server.";
	}

    // we don't check password for bots and local client
    // NOTE: local client <-> "ip" "localhost"
    //       this means this client is not running in our current process
	if ( !( ent->r.svFlags & SVF_BOT ) && (strcmp(value, "localhost") != 0)) {
        // check for a password
        value = Info_ValueForKey (userinfo, "password");
        if ( g_password.string[0] && Q_stricmp( g_password.string, "none" ) &&
            strcmp( g_password.string, value) != 0) {
            return "Invalid password";
        }
	}

	// they can connect
	ent->client = level.clients + clientNum;
	client = ent->client;

	memset( client, 0, sizeof(*client) );

	client->pers.connected = CON_CONNECTING;

	// JUHOX: set reference origin (has been cleared above)
	if (g_gametype.integer == GT_EFH) {
		G_SetPlayerRefOrigin(&client->ps);
	}

	// read or initialize the session data
	if ( firstTime || level.newSession ) {
		G_InitSessionData( client, userinfo );
	}
	G_ReadSessionData( client );

	if( isBot ) {
		ent->r.svFlags |= SVF_BOT;
		ent->inuse = qtrue;
		if( !G_BotConnect( clientNum, !firstTime ) ) {
			return "BotConnectfailed";
		}
	}

	// get and distribute relevent paramters
	G_LogPrintf( "ClientConnect: %i\n", clientNum );
	ClientUserinfoChanged( clientNum );

	// don't do the "xxx connected" messages if they were caried over from previous level
	if ( firstTime ) {
		trap_SendServerCommand( -1, va("print \"%s" S_COLOR_WHITE " connected\n\"", client->pers.netname) );
	}

	if ( g_gametype.integer >= GT_TEAM &&
		client->sess.sessionTeam != TEAM_SPECTATOR ) {
		BroadcastTeamChange( client, -1 );
	}

	// count current clients and rank for scoreboard
	CalculateRanks();

	return NULL;
}

/*
===========
ClientBegin

called when a client has finished connecting, and is ready
to be placed into the level.  This will happen every level load,
and on transition between teams, but doesn't happen on respawns
============
*/
void ClientBegin( int clientNum ) {
	gentity_t	*ent;
	gclient_t	*client;
	gentity_t	*tent;
	int			flags;

	ent = g_entities + clientNum;
	client = level.clients + clientNum;

	if ( ent->r.linked ) {
		trap_UnlinkEntity( ent );
	}

	G_InitGentity( ent );
	ent->touch = 0;
	ent->pain = 0;
	ent->client = client;

	client->pers.connected = CON_CONNECTED;
	client->pers.enterTime = level.time;
	client->pers.teamState.state = TEAM_BEGIN;
	client->pers.lastUsedWeapon = WP_NONE;	// JUHOX
	client->lasthurt_client = -1;	// JUHOX

	// save eflags around this, because changing teams will
	// cause this to happen with a valid entity, and we
	// want to make sure the teleport bit is set right
	// so the viewpoint doesn't interpolate through the
	// world to the new position
	flags = client->ps.eFlags;
	memset( &client->ps, 0, sizeof( client->ps ) );
	client->ps.eFlags = flags;
	BG_TSS_SetPlayerInfo(&client->ps, TSSPI_navAid, qtrue);

	// JUHOX: initialize first client position (JUHOX FIXME: still needed?)
	VectorCopy(level.intermission_origin, client->ps.origin);
	VectorCopy(level.intermission_angle, client->ps.viewangles);


	// locate ent at a spawn point
	ClientSpawn( ent );

	if ( client->sess.sessionTeam != TEAM_SPECTATOR ) {
		// send event
		// JUHOX: don't send teleport event for dead respawn

		if (client->ps.stats[STAT_HEALTH] > 0 && !level.meeting) {
			tent = G_TempEntity( ent->client->ps.origin, EV_PLAYER_TELEPORT_IN );
			tent->s.clientNum = ent->s.clientNum;
		}

		if ( g_gametype.integer != GT_TOURNAMENT  ) {
			trap_SendServerCommand( -1, va("print \"%s" S_COLOR_WHITE " entered the game\n\"", client->pers.netname) );
		}

		// JUHOX FIXME: set team leader
        // no bots in EFH, so there's no need to set the teamleader
		if ( g_gametype.integer >= GT_TEAM && g_gametype.integer != GT_EFH ) {
			int teamleader;

			teamleader = TeamLeader(client->sess.sessionTeam);
			if ( teamleader < 0 || ( !(g_entities[clientNum].r.svFlags & SVF_BOT) && (g_entities[teamleader].r.svFlags & SVF_BOT) )	) {
				SetLeader(client->sess.sessionTeam, clientNum);
			}
		}

	}
	G_LogPrintf( "ClientBegin: %i\n", clientNum );

	// count current clients and rank for scoreboard
	CalculateRanks();
}

/*
===========
JUHOX: GetRespawnLocationType
============
*/
respawnLocationType_t GetRespawnLocationType(gentity_t* ent, int msec) {
	vec3_t origin;
	vec3_t end;
	trace_t trace;
	respawnLocationType_t rlt;

	if (!ent->client) return RLT_invalid;
	if (ent->client->ps.stats[STAT_HEALTH] > 0) return RLT_invalid;
	if (g_gametype.integer >= GT_STU) return RLT_regular;
	if (g_gametype.integer < GT_TEAM) return RLT_regular;
	if (g_respawnDelay.integer < 10) return RLT_regular;

	if (msec >= 0) {
		if (ent->r.svFlags & SVF_BOT) return RLT_invalid;
		ent->client->timeResidual += msec;
		if (ent->client->timeResidual < 500) return ent->client->ps.stats[STAT_RESPAWN_INFO] & 3;
	}
	ent->client->timeResidual = 0;

	if (ent->client->ps.persistant[PERS_SPAWN_COUNT] == 0) return RLT_invalid;
	if (ent->client->respawnDelay < 0) return RLT_invalid;	// overkill / capture condition: don't show respawn position hint

	if (ent->client->buttons & BUTTON_USE_HOLDABLE) return RLT_regular;	// player wants to use a regular spawn point

	rlt = RLT_here;
	VectorCopy(ent->client->ps.origin, origin);
	if (g_gametype.integer == GT_CTF) {
		if (!NearHomeBase(ent->client->sess.sessionTeam, ent->client->ps.origin, 1)) {
			if (!g_respawnAtPOD.integer) return RLT_regular;
			if (!ent->client->mayRespawnAtDeathOrigin) return RLT_regular;
			rlt = RLT_atPOD;
			VectorCopy(ent->client->deathOrigin, origin);
		}
	}
	VectorCopy(origin, end);
	end[2] -= 10000;
	trap_Trace(
		&trace, origin, playerMins, playerMaxs, end, ent->client->ps.clientNum,
		(int)(CONTENTS_SOLID|CONTENTS_PLAYERCLIP|CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_NODROP)
	);
	if (trace.startsolid || trace.allsolid) return RLT_regular;
	if (trace.fraction >= 0.99) return RLT_regular;
	if (trace.contents & (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_NODROP)) return RLT_regular;
	VectorCopy(trace.endpos, origin);

	if (PositionWouldTelefrag(origin, playerMins, playerMaxs)) return RLT_regular;

	if (msec < 0) {
		VectorCopy(origin, ent->client->ps.origin);
	}

	return rlt;
}

/*
===========
JUHOX: CheckFreeSpawn
check if the entity may spawn at its current origin
============
*/
qboolean CheckFreeSpawn(gentity_t* ent) {
	switch (GetRespawnLocationType(ent, -1)) {
	case RLT_invalid:
	case RLT_regular:
	default:
		return qfalse;
	case RLT_here:
		return qtrue;
	case RLT_atPOD:
		VectorCopy(ent->client->deathAngles, ent->client->ps.viewangles);
		return qtrue;
	}
}

/*
===========
ClientSpawn

Called every time a client is placed fresh in the world:
after the first ClientBegin, and after each respawn
Initializes all non-persistant parts of playerState
============
*/
void ClientSpawn(gentity_t *ent) {
	int		index;
	vec3_t	spawn_origin, spawn_angles;
	gclient_t	*client;
	int		i;
	clientPersistant_t	saved;
	clientSession_t		savedSess;
	int		persistant[MAX_PERSISTANT];
	int		savedAmmo[MAX_WEAPONS];	// JUHOX
	float	savedAmmoFraction[MAX_WEAPONS];	// JUHOX
	int		savedStrength;	// JUHOX
	int		savedPowerups[16 - PW_NUM_POWERUPS];	// JUHOX
	gentity_t	*spawnPoint;
	int		flags;
	int		savedPing;
	int		accuracy_hits, accuracy_shots;
	int		eventSequence;
	char	userinfo[MAX_INFO_STRING];
	qboolean deadSpawn;	// JUHOX
	qboolean overkillSpawn;	// JUHOX

	index = ent - g_entities;
	client = ent->client;
	deadSpawn = qfalse;	// JUHOX
	overkillSpawn = (client->respawnDelay < 0);	// JUHOX
	client->tssNavAidTimeResidual = rand() % 1000;	// JUHOX
	if (client->podMarker) G_FreeEntity(client->podMarker);	// JUHOX

	// find a spawn point
	// do it before setting health back up, so farthest
	// ranging doesn't count this client
	if ( client->sess.sessionTeam == TEAM_SPECTATOR ) {
		spawnPoint = SelectSpectatorSpawnPoint (spawn_origin, spawn_angles);
	}
	else if (g_gametype.integer >= GT_TEAM && g_gametype.integer < GT_STU) {

        // JUHOX: check if a free spawn is possible
		if (CheckFreeSpawn(ent)) {
			spawnPoint = NULL;
			VectorCopy(client->ps.origin, spawn_origin);
			VectorCopy(client->ps.viewangles, spawn_angles);
			goto SpawnPointChoosen;
		}

		// all base oriented team games use the CTF spawn points
		spawnPoint = SelectCTFSpawnPoint (
						client->sess.sessionTeam,
						client->pers.teamState.state,
						spawn_origin, spawn_angles);
	} else {
        // JUHOX: check if a free spawn is possible
		if (CheckFreeSpawn(ent)) {
			spawnPoint = NULL;
			VectorCopy(client->ps.origin, spawn_origin);
			VectorCopy(client->ps.viewangles, spawn_angles);
			goto SpawnPointChoosen;
		}

		do {
			// the first spawn should be at a good looking spot
            // JUHOX: in STU use level.time to check for initial spawn
			if (g_gametype.integer >= GT_STU /*&& level.time < level.startTime + 5000*/) {
				client->pers.initialSpawn = qtrue;
				spawnPoint = SelectSpawnPoint(NULL, spawn_origin, spawn_angles);
			}
			else if ( !client->pers.initialSpawn && client->pers.localClient ) {
				client->pers.initialSpawn = qtrue;
				spawnPoint = SelectInitialSpawnPoint( spawn_origin, spawn_angles );
			} else {
				// don't spawn near existing origin if possible
				spawnPoint = SelectSpawnPoint (
					client->ps.origin,
					spawn_origin, spawn_angles);
			}

			if (!spawnPoint) return;	// JUHOX

			// Tim needs to prevent bots from spawning at the initial point
			// on q3dm0...
			if ( ( spawnPoint->flags & FL_NO_BOTS ) && ( ent->r.svFlags & SVF_BOT ) ) {
				continue;	// try again
			}
			// just to be symetric, we have a nohumans option...
			if ( ( spawnPoint->flags & FL_NO_HUMANS ) && !( ent->r.svFlags & SVF_BOT ) ) {
				continue;	// try again
			}

			break;

		} while ( 1 );
	}
	// JUHOX: spawn at current position if spawn point would telefrag
	if (client->sess.sessionTeam != TEAM_SPECTATOR && SpotWouldTelefrag(spawnPoint)) {
		if (client->ps.persistant[PERS_SPAWN_COUNT] != 0) return;
		// this is the first spawn. make it a dead spawn.
		VectorCopy(level.intermission_origin, client->ps.origin);
		VectorCopy(level.intermission_angle, client->ps.viewangles);
		deadSpawn = qtrue;
	}

	SpawnPointChoosen:	// JUHOX
	client->pers.teamState.state = TEAM_ACTIVE;

	// always clear the kamikaze flag
	ent->s.eFlags &= ~EF_KAMIKAZE;

	// toggle the teleport bit so the client knows to not lerp
	// and never clear the voted flag
	flags = ent->client->ps.eFlags & (EF_TELEPORT_BIT | EF_VOTED | EF_TEAMVOTED);
	flags ^= EF_TELEPORT_BIT;

	// clear everything but the persistant data
	saved = client->pers;
	savedSess = client->sess;
	savedPing = client->ps.ping;
	accuracy_hits = client->accuracy_hits;
	accuracy_shots = client->accuracy_shots;
	for ( i = 0 ; i < MAX_PERSISTANT ; i++ ) {
		persistant[i] = client->ps.persistant[i];
	}

	eventSequence = client->ps.eventSequence;

	// JUHOX: save ammo
	for (i = 0; i < MAX_WEAPONS; i++) {
		savedAmmo[i] = client->ps.ammo[i];
		savedAmmoFraction[i] = client->ammoFraction[i];
	}

	savedStrength = client->ps.stats[STAT_STRENGTH];	// JUHOX
	memcpy(savedPowerups, &client->ps.powerups[PW_NUM_POWERUPS], (16-PW_NUM_POWERUPS) * sizeof(int));	// JUHOX

	memset (client, 0, sizeof(*client)); // bk FIXME: Com_Memset?

	client->pers = saved;
	client->sess = savedSess;
	client->ps.ping = savedPing;
//	client->areabits = savedAreaBits;
	client->accuracy_hits = accuracy_hits;
	client->accuracy_shots = accuracy_shots;
	client->lastkilled_client = -1;

	for ( i = 0 ; i < MAX_PERSISTANT ; i++ ) {
		client->ps.persistant[i] = persistant[i];
	}

	// JUHOX: restore ammo
	for (i = 0; i < MAX_WEAPONS; i++) {
		client->ps.ammo[i] = savedAmmo[i];
		client->ammoFraction[i] = savedAmmoFraction[i];
	}

	client->ps.stats[STAT_STRENGTH] = savedStrength;	// JUHOX
	memcpy(&client->ps.powerups[PW_NUM_POWERUPS], savedPowerups, (16-PW_NUM_POWERUPS) * sizeof(int));	// JUHOX

	// JUHOX: add shield
	if (client->sess.sessionTeam != TEAM_SPECTATOR) {
		client->ps.powerups[PW_SHIELD] = level.time + 400;	// JUHOX
        // JUHOX: activate shield in STU
		if (g_gametype.integer == GT_STU) {
			client->ps.powerups[PW_SHIELD] = level.time + 5000;
		}
	}

	client->ps.eventSequence = eventSequence;
	// increment the spawncount so the client will detect the respawn
	client->ps.persistant[PERS_SPAWN_COUNT]++;
	client->ps.persistant[PERS_TEAM] = client->sess.sessionTeam;
	// JUHOX: set reference origin
	if (g_gametype.integer == GT_EFH) {
		G_SetPlayerRefOrigin(&client->ps);
	}


	client->airOutTime = level.time + 12000;

	trap_GetUserinfo( index, userinfo, sizeof(userinfo) );
	// set max health
	client->pers.maxHealth = atoi( Info_ValueForKey( userinfo, "handicap" ) );
	if ( client->pers.maxHealth < 1 || client->pers.maxHealth > 100 ) {
		client->pers.maxHealth = 100;
	}
	// clear entity values
	client->ps.stats[STAT_MAX_HEALTH] = g_baseHealth.value * (client->pers.maxHealth / 100.0);
	if (client->ps.stats[STAT_MAX_HEALTH] < 1) client->ps.stats[STAT_MAX_HEALTH] = 1;

	client->ps.eFlags = flags;

	ent->s.groundEntityNum = ENTITYNUM_NONE;
	ent->client = &level.clients[index];
	ent->takedamage = qtrue;
	ent->inuse = qtrue;
	ent->classname = "player";
	ent->r.contents = CONTENTS_BODY;
	ent->clipmask = MASK_PLAYERSOLID;
	ent->die = player_die;
	ent->waterlevel = 0;
	ent->watertype = 0;
	ent->flags = 0;

	VectorCopy (playerMins, ent->r.mins);
	VectorCopy (playerMaxs, ent->r.maxs);

	client->ps.clientNum = index;

	// health will count down towards max_health
	ent->health = client->ps.stats[STAT_HEALTH] = client->ps.stats[STAT_MAX_HEALTH] + 25;

	G_SetOrigin( ent, spawn_origin );
	VectorCopy( spawn_origin, client->ps.origin );

	// the respawned flag will be cleared after the attack and jump keys come up
	client->ps.pm_flags |= PMF_RESPAWNED;

	trap_GetUsercmd( client - level.clients, &ent->client->pers.cmd );
	SetClientViewAngle( ent, spawn_angles );

	if ( deadSpawn || ent->client->sess.sessionTeam == TEAM_SPECTATOR ) {

	} else {
		G_KillBox( ent );
		trap_LinkEntity (ent);

		// force the base weapon up
		client->ps.weapon = WP_MACHINEGUN;
		client->ps.weaponstate = WEAPON_READY;

	}

	// don't allow full run speed for a bit
	client->ps.pm_flags |= PMF_TIME_KNOCKBACK;
	client->ps.pm_time = 100;

	client->respawnTime = level.time;
	client->inactivityTime = level.time + g_inactivity.integer * 1000;
	client->latched_buttons = 0;

	// set default animations
	client->ps.torsoAnim = TORSO_STAND;
	client->ps.legsAnim = LEGS_IDLE;

	if ( level.intermissiontime ) {
		MoveClientToIntermission( ent );
	} else {
		// fire the targets of the spawn point
		G_UseTargets( spawnPoint, ent );

		// select the highest weapon number available, after any
		// spawn given items have fired
		client->ps.weapon = 1;
		for ( i = WP_NUM_WEAPONS - 1 ; i > 0 ; i-- ) {
			if ( client->ps.stats[STAT_WEAPONS] & ( 1 << i ) ) {
				client->ps.weapon = i;
				break;
			}
		}
	}

	// JUHOX: new default equipment
	client->ps.stats[STAT_WEAPONS] =
		(1<<WP_GAUNTLET) | (1<<WP_MACHINEGUN) | (1<<WP_SHOTGUN) |
		(1<<WP_GRENADE_LAUNCHER) | (1<<WP_ROCKET_LAUNCHER) |
		(1<<WP_LIGHTNING) | (1<<WP_RAILGUN) | (1<<WP_PLASMAGUN) |
		(1<<WP_BFG);

	if (g_gametype.integer < GT_STU && g_monsterLauncher.integer) {
		client->ps.stats[STAT_WEAPONS] |= (1<<WP_MONSTER_LAUNCHER);
	}

	if (
		g_weaponLimit.integer > 0 &&
		client->pers.numChoosenWeapons >= g_weaponLimit.integer
	) {
		// restrict to choosen weapons
		client->ps.stats[STAT_WEAPONS] = 0;
		for (i = 0; i < client->pers.numChoosenWeapons; i++) {
			client->ps.stats[STAT_WEAPONS] |= 1 << client->pers.choosenWeapons[i];
		}
	}


	if ( g_gametype.integer != GT_EFH &&g_grapple.integer > HM_disabled && g_grapple.integer < HM_num_modes ) {
		client->ps.stats[STAT_WEAPONS] |= (1<<WP_GRAPPLING_HOOK);
	}

	if (client->ps.persistant[PERS_SPAWN_COUNT] == 1) {
		if (g_unlimitedAmmo.integer) {
			client->ps.ammo[WP_GAUNTLET] = -1;
			client->ps.ammo[WP_MACHINEGUN] = -1;
			client->ps.ammo[WP_SHOTGUN] = -1;
			client->ps.ammo[WP_GRENADE_LAUNCHER] = -1;
			client->ps.ammo[WP_ROCKET_LAUNCHER] = -1;
			client->ps.ammo[WP_LIGHTNING] = -1;
			client->ps.ammo[WP_RAILGUN] = -1;
			client->ps.ammo[WP_PLASMAGUN] = -1;
			client->ps.ammo[WP_BFG] = -1;
			client->ps.ammo[WP_GRAPPLING_HOOK] = -1;
			client->ps.ammo[WP_MONSTER_LAUNCHER] = WP_MONSTER_LAUNCHER_MAX_AMMO;
		}
		else {
			client->ps.ammo[WP_GAUNTLET] = WP_GAUNTLET_MAX_AMMO;
			client->ps.ammo[WP_MACHINEGUN] = WP_MACHINEGUN_MAX_AMMO;
			client->ps.ammo[WP_SHOTGUN] = WP_SHOTGUN_MAX_AMMO;
			client->ps.ammo[WP_GRENADE_LAUNCHER] = WP_GRENADE_LAUNCHER_MAX_AMMO;
			client->ps.ammo[WP_ROCKET_LAUNCHER] = WP_ROCKET_LAUNCHER_MAX_AMMO;
			client->ps.ammo[WP_LIGHTNING] = WP_LIGHTNING_MAX_AMMO;
			client->ps.ammo[WP_RAILGUN] = WP_RAILGUN_MAX_AMMO;
			client->ps.ammo[WP_PLASMAGUN] = WP_PLASMAGUN_MAX_AMMO;
			client->ps.ammo[WP_BFG] = WP_BFG_MAX_AMMO;
			client->ps.ammo[WP_GRAPPLING_HOOK] = WP_GRAPPLING_HOOK_MAX_AMMO;
			client->ps.ammo[WP_MONSTER_LAUNCHER] = WP_MONSTER_LAUNCHER_MAX_AMMO;
		}

		client->ps.stats[STAT_STRENGTH] = MAX_STRENGTH_VALUE;
	}
	if (client->pers.lastUsedWeapon <= WP_NONE || client->pers.lastUsedWeapon >= WP_NUM_WEAPONS) {
		client->ps.weapon = WP_MACHINEGUN;
	}
	else {
		client->ps.weapon = client->pers.lastUsedWeapon;
	}
	client->ps.stats[STAT_TARGET] = -1;

	client->ps.weaponTime = 250;
	client->ps.weaponstate = WEAPON_READY;
	client->ps.generic1 = rand() & 255;	// JUHOX: randomize weapon shaking

	// run a client frame to drop exactly to the floor,
	// initialize animations and other things
	client->ps.commandTime = level.time - 100;
	ent->client->pers.cmd.serverTime = level.time;
	ClientThink( ent-g_entities );

	// JUHOX: make ClientThink() init viewmode next frame
	client->viewMode = -1;


	// JUHOX: spawn effect
	//client->ps.stats[STAT_EFFECT] = PE_spawn;
	SET_STAT_EFFECT(&client->ps, PE_spawn);
	client->ps.powerups[PW_EFFECT_TIME] = level.time + SPAWNHULL_TIME;
	client->weaponUsageTime = level.time - 5000;
	client->grappleUsageTime = level.time - 5000;
	if (g_cloakingDevice.integer) {
		client->ps.powerups[PW_INVIS] = level.time + 1000000000;
	}


#if 1	// JUHOX: spawn dead if the spawn point would telefrag someone
	if (deadSpawn) {
		client->ps.pm_type = PM_SPECTATOR;
		client->ps.stats[STAT_HEALTH] = 0;
		ent->health = 0;
		client->ps.stats[STAT_RESPAWN_INFO] = 0;
		client->ps.weapon = WP_NONE;
		client->ps.stats[STAT_WEAPONS] = 0;
		client->respawnDelay = -1;
		ent->s.eFlags |= EF_NODRAW;
		client->ps.eFlags |= EF_NODRAW;
		ent->takedamage = qfalse;
		ent->r.contents = CONTENTS_CORPSE;
	}
#endif

	// positively link the client, even if the command times are weird
	if ( ent->client->sess.sessionTeam != TEAM_SPECTATOR ) {
		BG_PlayerStateToEntityState( &client->ps, &ent->s, qtrue );
		VectorCopy( ent->client->ps.origin, ent->r.currentOrigin );
		trap_LinkEntity( ent );
	}

	// run the presend to set anything else
	ClientEndFrame( ent );

	// clear entity state values
	BG_PlayerStateToEntityState( &client->ps, &ent->s, qtrue );
}


/*
===========
ClientDisconnect

Called when a player drops from the server.
Will not be called between levels.

This should NOT be called directly by any game logic,
call trap_DropClient(), which will call this and do
server system housekeeping.
============
*/
void ClientDisconnect( int clientNum ) {
	gentity_t	*ent;
	gentity_t	*tent;
	int			i;

	// cleanup if we are kicking a bot that
	// hasn't spawned yet
	G_RemoveQueuedBotBegin( clientNum );

	ent = g_entities + clientNum;
	if ( !ent->client ) {
		return;
	}

	// stop any following clients
	for ( i = 0 ; i < level.maxclients ; i++ ) {
		if ( level.clients[i].sess.sessionTeam == TEAM_SPECTATOR
			&& level.clients[i].sess.spectatorState == SPECTATOR_FOLLOW
			&& level.clients[i].sess.spectatorClient == clientNum ) {
			StopFollowing( &g_entities[i] );
		}
	}

	// send effect if they were completely connected
	if ( ent->client->pers.connected == CON_CONNECTED
		&& ent->client->sess.sessionTeam != TEAM_SPECTATOR ) {
		tent = G_TempEntity( ent->client->ps.origin, EV_PLAYER_TELEPORT_OUT );
		tent->s.clientNum = ent->s.clientNum;

		// They don't get to take powerups with them!
		// Especially important for stuff like CTF flags
		TossClientItems( ent );

	}

	G_LogPrintf( "ClientDisconnect: %i\n", clientNum );

	// if we are playing in tourney mode and losing, give a win to the other player
	if ( (g_gametype.integer == GT_TOURNAMENT )
		&& !level.intermissiontime
		&& !level.warmupTime && level.sortedClients[1] == clientNum ) {
		level.clients[ level.sortedClients[0] ].sess.wins++;
		ClientUserinfoChanged( level.sortedClients[0] );
	}

	trap_UnlinkEntity (ent);
	ent->s.modelindex = 0;
	ent->inuse = qfalse;
	ent->classname = "disconnected";
	ent->client->pers.connected = CON_DISCONNECTED;
	ent->client->ps.persistant[PERS_TEAM] = TEAM_FREE;
	ent->client->sess.sessionTeam = TEAM_FREE;

	trap_SetConfigstring( CS_PLAYERS + clientNum, "");

	CalculateRanks();

	if ( ent->r.svFlags & SVF_BOT ) {
		BotAIShutdownClient( clientNum, qfalse );
	}

#if MEETING	// JUHOX: end match if the last human player left the game
	if (g_meeting.integer && !level.meeting) {
		int numHumanPlayers;

		numHumanPlayers = 0;
		for (i = 0; i < level.maxclients; i++) {
			if (level.clients[i].pers.connected != CON_CONNECTED) continue;
			if (g_entities[i].r.svFlags & SVF_BOT) continue;

			numHumanPlayers++;
		}

		if (numHumanPlayers <= 0) {
			level.endTime = level.time;
			LogExit("no human players");
		}
	}
#endif
}


