// Copyright (C) 1999-2000 Id Software, Inc.
//
// g_bot.c

#include "g_local.h"

static int		g_numBots;
static char		*g_botInfos[MAX_BOTS];

int				g_numArenas;
static char		*g_arenaInfos[MAX_ARENAS];

#define BOT_BEGIN_DELAY_BASE		2000
#define BOT_BEGIN_DELAY_INCREMENT	1500
#define BOT_SPAWN_QUEUE_DEPTH	16

typedef struct {
	int		clientNum;
	int		spawnTime;
} botSpawnQueue_t;

//static int			botBeginDelay = 0;  // bk001206 - unused, init
static botSpawnQueue_t	botSpawnQueue[BOT_SPAWN_QUEUE_DEPTH];

vmCvar_t bot_minplayers;

// JUHOX: monster types
typedef enum {
	HP_entry,
	HP_morphing,
	HP_raising,
	HP_sleeping,
	HP_falling
} hibernationPhase_t;
typedef struct gmonster_s {
	struct gmonster_s* next;
	gentity_t* entity;
	playerState_t ps;
	monsterType_t type;
	int clientNum;
	int owner;
	usercmd_t cmd;
	qboolean superJump;
	localseed_t seed;
	int removeTime;
	int nextHealthRefresh;
	int lastAIFrame;
	int nextAIFrame;
	monsterAction_t action;
	qboolean walk;
	gentity_t* enemy;
	int enemyFoundTime;
	int lastEnemyHitTime;
	int oldEnemyEFlags;
	int oldEFlags;
	qboolean freezeView;
	qboolean enemyWasInView;
	int nextDodgeTime;
	int dodgeDir;
	int nextEnemyVisCheck;
	int nextViewSearch;
	int nextDynViewSearch;
	int nextEnemySearch;
	int nextSpawnPoolCheck;
	vec3_t lastCheckedSpawnPos;
	vec3_t ideal_view;
	gentity_t* sourceOfNoise;

	gentity_t* lastHurtEntity;
	int lastHurtTime;
	int timeOfBodyCopying;

	playerState_t* avoidPlayer;
	int startAvoidPlayerTime;
	int stopAvoidPlayerTime;

	int hibernationTime;
	int hibernationWaitTime;
	hibernationPhase_t hibernationPhase;
	vec3_t hibernationSpot;
	int hibernationBrood;

	// charge damage computation
	float lastChargeAmount;
	float chargeDamageResidual;
	int lastChargeTime;

	int generic1;
} gmonster_t;
typedef struct {
	vec3_t origin;
	gentity_t* seed;
} monsterSeed_t;
typedef struct {
	vec3_t origin;
	int numMonsters;
} monsterTrap_t;

// JUHOX: monster variables
static int numMonsters;
static int nextMonsterSpawnTime;
#define MAX_MONSTER_SEEDS 200
static int firstMonsterSeed;
static int lastMonsterSeed;
static monsterSeed_t monsterSeeds[MAX_MONSTER_SEEDS];
#define MAX_MONSTER_TRAPS 20
static int firstMonsterTrap;
static int lastMonsterTrap;
static monsterTrap_t monsterTraps[MAX_MONSTER_TRAPS];
static gmonster_t monsterInfo[MAX_MONSTERS];
static gmonster_t* freeMonster;
#define MONSTER_SPAWNPOOL_SIZE 4096
static vec3_t monsterSpawnPool[MONSTER_SPAWNPOOL_SIZE];
static int numMonsterSpawnPoolEntries;

extern gentity_t	*podium1;
extern gentity_t	*podium2;
extern gentity_t	*podium3;

float trap_Cvar_VariableValue( const char *var_name ) {
	char buf[128];

	trap_Cvar_VariableStringBuffer(var_name, buf, sizeof(buf));
	return atof(buf);
}


/*
===============
G_ParseInfos
===============
*/
int G_ParseInfos( char *buf, int max, char *infos[] ) {
	char	*token;
	int		count;
	char	key[MAX_TOKEN_CHARS];
	char	info[MAX_INFO_STRING];

	count = 0;

	while ( 1 ) {
		token = COM_Parse( &buf );
		if ( !token[0] ) {
			break;
		}
		if ( strcmp( token, "{" ) ) {
			Com_Printf( "Missing { in info file\n" );
			break;
		}

		if ( count == max ) {
			Com_Printf( "Max infos exceeded\n" );
			break;
		}

		info[0] = '\0';
		while ( 1 ) {
			token = COM_ParseExt( &buf, qtrue );
			if ( !token[0] ) {
				Com_Printf( "Unexpected end of info file\n" );
				break;
			}
			if ( !strcmp( token, "}" ) ) {
				break;
			}
			Q_strncpyz( key, token, sizeof( key ) );

			token = COM_ParseExt( &buf, qfalse );
			if ( !token[0] ) {
				strcpy( token, "<NULL>" );
			}
			Info_SetValueForKey( info, key, token );
		}
		//NOTE: extra space for arena number
		infos[count] = G_Alloc(strlen(info) + strlen("\\num\\") + strlen(va("%d", MAX_ARENAS)) + 1);
		if (infos[count]) {
			strcpy(infos[count], info);
			count++;
		}
	}
	return count;
}

/*
===============
G_LoadArenasFromFile
===============
*/
static void G_LoadArenasFromFile( char *filename ) {
	int				len;
	fileHandle_t	f;
	char			buf[MAX_ARENAS_TEXT];

	len = trap_FS_FOpenFile( filename, &f, FS_READ );
	if ( !f ) {
		trap_Print( va( S_COLOR_RED "file not found: %s\n", filename ) );
		return;
	}
	if ( len >= MAX_ARENAS_TEXT ) {
		trap_Print( va( S_COLOR_RED "file too large: %s is %i, max allowed is %i", filename, len, MAX_ARENAS_TEXT ) );
		trap_FS_FCloseFile( f );
		return;
	}

	trap_FS_Read( buf, len, f );
	buf[len] = 0;
	trap_FS_FCloseFile( f );

	g_numArenas += G_ParseInfos( buf, MAX_ARENAS - g_numArenas, &g_arenaInfos[g_numArenas] );
}

/*
===============
G_LoadArenas
===============
*/
static void G_LoadArenas( void ) {
	int			numdirs;
	vmCvar_t	arenasFile;
	char		filename[128];
	char		dirlist[1024];
	char*		dirptr;
	int			i, n;
	int			dirlen;

	g_numArenas = 0;

	trap_Cvar_Register( &arenasFile, "g_arenasFile", "", CVAR_INIT|CVAR_ROM );
	if( *arenasFile.string ) {
		G_LoadArenasFromFile(arenasFile.string);
	}
	else {
		G_LoadArenasFromFile("scripts/arenas.txt");
	}

	// get all arenas from .arena files
	numdirs = trap_FS_GetFileList("scripts", ".arena", dirlist, 1024 );
	dirptr  = dirlist;
	for (i = 0; i < numdirs; i++, dirptr += dirlen+1) {
		dirlen = strlen(dirptr);
		strcpy(filename, "scripts/");
		strcat(filename, dirptr);
		G_LoadArenasFromFile(filename);
	}
	trap_Print( va( "%i arenas parsed\n", g_numArenas ) );

	for( n = 0; n < g_numArenas; n++ ) {
		Info_SetValueForKey( g_arenaInfos[n], "num", va( "%i", n ) );
	}
}


/*
===============
G_GetArenaInfoByNumber
===============
*/
const char *G_GetArenaInfoByMap( const char *map ) {
	int			n;

	for( n = 0; n < g_numArenas; n++ ) {
		if( Q_stricmp( Info_ValueForKey( g_arenaInfos[n], "map" ), map ) == 0 ) {
			return g_arenaInfos[n];
		}
	}

	return NULL;
}


/*
=================
PlayerIntroSound
=================
*/
static void PlayerIntroSound( const char *modelAndSkin ) {
	char	model[MAX_QPATH];
	char	*skin;

	Q_strncpyz( model, modelAndSkin, sizeof(model) );
	skin = Q_strrchr( model, '/' );
	if ( skin ) {
		*skin++ = '\0';
	}
	else {
		skin = model;
	}

	if( Q_stricmp( skin, "default" ) == 0 ) {
		skin = model;
	}

	trap_SendConsoleCommand( EXEC_APPEND, va( "play sound/player/announce/%s.wav\n", skin ) );
}

/*
===============
G_AddRandomBot
===============
*/
void G_AddRandomBot( int team ) {
	int		i, n, num;
	float	skill;
	char	*value, netname[36], *teamstr;
	gclient_t	*cl;

	num = 0;
	for ( n = 0; n < g_numBots ; n++ ) {
		value = Info_ValueForKey( g_botInfos[n], "name" );
		//
		for ( i=0 ; i< g_maxclients.integer ; i++ ) {
			cl = level.clients + i;
			if ( cl->pers.connected != CON_CONNECTED ) {
				continue;
			}
			if ( !(g_entities[cl->ps.clientNum].r.svFlags & SVF_BOT) ) {
				continue;
			}
			if ( team >= 0 && cl->sess.sessionTeam != team ) {
				continue;
			}
			if ( !Q_stricmp( value, cl->pers.netname ) ) {
				break;
			}
		}
		if (i >= g_maxclients.integer) {
			num++;
		}
	}
	num = random() * num;
	for ( n = 0; n < g_numBots ; n++ ) {
		value = Info_ValueForKey( g_botInfos[n], "name" );
		//
		for ( i=0 ; i< g_maxclients.integer ; i++ ) {
			cl = level.clients + i;
			if ( cl->pers.connected != CON_CONNECTED ) {
				continue;
			}
			if ( !(g_entities[cl->ps.clientNum].r.svFlags & SVF_BOT) ) {
				continue;
			}
			if ( team >= 0 && cl->sess.sessionTeam != team ) {
				continue;
			}
			if ( !Q_stricmp( value, cl->pers.netname ) ) {
				break;
			}
		}
		if (i >= g_maxclients.integer) {
			num--;
			if (num <= 0) {
				skill = trap_Cvar_VariableValue( "g_spSkill" );
				if (team == TEAM_RED) teamstr = "red";
				else if (team == TEAM_BLUE) teamstr = "blue";
				else teamstr = "";
				strncpy(netname, value, sizeof(netname)-1);
				netname[sizeof(netname)-1] = '\0';
				Q_CleanStr(netname);
				trap_SendConsoleCommand( EXEC_INSERT, va("addbot %s %f %s %i\n", netname, skill, teamstr, 0) );
				return;
			}
		}
	}
}

/*
===============
G_RemoveRandomBot
===============
*/
int G_RemoveRandomBot( int team ) {
	int i;
	char netname[36];
	gclient_t	*cl;

	for ( i=0 ; i< g_maxclients.integer ; i++ ) {
		cl = level.clients + i;
		if ( cl->pers.connected != CON_CONNECTED ) {
			continue;
		}
		if ( !(g_entities[cl->ps.clientNum].r.svFlags & SVF_BOT) ) {
			continue;
		}
		if ( team >= 0 && cl->sess.sessionTeam != team ) {
			continue;
		}
		strcpy(netname, cl->pers.netname);
		Q_CleanStr(netname);
		trap_SendConsoleCommand( EXEC_INSERT, va("kick %s\n", netname) );
		return qtrue;
	}
	return qfalse;
}

/*
===============
G_CountHumanPlayers
===============
*/
int G_CountHumanPlayers( int team ) {
	int i, num;
	gclient_t	*cl;

	num = 0;
	for ( i=0 ; i< g_maxclients.integer ; i++ ) {
		cl = level.clients + i;
		if ( cl->pers.connected != CON_CONNECTED ) {
			continue;
		}
		if ( g_entities[cl->ps.clientNum].r.svFlags & SVF_BOT ) {
			continue;
		}
		if ( team >= 0 && cl->sess.sessionTeam != team ) {
			continue;
		}
		num++;
	}
	return num;
}

/*
===============
G_CountBotPlayers
===============
*/
int G_CountBotPlayers( int team ) {
	int i, n, num;
	gclient_t	*cl;

	num = 0;
	for ( i=0 ; i< g_maxclients.integer ; i++ ) {
		cl = level.clients + i;
		if ( cl->pers.connected != CON_CONNECTED ) {
			continue;
		}
		if ( !(g_entities[cl->ps.clientNum].r.svFlags & SVF_BOT) ) {
			continue;
		}
		if ( team >= 0 && cl->sess.sessionTeam != team ) {
			continue;
		}
		num++;
	}
	for( n = 0; n < BOT_SPAWN_QUEUE_DEPTH; n++ ) {
		if( !botSpawnQueue[n].spawnTime ) {
			continue;
		}
		if ( botSpawnQueue[n].spawnTime > level.time ) {
			continue;
		}
		num++;
	}
	return num;
}

/*
===============
G_CheckMinimumPlayers
===============
*/
void G_CheckMinimumPlayers( void ) {
	int minplayers;
	int humanplayers, botplayers;
	static int checkminimumplayers_time;

	if (level.intermissiontime) return;
	//only check once each 10 seconds
	if (checkminimumplayers_time > level.time - 10000) {
		return;
	}
	checkminimumplayers_time = level.time;
	trap_Cvar_Update(&bot_minplayers);
	minplayers = bot_minplayers.integer;
	if (minplayers <= 0) return;

	if (g_gametype.integer >= GT_TEAM) {
		if (minplayers >= g_maxclients.integer / 2) {
			minplayers = (g_maxclients.integer / 2) -1;
		}

		humanplayers = G_CountHumanPlayers( TEAM_RED );
		botplayers = G_CountBotPlayers(	TEAM_RED );

		if (humanplayers + botplayers < minplayers) {
			G_AddRandomBot( TEAM_RED );
		} else if (humanplayers + botplayers > minplayers && botplayers) {
			G_RemoveRandomBot( TEAM_RED );
		}

		humanplayers = G_CountHumanPlayers( TEAM_BLUE );
		botplayers = G_CountBotPlayers( TEAM_BLUE );

		if (humanplayers + botplayers < minplayers) {
			G_AddRandomBot( TEAM_BLUE );
		} else if (humanplayers + botplayers > minplayers && botplayers) {
			G_RemoveRandomBot( TEAM_BLUE );
		}
	}
	else if (g_gametype.integer == GT_TOURNAMENT ) {
		if (minplayers >= g_maxclients.integer) {
			minplayers = g_maxclients.integer-1;
		}
		humanplayers = G_CountHumanPlayers( -1 );
		botplayers = G_CountBotPlayers( -1 );

		if (humanplayers + botplayers < minplayers) {
			G_AddRandomBot( TEAM_FREE );
		} else if (humanplayers + botplayers > minplayers && botplayers) {
			// try to remove spectators first
			if (!G_RemoveRandomBot( TEAM_SPECTATOR )) {
				// just remove the bot that is playing
				G_RemoveRandomBot( -1 );
			}
		}
	}
	else if (g_gametype.integer == GT_FFA) {
		if (minplayers >= g_maxclients.integer) {
			minplayers = g_maxclients.integer-1;
		}
		humanplayers = G_CountHumanPlayers( TEAM_FREE );
		botplayers = G_CountBotPlayers( TEAM_FREE );

		if (humanplayers + botplayers < minplayers) {
			G_AddRandomBot( TEAM_FREE );
		} else if (humanplayers + botplayers > minplayers && botplayers) {
			G_RemoveRandomBot( TEAM_FREE );
		}
	}
}

/*
===============
G_CheckBotSpawn
===============
*/
void G_CheckBotSpawn( void ) {
	int		n;
	char	userinfo[MAX_INFO_VALUE];

	G_CheckMinimumPlayers();

	for( n = 0; n < BOT_SPAWN_QUEUE_DEPTH; n++ ) {
		if( !botSpawnQueue[n].spawnTime ) {
			continue;
		}
		if ( botSpawnQueue[n].spawnTime > level.time ) {
			continue;
		}
		ClientBegin( botSpawnQueue[n].clientNum );
		botSpawnQueue[n].spawnTime = 0;

		if( g_gametype.integer == GT_SINGLE_PLAYER ) {
			trap_GetUserinfo( botSpawnQueue[n].clientNum, userinfo, sizeof(userinfo) );
			PlayerIntroSound( Info_ValueForKey (userinfo, "model") );
		}
	}
}


/*
===============
AddBotToSpawnQueue
===============
*/
static void AddBotToSpawnQueue( int clientNum, int delay ) {
	int		n;

	for( n = 0; n < BOT_SPAWN_QUEUE_DEPTH; n++ ) {
		if( !botSpawnQueue[n].spawnTime ) {
			botSpawnQueue[n].spawnTime = level.time + delay;
			botSpawnQueue[n].clientNum = clientNum;
			return;
		}
	}

	G_Printf( S_COLOR_YELLOW "Unable to delay spawn\n" );
	ClientBegin( clientNum );
}


/*
===============
G_RemoveQueuedBotBegin

Called on client disconnect to make sure the delayed spawn
doesn't happen on a freed index
===============
*/
void G_RemoveQueuedBotBegin( int clientNum ) {
	int		n;

	for( n = 0; n < BOT_SPAWN_QUEUE_DEPTH; n++ ) {
		if( botSpawnQueue[n].clientNum == clientNum ) {
			botSpawnQueue[n].spawnTime = 0;
			return;
		}
	}
}


/*
===============
G_BotConnect
===============
*/
qboolean G_BotConnect( int clientNum, qboolean restart ) {
	bot_settings_t	settings;
	char			userinfo[MAX_INFO_STRING];

	trap_GetUserinfo( clientNum, userinfo, sizeof(userinfo) );

	Q_strncpyz( settings.characterfile, Info_ValueForKey( userinfo, "characterfile" ), sizeof(settings.characterfile) );
	settings.skill = atof( Info_ValueForKey( userinfo, "skill" ) );
	Q_strncpyz( settings.team, Info_ValueForKey( userinfo, "team" ), sizeof(settings.team) );
	settings.arenaLord = atoi(Info_ValueForKey(userinfo, "arenaLord"));	// JUHOX

	if (!BotAISetupClient( clientNum, &settings, restart )) {
		trap_DropClient( clientNum, "BotAISetupClient failed" );
		return qfalse;
	}

	return qtrue;
}


/*
===============
JUHOX: IsClientNameInUse
===============
*/
static int IsClientNameInUse(char* name) {
	int i;

	for (i = 0; i < MAX_CLIENTS; i++) {
		if (level.clients[i].pers.connected == CON_DISCONNECTED) continue;
		if (!Q_stricmp(name, level.clients[i].pers.netname)) return qtrue;
	}
	return qfalse;
}

/*
===============
G_AddBot
===============
*/
static void G_AddBot( const char *name, float skill, const char *team, int delay, char *altname) {
	int				clientNum;
	char			*botinfo;
	gentity_t		*bot;
	char			*key;
	char			*s;
	char			*botname;
	char			*model;
	char			*headmodel;
	char			userinfo[MAX_INFO_STRING];

	// JUHOX: no bots in EFH
	if (g_gametype.integer == GT_EFH) return;


	// get the botinfo from bots.txt
	botinfo = G_GetBotInfoByName( name );
	if ( !botinfo ) {
		G_Printf( S_COLOR_RED "Error: Bot '%s' not defined\n", name );
		return;
	}

	// create the bot's userinfo
	userinfo[0] = '\0';

	botname = Info_ValueForKey( botinfo, "funname" );
	if( !botname[0] ) {
		botname = Info_ValueForKey( botinfo, "name" );
	}
	// check for an alternative name
	if (altname && altname[0]) {
		botname = altname;
	}
	// JUHOX: if there is already a client with that name use another one

	if (IsClientNameInUse(botname)) {
		int ext;
		static char buf[MAX_NETNAME];

		if (strlen(botname) > MAX_NETNAME-2) botname[MAX_NETNAME-2] = 0;
		ext = 2;
		Com_sprintf(buf, sizeof(buf), "%s%d", botname, ext);
		while (IsClientNameInUse(buf)) {
			ext++;
			if (ext > 9 && strlen(botname) > MAX_NETNAME-3) botname[MAX_NETNAME-3] = 0;
			else if (ext > 99 && strlen(botname) > MAX_NETNAME-4) botname[MAX_NETNAME-4] = 0;
			Com_sprintf(buf, sizeof(buf), "%s%d", botname, ext);
		}
		botname = buf;
	}

	Info_SetValueForKey( userinfo, "name", botname );
	Info_SetValueForKey( userinfo, "rate", "25000" );
	Info_SetValueForKey( userinfo, "snaps", "20" );
	Info_SetValueForKey( userinfo, "skill", va("%1.2f", skill) );

	if ( skill >= 1 && skill < 2 ) {
		Info_SetValueForKey( userinfo, "handicap", "50" );
	}
	else if ( skill >= 2 && skill < 3 ) {
		Info_SetValueForKey( userinfo, "handicap", "70" );
	}
	else if ( skill >= 3 && skill < 4 ) {
		Info_SetValueForKey( userinfo, "handicap", "90" );
	}

	key = "model";
	model = Info_ValueForKey( botinfo, key );
	if ( !*model ) {
		model = "visor/default";
	}
	Info_SetValueForKey( userinfo, key, model );
	key = "team_model";
	Info_SetValueForKey( userinfo, key, model );

	key = "headmodel";
	headmodel = Info_ValueForKey( botinfo, key );
	if ( !*headmodel ) {
		headmodel = model;
	}
	Info_SetValueForKey( userinfo, key, headmodel );
	key = "team_headmodel";
	Info_SetValueForKey( userinfo, key, headmodel );

	key = "gender";
	s = Info_ValueForKey( botinfo, key );
	if ( !*s ) {
		s = "male";
	}
	Info_SetValueForKey( userinfo, "sex", s );

	key = "color1";
	s = Info_ValueForKey( botinfo, key );
	if ( !*s ) {
		s = "4";
	}
	Info_SetValueForKey( userinfo, key, s );

	key = "color2";
	s = Info_ValueForKey( botinfo, key );
	if ( !*s ) {
		// JUHOX: use color1 if color2 not set
		s = Info_ValueForKey(userinfo, "color1");
	}
	Info_SetValueForKey( userinfo, key, s );

	s = Info_ValueForKey(botinfo, "aifile");
	if (!*s ) {
		trap_Print( S_COLOR_RED "Error: bot has no aifile specified\n" );
		return;
	}

	// have the server allocate a client slot
	clientNum = trap_BotAllocateClient();
	if ( clientNum == -1 ) {
		G_Printf( S_COLOR_RED "Unable to add bot.  All player slots are in use.\n" );
		G_Printf( S_COLOR_RED "Start server with more 'open' slots (or check setting of sv_maxclients cvar).\n" );
		return;
	}

	// initialize the bot settings
	if( !team || !*team ) {
		if( g_gametype.integer >= GT_TEAM ) {
			if( PickTeam(clientNum) == TEAM_RED) {
				team = "red";
			}
			else {
				team = "blue";
			}
		}
		else {
			team = "red";
		}
	}
	// JUHOX: in STU all players are in the red team
	if (g_gametype.integer >= GT_STU) {
		team = "red";
	}

	Info_SetValueForKey( userinfo, "characterfile", Info_ValueForKey( botinfo, "aifile" ) );
	Info_SetValueForKey( userinfo, "skill", va( "%5.2f", skill ) );
	Info_SetValueForKey( userinfo, "team", team );

	bot = &g_entities[ clientNum ];
	bot->r.svFlags |= SVF_BOT;
	bot->inuse = qtrue;

	// register the userinfo
	trap_SetUserinfo( clientNum, userinfo );

	// have it connect to the game as a normal client
	if ( ClientConnect( clientNum, qtrue, qtrue ) ) return;

	if( delay == 0 ) {
		ClientBegin( clientNum );
		return;
	}

	AddBotToSpawnQueue( clientNum, delay );
}


/*
===============
Svcmd_AddBot_f
===============
*/
void Svcmd_AddBot_f( void ) {
	float			skill;
	int				delay;
	char			name[MAX_TOKEN_CHARS];
	char			altname[MAX_TOKEN_CHARS];
	char			string[MAX_TOKEN_CHARS];
	char			team[MAX_TOKEN_CHARS];

	// JUHOX: no bots in EFH
	if (g_gametype.integer == GT_EFH) return;

	// are bots enabled?
	if ( !trap_Cvar_VariableIntegerValue( "bot_enable" ) ) {
		return;
	}

	// name
	trap_Argv( 1, name, sizeof( name ) );
	if ( !name[0] ) {
		trap_Print( "Usage: Addbot <botname> [skill 1-5] [team] [msec delay] [altname]\n" );
		return;
	}

	// skill
	trap_Argv( 2, string, sizeof( string ) );
	if ( !string[0] ) {
		skill = 4;
	}
	else {
		skill = atof( string );
	}

	// team
	trap_Argv( 3, team, sizeof( team ) );

	// delay
	trap_Argv( 4, string, sizeof( string ) );
	if ( !string[0] ) {
		delay = 0;
	}
	else {
		delay = atoi( string );
	}

	// alternative name
	trap_Argv( 5, altname, sizeof( altname ) );

	G_AddBot( name, skill, team, delay, altname );

	// if this was issued during gameplay and we are playing locally,
	// go ahead and load the bot's media immediately
	if ( level.time - level.startTime > 1000 &&
		trap_Cvar_VariableIntegerValue( "cl_running" ) ) {
		trap_SendServerCommand( -1, "loaddefered\n" );	// FIXME: spelled wrong, but not changing for demo
	}
}

/*
===============
Svcmd_BotList_f
===============
*/
void Svcmd_BotList_f( void ) {
	int i;
	char name[MAX_TOKEN_CHARS];
	char funname[MAX_TOKEN_CHARS];
	char model[MAX_TOKEN_CHARS];
	char aifile[MAX_TOKEN_CHARS];

	trap_Print("^1name             model            aifile              funname\n");
	for (i = 0; i < g_numBots; i++) {
		strcpy(name, Info_ValueForKey( g_botInfos[i], "name" ));
		if ( !*name ) {
			strcpy(name, "UnnamedPlayer");
		}
		strcpy(funname, Info_ValueForKey( g_botInfos[i], "funname" ));
		if ( !*funname ) {
			strcpy(funname, "");
		}
		strcpy(model, Info_ValueForKey( g_botInfos[i], "model" ));
		if ( !*model ) {
			strcpy(model, "visor/default");
		}
		strcpy(aifile, Info_ValueForKey( g_botInfos[i], "aifile"));
		if (!*aifile ) {
			strcpy(aifile, "bots/default_c.c");
		}
		trap_Print(va("%-16s %-16s %-20s %-20s\n", name, model, aifile, funname));
	}
}


/*
===============
G_SpawnBots
===============
*/
static void G_SpawnBots( char *botList, int baseDelay ) {
	char		*bot;
	char		*p;
	float		skill;
	int			delay;
	char		bots[MAX_INFO_VALUE];

	podium1 = NULL;
	podium2 = NULL;
	podium3 = NULL;

	skill = trap_Cvar_VariableValue( "g_spSkill" );
	if( skill < 1 ) {
		trap_Cvar_Set( "g_spSkill", "1" );
		skill = 1;
	}
	else if ( skill > 5 ) {
		trap_Cvar_Set( "g_spSkill", "5" );
		skill = 5;
	}

	Q_strncpyz( bots, botList, sizeof(bots) );
	p = &bots[0];
	delay = baseDelay;
	while( *p ) {
		//skip spaces
		while( *p && *p == ' ' ) {
			p++;
		}
		if( !p ) {
			break;
		}

		// mark start of bot name
		bot = p;

		// skip until space of null
		while( *p && *p != ' ' ) {
			p++;
		}
		if( *p ) {
			*p++ = 0;
		}

		// we must add the bot this way, calling G_AddBot directly at this stage
		// does "Bad Things"
		trap_SendConsoleCommand( EXEC_INSERT, va("addbot %s %f free %i\n", bot, skill, delay) );

		delay += BOT_BEGIN_DELAY_INCREMENT;
	}
}


/*
===============
G_LoadBotsFromFile
===============
*/
static void G_LoadBotsFromFile( char *filename ) {
	int				len;
	fileHandle_t	f;
	char			buf[MAX_BOTS_TEXT];

	len = trap_FS_FOpenFile( filename, &f, FS_READ );
	if ( !f ) {
		trap_Print( va( S_COLOR_RED "file not found: %s\n", filename ) );
		return;
	}
	if ( len >= MAX_BOTS_TEXT ) {
		trap_Print( va( S_COLOR_RED "file too large: %s is %i, max allowed is %i", filename, len, MAX_BOTS_TEXT ) );
		trap_FS_FCloseFile( f );
		return;
	}

	trap_FS_Read( buf, len, f );
	buf[len] = 0;
	trap_FS_FCloseFile( f );

	g_numBots += G_ParseInfos( buf, MAX_BOTS - g_numBots, &g_botInfos[g_numBots] );
}

/*
===============
G_LoadBots
===============
*/
static void G_LoadBots( void ) {
	vmCvar_t	botsFile;
	int			numdirs;
	char		filename[128];
	char		dirlist[1024];
	char*		dirptr;
	int			i;
	int			dirlen;

    // JUHOX: no bots in EFH
	if (g_gametype.integer == GT_EFH) return;
	if ( !trap_Cvar_VariableIntegerValue( "bot_enable" ) ) return;

	g_numBots = 0;

	trap_Cvar_Register( &botsFile, "g_botsFile", "", CVAR_INIT|CVAR_ROM );
	if( *botsFile.string ) {
		G_LoadBotsFromFile(botsFile.string);
	}
	else {
		G_LoadBotsFromFile("scripts/bots.txt");
	}

	// get all bots from .bot files
	numdirs = trap_FS_GetFileList("scripts", ".bot", dirlist, 1024 );
	dirptr  = dirlist;
	for (i = 0; i < numdirs; i++, dirptr += dirlen+1) {
		dirlen = strlen(dirptr);
		strcpy(filename, "scripts/");
		strcat(filename, dirptr);
		G_LoadBotsFromFile(filename);
	}
	trap_Print( va( "%i bots parsed\n", g_numBots ) );
}



/*
===============
G_GetBotInfoByNumber
===============
*/
char *G_GetBotInfoByNumber( int num ) {
	if( num < 0 || num >= g_numBots ) {
		trap_Print( va( S_COLOR_RED "Invalid bot number: %i\n", num ) );
		return NULL;
	}
	return g_botInfos[num];
}


/*
===============
G_GetBotInfoByName
===============
*/
char *G_GetBotInfoByName( const char *name ) {
	int		n;
	char	*value;

	for ( n = 0; n < g_numBots ; n++ ) {
		value = Info_ValueForKey( g_botInfos[n], "name" );
		if ( !Q_stricmp( value, name ) ) {
			return g_botInfos[n];
		}
	}

	return NULL;
}

/*
===============
G_InitBots
===============
*/
void G_InitBots( qboolean restart ) {
	int			fragLimit;
	int			timeLimit;
	const char	*arenainfo;
	char		*strValue;
	int			basedelay;
	char		map[MAX_QPATH];
	char		serverinfo[MAX_INFO_STRING];

	G_LoadBots();
	G_LoadArenas();

	trap_Cvar_Register( &bot_minplayers, "bot_minplayers", "0", CVAR_SERVERINFO );

	if( g_gametype.integer == GT_SINGLE_PLAYER ) {
		trap_GetServerinfo( serverinfo, sizeof(serverinfo) );
		Q_strncpyz( map, Info_ValueForKey( serverinfo, "mapname" ), sizeof(map) );
		arenainfo = G_GetArenaInfoByMap( map );
		if ( !arenainfo ) {
			return;
		}

		strValue = Info_ValueForKey( arenainfo, "fraglimit" );
		fragLimit = atoi( strValue );
		if ( fragLimit ) {
			trap_Cvar_Set( "fraglimit", strValue );
		}
		else {
			trap_Cvar_Set( "fraglimit", "0" );
		}

		strValue = Info_ValueForKey( arenainfo, "timelimit" );
		timeLimit = atoi( strValue );
		if ( timeLimit ) {
			trap_Cvar_Set( "timelimit", strValue );
		}
		else {
			trap_Cvar_Set( "timelimit", "0" );
		}

		if ( !fragLimit && !timeLimit ) {
			trap_Cvar_Set( "fraglimit", "10" );
			trap_Cvar_Set( "timelimit", "0" );
		}

		basedelay = BOT_BEGIN_DELAY_BASE;
		strValue = Info_ValueForKey( arenainfo, "special" );
		if( Q_stricmp( strValue, "training" ) == 0 ) {
			basedelay += 10000;
		}

		if( !restart ) {
			G_SpawnBots( Info_ValueForKey( arenainfo, "bots" ), basedelay );
		}
	}
}

/*
===============
JUHOX: FreeMonsterInfo
===============
*/
static void FreeMonsterInfo(gmonster_t* monster) {
	if (!monster) return;

	// mark as unused
	monster->ps.clientNum = 0;
	monster->entity = NULL;

	monster->next = freeMonster;
	freeMonster = monster;
}

/*
===============
JUHOX: GetMonsterInfo
===============
*/
static gmonster_t* GetMonsterInfo(void) {
	gmonster_t* monster;

	if (!freeMonster) return NULL;

	monster = freeMonster;
	freeMonster = monster->next;

	memset(monster, 0, sizeof(*monster));
	return monster;
}

/*
===============
JUHOX: G_NumMonsters
===============
*/
int G_NumMonsters(void) {
	return numMonsters;
}


/*
===============
JUHOX: G_FreeMonster
===============
*/
static void G_FreeMonster(gentity_t* monster) {
	if (monster->monster) {
		FreeMonsterInfo(monster->monster);
		monster->monster = NULL;
	}
	G_FreeEntity(monster);
}


/*
===============
JUHOX: G_KillMonster
===============
*/
void G_KillMonster(gentity_t* monster) {
	if (monster->monster && monster->health > 0) {
		numMonsters--;
	}
	G_FreeMonster(monster);
}


/*
===============
JUHOX: AddMonsterSpawnPoolEntry
===============
*/
static void AddMonsterSpawnPoolEntry(const vec3_t pos) {
	if (numMonsterSpawnPoolEntries >= MONSTER_SPAWNPOOL_SIZE) return;

	VectorCopy(pos, monsterSpawnPool[numMonsterSpawnPoolEntries++]);
}


/*
===============
JUHOX: CheckMonsterSpawnPoolEntry
===============
*/
static void CheckMonsterSpawnPoolEntry(const vec3_t pos) {
	int i;

	if (numMonsterSpawnPoolEntries >= MONSTER_SPAWNPOOL_SIZE) return;

	for (i = 0; i < numMonsterSpawnPoolEntries; i++) {
		if (DistanceSquared(pos, monsterSpawnPool[i]) < 50*50) return;
	}
	AddMonsterSpawnPoolEntry(pos);
}

/*
===============
JUHOX: InitMonsterSpawnPool
===============
*/
static void InitMonsterSpawnPool(void) {
	int i;

	numMonsterSpawnPoolEntries = 0;

	for (i = 0; i < level.numEmergencySpawnPoints; i++) {
		AddMonsterSpawnPoolEntry(level.emergencySpawnPoints[i]);
	}
}

/*
===============
JUHOX: G_InitMonsters
===============
*/
void G_InitMonsters(void) {
	int i;

	numMonsters = 0;
	nextMonsterSpawnTime = -1;

	freeMonster = NULL;
	for (i = 0; i < MAX_MONSTERS; i++) {
		FreeMonsterInfo(&monsterInfo[i]);
	}

	InitMonsterSpawnPool();

	firstMonsterSeed = 0;
	lastMonsterSeed = 0;
}

/*
===============
JUHOX: G_MonsterCorrectEntityState

needed after any call to 'BG_PlayerStateToEntityState()' or 'BG_PlayerStateToEntityStateExtraPolate()'
===============
*/
static void G_MonsterCorrectEntityState(gentity_t* monster) {
	if (!monster->monster) return;

	monster->s.clientNum = monster->monster->clientNum;
	monster->s.otherEntityNum = monster->monster->owner;
	if (
		monster->monster->type == MT_titan &&
		monster->monster->action == MA_sleeping
	) {
		monster->s.otherEntityNum2 = qtrue;
	}
	else {
		monster->s.otherEntityNum2 = qfalse;
	}
}

/*
===============
JUHOX: G_UpdateMonsterCS
===============
*/
void G_UpdateMonsterCS(void) {
	trap_SetConfigstring( CS_NUMMONSTERS, va("%03d,%d", numMonsters, level.maxMonstersPerPlayer));
}

/*
===============
JUHOX: MonsterBodyDie

derived from body_die() [g_combat.c]
===============
*/
static void MonsterBodyDie(gentity_t* self, gentity_t* inflictor, gentity_t* attacker, int damage, int mod) {
	if (self->health > GIB_HEALTH) {
		return;
	}
	if (!g_blood.integer) {
		self->health = GIB_HEALTH+1;
		return;
	}

	GibEntity(self, 0);

	// NOTE: can't free the entity immediatly because it's still needed to broadcast the gib event
	self->think = G_FreeMonster;
	self->nextthink = level.time + 2000;
}


/*
===============
JUHOX: MonsterDie

derived from player_die() [combat.c]
===============
*/

static void MonsterDie(gentity_t* self, gentity_t* inflictor, gentity_t* attacker, int damage, int mod) {
	int contents;
	int killer;

	if (!self->monster) return;
	G_MakeWorldAwareOfMonsterDeath(self);

	numMonsters--;

	if (
		numMonsters < g_minMonsters.integer &&
		nextMonsterSpawnTime > level.time + 200
	) {
		nextMonsterSpawnTime = level.time + 200;
	}

	if (attacker) {
		killer = attacker->s.number;
		if (
			g_gametype.integer >= GT_STU &&
			attacker->client &&
			level.endPhase <= 0 &&
			!level.intermissionQueued &&
			!level.intermissiontime
		) {
			int score;

			switch (self->monster->type) {
			case MT_predator:
				score = 10;
				break;
			case MT_guard:
				score = 30;
				break;
			case MT_titan:
				score = 100;
				break;
			default:
				score = 0;
				break;
			}
			if (g_scoreMode.integer) {
				score = (score * self->monster->ps.stats[STAT_MAX_HEALTH]) / G_MonsterBaseHealth(self->monster->type, 5.0);
			}
			level.stuScore += score;
			attacker->client->ps.persistant[PERS_SCORE] += score;
			ScorePlum(attacker, self->r.currentOrigin, score);
		}
	}
	else {
		killer = ENTITYNUM_NONE;
	}

	contents = trap_PointContents(self->r.currentOrigin, -1);

	if (
		self->monster->ps.powerups[PW_CHARGE] - level.time >= 8500 / CHARGE_DAMAGE_PER_SECOND
	) {
		self->health = GIB_HEALTH;
	}

	self->s.powerups = 0;
	self->r.contents = CONTENTS_CORPSE;
	self->s.loopSound = 0;
	self->r.maxs[2] = -8;
	self->monster->ps.pm_type = PM_DEAD;
	memset(self->monster->ps.powerups, 0, PW_NUM_POWERUPS * sizeof(int));

	// never gib in a nodrop
	if (
		(
			self->health <= GIB_HEALTH &&
			!(contents & CONTENTS_NODROP) &&
			g_blood.integer
		) ||
		mod == MOD_SUICIDE ||
		self->monster->action == MA_hibernation
	) {
		// gib death
		GibEntity(self, killer);

		// NOTE: can't free the entity immediatly because it's still needed to broadcast the gib event
		self->think = G_FreeMonster;
		self->nextthink = level.time + 2000;
	}
	else {
		// normal death
		int i;
		int anim;

		i = rand() % 3;

		switch (i) {
		case 0:
			anim = BOTH_DEATH1;
			break;
		case 1:
			anim = BOTH_DEATH2;
			break;
		case 2:
		default:
			anim = BOTH_DEATH3;
			break;
		}

		// for the no-blood option, we need to prevent the health
		// from going to gib level
		if (self->health <= GIB_HEALTH) {
			self->health = GIB_HEALTH + 1;
		}

		self->monster->ps.legsAnim =
			((self->monster->ps.legsAnim & ANIM_TOGGLEBIT) ^ ANIM_TOGGLEBIT) | anim;
		self->monster->ps.torsoAnim =
			((self->monster->ps.torsoAnim & ANIM_TOGGLEBIT) ^ ANIM_TOGGLEBIT) | anim;

		G_AddEvent(self, EV_DEATH1 + i, killer);

		// the body can still be gibbed
		self->die = MonsterBodyDie;

		// copy anims to entityState
		BG_PlayerStateToEntityState(&self->monster->ps, &self->s, qtrue);
		G_MonsterCorrectEntityState(self);

		// JUHOX: don't copy the monster to the body que in EFH

		if (g_gametype.integer != GT_EFH) {
			self->monster->timeOfBodyCopying = level.time + 3000;
		}
	}

	trap_LinkEntity(self);
}


/*
================
JUHOX: MonsterEvents

derived from ClientEvents() [g_active.c]
================
*/
static void MonsterEvents(gentity_t* monster, int oldEventSequence) {
	int i;
	gmonster_t* mi;

	mi = monster->monster;
	if (!mi) return;

	if (oldEventSequence < mi->ps.eventSequence - MAX_PS_EVENTS) {
		oldEventSequence = mi->ps.eventSequence - MAX_PS_EVENTS;
	}
	for (i = oldEventSequence; i < mi->ps.eventSequence; i++) {
		int event;
		int damage;

		event = mi->ps.events[i & (MAX_PS_EVENTS-1)];

		switch (event) {
		case EV_FALL_MEDIUM:
		case EV_FALL_FAR:
			if (g_dmflags.integer & DF_NO_FALLING) {
				break;
			}
			if (event == EV_FALL_FAR) {
				damage = 10;
			} else {
				damage = 5;
			}
			monster->pain_debounce_time = level.time + 200;	// no normal pain sound
			G_Damage(monster, NULL, NULL, NULL, NULL, damage, 0, MOD_FALLING);
			break;

		case EV_FIRE_WEAPON:
			switch (mi->type) {
			case MT_guard:
				{
					vec3_t forward, right, up, muzzlePoint;
					gentity_t* rocket;

					AngleVectors(mi->ps.viewangles, forward, right, up);
					CalcMuzzlePoint(monster, forward, right, up, muzzlePoint);
					VectorMA(muzzlePoint, 32, right, muzzlePoint);
					//VectorMA(muzzlePoint, 8, up, muzzlePoint);
					forward[0] += crandom() * 0.05;
					forward[1] += crandom() * 0.05;
					forward[2] += crandom() * 0.05;
					VectorNormalize(forward);
					rocket = fire_rocket(monster, muzzlePoint, forward);
					rocket->methodOfDeath = MOD_GUARD;
					rocket->splashMethodOfDeath = MOD_GUARD;
				}
				break;
			default:
				break;
			}
			break;

		default:
			break;
		}
	}

}


/*
============
JUHOX: MonsterTouchTriggers

derived from G_TouchTriggers() [from g_active.c]
============
*/
static void MonsterTouchTriggers(gentity_t* monster) {
	int i, num;
	int touch[MAX_GENTITIES];
	gentity_t* hit;
	trace_t trace;
	vec3_t mins, maxs;
	static vec3_t range = { 40, 40, 52 };

	if (!monster->monster) return;

	// dead clients don't activate triggers!
	if (monster->health <= 0) {
		return;
	}

	VectorSubtract(monster->monster->ps.origin, range, mins);
	VectorAdd(monster->monster->ps.origin, range, maxs);

	num = trap_EntitiesInBox(mins, maxs, touch, MAX_GENTITIES);

	// can't use ent->absmin, because that has a one unit pad
	VectorAdd(monster->monster->ps.origin, monster->r.mins, mins);
	VectorAdd(monster->monster->ps.origin, monster->r.maxs, maxs);

	for (i=0; i < num; i++) {
		hit = &g_entities[touch[i]];

		if (!hit->touch && !monster->touch) {
			continue;
		}
		if (!(hit->r.contents & CONTENTS_TRIGGER)) {
			continue;
		}

		// use seperate code for determining if an item is picked up
		// so you don't have to actually contact its bounding box
		if (hit->s.eType == ET_ITEM) {
			// monsters don't pick up items
			continue;
		} else {
			if (!trap_EntityContact(mins, maxs, hit)) {
				continue;
			}
		}

		memset(&trace, 0, sizeof(trace));

		if (hit->touch) {
			hit->touch(hit, monster, &trace);
		}

		if (monster->touch) {
			monster->touch(monster, hit, &trace);
		}
	}

	// if we didn't touch a jump pad this pmove frame
	if (monster->monster->ps.jumppad_frame != monster->monster->ps.pmove_framecount) {
		monster->monster->ps.jumppad_frame = 0;
		monster->monster->ps.jumppad_ent = 0;
	}
}

/*
====================
JUHOX: CauseMonsterChargeDamage
====================
*/
static void CauseMonsterChargeDamage(gentity_t* monster) {
	gmonster_t* mi;

	mi = monster->monster;
	if (!mi) return;

	if (mi->lastChargeTime) {
		int n;
		float damage;
		gentity_t* attacker;

		attacker = NULL;
		n = monster->chargeInflictor;
		if (n >= 0 && n < MAX_CLIENTS) {
			attacker = &g_entities[n];
			if (!attacker->inuse || !attacker->client) attacker = NULL;
		}

		damage = mi->chargeDamageResidual + TotalChargeDamage(mi->lastChargeAmount);
		if (monster->waterlevel <= 0 || level.endPhase) {
			float time;

			time = (level.time - mi->lastChargeTime) / 1000.0;
			damage -= TotalChargeDamage(mi->lastChargeAmount - time);
		}
		else {
			mi->ps.powerups[PW_CHARGE] -= (int) (1000.0 * mi->lastChargeAmount);
		}

		n = (int) damage;
		mi->chargeDamageResidual = damage - n;

		if (n) {
			G_Damage(monster, attacker, attacker, NULL, NULL, n, 0, MOD_CHARGE);

			// make sure the monster is aware of the attack even if the damage wasn't strong enough to hurt
			if (attacker) {
				mi->lastHurtEntity = attacker;
				mi->lastHurtTime = level.time;
			}
		}
	}

	if (mi->ps.powerups[PW_CHARGE] > level.time) {
		mi->lastChargeAmount = (mi->ps.powerups[PW_CHARGE] - level.time) / 1000.0;
		mi->lastChargeTime = level.time;
	}
	else {
		mi->lastChargeAmount = 0.0;
		mi->lastChargeTime = 0;
	}
}


/*
===============
JUHOX: SetUserCmdViewAngles
===============
*/
static void SetUserCmdViewAngles(usercmd_t* cmd, const playerState_t* ps, const vec3_t angles) {
	int i;

	for (i = 0; i < 3; i++) {
		cmd->angles[i] = ANGLE2SHORT(angles[i]) - ps->delta_angles[i];
	}
}


/*
===============
JUHOX: SetMonsterViewCmd
===============
*/
#define PREDATOR_VIEW_SPEED				240.0	// degrees per second
#define PREDATOR_HIBERNATION_VIEW_SPEED	120.0
#define PREDATOR_ATTACK_VIEW_SPEED		450.0
#define GUARD_VIEW_SPEED				80.0
#define TITAN_VIEW_SPEED				250.0
static void SetMonsterViewCmd(gmonster_t* mi, int msec) {
	vec3_t diff;
	vec_t viewSpeed;
	vec_t maxDiff;
	int i;

	AnglesSubtract(mi->ideal_view, mi->ps.viewangles, diff);

	switch (mi->type) {
	case MT_predator:
	default:
		switch (mi->action) {
		case MA_attacking:
			viewSpeed = PREDATOR_ATTACK_VIEW_SPEED;
			break;
		case MA_hibernation:
			viewSpeed = PREDATOR_HIBERNATION_VIEW_SPEED;
			break;
		default:
			viewSpeed = PREDATOR_VIEW_SPEED;
			break;
		}
		break;
	case MT_guard:
		viewSpeed = GUARD_VIEW_SPEED;
		break;
	case MT_titan:
		viewSpeed = TITAN_VIEW_SPEED;
		break;
	}
	maxDiff = viewSpeed * msec / 1000.0;
	for (i = 0; i < 3; i++) {
		if (diff[i] > maxDiff) diff[i] = maxDiff;
		else if (diff[i] < -maxDiff) diff[i] = -maxDiff;

		diff[i] += mi->ps.viewangles[i];
	}

	SetUserCmdViewAngles(&mi->cmd, &mi->ps, diff);
}


/*
===============
JUHOX: EntityAudible
===============
*/
qboolean EntityAudible(const gentity_t* ent) {
	if (ent->s.eType < ET_EVENTS) {
		switch (ent->s.eType) {
		case ET_PLAYER:
		case ET_MOVER:
			break;
		case ET_MISSILE:
			switch (ent->s.weapon) {
			case WP_ROCKET_LAUNCHER:
			case WP_PLASMAGUN:
			case WP_BFG:
				return qtrue;
			}
			break;
		default:
			return qfalse;
		}
	}

	if (ent->client) {
		if (ent->s.eFlags & EF_FIRING) return qtrue;

		//switch (ent->client->ps.stats[STAT_GRAPPLE_STATE]) {
		switch GET_STAT_GRAPPLESTATE(&ent->client->ps) {
		case GST_windoff:
		case GST_rewind:
		case GST_pulling:
		case GST_blocked:
			return qtrue;
		}

		switch (ent->s.weapon) {
		case WP_LIGHTNING:
		case WP_RAILGUN:
		case WP_BFG:
			return qtrue;
		}
	}

	if (ent->eventTime < level.time - 900) return qfalse;
	switch (ent->s.event & ~EV_EVENT_BITS) {
	case EV_NONE:
	case EV_STEP_4:
	case EV_STEP_8:
	case EV_STEP_12:
	case EV_STEP_16:
		return qfalse;
	}
	return qtrue;
}

typedef struct {
	vec3_t origin;
	gentity_t* source;
} noiseSource_t;
static noiseSource_t sourcesOfNoise[MAX_GENTITIES];
static int numSourcesOfNoise;


/*
===============
JUHOX: G_MonsterScanForNoises
===============
*/
void G_MonsterScanForNoises(void) {
	int i;

	numSourcesOfNoise = 0;

	if (numMonsters <= 0) return;

	for (i = 0; i < level.num_entities; i++) {
		gentity_t* ent;

		ent = &g_entities[i];
		if (!ent->inuse) continue;
		if (!ent->r.linked) continue;

		if (ent->client) {
			if (ent->health <= 0) continue;
			if (ent->client->respawnTime > level.time - 2000) continue;
			if (ent->client->ps.powerups[PW_SHIELD]) continue;
		}

		if (!EntityAudible(ent)) continue;

		sourcesOfNoise[numSourcesOfNoise].source = ent;
		if (ent->client) {
			VectorCopy(ent->client->ps.origin, sourcesOfNoise[numSourcesOfNoise].origin);
		}
		else if (ent->monster) {
			VectorCopy(ent->monster->ps.origin, sourcesOfNoise[numSourcesOfNoise].origin);
		}
		else {
			vec3_t org;

			VectorAdd(ent->r.absmin, ent->r.absmax, org);
			VectorScale(org, 0.5, org);

			VectorCopy(org, sourcesOfNoise[numSourcesOfNoise].origin);
		}
		numSourcesOfNoise++;
	}
}


/*
===============
JUHOX: MonsterSearchView
===============
*/
static void MonsterSearchView(gentity_t* monster, localseed_t* masterseed) {
	gmonster_t* mi;
	int i;
	localseed_t seed1, seed2, seed3, seed4, seed5;
	vec3_t angles;
	qboolean nervous;

	mi = monster->monster;
	if (!mi) return;

	DeriveLocalSeed(masterseed, &seed1);
	DeriveLocalSeed(masterseed, &seed2);
	DeriveLocalSeed(masterseed, &seed3);
	DeriveLocalSeed(masterseed, &seed4);
	DeriveLocalSeed(masterseed, &seed5);

	if (mi->nextDynViewSearch <= level.time) {
		vec_t maxdistanceSqr;
		int choosen;
		float totalWeight;

		mi->nextDynViewSearch = level.time + 250 + LocallySeededRandom(&seed1) % 250;
		if (level.intermissiontime) mi->nextDynViewSearch += 100000000;

		maxdistanceSqr = 1000.0 * 1000.0;
		choosen = -1;
		totalWeight = 0;

		for (i = 0; i < numSourcesOfNoise; i++) {
			vec3_t dir;
			float distanceSqr;
			float weight;

			if (sourcesOfNoise[i].source == monster) continue;
			VectorSubtract(sourcesOfNoise[i].origin, mi->ps.origin, dir);
			distanceSqr = VectorLengthSquared(dir);
			if (distanceSqr > maxdistanceSqr) continue;

			weight = 1.0 / (distanceSqr + 100);
			totalWeight += weight;
			if (local_random(&seed5) <= weight / totalWeight) {
				choosen = i;
				vectoangles(dir, mi->ideal_view);
				mi->sourceOfNoise = sourcesOfNoise[i].source;
			}

		}
		if (choosen >= 0) {
			float a1, a2;
			float viewSpeed;

			a1 = fabs(AngleSubtract(mi->ideal_view[YAW], mi->ps.viewangles[YAW]));
			a2 = fabs(AngleSubtract(mi->ideal_view[PITCH], mi->ps.viewangles[PITCH]));
			if (a2 > a1) a1 = a2;
			switch (mi->type) {
			case MT_predator:
			default:
				viewSpeed = PREDATOR_VIEW_SPEED;
				break;
			case MT_guard:
				viewSpeed = GUARD_VIEW_SPEED;
				break;
			case MT_titan:
				viewSpeed = TITAN_VIEW_SPEED;
				break;
			}
			mi->nextEnemySearch = level.time + 100 + (int)(1000 * a1 / viewSpeed);
			mi->nextDynViewSearch = level.time + 750 + LocallySeededRandom(&seed1) % 500;
			mi->nextViewSearch = level.time + 2000 + LocallySeededRandom(&seed1) % 2000;
			mi->walk = qfalse;
			return;
		}
		mi->sourceOfNoise = NULL;
	}

	if (mi->sourceOfNoise) {
		if (EntityAudible(mi->sourceOfNoise)) {
			vec3_t origin;
			vec3_t dir;

			if (mi->sourceOfNoise->client) {
				VectorCopy(mi->sourceOfNoise->client->ps.origin, origin);
			}
			else if (mi->sourceOfNoise->monster) {
				VectorCopy(mi->sourceOfNoise->monster->ps.origin, origin);
			}
			else {
				VectorAdd(mi->sourceOfNoise->r.absmin, mi->sourceOfNoise->r.absmax, origin);
				VectorScale(origin, 0.5, origin);
			}

			VectorSubtract(origin, mi->ps.origin, dir);
			vectoangles(dir, mi->ideal_view);
		}
		else {
			mi->sourceOfNoise = NULL;
		}
	}

	nervous = qfalse;
	if (
		(
			(
				level.artefactCapturedTime &&
				level.time < level.artefactCapturedTime + 15000
			) ||
			(
				level.endPhase > 0 &&
				!g_skipEndSequence.integer
			)
		) &&
		mi->type == MT_predator
	) {
		nervous = qtrue;
	}

	if (
		(
			nervous ||
			(
				mi->type == MT_titan &&
				!level.intermissiontime
			)
		) &&
		mi->nextViewSearch > level.time + 1000
	) {
		mi->nextViewSearch = level.time + 500 + LocallySeededRandom(&seed2) % 500;
	}

	if (mi->nextViewSearch > level.time) return;
	mi->nextViewSearch = level.time + 1000 + LocallySeededRandom(&seed3) % 9000;

	mi->walk = qfalse;

	for (i = 0; i < 3; i++) {
		vec3_t dir;
		vec3_t end;
		trace_t trace;

		VectorSet(angles, 45 * local_crandom(&seed3), 360 * local_random(&seed3), 0);
		if (
			fabs(AngleSubtract(angles[YAW], mi->ps.viewangles[YAW])) < 60 &&
			fabs(AngleSubtract(angles[PITCH], mi->ps.viewangles[PITCH])) < 45
		) {
			continue;
		}
		if (nervous) {
			if (LocallySeededRandom(&seed5) & 1) {
				angles[PITCH] -= 25;
			}
			else {
				angles[PITCH] += 25;
			}
			break;
		}
		AngleVectors(angles, dir, NULL, NULL);
		VectorMA(mi->ps.origin, 400, dir, end);
		trap_Trace(&trace, mi->ps.origin, NULL, NULL, end, mi->ps.clientNum, CONTENTS_SOLID);
		if (trace.fraction >= 0.5) {
			VectorCopy(angles, mi->ideal_view);
			if (
				(trace.fraction < 1 && angles[PITCH] > -10) ||
				local_random(&seed4) < 0.2
			) {
				mi->walk = qtrue;
			}
			return;
		}
	}

	VectorCopy(angles, mi->ideal_view);
}


/*
===============
JUHOX: EntityVisibleToMonster
===============
*/
static qboolean EntityVisibleToMonster(const gentity_t* ent, const gentity_t* monster) {
	vec3_t start;
	vec3_t dest;
	vec3_t end;
	vec3_t dir;
	static const vec3_t up = {0, 0, 1};
	vec3_t right;
	playerState_t* ps;
	trace_t trace;

	if (!monster->monster) return qfalse;

	VectorCopy(monster->monster->ps.origin, start);
	start[2] += monster->monster->ps.viewheight;
	ps = G_GetEntityPlayerState(ent);
	if (ps) {
		VectorCopy(ps->origin, dest);
	}
	else {
		VectorCopy(ent->r.currentOrigin, dest);
	}
	trap_Trace(&trace, start, NULL, NULL, dest, monster->s.number, MASK_SHOT);
	if (trace.entityNum == ent->s.number || trace.fraction >= 1) return qtrue;

	if (ps) {
		VectorCopy(dest, end);
		end[2] += ps->viewheight;
		trap_Trace(&trace, start, NULL, NULL, end, monster->s.number, MASK_SHOT);
		if (trace.entityNum == ent->s.number || trace.fraction >= 1) return qtrue;
	}

	VectorSubtract(dest, start, dir);
	VectorNormalize(dir);
	CrossProduct(dir, up, right);
	VectorMA(dest, 15, right, end);
	trap_Trace(&trace, start, NULL, NULL, end, monster->s.number, MASK_SHOT);
	if (trace.entityNum == ent->s.number || trace.fraction >= 1) return qtrue;

	VectorMA(dest, -15, right, end);
	trap_Trace(&trace, start, NULL, NULL, end, monster->s.number, MASK_SHOT);
	if (trace.entityNum == ent->s.number || trace.fraction >= 1) return qtrue;

	return qfalse;
}


/*
===============
JUHOX: EntityInViewOfMonster
===============
*/
static qboolean EntityInViewOfMonster(const gentity_t* ent, const gmonster_t* mi) {
	vec3_t dir;
	vec3_t angles;

	VectorSubtract(ent->s.pos.trBase, mi->ps.origin, dir);
	vectoangles(dir, angles);
	if (fabs(AngleSubtract(angles[YAW], mi->ps.viewangles[YAW])) > 60) return qfalse;
	if (fabs(AngleSubtract(angles[PITCH], mi->ps.viewangles[PITCH])) > 45) return qfalse;
	return qtrue;
}


/*
===============
JUHOX: EntityEasilyVisibleToMonsters
===============
*/
static qboolean EntityEasilyVisibleToMonsters(const gentity_t* ent) {
	if (!ent->client) return qtrue;
	if (!ent->client->ps.powerups[PW_INVIS]) return qtrue;
	if (ent->client->ps.powerups[PW_BATTLESUIT]) return qtrue;
	if (ent->client->ps.powerups[PW_REDFLAG]) return qtrue;
	if (ent->client->ps.powerups[PW_BLUEFLAG]) return qtrue;
	return qfalse;
}


/*
===============
JUHOX: CheckMonsterEnemy
===============
*/
static void CheckMonsterEnemy(gentity_t* monster, localseed_t* masterseed) {
	gentity_t* enemy;
	localseed_t seed;
	playerState_t* ps;

	if (!monster->monster) return;
	if (level.intermissiontime) {
		monster->monster->enemy = NULL;
		return;
	}

	DeriveLocalSeed(masterseed, &seed);

	enemy = monster->monster->enemy;
	if (!enemy) return;

	monster->monster->enemy = NULL;

	if (!enemy->inuse) return;
	ps = G_GetEntityPlayerState(enemy);
	if (!ps) return;
	if (ps->stats[STAT_HEALTH] <= 0) return;
	if (ps->powerups[PW_SHIELD]) return;
	if (level.endPhase > 0 && monster->monster->nextEnemyVisCheck <= level.time) return;

	if (
		monster->monster->lastHurtEntity != enemy ||
		monster->monster->lastHurtTime < level.time - 3000
	) {
		if ((enemy->s.eFlags ^ monster->monster->oldEnemyEFlags) & EF_TELEPORT_BIT) {
			monster->monster->nextEnemyVisCheck = level.time + 1000 + LocallySeededRandom(&seed) % 1000;
		}

		if (monster->monster->nextEnemyVisCheck <= level.time) {
			monster->monster->nextEnemyVisCheck = level.time + 1000 + LocallySeededRandom(&seed) % 1000;

			if (
				monster->monster->type != MT_titan &&
				!EntityEasilyVisibleToMonsters(enemy)
			) {
				vec_t distSqr;

				distSqr = DistanceSquared(ps->origin, monster->monster->ps.origin);
				if (distSqr > 1000.0 * 1000.0) return;
			}

			if (monster->monster->type == MT_guard) {
				if (!monster->monster->enemyWasInView) return;
			}
			else if (
				!EntityVisibleToMonster(enemy, monster) ||
				level.time > monster->monster->lastEnemyHitTime + 5000
			) {
				return;
			}
		}
	}

	monster->monster->enemy = enemy;
}


/*
===============
JUHOX: SetMonsterEnemy
===============
*/
static void SetMonsterEnemy(gmonster_t* monster, gentity_t* enemy, localseed_t* seed) {
	monster->enemy = enemy;
	monster->nextEnemyVisCheck = level.time + 1000 + (LocallySeededRandom(seed) % 1000);
	monster->lastEnemyHitTime = level.time;
	monster->enemyFoundTime = level.time;
	monster->oldEFlags = monster->ps.eFlags;
	monster->oldEnemyEFlags = G_GetEntityPlayerState(enemy)->eFlags;
	monster->freezeView = qfalse;
	monster->enemyWasInView = qtrue;
	monster->nextDodgeTime = level.time + 500;
	monster->dodgeDir = 0;
}


/*
===============
JUHOX: SearchMonsterEnemy
===============
*/
static void SearchMonsterEnemy(gentity_t* monster, localseed_t* masterseed) {
	gmonster_t* mi;
	int i;
	int n;
	int clientBag[MAX_GENTITIES];
	localseed_t seed;
	gentity_t* nearestEnemy;
	float minDistanceSqr;

	if (level.intermissiontime) return;
	if (level.endPhase > 0) return;

	mi = monster->monster;
	if (!mi) return;

	DeriveLocalSeed(masterseed, &seed);

	if (
		mi->enemy &&
		(
			mi->lastEnemyHitTime > level.time - 2000 ||
			mi->enemyFoundTime > level.time - 5000
		)
	) {
		return;
	}

	if (
		mi->lastHurtEntity &&
		mi->lastHurtTime > level.time - 1000 &&
		mi->lastHurtEntity->health > 0 &&
		mi->lastHurtEntity->s.number != mi->owner &&
		mi->lastHurtEntity != monster
	) {
		playerState_t* ps;

		ps = G_GetEntityPlayerState(mi->lastHurtEntity);
		if (
			g_gametype.integer < GT_TEAM ||
			!ps ||
			ps->persistant[PERS_TEAM] != mi->ps.persistant[PERS_TEAM] ||
			(
				g_gametype.integer >= GT_STU &&
				mi->lastHurtEntity->monster &&
				mi->lastHurtEntity->monster->type <= mi->type
			)
		) {
			SetMonsterEnemy(mi, mi->lastHurtEntity, &seed);
		}
		return;
	}

	if (mi->nextEnemySearch > level.time) return;
	mi->nextEnemySearch = level.time + 250 + (LocallySeededRandom(&seed) % 250);

	n = level.maxclients;
	if (
		mi->type == MT_titan ||
		(
			g_gametype.integer < GT_STU &&
			g_monsterLauncher.integer
		)
	) {
		n = level.num_entities;
	}
	for (i = 0; i < n; i++) {
		clientBag[i] = i;
	}

	nearestEnemy = NULL;
	minDistanceSqr = 1e12;
	while (i > 0) {
		int j;
		gentity_t* ent;
		playerState_t* ps;
		vec3_t dir;
		vec_t distanceSqr;
		vec3_t angles;

		j = LocallySeededRandom(&seed) % i;
		ent = &g_entities[clientBag[j]];
		clientBag[j] = clientBag[--i];

		if (!ent->inuse) continue;
		ps = G_GetEntityPlayerState(ent);
		if (!ps) continue;
		if (ps->stats[STAT_HEALTH] <= 0) continue;
		if (ps->persistant[PERS_TEAM] == TEAM_SPECTATOR) continue;
		if (G_IsFriendlyMonster(ent, monster)) continue;
		if (!G_CanBeDamaged(ent)) continue;
		if (ps->powerups[PW_SHIELD]) continue;
		if (ent == monster) continue;
		if (ent == mi->enemy) continue;

		VectorSubtract(ps->origin, mi->ps.origin, dir);
		distanceSqr = VectorLengthSquared(dir);
		if (distanceSqr > Square(3000.0f)) continue;
		if (
			mi->type != MT_titan &&
			!EntityEasilyVisibleToMonsters(ent)
		) {
			if (distanceSqr > Square(600.0f)) continue;
			if (!EntityAudible(ent) && distanceSqr > Square(200.0f)) continue;
		}

		vectoangles(dir, angles);
		if (fabs(AngleSubtract(angles[YAW], mi->ps.viewangles[YAW])) > 60.0f) continue;
		if (fabs(AngleSubtract(angles[PITCH], mi->ps.viewangles[PITCH])) > 45.0f) continue;

		if (!EntityVisibleToMonster(ent, monster)) continue;

		if (mi->type == MT_titan) {
			if (distanceSqr < minDistanceSqr) {
				minDistanceSqr = distanceSqr;
				nearestEnemy = ent;
			}
		}
		else {
			SetMonsterEnemy(mi, ent, &seed);
			return;
		}
	}

	if (mi->type == MT_titan && nearestEnemy) {
		SetMonsterEnemy(mi, nearestEnemy, &seed);
		return;
	}

	if (
		g_gametype.integer >= GT_STU &&
		mi->avoidPlayer &&
		mi->startAvoidPlayerTime > level.time - 500 &&
		(
			mi->type == MT_titan ||
			rand() % 5 == 0
		)
	) {
		gentity_t* troublemaker;

		troublemaker = &g_entities[mi->avoidPlayer->clientNum];
		if (
			troublemaker->monster &&
			troublemaker->monster->type == MT_predator
		) {
			vec3_t dir;
			vec3_t angles;

			VectorSubtract(troublemaker->monster->ps.origin, mi->ps.origin, dir);
			vectoangles(dir, angles);
			if (
				fabs(AngleSubtract(angles[YAW], mi->ps.viewangles[YAW])) < 30.0f &&
				fabs(AngleSubtract(angles[PITCH], mi->ps.viewangles[PITCH])) < 20.0f
			) {
				SetMonsterEnemy(mi, troublemaker, &seed);
				mi->lastHurtEntity = troublemaker;
				mi->lastHurtTime = level.time;
			}
		}
	}
}


/*
===============
JUHOX: ScanForMonsterEnemy

used in hibernation mode only
returns qtrue if hibernation should be quit
===============
*/
#define MONSTER_HIBERNATION_SCAN_RADIUS 300.0f
static qboolean ScanForMonsterEnemy(gentity_t* monster, localseed_t* masterseed) {
	gmonster_t* mi;
	int i;
	int n;
	vec3_t mins, maxs;
	int nearEntities[MAX_GENTITIES];
	int bag[MAX_GENTITIES];
	localseed_t seed;

	if (level.intermissiontime) return qfalse;
	if (level.endPhase > 0) return qfalse;

	mi = monster->monster;
	if (!mi) return qfalse;

	DeriveLocalSeed(masterseed, &seed);

	if (
		mi->lastHurtEntity &&
		mi->lastHurtTime > level.time - 1000
	) {
		mi->nextEnemySearch = level.time + 1000;
		SearchMonsterEnemy(monster, &seed);
		return qtrue;
	}

	if (mi->ps.powerups[PW_CHARGE]) {
		return qtrue;
	}

	if (mi->hibernationBrood > 0) {
		if (mi->nextEnemySearch > level.time) return qfalse;
		mi->nextEnemySearch = level.time + 1000 + (LocallySeededRandom(&seed) % 1000);

		VectorCopy(mi->ps.origin, mins);
		VectorCopy(mi->ps.origin, maxs);
		mins[0] -= MONSTER_HIBERNATION_SCAN_RADIUS;
		mins[1] -= MONSTER_HIBERNATION_SCAN_RADIUS;
		mins[2] -= 2000;
		maxs[0] += MONSTER_HIBERNATION_SCAN_RADIUS;
		maxs[1] += MONSTER_HIBERNATION_SCAN_RADIUS;
		n = trap_EntitiesInBox(mins, maxs, nearEntities, MAX_GENTITIES);
		for (i = 0; i < n; i++) bag[i] = i;

		while (i > 0) {
			int j;
			gentity_t* ent;
			playerState_t* ps;
			vec3_t foot;
			float footDist;

			j = LocallySeededRandom(&seed) % i;
			ent = &g_entities[nearEntities[bag[j]]];
			bag[j] = bag[--i];

			if (!ent->inuse) continue;
			ps = G_GetEntityPlayerState(ent);
			if (!ps) continue;
			if (ps->stats[STAT_HEALTH] <= 0) continue;
			if (ps->persistant[PERS_TEAM] == TEAM_SPECTATOR) continue;
			if (ent == monster) continue;
			if (ps->powerups[PW_SHIELD]) continue;

			if (ent->monster) {
				if (ent->monster->type != MT_predator) continue;
				if (ent->monster->action != MA_attacking) continue;
			}

			VectorCopy(mi->ps.origin, foot);
			foot[2] = ent->r.currentOrigin[2];
			footDist = Distance(foot, ent->r.currentOrigin);
			if (footDist > 0.5f * (mi->ps.origin[2] - foot[2])) continue;

			if (!EntityVisibleToMonster(ent, monster)) continue;

			if (!ent->monster) SetMonsterEnemy(mi, ent, &seed);
			return qtrue;
		}
	}

	return qfalse;
}

/*
===============
JUHOX: TryDucking
===============
*/
static qboolean TryDucking(gentity_t* monster) {
	gmonster_t* mi;
	vec3_t viewAngles;
	vec3_t viewDir;
	vec3_t end;
	vec3_t mins;
	vec3_t maxs;
	vec3_t testMins;
	vec3_t testMaxs;
	trace_t trace;
	float nonDuckedFraction;

	mi = monster->monster;
	if (!mi) return qfalse;

	G_GetMonsterBounds(mi->type, mins, maxs);

	VectorCopy(mi->ps.viewangles, viewAngles);
	viewAngles[PITCH] = 0;
	viewAngles[ROLL] = 0;
	AngleVectors(viewAngles, viewDir, NULL, NULL);
	VectorMA(mi->ps.origin, maxs[0], viewDir, end);

	// is there an obstacle above the waist?
	VectorCopy(mins, testMins);
	VectorCopy(maxs, testMaxs);
	testMins[0] *= 0.8f;
	testMins[1] *= 0.8f;
	testMins[2] *= 0.8f;
	testMaxs[0] *= 0.8f;
	testMaxs[1] *= 0.8f;
	trap_Trace(&trace, mi->ps.origin, testMins, testMaxs, end, monster->s.number, CONTENTS_SOLID | CONTENTS_PLAYERCLIP);
	nonDuckedFraction = trace.fraction;

	// does it help if the monster ducks?
	VectorCopy(mins, testMins);
	VectorCopy(maxs, testMaxs);
	testMins[0] *= 0.8f;
	testMins[1] *= 0.8f;
	testMins[2] *= 0.8f;
	testMaxs[0] *= 0.8f;
	testMaxs[1] *= 0.8f;
	testMaxs[2] *= 0.4f;
	trap_Trace(&trace, mi->ps.origin, testMins, testMaxs, end, monster->s.number, CONTENTS_SOLID | CONTENTS_PLAYERCLIP);
	if (trace.fraction <= nonDuckedFraction) return qfalse;

	return qtrue;
}


/*
===============
JUHOX: MonsterAI
===============
*/
static void MonsterAI(gentity_t* monster) {
	gmonster_t* mi;
	localseed_t seed;

	mi = monster->monster;
	if (!mi) return;

	SetMonsterViewCmd(mi, level.time - mi->cmd.serverTime);

	mi->cmd.serverTime = level.time;
	if (mi->nextAIFrame > level.time) return;

	mi->cmd.forwardmove = 0;
	mi->cmd.rightmove = 0;
	mi->cmd.upmove = 0;
	mi->cmd.buttons = 0;
	mi->superJump = qfalse;
	mi->ps.pm_flags &= ~PMF_GRAPPLE_PULL;

	if (monster->health <= 0) return;

	DeriveLocalSeed(&monster->monster->seed, &seed);

	mi->nextAIFrame = level.time + 100 + (LocallySeededRandom(&seed) % 100);
	mi->lastAIFrame = level.time;

	CheckMonsterEnemy(monster, &seed);

	if (
		mi->action != MA_hibernation &&
		mi->action != MA_sleeping
	) {
		monster->s.modelindex &= ~(PFMI_HIBERNATION_MODE | PFMI_HIBERNATION_MORPHED);
		if (
			level.endPhase >= 3 &&
			mi->ps.powerups[PW_CHARGE] - level.time > 5000
		) {
			mi->action = MA_panic;
		}
		else if (!mi->enemy) {
			mi->action = MA_waiting;
			if (mi->avoidPlayer) {
				if (mi->stopAvoidPlayerTime < level.time) {
					mi->avoidPlayer = NULL;
				}
				else {
					mi->action = MA_avoiding;
				}
			}
		}
	}

	switch (mi->action) {
	case MA_waiting:
		MonsterSearchView(monster, &seed);
		if (mi->walk && level.endPhase <= 0) {
			trace_t trace;
			vec3_t dir;
			vec3_t end;

			AngleVectors(mi->ps.viewangles, dir, NULL, NULL);
			VectorMA(mi->ps.origin, 75.0f, dir, end);
			trap_Trace(&trace, mi->ps.origin, NULL, NULL, end, monster->s.number, CONTENTS_SOLID|CONTENTS_PLAYERCLIP);
			if (trace.fraction < 1.0f) {
				mi->walk = qfalse;
			}
			else {
				vec3_t start;

				VectorCopy(trace.endpos, start);
				VectorCopy(start, end);
				end[2] -= 400.0f;
				trap_Trace(&trace, start, NULL, NULL, end, monster->s.number, MASK_OPAQUE|CONTENTS_PLAYERCLIP|CONTENTS_TRIGGER);
				if (
					trace.fraction >= 1 ||
					(trace.contents & (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_TRIGGER))
				) {
					mi->walk = qfalse;
				}
			}
			mi->cmd.forwardmove = 32;
			mi->cmd.buttons |= BUTTON_WALKING;
		}
		SearchMonsterEnemy(monster, &seed);
		if (mi->enemy) {
			mi->action = MA_attacking;
		}

		if (
			g_gametype.integer == GT_STU &&
			mi->hibernationTime &&
			g_monsterBreeding.integer
		) {
			if (
				!mi->walk &&
				!mi->enemy &&
				mi->hibernationTime <= level.time
			) {
				trace_t trace;
				vec3_t end;

				VectorCopy(mi->ps.origin, end);
				end[2] += 4000.0f;
				trap_Trace(&trace, mi->ps.origin, NULL, NULL, end, monster->s.number, MASK_PLAYERSOLID);
				if (
					trace.fraction < 1.0f &&
					trace.fraction > 0.03f &&
					!(trace.surfaceFlags & SURF_NOIMPACT) &&
					!(trace.contents & CONTENTS_BODY)
				) {
					mi->action = MA_hibernation;
					mi->hibernationPhase = HP_entry;
					mi->ideal_view[PITCH] = -90.0f;
					VectorCopy(trace.endpos, mi->hibernationSpot);
				}
				else {
					mi->hibernationWaitTime = 15000 + LocallySeededRandom(&seed) % 30000;
					mi->hibernationTime = level.time + mi->hibernationWaitTime;
				}
			}
		}
		break;
	case MA_avoiding:
		{
			vec3_t start, end;
			vec3_t dir;

			mi->walk = qfalse;

			VectorCopy(mi->ps.origin, start);
			start[2] += mi->ps.viewheight;
			VectorCopy(mi->avoidPlayer->origin, end);
			end[2] += mi->avoidPlayer->viewheight;
			VectorSubtract(end, start, dir);
			vectoangles(dir, mi->ideal_view);

			if (fabs(AngleSubtract(mi->ideal_view[YAW], mi->ps.viewangles[YAW])) > 90.0f) {
				mi->cmd.forwardmove = 32;
			}
			else {
				mi->cmd.forwardmove = -32;
			}
			mi->cmd.buttons |= BUTTON_WALKING;
		}
		SearchMonsterEnemy(monster, &seed);
		if (mi->enemy) mi->action = MA_attacking;
		break;
	case MA_attacking:

		switch (mi->type) {

		// predator attacking
		case MT_predator:

			mi->hibernationTime = level.time + mi->hibernationWaitTime;

			if (mi->enemyFoundTime < level.time - 250) {
				mi->cmd.forwardmove = 127;
			}
			{
				playerState_t* enemyPS;
				vec3_t start, end;
				vec3_t dir, horizDir;
				vec_t distSqr, horizDistSqr;
				localseed_t seed1;
				localseed_t seed2;

				enemyPS = G_GetEntityPlayerState(mi->enemy);
				VectorCopy(mi->ps.origin, start);
				start[2] += mi->ps.viewheight;
				VectorCopy(enemyPS->origin, end);
				end[2] += enemyPS->viewheight;
				VectorSubtract(end, start, dir);

				DeriveLocalSeed(&seed, &seed1);
				DeriveLocalSeed(&seed, &seed2);

				if (!mi->freezeView) {
					if ((enemyPS->eFlags ^ mi->oldEnemyEFlags) & EF_TELEPORT_BIT) {
						mi->freezeView = qtrue;
						mi->nextEnemyVisCheck = level.time + 1000 + (LocallySeededRandom(&seed1) % 1000);
					}
					else {
						vectoangles(dir, mi->ideal_view);
					}
				}
				else if ((mi->ps.eFlags ^ mi->oldEFlags) & EF_TELEPORT_BIT) {
					mi->freezeView = qfalse;
				}
				mi->oldEFlags = mi->ps.eFlags;
				mi->oldEnemyEFlags = enemyPS->eFlags;

				distSqr = VectorLengthSquared(dir);
				VectorCopy(dir, horizDir);
				horizDir[2] = 0;
				horizDistSqr = VectorLengthSquared(horizDir);

				if (mi->cmd.forwardmove) {
					if (
						(
							(
								horizDistSqr < Square(200.0f) &&
								dir[2] > 18.0f
							) ||
							local_random(&seed1) < (VectorLengthSquared(mi->ps.velocity) < Square(100.0f)? 0.2f : 0.02f)
						) &&
						enemyPS->groundEntityNum != ENTITYNUM_NONE &&
						!mi->freezeView
					) {
						mi->cmd.upmove = 127;
						if (dir[2] > 45.0f) mi->superJump = qtrue;
					}
					else if (mi->ps.groundEntityNum != ENTITYNUM_NONE) {
						trace_t trace;

						AngleVectors(mi->ps.viewangles, dir, NULL, NULL);
						VectorMA(mi->ps.origin, 0.150f * g_speed.value, dir, start);
						VectorCopy(start, end);
						end[2] -= 100.0f;
						trap_Trace(&trace, start, NULL, NULL, end, -1, MASK_PLAYERSOLID & ~CONTENTS_BODY);
						if (trace.fraction >= 1) {
							mi->cmd.upmove = 127;
							if (horizDistSqr > Square(400.0f)) {
								VectorCopy(start, end);
								end[2] += 200.0f;
								trap_Trace(&trace, start, NULL, NULL, end, -1, MASK_PLAYERSOLID & ~CONTENTS_BODY);
								if (trace.fraction >= 1.0f) {
									mi->superJump = qtrue;
								}
							}
						}
					}
				}

				if (distSqr < Square(100.0f)) {
					float viewDiff;

					mi->cmd.buttons |= BUTTON_ATTACK;
					// prevent the predator from orbitting the enemy
					viewDiff = fabs(AngleSubtract(mi->ps.viewangles[YAW], mi->ideal_view[YAW]));
					if (viewDiff > 60.0f) viewDiff = 60.0f;
					mi->cmd.forwardmove = 127 - 2 * viewDiff;
				}
				else if (!mi->freezeView) {
					if (mi->nextDodgeTime <= level.time) {
						mi->nextDodgeTime = level.time + 500 + (LocallySeededRandom(&seed2) % 1000);

						mi->dodgeDir = 32 + (LocallySeededRandom(&seed2) & 63);
						if (LocallySeededRandom(&seed2) & 1) mi->dodgeDir = -mi->dodgeDir;
					}
					mi->cmd.rightmove = mi->dodgeDir;
				}
			}
			break;

		// guard attacking
		case MT_guard:
			if (mi->enemyFoundTime < level.time - 500) {
				mi->cmd.buttons |= BUTTON_ATTACK;
			}
			else {
				mi->cmd.buttons |= BUTTON_GESTURE;
			}
			{
				playerState_t* enemyPS;
				vec3_t start, end;
				vec3_t dir;
				localseed_t seed1;
				trace_t trace;

				enemyPS = G_GetEntityPlayerState(mi->enemy);
				VectorCopy(mi->ps.origin, start);
				start[2] += mi->ps.viewheight;
				VectorCopy(enemyPS->origin, end);
				end[2] += enemyPS->viewheight;
				VectorSubtract(end, start, dir);

				DeriveLocalSeed(&seed, &seed1);

				trap_Trace(&trace, start, NULL, NULL, end, monster->s.number, MASK_SHOT);
				if (
					(trace.fraction >= 1 || trace.entityNum == mi->enemy->s.number) &&
					(mi->enemyWasInView || EntityInViewOfMonster(mi->enemy, mi))
				) {
					mi->enemyWasInView = qtrue;
					if (!mi->freezeView) {
						if ((enemyPS->eFlags ^ mi->oldEnemyEFlags) & EF_TELEPORT_BIT) {
							mi->freezeView = qtrue;
							mi->nextEnemyVisCheck = level.time + 1000 + (LocallySeededRandom(&seed1) % 1000);
						}
						else {
							vectoangles(dir, mi->ideal_view);
						}
					}
					else if ((mi->ps.eFlags ^ mi->oldEFlags) & EF_TELEPORT_BIT) {
						mi->freezeView = qfalse;
					}
				}
				else {
					mi->enemyWasInView = qfalse;
				}
				mi->oldEFlags = mi->ps.eFlags;
				mi->oldEnemyEFlags = enemyPS->eFlags;

				// stop shooting if we'd hit a titan
				if (
					trace.fraction < 1 &&
					g_entities[trace.entityNum].monster &&
					g_entities[trace.entityNum].monster->type == MT_titan
				) {
					mi->cmd.buttons &= ~BUTTON_ATTACK;
				}
			}
			break;

		// titan attacking (derived from predator attack code)
		case MT_titan:
			if (mi->enemyFoundTime < level.time - 250) {
				mi->cmd.forwardmove = 127;

				if (
					mi->enemyFoundTime < level.time - 700 &&
					VectorLengthSquared(mi->ps.velocity) < Square(100.0f) &&
					TryDucking(monster)
				) {
					mi->cmd.upmove = -127;
				}
			}
			else {
				mi->cmd.buttons |= BUTTON_GESTURE;
			}
			{
				playerState_t* enemyPS;
				vec3_t start, end;
				vec3_t dir, horizDir;
				vec_t distSqr, horizDistSqr;
				localseed_t seed1;
				localseed_t seed2;

				enemyPS = G_GetEntityPlayerState(mi->enemy);
				VectorCopy(mi->ps.origin, start);
				start[2] += mi->ps.viewheight;
				VectorCopy(enemyPS->origin, end);
				end[2] += enemyPS->viewheight;
				VectorSubtract(end, start, dir);

				DeriveLocalSeed(&seed, &seed1);
				DeriveLocalSeed(&seed, &seed2);

				if (!mi->freezeView) {
					if ((enemyPS->eFlags ^ mi->oldEnemyEFlags) & EF_TELEPORT_BIT) {
						mi->freezeView = qtrue;
						mi->nextEnemyVisCheck = level.time + 1000 + (LocallySeededRandom(&seed1) % 1000);
					}
					else {
						vectoangles(dir, mi->ideal_view);
					}
				}
				else if ((mi->ps.eFlags ^ mi->oldEFlags) & EF_TELEPORT_BIT) {
					mi->freezeView = qfalse;
				}
				mi->oldEFlags = mi->ps.eFlags;
				mi->oldEnemyEFlags = enemyPS->eFlags;

				distSqr = VectorLengthSquared(dir);
				VectorCopy(dir, horizDir);
				horizDir[2] = 0;
				horizDistSqr = VectorLengthSquared(horizDir);

				if (mi->cmd.forwardmove) {
					if (
						(
							(
								horizDistSqr < Square(200.0f) &&
								dir[2] > 18.0f
							) ||
							local_random(&seed1) < (VectorLengthSquared(mi->ps.velocity) < 100.0f? 0.2f : 0.01f)
						) &&
						enemyPS->groundEntityNum != ENTITYNUM_NONE &&
						!mi->freezeView
					) {
						mi->cmd.upmove = 127;
					}
					else if (mi->ps.groundEntityNum != ENTITYNUM_NONE) {
						trace_t trace;

						AngleVectors(mi->ps.viewangles, dir, NULL, NULL);
						VectorMA(mi->ps.origin, 0.2f * g_speed.value, dir, start);
						VectorCopy(start, end);
						end[2] -= 100.0f;
						trap_Trace(&trace, start, NULL, NULL, end, -1, MASK_PLAYERSOLID & ~CONTENTS_BODY);
						if (trace.fraction >= 1.0f) {
							mi->cmd.upmove = 127;
						}
					}
				}

				if (distSqr < Square(200.0f)) {
					float viewDiff;

					mi->cmd.buttons |= BUTTON_ATTACK;
					// prevent titan from orbitting the enemy
					viewDiff = fabs(AngleSubtract(mi->ps.viewangles[YAW], mi->ideal_view[YAW]));
					if (viewDiff > 60.0f) viewDiff = 60.0f;
					mi->cmd.forwardmove = 127 - 2 * viewDiff;
				}
				else if (
					!mi->freezeView &&
					// titan doesn't dodge, only tries to walk around obstacles
					mi->cmd.forwardmove &&
					VectorLengthSquared(mi->ps.velocity) < Square(150.0f)
				) {
					if (mi->nextDodgeTime <= level.time) {
						mi->nextDodgeTime = level.time + 500 + (LocallySeededRandom(&seed2) % 1000);

						mi->dodgeDir = 32 + (LocallySeededRandom(&seed2) & 63);
						if (LocallySeededRandom(&seed2) & 1) mi->dodgeDir = -mi->dodgeDir;
					}
					mi->cmd.rightmove = mi->dodgeDir;
				}
			}
			break;

		default:
			break;
		}
		SearchMonsterEnemy(monster, &seed);

		break;

	case MA_panic:
		mi->hibernationTime = 0;

		mi->cmd.forwardmove = 127;

		if (mi->nextViewSearch > level.time) break;
		mi->nextViewSearch = level.time + 500 + LocallySeededRandom(&seed) % 1000;

		VectorSet(mi->ideal_view, 0, 360.0f * local_random(&seed), 0);
		break;

	case MA_hibernation:	// predator only
		switch (mi->hibernationPhase) {
		case HP_entry:
			if (mi->ps.viewangles[PITCH] < -85.0f) {
				mi->hibernationPhase = HP_morphing;
				mi->hibernationBrood = 0;
				SET_STAT_EFFECT(&mi->ps, PE_hibernation);
				mi->ps.powerups[PW_EFFECT_TIME] = level.time + SPAWNHULL_TIME;
				VectorCopy(mi->hibernationSpot, monster->s.origin2);
				monster->s.modelindex |= (
					PFMI_HIBERNATION_MODE |
					PFMI_HIBERNATION_DRAW_SEED |
					PFMI_HIBERNATION_DRAW_THREAD
				);
			}
			else {
				SearchMonsterEnemy(monster, &seed);
				if (monster->enemy) {
					mi->action = MA_attacking;
				}
			}
			break;
		case HP_morphing:
			if (!mi->ps.powerups[PW_EFFECT_TIME]) {
				mi->hibernationPhase = HP_raising;
				mi->ps.origin[2] += DEFAULT_VIEWHEIGHT;
				mi->ps.eFlags ^= EF_TELEPORT_BIT;	// prevent lerping
				monster->s.modelindex |= PFMI_HIBERNATION_MORPHED;
				VectorSet(mi->ps.velocity, 100.0f*crandom(), 100.0f*crandom(), 0);
				mi->ps.pm_time = 100;
				mi->ps.pm_flags |= PMF_TIME_KNOCKBACK;
			}
			break;
		case HP_raising:
			VectorCopy(mi->hibernationSpot, mi->ps.grapplePoint);
			mi->ps.pm_flags |= PMF_GRAPPLE_PULL;
			mi->ps.stats[STAT_GRAPPLE_SPEED] = 200;
			//mi->ps.stats[STAT_GRAPPLE_STATE] = GST_silent;
			SET_STAT_GRAPPLESTATE (&mi->ps, GST_silent);

			if ((rand() & 127) == 0) {
				mi->ps.velocity[0] += 40.0f * crandom();
				mi->ps.velocity[1] += 40.0f * crandom();
			}

			if (DistanceSquared(mi->ps.origin, mi->hibernationSpot) < Square(100.0f)) {
				mi->hibernationTime = level.time + 15000 + LocallySeededRandom(&seed) % 30000;
				mi->hibernationPhase = HP_sleeping;
			}

			if (ScanForMonsterEnemy(monster, &seed)) {
				mi->hibernationPhase = HP_falling;
			}
			break;
		case HP_sleeping:
			VectorCopy(mi->hibernationSpot, mi->ps.grapplePoint);
			mi->ps.pm_flags |= PMF_GRAPPLE_PULL;
			mi->ps.stats[STAT_GRAPPLE_SPEED] = (int) (2.0f * Distance(mi->ps.origin, mi->hibernationSpot));
			//mi->ps.stats[STAT_GRAPPLE_STATE] = GST_silent;
			SET_STAT_GRAPPLESTATE (&mi->ps, GST_silent);

			if ((rand() & 127) == 0) {
				mi->ps.velocity[0] += 40.0f * crandom();
				mi->ps.velocity[1] += 40.0f * crandom();
			}
			else if (
				level.artefactCapturedTime &&
				level.time < level.artefactCapturedTime + 15000
			) {
				float intensity;

				intensity = 10.0f;
				if (level.time > level.artefactCapturedTime + 10000) {
					intensity *= (float)(level.artefactCapturedTime + 15000 - level.time) / 5000.0;
				}
				mi->ps.velocity[0] += intensity * crandom();
				mi->ps.velocity[1] += intensity * crandom();
			}

			if ( level.time >= mi->hibernationTime && !level.intermissiontime  ) {
				mi->hibernationTime = level.time + 15000 + LocallySeededRandom(&seed) % 30000;
				mi->hibernationBrood++;
				if (mi->hibernationBrood >= 3) {
					mi->hibernationPhase = HP_falling;
				}
			}

			if (ScanForMonsterEnemy(monster, &seed)) {
				mi->hibernationPhase = HP_falling;
			}
			break;
		case HP_falling:
			monster->s.modelindex &= ~PFMI_HIBERNATION_DRAW_THREAD;

			if (mi->enemy) {
				vec3_t origin;
				vec3_t dir;

				VectorAdd(mi->enemy->r.absmin, mi->enemy->r.absmax, origin);
				VectorScale(origin, 0.5f, origin);
				VectorSubtract(origin, mi->ps.origin, dir);
				vectoangles(dir, mi->ideal_view);
			}

			if (mi->ps.groundEntityNum != ENTITYNUM_NONE) {
				static const vec3_t mins = {-15.0f, -15.0f, -24.0f};
				static const vec3_t maxs = {15.0f, 15.0f, 32.0f};
				vec3_t spawnorigin;

				monster->s.modelindex &= ~PFMI_HIBERNATION_DRAW_SEED;

				if (G_GetMonsterSpawnPoint(mins, maxs, &seed, spawnorigin, MSM_atOrigin, mi->ps.origin)) {
					G_SetOrigin(monster, spawnorigin);
					VectorCopy(spawnorigin, mi->ps.origin);
					mi->ps.eFlags ^= EF_TELEPORT_BIT;	// prevent lerping
					monster->s.modelindex &= ~(PFMI_HIBERNATION_MODE | PFMI_HIBERNATION_MORPHED);
					//mi->ps.stats[STAT_EFFECT] = PE_spawn;
					SET_STAT_EFFECT(&mi->ps, PE_spawn);
					mi->ps.powerups[PW_EFFECT_TIME] = level.time + SPAWNHULL_TIME;
					mi->action = MA_waiting;
					if (mi->enemy) mi->action = MA_attacking;
					mi->hibernationWaitTime = 15000 + LocallySeededRandom(&seed) % 30000;
					mi->hibernationTime = level.time + mi->hibernationWaitTime;
					if (
						mi->hibernationBrood > 0 &&
						numMonsters < g_maxMonsters.integer &&
						numMonsters < MAX_MONSTERS
					) {
						G_ReleaseTrap(mi->hibernationBrood, spawnorigin);
					}
				}
				else {
					G_KillMonster(monster);
				}
			}
			break;
		}
		break;

	case MA_sleeping:	// titan only
		if (
			mi->lastHurtEntity ||
			mi->avoidPlayer
		) {
			mi->action = MA_waiting;

			//mi->ps.stats[STAT_EFFECT] = PE_titan_awaking;
			SET_STAT_EFFECT(&mi->ps, PE_titan_awaking);
			mi->ps.powerups[PW_EFFECT_TIME] = level.time + SPAWNHULL_TIME;
		}
		break;
	}
}


/*
===============
JUHOX: IsFightingMonster
===============
*/
qboolean IsFightingMonster(gentity_t* ent) {
	if (!ent->monster) return qfalse;
	if (ent->monster->action != MA_attacking) return qfalse;
	if (ent->monster->enemyFoundTime > level.time - 350) return qfalse;
	return qtrue;
}


/*
===============
JUHOX: CheckTouchedMonsters
===============
*/
void CheckTouchedMonsters(pmove_t* pm) {
	int i;

	for (i = 0; i < pm->numtouch; i++) {
		int te;
		gmonster_t* mi;

		te = pm->touchents[i];
		if (te < 0 || te >= ENTITYNUM_WORLD) continue;
		if (!g_entities[te].inuse) continue;
		mi = g_entities[te].monster;
		if (!mi) continue;

		switch (mi->type) {
		case MT_predator:
		case MT_titan:
			mi->avoidPlayer = pm->ps;
			mi->startAvoidPlayerTime = level.time;
			mi->stopAvoidPlayerTime = level.time + 500 + rand() % 700;
			break;
		case MT_guard:
			break;
		default:
			break;
		}
	}
}


/*
===============
JUHOX: ThinkMonster

derived from ClientThink_real() [g_active.c]
===============
*/
static void ThinkMonster(gentity_t* monster) {
	gmonster_t* mi;
	usercmd_t* ucmd;
	int msec;
	pmove_t pm;
	int oldEventSequence;

	mi = monster->monster;
	if (!mi) return;

	if (mi->removeTime && level.time >= mi->removeTime) {
		gentity_t* tent;

		tent = G_TempEntity(mi->ps.origin, EV_PLAYER_TELEPORT_OUT);
		if (tent) tent->s.clientNum = monster->s.clientNum;
		G_FreeMonster(monster);
		return;
	}

	if (mi->nextHealthRefresh <= level.time && monster->health > 0) {
		mi->nextHealthRefresh = level.time + 200;

		if (
			monster->health < mi->ps.stats[STAT_MAX_HEALTH] &&
			!mi->ps.stats[PW_CHARGE]
		) {
			monster->health++;
		}
	}
	mi->ps.stats[STAT_HEALTH] = monster->health;

	MonsterAI(monster);
	if (!monster->inuse) return;

	ucmd = &mi->cmd;
	msec = ucmd->serverTime - mi->ps.commandTime;
	if (msec < 1) goto Exit;
	if (msec > 200) msec = 200;

	if (monster->health <= 0) {
		mi->ps.pm_type = PM_DEAD;

		if (mi->timeOfBodyCopying && level.time >= mi->timeOfBodyCopying) {
			CopyToBodyQue(monster);
			G_FreeMonster(monster);
			return;
		}
	}
	else {
		mi->ps.pm_type = PM_NORMAL;
	}

	mi->ps.gravity = g_gravity.integer;
	mi->ps.speed = g_speed.integer;

	CheckPlayerDischarge(monster);

	oldEventSequence = mi->ps.eventSequence;

	memset(&pm, 0, sizeof(pm));

	pm.ps = &mi->ps;
	pm.cmd = *ucmd;
	if (pm.ps->pm_type == PM_DEAD) {
		pm.tracemask = MASK_PLAYERSOLID & ~CONTENTS_BODY;
	}
	else {
		pm.tracemask = MASK_PLAYERSOLID;
	}
	pm.trace = trap_Trace;
	pm.pointcontents = trap_PointContents;
	pm.debugLevel = g_debugMove.integer;
	pm.noFootsteps = (g_dmflags.integer & DF_NO_FOOTSTEPS) != 0;

	switch (mi->type) {
	case MT_predator:
	default:
		pm.scale = 1;
		pm.hookMode = HM_combat;
		if (monster->s.modelindex & PFMI_HIBERNATION_MORPHED) {
			pm.hibernation = qtrue;
		}
		if (
			(ucmd->buttons & BUTTON_ATTACK) &&
			mi->ps.weaponTime <= 0 &&
			monster->health > 0
		) {
			pm.gauntletHit = CheckGauntletAttack(monster);
		}
		break;
	case MT_guard:
		pm.scale = MONSTER_GUARD_SCALE;
		break;
	case MT_titan:
		pm.scale = MONSTER_TITAN_SCALE;
		mi->ps.speed = (int) (2.0f * g_speed.integer);
		if (
			(ucmd->buttons & BUTTON_ATTACK) &&
			mi->ps.weaponTime <= 0 &&
			monster->health > 0
		) {
			pm.gauntletHit = CheckTitanAttack(monster);
		}
		break;
	}

	pm.gametype = g_gametype.integer;

	pm.pmove_fixed = qtrue;
	pm.pmove_msec = 10000;
	Pmove(&pm);

	mi->ps.stats[STAT_STRENGTH] = MAX_STRENGTH_VALUE;
	mi->ps.stats[STAT_TARGET] = -1;

	if (mi->ps.eventSequence != oldEventSequence) {
		monster->eventTime = level.time;
	}
	BG_PlayerStateToEntityState(&mi->ps, &monster->s, qtrue);
	G_MonsterCorrectEntityState(monster);

	VectorCopy(monster->s.pos.trBase, monster->r.currentOrigin);

	VectorCopy(pm.mins, monster->r.mins);
	VectorCopy(pm.maxs, monster->r.maxs);

	monster->waterlevel = pm.waterlevel;
	monster->watertype = pm.watertype;

	MonsterEvents(monster, oldEventSequence);
	CauseMonsterChargeDamage(monster);

	trap_LinkEntity(monster);

	MonsterTouchTriggers(monster);

	VectorCopy(mi->ps.origin, monster->r.currentOrigin);

	// touch other objects
	ClientImpacts(monster, &pm);

	// save results of triggers and client events
	if (mi->ps.eventSequence != oldEventSequence) {
		monster->eventTime = level.time;
	}

	// turn off expired powerups
	if (mi->ps.powerups[PW_CHARGE] < level.time) mi->ps.powerups[PW_CHARGE] = 0;
	if (mi->ps.powerups[PW_EFFECT_TIME] < level.time) mi->ps.powerups[PW_EFFECT_TIME] = 0;

	// spawn pool
	if (
		g_gametype.integer == GT_STU &&
		g_gameSeed.integer == 0 &&
		mi->action == MA_waiting &&
		mi->nextSpawnPoolCheck <= level.time &&
		mi->ps.groundEntityNum == ENTITYNUM_WORLD &&
		mi->ps.stats[STAT_HEALTH] > 0
	) {
		mi->nextSpawnPoolCheck = level.time + 1000 + rand() % 1000;
		if (DistanceSquared(mi->ps.origin, mi->lastCheckedSpawnPos) > Square(10.0f)) {
			CheckMonsterSpawnPoolEntry(mi->ps.origin);
			VectorCopy(mi->ps.origin, mi->lastCheckedSpawnPos);
		}
	}

	// world effects
	if (
		(
			mi->type == MT_guard ||
			mi->type == MT_titan
		) &&
		mi->ps.groundEntityNum >= 0 &&
		mi->ps.groundEntityNum < ENTITYNUM_WORLD
	) {
		gentity_t* ent;
		playerState_t* ps;

		ent = &g_entities[mi->ps.groundEntityNum];
		ps = G_GetEntityPlayerState(ent);
		if (
			ps &&
			ps->groundEntityNum >= 0 &&
			ps->groundEntityNum <= ENTITYNUM_WORLD
		) {
			G_Damage(ent, NULL, monster, NULL, NULL, 100000, 0, MOD_CRUSH);
		}
	}
	if (
		monster->waterlevel &&
		(monster->watertype & (CONTENTS_LAVA|CONTENTS_SLIME)) &&
		monster->health > 0 &&
		monster->pain_debounce_time <= level.time
	) {
		if (monster->watertype & CONTENTS_LAVA) {
			G_Damage(monster, NULL, NULL, NULL, NULL, 30*monster->waterlevel, 0, MOD_LAVA);
		}

		if (monster->watertype & CONTENTS_SLIME) {
			G_Damage(monster, NULL, NULL, NULL, NULL, 10*monster->waterlevel, 0, MOD_SLIME);
		}
	}

	Exit:
	monster->nextthink = level.time + 1;
}


/*
===============
JUHOX: PainMonster

derived from P_DamageFeedback() [g_active.c]
===============
*/
static void PainMonster(gentity_t* monster, gentity_t* attacker, int damage) {
	if (!monster->monster) return;

	if (level.time > monster->pain_debounce_time && damage > 0) {
		monster->pain_debounce_time = level.time + 650 + rand() % 100;
		G_AddEvent(monster, EV_PAIN, (100 * monster->health) / monster->monster->ps.stats[STAT_MAX_HEALTH]);
	}
	if (attacker && G_GetEntityPlayerState(attacker)) {
		monster->monster->lastHurtEntity = attacker;
		monster->monster->lastHurtTime = level.time;
	}
}


/*
===============
JUHOX: G_GetMonsterBounds
===============
*/
void G_GetMonsterBounds(monsterType_t type, vec3_t mins, vec3_t maxs) {
	static const vec3_t predatorMins = {-15.0f, -15.0f, -24.0f};
	static const vec3_t predatorMaxs = {15.0f, 15.0f, 32.0f};
	static const vec3_t guardMins = {-15.0f*MONSTER_GUARD_SCALE, -15.0f*MONSTER_GUARD_SCALE, -24.0f*MONSTER_GUARD_SCALE};
	static const vec3_t guardMaxs = { 15.0f*MONSTER_GUARD_SCALE,  15.0f*MONSTER_GUARD_SCALE,  32.0f*MONSTER_GUARD_SCALE};
	static const vec3_t titanMins = {-15.0f*MONSTER_TITAN_SCALE, -15.0f*MONSTER_TITAN_SCALE, -24.0f*MONSTER_TITAN_SCALE};
	static const vec3_t titanMaxs = { 15.0f*MONSTER_TITAN_SCALE,  15.0f*MONSTER_TITAN_SCALE,  32.0f*MONSTER_TITAN_SCALE};

	switch (type) {
	case MT_predator:
	default:
		VectorCopy(predatorMins, mins);
		VectorCopy(predatorMaxs, maxs);
		break;
	case MT_guard:
		VectorCopy(guardMins, mins);
		VectorCopy(guardMaxs, maxs);
		break;
	case MT_titan:
		VectorCopy(titanMins, mins);
		VectorCopy(titanMaxs, maxs);
		break;
	}
}

/*
===============
JUHOX: FitBoxIn
===============
*/
static qboolean FitBoxIn(
	const vec3_t origin,
	const vec3_t boxmins, const vec3_t boxmaxs,
	int mask,
	vec3_t result
) {
	vec3_t boxsize;
	vec3_t end;
	vec3_t mins;
	vec3_t maxs;
	trace_t trace;
	vec3_t boundmins;
	vec3_t boundmaxs;

	if (trap_PointContents(origin, -1) & mask) return qfalse;

	VectorSubtract(boxmaxs, boxmins, boxsize);

	VectorCopy(origin, result);

	// fit X co-ordinate in
	VectorCopy(result, end);
	end[0] -= boxsize[0];
	trap_Trace(&trace, result, NULL, NULL, end, -1, mask);
	if (trace.fraction <= 0 || trace.startsolid || trace.allsolid) return qfalse;
	VectorCopy(trace.endpos, boundmins);
	trap_Trace(&trace, boundmins, NULL, NULL, result, -1, mask);	// trace back
	if (trace.fraction < 1 || trace.startsolid || trace.allsolid) return qfalse;

	VectorCopy(result, end);
	end[0] += boxsize[0];
	trap_Trace(&trace, result, NULL, NULL, end, -1, mask);
	if (trace.fraction <= 0 || trace.startsolid || trace.allsolid) return qfalse;
	VectorCopy(trace.endpos, boundmaxs);
	trap_Trace(&trace, boundmaxs, NULL, NULL, result, -1, mask);	// trace back
	if (trace.fraction < 1 || trace.startsolid || trace.allsolid) return qfalse;

	if (boundmaxs[0] - boundmins[0] < boxsize[0]) return qfalse;	// not enough space to fix box in

	if (result[0] + boxmins[0] < boundmins[0]) result[0] = boundmins[0] - boxmins[0];
	if (result[0] + boxmaxs[0] > boundmaxs[0]) result[0] = boundmaxs[0] - boxmaxs[0];

	// fit Y co-ordinate in
	VectorSet(mins, boxmins[0], -0.1f, -0.1f);
	VectorSet(maxs, boxmaxs[0], +0.1f, +0.1f);

	VectorCopy(result, end);
	end[1] -= boxsize[1];
	trap_Trace(&trace, result, mins, maxs, end, -1, mask);
	if (trace.fraction <= 0 || trace.startsolid || trace.allsolid) return qfalse;
	VectorCopy(trace.endpos, boundmins);
	trap_Trace(&trace, boundmins, mins, maxs, result, -1, mask);	// trace back
	if (trace.fraction < 1 || trace.startsolid || trace.allsolid) return qfalse;

	VectorCopy(result, end);
	end[1] += boxsize[1];
	trap_Trace(&trace, result, mins, maxs, end, -1, mask);
	if (trace.fraction <= 0 || trace.startsolid || trace.allsolid) return qfalse;
	VectorCopy(trace.endpos, boundmaxs);
	trap_Trace(&trace, boundmaxs, mins, maxs, result, -1, mask);	// trace back
	if (trace.fraction < 1 || trace.startsolid || trace.allsolid) return qfalse;

	if (boundmaxs[1] - boundmins[1] < boxsize[1]) return qfalse;	// not enough space to fit box in

	if (result[1] + boxmins[1] < boundmins[1]) result[1] = boundmins[1] - boxmins[1];
	if (result[1] + boxmaxs[1] > boundmaxs[1]) result[1] = boundmaxs[1] - boxmaxs[1];

	// fit Z co-ordinate in
	VectorSet(mins, boxmins[0], boxmins[1], -0.1f);
	VectorSet(maxs, boxmaxs[0], boxmaxs[1], +0.1f);

	VectorCopy(result, end);
	end[2] -= boxsize[2];
	maxs[2] = 1;
	trap_Trace(&trace, result, mins, maxs, end, -1, mask);
	if (trace.fraction <= 0 || trace.startsolid || trace.allsolid) return qfalse;
	VectorCopy(trace.endpos, boundmins);
	trap_Trace(&trace, boundmins, mins, maxs, result, -1, mask);	// trace back
	if (trace.fraction < 1 || trace.startsolid || trace.allsolid) return qfalse;

	VectorCopy(result, end);
	end[2] += boxsize[2];
	trap_Trace(&trace, result, mins, maxs, end, -1, mask);
	if (trace.fraction <= 0 || trace.startsolid || trace.allsolid) return qfalse;
	VectorCopy(trace.endpos, boundmaxs);
	trap_Trace(&trace, boundmaxs, mins, maxs, result, -1, mask);	// trace back
	if (trace.fraction < 1 || trace.startsolid || trace.allsolid) return qfalse;

	if (boundmaxs[2] - boundmins[2] < boxsize[2]) return qfalse;	// not enough space to fit box in

	if (result[2] + boxmins[2] < boundmins[2]) result[2] = boundmins[2] - boxmins[2];
	if (result[2] + boxmaxs[2] > boundmaxs[2]) result[2] = boundmaxs[2] - boxmaxs[2];

	return qtrue;
}


/*
===============
JUHOX: G_GetMonsterSpawnPoint
===============
*/
qboolean G_GetMonsterSpawnPoint(
	const vec3_t mmins, const vec3_t mmaxs,
	localseed_t* masterseed, vec3_t result,
	monsterspawnmode_t mode, const vec3_t origin
) {
	int choosen;
	localseed_t seed1;
	localseed_t seed2;

	DeriveLocalSeed(masterseed, &seed1);
	DeriveLocalSeed(masterseed, &seed2);

	if (
		mode == MSM_atOrigin ||
		mode == MSM_nearOrigin
	) {
		int i;
		trace_t trace;
		vec3_t nearOrigin;
		vec3_t end;
		float size;
		float maxDistance;

		size = Distance(mmins, mmaxs);
		maxDistance = size;
		if (mode == MSM_nearOrigin) maxDistance += 400;

		for (i = 0; i < 30; i++) {
			if (i <= 0 && mode == MSM_atOrigin) {
				VectorCopy(origin, nearOrigin);
			}
			else {
				vec3_t angles;
				vec3_t dir;
				float distance;

				angles[0] = 360.0f * local_random(&seed1);
				angles[1] = 360.0f * local_random(&seed1);
				angles[2] = 360.0f * local_random(&seed1);
				AngleVectors(angles, dir, NULL, NULL);
				distance = size + maxDistance * local_random(&seed1);
				VectorMA(origin, distance, dir, nearOrigin);

				trap_Trace(&trace, origin, NULL, NULL, nearOrigin, -1, CONTENTS_SOLID | CONTENTS_PLAYERCLIP);
				if (trace.fraction * distance < 2.0f || trace.startsolid || trace.allsolid) continue;

				// step back from the wall
				VectorSubtract(trace.endpos, dir, nearOrigin);

				trap_Trace(&trace, nearOrigin, NULL, NULL, origin, -1, CONTENTS_SOLID | CONTENTS_PLAYERCLIP);
				if (trace.fraction < 1 || trace.startsolid || trace.allsolid) continue;
			}
			if (!FitBoxIn(nearOrigin, mmins, mmaxs, CONTENTS_SOLID | CONTENTS_PLAYERCLIP, nearOrigin)) {
				continue;
			}

			VectorCopy(nearOrigin, end);
			end[2] -= 1000;
			trap_Trace(&trace, nearOrigin, mmins, mmaxs, end, -1, MASK_PLAYERSOLID);
			if (trace.fraction >= 1) continue;

			trace.endpos[2] += 1;
			SnapVectorTowards(trace.endpos, origin);
			if (PositionWouldTelefrag(trace.endpos, mmins, mmaxs)) continue;

			VectorCopy(trace.endpos, result);
			return qtrue;
		}
		return qfalse;
	}

	if (numMonsterSpawnPoolEntries > 0) {
		choosen = LocallySeededRandom(&seed1) % numMonsterSpawnPoolEntries;
		return G_GetMonsterSpawnPoint(mmins, mmaxs, &seed2, result, MSM_nearOrigin, monsterSpawnPool[choosen]);
	}
	return qfalse;
}


/*
===============
JUHOX: RandomWaitingMonster
===============
*/
static gentity_t* RandomWaitingMonster(localseed_t* masterseed, int owner) {
	int i;
	gentity_t* monster;
	int n;
	localseed_t seed;

	n = 0;
	monster = NULL;
	DeriveLocalSeed(masterseed, &seed);
	for (i = MAX_CLIENTS; i < level.num_entities; i++) {
		gentity_t* ent;

		ent = &g_entities[i];
		if (!ent->inuse) continue;
		if (ent->s.eType != ET_PLAYER) continue;
		if (!ent->monster) continue;
		if (ent->health <= 0) continue;
		if (ent->monster->action != MA_waiting) continue;
		if (ent->monster->walk) continue;
		if (owner >= 0 && ent->monster->owner != owner) continue;

		n++;
		if (LocallySeededRandom(&seed) % n == 0) monster = ent;
	}
	return monster;
}


/*
===============
JUHOX: G_MonsterHealthScale
===============
*/
float G_MonsterHealthScale(void) {
	float healthScale;

	healthScale = g_monsterHealthScale.integer;
	if (g_gametype.integer >= GT_STU) {
		healthScale *= (
			1.0f +
			0.01f * g_monsterProgression.integer * ((level.time - level.startTime) / 60000.0f)
		);
	}

	return healthScale;
}


/*
===============
JUHOX: G_MonsterBaseHealth
===============
*/
int G_MonsterBaseHealth(monsterType_t type, float healthScale) {
	switch (type) {
	case MT_predator:
		return (int) floor(3.0f * healthScale + 0.5f);
	case MT_guard:
		return (int) floor(10.0f * healthScale + 0.5f);
	case MT_titan:
		return (int) floor(50.0f * healthScale + 0.5f);
	default:
		return 0;
	}
}


/*
===============
JUHOX: G_MonsterType
===============
*/
monsterType_t G_MonsterType(localseed_t* seed) {
	int total;
	int r;

	total = g_monsterGuards.integer + g_monsterTitans.integer;
	if (total < 100) total = 100;

	r = LocallySeededRandom(seed) % total;

	if (r < g_monsterGuards.integer) return MT_guard;
	r -= g_monsterGuards.integer;

	if (r < g_monsterTitans.integer) return MT_titan;

	return MT_predator;
}


/*
===============
JUHOX: G_SpawnMonster
===============
*/
gentity_t* G_SpawnMonster(
	monsterType_t type,
	const vec3_t spawn_origin, const vec3_t spawn_angles,
	int removeTime,
	team_t spawnteam, int owner,
	const localseed_t* seed,
	gentity_t* monster,	// if non-NULL, telemorph this
	int maxHealth,
	monsterAction_t action,
	int generic1
) {
	vec3_t mins, maxs;
	vec3_t spawnorigin;
	gmonster_t* mi;
	float healthScale;
	int eFlags;
	qboolean telemorph;

	G_GetMonsterBounds(type, mins, maxs);

	VectorCopy(spawn_origin, spawnorigin);

	if (!monster) {
		monster = G_Spawn();
		if (!monster) return NULL;

		mi = GetMonsterInfo();
		if (!mi) {
			G_FreeEntity(monster);
			return NULL;
		}

		eFlags = 0;
		telemorph = qfalse;
	}
	else {
		mi = monster->monster;
		eFlags = mi->ps.eFlags & EF_TELEPORT_BIT;
		telemorph = qtrue;
		trap_UnlinkEntity(monster);
	}

	memset(monster, 0, sizeof(*monster));
	G_InitGentity(monster);
	memset(mi, 0, sizeof(*mi));
	monster->monster = mi;
	mi->type = type;
	mi->entity = monster;
	mi->seed = *seed;
	mi->owner = owner;
	mi->removeTime = removeTime;
	switch (spawnteam) {
	case TEAM_RED:
		monster->s.clientNum = CLIENTNUM_MONSTER_PREDATOR_RED;
		break;
	case TEAM_BLUE:
		monster->s.clientNum = CLIENTNUM_MONSTER_PREDATOR_BLUE;
		break;
	default:
		monster->s.clientNum = CLIENTNUM_MONSTERS + type;
		break;
	}
	mi->clientNum = monster->s.clientNum;
	monster->s.eType = ET_PLAYER;
	monster->s.eFlags = eFlags;
	monster->s.groundEntityNum = ENTITYNUM_NONE;
	monster->s.powerups = 0;
	monster->s.legsAnim = LEGS_IDLE;
	monster->s.torsoAnim = TORSO_STAND2;	// gauntlet anim
	monster->s.event = 0;
	monster->s.loopSound = 0;
	monster->s.otherEntityNum = ENTITYNUM_NONE;
	monster->s.otherEntityNum2 = ENTITYNUM_NONE;


	if (g_gametype.integer != GT_EFH)
	{
		SET_STAT_EFFECT(&mi->ps, PE_spawn);
		mi->ps.powerups[PW_EFFECT_TIME] = level.time + SPAWNHULL_TIME;
	}

	monster->r.svFlags = 0;
	monster->r.contents = CONTENTS_BODY;
	VectorCopy(mins, monster->r.mins);
	VectorCopy(maxs, monster->r.maxs);

	mi->ps.eFlags = eFlags;
	mi->ps.pm_type = PM_NORMAL;
	mi->ps.stats[STAT_STRENGTH] = MAX_STRENGTH_VALUE;
	mi->ps.stats[STAT_TARGET] = -1;
	mi->ps.persistant[PERS_TEAM] = spawnteam;
	mi->ps.clientNum = monster->s.number;
	mi->ps.pm_flags |= PMF_TIME_KNOCKBACK;
	mi->ps.pm_time = 100;
	mi->ps.torsoAnim = TORSO_STAND2;
	mi->ps.legsAnim = LEGS_IDLE;
	mi->ps.commandTime = level.time - 100;

	monster->client = NULL;
	monster->touch = 0;
	monster->pain = PainMonster;
	monster->nextthink = level.time;
	monster->think = ThinkMonster;
	monster->takedamage = qtrue;
	monster->die = MonsterDie;
	monster->clipmask = MASK_PLAYERSOLID;
	monster->waterlevel = 0;
	monster->watertype = 0;
	monster->flags = 0;
	monster->damage = 0;

	G_SetOrigin(monster, spawnorigin);
	VectorCopy(spawnorigin, mi->ps.origin);

	if (spawn_angles) {
		VectorCopy(spawn_angles, monster->s.apos.trBase);
	}
	else {
		VectorSet(monster->s.apos.trBase, 0, LocallySeededRandom(&mi->seed) % 360, 0);
	}
	VectorClear(monster->s.apos.trDelta);
	monster->s.angles2[YAW] = 0;
	monster->s.apos.trType = TR_STATIONARY;
	monster->s.apos.trTime = 0;
	monster->s.apos.trDuration = 0;
	VectorCopy(monster->s.apos.trBase, mi->ps.viewangles);
	VectorCopy(monster->s.apos.trBase, mi->cmd.angles);

	mi->cmd.serverTime = level.time;
	mi->nextHealthRefresh = level.time;
	mi->lastAIFrame = level.time;
	mi->nextAIFrame = level.time + LocallySeededRandom(&mi->seed) % 100;
	VectorCopy(monster->s.apos.trBase, mi->ideal_view);
	mi->action = action;
	mi->nextViewSearch = level.time;
	mi->nextDynViewSearch = level.time;
	mi->nextEnemySearch = level.time;
	mi->nextSpawnPoolCheck = level.time + 1000 + rand() % 1000;
	VectorCopy(spawnorigin, mi->lastCheckedSpawnPos);
	mi->generic1 = generic1;

	healthScale = G_MonsterHealthScale();

	switch (type) {
	case MT_predator:
	default:
		monster->classname = "monster predator";
		mi->ps.stats[STAT_WEAPONS] = 0;
		monster->s.weapon = WP_NONE;
		mi->ps.weapon = WP_NONE;
		mi->cmd.weapon = WP_NONE;
		mi->ps.ammo[WP_NONE] = -1;
		if (g_monsterBreeding.integer && g_gametype.integer == GT_STU) {
			mi->hibernationWaitTime = 15000 + LocallySeededRandom(&mi->seed) % 30000;
			mi->hibernationTime = level.time + mi->hibernationWaitTime;
		}
		break;
	case MT_guard:
		monster->classname = "monster guard";
		mi->ps.stats[STAT_WEAPONS] = (1 << WP_ROCKET_LAUNCHER);
		monster->s.weapon = WP_ROCKET_LAUNCHER;
		mi->ps.weapon = WP_ROCKET_LAUNCHER;
		mi->cmd.weapon = WP_ROCKET_LAUNCHER;
		mi->ps.ammo[WP_ROCKET_LAUNCHER] = -1;
		mi->ps.stats[STAT_ARMOR] = maxHealth;
		break;
	case MT_titan:
		monster->classname = "monster titan";
		mi->ps.stats[STAT_WEAPONS] = 0;
		monster->s.weapon = WP_NONE;
		mi->ps.weapon = WP_NONE;
		mi->cmd.weapon = WP_NONE;
		mi->ps.ammo[WP_NONE] = -1;
		break;
	}
	if (maxHealth <= 0) maxHealth = G_MonsterBaseHealth(type, healthScale);
	if (maxHealth < 1) maxHealth = 1;
	mi->ps.stats[STAT_MAX_HEALTH] = maxHealth;
	mi->ps.stats[STAT_HEALTH] = maxHealth;
	monster->health = maxHealth;

	BG_PlayerStateToEntityState(&mi->ps, &monster->s, qtrue);
	G_MonsterCorrectEntityState(monster);

	// JUHOX FIXME: why does this not work correctly?
	//G_KillBox(monster);

	trap_LinkEntity(monster);

	if (!telemorph) {
		numMonsters++;

		if (g_gametype.integer != GT_EFH) {
			G_TempEntity(spawnorigin, EV_PLAYER_TELEPORT_IN);
		}

	}

	return monster;
}


/*
===============
JUHOX: G_MonsterSpawning
===============
*/
void G_MonsterSpawning(void) {
	vec3_t mins, maxs;
	vec3_t spawnorigin;
	monsterspawnmode_t spawnmode;
	vec3_t spawnattractor;
	team_t spawnteam;
	int owner;
	int numMonstersOfOwner;
	int removeTime;
	gentity_t* monster;
	monsterType_t type;
	localseed_t localseed;
	localseed_t monsterseed;

	if (level.meeting) return;
	if (g_gametype.integer == GT_EFH) return;

	if (level.endPhase > 0) return;

	if (nextMonsterSpawnTime > level.time) return;

	if (nextMonsterSpawnTime < 0) {
		nextMonsterSpawnTime = level.startTime + 5000;
		return;
	}

	InitLocalSeed(GST_monsterSpawning, &localseed);

	// JUHOX FIXME: don't trust monster counting
	{
		int i;

		numMonsters = 0;
		for (i = MAX_CLIENTS; i < level.num_entities; i++) {
			gentity_t* ent;

			ent = &g_entities[i];
			if (!ent->inuse) continue;
			if (ent->s.eType != ET_PLAYER) continue;
			if (!ent->monster) continue;
			if (ent->health <= 0) continue;

			numMonsters++;
		}
	}

	if (firstMonsterTrap != lastMonsterTrap) {
		nextMonsterSpawnTime = level.time + 200;

		spawnmode = MSM_nearOrigin;
		VectorCopy(monsterTraps[firstMonsterTrap].origin, spawnattractor);
		spawnteam = TEAM_FREE;
		owner = -1;
		numMonstersOfOwner = -1;
		removeTime = 0;

		monsterTraps[firstMonsterTrap].numMonsters--;
		if (monsterTraps[firstMonsterTrap].numMonsters <= 0) {
			firstMonsterTrap = (firstMonsterTrap + 1) % MAX_MONSTER_TRAPS;
		}
	}
	else if (firstMonsterSeed != lastMonsterSeed) {
		gentity_t* seed;
		int i;

		nextMonsterSpawnTime = level.time + 200;

		spawnmode = MSM_atOrigin;
		seed = monsterSeeds[firstMonsterSeed].seed;
		owner = seed->r.ownerNum;
		if (owner < 0 || owner >= MAX_CLIENTS) return;
		G_FreeEntity(seed);
		spawnteam = level.clients[owner].sess.sessionTeam;
		VectorCopy(monsterSeeds[firstMonsterSeed].origin, spawnattractor);
		firstMonsterSeed = (firstMonsterSeed + 1) % MAX_MONSTER_SEEDS;

		numMonstersOfOwner = 0;
		for (i = 0; i < level.num_entities; i++) {
			gentity_t* ent;

			ent = &g_entities[i];
			if (!ent->inuse) continue;
			if (ent->s.eType != ET_PLAYER) continue;
			if (!ent->monster) continue;
			if (ent->health <= 0) continue;
			if (ent->monster->owner != owner) continue;

			numMonstersOfOwner++;
		}

		removeTime = level.time + 30000;
	}
	else if (g_gametype.integer == GT_STU) {
		if (numMonsters >= g_minMonsters.integer - 1 && g_monsterSpawnDelay.integer > 200) {
			nextMonsterSpawnTime = level.time + g_monsterSpawnDelay.integer;
		}
		else {
			nextMonsterSpawnTime = level.time + 200;
		}

		spawnmode = MSM_random;
		VectorClear(spawnattractor);
		spawnteam = TEAM_FREE;
		owner = -1;
		numMonstersOfOwner = -1;
		removeTime = 0;
	}
	else {
		return;
	}

	DeriveLocalSeed(&localseed, &monsterseed);

	switch (g_gametype.integer) {
	case GT_STU:
		type = G_MonsterType(&localseed);
		break;
	default:
		type = MT_predator;
		break;
	}

	G_GetMonsterBounds(type, mins, maxs);

	if (!G_GetMonsterSpawnPoint(mins, maxs, &localseed, spawnorigin, spawnmode, spawnattractor)) return;

	monster = NULL;
	if (
		numMonsters >= g_maxMonsters.integer ||
		numMonsters >= MAX_MONSTERS ||
		!freeMonster ||
		(
			owner >= 0 &&
			(
				numMonstersOfOwner >= g_maxMonsters.integer / level.numPlayingClients ||
				numMonstersOfOwner >= MAX_MONSTERS / level.numPlayingClients
			)
		)
	) {
		monster = RandomWaitingMonster(&localseed, owner);
		if (!monster) return;
		if (!monster->monster) return;
		TeleportPlayer(monster, spawnorigin, vec3_origin);
	}

	G_SpawnMonster(
		type, spawnorigin, NULL, removeTime, spawnteam, owner, &monsterseed, monster, 0, MA_waiting, -1
	);
}


/*
===============
JUHOX: G_GetEntityPlayerState
===============
*/
playerState_t* G_GetEntityPlayerState(const gentity_t* ent) {
	if (ent->client) return &ent->client->ps;
	if (ent->monster) return &ent->monster->ps;
	return NULL;
}

/*
===============
JUHOX: G_IsMonsterNearEntity
===============
*/
qboolean G_IsMonsterNearEntity(gentity_t* viewer, gentity_t* ent) {
	int i;

	for (i = 0; i < MAX_MONSTERS; i++) {
		gmonster_t* mi;
		trace_t trace;

		mi = &monsterInfo[i];
		if (!mi->ps.clientNum) continue;

		if (DistanceSquared(ent->s.pos.trBase, mi->ps.origin) > 700 * 700) continue;

		trap_Trace(&trace, viewer->s.pos.trBase, NULL, NULL, mi->ps.origin, viewer->s.number, MASK_SHOT);
		if (trace.fraction >= 1 || trace.entityNum != mi->ps.clientNum) continue;

		return qtrue;
	}
	return qfalse;
}


/*
===============
JUHOX: G_IsMonsterSuccessfulAttacking
===============
*/
qboolean G_IsMonsterSuccessfulAttacking(gentity_t* monster, gentity_t* exception) {
	gmonster_t* mi;

	mi = monster->monster;
	if (!mi) return qfalse;

	if (mi->action != MA_attacking) return qfalse;
	if (mi->lastEnemyHitTime < level.time - 3000) return qfalse;

	if (mi->enemy == exception) return qfalse;

	return qtrue;
}


/*
===============
JUHOX: G_ChargeMonsters
===============
*/
void G_ChargeMonsters(int msec, int chargePerSec) {
	int i;

	for (i = 0; i < MAX_MONSTERS; i++) {
		gmonster_t* mi;
		int charge;

		mi = &monsterInfo[i];
		if (!mi->ps.clientNum) continue;
		if (!mi->entity) continue;

		charge = msec * (rand() % chargePerSec) / 500;
		if (mi->type == MT_guard) charge *= 2;	// otherwise it would last too long to kill it
		if (mi->type == MT_titan) charge *= 3;
		if (mi->ps.powerups[PW_CHARGE] > level.time) {
			charge += mi->ps.powerups[PW_CHARGE] - level.time;
		}
		mi->ps.powerups[PW_CHARGE] = level.time + charge;
	}
}


/*
===============
JUHOX: G_IsAttackingGuard
===============
*/
qboolean G_IsAttackingGuard(int entnum) {
	const gentity_t* ent;

	if (entnum < 0 || entnum >= ENTITYNUM_WORLD) return qfalse;
	ent = &g_entities[entnum];
	if (!ent->inuse) return qfalse;
	if (!ent->monster) return qfalse;
	if (ent->monster->type != MT_guard) return qfalse;
	if (ent->monster->action != MA_attacking) return qfalse;
	return qtrue;
}


/*
===============
JUHOX: G_MonsterOwner
===============
*/
gentity_t* G_MonsterOwner(gentity_t* monster) {
	int ownernum;

	if (!monster->monster) return NULL;
	ownernum = monster->monster->owner;
	if (ownernum < 0 || ownernum >= level.maxclients) return NULL;
	return &g_entities[ownernum];
}


/*
===============
JUHOX: G_IsFriendlyMonster
===============
*/
qboolean G_IsFriendlyMonster(gentity_t* ent1, gentity_t* ent2) {
	playerState_t* ps;

	if (!ent2->monster) {
		gentity_t* e;

		if (!ent1->monster) return qfalse;

		e = ent2;
		ent2 = ent1;
		ent1 = e;
	}

	if (ent1 == ent2) return qtrue;

	ps = G_GetEntityPlayerState(ent1);
	if (!ps) return qtrue;	// a monster is "friendly" to everything not a player

	if (ent2->monster->enemy == ent1) return qfalse;
	if (ent1->monster && ent1->monster->enemy == ent2) return qfalse;

	if (ent2->monster->type == MT_titan) return qfalse;
	if (ent1->monster && ent1->monster->type == MT_titan) return qfalse;

	if (
		g_gametype.integer >= GT_TEAM &&
		ps->persistant[PERS_TEAM] == ent2->monster->ps.persistant[PERS_TEAM]
	) {
		return qtrue;
	}

	if (ent2->monster->owner == ps->clientNum) return qtrue;
	if (ent1->monster && ent1->monster->owner == ent2->monster->owner) return qtrue;

	return qfalse;
}


/*
===============
JUHOX: G_Constitution
===============
*/
int G_Constitution(const gentity_t* ent) {
	if (!ent->inuse) return 0;

	if (ent->client) {
		return (3 * ent->client->ps.stats[STAT_MAX_HEALTH]) / 2;	// assume 50% armor
	}

	if (ent->monster) {
		switch (ent->monster->type) {
		case MT_predator:
			return ent->monster->ps.stats[STAT_MAX_HEALTH];
		case MT_guard:
			return 2 * ent->monster->ps.stats[STAT_MAX_HEALTH];	// consider armor
		case MT_titan:
			return ent->monster->ps.stats[STAT_MAX_HEALTH];
		default:
			return 0;
		}
	}

	return 0;
}

/*
===============
JUHOX: G_ReleaseTrap
===============
*/
void G_ReleaseTrap(int numMonsters, const vec3_t origin) {
	int nextMonsterTrap;

	if (numMonsters <= 0) return;

	nextMonsterTrap = (lastMonsterTrap + 1) % MAX_MONSTER_TRAPS;
	if (nextMonsterTrap == firstMonsterTrap) return;

	VectorCopy(origin, monsterTraps[lastMonsterTrap].origin);
	monsterTraps[lastMonsterTrap].numMonsters = numMonsters;
	lastMonsterTrap = nextMonsterTrap;

	if (nextMonsterSpawnTime > level.time + 200) {
		nextMonsterSpawnTime = level.time;
	}
}


/*
===============
JUHOX: G_AddMonsterSeed
===============
*/
qboolean G_AddMonsterSeed(const vec3_t origin, gentity_t* seed) {
	int nextMonsterSeed;

	nextMonsterSeed = (lastMonsterSeed + 1) % MAX_MONSTER_SEEDS;
	if (nextMonsterSeed == firstMonsterSeed) return qfalse;

	VectorCopy(origin, monsterSeeds[lastMonsterSeed].origin);
	monsterSeeds[lastMonsterSeed].seed = seed;
	lastMonsterSeed = nextMonsterSeed;

	if (nextMonsterSpawnTime > level.time + 200) {
		nextMonsterSpawnTime = level.time;
	}
	return qtrue;
}


/*
===============
JUHOX: G_UpdateMonsterCounters
===============
*/
void G_UpdateMonsterCounters(void) {
	int i;

	if (g_gametype.integer >= GT_STU) return;
	if (!g_monsterLauncher.integer) return;

	level.maxMonstersPerPlayer = g_maxMonsters.integer;
	if (level.numPlayingClients > 0) level.maxMonstersPerPlayer /= level.numPlayingClients;
	if (level.maxMonstersPerPlayer > g_maxMonstersPP.integer) {
		level.maxMonstersPerPlayer = g_maxMonstersPP.integer;
	}

	for (i = 0; i < level.maxclients; i++) {
		level.clients[i].monstersAvailable = level.maxMonstersPerPlayer;
	}

	for (i = MAX_CLIENTS; i < level.num_entities; i++) {
		gentity_t* ent;
		gmonster_t* mi;
		gclient_t* client;

		ent = &g_entities[i];
		if (!ent->inuse) continue;


		mi = ent->monster;
		if (!mi) {
			if (ent->s.eType != ET_MISSILE) continue;
			if (ent->s.weapon != WP_MONSTER_LAUNCHER) continue;

			client = ent->parent->client;
			if (!client) continue;
		}
		else {
			if (ent->health <= 0) continue;

			if (mi->owner < 0) continue;
			if (mi->owner >= MAX_CLIENTS) continue;

			client = &level.clients[mi->owner];
		}

		client->monstersAvailable--;
	}
}


/*
===============
JUHOX: G_CanBeDamaged
===============
*/

qboolean G_CanBeDamaged(gentity_t* ent) {
	if (!ent->monster) return qtrue;
	if (ent->monster->action == MA_sleeping) return qfalse;
	return qtrue;
}


/*
===============
JUHOX: G_IsMovable
===============
*/
qboolean G_IsMovable(gentity_t* ent) {
	if (!ent->monster) return qtrue;
	if (ent->monster->type != MT_titan) return qtrue;
	if (ent->monster->action != MA_sleeping) return qtrue;
	return qfalse;
}


/*
===============
JUHOX: G_GetMonsterGeneric1
===============
*/
int G_GetMonsterGeneric1(gentity_t* monster) {
	if (!monster->monster) return -1;
	return monster->monster->generic1;
}


/*
===============
JUHOX: G_CheckMonsterDamage
===============
*/
void G_CheckMonsterDamage(gentity_t* monster, gentity_t* target, int mod) {
	gmonster_t* mi;

	mi = monster->monster;
	if (!mi) return;

	if (mi->enemy != target) return;

	switch (mi->type) {
	case MT_predator:
		if (mod != MOD_CLAW) return;
		break;
	case MT_guard:
		if (mod != MOD_GUARD) return;
		break;
	case MT_titan:
		if (mod != MOD_TITAN) return;
		break;
	default:
		return;
	}

	mi->lastEnemyHitTime = level.time;
}


/*
===============
JUHOX: G_MonsterAction
===============
*/
monsterAction_t G_MonsterAction(gentity_t* monster) {
	if (!monster->monster) return MA_waiting;
	return monster->monster->action;
}


/*
=================
JUHOX: IsPlayerFighting
=================
*/
qboolean IsPlayerFighting(int entityNum) {
	if (entityNum < 0 || entityNum >= ENTITYNUM_WORLD) return qfalse;

	if (!g_entities[entityNum].inuse) return qfalse;
	if (g_entities[entityNum].health <= 0) return qfalse;

	if (entityNum < MAX_CLIENTS) {
		if (level.clients[entityNum].weaponUsageTime > level.time - 3000) return qtrue;
	}

	else if (g_entities[entityNum].monster) {
		if (g_entities[entityNum].monster->action == MA_attacking) return qtrue;
	}

	return qfalse;
}
