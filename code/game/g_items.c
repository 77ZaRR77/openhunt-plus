// Copyright (C) 1999-2000 Id Software, Inc.
//
#include "g_local.h"

/*

  Items are any object that a player can touch to gain some effect.

  Pickup will return the number of seconds until they should respawn.

  all items should pop when dropped in lava or slime

  Respawnable items don't actually go away when picked up, they are
  just made invisible and untouchable.  This allows them to ride
  movers and respawn apropriately.
*/


#define	RESPAWN_ARMOR		25
#define	RESPAWN_HEALTH		35
#define	RESPAWN_AMMO		40
#define	RESPAWN_HOLDABLE	60
#define	RESPAWN_MEGAHEALTH	35//120
#define	RESPAWN_POWERUP		120


//======================================================================

int Pickup_Powerup( gentity_t *ent, gentity_t *other ) {
	int			quantity;
	int			i;
	gclient_t	*client;

	if ( !other->client->ps.powerups[ent->item->giTag] ) {
		// round timing to seconds to make multiple powerup timers
		// count in sync
		other->client->ps.powerups[ent->item->giTag] =
			level.time - ( level.time % 1000 );
	}

	if ( ent->count ) {
		quantity = ent->count;
	} else {
		quantity = ent->item->quantity;
	}

	other->client->ps.powerups[ent->item->giTag] += quantity * 1000;

	// give any nearby players a "denied" anti-reward
	for ( i = 0 ; i < level.maxclients ; i++ ) {
		vec3_t		delta;
		float		len;
		vec3_t		forward;
		trace_t		tr;

		client = &level.clients[i];
		if ( client == other->client ) {
			continue;
		}
		if ( client->pers.connected == CON_DISCONNECTED ) {
			continue;
		}
		if ( client->ps.stats[STAT_HEALTH] <= 0 ) {
			continue;
		}
		// JUHOX: don't give spectators an anti-reward
#if 1
		if (client->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR) {
			continue;
		}
#endif

    // if same team in team game, no sound
    // cannot use OnSameTeam as it expects to g_entities, not clients
  	if ( g_gametype.integer >= GT_TEAM && other->client->sess.sessionTeam == client->sess.sessionTeam  ) {
      continue;
    }

		// if too far away, no sound
		VectorSubtract( ent->s.pos.trBase, client->ps.origin, delta );
		len = VectorNormalize( delta );
		if ( len > 192 ) {
			continue;
		}

		// if not facing, no sound
		AngleVectors( client->ps.viewangles, forward, NULL, NULL );
		if ( DotProduct( delta, forward ) < 0.4 ) {
			continue;
		}

		// if not line of sight, no sound
		trap_Trace( &tr, client->ps.origin, NULL, NULL, ent->s.pos.trBase, ENTITYNUM_NONE, CONTENTS_SOLID );
		if ( tr.fraction != 1.0 ) {
			continue;
		}

		// anti-reward
		client->ps.persistant[PERS_PLAYEREVENTS] ^= PLAYEREVENT_DENIEDREWARD;
	}
	return RESPAWN_POWERUP;
}

//======================================================================

int Pickup_Holdable( gentity_t *ent, gentity_t *other ) {

	other->client->ps.stats[STAT_HOLDABLE_ITEM] = ent->item - bg_itemlist;

	if( ent->item->giTag == HI_KAMIKAZE ) {
		other->client->ps.eFlags |= EF_KAMIKAZE;
	}

	return RESPAWN_HOLDABLE;
}


//======================================================================

void Add_Ammo (gentity_t *ent, int weapon, int count)
{
	if (ent->client->ps.ammo[weapon] < 0) return;	// JUHOX
	ent->client->ps.ammo[weapon] += count;
	if ( ent->client->ps.ammo[weapon] > 200 ) {
		ent->client->ps.ammo[weapon] = 200;
	}
}

int Pickup_Ammo (gentity_t *ent, gentity_t *other)
{
	int		quantity;

	if ( ent->count ) {
		quantity = ent->count;
	} else {
		quantity = ent->item->quantity;
	}

	Add_Ammo (other, ent->item->giTag, quantity);

	return RESPAWN_AMMO;
}

//======================================================================


int Pickup_Weapon (gentity_t *ent, gentity_t *other) {
	int		quantity;

	if ( ent->count < 0 ) {
		quantity = 0; // None for you, sir!
	} else {
		if ( ent->count ) {
			quantity = ent->count;
		} else {
			quantity = ent->item->quantity;
		}

		// dropped items and teamplay weapons always have full ammo
		if ( ! (ent->flags & FL_DROPPED_ITEM) && g_gametype.integer != GT_TEAM ) {
			// respawning rules
			// drop the quantity if the already have over the minimum
			if ( other->client->ps.ammo[ ent->item->giTag ] < quantity ) {
				quantity = quantity - other->client->ps.ammo[ ent->item->giTag ];
			} else {
				quantity = 1;		// only add a single shot
			}
		}
	}

	// add the weapon
	other->client->ps.stats[STAT_WEAPONS] |= ( 1 << ent->item->giTag );

	Add_Ammo( other, ent->item->giTag, quantity );

	if (ent->item->giTag == WP_GRAPPLING_HOOK)
		other->client->ps.ammo[ent->item->giTag] = -1; // unlimited ammo

	// team deathmatch has slow weapon respawns
	if ( g_gametype.integer == GT_TEAM ) {
		return g_weaponTeamRespawn.integer;
	}

	return g_weaponRespawn.integer;
}


//======================================================================

int Pickup_Health (gentity_t *ent, gentity_t *other) {
	int			max;
	int			quantity;

	// small and mega healths will go over the max
	if ( ent->item->quantity != 5 && ent->item->quantity != 100 ) {
		max = other->client->ps.stats[STAT_MAX_HEALTH];
	} else {
		max = other->client->ps.stats[STAT_MAX_HEALTH] * 2;
	}

	if ( ent->count ) {
		quantity = ent->count;
	} else {
		quantity = ent->item->quantity;
	}

	// JUHOX: health items reduce charge
#if 0
	other->health += quantity;

	if (other->health > max ) {
		other->health = max;
	}
	other->client->ps.stats[STAT_HEALTH] = other->health;
#else
	if (other->client->ps.powerups[PW_CHARGE]) {
		other->client->ps.powerups[PW_CHARGE] -= 100 * quantity;
	}
	else {
		other->health += quantity;

		if (other->health > max ) {
			other->health = max;
		}
		other->client->ps.stats[STAT_HEALTH] = other->health;
	}
#endif

	if ( ent->item->quantity == 100 ) {		// mega health respawns slow
		return RESPAWN_MEGAHEALTH;
	}

	return RESPAWN_HEALTH;
}

//======================================================================

int Pickup_Armor( gentity_t *ent, gentity_t *other ) {

	other->client->ps.stats[STAT_ARMOR] += ent->item->quantity;
	if ( other->client->ps.stats[STAT_ARMOR] > other->client->ps.stats[STAT_MAX_HEALTH] * 2 ) {
		other->client->ps.stats[STAT_ARMOR] = other->client->ps.stats[STAT_MAX_HEALTH] * 2;
	}

	return RESPAWN_ARMOR;
}

//======================================================================

/*
===============
JUHOX: Think_Artefact
===============
*/
static void Think_Artefact(gentity_t* ent) {
	G_SpawnArtefact();
}

/*
===============
JUHOX: Pickup_Artefact
===============
*/
int Pickup_Artefact(gentity_t* ent, gentity_t* other) {
	gentity_t* te;
	int i;
	int score;

	level.artefactCapturedTime = level.time;

	level.teamScores[TEAM_RED]++;
	score = 1000;
	level.stuScore += score;
	if (other->client) {
		other->client->ps.persistant[PERS_SCORE] += score;
		ScorePlum(other, ent->s.pos.trBase, score);
	}
	CalculateRanks();

	if (other->client->pers.predictItemPickup) {
		G_AddPredictableEvent(other, EV_ITEM_PICKUP, ent->s.modelindex);
	} else {
		G_AddEvent(other, EV_ITEM_PICKUP, ent->s.modelindex);
	}

	ent->r.svFlags |= SVF_NOCLIENT;
	ent->s.eFlags |= EF_NODRAW;
	ent->r.contents = 0;

	if (
		g_skipEndSequence.integer &&
		g_artefacts.integer < 999 &&
		level.teamScores[TEAM_RED] >= g_artefacts.integer
	) return 0;

	te = G_TempEntity(ent->s.pos.trBase, EV_GLOBAL_ITEM_PICKUP);
	te->s.eventParm = ent->s.modelindex;
	te->s.modelindex = 0;
	te->r.svFlags |= SVF_BROADCAST;

	if (level.teamScores[TEAM_RED] < g_artefacts.integer || g_artefacts.integer >= 999) {
		ent->think = Think_Artefact;
		ent->nextthink = level.time + 16000;
	}
	else {
		te->s.modelindex = 1;	// signal to the clients: "this was the last pickup"
	}

	for (i = 0; i < level.maxclients; i++) ForceRespawn(&g_entities[i]);

	G_ReleaseTrap(g_monstersPerTrap.integer, ent->s.pos.trBase);

	return 0;
}


//======================================================================

/*
===============
RespawnItem
===============
*/
void RespawnItem( gentity_t *ent ) {
	// randomly select from teamed entities
	if (ent->team) {
		gentity_t	*master;
		int	count;
		int choice;

		if ( !ent->teammaster ) {
			G_Error( "RespawnItem: bad teammaster");
		}
		master = ent->teammaster;

		for (count = 0, ent = master; ent; ent = ent->teamchain, count++)
			;

		choice = rand() % count;

		for (count = 0, ent = master; count < choice; ent = ent->teamchain, count++)
			;
	}

	ent->r.contents = CONTENTS_TRIGGER;
	ent->s.eFlags &= ~EF_NODRAW;
	ent->r.svFlags &= ~SVF_NOCLIENT;
	trap_LinkEntity (ent);

	if ( ent->item->giType == IT_POWERUP ) {
		// play powerup spawn sound to all clients
		gentity_t	*te;

		// if the powerup respawn sound should Not be global
		if (ent->speed) {
			te = G_TempEntity( ent->s.pos.trBase, EV_GENERAL_SOUND );
		}
		else {
			te = G_TempEntity( ent->s.pos.trBase, EV_GLOBAL_SOUND );
		}
		te->s.eventParm = G_SoundIndex( "sound/items/poweruprespawn.wav" );
		te->r.svFlags |= SVF_BROADCAST;
	}

	if ( ent->item->giType == IT_HOLDABLE && ent->item->giTag == HI_KAMIKAZE ) {
		// play powerup spawn sound to all clients
		gentity_t	*te;

		// if the powerup respawn sound should Not be global
		if (ent->speed) {
			te = G_TempEntity( ent->s.pos.trBase, EV_GENERAL_SOUND );
		}
		else {
			te = G_TempEntity( ent->s.pos.trBase, EV_GLOBAL_SOUND );
		}
		te->s.eventParm = G_SoundIndex( "sound/items/kamikazerespawn.wav" );
		te->r.svFlags |= SVF_BROADCAST;
	}

	// play the normal respawn sound only to nearby clients
	G_AddEvent( ent, EV_ITEM_RESPAWN, 0 );

	ent->nextthink = 0;
}


/*
===============
Touch_Item
===============
*/
void Touch_Item (gentity_t *ent, gentity_t *other, trace_t *trace) {
	int			respawn;
	qboolean	predict;

	if (!other->client)
		return;
	if (other->health < 1)
		return;		// dead people can't pickup

	// the same pickup rules are used for client side and server side
	if ( !BG_CanItemBeGrabbed( g_gametype.integer, &ent->s, &other->client->ps ) ) {
		return;
	}

	G_LogPrintf( "Item: %i %s\n", other->s.number, ent->item->classname );

	predict = other->client->pers.predictItemPickup;

	// call the item-specific pickup function
	switch( ent->item->giType ) {
	case IT_WEAPON:
		respawn = Pickup_Weapon(ent, other);
//		predict = qfalse;
		break;
	case IT_AMMO:
		respawn = Pickup_Ammo(ent, other);
//		predict = qfalse;
		break;
	case IT_ARMOR:
		respawn = Pickup_Armor(ent, other);
		break;
	case IT_HEALTH:
		respawn = Pickup_Health(ent, other);
		break;
	case IT_POWERUP:
		respawn = Pickup_Powerup(ent, other);
		predict = qfalse;
		break;
	case IT_TEAM:
		// JUHOX: check for picking up an artefact
		if (ent->item->giTag == PW_QUAD) {
			respawn = Pickup_Artefact(ent, other);
		}
		else {
			respawn = Pickup_Team(ent, other);
		}
		break;
	case IT_HOLDABLE:
		respawn = Pickup_Holdable(ent, other);
		break;
	default:
		return;
	}

	if ( !respawn ) {
		return;
	}

	// play the normal pickup sound
	if (predict) {
		G_AddPredictableEvent( other, EV_ITEM_PICKUP, ent->s.modelindex );
	} else {
		G_AddEvent( other, EV_ITEM_PICKUP, ent->s.modelindex );
	}

	// powerup pickups are global broadcasts
	// JUHOX: don't play global sounds for powerups
	if (ent->item->giType == IT_TEAM) {
		// if we want the global sound to play
		if (!ent->speed) {
			gentity_t	*te;

			te = G_TempEntity( ent->s.pos.trBase, EV_GLOBAL_ITEM_PICKUP );
			te->s.eventParm = ent->s.modelindex;
			te->r.svFlags |= SVF_BROADCAST;
		} else {
			gentity_t	*te;

			te = G_TempEntity( ent->s.pos.trBase, EV_GLOBAL_ITEM_PICKUP );
			te->s.eventParm = ent->s.modelindex;
			// only send this temp entity to a single client
			te->r.svFlags |= SVF_SINGLECLIENT;
			te->r.singleClient = other->s.number;
		}
	}

	// fire item targets
	G_UseTargets (ent, other);

	// wait of -1 will not respawn
	if ( ent->wait == -1 ) {
		ent->r.svFlags |= SVF_NOCLIENT;
		ent->s.eFlags |= EF_NODRAW;
		ent->r.contents = 0;
		ent->unlinkAfterEvent = qtrue;
		return;
	}

	// non zero wait overrides respawn time
	if ( ent->wait ) {
		respawn = ent->wait;
	}

	// random can be used to vary the respawn time
	if ( ent->random ) {
		respawn += crandom() * ent->random;
		if ( respawn < 1 ) {
			respawn = 1;
		}
	}

	// dropped items will not respawn
	if ( ent->flags & FL_DROPPED_ITEM ) {
		ent->freeAfterEvent = qtrue;
	}

	// picked up items still stay around, they just don't
	// draw anything.  This allows respawnable items
	// to be placed on movers.
	ent->r.svFlags |= SVF_NOCLIENT;
	ent->s.eFlags |= EF_NODRAW;
	ent->r.contents = 0;

	// ZOID
	// A negative respawn times means to never respawn this item (but don't
	// delete it).  This is used by items that are respawned by third party
	// events such as ctf flags
	if ( respawn <= 0 ) {
		ent->nextthink = 0;
		ent->think = 0;
	} else {
		ent->nextthink = level.time + respawn * 1000;
		ent->think = RespawnItem;
	}
	trap_LinkEntity( ent );
}


//======================================================================

/*
================
JUHOX: G_SpawnArtefact

derived in part from LaunchItem()
================
*/
void G_SpawnArtefact(void) {
	int i;
	int numItems1;
	int numItems2;
	gentity_t* placeHolder1;
	gentity_t* placeHolder2;
	vec3_t origin;

	if (g_gametype.integer != GT_STU) return;

	if (!level.artefact) {
		gitem_t* item;

		item = BG_FindItem("Artefact");
		if (!item) return;

		level.artefact = G_Spawn();
		if (!level.artefact) return;

		level.artefact->s.eType = ET_ITEM;
		level.artefact->s.modelindex = item - bg_itemlist;
		level.artefact->s.modelindex2 = 0;

		level.artefact->classname = item->classname;
		level.artefact->item = item;
		VectorSet(level.artefact->r.mins, -ITEM_RADIUS, -ITEM_RADIUS, -ITEM_RADIUS);
		VectorSet(level.artefact->r.maxs, ITEM_RADIUS, ITEM_RADIUS, ITEM_RADIUS);
		level.artefact->r.contents = CONTENTS_TRIGGER;

		level.artefact->touch = Touch_Item;
	}

	if (level.artefactPlaceholder) {
		level.artefactPlaceholder->think = RespawnItem;
		level.artefactPlaceholder->nextthink = level.time + 30000;
		level.artefactPlaceholder = NULL;
	}

	numItems1 = 0;
	placeHolder1 = NULL;
	numItems2 = 0;
	placeHolder2 = NULL;
	for (i = MAX_CLIENTS; i < level.num_entities; i++) {
		gentity_t* ent;

		ent = &g_entities[i];
		if (!ent->inuse) continue;
		if (ent->s.eType != ET_ITEM) continue;
		if (ent->s.modelindex2) continue;	// dropped item
		if (ent == level.artefact) continue;

		numItems2++;
		if (SeededRandom(GST_artefactSpawning) % numItems2 == 0) placeHolder2 = ent;

		if (
			level.artefact &&
			DistanceSquared(ent->s.pos.trBase, level.artefact->s.pos.trBase) < Square(1000.0)
		) {
			continue;
		}

		numItems1++;
		if (SeededRandom(GST_artefactSpawning) % numItems1 == 0) placeHolder1 = ent;
	}
	if (!placeHolder2) {
		int choosen;
		int numSpawnPoints;
		trace_t trace;
		vec3_t mins;
		vec3_t maxs;
		vec3_t start;
		vec3_t end;

		if (level.numEmergencySpawnPoints <= 0) {
			G_Error("Couldn't find a suitable item to spawn artefact.\n");
			return;
		}

		numSpawnPoints = 0;
		choosen = -1;
		for (i = 0; i < level.numEmergencySpawnPoints; i++) {
			if (
				level.artefact &&
				DistanceSquared(level.emergencySpawnPoints[i], level.artefact->s.pos.trBase) < Square(1000.0)
			) {
				continue;
			}

			numSpawnPoints++;
			if (SeededRandom(GST_artefactSpawning) % numSpawnPoints == 0) choosen = i;
		}
		if (choosen < 0) {
			choosen = SeededRandom(GST_artefactSpawning) % level.numEmergencySpawnPoints;
		}
		VectorCopy(level.emergencySpawnPoints[choosen], start);
		VectorCopy(start, end);
		end[2] -= 4000;
		VectorSet(mins, -ITEM_RADIUS, -ITEM_RADIUS, -ITEM_RADIUS);
		VectorSet(maxs, ITEM_RADIUS, ITEM_RADIUS, ITEM_RADIUS);
		trap_Trace(&trace, start, mins, maxs, end, -1, MASK_PLAYERSOLID & ~CONTENTS_BODY);
		VectorCopy(trace.endpos, origin);
	}
	else {
		if (!placeHolder1) placeHolder1 = placeHolder2;

		// inhibit placeHolder
		placeHolder1->r.svFlags |= SVF_NOCLIENT;
		placeHolder1->s.eFlags |= EF_NODRAW;
		placeHolder1->r.contents = 0;
		placeHolder1->nextthink = 0;
		placeHolder1->think = 0;
		level.artefactPlaceholder = placeHolder1;
		VectorCopy(placeHolder1->s.pos.trBase, origin);
	}

	level.artefact->think = 0;
	level.artefact->nextthink = 0;
	G_SetOrigin(level.artefact, origin);
	level.artefact->s.eFlags ^= EF_TELEPORT_BIT;
	level.artefact->r.contents = CONTENTS_TRIGGER;
	level.artefact->s.eFlags &= ~EF_NODRAW;
	level.artefact->r.svFlags &= ~SVF_NOCLIENT;
	trap_LinkEntity(level.artefact);
}

/*
================
LaunchItem

Spawns an item and tosses it forward
================
*/
gentity_t *LaunchItem( gitem_t *item, vec3_t origin, vec3_t velocity ) {
	gentity_t	*dropped;

	dropped = G_Spawn();
	if (!dropped) return NULL;	// JUHOX BUGFIX

	dropped->s.eType = ET_ITEM;
	dropped->s.modelindex = item - bg_itemlist;	// store item number in modelindex
	dropped->s.modelindex2 = 1; // This is non-zero is it's a dropped item

	dropped->classname = item->classname;
	dropped->item = item;
	VectorSet (dropped->r.mins, -ITEM_RADIUS, -ITEM_RADIUS, -ITEM_RADIUS);
	VectorSet (dropped->r.maxs, ITEM_RADIUS, ITEM_RADIUS, ITEM_RADIUS);
	dropped->r.contents = CONTENTS_TRIGGER;

	dropped->touch = Touch_Item;

	G_SetOrigin( dropped, origin );
	dropped->s.pos.trType = TR_GRAVITY;
	dropped->s.pos.trTime = level.time;
	VectorCopy( velocity, dropped->s.pos.trDelta );

	dropped->s.eFlags |= EF_BOUNCE_HALF;
	if (g_gametype.integer == GT_CTF && item->giType == IT_TEAM) { // Special case for CTF flags
		dropped->think = Team_DroppedFlagThink;
		dropped->nextthink = level.time + 30000;
		Team_CheckDroppedItem( dropped );
	} else { // auto-remove after 30 seconds
		dropped->think = G_FreeEntity;
		dropped->nextthink = level.time + 30000;
	}

	dropped->flags = FL_DROPPED_ITEM;

	trap_LinkEntity (dropped);

	return dropped;
}

/*
================
Drop_Item

Spawns an item and tosses it forward
================
*/
gentity_t *Drop_Item( gentity_t *ent, gitem_t *item, float angle ) {
	vec3_t	velocity;
	vec3_t	angles;

	VectorCopy( ent->s.apos.trBase, angles );
	angles[YAW] += angle;
	angles[PITCH] = 0;	// always forward

	AngleVectors( angles, velocity, NULL, NULL );
	VectorScale( velocity, 150, velocity );
	velocity[2] += 200 + crandom() * 50;

	return LaunchItem( item, ent->s.pos.trBase, velocity );
}


/*
================
Use_Item

Respawn the item
================
*/
void Use_Item( gentity_t *ent, gentity_t *other, gentity_t *activator ) {
	RespawnItem( ent );
}

//======================================================================

/*
================
FinishSpawningItem

Traces down to find where an item should rest, instead of letting them
free fall from their spawn points
================
*/
void FinishSpawningItem( gentity_t *ent ) {
	trace_t		tr;
	vec3_t		dest;

	VectorSet( ent->r.mins, -ITEM_RADIUS, -ITEM_RADIUS, -ITEM_RADIUS );
	VectorSet( ent->r.maxs, ITEM_RADIUS, ITEM_RADIUS, ITEM_RADIUS );

	ent->s.eType = ET_ITEM;
	ent->s.modelindex = ent->item - bg_itemlist;		// store item number in modelindex
	ent->s.modelindex2 = 0; // zero indicates this isn't a dropped item

	ent->r.contents = CONTENTS_TRIGGER;
	ent->touch = Touch_Item;
	// useing an item causes it to respawn
	ent->use = Use_Item;

	if ( ent->spawnflags & 1 ) {
		// suspended
		G_SetOrigin( ent, ent->s.origin );
	} else {
		// drop to floor
		VectorSet( dest, ent->s.origin[0], ent->s.origin[1], ent->s.origin[2] - 4096 );
		trap_Trace( &tr, ent->s.origin, ent->r.mins, ent->r.maxs, dest, ent->s.number, MASK_SOLID );
		if ( tr.startsolid ) {
			G_Printf ("FinishSpawningItem: %s startsolid at %s\n", ent->classname, vtos(ent->s.origin));
			G_FreeEntity( ent );
			return;
		}

		// allow to ride movers
		ent->s.groundEntityNum = tr.entityNum;

		G_SetOrigin( ent, tr.endpos );
	}

	// team slaves and targeted items aren't present at start
	if ( ( ent->flags & FL_TEAMSLAVE ) || ent->targetname ) {
		ent->s.eFlags |= EF_NODRAW;
		ent->r.contents = 0;
		return;
	}

	// powerups don't spawn in for a while
	if (ent->item->giType == IT_POWERUP && g_gametype.integer != GT_EFH) {
		float	respawn;
		respawn = 45 + crandom() * 15;
		ent->s.eFlags |= EF_NODRAW;
		ent->r.contents = 0;
		ent->nextthink = level.time + respawn * 1000;
		ent->think = RespawnItem;
		return;
	}


	trap_LinkEntity (ent);
}

qboolean	itemRegistered[MAX_ITEMS];

/*
==================
G_CheckTeamItems
==================
*/
void G_CheckTeamItems( void ) {

	// Set up team stuff
	Team_InitGame();

	if( g_gametype.integer == GT_CTF ) {
		gitem_t	*item;

		// check for the two flags
		item = BG_FindItem( "Red Flag" );
		if ( !item || !itemRegistered[ item - bg_itemlist ] ) {
			G_Printf( S_COLOR_YELLOW "WARNING: No team_CTF_redflag in map" );
		}
		item = BG_FindItem( "Blue Flag" );
		if ( !item || !itemRegistered[ item - bg_itemlist ] ) {
			G_Printf( S_COLOR_YELLOW "WARNING: No team_CTF_blueflag in map" );
		}
	}
}

/*
==============
ClearRegisteredItems
==============
*/
void ClearRegisteredItems( void ) {
	memset( itemRegistered, 0, sizeof( itemRegistered ) );

    // JUHOX: don't load items for lens flare editor
	if (g_editmode.integer == EM_mlf) return;

	// players always start with the base weapon

	RegisterItem(BG_FindItem("5 Health"));
	RegisterItem(BG_FindItem("Armor Shard"));
	if (g_armorFragments.integer) {
		RegisterItem(BG_FindItem("Armor Fragment 5"));
		//RegisterItem(BG_FindItem("Armor Fragment 25"));
	}
	RegisterItem(BG_FindItemForWeapon(WP_GAUNTLET));
	RegisterItem(BG_FindItemForWeapon(WP_MACHINEGUN));
	RegisterItem(BG_FindItemForWeapon(WP_SHOTGUN));
	RegisterItem(BG_FindItemForWeapon(WP_GRENADE_LAUNCHER));
	RegisterItem(BG_FindItemForWeapon(WP_ROCKET_LAUNCHER));
	RegisterItem(BG_FindItemForWeapon(WP_LIGHTNING));
	RegisterItem(BG_FindItemForWeapon(WP_RAILGUN));
	RegisterItem(BG_FindItemForWeapon(WP_PLASMAGUN));
	RegisterItem(BG_FindItemForWeapon(WP_BFG));

	if ( g_gametype.integer != GT_EFH && g_grapple.integer > HM_disabled &&	g_grapple.integer < HM_num_modes ) {
		RegisterItem(BG_FindItemForWeapon(WP_GRAPPLING_HOOK));
	}

	if (g_respawnAtPOD.integer && g_gametype.integer == GT_CTF) {
		RegisterItem(BG_FindItem("POD marker"));
	}

	// JUHOX: register artefact item
	if (g_gametype.integer == GT_STU) {
		RegisterItem(BG_FindItem("Artefact"));
	}
	else if (g_gametype.integer < GT_STU && g_monsterLauncher.integer) {
		RegisterItem(BG_FindItemForWeapon(WP_MONSTER_LAUNCHER));
	}
}

/*
===============
RegisterItem

The item will be added to the precache list
===============
*/
void RegisterItem( gitem_t *item ) {
	if ( !item ) {
		G_Error( "RegisterItem: NULL" );
	}
	itemRegistered[ item - bg_itemlist ] = qtrue;
}


/*
===============
SaveRegisteredItems

Write the needed items to a config string
so the client will know which ones to precache
===============
*/
void SaveRegisteredItems( void ) {
	char	string[MAX_ITEMS+1];
	int		i;
	int		count;

	count = 0;
	for ( i = 0 ; i < bg_numItems ; i++ ) {
		if ( itemRegistered[i] ) {
			count++;
			string[i] = '1';
		} else {
			string[i] = '0';
		}
	}
	string[ bg_numItems ] = 0;

	G_Printf( "%i items registered\n", count );
	trap_SetConfigstring(CS_ITEMS, string);
}

/*
============
G_ItemDisabled
============
*/
int G_ItemDisabled( gitem_t *item ) {

	char name[128];

	Com_sprintf(name, sizeof(name), "disable_%s", item->classname);
	return trap_Cvar_VariableIntegerValue( name );
}

/*
============
G_SpawnItem

Sets the clipping size and plants the object on the floor.

Items can't be immediately dropped to floor, because they might
be on an entity that hasn't spawned yet.
============
*/
void G_SpawnItem (gentity_t *ent, gitem_t *item) {
	G_SpawnFloat( "random", "0", &ent->random );
	G_SpawnFloat( "wait", "0", &ent->wait );

	RegisterItem( item );
	if ( G_ItemDisabled(item) )
		return;

	ent->item = item;
	// some movers spawn on the second frame, so delay item
	// spawns until the third frame so they can ride trains
	ent->nextthink = level.time + FRAMETIME * 2;
	ent->think = FinishSpawningItem;

	ent->physicsBounce = 0.50;		// items are bouncy

	if ( item->giType == IT_POWERUP ) {
		G_SoundIndex( "sound/items/poweruprespawn.wav" );
		G_SpawnFloat( "noglobalsound", "0", &ent->speed);
	}

	// JUHOX: finish item spawning for EFH
	if (g_gametype.integer == GT_EFH) {
		FinishSpawningItem(ent);
		G_SetOrigin(ent, ent->s.origin);
	}
	ent->entClass = GEC_item;
}


/*
================
JUHOX: G_PODMarkerRotation
================
*/
#define PODMARKER_MINSPIN 180.0
#define PODMARKER_MAXSPIN 4000.0
static void G_PODMarkerRotation(gentity_t* ent) {
	vec3_t angles;

	BG_EvaluateTrajectory(&ent->s.apos, level.time, angles);
	VectorCopy(angles, ent->s.apos.trBase);
	ent->s.apos.trTime = level.time;

	if (level.time >= ent->s.time) {
		ent->s.apos.trDelta[YAW] = PODMARKER_MAXSPIN;
	}
	else if (level.time < ent->s.time - 10000) {
		ent->s.apos.trDelta[YAW] = PODMARKER_MINSPIN;
	}
	else {
		ent->s.apos.trDelta[YAW] =
			PODMARKER_MAXSPIN -
			(PODMARKER_MAXSPIN - PODMARKER_MINSPIN) * (ent->s.time - level.time) / 10000.0;
	}
}

/*
================
JUHOX: G_BounceItemRotation
================
*/
void G_BounceItemRotation(gentity_t* ent) {
	float maxSpeed;
	vec3_t angles;

	BG_EvaluateTrajectory(&ent->s.apos, level.time, angles);
	VectorCopy(angles, ent->s.apos.trBase);
	ent->s.apos.trTime = level.time;

	maxSpeed = VectorLength(ent->s.pos.trDelta) * 20;

	ent->s.apos.trDelta[0] = maxSpeed * crandom() * random();
	ent->s.apos.trDelta[1] = maxSpeed * crandom() * random();
	ent->s.apos.trDelta[2] = maxSpeed * crandom() * random();

	ent->s.apos.trType = TR_LINEAR;
	ent->s.apos.trDuration = 0;
}

/*
================
G_BounceItem

================
*/
void G_BounceItem( gentity_t *ent, trace_t *trace ) {
	vec3_t	velocity;
	float	dot;
	int		hitTime;
	qboolean armorFragment;	// JUHOX
	float sqrspeed;	// JUHOX

	armorFragment = (ent->item && ent->item->giType == IT_ARMOR && ent->item->giTag);	// JUHOX

	// reflect the velocity on the trace plane
	hitTime = level.previousTime + ( level.time - level.previousTime ) * trace->fraction;
	BG_EvaluateTrajectoryDelta( &ent->s.pos, hitTime, velocity );
	dot = DotProduct( velocity, trace->plane.normal );
	VectorMA( velocity, -2*dot, trace->plane.normal, ent->s.pos.trDelta );

	// cut the velocity to keep from bouncing forever
	VectorScale( ent->s.pos.trDelta, ent->physicsBounce, ent->s.pos.trDelta );

	sqrspeed = VectorLengthSquared(ent->s.pos.trDelta);	// JUHOX

	// JUHOX: bouncing armor fragment
	if (armorFragment) {
		G_BounceItemRotation(ent);
		if (sqrspeed >= 160*160) {
			G_AddEvent(ent, EV_BOUNCE_ARMOR, 0);
		}
		else if (sqrspeed >= 80*80) {
			G_AddEvent(ent, EV_BOUNCE_ARMOR, 1);
		}
		else if (sqrspeed >= 40*40) {
			G_AddEvent(ent, EV_BOUNCE_ARMOR, 2);
		}
	}

	// check for stop
	// JUHOX BUGFIX: check like in G_BounceMissile() (the VectorLength() call is the important thing, I think)

	if (trace->plane.normal[2] > 0.2 && sqrspeed < 40*40) {

		// JUHOX: stop armor fragment rotation
		if (armorFragment) {
			vec3_t angles;
			//float pitch;

			ent->s.apos.trType = TR_STATIONARY;

			// JUHOX: the following depends on code in CG_Item() [cg_ents.c]
			BG_EvaluateTrajectory(&ent->s.apos, level.time, angles);
			ent->s.apos.trDelta[YAW] = angles[YAW];
			VectorCopy(trace->plane.normal, ent->s.apos.trBase);
		}

		trace->endpos[2] += 1.0;	// make sure it is off ground
		SnapVector( trace->endpos );
		G_SetOrigin( ent, trace->endpos );
		ent->s.groundEntityNum = trace->entityNum;
		return;
	}

	VectorAdd( ent->r.currentOrigin, trace->plane.normal, ent->r.currentOrigin);
	VectorCopy( ent->r.currentOrigin, ent->s.pos.trBase );
	ent->s.pos.trTime = level.time;
}


/*
================
G_RunItem

================
*/
// JUHOX NOTE: G_RunItem() is also called for corpses
void G_RunItem( gentity_t *ent ) {
	vec3_t		origin;
	trace_t		tr;
	int			contents;
	int			mask;
	static vec3_t mins = {-8,-8,-8};	// JUHOX
	static vec3_t maxs = {8,8,8};		// JUHOX

	// JUHOX: POD markers do not much
	if (ent->item && ent->item->giType == IT_POD_MARKER) {
		G_PODMarkerRotation(ent);
		return;
	}

	// if groundentity has been set to -1, it may have been pushed off an edge
	if ( ent->s.groundEntityNum == -1 ) {
		if ( ent->s.pos.trType != TR_GRAVITY ) {
			ent->s.pos.trType = TR_GRAVITY;
			ent->s.pos.trTime = level.time;
		}
	}

	if ( ent->s.pos.trType == TR_STATIONARY ) {
		// check think function
		G_RunThink( ent );
		return;
	}

	// get current position
	BG_EvaluateTrajectory( &ent->s.pos, level.time, origin );

	// JUHOX: corpse sinking into ground
	if (ent->s.pos.trType == TR_LINEAR_STOP) {
		if (level.time - ent->s.pos.trTime < 3000) {
			VectorCopy(origin, ent->r.currentOrigin);
			trap_LinkEntity(ent);
		}
		else if (ent->r.contents) {
			ent->r.contents = 0;
			trap_LinkEntity(ent);
		}
		G_RunThink(ent);
		return;
	}


	// trace a line from the previous position to the current position
	if ( ent->clipmask ) {
		mask = ent->clipmask;
	} else {
		mask = MASK_PLAYERSOLID & ~CONTENTS_BODY;//MASK_SOLID;
	}
	// JUHOX: use smaller mins & maxs for fragment movement
	if (ent->item && ent->item->giType == IT_ARMOR && ent->item->giTag) {
		trap_Trace(&tr, ent->r.currentOrigin, mins, maxs, origin, ent->r.ownerNum, mask);
	}
	else {
		trap_Trace(&tr, ent->r.currentOrigin, ent->r.mins, ent->r.maxs, origin, ent->r.ownerNum, mask);
	}


	// JUHOX: do item movement like missile movement [G_RunMissile()]
	if ( tr.startsolid || tr.allsolid ) {
		vec3_t normal;

		VectorCopy(tr.plane.normal, normal);

		// make sure the tr.entityNum is set to the entity we're stuck in
		trap_Trace( &tr, ent->r.currentOrigin, ent->r.mins, ent->r.maxs, ent->r.currentOrigin, ent->r.ownerNum, mask );

		tr.fraction = 1;
		tr.endpos[2] += 1.0;	// make sure it is off ground
		SnapVector(tr.endpos);
		G_SetOrigin(ent, tr.endpos);
		ent->s.groundEntityNum = tr.entityNum;
		if (ent->item && ent->item->giType == IT_ARMOR && ent->item->giTag) {
			vec3_t angles;

			// stop armor fragment rotation
			ent->s.apos.trType = TR_STATIONARY;

			// JUHOX: the following depends on code in CG_Item() [cg_ents.c]
			BG_EvaluateTrajectory(&ent->s.apos, level.time, angles);
			ent->s.apos.trDelta[YAW] = angles[YAW];
			VectorCopy(normal, ent->s.apos.trBase);
		}
	}
	else {
		VectorCopy(tr.endpos, ent->r.currentOrigin);
	}


	trap_LinkEntity( ent );	// FIXME: avoid this for stationary?

	// check think function
	G_RunThink( ent );

	if ( tr.fraction == 1 ) {
		return;
	}

	// if it is in a nodrop volume, remove it
	contents = trap_PointContents( ent->r.currentOrigin, -1 );
	if ( contents & CONTENTS_NODROP ) {
		if (ent->item && ent->item->giType == IT_TEAM) {
			Team_FreeEntity(ent);
		} else {
			G_FreeEntity( ent );
		}
		return;
	}

	G_BounceItem( ent, &tr );
}

