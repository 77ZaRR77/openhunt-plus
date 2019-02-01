// Copyright (C) 1999-2000 Id Software, Inc.
//

#include "g_local.h"
#include "bg_promode.h" // SLK

level_locals_t	level;

typedef struct {
	vmCvar_t	*vmCvar;
	char		*cvarName;
	char		*defaultString;
	int			cvarFlags;
	int			modificationCount;  // for tracking changes
	qboolean	trackChange;	    // track this variable, and announce if changed
  qboolean teamShader;        // track and if changed, update shader state
} cvarTable_t;

gentity_t		g_entities[MAX_GENTITIES];
gclient_t		g_clients[MAX_CLIENTS];

// JUHOX: server global variables for game templates
char templateFileList[TEMPLATE_FILE_LIST_SIZE];
int numTemplateFiles;
gametemplatelist_t templateList;
long templateListChecksum;
char templateChecksumString[MAX_GAMETEMPLATES + 1];

typedef struct {
	int number;
	unsigned char flags[MAX_GAMETEMPLATES / 8];
} transferredTemplates_t;
static transferredTemplates_t transferredTemplatesPerClient[MAX_CLIENTS];
static qboolean clientWantsTemplateTransfer[MAX_CLIENTS];
static int lastServedClient;
static int numClientsToServe;
static int nextServiceTime;
long sv_mapChecksum;
static const char* hiscoreRejectionReason;

vmCvar_t	g_editmode; // JUHOX: cvar for map lens flares
vmCvar_t	g_gametype;
vmCvar_t	g_dmflags;
vmCvar_t	g_fraglimit;
vmCvar_t	g_timelimit;
vmCvar_t	g_capturelimit;
// JUHOX: STU cvar definitions
vmCvar_t	g_artefacts;
vmCvar_t	g_minMonsters;
vmCvar_t	g_maxMonsters;
vmCvar_t	g_monsterSpawnDelay;
vmCvar_t	g_monsterHealthScale;
vmCvar_t	g_monsterGuards;
vmCvar_t	g_monsterTitans;
vmCvar_t	g_monstersPerTrap;
vmCvar_t	g_skipEndSequence;
vmCvar_t	g_monsterLauncher;
vmCvar_t	g_maxMonstersPP;
vmCvar_t	g_monsterBreeding;
vmCvar_t	g_monsterProgression;
vmCvar_t	g_scoreMode;
// JUHOX: EFH cvar definitions
vmCvar_t	g_monsterLoad;
vmCvar_t	g_distanceLimit;
vmCvar_t	g_challengingEnv;
vmCvar_t	g_debugEFH;
vmCvar_t	g_template;				// JUHOX
vmCvar_t	g_gameSeed;				// JUHOX
vmCvar_t	g_respawnDelay;			// JUHOX
vmCvar_t	g_respawnAtPOD;			// JUHOX
vmCvar_t	g_tss;					// JUHOX
vmCvar_t	g_tssSafetyMode;		// JUHOX
vmCvar_t	g_armorFragments;		// JUHOX
vmCvar_t	g_stamina;				// JUHOX
vmCvar_t	g_baseHealth;			// JUHOX
vmCvar_t	g_lightningDamageLimit;	// JUHOX
vmCvar_t	g_grapple;				// JUHOX
vmCvar_t	g_noItems;				// JUHOX
vmCvar_t	g_noHealthRegen;		// JUHOX
vmCvar_t	g_unlimitedAmmo;		// JUHOX
vmCvar_t	g_cloakingDevice;		// JUHOX
vmCvar_t	g_weaponLimit;			// JUHOX
vmCvar_t	g_friendlyFire;
vmCvar_t	g_password;
vmCvar_t	g_needpass;
#if MEETING
vmCvar_t	g_meeting;				// JUHOX
#endif
vmCvar_t	g_maxclients;
vmCvar_t	g_maxGameClients;
vmCvar_t	g_dedicated;
vmCvar_t	g_speed;
vmCvar_t	g_gravity;
vmCvar_t	g_cheats;
vmCvar_t	g_knockback;
vmCvar_t	g_quadfactor;
vmCvar_t	g_forcerespawn;
vmCvar_t	g_inactivity;
vmCvar_t	g_debugMove;
vmCvar_t	g_debugDamage;
vmCvar_t	g_debugAlloc;
vmCvar_t	g_weaponRespawn;
vmCvar_t	g_weaponTeamRespawn;
vmCvar_t	g_motd;
vmCvar_t	g_synchronousClients;
vmCvar_t	g_warmup;
vmCvar_t	g_doWarmup;
vmCvar_t	g_restarted;
vmCvar_t	g_log;
vmCvar_t	g_logSync;
vmCvar_t	g_blood;
vmCvar_t	g_podiumDist;
vmCvar_t	g_podiumDrop;
vmCvar_t	g_allowVote;
vmCvar_t	g_teamAutoJoin;
vmCvar_t	g_teamForceBalance;
vmCvar_t	g_banIPs;
vmCvar_t	g_filterBan;
vmCvar_t	g_smoothClients;
vmCvar_t	pmove_fixed;
vmCvar_t	pmove_msec;
vmCvar_t	g_rankings;
vmCvar_t	g_listEntity;
vmCvar_t	g_mapName;	// JUHOX

vmCvar_t    g_promode; // SLK

// JUHOX: need gameCvarTable[] global accessible (not static)
cvarTable_t		gameCvarTable[] = {

	// don't override the cheat state set by the system
	{ &g_cheats, "sv_cheats", "", 0, 0, qfalse },

	// noset vars
	{ NULL, "gamename", GAMEVERSION , CVAR_SERVERINFO | CVAR_ROM, 0, qfalse  },
	{ NULL, "gamedate", __DATE__ , CVAR_ROM, 0, qfalse  },
	{ &g_restarted, "g_restarted", "0", CVAR_ROM, 0, qfalse  },
	{ NULL, "sv_mapname", "", CVAR_SERVERINFO | CVAR_ROM, 0, qfalse  },

    // JUHOX: cvars for map lens flares
	{ &g_editmode, "g_editmode", "0", CVAR_SERVERINFO | CVAR_INIT, 0, qfalse },

	// latched vars
	{ &g_gametype, "g_gametype", "0", CVAR_SERVERINFO | CVAR_USERINFO | CVAR_LATCH, 0, qfalse  },

	{ &g_maxclients, "sv_maxclients", "8", CVAR_SERVERINFO | CVAR_LATCH | CVAR_ARCHIVE, 0, qfalse  },
	{ &g_maxGameClients, "g_maxGameClients", "0", CVAR_SERVERINFO | CVAR_LATCH | CVAR_ARCHIVE, 0, qfalse  },
	{ &g_tssSafetyMode, "tssSafetyModeAllowed", "1", CVAR_SERVERINFO | CVAR_LATCH | CVAR_ARCHIVE, 0, qfalse },	// JUHOX
	{ &g_armorFragments, "g_armorFragments", "1", CVAR_ARCHIVE | CVAR_LATCH, 0, qfalse },	// JUHOX
	{ &g_baseHealth, "g_baseHealth", "300", CVAR_ARCHIVE | CVAR_SERVERINFO | CVAR_LATCH, 0, qfalse },	// JUHOX

	// change anytime vars
	{ &g_dmflags, "dmflags", "0", CVAR_SERVERINFO | CVAR_ARCHIVE, 0, qtrue  },
	{ &g_fraglimit, "fraglimit", "20", CVAR_SERVERINFO | CVAR_ARCHIVE | CVAR_NORESTART, 0, qtrue },
	{ &g_timelimit, "timelimit", "0", CVAR_SERVERINFO | CVAR_ARCHIVE | CVAR_NORESTART, 0, qtrue },
	{ &g_capturelimit, "capturelimit", "8", CVAR_SERVERINFO | CVAR_ARCHIVE | CVAR_NORESTART, 0, qtrue },
	// JUHOX: STU cvar definition
	{ &g_artefacts, "g_artefacts", "8", CVAR_SERVERINFO | CVAR_ARCHIVE | CVAR_NORESTART | CVAR_LATCH, 0, qfalse },
	{ &g_minMonsters, "g_minMonsters", "15", CVAR_ARCHIVE | CVAR_SERVERINFO | CVAR_NORESTART, 0, qfalse },
	{ &g_maxMonsters, "g_maxMonsters", "30", CVAR_ARCHIVE | CVAR_SERVERINFO | CVAR_NORESTART, 0, qfalse },
	{ &g_monsterSpawnDelay, "g_monsterSpawnDelay", "10000", CVAR_ARCHIVE | CVAR_SERVERINFO | CVAR_NORESTART, 0, qfalse },
	{ &g_monsterHealthScale, "g_monsterHealthScale", "100", CVAR_ARCHIVE | CVAR_SERVERINFO | CVAR_NORESTART, 0, qfalse },
	{ &g_monsterProgression, "g_monsterProgression", "0", CVAR_ARCHIVE, 0, qfalse },
	{ &g_monsterGuards, "g_monsterGuards", "12", CVAR_ARCHIVE | CVAR_SERVERINFO | CVAR_NORESTART, 0, qfalse },
	{ &g_monsterTitans, "g_monsterTitans", "6", CVAR_ARCHIVE | CVAR_SERVERINFO | CVAR_NORESTART, 0, qfalse },
	{ &g_monstersPerTrap, "g_monstersPerTrap", "0", CVAR_ARCHIVE, 0, qfalse },
	{ NULL, "monsterModel1", "klesk/maneater", CVAR_ARCHIVE | CVAR_SERVERINFO | CVAR_LATCH, 0, qfalse },
	{ NULL, "monsterModel2", "tankjr/default", CVAR_ARCHIVE | CVAR_SERVERINFO | CVAR_LATCH, 0, qfalse },
	{ NULL, "monsterModel3", "uriel/default", CVAR_ARCHIVE | CVAR_SERVERINFO | CVAR_LATCH, 0, qfalse },
	{ &g_skipEndSequence, "g_skipEndSequence", "0", CVAR_ARCHIVE, 0, qfalse },
	{ &g_monsterLauncher, "g_monsterLauncher", "0", CVAR_ARCHIVE | CVAR_SERVERINFO | CVAR_LATCH, 0, qfalse },
	{ &g_maxMonstersPP, "g_maxMonstersPP", "10", CVAR_ARCHIVE, 0, qtrue },
	{ &g_monsterBreeding, "g_monsterBreeding", "1", CVAR_ARCHIVE, 0, qfalse },
	{ &g_scoreMode, "g_scoreMode", "0", CVAR_ARCHIVE, 0, qfalse },

	// JUHOX: EFH cvar definitions
	{ &g_monsterLoad, "g_monsterLoad", "30", CVAR_ARCHIVE, 0, qfalse },
	{ &g_distanceLimit, "distancelimit", "3000", CVAR_SERVERINFO | CVAR_ARCHIVE | CVAR_LATCH, 0, qfalse },
	{ &g_challengingEnv, "g_challengingEnv", "1", CVAR_ARCHIVE | CVAR_LATCH, 0, qfalse },
	{ &g_debugEFH, "g_debugEFH", "0", CVAR_SYSTEMINFO | CVAR_INIT, 0, qfalse },
	{ &g_template, "g_template", "", 0, 0, qfalse },	// JUHOX
	{ &g_gameSeed, "g_gameSeed", "0", CVAR_ARCHIVE | CVAR_LATCH, 0, qfalse },	// JUHOX
	{ &g_respawnDelay, "respawnDelay", "10", CVAR_ARCHIVE | CVAR_SERVERINFO, 0, qtrue },	// JUHOX
	{ &g_respawnAtPOD, "respawnAtPOD", "0", CVAR_ARCHIVE, 0, qtrue },	// JUHOX
	{ &g_tss, "tss", "1", CVAR_SERVERINFO | CVAR_ARCHIVE, 0, qtrue },	// JUHOX
	{ &g_stamina, "g_stamina", "0", CVAR_SERVERINFO | CVAR_ARCHIVE, 0, qtrue },	// JUHOX
	{ &g_lightningDamageLimit, "g_lightningDamageLimit", "0", CVAR_ARCHIVE, 0, qtrue },	// JUHOX
	{ &g_grapple, "g_grapple", "0", CVAR_ARCHIVE | CVAR_LATCH | CVAR_SERVERINFO, 0, qfalse },	// JUHOX
	{ &g_noItems, "g_noItems", "0", CVAR_ARCHIVE | CVAR_LATCH, 0, qfalse },	// JUHOX
	{ &g_noHealthRegen, "g_noHealthRegen", "0", CVAR_ARCHIVE, 0, qtrue },	// JUHOX
	{ &g_unlimitedAmmo, "g_unlimitedAmmo", "0", CVAR_ARCHIVE | CVAR_LATCH, 0, qfalse },	// JUHOX
	{ &g_cloakingDevice, "g_cloakingDevice", "1", CVAR_ARCHIVE | CVAR_LATCH, 0, qfalse },	// JUHOX
	{ &g_weaponLimit, "g_weaponLimit", "0", CVAR_ARCHIVE | CVAR_LATCH | CVAR_SERVERINFO, 0, qfalse },	// JUHOX

#if MEETING
	{ &g_meeting, "g_meeting", "0", CVAR_ARCHIVE | CVAR_SERVERINFO, 0, qtrue },	// JUHOX
#endif

	{ &g_synchronousClients, "g_synchronousClients", "0", CVAR_SYSTEMINFO, 0, qfalse  },

	{ &g_friendlyFire, "g_friendlyFire", "0", CVAR_ARCHIVE, 0, qtrue  },

	{ &g_teamAutoJoin, "g_teamAutoJoin", "0", CVAR_ARCHIVE  },
	{ &g_teamForceBalance, "g_teamForceBalance", "0", CVAR_ARCHIVE  },

	{ &g_warmup, "g_warmup", "20", CVAR_ARCHIVE, 0, qtrue  },
	{ &g_doWarmup, "g_doWarmup", "0", 0, 0, qtrue  },
	{ &g_log, "g_log", "games.log", CVAR_ARCHIVE, 0, qfalse  },
	{ &g_logSync, "g_logSync", "0", CVAR_ARCHIVE, 0, qfalse  },

	{ &g_password, "g_password", "", CVAR_USERINFO, 0, qfalse  },

	{ &g_banIPs, "g_banIPs", "", CVAR_ARCHIVE, 0, qfalse  },
	{ &g_filterBan, "g_filterBan", "1", CVAR_ARCHIVE, 0, qfalse  },

	{ &g_needpass, "g_needpass", "0", CVAR_SERVERINFO | CVAR_ROM, 0, qfalse },

	{ &g_dedicated, "dedicated", "0", 0, 0, qfalse  },

	{ &g_speed, "g_speed", "320", 0, 0, qtrue  },
	{ &g_gravity, "g_gravity", "800", 0, 0, qtrue  },
	{ NULL, "g_gravityLatch", "", CVAR_ROM, 0, qfalse },	// JUHOX
	{ &g_knockback, "g_knockback", "1000", 0, 0, qtrue  },
	{ &g_quadfactor, "g_quadfactor", "3", 0, 0, qtrue  },
	{ &g_weaponRespawn, "g_weaponrespawn", "5", 0, 0, qtrue  },
	{ &g_weaponTeamRespawn, "g_weaponTeamRespawn", "30", 0, 0, qtrue },
	{ &g_forcerespawn, "g_forcerespawn", "20", 0, 0, qtrue },
	{ &g_inactivity, "g_inactivity", "0", 0, 0, qtrue },
	{ &g_debugMove, "g_debugMove", "0", 0, 0, qfalse },
	{ &g_debugDamage, "g_debugDamage", "0", 0, 0, qfalse },
	{ &g_debugAlloc, "g_debugAlloc", "0", 0, 0, qfalse },
	{ &g_motd, "g_motd", "", 0, 0, qfalse },
	{ &g_blood, "com_blood", "1", 0, 0, qfalse },

	{ &g_podiumDist, "g_podiumDist", "80", 0, 0, qfalse },
	{ &g_podiumDrop, "g_podiumDrop", "70", 0, 0, qfalse },

	{ &g_allowVote, "g_allowVote", "1", CVAR_ARCHIVE, 0, qfalse },
	{ &g_listEntity, "g_listEntity", "0", 0, 0, qfalse },

	{ &g_mapName, "mapname", "", CVAR_SERVERINFO | CVAR_ROM, 0, qfalse },	// JUHOX
	{ NULL, "svtmplfiles", "", CVAR_ROM | CVAR_NORESTART, 0, qfalse },	// JUHOX

	{ &g_smoothClients, "g_smoothClients", "1", 0, 0, qfalse},
	{ &pmove_fixed, "pmove_fixed", "0", CVAR_SYSTEMINFO, 0, qfalse},
	{ &pmove_msec, "pmove_msec", "8", CVAR_SYSTEMINFO, 0, qfalse},

	{ &g_rankings, "g_rankings", "0", 0, 0, qfalse},

	{ &g_promode, "g_promode", "0", CVAR_SERVERINFO, 0, qtrue  } // SLK

};

// bk001129 - made static to avoid aliasing
static int gameCvarTableSize = sizeof( gameCvarTable ) / sizeof( gameCvarTable[0] );

void G_InitGame( int levelTime, int randomSeed, int restart );
void G_RunFrame( int levelTime );
void G_ShutdownGame( int restart );
void CheckExitRules( void );
static qboolean DoCvarSettingsMatchTemplate(const gametemplate_t* gt);	// JUHOX


/*
================
vmMain

This is the only way control passes into the module.
This must be the very first function compiled into the .q3vm file
================
*/
int vmMain( int command, int arg0, int arg1, int arg2, int arg3, int arg4, int arg5, int arg6, int arg7, int arg8, int arg9, int arg10, int arg11  ) {
	switch ( command ) {
	case GAME_INIT:
		G_InitGame( arg0, arg1, arg2 );
		return 0;
	case GAME_SHUTDOWN:
		G_ShutdownGame( arg0 );
		return 0;
	case GAME_CLIENT_CONNECT:
		return (int)ClientConnect( arg0, arg1, arg2 );
	case GAME_CLIENT_THINK:
		ClientThink( arg0 );
		return 0;
	case GAME_CLIENT_USERINFO_CHANGED:
		ClientUserinfoChanged( arg0 );
		return 0;
	case GAME_CLIENT_DISCONNECT:
		ClientDisconnect( arg0 );
		return 0;
	case GAME_CLIENT_BEGIN:
		ClientBegin( arg0 );
		return 0;
	case GAME_CLIENT_COMMAND:
		ClientCommand( arg0 );
		return 0;
	case GAME_RUN_FRAME:
		G_RunFrame( arg0 );
		return 0;
	case GAME_CONSOLE_COMMAND:
		return ConsoleCommand();
	case BOTAI_START_FRAME:
		return BotAIStartFrame( arg0 );
	}

	return -1;
}


void QDECL G_Printf( const char *fmt, ... ) {
	va_list		argptr;
	char		text[1024];

	va_start (argptr, fmt);
	vsprintf (text, fmt, argptr);
	va_end (argptr);

	trap_Print( text );
}

void QDECL G_Error( const char *fmt, ... ) {
	va_list		argptr;
	char		text[1024];

	va_start (argptr, fmt);
	vsprintf (text, fmt, argptr);
	va_end (argptr);

	trap_Error( text );
}

/*
================
G_FindTeams

Chain together all entities with a matching team field.
Entity teams are used for item groups and multi-entity mover groups.

All but the first will have the FL_TEAMSLAVE flag set and teammaster field set
All but the last will have the teamchain field set to the next one
================
*/
void G_FindTeams( void ) {
	gentity_t	*e, *e2;
	int		i, j;
	int		c, c2;

	c = 0;
	c2 = 0;
	for ( i=1, e=g_entities+i ; i < level.num_entities ; i++,e++ ){
		if (!e->inuse)
			continue;
		if (!e->team)
			continue;
		if (e->flags & FL_TEAMSLAVE)
			continue;
		e->teammaster = e;
		c++;
		c2++;
		for (j=i+1, e2=e+1 ; j < level.num_entities ; j++,e2++)
		{
			if (!e2->inuse)
				continue;
			if (!e2->team)
				continue;
			if (e2->flags & FL_TEAMSLAVE)
				continue;
			if (!strcmp(e->team, e2->team))
			{
				c2++;
				e2->teamchain = e->teamchain;
				e->teamchain = e2;
				e2->teammaster = e;
				e2->flags |= FL_TEAMSLAVE;

				// make sure that targets only point at the master
				if ( e2->targetname ) {
					e->targetname = e2->targetname;
					e2->targetname = NULL;
				}
			}
		}
	}

	G_Printf ("%i teams with %i entities\n", c, c2);
}

void G_RemapTeamShaders() { //SLK: remove
}


/*
=================
G_RegisterCvars
=================
*/
void G_RegisterCvars( void ) {
	int			i;
	cvarTable_t	*cv;
	qboolean remapped = qfalse;

	for ( i = 0, cv = gameCvarTable ; i < gameCvarTableSize ; i++, cv++ ) {
		trap_Cvar_Register( cv->vmCvar, cv->cvarName,
			cv->defaultString, cv->cvarFlags );
		if ( cv->vmCvar )
			cv->modificationCount = cv->vmCvar->modificationCount;

		if (cv->teamShader) {
			remapped = qtrue;
		}

	}

	if (remapped) {
		G_RemapTeamShaders();
	}

	// check some things
	if ( g_gametype.integer < 0 || g_gametype.integer >= GT_MAX_GAME_TYPE ) {
		G_Printf( "g_gametype %i is out of range, defaulting to 0\n", g_gametype.integer );
		trap_Cvar_Set( "g_gametype", "0" );
	}

	level.warmupModificationCount = g_warmup.modificationCount;
}

/*
=================
G_UpdateCvars
=================
*/
void G_UpdateCvars( void ) {
	int			i;
	cvarTable_t	*cv;
	qboolean remapped = qfalse;

	for ( i = 0, cv = gameCvarTable ; i < gameCvarTableSize ; i++, cv++ ) {
		if ( cv->vmCvar ) {
			trap_Cvar_Update( cv->vmCvar );

			if ( cv->modificationCount != cv->vmCvar->modificationCount ) {
				cv->modificationCount = cv->vmCvar->modificationCount;

				// SLK: Detect if g_promode has been changed
				if (!strcmp(cv->cvarName,"g_promode"))
				{
					// Update all settings
					CPM_UpdateSettings((g_promode.integer) ?
						((g_gametype.integer == GT_TEAM) ? 2 : 1) : 0);

					// Set the config string (so clients will be updated)
					trap_SetConfigstring(CS_PRO_MODE, va("%d", g_promode.integer));

					// Update all pro mode-dependent server-side cvars

					if (g_promode.integer)
					{
						// pro mode default

					}
					else
					{
						// q3 default

					}
				}
				// !SLK

				if ( cv->trackChange ) {
					trap_SendServerCommand( -1, va("print \"Server: %s changed to %s\n\"",
						cv->cvarName, cv->vmCvar->string ) );
				}

				if (cv->teamShader) {
					remapped = qtrue;
				}

			}
		}
	}

	if (remapped) {
		G_RemapTeamShaders();
	}
}

/*
==================
JUHOX: HighscoreName
==================
*/
static const char* HighscoreName(const gametemplate_t* gt, const char* templatename) {
	static char name[256];
	int i;
	int len;

	if (
		gt->tksHighscorename > TKS_missing &&
		gt->highscorename[0]
	) {
		Q_strncpyz(name, gt->highscorename, sizeof(name));
	}
	else {
		Q_strncpyz(name, templatename, sizeof(name));
	}

	len = strlen(name);
	for (i = 0; i < len; i++) {
		if (name[i] >= 'a' && name[i] <= 'z') continue;
		if (name[i] >= 'A' && name[i] <= 'Z') continue;
		if (name[i] >= '0' && name[i] <= '9') continue;
		name[i] = '_';
	}
	return name;
}

/*
==================
JUHOX: InitRecord
==================
*/
static void InitRecord(void) {
	char info[MAX_INFO_STRING];
	gametemplate_t gt;
	char* scoreVarName;
	char scoreVarContents[64];

	trap_SetConfigstring(CS_RECORD, "0,0");

	if (!g_template.string[0]) return;

	trap_Cvar_VariableStringBuffer(g_template.string, info, sizeof(info));
	if (!BG_ParseGameTemplate(info, &gt)) return;
	if (gt.tksHighscoretype <= TKS_missing) return;
	if (!DoCvarSettingsMatchTemplate(&gt)) return;

	scoreVarName = va("%s0", HighscoreName(&gt, g_template.string));
	trap_Cvar_VariableStringBuffer(scoreVarName, scoreVarContents, sizeof(scoreVarContents));

	trap_SetConfigstring(CS_RECORD, va("%d,%d", gt.highscoretype, atoi(scoreVarContents)));
}

/*
============
G_InitGame

============
*/
void G_InitGame( int levelTime, int randomSeed, int restart ) {
	int					i;

	G_Printf ("------- Game Initialization -------\n");
	G_Printf ("gamename: %s\n", GAMEVERSION);
	G_Printf ("gamedate: %s\n", __DATE__);

	srand( randomSeed );

	G_RegisterCvars();

	G_ProcessIPBans();

	G_InitMemory();

	// SLK:Initialize CPM
        // Update all settings
        CPM_UpdateSettings((g_promode.integer) ?
		((g_gametype.integer == GT_TEAM) ? 2 : 1) : 0);

        // Set the config string
        trap_SetConfigstring(CS_PRO_MODE, va("%d", g_promode.integer));
	// !SLK

	// set some level globals
	memset( &level, 0, sizeof( level ) );
	level.time = levelTime;
	level.startTime = levelTime;
	G_InitGameTemplates();	// JUHOX
	G_InitWorldSystem();	// JUHOX

#if MEETING	// JUHOX: check for meeting
	level.meeting = g_meeting.integer;
#endif

	level.snd_fry = G_SoundIndex("sound/player/fry.wav");	// FIXME standing in lava / slime

	if ( g_gametype.integer != GT_SINGLE_PLAYER && g_log.string[0] ) {
		if ( g_logSync.integer ) {
			trap_FS_FOpenFile( g_log.string, &level.logFile, FS_APPEND_SYNC );
		} else {
			trap_FS_FOpenFile( g_log.string, &level.logFile, FS_APPEND );
		}
		if ( !level.logFile ) {
			G_Printf( "WARNING: Couldn't open logfile: %s\n", g_log.string );
		} else {
			char	serverinfo[MAX_INFO_STRING];

			trap_GetServerinfo( serverinfo, sizeof( serverinfo ) );

			G_LogPrintf("------------------------------------------------------------\n" );
			G_LogPrintf("InitGame: %s\n", serverinfo );
		}
	} else {
		G_Printf( "Not logging to disk.\n" );
	}

	G_InitWorldSession();

	// initialize all entities for this game
	memset( g_entities, 0, MAX_GENTITIES * sizeof(g_entities[0]) );
	level.gentities = g_entities;

	// initialize all clients for this game
	level.maxclients = g_maxclients.integer;
	memset( g_clients, 0, MAX_CLIENTS * sizeof(g_clients[0]) );
	level.clients = g_clients;

	// set client fields on player ents
	for ( i=0 ; i<level.maxclients ; i++ ) {
		g_entities[i].client = level.clients + i;
	}

	// always leave room for the max number of clients,
	// even if they aren't all used, so numbers inside that
	// range are NEVER anything but clients
	level.num_entities = MAX_CLIENTS;

	// let the server system know where the entites are
	trap_LocateGameData( level.gentities, level.num_entities, sizeof( gentity_t ),
		&level.clients[0].ps, sizeof( level.clients[0] ) );

	// reserve some spots for dead player bodies
	InitBodyQue();

	ClearRegisteredItems();

	// parse the key/value pairs and spawn gentities
	G_SpawnEntitiesFromString();

	// general initialization
	G_FindTeams();

	// make sure we have flags for CTF, etc
	if( g_gametype.integer >= GT_TEAM ) {
		G_CheckTeamItems();
	}

	SaveRegisteredItems();

	if (g_gametype.integer == GT_EFH) G_SpawnWorld();	// JUHOX

	G_Printf ("-----------------------------------\n");

	if( g_gametype.integer == GT_SINGLE_PLAYER || trap_Cvar_VariableIntegerValue( "com_buildScript" ) ) {
		G_ModelIndex( SP_PODIUM_MODEL );
		G_SoundIndex( "sound/player/gurp1.wav" );
		G_SoundIndex( "sound/player/gurp2.wav" );
	}

	if ( trap_Cvar_VariableIntegerValue("bot_enable") && g_gametype.integer != GT_EFH ) {
		BotAISetup( restart );
		BotAILoadMap( restart );
		G_InitBots( restart );
	}
	// JUHOX: init STU
	G_InitMonsters();
	trap_SetConfigstring(CS_HIGHSCORETEXT, "");	// JUHOX
	trap_SetConfigstring(CS_NUMMONSTERS, "000,0");	// JUHOX
	trap_SetConfigstring(CS_STU_SCORE, "0");	// JUHOX
	trap_SetConfigstring(CS_EFH_COVERED_DISTANCE, "0,0");	// JUHOX
	trap_SetConfigstring(CS_EFH_SPEED, "");	// JUHOX

	InitRecord();	// JUHOX
	trap_SetConfigstring(CS_CLIENTS_READY, "");	// JUHOX
#if MEETING
	trap_SetConfigstring(CS_MEETING, va("%d", level.meeting));	// JUHOX
#endif
	trap_SetConfigstring(CS_CHOOSENWEAPONS, "");	// JUHOX

	G_LoadGameTemplates();	// JUHOX

	G_RemapTeamShaders();
}



/*
=================
G_ShutdownGame
=================
*/
void G_ShutdownGame( int restart ) {
	G_Printf ("==== ShutdownGame ====\n");

	if ( level.logFile ) {
		G_LogPrintf("ShutdownGame:\n" );
		G_LogPrintf("------------------------------------------------------------\n" );
		trap_FS_FCloseFile( level.logFile );
	}

	// write all the client session data so we can get it back
	G_WriteSessionData();

	if ( trap_Cvar_VariableIntegerValue("bot_enable") && g_gametype.integer != GT_EFH ) {
		BotAIShutdown( restart );
	}
}



//===================================================================

#ifndef GAME_HARD_LINKED
// this is only here so the functions in q_shared.c and bg_*.c can link

void QDECL Com_Error ( int level, const char *error, ... ) {
	va_list		argptr;
	char		text[1024];

	va_start (argptr, error);
	vsprintf (text, error, argptr);
	va_end (argptr);

	G_Error( "%s", text);
}

void QDECL Com_Printf( const char *msg, ... ) {
	va_list		argptr;
	char		text[1024];

	va_start (argptr, msg);
	vsprintf (text, msg, argptr);
	va_end (argptr);

	G_Printf ("%s", text);
}

#endif

/*
========================================================================

PLAYER COUNTING / SCORE SORTING

========================================================================
*/

/*
=============
AddTournamentPlayer

If there are less than two tournament players, put a
spectator in the game and restart
=============
*/
void AddTournamentPlayer( void ) {
	int			i;
	gclient_t	*client;
	gclient_t	*nextInLine;

	if ( level.numPlayingClients >= 2 ) {
		return;
	}

	// never change during intermission
	if ( level.intermissiontime ) {
		return;
	}

	nextInLine = NULL;

	for ( i = 0 ; i < level.maxclients ; i++ ) {
		client = &level.clients[i];
		if ( client->pers.connected != CON_CONNECTED ) {
			continue;
		}
		if ( client->sess.sessionTeam != TEAM_SPECTATOR ) {
			continue;
		}
		// never select the dedicated follow or scoreboard clients
		if ( client->sess.spectatorState == SPECTATOR_SCOREBOARD ||
			client->sess.spectatorClient < 0  ) {
			continue;
		}

		if ( !nextInLine || client->sess.spectatorTime < nextInLine->sess.spectatorTime ) {
			nextInLine = client;
		}
	}

	if ( !nextInLine ) {
		return;
	}

	level.warmupTime = -1;

	// set them to free-for-all team
	SetTeam( &g_entities[ nextInLine - level.clients ], "f" );
}

/*
=======================
RemoveTournamentLoser

Make the loser a spectator at the back of the line
=======================
*/
void RemoveTournamentLoser( void ) {
	int			clientNum;

	if ( level.numPlayingClients != 2 ) {
		return;
	}

	clientNum = level.sortedClients[1];

	if ( level.clients[ clientNum ].pers.connected != CON_CONNECTED ) {
		return;
	}

	// make them a spectator
	SetTeam( &g_entities[ clientNum ], "s" );
}

/*
=======================
RemoveTournamentWinner
=======================
*/
void RemoveTournamentWinner( void ) {
	int			clientNum;

	if ( level.numPlayingClients != 2 ) {
		return;
	}

	clientNum = level.sortedClients[0];

	if ( level.clients[ clientNum ].pers.connected != CON_CONNECTED ) {
		return;
	}

	// make them a spectator
	SetTeam( &g_entities[ clientNum ], "s" );
}

/*
=======================
AdjustTournamentScores
=======================
*/
void AdjustTournamentScores( void ) {
	int			clientNum;

	clientNum = level.sortedClients[0];
	if ( level.clients[ clientNum ].pers.connected == CON_CONNECTED ) {
		level.clients[ clientNum ].sess.wins++;
		ClientUserinfoChanged( clientNum );
	}

	clientNum = level.sortedClients[1];
	if ( level.clients[ clientNum ].pers.connected == CON_CONNECTED ) {
		level.clients[ clientNum ].sess.losses++;
		ClientUserinfoChanged( clientNum );
	}

}

/*
=============
SortRanks

=============
*/
int QDECL SortRanks( const void *a, const void *b ) {
	gclient_t	*ca, *cb;

	ca = &level.clients[*(int *)a];
	cb = &level.clients[*(int *)b];

	// sort special clients last
	if ( ca->sess.spectatorState == SPECTATOR_SCOREBOARD || ca->sess.spectatorClient < 0 ) {
		return 1;
	}
	if ( cb->sess.spectatorState == SPECTATOR_SCOREBOARD || cb->sess.spectatorClient < 0  ) {
		return -1;
	}

	// then connecting clients
	if ( ca->pers.connected == CON_CONNECTING ) {
		return 1;
	}
	if ( cb->pers.connected == CON_CONNECTING ) {
		return -1;
	}


	// then spectators
	if ( ca->sess.sessionTeam == TEAM_SPECTATOR && cb->sess.sessionTeam == TEAM_SPECTATOR ) {
		if ( ca->sess.spectatorTime < cb->sess.spectatorTime ) {
			return -1;
		}
		if ( ca->sess.spectatorTime > cb->sess.spectatorTime ) {
			return 1;
		}
		return 0;
	}
	if ( ca->sess.sessionTeam == TEAM_SPECTATOR ) {
		return 1;
	}
	if ( cb->sess.sessionTeam == TEAM_SPECTATOR ) {
		return -1;
	}

	// JUHOX: take 'killed'-counter into account for team games
	if (g_gametype.integer >= GT_TEAM) {
		int sortScoreA, sortScoreB;

		sortScoreA = ca->ps.persistant[PERS_SCORE] - ca->ps.persistant[PERS_KILLED];
		sortScoreB = cb->ps.persistant[PERS_SCORE] - cb->ps.persistant[PERS_KILLED];
		if (sortScoreA > sortScoreB) return -1;
		if (sortScoreA < sortScoreB) return 1;
	}

	// then sort by score
	if ( ca->ps.persistant[PERS_SCORE]
		> cb->ps.persistant[PERS_SCORE] ) {
		return -1;
	}
	if ( ca->ps.persistant[PERS_SCORE]
		< cb->ps.persistant[PERS_SCORE] ) {
		return 1;
	}
	// JUHOX: take 'killed'-counter into account for non-team games
	// NOTE: 'ca' and 'cb' have equal score
	if (g_gametype.integer < GT_TEAM) {
		int sortScoreA, sortScoreB;

		sortScoreA = ca->ps.persistant[PERS_KILLED];
		sortScoreB = cb->ps.persistant[PERS_KILLED];
		if (sortScoreA < sortScoreB) return -1;
		if (sortScoreA > sortScoreB) return 1;
	}

	return 0;
}

/*
============
CalculateRanks

Recalculates the score ranks of all players
This will be called on every client connect, begin, disconnect, death,
and team change.
============
*/
void CalculateRanks( void ) {
	int		i;
	int		rank;
	int		score;
	int		newScore;
	gclient_t	*cl;

	level.follow1 = -1;
	level.follow2 = -1;
	level.numConnectedClients = 0;
	level.numNonSpectatorClients = 0;
	level.numPlayingClients = 0;
	level.numVotingClients = 0;		// don't count bots
	for ( i = 0; i < TEAM_NUM_TEAMS; i++ ) {
		level.numteamVotingClients[i] = 0;
	}
	for ( i = 0 ; i < level.maxclients ; i++ ) {
		if ( level.clients[i].pers.connected != CON_DISCONNECTED ) {
			level.sortedClients[level.numConnectedClients] = i;
			level.numConnectedClients++;

			if ( level.clients[i].sess.sessionTeam != TEAM_SPECTATOR ) {
				level.numNonSpectatorClients++;

				// decide if this should be auto-followed
				if ( level.clients[i].pers.connected == CON_CONNECTED ) {
					level.numPlayingClients++;
					if ( !(g_entities[i].r.svFlags & SVF_BOT) ) {
						level.numVotingClients++;
						if ( level.clients[i].sess.sessionTeam == TEAM_RED )
							level.numteamVotingClients[0]++;
						else if ( level.clients[i].sess.sessionTeam == TEAM_BLUE )
							level.numteamVotingClients[1]++;
					}
					if ( level.follow1 == -1 ) {
						level.follow1 = i;
					} else if ( level.follow2 == -1 ) {
						level.follow2 = i;
					}
				}
			}
		}
	}

	qsort( level.sortedClients, level.numConnectedClients,
		sizeof(level.sortedClients[0]), SortRanks );

	// set the rank value for all clients that are connected and not spectators
	if ( g_gametype.integer >= GT_TEAM ) {
		// in team games, rank is just the order of the teams, 0=red, 1=blue, 2=tied
		for ( i = 0;  i < level.numConnectedClients; i++ ) {
			cl = &level.clients[ level.sortedClients[i] ];
			if ( level.teamScores[TEAM_RED] == level.teamScores[TEAM_BLUE] ) {
				cl->ps.persistant[PERS_RANK] = 2;
			} else if ( level.teamScores[TEAM_RED] > level.teamScores[TEAM_BLUE] ) {
				cl->ps.persistant[PERS_RANK] = 0;
			} else {
				cl->ps.persistant[PERS_RANK] = 1;
			}
		}
	} else {
		rank = -1;
		score = 0;
		for ( i = 0;  i < level.numPlayingClients; i++ ) {
			cl = &level.clients[ level.sortedClients[i] ];
			newScore = cl->ps.persistant[PERS_SCORE];
			if ( i == 0 || newScore != score ) {
				rank = i;
				// assume we aren't tied until the next client is checked
				level.clients[ level.sortedClients[i] ].ps.persistant[PERS_RANK] = rank;
			} else {
				// we are tied with the previous client
				level.clients[ level.sortedClients[i-1] ].ps.persistant[PERS_RANK] = rank | RANK_TIED_FLAG;
				level.clients[ level.sortedClients[i] ].ps.persistant[PERS_RANK] = rank | RANK_TIED_FLAG;
			}
			score = newScore;
			if ( g_gametype.integer == GT_SINGLE_PLAYER && level.numPlayingClients == 1 ) {
				level.clients[ level.sortedClients[i] ].ps.persistant[PERS_RANK] = rank | RANK_TIED_FLAG;
			}
		}
	}

	// set the CS_SCORES1/2 configstrings, which will be visible to everyone
	if ( g_gametype.integer >= GT_TEAM ) {
		trap_SetConfigstring( CS_SCORES1, va("%i", level.teamScores[TEAM_RED] ) );
		trap_SetConfigstring( CS_SCORES2, va("%i", level.teamScores[TEAM_BLUE] ) );
	} else {
		if ( level.numConnectedClients == 0 ) {
			trap_SetConfigstring( CS_SCORES1, va("%i", SCORE_NOT_PRESENT) );
			trap_SetConfigstring( CS_SCORES2, va("%i", SCORE_NOT_PRESENT) );
		} else if ( level.numConnectedClients == 1 ) {
			trap_SetConfigstring( CS_SCORES1, va("%i", level.clients[ level.sortedClients[0] ].ps.persistant[PERS_SCORE] ) );
			trap_SetConfigstring( CS_SCORES2, va("%i", SCORE_NOT_PRESENT) );
		} else {
			trap_SetConfigstring( CS_SCORES1, va("%i", level.clients[ level.sortedClients[0] ].ps.persistant[PERS_SCORE] ) );
			trap_SetConfigstring( CS_SCORES2, va("%i", level.clients[ level.sortedClients[1] ].ps.persistant[PERS_SCORE] ) );
		}
	}

	// see if it is time to end the level
	CheckExitRules();

	// if we are at the intermission, send the new info to everyone
	if ( level.intermissiontime ) {
		SendScoreboardMessageToAllClients();
	}
}


/*
========================================================================

MAP CHANGING

========================================================================
*/

/*
========================
SendScoreboardMessageToAllClients

Do this at BeginIntermission time and whenever ranks are recalculated
due to enters/exits/forced team changes
========================
*/
void SendScoreboardMessageToAllClients( void ) {
	int		i;

	for ( i = 0 ; i < level.maxclients ; i++ ) {
		if ( level.clients[ i ].pers.connected == CON_CONNECTED ) {
			DeathmatchScoreboardMessage( g_entities + i );
		}
	}
}

/*
========================
MoveClientToIntermission

When the intermission starts, this will be called for all players.
If a new client connects, this will be called after the spawn function.
========================
*/
void MoveClientToIntermission( gentity_t *ent ) {
	// take out of follow mode if needed
	if ( ent->client->sess.spectatorState == SPECTATOR_FOLLOW ) {
		StopFollowing( ent );
	}


	// move to the spot
	VectorCopy( level.intermission_origin, ent->s.origin );
	VectorCopy( level.intermission_origin, ent->client->ps.origin );
	VectorCopy (level.intermission_angle, ent->client->ps.viewangles);
	ent->client->ps.pm_type = PM_INTERMISSION;

	// clean up powerup info
	memset( ent->client->ps.powerups, 0, sizeof(ent->client->ps.powerups) );

	ent->client->ps.eFlags = 0;
	ent->s.eFlags = 0;
	ent->s.eType = ET_GENERAL;
	ent->s.modelindex = 0;
	ent->s.loopSound = 0;
	ent->s.event = 0;
	ent->r.contents = 0;
}

/*
==================
FindIntermissionPoint

This is also used for spectator spawns
==================
*/
void FindIntermissionPoint( void ) {
	gentity_t	*ent, *target;
	vec3_t		dir;

	// find the intermission spot
	ent = G_Find (NULL, FOFS(classname), "info_player_intermission");
	// JUHOX: in EFH don't use intermission spot if we didn't reach the goal
	if (
		g_gametype.integer == GT_EFH &&
		(
			level.efhGoalDistance <= 0 ||
			level.efhCoveredDistance < level.efhGoalDistance
		)
	) {
		ent = NULL;
	}

	if ( !ent ) {	// the map creator forgot to put in an intermission point...
		SelectSpawnPoint ( vec3_origin, level.intermission_origin, level.intermission_angle );
	} else {
		VectorCopy (ent->s.origin, level.intermission_origin);
		VectorCopy (ent->s.angles, level.intermission_angle);
		// if it has a target, look towards it
		if ( ent->target ) {

			target = G_PickTarget(ent->target, ent->worldSegment - 1);

			if ( target ) {
				VectorSubtract( target->s.origin, level.intermission_origin, dir );
				vectoangles( dir, level.intermission_angle );
			}
		}
	}

}

/*
==================
JUHOX: DoCvarSettingsMatchTemplate
==================
*/
static qboolean DoCvarSettingsMatchTemplate(const gametemplate_t* gt) {
	hiscoreRejectionReason = "g_gametype";
	if (g_gametype.integer != gt->gametype) return qfalse;

	hiscoreRejectionReason = "map";
	if (gt->mapName[0] && Q_stricmp(g_mapName.string, gt->mapName)) return qfalse;

	hiscoreRejectionReason = "sv_maxclients";
	if (gt->tksMinplayers == TKS_fixedValue && g_maxclients.integer < gt->minplayers) return qfalse;

	hiscoreRejectionReason = "g_gameSeed";
	if (gt->tksGameseed == TKS_fixedValue && g_gameSeed.integer != gt->gameseed) return qfalse;

	hiscoreRejectionReason = "fraglimit";
	if (gt->tksFraglimit == TKS_fixedValue && g_fraglimit.integer != gt->fraglimit) return qfalse;

	hiscoreRejectionReason = "timelimit";
	if (gt->tksTimelimit == TKS_fixedValue && g_timelimit.integer != gt->timelimit) return qfalse;

	hiscoreRejectionReason = "g_artefacts";
	if (gt->tksArtefacts == TKS_fixedValue && g_artefacts.integer != gt->artefacts) return qfalse;

	hiscoreRejectionReason = "g_monsterLauncher";
	if (gt->tksMonsterlauncher == TKS_fixedValue && g_monsterLauncher.integer != gt->monsterLauncher) return qfalse;

	hiscoreRejectionReason = "g_minMonsters";
	if (gt->tksMinmonsters == TKS_fixedValue && g_minMonsters.integer != gt->minmonsters) return qfalse;

	hiscoreRejectionReason = "g_maxMonsters";
	if (gt->tksMaxmonsters == TKS_fixedValue && g_maxMonsters.integer != gt->maxmonsters) return qfalse;

	hiscoreRejectionReason = "g_monstersPerTrap";
	if (gt->tksMonsterspertrap == TKS_fixedValue && g_monstersPerTrap.integer != gt->monsterspertrap) return qfalse;

	hiscoreRejectionReason = "g_monsterSpawnDelay";
	if (gt->tksMonsterspawndelay == TKS_fixedValue && g_monsterSpawnDelay.integer != gt->monsterspawndelay) return qfalse;

	hiscoreRejectionReason = "g_monsterHealthScale";
	if (gt->tksMonsterhealthscale == TKS_fixedValue && g_monsterHealthScale.integer != gt->monsterhealthscale) return qfalse;

	hiscoreRejectionReason = "g_monsterProgression";
	if (gt->tksMonsterprogessivehealth == TKS_fixedValue && g_monsterProgression.integer < gt->monsterprogressivehealth) return qfalse;

	hiscoreRejectionReason = "g_monsterGuards";
	if (gt->tksGuards == TKS_fixedValue && g_monsterGuards.integer != gt->guards) return qfalse;

	hiscoreRejectionReason = "g_monsterBreeding";
	if (gt->tksMonsterbreeding == TKS_fixedValue && g_monsterBreeding.integer != gt->monsterbreeding) return qfalse;

	hiscoreRejectionReason = "g_monsterLoad";
	if (gt->tksMonsterload == TKS_fixedValue && g_monsterLoad.integer != gt->monsterLoad) return qfalse;

	hiscoreRejectionReason = "distancelimit";
	if (gt->tksDistancelimit == TKS_fixedValue && g_distanceLimit.integer != gt->distancelimit) return qfalse;

	hiscoreRejectionReason = "g_challengingEnv";
	if (gt->tksChallengingEnv == TKS_fixedValue && g_challengingEnv.integer != gt->challengingEnv) return qfalse;

	hiscoreRejectionReason = "g_respawnDelay";
	if (gt->tksRespawndelay == TKS_fixedValue && g_respawnDelay.integer != gt->respawndelay) return qfalse;

	hiscoreRejectionReason = "g_baseHealth";
	if (gt->tksBasehealth == TKS_fixedValue && g_baseHealth.integer != gt->basehealth) return qfalse;

	hiscoreRejectionReason = "g_friendlyFire";
	if (gt->tksFriendlyfire == TKS_fixedValue && gt->friendlyfire != g_friendlyFire.integer) return qfalse;

	hiscoreRejectionReason = "g_stamina";
	if (gt->tksStamina == TKS_fixedValue && gt->stamina != g_stamina.integer) return qfalse;

	hiscoreRejectionReason = "g_noItems";
	if (gt->tksNoitems == TKS_fixedValue && gt->noitems != g_noItems.integer) return qfalse;

	hiscoreRejectionReason = "g_noHealthRegen";
	if (gt->tksNohealthregen == TKS_fixedValue && gt->nohealthregen != g_noHealthRegen.integer) return qfalse;

	hiscoreRejectionReason = "g_cloakingDevice";
	if (gt->tksCloakingdevice == TKS_fixedValue && gt->cloakingdevice != g_cloakingDevice.integer) return qfalse;

	hiscoreRejectionReason = "g_unlimitedAmmo";
	if (gt->tksUnlimitedammo == TKS_fixedValue && gt->unlimitedammo != g_unlimitedAmmo.integer) return qfalse;

	hiscoreRejectionReason = "tss";
	if (gt->tksTss == TKS_fixedValue && gt->tss != g_tss.integer) return qfalse;

	hiscoreRejectionReason = "tssSafetyMode";
	if (gt->tksTsssafetymode == TKS_fixedValue && gt->tsssafetymode != g_tssSafetyMode.integer) return qfalse;

	hiscoreRejectionReason = "g_respawnAtPOD";
	if (gt->tksRespawnatpod == TKS_fixedValue && gt->respawnatpod != g_respawnAtPOD.integer) return qfalse;

	hiscoreRejectionReason = "g_armorFragments";
	if (gt->tksArmorfragments == TKS_fixedValue && gt->armorfragments != g_armorFragments.integer) return qfalse;

	hiscoreRejectionReason = "g_lightningDamageLimit";
	if (gt->tksLightningdamagelimit == TKS_fixedValue && gt->lightningdamagelimit != g_lightningDamageLimit.integer) return qfalse;

	hiscoreRejectionReason = "g_grapple";
	if (gt->tksGrapple == TKS_fixedValue && gt->grapple != g_grapple.integer) return qfalse;

	hiscoreRejectionReason = "dmflags";
	if (gt->tksDmflags == TKS_fixedValue && gt->dmflags != g_dmflags.integer) return qfalse;

	hiscoreRejectionReason = "g_speed";
	if (gt->tksSpeed == TKS_fixedValue && gt->speed != g_speed.integer) return qfalse;

	hiscoreRejectionReason = "g_knockback";
	if (gt->tksKnockback == TKS_fixedValue && gt->knockback != g_knockback.integer) return qfalse;

	hiscoreRejectionReason = "g_gravity";
	if (gt->tksGravity == TKS_fixedValue && gt->gravity != g_gravity.integer) return qfalse;

	hiscoreRejectionReason = NULL;
	return qtrue;
}

/*
==================
JUHOX: DoesGameMatchTemplate
==================
*/
static qboolean DoesGameMatchTemplate(const gametemplate_t* gt) {
	if (!DoCvarSettingsMatchTemplate(gt)) return qfalse;

	hiscoreRejectionReason = "too few players";
	if (
		gt->tksMinplayers == TKS_fixedValue &&
		level.numPlayingClients < gt->minplayers
	) {
		return qfalse;
	}

	hiscoreRejectionReason = "too many players";
	if (
		gt->tksMaxplayers == TKS_fixedValue &&
		gt->maxplayers > 0 &&
		level.numPlayingClients > gt->maxplayers
	) {
		return qfalse;
	}

	hiscoreRejectionReason = "no players";
	if (level.numPlayingClients <= 0) return qfalse;

	return qtrue;
}

/*
==================
JUHOX: CreateHighscoreDescriptor
==================
*/
static void CreateHighscoreDescriptor(char* msg) {
	int i;
	int size;

	size = 0;
	for (i = 0; i < level.numPlayingClients; i++) {
		int client;
		char info[MAX_INFO_STRING];
		char* name;
		int score;
		char* entry;
		int n;

		client = level.sortedClients[i];
		if (!g_entities[client].inuse) continue;
		if (level.clients[client].pers.connected != CON_CONNECTED) continue;
		trap_GetUserinfo(client, info, sizeof(info));
		if (!Info_Validate(info)) continue;

		name = Info_ValueForKey(info, "name");
		if (!name[0]) continue;

		score = level.clients[client].ps.persistant[PERS_SCORE];

		if (level.numPlayingClients == 1) {
			entry = name;
		}
		else {
			entry = va("%s%s^7 %d", i > 0? " * " : "", name, score);
		}
		n = strlen(entry);
		if (size + n > 1000) return;

		strcpy(msg, entry);
		msg += n;
		size += n;
	}
}

/*
==================
BeginIntermission
==================
*/
void BeginIntermission( void ) {
	int			i;
	gentity_t	*client;

	if ( level.intermissiontime ) {
		return;		// already active
	}

	// JUHOX: check for highscore
	trap_SetConfigstring(CS_HIGHSCORETEXT, "");
	{
		gametemplate_t gt;
		qboolean templated;
		char name[128];
		int time;

		templated = qfalse;
		if (g_template.string[0]) {
			char info[MAX_INFO_STRING];

			trap_Cvar_VariableStringBuffer(g_template.string, info, sizeof(info));
			templated = BG_ParseGameTemplate(info, &gt);
		}

		hiscoreRejectionReason = NULL;
		if ( templated && gt.tksHighscoretype > TKS_missing && DoesGameMatchTemplate(&gt) ) {
			const char* hsname;
			char scoreVarName[64];
			char scoreVarContents[64];
			qboolean newhighscore;

			hsname = HighscoreName(&gt, g_template.string);
			newhighscore = qfalse;
			Com_sprintf(scoreVarName, sizeof(scoreVarName), "%s0", hsname);
			trap_Cvar_VariableStringBuffer(scoreVarName, scoreVarContents, sizeof(scoreVarContents));
			switch (gt.highscoretype) {

			case GC_score:
				if (
					g_gametype.integer >= GT_STU &&
					level.stuScore > atoi(scoreVarContents)
				) {
					newhighscore = qtrue;
					trap_SetConfigstring(CS_HIGHSCORETEXT, "New highscore on this server!");
				}
				break;
			case GC_time:
				if (
					(
						time < atoi(scoreVarContents) ||
						!scoreVarContents[0]
					) &&
					(
						(
							g_gametype.integer == GT_STU &&
							g_artefacts.integer > 0 &&
							g_artefacts.integer < 999 &&
							level.teamScores[TEAM_RED] >= g_artefacts.integer
						)

						|| (
							g_gametype.integer == GT_EFH &&
							level.efhGoalDistance > 0 &&
							level.efhCoveredDistance >= level.efhGoalDistance
						)

					)
				) {
					newhighscore = qtrue;
					trap_SetConfigstring(CS_HIGHSCORETEXT, "New record time on this server!");
				}
				break;

			case GC_distance:
				if (
					g_gametype.integer == GT_EFH &&
					level.efhCoveredDistance > atoi(scoreVarContents)
				) {
					newhighscore = qtrue;
					trap_SetConfigstring(CS_HIGHSCORETEXT, "New record distance on this server!");
				}
				break;
			case GC_speed:
				if (
					g_gametype.integer == GT_EFH &&
					level.efhGoalDistance > 0 &&
					level.efhCoveredDistance >= level.efhGoalDistance &&
					level.efhSpeed > atoi(scoreVarContents)
				) {
					newhighscore = qtrue;
					trap_SetConfigstring(CS_HIGHSCORETEXT, "New record speed on this server!");
				}
				break;

			default:
				break;
			}

			if (newhighscore) {
				char msgVarName[64];
				char msgVarContents[1024];

				switch (gt.highscoretype) {
				case GC_score:
					Com_sprintf(scoreVarContents, sizeof(scoreVarContents), "%d", level.stuScore);
					break;
				case GC_time:
					Com_sprintf(scoreVarContents, sizeof(scoreVarContents), "%d", time);
					break;
				case GC_distance:
					Com_sprintf(scoreVarContents, sizeof(scoreVarContents), "%d", level.efhCoveredDistance);
					break;
				case GC_speed:
					Com_sprintf(scoreVarContents, sizeof(scoreVarContents), "%d", level.efhSpeed);
					break;

				default:
					scoreVarContents[0] = 0;
					break;
				}
				trap_Cvar_Register(NULL, scoreVarName, "", CVAR_ARCHIVE);
				trap_Cvar_Set(scoreVarName, scoreVarContents);

				Com_sprintf(msgVarName, sizeof(msgVarName), "%s1", hsname);
				CreateHighscoreDescriptor(msgVarContents);
				trap_Cvar_Register(NULL, msgVarName, "", CVAR_ARCHIVE);
				trap_Cvar_Set(msgVarName, msgVarContents);
			}
			else {
				G_Printf("no new highscore\n");
			}
		}
		else if (templated) {
			if (gt.tksHighscoretype <= TKS_missing) {
				G_Printf("template doesn't define highscore type\n");
			}
			else if (hiscoreRejectionReason) {
				G_Printf("^3highscore rejected, reason: %s\n", hiscoreRejectionReason);
			}
		}
	}

	// if in tournement mode, change the wins / losses
	if ( g_gametype.integer == GT_TOURNAMENT ) {
		AdjustTournamentScores();
	}

	level.intermissiontime = level.time;
	FindIntermissionPoint();

	// if single player game
	if ( g_gametype.integer == GT_SINGLE_PLAYER ) {
		UpdateTournamentInfo();
		SpawnModelsOnVictoryPads();
	}

	// move all clients to the intermission point
	for (i=0 ; i< level.maxclients ; i++) {
		client = g_entities + i;
		if (!client->inuse)
			continue;
		// respawn if dead
		if (client->health <= 0) {
			respawn(client);
		}
		client->client->pers.lastUsedWeapon = WP_NONE;	// JUHOX
		MoveClientToIntermission( client );
	}

	// send the current scoring to all clients
	SendScoreboardMessageToAllClients();

}


/*
=============
ExitLevel

When the intermission has been exited, the server is either killed
or moved to a new level based on the "nextmap" cvar

=============
*/
void ExitLevel (void) {
	int		i;
	gclient_t *cl;

#if MEETING	// JUHOX: leave meeting
	if (level.meeting) {
		level.meeting = qfalse;
		trap_SetConfigstring(CS_CLIENTS_READY, "");


		level.intermissiontime = 0;	// effects spawn location in EFH
		if (g_gametype.integer == GT_EFH) G_SpawnWorld();


		for (i = 0; i < level.maxclients; i++) {
			if (level.clients[i].pers.connected != CON_CONNECTED) continue;

			ClientBegin(i);

			if (g_gametype.integer == GT_EFH) G_UpdateWorld();

		}

		level.startTime = level.time;
		trap_SetConfigstring(CS_LEVEL_START_TIME, va("%d", level.startTime));
		trap_SetConfigstring(CS_MEETING, "0");
		return;
	}
#endif

	//bot interbreeding
	BotInterbreedEndMatch();

	// if we are running a tournement map, kick the loser to spectator status,
	// which will automatically grab the next spectator and restart
	if ( g_gametype.integer == GT_TOURNAMENT  ) {
		if ( !level.restarted ) {
			RemoveTournamentLoser();
			trap_SendConsoleCommand( EXEC_APPEND, "map_restart 0\n" );
			level.restarted = qtrue;
			level.changemap = NULL;
			level.intermissiontime = 0;
		}
		return;
	}


	trap_SendConsoleCommand( EXEC_APPEND, "vstr nextmap\n" );
	level.changemap = NULL;
	level.intermissiontime = 0;

	// reset all the scores so we don't enter the intermission again
	level.teamScores[TEAM_RED] = 0;
	level.teamScores[TEAM_BLUE] = 0;
	for ( i=0 ; i< g_maxclients.integer ; i++ ) {
		cl = level.clients + i;
		if ( cl->pers.connected != CON_CONNECTED ) {
			continue;
		}
		cl->ps.persistant[PERS_SCORE] = 0;
	}

	// we need to do this here before chaning to CON_CONNECTING
	G_WriteSessionData();

	// change all client states to connecting, so the early players into the
	// next level will know the others aren't done reconnecting
	for (i=0 ; i< g_maxclients.integer ; i++) {
		if ( level.clients[i].pers.connected == CON_CONNECTED ) {
			level.clients[i].pers.connected = CON_CONNECTING;
		}
	}

}

/*
=================
G_LogPrintf

Print to the logfile with a time stamp if it is open
=================
*/
void QDECL G_LogPrintf( const char *fmt, ... ) {
	va_list		argptr;
	char		string[1024];
	int			min, tens, sec;

	sec = level.time / 1000;

	min = sec / 60;
	sec -= min * 60;
	tens = sec / 10;
	sec -= tens * 10;

	Com_sprintf( string, sizeof(string), "%3i:%i%i ", min, tens, sec );

	va_start( argptr, fmt );
	vsprintf( string +7 , fmt,argptr );
	va_end( argptr );

	if ( g_dedicated.integer ) {
		G_Printf( "%s", string + 7 );
	}

	if ( !level.logFile ) {
		return;
	}

	trap_FS_Write( string, strlen( string ), level.logFile );
}

/*
================
LogExit

Append information about this game to the log file
================
*/
void LogExit( const char *string ) {
	int				i, numSorted;
	gclient_t		*cl;

	G_LogPrintf( "Exit: %s\n", string );

	level.intermissionQueued = level.time;

	// this will keep the clients from playing any voice sounds
	// that will get cut off when the queued intermission starts
	trap_SetConfigstring( CS_INTERMISSION, "1" );

	// don't send more than 32 scores (FIXME?)
	numSorted = level.numConnectedClients;
	if ( numSorted > 32 ) {
		numSorted = 32;
	}

	if ( g_gametype.integer >= GT_TEAM ) {
		G_LogPrintf( "red:%i  blue:%i\n",
			level.teamScores[TEAM_RED], level.teamScores[TEAM_BLUE] );
	}

	for (i=0 ; i < numSorted ; i++) {
		int		ping;

		cl = &level.clients[level.sortedClients[i]];

		if ( cl->sess.sessionTeam == TEAM_SPECTATOR ) {
			continue;
		}
		if ( cl->pers.connected == CON_CONNECTING ) {
			continue;
		}

		ping = cl->ps.ping < 999 ? cl->ps.ping : 999;

		G_LogPrintf( "score: %i  ping: %i  client: %i %s\n", cl->ps.persistant[PERS_SCORE], ping, level.sortedClients[i],	cl->pers.netname );
	}


	// JUHOX: in STU set the CS_TIME_PLAYED config string
	if (g_gametype.integer >= GT_STU) {
		int minutes, seconds, mseconds;
		char* s;

		mseconds = level.endTime - level.startTime;
		seconds = mseconds / 1000;
		minutes = seconds / 60;
		s = va("%d:%02d.%03d", minutes, seconds % 60, mseconds % 1000);
		trap_SetConfigstring(CS_TIME_PLAYED, s);
		G_LogPrintf("time played: %s\n", s);
	}


	// JUHOX: set CS_EFH_SPEED config string
	if (g_gametype.integer == GT_EFH) {
		float minutes;
		int metres;
		float speed;

		minutes = (level.endTime - level.startTime) / 60000.0;
		metres = level.efhCoveredDistance;
		if (
			level.efhGoalDistance > 0 &&
			metres > level.efhGoalDistance
		) {
			metres = level.efhGoalDistance;
		}

		if (minutes > 0) {
			speed = metres / minutes;
		}
		else {
			speed = 0;
		}
		level.efhSpeed = (int) floor(1000 * speed + 0.5);

		trap_SetConfigstring(CS_EFH_SPEED, va("%d.%03d", level.efhSpeed / 1000, level.efhSpeed % 1000));
	}
}


/*
=================
CheckIntermissionExit

The level will stay at the intermission for a minimum of 5 seconds
If all players wish to continue, the level will then exit.
If one or more players have not acknowledged the continue, the game will
wait 10 seconds before going on.
=================
*/
void CheckIntermissionExit( void ) {
	int			ready, notReady;
	int			i;
	gclient_t	*cl;
	int			readyMask;

	if ( g_gametype.integer == GT_SINGLE_PLAYER ) {
		return;
	}

	// see which players are ready
	ready = 0;
	notReady = 0;
	readyMask = 0;
	for (i=0 ; i< g_maxclients.integer ; i++) {
		cl = level.clients + i;
#if MEETING	// JUHOX: don't leave meeting while someone is connecting
		if (level.meeting && cl->pers.connected == CON_CONNECTING) {
			level.readyToExit = qfalse;
			return;
		}
#endif
		if ( cl->pers.connected != CON_CONNECTED ) {
			continue;
		}
		if ( g_entities[cl->ps.clientNum].r.svFlags & SVF_BOT ) {
			continue;
		}

		if ( cl->readyToExit ) {
			ready++;
			if ( i < 16 ) {
				readyMask |= 1 << i;
			}
		} else {
			notReady++;
		}
	}

	// copy the readyMask to each player's stats so
	// it can be displayed on the scoreboard
	// JUHOX: put ready mask in configstring
#if 0
	for (i=0 ; i< g_maxclients.integer ; i++) {
		cl = level.clients + i;
		if ( cl->pers.connected != CON_CONNECTED ) {
			continue;
		}
		cl->ps.stats[STAT_CLIENTS_READY] = readyMask;
	}
#else
	{
		char buf[32];

		memset(buf, 0, sizeof(buf));
		for (i = 0; i < g_maxclients.integer; i++) {
			cl = level.clients + i;
			if ( cl->pers.connected != CON_CONNECTED ) {
				continue;
			}
			if ( g_entities[cl->ps.clientNum].r.svFlags & SVF_BOT ) {
				continue;
			}

			if (cl->readyToExit) buf[i/4] |= 1 << (i & 3);
		}
		for (i = 0; i < MAX_CLIENTS/4; i++) {
			buf[i] += 'A';
		}
		trap_SetConfigstring(CS_CLIENTS_READY, buf);
	}
#endif

#if MEETING	// JUHOX: in meeting mode exit intermission, if there's nobody left (so people can connect)
	if (g_meeting.integer && !level.meeting && ready <= 0 && notReady <= 0) {
		ExitLevel();
		return;
	}
#endif

	// never exit in less than five seconds
	if ( level.time < level.intermissiontime + 5000 ) {
		return;
	}

	// if nobody wants to go, clear timer
	// JUHOX: if too few people want to go, clear timer
#if 0
	if ( !ready ) {
#else
	if (ready <= notReady) {
#endif
		level.readyToExit = qfalse;
		return;
	}

	// if everyone wants to go, go now
	if ( !notReady ) {
		ExitLevel();
		return;
	}

	// the first person to ready starts the ten second timeout
	if ( !level.readyToExit ) {
		level.readyToExit = qtrue;
		level.exitTime = level.time;
	}

	// if we have waited ten seconds since at least one player
	// wanted to exit, go ahead
	if ( level.time < level.exitTime + 10000 ) {
		return;
	}

	ExitLevel();
}

/*
=============
ScoreIsTied
=============
*/
qboolean ScoreIsTied( void ) {
	int		a, b;

	// JUHOX: score is never tied in STU
	if (g_gametype.integer >= GT_STU) {
		return qfalse;
	}

	if ( level.numPlayingClients < 2 ) {
		return qfalse;
	}

	if ( g_gametype.integer >= GT_TEAM ) {
		return level.teamScores[TEAM_RED] == level.teamScores[TEAM_BLUE];
	}

	a = level.clients[level.sortedClients[0]].ps.persistant[PERS_SCORE];
	b = level.clients[level.sortedClients[1]].ps.persistant[PERS_SCORE];

	return a == b;
}

/*
=================
CheckExitRules

There will be a delay between the time the exit is qualified for
and the time everyone is moved to the intermission spot, so you
can see the last frag.
=================
*/
void CheckExitRules( void ) {
 	int			i;
	gclient_t	*cl;
	// if at the intermission, wait for all non-bots to
	// signal ready, then go to next level
	if ( level.intermissiontime ) {
		CheckIntermissionExit ();
		return;
	}

#if MEETING	// JUHOX: during intermission wait for the players to signal ready
	if (level.meeting) {
		CheckIntermissionExit();
		return;
	}
#endif

	if ( level.intermissionQueued ) {
		if ( level.time - level.intermissionQueued >= INTERMISSION_DELAY_TIME ) {
			level.intermissionQueued = 0;
			BeginIntermission();
		}
		return;
	}

	// JUHOX: check STU exit rules
	if (g_gametype.integer == GT_STU) {
		if (
			g_artefacts.integer > 0 &&
			g_artefacts.integer < 999 &&
			level.teamScores[TEAM_RED] >= g_artefacts.integer
		) {
			switch (level.endPhase) {
			case 0:
				level.endTime = level.time;
				level.endPhase = 1;
				level.endPhaseEnteredTime = level.time;
				if (g_skipEndSequence.integer) level.endPhase = 5;
				break;
			case 1:
				if (level.time < level.endTime + 5000) break;
				{
					gentity_t* te;

					te = G_TempEntity(vec3_origin, EV_DISCHARGE_FLASH);
					if (te) {
						te->s.otherEntityNum = ENTITYNUM_NONE;
						te->r.svFlags |= SVF_BROADCAST;
					}
				}
				level.endPhase = 2;
				level.endPhaseEnteredTime = level.time;
				break;
			case 2:
				if (level.time < level.endTime + 8000) break;
				level.endPhase = 3;
				level.endPhaseEnteredTime = level.time;
				break;
			case 3:
				G_ChargeMonsters(level.time - level.previousTime, 3000);
				if (
					level.time < level.endTime + 25000 ||
					(
						G_NumMonsters() > 0 &&
						level.time < level.endTime + 35000
					)
				) {
					break;
				}
				level.endPhase = 4;
				level.endPhaseEnteredTime = level.time;
				break;
			case 4:
				if (level.time < level.endPhaseEnteredTime + 4000) break;
				level.endPhase = 5;
				level.endPhaseEnteredTime = level.time;
				break;
			case 5:
			default:
				trap_SendServerCommand( -1, "print \"The Universe has been saved!\n\"");
				LogExit("All artefacts collected.");
				break;
			}
			return;
		}
		if (
			g_fraglimit.integer > 0 &&
			level.teamScores[TEAM_BLUE] >= g_fraglimit.integer
		) {
			level.endTime = level.time;
			trap_SendServerCommand(-1, "print \"Monsters hit the fraglimit.\n\"");
			LogExit("Fraglimit hit.");
			return;
		}
		if (level.overkilled) {
			level.endTime = level.time;
			trap_SendServerCommand( -1, "print \"Monsters killed all hunters.\n\"");
			LogExit("Overkill.");
			return;
		}
		if (g_timelimit.integer && !level.warmupTime) {
			if (level.time - level.startTime >= g_timelimit.integer*60000) {
				level.endTime = level.time;
				trap_SendServerCommand( -1, "print \"Timelimit hit.\n\"");
				LogExit("Timelimit hit.");
				return;
			}
		}
		// do not apply other game types's exit rules
		return;
	}

    // JUHOX: check EFH exit rules
	if (g_gametype.integer == GT_EFH) {
		if (
			level.efhGoalDistance > 0 &&
			level.efhCoveredDistance >= level.efhGoalDistance &&
			!g_debugEFH.integer
		) {
			level.endTime = level.time;
			trap_SendServerCommand(-1, "print \"Goal reached.\n\"");
			LogExit("Goal reached.");
			return;
		}
		if (
			g_fraglimit.integer > 0 &&
			level.teamScores[TEAM_BLUE] >= g_fraglimit.integer &&
			!g_debugEFH.integer
		) {
			level.endTime = level.time;
			trap_SendServerCommand(-1, "print \"Monsters hit the fraglimit.\n\"");
			LogExit("Fraglimit hit.");
			return;
		}
		if (
			g_timelimit.integer > 0 &&
			!level.warmupTime &&
			!g_debugEFH.integer
		) {
			int time;

			time = level.time - level.startTime;
			if (level.efhGoalDistance > 0) {
				time -= (60000 * (level.efhGoalDistance - g_distanceLimit.integer) * g_timelimit.integer) / g_distanceLimit.integer;
			}

			if (time >= g_timelimit.integer*60000) {
				level.endTime = level.time;
				trap_SendServerCommand( -1, "print \"Timelimit hit.\n\"");
				LogExit("Timelimit hit.");
				return;
			}
		}
		// do not apply other game types's exit rules
		return;
	}


	// check for sudden death
	if ( ScoreIsTied() ) {
		// always wait for sudden death
		return;
	}

	if ( g_timelimit.integer && !level.warmupTime ) {
		if ( level.time - level.startTime >= g_timelimit.integer*60000 ) {
			trap_SendServerCommand( -1, "print \"Timelimit hit.\n\"");
			LogExit( "Timelimit hit." );
			return;
		}
	}

	if ( g_gametype.integer < GT_CTF && g_fraglimit.integer ) {
		if ( level.teamScores[TEAM_RED] >= g_fraglimit.integer ) {
			trap_SendServerCommand( -1, "print \"Red hit the fraglimit.\n\"" );
			LogExit( "Fraglimit hit." );
			return;
		}

		if ( level.teamScores[TEAM_BLUE] >= g_fraglimit.integer ) {
			trap_SendServerCommand( -1, "print \"Blue hit the fraglimit.\n\"" );
			LogExit( "Fraglimit hit." );
			return;
		}

		for ( i=0 ; i< g_maxclients.integer ; i++ ) {
			cl = level.clients + i;
			if ( cl->pers.connected != CON_CONNECTED ) {
				continue;
			}
			if ( cl->sess.sessionTeam != TEAM_FREE ) {
				continue;
			}

			if ( cl->ps.persistant[PERS_SCORE] >= g_fraglimit.integer ) {
				LogExit( "Fraglimit hit." );
				trap_SendServerCommand( -1, va("print \"%s" S_COLOR_WHITE " hit the fraglimit.\n\"",
					cl->pers.netname ) );
				return;
			}
		}
	}

	if ( g_gametype.integer >= GT_CTF && g_capturelimit.integer ) {

		if ( level.teamScores[TEAM_RED] >= g_capturelimit.integer ) {
			trap_SendServerCommand( -1, "print \"Red hit the capturelimit.\n\"" );
			LogExit( "Capturelimit hit." );
			return;
		}

		if ( level.teamScores[TEAM_BLUE] >= g_capturelimit.integer ) {
			trap_SendServerCommand( -1, "print \"Blue hit the capturelimit.\n\"" );
			LogExit( "Capturelimit hit." );
			return;
		}
	}
}



/*
========================================================================

FUNCTIONS CALLED EVERY FRAME

========================================================================
*/


/*
=============
CheckTournament

Once a frame, check for changes in tournement player state
=============
*/
void CheckTournament( void ) {
	// check because we run 3 game frames before calling Connect and/or ClientBegin
	// for clients on a map_restart
	if ( level.numPlayingClients == 0 ) {
		return;
	}

	if ( g_gametype.integer == GT_TOURNAMENT ) {

		// pull in a spectator if needed
		if ( level.numPlayingClients < 2 ) {
			AddTournamentPlayer();
		}

		// if we don't have two players, go back to "waiting for players"
		if ( level.numPlayingClients != 2 ) {
			if ( level.warmupTime != -1 ) {
				level.warmupTime = -1;
				trap_SetConfigstring( CS_WARMUP, va("%i", level.warmupTime) );
				G_LogPrintf( "Warmup:\n" );
			}
			return;
		}

		if ( level.warmupTime == 0 ) {
			return;
		}

		// if the warmup is changed at the console, restart it
		if ( g_warmup.modificationCount != level.warmupModificationCount ) {
			level.warmupModificationCount = g_warmup.modificationCount;
			level.warmupTime = -1;
		}

		// if all players have arrived, start the countdown
		if ( level.warmupTime < 0 ) {
			if ( level.numPlayingClients == 2 ) {
				// fudge by -1 to account for extra delays
				level.warmupTime = level.time + ( g_warmup.integer - 1 ) * 1000;
				trap_SetConfigstring( CS_WARMUP, va("%i", level.warmupTime) );
			}
			return;
		}

		// if the warmup time has counted down, restart
		if ( level.time > level.warmupTime ) {
			level.warmupTime += 10000;
			trap_Cvar_Set( "g_restarted", "1" );
			trap_SendConsoleCommand( EXEC_APPEND, "map_restart 0\n" );
			level.restarted = qtrue;
			return;
		}
	} else if ( g_gametype.integer != GT_SINGLE_PLAYER && level.warmupTime != 0 ) {
		int		counts[TEAM_NUM_TEAMS];
		qboolean	notEnough = qfalse;

		if ( g_gametype.integer > GT_TEAM ) {
			counts[TEAM_BLUE] = TeamCount( -1, TEAM_BLUE );
			counts[TEAM_RED] = TeamCount( -1, TEAM_RED );

			if (counts[TEAM_RED] < 1 || counts[TEAM_BLUE] < 1) {
				notEnough = qtrue;
			}
		} else if ( level.numPlayingClients < 2 ) {
			notEnough = qtrue;
		}

		// JUHOX: warmup waiting condition for STU
		if (g_gametype.integer >= GT_STU) {
			notEnough = (level.numPlayingClients < 1);
		}

		if ( notEnough ) {
			if ( level.warmupTime != -1 ) {
				level.warmupTime = -1;
				trap_SetConfigstring( CS_WARMUP, va("%i", level.warmupTime) );
				G_LogPrintf( "Warmup:\n" );
			}
			return; // still waiting for team members
		}

		if ( level.warmupTime == 0 ) {
			return;
		}

		// if the warmup is changed at the console, restart it
		if ( g_warmup.modificationCount != level.warmupModificationCount ) {
			level.warmupModificationCount = g_warmup.modificationCount;
			level.warmupTime = -1;
		}

		// if all players have arrived, start the countdown
		if ( level.warmupTime < 0 ) {
			// fudge by -1 to account for extra delays
			level.warmupTime = level.time + ( g_warmup.integer - 1 ) * 1000;
			trap_SetConfigstring( CS_WARMUP, va("%i", level.warmupTime) );
			return;
		}

		// if the warmup time has counted down, restart
		if ( level.time > level.warmupTime ) {
			level.warmupTime += 10000;
			trap_Cvar_Set( "g_restarted", "1" );
			trap_SendConsoleCommand( EXEC_APPEND, "map_restart 0\n" );
			level.restarted = qtrue;
			return;
		}
	}
}


/*
==================
CheckVote
==================
*/
void CheckVote( void ) {
	if ( level.voteExecuteTime && level.voteExecuteTime < level.time ) {
		level.voteExecuteTime = 0;
		trap_SendConsoleCommand( EXEC_APPEND, va("%s\n", level.voteString ) );
	}
	if ( !level.voteTime ) {
		return;
	}
	if ( level.time - level.voteTime >= VOTE_TIME ) {
		trap_SendServerCommand( -1, "print \"Vote failed.\n\"" );
	} else {
		// ATVI Q3 1.32 Patch #9, WNF
		if ( level.voteYes > level.numVotingClients/2 ) {
			// execute the command, then remove the vote
			trap_SendServerCommand( -1, "print \"Vote passed.\n\"" );
			level.voteExecuteTime = level.time + 3000;
		} else if ( level.voteNo >= level.numVotingClients/2 ) {
			// same behavior as a timeout
			trap_SendServerCommand( -1, "print \"Vote failed.\n\"" );
		} else {
			// still waiting for a majority
			return;
		}
	}
	level.voteTime = 0;
	trap_SetConfigstring( CS_VOTE_TIME, "" );

}

/*
==================
PrintTeam
==================
*/
void PrintTeam(int team, char *message) {
	int i;

	for ( i = 0 ; i < level.maxclients ; i++ ) {
		if (level.clients[i].sess.sessionTeam != team)
			continue;
		trap_SendServerCommand( i, message );
	}
}

/*
==================
SetLeader
==================
*/
void SetLeader(int team, int client) {
	int i;

	if ( level.clients[client].pers.connected == CON_DISCONNECTED ) {
		PrintTeam(team, va("print \"%s is not connected\n\"", level.clients[client].pers.netname) );
		return;
	}
	if (level.clients[client].sess.sessionTeam != team) {
		PrintTeam(team, va("print \"%s is not on the team anymore\n\"", level.clients[client].pers.netname) );
		return;
	}
	for ( i = 0 ; i < level.maxclients ; i++ ) {
		if (level.clients[i].sess.sessionTeam != team)
			continue;
		if (level.clients[i].sess.teamLeader) {
			level.clients[i].sess.teamLeader = qfalse;
			if (level.clients[i].tssSafetyMode) respawn(&g_entities[i]);	// JUHOX
			ClientUserinfoChanged(i);
		}
	}
	level.clients[client].sess.teamLeader = qtrue;
	ClientUserinfoChanged( client );
	PrintTeam(team, va("print \"%s is the new team leader\n\"", level.clients[client].pers.netname) );
}

/*
==================
CheckTeamLeader
==================
*/
void CheckTeamLeader( int team ) {
	int i;

	for ( i = 0 ; i < level.maxclients ; i++ ) {
		if (level.clients[i].sess.sessionTeam != team)
			continue;
		if (level.clients[i].sess.teamLeader)
			break;
	}
	if (i >= level.maxclients) {
		for ( i = 0 ; i < level.maxclients ; i++ ) {
			if (level.clients[i].sess.sessionTeam != team)
				continue;
			if (!(g_entities[i].r.svFlags & SVF_BOT)) {
				level.clients[i].sess.teamLeader = qtrue;
				/*break;*/return;	// JUHOX BUGFIX
			}
		}
		for ( i = 0 ; i < level.maxclients ; i++ ) {
			if (level.clients[i].sess.sessionTeam != team)
				continue;
			level.clients[i].sess.teamLeader = qtrue;
			break;
		}
	}
}

/*
==================
CheckTeamVote
==================
*/
void CheckTeamVote( int team ) {
	int cs_offset;

	if ( team == TEAM_RED )
		cs_offset = 0;
	else if ( team == TEAM_BLUE )
		cs_offset = 1;
	else
		return;

	if ( !level.teamVoteTime[cs_offset] ) {
		return;
	}
	if ( level.time - level.teamVoteTime[cs_offset] >= VOTE_TIME ) {
		trap_SendServerCommand( -1, "print \"Team vote failed.\n\"" );
	} else {
		if ( level.teamVoteYes[cs_offset] > level.numteamVotingClients[cs_offset]/2 ) {
			// execute the command, then remove the vote
			trap_SendServerCommand( -1, "print \"Team vote passed.\n\"" );
			//
			if ( !Q_strncmp( "leader", level.teamVoteString[cs_offset], 6) ) {
				//set the team leader
				SetLeader(team, atoi(level.teamVoteString[cs_offset] + 7));
			}
            // JUHOX: execute surrendering
			else if (!Q_strncmp("surrender", level.teamVoteString[cs_offset], 9)) {
				level.teamScores[team==TEAM_RED? TEAM_BLUE : TEAM_RED] += g_gametype.integer == GT_CTF? 2 : 5;
				CalculateRanks();
				DoOverkill(NULL, team, ENTITYNUM_NONE);
			}

			else {
				trap_SendConsoleCommand( EXEC_APPEND, va("%s\n", level.teamVoteString[cs_offset] ) );
			}
		} else if ( level.teamVoteNo[cs_offset] >= level.numteamVotingClients[cs_offset]/2 ) {
			// same behavior as a timeout
			trap_SendServerCommand( -1, "print \"Team vote failed.\n\"" );
		} else {
			// still waiting for a majority
			return;
		}
	}
	level.teamVoteTime[cs_offset] = 0;
	trap_SetConfigstring( CS_TEAMVOTE_TIME + cs_offset, "" );

}


/*
==================
JUHOX: CheckGamesettings
==================
*/
static void CheckGamesettings(void) {
	static int lastGametypeMod = -1;
	static int lastMapnameMod = -1;
	static int lastBasehealthMod = -1;
	static int lastDmflagsMod = -1;
	static int lastFraglimitMod = -1;
	static int lastCapturelimitMod = -1;
	static int lastTimelimitMod = -1;
	static int lastArtefactsMod = -1;
	static int lastRespawndelayMod = -1;
	static int lastGameseedMod = -1;
	static int lastFriendlyFireMod = -1;
	static int lastStaminaMod = -1;
	static int lastNoItemsMod = -1;
	static int lastNoHealthRegenMod = -1;
	static int lastCloakingDeviceMod = -1;
	static int lastUnlimitedAmmoMod = -1;
	static int lastArmorFragmentsMod = -1;
	static int lastLightningLimitMod = -1;
	static int lastGrappleMod = -1;
	static int lastMonsterLauncherMod = -1;
	static int lastMinMonstersMod = -1;
	static int lastMaxMonstersMod = -1;
	static int lastMonsterSpawnDelayMod = -1;
	static int lastMonsterHealthScaleMod = -1;
	static int lastMonsterGuardsMod = -1;
	static int lastMonsterTitansMod = -1;
	static int lastMonstersPerTrapMod = -1;
	static int lastMonsterLoadMod = -1;
	static int lastDistanceLimitMod = -1;
	static int lastChallengingEnvMod = -1;
	char info[MAX_INFO_STRING];

	if (
		lastGametypeMod != g_gametype.modificationCount ||
		lastMapnameMod != g_mapName.modificationCount ||
		lastBasehealthMod != g_baseHealth.modificationCount ||
		lastDmflagsMod != g_dmflags.modificationCount ||
		lastFraglimitMod != g_fraglimit.modificationCount ||
		lastCapturelimitMod != g_capturelimit.modificationCount ||
		lastTimelimitMod != g_timelimit.modificationCount ||
		lastDistanceLimitMod != g_distanceLimit.modificationCount ||
		lastMonsterLoadMod != g_monsterLoad.modificationCount ||
		lastChallengingEnvMod != g_challengingEnv.modificationCount ||
		lastArtefactsMod != g_artefacts.modificationCount ||
		lastRespawndelayMod != g_respawnDelay.modificationCount ||
		lastGameseedMod != g_gameSeed.modificationCount ||
		lastFriendlyFireMod != g_friendlyFire.modificationCount ||
		lastStaminaMod != g_stamina.modificationCount ||
		lastNoItemsMod != g_noItems.modificationCount ||
		lastNoHealthRegenMod != g_noHealthRegen.modificationCount ||
		lastCloakingDeviceMod != g_cloakingDevice.modificationCount ||
		lastUnlimitedAmmoMod != g_unlimitedAmmo.modificationCount ||
		lastArmorFragmentsMod != g_armorFragments.modificationCount ||
		lastLightningLimitMod != g_lightningDamageLimit.modificationCount ||
		lastGrappleMod != g_grapple.modificationCount ||
		lastMonsterLauncherMod != g_monsterLauncher.modificationCount ||
		lastMinMonstersMod != g_minMonsters.modificationCount ||
		lastMaxMonstersMod != g_maxMonsters.modificationCount ||
		lastMonsterSpawnDelayMod != g_monsterSpawnDelay.modificationCount ||
		lastMonsterHealthScaleMod != g_monsterHealthScale.modificationCount ||
		lastMonsterGuardsMod != g_monsterGuards.modificationCount ||
		lastMonsterTitansMod != g_monsterTitans.modificationCount ||
		lastMonstersPerTrapMod != g_monstersPerTrap.modificationCount
	) {
		int highscoreType;

		lastGametypeMod = g_gametype.modificationCount;
		lastMapnameMod = g_mapName.modificationCount;
		lastBasehealthMod = g_baseHealth.modificationCount;
		lastDmflagsMod = g_dmflags.modificationCount;
		lastFraglimitMod = g_fraglimit.modificationCount;
		lastCapturelimitMod = g_capturelimit.modificationCount;
		lastTimelimitMod = g_timelimit.modificationCount;
		lastDistanceLimitMod = g_distanceLimit.modificationCount;
		lastMonsterLoadMod = g_monsterLoad.modificationCount;
		lastChallengingEnvMod = g_challengingEnv.modificationCount;
		lastArtefactsMod = g_artefacts.modificationCount;
		lastRespawndelayMod = g_respawnDelay.modificationCount;
		lastGameseedMod = g_gameSeed.modificationCount;
		lastFriendlyFireMod = g_friendlyFire.modificationCount;
		lastStaminaMod = g_stamina.modificationCount;
		lastNoItemsMod = g_noItems.modificationCount;
		lastNoHealthRegenMod = g_noHealthRegen.modificationCount;
		lastCloakingDeviceMod = g_cloakingDevice.modificationCount;
		lastUnlimitedAmmoMod = g_unlimitedAmmo.modificationCount;
		lastArmorFragmentsMod = g_armorFragments.modificationCount;
		lastLightningLimitMod = g_lightningDamageLimit.modificationCount;
		lastGrappleMod = g_grapple.modificationCount;
		lastMonsterLauncherMod = g_monsterLauncher.modificationCount;
		lastMinMonstersMod = g_minMonsters.modificationCount;
		lastMaxMonstersMod = g_maxMonsters.modificationCount;
		lastMonsterSpawnDelayMod = g_monsterSpawnDelay.modificationCount;
		lastMonsterHealthScaleMod = g_monsterHealthScale.modificationCount;
		lastMonsterGuardsMod = g_monsterGuards.modificationCount;
		lastMonsterTitansMod = g_monsterTitans.modificationCount;
		lastMonstersPerTrapMod = g_monsterLauncher.modificationCount;

		switch (g_gametype.integer) {
		case GT_STU:
			if (
				g_artefacts.integer > 0 &&
				g_artefacts.integer < 999
			) {
				highscoreType = GC_time;
			}
			else {
				highscoreType = GC_score;
			}
			break;

		case GT_EFH:
			if (g_distanceLimit.integer <= 0) {
				highscoreType = GC_distance;
			}
			else {
				highscoreType = GC_speed;
			}
			break;

		default:
			highscoreType = GC_none;
			break;
		}

		Com_sprintf(
			info, sizeof(info),
			"gt\\%d"
			"\\map\\%s"
			"\\bh\\d%d"
			"\\dmf\\d%d"
			"\\fl\\d%d"
			"\\tl\\d%d"
			"\\dl\\d%d"
			"\\art\\d%d"
			"\\rd\\d%d"
			"\\gs\\d%d"
			"\\ff\\d%d"
			"\\st\\d%d"
			"\\ni\\d%d"
			"\\nhr\\d%d"
			"\\cd\\d%d"
			"\\ua\\d%d"
			"\\af\\d%d"
			"\\ldl\\d%d"
			"\\gh\\d%d"
			"\\che\\d%d"
			"\\ml\\d%d"
			"\\mlo\\d%d"
			"\\mim\\d%d"
			"\\mam\\d%d"
			"\\msd\\d%d"
			"\\mhs\\d%d"
			"\\mg\\d%d"
			"\\mt\\d%d"
			"\\mpt\\d%d"
			"\\ht\\%d",
			g_gametype.integer,
			g_mapName.string,
			g_baseHealth.integer,
			g_dmflags.integer,
			g_gametype.integer == GT_CTF? g_capturelimit.integer : g_fraglimit.integer,
			g_timelimit.integer,
			g_distanceLimit.integer,
			g_artefacts.integer,
			g_respawnDelay.integer,
			g_gameSeed.integer,
			g_friendlyFire.integer,
			g_stamina.integer,
			g_noItems.integer,
			g_noHealthRegen.integer,
			g_cloakingDevice.integer,
			g_unlimitedAmmo.integer,
			g_armorFragments.integer,
			g_lightningDamageLimit.integer,
			g_grapple.integer,
			g_challengingEnv.integer,
			g_monsterLauncher.integer,
			g_monsterLoad.integer,
			g_minMonsters.integer,
			g_maxMonsters.integer,
			g_monsterSpawnDelay.integer,
			g_monsterHealthScale.integer,
			g_monsterGuards.integer,
			g_monsterTitans.integer,
			g_monstersPerTrap.integer,
			highscoreType
		);
		trap_SetConfigstring(CS_GAMESETTINGS, info);
	}
}

/*
==================
CheckCvars
==================
*/
void CheckCvars( void ) {
	static int lastMod = -1;

	if ( g_password.modificationCount != lastMod ) {
		lastMod = g_password.modificationCount;
		if ( *g_password.string && Q_stricmp( g_password.string, "none" ) ) {
			trap_Cvar_Set( "g_needpass", "1" );
		} else {
			trap_Cvar_Set( "g_needpass", "0" );
		}
	}
	CheckGamesettings();	// JUHOX
}

/*
=============
G_RunThink

Runs thinking code for this frame if necessary
=============
*/
void G_RunThink (gentity_t *ent) {
	float	thinktime;

	thinktime = ent->nextthink;
	if (thinktime <= 0) {
		return;
	}
	if (thinktime > level.time) {
		return;
	}

	ent->nextthink = 0;
	if (!ent->think) {
		G_Error("NULL ent->think (%s)\n", ent->classname);
	}
	ent->think (ent);
}

/*
=============
JUHOX: G_SetPlayerRefOrigin
=============
*/
void G_SetPlayerRefOrigin(playerState_t* ps) {
	ps->stats[STAT_REFERENCE_X] = (level.referenceOrigin.x >> REFERENCE_SHIFT) & 0xffff;
	ps->stats[STAT_REFERENCE_Y] = (level.referenceOrigin.y >> REFERENCE_SHIFT) & 0xffff;
	ps->stats[STAT_REFERENCE_Z] = (level.referenceOrigin.z >> REFERENCE_SHIFT) & 0xffff;
}


/*
=============
JUHOX: UpdateReferenceOrigin
=============
*/
static void UpdateReferenceOrigin(void) {
	vec3_t middle;
	int i;
	int n;
	efhVector_t intMiddle;
	efhVector_t intDelta;
	vec3_t delta;

	if (g_gametype.integer != GT_EFH) return;

#if MEETING
	if (level.meeting) return;
#endif

	VectorClear(middle);
	n = 0;
	for (i = 0; i < level.maxclients; i++) {
		if (!g_entities[i].inuse) continue;
		if (level.clients[i].pers.connected != CON_CONNECTED) continue;

		VectorAdd(middle, level.clients[i].ps.origin, middle);
		n++;
	}
	if (n <= 0) return;

	VectorScale(middle, 1.0 / n, middle);

	intMiddle.x = (long) middle[0];
	intMiddle.y = (long) middle[1];
	intMiddle.z = (long) middle[2];

	intDelta.x = intMiddle.x >> REFERENCE_SHIFT;
	intDelta.y = intMiddle.y >> REFERENCE_SHIFT;
	intDelta.z = intMiddle.z >> REFERENCE_SHIFT;

	if (
		intDelta.x >= -1 &&
		intDelta.x <= +1 &&
		intDelta.y >= -1 &&
		intDelta.y <= +1 &&
		intDelta.z >= -1 &&
		intDelta.z <= +1
	) {
		return;
	}

	intDelta.x <<= REFERENCE_SHIFT;
	intDelta.y <<= REFERENCE_SHIFT;
	intDelta.z <<= REFERENCE_SHIFT;

	level.referenceOrigin.x += intDelta.x;
	level.referenceOrigin.y += intDelta.y;
	level.referenceOrigin.z += intDelta.z;

	delta[0] = -intDelta.x;
	delta[1] = -intDelta.y;
	delta[2] = -intDelta.z;

	for (i = 0; i < level.num_entities; i++) {
		gentity_t* ent;
		qboolean linked;
		playerState_t* ps;

		ent = &g_entities[i];
		if (i >= MAX_CLIENTS) {
			if (!ent->inuse) continue;
			if (!ent->r.linked && ent->neverFree) continue;
		}

		linked = ent->r.linked;
		trap_UnlinkEntity(ent);

		VectorAdd(ent->s.pos.trBase, delta, ent->s.pos.trBase);
		VectorAdd(ent->r.currentOrigin, delta, ent->r.currentOrigin);

		ps = G_GetEntityPlayerState(ent);
		if (ps) {
			G_SetPlayerRefOrigin(ps);
			VectorAdd(ps->origin, delta, ps->origin);
		}
		else {
			switch (ent->entClass) {
			case GEC_trigger_push:
			case GEC_target_push:
				VectorAdd(ent->s.origin, delta, ent->s.origin);
				break;
			default:
				VectorAdd(ent->s.origin, delta, ent->s.origin);
				VectorAdd(ent->s.origin2, delta, ent->s.origin2);
				VectorAdd(ent->pos1, delta, ent->pos1);
				VectorAdd(ent->pos2, delta, ent->pos2);
				break;
			}
		}

		if (linked) {
			trap_LinkEntity(ent);
		}
	}
}


/*
=============
JUHOX: ComputeCoveredDistance
=============
*/
static void ComputeCoveredDistance(void) {
	int i;
	long minDistance;
	int playersMissing;

	if (g_gametype.integer != GT_EFH) return;
	if (
		level.intermissiontime ||
		level.intermissionQueued
	) {
		return;
	}
#if MEETING
	if (level.meeting) return;
#endif

	minDistance = 0x7fffffff;
	playersMissing = 0;
	for (i = 0; i < level.maxclients; i++) {
		gentity_t* ent;
		long distance;

		ent = &g_entities[i];
		if (!ent->inuse) continue;
		if (!ent->client) continue;
		if (ent->client->pers.connected != CON_CONNECTED) continue;
		if (ent->client->sess.sessionTeam == TEAM_SPECTATOR) continue;

		distance = G_GetTotalWayLength(ent) / 32;

		if (
			level.efhGoalDistance > 0 &&
			distance < level.efhGoalDistance
		) {
			playersMissing++;
		}

		if (distance >= minDistance) continue;

		minDistance = distance;
	}

	if (minDistance == 0x7fffffff) {
		minDistance = 0;
	}

	if (minDistance == level.efhCoveredDistance) return;

	level.efhCoveredDistance = minDistance;

	trap_SetConfigstring(CS_EFH_COVERED_DISTANCE, va("%d,%d", minDistance, playersMissing));
}


/*
================
G_RunFrame

Advances the non-player objects in the world
================
*/
void G_RunFrame( int levelTime ) {
	int			i;
	gentity_t	*ent;
	int			msec;
int start, end;
	int			m;	// JUHOX
	static int	entityBag[MAX_GENTITIES];	// JUHOX

	// if we are waiting for the level to restart, do nothing
	if ( level.restarted ) {
		return;
	}

	level.framenum++;
	level.previousTime = level.time;
	level.time = levelTime;
	msec = level.time - level.previousTime;

#if 1	// JUHOX: record flag possession times
	if (g_gametype.integer == GT_CTF) {
		switch (Team_GetFlagStatus(TEAM_RED)) {
		case FLAG_TAKEN:
			level.ctfRedPossessionTime += msec;
			break;
		case FLAG_DROPPED:
			level.ctfRedPossessionTime += msec / 2;
			break;
		default:
			break;
		}

		switch (Team_GetFlagStatus(TEAM_BLUE)) {
		case FLAG_TAKEN:
			level.ctfBluePossessionTime += msec;
			break;
		case FLAG_DROPPED:
			level.ctfBluePossessionTime += msec / 2;
			break;
		default:
			break;
		}
	}
#endif

    // JUHOX: send STU score to clients
	if (level.stuScore != level.stuScoreTransmitted) {
		trap_SetConfigstring(CS_STU_SCORE, va("%d", level.stuScore));
		level.stuScoreTransmitted = level.stuScore;
	}

    // JUHOX: update world for EFH
	if (g_gametype.integer == GT_EFH) {
		UpdateReferenceOrigin();
		G_UpdateWorld();
		ComputeCoveredDistance();
	}

	// get any cvar changes
	G_UpdateCvars();

	TSS_Run();	// JUHOX

	G_SendGameTemplate();	// JUHOX

	// JUHOX: spawn monsters & artefacts
	G_MonsterScanForNoises();
	G_MonsterSpawning();
	if (g_gametype.integer == GT_STU) {
		if (
			g_artefacts.integer > 0 &&
			!level.artefact &&
			!level.meeting &&
			level.time > level.startTime + 5000
		) {
			G_SpawnArtefact();
		}
	}
	G_UpdateMonsterCounters();

	//
	// go through all allocated objects
	//
	start = trap_Milliseconds();
	// JUHOX: advance level objects in random order

	m = level.num_entities;
	for (i = 0; i < m; i++) {
		entityBag[i] = i;
	}
	while (m > 0) {
		{
			int b;

			b = rand() % m;
			i = entityBag[b];
			entityBag[b] = entityBag[--m];
			ent = &g_entities[i];
		}

		if ( !ent->inuse ) {
			continue;
		}

		// clear events that are too old
		if ( level.time - ent->eventTime > EVENT_VALID_MSEC ) {
			// JUHOX: new event clearing

			ent->s.event = 0;
			if (ent->client) ent->client->ps.externalEvent = 0;

			if ( ent->freeAfterEvent ) {
				// tempEntities or dropped items completely go away after their event
				G_FreeEntity( ent );
				continue;
			} else if ( ent->unlinkAfterEvent ) {
				// items that will respawn will hide themselves after their pickup event
				ent->unlinkAfterEvent = qfalse;
				trap_UnlinkEntity( ent );
			}
		}

		// temporary entities don't think
		if ( ent->freeAfterEvent ) {
			continue;
		}

		if ( !ent->r.linked && ent->neverFree ) {
			continue;
		}

		if ( ent->s.eType == ET_MISSILE ) {
			G_RunMissile( ent );
			continue;
		}

		if ( ent->s.eType == ET_ITEM || ent->physicsObject ) {
			G_RunItem( ent );
			continue;
		}

		if ( ent->s.eType == ET_MOVER ) {
			G_RunMover( ent );
			continue;
		}

		if ( i < MAX_CLIENTS ) {
			G_RunClient( ent );
			continue;
		}

		G_RunThink( ent );
	}
end = trap_Milliseconds();

start = trap_Milliseconds();
	// perform final fixups on the players
	ent = &g_entities[0];
	for (i=0 ; i < level.maxclients ; i++, ent++ ) {
		if ( ent->inuse ) {
			ClientEndFrame( ent );
		}
	}
end = trap_Milliseconds();

	// JUHOX: update lighting origins
	if (g_gametype.integer == GT_EFH) {
		G_UpdateLightingOrigins();
	}

	// JUHOX: update monster config strings
	G_UpdateMonsterCS();

	// see if it is time to do a tournement restart
	CheckTournament();

	// see if it is time to end the level
	CheckExitRules();

	// update to team status?
	CheckTeamStatus();

	// cancel vote if timed out
	CheckVote();

	// check team votes
	CheckTeamVote( TEAM_RED );
	CheckTeamVote( TEAM_BLUE );

	// for tracking changes
	CheckCvars();

	if (g_listEntity.integer) {
		for (i = 0; i < MAX_GENTITIES; i++) {
			G_Printf("%4i: %s\n", i, g_entities[i].classname);
		}
		trap_Cvar_Set("g_listEntity", "0");
	}
}

static unsigned long randomizers[GST_num_types][4][2];
static unsigned long seeds[GST_num_types][4];

/*
================
JUHOX: SetGameSeed
================
*/
void SetGameSeed(void) {
	unsigned long seed;
	int i;
	unsigned long staticSeed;

	seed = g_gameSeed.integer & 0xffff;
	if (!seed) seed = (rand() << 16) + rand();

	staticSeed = 0xab73496e;

	for (i = 0; i < GST_num_types; i++) {
		int j;

		for (j = 0; j < 4; j++) {
			int k;

			seeds[i][j] = seed;

			for (k = 0; k < 2; k++) {
				randomizers[i][j][k] = staticSeed;

				if (k == 0) randomizers[i][j][k] |= 1;

				staticSeed = 0x59f138eb * (staticSeed ^ 0xc7298ba5);
				staticSeed = (staticSeed << 1) | (staticSeed >> 31);
			}
		}
	}
}

/*
================
JUHOX: SeededRandom
================
*/
unsigned long SeededRandom(gameseed_type_t type) {
	unsigned long r;

	r = 0xe3994b8f;

	r += randomizers[type][0][0] * (seeds[type][0] ^ randomizers[type][0][1]);
	seeds[type][0] = seeds[type][1];

	r += randomizers[type][1][0] * (seeds[type][1] ^ randomizers[type][1][1]);
	seeds[type][1] = seeds[type][2];

	r += randomizers[type][2][0] * (seeds[type][2] ^ randomizers[type][2][1]);
	seeds[type][2] = seeds[type][3];

	r += randomizers[type][3][0] * (seeds[type][3] ^ randomizers[type][3][1]);
	r = (r << 1) | (r >> 31);
	seeds[type][3] = r;

	return r;
}

/*
================
JUHOX: InitLocalSeed
================
*/
void InitLocalSeed(gameseed_type_t type, localseed_t* seed) {
	seed->seed0 = SeededRandom(type);
	seed->seed1 = SeededRandom(type);
	seed->seed2 = SeededRandom(type);
	seed->seed3 = SeededRandom(type);
}

/*
================
JUHOX: G_InitGameTemplates
================
*/
void G_InitGameTemplates(void) {
	memset(&templateFileList, 0, sizeof(templateFileList));
	numTemplateFiles = 0;
	memset(&templateList, 0, sizeof(templateList));
	memset(&transferredTemplatesPerClient, 0, sizeof(transferredTemplatesPerClient));
	memset(&clientWantsTemplateTransfer, 0, sizeof(clientWantsTemplateTransfer));
	lastServedClient = 0;
	numClientsToServe = 0;
	nextServiceTime = 0;
}

/*
================
JUHOX: GetTemplateFileList
================
*/
static qboolean GetTemplateFileList(void) {
	int i;
	const char* name;
	char buf[MAX_STRING_CHARS];
	char* p;

	trap_Cvar_VariableStringBuffer("svtmplfiles", buf, sizeof(buf));
	if (!buf[0]) {
		numTemplateFiles = trap_FS_GetFileList("templates", ".tmpl", templateFileList, sizeof(templateFileList));

		p = buf;
		name = templateFileList;
		for (i = 0; i < numTemplateFiles; i++) {
			int n;

			n = strlen(name);
			if (i > 0) *(p++) = '\\';
			strcpy(p, name);
			p += n;
			name += n + 1;
		}
		trap_Cvar_Set("svtmplfiles", buf);
		return qtrue;
	}
	else {
		Q_strncpyz(templateFileList, buf, sizeof(templateFileList));
		p = templateFileList;
		numTemplateFiles = 0;
		while (*p) {
			if (*p == '\\') {
				*p = 0;
				numTemplateFiles++;
			}
			p++;
		}
		if (p > templateFileList) numTemplateFiles++;
		return qfalse;
	}
}

/*
================
JUHOX: G_LoadGameTemplates
================
*/
void G_LoadGameTemplates(void) {
	int i;
	const char* name;

	if (GetTemplateFileList()) {
		level.loadingTemplates = qtrue;
		level.templateCounter = 0;
		level.templateName[0] = 0;
		name = templateFileList;
		for (i = 0; i < numTemplateFiles; i++) {
			trap_SendConsoleCommand(EXEC_APPEND, va("tmplname %s; exec templates/%s\n", name, name));
			name += strlen(name) + 1;
		}
	}

	trap_SendConsoleCommand(EXEC_APPEND, "wait 3; templates_restart\n");

	{
		char buf[32];

		trap_Cvar_VariableStringBuffer("sv_mapChecksum", buf, sizeof(buf));
		sv_mapChecksum = atoi(buf);
	}
}

/*
================
JUHOX: G_SetTemplateName
================
*/
void G_SetTemplateName(const char* name) {
	int len;

	level.templateCounter = 0;
	level.templateName[0] = 0;
	if (!level.loadingTemplates) return;

	Q_strncpyz(level.templateName, name, sizeof(level.templateName));
	len = strlen(level.templateName);
	if (len >= 5) {
		if (!Q_stricmp(&level.templateName[len-5], ".tmpl")) {
			level.templateName[len-5] = 0;
		}
	}
}

/*
================
JUHOX: G_DefineTemplate
================
*/
void G_DefineTemplate(const char* tmpl) {
	const char* name;
	char cvarName[MAX_STRING_CHARS];

	if (!level.loadingTemplates) return;
	if (!level.templateName[0]) return;

	if (!Info_Validate(tmpl)) return;
	name = Info_ValueForKey(tmpl, "name");
	if (!name[0]) return;

	Com_sprintf(cvarName, sizeof(cvarName), "%s%03d", level.templateName, level.templateCounter);
	trap_Cvar_Register(NULL, cvarName, "", CVAR_ROM | CVAR_NORESTART);
	trap_Cvar_Set(cvarName, tmpl);

	level.templateCounter++;
}

/*
================
JUHOX: G_RestartGameTemplates
================
*/
void G_RestartGameTemplates(void) {
	int i;

	level.loadingTemplates = qfalse;

	BG_GetGameTemplateList(&templateList, numTemplateFiles, templateFileList, qfalse);

	memset(templateChecksumString, 0, sizeof(templateChecksumString));
	templateListChecksum = 0;
	for (i = 0; i < templateList.numEntries; i++) {
		char info[MAX_INFO_STRING];
		char name[64];
		char highscoreVar[64];
		int highscoreType;
		char highscore[32];
		char descriptor[MAX_HIGHSCORE_DESCRIPTOR];
		long checksum;

		trap_Cvar_VariableStringBuffer(templateList.entries[i].cvar, info, sizeof(info));
		Q_strncpyz(name, Info_ValueForKey(info, "name"), sizeof(name));
		highscoreType = atoi(Info_ValueForKey(info, "ht"));
		Q_strncpyz(highscoreVar, Info_ValueForKey(info, "hn"), sizeof(highscoreVar));
		trap_Cvar_VariableStringBuffer(va("%s0", highscoreVar), highscore, sizeof(highscore));
		trap_Cvar_VariableStringBuffer(va("%s1", highscoreVar), descriptor, sizeof(descriptor));
		checksum = BG_TemplateChecksum(name, highscoreType, highscore, descriptor);
		templateListChecksum += checksum;
		templateChecksumString[i] = BG_ChecksumChar(checksum);
	}
}

/*
================
JUHOX: IsTemplateTransferred
================
*/
static qboolean IsTemplateTransferred(const transferredTemplates_t* tt, int listIndex) {
	if (listIndex < 0 || listIndex >= templateList.numEntries) return qtrue;

	return (tt->flags[listIndex >> 3] & (1 << (listIndex & 7)))? qtrue : qfalse;
}

/*
================
JUHOX: MarkTemplateAsTransferred
================
*/
static void MarkTemplateAsTransferred(transferredTemplates_t* tt, int listIndex) {
	if (listIndex < 0 || listIndex >= templateList.numEntries) return;
	if (IsTemplateTransferred(tt, listIndex)) return;

	tt->flags[listIndex >> 3] |= 1 << (listIndex & 7);
	tt->number++;
}

/*
================
JUHOX: MarkTemplateAsNotTransferred
================
*/
/*
static void MarkTemplateAsNotTransferred(transferredTemplates_t* tt, int listIndex) {
	if (listIndex < 0 || listIndex >= templateList.numEntries) return;
	if (!IsTemplateTransferred(tt, listIndex)) return;

	tt->flags[listIndex >> 3] &= ~(1 << (listIndex & 7));
	tt->number--;
}
*/

/*
================
JUHOX: ClearTransferredTemplates
================
*/
static void ClearTransferredTemplates(transferredTemplates_t* tt) {
	memset(tt, 0, sizeof(*tt));
}

/*
================
JUHOX: G_TemplateList_Request
================
*/
void G_TemplateList_Request(int clientNum, int numberOfTemplates, long checksum) {
	if (clientNum < 0 || clientNum >= MAX_CLIENTS) return;
	if (clientWantsTemplateTransfer[clientNum]) return;

	if (numberOfTemplates == templateList.numEntries && checksum == templateListChecksum) {
		trap_SendServerCommand(
			clientNum,
			va("templatelist_complete_cg %d %d", templateList.numEntries, templateListChecksum)
		);
		return;
	}

	clientWantsTemplateTransfer[clientNum] = qtrue;
	numClientsToServe++;
}

/*
================
JUHOX: G_TemplateList_Stop
================
*/
void G_TemplateList_Stop(int clientNum) {
	if (clientNum < 0 || clientNum >= MAX_CLIENTS) return;
	if (!clientWantsTemplateTransfer[clientNum]) return;

	clientWantsTemplateTransfer[clientNum] = qfalse;
	numClientsToServe--;
}

/*
================
JUHOX: G_TemplateList_Error
================
*/
void G_TemplateList_Error(int clientNum, const char* checkString) {
	transferredTemplates_t* tt;
	int i, n;

	if (clientNum < 0 || clientNum >= MAX_CLIENTS) return;

	tt = &transferredTemplatesPerClient[clientNum];
	ClearTransferredTemplates(tt);

	n = strlen(checkString);
	if (templateList.numEntries < n) n = templateList.numEntries;

	for (i = 0; i < n; i++) {
		if (checkString[i] == templateChecksumString[i]) {
			MarkTemplateAsTransferred(tt, i);
		}
	}
	if (tt->number >= templateList.numEntries) {
		// no obvious error. re-transfer everything.
		ClearTransferredTemplates(tt);
	}

	G_TemplateList_Request(clientNum, -1, -1);
}

/*
================
JUHOX: NextClientToServe
================
*/
static int NextClientToServe(void) {
	int i;

	if (numClientsToServe <= 0) return -1;

	for (i = 0; i < MAX_CLIENTS; i++) {
		lastServedClient++;
		if (lastServedClient >= MAX_CLIENTS) lastServedClient = 0;

		if (clientWantsTemplateTransfer[lastServedClient]) return lastServedClient;
	}
	return -1;
}

/*
================
JUHOX: G_SendGameTemplate
================
*/
void G_SendGameTemplate(void) {
	int clientNum;
	transferredTemplates_t* tt;
	int i;

	if (numClientsToServe <= 0) return;

	if (nextServiceTime > level.time) return;
	nextServiceTime = level.time + 100;

	clientNum = NextClientToServe();
	if (clientNum < 0 || clientNum >= MAX_CLIENTS) return;

	tt = &transferredTemplatesPerClient[clientNum];
	if (tt->number >= templateList.numEntries) goto TransferComplete;

	for (i = 0; i < templateList.numEntries; i++) {
		if (!IsTemplateTransferred(tt, i)) {
			char info[MAX_INFO_STRING];
			char name[64];
			char highscoreVar[64];
			int highscoreType;
			char highscore[32];
			char descriptor[MAX_HIGHSCORE_DESCRIPTOR];

			trap_Cvar_VariableStringBuffer(templateList.entries[i].cvar, info, sizeof(info));
			Q_strncpyz(name, Info_ValueForKey(info, "name"), sizeof(name));
			highscoreType = atoi(Info_ValueForKey(info, "ht"));
			Q_strncpyz(highscoreVar, Info_ValueForKey(info, "hn"), sizeof(highscoreVar));
			trap_Cvar_VariableStringBuffer(va("%s0", highscoreVar), highscore, sizeof(highscore));
			trap_Cvar_VariableStringBuffer(va("%s1", highscoreVar), descriptor, sizeof(descriptor));
			trap_SendServerCommand(
				clientNum,
				va("sv_template_cg %d \"%s\" %d \"%s\" \"%s\"", i, name, highscoreType, highscore, descriptor)
			);
			MarkTemplateAsTransferred(tt, i);
			return;
		}
	}

	TransferComplete:
	trap_SendServerCommand(
		clientNum,
		va("templatelist_complete_cg %d %d", templateList.numEntries, templateListChecksum)
	);
	G_TemplateList_Stop(clientNum);
}

/*
================
JUHOX: G_PrintTemplateList
================
*/
void G_PrintTemplateList(void) {
	int i;

	if (templateList.numEntries <= 0) {
		G_Printf("No templates installed.\n");
		return;
	}

	for (i = 0; i < templateList.numEntries; i++) {
		G_Printf("%3d: %s\n", i, templateList.entries[i].name);
	}
}

/*
================
JUHOX: SetValue
================
*/
static void SetValue(const char* name, int v) {
	trap_Cvar_Set(name, va("%d", v));
}

/*
================
JUHOX: G_PlayTemplate
================
*/
void G_PlayTemplate(int index) {
	const char* templateVarName;
	char info[MAX_INFO_STRING];
	gametemplate_t gtmpl;

	if (index < 0 || index >= templateList.numEntries) {
		if (templateList.numEntries > 0) {
			G_Printf("Invalid template index #%d, use 0 - %d\n", index, templateList.numEntries);
		}
		else {
			G_Printf("No templates installed.\n");
		}
		return;
	}

	templateVarName = templateList.entries[index].cvar;
	trap_Cvar_VariableStringBuffer(templateVarName, info, sizeof(info));
	if (!BG_ParseGameTemplate(info, &gtmpl)) {
		G_Printf("Template #%d is faulty.\n", index);
		return;
	}

	trap_Cvar_Set("g_template", templateVarName);

	if (gtmpl.tksMaxplayers && gtmpl.maxplayers > 0) {
		if (gtmpl.maxplayers > g_maxclients.integer) SetValue("sv_maxclients", gtmpl.maxplayers);
		if (g_maxGameClients.integer > 0 && gtmpl.maxplayers > g_maxGameClients.integer) {
			SetValue("g_maxGameClients", gtmpl.maxplayers);
		}
	}
	if (gtmpl.tksArmorfragments) SetValue("g_armorFragments", gtmpl.armorfragments);
	if (gtmpl.tksBasehealth) SetValue("g_baseHealth", gtmpl.basehealth);
	if (gtmpl.tksStamina) SetValue("g_stamina", gtmpl.stamina);
	if (gtmpl.tksLightningdamagelimit) SetValue("g_lightningDamageLimit", gtmpl.lightningdamagelimit);
	if (gtmpl.tksGrapple) SetValue("g_grapple", gtmpl.grapple);
	if (gtmpl.tksDmflags) SetValue("dmflags", gtmpl.dmflags);
	if (gtmpl.tksSpeed) SetValue("g_speed", gtmpl.speed);
	if (gtmpl.tksKnockback) SetValue("g_knockback", gtmpl.knockback);
	if (gtmpl.tksGravity) SetValue("g_gravityLatch", gtmpl.gravity);
	else trap_Cvar_Set("g_gravityLatch", "");
	if (gtmpl.tksTsssafetymode) SetValue("tssSafetyModeAllowed", gtmpl.tsssafetymode);
	if (gtmpl.tksNoitems) SetValue("g_noItems", gtmpl.noitems);
	if (gtmpl.tksNohealthregen) SetValue("g_noHealthRegen", gtmpl.nohealthregen);
	if (gtmpl.tksCloakingdevice) SetValue("g_cloakingDevice", gtmpl.cloakingdevice);
	if (gtmpl.tksUnlimitedammo) SetValue("g_unlimitedAmmo", gtmpl.unlimitedammo);
	if (gtmpl.tksMonsterlauncher) SetValue("g_monsterLauncher", gtmpl.monsterLauncher);
	if (gtmpl.tksScoremode) SetValue("g_scoreMode", gtmpl.scoremode);
	if (gtmpl.tksTimelimit) SetValue("timelimit", gtmpl.timelimit);

	switch(gtmpl.gametype) {
	case GT_FFA:
	default:
		if (gtmpl.tksFraglimit) SetValue("fraglimit", gtmpl.fraglimit);
		if (gtmpl.tksRespawndelay) SetValue("respawndelay", gtmpl.respawndelay);
		if (gtmpl.tksGameseed) SetValue("g_gameseed", gtmpl.gameseed);
		break;

	case GT_TOURNAMENT:
		if (gtmpl.tksFraglimit) SetValue("fraglimit", gtmpl.fraglimit);
		if (gtmpl.tksGameseed) SetValue("g_gamessed", gtmpl.gameseed);
		break;

	case GT_TEAM:
		if (gtmpl.tksFraglimit) SetValue("fraglimit", gtmpl.fraglimit);
		if (gtmpl.tksFriendlyfire) SetValue("g_friendlyfire", gtmpl.friendlyfire);
		if (gtmpl.tksRespawndelay) SetValue("respawndelay", gtmpl.respawndelay);
		if (gtmpl.tksGameseed) SetValue("g_gameseed", gtmpl.gameseed);
		if (gtmpl.tksTss) SetValue("tss", gtmpl.tss);
		break;

	case GT_CTF:
		if (gtmpl.tksFraglimit) SetValue("capturelimit", gtmpl.fraglimit);
		if (gtmpl.tksFriendlyfire) SetValue("g_friendlyfire", gtmpl.friendlyfire);
		if (gtmpl.tksRespawndelay) SetValue("respawndelay", gtmpl.respawndelay);
		if (gtmpl.tksGameseed) SetValue("g_gameseed", gtmpl.gameseed);
		if (gtmpl.tksTss) SetValue("tss", gtmpl.tss);
		break;

	// JUHOX: set STU cvars
	case GT_STU:
		if (gtmpl.tksFraglimit) SetValue("fraglimit", gtmpl.fraglimit);
		if (gtmpl.tksArtefacts) SetValue("g_artefacts", gtmpl.artefacts);
		if (gtmpl.tksFriendlyfire) SetValue("g_friendlyfire", gtmpl.friendlyfire);
		if (gtmpl.tksRespawndelay) SetValue("respawndelay", gtmpl.respawndelay);
		if (gtmpl.tksGameseed) SetValue("g_gameseed", gtmpl.gameseed);

		if (gtmpl.tksMinmonsters) SetValue("g_minmonsters", gtmpl.minmonsters);
		if (gtmpl.tksMaxmonsters) SetValue("g_maxmonsters", gtmpl.maxmonsters);
		if (gtmpl.tksMonsterspertrap) SetValue("g_monstersPerTrap", gtmpl.monsterspertrap);
		if (gtmpl.tksMonsterspawndelay) SetValue("g_monsterSpawnDelay", gtmpl.monsterspawndelay);
		if (gtmpl.tksMonsterhealthscale) SetValue("g_monsterHealthScale", gtmpl.monsterhealthscale);
		if (gtmpl.tksMonsterprogessivehealth) SetValue("g_monsterProgression", gtmpl.monsterprogressivehealth);
		if (gtmpl.tksGuards) SetValue("g_monsterGuards", gtmpl.guards);
		if (gtmpl.tksTitans) SetValue("g_monsterTitans", gtmpl.titans);
		if (gtmpl.tksMonsterbreeding) SetValue("g_monsterBreeding", gtmpl.monsterbreeding);
		break;


	// JUHOX: set EFH cvars
	case GT_EFH:
		if (gtmpl.tksFraglimit) SetValue("fraglimit", gtmpl.fraglimit);
		if (gtmpl.tksDistancelimit) SetValue("distancelimit", gtmpl.distancelimit);
		if (gtmpl.tksFriendlyfire) SetValue("g_friendlyfire", gtmpl.friendlyfire);
		if (gtmpl.tksRespawndelay) SetValue("respawndelay", gtmpl.respawndelay);
		if (gtmpl.tksGameseed) SetValue("g_gameseed", gtmpl.gameseed);
		if (gtmpl.tksChallengingEnv) SetValue("g_challengingEnv", gtmpl.challengingEnv);

		if (gtmpl.tksMonsterload) SetValue("g_monsterLoad", gtmpl.monsterLoad);
		if (gtmpl.tksMonsterhealthscale) SetValue("g_monsterHealthScale", gtmpl.monsterhealthscale);
		if (gtmpl.tksMonsterprogessivehealth) SetValue("g_monsterProgression", gtmpl.monsterprogressivehealth);
		if (gtmpl.tksGuards) SetValue("g_monsterGuards", gtmpl.guards);
		if (gtmpl.tksTitans) SetValue("g_monsterTitans", gtmpl.titans);
		break;
	}

	SetValue("g_gameType", gtmpl.gametype);
	if (gtmpl.mapName[0]) {
		trap_SendConsoleCommand(EXEC_APPEND, va("map %s\n", gtmpl.mapName));
	}
	else {
		trap_SendConsoleCommand(EXEC_APPEND, "map_restart 0\n");
	}
}
