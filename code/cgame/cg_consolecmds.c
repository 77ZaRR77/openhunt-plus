// Copyright (C) 1999-2000 Id Software, Inc.
//
// cg_consolecmds.c -- text commands typed in at the local console, or
// executed by a key binding

#include "cg_local.h"
#include "../ui/ui_shared.h"


void CG_TargetCommand_f( void ) {
	int		targetNum;
	char	test[4];

	targetNum = CG_CrosshairPlayer();
	if ( !targetNum ) return;

	trap_Argv( 1, test, 4 );
	trap_SendConsoleCommand( va( "gc %i %i", targetNum, atoi( test ) ) );
}



/*
=================
CG_SizeUp_f

Keybinding command
=================
*/
static void CG_SizeUp_f (void) {
	trap_Cvar_Set("cg_viewsize", va("%i",(int)(cg_viewsize.integer+10)));
}


/*
=================
CG_SizeDown_f

Keybinding command
=================
*/
static void CG_SizeDown_f (void) {
	trap_Cvar_Set("cg_viewsize", va("%i",(int)(cg_viewsize.integer-10)));
}


/*
=============
CG_Viewpos_f

Debugging command to print the current position
=============
*/
static void CG_Viewpos_f (void) {
	CG_Printf ("(%i %i %i) : %i\n", (int)cg.refdef.vieworg[0], (int)cg.refdef.vieworg[1], (int)cg.refdef.vieworg[2], (int)cg.refdefViewAngles[YAW]);
}


static void CG_ScoresDown_f( void ) {

	// JUHOX: toggle lens flare editor move mode
	if (cgs.editMode == EM_mlf) {
		if (
			cg.lfEditor.selectedLFEnt &&
			cg.lfEditor.cmdMode == LFECM_main &&
			cg.lfEditor.editMode > LFEEM_none
		) {
			CG_SetLFEdMoveMode(!cg.lfEditor.moveMode);
		}
		return;
	}

	if ( cg.scoresRequestTime + 2000 < cg.time ) {
		// the scores are more than two seconds out of data,
		// so request new ones
		cg.scoresRequestTime = cg.time;
		trap_SendClientCommand( "score" );

		// leave the current scores up if they were already
		// displayed, but if this is the first hit, clear them out
		if ( !cg.showScores ) {
			cg.showScores = qtrue;
			cg.numScores = 0;
		}
	} else {
		// show the cached contents even if they just pressed if it
		// is within two seconds
		cg.showScores = qtrue;
	}
}

static void CG_ScoresUp_f( void ) {
	if ( cg.showScores ) {
		cg.showScores = qfalse;
		cg.scoreFadeTime = cg.time;
	}
}

/*
=================
JUHOX: CG_SaveLensFlareEntities_f
=================
*/
static void CG_SaveLensFlareEntities_f(void) {
	char mapname[256];
	char name[256];
	fileHandle_t f;
	int i;
	int n;

	if (cgs.editMode != EM_mlf) return;

	trap_Cvar_VariableStringBuffer("mapname", mapname, sizeof(mapname));
	Com_sprintf(name, sizeof(name), "flares/%s.lfe", mapname);

	trap_FS_FOpenFile(name, &f, FS_WRITE);
	if (!f) {
		CG_Printf("Could not create '%s'\n", name);
		return;
	}
	CG_Printf("writing '%s'...\n", name);

	n = 0;
	for (i = 0; i < cgs.numLensFlareEntities; i++) {
		const lensFlareEntity_t* lfent;
		char buf[512];
		char lockOption[16];
		char lightRadius[16];

		lfent = &cgs.lensFlareEntities[i];
		if (!lfent->lfeff) continue;

		if (lfent->lock) {
			Com_sprintf(lockOption, sizeof(lockOption), "mv %d ", lfent->lock->currentState.number);
		}
		else {
			lockOption[0] = 0;
		}

		if (lfent->lightRadius > 1) {
			Com_sprintf(lightRadius, sizeof(lightRadius), "lr %f ", lfent->lightRadius);
		}
		else {
			lightRadius[0] = 0;
		}

		Com_sprintf(
			buf, sizeof(buf), "{ %s %f %f %f %f %f %f %f %f %s%s}\n",
			lfent->lfeff->name,
			lfent->origin[0], lfent->origin[1], lfent->origin[2],
			lfent->radius,
			lfent->dir[0], lfent->dir[1], lfent->dir[2],
			lfent->angle,
			lockOption, lightRadius
		);
		trap_FS_Write(buf, strlen(buf), f);

		n++;
	}
	trap_FS_FCloseFile(f);

	CG_Printf("%d lens flare entities saved\n", n);
}


/*
=================
JUHOX: CG_RevertLensFlareEntities_f
=================
*/
static void CG_RevertLensFlareEntities_f(void) {
	if (cgs.editMode != EM_mlf) return;

	CG_LoadLensFlareEntities();
}


/*
=================
JUHOX: CG_UpdateLensFlares_f
=================
*/
static void CG_UpdateLensFlares_f(void) {
	if (cgs.editMode != EM_mlf) return;

	CG_SaveLensFlareEntities_f();
	CG_LoadLensFlares();
	CG_LoadLensFlareEntities();
}

static void CG_TellTarget_f( void ) {
	int		clientNum;
	char	command[128];
	char	message[128];

	clientNum = CG_CrosshairPlayer();
	if ( clientNum == -1 ) return;

	trap_Args( message, 128 );
	Com_sprintf( command, 128, "tell %i %s", clientNum, message );
	trap_SendClientCommand( command );
}

static void CG_TellAttacker_f( void ) {
	int		clientNum;
	char	command[128];
	char	message[128];

	clientNum = CG_LastAttacker();
	if ( clientNum == -1 ) return;

	trap_Args( message, 128 );
	Com_sprintf( command, 128, "tell %i %s", clientNum, message );
	trap_SendClientCommand( command );
}

static void CG_VoiceTellTarget_f( void ) {
	int		clientNum;
	char	command[128];
	char	message[128];

	clientNum = CG_CrosshairPlayer();
	if ( clientNum == -1 ) return;

	trap_Args( message, 128 );
	Com_sprintf( command, 128, "vtell %i %s", clientNum, message );
	trap_SendClientCommand( command );
}

static void CG_VoiceTellAttacker_f( void ) {
	int		clientNum;
	char	command[128];
	char	message[128];

	clientNum = CG_LastAttacker();
	if ( clientNum == -1 ) return;

	trap_Args( message, 128 );
	Com_sprintf( command, 128, "vtell %i %s", clientNum, message );
	trap_SendClientCommand( command );
}

// JUHOX: CG_TSSInterface_f()
static void CG_TSSInterface_f(void) {
	CG_TSS_OpenInterface();
}

// JUHOX: CG_Hook_Plus_f()
static void CG_Hook_Plus_f(void) {
	trap_SendClientCommand("throwhook +");
}

// JUHOX: CG_Hook_Minus_f()
static void CG_Hook_Minus_f(void) {
	trap_SendClientCommand("throwhook -");
}

/*
==================
CG_StartOrbit_f
==================
*/

static void CG_StartOrbit_f( void ) {
	char var[MAX_TOKEN_CHARS];

	trap_Cvar_VariableStringBuffer( "developer", var, sizeof( var ) );
	if ( !atoi(var) ) return;

	if (cg_cameraOrbit.value != 0) {
		trap_Cvar_Set ("cg_cameraOrbit", "0");
		trap_Cvar_Set("cg_thirdPerson", "0");
	} else {
		trap_Cvar_Set("cg_cameraOrbit", "5");
		trap_Cvar_Set("cg_thirdPerson", "1");
		trap_Cvar_Set("cg_thirdPersonAngle", "0");
		trap_Cvar_Set("cg_thirdPersonRange", "100");
	}
}


typedef struct {
	char	*cmd;
	void	(*function)(void);
} consoleCommand_t;

static consoleCommand_t	commands[] = {
	{ "testgun", CG_TestGun_f },
	{ "testmodel", CG_TestModel_f },
	{ "nextframe", CG_TestModelNextFrame_f },
	{ "prevframe", CG_TestModelPrevFrame_f },
	{ "nextskin", CG_TestModelNextSkin_f },
	{ "prevskin", CG_TestModelPrevSkin_f },
	{ "viewpos", CG_Viewpos_f },
	{ "+scores", CG_ScoresDown_f },
	{ "-scores", CG_ScoresUp_f },
	{ "+zoom", CG_ZoomDown_f },
	{ "-zoom", CG_ZoomUp_f },
	{ "sizeup", CG_SizeUp_f },
	{ "sizedown", CG_SizeDown_f },
	{ "weapnext", CG_NextWeapon_f },
	{ "weapprev", CG_PrevWeapon_f },
	{ "weapbest", CG_BestWeapon_f },			// JUHOX
	{ "weapskip", CG_SkipWeapon_f },			// JUHOX
	{ "nextweaporder", CG_NextWeaponOrder_f },	// JUHOX
	{ "prevweaporder", CG_PrevWeaponOrder_f },	// JUHOX
	{ "weapon", CG_Weapon_f },
	{ "tell_target", CG_TellTarget_f },
	{ "tell_attacker", CG_TellAttacker_f },
	{ "vtell_target", CG_VoiceTellTarget_f },
	{ "vtell_attacker", CG_VoiceTellAttacker_f },
	{ "tcmd", CG_TargetCommand_f },
	{ "tssinterface", CG_TSSInterface_f },	// JUHOX
	{ "+throwhook", CG_Hook_Plus_f },	// JUHOX
	{ "-throwhook", CG_Hook_Minus_f },	// JUHOX
	// JUHOX: add lens flare editor commands
	{ "lfsave", CG_SaveLensFlareEntities_f },
	{ "lfrevert", CG_RevertLensFlareEntities_f },
	{ "lfupdate", CG_UpdateLensFlares_f },
	{ "startOrbit", CG_StartOrbit_f },
	{ "loaddeferred", CG_LoadDeferredPlayers }
};


/*
=================
CG_ConsoleCommand

The string has been tokenized and can be retrieved with
Cmd_Argc() / Cmd_Argv()
=================
*/
qboolean CG_ConsoleCommand( void ) {
	const char	*cmd;
	int		i;

	cmd = CG_Argv(0);

	for ( i = 0 ; i < sizeof( commands ) / sizeof( commands[0] ) ; i++ ) {
		if ( !Q_stricmp( cmd, commands[i].cmd ) ) {
			commands[i].function();
			return qtrue;
		}
	}

	return qfalse;
}


/*
=================
CG_InitConsoleCommands

Let the client system know about all of our commands
so it can perform tab completion
=================
*/
void CG_InitConsoleCommands( void ) {
	int		i;

	for ( i = 0 ; i < sizeof( commands ) / sizeof( commands[0] ) ; i++ ) {
		trap_AddCommand( commands[i].cmd );
	}

	//
	// the game server will interpret these commands, which will be automatically
	// forwarded to the server after they are not recognized locally
	//
	trap_AddCommand ("kill");
	trap_AddCommand ("say");
	trap_AddCommand ("say_team");
	trap_AddCommand ("tell");
	trap_AddCommand ("give");
	trap_AddCommand ("god");
	trap_AddCommand ("notarget");
	trap_AddCommand ("noclip");
	trap_AddCommand ("team");
	trap_AddCommand ("follow");
	trap_AddCommand ("levelshot");
	trap_AddCommand ("addbot");
	trap_AddCommand ("setviewpos");
	trap_AddCommand ("callvote");
	trap_AddCommand ("vote");
	trap_AddCommand ("callteamvote");
	trap_AddCommand ("teamvote");
	trap_AddCommand ("stats");
	trap_AddCommand ("teamtask");
	trap_AddCommand ("loaddefered");
	trap_AddCommand ("drophealth");	// JUHOX
	trap_AddCommand ("droparmor");	// JUHOX
	trap_AddCommand ("navaid"); 	// JUHOX
}
