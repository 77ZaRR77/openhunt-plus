data
export forceModelModificationCount
align 4
LABELV forceModelModificationCount
byte 4 -1
export vmMain
code
proc vmMain 16 12
file "..\..\..\..\code\cgame\cg_main.c"
line 28
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_main.c -- initialization and primary entry point for cgame
;4:#include "cg_local.h"
;5:
;6:#ifdef MISSIONPACK
;7:#include "../ui/ui_shared.h"
;8:// display context for new ui stuff
;9:displayContextDef_t cgDC;
;10:#endif
;11:
;12:#define LFDEBUG 0	// JUHOX DEBUG
;13:
;14:int forceModelModificationCount = -1;
;15:
;16:void CG_Init( int serverMessageNum, int serverCommandSequence, int clientNum );
;17:void CG_Shutdown( void );
;18:
;19:
;20:/*
;21:================
;22:vmMain
;23:
;24:This is the only way control passes into the module.
;25:This must be the very first function compiled into the .q3vm file
;26:================
;27:*/
;28:int vmMain( int command, int arg0, int arg1, int arg2, int arg3, int arg4, int arg5, int arg6, int arg7, int arg8, int arg9, int arg10, int arg11  ) {
line 30
;29:
;30:	switch ( command ) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $125
ADDRLP4 0
INDIRI4
CNSTI4 8
GTI4 $125
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $137
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $137
address $127
address $128
address $129
address $130
address $131
address $132
address $133
address $134
address $135
code
LABELV $127
line 32
;31:	case CG_INIT:
;32:		CG_Init( arg0, arg1, arg2 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 CG_Init
CALLV
pop
line 33
;33:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $124
JUMPV
LABELV $128
line 35
;34:	case CG_SHUTDOWN:
;35:		CG_Shutdown();
ADDRGP4 CG_Shutdown
CALLV
pop
line 36
;36:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $124
JUMPV
LABELV $129
line 38
;37:	case CG_CONSOLE_COMMAND:
;38:		return CG_ConsoleCommand();
ADDRLP4 4
ADDRGP4 CG_ConsoleCommand
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $124
JUMPV
LABELV $130
line 40
;39:	case CG_DRAW_ACTIVE_FRAME:
;40:		CG_DrawActiveFrame( arg0, arg1, arg2 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 CG_DrawActiveFrame
CALLV
pop
line 41
;41:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $124
JUMPV
LABELV $131
line 43
;42:	case CG_CROSSHAIR_PLAYER:
;43:		return CG_CrosshairPlayer();
ADDRLP4 8
ADDRGP4 CG_CrosshairPlayer
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
ADDRGP4 $124
JUMPV
LABELV $132
line 45
;44:	case CG_LAST_ATTACKER:
;45:		return CG_LastAttacker();
ADDRLP4 12
ADDRGP4 CG_LastAttacker
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
RETI4
ADDRGP4 $124
JUMPV
LABELV $133
line 47
;46:	case CG_KEY_EVENT:
;47:		CG_KeyEvent(arg0, arg1);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 CG_KeyEvent
CALLV
pop
line 48
;48:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $124
JUMPV
LABELV $134
line 54
;49:	case CG_MOUSE_EVENT:
;50:#ifdef MISSIONPACK
;51:		cgDC.cursorx = cgs.cursorX;
;52:		cgDC.cursory = cgs.cursorY;
;53:#endif
;54:		CG_MouseEvent(arg0, arg1);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 CG_MouseEvent
CALLV
pop
line 55
;55:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $124
JUMPV
LABELV $135
line 57
;56:	case CG_EVENT_HANDLING:
;57:		CG_EventHandling(arg0);
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 CG_EventHandling
CALLV
pop
line 58
;58:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $124
JUMPV
LABELV $125
line 60
;59:	default:
;60:		CG_Error( "vmMain: unknown command %i", command );
ADDRGP4 $136
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 61
;61:		break;
LABELV $126
line 63
;62:	}
;63:	return -1;
CNSTI4 -1
RETI4
LABELV $124
endproc vmMain 16 12
data
align 4
LABELV cvarTable
address cg_ignore
address $139
address $140
byte 4 0
address cg_drawNumMonsters
address $141
address $140
byte 4 1
address cg_fireballTrail
address $142
address $143
byte 4 1
address cg_drawSegment
address $144
address $140
byte 4 1
address cg_tssiMouse
address $145
address $146
byte 4 64
address cg_tssiKey
address $147
address $146
byte 4 64
address cg_tmplcmd
address $148
address $146
byte 4 64
address cg_noTrace
address $149
address $140
byte 4 1
address cg_autoswitch
address $150
address $143
byte 4 1
address cg_autoswitchAmmoLimit
address $151
address $152
byte 4 1
address cg_weaponOrder
address $153
address $154
byte 4 1
address cg_weaponOrder+272
address $156
address $157
byte 4 1
address cg_weaponOrder+544
address $159
address $160
byte 4 1
address cg_weaponOrder+816
address $162
address $163
byte 4 1
address cg_weaponOrder+1088
address $165
address $166
byte 4 1
address cg_weaponOrder+1360
address $168
address $169
byte 4 1
address cg_weaponOrderName
address $170
address $171
byte 4 1
address cg_weaponOrderName+272
address $173
address $174
byte 4 1
address cg_weaponOrderName+544
address $176
address $177
byte 4 1
address cg_weaponOrderName+816
address $179
address $180
byte 4 1
address cg_weaponOrderName+1088
address $182
address $183
byte 4 1
address cg_weaponOrderName+1360
address $185
address $186
byte 4 1
address cg_drawGun
address $187
address $143
byte 4 1
address cg_zoomFov
address $188
address $189
byte 4 1
address cg_fov
address $190
address $191
byte 4 1
address cg_viewsize
address $192
address $193
byte 4 1
address cg_stereoSeparation
address $194
address $195
byte 4 1
address cg_shadows
address $196
address $143
byte 4 1
address cg_gibs
address $197
address $143
byte 4 1
address cg_draw2D
address $198
address $143
byte 4 1
address cg_drawStatus
address $199
address $143
byte 4 1
address cg_drawTimer
address $200
address $140
byte 4 1
address cg_drawFPS
address $201
address $140
byte 4 1
address cg_drawSnapshot
address $202
address $140
byte 4 1
address cg_draw3dIcons
address $203
address $143
byte 4 1
address cg_drawIcons
address $204
address $143
byte 4 1
address cg_drawAmmoWarning
address $205
address $143
byte 4 1
address cg_drawAttacker
address $206
address $143
byte 4 1
address cg_drawCrosshair
address $207
address $208
byte 4 1
address cg_drawCrosshairNames
address $209
address $143
byte 4 1
address cg_drawRewards
address $210
address $143
byte 4 1
address cg_crosshairSize
address $211
address $212
byte 4 1
address cg_crosshairHealth
address $213
address $143
byte 4 1
address cg_crosshairX
address $214
address $140
byte 4 1
address cg_crosshairY
address $215
address $140
byte 4 1
address cg_brassTime
address $216
address $217
byte 4 1
address cg_simpleItems
address $218
address $140
byte 4 1
address cg_addMarks
address $219
address $143
byte 4 1
address cg_lagometer
address $220
address $143
byte 4 1
address cg_railTrailTime
address $221
address $222
byte 4 1
address cg_gun_x
address $223
address $140
byte 4 512
address cg_gun_y
address $224
address $140
byte 4 512
address cg_gun_z
address $225
address $140
byte 4 512
address cg_centertime
address $226
address $227
byte 4 512
address cg_runpitch
address $228
address $229
byte 4 1
address cg_runroll
address $230
address $231
byte 4 1
address cg_bobup
address $232
address $231
byte 4 512
address cg_bobpitch
address $233
address $229
byte 4 1
address cg_bobroll
address $234
address $229
byte 4 1
address cg_swingSpeed
address $235
address $236
byte 4 512
address cg_animSpeed
address $237
address $143
byte 4 512
address cg_debugAnim
address $238
address $140
byte 4 512
address cg_debugPosition
address $239
address $140
byte 4 512
address cg_debugEvents
address $240
address $140
byte 4 512
address cg_errorDecay
address $241
address $193
byte 4 0
address cg_nopredict
address $242
address $140
byte 4 0
address cg_noPlayerAnims
address $243
address $140
byte 4 512
address cg_showmiss
address $244
address $140
byte 4 0
address cg_footsteps
address $245
address $143
byte 4 512
address cg_tracerChance
address $246
address $195
byte 4 512
address cg_tracerWidth
address $247
address $143
byte 4 512
address cg_tracerLength
address $248
address $193
byte 4 512
address cg_thirdPersonRange
address $249
address $250
byte 4 512
address cg_thirdPersonAngle
address $251
address $140
byte 4 512
address cg_thirdPerson
address $252
address $140
byte 4 0
address cg_teamChatTime
address $253
address $254
byte 4 1
address cg_teamChatHeight
address $255
address $140
byte 4 1
address cg_forceModel
address $256
address $140
byte 4 1
address cg_predictItems
address $257
address $143
byte 4 1
address cg_deferPlayers
address $258
address $143
byte 4 1
address cg_drawTeamOverlay
address $259
address $140
byte 4 1
address cg_teamOverlayUserinfo
address $260
address $140
byte 4 66
address cg_stats
address $261
address $140
byte 4 0
address cg_glassCloaking
address $262
address $140
byte 4 3
address cg_lensFlare
address $263
address $143
byte 4 1
address cg_mapFlare
address $264
address $265
byte 4 1
address cg_sunFlare
address $266
address $265
byte 4 1
address cg_missileFlare
address $267
address $143
byte 4 1
address cg_BFGsuperExpl
address $268
address $143
byte 4 1
address cg_nearbox
address $269
address $143
byte 4 1
address cg_autoGLC
address $270
address $143
byte 4 1
address cg_drawFriend
address $271
address $143
byte 4 1
address cg_teamChatsOnly
address $272
address $140
byte 4 1
address cg_noVoiceChats
address $273
address $140
byte 4 1
address cg_noVoiceText
address $274
address $140
byte 4 1
address cg_buildScript
address $275
address $140
byte 4 0
address cg_paused
address $276
address $140
byte 4 64
address cg_blood
address $277
address $143
byte 4 1
address cg_synchronousClients
address $278
address $140
byte 4 0
address cg_cameraOrbit
address $279
address $140
byte 4 512
address cg_cameraOrbitDelay
address $280
address $152
byte 4 1
address cg_timescaleFadeEnd
address $281
address $143
byte 4 512
address cg_timescaleFadeSpeed
address $282
address $140
byte 4 512
address cg_timescale
address $283
address $143
byte 4 512
address cg_scorePlum
address $284
address $143
byte 4 3
address cg_smoothClients
address $285
address $140
byte 4 3
address cg_cameraMode
address $286
address $140
byte 4 512
address cg_music
address $287
address $140
byte 4 1
address pmove_fixed
address $288
address $140
byte 4 0
address pmove_msec
address $289
address $290
byte 4 0
address cg_noTaunt
address $291
address $140
byte 4 1
address cg_noProjectileTrail
address $292
address $140
byte 4 1
address cg_smallFont
address $293
address $294
byte 4 1
address cg_bigFont
address $295
address $195
byte 4 1
address cg_oldRail
address $296
address $143
byte 4 1
address cg_oldRocket
address $297
address $143
byte 4 1
address cg_oldPlasma
address $298
address $143
byte 4 1
address cg_trueLightning
address $299
address $300
byte 4 1
align 4
LABELV cvarTableSize
byte 4 118
export CG_RegisterCvars
code
proc CG_RegisterCvars 1036 16
line 396
;64:}
;65:
;66:
;67:cg_t				cg;
;68:cgs_t				cgs;
;69:centity_t			cg_entities[MAX_GENTITIES];
;70:weaponInfo_t		cg_weapons[MAX_WEAPONS];
;71:itemInfo_t			cg_items[MAX_ITEMS];
;72:
;73:
;74:vmCvar_t	cg_railTrailTime;
;75:vmCvar_t	cg_centertime;
;76:vmCvar_t	cg_runpitch;
;77:vmCvar_t	cg_runroll;
;78:vmCvar_t	cg_bobup;
;79:vmCvar_t	cg_bobpitch;
;80:vmCvar_t	cg_bobroll;
;81:vmCvar_t	cg_swingSpeed;
;82:vmCvar_t	cg_shadows;
;83:vmCvar_t	cg_gibs;
;84:vmCvar_t	cg_drawTimer;
;85:vmCvar_t	cg_drawFPS;
;86:vmCvar_t	cg_drawSnapshot;
;87:vmCvar_t	cg_draw3dIcons;
;88:vmCvar_t	cg_drawIcons;
;89:vmCvar_t	cg_drawAmmoWarning;
;90:vmCvar_t	cg_drawCrosshair;
;91:vmCvar_t	cg_drawCrosshairNames;
;92:vmCvar_t	cg_drawRewards;
;93:vmCvar_t	cg_crosshairSize;
;94:vmCvar_t	cg_crosshairX;
;95:vmCvar_t	cg_crosshairY;
;96:vmCvar_t	cg_crosshairHealth;
;97:vmCvar_t	cg_draw2D;
;98:vmCvar_t	cg_drawStatus;
;99:vmCvar_t	cg_animSpeed;
;100:vmCvar_t	cg_debugAnim;
;101:vmCvar_t	cg_debugPosition;
;102:vmCvar_t	cg_debugEvents;
;103:vmCvar_t	cg_errorDecay;
;104:vmCvar_t	cg_nopredict;
;105:vmCvar_t	cg_noPlayerAnims;
;106:vmCvar_t	cg_showmiss;
;107:vmCvar_t	cg_footsteps;
;108:vmCvar_t	cg_addMarks;
;109:vmCvar_t	cg_brassTime;
;110:vmCvar_t	cg_viewsize;
;111:vmCvar_t	cg_drawGun;
;112:vmCvar_t	cg_gun_frame;
;113:vmCvar_t	cg_gun_x;
;114:vmCvar_t	cg_gun_y;
;115:vmCvar_t	cg_gun_z;
;116:vmCvar_t	cg_tracerChance;
;117:vmCvar_t	cg_tracerWidth;
;118:vmCvar_t	cg_tracerLength;
;119:vmCvar_t	cg_autoswitch;
;120:vmCvar_t	cg_autoswitchAmmoLimit;	// JUHOX
;121:vmCvar_t	cg_weaponOrder[NUM_WEAPONORDERS];		// JUHOX
;122:vmCvar_t	cg_weaponOrderName[NUM_WEAPONORDERS];	// JUHOX
;123:vmCvar_t	cg_ignore;
;124:#if MONSTER_MODE	// JUHOX:  STU cvars
;125:vmCvar_t	cg_drawNumMonsters;
;126:vmCvar_t	cg_fireballTrail;
;127:#endif
;128:#if ESCAPE_MODE	// JUHOX: EFH cvars
;129:vmCvar_t	cg_drawSegment;
;130:#endif
;131:vmCvar_t	cg_tssiMouse;	// JUHOX
;132:vmCvar_t	cg_tssiKey;		// JUHOX
;133:vmCvar_t	cg_tmplcmd;		// JUHOX
;134:vmCvar_t	cg_noTrace;		// JUHOX
;135:vmCvar_t	cg_simpleItems;
;136:vmCvar_t	cg_fov;
;137:vmCvar_t	cg_zoomFov;
;138:vmCvar_t	cg_thirdPerson;
;139:vmCvar_t	cg_thirdPersonRange;
;140:vmCvar_t	cg_thirdPersonAngle;
;141:vmCvar_t	cg_stereoSeparation;
;142:vmCvar_t	cg_lagometer;
;143:vmCvar_t	cg_drawAttacker;
;144:vmCvar_t	cg_synchronousClients;
;145:vmCvar_t 	cg_teamChatTime;
;146:vmCvar_t 	cg_teamChatHeight;
;147:vmCvar_t 	cg_stats;
;148:vmCvar_t 	cg_buildScript;
;149:vmCvar_t 	cg_forceModel;
;150:vmCvar_t	cg_paused;
;151:vmCvar_t	cg_blood;
;152:vmCvar_t	cg_predictItems;
;153:vmCvar_t	cg_deferPlayers;
;154:vmCvar_t	cg_drawTeamOverlay;
;155:vmCvar_t	cg_teamOverlayUserinfo;
;156:vmCvar_t	cg_drawFriend;
;157:vmCvar_t	cg_teamChatsOnly;
;158:vmCvar_t	cg_noVoiceChats;
;159:vmCvar_t	cg_noVoiceText;
;160:vmCvar_t	cg_hudFiles;
;161:vmCvar_t 	cg_scorePlum;
;162:vmCvar_t 	cg_smoothClients;
;163:vmCvar_t	pmove_fixed;
;164://vmCvar_t	cg_pmove_fixed;
;165:vmCvar_t	pmove_msec;
;166:vmCvar_t	cg_pmove_msec;
;167:vmCvar_t	cg_cameraMode;
;168:vmCvar_t	cg_cameraOrbit;
;169:vmCvar_t	cg_cameraOrbitDelay;
;170:vmCvar_t	cg_timescaleFadeEnd;
;171:vmCvar_t	cg_timescaleFadeSpeed;
;172:vmCvar_t	cg_timescale;
;173:vmCvar_t	cg_smallFont;
;174:vmCvar_t	cg_bigFont;
;175:vmCvar_t	cg_noTaunt;
;176:vmCvar_t	cg_noProjectileTrail;
;177:vmCvar_t	cg_oldRail;
;178:vmCvar_t	cg_oldRocket;
;179:vmCvar_t	cg_oldPlasma;
;180:vmCvar_t	cg_trueLightning;
;181:vmCvar_t	cg_glassCloaking;	// JUHOX
;182:vmCvar_t	cg_lensFlare;		// JUHOX
;183:#if MAPLENSFLARES
;184:vmCvar_t	cg_mapFlare;		// JUHOX
;185:vmCvar_t	cg_sunFlare;		// JUHOX
;186:vmCvar_t	cg_missileFlare;	// JUHOX
;187:#endif
;188:vmCvar_t	cg_BFGsuperExpl;		// JUHOX
;189:vmCvar_t	cg_nearbox;			// JUHOX
;190:vmCvar_t	cg_autoGLC;			// JUHOX
;191:#if PLAYLIST
;192:vmCvar_t	cg_music;	// JUHOX: 0 = no music, 1 = default music, 2 = playlist
;193:#endif
;194:/*
;195:vmCvar_t	cg_tssFileService;	// JUHOX
;196:vmCvar_t	cg_tssFileLen;		// JUHOX
;197:vmCvar_t	cg_tssPacketLen;	// JUHOX
;198:*/
;199:
;200:#ifdef MISSIONPACK
;201:vmCvar_t 	cg_redTeamName;
;202:vmCvar_t 	cg_blueTeamName;
;203:vmCvar_t	cg_currentSelectedPlayer;
;204:vmCvar_t	cg_currentSelectedPlayerName;
;205:vmCvar_t	cg_singlePlayer;
;206:vmCvar_t	cg_enableDust;
;207:vmCvar_t	cg_enableBreath;
;208:vmCvar_t	cg_singlePlayerActive;
;209:vmCvar_t	cg_recordSPDemo;
;210:vmCvar_t	cg_recordSPDemoName;
;211:vmCvar_t	cg_obeliskRespawnDelay;
;212:#endif
;213:
;214:typedef struct {
;215:	vmCvar_t	*vmCvar;
;216:	char		*cvarName;
;217:	char		*defaultString;
;218:	int			cvarFlags;
;219:} cvarTable_t;
;220:
;221:static cvarTable_t cvarTable[] = { // bk001129
;222:	{ &cg_ignore, "cg_ignore", "0", 0 },	// used for debugging
;223:#if MONSTER_MODE	// JUHOX: STU cvars
;224:	{ &cg_drawNumMonsters, "cg_drawNumMonsters", "0", CVAR_ARCHIVE},
;225:	{ &cg_fireballTrail, "cg_fireballTrail", "1", CVAR_ARCHIVE},
;226:#endif
;227:#if ESCAPE_MODE	// JUHOX: EFH cvars
;228:	{ &cg_drawSegment, "cg_drawSegment", "0", CVAR_ARCHIVE},
;229:#endif
;230:	{ &cg_tssiMouse, "tssi_mouse", "", CVAR_ROM },	// JUHOX
;231:	{ &cg_tssiKey, "tssi_key", "", CVAR_ROM },	// JUHOX
;232:	{ &cg_tmplcmd, "tmplcmd", "", CVAR_ROM },	// JUHOX
;233:	{ &cg_noTrace, "cg_noTrace", "0", CVAR_ARCHIVE },	// JUHOX
;234:	{ &cg_autoswitch, "cg_autoswitch", "1", CVAR_ARCHIVE },
;235:	// JUHOX: new weapon switching cvars
;236:#if 1
;237:	{ &cg_autoswitchAmmoLimit, "cg_autoswitchAmmoLimit", "50", CVAR_ARCHIVE },
;238:	{ &cg_weaponOrder[0], "cg_weaponOrder0", "ICFJDHGLEB", CVAR_ARCHIVE },
;239:	{ &cg_weaponOrder[1], "cg_weaponOrder1", "DCGHLBIFEJ", CVAR_ARCHIVE },
;240:	{ &cg_weaponOrder[2], "cg_weaponOrder2", "FCIDGEJLHB", CVAR_ARCHIVE },
;241:	{ &cg_weaponOrder[3], "cg_weaponOrder3", "JFCEIDHGLB", CVAR_ARCHIVE },
;242:	{ &cg_weaponOrder[4], "cg_weaponOrder4", "HLJCFGIDEB", CVAR_ARCHIVE },
;243:	{ &cg_weaponOrder[5], "cg_weaponOrder5", "LGEJICDFHB", CVAR_ARCHIVE },
;244:	{ &cg_weaponOrderName[0], "cg_weaponOrder0Name", "pursuit", CVAR_ARCHIVE },
;245:	{ &cg_weaponOrderName[1], "cg_weaponOrder1Name", "close combat", CVAR_ARCHIVE },
;246:	{ &cg_weaponOrderName[2], "cg_weaponOrder2Name", "attack", CVAR_ARCHIVE },
;247:	{ &cg_weaponOrderName[3], "cg_weaponOrder3Name", "annihilation", CVAR_ARCHIVE },
;248:	{ &cg_weaponOrderName[4], "cg_weaponOrder4Name", "revenge", CVAR_ARCHIVE },
;249:	{ &cg_weaponOrderName[5], "cg_weaponOrder5Name", "defence", CVAR_ARCHIVE },
;250:#endif
;251:	{ &cg_drawGun, "cg_drawGun", "1", CVAR_ARCHIVE },
;252:	{ &cg_zoomFov, "cg_zoomfov", "22.5", CVAR_ARCHIVE },
;253:	{ &cg_fov, "cg_fov", "90", CVAR_ARCHIVE },
;254:	{ &cg_viewsize, "cg_viewsize", "100", CVAR_ARCHIVE },
;255:	{ &cg_stereoSeparation, "cg_stereoSeparation", "0.4", CVAR_ARCHIVE  },
;256:	{ &cg_shadows, "cg_shadows", "1", CVAR_ARCHIVE  },
;257:	{ &cg_gibs, "cg_gibs", "1", CVAR_ARCHIVE  },
;258:	{ &cg_draw2D, "cg_draw2D", "1", CVAR_ARCHIVE  },
;259:	{ &cg_drawStatus, "cg_drawStatus", "1", CVAR_ARCHIVE  },
;260:	{ &cg_drawTimer, "cg_drawTimer", "0", CVAR_ARCHIVE  },
;261:	{ &cg_drawFPS, "cg_drawFPS", "0", CVAR_ARCHIVE  },
;262:	{ &cg_drawSnapshot, "cg_drawSnapshot", "0", CVAR_ARCHIVE  },
;263:	{ &cg_draw3dIcons, "cg_draw3dIcons", "1", CVAR_ARCHIVE  },
;264:	{ &cg_drawIcons, "cg_drawIcons", "1", CVAR_ARCHIVE  },
;265:	{ &cg_drawAmmoWarning, "cg_drawAmmoWarning", "1", CVAR_ARCHIVE  },
;266:	{ &cg_drawAttacker, "cg_drawAttacker", "1", CVAR_ARCHIVE  },
;267:	{ &cg_drawCrosshair, "cg_drawCrosshair", "4", CVAR_ARCHIVE },
;268:	{ &cg_drawCrosshairNames, "cg_drawCrosshairNames", "1", CVAR_ARCHIVE },
;269:	{ &cg_drawRewards, "cg_drawRewards", "1", CVAR_ARCHIVE },
;270:	{ &cg_crosshairSize, "cg_crosshairSize", "24", CVAR_ARCHIVE },
;271:	{ &cg_crosshairHealth, "cg_crosshairHealth", "1", CVAR_ARCHIVE },
;272:	{ &cg_crosshairX, "cg_crosshairX", "0", CVAR_ARCHIVE },
;273:	{ &cg_crosshairY, "cg_crosshairY", "0", CVAR_ARCHIVE },
;274:	{ &cg_brassTime, "cg_brassTime", "2500", CVAR_ARCHIVE },
;275:	{ &cg_simpleItems, "cg_simpleItems", "0", CVAR_ARCHIVE },
;276:	{ &cg_addMarks, "cg_marks", "1", CVAR_ARCHIVE },
;277:	{ &cg_lagometer, "cg_lagometer", "1", CVAR_ARCHIVE },
;278:	{ &cg_railTrailTime, "cg_railTrailTime", "400", CVAR_ARCHIVE  },
;279:	{ &cg_gun_x, "cg_gunX", "0", CVAR_CHEAT },
;280:	{ &cg_gun_y, "cg_gunY", "0", CVAR_CHEAT },
;281:	{ &cg_gun_z, "cg_gunZ", "0", CVAR_CHEAT },
;282:	{ &cg_centertime, "cg_centertime", "3", CVAR_CHEAT },
;283:	{ &cg_runpitch, "cg_runpitch", "0.002", CVAR_ARCHIVE},
;284:	{ &cg_runroll, "cg_runroll", "0.005", CVAR_ARCHIVE },
;285:	{ &cg_bobup , "cg_bobup", "0.005", CVAR_CHEAT },
;286:	{ &cg_bobpitch, "cg_bobpitch", "0.002", CVAR_ARCHIVE },
;287:	{ &cg_bobroll, "cg_bobroll", "0.002", CVAR_ARCHIVE },
;288:	{ &cg_swingSpeed, "cg_swingSpeed", "0.3", CVAR_CHEAT },
;289:	{ &cg_animSpeed, "cg_animspeed", "1", CVAR_CHEAT },
;290:	{ &cg_debugAnim, "cg_debuganim", "0", CVAR_CHEAT },
;291:	{ &cg_debugPosition, "cg_debugposition", "0", CVAR_CHEAT },
;292:	{ &cg_debugEvents, "cg_debugevents", "0", CVAR_CHEAT },
;293:	{ &cg_errorDecay, "cg_errordecay", "100", 0 },
;294:	{ &cg_nopredict, "cg_nopredict", "0", 0 },
;295:	{ &cg_noPlayerAnims, "cg_noplayeranims", "0", CVAR_CHEAT },
;296:	{ &cg_showmiss, "cg_showmiss", "0", 0 },
;297:	{ &cg_footsteps, "cg_footsteps", "1", CVAR_CHEAT },
;298:	{ &cg_tracerChance, "cg_tracerchance", "0.4", CVAR_CHEAT },
;299:	{ &cg_tracerWidth, "cg_tracerwidth", "1", CVAR_CHEAT },
;300:	{ &cg_tracerLength, "cg_tracerlength", "100", CVAR_CHEAT },
;301:	{ &cg_thirdPersonRange, "cg_thirdPersonRange", "40", CVAR_CHEAT },
;302:	{ &cg_thirdPersonAngle, "cg_thirdPersonAngle", "0", CVAR_CHEAT },
;303:	{ &cg_thirdPerson, "cg_thirdPerson", "0", 0 },
;304:	{ &cg_teamChatTime, "cg_teamChatTime", "3000", CVAR_ARCHIVE  },
;305:	{ &cg_teamChatHeight, "cg_teamChatHeight", "0", CVAR_ARCHIVE  },
;306:	{ &cg_forceModel, "cg_forceModel", "0", CVAR_ARCHIVE  },
;307:	{ &cg_predictItems, "cg_predictItems", "1", CVAR_ARCHIVE },
;308:#ifdef MISSIONPACK
;309:	{ &cg_deferPlayers, "cg_deferPlayers", "0", CVAR_ARCHIVE },
;310:#else
;311:	{ &cg_deferPlayers, "cg_deferPlayers", "1", CVAR_ARCHIVE },
;312:#endif
;313:	{ &cg_drawTeamOverlay, "cg_drawTeamOverlay", "0", CVAR_ARCHIVE },
;314:	{ &cg_teamOverlayUserinfo, "teamoverlay", "0", CVAR_ROM | CVAR_USERINFO },
;315:	{ &cg_stats, "cg_stats", "0", 0 },
;316:	{ &cg_glassCloaking, "cg_glassCloaking", "0", CVAR_ARCHIVE | CVAR_USERINFO},	// JUHOX
;317:	{ &cg_lensFlare, "cg_lensFlare", "1", CVAR_ARCHIVE},	// JUHOX
;318:#if MAPLENSFLARES
;319:	{ &cg_mapFlare, "cg_mapFlare", "2", CVAR_ARCHIVE},		// JUHOX
;320:	{ &cg_sunFlare, "cg_sunFlare", "2", CVAR_ARCHIVE},		// JUHOX
;321:	{ &cg_missileFlare, "cg_missileFlare", "1", CVAR_ARCHIVE},	// JUHOX
;322:#endif
;323:	{ &cg_BFGsuperExpl, "cg_BFGsuperExpl", "1", CVAR_ARCHIVE},	// JUHOX
;324:	{ &cg_nearbox, "cg_nearbox", "1", CVAR_ARCHIVE},	// JUHOX
;325:	{ &cg_autoGLC, "cg_autoGLC", "1", CVAR_ARCHIVE},	// JUHOX
;326:	{ &cg_drawFriend, "cg_drawFriend", "1", CVAR_ARCHIVE },
;327:	{ &cg_teamChatsOnly, "cg_teamChatsOnly", "0", CVAR_ARCHIVE },
;328:	{ &cg_noVoiceChats, "cg_noVoiceChats", "0", CVAR_ARCHIVE },
;329:	{ &cg_noVoiceText, "cg_noVoiceText", "0", CVAR_ARCHIVE },
;330:	// the following variables are created in other parts of the system,
;331:	// but we also reference them here
;332:	{ &cg_buildScript, "com_buildScript", "0", 0 },	// force loading of all possible data amd error on failures
;333:	{ &cg_paused, "cl_paused", "0", CVAR_ROM },
;334:	{ &cg_blood, "com_blood", "1", CVAR_ARCHIVE },
;335:	{ &cg_synchronousClients, "g_synchronousClients", "0", 0 },	// communicated by systeminfo
;336:/*
;337:	{ &cg_tssFileService, "cg_tssFileService", "0", CVAR_ROM },	// JUHOX
;338:	{ &cg_tssFileLen, "cg_tssFileLen", "0", CVAR_ROM },	// JUHOX
;339:	{ &cg_tssPacketLen, "cg_tssPacketLen", "0", CVAR_ROM },	// JUHOX
;340:*/
;341:#ifdef MISSIONPACK
;342:	{ &cg_redTeamName, "g_redteam", DEFAULT_REDTEAM_NAME, CVAR_ARCHIVE | CVAR_SERVERINFO | CVAR_USERINFO },
;343:	{ &cg_blueTeamName, "g_blueteam", DEFAULT_BLUETEAM_NAME, CVAR_ARCHIVE | CVAR_SERVERINFO | CVAR_USERINFO },
;344:	{ &cg_currentSelectedPlayer, "cg_currentSelectedPlayer", "0", CVAR_ARCHIVE},
;345:	{ &cg_currentSelectedPlayerName, "cg_currentSelectedPlayerName", "", CVAR_ARCHIVE},
;346:	{ &cg_singlePlayer, "ui_singlePlayerActive", "0", CVAR_USERINFO},
;347:	{ &cg_enableDust, "g_enableDust", "0", CVAR_SERVERINFO},
;348:	{ &cg_enableBreath, "g_enableBreath", "0", CVAR_SERVERINFO},
;349:	{ &cg_singlePlayerActive, "ui_singlePlayerActive", "0", CVAR_USERINFO},
;350:	{ &cg_recordSPDemo, "ui_recordSPDemo", "0", CVAR_ARCHIVE},
;351:	{ &cg_recordSPDemoName, "ui_recordSPDemoName", "", CVAR_ARCHIVE},
;352:	{ &cg_obeliskRespawnDelay, "g_obeliskRespawnDelay", "10", CVAR_SERVERINFO},
;353:	{ &cg_hudFiles, "cg_hudFiles", "ui/hud.txt", CVAR_ARCHIVE},
;354:#endif
;355:	{ &cg_cameraOrbit, "cg_cameraOrbit", "0", CVAR_CHEAT},
;356:	{ &cg_cameraOrbitDelay, "cg_cameraOrbitDelay", "50", CVAR_ARCHIVE},
;357:	// JUHOX: make timescale cvars be cheat protected
;358:#if 0
;359:	{ &cg_timescaleFadeEnd, "cg_timescaleFadeEnd", "1", 0},
;360:	{ &cg_timescaleFadeSpeed, "cg_timescaleFadeSpeed", "0", 0},
;361:	{ &cg_timescale, "timescale", "1", 0},
;362:#else
;363:	{ &cg_timescaleFadeEnd, "cg_timescaleFadeEnd", "1", CVAR_CHEAT},
;364:	{ &cg_timescaleFadeSpeed, "cg_timescaleFadeSpeed", "0", CVAR_CHEAT},
;365:	{ &cg_timescale, "timescale", "1", CVAR_CHEAT},
;366:#endif
;367:	{ &cg_scorePlum, "cg_scorePlums", "1", CVAR_USERINFO | CVAR_ARCHIVE},
;368:	{ &cg_smoothClients, "cg_smoothClients", "0", CVAR_USERINFO | CVAR_ARCHIVE},
;369:	{ &cg_cameraMode, "com_cameraMode", "0", CVAR_CHEAT},
;370:
;371:#if PLAYLIST
;372:	{ &cg_music, "cg_music", "0", CVAR_ARCHIVE},	// JUHOX
;373:#endif
;374:
;375:	{ &pmove_fixed, "pmove_fixed", "0", 0},
;376:	{ &pmove_msec, "pmove_msec", "8", 0},
;377:	{ &cg_noTaunt, "cg_noTaunt", "0", CVAR_ARCHIVE},
;378:	{ &cg_noProjectileTrail, "cg_noProjectileTrail", "0", CVAR_ARCHIVE},
;379:	{ &cg_smallFont, "ui_smallFont", "0.25", CVAR_ARCHIVE},
;380:	{ &cg_bigFont, "ui_bigFont", "0.4", CVAR_ARCHIVE},
;381:
;382:	{ &cg_oldRail, "cg_oldRail", "1", CVAR_ARCHIVE},
;383:	{ &cg_oldRocket, "cg_oldRocket", "1", CVAR_ARCHIVE},
;384:	{ &cg_oldPlasma, "cg_oldPlasma", "1", CVAR_ARCHIVE},
;385:	{ &cg_trueLightning, "cg_trueLightning", "0.0", CVAR_ARCHIVE}
;386://	{ &cg_pmove_fixed, "cg_pmove_fixed", "0", CVAR_USERINFO | CVAR_ARCHIVE }
;387:};
;388:
;389:		static int  cvarTableSize = sizeof( cvarTable ) / sizeof( cvarTable[0] );
;390:
;391:/*
;392:=================
;393:CG_RegisterCvars
;394:=================
;395:*/
;396:void CG_RegisterCvars( void ) {
line 401
;397:	int			i;
;398:	cvarTable_t	*cv;
;399:	char		var[MAX_TOKEN_CHARS];
;400:
;401:	for ( i = 0, cv = cvarTable ; i < cvarTableSize ; i++, cv++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
ADDRGP4 cvarTable
ASGNP4
ADDRGP4 $305
JUMPV
LABELV $302
line 402
;402:		trap_Cvar_Register( cv->vmCvar, cv->cvarName,
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 404
;403:			cv->defaultString, cv->cvarFlags );
;404:	}
LABELV $303
line 401
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
LABELV $305
ADDRLP4 4
INDIRI4
ADDRGP4 cvarTableSize
INDIRI4
LTI4 $302
line 407
;405:
;406:	// see if we are also running the server on this machine
;407:	trap_Cvar_VariableStringBuffer( "sv_running", var, sizeof( var ) );
ADDRGP4 $306
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 408
;408:	cgs.localServer = atoi( var );
ADDRLP4 8
ARGP4
ADDRLP4 1032
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+31452
ADDRLP4 1032
INDIRI4
ASGNI4
line 410
;409:
;410:	forceModelModificationCount = cg_forceModel.modificationCount;
ADDRGP4 forceModelModificationCount
ADDRGP4 cg_forceModel+4
INDIRI4
ASGNI4
line 412
;411:
;412:	trap_Cvar_Register(NULL, "model", DEFAULT_MODEL, CVAR_USERINFO | CVAR_ARCHIVE );
CNSTP4 0
ARGP4
ADDRGP4 $309
ARGP4
ADDRGP4 $310
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 413
;413:	trap_Cvar_Register(NULL, "headmodel", DEFAULT_MODEL, CVAR_USERINFO | CVAR_ARCHIVE );
CNSTP4 0
ARGP4
ADDRGP4 $311
ARGP4
ADDRGP4 $310
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 414
;414:	trap_Cvar_Register(NULL, "team_model", DEFAULT_TEAM_MODEL, CVAR_USERINFO | CVAR_ARCHIVE );
CNSTP4 0
ARGP4
ADDRGP4 $312
ARGP4
ADDRGP4 $310
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 415
;415:	trap_Cvar_Register(NULL, "team_headmodel", DEFAULT_TEAM_HEAD, CVAR_USERINFO | CVAR_ARCHIVE );
CNSTP4 0
ARGP4
ADDRGP4 $313
ARGP4
ADDRGP4 $310
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 416
;416:	trap_Cvar_Register(NULL, "crouchCutsRope", "1", CVAR_USERINFO | CVAR_ARCHIVE);	// JUHOX
CNSTP4 0
ARGP4
ADDRGP4 $314
ARGP4
ADDRGP4 $143
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 417
;417:	trap_Cvar_Register(NULL, "color", "1", CVAR_USERINFO | CVAR_ARCHIVE);	// JUHOX
CNSTP4 0
ARGP4
ADDRGP4 $315
ARGP4
ADDRGP4 $143
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 418
;418:	trap_Cvar_Register(NULL, "developer", "0", CVAR_INIT);	// JUHOX
CNSTP4 0
ARGP4
ADDRGP4 $316
ARGP4
ADDRGP4 $140
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 419
;419:	trap_Cvar_Register(NULL, "monsterModel1", "klesk/maneater", CVAR_ARCHIVE);	// JUHOX
CNSTP4 0
ARGP4
ADDRGP4 $317
ARGP4
ADDRGP4 $318
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 420
;420:	trap_Cvar_Register(NULL, "monsterModel2", "tankjr/default", CVAR_ARCHIVE);	// JUHOX
CNSTP4 0
ARGP4
ADDRGP4 $319
ARGP4
ADDRGP4 $320
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 421
;421:	trap_Cvar_Register(NULL, "monsterModel3", "uriel/default", CVAR_ARCHIVE);	// JUHOX
CNSTP4 0
ARGP4
ADDRGP4 $321
ARGP4
ADDRGP4 $322
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 422
;422:}
LABELV $301
endproc CG_RegisterCvars 1036 16
proc CG_ForceModelChange 12 4
line 429
;423:
;424:/*
;425:===================
;426:CG_ForceModelChange
;427:===================
;428:*/
;429:static void CG_ForceModelChange( void ) {
line 432
;430:	int		i;
;431:
;432:	for (i=0 ; i<MAX_CLIENTS ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $324
line 435
;433:		const char		*clientInfo;
;434:
;435:		clientInfo = CG_ConfigString( CS_PLAYERS+i );
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 8
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 436
;436:		if ( !clientInfo[0] ) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $328
line 437
;437:			continue;
ADDRGP4 $325
JUMPV
LABELV $328
line 439
;438:		}
;439:		CG_NewClientInfo( i );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_NewClientInfo
CALLV
pop
line 440
;440:	}
LABELV $325
line 432
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $324
line 441
;441:}
LABELV $323
endproc CG_ForceModelChange 12 4
data
align 4
LABELV tssiMouseModificationCount
byte 4 -1
align 4
LABELV tssiKeyModificationCount
byte 4 -1
align 4
LABELV tmplcmdModificationCount
byte 4 -1
align 4
LABELV lastTmplcmdTime
byte 4 0
export CG_UpdateCvars
code
proc CG_UpdateCvars 8 8
line 453
;442:
;443:static int tssiMouseModificationCount = -1;	// JUHOX
;444:static int tssiKeyModificationCount = -1;	// JUHOX
;445:static int tmplcmdModificationCount = -1;	// JUHOX
;446:static int lastTmplcmdTime = 0;	// JUHOX
;447:
;448:/*
;449:=================
;450:CG_UpdateCvars
;451:=================
;452:*/
;453:void CG_UpdateCvars( void ) {
line 457
;454:	int			i;
;455:	cvarTable_t	*cv;
;456:
;457:	for ( i = 0, cv = cvarTable ; i < cvarTableSize ; i++, cv++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRLP4 4
ADDRGP4 cvarTable
ASGNP4
ADDRGP4 $334
JUMPV
LABELV $331
line 458
;458:		trap_Cvar_Update( cv->vmCvar );
ADDRLP4 4
INDIRP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 459
;459:	}
LABELV $332
line 457
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
LABELV $334
ADDRLP4 0
INDIRI4
ADDRGP4 cvarTableSize
INDIRI4
LTI4 $331
line 465
;460:
;461:	// check for modications here
;462:
;463:	// If team overlay is on, ask for updates from the server.  If its off,
;464:	// let the server know so we don't receive it
;465:	if ( drawTeamOverlayModificationCount != cg_drawTeamOverlay.modificationCount ) {
ADDRGP4 drawTeamOverlayModificationCount
INDIRI4
ADDRGP4 cg_drawTeamOverlay+4
INDIRI4
EQI4 $335
line 466
;466:		drawTeamOverlayModificationCount = cg_drawTeamOverlay.modificationCount;
ADDRGP4 drawTeamOverlayModificationCount
ADDRGP4 cg_drawTeamOverlay+4
INDIRI4
ASGNI4
line 468
;467:
;468:		if ( cg_drawTeamOverlay.integer > 0 ) {
ADDRGP4 cg_drawTeamOverlay+12
INDIRI4
CNSTI4 0
LEI4 $339
line 469
;469:			trap_Cvar_Set( "teamoverlay", "1" );
ADDRGP4 $260
ARGP4
ADDRGP4 $143
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 470
;470:		} else {
ADDRGP4 $340
JUMPV
LABELV $339
line 471
;471:			trap_Cvar_Set( "teamoverlay", "0" );
ADDRGP4 $260
ARGP4
ADDRGP4 $140
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 472
;472:		}
LABELV $340
line 474
;473:		// FIXME E3 HACK
;474:		trap_Cvar_Set( "teamoverlay", "1" );
ADDRGP4 $260
ARGP4
ADDRGP4 $143
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 475
;475:	}
LABELV $335
line 478
;476:
;477:	// if force model changed
;478:	if ( forceModelModificationCount != cg_forceModel.modificationCount ) {
ADDRGP4 forceModelModificationCount
INDIRI4
ADDRGP4 cg_forceModel+4
INDIRI4
EQI4 $342
line 479
;479:		forceModelModificationCount = cg_forceModel.modificationCount;
ADDRGP4 forceModelModificationCount
ADDRGP4 cg_forceModel+4
INDIRI4
ASGNI4
line 480
;480:		CG_ForceModelChange();
ADDRGP4 CG_ForceModelChange
CALLV
pop
line 481
;481:	}
LABELV $342
line 485
;482:
;483:	// JUHOX: check for mouse & keyboard events
;484:#if 1
;485:	if (tssiMouseModificationCount != cg_tssiMouse.modificationCount) {
ADDRGP4 tssiMouseModificationCount
INDIRI4
ADDRGP4 cg_tssiMouse+4
INDIRI4
EQI4 $346
line 486
;486:		tssiMouseModificationCount = cg_tssiMouse.modificationCount;
ADDRGP4 tssiMouseModificationCount
ADDRGP4 cg_tssiMouse+4
INDIRI4
ASGNI4
line 487
;487:		CG_TSS_CheckMouseEvents();
ADDRGP4 CG_TSS_CheckMouseEvents
CALLV
pop
line 488
;488:	}
LABELV $346
line 489
;489:	if (tssiKeyModificationCount != cg_tssiKey.modificationCount) {
ADDRGP4 tssiKeyModificationCount
INDIRI4
ADDRGP4 cg_tssiKey+4
INDIRI4
EQI4 $350
line 490
;490:		tssiKeyModificationCount = cg_tssiKey.modificationCount;
ADDRGP4 tssiKeyModificationCount
ADDRGP4 cg_tssiKey+4
INDIRI4
ASGNI4
line 491
;491:		CG_TSS_CheckKeyEvents();
ADDRGP4 CG_TSS_CheckKeyEvents
CALLV
pop
line 492
;492:	}
LABELV $350
line 498
;493:#endif
;494:
;495:	// JUHOX: check for template list commands from the UI module
;496:#if 1
;497:	if (
;498:		!cg.infoScreenText[0] &&
ADDRGP4 cg+112484
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $354
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $354
ADDRGP4 cg+36
INDIRP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $354
ADDRGP4 tmplcmdModificationCount
INDIRI4
ADDRGP4 cg_tmplcmd+4
INDIRI4
EQI4 $354
ADDRGP4 lastTmplcmdTime
INDIRI4
ADDRGP4 cg+107656
INDIRI4
CNSTI4 1500
SUBI4
GEI4 $354
line 503
;499:		cg.snap &&
;500:		!(cg.snap->snapFlags & SNAPFLAG_NOT_ACTIVE) &&
;501:		tmplcmdModificationCount != cg_tmplcmd.modificationCount &&
;502:		lastTmplcmdTime < cg.time - 1500
;503:	) {
line 504
;504:		tmplcmdModificationCount = cg_tmplcmd.modificationCount;
ADDRGP4 tmplcmdModificationCount
ADDRGP4 cg_tmplcmd+4
INDIRI4
ASGNI4
line 506
;505:
;506:		if (cg_tmplcmd.string[0]) {
ADDRGP4 cg_tmplcmd+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $362
line 507
;507:			trap_SendClientCommand(&cg_tmplcmd.string[1]);
ADDRGP4 cg_tmplcmd+16+1
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 508
;508:			lastTmplcmdTime = cg.time;
ADDRGP4 lastTmplcmdTime
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 509
;509:		}
LABELV $362
line 510
;510:	}
LABELV $354
line 512
;511:#endif
;512:}
LABELV $330
endproc CG_UpdateCvars 8 8
export CG_CrosshairPlayer
proc CG_CrosshairPlayer 0 0
line 514
;513:
;514:int CG_CrosshairPlayer( void ) {
line 515
;515:	if ( cg.time > ( cg.crosshairClientTime + 1000 ) ) {
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cg+127716
INDIRI4
CNSTI4 1000
ADDI4
LEI4 $369
line 516
;516:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $368
JUMPV
LABELV $369
line 518
;517:	}
;518:	return cg.crosshairClientNum;
ADDRGP4 cg+127712
INDIRI4
RETI4
LABELV $368
endproc CG_CrosshairPlayer 0 0
export CG_LastAttacker
proc CG_LastAttacker 0 0
line 521
;519:}
;520:
;521:int CG_LastAttacker( void ) {
line 522
;522:	if ( !cg.attackerTime ) {
ADDRGP4 cg+127728
INDIRI4
CNSTI4 0
NEI4 $375
line 523
;523:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $374
JUMPV
LABELV $375
line 525
;524:	}
;525:	return cg.snap->ps.persistant[PERS_ATTACKER];
ADDRGP4 cg+36
INDIRP4
CNSTI4 316
ADDP4
INDIRI4
RETI4
LABELV $374
endproc CG_LastAttacker 0 0
export CG_Printf
proc CG_Printf 1028 12
line 528
;526:}
;527:
;528:void QDECL CG_Printf( const char *msg, ... ) {
line 532
;529:	va_list		argptr;
;530:	char		text[1024];
;531:
;532:	va_start (argptr, msg);
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 533
;533:	vsprintf (text, msg, argptr);
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 vsprintf
CALLI4
pop
line 534
;534:	va_end (argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 536
;535:
;536:	trap_Print( text );
ADDRLP4 4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 537
;537:}
LABELV $379
endproc CG_Printf 1028 12
export CG_Error
proc CG_Error 1028 12
line 539
;538:
;539:void QDECL CG_Error( const char *msg, ... ) {
line 543
;540:	va_list		argptr;
;541:	char		text[1024];
;542:
;543:	va_start (argptr, msg);
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 544
;544:	vsprintf (text, msg, argptr);
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 vsprintf
CALLI4
pop
line 545
;545:	va_end (argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 547
;546:
;547:	trap_Error( text );
ADDRLP4 4
ARGP4
ADDRGP4 trap_Error
CALLV
pop
line 548
;548:}
LABELV $381
endproc CG_Error 1028 12
export Com_Error
proc Com_Error 1028 12
line 553
;549:
;550:#ifndef CGAME_HARD_LINKED
;551:// this is only here so the functions in q_shared.c and bg_*.c can link (FIXME)
;552:
;553:void QDECL Com_Error( int level, const char *error, ... ) {
line 557
;554:	va_list		argptr;
;555:	char		text[1024];
;556:
;557:	va_start (argptr, error);
ADDRLP4 0
ADDRFP4 4+4
ASGNP4
line 558
;558:	vsprintf (text, error, argptr);
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 vsprintf
CALLI4
pop
line 559
;559:	va_end (argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 561
;560:
;561:	CG_Error( "%s", text);
ADDRGP4 $385
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 562
;562:}
LABELV $383
endproc Com_Error 1028 12
export Com_Printf
proc Com_Printf 1028 12
line 564
;563:
;564:void QDECL Com_Printf( const char *msg, ... ) {
line 568
;565:	va_list		argptr;
;566:	char		text[1024];
;567:
;568:	va_start (argptr, msg);
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 569
;569:	vsprintf (text, msg, argptr);
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 vsprintf
CALLI4
pop
line 570
;570:	va_end (argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 572
;571:
;572:	CG_Printf ("%s", text);
ADDRGP4 $385
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 573
;573:}
LABELV $386
endproc Com_Printf 1028 12
bss
align 1
LABELV $389
skip 1024
export CG_Argv
code
proc CG_Argv 0 12
line 582
;574:
;575:#endif
;576:
;577:/*
;578:================
;579:CG_Argv
;580:================
;581:*/
;582:const char *CG_Argv( int arg ) {
line 585
;583:	static char	buffer[MAX_STRING_CHARS];
;584:
;585:	trap_Argv( arg, buffer, sizeof( buffer ) );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $389
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 587
;586:
;587:	return buffer;
ADDRGP4 $389
RETP4
LABELV $388
endproc CG_Argv 0 12
proc CG_RegisterItemSounds 96 12
line 600
;588:}
;589:
;590:
;591://========================================================================
;592:
;593:/*
;594:=================
;595:CG_RegisterItemSounds
;596:
;597:The server says this item is used on this level
;598:=================
;599:*/
;600:static void CG_RegisterItemSounds( int itemNum ) {
line 606
;601:	gitem_t			*item;
;602:	char			data[MAX_QPATH];
;603:	char			*s, *start;
;604:	int				len;
;605:
;606:	item = &bg_itemlist[ itemNum ];
ADDRLP4 76
ADDRFP4 0
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 608
;607:
;608:	if( item->pickup_sound ) {
ADDRLP4 76
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $391
line 609
;609:		trap_S_RegisterSound( item->pickup_sound, qfalse );
ADDRLP4 76
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_S_RegisterSound
CALLI4
pop
line 610
;610:	}
LABELV $391
line 613
;611:
;612:	// parse the space seperated precache string for other media
;613:	s = item->sounds;
ADDRLP4 0
ADDRLP4 76
INDIRP4
CNSTI4 48
ADDP4
INDIRP4
ASGNP4
line 614
;614:	if (!s || !s[0])
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $395
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $397
LABELV $395
line 615
;615:		return;
ADDRGP4 $390
JUMPV
LABELV $396
line 617
;616:
;617:	while (*s) {
line 618
;618:		start = s;
ADDRLP4 72
ADDRLP4 0
INDIRP4
ASGNP4
ADDRGP4 $400
JUMPV
LABELV $399
line 619
;619:		while (*s && *s != ' ') {
line 620
;620:			s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 621
;621:		}
LABELV $400
line 619
ADDRLP4 84
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
EQI4 $402
ADDRLP4 84
INDIRI4
CNSTI4 32
NEI4 $399
LABELV $402
line 623
;622:
;623:		len = s-start;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 72
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 624
;624:		if (len >= MAX_QPATH || len < 5) {
ADDRLP4 4
INDIRI4
CNSTI4 64
GEI4 $405
ADDRLP4 4
INDIRI4
CNSTI4 5
GEI4 $403
LABELV $405
line 625
;625:			CG_Error( "PrecacheItem: %s has bad precache string",
ADDRGP4 $406
ARGP4
ADDRLP4 76
INDIRP4
INDIRP4
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 627
;626:				item->classname);
;627:			return;
ADDRGP4 $390
JUMPV
LABELV $403
line 629
;628:		}
;629:		memcpy (data, start, len);
ADDRLP4 8
ARGP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 630
;630:		data[len] = 0;
ADDRLP4 4
INDIRI4
ADDRLP4 8
ADDP4
CNSTI1 0
ASGNI1
line 631
;631:		if ( *s ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $407
line 632
;632:			s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 633
;633:		}
LABELV $407
line 635
;634:
;635:		if ( !strcmp(data+len-3, "wav" )) {
ADDRLP4 4
INDIRI4
ADDRLP4 8-3
ADDP4
ARGP4
ADDRGP4 $412
ARGP4
ADDRLP4 92
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 0
NEI4 $409
line 636
;636:			trap_S_RegisterSound( data, qfalse );
ADDRLP4 8
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_S_RegisterSound
CALLI4
pop
line 637
;637:		}
LABELV $409
line 638
;638:	}
LABELV $397
line 617
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $396
line 639
;639:}
LABELV $390
endproc CG_RegisterItemSounds 96 12
proc CG_RegisterSounds 608 16
line 649
;640:
;641:
;642:/*
;643:=================
;644:CG_RegisterSounds
;645:
;646:called during a precache command
;647:=================
;648:*/
;649:static void CG_RegisterSounds( void ) {
line 660
;650:	int		i;
;651:	char	items[MAX_ITEMS+1];
;652:	char	name[MAX_QPATH];
;653:	const char	*soundName;
;654:
;655:	// voice commands
;656:#ifdef MISSIONPACK
;657:	CG_LoadVoiceChats();
;658:#endif
;659:
;660:	cgs.media.silence = trap_S_RegisterSound("sound/misc/silence.wav", qfalse);	// JUHOX
ADDRGP4 $416
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 332
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+828
ADDRLP4 332
INDIRI4
ASGNI4
line 662
;661:
;662:	cgs.media.oneMinuteSound = trap_S_RegisterSound( "sound/feedback/1_minute.wav", qtrue );
ADDRGP4 $419
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 336
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1248
ADDRLP4 336
INDIRI4
ASGNI4
line 663
;663:	cgs.media.fiveMinuteSound = trap_S_RegisterSound( "sound/feedback/5_minute.wav", qtrue );
ADDRGP4 $422
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 340
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1252
ADDRLP4 340
INDIRI4
ASGNI4
line 664
;664:	cgs.media.suddenDeathSound = trap_S_RegisterSound( "sound/feedback/sudden_death.wav", qtrue );
ADDRGP4 $425
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 344
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1256
ADDRLP4 344
INDIRI4
ASGNI4
line 665
;665:	cgs.media.oneFragSound = trap_S_RegisterSound( "sound/feedback/1_frag.wav", qtrue );
ADDRGP4 $428
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 348
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1268
ADDRLP4 348
INDIRI4
ASGNI4
line 666
;666:	cgs.media.twoFragSound = trap_S_RegisterSound( "sound/feedback/2_frags.wav", qtrue );
ADDRGP4 $431
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 352
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1264
ADDRLP4 352
INDIRI4
ASGNI4
line 667
;667:	cgs.media.threeFragSound = trap_S_RegisterSound( "sound/feedback/3_frags.wav", qtrue );
ADDRGP4 $434
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 356
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1260
ADDRLP4 356
INDIRI4
ASGNI4
line 668
;668:	cgs.media.count3Sound = trap_S_RegisterSound( "sound/feedback/three.wav", qtrue );
ADDRGP4 $437
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 360
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1460
ADDRLP4 360
INDIRI4
ASGNI4
line 669
;669:	cgs.media.count2Sound = trap_S_RegisterSound( "sound/feedback/two.wav", qtrue );
ADDRGP4 $440
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 364
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1464
ADDRLP4 364
INDIRI4
ASGNI4
line 670
;670:	cgs.media.count1Sound = trap_S_RegisterSound( "sound/feedback/one.wav", qtrue );
ADDRGP4 $443
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 368
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1468
ADDRLP4 368
INDIRI4
ASGNI4
line 671
;671:	cgs.media.countFightSound = trap_S_RegisterSound( "sound/feedback/fight.wav", qtrue );
ADDRGP4 $446
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 372
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1472
ADDRLP4 372
INDIRI4
ASGNI4
line 672
;672:	cgs.media.countPrepareSound = trap_S_RegisterSound( "sound/feedback/prepare.wav", qtrue );
ADDRGP4 $449
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 376
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1476
ADDRLP4 376
INDIRI4
ASGNI4
line 677
;673:#ifdef MISSIONPACK
;674:	cgs.media.countPrepareTeamSound = trap_S_RegisterSound( "sound/feedback/prepare_team.wav", qtrue );
;675:#endif
;676:
;677:	if ( cgs.gametype >= GT_TEAM || cg_buildScript.integer ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
GEI4 $454
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $450
LABELV $454
line 679
;678:
;679:		cgs.media.captureAwardSound = trap_S_RegisterSound( "sound/teamplay/flagcapture_yourteam.wav", qtrue );
ADDRGP4 $457
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 380
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1372
ADDRLP4 380
INDIRI4
ASGNI4
line 680
;680:		cgs.media.redLeadsSound = trap_S_RegisterSound( "sound/feedback/redleads.wav", qtrue );
ADDRGP4 $460
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 384
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1384
ADDRLP4 384
INDIRI4
ASGNI4
line 681
;681:		cgs.media.blueLeadsSound = trap_S_RegisterSound( "sound/feedback/blueleads.wav", qtrue );
ADDRGP4 $463
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 388
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1388
ADDRLP4 388
INDIRI4
ASGNI4
line 682
;682:		cgs.media.teamsTiedSound = trap_S_RegisterSound( "sound/feedback/teamstied.wav", qtrue );
ADDRGP4 $466
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 392
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1392
ADDRLP4 392
INDIRI4
ASGNI4
line 683
;683:		cgs.media.hitTeamSound = trap_S_RegisterSound( "sound/feedback/hit_teammate.wav", qtrue );
ADDRGP4 $469
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 396
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1284
ADDRLP4 396
INDIRI4
ASGNI4
line 685
;684:
;685:		cgs.media.redScoredSound = trap_S_RegisterSound( "sound/teamplay/voc_red_scores.wav", qtrue );
ADDRGP4 $472
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 400
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1376
ADDRLP4 400
INDIRI4
ASGNI4
line 686
;686:		cgs.media.blueScoredSound = trap_S_RegisterSound( "sound/teamplay/voc_blue_scores.wav", qtrue );
ADDRGP4 $475
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 404
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1380
ADDRLP4 404
INDIRI4
ASGNI4
line 688
;687:
;688:		cgs.media.captureYourTeamSound = trap_S_RegisterSound( "sound/teamplay/flagcapture_yourteam.wav", qtrue );
ADDRGP4 $457
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 408
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1396
ADDRLP4 408
INDIRI4
ASGNI4
line 689
;689:		cgs.media.captureOpponentSound = trap_S_RegisterSound( "sound/teamplay/flagcapture_opponent.wav", qtrue );
ADDRGP4 $480
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 412
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1400
ADDRLP4 412
INDIRI4
ASGNI4
line 691
;690:
;691:		cgs.media.returnYourTeamSound = trap_S_RegisterSound( "sound/teamplay/flagreturn_yourteam.wav", qtrue );
ADDRGP4 $483
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 416
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1404
ADDRLP4 416
INDIRI4
ASGNI4
line 692
;692:		cgs.media.returnOpponentSound = trap_S_RegisterSound( "sound/teamplay/flagreturn_opponent.wav", qtrue );
ADDRGP4 $486
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 420
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1408
ADDRLP4 420
INDIRI4
ASGNI4
line 694
;693:
;694:		cgs.media.takenYourTeamSound = trap_S_RegisterSound( "sound/teamplay/flagtaken_yourteam.wav", qtrue );
ADDRGP4 $489
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 424
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1412
ADDRLP4 424
INDIRI4
ASGNI4
line 695
;695:		cgs.media.takenOpponentSound = trap_S_RegisterSound( "sound/teamplay/flagtaken_opponent.wav", qtrue );
ADDRGP4 $492
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 428
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1416
ADDRLP4 428
INDIRI4
ASGNI4
line 697
;696:
;697:		if ( cgs.gametype == GT_CTF || cg_buildScript.integer ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
EQI4 $497
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $493
LABELV $497
line 698
;698:			cgs.media.redFlagReturnedSound = trap_S_RegisterSound( "sound/teamplay/voc_red_returned.wav", qtrue );
ADDRGP4 $500
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 432
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1420
ADDRLP4 432
INDIRI4
ASGNI4
line 699
;699:			cgs.media.blueFlagReturnedSound = trap_S_RegisterSound( "sound/teamplay/voc_blue_returned.wav", qtrue );
ADDRGP4 $503
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 436
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1424
ADDRLP4 436
INDIRI4
ASGNI4
line 700
;700:			cgs.media.enemyTookYourFlagSound = trap_S_RegisterSound( "sound/teamplay/voc_enemy_flag.wav", qtrue );
ADDRGP4 $506
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 440
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1432
ADDRLP4 440
INDIRI4
ASGNI4
line 701
;701:			cgs.media.yourTeamTookEnemyFlagSound = trap_S_RegisterSound( "sound/teamplay/voc_team_flag.wav", qtrue );
ADDRGP4 $509
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 444
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1440
ADDRLP4 444
INDIRI4
ASGNI4
line 702
;702:		}
LABELV $493
line 721
;703:
;704:#ifdef MISSIONPACK
;705:		if ( cgs.gametype == GT_1FCTF || cg_buildScript.integer ) {
;706:			// FIXME: get a replacement for this sound ?
;707:			cgs.media.neutralFlagReturnedSound = trap_S_RegisterSound( "sound/teamplay/flagreturn_opponent.wav", qtrue );
;708:			cgs.media.yourTeamTookTheFlagSound = trap_S_RegisterSound( "sound/teamplay/voc_team_1flag.wav", qtrue );
;709:			cgs.media.enemyTookTheFlagSound = trap_S_RegisterSound( "sound/teamplay/voc_enemy_1flag.wav", qtrue );
;710:		}
;711:
;712:		if ( cgs.gametype == GT_1FCTF || cgs.gametype == GT_CTF || cg_buildScript.integer ) {
;713:			cgs.media.youHaveFlagSound = trap_S_RegisterSound( "sound/teamplay/voc_you_flag.wav", qtrue );
;714:			cgs.media.holyShitSound = trap_S_RegisterSound("sound/feedback/voc_holyshit.wav", qtrue);
;715:		}
;716:
;717:		if ( cgs.gametype == GT_OBELISK || cg_buildScript.integer ) {
;718:			cgs.media.yourBaseIsUnderAttackSound = trap_S_RegisterSound( "sound/teamplay/voc_base_attack.wav", qtrue );
;719:		}
;720:#else
;721:		cgs.media.youHaveFlagSound = trap_S_RegisterSound( "sound/teamplay/voc_you_flag.wav", qtrue );
ADDRGP4 $512
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 432
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1448
ADDRLP4 432
INDIRI4
ASGNI4
line 722
;722:		cgs.media.holyShitSound = trap_S_RegisterSound("sound/feedback/voc_holyshit.wav", qtrue);
ADDRGP4 $515
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 436
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1456
ADDRLP4 436
INDIRI4
ASGNI4
line 723
;723:		cgs.media.neutralFlagReturnedSound = trap_S_RegisterSound( "sound/teamplay/flagreturn_opponent.wav", qtrue );
ADDRGP4 $486
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 440
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1428
ADDRLP4 440
INDIRI4
ASGNI4
line 724
;724:		cgs.media.yourTeamTookTheFlagSound = trap_S_RegisterSound( "sound/teamplay/voc_team_1flag.wav", qtrue );
ADDRGP4 $520
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 444
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1444
ADDRLP4 444
INDIRI4
ASGNI4
line 725
;725:		cgs.media.enemyTookTheFlagSound = trap_S_RegisterSound( "sound/teamplay/voc_enemy_1flag.wav", qtrue );
ADDRGP4 $523
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 448
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1436
ADDRLP4 448
INDIRI4
ASGNI4
line 727
;726:#endif
;727:	}
LABELV $450
line 729
;728:
;729:	cgs.media.tracerSound = trap_S_RegisterSound( "sound/weapons/machinegun/buletby1.wav", qfalse );
ADDRGP4 $526
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 380
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+836
ADDRLP4 380
INDIRI4
ASGNI4
line 730
;730:	cgs.media.selectSound = trap_S_RegisterSound( "sound/weapons/change.wav", qfalse );
ADDRGP4 $529
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 384
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+840
ADDRLP4 384
INDIRI4
ASGNI4
line 731
;731:	cgs.media.wearOffSound = trap_S_RegisterSound( "sound/items/wearoff.wav", qfalse );
ADDRGP4 $532
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 388
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+848
ADDRLP4 388
INDIRI4
ASGNI4
line 732
;732:	cgs.media.useNothingSound = trap_S_RegisterSound( "sound/items/use_nothing.wav", qfalse );
ADDRGP4 $535
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 392
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+844
ADDRLP4 392
INDIRI4
ASGNI4
line 733
;733:	cgs.media.gibSound = trap_S_RegisterSound( "sound/player/gibsplt1.wav", qfalse );
ADDRGP4 $538
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 396
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1000
ADDRLP4 396
INDIRI4
ASGNI4
line 734
;734:	cgs.media.gibBounce1Sound = trap_S_RegisterSound( "sound/player/gibimp1.wav", qfalse );
ADDRGP4 $541
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 400
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1004
ADDRLP4 400
INDIRI4
ASGNI4
line 735
;735:	cgs.media.gibBounce2Sound = trap_S_RegisterSound( "sound/player/gibimp2.wav", qfalse );
ADDRGP4 $544
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 404
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1008
ADDRLP4 404
INDIRI4
ASGNI4
line 736
;736:	cgs.media.gibBounce3Sound = trap_S_RegisterSound( "sound/player/gibimp3.wav", qfalse );
ADDRGP4 $547
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 408
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1012
ADDRLP4 408
INDIRI4
ASGNI4
line 755
;737:
;738:#ifdef MISSIONPACK
;739:	cgs.media.useInvulnerabilitySound = trap_S_RegisterSound( "sound/items/invul_activate.wav", qfalse );
;740:	cgs.media.invulnerabilityImpactSound1 = trap_S_RegisterSound( "sound/items/invul_impact_01.wav", qfalse );
;741:	cgs.media.invulnerabilityImpactSound2 = trap_S_RegisterSound( "sound/items/invul_impact_02.wav", qfalse );
;742:	cgs.media.invulnerabilityImpactSound3 = trap_S_RegisterSound( "sound/items/invul_impact_03.wav", qfalse );
;743:	cgs.media.invulnerabilityJuicedSound = trap_S_RegisterSound( "sound/items/invul_juiced.wav", qfalse );
;744:	cgs.media.obeliskHitSound1 = trap_S_RegisterSound( "sound/items/obelisk_hit_01.wav", qfalse );
;745:	cgs.media.obeliskHitSound2 = trap_S_RegisterSound( "sound/items/obelisk_hit_02.wav", qfalse );
;746:	cgs.media.obeliskHitSound3 = trap_S_RegisterSound( "sound/items/obelisk_hit_03.wav", qfalse );
;747:	cgs.media.obeliskRespawnSound = trap_S_RegisterSound( "sound/items/obelisk_respawn.wav", qfalse );
;748:
;749:	cgs.media.ammoregenSound = trap_S_RegisterSound("sound/items/cl_ammoregen.wav", qfalse);
;750:	cgs.media.doublerSound = trap_S_RegisterSound("sound/items/cl_doubler.wav", qfalse);
;751:	cgs.media.guardSound = trap_S_RegisterSound("sound/items/cl_guard.wav", qfalse);
;752:	cgs.media.scoutSound = trap_S_RegisterSound("sound/items/cl_scout.wav", qfalse);
;753:#endif
;754:
;755:	cgs.media.teleInSound = trap_S_RegisterSound( "sound/world/telein.wav", qfalse );
ADDRGP4 $550
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 412
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1016
ADDRLP4 412
INDIRI4
ASGNI4
line 756
;756:	cgs.media.teleOutSound = trap_S_RegisterSound( "sound/world/teleout.wav", qfalse );
ADDRGP4 $553
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 416
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1020
ADDRLP4 416
INDIRI4
ASGNI4
line 757
;757:	cgs.media.respawnSound = trap_S_RegisterSound( "sound/items/respawn1.wav", qfalse );
ADDRGP4 $556
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 420
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1028
ADDRLP4 420
INDIRI4
ASGNI4
line 759
;758:
;759:	cgs.media.noAmmoSound = trap_S_RegisterSound( "sound/weapons/noammo.wav", qfalse );
ADDRGP4 $559
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 424
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1024
ADDRLP4 424
INDIRI4
ASGNI4
line 761
;760:
;761:	cgs.media.talkSound = trap_S_RegisterSound( "sound/player/talk.wav", qfalse );
ADDRGP4 $562
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 428
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1032
ADDRLP4 428
INDIRI4
ASGNI4
line 762
;762:	cgs.media.landSound = trap_S_RegisterSound( "sound/player/land1.wav", qfalse);
ADDRGP4 $565
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 432
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1036
ADDRLP4 432
INDIRI4
ASGNI4
line 764
;763:
;764:	cgs.media.hitSound = trap_S_RegisterSound( "sound/feedback/hit.wav", qfalse );
ADDRGP4 $568
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 436
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1272
ADDRLP4 436
INDIRI4
ASGNI4
line 770
;765:#ifdef MISSIONPACK
;766:	cgs.media.hitSoundHighArmor = trap_S_RegisterSound( "sound/feedback/hithi.wav", qfalse );
;767:	cgs.media.hitSoundLowArmor = trap_S_RegisterSound( "sound/feedback/hitlo.wav", qfalse );
;768:#endif
;769:
;770:	cgs.media.impressiveSound = trap_S_RegisterSound( "sound/feedback/impressive.wav", qtrue );
ADDRGP4 $571
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 440
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1288
ADDRLP4 440
INDIRI4
ASGNI4
line 771
;771:	cgs.media.excellentSound = trap_S_RegisterSound( "sound/feedback/excellent.wav", qtrue );
ADDRGP4 $574
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 444
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1292
ADDRLP4 444
INDIRI4
ASGNI4
line 772
;772:	cgs.media.deniedSound = trap_S_RegisterSound( "sound/feedback/denied.wav", qtrue );
ADDRGP4 $577
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 448
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1296
ADDRLP4 448
INDIRI4
ASGNI4
line 773
;773:	cgs.media.humiliationSound = trap_S_RegisterSound( "sound/feedback/humiliation.wav", qtrue );
ADDRGP4 $580
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 452
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1300
ADDRLP4 452
INDIRI4
ASGNI4
line 774
;774:	cgs.media.assistSound = trap_S_RegisterSound( "sound/feedback/assist.wav", qtrue );
ADDRGP4 $583
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 456
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1304
ADDRLP4 456
INDIRI4
ASGNI4
line 775
;775:	cgs.media.defendSound = trap_S_RegisterSound( "sound/feedback/defense.wav", qtrue );
ADDRGP4 $586
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 460
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1308
ADDRLP4 460
INDIRI4
ASGNI4
line 782
;776:#ifdef MISSIONPACK
;777:	cgs.media.firstImpressiveSound = trap_S_RegisterSound( "sound/feedback/first_impressive.wav", qtrue );
;778:	cgs.media.firstExcellentSound = trap_S_RegisterSound( "sound/feedback/first_excellent.wav", qtrue );
;779:	cgs.media.firstHumiliationSound = trap_S_RegisterSound( "sound/feedback/first_gauntlet.wav", qtrue );
;780:#endif
;781:
;782:	cgs.media.takenLeadSound = trap_S_RegisterSound( "sound/feedback/takenlead.wav", qtrue);
ADDRGP4 $589
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 464
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1324
ADDRLP4 464
INDIRI4
ASGNI4
line 783
;783:	cgs.media.tiedLeadSound = trap_S_RegisterSound( "sound/feedback/tiedlead.wav", qtrue);
ADDRGP4 $592
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 468
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1328
ADDRLP4 468
INDIRI4
ASGNI4
line 784
;784:	cgs.media.lostLeadSound = trap_S_RegisterSound( "sound/feedback/lostlead.wav", qtrue);
ADDRGP4 $595
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 472
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1332
ADDRLP4 472
INDIRI4
ASGNI4
line 792
;785:
;786:#ifdef MISSIONPACK
;787:	cgs.media.voteNow = trap_S_RegisterSound( "sound/feedback/vote_now.wav", qtrue);
;788:	cgs.media.votePassed = trap_S_RegisterSound( "sound/feedback/vote_passed.wav", qtrue);
;789:	cgs.media.voteFailed = trap_S_RegisterSound( "sound/feedback/vote_failed.wav", qtrue);
;790:#endif
;791:
;792:	cgs.media.watrInSound = trap_S_RegisterSound( "sound/player/watr_in.wav", qfalse);
ADDRGP4 $598
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 476
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1348
ADDRLP4 476
INDIRI4
ASGNI4
line 793
;793:	cgs.media.watrOutSound = trap_S_RegisterSound( "sound/player/watr_out.wav", qfalse);
ADDRGP4 $601
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 480
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1352
ADDRLP4 480
INDIRI4
ASGNI4
line 794
;794:	cgs.media.watrUnSound = trap_S_RegisterSound( "sound/player/watr_un.wav", qfalse);
ADDRGP4 $604
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 484
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1356
ADDRLP4 484
INDIRI4
ASGNI4
line 796
;795:
;796:	cgs.media.jumpPadSound = trap_S_RegisterSound ("sound/world/jumppad.wav", qfalse );
ADDRGP4 $607
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 488
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1044
ADDRLP4 488
INDIRI4
ASGNI4
line 798
;797:
;798:	for (i=0 ; i<4 ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $608
line 799
;799:		Com_sprintf (name, sizeof(name), "sound/player/footsteps/step%i.wav", i+1);
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $612
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 800
;800:		cgs.media.footsteps[FOOTSTEP_NORMAL][i] = trap_S_RegisterSound (name, qfalse);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 492
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+751220+852
ADDP4
ADDRLP4 492
INDIRI4
ASGNI4
line 802
;801:
;802:		Com_sprintf (name, sizeof(name), "sound/player/footsteps/boot%i.wav", i+1);
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $615
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 803
;803:		cgs.media.footsteps[FOOTSTEP_BOOT][i] = trap_S_RegisterSound (name, qfalse);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 496
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+751220+852+16
ADDP4
ADDRLP4 496
INDIRI4
ASGNI4
line 805
;804:
;805:		Com_sprintf (name, sizeof(name), "sound/player/footsteps/flesh%i.wav", i+1);
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $619
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 806
;806:		cgs.media.footsteps[FOOTSTEP_FLESH][i] = trap_S_RegisterSound (name, qfalse);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 500
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+751220+852+32
ADDP4
ADDRLP4 500
INDIRI4
ASGNI4
line 808
;807:
;808:		Com_sprintf (name, sizeof(name), "sound/player/footsteps/mech%i.wav", i+1);
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $623
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 809
;809:		cgs.media.footsteps[FOOTSTEP_MECH][i] = trap_S_RegisterSound (name, qfalse);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 504
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+751220+852+48
ADDP4
ADDRLP4 504
INDIRI4
ASGNI4
line 811
;810:
;811:		Com_sprintf (name, sizeof(name), "sound/player/footsteps/energy%i.wav", i+1);
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $627
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 812
;812:		cgs.media.footsteps[FOOTSTEP_ENERGY][i] = trap_S_RegisterSound (name, qfalse);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 508
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+751220+852+64
ADDP4
ADDRLP4 508
INDIRI4
ASGNI4
line 814
;813:
;814:		Com_sprintf (name, sizeof(name), "sound/player/footsteps/splash%i.wav", i+1);
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $631
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 815
;815:		cgs.media.footsteps[FOOTSTEP_SPLASH][i] = trap_S_RegisterSound (name, qfalse);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 512
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+751220+852+96
ADDP4
ADDRLP4 512
INDIRI4
ASGNI4
line 817
;816:
;817:		Com_sprintf (name, sizeof(name), "sound/player/footsteps/clank%i.wav", i+1);
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $635
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 818
;818:		cgs.media.footsteps[FOOTSTEP_METAL][i] = trap_S_RegisterSound (name, qfalse);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 516
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+751220+852+80
ADDP4
ADDRLP4 516
INDIRI4
ASGNI4
line 819
;819:	}
LABELV $609
line 798
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $608
line 821
;820:
;821:	cgs.media.overkillSound = trap_S_RegisterSound("sound/overkill.wav", qfalse);	// JUHOX
ADDRGP4 $641
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 492
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1048
ADDRLP4 492
INDIRI4
ASGNI4
line 822
;822:	cgs.media.exterminatedSound = trap_S_RegisterSound("sound/exterminated.wav", qfalse);	// JUHOX
ADDRGP4 $644
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 496
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1052
ADDRLP4 496
INDIRI4
ASGNI4
line 825
;823:	// JUHOX: register the respawn warn sound (also used for EFH)
;824:#if RESPAWN_DELAY || ESCAPE_MODE
;825:	cgs.media.respawnWarnSound = trap_S_RegisterSound("sound/respawn_warn.wav", qfalse);
ADDRGP4 $647
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 500
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1056
ADDRLP4 500
INDIRI4
ASGNI4
line 827
;826:#endif
;827:	cgs.media.tssBeepSound = trap_S_RegisterSound("sound/tssbeep.wav", qfalse);	// JUHOX
ADDRGP4 $650
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 504
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1060
ADDRLP4 504
INDIRI4
ASGNI4
line 828
;828:	cgs.media.bounceArmorSoundA1 = trap_S_RegisterSound("sound/bounce_armorA1.wav", qfalse);	// JUHOX
ADDRGP4 $653
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 508
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1080
ADDRLP4 508
INDIRI4
ASGNI4
line 829
;829:	cgs.media.bounceArmorSoundA2 = trap_S_RegisterSound("sound/bounce_armorA2.wav", qfalse);	// JUHOX
ADDRGP4 $656
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 512
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1084
ADDRLP4 512
INDIRI4
ASGNI4
line 830
;830:	cgs.media.bounceArmorSoundA3 = trap_S_RegisterSound("sound/bounce_armorA3.wav", qfalse);	// JUHOX
ADDRGP4 $659
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 516
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1088
ADDRLP4 516
INDIRI4
ASGNI4
line 831
;831:	cgs.media.bounceArmorSoundB1 = trap_S_RegisterSound("sound/bounce_armorB1.wav", qfalse);	// JUHOX
ADDRGP4 $662
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 520
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1092
ADDRLP4 520
INDIRI4
ASGNI4
line 832
;832:	cgs.media.bounceArmorSoundB2 = trap_S_RegisterSound("sound/bounce_armorB2.wav", qfalse);	// JUHOX
ADDRGP4 $665
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 524
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1096
ADDRLP4 524
INDIRI4
ASGNI4
line 833
;833:	cgs.media.bounceArmorSoundB3 = trap_S_RegisterSound("sound/bounce_armorB3.wav", qfalse);	// JUHOX
ADDRGP4 $668
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 528
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1100
ADDRLP4 528
INDIRI4
ASGNI4
line 837
;834:
;835:	// JUHOX: register monster sounds
;836:#if MONSTER_MODE
;837:	cgs.media.earthquakeSound = trap_S_RegisterSound("sound/earthquake.wav", qfalse);
ADDRGP4 $671
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 532
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1132
ADDRLP4 532
INDIRI4
ASGNI4
line 838
;838:	if (cgs.gametype == GT_STU) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 8
NEI4 $672
line 839
;839:		cgs.media.lastArtefactSound = trap_S_RegisterSound("sound/last_artefact.wav", qfalse);
ADDRGP4 $677
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 536
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1136
ADDRLP4 536
INDIRI4
ASGNI4
line 840
;840:		cgs.media.detectorBeepSound = trap_S_RegisterSound("sound/detector_beep.wav", qfalse);
ADDRGP4 $680
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 540
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1144
ADDRLP4 540
INDIRI4
ASGNI4
line 841
;841:	}
LABELV $672
line 846
;842:#endif
;843:
;844:	// JUHOX: register pant sounds
;845:#if 1
;846:	cgs.media.malePantSound = trap_S_RegisterSound("sound/player/pantm.wav", qfalse);
ADDRGP4 $683
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 536
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1068
ADDRLP4 536
INDIRI4
ASGNI4
line 847
;847:	cgs.media.femalePantSound = trap_S_RegisterSound("sound/player/pantf.wav", qfalse);
ADDRGP4 $686
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 540
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1072
ADDRLP4 540
INDIRI4
ASGNI4
line 848
;848:	cgs.media.neuterPantSound = trap_S_RegisterSound("sound/player/pantn.wav", qfalse);
ADDRGP4 $689
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 544
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1076
ADDRLP4 544
INDIRI4
ASGNI4
line 852
;849:#endif
;850:
;851:	// only register the items that the server says we need
;852:	strcpy( items, CG_ConfigString( CS_ITEMS ) );
CNSTI4 27
ARGI4
ADDRLP4 548
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 72
ARGP4
ADDRLP4 548
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 854
;853:
;854:	for ( i = 1 ; i < bg_numItems ; i++ ) {
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $693
JUMPV
LABELV $690
line 856
;855://		if ( items[ i ] == '1' || cg_buildScript.integer ) {
;856:			CG_RegisterItemSounds( i );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_RegisterItemSounds
CALLV
pop
line 858
;857://		}
;858:	}
LABELV $691
line 854
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $693
ADDRLP4 0
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $690
line 860
;859:
;860:	for ( i = 1 ; i < MAX_SOUNDS ; i++ ) {
ADDRLP4 0
CNSTI4 1
ASGNI4
LABELV $694
line 861
;861:		soundName = CG_ConfigString( CS_SOUNDS+i );
ADDRLP4 0
INDIRI4
CNSTI4 288
ADDI4
ARGI4
ADDRLP4 552
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 68
ADDRLP4 552
INDIRP4
ASGNP4
line 862
;862:		if ( !soundName[0] ) {
ADDRLP4 68
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $698
line 863
;863:			break;
ADDRGP4 $696
JUMPV
LABELV $698
line 865
;864:		}
;865:		if ( soundName[0] == '*' ) {
ADDRLP4 68
INDIRP4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $700
line 866
;866:			continue;	// custom sound
ADDRGP4 $695
JUMPV
LABELV $700
line 868
;867:		}
;868:		cgs.gameSounds[i] = trap_S_RegisterSound( soundName, qfalse );
ADDRLP4 68
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 556
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+36172
ADDP4
ADDRLP4 556
INDIRI4
ASGNI4
line 869
;869:	}
LABELV $695
line 860
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 256
LTI4 $694
LABELV $696
line 872
;870:
;871:	// FIXME: only needed with item
;872:	cgs.media.flightSound = trap_S_RegisterSound( "sound/items/flight.wav", qfalse );
ADDRGP4 $705
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 552
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1360
ADDRLP4 552
INDIRI4
ASGNI4
line 873
;873:	cgs.media.medkitSound = trap_S_RegisterSound ("sound/items/use_medkit.wav", qfalse);
ADDRGP4 $708
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 556
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1364
ADDRLP4 556
INDIRI4
ASGNI4
line 874
;874:	cgs.media.quadSound = trap_S_RegisterSound("sound/items/damage3.wav", qfalse);
ADDRGP4 $711
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 560
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+832
ADDRLP4 560
INDIRI4
ASGNI4
line 875
;875:	cgs.media.sfx_ric1 = trap_S_RegisterSound ("sound/weapons/machinegun/ric1.wav", qfalse);
ADDRGP4 $714
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 564
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+976
ADDRLP4 564
INDIRI4
ASGNI4
line 876
;876:	cgs.media.sfx_ric2 = trap_S_RegisterSound ("sound/weapons/machinegun/ric2.wav", qfalse);
ADDRGP4 $717
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 568
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+980
ADDRLP4 568
INDIRI4
ASGNI4
line 877
;877:	cgs.media.sfx_ric3 = trap_S_RegisterSound ("sound/weapons/machinegun/ric3.wav", qfalse);
ADDRGP4 $720
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 572
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+984
ADDRLP4 572
INDIRI4
ASGNI4
line 878
;878:	cgs.media.sfx_railg = trap_S_RegisterSound ("sound/weapons/railgun/railgf1a.wav", qfalse);
ADDRGP4 $723
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 576
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+988
ADDRLP4 576
INDIRI4
ASGNI4
line 879
;879:	cgs.media.sfx_rockexp = trap_S_RegisterSound ("sound/weapons/rocket/rocklx1a.wav", qfalse);
ADDRGP4 $726
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 580
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+992
ADDRLP4 580
INDIRI4
ASGNI4
line 880
;880:	cgs.media.sfx_plasmaexp = trap_S_RegisterSound ("sound/weapons/plasma/plasmx1a.wav", qfalse);
ADDRGP4 $729
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 584
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+996
ADDRLP4 584
INDIRI4
ASGNI4
line 902
;881:#ifdef MISSIONPACK
;882:	cgs.media.sfx_proxexp = trap_S_RegisterSound( "sound/weapons/proxmine/wstbexpl.wav" , qfalse);
;883:	cgs.media.sfx_nghit = trap_S_RegisterSound( "sound/weapons/nailgun/wnalimpd.wav" , qfalse);
;884:	cgs.media.sfx_nghitflesh = trap_S_RegisterSound( "sound/weapons/nailgun/wnalimpl.wav" , qfalse);
;885:	cgs.media.sfx_nghitmetal = trap_S_RegisterSound( "sound/weapons/nailgun/wnalimpm.wav", qfalse );
;886:	cgs.media.sfx_chghit = trap_S_RegisterSound( "sound/weapons/vulcan/wvulimpd.wav", qfalse );
;887:	cgs.media.sfx_chghitflesh = trap_S_RegisterSound( "sound/weapons/vulcan/wvulimpl.wav", qfalse );
;888:	cgs.media.sfx_chghitmetal = trap_S_RegisterSound( "sound/weapons/vulcan/wvulimpm.wav", qfalse );
;889:	cgs.media.weaponHoverSound = trap_S_RegisterSound( "sound/weapons/weapon_hover.wav", qfalse );
;890:	cgs.media.kamikazeExplodeSound = trap_S_RegisterSound( "sound/items/kam_explode.wav", qfalse );
;891:	cgs.media.kamikazeImplodeSound = trap_S_RegisterSound( "sound/items/kam_implode.wav", qfalse );
;892:	cgs.media.kamikazeFarSound = trap_S_RegisterSound( "sound/items/kam_explode_far.wav", qfalse );
;893:	cgs.media.winnerSound = trap_S_RegisterSound( "sound/feedback/voc_youwin.wav", qfalse );
;894:	cgs.media.loserSound = trap_S_RegisterSound( "sound/feedback/voc_youlose.wav", qfalse );
;895:	cgs.media.youSuckSound = trap_S_RegisterSound( "sound/misc/yousuck.wav", qfalse );
;896:	cgs.media.wstbimplSound = trap_S_RegisterSound("sound/weapons/proxmine/wstbimpl.wav", qfalse);
;897:	cgs.media.wstbimpmSound = trap_S_RegisterSound("sound/weapons/proxmine/wstbimpm.wav", qfalse);
;898:	cgs.media.wstbimpdSound = trap_S_RegisterSound("sound/weapons/proxmine/wstbimpd.wav", qfalse);
;899:	cgs.media.wstbactvSound = trap_S_RegisterSound("sound/weapons/proxmine/wstbactv.wav", qfalse);
;900:#endif
;901:
;902:	cgs.media.regenSound = trap_S_RegisterSound("sound/items/regen.wav", qfalse);
ADDRGP4 $732
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 588
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1492
ADDRLP4 588
INDIRI4
ASGNI4
line 903
;903:	cgs.media.protectSound = trap_S_RegisterSound("sound/items/protect3.wav", qfalse);
ADDRGP4 $735
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 592
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1496
ADDRLP4 592
INDIRI4
ASGNI4
line 904
;904:	cgs.media.n_healthSound = trap_S_RegisterSound("sound/items/n_health.wav", qfalse );
ADDRGP4 $738
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 596
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1500
ADDRLP4 596
INDIRI4
ASGNI4
line 905
;905:	cgs.media.hgrenb1aSound = trap_S_RegisterSound("sound/weapons/grenade/hgrenb1a.wav", qfalse);
ADDRGP4 $741
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 600
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1504
ADDRLP4 600
INDIRI4
ASGNI4
line 906
;906:	cgs.media.hgrenb2aSound = trap_S_RegisterSound("sound/weapons/grenade/hgrenb2a.wav", qfalse);
ADDRGP4 $744
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 604
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+751220+1508
ADDRLP4 604
INDIRI4
ASGNI4
line 936
;907:
;908:#ifdef MISSIONPACK
;909:	trap_S_RegisterSound("sound/player/james/death1.wav", qfalse );
;910:	trap_S_RegisterSound("sound/player/james/death2.wav", qfalse );
;911:	trap_S_RegisterSound("sound/player/james/death3.wav", qfalse );
;912:	trap_S_RegisterSound("sound/player/james/jump1.wav", qfalse );
;913:	trap_S_RegisterSound("sound/player/james/pain25_1.wav", qfalse );
;914:	trap_S_RegisterSound("sound/player/james/pain75_1.wav", qfalse );
;915:	trap_S_RegisterSound("sound/player/james/pain100_1.wav", qfalse );
;916:	trap_S_RegisterSound("sound/player/james/falling1.wav", qfalse );
;917:	trap_S_RegisterSound("sound/player/james/gasp.wav", qfalse );
;918:	trap_S_RegisterSound("sound/player/james/drown.wav", qfalse );
;919:	trap_S_RegisterSound("sound/player/james/fall1.wav", qfalse );
;920:	trap_S_RegisterSound("sound/player/james/taunt.wav", qfalse );
;921:
;922:	trap_S_RegisterSound("sound/player/janet/death1.wav", qfalse );
;923:	trap_S_RegisterSound("sound/player/janet/death2.wav", qfalse );
;924:	trap_S_RegisterSound("sound/player/janet/death3.wav", qfalse );
;925:	trap_S_RegisterSound("sound/player/janet/jump1.wav", qfalse );
;926:	trap_S_RegisterSound("sound/player/janet/pain25_1.wav", qfalse );
;927:	trap_S_RegisterSound("sound/player/janet/pain75_1.wav", qfalse );
;928:	trap_S_RegisterSound("sound/player/janet/pain100_1.wav", qfalse );
;929:	trap_S_RegisterSound("sound/player/janet/falling1.wav", qfalse );
;930:	trap_S_RegisterSound("sound/player/janet/gasp.wav", qfalse );
;931:	trap_S_RegisterSound("sound/player/janet/drown.wav", qfalse );
;932:	trap_S_RegisterSound("sound/player/janet/fall1.wav", qfalse );
;933:	trap_S_RegisterSound("sound/player/janet/taunt.wav", qfalse );
;934:#endif
;935:
;936:}
LABELV $413
endproc CG_RegisterSounds 608 16
export CG_LFEntOrigin
proc CG_LFEntOrigin 12 0
line 948
;937:
;938:
;939://===================================================================================
;940:
;941:
;942:/*
;943:=====================
;944:JUHOX: CG_LFEntOrigin
;945:=====================
;946:*/
;947:#if MAPLENSFLARES
;948:void CG_LFEntOrigin(const lensFlareEntity_t* lfent, vec3_t origin) {
line 949
;949:	VectorCopy(lfent->origin, origin);
ADDRFP4 4
INDIRP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 950
;950:	if (lfent->lock) {
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $746
line 951
;951:		VectorAdd(origin, lfent->lock->lerpOrigin, origin);
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRP4
CNSTI4 728
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRP4
CNSTI4 732
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 8
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRP4
CNSTI4 736
ADDP4
INDIRF4
ADDF4
ASGNF4
line 952
;952:	}
LABELV $746
line 953
;953:}
LABELV $745
endproc CG_LFEntOrigin 12 0
export CG_SetLFEntOrigin
proc CG_SetLFEntOrigin 12 0
line 962
;954:#endif
;955:
;956:/*
;957:=====================
;958:JUHOX: CG_SetLFEntOrigin
;959:=====================
;960:*/
;961:#if MAPLENSFLARES
;962:void CG_SetLFEntOrigin(lensFlareEntity_t* lfent, const vec3_t origin) {
line 963
;963:	if (lfent->lock) {
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $749
line 964
;964:		VectorSubtract(origin, lfent->lock->lerpOrigin, lfent->origin);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRFP4 4
INDIRP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRP4
CNSTI4 728
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRP4
CNSTI4 732
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRP4
CNSTI4 736
ADDP4
INDIRF4
SUBF4
ASGNF4
line 965
;965:	}
ADDRGP4 $750
JUMPV
LABELV $749
line 966
;966:	else {
line 967
;967:		VectorCopy(origin, lfent->origin);
ADDRFP4 0
INDIRP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 968
;968:	}
LABELV $750
line 969
;969:}
LABELV $748
endproc CG_SetLFEntOrigin 12 0
export CG_SetLFEdMoveMode
proc CG_SetLFEdMoveMode 32 20
line 978
;970:#endif
;971:
;972:/*
;973:=================
;974:JUHOX: CG_SetLFEdMoveMode
;975:=================
;976:*/
;977:#if MAPLENSFLARES
;978:void CG_SetLFEdMoveMode(lfeMoveMode_t mode) {
line 981
;979:	vec3_t origin;
;980:
;981:	if (cg.lfEditor.moveMode == mode) return;
ADDRGP4 cg+109660+12
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $752
ADDRGP4 $751
JUMPV
LABELV $752
line 983
;982:
;983:	switch (mode) {
ADDRLP4 12
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $759
ADDRLP4 12
INDIRI4
CNSTI4 1
EQI4 $783
ADDRGP4 $756
JUMPV
LABELV $759
line 985
;984:	case LFEMM_coarse:
;985:		VectorCopy(cg.snap->ps.origin, origin);
ADDRLP4 0
ADDRGP4 cg+36
INDIRP4
CNSTI4 64
ADDP4
INDIRB
ASGNB 12
line 987
;986:		if (
;987:			cg.lfEditor.moveMode == LFEMM_fine &&
ADDRGP4 cg+109660+12
INDIRI4
CNSTI4 1
NEI4 $761
ADDRGP4 cg+109660
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $761
line 989
;988:			cg.lfEditor.selectedLFEnt
;989:		) {
line 992
;990:			vec3_t dir;
;991:
;992:			AngleVectors(cg.snap->ps.viewangles, dir, NULL, NULL);
ADDRGP4 cg+36
INDIRP4
CNSTI4 196
ADDP4
ARGP4
ADDRLP4 20
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 993
;993:			CG_LFEntOrigin(cg.lfEditor.selectedLFEnt, origin);
ADDRGP4 cg+109660
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_LFEntOrigin
CALLV
pop
line 994
;994:			VectorMA(origin, -cg.lfEditor.fmm_distance, dir, origin);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 20
INDIRF4
ADDRGP4 cg+109660+20
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 20+4
INDIRF4
ADDRGP4 cg+109660+20
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 20+8
INDIRF4
ADDRGP4 cg+109660+20
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 995
;995:		}
LABELV $761
line 996
;996:		trap_SendClientCommand(va("lfemm %d %f %f %f", mode, origin[0], origin[1], origin[2]));
ADDRGP4 $780
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 997
;997:		break;
ADDRGP4 $757
JUMPV
LABELV $783
line 999
;998:	case LFEMM_fine:
;999:		CG_LFEntOrigin(cg.lfEditor.selectedLFEnt, origin);
ADDRGP4 cg+109660
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_LFEntOrigin
CALLV
pop
line 1000
;1000:		VectorSubtract(origin, cg.refdef.vieworg, cg.lfEditor.fmm_offset);
ADDRGP4 cg+109660+24
ADDRLP4 0
INDIRF4
ADDRGP4 cg+109260+24
INDIRF4
SUBF4
ASGNF4
ADDRGP4 cg+109660+24+4
ADDRLP4 0+4
INDIRF4
ADDRGP4 cg+109260+24+4
INDIRF4
SUBF4
ASGNF4
ADDRGP4 cg+109660+24+8
ADDRLP4 0+8
INDIRF4
ADDRGP4 cg+109260+24+8
INDIRF4
SUBF4
ASGNF4
line 1001
;1001:		cg.lfEditor.fmm_distance = VectorLength(cg.lfEditor.fmm_offset);
ADDRGP4 cg+109660+24
ARGP4
ADDRLP4 24
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRGP4 cg+109660+20
ADDRLP4 24
INDIRF4
ASGNF4
line 1002
;1002:		trap_SendClientCommand(va("lfemm %d", mode));
ADDRGP4 $807
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 1003
;1003:		break;
LABELV $756
LABELV $757
line 1006
;1004:	}
;1005:
;1006:	cg.lfEditor.moveMode = mode;
ADDRGP4 cg+109660+12
ADDRFP4 0
INDIRI4
ASGNI4
line 1007
;1007:}
LABELV $751
endproc CG_SetLFEdMoveMode 32 20
export CG_SelectLFEnt
proc CG_SelectLFEnt 8 4
line 1016
;1008:#endif
;1009:
;1010:/*
;1011:=================
;1012:JUHOX: CG_SelectLFEnt
;1013:=================
;1014:*/
;1015:#if MAPLENSFLARES
;1016:void CG_SelectLFEnt(int lfentnum) {
line 1019
;1017:	lensFlareEntity_t* lfent;
;1018:
;1019:	if (lfentnum < 0 || lfentnum >= cgs.numLensFlareEntities) return;
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $814
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+562612
INDIRI4
LTI4 $811
LABELV $814
ADDRGP4 $810
JUMPV
LABELV $811
line 1021
;1020:
;1021:	CG_SetLFEdMoveMode(LFEMM_coarse);
CNSTI4 0
ARGI4
ADDRGP4 CG_SetLFEdMoveMode
CALLV
pop
line 1022
;1022:	lfent = &cgs.lensFlareEntities[lfentnum];
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 184
MULI4
ADDRGP4 cgs+562800
ADDP4
ASGNP4
line 1023
;1023:	cg.lfEditor.selectedLFEnt = lfent;
ADDRGP4 cg+109660
ADDRLP4 0
INDIRP4
ASGNP4
line 1024
;1024:	cg.lfEditor.markedLFEnt = -1;
ADDRGP4 cg+109660+44
CNSTI4 -1
ASGNI4
line 1025
;1025:	cg.lfEditor.editMode = LFEEM_none;
ADDRGP4 cg+109660+8
CNSTI4 0
ASGNI4
line 1026
;1026:	cg.lfEditor.originalLFEnt = *lfent;
ADDRGP4 cg+109660+48
ADDRLP4 0
INDIRP4
INDIRB
ASGNB 184
line 1027
;1027:}
LABELV $810
endproc CG_SelectLFEnt 8 4
proc CG_InitFileStack 0 0
line 1052
;1028:#endif
;1029:
;1030:#if MAPLENSFLARES	// JUHOX: definitions needed for parsing the lens flare files
;1031:#define FILESTACK_NAMESIZE 128
;1032:typedef struct {
;1033:	char path[FILESTACK_NAMESIZE];
;1034:	char name[FILESTACK_NAMESIZE];
;1035:} lfFileData_t;
;1036:
;1037:#define FILESTACK_SIZE 128
;1038:static int numFilesOnStack;
;1039:static lfFileData_t fileStack[FILESTACK_SIZE];
;1040:
;1041:static char lfNameBase[128];
;1042:
;1043:static char lfbuf[65536];
;1044:#endif
;1045:
;1046:/*
;1047:=================
;1048:JUHOX: CG_InitFileStack
;1049:=================
;1050:*/
;1051:#if MAPLENSFLARES
;1052:static void CG_InitFileStack(void) {
line 1056
;1053:#if LFDEBUG
;1054:	CG_LoadingString("LF: CG_InitFileStack()");
;1055:#endif
;1056:	numFilesOnStack = 0;
ADDRGP4 numFilesOnStack
CNSTI4 0
ASGNI4
line 1057
;1057:	lfbuf[0] = 0;
ADDRGP4 lfbuf
CNSTI1 0
ASGNI1
line 1058
;1058:}
LABELV $824
endproc CG_InitFileStack 0 0
proc CG_PushFile 4 12
line 1067
;1059:#endif
;1060:
;1061:/*
;1062:=================
;1063:JUHOX: CG_PushFile
;1064:=================
;1065:*/
;1066:#if MAPLENSFLARES
;1067:static void CG_PushFile(const char* path, const char* name) {
line 1071
;1068:#if LFDEBUG
;1069:	CG_LoadingString(va("LF: CG_PushFile(%s)", name));
;1070:#endif
;1071:	if (numFilesOnStack >= FILESTACK_SIZE) return;
ADDRGP4 numFilesOnStack
INDIRI4
CNSTI4 128
LTI4 $826
ADDRGP4 $825
JUMPV
LABELV $826
line 1073
;1072:
;1073:	Q_strncpyz(fileStack[numFilesOnStack].path, path, FILESTACK_NAMESIZE);
ADDRGP4 numFilesOnStack
INDIRI4
CNSTI4 8
LSHI4
ADDRGP4 fileStack
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1074
;1074:	Q_strncpyz(fileStack[numFilesOnStack].name, name, FILESTACK_NAMESIZE);
ADDRGP4 numFilesOnStack
INDIRI4
CNSTI4 8
LSHI4
ADDRGP4 fileStack+128
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1075
;1075:	numFilesOnStack++;
ADDRLP4 0
ADDRGP4 numFilesOnStack
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1076
;1076:}
LABELV $825
endproc CG_PushFile 4 12
proc CG_PopFile 280 20
line 1085
;1077:#endif
;1078:
;1079:/*
;1080:=================
;1081:JUHOX: CG_PopFile
;1082:=================
;1083:*/
;1084:#if MAPLENSFLARES
;1085:static qboolean CG_PopFile(void) {
LABELV $830
line 1094
;1086:	char name[256];
;1087:	fileHandle_t file;
;1088:	int len;
;1089:
;1090:#if LFDEBUG
;1091:	CG_LoadingString("LF: CG_PopFile()");
;1092:#endif
;1093:	PopFile:
;1094:	if (numFilesOnStack <= 0) return qfalse;
ADDRGP4 numFilesOnStack
INDIRI4
CNSTI4 0
GTI4 $831
CNSTI4 0
RETI4
ADDRGP4 $829
JUMPV
LABELV $831
line 1096
;1095:
;1096:	numFilesOnStack--;
ADDRLP4 264
ADDRGP4 numFilesOnStack
ASGNP4
ADDRLP4 264
INDIRP4
ADDRLP4 264
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1097
;1097:	Q_strncpyz(lfNameBase, fileStack[numFilesOnStack].name, sizeof(lfNameBase)-1);
ADDRGP4 lfNameBase
ARGP4
ADDRGP4 numFilesOnStack
INDIRI4
CNSTI4 8
LSHI4
ADDRGP4 fileStack+128
ADDP4
ARGP4
CNSTI4 127
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1098
;1098:	Com_sprintf(name, sizeof(name), "%s%s", fileStack[numFilesOnStack].path, lfNameBase);
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $834
ARGP4
ADDRGP4 numFilesOnStack
INDIRI4
CNSTI4 8
LSHI4
ADDRGP4 fileStack
ADDP4
ARGP4
ADDRGP4 lfNameBase
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1099
;1099:	COM_StripExtension(lfNameBase, lfNameBase);
ADDRLP4 268
ADDRGP4 lfNameBase
ASGNP4
ADDRLP4 268
INDIRP4
ARGP4
ADDRLP4 268
INDIRP4
ARGP4
ADDRGP4 COM_StripExtension
CALLV
pop
line 1100
;1100:	len = strlen(lfNameBase);
ADDRGP4 lfNameBase
ARGP4
ADDRLP4 272
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 272
INDIRI4
ASGNI4
line 1101
;1101:	lfNameBase[len] = '/';
ADDRLP4 0
INDIRI4
ADDRGP4 lfNameBase
ADDP4
CNSTI1 47
ASGNI1
line 1102
;1102:	lfNameBase[len+1] = 0;
ADDRLP4 0
INDIRI4
ADDRGP4 lfNameBase+1
ADDP4
CNSTI1 0
ASGNI1
line 1104
;1103:
;1104:	len = trap_FS_FOpenFile(name, &file, FS_READ);
ADDRLP4 4
ARGP4
ADDRLP4 260
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 276
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 276
INDIRI4
ASGNI4
line 1105
;1105:	if (!file) {
ADDRLP4 260
INDIRI4
CNSTI4 0
NEI4 $836
line 1106
;1106:		CG_Printf(S_COLOR_YELLOW "'%s' not found\n", name);
ADDRGP4 $838
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1110
;1107:#if LFDEBUG
;1108:		CG_LoadingString(va("LF: CG_PopFile(%s) failed", name));
;1109:#endif
;1110:		goto PopFile;
ADDRGP4 $830
JUMPV
LABELV $836
line 1112
;1111:	}
;1112:	if (len >= sizeof(lfbuf)) {
ADDRLP4 0
INDIRI4
CVIU4 4
CNSTU4 65536
LTU4 $839
line 1113
;1113:		CG_Printf(S_COLOR_YELLOW "file too large: '%s' > %d\n", name, sizeof(lfbuf)-1);
ADDRGP4 $841
ARGP4
ADDRLP4 4
ARGP4
CNSTU4 65535
ARGU4
ADDRGP4 CG_Printf
CALLV
pop
line 1117
;1114:#if LFDEBUG
;1115:		CG_LoadingString(va("LF: CG_PopFile(%s): file too large", name));
;1116:#endif
;1117:		goto PopFile;
ADDRGP4 $830
JUMPV
LABELV $839
line 1119
;1118:	}
;1119:	CG_Printf("reading '%s'...\n", name);
ADDRGP4 $842
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1124
;1120:#if LFDEBUG
;1121:	CG_LoadingString(va("%s", name));
;1122:#endif
;1123:
;1124:	trap_FS_Read(lfbuf, len, file);
ADDRGP4 lfbuf
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 1125
;1125:	lfbuf[len] = 0;
ADDRLP4 0
INDIRI4
ADDRGP4 lfbuf
ADDP4
CNSTI1 0
ASGNI1
line 1126
;1126:	trap_FS_FCloseFile(file);
ADDRLP4 260
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 1127
;1127:	return qtrue;
CNSTI4 1
RETI4
LABELV $829
endproc CG_PopFile 280 20
proc CG_ParseLensFlare 76 12
line 1137
;1128:}
;1129:#endif
;1130:
;1131:/*
;1132:=================
;1133:JUHOX: CG_ParseLensFlare
;1134:=================
;1135:*/
;1136:#if MAPLENSFLARES
;1137:static qboolean CG_ParseLensFlare(char** p, lensFlare_t* lf, const char* lfename) {
line 1144
;1138:	char* token;
;1139:
;1140:#if LFDEBUG
;1141:	CG_LoadingString(va("LF: CG_ParseLensFlare(%s)", lfename));
;1142:#endif
;1143:	// set non-zero default values
;1144:	lf->pos = 1.0;
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 1065353216
ASGNF4
line 1145
;1145:	lf->size = 1.0;
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
CNSTF4 1065353216
ASGNF4
line 1146
;1146:	lf->rgba[0] = 0xff;
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
CNSTF4 1132396544
ASGNF4
line 1147
;1147:	lf->rgba[1] = 0xff;
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 1132396544
ASGNF4
line 1148
;1148:	lf->rgba[2] = 0xff;
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 1132396544
ASGNF4
line 1149
;1149:	lf->rgba[3] = 0xff;
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 1132396544
ASGNF4
line 1150
;1150:	lf->fadeAngleFactor = 1.0;
ADDRFP4 4
INDIRP4
CNSTI4 48
ADDP4
CNSTF4 1065353216
ASGNF4
line 1151
;1151:	lf->entityAngleFactor = 1.0;
ADDRFP4 4
INDIRP4
CNSTI4 52
ADDP4
CNSTF4 1065353216
ASGNF4
line 1152
;1152:	lf->rotationRollFactor = 1.0;
ADDRFP4 4
INDIRP4
CNSTI4 44
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRGP4 $845
JUMPV
LABELV $844
line 1154
;1153:
;1154:	while (1) {
line 1155
;1155:		token = COM_Parse(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 1156
;1156:		if (!token[0]) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $847
line 1157
;1157:			CG_Printf(S_COLOR_YELLOW "unexpected end of lens flare definition in '%s'\n", lfename);
ADDRGP4 $849
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1161
;1158:#if LFDEBUG
;1159:			CG_LoadingString(va("LF: CG_ParseLensFlare(%s) unexpected end", lfename));
;1160:#endif
;1161:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $843
JUMPV
LABELV $847
line 1164
;1162:		}
;1163:
;1164:		if (!Q_stricmp(token, "}")) break;
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $852
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $850
ADDRGP4 $846
JUMPV
LABELV $850
line 1166
;1165:
;1166:		if (!Q_stricmp(token, "shader")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $855
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $853
line 1167
;1167:			token = COM_Parse(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 1168
;1168:			if (token[0]) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $854
line 1169
;1169:				lf->shader = trap_R_RegisterShaderNoMip(token);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 20
INDIRI4
ASGNI4
line 1170
;1170:			}
line 1171
;1171:		}
ADDRGP4 $854
JUMPV
LABELV $853
line 1172
;1172:		else if (!Q_stricmp(token, "mode")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $860
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $858
line 1173
;1173:			token = COM_Parse(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 1174
;1174:			if (!Q_stricmp(token, "reflexion")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $863
ARGP4
ADDRLP4 24
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $861
line 1175
;1175:				lf->mode = LFM_reflexion;
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 0
ASGNI4
line 1176
;1176:			}
ADDRGP4 $859
JUMPV
LABELV $861
line 1177
;1177:			else if (!Q_stricmp(token, "glare")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $866
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $864
line 1178
;1178:				lf->mode = LFM_glare;
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 1
ASGNI4
line 1179
;1179:			}
ADDRGP4 $859
JUMPV
LABELV $864
line 1180
;1180:			else if (!Q_stricmp(token, "star")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $869
ARGP4
ADDRLP4 32
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $867
line 1181
;1181:				lf->mode = LFM_star;
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 2
ASGNI4
line 1182
;1182:			}
ADDRGP4 $859
JUMPV
LABELV $867
line 1183
;1183:			else {
line 1184
;1184:				CG_Printf(S_COLOR_YELLOW "unknown mode '%s' in '%s'\n", token, lfename);
ADDRGP4 $870
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1185
;1185:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $843
JUMPV
line 1187
;1186:			}
;1187:		}
LABELV $858
line 1188
;1188:		else if (!Q_stricmp(token, "pos")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $873
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $871
line 1189
;1189:			token = COM_Parse(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 24
INDIRP4
ASGNP4
line 1190
;1190:			lf->pos = atof(token);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 atof
CALLF4
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 28
INDIRF4
ASGNF4
line 1191
;1191:		}
ADDRGP4 $872
JUMPV
LABELV $871
line 1192
;1192:		else if (!Q_stricmp(token, "size")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $876
ARGP4
ADDRLP4 24
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $874
line 1193
;1193:			token = COM_Parse(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ASGNP4
line 1194
;1194:			lf->size = atof(token);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 atof
CALLF4
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 32
INDIRF4
ASGNF4
line 1195
;1195:		}
ADDRGP4 $875
JUMPV
LABELV $874
line 1196
;1196:		else if (!Q_stricmp(token, "color")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $315
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $877
line 1197
;1197:			token = COM_Parse(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 32
INDIRP4
ASGNP4
line 1198
;1198:			lf->rgba[0] = 0xff * Com_Clamp(0, 1, atof(token));
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 atof
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 40
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 40
INDIRF4
CNSTF4 1132396544
MULF4
ASGNF4
line 1200
;1199:
;1200:			token = COM_Parse(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 44
INDIRP4
ASGNP4
line 1201
;1201:			lf->rgba[1] = 0xff * Com_Clamp(0, 1, atof(token));
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 atof
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 52
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 52
INDIRF4
CNSTF4 1132396544
MULF4
ASGNF4
line 1203
;1202:
;1203:			token = COM_Parse(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 56
INDIRP4
ASGNP4
line 1204
;1204:			lf->rgba[2] = 0xff * Com_Clamp(0, 1, atof(token));
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 atof
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 64
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 64
INDIRF4
CNSTF4 1132396544
MULF4
ASGNF4
line 1205
;1205:		}
ADDRGP4 $878
JUMPV
LABELV $877
line 1206
;1206:		else if (!Q_stricmp(token, "alpha")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $881
ARGP4
ADDRLP4 32
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $879
line 1207
;1207:			token = COM_Parse(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 36
INDIRP4
ASGNP4
line 1208
;1208:			lf->rgba[3] = 0xff * Com_Clamp(0, 1000, atof(token));
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 atof
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1148846080
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 44
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 44
INDIRF4
CNSTF4 1132396544
MULF4
ASGNF4
line 1209
;1209:		}
ADDRGP4 $880
JUMPV
LABELV $879
line 1210
;1210:		else if (!Q_stricmp(token, "rotation")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $884
ARGP4
ADDRLP4 36
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $882
line 1211
;1211:			token = COM_Parse(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 40
INDIRP4
ASGNP4
line 1212
;1212:			lf->rotationOffset = Com_Clamp(-360, 360, atof(token));
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 atof
CALLF4
ASGNF4
CNSTF4 3283353600
ARGF4
CNSTF4 1135869952
ARGF4
ADDRLP4 44
INDIRF4
ARGF4
ADDRLP4 48
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 48
INDIRF4
ASGNF4
line 1214
;1213:
;1214:			token = COM_Parse(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 52
INDIRP4
ASGNP4
line 1215
;1215:			lf->rotationYawFactor = atof(token);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 atof
CALLF4
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 56
INDIRF4
ASGNF4
line 1217
;1216:
;1217:			token = COM_Parse(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 60
INDIRP4
ASGNP4
line 1218
;1218:			lf->rotationPitchFactor = atof(token);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 atof
CALLF4
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 64
INDIRF4
ASGNF4
line 1220
;1219:
;1220:			token = COM_Parse(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 68
INDIRP4
ASGNP4
line 1221
;1221:			lf->rotationRollFactor = atof(token);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 72
ADDRGP4 atof
CALLF4
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 72
INDIRF4
ASGNF4
line 1222
;1222:		}
ADDRGP4 $883
JUMPV
LABELV $882
line 1223
;1223:		else if (!Q_stricmp(token, "fadeAngleFactor")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $887
ARGP4
ADDRLP4 40
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $885
line 1224
;1224:			token = COM_Parse(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 44
INDIRP4
ASGNP4
line 1225
;1225:			lf->fadeAngleFactor = atof(token);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 atof
CALLF4
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 48
ADDP4
ADDRLP4 48
INDIRF4
ASGNF4
line 1226
;1226:			if (lf->fadeAngleFactor < 0) lf->fadeAngleFactor = 0;
ADDRFP4 4
INDIRP4
CNSTI4 48
ADDP4
INDIRF4
CNSTF4 0
GEF4 $886
ADDRFP4 4
INDIRP4
CNSTI4 48
ADDP4
CNSTF4 0
ASGNF4
line 1227
;1227:		}
ADDRGP4 $886
JUMPV
LABELV $885
line 1228
;1228:		else if (!Q_stricmp(token, "entityAngleFactor")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $892
ARGP4
ADDRLP4 44
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $890
line 1229
;1229:			token = COM_Parse(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 48
INDIRP4
ASGNP4
line 1230
;1230:			lf->entityAngleFactor = atof(token);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 atof
CALLF4
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 52
ADDP4
ADDRLP4 52
INDIRF4
ASGNF4
line 1231
;1231:			if (lf->entityAngleFactor < 0) lf->entityAngleFactor = 0;
ADDRFP4 4
INDIRP4
CNSTI4 52
ADDP4
INDIRF4
CNSTF4 0
GEF4 $891
ADDRFP4 4
INDIRP4
CNSTI4 52
ADDP4
CNSTF4 0
ASGNF4
line 1232
;1232:		}
ADDRGP4 $891
JUMPV
LABELV $890
line 1233
;1233:		else if (!Q_stricmp(token, "intensityThreshold")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $897
ARGP4
ADDRLP4 48
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
NEI4 $895
line 1234
;1234:			token = COM_Parse(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 52
INDIRP4
ASGNP4
line 1235
;1235:			lf->intensityThreshold = Com_Clamp(0, 0.99, atof(token));
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 atof
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065185444
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 60
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 56
ADDP4
ADDRLP4 60
INDIRF4
ASGNF4
line 1236
;1236:		}
ADDRGP4 $896
JUMPV
LABELV $895
line 1237
;1237:		else {
line 1238
;1238:			CG_Printf(S_COLOR_YELLOW "unexpected token '%s' in '%s'\n", token, lfename);
ADDRGP4 $898
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1239
;1239:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $843
JUMPV
LABELV $896
LABELV $891
LABELV $886
LABELV $883
LABELV $880
LABELV $878
LABELV $875
LABELV $872
LABELV $859
LABELV $854
line 1241
;1240:		}
;1241:	}
LABELV $845
line 1154
ADDRGP4 $844
JUMPV
LABELV $846
line 1242
;1242:	return qtrue;
CNSTI4 1
RETI4
LABELV $843
endproc CG_ParseLensFlare 76 12
proc CG_FindLensFlareEffect 8 8
line 1252
;1243:}
;1244:#endif
;1245:
;1246:/*
;1247:=================
;1248:JUHOX: CG_FindLensFlareEffect
;1249:=================
;1250:*/
;1251:#if MAPLENSFLARES
;1252:static const lensFlareEffect_t* CG_FindLensFlareEffect(const char* name) {
line 1258
;1253:	int i;
;1254:
;1255:#if LFDEBUG
;1256:	CG_LoadingString(va("LF: CG_FindLensFlareEffect(%s)", name));
;1257:#endif
;1258:	for (i = 0; i < cgs.numLensFlareEffects; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $903
JUMPV
LABELV $900
line 1259
;1259:		if (!Q_stricmp(name, cgs.lensFlareEffects[i].name)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2000
MULI4
ADDRGP4 cgs+162612
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $905
line 1260
;1260:			return &cgs.lensFlareEffects[i];
ADDRLP4 0
INDIRI4
CNSTI4 2000
MULI4
ADDRGP4 cgs+162612
ADDP4
RETP4
ADDRGP4 $899
JUMPV
LABELV $905
line 1262
;1261:		}
;1262:	}
LABELV $901
line 1258
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $903
ADDRLP4 0
INDIRI4
ADDRGP4 cgs+162608
INDIRI4
LTI4 $900
line 1263
;1263:	return NULL;
CNSTP4 0
RETP4
LABELV $899
endproc CG_FindLensFlareEffect 8 8
proc CG_FinalizeLensFlareEffect 12 0
line 1273
;1264:}
;1265:#endif
;1266:
;1267:/*
;1268:=================
;1269:JUHOX: CG_FinalizeLensFlareEffect
;1270:=================
;1271:*/
;1272:#if MAPLENSFLARES
;1273:static void CG_FinalizeLensFlareEffect(lensFlareEffect_t* lfeff) {
line 1279
;1274:	int i;
;1275:
;1276:#if LFDEBUG
;1277:	CG_LoadingString("LF: CG_FinalizeLensFlareEffect()");
;1278:#endif
;1279:	if (lfeff->range >= 0) return;
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
CNSTF4 0
LTF4 $910
ADDRGP4 $909
JUMPV
LABELV $910
line 1281
;1280:
;1281:	for (i = 0; i < lfeff->numLensFlares; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $915
JUMPV
LABELV $912
line 1284
;1282:		lensFlare_t* lf;
;1283:
;1284:		lf = &lfeff->lensFlares[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 60
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 80
ADDP4
ADDP4
ASGNP4
line 1286
;1285:
;1286:		lf->intensityThreshold = 1 / (1 - lf->intensityThreshold) - 1;
ADDRLP4 4
INDIRP4
CNSTI4 56
ADDP4
CNSTF4 1065353216
CNSTF4 1065353216
ADDRLP4 4
INDIRP4
CNSTI4 56
ADDP4
INDIRF4
SUBF4
DIVF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 1287
;1287:	}
LABELV $913
line 1281
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $915
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
LTI4 $912
line 1288
;1288:}
LABELV $909
endproc CG_FinalizeLensFlareEffect 12 0
proc CG_ParseLensFlareEffect 68 12
line 1297
;1289:#endif
;1290:
;1291:/*
;1292:=================
;1293:JUHOX: CG_ParseLensFlareEffect
;1294:=================
;1295:*/
;1296:#if MAPLENSFLARES
;1297:static qboolean CG_ParseLensFlareEffect(char** p, lensFlareEffect_t* lfe) {
LABELV $917
line 1305
;1298:	char* token;
;1299:	char* name;
;1300:
;1301:#if LFDEBUG
;1302:	CG_LoadingString("LF: CG_ParseLensFlareEffect()");
;1303:#endif
;1304:	ParseEffect:
;1305:	token = COM_Parse(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 1306
;1306:	if (!token[0]) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $918
line 1307
;1307:		if (CG_PopFile()) {
ADDRLP4 12
ADDRGP4 CG_PopFile
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $920
line 1308
;1308:			*p = lfbuf;
ADDRFP4 0
INDIRP4
ADDRGP4 lfbuf
ASGNP4
line 1309
;1309:			goto ParseEffect;
ADDRGP4 $917
JUMPV
LABELV $920
line 1311
;1310:		}
;1311:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $916
JUMPV
LABELV $918
line 1314
;1312:	}
;1313:
;1314:	if (!Q_stricmp(token, "import")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $924
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $922
line 1315
;1315:		CG_PushFile("flares/import/", COM_Parse(p));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRGP4 $925
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 CG_PushFile
CALLV
pop
line 1316
;1316:		goto ParseEffect;
ADDRGP4 $917
JUMPV
LABELV $922
line 1319
;1317:	}
;1318:
;1319:	if (!Q_stricmp(token, "sunparm")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $928
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $926
line 1320
;1320:		token = COM_Parse(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 1321
;1321:		Q_strncpyz(cgs.sunFlareEffect, token, sizeof(cgs.sunFlareEffect));
ADDRGP4 cgs+31688
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1323
;1322:
;1323:		token = COM_Parse(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 24
INDIRP4
ASGNP4
line 1324
;1324:		cgs.sunFlareYaw = atof(token);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 atof
CALLF4
ASGNF4
ADDRGP4 cgs+31816
ADDRLP4 28
INDIRF4
ASGNF4
line 1326
;1325:
;1326:		token = COM_Parse(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 32
INDIRP4
ASGNP4
line 1327
;1327:		cgs.sunFlarePitch = atof(token);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 atof
CALLF4
ASGNF4
ADDRGP4 cgs+31820
ADDRLP4 36
INDIRF4
ASGNF4
line 1329
;1328:
;1329:		token = COM_Parse(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 40
INDIRP4
ASGNP4
line 1330
;1330:		cgs.sunFlareDistance = atof(token);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 atof
CALLF4
ASGNF4
ADDRGP4 cgs+31824
ADDRLP4 44
INDIRF4
ASGNF4
line 1331
;1331:		goto ParseEffect;
ADDRGP4 $917
JUMPV
LABELV $926
line 1334
;1332:	}
;1333:
;1334:	name = va("%s%s", lfNameBase, token);
ADDRGP4 $834
ARGP4
ADDRGP4 lfNameBase
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 20
INDIRP4
ASGNP4
line 1335
;1335:	if (CG_FindLensFlareEffect(name)) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 CG_FindLensFlareEffect
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $934
line 1336
;1336:		SkipBracedSection(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 SkipBracedSection
CALLV
pop
line 1337
;1337:		goto ParseEffect;
ADDRGP4 $917
JUMPV
LABELV $934
line 1340
;1338:	}
;1339:
;1340:	Q_strncpyz(lfe->name, name, sizeof(lfe->name));
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1342
;1341:
;1342:	token = COM_Parse(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ASGNP4
line 1343
;1343:	if (Q_stricmp(token, "{")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $938
ARGP4
ADDRLP4 32
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $936
line 1344
;1344:		CG_Printf(S_COLOR_YELLOW "read '%s', expected '{' in '%s'\n", token, lfe->name);
ADDRGP4 $939
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1345
;1345:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $916
JUMPV
LABELV $936
line 1349
;1346:	}
;1347:
;1348:	// set non-zero default values
;1349:	lfe->range = 400;
ADDRFP4 4
INDIRP4
CNSTI4 64
ADDP4
CNSTF4 1137180672
ASGNF4
line 1350
;1350:	lfe->fadeAngle = 20;
ADDRFP4 4
INDIRP4
CNSTI4 72
ADDP4
CNSTF4 1101004800
ASGNF4
ADDRGP4 $941
JUMPV
LABELV $940
line 1352
;1351:
;1352:	while (1) {
line 1353
;1353:		token = COM_Parse(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 36
INDIRP4
ASGNP4
line 1354
;1354:		if (!token[0]) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $943
line 1355
;1355:			CG_Printf(S_COLOR_YELLOW "unexpected end of lens flare effect '%s'\n", lfe->name);
ADDRGP4 $945
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1356
;1356:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $916
JUMPV
LABELV $943
line 1359
;1357:		}
;1358:
;1359:		if (!Q_stricmp(token, "}")) break;
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $852
ARGP4
ADDRLP4 40
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $946
ADDRGP4 $942
JUMPV
LABELV $946
line 1361
;1360:
;1361:		if (!Q_stricmp(token, "{")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $938
ARGP4
ADDRLP4 44
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $948
line 1362
;1362:			if (lfe->numLensFlares >= MAX_LENSFLARES_PER_EFFECT) {
ADDRFP4 4
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 32
LTI4 $950
line 1363
;1363:				CG_Printf(S_COLOR_YELLOW "too many lensflares in '%s' (max=%d)\n", lfe->name, MAX_LENSFLARES_PER_EFFECT);
ADDRGP4 $952
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 1364
;1364:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $916
JUMPV
LABELV $950
line 1367
;1365:			}
;1366:
;1367:			if (!CG_ParseLensFlare(p, &lfe->lensFlares[lfe->numLensFlares], lfe->name)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 48
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 60
MULI4
ADDRLP4 48
INDIRP4
CNSTI4 80
ADDP4
ADDP4
ARGP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 CG_ParseLensFlare
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $953
CNSTI4 0
RETI4
ADDRGP4 $916
JUMPV
LABELV $953
line 1368
;1368:			lfe->numLensFlares++;
ADDRLP4 56
ADDRFP4 4
INDIRP4
CNSTI4 76
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1369
;1369:		}
ADDRGP4 $949
JUMPV
LABELV $948
line 1370
;1370:		else if (!Q_stricmp(token, "range")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $957
ARGP4
ADDRLP4 48
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
NEI4 $955
line 1371
;1371:			token = COM_Parse(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 52
INDIRP4
ASGNP4
line 1372
;1372:			lfe->range = atof(token);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 atof
CALLF4
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 64
ADDP4
ADDRLP4 56
INDIRF4
ASGNF4
line 1373
;1373:			lfe->rangeSqr = Square(lfe->range);
ADDRLP4 60
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDRLP4 60
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
MULF4
ASGNF4
line 1374
;1374:		}
ADDRGP4 $956
JUMPV
LABELV $955
line 1375
;1375:		else if (!Q_stricmp(token, "fadeAngle")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $960
ARGP4
ADDRLP4 52
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $958
line 1376
;1376:			token = COM_Parse(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 56
INDIRP4
ASGNP4
line 1377
;1377:			lfe->fadeAngle = Com_Clamp(0, 180, atof(token));
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 atof
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1127481344
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 64
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 72
ADDP4
ADDRLP4 64
INDIRF4
ASGNF4
line 1378
;1378:		}
ADDRGP4 $959
JUMPV
LABELV $958
line 1379
;1379:		else {
line 1380
;1380:			CG_Printf(S_COLOR_YELLOW "unexpected token '%s' in '%s'\n", token, lfe->name);
ADDRGP4 $898
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1381
;1381:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $916
JUMPV
LABELV $959
LABELV $956
LABELV $949
line 1383
;1382:		}
;1383:	}
LABELV $941
line 1352
ADDRGP4 $940
JUMPV
LABELV $942
line 1385
;1384:
;1385:	CG_FinalizeLensFlareEffect(lfe);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_FinalizeLensFlareEffect
CALLV
pop
line 1387
;1386:
;1387:	return qtrue;
CNSTI4 1
RETI4
LABELV $916
endproc CG_ParseLensFlareEffect 68 12
export CG_LoadLensFlares
proc CG_LoadLensFlares 28 12
line 1397
;1388:}
;1389:#endif
;1390:
;1391:/*
;1392:=================
;1393:JUHOX: CG_LoadLensFlares
;1394:=================
;1395:*/
;1396:#if MAPLENSFLARES
;1397:void CG_LoadLensFlares(void) {
line 1404
;1398:	char* p;
;1399:
;1400:#if LFDEBUG
;1401:	CG_LoadingString("LF: CG_LoadLensFlares()");
;1402:#endif
;1403:
;1404:	CG_InitFileStack();
ADDRGP4 CG_InitFileStack
CALLV
pop
line 1406
;1405:
;1406:	cgs.numLensFlareEffects = 0;
ADDRGP4 cgs+162608
CNSTI4 0
ASGNI4
line 1407
;1407:	memset(&cgs.lensFlareEffects, 0, sizeof(cgs.lensFlareEffects));
ADDRGP4 cgs+162612
ARGP4
CNSTI4 0
ARGI4
CNSTI4 400000
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1409
;1408:
;1409:	CG_PushFile("flares/", va("%s.lfs", Info_ValueForKey(CG_ConfigString(CS_SERVERINFO), "mapname")));
CNSTI4 0
ARGI4
ADDRLP4 4
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $967
ARGP4
ADDRLP4 8
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $966
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $965
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 CG_PushFile
CALLV
pop
line 1410
;1410:	if (!CG_PopFile()) return;
ADDRLP4 16
ADDRGP4 CG_PopFile
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $968
ADDRGP4 $961
JUMPV
LABELV $968
line 1411
;1411:	lfNameBase[0] = 0;
ADDRGP4 lfNameBase
CNSTI1 0
ASGNI1
line 1413
;1412:
;1413:	p = lfbuf;
ADDRLP4 0
ADDRGP4 lfbuf
ASGNP4
ADDRGP4 $971
JUMPV
LABELV $970
line 1416
;1414:
;1415:	// parse all lens flare effects
;1416:	while (cgs.numLensFlareEffects < MAX_LENSFLARE_EFFECTS && p) {
line 1417
;1417:		if (!CG_ParseLensFlareEffect(&p, &cgs.lensFlareEffects[cgs.numLensFlareEffects])) {
ADDRLP4 0
ARGP4
ADDRGP4 cgs+162608
INDIRI4
CNSTI4 2000
MULI4
ADDRGP4 cgs+162612
ADDP4
ARGP4
ADDRLP4 20
ADDRGP4 CG_ParseLensFlareEffect
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $974
line 1418
;1418:			break;
ADDRGP4 $972
JUMPV
LABELV $974
line 1420
;1419:		}
;1420:		cgs.numLensFlareEffects++;
ADDRLP4 24
ADDRGP4 cgs+162608
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1421
;1421:	}
LABELV $971
line 1416
ADDRGP4 cgs+162608
INDIRI4
CNSTI4 200
GEI4 $979
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $970
LABELV $979
LABELV $972
line 1422
;1422:	CG_Printf("%d lens flare effects loaded\n", cgs.numLensFlareEffects);
ADDRGP4 $980
ARGP4
ADDRGP4 cgs+162608
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 1423
;1423:}
LABELV $961
endproc CG_LoadLensFlares 28 12
export CG_ComputeMaxVisAngle
proc CG_ComputeMaxVisAngle 24 0
line 1432
;1424:#endif
;1425:
;1426:/*
;1427:=================
;1428:JUHOX: CG_ComputeMaxVisAngle
;1429:=================
;1430:*/
;1431:#if MAPLENSFLARES
;1432:void CG_ComputeMaxVisAngle(lensFlareEntity_t* lfent) {
line 1440
;1433:	const lensFlareEffect_t* lfeff;
;1434:	int i;
;1435:	float maxVisAngle;
;1436:
;1437:#if LFDEBUG
;1438:	CG_LoadingString("LF: CG_ComputeMaxVisAngle()");
;1439:#endif
;1440:	lfeff = lfent->lfeff;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRP4
ASGNP4
line 1441
;1441:	if (lfent->angle >= 0 && lfeff) {
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
CNSTF4 0
LTF4 $983
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $983
line 1442
;1442:		maxVisAngle = 0.0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 1443
;1443:		for (i = 0; i < lfeff->numLensFlares; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $988
JUMPV
LABELV $985
line 1447
;1444:			const lensFlare_t* lf;
;1445:			float visAngle;
;1446:
;1447:			lf = &lfeff->lensFlares[i];
ADDRLP4 12
ADDRLP4 4
INDIRI4
CNSTI4 60
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
ADDP4
ASGNP4
line 1448
;1448:			visAngle = lfent->angle * lf->entityAngleFactor + lfeff->fadeAngle * lf->fadeAngleFactor;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 52
ADDP4
INDIRF4
MULF4
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 48
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1449
;1449:			if (visAngle > maxVisAngle) maxVisAngle = visAngle;
ADDRLP4 16
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $989
ADDRLP4 8
ADDRLP4 16
INDIRF4
ASGNF4
LABELV $989
line 1450
;1450:		}
LABELV $986
line 1443
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $988
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
LTI4 $985
line 1451
;1451:	}
ADDRGP4 $984
JUMPV
LABELV $983
line 1452
;1452:	else {
line 1453
;1453:		maxVisAngle = 999.0;
ADDRLP4 8
CNSTF4 1148829696
ASGNF4
line 1454
;1454:	}
LABELV $984
line 1455
;1455:	lfent->maxVisAngle = maxVisAngle;
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
line 1456
;1456:}
LABELV $982
endproc CG_ComputeMaxVisAngle 24 0
proc CG_ParseLensFlareEntity 120 8
line 1465
;1457:#endif
;1458:
;1459:/*
;1460:=================
;1461:JUHOX: CG_ParseLensFlareEntity
;1462:=================
;1463:*/
;1464:#if MAPLENSFLARES
;1465:static qboolean CG_ParseLensFlareEntity(char** p, lensFlareEntity_t* lfent) {
line 1471
;1466:	char* token;
;1467:
;1468:#if LFDEBUG
;1469:	CG_LoadingString("LF: CG_ParseLensFlareEntity()");
;1470:#endif
;1471:	token = COM_Parse(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 1472
;1472:	if (!token[0]) return qfalse;
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $992
CNSTI4 0
RETI4
ADDRGP4 $991
JUMPV
LABELV $992
line 1474
;1473:
;1474:	if (Q_stricmp(token, "{")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $938
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $994
line 1475
;1475:		CG_Printf(S_COLOR_YELLOW "read '%s', expected '{'\n", token);
ADDRGP4 $996
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1476
;1476:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $991
JUMPV
LABELV $994
line 1479
;1477:	}
;1478:
;1479:	token = COM_Parse(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 1480
;1480:	if (!token[0]) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $997
line 1481
;1481:		CG_Printf(S_COLOR_YELLOW "unexpected end of file\n");
ADDRGP4 $999
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1482
;1482:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $991
JUMPV
LABELV $997
line 1484
;1483:	}
;1484:	lfent->lfeff = CG_FindLensFlareEffect(token);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 CG_FindLensFlareEffect
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 16
INDIRP4
ASGNP4
line 1485
;1485:	if (!lfent->lfeff) {
ADDRFP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1000
line 1486
;1486:		CG_Printf(S_COLOR_YELLOW "undefined lens flare effect '%s'\n", token);
ADDRGP4 $1002
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1488
;1487:		//return qfalse;
;1488:	}
LABELV $1000
line 1490
;1489:
;1490:	lfent->origin[0] = atof(COM_Parse(p));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 atof
CALLF4
ASGNF4
ADDRFP4 4
INDIRP4
ADDRLP4 24
INDIRF4
ASGNF4
line 1491
;1491:	lfent->origin[1] = atof(COM_Parse(p));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 atof
CALLF4
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 32
INDIRF4
ASGNF4
line 1492
;1492:	lfent->origin[2] = atof(COM_Parse(p));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 atof
CALLF4
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 40
INDIRF4
ASGNF4
line 1494
;1493:
;1494:	lfent->radius = atof(COM_Parse(p));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 atof
CALLF4
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 48
INDIRF4
ASGNF4
line 1496
;1495:
;1496:	lfent->dir[0] = atof(COM_Parse(p));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 atof
CALLF4
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 56
INDIRF4
ASGNF4
line 1497
;1497:	lfent->dir[1] = atof(COM_Parse(p));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 atof
CALLF4
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 64
INDIRF4
ASGNF4
line 1498
;1498:	lfent->dir[2] = atof(COM_Parse(p));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 72
ADDRGP4 atof
CALLF4
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 72
INDIRF4
ASGNF4
line 1499
;1499:	if (VectorLength(lfent->dir) < 0.1) {
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 76
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 76
INDIRF4
CNSTF4 1036831949
GEF4 $1003
line 1500
;1500:		lfent->dir[0] = 1;
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 1065353216
ASGNF4
line 1501
;1501:	}
LABELV $1003
line 1502
;1502:	VectorNormalize(lfent->dir);
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 1504
;1503:
;1504:	lfent->angle = atof(COM_Parse(p));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 80
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 80
INDIRP4
ARGP4
ADDRLP4 84
ADDRGP4 atof
CALLF4
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 84
INDIRF4
ASGNF4
line 1505
;1505:	if (lfent->angle < 0) lfent->angle = -1;
ADDRFP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
CNSTF4 0
GEF4 $1005
ADDRFP4 4
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 3212836864
ASGNF4
LABELV $1005
line 1506
;1506:	if (lfent->angle > 180) lfent->angle = 180;
ADDRFP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
CNSTF4 1127481344
LEF4 $1007
ADDRFP4 4
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 1127481344
ASGNF4
LABELV $1007
line 1508
;1507:
;1508:	CG_ComputeMaxVisAngle(lfent);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_ComputeMaxVisAngle
CALLV
pop
ADDRGP4 $1010
JUMPV
LABELV $1009
line 1510
;1509:
;1510:	while (1) {
line 1511
;1511:		token = COM_Parse(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 88
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 88
INDIRP4
ASGNP4
line 1512
;1512:		if (!token[0]) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1012
line 1513
;1513:			CG_Printf(S_COLOR_YELLOW "unexpected end of file\n");
ADDRGP4 $999
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1514
;1514:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $991
JUMPV
LABELV $1012
line 1516
;1515:		}
;1516:		if (!Q_stricmp(token, "}")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $852
ARGP4
ADDRLP4 92
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 0
NEI4 $1014
line 1517
;1517:			break;
ADDRGP4 $1011
JUMPV
LABELV $1014
line 1519
;1518:		}
;1519:		else if (!Q_stricmp(token, "lr")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $1018
ARGP4
ADDRLP4 96
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 96
INDIRI4
CNSTI4 0
NEI4 $1016
line 1520
;1520:			lfent->lightRadius = atof(COM_Parse(p));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 100
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRLP4 104
ADDRGP4 atof
CALLF4
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 104
INDIRF4
ASGNF4
line 1521
;1521:			if (lfent->lightRadius > lfent->radius) {
ADDRLP4 108
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 108
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 108
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
LEF4 $1017
line 1522
;1522:				lfent->lightRadius = lfent->radius;
ADDRLP4 112
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 112
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 112
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ASGNF4
line 1523
;1523:			}
line 1524
;1524:		}
ADDRGP4 $1017
JUMPV
LABELV $1016
line 1525
;1525:		else if (!Q_stricmp(token, "mv")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $1023
ARGP4
ADDRLP4 100
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 0
NEI4 $1021
line 1528
;1526:			int entnum;
;1527:
;1528:			entnum = atoi(COM_Parse(p));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 108
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 108
INDIRP4
ARGP4
ADDRLP4 112
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 104
ADDRLP4 112
INDIRI4
ASGNI4
line 1529
;1529:			if (entnum >= MAX_CLIENTS && entnum < ENTITYNUM_WORLD) {
ADDRLP4 104
INDIRI4
CNSTI4 64
LTI4 $1022
ADDRLP4 104
INDIRI4
CNSTI4 1022
GEI4 $1022
line 1530
;1530:				lfent->lock = &cg_entities[entnum];
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 104
INDIRI4
CNSTI4 880
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 1531
;1531:			}
line 1532
;1532:		}
ADDRGP4 $1022
JUMPV
LABELV $1021
line 1533
;1533:		else {
line 1534
;1534:			CG_Printf(S_COLOR_YELLOW "unexpected token '%s'\n", token);
ADDRGP4 $1026
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1535
;1535:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $991
JUMPV
LABELV $1022
LABELV $1017
line 1537
;1536:		}
;1537:	}
LABELV $1010
line 1510
ADDRGP4 $1009
JUMPV
LABELV $1011
line 1539
;1538:
;1539:	return qtrue;
CNSTI4 1
RETI4
LABELV $991
endproc CG_ParseLensFlareEntity 120 8
export CG_LoadLensFlareEntities
proc CG_LoadLensFlareEntities 300 16
line 1549
;1540:}
;1541:#endif
;1542:
;1543:/*
;1544:=================
;1545:JUHOX: CG_LoadLensFlareEntities
;1546:=================
;1547:*/
;1548:#if MAPLENSFLARES
;1549:void CG_LoadLensFlareEntities(void) {
line 1558
;1550:	char name[256];
;1551:	fileHandle_t f;
;1552:	int len;
;1553:	char* p;
;1554:
;1555:#if LFDEBUG
;1556:	CG_LoadingString("LF: CG_LoadLensFlareEntities()");
;1557:#endif
;1558:	cgs.numLensFlareEntities = 0;
ADDRGP4 cgs+562612
CNSTI4 0
ASGNI4
line 1559
;1559:	memset(&cgs.lensFlareEntities, 0, sizeof(cgs.lensFlareEntities));
ADDRGP4 cgs+562800
ARGP4
CNSTI4 0
ARGI4
CNSTI4 188416
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1561
;1560:
;1561:	if (cgs.sunFlareEffect[0]) {
ADDRGP4 cgs+31688
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1031
line 1566
;1562:		lensFlareEntity_t* lfent;
;1563:		vec3_t angles;
;1564:		vec3_t sunDir;
;1565:
;1566:		lfent = &cgs.sunFlare;
ADDRLP4 268
ADDRGP4 cgs+562616
ASGNP4
line 1568
;1567:
;1568:		lfent->lfeff = CG_FindLensFlareEffect(cgs.sunFlareEffect);
ADDRGP4 cgs+31688
ARGP4
ADDRLP4 296
ADDRGP4 CG_FindLensFlareEffect
CALLP4
ASGNP4
ADDRLP4 268
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 296
INDIRP4
ASGNP4
line 1569
;1569:		if (!lfent->lfeff) {
ADDRLP4 268
INDIRP4
CNSTI4 44
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1036
line 1570
;1570:			CG_Printf(S_COLOR_YELLOW "undefined sun flare effect '%s'\n", cgs.sunFlareEffect);
ADDRGP4 $1038
ARGP4
ADDRGP4 cgs+31688
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1571
;1571:		}
LABELV $1036
line 1573
;1572:
;1573:		angles[YAW] = cgs.sunFlareYaw;
ADDRLP4 272+4
ADDRGP4 cgs+31816
INDIRF4
ASGNF4
line 1574
;1574:		angles[PITCH] = -cgs.sunFlarePitch;
ADDRLP4 272
ADDRGP4 cgs+31820
INDIRF4
NEGF4
ASGNF4
line 1575
;1575:		angles[ROLL] = 0;
ADDRLP4 272+8
CNSTF4 0
ASGNF4
line 1576
;1576:		AngleVectors(angles, sunDir, NULL, NULL);
ADDRLP4 272
ARGP4
ADDRLP4 284
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 1577
;1577:		VectorScale(sunDir, cgs.sunFlareDistance, lfent->origin);
ADDRLP4 268
INDIRP4
ADDRLP4 284
INDIRF4
ADDRGP4 cgs+31824
INDIRF4
MULF4
ASGNF4
ADDRLP4 268
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 284+4
INDIRF4
ADDRGP4 cgs+31824
INDIRF4
MULF4
ASGNF4
ADDRLP4 268
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 284+8
INDIRF4
ADDRGP4 cgs+31824
INDIRF4
MULF4
ASGNF4
line 1579
;1578:
;1579:		lfent->radius = 150;
ADDRLP4 268
INDIRP4
CNSTI4 16
ADDP4
CNSTF4 1125515264
ASGNF4
line 1580
;1580:		lfent->lightRadius = 100;
ADDRLP4 268
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 1120403456
ASGNF4
line 1581
;1581:		lfent->angle = -1;
ADDRLP4 268
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 3212836864
ASGNF4
line 1583
;1582:
;1583:		CG_ComputeMaxVisAngle(lfent);
ADDRLP4 268
INDIRP4
ARGP4
ADDRGP4 CG_ComputeMaxVisAngle
CALLV
pop
line 1585
;1584:
;1585:		CG_Printf("sun flare entity created\n");
ADDRGP4 $1049
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1586
;1586:	}
LABELV $1031
line 1588
;1587:
;1588:	Com_sprintf(name, sizeof(name), "flares/%s.lfe", Info_ValueForKey(CG_ConfigString(CS_SERVERINFO), "mapname"));
CNSTI4 0
ARGI4
ADDRLP4 268
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 268
INDIRP4
ARGP4
ADDRGP4 $967
ARGP4
ADDRLP4 272
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $1050
ARGP4
ADDRLP4 272
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1590
;1589:
;1590:	len = trap_FS_FOpenFile(name, &f, FS_READ);
ADDRLP4 4
ARGP4
ADDRLP4 260
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 276
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 264
ADDRLP4 276
INDIRI4
ASGNI4
line 1591
;1591:	if (!f) {
ADDRLP4 260
INDIRI4
CNSTI4 0
NEI4 $1051
line 1592
;1592:		CG_Printf("'%s' not found\n", name);
ADDRGP4 $1053
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1593
;1593:		return;
ADDRGP4 $1027
JUMPV
LABELV $1051
line 1595
;1594:	}
;1595:	if (len >= sizeof(lfbuf)) {
ADDRLP4 264
INDIRI4
CVIU4 4
CNSTU4 65536
LTU4 $1054
line 1596
;1596:		CG_Printf(S_COLOR_YELLOW "file too large: '%s' > %d\n", name, sizeof(lfbuf)-1);
ADDRGP4 $841
ARGP4
ADDRLP4 4
ARGP4
CNSTU4 65535
ARGU4
ADDRGP4 CG_Printf
CALLV
pop
line 1597
;1597:		return;
ADDRGP4 $1027
JUMPV
LABELV $1054
line 1599
;1598:	}
;1599:	CG_Printf("reading '%s'...\n", name);
ADDRGP4 $842
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1604
;1600:#if LFDEBUG
;1601:	CG_LoadingString(va("%s", name));
;1602:#endif
;1603:
;1604:	trap_FS_Read(lfbuf, len, f);
ADDRGP4 lfbuf
ARGP4
ADDRLP4 264
INDIRI4
ARGI4
ADDRLP4 260
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 1605
;1605:	lfbuf[len] = 0;
ADDRLP4 264
INDIRI4
ADDRGP4 lfbuf
ADDP4
CNSTI1 0
ASGNI1
line 1606
;1606:	trap_FS_FCloseFile(f);
ADDRLP4 260
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 1608
;1607:
;1608:	COM_Compress(lfbuf);
ADDRGP4 lfbuf
ARGP4
ADDRGP4 COM_Compress
CALLI4
pop
line 1610
;1609:
;1610:	p = lfbuf;
ADDRLP4 0
ADDRGP4 lfbuf
ASGNP4
ADDRGP4 $1057
JUMPV
LABELV $1056
line 1613
;1611:
;1612:	// parse all lens flare entities
;1613:	while (cgs.numLensFlareEntities < MAX_LIGHTS_PER_MAP && p) {
line 1614
;1614:		if (!CG_ParseLensFlareEntity(&p, &cgs.lensFlareEntities[cgs.numLensFlareEntities])) {
ADDRLP4 0
ARGP4
ADDRGP4 cgs+562612
INDIRI4
CNSTI4 184
MULI4
ADDRGP4 cgs+562800
ADDP4
ARGP4
ADDRLP4 280
ADDRGP4 CG_ParseLensFlareEntity
CALLI4
ASGNI4
ADDRLP4 280
INDIRI4
CNSTI4 0
NEI4 $1060
line 1615
;1615:			break;
ADDRGP4 $1058
JUMPV
LABELV $1060
line 1617
;1616:		}
;1617:		cgs.numLensFlareEntities++;
ADDRLP4 284
ADDRGP4 cgs+562612
ASGNP4
ADDRLP4 284
INDIRP4
ADDRLP4 284
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1618
;1618:	}
LABELV $1057
line 1613
ADDRGP4 cgs+562612
INDIRI4
CNSTI4 1024
GEI4 $1065
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1056
LABELV $1065
LABELV $1058
line 1620
;1619:
;1620:	CG_Printf("%d lens flare entities loaded\n", cgs.numLensFlareEntities);
ADDRGP4 $1066
ARGP4
ADDRGP4 cgs+562612
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 1624
;1621:#if LFDEBUG
;1622:	CG_LoadingString("LF: CG_LoadLensFlareEntities() ready");
;1623:#endif
;1624:}
LABELV $1027
endproc CG_LoadLensFlareEntities 300 16
data
align 4
LABELV $1069
address $1070
address $1071
address $1072
address $1073
address $1074
address $1075
address $1076
address $1077
address $1078
address $1079
address $1080
code
proc CG_RegisterGraphics 716 16
line 1634
;1625:#endif
;1626:
;1627:/*
;1628:=================
;1629:CG_RegisterGraphics
;1630:
;1631:This function may execute for a couple of minutes with a slow disk.
;1632:=================
;1633:*/
;1634:static void CG_RegisterGraphics( void ) {
line 1652
;1635:	int			i;
;1636:	char		items[MAX_ITEMS+1];
;1637:	static char		*sb_nums[11] = {
;1638:		"gfx/2d/numbers/zero_32b",
;1639:		"gfx/2d/numbers/one_32b",
;1640:		"gfx/2d/numbers/two_32b",
;1641:		"gfx/2d/numbers/three_32b",
;1642:		"gfx/2d/numbers/four_32b",
;1643:		"gfx/2d/numbers/five_32b",
;1644:		"gfx/2d/numbers/six_32b",
;1645:		"gfx/2d/numbers/seven_32b",
;1646:		"gfx/2d/numbers/eight_32b",
;1647:		"gfx/2d/numbers/nine_32b",
;1648:		"gfx/2d/numbers/minus_32b",
;1649:	};
;1650:
;1651:	// clear any references to old media
;1652:	memset( &cg.refdef, 0, sizeof( cg.refdef ) );
ADDRGP4 cg+109260
ARGP4
CNSTI4 0
ARGI4
CNSTI4 368
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1653
;1653:	trap_R_ClearScene();
ADDRGP4 trap_R_ClearScene
CALLV
pop
line 1655
;1654:
;1655:	CG_LoadingString( cgs.mapname );
ADDRGP4 cgs+31484
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 1657
;1656:
;1657:	trap_R_LoadWorldMap( cgs.mapname );
ADDRGP4 cgs+31484
ARGP4
ADDRGP4 trap_R_LoadWorldMap
CALLV
pop
line 1660
;1658:
;1659:#if MAPLENSFLARES	// JUHOX: load map lens flares
;1660:	CG_LoadingString("lens flares");
ADDRGP4 $1085
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 1661
;1661:	CG_LoadLensFlares();
ADDRGP4 CG_LoadLensFlares
CALLV
pop
line 1662
;1662:	CG_LoadLensFlareEntities();
ADDRGP4 CG_LoadLensFlareEntities
CALLV
pop
line 1663
;1663:	cg.lfEditor.copyOptions = -1;
ADDRGP4 cg+109660+260
CNSTI4 -1
ASGNI4
line 1664
;1664:	cg.lfEditor.copiedLFEnt.dir[0] = 1;
ADDRGP4 cg+109660+264+24
CNSTF4 1065353216
ASGNF4
line 1669
;1665:#endif
;1666:
;1667:	// JUHOX: load nearbox shaders
;1668:#if 1
;1669:	if (cgs.nearboxShaderName[0]) {
ADDRGP4 cgs+31872
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1091
line 1671
;1670:		//cgs.media.nearbox_up = trap_R_RegisterShader(va("%s_up", cgs.nearboxShaderName));
;1671:		cgs.media.nearbox_dn = trap_R_RegisterShader(va("%s_dn", cgs.nearboxShaderName));
ADDRGP4 $1096
ARGP4
ADDRGP4 cgs+31872
ARGP4
ADDRLP4 264
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 264
INDIRP4
ARGP4
ADDRLP4 268
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+52
ADDRLP4 268
INDIRI4
ASGNI4
line 1672
;1672:		cgs.media.nearbox_ft = trap_R_RegisterShader(va("%s_ft", cgs.nearboxShaderName));
ADDRGP4 $1100
ARGP4
ADDRGP4 cgs+31872
ARGP4
ADDRLP4 272
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 272
INDIRP4
ARGP4
ADDRLP4 276
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+56
ADDRLP4 276
INDIRI4
ASGNI4
line 1673
;1673:		cgs.media.nearbox_bk = trap_R_RegisterShader(va("%s_bk", cgs.nearboxShaderName));
ADDRGP4 $1104
ARGP4
ADDRGP4 cgs+31872
ARGP4
ADDRLP4 280
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 280
INDIRP4
ARGP4
ADDRLP4 284
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+60
ADDRLP4 284
INDIRI4
ASGNI4
line 1674
;1674:		cgs.media.nearbox_lf = trap_R_RegisterShader(va("%s_lf", cgs.nearboxShaderName));
ADDRGP4 $1108
ARGP4
ADDRGP4 cgs+31872
ARGP4
ADDRLP4 288
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 292
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+64
ADDRLP4 292
INDIRI4
ASGNI4
line 1675
;1675:		cgs.media.nearbox_rt = trap_R_RegisterShader(va("%s_rt", cgs.nearboxShaderName));
ADDRGP4 $1112
ARGP4
ADDRGP4 cgs+31872
ARGP4
ADDRLP4 296
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 296
INDIRP4
ARGP4
ADDRLP4 300
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+68
ADDRLP4 300
INDIRI4
ASGNI4
line 1676
;1676:	}
LABELV $1091
line 1680
;1677:#endif
;1678:
;1679:	// precache status bar pics
;1680:	CG_LoadingString( "game media" );
ADDRGP4 $1114
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 1682
;1681:
;1682:	for ( i=0 ; i<11 ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1115
line 1683
;1683:		cgs.media.numberShaders[i] = trap_R_RegisterShader( sb_nums[i] );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1069
ADDP4
INDIRP4
ARGP4
ADDRLP4 268
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+751220+508
ADDP4
ADDRLP4 268
INDIRI4
ASGNI4
line 1684
;1684:	}
LABELV $1116
line 1682
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 11
LTI4 $1115
line 1686
;1685:
;1686:	cgs.media.botSkillShaders[0] = trap_R_RegisterShader( "menu/art/skill1.tga" );
ADDRGP4 $1123
ARGP4
ADDRLP4 264
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+556
ADDRLP4 264
INDIRI4
ASGNI4
line 1687
;1687:	cgs.media.botSkillShaders[1] = trap_R_RegisterShader( "menu/art/skill2.tga" );
ADDRGP4 $1127
ARGP4
ADDRLP4 268
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+556+4
ADDRLP4 268
INDIRI4
ASGNI4
line 1688
;1688:	cgs.media.botSkillShaders[2] = trap_R_RegisterShader( "menu/art/skill3.tga" );
ADDRGP4 $1131
ARGP4
ADDRLP4 272
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+556+8
ADDRLP4 272
INDIRI4
ASGNI4
line 1689
;1689:	cgs.media.botSkillShaders[3] = trap_R_RegisterShader( "menu/art/skill4.tga" );
ADDRGP4 $1135
ARGP4
ADDRLP4 276
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+556+12
ADDRLP4 276
INDIRI4
ASGNI4
line 1690
;1690:	cgs.media.botSkillShaders[4] = trap_R_RegisterShader( "menu/art/skill5.tga" );
ADDRGP4 $1139
ARGP4
ADDRLP4 280
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+556+16
ADDRLP4 280
INDIRI4
ASGNI4
line 1692
;1691:
;1692:	cgs.media.viewBloodShader = trap_R_RegisterShader( "viewBloodBlend" );
ADDRGP4 $1142
ARGP4
ADDRLP4 284
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+384
ADDRLP4 284
INDIRI4
ASGNI4
line 1694
;1693:
;1694:	cgs.media.deferShader = trap_R_RegisterShaderNoMip( "gfx/2d/defer.tga" );
ADDRGP4 $1145
ARGP4
ADDRLP4 288
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+751220+184
ADDRLP4 288
INDIRI4
ASGNI4
line 1696
;1695:
;1696:	cgs.media.scoreboardName = trap_R_RegisterShaderNoMip( "menu/tab/name.tga" );
ADDRGP4 $1148
ARGP4
ADDRLP4 292
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+751220+740
ADDRLP4 292
INDIRI4
ASGNI4
line 1697
;1697:	cgs.media.scoreboardPing = trap_R_RegisterShaderNoMip( "menu/tab/ping.tga" );
ADDRGP4 $1151
ARGP4
ADDRLP4 296
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+751220+744
ADDRLP4 296
INDIRI4
ASGNI4
line 1698
;1698:	cgs.media.scoreboardScore = trap_R_RegisterShaderNoMip( "menu/tab/score.tga" );
ADDRGP4 $1154
ARGP4
ADDRLP4 300
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+751220+748
ADDRLP4 300
INDIRI4
ASGNI4
line 1699
;1699:	cgs.media.scoreboardTime = trap_R_RegisterShaderNoMip( "menu/tab/time.tga" );
ADDRGP4 $1157
ARGP4
ADDRLP4 304
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+751220+752
ADDRLP4 304
INDIRI4
ASGNI4
line 1701
;1700:
;1701:	cgs.media.smokePuffShader = trap_R_RegisterShader( "smokePuff" );
ADDRGP4 $1160
ARGP4
ADDRLP4 308
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+444
ADDRLP4 308
INDIRI4
ASGNI4
line 1702
;1702:	cgs.media.smokePuffRageProShader = trap_R_RegisterShader( "smokePuffRagePro" );
ADDRGP4 $1163
ARGP4
ADDRLP4 312
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+448
ADDRLP4 312
INDIRI4
ASGNI4
line 1703
;1703:	cgs.media.shotgunSmokePuffShader = trap_R_RegisterShader( "shotgunSmokePuff" );
ADDRGP4 $1166
ARGP4
ADDRLP4 316
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+452
ADDRLP4 316
INDIRI4
ASGNI4
line 1708
;1704:#ifdef MISSIONPACK
;1705:	cgs.media.nailPuffShader = trap_R_RegisterShader( "nailtrail" );
;1706:	cgs.media.blueProxMine = trap_R_RegisterModel( "models/weaphits/proxmineb.md3" );
;1707:#endif
;1708:	cgs.media.plasmaBallShader = trap_R_RegisterShader( "sprites/plasma1" );
ADDRGP4 $1169
ARGP4
ADDRLP4 320
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+456
ADDRLP4 320
INDIRI4
ASGNI4
line 1709
;1709:	cgs.media.bloodTrailShader = trap_R_RegisterShader( "bloodTrail" );
ADDRGP4 $1172
ARGP4
ADDRLP4 324
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+464
ADDRLP4 324
INDIRI4
ASGNI4
line 1710
;1710:	cgs.media.monsterBloodTrail1Shader = trap_R_RegisterShader("monsterBloodTrail1");	// JUHOX
ADDRGP4 $1175
ARGP4
ADDRLP4 328
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+468
ADDRLP4 328
INDIRI4
ASGNI4
line 1711
;1711:	cgs.media.monsterBloodTrail2Shader = trap_R_RegisterShader("monsterBloodTrail2");	// JUHOX
ADDRGP4 $1178
ARGP4
ADDRLP4 332
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+472
ADDRLP4 332
INDIRI4
ASGNI4
line 1712
;1712:	cgs.media.monsterBloodExplosionShader = trap_R_RegisterShader("gfx/damage/monster_blood_explosion");	// JUHOX
ADDRGP4 $1181
ARGP4
ADDRLP4 336
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+476
ADDRLP4 336
INDIRI4
ASGNI4
line 1713
;1713:	cgs.media.lagometerShader = trap_R_RegisterShader("lagometer" );
ADDRGP4 $1184
ARGP4
ADDRLP4 340
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+432
ADDRLP4 340
INDIRI4
ASGNI4
line 1714
;1714:	cgs.media.connectionShader = trap_R_RegisterShader( "disconnected" );
ADDRGP4 $1187
ARGP4
ADDRLP4 344
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+376
ADDRLP4 344
INDIRI4
ASGNI4
line 1716
;1715:
;1716:	cgs.media.waterBubbleShader = trap_R_RegisterShader( "waterBubble" );
ADDRGP4 $1190
ARGP4
ADDRLP4 348
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+460
ADDRLP4 348
INDIRI4
ASGNI4
line 1718
;1717:
;1718:	cgs.media.tracerShader = trap_R_RegisterShader( "gfx/misc/tracer" );
ADDRGP4 $1193
ARGP4
ADDRLP4 352
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+388
ADDRLP4 352
INDIRI4
ASGNI4
line 1719
;1719:	cgs.media.selectShader = trap_R_RegisterShader( "gfx/2d/select" );
ADDRGP4 $1196
ARGP4
ADDRLP4 356
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+380
ADDRLP4 356
INDIRI4
ASGNI4
line 1721
;1720:
;1721:	for ( i = 0 ; i < NUM_CROSSHAIRS ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1197
line 1722
;1722:		cgs.media.crosshairShader[i] = trap_R_RegisterShader( va("gfx/2d/crosshair%c", 'a'+i) );
ADDRGP4 $1203
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 97
ADDI4
ARGI4
ADDRLP4 364
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 364
INDIRP4
ARGP4
ADDRLP4 368
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+751220+392
ADDP4
ADDRLP4 368
INDIRI4
ASGNI4
line 1723
;1723:	}
LABELV $1198
line 1721
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 10
LTI4 $1197
line 1725
;1724:
;1725:	cgs.media.backTileShader = trap_R_RegisterShader( "gfx/2d/backtile" );
ADDRGP4 $1206
ARGP4
ADDRLP4 360
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+436
ADDRLP4 360
INDIRI4
ASGNI4
line 1726
;1726:	cgs.media.noammoShader = trap_R_RegisterShader( "icons/noammo" );
ADDRGP4 $1209
ARGP4
ADDRLP4 364
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+440
ADDRLP4 364
INDIRI4
ASGNI4
line 1729
;1727:
;1728:	// powerup shaders
;1729:	cgs.media.quadShader = trap_R_RegisterShader("powerups/quad" );
ADDRGP4 $1212
ARGP4
ADDRLP4 368
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+604
ADDRLP4 368
INDIRI4
ASGNI4
line 1730
;1730:	cgs.media.quadWeaponShader = trap_R_RegisterShader("powerups/quadWeapon" );
ADDRGP4 $1215
ARGP4
ADDRLP4 372
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+612
ADDRLP4 372
INDIRI4
ASGNI4
line 1731
;1731:	cgs.media.battleSuitShader = trap_R_RegisterShader("powerups/battleSuit" );
ADDRGP4 $1218
ARGP4
ADDRLP4 376
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+624
ADDRLP4 376
INDIRI4
ASGNI4
line 1732
;1732:	cgs.media.battleWeaponShader = trap_R_RegisterShader("powerups/battleWeapon" );
ADDRGP4 $1221
ARGP4
ADDRLP4 380
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+628
ADDRLP4 380
INDIRI4
ASGNI4
line 1737
;1733:	// JUHOX: new invisibility shader
;1734:#if 0
;1735:	cgs.media.invisShader = trap_R_RegisterShader("powerups/invisibility" );
;1736:#else
;1737:	cgs.media.invisShader = trap_R_RegisterShader("powerups/stdInvis" );
ADDRGP4 $1224
ARGP4
ADDRLP4 384
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+616
ADDRLP4 384
INDIRI4
ASGNI4
line 1739
;1738:#endif
;1739:	cgs.media.regenShader = trap_R_RegisterShader("powerups/regen" );
ADDRGP4 $1227
ARGP4
ADDRLP4 388
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+620
ADDRLP4 388
INDIRI4
ASGNI4
line 1740
;1740:	cgs.media.hastePuffShader = trap_R_RegisterShader("hasteSmokePuff" );
ADDRGP4 $1230
ARGP4
ADDRLP4 392
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+632
ADDRLP4 392
INDIRI4
ASGNI4
line 1741
;1741:	cgs.media.chargeShader = trap_R_RegisterShader("powerups/charge");				// JUHOX
ADDRGP4 $1233
ARGP4
ADDRLP4 396
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+644
ADDRLP4 396
INDIRI4
ASGNI4
line 1742
;1742:	cgs.media.chargeWeaponShader = trap_R_RegisterShader("powerups/chargeWeapon");	// JUHOX
ADDRGP4 $1236
ARGP4
ADDRLP4 400
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+648
ADDRLP4 400
INDIRI4
ASGNI4
line 1743
;1743:	cgs.media.targetMarker = trap_R_RegisterShader("powerups/targetMarker");		// JUHOX
ADDRGP4 $1239
ARGP4
ADDRLP4 404
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+660
ADDRLP4 404
INDIRI4
ASGNI4
line 1744
;1744:	cgs.media.shieldShader = trap_R_RegisterShader("powerups/shield");				// JUHOX
ADDRGP4 $1242
ARGP4
ADDRLP4 408
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+668
ADDRLP4 408
INDIRI4
ASGNI4
line 1745
;1745:	cgs.media.shieldWeaponShader = trap_R_RegisterShader("powerups/shieldWeapon");	// JUHOX
ADDRGP4 $1245
ARGP4
ADDRLP4 412
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+672
ADDRLP4 412
INDIRI4
ASGNI4
line 1746
;1746:	cgs.media.glassCloakingShader = trap_R_RegisterShader("powerups/glassCloaking");	// JUHOX
ADDRGP4 $1248
ARGP4
ADDRLP4 416
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+280
ADDRLP4 416
INDIRI4
ASGNI4
line 1747
;1747:	cgs.media.glassCloakingSpecShader = trap_R_RegisterShader("powerups/glassCloakingSpecular");	// JUHOX
ADDRGP4 $1251
ARGP4
ADDRLP4 420
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+284
ADDRLP4 420
INDIRI4
ASGNI4
line 1750
;1748:	// JUHOX: load shaders for new spawn effect
;1749:#if 1
;1750:	cgs.media.spawnHullShader = trap_R_RegisterShader("spawnHull");
ADDRGP4 $1254
ARGP4
ADDRLP4 424
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+288
ADDRLP4 424
INDIRI4
ASGNI4
line 1751
;1751:	cgs.media.spawnHullGlow1Shader = trap_R_RegisterShader("spawnHullGlow1");
ADDRGP4 $1257
ARGP4
ADDRLP4 428
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+292
ADDRLP4 428
INDIRI4
ASGNI4
line 1752
;1752:	cgs.media.spawnHullGlow2Shader = trap_R_RegisterShader("spawnHullGlow2");
ADDRGP4 $1260
ARGP4
ADDRLP4 432
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+296
ADDRLP4 432
INDIRI4
ASGNI4
line 1753
;1753:	cgs.media.spawnHullGlow3Shader = trap_R_RegisterShader("spawnHullGlow3");
ADDRGP4 $1263
ARGP4
ADDRLP4 436
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+300
ADDRLP4 436
INDIRI4
ASGNI4
line 1754
;1754:	cgs.media.spawnHullGlow4Shader = trap_R_RegisterShader("spawnHullGlow4");
ADDRGP4 $1266
ARGP4
ADDRLP4 440
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+304
ADDRLP4 440
INDIRI4
ASGNI4
line 1755
;1755:	cgs.media.spawnHullWeaponShader = trap_R_RegisterShader("spawnHullWeapon");
ADDRGP4 $1269
ARGP4
ADDRLP4 444
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+308
ADDRLP4 444
INDIRI4
ASGNI4
line 1756
;1756:	cgs.media.spawnHullGlow1WeaponShader = trap_R_RegisterShader("spawnHullGlow1Weapon");
ADDRGP4 $1272
ARGP4
ADDRLP4 448
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+312
ADDRLP4 448
INDIRI4
ASGNI4
line 1757
;1757:	cgs.media.spawnHullGlow2WeaponShader = trap_R_RegisterShader("spawnHullGlow2Weapon");
ADDRGP4 $1275
ARGP4
ADDRLP4 452
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+316
ADDRLP4 452
INDIRI4
ASGNI4
line 1758
;1758:	cgs.media.spawnHullGlow3WeaponShader = trap_R_RegisterShader("spawnHullGlow3Weapon");
ADDRGP4 $1278
ARGP4
ADDRLP4 456
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+320
ADDRLP4 456
INDIRI4
ASGNI4
line 1759
;1759:	cgs.media.spawnHullGlow4WeaponShader = trap_R_RegisterShader("spawnHullGlow4Weapon");
ADDRGP4 $1281
ARGP4
ADDRLP4 460
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+324
ADDRLP4 460
INDIRI4
ASGNI4
line 1762
;1760:#endif
;1761:
;1762:	cgs.media.navaidShader = trap_R_RegisterShader("navaidline");	// JUHOX
ADDRGP4 $1284
ARGP4
ADDRLP4 464
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+264
ADDRLP4 464
INDIRI4
ASGNI4
line 1763
;1763:	cgs.media.navaid2Shader = trap_R_RegisterShader("navaidline2");	// JUHOX
ADDRGP4 $1287
ARGP4
ADDRLP4 468
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+268
ADDRLP4 468
INDIRI4
ASGNI4
line 1764
;1764:	cgs.media.navaidGoalShader = trap_R_RegisterShader("navAidGoal");	// JUHOX
ADDRGP4 $1290
ARGP4
ADDRLP4 472
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+276
ADDRLP4 472
INDIRI4
ASGNI4
line 1765
;1765:	cgs.media.navaidTargetShader = trap_R_RegisterShader("navAidTarget");	// JUHOX
ADDRGP4 $1293
ARGP4
ADDRLP4 476
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+272
ADDRLP4 476
INDIRI4
ASGNI4
line 1767
;1766:
;1767:	cgs.media.fightInProgressShader = trap_R_RegisterShader("icons/fight");	// JUHOX
ADDRGP4 $1296
ARGP4
ADDRLP4 480
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+328
ADDRLP4 480
INDIRI4
ASGNI4
line 1769
;1768:#if MONSTER_MODE
;1769:	if (cgs.gametype >= GT_STU) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 8
LTI4 $1297
line 1770
;1770:		cgs.media.artefactsShader = trap_R_RegisterShader("icons/artefact");	// JUHOX
ADDRGP4 $1302
ARGP4
ADDRLP4 484
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+332
ADDRLP4 484
INDIRI4
ASGNI4
line 1771
;1771:		cgs.media.lifesShader = trap_R_RegisterShader("icons/lifes");	// JUHOX
ADDRGP4 $1305
ARGP4
ADDRLP4 488
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+336
ADDRLP4 488
INDIRI4
ASGNI4
line 1772
;1772:		cgs.media.detectorShader = trap_R_RegisterShader("icons/detector_beep");	// JUHOX
ADDRGP4 $1308
ARGP4
ADDRLP4 492
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+344
ADDRLP4 492
INDIRI4
ASGNI4
line 1773
;1773:		cgs.media.clockShader = trap_R_RegisterShader("icons/clock");	// JUHOX
ADDRGP4 $1311
ARGP4
ADDRLP4 496
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+340
ADDRLP4 496
INDIRI4
ASGNI4
line 1774
;1774:		cgs.media.monsterSeedMetalShader = trap_R_RegisterShader("models/weapons2/monsterl/seed");	// JUHOX
ADDRGP4 $1314
ARGP4
ADDRLP4 500
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+720
ADDRLP4 500
INDIRI4
ASGNI4
line 1775
;1775:	}
LABELV $1297
line 1779
;1776:#endif
;1777:
;1778:#if MONSTER_MODE
;1779:	cgs.media.hotAirShader = trap_R_RegisterShader("hotAir");	// JUHOX
ADDRGP4 $1317
ARGP4
ADDRLP4 484
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+504
ADDRLP4 484
INDIRI4
ASGNI4
line 1782
;1780:#endif
;1781:
;1782:	cgs.media.huntNameShader = trap_R_RegisterShader("gfx/hunt_name.tga");	// JUHOX
ADDRGP4 $1320
ARGP4
ADDRLP4 488
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+348
ADDRLP4 488
INDIRI4
ASGNI4
line 1784
;1783:
;1784:	cgs.media.deathBlurryShader = trap_R_RegisterShader("deathBlurry");	// JUHOX
ADDRGP4 $1323
ARGP4
ADDRLP4 492
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+352
ADDRLP4 492
INDIRI4
ASGNI4
line 1787
;1785:	// JUHOX: load skull skin for CTF place-of-death marker
;1786:#if 1
;1787:	if (cgs.gametype == GT_CTF) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
NEI4 $1324
line 1788
;1788:		cgs.media.podSkullSkin = trap_R_RegisterSkin("models/players/bones/head_bones.skin");
ADDRGP4 $1329
ARGP4
ADDRLP4 496
ADDRGP4 trap_R_RegisterSkin
CALLI4
ASGNI4
ADDRGP4 cgs+751220+356
ADDRLP4 496
INDIRI4
ASGNI4
line 1789
;1789:	}
LABELV $1324
line 1792
;1790:#endif
;1791:#if SPECIAL_VIEW_MODES
;1792:	cgs.media.scannerShader = trap_R_RegisterShader("scannerFilter");		// JUHOX
ADDRGP4 $1332
ARGP4
ADDRLP4 496
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+360
ADDRLP4 496
INDIRI4
ASGNI4
line 1793
;1793:	cgs.media.amplifierShader = trap_R_RegisterShader("lightAmplifier");	// JUHOX
ADDRGP4 $1335
ARGP4
ADDRLP4 500
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+364
ADDRLP4 500
INDIRI4
ASGNI4
line 1799
;1794:#endif
;1795:
;1796:#ifdef MISSIONPACK
;1797:	if ( cgs.gametype == GT_CTF || cgs.gametype == GT_1FCTF || cgs.gametype == GT_HARVESTER || cg_buildScript.integer ) {
;1798:#else
;1799:	if ( cgs.gametype == GT_CTF || cg_buildScript.integer ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
EQI4 $1340
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $1336
LABELV $1340
line 1801
;1800:#endif
;1801:		cgs.media.redCubeModel = trap_R_RegisterModel( "models/powerups/orb/r_orb.md3" );
ADDRGP4 $1343
ARGP4
ADDRLP4 504
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+751220+72
ADDRLP4 504
INDIRI4
ASGNI4
line 1802
;1802:		cgs.media.blueCubeModel = trap_R_RegisterModel( "models/powerups/orb/b_orb.md3" );
ADDRGP4 $1346
ARGP4
ADDRLP4 508
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+751220+76
ADDRLP4 508
INDIRI4
ASGNI4
line 1803
;1803:		cgs.media.redCubeIcon = trap_R_RegisterShader( "icons/skull_red" );
ADDRGP4 $1349
ARGP4
ADDRLP4 512
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+80
ADDRLP4 512
INDIRI4
ASGNI4
line 1804
;1804:		cgs.media.blueCubeIcon = trap_R_RegisterShader( "icons/skull_blue" );
ADDRGP4 $1352
ARGP4
ADDRLP4 516
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+84
ADDRLP4 516
INDIRI4
ASGNI4
line 1805
;1805:	}
LABELV $1336
line 1810
;1806:
;1807:#ifdef MISSIONPACK
;1808:	if ( cgs.gametype == GT_CTF || cgs.gametype == GT_1FCTF || cgs.gametype == GT_HARVESTER || cg_buildScript.integer ) {
;1809:#else
;1810:	if ( cgs.gametype == GT_CTF || cg_buildScript.integer ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
EQI4 $1357
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $1353
LABELV $1357
line 1812
;1811:#endif
;1812:		cgs.media.redFlagModel = trap_R_RegisterModel( "models/flags/r_flag.md3" );
ADDRGP4 $1360
ARGP4
ADDRLP4 504
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+751220+88
ADDRLP4 504
INDIRI4
ASGNI4
line 1813
;1813:		cgs.media.blueFlagModel = trap_R_RegisterModel( "models/flags/b_flag.md3" );
ADDRGP4 $1363
ARGP4
ADDRLP4 508
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+751220+92
ADDRLP4 508
INDIRI4
ASGNI4
line 1814
;1814:		cgs.media.redFlagShader[0] = trap_R_RegisterShaderNoMip( "icons/iconf_red1" );
ADDRGP4 $1366
ARGP4
ADDRLP4 512
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+751220+100
ADDRLP4 512
INDIRI4
ASGNI4
line 1815
;1815:		cgs.media.redFlagShader[1] = trap_R_RegisterShaderNoMip( "icons/iconf_red2" );
ADDRGP4 $1370
ARGP4
ADDRLP4 516
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+751220+100+4
ADDRLP4 516
INDIRI4
ASGNI4
line 1816
;1816:		cgs.media.redFlagShader[2] = trap_R_RegisterShaderNoMip( "icons/iconf_red3" );
ADDRGP4 $1374
ARGP4
ADDRLP4 520
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+751220+100+8
ADDRLP4 520
INDIRI4
ASGNI4
line 1817
;1817:		cgs.media.blueFlagShader[0] = trap_R_RegisterShaderNoMip( "icons/iconf_blu1" );
ADDRGP4 $1377
ARGP4
ADDRLP4 524
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+751220+112
ADDRLP4 524
INDIRI4
ASGNI4
line 1818
;1818:		cgs.media.blueFlagShader[1] = trap_R_RegisterShaderNoMip( "icons/iconf_blu2" );
ADDRGP4 $1381
ARGP4
ADDRLP4 528
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+751220+112+4
ADDRLP4 528
INDIRI4
ASGNI4
line 1819
;1819:		cgs.media.blueFlagShader[2] = trap_R_RegisterShaderNoMip( "icons/iconf_blu3" );
ADDRGP4 $1385
ARGP4
ADDRLP4 532
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+751220+112+8
ADDRLP4 532
INDIRI4
ASGNI4
line 1832
;1820:#ifdef MISSIONPACK
;1821:		cgs.media.flagPoleModel = trap_R_RegisterModel( "models/flag2/flagpole.md3" );
;1822:		cgs.media.flagFlapModel = trap_R_RegisterModel( "models/flag2/flagflap3.md3" );
;1823:
;1824:		cgs.media.redFlagFlapSkin = trap_R_RegisterSkin( "models/flag2/red.skin" );
;1825:		cgs.media.blueFlagFlapSkin = trap_R_RegisterSkin( "models/flag2/blue.skin" );
;1826:		cgs.media.neutralFlagFlapSkin = trap_R_RegisterSkin( "models/flag2/white.skin" );
;1827:
;1828:		cgs.media.redFlagBaseModel = trap_R_RegisterModel( "models/mapobjects/flagbase/red_base.md3" );
;1829:		cgs.media.blueFlagBaseModel = trap_R_RegisterModel( "models/mapobjects/flagbase/blue_base.md3" );
;1830:		cgs.media.neutralFlagBaseModel = trap_R_RegisterModel( "models/mapobjects/flagbase/ntrl_base.md3" );
;1831:#endif
;1832:	}
LABELV $1353
line 1861
;1833:
;1834:#ifdef MISSIONPACK
;1835:	if ( cgs.gametype == GT_1FCTF || cg_buildScript.integer ) {
;1836:		cgs.media.neutralFlagModel = trap_R_RegisterModel( "models/flags/n_flag.md3" );
;1837:		cgs.media.flagShader[0] = trap_R_RegisterShaderNoMip( "icons/iconf_neutral1" );
;1838:		cgs.media.flagShader[1] = trap_R_RegisterShaderNoMip( "icons/iconf_red2" );
;1839:		cgs.media.flagShader[2] = trap_R_RegisterShaderNoMip( "icons/iconf_blu2" );
;1840:		cgs.media.flagShader[3] = trap_R_RegisterShaderNoMip( "icons/iconf_neutral3" );
;1841:	}
;1842:
;1843:	if ( cgs.gametype == GT_OBELISK || cg_buildScript.integer ) {
;1844:		cgs.media.overloadBaseModel = trap_R_RegisterModel( "models/powerups/overload_base.md3" );
;1845:		cgs.media.overloadTargetModel = trap_R_RegisterModel( "models/powerups/overload_target.md3" );
;1846:		cgs.media.overloadLightsModel = trap_R_RegisterModel( "models/powerups/overload_lights.md3" );
;1847:		cgs.media.overloadEnergyModel = trap_R_RegisterModel( "models/powerups/overload_energy.md3" );
;1848:	}
;1849:
;1850:	if ( cgs.gametype == GT_HARVESTER || cg_buildScript.integer ) {
;1851:		cgs.media.harvesterModel = trap_R_RegisterModel( "models/powerups/harvester/harvester.md3" );
;1852:		cgs.media.harvesterRedSkin = trap_R_RegisterSkin( "models/powerups/harvester/red.skin" );
;1853:		cgs.media.harvesterBlueSkin = trap_R_RegisterSkin( "models/powerups/harvester/blue.skin" );
;1854:		cgs.media.harvesterNeutralModel = trap_R_RegisterModel( "models/powerups/obelisk/obelisk.md3" );
;1855:	}
;1856:
;1857:	cgs.media.redKamikazeShader = trap_R_RegisterShader( "models/weaphits/kamikred" );
;1858:	cgs.media.dustPuffShader = trap_R_RegisterShader("hasteSmokePuff" );
;1859:#endif
;1860:
;1861:	if ( cgs.gametype >= GT_TEAM || cg_buildScript.integer ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
GEI4 $1390
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $1386
LABELV $1390
line 1862
;1862:		cgs.media.friendShader = trap_R_RegisterShader( "sprites/foe" );
ADDRGP4 $1393
ARGP4
ADDRLP4 504
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+368
ADDRLP4 504
INDIRI4
ASGNI4
line 1863
;1863:		cgs.media.redQuadShader = trap_R_RegisterShader("powerups/blueflag" );
ADDRGP4 $1396
ARGP4
ADDRLP4 508
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+608
ADDRLP4 508
INDIRI4
ASGNI4
line 1864
;1864:		cgs.media.teamStatusBar = trap_R_RegisterShader( "gfx/2d/colorbar.tga" );
ADDRGP4 $1399
ARGP4
ADDRLP4 512
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+180
ADDRLP4 512
INDIRI4
ASGNI4
line 1868
;1865:#ifdef MISSIONPACK
;1866:		cgs.media.blueKamikazeShader = trap_R_RegisterShader( "models/weaphits/kamikblu" );
;1867:#endif
;1868:		cgs.media.blueInvis = trap_R_RegisterShader("powerups/blueInvis");	// JUHOX
ADDRGP4 $1402
ARGP4
ADDRLP4 516
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+652
ADDRLP4 516
INDIRI4
ASGNI4
line 1869
;1869:		cgs.media.redInvis = trap_R_RegisterShader("powerups/redInvis");	// JUHOX
ADDRGP4 $1405
ARGP4
ADDRLP4 520
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+656
ADDRLP4 520
INDIRI4
ASGNI4
line 1870
;1870:	}
LABELV $1386
line 1874
;1871:
;1872:	// JUHOX: load friend shader for monster launcher
;1873:#if MONSTER_MODE
;1874:	if (cgs.gametype < GT_TEAM && cgs.monsterLauncher && !cgs.media.friendShader) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
GEI4 $1406
ADDRGP4 cgs+31852
INDIRI4
CNSTI4 0
EQI4 $1406
ADDRGP4 cgs+751220+368
INDIRI4
CNSTI4 0
NEI4 $1406
line 1875
;1875:		cgs.media.friendShader = trap_R_RegisterShader("sprites/foe");
ADDRGP4 $1393
ARGP4
ADDRLP4 504
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+368
ADDRLP4 504
INDIRI4
ASGNI4
line 1876
;1876:	}
LABELV $1406
line 1879
;1877:#endif
;1878:
;1879:	cgs.media.armorModel = trap_R_RegisterModel( "models/powerups/armor/armor_yel.md3" );
ADDRGP4 $1416
ARGP4
ADDRLP4 504
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+751220+172
ADDRLP4 504
INDIRI4
ASGNI4
line 1880
;1880:	cgs.media.armorIcon  = trap_R_RegisterShaderNoMip( "icons/iconr_yellow" );
ADDRGP4 $1419
ARGP4
ADDRLP4 508
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+751220+176
ADDRLP4 508
INDIRI4
ASGNI4
line 1882
;1881:
;1882:	cgs.media.machinegunBrassModel = trap_R_RegisterModel( "models/weapons2/shells/m_shell.md3" );
ADDRGP4 $1422
ARGP4
ADDRLP4 512
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+751220+236
ADDRLP4 512
INDIRI4
ASGNI4
line 1883
;1883:	cgs.media.shotgunBrassModel = trap_R_RegisterModel( "models/weapons2/shells/s_shell.md3" );
ADDRGP4 $1425
ARGP4
ADDRLP4 516
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+751220+240
ADDRLP4 516
INDIRI4
ASGNI4
line 1885
;1884:
;1885:	cgs.media.gibAbdomen = trap_R_RegisterModel( "models/gibs/abdomen.md3" );
ADDRGP4 $1428
ARGP4
ADDRLP4 520
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+751220+188
ADDRLP4 520
INDIRI4
ASGNI4
line 1886
;1886:	cgs.media.gibArm = trap_R_RegisterModel( "models/gibs/arm.md3" );
ADDRGP4 $1431
ARGP4
ADDRLP4 524
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+751220+192
ADDRLP4 524
INDIRI4
ASGNI4
line 1887
;1887:	cgs.media.gibChest = trap_R_RegisterModel( "models/gibs/chest.md3" );
ADDRGP4 $1434
ARGP4
ADDRLP4 528
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+751220+196
ADDRLP4 528
INDIRI4
ASGNI4
line 1888
;1888:	cgs.media.gibFist = trap_R_RegisterModel( "models/gibs/fist.md3" );
ADDRGP4 $1437
ARGP4
ADDRLP4 532
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+751220+200
ADDRLP4 532
INDIRI4
ASGNI4
line 1889
;1889:	cgs.media.gibFoot = trap_R_RegisterModel( "models/gibs/foot.md3" );
ADDRGP4 $1440
ARGP4
ADDRLP4 536
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+751220+204
ADDRLP4 536
INDIRI4
ASGNI4
line 1890
;1890:	cgs.media.gibForearm = trap_R_RegisterModel( "models/gibs/forearm.md3" );
ADDRGP4 $1443
ARGP4
ADDRLP4 540
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+751220+208
ADDRLP4 540
INDIRI4
ASGNI4
line 1891
;1891:	cgs.media.gibIntestine = trap_R_RegisterModel( "models/gibs/intestine.md3" );
ADDRGP4 $1446
ARGP4
ADDRLP4 544
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+751220+212
ADDRLP4 544
INDIRI4
ASGNI4
line 1892
;1892:	cgs.media.gibLeg = trap_R_RegisterModel( "models/gibs/leg.md3" );
ADDRGP4 $1449
ARGP4
ADDRLP4 548
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+751220+216
ADDRLP4 548
INDIRI4
ASGNI4
line 1893
;1893:	cgs.media.gibSkull = trap_R_RegisterModel( "models/gibs/skull.md3" );
ADDRGP4 $1452
ARGP4
ADDRLP4 552
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+751220+220
ADDRLP4 552
INDIRI4
ASGNI4
line 1894
;1894:	cgs.media.gibBrain = trap_R_RegisterModel( "models/gibs/brain.md3" );
ADDRGP4 $1455
ARGP4
ADDRLP4 556
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+751220+224
ADDRLP4 556
INDIRI4
ASGNI4
line 1897
;1895:	// JUHOX: load monster gibs shader
;1896:#if MONSTER_MODE
;1897:	if (cgs.gametype >= GT_STU || cgs.monsterLauncher) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 8
GEI4 $1460
ADDRGP4 cgs+31852
INDIRI4
CNSTI4 0
EQI4 $1456
LABELV $1460
line 1898
;1898:		cgs.media.monsterGibsShader = trap_R_RegisterShader("models/gibs/monstergibs.tga");
ADDRGP4 $1463
ARGP4
ADDRLP4 560
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+228
ADDRLP4 560
INDIRI4
ASGNI4
line 1899
;1899:	}
LABELV $1456
line 1902
;1900:#endif
;1901:
;1902:	cgs.media.smoke2 = trap_R_RegisterModel( "models/weapons2/shells/s_shell.md3" );
ADDRGP4 $1425
ARGP4
ADDRLP4 560
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+751220+232
ADDRLP4 560
INDIRI4
ASGNI4
line 1904
;1903:
;1904:	cgs.media.balloonShader = trap_R_RegisterShader( "sprites/balloon3" );
ADDRGP4 $1468
ARGP4
ADDRLP4 564
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+372
ADDRLP4 564
INDIRI4
ASGNI4
line 1906
;1905:
;1906:	cgs.media.bloodExplosionShader = trap_R_RegisterShader( "bloodExplosion" );
ADDRGP4 $1471
ARGP4
ADDRLP4 568
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+716
ADDRLP4 568
INDIRI4
ASGNI4
line 1908
;1907:
;1908:	cgs.media.bulletFlashModel = trap_R_RegisterModel("models/weaphits/bullet.md3");
ADDRGP4 $1474
ARGP4
ADDRLP4 572
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+751220+676
ADDRLP4 572
INDIRI4
ASGNI4
line 1909
;1909:	cgs.media.ringFlashModel = trap_R_RegisterModel("models/weaphits/ring02.md3");
ADDRGP4 $1477
ARGP4
ADDRLP4 576
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+751220+680
ADDRLP4 576
INDIRI4
ASGNI4
line 1910
;1910:	cgs.media.dishFlashModel = trap_R_RegisterModel("models/weaphits/boom01.md3");
ADDRGP4 $1480
ARGP4
ADDRLP4 580
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+751220+684
ADDRLP4 580
INDIRI4
ASGNI4
line 1914
;1911:#ifdef MISSIONPACK
;1912:	cgs.media.teleportEffectModel = trap_R_RegisterModel( "models/powerups/pop.md3" );
;1913:#else
;1914:	cgs.media.teleportEffectModel = trap_R_RegisterModel( "models/misc/telep.md3" );
ADDRGP4 $1483
ARGP4
ADDRLP4 584
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+751220+728
ADDRLP4 584
INDIRI4
ASGNI4
line 1915
;1915:	cgs.media.teleportEffectShader = trap_R_RegisterShader( "teleportEffect" );
ADDRGP4 $1486
ARGP4
ADDRLP4 588
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+732
ADDRLP4 588
INDIRI4
ASGNI4
line 1933
;1916:#endif
;1917:#ifdef MISSIONPACK
;1918:	cgs.media.kamikazeEffectModel = trap_R_RegisterModel( "models/weaphits/kamboom2.md3" );
;1919:	cgs.media.kamikazeShockWave = trap_R_RegisterModel( "models/weaphits/kamwave.md3" );
;1920:	cgs.media.kamikazeHeadModel = trap_R_RegisterModel( "models/powerups/kamikazi.md3" );
;1921:	cgs.media.kamikazeHeadTrail = trap_R_RegisterModel( "models/powerups/trailtest.md3" );
;1922:	cgs.media.guardPowerupModel = trap_R_RegisterModel( "models/powerups/guard_player.md3" );
;1923:	cgs.media.scoutPowerupModel = trap_R_RegisterModel( "models/powerups/scout_player.md3" );
;1924:	cgs.media.doublerPowerupModel = trap_R_RegisterModel( "models/powerups/doubler_player.md3" );
;1925:	cgs.media.ammoRegenPowerupModel = trap_R_RegisterModel( "models/powerups/ammo_player.md3" );
;1926:	cgs.media.invulnerabilityImpactModel = trap_R_RegisterModel( "models/powerups/shield/impact.md3" );
;1927:	cgs.media.invulnerabilityJuicedModel = trap_R_RegisterModel( "models/powerups/shield/juicer.md3" );
;1928:	cgs.media.medkitUsageModel = trap_R_RegisterModel( "models/powerups/regen.md3" );
;1929:	cgs.media.heartShader = trap_R_RegisterShaderNoMip( "ui/assets/statusbar/selectedhealth.tga" );
;1930:
;1931:#endif
;1932:
;1933:	cgs.media.invulnerabilityPowerupModel = trap_R_RegisterModel( "models/powerups/shield/shield.md3" );
ADDRGP4 $1489
ARGP4
ADDRLP4 592
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+751220+736
ADDRLP4 592
INDIRI4
ASGNI4
line 1934
;1934:	cgs.media.medalImpressive = trap_R_RegisterShaderNoMip( "medal_impressive" );
ADDRGP4 $1492
ARGP4
ADDRLP4 596
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+751220+756
ADDRLP4 596
INDIRI4
ASGNI4
line 1935
;1935:	cgs.media.medalExcellent = trap_R_RegisterShaderNoMip( "medal_excellent" );
ADDRGP4 $1495
ARGP4
ADDRLP4 600
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+751220+760
ADDRLP4 600
INDIRI4
ASGNI4
line 1936
;1936:	cgs.media.medalGauntlet = trap_R_RegisterShaderNoMip( "medal_gauntlet" );
ADDRGP4 $1498
ARGP4
ADDRLP4 604
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+751220+764
ADDRLP4 604
INDIRI4
ASGNI4
line 1937
;1937:	cgs.media.medalDefend = trap_R_RegisterShaderNoMip( "medal_defend" );
ADDRGP4 $1501
ARGP4
ADDRLP4 608
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+751220+768
ADDRLP4 608
INDIRI4
ASGNI4
line 1938
;1938:	cgs.media.medalAssist = trap_R_RegisterShaderNoMip( "medal_assist" );
ADDRGP4 $1504
ARGP4
ADDRLP4 612
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+751220+772
ADDRLP4 612
INDIRI4
ASGNI4
line 1939
;1939:	cgs.media.medalCapture = trap_R_RegisterShaderNoMip( "medal_capture" );
ADDRGP4 $1507
ARGP4
ADDRLP4 616
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+751220+776
ADDRLP4 616
INDIRI4
ASGNI4
line 1943
;1940:
;1941:	// JUHOX: load group mark sprites
;1942:#if 1
;1943:	cgs.media.groupDesignated = trap_R_RegisterShader("tssgroupDesignated");
ADDRGP4 $1510
ARGP4
ADDRLP4 620
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+784
ADDRLP4 620
INDIRI4
ASGNI4
line 1944
;1944:	cgs.media.groupTemporary = trap_R_RegisterShader("tssgroupTemporary");
ADDRGP4 $1513
ARGP4
ADDRLP4 624
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+780
ADDRLP4 624
INDIRI4
ASGNI4
line 1945
;1945:	for (i = 0; i < MAX_GROUPS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1514
line 1948
;1946:		char name[32];
;1947:
;1948:		Com_sprintf(name, sizeof(name), "tssgroup%c", i + 'A');
ADDRLP4 628
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $1518
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 65
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1949
;1949:		cgs.media.groupMarks[i] = trap_R_RegisterShader(name);
ADDRLP4 628
ARGP4
ADDRLP4 660
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+751220+788
ADDP4
ADDRLP4 660
INDIRI4
ASGNI4
line 1950
;1950:	}
LABELV $1515
line 1945
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 10
LTI4 $1514
line 1953
;1951:#endif
;1952:
;1953:	memset( cg_items, 0, sizeof( cg_items ) );
ADDRGP4 cg_items
ARGP4
CNSTI4 0
ARGI4
CNSTI4 6144
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1954
;1954:	memset( cg_weapons, 0, sizeof( cg_weapons ) );
ADDRGP4 cg_weapons
ARGP4
CNSTI4 0
ARGI4
CNSTI4 2176
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1957
;1955:
;1956:	// only register the items that the server says we need
;1957:	strcpy( items, CG_ConfigString( CS_ITEMS) );
CNSTI4 27
ARGI4
ADDRLP4 628
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 4
ARGP4
ADDRLP4 628
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1959
;1958:
;1959:	for ( i = 1 ; i < bg_numItems ; i++ ) {
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $1524
JUMPV
LABELV $1521
line 1960
;1960:		if ( items[ i ] == '1' || cg_buildScript.integer ) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
INDIRI1
CVII4 1
CNSTI4 49
EQI4 $1528
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $1525
LABELV $1528
line 1961
;1961:			CG_LoadingItem( i );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_LoadingItem
CALLV
pop
line 1962
;1962:			CG_RegisterItemVisuals( i );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_RegisterItemVisuals
CALLV
pop
line 1963
;1963:		}
LABELV $1525
line 1964
;1964:	}
LABELV $1522
line 1959
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1524
ADDRLP4 0
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $1521
line 1967
;1965:
;1966:	// wall marks
;1967:	cgs.media.bulletMarkShader = trap_R_RegisterShader( "gfx/damage/bullet_mrk" );
ADDRGP4 $1531
ARGP4
ADDRLP4 632
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+588
ADDRLP4 632
INDIRI4
ASGNI4
line 1968
;1968:	cgs.media.burnMarkShader = trap_R_RegisterShader( "gfx/damage/burn_med_mrk" );
ADDRGP4 $1534
ARGP4
ADDRLP4 636
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+592
ADDRLP4 636
INDIRI4
ASGNI4
line 1969
;1969:	cgs.media.holeMarkShader = trap_R_RegisterShader( "gfx/damage/hole_lg_mrk" );
ADDRGP4 $1537
ARGP4
ADDRLP4 640
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+596
ADDRLP4 640
INDIRI4
ASGNI4
line 1970
;1970:	cgs.media.energyMarkShader = trap_R_RegisterShader( "gfx/damage/plasma_mrk" );
ADDRGP4 $1540
ARGP4
ADDRLP4 644
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+600
ADDRLP4 644
INDIRI4
ASGNI4
line 1971
;1971:	cgs.media.shadowMarkShader = trap_R_RegisterShader( "markShadow" );
ADDRGP4 $1543
ARGP4
ADDRLP4 648
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+552
ADDRLP4 648
INDIRI4
ASGNI4
line 1972
;1972:	cgs.media.wakeMarkShader = trap_R_RegisterShader( "wake" );
ADDRGP4 $1546
ARGP4
ADDRLP4 652
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+576
ADDRLP4 652
INDIRI4
ASGNI4
line 1973
;1973:	cgs.media.bloodMarkShader = trap_R_RegisterShader( "bloodMark" );
ADDRGP4 $1549
ARGP4
ADDRLP4 656
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+580
ADDRLP4 656
INDIRI4
ASGNI4
line 1974
;1974:	cgs.media.monsterBloodMarkShader = trap_R_RegisterShader("monsterBloodMark");	// JUHOX
ADDRGP4 $1552
ARGP4
ADDRLP4 660
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+584
ADDRLP4 660
INDIRI4
ASGNI4
line 1977
;1975:
;1976:	// register the inline models
;1977:	cgs.numInlineModels = trap_CM_NumInlineModels();
ADDRLP4 664
ADDRGP4 trap_CM_NumInlineModels
CALLI4
ASGNI4
ADDRGP4 cgs+37196
ADDRLP4 664
INDIRI4
ASGNI4
line 1978
;1978:	for ( i = 1 ; i < cgs.numInlineModels ; i++ ) {
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $1557
JUMPV
LABELV $1554
line 1983
;1979:		char	name[10];
;1980:		vec3_t			mins, maxs;
;1981:		int				j;
;1982:
;1983:		Com_sprintf( name, sizeof(name), "*%i", i );
ADDRLP4 696
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $1559
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1984
;1984:		cgs.inlineDrawModel[i] = trap_R_RegisterModel( name );
ADDRLP4 696
ARGP4
ADDRLP4 708
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+37200
ADDP4
ADDRLP4 708
INDIRI4
ASGNI4
line 1985
;1985:		trap_R_ModelBounds( cgs.inlineDrawModel[i], mins, maxs );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+37200
ADDP4
INDIRI4
ARGI4
ADDRLP4 672
ARGP4
ADDRLP4 684
ARGP4
ADDRGP4 trap_R_ModelBounds
CALLV
pop
line 1986
;1986:		for ( j = 0 ; j < 3 ; j++ ) {
ADDRLP4 668
CNSTI4 0
ASGNI4
LABELV $1562
line 1987
;1987:			cgs.inlineModelMidpoints[i][j] = mins[j] + 0.5 * ( maxs[j] - mins[j] );
ADDRLP4 668
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 cgs+38224
ADDP4
ADDP4
ADDRLP4 668
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 672
ADDP4
INDIRF4
ADDRLP4 668
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 684
ADDP4
INDIRF4
ADDRLP4 668
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 672
ADDP4
INDIRF4
SUBF4
CNSTF4 1056964608
MULF4
ADDF4
ASGNF4
line 1988
;1988:		}
LABELV $1563
line 1986
ADDRLP4 668
ADDRLP4 668
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 668
INDIRI4
CNSTI4 3
LTI4 $1562
line 1989
;1989:	}
LABELV $1555
line 1978
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1557
ADDRLP4 0
INDIRI4
ADDRGP4 cgs+37196
INDIRI4
LTI4 $1554
line 1992
;1990:
;1991:	// register all the server specified models
;1992:	for (i=1 ; i<MAX_MODELS ; i++) {
ADDRLP4 0
CNSTI4 1
ASGNI4
LABELV $1567
line 1995
;1993:		const char		*modelName;
;1994:
;1995:		modelName = CG_ConfigString( CS_MODELS+i );
ADDRLP4 0
INDIRI4
CNSTI4 32
ADDI4
ARGI4
ADDRLP4 672
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 668
ADDRLP4 672
INDIRP4
ASGNP4
line 1996
;1996:		if ( !modelName[0] ) {
ADDRLP4 668
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1571
line 1997
;1997:			break;
ADDRGP4 $1569
JUMPV
LABELV $1571
line 1999
;1998:		}
;1999:		cgs.gameModels[i] = trap_R_RegisterModel( modelName );
ADDRLP4 668
INDIRP4
ARGP4
ADDRLP4 676
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+35148
ADDP4
ADDRLP4 676
INDIRI4
ASGNI4
line 2000
;2000:	}
LABELV $1568
line 1992
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 256
LTI4 $1567
LABELV $1569
line 2028
;2001:
;2002:#ifdef MISSIONPACK
;2003:	// new stuff
;2004:	cgs.media.patrolShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/patrol.tga");
;2005:	cgs.media.assaultShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/assault.tga");
;2006:	cgs.media.campShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/camp.tga");
;2007:	cgs.media.followShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/follow.tga");
;2008:	cgs.media.defendShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/defend.tga");
;2009:	cgs.media.teamLeaderShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/team_leader.tga");
;2010:	cgs.media.retrieveShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/retrieve.tga");
;2011:	cgs.media.escortShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/escort.tga");
;2012:	cgs.media.cursor = trap_R_RegisterShaderNoMip( "menu/art/3_cursor2" );
;2013:	cgs.media.sizeCursor = trap_R_RegisterShaderNoMip( "ui/assets/sizecursor.tga" );
;2014:	cgs.media.selectCursor = trap_R_RegisterShaderNoMip( "ui/assets/selectcursor.tga" );
;2015:	cgs.media.flagShaders[0] = trap_R_RegisterShaderNoMip("ui/assets/statusbar/flag_in_base.tga");
;2016:	cgs.media.flagShaders[1] = trap_R_RegisterShaderNoMip("ui/assets/statusbar/flag_capture.tga");
;2017:	cgs.media.flagShaders[2] = trap_R_RegisterShaderNoMip("ui/assets/statusbar/flag_missing.tga");
;2018:
;2019:	trap_R_RegisterModel( "models/players/james/lower.md3" );
;2020:	trap_R_RegisterModel( "models/players/james/upper.md3" );
;2021:	trap_R_RegisterModel( "models/players/heads/james/james.md3" );
;2022:
;2023:	trap_R_RegisterModel( "models/players/janet/lower.md3" );
;2024:	trap_R_RegisterModel( "models/players/janet/upper.md3" );
;2025:	trap_R_RegisterModel( "models/players/heads/janet/janet.md3" );
;2026:
;2027:#endif
;2028:	CG_ClearParticles ();
ADDRGP4 CG_ClearParticles
CALLV
pop
line 2041
;2029:/*
;2030:	for (i=1; i<MAX_PARTICLES_AREAS; i++)
;2031:	{
;2032:		{
;2033:			int rval;
;2034:
;2035:			rval = CG_NewParticleArea ( CS_PARTICLES + i);
;2036:			if (!rval)
;2037:				break;
;2038:		}
;2039:	}
;2040:*/
;2041:}
LABELV $1068
endproc CG_RegisterGraphics 716 16
export CG_BuildSpectatorString
proc CG_BuildSpectatorString 12 12
line 2051
;2042:
;2043:
;2044:
;2045:/*
;2046:=======================
;2047:CG_BuildSpectatorString
;2048:
;2049:=======================
;2050:*/
;2051:void CG_BuildSpectatorString() {
line 2053
;2052:	int i;
;2053:	cg.spectatorList[0] = 0;
ADDRGP4 cg+117668
CNSTI1 0
ASGNI1
line 2054
;2054:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1576
line 2055
;2055:		if (cgs.clientinfo[i].infoValid && cgs.clientinfo[i].team == TEAM_SPECTATOR ) {
ADDRLP4 0
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1580
ADDRLP4 0
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320+68
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1580
line 2056
;2056:			Q_strcat(cg.spectatorList, sizeof(cg.spectatorList), va("%s     ", cgs.clientinfo[i].name));
ADDRGP4 $1587
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320+4
ADDP4
ARGP4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 cg+117668
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 2057
;2057:		}
LABELV $1580
line 2058
;2058:	}
LABELV $1577
line 2054
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $1576
line 2059
;2059:	i = strlen(cg.spectatorList);
ADDRGP4 cg+117668
ARGP4
ADDRLP4 4
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 2060
;2060:	if (i != cg.spectatorLen) {
ADDRLP4 0
INDIRI4
ADDRGP4 cg+118692
INDIRI4
EQI4 $1591
line 2061
;2061:		cg.spectatorLen = i;
ADDRGP4 cg+118692
ADDRLP4 0
INDIRI4
ASGNI4
line 2062
;2062:		cg.spectatorWidth = -1;
ADDRGP4 cg+118696
CNSTF4 3212836864
ASGNF4
line 2063
;2063:	}
LABELV $1591
line 2064
;2064:}
LABELV $1574
endproc CG_BuildSpectatorString 12 12
proc CG_RegisterClients 12 4
line 2072
;2065:
;2066:
;2067:/*
;2068:===================
;2069:CG_RegisterClients
;2070:===================
;2071:*/
;2072:static void CG_RegisterClients( void ) {
line 2077
;2073:	int		i;
;2074:
;2075:	// JUHOX: don't load client models in lens flare editor
;2076:#if MAPLENSFLARES
;2077:	if (cgs.editMode == EM_mlf) return;
ADDRGP4 cgs+31684
INDIRI4
CNSTI4 1
NEI4 $1597
ADDRGP4 $1596
JUMPV
LABELV $1597
line 2080
;2078:#endif
;2079:
;2080:	CG_LoadingClient(cg.clientNum);
ADDRGP4 cg+4
INDIRI4
ARGI4
ADDRGP4 CG_LoadingClient
CALLV
pop
line 2081
;2081:	CG_NewClientInfo(cg.clientNum);
ADDRGP4 cg+4
INDIRI4
ARGI4
ADDRGP4 CG_NewClientInfo
CALLV
pop
line 2085
;2082:
;2083:	// JUHOX: load monster
;2084:#if MONSTER_MODE
;2085:	if (cgs.gametype >= GT_STU) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 8
LTI4 $1602
line 2086
;2086:		CG_InitMonsterClientInfo(CLIENTNUM_MONSTER_PREDATOR);
CNSTI4 64
ARGI4
ADDRGP4 CG_InitMonsterClientInfo
CALLV
pop
line 2087
;2087:		CG_InitMonsterClientInfo(CLIENTNUM_MONSTER_GUARD);
CNSTI4 65
ARGI4
ADDRGP4 CG_InitMonsterClientInfo
CALLV
pop
line 2088
;2088:		CG_InitMonsterClientInfo(CLIENTNUM_MONSTER_TITAN);
CNSTI4 66
ARGI4
ADDRGP4 CG_InitMonsterClientInfo
CALLV
pop
line 2089
;2089:	}
ADDRGP4 $1603
JUMPV
LABELV $1602
line 2090
;2090:	else if (cgs.monsterLauncher) {
ADDRGP4 cgs+31852
INDIRI4
CNSTI4 0
EQI4 $1605
line 2091
;2091:		if (cgs.gametype < GT_TEAM) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
GEI4 $1608
line 2092
;2092:			CG_InitMonsterClientInfo(CLIENTNUM_MONSTER_PREDATOR);
CNSTI4 64
ARGI4
ADDRGP4 CG_InitMonsterClientInfo
CALLV
pop
line 2093
;2093:		}
ADDRGP4 $1609
JUMPV
LABELV $1608
line 2094
;2094:		else {
line 2095
;2095:			CG_InitMonsterClientInfo(CLIENTNUM_MONSTER_PREDATOR_RED);
CNSTI4 67
ARGI4
ADDRGP4 CG_InitMonsterClientInfo
CALLV
pop
line 2096
;2096:			CG_InitMonsterClientInfo(CLIENTNUM_MONSTER_PREDATOR_BLUE);
CNSTI4 68
ARGI4
ADDRGP4 CG_InitMonsterClientInfo
CALLV
pop
line 2097
;2097:		}
LABELV $1609
line 2098
;2098:	}
LABELV $1605
LABELV $1603
line 2101
;2099:#endif
;2100:
;2101:	for (i=0 ; i<MAX_CLIENTS ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1611
line 2104
;2102:		const char		*clientInfo;
;2103:
;2104:		if (cg.clientNum == i) {
ADDRGP4 cg+4
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $1615
line 2105
;2105:			continue;
ADDRGP4 $1612
JUMPV
LABELV $1615
line 2108
;2106:		}
;2107:
;2108:		clientInfo = CG_ConfigString( CS_PLAYERS+i );
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 8
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 2109
;2109:		if ( !clientInfo[0]) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1618
line 2110
;2110:			continue;
ADDRGP4 $1612
JUMPV
LABELV $1618
line 2112
;2111:		}
;2112:		CG_LoadingClient( i );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_LoadingClient
CALLV
pop
line 2113
;2113:		CG_NewClientInfo( i );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_NewClientInfo
CALLV
pop
line 2114
;2114:	}
LABELV $1612
line 2101
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $1611
line 2115
;2115:	CG_BuildSpectatorString();
ADDRGP4 CG_BuildSpectatorString
CALLV
pop
line 2116
;2116:}
LABELV $1596
endproc CG_RegisterClients 12 4
export CG_ConfigString
proc CG_ConfigString 4 8
line 2125
;2117:
;2118://===========================================================================
;2119:
;2120:/*
;2121:=================
;2122:CG_ConfigString
;2123:=================
;2124:*/
;2125:const char *CG_ConfigString( int index ) {
line 2126
;2126:	if ( index < 0 || index >= MAX_CONFIGSTRINGS ) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1623
ADDRLP4 0
INDIRI4
CNSTI4 1024
LTI4 $1621
LABELV $1623
line 2127
;2127:		CG_Error( "CG_ConfigString: bad index: %i", index );
ADDRGP4 $1624
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 2128
;2128:	}
LABELV $1621
line 2129
;2129:	return cgs.gameState.stringData + cgs.gameState.stringOffsets[ index ];
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs
ADDP4
INDIRI4
ADDRGP4 cgs+4096
ADDP4
RETP4
LABELV $1620
endproc CG_ConfigString 4 8
export CG_StartMusic
proc CG_StartMusic 148 12
line 2140
;2130:}
;2131:
;2132://==================================================================
;2133:
;2134:/*
;2135:======================
;2136:CG_StartMusic
;2137:
;2138:======================
;2139:*/
;2140:void CG_StartMusic( void ) {
line 2146
;2141:	char	*s;
;2142:	char	parm1[MAX_QPATH], parm2[MAX_QPATH];
;2143:
;2144:	// JUHOX: check type of music
;2145:#if PLAYLIST
;2146:	switch (cg_music.integer) {
ADDRLP4 132
ADDRGP4 cg_music+12
INDIRI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 0
EQI4 $1630
ADDRLP4 132
INDIRI4
CNSTI4 1
EQI4 $1631
ADDRLP4 132
INDIRI4
CNSTI4 2
EQI4 $1632
ADDRGP4 $1627
JUMPV
LABELV $1630
LABELV $1627
line 2149
;2147:	case 0:	// no music
;2148:	default:
;2149:		CG_StopPlayList();	// also stops any other music
ADDRGP4 CG_StopPlayList
CALLV
pop
line 2150
;2150:		return;
ADDRGP4 $1626
JUMPV
LABELV $1631
line 2152
;2151:	case 1:	// default music
;2152:		CG_StopPlayList();
ADDRGP4 CG_StopPlayList
CALLV
pop
line 2153
;2153:		break;
ADDRGP4 $1628
JUMPV
LABELV $1632
line 2155
;2154:	case 2:	// play list
;2155:		CG_ContinuePlayList();
ADDRGP4 CG_ContinuePlayList
CALLV
pop
line 2156
;2156:		return;
ADDRGP4 $1626
JUMPV
LABELV $1628
line 2161
;2157:	}
;2158:#endif
;2159:
;2160:	// start the background music
;2161:	s = (char *)CG_ConfigString( CS_MUSIC );
CNSTI4 2
ARGI4
ADDRLP4 136
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 136
INDIRP4
ASGNP4
line 2162
;2162:	Q_strncpyz( parm1, COM_Parse( &s ), sizeof( parm1 ) );
ADDRLP4 0
ARGP4
ADDRLP4 140
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 4
ARGP4
ADDRLP4 140
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 2163
;2163:	Q_strncpyz( parm2, COM_Parse( &s ), sizeof( parm2 ) );
ADDRLP4 0
ARGP4
ADDRLP4 144
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 68
ARGP4
ADDRLP4 144
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 2165
;2164:
;2165:	trap_S_StartBackgroundTrack( parm1, parm2 );
ADDRLP4 4
ARGP4
ADDRLP4 68
ARGP4
ADDRGP4 trap_S_StartBackgroundTrack
CALLV
pop
line 2166
;2166:}
LABELV $1626
endproc CG_StartMusic 148 12
export CG_Init
proc CG_Init 88 16
line 2869
;2167:#ifdef MISSIONPACK
;2168:char *CG_GetMenuBuffer(const char *filename) {
;2169:	int	len;
;2170:	fileHandle_t	f;
;2171:	static char buf[MAX_MENUFILE];
;2172:
;2173:	len = trap_FS_FOpenFile( filename, &f, FS_READ );
;2174:	if ( !f ) {
;2175:		trap_Print( va( S_COLOR_RED "menu file not found: %s, using default\n", filename ) );
;2176:		return NULL;
;2177:	}
;2178:	if ( len >= MAX_MENUFILE ) {
;2179:		trap_Print( va( S_COLOR_RED "menu file too large: %s is %i, max allowed is %i", filename, len, MAX_MENUFILE ) );
;2180:		trap_FS_FCloseFile( f );
;2181:		return NULL;
;2182:	}
;2183:
;2184:	trap_FS_Read( buf, len, f );
;2185:	buf[len] = 0;
;2186:	trap_FS_FCloseFile( f );
;2187:
;2188:	return buf;
;2189:}
;2190:
;2191://
;2192:// ==============================
;2193:// new hud stuff ( mission pack )
;2194:// ==============================
;2195://
;2196:qboolean CG_Asset_Parse(int handle) {
;2197:	pc_token_t token;
;2198:	const char *tempStr;
;2199:
;2200:	if (!trap_PC_ReadToken(handle, &token))
;2201:		return qfalse;
;2202:	if (Q_stricmp(token.string, "{") != 0) {
;2203:		return qfalse;
;2204:	}
;2205:
;2206:	while ( 1 ) {
;2207:		if (!trap_PC_ReadToken(handle, &token))
;2208:			return qfalse;
;2209:
;2210:		if (Q_stricmp(token.string, "}") == 0) {
;2211:			return qtrue;
;2212:		}
;2213:
;2214:		// font
;2215:		if (Q_stricmp(token.string, "font") == 0) {
;2216:			int pointSize;
;2217:			if (!PC_String_Parse(handle, &tempStr) || !PC_Int_Parse(handle, &pointSize)) {
;2218:				return qfalse;
;2219:			}
;2220:			cgDC.registerFont(tempStr, pointSize, &cgDC.Assets.textFont);
;2221:			continue;
;2222:		}
;2223:
;2224:		// smallFont
;2225:		if (Q_stricmp(token.string, "smallFont") == 0) {
;2226:			int pointSize;
;2227:			if (!PC_String_Parse(handle, &tempStr) || !PC_Int_Parse(handle, &pointSize)) {
;2228:				return qfalse;
;2229:			}
;2230:			cgDC.registerFont(tempStr, pointSize, &cgDC.Assets.smallFont);
;2231:			continue;
;2232:		}
;2233:
;2234:		// font
;2235:		if (Q_stricmp(token.string, "bigfont") == 0) {
;2236:			int pointSize;
;2237:			if (!PC_String_Parse(handle, &tempStr) || !PC_Int_Parse(handle, &pointSize)) {
;2238:				return qfalse;
;2239:			}
;2240:			cgDC.registerFont(tempStr, pointSize, &cgDC.Assets.bigFont);
;2241:			continue;
;2242:		}
;2243:
;2244:		// gradientbar
;2245:		if (Q_stricmp(token.string, "gradientbar") == 0) {
;2246:			if (!PC_String_Parse(handle, &tempStr)) {
;2247:				return qfalse;
;2248:			}
;2249:			cgDC.Assets.gradientBar = trap_R_RegisterShaderNoMip(tempStr);
;2250:			continue;
;2251:		}
;2252:
;2253:		// enterMenuSound
;2254:		if (Q_stricmp(token.string, "menuEnterSound") == 0) {
;2255:			if (!PC_String_Parse(handle, &tempStr)) {
;2256:				return qfalse;
;2257:			}
;2258:			cgDC.Assets.menuEnterSound = trap_S_RegisterSound( tempStr, qfalse );
;2259:			continue;
;2260:		}
;2261:
;2262:		// exitMenuSound
;2263:		if (Q_stricmp(token.string, "menuExitSound") == 0) {
;2264:			if (!PC_String_Parse(handle, &tempStr)) {
;2265:				return qfalse;
;2266:			}
;2267:			cgDC.Assets.menuExitSound = trap_S_RegisterSound( tempStr, qfalse );
;2268:			continue;
;2269:		}
;2270:
;2271:		// itemFocusSound
;2272:		if (Q_stricmp(token.string, "itemFocusSound") == 0) {
;2273:			if (!PC_String_Parse(handle, &tempStr)) {
;2274:				return qfalse;
;2275:			}
;2276:			cgDC.Assets.itemFocusSound = trap_S_RegisterSound( tempStr, qfalse );
;2277:			continue;
;2278:		}
;2279:
;2280:		// menuBuzzSound
;2281:		if (Q_stricmp(token.string, "menuBuzzSound") == 0) {
;2282:			if (!PC_String_Parse(handle, &tempStr)) {
;2283:				return qfalse;
;2284:			}
;2285:			cgDC.Assets.menuBuzzSound = trap_S_RegisterSound( tempStr, qfalse );
;2286:			continue;
;2287:		}
;2288:
;2289:		if (Q_stricmp(token.string, "cursor") == 0) {
;2290:			if (!PC_String_Parse(handle, &cgDC.Assets.cursorStr)) {
;2291:				return qfalse;
;2292:			}
;2293:			cgDC.Assets.cursor = trap_R_RegisterShaderNoMip( cgDC.Assets.cursorStr);
;2294:			continue;
;2295:		}
;2296:
;2297:		if (Q_stricmp(token.string, "fadeClamp") == 0) {
;2298:			if (!PC_Float_Parse(handle, &cgDC.Assets.fadeClamp)) {
;2299:				return qfalse;
;2300:			}
;2301:			continue;
;2302:		}
;2303:
;2304:		if (Q_stricmp(token.string, "fadeCycle") == 0) {
;2305:			if (!PC_Int_Parse(handle, &cgDC.Assets.fadeCycle)) {
;2306:				return qfalse;
;2307:			}
;2308:			continue;
;2309:		}
;2310:
;2311:		if (Q_stricmp(token.string, "fadeAmount") == 0) {
;2312:			if (!PC_Float_Parse(handle, &cgDC.Assets.fadeAmount)) {
;2313:				return qfalse;
;2314:			}
;2315:			continue;
;2316:		}
;2317:
;2318:		if (Q_stricmp(token.string, "shadowX") == 0) {
;2319:			if (!PC_Float_Parse(handle, &cgDC.Assets.shadowX)) {
;2320:				return qfalse;
;2321:			}
;2322:			continue;
;2323:		}
;2324:
;2325:		if (Q_stricmp(token.string, "shadowY") == 0) {
;2326:			if (!PC_Float_Parse(handle, &cgDC.Assets.shadowY)) {
;2327:				return qfalse;
;2328:			}
;2329:			continue;
;2330:		}
;2331:
;2332:		if (Q_stricmp(token.string, "shadowColor") == 0) {
;2333:			if (!PC_Color_Parse(handle, &cgDC.Assets.shadowColor)) {
;2334:				return qfalse;
;2335:			}
;2336:			cgDC.Assets.shadowFadeClamp = cgDC.Assets.shadowColor[3];
;2337:			continue;
;2338:		}
;2339:	}
;2340:	return qfalse; // bk001204 - why not?
;2341:}
;2342:
;2343:void CG_ParseMenu(const char *menuFile) {
;2344:	pc_token_t token;
;2345:	int handle;
;2346:
;2347:	handle = trap_PC_LoadSource(menuFile);
;2348:	if (!handle)
;2349:		handle = trap_PC_LoadSource("ui/testhud.menu");
;2350:	if (!handle)
;2351:		return;
;2352:
;2353:	while ( 1 ) {
;2354:		if (!trap_PC_ReadToken( handle, &token )) {
;2355:			break;
;2356:		}
;2357:
;2358:		//if ( Q_stricmp( token, "{" ) ) {
;2359:		//	Com_Printf( "Missing { in menu file\n" );
;2360:		//	break;
;2361:		//}
;2362:
;2363:		//if ( menuCount == MAX_MENUS ) {
;2364:		//	Com_Printf( "Too many menus!\n" );
;2365:		//	break;
;2366:		//}
;2367:
;2368:		if ( token.string[0] == '}' ) {
;2369:			break;
;2370:		}
;2371:
;2372:		if (Q_stricmp(token.string, "assetGlobalDef") == 0) {
;2373:			if (CG_Asset_Parse(handle)) {
;2374:				continue;
;2375:			} else {
;2376:				break;
;2377:			}
;2378:		}
;2379:
;2380:
;2381:		if (Q_stricmp(token.string, "menudef") == 0) {
;2382:			// start a new menu
;2383:			Menu_New(handle);
;2384:		}
;2385:	}
;2386:	trap_PC_FreeSource(handle);
;2387:}
;2388:
;2389:qboolean CG_Load_Menu(char **p) {
;2390:	char *token;
;2391:
;2392:	token = COM_ParseExt(p, qtrue);
;2393:
;2394:	if (token[0] != '{') {
;2395:		return qfalse;
;2396:	}
;2397:
;2398:	while ( 1 ) {
;2399:
;2400:		token = COM_ParseExt(p, qtrue);
;2401:
;2402:		if (Q_stricmp(token, "}") == 0) {
;2403:			return qtrue;
;2404:		}
;2405:
;2406:		if ( !token || token[0] == 0 ) {
;2407:			return qfalse;
;2408:		}
;2409:
;2410:		CG_ParseMenu(token);
;2411:	}
;2412:	return qfalse;
;2413:}
;2414:
;2415:
;2416:
;2417:void CG_LoadMenus(const char *menuFile) {
;2418:	char	*token;
;2419:	char *p;
;2420:	int	len, start;
;2421:	fileHandle_t	f;
;2422:	static char buf[MAX_MENUDEFFILE];
;2423:
;2424:	start = trap_Milliseconds();
;2425:
;2426:	len = trap_FS_FOpenFile( menuFile, &f, FS_READ );
;2427:	if ( !f ) {
;2428:		trap_Error( va( S_COLOR_YELLOW "menu file not found: %s, using default\n", menuFile ) );
;2429:		len = trap_FS_FOpenFile( "ui/hud.txt", &f, FS_READ );
;2430:		if (!f) {
;2431:			trap_Error( va( S_COLOR_RED "default menu file not found: ui/hud.txt, unable to continue!\n", menuFile ) );
;2432:		}
;2433:	}
;2434:
;2435:	if ( len >= MAX_MENUDEFFILE ) {
;2436:		trap_Error( va( S_COLOR_RED "menu file too large: %s is %i, max allowed is %i", menuFile, len, MAX_MENUDEFFILE ) );
;2437:		trap_FS_FCloseFile( f );
;2438:		return;
;2439:	}
;2440:
;2441:	trap_FS_Read( buf, len, f );
;2442:	buf[len] = 0;
;2443:	trap_FS_FCloseFile( f );
;2444:
;2445:	COM_Compress(buf);
;2446:
;2447:	Menu_Reset();
;2448:
;2449:	p = buf;
;2450:
;2451:	while ( 1 ) {
;2452:		token = COM_ParseExt( &p, qtrue );
;2453:		if( !token || token[0] == 0 || token[0] == '}') {
;2454:			break;
;2455:		}
;2456:
;2457:		//if ( Q_stricmp( token, "{" ) ) {
;2458:		//	Com_Printf( "Missing { in menu file\n" );
;2459:		//	break;
;2460:		//}
;2461:
;2462:		//if ( menuCount == MAX_MENUS ) {
;2463:		//	Com_Printf( "Too many menus!\n" );
;2464:		//	break;
;2465:		//}
;2466:
;2467:		if ( Q_stricmp( token, "}" ) == 0 ) {
;2468:			break;
;2469:		}
;2470:
;2471:		if (Q_stricmp(token, "loadmenu") == 0) {
;2472:			if (CG_Load_Menu(&p)) {
;2473:				continue;
;2474:			} else {
;2475:				break;
;2476:			}
;2477:		}
;2478:	}
;2479:
;2480:	Com_Printf("UI menu load time = %d milli seconds\n", trap_Milliseconds() - start);
;2481:
;2482:}
;2483:
;2484:
;2485:
;2486:static qboolean CG_OwnerDrawHandleKey(int ownerDraw, int flags, float *special, int key) {
;2487:	return qfalse;
;2488:}
;2489:
;2490:
;2491:static int CG_FeederCount(float feederID) {
;2492:	int i, count;
;2493:	count = 0;
;2494:	if (feederID == FEEDER_REDTEAM_LIST) {
;2495:		for (i = 0; i < cg.numScores; i++) {
;2496:			if (cg.scores[i].team == TEAM_RED) {
;2497:				count++;
;2498:			}
;2499:		}
;2500:	} else if (feederID == FEEDER_BLUETEAM_LIST) {
;2501:		for (i = 0; i < cg.numScores; i++) {
;2502:			if (cg.scores[i].team == TEAM_BLUE) {
;2503:				count++;
;2504:			}
;2505:		}
;2506:	} else if (feederID == FEEDER_SCOREBOARD) {
;2507:		return cg.numScores;
;2508:	}
;2509:	return count;
;2510:}
;2511:
;2512:
;2513:void CG_SetScoreSelection(void *p) {
;2514:	menuDef_t *menu = (menuDef_t*)p;
;2515:	playerState_t *ps = &cg.snap->ps;
;2516:	int i, red, blue;
;2517:	red = blue = 0;
;2518:	for (i = 0; i < cg.numScores; i++) {
;2519:		if (cg.scores[i].team == TEAM_RED) {
;2520:			red++;
;2521:		} else if (cg.scores[i].team == TEAM_BLUE) {
;2522:			blue++;
;2523:		}
;2524:		if (ps->clientNum == cg.scores[i].client) {
;2525:			cg.selectedScore = i;
;2526:		}
;2527:	}
;2528:
;2529:	if (menu == NULL) {
;2530:		// just interested in setting the selected score
;2531:		return;
;2532:	}
;2533:
;2534:	if ( cgs.gametype >= GT_TEAM ) {
;2535:		int feeder = FEEDER_REDTEAM_LIST;
;2536:		i = red;
;2537:		if (cg.scores[cg.selectedScore].team == TEAM_BLUE) {
;2538:			feeder = FEEDER_BLUETEAM_LIST;
;2539:			i = blue;
;2540:		}
;2541:		Menu_SetFeederSelection(menu, feeder, i, NULL);
;2542:	} else {
;2543:		Menu_SetFeederSelection(menu, FEEDER_SCOREBOARD, cg.selectedScore, NULL);
;2544:	}
;2545:}
;2546:
;2547:// FIXME: might need to cache this info
;2548:static clientInfo_t * CG_InfoFromScoreIndex(int index, int team, int *scoreIndex) {
;2549:	int i, count;
;2550:	if ( cgs.gametype >= GT_TEAM ) {
;2551:		count = 0;
;2552:		for (i = 0; i < cg.numScores; i++) {
;2553:			if (cg.scores[i].team == team) {
;2554:				if (count == index) {
;2555:					*scoreIndex = i;
;2556:					return &cgs.clientinfo[cg.scores[i].client];
;2557:				}
;2558:				count++;
;2559:			}
;2560:		}
;2561:	}
;2562:	*scoreIndex = index;
;2563:	return &cgs.clientinfo[ cg.scores[index].client ];
;2564:}
;2565:
;2566:static const char *CG_FeederItemText(float feederID, int index, int column, qhandle_t *handle) {
;2567:	gitem_t *item;
;2568:	int scoreIndex = 0;
;2569:	clientInfo_t *info = NULL;
;2570:	int team = -1;
;2571:	score_t *sp = NULL;
;2572:
;2573:	*handle = -1;
;2574:
;2575:	if (feederID == FEEDER_REDTEAM_LIST) {
;2576:		team = TEAM_RED;
;2577:	} else if (feederID == FEEDER_BLUETEAM_LIST) {
;2578:		team = TEAM_BLUE;
;2579:	}
;2580:
;2581:	info = CG_InfoFromScoreIndex(index, team, &scoreIndex);
;2582:	sp = &cg.scores[scoreIndex];
;2583:
;2584:	if (info && info->infoValid) {
;2585:		switch (column) {
;2586:			case 0:
;2587:				if ( info->powerups & ( 1 << PW_NEUTRALFLAG ) ) {
;2588:					item = BG_FindItemForPowerup( PW_NEUTRALFLAG );
;2589:					*handle = cg_items[ ITEM_INDEX(item) ].icon;
;2590:				} else if ( info->powerups & ( 1 << PW_REDFLAG ) ) {
;2591:					item = BG_FindItemForPowerup( PW_REDFLAG );
;2592:					*handle = cg_items[ ITEM_INDEX(item) ].icon;
;2593:				} else if ( info->powerups & ( 1 << PW_BLUEFLAG ) ) {
;2594:					item = BG_FindItemForPowerup( PW_BLUEFLAG );
;2595:					*handle = cg_items[ ITEM_INDEX(item) ].icon;
;2596:				} else {
;2597:					if ( info->botSkill > 0 && info->botSkill <= 5 ) {
;2598:						*handle = cgs.media.botSkillShaders[ info->botSkill - 1 ];
;2599:					} else if ( info->handicap < 100 ) {
;2600:					return va("%i", info->handicap );
;2601:					}
;2602:				}
;2603:			break;
;2604:			case 1:
;2605:				if (team == -1) {
;2606:					return "";
;2607:				} else {
;2608:					*handle = CG_StatusHandle(info->teamTask);
;2609:				}
;2610:		  break;
;2611:			case 2:
;2612:				if ( cg.snap->ps.stats[ STAT_CLIENTS_READY ] & ( 1 << sp->client ) ) {
;2613:					return "Ready";
;2614:				}
;2615:				if (team == -1) {
;2616:					if (cgs.gametype == GT_TOURNAMENT) {
;2617:						return va("%i/%i", info->wins, info->losses);
;2618:					} else if (info->infoValid && info->team == TEAM_SPECTATOR ) {
;2619:						return "Spectator";
;2620:					} else {
;2621:						return "";
;2622:					}
;2623:				} else {
;2624:					if (info->teamLeader) {
;2625:						return "Leader";
;2626:					}
;2627:				}
;2628:			break;
;2629:			case 3:
;2630:				return info->name;
;2631:			break;
;2632:			case 4:
;2633:				return va("%i", info->score);
;2634:			break;
;2635:			case 5:
;2636:				return va("%4i", sp->time);
;2637:			break;
;2638:			case 6:
;2639:				if ( sp->ping == -1 ) {
;2640:					return "connecting";
;2641:				}
;2642:				return va("%4i", sp->ping);
;2643:			break;
;2644:		}
;2645:	}
;2646:
;2647:	return "";
;2648:}
;2649:
;2650:static qhandle_t CG_FeederItemImage(float feederID, int index) {
;2651:	return 0;
;2652:}
;2653:
;2654:static void CG_FeederSelection(float feederID, int index) {
;2655:	if ( cgs.gametype >= GT_TEAM ) {
;2656:		int i, count;
;2657:		int team = (feederID == FEEDER_REDTEAM_LIST) ? TEAM_RED : TEAM_BLUE;
;2658:		count = 0;
;2659:		for (i = 0; i < cg.numScores; i++) {
;2660:			if (cg.scores[i].team == team) {
;2661:				if (index == count) {
;2662:					cg.selectedScore = i;
;2663:				}
;2664:				count++;
;2665:			}
;2666:		}
;2667:	} else {
;2668:		cg.selectedScore = index;
;2669:	}
;2670:}
;2671:#endif
;2672:
;2673:#ifdef MISSIONPACK // bk001204 - only needed there
;2674:static float CG_Cvar_Get(const char *cvar) {
;2675:	char buff[128];
;2676:	memset(buff, 0, sizeof(buff));
;2677:	trap_Cvar_VariableStringBuffer(cvar, buff, sizeof(buff));
;2678:	return atof(buff);
;2679:}
;2680:#endif
;2681:
;2682:#ifdef MISSIONPACK
;2683:void CG_Text_PaintWithCursor(float x, float y, float scale, vec4_t color, const char *text, int cursorPos, char cursor, int limit, int style) {
;2684:	CG_Text_Paint(x, y, scale, color, text, 0, limit, style);
;2685:}
;2686:
;2687:static int CG_OwnerDrawWidth(int ownerDraw, float scale) {
;2688:	switch (ownerDraw) {
;2689:	  case CG_GAME_TYPE:
;2690:			return CG_Text_Width(CG_GameTypeString(), scale, 0);
;2691:	  case CG_GAME_STATUS:
;2692:			return CG_Text_Width(CG_GetGameStatusText(), scale, 0);
;2693:			break;
;2694:	  case CG_KILLER:
;2695:			return CG_Text_Width(CG_GetKillerText(), scale, 0);
;2696:			break;
;2697:	  case CG_RED_NAME:
;2698:			return CG_Text_Width(cg_redTeamName.string, scale, 0);
;2699:			break;
;2700:	  case CG_BLUE_NAME:
;2701:			return CG_Text_Width(cg_blueTeamName.string, scale, 0);
;2702:			break;
;2703:
;2704:
;2705:	}
;2706:	return 0;
;2707:}
;2708:
;2709:static int CG_PlayCinematic(const char *name, float x, float y, float w, float h) {
;2710:  return trap_CIN_PlayCinematic(name, x, y, w, h, CIN_loop);
;2711:}
;2712:
;2713:static void CG_StopCinematic(int handle) {
;2714:  trap_CIN_StopCinematic(handle);
;2715:}
;2716:
;2717:static void CG_DrawCinematic(int handle, float x, float y, float w, float h) {
;2718:  trap_CIN_SetExtents(handle, x, y, w, h);
;2719:  trap_CIN_DrawCinematic(handle);
;2720:}
;2721:
;2722:static void CG_RunCinematicFrame(int handle) {
;2723:  trap_CIN_RunCinematic(handle);
;2724:}
;2725:
;2726:/*
;2727:=================
;2728:CG_LoadHudMenu();
;2729:
;2730:=================
;2731:*/
;2732:void CG_LoadHudMenu() {
;2733:	char buff[1024];
;2734:	const char *hudSet;
;2735:
;2736:	cgDC.registerShaderNoMip = &trap_R_RegisterShaderNoMip;
;2737:	cgDC.setColor = &trap_R_SetColor;
;2738:	cgDC.drawHandlePic = &CG_DrawPic;
;2739:	cgDC.drawStretchPic = &trap_R_DrawStretchPic;
;2740:	cgDC.drawText = &CG_Text_Paint;
;2741:	cgDC.textWidth = &CG_Text_Width;
;2742:	cgDC.textHeight = &CG_Text_Height;
;2743:	cgDC.registerModel = &trap_R_RegisterModel;
;2744:	cgDC.modelBounds = &trap_R_ModelBounds;
;2745:	cgDC.fillRect = &CG_FillRect;
;2746:	cgDC.drawRect = &CG_DrawRect;
;2747:	cgDC.drawSides = &CG_DrawSides;
;2748:	cgDC.drawTopBottom = &CG_DrawTopBottom;
;2749:	cgDC.clearScene = &trap_R_ClearScene;
;2750:	cgDC.addRefEntityToScene = &trap_R_AddRefEntityToScene;
;2751:	cgDC.renderScene = &trap_R_RenderScene;
;2752:	cgDC.registerFont = &trap_R_RegisterFont;
;2753:	cgDC.ownerDrawItem = &CG_OwnerDraw;
;2754:	cgDC.getValue = &CG_GetValue;
;2755:	cgDC.ownerDrawVisible = &CG_OwnerDrawVisible;
;2756:	cgDC.runScript = &CG_RunMenuScript;
;2757:	cgDC.getTeamColor = &CG_GetTeamColor;
;2758:	cgDC.setCVar = trap_Cvar_Set;
;2759:	cgDC.getCVarString = trap_Cvar_VariableStringBuffer;
;2760:	cgDC.getCVarValue = CG_Cvar_Get;
;2761:	cgDC.drawTextWithCursor = &CG_Text_PaintWithCursor;
;2762:	//cgDC.setOverstrikeMode = &trap_Key_SetOverstrikeMode;
;2763:	//cgDC.getOverstrikeMode = &trap_Key_GetOverstrikeMode;
;2764:	cgDC.startLocalSound = &trap_S_StartLocalSound;
;2765:	cgDC.ownerDrawHandleKey = &CG_OwnerDrawHandleKey;
;2766:	cgDC.feederCount = &CG_FeederCount;
;2767:	cgDC.feederItemImage = &CG_FeederItemImage;
;2768:	cgDC.feederItemText = &CG_FeederItemText;
;2769:	cgDC.feederSelection = &CG_FeederSelection;
;2770:	//cgDC.setBinding = &trap_Key_SetBinding;
;2771:	//cgDC.getBindingBuf = &trap_Key_GetBindingBuf;
;2772:	//cgDC.keynumToStringBuf = &trap_Key_KeynumToStringBuf;
;2773:	//cgDC.executeText = &trap_Cmd_ExecuteText;
;2774:	cgDC.Error = &Com_Error;
;2775:	cgDC.Print = &Com_Printf;
;2776:	cgDC.ownerDrawWidth = &CG_OwnerDrawWidth;
;2777:	//cgDC.Pause = &CG_Pause;
;2778:	cgDC.registerSound = &trap_S_RegisterSound;
;2779:	cgDC.startBackgroundTrack = &trap_S_StartBackgroundTrack;
;2780:	cgDC.stopBackgroundTrack = &trap_S_StopBackgroundTrack;
;2781:	cgDC.playCinematic = &CG_PlayCinematic;
;2782:	cgDC.stopCinematic = &CG_StopCinematic;
;2783:	cgDC.drawCinematic = &CG_DrawCinematic;
;2784:	cgDC.runCinematicFrame = &CG_RunCinematicFrame;
;2785:
;2786:	Init_Display(&cgDC);
;2787:
;2788:	Menu_Reset();
;2789:
;2790:	trap_Cvar_VariableStringBuffer("cg_hudFiles", buff, sizeof(buff));
;2791:	hudSet = buff;
;2792:	if (hudSet[0] == '\0') {
;2793:		hudSet = "ui/hud.txt";
;2794:	}
;2795:
;2796:	CG_LoadMenus(hudSet);
;2797:}
;2798:
;2799:void CG_AssetCache() {
;2800:	//if (Assets.textFont == NULL) {
;2801:	//  trap_R_RegisterFont("fonts/arial.ttf", 72, &Assets.textFont);
;2802:	//}
;2803:	//Assets.background = trap_R_RegisterShaderNoMip( ASSET_BACKGROUND );
;2804:	//Com_Printf("Menu Size: %i bytes\n", sizeof(Menus));
;2805:	cgDC.Assets.gradientBar = trap_R_RegisterShaderNoMip( ASSET_GRADIENTBAR );
;2806:	cgDC.Assets.fxBasePic = trap_R_RegisterShaderNoMip( ART_FX_BASE );
;2807:	cgDC.Assets.fxPic[0] = trap_R_RegisterShaderNoMip( ART_FX_RED );
;2808:	cgDC.Assets.fxPic[1] = trap_R_RegisterShaderNoMip( ART_FX_YELLOW );
;2809:	cgDC.Assets.fxPic[2] = trap_R_RegisterShaderNoMip( ART_FX_GREEN );
;2810:	cgDC.Assets.fxPic[3] = trap_R_RegisterShaderNoMip( ART_FX_TEAL );
;2811:	cgDC.Assets.fxPic[4] = trap_R_RegisterShaderNoMip( ART_FX_BLUE );
;2812:	cgDC.Assets.fxPic[5] = trap_R_RegisterShaderNoMip( ART_FX_CYAN );
;2813:	cgDC.Assets.fxPic[6] = trap_R_RegisterShaderNoMip( ART_FX_WHITE );
;2814:	cgDC.Assets.scrollBar = trap_R_RegisterShaderNoMip( ASSET_SCROLLBAR );
;2815:	cgDC.Assets.scrollBarArrowDown = trap_R_RegisterShaderNoMip( ASSET_SCROLLBAR_ARROWDOWN );
;2816:	cgDC.Assets.scrollBarArrowUp = trap_R_RegisterShaderNoMip( ASSET_SCROLLBAR_ARROWUP );
;2817:	cgDC.Assets.scrollBarArrowLeft = trap_R_RegisterShaderNoMip( ASSET_SCROLLBAR_ARROWLEFT );
;2818:	cgDC.Assets.scrollBarArrowRight = trap_R_RegisterShaderNoMip( ASSET_SCROLLBAR_ARROWRIGHT );
;2819:	cgDC.Assets.scrollBarThumb = trap_R_RegisterShaderNoMip( ASSET_SCROLL_THUMB );
;2820:	cgDC.Assets.sliderBar = trap_R_RegisterShaderNoMip( ASSET_SLIDER_BAR );
;2821:	cgDC.Assets.sliderThumb = trap_R_RegisterShaderNoMip( ASSET_SLIDER_THUMB );
;2822:}
;2823:#endif
;2824:
;2825:
;2826:/*
;2827:=================
;2828:JUHOX: CG_Get3DFontModelBounds
;2829:=================
;2830:*/
;2831:/*
;2832:static void CG_Get3DFontModelBounds(void) {
;2833:	int i;
;2834:	fileHandle_t file;
;2835:
;2836:	trap_FS_FOpenFile("font.txt", &file, FS_WRITE);
;2837:	if (!file) return;
;2838:
;2839:	for (i = 33; i < 256; i++) {
;2840:		qhandle_t model;
;2841:		char buf[32];
;2842:
;2843:		model = trap_R_RegisterModel(va("models/fonts/hunt1/f_%d.md3", i));
;2844:		if (model) {
;2845:			vec3_t mins, maxs;
;2846:			float width;
;2847:
;2848:			trap_R_ModelBounds(model, mins, maxs);
;2849:			width = maxs[1] - mins[1];
;2850:			Com_sprintf(buf, sizeof(buf), "%f,\n", width);
;2851:		}
;2852:		else {
;2853:			Com_sprintf(buf, sizeof(buf), "0, //omitted\n");
;2854:		}
;2855:		trap_FS_Write(buf, strlen(buf), file);
;2856:	}
;2857:	trap_FS_FCloseFile(file);
;2858:}
;2859:*/
;2860:
;2861:/*
;2862:=================
;2863:CG_Init
;2864:
;2865:Called after every level change or subsystem restart
;2866:Will perform callbacks to make the loading info screen update.
;2867:=================
;2868:*/
;2869:void CG_Init( int serverMessageNum, int serverCommandSequence, int clientNum ) {
line 2873
;2870:	const char	*s;
;2871:
;2872:	// clear everything
;2873:	memset( &cgs, 0, sizeof( cgs ) );
ADDRGP4 cgs
ARGP4
CNSTI4 0
ARGI4
CNSTI4 752732
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2874
;2874:	memset( &cg, 0, sizeof( cg ) );
ADDRGP4 cg
ARGP4
CNSTI4 0
ARGI4
CNSTI4 163672
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2875
;2875:	memset( cg_entities, 0, sizeof(cg_entities) );
ADDRGP4 cg_entities
ARGP4
CNSTI4 0
ARGI4
CNSTI4 901120
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2876
;2876:	memset( cg_weapons, 0, sizeof(cg_weapons) );
ADDRGP4 cg_weapons
ARGP4
CNSTI4 0
ARGI4
CNSTI4 2176
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2877
;2877:	memset( cg_items, 0, sizeof(cg_items) );
ADDRGP4 cg_items
ARGP4
CNSTI4 0
ARGI4
CNSTI4 6144
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2881
;2878:
;2879:	//CG_Get3DFontModelBounds();	// JUHOX
;2880:
;2881:	cg.clientNum = clientNum;
ADDRGP4 cg+4
ADDRFP4 8
INDIRI4
ASGNI4
line 2883
;2882:
;2883:	cgs.processedSnapshotNum = serverMessageNum;
ADDRGP4 cgs+31448
ADDRFP4 0
INDIRI4
ASGNI4
line 2884
;2884:	cgs.serverCommandSequence = serverCommandSequence;
ADDRGP4 cgs+31444
ADDRFP4 4
INDIRI4
ASGNI4
line 2886
;2885:
;2886:	CG_TSS_InitInterface();	// JUHOX
ADDRGP4 CG_TSS_InitInterface
CALLV
pop
line 2892
;2887:
;2888:	// load a few needed things before we do any screen updates
;2889:#if 0	// JUHOX: new charsetShader
;2890:	cgs.media.charsetShader		= trap_R_RegisterShader( "gfx/2d/bigchars" );
;2891:#else
;2892:	cgs.media.oldCharsetShader = trap_R_RegisterShader("gfx/2d/bigchars");	// better readable with low resolutions
ADDRGP4 $1638
ARGP4
ADDRLP4 4
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220
ADDRLP4 4
INDIRI4
ASGNI4
line 2893
;2893:	cgs.media.charsetShaders[0] = trap_R_RegisterShader("gfx/2d/bigchar0");
ADDRGP4 $1641
ARGP4
ADDRLP4 8
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+4
ADDRLP4 8
INDIRI4
ASGNI4
line 2894
;2894:	cgs.media.charsetShaders[1] = trap_R_RegisterShader("gfx/2d/bigchar1");
ADDRGP4 $1645
ARGP4
ADDRLP4 12
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+4+4
ADDRLP4 12
INDIRI4
ASGNI4
line 2895
;2895:	cgs.media.charsetShaders[2] = trap_R_RegisterShader("gfx/2d/bigchar2");
ADDRGP4 $1649
ARGP4
ADDRLP4 16
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+4+8
ADDRLP4 16
INDIRI4
ASGNI4
line 2896
;2896:	cgs.media.charsetShaders[3] = trap_R_RegisterShader("gfx/2d/bigchar3");
ADDRGP4 $1653
ARGP4
ADDRLP4 20
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+4+12
ADDRLP4 20
INDIRI4
ASGNI4
line 2897
;2897:	cgs.media.charsetShaders[4] = trap_R_RegisterShader("gfx/2d/bigchar4");
ADDRGP4 $1657
ARGP4
ADDRLP4 24
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+4+16
ADDRLP4 24
INDIRI4
ASGNI4
line 2898
;2898:	cgs.media.charsetShaders[5] = trap_R_RegisterShader("gfx/2d/bigchar5");
ADDRGP4 $1661
ARGP4
ADDRLP4 28
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+4+20
ADDRLP4 28
INDIRI4
ASGNI4
line 2899
;2899:	cgs.media.charsetShaders[6] = trap_R_RegisterShader("gfx/2d/bigchar6");
ADDRGP4 $1665
ARGP4
ADDRLP4 32
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+4+24
ADDRLP4 32
INDIRI4
ASGNI4
line 2900
;2900:	cgs.media.charsetShaders[7] = trap_R_RegisterShader("gfx/2d/bigchar7");
ADDRGP4 $1669
ARGP4
ADDRLP4 36
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+4+28
ADDRLP4 36
INDIRI4
ASGNI4
line 2902
;2901:#endif
;2902:	cgs.media.whiteShader		= trap_R_RegisterShader( "white" );
ADDRGP4 $1672
ARGP4
ADDRLP4 40
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+751220+48
ADDRLP4 40
INDIRI4
ASGNI4
line 2903
;2903:	cgs.media.charsetProp		= trap_R_RegisterShaderNoMip( "menu/art/font1_prop.tga" );
ADDRGP4 $1675
ARGP4
ADDRLP4 44
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+751220+36
ADDRLP4 44
INDIRI4
ASGNI4
line 2904
;2904:	cgs.media.charsetPropGlow	= trap_R_RegisterShaderNoMip( "menu/art/font1_prop_glo.tga" );
ADDRGP4 $1678
ARGP4
ADDRLP4 48
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+751220+40
ADDRLP4 48
INDIRI4
ASGNI4
line 2905
;2905:	cgs.media.charsetPropB		= trap_R_RegisterShaderNoMip( "menu/art/font2_prop.tga" );
ADDRGP4 $1681
ARGP4
ADDRLP4 52
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+751220+44
ADDRLP4 52
INDIRI4
ASGNI4
line 2907
;2906:
;2907:	CG_RegisterCvars();
ADDRGP4 CG_RegisterCvars
CALLV
pop
line 2909
;2908:
;2909:	CG_InitConsoleCommands();
ADDRGP4 CG_InitConsoleCommands
CALLV
pop
line 2911
;2910:
;2911:	cg.weaponSelect = WP_MACHINEGUN;
ADDRGP4 cg+109148
CNSTI4 2
ASGNI4
line 2912
;2912:	cg.weaponManuallySet = qtrue;	// JUHOX
ADDRGP4 cg+109152
CNSTI4 1
ASGNI4
line 2913
;2913:	cg.weaponOrderActive = qfalse;	// JUHOX
ADDRGP4 cg+109156
CNSTI4 0
ASGNI4
line 2915
;2914:
;2915:	cgs.redflag = cgs.blueflag = -1; // For compatibily, default to unset for
ADDRLP4 56
CNSTI4 -1
ASGNI4
ADDRGP4 cgs+35136
ADDRLP4 56
INDIRI4
ASGNI4
ADDRGP4 cgs+35132
ADDRLP4 56
INDIRI4
ASGNI4
line 2916
;2916:	cgs.flagStatus = -1;
ADDRGP4 cgs+35140
CNSTI4 -1
ASGNI4
line 2920
;2917:	// old servers
;2918:
;2919:	// get the rendering configuration from the client system
;2920:	trap_GetGlconfig( &cgs.glconfig );
ADDRGP4 cgs+20100
ARGP4
ADDRGP4 trap_GetGlconfig
CALLV
pop
line 2921
;2921:	cgs.screenXScale = cgs.glconfig.vidWidth / 640.0;
ADDRGP4 cgs+31432
ADDRGP4 cgs+20100+11304
INDIRI4
CVIF4 4
CNSTF4 986500301
MULF4
ASGNF4
line 2922
;2922:	cgs.screenYScale = cgs.glconfig.vidHeight / 480.0;
ADDRGP4 cgs+31436
ADDRGP4 cgs+20100+11308
INDIRI4
CVIF4 4
CNSTF4 990414985
MULF4
ASGNF4
line 2925
;2923:
;2924:	// get the gamestate from the client system
;2925:	trap_GetGameState( &cgs.gameState );
ADDRGP4 cgs
ARGP4
ADDRGP4 trap_GetGameState
CALLV
pop
line 2928
;2926:
;2927:	// check version
;2928:	s = CG_ConfigString( CS_GAME_VERSION );
CNSTI4 20
ARGI4
ADDRLP4 60
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 60
INDIRP4
ASGNP4
line 2929
;2929:	if ( strcmp( s, GAME_VERSION ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $1697
ARGP4
ADDRLP4 64
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
EQI4 $1695
line 2930
;2930:		CG_Error( "Client/Server game mismatch: %s/%s", GAME_VERSION, s );
ADDRGP4 $1698
ARGP4
ADDRGP4 $1697
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 2931
;2931:	}
LABELV $1695
line 2933
;2932:
;2933:	s = CG_ConfigString( CS_LEVEL_START_TIME );
CNSTI4 21
ARGI4
ADDRLP4 68
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 68
INDIRP4
ASGNP4
line 2934
;2934:	cgs.levelStartTime = atoi( s );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 72
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+35120
ADDRLP4 72
INDIRI4
ASGNI4
line 2937
;2935:
;2936:#if 1	// JUHOX: get nearbox shader name
;2937:	Q_strncpyz(cgs.nearboxShaderName, CG_ConfigString(CS_NEARBOX), sizeof(cgs.nearboxShaderName));
CNSTI4 708
ARGI4
ADDRLP4 76
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRGP4 cgs+31872
ARGP4
ADDRLP4 76
INDIRP4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 2940
;2938:#endif
;2939:
;2940:	CG_ParseServerinfo();
ADDRGP4 CG_ParseServerinfo
CALLV
pop
line 2943
;2941:
;2942:	// load the new map
;2943:	CG_LoadingString( "collision map" );
ADDRGP4 $1702
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 2945
;2944:
;2945:	trap_CM_LoadMap( cgs.mapname );
ADDRGP4 cgs+31484
ARGP4
ADDRGP4 trap_CM_LoadMap
CALLV
pop
line 2951
;2946:
;2947:#ifdef MISSIONPACK
;2948:	String_Init();
;2949:#endif
;2950:
;2951:	cg.loading = qtrue;		// force players to load instead of defer
ADDRGP4 cg+20
CNSTI4 1
ASGNI4
line 2953
;2952:
;2953:	CG_LoadingString( "sounds" );
ADDRGP4 $1705
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 2955
;2954:
;2955:	CG_RegisterSounds();
ADDRGP4 CG_RegisterSounds
CALLV
pop
line 2957
;2956:
;2957:	CG_LoadingString( "graphics" );
ADDRGP4 $1706
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 2959
;2958:
;2959:	CG_RegisterGraphics();
ADDRGP4 CG_RegisterGraphics
CALLV
pop
line 2961
;2960:
;2961:	CG_LoadingString( "clients" );
ADDRGP4 $1707
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 2963
;2962:
;2963:	CG_RegisterClients();		// if low on memory, some clients will be deferred
ADDRGP4 CG_RegisterClients
CALLV
pop
line 2970
;2964:
;2965:#ifdef MISSIONPACK
;2966:	CG_AssetCache();
;2967:	CG_LoadHudMenu();      // load new hud stuff
;2968:#endif
;2969:
;2970:	cg.loading = qfalse;	// future players will be deferred
ADDRGP4 cg+20
CNSTI4 0
ASGNI4
line 2972
;2971:
;2972:	CG_InitLocalEntities();
ADDRGP4 CG_InitLocalEntities
CALLV
pop
line 2974
;2973:
;2974:	CG_InitMarkPolys();
ADDRGP4 CG_InitMarkPolys
CALLV
pop
line 2977
;2975:
;2976:	// remove the last loading update
;2977:	cg.infoScreenText[0] = 0;
ADDRGP4 cg+112484
CNSTI1 0
ASGNI1
line 2980
;2978:
;2979:	// Make sure we have update values (scores)
;2980:	CG_SetConfigValues();
ADDRGP4 CG_SetConfigValues
CALLV
pop
line 2989
;2981:
;2982:#if 0	// JUHOX: don't play in-game music
;2983:	CG_StartMusic();
;2984:#else
;2985:
;2986:#if !PLAYLIST	// JUHOX: init playlist
;2987:	trap_S_StopBackgroundTrack();
;2988:#else
;2989:	CG_InitPlayList();
ADDRGP4 CG_InitPlayList
CALLV
pop
line 2990
;2990:	CG_ParsePlayList();
ADDRGP4 CG_ParsePlayList
CALLV
pop
line 2996
;2991:#endif
;2992:
;2993:#endif
;2994:
;2995:
;2996:	CG_LoadingString( "" );
ADDRGP4 $146
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 3002
;2997:
;2998:#ifdef MISSIONPACK
;2999:	CG_InitTeamChat();
;3000:#endif
;3001:
;3002:	CG_ShaderStateChanged();
ADDRGP4 CG_ShaderStateChanged
CALLV
pop
line 3004
;3003:
;3004:	trap_S_ClearLoopingSounds( qtrue );
CNSTI4 1
ARGI4
ADDRGP4 trap_S_ClearLoopingSounds
CALLV
pop
line 3006
;3005:
;3006:	CG_TSS_LoadInterface();	// JUHOX
ADDRGP4 CG_TSS_LoadInterface
CALLV
pop
line 3008
;3007:
;3008:	trap_Cvar_Set("ui_init", "0");	// JUHOX
ADDRGP4 $1710
ARGP4
ADDRGP4 $140
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3010
;3009:#if MONSTER_MODE	// JUHOX: prevent "sudden death" announcement in STU
;3010:	if (cgs.gametype >= GT_STU) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 8
LTI4 $1711
line 3011
;3011:		cg.timelimitWarnings = 4;
ADDRGP4 cg+107668
CNSTI4 4
ASGNI4
line 3012
;3012:	}
LABELV $1711
line 3015
;3013:#endif
;3014:#if 1	// JUHOX: get record
;3015:	{
line 3018
;3016:		int recordType;
;3017:
;3018:		recordType = GC_none;
ADDRLP4 80
CNSTI4 0
ASGNI4
line 3019
;3019:		cgs.record = 0;
ADDRGP4 cgs+31676
CNSTI4 0
ASGNI4
line 3020
;3020:		sscanf(CG_ConfigString(CS_RECORD), "%d,%d", &recordType, &cgs.record);
CNSTI4 713
ARGI4
ADDRLP4 84
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 84
INDIRP4
ARGP4
ADDRGP4 $1716
ARGP4
ADDRLP4 80
ARGP4
ADDRGP4 cgs+31676
ARGP4
ADDRGP4 sscanf
CALLI4
pop
line 3021
;3021:		cgs.recordType = recordType;
ADDRGP4 cgs+31680
ADDRLP4 80
INDIRI4
ASGNI4
line 3022
;3022:	}
line 3024
;3023:#endif
;3024:}
LABELV $1633
endproc CG_Init 88 16
export CG_Shutdown
proc CG_Shutdown 0 0
line 3033
;3025:
;3026:/*
;3027:=================
;3028:CG_Shutdown
;3029:
;3030:Called before every level change or subsystem restart
;3031:=================
;3032:*/
;3033:void CG_Shutdown( void ) {
line 3036
;3034:	// some mods may need to do cleanup work here,
;3035:	// like closing files or archiving session data
;3036:	CG_TSS_SaveInterface();	// JUHOX
ADDRGP4 CG_TSS_SaveInterface
CALLV
pop
line 3037
;3037:}
LABELV $1719
endproc CG_Shutdown 0 0
export CG_EventHandling
proc CG_EventHandling 0 0
line 3050
;3038:
;3039:
;3040:/*
;3041:==================
;3042:CG_EventHandling
;3043:==================
;3044: type 0 - no event handling
;3045:      1 - team menu
;3046:      2 - hud editor
;3047:
;3048:*/
;3049:#ifndef MISSIONPACK
;3050:void CG_EventHandling(int type) {
line 3051
;3051:}
LABELV $1720
endproc CG_EventHandling 0 0
export CG_KeyEvent
proc CG_KeyEvent 0 0
line 3055
;3052:
;3053:
;3054:
;3055:void CG_KeyEvent(int key, qboolean down) {
line 3056
;3056:}
LABELV $1721
endproc CG_KeyEvent 0 0
export CG_MouseEvent
proc CG_MouseEvent 0 0
line 3058
;3057:
;3058:void CG_MouseEvent(int x, int y) {
line 3059
;3059:}
LABELV $1722
endproc CG_MouseEvent 0 0
bss
align 1
LABELV lfbuf
skip 65536
align 1
LABELV lfNameBase
skip 128
align 4
LABELV fileStack
skip 32768
align 4
LABELV numFilesOnStack
skip 4
export cg_pmove_msec
align 4
LABELV cg_pmove_msec
skip 272
export cg_hudFiles
align 4
LABELV cg_hudFiles
skip 272
export cg_tmplcmd
align 4
LABELV cg_tmplcmd
skip 272
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
import CG_InitConsoleCommands
import CG_ConsoleCommand
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
import CG_GetSelectedScore
import CG_SetScoreSelection
import CG_RankRunFrame
import CG_LoadMenus
export cg_music
align 4
LABELV cg_music
skip 272
export cg_autoGLC
align 4
LABELV cg_autoGLC
skip 272
export cg_nearbox
align 4
LABELV cg_nearbox
skip 272
export cg_BFGsuperExpl
align 4
LABELV cg_BFGsuperExpl
skip 272
export cg_missileFlare
align 4
LABELV cg_missileFlare
skip 272
export cg_sunFlare
align 4
LABELV cg_sunFlare
skip 272
export cg_mapFlare
align 4
LABELV cg_mapFlare
skip 272
export cg_lensFlare
align 4
LABELV cg_lensFlare
skip 272
export cg_glassCloaking
align 4
LABELV cg_glassCloaking
skip 272
export cg_trueLightning
align 4
LABELV cg_trueLightning
skip 272
export cg_oldPlasma
align 4
LABELV cg_oldPlasma
skip 272
export cg_oldRocket
align 4
LABELV cg_oldRocket
skip 272
export cg_oldRail
align 4
LABELV cg_oldRail
skip 272
export cg_noProjectileTrail
align 4
LABELV cg_noProjectileTrail
skip 272
export cg_noTaunt
align 4
LABELV cg_noTaunt
skip 272
export cg_bigFont
align 4
LABELV cg_bigFont
skip 272
export cg_smallFont
align 4
LABELV cg_smallFont
skip 272
export cg_cameraMode
align 4
LABELV cg_cameraMode
skip 272
export cg_timescale
align 4
LABELV cg_timescale
skip 272
export cg_timescaleFadeSpeed
align 4
LABELV cg_timescaleFadeSpeed
skip 272
export cg_timescaleFadeEnd
align 4
LABELV cg_timescaleFadeEnd
skip 272
export cg_cameraOrbitDelay
align 4
LABELV cg_cameraOrbitDelay
skip 272
export cg_cameraOrbit
align 4
LABELV cg_cameraOrbit
skip 272
export pmove_msec
align 4
LABELV pmove_msec
skip 272
export pmove_fixed
align 4
LABELV pmove_fixed
skip 272
export cg_smoothClients
align 4
LABELV cg_smoothClients
skip 272
export cg_scorePlum
align 4
LABELV cg_scorePlum
skip 272
export cg_noVoiceText
align 4
LABELV cg_noVoiceText
skip 272
export cg_noVoiceChats
align 4
LABELV cg_noVoiceChats
skip 272
export cg_teamChatsOnly
align 4
LABELV cg_teamChatsOnly
skip 272
export cg_drawFriend
align 4
LABELV cg_drawFriend
skip 272
export cg_deferPlayers
align 4
LABELV cg_deferPlayers
skip 272
export cg_predictItems
align 4
LABELV cg_predictItems
skip 272
export cg_blood
align 4
LABELV cg_blood
skip 272
export cg_paused
align 4
LABELV cg_paused
skip 272
export cg_buildScript
align 4
LABELV cg_buildScript
skip 272
export cg_forceModel
align 4
LABELV cg_forceModel
skip 272
export cg_stats
align 4
LABELV cg_stats
skip 272
export cg_teamChatHeight
align 4
LABELV cg_teamChatHeight
skip 272
export cg_teamChatTime
align 4
LABELV cg_teamChatTime
skip 272
export cg_synchronousClients
align 4
LABELV cg_synchronousClients
skip 272
export cg_drawAttacker
align 4
LABELV cg_drawAttacker
skip 272
export cg_lagometer
align 4
LABELV cg_lagometer
skip 272
export cg_stereoSeparation
align 4
LABELV cg_stereoSeparation
skip 272
export cg_thirdPerson
align 4
LABELV cg_thirdPerson
skip 272
export cg_thirdPersonAngle
align 4
LABELV cg_thirdPersonAngle
skip 272
export cg_thirdPersonRange
align 4
LABELV cg_thirdPersonRange
skip 272
export cg_zoomFov
align 4
LABELV cg_zoomFov
skip 272
export cg_fov
align 4
LABELV cg_fov
skip 272
export cg_simpleItems
align 4
LABELV cg_simpleItems
skip 272
export cg_noTrace
align 4
LABELV cg_noTrace
skip 272
export cg_tssiKey
align 4
LABELV cg_tssiKey
skip 272
export cg_tssiMouse
align 4
LABELV cg_tssiMouse
skip 272
export cg_drawSegment
align 4
LABELV cg_drawSegment
skip 272
export cg_fireballTrail
align 4
LABELV cg_fireballTrail
skip 272
export cg_drawNumMonsters
align 4
LABELV cg_drawNumMonsters
skip 272
export cg_ignore
align 4
LABELV cg_ignore
skip 272
export cg_weaponOrderName
align 4
LABELV cg_weaponOrderName
skip 1632
export cg_weaponOrder
align 4
LABELV cg_weaponOrder
skip 1632
export cg_autoswitchAmmoLimit
align 4
LABELV cg_autoswitchAmmoLimit
skip 272
export cg_autoswitch
align 4
LABELV cg_autoswitch
skip 272
export cg_tracerLength
align 4
LABELV cg_tracerLength
skip 272
export cg_tracerWidth
align 4
LABELV cg_tracerWidth
skip 272
export cg_tracerChance
align 4
LABELV cg_tracerChance
skip 272
export cg_viewsize
align 4
LABELV cg_viewsize
skip 272
export cg_drawGun
align 4
LABELV cg_drawGun
skip 272
export cg_gun_z
align 4
LABELV cg_gun_z
skip 272
export cg_gun_y
align 4
LABELV cg_gun_y
skip 272
export cg_gun_x
align 4
LABELV cg_gun_x
skip 272
export cg_gun_frame
align 4
LABELV cg_gun_frame
skip 272
export cg_brassTime
align 4
LABELV cg_brassTime
skip 272
export cg_addMarks
align 4
LABELV cg_addMarks
skip 272
export cg_footsteps
align 4
LABELV cg_footsteps
skip 272
export cg_showmiss
align 4
LABELV cg_showmiss
skip 272
export cg_noPlayerAnims
align 4
LABELV cg_noPlayerAnims
skip 272
export cg_nopredict
align 4
LABELV cg_nopredict
skip 272
export cg_errorDecay
align 4
LABELV cg_errorDecay
skip 272
export cg_railTrailTime
align 4
LABELV cg_railTrailTime
skip 272
export cg_debugEvents
align 4
LABELV cg_debugEvents
skip 272
export cg_debugPosition
align 4
LABELV cg_debugPosition
skip 272
export cg_debugAnim
align 4
LABELV cg_debugAnim
skip 272
export cg_animSpeed
align 4
LABELV cg_animSpeed
skip 272
export cg_draw2D
align 4
LABELV cg_draw2D
skip 272
export cg_drawStatus
align 4
LABELV cg_drawStatus
skip 272
export cg_crosshairHealth
align 4
LABELV cg_crosshairHealth
skip 272
export cg_crosshairSize
align 4
LABELV cg_crosshairSize
skip 272
export cg_crosshairY
align 4
LABELV cg_crosshairY
skip 272
export cg_crosshairX
align 4
LABELV cg_crosshairX
skip 272
export cg_teamOverlayUserinfo
align 4
LABELV cg_teamOverlayUserinfo
skip 272
export cg_drawTeamOverlay
align 4
LABELV cg_drawTeamOverlay
skip 272
export cg_drawRewards
align 4
LABELV cg_drawRewards
skip 272
export cg_drawCrosshairNames
align 4
LABELV cg_drawCrosshairNames
skip 272
export cg_drawCrosshair
align 4
LABELV cg_drawCrosshair
skip 272
export cg_drawAmmoWarning
align 4
LABELV cg_drawAmmoWarning
skip 272
export cg_drawIcons
align 4
LABELV cg_drawIcons
skip 272
export cg_draw3dIcons
align 4
LABELV cg_draw3dIcons
skip 272
export cg_drawSnapshot
align 4
LABELV cg_drawSnapshot
skip 272
export cg_drawFPS
align 4
LABELV cg_drawFPS
skip 272
export cg_drawTimer
align 4
LABELV cg_drawTimer
skip 272
export cg_gibs
align 4
LABELV cg_gibs
skip 272
export cg_shadows
align 4
LABELV cg_shadows
skip 272
export cg_swingSpeed
align 4
LABELV cg_swingSpeed
skip 272
export cg_bobroll
align 4
LABELV cg_bobroll
skip 272
export cg_bobpitch
align 4
LABELV cg_bobpitch
skip 272
export cg_bobup
align 4
LABELV cg_bobup
skip 272
export cg_runroll
align 4
LABELV cg_runroll
skip 272
export cg_runpitch
align 4
LABELV cg_runpitch
skip 272
export cg_centertime
align 4
LABELV cg_centertime
skip 272
import cg_markPolys
export cg_items
align 4
LABELV cg_items
skip 6144
export cg_weapons
align 4
LABELV cg_weapons
skip 2176
export cg_entities
align 4
LABELV cg_entities
skip 901120
export cg
align 4
LABELV cg
skip 163672
export cgs
align 4
LABELV cgs
skip 752732
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
LABELV $1716
byte 1 37
byte 1 100
byte 1 44
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $1710
byte 1 117
byte 1 105
byte 1 95
byte 1 105
byte 1 110
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $1707
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $1706
byte 1 103
byte 1 114
byte 1 97
byte 1 112
byte 1 104
byte 1 105
byte 1 99
byte 1 115
byte 1 0
align 1
LABELV $1705
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $1702
byte 1 99
byte 1 111
byte 1 108
byte 1 108
byte 1 105
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $1698
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 47
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 109
byte 1 105
byte 1 115
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1697
byte 1 79
byte 1 112
byte 1 101
byte 1 110
byte 1 72
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $1681
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 50
byte 1 95
byte 1 112
byte 1 114
byte 1 111
byte 1 112
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1678
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 49
byte 1 95
byte 1 112
byte 1 114
byte 1 111
byte 1 112
byte 1 95
byte 1 103
byte 1 108
byte 1 111
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1675
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 49
byte 1 95
byte 1 112
byte 1 114
byte 1 111
byte 1 112
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1672
byte 1 119
byte 1 104
byte 1 105
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $1669
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 98
byte 1 105
byte 1 103
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 55
byte 1 0
align 1
LABELV $1665
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 98
byte 1 105
byte 1 103
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 54
byte 1 0
align 1
LABELV $1661
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 98
byte 1 105
byte 1 103
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 53
byte 1 0
align 1
LABELV $1657
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 98
byte 1 105
byte 1 103
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 52
byte 1 0
align 1
LABELV $1653
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 98
byte 1 105
byte 1 103
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 51
byte 1 0
align 1
LABELV $1649
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 98
byte 1 105
byte 1 103
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 50
byte 1 0
align 1
LABELV $1645
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 98
byte 1 105
byte 1 103
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 49
byte 1 0
align 1
LABELV $1641
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 98
byte 1 105
byte 1 103
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 48
byte 1 0
align 1
LABELV $1638
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 98
byte 1 105
byte 1 103
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $1624
byte 1 67
byte 1 71
byte 1 95
byte 1 67
byte 1 111
byte 1 110
byte 1 102
byte 1 105
byte 1 103
byte 1 83
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 58
byte 1 32
byte 1 98
byte 1 97
byte 1 100
byte 1 32
byte 1 105
byte 1 110
byte 1 100
byte 1 101
byte 1 120
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $1587
byte 1 37
byte 1 115
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $1559
byte 1 42
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $1552
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 66
byte 1 108
byte 1 111
byte 1 111
byte 1 100
byte 1 77
byte 1 97
byte 1 114
byte 1 107
byte 1 0
align 1
LABELV $1549
byte 1 98
byte 1 108
byte 1 111
byte 1 111
byte 1 100
byte 1 77
byte 1 97
byte 1 114
byte 1 107
byte 1 0
align 1
LABELV $1546
byte 1 119
byte 1 97
byte 1 107
byte 1 101
byte 1 0
align 1
LABELV $1543
byte 1 109
byte 1 97
byte 1 114
byte 1 107
byte 1 83
byte 1 104
byte 1 97
byte 1 100
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $1540
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 95
byte 1 109
byte 1 114
byte 1 107
byte 1 0
align 1
LABELV $1537
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 47
byte 1 104
byte 1 111
byte 1 108
byte 1 101
byte 1 95
byte 1 108
byte 1 103
byte 1 95
byte 1 109
byte 1 114
byte 1 107
byte 1 0
align 1
LABELV $1534
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 47
byte 1 98
byte 1 117
byte 1 114
byte 1 110
byte 1 95
byte 1 109
byte 1 101
byte 1 100
byte 1 95
byte 1 109
byte 1 114
byte 1 107
byte 1 0
align 1
LABELV $1531
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 47
byte 1 98
byte 1 117
byte 1 108
byte 1 108
byte 1 101
byte 1 116
byte 1 95
byte 1 109
byte 1 114
byte 1 107
byte 1 0
align 1
LABELV $1518
byte 1 116
byte 1 115
byte 1 115
byte 1 103
byte 1 114
byte 1 111
byte 1 117
byte 1 112
byte 1 37
byte 1 99
byte 1 0
align 1
LABELV $1513
byte 1 116
byte 1 115
byte 1 115
byte 1 103
byte 1 114
byte 1 111
byte 1 117
byte 1 112
byte 1 84
byte 1 101
byte 1 109
byte 1 112
byte 1 111
byte 1 114
byte 1 97
byte 1 114
byte 1 121
byte 1 0
align 1
LABELV $1510
byte 1 116
byte 1 115
byte 1 115
byte 1 103
byte 1 114
byte 1 111
byte 1 117
byte 1 112
byte 1 68
byte 1 101
byte 1 115
byte 1 105
byte 1 103
byte 1 110
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $1507
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 95
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $1504
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 95
byte 1 97
byte 1 115
byte 1 115
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $1501
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 95
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $1498
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 95
byte 1 103
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $1495
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 95
byte 1 101
byte 1 120
byte 1 99
byte 1 101
byte 1 108
byte 1 108
byte 1 101
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $1492
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 95
byte 1 105
byte 1 109
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 105
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $1489
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 115
byte 1 104
byte 1 105
byte 1 101
byte 1 108
byte 1 100
byte 1 47
byte 1 115
byte 1 104
byte 1 105
byte 1 101
byte 1 108
byte 1 100
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1486
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 69
byte 1 102
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $1483
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 112
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1480
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 104
byte 1 105
byte 1 116
byte 1 115
byte 1 47
byte 1 98
byte 1 111
byte 1 111
byte 1 109
byte 1 48
byte 1 49
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1477
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 104
byte 1 105
byte 1 116
byte 1 115
byte 1 47
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 48
byte 1 50
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1474
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 104
byte 1 105
byte 1 116
byte 1 115
byte 1 47
byte 1 98
byte 1 117
byte 1 108
byte 1 108
byte 1 101
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1471
byte 1 98
byte 1 108
byte 1 111
byte 1 111
byte 1 100
byte 1 69
byte 1 120
byte 1 112
byte 1 108
byte 1 111
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1468
byte 1 115
byte 1 112
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 115
byte 1 47
byte 1 98
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 111
byte 1 110
byte 1 51
byte 1 0
align 1
LABELV $1463
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1455
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 98
byte 1 114
byte 1 97
byte 1 105
byte 1 110
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1452
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 115
byte 1 107
byte 1 117
byte 1 108
byte 1 108
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1449
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 108
byte 1 101
byte 1 103
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1446
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 105
byte 1 110
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1443
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 102
byte 1 111
byte 1 114
byte 1 101
byte 1 97
byte 1 114
byte 1 109
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1440
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1437
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 102
byte 1 105
byte 1 115
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1434
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 99
byte 1 104
byte 1 101
byte 1 115
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1431
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 97
byte 1 114
byte 1 109
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1428
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 97
byte 1 98
byte 1 100
byte 1 111
byte 1 109
byte 1 101
byte 1 110
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1425
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 50
byte 1 47
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 47
byte 1 115
byte 1 95
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1422
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 50
byte 1 47
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 47
byte 1 109
byte 1 95
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1419
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 114
byte 1 95
byte 1 121
byte 1 101
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $1416
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 47
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 95
byte 1 121
byte 1 101
byte 1 108
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1405
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 114
byte 1 101
byte 1 100
byte 1 73
byte 1 110
byte 1 118
byte 1 105
byte 1 115
byte 1 0
align 1
LABELV $1402
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 73
byte 1 110
byte 1 118
byte 1 105
byte 1 115
byte 1 0
align 1
LABELV $1399
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 98
byte 1 97
byte 1 114
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1396
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $1393
byte 1 115
byte 1 112
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 115
byte 1 47
byte 1 102
byte 1 111
byte 1 101
byte 1 0
align 1
LABELV $1385
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 51
byte 1 0
align 1
LABELV $1381
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 50
byte 1 0
align 1
LABELV $1377
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 49
byte 1 0
align 1
LABELV $1374
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1370
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 50
byte 1 0
align 1
LABELV $1366
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 49
byte 1 0
align 1
LABELV $1363
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 47
byte 1 98
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1360
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 47
byte 1 114
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1352
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 115
byte 1 107
byte 1 117
byte 1 108
byte 1 108
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $1349
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 115
byte 1 107
byte 1 117
byte 1 108
byte 1 108
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $1346
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 111
byte 1 114
byte 1 98
byte 1 47
byte 1 98
byte 1 95
byte 1 111
byte 1 114
byte 1 98
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1343
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 111
byte 1 114
byte 1 98
byte 1 47
byte 1 114
byte 1 95
byte 1 111
byte 1 114
byte 1 98
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1335
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 65
byte 1 109
byte 1 112
byte 1 108
byte 1 105
byte 1 102
byte 1 105
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1332
byte 1 115
byte 1 99
byte 1 97
byte 1 110
byte 1 110
byte 1 101
byte 1 114
byte 1 70
byte 1 105
byte 1 108
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1329
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 98
byte 1 111
byte 1 110
byte 1 101
byte 1 115
byte 1 47
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 95
byte 1 98
byte 1 111
byte 1 110
byte 1 101
byte 1 115
byte 1 46
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $1323
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 66
byte 1 108
byte 1 117
byte 1 114
byte 1 114
byte 1 121
byte 1 0
align 1
LABELV $1320
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 104
byte 1 117
byte 1 110
byte 1 116
byte 1 95
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1317
byte 1 104
byte 1 111
byte 1 116
byte 1 65
byte 1 105
byte 1 114
byte 1 0
align 1
LABELV $1314
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 50
byte 1 47
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 108
byte 1 47
byte 1 115
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $1311
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 99
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $1308
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 100
byte 1 101
byte 1 116
byte 1 101
byte 1 99
byte 1 116
byte 1 111
byte 1 114
byte 1 95
byte 1 98
byte 1 101
byte 1 101
byte 1 112
byte 1 0
align 1
LABELV $1305
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 108
byte 1 105
byte 1 102
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $1302
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 101
byte 1 102
byte 1 97
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $1296
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 102
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $1293
byte 1 110
byte 1 97
byte 1 118
byte 1 65
byte 1 105
byte 1 100
byte 1 84
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $1290
byte 1 110
byte 1 97
byte 1 118
byte 1 65
byte 1 105
byte 1 100
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $1287
byte 1 110
byte 1 97
byte 1 118
byte 1 97
byte 1 105
byte 1 100
byte 1 108
byte 1 105
byte 1 110
byte 1 101
byte 1 50
byte 1 0
align 1
LABELV $1284
byte 1 110
byte 1 97
byte 1 118
byte 1 97
byte 1 105
byte 1 100
byte 1 108
byte 1 105
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $1281
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 72
byte 1 117
byte 1 108
byte 1 108
byte 1 71
byte 1 108
byte 1 111
byte 1 119
byte 1 52
byte 1 87
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1278
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 72
byte 1 117
byte 1 108
byte 1 108
byte 1 71
byte 1 108
byte 1 111
byte 1 119
byte 1 51
byte 1 87
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1275
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 72
byte 1 117
byte 1 108
byte 1 108
byte 1 71
byte 1 108
byte 1 111
byte 1 119
byte 1 50
byte 1 87
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1272
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 72
byte 1 117
byte 1 108
byte 1 108
byte 1 71
byte 1 108
byte 1 111
byte 1 119
byte 1 49
byte 1 87
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1269
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 72
byte 1 117
byte 1 108
byte 1 108
byte 1 87
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1266
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 72
byte 1 117
byte 1 108
byte 1 108
byte 1 71
byte 1 108
byte 1 111
byte 1 119
byte 1 52
byte 1 0
align 1
LABELV $1263
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 72
byte 1 117
byte 1 108
byte 1 108
byte 1 71
byte 1 108
byte 1 111
byte 1 119
byte 1 51
byte 1 0
align 1
LABELV $1260
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 72
byte 1 117
byte 1 108
byte 1 108
byte 1 71
byte 1 108
byte 1 111
byte 1 119
byte 1 50
byte 1 0
align 1
LABELV $1257
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 72
byte 1 117
byte 1 108
byte 1 108
byte 1 71
byte 1 108
byte 1 111
byte 1 119
byte 1 49
byte 1 0
align 1
LABELV $1254
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 72
byte 1 117
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $1251
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 103
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 67
byte 1 108
byte 1 111
byte 1 97
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 83
byte 1 112
byte 1 101
byte 1 99
byte 1 117
byte 1 108
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $1248
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 103
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 67
byte 1 108
byte 1 111
byte 1 97
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $1245
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 115
byte 1 104
byte 1 105
byte 1 101
byte 1 108
byte 1 100
byte 1 87
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1242
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 115
byte 1 104
byte 1 105
byte 1 101
byte 1 108
byte 1 100
byte 1 0
align 1
LABELV $1239
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 77
byte 1 97
byte 1 114
byte 1 107
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1236
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 87
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1233
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $1230
byte 1 104
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 83
byte 1 109
byte 1 111
byte 1 107
byte 1 101
byte 1 80
byte 1 117
byte 1 102
byte 1 102
byte 1 0
align 1
LABELV $1227
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 114
byte 1 101
byte 1 103
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $1224
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 115
byte 1 116
byte 1 100
byte 1 73
byte 1 110
byte 1 118
byte 1 105
byte 1 115
byte 1 0
align 1
LABELV $1221
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 87
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1218
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 83
byte 1 117
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $1215
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 113
byte 1 117
byte 1 97
byte 1 100
byte 1 87
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1212
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 113
byte 1 117
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $1209
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 110
byte 1 111
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 0
align 1
LABELV $1206
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 116
byte 1 105
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $1203
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 37
byte 1 99
byte 1 0
align 1
LABELV $1196
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 115
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $1193
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 116
byte 1 114
byte 1 97
byte 1 99
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1190
byte 1 119
byte 1 97
byte 1 116
byte 1 101
byte 1 114
byte 1 66
byte 1 117
byte 1 98
byte 1 98
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $1187
byte 1 100
byte 1 105
byte 1 115
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $1184
byte 1 108
byte 1 97
byte 1 103
byte 1 111
byte 1 109
byte 1 101
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1181
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 47
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 95
byte 1 98
byte 1 108
byte 1 111
byte 1 111
byte 1 100
byte 1 95
byte 1 101
byte 1 120
byte 1 112
byte 1 108
byte 1 111
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1178
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 66
byte 1 108
byte 1 111
byte 1 111
byte 1 100
byte 1 84
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 50
byte 1 0
align 1
LABELV $1175
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 66
byte 1 108
byte 1 111
byte 1 111
byte 1 100
byte 1 84
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 49
byte 1 0
align 1
LABELV $1172
byte 1 98
byte 1 108
byte 1 111
byte 1 111
byte 1 100
byte 1 84
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 0
align 1
LABELV $1169
byte 1 115
byte 1 112
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 49
byte 1 0
align 1
LABELV $1166
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 83
byte 1 109
byte 1 111
byte 1 107
byte 1 101
byte 1 80
byte 1 117
byte 1 102
byte 1 102
byte 1 0
align 1
LABELV $1163
byte 1 115
byte 1 109
byte 1 111
byte 1 107
byte 1 101
byte 1 80
byte 1 117
byte 1 102
byte 1 102
byte 1 82
byte 1 97
byte 1 103
byte 1 101
byte 1 80
byte 1 114
byte 1 111
byte 1 0
align 1
LABELV $1160
byte 1 115
byte 1 109
byte 1 111
byte 1 107
byte 1 101
byte 1 80
byte 1 117
byte 1 102
byte 1 102
byte 1 0
align 1
LABELV $1157
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 116
byte 1 97
byte 1 98
byte 1 47
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1154
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 116
byte 1 97
byte 1 98
byte 1 47
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1151
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 116
byte 1 97
byte 1 98
byte 1 47
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1148
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 116
byte 1 97
byte 1 98
byte 1 47
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1145
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 114
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1142
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 66
byte 1 108
byte 1 111
byte 1 111
byte 1 100
byte 1 66
byte 1 108
byte 1 101
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $1139
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 53
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1135
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 52
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1131
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 51
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1127
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 50
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1123
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 49
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1114
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 109
byte 1 101
byte 1 100
byte 1 105
byte 1 97
byte 1 0
align 1
LABELV $1112
byte 1 37
byte 1 115
byte 1 95
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $1108
byte 1 37
byte 1 115
byte 1 95
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $1104
byte 1 37
byte 1 115
byte 1 95
byte 1 98
byte 1 107
byte 1 0
align 1
LABELV $1100
byte 1 37
byte 1 115
byte 1 95
byte 1 102
byte 1 116
byte 1 0
align 1
LABELV $1096
byte 1 37
byte 1 115
byte 1 95
byte 1 100
byte 1 110
byte 1 0
align 1
LABELV $1085
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
byte 1 115
byte 1 0
align 1
LABELV $1080
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 109
byte 1 105
byte 1 110
byte 1 117
byte 1 115
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $1079
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 110
byte 1 105
byte 1 110
byte 1 101
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $1078
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 101
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $1077
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 115
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $1076
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 115
byte 1 105
byte 1 120
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $1075
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 102
byte 1 105
byte 1 118
byte 1 101
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $1074
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 102
byte 1 111
byte 1 117
byte 1 114
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $1073
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 116
byte 1 104
byte 1 114
byte 1 101
byte 1 101
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $1072
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 116
byte 1 119
byte 1 111
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $1071
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 111
byte 1 110
byte 1 101
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $1070
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 122
byte 1 101
byte 1 114
byte 1 111
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $1066
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
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $1053
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $1050
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
LABELV $1049
byte 1 115
byte 1 117
byte 1 110
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
byte 1 121
byte 1 32
byte 1 99
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $1038
byte 1 94
byte 1 51
byte 1 117
byte 1 110
byte 1 100
byte 1 101
byte 1 102
byte 1 105
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 115
byte 1 117
byte 1 110
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 101
byte 1 102
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $1026
byte 1 94
byte 1 51
byte 1 117
byte 1 110
byte 1 101
byte 1 120
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $1023
byte 1 109
byte 1 118
byte 1 0
align 1
LABELV $1018
byte 1 108
byte 1 114
byte 1 0
align 1
LABELV $1002
byte 1 94
byte 1 51
byte 1 117
byte 1 110
byte 1 100
byte 1 101
byte 1 102
byte 1 105
byte 1 110
byte 1 101
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
byte 1 102
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $999
byte 1 94
byte 1 51
byte 1 117
byte 1 110
byte 1 101
byte 1 120
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 101
byte 1 110
byte 1 100
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $996
byte 1 94
byte 1 51
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 44
byte 1 32
byte 1 101
byte 1 120
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 39
byte 1 123
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $980
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
byte 1 102
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 115
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $967
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $966
byte 1 37
byte 1 115
byte 1 46
byte 1 108
byte 1 102
byte 1 115
byte 1 0
align 1
LABELV $965
byte 1 102
byte 1 108
byte 1 97
byte 1 114
byte 1 101
byte 1 115
byte 1 47
byte 1 0
align 1
LABELV $960
byte 1 102
byte 1 97
byte 1 100
byte 1 101
byte 1 65
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $957
byte 1 114
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $952
byte 1 94
byte 1 51
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 109
byte 1 97
byte 1 110
byte 1 121
byte 1 32
byte 1 108
byte 1 101
byte 1 110
byte 1 115
byte 1 102
byte 1 108
byte 1 97
byte 1 114
byte 1 101
byte 1 115
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 32
byte 1 40
byte 1 109
byte 1 97
byte 1 120
byte 1 61
byte 1 37
byte 1 100
byte 1 41
byte 1 10
byte 1 0
align 1
LABELV $945
byte 1 94
byte 1 51
byte 1 117
byte 1 110
byte 1 101
byte 1 120
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 101
byte 1 110
byte 1 100
byte 1 32
byte 1 111
byte 1 102
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
byte 1 102
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $939
byte 1 94
byte 1 51
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 44
byte 1 32
byte 1 101
byte 1 120
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 39
byte 1 123
byte 1 39
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $938
byte 1 123
byte 1 0
align 1
LABELV $928
byte 1 115
byte 1 117
byte 1 110
byte 1 112
byte 1 97
byte 1 114
byte 1 109
byte 1 0
align 1
LABELV $925
byte 1 102
byte 1 108
byte 1 97
byte 1 114
byte 1 101
byte 1 115
byte 1 47
byte 1 105
byte 1 109
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 47
byte 1 0
align 1
LABELV $924
byte 1 105
byte 1 109
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $898
byte 1 94
byte 1 51
byte 1 117
byte 1 110
byte 1 101
byte 1 120
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $897
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 110
byte 1 115
byte 1 105
byte 1 116
byte 1 121
byte 1 84
byte 1 104
byte 1 114
byte 1 101
byte 1 115
byte 1 104
byte 1 111
byte 1 108
byte 1 100
byte 1 0
align 1
LABELV $892
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 65
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 70
byte 1 97
byte 1 99
byte 1 116
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $887
byte 1 102
byte 1 97
byte 1 100
byte 1 101
byte 1 65
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 70
byte 1 97
byte 1 99
byte 1 116
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $884
byte 1 114
byte 1 111
byte 1 116
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $881
byte 1 97
byte 1 108
byte 1 112
byte 1 104
byte 1 97
byte 1 0
align 1
LABELV $876
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $873
byte 1 112
byte 1 111
byte 1 115
byte 1 0
align 1
LABELV $870
byte 1 94
byte 1 51
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $869
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $866
byte 1 103
byte 1 108
byte 1 97
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $863
byte 1 114
byte 1 101
byte 1 102
byte 1 108
byte 1 101
byte 1 120
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $860
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $855
byte 1 115
byte 1 104
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $852
byte 1 125
byte 1 0
align 1
LABELV $849
byte 1 94
byte 1 51
byte 1 117
byte 1 110
byte 1 101
byte 1 120
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 101
byte 1 110
byte 1 100
byte 1 32
byte 1 111
byte 1 102
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
byte 1 100
byte 1 101
byte 1 102
byte 1 105
byte 1 110
byte 1 105
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $842
byte 1 114
byte 1 101
byte 1 97
byte 1 100
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
LABELV $841
byte 1 94
byte 1 51
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 108
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 32
byte 1 62
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $838
byte 1 94
byte 1 51
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $834
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $807
byte 1 108
byte 1 102
byte 1 101
byte 1 109
byte 1 109
byte 1 32
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $780
byte 1 108
byte 1 102
byte 1 101
byte 1 109
byte 1 109
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 0
align 1
LABELV $744
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 47
byte 1 104
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 98
byte 1 50
byte 1 97
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $741
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 47
byte 1 104
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 98
byte 1 49
byte 1 97
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $738
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 110
byte 1 95
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $735
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 112
byte 1 114
byte 1 111
byte 1 116
byte 1 101
byte 1 99
byte 1 116
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $732
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 114
byte 1 101
byte 1 103
byte 1 101
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $729
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 120
byte 1 49
byte 1 97
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $726
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 47
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 108
byte 1 120
byte 1 49
byte 1 97
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $723
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 117
byte 1 110
byte 1 47
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 102
byte 1 49
byte 1 97
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $720
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 109
byte 1 97
byte 1 99
byte 1 104
byte 1 105
byte 1 110
byte 1 101
byte 1 103
byte 1 117
byte 1 110
byte 1 47
byte 1 114
byte 1 105
byte 1 99
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $717
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 109
byte 1 97
byte 1 99
byte 1 104
byte 1 105
byte 1 110
byte 1 101
byte 1 103
byte 1 117
byte 1 110
byte 1 47
byte 1 114
byte 1 105
byte 1 99
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $714
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 109
byte 1 97
byte 1 99
byte 1 104
byte 1 105
byte 1 110
byte 1 101
byte 1 103
byte 1 117
byte 1 110
byte 1 47
byte 1 114
byte 1 105
byte 1 99
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $711
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $708
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 117
byte 1 115
byte 1 101
byte 1 95
byte 1 109
byte 1 101
byte 1 100
byte 1 107
byte 1 105
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $705
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $689
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 112
byte 1 97
byte 1 110
byte 1 116
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $686
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 112
byte 1 97
byte 1 110
byte 1 116
byte 1 102
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $683
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 112
byte 1 97
byte 1 110
byte 1 116
byte 1 109
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $680
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 100
byte 1 101
byte 1 116
byte 1 101
byte 1 99
byte 1 116
byte 1 111
byte 1 114
byte 1 95
byte 1 98
byte 1 101
byte 1 101
byte 1 112
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $677
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 95
byte 1 97
byte 1 114
byte 1 116
byte 1 101
byte 1 102
byte 1 97
byte 1 99
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $671
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 101
byte 1 97
byte 1 114
byte 1 116
byte 1 104
byte 1 113
byte 1 117
byte 1 97
byte 1 107
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $668
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 98
byte 1 111
byte 1 117
byte 1 110
byte 1 99
byte 1 101
byte 1 95
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 66
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $665
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 98
byte 1 111
byte 1 117
byte 1 110
byte 1 99
byte 1 101
byte 1 95
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 66
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $662
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 98
byte 1 111
byte 1 117
byte 1 110
byte 1 99
byte 1 101
byte 1 95
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 66
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $659
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 98
byte 1 111
byte 1 117
byte 1 110
byte 1 99
byte 1 101
byte 1 95
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 65
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $656
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 98
byte 1 111
byte 1 117
byte 1 110
byte 1 99
byte 1 101
byte 1 95
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 65
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $653
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 98
byte 1 111
byte 1 117
byte 1 110
byte 1 99
byte 1 101
byte 1 95
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 65
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $650
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 115
byte 1 115
byte 1 98
byte 1 101
byte 1 101
byte 1 112
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $647
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 95
byte 1 119
byte 1 97
byte 1 114
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $644
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 101
byte 1 120
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $641
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $635
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 47
byte 1 99
byte 1 108
byte 1 97
byte 1 110
byte 1 107
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $631
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 47
byte 1 115
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $627
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 47
byte 1 101
byte 1 110
byte 1 101
byte 1 114
byte 1 103
byte 1 121
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $623
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 47
byte 1 109
byte 1 101
byte 1 99
byte 1 104
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $619
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 101
byte 1 115
byte 1 104
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $615
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 47
byte 1 98
byte 1 111
byte 1 111
byte 1 116
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $612
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 47
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $607
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 47
byte 1 106
byte 1 117
byte 1 109
byte 1 112
byte 1 112
byte 1 97
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $604
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 119
byte 1 97
byte 1 116
byte 1 114
byte 1 95
byte 1 117
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $601
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 119
byte 1 97
byte 1 116
byte 1 114
byte 1 95
byte 1 111
byte 1 117
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $598
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 119
byte 1 97
byte 1 116
byte 1 114
byte 1 95
byte 1 105
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $595
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 108
byte 1 111
byte 1 115
byte 1 116
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $592
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 116
byte 1 105
byte 1 101
byte 1 100
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $589
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 116
byte 1 97
byte 1 107
byte 1 101
byte 1 110
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $586
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $583
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 97
byte 1 115
byte 1 115
byte 1 105
byte 1 115
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $580
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 104
byte 1 117
byte 1 109
byte 1 105
byte 1 108
byte 1 105
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $577
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 100
byte 1 101
byte 1 110
byte 1 105
byte 1 101
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $574
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 101
byte 1 120
byte 1 99
byte 1 101
byte 1 108
byte 1 108
byte 1 101
byte 1 110
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $571
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 105
byte 1 109
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 105
byte 1 118
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $568
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 104
byte 1 105
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $565
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 108
byte 1 97
byte 1 110
byte 1 100
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $562
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 116
byte 1 97
byte 1 108
byte 1 107
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $559
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 110
byte 1 111
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $556
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $553
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 111
byte 1 117
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $550
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 105
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $547
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 105
byte 1 109
byte 1 112
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $544
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 105
byte 1 109
byte 1 112
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $541
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 105
byte 1 109
byte 1 112
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $538
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 112
byte 1 108
byte 1 116
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $535
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 117
byte 1 115
byte 1 101
byte 1 95
byte 1 110
byte 1 111
byte 1 116
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $532
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 114
byte 1 111
byte 1 102
byte 1 102
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $529
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $526
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 109
byte 1 97
byte 1 99
byte 1 104
byte 1 105
byte 1 110
byte 1 101
byte 1 103
byte 1 117
byte 1 110
byte 1 47
byte 1 98
byte 1 117
byte 1 108
byte 1 101
byte 1 116
byte 1 98
byte 1 121
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $523
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 95
byte 1 49
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $520
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 49
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $515
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 104
byte 1 111
byte 1 108
byte 1 121
byte 1 115
byte 1 104
byte 1 105
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $512
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 121
byte 1 111
byte 1 117
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $509
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $506
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $503
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 95
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $500
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 95
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $492
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 116
byte 1 97
byte 1 107
byte 1 101
byte 1 110
byte 1 95
byte 1 111
byte 1 112
byte 1 112
byte 1 111
byte 1 110
byte 1 101
byte 1 110
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $489
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 116
byte 1 97
byte 1 107
byte 1 101
byte 1 110
byte 1 95
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $486
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 95
byte 1 111
byte 1 112
byte 1 112
byte 1 111
byte 1 110
byte 1 101
byte 1 110
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $483
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 95
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $480
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 95
byte 1 111
byte 1 112
byte 1 112
byte 1 111
byte 1 110
byte 1 101
byte 1 110
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $475
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $472
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $469
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 104
byte 1 105
byte 1 116
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 109
byte 1 97
byte 1 116
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $466
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 115
byte 1 116
byte 1 105
byte 1 101
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $463
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $460
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 114
byte 1 101
byte 1 100
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $457
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 95
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $449
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 112
byte 1 114
byte 1 101
byte 1 112
byte 1 97
byte 1 114
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $446
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 102
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $443
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 111
byte 1 110
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $440
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 116
byte 1 119
byte 1 111
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $437
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 116
byte 1 104
byte 1 114
byte 1 101
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $434
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 51
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $431
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 50
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $428
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 49
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $425
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 115
byte 1 117
byte 1 100
byte 1 100
byte 1 101
byte 1 110
byte 1 95
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $422
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 53
byte 1 95
byte 1 109
byte 1 105
byte 1 110
byte 1 117
byte 1 116
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $419
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 49
byte 1 95
byte 1 109
byte 1 105
byte 1 110
byte 1 117
byte 1 116
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $416
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 115
byte 1 105
byte 1 108
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $412
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $406
byte 1 80
byte 1 114
byte 1 101
byte 1 99
byte 1 97
byte 1 99
byte 1 104
byte 1 101
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 98
byte 1 97
byte 1 100
byte 1 32
byte 1 112
byte 1 114
byte 1 101
byte 1 99
byte 1 97
byte 1 99
byte 1 104
byte 1 101
byte 1 32
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $385
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $322
byte 1 117
byte 1 114
byte 1 105
byte 1 101
byte 1 108
byte 1 47
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $321
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 51
byte 1 0
align 1
LABELV $320
byte 1 116
byte 1 97
byte 1 110
byte 1 107
byte 1 106
byte 1 114
byte 1 47
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $319
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 50
byte 1 0
align 1
LABELV $318
byte 1 107
byte 1 108
byte 1 101
byte 1 115
byte 1 107
byte 1 47
byte 1 109
byte 1 97
byte 1 110
byte 1 101
byte 1 97
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $317
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 49
byte 1 0
align 1
LABELV $316
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
LABELV $315
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $314
byte 1 99
byte 1 114
byte 1 111
byte 1 117
byte 1 99
byte 1 104
byte 1 67
byte 1 117
byte 1 116
byte 1 115
byte 1 82
byte 1 111
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $313
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $312
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $311
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $310
byte 1 115
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $309
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $306
byte 1 115
byte 1 118
byte 1 95
byte 1 114
byte 1 117
byte 1 110
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $300
byte 1 48
byte 1 46
byte 1 48
byte 1 0
align 1
LABELV $299
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 114
byte 1 117
byte 1 101
byte 1 76
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $298
byte 1 99
byte 1 103
byte 1 95
byte 1 111
byte 1 108
byte 1 100
byte 1 80
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 0
align 1
LABELV $297
byte 1 99
byte 1 103
byte 1 95
byte 1 111
byte 1 108
byte 1 100
byte 1 82
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $296
byte 1 99
byte 1 103
byte 1 95
byte 1 111
byte 1 108
byte 1 100
byte 1 82
byte 1 97
byte 1 105
byte 1 108
byte 1 0
align 1
LABELV $295
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 105
byte 1 103
byte 1 70
byte 1 111
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $294
byte 1 48
byte 1 46
byte 1 50
byte 1 53
byte 1 0
align 1
LABELV $293
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 109
byte 1 97
byte 1 108
byte 1 108
byte 1 70
byte 1 111
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $292
byte 1 99
byte 1 103
byte 1 95
byte 1 110
byte 1 111
byte 1 80
byte 1 114
byte 1 111
byte 1 106
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 108
byte 1 101
byte 1 84
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 0
align 1
LABELV $291
byte 1 99
byte 1 103
byte 1 95
byte 1 110
byte 1 111
byte 1 84
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $290
byte 1 56
byte 1 0
align 1
LABELV $289
byte 1 112
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 95
byte 1 109
byte 1 115
byte 1 101
byte 1 99
byte 1 0
align 1
LABELV $288
byte 1 112
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 95
byte 1 102
byte 1 105
byte 1 120
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $287
byte 1 99
byte 1 103
byte 1 95
byte 1 109
byte 1 117
byte 1 115
byte 1 105
byte 1 99
byte 1 0
align 1
LABELV $286
byte 1 99
byte 1 111
byte 1 109
byte 1 95
byte 1 99
byte 1 97
byte 1 109
byte 1 101
byte 1 114
byte 1 97
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $285
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 109
byte 1 111
byte 1 111
byte 1 116
byte 1 104
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $284
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 80
byte 1 108
byte 1 117
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $283
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 115
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $282
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 115
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 70
byte 1 97
byte 1 100
byte 1 101
byte 1 83
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $281
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 115
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 70
byte 1 97
byte 1 100
byte 1 101
byte 1 69
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $280
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
byte 1 68
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $279
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
LABELV $278
byte 1 103
byte 1 95
byte 1 115
byte 1 121
byte 1 110
byte 1 99
byte 1 104
byte 1 114
byte 1 111
byte 1 110
byte 1 111
byte 1 117
byte 1 115
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $277
byte 1 99
byte 1 111
byte 1 109
byte 1 95
byte 1 98
byte 1 108
byte 1 111
byte 1 111
byte 1 100
byte 1 0
align 1
LABELV $276
byte 1 99
byte 1 108
byte 1 95
byte 1 112
byte 1 97
byte 1 117
byte 1 115
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $275
byte 1 99
byte 1 111
byte 1 109
byte 1 95
byte 1 98
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 83
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 0
align 1
LABELV $274
byte 1 99
byte 1 103
byte 1 95
byte 1 110
byte 1 111
byte 1 86
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 84
byte 1 101
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $273
byte 1 99
byte 1 103
byte 1 95
byte 1 110
byte 1 111
byte 1 86
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 67
byte 1 104
byte 1 97
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $272
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 67
byte 1 104
byte 1 97
byte 1 116
byte 1 115
byte 1 79
byte 1 110
byte 1 108
byte 1 121
byte 1 0
align 1
LABELV $271
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 70
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $270
byte 1 99
byte 1 103
byte 1 95
byte 1 97
byte 1 117
byte 1 116
byte 1 111
byte 1 71
byte 1 76
byte 1 67
byte 1 0
align 1
LABELV $269
byte 1 99
byte 1 103
byte 1 95
byte 1 110
byte 1 101
byte 1 97
byte 1 114
byte 1 98
byte 1 111
byte 1 120
byte 1 0
align 1
LABELV $268
byte 1 99
byte 1 103
byte 1 95
byte 1 66
byte 1 70
byte 1 71
byte 1 115
byte 1 117
byte 1 112
byte 1 101
byte 1 114
byte 1 69
byte 1 120
byte 1 112
byte 1 108
byte 1 0
align 1
LABELV $267
byte 1 99
byte 1 103
byte 1 95
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 108
byte 1 101
byte 1 70
byte 1 108
byte 1 97
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $266
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 117
byte 1 110
byte 1 70
byte 1 108
byte 1 97
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $265
byte 1 50
byte 1 0
align 1
LABELV $264
byte 1 99
byte 1 103
byte 1 95
byte 1 109
byte 1 97
byte 1 112
byte 1 70
byte 1 108
byte 1 97
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $263
byte 1 99
byte 1 103
byte 1 95
byte 1 108
byte 1 101
byte 1 110
byte 1 115
byte 1 70
byte 1 108
byte 1 97
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $262
byte 1 99
byte 1 103
byte 1 95
byte 1 103
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 67
byte 1 108
byte 1 111
byte 1 97
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $261
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $260
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $259
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 79
byte 1 118
byte 1 101
byte 1 114
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $258
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 114
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $257
byte 1 99
byte 1 103
byte 1 95
byte 1 112
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $256
byte 1 99
byte 1 103
byte 1 95
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $255
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 67
byte 1 104
byte 1 97
byte 1 116
byte 1 72
byte 1 101
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $254
byte 1 51
byte 1 48
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $253
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 67
byte 1 104
byte 1 97
byte 1 116
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $252
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
LABELV $251
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
LABELV $250
byte 1 52
byte 1 48
byte 1 0
align 1
LABELV $249
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
LABELV $248
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 114
byte 1 97
byte 1 99
byte 1 101
byte 1 114
byte 1 108
byte 1 101
byte 1 110
byte 1 103
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $247
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 114
byte 1 97
byte 1 99
byte 1 101
byte 1 114
byte 1 119
byte 1 105
byte 1 100
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $246
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 114
byte 1 97
byte 1 99
byte 1 101
byte 1 114
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $245
byte 1 99
byte 1 103
byte 1 95
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $244
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 104
byte 1 111
byte 1 119
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 0
align 1
LABELV $243
byte 1 99
byte 1 103
byte 1 95
byte 1 110
byte 1 111
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $242
byte 1 99
byte 1 103
byte 1 95
byte 1 110
byte 1 111
byte 1 112
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $241
byte 1 99
byte 1 103
byte 1 95
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 100
byte 1 101
byte 1 99
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $240
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 98
byte 1 117
byte 1 103
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $239
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 98
byte 1 117
byte 1 103
byte 1 112
byte 1 111
byte 1 115
byte 1 105
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $238
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 98
byte 1 117
byte 1 103
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 0
align 1
LABELV $237
byte 1 99
byte 1 103
byte 1 95
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $236
byte 1 48
byte 1 46
byte 1 51
byte 1 0
align 1
LABELV $235
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 119
byte 1 105
byte 1 110
byte 1 103
byte 1 83
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $234
byte 1 99
byte 1 103
byte 1 95
byte 1 98
byte 1 111
byte 1 98
byte 1 114
byte 1 111
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $233
byte 1 99
byte 1 103
byte 1 95
byte 1 98
byte 1 111
byte 1 98
byte 1 112
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $232
byte 1 99
byte 1 103
byte 1 95
byte 1 98
byte 1 111
byte 1 98
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $231
byte 1 48
byte 1 46
byte 1 48
byte 1 48
byte 1 53
byte 1 0
align 1
LABELV $230
byte 1 99
byte 1 103
byte 1 95
byte 1 114
byte 1 117
byte 1 110
byte 1 114
byte 1 111
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $229
byte 1 48
byte 1 46
byte 1 48
byte 1 48
byte 1 50
byte 1 0
align 1
LABELV $228
byte 1 99
byte 1 103
byte 1 95
byte 1 114
byte 1 117
byte 1 110
byte 1 112
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $227
byte 1 51
byte 1 0
align 1
LABELV $226
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 101
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $225
byte 1 99
byte 1 103
byte 1 95
byte 1 103
byte 1 117
byte 1 110
byte 1 90
byte 1 0
align 1
LABELV $224
byte 1 99
byte 1 103
byte 1 95
byte 1 103
byte 1 117
byte 1 110
byte 1 89
byte 1 0
align 1
LABELV $223
byte 1 99
byte 1 103
byte 1 95
byte 1 103
byte 1 117
byte 1 110
byte 1 88
byte 1 0
align 1
LABELV $222
byte 1 52
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $221
byte 1 99
byte 1 103
byte 1 95
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 84
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $220
byte 1 99
byte 1 103
byte 1 95
byte 1 108
byte 1 97
byte 1 103
byte 1 111
byte 1 109
byte 1 101
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $219
byte 1 99
byte 1 103
byte 1 95
byte 1 109
byte 1 97
byte 1 114
byte 1 107
byte 1 115
byte 1 0
align 1
LABELV $218
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 105
byte 1 109
byte 1 112
byte 1 108
byte 1 101
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $217
byte 1 50
byte 1 53
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $216
byte 1 99
byte 1 103
byte 1 95
byte 1 98
byte 1 114
byte 1 97
byte 1 115
byte 1 115
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $215
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 89
byte 1 0
align 1
LABELV $214
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 88
byte 1 0
align 1
LABELV $213
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $212
byte 1 50
byte 1 52
byte 1 0
align 1
LABELV $211
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 83
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $210
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 82
byte 1 101
byte 1 119
byte 1 97
byte 1 114
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $209
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 67
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $208
byte 1 52
byte 1 0
align 1
LABELV $207
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 67
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 0
align 1
LABELV $206
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 65
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $205
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 65
byte 1 109
byte 1 109
byte 1 111
byte 1 87
byte 1 97
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $204
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 73
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $203
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 51
byte 1 100
byte 1 73
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $202
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 83
byte 1 110
byte 1 97
byte 1 112
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $201
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 70
byte 1 80
byte 1 83
byte 1 0
align 1
LABELV $200
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $199
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $198
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 50
byte 1 68
byte 1 0
align 1
LABELV $197
byte 1 99
byte 1 103
byte 1 95
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 0
align 1
LABELV $196
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 104
byte 1 97
byte 1 100
byte 1 111
byte 1 119
byte 1 115
byte 1 0
align 1
LABELV $195
byte 1 48
byte 1 46
byte 1 52
byte 1 0
align 1
LABELV $194
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 101
byte 1 111
byte 1 83
byte 1 101
byte 1 112
byte 1 97
byte 1 114
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $193
byte 1 49
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $192
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
LABELV $191
byte 1 57
byte 1 48
byte 1 0
align 1
LABELV $190
byte 1 99
byte 1 103
byte 1 95
byte 1 102
byte 1 111
byte 1 118
byte 1 0
align 1
LABELV $189
byte 1 50
byte 1 50
byte 1 46
byte 1 53
byte 1 0
align 1
LABELV $188
byte 1 99
byte 1 103
byte 1 95
byte 1 122
byte 1 111
byte 1 111
byte 1 109
byte 1 102
byte 1 111
byte 1 118
byte 1 0
align 1
LABELV $187
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 71
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $186
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $185
byte 1 99
byte 1 103
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 79
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 53
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $183
byte 1 114
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $182
byte 1 99
byte 1 103
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 79
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 52
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $180
byte 1 97
byte 1 110
byte 1 110
byte 1 105
byte 1 104
byte 1 105
byte 1 108
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $179
byte 1 99
byte 1 103
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 79
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 51
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $177
byte 1 97
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $176
byte 1 99
byte 1 103
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 79
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 50
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $174
byte 1 99
byte 1 108
byte 1 111
byte 1 115
byte 1 101
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 98
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $173
byte 1 99
byte 1 103
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 79
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 49
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $171
byte 1 112
byte 1 117
byte 1 114
byte 1 115
byte 1 117
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $170
byte 1 99
byte 1 103
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 79
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 48
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $169
byte 1 76
byte 1 71
byte 1 69
byte 1 74
byte 1 73
byte 1 67
byte 1 68
byte 1 70
byte 1 72
byte 1 66
byte 1 0
align 1
LABELV $168
byte 1 99
byte 1 103
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 79
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 53
byte 1 0
align 1
LABELV $166
byte 1 72
byte 1 76
byte 1 74
byte 1 67
byte 1 70
byte 1 71
byte 1 73
byte 1 68
byte 1 69
byte 1 66
byte 1 0
align 1
LABELV $165
byte 1 99
byte 1 103
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 79
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 52
byte 1 0
align 1
LABELV $163
byte 1 74
byte 1 70
byte 1 67
byte 1 69
byte 1 73
byte 1 68
byte 1 72
byte 1 71
byte 1 76
byte 1 66
byte 1 0
align 1
LABELV $162
byte 1 99
byte 1 103
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 79
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 51
byte 1 0
align 1
LABELV $160
byte 1 70
byte 1 67
byte 1 73
byte 1 68
byte 1 71
byte 1 69
byte 1 74
byte 1 76
byte 1 72
byte 1 66
byte 1 0
align 1
LABELV $159
byte 1 99
byte 1 103
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 79
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 50
byte 1 0
align 1
LABELV $157
byte 1 68
byte 1 67
byte 1 71
byte 1 72
byte 1 76
byte 1 66
byte 1 73
byte 1 70
byte 1 69
byte 1 74
byte 1 0
align 1
LABELV $156
byte 1 99
byte 1 103
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 79
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 49
byte 1 0
align 1
LABELV $154
byte 1 73
byte 1 67
byte 1 70
byte 1 74
byte 1 68
byte 1 72
byte 1 71
byte 1 76
byte 1 69
byte 1 66
byte 1 0
align 1
LABELV $153
byte 1 99
byte 1 103
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 79
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 48
byte 1 0
align 1
LABELV $152
byte 1 53
byte 1 48
byte 1 0
align 1
LABELV $151
byte 1 99
byte 1 103
byte 1 95
byte 1 97
byte 1 117
byte 1 116
byte 1 111
byte 1 115
byte 1 119
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 65
byte 1 109
byte 1 109
byte 1 111
byte 1 76
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $150
byte 1 99
byte 1 103
byte 1 95
byte 1 97
byte 1 117
byte 1 116
byte 1 111
byte 1 115
byte 1 119
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $149
byte 1 99
byte 1 103
byte 1 95
byte 1 110
byte 1 111
byte 1 84
byte 1 114
byte 1 97
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $148
byte 1 116
byte 1 109
byte 1 112
byte 1 108
byte 1 99
byte 1 109
byte 1 100
byte 1 0
align 1
LABELV $147
byte 1 116
byte 1 115
byte 1 115
byte 1 105
byte 1 95
byte 1 107
byte 1 101
byte 1 121
byte 1 0
align 1
LABELV $146
byte 1 0
align 1
LABELV $145
byte 1 116
byte 1 115
byte 1 115
byte 1 105
byte 1 95
byte 1 109
byte 1 111
byte 1 117
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $144
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 83
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $143
byte 1 49
byte 1 0
align 1
LABELV $142
byte 1 99
byte 1 103
byte 1 95
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 98
byte 1 97
byte 1 108
byte 1 108
byte 1 84
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 0
align 1
LABELV $141
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 78
byte 1 117
byte 1 109
byte 1 77
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $140
byte 1 48
byte 1 0
align 1
LABELV $139
byte 1 99
byte 1 103
byte 1 95
byte 1 105
byte 1 103
byte 1 110
byte 1 111
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $136
byte 1 118
byte 1 109
byte 1 77
byte 1 97
byte 1 105
byte 1 110
byte 1 58
byte 1 32
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 105
byte 1 0
