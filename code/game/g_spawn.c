// Copyright (C) 1999-2000 Id Software, Inc.
//

#include "g_local.h"

// JUHOX: variables & definitions for EFH
#define MAX_ENTITY_TEMPLATES		4096
#define MAX_SEGMENTTYPES			256
#define MAX_ENTITIES_PER_SEGMENT	64
#define MAX_WORLD_SEGMENTS			65536
#define MAX_CACHED_MONSTERS			1024
#define MAX_VIEWDISTANCE			3000
#define MAX_WAYPOINTS				16
#define MAX_STYLES					100
#define STYLE_NAME_MAX_SIZE			32
#define MAX_PARALLEL_STYLES			10
#define MAX_FINALIZATION_SUCCESSORS	32

typedef struct {
	int count;
	vec3_t origin;
} efhWaypoint_t;
typedef enum {
	REACH_unreachable,
	REACH_reachable,
	REACH_loopable
} REACHABILITY;
typedef struct {
	int minStepsToFinalSegment;
	qboolean visited;	// temporarily used
	REACHABILITY reachability;
	char name[STYLE_NAME_MAX_SIZE];
} efhTransitionStyle_t;
typedef struct {
	efhTransitionStyle_t* entrance;
	efhTransitionStyle_t* exit;
	float frequency;
} efhStyleEntry_t;
typedef struct efhSegmentType_s {
	int numEntities;
	int entityTemplateIndex[MAX_ENTITIES_PER_SEGMENT];
	int numWayPoints;
	efhWaypoint_t wayPoints[MAX_WAYPOINTS];
	unsigned long wayLength;
	qboolean entranceSet;
	vec3_t entranceOrigin;
	qboolean exitSet;
	vec3_t exitOrigin;
	qboolean final;
	qboolean initial;
	qboolean visBlocking;
	efhVector_t exitDelta;
	const gentity_t* goalTemplate;
	vec3_t absmin;
	vec3_t absmax;
	vec3_t boundingMin;
	vec3_t boundingMax;
	char* name;
	int idnum;
	efhStyleEntry_t styles[MAX_PARALLEL_STYLES];
	qboolean frustrating;
} efhSegmentType_t;
typedef struct {
	int sourceSegment;	// index in efhWorld, -1 if unused
	int sourceEntity;	// index in entityTemplates
	int index;
	int currentSegment;	// index in efhWorld, -1 if spawned
	efhVector_t position;
	vec3_t angles;
	monsterspawnmode_t spawnmode;
	monsterType_t type;
	int maxHealth;
	monsterAction_t action;
} efhCachedMonster_t;
typedef enum {
	ESS_removed,
	ESS_solidPartSpawned,
	ESS_spawned
} efhSegmentState_t;
typedef enum {
	ESC_spawnCompletely,
	ESC_spawnSolidOnly,
	ESC_spawnNonSolidOnly
} efhSpawnCommand_t;

static vec3_t efhSpaceMins;
static vec3_t efhSpaceMaxs;

static int numEntityTemplates;
static gentity_t entityTemplates[MAX_ENTITY_TEMPLATES];

static int numSegmentTypes;
static efhSegmentType_t segmentTypes[MAX_SEGMENTTYPES+1];

static int debugModeChoosenSegmentType;
static int debugSegment;
static int oldDebugSegment;

static efhSegmentType_t* efhWorld[MAX_WORLD_SEGMENTS];
static unsigned long totalWayLength[MAX_WORLD_SEGMENTS];
static unsigned char segmentState[MAX_WORLD_SEGMENTS];		// efhSegmentState_t
static unsigned char newSegmentState[MAX_WORLD_SEGMENTS];	// efhSegmentState_t
static unsigned char visitedSegments[MAX_WORLD_SEGMENTS/8];	// bit flags
static int numFallbacks;

static int currentSegment;
static efhVector_t currentSegmentOrigin;
static int maxSegment;

static efhCachedMonster_t cachedMonsters[MAX_CACHED_MONSTERS];

static int numTransitionStyles;
static efhTransitionStyle_t transitionStyles[MAX_STYLES];

static efhTransitionStyle_t* worldStyle;
static unsigned long worldWayLength;
static int worldEnd;
static localseed_t worldCreationSeed;

static unsigned long monsterSpawnSeed;


qboolean	G_SpawnString( const char *key, const char *defaultString, char **out ) {
	int		i;

	if ( !level.spawning ) {
		*out = (char *)defaultString;
	}

	for ( i = 0 ; i < level.numSpawnVars ; i++ ) {
		if ( !Q_stricmp( key, level.spawnVars[i][0] ) ) {
			*out = level.spawnVars[i][1];
			return qtrue;
		}
	}

	*out = (char *)defaultString;
	return qfalse;
}

qboolean	G_SpawnFloat( const char *key, const char *defaultString, float *out ) {
	char		*s;
	qboolean	present;

	present = G_SpawnString( key, defaultString, &s );
	*out = atof( s );
	return present;
}

qboolean	G_SpawnInt( const char *key, const char *defaultString, int *out ) {
	char		*s;
	qboolean	present;

	present = G_SpawnString( key, defaultString, &s );
	*out = atoi( s );
	return present;
}

qboolean	G_SpawnVector( const char *key, const char *defaultString, float *out ) {
	char		*s;
	qboolean	present;

	present = G_SpawnString( key, defaultString, &s );
	sscanf( s, "%f %f %f", &out[0], &out[1], &out[2] );
	return present;
}



//
// fields are needed for spawning from the entity string
//
typedef enum {
	F_INT,
	F_FLOAT,
	F_LSTRING,			// string on disk, pointer in memory, TAG_LEVEL
	F_GSTRING,			// string on disk, pointer in memory, TAG_GAME
	F_VECTOR,
	F_ANGLEHACK,
	F_ENTITY,			// index on disk, pointer in memory
	F_ITEM,				// index on disk, pointer in memory
	F_CLIENT,			// index on disk, pointer in memory
	F_IGNORE
} fieldtype_t;

typedef struct
{
	char	*name;
	int		ofs;
	fieldtype_t	type;
	int		flags;
} field_t;

field_t fields[] = {
	{"classname", FOFS(classname), F_LSTRING},
	{"origin", FOFS(s.origin), F_VECTOR},
	{"model", FOFS(model), F_LSTRING},
	{"model2", FOFS(model2), F_LSTRING},
	{"spawnflags", FOFS(spawnflags), F_INT},
	{"speed", FOFS(speed), F_FLOAT},
	{"target", FOFS(target), F_LSTRING},
	{"targetname", FOFS(targetname), F_LSTRING},
	{"message", FOFS(message), F_LSTRING},
	{"team", FOFS(team), F_LSTRING},
	{"wait", FOFS(wait), F_FLOAT},
	{"random", FOFS(random), F_FLOAT},
	{"count", FOFS(count), F_INT},
	{"health", FOFS(health), F_INT},
	{"light", 0, F_IGNORE},
	{"dmg", FOFS(damage), F_INT},
	{"angles", FOFS(s.angles), F_VECTOR},
	{"angle", FOFS(s.angles), F_ANGLEHACK},
	{"targetShaderName", FOFS(targetShaderName), F_LSTRING},
	{"targetShaderNewName", FOFS(targetShaderNewName), F_LSTRING},
	{"idnum", FOFS(idnum), F_INT},	// JUHOX

	{NULL}
};


typedef struct {
	char	*name;
	void	(*spawn)(gentity_t *ent);
} spawn_t;

void SP_info_player_start (gentity_t *ent);
void SP_info_player_deathmatch (gentity_t *ent);
void SP_info_player_intermission (gentity_t *ent);
void SP_info_firstplace(gentity_t *ent);
void SP_info_secondplace(gentity_t *ent);
void SP_info_thirdplace(gentity_t *ent);
void SP_info_podium(gentity_t *ent);

void SP_func_plat (gentity_t *ent);
void SP_func_static (gentity_t *ent);
void SP_func_rotating (gentity_t *ent);
void SP_func_bobbing (gentity_t *ent);
void SP_func_pendulum( gentity_t *ent );
void SP_func_button (gentity_t *ent);
void SP_func_door (gentity_t *ent);
void SP_func_train (gentity_t *ent);
void SP_func_timer (gentity_t *self);

void SP_trigger_always (gentity_t *ent);
void SP_trigger_multiple (gentity_t *ent);
void SP_trigger_push (gentity_t *ent);
void SP_trigger_teleport (gentity_t *ent);
void SP_trigger_hurt (gentity_t *ent);

void SP_target_remove_powerups( gentity_t *ent );
void SP_target_give (gentity_t *ent);
void SP_target_delay (gentity_t *ent);
void SP_target_speaker (gentity_t *ent);
void SP_target_print (gentity_t *ent);
void SP_target_laser (gentity_t *self);
void SP_target_character (gentity_t *ent);
void SP_target_score( gentity_t *ent );
void SP_target_teleporter( gentity_t *ent );
void SP_target_relay (gentity_t *ent);
void SP_target_kill (gentity_t *ent);
void SP_target_position (gentity_t *ent);
void SP_target_location (gentity_t *ent);
void SP_target_push (gentity_t *ent);
void SP_target_earthquake(gentity_t* ent);	// JUHOX

void SP_light (gentity_t *self);
void SP_info_null (gentity_t *self);
void SP_info_notnull (gentity_t *self);
void SP_info_camp (gentity_t *self);
void SP_path_corner (gentity_t *self);

void SP_misc_teleporter_dest (gentity_t *self);
void SP_misc_model(gentity_t *ent);
void SP_misc_portal_camera(gentity_t *ent);
void SP_misc_portal_surface(gentity_t *ent);

void SP_shooter_rocket( gentity_t *ent );
void SP_shooter_plasma( gentity_t *ent );
void SP_shooter_grenade( gentity_t *ent );

void SP_team_CTF_redplayer( gentity_t *ent );
void SP_team_CTF_blueplayer( gentity_t *ent );

void SP_team_CTF_redspawn( gentity_t *ent );
void SP_team_CTF_bluespawn( gentity_t *ent );

void SP_item_botroam(gentity_t* ent) {
	if (g_gametype.integer == GT_EFH) {
		G_FreeEntity(ent);
		return;
	}
}


// JUHOX: prototypes for EFH spawn functions
static void SP_efh_hull(gentity_t* ent);
static void SP_efh_model(gentity_t* ent);
static void SP_efh_brush(gentity_t* ent);
static void SP_efh_null_brush(gentity_t* ent);
static void SP_efh_entrance(gentity_t* ent);
static void SP_efh_exit(gentity_t* ent);
static void SP_efh_monster(gentity_t* ent);
static void SP_efh_waypoint(gentity_t* ent);


spawn_t	spawns[] = {
	// info entities don't do anything at all, but provide positional
	// information for things controlled by other processes
	{"info_player_start", SP_info_player_start},
	{"info_player_deathmatch", SP_info_player_deathmatch},
	{"info_player_intermission", SP_info_player_intermission},
	{"info_null", SP_info_null},
	{"info_notnull", SP_info_notnull},		// use target_position instead
	{"info_camp", SP_info_camp},

	{"func_plat", SP_func_plat},
	{"func_button", SP_func_button},
	{"func_door", SP_func_door},
	{"func_static", SP_func_static},
	{"func_rotating", SP_func_rotating},
	{"func_bobbing", SP_func_bobbing},
	{"func_pendulum", SP_func_pendulum},
	{"func_train", SP_func_train},
	{"func_group", SP_info_null},
	{"func_timer", SP_func_timer},			// rename trigger_timer?

	// Triggers are brush objects that cause an effect when contacted
	// by a living player, usually involving firing targets.
	// While almost everything could be done with
	// a single trigger class and different targets, triggered effects
	// could not be client side predicted (push and teleport).
	{"trigger_always", SP_trigger_always},
	{"trigger_multiple", SP_trigger_multiple},
	{"trigger_push", SP_trigger_push},
	{"trigger_teleport", SP_trigger_teleport},
	{"trigger_hurt", SP_trigger_hurt},

	// targets perform no action by themselves, but must be triggered
	// by another entity
	{"target_give", SP_target_give},
	{"target_remove_powerups", SP_target_remove_powerups},
	{"target_delay", SP_target_delay},
	{"target_speaker", SP_target_speaker},
	{"target_print", SP_target_print},
	{"target_laser", SP_target_laser},
	{"target_score", SP_target_score},
	{"target_teleporter", SP_target_teleporter},
	{"target_relay", SP_target_relay},
	{"target_kill", SP_target_kill},
	{"target_position", SP_target_position},
	{"target_location", SP_target_location},
	{"target_push", SP_target_push},
	{"target_earthquake", SP_target_earthquake},

	{"light", SP_light},
	{"path_corner", SP_path_corner},

	{"misc_teleporter_dest", SP_misc_teleporter_dest},
	{"misc_model", SP_misc_model},
	{"misc_portal_surface", SP_misc_portal_surface},
	{"misc_portal_camera", SP_misc_portal_camera},

	{"shooter_rocket", SP_shooter_rocket},
	{"shooter_grenade", SP_shooter_grenade},
	{"shooter_plasma", SP_shooter_plasma},

	{"team_CTF_redplayer", SP_team_CTF_redplayer},
	{"team_CTF_blueplayer", SP_team_CTF_blueplayer},

	{"team_CTF_redspawn", SP_team_CTF_redspawn},
	{"team_CTF_bluespawn", SP_team_CTF_bluespawn},

	{"item_botroam", SP_item_botroam},

	// JUHOX: EFH spawn functions
	{"efh_hull", SP_efh_hull},
	{"efh_model", SP_efh_model},
	{"efh_brush", SP_efh_brush},
	{"efh_null_brush", SP_efh_null_brush},
	{"efh_entrance", SP_efh_entrance},
	{"efh_exit", SP_efh_exit},
	{"efh_monster", SP_efh_monster},
	{"efh_waypoint", SP_efh_waypoint},

	{0, 0}
};

/*
===============
JUHOX: AddEmergencySpawnPoint
===============
*/
static void AddEmergencySpawnPoint(const vec3_t origin) {
	vec3_t pos;

	if (g_gametype.integer == GT_EFH) return;	// JUHOX
	if (level.numEmergencySpawnPoints >= MAX_GENTITIES) return;

	VectorCopy(origin, pos);
	VectorCopy(pos, level.emergencySpawnPoints[level.numEmergencySpawnPoints]);
	level.numEmergencySpawnPoints++;
}

/*
===============
G_CallSpawn

Finds the spawn function for the entity and calls it,
returning qfalse if not found
===============
*/
qboolean G_CallSpawn( gentity_t *ent ) {
	spawn_t	*s;
	gitem_t	*item;

	if ( !ent->classname ) {
		G_Printf ("G_CallSpawn: NULL classname\n");
		return qfalse;
	}

	// check item spawn functions
	for ( item=bg_itemlist+1 ; item->classname ; item++ ) {
		if ( !strcmp(item->classname, ent->classname) ) {
			AddEmergencySpawnPoint(ent->s.origin);	// JUHOX
            // JUHOX: no flags in non-ctf games (we're able to load all maps now!)
			if ( item->giType == IT_TEAM &&	NOT ( g_gametype.integer == GT_CTF || (	g_gametype.integer == GT_EFH &&	item->giTag == PW_BLUEFLAG ) ) ) {
				return qfalse;
			}

			if (g_editmode.integer == EM_mlf) {
				// don't remove, otherwise movers could change their entity number
				ent->s.eType = ET_INVISIBLE;
				return qtrue;
			}

            // JUHOX: check for no-items option
			if (g_noItems.integer && item->giType != IT_TEAM) return qfalse;

            // JUHOX: item replacement
			if (g_gametype.integer == GT_EFH) {
				// no replacement
			}
			else if (item->giType == IT_POWERUP) {
				item = BG_FindItemForPowerup(PW_REGEN);
				if (!item) return qfalse;	// should not happen
			}
			else if (item->giType == IT_WEAPON) {
				switch (item->giTag) {
				case WP_GAUNTLET:
				case WP_MACHINEGUN:
					item = BG_FindItem("5 Health");
					break;
				case WP_SHOTGUN:
					item = BG_FindItem("25 Health");
					break;
				case WP_GRENADE_LAUNCHER:
				case WP_LIGHTNING:
				case WP_RAILGUN:
					item = BG_FindItem("Armor");
					break;
				case WP_ROCKET_LAUNCHER:
				case WP_PLASMAGUN:
					item = BG_FindItem("50 Health");
					break;
				case WP_BFG:
					item = BG_FindItem("Mega Health");
					break;
				default:
					return qfalse;
				}
				if (!item) return qfalse;
			}
			else if (item->giType == IT_AMMO) {
				switch (item->giTag) {
				case WP_GAUNTLET:
				case WP_MACHINEGUN:
				case WP_SHOTGUN:
					item = BG_FindItem("5 Health");
					break;
				case WP_LIGHTNING:
				case WP_RAILGUN:
					item = BG_FindItem("50 Health");
					break;
				case WP_GRENADE_LAUNCHER:
				case WP_ROCKET_LAUNCHER:
				case WP_PLASMAGUN:
					item = BG_FindItem("25 Health");
					break;
				case WP_BFG:
					item = BG_FindItem("Heavy Armor");
					break;
				default:
					return qfalse;
				}
				if (!item) return qfalse;
			}

			G_SpawnItem( ent, item );
			return qtrue;
		}
	}

	// check normal spawn functions
	for ( s=spawns ; s->name ; s++ ) {
		if ( !strcmp(s->name, ent->classname) ) {
			// found it
			s->spawn(ent);
			return qtrue;
		}
	}
	G_Printf ("%s doesn't have a spawn function\n", ent->classname);
	return qfalse;
}

/*
=============
G_NewString

Builds a copy of the string, translating \n to real linefeeds
so message texts can be multi-line
=============
*/
char *G_NewString( const char *string ) {
	char	*newb, *new_p;
	int		i,l;

	l = strlen(string) + 1;

	newb = G_Alloc( l );

	new_p = newb;

	// turn \n into a real linefeed
	for ( i=0 ; i< l ; i++ ) {
		if (string[i] == '\\' && i < l-1) {
			i++;
			if (string[i] == 'n') {
				*new_p++ = '\n';
			} else {
				*new_p++ = '\\';
			}
		} else {
			*new_p++ = string[i];
		}
	}

	return newb;
}




/*
===============
G_ParseField

Takes a key/value pair and sets the binary values
in a gentity
===============
*/
void G_ParseField( const char *key, const char *value, gentity_t *ent ) {
	field_t	*f;
	byte	*b;
	float	v;
	vec3_t	vec;

	for ( f=fields ; f->name ; f++ ) {
		if ( !Q_stricmp(f->name, key) ) {
			// found it
			b = (byte *)ent;

			switch( f->type ) {
			case F_LSTRING:
				*(char **)(b+f->ofs) = G_NewString (value);
				break;
			case F_VECTOR:
				sscanf (value, "%f %f %f", &vec[0], &vec[1], &vec[2]);
				((float *)(b+f->ofs))[0] = vec[0];
				((float *)(b+f->ofs))[1] = vec[1];
				((float *)(b+f->ofs))[2] = vec[2];
				break;
			case F_INT:
				*(int *)(b+f->ofs) = atoi(value);
				break;
			case F_FLOAT:
				*(float *)(b+f->ofs) = atof(value);
				break;
			case F_ANGLEHACK:
				v = atof(value);
				((float *)(b+f->ofs))[0] = 0;
				((float *)(b+f->ofs))[1] = v;
				((float *)(b+f->ofs))[2] = 0;
				break;
			default:
			case F_IGNORE:
				break;
			}
			return;
		}
	}
}




/*
===================
G_SpawnGEntityFromSpawnVars

Spawn an entity and fill in all of the level fields from
level.spawnVars[], then call the class specfic spawn function
===================
*/
void G_SpawnGEntityFromSpawnVars( void ) {
	int			i;
	gentity_t	*ent;
	char		*s, *value, *gametypeName;

	static char *gametypeNames[] = { "ffa", "tournament", "single", "team", "ctf", "oneflag", "obelisk", "harvester", "stu", "efh" };

	// get the next free entity
	ent = G_Spawn();

	for ( i = 0 ; i < level.numSpawnVars ; i++ ) {
		G_ParseField( level.spawnVars[i][0], level.spawnVars[i][1], ent );
	}

	// JUHOX: introducing non-solid movers
	G_SpawnInt("nonsolid", "0", &i);
	if (i) {
		ent->flags |= FL_NON_SOLID;
	}

	// check for "notsingle" flag
	if ( g_gametype.integer == GT_SINGLE_PLAYER ) {
		G_SpawnInt( "notsingle", "0", &i );
		if ( i ) {
			G_FreeEntity( ent );
			return;
		}
	}
	// check for "notteam" flag (GT_FFA, GT_TOURNAMENT, GT_SINGLE_PLAYER)
	if ( g_gametype.integer >= GT_TEAM ) {
		G_SpawnInt( "notteam", "0", &i );
		if ( i ) {
			G_FreeEntity( ent );
			return;
		}
	} else {
		G_SpawnInt( "notfree", "0", &i );
		if ( i ) {
			G_FreeEntity( ent );
			return;
		}
	}

	G_SpawnInt( "notq3a", "0", &i );
	if ( i ) {
		G_FreeEntity( ent );
		return;
	}

	if( G_SpawnString( "gametype", NULL, &value ) ) {
		if( g_gametype.integer >= GT_FFA && g_gametype.integer < GT_MAX_GAME_TYPE ) {
			gametypeName = gametypeNames[g_gametype.integer];

			s = strstr( value, gametypeName );
			if( !s ) {
				G_FreeEntity( ent );
				return;
			}
		}
	}

	// move editor origin to pos
	VectorCopy( ent->s.origin, ent->s.pos.trBase );
	VectorCopy( ent->s.origin, ent->r.currentOrigin );

	// if we didn't get a classname, don't bother spawning anything
	if ( !G_CallSpawn( ent ) ) {
		G_FreeEntity( ent );
	}

	// JUHOX: in EFH, add the entity to the list of templates
	if (ent->inuse && g_gametype.integer == GT_EFH) {
		if (numEntityTemplates < MAX_ENTITY_TEMPLATES) {
			qboolean linked;
			gentity_t* entTemplate;

			linked = ent->r.linked;
			if (linked) {
				vec3_t v;

				VectorAdd(ent->r.mins, ent->r.maxs, v);
				VectorMA(ent->r.currentOrigin, 0.5, v, ent->sourceLocation);
			}
			else {
				VectorCopy(ent->s.origin, ent->sourceLocation);
			}
			trap_UnlinkEntity(ent);

			entTemplate = &entityTemplates[numEntityTemplates];
			numEntityTemplates++;

			memcpy(entTemplate, ent, sizeof(gentity_t));
			entTemplate->r.linked = linked;
		}
		G_FreeEntity(ent);
	}
}



/*
====================
G_AddSpawnVarToken
====================
*/
char *G_AddSpawnVarToken( const char *string ) {
	int		l;
	char	*dest;

	l = strlen( string );
	if ( level.numSpawnVarChars + l + 1 > MAX_SPAWN_VARS_CHARS ) {
		G_Error( "G_AddSpawnVarToken: MAX_SPAWN_CHARS" );
	}

	dest = level.spawnVarChars + level.numSpawnVarChars;
	memcpy( dest, string, l+1 );

	level.numSpawnVarChars += l + 1;

	return dest;
}

/*
====================
G_ParseSpawnVars

Parses a brace bounded set of key / value pairs out of the
level's entity strings into level.spawnVars[]

This does not actually spawn an entity.
====================
*/
qboolean G_ParseSpawnVars( void ) {
	char		keyname[MAX_TOKEN_CHARS];
	char		com_token[MAX_TOKEN_CHARS];

	level.numSpawnVars = 0;
	level.numSpawnVarChars = 0;

	// parse the opening brace
	if ( !trap_GetEntityToken( com_token, sizeof( com_token ) ) ) {
		// end of spawn string
		return qfalse;
	}
	if ( com_token[0] != '{' ) {
		G_Error( "G_ParseSpawnVars: found %s when expecting {",com_token );
	}

	// go through all the key / value pairs
	while ( 1 ) {
		// parse key
		if ( !trap_GetEntityToken( keyname, sizeof( keyname ) ) ) {
			G_Error( "G_ParseSpawnVars: EOF without closing brace" );
		}

		if ( keyname[0] == '}' ) {
			break;
		}

		// parse value
		if ( !trap_GetEntityToken( com_token, sizeof( com_token ) ) ) {
			G_Error( "G_ParseSpawnVars: EOF without closing brace" );
		}

		if ( com_token[0] == '}' ) {
			G_Error( "G_ParseSpawnVars: closing brace without data" );
		}
		if ( level.numSpawnVars == MAX_SPAWN_VARS ) {
			G_Error( "G_ParseSpawnVars: MAX_SPAWN_VARS" );
		}
		level.spawnVars[ level.numSpawnVars ][0] = G_AddSpawnVarToken( keyname );
		level.spawnVars[ level.numSpawnVars ][1] = G_AddSpawnVarToken( com_token );
		level.numSpawnVars++;
	}

	return qtrue;
}



/*QUAKED worldspawn (0 0 0) ?

Every map should have exactly one worldspawn.
"music"		music wav file
"gravity"	800 is default gravity
"message"	Text to print during connection process
*/
void SP_worldspawn( void ) {
	char	*s;
	char buf[16];	// JUHOX

	G_SpawnString( "classname", "", &s );
	if ( Q_stricmp( s, "worldspawn" ) ) {
		G_Error( "SP_worldspawn: The first entity isn't 'worldspawn'" );
	}

	// make some data visible to connecting client
	trap_SetConfigstring( CS_GAME_VERSION, GAME_VERSION );

	trap_SetConfigstring( CS_LEVEL_START_TIME, va("%i", level.startTime ) );

	G_SpawnString( "music", "", &s );
	trap_SetConfigstring( CS_MUSIC, s );

	G_SpawnString( "message", "", &s );
	trap_SetConfigstring( CS_MESSAGE, s );				// map specific message

#if 1	// JUHOX: send name of nearbox shader to clients
	G_SpawnString("nearbox", "", &s);
	trap_SetConfigstring(CS_NEARBOX, s);
#endif

	trap_SetConfigstring( CS_MOTD, g_motd.string );		// message of the day

	G_SpawnString( "gravity", "800", &s );
#if 1	// JUHOX: if set, get the gravity from g_gravityLatch
	trap_Cvar_VariableStringBuffer("g_gravityLatch", buf, sizeof(buf));
	trap_Cvar_Set("g_gravityLatch", "");
	if (buf[0]) s = buf;
#endif
	trap_Cvar_Set( "g_gravity", s );

	G_SpawnString( "enableDust", "0", &s );
	trap_Cvar_Set( "g_enableDust", s );

	G_SpawnString( "enableBreath", "0", &s );
	trap_Cvar_Set( "g_enableBreath", s );

	g_entities[ENTITYNUM_WORLD].s.number = ENTITYNUM_WORLD;
	g_entities[ENTITYNUM_WORLD].classname = "worldspawn";

	// see if we want a warmup time
	trap_SetConfigstring( CS_WARMUP, "" );
	if ( g_restarted.integer ) {
		trap_Cvar_Set( "g_restarted", "0" );
		level.warmupTime = 0;
	} else if ( g_doWarmup.integer ) { // Turn it on
		level.warmupTime = -1;
		trap_SetConfigstring( CS_WARMUP, va("%i", level.warmupTime) );
		G_LogPrintf( "Warmup:\n" );
	}

}


/*
==============
JUHOX: SegmentName
==============
*/
static char* SegmentName(const efhSegmentType_t* segType) {
	static char buf[256];

	Com_sprintf(
		buf, sizeof(buf), "'%s' @ (%d,%d,%d)",
		segType->name,
		(int) (0.5 * (segType->absmin[0] + segType->absmax[0])),
		(int) (0.5 * (segType->absmin[1] + segType->absmax[1])),
		(int) (0.5 * (segType->absmin[2] + segType->absmax[2]))
	);
	return buf;
}


/*
==============
JUHOX: MapOriginToWorldOrigin
==============
*/
static void MapOriginToWorldOrigin(const vec3_t mapOrigin, efhVector_t* worldOrigin) {
	worldOrigin->x = (long) (level.referenceOrigin.x + mapOrigin[0]);
	worldOrigin->y = (long) (level.referenceOrigin.y + mapOrigin[1]);
	worldOrigin->z = (long) (level.referenceOrigin.z + mapOrigin[2]);
}


/*
==============
JUHOX: WorldOriginToMapOrigin
==============
*/
static void WorldOriginToMapOrigin(const efhVector_t* worldOrigin, vec3_t mapOrigin) {
	mapOrigin[0] = worldOrigin->x - level.referenceOrigin.x;
	mapOrigin[1] = worldOrigin->y - level.referenceOrigin.y;
	mapOrigin[2] = worldOrigin->z - level.referenceOrigin.z;
}


/*
==============
JUHOX: IsStyleEntryValid
==============
*/
static qboolean IsStyleEntryValid(const efhSegmentType_t* seg, const efhStyleEntry_t* styleEntry) {
	if (styleEntry->frequency <= 0) return qfalse;
	if (!styleEntry->entrance && !seg->initial) return qfalse;
	if (!styleEntry->exit && !seg->final) return qfalse;

	return qtrue;
}


/*
==============
JUHOX: AddWaypoint
==============
*/
static void AddWaypoint(const gentity_t* ent, efhSegmentType_t* seg) {
	int i;
	int k;

	if (seg->numWayPoints >= MAX_WAYPOINTS) {
		G_Error(
			"^1AddWaypoint: too many waypoints (>%d) for segment %s",
			MAX_WAYPOINTS, SegmentName(seg)
		);
		return;
	}

	for (i = 0; i < seg->numWayPoints; i++) {
		if (ent->count < seg->wayPoints[i].count) break;
		if (ent->count == seg->wayPoints[i].count) {
			G_Error(
				"^1AddWaypoint: duplicate waypoint count %d in segment %s",
				ent->count, SegmentName(seg)
			);
			return;
		}
	}

	for (k = seg->numWayPoints; k > i; k--) {
		seg->wayPoints[k] = seg->wayPoints[k-1];
	}
	seg->wayPoints[i].count = ent->count;
	VectorCopy(ent->s.origin, seg->wayPoints[i].origin);
	seg->numWayPoints++;
}


/*
==============
JUHOX: ComputeWayLength
==============
*/
static void ComputeWayLength(efhSegmentType_t* seg) {
	int i;
	vec3_t origin;
	float dist;
	float len;

	VectorCopy(seg->entranceOrigin, origin);
	len = 0;
	for (i = 0; i < seg->numWayPoints; i++) {
		dist = Distance(origin, seg->wayPoints[i].origin);
		if (dist < 10) {
			if (i > 0) {
				G_Error(
					"^1ComputeWayLength: waypoints #%d & #%d too near in segment %s",
					seg->wayPoints[i-1].count, seg->wayPoints[i].count, SegmentName(seg)
				);
			}
			else {
				G_Error(
					"^1ComputeWayLength: waypoint #%d too near to entrance in segment %s",
					seg->wayPoints[i].count, SegmentName(seg)
				);
			}
		}
		len += dist;
		VectorCopy(seg->wayPoints[i].origin, origin);
	}
	dist = Distance(origin, seg->exitOrigin);
	if (dist < 10) {
		if (i > 0) {
			G_Error(
				"^1ComputeWayLength: waypoint #%d too near to exit in segment %s",
				seg->wayPoints[i-1].count, SegmentName(seg)
			);
		}
		else {
			G_Error(
				"^1ComputeWayLength: entrance too near to exit in segment %s",
				SegmentName(seg)
			);
		}
	}
	len += dist;

	seg->wayLength = (unsigned long) len;
}


/*
==============
JUHOX: WayPoint
==============
*/
static void WayPoint(const efhSegmentType_t* seg, int n, vec3_t org) {
	if (n < 0) {
		VectorClear(org);
	}
	else if (n < seg->numWayPoints) {
		VectorSubtract(seg->wayPoints[n].origin, seg->entranceOrigin, org);
	}
	else {
		VectorSubtract(seg->exitOrigin, seg->entranceOrigin, org);
	}
}


/*
==============
JUHOX: SegmentWayLength
==============
*/
static unsigned long SegmentWayLength(
	const vec3_t origin, const efhSegmentType_t* seg, const efhVector_t* segOrg
) {
	vec3_t entrance;
	vec3_t wayPoints[MAX_WAYPOINTS+2];
	int numWayPoints;
	int i;
	float smallestDistance;
	int nearestWaypoint;
	int nextWaypoint;
	int a, b;
	float wayLength;
	vec3_t wayDir;
	vec3_t pointDir;

	if (segOrg) {
		WorldOriginToMapOrigin(segOrg, entrance);
	}
	else {
		VectorCopy(seg->entranceOrigin, entrance);
	}

	for (i = -1; i <= seg->numWayPoints; i++) {
		WayPoint(seg, i, wayPoints[i + 1]);
		VectorAdd(wayPoints[i + 1], entrance, wayPoints[i + 1]);
	}
	numWayPoints = seg->numWayPoints + 2;

	nearestWaypoint = -1;
	smallestDistance = 1000000.0;
	for (i = 0; i < numWayPoints; i++) {
		float distance;

		distance = Distance(origin, wayPoints[i]);
		if (distance < smallestDistance) {
			smallestDistance = distance;
			nearestWaypoint = i;
		}
	}
	if (nearestWaypoint < 0) return 0;	// should not happen
	if (nearestWaypoint == 0) {
		nextWaypoint = 1;
	}
	else if (nearestWaypoint >= numWayPoints - 1) {
		nextWaypoint = numWayPoints - 2;
	}
	else {
		if (
			Distance(origin, wayPoints[nearestWaypoint - 1]) <
			Distance(origin, wayPoints[nearestWaypoint + 1])
		) {
			nextWaypoint = nearestWaypoint - 1;
		}
		else {
			nextWaypoint = nearestWaypoint + 1;
		}
	}

	if (nearestWaypoint < nextWaypoint) {
		a = nearestWaypoint;
		b = nextWaypoint;
	}
	else {
		a = nextWaypoint;
		b = nearestWaypoint;
	}

	wayLength = 0;
	for (i = 0; i < a; i++) {
		wayLength += Distance(wayPoints[i], wayPoints[i+1]);
	}

	VectorSubtract(wayPoints[b], wayPoints[a], wayDir);
	VectorNormalize(wayDir);
	VectorSubtract(origin, wayPoints[a], pointDir);
	wayLength += DotProduct(wayDir, pointDir);

	if (wayLength < 0) wayLength = 0;

	return (unsigned long) wayLength;
}


/*
==============
JUHOX: CheckForDeadStyles
==============
*/
static void CheckForDeadStyles(void) {
	char styleUsedAsEntrance[MAX_STYLES];
	char styleUsedAsExit[MAX_STYLES];
	int i;

	G_Printf("CheckForDeadStyles...\n");

	memset(&styleUsedAsEntrance, 0, sizeof(styleUsedAsEntrance));
	memset(&styleUsedAsExit, 0, sizeof(styleUsedAsExit));

	for (i = 0; i < numSegmentTypes; i++) {
		const efhSegmentType_t* segType;
		int styleEntryNum;

		segType = &segmentTypes[i];
		for (styleEntryNum = 0; styleEntryNum < MAX_PARALLEL_STYLES; styleEntryNum++) {
			const efhStyleEntry_t* styleEntry;

			styleEntry = &segType->styles[styleEntryNum];

			if (styleEntry->entrance) {
				styleUsedAsEntrance[styleEntry->entrance - transitionStyles] = qtrue;
			}
			if (styleEntry->exit) {
				styleUsedAsExit[styleEntry->exit - transitionStyles] = qtrue;
			}
		}
	}

	for (i = 0; i < numTransitionStyles; i++) {
		const efhTransitionStyle_t* style;

		style = &transitionStyles[i];

		if (!styleUsedAsEntrance[i]) {
			G_Error("^1CheckForDeadStyles: Style '%s' doesn't appear in any style_in key.", style->name);
		}
		if (!styleUsedAsExit[i]) {
			G_Error("^1CheckForDeadStyles: Style '%s' doesn't appear in any style_out key.", style->name);
		}
	}
}


/*
==============
JUHOX: CheckForUnterminatedStyles
==============
*/
static void CheckForUnterminatedStyles(void) {
	int numRemainingStyles;
	int segnum;
	int styleEntryNum;
	int styleNum;

	G_Printf("CheckForUnterminatedStyles...\n");

	for (styleNum = 0; styleNum < numTransitionStyles; styleNum++) {
		transitionStyles[styleNum].minStepsToFinalSegment = -1;
	}
	numRemainingStyles = numTransitionStyles;

	for (segnum = 0; segnum < numSegmentTypes; segnum++) {
		const efhSegmentType_t* segType;

		segType = &segmentTypes[segnum];
		if (!segType->final) continue;

		for (styleEntryNum = 0; styleEntryNum < MAX_PARALLEL_STYLES; styleEntryNum++) {
			const efhStyleEntry_t* styleEntry;

			styleEntry = &segType->styles[styleEntryNum];
			if (!styleEntry->entrance) continue;

			if (styleEntry->entrance->minStepsToFinalSegment >= 0) continue;

			styleEntry->entrance->minStepsToFinalSegment = 0;
			numRemainingStyles--;
		}
	}

	while (numRemainingStyles > 0) {
		int numProcessedStyles;

		numProcessedStyles = 0;
		for (segnum = 0; segnum < numSegmentTypes; segnum++) {
			const efhSegmentType_t* segType;

			segType = &segmentTypes[segnum];
			if (segType->final) continue;

			for (styleEntryNum = 0; styleEntryNum < MAX_PARALLEL_STYLES; styleEntryNum++) {
				const efhStyleEntry_t* styleEntry;

				styleEntry = &segType->styles[styleEntryNum];
				if (!styleEntry->entrance) continue;
				if (!styleEntry->exit) continue;

				if (styleEntry->exit->minStepsToFinalSegment < 0) continue;
				if (styleEntry->entrance->minStepsToFinalSegment >= 0) continue;

				styleEntry->entrance->minStepsToFinalSegment = styleEntry->exit->minStepsToFinalSegment + 1;
				numProcessedStyles++;
			}
		}

		if (!numProcessedStyles) break;

		numRemainingStyles -= numProcessedStyles;
	}

	if (numRemainingStyles > 0) {
		G_Printf("^1ERROR: CheckForUnterminatedStyles: The following styles can't reach a final segment.\n");

		for (styleNum = 0; styleNum < numTransitionStyles; styleNum++) {
			const efhTransitionStyle_t* style;

			style = &transitionStyles[styleNum];
			if (style->minStepsToFinalSegment >= 0) continue;

			G_Printf("  %s\n", style->name);
		}
		G_Error("(see above)");
	}
}


/*
==============
JUHOX: ReachStyle
==============
*/

static void ReachSegment(efhTransitionStyle_t* style, const efhSegmentType_t* segType);

static void ReachStyle(efhTransitionStyle_t* style) {
	int segTypeNum;

	if (!style) return;

	if (style->visited) {
		if (style->reachability < REACH_loopable) style->reachability = REACH_loopable;
		return;
	}

	if (style->reachability < REACH_reachable) style->reachability = REACH_reachable;

	style->visited = qtrue;
	for (segTypeNum = 0; segTypeNum < numSegmentTypes; segTypeNum++) {
		const efhSegmentType_t* segType;

		segType = &segmentTypes[segTypeNum];
		ReachSegment(style, segType);
	}
	style->visited = qfalse;
}


/*
==============
JUHOX: ReachSegment
==============
*/
static void ReachSegment(efhTransitionStyle_t* style, const efhSegmentType_t* segType) {
	int styleEntryNum;

	for (styleEntryNum = 0; styleEntryNum < MAX_PARALLEL_STYLES; styleEntryNum++) {
		const efhStyleEntry_t* styleEntry;

		styleEntry = &segType->styles[styleEntryNum];
		if (!IsStyleEntryValid(segType, styleEntry)) continue;
		if (styleEntry->entrance != style) continue;
		if (!styleEntry->exit) continue;

		ReachStyle(styleEntry->exit);
		if (style && styleEntry->exit->reachability == REACH_loopable) {
			style->reachability = REACH_loopable;
		}
	}
}


/*
==============
JUHOX: CheckReachabilityAndLoops
==============
*/
static void CheckReachabilityAndLoops(void) {
	int segNum;
	int styleNum;
	int numLoopableStyles;

	G_Printf("CheckReachabilityAndLoops...\n");

	for (segNum = 0; segNum < numSegmentTypes; segNum++) {
		const efhSegmentType_t* segType;

		segType = &segmentTypes[segNum];
		if (!segType->initial) continue;

		ReachSegment(NULL, segType);
	}

	numLoopableStyles = 0;
	for (styleNum = 0; styleNum < numTransitionStyles; styleNum++) {
		const efhTransitionStyle_t* style;

		style = &transitionStyles[styleNum];
		if (style->reachability >= REACH_loopable) {
			numLoopableStyles++;
		}
		if (style->reachability) continue;

		G_Error("CheckReachabilityAndLoops: Style '%s' not reachable.", style->name);
	}

	if (numLoopableStyles <= 0) {
		G_Error("CheckReachabilityAndLoops: No loopable styles available.\n");
	}
	G_Printf("%d/%d styles are loopable.\n", numLoopableStyles, numTransitionStyles);
}


/*
==============
JUHOX: BuildSegments
==============
*/
static void BuildSegments(void) {
	int t;
	int s;

	if (g_gametype.integer != GT_EFH) return;

	G_Printf("BuildSegments...\n");

	if (numSegmentTypes <= 0) {
		G_Error("^1BuildSegments: no segments found");
		return;
	}

	for (t = 0; t < numEntityTemplates; t++) {
		const gentity_t* ent;

		ent = &entityTemplates[t];
		for (s = 0; s < numSegmentTypes; s++) {
			efhSegmentType_t* seg;

			seg = &segmentTypes[s];
			if (ent->sourceLocation[0] < seg->absmin[0]) continue;
			if (ent->sourceLocation[0] > seg->absmax[0]) continue;
			if (ent->sourceLocation[1] < seg->absmin[1]) continue;
			if (ent->sourceLocation[1] > seg->absmax[1]) continue;
			if (ent->sourceLocation[2] < seg->absmin[2]) continue;
			if (ent->sourceLocation[2] > seg->absmax[2]) continue;
			if (ent->idnum != seg->idnum) continue;

			if (ent->s.eType == ET_MOVER && ent->r.linked && ent->s.solid) {

				if (ent->r.absmin[0] < seg->boundingMin[0]) {
					seg->boundingMin[0] = ent->r.absmin[0];
				}
				if (ent->r.absmax[0] > seg->boundingMax[0]) {
					seg->boundingMax[0] = ent->r.absmax[0];
				}
				if (ent->r.absmin[1] < seg->boundingMin[1]) {
					seg->boundingMin[1] = ent->r.absmin[1];
				}
				if (ent->r.absmax[1] > seg->boundingMax[1]) {
					seg->boundingMax[1] = ent->r.absmax[1];
				}
				if (ent->r.absmin[2] < seg->boundingMin[2]) {
					seg->boundingMin[2] = ent->r.absmin[2];
				}
				if (ent->r.absmax[2] > seg->boundingMax[2]) {
					seg->boundingMax[2] = ent->r.absmax[2];
				}
			}

			switch (ent->entClass) {
			case GEC_efh_entrance:
				if (seg->entranceSet) {
					G_Error(
						"^1BuildSegments: duplicate entrance in segment %s",
						SegmentName(seg)
					);
				}
				VectorCopy(ent->sourceLocation, seg->entranceOrigin);
				seg->entranceSet = qtrue;
				break;
			case GEC_efh_exit:
				if (seg->exitSet) {
					G_Error(
						"^1BuildSegments: duplicate exit in segment %s",
						SegmentName(seg)
					);
				}
				VectorCopy(ent->sourceLocation, seg->exitOrigin);
				seg->exitSet = qtrue;
				break;
			case GEC_efh_waypoint:
				AddWaypoint(ent, seg);
				break;
			default:
				if (
					ent->item &&
					ent->item->giType == IT_TEAM &&
					ent->item->giTag == PW_BLUEFLAG
				) {
					if (seg->goalTemplate) {
						G_Error(
							"^1BuildSegments: duplicate goal in segment %s",
							SegmentName(seg)
						);
					}
					seg->goalTemplate = ent;
				}

				if (seg->numEntities >= MAX_ENTITIES_PER_SEGMENT) {
					G_Error(
						"^1BuildSegments: too many (>%d) entities in segment %s",
						MAX_ENTITIES_PER_SEGMENT, SegmentName(seg)
					);
					break;
				}

				seg->entityTemplateIndex[seg->numEntities] = t;
				seg->numEntities++;
			}

			break;	// we've found the segment this entity belongs to
		}
	}

	for (s = 0; s < numSegmentTypes; s++) {
		efhSegmentType_t* seg;
		vec3_t delta;

		seg = &segmentTypes[s];

		if (seg->numEntities <= 0) {
			G_Error("^1BuildSegments: empty segment %s", SegmentName(seg));
		}

		if (!seg->entranceSet) {
			G_Error("^1BuildSegments: no entrance for segment %s", SegmentName(seg));
		}

		if (!seg->exitSet) {
			G_Error("^1BuildSegments: no exit for segment %s", SegmentName(seg));
		}

		// make bounding box relative to segment entrance
		VectorSubtract(seg->boundingMin, seg->entranceOrigin, seg->boundingMin);
		VectorSubtract(seg->boundingMax, seg->entranceOrigin, seg->boundingMax);

		if (seg->final && !seg->goalTemplate) {
			G_Error("^1BuildSegments: no team_CTF_blueflag in final segment %s", SegmentName(seg));
		}

		VectorSubtract(seg->exitOrigin, seg->entranceOrigin, delta);
		seg->exitDelta.x = (int) delta[0];
		seg->exitDelta.y = (int) delta[1];
		seg->exitDelta.z = (int) delta[2];

		if (VectorLength(delta) < 16) {
			G_Error(
				"^1BuildSegments: exit too near to entrance in segment %s",
				SegmentName(seg)
			);
		}

		ComputeWayLength(seg);
	}

	CheckForDeadStyles();
	CheckForUnterminatedStyles();
	CheckReachabilityAndLoops();

	G_Printf("BuildSegments: %d entities in %d segments\n", numEntityTemplates, numSegmentTypes);
}


/*
==============
JUHOX: ClearMonsterCache
==============
*/
static void ClearMonsterCache(efhCachedMonster_t* cache) {
	cache->currentSegment = -1;
	cache->sourceSegment = -1;
	cache->sourceEntity = -1;
	cache->index = -1;
}


/*
==============
JUHOX: AllocMonsterCache
==============
*/
static efhCachedMonster_t* AllocMonsterCache(int sourceSegment, int sourceEntity, int index) {
	int i;
	efhCachedMonster_t* freeCache;
	efhCachedMonster_t* oldestCache;
	long minX;

	freeCache = NULL;
	oldestCache = NULL;
	minX = 0x7fffffff;

	for (i = 0; i < MAX_CACHED_MONSTERS; i++) {
		efhCachedMonster_t* cache;

		cache = &cachedMonsters[i];

		if (
			cache->sourceSegment == sourceSegment &&
			cache->sourceEntity == sourceEntity &&
			cache->index == index
		) {
			return NULL;
		}

		if (!freeCache && cache->sourceSegment < 0) {
			freeCache = cache;
		}
		if (cache->position.x < minX) {
			minX = cache->position.x;
			oldestCache = cache;
		}
	}

	if (freeCache) return freeCache;
	return oldestCache;
}


/*
==============
JUHOX: FreeMonsterCache
==============
*/
static void FreeMonsterCache(efhCachedMonster_t* cache) {
	int sourceSegment;
	int sourceEntity;
	gentity_t* entTemplate;
	int i;

	sourceSegment = cache->sourceSegment;
	sourceEntity = cache->sourceEntity;

	ClearMonsterCache(cache);

	if (sourceSegment < 0) return;
	if (sourceEntity < 0) return;

	entTemplate = &entityTemplates[sourceEntity];
	if (!entTemplate->target) return;

	// this was a boss monster, check if there're others
	for (i = 0; i < MAX_CACHED_MONSTERS; i++) {
		cache = &cachedMonsters[i];

		if (cache->sourceSegment != sourceSegment) continue;
		if (cache->sourceEntity != sourceEntity) continue;

		return;
	}
	// No other boss monsters. Fire the targets.
	entTemplate->worldSegment = sourceSegment + 1;
	G_UseTargets(entTemplate, &g_entities[ENTITYNUM_WORLD]);
}


/*
==============
JUHOX: SpawnMonster
==============
*/
static void SpawnMonster(
	int count, int sourceSegment, int sourceEntity, const efhVector_t* segOrg,
	int type, int health, qboolean forceSpawn
) {
	int load;
	monsterspawnmode_t msm;
	localseed_t seed;
	int i;
	int n;

	if (visitedSegments[sourceSegment>>3] & (1 << (sourceSegment & 7))) return;

	load = g_monsterLoad.integer;
	if (load > 1000) load = 1000;
	if (totalWayLength[sourceSegment] < 10000) load = (load * totalWayLength[sourceSegment]) / 10000;

	msm = MSM_nearOrigin;
	if (count <= 0) {
		count = 1;
		if (load > 100) load = 100;
		msm = MSM_atOrigin;
	}

	if (forceSpawn && load < 100) {
		load = 100;
	}
	else if (totalWayLength[sourceSegment] < 3000) {
		return;
	}

	// guarantee the seed does not depend on the order of segment creation
	seed.seed0 = monsterSpawnSeed;
	seed.seed1 = sourceSegment;
	seed.seed2 = sourceEntity;
	seed.seed3 = 0;

	n = 0;

	for (i = 0; i < count; i++) {
		int stock;

		for (stock = load; stock > 0; stock -= 100) {
			efhCachedMonster_t* cache;
			vec3_t delta;

			if (stock < 100) {
				if (LocallySeededRandom(&seed) % 100 >= stock) break;
			}

			cache = AllocMonsterCache(sourceSegment, sourceEntity, n);
			if (!cache) continue;

			switch (type) {
			case 1:
				cache->type = MT_predator;
				break;
			case 2:
				cache->type = MT_guard;
				break;
			case 3:
				cache->type = MT_titan;
				break;
			default:
				cache->type = G_MonsterType(&seed);
				break;
			}

			if (health > 0) {
				health = G_MonsterBaseHealth(cache->type, G_MonsterHealthScale() * health / 100.0);
			}

			cache->sourceSegment = sourceSegment;
			cache->sourceEntity = sourceEntity;
			cache->index = n;
			cache->currentSegment = sourceSegment;

			cache->position = *segOrg;
			VectorSubtract(
				entityTemplates[sourceEntity].sourceLocation,
				efhWorld[sourceSegment]->entranceOrigin,
				delta
			);
			cache->position.x += delta[0];
			cache->position.y += delta[1];
			cache->position.z += delta[2];
			VectorSet(cache->angles, 0, local_random(&seed) * 360, 0);
			cache->spawnmode = msm;
			cache->maxHealth = health;
			cache->action = MA_waiting;
			if (cache->type == MT_titan) {
				cache->action = MA_sleeping;
			}

			n++;
		}
	}
}


/*
==============
JUHOX: SpawnCachedMonsters
==============
*/
static void SpawnCachedMonsters(void) {
	int i;

	if (G_NumMonsters() >= MAX_MONSTERS) return;

	for (i = 0; i < MAX_CACHED_MONSTERS; i++) {
		efhCachedMonster_t* cache;

		cache = &cachedMonsters[i];
		if (
			cache->currentSegment >= 0 &&
			segmentState[cache->currentSegment] == ESS_spawned
		) {
			vec3_t mins, maxs;
			vec3_t origin;
			vec3_t spawnorigin;
			localseed_t seed;
			gentity_t* monster;

			G_GetMonsterBounds(cache->type, mins, maxs);
			origin[0] = cache->position.x - level.referenceOrigin.x;
			origin[1] = cache->position.y - level.referenceOrigin.y;
			origin[2] = cache->position.z - level.referenceOrigin.z;
			InitLocalSeed(GST_monsterSpawning, &seed);
			if (!G_GetMonsterSpawnPoint(mins, maxs, &seed, spawnorigin, cache->spawnmode, origin)) {
				ClearMonsterCache(cache);
				continue;
			}
			monster = G_SpawnMonster(
				cache->type,
				spawnorigin, cache->angles,
				0, TEAM_FREE, -1, &seed, NULL, cache->maxHealth, cache->action, i
			);
			if (monster) {
				playerState_t* ps;

				monster->worldSegment = cache->currentSegment + 1;
				cache->currentSegment = -1;
				ps = G_GetEntityPlayerState(monster);
				if (ps) {
					cache->maxHealth = ps->stats[STAT_MAX_HEALTH];
				}
			}

			if (G_NumMonsters() >= MAX_MONSTERS) return;
		}
	}
}


/*
==============
JUHOX: SpawnSegment
==============
*/
static void SpawnSegment(
	const efhSegmentType_t* seg, const vec3_t origin,
	int worldSegment, const efhVector_t* segOrg,
	efhSpawnCommand_t cmd
) {
	int i;
	int numBossEntities;
	int bossEntities[MAX_ENTITIES_PER_SEGMENT];

	if (g_gametype.integer != GT_EFH) return;

	numBossEntities = 0;

	for (i = 0; i < seg->numEntities; i++) {
		gentity_t* ent;
		const gentity_t* entTemplate;
		int entnum;
		vec3_t dir;
		vec3_t entOrigin;

		entTemplate = &entityTemplates[seg->entityTemplateIndex[i]];

		switch (cmd) {
		case ESC_spawnCompletely:
			break;
		case ESC_spawnSolidOnly:
			if (entTemplate->s.eType != ET_MOVER) goto NextEntity;
			break;
		case ESC_spawnNonSolidOnly:
			if (entTemplate->s.eType == ET_MOVER) goto NextEntity;
			break;
		}

		if (entTemplate->entClass == GEC_efh_monster) {
			SpawnMonster(
				entTemplate->count, worldSegment, seg->entityTemplateIndex[i], segOrg,
				entTemplate->s.otherEntityNum, entTemplate->health,
				entTemplate->spawnflags & 1
			);
			if (entTemplate->target) {
				bossEntities[numBossEntities++] = seg->entityTemplateIndex[i];
			}
			continue;
		}

		ent = G_Spawn();
		if (!ent) return;

		entnum = ent->s.number;
		memcpy(ent, entTemplate, sizeof(gentity_t));
		ent->s.number = entnum;
		ent->r.s = ent->s;
		VectorSubtract(ent->r.currentOrigin, seg->entranceOrigin, dir);
		VectorAdd(origin, dir, entOrigin);
		VectorCopy(entOrigin, ent->s.pos.trBase);
		VectorCopy(entOrigin, ent->r.currentOrigin);
		VectorCopy(entOrigin, ent->s.origin);	// for spawn points
		if (ent->s.eType == ET_MOVER) {
			VectorSubtract(entOrigin, entTemplate->r.currentOrigin, dir);
			VectorAdd(ent->pos1, dir, ent->pos1);
			VectorAdd(ent->pos2, dir, ent->pos2);
			ent->s.time = worldSegment;
		}
		ent->worldSegment = worldSegment + 1;

		// entity type specific initializations
		switch (ent->entClass) {
		case GEC_invalid:
			G_Error("^1BUG! SpawnSegment: entity class not initialized for '%s'", ent->classname);
			break;
		case GEC_item:
		case GEC_func_train:
		case GEC_trigger_push:
		case GEC_target_push:
			ent->nextthink = level.time + FRAMETIME;
			break;
		case GEC_func_timer:
			if (ent->spawnflags & 1) {
				ent->nextthink = level.time + FRAMETIME;
			}
			else {
				ent->nextthink = 0;
			}
			break;
		case GEC_trigger_always:
			ent->nextthink = level.time + 300;
			break;
		case GEC_misc_portal_surface:
			if (ent->target) {
				ent->nextthink = level.time + 100;
			}
			break;
		case GEC_shooter_rocket:
		case GEC_shooter_plasma:
		case GEC_shooter_grenade:
			if (ent->target) {
				ent->nextthink = level.time + 500;
			}
			break;
		default:
			break;
		}

		if (ent->r.linked) {
			ent->r.linked = qfalse;
			trap_LinkEntity(ent);
		}

		NextEntity:;
	}

	if (cmd == ESC_spawnSolidOnly) return;

	for (i = 0; i < numBossEntities; i++) {
		gentity_t* bossSpawn;
		int n;

		bossSpawn = &entityTemplates[bossEntities[i]];
		for (n = 0; n < MAX_CACHED_MONSTERS; n++) {
			const efhCachedMonster_t* cache;

			cache = &cachedMonsters[n];
			if (cache->sourceSegment != worldSegment) continue;
			if (cache->sourceEntity != bossEntities[i]) continue;

			break;
		}
		if (n >= MAX_CACHED_MONSTERS) {
			bossSpawn->worldSegment = worldSegment + 1;
			G_UseTargets(bossSpawn, &g_entities[ENTITYNUM_WORLD]);
		}
	}

	visitedSegments[worldSegment>>3] |= 1 << (worldSegment & 7);
}


/*
==============
JUHOX: GetExcludedSegmentTypes
==============
*/
static int GetExcludedSegmentTypes(int segment, efhSegmentType_t** exclude) {
	efhVector_t segOrg;
	int numExcluded;
	int visBlockingCount;

	segOrg.x = 0;
	segOrg.y = 0;
	segOrg.z = 0;
	numExcluded = 0;
	visBlockingCount = 0;

	while (segment > 0) {
		int i;
		efhSegmentType_t* seg;

		seg = efhWorld[segment];
		if (!seg) continue;

		for (i = 0; i < numExcluded; i++) {
			if (exclude[i] == seg) goto NextSegment;
		}
		exclude[numExcluded++] = seg;

		NextSegment:
		if (seg->visBlocking) {
			visBlockingCount++;
			if (visBlockingCount >= 2) break;
		}

		segOrg.x += seg->exitDelta.x;
		segOrg.y += seg->exitDelta.y;
		segOrg.z += seg->exitDelta.z;

		if (segOrg.x < -MAX_VIEWDISTANCE) break;
		if (segOrg.x > MAX_VIEWDISTANCE) break;
		if (segOrg.y < -MAX_VIEWDISTANCE) break;
		if (segOrg.y > MAX_VIEWDISTANCE) break;
		if (segOrg.z < -MAX_VIEWDISTANCE) break;
		if (segOrg.z > MAX_VIEWDISTANCE) break;

		segment--;
	}
	return numExcluded;
}


/*
==============
JUHOX: IsBoundingBoxOverlappingSegment
==============
*/
static qboolean IsBoundingBoxOverlappingSegment(
	const efhVector_t* mins, const efhVector_t* maxs,
	const efhSegmentType_t* segType, const efhVector_t* segOrg
) {
	if (mins->x - segOrg->x > segType->boundingMax[0] + 1) return qfalse;
	if (maxs->x - segOrg->x < segType->boundingMin[0] - 1) return qfalse;
	if (mins->y - segOrg->y > segType->boundingMax[1] + 1) return qfalse;
	if (maxs->y - segOrg->y < segType->boundingMin[1] - 1) return qfalse;
	if (mins->z - segOrg->z > segType->boundingMax[2] + 1) return qfalse;
	if (maxs->z - segOrg->z < segType->boundingMin[2] - 1) return qfalse;
	return qtrue;
}


/*
==============
JUHOX: DoesSegmentTypeFit
==============
*/
static qboolean DoesSegmentTypeFit(const efhSegmentType_t* segType, int segment) {
	efhVector_t segOrg;
	efhVector_t mins;
	efhVector_t maxs;
	const efhSegmentType_t* sType;
	int visBlockingCount;

	mins.x = segType->boundingMin[0];
	mins.y = segType->boundingMin[1];
	mins.z = segType->boundingMin[2];

	maxs.x = segType->boundingMax[0];
	maxs.y = segType->boundingMax[1];
	maxs.z = segType->boundingMax[2];

	sType = efhWorld[segment];

	segOrg.x = -sType->exitDelta.x;
	segOrg.y = -sType->exitDelta.y;
	segOrg.z = -sType->exitDelta.z;

	visBlockingCount = 0;

	while (segment > 0) {
		if (sType->visBlocking) {
			visBlockingCount++;
			if (visBlockingCount >= 2) {
				break;
			}
		}

		segment--;
		sType = efhWorld[segment];
		segOrg.x -= sType->exitDelta.x;
		segOrg.y -= sType->exitDelta.y;
		segOrg.z -= sType->exitDelta.z;

		if (IsBoundingBoxOverlappingSegment(&mins, &maxs, sType, &segOrg)) return qfalse;

		if (segOrg.x < -MAX_VIEWDISTANCE) break;
		if (segOrg.x > MAX_VIEWDISTANCE) break;
		if (segOrg.y < -MAX_VIEWDISTANCE) break;
		if (segOrg.y > MAX_VIEWDISTANCE) break;
		if (segOrg.z < -MAX_VIEWDISTANCE) break;
		if (segOrg.z > MAX_VIEWDISTANCE) break;
	}
	return qtrue;
}


/*
==============
JUHOX: GetAvailableSegmentTypes
==============
*/
static int GetAvailableSegmentTypes(
	int segment,
	const efhTransitionStyle_t* style,
	qboolean finalization,
	efhSegmentType_t** exclude, int numExcluded,
	efhSegmentType_t** available
) {
	int i;
	int numAvailable;
	efhSegmentType_t* fallback;
	int fallbackDist;

	numAvailable = 0;

	fallback = NULL;
	fallbackDist = -1;

	for (i = 0; i < numSegmentTypes; i++) {
		int k;
		efhSegmentType_t* seg;

		seg = &segmentTypes[i];

		// check some basic restrictions
		if (style) {
			if (seg->initial) continue;
		}
		else {
			if (!seg->initial) continue;
			goto SegmentAvailable;
		}
		if (seg->final && !finalization) continue;
		if (seg->frustrating && !g_challengingEnv.integer) continue;

		// does seg have a matching style?
		for (k = 0; k < MAX_PARALLEL_STYLES; k++) {
			const efhStyleEntry_t* se;

			se = &seg->styles[k];
			if (!IsStyleEntryValid(seg, se)) continue;

			if (se->entrance == style) break;
		}
		if (k >= MAX_PARALLEL_STYLES) continue;

		// is seg excluded?
		for (k = 0; k < numExcluded; k++) {
			if (seg == exclude[k]) {
				// seg is excluded, but since everything else matches it may be used as a fallback
				if (k > fallbackDist) {
					fallbackDist = k;
					fallback = seg;
				}
				goto NextType;
			}
		}

		if (!DoesSegmentTypeFit(seg, segment)) continue;

		SegmentAvailable:
		available[numAvailable++] = seg;

		NextType:;
	}

	if (numAvailable <= 0) {
		available[0] = fallback;
		numAvailable = 1;
		numFallbacks++;
		G_Printf(
			"^3WARNING: Not enough segments to choose from for style '%s'.\n",
			style? style->name : "<none>"
		);

		if (!fallback) {
			G_Printf(
				"^3WARNING: No fallback available for style '%s'.\n",
				style? style->name : "<none>"
			);
			numAvailable = 0;
		}
	}

	return numAvailable;
}


/*
==============
JUHOX: FilterBestSegmentsForFinalization
==============
*/
static void FilterBestSegmentsForFinalization(
	const efhTransitionStyle_t* style,
	efhSegmentType_t** available, int numAvailable
) {
	int i;
	int minStepsNeeded;

	// find out the minimum number of segments needed to reach a final segment
	minStepsNeeded = 10000;
	for (i = 0; i < numAvailable; i++) {
		const efhSegmentType_t* segType;
		int j;

		segType = available[i];
		if (segType->final) {
			minStepsNeeded = -1;
			break;
		}

		for (j = 0; j < MAX_PARALLEL_STYLES; j++) {
			const efhStyleEntry_t* styleEntry;

			styleEntry = &segType->styles[j];
			if (styleEntry->entrance != style) continue;
			if (!styleEntry->exit) continue;	// should not happen

			if (styleEntry->exit->minStepsToFinalSegment >= minStepsNeeded) continue;

			minStepsNeeded = styleEntry->exit->minStepsToFinalSegment;
		}
	}

	// filter out any segment that would require more steps than needed
	for (i = 0; i < numAvailable; i++) {
		const efhSegmentType_t* segType;
		int j;

		segType = available[i];
		for (j = 0; j < MAX_PARALLEL_STYLES; j++) {
			const efhStyleEntry_t* styleEntry;

			styleEntry = &segType->styles[j];
			if (styleEntry->entrance != style) continue;

			if (!styleEntry->exit) break;
			if (styleEntry->exit->minStepsToFinalSegment <= minStepsNeeded) break;
		}

		if (j >= MAX_PARALLEL_STYLES) {
			available[i] = NULL;
		}
	}
}


/*
==============
JUHOX: RemoveSegment
==============
*/

static void DeleteUnusedEntities(void);

static void RemoveSegment(int segment) {
	memcpy(&newSegmentState, &segmentState, sizeof(newSegmentState));
	newSegmentState[segment] = ESS_removed;

	DeleteUnusedEntities();

	memcpy(&segmentState, &newSegmentState, sizeof(segmentState));
}


/*
==============
JUHOX: PredictWayLength
==============
*/
static int PredictWayLength(const vec3_t origin, int segment) {
	return (int) (totalWayLength[segment] + SegmentWayLength(origin, efhWorld[segment], NULL));
}


/*
==============
JUHOX: ExtendWorld
==============
*/
static void ExtendWorld(void) {
	int numExcluded;
	efhSegmentType_t* excluded[MAX_SEGMENTTYPES];
	int numAvailable;
	efhSegmentType_t* available[MAX_SEGMENTTYPES];
	int k;
	float totalFrequency;
	efhSegmentType_t* choosen;
	efhTransitionStyle_t* choosenStyle;
	qboolean finalization;

	if (worldEnd >= MAX_WORLD_SEGMENTS) return;

	if (g_debugEFH.integer) {
		if (debugSegment <= 0) return;

		if (debugSegment > maxSegment) {
			if (maxSegment > 0) G_EFH_NextDebugSegment(1);
			worldEnd++;
			maxSegment = worldEnd;
		}
		else {
			if (debugSegment != oldDebugSegment) {
				debugModeChoosenSegmentType = efhWorld[debugSegment] - segmentTypes;
				G_EFH_NextDebugSegment(0);
			}
			if (efhWorld[debugSegment] != &segmentTypes[debugModeChoosenSegmentType]) {
				int i;
				vec3_t delta;

				for (i = debugSegment; i <= maxSegment; i++) {
					RemoveSegment(i);
				}

				if (currentSegment > debugSegment) {
					currentSegmentOrigin.x += segmentTypes[debugModeChoosenSegmentType].exitDelta.x - efhWorld[debugSegment]->exitDelta.x;
					currentSegmentOrigin.y += segmentTypes[debugModeChoosenSegmentType].exitDelta.y - efhWorld[debugSegment]->exitDelta.y;
					currentSegmentOrigin.z += segmentTypes[debugModeChoosenSegmentType].exitDelta.z - efhWorld[debugSegment]->exitDelta.z;
				}

				delta[0] = segmentTypes[debugModeChoosenSegmentType].exitDelta.x - efhWorld[debugSegment]->exitDelta.x;
				delta[1] = segmentTypes[debugModeChoosenSegmentType].exitDelta.y - efhWorld[debugSegment]->exitDelta.y;
				delta[2] = segmentTypes[debugModeChoosenSegmentType].exitDelta.z - efhWorld[debugSegment]->exitDelta.z;

				for (i = 0; i < level.maxclients; i++) {
					gentity_t* ent;
					playerState_t* ps;

					if (level.clients[i].pers.connected != CON_CONNECTED) continue;

					ent = &g_entities[i];
					if (ent->worldSegment - 1 < debugSegment) continue;

					VectorAdd(ent->s.pos.trBase, delta, ent->s.pos.trBase);
					VectorAdd(ent->r.currentOrigin, delta, ent->r.currentOrigin);

					ps = G_GetEntityPlayerState(ent);
					if (ps) {
						VectorAdd(ps->origin, delta, ps->origin);

						ps->eFlags ^= EF_TELEPORT_BIT;
					}

					trap_LinkEntity(ent);
				}
			}
		}
		efhWorld[debugSegment] = &segmentTypes[debugModeChoosenSegmentType];
		oldDebugSegment = debugSegment;
		return;
	}

	finalization = (
		g_distanceLimit.integer > 0 &&
		worldWayLength / 32 >= g_distanceLimit.integer
	);

	numExcluded = GetExcludedSegmentTypes(worldEnd - 1, excluded);
	numAvailable = GetAvailableSegmentTypes(
		worldEnd - 1, worldStyle, finalization, excluded, numExcluded, available
	);
	if (finalization) {
		FilterBestSegmentsForFinalization(worldStyle, available, numAvailable);
	}

	// randomly choose among the available segments
	totalFrequency = 0;
	choosen = NULL;
	choosenStyle = NULL;
	for (k = 0; k < numAvailable; k++) {
		const efhSegmentType_t* type;
		int s;

		type = available[k];
		if (!type) continue;

		for (s = 0; s < MAX_PARALLEL_STYLES; s++) {
			const efhStyleEntry_t* se;

			se = &type->styles[s];
			if (se->frequency <= 0) continue;

			if (worldStyle && se->entrance != worldStyle) continue;
			if (!finalization) {
				if (!se->exit) continue;
				if (se->exit->reachability < REACH_loopable) continue;
			}

			totalFrequency += se->frequency;
			if (local_random(&worldCreationSeed) * totalFrequency < se->frequency || !choosen) {
				choosen = available[k];
				choosenStyle = se->exit;
			}
		}
	}

	if (!choosen) {
		G_Printf("latest generated segments:\n");
		for (k = 0; k < 15; k++) {
			int i;

			i = worldEnd - 15 + k;
			if (i < 0) continue;

			G_Printf("#%d: %s\n", i, SegmentName(efhWorld[i]));
		}
		G_Error(
			"^1ExtendWorld: No segments fit.\n"
			"worldStyle=%s, finalization=%s, numExcluded=%d, numAvaliable=%d",
			worldStyle? worldStyle->name : "<none>", finalization? "true" : "false",
			numExcluded, numAvailable
		);
	}

	efhWorld[worldEnd] = choosen;

	worldStyle = choosenStyle;
	if (worldEnd > 0) {
		totalWayLength[worldEnd] = worldWayLength;
		worldWayLength += choosen->wayLength;
	}

	maxSegment = worldEnd;
	worldEnd++;

	if (choosen->final) {
		level.efhGoalDistance = PredictWayLength(choosen->goalTemplate->s.origin, maxSegment) / 32;
		trap_SetConfigstring(CS_EFH_GOAL_DISTANCE, va("%d", level.efhGoalDistance));
		worldEnd = MAX_WORLD_SEGMENTS;
	}
}


/*
==============
JUHOX: CreateWorld
==============
*/
static void CreateWorld(void) {
	int i;

	if (g_gametype.integer != GT_EFH) return;

	G_Printf("CreateWorld...\n");

	if (numTransitionStyles <= 0) {
		G_Error("^1CreateWorld: no styles found");
	}

	G_Printf("available styles:\n");
	for (i = 0; i < numTransitionStyles; i++) {
		G_Printf("   %s\n", transitionStyles[i].name);
	}
	G_Printf("---------\n");

	if (!g_debugEFH.integer) {
		memset(&efhWorld, 0, sizeof(efhWorld));
	}
	else {
		for (i = 0; i < MAX_WORLD_SEGMENTS; i++) {
			efhWorld[i] = &segmentTypes[0];
		}
	}

	monsterSpawnSeed = SeededRandom(GST_worldCreation);

	InitLocalSeed(GST_worldCreation, &worldCreationSeed);

	worldEnd = 0;
	worldStyle = NULL;

	totalWayLength[0] = 0;
	worldWayLength = 0;
	maxSegment = 0;
	numFallbacks = 0;

	// create just enough world segments so clients can spawn
	for (i = 0; i < 100; i++) {
		ExtendWorld();
	}
}


/*
==============
JUHOX: GetSpaceExtent
==============
*/
static void GetSpaceExtent(void) {
	trace_t trace;
	vec3_t start;
	vec3_t end;

	VectorClear(start);
	VectorCopy(start, end);
	end[0] = -1000000;
	trap_Trace(&trace, start, NULL, NULL, end, -1, CONTENTS_SOLID);
	efhSpaceMins[0] = trace.endpos[0];

	end[0] = +1000000;
	trap_Trace(&trace, start, NULL, NULL, end, -1, CONTENTS_SOLID);
	efhSpaceMaxs[0] = trace.endpos[0];

	start[0] = efhSpaceMins[0] + 1;
	VectorCopy(start, end);
	end[1] = -1000000;
	trap_Trace(&trace, start, NULL, NULL, end, -1, CONTENTS_SOLID);
	efhSpaceMins[1] = trace.endpos[1];

	end[1] = +1000000;
	trap_Trace(&trace, start, NULL, NULL, end, -1, CONTENTS_SOLID);
	efhSpaceMaxs[1] = trace.endpos[1];

	start[1] = efhSpaceMins[1] + 1;
	VectorCopy(start, end);
	end[2] = -1000000;
	trap_Trace(&trace, start, NULL, NULL, end, -1, CONTENTS_SOLID);
	efhSpaceMins[2] = trace.endpos[2];

	end[2] = +1000000;
	trap_Trace(&trace, start, NULL, NULL, end, -1, CONTENTS_SOLID);
	efhSpaceMaxs[2] = trace.endpos[2];
}


/*
==============
G_SpawnEntitiesFromString

Parses textual entity definitions out of an entstring and spawns gentities.
==============
*/
void G_SpawnEntitiesFromString( void ) {
	// allow calls to G_Spawn*()
	level.spawning = qtrue;
	level.numSpawnVars = 0;

	// JUHOX: get efh space extent
	if (g_gametype.integer == GT_EFH) {
		GetSpaceExtent();
	}


	// the worldspawn is not an actual entity, but it still
	// has a "spawn" function to perform any global setup
	// needed by a level (setting configstrings or cvars, etc)
	if ( !G_ParseSpawnVars() ) {
		G_Error( "SpawnEntities: no entities" );
	}
	SP_worldspawn();

	// parse ents
	while( G_ParseSpawnVars() ) {
		G_SpawnGEntityFromSpawnVars();
	}

	SetGameSeed();	// JUHOX

	// JUHOX: spawn EFH world
	if (g_gametype.integer == GT_EFH) {
		BuildSegments();
		CreateWorld();
		if (g_debugEFH.integer) G_EFH_NextDebugSegment(0);
	}

	level.spawning = qfalse;			// any future calls to G_Spawn*() will be errors
}

/*
==============
JUHOX: G_InitWorldSystem
==============
*/
void G_InitWorldSystem(void) {
	int i;

	VectorClear(efhSpaceMins);
	VectorClear(efhSpaceMaxs);
	numEntityTemplates = 0;
	numSegmentTypes = 0;
	maxSegment = -1;
	currentSegment = 0;
	currentSegmentOrigin.x = 0;
	currentSegmentOrigin.y = 0;
	currentSegmentOrigin.z = 0;
	memset(&entityTemplates, 0, sizeof(entityTemplates));
	memset(&segmentTypes, 0, sizeof(segmentTypes));
	segmentTypes[MAX_SEGMENTTYPES].name = "<void>";
	segmentTypes[MAX_SEGMENTTYPES].exitDelta.x = 100000;
	memset(&segmentState, ESS_removed, sizeof(segmentState));
	memset(&visitedSegments, 0, sizeof(visitedSegments));
	memset(&cachedMonsters, 0, sizeof(cachedMonsters));
	memset(&efhWorld, 0, sizeof(efhWorld));
	for (i = 0; i < MAX_CACHED_MONSTERS; i++) {
		efhCachedMonster_t* cache;

		cache = &cachedMonsters[i];
		ClearMonsterCache(cache);
	}
	numTransitionStyles = 0;
	memset(&transitionStyles, 0, sizeof(transitionStyles));
	debugSegment = 1;
	oldDebugSegment = 1;
	debugModeChoosenSegmentType = 0;
	trap_SetConfigstring(CS_EFH_GOAL_DISTANCE, "0");
}


/*
==============
JUHOX: GetTransitionStyleFromName
==============
*/
static efhTransitionStyle_t* GetTransitionStyleFromName(const char* name) {
	int i;
	efhTransitionStyle_t* style;

	if (!name[0]) return NULL;

	for (i = 0; i < numTransitionStyles; i++) {
		style = &transitionStyles[i];
		if (!Q_stricmp(style->name, name)) {
			return style;
		}
	}
	if (numTransitionStyles >= MAX_STYLES) {
		G_Error("^1GetTransitionStyleFromName: too many styles (>%d)", MAX_STYLES);
		return 0;
	}
	style = &transitionStyles[numTransitionStyles++];
	Q_strncpyz(style->name, name, STYLE_NAME_MAX_SIZE);
	return style;
}


/*
==============
JUHOX: SP_efh_hull
==============
*/
static void SP_efh_hull(gentity_t* ent) {
	int idnum;
	int count;
	const efhSegmentType_t* org;

	if (
		g_gametype.integer != GT_EFH ||
		(ent->spawnflags & 16)
	) {
		G_FreeEntity(ent);
		return;
	}

	count = ent->count;
	if (count < 1) count = 1;

	if (numSegmentTypes + count <= MAX_SEGMENTTYPES) {
		efhSegmentType_t* seg;
		char* bounds;
		int i;
		int numStyleEntriesDefined;
		float defaultFrequency;

		seg = &segmentTypes[numSegmentTypes];

		seg->name = ent->targetname;
		if (!seg->name) {
			seg->name = "unnamed";
		}

		if (G_SpawnString("bounds", "", &bounds)) {
			// map compiled with q3map_efh
			sscanf(
				bounds, "%f %f %f %f %f %f",
				&seg->absmin[0], &seg->absmin[1], &seg->absmin[2],
				&seg->absmax[0], &seg->absmax[1], &seg->absmax[2]
			);
		}
		else {
			// map compiled with standard q3map
			trap_SetBrushModel(ent, ent->model);
			VectorAdd(ent->s.origin, ent->r.mins, seg->absmin);
			VectorAdd(ent->s.origin, ent->r.maxs, seg->absmax);
		}

		// Initial values for the bounding box. Correct values will be computed in BuildSegments()
		VectorCopy(seg->absmin, seg->boundingMax);
		VectorCopy(seg->absmax, seg->boundingMin);

		if (ent->spawnflags & 1) {
			seg->initial = qtrue;
		}
		if (ent->spawnflags & 2) {
			seg->final = qtrue;
		}
		if (ent->spawnflags & 4) {
			seg->frustrating = qtrue;
		}
		if (ent->spawnflags & 8) {
			seg->visBlocking = qtrue;
		}

		if (seg->initial && seg->final) {
			G_Error("SP_efh_hull: Both initial & final flag set in segment %s", SegmentName(seg));
		}

		numStyleEntriesDefined = 0;
		defaultFrequency = 100;
		for (i = 0; i < MAX_PARALLEL_STYLES; i++) {
			efhStyleEntry_t* styleEntry;
			char* styleName;
			char ext[4];

			styleEntry = &seg->styles[i];

			if (i <= 0) {
				ext[0] = 0;
			}
			else {
				Q_strncpyz(ext, va("%d", i), sizeof(ext));
			}

			G_SpawnFloat(va("frequency%s", ext), "100", &styleEntry->frequency);

			G_SpawnString(va("style_in%s", ext), "", &styleName);
			styleEntry->entrance = GetTransitionStyleFromName(styleName);

			G_SpawnString(va("style_out%s", ext), "", &styleName);
			styleEntry->exit = GetTransitionStyleFromName(styleName);

			if (styleEntry->entrance || styleEntry->exit) {
				if (!styleEntry->entrance && !seg->initial) {
					G_Error("^1SP_efh_hull: no style_in%s key in segment %s", ext, SegmentName(seg));
				}
				if (!styleEntry->exit && !seg->final) {
					G_Error("^1SP_efh_hull: no style_out%s key in segment %s", ext, SegmentName(seg));
				}
			}
			if (styleEntry->frequency <= 0) {
				G_Error(
					"^1SP_efh_hull: invalid value frequency%s=%f for segment %s",
					ext, styleEntry->frequency, SegmentName(seg)
				);
			}

			// mark unused parts of the entry
			if (seg->initial) styleEntry->entrance = NULL;
			if (seg->final) styleEntry->exit = NULL;
			if (!styleEntry->entrance && !styleEntry->exit) {
				if (i == 0) defaultFrequency = styleEntry->frequency;
				styleEntry->frequency = -1;
			}
			else {
				numStyleEntriesDefined++;
			}
		}
		if (numStyleEntriesDefined <= 0) {
			if (!seg->initial) seg->styles[0].entrance = GetTransitionStyleFromName("style_default");
			if (!seg->final) seg->styles[0].exit = GetTransitionStyleFromName("style_default");
			seg->styles[0].frequency = defaultFrequency;
		}

		numSegmentTypes++;
	}
	else {
		G_Error("^1SP_efh_hull: too many segments (>%d)", MAX_SEGMENTTYPES);
	}

	org = &segmentTypes[numSegmentTypes - 1];
	for (idnum = 1; idnum < count; idnum++) {
		efhSegmentType_t* seg;

		seg = &segmentTypes[numSegmentTypes++];

		*seg = *org;
		seg->idnum = idnum;
	}

	G_FreeEntity(ent);
}


/*
==============
JUHOX: SP_efh_model
==============
*/
static void SP_efh_model(gentity_t* ent) {
	if (g_gametype.integer != GT_EFH) {
		G_FreeEntity(ent);
		return;
	}

	ent->s.modelindex = G_ModelIndex(ent->model);
	InitMover(ent);
	VectorCopy(ent->s.origin, ent->s.pos.trBase);
	VectorCopy(ent->s.origin, ent->r.currentOrigin);
	VectorCopy(ent->s.angles, ent->s.apos.trBase);
	ent->entClass = GEC_efh_model;
}


/*
==============
JUHOX: SP_efh_brush
==============
*/
static void SP_efh_brush(gentity_t* ent) {
	if (g_gametype.integer != GT_EFH) {
		G_FreeEntity(ent);
		return;
	}

	trap_SetBrushModel(ent, ent->model);
	ent->r.svFlags = SVF_USE_CURRENT_ORIGIN;
	ent->s.eType = ET_MOVER;
	trap_LinkEntity(ent);
	ent->entClass = GEC_efh_brush;
}

/*
==============
JUHOX: SP_efh_null_brush
==============
*/
static void SP_efh_null_brush(gentity_t* ent) {
	G_FreeEntity(ent);
}


/*
==============
JUHOX: SP_efh_entrance
==============
*/
static void SP_efh_entrance(gentity_t* ent) {
	if (g_gametype.integer != GT_EFH) {
		G_FreeEntity(ent);
		return;
	}

	ent->entClass = GEC_efh_entrance;
}


/*
==============
JUHOX: SP_efh_exit
==============
*/
static void SP_efh_exit(gentity_t* ent) {
	if (g_gametype.integer != GT_EFH) {
		G_FreeEntity(ent);
		return;
	}

	ent->entClass = GEC_efh_exit;
}


/*
==============
JUHOX: SP_efh_monster
==============
*/
static void SP_efh_monster(gentity_t* ent) {
	if (g_gametype.integer != GT_EFH) {
		G_FreeEntity(ent);
		return;
	}

	G_SpawnInt("type", "0", &ent->s.otherEntityNum);
	ent->entClass = GEC_efh_monster;
}


/*
==============
JUHOX: SP_efh_waypoint
==============
*/
static void SP_efh_waypoint(gentity_t* ent) {
	if (g_gametype.integer != GT_EFH) {
		G_FreeEntity(ent);
		return;
	}

	ent->entClass = GEC_efh_waypoint;
}


/*
==============
JUHOX: IsWorldOriginInsideSegment
==============
*/
static qboolean IsWorldOriginInsideSegment(
	const efhVector_t* origin,
	const efhSegmentType_t* segType,
	const efhVector_t* segOrigin
) {
	if (origin->x - segOrigin->x < segType->boundingMin[0] - 8) return qfalse;
	if (origin->x - segOrigin->x > segType->boundingMax[0] + 8) return qfalse;
	if (origin->y - segOrigin->y < segType->boundingMin[1] - 8) return qfalse;
	if (origin->y - segOrigin->y > segType->boundingMax[1] + 8) return qfalse;
	if (origin->z - segOrigin->z < segType->boundingMin[2] - 8) return qfalse;
	if (origin->z - segOrigin->z > segType->boundingMax[2] + 8) return qfalse;
	return qtrue;
}



/*
==============
JUHOX: G_FindSegment
==============
*/
int G_FindSegment(const vec3_t mapOrigin, efhVector_t* segOrigin) {
	efhVector_t worldOrigin;
	efhVector_t segOrgBack;
	efhVector_t segOrgForw;

	int index;

	if (g_gametype.integer != GT_EFH) return -1;

	MapOriginToWorldOrigin(mapOrigin, &worldOrigin);
	segOrgBack = currentSegmentOrigin;
	segOrgForw = currentSegmentOrigin;

	index = 0;
	do {
		int segment;
		const efhSegmentType_t* segType;

		segment = currentSegment + index;
		if (segment <= maxSegment) {
			segType = efhWorld[segment];

			if (IsWorldOriginInsideSegment(&worldOrigin, segType, &segOrgForw)) {
				if (segOrigin) *segOrigin = segOrgForw;
				return segment;
			}

			segOrgForw.x += segType->exitDelta.x;
			segOrgForw.y += segType->exitDelta.y;
			segOrgForw.z += segType->exitDelta.z;
		}

		segment = currentSegment - index - 1;
		if (segment >= 0) {
			segType = efhWorld[segment];

			segOrgBack.x -= segType->exitDelta.x;
			segOrgBack.y -= segType->exitDelta.y;
			segOrgBack.z -= segType->exitDelta.z;

			if (IsWorldOriginInsideSegment(&worldOrigin, segType, &segOrgBack)) {
				if (segOrigin) *segOrigin = segOrgBack;
				return segment;
			}
		}

		index++;
	} while (index < 50);

	//return nearestSegment;
	return -1;
}


/*
==============
JUHOX: FindSegmentOrigin
==============
*/
static void FindSegmentOrigin(int segment, efhVector_t* segOrg) {
	efhVector_t origin;
	int s;

	origin = currentSegmentOrigin;
	s = currentSegment;

	while (s < segment) {
		const efhSegmentType_t* segType;

		segType = efhWorld[s];
		origin.x += segType->exitDelta.x;
		origin.y += segType->exitDelta.y;
		origin.z += segType->exitDelta.z;
		s++;
	}

	while (s > segment) {
		const efhSegmentType_t* segType;

		s--;
		segType = efhWorld[s];
		origin.x -= segType->exitDelta.x;
		origin.y -= segType->exitDelta.y;
		origin.z -= segType->exitDelta.z;
	}

	*segOrg = origin;
}


/*
==============
JUHOX: ActivateSegment
==============
*/
static void ActivateSegment(int segment, const efhVector_t* segOrg, efhSegmentState_t state) {
	if (segment < 0 || segment > maxSegment) {
		G_Error("^1BUG! ActivateSegment: segment=%d, max=%d\n", segment, maxSegment);
		return;
	}

	if (newSegmentState[segment] >= state) return;

	newSegmentState[segment] = state;

	if (segmentState[segment] < state) {
		efhSegmentType_t* segType;
		vec3_t mapOrigin;
		efhSpawnCommand_t cmd;

		segType = efhWorld[segment];
		if (!segType) {
			G_Error("^1BUG! ActivateSegment: segment=%d, max=%d, type=NULL\n", segment, maxSegment);
		}
		WorldOriginToMapOrigin(segOrg, mapOrigin);

		if (state == ESS_solidPartSpawned) {
			cmd = ESC_spawnSolidOnly;
		}
		else if (segmentState[segment] == ESS_solidPartSpawned) {
			cmd = ESC_spawnNonSolidOnly;
		}
		else {
			cmd = ESC_spawnCompletely;
		}

		SpawnSegment(segType, mapOrigin, segment, segOrg, cmd);
	}
}


/*
==============
JUHOX: G_SpawnWorld
==============
*/
void G_SpawnWorld(void) {
	efhVector_t origin;

	if (g_gametype.integer != GT_EFH) return;
#if MEETING
	if (level.meeting) return;
#endif
	origin.x = 0;
	origin.y = 0;
	origin.z = 0;
	ActivateSegment(0, &origin, ESS_spawned);
}


/*
==============
JUHOX: G_UpdateSegmentInfo

clients get the segment number of each player and mover,
so they can decide about whether to draw them
==============
*/
static void G_UpdateSegmentInfo(void) {
	int i;

	for (i = 0; i < level.num_entities; i++) {
		gentity_t* ent;

		ent = &g_entities[i];
		if (!ent->inuse) continue;

		switch (ent->s.eType) {
		case ET_PLAYER:
			ent->s.constantLight = ent->worldSegment - 1;
			break;
		}
	}
}


/*
==============
JUHOX: DeleteUnusedEntities
==============
*/
static void DeleteUnusedEntities(void) {
	int i;

	for (i = MAX_CLIENTS; i < level.num_entities; i++) {
		gentity_t* ent;
		playerState_t* ps;
		int segment;

		ent = &g_entities[i];
		if (!ent->inuse) continue;
		if (ent->neverFree) continue;

		ps = G_GetEntityPlayerState(ent);
		if (ps) {
			segment = G_FindSegment(ps->origin, NULL);
			if (segment >= 0) {
				ent->worldSegment = segment + 1;
			}
			else if (ent->worldSegment) {
				segment = ent->worldSegment - 1;
			}
			else {
				continue;
			}
		}
		else if (ent->worldSegment) {
			segment = ent->worldSegment - 1;
		}
		else {
			continue;
		}

		if (ent->s.eType == ET_MOVER) {
			switch (newSegmentState[segment]) {
			case ESS_removed:
				G_FreeEntity(ent);
				break;
			case ESS_solidPartSpawned:
				if (!(ent->r.svFlags & SVF_NOCLIENT)) {
					ent->r.svFlags |= SVF_NOCLIENT;
					trap_LinkEntity(ent);
				}
				break;
			case ESS_spawned:
				if (ent->r.svFlags & SVF_NOCLIENT) {
					ent->r.svFlags &= ~SVF_NOCLIENT;
					trap_LinkEntity(ent);
				}
				break;
			}
		}
		else {
			if (newSegmentState[segment] >= ESS_spawned) continue;

			if (ent->monster) {
				if (ent->health > 0) {
					int cacheIndex;

					cacheIndex = G_GetMonsterGeneric1(ent);
					if (cacheIndex >= 0 && cacheIndex < MAX_CACHED_MONSTERS) {
						efhCachedMonster_t* cache;
						playerState_t* ps;
						vec3_t origin;

						cache = &cachedMonsters[cacheIndex];
						cache->currentSegment = segment;
						ps = G_GetEntityPlayerState(ent);
						VectorCopy(ps->origin, origin);
						cache->position.x = (long) (level.referenceOrigin.x + origin[0]);
						cache->position.y = (long) (level.referenceOrigin.y + origin[1]);
						cache->position.z = (long) (level.referenceOrigin.z + origin[2]);
						VectorCopy(ps->viewangles, cache->angles);
						cache->spawnmode = MSM_atOrigin;
						cache->action = G_MonsterAction(ent);
						if (cache->action != MA_sleeping) {
							cache->action = MA_waiting;
						}
					}
				}
				G_KillMonster(ent);
			}
			else {
				G_FreeEntity(ent);
			}
		}
	}
}

/*
==============
JUHOX: G_UpdateWorld
==============
*/
void G_UpdateWorld(void) {
	int i;
	qboolean update;
	qboolean currentSegmentUpdated;
	int debugClient;

	if (g_gametype.integer != GT_EFH) return;

	ExtendWorld();

#if MEETING
	if (level.meeting) return;
#endif

	memset(&newSegmentState, ESS_removed, sizeof(newSegmentState));

	update = qfalse;
	currentSegmentUpdated = qfalse;
	debugSegment = -1;
	debugClient = -1;
	for (i = 0; i < level.maxclients; i++) {
		int segment;
		efhVector_t segOrg;
		efhVector_t clientOrg;
		int s;
		int limit;
		efhVector_t sOrg;
		const efhSegmentType_t* segType;
		efhVector_t minOrg;
		efhVector_t maxOrg;

		if (level.clients[i].pers.connected != CON_CONNECTED) continue;

		segment = G_FindSegment(level.clients[i].ps.origin, &segOrg);
		if (segment < 0) {
			segment = g_entities[i].worldSegment - 1;
			if (segment < 0) continue;
			FindSegmentOrigin(segment, &segOrg);
		}
		else if (!currentSegmentUpdated) {
			if (currentSegment != segment) {
				trap_SetConfigstring(
					CS_EFH_SEGMENT,
					va(
						"%s^7 at %s",
						level.clients[i].pers.netname,
						SegmentName(efhWorld[segment])
					)
				);
			}
			currentSegment = segment;
			currentSegmentOrigin = segOrg;
			currentSegmentUpdated = qtrue;
		}

		g_entities[i].worldSegment = segment + 1;
		if (segment > debugSegment) {
			debugSegment = segment;
			debugClient = i;
		}
		MapOriginToWorldOrigin(level.clients[i].ps.origin, &clientOrg);

		minOrg.x = clientOrg.x - MAX_VIEWDISTANCE;
		minOrg.y = clientOrg.y - MAX_VIEWDISTANCE;
		minOrg.z = clientOrg.z - MAX_VIEWDISTANCE;

		maxOrg.x = clientOrg.x + MAX_VIEWDISTANCE;
		maxOrg.y = clientOrg.y + MAX_VIEWDISTANCE;
		maxOrg.z = clientOrg.z + MAX_VIEWDISTANCE;

		sOrg = segOrg;
		s = segment;
		segType = efhWorld[s];
		do {
			ActivateSegment(s, &sOrg, ESS_spawned);
			limit = s;

			if (segType->visBlocking && s != segment) break;

			if (sOrg.x < minOrg.x) break;
			if (sOrg.y < minOrg.y) break;
			if (sOrg.z < minOrg.z) break;

			if (sOrg.x > maxOrg.x) break;
			if (sOrg.y > maxOrg.y) break;
			if (sOrg.z > maxOrg.z) break;

			s--;
			if (s < 0) break;

			segType = efhWorld[s];
			sOrg.x -= segType->exitDelta.x;
			sOrg.y -= segType->exitDelta.y;
			sOrg.z -= segType->exitDelta.z;
		} while (1);
		s--;
		if (s >= 0) {
			segType = efhWorld[s];
			sOrg.x -= segType->exitDelta.x;
			sOrg.y -= segType->exitDelta.y;
			sOrg.z -= segType->exitDelta.z;
			ActivateSegment(s, &sOrg, ESS_solidPartSpawned);
		}
		level.clients[i].ps.persistant[PERS_MIN_SEGMENT] = limit;

		sOrg = segOrg;
		s = segment;
		limit = segment;
		segType = efhWorld[s];
		do {
			sOrg.x += segType->exitDelta.x;
			sOrg.y += segType->exitDelta.y;
			sOrg.z += segType->exitDelta.z;

			s++;
			if (s > maxSegment) break;

			ActivateSegment(s, &sOrg, ESS_spawned);
			limit = s;

			segType = efhWorld[s];
			if (segType->visBlocking) break;
		} while (
			sOrg.x >= minOrg.x &&
			sOrg.y >= minOrg.y &&
			sOrg.z >= minOrg.z &&
			sOrg.x <= maxOrg.x &&
			sOrg.y <= maxOrg.y &&
			sOrg.z <= maxOrg.z
		);
		s++;
		if (s <= maxSegment) {
			sOrg.x += segType->exitDelta.x;
			sOrg.y += segType->exitDelta.y;
			sOrg.z += segType->exitDelta.z;
			ActivateSegment(s, &sOrg, ESS_solidPartSpawned);
		}
		level.clients[i].ps.persistant[PERS_MAX_SEGMENT] = limit;

		update = qtrue;
	}

	if (debugClient >= 0) {
		vec3_t dir;

		AngleVectors(level.clients[debugClient].ps.viewangles, dir, NULL, NULL);
		debugSegment += dir[0] < 0? -1 : +1;
	}

	if (!update) return;

	DeleteUnusedEntities();

	memcpy(&segmentState, &newSegmentState, sizeof(segmentState));

	SpawnCachedMonsters();

	G_UpdateSegmentInfo();
}


/*
==============
JUHOX: G_MakeWorldAwareOfMonsterDeath
==============
*/
void G_MakeWorldAwareOfMonsterDeath(gentity_t* monster) {
	int cacheIndex;
	efhCachedMonster_t* cache;

	if (g_gametype.integer != GT_EFH) return;

	cacheIndex = G_GetMonsterGeneric1(monster);
	if (cacheIndex < 0 || cacheIndex >= MAX_CACHED_MONSTERS) return;

	cache = &cachedMonsters[cacheIndex];
	FreeMonsterCache(cache);
}


/*
==============
JUHOX: G_GetTotalWayLength
==============
*/
long G_GetTotalWayLength(gentity_t* ent) {
	playerState_t* ps;
	vec3_t origin;
	int segment;
	efhVector_t segOrg;

	if (g_gametype.integer != GT_EFH) return 0;

	ps = G_GetEntityPlayerState(ent);
	if (ps) {
		VectorCopy(ps->origin, origin);
	}
	else {
		VectorCopy(ent->r.currentOrigin, origin);
	}

	segment = G_FindSegment(origin, &segOrg);
	if (segment < 0) {
		segment = ent->worldSegment - 1;
		if (segment < 0) return 0;
		FindSegmentOrigin(segment, &segOrg);
	}
	if (segment <= 0) return 0;

	return totalWayLength[segment] + SegmentWayLength(origin, efhWorld[segment], &segOrg);
}


/*
==============
JUHOX: G_GetLightingOrigin
==============
*/
static void G_GetLightingOrigin(gentity_t* ent, vec3_t lightingOrigin) {
	playerState_t* ps;
	vec3_t origin;
	int segment;
	efhVector_t segOrg;
	vec3_t segMapOrg;
	vec3_t delta;

	ps = G_GetEntityPlayerState(ent);
	if (ps) {
		VectorCopy(ps->origin, origin);
	}
	else {
		VectorCopy(ent->r.currentOrigin, origin);
	}
	segment = G_FindSegment(origin, &segOrg);
	if (segment < 0) {
		segment = currentSegment;
		segOrg = currentSegmentOrigin;
	}
	WorldOriginToMapOrigin(&segOrg, segMapOrg);
	VectorSubtract(origin, segMapOrg, delta);
	VectorAdd(efhWorld[segment]->entranceOrigin, delta, lightingOrigin);
}


/*
==============
JUHOX: G_UpdateLightingOrigins
==============
*/
void G_UpdateLightingOrigins(void) {
	int i;

	if (g_gametype.integer != GT_EFH) return;

	for (i = 0; i < level.num_entities; i++) {
		gentity_t* ent;
		playerState_t* ps;
		vec3_t lightingOrigin;

		ent = &g_entities[i];
		if (!ent->inuse) continue;
		if (ent->freeAfterEvent) continue;
		if (!ent->r.linked) continue;
		if (ent->s.solid == SOLID_BMODEL) continue;
		if (ent->s.eFlags & EF_NODRAW) continue;
		if (ent->r.svFlags & SVF_NOCLIENT) continue;
		switch (ent->s.eType) {
		case ET_GENERAL:
		case ET_MISSILE:
			continue;
		case ET_ITEM:
			if (ent->s.pos.trType == TR_STATIONARY) continue;
			break;
		}

		G_GetLightingOrigin(ent, lightingOrigin);

		ps = G_GetEntityPlayerState(ent);
		if (ps) {
			ps->persistant[PERS_LIGHT_X] = lightingOrigin[0];
			ps->persistant[PERS_LIGHT_Y] = lightingOrigin[1];
			ps->persistant[PERS_LIGHT_Z] = lightingOrigin[2];
		}
		else {
			VectorCopy(lightingOrigin, ent->s.angles2);
		}
	}
}


/*
==============
JUHOX: G_EFH_SpaceExtent
==============
*/
void G_EFH_SpaceExtent(vec3_t mins, vec3_t maxs) {
	VectorCopy(efhSpaceMins, mins);
	VectorCopy(efhSpaceMaxs, maxs);
}


/*
==============
JUHOX: G_EFH_NextDebugSegment
==============
*/
void G_EFH_NextDebugSegment(int dir) {
	if (g_gametype.integer != GT_EFH) return;
	if (!g_debugEFH.integer) return;
	if (numSegmentTypes <= 0) return;

	dir %= numSegmentTypes;
	dir += numSegmentTypes;
	debugModeChoosenSegmentType += dir;
	debugModeChoosenSegmentType %= numSegmentTypes;
	trap_SetConfigstring(
		CS_EFH_DEBUG,
		va(
			"'%s' #%d/%d @%d",
			segmentTypes[debugModeChoosenSegmentType].name,
			debugModeChoosenSegmentType + 1,
			numSegmentTypes,
			debugSegment
		)
	);
}

