// Copyright (C) 1999-2000 Id Software, Inc.
//
/*
=======================================================================

USER INTERFACE MAIN

=======================================================================
*/


#include "ui_local.h"


/*
================
vmMain

This is the only way control passes into the module.
This must be the very first function compiled into the .qvm file
================
*/
int vmMain( int command, int arg0, int arg1, int arg2, int arg3, int arg4, int arg5, int arg6, int arg7, int arg8, int arg9, int arg10, int arg11  ) {
	switch ( command ) {
	case UI_GETAPIVERSION:
		return UI_API_VERSION;

	case UI_INIT:
		UI_Init();
		return 0;

	case UI_SHUTDOWN:
		UI_Shutdown();
		return 0;

	case UI_KEY_EVENT:
		UI_KeyEvent( arg0, arg1 );
		return 0;

	case UI_MOUSE_EVENT:
		UI_MouseEvent( arg0, arg1 );
		return 0;

	case UI_REFRESH:
		UI_Refresh( arg0 );
		return 0;

	case UI_IS_FULLSCREEN:
		return UI_IsFullscreen();

	case UI_SET_ACTIVE_MENU:
		UI_SetActiveMenu( arg0 );
		return 0;

	case UI_CONSOLE_COMMAND:
		return UI_ConsoleCommand(arg0);

	case UI_DRAW_CONNECT_SCREEN:
		UI_DrawConnectScreen( arg0 );
		return 0;
	case UI_HASUNIQUECDKEY:		// mod authors need to observe this
		return qfalse;          // bk010117 - change this to qfalse for mods!
	}

	return -1;
}


/*
================
cvars
================
*/

typedef struct {
	vmCvar_t	*vmCvar;
	char		*cvarName;
	char		*defaultString;
	int			cvarFlags;
} cvarTable_t;

vmCvar_t	ui_ffa_fraglimit;
vmCvar_t	ui_ffa_timelimit;

vmCvar_t	ui_tourney_fraglimit;
vmCvar_t	ui_tourney_timelimit;

vmCvar_t	ui_team_fraglimit;
vmCvar_t	ui_team_timelimit;
vmCvar_t	ui_team_friendly;
vmCvar_t	ui_team_tss;	// JUHOX

vmCvar_t	ui_ctf_capturelimit;
vmCvar_t	ui_ctf_timelimit;
vmCvar_t	ui_ctf_friendly;
vmCvar_t	ui_ctf_tss;	// JUHOX

vmCvar_t	ui_additionalSlots;	// JUHOX
vmCvar_t	ui_tss;	// JUHOX
vmCvar_t	ui_respawnAtPOD;	// JUHOX
vmCvar_t	ui_armorFragments;	// JUHOX
vmCvar_t	ui_stamina;	// JUHOX
vmCvar_t	ui_baseHealth;	// JUHOX
vmCvar_t	ui_lightningDamageLimit;	// JUHOX

vmCvar_t	ui_arenasFile;
vmCvar_t	ui_botsFile;
vmCvar_t	ui_spScores1;
vmCvar_t	ui_spScores2;
vmCvar_t	ui_spScores3;
vmCvar_t	ui_spScores4;
vmCvar_t	ui_spScores5;
vmCvar_t	ui_spAwards;
vmCvar_t	ui_spVideos;
vmCvar_t	ui_spSkill;

vmCvar_t	ui_spSelection;

vmCvar_t	ui_browserMaster;
vmCvar_t	ui_browserGameType;
vmCvar_t	ui_browserSortKey;
vmCvar_t	ui_browserShowFull;
vmCvar_t	ui_browserShowEmpty;

vmCvar_t	ui_brassTime;
vmCvar_t	ui_drawCrosshair;
vmCvar_t	ui_drawCrosshairNames;
vmCvar_t	ui_marks;

vmCvar_t	ui_hiDetailTitle;	// JUHOX

vmCvar_t	ui_server1;
vmCvar_t	ui_server2;
vmCvar_t	ui_server3;
vmCvar_t	ui_server4;
vmCvar_t	ui_server5;
vmCvar_t	ui_server6;
vmCvar_t	ui_server7;
vmCvar_t	ui_server8;
vmCvar_t	ui_server9;
vmCvar_t	ui_server10;
vmCvar_t	ui_server11;
vmCvar_t	ui_server12;
vmCvar_t	ui_server13;
vmCvar_t	ui_server14;
vmCvar_t	ui_server15;
vmCvar_t	ui_server16;


// bk001129 - made static to avoid aliasing.
static cvarTable_t		cvarTable[] = {
	{ &ui_ffa_fraglimit, "ui_ffa_fraglimit", "20", CVAR_ARCHIVE },
	{ &ui_ffa_timelimit, "ui_ffa_timelimit", "0", CVAR_ARCHIVE },
	{ NULL, "ui_ffa_respawndelay", "0", CVAR_ARCHIVE },	// JUHOX
	{ NULL, "ui_ffa_gameseed", "0", CVAR_ARCHIVE },	// JUHOX
	{ NULL, "ui_ffa_noItems", "0", CVAR_ARCHIVE },	// JUHOX
	{ NULL, "ui_ffa_noHealthRegen", "0", CVAR_ARCHIVE },	// JUHOX
	{ NULL, "ui_ffa_unlimitedAmmo", "0", CVAR_ARCHIVE },	// JUHOX
	{ NULL, "ui_ffa_cloakingDevice", "1", CVAR_ARCHIVE },	// JUHOX
	{ NULL, "ui_ffa_weaponLimit", "0", CVAR_ARCHIVE },	// JUHOX

	{ &ui_tourney_fraglimit, "ui_tourney_fraglimit", "0", CVAR_ARCHIVE },
	{ &ui_tourney_timelimit, "ui_tourney_timelimit", "15", CVAR_ARCHIVE },
	{ NULL, "ui_tourney_gameseed", "0", CVAR_ARCHIVE },	// JUHOX
	{ NULL, "ui_tourney_noItems", "0", CVAR_ARCHIVE },	// JUHOX
	{ NULL, "ui_tourney_noHealthRegen", "0", CVAR_ARCHIVE },	// JUHOX
	{ NULL, "ui_tourney_unlimitedAmmo", "0", CVAR_ARCHIVE },	// JUHOX
	{ NULL, "ui_tourney_cloakingDevice", "1", CVAR_ARCHIVE },	// JUHOX
	{ NULL, "ui_tourney_weaponLimit", "0", CVAR_ARCHIVE },	// JUHOX

	{ &ui_team_fraglimit, "ui_team_fraglimit", "0", CVAR_ARCHIVE },
	{ &ui_team_timelimit, "ui_team_timelimit", "20", CVAR_ARCHIVE },
	{ &ui_team_friendly, "ui_team_friendly",  "1", CVAR_ARCHIVE },
	{ NULL, "ui_team_respawndelay", "0", CVAR_ARCHIVE },	// JUHOX
	{ &ui_team_tss, "ui_team_tss", "1", CVAR_ARCHIVE },	// JUHOX
	{ NULL, "ui_team_gameseed", "0", CVAR_ARCHIVE },	// JUHOX
	{ NULL, "ui_team_noItems", "0", CVAR_ARCHIVE },	// JUHOX
	{ NULL, "ui_team_noHealthRegen", "0", CVAR_ARCHIVE },	// JUHOX
	{ NULL, "ui_team_unlimitedAmmo", "0", CVAR_ARCHIVE },	// JUHOX
	{ NULL, "ui_team_cloakingDevice", "1", CVAR_ARCHIVE },	// JUHOX
	{ NULL, "ui_team_weaponLimit", "0", CVAR_ARCHIVE },	// JUHOX

	{ &ui_ctf_capturelimit, "ui_ctf_capturelimit", "8", CVAR_ARCHIVE },
	{ &ui_ctf_timelimit, "ui_ctf_timelimit", "30", CVAR_ARCHIVE },
	{ &ui_ctf_friendly, "ui_ctf_friendly",  "0", CVAR_ARCHIVE },
	{ NULL, "ui_ctf_respawndelay", "0", CVAR_ARCHIVE },	// JUHOX
	{ &ui_ctf_tss, "ui_ctf_tss", "1", CVAR_ARCHIVE },	// JUHOX
	{ NULL, "ui_ctf_gameseed", "0", CVAR_ARCHIVE },	// JUHOX
	{ NULL, "ui_ctf_noItems", "0", CVAR_ARCHIVE },	// JUHOX
	{ NULL, "ui_ctf_noHealthRegen", "0", CVAR_ARCHIVE },	// JUHOX
	{ NULL, "ui_ctf_unlimitedAmmo", "0", CVAR_ARCHIVE },	// JUHOX
	{ NULL, "ui_ctf_cloakingDevice", "1", CVAR_ARCHIVE },	// JUHOX
	{ NULL, "ui_ctf_weaponLimit", "0", CVAR_ARCHIVE },	// JUHOX

	// JUHOX: ui cvars used for monsters
	{ NULL, "ui_ffa_monsterLauncher", "1", CVAR_ARCHIVE },
	{ NULL, "ui_ffa_maxMonsters", "60", CVAR_ARCHIVE },
	{ NULL, "ui_ffa_maxMonstersPP", "10", CVAR_ARCHIVE },
	{ NULL, "ui_ffa_monsterHealthScale", "10", CVAR_ARCHIVE },

	{ NULL, "ui_tourney_monsterLauncher", "1", CVAR_ARCHIVE },
	{ NULL, "ui_tourney_maxMonsters", "60", CVAR_ARCHIVE },
	{ NULL, "ui_tourney_maxMonstersPP", "10", CVAR_ARCHIVE },
	{ NULL, "ui_tourney_monsterHealthScale", "10", CVAR_ARCHIVE },

	{ NULL, "ui_team_monsterLauncher", "1", CVAR_ARCHIVE },
	{ NULL, "ui_team_maxMonsters", "60", CVAR_ARCHIVE },
	{ NULL, "ui_team_maxMonstersPP", "10", CVAR_ARCHIVE },
	{ NULL, "ui_team_monsterHealthScale", "10", CVAR_ARCHIVE },

	{ NULL, "ui_ctf_monsterLauncher", "1", CVAR_ARCHIVE },
	{ NULL, "ui_ctf_maxMonsters", "60", CVAR_ARCHIVE },
	{ NULL, "ui_ctf_maxMonstersPP", "10", CVAR_ARCHIVE },
	{ NULL, "ui_ctf_monsterHealthScale", "10", CVAR_ARCHIVE },

	{ NULL, "g_template", "", CVAR_ROM },	// JUHOX
	{ NULL, "g_noItems", "0", CVAR_ARCHIVE | CVAR_LATCH },	// JUHOX
	{ NULL, "g_noHealthRegen", "0", CVAR_ARCHIVE },	// JUHOX

	// JUHOX: ui cvars used for STU
	{ NULL, "ui_stu_fraglimit", "5", CVAR_ARCHIVE },
	{ NULL, "ui_stu_timelimit", "0", CVAR_ARCHIVE },
	{ NULL, "ui_stu_artefacts", "8", CVAR_ARCHIVE },
	{ NULL, "ui_stu_friendly", "0", CVAR_ARCHIVE },
	{ NULL, "ui_stu_respawndelay", "0", CVAR_ARCHIVE },
	{ NULL, "ui_stu_tss", "0", CVAR_ARCHIVE },
	{ NULL, "ui_stu_gameseed", "0", CVAR_ARCHIVE },
	{ NULL, "ui_stu_noItems", "0", CVAR_ARCHIVE },
	{ NULL, "ui_stu_noHealthRegen", "1", CVAR_ARCHIVE },
	{ NULL, "ui_stu_unlimitedAmmo", "0", CVAR_ARCHIVE },
	{ NULL, "ui_stu_cloakingDevice", "1", CVAR_ARCHIVE },
	{ NULL, "ui_stu_weaponLimit", "0", CVAR_ARCHIVE },

	{ NULL, "ui_stu_minMonsters", "15", CVAR_ARCHIVE },
	{ NULL, "ui_stu_maxMonsters", "30", CVAR_ARCHIVE },
	{ NULL, "ui_stu_monstersPerTrap", "0", CVAR_ARCHIVE },
	{ NULL, "ui_stu_monsterSpawnDelay", "10000", CVAR_ARCHIVE },
	{ NULL, "ui_stu_monsterGuards", "12", CVAR_ARCHIVE },
	{ NULL, "ui_stu_monsterTitans", "6", CVAR_ARCHIVE },
	{ NULL, "ui_stu_monsterHealthScale", "100", CVAR_ARCHIVE },
	{ NULL,	"ui_stu_monsterProgression", "10", CVAR_ARCHIVE },
	{ NULL, "ui_stu_monsterBreeding", "1", CVAR_ARCHIVE },
	{ NULL, "monsterModel1", "klesk/maneater", CVAR_ARCHIVE },
	{ NULL, "monsterModel2", "tankjr/default", CVAR_ARCHIVE },
	{ NULL, "monsterModel3", "uriel/default", CVAR_ARCHIVE },
	{ NULL, "g_skipEndSequence", "0", CVAR_ARCHIVE },
	{ NULL, "g_scoreMode", "0", CVAR_ARCHIVE },

	// JUHOX: ui cvars used for EFH
	{ NULL, "ui_efh_fraglimit", "1", CVAR_ARCHIVE },
	{ NULL, "ui_efh_timelimit", "10", CVAR_ARCHIVE },
	{ NULL, "ui_efh_distancelimit", "1000", CVAR_ARCHIVE },
	{ NULL, "ui_efh_friendly", "0", CVAR_ARCHIVE },
	{ NULL, "ui_efh_gameseed", "0", CVAR_ARCHIVE },
	{ NULL, "ui_efh_noItems", "1", CVAR_ARCHIVE },
	{ NULL, "ui_efh_noHealthRegen", "1", CVAR_ARCHIVE },
	{ NULL, "ui_efh_challengingEnv", "1", CVAR_ARCHIVE },
	{ NULL, "ui_efh_monsterLoad", "30", CVAR_ARCHIVE },
	{ NULL, "ui_efh_monsterGuards", "10", CVAR_ARCHIVE },
	{ NULL, "ui_efh_monsterTitans", "5", CVAR_ARCHIVE },
	{ NULL, "ui_efh_monsterHealthScale", "5", CVAR_ARCHIVE },
	{ NULL, "ui_efh_monsterProgression", "0", CVAR_ARCHIVE },
	{ NULL, "ui_efh_unlimitedAmmo", "0", CVAR_ARCHIVE },	// JUHOX
	{ NULL, "ui_efh_cloakingDevice", "1", CVAR_ARCHIVE },	// JUHOX
	{ NULL, "ui_efh_weaponLimit", "0", CVAR_ARCHIVE },	// JUHOX
	{ NULL, "g_debugEFH", "0", CVAR_SYSTEMINFO | CVAR_INIT },

#if MEETING	// JUHOX: ui cvars used for meeting
	{ NULL, "ui_ffa_meeting", "0", CVAR_ARCHIVE },
	{ NULL, "ui_tourney_meeting", "0", CVAR_ARCHIVE },
	{ NULL, "ui_team_meeting", "0", CVAR_ARCHIVE },
	{ NULL, "ui_ctf_meeting", "0", CVAR_ARCHIVE },
	{ NULL, "ui_stu_meeting", "0", CVAR_ARCHIVE },
	{ NULL, "ui_efh_meeting", "0", CVAR_ARCHIVE },
#endif

	{ &ui_additionalSlots, "ui_additionalSlots", "0", CVAR_ARCHIVE },	// JUHOX
	{ &ui_tss, "tss", "1", CVAR_SERVERINFO | CVAR_ARCHIVE | CVAR_NORESTART },	// JUHOX: just for reference
	{ NULL, "tssSafetyModeAllowed", "1", CVAR_SERVERINFO | CVAR_LATCH | CVAR_ARCHIVE },	// JUHOX: just for reference
	{ &ui_respawnAtPOD, "respawnAtPOD", "0", CVAR_ARCHIVE | CVAR_NORESTART },	// JUHOX: just for reference
	{ &ui_armorFragments, "g_armorFragments", "0", CVAR_ARCHIVE | CVAR_NORESTART },	// JUHOX: just for reference
	{ &ui_stamina, "g_stamina", "0", CVAR_SERVERINFO | CVAR_ARCHIVE | CVAR_NORESTART },	// JUHOX: just for reference
	{ &ui_baseHealth, "g_baseHealth", "300", CVAR_SERVERINFO | CVAR_LATCH | CVAR_ARCHIVE },	// JUHOX: just for reference
	{ &ui_lightningDamageLimit, "g_lightningDamageLimit", "0", CVAR_ARCHIVE | CVAR_SERVERINFO | CVAR_NORESTART },	// JUHOX: just for reference

	{ &ui_arenasFile, "g_arenasFile", "", CVAR_INIT|CVAR_ROM },
	{ &ui_botsFile, "g_botsFile", "", CVAR_INIT|CVAR_ROM },
	{ &ui_spScores1, "g_spScores1", "", CVAR_ARCHIVE | CVAR_ROM },
	{ &ui_spScores2, "g_spScores2", "", CVAR_ARCHIVE | CVAR_ROM },
	{ &ui_spScores3, "g_spScores3", "", CVAR_ARCHIVE | CVAR_ROM },
	{ &ui_spScores4, "g_spScores4", "", CVAR_ARCHIVE | CVAR_ROM },
	{ &ui_spScores5, "g_spScores5", "", CVAR_ARCHIVE | CVAR_ROM },
	{ &ui_spAwards, "g_spAwards", "", CVAR_ARCHIVE | CVAR_ROM },
	{ &ui_spVideos, "g_spVideos", "", CVAR_ARCHIVE | CVAR_ROM },
	{ &ui_spSkill, "g_spSkill", "2", CVAR_ARCHIVE | CVAR_LATCH },
	{ NULL, "g_grapple", "0", CVAR_ARCHIVE | CVAR_SERVERINFO | CVAR_LATCH },	// JUHOX
	{ NULL, "g_gravityLatch", "", CVAR_ROM },	// JUHOX

	{ &ui_spSelection, "ui_spSelection", "", CVAR_ROM },

	{ &ui_browserMaster, "ui_browserMaster", "0", CVAR_ARCHIVE },
	{ &ui_browserGameType, "ui_browserGameType", "0", CVAR_ARCHIVE },
	{ &ui_browserSortKey, "ui_browserSortKey", "4", CVAR_ARCHIVE },
	{ &ui_browserShowFull, "ui_browserShowFull", "1", CVAR_ARCHIVE },
	{ &ui_browserShowEmpty, "ui_browserShowEmpty", "1", CVAR_ARCHIVE },

	{ &ui_brassTime, "cg_brassTime", "2500", CVAR_ARCHIVE },
	{ &ui_drawCrosshair, "cg_drawCrosshair", "4", CVAR_ARCHIVE },
	{ &ui_drawCrosshairNames, "cg_drawCrosshairNames", "1", CVAR_ARCHIVE },
	{ &ui_marks, "cg_marks", "1", CVAR_ARCHIVE },
#if 1	// JUHOX: client cvars referenced by the ui module (only used for registering)
	{ NULL, "cg_autoswitchAmmoLimit", "50", CVAR_ARCHIVE },
	{ NULL, "cg_weaponOrder0", "ICFJDHGLEB", CVAR_ARCHIVE },
	{ NULL, "cg_weaponOrder1", "DCGHLBIFEJ", CVAR_ARCHIVE },
	{ NULL, "cg_weaponOrder2", "FCIDGEJLHB", CVAR_ARCHIVE },
	{ NULL, "cg_weaponOrder3", "JFCEIDHGLB", CVAR_ARCHIVE },
	{ NULL, "cg_weaponOrder4", "HLJCFGIDEB", CVAR_ARCHIVE },
	{ NULL, "cg_weaponOrder5", "LGEJICDFHB", CVAR_ARCHIVE },
	{ NULL, "cg_weaponOrder0Name", "pursuit", CVAR_ARCHIVE },
	{ NULL, "cg_weaponOrder1Name", "close combat", CVAR_ARCHIVE },
	{ NULL, "cg_weaponOrder2Name", "attack", CVAR_ARCHIVE },
	{ NULL, "cg_weaponOrder3Name", "annihilation", CVAR_ARCHIVE },
	{ NULL, "cg_weaponOrder4Name", "revenge", CVAR_ARCHIVE },
	{ NULL, "cg_weaponOrder5Name", "defence", CVAR_ARCHIVE },
	{ NULL, "cg_glassCloaking", "0", CVAR_ARCHIVE},
	{ NULL, "cg_lensFlare", "1", CVAR_ARCHIVE},
	{ NULL, "cg_BFGsuperExpl", "1", CVAR_ARCHIVE},
	{ NULL, "cg_autoGLC", "1", CVAR_ARCHIVE},
	{ NULL, "crouchCutsRope", "1", CVAR_ARCHIVE | CVAR_USERINFO },
#endif
	{ NULL, "tssinit", "0", CVAR_ROM },		// JUHOX
	{ NULL, "tssi_key", "", CVAR_ROM },		// JUHOX
	{ NULL, "tssi_mouse", "", CVAR_ROM },	// JUHOX
	{ NULL, "tmplcmd", "", CVAR_ROM },		// JUHOX
	{ NULL, "tmplfiles", "", CVAR_ROM | CVAR_NORESTART },	// JUHOX
	{ &ui_hiDetailTitle, "ui_hiDetailTitle", "1", CVAR_ARCHIVE },	// JUHOX

	{ &ui_server1, "server1", "", CVAR_ARCHIVE },
	{ &ui_server2, "server2", "", CVAR_ARCHIVE },
	{ &ui_server3, "server3", "", CVAR_ARCHIVE },
	{ &ui_server4, "server4", "", CVAR_ARCHIVE },
	{ &ui_server5, "server5", "", CVAR_ARCHIVE },
	{ &ui_server6, "server6", "", CVAR_ARCHIVE },
	{ &ui_server7, "server7", "", CVAR_ARCHIVE },
	{ &ui_server8, "server8", "", CVAR_ARCHIVE },
	{ &ui_server9, "server9", "", CVAR_ARCHIVE },
	{ &ui_server10, "server10", "", CVAR_ARCHIVE },
	{ &ui_server11, "server11", "", CVAR_ARCHIVE },
	{ &ui_server12, "server12", "", CVAR_ARCHIVE },
	{ &ui_server13, "server13", "", CVAR_ARCHIVE },
	{ &ui_server14, "server14", "", CVAR_ARCHIVE },
	{ &ui_server15, "server15", "", CVAR_ARCHIVE },
	{ &ui_server16, "server16", "", CVAR_ARCHIVE },
	{ NULL, "ui_init", "0", CVAR_ROM },		// JUHOX
	{ NULL, "ui_precache", "1", CVAR_ARCHIVE },	// JUHOX
	{ NULL, "cg_music", "0", CVAR_ARCHIVE },	// JUHOX
	{ NULL, "developer", "0", CVAR_INIT}	// JUHOX
	// SLK @ZARR - this seems your developer issue - might cause problem if called while running. should work from command line tho

};

// bk001129 - made static to avoid aliasing
static int cvarTableSize = sizeof(cvarTable) / sizeof(cvarTable[0]);


/*
=================
UI_RegisterCvars
=================
*/
void UI_RegisterCvars( void ) {
	int			i;
	cvarTable_t	*cv;

	for ( i = 0, cv = cvarTable ; i < cvarTableSize ; i++, cv++ ) {
		trap_Cvar_Register( cv->vmCvar, cv->cvarName, cv->defaultString, cv->cvarFlags );
	}
}

/*
=================
UI_UpdateCvars
=================
*/
void UI_UpdateCvars( void ) {
	int			i;
	cvarTable_t	*cv;

	for ( i = 0, cv = cvarTable ; i < cvarTableSize ; i++, cv++ ) {
		// JUHOX: don't update noset cvars
#if 0
		trap_Cvar_Update( cv->vmCvar );
#else
		if (cv->vmCvar) trap_Cvar_Update(cv->vmCvar);
#endif
	}
}
