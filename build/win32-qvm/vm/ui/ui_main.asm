export vmMain
code
proc vmMain 12 8
file "..\..\..\..\code\q3_ui\ui_main.c"
line 23
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:/*
;4:=======================================================================
;5:
;6:USER INTERFACE MAIN
;7:
;8:=======================================================================
;9:*/
;10:
;11:
;12:#include "ui_local.h"
;13:
;14:
;15:/*
;16:================
;17:vmMain
;18:
;19:This is the only way control passes into the module.
;20:This must be the very first function compiled into the .qvm file
;21:================
;22:*/
;23:int vmMain( int command, int arg0, int arg1, int arg2, int arg3, int arg4, int arg5, int arg6, int arg7, int arg8, int arg9, int arg10, int arg11  ) {
line 24
;24:	switch ( command ) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $97
ADDRLP4 0
INDIRI4
CNSTI4 10
GTI4 $97
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $110
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $110
address $99
address $100
address $101
address $102
address $103
address $104
address $105
address $106
address $107
address $108
address $109
code
LABELV $99
line 26
;25:	case UI_GETAPIVERSION:
;26:		return UI_API_VERSION;
CNSTI4 4
RETI4
ADDRGP4 $96
JUMPV
LABELV $100
line 29
;27:
;28:	case UI_INIT:
;29:		UI_Init();
ADDRGP4 UI_Init
CALLV
pop
line 30
;30:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $96
JUMPV
LABELV $101
line 33
;31:
;32:	case UI_SHUTDOWN:
;33:		UI_Shutdown();
ADDRGP4 UI_Shutdown
CALLV
pop
line 34
;34:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $96
JUMPV
LABELV $102
line 37
;35:
;36:	case UI_KEY_EVENT:
;37:		UI_KeyEvent( arg0, arg1 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 UI_KeyEvent
CALLV
pop
line 38
;38:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $96
JUMPV
LABELV $103
line 41
;39:
;40:	case UI_MOUSE_EVENT:
;41:		UI_MouseEvent( arg0, arg1 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 UI_MouseEvent
CALLV
pop
line 42
;42:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $96
JUMPV
LABELV $104
line 45
;43:
;44:	case UI_REFRESH:
;45:		UI_Refresh( arg0 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 UI_Refresh
CALLV
pop
line 46
;46:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $96
JUMPV
LABELV $105
line 49
;47:
;48:	case UI_IS_FULLSCREEN:
;49:		return UI_IsFullscreen();
ADDRLP4 4
ADDRGP4 UI_IsFullscreen
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $96
JUMPV
LABELV $106
line 52
;50:
;51:	case UI_SET_ACTIVE_MENU:
;52:		UI_SetActiveMenu( arg0 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 UI_SetActiveMenu
CALLV
pop
line 53
;53:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $96
JUMPV
LABELV $107
line 56
;54:
;55:	case UI_CONSOLE_COMMAND:
;56:		return UI_ConsoleCommand(arg0);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 UI_ConsoleCommand
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
ADDRGP4 $96
JUMPV
LABELV $108
line 59
;57:
;58:	case UI_DRAW_CONNECT_SCREEN:
;59:		UI_DrawConnectScreen( arg0 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 UI_DrawConnectScreen
CALLV
pop
line 60
;60:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $96
JUMPV
LABELV $109
line 62
;61:	case UI_HASUNIQUECDKEY:				// mod authors need to observe this
;62:		return /*qtrue*/qfalse;  // bk010117 - change this to qfalse for mods!
CNSTI4 0
RETI4
ADDRGP4 $96
JUMPV
LABELV $97
line 65
;63:	}
;64:
;65:	return -1;
CNSTI4 -1
RETI4
LABELV $96
endproc vmMain 12 8
data
align 4
LABELV cvarTable
address ui_ffa_fraglimit
address $112
address $113
byte 4 1
address ui_ffa_timelimit
address $114
address $115
byte 4 1
byte 4 0
address $116
address $115
byte 4 1
byte 4 0
address $117
address $115
byte 4 1
byte 4 0
address $118
address $115
byte 4 1
byte 4 0
address $119
address $115
byte 4 1
byte 4 0
address $120
address $115
byte 4 1
byte 4 0
address $121
address $122
byte 4 1
byte 4 0
address $123
address $115
byte 4 1
address ui_tourney_fraglimit
address $124
address $115
byte 4 1
address ui_tourney_timelimit
address $125
address $126
byte 4 1
byte 4 0
address $127
address $115
byte 4 1
byte 4 0
address $128
address $115
byte 4 1
byte 4 0
address $129
address $115
byte 4 1
byte 4 0
address $130
address $115
byte 4 1
byte 4 0
address $131
address $122
byte 4 1
byte 4 0
address $132
address $115
byte 4 1
address ui_team_fraglimit
address $133
address $115
byte 4 1
address ui_team_timelimit
address $134
address $113
byte 4 1
address ui_team_friendly
address $135
address $122
byte 4 1
byte 4 0
address $136
address $115
byte 4 1
address ui_team_tss
address $137
address $122
byte 4 1
byte 4 0
address $138
address $115
byte 4 1
byte 4 0
address $139
address $115
byte 4 1
byte 4 0
address $140
address $115
byte 4 1
byte 4 0
address $141
address $115
byte 4 1
byte 4 0
address $142
address $122
byte 4 1
byte 4 0
address $143
address $115
byte 4 1
address ui_ctf_capturelimit
address $144
address $145
byte 4 1
address ui_ctf_timelimit
address $146
address $147
byte 4 1
address ui_ctf_friendly
address $148
address $115
byte 4 1
byte 4 0
address $149
address $115
byte 4 1
address ui_ctf_tss
address $150
address $122
byte 4 1
byte 4 0
address $151
address $115
byte 4 1
byte 4 0
address $152
address $115
byte 4 1
byte 4 0
address $153
address $115
byte 4 1
byte 4 0
address $154
address $115
byte 4 1
byte 4 0
address $155
address $122
byte 4 1
byte 4 0
address $156
address $115
byte 4 1
byte 4 0
address $157
address $122
byte 4 1
byte 4 0
address $158
address $159
byte 4 1
byte 4 0
address $160
address $161
byte 4 1
byte 4 0
address $162
address $161
byte 4 1
byte 4 0
address $163
address $122
byte 4 1
byte 4 0
address $164
address $159
byte 4 1
byte 4 0
address $165
address $161
byte 4 1
byte 4 0
address $166
address $161
byte 4 1
byte 4 0
address $167
address $122
byte 4 1
byte 4 0
address $168
address $159
byte 4 1
byte 4 0
address $169
address $161
byte 4 1
byte 4 0
address $170
address $161
byte 4 1
byte 4 0
address $171
address $122
byte 4 1
byte 4 0
address $172
address $159
byte 4 1
byte 4 0
address $173
address $161
byte 4 1
byte 4 0
address $174
address $161
byte 4 1
byte 4 0
address $175
address $176
byte 4 64
byte 4 0
address $177
address $115
byte 4 33
byte 4 0
address $178
address $115
byte 4 1
byte 4 0
address $179
address $180
byte 4 1
byte 4 0
address $181
address $115
byte 4 1
byte 4 0
address $182
address $145
byte 4 1
byte 4 0
address $183
address $115
byte 4 1
byte 4 0
address $184
address $115
byte 4 1
byte 4 0
address $185
address $115
byte 4 1
byte 4 0
address $186
address $115
byte 4 1
byte 4 0
address $187
address $115
byte 4 1
byte 4 0
address $188
address $122
byte 4 1
byte 4 0
address $189
address $115
byte 4 1
byte 4 0
address $190
address $122
byte 4 1
byte 4 0
address $191
address $115
byte 4 1
byte 4 0
address $192
address $126
byte 4 1
byte 4 0
address $193
address $147
byte 4 1
byte 4 0
address $194
address $115
byte 4 1
byte 4 0
address $195
address $196
byte 4 1
byte 4 0
address $197
address $198
byte 4 1
byte 4 0
address $199
address $200
byte 4 1
byte 4 0
address $201
address $202
byte 4 1
byte 4 0
address $203
address $161
byte 4 1
byte 4 0
address $204
address $122
byte 4 1
byte 4 0
address $205
address $206
byte 4 1
byte 4 0
address $207
address $208
byte 4 1
byte 4 0
address $209
address $210
byte 4 1
byte 4 0
address $211
address $115
byte 4 1
byte 4 0
address $212
address $115
byte 4 1
byte 4 0
address $213
address $122
byte 4 1
byte 4 0
address $214
address $161
byte 4 1
byte 4 0
address $215
address $216
byte 4 1
byte 4 0
address $217
address $115
byte 4 1
byte 4 0
address $218
address $115
byte 4 1
byte 4 0
address $219
address $122
byte 4 1
byte 4 0
address $220
address $122
byte 4 1
byte 4 0
address $221
address $122
byte 4 1
byte 4 0
address $222
address $147
byte 4 1
byte 4 0
address $223
address $161
byte 4 1
byte 4 0
address $224
address $180
byte 4 1
byte 4 0
address $225
address $180
byte 4 1
byte 4 0
address $226
address $115
byte 4 1
byte 4 0
address $227
address $115
byte 4 1
byte 4 0
address $228
address $122
byte 4 1
byte 4 0
address $229
address $115
byte 4 1
byte 4 0
address $230
address $115
byte 4 24
byte 4 0
address $231
address $115
byte 4 1
byte 4 0
address $232
address $115
byte 4 1
byte 4 0
address $233
address $115
byte 4 1
byte 4 0
address $234
address $115
byte 4 1
byte 4 0
address $235
address $115
byte 4 1
byte 4 0
address $236
address $115
byte 4 1
address ui_additionalSlots
address $237
address $115
byte 4 1
address ui_tss
address $238
address $122
byte 4 1029
byte 4 0
address $239
address $122
byte 4 37
address ui_respawnAtPOD
address $240
address $115
byte 4 1025
address ui_armorFragments
address $241
address $115
byte 4 1025
address ui_stamina
address $242
address $115
byte 4 1029
address ui_baseHealth
address $243
address $244
byte 4 37
address ui_lightningDamageLimit
address $245
address $115
byte 4 1029
address ui_arenasFile
address $246
address $176
byte 4 80
address ui_botsFile
address $247
address $176
byte 4 80
address ui_spScores1
address $248
address $176
byte 4 65
address ui_spScores2
address $249
address $176
byte 4 65
address ui_spScores3
address $250
address $176
byte 4 65
address ui_spScores4
address $251
address $176
byte 4 65
address ui_spScores5
address $252
address $176
byte 4 65
address ui_spAwards
address $253
address $176
byte 4 65
address ui_spVideos
address $254
address $176
byte 4 65
address ui_spSkill
address $255
address $256
byte 4 33
byte 4 0
address $257
address $115
byte 4 37
byte 4 0
address $258
address $176
byte 4 64
address ui_spSelection
address $259
address $176
byte 4 64
address ui_browserMaster
address $260
address $115
byte 4 1
address ui_browserGameType
address $261
address $115
byte 4 1
address ui_browserSortKey
address $262
address $263
byte 4 1
address ui_browserShowFull
address $264
address $122
byte 4 1
address ui_browserShowEmpty
address $265
address $122
byte 4 1
address ui_brassTime
address $266
address $267
byte 4 1
address ui_drawCrosshair
address $268
address $263
byte 4 1
address ui_drawCrosshairNames
address $269
address $122
byte 4 1
address ui_marks
address $270
address $122
byte 4 1
byte 4 0
address $271
address $272
byte 4 1
byte 4 0
address $273
address $274
byte 4 1
byte 4 0
address $275
address $276
byte 4 1
byte 4 0
address $277
address $278
byte 4 1
byte 4 0
address $279
address $280
byte 4 1
byte 4 0
address $281
address $282
byte 4 1
byte 4 0
address $283
address $284
byte 4 1
byte 4 0
address $285
address $286
byte 4 1
byte 4 0
address $287
address $288
byte 4 1
byte 4 0
address $289
address $290
byte 4 1
byte 4 0
address $291
address $292
byte 4 1
byte 4 0
address $293
address $294
byte 4 1
byte 4 0
address $295
address $296
byte 4 1
byte 4 0
address $297
address $115
byte 4 1
byte 4 0
address $298
address $122
byte 4 1
byte 4 0
address $299
address $122
byte 4 1
byte 4 0
address $300
address $122
byte 4 1
byte 4 0
address $301
address $122
byte 4 3
byte 4 0
address $302
address $115
byte 4 64
byte 4 0
address $303
address $176
byte 4 64
byte 4 0
address $304
address $176
byte 4 64
byte 4 0
address $305
address $176
byte 4 64
byte 4 0
address $306
address $176
byte 4 1088
address ui_lensFlare
address $307
address $122
byte 4 1
address ui_hiDetailTitle
address $308
address $122
byte 4 1
address ui_server1
address $309
address $176
byte 4 1
address ui_server2
address $310
address $176
byte 4 1
address ui_server3
address $311
address $176
byte 4 1
address ui_server4
address $312
address $176
byte 4 1
address ui_server5
address $313
address $176
byte 4 1
address ui_server6
address $314
address $176
byte 4 1
address ui_server7
address $315
address $176
byte 4 1
address ui_server8
address $316
address $176
byte 4 1
address ui_server9
address $317
address $176
byte 4 1
address ui_server10
address $318
address $176
byte 4 1
address ui_server11
address $319
address $176
byte 4 1
address ui_server12
address $320
address $176
byte 4 1
address ui_server13
address $321
address $176
byte 4 1
address ui_server14
address $322
address $176
byte 4 1
address ui_server15
address $323
address $176
byte 4 1
address ui_server16
address $324
address $176
byte 4 1
byte 4 0
address $325
address $115
byte 4 64
byte 4 0
address $326
address $122
byte 4 1
byte 4 0
address $327
address $115
byte 4 1
byte 4 0
address $328
address $115
byte 4 16
address ui_cdkeychecked
address $329
address $115
byte 4 64
align 4
LABELV cvarTableSize
byte 4 183
export UI_RegisterCvars
code
proc UI_RegisterCvars 12 16
line 383
;66:}
;67:
;68:
;69:/*
;70:================
;71:cvars
;72:================
;73:*/
;74:
;75:typedef struct {
;76:	vmCvar_t	*vmCvar;
;77:	char		*cvarName;
;78:	char		*defaultString;
;79:	int			cvarFlags;
;80:} cvarTable_t;
;81:
;82:vmCvar_t	ui_ffa_fraglimit;
;83:vmCvar_t	ui_ffa_timelimit;
;84:
;85:vmCvar_t	ui_tourney_fraglimit;
;86:vmCvar_t	ui_tourney_timelimit;
;87:
;88:vmCvar_t	ui_team_fraglimit;
;89:vmCvar_t	ui_team_timelimit;
;90:vmCvar_t	ui_team_friendly;
;91:vmCvar_t	ui_team_tss;	// JUHOX
;92:
;93:vmCvar_t	ui_ctf_capturelimit;
;94:vmCvar_t	ui_ctf_timelimit;
;95:vmCvar_t	ui_ctf_friendly;
;96:vmCvar_t	ui_ctf_tss;	// JUHOX
;97:
;98:vmCvar_t	ui_additionalSlots;	// JUHOX
;99:vmCvar_t	ui_tss;	// JUHOX
;100:vmCvar_t	ui_respawnAtPOD;	// JUHOX
;101:vmCvar_t	ui_armorFragments;	// JUHOX
;102:vmCvar_t	ui_stamina;	// JUHOX
;103:vmCvar_t	ui_baseHealth;	// JUHOX
;104:vmCvar_t	ui_lightningDamageLimit;	// JUHOX
;105:
;106:vmCvar_t	ui_arenasFile;
;107:vmCvar_t	ui_botsFile;
;108:vmCvar_t	ui_spScores1;
;109:vmCvar_t	ui_spScores2;
;110:vmCvar_t	ui_spScores3;
;111:vmCvar_t	ui_spScores4;
;112:vmCvar_t	ui_spScores5;
;113:vmCvar_t	ui_spAwards;
;114:vmCvar_t	ui_spVideos;
;115:vmCvar_t	ui_spSkill;
;116:
;117:vmCvar_t	ui_spSelection;
;118:
;119:vmCvar_t	ui_browserMaster;
;120:vmCvar_t	ui_browserGameType;
;121:vmCvar_t	ui_browserSortKey;
;122:vmCvar_t	ui_browserShowFull;
;123:vmCvar_t	ui_browserShowEmpty;
;124:
;125:vmCvar_t	ui_brassTime;
;126:vmCvar_t	ui_drawCrosshair;
;127:vmCvar_t	ui_drawCrosshairNames;
;128:vmCvar_t	ui_marks;
;129:
;130:vmCvar_t	ui_lensFlare;	// JUHOX
;131:vmCvar_t	ui_hiDetailTitle;	// JUHOX
;132:
;133:vmCvar_t	ui_server1;
;134:vmCvar_t	ui_server2;
;135:vmCvar_t	ui_server3;
;136:vmCvar_t	ui_server4;
;137:vmCvar_t	ui_server5;
;138:vmCvar_t	ui_server6;
;139:vmCvar_t	ui_server7;
;140:vmCvar_t	ui_server8;
;141:vmCvar_t	ui_server9;
;142:vmCvar_t	ui_server10;
;143:vmCvar_t	ui_server11;
;144:vmCvar_t	ui_server12;
;145:vmCvar_t	ui_server13;
;146:vmCvar_t	ui_server14;
;147:vmCvar_t	ui_server15;
;148:vmCvar_t	ui_server16;
;149:
;150:vmCvar_t	ui_cdkeychecked;
;151:
;152:// bk001129 - made static to avoid aliasing.
;153:static cvarTable_t		cvarTable[] = {
;154:	{ &ui_ffa_fraglimit, "ui_ffa_fraglimit", "20", CVAR_ARCHIVE },
;155:	{ &ui_ffa_timelimit, "ui_ffa_timelimit", "0", CVAR_ARCHIVE },
;156:	{ NULL, "ui_ffa_respawndelay", "0", CVAR_ARCHIVE },	// JUHOX
;157:	{ NULL, "ui_ffa_gameseed", "0", CVAR_ARCHIVE },	// JUHOX
;158:	{ NULL, "ui_ffa_noItems", "0", CVAR_ARCHIVE },	// JUHOX
;159:	{ NULL, "ui_ffa_noHealthRegen", "0", CVAR_ARCHIVE },	// JUHOX
;160:	{ NULL, "ui_ffa_unlimitedAmmo", "0", CVAR_ARCHIVE },	// JUHOX
;161:	{ NULL, "ui_ffa_cloakingDevice", "1", CVAR_ARCHIVE },	// JUHOX
;162:	{ NULL, "ui_ffa_weaponLimit", "0", CVAR_ARCHIVE },	// JUHOX
;163:
;164:	{ &ui_tourney_fraglimit, "ui_tourney_fraglimit", "0", CVAR_ARCHIVE },
;165:	{ &ui_tourney_timelimit, "ui_tourney_timelimit", "15", CVAR_ARCHIVE },
;166:	{ NULL, "ui_tourney_gameseed", "0", CVAR_ARCHIVE },	// JUHOX
;167:	{ NULL, "ui_tourney_noItems", "0", CVAR_ARCHIVE },	// JUHOX
;168:	{ NULL, "ui_tourney_noHealthRegen", "0", CVAR_ARCHIVE },	// JUHOX
;169:	{ NULL, "ui_tourney_unlimitedAmmo", "0", CVAR_ARCHIVE },	// JUHOX
;170:	{ NULL, "ui_tourney_cloakingDevice", "1", CVAR_ARCHIVE },	// JUHOX
;171:	{ NULL, "ui_tourney_weaponLimit", "0", CVAR_ARCHIVE },	// JUHOX
;172:
;173:	{ &ui_team_fraglimit, "ui_team_fraglimit", "0", CVAR_ARCHIVE },
;174:	{ &ui_team_timelimit, "ui_team_timelimit", "20", CVAR_ARCHIVE },
;175:	{ &ui_team_friendly, "ui_team_friendly",  "1", CVAR_ARCHIVE },
;176:	{ NULL, "ui_team_respawndelay", "0", CVAR_ARCHIVE },	// JUHOX
;177:	{ &ui_team_tss, "ui_team_tss", "1", CVAR_ARCHIVE },	// JUHOX
;178:	{ NULL, "ui_team_gameseed", "0", CVAR_ARCHIVE },	// JUHOX
;179:	{ NULL, "ui_team_noItems", "0", CVAR_ARCHIVE },	// JUHOX
;180:	{ NULL, "ui_team_noHealthRegen", "0", CVAR_ARCHIVE },	// JUHOX
;181:	{ NULL, "ui_team_unlimitedAmmo", "0", CVAR_ARCHIVE },	// JUHOX
;182:	{ NULL, "ui_team_cloakingDevice", "1", CVAR_ARCHIVE },	// JUHOX
;183:	{ NULL, "ui_team_weaponLimit", "0", CVAR_ARCHIVE },	// JUHOX
;184:
;185:	{ &ui_ctf_capturelimit, "ui_ctf_capturelimit", "8", CVAR_ARCHIVE },
;186:	{ &ui_ctf_timelimit, "ui_ctf_timelimit", "30", CVAR_ARCHIVE },
;187:	{ &ui_ctf_friendly, "ui_ctf_friendly",  "0", CVAR_ARCHIVE },
;188:	{ NULL, "ui_ctf_respawndelay", "0", CVAR_ARCHIVE },	// JUHOX
;189:	{ &ui_ctf_tss, "ui_ctf_tss", "1", CVAR_ARCHIVE },	// JUHOX
;190:	{ NULL, "ui_ctf_gameseed", "0", CVAR_ARCHIVE },	// JUHOX
;191:	{ NULL, "ui_ctf_noItems", "0", CVAR_ARCHIVE },	// JUHOX
;192:	{ NULL, "ui_ctf_noHealthRegen", "0", CVAR_ARCHIVE },	// JUHOX
;193:	{ NULL, "ui_ctf_unlimitedAmmo", "0", CVAR_ARCHIVE },	// JUHOX
;194:	{ NULL, "ui_ctf_cloakingDevice", "1", CVAR_ARCHIVE },	// JUHOX
;195:	{ NULL, "ui_ctf_weaponLimit", "0", CVAR_ARCHIVE },	// JUHOX
;196:
;197:#if MONSTER_MODE	// JUHOX: ui cvars used for monsters
;198:	{ NULL, "ui_ffa_monsterLauncher", "1", CVAR_ARCHIVE },
;199:	{ NULL, "ui_ffa_maxMonsters", "60", CVAR_ARCHIVE },
;200:	{ NULL, "ui_ffa_maxMonstersPP", "10", CVAR_ARCHIVE },
;201:	{ NULL, "ui_ffa_monsterHealthScale", "10", CVAR_ARCHIVE },
;202:
;203:	{ NULL, "ui_tourney_monsterLauncher", "1", CVAR_ARCHIVE },
;204:	{ NULL, "ui_tourney_maxMonsters", "60", CVAR_ARCHIVE },
;205:	{ NULL, "ui_tourney_maxMonstersPP", "10", CVAR_ARCHIVE },
;206:	{ NULL, "ui_tourney_monsterHealthScale", "10", CVAR_ARCHIVE },
;207:
;208:	{ NULL, "ui_team_monsterLauncher", "1", CVAR_ARCHIVE },
;209:	{ NULL, "ui_team_maxMonsters", "60", CVAR_ARCHIVE },
;210:	{ NULL, "ui_team_maxMonstersPP", "10", CVAR_ARCHIVE },
;211:	{ NULL, "ui_team_monsterHealthScale", "10", CVAR_ARCHIVE },
;212:
;213:	{ NULL, "ui_ctf_monsterLauncher", "1", CVAR_ARCHIVE },
;214:	{ NULL, "ui_ctf_maxMonsters", "60", CVAR_ARCHIVE },
;215:	{ NULL, "ui_ctf_maxMonstersPP", "10", CVAR_ARCHIVE },
;216:	{ NULL, "ui_ctf_monsterHealthScale", "10", CVAR_ARCHIVE },
;217:#endif
;218:
;219:	{ NULL, "g_template", "", CVAR_ROM },	// JUHOX
;220:	{ NULL, "g_noItems", "0", CVAR_ARCHIVE | CVAR_LATCH },	// JUHOX
;221:	{ NULL, "g_noHealthRegen", "0", CVAR_ARCHIVE },	// JUHOX
;222:
;223:#if MONSTER_MODE	// JUHOX: ui cvars used for STU
;224:	{ NULL, "ui_stu_fraglimit", "5", CVAR_ARCHIVE },
;225:	{ NULL, "ui_stu_timelimit", "0", CVAR_ARCHIVE },
;226:	{ NULL, "ui_stu_artefacts", "8", CVAR_ARCHIVE },
;227:	{ NULL, "ui_stu_friendly", "0", CVAR_ARCHIVE },
;228:	{ NULL, "ui_stu_respawndelay", "0", CVAR_ARCHIVE },
;229:	{ NULL, "ui_stu_tss", "0", CVAR_ARCHIVE },
;230:	{ NULL, "ui_stu_gameseed", "0", CVAR_ARCHIVE },
;231:	{ NULL, "ui_stu_noItems", "0", CVAR_ARCHIVE },
;232:	{ NULL, "ui_stu_noHealthRegen", "1", CVAR_ARCHIVE },
;233:	{ NULL, "ui_stu_unlimitedAmmo", "0", CVAR_ARCHIVE },
;234:	{ NULL, "ui_stu_cloakingDevice", "1", CVAR_ARCHIVE },
;235:	{ NULL, "ui_stu_weaponLimit", "0", CVAR_ARCHIVE },
;236:
;237:	{ NULL, "ui_stu_minMonsters", "15", CVAR_ARCHIVE },
;238:	{ NULL, "ui_stu_maxMonsters", "30", CVAR_ARCHIVE },
;239:	{ NULL, "ui_stu_monstersPerTrap", "0", CVAR_ARCHIVE },
;240:	{ NULL, "ui_stu_monsterSpawnDelay", "10000", CVAR_ARCHIVE },
;241:	{ NULL, "ui_stu_monsterGuards", "12", CVAR_ARCHIVE },
;242:	{ NULL, "ui_stu_monsterTitans", "6", CVAR_ARCHIVE },
;243:	{ NULL, "ui_stu_monsterHealthScale", "100", CVAR_ARCHIVE },
;244:	{ NULL,	"ui_stu_monsterProgression", "10", CVAR_ARCHIVE },
;245:	{ NULL, "ui_stu_monsterBreeding", "1", CVAR_ARCHIVE },
;246:	{ NULL, "monsterModel1", "klesk/maneater", CVAR_ARCHIVE },
;247:	{ NULL, "monsterModel2", "tankjr/default", CVAR_ARCHIVE },
;248:	{ NULL, "monsterModel3", "uriel/default", CVAR_ARCHIVE },
;249:	{ NULL, "g_skipEndSequence", "0", CVAR_ARCHIVE },
;250:	{ NULL, "g_scoreMode", "0", CVAR_ARCHIVE },
;251:#endif
;252:
;253:#if ESCAPE_MODE	// JUHOX: ui cvars used for EFH
;254:	{ NULL, "ui_efh_fraglimit", "1", CVAR_ARCHIVE },
;255:	{ NULL, "ui_efh_timelimit", "10", CVAR_ARCHIVE },
;256:	{ NULL, "ui_efh_distancelimit", "1000", CVAR_ARCHIVE },
;257:	{ NULL, "ui_efh_friendly", "0", CVAR_ARCHIVE },
;258:	{ NULL, "ui_efh_gameseed", "0", CVAR_ARCHIVE },
;259:	{ NULL, "ui_efh_noItems", "1", CVAR_ARCHIVE },
;260:	{ NULL, "ui_efh_noHealthRegen", "1", CVAR_ARCHIVE },
;261:	{ NULL, "ui_efh_challengingEnv", "1", CVAR_ARCHIVE },
;262:	{ NULL, "ui_efh_monsterLoad", "30", CVAR_ARCHIVE },
;263:	{ NULL, "ui_efh_monsterGuards", "10", CVAR_ARCHIVE },
;264:	{ NULL, "ui_efh_monsterTitans", "5", CVAR_ARCHIVE },
;265:	{ NULL, "ui_efh_monsterHealthScale", "5", CVAR_ARCHIVE },
;266:	{ NULL, "ui_efh_monsterProgression", "0", CVAR_ARCHIVE },
;267:	{ NULL, "ui_efh_unlimitedAmmo", "0", CVAR_ARCHIVE },	// JUHOX
;268:	{ NULL, "ui_efh_cloakingDevice", "1", CVAR_ARCHIVE },	// JUHOX
;269:	{ NULL, "ui_efh_weaponLimit", "0", CVAR_ARCHIVE },	// JUHOX
;270:
;271:	{ NULL, "g_debugEFH", "0", CVAR_SYSTEMINFO | CVAR_INIT },
;272:#endif
;273:
;274:#if MEETING	// JUHOX: ui cvars used for meeting
;275:	{ NULL, "ui_ffa_meeting", "0", CVAR_ARCHIVE },
;276:	{ NULL, "ui_tourney_meeting", "0", CVAR_ARCHIVE },
;277:	{ NULL, "ui_team_meeting", "0", CVAR_ARCHIVE },
;278:	{ NULL, "ui_ctf_meeting", "0", CVAR_ARCHIVE },
;279:	{ NULL, "ui_stu_meeting", "0", CVAR_ARCHIVE },
;280:	{ NULL, "ui_efh_meeting", "0", CVAR_ARCHIVE },
;281:#endif
;282:
;283:	{ &ui_additionalSlots, "ui_additionalSlots", "0", CVAR_ARCHIVE },	// JUHOX
;284:	{ &ui_tss, "tss", "1", CVAR_SERVERINFO | CVAR_ARCHIVE | CVAR_NORESTART },	// JUHOX: just for reference
;285:	{ NULL, "tssSafetyModeAllowed", "1", CVAR_SERVERINFO | CVAR_LATCH | CVAR_ARCHIVE },	// JUHOX: just for reference
;286:	{ &ui_respawnAtPOD, "respawnAtPOD", "0", CVAR_ARCHIVE | CVAR_NORESTART },	// JUHOX: just for reference
;287:	{ &ui_armorFragments, "g_armorFragments", "0", CVAR_ARCHIVE | CVAR_NORESTART },	// JUHOX: just for reference
;288:	{ &ui_stamina, "g_stamina", "0", CVAR_SERVERINFO | CVAR_ARCHIVE | CVAR_NORESTART },	// JUHOX: just for reference
;289:	{ &ui_baseHealth, "g_baseHealth", "300", CVAR_SERVERINFO | CVAR_LATCH | CVAR_ARCHIVE },	// JUHOX: just for reference
;290:	{ &ui_lightningDamageLimit, "g_lightningDamageLimit", "0", CVAR_ARCHIVE | CVAR_SERVERINFO | CVAR_NORESTART },	// JUHOX: just for reference
;291:
;292:	{ &ui_arenasFile, "g_arenasFile", "", CVAR_INIT|CVAR_ROM },
;293:	{ &ui_botsFile, "g_botsFile", "", CVAR_INIT|CVAR_ROM },
;294:	{ &ui_spScores1, "g_spScores1", "", CVAR_ARCHIVE | CVAR_ROM },
;295:	{ &ui_spScores2, "g_spScores2", "", CVAR_ARCHIVE | CVAR_ROM },
;296:	{ &ui_spScores3, "g_spScores3", "", CVAR_ARCHIVE | CVAR_ROM },
;297:	{ &ui_spScores4, "g_spScores4", "", CVAR_ARCHIVE | CVAR_ROM },
;298:	{ &ui_spScores5, "g_spScores5", "", CVAR_ARCHIVE | CVAR_ROM },
;299:	{ &ui_spAwards, "g_spAwards", "", CVAR_ARCHIVE | CVAR_ROM },
;300:	{ &ui_spVideos, "g_spVideos", "", CVAR_ARCHIVE | CVAR_ROM },
;301:	{ &ui_spSkill, "g_spSkill", "2", CVAR_ARCHIVE | CVAR_LATCH },
;302:	{ NULL, "g_grapple", "0", CVAR_ARCHIVE | CVAR_SERVERINFO | CVAR_LATCH },	// JUHOX
;303:	{ NULL, "g_gravityLatch", "", CVAR_ROM },	// JUHOX
;304:
;305:	{ &ui_spSelection, "ui_spSelection", "", CVAR_ROM },
;306:
;307:	{ &ui_browserMaster, "ui_browserMaster", "0", CVAR_ARCHIVE },
;308:	{ &ui_browserGameType, "ui_browserGameType", "0", CVAR_ARCHIVE },
;309:	{ &ui_browserSortKey, "ui_browserSortKey", "4", CVAR_ARCHIVE },
;310:	{ &ui_browserShowFull, "ui_browserShowFull", "1", CVAR_ARCHIVE },
;311:	{ &ui_browserShowEmpty, "ui_browserShowEmpty", "1", CVAR_ARCHIVE },
;312:
;313:	{ &ui_brassTime, "cg_brassTime", "2500", CVAR_ARCHIVE },
;314:	{ &ui_drawCrosshair, "cg_drawCrosshair", "4", CVAR_ARCHIVE },
;315:	{ &ui_drawCrosshairNames, "cg_drawCrosshairNames", "1", CVAR_ARCHIVE },
;316:	{ &ui_marks, "cg_marks", "1", CVAR_ARCHIVE },
;317:#if 1	// JUHOX: client cvars referenced by the ui module (only used for registering)
;318:	{ NULL, "cg_autoswitchAmmoLimit", "50", CVAR_ARCHIVE },
;319:	{ NULL, "cg_weaponOrder0", "ICFJDHGLEB", CVAR_ARCHIVE },
;320:	{ NULL, "cg_weaponOrder1", "DCGHLBIFEJ", CVAR_ARCHIVE },
;321:	{ NULL, "cg_weaponOrder2", "FCIDGEJLHB", CVAR_ARCHIVE },
;322:	{ NULL, "cg_weaponOrder3", "JFCEIDHGLB", CVAR_ARCHIVE },
;323:	{ NULL, "cg_weaponOrder4", "HLJCFGIDEB", CVAR_ARCHIVE },
;324:	{ NULL, "cg_weaponOrder5", "LGEJICDFHB", CVAR_ARCHIVE },
;325:	{ NULL, "cg_weaponOrder0Name", "pursuit", CVAR_ARCHIVE },
;326:	{ NULL, "cg_weaponOrder1Name", "close combat", CVAR_ARCHIVE },
;327:	{ NULL, "cg_weaponOrder2Name", "attack", CVAR_ARCHIVE },
;328:	{ NULL, "cg_weaponOrder3Name", "annihilation", CVAR_ARCHIVE },
;329:	{ NULL, "cg_weaponOrder4Name", "revenge", CVAR_ARCHIVE },
;330:	{ NULL, "cg_weaponOrder5Name", "defence", CVAR_ARCHIVE },
;331:	{ NULL, "cg_glassCloaking", "0", CVAR_ARCHIVE},
;332:	{ NULL, "cg_lensFlare", "1", CVAR_ARCHIVE},
;333:	{ NULL, "cg_BFGsuperExpl", "1", CVAR_ARCHIVE},
;334:	{ NULL, "cg_autoGLC", "1", CVAR_ARCHIVE},
;335:	{ NULL, "crouchCutsRope", "1", CVAR_ARCHIVE | CVAR_USERINFO },
;336:#endif
;337:	{ NULL, "tssinit", "0", CVAR_ROM },		// JUHOX
;338:	{ NULL, "tssi_key", "", CVAR_ROM },		// JUHOX
;339:	{ NULL, "tssi_mouse", "", CVAR_ROM },	// JUHOX
;340:	{ NULL, "tmplcmd", "", CVAR_ROM },		// JUHOX
;341:	{ NULL, "tmplfiles", "", CVAR_ROM | CVAR_NORESTART },	// JUHOX
;342:	{ &ui_lensFlare, "ui_lensFlare", "1", CVAR_ARCHIVE },	// JUHOX
;343:	{ &ui_hiDetailTitle, "ui_hiDetailTitle", "1", CVAR_ARCHIVE },	// JUHOX
;344:
;345:	{ &ui_server1, "server1", "", CVAR_ARCHIVE },
;346:	{ &ui_server2, "server2", "", CVAR_ARCHIVE },
;347:	{ &ui_server3, "server3", "", CVAR_ARCHIVE },
;348:	{ &ui_server4, "server4", "", CVAR_ARCHIVE },
;349:	{ &ui_server5, "server5", "", CVAR_ARCHIVE },
;350:	{ &ui_server6, "server6", "", CVAR_ARCHIVE },
;351:	{ &ui_server7, "server7", "", CVAR_ARCHIVE },
;352:	{ &ui_server8, "server8", "", CVAR_ARCHIVE },
;353:	{ &ui_server9, "server9", "", CVAR_ARCHIVE },
;354:	{ &ui_server10, "server10", "", CVAR_ARCHIVE },
;355:	{ &ui_server11, "server11", "", CVAR_ARCHIVE },
;356:	{ &ui_server12, "server12", "", CVAR_ARCHIVE },
;357:	{ &ui_server13, "server13", "", CVAR_ARCHIVE },
;358:	{ &ui_server14, "server14", "", CVAR_ARCHIVE },
;359:	{ &ui_server15, "server15", "", CVAR_ARCHIVE },
;360:	{ &ui_server16, "server16", "", CVAR_ARCHIVE },
;361:
;362:	{ NULL, "ui_init", "0", CVAR_ROM },		// JUHOX
;363:	{ NULL, "ui_precache", "1", CVAR_ARCHIVE },	// JUHOX
;364:
;365:#if PLAYLIST
;366:	{ NULL, "cg_music", "0", CVAR_ARCHIVE },	// JUHOX
;367:#endif
;368:
;369:	{ NULL, "developer", "0", CVAR_INIT},	// JUHOX
;370:
;371:	{ &ui_cdkeychecked, "ui_cdkeychecked", "0", CVAR_ROM }
;372:};
;373:
;374:// bk001129 - made static to avoid aliasing
;375:static int cvarTableSize = sizeof(cvarTable) / sizeof(cvarTable[0]);
;376:
;377:
;378:/*
;379:=================
;380:UI_RegisterCvars
;381:=================
;382:*/
;383:void UI_RegisterCvars( void ) {
line 387
;384:	int			i;
;385:	cvarTable_t	*cv;
;386:
;387:	for ( i = 0, cv = cvarTable ; i < cvarTableSize ; i++, cv++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
ADDRGP4 cvarTable
ASGNP4
ADDRGP4 $334
JUMPV
LABELV $331
line 388
;388:		trap_Cvar_Register( cv->vmCvar, cv->cvarName, cv->defaultString, cv->cvarFlags );
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
line 389
;389:	}
LABELV $332
line 387
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
LABELV $334
ADDRLP4 4
INDIRI4
ADDRGP4 cvarTableSize
INDIRI4
LTI4 $331
line 390
;390:}
LABELV $330
endproc UI_RegisterCvars 12 16
export UI_UpdateCvars
proc UI_UpdateCvars 8 4
line 397
;391:
;392:/*
;393:=================
;394:UI_UpdateCvars
;395:=================
;396:*/
;397:void UI_UpdateCvars( void ) {
line 401
;398:	int			i;
;399:	cvarTable_t	*cv;
;400:
;401:	for ( i = 0, cv = cvarTable ; i < cvarTableSize ; i++, cv++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
ADDRGP4 cvarTable
ASGNP4
ADDRGP4 $339
JUMPV
LABELV $336
line 406
;402:		// JUHOX: don't update noset cvars
;403:#if 0
;404:		trap_Cvar_Update( cv->vmCvar );
;405:#else
;406:		if (cv->vmCvar) trap_Cvar_Update(cv->vmCvar);
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $340
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
LABELV $340
line 408
;407:#endif
;408:	}
LABELV $337
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
LABELV $339
ADDRLP4 4
INDIRI4
ADDRGP4 cvarTableSize
INDIRI4
LTI4 $336
line 409
;409:}
LABELV $335
endproc UI_UpdateCvars 8 4
bss
export ui_lightningDamageLimit
align 4
LABELV ui_lightningDamageLimit
skip 272
export ui_baseHealth
align 4
LABELV ui_baseHealth
skip 272
export ui_stamina
align 4
LABELV ui_stamina
skip 272
export ui_armorFragments
align 4
LABELV ui_armorFragments
skip 272
export ui_respawnAtPOD
align 4
LABELV ui_respawnAtPOD
skip 272
export ui_tss
align 4
LABELV ui_tss
skip 272
export ui_additionalSlots
align 4
LABELV ui_additionalSlots
skip 272
export ui_ctf_tss
align 4
LABELV ui_ctf_tss
skip 272
export ui_team_tss
align 4
LABELV ui_team_tss
skip 272
import UI_RankStatusMenu
import RankStatus_Cache
import UI_SignupMenu
import Signup_Cache
import UI_LoginMenu
import Login_Cache
import UI_RankingsMenu
import Rankings_Cache
import Rankings_DrawPassword
import Rankings_DrawName
import Rankings_DrawText
import UI_InitGameinfo
import UI_SPUnlockMedals_f
import UI_SPUnlock_f
import UI_GetAwardLevel
import UI_LogAwardData
import UI_NewGame
import UI_GetCurrentGame
import UI_CanShowTierVideo
import UI_ShowTierVideo
import UI_TierCompleted
import UI_SetBestScore
import UI_GetBestScore
import UI_GetNumBots
import UI_GetBotInfoByName
import UI_GetBotInfoByNumber
import UI_GetNumSPTiers
import UI_GetNumSPArenas
import UI_GetNumArenas
import UI_GetSpecialArenaInfo
import UI_GetArenaInfoByMap
import UI_GetArenaInfoByNumber
import UI_NetworkOptionsMenu
import UI_NetworkOptionsMenu_Cache
import UI_SoundOptionsMenu
import UI_SoundOptionsMenu_Cache
import UI_DisplayOptionsMenu
import UI_DisplayOptionsMenu_Cache
import UI_SaveConfigMenu
import UI_SaveConfigMenu_Cache
import UI_LoadConfigMenu
import UI_LoadConfig_Cache
import UI_TeamOrdersMenu_Cache
import UI_TeamOrdersMenu_f
import UI_TeamOrdersMenu
import UI_RemoveBotsMenu
import UI_RemoveBots_Cache
import UI_AddBotsMenu
import UI_AddBots_Cache
import trap_SetPbClStatus
import trap_VerifyCDKey
import trap_SetCDKey
import trap_GetCDKey
import trap_MemoryRemaining
import trap_LAN_GetPingInfo
import trap_LAN_GetPing
import trap_LAN_ClearPing
import trap_LAN_ServerStatus
import trap_LAN_GetPingQueueCount
import trap_LAN_GetServerInfo
import trap_LAN_GetServerAddressString
import trap_LAN_GetServerCount
import trap_GetConfigString
import trap_GetGlconfig
import trap_GetClientState
import trap_GetClipboardData
import trap_Key_SetCatcher
import trap_Key_GetCatcher
import trap_Key_ClearStates
import trap_Key_SetOverstrikeMode
import trap_Key_GetOverstrikeMode
import trap_Key_IsDown
import trap_Key_SetBinding
import trap_Key_GetBindingBuf
import trap_Key_KeynumToStringBuf
import trap_S_StartBackgroundTrack
import trap_S_StopBackgroundTrack
import trap_S_RegisterSound
import trap_S_StartLocalSound
import trap_CM_LerpTag
import trap_UpdateScreen
import trap_R_DrawStretchPic
import trap_R_SetColor
import trap_R_RenderScene
import trap_R_AddLightToScene
import trap_R_AddPolyToScene
import trap_R_AddRefEntityToScene
import trap_R_ClearScene
import trap_R_RegisterShaderNoMip
import trap_R_RegisterSkin
import trap_R_RegisterModel
import trap_FS_Seek
import trap_FS_GetFileList
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_FS_FOpenFile
import trap_Cmd_ExecuteText
import trap_Argv
import trap_Argc
import trap_Cvar_InfoStringBuffer
import trap_Cvar_Create
import trap_Cvar_Reset
import trap_Cvar_SetValue
import trap_Cvar_VariableStringBuffer
import trap_Cvar_VariableValue
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_Milliseconds
import trap_Error
import trap_Print
import UI_SPSkillMenu_Cache
import UI_SPSkillMenu
import UI_SPPostgameMenu_f
import UI_SPPostgameMenu_Cache
import UI_SPArena_Start
import UI_SPLevelMenu_ReInit
import UI_SPLevelMenu_f
import UI_SPLevelMenu
import UI_SPLevelMenu_Cache
import uis
import m_entersound
import UI_StartDemoLoop
import UI_DrawBackPic
import UI_Cvar_VariableString
import UI_Argv
import UI_ForceMenuOff
import UI_PopMenu
import UI_PushMenu
import UI_SetActiveMenu
import UI_IsFullscreen
import UI_DrawTextBox
import UI_AdjustFrom640
import UI_CursorInRect
import UI_DrawChar
import UI_DrawString
import UI_DrawStrlen
import UI_ProportionalStringWidth
import UI_DrawProportionalString_AutoWrapped
import UI_DrawProportionalString
import UI_ProportionalSizeScale
import UI_DrawBannerString
import UI_LerpColor
import UI_SetColor
import UI_UpdateScreen
import UI_DrawRect
import UI_FillRect
import UI_DrawHandlePic
import UI_DrawNamedPic
import UI_ClampCvar
import UI_ConsoleCommand
import UI_Refresh
import UI_MouseEvent
import UI_KeyEvent
import UI_Shutdown
import UI_Init
import UI_RegisterClientModelname
import UI_PlayerInfo_SetInfo
import UI_PlayerInfo_SetModel
import UI_DrawPlayer
import DriverInfo_Cache
import GraphicsOptions_Cache
import UI_GraphicsOptionsMenu
import ServerInfo_Cache
import UI_ServerInfoMenu
import UI_GTS_Menu
import UI_TemplateList_Complete
import UI_TemplateList_SvTemplate
import UI_TemplateMenu
import UI_BotSelectMenu_Cache
import UI_BotSelectMenu
import ServerOptions_Cache
import StartServer_Cache
import UI_StartServerMenu
import ArenaServers_Cache
import UI_ArenaServersMenu
import SpecifyServer_Cache
import UI_SpecifyServerMenu
import SpecifyLeague_Cache
import UI_SpecifyLeagueMenu
import Preferences_Cache
import UI_PreferencesMenu
import PlayerSettings_Cache
import UI_PlayerSettingsMenu
import PlayerModel_Cache
import UI_PlayerModelMenu
import UI_CDKeyMenu_f
import UI_CDKeyMenu_Cache
import UI_CDKeyMenu
import UI_ModsMenu_Cache
import UI_ModsMenu
import UI_CinematicsMenu_Cache
import UI_CinematicsMenu_f
import UI_CinematicsMenu
import Demos_Cache
import UI_DemosMenu
import Controls_Cache
import UI_ControlsMenu
import UI_DrawConnectScreen
import TeamMain_Cache
import UI_TeamMainMenu
import UI_SetupMenu
import UI_SetupMenu_Cache
import UI_Message
import UI_ConfirmMenu_Style
import UI_ConfirmMenu
import ConfirmMenu_Cache
import UI_InGameMenu
import InGame_Cache
import UI_Hunt_Credits
import UI_CreditMenu
import UI_MainMenu
import MainMenu_Cache
import MenuField_Key
import MenuField_Draw
import MenuField_Init
import MField_Draw
import MField_CharEvent
import MField_KeyDownEvent
import MField_Clear
import ui_medalSounds
import ui_medalPicNames
import ui_medalNames
import text_color_highlight
import text_color_normal
import text_color_disabled
import listbar_color
import list_color
import name_color
import color_dim
import color_red
import color_orange
import color_blue
import color_yellow
import color_white
import color_black
import menu_dim_color
import menu_black_color
import menu_red_color
import menu_highlight_color
import menu_dark_color
import menu_grayed_color
import menu_text_color
import weaponChangeSound
import menu_null_sound
import menu_buzz_sound
import menu_out_sound
import menu_move_sound
import menu_in_sound
import ScrollList_Key
import ScrollList_Draw
import Bitmap_Draw
import Bitmap_Init
import Menu_DefaultKey
import Menu_SetCursorToItem
import Menu_SetCursor
import Menu_ActivateItem
import Menu_ItemAtCursor
import Menu_Draw
import Menu_AdjustCursor
import Menu_AddItem
import Menu_Focus
import Menu_Cache
export ui_cdkeychecked
align 4
LABELV ui_cdkeychecked
skip 272
import ui_cdkey
export ui_server16
align 4
LABELV ui_server16
skip 272
export ui_server15
align 4
LABELV ui_server15
skip 272
export ui_server14
align 4
LABELV ui_server14
skip 272
export ui_server13
align 4
LABELV ui_server13
skip 272
export ui_server12
align 4
LABELV ui_server12
skip 272
export ui_server11
align 4
LABELV ui_server11
skip 272
export ui_server10
align 4
LABELV ui_server10
skip 272
export ui_server9
align 4
LABELV ui_server9
skip 272
export ui_server8
align 4
LABELV ui_server8
skip 272
export ui_server7
align 4
LABELV ui_server7
skip 272
export ui_server6
align 4
LABELV ui_server6
skip 272
export ui_server5
align 4
LABELV ui_server5
skip 272
export ui_server4
align 4
LABELV ui_server4
skip 272
export ui_server3
align 4
LABELV ui_server3
skip 272
export ui_server2
align 4
LABELV ui_server2
skip 272
export ui_server1
align 4
LABELV ui_server1
skip 272
export ui_hiDetailTitle
align 4
LABELV ui_hiDetailTitle
skip 272
export ui_lensFlare
align 4
LABELV ui_lensFlare
skip 272
export ui_marks
align 4
LABELV ui_marks
skip 272
export ui_drawCrosshairNames
align 4
LABELV ui_drawCrosshairNames
skip 272
export ui_drawCrosshair
align 4
LABELV ui_drawCrosshair
skip 272
export ui_brassTime
align 4
LABELV ui_brassTime
skip 272
export ui_browserShowEmpty
align 4
LABELV ui_browserShowEmpty
skip 272
export ui_browserShowFull
align 4
LABELV ui_browserShowFull
skip 272
export ui_browserSortKey
align 4
LABELV ui_browserSortKey
skip 272
export ui_browserGameType
align 4
LABELV ui_browserGameType
skip 272
export ui_browserMaster
align 4
LABELV ui_browserMaster
skip 272
export ui_spSelection
align 4
LABELV ui_spSelection
skip 272
export ui_spSkill
align 4
LABELV ui_spSkill
skip 272
export ui_spVideos
align 4
LABELV ui_spVideos
skip 272
export ui_spAwards
align 4
LABELV ui_spAwards
skip 272
export ui_spScores5
align 4
LABELV ui_spScores5
skip 272
export ui_spScores4
align 4
LABELV ui_spScores4
skip 272
export ui_spScores3
align 4
LABELV ui_spScores3
skip 272
export ui_spScores2
align 4
LABELV ui_spScores2
skip 272
export ui_spScores1
align 4
LABELV ui_spScores1
skip 272
export ui_botsFile
align 4
LABELV ui_botsFile
skip 272
export ui_arenasFile
align 4
LABELV ui_arenasFile
skip 272
export ui_ctf_friendly
align 4
LABELV ui_ctf_friendly
skip 272
export ui_ctf_timelimit
align 4
LABELV ui_ctf_timelimit
skip 272
export ui_ctf_capturelimit
align 4
LABELV ui_ctf_capturelimit
skip 272
export ui_team_friendly
align 4
LABELV ui_team_friendly
skip 272
export ui_team_timelimit
align 4
LABELV ui_team_timelimit
skip 272
export ui_team_fraglimit
align 4
LABELV ui_team_fraglimit
skip 272
export ui_tourney_timelimit
align 4
LABELV ui_tourney_timelimit
skip 272
export ui_tourney_fraglimit
align 4
LABELV ui_tourney_fraglimit
skip 272
export ui_ffa_timelimit
align 4
LABELV ui_ffa_timelimit
skip 272
export ui_ffa_fraglimit
align 4
LABELV ui_ffa_fraglimit
skip 272
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
LABELV $329
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 100
byte 1 107
byte 1 101
byte 1 121
byte 1 99
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $328
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
LABELV $327
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
LABELV $326
byte 1 117
byte 1 105
byte 1 95
byte 1 112
byte 1 114
byte 1 101
byte 1 99
byte 1 97
byte 1 99
byte 1 104
byte 1 101
byte 1 0
align 1
LABELV $325
byte 1 117
byte 1 105
byte 1 95
byte 1 105
byte 1 110
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $324
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 49
byte 1 54
byte 1 0
align 1
LABELV $323
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 49
byte 1 53
byte 1 0
align 1
LABELV $322
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 49
byte 1 52
byte 1 0
align 1
LABELV $321
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 49
byte 1 51
byte 1 0
align 1
LABELV $320
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 49
byte 1 50
byte 1 0
align 1
LABELV $319
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 49
byte 1 49
byte 1 0
align 1
LABELV $318
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 49
byte 1 48
byte 1 0
align 1
LABELV $317
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 57
byte 1 0
align 1
LABELV $316
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 56
byte 1 0
align 1
LABELV $315
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 55
byte 1 0
align 1
LABELV $314
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 54
byte 1 0
align 1
LABELV $313
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 53
byte 1 0
align 1
LABELV $312
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 52
byte 1 0
align 1
LABELV $311
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 51
byte 1 0
align 1
LABELV $310
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 50
byte 1 0
align 1
LABELV $309
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 49
byte 1 0
align 1
LABELV $308
byte 1 117
byte 1 105
byte 1 95
byte 1 104
byte 1 105
byte 1 68
byte 1 101
byte 1 116
byte 1 97
byte 1 105
byte 1 108
byte 1 84
byte 1 105
byte 1 116
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $307
byte 1 117
byte 1 105
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
LABELV $306
byte 1 116
byte 1 109
byte 1 112
byte 1 108
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $305
byte 1 116
byte 1 109
byte 1 112
byte 1 108
byte 1 99
byte 1 109
byte 1 100
byte 1 0
align 1
LABELV $304
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
LABELV $303
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
LABELV $302
byte 1 116
byte 1 115
byte 1 115
byte 1 105
byte 1 110
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $301
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
LABELV $300
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
LABELV $299
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
LABELV $298
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
LABELV $297
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
LABELV $296
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $295
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
LABELV $294
byte 1 114
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $293
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
LABELV $292
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
LABELV $291
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
LABELV $290
byte 1 97
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $289
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
LABELV $288
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
LABELV $287
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
LABELV $286
byte 1 112
byte 1 117
byte 1 114
byte 1 115
byte 1 117
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $285
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
LABELV $284
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
LABELV $283
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
LABELV $282
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
LABELV $281
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
LABELV $280
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
LABELV $279
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
LABELV $278
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
LABELV $277
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
LABELV $276
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
LABELV $275
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
LABELV $274
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
LABELV $273
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
LABELV $272
byte 1 53
byte 1 48
byte 1 0
align 1
LABELV $271
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
LABELV $270
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
LABELV $269
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
LABELV $268
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
LABELV $267
byte 1 50
byte 1 53
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $266
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
LABELV $265
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 101
byte 1 114
byte 1 83
byte 1 104
byte 1 111
byte 1 119
byte 1 69
byte 1 109
byte 1 112
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $264
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 101
byte 1 114
byte 1 83
byte 1 104
byte 1 111
byte 1 119
byte 1 70
byte 1 117
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $263
byte 1 52
byte 1 0
align 1
LABELV $262
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 101
byte 1 114
byte 1 83
byte 1 111
byte 1 114
byte 1 116
byte 1 75
byte 1 101
byte 1 121
byte 1 0
align 1
LABELV $261
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 101
byte 1 114
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 84
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $260
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 101
byte 1 114
byte 1 77
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $259
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $258
byte 1 103
byte 1 95
byte 1 103
byte 1 114
byte 1 97
byte 1 118
byte 1 105
byte 1 116
byte 1 121
byte 1 76
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $257
byte 1 103
byte 1 95
byte 1 103
byte 1 114
byte 1 97
byte 1 112
byte 1 112
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $256
byte 1 50
byte 1 0
align 1
LABELV $255
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $254
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 86
byte 1 105
byte 1 100
byte 1 101
byte 1 111
byte 1 115
byte 1 0
align 1
LABELV $253
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 65
byte 1 119
byte 1 97
byte 1 114
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $252
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 53
byte 1 0
align 1
LABELV $251
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 52
byte 1 0
align 1
LABELV $250
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 51
byte 1 0
align 1
LABELV $249
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 50
byte 1 0
align 1
LABELV $248
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 49
byte 1 0
align 1
LABELV $247
byte 1 103
byte 1 95
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 70
byte 1 105
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $246
byte 1 103
byte 1 95
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 115
byte 1 70
byte 1 105
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $245
byte 1 103
byte 1 95
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 68
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 76
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $244
byte 1 51
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $243
byte 1 103
byte 1 95
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $242
byte 1 103
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 109
byte 1 105
byte 1 110
byte 1 97
byte 1 0
align 1
LABELV $241
byte 1 103
byte 1 95
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 70
byte 1 114
byte 1 97
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $240
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 65
byte 1 116
byte 1 80
byte 1 79
byte 1 68
byte 1 0
align 1
LABELV $239
byte 1 116
byte 1 115
byte 1 115
byte 1 83
byte 1 97
byte 1 102
byte 1 101
byte 1 116
byte 1 121
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 65
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $238
byte 1 116
byte 1 115
byte 1 115
byte 1 0
align 1
LABELV $237
byte 1 117
byte 1 105
byte 1 95
byte 1 97
byte 1 100
byte 1 100
byte 1 105
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 97
byte 1 108
byte 1 83
byte 1 108
byte 1 111
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $236
byte 1 117
byte 1 105
byte 1 95
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 109
byte 1 101
byte 1 101
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $235
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 109
byte 1 101
byte 1 101
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $234
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
byte 1 109
byte 1 101
byte 1 101
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $233
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 109
byte 1 101
byte 1 101
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $232
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 95
byte 1 109
byte 1 101
byte 1 101
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $231
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 102
byte 1 97
byte 1 95
byte 1 109
byte 1 101
byte 1 101
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $230
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 98
byte 1 117
byte 1 103
byte 1 69
byte 1 70
byte 1 72
byte 1 0
align 1
LABELV $229
byte 1 117
byte 1 105
byte 1 95
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 76
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $228
byte 1 117
byte 1 105
byte 1 95
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 99
byte 1 108
byte 1 111
byte 1 97
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 68
byte 1 101
byte 1 118
byte 1 105
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $227
byte 1 117
byte 1 105
byte 1 95
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 117
byte 1 110
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 101
byte 1 100
byte 1 65
byte 1 109
byte 1 109
byte 1 111
byte 1 0
align 1
LABELV $226
byte 1 117
byte 1 105
byte 1 95
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 80
byte 1 114
byte 1 111
byte 1 103
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $225
byte 1 117
byte 1 105
byte 1 95
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 83
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $224
byte 1 117
byte 1 105
byte 1 95
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 84
byte 1 105
byte 1 116
byte 1 97
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $223
byte 1 117
byte 1 105
byte 1 95
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 71
byte 1 117
byte 1 97
byte 1 114
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $222
byte 1 117
byte 1 105
byte 1 95
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $221
byte 1 117
byte 1 105
byte 1 95
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 99
byte 1 104
byte 1 97
byte 1 108
byte 1 108
byte 1 101
byte 1 110
byte 1 103
byte 1 105
byte 1 110
byte 1 103
byte 1 69
byte 1 110
byte 1 118
byte 1 0
align 1
LABELV $220
byte 1 117
byte 1 105
byte 1 95
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 110
byte 1 111
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 82
byte 1 101
byte 1 103
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $219
byte 1 117
byte 1 105
byte 1 95
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 110
byte 1 111
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $218
byte 1 117
byte 1 105
byte 1 95
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $217
byte 1 117
byte 1 105
byte 1 95
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 102
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 108
byte 1 121
byte 1 0
align 1
LABELV $216
byte 1 49
byte 1 48
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $215
byte 1 117
byte 1 105
byte 1 95
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 100
byte 1 105
byte 1 115
byte 1 116
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $214
byte 1 117
byte 1 105
byte 1 95
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $213
byte 1 117
byte 1 105
byte 1 95
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $212
byte 1 103
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $211
byte 1 103
byte 1 95
byte 1 115
byte 1 107
byte 1 105
byte 1 112
byte 1 69
byte 1 110
byte 1 100
byte 1 83
byte 1 101
byte 1 113
byte 1 117
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $210
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
LABELV $209
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
LABELV $208
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
LABELV $207
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
LABELV $206
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
LABELV $205
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
LABELV $204
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 66
byte 1 114
byte 1 101
byte 1 101
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $203
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 80
byte 1 114
byte 1 111
byte 1 103
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $202
byte 1 49
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $201
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 83
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $200
byte 1 54
byte 1 0
align 1
LABELV $199
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 84
byte 1 105
byte 1 116
byte 1 97
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $198
byte 1 49
byte 1 50
byte 1 0
align 1
LABELV $197
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 71
byte 1 117
byte 1 97
byte 1 114
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $196
byte 1 49
byte 1 48
byte 1 48
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $195
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 68
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $194
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 80
byte 1 101
byte 1 114
byte 1 84
byte 1 114
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $193
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 109
byte 1 97
byte 1 120
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
LABELV $192
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 109
byte 1 105
byte 1 110
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
LABELV $191
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 76
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $190
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 99
byte 1 108
byte 1 111
byte 1 97
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 68
byte 1 101
byte 1 118
byte 1 105
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $189
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 117
byte 1 110
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 101
byte 1 100
byte 1 65
byte 1 109
byte 1 109
byte 1 111
byte 1 0
align 1
LABELV $188
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 110
byte 1 111
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 82
byte 1 101
byte 1 103
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $187
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 110
byte 1 111
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $186
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $185
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 116
byte 1 115
byte 1 115
byte 1 0
align 1
LABELV $184
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 100
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $183
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 102
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 108
byte 1 121
byte 1 0
align 1
LABELV $182
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 97
byte 1 114
byte 1 116
byte 1 101
byte 1 102
byte 1 97
byte 1 99
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $181
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $180
byte 1 53
byte 1 0
align 1
LABELV $179
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 116
byte 1 117
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $178
byte 1 103
byte 1 95
byte 1 110
byte 1 111
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 82
byte 1 101
byte 1 103
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $177
byte 1 103
byte 1 95
byte 1 110
byte 1 111
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $176
byte 1 0
align 1
LABELV $175
byte 1 103
byte 1 95
byte 1 116
byte 1 101
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $174
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 83
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $173
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 77
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 80
byte 1 80
byte 1 0
align 1
LABELV $172
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
byte 1 109
byte 1 97
byte 1 120
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
LABELV $171
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 76
byte 1 97
byte 1 117
byte 1 110
byte 1 99
byte 1 104
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $170
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 83
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $169
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 77
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 80
byte 1 80
byte 1 0
align 1
LABELV $168
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 109
byte 1 97
byte 1 120
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
LABELV $167
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 76
byte 1 97
byte 1 117
byte 1 110
byte 1 99
byte 1 104
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $166
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 83
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $165
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 77
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 80
byte 1 80
byte 1 0
align 1
LABELV $164
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 95
byte 1 109
byte 1 97
byte 1 120
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
LABELV $163
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 76
byte 1 97
byte 1 117
byte 1 110
byte 1 99
byte 1 104
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $162
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 102
byte 1 97
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 83
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $161
byte 1 49
byte 1 48
byte 1 0
align 1
LABELV $160
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 102
byte 1 97
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 77
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 80
byte 1 80
byte 1 0
align 1
LABELV $159
byte 1 54
byte 1 48
byte 1 0
align 1
LABELV $158
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 102
byte 1 97
byte 1 95
byte 1 109
byte 1 97
byte 1 120
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
LABELV $157
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 102
byte 1 97
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 76
byte 1 97
byte 1 117
byte 1 110
byte 1 99
byte 1 104
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $156
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 76
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $155
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
byte 1 99
byte 1 108
byte 1 111
byte 1 97
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 68
byte 1 101
byte 1 118
byte 1 105
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $154
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
byte 1 117
byte 1 110
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 101
byte 1 100
byte 1 65
byte 1 109
byte 1 109
byte 1 111
byte 1 0
align 1
LABELV $153
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
byte 1 110
byte 1 111
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 82
byte 1 101
byte 1 103
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $152
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
byte 1 110
byte 1 111
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $151
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $150
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
byte 1 116
byte 1 115
byte 1 115
byte 1 0
align 1
LABELV $149
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 100
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $148
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
byte 1 102
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 108
byte 1 121
byte 1 0
align 1
LABELV $147
byte 1 51
byte 1 48
byte 1 0
align 1
LABELV $146
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $145
byte 1 56
byte 1 0
align 1
LABELV $144
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $143
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 76
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $142
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 99
byte 1 108
byte 1 111
byte 1 97
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 68
byte 1 101
byte 1 118
byte 1 105
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $141
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 117
byte 1 110
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 101
byte 1 100
byte 1 65
byte 1 109
byte 1 109
byte 1 111
byte 1 0
align 1
LABELV $140
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 110
byte 1 111
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 82
byte 1 101
byte 1 103
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $139
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 110
byte 1 111
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $138
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $137
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 116
byte 1 115
byte 1 115
byte 1 0
align 1
LABELV $136
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 100
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $135
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 102
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 108
byte 1 121
byte 1 0
align 1
LABELV $134
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $133
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $132
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 76
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $131
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 95
byte 1 99
byte 1 108
byte 1 111
byte 1 97
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 68
byte 1 101
byte 1 118
byte 1 105
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $130
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 95
byte 1 117
byte 1 110
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 101
byte 1 100
byte 1 65
byte 1 109
byte 1 109
byte 1 111
byte 1 0
align 1
LABELV $129
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 95
byte 1 110
byte 1 111
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 82
byte 1 101
byte 1 103
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $128
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 95
byte 1 110
byte 1 111
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $127
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $126
byte 1 49
byte 1 53
byte 1 0
align 1
LABELV $125
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $124
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $123
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 102
byte 1 97
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 76
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $122
byte 1 49
byte 1 0
align 1
LABELV $121
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 102
byte 1 97
byte 1 95
byte 1 99
byte 1 108
byte 1 111
byte 1 97
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 68
byte 1 101
byte 1 118
byte 1 105
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $120
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 102
byte 1 97
byte 1 95
byte 1 117
byte 1 110
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 101
byte 1 100
byte 1 65
byte 1 109
byte 1 109
byte 1 111
byte 1 0
align 1
LABELV $119
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 102
byte 1 97
byte 1 95
byte 1 110
byte 1 111
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 82
byte 1 101
byte 1 103
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $118
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 102
byte 1 97
byte 1 95
byte 1 110
byte 1 111
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $117
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 102
byte 1 97
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $116
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 102
byte 1 97
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 100
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $115
byte 1 48
byte 1 0
align 1
LABELV $114
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 102
byte 1 97
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $113
byte 1 50
byte 1 48
byte 1 0
align 1
LABELV $112
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 102
byte 1 97
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
