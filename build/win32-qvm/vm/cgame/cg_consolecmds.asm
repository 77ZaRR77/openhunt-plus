export CG_TargetCommand_f
code
proc CG_TargetCommand_f 20 12
file "..\..\..\..\code\cgame\cg_consolecmds.c"
line 14
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_consolecmds.c -- text commands typed in at the local console, or
;4:// executed by a key binding
;5:
;6:#include "cg_local.h"
;7:#include "../ui/ui_shared.h"
;8:#ifdef MISSIONPACK
;9:extern menuDef_t *menuScoreboard;
;10:#endif
;11:
;12:
;13:
;14:void CG_TargetCommand_f( void ) {
line 18
;15:	int		targetNum;
;16:	char	test[4];
;17:
;18:	targetNum = CG_CrosshairPlayer();
ADDRLP4 8
ADDRGP4 CG_CrosshairPlayer
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 19
;19:	if (!targetNum ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $134
line 20
;20:		return;
ADDRGP4 $133
JUMPV
LABELV $134
line 23
;21:	}
;22:
;23:	trap_Argv( 1, test, 4 );
CNSTI4 1
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 24
;24:	trap_SendConsoleCommand( va( "gc %i %i", targetNum, atoi( test ) ) );
ADDRLP4 4
ARGP4
ADDRLP4 12
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 $136
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 25
;25:}
LABELV $133
endproc CG_TargetCommand_f 20 12
proc CG_SizeUp_f 4 8
line 36
;26:
;27:
;28:
;29:/*
;30:=================
;31:CG_SizeUp_f
;32:
;33:Keybinding command
;34:=================
;35:*/
;36:static void CG_SizeUp_f (void) {
line 37
;37:	trap_Cvar_Set("cg_viewsize", va("%i",(int)(cg_viewsize.integer+10)));
ADDRGP4 $139
ARGP4
ADDRGP4 cg_viewsize+12
INDIRI4
CNSTI4 10
ADDI4
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $138
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 38
;38:}
LABELV $137
endproc CG_SizeUp_f 4 8
proc CG_SizeDown_f 4 8
line 48
;39:
;40:
;41:/*
;42:=================
;43:CG_SizeDown_f
;44:
;45:Keybinding command
;46:=================
;47:*/
;48:static void CG_SizeDown_f (void) {
line 49
;49:	trap_Cvar_Set("cg_viewsize", va("%i",(int)(cg_viewsize.integer-10)));
ADDRGP4 $139
ARGP4
ADDRGP4 cg_viewsize+12
INDIRI4
CNSTI4 10
SUBI4
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $138
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 50
;50:}
LABELV $141
endproc CG_SizeDown_f 4 8
proc CG_Viewpos_f 0 20
line 60
;51:
;52:
;53:/*
;54:=============
;55:CG_Viewpos_f
;56:
;57:Debugging command to print the current position
;58:=============
;59:*/
;60:static void CG_Viewpos_f (void) {
line 61
;61:	CG_Printf ("(%i %i %i) : %i\n", (int)cg.refdef.vieworg[0],
ADDRGP4 $144
ARGP4
ADDRGP4 cg+109260+24
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 cg+109260+24+4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 cg+109260+24+8
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 cg+109628+4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 64
;62:		(int)cg.refdef.vieworg[1], (int)cg.refdef.vieworg[2], 
;63:		(int)cg.refdefViewAngles[YAW]);
;64:}
LABELV $143
endproc CG_Viewpos_f 0 20
proc CG_ScoresDown_f 4 4
line 67
;65:
;66:
;67:static void CG_ScoresDown_f( void ) {
line 71
;68:
;69:	// JUHOX: toggle lens flare editor move mode
;70:#if MAPLENSFLARES
;71:	if (cgs.editMode == EM_mlf) {
ADDRGP4 cgs+31684
INDIRI4
CNSTI4 1
NEI4 $156
line 73
;72:		if (
;73:			cg.lfEditor.selectedLFEnt &&
ADDRGP4 cg+109660
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $155
ADDRGP4 cg+109660+256
INDIRI4
CNSTI4 0
NEI4 $155
ADDRGP4 cg+109660+8
INDIRI4
CNSTI4 0
LEI4 $155
line 76
;74:			cg.lfEditor.cmdMode == LFECM_main &&
;75:			cg.lfEditor.editMode > LFEEM_none
;76:		) {
line 77
;77:			CG_SetLFEdMoveMode(!cg.lfEditor.moveMode);
ADDRGP4 cg+109660+12
INDIRI4
CNSTI4 0
NEI4 $169
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $170
JUMPV
LABELV $169
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $170
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_SetLFEdMoveMode
CALLV
pop
line 78
;78:		}
line 79
;79:		return;
ADDRGP4 $155
JUMPV
LABELV $156
line 86
;80:	}
;81:#endif
;82:
;83:#ifdef MISSIONPACK
;84:		CG_BuildSpectatorString();
;85:#endif
;86:	if ( cg.scoresRequestTime + 2000 < cg.time ) {
ADDRGP4 cg+113508
INDIRI4
CNSTI4 2000
ADDI4
ADDRGP4 cg+107656
INDIRI4
GEI4 $171
line 89
;87:		// the scores are more than two seconds out of data,
;88:		// so request new ones
;89:		cg.scoresRequestTime = cg.time;
ADDRGP4 cg+113508
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 90
;90:		trap_SendClientCommand( "score" );
ADDRGP4 $177
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 94
;91:
;92:		// leave the current scores up if they were already
;93:		// displayed, but if this is the first hit, clear them out
;94:		if ( !cg.showScores ) {
ADDRGP4 cg+117624
INDIRI4
CNSTI4 0
NEI4 $172
line 95
;95:			cg.showScores = qtrue;
ADDRGP4 cg+117624
CNSTI4 1
ASGNI4
line 96
;96:			cg.numScores = 0;
ADDRGP4 cg+113512
CNSTI4 0
ASGNI4
line 97
;97:		}
line 98
;98:	} else {
ADDRGP4 $172
JUMPV
LABELV $171
line 101
;99:		// show the cached contents even if they just pressed if it
;100:		// is within two seconds
;101:		cg.showScores = qtrue;
ADDRGP4 cg+117624
CNSTI4 1
ASGNI4
line 102
;102:	}
LABELV $172
line 103
;103:}
LABELV $155
endproc CG_ScoresDown_f 4 4
proc CG_ScoresUp_f 0 0
line 105
;104:
;105:static void CG_ScoresUp_f( void ) {
line 106
;106:	if ( cg.showScores ) {
ADDRGP4 cg+117624
INDIRI4
CNSTI4 0
EQI4 $185
line 107
;107:		cg.showScores = qfalse;
ADDRGP4 cg+117624
CNSTI4 0
ASGNI4
line 108
;108:		cg.scoreFadeTime = cg.time;
ADDRGP4 cg+117632
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 109
;109:	}
LABELV $185
line 110
;110:}
LABELV $184
endproc CG_ScoresUp_f 0 0
proc CG_SaveLensFlareEntities_f 1080 56
line 118
;111:
;112:/*
;113:=================
;114:JUHOX: CG_SaveLensFlareEntities_f
;115:=================
;116:*/
;117:#if MAPLENSFLARES
;118:static void CG_SaveLensFlareEntities_f(void) {
line 125
;119:	char mapname[256];
;120:	char name[256];
;121:	fileHandle_t f;
;122:	int i;
;123:	int n;
;124:
;125:	if (cgs.editMode != EM_mlf) return;
ADDRGP4 cgs+31684
INDIRI4
CNSTI4 1
EQI4 $192
ADDRGP4 $191
JUMPV
LABELV $192
line 127
;126:
;127:	trap_Cvar_VariableStringBuffer("mapname", mapname, sizeof(mapname));
ADDRGP4 $195
ARGP4
ADDRLP4 268
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 128
;128:	Com_sprintf(name, sizeof(name), "flares/%s.lfe", mapname);
ADDRLP4 12
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $196
ARGP4
ADDRLP4 268
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 130
;129:
;130:	trap_FS_FOpenFile(name, &f, FS_WRITE);
ADDRLP4 12
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 trap_FS_FOpenFile
CALLI4
pop
line 131
;131:	if (!f) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $197
line 132
;132:		CG_Printf("Could not create '%s'\n", name);
ADDRGP4 $199
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 133
;133:		return;
ADDRGP4 $191
JUMPV
LABELV $197
line 135
;134:	}
;135:	CG_Printf("writing '%s'...\n", name);
ADDRGP4 $200
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 137
;136:
;137:	n = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 138
;138:	for (i = 0; i < cgs.numLensFlareEntities; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $204
JUMPV
LABELV $201
line 144
;139:		const lensFlareEntity_t* lfent;
;140:		char buf[512];
;141:		char lockOption[16];
;142:		char lightRadius[16];
;143:
;144:		lfent = &cgs.lensFlareEntities[i];
ADDRLP4 524
ADDRLP4 0
INDIRI4
CNSTI4 184
MULI4
ADDRGP4 cgs+562800
ADDP4
ASGNP4
line 145
;145:		if (!lfent->lfeff) continue;
ADDRLP4 524
INDIRP4
CNSTI4 44
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $207
ADDRGP4 $202
JUMPV
LABELV $207
line 147
;146:
;147:		if (lfent->lock) {
ADDRLP4 524
INDIRP4
CNSTI4 12
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $209
line 148
;148:			Com_sprintf(lockOption, sizeof(lockOption), "mv %d ", lfent->lock->currentState.number);
ADDRLP4 1040
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $211
ARGP4
ADDRLP4 524
INDIRP4
CNSTI4 12
ADDP4
INDIRP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 149
;149:		}
ADDRGP4 $210
JUMPV
LABELV $209
line 150
;150:		else {
line 151
;151:			lockOption[0] = 0;
ADDRLP4 1040
CNSTI1 0
ASGNI1
line 152
;152:		}
LABELV $210
line 154
;153:
;154:		if (lfent->lightRadius > 1) {
ADDRLP4 524
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
CNSTF4 1065353216
LEF4 $212
line 155
;155:			Com_sprintf(lightRadius, sizeof(lightRadius), "lr %f ", lfent->lightRadius);
ADDRLP4 1056
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $214
ARGP4
ADDRLP4 524
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ARGF4
ADDRGP4 Com_sprintf
CALLV
pop
line 156
;156:		}
ADDRGP4 $213
JUMPV
LABELV $212
line 157
;157:		else {
line 158
;158:			lightRadius[0] = 0;
ADDRLP4 1056
CNSTI1 0
ASGNI1
line 159
;159:		}
LABELV $213
line 161
;160:
;161:		Com_sprintf(
ADDRLP4 528
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 $215
ARGP4
ADDRLP4 524
INDIRP4
CNSTI4 44
ADDP4
INDIRP4
ARGP4
ADDRLP4 524
INDIRP4
INDIRF4
ARGF4
ADDRLP4 524
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 524
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 524
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ARGF4
ADDRLP4 524
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ARGF4
ADDRLP4 524
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ARGF4
ADDRLP4 524
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ARGF4
ADDRLP4 524
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ARGF4
ADDRLP4 1040
ARGP4
ADDRLP4 1056
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 170
;162:			buf, sizeof(buf), "{ %s %f %f %f %f %f %f %f %f %s%s}\n",
;163:			lfent->lfeff->name,
;164:			lfent->origin[0], lfent->origin[1], lfent->origin[2],
;165:			lfent->radius,
;166:			lfent->dir[0], lfent->dir[1], lfent->dir[2],
;167:			lfent->angle,
;168:			lockOption, lightRadius
;169:		);
;170:		trap_FS_Write(buf, strlen(buf), f);
ADDRLP4 528
ARGP4
ADDRLP4 1076
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 528
ARGP4
ADDRLP4 1076
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 172
;171:
;172:		n++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 173
;173:	}
LABELV $202
line 138
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $204
ADDRLP4 0
INDIRI4
ADDRGP4 cgs+562612
INDIRI4
LTI4 $201
line 174
;174:	trap_FS_FCloseFile(f);
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 176
;175:
;176:	CG_Printf("%d lens flare entities saved\n", n);
ADDRGP4 $216
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 177
;177:}
LABELV $191
endproc CG_SaveLensFlareEntities_f 1080 56
proc CG_RevertLensFlareEntities_f 0 0
line 186
;178:#endif
;179:
;180:/*
;181:=================
;182:JUHOX: CG_RevertLensFlareEntities_f
;183:=================
;184:*/
;185:#if MAPLENSFLARES
;186:static void CG_RevertLensFlareEntities_f(void) {
line 187
;187:	if (cgs.editMode != EM_mlf) return;
ADDRGP4 cgs+31684
INDIRI4
CNSTI4 1
EQI4 $218
ADDRGP4 $217
JUMPV
LABELV $218
line 189
;188:
;189:	CG_LoadLensFlareEntities();
ADDRGP4 CG_LoadLensFlareEntities
CALLV
pop
line 190
;190:}
LABELV $217
endproc CG_RevertLensFlareEntities_f 0 0
proc CG_UpdateLensFlares_f 0 0
line 199
;191:#endif
;192:
;193:/*
;194:=================
;195:JUHOX: CG_UpdateLensFlares_f
;196:=================
;197:*/
;198:#if MAPLENSFLARES
;199:static void CG_UpdateLensFlares_f(void) {
line 200
;200:	if (cgs.editMode != EM_mlf) return;
ADDRGP4 cgs+31684
INDIRI4
CNSTI4 1
EQI4 $222
ADDRGP4 $221
JUMPV
LABELV $222
line 202
;201:
;202:	CG_SaveLensFlareEntities_f();
ADDRGP4 CG_SaveLensFlareEntities_f
CALLV
pop
line 203
;203:	CG_LoadLensFlares();
ADDRGP4 CG_LoadLensFlares
CALLV
pop
line 204
;204:	CG_LoadLensFlareEntities();
ADDRGP4 CG_LoadLensFlareEntities
CALLV
pop
line 205
;205:}
LABELV $221
endproc CG_UpdateLensFlares_f 0 0
proc CG_TellTarget_f 264 20
line 273
;206:#endif
;207:
;208:#ifdef MISSIONPACK
;209:extern menuDef_t *menuScoreboard;
;210:void Menu_Reset();			// FIXME: add to right include file
;211:
;212:static void CG_LoadHud_f( void) {
;213:  char buff[1024];
;214:	const char *hudSet;
;215:  memset(buff, 0, sizeof(buff));
;216:
;217:	String_Init();
;218:	Menu_Reset();
;219:	
;220:	trap_Cvar_VariableStringBuffer("cg_hudFiles", buff, sizeof(buff));
;221:	hudSet = buff;
;222:	if (hudSet[0] == '\0') {
;223:		hudSet = "ui/hud.txt";
;224:	}
;225:
;226:	CG_LoadMenus(hudSet);
;227:  menuScoreboard = NULL;
;228:}
;229:
;230:
;231:static void CG_scrollScoresDown_f( void) {
;232:	if (menuScoreboard && cg.scoreBoardShowing) {
;233:		Menu_ScrollFeeder(menuScoreboard, FEEDER_SCOREBOARD, qtrue);
;234:		Menu_ScrollFeeder(menuScoreboard, FEEDER_REDTEAM_LIST, qtrue);
;235:		Menu_ScrollFeeder(menuScoreboard, FEEDER_BLUETEAM_LIST, qtrue);
;236:	}
;237:}
;238:
;239:
;240:static void CG_scrollScoresUp_f( void) {
;241:	if (menuScoreboard && cg.scoreBoardShowing) {
;242:		Menu_ScrollFeeder(menuScoreboard, FEEDER_SCOREBOARD, qfalse);
;243:		Menu_ScrollFeeder(menuScoreboard, FEEDER_REDTEAM_LIST, qfalse);
;244:		Menu_ScrollFeeder(menuScoreboard, FEEDER_BLUETEAM_LIST, qfalse);
;245:	}
;246:}
;247:
;248:
;249:static void CG_spWin_f( void) {
;250:	trap_Cvar_Set("cg_cameraOrbit", "2");
;251:	trap_Cvar_Set("cg_cameraOrbitDelay", "35");
;252:	trap_Cvar_Set("cg_thirdPerson", "1");
;253:	trap_Cvar_Set("cg_thirdPersonAngle", "0");
;254:	trap_Cvar_Set("cg_thirdPersonRange", "100");
;255:	CG_AddBufferedSound(cgs.media.winnerSound);
;256:	//trap_S_StartLocalSound(cgs.media.winnerSound, CHAN_ANNOUNCER);
;257:	CG_CenterPrint("YOU WIN!", SCREEN_HEIGHT * .30, 0);
;258:}
;259:
;260:static void CG_spLose_f( void) {
;261:	trap_Cvar_Set("cg_cameraOrbit", "2");
;262:	trap_Cvar_Set("cg_cameraOrbitDelay", "35");
;263:	trap_Cvar_Set("cg_thirdPerson", "1");
;264:	trap_Cvar_Set("cg_thirdPersonAngle", "0");
;265:	trap_Cvar_Set("cg_thirdPersonRange", "100");
;266:	CG_AddBufferedSound(cgs.media.loserSound);
;267:	//trap_S_StartLocalSound(cgs.media.loserSound, CHAN_ANNOUNCER);
;268:	CG_CenterPrint("YOU LOSE...", SCREEN_HEIGHT * .30, 0);
;269:}
;270:
;271:#endif
;272:
;273:static void CG_TellTarget_f( void ) {
line 278
;274:	int		clientNum;
;275:	char	command[128];
;276:	char	message[128];
;277:
;278:	clientNum = CG_CrosshairPlayer();
ADDRLP4 260
ADDRGP4 CG_CrosshairPlayer
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 260
INDIRI4
ASGNI4
line 279
;279:	if ( clientNum == -1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $226
line 280
;280:		return;
ADDRGP4 $225
JUMPV
LABELV $226
line 283
;281:	}
;282:
;283:	trap_Args( message, 128 );
ADDRLP4 132
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Args
CALLV
pop
line 284
;284:	Com_sprintf( command, 128, "tell %i %s", clientNum, message );
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $228
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 132
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 285
;285:	trap_SendClientCommand( command );
ADDRLP4 4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 286
;286:}
LABELV $225
endproc CG_TellTarget_f 264 20
proc CG_TellAttacker_f 264 20
line 288
;287:
;288:static void CG_TellAttacker_f( void ) {
line 293
;289:	int		clientNum;
;290:	char	command[128];
;291:	char	message[128];
;292:
;293:	clientNum = CG_LastAttacker();
ADDRLP4 260
ADDRGP4 CG_LastAttacker
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 260
INDIRI4
ASGNI4
line 294
;294:	if ( clientNum == -1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $230
line 295
;295:		return;
ADDRGP4 $229
JUMPV
LABELV $230
line 298
;296:	}
;297:
;298:	trap_Args( message, 128 );
ADDRLP4 132
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Args
CALLV
pop
line 299
;299:	Com_sprintf( command, 128, "tell %i %s", clientNum, message );
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $228
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 132
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 300
;300:	trap_SendClientCommand( command );
ADDRLP4 4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 301
;301:}
LABELV $229
endproc CG_TellAttacker_f 264 20
proc CG_VoiceTellTarget_f 264 20
line 303
;302:
;303:static void CG_VoiceTellTarget_f( void ) {
line 308
;304:	int		clientNum;
;305:	char	command[128];
;306:	char	message[128];
;307:
;308:	clientNum = CG_CrosshairPlayer();
ADDRLP4 260
ADDRGP4 CG_CrosshairPlayer
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 260
INDIRI4
ASGNI4
line 309
;309:	if ( clientNum == -1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $233
line 310
;310:		return;
ADDRGP4 $232
JUMPV
LABELV $233
line 313
;311:	}
;312:
;313:	trap_Args( message, 128 );
ADDRLP4 132
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Args
CALLV
pop
line 314
;314:	Com_sprintf( command, 128, "vtell %i %s", clientNum, message );
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $235
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 132
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 315
;315:	trap_SendClientCommand( command );
ADDRLP4 4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 316
;316:}
LABELV $232
endproc CG_VoiceTellTarget_f 264 20
proc CG_VoiceTellAttacker_f 264 20
line 318
;317:
;318:static void CG_VoiceTellAttacker_f( void ) {
line 323
;319:	int		clientNum;
;320:	char	command[128];
;321:	char	message[128];
;322:
;323:	clientNum = CG_LastAttacker();
ADDRLP4 260
ADDRGP4 CG_LastAttacker
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 260
INDIRI4
ASGNI4
line 324
;324:	if ( clientNum == -1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $237
line 325
;325:		return;
ADDRGP4 $236
JUMPV
LABELV $237
line 328
;326:	}
;327:
;328:	trap_Args( message, 128 );
ADDRLP4 132
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Args
CALLV
pop
line 329
;329:	Com_sprintf( command, 128, "vtell %i %s", clientNum, message );
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $235
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 132
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 330
;330:	trap_SendClientCommand( command );
ADDRLP4 4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 331
;331:}
LABELV $236
endproc CG_VoiceTellAttacker_f 264 20
proc CG_TSSInterface_f 0 0
line 334
;332:
;333:// JUHOX: CG_TSSInterface_f()
;334:static void CG_TSSInterface_f(void) {
line 335
;335:	CG_TSS_OpenInterface();
ADDRGP4 CG_TSS_OpenInterface
CALLV
pop
line 336
;336:}
LABELV $239
endproc CG_TSSInterface_f 0 0
proc CG_Hook_Plus_f 0 4
line 339
;337:
;338:// JUHOX: CG_Hook_Plus_f()
;339:static void CG_Hook_Plus_f(void) {
line 340
;340:	trap_SendClientCommand("throwhook +");
ADDRGP4 $241
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 341
;341:}
LABELV $240
endproc CG_Hook_Plus_f 0 4
proc CG_Hook_Minus_f 0 4
line 344
;342:
;343:// JUHOX: CG_Hook_Minus_f()
;344:static void CG_Hook_Minus_f(void) {
line 345
;345:	trap_SendClientCommand("throwhook -");
ADDRGP4 $243
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 346
;346:}
LABELV $242
endproc CG_Hook_Minus_f 0 4
proc CG_StartOrbit_f 1028 12
line 521
;347:
;348:#ifdef MISSIONPACK
;349:static void CG_NextTeamMember_f( void ) {
;350:  CG_SelectNextPlayer();
;351:}
;352:
;353:static void CG_PrevTeamMember_f( void ) {
;354:  CG_SelectPrevPlayer();
;355:}
;356:
;357:// ASS U ME's enumeration order as far as task specific orders, OFFENSE is zero, CAMP is last
;358://
;359:static void CG_NextOrder_f( void ) {
;360:	clientInfo_t *ci = cgs.clientinfo + cg.snap->ps.clientNum;
;361:	if (ci) {
;362:		if (!ci->teamLeader && sortedTeamPlayers[cg_currentSelectedPlayer.integer] != cg.snap->ps.clientNum) {
;363:			return;
;364:		}
;365:	}
;366:	if (cgs.currentOrder < TEAMTASK_CAMP) {
;367:		cgs.currentOrder++;
;368:
;369:		if (cgs.currentOrder == TEAMTASK_RETRIEVE) {
;370:			if (!CG_OtherTeamHasFlag()) {
;371:				cgs.currentOrder++;
;372:			}
;373:		}
;374:
;375:		if (cgs.currentOrder == TEAMTASK_ESCORT) {
;376:			if (!CG_YourTeamHasFlag()) {
;377:				cgs.currentOrder++;
;378:			}
;379:		}
;380:
;381:	} else {
;382:		cgs.currentOrder = TEAMTASK_OFFENSE;
;383:	}
;384:	cgs.orderPending = qtrue;
;385:	cgs.orderTime = cg.time + 3000;
;386:}
;387:
;388:
;389:static void CG_ConfirmOrder_f (void ) {
;390:	trap_SendConsoleCommand(va("cmd vtell %d %s\n", cgs.acceptLeader, VOICECHAT_YES));
;391:	trap_SendConsoleCommand("+button5; wait; -button5");
;392:	if (cg.time < cgs.acceptOrderTime) {
;393:		trap_SendClientCommand(va("teamtask %d\n", cgs.acceptTask));
;394:		cgs.acceptOrderTime = 0;
;395:	}
;396:}
;397:
;398:static void CG_DenyOrder_f (void ) {
;399:	trap_SendConsoleCommand(va("cmd vtell %d %s\n", cgs.acceptLeader, VOICECHAT_NO));
;400:	trap_SendConsoleCommand("+button6; wait; -button6");
;401:	if (cg.time < cgs.acceptOrderTime) {
;402:		cgs.acceptOrderTime = 0;
;403:	}
;404:}
;405:
;406:static void CG_TaskOffense_f (void ) {
;407:	if (cgs.gametype == GT_CTF || cgs.gametype == GT_1FCTF) {
;408:		trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONGETFLAG));
;409:	} else {
;410:		trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONOFFENSE));
;411:	}
;412:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_OFFENSE));
;413:}
;414:
;415:static void CG_TaskDefense_f (void ) {
;416:	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONDEFENSE));
;417:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_DEFENSE));
;418:}
;419:
;420:static void CG_TaskPatrol_f (void ) {
;421:	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONPATROL));
;422:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_PATROL));
;423:}
;424:
;425:static void CG_TaskCamp_f (void ) {
;426:	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONCAMPING));
;427:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_CAMP));
;428:}
;429:
;430:static void CG_TaskFollow_f (void ) {
;431:	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONFOLLOW));
;432:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_FOLLOW));
;433:}
;434:
;435:static void CG_TaskRetrieve_f (void ) {
;436:	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONRETURNFLAG));
;437:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_RETRIEVE));
;438:}
;439:
;440:static void CG_TaskEscort_f (void ) {
;441:	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONFOLLOWCARRIER));
;442:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_ESCORT));
;443:}
;444:
;445:static void CG_TaskOwnFlag_f (void ) {
;446:	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_IHAVEFLAG));
;447:}
;448:
;449:static void CG_TauntKillInsult_f (void ) {
;450:	trap_SendConsoleCommand("cmd vsay kill_insult\n");
;451:}
;452:
;453:static void CG_TauntPraise_f (void ) {
;454:	trap_SendConsoleCommand("cmd vsay praise\n");
;455:}
;456:
;457:static void CG_TauntTaunt_f (void ) {
;458:	trap_SendConsoleCommand("cmd vtaunt\n");
;459:}
;460:
;461:static void CG_TauntDeathInsult_f (void ) {
;462:	trap_SendConsoleCommand("cmd vsay death_insult\n");
;463:}
;464:
;465:static void CG_TauntGauntlet_f (void ) {
;466:	trap_SendConsoleCommand("cmd vsay kill_guantlet\n");
;467:}
;468:
;469:static void CG_TaskSuicide_f (void ) {
;470:	int		clientNum;
;471:	char	command[128];
;472:
;473:	clientNum = CG_CrosshairPlayer();
;474:	if ( clientNum == -1 ) {
;475:		return;
;476:	}
;477:
;478:	Com_sprintf( command, 128, "tell %i suicide", clientNum );
;479:	trap_SendClientCommand( command );
;480:}
;481:
;482:
;483:
;484:/*
;485:==================
;486:CG_TeamMenu_f
;487:==================
;488:*/
;489:/*
;490:static void CG_TeamMenu_f( void ) {
;491:  if (trap_Key_GetCatcher() & KEYCATCH_CGAME) {
;492:    CG_EventHandling(CGAME_EVENT_NONE);
;493:    trap_Key_SetCatcher(0);
;494:  } else {
;495:    CG_EventHandling(CGAME_EVENT_TEAMMENU);
;496:    //trap_Key_SetCatcher(KEYCATCH_CGAME);
;497:  }
;498:}
;499:*/
;500:
;501:/*
;502:==================
;503:CG_EditHud_f
;504:==================
;505:*/
;506:/*
;507:static void CG_EditHud_f( void ) {
;508:  //cls.keyCatchers ^= KEYCATCH_CGAME;
;509:  //VM_Call (cgvm, CG_EVENT_HANDLING, (cls.keyCatchers & KEYCATCH_CGAME) ? CGAME_EVENT_EDITHUD : CGAME_EVENT_NONE);
;510:}
;511:*/
;512:
;513:#endif
;514:
;515:/*
;516:==================
;517:CG_StartOrbit_f
;518:==================
;519:*/
;520:
;521:static void CG_StartOrbit_f( void ) {
line 524
;522:	char var[MAX_TOKEN_CHARS];
;523:
;524:	trap_Cvar_VariableStringBuffer( "developer", var, sizeof( var ) );
ADDRGP4 $245
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 525
;525:	if ( !atoi(var) ) {
ADDRLP4 0
ARGP4
ADDRLP4 1024
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1024
INDIRI4
CNSTI4 0
NEI4 $246
line 526
;526:		return;
ADDRGP4 $244
JUMPV
LABELV $246
line 528
;527:	}
;528:	if (cg_cameraOrbit.value != 0) {
ADDRGP4 cg_cameraOrbit+8
INDIRF4
CNSTF4 0
EQF4 $248
line 529
;529:		trap_Cvar_Set ("cg_cameraOrbit", "0");
ADDRGP4 $251
ARGP4
ADDRGP4 $252
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 530
;530:		trap_Cvar_Set("cg_thirdPerson", "0");
ADDRGP4 $253
ARGP4
ADDRGP4 $252
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 531
;531:	} else {
ADDRGP4 $249
JUMPV
LABELV $248
line 532
;532:		trap_Cvar_Set("cg_cameraOrbit", "5");
ADDRGP4 $251
ARGP4
ADDRGP4 $254
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 533
;533:		trap_Cvar_Set("cg_thirdPerson", "1");
ADDRGP4 $253
ARGP4
ADDRGP4 $255
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 534
;534:		trap_Cvar_Set("cg_thirdPersonAngle", "0");
ADDRGP4 $256
ARGP4
ADDRGP4 $252
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 535
;535:		trap_Cvar_Set("cg_thirdPersonRange", "100");
ADDRGP4 $257
ARGP4
ADDRGP4 $258
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 536
;536:	}
LABELV $249
line 537
;537:}
LABELV $244
endproc CG_StartOrbit_f 1028 12
data
align 4
LABELV commands
address $260
address CG_TestGun_f
address $261
address CG_TestModel_f
address $262
address CG_TestModelNextFrame_f
address $263
address CG_TestModelPrevFrame_f
address $264
address CG_TestModelNextSkin_f
address $265
address CG_TestModelPrevSkin_f
address $266
address CG_Viewpos_f
address $267
address CG_ScoresDown_f
address $268
address CG_ScoresUp_f
address $269
address CG_ZoomDown_f
address $270
address CG_ZoomUp_f
address $271
address CG_SizeUp_f
address $272
address CG_SizeDown_f
address $273
address CG_NextWeapon_f
address $274
address CG_PrevWeapon_f
address $275
address CG_BestWeapon_f
address $276
address CG_SkipWeapon_f
address $277
address CG_NextWeaponOrder_f
address $278
address CG_PrevWeaponOrder_f
address $279
address CG_Weapon_f
address $280
address CG_TellTarget_f
address $281
address CG_TellAttacker_f
address $282
address CG_VoiceTellTarget_f
address $283
address CG_VoiceTellAttacker_f
address $284
address CG_TargetCommand_f
address $285
address CG_TSSInterface_f
address $286
address CG_Hook_Plus_f
address $287
address CG_Hook_Minus_f
address $288
address CG_SaveLensFlareEntities_f
address $289
address CG_RevertLensFlareEntities_f
address $290
address CG_UpdateLensFlares_f
address $291
address CG_StartOrbit_f
address $292
address CG_LoadDeferredPlayers
export CG_ConsoleCommand
code
proc CG_ConsoleCommand 16 8
line 635
;538:
;539:/*
;540:static void CG_Camera_f( void ) {
;541:	char name[1024];
;542:	trap_Argv( 1, name, sizeof(name));
;543:	if (trap_loadCamera(name)) {
;544:		cg.cameraMode = qtrue;
;545:		trap_startCamera(cg.time);
;546:	} else {
;547:		CG_Printf ("Unable to load camera %s\n",name);
;548:	}
;549:}
;550:*/
;551:
;552:
;553:
;554:
;555:typedef struct {
;556:	char	*cmd;
;557:	void	(*function)(void);
;558:} consoleCommand_t;
;559:
;560:static consoleCommand_t	commands[] = {
;561:	{ "testgun", CG_TestGun_f },
;562:	{ "testmodel", CG_TestModel_f },
;563:	{ "nextframe", CG_TestModelNextFrame_f },
;564:	{ "prevframe", CG_TestModelPrevFrame_f },
;565:	{ "nextskin", CG_TestModelNextSkin_f },
;566:	{ "prevskin", CG_TestModelPrevSkin_f },
;567:	{ "viewpos", CG_Viewpos_f },
;568:	{ "+scores", CG_ScoresDown_f },
;569:	{ "-scores", CG_ScoresUp_f },
;570:	{ "+zoom", CG_ZoomDown_f },
;571:	{ "-zoom", CG_ZoomUp_f },
;572:	{ "sizeup", CG_SizeUp_f },
;573:	{ "sizedown", CG_SizeDown_f },
;574:	{ "weapnext", CG_NextWeapon_f },
;575:	{ "weapprev", CG_PrevWeapon_f },
;576:	{ "weapbest", CG_BestWeapon_f },			// JUHOX
;577:	{ "weapskip", CG_SkipWeapon_f },			// JUHOX
;578:	{ "nextweaporder", CG_NextWeaponOrder_f },	// JUHOX
;579:	{ "prevweaporder", CG_PrevWeaponOrder_f },	// JUHOX
;580:	{ "weapon", CG_Weapon_f },
;581:	{ "tell_target", CG_TellTarget_f },
;582:	{ "tell_attacker", CG_TellAttacker_f },
;583:	{ "vtell_target", CG_VoiceTellTarget_f },
;584:	{ "vtell_attacker", CG_VoiceTellAttacker_f },
;585:	{ "tcmd", CG_TargetCommand_f },
;586:	{ "tssinterface", CG_TSSInterface_f },	// JUHOX
;587:	{ "+throwhook", CG_Hook_Plus_f },	// JUHOX
;588:	{ "-throwhook", CG_Hook_Minus_f },	// JUHOX
;589:	// JUHOX: add lens flare editor commands
;590:#if MAPLENSFLARES
;591:	{ "lfsave", CG_SaveLensFlareEntities_f },
;592:	{ "lfrevert", CG_RevertLensFlareEntities_f },
;593:	{ "lfupdate", CG_UpdateLensFlares_f },
;594:#endif
;595:#ifdef MISSIONPACK
;596:	{ "loadhud", CG_LoadHud_f },
;597:	{ "nextTeamMember", CG_NextTeamMember_f },
;598:	{ "prevTeamMember", CG_PrevTeamMember_f },
;599:	{ "nextOrder", CG_NextOrder_f },
;600:	{ "confirmOrder", CG_ConfirmOrder_f },
;601:	{ "denyOrder", CG_DenyOrder_f },
;602:	{ "taskOffense", CG_TaskOffense_f },
;603:	{ "taskDefense", CG_TaskDefense_f },
;604:	{ "taskPatrol", CG_TaskPatrol_f },
;605:	{ "taskCamp", CG_TaskCamp_f },
;606:	{ "taskFollow", CG_TaskFollow_f },
;607:	{ "taskRetrieve", CG_TaskRetrieve_f },
;608:	{ "taskEscort", CG_TaskEscort_f },
;609:	{ "taskSuicide", CG_TaskSuicide_f },
;610:	{ "taskOwnFlag", CG_TaskOwnFlag_f },
;611:	{ "tauntKillInsult", CG_TauntKillInsult_f },
;612:	{ "tauntPraise", CG_TauntPraise_f },
;613:	{ "tauntTaunt", CG_TauntTaunt_f },
;614:	{ "tauntDeathInsult", CG_TauntDeathInsult_f },
;615:	{ "tauntGauntlet", CG_TauntGauntlet_f },
;616:	{ "spWin", CG_spWin_f },
;617:	{ "spLose", CG_spLose_f },
;618:	{ "scoresDown", CG_scrollScoresDown_f },
;619:	{ "scoresUp", CG_scrollScoresUp_f },
;620:#endif
;621:	{ "startOrbit", CG_StartOrbit_f },
;622:	//{ "camera", CG_Camera_f },
;623:	{ "loaddeferred", CG_LoadDeferredPlayers }	
;624:};
;625:
;626:
;627:/*
;628:=================
;629:CG_ConsoleCommand
;630:
;631:The string has been tokenized and can be retrieved with
;632:Cmd_Argc() / Cmd_Argv()
;633:=================
;634:*/
;635:qboolean CG_ConsoleCommand( void ) {
line 639
;636:	const char	*cmd;
;637:	int		i;
;638:
;639:	cmd = CG_Argv(0);
CNSTI4 0
ARGI4
ADDRLP4 8
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 641
;640:
;641:	for ( i = 0 ; i < sizeof( commands ) / sizeof( commands[0] ) ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $297
JUMPV
LABELV $294
line 642
;642:		if ( !Q_stricmp( cmd, commands[i].cmd ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 commands
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $298
line 643
;643:			commands[i].function();
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 commands+4
ADDP4
INDIRP4
CALLV
pop
line 644
;644:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $293
JUMPV
LABELV $298
line 646
;645:		}
;646:	}
LABELV $295
line 641
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $297
ADDRLP4 0
INDIRI4
CVIU4 4
CNSTU4 33
LTU4 $294
line 648
;647:
;648:	return qfalse;
CNSTI4 0
RETI4
LABELV $293
endproc CG_ConsoleCommand 16 8
export CG_InitConsoleCommands
proc CG_InitConsoleCommands 4 4
line 660
;649:}
;650:
;651:
;652:/*
;653:=================
;654:CG_InitConsoleCommands
;655:
;656:Let the client system know about all of our commands
;657:so it can perform tab completion
;658:=================
;659:*/
;660:void CG_InitConsoleCommands( void ) {
line 663
;661:	int		i;
;662:
;663:	for ( i = 0 ; i < sizeof( commands ) / sizeof( commands[0] ) ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $305
JUMPV
LABELV $302
line 664
;664:		trap_AddCommand( commands[i].cmd );
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 commands
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 665
;665:	}
LABELV $303
line 663
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $305
ADDRLP4 0
INDIRI4
CVIU4 4
CNSTU4 33
LTU4 $302
line 671
;666:
;667:	//
;668:	// the game server will interpret these commands, which will be automatically
;669:	// forwarded to the server after they are not recognized locally
;670:	//
;671:	trap_AddCommand ("kill");
ADDRGP4 $306
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 672
;672:	trap_AddCommand ("say");
ADDRGP4 $307
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 673
;673:	trap_AddCommand ("say_team");
ADDRGP4 $308
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 674
;674:	trap_AddCommand ("tell");
ADDRGP4 $309
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 685
;675:	// JUHOX: no voice chat commands accepted
;676:#if 0
;677:	trap_AddCommand ("vsay");
;678:	trap_AddCommand ("vsay_team");
;679:	trap_AddCommand ("vtell");
;680:	trap_AddCommand ("vtaunt");
;681:	trap_AddCommand ("vosay");
;682:	trap_AddCommand ("vosay_team");
;683:	trap_AddCommand ("votell");
;684:#endif
;685:	trap_AddCommand ("give");
ADDRGP4 $310
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 686
;686:	trap_AddCommand ("god");
ADDRGP4 $311
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 687
;687:	trap_AddCommand ("notarget");
ADDRGP4 $312
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 688
;688:	trap_AddCommand ("noclip");
ADDRGP4 $313
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 689
;689:	trap_AddCommand ("team");
ADDRGP4 $314
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 690
;690:	trap_AddCommand ("follow");
ADDRGP4 $315
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 691
;691:	trap_AddCommand ("levelshot");
ADDRGP4 $316
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 692
;692:	trap_AddCommand ("addbot");
ADDRGP4 $317
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 693
;693:	trap_AddCommand ("setviewpos");
ADDRGP4 $318
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 694
;694:	trap_AddCommand ("callvote");
ADDRGP4 $319
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 695
;695:	trap_AddCommand ("vote");
ADDRGP4 $320
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 696
;696:	trap_AddCommand ("callteamvote");
ADDRGP4 $321
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 697
;697:	trap_AddCommand ("teamvote");
ADDRGP4 $322
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 698
;698:	trap_AddCommand ("stats");
ADDRGP4 $323
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 699
;699:	trap_AddCommand ("teamtask");
ADDRGP4 $324
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 700
;700:	trap_AddCommand ("loaddefered");	// spelled wrong, but not changing for demo
ADDRGP4 $325
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 701
;701:	trap_AddCommand ("drophealth");	// JUHOX
ADDRGP4 $326
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 702
;702:	trap_AddCommand ("droparmor");	// JUHOX
ADDRGP4 $327
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 703
;703:	trap_AddCommand ("navaid");	// JUHOX
ADDRGP4 $328
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 704
;704:}
LABELV $301
endproc CG_InitConsoleCommands 4 4
import trap_PC_SourceFileAndLine
import trap_PC_ReadToken
import trap_PC_FreeSource
import trap_PC_LoadSource
import trap_PC_AddGlobalDefine
import Controls_SetDefaults
import Controls_SetConfig
import Controls_GetConfig
import UI_OutOfMemory
import UI_InitMemory
import UI_Alloc
import Display_CacheAll
import Menu_SetFeederSelection
import Menu_Paint
import Menus_CloseAll
import LerpColor
import Display_HandleKey
import Menus_CloseByName
import Menus_ShowByName
import Menus_FindByName
import Menus_OpenByName
import Display_KeyBindPending
import Display_CursorType
import Display_MouseMove
import Display_CaptureItem
import Display_GetContext
import Menus_Activate
import Menus_AnyFullScreenVisible
import Menu_Reset
import Menus_ActivateByName
import Menu_PaintAll
import Menu_New
import Menu_Count
import PC_Script_Parse
import PC_String_Parse
import PC_Rect_Parse
import PC_Int_Parse
import PC_Color_Parse
import PC_Float_Parse
import Script_Parse
import String_Parse
import Rect_Parse
import Int_Parse
import Color_Parse
import Float_Parse
import Menu_ScrollFeeder
import Menu_HandleMouseMove
import Menu_HandleKey
import Menu_GetFocused
import Menu_PostParse
import Item_Init
import Menu_Init
import Display_ExpandMacros
import Init_Display
import String_Report
import String_Init
import String_Alloc
import CG_AdjustParticles
import CG_NewParticleArea
import initparticles
import CG_ParticleExplosion
import CG_ParticleMisc
import CG_ParticleDust
import CG_ParticleSparks
import CG_ParticleBulletDebris
import CG_ParticleSnowFlurry
import CG_AddParticleShrapnel
import CG_ParticleSmoke
import CG_ParticleSnow
import CG_AddParticles
import CG_ClearParticles
import trap_GetEntityToken
import trap_getCameraInfo
import trap_startCamera
import trap_loadCamera
import trap_SnapVector
import trap_CIN_SetExtents
import trap_CIN_DrawCinematic
import trap_CIN_RunCinematic
import trap_CIN_StopCinematic
import trap_CIN_PlayCinematic
import trap_Key_GetKey
import trap_Key_SetCatcher
import trap_Key_GetCatcher
import trap_Key_IsDown
import trap_R_RegisterFont
import trap_MemoryRemaining
import testPrintFloat
import testPrintInt
import trap_SetUserCmdValue
import trap_GetUserCmd
import trap_GetCurrentCmdNumber
import trap_GetServerCommand
import trap_GetSnapshot
import trap_GetCurrentSnapshotNumber
import trap_GetGameState
import trap_GetGlconfig
import trap_R_RemapShader
import trap_R_LerpTag
import trap_R_ModelBounds
import trap_R_DrawStretchPic
import trap_R_SetColor
import trap_R_RenderScene
import trap_R_LightForPoint
import trap_R_AddLightToScene
import trap_R_AddPolysToScene
import trap_R_AddPolyToScene
import trap_R_AddRefEntityToScene
import trap_R_ClearScene
import trap_R_RegisterShaderNoMip
import trap_R_RegisterShader
import trap_R_RegisterSkin
import trap_R_RegisterModel
import trap_R_LoadWorldMap
import trap_S_AddRealLoopingSound_fixed
import trap_S_AddLoopingSound_fixed
import trap_S_StartSound_fixed
import currentReference
import trap_S_StopBackgroundTrack
import trap_S_StartBackgroundTrack
import trap_S_RegisterSound
import trap_S_Respatialize
import trap_S_UpdateEntityPosition
import trap_S_AddRealLoopingSound
import trap_S_AddLoopingSound
import trap_S_ClearLoopingSounds
import trap_S_StartLocalSound
import trap_S_StopLoopingSound
import trap_S_StartSound
import trap_CM_MarkFragments
import trap_CM_TransformedBoxTrace
import trap_CM_BoxTrace
import trap_CM_TransformedPointContents
import trap_CM_PointContents
import trap_CM_TempBoxModel
import trap_CM_InlineModel
import trap_CM_NumInlineModels
import trap_CM_LoadMap
import trap_UpdateScreen
import trap_SendClientCommand
import trap_AddCommand
import trap_SendConsoleCommand
import trap_FS_Seek
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_FS_FOpenFile
import trap_Args
import trap_Argv
import trap_Argc
import trap_Cvar_VariableStringBuffer
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_Milliseconds
import trap_Error
import trap_Print
import CG_RunPlayListFrame
import CG_ResetPlayList
import CG_ContinuePlayList
import CG_StopPlayList
import CG_ParsePlayList
import CG_InitPlayList
import CG_TSS_CheckMouseEvents
import CG_TSS_CheckKeyEvents
import CG_TSS_MouseEvent
import CG_TSS_KeyEvent
import CG_TSS_CloseInterface
import CG_TSS_OpenInterface
import CG_TSS_DrawInterface
import CG_TSS_SPrintTacticalMeasure
import CG_TSS_Update
import CG_TSS_SaveInterface
import CG_TSS_LoadInterface
import CG_TSS_InitInterface
import TSS_SetPalette
import TSS_GetPalette
import CG_TSS_StrategyNameChanged
import CG_TSS_SetSearchPattern
import CG_TSS_CreateNewStrategy
import CG_TSS_FreePaletteSlot
import CG_TSS_SavePaletteSlotIfNeeded
import CG_TSS_LoadPaletteSlot
import CG_TSS_GetSortIndexByID
import CG_TSS_GetSortedSlot
import CG_TSS_GetSlotByName
import CG_TSS_GetSlotByID
import CG_TSS_NumStrategiesInStock
import TSSFS_SaveStrategyStock
import TSSFS_LoadStrategyStock
import TSSFS_LoadStrategy
import TSSFS_SaveStrategy
import CG_CheckChangedPredictableEvents
import CG_TransitionPlayerState
import CG_Respawn
import CG_PlayBufferedVoiceChats
import CG_VoiceChatLocal
import CG_ShaderStateChanged
import CG_LoadVoiceChats
import CG_SetConfigValues
import CG_ParseServerinfo
import CG_ExecuteNewServerCommands
import CG_DrawOldTourneyScoreboard
import CG_DrawOldScoreboard
import CG_DrawInformation
import CG_LoadingClient
import CG_LoadingItem
import CG_LoadingString
import CG_ProcessSnapshots
import CG_MakeExplosion
import CG_Bleed
import CG_BigExplode
import CG_BFGsuperExpl
import CG_GibPlayer
import CG_ScorePlum
import CG_SpawnEffect
import CG_BubbleTrail
import CG_SmokePuff
import CG_AdjustLocalEntities
import CG_AddLocalEntities
import CG_AllocLocalEntity
import CG_InitLocalEntities
import CG_DrawLightBlobs
import CG_CheckStrongLight
import CG_AddLightningMarks
import CG_AddNearbox
import CG_ImpactMark
import CG_AddMarks
import CG_InitMarkPolys
import CG_OutOfAmmoChange
import CG_DrawWeaponSelect
import CG_AddPlayerWeapon
import CG_AddViewWeapon
import CG_GrappleTrail
import CG_RailTrail
import CG_Draw3DLine
import CG_Bullet
import CG_ShotgunFire
import CG_MissileHitPlayer
import CG_MissileHitWall
import CG_FireWeapon
import CG_RegisterItemVisuals
import CG_RegisterWeapon
import CG_Weapon_f
import CG_PrevWeapon_f
import CG_NextWeapon_f
import CG_PrevWeaponOrder_f
import CG_NextWeaponOrder_f
import CG_SkipWeapon_f
import CG_BestWeapon_f
import CG_AutoSwitchToBestWeapon
import CG_CalcEntityLerpPositions
import CG_Mover
import CG_AddPacketEntitiesForGlassLook
import CG_PositionRotatedEntityOnTag
import CG_PositionEntityOnTag
import CG_AdjustPositionForMover
import CG_DrawLineSegment
import CG_Beam
import CG_AddPacketEntities
import CG_SetEntitySoundPosition
import CG_PainEvent
import CG_EntityEvent
import CG_PlaceString
import CG_CheckEvents
import CG_LoadDeferredPlayers
import CG_PredictPlayerState
import CG_SmoothTrace
import CG_Trace
import CG_PointContents
import CG_BuildSolidList
import CG_GetSpawnEffectParameters
import CG_InitMonsterClientInfo
import CG_CustomSound
import CG_NewClientInfo
import CG_AddRefEntityWithPowerups
import CG_ResetPlayerEntity
import CG_Player
import AddDischargeFlash
import CG_DrawTeamVote
import CG_DrawVote
import CG_StatusHandle
import CG_OtherTeamHasFlag
import CG_YourTeamHasFlag
import CG_GameTypeString
import CG_CheckOrderPending
import CG_Text_PaintChar
import CG_Draw3DModel
import CG_GetKillerText
import CG_GetGameStatusText
import CG_GetTeamColor
import CG_InitTeamChat
import CG_SetPrintString
import CG_ShowResponseHead
import CG_RunMenuScript
import CG_OwnerDrawVisible
import CG_GetValue
import CG_SelectNextPlayer
import CG_SelectPrevPlayer
import CG_Text_Height
import CG_Text_Width
import CG_Text_Paint
import CG_OwnerDraw
import CG_DrawTeamBackground
import CG_DrawFlagModel
import CG_DrawActive
import CG_DrawHead
import CG_CenterPrint
import CG_AddLagometerSnapshotInfo
import CG_AddLagometerFrameInfo
import teamChat2
import teamChat1
import systemChat
import drawTeamOverlayModificationCount
import numSortedTeamPlayers
import sortedTeamPlayers
import CG_DrawTopBottom
import CG_DrawSides
import CG_DrawRect
import UI_DrawProportionalString
import CG_GetColorForHealth
import CG_ColorForHealth
import CG_TileClear
import CG_TeamColor
import CG_FadeColor
import CG_DrawStrlen
import CG_DrawSmallStringColor
import CG_DrawSmallString
import CG_DrawBigStringColor
import CG_DrawBigString
import CG_DrawStringExt
import CG_DrawString
import CG_DrawPic
import CG_FillRect
import CG_AdjustFrom640
import CG_GetScreenCoordinates
import CG_AddLFEditorCursor
import CG_AdjustEarthquakes
import CG_AddEarthquake
import CG_DrawActiveFrame
import CG_AddBufferedSound
import CG_ZoomUp_f
import CG_ZoomDown_f
import CG_TestModelPrevSkin_f
import CG_TestModelNextSkin_f
import CG_TestModelPrevFrame_f
import CG_TestModelNextFrame_f
import CG_TestGun_f
import CG_TestModel_f
import CG_LoadLensFlareEntities
import CG_ComputeMaxVisAngle
import CG_LoadLensFlares
import CG_SelectLFEnt
import CG_SetLFEdMoveMode
import CG_SetLFEntOrigin
import CG_LFEntOrigin
import CG_BuildSpectatorString
import CG_GetSelectedScore
import CG_SetScoreSelection
import CG_RankRunFrame
import CG_EventHandling
import CG_MouseEvent
import CG_KeyEvent
import CG_LoadMenus
import CG_LastAttacker
import CG_CrosshairPlayer
import CG_UpdateCvars
import CG_StartMusic
import CG_Error
import CG_Printf
import CG_Argv
import CG_ConfigString
import cg_music
import cg_autoGLC
import cg_nearbox
import cg_BFGsuperExpl
import cg_missileFlare
import cg_sunFlare
import cg_mapFlare
import cg_lensFlare
import cg_glassCloaking
import cg_trueLightning
import cg_oldPlasma
import cg_oldRocket
import cg_oldRail
import cg_noProjectileTrail
import cg_noTaunt
import cg_bigFont
import cg_smallFont
import cg_cameraMode
import cg_timescale
import cg_timescaleFadeSpeed
import cg_timescaleFadeEnd
import cg_cameraOrbitDelay
import cg_cameraOrbit
import pmove_msec
import pmove_fixed
import cg_smoothClients
import cg_scorePlum
import cg_noVoiceText
import cg_noVoiceChats
import cg_teamChatsOnly
import cg_drawFriend
import cg_deferPlayers
import cg_predictItems
import cg_blood
import cg_paused
import cg_buildScript
import cg_forceModel
import cg_stats
import cg_teamChatHeight
import cg_teamChatTime
import cg_synchronousClients
import cg_drawAttacker
import cg_lagometer
import cg_stereoSeparation
import cg_thirdPerson
import cg_thirdPersonAngle
import cg_thirdPersonRange
import cg_zoomFov
import cg_fov
import cg_simpleItems
import cg_noTrace
import cg_tssiKey
import cg_tssiMouse
import cg_drawSegment
import cg_fireballTrail
import cg_drawNumMonsters
import cg_ignore
import cg_weaponOrderName
import cg_weaponOrder
import cg_autoswitchAmmoLimit
import cg_autoswitch
import cg_tracerLength
import cg_tracerWidth
import cg_tracerChance
import cg_viewsize
import cg_drawGun
import cg_gun_z
import cg_gun_y
import cg_gun_x
import cg_gun_frame
import cg_brassTime
import cg_addMarks
import cg_footsteps
import cg_showmiss
import cg_noPlayerAnims
import cg_nopredict
import cg_errorDecay
import cg_railTrailTime
import cg_debugEvents
import cg_debugPosition
import cg_debugAnim
import cg_animSpeed
import cg_draw2D
import cg_drawStatus
import cg_crosshairHealth
import cg_crosshairSize
import cg_crosshairY
import cg_crosshairX
import cg_teamOverlayUserinfo
import cg_drawTeamOverlay
import cg_drawRewards
import cg_drawCrosshairNames
import cg_drawCrosshair
import cg_drawAmmoWarning
import cg_drawIcons
import cg_draw3dIcons
import cg_drawSnapshot
import cg_drawFPS
import cg_drawTimer
import cg_gibs
import cg_shadows
import cg_swingSpeed
import cg_bobroll
import cg_bobpitch
import cg_bobup
import cg_runroll
import cg_runpitch
import cg_centertime
import cg_markPolys
import cg_items
import cg_weapons
import cg_entities
import cg
import cgs
import BG_PlayerTargetOffset
import BG_PlayerTouchesItem
import BG_PlayerStateToEntityStateExtraPolate
import BG_PlayerStateToEntityState
import BG_TouchJumpPad
import BG_AddPredictableEventToPlayerstate
import BG_EvaluateTrajectoryDelta
import BG_EvaluateTrajectory
import BG_CanItemBeGrabbed
import BG_FindItemForHoldable
import BG_FindItemForPowerup
import BG_FindItemForWeapon
import BG_FindItem
import bg_numItems
import bg_itemlist
import weaponAmmoCharacteristics
import Pmove
import PM_UpdateViewAngles
import BG_TSS_GetPlayerEntityInfo
import BG_TSS_GetPlayerInfo
import BG_TSS_SetPlayerInfo
import BG_TSS_DecodeLeadership
import BG_TSS_CodeLeadership
import BG_TSS_DecodeInstructions
import BG_TSS_CodeInstructions
import TSS_DecodeInt
import TSS_CodeInt
import TSS_DecodeNibble
import TSS_CodeNibble
import BG_TSS_AssignPlayers
import BG_TSS_TakeProportionAway
import BG_TSS_Proportion
import BG_VectorChecksum
import BG_ChecksumChar
import BG_TemplateChecksum
import BG_GetGameTemplateList
import BG_ParseGameTemplate
import local_crandom
import local_random
import DeriveLocalSeed
import LocallySeededRandom
import Com_Printf
import Com_Error
import Info_NextPair
import Info_Validate
import Info_SetValueForKey_Big
import Info_SetValueForKey
import Info_RemoveKey_big
import Info_RemoveKey
import Info_ValueForKey
import va
import Q_CleanStr
import Q_PrintStrlen
import Q_strcat
import Q_strncpyz
import Q_strrchr
import Q_strupr
import Q_strlwr
import Q_stricmpn
import Q_strncmp
import Q_stricmp
import Q_isalpha
import Q_isupper
import Q_islower
import Q_isprint
import Com_sprintf
import Parse3DMatrix
import Parse2DMatrix
import Parse1DMatrix
import SkipRestOfLine
import SkipBracedSection
import COM_MatchToken
import COM_ParseWarning
import COM_ParseError
import COM_Compress
import COM_ParseExt
import COM_Parse
import COM_GetCurrentParseLine
import COM_BeginParseSession
import COM_DefaultExtension
import COM_StripExtension
import COM_SkipPath
import Com_Clamp
import PerpendicularVector
import AngleVectors
import MatrixMultiply
import MakeNormalVectors
import RotateAroundDirection
import RotatePointAroundVector
import ProjectPointOnPlane
import PlaneFromPoints
import AngleDelta
import AngleNormalize180
import AngleNormalize360
import AnglesSubtract
import AngleSubtract
import LerpAngle
import AngleMod
import BoxOnPlaneSide
import SetPlaneSignbits
import AxisCopy
import AxisClear
import AnglesToAxis
import vectoangles
import lrand
import Q_crandom
import Q_random
import Q_rand
import Q_acos
import Q_log2
import VectorRotate
import Vector4Scale
import VectorNormalize2
import VectorNormalize
import CrossProduct
import VectorInverse
import VectorNormalizeFast
import DistanceSquared
import Distance
import VectorLengthSquared
import VectorLength
import VectorCompare
import AddPointToBounds
import ClearBounds
import RadiusFromBounds
import NormalizeColor
import ColorBytes4
import ColorBytes3
import _VectorMA
import _VectorScale
import _VectorCopy
import _VectorAdd
import _VectorSubtract
import _DotProduct
import ByteToDir
import DirToByte
import ClampShort
import ClampChar
import Q_rsqrt
import Q_fabs
import axisDefault
import vec3_origin
import g_color_table
import colorDkGrey
import colorMdGrey
import colorLtGrey
import colorWhite
import colorCyan
import colorMagenta
import colorYellow
import colorBlue
import colorGreen
import colorRed
import colorBlack
import bytedirs
import Com_Memcpy
import Com_Memset
import Hunk_Alloc
import FloatSwap
import LongSwap
import ShortSwap
import acos
import fabs
import abs
import tan
import atan2
import cos
import sin
import sqrt
import floor
import ceil
import memcpy
import memset
import memmove
import sscanf
import vsprintf
import _atoi
import atoi
import _atof
import atof
import toupper
import tolower
import strncpy
import strstr
import strchr
import strcmp
import strcpy
import strcat
import strlen
import rand
import srand
import qsort
lit
align 1
LABELV $328
byte 1 110
byte 1 97
byte 1 118
byte 1 97
byte 1 105
byte 1 100
byte 1 0
align 1
LABELV $327
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $326
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $325
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $324
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $323
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $322
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $321
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $320
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $319
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $318
byte 1 115
byte 1 101
byte 1 116
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 112
byte 1 111
byte 1 115
byte 1 0
align 1
LABELV $317
byte 1 97
byte 1 100
byte 1 100
byte 1 98
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $316
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $315
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $314
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $313
byte 1 110
byte 1 111
byte 1 99
byte 1 108
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $312
byte 1 110
byte 1 111
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $311
byte 1 103
byte 1 111
byte 1 100
byte 1 0
align 1
LABELV $310
byte 1 103
byte 1 105
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $309
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $308
byte 1 115
byte 1 97
byte 1 121
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $307
byte 1 115
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $306
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $292
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 114
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $291
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 79
byte 1 114
byte 1 98
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $290
byte 1 108
byte 1 102
byte 1 117
byte 1 112
byte 1 100
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $289
byte 1 108
byte 1 102
byte 1 114
byte 1 101
byte 1 118
byte 1 101
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $288
byte 1 108
byte 1 102
byte 1 115
byte 1 97
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $287
byte 1 45
byte 1 116
byte 1 104
byte 1 114
byte 1 111
byte 1 119
byte 1 104
byte 1 111
byte 1 111
byte 1 107
byte 1 0
align 1
LABELV $286
byte 1 43
byte 1 116
byte 1 104
byte 1 114
byte 1 111
byte 1 119
byte 1 104
byte 1 111
byte 1 111
byte 1 107
byte 1 0
align 1
LABELV $285
byte 1 116
byte 1 115
byte 1 115
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 102
byte 1 97
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $284
byte 1 116
byte 1 99
byte 1 109
byte 1 100
byte 1 0
align 1
LABELV $283
byte 1 118
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 95
byte 1 97
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $282
byte 1 118
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 95
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $281
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 95
byte 1 97
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $280
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 95
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $279
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $278
byte 1 112
byte 1 114
byte 1 101
byte 1 118
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $277
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $276
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 115
byte 1 107
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $275
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 98
byte 1 101
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $274
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 112
byte 1 114
byte 1 101
byte 1 118
byte 1 0
align 1
LABELV $273
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $272
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $271
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $270
byte 1 45
byte 1 122
byte 1 111
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $269
byte 1 43
byte 1 122
byte 1 111
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $268
byte 1 45
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $267
byte 1 43
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $266
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 112
byte 1 111
byte 1 115
byte 1 0
align 1
LABELV $265
byte 1 112
byte 1 114
byte 1 101
byte 1 118
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $264
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $263
byte 1 112
byte 1 114
byte 1 101
byte 1 118
byte 1 102
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $262
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 102
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $261
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $260
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $258
byte 1 49
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $257
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 104
byte 1 105
byte 1 114
byte 1 100
byte 1 80
byte 1 101
byte 1 114
byte 1 115
byte 1 111
byte 1 110
byte 1 82
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $256
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 104
byte 1 105
byte 1 114
byte 1 100
byte 1 80
byte 1 101
byte 1 114
byte 1 115
byte 1 111
byte 1 110
byte 1 65
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $255
byte 1 49
byte 1 0
align 1
LABELV $254
byte 1 53
byte 1 0
align 1
LABELV $253
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 104
byte 1 105
byte 1 114
byte 1 100
byte 1 80
byte 1 101
byte 1 114
byte 1 115
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $252
byte 1 48
byte 1 0
align 1
LABELV $251
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 97
byte 1 109
byte 1 101
byte 1 114
byte 1 97
byte 1 79
byte 1 114
byte 1 98
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $245
byte 1 100
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 111
byte 1 112
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $243
byte 1 116
byte 1 104
byte 1 114
byte 1 111
byte 1 119
byte 1 104
byte 1 111
byte 1 111
byte 1 107
byte 1 32
byte 1 45
byte 1 0
align 1
LABELV $241
byte 1 116
byte 1 104
byte 1 114
byte 1 111
byte 1 119
byte 1 104
byte 1 111
byte 1 111
byte 1 107
byte 1 32
byte 1 43
byte 1 0
align 1
LABELV $235
byte 1 118
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $228
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $216
byte 1 37
byte 1 100
byte 1 32
byte 1 108
byte 1 101
byte 1 110
byte 1 115
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 105
byte 1 101
byte 1 115
byte 1 32
byte 1 115
byte 1 97
byte 1 118
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $215
byte 1 123
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 125
byte 1 10
byte 1 0
align 1
LABELV $214
byte 1 108
byte 1 114
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 0
align 1
LABELV $211
byte 1 109
byte 1 118
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 0
align 1
LABELV $200
byte 1 119
byte 1 114
byte 1 105
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 46
byte 1 46
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $199
byte 1 67
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 99
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $196
byte 1 102
byte 1 108
byte 1 97
byte 1 114
byte 1 101
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 46
byte 1 108
byte 1 102
byte 1 101
byte 1 0
align 1
LABELV $195
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $177
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $144
byte 1 40
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 41
byte 1 32
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $139
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $138
byte 1 99
byte 1 103
byte 1 95
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $136
byte 1 103
byte 1 99
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 0
