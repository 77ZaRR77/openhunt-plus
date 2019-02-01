// Copyright (C) 2001 J. Hoffmann
//
// cg_tss -- client part of the tactical support system
#include "cg_local.h"
#include "../q3_ui/keycodes.h"



#define TSS_KEYCATCHER KEYCATCH_UI

#define TSS_X 48
#define TSS_Y 52
#define TSS_W 544
#define TSS_H 352
#define TSS_MOUSE_FACTOR 2	// the higher the slower

#define TSS_LOWER_OR_EQUAL_CHAR '\x90'
#define TSS_LOWER_OR_EQUAL_STR "\x90"
#define TSS_GREATER_OR_EQUAL_CHAR '\x91'
#define TSS_GREATER_OR_EQUAL_STR "\x91"
#define TSS_UNEQUAL_CHAR '\x92'
#define TSS_UNEQUAL_STR "\x92"

typedef enum {
	TSSBID_RESUMEGAME,
	TSSBID_CALLLEADERVOTE,
	TSSBID_CALLSURRENDERVOTE,
	TSSBID_VOTE_YES,
	TSSBID_VOTE_NO,
	TSSBID_NAVAID_ON,
	TSSBID_NAVAID_OFF,
	TSSBID_GROUPFORMATION_TIGHT,
	TSSBID_GROUPFORMATION_LOOSE,
	TSSBID_GROUPFORMATION_FREE,
	TSSBID_SAFETYMODE,
	TSSBID_CREATE_STRATEGY,
	TSSBID_DUPLICATE_STRATEGY,
	TSSBID_UTILIZE_STRATEGY,
	TSSBID_REMOVE_STRATEGY,
	TSSBID_CANCEL,
	TSSBID_APPLY,
	TSSBID_INSERT_DIRECTIVE,
	TSSBID_DELETE_DIRECTIVE,
	TSSBID_CLEAR_DIRECTIVE,
	TSSBID_COPY_DIRECTIVE,
	TSSBID_PASTE_DIRECTIVE,
	TSSBID_SEARCH_SELECTED,
	TSSBID_JOIN_RED,
	TSSBID_JOIN_BLUE,
	TSSBID_AUTOGLC_ON,
	TSSBID_AUTOGLC_OFF,

	TSSBID_ADD_STRATEGY = 10000	// + stock position
} tss_button_id_t;
#define TSS_BUTTON ((int*)1)
#define TSS_SIMPLE_TEXT ((const char* const*)1)

#define TSS_STOCK_WINDOW_SIZE 13





static int selectedStrategyScrollOffset;
static int lastKey;	// to identify repeated keys
static int altKey;
static char searchIDBuf[4];
static char searchNameBuf[TSS_NAME_SIZE];




/*
=================
TSS_MemCmp
=================
*/
static qboolean TSS_MemCmp(const void* m1, const void* m2, int size) {
	while (size-- > 0) {
		if (((const char*)m1)[size] != ((const char*)m2)[size]) return qtrue;
	}
	return qfalse;
}

/*
=================
TSS_StdClearDirective
=================
*/
static void TSS_StdClearDirective(tss_directive_t* directive) {
	int i;

	if (!directive) return;

	memset(directive, 0, sizeof(*directive));
	directive->instr.division.unassignedPlayers = 100;
	for (i = 0; i < MAX_GROUPS; i++) {
		directive->instr.groupOrganization[i] = i;
		directive->instr.division.group[i].minReadyMembers = 100;
		directive->instr.orders.order[i].maxDanger = 25;
	}
}

/*
=================
TSS_ClearDirective
=================
*/
static void TSS_ClearDirective(tss_strategy_t* strategy, int d) {
	tss_directive_t* directive;

	if (d < 0 || d > TSS_NON_DEFAULT_DIRECTIVES_PER_STRATEGY) return;
	directive = &strategy->directives[d];

	TSS_StdClearDirective(directive);
	if (d == 0) {
		strcpy(directive->name, "default");
	}
}

/*
=================
TSS_PaletteSlotID
=================
*/
static int TSS_PaletteSlotID(tss_strategyPaletteSlot_t* pslot) {
	if (!pslot) return -1;
	if (!pslot->slot) return -1;
	return pslot->slot->id;
}

/*
=================
TSS_GetSlotAtStockPos
=================
*/
static tss_strategySlot_t* TSS_GetSlotAtStockPos(int pos) {
	pos -= cg.tssStrategyStockScrollOffset;
	return CG_TSS_GetSortedSlot(pos, cg.tssStrategyStockSortOrder);
}

/*
=================
TSS_SetStockWindow
=================
*/
static int TSS_SetStockWindow(int pos, int index) {
	int numStrategies;
	int start;

	numStrategies = CG_TSS_NumStrategiesInStock(cg.tssStrategyStockSortOrder);

	index -= pos;
	start = index;

	if (start + TSS_STOCK_WINDOW_SIZE > numStrategies) {
		start = numStrategies - TSS_STOCK_WINDOW_SIZE;
	}
	if (start < 0) {
		start = 0;
	}

	pos += index - start;
	cg.tssStrategyStockScrollOffset = -start;
	return pos;
}

/*
=================
TSS_SelectStrategy
=================
*/
static void TSS_SelectStrategy(tss_strategyPaletteSlot_t* pslot) {
	if (cg.tssSelectedStrategy && cg.tssStrategyWorkCopyChanged) {
		memcpy(cg.tssSelectedStrategy->strategy, &cg.tssStrategyWorkCopy, sizeof(tss_strategy_t));
		cg.tssSelectedStrategy->isChanged = qtrue;
		cg.tssSavingNeeded = qtrue;
		cg.tssStrategyWorkCopyChanged = qfalse;
	}
	if (pslot && pslot != cg.tssSelectedStrategy) {
		memcpy(&cg.tssStrategyWorkCopy, pslot->strategy, sizeof(tss_strategy_t));
		cg.tssStrategyWorkCopyChanged = qfalse;
	}
	cg.tssSelectedStrategy = pslot;
}

/*
=================
TSS_ApplyChanges
=================
*/
static void TSS_ApplyChanges(void) {
	tss_strategyPaletteSlot_t* pslot;

	pslot = cg.tssSelectedStrategy;
	TSS_SelectStrategy(NULL);
	CG_TSS_SavePaletteSlotIfNeeded(pslot);	// this may change the strategy->name field
	TSS_SelectStrategy(pslot);
}

/*
=================
TSS_CancelChanges
=================
*/
static void TSS_CancelChanges(void) {
	tss_strategyPaletteSlot_t* pslot;

	pslot = cg.tssSelectedStrategy;
	cg.tssSelectedStrategy = NULL;
	TSS_SelectStrategy(pslot);
}

/*
=================
TSS_PaletteSlotIndex
=================
*/
static int TSS_PaletteSlotIndex(tss_strategyPaletteSlot_t* pslot) {
	int index;

	if (!pslot) return -1;
	if (pslot < cg.tssPalette.slots) return -1;

	index = pslot - cg.tssPalette.slots;
	if (index >= cg.tssPalette.numEntries) return -1;

	return index;
}

/*
=================
TSS_SearchPaletteSlotIndex
=================
*/
static int TSS_SearchPaletteSlotIndex(tss_strategySlot_t* sslot) {
	int i;

	for (i = 0; i < cg.tssPalette.numEntries; i++) {
		if (cg.tssPalette.slots[i].slot == sslot) return i;
	}
	return -1;
}

/*
=================
TSS_AddToPalette
=================
*/
static int TSS_AddToPalette(tss_strategySlot_t* sslot) {
	tss_strategyPaletteSlot_t* pslot;
	int index;

	if (!sslot) return -1;
	if (cg.tssPalette.numEntries >= TSS_MAX_STRATEGIES_PER_PALETTE) return -1;

	index = TSS_SearchPaletteSlotIndex(sslot);
	if (index >= 0) {
		pslot = &cg.tssPalette.slots[index];
		goto SelectSlot;
	}

	index = cg.tssPalette.numEntries;
	pslot = &cg.tssPalette.slots[index];
	if (!CG_TSS_LoadPaletteSlot(sslot, pslot)) return -1;

	cg.tssPalette.numEntries++;

	if (!cg.tssUtilizedStrategy) {
		cg.tssUtilizedStrategy = pslot;
	}

	SelectSlot:
	TSS_SelectStrategy(pslot);
	return index;
}

/*
=================
TSS_RemoveFromPalette
=================
*/
static void TSS_RemoveFromPalette(tss_strategyPaletteSlot_t* pslot) {
	int index;
	int selected;
	int i;

	index = TSS_PaletteSlotIndex(pslot);
	if (index < 0) return;

	i = TSS_PaletteSlotIndex(cg.tssUtilizedStrategy);
	if (i == index) {
		cg.tssUtilizedStrategy = NULL;
	}
	else if (i > index) {
		cg.tssUtilizedStrategy--;
	}

	selected = TSS_PaletteSlotIndex(cg.tssSelectedStrategy);
	if (selected >= index) {
		if (selected >= cg.tssPalette.numEntries - 1 || selected > index) {
			selected--;
		}
	}
	TSS_SelectStrategy(NULL);

	CG_TSS_FreePaletteSlot(pslot);

	for (i = index + 1; i < cg.tssPalette.numEntries; i++) {
		// copy from 'i' to 'i-1'
		memcpy(&cg.tssPalette.slots[i - 1], &cg.tssPalette.slots[i], sizeof(tss_strategyPaletteSlot_t));
	}
	cg.tssPalette.numEntries--;

	if (selected >= 0) {
		TSS_SelectStrategy(&cg.tssPalette.slots[selected]);
	}
}

/*
=================
TSS_GetPalette
=================
*/
void TSS_GetPalette(tss_savedPalette_t* palette) {
	int i;

	memset(palette, 0, sizeof(*palette));

	palette->utilizedStrategy = TSS_PaletteSlotID(cg.tssUtilizedStrategy);
	palette->selectedStrategy = TSS_PaletteSlotID(cg.tssSelectedStrategy);
	palette->numEntries = cg.tssPalette.numEntries;
	for (i = 0; i < palette->numEntries; i++) {
		palette->palette[i] = TSS_PaletteSlotID(&cg.tssPalette.slots[i]);
	}
}

/*
=================
TSS_SavePalette
=================
*/
#if !TSSINCVAR
static void TSS_SavePalette(void) {
	static tss_savedPalette_t savedPalette;
	int i;
	const char* filename;
	fileHandle_t f;

	TSS_GetPalette(&savedPalette);

	switch (cg.tssGametype) {
	case GT_TEAM:
		filename = "tss/tdm/" TSS_PALETTE_FILE;
		break;
	case GT_CTF:
		filename = "tss/ctf/" TSS_PALETTE_FILE;
		break;
	default:
		return;
	}
	trap_FS_FOpenFile(filename, &f, FS_WRITE);
	if (f) {
		trap_FS_Write(&savedPalette, sizeof(savedPalette), f);
		trap_FS_FCloseFile(f);
	}
}
#endif

/*
=================
TSS_SetPalette
=================
*/
void TSS_SetPalette(const tss_savedPalette_t* palette) {
	int i;

	for (i = 0; i < palette->numEntries; i++) {
		TSS_AddToPalette(CG_TSS_GetSlotByID(palette->palette[i]));
	}

	if (palette->utilizedStrategy >= 0) {
		TSS_AddToPalette(CG_TSS_GetSlotByID(palette->utilizedStrategy));
		cg.tssUtilizedStrategy = cg.tssSelectedStrategy;
	}

	TSS_AddToPalette(CG_TSS_GetSlotByID(palette->selectedStrategy));
}

/*
=================
TSS_LoadPalette
=================
*/
#if !TSSINCVAR
static qboolean TSS_LoadPalette(void) {
	tss_savedPalette_t savedPalette;
	const char* filename;
	fileHandle_t f;
	int len;
	int i;

	switch (cg.tssGametype) {
	case GT_TEAM:
		filename = "tss/tdm/" TSS_PALETTE_FILE;
		break;
	case GT_CTF:
		filename = "tss/ctf/" TSS_PALETTE_FILE;
		break;
	default:
		return qfalse;
	}
	len = trap_FS_FOpenFile(filename, &f, FS_READ);
	if (!f) return qfalse;
	if (len != sizeof(savedPalette)) return qfalse;

	trap_FS_Read(&savedPalette, sizeof(savedPalette), f);
	trap_FS_FCloseFile(f);

	TSS_SetPalette(&savedPalette);
	return qtrue;
}
#endif

/*
=================
CG_TSS_InitInterface
=================
*/
void CG_TSS_InitInterface(void) {
	int i;

	lastKey = -1;
	altKey = 0;

	cg.tssOnline = qfalse;
	cg.tssUtilizedStrategy = NULL;
	cg.tssSelectedStrategy = NULL;
	cg.tssPalette.numEntries = 0;
	cg.tssStrategyStockScrollOffset = 0;
	cg.tssStrategyStockSortOrder = SSO_accessTime;
	cg.tssDivisionMode = DM_percentage;
#if !TSSINCVAR
	{
		char buf[16];

		trap_Cvar_VariableStringBuffer("sv_pure", buf, sizeof(buf));
		cg.tssPureServer = atoi(buf);
	}
#endif

	for (i = 0; i < MAX_GROUPS; i++) {
		cg.tssGroupLeader[0][i] = -1;	// '---'
		cg.tssGroupLeader[1][i] = -1;
		cg.tssGroupLeader[2][i] = -1;
		cg.tssCurrentLeader[i] = -1;
	}

	TSS_StdClearDirective(&cg.tssDirectiveClipboard);
}

/*
=================
CG_TSS_LoadInterface
=================
*/
void CG_TSS_LoadInterface(void) {
#if !TSSINCVAR
	if (cg.tssPureServer) return;
#endif
	if (cgs.gametype < GT_TEAM) return;

	switch (cgs.gametype) {
	case GT_TEAM:
	//case GT_STU:
		cg.tssGametype = GT_TEAM;
		break;
	case GT_CTF:
		cg.tssGametype = GT_CTF;
		break;
	default:
		cg.tssGametype = -1;
		return;
	}

#if !TSSINCVAR
	CG_TSS_LoadStrategyStock();
	TSS_LoadPalette();
#else
	TSSFS_LoadStrategyStock();
#endif
	if (!cg.tssSelectedStrategy) {
		if (
			TSS_AddToPalette(
				CG_TSS_GetSlotByName(
					cg.tssGametype == GT_CTF? "juhox powerpliers" : "juhox crowd"
				)
			) < 0
		) {
			TSS_AddToPalette(CG_TSS_GetSortedSlot(0, SSO_accessTime));
		}
	}
}

/*
=================
CG_TSS_SaveInterface
=================
*/
void CG_TSS_SaveInterface(void) {
#if !TSSINCVAR
	int i;

	if (cg.tssPureServer) return;
	if (cgs.gametype < GT_TEAM) return;
	if (CG_TSS_NumStrategiesInStock(SSO_creationTime) <= 0) return;

	TSS_SavePalette();
	TSS_SelectStrategy(NULL);
	for (i = 0; i < cg.tssPalette.numEntries; i++) {
		CG_TSS_FreePaletteSlot(&cg.tssPalette.slots[i]);
	}
	CG_TSS_SaveStrategyStock();
#endif
}

/*
=================
TSS_SaveInterfaceIfNeeded
=================
*/
#if TSSINCVAR
static void TSS_SaveInterfaceIfNeeded(void) {
	int i;

	if (!cg.tssSavingNeeded) return;
	if (cgs.gametype < GT_TEAM) return;
	if (CG_TSS_NumStrategiesInStock(SSO_creationTime) <= 0) return;

	for (i = 0; i < cg.tssPalette.numEntries; i++) {
		CG_TSS_SavePaletteSlotIfNeeded(&cg.tssPalette.slots[i]);
	}
	TSSFS_SaveStrategyStock();
	cg.tssSavingNeeded = qfalse;
}
#endif

/*
=================
TSS_RemapFlagStatus
=================
*/
static tss_flagStatus_t TSS_RemapFlagStatus(int quakeFlagStatus) {
	switch (quakeFlagStatus) {
		case 0:
			return TSSFS_atBase;
		case 1:
			return TSSFS_taken;
		case 2:
			return TSSFS_dropped;
	}
	return 0;
}

/*
=================
TSS_UpdateTacticalMeasures
=================
*/
static void TSS_UpdateTacticalMeasures(void) {
	int i;
	int* var;

	cg.tssNumTeamMates = 0;
	cg.tssNumTeamMatesAlive = 0;
	cg.tssNumEnemies = 0;
	cg.tssNumEnemiesAlive = 0;

	for (i = 0; i < MAX_CLIENTS; i++) {
		if (!cgs.clientinfo[i].infoValid) continue;
		if (cgs.clientinfo[i].team != cgs.clientinfo[cg.clientNum].team) {
			cg.tssNumEnemies++;
			if (cgs.clientinfo[i].health > 0) cg.tssNumEnemiesAlive++;
			continue;
		}

		if (cgs.clientinfo[i].health > 0) cg.tssNumTeamMatesAlive++;

		cg.tssNumTeamMates++;
	}

	if (
		cgs.clientinfo[cg.clientNum].teamLeader &&
		cg.snap->ps.stats[STAT_HEALTH] > 0 &&
		cg.snap->ps.pm_type == PM_SPECTATOR
	) {
		// mission leader in safety mode
		cg.tssNumTeamMates--;
		cg.tssNumTeamMatesAlive--;
	}

	if (cgs.gametype < GT_TEAM) return;

	var = cg.tssMeasures.var;
	var[TSSTM_YTS] = cg.tssNumTeamMates;
	var[TSSTM_OTS] = cg.tssNumEnemies;
	var[TSSTM_BTS] = var[TSSTM_YTS] - var[TSSTM_OTS];
	var[TSSTM_RSPD] = cg.tssRespawnDelay;
	var[TSSTM_YAQ] = cg.tssNumTeamMatesAlive;
	var[TSSTM_OAQ] = cg.tssNumEnemiesAlive;
	var[TSSTM_YAP] = BG_TSS_Proportion(var[TSSTM_YAQ], var[TSSTM_YTS], 100);
	var[TSSTM_OAP] = BG_TSS_Proportion(var[TSSTM_OAQ], var[TSSTM_OTS], 100);
	var[TSSTM_BAQ] = var[TSSTM_YAQ] - var[TSSTM_OAQ];
	var[TSSTM_BAP] = var[TSSTM_YAP] - var[TSSTM_OAP];
	var[TSSTM_YAMQ] = (int) (cg.tssYAMQ + 0.5);
	var[TSSTM_YALQ] = (int) (cg.tssYALQ + 0.5);
	var[TSSTM_OAMQ] = (int) (cg.tssOAMQ + 0.5);
	var[TSSTM_OALQ] = (int) (cg.tssOALQ + 0.5);
	var[TSSTM_YAMP] = (int) (100 * cg.tssYAMQ / var[TSSTM_YTS] + 0.5);
	var[TSSTM_YALP] = (int) (100 * cg.tssYALQ / var[TSSTM_YTS] + 0.5);
	var[TSSTM_OAMP] = (int) (100 * cg.tssOAMQ / var[TSSTM_OTS] + 0.5);
	var[TSSTM_OALP] = (int) (100 * cg.tssOALQ / var[TSSTM_OTS] + 0.5);
	var[TSSTM_BAMQ] = (int) (cg.tssYAMQ - cg.tssOAMQ + 0.5);
	var[TSSTM_BALQ] = (int) (cg.tssYALQ - cg.tssOALQ + 0.5);
	var[TSSTM_BAMP] = var[TSSTM_YAMP] - var[TSSTM_OAMP];
	var[TSSTM_BALP] = var[TSSTM_YALP] - var[TSSTM_OALP];
	var[TSSTM_BAMT] = (int) (100 * (cg.tssYAMQ - cg.tssOAMQ - var[TSSTM_BAQ]) / (var[TSSTM_YTS] + var[TSSTM_OTS]) + 0.5);
	var[TSSTM_BALT] = (int) (100 * (cg.tssYALQ - cg.tssOALQ - var[TSSTM_BAQ]) / (var[TSSTM_YTS] + var[TSSTM_OTS]) + 0.5);
	i = cg.tssGametype == GT_CTF? cgs.capturelimit : cgs.fraglimit;
	if (cgs.gametype == GT_STU) i = cgs.artefacts;

	if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE) {
		var[TSSTM_SCB] = cgs.scores2 - cgs.scores1;
		var[TSSTM_YFS] = TSS_RemapFlagStatus(cgs.blueflag);
		var[TSSTM_OFS] = TSS_RemapFlagStatus(cgs.redflag);
		if (i) {
			var[TSSTM_YRS] = i - cgs.scores2;
			var[TSSTM_ORS] = i - cgs.scores1;
		}
	}
	else {
		var[TSSTM_SCB] = cgs.scores1 - cgs.scores2;
		var[TSSTM_YFS] = TSS_RemapFlagStatus(cgs.redflag);
		var[TSSTM_OFS] = TSS_RemapFlagStatus(cgs.blueflag);
		if (i) {
			var[TSSTM_YRS] = i - cgs.scores1;
			var[TSSTM_ORS] = i - cgs.scores2;
		}
	}
	if (i) {
		if (var[TSSTM_YRS] > 100) var[TSSTM_YRS] = 100;
		if (var[TSSTM_ORS] > 100) var[TSSTM_ORS] = 100;
	}
	else {
		var[TSSTM_YRS] = 999;
		var[TSSTM_ORS] = 999;
	}
	var[TSSTM_RFAQ] = cg.tssRFAQ;
	var[TSSTM_RFDQ] = cg.tssRFDQ;
	var[TSSTM_RFAP] = BG_TSS_Proportion(var[TSSTM_RFAQ], var[TSSTM_YTS], 100);
	var[TSSTM_RFDP] = BG_TSS_Proportion(var[TSSTM_RFDQ], var[TSSTM_YTS], 100);
	var[TSSTM_FIN] = cg.tssFightIntensity;
	var[TSSTM_TIDY] = cg.tssTidiness;
	var[TSSTM_AVST] = cg.tssAvgStamina;
	if (cgs.timelimit) {
		var[TSSTM_TIME] = (cgs.timelimit - (cg.time - cgs.levelStartTime)) / 60000;
	}
	else {
		var[TSSTM_TIME] = 999;
	}
	var[TSSTM_YFP] = cg.tssYFP;
	var[TSSTM_OFP] = cg.tssOFP;
}

/*
=================
CG_TSS_UpdateInterface
=================
*/
static void CG_TSS_UpdateInterface(void) {
	int i, n;
	char buf[MAX_QPATH];

	if (cg.tssLastUpdate + 250 > cg.time || !cg.snap) {
		return;
	}
	cg.tssLastUpdate = cg.time;

	if (BG_TSS_GetPlayerInfo(&cg.snap->ps, TSSPI_isValid)) {
		cg.tssActivated = qtrue;
		cg.tssNavAid = BG_TSS_GetPlayerInfo(&cg.snap->ps, TSSPI_navAid);
		cg.tssGroupLeaderAuthorization = (BG_TSS_GetPlayerInfo(&cg.snap->ps, TSSPI_groupMemberStatus) <= TSSGMS_temporaryLeader);
		cg.tssGroupFormation = BG_TSS_GetPlayerInfo(&cg.snap->ps, TSSPI_groupFormation);
	}
	else {
		cg.tssActivated = qfalse;
		cg.tssNavAid = qfalse;
		cg.tssGroupLeaderAuthorization = qfalse;
		cg.tssGroupFormation = -1;
	}

	if (!cg.tssActivated && !cg.tssOnline) {
		memset(cg.tssCurrentLeader, -1, sizeof(cg.tssCurrentLeader));
		memset(cg.tssCurrentTotal, 0, sizeof(cg.tssCurrentTotal));
		memset(cg.tssCurrentAlive, 0, sizeof(cg.tssCurrentAlive));
		memset(cg.tssCurrentReady, 0, sizeof(cg.tssCurrentReady));
	}

	strcpy(cg.tssTeamLeaderName, "---");

	n = 0;
	for (i = 0; i < MAX_CLIENTS; i++) {
		if (!cgs.clientinfo[i].infoValid) continue;
		if (cgs.clientinfo[i].team != cgs.clientinfo[cg.clientNum].team) {
			continue;
		}

		cg.tssTeamMateList[n] = &cg.tssTeamMateNames[n][0];
		cg.tssTeamMatesClientNum[n] = i;

		Q_strncpyz(buf, cgs.clientinfo[i].name, sizeof(buf));
		Q_CleanStr(buf);
		Q_strncpyz(cg.tssTeamMateNames[n], buf, 16);

		if (cgs.clientinfo[i].teamLeader) {
			strcpy(cg.tssTeamLeaderName, cg.tssTeamMateList[n]);
		}

		n++;
	}

	TSS_UpdateTacticalMeasures();

	if (cgs.gametype < GT_TEAM) return;

	// Ouch! The array addressing below is really a fast, dirty hack!
	for (i = 0; i < 3 * MAX_GROUPS; i++) {
		int j;

		cg.tssMultiMandate[0][i] = qfalse;
		if (cg.tssGroupLeader[0][i] < 0) continue;

		for (j = i + 1; j < 3 * MAX_GROUPS; j++) {
			if (cg.tssGroupLeader[0][i] == cg.tssGroupLeader[0][j]) {
				cg.tssMultiMandate[0][i] = qtrue;
				cg.tssMultiMandate[0][j] = qtrue;
			}
		}
	}
}


/*
=================
TSS_CreateStrategy
=================
*/
static void TSS_CreateStrategy(void) {
	tss_strategyPaletteSlot_t* pslot;

	if (cg.tssPalette.numEntries >= TSS_MAX_STRATEGIES_PER_PALETTE) return;

	pslot = &cg.tssPalette.slots[cg.tssPalette.numEntries];
	if (!CG_TSS_CreateNewStrategy(pslot)) return;

	cg.tssPalette.numEntries++;
	TSS_SelectStrategy(pslot);

	TSS_SetStockWindow(0, CG_TSS_GetSortIndexByID(pslot->slot->id, cg.tssStrategyStockSortOrder));
	Com_sprintf(searchIDBuf, sizeof(searchIDBuf), "%d", pslot->slot->id);
}

/*
=================
TSS_DuplicateStrategy
=================
*/
static void TSS_DuplicateStrategy(void) {
	tss_strategyPaletteSlot_t* original;

	if (!cg.tssSelectedStrategy) return;

	original = cg.tssSelectedStrategy;
	TSS_CreateStrategy();
	if (cg.tssSelectedStrategy && cg.tssSelectedStrategy != original) {
		int sortIndex;

		strcpy(cg.tssSelectedStrategy->slot->tssname, original->slot->tssname);
		sortIndex = CG_TSS_GetSortIndexByID(cg.tssSelectedStrategy->slot->id, cg.tssStrategyStockSortOrder);
		sortIndex = CG_TSS_StrategyNameChanged(sortIndex, cg.tssStrategyStockSortOrder);
		TSS_SetStockWindow(0, sortIndex);

		memcpy(cg.tssSelectedStrategy->strategy, original->strategy, sizeof(tss_strategy_t));
		TSS_CancelChanges();	// update work copy
	}
}

/*
=================
TSS_InsertDirective
=================
*/
static void TSS_InsertDirective(tss_strategy_t* strategy, int d) {
	if (!strategy) return;
	if (d <= 0 || d > TSS_NON_DEFAULT_DIRECTIVES_PER_STRATEGY) return;

	memmove(
		&strategy->directives[d+1], &strategy->directives[d],
		sizeof(tss_directive_t) * (TSS_NON_DEFAULT_DIRECTIVES_PER_STRATEGY - d)
	);
	TSS_ClearDirective(strategy, d);
}

/*
=================
TSS_DeleteDirective
=================
*/
static void TSS_DeleteDirective(tss_strategy_t* strategy, int d) {
	if (!strategy) return;
	if (d <= 0 || d > TSS_NON_DEFAULT_DIRECTIVES_PER_STRATEGY) return;

	memmove(
		&strategy->directives[d], &strategy->directives[d+1],
		sizeof(tss_directive_t) * (TSS_NON_DEFAULT_DIRECTIVES_PER_STRATEGY - d)
	);
	TSS_ClearDirective(strategy, TSS_NON_DEFAULT_DIRECTIVES_PER_STRATEGY);
}

/*
=================
TSS_EvalPredicate
=================
*/
static qboolean TSS_EvalPredicate(tss_tacticalPredicate_t* predicate, tss_tacticalMeasures_t* measures) {
	if (predicate->magnitude == TSSTM_no) return qtrue;

	switch (predicate->op) {
	case TSSPROP_varLowerThanLimit:
		return measures->var[predicate->magnitude] < predicate->limit;
	case TSSPROP_varLowerThanOrEqualToLimit:
		return measures->var[predicate->magnitude] <= predicate->limit;
	case TSSPROP_varHigherThanOrEqualToLimit:
		return measures->var[predicate->magnitude] >= predicate->limit;
	case TSSPROP_varHigherThanLimit:
		return measures->var[predicate->magnitude] > predicate->limit;
	case TSSPROP_varEqualToLimit:
		return measures->var[predicate->magnitude] == predicate->limit;
	case TSSPROP_varUnequalToLimit:
		return measures->var[predicate->magnitude] != predicate->limit;
	default:	// should not happen
		return qfalse;
	}
}

/*
=================
TSS_EvalClause
=================
*/
static qboolean TSS_EvalClause(tss_clause_t* clause, tss_tacticalMeasures_t* measures) {
	int i;

	if (!clause->inUse) return qfalse;

	for (i = 0; i < TSS_PREDICATES_PER_CLAUSE; i++) {
		if (!TSS_EvalPredicate(&clause->predicate[i], measures)) return qfalse;
	}
	return qtrue;
}

/*
=================
TSS_EvalOccasion
=================
*/
static qboolean TSS_EvalOccasion(tss_occasion_t* occasion, tss_tacticalMeasures_t* measures) {
	int i;

	for (i = 0; i < TSS_CLAUSES_PER_OCCASION; i++) {
		if (TSS_EvalClause(&occasion->clause[i], measures)) return qtrue;
	}
	return qfalse;
}

/*
=================
TSS_DetermineCondition
=================
*/
static int TSS_DetermineCondition(tss_strategy_t* strategy, tss_tacticalMeasures_t* measures) {
	int i;

	for (i = 1; i <= TSS_NON_DEFAULT_DIRECTIVES_PER_STRATEGY; i++) {
		tss_directive_t* directive;

		directive = &strategy->directives[i];
		if (!directive->inUse) continue;

		if (!TSS_EvalOccasion(&directive->occasion, measures)) continue;
		return i;
	}
	return 0;
}

/*
=================
CG_TSS_Update
=================
*/
void CG_TSS_Update(void) {
	TSS_UpdateTacticalMeasures();

	if (cg.tssUtilizedStrategy && cg.tssUtilizedStrategy->strategy->autoCondition) {
		cg.tssUtilizedStrategy->condition = TSS_DetermineCondition(
			cg.tssUtilizedStrategy->strategy, &cg.tssMeasures
		);
	}
}

/*
=================
CG_TSS_Print
=================
*/
static void CG_TSS_Print(const char* text, float* color) {
	if (!text) return;

	while (*text) {
		int x, y;
		char buf[2];

		switch (*text) {
		case '\n':
			if (cg.tssCursorLine == cg.tssPrintLine) {
				if (cg.tssPrintCol >= TSS_W / SMALLCHAR_WIDTH) {
					cg.tssPrintCol = TSS_W / SMALLCHAR_WIDTH - 1;
				}
				cg.tssCursorLineEnd = cg.tssPrintCol;
			}
			cg.tssPrintCol = 0;
			cg.tssPrintLine++;
			break;
		case TSS_LOWER_OR_EQUAL_CHAR:
			CG_TSS_Print("<", color);
			cg.tssPrintCol--;
			CG_TSS_Print("\x08", color);
			break;
		case TSS_GREATER_OR_EQUAL_CHAR:
			CG_TSS_Print(">", color);
			cg.tssPrintCol--;
			CG_TSS_Print("\x08", color);
			break;
		case TSS_UNEQUAL_CHAR:
			CG_TSS_Print("=", color);
			cg.tssPrintCol--;
			CG_TSS_Print("/", color);
			break;
		default:
			x = TSS_X + SMALLCHAR_WIDTH * cg.tssPrintCol;
			y = TSS_Y + SMALLCHAR_HEIGHT * cg.tssPrintLine;
			buf[0] = *text;
			buf[1] = 0;
			if (color) {
				CG_DrawSmallStringColor(x, y, buf, color);
			}
			else {
				static vec4_t normalColor = {0.5, 0.5, 0.5, 1};

				CG_DrawSmallStringColor(x, y, buf, normalColor);
			}
			cg.tssPrintCol++;
		}
		text++;
	}
}

/*
=================
TSS_Print
=================
*/
static void TSS_Print(const char* text) {
	CG_TSS_Print(text, NULL);
}

/*
=================
TSS_FillLine
=================
*/
static void TSS_FillLine(char c) {
	char buf[2];
	const int end = TSS_W / SMALLCHAR_WIDTH;

	buf[0] = c;
	buf[1] = 0;

	while (cg.tssPrintCol < end) {
		TSS_Print(buf);
	}
	TSS_Print("\n");
}

/*
=================
CG_TSS_MapStr
=================
*/
static const char* CG_TSS_MapStr(
	int par, int parmin,
	const char* const* translationTable1,		// may be NULL if parmin >= 0
	const char* const* translationTable2		// may be NULL
) {
	const char* str;

	str = NULL;
	if (translationTable2 == TSS_SIMPLE_TEXT) {
		str = (const char*) translationTable1;
	}
	else if (par < 0 || !translationTable2) {
		if (translationTable1) str = translationTable1[par - parmin];
	}
	else {
		str = translationTable2[par];
	}

	if (!str) str = "";
	return str;
}

static float cursorC;
static qboolean parameterInUse = qtrue;
static qboolean* parameterChangeNotifier = NULL;
static qboolean* textParameterChangeNotifier = NULL;
static qboolean parameterReversedHome = qfalse;

/*
=================
CG_TSS_Parameter
=================
*/
static qboolean CG_TSS_Parameter(
	int* parameter, int parmin, int parmax,
	const char* const* translationTable1,
	const char* const* translationTable2,
	int width
) {
	vec4_t color;
	int buttonID;
	char* textField;
	char buf[128];
	qboolean isActive;

	isActive =qfalse;
	if (width > 127) width = 127;

	textField = NULL;
	if (parameter == TSS_BUTTON) {
		static int dummyParameter;

		parameter = &dummyParameter;
		buttonID = parmin;
		parmin = 0;
		parmax = 0;
	}
	else {
		buttonID = -1;
		if (parmin > parmax) {
			textField = (char*) parameter;
			parameter = NULL;
			parmin = 0;
			parmax = 0;
			if (width <= 0) width = TSS_NAME_SIZE;
		}
	}

	if (width <= 0) {
		if (translationTable1 || translationTable2) {
			if (width == 0) {
				int i;

				for (i = parmin; i <= parmax; i++) {
					int size;

					size = strlen(CG_TSS_MapStr(i, parmin, translationTable1, translationTable2));
					if (size > width) width = size;
				}
			}
			else {
				width = strlen(CG_TSS_MapStr(*parameter, parmin, translationTable1, translationTable2));
			}
		}
		else {
			if (abs(parmin) < 10 && abs(parmax) < 10) {
				width = 1;
			}
			else if (abs(parmin) < 100 && abs(parmax) < 100) {
				width = 2;
			}
			else {
				width = 3;
			}
			if (parmin < 0) width++;
		}
	}

	// draw button background
	if (buttonID >= 0) {
		color[0] = 1;
		color[1] = 1;
		color[2] = 1;
		color[3] = 0.17;
		CG_FillRect(
			TSS_X + SMALLCHAR_WIDTH*cg.tssPrintCol,
			TSS_Y + SMALLCHAR_HEIGHT*cg.tssPrintLine + 1,
			SMALLCHAR_WIDTH * width, SMALLCHAR_HEIGHT - 1,
			color
		);
	}
	// draw text field background
	if (textField) {
		color[0] = 0;
		color[1] = 0;
		color[2] = 0;
		color[3] = 0.3;
		CG_FillRect(
			TSS_X + SMALLCHAR_WIDTH*cg.tssPrintCol,
			TSS_Y + SMALLCHAR_HEIGHT*cg.tssPrintLine + 1,
			SMALLCHAR_WIDTH * width, SMALLCHAR_HEIGHT - 1,
			color
		);
	}
	if (buttonID >= 0 || textField) {
		// redraw cursor if needed
		if (
			cg.tssPrintLine == cg.tssCursorLine &&
			cg.tssCursorCol >= cg.tssPrintCol &&
			cg.tssCursorCol < cg.tssPrintCol + width
		) {
			color[0] = cursorC;
			color[1] = cursorC;
			color[2] = cursorC;
			color[3] = 1;
			CG_FillRect(
				TSS_X + SMALLCHAR_WIDTH * cg.tssCursorCol,
				TSS_Y + SMALLCHAR_HEIGHT * cg.tssCursorLine,
				SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT,
				color
			);
		}
	}

	// determine color and active variable
	color[0] = 1;
	color[1] = 1;
	color[2] = 1;
	color[3] = 1;
	if (!parameterInUse) {
		color[0] = 0.5;
		color[1] = 0.5;
		color[2] = 0.5;
		color[3] = 1;
	}
	else if (
		cg.tssCursorLine == cg.tssPrintLine &&
		cg.tssCursorCol >= cg.tssPrintCol &&
		cg.tssCursorCol < cg.tssPrintCol + width
	) {
		color[0] = 1;
		color[1] = 0.7;
		color[2] = 0;
		color[3] = 1;
		cg.tssCurrentValue = parameter;
		cg.tssCurrentTextField = textField;
		cg.tssCurrentValueMin = parmin;
		cg.tssCurrentValueMax = parmax;
		cg.tssCurrentValueReversedHome = parameterReversedHome;
		cg.tssButtonID = buttonID;
		cg.tssCurrentParStartCol = cg.tssPrintCol;
		cg.tssCurrentParWidth = width;
		cg.tssCurrentValueChanged = parameterChangeNotifier;
		cg.tssCurrentTextFieldChanged = textParameterChangeNotifier;
		isActive = qtrue;
	}

	// determine values needed for TAB-movement
	if (
		parameterInUse &&
		(cg.tssNextValueCol < 0 || cg.tssNextValueLine < 0)
	) {
		if (
			cg.tssCursorLine > cg.tssPrintLine ||
			(
				cg.tssCursorLine == cg.tssPrintLine &&
				cg.tssCursorCol >= cg.tssPrintCol + width
			)
		) {
			cg.tssPrevValueCol = cg.tssPrintCol;
			cg.tssPrevValueLine = cg.tssPrintLine;
		}
		if (
			cg.tssCursorLine < cg.tssPrintLine ||
			(
				cg.tssCursorLine == cg.tssPrintLine &&
				cg.tssCursorCol < cg.tssPrintCol
			)
		) {
			cg.tssNextValueCol = cg.tssPrintCol;
			cg.tssNextValueLine = cg.tssPrintLine;
		}
	}

	if (textField) {
		textField[width-1] = 0;
		CG_TSS_Print(textField, color);
		cg.tssPrintCol += width - strlen(textField);
		goto Exit;
	}

	if (*parameter < parmin) *parameter = parmin;
	if (*parameter > parmax) *parameter = parmax;

	if (translationTable1 || translationTable2) {
		const char* s;

		s = CG_TSS_MapStr(*parameter, parmin, translationTable1, translationTable2);
		// print left adjusted
		CG_TSS_Print(s, color);
		cg.tssPrintCol += width - strlen(s);
	}
	else {
		if (parmin < 0 && *parameter > 0) {
			Com_sprintf(buf, sizeof(buf), "+%d", *parameter);
		}
		else {
			Com_sprintf(buf, sizeof(buf), "%d", *parameter);
		}
		// print right adjusted
		cg.tssPrintCol += width - strlen(buf);
		CG_TSS_Print(buf, color);
	}

	Exit:
	parameterChangeNotifier = NULL;
	textParameterChangeNotifier = NULL;
	parameterInUse = qtrue;
	parameterReversedHome = qfalse;
	return isActive;
}

/*
=================
TSS_Button
=================
*/
static qboolean TSS_Button(int buttonID, const char* name) {
	const char* table;

	table = name;
	return CG_TSS_Parameter(TSS_BUTTON, buttonID, 0, &table, NULL, 0);
}

/*
=================
TSS_NumPar
=================
*/
static qboolean TSS_NumPar(int* parameter, int parmin, int parmax) {
	return CG_TSS_Parameter(parameter, parmin, parmax, NULL, NULL, 0);
}

/*
=================
TSS_BigNumPar
=================
*/
static qboolean TSS_BigNumPar(int* parameter, int parmin, int parmax) {
	return CG_TSS_Parameter(parameter, parmin, parmax, NULL, NULL, 3);
}

/*
=================
TSS_ListPar
=================
*/
static qboolean TSS_ListPar(int* parameter, int parmin, int parmax, const char* const* transTab) {
	return CG_TSS_Parameter(parameter, parmin, parmax, transTab, NULL, 0);
}

/*
=================
TSS_ListParTight
=================
*/
static qboolean TSS_ListParTight(int* parameter, int parmin, int parmax, const char* const* transTab) {
	return CG_TSS_Parameter(parameter, parmin, parmax, transTab, NULL, -1);
}

/*
=================
TSS_TeamListPar
=================
*/
static qboolean TSS_TeamListPar(int* parameter, int parmin, const char* const* transTab) {
	if (!transTab) parmin = 0;
	return CG_TSS_Parameter(parameter, parmin, cg.tssNumTeamMates-1, transTab, cg.tssTeamMateList, 0);
}

/*
=================
TSS_TeamListParTight
=================
*/
static qboolean TSS_TeamListParTight(int* parameter, int parmin, const char* const* transTab) {
	if (!transTab) parmin = 0;
	return CG_TSS_Parameter(parameter, parmin, cg.tssNumTeamMates-1, transTab, cg.tssTeamMateList, -1);
}

/*
=================
TSS_StringWithNumberPar
=================
*/
static qboolean TSS_StringWithNumberPar(int* parameter, int parmin, int parmax, const char* string) {
	return CG_TSS_Parameter(parameter, parmin, parmax, (const char* const*) string, TSS_SIMPLE_TEXT, -1);
}

/*
=================
TSS_TextPar
=================
*/
static qboolean TSS_TextPar(char* textpar, int width) {
	return CG_TSS_Parameter((int*)textpar, 1, 0, NULL, NULL, width);
}

/*
=================
TSS_TextWithNumberPar
=================
*/
static qboolean TSS_TextWithNumberPar(char* textpar, int width, int* numpar, int numparmin, int numparmax) {
	if (TSS_TextPar(textpar, width)) {
		cg.tssCurrentValue = numpar;
		cg.tssCurrentValueMin = numparmin;
		cg.tssCurrentValueMax = numparmax;
		return qtrue;
	}
	return qfalse;
}

/*
=================
TSS_IsTacticalMagnitudeAllowed
=================
*/
static qboolean TSS_IsTacticalMagnitudeAllowed(tss_tacticalMagnitude_t magnitude) {
	if (cg.tssGametype < GT_CTF) {
		switch (magnitude) {
		case TSSTM_YFS:
		case TSSTM_OFS:
		case TSSTM_YFP:
		case TSSTM_OFP:
			return qfalse;
		default:
			break;
		}
	}
	return qtrue;
}

static const char* const tssMagnitudeNames[TSSTM_num_magnitudes] = {
	"----", "YTS ", "OTS ", "BTS ", "RSPD", "YAP ", "YAQ ", "OAP ",
	"OAQ ", "BAP ", "BAQ ", "YAMP", "YAMQ", "OAMP", "OAMQ", "BAMP",
	"BAMQ", "YALP", "YALQ", "OALP", "OALQ", "BALP", "BALQ", "BAMT",
	"BALT", "RFAP", "RFAQ", "RFDP", "RFDQ", "FIN ", "TIDY", "AVST",
	"TIME", "YRS ", "ORS ", "SCB ", "YFS ", "OFS ", "YFP ", "OFP "
};

/*
=================
TSS_TacticalPredicatePar
=================
*/
static void TSS_TacticalPredicatePar(tss_tacticalPredicate_t* predicate) {
	static const char* const opNames[] = {
		"<", TSS_LOWER_OR_EQUAL_STR, TSS_GREATER_OR_EQUAL_STR, ">", "=",
		TSS_UNEQUAL_STR
	};
	static const char* const flagStatusNames[] = {
		"1-bas", "2-dro", "3-tak"
	};
	qboolean inUse;

	if (!TSS_IsTacticalMagnitudeAllowed(predicate->magnitude)) {
		predicate->magnitude = TSSTM_no;
	}

	inUse = parameterInUse;
	TSS_ListPar((int*)&predicate->magnitude, 0, TSSTM_num_magnitudes-1, tssMagnitudeNames);

	switch (predicate->magnitude) {
	case TSSTM_no:
		TSS_Print("------");
		return;
	case TSSTM_YTS:
	case TSSTM_OTS:
	case TSSTM_RSPD:
	case TSSTM_YAQ:
	case TSSTM_OAQ:
	case TSSTM_YAMQ:
	case TSSTM_OAMQ:
	case TSSTM_YALQ:
	case TSSTM_OALQ:
	case TSSTM_RFAQ:
	case TSSTM_RFDQ:
	case TSSTM_TIME:
	case TSSTM_YRS:
	case TSSTM_ORS:
		parameterInUse = inUse;
		TSS_ListPar((int*)&predicate->op, 0, 5, opNames);
		parameterInUse = inUse;
		TSS_NumPar(&predicate->limit, 0, 100);
		TSS_Print("  ");
		break;
	case TSSTM_BTS:
	case TSSTM_BAQ:
	case TSSTM_BAMQ:
	case TSSTM_BALQ:
	case TSSTM_SCB:
		parameterInUse = inUse;
		TSS_ListPar((int*)&predicate->op, 0, 5, opNames);
		parameterInUse = inUse;
		TSS_NumPar(&predicate->limit, -100, 100);
		TSS_Print(" ");
		break;
	case TSSTM_YAP:
	case TSSTM_OAP:
	case TSSTM_YAMP:
	case TSSTM_OAMP:
	case TSSTM_YALP:
	case TSSTM_OALP:
	case TSSTM_RFAP:
	case TSSTM_RFDP:
	case TSSTM_FIN:
	case TSSTM_TIDY:
	case TSSTM_AVST:
		parameterInUse = inUse;
		TSS_ListPar((int*)&predicate->op, 0, 5, opNames);
		parameterInUse = inUse;
		TSS_NumPar(&predicate->limit, 0, 100);
		TSS_Print("% ");
		break;
	case TSSTM_BAP:
	case TSSTM_BAMP:
	case TSSTM_BALP:
	case TSSTM_BAMT:
	case TSSTM_BALT:
	case TSSTM_YFP:
	case TSSTM_OFP:
		parameterInUse = inUse;
		TSS_ListPar((int*)&predicate->op, 0, 5, opNames);
		parameterInUse = inUse;
		TSS_NumPar(&predicate->limit, -100, 100);
		TSS_Print("%");
		break;
	case TSSTM_YFS:
	case TSSTM_OFS:
		parameterInUse = inUse;
		TSS_ListPar((int*)&predicate->op, 0, 5, opNames);
		parameterInUse = inUse;
		TSS_ListPar(&predicate->limit, 0, 2, flagStatusNames);
		break;
	default:
		TSS_Print("??????");	// should not occur
		break;
	}

	if (
		cg.tssCurrentValue == (int*) &predicate->magnitude ||
		cg.tssCurrentValue == (int*) &predicate->op ||
		cg.tssCurrentValue == &predicate->limit
	) {
		cg.tssCurrentMagnitude = predicate->magnitude;
	}
}

/*
=================
CG_TSS_SPrintTacticalMeasure
=================
*/
void CG_TSS_SPrintTacticalMeasure(
	char* buf, int size,
	tss_tacticalMagnitude_t magnitude, tss_tacticalMeasures_t* measures
) {
	static const char* const flagStatusNames[3] = {
		"1-bas", "2-dro", "3-tak"
	};
	const char* sign;

	switch (magnitude) {
	case TSSTM_no:
		buf[0] = 0;
		break;
	case TSSTM_YFS:
	case TSSTM_OFS:
		Com_sprintf(buf, size, "%s=%s", tssMagnitudeNames[magnitude], flagStatusNames[measures->var[magnitude]]);
		break;
	case TSSTM_YAP:
	case TSSTM_OAP:
	case TSSTM_YAMP:
	case TSSTM_OAMP:
	case TSSTM_YALP:
	case TSSTM_OALP:
	case TSSTM_RFAP:
	case TSSTM_RFDP:
	case TSSTM_FIN:
	case TSSTM_TIDY:
	case TSSTM_AVST:
		Com_sprintf(buf, size, "%s=%d%%", tssMagnitudeNames[magnitude], measures->var[magnitude]);
		break;
	case TSSTM_BAP:
	case TSSTM_BAMP:
	case TSSTM_BALP:
	case TSSTM_BAMT:
	case TSSTM_BALT:
	case TSSTM_YFP:
	case TSSTM_OFP:
		sign = (measures->var[magnitude] > 0? "+" : "");
		Com_sprintf(buf, size, "%s=%s%d%%", tssMagnitudeNames[magnitude], sign, measures->var[magnitude]);
		break;
	case TSSTM_BTS:
	case TSSTM_BAQ:
	case TSSTM_BAMQ:
	case TSSTM_BALQ:
	case TSSTM_SCB:
		sign = (measures->var[magnitude] > 0? "+" : "");
		Com_sprintf(buf, size, "%s=%s%d", tssMagnitudeNames[magnitude], sign, measures->var[magnitude]);
		break;
	default:
		Com_sprintf(buf, size, "%s=%d", tssMagnitudeNames[magnitude], measures->var[magnitude]);
		break;
	}
}

/*
=================
TSS_PrintTacticalMeasure
=================
*/
static void TSS_PrintTacticalMeasure(tss_tacticalMagnitude_t magnitude, tss_tacticalMeasures_t* measures) {
	char buf[32];

	CG_TSS_SPrintTacticalMeasure(buf, sizeof(buf), magnitude, measures);
	TSS_Print(buf);
}

/*
=================
TSS_ReorganizeGroups
=================
*/
static int TSS_ReorganizeGroups(int* groupOrderController, unsigned char* groupOrganization) {
	int i;
	int move;

	move = 0;
	for (i = 0; i < MAX_GROUPS; i++) {
		int dist;

		dist = groupOrderController[i];
		if (dist) {
			int j, m;

			dist = -dist;
			if (dist < 0) {
				if (i + dist < 0) dist = -i;

				m = groupOrganization[i];
				for (j = i; j > i + dist; j--) {
					groupOrganization[j] = groupOrganization[j - 1];
				}
				groupOrganization[j] = m;
			}
			else {
				if (i + dist >= MAX_GROUPS) dist = MAX_GROUPS-1 - i;

				m = groupOrganization[i];
				for (j = i; j < i + dist; j++) {
					groupOrganization[j] = groupOrganization[j + 1];
				}
				groupOrganization[j] = m;
			}
			move += dist;
			groupOrderController[i] = 0;
		}
	}
	return move;
}

/*
=================
TSS_CreateAbsoluteDivision
=================
*/
static void TSS_CreateAbsoluteDivision(void) {
	tss_division_t* relDiv;
	tss_division_t* absDiv;
	int group;
	int groupSizes[MAX_GROUPS];
	int assignments[MAX_GROUPS];
	int teamMatesLeft;

	if (!cg.tssSelectedStrategy) return;

	relDiv = &cg.tssStrategyWorkCopy.directives[cg.tssSelectedStrategy->directive].instr.division;
	absDiv = &cg.tssAbsoluteDivision;

	for (group = 0; group < MAX_GROUPS; group++) {
		groupSizes[group] = relDiv->group[group].minTotalMembers;
	}
	BG_TSS_AssignPlayers(cg.tssNumTeamMates, &groupSizes, relDiv->unassignedPlayers, &assignments);

	teamMatesLeft = cg.tssNumTeamMates;
	for (group = 0; group < MAX_GROUPS; group++) {
		int n;

		//n = BG_TSS_TakeProportionAway(relDiv->group[group].minTotalMembers, &teamMatesPercentLeft, &teamMatesLeft);
		n = assignments[group];
		teamMatesLeft -= n;
		absDiv->group[group].minTotalMembers = n;
		n = BG_TSS_Proportion(relDiv->group[group].minAliveMembers, 100, n);
		absDiv->group[group].minAliveMembers = n;
		n = BG_TSS_Proportion(relDiv->group[group].minReadyMembers, 100, n);
		absDiv->group[group].minReadyMembers = n;
	}
	absDiv->unassignedPlayers = teamMatesLeft;
}

/*
=================
TSS_CreateRelativeDivision
=================
*/
static void TSS_CreateRelativeDivision(void) {
	tss_division_t* relDiv;
	tss_division_t* absDiv;
	int group;
	int teamMatesLeft, teamMatesPercentLeft;

	if (!cg.tssSelectedStrategy) return;

	relDiv = &cg.tssStrategyWorkCopy.directives[cg.tssSelectedStrategy->directive].instr.division;
	absDiv = &cg.tssAbsoluteDivision;

	teamMatesLeft = absDiv->unassignedPlayers;
	for (group = 0; group < MAX_GROUPS; group++) {
		teamMatesLeft += absDiv->group[group].minTotalMembers;
	}
	teamMatesPercentLeft = 100;

	for (group = 0; group < MAX_GROUPS; group++) {
		int n;

		n = BG_TSS_TakeProportionAway(absDiv->group[group].minTotalMembers, &teamMatesLeft, &teamMatesPercentLeft);
		relDiv->group[group].minTotalMembers = n;
		n = BG_TSS_Proportion(absDiv->group[group].minAliveMembers, absDiv->group[group].minTotalMembers, 100);
		relDiv->group[group].minAliveMembers = n;
		n = BG_TSS_Proportion(absDiv->group[group].minReadyMembers, absDiv->group[group].minAliveMembers, 100);
		relDiv->group[group].minReadyMembers = n;
	}
	relDiv->unassignedPlayers = teamMatesPercentLeft;
}

/*
=================
TSS_ComputeUnassignedPlayers
=================
*/
static void TSS_ComputeUnassignedPlayers(tss_division_t* division, int totalPlayers) {
	int i, assignedPlayers;

	assignedPlayers = 0;
	for (i = 0; i < MAX_GROUPS; i++) {
		assignedPlayers += division->group[i].minTotalMembers;
	}
	totalPlayers -= assignedPlayers;
	if (totalPlayers < 0) totalPlayers = 0;
	division->unassignedPlayers = totalPlayers;
}

static qboolean groupOrganizationChanged;
static qboolean divisionChanged;
static qboolean selectedStrategyScrollOffsetChanged;
static qboolean stockLineChanged[TSS_STOCK_WINDOW_SIZE];
static qboolean searchIDChanged;
static qboolean searchNameChanged;

/*
=================
TSS_CheckModifications
=================
*/
static void TSS_CheckModifications(void) {
	tss_directive_t* directive;
	int i;

	if (selectedStrategyScrollOffsetChanged) {
		int index;

		index = TSS_PaletteSlotIndex(cg.tssSelectedStrategy);
		if (index >= 0) {
			int oldIndex;

			oldIndex = index;
			index += selectedStrategyScrollOffset;
			if (index < 0) index = 0;
			if (index >= cg.tssPalette.numEntries) index = cg.tssPalette.numEntries - 1;
			if (index != oldIndex) TSS_SelectStrategy(&cg.tssPalette.slots[index]);
		}
		selectedStrategyScrollOffset = 0;
		selectedStrategyScrollOffsetChanged = qfalse;
	}

	for (i = 0; i < TSS_STOCK_WINDOW_SIZE; i++) {
		int newIndex;
		int newPos;

		if (!stockLineChanged[i]) continue;

		newIndex = CG_TSS_StrategyNameChanged(
			i - cg.tssStrategyStockScrollOffset,
			cg.tssStrategyStockSortOrder
		);
		newPos = TSS_SetStockWindow(i, newIndex);
		cg.tssCursorLine += newPos - i;

		stockLineChanged[i] = qfalse;
	}

	if (searchIDChanged) {
		int sortIndex;

		sortIndex = CG_TSS_GetSortIndexByID(atoi(searchIDBuf), cg.tssStrategyStockSortOrder);
		if (sortIndex >= 0) {
			TSS_SetStockWindow((TSS_STOCK_WINDOW_SIZE-1)/2, sortIndex);
		}
		searchIDChanged = qfalse;
	}

	if (searchNameChanged) {
		CG_TSS_SetSearchPattern(searchNameBuf);
		TSS_SetStockWindow(0, 0);

		searchNameChanged = qfalse;
	}

	//
	// following: solely checks that depend on a strategy to be selected
	//

	if (!cg.tssSelectedStrategy) return;
	directive = &cg.tssStrategyWorkCopy.directives[cg.tssSelectedStrategy->directive];

	if (groupOrganizationChanged) {
		cg.tssCursorLine += TSS_ReorganizeGroups(cg.tssGroupOrderController, directive->instr.groupOrganization);
		groupOrganizationChanged = qfalse;
	}

	if (divisionChanged) {
		switch (cg.tssDivisionMode) {
		case DM_quantity:
			TSS_ComputeUnassignedPlayers(&cg.tssAbsoluteDivision, cg.tssNumTeamMates);
			TSS_CreateRelativeDivision();
			break;
		case DM_percentage:
			TSS_ComputeUnassignedPlayers(&directive->instr.division, 100);
			break;
		}
		divisionChanged = qfalse;
	}
}

/*
=================
CG_TSS_DrawInterface
=================
*/
void CG_TSS_DrawInterface(void) {
	static int page = 1;
	const int numPages = 5;
	static const char* const pageNames[/*numPages*/] = {
		"Personal Services",
		"Groups",
		"Strategy",
		"Tactics",
		"Measures"
	};
	static const char* const groupLeaderNames[] = {
		"---"
	};
	static int leaderPage = 1;
	const int numLeaderPages = 2;
	static const char* const leaderPageNames[/*numLeaderPages*/] = {
		"Designated Leaders", "Statistics"
	};
	static int strategyPage = 1;
	const int numStrategyPages = 3;
	static const char* const strategyPageNames[/*numStrategyPages*/] = {
		"Stock",
		"Administration",
		"Global Adjustments of the Selected Strategy"
	};
	static const char* const conditionControlNames[2] = {
		"Manual", "Auto"
	};
	static const char* const directiveShortNames[] = {
		"?", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
		"N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"
	};
	static int tacticsPage = 1;
	const int numTacticsPages = 3;
	static const char* const tacticsPageNames[/*numTacticsPages*/] = {
		"Division", "Orders", "Occasion"
	};
	static const char* const divisionModeNames[2] = {
		"Quantity", "Percentage"
	};
	static const char* const missionNames[TSSMISSION_num_missions] = {
		"---",
		"Seek Enemy", "Seek Items",
		"Capture Enemy Flag", "Defend Our Flag", "Defend Our Base", "Occupy Enemy Base"
	};

	vec4_t color;
	int i;
	tss_directive_t* directive;
	tss_division_t* division;
	const char* quantitySuffix;
	char buf[128];

	if (
		!(trap_Key_GetCatcher() & TSS_KEYCATCHER) ||
		cg.predictedPlayerState.pm_type == PM_INTERMISSION ||
        // JUHOX: no TSS with STU
		cgs.gametype >= GT_STU ||
		cgs.gametype < GT_TEAM
	) {
		CG_TSS_CloseInterface();
		return;
	}

	CG_TSS_UpdateInterface();

	// draw background
	color[0] = 0.05;
	color[1] = 0.25;
	color[2] = 0.1;
	color[3] = 0.8;
	CG_FillRect(TSS_X-1, TSS_Y-1, TSS_W+2, TSS_H+2, color);

	// draw cursor
	i = cg.time % 500;
	if (i >= 300) cursorC = 0;
	else if (i < 50) cursorC = i / 50.0;
	else cursorC = (300 - i) / 250.0;
	color[0] = cursorC;
	color[1] = cursorC;
	color[2] = cursorC;
	color[3] = 1;
	CG_FillRect(
		TSS_X + SMALLCHAR_WIDTH * cg.tssCursorCol,
		TSS_Y + SMALLCHAR_HEIGHT * cg.tssCursorLine,
		SMALLCHAR_WIDTH,
		SMALLCHAR_HEIGHT,
		color
	);

	cg.tssPrintCol = 0;
	cg.tssPrintLine = 0;
	cg.tssCursorLineEnd = 0;
	cg.tssCurrentValue = NULL;
	cg.tssCurrentTextField = NULL;
	cg.tssCurrentValueChanged = NULL;
	cg.tssNextValueCol = -1;
	cg.tssNextValueLine = -1;
	cg.tssPrevValueCol = -1;
	cg.tssPrevValueLine = -1;
	parameterInUse = qtrue;
	parameterChangeNotifier = NULL;

	if (page != 4 || tacticsPage != 3) cg.tssCurrentMagnitude = 0;



	TSS_Print("Tactical Support System");
	if (cg.tssStrategyWorkCopyChanged) {
		TSS_Print("       changes: ");
		TSS_Button(TSSBID_APPLY, "use");
		TSS_Print(" ");
		TSS_Button(TSSBID_CANCEL, "cancel");
	}
	cg.tssPrintCol = TSS_W / SMALLCHAR_WIDTH - 11;
	TSS_Button(TSSBID_RESUMEGAME, "resume game");
	TSS_Print("\n");

	if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR) {
		TSS_Print("\n\nYou're spectating. No support available.\n\n");
		TSS_Print("     ");
		TSS_Button(TSSBID_JOIN_RED, "   Join Red Team    ");
		TSS_Print("   ");
		TSS_Button(TSSBID_JOIN_BLUE, "   Join Blue Team   ");
		TSS_Print("\n");
		goto Exit;
	}

	TSS_Print("Page #");
	TSS_NumPar(&page, 1, numPages);
	Com_sprintf(buf, sizeof(buf), "/%d: ", numPages);
	TSS_Print(buf);
	TSS_ListPar(&page, 1, numPages, pageNames);
	TSS_Print("\n");

	switch (page) {
	case 1:	// team state
	{
		int cs_offset;

		TSS_Print("\n");
		if (cgs.clientinfo[cg.clientNum].teamLeader) {
			static const char* const missionControlStatusNames[2] = {
				"off-line", "on-line"
			};

			TSS_Print("You are the mission leader.\n");
			TSS_Print("Mission control is ");
#if !TSSINCVAR
			if (cgs.tss && !cg.tssPureServer) {
#else
			if (cgs.tss) {
#endif
				TSS_ListParTight((int*)&cg.tssOnline, 0, 1, missionControlStatusNames);
				TSS_Print(".\n");
			}
			else {
#if !TSSINCVAR
				TSS_Print("off-line.");
				if (cg.tssPureServer) {
					TSS_Print(" (pure server)");
				}
				else if (!cgs.tss) {
					TSS_Print(" (disabled on this server)");
				}
#else
				TSS_Print("off-line. (disabled on this server)");
#endif
				TSS_Print("\n");
			}
		}
		else {
			TSS_Print("Your mission leader is ");
			TSS_Print(cg.tssTeamLeaderName);
			TSS_Print(".\n");
		}

		switch (cgs.clientinfo[cg.clientNum].team) {
		case TEAM_RED:
			cs_offset = 0;
			break;
		case TEAM_BLUE:
			cs_offset = 1;
			break;
		default:
			goto Exit;
		}
		if (cgs.teamVoteTime[cs_offset]) {
			int sec;

			TSS_Print("\nVote for ");
			if (!Q_strncmp("leader", cgs.teamVoteString[cs_offset], 6)) {
				TSS_Print("mission leader ");
				Q_strncpyz(buf, cgs.clientinfo[atoi(cgs.teamVoteString[cs_offset] + 7)].name, sizeof(buf));
			}
			else if (!Q_strncmp("surrender", cgs.teamVoteString[cs_offset], 9)) {
				TSS_Print("surrendering this round");
				buf[0] = 0;
			}
			else {
				Q_strncpyz(buf, cgs.teamVoteString[cs_offset], sizeof(buf));
			}
			Q_CleanStr(buf);
			TSS_Print(buf);
			TSS_Print(".\n");

			if (!(cg.predictedPlayerState.eFlags & EF_TEAMVOTED)) {
				TSS_Button(TSSBID_VOTE_YES, "YES");
				Com_sprintf(buf, sizeof(buf), "   %3d\n", cgs.teamVoteYes[cs_offset]);
				TSS_Print(buf);
				TSS_Button(TSSBID_VOTE_NO, "NO ");
				Com_sprintf(buf, sizeof(buf), "   %3d\n", cgs.teamVoteNo[cs_offset]);
				TSS_Print(buf);
			}
			else {
				Com_sprintf(
					buf, sizeof(buf),
					"YES   %3d\n"
					"NO    %3d\n",
					cgs.teamVoteYes[cs_offset],
					cgs.teamVoteNo[cs_offset]
				);
				TSS_Print(buf);
			}

			sec = (VOTE_TIME - (cg.time - cgs.teamVoteTime[cs_offset])) / 1000;
			if (sec < 0) sec = 0;
			Com_sprintf(buf, sizeof(buf), "time left: %d sec\n", sec);
			TSS_Print(buf);
		}
		else {
			TSS_Button(TSSBID_CALLLEADERVOTE, "Call a vote");
			TSS_Print(" for mission leader ");
			TSS_TeamListParTight(&cg.tssCallVoteLeader, 0, NULL);
			TSS_Print(".\n\n");

			TSS_Button(TSSBID_CALLSURRENDERVOTE, "Call a vote");
			TSS_Print(" for surrendering this round.\n");
		}

		if (
			(cg.tssActivated || cg.tssOnline) &&
			(cg.snap->ps.pm_type != PM_SPECTATOR || cg.snap->ps.stats[STAT_HEALTH] <= 0)
		) {
			const char* groupCommand;

			Com_sprintf(
				buf, sizeof(buf), "\nYour navigation aid is %s.   ",
				BG_TSS_GetPlayerInfo(&cg.snap->ps, TSSPI_navAid)? "active" : "inactive"
			);
			TSS_Print(buf);
			TSS_Button(TSSBID_NAVAID_ON, " ON  ");
			TSS_Print("   ");
			TSS_Button(TSSBID_NAVAID_OFF, " OFF ");
			TSS_Print("\n");

			if (cg.snap->ps.stats[STAT_HEALTH] > 0) {
				switch (cg.tssGroupFormation) {
				case TSSGF_tight:
					if (cg.tssGroupLeaderAuthorization) {
						groupCommand = "Stick to me!";
					}
					else {
						groupCommand = "Stick to group leader!";
					}
					break;
				case TSSGF_loose:
					if (cg.tssGroupLeaderAuthorization) {
						groupCommand = "Support me!";
					}
					else {
						groupCommand = "Support group leader!";
					}
					break;
				case TSSGF_free:
					groupCommand = "Go! Go! Go!";
					break;
				default:
					groupCommand = NULL;
					break;
				}
				if (groupCommand) {
					Com_sprintf(buf, sizeof(buf), "\nCurrent group command is \"%s\"\n", groupCommand);
					TSS_Print(buf);

					Com_sprintf(
						buf, sizeof(buf), "%sroup command is choosen %s.\n",
						cg.tssGroupLeaderAuthorization? "G" : "When you're leader, g",
						cg_autoGLC.integer? "automatically" : "manually"
					);
					TSS_Print(buf);
					TSS_Print("Automatic group commands:   ");
					TSS_Button(TSSBID_AUTOGLC_ON, " ON  ");
					TSS_Print("   ");
					TSS_Button(TSSBID_AUTOGLC_OFF, " OFF ");
					TSS_Print("\n");
				}
				if (cg.tssGroupLeaderAuthorization && !cg_autoGLC.integer) {
					TSS_Print("   ");
					TSS_Button(TSSBID_GROUPFORMATION_TIGHT, "Stick to me!");
					TSS_Print("   ");
					TSS_Button(TSSBID_GROUPFORMATION_LOOSE, "Support me!");
					TSS_Print("   ");
					TSS_Button(TSSBID_GROUPFORMATION_FREE, "Go! Go! Go!");
					TSS_Print("\n");
				}
			}
		}

		if (cgs.clientinfo[cg.clientNum].teamLeader && cg.tssOnline) {
			Com_sprintf(
				buf, sizeof(buf),
				"\n"
				"    your team: %d of %d player%s alive\n"
				"opposing team: %d of %d player%s alive\n",
				cg.tssNumTeamMatesAlive, cg.tssNumTeamMates, cg.tssNumTeamMates != 1? "s" : "",
				cg.tssNumEnemiesAlive, cg.tssNumEnemies, cg.tssNumEnemies != 1? "s" : ""
			);
		}
		else {
			Com_sprintf(
				buf, sizeof(buf),
				"\n"
				"    your team: %d player%s\n"
				"opposing team: %d player%s\n",
				cg.tssNumTeamMates, cg.tssNumTeamMates != 1? "s" : "",
				cg.tssNumEnemies, cg.tssNumEnemies != 1? "s" : ""
			);
		}
		TSS_Print(buf);

		if (
			cgs.tssSafetyMode &&
			cgs.clientinfo[cg.clientNum].teamLeader &&
			cg.snap->ps.stats[STAT_HEALTH] >= cg.snap->ps.stats[STAT_MAX_HEALTH] &&
			cg.snap->ps.weaponstate == WEAPON_READY &&
			(cg.tssNumTeamMatesAlive > 1 || cg.snap->ps.pm_type == PM_SPECTATOR)
		) {
			TSS_Print("\n");
			if (cg.snap->ps.pm_type == PM_SPECTATOR) {
				TSS_Button(TSSBID_SAFETYMODE, "leave safety mode");
			}
			else {
				TSS_Button(TSSBID_SAFETYMODE, "enter safety mode");
			}
			TSS_Print("\n");
		}
		break;
	}
	case 2:	// group state
	{
		qboolean multiMandate;

		if (!cgs.clientinfo[cg.clientNum].teamLeader) {
			AccessDenied:
			TSS_Print(
				"\n"
				"ACCESS DENIED: NO AUTHORIZATION\n"
				"You do not have mission leader authorization.\n"
				"\n"
				"Ask your administrator for more information.\n"
			);
			goto Exit;
		}

#if !TSSINCVAR
		if (cg.tssPureServer) {
			PureServer:
			TSS_Print(
				"\n"
				"ACCESS DENIED: PURE SERVER\n"
				"Mission control not available.\n"
				"\n"
				"Ask your administrator for more information.\n"
			);
			goto Exit;
		}
#endif

		TSS_Print("Section #");
		TSS_NumPar(&leaderPage, 1, numLeaderPages);
		TSS_Print(va("/%d: ", numLeaderPages));
		TSS_ListPar(&leaderPage, 1, numLeaderPages, leaderPageNames);
		TSS_Print("\n\n");

		switch (leaderPage) {
		case 1:
			TSS_Print("     1st leader          2nd leader          3rd leader\n");
			multiMandate = qfalse;
			for (i = 0; i < MAX_GROUPS; i++) {
				int j;

				Com_sprintf(buf, sizeof(buf), "[%c] ", i + 'A');
				TSS_Print(buf);

				for (j = 0; j < 3; j++) {
					cg.tssPrintCol = 3 + j * 20;
					TSS_Print(" ");	// to remove the last character of a long name
					if (cg.tssMultiMandate[j][i]) {
						TSS_Print("*");
						multiMandate = qtrue;
					}
					else {
						TSS_Print(" ");
					}
					TSS_TeamListPar(&cg.tssGroupLeader[j][i], -1, groupLeaderNames);
				}
				TSS_Print("\n");
			}
			if (multiMandate) {
				TSS_Print("\n    * multiple mandates\n");
			}
			break;
		case 2:
			TSS_Print("     ready alive total   current leader\n");
			for (i = 0; i < MAX_GROUPS; i++) {
				char name[32];

				if (cg.tssCurrentLeader[i] >= 0 && cg.tssCurrentLeader[i] < MAX_CLIENTS) {
					Q_strncpyz(name, cgs.clientinfo[cg.tssCurrentLeader[i]].name, sizeof(name));
					Q_CleanStr(name);
				}
				else {
					strcpy(name, "---");
				}
				Com_sprintf(
					buf, sizeof(buf), "[%c]  %5d %5d %5d   %s\n",
					i + 'A', cg.tssCurrentReady[i], cg.tssCurrentAlive[i], cg.tssCurrentTotal[i], name
				);
				TSS_Print(buf);
			}
			break;
		}
		break;
	}
	case 3:	// strategy
		if (!cgs.clientinfo[cg.clientNum].teamLeader) goto AccessDenied;
#if !TSSINCVAR
		if (cg.tssPureServer) goto PureServer;
#endif

		TSS_Print("===== Palette [");
		if (cg.tssPalette.numEntries) {
			Com_sprintf(buf, sizeof(buf), "a-%c", 'a' + cg.tssPalette.numEntries - 1);
			TSS_Print(buf);
		}
		TSS_Print("] ");
		TSS_FillLine('=');
		TSS_Print("applied  ");
		if (cg.tssUtilizedStrategy) {
			Com_sprintf(
				buf, sizeof(buf), "(%c) #%03d %s\n",
				'a' + TSS_PaletteSlotIndex(cg.tssUtilizedStrategy),
				cg.tssUtilizedStrategy->slot->id,
				cg.tssUtilizedStrategy->slot->tssname
			);
			TSS_Print(buf);
		}
		else {
			TSS_Print("(-) #--- ---------\n");
		}
		TSS_Print("selected ");
		if (cg.tssSelectedStrategy) {
			Com_sprintf(
				buf, sizeof(buf), "(%c) #%03d %31s ",
				'a' + TSS_PaletteSlotIndex(cg.tssSelectedStrategy),
				cg.tssSelectedStrategy->slot->id,
				cg.tssSelectedStrategy->slot->tssname
			);
			parameterChangeNotifier = &selectedStrategyScrollOffsetChanged;
			TSS_StringWithNumberPar(&selectedStrategyScrollOffset, -100, 100, buf);
			if (cg.tssSelectedStrategy != cg.tssUtilizedStrategy) {
				TSS_Button(TSSBID_UTILIZE_STRATEGY, "apply");
			}
			else {
				TSS_Print("     ");
			}
			TSS_Print("    ");
			TSS_Button(TSSBID_REMOVE_STRATEGY, "remove");
		}
		else {
			TSS_Print("(-) #--- ---------");
		}
		TSS_Print("\n\n");

		TSS_Print("===== Section #");
		TSS_NumPar(&strategyPage, 1, numStrategyPages);
		Com_sprintf(buf, sizeof(buf), "/%d: ", numStrategyPages);
		TSS_Print(buf);
		TSS_ListParTight(&strategyPage, 1, numStrategyPages, strategyPageNames);

		switch (strategyPage) {
		case 1:	// stock
			{
				static const char* const sortOrderNames[SSO_num_orders] = {
					"creation date",
					"access date",
					"name / creation date",
					"name / access date",
					"pattern similariy"
				};
				static const char* const sortOrderNumbers[SSO_num_orders] = {"1", "2", "3", "4", "5"};
				int minScrollOffset;

				TSS_Print(" ");
				TSS_FillLine('=');
				minScrollOffset = CG_TSS_NumStrategiesInStock(cg.tssStrategyStockSortOrder) - TSS_STOCK_WINDOW_SIZE;
				if (minScrollOffset < 0) minScrollOffset = 0;
				minScrollOffset = -minScrollOffset;
				TSS_Print("    ID# Name            sort by ");
				TSS_ListParTight((int*)&cg.tssStrategyStockSortOrder, 0, SSO_num_orders-1, sortOrderNames);
				TSS_Print(" (#");
				TSS_ListPar((int*)&cg.tssStrategyStockSortOrder, 0, SSO_num_orders-1, sortOrderNumbers);
				TSS_Print(va("/%d)\n", SSO_num_orders));
				for (i = 0; i < TSS_STOCK_WINDOW_SIZE; i++) {
					tss_strategySlot_t* slot;

					slot = TSS_GetSlotAtStockPos(i);
					if (slot) {
						int c;

						c = 32;
						if (searchIDBuf[0] && slot->id == atoi(searchIDBuf)) c = '=';
						if (i == 0 && cg.tssStrategyStockScrollOffset != 0) c = 1;
						if (i == TSS_STOCK_WINDOW_SIZE-1 && TSS_GetSlotAtStockPos(i+1)) c= 2;

						TSS_Button(TSSBID_ADD_STRATEGY + i, " + ");
						Com_sprintf(buf, sizeof(buf), "%c%03d%c", c, slot->id, c);
						TSS_Print(buf);
						textParameterChangeNotifier = &stockLineChanged[i];
						parameterReversedHome = qtrue;
						TSS_TextWithNumberPar(
							slot->tssname, sizeof(slot->tssname),
							&cg.tssStrategyStockScrollOffset, minScrollOffset, 0
						);
						TSS_Print(va("%c", c));
						TSS_Print(slot->filename);
						TSS_Print("\n");
					}
					else {
						TSS_Print("    --- --------\n");
					}
				}

				TSS_Print("Search ID#");
				textParameterChangeNotifier = &searchIDChanged;
				TSS_TextPar(searchIDBuf, sizeof(searchIDBuf));
				TSS_Print(" ");
				if (cg.tssSelectedStrategy) {
					TSS_Button(TSSBID_SEARCH_SELECTED, va("search #%03d", cg.tssSelectedStrategy->slot->id));
				}
				else {
					TSS_Print("           ");
				}
				if (cg.tssStrategyStockSortOrder == SSO_searchResult) {
					TSS_Print("  Pattern ");
					textParameterChangeNotifier = &searchNameChanged;
					TSS_TextPar(searchNameBuf, sizeof(searchNameBuf));
				}
				TSS_Print("\n");
			}
			break;
		case 2:	// administration
			TSS_Print(" ");
			TSS_FillLine('=');
			TSS_Print("\n\n");
			TSS_Button(TSSBID_CREATE_STRATEGY, "create new strategy");
			TSS_Print("\n\n");
			if (cg.tssSelectedStrategy) {
				TSS_Button(TSSBID_DUPLICATE_STRATEGY, "duplicate selected strategy");
				TSS_Print("\n");
			}
			break;
		case 3:	// contents
			TSS_Print(" ");
			TSS_FillLine('=');
			TSS_Print("\n");

			if (!cg.tssSelectedStrategy) goto Exit;

			TSS_Print("RFA danger limit: ");
			CG_TSS_Parameter(
				&cg.tssStrategyWorkCopy.rfa_dangerLimit, -100, cg.tssStrategyWorkCopy.rfd_dangerLimit,
				NULL, NULL, 4
			);
			TSS_Print("\n");

			TSS_Print("RFD danger limit: ");
			CG_TSS_Parameter(
				&cg.tssStrategyWorkCopy.rfd_dangerLimit, cg.tssStrategyWorkCopy.rfa_dangerLimit, 100,
				NULL, NULL, 4
			);
			TSS_Print("\n\n");

			TSS_Print("definition of \"medium term\": " TSS_GREATER_OR_EQUAL_STR);
			TSS_BigNumPar(&cg.tssStrategyWorkCopy.medium_term, 1, cg.tssStrategyWorkCopy.long_term - 1);
			TSS_Print("% of respawn delay\n");

			TSS_Print("definition of \"long term\":   " TSS_GREATER_OR_EQUAL_STR);
			TSS_BigNumPar(&cg.tssStrategyWorkCopy.long_term, cg.tssStrategyWorkCopy.medium_term + 1, 100);
			TSS_Print("% of respawn delay\n");

			TSS_Print("\nComment\n");
			TSS_TextPar(cg.tssStrategyWorkCopy.comment, sizeof(cg.tssStrategyWorkCopy.comment));
			TSS_Print("\n");
			break;
		}
		break;
	case 4:	// tactics
		if (!cgs.clientinfo[cg.clientNum].teamLeader) goto AccessDenied;
#if !TSSINCVAR
		if (cg.tssPureServer) goto PureServer;
#endif

		TSS_Print("===== Applied Strategy ");
		if (cg.tssUtilizedStrategy) {
			const char* conditionName;

			Com_sprintf(
				buf, sizeof(buf), "(%c) #%03d %s ",
				'a' + TSS_PaletteSlotIndex(cg.tssUtilizedStrategy),
				cg.tssUtilizedStrategy->slot->id,
				cg.tssUtilizedStrategy->slot->tssname
			);
			TSS_Print(buf);
			TSS_FillLine('=');

			TSS_Print("===== [");
			parameterInUse = qfalse;
			TSS_ListParTight(&cg.tssUtilizedStrategy->strategy->autoCondition, 0, 1, conditionControlNames);
			TSS_Print("] Condition ");
			parameterInUse = !cg.tssUtilizedStrategy->strategy->autoCondition;
			TSS_ListPar(&cg.tssUtilizedStrategy->condition, 0, TSS_NON_DEFAULT_DIRECTIVES_PER_STRATEGY, directiveShortNames);
			conditionName = cg.tssUtilizedStrategy->strategy->directives[cg.tssUtilizedStrategy->condition].name;
			TSS_Print(" - ");
			parameterInUse = !cg.tssUtilizedStrategy->strategy->autoCondition;
			TSS_StringWithNumberPar(
				&cg.tssUtilizedStrategy->condition, 0, TSS_NON_DEFAULT_DIRECTIVES_PER_STRATEGY,
				conditionName[0]? conditionName : "---------"
			);
			TSS_Print("\n");
		}
		else {
			TSS_Print("(-) #--- --------- ");
			TSS_FillLine('=');
			TSS_Print("\n");
		}
		TSS_Print("\n");

		TSS_Print("===== Edit ");
		if (cg.tssSelectedStrategy) {
			Com_sprintf(
				buf, sizeof(buf), "(%c) #%03d %s",
				'a' + TSS_PaletteSlotIndex(cg.tssSelectedStrategy),
				cg.tssSelectedStrategy->slot->id,
				cg.tssSelectedStrategy->slot->tssname
			);
			parameterChangeNotifier = &selectedStrategyScrollOffsetChanged;
			TSS_StringWithNumberPar(&selectedStrategyScrollOffset, -100, 100, buf);
			TSS_Print(" ");
			TSS_FillLine('=');
		}
		else {
			TSS_Print("(-) #--- --------- ");
			TSS_FillLine('=');
			goto Exit;
		}

		directive = &cg.tssStrategyWorkCopy.directives[cg.tssSelectedStrategy->directive];

		TSS_ListParTight(&cg.tssStrategyWorkCopy.autoCondition, 0, 1, conditionControlNames);
		TSS_Print(" Tactics         ");

		if (cg.tssSelectedStrategy->directive > 0) {
			TSS_Button(TSSBID_INSERT_DIRECTIVE, "insert");
			TSS_Print("   ");
			TSS_Button(TSSBID_DELETE_DIRECTIVE, "delete");
			TSS_Print(" ");
			TSS_Button(TSSBID_CLEAR_DIRECTIVE, "clear");
			TSS_Print("        ");
			TSS_Button(TSSBID_COPY_DIRECTIVE, "copy");
			TSS_Print(" ");
			TSS_Button(TSSBID_PASTE_DIRECTIVE, "paste");
		}
		else {
			TSS_Print("                ");
			TSS_Button(TSSBID_CLEAR_DIRECTIVE, "clear");
			TSS_Print("        ");
			TSS_Button(TSSBID_COPY_DIRECTIVE, "copy");
			TSS_Print(" ");
			TSS_Button(TSSBID_PASTE_DIRECTIVE, "paste");
		}
		TSS_Print("\n");

		TSS_Print("Edit Condition ");
		TSS_ListPar(&cg.tssSelectedStrategy->directive, 0, TSS_NON_DEFAULT_DIRECTIVES_PER_STRATEGY, directiveShortNames);
		TSS_Print(" - ");
		if (cg.tssSelectedStrategy->directive > 0) {
			static const char* const directiveInUseNames[2] = {
				"[ ] off", "[X] on"
			};

			TSS_TextWithNumberPar(
				directive->name, sizeof(directive->name),
				&cg.tssSelectedStrategy->directive, 0, TSS_NON_DEFAULT_DIRECTIVES_PER_STRATEGY
			);
			TSS_Print("   ");
			TSS_ListPar((int*)&directive->inUse, 0, 1, directiveInUseNames);
		}
		else {
			TSS_StringWithNumberPar(
				&cg.tssSelectedStrategy->directive, 0, TSS_NON_DEFAULT_DIRECTIVES_PER_STRATEGY,
				"default                         "
			);
		}
		TSS_Print("\n\n");

		TSS_Print("Section #");
		TSS_NumPar(&tacticsPage, 1, numTacticsPages);
		Com_sprintf(buf, sizeof(buf), "/%d: ", numTacticsPages);
		TSS_Print(buf);
		TSS_ListPar(&tacticsPage, 1, numTacticsPages, tacticsPageNames);

		switch (tacticsPage) {
		case 1:	// division
			{
				qboolean total, alive, ready;

				TSS_Print("     Mode: ");
				TSS_ListPar((int*)&cg.tssDivisionMode, 1, 2, divisionModeNames);
				TSS_Print("\n");
				switch (cg.tssDivisionMode) {
				case DM_quantity:
					quantitySuffix = "";
					division = &cg.tssAbsoluteDivision;
					TSS_CreateAbsoluteDivision();
					break;
				case DM_percentage:
					quantitySuffix = "%";
					division = &directive->instr.division;
					break;
				default:
					goto Exit;
				}
				Com_sprintf(buf, sizeof(buf), "remaining players: %d%s\n", division->unassignedPlayers, quantitySuffix);
				TSS_Print(buf);

				total = alive = ready = qfalse;
				for (i = 0; i < MAX_GROUPS; i++) {
					int group;
					int limit;

					group = directive->instr.groupOrganization[i];
					parameterChangeNotifier = &groupOrganizationChanged;
					parameterReversedHome = qtrue;
					TSS_StringWithNumberPar(&cg.tssGroupOrderController[i], -10, 10, "=");
					Com_sprintf(buf, sizeof(buf), "[%c] total "TSS_GREATER_OR_EQUAL_STR, group + 'A');
					TSS_Print(buf);
					limit = division->group[group].minTotalMembers + division->unassignedPlayers;
					parameterChangeNotifier = &divisionChanged;
					total |= TSS_BigNumPar(&division->group[group].minTotalMembers, 0, limit);
					Com_sprintf(buf, sizeof(buf), "%s      alive "TSS_GREATER_OR_EQUAL_STR, quantitySuffix);
					TSS_Print(buf);
					limit = cg.tssDivisionMode == DM_quantity? division->group[group].minTotalMembers : 100;
					parameterChangeNotifier = &divisionChanged;
					alive |= TSS_BigNumPar(&division->group[group].minAliveMembers, 0, limit);
					Com_sprintf(buf, sizeof(buf), "%s      ready "TSS_GREATER_OR_EQUAL_STR, quantitySuffix);
					TSS_Print(buf);
					limit = cg.tssDivisionMode == DM_quantity? division->group[group].minAliveMembers : 100;
					parameterChangeNotifier = &divisionChanged;
					ready |= TSS_BigNumPar(&division->group[group].minReadyMembers, 0, limit);
					Com_sprintf(buf, sizeof(buf), "%s\n", quantitySuffix);
					TSS_Print(buf);
				}
				//	we've this much space:
				//	          "********************************************************************",
				if (total) {
					TSS_Print("part of the team that should be dedicated to this group\n");
				}
				if (alive) {
					TSS_Print("part of this group that should be alive\n");
				}
				if (ready) {
					TSS_Print("part of the living group members that should be ready for action\n");
				}
			}
			break;
		case 2:	// orders
			{
				qboolean di, r, s, g;

				TSS_Print("\n\n");
				di = r = s = g = qfalse;
				for (i = 0; i < MAX_GROUPS; i++) {
					int group;

					group = directive->instr.groupOrganization[i];
					parameterChangeNotifier = &groupOrganizationChanged;
					parameterReversedHome = qtrue;
					TSS_StringWithNumberPar(&cg.tssGroupOrderController[i], -10, 10, "=");
					Com_sprintf(buf, sizeof(buf), "[%c] ", group + 'A');
					TSS_Print(buf);
					TSS_ListPar(
						(int*)&directive->instr.orders.order[group].mission,
						0, cg.tssGametype == GT_CTF? TSSMISSION_num_missions-1 : TSSMISSION_num_tdm_missions-1,
						missionNames
					);
					TSS_Print("   DI" TSS_LOWER_OR_EQUAL_STR);
					di |= TSS_NumPar(&directive->instr.orders.order[group].maxDanger, -100, 100);
					TSS_Print("    RP" TSS_GREATER_OR_EQUAL_STR);
					r |= TSS_NumPar(&directive->instr.orders.order[group].minReady, 0, 100);
					TSS_Print("%    GS" TSS_GREATER_OR_EQUAL_STR);
					s |= TSS_NumPar(&directive->instr.orders.order[group].minGroupSize, 0, 100);
					TSS_Print("%    BG" TSS_LOWER_OR_EQUAL_STR);
					g |= TSS_NumPar(&directive->instr.orders.order[group].maxGuards, 0, 9);
					TSS_Print("\n");
				}
				//	we've this much space:
				//	          "********************************************************************",
				if (di) {
					TSS_Print("Danger Index: specify upper limit for player status \"ready\"\n");
				}
				if (r) {
					TSS_Print("Ready Players: specify lower limit for mission status \"ready\"\n");
				}
				if (s) {
					TSS_Print("Group Size: specify lower limit for mission status \"ready\"\n");
				}
				if (g) {
					TSS_Print("Bodyguards: max. # assigned to non-ready players\n");
				}
			}
			break;
		case 3:	// occasion
			if (cg.tssCurrentMagnitude > 0) {
				TSS_Print("      ");
				Com_sprintf(buf, sizeof(buf), "#%2d/%d: ", cg.tssCurrentMagnitude, TSSTM_num_magnitudes-1);
				TSS_Print(buf);
				TSS_PrintTacticalMeasure(cg.tssCurrentMagnitude, &cg.tssMeasures);
			}
			TSS_Print("\n");

			if (cg.tssSelectedStrategy->directive <= 0) {
				TSS_Print("\n   no other directive fits\n");
				cg.tssCurrentMagnitude = 0;
			}
			else {
				static const char* const usageNames[] = {
					"[ ]", "[X]"
				};
				int i;

				if (cg.tssCursorLine < cg.tssPrintLine) cg.tssCurrentMagnitude = 0;

				for (i = 0; i < TSS_CLAUSES_PER_OCCASION; i++) {
					tss_clause_t* clause;
					int j;

					clause = &directive->occasion.clause[i];

					if (i & 1) {
						color[0] = 0;
						color[1] = 0;
						color[2] = 0;
						color[3] = 0.04;
					}
					else {
						color[0] = 1;
						color[1] = 1;
						color[2] = 1;
						color[3] = 0.04;
					}
					CG_FillRect(TSS_X, TSS_Y + cg.tssPrintLine*SMALLCHAR_HEIGHT, TSS_W, SMALLCHAR_HEIGHT*2, color);

					TSS_ListPar((int*)&clause->inUse, 0, 1, usageNames);

					for (j = 0; j < TSS_PREDICATES_PER_CLAUSE; j++) {
						if (j == TSS_PREDICATES_PER_CLAUSE/2) {
							TSS_Print("\n ");
							TSS_Print(TSS_EvalClause(clause, &cg.tssMeasures)? "*" : " ");
							TSS_Print(" ");
						}
						TSS_Print("  ");
						if (clause->inUse && TSS_EvalPredicate(&clause->predicate[j], &cg.tssMeasures)) {
							TSS_Print("*");
						}
						else {
							TSS_Print(" ");
						}
						parameterInUse = clause->inUse;
						TSS_TacticalPredicatePar(&clause->predicate[j]);
					}

					TSS_Print("\n");
				}
			}
			break;
		}
		break;
	case 5:	// measures
		{
			int startLine, lastLine;
			int col;
			tss_tacticalMagnitude_t selectedMagnitude;
			static const char* const helpLine[TSSTM_num_magnitudes] = {
				"",
			//	we've this much space:
			//	"********************************************************************",
				"(#1)  Your Team's Size\n"
				"number of players in your team",

				"(#2)  Opposing Team's Size\n"
				"number of opponents",

				"(#3)  Balance of Team Sizes\n"
				"YTS - OTS",

				"(#4)  ReSPawn Delay\n"
				"respawn delay in seconds",

				"(#5)  Your team: number of players Alive, Percentage\n"
				"100% \xb7 (YAQ / YTS)",

				"(#6)  Your team: number of players Alive, Quantity\n"
				"number of players alive in your team",

				"(#7)  Opposing team: number of players Alive, Percentage\n"
				"100% \xb7 (OAQ / OTS)",

				"(#8)  Opposing team: number of players Alive, Quantity\n"
				"number of opponents alive",

				"(#9)  Balance of players Alive, Percentage\n"
				"YAP - OAP",

				"(#10) Balance of players Alive, Quantity\n"
				"YAQ - OAQ",

				"(#11) Your team: players Alive, Medium-term prediction, Percentage\n"
				"100% \xb7 (YAMQ / YTS)",

				"(#12) Your team: players Alive, Medium-term prediction, Quantity\n"
				"YAQ + dead players of your team who respawn in the medium term",

				"(#13) Opp. team: players Alive, Medium-term prediction, Percentage\n"
				"100% \xb7 (OAMQ / OTS)",

				"(#14) Opp. team: players Alive, Medium-term prediction, Quantity\n"
				"OAQ + dead players of the opp. team who respawn in the medium term",

				"(#15) Balance of players Alive, Medium-term prediction, Percentage\n"
				"YAMP - OAMP",

				"(#16) Balance of players Alive, Medium-term prediction, Quantity\n"
				"YAMQ - OAMQ",

				"(#17) Your team: players Alive, Long-term prediction, Percentage\n"
				"100% \xb7 (YALQ / YTS)",

				"(#18) Your team: players Alive, Long-term prediction, Quantity\n"
				"YAQ + dead players of your team who respawn in the long term",

				"(#19) Opposing team: players Alive, Long-term prediction, Percentage\n"
				"100% \xb7 (OALQ / OTS)",

				"(#20) Opposing team: players Alive, Long-term prediction, Quantity\n"
				"OAQ + dead players of the opp. team who respawn in the long term",

				"(#21) Balance of players Alive, Long-term prediction, Percentage\n"
				"YALP - OALP",

				"(#22) Balance of players Alive, Long-term prediction, Quantity\n"
				"YALQ - OALQ",

				"(#23) Balance of players Alive, Medium-term Tendency\n"
				"100% \xb7 [(BAMQ - BAQ) / (YTS + OTS)]",

				"(#24) Balance of players Alive, Long-term Tendency\n"
				"100% \xb7 [(BALQ - BAQ) / (YTS + OTS)]",

				"(#25) Readiness For Attack, Percentage\n"
				"100% \xb7 (RFAQ / YTS)",

				"(#26) Readiness For Attack, Quantity\n"
				"number of players in your team who are ready for attack",

				"(#27) Readiness For Defence, Percentage\n"
				"100% \xb7 (RFDQ / YTS)",

				"(#28) Readiness For Defence, Quantity\n"
				"number of players in your team who are ready for defence",

				"(#29) Fight INtensity\n"
				"100% \xb7 [(number of fighting players in your team) / YAQ]",

				"(#30) tidiness\n"
				"100% \xb7 [(number of co-operating players in your team) / YAQ]",

				"(#31) AVerage STamina\n"
				"100% \xb7 [(total stamina of players alive in your team) / YAQ]",

				"(#32) time left\n"
				"number of minutes (max. 100), or 999 if there's no time limit",

				"(#33) Your team's Remaining Score\n"
				"max. 100, or 999 if there's no score limit",

				"(#34) Opposing team's Remaining Score\n"
				"max. 100, or 999 if there's no score limit",

				"(#35) SCore Balance\n"
				"your team's score - opposing team's score",

				"(#36) Your team's Flag: Status\n"
				"at base = 1-bas, dropped = 2-dro, taken = 3-tak",

				"(#37) Opposing team's Flag: Status\n"
				"at base = 1-bas, dropped = 2-dro, taken = 3-tak",

				"(#38) Your team's Flag: Position\n"
				"at opponent's base = -100 ... at home base = +100",

				"(#39) Opposing team's Flag: Position\n"
				"at opponent's base = -100 ... at home base = +100"
			};

			if (!cgs.clientinfo[cg.clientNum].teamLeader) goto AccessDenied;
#if !TSSINCVAR
			if (cg.tssPureServer) goto PureServer;
#endif

			if (cg.tssOnline) {
				TSS_Print("\n");
			}
			else {
				TSS_Print("(Mission control is off-line, so only a few measures are valid.)\n");
			}
			TSS_Print("\n\n\n");
			selectedMagnitude = TSSTM_no;
			col = 0;
			startLine = cg.tssPrintLine;
			lastLine = TSS_H / SMALLCHAR_HEIGHT - 1;
			for (i = 1; i < TSSTM_num_magnitudes; i++) {
				static const char* const inspectorControllerNames[2] = {
					"-", "*"
				};

				if (!TSS_IsTacticalMagnitudeAllowed(i)) continue;

				cg.tssPrintCol = col;
				TSS_ListPar((int*)&cg.tssInspectMagnitude[i], 0, 1, inspectorControllerNames);
				TSS_PrintTacticalMeasure(i, &cg.tssMeasures);

				if (
					cg.tssPrintLine == cg.tssCursorLine &&
					col <= cg.tssCursorCol &&
					cg.tssCursorCol < cg.tssPrintCol
				) {
					selectedMagnitude = i;
				}

				TSS_Print("\n");
				if (cg.tssPrintLine > lastLine) {
					cg.tssPrintLine = startLine;
					col += 14;
				}
			}

			if (selectedMagnitude > TSSTM_no) {
				cg.tssPrintLine = startLine - 3;
				cg.tssPrintCol = 0;
				TSS_Print(helpLine[selectedMagnitude]);
				TSS_Print("\n");
			}
		}
		break;
	}

	Exit:
	return;
}

/*
=================
CG_TSS_PressButton
=================
*/
static void CG_TSS_PressButton(void) {
	char buf[128];

	if (!cg.tssCurrentValue) return;

	trap_S_StartSound(NULL, cg.clientNum, CHAN_BODY, cgs.media.useNothingSound);

	switch (cg.tssButtonID) {
	case TSSBID_RESUMEGAME:
		CG_TSS_CloseInterface();
		break;
	case TSSBID_CALLLEADERVOTE:
		Com_sprintf(buf, sizeof(buf), "callteamvote leader \"%s\"", cg.tssTeamMateList[cg.tssCallVoteLeader]);
		trap_SendClientCommand(buf);
		break;
	case TSSBID_CALLSURRENDERVOTE:
		trap_SendClientCommand("callteamvote surrender");
		break;
	case TSSBID_VOTE_YES:
		trap_SendClientCommand("teamvote y");
		break;
	case TSSBID_VOTE_NO:
		trap_SendClientCommand("teamvote n");
		break;
	case TSSBID_NAVAID_ON:
		trap_SendClientCommand("navaid 1");
		break;
	case TSSBID_NAVAID_OFF:
		trap_SendClientCommand("navaid 0");
		break;
	case TSSBID_GROUPFORMATION_TIGHT:
		trap_SendClientCommand("groupformation tight");
		break;
	case TSSBID_GROUPFORMATION_LOOSE:
		trap_SendClientCommand("groupformation loose");
		break;
	case TSSBID_GROUPFORMATION_FREE:
		trap_SendClientCommand("groupformation free");
		break;
	case TSSBID_SAFETYMODE:
		trap_SendClientCommand("tssSafetyMode");	// toggles safety mode
		break;
	case TSSBID_CREATE_STRATEGY:
		TSS_CreateStrategy();
		break;
	case TSSBID_DUPLICATE_STRATEGY:
		TSS_DuplicateStrategy();
		break;
	case TSSBID_UTILIZE_STRATEGY:
		cg.tssUtilizedStrategy = cg.tssSelectedStrategy;
		break;
	case TSSBID_REMOVE_STRATEGY:
		TSS_RemoveFromPalette(cg.tssSelectedStrategy);
		break;
	case TSSBID_CANCEL:
		TSS_CancelChanges();
		break;
	case TSSBID_APPLY:
		TSS_ApplyChanges();
		break;
	case TSSBID_INSERT_DIRECTIVE:
		TSS_InsertDirective(&cg.tssStrategyWorkCopy, cg.tssSelectedStrategy->directive);
		break;
	case TSSBID_DELETE_DIRECTIVE:
		TSS_DeleteDirective(&cg.tssStrategyWorkCopy, cg.tssSelectedStrategy->directive);
		break;
	case TSSBID_CLEAR_DIRECTIVE:
		TSS_ClearDirective(&cg.tssStrategyWorkCopy, cg.tssSelectedStrategy->directive);
		break;
	case TSSBID_COPY_DIRECTIVE:
		memcpy(
			&cg.tssDirectiveClipboard,
			&cg.tssStrategyWorkCopy.directives[cg.tssSelectedStrategy->directive],
			sizeof(tss_directive_t)
		);
		break;
	case TSSBID_PASTE_DIRECTIVE:
		memcpy(
			&cg.tssStrategyWorkCopy.directives[cg.tssSelectedStrategy->directive],
			&cg.tssDirectiveClipboard,
			sizeof(tss_directive_t)
		);
		if (cg.tssSelectedStrategy->directive == 0) {
			memset(cg.tssStrategyWorkCopy.directives[0].name, 0, TSS_NAME_SIZE);
			strcpy(cg.tssStrategyWorkCopy.directives[0].name, "default");
			memset(&cg.tssStrategyWorkCopy.directives[0].occasion, 0, sizeof(tss_occasion_t));
			cg.tssStrategyWorkCopy.directives[0].inUse = qtrue;
		}
		break;
	case TSSBID_SEARCH_SELECTED:
		if (cg.tssSelectedStrategy) {
			int sortIndex;

			sortIndex = CG_TSS_GetSortIndexByID(cg.tssSelectedStrategy->slot->id, cg.tssStrategyStockSortOrder);
			if (sortIndex >= 0) {
				TSS_SetStockWindow((TSS_STOCK_WINDOW_SIZE-1)/2, sortIndex);
				Com_sprintf(searchIDBuf, sizeof(searchIDBuf), "%03d", cg.tssSelectedStrategy->slot->id);
			}
		}
		break;
	case TSSBID_JOIN_RED:
		trap_SendClientCommand("team red");
		break;
	case TSSBID_JOIN_BLUE:
		trap_SendClientCommand("team blue");
		break;
	case TSSBID_AUTOGLC_ON:
		trap_Cvar_Set("cg_autoGLC", "1");
		break;
	case TSSBID_AUTOGLC_OFF:
		trap_Cvar_Set("cg_autoGLC", "0");
		break;
	default:
		if (
			cg.tssButtonID >= TSSBID_ADD_STRATEGY &&
			cg.tssButtonID < TSSBID_ADD_STRATEGY + TSS_STOCK_WINDOW_SIZE
		) {
			TSS_AddToPalette(TSS_GetSlotAtStockPos(cg.tssButtonID - TSSBID_ADD_STRATEGY));
		}
		break;
	}
}

/*
=================
CG_TSS_OpenInterface
=================
*/
void CG_TSS_OpenInterface(void) {

	if ( cgs.gametype < GT_TEAM || cg.showScores ||	cg.predictedPlayerState.pm_type == PM_INTERMISSION ) return;

	groupOrganizationChanged = qfalse;

	cg.tssInterfaceOn = qtrue;
	cg.tssLastUpdate = 0;
	cg.tssKeyEventSeq = -1;
	cg.tssMouseEventSeq = -1;
	cg.tssCurrentValue = NULL;
	cg.tssMouseX = TSS_MOUSE_FACTOR * (TSS_X + SMALLCHAR_WIDTH * (cg.tssCursorCol + 0.5));
	cg.tssMouseY = TSS_MOUSE_FACTOR * (TSS_Y + SMALLCHAR_HEIGHT * (cg.tssCursorLine + 0.5));

	CG_TSS_UpdateInterface();

	trap_Key_SetCatcher(trap_Key_GetCatcher() | TSS_KEYCATCHER);
	trap_SendConsoleCommand("tssiopen\n");

	lastKey = -1;
	altKey = 0;
}

/*
=================
CG_TSS_CloseInterface
=================
*/
void CG_TSS_CloseInterface(void) {

	TSS_ApplyChanges();
	cg.tssInterfaceOn = qfalse;

	trap_SendConsoleCommand("tssiclose\n");

	lastKey = -1;
	altKey = 0;

	#if TSSINCVAR
		TSS_SaveInterfaceIfNeeded();
	#endif
}

/*
=================
CG_TSS_KeyEvent
=================
*/
void CG_TSS_KeyEvent(int key, qboolean down) {

	int oldCol, oldLine;
	int oldValue;
	qboolean keyRepeated;
	qboolean changesMade;

	if (!cg.tssInterfaceOn) return;

	oldCol = cg.tssCursorCol;
	oldLine = cg.tssCursorLine;
	oldValue = 0;
	changesMade = qfalse;

	if (cg.tssCurrentValue) oldValue = *cg.tssCurrentValue;

	if (!down) {
		lastKey = -1;
		if (key == K_ALT && altKey) {
			key = altKey & 255;
			altKey = 0;
			goto InsertKeyIntoTextField;
		}
		return;
	}
	if (key & K_CHAR_FLAG) {
		keyRepeated = qfalse;
	}
	else {
		keyRepeated = (key == lastKey);
		lastKey = key;
	}

	switch (key) {
	case K_F12:
		CG_TSS_CloseInterface();
		break;
	case K_F11:
		trap_SendConsoleCommand("screenshot\n");
		break;
	case K_LEFTARROW:
		if (trap_Key_IsDown(K_SHIFT) || trap_Key_IsDown(K_CTRL)) goto DecreaseValue;
		cg.tssCursorCol--;
		if (cg.tssCursorCol < 0) cg.tssCursorCol = 0;
		break;
	case K_RIGHTARROW:
		if (trap_Key_IsDown(K_SHIFT) || trap_Key_IsDown(K_CTRL)) goto IncreaseValue;
		cg.tssCursorCol++;
		if (SMALLCHAR_WIDTH * cg.tssCursorCol >= TSS_W) cg.tssCursorCol--;
		break;
	case K_UPARROW:
		if (trap_Key_IsDown(K_SHIFT) || trap_Key_IsDown(K_CTRL)) goto IncreaseValue;
		cg.tssCursorLine--;
		if (cg.tssCursorLine < 0) cg.tssCursorLine = 0;
		break;
	case K_DOWNARROW:
		if (trap_Key_IsDown(K_SHIFT) || trap_Key_IsDown(K_CTRL)) goto DecreaseValue;
		cg.tssCursorLine++;
		if (SMALLCHAR_HEIGHT * cg.tssCursorLine >= TSS_H) cg.tssCursorLine--;
		break;
	case K_HOME:
		if (trap_Key_IsDown(K_SHIFT) || trap_Key_IsDown(K_CTRL)) {
			if (cg.tssCurrentValue) {
				*cg.tssCurrentValue = cg.tssCurrentValueMin;
				if (cg.tssCurrentValueReversedHome) {
					*cg.tssCurrentValue = cg.tssCurrentValueMax;
				}
			}
			else {
				cg.tssCursorCol = 0;
				cg.tssCursorLine = 0;
			}
		}
		else if (cg.tssCurrentTextField) {
			cg.tssCursorCol = cg.tssCurrentParStartCol;
		}
		else {
			cg.tssCursorCol = 0;
		}
		break;
	case K_END:
		if (trap_Key_IsDown(K_SHIFT) || trap_Key_IsDown(K_CTRL)) {
			if (cg.tssCurrentValue) {
				*cg.tssCurrentValue = cg.tssCurrentValueMax;
				if (cg.tssCurrentValueReversedHome) {
					*cg.tssCurrentValue = cg.tssCurrentValueMin;
				}
			}
			else {
				cg.tssCursorCol = 0;
				cg.tssCursorLine = TSS_H / SMALLCHAR_HEIGHT - 1;
			}
		}
		else if (cg.tssCurrentTextField) {
			cg.tssCursorCol = cg.tssCurrentParStartCol + strlen(cg.tssCurrentTextField);
		}
		else {
			cg.tssCursorCol = cg.tssCursorLineEnd;
		}
		break;
	case K_ENTER:
	case K_KP_ENTER:
	case K_SPACE:
	case K_MOUSE1:
	case K_MOUSE2:
		if (cg.tssButtonID < 0) {
			if (cg.tssCurrentValue && !keyRepeated && !cg.tssCurrentTextField) {
				if (cg.tssCurrentValueMax - cg.tssCurrentValueMin == 1) {
					trap_S_StartSound(NULL, cg.clientNum, CHAN_BODY, cgs.media.useNothingSound);
					if (*cg.tssCurrentValue == cg.tssCurrentValueMin) {
						*cg.tssCurrentValue = cg.tssCurrentValueMax;
					}
					else {
						*cg.tssCurrentValue = cg.tssCurrentValueMin;
					}
				}
			}
		}
		else if (!keyRepeated) {
			CG_TSS_PressButton();
			changesMade = qtrue;
		}
		break;
	case K_TAB:
		if (trap_Key_IsDown(K_SHIFT) || trap_Key_IsDown(K_CTRL)) {
			if (cg.tssPrevValueCol >= 0 && cg.tssPrevValueLine >= 0) {
				cg.tssCursorCol = cg.tssPrevValueCol;
				cg.tssCursorLine = cg.tssPrevValueLine;
			}
		}
		else {
			if (cg.tssNextValueCol >= 0 && cg.tssNextValueLine >= 0) {
				cg.tssCursorCol = cg.tssNextValueCol;
				cg.tssCursorLine = cg.tssNextValueLine;
			}
		}
		break;
	case K_BACKSPACE:
	case K_DEL:
		if (cg.tssCurrentTextField) {
			int n, pos;

			n = strlen(cg.tssCurrentTextField);
			pos = cg.tssCursorCol - cg.tssCurrentParStartCol;
			if (key == K_DEL || key == K_KP_DEL) pos++;

			if (pos > 0) {
				if (pos <= n) {
					int i;

					for (i = pos-1; i < n; i++) {
						cg.tssCurrentTextField[i] = cg.tssCurrentTextField[i+1];
					}

					changesMade = qtrue;
					if (cg.tssCurrentTextFieldChanged) {
						*cg.tssCurrentTextFieldChanged = qtrue;
					}
				}
				pos--;
				cg.tssCursorCol = cg.tssCurrentParStartCol + pos;
			}
		}
		else if (cg.tssCurrentValue) {
			*cg.tssCurrentValue = 0;
			if (*cg.tssCurrentValue < cg.tssCurrentValueMin) {
				*cg.tssCurrentValue = cg.tssCurrentValueMin;
			}
			if (*cg.tssCurrentValue > cg.tssCurrentValueMax) {
				*cg.tssCurrentValue = cg.tssCurrentValueMax;
			}
		}
		break;
	case K_PGUP:
	case K_KP_PLUS:
	case K_MWHEELUP:
	IncreaseValue:
		if (cg.tssCurrentValue) {
			int step;

			step = trap_Key_IsDown(K_CTRL)? 5 : 1;
			*cg.tssCurrentValue += step;
			if (*cg.tssCurrentValue > cg.tssCurrentValueMax) {
				*cg.tssCurrentValue = cg.tssCurrentValueMax;
				if (cg.tssCurrentValueMax - cg.tssCurrentValueMin <= 1) {
					*cg.tssCurrentValue = cg.tssCurrentValueMin;
				}
			}
		}
		break;
	case K_PGDN:
	case K_KP_MINUS:
	case K_MWHEELDOWN:
	DecreaseValue:
		if (cg.tssCurrentValue) {
			int step;

			step = trap_Key_IsDown(K_CTRL)? 5 : 1;
			*cg.tssCurrentValue -= step;
			if (*cg.tssCurrentValue < cg.tssCurrentValueMin) {
				*cg.tssCurrentValue = cg.tssCurrentValueMin;
				if (cg.tssCurrentValueMax - cg.tssCurrentValueMin <= 1) {
					*cg.tssCurrentValue = cg.tssCurrentValueMax;
				}
			}
		}
		break;
	case K_KP_INS:
		if (trap_Key_IsDown(K_ALT)) {
			altKey = altKey * 10;
		}
		break;
	case K_KP_END:
		if (trap_Key_IsDown(K_ALT)) {
			altKey = altKey * 10 + 1;
		}
		break;
	case K_KP_DOWNARROW:
		if (trap_Key_IsDown(K_ALT)) {
			altKey = altKey * 10 + 2;
		}
		break;
	case K_KP_PGDN:
		if (trap_Key_IsDown(K_ALT)) {
			altKey = altKey * 10 + 3;
		}
		break;
	case K_KP_LEFTARROW:
		if (trap_Key_IsDown(K_ALT)) {
			altKey = altKey * 10 + 4;
		}
		break;
	case K_KP_5:
		if (trap_Key_IsDown(K_ALT)) {
			altKey = altKey * 10 + 5;
		}
		break;
	case K_KP_RIGHTARROW:
		if (trap_Key_IsDown(K_ALT)) {
			altKey = altKey * 10 + 6;
		}
		break;
	case K_KP_HOME:
		if (trap_Key_IsDown(K_ALT)) {
			altKey = altKey * 10 + 7;
		}
		break;
	case K_KP_UPARROW:
		if (trap_Key_IsDown(K_ALT)) {
			altKey = altKey * 10 + 8;
		}
		break;
	case K_KP_PGUP:
		if (trap_Key_IsDown(K_ALT)) {
			altKey = altKey * 10 + 9;
		}
		break;
	/*
	case '0':
	case '1':
	case '2':
	case '3':
	case '4':
	case '5':
	case '6':
	case '7':
	case '8':
	case '9':
	SetDigit:
		{
			int base;
			int i;
			int v;
			qboolean neg;

			if (!cg.tssCurrentValue || cg.tssCurrentValueLastCol < 0) return;

			base = 1;
			for (i = cg.tssCursorCol; i < cg.tssCurrentValueLastCol; i++) {
				base *= 10;
				if (base >= 10000) break;
			}

			v = *cg.tssCurrentValue;
			if (v < 0) {
				neg = qtrue;
				v = -v;
			}
			else {
				neg = qfalse;
			}
			// set the choosen digit to zero
			v -= v % (10*base) - v % base;
			// add the new digit
			v += (key - '0') * base;
			// set the sign
			if (neg) v = -v;

			if (v < cg.tssCurrentValueMin) v = cg.tssCurrentValueMin;
			else if (v > cg.tssCurrentValueMax) v = cg.tssCurrentValueMax;
			*cg.tssCurrentValue = v;

			if (cg.tssCursorCol < cg.tssCurrentValueLastCol) cg.tssCursorCol++;
		}
		break;
	*/
	default:
		if (
			key & K_CHAR_FLAG
		) {
			int i, pos;

			key &= ~K_CHAR_FLAG;

			if (!cg.tssCurrentTextField) {
				if (key == '+' && cg.tssCurrentValue) goto IncreaseValue;
				if (key == '-' && cg.tssCurrentValue) goto DecreaseValue;
				goto Exit;
			}

			InsertKeyIntoTextField:
			if (key < 32) goto Exit;

			i = strlen(cg.tssCurrentTextField);
			pos = cg.tssCursorCol - cg.tssCurrentParStartCol;
			if (i < cg.tssCurrentParWidth-1 && pos < cg.tssCurrentParWidth-1) {
				while (i < pos) {
					cg.tssCurrentTextField[i] = 32;
					i++;
				}
				cg.tssCurrentTextField[i] = 0;
				for (i++; i > pos; i--) {
					cg.tssCurrentTextField[i] = cg.tssCurrentTextField[i-1];
				}
				cg.tssCurrentTextField[pos] = key;
				pos++;
				cg.tssCursorCol = cg.tssCurrentParStartCol + pos;

				changesMade = qtrue;
				if (cg.tssCurrentTextFieldChanged) {
					*cg.tssCurrentTextFieldChanged = qtrue;
				}
			}
		}
		break;
	}

	Exit:
	if (changesMade && cg.tssCurrentTextField) {
		// remove trailing spaces
		int i;

		i = strlen(cg.tssCurrentTextField) - 1;
		while (i >= 0) {
			if (cg.tssCurrentTextField[i] != 32) break;

			cg.tssCurrentTextField[i] = 0;
			i--;
		}
	}
	if (cg.tssCurrentValue && *cg.tssCurrentValue != oldValue) {
		changesMade = qtrue;
		if (cg.tssCurrentValueChanged) {
			*cg.tssCurrentValueChanged = qtrue;
		}
	}
	TSS_CheckModifications();
	if (changesMade && cg.tssSelectedStrategy) {
		cg.tssStrategyWorkCopyChanged = TSS_MemCmp(
			&cg.tssStrategyWorkCopy, cg.tssSelectedStrategy->strategy, sizeof(tss_strategy_t)
		);
	}

	if (cg.tssCursorCol != oldCol || cg.tssCursorLine != oldLine) {
		cg.tssMouseX = TSS_MOUSE_FACTOR * (SMALLCHAR_WIDTH * (cg.tssCursorCol + 0.5) + TSS_X);
		cg.tssMouseY = TSS_MOUSE_FACTOR * (SMALLCHAR_HEIGHT * (cg.tssCursorLine + 0.5) + TSS_Y);
		if (
			cg.tssCursorLine != oldLine ||
			cg.tssCursorCol < cg.tssCurrentParStartCol ||
			cg.tssCursorCol >= cg.tssCurrentParStartCol + cg.tssCurrentParWidth
		) {
			cg.tssCurrentValue = NULL;
			cg.tssCurrentTextField = NULL;
			cg.tssCurrentValueChanged = NULL;
			cg.tssNextValueCol = -1;
			cg.tssNextValueLine = -1;
			cg.tssPrevValueCol = -1;
			cg.tssPrevValueLine = -1;
		}
	}
}

/*
=================
CG_TSS_MouseEvent
=================
*/
void CG_TSS_MouseEvent(int dx, int dy) {
	if (!cg.tssInterfaceOn) return;

	cg.tssMouseX += dx;
	cg.tssMouseY += dy;
	if (cg.tssMouseX < TSS_MOUSE_FACTOR * TSS_X) cg.tssMouseX = TSS_MOUSE_FACTOR * TSS_X;
	if (cg.tssMouseX >= TSS_MOUSE_FACTOR * (TSS_X + TSS_W)) cg.tssMouseX = TSS_MOUSE_FACTOR * (TSS_X + TSS_W) - 1;
	if (cg.tssMouseY < TSS_MOUSE_FACTOR * TSS_Y) cg.tssMouseY = TSS_MOUSE_FACTOR * TSS_Y;
	if (cg.tssMouseY >= TSS_MOUSE_FACTOR * (TSS_Y + TSS_H)) cg.tssMouseY = TSS_MOUSE_FACTOR * (TSS_Y + TSS_H) - 1;

	cg.tssCursorCol = (cg.tssMouseX / TSS_MOUSE_FACTOR - TSS_X) / SMALLCHAR_WIDTH;
	cg.tssCursorLine = (cg.tssMouseY / TSS_MOUSE_FACTOR - TSS_Y) / SMALLCHAR_HEIGHT;
}

typedef struct {
	int sequence;
	int data1;
	int data2;
} cg_tssiEvent_t;
#define TSSI_EVENTBUFFER_SIZE 10
typedef struct {
	vmCvar_t* cvar;
	cg_tssiEvent_t events[TSSI_EVENTBUFFER_SIZE];
} cg_tssiEventBuffer_t;

/*
=================
TSS_ParseNumber
=================
*/
static const char* TSS_ParseNumber(const char* buf, int* number) {
	*number = -1;

	if (!buf) return NULL;
	if ((*buf < '0' || *buf > '9') && *buf != '-') return NULL;

	*number = atoi(buf);

	while (*buf == '-' || (*buf >= '0' && *buf <= '9')) {
		buf++;
	}
	while (*buf == '/') buf++;
	return buf;
}

/*
=================
TSS_ParseEvent
=================
*/
static const char* TSS_ParseEvent(const char* buf, cg_tssiEvent_t* event) {
	buf = TSS_ParseNumber(buf, &event->sequence);
	buf = TSS_ParseNumber(buf, &event->data1);
	buf = TSS_ParseNumber(buf, &event->data2);
	return buf;
}

/*
=================
TSS_ParseEvents
=================
*/
static int TSS_ParseEvents(cg_tssiEventBuffer_t* buffer) {
	int i;
	const char* s;
	int maxSeq;

	if (!buffer->cvar) return -1;

	s = TSS_ParseNumber(buffer->cvar->string, &maxSeq);
	for (i = 0; i < TSSI_EVENTBUFFER_SIZE; i++) {
		s = TSS_ParseEvent(s, &buffer->events[i]);
	}
	return maxSeq;
}

/*
=================
CG_TSS_CheckKeyEvents
=================
*/
void CG_TSS_CheckKeyEvents(void) {
	cg_tssiEventBuffer_t buffer;
	int newSeq;
	int i;

	if (cg_tssiKey.string[0] == '*') {
		CG_TSS_CloseInterface();
		return;
	}

	buffer.cvar = &cg_tssiKey;
	newSeq = TSS_ParseEvents(&buffer);
	if (newSeq < 0) return;

	for (i = 0; i < TSSI_EVENTBUFFER_SIZE; i++) {
		cg_tssiEvent_t* event;

		event = &buffer.events[i];
		if (event->sequence <= cg.tssKeyEventSeq) continue;

		CG_TSS_KeyEvent(event->data1, event->data2);
	}

	cg.tssKeyEventSeq = newSeq;
}

/*
=================
CG_TSS_CheckMouseEvents
=================
*/
void CG_TSS_CheckMouseEvents(void) {
	cg_tssiEventBuffer_t buffer;
	int newSeq;
	int i;

	if (cg_tssiMouse.string[0] == '*') {
		CG_TSS_CloseInterface();
		return;
	}

	buffer.cvar = &cg_tssiMouse;
	newSeq = TSS_ParseEvents(&buffer);
	if (newSeq < 0) return;

	for (i = 0; i < TSSI_EVENTBUFFER_SIZE; i++) {
		cg_tssiEvent_t* event;

		event = &buffer.events[i];
		if (event->sequence <= cg.tssMouseEventSeq) continue;

		CG_TSS_MouseEvent(event->data1, event->data2);
	}

	cg.tssMouseEventSeq = newSeq;
}
