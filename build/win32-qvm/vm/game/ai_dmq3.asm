export BotSetUserInfo
code
proc BotSetUserInfo 1024 12
file "..\..\..\..\code\game\ai_dmq3.c"
line 96
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:
;4:/*****************************************************************************
;5: * name:		ai_dmq3.c
;6: *
;7: * desc:		Quake3 bot AI
;8: *
;9: * $Archive: /MissionPack/code/game/ai_dmq3.c $
;10: *
;11: *****************************************************************************/
;12:
;13:
;14:#include "g_local.h"
;15:#include "botlib.h"
;16:#include "be_aas.h"
;17:#include "be_ea.h"
;18:#include "be_ai_char.h"
;19:#include "be_ai_chat.h"
;20:#include "be_ai_gen.h"
;21:#include "be_ai_goal.h"
;22:#include "be_ai_move.h"
;23:#include "be_ai_weap.h"
;24://
;25:#include "ai_main.h"
;26:#include "ai_dmq3.h"
;27:#include "ai_chat.h"
;28:#include "ai_cmd.h"
;29:#include "ai_dmnet.h"
;30:#include "ai_team.h"
;31://
;32:#include "chars.h"				//characteristics
;33:#include "inv.h"				//indexes into the inventory
;34:#include "syn.h"				//synonyms
;35:#include "match.h"				//string matching types and vars
;36:
;37:// for the voice chats
;38:#include "../../ui/menudef.h" // sos001205 - for q3_ui also
;39:
;40:// from aasfile.h
;41:#define AREACONTENTS_MOVER				1024
;42:#define AREACONTENTS_MODELNUMSHIFT		24
;43:#define AREACONTENTS_MAXMODELNUM		0xFF
;44:#define AREACONTENTS_MODELNUM			(AREACONTENTS_MAXMODELNUM << AREACONTENTS_MODELNUMSHIFT)
;45:
;46:#define IDEAL_ATTACKDIST			140
;47:
;48:#define MAX_WAYPOINTS		128
;49://
;50:bot_waypoint_t botai_waypoints[MAX_WAYPOINTS];
;51:bot_waypoint_t *botai_freewaypoints;
;52:
;53://NOTE: not using a cvars which can be updated because the game should be reloaded anyway
;54:int gametype;		//game type
;55:int maxclients;		//maximum number of clients
;56:
;57:vmCvar_t bot_grapple;
;58:vmCvar_t bot_rocketjump;
;59:vmCvar_t bot_fastchat;
;60:vmCvar_t bot_nochat;
;61:vmCvar_t bot_testrchat;
;62:vmCvar_t bot_challenge;
;63:vmCvar_t bot_predictobstacles;
;64:vmCvar_t g_spSkill;
;65:
;66:extern vmCvar_t bot_developer;
;67:
;68:vec3_t lastteleport_origin;		//last teleport event origin
;69:float lastteleport_time;		//last teleport event time
;70:int max_bspmodelindex;			//maximum BSP model index
;71:
;72://CTF flag goals
;73:bot_goal_t ctf_redflag;
;74:bot_goal_t ctf_blueflag;
;75:#ifdef MISSIONPACK
;76:bot_goal_t ctf_neutralflag;
;77:bot_goal_t redobelisk;
;78:bot_goal_t blueobelisk;
;79:bot_goal_t neutralobelisk;
;80:#endif
;81:
;82:#define MAX_ALTROUTEGOALS		32
;83:
;84:int altroutegoals_setup;
;85:aas_altroutegoal_t red_altroutegoals[MAX_ALTROUTEGOALS];
;86:int red_numaltroutegoals;
;87:aas_altroutegoal_t blue_altroutegoals[MAX_ALTROUTEGOALS];
;88:int blue_numaltroutegoals;
;89:
;90:
;91:/*
;92:==================
;93:BotSetUserInfo
;94:==================
;95:*/
;96:void BotSetUserInfo(bot_state_t *bs, char *key, char *value) {
line 99
;97:	char userinfo[MAX_INFO_STRING];
;98:
;99:	trap_GetUserinfo(bs->client, userinfo, sizeof(userinfo));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 100
;100:	Info_SetValueForKey(userinfo, key, value);
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 101
;101:	trap_SetUserinfo(bs->client, userinfo);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_SetUserinfo
CALLV
pop
line 102
;102:	ClientUserinfoChanged( bs->client );
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 ClientUserinfoChanged
CALLV
pop
line 103
;103:}
LABELV $92
endproc BotSetUserInfo 1024 12
export BotCTFCarryingFlag
proc BotCTFCarryingFlag 0 0
line 110
;104:
;105:/*
;106:==================
;107:BotCTFCarryingFlag
;108:==================
;109:*/
;110:int BotCTFCarryingFlag(bot_state_t *bs) {
line 111
;111:	if (gametype != GT_CTF) return CTF_FLAG_NONE;
ADDRGP4 gametype
INDIRI4
CNSTI4 4
EQI4 $94
CNSTI4 0
RETI4
ADDRGP4 $93
JUMPV
LABELV $94
line 113
;112:
;113:	if (bs->inventory[INVENTORY_REDFLAG] > 0) return CTF_FLAG_RED;
ADDRFP4 0
INDIRP4
CNSTI4 5140
ADDP4
INDIRI4
CNSTI4 0
LEI4 $96
CNSTI4 1
RETI4
ADDRGP4 $93
JUMPV
LABELV $96
line 114
;114:	else if (bs->inventory[INVENTORY_BLUEFLAG] > 0) return CTF_FLAG_BLUE;
ADDRFP4 0
INDIRP4
CNSTI4 5144
ADDP4
INDIRI4
CNSTI4 0
LEI4 $98
CNSTI4 2
RETI4
ADDRGP4 $93
JUMPV
LABELV $98
line 115
;115:	return CTF_FLAG_NONE;
CNSTI4 0
RETI4
LABELV $93
endproc BotCTFCarryingFlag 0 0
export BotTeam
proc BotTeam 1044 12
line 123
;116:}
;117:
;118:/*
;119:==================
;120:BotTeam
;121:==================
;122:*/
;123:int BotTeam(bot_state_t *bs) {
line 126
;124:	char info[1024];
;125:
;126:	if (bs->client < 0 || bs->client >= MAX_CLIENTS) {
ADDRLP4 1024
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1024
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 0
LTI4 $103
ADDRLP4 1024
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 64
LTI4 $101
LABELV $103
line 128
;127:		//BotAI_Print(PRT_ERROR, "BotCTFTeam: client out of range\n");
;128:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $100
JUMPV
LABELV $101
line 130
;129:	}
;130:	trap_GetConfigstring(CS_PLAYERS+bs->client, info, sizeof(info));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 132
;131:	//
;132:	if (atoi(Info_ValueForKey(info, "t")) == TEAM_RED) return TEAM_RED;
ADDRLP4 0
ARGP4
ADDRGP4 $106
ARGP4
ADDRLP4 1028
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRLP4 1032
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 1
NEI4 $104
CNSTI4 1
RETI4
ADDRGP4 $100
JUMPV
LABELV $104
line 133
;133:	else if (atoi(Info_ValueForKey(info, "t")) == TEAM_BLUE) return TEAM_BLUE;
ADDRLP4 0
ARGP4
ADDRGP4 $106
ARGP4
ADDRLP4 1036
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1036
INDIRP4
ARGP4
ADDRLP4 1040
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 2
NEI4 $107
CNSTI4 2
RETI4
ADDRGP4 $100
JUMPV
LABELV $107
line 134
;134:	return TEAM_FREE;
CNSTI4 0
RETI4
LABELV $100
endproc BotTeam 1044 12
export BotOppositeTeam
proc BotOppositeTeam 12 4
line 142
;135:}
;136:
;137:/*
;138:==================
;139:BotOppositeTeam
;140:==================
;141:*/
;142:int BotOppositeTeam(bot_state_t *bs) {
line 143
;143:	switch(BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $113
ADDRLP4 0
INDIRI4
CNSTI4 2
EQI4 $114
ADDRGP4 $110
JUMPV
LABELV $113
line 144
;144:		case TEAM_RED: return TEAM_BLUE;
CNSTI4 2
RETI4
ADDRGP4 $109
JUMPV
LABELV $114
line 145
;145:		case TEAM_BLUE: return TEAM_RED;
CNSTI4 1
RETI4
ADDRGP4 $109
JUMPV
LABELV $110
line 146
;146:		default: return TEAM_FREE;
CNSTI4 0
RETI4
LABELV $109
endproc BotOppositeTeam 12 4
export BotFindCTFBases
proc BotFindCTFBases 32 8
line 155
;147:	}
;148:}
;149:
;150:/*
;151:==================
;152:JUHOX: BotFindCTFBases
;153:==================
;154:*/
;155:void BotFindCTFBases(void) {
line 160
;156:	int i;
;157:	qboolean foundRedFlag;
;158:	qboolean foundBlueFlag;
;159:
;160:	if (g_gametype.integer != GT_CTF) return;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
EQI4 $116
ADDRGP4 $115
JUMPV
LABELV $116
line 161
;161:	if (!trap_AAS_Initialized()) return;
ADDRLP4 12
ADDRGP4 trap_AAS_Initialized
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $119
ADDRGP4 $115
JUMPV
LABELV $119
line 162
;162:	if (ctf_redflag.areanum && ctf_blueflag.areanum) return;
ADDRGP4 ctf_redflag+12
INDIRI4
CNSTI4 0
EQI4 $121
ADDRGP4 ctf_blueflag+12
INDIRI4
CNSTI4 0
EQI4 $121
ADDRGP4 $115
JUMPV
LABELV $121
line 164
;163:
;164:	foundRedFlag = qfalse;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 165
;165:	foundBlueFlag = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 167
;166:
;167:	for (i = MAX_CLIENTS; i < level.num_entities; i++) {
ADDRLP4 0
CNSTI4 64
ASGNI4
ADDRGP4 $128
JUMPV
LABELV $125
line 171
;168:		gentity_t* ent;
;169:		gitem_t* item;
;170:		
;171:		ent = &g_entities[i];
ADDRLP4 20
ADDRLP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 172
;172:		if (!ent->inuse) continue;
ADDRLP4 20
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $130
ADDRGP4 $126
JUMPV
LABELV $130
line 178
;173:		//if (ent->s.eType != ET_ITEM) continue;
;174:		//if (!ent->r.linked) continue;
;175:		//if (ent->s.eFlags & EF_NODRAW) continue;
;176:		//if (ent->flags & FL_DROPPED_ITEM) continue;
;177:
;178:		item = ent->item;
ADDRLP4 16
ADDRLP4 20
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
ASGNP4
line 179
;179:		if (!item) continue;
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $132
ADDRGP4 $126
JUMPV
LABELV $132
line 181
;180:
;181:		if (item->giType != IT_TEAM) continue;
ADDRLP4 16
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
EQI4 $134
ADDRGP4 $126
JUMPV
LABELV $134
line 183
;182:
;183:		switch (item->giTag) {
ADDRLP4 24
ADDRLP4 16
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 7
EQI4 $139
ADDRLP4 24
INDIRI4
CNSTI4 8
EQI4 $140
ADDRGP4 $136
JUMPV
LABELV $139
line 185
;184:		case PW_REDFLAG:
;185:			BotCreateItemGoal(ent, &ctf_redflag);
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 ctf_redflag
ARGP4
ADDRGP4 BotCreateItemGoal
CALLV
pop
line 186
;186:			foundRedFlag = qtrue;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 187
;187:			break;
ADDRGP4 $137
JUMPV
LABELV $140
line 189
;188:		case PW_BLUEFLAG:
;189:			BotCreateItemGoal(ent, &ctf_blueflag);
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
ADDRGP4 BotCreateItemGoal
CALLV
pop
line 190
;190:			foundBlueFlag = qtrue;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 191
;191:			break;
LABELV $136
LABELV $137
line 193
;192:		}
;193:	}
LABELV $126
line 167
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $128
ADDRLP4 0
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $125
line 195
;194:
;195:	if (!foundRedFlag) BotAI_Print(PRT_WARNING, "CTF without Red Flag\n");
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $141
CNSTI4 2
ARGI4
ADDRGP4 $143
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
LABELV $141
line 196
;196:	if (!foundBlueFlag) BotAI_Print(PRT_WARNING, "CTF without Blue Flag\n");
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $144
CNSTI4 2
ARGI4
ADDRGP4 $146
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
LABELV $144
line 197
;197:}
LABELV $115
endproc BotFindCTFBases 32 8
export BotEnemyFlag
proc BotEnemyFlag 4 4
line 204
;198:
;199:/*
;200:==================
;201:BotEnemyFlag
;202:==================
;203:*/
;204:bot_goal_t *BotEnemyFlag(bot_state_t *bs) {
line 205
;205:	if (BotTeam(bs) == TEAM_RED) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $148
line 206
;206:		return &ctf_blueflag;
ADDRGP4 ctf_blueflag
RETP4
ADDRGP4 $147
JUMPV
LABELV $148
line 208
;207:	}
;208:	else {
line 209
;209:		return &ctf_redflag;
ADDRGP4 ctf_redflag
RETP4
LABELV $147
endproc BotEnemyFlag 4 4
export BotTeamFlag
proc BotTeamFlag 4 4
line 218
;210:	}
;211:}
;212:
;213:/*
;214:==================
;215:BotTeamFlag
;216:==================
;217:*/
;218:bot_goal_t *BotTeamFlag(bot_state_t *bs) {
line 219
;219:	if (BotTeam(bs) == TEAM_RED) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $151
line 220
;220:		return &ctf_redflag;
ADDRGP4 ctf_redflag
RETP4
ADDRGP4 $150
JUMPV
LABELV $151
line 222
;221:	}
;222:	else {
line 223
;223:		return &ctf_blueflag;
ADDRGP4 ctf_blueflag
RETP4
LABELV $150
endproc BotTeamFlag 4 4
export EntityIsDead
proc EntityIsDead 16 4
line 233
;224:	}
;225:}
;226:
;227:
;228:/*
;229:==================
;230:EntityIsDead
;231:==================
;232:*/
;233:qboolean EntityIsDead(aas_entityinfo_t *entinfo) {
line 246
;234:	// JUHOX: let EntityIsDead() accept monsters
;235:#if !MONSTER_MODE
;236:	playerState_t ps;
;237:
;238:	if (entinfo->number >= 0 && entinfo->number < MAX_CLIENTS) {
;239:		//retrieve the current client state
;240:		BotAI_GetClientState( entinfo->number, &ps );
;241:		if (ps.pm_type != PM_NORMAL) return qtrue;
;242:		if (ps.stats[STAT_HEALTH] <= 0) return qtrue;	// JUHOX: safety check
;243:	}
;244:	return qfalse;
;245:#else
;246:	if (entinfo->number >= 0 && entinfo->number < level.num_entities) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 0
LTI4 $154
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ADDRGP4 level+12
INDIRI4
GEI4 $154
line 250
;247:		gentity_t* ent;
;248:		playerState_t* ps;
;249:
;250:		ent = &g_entities[entinfo->number];
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 251
;251:		if (!ent->inuse) return qtrue;
ADDRLP4 4
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $157
CNSTI4 1
RETI4
ADDRGP4 $153
JUMPV
LABELV $157
line 252
;252:		if (!ent->r.linked) return qtrue;
ADDRLP4 4
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
CNSTI4 0
NEI4 $159
CNSTI4 1
RETI4
ADDRGP4 $153
JUMPV
LABELV $159
line 254
;253:
;254:		ps = G_GetEntityPlayerState(ent);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 12
INDIRP4
ASGNP4
line 255
;255:		if (!ps) return qtrue;
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $161
CNSTI4 1
RETI4
ADDRGP4 $153
JUMPV
LABELV $161
line 257
;256:
;257:		if (ps->pm_type != PM_NORMAL) return qtrue;
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $163
CNSTI4 1
RETI4
ADDRGP4 $153
JUMPV
LABELV $163
line 258
;258:		if (ps->stats[STAT_HEALTH] <= 0) return qtrue;
ADDRLP4 8
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $165
CNSTI4 1
RETI4
ADDRGP4 $153
JUMPV
LABELV $165
line 260
;259:
;260:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $153
JUMPV
LABELV $154
line 262
;261:	}
;262:	return qtrue;
CNSTI4 1
RETI4
LABELV $153
endproc EntityIsDead 16 4
export EntityCarriesFlag
proc EntityCarriesFlag 0 0
line 271
;263:#endif
;264:}
;265:
;266:/*
;267:==================
;268:EntityCarriesFlag
;269:==================
;270:*/
;271:qboolean EntityCarriesFlag(aas_entityinfo_t *entinfo) {
line 272
;272:	if ( entinfo->powerups & ( 1 << PW_REDFLAG ) )
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $168
line 273
;273:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $167
JUMPV
LABELV $168
line 274
;274:	if ( entinfo->powerups & ( 1 << PW_BLUEFLAG ) )
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $170
line 275
;275:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $167
JUMPV
LABELV $170
line 280
;276:#ifdef MISSIONPACK
;277:	if ( entinfo->powerups & ( 1 << PW_NEUTRALFLAG ) )
;278:		return qtrue;
;279:#endif
;280:	return qfalse;
CNSTI4 0
RETI4
LABELV $167
endproc EntityCarriesFlag 0 0
export EntityIsInvisible
proc EntityIsInvisible 944 8
line 301
;281:}
;282:
;283:/*
;284:==================
;285:EntityIsInvisible
;286:==================
;287:*/
;288:// JUHOX: take the marks into account
;289:#if 0
;290:qboolean EntityIsInvisible(aas_entityinfo_t *entinfo) {
;291:	// the flag is always visible
;292:	if (EntityCarriesFlag(entinfo)) {
;293:		return qfalse;
;294:	}
;295:	if (entinfo->powerups & (1 << PW_INVIS)) {
;296:		return qtrue;
;297:	}
;298:	return qfalse;
;299:}
;300:#else
;301:qboolean EntityIsInvisible(int viewer, aas_entityinfo_t *entinfo) {
line 303
;302:	if (
;303:		(
ADDRFP4 4
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
CNSTI4 1428
BANDI4
CNSTI4 16
NEI4 $173
line 313
;304:			entinfo->powerups &
;305:			(
;306:				(1 << PW_INVIS) |
;307:				(1 << PW_BATTLESUIT) |
;308:				(1 << PW_CHARGE) |
;309:				(1 << PW_REDFLAG) |
;310:				(1 << PW_BLUEFLAG)
;311:			)
;312:		) == (1 << PW_INVIS)
;313:	) {
line 316
;314:		playerState_t ps1, ps2;
;315:
;316:		if (g_gametype.integer < GT_TEAM) return qtrue;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
GEI4 $175
CNSTI4 1
RETI4
ADDRGP4 $172
JUMPV
LABELV $175
line 317
;317:		if (viewer == VIEWER_SAMETEAM) return qfalse;
ADDRFP4 0
INDIRI4
CNSTI4 -1
NEI4 $178
CNSTI4 0
RETI4
ADDRGP4 $172
JUMPV
LABELV $178
line 318
;318:		if (viewer == VIEWER_OTHERTEAM) return qtrue;
ADDRFP4 0
INDIRI4
CNSTI4 -2
NEI4 $180
CNSTI4 1
RETI4
ADDRGP4 $172
JUMPV
LABELV $180
line 319
;319:		if (!BotAI_GetClientState(viewer, &ps1)) return qtrue;
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 936
ADDRGP4 BotAI_GetClientState
CALLI4
ASGNI4
ADDRLP4 936
INDIRI4
CNSTI4 0
NEI4 $182
CNSTI4 1
RETI4
ADDRGP4 $172
JUMPV
LABELV $182
line 320
;320:		if (!BotAI_GetClientState(entinfo->number, &ps2)) return qtrue;
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ARGI4
ADDRLP4 468
ARGP4
ADDRLP4 940
ADDRGP4 BotAI_GetClientState
CALLI4
ASGNI4
ADDRLP4 940
INDIRI4
CNSTI4 0
NEI4 $184
CNSTI4 1
RETI4
ADDRGP4 $172
JUMPV
LABELV $184
line 321
;321:		if (ps1.persistant[PERS_TEAM] == ps2.persistant[PERS_TEAM]) return qfalse;
ADDRLP4 0+248+12
INDIRI4
ADDRLP4 468+248+12
INDIRI4
NEI4 $186
CNSTI4 0
RETI4
ADDRGP4 $172
JUMPV
LABELV $186
line 322
;322:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $172
JUMPV
LABELV $173
line 324
;323:	}
;324:	return qfalse;
CNSTI4 0
RETI4
LABELV $172
endproc EntityIsInvisible 944 8
export EntityIsShooting
proc EntityIsShooting 0 0
line 333
;325:}
;326:#endif
;327:
;328:/*
;329:==================
;330:EntityIsShooting
;331:==================
;332:*/
;333:qboolean EntityIsShooting(aas_entityinfo_t *entinfo) {
line 334
;334:	if (entinfo->flags & EF_FIRING) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $193
line 335
;335:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $192
JUMPV
LABELV $193
line 337
;336:	}
;337:	return qfalse;
CNSTI4 0
RETI4
LABELV $192
endproc EntityIsShooting 0 0
export EntityIsChatting
proc EntityIsChatting 0 0
line 345
;338:}
;339:
;340:/*
;341:==================
;342:EntityIsChatting
;343:==================
;344:*/
;345:qboolean EntityIsChatting(aas_entityinfo_t *entinfo) {
line 346
;346:	if (entinfo->flags & EF_TALK) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $196
line 347
;347:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $195
JUMPV
LABELV $196
line 349
;348:	}
;349:	return qfalse;
CNSTI4 0
RETI4
LABELV $195
endproc EntityIsChatting 0 0
export EntityHasQuad
proc EntityHasQuad 0 0
line 357
;350:}
;351:
;352:/*
;353:==================
;354:EntityHasQuad
;355:==================
;356:*/
;357:qboolean EntityHasQuad(aas_entityinfo_t *entinfo) {
line 364
;358:	// JUHOX: quad powerup is not used
;359:#if 0
;360:	if (entinfo->powerups & (1 << PW_QUAD)) {
;361:		return qtrue;
;362:	}
;363:#endif
;364:	return qfalse;
CNSTI4 0
RETI4
LABELV $198
endproc EntityHasQuad 0 0
export BotRememberLastOrderedTask
proc BotRememberLastOrderedTask 16 12
line 428
;365:}
;366:
;367:#ifdef MISSIONPACK
;368:/*
;369:==================
;370:EntityHasKamikze
;371:==================
;372:*/
;373:qboolean EntityHasKamikaze(aas_entityinfo_t *entinfo) {
;374:	if (entinfo->flags & EF_KAMIKAZE) {
;375:		return qtrue;
;376:	}
;377:	return qfalse;
;378:}
;379:
;380:/*
;381:==================
;382:EntityCarriesCubes
;383:==================
;384:*/
;385:qboolean EntityCarriesCubes(aas_entityinfo_t *entinfo) {
;386:	entityState_t state;
;387:
;388:	if (gametype != GT_HARVESTER)
;389:		return qfalse;
;390:	//FIXME: get this info from the aas_entityinfo_t ?
;391:	BotAI_GetEntityState(entinfo->number, &state);
;392:	if (state.generic1 > 0)
;393:		return qtrue;
;394:	return qfalse;
;395:}
;396:
;397:/*
;398:==================
;399:Bot1FCTFCarryingFlag
;400:==================
;401:*/
;402:int Bot1FCTFCarryingFlag(bot_state_t *bs) {
;403:	if (gametype != GT_1FCTF) return qfalse;
;404:
;405:	if (bs->inventory[INVENTORY_NEUTRALFLAG] > 0) return qtrue;
;406:	return qfalse;
;407:}
;408:
;409:/*
;410:==================
;411:BotHarvesterCarryingCubes
;412:==================
;413:*/
;414:int BotHarvesterCarryingCubes(bot_state_t *bs) {
;415:	if (gametype != GT_HARVESTER) return qfalse;
;416:
;417:	if (bs->inventory[INVENTORY_REDCUBE] > 0) return qtrue;
;418:	if (bs->inventory[INVENTORY_BLUECUBE] > 0) return qtrue;
;419:	return qfalse;
;420:}
;421:#endif
;422:
;423:/*
;424:==================
;425:BotRememberLastOrderedTask
;426:==================
;427:*/
;428:void BotRememberLastOrderedTask(bot_state_t *bs) {
line 429
;429:	if (!bs->ordered) {
ADDRFP4 0
INDIRP4
CNSTI4 11568
ADDP4
INDIRI4
CNSTI4 0
NEI4 $200
line 430
;430:		return;
ADDRGP4 $199
JUMPV
LABELV $200
line 432
;431:	}
;432:	bs->lastgoal_decisionmaker = bs->decisionmaker;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 11716
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 11564
ADDP4
INDIRI4
ASGNI4
line 433
;433:	bs->lastgoal_ltgtype = bs->ltgtype;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 11720
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
ASGNI4
line 434
;434:	memcpy(&bs->lastgoal_teamgoal, &bs->teamgoal, sizeof(bot_goal_t));
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 11728
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 11580
ADDP4
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 435
;435:	bs->lastgoal_teammate = bs->teammate;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 11724
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 11560
ADDP4
INDIRI4
ASGNI4
line 436
;436:}
LABELV $199
endproc BotRememberLastOrderedTask 16 12
export BotSetTeamStatus
proc BotSetTeamStatus 0 0
line 443
;437:
;438:/*
;439:==================
;440:BotSetTeamStatus
;441:==================
;442:*/
;443:void BotSetTeamStatus(bot_state_t *bs) {
line 500
;444:#ifdef MISSIONPACK
;445:	int teamtask;
;446:	aas_entityinfo_t entinfo;
;447:
;448:	teamtask = TEAMTASK_PATROL;
;449:
;450:	switch(bs->ltgtype) {
;451:		case LTG_TEAMHELP:
;452:			break;
;453:		case LTG_TEAMACCOMPANY:
;454:			BotEntityInfo(bs->teammate, &entinfo);
;455:			if ( ( (gametype == GT_CTF || gametype == GT_1FCTF) && EntityCarriesFlag(&entinfo))
;456:				|| ( gametype == GT_HARVESTER && EntityCarriesCubes(&entinfo)) ) {
;457:				teamtask = TEAMTASK_ESCORT;
;458:			}
;459:			else {
;460:				teamtask = TEAMTASK_FOLLOW;
;461:			}
;462:			break;
;463:		case LTG_DEFENDKEYAREA:
;464:			teamtask = TEAMTASK_DEFENSE;
;465:			break;
;466:		case LTG_GETFLAG:
;467:			teamtask = TEAMTASK_OFFENSE;
;468:			break;
;469:		case LTG_RUSHBASE:
;470:			teamtask = TEAMTASK_DEFENSE;
;471:			break;
;472:		case LTG_RETURNFLAG:
;473:			teamtask = TEAMTASK_RETRIEVE;
;474:			break;
;475:		case LTG_CAMP:
;476:		case LTG_CAMPORDER:
;477:			teamtask = TEAMTASK_CAMP;
;478:			break;
;479:		case LTG_PATROL:
;480:			teamtask = TEAMTASK_PATROL;
;481:			break;
;482:		case LTG_GETITEM:
;483:			teamtask = TEAMTASK_PATROL;
;484:			break;
;485:		case LTG_KILL:
;486:			teamtask = TEAMTASK_PATROL;
;487:			break;
;488:		case LTG_HARVEST:
;489:			teamtask = TEAMTASK_OFFENSE;
;490:			break;
;491:		case LTG_ATTACKENEMYBASE:
;492:			teamtask = TEAMTASK_OFFENSE;
;493:			break;
;494:		default:
;495:			teamtask = TEAMTASK_PATROL;
;496:			break;
;497:	}
;498:	BotSetUserInfo(bs, "teamtask", va("%d", teamtask));
;499:#endif
;500:}
LABELV $202
endproc BotSetTeamStatus 0 0
export BotPointAreaNum
proc BotPointAreaNum 68 20
line 1469
;501:
;502:// JUHOX: BotSetLastOrderedTask() not needed
;503:#if 0
;504:/*
;505:==================
;506:BotSetLastOrderedTask
;507:==================
;508:*/
;509:int BotSetLastOrderedTask(bot_state_t *bs) {
;510:
;511:	if (gametype == GT_CTF) {
;512:		// don't go back to returning the flag if it's at the base
;513:		if ( bs->lastgoal_ltgtype == LTG_RETURNFLAG ) {
;514:			if ( BotTeam(bs) == TEAM_RED ) {
;515:				if ( bs->redflagstatus == 0 ) {
;516:					bs->lastgoal_ltgtype = 0;
;517:				}
;518:			}
;519:			else {
;520:				if ( bs->blueflagstatus == 0 ) {
;521:					bs->lastgoal_ltgtype = 0;
;522:				}
;523:			}
;524:		}
;525:	}
;526:
;527:	if ( bs->lastgoal_ltgtype ) {
;528:		bs->decisionmaker = bs->lastgoal_decisionmaker;
;529:		bs->ordered = qtrue;
;530:		bs->ltgtype = bs->lastgoal_ltgtype;
;531:		memcpy(&bs->teamgoal, &bs->lastgoal_teamgoal, sizeof(bot_goal_t));
;532:		bs->teammate = bs->lastgoal_teammate;
;533:		bs->teamgoal_time = FloatTime() + 300;
;534:		BotSetTeamStatus(bs);
;535:		//
;536:		if ( gametype == GT_CTF ) {
;537:			if ( bs->ltgtype == LTG_GETFLAG ) {
;538:				bot_goal_t *tb, *eb;
;539:				int tt, et;
;540:
;541:				tb = BotTeamFlag(bs);
;542:				eb = BotEnemyFlag(bs);
;543:				tt = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, tb->areanum, TFL_DEFAULT);
;544:				et = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, eb->areanum, TFL_DEFAULT);
;545:				// if the travel time towards the enemy base is larger than towards our base
;546:				if (et > tt) {
;547:					//get an alternative route goal towards the enemy base
;548:					BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
;549:				}
;550:			}
;551:		}
;552:		return qtrue;
;553:	}
;554:	return qfalse;
;555:}
;556:#endif
;557:
;558:// JUHOX: BotRefuseOrder() not needed
;559:#if 0
;560:/*
;561:==================
;562:BotRefuseOrder
;563:==================
;564:*/
;565:void BotRefuseOrder(bot_state_t *bs) {
;566:	if (!bs->ordered)
;567:		return;
;568:	// if the bot was ordered to do something
;569:	if ( bs->order_time && bs->order_time > FloatTime() - 10 ) {
;570:		trap_EA_Action(bs->client, ACTION_NEGATIVE);
;571:		BotVoiceChat(bs, bs->decisionmaker, VOICECHAT_NO);
;572:		bs->order_time = 0;
;573:	}
;574:}
;575:#endif
;576:
;577:// JUHOX: 'BotCTFSeekGoals()' no longer used
;578:#if 0
;579:/*
;580:==================
;581:BotCTFSeekGoals
;582:==================
;583:*/
;584:void BotCTFSeekGoals(bot_state_t *bs) {
;585:	float rnd, l1, l2;
;586:	int flagstatus, c;
;587:	vec3_t dir;
;588:	aas_entityinfo_t entinfo;
;589:
;590:	//when carrying a flag in ctf the bot should rush to the base
;591:	if (BotCTFCarryingFlag(bs)) {
;592:		//if not already rushing to the base
;593:		if (bs->ltgtype != LTG_RUSHBASE) {
;594:			BotRefuseOrder(bs);
;595:			bs->ltgtype = LTG_RUSHBASE;
;596:			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
;597:			bs->rushbaseaway_time = 0;
;598:			bs->decisionmaker = bs->client;
;599:			bs->ordered = qfalse;
;600:			//
;601:			switch(BotTeam(bs)) {
;602:				case TEAM_RED: VectorSubtract(bs->origin, ctf_blueflag.origin, dir); break;
;603:				case TEAM_BLUE: VectorSubtract(bs->origin, ctf_redflag.origin, dir); break;
;604:				default: VectorSet(dir, 999, 999, 999); break;
;605:			}
;606:			// if the bot picked up the flag very close to the enemy base
;607:			if ( VectorLength(dir) < 128 ) {
;608:				// get an alternative route goal through the enemy base
;609:				BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
;610:			} else {
;611:				// don't use any alt route goal, just get the hell out of the base
;612:				bs->altroutegoal.areanum = 0;
;613:			}
;614:			BotSetUserInfo(bs, "teamtask", va("%d", TEAMTASK_OFFENSE));
;615:			BotVoiceChat(bs, -1, VOICECHAT_IHAVEFLAG);
;616:		}
;617:		else if (bs->rushbaseaway_time > FloatTime()) {
;618:			if (BotTeam(bs) == TEAM_RED) flagstatus = bs->redflagstatus;
;619:			else flagstatus = bs->blueflagstatus;
;620:			//if the flag is back
;621:			if (flagstatus == 0) {
;622:				bs->rushbaseaway_time = 0;
;623:			}
;624:		}
;625:		return;
;626:	}
;627:	// if the bot decided to follow someone
;628:	if ( bs->ltgtype == LTG_TEAMACCOMPANY && !bs->ordered ) {
;629:		// if the team mate being accompanied no longer carries the flag
;630:		BotEntityInfo(bs->teammate, &entinfo);
;631:		if (!EntityCarriesFlag(&entinfo)) {
;632:			bs->ltgtype = 0;
;633:		}
;634:	}
;635:	//
;636:	if (BotTeam(bs) == TEAM_RED) flagstatus = bs->redflagstatus * 2 + bs->blueflagstatus;
;637:	else flagstatus = bs->blueflagstatus * 2 + bs->redflagstatus;
;638:	//if our team has the enemy flag and our flag is at the base
;639:	if (flagstatus == 1) {
;640:		//
;641:		if (bs->owndecision_time < FloatTime()) {
;642:			//if Not defending the base already
;643:			if (!(bs->ltgtype == LTG_DEFENDKEYAREA &&
;644:					(bs->teamgoal.number == ctf_redflag.number ||
;645:					bs->teamgoal.number == ctf_blueflag.number))) {
;646:				//if there is a visible team mate flag carrier
;647:				c = BotTeamFlagCarrierVisible(bs);
;648:				if (c >= 0 &&
;649:						// and not already following the team mate flag carrier
;650:						(bs->ltgtype != LTG_TEAMACCOMPANY || bs->teammate != c)) {
;651:					//
;652:					BotRefuseOrder(bs);
;653:					//follow the flag carrier
;654:					bs->decisionmaker = bs->client;
;655:					bs->ordered = qfalse;
;656:					//the team mate
;657:					bs->teammate = c;
;658:					//last time the team mate was visible
;659:					bs->teammatevisible_time = FloatTime();
;660:					//no message
;661:					bs->teammessage_time = 0;
;662:					//no arrive message
;663:					bs->arrive_time = 1;
;664:					//
;665:					BotVoiceChat(bs, bs->teammate, VOICECHAT_ONFOLLOW);
;666:					//get the team goal time
;667:					bs->teamgoal_time = FloatTime() + TEAM_ACCOMPANY_TIME;
;668:					bs->ltgtype = LTG_TEAMACCOMPANY;
;669:					bs->formation_dist = 3.5 * 32;		//3.5 meter
;670:					BotSetTeamStatus(bs);
;671:					bs->owndecision_time = FloatTime() + 5;
;672:				}
;673:			}
;674:		}
;675:		return;
;676:	}
;677:	//if the enemy has our flag
;678:	else if (flagstatus == 2) {
;679:		//
;680:		if (bs->owndecision_time < FloatTime()) {
;681:			//if enemy flag carrier is visible
;682:			c = BotEnemyFlagCarrierVisible(bs);
;683:			if (c >= 0) {
;684:				//FIXME: fight enemy flag carrier
;685:			}
;686:			//if not already doing something important
;687:			if (bs->ltgtype != LTG_GETFLAG &&
;688:				bs->ltgtype != LTG_RETURNFLAG &&
;689:				bs->ltgtype != LTG_TEAMHELP &&
;690:				bs->ltgtype != LTG_TEAMACCOMPANY &&
;691:				bs->ltgtype != LTG_CAMPORDER &&
;692:				bs->ltgtype != LTG_PATROL &&
;693:				bs->ltgtype != LTG_GETITEM) {
;694:
;695:				BotRefuseOrder(bs);
;696:				bs->decisionmaker = bs->client;
;697:				bs->ordered = qfalse;
;698:				//
;699:				if (random() < 0.5) {
;700:					//go for the enemy flag
;701:					bs->ltgtype = LTG_GETFLAG;
;702:				}
;703:				else {
;704:					bs->ltgtype = LTG_RETURNFLAG;
;705:				}
;706:				//no team message
;707:				bs->teammessage_time = 0;
;708:				//set the time the bot will stop getting the flag
;709:				bs->teamgoal_time = FloatTime() + CTF_GETFLAG_TIME;
;710:				//get an alternative route goal towards the enemy base
;711:				BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
;712:				//
;713:				BotSetTeamStatus(bs);
;714:				bs->owndecision_time = FloatTime() + 5;
;715:			}
;716:		}
;717:		return;
;718:	}
;719:	//if both flags Not at their bases
;720:	else if (flagstatus == 3) {
;721:		//
;722:		if (bs->owndecision_time < FloatTime()) {
;723:			// if not trying to return the flag and not following the team flag carrier
;724:			if ( bs->ltgtype != LTG_RETURNFLAG && bs->ltgtype != LTG_TEAMACCOMPANY ) {
;725:				//
;726:				c = BotTeamFlagCarrierVisible(bs);
;727:				// if there is a visible team mate flag carrier
;728:				if (c >= 0) {
;729:					BotRefuseOrder(bs);
;730:					//follow the flag carrier
;731:					bs->decisionmaker = bs->client;
;732:					bs->ordered = qfalse;
;733:					//the team mate
;734:					bs->teammate = c;
;735:					//last time the team mate was visible
;736:					bs->teammatevisible_time = FloatTime();
;737:					//no message
;738:					bs->teammessage_time = 0;
;739:					//no arrive message
;740:					bs->arrive_time = 1;
;741:					//
;742:					BotVoiceChat(bs, bs->teammate, VOICECHAT_ONFOLLOW);
;743:					//get the team goal time
;744:					bs->teamgoal_time = FloatTime() + TEAM_ACCOMPANY_TIME;
;745:					bs->ltgtype = LTG_TEAMACCOMPANY;
;746:					bs->formation_dist = 3.5 * 32;		//3.5 meter
;747:					//
;748:					BotSetTeamStatus(bs);
;749:					bs->owndecision_time = FloatTime() + 5;
;750:				}
;751:				else {
;752:					BotRefuseOrder(bs);
;753:					bs->decisionmaker = bs->client;
;754:					bs->ordered = qfalse;
;755:					//get the enemy flag
;756:					bs->teammessage_time = FloatTime() + 2 * random();
;757:					//get the flag
;758:					bs->ltgtype = LTG_RETURNFLAG;
;759:					//set the time the bot will stop getting the flag
;760:					bs->teamgoal_time = FloatTime() + CTF_RETURNFLAG_TIME;
;761:					//get an alternative route goal towards the enemy base
;762:					BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
;763:					//
;764:					BotSetTeamStatus(bs);
;765:					bs->owndecision_time = FloatTime() + 5;
;766:				}
;767:			}
;768:		}
;769:		return;
;770:	}
;771:	// don't just do something wait for the bot team leader to give orders
;772:	if (BotTeamLeader(bs)) {
;773:		return;
;774:	}
;775:	// if the bot is ordered to do something
;776:	if ( bs->lastgoal_ltgtype ) {
;777:		bs->teamgoal_time += 60;
;778:	}
;779:	// if the bot decided to do something on it's own and has a last ordered goal
;780:	if ( !bs->ordered && bs->lastgoal_ltgtype ) {
;781:		bs->ltgtype = 0;
;782:	}
;783:	//if already a CTF or team goal
;784:	if (bs->ltgtype == LTG_TEAMHELP ||
;785:			bs->ltgtype == LTG_TEAMACCOMPANY ||
;786:			bs->ltgtype == LTG_DEFENDKEYAREA ||
;787:			bs->ltgtype == LTG_GETFLAG ||
;788:			bs->ltgtype == LTG_RUSHBASE ||
;789:			bs->ltgtype == LTG_RETURNFLAG ||
;790:			bs->ltgtype == LTG_CAMPORDER ||
;791:			bs->ltgtype == LTG_PATROL ||
;792:			bs->ltgtype == LTG_GETITEM ||
;793:			bs->ltgtype == LTG_MAKELOVE_UNDER ||
;794:			bs->ltgtype == LTG_MAKELOVE_ONTOP) {
;795:		return;
;796:	}
;797:	//
;798:	if (BotSetLastOrderedTask(bs))
;799:		return;
;800:	//
;801:	if (bs->owndecision_time > FloatTime())
;802:		return;;
;803:	//if the bot is roaming
;804:	if (bs->ctfroam_time > FloatTime())
;805:		return;
;806:	//if the bot has anough aggression to decide what to do
;807:	if (BotAggression(bs) < 50)
;808:		return;
;809:	//set the time to send a message to the team mates
;810:	bs->teammessage_time = FloatTime() + 2 * random();
;811:	//
;812:	if (bs->teamtaskpreference & (TEAMTP_ATTACKER|TEAMTP_DEFENDER)) {
;813:		if (bs->teamtaskpreference & TEAMTP_ATTACKER) {
;814:			l1 = 0.7f;
;815:		}
;816:		else {
;817:			l1 = 0.2f;
;818:		}
;819:		l2 = 0.9f;
;820:	}
;821:	else {
;822:		l1 = 0.4f;
;823:		l2 = 0.7f;
;824:	}
;825:	//get the flag or defend the base
;826:	rnd = random();
;827:	if (rnd < l1 && ctf_redflag.areanum && ctf_blueflag.areanum) {
;828:		bs->decisionmaker = bs->client;
;829:		bs->ordered = qfalse;
;830:		bs->ltgtype = LTG_GETFLAG;
;831:		//set the time the bot will stop getting the flag
;832:		bs->teamgoal_time = FloatTime() + CTF_GETFLAG_TIME;
;833:		//get an alternative route goal towards the enemy base
;834:		BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
;835:		BotSetTeamStatus(bs);
;836:	}
;837:	else if (rnd < l2 && ctf_redflag.areanum && ctf_blueflag.areanum) {
;838:		bs->decisionmaker = bs->client;
;839:		bs->ordered = qfalse;
;840:		//
;841:		if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &ctf_redflag, sizeof(bot_goal_t));
;842:		else memcpy(&bs->teamgoal, &ctf_blueflag, sizeof(bot_goal_t));
;843:		//set the ltg type
;844:		bs->ltgtype = LTG_DEFENDKEYAREA;
;845:		//set the time the bot stops defending the base
;846:		bs->teamgoal_time = FloatTime() + TEAM_DEFENDKEYAREA_TIME;
;847:		bs->defendaway_time = 0;
;848:		BotSetTeamStatus(bs);
;849:	}
;850:	else {
;851:		bs->ltgtype = 0;
;852:		//set the time the bot will stop roaming
;853:		bs->ctfroam_time = FloatTime() + CTF_ROAM_TIME;
;854:		BotSetTeamStatus(bs);
;855:	}
;856:	bs->owndecision_time = FloatTime() + 5;
;857:#ifdef DEBUG
;858:	BotPrintTeamGoal(bs);
;859:#endif //DEBUG
;860:}
;861:#endif	// JUHOX
;862:
;863:// JUHOX: 'BotCTFRetreatGoals()' no longer used
;864:#if 0
;865:/*
;866:==================
;867:BotCTFRetreatGoals
;868:==================
;869:*/
;870:void BotCTFRetreatGoals(bot_state_t *bs) {
;871:	//when carrying a flag in ctf the bot should rush to the base
;872:	if (BotCTFCarryingFlag(bs)) {
;873:		//if not already rushing to the base
;874:		if (bs->ltgtype != LTG_RUSHBASE) {
;875:			BotRefuseOrder(bs);
;876:			bs->ltgtype = LTG_RUSHBASE;
;877:			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
;878:			bs->rushbaseaway_time = 0;
;879:			bs->decisionmaker = bs->client;
;880:			bs->ordered = qfalse;
;881:			BotSetTeamStatus(bs);
;882:		}
;883:	}
;884:}
;885:#endif	// JUHOX
;886:
;887:#ifdef MISSIONPACK
;888:/*
;889:==================
;890:Bot1FCTFSeekGoals
;891:==================
;892:*/
;893:void Bot1FCTFSeekGoals(bot_state_t *bs) {
;894:	aas_entityinfo_t entinfo;
;895:	float rnd, l1, l2;
;896:	int c;
;897:
;898:	//when carrying a flag in ctf the bot should rush to the base
;899:	if (Bot1FCTFCarryingFlag(bs)) {
;900:		//if not already rushing to the base
;901:		if (bs->ltgtype != LTG_RUSHBASE) {
;902:			BotRefuseOrder(bs);
;903:			bs->ltgtype = LTG_RUSHBASE;
;904:			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
;905:			bs->rushbaseaway_time = 0;
;906:			bs->decisionmaker = bs->client;
;907:			bs->ordered = qfalse;
;908:			//get an alternative route goal towards the enemy base
;909:			BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
;910:			//
;911:			BotSetTeamStatus(bs);
;912:			BotVoiceChat(bs, -1, VOICECHAT_IHAVEFLAG);
;913:		}
;914:		return;
;915:	}
;916:	// if the bot decided to follow someone
;917:	if ( bs->ltgtype == LTG_TEAMACCOMPANY && !bs->ordered ) {
;918:		// if the team mate being accompanied no longer carries the flag
;919:		BotEntityInfo(bs->teammate, &entinfo);
;920:		if (!EntityCarriesFlag(&entinfo)) {
;921:			bs->ltgtype = 0;
;922:		}
;923:	}
;924:	//our team has the flag
;925:	if (bs->neutralflagstatus == 1) {
;926:		if (bs->owndecision_time < FloatTime()) {
;927:			// if not already following someone
;928:			if (bs->ltgtype != LTG_TEAMACCOMPANY) {
;929:				//if there is a visible team mate flag carrier
;930:				c = BotTeamFlagCarrierVisible(bs);
;931:				if (c >= 0) {
;932:					BotRefuseOrder(bs);
;933:					//follow the flag carrier
;934:					bs->decisionmaker = bs->client;
;935:					bs->ordered = qfalse;
;936:					//the team mate
;937:					bs->teammate = c;
;938:					//last time the team mate was visible
;939:					bs->teammatevisible_time = FloatTime();
;940:					//no message
;941:					bs->teammessage_time = 0;
;942:					//no arrive message
;943:					bs->arrive_time = 1;
;944:					//
;945:					BotVoiceChat(bs, bs->teammate, VOICECHAT_ONFOLLOW);
;946:					//get the team goal time
;947:					bs->teamgoal_time = FloatTime() + TEAM_ACCOMPANY_TIME;
;948:					bs->ltgtype = LTG_TEAMACCOMPANY;
;949:					bs->formation_dist = 3.5 * 32;		//3.5 meter
;950:					BotSetTeamStatus(bs);
;951:					bs->owndecision_time = FloatTime() + 5;
;952:					return;
;953:				}
;954:			}
;955:			//if already a CTF or team goal
;956:			if (bs->ltgtype == LTG_TEAMHELP ||
;957:					bs->ltgtype == LTG_TEAMACCOMPANY ||
;958:					bs->ltgtype == LTG_DEFENDKEYAREA ||
;959:					bs->ltgtype == LTG_GETFLAG ||
;960:					bs->ltgtype == LTG_RUSHBASE ||
;961:					bs->ltgtype == LTG_CAMPORDER ||
;962:					bs->ltgtype == LTG_PATROL ||
;963:					bs->ltgtype == LTG_ATTACKENEMYBASE ||
;964:					bs->ltgtype == LTG_GETITEM ||
;965:					bs->ltgtype == LTG_MAKELOVE_UNDER ||
;966:					bs->ltgtype == LTG_MAKELOVE_ONTOP) {
;967:				return;
;968:			}
;969:			//if not already attacking the enemy base
;970:			if (bs->ltgtype != LTG_ATTACKENEMYBASE) {
;971:				BotRefuseOrder(bs);
;972:				bs->decisionmaker = bs->client;
;973:				bs->ordered = qfalse;
;974:				//
;975:				if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &ctf_blueflag, sizeof(bot_goal_t));
;976:				else memcpy(&bs->teamgoal, &ctf_redflag, sizeof(bot_goal_t));
;977:				//set the ltg type
;978:				bs->ltgtype = LTG_ATTACKENEMYBASE;
;979:				//set the time the bot will stop getting the flag
;980:				bs->teamgoal_time = FloatTime() + TEAM_ATTACKENEMYBASE_TIME;
;981:				BotSetTeamStatus(bs);
;982:				bs->owndecision_time = FloatTime() + 5;
;983:			}
;984:		}
;985:		return;
;986:	}
;987:	//enemy team has the flag
;988:	else if (bs->neutralflagstatus == 2) {
;989:		if (bs->owndecision_time < FloatTime()) {
;990:			c = BotEnemyFlagCarrierVisible(bs);
;991:			if (c >= 0) {
;992:				//FIXME: attack enemy flag carrier
;993:			}
;994:			//if already a CTF or team goal
;995:			if (bs->ltgtype == LTG_TEAMHELP ||
;996:					bs->ltgtype == LTG_TEAMACCOMPANY ||
;997:					bs->ltgtype == LTG_CAMPORDER ||
;998:					bs->ltgtype == LTG_PATROL ||
;999:					bs->ltgtype == LTG_GETITEM) {
;1000:				return;
;1001:			}
;1002:			// if not already defending the base
;1003:			if (bs->ltgtype != LTG_DEFENDKEYAREA) {
;1004:				BotRefuseOrder(bs);
;1005:				bs->decisionmaker = bs->client;
;1006:				bs->ordered = qfalse;
;1007:				//
;1008:				if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &ctf_redflag, sizeof(bot_goal_t));
;1009:				else memcpy(&bs->teamgoal, &ctf_blueflag, sizeof(bot_goal_t));
;1010:				//set the ltg type
;1011:				bs->ltgtype = LTG_DEFENDKEYAREA;
;1012:				//set the time the bot stops defending the base
;1013:				bs->teamgoal_time = FloatTime() + TEAM_DEFENDKEYAREA_TIME;
;1014:				bs->defendaway_time = 0;
;1015:				BotSetTeamStatus(bs);
;1016:				bs->owndecision_time = FloatTime() + 5;
;1017:			}
;1018:		}
;1019:		return;
;1020:	}
;1021:	// don't just do something wait for the bot team leader to give orders
;1022:	if (BotTeamLeader(bs)) {
;1023:		return;
;1024:	}
;1025:	// if the bot is ordered to do something
;1026:	if ( bs->lastgoal_ltgtype ) {
;1027:		bs->teamgoal_time += 60;
;1028:	}
;1029:	// if the bot decided to do something on it's own and has a last ordered goal
;1030:	if ( !bs->ordered && bs->lastgoal_ltgtype ) {
;1031:		bs->ltgtype = 0;
;1032:	}
;1033:	//if already a CTF or team goal
;1034:	if (bs->ltgtype == LTG_TEAMHELP ||
;1035:			bs->ltgtype == LTG_TEAMACCOMPANY ||
;1036:			bs->ltgtype == LTG_DEFENDKEYAREA ||
;1037:			bs->ltgtype == LTG_GETFLAG ||
;1038:			bs->ltgtype == LTG_RUSHBASE ||
;1039:			bs->ltgtype == LTG_RETURNFLAG ||
;1040:			bs->ltgtype == LTG_CAMPORDER ||
;1041:			bs->ltgtype == LTG_PATROL ||
;1042:			bs->ltgtype == LTG_ATTACKENEMYBASE ||
;1043:			bs->ltgtype == LTG_GETITEM ||
;1044:			bs->ltgtype == LTG_MAKELOVE_UNDER ||
;1045:			bs->ltgtype == LTG_MAKELOVE_ONTOP) {
;1046:		return;
;1047:	}
;1048:	//
;1049:	if (BotSetLastOrderedTask(bs))
;1050:		return;
;1051:	//
;1052:	if (bs->owndecision_time > FloatTime())
;1053:		return;;
;1054:	//if the bot is roaming
;1055:	if (bs->ctfroam_time > FloatTime())
;1056:		return;
;1057:	//if the bot has anough aggression to decide what to do
;1058:	if (BotAggression(bs) < 50)
;1059:		return;
;1060:	//set the time to send a message to the team mates
;1061:	bs->teammessage_time = FloatTime() + 2 * random();
;1062:	//
;1063:	if (bs->teamtaskpreference & (TEAMTP_ATTACKER|TEAMTP_DEFENDER)) {
;1064:		if (bs->teamtaskpreference & TEAMTP_ATTACKER) {
;1065:			l1 = 0.7f;
;1066:		}
;1067:		else {
;1068:			l1 = 0.2f;
;1069:		}
;1070:		l2 = 0.9f;
;1071:	}
;1072:	else {
;1073:		l1 = 0.4f;
;1074:		l2 = 0.7f;
;1075:	}
;1076:	//get the flag or defend the base
;1077:	rnd = random();
;1078:	if (rnd < l1 && ctf_neutralflag.areanum) {
;1079:		bs->decisionmaker = bs->client;
;1080:		bs->ordered = qfalse;
;1081:		bs->ltgtype = LTG_GETFLAG;
;1082:		//set the time the bot will stop getting the flag
;1083:		bs->teamgoal_time = FloatTime() + CTF_GETFLAG_TIME;
;1084:		BotSetTeamStatus(bs);
;1085:	}
;1086:	else if (rnd < l2 && ctf_redflag.areanum && ctf_blueflag.areanum) {
;1087:		bs->decisionmaker = bs->client;
;1088:		bs->ordered = qfalse;
;1089:		//
;1090:		if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &ctf_redflag, sizeof(bot_goal_t));
;1091:		else memcpy(&bs->teamgoal, &ctf_blueflag, sizeof(bot_goal_t));
;1092:		//set the ltg type
;1093:		bs->ltgtype = LTG_DEFENDKEYAREA;
;1094:		//set the time the bot stops defending the base
;1095:		bs->teamgoal_time = FloatTime() + TEAM_DEFENDKEYAREA_TIME;
;1096:		bs->defendaway_time = 0;
;1097:		BotSetTeamStatus(bs);
;1098:	}
;1099:	else {
;1100:		bs->ltgtype = 0;
;1101:		//set the time the bot will stop roaming
;1102:		bs->ctfroam_time = FloatTime() + CTF_ROAM_TIME;
;1103:		BotSetTeamStatus(bs);
;1104:	}
;1105:	bs->owndecision_time = FloatTime() + 5;
;1106:#ifdef DEBUG
;1107:	BotPrintTeamGoal(bs);
;1108:#endif //DEBUG
;1109:}
;1110:
;1111:/*
;1112:==================
;1113:Bot1FCTFRetreatGoals
;1114:==================
;1115:*/
;1116:void Bot1FCTFRetreatGoals(bot_state_t *bs) {
;1117:	//when carrying a flag in ctf the bot should rush to the enemy base
;1118:	if (Bot1FCTFCarryingFlag(bs)) {
;1119:		//if not already rushing to the base
;1120:		if (bs->ltgtype != LTG_RUSHBASE) {
;1121:			BotRefuseOrder(bs);
;1122:			bs->ltgtype = LTG_RUSHBASE;
;1123:			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
;1124:			bs->rushbaseaway_time = 0;
;1125:			bs->decisionmaker = bs->client;
;1126:			bs->ordered = qfalse;
;1127:			//get an alternative route goal towards the enemy base
;1128:			BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
;1129:			BotSetTeamStatus(bs);
;1130:		}
;1131:	}
;1132:}
;1133:
;1134:/*
;1135:==================
;1136:BotObeliskSeekGoals
;1137:==================
;1138:*/
;1139:void BotObeliskSeekGoals(bot_state_t *bs) {
;1140:	float rnd, l1, l2;
;1141:
;1142:	// don't just do something wait for the bot team leader to give orders
;1143:	if (BotTeamLeader(bs)) {
;1144:		return;
;1145:	}
;1146:	// if the bot is ordered to do something
;1147:	if ( bs->lastgoal_ltgtype ) {
;1148:		bs->teamgoal_time += 60;
;1149:	}
;1150:	//if already a team goal
;1151:	if (bs->ltgtype == LTG_TEAMHELP ||
;1152:			bs->ltgtype == LTG_TEAMACCOMPANY ||
;1153:			bs->ltgtype == LTG_DEFENDKEYAREA ||
;1154:			bs->ltgtype == LTG_GETFLAG ||
;1155:			bs->ltgtype == LTG_RUSHBASE ||
;1156:			bs->ltgtype == LTG_RETURNFLAG ||
;1157:			bs->ltgtype == LTG_CAMPORDER ||
;1158:			bs->ltgtype == LTG_PATROL ||
;1159:			bs->ltgtype == LTG_ATTACKENEMYBASE ||
;1160:			bs->ltgtype == LTG_GETITEM ||
;1161:			bs->ltgtype == LTG_MAKELOVE_UNDER ||
;1162:			bs->ltgtype == LTG_MAKELOVE_ONTOP) {
;1163:		return;
;1164:	}
;1165:	//
;1166:	if (BotSetLastOrderedTask(bs))
;1167:		return;
;1168:	//if the bot is roaming
;1169:	if (bs->ctfroam_time > FloatTime())
;1170:		return;
;1171:	//if the bot has anough aggression to decide what to do
;1172:	if (BotAggression(bs) < 50)
;1173:		return;
;1174:	//set the time to send a message to the team mates
;1175:	bs->teammessage_time = FloatTime() + 2 * random();
;1176:	//
;1177:	if (bs->teamtaskpreference & (TEAMTP_ATTACKER|TEAMTP_DEFENDER)) {
;1178:		if (bs->teamtaskpreference & TEAMTP_ATTACKER) {
;1179:			l1 = 0.7f;
;1180:		}
;1181:		else {
;1182:			l1 = 0.2f;
;1183:		}
;1184:		l2 = 0.9f;
;1185:	}
;1186:	else {
;1187:		l1 = 0.4f;
;1188:		l2 = 0.7f;
;1189:	}
;1190:	//get the flag or defend the base
;1191:	rnd = random();
;1192:	if (rnd < l1 && redobelisk.areanum && blueobelisk.areanum) {
;1193:		bs->decisionmaker = bs->client;
;1194:		bs->ordered = qfalse;
;1195:		//
;1196:		if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &blueobelisk, sizeof(bot_goal_t));
;1197:		else memcpy(&bs->teamgoal, &redobelisk, sizeof(bot_goal_t));
;1198:		//set the ltg type
;1199:		bs->ltgtype = LTG_ATTACKENEMYBASE;
;1200:		//set the time the bot will stop attacking the enemy base
;1201:		bs->teamgoal_time = FloatTime() + TEAM_ATTACKENEMYBASE_TIME;
;1202:		//get an alternate route goal towards the enemy base
;1203:		BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
;1204:		BotSetTeamStatus(bs);
;1205:	}
;1206:	else if (rnd < l2 && redobelisk.areanum && blueobelisk.areanum) {
;1207:		bs->decisionmaker = bs->client;
;1208:		bs->ordered = qfalse;
;1209:		//
;1210:		if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &redobelisk, sizeof(bot_goal_t));
;1211:		else memcpy(&bs->teamgoal, &blueobelisk, sizeof(bot_goal_t));
;1212:		//set the ltg type
;1213:		bs->ltgtype = LTG_DEFENDKEYAREA;
;1214:		//set the time the bot stops defending the base
;1215:		bs->teamgoal_time = FloatTime() + TEAM_DEFENDKEYAREA_TIME;
;1216:		bs->defendaway_time = 0;
;1217:		BotSetTeamStatus(bs);
;1218:	}
;1219:	else {
;1220:		bs->ltgtype = 0;
;1221:		//set the time the bot will stop roaming
;1222:		bs->ctfroam_time = FloatTime() + CTF_ROAM_TIME;
;1223:		BotSetTeamStatus(bs);
;1224:	}
;1225:}
;1226:
;1227:/*
;1228:==================
;1229:BotGoHarvest
;1230:==================
;1231:*/
;1232:void BotGoHarvest(bot_state_t *bs) {
;1233:	//
;1234:	if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &blueobelisk, sizeof(bot_goal_t));
;1235:	else memcpy(&bs->teamgoal, &redobelisk, sizeof(bot_goal_t));
;1236:	//set the ltg type
;1237:	bs->ltgtype = LTG_HARVEST;
;1238:	//set the time the bot will stop harvesting
;1239:	bs->teamgoal_time = FloatTime() + TEAM_HARVEST_TIME;
;1240:	bs->harvestaway_time = 0;
;1241:	BotSetTeamStatus(bs);
;1242:}
;1243:
;1244:/*
;1245:==================
;1246:BotObeliskRetreatGoals
;1247:==================
;1248:*/
;1249:void BotObeliskRetreatGoals(bot_state_t *bs) {
;1250:	//nothing special
;1251:}
;1252:
;1253:/*
;1254:==================
;1255:BotHarvesterSeekGoals
;1256:==================
;1257:*/
;1258:void BotHarvesterSeekGoals(bot_state_t *bs) {
;1259:	aas_entityinfo_t entinfo;
;1260:	float rnd, l1, l2;
;1261:	int c;
;1262:
;1263:	//when carrying cubes in harvester the bot should rush to the base
;1264:	if (BotHarvesterCarryingCubes(bs)) {
;1265:		//if not already rushing to the base
;1266:		if (bs->ltgtype != LTG_RUSHBASE) {
;1267:			BotRefuseOrder(bs);
;1268:			bs->ltgtype = LTG_RUSHBASE;
;1269:			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
;1270:			bs->rushbaseaway_time = 0;
;1271:			bs->decisionmaker = bs->client;
;1272:			bs->ordered = qfalse;
;1273:			//get an alternative route goal towards the enemy base
;1274:			BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
;1275:			//
;1276:			BotSetTeamStatus(bs);
;1277:		}
;1278:		return;
;1279:	}
;1280:	// don't just do something wait for the bot team leader to give orders
;1281:	if (BotTeamLeader(bs)) {
;1282:		return;
;1283:	}
;1284:	// if the bot decided to follow someone
;1285:	if ( bs->ltgtype == LTG_TEAMACCOMPANY && !bs->ordered ) {
;1286:		// if the team mate being accompanied no longer carries the flag
;1287:		BotEntityInfo(bs->teammate, &entinfo);
;1288:		if (!EntityCarriesCubes(&entinfo)) {
;1289:			bs->ltgtype = 0;
;1290:		}
;1291:	}
;1292:	// if the bot is ordered to do something
;1293:	if ( bs->lastgoal_ltgtype ) {
;1294:		bs->teamgoal_time += 60;
;1295:	}
;1296:	//if not yet doing something
;1297:	if (bs->ltgtype == LTG_TEAMHELP ||
;1298:			bs->ltgtype == LTG_TEAMACCOMPANY ||
;1299:			bs->ltgtype == LTG_DEFENDKEYAREA ||
;1300:			bs->ltgtype == LTG_GETFLAG ||
;1301:			bs->ltgtype == LTG_CAMPORDER ||
;1302:			bs->ltgtype == LTG_PATROL ||
;1303:			bs->ltgtype == LTG_ATTACKENEMYBASE ||
;1304:			bs->ltgtype == LTG_HARVEST ||
;1305:			bs->ltgtype == LTG_GETITEM ||
;1306:			bs->ltgtype == LTG_MAKELOVE_UNDER ||
;1307:			bs->ltgtype == LTG_MAKELOVE_ONTOP) {
;1308:		return;
;1309:	}
;1310:	//
;1311:	if (BotSetLastOrderedTask(bs))
;1312:		return;
;1313:	//if the bot is roaming
;1314:	if (bs->ctfroam_time > FloatTime())
;1315:		return;
;1316:	//if the bot has anough aggression to decide what to do
;1317:	if (BotAggression(bs) < 50)
;1318:		return;
;1319:	//set the time to send a message to the team mates
;1320:	bs->teammessage_time = FloatTime() + 2 * random();
;1321:	//
;1322:	c = BotEnemyCubeCarrierVisible(bs);
;1323:	if (c >= 0) {
;1324:		//FIXME: attack enemy cube carrier
;1325:	}
;1326:	if (bs->ltgtype != LTG_TEAMACCOMPANY) {
;1327:		//if there is a visible team mate carrying cubes
;1328:		c = BotTeamCubeCarrierVisible(bs);
;1329:		if (c >= 0) {
;1330:			//follow the team mate carrying cubes
;1331:			bs->decisionmaker = bs->client;
;1332:			bs->ordered = qfalse;
;1333:			//the team mate
;1334:			bs->teammate = c;
;1335:			//last time the team mate was visible
;1336:			bs->teammatevisible_time = FloatTime();
;1337:			//no message
;1338:			bs->teammessage_time = 0;
;1339:			//no arrive message
;1340:			bs->arrive_time = 1;
;1341:			//
;1342:			BotVoiceChat(bs, bs->teammate, VOICECHAT_ONFOLLOW);
;1343:			//get the team goal time
;1344:			bs->teamgoal_time = FloatTime() + TEAM_ACCOMPANY_TIME;
;1345:			bs->ltgtype = LTG_TEAMACCOMPANY;
;1346:			bs->formation_dist = 3.5 * 32;		//3.5 meter
;1347:			BotSetTeamStatus(bs);
;1348:			return;
;1349:		}
;1350:	}
;1351:	//
;1352:	if (bs->teamtaskpreference & (TEAMTP_ATTACKER|TEAMTP_DEFENDER)) {
;1353:		if (bs->teamtaskpreference & TEAMTP_ATTACKER) {
;1354:			l1 = 0.7f;
;1355:		}
;1356:		else {
;1357:			l1 = 0.2f;
;1358:		}
;1359:		l2 = 0.9f;
;1360:	}
;1361:	else {
;1362:		l1 = 0.4f;
;1363:		l2 = 0.7f;
;1364:	}
;1365:	//
;1366:	rnd = random();
;1367:	if (rnd < l1 && redobelisk.areanum && blueobelisk.areanum) {
;1368:		bs->decisionmaker = bs->client;
;1369:		bs->ordered = qfalse;
;1370:		BotGoHarvest(bs);
;1371:	}
;1372:	else if (rnd < l2 && redobelisk.areanum && blueobelisk.areanum) {
;1373:		bs->decisionmaker = bs->client;
;1374:		bs->ordered = qfalse;
;1375:		//
;1376:		if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &redobelisk, sizeof(bot_goal_t));
;1377:		else memcpy(&bs->teamgoal, &blueobelisk, sizeof(bot_goal_t));
;1378:		//set the ltg type
;1379:		bs->ltgtype = LTG_DEFENDKEYAREA;
;1380:		//set the time the bot stops defending the base
;1381:		bs->teamgoal_time = FloatTime() + TEAM_DEFENDKEYAREA_TIME;
;1382:		bs->defendaway_time = 0;
;1383:		BotSetTeamStatus(bs);
;1384:	}
;1385:	else {
;1386:		bs->ltgtype = 0;
;1387:		//set the time the bot will stop roaming
;1388:		bs->ctfroam_time = FloatTime() + CTF_ROAM_TIME;
;1389:		BotSetTeamStatus(bs);
;1390:	}
;1391:}
;1392:
;1393:/*
;1394:==================
;1395:BotHarvesterRetreatGoals
;1396:==================
;1397:*/
;1398:void BotHarvesterRetreatGoals(bot_state_t *bs) {
;1399:	//when carrying cubes in harvester the bot should rush to the base
;1400:	if (BotHarvesterCarryingCubes(bs)) {
;1401:		//if not already rushing to the base
;1402:		if (bs->ltgtype != LTG_RUSHBASE) {
;1403:			BotRefuseOrder(bs);
;1404:			bs->ltgtype = LTG_RUSHBASE;
;1405:			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
;1406:			bs->rushbaseaway_time = 0;
;1407:			bs->decisionmaker = bs->client;
;1408:			bs->ordered = qfalse;
;1409:			BotSetTeamStatus(bs);
;1410:		}
;1411:		return;
;1412:	}
;1413:}
;1414:#endif
;1415:
;1416:// JUHOX: 'BotTeamGoals()' no longer used
;1417:#if 0
;1418:/*
;1419:==================
;1420:BotTeamGoals
;1421:==================
;1422:*/
;1423:void BotTeamGoals(bot_state_t *bs, int retreat) {
;1424:
;1425:	if ( retreat ) {
;1426:		if (gametype == GT_CTF) {
;1427:			BotCTFRetreatGoals(bs);
;1428:		}
;1429:#ifdef MISSIONPACK
;1430:		else if (gametype == GT_1FCTF) {
;1431:			Bot1FCTFRetreatGoals(bs);
;1432:		}
;1433:		else if (gametype == GT_OBELISK) {
;1434:			BotObeliskRetreatGoals(bs);
;1435:		}
;1436:		else if (gametype == GT_HARVESTER) {
;1437:			BotHarvesterRetreatGoals(bs);
;1438:		}
;1439:#endif
;1440:	}
;1441:	else {
;1442:		if (gametype == GT_CTF) {
;1443:			//decide what to do in CTF mode
;1444:			BotCTFSeekGoals(bs);
;1445:		}
;1446:#ifdef MISSIONPACK
;1447:		else if (gametype == GT_1FCTF) {
;1448:			Bot1FCTFSeekGoals(bs);
;1449:		}
;1450:		else if (gametype == GT_OBELISK) {
;1451:			BotObeliskSeekGoals(bs);
;1452:		}
;1453:		else if (gametype == GT_HARVESTER) {
;1454:			BotHarvesterSeekGoals(bs);
;1455:		}
;1456:#endif
;1457:	}
;1458:	// reset the order time which is used to see if
;1459:	// we decided to refuse an order
;1460:	bs->order_time = 0;
;1461:}
;1462:#endif	// JUHOX
;1463:
;1464:/*
;1465:==================
;1466:BotPointAreaNum
;1467:==================
;1468:*/
;1469:int BotPointAreaNum(vec3_t origin) {
line 1473
;1470:	int areanum, numareas, areas[10];
;1471:	vec3_t end;
;1472:
;1473:	areanum = trap_AAS_PointAreaNum(origin);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 trap_AAS_PointAreaNum
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 60
INDIRI4
ASGNI4
line 1474
;1474:	if (areanum) return areanum;
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $204
ADDRLP4 12
INDIRI4
RETI4
ADDRGP4 $203
JUMPV
LABELV $204
line 1475
;1475:	VectorCopy(origin, end);
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 1476
;1476:	end[2] += /*10*/24;	// JUHOX
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1103101952
ADDF4
ASGNF4
line 1477
;1477:	numareas = trap_AAS_TraceAreas(origin, end, areas, NULL, 10);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 20
ARGP4
CNSTP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 64
ADDRGP4 trap_AAS_TraceAreas
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 64
INDIRI4
ASGNI4
line 1478
;1478:	if (numareas > 0) return areas[0];
ADDRLP4 16
INDIRI4
CNSTI4 0
LEI4 $207
ADDRLP4 20
INDIRI4
RETI4
ADDRGP4 $203
JUMPV
LABELV $207
line 1493
;1479:#if 0	// -JUHOX: search area below the point
;1480:	{
;1481:		trace_t trace;
;1482:		vec3_t mins = {-8, -8, -8};
;1483:		vec3_t maxs = {8, 8, 8};
;1484:
;1485:		end[2] -= 10000;
;1486:		trap_Trace(&trace, origin, mins, maxs, end, ENTITYNUM_NONE, MASK_SOLID);
;1487:		if (!trace.allsolid && !trace.startsolid && trace.fraction < 1) {
;1488:			numareas = trap_AAS_TraceAreas(trace.endpos, origin, areas, NULL, 10);
;1489:			if (numareas > 0) return areas[0];
;1490:		}
;1491:	}
;1492:#endif
;1493:	return 0;
CNSTI4 0
RETI4
LABELV $203
endproc BotPointAreaNum 68 20
export ClientName
proc ClientName 1032 12
line 1501
;1494:}
;1495:
;1496:/*
;1497:==================
;1498:ClientName
;1499:==================
;1500:*/
;1501:char *ClientName(int client, char *name, int size) {
line 1504
;1502:	char buf[MAX_INFO_STRING];
;1503:
;1504:	if (client < 0 || client >= MAX_CLIENTS) {
ADDRLP4 1024
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 1024
INDIRI4
CNSTI4 0
LTI4 $212
ADDRLP4 1024
INDIRI4
CNSTI4 64
LTI4 $210
LABELV $212
line 1505
;1505:		BotAI_Print(PRT_ERROR, "ClientName: client out of range\n");
CNSTI4 3
ARGI4
ADDRGP4 $213
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 1506
;1506:		return "[client out of range]";
ADDRGP4 $214
RETP4
ADDRGP4 $209
JUMPV
LABELV $210
line 1508
;1507:	}
;1508:	trap_GetConfigstring(CS_PLAYERS+client, buf, sizeof(buf));
ADDRFP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 1509
;1509:	strncpy(name, Info_ValueForKey(buf, "n"), size-1);
ADDRLP4 0
ARGP4
ADDRGP4 $215
ARGP4
ADDRLP4 1028
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 1510
;1510:	name[size-1] = '\0';
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
ADDRFP4 4
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 1511
;1511:	Q_CleanStr( name );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 1512
;1512:	return name;
ADDRFP4 4
INDIRP4
RETP4
LABELV $209
endproc ClientName 1032 12
export ClientSkin
proc ClientSkin 1032 12
line 1520
;1513:}
;1514:
;1515:/*
;1516:==================
;1517:ClientSkin
;1518:==================
;1519:*/
;1520:char *ClientSkin(int client, char *skin, int size) {
line 1523
;1521:	char buf[MAX_INFO_STRING];
;1522:
;1523:	if (client < 0 || client >= MAX_CLIENTS) {
ADDRLP4 1024
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 1024
INDIRI4
CNSTI4 0
LTI4 $219
ADDRLP4 1024
INDIRI4
CNSTI4 64
LTI4 $217
LABELV $219
line 1524
;1524:		BotAI_Print(PRT_ERROR, "ClientSkin: client out of range\n");
CNSTI4 3
ARGI4
ADDRGP4 $220
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 1525
;1525:		return "[client out of range]";
ADDRGP4 $214
RETP4
ADDRGP4 $216
JUMPV
LABELV $217
line 1527
;1526:	}
;1527:	trap_GetConfigstring(CS_PLAYERS+client, buf, sizeof(buf));
ADDRFP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 1528
;1528:	strncpy(skin, Info_ValueForKey(buf, "model"), size-1);
ADDRLP4 0
ARGP4
ADDRGP4 $221
ARGP4
ADDRLP4 1028
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 1529
;1529:	skin[size-1] = '\0';
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
ADDRFP4 4
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 1530
;1530:	return skin;
ADDRFP4 4
INDIRP4
RETP4
LABELV $216
endproc ClientSkin 1032 12
bss
align 4
LABELV $223
skip 4
export ClientFromName
code
proc ClientFromName 1040 12
line 1538
;1531:}
;1532:
;1533:/*
;1534:==================
;1535:ClientFromName
;1536:==================
;1537:*/
;1538:int ClientFromName(char *name) {
line 1543
;1539:	int i;
;1540:	char buf[MAX_INFO_STRING];
;1541:	static int maxclients;
;1542:
;1543:	if (!maxclients)
ADDRGP4 $223
INDIRI4
CNSTI4 0
NEI4 $224
line 1544
;1544:		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
ADDRGP4 $226
ARGP4
ADDRLP4 1028
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 $223
ADDRLP4 1028
INDIRI4
ASGNI4
LABELV $224
line 1545
;1545:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $230
JUMPV
LABELV $227
line 1546
;1546:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 1547
;1547:		Q_CleanStr( buf );
ADDRLP4 4
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 1548
;1548:		if (!Q_stricmp(Info_ValueForKey(buf, "n"), name)) return i;
ADDRLP4 4
ARGP4
ADDRGP4 $215
ARGP4
ADDRLP4 1032
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1032
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1036
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
NEI4 $231
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $222
JUMPV
LABELV $231
line 1549
;1549:	}
LABELV $228
line 1545
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $230
ADDRLP4 0
INDIRI4
ADDRGP4 $223
INDIRI4
GEI4 $233
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $227
LABELV $233
line 1550
;1550:	return -1;
CNSTI4 -1
RETI4
LABELV $222
endproc ClientFromName 1040 12
bss
align 4
LABELV $235
skip 4
export ClientOnSameTeamFromName
code
proc ClientOnSameTeamFromName 1044 12
line 1558
;1551:}
;1552:
;1553:/*
;1554:==================
;1555:ClientOnSameTeamFromName
;1556:==================
;1557:*/
;1558:int ClientOnSameTeamFromName(bot_state_t *bs, char *name) {
line 1563
;1559:	int i;
;1560:	char buf[MAX_INFO_STRING];
;1561:	static int maxclients;
;1562:
;1563:	if (!maxclients)
ADDRGP4 $235
INDIRI4
CNSTI4 0
NEI4 $236
line 1564
;1564:		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
ADDRGP4 $226
ARGP4
ADDRLP4 1028
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 $235
ADDRLP4 1028
INDIRI4
ASGNI4
LABELV $236
line 1565
;1565:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $241
JUMPV
LABELV $238
line 1566
;1566:		if (!BotSameTeam(bs, i))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1032
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 0
NEI4 $242
line 1567
;1567:			continue;
ADDRGP4 $239
JUMPV
LABELV $242
line 1568
;1568:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 1569
;1569:		Q_CleanStr( buf );
ADDRLP4 4
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 1570
;1570:		if (!Q_stricmp(Info_ValueForKey(buf, "n"), name)) return i;
ADDRLP4 4
ARGP4
ADDRGP4 $215
ARGP4
ADDRLP4 1036
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1036
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1040
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $244
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $234
JUMPV
LABELV $244
line 1571
;1571:	}
LABELV $239
line 1565
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $241
ADDRLP4 0
INDIRI4
ADDRGP4 $235
INDIRI4
GEI4 $246
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $238
LABELV $246
line 1572
;1572:	return -1;
CNSTI4 -1
RETI4
LABELV $234
endproc ClientOnSameTeamFromName 1044 12
export stristr
proc stristr 12 4
line 1580
;1573:}
;1574:
;1575:/*
;1576:==================
;1577:stristr
;1578:==================
;1579:*/
;1580:char *stristr(char *str, char *charset) {
ADDRGP4 $249
JUMPV
LABELV $248
line 1583
;1581:	int i;
;1582:
;1583:	while(*str) {
line 1584
;1584:		for (i = 0; charset[i] && str[i]; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $254
JUMPV
LABELV $251
line 1585
;1585:			if (toupper(charset[i]) != toupper(str[i])) break;
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 4
ADDRGP4 toupper
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 8
ADDRGP4 toupper
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $255
ADDRGP4 $253
JUMPV
LABELV $255
line 1586
;1586:		}
LABELV $252
line 1584
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $254
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $257
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $251
LABELV $257
LABELV $253
line 1587
;1587:		if (!charset[i]) return str;
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $258
ADDRFP4 0
INDIRP4
RETP4
ADDRGP4 $247
JUMPV
LABELV $258
line 1588
;1588:		str++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1589
;1589:	}
LABELV $249
line 1583
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $248
line 1590
;1590:	return NULL;
CNSTP4 0
RETP4
LABELV $247
endproc stristr 12 4
export EasyClientName
proc EasyClientName 196 12
line 1598
;1591:}
;1592:
;1593:/*
;1594:==================
;1595:EasyClientName
;1596:==================
;1597:*/
;1598:char *EasyClientName(int client, char *buf, int size) {
line 1603
;1599:	int i;
;1600:	char *str1, *str2, *ptr, c;
;1601:	char name[128];
;1602:
;1603:	strcpy(name, ClientName(client, name, sizeof(name)));
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 5
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 148
ADDRGP4 ClientName
CALLP4
ASGNP4
ADDRLP4 5
ARGP4
ADDRLP4 148
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1604
;1604:	for (i = 0; name[i]; i++) name[i] &= 127;
ADDRLP4 136
CNSTI4 0
ASGNI4
ADDRGP4 $264
JUMPV
LABELV $261
ADDRLP4 152
ADDRLP4 136
INDIRI4
ADDRLP4 5
ADDP4
ASGNP4
ADDRLP4 152
INDIRP4
ADDRLP4 152
INDIRP4
INDIRI1
CVII4 1
CNSTI4 127
BANDI4
CVII1 4
ASGNI1
LABELV $262
ADDRLP4 136
ADDRLP4 136
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $264
ADDRLP4 136
INDIRI4
ADDRLP4 5
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $261
line 1606
;1605:	//remove all spaces
;1606:	for (ptr = strstr(name, " "); ptr; ptr = strstr(name, " ")) {
ADDRLP4 5
ARGP4
ADDRGP4 $269
ARGP4
ADDRLP4 156
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 156
INDIRP4
ASGNP4
ADDRGP4 $268
JUMPV
LABELV $265
line 1607
;1607:		memmove(ptr, ptr+1, strlen(ptr+1)+1);
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 160
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 160
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 1608
;1608:	}
LABELV $266
line 1606
ADDRLP4 5
ARGP4
ADDRGP4 $269
ARGP4
ADDRLP4 160
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 160
INDIRP4
ASGNP4
LABELV $268
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $265
line 1610
;1609:	//check for [x] and ]x[ clan names
;1610:	str1 = strstr(name, "[");
ADDRLP4 5
ARGP4
ADDRGP4 $270
ARGP4
ADDRLP4 164
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 140
ADDRLP4 164
INDIRP4
ASGNP4
line 1611
;1611:	str2 = strstr(name, "]");
ADDRLP4 5
ARGP4
ADDRGP4 $271
ARGP4
ADDRLP4 168
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 144
ADDRLP4 168
INDIRP4
ASGNP4
line 1612
;1612:	if (str1 && str2) {
ADDRLP4 140
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $272
ADDRLP4 144
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $272
line 1613
;1613:		if (str2 > str1) memmove(str1, str2+1, strlen(str2+1)+1);
ADDRLP4 144
INDIRP4
CVPU4 4
ADDRLP4 140
INDIRP4
CVPU4 4
LEU4 $274
ADDRLP4 144
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 172
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 140
INDIRP4
ARGP4
ADDRLP4 144
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 172
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
ADDRGP4 $275
JUMPV
LABELV $274
line 1614
;1614:		else memmove(str2, str1+1, strlen(str1+1)+1);
ADDRLP4 140
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 176
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 144
INDIRP4
ARGP4
ADDRLP4 140
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 176
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
LABELV $275
line 1615
;1615:	}
LABELV $272
line 1617
;1616:	//remove Mr prefix
;1617:	if ((name[0] == 'm' || name[0] == 'M') &&
ADDRLP4 172
ADDRLP4 5
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 109
EQI4 $280
ADDRLP4 172
INDIRI4
CNSTI4 77
NEI4 $276
LABELV $280
ADDRLP4 5+1
INDIRI1
CVII4 1
CNSTI4 114
EQI4 $281
ADDRLP4 5+1
INDIRI1
CVII4 1
CNSTI4 82
NEI4 $276
LABELV $281
line 1618
;1618:			(name[1] == 'r' || name[1] == 'R')) {
line 1619
;1619:		memmove(name, name+2, strlen(name+2)+1);
ADDRLP4 5+2
ARGP4
ADDRLP4 176
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 5
ARGP4
ADDRLP4 5+2
ARGP4
ADDRLP4 176
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 1620
;1620:	}
LABELV $276
line 1622
;1621:	//only allow lower case alphabet characters
;1622:	ptr = name;
ADDRLP4 0
ADDRLP4 5
ASGNP4
ADDRGP4 $285
JUMPV
LABELV $284
line 1623
;1623:	while(*ptr) {
line 1624
;1624:		c = *ptr;
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI1
ASGNI1
line 1625
;1625:		if ((c >= 'a' && c <= 'z') ||
ADDRLP4 176
ADDRLP4 4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 97
LTI4 $290
ADDRLP4 176
INDIRI4
CNSTI4 122
LEI4 $291
LABELV $290
ADDRLP4 180
ADDRLP4 4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 48
LTI4 $292
ADDRLP4 180
INDIRI4
CNSTI4 57
LEI4 $291
LABELV $292
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 95
NEI4 $287
LABELV $291
line 1626
;1626:				(c >= '0' && c <= '9') || c == '_') {
line 1627
;1627:			ptr++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1628
;1628:		}
ADDRGP4 $288
JUMPV
LABELV $287
line 1629
;1629:		else if (c >= 'A' && c <= 'Z') {
ADDRLP4 184
ADDRLP4 4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 184
INDIRI4
CNSTI4 65
LTI4 $293
ADDRLP4 184
INDIRI4
CNSTI4 90
GTI4 $293
line 1630
;1630:			*ptr += 'a' - 'A';
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 32
ADDI4
CVII1 4
ASGNI1
line 1631
;1631:			ptr++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1632
;1632:		}
ADDRGP4 $294
JUMPV
LABELV $293
line 1633
;1633:		else {
line 1634
;1634:			memmove(ptr, ptr+1, strlen(ptr + 1)+1);
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 188
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 188
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 1635
;1635:		}
LABELV $294
LABELV $288
line 1636
;1636:	}
LABELV $285
line 1623
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $284
line 1637
;1637:	strncpy(buf, name, size-1);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 5
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 1638
;1638:	buf[size-1] = '\0';
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
ADDRFP4 4
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 1639
;1639:	return buf;
ADDRFP4 4
INDIRP4
RETP4
LABELV $260
endproc EasyClientName 196 12
export BotSynonymContext
proc BotSynonymContext 8 4
line 1647
;1640:}
;1641:
;1642:/*
;1643:==================
;1644:BotSynonymContext
;1645:==================
;1646:*/
;1647:int BotSynonymContext(bot_state_t *bs) {
line 1650
;1648:	int context;
;1649:
;1650:	context = CONTEXT_NORMAL|CONTEXT_NEARBYITEM|CONTEXT_NAMES;
ADDRLP4 0
CNSTI4 1027
ASGNI4
line 1652
;1651:	//
;1652:	if (gametype == GT_CTF
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $296
line 1656
;1653:#ifdef MISSIONPACK
;1654:		|| gametype == GT_1FCTF
;1655:#endif
;1656:		) {
line 1657
;1657:		if (BotTeam(bs) == TEAM_RED) context |= CONTEXT_CTFREDTEAM;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 1
NEI4 $298
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 4
BORI4
ASGNI4
ADDRGP4 $299
JUMPV
LABELV $298
line 1658
;1658:		else context |= CONTEXT_CTFBLUETEAM;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 8
BORI4
ASGNI4
LABELV $299
line 1659
;1659:	}
LABELV $296
line 1670
;1660:#ifdef MISSIONPACK
;1661:	else if (gametype == GT_OBELISK) {
;1662:		if (BotTeam(bs) == TEAM_RED) context |= CONTEXT_OBELISKREDTEAM;
;1663:		else context |= CONTEXT_OBELISKBLUETEAM;
;1664:	}
;1665:	else if (gametype == GT_HARVESTER) {
;1666:		if (BotTeam(bs) == TEAM_RED) context |= CONTEXT_HARVESTERREDTEAM;
;1667:		else context |= CONTEXT_HARVESTERBLUETEAM;
;1668:	}
;1669:#endif
;1670:	return context;
ADDRLP4 0
INDIRI4
RETI4
LABELV $295
endproc BotSynonymContext 8 4
export BotArmorIsUsefulForPlayer
proc BotArmorIsUsefulForPlayer 12 0
line 1678
;1671:}
;1672:
;1673:/*
;1674:==================
;1675:JUHOX: BotArmorIsUsefulForPlayer
;1676:==================
;1677:*/
;1678:qboolean BotArmorIsUsefulForPlayer(const playerState_t* ps) {
line 1679
;1679:	if (ps->stats[STAT_ARMOR] >= 2 * ps->stats[STAT_MAX_HEALTH]) return qfalse;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 1
LSHI4
LTI4 $301
CNSTI4 0
RETI4
ADDRGP4 $300
JUMPV
LABELV $301
line 1680
;1680:	return ps->stats[STAT_HEALTH] > ps->stats[STAT_ARMOR] * ((1 - ARMOR_PROTECTION) / ARMOR_PROTECTION);
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 8
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1057218808
MULF4
LEF4 $304
ADDRLP4 4
CNSTI4 1
ASGNI4
ADDRGP4 $305
JUMPV
LABELV $304
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $305
ADDRLP4 4
INDIRI4
RETI4
LABELV $300
endproc BotArmorIsUsefulForPlayer 12 0
export BotLimitedHealthIsUsefulForPlayer
proc BotLimitedHealthIsUsefulForPlayer 8 0
line 1688
;1681:}
;1682:
;1683:/*
;1684:==================
;1685:JUHOX: BotLimitedHealthIsUsefulForPlayer
;1686:==================
;1687:*/
;1688:qboolean BotLimitedHealthIsUsefulForPlayer(const playerState_t* ps) {
line 1689
;1689:	if (ps->powerups[PW_CHARGE]) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 352
ADDP4
INDIRI4
CNSTI4 0
EQI4 $307
CNSTI4 1
RETI4
ADDRGP4 $306
JUMPV
LABELV $307
line 1690
;1690:	return ps->stats[STAT_HEALTH] < ps->stats[STAT_MAX_HEALTH];
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
GEI4 $310
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $311
JUMPV
LABELV $310
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $311
ADDRLP4 0
INDIRI4
RETI4
LABELV $306
endproc BotLimitedHealthIsUsefulForPlayer 8 0
export BotUnlimitedHealthIsUsefulForPlayer
proc BotUnlimitedHealthIsUsefulForPlayer 12 0
line 1698
;1691:}
;1692:
;1693:/*
;1694:==================
;1695:JUHOX: BotUnlimitedHealthIsUsefulForPlayer
;1696:==================
;1697:*/
;1698:qboolean BotUnlimitedHealthIsUsefulForPlayer(const playerState_t* ps) {
line 1699
;1699:	if (ps->powerups[PW_CHARGE]) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 352
ADDP4
INDIRI4
CNSTI4 0
EQI4 $313
CNSTI4 1
RETI4
ADDRGP4 $312
JUMPV
LABELV $313
line 1700
;1700:	if (ps->powerups[PW_REGEN] && ps->stats[STAT_HEALTH] >= ps->stats[STAT_MAX_HEALTH]) return qfalse;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 332
ADDP4
INDIRI4
CNSTI4 0
EQI4 $315
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
LTI4 $315
CNSTI4 0
RETI4
ADDRGP4 $312
JUMPV
LABELV $315
line 1701
;1701:	return ps->stats[STAT_HEALTH] < 2 * ps->stats[STAT_MAX_HEALTH];
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 1
LSHI4
GEI4 $318
ADDRLP4 4
CNSTI4 1
ASGNI4
ADDRGP4 $319
JUMPV
LABELV $318
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $319
ADDRLP4 4
INDIRI4
RETI4
LABELV $312
endproc BotUnlimitedHealthIsUsefulForPlayer 12 0
export BotHoldableItemIsUsefulForPlayer
proc BotHoldableItemIsUsefulForPlayer 4 0
line 1709
;1702:}
;1703:
;1704:/*
;1705:==================
;1706:JUHOX: BotHoldableItemIsUsefulForPlayer
;1707:==================
;1708:*/
;1709:qboolean BotHoldableItemIsUsefulForPlayer(const playerState_t* ps) {
line 1710
;1710:	return ps->stats[STAT_HOLDABLE_ITEM]? qfalse : qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 0
EQI4 $322
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $323
JUMPV
LABELV $322
ADDRLP4 0
CNSTI4 1
ASGNI4
LABELV $323
ADDRLP4 0
INDIRI4
RETI4
LABELV $320
endproc BotHoldableItemIsUsefulForPlayer 4 0
export BotPlayerKillDamage
proc BotPlayerKillDamage 16 0
line 1720
;1711:}
;1712:
;1713:/*
;1714:==================
;1715:JUHOX: BotPlayerKillDamage
;1716:
;1717:returns the lowest damage that could kill the player
;1718:==================
;1719:*/
;1720:int BotPlayerKillDamage(const playerState_t* ps) {
line 1724
;1721:	int killDamage;
;1722:	float pf;	// protection factor
;1723:
;1724:	pf = (1 - ARMOR_PROTECTION) / ARMOR_PROTECTION;	// currently 0.5
ADDRLP4 4
CNSTF4 1057218808
ASGNF4
line 1725
;1725:	if (ps->stats[STAT_HEALTH] <= ps->stats[STAT_ARMOR] * pf) {
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 8
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRF4
MULF4
GTF4 $325
line 1726
;1726:		killDamage = ps->stats[STAT_HEALTH] / (1 - ARMOR_PROTECTION);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1077689404
MULF4
CVFI4 4
ASGNI4
line 1727
;1727:	}
ADDRGP4 $326
JUMPV
LABELV $325
line 1728
;1728:	else {
line 1730
;1729:		//killDamage = ps->stats[STAT_ARMOR] / ARMOR_PROTECTION + (ps->stats[STAT_HEALTH] - ps->stats[STAT_ARMOR] * pf);
;1730:		killDamage = ps->stats[STAT_HEALTH] + ps->stats[STAT_ARMOR];	// computes the same as the formula above!
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ADDI4
ASGNI4
line 1731
;1731:	}
LABELV $326
line 1732
;1732:	return killDamage;
ADDRLP4 0
INDIRI4
RETI4
LABELV $324
endproc BotPlayerKillDamage 16 0
export BotPlayerDanger
proc BotPlayerDanger 20 4
line 1751
;1733:}
;1734:
;1735:/*
;1736:==================
;1737:JUHOX: BotPlayerDanger
;1738:
;1739:danger <= -200	... unstoppable!
;1740:danger == -100	... 100/100
;1741:danger <= 0		... no danger
;1742:danger >= 11	... help would be nice, but not required
;1743:danger >= 25	... moderate danger
;1744:danger >= 75	... extreme danger
;1745:danger >= 200	... useless
;1746:NOTE:	This function takes information into account that a human player can't derive
;1747:		from his display. I justify this by assuming that an endangered player screams
;1748:		for help and tells the needed information.
;1749:==================
;1750:*/
;1751:int BotPlayerDanger(const playerState_t* ps) {
line 1755
;1752:	float maxDamage;
;1753:	float danger;
;1754:
;1755:	if (ps->stats[STAT_HEALTH] <= 0) return 0;	// a dead player is not in danger
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $328
CNSTI4 0
RETI4
ADDRGP4 $327
JUMPV
LABELV $328
line 1757
;1756:
;1757:	danger = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 1758
;1758:	maxDamage = BotPlayerKillDamage(ps);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BotPlayerKillDamage
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
CVIF4 4
ASGNF4
line 1759
;1759:	if (ps->powerups[PW_CHARGE]) {
ADDRFP4 0
INDIRP4
CNSTI4 352
ADDP4
INDIRI4
CNSTI4 0
EQI4 $330
line 1762
;1760:		float charge;
;1761:
;1762:		charge = ps->powerups[PW_CHARGE] / 1000.0F - FloatTime();
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 352
ADDP4
INDIRI4
CVIF4 4
CNSTF4 981668463
MULF4
ADDRGP4 floattime
INDIRF4
SUBF4
ASGNF4
line 1763
;1763:		if (charge > 0) {
ADDRLP4 12
INDIRF4
CNSTF4 0
LEF4 $332
line 1764
;1764:			maxDamage -= TotalChargeDamage(charge);
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 16
ADDRGP4 TotalChargeDamage
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 16
INDIRF4
SUBF4
ASGNF4
line 1765
;1765:		}
LABELV $332
line 1766
;1766:	}
LABELV $330
line 1767
;1767:	danger += 100 - (100 * maxDamage) / ps->stats[STAT_MAX_HEALTH];
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1120403456
ADDRLP4 4
INDIRF4
CNSTF4 1120403456
MULF4
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CVIF4 4
DIVF4
SUBF4
ADDF4
ASGNF4
line 1774
;1768:
;1769:	/*
;1770:	if (ps->eFlags & EF_FIRING) {
;1771:		danger += 10;
;1772:	}
;1773:	*/
;1774:	if (ps->powerups[PW_REDFLAG] || ps->powerups[PW_BLUEFLAG]) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
NEI4 $336
ADDRLP4 12
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
EQI4 $334
LABELV $336
line 1775
;1775:		danger += 50;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1112014848
ADDF4
ASGNF4
line 1776
;1776:		if (danger < 50) danger = 50;
ADDRLP4 0
INDIRF4
CNSTF4 1112014848
GEF4 $337
ADDRLP4 0
CNSTF4 1112014848
ASGNF4
LABELV $337
line 1777
;1777:	}
LABELV $334
line 1778
;1778:	if (ps->stats[STAT_STRENGTH] < LOW_STRENGTH_VALUE) {
ADDRFP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1161527296
GEF4 $339
line 1779
;1779:		danger += 20.0F * (1.0F - (float)ps->stats[STAT_STRENGTH] / LOW_STRENGTH_VALUE);
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
ADDRFP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CVIF4 4
CNSTF4 967754558
MULF4
SUBF4
CNSTF4 1101004800
MULF4
ADDF4
ASGNF4
line 1780
;1780:	}
LABELV $339
line 1781
;1781:	return (int) danger;
ADDRLP4 0
INDIRF4
CVFI4 4
RETI4
LABELV $327
endproc BotPlayerDanger 20 4
proc UpdateSplashCalculations 988 12
line 1791
;1782:}
;1783:
;1784:/*
;1785:==================
;1786:JUHOX: UpdateSplashCalculations
;1787:==================
;1788:*/
;1789:#define APPROX_SPLASH_RADIUS_BFG 400
;1790:#define MAX_SPLASH_RADIUS 500
;1791:static void UpdateSplashCalculations(bot_state_t* bs) {
line 1792
;1792:	if (bs->enemy < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 0
GEI4 $342
line 1793
;1793:		bs->splashCount_grenade = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7816
ADDP4
CNSTI4 0
ASGNI4
line 1794
;1794:		bs->splashCount_rocket = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7820
ADDP4
CNSTI4 0
ASGNI4
line 1795
;1795:		bs->splashCount_plasma = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7824
ADDP4
CNSTI4 0
ASGNI4
line 1796
;1796:		bs->splashCount_bfg = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7828
ADDP4
CNSTI4 0
ASGNI4
line 1797
;1797:		bs->splashCount_monster_launcher = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7832
ADDP4
CNSTI4 0
ASGNI4
line 1798
;1798:		bs->nextSplashCalculation_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7836
ADDP4
CNSTF4 0
ASGNF4
line 1799
;1799:		return;
ADDRGP4 $341
JUMPV
LABELV $342
line 1802
;1800:	}
;1801:
;1802:	if (bs->nextSplashCalculation_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 7836
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $344
line 1805
;1803:		playerState_t enemyPS;
;1804:
;1805:		bs->nextSplashCalculation_time = FloatTime() + 1 + 0.1 * random();
ADDRLP4 468
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRFP4 0
INDIRP4
CNSTI4 7836
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
ADDF4
ADDRLP4 468
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 468
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1036831949
MULF4
ADDF4
ASGNF4
line 1807
;1806:
;1807:		bs->splashCount_grenade = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7816
ADDP4
CNSTI4 0
ASGNI4
line 1808
;1808:		bs->splashCount_rocket = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7820
ADDP4
CNSTI4 0
ASGNI4
line 1809
;1809:		bs->splashCount_plasma = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7824
ADDP4
CNSTI4 0
ASGNI4
line 1810
;1810:		bs->splashCount_bfg = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7828
ADDP4
CNSTI4 0
ASGNI4
line 1811
;1811:		bs->splashCount_monster_launcher = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7832
ADDP4
CNSTI4 0
ASGNI4
line 1813
;1812:
;1813:		if (BotAI_GetClientState(bs->enemy, &enemyPS)) {
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 472
ADDRGP4 BotAI_GetClientState
CALLI4
ASGNI4
ADDRLP4 472
INDIRI4
CNSTI4 0
EQI4 $346
line 1817
;1814:			int player;
;1815:			playerState_t playerPS;
;1816:
;1817:			for (player = -1; (player = BotGetNextPlayerOrMonster(bs, player, &playerPS)) >= 0; ) {
ADDRLP4 476
CNSTI4 -1
ASGNI4
ADDRGP4 $351
JUMPV
LABELV $348
line 1820
;1818:				float distance;
;1819:
;1820:				if (player == bs->enemy) continue;
ADDRLP4 476
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
NEI4 $352
ADDRGP4 $349
JUMPV
LABELV $352
line 1822
;1821:
;1822:				distance = Distance(bs->origin, playerPS.origin);
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 480+20
ARGP4
ADDRLP4 952
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRLP4 948
ADDRLP4 952
INDIRF4
ASGNF4
line 1823
;1823:				if (distance > MAX_SPLASH_RADIUS) continue;
ADDRLP4 948
INDIRF4
CNSTF4 1140457472
LEF4 $355
ADDRGP4 $349
JUMPV
LABELV $355
line 1825
;1824:
;1825:				if (!BotEntityVisible(&bs->cur_ps, 90, player)) continue;
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTF4 1119092736
ARGF4
ADDRLP4 476
INDIRI4
ARGI4
ADDRLP4 956
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 956
INDIRF4
CNSTF4 0
NEF4 $357
ADDRGP4 $349
JUMPV
LABELV $357
line 1828
;1826:
;1827:				if (
;1828:					(
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $368
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ADDRLP4 480+248+12
INDIRI4
EQI4 $367
LABELV $368
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
GEI4 $359
ADDRGP4 g_monsterLauncher+12
INDIRI4
CNSTI4 0
EQI4 $359
ADDRLP4 960
ADDRGP4 g_entities
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRLP4 960
INDIRP4
ADDP4
ARGP4
ADDRLP4 480+140
INDIRI4
CNSTI4 844
MULI4
ADDRLP4 960
INDIRP4
ADDP4
ARGP4
ADDRLP4 964
ADDRGP4 G_IsFriendlyMonster
CALLI4
ASGNI4
ADDRLP4 964
INDIRI4
CNSTI4 0
EQI4 $359
LABELV $367
line 1840
;1829:						g_gametype.integer >= GT_TEAM &&
;1830:						bs->cur_ps.persistant[PERS_TEAM] == playerPS.persistant[PERS_TEAM]
;1831:					)
;1832:#if MONSTER_MODE
;1833:					||
;1834:					(
;1835:						g_gametype.integer < GT_STU &&
;1836:						g_monsterLauncher.integer &&
;1837:						G_IsFriendlyMonster(&g_entities[bs->client], &g_entities[playerPS.clientNum])
;1838:					)
;1839:#endif
;1840:				) {
line 1842
;1841:					// don't hit this player
;1842:					if (distance < SPLASH_RADIUS_GRENADE) bs->splashCount_grenade = -1;
ADDRLP4 948
INDIRF4
CNSTF4 1128792064
GEF4 $369
ADDRFP4 0
INDIRP4
CNSTI4 7816
ADDP4
CNSTI4 -1
ASGNI4
LABELV $369
line 1843
;1843:					if (distance < SPLASH_RADIUS_ROCKET) bs->splashCount_rocket = -1;
ADDRLP4 948
INDIRF4
CNSTF4 1123024896
GEF4 $371
ADDRFP4 0
INDIRP4
CNSTI4 7820
ADDP4
CNSTI4 -1
ASGNI4
LABELV $371
line 1844
;1844:					if (distance < SPLASH_RADIUS_PLASMA) bs->splashCount_plasma = -1;
ADDRLP4 948
INDIRF4
CNSTF4 1120403456
GEF4 $373
ADDRFP4 0
INDIRP4
CNSTI4 7824
ADDP4
CNSTI4 -1
ASGNI4
LABELV $373
line 1845
;1845:					if (distance < APPROX_SPLASH_RADIUS_BFG) bs->splashCount_bfg = -1;
ADDRLP4 948
INDIRF4
CNSTF4 1137180672
GEF4 $360
ADDRFP4 0
INDIRP4
CNSTI4 7828
ADDP4
CNSTI4 -1
ASGNI4
line 1846
;1846:				}
ADDRGP4 $360
JUMPV
LABELV $359
line 1847
;1847:				else {
line 1849
;1848:					// we should hit this player
;1849:					if (distance < SPLASH_RADIUS_GRENADE && bs->splashCount_grenade >= 0) bs->splashCount_grenade++;
ADDRLP4 948
INDIRF4
CNSTF4 1128792064
GEF4 $377
ADDRFP4 0
INDIRP4
CNSTI4 7816
ADDP4
INDIRI4
CNSTI4 0
LTI4 $377
ADDRLP4 968
ADDRFP4 0
INDIRP4
CNSTI4 7816
ADDP4
ASGNP4
ADDRLP4 968
INDIRP4
ADDRLP4 968
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $377
line 1850
;1850:					if (distance < SPLASH_RADIUS_ROCKET && bs->splashCount_rocket >= 0) bs->splashCount_rocket++;
ADDRLP4 948
INDIRF4
CNSTF4 1123024896
GEF4 $379
ADDRFP4 0
INDIRP4
CNSTI4 7820
ADDP4
INDIRI4
CNSTI4 0
LTI4 $379
ADDRLP4 972
ADDRFP4 0
INDIRP4
CNSTI4 7820
ADDP4
ASGNP4
ADDRLP4 972
INDIRP4
ADDRLP4 972
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $379
line 1851
;1851:					if (distance < SPLASH_RADIUS_PLASMA && bs->splashCount_plasma >= 0) bs->splashCount_plasma++;
ADDRLP4 948
INDIRF4
CNSTF4 1120403456
GEF4 $381
ADDRFP4 0
INDIRP4
CNSTI4 7824
ADDP4
INDIRI4
CNSTI4 0
LTI4 $381
ADDRLP4 976
ADDRFP4 0
INDIRP4
CNSTI4 7824
ADDP4
ASGNP4
ADDRLP4 976
INDIRP4
ADDRLP4 976
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $381
line 1852
;1852:					if (distance < APPROX_SPLASH_RADIUS_BFG && bs->splashCount_bfg >= 0) bs->splashCount_bfg++;
ADDRLP4 948
INDIRF4
CNSTF4 1137180672
GEF4 $383
ADDRFP4 0
INDIRP4
CNSTI4 7828
ADDP4
INDIRI4
CNSTI4 0
LTI4 $383
ADDRLP4 980
ADDRFP4 0
INDIRP4
CNSTI4 7828
ADDP4
ASGNP4
ADDRLP4 980
INDIRP4
ADDRLP4 980
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $383
line 1853
;1853:					if (distance < 500) bs->splashCount_monster_launcher++;
ADDRLP4 948
INDIRF4
CNSTF4 1140457472
GEF4 $385
ADDRLP4 984
ADDRFP4 0
INDIRP4
CNSTI4 7832
ADDP4
ASGNP4
ADDRLP4 984
INDIRP4
ADDRLP4 984
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $385
line 1854
;1854:				}
LABELV $360
line 1855
;1855:			}
LABELV $349
line 1817
LABELV $351
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 476
INDIRI4
ARGI4
ADDRLP4 480
ARGP4
ADDRLP4 948
ADDRGP4 BotGetNextPlayerOrMonster
CALLI4
ASGNI4
ADDRLP4 476
ADDRLP4 948
INDIRI4
ASGNI4
ADDRLP4 948
INDIRI4
CNSTI4 0
GEI4 $348
line 1856
;1856:		}
LABELV $346
line 1857
;1857:	}
LABELV $344
line 1858
;1858:}
LABELV $341
endproc UpdateSplashCalculations 988 12
proc BotGauntletValue 8 4
line 1880
;1859:
;1860:#if 1	// JUHOX: types used with weapon selection
;1861:typedef struct {
;1862:	int enemyWeapon;
;1863:	float distance;
;1864:	float verticalDistance;
;1865:	qboolean enemyOnGround;
;1866:	int enemyConstitution;
;1867:	qboolean wallTargetAvailable;
;1868:	qboolean mayCauseIdleNoise;
;1869:	qboolean chasedByEnemy;	// implies bot's escaping
;1870:	qboolean chasingEnemy;
;1871:	int danger;
;1872:} combatCharacteristics_t;
;1873:#endif
;1874:
;1875:/*
;1876:==================
;1877:JUHOX: BotGauntletValue
;1878:==================
;1879:*/
;1880:static float BotGauntletValue(bot_state_t* bs, const combatCharacteristics_t* cc) {
line 1883
;1881:	float value;
;1882:
;1883:	value = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 1887
;1884:
;1885:	// ammo
;1886:	#if WP_GAUNTLET_MAX_AMMO < 0
;1887:		value += 50.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1112014848
ADDF4
ASGNF4
line 1899
;1888:	#else
;1889:		if (g_unlimitedAmmo.integer) {
;1890:			value += 50.0;
;1891:		}
;1892:		else {
;1893:			value += 50.0 * bs->cur_ps.ammo[WP_GAUNTLET] / WP_GAUNTLET_MAX_AMMO;
;1894:			if (bs->cur_ps.ammo[WP_GAUNTLET] == 0) value -= 1000;
;1895:		}
;1896:	#endif
;1897:
;1898:	// distance
;1899:	if (cc->distance > 100.0) {
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1120403456
LEF4 $389
line 1900
;1900:		value += 50.0 * 100.0 / cc->distance;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1167867904
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
DIVF4
ADDF4
ASGNF4
line 1901
;1901:	}
ADDRGP4 $390
JUMPV
LABELV $389
line 1902
;1902:	else {
line 1903
;1903:		value += 50.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1112014848
ADDF4
ASGNF4
line 1904
;1904:	}
LABELV $390
line 1907
;1905:
;1906:	// special attributes
;1907:	if (bs->enemy >= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 0
LTI4 $391
line 1908
;1908:		if (cc->enemyWeapon == WP_GAUNTLET) {
ADDRFP4 4
INDIRP4
INDIRI4
CNSTI4 1
NEI4 $393
line 1909
;1909:			if (cc->chasedByEnemy || BotWantsToRetreat(bs)) {
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 0
NEI4 $397
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 BotWantsToRetreat
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $395
LABELV $397
line 1910
;1910:				value += 30.0;	// because enemy can't use Gauntlet's auto aim and speed up
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1106247680
ADDF4
ASGNF4
line 1911
;1911:			}
ADDRGP4 $392
JUMPV
LABELV $395
line 1912
;1912:			else if (cc->chasingEnemy) {
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $392
line 1913
;1913:				value -= 20.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1101004800
SUBF4
ASGNF4
line 1914
;1914:			}
line 1915
;1915:		}
ADDRGP4 $392
JUMPV
LABELV $393
line 1916
;1916:		else if (cc->enemyWeapon == WP_BFG) {
ADDRFP4 4
INDIRP4
INDIRI4
CNSTI4 9
NEI4 $392
line 1917
;1917:			if (!BotWantsToRetreat(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 BotWantsToRetreat
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $392
line 1918
;1918:				value += 10.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1092616192
ADDF4
ASGNF4
line 1919
;1919:			}
line 1920
;1920:		}
line 1921
;1921:	}
ADDRGP4 $392
JUMPV
LABELV $391
line 1922
;1922:	else if (cc->chasedByEnemy || BotWantsToRetreat(bs)) {
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 0
NEI4 $406
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 BotWantsToRetreat
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $404
LABELV $406
line 1923
;1923:		value -= 30.0;	// we wouldn't be able to attack the enemy
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1106247680
SUBF4
ASGNF4
line 1924
;1924:	}
LABELV $404
LABELV $392
line 1928
;1925:
;1926:	// prevent gauntlet become the only weapon
;1927:	if (
;1928:		g_weaponLimit.integer > 0 &&
ADDRGP4 g_weaponLimit+12
INDIRI4
CNSTI4 0
LEI4 $407
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 628
ADDP4
INDIRI4
CNSTI4 0
GTI4 $407
line 1930
;1929:		level.clients[bs->client].pers.numChoosenWeapons <= 0
;1930:	) {
line 1931
;1931:		value -= 1000;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1148846080
SUBF4
ASGNF4
line 1932
;1932:	}
LABELV $407
line 1935
;1933:
;1934:
;1935:	return value;
ADDRLP4 0
INDIRF4
RETF4
LABELV $388
endproc BotGauntletValue 8 4
proc BotMachineGunValue 8 0
line 1943
;1936:}
;1937:
;1938:/*
;1939:==================
;1940:JUHOX: BotMachineGunValue
;1941:==================
;1942:*/
;1943:static float BotMachineGunValue(bot_state_t* bs, const combatCharacteristics_t* cc) {
line 1946
;1944:	float value;
;1945:
;1946:	value = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 1952
;1947:
;1948:	// ammo
;1949:	#if WP_MACHINEGUN_MAX_AMMO < 0
;1950:		value += 50.0;
;1951:	#else
;1952:		if (g_unlimitedAmmo.integer) {
ADDRGP4 g_unlimitedAmmo+12
INDIRI4
CNSTI4 0
EQI4 $411
line 1953
;1953:			value += 50.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1112014848
ADDF4
ASGNF4
line 1954
;1954:		}
ADDRGP4 $412
JUMPV
LABELV $411
line 1955
;1955:		else {
line 1956
;1956:			value += 50.0 * bs->cur_ps.ammo[WP_MACHINEGUN] / WP_MACHINEGUN_MAX_AMMO;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1048576000
MULF4
ADDF4
ASGNF4
line 1957
;1957:			if (bs->cur_ps.ammo[WP_MACHINEGUN] == 0) value -= 1000;
ADDRFP4 0
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
CNSTI4 0
NEI4 $414
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1148846080
SUBF4
ASGNF4
LABELV $414
line 1958
;1958:		}
LABELV $412
line 1970
;1959:	#endif
;1960:
;1961:	// distance
;1962:	/* machine gun no longer spreads
;1963:	if (cc->distance > 500.0) {
;1964:		value += 50.0 * 500.0 / cc->distance;
;1965:	}
;1966:	else {
;1967:		value += 50.0;
;1968:	}
;1969:	*/
;1970:	value += 25.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1103626240
ADDF4
ASGNF4
line 1983
;1971:
;1972:	// "splash damage"
;1973:	/* machine gun no longer spreads
;1974:	if (bs->splashCount_rocket < 0) {
;1975:		value -= 15.0;
;1976:	}
;1977:	else {
;1978:		value += 10.0 * bs->splashCount_rocket;
;1979:	}
;1980:	*/
;1981:
;1982:	// special attributes
;1983:	if (bs->cur_ps.weapon != WP_MACHINEGUN || bs->cur_ps.weaponstate != WEAPON_FIRING) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 2
NEI4 $418
ADDRLP4 4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 3
EQI4 $416
LABELV $418
line 1984
;1984:		value -= 10.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1092616192
SUBF4
ASGNF4
line 1985
;1985:	}
LABELV $416
line 1986
;1986:	if (bs->enemy >= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 0
LTI4 $419
line 1987
;1987:		if (cc->enemyWeapon == WP_GAUNTLET) value += 10.0;
ADDRFP4 4
INDIRP4
INDIRI4
CNSTI4 1
NEI4 $421
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1092616192
ADDF4
ASGNF4
LABELV $421
line 1988
;1988:		if (cc->chasingEnemy) value -= 15.0;
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $423
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1097859072
SUBF4
ASGNF4
LABELV $423
line 1989
;1989:		if (cc->chasedByEnemy) value += 15.0;
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 0
EQI4 $425
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1097859072
ADDF4
ASGNF4
LABELV $425
line 1990
;1990:	}
LABELV $419
line 1992
;1991:
;1992:	return value;
ADDRLP4 0
INDIRF4
RETF4
LABELV $410
endproc BotMachineGunValue 8 0
proc BotShotgunValue 8 0
line 2000
;1993:}
;1994:
;1995:/*
;1996:==================
;1997:JUHOX: BotShotgunValue
;1998:==================
;1999:*/
;2000:static float BotShotgunValue(bot_state_t* bs, const combatCharacteristics_t* cc) {
line 2003
;2001:	float value;
;2002:
;2003:	value = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 2009
;2004:
;2005:	// ammo
;2006:	#if WP_SHOTGUN_MAX_AMMO < 0
;2007:		value += 50.0;
;2008:	#else
;2009:		if (g_unlimitedAmmo.integer) {
ADDRGP4 g_unlimitedAmmo+12
INDIRI4
CNSTI4 0
EQI4 $428
line 2010
;2010:			value += 50.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1112014848
ADDF4
ASGNF4
line 2011
;2011:		}
ADDRGP4 $429
JUMPV
LABELV $428
line 2012
;2012:		else {
line 2013
;2013:			value += 50.0 * bs->cur_ps.ammo[WP_SHOTGUN] / WP_SHOTGUN_MAX_AMMO;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 404
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 2014
;2014:			if (bs->cur_ps.ammo[WP_SHOTGUN] == 0) value -= 1000;
ADDRFP4 0
INDIRP4
CNSTI4 404
ADDP4
INDIRI4
CNSTI4 0
NEI4 $431
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1148846080
SUBF4
ASGNF4
LABELV $431
line 2015
;2015:		}
LABELV $429
line 2019
;2016:	#endif
;2017:
;2018:	// distance
;2019:	if (cc->distance > 150.0) {
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1125515264
LEF4 $433
line 2020
;2020:		value += 50.0 * 150.0 / cc->distance;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1172987904
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
DIVF4
ADDF4
ASGNF4
line 2021
;2021:	}
ADDRGP4 $434
JUMPV
LABELV $433
line 2022
;2022:	else {
line 2023
;2023:		value += 50.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1112014848
ADDF4
ASGNF4
line 2024
;2024:	}
LABELV $434
line 2027
;2025:
;2026:	// "splash damage" (weapon spreading)
;2027:	if (bs->splashCount_rocket < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 7820
ADDP4
INDIRI4
CNSTI4 0
GEI4 $435
line 2028
;2028:		value -= 10.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1092616192
SUBF4
ASGNF4
line 2029
;2029:	}
ADDRGP4 $436
JUMPV
LABELV $435
line 2030
;2030:	else {
line 2031
;2031:		value += 5.0 * bs->splashCount_rocket;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 7820
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1084227584
MULF4
ADDF4
ASGNF4
line 2032
;2032:	}
LABELV $436
line 2036
;2033:
;2034:	// special attributes
;2035:	if (
;2036:		bs->enemy >= 0 &&
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 0
LTI4 $437
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
NEI4 $437
ADDRLP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $437
line 2040
;2037:		cc->enemyWeapon == WP_GAUNTLET &&
;2038:		//!BotWantsToRetreat(bs)
;2039:		cc->chasingEnemy
;2040:	) {
line 2041
;2041:		value += 15.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1097859072
ADDF4
ASGNF4
line 2042
;2042:	}
LABELV $437
line 2044
;2043:
;2044:	return value;
ADDRLP4 0
INDIRF4
RETF4
LABELV $427
endproc BotShotgunValue 8 0
proc BotGrenadeLauncherValue 12 0
line 2052
;2045:}
;2046:
;2047:/*
;2048:==================
;2049:JUHOX: BotGrenadeLauncherValue
;2050:==================
;2051:*/
;2052:static float BotGrenadeLauncherValue(bot_state_t* bs, const combatCharacteristics_t* cc) {
line 2056
;2053:	float value;
;2054:	float bestDistance;
;2055:
;2056:	value = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 2062
;2057:
;2058:	// ammo
;2059:	#if WP_GRENADE_LAUNCHER_MAX_AMMO < 0
;2060:		value += 50.0;
;2061:	#else
;2062:		if (g_unlimitedAmmo.integer) {
ADDRGP4 g_unlimitedAmmo+12
INDIRI4
CNSTI4 0
EQI4 $440
line 2063
;2063:			value += 50.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1112014848
ADDF4
ASGNF4
line 2064
;2064:		}
ADDRGP4 $441
JUMPV
LABELV $440
line 2065
;2065:		else {
line 2066
;2066:			value += 50.0 * bs->cur_ps.ammo[WP_GRENADE_LAUNCHER] / WP_GRENADE_LAUNCHER_MAX_AMMO;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 408
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1056964608
MULF4
ADDF4
ASGNF4
line 2067
;2067:			if (bs->cur_ps.ammo[WP_GRENADE_LAUNCHER] == 0) value -= 1000;
ADDRFP4 0
INDIRP4
CNSTI4 408
ADDP4
INDIRI4
CNSTI4 0
NEI4 $443
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1148846080
SUBF4
ASGNF4
LABELV $443
line 2068
;2068:		}
LABELV $441
line 2072
;2069:	#endif
;2070:
;2071:	// distance
;2072:	bestDistance = 500.0 - cc->verticalDistance;
ADDRLP4 4
CNSTF4 1140457472
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2073
;2073:	if (bestDistance > SPLASH_RADIUS_GRENADE + 100.0) {
ADDRLP4 4
INDIRF4
CNSTF4 1133903872
LEF4 $445
line 2074
;2074:		if (cc->distance > bestDistance) {
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
LEF4 $447
line 2075
;2075:			value += 0.1 * bestDistance * (1.0 - (cc->distance - bestDistance) / (0.6 * bestDistance));
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 4
INDIRF4
CNSTF4 1036831949
MULF4
CNSTF4 1065353216
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ADDRLP4 4
INDIRF4
CNSTF4 1058642330
MULF4
DIVF4
SUBF4
MULF4
ADDF4
ASGNF4
line 2076
;2076:		}
ADDRGP4 $446
JUMPV
LABELV $447
line 2077
;2077:		else {
line 2078
;2078:			value += 0.1 * bestDistance * (1.0 + (cc->distance - bestDistance) / (bestDistance - SPLASH_RADIUS_GRENADE));
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 4
INDIRF4
CNSTF4 1036831949
MULF4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ADDRLP4 4
INDIRF4
CNSTF4 1128792064
SUBF4
DIVF4
CNSTF4 1065353216
ADDF4
MULF4
ADDF4
ASGNF4
line 2079
;2079:		}
line 2080
;2080:	}
ADDRGP4 $446
JUMPV
LABELV $445
line 2081
;2081:	else {
line 2082
;2082:		value -= 1000;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1148846080
SUBF4
ASGNF4
line 2083
;2083:	}
LABELV $446
line 2086
;2084:
;2085:	// splash damage
;2086:	if (bs->splashCount_grenade < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 7816
ADDP4
INDIRI4
CNSTI4 0
GEI4 $449
line 2087
;2087:		value -= 100.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1120403456
SUBF4
ASGNF4
line 2088
;2088:	}
ADDRGP4 $450
JUMPV
LABELV $449
line 2089
;2089:	else {
line 2090
;2090:		value += 20.0 * bs->splashCount_grenade;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 7816
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1101004800
MULF4
ADDF4
ASGNF4
line 2091
;2091:	}
LABELV $450
line 2092
;2092:	if (bs->splashCount_bfg < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 7828
ADDP4
INDIRI4
CNSTI4 0
GEI4 $451
line 2093
;2093:		value -= 50.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1112014848
SUBF4
ASGNF4
line 2094
;2094:	}
ADDRGP4 $452
JUMPV
LABELV $451
line 2095
;2095:	else {
line 2096
;2096:		value += 10.0 * bs->splashCount_bfg;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 7828
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1092616192
MULF4
ADDF4
ASGNF4
line 2097
;2097:	}
LABELV $452
line 2100
;2098:
;2099:	// special attributes
;2100:	if (bs->enemy >= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 0
LTI4 $453
line 2101
;2101:		if (cc->enemyWeapon == WP_PLASMAGUN) value -= 15;
ADDRFP4 4
INDIRP4
INDIRI4
CNSTI4 8
NEI4 $455
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1097859072
SUBF4
ASGNF4
LABELV $455
line 2102
;2102:		if (cc->chasedByEnemy) value += 15;
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 0
EQI4 $457
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1097859072
ADDF4
ASGNF4
LABELV $457
line 2103
;2103:		if (cc->chasingEnemy) value -= 20;
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $459
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1101004800
SUBF4
ASGNF4
LABELV $459
line 2104
;2104:	}
LABELV $453
line 2108
;2105:
;2106:	// prevent grenade launcher become the only weapon
;2107:	if (
;2108:		g_weaponLimit.integer > 0 &&
ADDRGP4 g_weaponLimit+12
INDIRI4
CNSTI4 0
LEI4 $461
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 628
ADDP4
INDIRI4
CNSTI4 0
GTI4 $461
line 2110
;2109:		level.clients[bs->client].pers.numChoosenWeapons <= 0
;2110:	) {
line 2111
;2111:		value -= 1000;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1148846080
SUBF4
ASGNF4
line 2112
;2112:	}
LABELV $461
line 2114
;2113:
;2114:	return value;
ADDRLP4 0
INDIRF4
RETF4
LABELV $439
endproc BotGrenadeLauncherValue 12 0
proc BotRocketLauncherValue 12 0
line 2122
;2115:}
;2116:
;2117:/*
;2118:==================
;2119:JUHOX: BotRocketLauncherValue
;2120:==================
;2121:*/
;2122:static float BotRocketLauncherValue(bot_state_t* bs, const combatCharacteristics_t* cc) {
line 2124
;2123:	float value;
;2124:	const float minDistance = 2.5 * SPLASH_RADIUS_ROCKET;
ADDRLP4 4
CNSTF4 1133903872
ASGNF4
line 2126
;2125:
;2126:	value = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 2132
;2127:
;2128:	// ammo
;2129:	#if WP_ROCKET_LAUNCHER_MAX_AMMO < 0
;2130:		value += 50.0;
;2131:	#else
;2132:		if (g_unlimitedAmmo.integer) {
ADDRGP4 g_unlimitedAmmo+12
INDIRI4
CNSTI4 0
EQI4 $465
line 2133
;2133:			value += 50.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1112014848
ADDF4
ASGNF4
line 2134
;2134:		}
ADDRGP4 $466
JUMPV
LABELV $465
line 2135
;2135:		else {
line 2136
;2136:			value += 50.0 * bs->cur_ps.ammo[WP_ROCKET_LAUNCHER] / WP_ROCKET_LAUNCHER_MAX_AMMO;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 412
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1067450368
MULF4
ADDF4
ASGNF4
line 2137
;2137:			if (bs->cur_ps.ammo[WP_ROCKET_LAUNCHER] == 0) value -= 1000;
ADDRFP4 0
INDIRP4
CNSTI4 412
ADDP4
INDIRI4
CNSTI4 0
NEI4 $468
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1148846080
SUBF4
ASGNF4
LABELV $468
line 2138
;2138:		}
LABELV $466
line 2142
;2139:	#endif
;2140:
;2141:	// distance
;2142:	if (cc->distance > minDistance) {
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
LEF4 $470
line 2143
;2143:		value += 50.0 * minDistance / cc->distance;		
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 4
INDIRF4
CNSTF4 1112014848
MULF4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
DIVF4
ADDF4
ASGNF4
line 2144
;2144:	}
ADDRGP4 $471
JUMPV
LABELV $470
line 2145
;2145:	else {
line 2146
;2146:		value += 50.0 * (1.0 + (cc->distance - minDistance) / (minDistance - SPLASH_RADIUS_ROCKET));
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ADDRLP4 4
INDIRF4
CNSTF4 1123024896
SUBF4
DIVF4
CNSTF4 1065353216
ADDF4
CNSTF4 1112014848
MULF4
ADDF4
ASGNF4
line 2147
;2147:	}
LABELV $471
line 2150
;2148:
;2149:	// splash damage
;2150:	if (bs->splashCount_rocket < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 7820
ADDP4
INDIRI4
CNSTI4 0
GEI4 $472
line 2151
;2151:		value -= 100.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1120403456
SUBF4
ASGNF4
line 2152
;2152:	}
ADDRGP4 $473
JUMPV
LABELV $472
line 2153
;2153:	else {
line 2154
;2154:		value += 30.0 * bs->splashCount_rocket;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 7820
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1106247680
MULF4
ADDF4
ASGNF4
line 2155
;2155:	}
LABELV $473
line 2158
;2156:
;2157:	// wall target
;2158:	if (!cc->wallTargetAvailable) value -= cc->distance / 20.0;
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 0
NEI4 $474
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1028443341
MULF4
SUBF4
ASGNF4
LABELV $474
line 2161
;2159:
;2160:	// special attributes
;2161:	if (bs->enemy >= 0 && cc->chasedByEnemy) value += 20.0;
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 0
LTI4 $476
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 0
EQI4 $476
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1101004800
ADDF4
ASGNF4
LABELV $476
line 2163
;2162:
;2163:	return value;
ADDRLP4 0
INDIRF4
RETF4
LABELV $464
endproc BotRocketLauncherValue 12 0
proc BotLightningGunValue 12 0
line 2171
;2164:}
;2165:
;2166:/*
;2167:==================
;2168:JUHOX: BotLightningGunValue
;2169:==================
;2170:*/
;2171:static float BotLightningGunValue(bot_state_t* bs, const combatCharacteristics_t* cc) {
line 2173
;2172:	float value;
;2173:	const float bestDistance = 0.65 * LIGHTNING_RANGE;
ADDRLP4 4
CNSTF4 1134723072
ASGNF4
line 2175
;2174:
;2175:	value = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 2181
;2176:
;2177:	// ammo
;2178:	#if WP_LIGHTNING_MAX_AMMO < 0
;2179:		value += 50.0;
;2180:	#else
;2181:		if (g_unlimitedAmmo.integer) {
ADDRGP4 g_unlimitedAmmo+12
INDIRI4
CNSTI4 0
EQI4 $479
line 2182
;2182:			value += 50.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1112014848
ADDF4
ASGNF4
line 2183
;2183:		}
ADDRGP4 $480
JUMPV
LABELV $479
line 2184
;2184:		else {
line 2185
;2185:			value += 50.0 * bs->cur_ps.ammo[WP_LIGHTNING] / WP_LIGHTNING_MAX_AMMO;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1031798784
MULF4
ADDF4
ASGNF4
line 2186
;2186:			if (bs->cur_ps.ammo[WP_LIGHTNING] == 0) value -= 1000;
ADDRFP4 0
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
CNSTI4 0
NEI4 $482
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1148846080
SUBF4
ASGNF4
LABELV $482
line 2187
;2187:		}
LABELV $480
line 2191
;2188:	#endif
;2189:
;2190:	// distance
;2191:	if (cc->distance > bestDistance) {
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
LEF4 $484
line 2192
;2192:		value += 50.0 * (1.0 - (cc->distance - bestDistance) / (LIGHTNING_RANGE - bestDistance));
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
CNSTF4 1140457472
ADDRLP4 4
INDIRF4
SUBF4
DIVF4
SUBF4
CNSTF4 1112014848
MULF4
ADDF4
ASGNF4
line 2193
;2193:	}
ADDRGP4 $485
JUMPV
LABELV $484
line 2194
;2194:	else {
line 2195
;2195:		value += 50.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1112014848
ADDF4
ASGNF4
line 2196
;2196:	}
LABELV $485
line 2199
;2197:
;2198:	// "splash damage"
;2199:	if (bs->splashCount_rocket < 0 && cc->distance > 150) {
ADDRFP4 0
INDIRP4
CNSTI4 7820
ADDP4
INDIRI4
CNSTI4 0
GEI4 $486
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1125515264
LEF4 $486
line 2200
;2200:		value -= cc->distance / 10.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1036831949
MULF4
SUBF4
ASGNF4
line 2201
;2201:	}
LABELV $486
line 2202
;2202:	if (bs->splashCount_rocket > 1) {
ADDRFP4 0
INDIRP4
CNSTI4 7820
ADDP4
INDIRI4
CNSTI4 1
LEI4 $488
line 2203
;2203:		value -= 5.0 * bs->splashCount_rocket;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 7820
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1084227584
MULF4
SUBF4
ASGNF4
line 2204
;2204:	}
LABELV $488
line 2205
;2205:	if (bs->splashCount_bfg > 1) {
ADDRFP4 0
INDIRP4
CNSTI4 7828
ADDP4
INDIRI4
CNSTI4 1
LEI4 $490
line 2206
;2206:		value -= 3.0 * bs->splashCount_bfg;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 7828
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1077936128
MULF4
SUBF4
ASGNF4
line 2207
;2207:	}
LABELV $490
line 2210
;2208:
;2209:	// idle noise
;2210:	if (!cc->mayCauseIdleNoise) value -= 50.0;
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 0
NEI4 $492
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1112014848
SUBF4
ASGNF4
LABELV $492
line 2213
;2211:
;2212:	// special attributes
;2213:	if (bs->enemy >= 0 && cc->enemyWeapon == WP_LIGHTNING) value += 10.0;
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 0
LTI4 $494
ADDRFP4 4
INDIRP4
INDIRI4
CNSTI4 6
NEI4 $494
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1092616192
ADDF4
ASGNF4
LABELV $494
line 2214
;2214:	value += 0.2 * cc->danger;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1045220557
MULF4
ADDF4
ASGNF4
line 2215
;2215:	if (g_entities[bs->client].waterlevel > 1) value -= 100000;
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+792
ADDP4
INDIRI4
CNSTI4 1
LEI4 $496
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1203982336
SUBF4
ASGNF4
LABELV $496
line 2216
;2216:	if (g_lightningDamageLimit.value > 0) {
ADDRGP4 g_lightningDamageLimit+8
INDIRF4
CNSTF4 0
LEF4 $499
line 2217
;2217:		value -= 300.0 / g_lightningDamageLimit.value;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1133903872
ADDRGP4 g_lightningDamageLimit+8
INDIRF4
DIVF4
SUBF4
ASGNF4
line 2218
;2218:	}
LABELV $499
line 2220
;2219:
;2220:	return value;
ADDRLP4 0
INDIRF4
RETF4
LABELV $478
endproc BotLightningGunValue 12 0
proc BotRailgunValue 8 0
line 2228
;2221:}
;2222:
;2223:/*
;2224:==================
;2225:JUHOX: BotRailgunValue
;2226:==================
;2227:*/
;2228:static float BotRailgunValue(bot_state_t* bs, const combatCharacteristics_t* cc) {
line 2231
;2229:	float value;
;2230:
;2231:	value = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 2237
;2232:
;2233:	// ammo
;2234:	#if WP_RAILGUN_MAX_AMMO < 0
;2235:		value += 50.0;
;2236:	#else
;2237:		if (g_unlimitedAmmo.integer) {
ADDRGP4 g_unlimitedAmmo+12
INDIRI4
CNSTI4 0
EQI4 $504
line 2238
;2238:			value += 50.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1112014848
ADDF4
ASGNF4
line 2239
;2239:		}
ADDRGP4 $505
JUMPV
LABELV $504
line 2240
;2240:		else {
line 2241
;2241:			value += 50.0 * bs->cur_ps.ammo[WP_RAILGUN] / WP_RAILGUN_MAX_AMMO;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 420
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1090868565
MULF4
ADDF4
ASGNF4
line 2242
;2242:			if (bs->cur_ps.ammo[WP_RAILGUN] == 0) value -= 1000;
ADDRFP4 0
INDIRP4
CNSTI4 420
ADDP4
INDIRI4
CNSTI4 0
NEI4 $507
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1148846080
SUBF4
ASGNF4
LABELV $507
line 2243
;2243:		}
LABELV $505
line 2247
;2244:	#endif
;2245:
;2246:	// distance
;2247:	value += 50.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1112014848
ADDF4
ASGNF4
line 2250
;2248:
;2249:	// idle noise
;2250:	if (!cc->mayCauseIdleNoise) value -= 50.0;
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 0
NEI4 $509
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1112014848
SUBF4
ASGNF4
LABELV $509
line 2253
;2251:
;2252:	// special attributes
;2253:	if (cc->enemyConstitution < 120) value -= 30.0;
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 120
GEI4 $511
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1106247680
SUBF4
ASGNF4
LABELV $511
line 2255
;2254:	if (
;2255:		bs->enemy >= 0 &&
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 0
LTI4 $513
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
NEI4 $513
ADDRLP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $513
line 2258
;2256:		cc->enemyWeapon == WP_GAUNTLET &&
;2257:		cc->chasingEnemy
;2258:	) {
line 2259
;2259:		value += 20.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1101004800
ADDF4
ASGNF4
line 2260
;2260:	}
LABELV $513
line 2261
;2261:	if (bs->splashCount_bfg > 1) value -= 10.0 * bs->splashCount_bfg;	// these enemies might attack us while railgun is reloading
ADDRFP4 0
INDIRP4
CNSTI4 7828
ADDP4
INDIRI4
CNSTI4 1
LEI4 $515
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 7828
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1092616192
MULF4
SUBF4
ASGNF4
LABELV $515
line 2263
;2262:
;2263:	return value;
ADDRLP4 0
INDIRF4
RETF4
LABELV $503
endproc BotRailgunValue 8 0
proc BotPlasmagunValue 12 0
line 2271
;2264:}
;2265:
;2266:/*
;2267:==================
;2268:JUHOX: BotPlasmagunValue
;2269:==================
;2270:*/
;2271:static float BotPlasmagunValue(bot_state_t* bs, const combatCharacteristics_t* cc) {
line 2273
;2272:	float value;
;2273:	const float minDistance = 2.0 * SPLASH_RADIUS_PLASMA;
ADDRLP4 4
CNSTF4 1128792064
ASGNF4
line 2275
;2274:
;2275:	value = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 2281
;2276:
;2277:	// ammo
;2278:	#if WP_PLASMAGUN_MAX_AMMO < 0
;2279:		value += 50.0;
;2280:	#else
;2281:		if (g_unlimitedAmmo.integer) {
ADDRGP4 g_unlimitedAmmo+12
INDIRI4
CNSTI4 0
EQI4 $518
line 2282
;2282:			value += 50.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1112014848
ADDF4
ASGNF4
line 2283
;2283:		}
ADDRGP4 $519
JUMPV
LABELV $518
line 2284
;2284:		else {
line 2285
;2285:			value += 50.0 * bs->cur_ps.ammo[WP_PLASMAGUN] / WP_PLASMAGUN_MAX_AMMO;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1040187392
MULF4
ADDF4
ASGNF4
line 2286
;2286:			if (bs->cur_ps.ammo[WP_PLASMAGUN] == 0) value -= 1000;
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 0
NEI4 $521
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1148846080
SUBF4
ASGNF4
LABELV $521
line 2287
;2287:		}
LABELV $519
line 2291
;2288:	#endif
;2289:
;2290:	// distance
;2291:	if (cc->distance > 500.0) {
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1140457472
LEF4 $523
line 2292
;2292:		value += 50.0 * 500.0 / cc->distance;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1187205120
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
DIVF4
ADDF4
ASGNF4
line 2293
;2293:	}
ADDRGP4 $524
JUMPV
LABELV $523
line 2294
;2294:	else if (cc->distance >= minDistance) {
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
LTF4 $525
line 2295
;2295:		value += 50.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1112014848
ADDF4
ASGNF4
line 2296
;2296:	}
ADDRGP4 $526
JUMPV
LABELV $525
line 2297
;2297:	else {
line 2298
;2298:		value += 50.0 * (1.0 + (cc->distance - minDistance) / (minDistance - SPLASH_RADIUS_PLASMA));
ADDRLP4 8
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
SUBF4
ADDRLP4 8
INDIRF4
CNSTF4 1120403456
SUBF4
DIVF4
CNSTF4 1065353216
ADDF4
CNSTF4 1112014848
MULF4
ADDF4
ASGNF4
line 2299
;2299:	}
LABELV $526
LABELV $524
line 2302
;2300:
;2301:	// splash damage
;2302:	if (bs->splashCount_plasma < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 7824
ADDP4
INDIRI4
CNSTI4 0
GEI4 $527
line 2303
;2303:		value -= 50.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1112014848
SUBF4
ASGNF4
line 2304
;2304:	}
ADDRGP4 $528
JUMPV
LABELV $527
line 2305
;2305:	else {
line 2306
;2306:		value += 10.0 * bs->splashCount_plasma;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 7824
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1092616192
MULF4
ADDF4
ASGNF4
line 2307
;2307:	}
LABELV $528
line 2310
;2308:
;2309:	// wall target
;2310:	if (!cc->wallTargetAvailable) value -= cc->distance / 40.0;
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 0
NEI4 $529
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1020054733
MULF4
SUBF4
ASGNF4
LABELV $529
line 2313
;2311:
;2312:	// special attributes
;2313:	if (bs->enemy >= 0 && cc->enemyWeapon == WP_GRENADE_LAUNCHER) value += 25.0;
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 0
LTI4 $531
ADDRFP4 4
INDIRP4
INDIRI4
CNSTI4 4
NEI4 $531
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1103626240
ADDF4
ASGNF4
LABELV $531
line 2315
;2314:
;2315:	return value;
ADDRLP4 0
INDIRF4
RETF4
LABELV $517
endproc BotPlasmagunValue 12 0
proc BotBFGValue 12 0
line 2323
;2316:}
;2317:
;2318:/*
;2319:==================
;2320:JUHOX: BotBFGValue
;2321:==================
;2322:*/
;2323:static float BotBFGValue(bot_state_t* bs, const combatCharacteristics_t* cc) {
line 2325
;2324:	float value;
;2325:	const float minDistance = 1.5 * APPROX_SPLASH_RADIUS_BFG;
ADDRLP4 4
CNSTF4 1142292480
ASGNF4
line 2327
;2326:
;2327:	value = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 2333
;2328:
;2329:	// ammo
;2330:	#if WP_BFG_MAX_AMMO < 0
;2331:		value += 50.0;
;2332:	#else
;2333:		if (g_unlimitedAmmo.integer) {
ADDRGP4 g_unlimitedAmmo+12
INDIRI4
CNSTI4 0
EQI4 $534
line 2334
;2334:			value += 50.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1112014848
ADDF4
ASGNF4
line 2335
;2335:		}
ADDRGP4 $535
JUMPV
LABELV $534
line 2336
;2336:		else {
line 2337
;2337:			value += 50.0 * bs->cur_ps.ammo[WP_BFG] / WP_BFG_MAX_AMMO;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1092616192
MULF4
ADDF4
ASGNF4
line 2338
;2338:			if (bs->cur_ps.ammo[WP_BFG] == 0) value -= 1000;
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
INDIRI4
CNSTI4 0
NEI4 $537
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1148846080
SUBF4
ASGNF4
LABELV $537
line 2339
;2339:		}
LABELV $535
line 2343
;2340:	#endif
;2341:
;2342:	// distance
;2343:	if (cc->distance > minDistance) {
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
LEF4 $539
line 2344
;2344:		value += 50.0 * minDistance / cc->distance;		
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 4
INDIRF4
CNSTF4 1112014848
MULF4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
DIVF4
ADDF4
ASGNF4
line 2345
;2345:	}
ADDRGP4 $540
JUMPV
LABELV $539
line 2346
;2346:	else {
line 2347
;2347:		value += 50.0 * (1.0 + (cc->distance - minDistance) / (minDistance - APPROX_SPLASH_RADIUS_BFG));
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ADDRLP4 4
INDIRF4
CNSTF4 1137180672
SUBF4
DIVF4
CNSTF4 1065353216
ADDF4
CNSTF4 1112014848
MULF4
ADDF4
ASGNF4
line 2348
;2348:	}
LABELV $540
line 2351
;2349:
;2350:	// splash
;2351:	if (bs->splashCount_bfg < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 7828
ADDP4
INDIRI4
CNSTI4 0
GEI4 $541
line 2352
;2352:		value -= 100.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1120403456
SUBF4
ASGNF4
line 2353
;2353:	}
ADDRGP4 $542
JUMPV
LABELV $541
line 2354
;2354:	else {
line 2355
;2355:		value += 20.0 * bs->splashCount_bfg;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 7828
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1101004800
MULF4
ADDF4
ASGNF4
line 2356
;2356:	}
LABELV $542
line 2359
;2357:
;2358:	// wall target
;2359:	if (!cc->wallTargetAvailable) value -= cc->distance / 5.0;
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 0
NEI4 $543
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1045220557
MULF4
SUBF4
ASGNF4
LABELV $543
line 2362
;2360:
;2361:	// idle noise
;2362:	if (!cc->mayCauseIdleNoise) value -= 50.0;
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 0
NEI4 $545
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1112014848
SUBF4
ASGNF4
LABELV $545
line 2365
;2363:
;2364:	// special attributes
;2365:	if (cc->enemyConstitution < 150) value -= 30.0;
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 150
GEI4 $547
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1106247680
SUBF4
ASGNF4
LABELV $547
line 2367
;2366:
;2367:	return value;
ADDRLP4 0
INDIRF4
RETF4
LABELV $533
endproc BotBFGValue 12 0
proc BotMonsterLauncherValue 20 0
line 2376
;2368:}
;2369:
;2370:/*
;2371:==================
;2372:JUHOX: BotMonsterLauncherValue
;2373:==================
;2374:*/
;2375:#if MONSTER_MODE
;2376:static float BotMonsterLauncherValue(bot_state_t* bs, const combatCharacteristics_t* cc) {
line 2378
;2377:	float value;
;2378:	const float bestDistance = 500.0;
ADDRLP4 4
CNSTF4 1140457472
ASGNF4
line 2379
;2379:	const float maxDistance = 1200.0;
ADDRLP4 8
CNSTF4 1150681088
ASGNF4
line 2381
;2380:
;2381:	value = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 2384
;2382:
;2383:	// ammo
;2384:	value += 50.0 * bs->cur_ps.ammo[WP_MONSTER_LAUNCHER] / level.maxMonstersPerPlayer;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1112014848
MULF4
ADDRGP4 level+22992
INDIRI4
CVIF4 4
DIVF4
ADDF4
ASGNF4
line 2385
;2385:	if (bs->cur_ps.ammo[WP_MONSTER_LAUNCHER] == 0) value -= 1000;
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRI4
CNSTI4 0
NEI4 $551
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1148846080
SUBF4
ASGNF4
LABELV $551
line 2388
;2386:
;2387:	// distance
;2388:	if (cc->distance > bestDistance) {
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
LEF4 $553
line 2389
;2389:		value += 50.0 * (1.0 - (cc->distance - bestDistance) / (maxDistance - bestDistance));
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ADDRLP4 8
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
DIVF4
SUBF4
CNSTF4 1112014848
MULF4
ADDF4
ASGNF4
line 2390
;2390:	}
ADDRGP4 $554
JUMPV
LABELV $553
line 2391
;2391:	else {
line 2392
;2392:		value += 50.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1112014848
ADDF4
ASGNF4
line 2393
;2393:	}
LABELV $554
line 2396
;2394:
;2395:	// "splash damage"
;2396:	value += 5.0 * bs->splashCount_monster_launcher;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 7832
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1084227584
MULF4
ADDF4
ASGNF4
line 2399
;2397:
;2398:	// special attributes
;2399:	value += 0.2 * g_monsterHealthScale.integer;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRGP4 g_monsterHealthScale+12
INDIRI4
CVIF4 4
CNSTF4 1045220557
MULF4
ADDF4
ASGNF4
line 2400
;2400:	value += 0.25 * cc->danger;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1048576000
MULF4
ADDF4
ASGNF4
line 2401
;2401:	if (bs->cur_ps.powerups[PW_CHARGE]) {
ADDRFP4 0
INDIRP4
CNSTI4 368
ADDP4
INDIRI4
CNSTI4 0
EQI4 $556
line 2402
;2402:		value += 0.01 * (bs->cur_ps.powerups[PW_CHARGE] - level.time);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 368
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
SUBI4
CVIF4 4
CNSTF4 1008981770
MULF4
ADDF4
ASGNF4
line 2403
;2403:	}
LABELV $556
line 2404
;2404:	if (bs->enemy >= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 0
LTI4 $559
line 2405
;2405:		if (cc->chasedByEnemy) value += 20.0;
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 0
EQI4 $561
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1101004800
ADDF4
ASGNF4
LABELV $561
line 2406
;2406:		if (cc->chasingEnemy) value -= 15.0;
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $563
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1097859072
SUBF4
ASGNF4
LABELV $563
line 2407
;2407:		if (cc->enemyWeapon == WP_BFG) value += 10.0;
ADDRFP4 4
INDIRP4
INDIRI4
CNSTI4 9
NEI4 $565
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1092616192
ADDF4
ASGNF4
LABELV $565
line 2408
;2408:		if (bs->enemy < MAX_CLIENTS) {
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 64
GEI4 $567
line 2410
;2409:			if (
;2410:				level.clients[bs->enemy].ps.powerups[PW_REDFLAG] ||
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
ADDRGP4 level
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 5604
MULI4
ADDRLP4 16
INDIRP4
ADDP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
NEI4 $571
ADDRLP4 12
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 5604
MULI4
ADDRLP4 16
INDIRP4
ADDP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
EQI4 $569
LABELV $571
line 2412
;2411:				level.clients[bs->enemy].ps.powerups[PW_BLUEFLAG]
;2412:			) {
line 2413
;2413:				value -= 10.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1092616192
SUBF4
ASGNF4
line 2414
;2414:			}
LABELV $569
line 2415
;2415:		}
LABELV $567
line 2416
;2416:	}
LABELV $559
line 2420
;2417:
;2418:	// prevent monster launcher become the only weapon
;2419:	if (
;2420:		g_weaponLimit.integer > 0 &&
ADDRGP4 g_weaponLimit+12
INDIRI4
CNSTI4 0
LEI4 $572
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 628
ADDP4
INDIRI4
CNSTI4 0
GTI4 $572
line 2422
;2421:		level.clients[bs->client].pers.numChoosenWeapons <= 0
;2422:	) {
line 2423
;2423:		value -= 1000;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1148846080
SUBF4
ASGNF4
line 2424
;2424:	}
LABELV $572
line 2426
;2425:
;2426:	return value;
ADDRLP4 0
INDIRF4
RETF4
LABELV $549
endproc BotMonsterLauncherValue 20 0
proc BotWeaponValue 48 8
line 2435
;2427:}
;2428:#endif
;2429:
;2430:/*
;2431:==================
;2432:JUHOX: BotWeaponValue
;2433:==================
;2434:*/
;2435:static float BotWeaponValue(bot_state_t* bs, const combatCharacteristics_t* cc, int weapon) {
line 2438
;2436:	float value;
;2437:
;2438:	value = -1000000;
ADDRLP4 0
CNSTF4 3379831808
ASGNF4
line 2440
;2439:
;2440:	if (bs->cur_ps.stats[STAT_WEAPONS] & (1 << weapon)) {
ADDRFP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 1
ADDRFP4 8
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $576
line 2441
;2441:		switch (weapon) {
ADDRLP4 4
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 1
LTI4 $578
ADDRLP4 4
INDIRI4
CNSTI4 11
GTI4 $578
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $590-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $590
address $580
address $581
address $582
address $583
address $584
address $585
address $586
address $587
address $588
address $578
address $589
code
LABELV $580
line 2443
;2442:		case WP_GAUNTLET:
;2443:			value = BotGauntletValue(bs, cc);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BotGauntletValue
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
ASGNF4
line 2444
;2444:			break;
ADDRGP4 $579
JUMPV
LABELV $581
line 2446
;2445:		case WP_MACHINEGUN:
;2446:			value = BotMachineGunValue(bs, cc);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 BotMachineGunValue
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ASGNF4
line 2447
;2447:			break;
ADDRGP4 $579
JUMPV
LABELV $582
line 2449
;2448:		case WP_SHOTGUN:
;2449:			value = BotShotgunValue(bs, cc);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 BotShotgunValue
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 2450
;2450:			break;
ADDRGP4 $579
JUMPV
LABELV $583
line 2452
;2451:		case WP_GRENADE_LAUNCHER:
;2452:			value = BotGrenadeLauncherValue(bs, cc);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 BotGrenadeLauncherValue
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 20
INDIRF4
ASGNF4
line 2453
;2453:			break;
ADDRGP4 $579
JUMPV
LABELV $584
line 2455
;2454:		case WP_ROCKET_LAUNCHER:
;2455:			value = BotRocketLauncherValue(bs, cc);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 BotRocketLauncherValue
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 24
INDIRF4
ASGNF4
line 2456
;2456:			break;
ADDRGP4 $579
JUMPV
LABELV $585
line 2458
;2457:		case WP_LIGHTNING:
;2458:			value = BotLightningGunValue(bs, cc);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 BotLightningGunValue
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 28
INDIRF4
ASGNF4
line 2459
;2459:			break;
ADDRGP4 $579
JUMPV
LABELV $586
line 2461
;2460:		case WP_RAILGUN:
;2461:			value = BotRailgunValue(bs, cc);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 BotRailgunValue
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 32
INDIRF4
ASGNF4
line 2462
;2462:			break;
ADDRGP4 $579
JUMPV
LABELV $587
line 2464
;2463:		case WP_PLASMAGUN:
;2464:			value = BotPlasmagunValue(bs, cc);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 BotPlasmagunValue
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 36
INDIRF4
ASGNF4
line 2465
;2465:			break;
ADDRGP4 $579
JUMPV
LABELV $588
line 2467
;2466:		case WP_BFG:
;2467:			value = BotBFGValue(bs, cc);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 BotBFGValue
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 40
INDIRF4
ASGNF4
line 2468
;2468:			break;
ADDRGP4 $579
JUMPV
LABELV $589
line 2471
;2469:#if MONSTER_MODE
;2470:		case WP_MONSTER_LAUNCHER:
;2471:			value = BotMonsterLauncherValue(bs, cc);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 BotMonsterLauncherValue
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 44
INDIRF4
ASGNF4
line 2472
;2472:			break;
LABELV $578
LABELV $579
line 2475
;2473:#endif
;2474:		}
;2475:		if (bs->cur_ps.weapon == weapon) value += 30.0;
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ADDRFP4 8
INDIRI4
NEI4 $592
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1106247680
ADDF4
ASGNF4
LABELV $592
line 2476
;2476:	}
LABELV $576
line 2477
;2477:	return value;
ADDRLP4 0
INDIRF4
RETF4
LABELV $575
endproc BotWeaponValue 48 8
proc BotGetCombatCharacteristics 92 8
line 2485
;2478:}
;2479:
;2480:/*
;2481:==================
;2482:JUHOX: BotGetCombatCharacteristics
;2483:==================
;2484:*/
;2485:static void BotGetCombatCharacteristics(bot_state_t* bs, combatCharacteristics_t* cc) {
line 2486
;2486:	if (bs->enemy >= 0 && bs->enemy < MAX_GENTITIES) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 0
LTI4 $595
ADDRLP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 1024
GEI4 $595
line 2490
;2487:		gentity_t* enemy;
;2488:		playerState_t* ps;
;2489:
;2490:		enemy = &g_entities[bs->enemy];
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 2491
;2491:		ps = G_GetEntityPlayerState(enemy);
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 12
INDIRP4
ASGNP4
line 2492
;2492:		if (!ps) goto NoEnemy;
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $597
ADDRGP4 $599
JUMPV
LABELV $597
line 2494
;2493:
;2494:		cc->enemyWeapon = ps->weapon;
ADDRFP4 4
INDIRP4
ADDRLP4 4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ASGNI4
line 2495
;2495:		cc->distance = Distance(ps->origin, bs->origin);
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 16
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 16
INDIRF4
ASGNF4
line 2496
;2496:		cc->verticalDistance = ps->origin[2] - bs->origin[2];
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2497
;2497:		cc->enemyOnGround = ps->groundEntityNum != ENTITYNUM_NONE;
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1023
EQI4 $601
ADDRLP4 20
CNSTI4 1
ASGNI4
ADDRGP4 $602
JUMPV
LABELV $601
ADDRLP4 20
CNSTI4 0
ASGNI4
LABELV $602
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
line 2498
;2498:		cc->enemyConstitution = G_Constitution(enemy);
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 G_Constitution
CALLI4
ASGNI4
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 24
INDIRI4
ASGNI4
line 2499
;2499:		cc->mayCauseIdleNoise = qtrue;
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
CNSTI4 1
ASGNI4
line 2500
;2500:		cc->wallTargetAvailable = bs->walltarget_time > FloatTime() - 0.75;
ADDRFP4 0
INDIRP4
CNSTI4 7412
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1061158912
SUBF4
LEF4 $604
ADDRLP4 28
CNSTI4 1
ASGNI4
ADDRGP4 $605
JUMPV
LABELV $604
ADDRLP4 28
CNSTI4 0
ASGNI4
LABELV $605
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 2502
;2501:		
;2502:		cc->chasedByEnemy = qfalse;
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
CNSTI4 0
ASGNI4
line 2503
;2503:		cc->chasingEnemy = qfalse;
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
CNSTI4 0
ASGNI4
line 2504
;2504:		{
line 2508
;2505:			vec3_t vel;
;2506:			float speed;
;2507:
;2508:			speed = VectorNormalize2(bs->cur_ps.velocity, vel);
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRLP4 32
ARGP4
ADDRLP4 48
ADDRGP4 VectorNormalize2
CALLF4
ASGNF4
ADDRLP4 44
ADDRLP4 48
INDIRF4
ASGNF4
line 2509
;2509:			if (speed > 100) {
ADDRLP4 44
INDIRF4
CNSTF4 1120403456
LEF4 $596
line 2513
;2510:				vec3_t dir;
;2511:				float d;
;2512:
;2513:				VectorSubtract(ps->origin, bs->origin, dir);
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 72
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 52+4
ADDRLP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 72
INDIRP4
CNSTI4 4920
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 52+8
ADDRLP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2514
;2514:				VectorNormalize(dir);
ADDRLP4 52
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 2515
;2515:				d = DotProduct(vel, dir);
ADDRLP4 64
ADDRLP4 32
INDIRF4
ADDRLP4 52
INDIRF4
MULF4
ADDRLP4 32+4
INDIRF4
ADDRLP4 52+4
INDIRF4
MULF4
ADDF4
ADDRLP4 32+8
INDIRF4
ADDRLP4 52+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 2516
;2516:				if (d > 0.707) {	// 0.707 = cos(45°)
ADDRLP4 64
INDIRF4
CNSTF4 1060437492
LEF4 $614
line 2517
;2517:					cc->chasingEnemy = qtrue;
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
CNSTI4 1
ASGNI4
line 2518
;2518:				}
ADDRGP4 $596
JUMPV
LABELV $614
line 2519
;2519:				else if (d < -0.707) {
ADDRLP4 64
INDIRF4
CNSTF4 3207921140
GEF4 $596
line 2524
;2520:					vec3_t enemyVel;
;2521:
;2522:					// we try to escape
;2523:					// see if enemy is chasing us
;2524:					VectorNormalize2(ps->velocity, enemyVel);
ADDRLP4 4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 76
ARGP4
ADDRGP4 VectorNormalize2
CALLF4
pop
line 2525
;2525:					if (DotProduct(ps->velocity, dir) < -0.707) {	// consider orientation of 'dir'
ADDRLP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 52
INDIRF4
MULF4
ADDRLP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 52+4
INDIRF4
MULF4
ADDF4
ADDRLP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 52+8
INDIRF4
MULF4
ADDF4
CNSTF4 3207921140
GEF4 $596
line 2526
;2526:						cc->chasedByEnemy = qtrue;
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
CNSTI4 1
ASGNI4
line 2527
;2527:					}
line 2528
;2528:				}
line 2529
;2529:			}
line 2530
;2530:		}
line 2531
;2531:	}
ADDRGP4 $596
JUMPV
LABELV $595
line 2532
;2532:	else {
LABELV $599
line 2534
;2533:		NoEnemy:
;2534:		cc->enemyWeapon = WP_ROCKET_LAUNCHER;
ADDRFP4 4
INDIRP4
CNSTI4 5
ASGNI4
line 2535
;2535:		cc->distance = 500.0;
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 1140457472
ASGNF4
line 2536
;2536:		cc->verticalDistance = 0;
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 0
ASGNF4
line 2537
;2537:		cc->enemyOnGround = qtrue;
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 1
ASGNI4
line 2538
;2538:		cc->enemyConstitution = g_baseHealth.integer;
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 g_baseHealth+12
INDIRI4
ASGNI4
line 2539
;2539:		cc->mayCauseIdleNoise = bs->enemyvisible_time >= FloatTime() - 5;
ADDRFP4 0
INDIRP4
CNSTI4 7180
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
SUBF4
LTF4 $624
ADDRLP4 4
CNSTI4 1
ASGNI4
ADDRGP4 $625
JUMPV
LABELV $624
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $625
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 2540
;2540:		cc->wallTargetAvailable = qtrue;
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
CNSTI4 1
ASGNI4
line 2541
;2541:		cc->chasedByEnemy = qfalse;
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
CNSTI4 0
ASGNI4
line 2542
;2542:		cc->chasingEnemy = qfalse;
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
CNSTI4 0
ASGNI4
line 2543
;2543:	}
LABELV $596
line 2544
;2544:	cc->danger = BotPlayerDanger(&bs->cur_ps);
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 BotPlayerDanger
CALLI4
ASGNI4
ADDRFP4 4
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 2545
;2545:}
LABELV $594
endproc BotGetCombatCharacteristics 92 8
proc BotGoodWeapon 112 12
line 2552
;2546:
;2547:/*
;2548:==================
;2549:JUHOX: BotGoodWeapon
;2550:==================
;2551:*/
;2552:static int BotGoodWeapon(bot_state_t* bs) {
line 2560
;2553:	combatCharacteristics_t cc;
;2554:	float values[WP_NUM_WEAPONS];
;2555:	float bestValue;
;2556:	int weapon;
;2557:	int goodWeapon;
;2558:	int numGoodWeapons;
;2559:
;2560:	UpdateSplashCalculations(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 UpdateSplashCalculations
CALLV
pop
line 2561
;2561:	BotGetCombatCharacteristics(bs, &cc);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
ARGP4
ADDRGP4 BotGetCombatCharacteristics
CALLV
pop
line 2563
;2562:
;2563:	bestValue = -100000;
ADDRLP4 4
CNSTF4 3351465984
ASGNF4
line 2565
;2564:
;2565:	for (weapon = 0; weapon < WP_NUM_WEAPONS; weapon++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $627
line 2568
;2566:		float value;
;2567:
;2568:		value = BotWeaponValue(bs, &cc, weapon);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 108
ADDRGP4 BotWeaponValue
CALLF4
ASGNF4
ADDRLP4 104
ADDRLP4 108
INDIRF4
ASGNF4
line 2570
;2569:
;2570:		if (value > bestValue) bestValue = value;
ADDRLP4 104
INDIRF4
ADDRLP4 4
INDIRF4
LEF4 $631
ADDRLP4 4
ADDRLP4 104
INDIRF4
ASGNF4
LABELV $631
line 2572
;2571:		
;2572:		values[weapon] = value;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
ADDRLP4 104
INDIRF4
ASGNF4
line 2573
;2573:	}
LABELV $628
line 2565
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 12
LTI4 $627
line 2575
;2574:
;2575:	goodWeapon = -1;
ADDRLP4 100
CNSTI4 -1
ASGNI4
line 2576
;2576:	numGoodWeapons = 0;
ADDRLP4 96
CNSTI4 0
ASGNI4
line 2577
;2577:	for (weapon = 0; weapon < WP_NUM_WEAPONS; weapon++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $633
line 2580
;2578:		float value;
;2579:
;2580:		value = values[weapon];
ADDRLP4 104
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
INDIRF4
ASGNF4
line 2581
;2581:		if (value > bestValue - 10) {
ADDRLP4 104
INDIRF4
ADDRLP4 4
INDIRF4
CNSTF4 1092616192
SUBF4
LEF4 $637
line 2582
;2582:			numGoodWeapons++;
ADDRLP4 96
ADDRLP4 96
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2583
;2583:			if (rand() % numGoodWeapons == 0) {
ADDRLP4 108
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 108
INDIRI4
ADDRLP4 96
INDIRI4
MODI4
CNSTI4 0
NEI4 $639
line 2584
;2584:				goodWeapon = weapon;
ADDRLP4 100
ADDRLP4 0
INDIRI4
ASGNI4
line 2585
;2585:			}
LABELV $639
line 2586
;2586:		}
LABELV $637
line 2587
;2587:	}
LABELV $634
line 2577
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 12
LTI4 $633
line 2589
;2588:
;2589:	return goodWeapon;
ADDRLP4 100
INDIRI4
RETI4
LABELV $626
endproc BotGoodWeapon 112 12
export BotChooseWeapon
proc BotChooseWeapon 28 8
line 2597
;2590:}
;2591:
;2592:/*
;2593:==================
;2594:BotChooseWeapon
;2595:==================
;2596:*/
;2597:void BotChooseWeapon(bot_state_t *bs) {
line 2600
;2598:	int newweaponnum;
;2599:
;2600:	if (bs->cur_ps.stats[STAT_HEALTH] <= 0) return;	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
CNSTI4 0
GTI4 $642
ADDRGP4 $641
JUMPV
LABELV $642
line 2601
;2601:	if (bs->cur_ps.weaponstate == WEAPON_RAISING ||
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 1
EQI4 $646
ADDRLP4 4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 2
NEI4 $644
LABELV $646
line 2602
;2602:			bs->cur_ps.weaponstate == WEAPON_DROPPING) {
line 2603
;2603:		if (bs->weaponnum == WP_NONE) return;	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 7804
ADDP4
INDIRI4
CNSTI4 0
NEI4 $647
ADDRGP4 $641
JUMPV
LABELV $647
line 2604
;2604:		trap_EA_SelectWeapon(bs->client, bs->weaponnum);
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 7804
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_SelectWeapon
CALLV
pop
line 2605
;2605:	}
ADDRGP4 $645
JUMPV
LABELV $644
line 2606
;2606:	else {
line 2610
;2607:#if 0	// JUHOX: enhanced weapon selection logic
;2608:		newweaponnum = trap_BotChooseBestFightWeapon(bs->ws, bs->inventory);
;2609:#else
;2610:		if (bs->railgunJump_ordertime > 0) {
ADDRFP4 0
INDIRP4
CNSTI4 7728
ADDP4
INDIRF4
CNSTF4 0
LEF4 $649
line 2611
;2611:			newweaponnum = WP_RAILGUN;
ADDRLP4 0
CNSTI4 7
ASGNI4
line 2612
;2612:			bs->weaponProposal = newweaponnum;
ADDRFP4 0
INDIRP4
CNSTI4 7808
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 2613
;2613:			bs->weaponProposal_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7812
ADDP4
CNSTF4 0
ASGNF4
line 2614
;2614:			goto SelectWeapon;
ADDRGP4 $651
JUMPV
LABELV $649
line 2617
;2615:		}
;2616:
;2617:		if (bs->weaponchoose_time > FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 7304
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $652
line 2618
;2618:			newweaponnum = bs->weaponProposal;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 7808
ADDP4
INDIRI4
ASGNI4
line 2619
;2619:			if (newweaponnum <= WP_NONE) return;
ADDRLP4 0
INDIRI4
CNSTI4 0
GTI4 $651
ADDRGP4 $641
JUMPV
line 2620
;2620:			goto SelectWeapon;
LABELV $652
line 2623
;2621:		}
;2622:
;2623:		bs->weaponchoose_time = FloatTime() + 0.5 + 0.5 * random();
ADDRLP4 8
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRFP4 0
INDIRP4
CNSTI4 7304
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1056964608
ADDF4
ADDRLP4 8
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 8
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1056964608
MULF4
ADDF4
ASGNF4
line 2625
;2624:
;2625:		newweaponnum = BotGoodWeapon(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 BotGoodWeapon
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 2626
;2626:		if (newweaponnum == WP_NONE) return;	// should only happen for spectators
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $656
ADDRGP4 $641
JUMPV
LABELV $656
line 2627
;2627:		if (bs->cur_ps.ammo[bs->weaponnum] <= 0) {
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 7804
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
INDIRP4
CNSTI4 392
ADDP4
ADDP4
INDIRI4
CNSTI4 0
GTI4 $658
line 2628
;2628:			bs->weaponProposal = newweaponnum;
ADDRFP4 0
INDIRP4
CNSTI4 7808
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 2629
;2629:			bs->weaponProposal_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7812
ADDP4
CNSTF4 0
ASGNF4
line 2630
;2630:		}
LABELV $658
LABELV $651
line 2633
;2631:
;2632:		SelectWeapon:
;2633:		if (bs->weaponProposal != newweaponnum) {
ADDRFP4 0
INDIRP4
CNSTI4 7808
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
EQI4 $660
line 2634
;2634:			bs->weaponProposal = newweaponnum;
ADDRFP4 0
INDIRP4
CNSTI4 7808
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 2635
;2635:			bs->weaponProposal_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7812
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2636
;2636:			return;
ADDRGP4 $641
JUMPV
LABELV $660
line 2638
;2637:		}
;2638:		if (bs->weaponProposal_time > FloatTime() - 2 * /*BotReactionTime(bs)*/bs->reactiontime) {
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 7812
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
CNSTF4 1073741824
MULF4
SUBF4
LEF4 $662
line 2639
;2639:			return;
ADDRGP4 $641
JUMPV
LABELV $662
line 2641
;2640:		}
;2641:		newweaponnum = bs->weaponProposal;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 7808
ADDP4
INDIRI4
ASGNI4
line 2643
;2642:#endif
;2643:		if (bs->weaponnum != newweaponnum) bs->weaponchange_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7804
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
EQI4 $664
ADDRFP4 0
INDIRP4
CNSTI4 7300
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
LABELV $664
line 2644
;2644:		bs->weaponnum = newweaponnum;
ADDRFP4 0
INDIRP4
CNSTI4 7804
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 2646
;2645:		//BotAI_Print(PRT_MESSAGE, "bs->weaponnum = %d\n", bs->weaponnum);
;2646:		trap_EA_SelectWeapon(bs->client, bs->weaponnum);
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
INDIRP4
CNSTI4 7804
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_SelectWeapon
CALLV
pop
line 2647
;2647:	}
LABELV $645
line 2648
;2648:}
LABELV $641
endproc BotChooseWeapon 28 8
export LTGNearlyFulfilled
proc LTGNearlyFulfilled 572 12
line 2655
;2649:
;2650:/*
;2651:==================
;2652:JUHOX: LTGNearlyFulfilled
;2653:==================
;2654:*/
;2655:qboolean LTGNearlyFulfilled(bot_state_t* bs) {
line 2662
;2656:	playerState_t ps;
;2657:	int danger, strength;
;2658:
;2659:#if !MONSTER_MODE
;2660:	if (bs->getImportantNBGItem) return qfalse;
;2661:#else
;2662:	if (g_gametype.integer != GT_STU && bs->getImportantNBGItem) return qfalse;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
EQI4 $667
ADDRFP4 0
INDIRP4
CNSTI4 7736
ADDP4
INDIRI4
CNSTI4 0
EQI4 $667
CNSTI4 0
RETI4
ADDRGP4 $666
JUMPV
LABELV $667
line 2665
;2663:#endif
;2664:	if (
;2665:		bs->enemy >= 0 &&
ADDRLP4 476
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 476
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 0
LTI4 $670
ADDRLP4 476
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 480
ADDRGP4 BotPlayerDanger
CALLI4
ASGNI4
ADDRLP4 480
INDIRI4
CNSTI4 0
LEI4 $670
line 2670
;2666:		(
;2667:			//!g_stamina.integer ||
;2668:			BotPlayerDanger(&bs->cur_ps) > 0
;2669:		)
;2670:	) return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $666
JUMPV
LABELV $670
line 2671
;2671:	switch (bs->ltgtype) {
ADDRLP4 484
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
ASGNI4
ADDRLP4 484
INDIRI4
CNSTI4 0
LTI4 $672
ADDRLP4 484
INDIRI4
CNSTI4 17
GTI4 $672
ADDRLP4 484
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $746
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $746
address $675
address $687
address $672
address $672
address $728
address $731
address $734
address $686
address $686
address $672
address $672
address $672
address $672
address $672
address $672
address $672
address $723
address $686
code
LABELV $675
LABELV $672
line 2675
;2672:		case 0:
;2673:		default:
;2674:#if MONSTER_MODE
;2675:			if (g_gametype.integer == GT_STU) return qtrue;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
NEI4 $676
CNSTI4 1
RETI4
ADDRGP4 $666
JUMPV
LABELV $676
line 2677
;2676:#endif
;2677:			if (!g_stamina.integer) return qfalse;
ADDRGP4 g_stamina+12
INDIRI4
CNSTI4 0
NEI4 $679
CNSTI4 0
RETI4
ADDRGP4 $666
JUMPV
LABELV $679
line 2678
;2678:			if (bs->cur_ps.stats[STAT_STRENGTH] < 2*LOW_STRENGTH_VALUE) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1169915904
GEF4 $682
CNSTI4 1
RETI4
ADDRGP4 $666
JUMPV
LABELV $682
line 2679
;2679:			if (BotWantsToRetreat(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 492
ADDRGP4 BotWantsToRetreat
CALLI4
ASGNI4
ADDRLP4 492
INDIRI4
CNSTI4 0
EQI4 $684
CNSTI4 0
RETI4
ADDRGP4 $666
JUMPV
LABELV $684
line 2680
;2680:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $666
JUMPV
LABELV $686
line 2684
;2681:		case LTG_CAMP:
;2682:		case LTG_CAMPORDER:
;2683:		case LTG_WAIT:
;2684:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $666
JUMPV
LABELV $687
line 2686
;2685:		case LTG_TEAMHELP:
;2686:			if (!BotAI_GetClientState(bs->teammate, &ps)) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 11560
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 496
ADDRGP4 BotAI_GetClientState
CALLI4
ASGNI4
ADDRLP4 496
INDIRI4
CNSTI4 0
NEI4 $688
CNSTI4 1
RETI4
ADDRGP4 $666
JUMPV
LABELV $688
line 2687
;2687:			if (ps.stats[STAT_HEALTH] <= 0) return qtrue;
ADDRLP4 0+184
INDIRI4
CNSTI4 0
GTI4 $690
CNSTI4 1
RETI4
ADDRGP4 $666
JUMPV
LABELV $690
line 2689
;2688:#if BOTS_USE_TSS
;2689:			if (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_isValid)) {
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 500
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 500
INDIRI4
CNSTI4 0
EQI4 $693
line 2690
;2690:				if (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_groupFormation) == TSSGF_tight) {
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTI4 6
ARGI4
ADDRLP4 504
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 504
INDIRI4
CNSTI4 0
NEI4 $695
line 2691
;2691:					if (VectorLengthSquared(ps.velocity) > 250*250) return qfalse;
ADDRLP4 0+32
ARGP4
ADDRLP4 508
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 508
INDIRF4
CNSTF4 1198793728
LEF4 $697
CNSTI4 0
RETI4
ADDRGP4 $666
JUMPV
LABELV $697
line 2692
;2692:					return DistanceSquared(ps.origin, bs->origin) < 300*300;
ADDRLP4 0+20
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 516
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 516
INDIRF4
CNSTF4 1202702336
GEF4 $702
ADDRLP4 512
CNSTI4 1
ASGNI4
ADDRGP4 $703
JUMPV
LABELV $702
ADDRLP4 512
CNSTI4 0
ASGNI4
LABELV $703
ADDRLP4 512
INDIRI4
RETI4
ADDRGP4 $666
JUMPV
LABELV $695
line 2694
;2693:				}
;2694:			}
LABELV $693
line 2696
;2695:#endif
;2696:			strength = bs->cur_ps.stats[STAT_STRENGTH];
ADDRLP4 472
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ASGNI4
line 2697
;2697:			danger = BotPlayerDanger(&ps);
ADDRLP4 0
ARGP4
ADDRLP4 504
ADDRGP4 BotPlayerDanger
CALLI4
ASGNI4
ADDRLP4 468
ADDRLP4 504
INDIRI4
ASGNI4
line 2698
;2698:			if (danger > 25) {
ADDRLP4 468
INDIRI4
CNSTI4 25
LEI4 $704
line 2699
;2699:				if (danger > 75) danger = 75;
ADDRLP4 468
INDIRI4
CNSTI4 75
LEI4 $706
ADDRLP4 468
CNSTI4 75
ASGNI4
LABELV $706
line 2700
;2700:				return strength < (0.4 + 0.6 * (1 - danger/75.0)) * MAX_STRENGTH_VALUE;
ADDRLP4 472
INDIRI4
CVIF4 4
CNSTF4 1065353216
ADDRLP4 468
INDIRI4
CVIF4 4
CNSTF4 1012560910
MULF4
SUBF4
CNSTF4 1058642330
MULF4
CNSTF4 1053609165
ADDF4
CNSTF4 1183621120
MULF4
GEF4 $709
ADDRLP4 508
CNSTI4 1
ASGNI4
ADDRGP4 $710
JUMPV
LABELV $709
ADDRLP4 508
CNSTI4 0
ASGNI4
LABELV $710
ADDRLP4 508
INDIRI4
RETI4
ADDRGP4 $666
JUMPV
LABELV $704
line 2702
;2701:			}
;2702:			if (strength < 0.8 * MAX_STRENGTH_VALUE) return qtrue;
ADDRLP4 472
INDIRI4
CVIF4 4
CNSTF4 1180762112
GEF4 $711
CNSTI4 1
RETI4
ADDRGP4 $666
JUMPV
LABELV $711
line 2704
;2703:			if (
;2704:				VectorLengthSquared(ps.velocity) > Square(250) &&
ADDRLP4 0+32
ARGP4
ADDRLP4 508
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 508
INDIRF4
CNSTF4 1198793728
LEF4 $713
ADDRLP4 0+68
INDIRI4
CNSTI4 1023
EQI4 $713
line 2706
;2705:				ps.groundEntityNum != ENTITYNUM_NONE
;2706:			) {
line 2707
;2707:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $666
JUMPV
LABELV $713
line 2710
;2708:			}
;2709:#if MONSTER_MODE
;2710:			if (g_gametype.integer == GT_STU) return qtrue;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
NEI4 $717
CNSTI4 1
RETI4
ADDRGP4 $666
JUMPV
LABELV $717
line 2712
;2711:#endif
;2712:			if (DistanceSquared(ps.origin, bs->origin) > Square(600)) return qfalse;
ADDRLP4 0+20
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 512
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 512
INDIRF4
CNSTF4 1219479552
LEF4 $720
CNSTI4 0
RETI4
ADDRGP4 $666
JUMPV
LABELV $720
line 2713
;2713:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $666
JUMPV
LABELV $723
line 2715
;2714:		case LTG_ESCAPE:
;2715:			if (bs->cur_ps.stats[STAT_STRENGTH] < LOW_STRENGTH_VALUE) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1161527296
GEF4 $724
CNSTI4 1
RETI4
ADDRGP4 $666
JUMPV
LABELV $724
line 2716
;2716:			if (BotWantsToRetreat(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 516
ADDRGP4 BotWantsToRetreat
CALLI4
ASGNI4
ADDRLP4 516
INDIRI4
CNSTI4 0
EQI4 $726
CNSTI4 0
RETI4
ADDRGP4 $666
JUMPV
LABELV $726
line 2717
;2717:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $666
JUMPV
LABELV $728
line 2719
;2718:		case LTG_GETFLAG:
;2719:			if (BotOwnFlagStatus(bs) != FLAG_ATBASE) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 520
ADDRGP4 BotOwnFlagStatus
CALLI4
ASGNI4
ADDRLP4 520
INDIRI4
CNSTI4 0
EQI4 $729
CNSTI4 0
RETI4
ADDRGP4 $666
JUMPV
LABELV $729
line 2720
;2720:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $666
JUMPV
LABELV $731
line 2722
;2721:		case LTG_RUSHBASE:
;2722:			if (BotOwnFlagStatus(bs) == FLAG_ATBASE) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 524
ADDRGP4 BotOwnFlagStatus
CALLI4
ASGNI4
ADDRLP4 524
INDIRI4
CNSTI4 0
NEI4 $732
CNSTI4 0
RETI4
ADDRGP4 $666
JUMPV
LABELV $732
line 2723
;2723:			return NearHomeBase(bs->cur_ps.persistant[PERS_TEAM], bs->origin, 9);
ADDRLP4 528
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 528
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ARGI4
ADDRLP4 528
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
CNSTF4 1091567616
ARGF4
ADDRLP4 532
ADDRGP4 NearHomeBase
CALLI4
ASGNI4
ADDRLP4 532
INDIRI4
RETI4
ADDRGP4 $666
JUMPV
LABELV $734
line 2726
;2724:		case LTG_RETURNFLAG:
;2725:			if (
;2726:				BotEnemyFlagStatus(bs) == FLAG_TAKEN &&
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 536
ADDRGP4 BotEnemyFlagStatus
CALLI4
ASGNI4
ADDRLP4 536
INDIRI4
CNSTI4 1
NEI4 $735
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ARGI4
ADDRLP4 540
ADDRGP4 OtherTeam
CALLI4
ASGNI4
ADDRLP4 540
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
CNSTF4 1073741824
ARGF4
ADDRLP4 544
ADDRGP4 NearHomeBase
CALLI4
ASGNI4
ADDRLP4 544
INDIRI4
CNSTI4 0
EQI4 $735
line 2728
;2727:				NearHomeBase(OtherTeam(bs->cur_ps.persistant[PERS_TEAM]), bs->origin, 2)
;2728:			) {
line 2729
;2729:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $666
JUMPV
LABELV $735
line 2731
;2730:			}
;2731:			switch (bs->cur_ps.persistant[PERS_TEAM]) {
ADDRLP4 548
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ASGNI4
ADDRLP4 548
INDIRI4
CNSTI4 1
EQI4 $740
ADDRLP4 548
INDIRI4
CNSTI4 2
EQI4 $743
ADDRGP4 $737
JUMPV
LABELV $740
line 2734
;2732:			case TEAM_RED:
;2733:				if (
;2734:					DistanceSquared(bs->origin, ctf_blueflag.origin) <
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
ADDRLP4 556
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 11580
ADDP4
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
ADDRLP4 560
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 556
INDIRF4
ADDRLP4 560
INDIRF4
GEF4 $738
line 2736
;2735:					DistanceSquared(bs->teamgoal.origin, ctf_blueflag.origin)
;2736:				) {
line 2737
;2737:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $666
JUMPV
line 2739
;2738:				}
;2739:				break;
LABELV $743
line 2742
;2740:			case TEAM_BLUE:
;2741:				if (
;2742:					DistanceSquared(bs->origin, ctf_redflag.origin) <
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRGP4 ctf_redflag
ARGP4
ADDRLP4 564
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 11580
ADDP4
ARGP4
ADDRGP4 ctf_redflag
ARGP4
ADDRLP4 568
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 564
INDIRF4
ADDRLP4 568
INDIRF4
GEF4 $738
line 2744
;2743:					DistanceSquared(bs->teamgoal.origin, ctf_redflag.origin)
;2744:				) {
line 2745
;2745:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $666
JUMPV
line 2747
;2746:				}
;2747:				break;
LABELV $737
line 2749
;2748:			default:
;2749:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $666
JUMPV
LABELV $738
line 2751
;2750:			}
;2751:			return qfalse;
CNSTI4 0
RETI4
LABELV $666
endproc LTGNearlyFulfilled 572 12
export BotSetupForMovement
proc BotSetupForMovement 96 12
line 2760
;2752:	}
;2753:}
;2754:
;2755:/*
;2756:==================
;2757:BotSetupForMovement
;2758:==================
;2759:*/
;2760:void BotSetupForMovement(bot_state_t *bs) {
line 2763
;2761:	bot_initmove_t initmove;
;2762:
;2763:	memset(&initmove, 0, sizeof(bot_initmove_t));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 68
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2764
;2764:	VectorCopy(bs->cur_ps.origin, initmove.origin);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRB
ASGNB 12
line 2765
;2765:	VectorCopy(bs->cur_ps.velocity, initmove.velocity);
ADDRLP4 0+12
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRB
ASGNB 12
line 2766
;2766:	VectorClear(initmove.viewoffset);
ADDRLP4 68
CNSTF4 0
ASGNF4
ADDRLP4 0+24+8
ADDRLP4 68
INDIRF4
ASGNF4
ADDRLP4 0+24+4
ADDRLP4 68
INDIRF4
ASGNF4
ADDRLP4 0+24
ADDRLP4 68
INDIRF4
ASGNF4
line 2767
;2767:	initmove.viewoffset[2] += bs->cur_ps.viewheight;
ADDRLP4 0+24+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 2768
;2768:	initmove.entitynum = bs->entitynum;
ADDRLP4 0+36
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 2769
;2769:	initmove.client = bs->client;
ADDRLP4 0+40
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 2770
;2770:	initmove.thinktime = bs->thinktime;
ADDRLP4 0+44
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
ASGNF4
line 2772
;2771:	//set the onground flag
;2772:	if (bs->cur_ps.groundEntityNum != ENTITYNUM_NONE) initmove.or_moveflags |= MFL_ONGROUND;
ADDRFP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 1023
EQI4 $759
ADDRLP4 0+64
ADDRLP4 0+64
INDIRI4
CNSTI4 2
BORI4
ASGNI4
LABELV $759
line 2774
;2773:	//set the teleported flag
;2774:	if ((bs->cur_ps.pm_flags & PMF_TIME_KNOCKBACK) && (bs->cur_ps.pm_time > 0)) {
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $762
ADDRLP4 72
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
LEI4 $762
line 2775
;2775:		initmove.or_moveflags |= MFL_TELEPORTED;
ADDRLP4 0+64
ADDRLP4 0+64
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 2776
;2776:	}
LABELV $762
line 2778
;2777:	//set the waterjump flag
;2778:	if ((bs->cur_ps.pm_flags & PMF_TIME_WATERJUMP) && (bs->cur_ps.pm_time > 0)) {
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $765
ADDRLP4 76
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
LEI4 $765
line 2779
;2779:		initmove.or_moveflags |= MFL_WATERJUMP;
ADDRLP4 0+64
ADDRLP4 0+64
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 2780
;2780:	}
LABELV $765
line 2782
;2781:	//set presence type
;2782:	if (bs->cur_ps.pm_flags & PMF_DUCKED) initmove.presencetype = PRESENCE_CROUCH;
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $768
ADDRLP4 0+48
CNSTI4 4
ASGNI4
ADDRGP4 $769
JUMPV
LABELV $768
line 2783
;2783:	else initmove.presencetype = PRESENCE_NORMAL;
ADDRLP4 0+48
CNSTI4 2
ASGNI4
LABELV $769
line 2785
;2784:	//
;2785:	if (bs->walker > 0.5) initmove.or_moveflags |= MFL_WALK;
ADDRFP4 0
INDIRP4
CNSTI4 6076
ADDP4
INDIRF4
CNSTF4 1056964608
LEF4 $772
ADDRLP4 0+64
ADDRLP4 0+64
INDIRI4
CNSTI4 512
BORI4
ASGNI4
LABELV $772
line 2789
;2786:	// JUHOX: bots should be silent if nothing important to do
;2787:#if 1
;2788:	if (
;2789:		(
ADDRGP4 g_stamina+12
INDIRI4
CNSTI4 0
NEI4 $779
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
EQI4 $775
LABELV $779
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 6636
ADDP4
INDIRI4
CNSTI4 0
NEI4 $775
ADDRLP4 80
INDIRP4
ARGP4
ADDRLP4 84
ADDRGP4 LTGNearlyFulfilled
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
EQI4 $775
line 2795
;2790:			g_stamina.integer ||
;2791:			g_gametype.integer != GT_CTF
;2792:		) &&
;2793:		!bs->nbgGivesPODMarker &&
;2794:		LTGNearlyFulfilled(bs)
;2795:	) {
line 2796
;2796:		initmove.or_moveflags |= MFL_WALK;
ADDRLP4 0+64
ADDRLP4 0+64
INDIRI4
CNSTI4 512
BORI4
ASGNI4
line 2797
;2797:	}
LABELV $775
line 2801
;2798:#endif
;2799:	// JUHOX: since the MFL_WALK is not checked by all movement functions (bug?) we use 'forceWalk'
;2800:#if 1
;2801:	bs->forceWalk = (initmove.or_moveflags & MFL_WALK)? qtrue : qfalse;
ADDRLP4 0+64
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $783
ADDRLP4 88
CNSTI4 1
ASGNI4
ADDRGP4 $784
JUMPV
LABELV $783
ADDRLP4 88
CNSTI4 0
ASGNI4
LABELV $784
ADDRFP4 0
INDIRP4
CNSTI4 7740
ADDP4
ADDRLP4 88
INDIRI4
ASGNI4
line 2803
;2802:#endif
;2803:	if (bs->forceWalk) bs->tfl &= ~TFL_JUMP;	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 7740
ADDP4
INDIRI4
CNSTI4 0
EQI4 $785
ADDRLP4 92
ADDRFP4 0
INDIRP4
CNSTI4 5984
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRI4
CNSTI4 -17
BANDI4
ASGNI4
LABELV $785
line 2805
;2804:	//
;2805:	VectorCopy(bs->viewangles, initmove.viewangles);
ADDRLP4 0+52
ADDRFP4 0
INDIRP4
CNSTI4 7840
ADDP4
INDIRB
ASGNB 12
line 2807
;2806:	//
;2807:	trap_BotInitMoveState(bs->ms, &initmove);
ADDRFP4 0
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotInitMoveState
CALLV
pop
line 2808
;2808:	bs->preventJump = qfalse;	// JUHOX: eventually set later by movement code
ADDRFP4 0
INDIRP4
CNSTI4 7748
ADDP4
CNSTI4 0
ASGNI4
line 2809
;2809:	bs->specialMove = qfalse;	// JUHOX: eventually set later
ADDRFP4 0
INDIRP4
CNSTI4 7744
ADDP4
CNSTI4 0
ASGNI4
line 2810
;2810:}
LABELV $747
endproc BotSetupForMovement 96 12
export BotCheckItemPickup
proc BotCheckItemPickup 0 0
line 2817
;2811:
;2812:/*
;2813:==================
;2814:BotCheckItemPickup
;2815:==================
;2816:*/
;2817:void BotCheckItemPickup(bot_state_t *bs, int *oldinventory) {
line 2904
;2818:#ifdef MISSIONPACK
;2819:	int offence, leader;
;2820:
;2821:	if (gametype <= GT_TEAM)
;2822:		return;
;2823:
;2824:	offence = -1;
;2825:	// go into offence if picked up the kamikaze or invulnerability
;2826:	if (!oldinventory[INVENTORY_KAMIKAZE] && bs->inventory[INVENTORY_KAMIKAZE] >= 1) {
;2827:		offence = qtrue;
;2828:	}
;2829:	if (!oldinventory[INVENTORY_INVULNERABILITY] && bs->inventory[INVENTORY_INVULNERABILITY] >= 1) {
;2830:		offence = qtrue;
;2831:	}
;2832:	// if not already wearing the kamikaze or invulnerability
;2833:	if (!bs->inventory[INVENTORY_KAMIKAZE] && !bs->inventory[INVENTORY_INVULNERABILITY]) {
;2834:		if (!oldinventory[INVENTORY_SCOUT] && bs->inventory[INVENTORY_SCOUT] >= 1) {
;2835:			offence = qtrue;
;2836:		}
;2837:		if (!oldinventory[INVENTORY_GUARD] && bs->inventory[INVENTORY_GUARD] >= 1) {
;2838:			offence = qtrue;
;2839:		}
;2840:		if (!oldinventory[INVENTORY_DOUBLER] && bs->inventory[INVENTORY_DOUBLER] >= 1) {
;2841:			offence = qfalse;
;2842:		}
;2843:		if (!oldinventory[INVENTORY_AMMOREGEN] && bs->inventory[INVENTORY_AMMOREGEN] >= 1) {
;2844:			offence = qfalse;
;2845:		}
;2846:	}
;2847:
;2848:	if (offence >= 0) {
;2849:		leader = ClientFromName(bs->teamleader);
;2850:		if (offence) {
;2851:			if (!(bs->teamtaskpreference & TEAMTP_ATTACKER)) {
;2852:				// if we have a bot team leader
;2853:				if (BotTeamLeader(bs)) {
;2854:					// tell the leader we want to be on offence
;2855:					BotVoiceChat(bs, leader, VOICECHAT_WANTONOFFENSE);
;2856:					//BotAI_BotInitialChat(bs, "wantoffence", NULL);
;2857:					//trap_BotEnterChat(bs->cs, leader, CHAT_TELL);
;2858:				}
;2859:				else if (g_spSkill.integer <= 3) {
;2860:					if ( bs->ltgtype != LTG_GETFLAG &&
;2861:						 bs->ltgtype != LTG_ATTACKENEMYBASE &&
;2862:						 bs->ltgtype != LTG_HARVEST ) {
;2863:						//
;2864:						if ((gametype != GT_CTF || (bs->redflagstatus == 0 && bs->blueflagstatus == 0)) &&
;2865:							(gametype != GT_1FCTF || bs->neutralflagstatus == 0) ) {
;2866:							// tell the leader we want to be on offence
;2867:							BotVoiceChat(bs, leader, VOICECHAT_WANTONOFFENSE);
;2868:							//BotAI_BotInitialChat(bs, "wantoffence", NULL);
;2869:							//trap_BotEnterChat(bs->cs, leader, CHAT_TELL);
;2870:						}
;2871:					}
;2872:					bs->teamtaskpreference |= TEAMTP_ATTACKER;
;2873:				}
;2874:			}
;2875:			bs->teamtaskpreference &= ~TEAMTP_DEFENDER;
;2876:		}
;2877:		else {
;2878:			if (!(bs->teamtaskpreference & TEAMTP_DEFENDER)) {
;2879:				// if we have a bot team leader
;2880:				if (BotTeamLeader(bs)) {
;2881:					// tell the leader we want to be on defense
;2882:					BotVoiceChat(bs, -1, VOICECHAT_WANTONDEFENSE);
;2883:					//BotAI_BotInitialChat(bs, "wantdefence", NULL);
;2884:					//trap_BotEnterChat(bs->cs, leader, CHAT_TELL);
;2885:				}
;2886:				else if (g_spSkill.integer <= 3) {
;2887:					if ( bs->ltgtype != LTG_DEFENDKEYAREA ) {
;2888:						//
;2889:						if ((gametype != GT_CTF || (bs->redflagstatus == 0 && bs->blueflagstatus == 0)) &&
;2890:							(gametype != GT_1FCTF || bs->neutralflagstatus == 0) ) {
;2891:							// tell the leader we want to be on defense
;2892:							BotVoiceChat(bs, -1, VOICECHAT_WANTONDEFENSE);
;2893:							//BotAI_BotInitialChat(bs, "wantdefence", NULL);
;2894:							//trap_BotEnterChat(bs->cs, leader, CHAT_TELL);
;2895:						}
;2896:					}
;2897:				}
;2898:				bs->teamtaskpreference |= TEAMTP_DEFENDER;
;2899:			}
;2900:			bs->teamtaskpreference &= ~TEAMTP_ATTACKER;
;2901:		}
;2902:	}
;2903:#endif
;2904:}
LABELV $788
endproc BotCheckItemPickup 0 0
export BotUpdateInventory
proc BotUpdateInventory 1224 12
line 2911
;2905:
;2906:/*
;2907:==================
;2908:BotUpdateInventory
;2909:==================
;2910:*/
;2911:void BotUpdateInventory(bot_state_t *bs) {
line 2914
;2912:	int oldinventory[MAX_ITEMS];
;2913:
;2914:	memcpy(oldinventory, bs->inventory, sizeof(oldinventory));
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 4960
ADDP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2916
;2915:	//armor
;2916:	bs->inventory[INVENTORY_ARMOR] = bs->cur_ps.stats[STAT_ARMOR];
ADDRLP4 1024
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1024
INDIRP4
CNSTI4 4964
ADDP4
ADDRLP4 1024
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ASGNI4
line 2918
;2917:	//weapons
;2918:	bs->inventory[INVENTORY_GAUNTLET] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_GAUNTLET)) != 0;
ADDRLP4 1032
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1032
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $791
ADDRLP4 1028
CNSTI4 1
ASGNI4
ADDRGP4 $792
JUMPV
LABELV $791
ADDRLP4 1028
CNSTI4 0
ASGNI4
LABELV $792
ADDRLP4 1032
INDIRP4
CNSTI4 4976
ADDP4
ADDRLP4 1028
INDIRI4
ASGNI4
line 2919
;2919:	bs->inventory[INVENTORY_SHOTGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_SHOTGUN)) != 0;
ADDRLP4 1040
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1040
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $794
ADDRLP4 1036
CNSTI4 1
ASGNI4
ADDRGP4 $795
JUMPV
LABELV $794
ADDRLP4 1036
CNSTI4 0
ASGNI4
LABELV $795
ADDRLP4 1040
INDIRP4
CNSTI4 4980
ADDP4
ADDRLP4 1036
INDIRI4
ASGNI4
line 2920
;2920:	bs->inventory[INVENTORY_MACHINEGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_MACHINEGUN)) != 0;
ADDRLP4 1048
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1048
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $797
ADDRLP4 1044
CNSTI4 1
ASGNI4
ADDRGP4 $798
JUMPV
LABELV $797
ADDRLP4 1044
CNSTI4 0
ASGNI4
LABELV $798
ADDRLP4 1048
INDIRP4
CNSTI4 4984
ADDP4
ADDRLP4 1044
INDIRI4
ASGNI4
line 2921
;2921:	bs->inventory[INVENTORY_GRENADELAUNCHER] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_GRENADE_LAUNCHER)) != 0;
ADDRLP4 1056
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1056
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $800
ADDRLP4 1052
CNSTI4 1
ASGNI4
ADDRGP4 $801
JUMPV
LABELV $800
ADDRLP4 1052
CNSTI4 0
ASGNI4
LABELV $801
ADDRLP4 1056
INDIRP4
CNSTI4 4988
ADDP4
ADDRLP4 1052
INDIRI4
ASGNI4
line 2922
;2922:	bs->inventory[INVENTORY_ROCKETLAUNCHER] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_ROCKET_LAUNCHER)) != 0;
ADDRLP4 1064
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1064
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $803
ADDRLP4 1060
CNSTI4 1
ASGNI4
ADDRGP4 $804
JUMPV
LABELV $803
ADDRLP4 1060
CNSTI4 0
ASGNI4
LABELV $804
ADDRLP4 1064
INDIRP4
CNSTI4 4992
ADDP4
ADDRLP4 1060
INDIRI4
ASGNI4
line 2923
;2923:	bs->inventory[INVENTORY_LIGHTNING] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_LIGHTNING)) != 0;
ADDRLP4 1072
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1072
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $806
ADDRLP4 1068
CNSTI4 1
ASGNI4
ADDRGP4 $807
JUMPV
LABELV $806
ADDRLP4 1068
CNSTI4 0
ASGNI4
LABELV $807
ADDRLP4 1072
INDIRP4
CNSTI4 4996
ADDP4
ADDRLP4 1068
INDIRI4
ASGNI4
line 2924
;2924:	bs->inventory[INVENTORY_RAILGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_RAILGUN)) != 0;
ADDRLP4 1080
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1080
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $809
ADDRLP4 1076
CNSTI4 1
ASGNI4
ADDRGP4 $810
JUMPV
LABELV $809
ADDRLP4 1076
CNSTI4 0
ASGNI4
LABELV $810
ADDRLP4 1080
INDIRP4
CNSTI4 5000
ADDP4
ADDRLP4 1076
INDIRI4
ASGNI4
line 2925
;2925:	bs->inventory[INVENTORY_PLASMAGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_PLASMAGUN)) != 0;
ADDRLP4 1088
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1088
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $812
ADDRLP4 1084
CNSTI4 1
ASGNI4
ADDRGP4 $813
JUMPV
LABELV $812
ADDRLP4 1084
CNSTI4 0
ASGNI4
LABELV $813
ADDRLP4 1088
INDIRP4
CNSTI4 5004
ADDP4
ADDRLP4 1084
INDIRI4
ASGNI4
line 2926
;2926:	bs->inventory[INVENTORY_BFG10K] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_BFG)) != 0;
ADDRLP4 1096
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1096
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $815
ADDRLP4 1092
CNSTI4 1
ASGNI4
ADDRGP4 $816
JUMPV
LABELV $815
ADDRLP4 1092
CNSTI4 0
ASGNI4
LABELV $816
ADDRLP4 1096
INDIRP4
CNSTI4 5012
ADDP4
ADDRLP4 1092
INDIRI4
ASGNI4
line 2927
;2927:	bs->inventory[INVENTORY_GRAPPLINGHOOK] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_GRAPPLING_HOOK)) != 0;
ADDRLP4 1104
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1104
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $818
ADDRLP4 1100
CNSTI4 1
ASGNI4
ADDRGP4 $819
JUMPV
LABELV $818
ADDRLP4 1100
CNSTI4 0
ASGNI4
LABELV $819
ADDRLP4 1104
INDIRP4
CNSTI4 5016
ADDP4
ADDRLP4 1100
INDIRI4
ASGNI4
line 2934
;2928:#ifdef MISSIONPACK
;2929:	bs->inventory[INVENTORY_NAILGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_NAILGUN)) != 0;;
;2930:	bs->inventory[INVENTORY_PROXLAUNCHER] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_PROX_LAUNCHER)) != 0;;
;2931:	bs->inventory[INVENTORY_CHAINGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_CHAINGUN)) != 0;;
;2932:#endif
;2933:	//ammo
;2934:	bs->inventory[INVENTORY_SHELLS] = bs->cur_ps.ammo[WP_SHOTGUN];
ADDRLP4 1108
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1108
INDIRP4
CNSTI4 5032
ADDP4
ADDRLP4 1108
INDIRP4
CNSTI4 404
ADDP4
INDIRI4
ASGNI4
line 2935
;2935:	bs->inventory[INVENTORY_BULLETS] = bs->cur_ps.ammo[WP_MACHINEGUN];
ADDRLP4 1112
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1112
INDIRP4
CNSTI4 5036
ADDP4
ADDRLP4 1112
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ASGNI4
line 2936
;2936:	bs->inventory[INVENTORY_GRENADES] = bs->cur_ps.ammo[WP_GRENADE_LAUNCHER];
ADDRLP4 1116
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1116
INDIRP4
CNSTI4 5040
ADDP4
ADDRLP4 1116
INDIRP4
CNSTI4 408
ADDP4
INDIRI4
ASGNI4
line 2937
;2937:	bs->inventory[INVENTORY_CELLS] = bs->cur_ps.ammo[WP_PLASMAGUN];
ADDRLP4 1120
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1120
INDIRP4
CNSTI4 5044
ADDP4
ADDRLP4 1120
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
ASGNI4
line 2938
;2938:	bs->inventory[INVENTORY_LIGHTNINGAMMO] = bs->cur_ps.ammo[WP_LIGHTNING];
ADDRLP4 1124
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1124
INDIRP4
CNSTI4 5048
ADDP4
ADDRLP4 1124
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
ASGNI4
line 2939
;2939:	bs->inventory[INVENTORY_ROCKETS] = bs->cur_ps.ammo[WP_ROCKET_LAUNCHER];
ADDRLP4 1128
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1128
INDIRP4
CNSTI4 5052
ADDP4
ADDRLP4 1128
INDIRP4
CNSTI4 412
ADDP4
INDIRI4
ASGNI4
line 2940
;2940:	bs->inventory[INVENTORY_SLUGS] = bs->cur_ps.ammo[WP_RAILGUN];
ADDRLP4 1132
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1132
INDIRP4
CNSTI4 5056
ADDP4
ADDRLP4 1132
INDIRP4
CNSTI4 420
ADDP4
INDIRI4
ASGNI4
line 2945
;2941:	// JUHOX: BFG ammo is now more valuable than before, so cheat the AI a bit
;2942:#if 0
;2943:	bs->inventory[INVENTORY_BFGAMMO] = bs->cur_ps.ammo[WP_BFG];
;2944:#else
;2945:	bs->inventory[INVENTORY_BFGAMMO] = 10 * bs->cur_ps.ammo[WP_BFG];
ADDRLP4 1136
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1136
INDIRP4
CNSTI4 5060
ADDP4
ADDRLP4 1136
INDIRP4
CNSTI4 428
ADDP4
INDIRI4
CNSTI4 10
MULI4
ASGNI4
line 2953
;2946:#endif
;2947:#ifdef MISSIONPACK
;2948:	bs->inventory[INVENTORY_NAILS] = bs->cur_ps.ammo[WP_NAILGUN];
;2949:	bs->inventory[INVENTORY_MINES] = bs->cur_ps.ammo[WP_PROX_LAUNCHER];
;2950:	bs->inventory[INVENTORY_BELT] = bs->cur_ps.ammo[WP_CHAINGUN];
;2951:#endif
;2952:	//powerups
;2953:	bs->inventory[INVENTORY_HEALTH] = bs->cur_ps.stats[STAT_HEALTH];
ADDRLP4 1140
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1140
INDIRP4
CNSTI4 5076
ADDP4
ADDRLP4 1140
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ASGNI4
line 2954
;2954:	bs->inventory[INVENTORY_TELEPORTER] = bs->cur_ps.stats[STAT_HOLDABLE_ITEM] == MODELINDEX_TELEPORTER;
ADDRLP4 1148
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1148
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 26
NEI4 $821
ADDRLP4 1144
CNSTI4 1
ASGNI4
ADDRGP4 $822
JUMPV
LABELV $821
ADDRLP4 1144
CNSTI4 0
ASGNI4
LABELV $822
ADDRLP4 1148
INDIRP4
CNSTI4 5080
ADDP4
ADDRLP4 1144
INDIRI4
ASGNI4
line 2955
;2955:	bs->inventory[INVENTORY_MEDKIT] = bs->cur_ps.stats[STAT_HOLDABLE_ITEM] == MODELINDEX_MEDKIT;
ADDRLP4 1156
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1156
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 27
NEI4 $824
ADDRLP4 1152
CNSTI4 1
ASGNI4
ADDRGP4 $825
JUMPV
LABELV $824
ADDRLP4 1152
CNSTI4 0
ASGNI4
LABELV $825
ADDRLP4 1156
INDIRP4
CNSTI4 5084
ADDP4
ADDRLP4 1152
INDIRI4
ASGNI4
line 2961
;2956:#ifdef MISSIONPACK
;2957:	bs->inventory[INVENTORY_KAMIKAZE] = bs->cur_ps.stats[STAT_HOLDABLE_ITEM] == MODELINDEX_KAMIKAZE;
;2958:	bs->inventory[INVENTORY_PORTAL] = bs->cur_ps.stats[STAT_HOLDABLE_ITEM] == MODELINDEX_PORTAL;
;2959:	bs->inventory[INVENTORY_INVULNERABILITY] = bs->cur_ps.stats[STAT_HOLDABLE_ITEM] == MODELINDEX_INVULNERABILITY;
;2960:#endif
;2961:	bs->inventory[INVENTORY_QUAD] = bs->cur_ps.powerups[PW_QUAD] != 0;
ADDRLP4 1164
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1164
INDIRP4
CNSTI4 332
ADDP4
INDIRI4
CNSTI4 0
EQI4 $827
ADDRLP4 1160
CNSTI4 1
ASGNI4
ADDRGP4 $828
JUMPV
LABELV $827
ADDRLP4 1160
CNSTI4 0
ASGNI4
LABELV $828
ADDRLP4 1164
INDIRP4
CNSTI4 5100
ADDP4
ADDRLP4 1160
INDIRI4
ASGNI4
line 2962
;2962:	bs->inventory[INVENTORY_ENVIRONMENTSUIT] = bs->cur_ps.powerups[PW_BATTLESUIT] != 0;
ADDRLP4 1172
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1172
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
CNSTI4 0
EQI4 $830
ADDRLP4 1168
CNSTI4 1
ASGNI4
ADDRGP4 $831
JUMPV
LABELV $830
ADDRLP4 1168
CNSTI4 0
ASGNI4
LABELV $831
ADDRLP4 1172
INDIRP4
CNSTI4 5104
ADDP4
ADDRLP4 1168
INDIRI4
ASGNI4
line 2963
;2963:	bs->inventory[INVENTORY_HASTE] = bs->cur_ps.powerups[PW_HASTE] != 0;
ADDRLP4 1180
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1180
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
EQI4 $833
ADDRLP4 1176
CNSTI4 1
ASGNI4
ADDRGP4 $834
JUMPV
LABELV $833
ADDRLP4 1176
CNSTI4 0
ASGNI4
LABELV $834
ADDRLP4 1180
INDIRP4
CNSTI4 5108
ADDP4
ADDRLP4 1176
INDIRI4
ASGNI4
line 2964
;2964:	bs->inventory[INVENTORY_INVISIBILITY] = bs->cur_ps.powerups[PW_INVIS] != 0;
ADDRLP4 1188
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1188
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
EQI4 $836
ADDRLP4 1184
CNSTI4 1
ASGNI4
ADDRGP4 $837
JUMPV
LABELV $836
ADDRLP4 1184
CNSTI4 0
ASGNI4
LABELV $837
ADDRLP4 1188
INDIRP4
CNSTI4 5112
ADDP4
ADDRLP4 1184
INDIRI4
ASGNI4
line 2965
;2965:	bs->inventory[INVENTORY_REGEN] = bs->cur_ps.powerups[PW_REGEN] != 0;
ADDRLP4 1196
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1196
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
CNSTI4 0
EQI4 $839
ADDRLP4 1192
CNSTI4 1
ASGNI4
ADDRGP4 $840
JUMPV
LABELV $839
ADDRLP4 1192
CNSTI4 0
ASGNI4
LABELV $840
ADDRLP4 1196
INDIRP4
CNSTI4 5116
ADDP4
ADDRLP4 1192
INDIRI4
ASGNI4
line 2966
;2966:	bs->inventory[INVENTORY_FLIGHT] = bs->cur_ps.powerups[PW_FLIGHT] != 0;
ADDRLP4 1204
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1204
INDIRP4
CNSTI4 352
ADDP4
INDIRI4
CNSTI4 0
EQI4 $842
ADDRLP4 1200
CNSTI4 1
ASGNI4
ADDRGP4 $843
JUMPV
LABELV $842
ADDRLP4 1200
CNSTI4 0
ASGNI4
LABELV $843
ADDRLP4 1204
INDIRP4
CNSTI4 5120
ADDP4
ADDRLP4 1200
INDIRI4
ASGNI4
line 2973
;2967:#ifdef MISSIONPACK
;2968:	bs->inventory[INVENTORY_SCOUT] = bs->cur_ps.stats[STAT_PERSISTANT_POWERUP] == MODELINDEX_SCOUT;
;2969:	bs->inventory[INVENTORY_GUARD] = bs->cur_ps.stats[STAT_PERSISTANT_POWERUP] == MODELINDEX_GUARD;
;2970:	bs->inventory[INVENTORY_DOUBLER] = bs->cur_ps.stats[STAT_PERSISTANT_POWERUP] == MODELINDEX_DOUBLER;
;2971:	bs->inventory[INVENTORY_AMMOREGEN] = bs->cur_ps.stats[STAT_PERSISTANT_POWERUP] == MODELINDEX_AMMOREGEN;
;2972:#endif
;2973:	bs->inventory[INVENTORY_REDFLAG] = bs->cur_ps.powerups[PW_REDFLAG] != 0;
ADDRLP4 1212
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1212
INDIRP4
CNSTI4 356
ADDP4
INDIRI4
CNSTI4 0
EQI4 $845
ADDRLP4 1208
CNSTI4 1
ASGNI4
ADDRGP4 $846
JUMPV
LABELV $845
ADDRLP4 1208
CNSTI4 0
ASGNI4
LABELV $846
ADDRLP4 1212
INDIRP4
CNSTI4 5140
ADDP4
ADDRLP4 1208
INDIRI4
ASGNI4
line 2974
;2974:	bs->inventory[INVENTORY_BLUEFLAG] = bs->cur_ps.powerups[PW_BLUEFLAG] != 0;
ADDRLP4 1220
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1220
INDIRP4
CNSTI4 360
ADDP4
INDIRI4
CNSTI4 0
EQI4 $848
ADDRLP4 1216
CNSTI4 1
ASGNI4
ADDRGP4 $849
JUMPV
LABELV $848
ADDRLP4 1216
CNSTI4 0
ASGNI4
LABELV $849
ADDRLP4 1220
INDIRP4
CNSTI4 5144
ADDP4
ADDRLP4 1216
INDIRI4
ASGNI4
line 2986
;2975:#ifdef MISSIONPACK
;2976:	bs->inventory[INVENTORY_NEUTRALFLAG] = bs->cur_ps.powerups[PW_NEUTRALFLAG] != 0;
;2977:	if (BotTeam(bs) == TEAM_RED) {
;2978:		bs->inventory[INVENTORY_REDCUBE] = bs->cur_ps.generic1;
;2979:		bs->inventory[INVENTORY_BLUECUBE] = 0;
;2980:	}
;2981:	else {
;2982:		bs->inventory[INVENTORY_REDCUBE] = 0;
;2983:		bs->inventory[INVENTORY_BLUECUBE] = bs->cur_ps.generic1;
;2984:	}
;2985:#endif
;2986:	BotCheckItemPickup(bs, oldinventory);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotCheckItemPickup
CALLV
pop
line 2987
;2987:}
LABELV $789
endproc BotUpdateInventory 1224 12
export BotUpdateBattleInventory
proc BotUpdateBattleInventory 0 0
line 2994
;2988:
;2989:/*
;2990:==================
;2991:BotUpdateBattleInventory
;2992:==================
;2993:*/
;2994:void BotUpdateBattleInventory(bot_state_t *bs, int enemy) {
line 3007
;2995:	// JUHOX: ENEMY_HEIGHT and ENEMY_HORIZONTAL_DIST are no longer needed
;2996:#if 0
;2997:	vec3_t dir;
;2998:	aas_entityinfo_t entinfo;
;2999:
;3000:	BotEntityInfo(enemy, &entinfo);
;3001:	VectorSubtract(entinfo.origin, bs->origin, dir);
;3002:	bs->inventory[ENEMY_HEIGHT] = (int) dir[2];
;3003:	dir[2] = 0;
;3004:	bs->inventory[ENEMY_HORIZONTAL_DIST] = (int) VectorLength(dir);
;3005:	//FIXME: add num visible enemies and num visible team mates to the inventory
;3006:#endif
;3007:}
LABELV $850
endproc BotUpdateBattleInventory 0 0
export BotBattleUseItems
proc BotBattleUseItems 8 4
line 3234
;3008:
;3009:#ifdef MISSIONPACK
;3010:/*
;3011:==================
;3012:BotUseKamikaze
;3013:==================
;3014:*/
;3015:#define KAMIKAZE_DIST		1024
;3016:
;3017:void BotUseKamikaze(bot_state_t *bs) {
;3018:	int c, teammates, enemies;
;3019:	aas_entityinfo_t entinfo;
;3020:	vec3_t dir, target;
;3021:	bot_goal_t *goal;
;3022:	bsp_trace_t trace;
;3023:
;3024:	//if the bot has no kamikaze
;3025:	if (bs->inventory[INVENTORY_KAMIKAZE] <= 0)
;3026:		return;
;3027:	if (bs->kamikaze_time > FloatTime())
;3028:		return;
;3029:	bs->kamikaze_time = FloatTime() + 0.2;
;3030:	if (gametype == GT_CTF) {
;3031:		//never use kamikaze if the team flag carrier is visible
;3032:		if (BotCTFCarryingFlag(bs))
;3033:			return;
;3034:		c = BotTeamFlagCarrierVisible(bs);
;3035:		if (c >= 0) {
;3036:			BotEntityInfo(c, &entinfo);
;3037:			VectorSubtract(entinfo.origin, bs->origin, dir);
;3038:			if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST))
;3039:				return;
;3040:		}
;3041:		c = BotEnemyFlagCarrierVisible(bs);
;3042:		if (c >= 0) {
;3043:			BotEntityInfo(c, &entinfo);
;3044:			VectorSubtract(entinfo.origin, bs->origin, dir);
;3045:			if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST)) {
;3046:				trap_EA_Use(bs->client);
;3047:				return;
;3048:			}
;3049:		}
;3050:	}
;3051:	else if (gametype == GT_1FCTF) {
;3052:		//never use kamikaze if the team flag carrier is visible
;3053:		if (Bot1FCTFCarryingFlag(bs))
;3054:			return;
;3055:		c = BotTeamFlagCarrierVisible(bs);
;3056:		if (c >= 0) {
;3057:			BotEntityInfo(c, &entinfo);
;3058:			VectorSubtract(entinfo.origin, bs->origin, dir);
;3059:			if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST))
;3060:				return;
;3061:		}
;3062:		c = BotEnemyFlagCarrierVisible(bs);
;3063:		if (c >= 0) {
;3064:			BotEntityInfo(c, &entinfo);
;3065:			VectorSubtract(entinfo.origin, bs->origin, dir);
;3066:			if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST)) {
;3067:				trap_EA_Use(bs->client);
;3068:				return;
;3069:			}
;3070:		}
;3071:	}
;3072:	else if (gametype == GT_OBELISK) {
;3073:		switch(BotTeam(bs)) {
;3074:			case TEAM_RED: goal = &blueobelisk; break;
;3075:			default: goal = &redobelisk; break;
;3076:		}
;3077:		//if the obelisk is visible
;3078:		VectorCopy(goal->origin, target);
;3079:		target[2] += 1;
;3080:		VectorSubtract(bs->origin, target, dir);
;3081:		if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST * 0.9)) {
;3082:			BotAI_Trace(&trace, bs->eye, NULL, NULL, target, bs->client, CONTENTS_SOLID);
;3083:			if (trace.fraction >= 1 || trace.ent == goal->entitynum) {
;3084:				trap_EA_Use(bs->client);
;3085:				return;
;3086:			}
;3087:		}
;3088:	}
;3089:	else if (gametype == GT_HARVESTER) {
;3090:		//
;3091:		if (BotHarvesterCarryingCubes(bs))
;3092:			return;
;3093:		//never use kamikaze if a team mate carrying cubes is visible
;3094:		c = BotTeamCubeCarrierVisible(bs);
;3095:		if (c >= 0) {
;3096:			BotEntityInfo(c, &entinfo);
;3097:			VectorSubtract(entinfo.origin, bs->origin, dir);
;3098:			if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST))
;3099:				return;
;3100:		}
;3101:		c = BotEnemyCubeCarrierVisible(bs);
;3102:		if (c >= 0) {
;3103:			BotEntityInfo(c, &entinfo);
;3104:			VectorSubtract(entinfo.origin, bs->origin, dir);
;3105:			if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST)) {
;3106:				trap_EA_Use(bs->client);
;3107:				return;
;3108:			}
;3109:		}
;3110:	}
;3111:	//
;3112:	BotVisibleTeamMatesAndEnemies(bs, &teammates, &enemies, KAMIKAZE_DIST);
;3113:	//
;3114:	if (enemies > 2 && enemies > teammates+1) {
;3115:		trap_EA_Use(bs->client);
;3116:		return;
;3117:	}
;3118:}
;3119:
;3120:/*
;3121:==================
;3122:BotUseInvulnerability
;3123:==================
;3124:*/
;3125:void BotUseInvulnerability(bot_state_t *bs) {
;3126:	int c;
;3127:	vec3_t dir, target;
;3128:	bot_goal_t *goal;
;3129:	bsp_trace_t trace;
;3130:
;3131:	//if the bot has no invulnerability
;3132:	if (bs->inventory[INVENTORY_INVULNERABILITY] <= 0)
;3133:		return;
;3134:	if (bs->invulnerability_time > FloatTime())
;3135:		return;
;3136:	bs->invulnerability_time = FloatTime() + 0.2;
;3137:	if (gametype == GT_CTF) {
;3138:		//never use kamikaze if the team flag carrier is visible
;3139:		if (BotCTFCarryingFlag(bs))
;3140:			return;
;3141:		c = BotEnemyFlagCarrierVisible(bs);
;3142:		if (c >= 0)
;3143:			return;
;3144:		//if near enemy flag and the flag is visible
;3145:		switch(BotTeam(bs)) {
;3146:			case TEAM_RED: goal = &ctf_blueflag; break;
;3147:			default: goal = &ctf_redflag; break;
;3148:		}
;3149:		//if the obelisk is visible
;3150:		VectorCopy(goal->origin, target);
;3151:		target[2] += 1;
;3152:		VectorSubtract(bs->origin, target, dir);
;3153:		if (VectorLengthSquared(dir) < Square(200)) {
;3154:			BotAI_Trace(&trace, bs->eye, NULL, NULL, target, bs->client, CONTENTS_SOLID);
;3155:			if (trace.fraction >= 1 || trace.ent == goal->entitynum) {
;3156:				trap_EA_Use(bs->client);
;3157:				return;
;3158:			}
;3159:		}
;3160:	}
;3161:	else if (gametype == GT_1FCTF) {
;3162:		//never use kamikaze if the team flag carrier is visible
;3163:		if (Bot1FCTFCarryingFlag(bs))
;3164:			return;
;3165:		c = BotEnemyFlagCarrierVisible(bs);
;3166:		if (c >= 0)
;3167:			return;
;3168:		//if near enemy flag and the flag is visible
;3169:		switch(BotTeam(bs)) {
;3170:			case TEAM_RED: goal = &ctf_blueflag; break;
;3171:			default: goal = &ctf_redflag; break;
;3172:		}
;3173:		//if the obelisk is visible
;3174:		VectorCopy(goal->origin, target);
;3175:		target[2] += 1;
;3176:		VectorSubtract(bs->origin, target, dir);
;3177:		if (VectorLengthSquared(dir) < Square(200)) {
;3178:			BotAI_Trace(&trace, bs->eye, NULL, NULL, target, bs->client, CONTENTS_SOLID);
;3179:			if (trace.fraction >= 1 || trace.ent == goal->entitynum) {
;3180:				trap_EA_Use(bs->client);
;3181:				return;
;3182:			}
;3183:		}
;3184:	}
;3185:	else if (gametype == GT_OBELISK) {
;3186:		switch(BotTeam(bs)) {
;3187:			case TEAM_RED: goal = &blueobelisk; break;
;3188:			default: goal = &redobelisk; break;
;3189:		}
;3190:		//if the obelisk is visible
;3191:		VectorCopy(goal->origin, target);
;3192:		target[2] += 1;
;3193:		VectorSubtract(bs->origin, target, dir);
;3194:		if (VectorLengthSquared(dir) < Square(300)) {
;3195:			BotAI_Trace(&trace, bs->eye, NULL, NULL, target, bs->client, CONTENTS_SOLID);
;3196:			if (trace.fraction >= 1 || trace.ent == goal->entitynum) {
;3197:				trap_EA_Use(bs->client);
;3198:				return;
;3199:			}
;3200:		}
;3201:	}
;3202:	else if (gametype == GT_HARVESTER) {
;3203:		//
;3204:		if (BotHarvesterCarryingCubes(bs))
;3205:			return;
;3206:		c = BotEnemyCubeCarrierVisible(bs);
;3207:		if (c >= 0)
;3208:			return;
;3209:		//if near enemy base and enemy base is visible
;3210:		switch(BotTeam(bs)) {
;3211:			case TEAM_RED: goal = &blueobelisk; break;
;3212:			default: goal = &redobelisk; break;
;3213:		}
;3214:		//if the obelisk is visible
;3215:		VectorCopy(goal->origin, target);
;3216:		target[2] += 1;
;3217:		VectorSubtract(bs->origin, target, dir);
;3218:		if (VectorLengthSquared(dir) < Square(200)) {
;3219:			BotAI_Trace(&trace, bs->eye, NULL, NULL, target, bs->client, CONTENTS_SOLID);
;3220:			if (trace.fraction >= 1 || trace.ent == goal->entitynum) {
;3221:				trap_EA_Use(bs->client);
;3222:				return;
;3223:			}
;3224:		}
;3225:	}
;3226:}
;3227:#endif
;3228:
;3229:/*
;3230:==================
;3231:BotBattleUseItems
;3232:==================
;3233:*/
;3234:void BotBattleUseItems(bot_state_t *bs) {
line 3240
;3235:	// JUHOX: item usage should also depend on max health
;3236:#if 0
;3237:	if (bs->inventory[INVENTORY_HEALTH] < 40) {
;3238:#else
;3239:	if (
;3240:		bs->cur_ps.stats[STAT_HEALTH] < 0.4 * bs->cur_ps.stats[STAT_MAX_HEALTH] &&
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1053609165
MULF4
GEF4 $852
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 828
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 2000
ADDI4
LEI4 $852
line 3242
;3241:		level.clients[bs->client].lasthurt_time > level.time + 2000
;3242:	) {
line 3244
;3243:#endif
;3244:		if (bs->inventory[INVENTORY_TELEPORTER] > 0) {
ADDRFP4 0
INDIRP4
CNSTI4 5080
ADDP4
INDIRI4
CNSTI4 0
LEI4 $855
line 3245
;3245:			if (!BotCTFCarryingFlag(bs)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $857
line 3250
;3246:#ifdef MISSIONPACK
;3247:				&& !Bot1FCTFCarryingFlag(bs)
;3248:				&& !BotHarvesterCarryingCubes(bs)
;3249:#endif
;3250:				) {
line 3251
;3251:				trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 3252
;3252:			}
LABELV $857
line 3253
;3253:		}
LABELV $855
line 3254
;3254:	}
LABELV $852
line 3259
;3255:	// JUHOX: item usage should also depend on max health
;3256:#if 0
;3257:	if (bs->inventory[INVENTORY_HEALTH] < 60) {
;3258:#else
;3259:	if (bs->cur_ps.stats[STAT_HEALTH] < 0.6 * bs->cur_ps.stats[STAT_MAX_HEALTH]) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1058642330
MULF4
GEF4 $859
line 3261
;3260:#endif
;3261:		if (bs->inventory[INVENTORY_MEDKIT] > 0) {
ADDRFP4 0
INDIRP4
CNSTI4 5084
ADDP4
INDIRI4
CNSTI4 0
LEI4 $861
line 3262
;3262:			trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 3263
;3263:		}
LABELV $861
line 3264
;3264:	}
LABELV $859
line 3269
;3265:#ifdef MISSIONPACK
;3266:	BotUseKamikaze(bs);
;3267:	BotUseInvulnerability(bs);
;3268:#endif
;3269:}
LABELV $851
endproc BotBattleUseItems 8 4
export BotSetTeleportTime
proc BotSetTeleportTime 8 0
line 3276
;3270:
;3271:/*
;3272:==================
;3273:BotSetTeleportTime
;3274:==================
;3275:*/
;3276:void BotSetTeleportTime(bot_state_t *bs) {
line 3277
;3277:	if ((bs->cur_ps.eFlags ^ bs->last_eFlags) & EF_TELEPORT_BIT) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 484
ADDP4
INDIRI4
BXORI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $864
line 3278
;3278:		bs->teleport_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7272
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 3279
;3279:		VectorCopy(bs->origin, bs->teleport_origin);	// JUHOX
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 7276
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 4916
ADDP4
INDIRB
ASGNB 12
line 3280
;3280:	}
LABELV $864
line 3281
;3281:	bs->last_eFlags = bs->cur_ps.eFlags;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 484
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
ASGNI4
line 3282
;3282:}
LABELV $863
endproc BotSetTeleportTime 8 0
export BotIsDead
proc BotIsDead 4 0
line 3289
;3283:
;3284:/*
;3285:==================
;3286:BotIsDead
;3287:==================
;3288:*/
;3289:qboolean BotIsDead(bot_state_t *bs) {
line 3294
;3290:	// JUHOX: use other death condition, dead players may have PM_SPECTATOR now
;3291:#if 0
;3292:	return (bs->cur_ps.pm_type == PM_DEAD);
;3293:#else
;3294:	return bs->cur_ps.stats[STAT_HEALTH] <= 0;
ADDRFP4 0
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
CNSTI4 0
GTI4 $868
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $869
JUMPV
LABELV $868
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $869
ADDRLP4 0
INDIRI4
RETI4
LABELV $866
endproc BotIsDead 4 0
export BotIsObserver
proc BotIsObserver 1032 12
line 3303
;3295:#endif
;3296:}
;3297:
;3298:/*
;3299:==================
;3300:BotIsObserver
;3301:==================
;3302:*/
;3303:qboolean BotIsObserver(bot_state_t *bs) {
line 3305
;3304:	char buf[MAX_INFO_STRING];
;3305:	if (bs->cur_ps.pm_type == PM_SPECTATOR) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 2
NEI4 $871
CNSTI4 1
RETI4
ADDRGP4 $870
JUMPV
LABELV $871
line 3306
;3306:	trap_GetConfigstring(CS_PLAYERS+bs->client, buf, sizeof(buf));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 3307
;3307:	if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) return qtrue;
ADDRLP4 0
ARGP4
ADDRGP4 $106
ARGP4
ADDRLP4 1024
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1024
INDIRP4
ARGP4
ADDRLP4 1028
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 3
NEI4 $873
CNSTI4 1
RETI4
ADDRGP4 $870
JUMPV
LABELV $873
line 3308
;3308:	return qfalse;
CNSTI4 0
RETI4
LABELV $870
endproc BotIsObserver 1032 12
export BotIntermission
proc BotIntermission 8 0
line 3316
;3309:}
;3310:
;3311:/*
;3312:==================
;3313:BotIntermission
;3314:==================
;3315:*/
;3316:qboolean BotIntermission(bot_state_t *bs) {
line 3318
;3317:	//NOTE: we shouldn't be looking at the game code...
;3318:	if (level.intermissiontime) return qtrue;
ADDRGP4 level+9144
INDIRI4
CNSTI4 0
EQI4 $876
CNSTI4 1
RETI4
ADDRGP4 $875
JUMPV
LABELV $876
line 3320
;3319:#if MEETING	// JUHOX: no AI during meeting
;3320:	if (bs->cur_ps.pm_type == PM_MEETING) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 7
NEI4 $879
CNSTI4 1
RETI4
ADDRGP4 $875
JUMPV
LABELV $879
line 3322
;3321:#endif
;3322:	return (bs->cur_ps.pm_type == PM_FREEZE || bs->cur_ps.pm_type == PM_INTERMISSION);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 4
EQI4 $884
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 5
NEI4 $882
LABELV $884
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $883
JUMPV
LABELV $882
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $883
ADDRLP4 0
INDIRI4
RETI4
LABELV $875
endproc BotIntermission 8 0
export BotInLavaOrSlime
proc BotInLavaOrSlime 16 4
line 3330
;3323:}
;3324:
;3325:/*
;3326:==================
;3327:BotInLavaOrSlime
;3328:==================
;3329:*/
;3330:qboolean BotInLavaOrSlime(bot_state_t *bs) {
line 3333
;3331:	vec3_t feet;
;3332:
;3333:	if (bs->travelLavaAndSlime_time > FloatTime()) return qtrue;	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 5988
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $886
CNSTI4 1
RETI4
ADDRGP4 $885
JUMPV
LABELV $886
line 3334
;3334:	VectorCopy(bs->origin, feet);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRB
ASGNB 12
line 3335
;3335:	feet[2] -= 23;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1102577664
SUBF4
ASGNF4
line 3336
;3336:	return (trap_AAS_PointContents(feet) & (CONTENTS_LAVA|CONTENTS_SLIME));
ADDRLP4 0
ARGP4
ADDRLP4 12
ADDRGP4 trap_AAS_PointContents
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 24
BANDI4
RETI4
LABELV $885
endproc BotInLavaOrSlime 16 4
data
align 4
LABELV $890
byte 4 3238002688
byte 4 3238002688
byte 4 3238002688
align 4
LABELV $891
byte 4 1090519040
byte 4 1090519040
byte 4 1090519040
export BotCreateWayPoint
code
proc BotCreateWayPoint 32 12
line 3344
;3337:}
;3338:
;3339:/*
;3340:==================
;3341:BotCreateWayPoint
;3342:==================
;3343:*/
;3344:bot_waypoint_t *BotCreateWayPoint(char *name, vec3_t origin, int areanum) {
line 3346
;3345:	bot_waypoint_t *wp;
;3346:	vec3_t waypointmins = {-8, -8, -8}, waypointmaxs = {8, 8, 8};
ADDRLP4 4
ADDRGP4 $890
INDIRB
ASGNB 12
ADDRLP4 16
ADDRGP4 $891
INDIRB
ASGNB 12
line 3348
;3347:
;3348:	wp = botai_freewaypoints;
ADDRLP4 0
ADDRGP4 botai_freewaypoints
INDIRP4
ASGNP4
line 3349
;3349:	if ( !wp ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $892
line 3350
;3350:		BotAI_Print( PRT_WARNING, "BotCreateWayPoint: Out of waypoints\n" );
CNSTI4 2
ARGI4
ADDRGP4 $894
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 3351
;3351:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $889
JUMPV
LABELV $892
line 3353
;3352:	}
;3353:	botai_freewaypoints = botai_freewaypoints->next;
ADDRLP4 28
ADDRGP4 botai_freewaypoints
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
ASGNP4
line 3355
;3354:
;3355:	Q_strncpyz( wp->name, name, sizeof(wp->name) );
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 3356
;3356:	VectorCopy(origin, wp->goal.origin);
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 3357
;3357:	VectorCopy(waypointmins, wp->goal.mins);
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
ADDRLP4 4
INDIRB
ASGNB 12
line 3358
;3358:	VectorCopy(waypointmaxs, wp->goal.maxs);
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
ADDRLP4 16
INDIRB
ASGNB 12
line 3359
;3359:	wp->goal.areanum = areanum;
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 3360
;3360:	wp->next = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
CNSTP4 0
ASGNP4
line 3361
;3361:	wp->prev = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
CNSTP4 0
ASGNP4
line 3362
;3362:	return wp;
ADDRLP4 0
INDIRP4
RETP4
LABELV $889
endproc BotCreateWayPoint 32 12
export BotFindWayPoint
proc BotFindWayPoint 8 8
line 3370
;3363:}
;3364:
;3365:/*
;3366:==================
;3367:BotFindWayPoint
;3368:==================
;3369:*/
;3370:bot_waypoint_t *BotFindWayPoint(bot_waypoint_t *waypoints, char *name) {
line 3373
;3371:	bot_waypoint_t *wp;
;3372:
;3373:	for (wp = waypoints; wp; wp = wp->next) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $899
JUMPV
LABELV $896
line 3374
;3374:		if (!Q_stricmp(wp->name, name)) return wp;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $900
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $895
JUMPV
LABELV $900
line 3375
;3375:	}
LABELV $897
line 3373
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
ASGNP4
LABELV $899
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $896
line 3376
;3376:	return NULL;
CNSTP4 0
RETP4
LABELV $895
endproc BotFindWayPoint 8 8
export BotFreeWaypoints
proc BotFreeWaypoints 4 0
line 3384
;3377:}
;3378:
;3379:/*
;3380:==================
;3381:BotFreeWaypoints
;3382:==================
;3383:*/
;3384:void BotFreeWaypoints(bot_waypoint_t *wp) {
line 3387
;3385:	bot_waypoint_t *nextwp;
;3386:
;3387:	for (; wp; wp = nextwp) {
ADDRGP4 $906
JUMPV
LABELV $903
line 3388
;3388:		nextwp = wp->next;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
ASGNP4
line 3389
;3389:		wp->next = botai_freewaypoints;
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ADDRGP4 botai_freewaypoints
INDIRP4
ASGNP4
line 3390
;3390:		botai_freewaypoints = wp;
ADDRGP4 botai_freewaypoints
ADDRFP4 0
INDIRP4
ASGNP4
line 3391
;3391:	}
LABELV $904
line 3387
ADDRFP4 0
ADDRLP4 0
INDIRP4
ASGNP4
LABELV $906
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $903
line 3392
;3392:}
LABELV $902
endproc BotFreeWaypoints 4 0
export BotInitWaypoints
proc BotInitWaypoints 4 0
line 3399
;3393:
;3394:/*
;3395:==================
;3396:BotInitWaypoints
;3397:==================
;3398:*/
;3399:void BotInitWaypoints(void) {
line 3402
;3400:	int i;
;3401:
;3402:	botai_freewaypoints = NULL;
ADDRGP4 botai_freewaypoints
CNSTP4 0
ASGNP4
line 3403
;3403:	for (i = 0; i < MAX_WAYPOINTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $908
line 3404
;3404:		botai_waypoints[i].next = botai_freewaypoints;
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 botai_waypoints+92
ADDP4
ADDRGP4 botai_freewaypoints
INDIRP4
ASGNP4
line 3405
;3405:		botai_freewaypoints = &botai_waypoints[i];
ADDRGP4 botai_freewaypoints
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 botai_waypoints
ADDP4
ASGNP4
line 3406
;3406:	}
LABELV $909
line 3403
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 128
LTI4 $908
line 3407
;3407:}
LABELV $907
endproc BotInitWaypoints 4 0
export TeamPlayIsOn
proc TeamPlayIsOn 4 0
line 3414
;3408:
;3409:/*
;3410:==================
;3411:TeamPlayIsOn
;3412:==================
;3413:*/
;3414:int TeamPlayIsOn(void) {
line 3415
;3415:	return ( gametype >= GT_TEAM );
ADDRGP4 gametype
INDIRI4
CNSTI4 3
LTI4 $915
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $916
JUMPV
LABELV $915
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $916
ADDRLP4 0
INDIRI4
RETI4
LABELV $913
endproc TeamPlayIsOn 4 0
export BotAggression
proc BotAggression 36 4
line 3423
;3416:}
;3417:
;3418:/*
;3419:==================
;3420:BotAggression
;3421:==================
;3422:*/
;3423:float BotAggression(bot_state_t *bs) {
line 3424
;3424:	if (bs->cur_ps.weaponTime > 1000) return 0;	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
CNSTI4 1000
LEI4 $918
CNSTF4 0
RETF4
ADDRGP4 $917
JUMPV
LABELV $918
line 3426
;3425:	//if the bot has quad
;3426:	if (bs->inventory[INVENTORY_QUAD]) {
ADDRFP4 0
INDIRP4
CNSTI4 5100
ADDP4
INDIRI4
CNSTI4 0
EQI4 $920
line 3434
;3427:#if 0	// JUHOX: quad now always makes aggressive (remove the only reference to ENEMY_HORIZONTAL_DIST)
;3428:		//if the bot is not holding the gauntlet or the enemy is really nearby
;3429:		if (bs->weaponnum != WP_GAUNTLET ||
;3430:			bs->inventory[ENEMY_HORIZONTAL_DIST] < 80) {
;3431:			return 70;
;3432:		}
;3433:#else
;3434:		return 100;
CNSTF4 1120403456
RETF4
ADDRGP4 $917
JUMPV
LABELV $920
line 3456
;3435:#endif
;3436:	}
;3437:#if 0	// JUHOX: don't check the enemy height, so we no longer depend on BotUpdateBattleInventory()
;3438:	//if the enemy is located way higher than the bot
;3439:	if (bs->inventory[ENEMY_HEIGHT] > 200) return 0;
;3440:#endif
;3441:#if 0	// JUHOX: take skill into account
;3442:	//if the bot is very low on health
;3443:	if (bs->inventory[INVENTORY_HEALTH] < 60) return 0;
;3444:	//if the bot is low on health
;3445:	if (bs->inventory[INVENTORY_HEALTH] < 80) {
;3446:		//if the bot has insufficient armor
;3447:		if (bs->inventory[INVENTORY_ARMOR] < 40) return 0;
;3448:	}
;3449:#else
;3450:	/*
;3451:	if (bs->inventory[INVENTORY_HEALTH] < 0.6 * bs->cur_ps.stats[STAT_MAX_HEALTH]) return 0;
;3452:	if (bs->inventory[INVENTORY_HEALTH] < 0.8 * bs->cur_ps.stats[STAT_MAX_HEALTH]) {
;3453:		if (bs->inventory[INVENTORY_ARMOR] < 0.4 * bs->cur_ps.stats[STAT_MAX_HEALTH]) return 0;
;3454:	}
;3455:	*/
;3456:	if (BotPlayerDanger(&bs->cur_ps) >= 25) return 0;
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 BotPlayerDanger
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 25
LTI4 $922
CNSTF4 0
RETF4
ADDRGP4 $917
JUMPV
LABELV $922
line 3458
;3457:#endif
;3458:	if (g_unlimitedAmmo.integer) return 100;	// JUHOX
ADDRGP4 g_unlimitedAmmo+12
INDIRI4
CNSTI4 0
EQI4 $924
CNSTF4 1120403456
RETF4
ADDRGP4 $917
JUMPV
LABELV $924
line 3460
;3459:	//if the bot can use the bfg
;3460:	if (bs->inventory[INVENTORY_BFG10K] > 0 &&
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 5012
ADDP4
INDIRI4
CNSTI4 0
LEI4 $927
ADDRLP4 4
INDIRP4
CNSTI4 5060
ADDP4
INDIRI4
CNSTI4 1
LEI4 $927
line 3461
;3461:			bs->inventory[INVENTORY_BFGAMMO] > /*7*/1) return 100;	// JUHOX
CNSTF4 1120403456
RETF4
ADDRGP4 $917
JUMPV
LABELV $927
line 3463
;3462:	//if the bot can use the railgun
;3463:	if (bs->inventory[INVENTORY_RAILGUN] > 0 &&
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 5000
ADDP4
INDIRI4
CNSTI4 0
LEI4 $929
ADDRLP4 8
INDIRP4
CNSTI4 5056
ADDP4
INDIRI4
CNSTI4 1
LEI4 $929
line 3464
;3464:			bs->inventory[INVENTORY_SLUGS] > /*5*/1) return 95;	// JUHOX
CNSTF4 1119748096
RETF4
ADDRGP4 $917
JUMPV
LABELV $929
line 3466
;3465:	//if the bot can use the lightning gun
;3466:	if (bs->inventory[INVENTORY_LIGHTNING] > 0 &&
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 4996
ADDP4
INDIRI4
CNSTI4 0
LEI4 $931
ADDRLP4 12
INDIRP4
CNSTI4 5048
ADDP4
INDIRI4
CNSTI4 50
LEI4 $931
line 3467
;3467:			bs->inventory[INVENTORY_LIGHTNINGAMMO] > 50) return 90;
CNSTF4 1119092736
RETF4
ADDRGP4 $917
JUMPV
LABELV $931
line 3469
;3468:	//if the bot can use the rocketlauncher
;3469:	if (bs->inventory[INVENTORY_ROCKETLAUNCHER] > 0 &&
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 4992
ADDP4
INDIRI4
CNSTI4 0
LEI4 $933
ADDRLP4 16
INDIRP4
CNSTI4 5052
ADDP4
INDIRI4
CNSTI4 2
LEI4 $933
line 3470
;3470:			bs->inventory[INVENTORY_ROCKETS] > /*5*/2) return 90;	// JUHOX
CNSTF4 1119092736
RETF4
ADDRGP4 $917
JUMPV
LABELV $933
line 3471
;3471:	if (bs->inventory[INVENTORY_MACHINEGUN] > 0 && bs->inventory[INVENTORY_BULLETS] > 14) return 85;	// JUHOX
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 4984
ADDP4
INDIRI4
CNSTI4 0
LEI4 $935
ADDRLP4 20
INDIRP4
CNSTI4 5036
ADDP4
INDIRI4
CNSTI4 14
LEI4 $935
CNSTF4 1118437376
RETF4
ADDRGP4 $917
JUMPV
LABELV $935
line 3473
;3472:	//if the bot can use the plasmagun
;3473:	if (bs->inventory[INVENTORY_PLASMAGUN] > 0 &&
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 5004
ADDP4
INDIRI4
CNSTI4 0
LEI4 $937
ADDRLP4 24
INDIRP4
CNSTI4 5044
ADDP4
INDIRI4
CNSTI4 40
LEI4 $937
line 3474
;3474:			bs->inventory[INVENTORY_CELLS] > 40) return 85;
CNSTF4 1118437376
RETF4
ADDRGP4 $917
JUMPV
LABELV $937
line 3476
;3475:	//if the bot can use the grenade launcher
;3476:	if (bs->inventory[INVENTORY_GRENADELAUNCHER] > 0 &&
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 4988
ADDP4
INDIRI4
CNSTI4 0
LEI4 $939
ADDRLP4 28
INDIRP4
CNSTI4 5040
ADDP4
INDIRI4
CNSTI4 10
LEI4 $939
line 3477
;3477:			bs->inventory[INVENTORY_GRENADES] > 10) return 80;
CNSTF4 1117782016
RETF4
ADDRGP4 $917
JUMPV
LABELV $939
line 3479
;3478:	//if the bot can use the shotgun
;3479:	if (bs->inventory[INVENTORY_SHOTGUN] > 0 &&
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 4980
ADDP4
INDIRI4
CNSTI4 0
LEI4 $941
ADDRLP4 32
INDIRP4
CNSTI4 5032
ADDP4
INDIRI4
CNSTI4 2
LEI4 $941
line 3480
;3480:			bs->inventory[INVENTORY_SHELLS] > /*10*/2) return 50;	// JUHOX
CNSTF4 1112014848
RETF4
ADDRGP4 $917
JUMPV
LABELV $941
line 3482
;3481:	//otherwise the bot is not feeling too good
;3482:	return 0;
CNSTF4 0
RETF4
LABELV $917
endproc BotAggression 36 4
export BotFeelingBad
proc BotFeelingBad 0 0
line 3490
;3483:}
;3484:
;3485:/*
;3486:==================
;3487:BotFeelingBad
;3488:==================
;3489:*/
;3490:float BotFeelingBad(bot_state_t *bs) {
line 3491
;3491:	if (bs->weaponnum == WP_GAUNTLET) {
ADDRFP4 0
INDIRP4
CNSTI4 7804
ADDP4
INDIRI4
CNSTI4 1
NEI4 $944
line 3492
;3492:		return 100;
CNSTF4 1120403456
RETF4
ADDRGP4 $943
JUMPV
LABELV $944
line 3494
;3493:	}
;3494:	if (bs->inventory[INVENTORY_HEALTH] < 40) {
ADDRFP4 0
INDIRP4
CNSTI4 5076
ADDP4
INDIRI4
CNSTI4 40
GEI4 $946
line 3495
;3495:		return 100;
CNSTF4 1120403456
RETF4
ADDRGP4 $943
JUMPV
LABELV $946
line 3497
;3496:	}
;3497:	if (bs->weaponnum == WP_MACHINEGUN) {
ADDRFP4 0
INDIRP4
CNSTI4 7804
ADDP4
INDIRI4
CNSTI4 2
NEI4 $948
line 3498
;3498:		return 90;
CNSTF4 1119092736
RETF4
ADDRGP4 $943
JUMPV
LABELV $948
line 3500
;3499:	}
;3500:	if (bs->inventory[INVENTORY_HEALTH] < 60) {
ADDRFP4 0
INDIRP4
CNSTI4 5076
ADDP4
INDIRI4
CNSTI4 60
GEI4 $950
line 3501
;3501:		return 80;
CNSTF4 1117782016
RETF4
ADDRGP4 $943
JUMPV
LABELV $950
line 3503
;3502:	}
;3503:	return 0;
CNSTF4 0
RETF4
LABELV $943
endproc BotFeelingBad 0 0
export BotEnemyTooStrong
proc BotEnemyTooStrong 516 12
line 3511
;3504:}
;3505:
;3506:/*
;3507:==================
;3508:JUHOX: BotEnemyTooStrong
;3509:==================
;3510:*/
;3511:qboolean BotEnemyTooStrong(bot_state_t* bs) {
line 3517
;3512:	int player;
;3513:	playerState_t ps;
;3514:	int numTotalTeammates, numVisTeammates;
;3515:	int numTotalEnemies, numVisEnemies;
;3516:
;3517:	if (gametype < GT_TEAM) return qfalse;
ADDRGP4 gametype
INDIRI4
CNSTI4 3
GEI4 $953
CNSTI4 0
RETI4
ADDRGP4 $952
JUMPV
LABELV $953
line 3519
;3518:#if MONSTER_MODE	// JUHOX FIXME: enemy never too strong in STU?
;3519:	if (gametype == GT_STU) return qfalse;
ADDRGP4 gametype
INDIRI4
CNSTI4 8
NEI4 $955
CNSTI4 0
RETI4
ADDRGP4 $952
JUMPV
LABELV $955
line 3522
;3520:#endif
;3521:
;3522:	if (bs->enemy < 0 && bs->cur_ps.stats[STAT_HEALTH] > 0) {
ADDRLP4 488
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 488
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 0
GEI4 $957
ADDRLP4 488
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
CNSTI4 0
LEI4 $957
line 3523
;3523:		if (bs->enemytoostrong) {
ADDRFP4 0
INDIRP4
CNSTI4 7796
ADDP4
INDIRI4
CNSTI4 0
EQI4 $959
line 3524
;3524:			if (bs->enemytoostrong_time + 1 > FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 7800
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
ADDRGP4 floattime
INDIRF4
LEF4 $961
line 3525
;3525:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $952
JUMPV
LABELV $961
line 3527
;3526:			}
;3527:			bs->enemytoostrong = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 7796
ADDP4
CNSTI4 0
ASGNI4
line 3528
;3528:			bs->enemytoostrong_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7800
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 3529
;3529:		}
LABELV $959
line 3530
;3530:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $952
JUMPV
LABELV $957
line 3533
;3531:	}
;3532:
;3533:	if (bs->enemytoostrong_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 7800
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $963
line 3534
;3534:		bs->enemytoostrong_time = FloatTime() + 0.5 + 0.5*random();
ADDRLP4 492
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRFP4 0
INDIRP4
CNSTI4 7800
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1056964608
ADDF4
ADDRLP4 492
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 492
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1056964608
MULF4
ADDF4
ASGNF4
line 3536
;3535:
;3536:		BotDetermineVisibleTeammates(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotDetermineVisibleTeammates
CALLV
pop
line 3538
;3537:
;3538:		numTotalTeammates = numVisTeammates = 1;	// the bot itself
ADDRLP4 496
CNSTI4 1
ASGNI4
ADDRLP4 484
ADDRLP4 496
INDIRI4
ASGNI4
ADDRLP4 476
ADDRLP4 496
INDIRI4
ASGNI4
line 3539
;3539:		numTotalEnemies = numVisEnemies = 0;
ADDRLP4 500
CNSTI4 0
ASGNI4
ADDRLP4 480
ADDRLP4 500
INDIRI4
ASGNI4
ADDRLP4 472
ADDRLP4 500
INDIRI4
ASGNI4
line 3540
;3540:		for (player = -1; (player = BotGetNextPlayer(bs, player, &ps)) >= 0; ) {
ADDRLP4 468
CNSTI4 -1
ASGNI4
ADDRGP4 $968
JUMPV
LABELV $965
line 3543
;3541:			qboolean vis;
;3542:
;3543:			if (bs->cur_ps.persistant[PERS_TEAM] == ps.persistant[PERS_TEAM]) {
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ADDRLP4 0+248+12
INDIRI4
NEI4 $969
line 3544
;3544:				numTotalTeammates++;
ADDRLP4 476
ADDRLP4 476
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3545
;3545:				continue;
ADDRGP4 $966
JUMPV
LABELV $969
line 3547
;3546:			}
;3547:			numTotalEnemies++;
ADDRLP4 472
ADDRLP4 472
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3548
;3548:			if (ps.stats[STAT_HEALTH] <= 0) {
ADDRLP4 0+184
INDIRI4
CNSTI4 0
GTI4 $973
line 3549
;3549:				vis = qfalse;
ADDRLP4 504
CNSTI4 0
ASGNI4
line 3550
;3550:			}
ADDRGP4 $974
JUMPV
LABELV $973
line 3551
;3551:			else {
line 3552
;3552:				vis = (BotEntityVisible(&bs->cur_ps, 90, player) > 0);
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTF4 1119092736
ARGF4
ADDRLP4 468
INDIRI4
ARGI4
ADDRLP4 512
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 512
INDIRF4
CNSTF4 0
LEF4 $977
ADDRLP4 508
CNSTI4 1
ASGNI4
ADDRGP4 $978
JUMPV
LABELV $977
ADDRLP4 508
CNSTI4 0
ASGNI4
LABELV $978
ADDRLP4 504
ADDRLP4 508
INDIRI4
ASGNI4
line 3553
;3553:			}
LABELV $974
line 3554
;3554:			if (vis) numVisEnemies++;
ADDRLP4 504
INDIRI4
CNSTI4 0
EQI4 $979
ADDRLP4 480
ADDRLP4 480
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $979
line 3555
;3555:		}
LABELV $966
line 3540
LABELV $968
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 468
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 504
ADDRGP4 BotGetNextPlayer
CALLI4
ASGNI4
ADDRLP4 468
ADDRLP4 504
INDIRI4
ASGNI4
ADDRLP4 504
INDIRI4
CNSTI4 0
GEI4 $965
line 3557
;3556:
;3557:		numVisTeammates += bs->numvisteammates;
ADDRLP4 484
ADDRLP4 484
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 12180
ADDP4
INDIRI4
ADDI4
ASGNI4
line 3559
;3558:
;3559:		bs->enemytoostrong = (numVisEnemies * numTotalTeammates > numVisTeammates * numTotalEnemies);
ADDRLP4 480
INDIRI4
ADDRLP4 476
INDIRI4
MULI4
ADDRLP4 484
INDIRI4
ADDRLP4 472
INDIRI4
MULI4
LEI4 $982
ADDRLP4 508
CNSTI4 1
ASGNI4
ADDRGP4 $983
JUMPV
LABELV $982
ADDRLP4 508
CNSTI4 0
ASGNI4
LABELV $983
ADDRFP4 0
INDIRP4
CNSTI4 7796
ADDP4
ADDRLP4 508
INDIRI4
ASGNI4
line 3560
;3560:	}
LABELV $963
line 3561
;3561:	return bs->enemytoostrong;
ADDRFP4 0
INDIRP4
CNSTI4 7796
ADDP4
INDIRI4
RETI4
LABELV $952
endproc BotEnemyTooStrong 516 12
export BotWantsToEscape
proc BotWantsToEscape 28 12
line 3569
;3562:}
;3563:
;3564:/*
;3565:==================
;3566:JUHOX: BotWantsToEscape
;3567:==================
;3568:*/
;3569:int BotWantsToEscape(bot_state_t *bs) {
line 3570
;3570:	if (BotCTFCarryingFlag(bs) && !NearHomeBase(bs->cur_ps.persistant[PERS_TEAM], bs->origin, 9)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $985
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
CNSTF4 1091567616
ARGF4
ADDRLP4 8
ADDRGP4 NearHomeBase
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $985
CNSTI4 0
RETI4
ADDRGP4 $984
JUMPV
LABELV $985
line 3572
;3571:#if BOTS_USE_TSS
;3572:	if (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_isValid)) {
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 12
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $987
line 3573
;3573:		if (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_groupMemberStatus) != TSSGMS_retreating) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 16
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $989
CNSTI4 0
RETI4
ADDRGP4 $984
JUMPV
LABELV $989
line 3574
;3574:	}
LABELV $987
line 3576
;3575:#endif
;3576:	if (bs->enemy < 0) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 0
GEI4 $991
CNSTI4 0
RETI4
ADDRGP4 $984
JUMPV
LABELV $991
line 3578
;3577:#if MONSTER_MODE
;3578:	if (g_gametype.integer == GT_STU && G_NumMonsters() > 15) return qfalse;	// if too many monsters, it's safer to stay
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
NEI4 $993
ADDRLP4 16
ADDRGP4 G_NumMonsters
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 15
LEI4 $993
CNSTI4 0
RETI4
ADDRGP4 $984
JUMPV
LABELV $993
line 3580
;3579:#endif
;3580:	if (BotPlayerDanger(&bs->cur_ps) >= 70) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 20
ADDRGP4 BotPlayerDanger
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 70
LTI4 $996
CNSTI4 1
RETI4
ADDRGP4 $984
JUMPV
LABELV $996
line 3581
;3581:	if (BotEnemyTooStrong(bs)) return qtrue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 BotEnemyTooStrong
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $998
CNSTI4 1
RETI4
ADDRGP4 $984
JUMPV
LABELV $998
line 3582
;3582:	return qfalse;
CNSTI4 0
RETI4
LABELV $984
endproc BotWantsToEscape 28 12
export BotWantsToRetreat
proc BotWantsToRetreat 632 12
line 3590
;3583:}
;3584:
;3585:/*
;3586:==================
;3587:BotWantsToRetreat
;3588:==================
;3589:*/
;3590:int BotWantsToRetreat(bot_state_t *bs) {
line 3594
;3591:	aas_entityinfo_t entinfo;
;3592:
;3593:#if 1	// JUHOX: return cached value if possible
;3594:	if (bs->wantsToRetreat_time == FloatTime()) return bs->wantsToRetreat;
ADDRFP4 0
INDIRP4
CNSTI4 7792
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
NEF4 $1001
ADDRFP4 0
INDIRP4
CNSTI4 7788
ADDP4
INDIRI4
RETI4
ADDRGP4 $1000
JUMPV
LABELV $1001
line 3595
;3595:	bs->wantsToRetreat = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 7788
ADDP4
CNSTI4 1
ASGNI4
line 3596
;3596:	bs->wantsToRetreat_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7792
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 3599
;3597:#endif
;3598:#if 1	// JUHOX: retreat when standing in lava or slime
;3599:	if (bs->tfl & (TFL_LAVA|TFL_SLIME)) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 5984
ADDP4
INDIRI4
CNSTI4 6291456
BANDI4
CNSTI4 0
EQI4 $1003
CNSTI4 1
RETI4
ADDRGP4 $1000
JUMPV
LABELV $1003
line 3601
;3600:#endif
;3601:	if (BotWantsToEscape(bs)) return qtrue;	// JUHOX
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotWantsToEscape
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $1005
CNSTI4 1
RETI4
ADDRGP4 $1000
JUMPV
LABELV $1005
line 3602
;3602:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $1007
line 3604
;3603:		//always retreat when carrying a CTF flag
;3604:		if (BotCTFCarryingFlag(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 144
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $1009
line 3605
;3605:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1000
JUMPV
LABELV $1009
line 3606
;3606:	}
LABELV $1007
line 3608
;3607:#if BOTS_USE_TSS	// JUHOX: if the TSS is active, only retreat when said to
;3608:	if (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_isValid)) {
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 144
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $1011
line 3609
;3609:		if (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_groupMemberStatus) == TSSGMS_retreating) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 148
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $1013
CNSTI4 1
RETI4
ADDRGP4 $1000
JUMPV
LABELV $1013
line 3610
;3610:		if (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_missionStatus) == TSSMS_aborted) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 152
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 1
NEI4 $1015
CNSTI4 1
RETI4
ADDRGP4 $1000
JUMPV
LABELV $1015
line 3611
;3611:		switch (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_mission)) {
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTI4 3
ARGI4
ADDRLP4 160
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 156
ADDRLP4 160
INDIRI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 1
LTI4 $1034
ADDRLP4 156
INDIRI4
CNSTI4 6
GTI4 $1034
ADDRLP4 156
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1032-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1032
address $1034
address $1020
address $1020
address $1021
address $1025
address $1028
code
LABELV $1020
line 3614
;3612:		case TSSMISSION_seek_items:
;3613:		case TSSMISSION_capture_enemy_flag:
;3614:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1000
JUMPV
LABELV $1021
line 3617
;3615:		case TSSMISSION_defend_our_flag:
;3616:			if (
;3617:				BotOwnFlagStatus(bs) != FLAG_ATBASE ||
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 168
ADDRGP4 BotOwnFlagStatus
CALLI4
ASGNI4
ADDRLP4 168
INDIRI4
CNSTI4 0
NEI4 $1024
ADDRLP4 172
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 172
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ARGI4
ADDRLP4 172
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
CNSTF4 1091567616
ARGF4
ADDRLP4 176
ADDRGP4 NearHomeBase
CALLI4
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 0
NEI4 $1034
LABELV $1024
line 3619
;3618:				!NearHomeBase(bs->cur_ps.persistant[PERS_TEAM], bs->origin, 9)
;3619:			) {
line 3620
;3620:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1000
JUMPV
line 3622
;3621:			}
;3622:			break;
LABELV $1025
line 3624
;3623:		case TSSMISSION_defend_our_base:
;3624:			if (!NearHomeBase(bs->cur_ps.persistant[PERS_TEAM], bs->origin, 4)) {
ADDRLP4 180
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 180
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ARGI4
ADDRLP4 180
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
CNSTF4 1082130432
ARGF4
ADDRLP4 184
ADDRGP4 NearHomeBase
CALLI4
ASGNI4
ADDRLP4 184
INDIRI4
CNSTI4 0
NEI4 $1034
line 3625
;3625:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1000
JUMPV
line 3627
;3626:			}
;3627:			break;
LABELV $1028
line 3629
;3628:		case TSSMISSION_occupy_enemy_base:
;3629:			if (!NearHomeBase(OtherTeam(bs->cur_ps.persistant[PERS_TEAM]), bs->origin, 2)) {
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ARGI4
ADDRLP4 188
ADDRGP4 OtherTeam
CALLI4
ASGNI4
ADDRLP4 188
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
CNSTF4 1073741824
ARGF4
ADDRLP4 192
ADDRGP4 NearHomeBase
CALLI4
ASGNI4
ADDRLP4 192
INDIRI4
CNSTI4 0
NEI4 $1034
line 3630
;3630:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1000
JUMPV
line 3632
;3631:			}
;3632:			break;
line 3634
;3633:		case TSSMISSION_seek_enemy:
;3634:			break;
line 3636
;3635:		}
;3636:		goto NoRetreat;
LABELV $1011
line 3664
;3637:	}
;3638:#endif
;3639:#ifdef MISSIONPACK
;3640:	else if (gametype == GT_1FCTF) {
;3641:		//if carrying the flag then always retreat
;3642:		if (Bot1FCTFCarryingFlag(bs))
;3643:			return qtrue;
;3644:	}
;3645:	else if (gametype == GT_OBELISK) {
;3646:		//the bots should be dedicated to attacking the enemy obelisk
;3647:		if (bs->ltgtype == LTG_ATTACKENEMYBASE) {
;3648:			if (bs->enemy != redobelisk.entitynum /*||*/&&	// JUHOX BUGFIX
;3649:						bs->enemy != blueobelisk.entitynum) {
;3650:				return qtrue;
;3651:			}
;3652:		}
;3653:		if (BotFeelingBad(bs) > 50) {
;3654:			return qtrue;
;3655:		}
;3656:		/*return qfalse;*/goto NoRetreat;	// JUHOX
;3657:	}
;3658:	else if (gametype == GT_HARVESTER) {
;3659:		//if carrying cubes then always retreat
;3660:		if (BotHarvesterCarryingCubes(bs)) return qtrue;
;3661:	}
;3662:#endif
;3663:	//
;3664:	if (bs->enemy >= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 0
LTI4 $1035
line 3666
;3665:		//if the enemy is carrying a flag
;3666:		BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3667
;3667:		if (EntityCarriesFlag(&entinfo))
ADDRLP4 0
ARGP4
ADDRLP4 148
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
EQI4 $1037
line 3668
;3668:			/*return qfalse;*/goto NoRetreat;	// JUHOX
ADDRGP4 $1034
JUMPV
LABELV $1037
line 3669
;3669:	}
LABELV $1035
line 3671
;3670:	//if the bot is getting the flag
;3671:	if (bs->ltgtype == LTG_GETFLAG)
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 4
NEI4 $1039
line 3672
;3672:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1000
JUMPV
LABELV $1039
line 3675
;3673:	//
;3674:#if 1	// JUHOX: retreat if helping someone
;3675:	if (bs->ltgtype == LTG_TEAMHELP) {
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1041
line 3678
;3676:		playerState_t ps;
;3677:
;3678:		if (BotAI_GetClientState(bs->teammate, &ps)) {
ADDRFP4 0
INDIRP4
CNSTI4 11560
ADDP4
INDIRI4
ARGI4
ADDRLP4 148
ARGP4
ADDRLP4 616
ADDRGP4 BotAI_GetClientState
CALLI4
ASGNI4
ADDRLP4 616
INDIRI4
CNSTI4 0
EQI4 $1043
line 3681
;3679:			float maxDistanceSqr;
;3680:
;3681:			maxDistanceSqr = g_gametype.integer == GT_CTF? Square(300) : Square(500);
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $1047
ADDRLP4 624
CNSTI4 90000
ASGNI4
ADDRGP4 $1048
JUMPV
LABELV $1047
ADDRLP4 624
CNSTI4 250000
ASGNI4
LABELV $1048
ADDRLP4 620
ADDRLP4 624
INDIRI4
CVIF4 4
ASGNF4
line 3682
;3682:			if (DistanceSquared(bs->origin, ps.origin) > maxDistanceSqr) {
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 148+20
ARGP4
ADDRLP4 628
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 628
INDIRF4
ADDRLP4 620
INDIRF4
LEF4 $1049
line 3683
;3683:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1000
JUMPV
LABELV $1049
line 3685
;3684:			}
;3685:		}
LABELV $1043
line 3686
;3686:	}
LABELV $1041
line 3688
;3687:#endif
;3688:	if (BotAggression(bs) < 50)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 148
ADDRGP4 BotAggression
CALLF4
ASGNF4
ADDRLP4 148
INDIRF4
CNSTF4 1112014848
GEF4 $1052
line 3689
;3689:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1000
JUMPV
LABELV $1052
LABELV $1034
line 3692
;3690:#if 1	// JUHOX: bot doesn't want to retreat
;3691:	NoRetreat:
;3692:	bs->wantsToRetreat = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 7788
ADDP4
CNSTI4 0
ASGNI4
line 3694
;3693:#endif
;3694:	return qfalse;
CNSTI4 0
RETI4
LABELV $1000
endproc BotWantsToRetreat 632 12
export BotWantsToFight
proc BotWantsToFight 504 12
line 3702
;3695:}
;3696:
;3697:/*
;3698:==================
;3699:JUHOX: BotWantsToFight
;3700:==================
;3701:*/
;3702:int BotWantsToFight(bot_state_t *bs, int enemy, qboolean indirectVis) {
line 3705
;3703:	playerState_t ps;
;3704:
;3705:	if (!BotAI_GetClientState(enemy, &ps)) return qfalse;
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 468
ADDRGP4 BotAI_GetClientState
CALLI4
ASGNI4
ADDRLP4 468
INDIRI4
CNSTI4 0
NEI4 $1055
CNSTI4 0
RETI4
ADDRGP4 $1054
JUMPV
LABELV $1055
line 3707
;3706:#if MONSTER_MODE
;3707:	if (g_entities[enemy].monster && !IsFightingMonster(&g_entities[enemy])) return qfalse;
ADDRLP4 472
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 472
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1057
ADDRLP4 472
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 476
ADDRGP4 IsFightingMonster
CALLI4
ASGNI4
ADDRLP4 476
INDIRI4
CNSTI4 0
NEI4 $1057
CNSTI4 0
RETI4
ADDRGP4 $1054
JUMPV
LABELV $1057
line 3710
;3708:#endif
;3709:
;3710:	if (g_gametype.integer == GT_CTF) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $1060
line 3711
;3711:		if (bs->ltgtype == LTG_RETURNFLAG) {
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 6
NEI4 $1063
line 3712
;3712:			if (ps.powerups[PW_REDFLAG] || ps.powerups[PW_BLUEFLAG]) return qtrue;
ADDRLP4 0+312+28
INDIRI4
CNSTI4 0
NEI4 $1071
ADDRLP4 0+312+32
INDIRI4
CNSTI4 0
EQI4 $1065
LABELV $1071
CNSTI4 1
RETI4
ADDRGP4 $1054
JUMPV
LABELV $1065
line 3713
;3713:			if (enemy == bs->blockingEnemy) return qtrue;
ADDRFP4 4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 7320
ADDP4
INDIRI4
NEI4 $1072
CNSTI4 1
RETI4
ADDRGP4 $1054
JUMPV
LABELV $1072
line 3714
;3714:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1054
JUMPV
LABELV $1063
line 3717
;3715:		}
;3716:#if BOTS_USE_TSS
;3717:		if (!BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_isValid)) {
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 480
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 480
INDIRI4
CNSTI4 0
NEI4 $1074
line 3722
;3718:#else
;3719:		{
;3720:#endif
;3721:			if (
;3722:				!bs->ltgtype ||
ADDRLP4 484
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 484
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1078
ADDRLP4 484
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1076
LABELV $1078
line 3724
;3723:				bs->ltgtype == LTG_TEAMHELP
;3724:			) {
line 3726
;3725:				if (
;3726:					!IsPlayerFighting(enemy) &&
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 488
ADDRGP4 IsPlayerFighting
CALLI4
ASGNI4
ADDRLP4 488
INDIRI4
CNSTI4 0
NEI4 $1077
ADDRLP4 0+312+28
INDIRI4
CNSTI4 0
NEI4 $1077
ADDRLP4 0+312+32
INDIRI4
CNSTI4 0
NEI4 $1077
ADDRLP4 492
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 4
INDIRI4
ADDRLP4 492
INDIRP4
CNSTI4 7320
ADDP4
INDIRI4
EQI4 $1077
ADDRLP4 492
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ARGI4
ADDRLP4 492
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
CNSTF4 1082130432
ARGF4
ADDRLP4 496
ADDRGP4 NearHomeBase
CALLI4
ASGNI4
ADDRLP4 496
INDIRI4
CNSTI4 0
NEI4 $1077
line 3731
;3727:					!ps.powerups[PW_REDFLAG] &&
;3728:					!ps.powerups[PW_BLUEFLAG] &&
;3729:					enemy != bs->blockingEnemy &&
;3730:					!NearHomeBase(bs->cur_ps.persistant[PERS_TEAM], bs->origin, 4)
;3731:				) return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1054
JUMPV
line 3732
;3732:			}
LABELV $1076
line 3733
;3733:			else if (bs->leader == bs->client) {
ADDRLP4 488
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 488
INDIRP4
CNSTI4 11872
ADDP4
INDIRI4
ADDRLP4 488
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1085
line 3735
;3734:				if (
;3735:					BotOwnFlagStatus(bs) == FLAG_TAKEN ||
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 492
ADDRGP4 BotOwnFlagStatus
CALLI4
ASGNI4
ADDRLP4 492
INDIRI4
CNSTI4 1
EQI4 $1089
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 496
ADDRGP4 BotEnemyFlagStatus
CALLI4
ASGNI4
ADDRLP4 496
INDIRI4
CNSTI4 1
EQI4 $1087
LABELV $1089
line 3737
;3736:					BotEnemyFlagStatus(bs) != FLAG_TAKEN
;3737:				) {
line 3739
;3738:					if (
;3739:						!IsPlayerFighting(enemy) &&
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 500
ADDRGP4 IsPlayerFighting
CALLI4
ASGNI4
ADDRLP4 500
INDIRI4
CNSTI4 0
NEI4 $1090
ADDRLP4 0+312+28
INDIRI4
CNSTI4 0
NEI4 $1090
ADDRLP4 0+312+32
INDIRI4
CNSTI4 0
NEI4 $1090
ADDRFP4 4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 7320
ADDP4
INDIRI4
EQI4 $1090
line 3743
;3740:						!ps.powerups[PW_REDFLAG] &&
;3741:						!ps.powerups[PW_BLUEFLAG] &&
;3742:						enemy != bs->blockingEnemy
;3743:					) return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1054
JUMPV
LABELV $1090
line 3744
;3744:				}
LABELV $1087
line 3745
;3745:			}
LABELV $1085
LABELV $1077
line 3746
;3746:		}
LABELV $1074
line 3747
;3747:	}
LABELV $1060
line 3750
;3748:
;3749:	if (
;3750:		indirectVis ||
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $1102
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 480
ADDRGP4 IsPlayerFighting
CALLI4
ASGNI4
ADDRLP4 480
INDIRI4
CNSTI4 0
NEI4 $1096
ADDRLP4 0+312+28
INDIRI4
CNSTI4 0
NEI4 $1096
ADDRLP4 0+312+32
INDIRI4
CNSTI4 0
NEI4 $1096
LABELV $1102
line 3756
;3751:		(
;3752:			!IsPlayerFighting(enemy) &&
;3753:			!ps.powerups[PW_REDFLAG] &&
;3754:			!ps.powerups[PW_BLUEFLAG]
;3755:		)
;3756:	) {
line 3757
;3757:		if (enemy == bs->blockingEnemy) return qtrue;
ADDRFP4 4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 7320
ADDP4
INDIRI4
NEI4 $1103
CNSTI4 1
RETI4
ADDRGP4 $1054
JUMPV
LABELV $1103
line 3758
;3758:		if (bs->ltgtype == LTG_ESCAPE) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 16
NEI4 $1105
CNSTI4 0
RETI4
ADDRGP4 $1054
JUMPV
LABELV $1105
line 3760
;3759:#if MONSTER_MODE
;3760:		if (G_IsMonsterSuccessfulAttacking(&g_entities[enemy], &g_entities[bs->entitynum])) return qtrue;
ADDRLP4 484
ADDRGP4 g_entities
ASGNP4
ADDRFP4 4
INDIRI4
CNSTI4 844
MULI4
ADDRLP4 484
INDIRP4
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRLP4 484
INDIRP4
ADDP4
ARGP4
ADDRLP4 488
ADDRGP4 G_IsMonsterSuccessfulAttacking
CALLI4
ASGNI4
ADDRLP4 488
INDIRI4
CNSTI4 0
EQI4 $1107
CNSTI4 1
RETI4
ADDRGP4 $1054
JUMPV
LABELV $1107
line 3799
;3761:#endif
;3762:		/*
;3763:		if (bs->cur_ps.powerups[PW_REDFLAG] || bs->cur_ps.powerups[PW_BLUEFLAG]) return qfalse;
;3764:#if BOTS_USE_TSS
;3765:		if (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_isValid)) {
;3766:			if (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_missionStatus) == TSSMS_aborted) return qfalse;
;3767:			switch (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_mission)) {
;3768:			case TSSMISSION_seek_enemy:
;3769:				return qtrue;
;3770:			case TSSMISSION_seek_items:
;3771:				return qfalse;
;3772:			case TSSMISSION_capture_enemy_flag:
;3773:				if (
;3774:					BotEnemyFlagStatus(bs) == FLAG_ATBASE &&
;3775:					!NearHomeBase(ps.persistant[PERS_TEAM], bs->origin, 9)
;3776:				) {
;3777:					return qfalse;
;3778:				}
;3779:				return qtrue;
;3780:			case TSSMISSION_defend_our_flag:
;3781:				if (
;3782:					BotOwnFlagStatus(bs) != FLAG_ATBASE &&
;3783:					!ps.powerups[PW_REDFLAG] &&
;3784:					!ps.powerups[PW_BLUEFLAG]
;3785:				) {
;3786:					return qfalse;
;3787:				}
;3788:				break;
;3789:			case TSSMISSION_defend_our_base:
;3790:			case TSSMISSION_occupy_enemy_base:
;3791:				if (indirectVis) return qfalse;
;3792:				break;
;3793:			}
;3794:			if (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_task) == TSSMT_fulfilMission) return qtrue;
;3795:			if (BG_TSS_GetPlayerInfo(&bs->cur_ps, TSSPI_groupFormation) == TSSGF_tight) return qfalse;
;3796:		}
;3797:#endif
;3798:		*/
;3799:		if (BotWantsToRetreat(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 492
ADDRGP4 BotWantsToRetreat
CALLI4
ASGNI4
ADDRLP4 492
INDIRI4
CNSTI4 0
EQI4 $1109
CNSTI4 0
RETI4
ADDRGP4 $1054
JUMPV
LABELV $1109
line 3800
;3800:		if (bs->cur_ps.stats[STAT_STRENGTH] < 2 * LOW_STRENGTH_VALUE) {
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1169915904
GEF4 $1111
line 3801
;3801:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1054
JUMPV
LABELV $1111
line 3803
;3802:		}
;3803:	}
LABELV $1096
line 3828
;3804:	/*
;3805:	// line-of-fire crossing prevention
;3806:	if (enemy >= 0) {
;3807:		aas_entityinfo_t entinfo;
;3808:		vec_t squaredDistanceToEnemy;
;3809:		int i;
;3810:
;3811:		BotEntityInfo(enemy, &entinfo);
;3812:		squaredDistanceToEnemy = DistanceSquared(bs->origin, entinfo.origin);
;3813:		for (i = 0; i < bs->numvisteammates; i++) {
;3814:			playerState_t ps;
;3815:			vec_t teamMateSquaredDistanceToEnemy;
;3816:
;3817:			if (!BotAI_GetClientState(bs->visteammates[i], &ps)) continue;
;3818:			if (ps.stats[STAT_HEALTH] <= 0) continue;
;3819:			teamMateSquaredDistanceToEnemy = DistanceSquared(ps.origin, entinfo.origin);
;3820:			if (teamMateSquaredDistanceToEnemy <= squaredDistanceToEnemy) {
;3821:				if (DistanceSquared(bs->origin, ps.origin) < 150*150) {
;3822:					return qfalse;
;3823:				}
;3824:			}
;3825:		}
;3826:	}
;3827:	*/
;3828:	return qtrue;
CNSTI4 1
RETI4
LABELV $1054
endproc BotWantsToFight 504 12
export BotWantsToChase
proc BotWantsToChase 24 16
line 3836
;3829:}
;3830:
;3831:/*
;3832:==================
;3833:BotWantsToChase
;3834:==================
;3835:*/
;3836:int BotWantsToChase(bot_state_t *bs) {
line 3883
;3837:	// JUHOX: new chase decision logic
;3838:#if 0
;3839:	aas_entityinfo_t entinfo;
;3840:
;3841:	if (gametype == GT_CTF) {
;3842:		//never chase when carrying a CTF flag
;3843:		if (BotCTFCarryingFlag(bs))
;3844:			return qfalse;
;3845:		//always chase if the enemy is carrying a flag
;3846:		BotEntityInfo(bs->enemy, &entinfo);
;3847:		if (EntityCarriesFlag(&entinfo))
;3848:			return qtrue;
;3849:	}
;3850:#ifdef MISSIONPACK
;3851:	else if (gametype == GT_1FCTF) {
;3852:		//never chase if carrying the flag
;3853:		if (Bot1FCTFCarryingFlag(bs))
;3854:			return qfalse;
;3855:		//always chase if the enemy is carrying a flag
;3856:		BotEntityInfo(bs->enemy, &entinfo);
;3857:		if (EntityCarriesFlag(&entinfo))
;3858:			return qtrue;
;3859:	}
;3860:	else if (gametype == GT_OBELISK) {
;3861:		//the bots should be dedicated to attacking the enemy obelisk
;3862:		if (bs->ltgtype == LTG_ATTACKENEMYBASE) {
;3863:			if (bs->enemy != redobelisk.entitynum ||
;3864:						bs->enemy != blueobelisk.entitynum) {
;3865:				return qfalse;
;3866:			}
;3867:		}
;3868:	}
;3869:	else if (gametype == GT_HARVESTER) {
;3870:		//never chase if carrying cubes
;3871:		if (BotHarvesterCarryingCubes(bs))
;3872:			return qfalse;
;3873:	}
;3874:#endif
;3875:	//if the bot is getting the flag
;3876:	if (bs->ltgtype == LTG_GETFLAG)
;3877:		return qfalse;
;3878:	//
;3879:	if (BotAggression(bs) > 50)
;3880:		return qtrue;
;3881:	return qfalse;
;3882:#else
;3883:	if (bs->lastenemyareanum <= 0) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 7768
ADDP4
INDIRI4
CNSTI4 0
GTI4 $1114
CNSTI4 0
RETI4
ADDRGP4 $1113
JUMPV
LABELV $1114
line 3884
;3884:	if (BotWantsToRetreat(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotWantsToRetreat
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1116
CNSTI4 0
RETI4
ADDRGP4 $1113
JUMPV
LABELV $1116
line 3885
;3885:	if (!BotWantsToFight(bs, bs->enemy, qtrue)) return qfalse;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 BotWantsToFight
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $1118
CNSTI4 0
RETI4
ADDRGP4 $1113
JUMPV
LABELV $1118
line 3886
;3886:	if (!trap_AAS_AreaReachability(bs->lastenemyareanum)) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 7768
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $1120
CNSTI4 0
RETI4
ADDRGP4 $1113
JUMPV
LABELV $1120
line 3887
;3887:	if (trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, bs->lastenemyareanum, bs->tfl) <= 0) return qfalse;
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 7768
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
INDIRP4
CNSTI4 5984
ADDP4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
GTI4 $1122
CNSTI4 0
RETI4
ADDRGP4 $1113
JUMPV
LABELV $1122
line 3888
;3888:	return qtrue;
CNSTI4 1
RETI4
LABELV $1113
endproc BotWantsToChase 24 16
export BotWantsToHelp
proc BotWantsToHelp 0 0
line 3897
;3889:#endif
;3890:}
;3891:
;3892:/*
;3893:==================
;3894:BotWantsToHelp
;3895:==================
;3896:*/
;3897:int BotWantsToHelp(bot_state_t *bs) {
line 3898
;3898:	return qtrue;
CNSTI4 1
RETI4
LABELV $1124
endproc BotWantsToHelp 0 0
export BotCanAndWantsToRocketJump
proc BotCanAndWantsToRocketJump 12 16
line 3906
;3899:}
;3900:
;3901:/*
;3902:==================
;3903:BotCanAndWantsToRocketJump
;3904:==================
;3905:*/
;3906:int BotCanAndWantsToRocketJump(bot_state_t *bs) {
line 3910
;3907:	float rocketjumper;
;3908:
;3909:	//if rocket jumping is disabled
;3910:	if (!bot_rocketjump.integer) return qfalse;
ADDRGP4 bot_rocketjump+12
INDIRI4
CNSTI4 0
NEI4 $1126
CNSTI4 0
RETI4
ADDRGP4 $1125
JUMPV
LABELV $1126
line 3911
;3911:	if (bs->ltgtype == LTG_CAMP) return qfalse;	// JUHOX: leader should not use rocket jump
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 7
NEI4 $1129
CNSTI4 0
RETI4
ADDRGP4 $1125
JUMPV
LABELV $1129
line 3912
;3912:	if (bs->cur_ps.powerups[PW_SHIELD]) return qfalse;	// JUHOX: can't shoot with the shield, so no rocket jumping
ADDRFP4 0
INDIRP4
CNSTI4 372
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1131
CNSTI4 0
RETI4
ADDRGP4 $1125
JUMPV
LABELV $1131
line 3913
;3913:	if (bs->cur_ps.stats[STAT_STRENGTH] < 2*LOW_STRENGTH_VALUE + JUMP_STRENGTH_DECREASE) return qfalse;	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1172987904
GEF4 $1133
CNSTI4 0
RETI4
ADDRGP4 $1125
JUMPV
LABELV $1133
line 3915
;3914:#if 1	// JUHOX: railgun jump possible?
;3915:	if ((bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_RAILGUN)) && bs->cur_ps.ammo[WP_RAILGUN] != 0) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $1135
ADDRLP4 4
INDIRP4
CNSTI4 420
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1135
line 3916
;3916:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1125
JUMPV
LABELV $1135
line 3920
;3917:	}
;3918:#endif
;3919:	//if no rocket launcher
;3920:	if (bs->inventory[INVENTORY_ROCKETLAUNCHER] <= 0) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 4992
ADDP4
INDIRI4
CNSTI4 0
GTI4 $1137
CNSTI4 0
RETI4
ADDRGP4 $1125
JUMPV
LABELV $1137
line 3922
;3921:	//if low on rockets
;3922:	if (bs->inventory[INVENTORY_ROCKETS] < 3) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 5052
ADDP4
INDIRI4
CNSTI4 3
GEI4 $1139
CNSTI4 0
RETI4
ADDRGP4 $1125
JUMPV
LABELV $1139
line 3924
;3923:	//never rocket jump with the Quad
;3924:	if (bs->inventory[INVENTORY_QUAD]) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 5100
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1141
CNSTI4 0
RETI4
ADDRGP4 $1125
JUMPV
LABELV $1141
line 3926
;3925:	//if low on health
;3926:	if (bs->inventory[INVENTORY_HEALTH] < 60) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 5076
ADDP4
INDIRI4
CNSTI4 60
GEI4 $1143
CNSTI4 0
RETI4
ADDRGP4 $1125
JUMPV
LABELV $1143
line 3928
;3927:	//if not full health
;3928:	if (bs->inventory[INVENTORY_HEALTH] < 90) {
ADDRFP4 0
INDIRP4
CNSTI4 5076
ADDP4
INDIRI4
CNSTI4 90
GEI4 $1145
line 3930
;3929:		//if the bot has insufficient armor
;3930:		if (bs->inventory[INVENTORY_ARMOR] < 40) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 4964
ADDP4
INDIRI4
CNSTI4 40
GEI4 $1147
CNSTI4 0
RETI4
ADDRGP4 $1125
JUMPV
LABELV $1147
line 3931
;3931:	}
LABELV $1145
line 3932
;3932:	rocketjumper = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_WEAPONJUMPING, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 38
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 8
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
ASGNF4
line 3933
;3933:	if (rocketjumper < 0.5) return qfalse;
ADDRLP4 0
INDIRF4
CNSTF4 1056964608
GEF4 $1149
CNSTI4 0
RETI4
ADDRGP4 $1125
JUMPV
LABELV $1149
line 3934
;3934:	return qtrue;
CNSTI4 1
RETI4
LABELV $1125
endproc BotCanAndWantsToRocketJump 12 16
export BotHasPersistantPowerupAndWeapon
proc BotHasPersistantPowerupAndWeapon 8 4
line 3942
;3935:}
;3936:
;3937:/*
;3938:==================
;3939:BotHasPersistantPowerupAndWeapon
;3940:==================
;3941:*/
;3942:int BotHasPersistantPowerupAndWeapon(bot_state_t *bs) {
line 3986
;3943:#ifdef MISSIONPACK
;3944:	// if the bot does not have a persistant powerup
;3945:	if (!bs->inventory[INVENTORY_SCOUT] &&
;3946:		!bs->inventory[INVENTORY_GUARD] &&
;3947:		!bs->inventory[INVENTORY_DOUBLER] &&
;3948:		!bs->inventory[INVENTORY_AMMOREGEN] ) {
;3949:		return qfalse;
;3950:	}
;3951:#endif
;3952:#if 0	// JUHOX: check aggression
;3953:	//if the bot is very low on health
;3954:	if (bs->inventory[INVENTORY_HEALTH] < 60) return qfalse;
;3955:	//if the bot is low on health
;3956:	if (bs->inventory[INVENTORY_HEALTH] < 80) {
;3957:		//if the bot has insufficient armor
;3958:		if (bs->inventory[INVENTORY_ARMOR] < 40) return qfalse;
;3959:	}
;3960:	//if the bot can use the bfg
;3961:	if (bs->inventory[INVENTORY_BFG10K] > 0 &&
;3962:			bs->inventory[INVENTORY_BFGAMMO] > 7) return qtrue;
;3963:	//if the bot can use the railgun
;3964:	if (bs->inventory[INVENTORY_RAILGUN] > 0 &&
;3965:			bs->inventory[INVENTORY_SLUGS] > 5) return qtrue;
;3966:	//if the bot can use the lightning gun
;3967:	if (bs->inventory[INVENTORY_LIGHTNING] > 0 &&
;3968:			bs->inventory[INVENTORY_LIGHTNINGAMMO] > 50) return qtrue;
;3969:	//if the bot can use the rocketlauncher
;3970:	if (bs->inventory[INVENTORY_ROCKETLAUNCHER] > 0 &&
;3971:			bs->inventory[INVENTORY_ROCKETS] > 5) return qtrue;
;3972:	//
;3973:	if (bs->inventory[INVENTORY_NAILGUN] > 0 &&
;3974:			bs->inventory[INVENTORY_NAILS] > 5) return qtrue;
;3975:	//
;3976:	if (bs->inventory[INVENTORY_PROXLAUNCHER] > 0 &&
;3977:			bs->inventory[INVENTORY_MINES] > 5) return qtrue;
;3978:	//
;3979:	if (bs->inventory[INVENTORY_CHAINGUN] > 0 &&
;3980:			bs->inventory[INVENTORY_BELT] > 40) return qtrue;
;3981:	//if the bot can use the plasmagun
;3982:	if (bs->inventory[INVENTORY_PLASMAGUN] > 0 &&
;3983:			bs->inventory[INVENTORY_CELLS] > 20) return qtrue;
;3984:	return qfalse;
;3985:#else
;3986:	return BotAggression(bs) >= 50;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 BotAggression
CALLF4
ASGNF4
ADDRLP4 4
INDIRF4
CNSTF4 1112014848
LTF4 $1153
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $1154
JUMPV
LABELV $1153
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1154
ADDRLP4 0
INDIRI4
RETI4
LABELV $1151
endproc BotHasPersistantPowerupAndWeapon 8 4
export BotDontAvoid
proc BotDontAvoid 68 12
line 4079
;3987:#endif
;3988:}
;3989:
;3990:#if 0	// JUHOX: no auto camping
;3991:/*
;3992:==================
;3993:BotGoCamp
;3994:==================
;3995:*/
;3996:void BotGoCamp(bot_state_t *bs, bot_goal_t *goal) {
;3997:	float camper;
;3998:
;3999:	bs->decisionmaker = bs->client;
;4000:	//set message time to zero so bot will NOT show any message
;4001:	bs->teammessage_time = 0;
;4002:	//set the ltg type
;4003:	bs->ltgtype = LTG_CAMP;
;4004:	//set the team goal
;4005:	memcpy(&bs->teamgoal, goal, sizeof(bot_goal_t));
;4006:	//get the team goal time
;4007:	camper = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CAMPER, 0, 1);
;4008:	if (camper > 0.99) bs->teamgoal_time = FloatTime() + 99999;
;4009:	else bs->teamgoal_time = FloatTime() + 120 + 180 * camper + random() * 15;
;4010:	//set the last time the bot started camping
;4011:	bs->camp_time = FloatTime();
;4012:	//the teammate that requested the camping
;4013:	bs->teammate = 0;
;4014:	//do NOT type arrive message
;4015:	bs->arrive_time = 1;
;4016:}
;4017:
;4018:/*
;4019:==================
;4020:BotWantsToCamp
;4021:==================
;4022:*/
;4023:int BotWantsToCamp(bot_state_t *bs) {
;4024:	float camper;
;4025:	int cs, traveltime, besttraveltime;
;4026:	bot_goal_t goal, bestgoal;
;4027:
;4028:	camper = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CAMPER, 0, 1);
;4029:	if (camper < 0.1) return qfalse;
;4030:	//if the bot has a team goal
;4031:	if (bs->ltgtype == LTG_TEAMHELP ||
;4032:			bs->ltgtype == LTG_TEAMACCOMPANY ||
;4033:			bs->ltgtype == LTG_DEFENDKEYAREA ||
;4034:			bs->ltgtype == LTG_GETFLAG ||
;4035:			bs->ltgtype == LTG_RUSHBASE ||
;4036:			bs->ltgtype == LTG_CAMP ||
;4037:			bs->ltgtype == LTG_CAMPORDER ||
;4038:			bs->ltgtype == LTG_PATROL) {
;4039:		return qfalse;
;4040:	}
;4041:	//if camped recently
;4042:	if (bs->camp_time > FloatTime() - 60 + 300 * (1-camper)) return qfalse;
;4043:	//
;4044:	if (random() > camper) {
;4045:		bs->camp_time = FloatTime();
;4046:		return qfalse;
;4047:	}
;4048:	//if the bot isn't healthy anough
;4049:	if (BotAggression(bs) < 50) return qfalse;
;4050:	//the bot should have at least have the rocket launcher, the railgun or the bfg10k with some ammo
;4051:	if ((bs->inventory[INVENTORY_ROCKETLAUNCHER] <= 0 || bs->inventory[INVENTORY_ROCKETS < 10]) &&
;4052:		(bs->inventory[INVENTORY_RAILGUN] <= 0 || bs->inventory[INVENTORY_SLUGS] < 10) &&
;4053:		(bs->inventory[INVENTORY_BFG10K] <= 0 || bs->inventory[INVENTORY_BFGAMMO] < 10)) {
;4054:		return qfalse;
;4055:	}
;4056:	//find the closest camp spot
;4057:	besttraveltime = 99999;
;4058:	for (cs = trap_BotGetNextCampSpotGoal(0, &goal); cs; cs = trap_BotGetNextCampSpotGoal(cs, &goal)) {
;4059:		traveltime = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, goal.areanum, TFL_DEFAULT);
;4060:		if (traveltime && traveltime < besttraveltime) {
;4061:			besttraveltime = traveltime;
;4062:			memcpy(&bestgoal, &goal, sizeof(bot_goal_t));
;4063:		}
;4064:	}
;4065:	if (besttraveltime > 150) return qfalse;
;4066:	//ok found a camp spot, go camp there
;4067:	BotGoCamp(bs, &bestgoal);
;4068:	bs->ordered = qfalse;
;4069:	//
;4070:	return qtrue;
;4071:}
;4072:#endif	// JUHOX
;4073:
;4074:/*
;4075:==================
;4076:BotDontAvoid
;4077:==================
;4078:*/
;4079:void BotDontAvoid(bot_state_t *bs, char *itemname) {
line 4083
;4080:	bot_goal_t goal;
;4081:	int num;
;4082:
;4083:	num = trap_BotGetLevelItemGoal(-1, itemname, &goal);
CNSTI4 -1
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 60
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 60
INDIRI4
ASGNI4
ADDRGP4 $1157
JUMPV
LABELV $1156
line 4084
;4084:	while(num >= 0) {
line 4085
;4085:		trap_BotRemoveFromAvoidGoals(bs->gs, goal.number);
ADDRFP4 0
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
ADDRLP4 4+44
INDIRI4
ARGI4
ADDRGP4 trap_BotRemoveFromAvoidGoals
CALLV
pop
line 4086
;4086:		num = trap_BotGetLevelItemGoal(num, itemname, &goal);
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 64
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 64
INDIRI4
ASGNI4
line 4087
;4087:	}
LABELV $1157
line 4084
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $1156
line 4088
;4088:}
LABELV $1155
endproc BotDontAvoid 68 12
export BotGoForPowerups
proc BotGoForPowerups 0 8
line 4095
;4089:
;4090:/*
;4091:==================
;4092:BotGoForPowerups
;4093:==================
;4094:*/
;4095:void BotGoForPowerups(bot_state_t *bs) {
line 4098
;4096:
;4097:	//don't avoid any of the powerups anymore
;4098:	BotDontAvoid(bs, "Quad Damage");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1161
ARGP4
ADDRGP4 BotDontAvoid
CALLV
pop
line 4099
;4099:	BotDontAvoid(bs, "Regeneration");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1162
ARGP4
ADDRGP4 BotDontAvoid
CALLV
pop
line 4100
;4100:	BotDontAvoid(bs, "Battle Suit");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1163
ARGP4
ADDRGP4 BotDontAvoid
CALLV
pop
line 4101
;4101:	BotDontAvoid(bs, "Speed");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1164
ARGP4
ADDRGP4 BotDontAvoid
CALLV
pop
line 4102
;4102:	BotDontAvoid(bs, "Invisibility");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1165
ARGP4
ADDRGP4 BotDontAvoid
CALLV
pop
line 4106
;4103:	//BotDontAvoid(bs, "Flight");
;4104:	//reset the long term goal time so the bot will go for the powerup
;4105:	//NOTE: the long term goal type doesn't change
;4106:	bs->ltg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6088
ADDP4
CNSTF4 0
ASGNF4
line 4107
;4107:}
LABELV $1160
endproc BotGoForPowerups 0 8
export BotRoamGoal
proc BotRoamGoal 228 28
line 4119
;4108:
;4109:qboolean InFieldOfVision(vec3_t viewangles, float fov, vec3_t angles);	// JUHOX
;4110:/*
;4111:==================
;4112:BotRoamGoal
;4113:==================
;4114:*/
;4115:// JUHOX: BotRoamGoal has now a return value and an additional parameter
;4116:#if 0
;4117:void BotRoamGoal(bot_state_t *bs, vec3_t goal) {
;4118:#else
;4119:qboolean BotRoamGoal(bot_state_t *bs, vec3_t goal, qboolean dynamicOnly) {
line 4128
;4120:#endif
;4121:	int pc, i;
;4122:	float len, rnd;
;4123:	vec3_t dir, bestorg, belowbestorg;
;4124:	vec3_t angles;	// JUHOX
;4125:	bsp_trace_t trace;
;4126:
;4127:#if 1	// JUHOX: search a dynamic roam goal
;4128:	if (dynamicOnly && bs->ltgtype != 0 && DistanceSquared(bs->origin, bs->teamgoal.origin) < 300*300) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $1167
ADDRLP4 148
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 148
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1167
ADDRLP4 148
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 148
INDIRP4
CNSTI4 11580
ADDP4
ARGP4
ADDRLP4 152
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 152
INDIRF4
CNSTF4 1202702336
GEF4 $1167
line 4129
;4129:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1166
JUMPV
LABELV $1167
line 4132
;4130:	}
;4131:
;4132:	{
line 4137
;4133:		float maxdistanceSqr;
;4134:		qboolean found;
;4135:		float totalWeight;
;4136:
;4137:		if (bs->dynamicroamgoal_time > FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 11504
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $1169
line 4138
;4138:			if (dynamicOnly && bs->hasDynamicRoamGoal) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $1171
ADDRFP4 0
INDIRP4
CNSTI4 11508
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1171
line 4139
;4139:				VectorCopy(bs->dynamicRoamGoal, goal);
ADDRFP4 4
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 11512
ADDP4
INDIRB
ASGNB 12
line 4140
;4140:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1166
JUMPV
LABELV $1171
line 4142
;4141:			}
;4142:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1166
JUMPV
LABELV $1169
line 4144
;4143:		}
;4144:		bs->dynamicroamgoal_time = FloatTime() + 0.4 + 0.4 * random();
ADDRLP4 168
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRFP4 0
INDIRP4
CNSTI4 11504
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1053609165
ADDF4
ADDRLP4 168
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 168
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1053609165
MULF4
ADDF4
ASGNF4
line 4146
;4145:
;4146:		found = qfalse;
ADDRLP4 164
CNSTI4 0
ASGNI4
line 4147
;4147:		maxdistanceSqr = Square(1200.0);
ADDRLP4 160
CNSTF4 1236256768
ASGNF4
line 4148
;4148:		if (bs->cur_ps.powerups[PW_CHARGE]) maxdistanceSqr = Square(600.0);
ADDRFP4 0
INDIRP4
CNSTI4 368
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1173
ADDRLP4 160
CNSTF4 1219479552
ASGNF4
LABELV $1173
line 4149
;4149:		totalWeight = 0;
ADDRLP4 156
CNSTF4 0
ASGNF4
line 4150
;4150:		for (i = 0; i < level.num_entities; i++) {
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRGP4 $1178
JUMPV
LABELV $1175
line 4157
;4151:			gentity_t* ent;
;4152:			playerState_t* ps;
;4153:			vec3_t origin;
;4154:			float distanceSqr;
;4155:			float weight;
;4156:
;4157:			ent = &g_entities[i];
ADDRLP4 184
ADDRLP4 24
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 4158
;4158:			if (!ent->inuse) continue;
ADDRLP4 184
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1180
ADDRGP4 $1176
JUMPV
LABELV $1180
line 4159
;4159:			if (!ent->r.linked) continue;
ADDRLP4 184
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1182
ADDRGP4 $1176
JUMPV
LABELV $1182
line 4160
;4160:			if (!EntityAudible(ent)) continue;
ADDRLP4 184
INDIRP4
ARGP4
ADDRLP4 200
ADDRGP4 EntityAudible
CALLI4
ASGNI4
ADDRLP4 200
INDIRI4
CNSTI4 0
NEI4 $1184
ADDRGP4 $1176
JUMPV
LABELV $1184
line 4161
;4161:			if (bs->client == i) continue;
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
NEI4 $1186
ADDRGP4 $1176
JUMPV
LABELV $1186
line 4163
;4162:
;4163:			ps = G_GetEntityPlayerState(ent);
ADDRLP4 184
INDIRP4
ARGP4
ADDRLP4 204
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 196
ADDRLP4 204
INDIRP4
ASGNP4
line 4164
;4164:			if (ps) {
ADDRLP4 196
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1188
line 4165
;4165:				VectorCopy(ps->origin, origin);
ADDRLP4 172
ADDRLP4 196
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 4166
;4166:			}
ADDRGP4 $1189
JUMPV
LABELV $1188
line 4167
;4167:			else {
line 4168
;4168:				VectorAdd(ent->r.absmin, ent->r.absmax, origin);
ADDRLP4 172
ADDRLP4 184
INDIRP4
CNSTI4 464
ADDP4
INDIRF4
ADDRLP4 184
INDIRP4
CNSTI4 476
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 172+4
ADDRLP4 184
INDIRP4
CNSTI4 468
ADDP4
INDIRF4
ADDRLP4 184
INDIRP4
CNSTI4 480
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 172+8
ADDRLP4 184
INDIRP4
CNSTI4 472
ADDP4
INDIRF4
ADDRLP4 184
INDIRP4
CNSTI4 484
ADDP4
INDIRF4
ADDF4
ASGNF4
line 4169
;4169:				VectorScale(origin, 0.5, origin);
ADDRLP4 172
ADDRLP4 172
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 172+4
ADDRLP4 172+4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 172+8
ADDRLP4 172+8
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 4170
;4170:			}
LABELV $1189
line 4172
;4171:
;4172:			VectorSubtract(origin, bs->origin, dir);
ADDRLP4 208
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 172
INDIRF4
ADDRLP4 208
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 172+4
INDIRF4
ADDRLP4 208
INDIRP4
CNSTI4 4920
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 172+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRF4
SUBF4
ASGNF4
line 4173
;4173:			distanceSqr = VectorLengthSquared(dir);
ADDRLP4 0
ARGP4
ADDRLP4 212
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 188
ADDRLP4 212
INDIRF4
ASGNF4
line 4174
;4174:			if (distanceSqr > maxdistanceSqr) continue;
ADDRLP4 188
INDIRF4
ADDRLP4 160
INDIRF4
LEF4 $1200
ADDRGP4 $1176
JUMPV
LABELV $1200
line 4176
;4175:
;4176:			vectoangles(dir, angles);
ADDRLP4 0
ARGP4
ADDRLP4 112
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 4177
;4177:			if (InFieldOfVision(bs->viewangles, 100, angles)) continue;
ADDRFP4 0
INDIRP4
CNSTI4 7840
ADDP4
ARGP4
CNSTF4 1120403456
ARGF4
ADDRLP4 112
ARGP4
ADDRLP4 216
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 216
INDIRI4
CNSTI4 0
EQI4 $1202
ADDRGP4 $1176
JUMPV
LABELV $1202
line 4178
;4178:			if (!trap_InPVSIgnorePortals(bs->origin, g_entities[i].s.pos.trBase)) continue;
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 24
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+12+12
ADDP4
ARGP4
ADDRLP4 220
ADDRGP4 trap_InPVSIgnorePortals
CALLI4
ASGNI4
ADDRLP4 220
INDIRI4
CNSTI4 0
NEI4 $1204
ADDRGP4 $1176
JUMPV
LABELV $1204
line 4180
;4179:
;4180:			weight = 1.0 / (distanceSqr + 100);
ADDRLP4 192
CNSTF4 1065353216
ADDRLP4 188
INDIRF4
CNSTF4 1120403456
ADDF4
DIVF4
ASGNF4
line 4181
;4181:			totalWeight += weight;
ADDRLP4 156
ADDRLP4 156
INDIRF4
ADDRLP4 192
INDIRF4
ADDF4
ASGNF4
line 4182
;4182:			if (random() <= weight / totalWeight) {
ADDRLP4 224
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 224
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 224
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
ADDRLP4 192
INDIRF4
ADDRLP4 156
INDIRF4
DIVF4
GTF4 $1208
line 4183
;4183:				found = qtrue;
ADDRLP4 164
CNSTI4 1
ASGNI4
line 4184
;4184:				VectorCopy(origin, goal);
ADDRFP4 4
INDIRP4
ADDRLP4 172
INDIRB
ASGNB 12
line 4185
;4185:			}
LABELV $1208
line 4186
;4186:		}
LABELV $1176
line 4150
ADDRLP4 24
ADDRLP4 24
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1178
ADDRLP4 24
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $1175
line 4187
;4187:		if (found) {
ADDRLP4 164
INDIRI4
CNSTI4 0
EQI4 $1210
line 4188
;4188:			bs->roamgoal_time = FloatTime() + 1 + 2 * random();
ADDRLP4 172
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRFP4 0
INDIRP4
CNSTI4 11524
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
ADDF4
ADDRLP4 172
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 172
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1073741824
MULF4
ADDF4
ASGNF4
line 4189
;4189:			VectorCopy(goal, bs->dynamicRoamGoal);
ADDRFP4 0
INDIRP4
CNSTI4 11512
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 4190
;4190:			bs->hasDynamicRoamGoal = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 11508
ADDP4
CNSTI4 1
ASGNI4
line 4191
;4191:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1166
JUMPV
LABELV $1210
line 4193
;4192:		}
;4193:		bs->hasDynamicRoamGoal = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 11508
ADDP4
CNSTI4 0
ASGNI4
line 4194
;4194:	}
line 4198
;4195:#endif
;4196:
;4197:#if 1	// JUHOX: check if a new roam goal should be determined
;4198:	if (dynamicOnly) return qfalse;
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $1212
CNSTI4 0
RETI4
ADDRGP4 $1166
JUMPV
LABELV $1212
line 4199
;4199:	if (bs->roamgoal_time > FloatTime()) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 11524
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $1214
CNSTI4 0
RETI4
ADDRGP4 $1166
JUMPV
LABELV $1214
line 4202
;4200:#endif
;4201:
;4202:	for (i = 0; i < /*10*/3; i++) {	// JUHOX
ADDRLP4 24
CNSTI4 0
ASGNI4
LABELV $1216
line 4204
;4203:		//start at the bot origin
;4204:		VectorCopy(bs->origin, bestorg);
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRB
ASGNB 12
line 4205
;4205:		rnd = random();
ADDRLP4 156
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 128
ADDRLP4 156
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 156
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
ASGNF4
line 4206
;4206:		if (rnd > 0.25) {
ADDRLP4 128
INDIRF4
CNSTF4 1048576000
LEF4 $1220
line 4208
;4207:			//add a random value to the x-coordinate
;4208:			if (random() < 0.5) bestorg[0] -= 800 * random() + 100;
ADDRLP4 160
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 160
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 160
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1056964608
GEF4 $1222
ADDRLP4 164
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 164
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 164
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1145569280
MULF4
CNSTF4 1120403456
ADDF4
SUBF4
ASGNF4
ADDRGP4 $1223
JUMPV
LABELV $1222
line 4209
;4209:			else bestorg[0] += 800 * random() + 100;
ADDRLP4 168
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 168
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 168
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1145569280
MULF4
CNSTF4 1120403456
ADDF4
ADDF4
ASGNF4
LABELV $1223
line 4210
;4210:		}
LABELV $1220
line 4211
;4211:		if (rnd < 0.75) {
ADDRLP4 128
INDIRF4
CNSTF4 1061158912
GEF4 $1224
line 4213
;4212:			//add a random value to the y-coordinate
;4213:			if (random() < 0.5) bestorg[1] -= 800 * random() + 100;
ADDRLP4 160
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 160
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 160
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1056964608
GEF4 $1226
ADDRLP4 164
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 164
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 164
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1145569280
MULF4
CNSTF4 1120403456
ADDF4
SUBF4
ASGNF4
ADDRGP4 $1227
JUMPV
LABELV $1226
line 4214
;4214:			else bestorg[1] += 800 * random() + 100;
ADDRLP4 168
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 168
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 168
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1145569280
MULF4
CNSTF4 1120403456
ADDF4
ADDF4
ASGNF4
LABELV $1227
line 4215
;4215:		}
LABELV $1224
line 4217
;4216:		//add a random value to the z-coordinate (NOTE: 48 = maxjump?)
;4217:		bestorg[2] += 2 * 48 * crandom();
ADDRLP4 160
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
ADDRLP4 160
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 160
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
CNSTF4 1119879168
MULF4
ADDF4
ASGNF4
line 4219
;4218:		//trace a line from the origin to the roam target
;4219:		BotAI_Trace(&trace, bs->origin, NULL, NULL, bestorg, bs->entitynum, MASK_SOLID);
ADDRLP4 28
ARGP4
ADDRLP4 164
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 164
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 164
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 4221
;4220:		//direction and length towards the roam target
;4221:		VectorSubtract(trace.endpos, bs->origin, dir);
ADDRLP4 168
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 28+12
INDIRF4
ADDRLP4 168
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 28+12+4
INDIRF4
ADDRLP4 168
INDIRP4
CNSTI4 4920
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 28+12+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRF4
SUBF4
ASGNF4
line 4223
;4222:#if 1	// JUHOX: check if the goal is already in the field of vision
;4223:		vectoangles(dir, angles);
ADDRLP4 0
ARGP4
ADDRLP4 112
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 4224
;4224:		if (InFieldOfVision(bs->viewangles, 100, angles)) continue;
ADDRFP4 0
INDIRP4
CNSTI4 7840
ADDP4
ARGP4
CNSTF4 1120403456
ARGF4
ADDRLP4 112
ARGP4
ADDRLP4 172
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 0
EQI4 $1238
ADDRGP4 $1217
JUMPV
LABELV $1238
line 4226
;4225:#endif
;4226:		len = VectorNormalize(dir);
ADDRLP4 0
ARGP4
ADDRLP4 176
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 124
ADDRLP4 176
INDIRF4
ASGNF4
line 4228
;4227:		//if the roam target is far away anough
;4228:		if (len > 200) {
ADDRLP4 124
INDIRF4
CNSTF4 1128792064
LEF4 $1240
line 4230
;4229:			//the roam target is in the given direction before walls
;4230:			VectorScale(dir, len * trace.fraction - 40, dir);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 124
INDIRF4
ADDRLP4 28+8
INDIRF4
MULF4
CNSTF4 1109393408
SUBF4
MULF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 124
INDIRF4
ADDRLP4 28+8
INDIRF4
MULF4
CNSTF4 1109393408
SUBF4
MULF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 124
INDIRF4
ADDRLP4 28+8
INDIRF4
MULF4
CNSTF4 1109393408
SUBF4
MULF4
ASGNF4
line 4231
;4231:			VectorAdd(bs->origin, dir, bestorg);
ADDRLP4 184
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 184
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 184
INDIRP4
CNSTI4 4920
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
ADDF4
ASGNF4
line 4233
;4232:			//get the coordinates of the floor below the roam target
;4233:			belowbestorg[0] = bestorg[0];
ADDRLP4 132
ADDRLP4 12
INDIRF4
ASGNF4
line 4234
;4234:			belowbestorg[1] = bestorg[1];
ADDRLP4 132+4
ADDRLP4 12+4
INDIRF4
ASGNF4
line 4235
;4235:			belowbestorg[2] = bestorg[2] - 800;
ADDRLP4 132+8
ADDRLP4 12+8
INDIRF4
CNSTF4 1145569280
SUBF4
ASGNF4
line 4236
;4236:			BotAI_Trace(&trace, bestorg, NULL, NULL, belowbestorg, bs->entitynum, MASK_SOLID);
ADDRLP4 28
ARGP4
ADDRLP4 12
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 132
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 4238
;4237:			//
;4238:			if (!trace.startsolid) {
ADDRLP4 28+4
INDIRI4
CNSTI4 0
NEI4 $1257
line 4239
;4239:				trace.endpos[2]++;
ADDRLP4 28+12+8
ADDRLP4 28+12+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 4240
;4240:				pc = trap_PointContents(trace.endpos, bs->entitynum);
ADDRLP4 28+12
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 188
ADDRGP4 trap_PointContents
CALLI4
ASGNI4
ADDRLP4 144
ADDRLP4 188
INDIRI4
ASGNI4
line 4241
;4241:				if (!(pc & (CONTENTS_LAVA | CONTENTS_SLIME))) {
ADDRLP4 144
INDIRI4
CNSTI4 24
BANDI4
CNSTI4 0
NEI4 $1263
line 4242
;4242:					VectorCopy(bestorg, goal);
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRB
ASGNB 12
line 4246
;4243:#if 0	// JUHOX: found a roaming view goal
;4244:					return;
;4245:#else
;4246:					bs->roamgoal_time = FloatTime() + 0.5 + 2 * random();
ADDRLP4 192
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRFP4 0
INDIRP4
CNSTI4 11524
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1056964608
ADDF4
ADDRLP4 192
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 192
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1073741824
MULF4
ADDF4
ASGNF4
line 4247
;4247:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1166
JUMPV
LABELV $1263
line 4250
;4248:#endif
;4249:				}
;4250:			}
LABELV $1257
line 4251
;4251:		}
LABELV $1240
line 4252
;4252:	}
LABELV $1217
line 4202
ADDRLP4 24
ADDRLP4 24
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 3
LTI4 $1216
line 4256
;4253:#if 0	// JUHOX: no roaming view goal found
;4254:	VectorCopy(bestorg, goal);
;4255:#else
;4256:	bs->roamgoalcnt = 0;	// do not use a roam goal
ADDRFP4 0
INDIRP4
CNSTI4 11528
ADDP4
CNSTI4 0
ASGNI4
line 4257
;4257:	return qfalse;
CNSTI4 0
RETI4
LABELV $1166
endproc BotRoamGoal 228 28
data
align 4
LABELV $1267
byte 4 0
byte 4 0
byte 4 1065353216
export BotAttackMove
code
proc BotAttackMove 444 16
line 4266
;4258:#endif
;4259:}
;4260:
;4261:/*
;4262:==================
;4263:BotAttackMove
;4264:==================
;4265:*/
;4266:bot_moveresult_t BotAttackMove(bot_state_t *bs, int tfl) {
line 4270
;4267:	int movetype, i, attackentity;
;4268:	float attack_skill, jumper, croucher, dist/*, strafechange_time*/;	// JUHOX: strafechange_time no longer needed
;4269:	float attack_dist, attack_range;
;4270:	vec3_t forward, backward, sideward, hordir, up = {0, 0, 1};
ADDRLP4 212
ADDRGP4 $1267
INDIRB
ASGNB 12
line 4276
;4271:	aas_entityinfo_t entinfo;
;4272:	bot_moveresult_t moveresult;
;4273:	bot_goal_t goal;
;4274:	float speed;	// JUHOX
;4275:
;4276:	attackentity = bs->enemy;
ADDRLP4 336
ADDRFP4 4
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
ASGNI4
line 4278
;4277:#if 1	// JUHOX: safety check
;4278:	if (attackentity < 0) {
ADDRLP4 336
INDIRI4
CNSTI4 0
GEI4 $1268
line 4279
;4279:		memset(&moveresult, 0, sizeof(moveresult));
ADDRLP4 224
ARGP4
CNSTI4 0
ARGI4
CNSTI4 52
ARGI4
ADDRGP4 memset
CALLP4
pop
line 4280
;4280:		return moveresult;
ADDRFP4 0
INDIRP4
ADDRLP4 224
INDIRB
ASGNB 52
ADDRGP4 $1265
JUMPV
LABELV $1268
line 4287
;4281:	}
;4282:#endif
;4283:	//
;4284:#if 0	// JUHOX: more chase conditions for attack move
;4285:	if (bs->attackchase_time > FloatTime()) {
;4286:#else
;4287:	BotEntityInfo(attackentity, &entinfo);	// moved to here from below!
ADDRLP4 336
INDIRI4
ARGI4
ADDRLP4 64
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 4289
;4288:	if (
;4289:		(
ADDRLP4 348
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 352
ADDRGP4 floattime
INDIRF4
ASGNF4
ADDRLP4 348
INDIRP4
CNSTI4 7216
ADDP4
INDIRF4
ADDRLP4 352
INDIRF4
GTF4 $1275
ADDRLP4 348
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 64+24
ARGP4
ADDRLP4 356
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRLP4 348
INDIRP4
CNSTI4 7224
ADDP4
INDIRF4
ADDRLP4 352
INDIRF4
CNSTF4 1056964608
SUBF4
ADDRLP4 356
INDIRF4
CNSTF4 981668463
MULF4
SUBF4
GTF4 $1276
ADDRLP4 64+124
INDIRI4
CNSTI4 384
BANDI4
CNSTI4 0
EQI4 $1270
LABELV $1276
ADDRFP4 4
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 64+24
ARGP4
ADDRLP4 360
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 360
INDIRF4
CNSTF4 1202702336
LEF4 $1270
LABELV $1275
ADDRFP4 4
INDIRP4
CNSTI4 7768
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1270
line 4300
;4290:			bs->attackchase_time > FloatTime() ||
;4291:			(
;4292:				(
;4293:					bs->enemysight_time > FloatTime() - 0.5 - Distance(bs->origin, entinfo.origin) / 1000 ||
;4294:					(entinfo.powerups & ((1 << PW_REDFLAG) | (1 << PW_BLUEFLAG)))
;4295:				) &&
;4296:				DistanceSquared(bs->origin, entinfo.origin) > Square(300)
;4297:			)
;4298:		) &&
;4299:		bs->lastenemyareanum > 0
;4300:	) {
line 4303
;4301:#endif
;4302:		//create the chase goal
;4303:		goal.entitynum = attackentity;
ADDRLP4 280+40
ADDRLP4 336
INDIRI4
ASGNI4
line 4304
;4304:		goal.areanum = bs->lastenemyareanum;
ADDRLP4 280+12
ADDRFP4 4
INDIRP4
CNSTI4 7768
ADDP4
INDIRI4
ASGNI4
line 4305
;4305:		VectorCopy(bs->lastenemyorigin, goal.origin);
ADDRLP4 280
ADDRFP4 4
INDIRP4
CNSTI4 7772
ADDP4
INDIRB
ASGNB 12
line 4306
;4306:		VectorSet(goal.mins, -8, -8, -8);
ADDRLP4 280+16
CNSTF4 3238002688
ASGNF4
ADDRLP4 280+16+4
CNSTF4 3238002688
ASGNF4
ADDRLP4 280+16+8
CNSTF4 3238002688
ASGNF4
line 4307
;4307:		VectorSet(goal.maxs, 8, 8, 8);
ADDRLP4 280+28
CNSTF4 1090519040
ASGNF4
ADDRLP4 280+28+4
CNSTF4 1090519040
ASGNF4
ADDRLP4 280+28+8
CNSTF4 1090519040
ASGNF4
line 4309
;4308:		//initialize the movement state
;4309:		BotSetupForMovement(bs);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotSetupForMovement
CALLV
pop
line 4311
;4310:		//move towards the goal
;4311:		trap_BotMoveToGoal(&moveresult, bs->ms, &goal, tfl);
ADDRLP4 224
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRLP4 280
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 trap_BotMoveToGoal
CALLV
pop
line 4312
;4312:		return moveresult;
ADDRFP4 0
INDIRP4
ADDRLP4 224
INDIRB
ASGNB 52
ADDRGP4 $1265
JUMPV
LABELV $1270
line 4315
;4313:	}
;4314:	//
;4315:	memset(&moveresult, 0, sizeof(bot_moveresult_t));
ADDRLP4 224
ARGP4
CNSTI4 0
ARGI4
CNSTI4 52
ARGI4
ADDRGP4 memset
CALLP4
pop
line 4317
;4316:	//
;4317:	attack_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_ATTACK_SKILL, 0, 1);
ADDRFP4 4
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 364
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 276
ADDRLP4 364
INDIRF4
ASGNF4
line 4318
;4318:	jumper = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_JUMPER, 0, 1);
ADDRFP4 4
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 37
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 368
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 340
ADDRLP4 368
INDIRF4
ASGNF4
line 4319
;4319:	croucher = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CROUCHER, 0, 1);
ADDRFP4 4
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 36
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 372
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 344
ADDRLP4 372
INDIRF4
ASGNF4
line 4321
;4320:	//if the bot is really stupid
;4321:	if (attack_skill < 0.2) return moveresult;
ADDRLP4 276
INDIRF4
CNSTF4 1045220557
GEF4 $1289
ADDRFP4 0
INDIRP4
ADDRLP4 224
INDIRB
ASGNB 52
ADDRGP4 $1265
JUMPV
LABELV $1289
line 4323
;4322:	//initialize the movement state
;4323:	BotSetupForMovement(bs);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotSetupForMovement
CALLV
pop
line 4327
;4324:	//get the enemy entity info
;4325:	//BotEntityInfo(attackentity, &entinfo);	// JUHOX: already done above
;4326:	//direction towards the enemy
;4327:	VectorSubtract(entinfo.origin, bs->origin, forward);
ADDRLP4 376
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 64+24
INDIRF4
ADDRLP4 376
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 64+24+4
INDIRF4
ADDRLP4 376
INDIRP4
CNSTI4 4920
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24+8
ADDRLP4 64+24+8
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 4924
ADDP4
INDIRF4
SUBF4
ASGNF4
line 4329
;4328:	//the distance towards the enemy
;4329:	dist = VectorNormalize(forward);
ADDRLP4 24
ARGP4
ADDRLP4 380
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 60
ADDRLP4 380
INDIRF4
ASGNF4
line 4330
;4330:	VectorNegate(forward, backward);
ADDRLP4 36
ADDRLP4 24
INDIRF4
NEGF4
ASGNF4
ADDRLP4 36+4
ADDRLP4 24+4
INDIRF4
NEGF4
ASGNF4
ADDRLP4 36+8
ADDRLP4 24+8
INDIRF4
NEGF4
ASGNF4
line 4332
;4331:	//walk, crouch or jump
;4332:	movetype = MOVE_WALK;
ADDRLP4 204
CNSTI4 1
ASGNI4
line 4348
;4333:#if 0	// JUHOX: neither jump nor crouch during attack randomly
;4334:	//
;4335:	if (bs->attackcrouch_time < FloatTime() - 1) {
;4336:		if (random() < jumper) {
;4337:			movetype = MOVE_JUMP;
;4338:		}
;4339:		//wait at least one second before crouching again
;4340:		else if (bs->attackcrouch_time < FloatTime() - 1 && random() < croucher) {
;4341:			bs->attackcrouch_time = FloatTime() + croucher * 5;
;4342:		}
;4343:	}
;4344:	if (bs->attackcrouch_time > FloatTime()) movetype = MOVE_CROUCH;
;4345:#endif
;4346:#if 1	// JUHOX: most weapons become more precise if the bot crouches
;4347:	if (
;4348:		attack_skill >= 0.5 &&
ADDRLP4 276
INDIRF4
CNSTF4 1056964608
LTF4 $1302
ADDRLP4 60
INDIRF4
CNSTF4 1142292480
GTF4 $1308
ADDRLP4 60
INDIRF4
CNSTF4 1137180672
LEF4 $1307
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $1308
LABELV $1307
ADDRLP4 388
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 388
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 9
EQI4 $1308
ADDRLP4 388
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 5
NEI4 $1302
LABELV $1308
ADDRLP4 392
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 392
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 1
EQI4 $1302
ADDRLP4 392
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 6
EQI4 $1302
ADDRLP4 392
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 7
EQI4 $1309
ADDRLP4 64+128
INDIRI4
CNSTI4 7
EQI4 $1302
LABELV $1309
ADDRLP4 396
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 396
INDIRP4
CNSTI4 7420
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1077936128
SUBF4
GEF4 $1302
ADDRLP4 396
INDIRP4
ARGP4
ADDRLP4 400
ADDRGP4 BotWantsToRetreat
CALLI4
ASGNI4
ADDRLP4 400
INDIRI4
CNSTI4 0
NEI4 $1302
ADDRFP4 4
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1302
line 4365
;4349:		(
;4350:			dist > 600 ||
;4351:			(dist > 400 && (bs->cur_ps.pm_flags & PMF_DUCKED)) ||
;4352:			bs->cur_ps.weapon == WP_BFG ||
;4353:			bs->cur_ps.weapon == WP_ROCKET_LAUNCHER
;4354:		) &&
;4355:		bs->cur_ps.weapon != WP_GAUNTLET &&
;4356:		//bs->cur_ps.weapon != WP_GRENADE_LAUNCHER &&
;4357:		bs->cur_ps.weapon != WP_LIGHTNING &&
;4358:		(
;4359:			bs->cur_ps.weapon == WP_RAILGUN ||
;4360:			entinfo.weapon != WP_RAILGUN
;4361:		) &&
;4362:		bs->couldNotSeeEnemyWhileDucked_time < FloatTime() - 3 &&	// to suppress "crouch-shaking"
;4363:		!BotWantsToRetreat(bs) &&
;4364:		bs->cur_ps.weapon != WP_NONE
;4365:	) {
line 4366
;4366:		movetype = MOVE_CROUCH;
ADDRLP4 204
CNSTI4 2
ASGNI4
line 4367
;4367:	}
LABELV $1302
line 4370
;4368:#endif
;4369:	//if the bot should jump
;4370:	if (movetype == MOVE_JUMP) {
ADDRLP4 204
INDIRI4
CNSTI4 4
NEI4 $1310
line 4372
;4371:		//if jumped last frame
;4372:		if (bs->attackjump_time > FloatTime()) {
ADDRFP4 4
INDIRP4
CNSTI4 7220
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $1312
line 4373
;4373:			movetype = MOVE_WALK;
ADDRLP4 204
CNSTI4 1
ASGNI4
line 4374
;4374:		}
ADDRGP4 $1313
JUMPV
LABELV $1312
line 4375
;4375:		else {
line 4376
;4376:			bs->attackjump_time = FloatTime() + 1;
ADDRFP4 4
INDIRP4
CNSTI4 7220
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 4377
;4377:		}
LABELV $1313
line 4378
;4378:	}
LABELV $1310
line 4379
;4379:	if (bs->cur_ps.weapon == WP_GAUNTLET) {
ADDRFP4 4
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1314
line 4380
;4380:		attack_dist = 0;
ADDRLP4 52
CNSTF4 0
ASGNF4
line 4381
;4381:		attack_range = 0;
ADDRLP4 56
CNSTF4 0
ASGNF4
line 4382
;4382:	}
ADDRGP4 $1315
JUMPV
LABELV $1314
line 4384
;4383:#if 1	// JUHOX: more elaborated attack distances
;4384:	else if (bs->cur_ps.weapon == WP_BFG) {
ADDRFP4 4
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 9
NEI4 $1316
line 4385
;4385:		attack_dist = 1500;
ADDRLP4 52
CNSTF4 1153138688
ASGNF4
line 4386
;4386:		attack_range = 900;
ADDRLP4 56
CNSTF4 1147207680
ASGNF4
line 4387
;4387:	}
ADDRGP4 $1317
JUMPV
LABELV $1316
line 4388
;4388:	else if (bs->cur_ps.weapon == WP_ROCKET_LAUNCHER) {
ADDRFP4 4
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 5
NEI4 $1318
line 4389
;4389:		attack_dist = 700;
ADDRLP4 52
CNSTF4 1143930880
ASGNF4
line 4390
;4390:		attack_range = 400;
ADDRLP4 56
CNSTF4 1137180672
ASGNF4
line 4391
;4391:	}
ADDRGP4 $1319
JUMPV
LABELV $1318
line 4392
;4392:	else if (bs->cur_ps.weapon == WP_GRENADE_LAUNCHER) {
ADDRFP4 4
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 4
NEI4 $1320
line 4393
;4393:		attack_dist = 500;
ADDRLP4 52
CNSTF4 1140457472
ASGNF4
line 4394
;4394:		attack_range = 150;
ADDRLP4 56
CNSTF4 1125515264
ASGNF4
line 4395
;4395:	}
ADDRGP4 $1321
JUMPV
LABELV $1320
line 4396
;4396:	else if (bs->cur_ps.weapon == WP_PLASMAGUN) {
ADDRFP4 4
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 8
NEI4 $1322
line 4397
;4397:		attack_dist = 800;
ADDRLP4 52
CNSTF4 1145569280
ASGNF4
line 4398
;4398:		attack_range = 500;
ADDRLP4 56
CNSTF4 1140457472
ASGNF4
line 4399
;4399:	}
ADDRGP4 $1323
JUMPV
LABELV $1322
line 4400
;4400:	else if (bs->cur_ps.weapon == WP_LIGHTNING) {
ADDRFP4 4
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 6
NEI4 $1324
line 4401
;4401:		attack_dist = 0.5 * LIGHTNING_RANGE;
ADDRLP4 52
CNSTF4 1132068864
ASGNF4
line 4402
;4402:		attack_range = 0.4 * LIGHTNING_RANGE;
ADDRLP4 56
CNSTF4 1128792064
ASGNF4
line 4403
;4403:	}
ADDRGP4 $1325
JUMPV
LABELV $1324
line 4404
;4404:	else if (bs->cur_ps.weapon == WP_MACHINEGUN) {
ADDRFP4 4
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1326
line 4405
;4405:		attack_dist = 600;
ADDRLP4 52
CNSTF4 1142292480
ASGNF4
line 4406
;4406:		attack_range = 500;
ADDRLP4 56
CNSTF4 1140457472
ASGNF4
line 4407
;4407:	}
ADDRGP4 $1327
JUMPV
LABELV $1326
line 4408
;4408:	else if (bs->cur_ps.weapon == WP_RAILGUN) {
ADDRFP4 4
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 7
NEI4 $1328
line 4409
;4409:		attack_dist = 1000;
ADDRLP4 52
CNSTF4 1148846080
ASGNF4
line 4410
;4410:		attack_range = 800;
ADDRLP4 56
CNSTF4 1145569280
ASGNF4
line 4411
;4411:	}
ADDRGP4 $1329
JUMPV
LABELV $1328
line 4412
;4412:	else if (bs->cur_ps.weapon == WP_SHOTGUN) {
ADDRFP4 4
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1330
line 4413
;4413:		attack_dist = 250;
ADDRLP4 52
CNSTF4 1132068864
ASGNF4
line 4414
;4414:		attack_range = 150;
ADDRLP4 56
CNSTF4 1125515264
ASGNF4
line 4415
;4415:	}
ADDRGP4 $1331
JUMPV
LABELV $1330
line 4417
;4416:#endif
;4417:	else {
line 4418
;4418:		attack_dist = IDEAL_ATTACKDIST;
ADDRLP4 52
CNSTF4 1124859904
ASGNF4
line 4419
;4419:		attack_range = 40;
ADDRLP4 56
CNSTF4 1109393408
ASGNF4
line 4420
;4420:	}
LABELV $1331
LABELV $1329
LABELV $1327
LABELV $1325
LABELV $1323
LABELV $1321
LABELV $1319
LABELV $1317
LABELV $1315
line 4422
;4421:#if 1	// JUHOX: if the enemy carries a flag, go closer
;4422:	if (EntityCarriesFlag(&entinfo)) {
ADDRLP4 64
ARGP4
ADDRLP4 404
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 404
INDIRI4
CNSTI4 0
EQI4 $1332
line 4425
;4423:		float attack_min, attack_max;
;4424:
;4425:		attack_min = attack_dist - attack_range;
ADDRLP4 412
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRF4
SUBF4
ASGNF4
line 4426
;4426:		attack_max = attack_dist + attack_range;
ADDRLP4 408
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRF4
ADDF4
ASGNF4
line 4427
;4427:		if (attack_max > 500 && attack_range > 100) {
ADDRLP4 408
INDIRF4
CNSTF4 1140457472
LEF4 $1334
ADDRLP4 56
INDIRF4
CNSTF4 1120403456
LEF4 $1334
line 4428
;4428:			if (attack_min > 300) {
ADDRLP4 412
INDIRF4
CNSTF4 1133903872
LEF4 $1336
line 4429
;4429:				attack_max = attack_min + 200;
ADDRLP4 408
ADDRLP4 412
INDIRF4
CNSTF4 1128792064
ADDF4
ASGNF4
line 4430
;4430:			}
ADDRGP4 $1337
JUMPV
LABELV $1336
line 4431
;4431:			else {
line 4432
;4432:				attack_max = 500;
ADDRLP4 408
CNSTF4 1140457472
ASGNF4
line 4433
;4433:			}
LABELV $1337
line 4434
;4434:			attack_dist = (attack_min + attack_max) / 2;
ADDRLP4 52
ADDRLP4 412
INDIRF4
ADDRLP4 408
INDIRF4
ADDF4
CNSTF4 1056964608
MULF4
ASGNF4
line 4435
;4435:			attack_range = (attack_max - attack_min) / 2;
ADDRLP4 56
ADDRLP4 408
INDIRF4
ADDRLP4 412
INDIRF4
SUBF4
CNSTF4 1056964608
MULF4
ASGNF4
line 4436
;4436:		}
LABELV $1334
line 4437
;4437:	}
LABELV $1332
line 4440
;4438:#endif
;4439:#if 1	// JUHOX: if the enemy uses the bfg, go even closer
;4440:	if (entinfo.weapon == WP_BFG && attack_skill > 0.5) {
ADDRLP4 64+128
INDIRI4
CNSTI4 9
NEI4 $1338
ADDRLP4 276
INDIRF4
CNSTF4 1056964608
LEF4 $1338
line 4441
;4441:		attack_dist = 120;
ADDRLP4 52
CNSTF4 1123024896
ASGNF4
line 4442
;4442:		attack_range = 70;
ADDRLP4 56
CNSTF4 1116471296
ASGNF4
line 4443
;4443:	}
LABELV $1338
line 4447
;4444:#endif
;4445:#if 1	// JUHOX: if the enemy just fired the bfg, go very close
;4446:	if (
;4447:		(entinfo.powerups & (1 << PW_BFG_RELOADING)) &&
ADDRLP4 64+124
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $1341
ADDRFP4 4
INDIRP4
CNSTI4 376
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1341
ADDRLP4 276
INDIRF4
CNSTF4 1053609165
LEF4 $1341
line 4450
;4448:		!bs->cur_ps.powerups[PW_BFG_RELOADING] &&
;4449:		attack_skill > 0.4
;4450:	) {
line 4451
;4451:		attack_dist = 50;
ADDRLP4 52
CNSTF4 1112014848
ASGNF4
line 4452
;4452:		attack_range = 50;
ADDRLP4 56
CNSTF4 1112014848
ASGNF4
line 4453
;4453:	}
LABELV $1341
line 4457
;4454:#endif
;4455:#if 1	// JUHOX: if the enemy uses lightning gun, stay away
;4456:	if (
;4457:		entinfo.weapon == WP_LIGHTNING &&
ADDRLP4 64+128
INDIRI4
CNSTI4 6
NEI4 $1344
ADDRFP4 4
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 1
EQI4 $1344
ADDRLP4 276
INDIRF4
CNSTF4 1050253722
LEF4 $1344
line 4460
;4458:		bs->cur_ps.weapon != WP_GAUNTLET &&
;4459:		attack_skill > 0.3
;4460:	) {
line 4461
;4461:		attack_dist += LIGHTNING_RANGE + 200;
ADDRLP4 52
ADDRLP4 52
INDIRF4
CNSTF4 1143930880
ADDF4
ASGNF4
line 4462
;4462:	}
LABELV $1344
line 4464
;4463:#endif
;4464:	speed = bs->forceWalk? 200 : 400;	// JUHOX
ADDRFP4 4
INDIRP4
CNSTI4 7740
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1348
ADDRLP4 408
CNSTI4 200
ASGNI4
ADDRGP4 $1349
JUMPV
LABELV $1348
ADDRLP4 408
CNSTI4 400
ASGNI4
LABELV $1349
ADDRLP4 208
ADDRLP4 408
INDIRI4
CVIF4 4
ASGNF4
line 4471
;4465:	//if the bot is stupid
;4466:#if 0	// JUHOX: different strafe behavior with melee weapon
;4467:	if (attack_skill <= 0.4) {
;4468:#else
;4469:	if
;4470:	(
;4471:		(attack_dist > 50 && attack_skill <= 0.4) ||
ADDRLP4 52
INDIRF4
CNSTF4 1112014848
LEF4 $1355
ADDRLP4 276
INDIRF4
CNSTF4 1053609165
LEF4 $1354
LABELV $1355
ADDRLP4 52
INDIRF4
CNSTF4 1112014848
GTF4 $1350
ADDRLP4 276
INDIRF4
CNSTF4 1053609165
LEF4 $1350
ADDRLP4 64+24+8
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 4924
ADDP4
INDIRF4
SUBF4
CNSTF4 1112014848
GEF4 $1350
LABELV $1354
line 4477
;4472:		(
;4473:			attack_dist <= 50 && attack_skill > 0.4 &&
;4474:			/*dist < 400 &&*/ entinfo.origin[2] - bs->origin[2] < 50
;4475:		)
;4476:	)
;4477:	{
line 4480
;4478:#endif
;4479:		//just walk to or away from the enemy
;4480:		if (dist > attack_dist + attack_range) {
ADDRLP4 60
INDIRF4
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRF4
ADDF4
LEF4 $1356
line 4481
;4481:			if (trap_BotMoveInDirection(bs->ms, forward, /*400*/speed, movetype)) return moveresult;	// JUHOX
ADDRFP4 4
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
ADDRLP4 208
INDIRF4
ARGF4
ADDRLP4 204
INDIRI4
ARGI4
ADDRLP4 412
ADDRGP4 trap_BotMoveInDirection
CALLI4
ASGNI4
ADDRLP4 412
INDIRI4
CNSTI4 0
EQI4 $1358
ADDRFP4 0
INDIRP4
ADDRLP4 224
INDIRB
ASGNB 52
ADDRGP4 $1265
JUMPV
LABELV $1358
line 4482
;4482:		}
LABELV $1356
line 4483
;4483:		if (dist < attack_dist - attack_range) {
ADDRLP4 60
INDIRF4
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRF4
SUBF4
GEF4 $1360
line 4484
;4484:			if (trap_BotMoveInDirection(bs->ms, backward, /*400*/speed, movetype)) return moveresult;	// JUHOX
ADDRFP4 4
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
ARGP4
ADDRLP4 208
INDIRF4
ARGF4
ADDRLP4 204
INDIRI4
ARGI4
ADDRLP4 412
ADDRGP4 trap_BotMoveInDirection
CALLI4
ASGNI4
ADDRLP4 412
INDIRI4
CNSTI4 0
EQI4 $1362
ADDRFP4 0
INDIRP4
ADDRLP4 224
INDIRB
ASGNB 52
ADDRGP4 $1265
JUMPV
LABELV $1362
line 4485
;4485:		}
LABELV $1360
line 4489
;4486:#if 0	// JUHOX: movement failed or distance is ok. if bot is skilled enough, try strafing.
;4487:		return moveresult;
;4488:#else
;4489:		if (attack_skill <= 0.4) return moveresult;
ADDRLP4 276
INDIRF4
CNSTF4 1053609165
GTF4 $1364
ADDRFP4 0
INDIRP4
ADDRLP4 224
INDIRB
ASGNB 52
ADDRGP4 $1265
JUMPV
LABELV $1364
line 4490
;4490:		if (attack_dist <= 0) {
ADDRLP4 52
INDIRF4
CNSTF4 0
GTF4 $1366
line 4491
;4491:			bs->attackchase_time = FloatTime() + 10;
ADDRFP4 4
INDIRP4
CNSTI4 7216
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1092616192
ADDF4
ASGNF4
line 4492
;4492:			return moveresult;
ADDRFP4 0
INDIRP4
ADDRLP4 224
INDIRB
ASGNB 52
ADDRGP4 $1265
JUMPV
LABELV $1366
line 4495
;4493:		}
;4494:#endif
;4495:	}
LABELV $1350
line 4498
;4496:#if 1	// JUHOX: check if we should move at all
;4497:	if (
;4498:		level.clients[bs->client].lasthurt_time < level.time - 3000 &&
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 828
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 3000
SUBI4
GEI4 $1368
ADDRLP4 60
INDIRF4
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRF4
SUBF4
LTF4 $1368
ADDRLP4 60
INDIRF4
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRF4
ADDF4
GTF4 $1368
line 4501
;4499:		dist >= attack_dist-attack_range &&
;4500:		dist <= attack_dist+attack_range
;4501:	) {
line 4504
;4502:		vec3_t angles;
;4503:
;4504:		vectoangles(backward, angles);
ADDRLP4 36
ARGP4
ADDRLP4 424
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 4506
;4505:		if (
;4506:			!InFieldOfVision(entinfo.angles, 90, angles) ||
ADDRLP4 64+36
ARGP4
CNSTF4 1119092736
ARGF4
ADDRLP4 424
ARGP4
ADDRLP4 436
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 436
INDIRI4
CNSTI4 0
EQI4 $1374
ADDRFP4 4
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
ARGI4
ADDRLP4 440
ADDRGP4 IsPlayerFighting
CALLI4
ASGNI4
ADDRLP4 440
INDIRI4
CNSTI4 0
NEI4 $1371
LABELV $1374
line 4508
;4507:			!IsPlayerFighting(bs->enemy)
;4508:		) {
line 4509
;4509:			if (bs->couldNotSeeEnemyWhileDucked_time < FloatTime() - 3) {
ADDRFP4 4
INDIRP4
CNSTI4 7420
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1077936128
SUBF4
GEF4 $1375
line 4510
;4510:				trap_EA_Crouch(bs->client);
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Crouch
CALLV
pop
line 4511
;4511:			}
LABELV $1375
line 4512
;4512:			return moveresult;
ADDRFP4 0
INDIRP4
ADDRLP4 224
INDIRB
ASGNB 52
ADDRGP4 $1265
JUMPV
LABELV $1371
line 4514
;4513:		}
;4514:	}
LABELV $1368
line 4532
;4515:#endif
;4516:#if 0	// JUHOX: new attack strafe code
;4517:	//increase the strafe time
;4518:	bs->attackstrafe_time += bs->thinktime;
;4519:	//get the strafe change time
;4520:	strafechange_time = 0.4 + (1 - attack_skill) * 0.2;
;4521:	if (attack_skill > 0.7) strafechange_time += crandom() * 0.2;
;4522:	//if the strafe direction should be changed
;4523:	if (bs->attackstrafe_time > strafechange_time) {
;4524:		//some magic number :)
;4525:		if (random() > 0.935) {
;4526:			//flip the strafe direction
;4527:			bs->flags ^= BFL_STRAFERIGHT;
;4528:			bs->attackstrafe_time = 0;
;4529:		}
;4530:	}
;4531:#else
;4532:	if (bs->attackstrafe_time < FloatTime()) {
ADDRFP4 4
INDIRP4
CNSTI4 7208
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $1377
line 4533
;4533:		if (bs->attackstrafe_time > 0) {
ADDRFP4 4
INDIRP4
CNSTI4 7208
ADDP4
INDIRF4
CNSTF4 0
LEF4 $1379
line 4534
;4534:			bs->flags ^= BFL_STRAFERIGHT;
ADDRLP4 424
ADDRFP4 4
INDIRP4
CNSTI4 5992
ADDP4
ASGNP4
ADDRLP4 424
INDIRP4
ADDRLP4 424
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 4535
;4535:		}
LABELV $1379
line 4536
;4536:		bs->attackstrafe_time = FloatTime() + 1.0 + (1.5 - attack_skill) * (1.0 + random());
ADDRLP4 424
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRFP4 4
INDIRP4
CNSTI4 7208
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
ADDF4
CNSTF4 1069547520
ADDRLP4 276
INDIRF4
SUBF4
ADDRLP4 424
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 424
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1065353216
ADDF4
MULF4
ADDF4
ASGNF4
line 4537
;4537:	}
LABELV $1377
line 4540
;4538:#endif
;4539:	//
;4540:	for (i = 0; i < 2; i++) {
ADDRLP4 48
CNSTI4 0
ASGNI4
LABELV $1381
line 4541
;4541:		hordir[0] = forward[0];
ADDRLP4 12
ADDRLP4 24
INDIRF4
ASGNF4
line 4542
;4542:		hordir[1] = forward[1];
ADDRLP4 12+4
ADDRLP4 24+4
INDIRF4
ASGNF4
line 4543
;4543:		hordir[2] = 0;
ADDRLP4 12+8
CNSTF4 0
ASGNF4
line 4544
;4544:		VectorNormalize(hordir);
ADDRLP4 12
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 4546
;4545:		//get the sideward vector
;4546:		CrossProduct(hordir, up, sideward);
ADDRLP4 12
ARGP4
ADDRLP4 212
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 4548
;4547:		//reverse the vector depending on the strafe direction
;4548:		if (bs->flags & BFL_STRAFERIGHT) VectorNegate(sideward, sideward);
ADDRFP4 4
INDIRP4
CNSTI4 5992
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1388
ADDRLP4 0
ADDRLP4 0
INDIRF4
NEGF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
NEGF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
NEGF4
ASGNF4
LABELV $1388
line 4550
;4549:		//randomly go back a little
;4550:		if (random() > 0.9) {
ADDRLP4 424
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 424
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 424
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1063675494
LEF4 $1394
line 4551
;4551:			VectorAdd(sideward, backward, sideward);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 36
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 36+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 36+8
INDIRF4
ADDF4
ASGNF4
line 4552
;4552:		}
ADDRGP4 $1395
JUMPV
LABELV $1394
line 4553
;4553:		else {
line 4555
;4554:			//walk forward or backward to get at the ideal attack distance
;4555:			if (dist > attack_dist + attack_range) {
ADDRLP4 60
INDIRF4
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRF4
ADDF4
LEF4 $1402
line 4556
;4556:				VectorAdd(sideward, forward, sideward);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 24
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 24+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 24+8
INDIRF4
ADDF4
ASGNF4
line 4557
;4557:			}
ADDRGP4 $1403
JUMPV
LABELV $1402
line 4558
;4558:			else if (dist < attack_dist - attack_range) {
ADDRLP4 60
INDIRF4
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRF4
SUBF4
GEF4 $1410
line 4559
;4559:				VectorAdd(sideward, backward, sideward);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 36
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 36+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 36+8
INDIRF4
ADDF4
ASGNF4
line 4560
;4560:			}
LABELV $1410
LABELV $1403
line 4561
;4561:		}
LABELV $1395
line 4563
;4562:		//perform the movement
;4563:		if (trap_BotMoveInDirection(bs->ms, sideward, /*400*/speed, movetype))	// JUHOX
ADDRFP4 4
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 208
INDIRF4
ARGF4
ADDRLP4 204
INDIRI4
ARGI4
ADDRLP4 428
ADDRGP4 trap_BotMoveInDirection
CALLI4
ASGNI4
ADDRLP4 428
INDIRI4
CNSTI4 0
EQI4 $1418
line 4564
;4564:			return moveresult;
ADDRFP4 0
INDIRP4
ADDRLP4 224
INDIRB
ASGNB 52
ADDRGP4 $1265
JUMPV
LABELV $1418
line 4566
;4565:		//movement failed, flip the strafe direction
;4566:		bs->flags ^= BFL_STRAFERIGHT;
ADDRLP4 432
ADDRFP4 4
INDIRP4
CNSTI4 5992
ADDP4
ASGNP4
ADDRLP4 432
INDIRP4
ADDRLP4 432
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 4567
;4567:		bs->attackstrafe_time = 0;
ADDRFP4 4
INDIRP4
CNSTI4 7208
ADDP4
CNSTF4 0
ASGNF4
line 4568
;4568:	}
LABELV $1382
line 4540
ADDRLP4 48
ADDRLP4 48
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 2
LTI4 $1381
line 4571
;4569:	//bot couldn't do any usefull movement
;4570://	bs->attackchase_time = AAS_Time() + 6;
;4571:	return moveresult;
ADDRFP4 0
INDIRP4
ADDRLP4 224
INDIRB
ASGNB 52
LABELV $1265
endproc BotAttackMove 444 16
export BotSameTeam
proc BotSameTeam 16 8
line 4579
;4572:}
;4573:
;4574:/*
;4575:==================
;4576:BotSameTeam
;4577:==================
;4578:*/
;4579:int BotSameTeam(bot_state_t *bs, int entnum) {
line 4607
;4580:	// JUHOX: use OnSameTeam() for BotSameTeam
;4581:#if 0
;4582:	char info1[1024], info2[1024];
;4583:
;4584:	if (bs->client < 0 || bs->client >= MAX_CLIENTS) {
;4585:		//BotAI_Print(PRT_ERROR, "BotSameTeam: client out of range\n");
;4586:		return qfalse;
;4587:	}
;4588:	if (entnum < 0 || entnum >= MAX_CLIENTS) {
;4589:		//BotAI_Print(PRT_ERROR, "BotSameTeam: client out of range\n");
;4590:		return qfalse;
;4591:	}
;4592:	if ( gametype >= GT_TEAM ) {
;4593:		// JUHOX: faster team check
;4594:#if 0
;4595:		trap_GetConfigstring(CS_PLAYERS+bs->client, info1, sizeof(info1));
;4596:		trap_GetConfigstring(CS_PLAYERS+entnum, info2, sizeof(info2));
;4597:		//
;4598:		if (atoi(Info_ValueForKey(info1, "t")) == atoi(Info_ValueForKey(info2, "t"))) return qtrue;
;4599:#else
;4600:		if (!g_entities[entnum].inuse) return qfalse;
;4601:		if (!g_entities[entnum].client) return qfalse;
;4602:		if (bs->cur_ps.persistant[PERS_TEAM] == g_entities[entnum].client->ps.persistant[PERS_TEAM]) return qtrue;
;4603:#endif
;4604:	}
;4605:	return qfalse;
;4606:#else
;4607:	if (bs->client < 0 || bs->client >= MAX_CLIENTS) return qfalse;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 0
LTI4 $1423
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 64
LTI4 $1421
LABELV $1423
CNSTI4 0
RETI4
ADDRGP4 $1420
JUMPV
LABELV $1421
line 4608
;4608:	if (entnum < 0 || entnum >= MAX_GENTITIES) return qfalse;
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $1426
ADDRLP4 4
INDIRI4
CNSTI4 1024
LTI4 $1424
LABELV $1426
CNSTI4 0
RETI4
ADDRGP4 $1420
JUMPV
LABELV $1424
line 4609
;4609:	if (!g_entities[entnum].inuse) return qfalse;
ADDRFP4 4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1427
CNSTI4 0
RETI4
ADDRGP4 $1420
JUMPV
LABELV $1427
line 4610
;4610:	return OnSameTeam(&g_entities[bs->client], &g_entities[entnum]);
ADDRLP4 8
ADDRGP4 g_entities
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRLP4 8
INDIRP4
ADDP4
ARGP4
ADDRFP4 4
INDIRI4
CNSTI4 844
MULI4
ADDRLP4 8
INDIRP4
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
RETI4
LABELV $1420
endproc BotSameTeam 16 8
export InFieldOfVision
proc InFieldOfVision 28 4
line 4620
;4611:#endif
;4612:}
;4613:
;4614:/*
;4615:==================
;4616:InFieldOfVision
;4617:==================
;4618:*/
;4619:qboolean InFieldOfVision(vec3_t viewangles, float fov, vec3_t angles)
;4620:{
line 4624
;4621:	int i;
;4622:	float diff, angle;
;4623:
;4624:	for (i = 0; i < 2; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1431
line 4625
;4625:		angle = AngleMod(viewangles[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 12
INDIRF4
ASGNF4
line 4626
;4626:		angles[i] = AngleMod(angles[i]);
ADDRLP4 20
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
INDIRP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
INDIRP4
ADDP4
ADDRLP4 24
INDIRF4
ASGNF4
line 4627
;4627:		diff = angles[i] - angle;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
SUBF4
ASGNF4
line 4628
;4628:		if (angles[i] > angle) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $1435
line 4629
;4629:			if (diff > 180.0) diff -= 360.0;
ADDRLP4 4
INDIRF4
CNSTF4 1127481344
LEF4 $1436
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
line 4630
;4630:		}
ADDRGP4 $1436
JUMPV
LABELV $1435
line 4631
;4631:		else {
line 4632
;4632:			if (diff < -180.0) diff += 360.0;
ADDRLP4 4
INDIRF4
CNSTF4 3274964992
GEF4 $1439
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
LABELV $1439
line 4633
;4633:		}
LABELV $1436
line 4634
;4634:		if (diff > 0) {
ADDRLP4 4
INDIRF4
CNSTF4 0
LEF4 $1441
line 4635
;4635:			if (diff > fov * 0.5) return qfalse;
ADDRLP4 4
INDIRF4
ADDRFP4 4
INDIRF4
CNSTF4 1056964608
MULF4
LEF4 $1442
CNSTI4 0
RETI4
ADDRGP4 $1430
JUMPV
line 4636
;4636:		}
LABELV $1441
line 4637
;4637:		else {
line 4638
;4638:			if (diff < -fov * 0.5) return qfalse;
ADDRLP4 4
INDIRF4
ADDRFP4 4
INDIRF4
NEGF4
CNSTF4 1056964608
MULF4
GEF4 $1445
CNSTI4 0
RETI4
ADDRGP4 $1430
JUMPV
LABELV $1445
line 4639
;4639:		}
LABELV $1442
line 4640
;4640:	}
LABELV $1432
line 4624
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LTI4 $1431
line 4641
;4641:	return qtrue;
CNSTI4 1
RETI4
LABELV $1430
endproc InFieldOfVision 28 4
export BotEntityVisible
proc BotEntityVisible 400 28
line 4681
;4642:}
;4643:
;4644:/*
;4645:==================
;4646:JUHOX: EntityIsAudible
;4647:==================
;4648:*/
;4649:/*
;4650:int EntityIsAudible(aas_entityinfo_t* entinfo) {
;4651:	switch (entinfo->weapon) {
;4652:	case WP_LIGHTNING:
;4653:	case WP_RAILGUN:
;4654:	case WP_BFG:
;4655:		return qtrue;
;4656:	}
;4657:	if (g_entities[entinfo->number].eventTime < level.time - 900) return qfalse;
;4658:	switch (g_entities[entinfo->number].s.event & ~EV_EVENT_BITS) {
;4659:	case EV_NONE:
;4660:	case EV_STEP_4:
;4661:	case EV_STEP_8:
;4662:	case EV_STEP_12:
;4663:	case EV_STEP_16:
;4664:		return qfalse;
;4665:	}
;4666:	return qtrue;
;4667:}
;4668:*/
;4669:
;4670:/*
;4671:==================
;4672:BotEntityVisible
;4673:
;4674:returns visibility in the range [0, 1] taking fog and water surfaces into account
;4675:==================
;4676:*/
;4677:// JUHOX: new parameter set for BotEntityVisible()
;4678:#if 0
;4679:float BotEntityVisible(int viewer, vec3_t eye, vec3_t viewangles, float fov, int ent) {
;4680:#else
;4681:float BotEntityVisible(playerState_t* ps, float fov, int ent) {
line 4695
;4682:#endif
;4683:	int i, contents_mask, passent, hitent, infog, inwater, otherinfog, pc;
;4684:	float squaredfogdist, waterfactor, vis, bestvis;
;4685:	bsp_trace_t trace;
;4686:	aas_entityinfo_t entinfo;
;4687:	vec3_t dir, entangles, start, end, middle;
;4688:
;4689:	// JUHOX: some vars to support the old parameters
;4690:#if 1
;4691:	int viewer;
;4692:	vec3_t eye;
;4693:	vec3_t viewangles;
;4694:
;4695:	viewer = ps->clientNum;
ADDRLP4 300
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 4696
;4696:	VectorCopy(ps->origin, eye);
ADDRLP4 104
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 4697
;4697:	eye[2] += ps->viewheight;
ADDRLP4 104+8
ADDRLP4 104+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 4698
;4698:	VectorCopy(ps->viewangles, viewangles);
ADDRLP4 348
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
INDIRB
ASGNB 12
line 4701
;4699:#endif
;4700:
;4701:	if (ent < 0) return 0;	// JUHOX: safety check
ADDRFP4 8
INDIRI4
CNSTI4 0
GEI4 $1449
CNSTF4 0
RETF4
ADDRGP4 $1447
JUMPV
LABELV $1449
line 4704
;4702:
;4703:	//calculate middle of bounding box
;4704:	BotEntityInfo(ent, &entinfo);
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 148
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 4705
;4705:	if (ent < MAX_CLIENTS && EntityIsDead(&entinfo)) return 0;	// JUHOX: a dead entity is not visible
ADDRFP4 8
INDIRI4
CNSTI4 64
GEI4 $1451
ADDRLP4 148
ARGP4
ADDRLP4 360
ADDRGP4 EntityIsDead
CALLI4
ASGNI4
ADDRLP4 360
INDIRI4
CNSTI4 0
EQI4 $1451
CNSTF4 0
RETF4
ADDRGP4 $1447
JUMPV
LABELV $1451
line 4706
;4706:	VectorAdd(entinfo.mins, entinfo.maxs, middle);
ADDRLP4 84
ADDRLP4 148+72
INDIRF4
ADDRLP4 148+84
INDIRF4
ADDF4
ASGNF4
ADDRLP4 84+4
ADDRLP4 148+72+4
INDIRF4
ADDRLP4 148+84+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 84+8
ADDRLP4 148+72+8
INDIRF4
ADDRLP4 148+84+8
INDIRF4
ADDF4
ASGNF4
line 4707
;4707:	VectorScale(middle, 0.5, middle);
ADDRLP4 84
ADDRLP4 84
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 84+4
ADDRLP4 84+4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 84+8
ADDRLP4 84+8
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 4708
;4708:	VectorAdd(entinfo.origin, middle, middle);
ADDRLP4 84
ADDRLP4 148+24
INDIRF4
ADDRLP4 84
INDIRF4
ADDF4
ASGNF4
ADDRLP4 84+4
ADDRLP4 148+24+4
INDIRF4
ADDRLP4 84+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 84+8
ADDRLP4 148+24+8
INDIRF4
ADDRLP4 84+8
INDIRF4
ADDF4
ASGNF4
line 4713
;4709:	//check if entity is within field of vision
;4710:	// JUHOX: take invisibility and audibility into account
;4711:#if 1
;4712:	if (
;4713:		ps->persistant[PERS_ATTACKER] == ent &&
ADDRFP4 0
INDIRP4
CNSTI4 272
ADDP4
INDIRI4
ADDRFP4 8
INDIRI4
NEI4 $1478
ADDRLP4 300
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1478
ADDRLP4 300
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 824
ADDP4
INDIRI4
CNSTI4 7
EQI4 $1478
ADDRLP4 300
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 828
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 500
SUBI4
LEI4 $1478
line 4717
;4714:		g_entities[viewer].client &&
;4715:		g_entities[viewer].client->lasthurt_mod != MOD_CHARGE &&
;4716:		g_entities[viewer].client->lasthurt_time > level.time - 500
;4717:	) {
line 4718
;4718:		return 1;
CNSTF4 1065353216
RETF4
ADDRGP4 $1447
JUMPV
LABELV $1478
line 4721
;4719:	}
;4720:#if MONSTER_MODE
;4721:	if (G_IsAttackingGuard(ent)) fov = 360;
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 368
ADDRGP4 G_IsAttackingGuard
CALLI4
ASGNI4
ADDRLP4 368
INDIRI4
CNSTI4 0
EQI4 $1484
ADDRFP4 4
CNSTF4 1135869952
ASGNF4
LABELV $1484
line 4723
;4722:#endif
;4723:	if (fov < 360) {
ADDRFP4 4
INDIRF4
CNSTF4 1135869952
GEF4 $1486
line 4724
;4724:		if (EntityIsInvisible(viewer, &entinfo) && DistanceSquared(middle, eye) > 100*100) {
ADDRLP4 300
INDIRI4
ARGI4
ADDRLP4 148
ARGP4
ADDRLP4 372
ADDRGP4 EntityIsInvisible
CALLI4
ASGNI4
ADDRLP4 372
INDIRI4
CNSTI4 0
EQI4 $1488
ADDRLP4 84
ARGP4
ADDRLP4 104
ARGP4
ADDRLP4 376
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 376
INDIRF4
CNSTF4 1176256512
LEF4 $1488
line 4728
;4725:			bot_state_t* bs;
;4726:			float alertness;
;4727:
;4728:			bs = BotAI_IsBot(viewer);
ADDRLP4 300
INDIRI4
ARGI4
ADDRLP4 388
ADDRGP4 BotAI_IsBot
CALLP4
ASGNP4
ADDRLP4 380
ADDRLP4 388
INDIRP4
ASGNP4
line 4729
;4729:			if (!bs) return 0;
ADDRLP4 380
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1490
CNSTF4 0
RETF4
ADDRGP4 $1447
JUMPV
LABELV $1490
line 4730
;4730:			alertness = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_ALERTNESS, 0, 1);
ADDRLP4 380
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 46
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 392
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 384
ADDRLP4 392
INDIRF4
ASGNF4
line 4731
;4731:			fov *= 0.75 * alertness * alertness;
ADDRLP4 396
ADDRLP4 384
INDIRF4
ASGNF4
ADDRFP4 4
ADDRFP4 4
INDIRF4
ADDRLP4 396
INDIRF4
CNSTF4 1061158912
MULF4
ADDRLP4 396
INDIRF4
MULF4
MULF4
ASGNF4
line 4732
;4732:			fov *= bs->settings.skill / 5.0;
ADDRFP4 4
ADDRFP4 4
INDIRF4
ADDRLP4 380
INDIRP4
CNSTI4 4752
ADDP4
INDIRF4
CNSTF4 1045220557
MULF4
MULF4
ASGNF4
line 4733
;4733:		}
LABELV $1488
line 4739
;4734:		/*
;4735:		if (ps->weaponstate < WEAPON_FIRING) {
;4736:			fov /= 2.0;
;4737:		}
;4738:		*/
;4739:		if (ps->powerups[PW_CHARGE]) {
ADDRFP4 0
INDIRP4
CNSTI4 352
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1492
line 4742
;4740:			float disturbance;
;4741:	
;4742:			disturbance = 0.0001 * (ps->powerups[PW_CHARGE] - level.time) + 0.5;
ADDRLP4 380
ADDRFP4 0
INDIRP4
CNSTI4 352
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
SUBI4
CVIF4 4
CNSTF4 953267991
MULF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 4743
;4743:			if (disturbance > 1.0) fov /= disturbance;
ADDRLP4 380
INDIRF4
CNSTF4 1065353216
LEF4 $1495
ADDRFP4 4
ADDRFP4 4
INDIRF4
ADDRLP4 380
INDIRF4
DIVF4
ASGNF4
LABELV $1495
line 4744
;4744:		}
LABELV $1492
line 4745
;4745:	}
LABELV $1486
line 4753
;4746:	/*
;4747:	if (fov < 360 && EntityIsAudible(&entinfo) && trap_InPVSIgnorePortals(ps->origin, entinfo.origin)) {
;4748:		fov *= 3.0;
;4749:		if (fov > 360) fov = 360;
;4750:	}
;4751:	*/
;4752:#endif
;4753:	VectorSubtract(middle, eye, dir);
ADDRLP4 288
ADDRLP4 84
INDIRF4
ADDRLP4 104
INDIRF4
SUBF4
ASGNF4
ADDRLP4 288+4
ADDRLP4 84+4
INDIRF4
ADDRLP4 104+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 288+8
ADDRLP4 84+8
INDIRF4
ADDRLP4 104+8
INDIRF4
SUBF4
ASGNF4
line 4754
;4754:	vectoangles(dir, entangles);
ADDRLP4 288
ARGP4
ADDRLP4 336
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 4755
;4755:	if (!InFieldOfVision(viewangles, fov, entangles)) return 0;
ADDRLP4 348
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRLP4 336
ARGP4
ADDRLP4 372
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 372
INDIRI4
CNSTI4 0
NEI4 $1503
CNSTF4 0
RETF4
ADDRGP4 $1447
JUMPV
LABELV $1503
line 4756
;4756:	if (EntityIsInvisible(viewer, &entinfo) && VectorLength(dir) > 1500) return 0;	// JUHOX
ADDRLP4 300
INDIRI4
ARGI4
ADDRLP4 148
ARGP4
ADDRLP4 376
ADDRGP4 EntityIsInvisible
CALLI4
ASGNI4
ADDRLP4 376
INDIRI4
CNSTI4 0
EQI4 $1505
ADDRLP4 288
ARGP4
ADDRLP4 380
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 380
INDIRF4
CNSTF4 1153138688
LEF4 $1505
CNSTF4 0
RETF4
ADDRGP4 $1447
JUMPV
LABELV $1505
line 4758
;4757:	//
;4758:	pc = trap_AAS_PointContents(eye);
ADDRLP4 104
ARGP4
ADDRLP4 384
ADDRGP4 trap_AAS_PointContents
CALLI4
ASGNI4
ADDRLP4 332
ADDRLP4 384
INDIRI4
ASGNI4
line 4759
;4759:	infog = (pc & CONTENTS_FOG);
ADDRLP4 328
ADDRLP4 332
INDIRI4
CNSTI4 64
BANDI4
ASGNI4
line 4760
;4760:	inwater = (pc & (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER));
ADDRLP4 324
ADDRLP4 332
INDIRI4
CNSTI4 56
BANDI4
ASGNI4
line 4762
;4761:	//
;4762:	bestvis = 0;
ADDRLP4 312
CNSTF4 0
ASGNF4
line 4763
;4763:	for (i = 0; i < 3; i++) {
ADDRLP4 100
CNSTI4 0
ASGNI4
LABELV $1507
line 4767
;4764:		//if the point is not in potential visible sight
;4765:		//if (!AAS_inPVS(eye, middle)) continue;
;4766:		//
;4767:		contents_mask = CONTENTS_SOLID|CONTENTS_PLAYERCLIP;
ADDRLP4 96
CNSTI4 65537
ASGNI4
line 4768
;4768:		passent = viewer;
ADDRLP4 128
ADDRLP4 300
INDIRI4
ASGNI4
line 4769
;4769:		hitent = ent;
ADDRLP4 144
ADDRFP4 8
INDIRI4
ASGNI4
line 4770
;4770:		VectorCopy(eye, start);
ADDRLP4 132
ADDRLP4 104
INDIRB
ASGNB 12
line 4771
;4771:		VectorCopy(middle, end);
ADDRLP4 116
ADDRLP4 84
INDIRB
ASGNB 12
line 4773
;4772:		//if the entity is in water, lava or slime
;4773:		if (trap_AAS_PointContents(middle) & (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER)) {
ADDRLP4 84
ARGP4
ADDRLP4 388
ADDRGP4 trap_AAS_PointContents
CALLI4
ASGNI4
ADDRLP4 388
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $1511
line 4774
;4774:			contents_mask |= (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER);
ADDRLP4 96
ADDRLP4 96
INDIRI4
CNSTI4 56
BORI4
ASGNI4
line 4775
;4775:		}
LABELV $1511
line 4777
;4776:		//if eye is in water, lava or slime
;4777:		if (inwater) {
ADDRLP4 324
INDIRI4
CNSTI4 0
EQI4 $1513
line 4778
;4778:			if (!(contents_mask & (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER))) {
ADDRLP4 96
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
NEI4 $1515
line 4779
;4779:				passent = ent;
ADDRLP4 128
ADDRFP4 8
INDIRI4
ASGNI4
line 4780
;4780:				hitent = viewer;
ADDRLP4 144
ADDRLP4 300
INDIRI4
ASGNI4
line 4781
;4781:				VectorCopy(middle, start);
ADDRLP4 132
ADDRLP4 84
INDIRB
ASGNB 12
line 4782
;4782:				VectorCopy(eye, end);
ADDRLP4 116
ADDRLP4 104
INDIRB
ASGNB 12
line 4783
;4783:			}
LABELV $1515
line 4784
;4784:			contents_mask ^= (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER);
ADDRLP4 96
ADDRLP4 96
INDIRI4
CNSTI4 56
BXORI4
ASGNI4
line 4785
;4785:		}
LABELV $1513
line 4787
;4786:		//trace from start to end
;4787:		BotAI_Trace(&trace, start, NULL, NULL, end, passent, contents_mask);
ADDRLP4 0
ARGP4
ADDRLP4 132
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 116
ARGP4
ADDRLP4 128
INDIRI4
ARGI4
ADDRLP4 96
INDIRI4
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 4789
;4788:		//if water was hit
;4789:		waterfactor = 1.0;
ADDRLP4 304
CNSTF4 1065353216
ASGNF4
line 4790
;4790:		if (trace.contents & (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER)) {
ADDRLP4 0+76
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $1517
line 4792
;4791:			//if the water surface is translucent
;4792:			if (1) {
line 4794
;4793:				//trace through the water
;4794:				contents_mask &= ~(CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER);
ADDRLP4 96
ADDRLP4 96
INDIRI4
CNSTI4 -57
BANDI4
ASGNI4
line 4795
;4795:				BotAI_Trace(&trace, trace.endpos, NULL, NULL, end, passent, contents_mask);
ADDRLP4 0
ARGP4
ADDRLP4 0+12
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 116
ARGP4
ADDRLP4 128
INDIRI4
ARGI4
ADDRLP4 96
INDIRI4
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 4796
;4796:				waterfactor = 0.5;
ADDRLP4 304
CNSTF4 1056964608
ASGNF4
line 4797
;4797:			}
LABELV $1520
line 4798
;4798:		}
LABELV $1517
line 4800
;4799:		//if a full trace or the hitent was hit
;4800:		if (trace.fraction >= 1 || trace.ent == hitent) {
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
GEF4 $1527
ADDRLP4 0+80
INDIRI4
ADDRLP4 144
INDIRI4
NEI4 $1523
LABELV $1527
line 4803
;4801:			//check for fog, assuming there's only one fog brush where
;4802:			//either the viewer or the entity is in or both are in
;4803:			otherinfog = (trap_AAS_PointContents(middle) & CONTENTS_FOG);
ADDRLP4 84
ARGP4
ADDRLP4 392
ADDRGP4 trap_AAS_PointContents
CALLI4
ASGNI4
ADDRLP4 320
ADDRLP4 392
INDIRI4
CNSTI4 64
BANDI4
ASGNI4
line 4804
;4804:			if (infog && otherinfog) {
ADDRLP4 328
INDIRI4
CNSTI4 0
EQI4 $1528
ADDRLP4 320
INDIRI4
CNSTI4 0
EQI4 $1528
line 4805
;4805:				VectorSubtract(trace.endpos, eye, dir);
ADDRLP4 288
ADDRLP4 0+12
INDIRF4
ADDRLP4 104
INDIRF4
SUBF4
ASGNF4
ADDRLP4 288+4
ADDRLP4 0+12+4
INDIRF4
ADDRLP4 104+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 288+8
ADDRLP4 0+12+8
INDIRF4
ADDRLP4 104+8
INDIRF4
SUBF4
ASGNF4
line 4806
;4806:				squaredfogdist = VectorLengthSquared(dir);
ADDRLP4 288
ARGP4
ADDRLP4 396
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 316
ADDRLP4 396
INDIRF4
ASGNF4
line 4807
;4807:			}
ADDRGP4 $1529
JUMPV
LABELV $1528
line 4808
;4808:			else if (infog) {
ADDRLP4 328
INDIRI4
CNSTI4 0
EQI4 $1539
line 4809
;4809:				VectorCopy(trace.endpos, start);
ADDRLP4 132
ADDRLP4 0+12
INDIRB
ASGNB 12
line 4810
;4810:				BotAI_Trace(&trace, start, NULL, NULL, eye, viewer, CONTENTS_FOG);
ADDRLP4 0
ARGP4
ADDRLP4 132
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 104
ARGP4
ADDRLP4 300
INDIRI4
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 4811
;4811:				VectorSubtract(eye, trace.endpos, dir);
ADDRLP4 288
ADDRLP4 104
INDIRF4
ADDRLP4 0+12
INDIRF4
SUBF4
ASGNF4
ADDRLP4 288+4
ADDRLP4 104+4
INDIRF4
ADDRLP4 0+12+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 288+8
ADDRLP4 104+8
INDIRF4
ADDRLP4 0+12+8
INDIRF4
SUBF4
ASGNF4
line 4812
;4812:				squaredfogdist = VectorLengthSquared(dir);
ADDRLP4 288
ARGP4
ADDRLP4 396
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 316
ADDRLP4 396
INDIRF4
ASGNF4
line 4813
;4813:			}
ADDRGP4 $1540
JUMPV
LABELV $1539
line 4814
;4814:			else if (otherinfog) {
ADDRLP4 320
INDIRI4
CNSTI4 0
EQI4 $1551
line 4815
;4815:				VectorCopy(trace.endpos, end);
ADDRLP4 116
ADDRLP4 0+12
INDIRB
ASGNB 12
line 4816
;4816:				BotAI_Trace(&trace, eye, NULL, NULL, end, viewer, CONTENTS_FOG);
ADDRLP4 0
ARGP4
ADDRLP4 104
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 116
ARGP4
ADDRLP4 300
INDIRI4
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 4817
;4817:				VectorSubtract(end, trace.endpos, dir);
ADDRLP4 288
ADDRLP4 116
INDIRF4
ADDRLP4 0+12
INDIRF4
SUBF4
ASGNF4
ADDRLP4 288+4
ADDRLP4 116+4
INDIRF4
ADDRLP4 0+12+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 288+8
ADDRLP4 116+8
INDIRF4
ADDRLP4 0+12+8
INDIRF4
SUBF4
ASGNF4
line 4818
;4818:				squaredfogdist = VectorLengthSquared(dir);
ADDRLP4 288
ARGP4
ADDRLP4 396
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 316
ADDRLP4 396
INDIRF4
ASGNF4
line 4819
;4819:			}
ADDRGP4 $1552
JUMPV
LABELV $1551
line 4820
;4820:			else {
line 4822
;4821:				//if the entity and the viewer are not in fog assume there's no fog in between
;4822:				squaredfogdist = 0;
ADDRLP4 316
CNSTF4 0
ASGNF4
line 4823
;4823:			}
LABELV $1552
LABELV $1540
LABELV $1529
line 4825
;4824:			//decrease visibility with the view distance through fog
;4825:			vis = 1 / ((squaredfogdist * 0.001) < 1 ? 1 : (squaredfogdist * 0.001));
ADDRLP4 316
INDIRF4
CNSTF4 981668463
MULF4
CNSTF4 1065353216
GEF4 $1564
ADDRLP4 396
CNSTF4 1065353216
ASGNF4
ADDRGP4 $1565
JUMPV
LABELV $1564
ADDRLP4 396
ADDRLP4 316
INDIRF4
CNSTF4 981668463
MULF4
ASGNF4
LABELV $1565
ADDRLP4 308
CNSTF4 1065353216
ADDRLP4 396
INDIRF4
DIVF4
ASGNF4
line 4827
;4826:			//if entering water visibility is reduced
;4827:			vis *= waterfactor;
ADDRLP4 308
ADDRLP4 308
INDIRF4
ADDRLP4 304
INDIRF4
MULF4
ASGNF4
line 4829
;4828:			//
;4829:			if (vis > bestvis) bestvis = vis;
ADDRLP4 308
INDIRF4
ADDRLP4 312
INDIRF4
LEF4 $1566
ADDRLP4 312
ADDRLP4 308
INDIRF4
ASGNF4
LABELV $1566
line 4831
;4830:			//if pretty much no fog
;4831:			if (bestvis >= 0.95) return bestvis;
ADDRLP4 312
INDIRF4
CNSTF4 1064514355
LTF4 $1568
ADDRLP4 312
INDIRF4
RETF4
ADDRGP4 $1447
JUMPV
LABELV $1568
line 4832
;4832:		}
LABELV $1523
line 4834
;4833:		//check bottom and top of bounding box as well
;4834:		if (i == 0) middle[2] += entinfo.mins[2];
ADDRLP4 100
INDIRI4
CNSTI4 0
NEI4 $1570
ADDRLP4 84+8
ADDRLP4 84+8
INDIRF4
ADDRLP4 148+72+8
INDIRF4
ADDF4
ASGNF4
ADDRGP4 $1571
JUMPV
LABELV $1570
line 4835
;4835:		else if (i == 1) middle[2] += entinfo.maxs[2] - entinfo.mins[2];
ADDRLP4 100
INDIRI4
CNSTI4 1
NEI4 $1575
ADDRLP4 84+8
ADDRLP4 84+8
INDIRF4
ADDRLP4 148+84+8
INDIRF4
ADDRLP4 148+72+8
INDIRF4
SUBF4
ADDF4
ASGNF4
LABELV $1575
LABELV $1571
line 4836
;4836:	}
LABELV $1508
line 4763
ADDRLP4 100
ADDRLP4 100
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 3
LTI4 $1507
line 4837
;4837:	return bestvis;
ADDRLP4 312
INDIRF4
RETF4
LABELV $1447
endproc BotEntityVisible 400 28
bss
align 1
LABELV $1583
skip 65536
align 4
LABELV $1584
skip 262144
code
proc BotEntityIndirectlyVisible 40 12
line 4845
;4838:}
;4839:
;4840:/*
;4841:==================
;4842:JUHOX: BotEntityIndirectlyVisible
;4843:==================
;4844:*/
;4845:static qboolean BotEntityIndirectlyVisible(bot_state_t* bs, int ent) {
line 4851
;4846:	static char entityVisStatus[MAX_CLIENTS][MAX_GENTITIES];
;4847:	static int entityVisStatusNextCheck[MAX_CLIENTS][MAX_GENTITIES];
;4848:	int i;
;4849:	qboolean checkStatus;
;4850:
;4851:	if (ent < 0 || ent >= ENTITYNUM_MAX_NORMAL) return qfalse;
ADDRLP4 8
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $1587
ADDRLP4 8
INDIRI4
CNSTI4 1022
LTI4 $1585
LABELV $1587
CNSTI4 0
RETI4
ADDRGP4 $1582
JUMPV
LABELV $1585
line 4853
;4852:
;4853:	BotDetermineVisibleTeammates(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotDetermineVisibleTeammates
CALLV
pop
line 4855
;4854:
;4855:	checkStatus = qfalse;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 4856
;4856:	for (i = 0; i < bs->numvisteammates; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1591
JUMPV
LABELV $1588
line 4859
;4857:		int teammate;
;4858:		
;4859:		teammate = bs->visteammates[i];
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 12184
ADDP4
ADDP4
INDIRI4
ASGNI4
line 4860
;4860:		if (teammate < 0 || teammate >= MAX_CLIENTS) continue;	// should not happen
ADDRLP4 12
INDIRI4
CNSTI4 0
LTI4 $1594
ADDRLP4 12
INDIRI4
CNSTI4 64
LTI4 $1592
LABELV $1594
ADDRGP4 $1589
JUMPV
LABELV $1592
line 4861
;4861:		if (entityVisStatusNextCheck[teammate][ent] <= level.time) {
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRI4
CNSTI4 12
LSHI4
ADDRGP4 $1584
ADDP4
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
GTI4 $1595
line 4862
;4862:			checkStatus = qtrue;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 4863
;4863:			continue;
ADDRGP4 $1589
JUMPV
LABELV $1595
line 4865
;4864:		}
;4865:		if (entityVisStatus[teammate][ent]) return qtrue;
ADDRFP4 4
INDIRI4
ADDRLP4 12
INDIRI4
CNSTI4 10
LSHI4
ADDRGP4 $1583
ADDP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1598
CNSTI4 1
RETI4
ADDRGP4 $1582
JUMPV
LABELV $1598
line 4866
;4866:	}
LABELV $1589
line 4856
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1591
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 12180
ADDP4
INDIRI4
LTI4 $1588
line 4867
;4867:	if (!checkStatus) return qfalse;
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1600
CNSTI4 0
RETI4
ADDRGP4 $1582
JUMPV
LABELV $1600
line 4869
;4868:
;4869:	for (i = 0; i < bs->numvisteammates; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1605
JUMPV
LABELV $1602
line 4878
;4870:		int teammate;
;4871:		gentity_t* tent;
;4872:		qboolean vis;
;4873:		/*
;4874:		gclient_t* client;
;4875:		gclient_t* enemy;
;4876:		*/
;4877:
;4878:		teammate = bs->visteammates[i];
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 12184
ADDP4
ADDP4
INDIRI4
ASGNI4
line 4879
;4879:		if (teammate < 0 || teammate >= MAX_CLIENTS) continue;
ADDRLP4 12
INDIRI4
CNSTI4 0
LTI4 $1608
ADDRLP4 12
INDIRI4
CNSTI4 64
LTI4 $1606
LABELV $1608
ADDRGP4 $1603
JUMPV
LABELV $1606
line 4880
;4880:		if (entityVisStatusNextCheck[teammate][ent] > level.time) continue;
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRI4
CNSTI4 12
LSHI4
ADDRGP4 $1584
ADDP4
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $1609
ADDRGP4 $1603
JUMPV
LABELV $1609
line 4882
;4881:
;4882:		tent = &g_entities[teammate];
ADDRLP4 16
ADDRLP4 12
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 4883
;4883:		if (!tent->inuse) continue;
ADDRLP4 16
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1612
ADDRGP4 $1603
JUMPV
LABELV $1612
line 4884
;4884:		if (!tent->client) continue;
ADDRLP4 16
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1614
ADDRGP4 $1603
JUMPV
LABELV $1614
line 4885
;4885:		if (tent->health <= 0) continue;
ADDRLP4 16
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
GTI4 $1616
ADDRGP4 $1603
JUMPV
LABELV $1616
line 4887
;4886:
;4887:		vis = (BotEntityVisible(&tent->client->ps, 90, ent) > 0);
ADDRLP4 16
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
CNSTF4 1119092736
ARGF4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 32
INDIRF4
CNSTF4 0
LEF4 $1619
ADDRLP4 28
CNSTI4 1
ASGNI4
ADDRGP4 $1620
JUMPV
LABELV $1619
ADDRLP4 28
CNSTI4 0
ASGNI4
LABELV $1620
ADDRLP4 20
ADDRLP4 28
INDIRI4
ASGNI4
line 4889
;4888:
;4889:		entityVisStatus[teammate][ent] = vis;
ADDRFP4 4
INDIRI4
ADDRLP4 12
INDIRI4
CNSTI4 10
LSHI4
ADDRGP4 $1583
ADDP4
ADDP4
ADDRLP4 20
INDIRI4
CVII1 4
ASGNI1
line 4890
;4890:		entityVisStatusNextCheck[teammate][ent] = level.time + 1000 + rand() % 2000;
ADDRLP4 36
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRI4
CNSTI4 12
LSHI4
ADDRGP4 $1584
ADDP4
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDI4
ADDRLP4 36
INDIRI4
CNSTI4 2000
MODI4
ADDI4
ASGNI4
line 4891
;4891:		if (vis) return qtrue;
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $1622
CNSTI4 1
RETI4
ADDRGP4 $1582
JUMPV
LABELV $1622
line 4915
;4892:
;4893:		/*
;4894:		if (!g_entities[teammate].inuse) continue;
;4895:		client = g_entities[teammate].client;
;4896:		if (!client) continue;
;4897:		if (client->ps.stats[STAT_HEALTH] <= 0) continue;
;4898:		enemy = g_entities[ent].client;
;4899:		if (
;4900:			(
;4901:				client->lasthurt_client != ent ||
;4902:				client->lasthurt_time < level.time - 2000
;4903:			) &&
;4904:			(
;4905:				!enemy ||
;4906:				enemy->lasthurt_client != bs->client ||
;4907:				enemy->lasthurt_time < level.time - 2000
;4908:			)
;4909:		) continue;
;4910:		//if (ps.weaponstate < WEAPON_FIRING) continue;
;4911:		if (BotEntityVisible(&client->ps, 90, ent) > 0) {
;4912:			return qtrue;
;4913:		}
;4914:		*/
;4915:	}
LABELV $1603
line 4869
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1605
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 12180
ADDP4
INDIRI4
LTI4 $1602
line 4916
;4916:	return qfalse;
CNSTI4 0
RETI4
LABELV $1582
endproc BotEntityIndirectlyVisible 40 12
bss
align 4
LABELV $1625
skip 4096
export BotFindEnemy
code
proc BotFindEnemy 436 16
line 4924
;4917:}
;4918:
;4919:/*
;4920:==================
;4921:BotFindEnemy
;4922:==================
;4923:*/
;4924:int BotFindEnemy(bot_state_t *bs, int curenemy) {
line 4935
;4925:	int i, healthdecrease;
;4926:	float f, alertness, easyfragger, vis;
;4927:	float squaredist, cursquaredist;
;4928:	aas_entityinfo_t entinfo, curenemyinfo;
;4929:	vec3_t dir/*, angles*/;	// JUHOX: angles no longer needed
;4930:	qboolean foundEnemy;	// JUHOX
;4931:	int m;	// JUHOX
;4932:	static int clientBag[MAX_GENTITIES];	// JUHOX
;4933:	int danger;	// JUHOX
;4934:
;4935:	alertness = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_ALERTNESS, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 46
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 336
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 312
ADDRLP4 336
INDIRF4
ASGNF4
line 4936
;4936:	easyfragger = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_EASY_FRAGGER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 45
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 340
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 324
ADDRLP4 340
INDIRF4
ASGNF4
line 4941
;4937:	//check if the health decreased
;4938:#if 0	// JUHOX: compute the health decrease condition by a more reliable method (consider automatic decrease if health > max. health!)
;4939:	healthdecrease = bs->lasthealth > bs->inventory[INVENTORY_HEALTH];
;4940:#else
;4941:	healthdecrease = g_entities[bs->entitynum].client->lasthurt_time > level.time - 1000;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 828
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
SUBI4
LEI4 $1629
ADDRLP4 344
CNSTI4 1
ASGNI4
ADDRGP4 $1630
JUMPV
LABELV $1629
ADDRLP4 344
CNSTI4 0
ASGNI4
LABELV $1630
ADDRLP4 332
ADDRLP4 344
INDIRI4
ASGNI4
line 4944
;4942:#endif
;4943:	//remember the current health value
;4944:	bs->lasthealth = bs->inventory[INVENTORY_HEALTH];
ADDRLP4 348
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 348
INDIRP4
CNSTI4 6008
ADDP4
ADDRLP4 348
INDIRP4
CNSTI4 5076
ADDP4
INDIRI4
ASGNI4
line 4946
;4945:	//
;4946:	if (curenemy >= 0) {
ADDRFP4 4
INDIRI4
CNSTI4 0
LTI4 $1631
line 4947
;4947:		BotEntityInfo(curenemy, &curenemyinfo);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 172
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 4952
;4948:#if 0	// JUHOX: only concentrate on flag carrier if not carrying a flag
;4949:		if (EntityCarriesFlag(&curenemyinfo)) return qfalse;
;4950:#else
;4951:		if (
;4952:			EntityCarriesFlag(&curenemyinfo) &&
ADDRLP4 172
ARGP4
ADDRLP4 352
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 352
INDIRI4
CNSTI4 0
EQI4 $1633
ADDRLP4 356
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 356
INDIRP4
CNSTI4 356
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1633
ADDRLP4 356
INDIRP4
CNSTI4 360
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1633
line 4955
;4953:			!bs->cur_ps.powerups[PW_REDFLAG] &&
;4954:			!bs->cur_ps.powerups[PW_BLUEFLAG]
;4955:		) {
line 4956
;4956:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1624
JUMPV
LABELV $1633
line 4961
;4957:		}
;4958:#endif
;4959:#if 1	// JUHOX: healthy bots don't accept new enemies while already fighting
;4960:		if (
;4961:			bs->cur_ps.weaponstate != WEAPON_READY &&
ADDRLP4 360
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 360
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1635
ADDRLP4 360
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 364
ADDRGP4 BotPlayerDanger
CALLI4
ASGNI4
ADDRLP4 364
INDIRI4
CNSTI4 25
GTI4 $1635
line 4963
;4962:			BotPlayerDanger(&bs->cur_ps) <= 25
;4963:		) return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1624
JUMPV
LABELV $1635
line 4965
;4964:#endif
;4965:		VectorSubtract(curenemyinfo.origin, bs->origin, dir);
ADDRLP4 368
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
ADDRLP4 172+24
INDIRF4
ADDRLP4 368
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+4
ADDRLP4 172+24+4
INDIRF4
ADDRLP4 368
INDIRP4
CNSTI4 4920
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+8
ADDRLP4 172+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRF4
SUBF4
ASGNF4
line 4966
;4966:		cursquaredist = VectorLengthSquared(dir);
ADDRLP4 144
ARGP4
ADDRLP4 372
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 316
ADDRLP4 372
INDIRF4
ASGNF4
line 4967
;4967:	}
ADDRGP4 $1632
JUMPV
LABELV $1631
line 4968
;4968:	else {
line 4969
;4969:		cursquaredist = 0;
ADDRLP4 316
CNSTF4 0
ASGNF4
line 4970
;4970:	}
LABELV $1632
line 4999
;4971:#ifdef MISSIONPACK
;4972:	if (gametype == GT_OBELISK) {
;4973:		vec3_t target;
;4974:		bot_goal_t *goal;
;4975:		bsp_trace_t trace;
;4976:
;4977:		if (BotTeam(bs) == TEAM_RED)
;4978:			goal = &blueobelisk;
;4979:		else
;4980:			goal = &redobelisk;
;4981:		//if the obelisk is visible
;4982:		VectorCopy(goal->origin, target);
;4983:		target[2] += 1;
;4984:		BotAI_Trace(&trace, bs->eye, NULL, NULL, target, bs->client, CONTENTS_SOLID);
;4985:		if (trace.fraction >= 1 || trace.ent == goal->entitynum) {
;4986:			if (goal->entitynum == bs->enemy) {
;4987:				return qfalse;
;4988:			}
;4989:			bs->enemy = goal->entitynum;
;4990:			bs->enemysight_time = FloatTime();
;4991:			bs->enemysuicide = qfalse;
;4992:			bs->enemydeath_time = 0;
;4993:			bs->enemyvisible_time = FloatTime();
;4994:			return qtrue;
;4995:		}
;4996:	}
;4997:#endif
;4998:	//
;4999:	foundEnemy = qfalse;	// JUHOX
ADDRLP4 320
CNSTI4 0
ASGNI4
line 5000
;5000:	danger = BotPlayerDanger(&bs->cur_ps);	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 352
ADDRGP4 BotPlayerDanger
CALLI4
ASGNI4
ADDRLP4 328
ADDRLP4 352
INDIRI4
ASGNI4
line 5004
;5001:#if 0	// JUHOX: check clients in random order
;5002:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
;5003:#else
;5004:	m = level.maxclients;
ADDRLP4 160
ADDRGP4 level+24
INDIRI4
ASGNI4
line 5007
;5005:#if MONSTER_MODE
;5006:	if (
;5007:		g_gametype.integer == GT_STU ||
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
EQI4 $1649
ADDRGP4 g_monsterLauncher+12
INDIRI4
CNSTI4 0
EQI4 $1645
LABELV $1649
line 5009
;5008:		g_monsterLauncher.integer
;5009:	) {
line 5010
;5010:		m = level.num_entities;
ADDRLP4 160
ADDRGP4 level+12
INDIRI4
ASGNI4
line 5011
;5011:	}
LABELV $1645
line 5013
;5012:#endif
;5013:	for (i = 0; i < m; i++) {
ADDRLP4 140
CNSTI4 0
ASGNI4
ADDRGP4 $1654
JUMPV
LABELV $1651
line 5014
;5014:		clientBag[i] = i;
ADDRLP4 140
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1625
ADDP4
ADDRLP4 140
INDIRI4
ASGNI4
line 5015
;5015:	}
LABELV $1652
line 5013
ADDRLP4 140
ADDRLP4 140
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1654
ADDRLP4 140
INDIRI4
ADDRLP4 160
INDIRI4
LTI4 $1651
ADDRGP4 $1656
JUMPV
LABELV $1655
line 5016
;5016:	while (m > 0) {
line 5017
;5017:		{
line 5020
;5018:			int j;
;5019:
;5020:			j = rand() % m;
ADDRLP4 360
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 356
ADDRLP4 360
INDIRI4
ADDRLP4 160
INDIRI4
MODI4
ASGNI4
line 5021
;5021:			i = clientBag[j];
ADDRLP4 140
ADDRLP4 356
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1625
ADDP4
INDIRI4
ASGNI4
line 5022
;5022:			clientBag[j] = clientBag[--m];
ADDRLP4 364
ADDRLP4 160
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRLP4 160
ADDRLP4 364
INDIRI4
ASGNI4
ADDRLP4 368
ADDRGP4 $1625
ASGNP4
ADDRLP4 356
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 368
INDIRP4
ADDP4
ADDRLP4 364
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 368
INDIRP4
ADDP4
INDIRI4
ASGNI4
line 5023
;5023:		}
line 5027
;5024:#endif
;5025:
;5026:#if MONSTER_MODE
;5027:		if (!G_GetEntityPlayerState(&g_entities[i])) continue;
ADDRLP4 140
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 356
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 356
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1658
ADDRGP4 $1656
JUMPV
LABELV $1658
line 5029
;5028:#endif
;5029:		if (i == bs->client) continue;
ADDRLP4 140
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1660
ADDRGP4 $1656
JUMPV
LABELV $1660
line 5031
;5030:		//if it's the current enemy
;5031:		if (i == curenemy) continue;
ADDRLP4 140
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $1662
ADDRGP4 $1656
JUMPV
LABELV $1662
line 5033
;5032:#if 1	// JUHOX: erlier test for same team
;5033:		if (BotSameTeam(bs, i)) continue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 360
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 360
INDIRI4
CNSTI4 0
EQI4 $1664
ADDRGP4 $1656
JUMPV
LABELV $1664
line 5036
;5034:#endif
;5035:		//
;5036:		BotEntityInfo(i, &entinfo);
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 5038
;5037:		//
;5038:		if (!entinfo.valid) continue;
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1666
ADDRGP4 $1656
JUMPV
LABELV $1666
line 5040
;5039:		//if the enemy isn't dead and the enemy isn't the bot self
;5040:		if (EntityIsDead(&entinfo) || entinfo.number == bs->entitynum) continue;
ADDRLP4 0
ARGP4
ADDRLP4 364
ADDRGP4 EntityIsDead
CALLI4
ASGNI4
ADDRLP4 364
INDIRI4
CNSTI4 0
NEI4 $1671
ADDRLP4 0+20
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
NEI4 $1668
LABELV $1671
ADDRGP4 $1656
JUMPV
LABELV $1668
line 5047
;5041:		//if the enemy is invisible and not shooting
;5042:#if 0	// JUHOX: This is now handled by BotEntityVisible(). Ignore invisible enemy only if already fighting.
;5043:		if (EntityIsInvisible(VIEWER_OTHERTEAM, &entinfo) && !EntityIsShooting(&entinfo)) {	// JUHOX: added 'VIEWER_OTHERTEAM'
;5044:			continue;
;5045:		}
;5046:#else
;5047:		if (bs->enemy >= 0 && EntityIsInvisible(VIEWER_OTHERTEAM, &entinfo)) continue;
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 0
LTI4 $1672
CNSTI4 -2
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 368
ADDRGP4 EntityIsInvisible
CALLI4
ASGNI4
ADDRLP4 368
INDIRI4
CNSTI4 0
EQI4 $1672
ADDRGP4 $1656
JUMPV
LABELV $1672
line 5050
;5048:#endif
;5049:		//if not an easy fragger don't shoot at chatting players
;5050:		if (easyfragger < 0.5 && EntityIsChatting(&entinfo)) continue;
ADDRLP4 324
INDIRF4
CNSTF4 1056964608
GEF4 $1674
ADDRLP4 0
ARGP4
ADDRLP4 372
ADDRGP4 EntityIsChatting
CALLI4
ASGNI4
ADDRLP4 372
INDIRI4
CNSTI4 0
EQI4 $1674
ADDRGP4 $1656
JUMPV
LABELV $1674
line 5052
;5051:		//
;5052:		if (lastteleport_time > FloatTime() - 3) {
ADDRGP4 lastteleport_time
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1077936128
SUBF4
LEF4 $1676
line 5053
;5053:			VectorSubtract(entinfo.origin, lastteleport_origin, dir);
ADDRLP4 144
ADDRLP4 0+24
INDIRF4
ADDRGP4 lastteleport_origin
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+4
ADDRLP4 0+24+4
INDIRF4
ADDRGP4 lastteleport_origin+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+8
ADDRLP4 0+24+8
INDIRF4
ADDRGP4 lastteleport_origin+8
INDIRF4
SUBF4
ASGNF4
line 5054
;5054:			if (VectorLengthSquared(dir) < Square(70)) continue;
ADDRLP4 144
ARGP4
ADDRLP4 376
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 376
INDIRF4
CNSTF4 1167663104
GEF4 $1687
ADDRGP4 $1656
JUMPV
LABELV $1687
line 5055
;5055:		}
LABELV $1676
line 5057
;5056:		//calculate the distance towards the enemy
;5057:		VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 376
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
ADDRLP4 0+24
INDIRF4
ADDRLP4 376
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 376
INDIRP4
CNSTI4 4920
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRF4
SUBF4
ASGNF4
line 5058
;5058:		squaredist = VectorLengthSquared(dir);
ADDRLP4 144
ARGP4
ADDRLP4 380
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 380
INDIRF4
ASGNF4
line 5060
;5059:		//if this entity is not carrying a flag
;5060:		if (!EntityCarriesFlag(&entinfo))
ADDRLP4 0
ARGP4
ADDRLP4 384
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 384
INDIRI4
CNSTI4 0
NEI4 $1696
line 5061
;5061:		{
line 5064
;5062:#if MONSTER_MODE	// JUHOX: in STU prefer guards
;5063:			if (
;5064:				g_gametype.integer >= GT_STU &&
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
LTI4 $1698
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 388
ADDRGP4 G_IsAttackingGuard
CALLI4
ASGNI4
ADDRLP4 388
INDIRI4
CNSTI4 0
EQI4 $1698
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 392
ADDRGP4 G_IsAttackingGuard
CALLI4
ASGNI4
ADDRLP4 392
INDIRI4
CNSTI4 0
NEI4 $1698
line 5067
;5065:				G_IsAttackingGuard(curenemy) &&
;5066:				!G_IsAttackingGuard(i)
;5067:			) {
line 5068
;5068:				continue;
ADDRGP4 $1656
JUMPV
LABELV $1698
line 5073
;5069:			}
;5070:#endif
;5071:#if 1	// JUHOX: if not too much endangered prefer targets near the goal
;5072:			if (
;5073:				curenemy >= 0 &&
ADDRFP4 4
INDIRI4
CNSTI4 0
LTI4 $1701
ADDRLP4 328
INDIRI4
CNSTI4 40
GEI4 $1701
ADDRLP4 396
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 396
INDIRP4
CNSTI4 11532
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1701
ADDRLP4 0+24
ARGP4
ADDRLP4 396
INDIRP4
CNSTI4 11580
ADDP4
ARGP4
ADDRLP4 400
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 172+24
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 11580
ADDP4
ARGP4
ADDRLP4 404
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 400
INDIRF4
CNSTF4 1069547520
MULF4
ADDRLP4 404
INDIRF4
LEF4 $1701
line 5078
;5074:				danger < 40 &&
;5075:				bs->ltgtype != 0 &&
;5076:				1.5 * DistanceSquared(entinfo.origin, bs->teamgoal.origin) >
;5077:					DistanceSquared(curenemyinfo.origin, bs->teamgoal.origin)
;5078:			) {
line 5079
;5079:				continue;
ADDRGP4 $1656
JUMPV
LABELV $1701
line 5087
;5080:			}
;5081:#endif
;5082:			//if this enemy is further away than the current one
;5083:#if 0	// JUHOX: ignore distance if current enemy has shield but the new enemy not
;5084:			if (curenemy >= 0 && squaredist > cursquaredist) continue;
;5085:#else
;5086:			if (
;5087:				curenemy >= 0 && 1.5 * squaredist > cursquaredist &&
ADDRFP4 4
INDIRI4
CNSTI4 0
LTI4 $1705
ADDRLP4 156
INDIRF4
CNSTF4 1069547520
MULF4
ADDRLP4 316
INDIRF4
LEF4 $1705
ADDRLP4 156
INDIRF4
CNSTF4 1202702336
GTF4 $1709
ADDRLP4 156
INDIRF4
ADDRLP4 316
INDIRF4
LEF4 $1705
LABELV $1709
ADDRFP4 0
INDIRP4
CNSTI4 7784
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1705
ADDRLP4 172+124
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $1710
ADDRLP4 0+124
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $1705
LABELV $1710
line 5091
;5088:				(squaredist > Square(300) || squaredist > cursquaredist) &&
;5089:				!bs->lastEnemyAreaPredicted &&
;5090:				(!(curenemyinfo.powerups & (1 << PW_SHIELD)) || (entinfo.powerups & (1 << PW_SHIELD)))
;5091:			) {
line 5092
;5092:				continue;
ADDRGP4 $1656
JUMPV
LABELV $1705
line 5095
;5093:			}
;5094:#endif
;5095:		} //end if
LABELV $1696
line 5097
;5096:		//if the bot has no
;5097:		if (squaredist > Square(900.0 + alertness * 4000.0)) continue;
ADDRLP4 156
INDIRF4
ADDRLP4 312
INDIRF4
CNSTF4 1165623296
MULF4
CNSTF4 1147207680
ADDF4
ADDRLP4 312
INDIRF4
CNSTF4 1165623296
MULF4
CNSTF4 1147207680
ADDF4
MULF4
LEF4 $1711
ADDRGP4 $1656
JUMPV
LABELV $1711
line 5104
;5098:		//if on the same team
;5099:#if 0	// JUHOX: earlier test for same team
;5100:		if (BotSameTeam(bs, i)) continue;
;5101:#endif
;5102:#if 1	// JUHOX: if retreating ignore cloaked enemies (they are not shooting)
;5103:		if (
;5104:			(entinfo.powerups & (1 << PW_INVIS)) &&
ADDRLP4 0+124
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1713
ADDRLP4 0
ARGP4
ADDRLP4 392
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 392
INDIRI4
CNSTI4 0
NEI4 $1713
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 396
ADDRGP4 BotWantsToRetreat
CALLI4
ASGNI4
ADDRLP4 396
INDIRI4
CNSTI4 0
EQI4 $1713
line 5107
;5105:			!EntityCarriesFlag(&entinfo) &&
;5106:			BotWantsToRetreat(bs)
;5107:		) {
line 5108
;5108:			continue;
ADDRGP4 $1656
JUMPV
LABELV $1713
line 5111
;5109:		}
;5110:#endif
;5111:		if (!BotWantsToFight(bs, i, qfalse)) continue;	// JUHOX
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 400
ADDRGP4 BotWantsToFight
CALLI4
ASGNI4
ADDRLP4 400
INDIRI4
CNSTI4 0
NEI4 $1716
ADDRGP4 $1656
JUMPV
LABELV $1716
line 5119
;5112:#if 0	// JUHOX: always use a fov of 90; BotEntityVisible() does already some special checks and this distance dependend fov is nonsense
;5113:		//if the bot's health decreased or the enemy is shooting
;5114:		if (curenemy < 0 && (healthdecrease || EntityIsShooting(&entinfo)))
;5115:			f = 360;
;5116:		else
;5117:			f = 90 + 90 - (90 - (squaredist > Square(810) ? Square(810) : squaredist) / (810 * 9));
;5118:#else
;5119:		f = 90;
ADDRLP4 168
CNSTF4 1119092736
ASGNF4
line 5120
;5120:		if (bs->blockingEnemy == i) f = 360;
ADDRFP4 0
INDIRP4
CNSTI4 7320
ADDP4
INDIRI4
ADDRLP4 140
INDIRI4
NEI4 $1718
ADDRLP4 168
CNSTF4 1135869952
ASGNF4
LABELV $1718
line 5123
;5121:#endif
;5122:		//check if the enemy is visible
;5123:		vis = BotEntityVisible(&bs->cur_ps/*bs->entitynum, bs->eye, bs->viewangles*/, f, i);	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 168
INDIRF4
ARGF4
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 404
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 164
ADDRLP4 404
INDIRF4
ASGNF4
line 5127
;5124:#if 0	// JUHOX: if the enemy is not directly visible, check if he is visible to a teammate
;5125:		if (vis <= 0) continue;
;5126:#else
;5127:		if (vis <= 0) {
ADDRLP4 164
INDIRF4
CNSTF4 0
GTF4 $1720
line 5130
;5128:			int enemyArea;
;5129:
;5130:			if (bs->enemy >= 0) continue;
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 0
LTI4 $1722
ADDRGP4 $1656
JUMPV
LABELV $1722
line 5131
;5131:			if (curenemy >= 0) continue;
ADDRFP4 4
INDIRI4
CNSTI4 0
LTI4 $1724
ADDRGP4 $1656
JUMPV
LABELV $1724
line 5132
;5132:			if ((entinfo.powerups & ((1 << PW_INVIS) | (1 << PW_BATTLESUIT))) == (1 << PW_INVIS)) continue;
ADDRLP4 0+124
INDIRI4
CNSTI4 20
BANDI4
CNSTI4 16
NEI4 $1726
ADDRGP4 $1656
JUMPV
LABELV $1726
line 5133
;5133:			if (!BotWantsToFight(bs, i, qtrue)) continue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 412
ADDRGP4 BotWantsToFight
CALLI4
ASGNI4
ADDRLP4 412
INDIRI4
CNSTI4 0
NEI4 $1729
ADDRGP4 $1656
JUMPV
LABELV $1729
line 5134
;5134:			enemyArea = BotPointAreaNum(entinfo.origin);
ADDRLP4 0+24
ARGP4
ADDRLP4 416
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 408
ADDRLP4 416
INDIRI4
ASGNI4
line 5135
;5135:			if (enemyArea <= 0) continue;
ADDRLP4 408
INDIRI4
CNSTI4 0
GTI4 $1732
ADDRGP4 $1656
JUMPV
LABELV $1732
line 5136
;5136:			if (!trap_AAS_AreaReachability(enemyArea)) continue;
ADDRLP4 408
INDIRI4
ARGI4
ADDRLP4 420
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 420
INDIRI4
CNSTI4 0
NEI4 $1734
ADDRGP4 $1656
JUMPV
LABELV $1734
line 5137
;5137:			if (!BotEntityIndirectlyVisible(bs, i)) continue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 424
ADDRGP4 BotEntityIndirectlyVisible
CALLI4
ASGNI4
ADDRLP4 424
INDIRI4
CNSTI4 0
NEI4 $1736
ADDRGP4 $1656
JUMPV
LABELV $1736
line 5138
;5138:			if (trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, enemyArea, bs->tfl) <= 0) continue;
ADDRLP4 428
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 428
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
ARGI4
ADDRLP4 428
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 408
INDIRI4
ARGI4
ADDRLP4 428
INDIRP4
CNSTI4 5984
ADDP4
INDIRI4
ARGI4
ADDRLP4 432
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 432
INDIRI4
CNSTI4 0
GTI4 $1738
ADDRGP4 $1656
JUMPV
LABELV $1738
line 5139
;5139:		}
LABELV $1720
line 5166
;5140:#endif
;5141:#if 0	// JUHOX: avoiding enemies is already checked by BotWantsToFight()
;5142:		//if the enemy is quite far away, not shooting and the bot is not damaged
;5143:		if (curenemy < 0 && squaredist > Square(100) && !healthdecrease && !EntityIsShooting(&entinfo))
;5144:		{
;5145:			//check if we can avoid this enemy
;5146:			VectorSubtract(bs->origin, entinfo.origin, dir);
;5147:			vectoangles(dir, angles);
;5148:			//if the bot isn't in the fov of the enemy
;5149:			if (!InFieldOfVision(entinfo.angles, 90, angles)) {
;5150:				//update some stuff for this enemy
;5151:				BotUpdateBattleInventory(bs, i);
;5152:				//if the bot doesn't really want to fight
;5153:				if (BotWantsToRetreat(bs)) continue;
;5154:			}
;5155:		}
;5156:#endif
;5157:		//found an enemy
;5158:#if 0	// JUHOX: there might by better enemies, so defer enemy decision
;5159:		bs->enemy = entinfo.number;
;5160:		if (curenemy >= 0) bs->enemysight_time = FloatTime() - /*2*/0.5;	// JUHOX
;5161:		else bs->enemysight_time = FloatTime();
;5162:		bs->enemysuicide = qfalse;
;5163:		bs->enemydeath_time = 0;
;5164:		return qtrue;
;5165:#else
;5166:		foundEnemy = qtrue;
ADDRLP4 320
CNSTI4 1
ASGNI4
line 5167
;5167:		curenemy = entinfo.number;
ADDRFP4 4
ADDRLP4 0+20
INDIRI4
ASGNI4
line 5168
;5168:		cursquaredist = squaredist;
ADDRLP4 316
ADDRLP4 156
INDIRF4
ASGNF4
line 5169
;5169:		bs->lastEnemyAreaPredicted = (vis <= 0);
ADDRLP4 164
INDIRF4
CNSTF4 0
GTF4 $1742
ADDRLP4 408
CNSTI4 1
ASGNI4
ADDRGP4 $1743
JUMPV
LABELV $1742
ADDRLP4 408
CNSTI4 0
ASGNI4
LABELV $1743
ADDRFP4 0
INDIRP4
CNSTI4 7784
ADDP4
ADDRLP4 408
INDIRI4
ASGNI4
line 5171
;5170:		if (
;5171:			EntityCarriesFlag(&entinfo) &&
ADDRLP4 0
ARGP4
ADDRLP4 412
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 412
INDIRI4
CNSTI4 0
EQI4 $1744
ADDRLP4 416
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 416
INDIRP4
CNSTI4 356
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1744
ADDRLP4 416
INDIRP4
CNSTI4 360
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1744
line 5174
;5172:			!bs->cur_ps.powerups[PW_REDFLAG] &&
;5173:			!bs->cur_ps.powerups[PW_BLUEFLAG]
;5174:		) break;
ADDRGP4 $1657
JUMPV
LABELV $1744
line 5175
;5175:		curenemyinfo = entinfo;
ADDRLP4 172
ADDRLP4 0
INDIRB
ASGNB 140
line 5177
;5176:#endif
;5177:	}
LABELV $1656
line 5016
ADDRLP4 160
INDIRI4
CNSTI4 0
GTI4 $1655
LABELV $1657
line 5181
;5178:#if 0	// JUHOX: handle deferred enemy decision
;5179:	return qfalse;
;5180:#else
;5181:	if (foundEnemy) {
ADDRLP4 320
INDIRI4
CNSTI4 0
EQI4 $1746
line 5182
;5182:		if (bs->enemy < 0) bs->enemysight_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 0
GEI4 $1748
ADDRFP4 0
INDIRP4
CNSTI4 7224
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
LABELV $1748
line 5183
;5183:		bs->viewnotperfect_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7416
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 5184
;5184:		bs->enemysuicide = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6032
ADDP4
CNSTI4 0
ASGNI4
line 5185
;5185:		bs->enemydeath_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7228
ADDP4
CNSTF4 0
ASGNF4
line 5188
;5186:
;5187:		if (
;5188:			g_gametype.integer >= GT_TEAM &&
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $1750
ADDRLP4 356
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 356
INDIRP4
CNSTI4 7784
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1750
ADDRLP4 356
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 0
GEI4 $1750
ADDRLP4 356
INDIRP4
CNSTI4 7180
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1077936128
SUBF4
GEF4 $1750
ADDRLP4 356
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 360
ADDRGP4 IsPlayerFighting
CALLI4
ASGNI4
ADDRLP4 360
INDIRI4
CNSTI4 0
NEI4 $1750
line 5193
;5189:			!bs->lastEnemyAreaPredicted &&
;5190:			bs->enemy < 0 &&
;5191:			bs->enemyvisible_time < FloatTime() - 3 &&
;5192:			!IsPlayerFighting(bs->client)
;5193:		) {
line 5194
;5194:			trap_EA_SayTeam(bs->client, "Contact!\n");
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 $1753
ARGP4
ADDRGP4 trap_EA_SayTeam
CALLV
pop
line 5195
;5195:		}
LABELV $1750
line 5196
;5196:		bs->enemy = curenemy;
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 5197
;5197:		bs->enemyvisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7180
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 5198
;5198:		VectorCopy(entinfo.origin, bs->lastenemyorigin);
ADDRFP4 0
INDIRP4
CNSTI4 7772
ADDP4
ADDRLP4 0+24
INDIRB
ASGNB 12
line 5199
;5199:		bs->lastenemyareanum = BotPointAreaNum(entinfo.origin);
ADDRLP4 0+24
ARGP4
ADDRLP4 364
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 7768
ADDP4
ADDRLP4 364
INDIRI4
ASGNI4
line 5200
;5200:	}
LABELV $1746
line 5201
;5201:	return foundEnemy;
ADDRLP4 320
INDIRI4
RETI4
LABELV $1624
endproc BotFindEnemy 436 16
export BotTeamFlagCarrierVisible
proc BotTeamFlagCarrierVisible 160 12
line 5210
;5202:#endif
;5203:}
;5204:
;5205:/*
;5206:==================
;5207:BotTeamFlagCarrierVisible
;5208:==================
;5209:*/
;5210:int BotTeamFlagCarrierVisible(bot_state_t *bs) {
line 5215
;5211:	int i;
;5212:	float vis;
;5213:	aas_entityinfo_t entinfo;
;5214:
;5215:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1760
JUMPV
LABELV $1757
line 5216
;5216:		if (i == bs->client)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1761
line 5217
;5217:			continue;
ADDRGP4 $1758
JUMPV
LABELV $1761
line 5219
;5218:		//
;5219:		BotEntityInfo(i, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 5221
;5220:		//if this player is active
;5221:		if (!entinfo.valid)
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1763
line 5222
;5222:			continue;
ADDRGP4 $1758
JUMPV
LABELV $1763
line 5224
;5223:		//if this player is carrying a flag
;5224:		if (!EntityCarriesFlag(&entinfo))
ADDRLP4 4
ARGP4
ADDRLP4 148
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $1765
line 5225
;5225:			continue;
ADDRGP4 $1758
JUMPV
LABELV $1765
line 5227
;5226:		//if the flag carrier is not on the same team
;5227:		if (!BotSameTeam(bs, i))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 152
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
NEI4 $1767
line 5228
;5228:			continue;
ADDRGP4 $1758
JUMPV
LABELV $1767
line 5230
;5229:		//if the flag carrier is not visible
;5230:		vis = BotEntityVisible(&bs->cur_ps/*bs->entitynum, bs->eye, bs->viewangles*/, 360, i);	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 156
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 144
ADDRLP4 156
INDIRF4
ASGNF4
line 5231
;5231:		if (vis <= 0)
ADDRLP4 144
INDIRF4
CNSTF4 0
GTF4 $1769
line 5232
;5232:			continue;
ADDRGP4 $1758
JUMPV
LABELV $1769
line 5234
;5233:		//
;5234:		return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1756
JUMPV
LABELV $1758
line 5215
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1760
ADDRLP4 0
INDIRI4
ADDRGP4 maxclients
INDIRI4
GEI4 $1771
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $1757
LABELV $1771
line 5236
;5235:	}
;5236:	return -1;
CNSTI4 -1
RETI4
LABELV $1756
endproc BotTeamFlagCarrierVisible 160 12
export BotTeamFlagCarrier
proc BotTeamFlagCarrier 152 8
line 5244
;5237:}
;5238:
;5239:/*
;5240:==================
;5241:BotTeamFlagCarrier
;5242:==================
;5243:*/
;5244:int BotTeamFlagCarrier(bot_state_t *bs) {
line 5248
;5245:	int i;
;5246:	aas_entityinfo_t entinfo;
;5247:
;5248:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1776
JUMPV
LABELV $1773
line 5249
;5249:		if (i == bs->client)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1777
line 5250
;5250:			continue;
ADDRGP4 $1774
JUMPV
LABELV $1777
line 5252
;5251:		//
;5252:		BotEntityInfo(i, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 5254
;5253:		//if this player is active
;5254:		if (!entinfo.valid)
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1779
line 5255
;5255:			continue;
ADDRGP4 $1774
JUMPV
LABELV $1779
line 5257
;5256:		//if this player is carrying a flag
;5257:		if (!EntityCarriesFlag(&entinfo))
ADDRLP4 4
ARGP4
ADDRLP4 144
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
NEI4 $1781
line 5258
;5258:			continue;
ADDRGP4 $1774
JUMPV
LABELV $1781
line 5260
;5259:		//if the flag carrier is not on the same team
;5260:		if (!BotSameTeam(bs, i))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 148
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $1783
line 5261
;5261:			continue;
ADDRGP4 $1774
JUMPV
LABELV $1783
line 5263
;5262:		//
;5263:		return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1772
JUMPV
LABELV $1774
line 5248
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1776
ADDRLP4 0
INDIRI4
ADDRGP4 maxclients
INDIRI4
GEI4 $1785
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $1773
LABELV $1785
line 5265
;5264:	}
;5265:	return -1;
CNSTI4 -1
RETI4
LABELV $1772
endproc BotTeamFlagCarrier 152 8
export BotEnemyFlagCarrierVisible
proc BotEnemyFlagCarrierVisible 160 12
line 5273
;5266:}
;5267:
;5268:/*
;5269:==================
;5270:BotEnemyFlagCarrierVisible
;5271:==================
;5272:*/
;5273:int BotEnemyFlagCarrierVisible(bot_state_t *bs) {
line 5278
;5274:	int i;
;5275:	float vis;
;5276:	aas_entityinfo_t entinfo;
;5277:
;5278:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1790
JUMPV
LABELV $1787
line 5279
;5279:		if (i == bs->client)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1791
line 5280
;5280:			continue;
ADDRGP4 $1788
JUMPV
LABELV $1791
line 5282
;5281:		//
;5282:		BotEntityInfo(i, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 5284
;5283:		//if this player is active
;5284:		if (!entinfo.valid)
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1793
line 5285
;5285:			continue;
ADDRGP4 $1788
JUMPV
LABELV $1793
line 5287
;5286:		//if this player is carrying a flag
;5287:		if (!EntityCarriesFlag(&entinfo))
ADDRLP4 4
ARGP4
ADDRLP4 148
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $1795
line 5288
;5288:			continue;
ADDRGP4 $1788
JUMPV
LABELV $1795
line 5290
;5289:		//if the flag carrier is on the same team
;5290:		if (BotSameTeam(bs, i))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 152
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
EQI4 $1797
line 5291
;5291:			continue;
ADDRGP4 $1788
JUMPV
LABELV $1797
line 5293
;5292:		//if the flag carrier is not visible
;5293:		vis = BotEntityVisible(&bs->cur_ps/*bs->entitynum, bs->eye, bs->viewangles*/, 360, i);	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 156
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 144
ADDRLP4 156
INDIRF4
ASGNF4
line 5294
;5294:		if (vis <= 0)
ADDRLP4 144
INDIRF4
CNSTF4 0
GTF4 $1799
line 5295
;5295:			continue;
ADDRGP4 $1788
JUMPV
LABELV $1799
line 5297
;5296:		//
;5297:		return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1786
JUMPV
LABELV $1788
line 5278
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1790
ADDRLP4 0
INDIRI4
ADDRGP4 maxclients
INDIRI4
GEI4 $1801
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $1787
LABELV $1801
line 5299
;5298:	}
;5299:	return -1;
CNSTI4 -1
RETI4
LABELV $1786
endproc BotEnemyFlagCarrierVisible 160 12
proc SearchGrappleTarget 120 28
line 5420
;5300:}
;5301:
;5302:/*
;5303:==================
;5304:BotVisibleTeamMatesAndEnemies
;5305:==================
;5306:*/
;5307:// JUHOX: BotVisibleTeamMatesAndEnemies() not used
;5308:#if 0
;5309:void BotVisibleTeamMatesAndEnemies(bot_state_t *bs, int *teammates, int *enemies, float range) {
;5310:	int i;
;5311:	float vis;
;5312:	aas_entityinfo_t entinfo;
;5313:	vec3_t dir;
;5314:
;5315:	if (teammates)
;5316:		*teammates = 0;
;5317:	if (enemies)
;5318:		*enemies = 0;
;5319:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
;5320:		if (i == bs->client)
;5321:			continue;
;5322:		//
;5323:		BotEntityInfo(i, &entinfo);
;5324:		//if this player is active
;5325:		if (!entinfo.valid)
;5326:			continue;
;5327:		//if this player is carrying a flag
;5328:		if (!EntityCarriesFlag(&entinfo))
;5329:			continue;
;5330:		//if not within range
;5331:		VectorSubtract(entinfo.origin, bs->origin, dir);
;5332:		if (VectorLengthSquared(dir) > Square(range))
;5333:			continue;
;5334:		//if the flag carrier is not visible
;5335:		vis = BotEntityVisible(&bs->cur_ps/*bs->entitynum, bs->eye, bs->viewangles*/, 360, i);	// JUHOX
;5336:		if (vis <= 0)
;5337:			continue;
;5338:		//if the flag carrier is on the same team
;5339:		if (BotSameTeam(bs, i)) {
;5340:			if (teammates)
;5341:				(*teammates)++;
;5342:		}
;5343:		else {
;5344:			if (enemies)
;5345:				(*enemies)++;
;5346:		}
;5347:	}
;5348:}
;5349:#endif
;5350:
;5351:#ifdef MISSIONPACK
;5352:/*
;5353:==================
;5354:BotTeamCubeCarrierVisible
;5355:==================
;5356:*/
;5357:int BotTeamCubeCarrierVisible(bot_state_t *bs) {
;5358:	int i;
;5359:	float vis;
;5360:	aas_entityinfo_t entinfo;
;5361:
;5362:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
;5363:		if (i == bs->client) continue;
;5364:		//
;5365:		BotEntityInfo(i, &entinfo);
;5366:		//if this player is active
;5367:		if (!entinfo.valid) continue;
;5368:		//if this player is carrying a flag
;5369:		if (!EntityCarriesCubes(&entinfo)) continue;
;5370:		//if the flag carrier is not on the same team
;5371:		if (!BotSameTeam(bs, i)) continue;
;5372:		//if the flag carrier is not visible
;5373:		vis = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, i);
;5374:		if (vis <= 0) continue;
;5375:		//
;5376:		return i;
;5377:	}
;5378:	return -1;
;5379:}
;5380:
;5381:/*
;5382:==================
;5383:BotEnemyCubeCarrierVisible
;5384:==================
;5385:*/
;5386:int BotEnemyCubeCarrierVisible(bot_state_t *bs) {
;5387:	int i;
;5388:	float vis;
;5389:	aas_entityinfo_t entinfo;
;5390:
;5391:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
;5392:		if (i == bs->client)
;5393:			continue;
;5394:		//
;5395:		BotEntityInfo(i, &entinfo);
;5396:		//if this player is active
;5397:		if (!entinfo.valid)
;5398:			continue;
;5399:		//if this player is carrying a flag
;5400:		if (!EntityCarriesCubes(&entinfo)) continue;
;5401:		//if the flag carrier is on the same team
;5402:		if (BotSameTeam(bs, i))
;5403:			continue;
;5404:		//if the flag carrier is not visible
;5405:		vis = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, i);
;5406:		if (vis <= 0)
;5407:			continue;
;5408:		//
;5409:		return i;
;5410:	}
;5411:	return -1;
;5412:}
;5413:#endif
;5414:
;5415:/*
;5416:==================
;5417:JUHOX: SearchGrappleTarget
;5418:==================
;5419:*/
;5420:static qboolean SearchGrappleTarget(int bot, vec3_t start, const vec3_t dest, const vec3_t dir, const vec3_t back, vec3_t target) {
line 5424
;5421:	vec3_t end, tmp;
;5422:	bsp_trace_t trace;
;5423:
;5424:	VectorMA(dest, 60, dir, end);
ADDRLP4 108
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 112
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 84
ADDRLP4 108
INDIRP4
INDIRF4
ADDRLP4 112
INDIRP4
INDIRF4
CNSTF4 1114636288
MULF4
ADDF4
ASGNF4
ADDRLP4 84+4
ADDRLP4 108
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 112
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1114636288
MULF4
ADDF4
ASGNF4
ADDRLP4 84+8
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1114636288
MULF4
ADDF4
ASGNF4
line 5425
;5425:	BotAI_Trace(&trace, start, NULL, NULL, end, bot, MASK_SHOT);
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 84
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 5426
;5426:	if (trace.fraction >= 1) return qfalse;	// no wall hit
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
LTF4 $1805
CNSTI4 0
RETI4
ADDRGP4 $1802
JUMPV
LABELV $1805
line 5427
;5427:	if (DistanceSquared(target, trace.endpos) > 10000) return qfalse;
ADDRFP4 20
INDIRP4
ARGP4
ADDRLP4 0+12
ARGP4
ADDRLP4 116
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 116
INDIRF4
CNSTF4 1176256512
LEF4 $1808
CNSTI4 0
RETI4
ADDRGP4 $1802
JUMPV
LABELV $1808
line 5428
;5428:	VectorMA(trace.endpos, 16, back, trace.endpos);
ADDRLP4 0+12
ADDRLP4 0+12
INDIRF4
ADDRFP4 16
INDIRP4
INDIRF4
CNSTF4 1098907648
MULF4
ADDF4
ASGNF4
ADDRLP4 0+12+4
ADDRLP4 0+12+4
INDIRF4
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1098907648
MULF4
ADDF4
ASGNF4
ADDRLP4 0+12+8
ADDRLP4 0+12+8
INDIRF4
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1098907648
MULF4
ADDF4
ASGNF4
line 5429
;5429:	VectorCopy(trace.endpos, end);
ADDRLP4 84
ADDRLP4 0+12
INDIRB
ASGNB 12
line 5430
;5430:	VectorCopy(trace.endpos, tmp);
ADDRLP4 96
ADDRLP4 0+12
INDIRB
ASGNB 12
line 5431
;5431:	end[2] -= 100;
ADDRLP4 84+8
ADDRLP4 84+8
INDIRF4
CNSTF4 1120403456
SUBF4
ASGNF4
line 5432
;5432:	BotAI_Trace(&trace, trace.endpos, NULL, NULL, end, bot, MASK_PLAYERSOLID|MASK_WATER);	// is there ground to stand on?
ADDRLP4 0
ARGP4
ADDRLP4 0+12
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 84
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
CNSTI4 33620025
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 5433
;5433:	if (trace.fraction >= 1) return qfalse;
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
LTF4 $1825
CNSTI4 0
RETI4
ADDRGP4 $1802
JUMPV
LABELV $1825
line 5434
;5434:	if ((trace.contents & MASK_PLAYERSOLID) == 0) return qfalse;	// the bot doesn't want to stand there
ADDRLP4 0+76
INDIRI4
CNSTI4 33619969
BANDI4
CNSTI4 0
NEI4 $1828
CNSTI4 0
RETI4
ADDRGP4 $1802
JUMPV
LABELV $1828
line 5435
;5435:	VectorCopy(tmp, target);
ADDRFP4 20
INDIRP4
ADDRLP4 96
INDIRB
ASGNB 12
line 5436
;5436:	return qtrue;
CNSTI4 1
RETI4
LABELV $1802
endproc SearchGrappleTarget 120 28
proc LeftOrRightGrappleTarget 56 24
line 5444
;5437:}
;5438:
;5439:/*
;5440:==================
;5441:JUHOX: LeftOrRightGrappleTarget
;5442:==================
;5443:*/
;5444:static qboolean LeftOrRightGrappleTarget(int bot, vec3_t start, vec3_t dest) {
line 5447
;5445:	vec3_t forward, right, end;
;5446:
;5447:	VectorSubtract(dest, start, forward);
ADDRLP4 36
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 40
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 36
INDIRP4
INDIRF4
ADDRLP4 40
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 36
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 5448
;5448:	VectorNormalize(forward);
ADDRLP4 0
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 5449
;5449:	CrossProduct(forward, axisDefault[2], right);
ADDRLP4 0
ARGP4
ADDRGP4 axisDefault+24
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 5450
;5450:	VectorMA(dest, 50, forward, end);
ADDRLP4 44
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 44
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
CNSTF4 1112014848
MULF4
ADDF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 44
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
CNSTF4 1112014848
MULF4
ADDF4
ASGNF4
ADDRLP4 24+8
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
CNSTF4 1112014848
MULF4
ADDF4
ASGNF4
line 5451
;5451:	VectorNegate(forward, forward);
ADDRLP4 0
ADDRLP4 0
INDIRF4
NEGF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
NEGF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
NEGF4
ASGNF4
line 5452
;5452:	if (SearchGrappleTarget(bot, start, end, right, forward, dest)) return qtrue;
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 SearchGrappleTarget
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $1843
CNSTI4 1
RETI4
ADDRGP4 $1831
JUMPV
LABELV $1843
line 5453
;5453:	VectorNegate(right, right);
ADDRLP4 12
ADDRLP4 12
INDIRF4
NEGF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
NEGF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
NEGF4
ASGNF4
line 5454
;5454:	if (SearchGrappleTarget(bot, start, end, right, forward, dest)) return qtrue;
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 SearchGrappleTarget
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $1849
CNSTI4 1
RETI4
ADDRGP4 $1831
JUMPV
LABELV $1849
line 5455
;5455:	return qfalse;
CNSTI4 0
RETI4
LABELV $1831
endproc LeftOrRightGrappleTarget 56 24
proc CheckWallTarget 124 28
line 5463
;5456:}
;5457:
;5458:/*
;5459:==================
;5460:JUHOX: CheckWallTarget
;5461:==================
;5462:*/
;5463:static qboolean CheckWallTarget(bot_state_t* bs, int enemy, vec3_t start, const vec3_t dest, const vec3_t dir, float maxdist, vec3_t target) {
line 5467
;5464:	vec3_t end, tmp;
;5465:	bsp_trace_t trace;
;5466:
;5467:	VectorMA(dest, maxdist, dir, end);
ADDRLP4 108
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 112
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 116
ADDRFP4 20
INDIRF4
ASGNF4
ADDRLP4 84
ADDRLP4 108
INDIRP4
INDIRF4
ADDRLP4 112
INDIRP4
INDIRF4
ADDRLP4 116
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 84+4
ADDRLP4 108
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 112
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 116
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 84+8
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 20
INDIRF4
MULF4
ADDF4
ASGNF4
line 5468
;5468:	BotAI_Trace(&trace, start, NULL, NULL, end, bs->client, MASK_SHOT);
ADDRLP4 0
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 84
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 5469
;5469:	if (trace.fraction >= 1) return qfalse;	// nothing hit
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
LTF4 $1854
CNSTI4 0
RETI4
ADDRGP4 $1851
JUMPV
LABELV $1854
line 5470
;5470:	if (Distance(target, trace.endpos) > 1.5 * maxdist) return qfalse;
ADDRFP4 24
INDIRP4
ARGP4
ADDRLP4 0+12
ARGP4
ADDRLP4 120
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRLP4 120
INDIRF4
ADDRFP4 20
INDIRF4
CNSTF4 1069547520
MULF4
LEF4 $1857
CNSTI4 0
RETI4
ADDRGP4 $1851
JUMPV
LABELV $1857
line 5471
;5471:	VectorCopy(trace.endpos, tmp);
ADDRLP4 96
ADDRLP4 0+12
INDIRB
ASGNB 12
line 5472
;5472:	BotAI_Trace(&trace, tmp, NULL, NULL, target, enemy, MASK_SHOT);
ADDRLP4 0
ARGP4
ADDRLP4 96
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 5473
;5473:	if (trace.fraction < 1) return qfalse;	// an obstacle between wall target and enemy
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
GEF4 $1861
CNSTI4 0
RETI4
ADDRGP4 $1851
JUMPV
LABELV $1861
line 5474
;5474:	VectorCopy(tmp, target);
ADDRFP4 24
INDIRP4
ADDRLP4 96
INDIRB
ASGNB 12
line 5475
;5475:	return qtrue;
CNSTI4 1
RETI4
LABELV $1851
endproc CheckWallTarget 124 28
proc SearchWallTarget 84 28
line 5483
;5476:}
;5477:
;5478:/*
;5479:==================
;5480:JUHOX: SearchWallTarget
;5481:==================
;5482:*/
;5483:static qboolean SearchWallTarget(bot_state_t* bs, int enemy, vec3_t start, vec3_t dest, float maxdist) {
line 5486
;5484:	vec3_t forward, right, up, end;
;5485:
;5486:	VectorSubtract(dest, start, forward);
ADDRLP4 48
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 52
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 48
INDIRP4
INDIRF4
ADDRLP4 52
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 48
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24+8
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 5487
;5487:	VectorNormalize(forward);
ADDRLP4 24
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 5488
;5488:	CrossProduct(forward, axisDefault[2], right);	// this may actually be a 'left' vector, but that doesn't matter
ADDRLP4 24
ARGP4
ADDRGP4 axisDefault+24
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 5489
;5489:	CrossProduct(forward, right, up);				// this may actually be a 'down' vector, but ... you know
ADDRLP4 24
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 5490
;5490:	VectorMA(dest, maxdist, forward, end);
ADDRLP4 56
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 60
ADDRFP4 16
INDIRF4
ASGNF4
ADDRLP4 36
ADDRLP4 56
INDIRP4
INDIRF4
ADDRLP4 24
INDIRF4
ADDRLP4 60
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 36+4
ADDRLP4 56
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 24+4
INDIRF4
ADDRLP4 60
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 36+8
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 24+8
INDIRF4
ADDRFP4 16
INDIRF4
MULF4
ADDF4
ASGNF4
line 5493
;5491:
;5492:	// make the wall target unpredictable for the enemy
;5493:	if (bs->walltargetorder_time < FloatTime() - 1 - 2 * random()) {
ADDRLP4 64
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRFP4 0
INDIRP4
CNSTI4 7408
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
SUBF4
ADDRLP4 64
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 64
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1073741824
MULF4
SUBF4
GEF4 $1872
line 5494
;5494:		bs->walltargetorder_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7408
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 5495
;5495:		bs->walltargetorder = rand();
ADDRLP4 68
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 7404
ADDP4
ADDRLP4 68
INDIRI4
ASGNI4
line 5496
;5496:	}
LABELV $1872
line 5497
;5497:	if (bs->walltargetorder & 1) VectorNegate(up, up);
ADDRFP4 0
INDIRP4
CNSTI4 7404
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1874
ADDRLP4 12
ADDRLP4 12
INDIRF4
NEGF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
NEGF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
NEGF4
ASGNF4
LABELV $1874
line 5498
;5498:	if (bs->walltargetorder & 2) VectorNegate(right, right);
ADDRFP4 0
INDIRP4
CNSTI4 7404
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1880
ADDRLP4 0
ADDRLP4 0
INDIRF4
NEGF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
NEGF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
NEGF4
ASGNF4
LABELV $1880
line 5499
;5499:	if (bs->walltargetorder & 4) {
ADDRFP4 0
INDIRP4
CNSTI4 7404
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $1886
line 5502
;5500:		vec3_t tmp;
;5501:
;5502:		VectorCopy(up, tmp);
ADDRLP4 68
ADDRLP4 12
INDIRB
ASGNB 12
line 5503
;5503:		VectorCopy(right, up);
ADDRLP4 12
ADDRLP4 0
INDIRB
ASGNB 12
line 5504
;5504:		VectorCopy(tmp, right);
ADDRLP4 0
ADDRLP4 68
INDIRB
ASGNB 12
line 5505
;5505:	}
LABELV $1886
line 5507
;5506:
;5507:	if (CheckWallTarget(bs, enemy, start, end, up, maxdist, dest)) return qtrue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 12
ARGP4
ADDRFP4 16
INDIRF4
ARGF4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 CheckWallTarget
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $1888
CNSTI4 1
RETI4
ADDRGP4 $1864
JUMPV
LABELV $1888
line 5508
;5508:	VectorNegate(up, up);
ADDRLP4 12
ADDRLP4 12
INDIRF4
NEGF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
NEGF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
NEGF4
ASGNF4
line 5509
;5509:	if (CheckWallTarget(bs, enemy, start, end, up, maxdist, dest)) return qtrue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 12
ARGP4
ADDRFP4 16
INDIRF4
ARGF4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 72
ADDRGP4 CheckWallTarget
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
EQI4 $1894
CNSTI4 1
RETI4
ADDRGP4 $1864
JUMPV
LABELV $1894
line 5511
;5510:
;5511:	if (CheckWallTarget(bs, enemy, start, end, right, maxdist, dest)) return qtrue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 0
ARGP4
ADDRFP4 16
INDIRF4
ARGF4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 76
ADDRGP4 CheckWallTarget
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
EQI4 $1896
CNSTI4 1
RETI4
ADDRGP4 $1864
JUMPV
LABELV $1896
line 5512
;5512:	VectorNegate(right, right);
ADDRLP4 0
ADDRLP4 0
INDIRF4
NEGF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
NEGF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
NEGF4
ASGNF4
line 5513
;5513:	if (CheckWallTarget(bs, enemy, start, end, right, maxdist, dest)) return qtrue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 0
ARGP4
ADDRFP4 16
INDIRF4
ARGF4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 80
ADDRGP4 CheckWallTarget
CALLI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 0
EQI4 $1902
CNSTI4 1
RETI4
ADDRGP4 $1864
JUMPV
LABELV $1902
line 5514
;5514:	return qfalse;
CNSTI4 0
RETI4
LABELV $1864
endproc SearchWallTarget 84 28
data
align 4
LABELV $1905
byte 4 3229614080
byte 4 3229614080
byte 4 3229614080
align 4
LABELV $1906
byte 4 1082130432
byte 4 1082130432
byte 4 1082130432
export BotAimAtEnemy
code
proc BotAimAtEnemy 1120 52
line 5522
;5515:}
;5516:
;5517:/*
;5518:==================
;5519:BotAimAtEnemy
;5520:==================
;5521:*/
;5522:void BotAimAtEnemy(bot_state_t *bs) {
line 5526
;5523:	int i, enemyvisible;
;5524:	float dist/*, f*/, aim_skill, aim_accuracy, speed/*, reactiontime*/;	// JUHOX: f and reactiontime no longer needed
;5525:	vec3_t dir, bestorigin, end, start, groundtarget, cmdmove, enemyvelocity;
;5526:	vec3_t mins = {-4,-4,-4}, maxs = {4, 4, 4};
ADDRLP4 856
ADDRGP4 $1905
INDIRB
ASGNB 12
ADDRLP4 868
ADDRGP4 $1906
INDIRB
ASGNB 12
line 5534
;5527:	weaponinfo_t wi;
;5528:	aas_entityinfo_t entinfo;
;5529:	bot_goal_t goal;
;5530:	bsp_trace_t trace;
;5531:	vec3_t target;
;5532:
;5533:	//if the bot has no enemy
;5534:	if (bs->enemy < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 0
GEI4 $1907
line 5535
;5535:		return;
ADDRGP4 $1904
JUMPV
LABELV $1907
line 5537
;5536:	}
;5537:	if (bs->weaponnum <= WP_NONE) return;	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 7804
ADDP4
INDIRI4
CNSTI4 0
GTI4 $1909
ADDRGP4 $1904
JUMPV
LABELV $1909
line 5539
;5538:	//get the enemy entity information
;5539:	BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 5544
;5540:	//if this is not a player (should be an obelisk)
;5541:#if !MONSTER_MODE	// JUHOX: let BotAimAtEnemy() accept monsters
;5542:	if (bs->enemy >= MAX_CLIENTS) {
;5543:#else
;5544:	if (bs->enemy >= MAX_CLIENTS && g_gametype.integer != GT_STU) {
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
CNSTI4 64
LTI4 $1911
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
EQI4 $1911
line 5547
;5545:#endif
;5546:		//if the obelisk is visible
;5547:		VectorCopy(entinfo.origin, target);
ADDRLP4 828
ADDRLP4 0+24
INDIRB
ASGNB 12
line 5556
;5548:#ifdef MISSIONPACK
;5549:		// if attacking an obelisk
;5550:		if ( bs->enemy == redobelisk.entitynum ||
;5551:			bs->enemy == blueobelisk.entitynum ) {
;5552:			target[2] += 32;
;5553:		}
;5554:#endif
;5555:		//aim at the obelisk
;5556:		VectorSubtract(target, bs->eye, dir);
ADDRLP4 976
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 828
INDIRF4
ADDRLP4 976
INDIRP4
CNSTI4 4944
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 828+4
INDIRF4
ADDRLP4 976
INDIRP4
CNSTI4 4948
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 828+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4952
ADDP4
INDIRF4
SUBF4
ASGNF4
line 5557
;5557:		vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 140
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 7852
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 5559
;5558:		//set the aim target before trying to attack
;5559:		VectorCopy(target, bs->aimtarget);
ADDRFP4 0
INDIRP4
CNSTI4 7392
ADDP4
ADDRLP4 828
INDIRB
ASGNB 12
line 5560
;5560:		return;
ADDRGP4 $1904
JUMPV
LABELV $1911
line 5565
;5561:	}
;5562:	//
;5563:	//BotAI_Print(PRT_MESSAGE, "client %d: aiming at client %d\n", bs->entitynum, bs->enemy);
;5564:	//
;5565:	aim_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_SKILL, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 16
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 976
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 732
ADDRLP4 976
INDIRF4
ASGNF4
line 5566
;5566:	aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 7
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 980
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 176
ADDRLP4 980
INDIRF4
ASGNF4
line 5581
;5567:	//
;5568:#if 0	// JUHOX: aiming reaction time handled in BotViewReaction()
;5569:	if (aim_skill > 0.95) {
;5570:		//don't aim too early
;5571:		reactiontime = 0.5 * trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_REACTIONTIME, 0, 1);
;5572:		if (bs->enemysight_time > FloatTime() - reactiontime) return;
;5573:		if (bs->teleport_time > FloatTime() - reactiontime) return;
;5574:	}
;5575:#endif
;5576:
;5577:	//get the weapon information
;5578:#if 0	// JUHOX: weapon info for new weapons
;5579:	trap_BotGetWeaponInfo(bs->ws, bs->weaponnum, &wi);
;5580:#else
;5581:	i = bs->weaponnum;
ADDRLP4 736
ADDRFP4 0
INDIRP4
CNSTI4 7804
ADDP4
INDIRI4
ASGNI4
line 5583
;5582:#if MONSTER_MODE
;5583:	if (i == WP_MONSTER_LAUNCHER) i = WP_GRENADE_LAUNCHER;
ADDRLP4 736
INDIRI4
CNSTI4 11
NEI4 $1919
ADDRLP4 736
CNSTI4 4
ASGNI4
LABELV $1919
line 5585
;5584:#endif
;5585:	trap_BotGetWeaponInfo(bs->ws, i, &wi);
ADDRFP4 0
INDIRP4
CNSTI4 7760
ADDP4
INDIRI4
ARGI4
ADDRLP4 736
INDIRI4
ARGI4
ADDRLP4 180
ARGP4
ADDRGP4 trap_BotGetWeaponInfo
CALLV
pop
line 5588
;5586:#endif
;5587:	//get the weapon specific aim accuracy and or aim skill
;5588:	if (wi.number == WP_MACHINEGUN) {
ADDRLP4 180+4
INDIRI4
CNSTI4 2
NEI4 $1921
line 5589
;5589:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_MACHINEGUN, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 8
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 984
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 176
ADDRLP4 984
INDIRF4
ASGNF4
line 5590
;5590:	}
ADDRGP4 $1922
JUMPV
LABELV $1921
line 5591
;5591:	else if (wi.number == WP_SHOTGUN) {
ADDRLP4 180+4
INDIRI4
CNSTI4 3
NEI4 $1924
line 5592
;5592:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_SHOTGUN, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 9
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 984
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 176
ADDRLP4 984
INDIRF4
ASGNF4
line 5593
;5593:	}
ADDRGP4 $1925
JUMPV
LABELV $1924
line 5594
;5594:	else if (wi.number == WP_GRENADE_LAUNCHER) {
ADDRLP4 180+4
INDIRI4
CNSTI4 4
NEI4 $1927
line 5595
;5595:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_GRENADELAUNCHER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 11
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 984
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 176
ADDRLP4 984
INDIRF4
ASGNF4
line 5596
;5596:		aim_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_SKILL_GRENADELAUNCHER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 18
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 988
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 732
ADDRLP4 988
INDIRF4
ASGNF4
line 5597
;5597:	}
ADDRGP4 $1928
JUMPV
LABELV $1927
line 5598
;5598:	else if (wi.number == WP_ROCKET_LAUNCHER) {
ADDRLP4 180+4
INDIRI4
CNSTI4 5
NEI4 $1930
line 5599
;5599:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_ROCKETLAUNCHER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 10
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 984
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 176
ADDRLP4 984
INDIRF4
ASGNF4
line 5600
;5600:		aim_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_SKILL_ROCKETLAUNCHER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 17
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 988
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 732
ADDRLP4 988
INDIRF4
ASGNF4
line 5601
;5601:	}
ADDRGP4 $1931
JUMPV
LABELV $1930
line 5602
;5602:	else if (wi.number == WP_LIGHTNING) {
ADDRLP4 180+4
INDIRI4
CNSTI4 6
NEI4 $1933
line 5603
;5603:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_LIGHTNING, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 12
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 984
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 176
ADDRLP4 984
INDIRF4
ASGNF4
line 5604
;5604:	}
ADDRGP4 $1934
JUMPV
LABELV $1933
line 5605
;5605:	else if (wi.number == WP_RAILGUN) {
ADDRLP4 180+4
INDIRI4
CNSTI4 7
NEI4 $1936
line 5606
;5606:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_RAILGUN, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 14
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 984
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 176
ADDRLP4 984
INDIRF4
ASGNF4
line 5607
;5607:	}
ADDRGP4 $1937
JUMPV
LABELV $1936
line 5608
;5608:	else if (wi.number == WP_PLASMAGUN) {
ADDRLP4 180+4
INDIRI4
CNSTI4 8
NEI4 $1939
line 5609
;5609:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_PLASMAGUN, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 13
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 984
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 176
ADDRLP4 984
INDIRF4
ASGNF4
line 5610
;5610:		aim_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_SKILL_PLASMAGUN, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 19
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 988
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 732
ADDRLP4 988
INDIRF4
ASGNF4
line 5611
;5611:	}
ADDRGP4 $1940
JUMPV
LABELV $1939
line 5612
;5612:	else if (wi.number == WP_BFG) {
ADDRLP4 180+4
INDIRI4
CNSTI4 9
NEI4 $1942
line 5613
;5613:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_BFG10K, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 15
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 984
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 176
ADDRLP4 984
INDIRF4
ASGNF4
line 5614
;5614:		aim_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_SKILL_BFG10K, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 20
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 988
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 732
ADDRLP4 988
INDIRF4
ASGNF4
line 5615
;5615:		wi.speed = 1000;	// JUHOX
ADDRLP4 180+272
CNSTF4 1148846080
ASGNF4
line 5616
;5616:	}
LABELV $1942
LABELV $1940
LABELV $1937
LABELV $1934
LABELV $1931
LABELV $1928
LABELV $1925
LABELV $1922
line 5627
;5617:#if 0	// -JUHOX: grapple weapon info
;5618:	if (bs->weaponnum == WP_GRAPPLING_HOOK) {
;5619:		wi.number = WP_GRAPPLING_HOOK;
;5620:		wi.speed = 1500;
;5621:		wi.hspread = 0;
;5622:		wi.vspread = 0;
;5623:		wi.proj.damagetype = 0;
;5624:	}
;5625:#endif
;5626:	//
;5627:	if (aim_accuracy <= 0) aim_accuracy = 0.0001f;
ADDRLP4 176
INDIRF4
CNSTF4 0
GTF4 $1946
ADDRLP4 176
CNSTF4 953267991
ASGNF4
LABELV $1946
line 5629
;5628:	//get the enemy entity information
;5629:	BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 5631
;5630:	//if the enemy is invisible then shoot crappy most of the time
;5631:	if (EntityIsInvisible(VIEWER_OTHERTEAM, &entinfo)) {	// JUHOX: added 'VIEWER_OTHERTEAM'
CNSTI4 -2
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 984
ADDRGP4 EntityIsInvisible
CALLI4
ASGNI4
ADDRLP4 984
INDIRI4
CNSTI4 0
EQI4 $1948
line 5635
;5632:#if 0	// JUHOX: worse accuracy for invisible enemies
;5633:		if (random() > 0.1) aim_accuracy *= 0.4f;
;5634:#else
;5635:		aim_accuracy *= 0.3f;
ADDRLP4 176
ADDRLP4 176
INDIRF4
CNSTF4 1050253722
MULF4
ASGNF4
line 5637
;5636:#endif
;5637:	}
LABELV $1948
line 5639
;5638:	//
;5639:	VectorSubtract(entinfo.origin, entinfo.lastvisorigin, enemyvelocity);
ADDRLP4 152
ADDRLP4 0+24
INDIRF4
ADDRLP4 0+60
INDIRF4
SUBF4
ASGNF4
ADDRLP4 152+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 0+60+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 152+8
ADDRLP4 0+24+8
INDIRF4
ADDRLP4 0+60+8
INDIRF4
SUBF4
ASGNF4
line 5640
;5640:	VectorScale(enemyvelocity, 1 / entinfo.update_time, enemyvelocity);
ADDRLP4 152
ADDRLP4 152
INDIRF4
CNSTF4 1065353216
ADDRLP4 0+16
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 152+4
ADDRLP4 152+4
INDIRF4
CNSTF4 1065353216
ADDRLP4 0+16
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 152+8
ADDRLP4 152+8
INDIRF4
CNSTF4 1065353216
ADDRLP4 0+16
INDIRF4
DIVF4
MULF4
ASGNF4
line 5642
;5641:	//enemy origin and velocity is remembered every 0.5 seconds
;5642:	if (bs->enemyposition_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 7232
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $1969
line 5644
;5643:		//
;5644:		bs->enemyposition_time = FloatTime() + 0.5;
ADDRFP4 0
INDIRP4
CNSTI4 7232
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 5645
;5645:		VectorCopy(enemyvelocity, bs->enemyvelocity);
ADDRFP4 0
INDIRP4
CNSTI4 7432
ADDP4
ADDRLP4 152
INDIRB
ASGNB 12
line 5646
;5646:		VectorCopy(entinfo.origin, bs->enemyorigin);
ADDRFP4 0
INDIRP4
CNSTI4 7444
ADDP4
ADDRLP4 0+24
INDIRB
ASGNB 12
line 5647
;5647:	}
LABELV $1969
line 5649
;5648:	//if not extremely skilled
;5649:	if (aim_skill < 0.9) {
ADDRLP4 732
INDIRF4
CNSTF4 1063675494
GEF4 $1972
line 5650
;5650:		VectorSubtract(entinfo.origin, bs->enemyorigin, dir);
ADDRLP4 988
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 0+24
INDIRF4
ADDRLP4 988
INDIRP4
CNSTI4 7444
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 988
INDIRP4
CNSTI4 7448
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 7452
ADDP4
INDIRF4
SUBF4
ASGNF4
line 5652
;5651:		//if the enemy moved a bit
;5652:		if (VectorLengthSquared(dir) > Square(48)) {
ADDRLP4 140
ARGP4
ADDRLP4 992
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 992
INDIRF4
CNSTF4 1158676480
LEF4 $1981
line 5654
;5653:			//if the enemy changed direction
;5654:			if (DotProduct(bs->enemyvelocity, enemyvelocity) < 0) {
ADDRLP4 996
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 996
INDIRP4
CNSTI4 7432
ADDP4
INDIRF4
ADDRLP4 152
INDIRF4
MULF4
ADDRLP4 996
INDIRP4
CNSTI4 7436
ADDP4
INDIRF4
ADDRLP4 152+4
INDIRF4
MULF4
ADDF4
ADDRLP4 996
INDIRP4
CNSTI4 7440
ADDP4
INDIRF4
ADDRLP4 152+8
INDIRF4
MULF4
ADDF4
CNSTF4 0
GEF4 $1983
line 5656
;5655:				//aim accuracy should be worse now
;5656:				aim_accuracy *= 0.7f;
ADDRLP4 176
ADDRLP4 176
INDIRF4
CNSTF4 1060320051
MULF4
ASGNF4
line 5657
;5657:			}
LABELV $1983
line 5658
;5658:		}
LABELV $1981
line 5666
;5659:#if 0	// -JUHOX: accuracy should also depend directly on enemy velocity
;5660:		dist = VectorNormalize(dir);
;5661:		if (dist < 1) dist = 1;
;5662:		CrossProduct(dir, enemyvelocity, end);	// 'end' used temporary
;5663:		aim_accuracy -= VectorLength(end) / dist;
;5664:		if (aim_accuracy < 0) aim_accuracy = 0;
;5665:#endif
;5666:	}
LABELV $1972
line 5668
;5667:	//check visibility of enemy
;5668:	enemyvisible = BotEntityVisible(&bs->cur_ps/*bs->entitynum, bs->eye, bs->viewangles*/, 360, bs->enemy);	// JUHOX
ADDRLP4 988
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 988
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 988
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
ARGI4
ADDRLP4 992
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 824
ADDRLP4 992
INDIRF4
CVFI4 4
ASGNI4
line 5670
;5669:	//if the enemy is visible
;5670:	if (enemyvisible) {
ADDRLP4 824
INDIRI4
CNSTI4 0
EQI4 $1987
line 5672
;5671:		//
;5672:		VectorCopy(entinfo.origin, bestorigin);
ADDRLP4 164
ADDRLP4 0+24
INDIRB
ASGNB 12
line 5673
;5673:		bestorigin[2] += 8;
ADDRLP4 164+8
ADDRLP4 164+8
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 5676
;5674:		//get the start point shooting from
;5675:		//NOTE: the x and y projectile start offsets are ignored
;5676:		VectorCopy(bs->origin, start);
ADDRLP4 844
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRB
ASGNB 12
line 5677
;5677:		start[2] += bs->cur_ps.viewheight;
ADDRLP4 844+8
ADDRLP4 844+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 5678
;5678:		start[2] += wi.offset[2];
ADDRLP4 844+8
ADDRLP4 844+8
INDIRF4
ADDRLP4 180+292+8
INDIRF4
ADDF4
ASGNF4
line 5680
;5679:		//
;5680:		BotAI_Trace(&trace, start, mins, maxs, bestorigin, bs->entitynum, MASK_SHOT);
ADDRLP4 740
ARGP4
ADDRLP4 844
ARGP4
ADDRLP4 856
ARGP4
ADDRLP4 868
ARGP4
ADDRLP4 164
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 5682
;5681:		//if the enemy is NOT hit
;5682:		if (trace.fraction <= 1 && trace.ent != entinfo.number) {
ADDRLP4 740+8
INDIRF4
CNSTF4 1065353216
GTF4 $1995
ADDRLP4 740+80
INDIRI4
ADDRLP4 0+20
INDIRI4
EQI4 $1995
line 5683
;5683:			bestorigin[2] += 16;
ADDRLP4 164+8
ADDRLP4 164+8
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 5684
;5684:		}
LABELV $1995
line 5686
;5685:		//if it is not an instant hit weapon the bot might want to predict the enemy
;5686:		if (wi.speed) {
ADDRLP4 180+272
INDIRF4
CNSTF4 0
EQF4 $2001
line 5688
;5687:			//
;5688:			VectorSubtract(bestorigin, bs->origin, dir);
ADDRLP4 996
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 164
INDIRF4
ADDRLP4 996
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 164+4
INDIRF4
ADDRLP4 996
INDIRP4
CNSTI4 4920
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 164+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRF4
SUBF4
ASGNF4
line 5689
;5689:			dist = VectorLength(dir);
ADDRLP4 140
ARGP4
ADDRLP4 1000
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 840
ADDRLP4 1000
INDIRF4
ASGNF4
line 5690
;5690:			VectorSubtract(entinfo.origin, bs->enemyorigin, dir);
ADDRLP4 1004
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 0+24
INDIRF4
ADDRLP4 1004
INDIRP4
CNSTI4 7444
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 1004
INDIRP4
CNSTI4 7448
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 7452
ADDP4
INDIRF4
SUBF4
ASGNF4
line 5692
;5691:			//if the enemy is NOT pretty far away and strafing just small steps left and right
;5692:			if (!(dist > 100 && VectorLengthSquared(dir) < Square(32))) {
ADDRLP4 840
INDIRF4
CNSTF4 1120403456
LEF4 $2017
ADDRLP4 140
ARGP4
ADDRLP4 1008
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 1008
INDIRF4
CNSTF4 1149239296
LTF4 $2015
LABELV $2017
line 5694
;5693:				//if skilled anough do exact prediction
;5694:				if (aim_skill > 0.8 &&
ADDRLP4 732
INDIRF4
CNSTF4 1061997773
LEF4 $2018
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2018
line 5696
;5695:						//if the weapon is ready to fire
;5696:						bs->cur_ps.weaponstate == WEAPON_READY) {
line 5700
;5697:					aas_clientmove_t move;
;5698:					vec3_t origin;
;5699:
;5700:					VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 1108
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 0+24
INDIRF4
ADDRLP4 1108
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 1108
INDIRP4
CNSTI4 4920
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRF4
SUBF4
ASGNF4
line 5702
;5701:					//distance towards the enemy
;5702:					dist = VectorLength(dir);
ADDRLP4 140
ARGP4
ADDRLP4 1112
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 840
ADDRLP4 1112
INDIRF4
ASGNF4
line 5704
;5703:					//direction the enemy is moving in
;5704:					VectorSubtract(entinfo.origin, entinfo.lastvisorigin, dir);
ADDRLP4 140
ADDRLP4 0+24
INDIRF4
ADDRLP4 0+60
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 0+60+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 0+24+8
INDIRF4
ADDRLP4 0+60+8
INDIRF4
SUBF4
ASGNF4
line 5706
;5705:					//
;5706:					VectorScale(dir, 1 / entinfo.update_time, dir);
ADDRLP4 140
ADDRLP4 140
INDIRF4
CNSTF4 1065353216
ADDRLP4 0+16
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 140+4
INDIRF4
CNSTF4 1065353216
ADDRLP4 0+16
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 140+8
INDIRF4
CNSTF4 1065353216
ADDRLP4 0+16
INDIRF4
DIVF4
MULF4
ASGNF4
line 5708
;5707:					//
;5708:					VectorCopy(entinfo.origin, origin);
ADDRLP4 1012
ADDRLP4 0+24
INDIRB
ASGNB 12
line 5709
;5709:					origin[2] += 1;
ADDRLP4 1012+8
ADDRLP4 1012+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 5711
;5710:					//
;5711:					VectorClear(cmdmove);
ADDRLP4 1116
CNSTF4 0
ASGNF4
ADDRLP4 960+8
ADDRLP4 1116
INDIRF4
ASGNF4
ADDRLP4 960+4
ADDRLP4 1116
INDIRF4
ASGNF4
ADDRLP4 960
ADDRLP4 1116
INDIRF4
ASGNF4
line 5713
;5712:					//AAS_ClearShownDebugLines();
;5713:					trap_AAS_PredictClientMovement(&move, bs->enemy, origin,
ADDRLP4 1024
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
ARGI4
ADDRLP4 1012
ARGP4
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 140
ARGP4
ADDRLP4 960
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 840
INDIRF4
CNSTF4 1092616192
MULF4
ADDRLP4 180+272
INDIRF4
DIVF4
CVFI4 4
ARGI4
CNSTF4 1036831949
ARGF4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_AAS_PredictClientMovement
CALLI4
pop
line 5717
;5714:														PRESENCE_CROUCH, qfalse,
;5715:														dir, cmdmove, 0,
;5716:														dist * 10 / wi.speed, 0.1f, 0, 0, qfalse);
;5717:					VectorCopy(move.endpos, bestorigin);
ADDRLP4 164
ADDRLP4 1024
INDIRB
ASGNB 12
line 5719
;5718:					//BotAI_Print(PRT_MESSAGE, "%1.1f predicted speed = %f, frames = %f\n", FloatTime(), VectorLength(dir), dist * 10 / wi.speed);
;5719:				}
ADDRGP4 $2019
JUMPV
LABELV $2018
line 5721
;5720:				//if not that skilled do linear prediction
;5721:				else if (aim_skill > 0.4) {
ADDRLP4 732
INDIRF4
CNSTF4 1053609165
LEF4 $2051
line 5722
;5722:					VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 1012
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 0+24
INDIRF4
ADDRLP4 1012
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 1012
INDIRP4
CNSTI4 4920
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRF4
SUBF4
ASGNF4
line 5724
;5723:					//distance towards the enemy
;5724:					dist = VectorLength(dir);
ADDRLP4 140
ARGP4
ADDRLP4 1016
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 840
ADDRLP4 1016
INDIRF4
ASGNF4
line 5726
;5725:					//direction the enemy is moving in
;5726:					VectorSubtract(entinfo.origin, entinfo.lastvisorigin, dir);
ADDRLP4 140
ADDRLP4 0+24
INDIRF4
ADDRLP4 0+60
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 0+60+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 0+24+8
INDIRF4
ADDRLP4 0+60+8
INDIRF4
SUBF4
ASGNF4
line 5727
;5727:					dir[2] = 0;
ADDRLP4 140+8
CNSTF4 0
ASGNF4
line 5729
;5728:					//
;5729:					speed = VectorNormalize(dir) / entinfo.update_time;
ADDRLP4 140
ARGP4
ADDRLP4 1020
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 972
ADDRLP4 1020
INDIRF4
ADDRLP4 0+16
INDIRF4
DIVF4
ASGNF4
line 5732
;5730:					//botimport.Print(PRT_MESSAGE, "speed = %f, wi->speed = %f\n", speed, wi->speed);
;5731:					//best spot to aim at
;5732:					VectorMA(entinfo.origin, (dist / wi.speed) * speed, dir, bestorigin);
ADDRLP4 1024
ADDRLP4 840
INDIRF4
ASGNF4
ADDRLP4 1028
ADDRLP4 972
INDIRF4
ASGNF4
ADDRLP4 164
ADDRLP4 0+24
INDIRF4
ADDRLP4 140
INDIRF4
ADDRLP4 1024
INDIRF4
ADDRLP4 180+272
INDIRF4
DIVF4
ADDRLP4 1028
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 164+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 140+4
INDIRF4
ADDRLP4 1024
INDIRF4
ADDRLP4 180+272
INDIRF4
DIVF4
ADDRLP4 1028
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 164+8
ADDRLP4 0+24+8
INDIRF4
ADDRLP4 140+8
INDIRF4
ADDRLP4 840
INDIRF4
ADDRLP4 180+272
INDIRF4
DIVF4
ADDRLP4 972
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 5733
;5733:				}
LABELV $2051
LABELV $2019
line 5734
;5734:			}
LABELV $2015
line 5735
;5735:		}
LABELV $2001
line 5772
;5736:		//if the projectile does radial damage
;5737:#if 0	// JUHOX: new wall aiming
;5738:		if (aim_skill > 0.6 && wi.proj.damagetype & DAMAGETYPE_RADIAL) {
;5739:			//if the enemy isn't standing significantly higher than the bot
;5740:			if (entinfo.origin[2] < bs->origin[2] + 16) {
;5741:				//try to aim at the ground in front of the enemy
;5742:				VectorCopy(entinfo.origin, end);
;5743:				end[2] -= 64;
;5744:				BotAI_Trace(&trace, entinfo.origin, NULL, NULL, end, entinfo.number, MASK_SHOT);
;5745:				//
;5746:				VectorCopy(bestorigin, groundtarget);
;5747:				if (trace.startsolid) groundtarget[2] = entinfo.origin[2] - 16;
;5748:				else groundtarget[2] = trace.endpos[2] - 8;
;5749:				//trace a line from projectile start to ground target
;5750:				BotAI_Trace(&trace, start, NULL, NULL, groundtarget, bs->entitynum, MASK_SHOT);
;5751:				//if hitpoint is not vertically too far from the ground target
;5752:				if (fabs(trace.endpos[2] - groundtarget[2]) < 50) {
;5753:					VectorSubtract(trace.endpos, groundtarget, dir);
;5754:					//if the hitpoint is near anough the ground target
;5755:					if (VectorLengthSquared(dir) < Square(60)) {
;5756:						VectorSubtract(trace.endpos, start, dir);
;5757:						//if the hitpoint is far anough from the bot
;5758:						if (VectorLengthSquared(dir) > Square(100)) {
;5759:							//check if the bot is visible from the ground target
;5760:							trace.endpos[2] += 1;
;5761:							BotAI_Trace(&trace, trace.endpos, NULL, NULL, entinfo.origin, entinfo.number, MASK_SHOT);
;5762:							if (trace.fraction >= 1) {
;5763:								//botimport.Print(PRT_MESSAGE, "%1.1f aiming at ground\n", AAS_Time());
;5764:								VectorCopy(groundtarget, bestorigin);
;5765:							}
;5766:						}
;5767:					}
;5768:				}
;5769:			}
;5770:		}
;5771:#else
;5772:		if (aim_skill > 0.6) {
ADDRLP4 732
INDIRF4
CNSTF4 1058642330
LEF4 $2086
line 5773
;5773:			switch (bs->weaponnum) {
ADDRLP4 996
ADDRFP4 0
INDIRP4
CNSTI4 7804
ADDP4
INDIRI4
ASGNI4
ADDRLP4 996
INDIRI4
CNSTI4 4
EQI4 $2091
ADDRLP4 996
INDIRI4
CNSTI4 5
EQI4 $2091
ADDRLP4 996
INDIRI4
CNSTI4 9
EQI4 $2091
ADDRGP4 $2088
JUMPV
LABELV $2091
line 5778
;5774:			case WP_GRENADE_LAUNCHER:
;5775:			case WP_ROCKET_LAUNCHER:
;5776:			case WP_BFG:
;5777:			// JUHOX FIXME: try to handle grapple here too
;5778:				if (SearchWallTarget(bs, entinfo.number, bs->origin, bestorigin, 100)) {
ADDRLP4 1004
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1004
INDIRP4
ARGP4
ADDRLP4 0+20
INDIRI4
ARGI4
ADDRLP4 1004
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 164
ARGP4
CNSTF4 1120403456
ARGF4
ADDRLP4 1008
ADDRGP4 SearchWallTarget
CALLI4
ASGNI4
ADDRLP4 1008
INDIRI4
CNSTI4 0
EQI4 $2087
line 5779
;5779:					bs->walltarget_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7412
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 5780
;5780:				}
line 5781
;5781:				break;
ADDRGP4 $2087
JUMPV
LABELV $2088
line 5783
;5782:			default:
;5783:				{
line 5786
;5784:					vec3_t dummy;
;5785:
;5786:					VectorCopy(bestorigin, dummy);
ADDRLP4 1012
ADDRLP4 164
INDIRB
ASGNB 12
line 5787
;5787:					if (SearchWallTarget(bs, entinfo.number, bs->origin, dummy, 100)) {
ADDRLP4 1024
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1024
INDIRP4
ARGP4
ADDRLP4 0+20
INDIRI4
ARGI4
ADDRLP4 1024
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 1012
ARGP4
CNSTF4 1120403456
ARGF4
ADDRLP4 1028
ADDRGP4 SearchWallTarget
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 0
EQI4 $2087
line 5788
;5788:						bs->walltarget_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7412
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 5789
;5789:					}
line 5790
;5790:				}
line 5791
;5791:				break;
line 5793
;5792:			}
;5793:		}
ADDRGP4 $2087
JUMPV
LABELV $2086
line 5794
;5794:		else {
line 5795
;5795:			bs->walltarget_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7412
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 5796
;5796:		}
LABELV $2087
line 5799
;5797:#endif
;5798:#if 1	// JUHOX: grapple aiming
;5799:		if (bs->weaponnum == WP_GRAPPLING_HOOK && aim_skill > 0.3) {
ADDRFP4 0
INDIRP4
CNSTI4 7804
ADDP4
INDIRI4
CNSTI4 10
NEI4 $2098
ADDRLP4 732
INDIRF4
CNSTF4 1050253722
LEF4 $2098
line 5800
;5800:			qboolean foundGrappleTarget = qfalse; // JUHOX
ADDRLP4 996
CNSTI4 0
ASGNI4
line 5802
;5801:
;5802:			if (entinfo.origin[2] > bs->origin[2]) {	// if the enemy is higher than the bot
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRF4
LEF4 $2100
line 5804
;5803:				// try to aim at the ceiling above the predicted enemy
;5804:				VectorCopy(bestorigin, end);
ADDRLP4 936
ADDRLP4 164
INDIRB
ASGNB 12
line 5805
;5805:				end[2] += 200;
ADDRLP4 936+8
ADDRLP4 936+8
INDIRF4
CNSTF4 1128792064
ADDF4
ASGNF4
line 5806
;5806:				BotAI_Trace(&trace, bestorigin, NULL, NULL, end, entinfo.number, MASK_SHOT);
ADDRLP4 740
ARGP4
ADDRLP4 164
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 936
ARGP4
ADDRLP4 0+20
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 5807
;5807:				if (trace.fraction < 1) {
ADDRLP4 740+8
INDIRF4
CNSTF4 1065353216
GEF4 $2106
line 5808
;5808:					VectorCopy(trace.endpos, groundtarget);	// the 'groundtarget' is actually the ceiling target
ADDRLP4 948
ADDRLP4 740+12
INDIRB
ASGNB 12
line 5810
;5809:					// test if the ceiling is visible from the bot
;5810:					BotAI_Trace(&trace, start, NULL, NULL, groundtarget, bs->entitynum, MASK_SHOT);
ADDRLP4 740
ARGP4
ADDRLP4 844
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 948
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 5811
;5811:					VectorSubtract(trace.endpos, groundtarget, dir);
ADDRLP4 140
ADDRLP4 740+12
INDIRF4
ADDRLP4 948
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 740+12+4
INDIRF4
ADDRLP4 948+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 740+12+8
INDIRF4
ADDRLP4 948+8
INDIRF4
SUBF4
ASGNF4
line 5812
;5812:					if (VectorLength(dir) < 30) {
ADDRLP4 140
ARGP4
ADDRLP4 1000
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 1000
INDIRF4
CNSTF4 1106247680
GEF4 $2119
line 5813
;5813:						VectorCopy(groundtarget, bestorigin);
ADDRLP4 164
ADDRLP4 948
INDIRB
ASGNB 12
line 5814
;5814:						foundGrappleTarget = qtrue;
ADDRLP4 996
CNSTI4 1
ASGNI4
line 5815
;5815:					}
LABELV $2119
line 5816
;5816:				}
LABELV $2106
line 5817
;5817:			}
LABELV $2100
line 5818
;5818:			if (!foundGrappleTarget) {
ADDRLP4 996
INDIRI4
CNSTI4 0
NEI4 $2121
line 5820
;5819:				// try to aim at a wall near the enemy
;5820:				foundGrappleTarget = LeftOrRightGrappleTarget(bs->entitynum, bs->origin, bestorigin);
ADDRLP4 1000
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1000
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 1000
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 164
ARGP4
ADDRLP4 1004
ADDRGP4 LeftOrRightGrappleTarget
CALLI4
ASGNI4
ADDRLP4 996
ADDRLP4 1004
INDIRI4
ASGNI4
line 5821
;5821:			}
LABELV $2121
line 5822
;5822:		}
LABELV $2098
line 5829
;5823:#endif
;5824:#if 0	// JUHOX: the farther away the enemy the greater the error
;5825:		bestorigin[0] += 20 * crandom() * (1 - aim_accuracy);
;5826:		bestorigin[1] += 20 * crandom() * (1 - aim_accuracy);
;5827:		bestorigin[2] += 10 * crandom() * (1 - aim_accuracy);
;5828:#else
;5829:		dist = (1 - aim_accuracy) * Distance(bs->origin, bestorigin) / /*15*/30;
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRLP4 164
ARGP4
ADDRLP4 996
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRLP4 840
CNSTF4 1065353216
ADDRLP4 176
INDIRF4
SUBF4
ADDRLP4 996
INDIRF4
MULF4
CNSTF4 1023969417
MULF4
ASGNF4
line 5830
;5830:		bestorigin[0] += dist * crandom();
ADDRLP4 1000
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 164
ADDRLP4 164
INDIRF4
ADDRLP4 840
INDIRF4
ADDRLP4 1000
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 1000
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
MULF4
ADDF4
ASGNF4
line 5831
;5831:		bestorigin[1] += dist * crandom();
ADDRLP4 1004
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 164+4
ADDRLP4 164+4
INDIRF4
ADDRLP4 840
INDIRF4
ADDRLP4 1004
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 1004
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
MULF4
ADDF4
ASGNF4
line 5832
;5832:		bestorigin[2] += dist * crandom();
ADDRLP4 1008
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 164+8
ADDRLP4 164+8
INDIRF4
ADDRLP4 840
INDIRF4
ADDRLP4 1008
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 1008
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
MULF4
ADDF4
ASGNF4
line 5834
;5833:#endif
;5834:	}
ADDRGP4 $1988
JUMPV
LABELV $1987
line 5835
;5835:	else {
line 5836
;5836:		if (bs->cur_ps.pm_flags & PMF_DUCKED) bs->couldNotSeeEnemyWhileDucked_time = FloatTime();	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $2125
ADDRFP4 0
INDIRP4
CNSTI4 7420
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
LABELV $2125
line 5838
;5837:		//
;5838:		VectorCopy(bs->lastenemyorigin, bestorigin);
ADDRLP4 164
ADDRFP4 0
INDIRP4
CNSTI4 7772
ADDP4
INDIRB
ASGNB 12
line 5839
;5839:		bestorigin[2] += 8;
ADDRLP4 164+8
ADDRLP4 164+8
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 5844
;5840:		//if the bot is skilled anough
;5841:#if 0	// JUHOX: no prediction shots if the enemy area has been predicted
;5842:		if (aim_skill > 0.5) {
;5843:#else
;5844:		if (aim_skill > 0.5 && !bs->lastEnemyAreaPredicted) {
ADDRLP4 732
INDIRF4
CNSTF4 1056964608
LEF4 $2128
ADDRFP4 0
INDIRP4
CNSTI4 7784
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2128
line 5847
;5845:#endif
;5846:			//do prediction shots around corners
;5847:			if (wi.number == WP_BFG ||
ADDRLP4 180+4
INDIRI4
CNSTI4 9
EQI4 $2138
ADDRLP4 180+4
INDIRI4
CNSTI4 5
EQI4 $2138
ADDRLP4 180+4
INDIRI4
CNSTI4 8
EQI4 $2138
ADDRLP4 180+4
INDIRI4
CNSTI4 4
NEI4 $2130
LABELV $2138
line 5850
;5848:				wi.number == WP_ROCKET_LAUNCHER ||
;5849:				wi.number == WP_PLASMAGUN ||	// JUHOX: plasmagun has a significantly greater splash radius now
;5850:				wi.number == WP_GRENADE_LAUNCHER) {
line 5852
;5851:				//create the chase goal
;5852:				goal.entitynum = bs->client;
ADDRLP4 880+40
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 5853
;5853:				goal.areanum = bs->areanum;
ADDRLP4 880+12
ADDRFP4 0
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
ASGNI4
line 5854
;5854:				VectorCopy(bs->eye, goal.origin);
ADDRLP4 880
ADDRFP4 0
INDIRP4
CNSTI4 4944
ADDP4
INDIRB
ASGNB 12
line 5855
;5855:				VectorSet(goal.mins, -8, -8, -8);
ADDRLP4 880+16
CNSTF4 3238002688
ASGNF4
ADDRLP4 880+16+4
CNSTF4 3238002688
ASGNF4
ADDRLP4 880+16+8
CNSTF4 3238002688
ASGNF4
line 5856
;5856:				VectorSet(goal.maxs, 8, 8, 8);
ADDRLP4 880+28
CNSTF4 1090519040
ASGNF4
ADDRLP4 880+28+4
CNSTF4 1090519040
ASGNF4
ADDRLP4 880+28+8
CNSTF4 1090519040
ASGNF4
line 5858
;5857:				//
;5858:				if (trap_BotPredictVisiblePosition(bs->lastenemyorigin, bs->lastenemyareanum, &goal, TFL_DEFAULT, target)) {
ADDRLP4 996
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 996
INDIRP4
CNSTI4 7772
ADDP4
ARGP4
ADDRLP4 996
INDIRP4
CNSTI4 7768
ADDP4
INDIRI4
ARGI4
ADDRLP4 880
ARGP4
CNSTI4 18616254
ARGI4
ADDRLP4 828
ARGP4
ADDRLP4 1000
ADDRGP4 trap_BotPredictVisiblePosition
CALLI4
ASGNI4
ADDRLP4 1000
INDIRI4
CNSTI4 0
EQI4 $2151
line 5859
;5859:					VectorSubtract(target, bs->eye, dir);
ADDRLP4 1004
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 828
INDIRF4
ADDRLP4 1004
INDIRP4
CNSTI4 4944
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 828+4
INDIRF4
ADDRLP4 1004
INDIRP4
CNSTI4 4948
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 828+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4952
ADDP4
INDIRF4
SUBF4
ASGNF4
line 5860
;5860:					if (VectorLengthSquared(dir) > Square(80)) {
ADDRLP4 140
ARGP4
ADDRLP4 1008
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 1008
INDIRF4
CNSTF4 1170735104
LEF4 $2157
line 5861
;5861:						VectorCopy(target, bestorigin);
ADDRLP4 164
ADDRLP4 828
INDIRB
ASGNB 12
line 5862
;5862:						bestorigin[2] -= 20;
ADDRLP4 164+8
ADDRLP4 164+8
INDIRF4
CNSTF4 1101004800
SUBF4
ASGNF4
line 5863
;5863:					}
LABELV $2157
line 5864
;5864:				}
LABELV $2151
line 5865
;5865:				aim_accuracy = 1;
ADDRLP4 176
CNSTF4 1065353216
ASGNF4
line 5866
;5866:			}
LABELV $2130
line 5867
;5867:		}
LABELV $2128
line 5868
;5868:	}
LABELV $1988
line 5870
;5869:	//
;5870:	if (enemyvisible) {
ADDRLP4 824
INDIRI4
CNSTI4 0
EQI4 $2160
line 5871
;5871:		BotAI_Trace(&trace, bs->eye, NULL, NULL, bestorigin, bs->entitynum, MASK_SHOT);
ADDRLP4 740
ARGP4
ADDRLP4 996
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 996
INDIRP4
CNSTI4 4944
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 164
ARGP4
ADDRLP4 996
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 5872
;5872:		VectorCopy(trace.endpos, bs->aimtarget);
ADDRFP4 0
INDIRP4
CNSTI4 7392
ADDP4
ADDRLP4 740+12
INDIRB
ASGNB 12
line 5873
;5873:	}
ADDRGP4 $2161
JUMPV
LABELV $2160
line 5874
;5874:	else {
line 5875
;5875:		VectorCopy(bestorigin, bs->aimtarget);
ADDRFP4 0
INDIRP4
CNSTI4 7392
ADDP4
ADDRLP4 164
INDIRB
ASGNB 12
line 5876
;5876:	}
LABELV $2161
line 5878
;5877:	//get aim direction
;5878:	VectorSubtract(bestorigin, bs->eye, dir);
ADDRLP4 996
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 164
INDIRF4
ADDRLP4 996
INDIRP4
CNSTI4 4944
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 164+4
INDIRF4
ADDRLP4 996
INDIRP4
CNSTI4 4948
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 164+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4952
ADDP4
INDIRF4
SUBF4
ASGNF4
line 5900
;5879:	//
;5880:#if 0	// JUHOX: additional error no longer needed for instant-hit weapons
;5881:	if (wi.number == WP_MACHINEGUN ||
;5882:		wi.number == WP_SHOTGUN ||
;5883:		wi.number == WP_LIGHTNING ||
;5884:		wi.number == WP_RAILGUN) {
;5885:		//distance towards the enemy
;5886:		dist = VectorLength(dir);
;5887:		if (dist > 150) dist = 150;
;5888:		f = 0.6 + dist / 150 * 0.4;
;5889:		aim_accuracy *= f;
;5890:	}
;5891:#endif
;5892:#if 0	// JUHOX: no shaking
;5893:	//add some random stuff to the aim direction depending on the aim accuracy
;5894:	if (aim_accuracy < 0.8) {
;5895:		VectorNormalize(dir);
;5896:		for (i = 0; i < 3; i++) dir[i] += 0.3 * crandom() * (1 - aim_accuracy);
;5897:	}
;5898:#endif
;5899:	//set the ideal view angles
;5900:	vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 140
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 7852
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 5908
;5901:	//take the weapon spread into account for lower skilled bots
;5902:#if 0	// JUHOX: ignore spread
;5903:	bs->ideal_viewangles[PITCH] += 6 * wi.vspread * crandom() * (1 - aim_accuracy);
;5904:	bs->ideal_viewangles[PITCH] = AngleMod(bs->ideal_viewangles[PITCH]);
;5905:	bs->ideal_viewangles[YAW] += 6 * wi.hspread * crandom() * (1 - aim_accuracy);
;5906:	bs->ideal_viewangles[YAW] = AngleMod(bs->ideal_viewangles[YAW]);
;5907:#else
;5908:	bs->ideal_viewangles[PITCH] = AngleMod(bs->ideal_viewangles[PITCH]);
ADDRLP4 1000
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1000
INDIRP4
CNSTI4 7852
ADDP4
INDIRF4
ARGF4
ADDRLP4 1004
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 1000
INDIRP4
CNSTI4 7852
ADDP4
ADDRLP4 1004
INDIRF4
ASGNF4
line 5909
;5909:	bs->ideal_viewangles[YAW] = AngleMod(bs->ideal_viewangles[YAW]);
ADDRLP4 1008
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1008
INDIRP4
CNSTI4 7856
ADDP4
INDIRF4
ARGF4
ADDRLP4 1012
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 1008
INDIRP4
CNSTI4 7856
ADDP4
ADDRLP4 1012
INDIRF4
ASGNF4
line 5912
;5910:#endif
;5911:	//if the bots should be really challenging
;5912:	if (bot_challenge.integer) {
ADDRGP4 bot_challenge+12
INDIRI4
CNSTI4 0
EQI4 $2167
line 5914
;5913:		//if the bot is really accurate and has the enemy in view for some time
;5914:		if (aim_accuracy > 0.9 && bs->enemysight_time < FloatTime() - 1) {
ADDRLP4 176
INDIRF4
CNSTF4 1063675494
LEF4 $2170
ADDRFP4 0
INDIRP4
CNSTI4 7224
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
SUBF4
GEF4 $2170
line 5916
;5915:			//set the view angles directly
;5916:			if (bs->ideal_viewangles[PITCH] > 180) bs->ideal_viewangles[PITCH] -= 360;
ADDRFP4 0
INDIRP4
CNSTI4 7852
ADDP4
INDIRF4
CNSTF4 1127481344
LEF4 $2172
ADDRLP4 1016
ADDRFP4 0
INDIRP4
CNSTI4 7852
ADDP4
ASGNP4
ADDRLP4 1016
INDIRP4
ADDRLP4 1016
INDIRP4
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
LABELV $2172
line 5917
;5917:			VectorCopy(bs->ideal_viewangles, bs->viewangles);
ADDRLP4 1020
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1020
INDIRP4
CNSTI4 7840
ADDP4
ADDRLP4 1020
INDIRP4
CNSTI4 7852
ADDP4
INDIRB
ASGNB 12
line 5918
;5918:			trap_EA_View(bs->client, bs->viewangles);
ADDRLP4 1024
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1024
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 1024
INDIRP4
CNSTI4 7840
ADDP4
ARGP4
ADDRGP4 trap_EA_View
CALLV
pop
line 5919
;5919:		}
LABELV $2170
line 5920
;5920:	}
LABELV $2167
line 5921
;5921:}
LABELV $1904
endproc BotAimAtEnemy 1120 52
proc MayDamage 92 28
line 5931
;5922:
;5923:/*
;5924:============
;5925:JUHOX: MayDamage
;5926:
;5927:Returns qtrue if the inflictor may directly damage the target.
;5928:[derived from CanDamage()]
;5929:============
;5930:*/
;5931:static qboolean MayDamage (gentity_t* targ, vec3_t origin) {
line 5938
;5932:	vec3_t	dest;
;5933:	trace_t	tr;
;5934:	vec3_t	midpoint;
;5935:
;5936:	// use the midpoint of the bounds instead of the origin, because
;5937:	// bmodels may have their origin is 0,0,0
;5938:	VectorAdd (targ->r.absmin, targ->r.absmax, midpoint);
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 80
INDIRP4
CNSTI4 464
ADDP4
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 476
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 80
INDIRP4
CNSTI4 468
ADDP4
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 480
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 84
INDIRP4
CNSTI4 472
ADDP4
INDIRF4
ADDRLP4 84
INDIRP4
CNSTI4 484
ADDP4
INDIRF4
ADDF4
ASGNF4
line 5939
;5939:	VectorScale (midpoint, 0.5, midpoint);
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 5941
;5940:
;5941:	VectorCopy (midpoint, dest);
ADDRLP4 12
ADDRLP4 0
INDIRB
ASGNB 12
line 5942
;5942:	trap_Trace (&tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID);
ADDRLP4 24
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 88
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 5943
;5943:	if (tr.fraction == 1.0)
ADDRLP4 24+8
INDIRF4
CNSTF4 1065353216
NEF4 $2181
line 5944
;5944:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2174
JUMPV
LABELV $2181
line 5946
;5945:
;5946:	return qfalse;
CNSTI4 0
RETI4
LABELV $2174
endproc MayDamage 92 28
proc BotMayRadiusDamageTeamMate 4168 16
line 5956
;5947:}
;5948:
;5949:/*
;5950:============
;5951:JUHOX: BotMayRadiusDamageTeamMate
;5952:[derived from G_RadiusDamage()]
;5953:also returns qtrue if the bot would damage itself
;5954:============
;5955:*/
;5956:static qboolean BotMayRadiusDamageTeamMate(bot_state_t* bs, vec3_t origin, float radius) {
line 5965
;5957:	gentity_t	*ent;
;5958:	int			entityList[MAX_GENTITIES];
;5959:	int			numListedEntities;
;5960:	vec3_t		mins, maxs;
;5961:	vec3_t		v;
;5962:	int			i, e;
;5963:	team_t		team;
;5964:
;5965:	if (g_gametype.integer < GT_TEAM) return qfalse;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
GEI4 $2185
CNSTI4 0
RETI4
ADDRGP4 $2184
JUMPV
LABELV $2185
line 5966
;5966:	if (!g_friendlyFire.integer) return qfalse;
ADDRGP4 g_friendlyFire+12
INDIRI4
CNSTI4 0
NEI4 $2188
CNSTI4 0
RETI4
ADDRGP4 $2184
JUMPV
LABELV $2188
line 5968
;5967:
;5968:	if ( radius < 1 ) {
ADDRFP4 8
INDIRF4
CNSTF4 1065353216
GEF4 $2191
line 5969
;5969:		radius = 1;
ADDRFP4 8
CNSTF4 1065353216
ASGNF4
line 5970
;5970:	}
LABELV $2191
line 5972
;5971:
;5972:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2193
line 5973
;5973:		mins[i] = origin[i] - radius;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4124
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ADDRFP4 8
INDIRF4
SUBF4
ASGNF4
line 5974
;5974:		maxs[i] = origin[i] + radius;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4136
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ADDRFP4 8
INDIRF4
ADDF4
ASGNF4
line 5975
;5975:	}
LABELV $2194
line 5972
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $2193
line 5977
;5976:
;5977:	team = g_entities[bs->entitynum].client->sess.sessionTeam;
ADDRLP4 4148
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
ASGNI4
line 5979
;5978:
;5979:	numListedEntities = trap_EntitiesInBox(mins, maxs, entityList, MAX_GENTITIES);
ADDRLP4 4124
ARGP4
ADDRLP4 4136
ARGP4
ADDRLP4 24
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 4152
ADDRGP4 trap_EntitiesInBox
CALLI4
ASGNI4
ADDRLP4 4120
ADDRLP4 4152
INDIRI4
ASGNI4
line 5981
;5980:
;5981:	for (e = 0; e < numListedEntities; e++) {
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRGP4 $2201
JUMPV
LABELV $2198
line 5982
;5982:		ent = &g_entities[entityList[e]];
ADDRLP4 4
ADDRLP4 20
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 24
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 5984
;5983:
;5984:		if (!ent->takedamage) continue;
ADDRLP4 4
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2202
ADDRGP4 $2199
JUMPV
LABELV $2202
line 5985
;5985:		if (!ent->client) continue;
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2204
ADDRGP4 $2199
JUMPV
LABELV $2204
line 5986
;5986:		if (ent->client->sess.sessionTeam != team) continue;
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
ADDRLP4 4148
INDIRI4
EQI4 $2206
ADDRGP4 $2199
JUMPV
LABELV $2206
line 5987
;5987:		if (ent->client->ps.stats[STAT_HEALTH] <= 0) continue;
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $2208
ADDRGP4 $2199
JUMPV
LABELV $2208
line 5990
;5988:
;5989:		// find the distance from the edge of the bounding box
;5990:		for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2210
line 5991
;5991:			if (origin[i] < ent->r.absmin[i]) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 464
ADDP4
ADDP4
INDIRF4
GEF4 $2214
line 5992
;5992:				v[i] = ent->r.absmin[i] - origin[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 464
ADDP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 5993
;5993:			}
ADDRGP4 $2215
JUMPV
LABELV $2214
line 5994
;5994:			else if (origin[i] > ent->r.absmax[i]) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 476
ADDP4
ADDP4
INDIRF4
LEF4 $2216
line 5995
;5995:				v[i] = origin[i] - ent->r.absmax[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 476
ADDP4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 5996
;5996:			}
ADDRGP4 $2217
JUMPV
LABELV $2216
line 5997
;5997:			else {
line 5998
;5998:				v[i] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
CNSTF4 0
ASGNF4
line 5999
;5999:			}
LABELV $2217
LABELV $2215
line 6000
;6000:		}
LABELV $2211
line 5990
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $2210
line 6002
;6001:
;6002:		if (VectorLength(v) >= radius) continue;
ADDRLP4 8
ARGP4
ADDRLP4 4156
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 4156
INDIRF4
ADDRFP4 8
INDIRF4
LTF4 $2218
ADDRGP4 $2199
JUMPV
LABELV $2218
line 6004
;6003:
;6004:		if (!MayDamage(ent, origin)) continue;
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4160
ADDRGP4 MayDamage
CALLI4
ASGNI4
ADDRLP4 4160
INDIRI4
CNSTI4 0
NEI4 $2220
ADDRGP4 $2199
JUMPV
LABELV $2220
line 6006
;6005:
;6006:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2184
JUMPV
LABELV $2199
line 5981
ADDRLP4 20
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2201
ADDRLP4 20
INDIRI4
ADDRLP4 4120
INDIRI4
LTI4 $2198
line 6009
;6007:	}
;6008:
;6009:	return qfalse;
CNSTI4 0
RETI4
LABELV $2184
endproc BotMayRadiusDamageTeamMate 4168 16
data
align 4
LABELV $2223
byte 4 3238002688
byte 4 3238002688
byte 4 3238002688
align 4
LABELV $2224
byte 4 1090519040
byte 4 1090519040
byte 4 1090519040
export BotCheckAttack
code
proc BotCheckAttack 1056 28
line 6017
;6010:}
;6011:
;6012:/*
;6013:==================
;6014:BotCheckAttack
;6015:==================
;6016:*/
;6017:void BotCheckAttack(bot_state_t *bs) {
line 6026
;6018:	float /*points, */reactiontime, fov/*, firethrottle*/;	// JUHOX: points and firethrottle no longer needed
;6019:	int attackentity;
;6020:	bsp_trace_t bsptrace;
;6021:	//float selfpreservation;
;6022:	vec3_t forward, right, start, end, dir, angles;
;6023:	weaponinfo_t wi;
;6024:	bsp_trace_t trace;
;6025:	aas_entityinfo_t entinfo;
;6026:	vec3_t mins = {-8, -8, -8}, maxs = {8, 8, 8};
ADDRLP4 868
ADDRGP4 $2223
INDIRB
ASGNB 12
ADDRLP4 880
ADDRGP4 $2224
INDIRB
ASGNB 12
line 6030
;6027:	float prevLineOfFireBlockedTime;	// JUHOX
;6028:	float dist;	// JUHOX
;6029:
;6030:	if (bs->weaponnum <= WP_NONE) return;	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 7804
ADDP4
INDIRI4
CNSTI4 0
GTI4 $2225
ADDRGP4 $2222
JUMPV
LABELV $2225
line 6031
;6031:	reactiontime = 0.7 * bs->reactiontime;	// JUHOX
ADDRLP4 576
ADDRFP4 0
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
CNSTF4 1060320051
MULF4
ASGNF4
line 6033
;6032:#if 1	// JUHOX: prepare for reaction-time delay on changes of line-of-fire blocked / not blocked
;6033:	prevLineOfFireBlockedTime = bs->lineOfFireBlocked_time;
ADDRLP4 852
ADDRFP4 0
INDIRP4
CNSTI4 7424
ADDP4
INDIRF4
ASGNF4
line 6034
;6034:	bs->lineOfFireBlocked_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7424
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 6036
;6035:	if (
;6036:		bs->lineOfFireNotBlocked_time > FloatTime() - reactiontime
ADDRFP4 0
INDIRP4
CNSTI4 7428
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
ADDRLP4 576
INDIRF4
SUBF4
LEF4 $2227
line 6037
;6037:	) {
line 6038
;6038:		trap_EA_Attack(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Attack
CALLV
pop
line 6039
;6039:	}
LABELV $2227
line 6042
;6040:#endif
;6041:
;6042:	attackentity = bs->enemy;
ADDRLP4 596
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
ASGNI4
line 6043
;6043:	if (attackentity < 0) return;	// JUHOX
ADDRLP4 596
INDIRI4
CNSTI4 0
GEI4 $2229
ADDRGP4 $2222
JUMPV
LABELV $2229
line 6046
;6044:#if 1	// JUHOX: don't shoot with a back knocking weapon while flying
;6045:	if (
;6046:		bs->cur_ps.groundEntityNum == ENTITYNUM_NONE &&
ADDRLP4 976
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 976
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 1023
NEI4 $2231
ADDRLP4 976
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 1
EQI4 $2231
ADDRLP4 976
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 6
EQI4 $2231
ADDRLP4 976
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 8
EQI4 $2231
line 6050
;6047:		bs->cur_ps.weapon != WP_GAUNTLET &&
;6048:		bs->cur_ps.weapon != WP_LIGHTNING &&
;6049:		bs->cur_ps.weapon != WP_PLASMAGUN
;6050:	) {
line 6051
;6051:		return;
ADDRGP4 $2222
JUMPV
LABELV $2231
line 6055
;6052:	}
;6053:#endif
;6054:	//
;6055:	BotEntityInfo(attackentity, &entinfo);
ADDRLP4 596
INDIRI4
ARGI4
ADDRLP4 708
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 6057
;6056:	// if not attacking a player
;6057:	if (attackentity >= MAX_CLIENTS) {
ADDRLP4 596
INDIRI4
CNSTI4 64
LTI4 $2233
line 6069
;6058:#ifdef MISSIONPACK
;6059:		// if attacking an obelisk
;6060:		if ( entinfo.number == redobelisk.entitynum ||
;6061:			entinfo.number == blueobelisk.entitynum ) {
;6062:			// if obelisk is respawning return
;6063:			if ( g_entities[entinfo.number].activator &&
;6064:				g_entities[entinfo.number].activator->s.frame == 2 ) {
;6065:				return;
;6066:			}
;6067:		}
;6068:#endif
;6069:	}
LABELV $2233
line 6070
;6070:	if (entinfo.powerups & (1 << PW_SHIELD)) return;	// JUHOX
ADDRLP4 708+124
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $2235
ADDRGP4 $2222
JUMPV
LABELV $2235
line 6071
;6071:	if (EntityIsDead(&entinfo)) return;	// JUHOX
ADDRLP4 708
ARGP4
ADDRLP4 980
ADDRGP4 EntityIsDead
CALLI4
ASGNI4
ADDRLP4 980
INDIRI4
CNSTI4 0
EQI4 $2238
ADDRGP4 $2222
JUMPV
LABELV $2238
line 6077
;6072:	//
;6073:	//reactiontime = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_REACTIONTIME, 0, 1);	// JUHOX: done earlier
;6074:#if 0	// JUHOX: longer reaction time for the first shot
;6075:	if (bs->enemysight_time > FloatTime() - reactiontime) return;
;6076:#else
;6077:	if (bs->enemysight_time > FloatTime() - reactiontime) {
ADDRFP4 0
INDIRP4
CNSTI4 7224
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
ADDRLP4 576
INDIRF4
SUBF4
LEF4 $2240
line 6078
;6078:		bs->viewnotperfect_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7416
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 6079
;6079:		return;
ADDRGP4 $2222
JUMPV
LABELV $2240
line 6082
;6080:	}
;6081:#endif
;6082:	if (bs->teleport_time > FloatTime() - reactiontime) return;
ADDRFP4 0
INDIRP4
CNSTI4 7272
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
ADDRLP4 576
INDIRF4
SUBF4
LEF4 $2242
ADDRGP4 $2222
JUMPV
LABELV $2242
line 6103
;6083:#if 0	// JUHOX: don't stop firing while changing weapon
;6084:	//if changing weapons
;6085:	if (bs->weaponchange_time > FloatTime() - 0.1) return;
;6086:#endif
;6087:	//check fire throttle characteristic
;6088:#if 0	// JUHOX: do not check fire throttle characteristic
;6089:	if (bs->firethrottlewait_time > FloatTime()) return;
;6090:	firethrottle = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_FIRETHROTTLE, 0, 1);
;6091:	if (bs->firethrottleshoot_time < FloatTime()) {
;6092:		if (random() > firethrottle) {
;6093:			bs->firethrottlewait_time = FloatTime() + firethrottle;
;6094:			bs->firethrottleshoot_time = 0;
;6095:		}
;6096:		else {
;6097:			bs->firethrottleshoot_time = FloatTime() + 1 - firethrottle;
;6098:			bs->firethrottlewait_time = 0;
;6099:		}
;6100:	}
;6101:#endif
;6102:	//
;6103:	VectorSubtract(bs->aimtarget, bs->eye, dir);
ADDRLP4 984
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 584
ADDRLP4 984
INDIRP4
CNSTI4 7392
ADDP4
INDIRF4
ADDRLP4 984
INDIRP4
CNSTI4 4944
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 584+4
ADDRLP4 984
INDIRP4
CNSTI4 7396
ADDP4
INDIRF4
ADDRLP4 984
INDIRP4
CNSTI4 4948
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 988
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 584+8
ADDRLP4 988
INDIRP4
CNSTI4 7400
ADDP4
INDIRF4
ADDRLP4 988
INDIRP4
CNSTI4 4952
ADDP4
INDIRF4
SUBF4
ASGNF4
line 6113
;6104:	//
;6105:#if 0	// JUHOX: don't prevent early gauntlet attacks unless retreating
;6106:	if (bs->weaponnum == WP_GAUNTLET) {
;6107:		if (VectorLengthSquared(dir) > Square(60)) {
;6108:			return;
;6109:		}
;6110:	}
;6111:#else
;6112:	if (
;6113:		bs->weaponnum == WP_GAUNTLET &&
ADDRLP4 992
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 992
INDIRP4
CNSTI4 7804
ADDP4
INDIRI4
CNSTI4 1
NEI4 $2246
ADDRLP4 992
INDIRP4
ARGP4
ADDRLP4 996
ADDRGP4 BotWantsToRetreat
CALLI4
ASGNI4
ADDRLP4 996
INDIRI4
CNSTI4 0
EQI4 $2246
ADDRLP4 584
ARGP4
ADDRLP4 1000
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 1000
INDIRF4
CNSTF4 1163984896
LEF4 $2246
line 6116
;6114:		BotWantsToRetreat(bs) &&
;6115:		VectorLengthSquared(dir) > Square(60)
;6116:	) {
line 6117
;6117:		return;
ADDRGP4 $2222
JUMPV
LABELV $2246
line 6134
;6118:	}
;6119:#endif
;6120:	//
;6121:#if 0	// JUHOX: make sure that BotCheckAttack() doesn't aim better than BotAimAtEnemy()
;6122:	if (VectorLengthSquared(dir) < Square(100))
;6123:		fov = 120;
;6124:	else
;6125:		fov = 50;
;6126:	//
;6127:	vectoangles(dir, angles);
;6128:	if (!InFieldOfVision(bs->viewangles, fov, angles))
;6129:		return;
;6130:	BotAI_Trace(&bsptrace, bs->eye, NULL, NULL, bs->aimtarget, bs->client, CONTENTS_SOLID|CONTENTS_PLAYERCLIP);
;6131:	if (bsptrace.fraction < 1 && bsptrace.ent != attackentity)
;6132:		return;
;6133:#else
;6134:	if (bs->weaponnum == WP_MACHINEGUN && bs->cur_ps.weaponstate >= WEAPON_FIRING) goto Shoot;
ADDRLP4 1004
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1004
INDIRP4
CNSTI4 7804
ADDP4
INDIRI4
CNSTI4 2
NEI4 $2248
ADDRLP4 1004
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 3
LTI4 $2248
ADDRGP4 $2250
JUMPV
LABELV $2248
line 6135
;6135:	dist = VectorLength(dir);
ADDRLP4 584
ARGP4
ADDRLP4 1008
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 848
ADDRLP4 1008
INDIRF4
ASGNF4
line 6136
;6136:	if (dist < 100) fov = 120;
ADDRLP4 848
INDIRF4
CNSTF4 1120403456
GEF4 $2251
ADDRLP4 580
CNSTF4 1123024896
ASGNF4
ADDRGP4 $2252
JUMPV
LABELV $2251
line 6137
;6137:	else fov = 20 + 10000 / dist;
ADDRLP4 580
CNSTF4 1176256512
ADDRLP4 848
INDIRF4
DIVF4
CNSTF4 1101004800
ADDF4
ASGNF4
LABELV $2252
line 6138
;6138:	fov += 40 * (1 - trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_SKILL, 0, 1));
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 16
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 1012
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 580
ADDRLP4 580
INDIRF4
CNSTF4 1065353216
ADDRLP4 1012
INDIRF4
SUBF4
CNSTF4 1109393408
MULF4
ADDF4
ASGNF4
line 6139
;6139:	if (g_baseHealth.value > 1) {
ADDRGP4 g_baseHealth+8
INDIRF4
CNSTF4 1065353216
LEF4 $2253
line 6140
;6140:		fov += 40 * (1 - bs->cur_ps.stats[STAT_MAX_HEALTH] / g_baseHealth.value);
ADDRLP4 580
ADDRLP4 580
INDIRF4
CNSTF4 1065353216
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 g_baseHealth+8
INDIRF4
DIVF4
SUBF4
CNSTF4 1109393408
MULF4
ADDF4
ASGNF4
line 6141
;6141:	}
LABELV $2253
line 6143
;6142:	if (
;6143:		bs->weaponnum == WP_MACHINEGUN ||
ADDRLP4 1016
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1016
INDIRP4
CNSTI4 7804
ADDP4
INDIRI4
CNSTI4 2
EQI4 $2261
ADDRLP4 1016
INDIRP4
CNSTI4 7804
ADDP4
INDIRI4
CNSTI4 3
EQI4 $2261
ADDRLP4 1016
INDIRP4
CNSTI4 7804
ADDP4
INDIRI4
CNSTI4 4
EQI4 $2261
ADDRLP4 1016
INDIRP4
CNSTI4 7804
ADDP4
INDIRI4
CNSTI4 6
NEI4 $2257
LABELV $2261
line 6147
;6144:		bs->weaponnum == WP_SHOTGUN ||
;6145:		bs->weaponnum == WP_GRENADE_LAUNCHER ||
;6146:		bs->weaponnum == WP_LIGHTNING
;6147:	) {
line 6149
;6148:		// these weapons accept much inprecision
;6149:		fov += 90;
ADDRLP4 580
ADDRLP4 580
INDIRF4
CNSTF4 1119092736
ADDF4
ASGNF4
line 6150
;6150:	}
ADDRGP4 $2258
JUMPV
LABELV $2257
line 6152
;6151:	else if (
;6152:		bs->weaponnum == WP_ROCKET_LAUNCHER ||
ADDRLP4 1020
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1020
INDIRP4
CNSTI4 7804
ADDP4
INDIRI4
CNSTI4 5
EQI4 $2264
ADDRLP4 1020
INDIRP4
CNSTI4 7804
ADDP4
INDIRI4
CNSTI4 1
NEI4 $2262
LABELV $2264
line 6154
;6153:		bs->weaponnum == WP_GAUNTLET
;6154:	) {
line 6156
;6155:		// these weapons accept inprecision
;6156:		fov += 40;
ADDRLP4 580
ADDRLP4 580
INDIRF4
CNSTF4 1109393408
ADDF4
ASGNF4
line 6157
;6157:	}
ADDRGP4 $2263
JUMPV
LABELV $2262
line 6159
;6158:	else if (
;6159:		bs->weaponnum == WP_BFG
ADDRFP4 0
INDIRP4
CNSTI4 7804
ADDP4
INDIRI4
CNSTI4 9
NEI4 $2265
line 6160
;6160:	) {
line 6162
;6161:		// this weapon accepts only a bit inprecision (could be dangerous for ourself!)
;6162:		fov += 15;
ADDRLP4 580
ADDRLP4 580
INDIRF4
CNSTF4 1097859072
ADDF4
ASGNF4
line 6163
;6163:	}
LABELV $2265
LABELV $2263
LABELV $2258
line 6164
;6164:	fov *= 1.1 + 3*reactiontime;
ADDRLP4 580
ADDRLP4 580
INDIRF4
ADDRLP4 576
INDIRF4
CNSTF4 1077936128
MULF4
CNSTF4 1066192077
ADDF4
MULF4
ASGNF4
line 6165
;6165:	if (EntityIsInvisible(VIEWER_OTHERTEAM, &entinfo)) fov *= 2;
CNSTI4 -2
ARGI4
ADDRLP4 708
ARGP4
ADDRLP4 1024
ADDRGP4 EntityIsInvisible
CALLI4
ASGNI4
ADDRLP4 1024
INDIRI4
CNSTI4 0
EQI4 $2267
ADDRLP4 580
ADDRLP4 580
INDIRF4
CNSTF4 1073741824
MULF4
ASGNF4
LABELV $2267
line 6166
;6166:	vectoangles(dir, angles);
ADDRLP4 584
ARGP4
ADDRLP4 856
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 6167
;6167:	if (!InFieldOfVision(bs->viewangles, 0.25 * fov, angles)) bs->viewnotperfect_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7840
ADDP4
ARGP4
ADDRLP4 580
INDIRF4
CNSTF4 1048576000
MULF4
ARGF4
ADDRLP4 856
ARGP4
ADDRLP4 1028
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 0
NEI4 $2269
ADDRFP4 0
INDIRP4
CNSTI4 7416
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
LABELV $2269
line 6169
;6168:	if (
;6169:		bs->weaponnum == WP_RAILGUN &&
ADDRLP4 1032
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1032
INDIRP4
CNSTI4 7804
ADDP4
INDIRI4
CNSTI4 7
NEI4 $2271
ADDRLP4 1032
INDIRP4
CNSTI4 7416
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
ADDRLP4 576
INDIRF4
CNSTF4 1077936128
MULF4
SUBF4
GTF4 $2273
ADDRLP4 1032
INDIRP4
CNSTI4 7784
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2271
LABELV $2273
line 6174
;6170:		(
;6171:			bs->viewnotperfect_time > FloatTime() - 3 * reactiontime ||
;6172:			bs->lastEnemyAreaPredicted
;6173:		)
;6174:	) return;
ADDRGP4 $2222
JUMPV
LABELV $2271
line 6176
;6175:	if (
;6176:		bs->weaponnum == WP_LIGHTNING &&
ADDRLP4 1036
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1036
INDIRP4
CNSTI4 7804
ADDP4
INDIRI4
CNSTI4 6
NEI4 $2274
ADDRLP4 1036
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $2274
ADDRLP4 1036
INDIRP4
CNSTI4 224
ADDP4
INDIRI4
CNSTI4 0
LTI4 $2274
ADDRLP4 1036
INDIRP4
CNSTI4 224
ADDP4
INDIRI4
CNSTI4 1022
GEI4 $2274
ADDRLP4 1036
INDIRP4
ARGP4
ADDRLP4 1036
INDIRP4
CNSTI4 224
ADDP4
INDIRI4
ARGI4
ADDRLP4 1040
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $2274
line 6181
;6177:		(bs->cur_ps.eFlags & EF_FIRING) &&
;6178:		bs->cur_ps.stats[STAT_TARGET] >= 0 &&
;6179:		bs->cur_ps.stats[STAT_TARGET] < ENTITYNUM_MAX_NORMAL &&
;6180:		!BotSameTeam(bs, bs->cur_ps.stats[STAT_TARGET])
;6181:	) {
line 6183
;6182:		// do not release lightning gun while it has contact
;6183:		goto Shoot;
ADDRGP4 $2250
JUMPV
LABELV $2274
line 6185
;6184:	}
;6185:	if (!InFieldOfVision(bs->viewangles, fov, bs->viewhistory.real_viewangles)) return;
ADDRLP4 1044
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1044
INDIRP4
CNSTI4 7840
ADDP4
ARGP4
ADDRLP4 580
INDIRF4
ARGF4
ADDRLP4 1044
INDIRP4
CNSTI4 7876
ADDP4
ARGP4
ADDRLP4 1048
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $2276
ADDRGP4 $2222
JUMPV
LABELV $2276
line 6187
;6186:	//if (!InFieldOfVision(bs->viewangles, 90, angles)) return;
;6187:	if (dist > 100) {
ADDRLP4 848
INDIRF4
CNSTF4 1120403456
LEF4 $2278
line 6188
;6188:		BotAI_Trace(&bsptrace, bs->eye, NULL, NULL, bs->aimtarget, bs->client, CONTENTS_SOLID);
ADDRLP4 892
ARGP4
ADDRLP4 1052
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1052
INDIRP4
CNSTI4 4944
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 1052
INDIRP4
CNSTI4 7392
ADDP4
ARGP4
ADDRLP4 1052
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 6189
;6189:		if (bsptrace.fraction < 1) return;
ADDRLP4 892+8
INDIRF4
CNSTF4 1065353216
GEF4 $2280
ADDRGP4 $2222
JUMPV
LABELV $2280
line 6190
;6190:	}
LABELV $2278
LABELV $2250
line 6198
;6191:	Shoot:
;6192:#endif
;6193:
;6194:	//get the weapon info
;6195:#if 0	// JUHOX: weapon info for new weapons
;6196:	trap_BotGetWeaponInfo(bs->ws, bs->weaponnum, &wi);
;6197:#else
;6198:	{
line 6201
;6199:		int wp;
;6200:
;6201:		wp = bs->weaponnum;
ADDRLP4 1052
ADDRFP4 0
INDIRP4
CNSTI4 7804
ADDP4
INDIRI4
ASGNI4
line 6203
;6202:#if MONSTER_MODE
;6203:		if (wp == WP_MONSTER_LAUNCHER) wp = WP_GRENADE_LAUNCHER;
ADDRLP4 1052
INDIRI4
CNSTI4 11
NEI4 $2283
ADDRLP4 1052
CNSTI4 4
ASGNI4
LABELV $2283
line 6205
;6204:#endif
;6205:		trap_BotGetWeaponInfo(bs->ws, wp, &wi);
ADDRFP4 0
INDIRP4
CNSTI4 7760
ADDP4
INDIRI4
ARGI4
ADDRLP4 1052
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
ADDRGP4 trap_BotGetWeaponInfo
CALLV
pop
line 6206
;6206:	}
line 6209
;6207:#endif
;6208:#if 1	// JUHOX: correct some weapon info
;6209:	if (bs->weaponnum == WP_BFG) {
ADDRFP4 0
INDIRP4
CNSTI4 7804
ADDP4
INDIRI4
CNSTI4 9
NEI4 $2285
line 6210
;6210:		wi.proj.radius = 400;
ADDRLP4 12+344+172
CNSTF4 1137180672
ASGNF4
line 6211
;6211:		wi.speed = 1000;
ADDRLP4 12+272
CNSTF4 1148846080
ASGNF4
line 6212
;6212:	}
ADDRGP4 $2286
JUMPV
LABELV $2285
line 6213
;6213:	else if (bs->weaponnum == WP_PLASMAGUN) {
ADDRFP4 0
INDIRP4
CNSTI4 7804
ADDP4
INDIRI4
CNSTI4 8
NEI4 $2290
line 6214
;6214:		wi.proj.radius = 100;
ADDRLP4 12+344+172
CNSTF4 1120403456
ASGNF4
line 6215
;6215:	}
ADDRGP4 $2291
JUMPV
LABELV $2290
line 6216
;6216:	else if (bs->weaponnum == WP_GRAPPLING_HOOK) {
ADDRFP4 0
INDIRP4
CNSTI4 7804
ADDP4
INDIRI4
CNSTI4 10
NEI4 $2294
line 6217
;6217:		VectorCopy(vec3_origin, wi.offset);
ADDRLP4 12+292
ADDRGP4 vec3_origin
INDIRB
ASGNB 12
line 6218
;6218:		wi.proj.damagetype = 0;
ADDRLP4 12+344+180
CNSTI4 0
ASGNI4
line 6219
;6219:		wi.flags = 0;
ADDRLP4 12+176
CNSTI4 0
ASGNI4
line 6220
;6220:	}
LABELV $2294
LABELV $2291
LABELV $2286
line 6223
;6221:#endif
;6222:	//get the start point shooting from
;6223:	VectorCopy(bs->origin, start);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRB
ASGNB 12
line 6224
;6224:	start[2] += bs->cur_ps.viewheight;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 6225
;6225:	AngleVectors(bs->viewangles, forward, right, NULL);
ADDRFP4 0
INDIRP4
CNSTI4 7840
ADDP4
ARGP4
ADDRLP4 564
ARGP4
ADDRLP4 684
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 6226
;6226:	start[0] += forward[0] * wi.offset[0] + right[0] * wi.offset[1];
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 564
INDIRF4
ADDRLP4 12+292
INDIRF4
MULF4
ADDRLP4 684
INDIRF4
ADDRLP4 12+292+4
INDIRF4
MULF4
ADDF4
ADDF4
ASGNF4
line 6227
;6227:	start[1] += forward[1] * wi.offset[0] + right[1] * wi.offset[1];
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 564+4
INDIRF4
ADDRLP4 12+292
INDIRF4
MULF4
ADDRLP4 684+4
INDIRF4
ADDRLP4 12+292+4
INDIRF4
MULF4
ADDF4
ADDF4
ASGNF4
line 6228
;6228:	start[2] += forward[2] * wi.offset[0] + right[2] * wi.offset[1] + wi.offset[2];
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 564+8
INDIRF4
ADDRLP4 12+292
INDIRF4
MULF4
ADDRLP4 684+8
INDIRF4
ADDRLP4 12+292+4
INDIRF4
MULF4
ADDF4
ADDRLP4 12+292+8
INDIRF4
ADDF4
ADDF4
ASGNF4
line 6230
;6229:	//end point aiming at
;6230:	VectorMA(start, 1000, forward, end);
ADDRLP4 696
ADDRLP4 0
INDIRF4
ADDRLP4 564
INDIRF4
CNSTF4 1148846080
MULF4
ADDF4
ASGNF4
ADDRLP4 696+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 564+4
INDIRF4
CNSTF4 1148846080
MULF4
ADDF4
ASGNF4
ADDRLP4 696+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 564+8
INDIRF4
CNSTF4 1148846080
MULF4
ADDF4
ASGNF4
line 6232
;6231:	//a little back to make sure not inside a very close enemy
;6232:	VectorMA(start, -12, forward, start);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 564
INDIRF4
CNSTF4 3242196992
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 564+4
INDIRF4
CNSTF4 3242196992
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 564+8
INDIRF4
CNSTF4 3242196992
MULF4
ADDF4
ASGNF4
line 6233
;6233:	BotAI_Trace(&trace, start, mins, maxs, end, bs->entitynum, MASK_SHOT);
ADDRLP4 600
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 868
ARGP4
ADDRLP4 880
ARGP4
ADDRLP4 696
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 6235
;6234:	//if the entity is a client
;6235:	if (trace.ent /*>*/>= 0 && trace.ent /*<=*/< MAX_CLIENTS) {	// JUHOX BUGFIX
ADDRLP4 600+80
INDIRI4
CNSTI4 0
LTI4 $2330
ADDRLP4 600+80
INDIRI4
CNSTI4 64
GEI4 $2330
line 6236
;6236:		if (trace.ent != attackentity) {
ADDRLP4 600+80
INDIRI4
ADDRLP4 596
INDIRI4
EQI4 $2334
line 6238
;6237:			//if a teammate is hit
;6238:			if (BotSameTeam(bs, trace.ent))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 600+80
INDIRI4
ARGI4
ADDRLP4 1052
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 0
EQI4 $2337
line 6239
;6239:				return;
ADDRGP4 $2222
JUMPV
LABELV $2337
line 6240
;6240:		}
LABELV $2334
line 6241
;6241:	}
LABELV $2330
line 6257
;6242:#if 0	// JUHOX: enhanced radial damage check
;6243:	//if won't hit the enemy or not attacking a player (obelisk)
;6244:	if (trace.ent != attackentity || attackentity >= MAX_CLIENTS) {
;6245:		//if the projectile does radial damage
;6246:		if (wi.proj.damagetype & DAMAGETYPE_RADIAL) {
;6247:			if (trace.fraction * 1000 < wi.proj.radius) {
;6248:				points = (wi.proj.damage - 0.5 * trace.fraction * 1000) * 0.5;
;6249:				if (points > 0) {
;6250:					return;
;6251:				}
;6252:			}
;6253:			//FIXME: check if a teammate gets radial damage
;6254:		}
;6255:	}
;6256:#else
;6257:	if (wi.proj.damagetype & DAMAGETYPE_RADIAL){
ADDRLP4 12+344+180
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $2340
line 6258
;6258:		if (BotMayRadiusDamageTeamMate(bs, trace.endpos, wi.proj.radius)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 600+12
ARGP4
ADDRLP4 12+344+172
INDIRF4
ARGF4
ADDRLP4 1052
ADDRGP4 BotMayRadiusDamageTeamMate
CALLI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 0
EQI4 $2344
ADDRGP4 $2222
JUMPV
LABELV $2344
line 6259
;6259:	}
LABELV $2340
line 6262
;6260:#endif
;6261:#if 1	// JUHOX: handle reaction-time delay on changes of line-of-fire blocked / not blocked
;6262:	bs->lineOfFireBlocked_time = prevLineOfFireBlockedTime;
ADDRFP4 0
INDIRP4
CNSTI4 7424
ADDP4
ADDRLP4 852
INDIRF4
ASGNF4
line 6263
;6263:	if (prevLineOfFireBlockedTime > FloatTime() - reactiontime) return;
ADDRLP4 852
INDIRF4
ADDRGP4 floattime
INDIRF4
ADDRLP4 576
INDIRF4
SUBF4
LEF4 $2349
ADDRGP4 $2222
JUMPV
LABELV $2349
line 6264
;6264:	bs->lineOfFireNotBlocked_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7428
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 6267
;6265:#endif
;6266:	//if fire has to be release to activate weapon
;6267:	if (wi.flags & WFL_FIRERELEASED) {
ADDRLP4 12+176
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $2351
line 6268
;6268:		if (bs->flags & BFL_ATTACKED) {
ADDRFP4 0
INDIRP4
CNSTI4 5992
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $2352
line 6269
;6269:			trap_EA_Attack(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Attack
CALLV
pop
line 6270
;6270:		}
line 6271
;6271:	}
ADDRGP4 $2352
JUMPV
LABELV $2351
line 6272
;6272:	else {
line 6273
;6273:		trap_EA_Attack(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Attack
CALLV
pop
line 6274
;6274:	}
LABELV $2352
line 6275
;6275:	bs->flags ^= BFL_ATTACKED;
ADDRLP4 1052
ADDRFP4 0
INDIRP4
CNSTI4 5992
ADDP4
ASGNP4
ADDRLP4 1052
INDIRP4
ADDRLP4 1052
INDIRP4
INDIRI4
CNSTI4 2
BXORI4
ASGNI4
line 6276
;6276:}
LABELV $2222
endproc BotCheckAttack 1056 28
data
align 4
LABELV $2362
byte 4 1143930880
byte 4 1129054208
byte 4 1143472128
align 4
LABELV $2363
byte 4 1148256256
byte 4 1139408896
byte 4 1143603200
align 4
LABELV $2364
byte 4 1134034944
byte 4 1135607808
byte 4 1147535360
export BotMapScripts
code
proc BotMapScripts 1424 16
line 6283
;6277:
;6278:/*
;6279:==================
;6280:BotMapScripts
;6281:==================
;6282:*/
;6283:void BotMapScripts(bot_state_t *bs) {
line 6291
;6284:	char info[1024];
;6285:	char mapname[128];
;6286:	int i, shootbutton;
;6287:	float aim_accuracy;
;6288:	aas_entityinfo_t entinfo;
;6289:	vec3_t dir;
;6290:
;6291:	trap_GetServerinfo(info, sizeof(info));
ADDRLP4 272
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetServerinfo
CALLV
pop
line 6293
;6292:
;6293:	strncpy(mapname, Info_ValueForKey( info, "mapname" ), sizeof(mapname)-1);
ADDRLP4 272
ARGP4
ADDRGP4 $2357
ARGP4
ADDRLP4 1316
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 144
ARGP4
ADDRLP4 1316
INDIRP4
ARGP4
CNSTI4 127
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 6294
;6294:	mapname[sizeof(mapname)-1] = '\0';
ADDRLP4 144+127
CNSTI1 0
ASGNI1
line 6296
;6295:
;6296:	if (!Q_stricmp(mapname, "q3tourney6")) {
ADDRLP4 144
ARGP4
ADDRGP4 $2361
ARGP4
ADDRLP4 1320
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1320
INDIRI4
CNSTI4 0
NEI4 $2359
line 6297
;6297:		vec3_t mins = {700, 204, 672}, maxs = {964, 468, 680};
ADDRLP4 1324
ADDRGP4 $2362
INDIRB
ASGNB 12
ADDRLP4 1336
ADDRGP4 $2363
INDIRB
ASGNB 12
line 6298
;6298:		vec3_t buttonorg = {304, 352, 920};
ADDRLP4 1348
ADDRGP4 $2364
INDIRB
ASGNB 12
line 6300
;6299:		//NOTE: NEVER use the func_bobbing in q3tourney6
;6300:		bs->tfl &= ~TFL_FUNCBOB;
ADDRLP4 1360
ADDRFP4 0
INDIRP4
CNSTI4 5984
ADDP4
ASGNP4
ADDRLP4 1360
INDIRP4
ADDRLP4 1360
INDIRP4
INDIRI4
CNSTI4 -16777217
BANDI4
ASGNI4
line 6302
;6301:		//if the bot is below the bounding box
;6302:		if (bs->origin[0] > mins[0] && bs->origin[0] < maxs[0]) {
ADDRLP4 1364
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1364
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRLP4 1324
INDIRF4
LEF4 $2365
ADDRLP4 1364
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRLP4 1336
INDIRF4
GEF4 $2365
line 6303
;6303:			if (bs->origin[1] > mins[1] && bs->origin[1] < maxs[1]) {
ADDRLP4 1368
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1368
INDIRP4
CNSTI4 4920
ADDP4
INDIRF4
ADDRLP4 1324+4
INDIRF4
LEF4 $2367
ADDRLP4 1368
INDIRP4
CNSTI4 4920
ADDP4
INDIRF4
ADDRLP4 1336+4
INDIRF4
GEF4 $2367
line 6304
;6304:				if (bs->origin[2] < mins[2]) {
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRF4
ADDRLP4 1324+8
INDIRF4
GEF4 $2371
line 6305
;6305:					return;
ADDRGP4 $2356
JUMPV
LABELV $2371
line 6307
;6306:				}
;6307:			}
LABELV $2367
line 6308
;6308:		}
LABELV $2365
line 6309
;6309:		shootbutton = qfalse;
ADDRLP4 1296
CNSTI4 0
ASGNI4
line 6311
;6310:		//if an enemy is below this bounding box then shoot the button
;6311:		for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 140
CNSTI4 0
ASGNI4
ADDRGP4 $2377
JUMPV
LABELV $2374
line 6313
;6312:
;6313:			if (i == bs->client) continue;
ADDRLP4 140
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $2378
ADDRGP4 $2375
JUMPV
LABELV $2378
line 6315
;6314:			//
;6315:			BotEntityInfo(i, &entinfo);
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 6317
;6316:			//
;6317:			if (!entinfo.valid) continue;
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2380
ADDRGP4 $2375
JUMPV
LABELV $2380
line 6319
;6318:			//if the enemy isn't dead and the enemy isn't the bot self
;6319:			if (EntityIsDead(&entinfo) || entinfo.number == bs->entitynum) continue;
ADDRLP4 0
ARGP4
ADDRLP4 1368
ADDRGP4 EntityIsDead
CALLI4
ASGNI4
ADDRLP4 1368
INDIRI4
CNSTI4 0
NEI4 $2385
ADDRLP4 0+20
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
NEI4 $2382
LABELV $2385
ADDRGP4 $2375
JUMPV
LABELV $2382
line 6321
;6320:			//
;6321:			if (entinfo.origin[0] > mins[0] && entinfo.origin[0] < maxs[0]) {
ADDRLP4 0+24
INDIRF4
ADDRLP4 1324
INDIRF4
LEF4 $2386
ADDRLP4 0+24
INDIRF4
ADDRLP4 1336
INDIRF4
GEF4 $2386
line 6322
;6322:				if (entinfo.origin[1] > mins[1] && entinfo.origin[1] < maxs[1]) {
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 1324+4
INDIRF4
LEF4 $2390
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 1336+4
INDIRF4
GEF4 $2390
line 6323
;6323:					if (entinfo.origin[2] < mins[2]) {
ADDRLP4 0+24+8
INDIRF4
ADDRLP4 1324+8
INDIRF4
GEF4 $2398
line 6325
;6324:						//if there's a team mate below the crusher
;6325:						if (BotSameTeam(bs, i)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 1372
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1372
INDIRI4
CNSTI4 0
EQI4 $2403
line 6326
;6326:							shootbutton = qfalse;
ADDRLP4 1296
CNSTI4 0
ASGNI4
line 6327
;6327:							break;
ADDRGP4 $2376
JUMPV
LABELV $2403
line 6329
;6328:						}
;6329:						else {
line 6330
;6330:							shootbutton = qtrue;
ADDRLP4 1296
CNSTI4 1
ASGNI4
line 6331
;6331:						}
line 6332
;6332:					}
LABELV $2398
line 6333
;6333:				}
LABELV $2390
line 6334
;6334:			}
LABELV $2386
line 6335
;6335:		}
LABELV $2375
line 6311
ADDRLP4 140
ADDRLP4 140
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2377
ADDRLP4 140
INDIRI4
ADDRGP4 maxclients
INDIRI4
GEI4 $2405
ADDRLP4 140
INDIRI4
CNSTI4 64
LTI4 $2374
LABELV $2405
LABELV $2376
line 6336
;6336:		if (shootbutton) {
ADDRLP4 1296
INDIRI4
CNSTI4 0
EQI4 $2360
line 6337
;6337:			bs->flags |= BFL_IDEALVIEWSET;
ADDRLP4 1372
ADDRFP4 0
INDIRP4
CNSTI4 5992
ADDP4
ASGNP4
ADDRLP4 1372
INDIRP4
ADDRLP4 1372
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 6338
;6338:			VectorSubtract(buttonorg, bs->eye, dir);
ADDRLP4 1376
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1300
ADDRLP4 1348
INDIRF4
ADDRLP4 1376
INDIRP4
CNSTI4 4944
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 1300+4
ADDRLP4 1348+4
INDIRF4
ADDRLP4 1376
INDIRP4
CNSTI4 4948
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 1300+8
ADDRLP4 1348+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4952
ADDP4
INDIRF4
SUBF4
ASGNF4
line 6339
;6339:			vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 1300
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 7852
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 6340
;6340:			aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 7
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 1380
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 1312
ADDRLP4 1380
INDIRF4
ASGNF4
line 6341
;6341:			bs->ideal_viewangles[PITCH] += 8 * crandom() * (1 - aim_accuracy);
ADDRLP4 1384
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 1388
ADDRFP4 0
INDIRP4
CNSTI4 7852
ADDP4
ASGNP4
ADDRLP4 1388
INDIRP4
ADDRLP4 1388
INDIRP4
INDIRF4
ADDRLP4 1384
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 1384
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
CNSTF4 1090519040
MULF4
CNSTF4 1065353216
ADDRLP4 1312
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 6342
;6342:			bs->ideal_viewangles[PITCH] = AngleMod(bs->ideal_viewangles[PITCH]);
ADDRLP4 1392
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1392
INDIRP4
CNSTI4 7852
ADDP4
INDIRF4
ARGF4
ADDRLP4 1396
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 1392
INDIRP4
CNSTI4 7852
ADDP4
ADDRLP4 1396
INDIRF4
ASGNF4
line 6343
;6343:			bs->ideal_viewangles[YAW] += 8 * crandom() * (1 - aim_accuracy);
ADDRLP4 1400
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 1404
ADDRFP4 0
INDIRP4
CNSTI4 7856
ADDP4
ASGNP4
ADDRLP4 1404
INDIRP4
ADDRLP4 1404
INDIRP4
INDIRF4
ADDRLP4 1400
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 1400
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
CNSTF4 1090519040
MULF4
CNSTF4 1065353216
ADDRLP4 1312
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 6344
;6344:			bs->ideal_viewangles[YAW] = AngleMod(bs->ideal_viewangles[YAW]);
ADDRLP4 1408
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1408
INDIRP4
CNSTI4 7856
ADDP4
INDIRF4
ARGF4
ADDRLP4 1412
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 1408
INDIRP4
CNSTI4 7856
ADDP4
ADDRLP4 1412
INDIRF4
ASGNF4
line 6346
;6345:			//
;6346:			if (InFieldOfVision(bs->viewangles, 20, bs->ideal_viewangles)) {
ADDRLP4 1416
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1416
INDIRP4
CNSTI4 7840
ADDP4
ARGP4
CNSTF4 1101004800
ARGF4
ADDRLP4 1416
INDIRP4
CNSTI4 7852
ADDP4
ARGP4
ADDRLP4 1420
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 1420
INDIRI4
CNSTI4 0
EQI4 $2360
line 6347
;6347:				trap_EA_Attack(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Attack
CALLV
pop
line 6348
;6348:			}
line 6349
;6349:		}
line 6350
;6350:	}
ADDRGP4 $2360
JUMPV
LABELV $2359
line 6351
;6351:	else if (!Q_stricmp(mapname, "mpq3tourney6")) {
ADDRLP4 144
ARGP4
ADDRGP4 $2416
ARGP4
ADDRLP4 1324
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1324
INDIRI4
CNSTI4 0
NEI4 $2414
line 6353
;6352:		//NOTE: NEVER use the func_bobbing in mpq3tourney6
;6353:		bs->tfl &= ~TFL_FUNCBOB;
ADDRLP4 1328
ADDRFP4 0
INDIRP4
CNSTI4 5984
ADDP4
ASGNP4
ADDRLP4 1328
INDIRP4
ADDRLP4 1328
INDIRP4
INDIRI4
CNSTI4 -16777217
BANDI4
ASGNI4
line 6354
;6354:	}
LABELV $2414
LABELV $2360
line 6355
;6355:}
LABELV $2356
endproc BotMapScripts 1424 16
data
align 4
LABELV VEC_UP
byte 4 0
byte 4 3212836864
byte 4 0
align 4
LABELV MOVEDIR_UP
byte 4 0
byte 4 0
byte 4 1065353216
align 4
LABELV VEC_DOWN
byte 4 0
byte 4 3221225472
byte 4 0
align 4
LABELV MOVEDIR_DOWN
byte 4 0
byte 4 0
byte 4 3212836864
export BotSetMovedir
code
proc BotSetMovedir 8 16
line 6368
;6356:
;6357:/*
;6358:==================
;6359:BotSetMovedir
;6360:==================
;6361:*/
;6362:// bk001205 - made these static
;6363:static vec3_t VEC_UP		= {0, -1,  0};
;6364:static vec3_t MOVEDIR_UP	= {0,  0,  1};
;6365:static vec3_t VEC_DOWN		= {0, -2,  0};
;6366:static vec3_t MOVEDIR_DOWN	= {0,  0, -1};
;6367:
;6368:void BotSetMovedir(vec3_t angles, vec3_t movedir) {
line 6369
;6369:	if (VectorCompare(angles, VEC_UP)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 VEC_UP
ARGP4
ADDRLP4 0
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $2418
line 6370
;6370:		VectorCopy(MOVEDIR_UP, movedir);
ADDRFP4 4
INDIRP4
ADDRGP4 MOVEDIR_UP
INDIRB
ASGNB 12
line 6371
;6371:	}
ADDRGP4 $2419
JUMPV
LABELV $2418
line 6372
;6372:	else if (VectorCompare(angles, VEC_DOWN)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 VEC_DOWN
ARGP4
ADDRLP4 4
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $2420
line 6373
;6373:		VectorCopy(MOVEDIR_DOWN, movedir);
ADDRFP4 4
INDIRP4
ADDRGP4 MOVEDIR_DOWN
INDIRB
ASGNB 12
line 6374
;6374:	}
ADDRGP4 $2421
JUMPV
LABELV $2420
line 6375
;6375:	else {
line 6376
;6376:		AngleVectors(angles, movedir, NULL, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 6377
;6377:	}
LABELV $2421
LABELV $2419
line 6378
;6378:}
LABELV $2417
endproc BotSetMovedir 8 16
export BotModelMinsMaxs
proc BotModelMinsMaxs 40 0
line 6387
;6379:
;6380:/*
;6381:==================
;6382:BotModelMinsMaxs
;6383:
;6384:this is ugly
;6385:==================
;6386:*/
;6387:int BotModelMinsMaxs(int modelindex, int eType, int contents, vec3_t mins, vec3_t maxs) {
line 6391
;6388:	gentity_t *ent;
;6389:	int i;
;6390:
;6391:	ent = &g_entities[0];
ADDRLP4 0
ADDRGP4 g_entities
ASGNP4
line 6392
;6392:	for (i = 0; i < level.num_entities; i++, ent++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $2426
JUMPV
LABELV $2423
line 6393
;6393:		if ( !ent->inuse ) {
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2428
line 6394
;6394:			continue;
ADDRGP4 $2424
JUMPV
LABELV $2428
line 6396
;6395:		}
;6396:		if ( eType && ent->s.eType != eType) {
ADDRLP4 8
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $2430
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $2430
line 6397
;6397:			continue;
ADDRGP4 $2424
JUMPV
LABELV $2430
line 6399
;6398:		}
;6399:		if ( contents && ent->r.contents != contents) {
ADDRLP4 12
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $2432
ADDRLP4 0
INDIRP4
CNSTI4 460
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $2432
line 6400
;6400:			continue;
ADDRGP4 $2424
JUMPV
LABELV $2432
line 6402
;6401:		}
;6402:		if (ent->s.modelindex == modelindex) {
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $2434
line 6403
;6403:			if (mins)
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2436
line 6404
;6404:				VectorAdd(ent->r.currentOrigin, ent->r.mins, mins);
ADDRFP4 12
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRFP4 12
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 440
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 444
ADDP4
INDIRF4
ADDF4
ASGNF4
LABELV $2436
line 6405
;6405:			if (maxs)
ADDRFP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2438
line 6406
;6406:				VectorAdd(ent->r.currentOrigin, ent->r.maxs, maxs);
ADDRFP4 16
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 448
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 452
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
ADDF4
ASGNF4
LABELV $2438
line 6407
;6407:			return i;
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $2422
JUMPV
LABELV $2434
line 6409
;6408:		}
;6409:	}
LABELV $2424
line 6392
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 844
ADDP4
ASGNP4
LABELV $2426
ADDRLP4 4
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $2423
line 6410
;6410:	if (mins)
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2440
line 6411
;6411:		VectorClear(mins);
ADDRLP4 8
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 12
CNSTF4 0
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 8
INDIRP4
ADDRLP4 12
INDIRF4
ASGNF4
LABELV $2440
line 6412
;6412:	if (maxs)
ADDRFP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2442
line 6413
;6413:		VectorClear(maxs);
ADDRLP4 16
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 20
CNSTF4 0
ASGNF4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 20
INDIRF4
ASGNF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 20
INDIRF4
ASGNF4
ADDRLP4 16
INDIRP4
ADDRLP4 20
INDIRF4
ASGNF4
LABELV $2442
line 6414
;6414:	return 0;
CNSTI4 0
RETI4
LABELV $2422
endproc BotModelMinsMaxs 40 0
data
align 4
LABELV $2445
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
align 4
LABELV $2446
byte 4 3212836864
byte 4 3212836864
byte 4 3212836864
export BotFuncButtonActivateGoal
code
proc BotFuncButtonActivateGoal 640 28
line 6422
;6415:}
;6416:
;6417:/*
;6418:==================
;6419:BotFuncButtonGoal
;6420:==================
;6421:*/
;6422:int BotFuncButtonActivateGoal(bot_state_t *bs, int bspent, bot_activategoal_t *activategoal) {
line 6428
;6423:	int i, areas[10], numareas, modelindex, entitynum;
;6424:	char model[128];
;6425:	float lip, dist, health, angle;
;6426:	vec3_t size, start, end, mins, maxs, angles, points[10];
;6427:	vec3_t movedir, origin, goalorigin, bboxmins, bboxmaxs;
;6428:	vec3_t extramins = {1, 1, 1}, extramaxs = {-1, -1, -1};
ADDRLP4 304
ADDRGP4 $2445
INDIRB
ASGNB 12
ADDRLP4 316
ADDRGP4 $2446
INDIRB
ASGNB 12
line 6431
;6429:	bsp_trace_t bsptrace;
;6430:
;6431:	activategoal->shoot = qfalse;
ADDRFP4 8
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 0
ASGNI4
line 6432
;6432:	VectorClear(activategoal->target);
ADDRLP4 560
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 564
CNSTF4 0
ASGNF4
ADDRLP4 560
INDIRP4
CNSTI4 88
ADDP4
ADDRLP4 564
INDIRF4
ASGNF4
ADDRLP4 560
INDIRP4
CNSTI4 84
ADDP4
ADDRLP4 564
INDIRF4
ASGNF4
ADDRLP4 560
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 564
INDIRF4
ASGNF4
line 6434
;6433:	//create a bot goal towards the button
;6434:	trap_AAS_ValueForBSPEpairKey(bspent, "model", model, sizeof(model));
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $221
ARGP4
ADDRLP4 160
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
pop
line 6435
;6435:	if (!*model)
ADDRLP4 160
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $2447
line 6436
;6436:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2444
JUMPV
LABELV $2447
line 6437
;6437:	modelindex = atoi(model+1);
ADDRLP4 160+1
ARGP4
ADDRLP4 568
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 288
ADDRLP4 568
INDIRI4
ASGNI4
line 6438
;6438:	if (!modelindex)
ADDRLP4 288
INDIRI4
CNSTI4 0
NEI4 $2450
line 6439
;6439:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2444
JUMPV
LABELV $2450
line 6440
;6440:	VectorClear(angles);
ADDRLP4 572
CNSTF4 0
ASGNF4
ADDRLP4 96+8
ADDRLP4 572
INDIRF4
ASGNF4
ADDRLP4 96+4
ADDRLP4 572
INDIRF4
ASGNF4
ADDRLP4 96
ADDRLP4 572
INDIRF4
ASGNF4
line 6441
;6441:	entitynum = BotModelMinsMaxs(modelindex, ET_MOVER, 0, mins, maxs);
ADDRLP4 288
INDIRI4
ARGI4
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 72
ARGP4
ADDRLP4 84
ARGP4
ADDRLP4 576
ADDRGP4 BotModelMinsMaxs
CALLI4
ASGNI4
ADDRLP4 344
ADDRLP4 576
INDIRI4
ASGNI4
line 6443
;6442:	//get the lip of the button
;6443:	trap_AAS_FloatForBSPEpairKey(bspent, "lip", &lip);
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $2454
ARGP4
ADDRLP4 328
ARGP4
ADDRGP4 trap_AAS_FloatForBSPEpairKey
CALLI4
pop
line 6444
;6444:	if (!lip) lip = 4;
ADDRLP4 328
INDIRF4
CNSTF4 0
NEF4 $2455
ADDRLP4 328
CNSTF4 1082130432
ASGNF4
LABELV $2455
line 6446
;6445:	//get the move direction from the angle
;6446:	trap_AAS_FloatForBSPEpairKey(bspent, "angle", &angle);
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $2457
ARGP4
ADDRLP4 352
ARGP4
ADDRGP4 trap_AAS_FloatForBSPEpairKey
CALLI4
pop
line 6447
;6447:	VectorSet(angles, 0, angle, 0);
ADDRLP4 96
CNSTF4 0
ASGNF4
ADDRLP4 96+4
ADDRLP4 352
INDIRF4
ASGNF4
ADDRLP4 96+8
CNSTF4 0
ASGNF4
line 6448
;6448:	BotSetMovedir(angles, movedir);
ADDRLP4 96
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 BotSetMovedir
CALLV
pop
line 6450
;6449:	//button size
;6450:	VectorSubtract(maxs, mins, size);
ADDRLP4 112
ADDRLP4 84
INDIRF4
ADDRLP4 72
INDIRF4
SUBF4
ASGNF4
ADDRLP4 112+4
ADDRLP4 84+4
INDIRF4
ADDRLP4 72+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 112+8
ADDRLP4 84+8
INDIRF4
ADDRLP4 72+8
INDIRF4
SUBF4
ASGNF4
line 6452
;6451:	//button origin
;6452:	VectorAdd(mins, maxs, origin);
ADDRLP4 16
ADDRLP4 72
INDIRF4
ADDRLP4 84
INDIRF4
ADDF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 72+4
INDIRF4
ADDRLP4 84+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 16+8
ADDRLP4 72+8
INDIRF4
ADDRLP4 84+8
INDIRF4
ADDF4
ASGNF4
line 6453
;6453:	VectorScale(origin, 0.5, origin);
ADDRLP4 16
ADDRLP4 16
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 16+4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 16+8
ADDRLP4 16+8
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 6455
;6454:	//touch distance of the button
;6455:	dist = fabs(movedir[0]) * size[0] + fabs(movedir[1]) * size[1] + fabs(movedir[2]) * size[2];
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 580
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 4+4
INDIRF4
ARGF4
ADDRLP4 584
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 4+8
INDIRF4
ARGF4
ADDRLP4 588
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 580
INDIRF4
ADDRLP4 112
INDIRF4
MULF4
ADDRLP4 584
INDIRF4
ADDRLP4 112+4
INDIRF4
MULF4
ADDF4
ADDRLP4 588
INDIRF4
ADDRLP4 112+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 6456
;6456:	dist *= 0.5;
ADDRLP4 28
ADDRLP4 28
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 6458
;6457:	//
;6458:	trap_AAS_FloatForBSPEpairKey(bspent, "health", &health);
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $2480
ARGP4
ADDRLP4 348
ARGP4
ADDRGP4 trap_AAS_FloatForBSPEpairKey
CALLI4
pop
line 6460
;6459:	//if the button is shootable
;6460:	if (health) {
ADDRLP4 348
INDIRF4
CNSTF4 0
EQF4 $2481
line 6462
;6461:		//calculate the shoot target
;6462:		VectorMA(origin, -dist, movedir, goalorigin);
ADDRLP4 592
ADDRLP4 28
INDIRF4
NEGF4
ASGNF4
ADDRLP4 124
ADDRLP4 16
INDIRF4
ADDRLP4 4
INDIRF4
ADDRLP4 592
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 124+4
ADDRLP4 16+4
INDIRF4
ADDRLP4 4+4
INDIRF4
ADDRLP4 592
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 124+8
ADDRLP4 16+8
INDIRF4
ADDRLP4 4+8
INDIRF4
ADDRLP4 28
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 6464
;6463:		//
;6464:		VectorCopy(goalorigin, activategoal->target);
ADDRFP4 8
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 124
INDIRB
ASGNB 12
line 6465
;6465:		activategoal->shoot = qtrue;
ADDRFP4 8
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 1
ASGNI4
line 6467
;6466:		//
;6467:		BotAI_Trace(&bsptrace, bs->eye, NULL, NULL, goalorigin, bs->entitynum, MASK_SHOT);
ADDRLP4 356
ARGP4
ADDRLP4 596
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 596
INDIRP4
CNSTI4 4944
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 124
ARGP4
ADDRLP4 596
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 6469
;6468:		// if the button is visible from the current position
;6469:		if (bsptrace.fraction >= 1.0 || bsptrace.ent == entitynum) {
ADDRLP4 356+8
INDIRF4
CNSTF4 1065353216
GEF4 $2493
ADDRLP4 356+80
INDIRI4
ADDRLP4 344
INDIRI4
NEI4 $2489
LABELV $2493
line 6471
;6470:			//
;6471:			activategoal->goal.entitynum = entitynum; //NOTE: this is the entity number of the shootable button
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 344
INDIRI4
ASGNI4
line 6472
;6472:			activategoal->goal.number = 0;
ADDRFP4 8
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 6473
;6473:			activategoal->goal.flags = 0;
ADDRFP4 8
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 6474
;6474:			VectorCopy(bs->origin, activategoal->goal.origin);
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRB
ASGNB 12
line 6475
;6475:			activategoal->goal.areanum = bs->areanum;
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
ASGNI4
line 6476
;6476:			VectorSet(activategoal->goal.mins, -8, -8, -8);
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 3238002688
ASGNF4
line 6477
;6477:			VectorSet(activategoal->goal.maxs, 8, 8, 8);
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1090519040
ASGNF4
line 6479
;6478:			//
;6479:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2444
JUMPV
LABELV $2489
line 6481
;6480:		}
;6481:		else {
line 6484
;6482:			//create a goal from where the button is visible and shoot at the button from there
;6483:			//add bounding box size to the dist
;6484:			trap_AAS_PresenceTypeBoundingBox(PRESENCE_CROUCH, bboxmins, bboxmaxs);
CNSTI4 4
ARGI4
ADDRLP4 136
ARGP4
ADDRLP4 148
ARGP4
ADDRGP4 trap_AAS_PresenceTypeBoundingBox
CALLV
pop
line 6485
;6485:			for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2494
line 6486
;6486:				if (movedir[i] < 0) dist += fabs(movedir[i]) * fabs(bboxmaxs[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 0
GEF4 $2498
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 600
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 148
ADDP4
INDIRF4
ARGF4
ADDRLP4 604
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 28
INDIRF4
ADDRLP4 600
INDIRF4
ADDRLP4 604
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 $2499
JUMPV
LABELV $2498
line 6487
;6487:				else dist += fabs(movedir[i]) * fabs(bboxmins[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 608
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 136
ADDP4
INDIRF4
ARGF4
ADDRLP4 612
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 28
INDIRF4
ADDRLP4 608
INDIRF4
ADDRLP4 612
INDIRF4
MULF4
ADDF4
ASGNF4
LABELV $2499
line 6488
;6488:			}
LABELV $2495
line 6485
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $2494
line 6490
;6489:			//calculate the goal origin
;6490:			VectorMA(origin, -dist, movedir, goalorigin);
ADDRLP4 600
ADDRLP4 28
INDIRF4
NEGF4
ASGNF4
ADDRLP4 124
ADDRLP4 16
INDIRF4
ADDRLP4 4
INDIRF4
ADDRLP4 600
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 124+4
ADDRLP4 16+4
INDIRF4
ADDRLP4 4+4
INDIRF4
ADDRLP4 600
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 124+8
ADDRLP4 16+8
INDIRF4
ADDRLP4 4+8
INDIRF4
ADDRLP4 28
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 6492
;6491:			//
;6492:			VectorCopy(goalorigin, start);
ADDRLP4 292
ADDRLP4 124
INDIRB
ASGNB 12
line 6493
;6493:			start[2] += 24;
ADDRLP4 292+8
ADDRLP4 292+8
INDIRF4
CNSTF4 1103101952
ADDF4
ASGNF4
line 6494
;6494:			VectorCopy(start, end);
ADDRLP4 332
ADDRLP4 292
INDIRB
ASGNB 12
line 6495
;6495:			end[2] -= 512;
ADDRLP4 332+8
ADDRLP4 332+8
INDIRF4
CNSTF4 1140850688
SUBF4
ASGNF4
line 6496
;6496:			numareas = trap_AAS_TraceAreas(start, end, areas, points, 10);
ADDRLP4 292
ARGP4
ADDRLP4 332
ARGP4
ADDRLP4 32
ARGP4
ADDRLP4 440
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 604
ADDRGP4 trap_AAS_TraceAreas
CALLI4
ASGNI4
ADDRLP4 108
ADDRLP4 604
INDIRI4
ASGNI4
line 6498
;6497:			//
;6498:			for (i = numareas-1; i >= 0; i--) {
ADDRLP4 0
ADDRLP4 108
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRGP4 $2511
JUMPV
LABELV $2508
line 6499
;6499:				if (trap_AAS_AreaReachability(areas[i])) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
ADDP4
INDIRI4
ARGI4
ADDRLP4 608
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 608
INDIRI4
CNSTI4 0
EQI4 $2512
line 6500
;6500:					break;
ADDRGP4 $2510
JUMPV
LABELV $2512
line 6502
;6501:				}
;6502:			}
LABELV $2509
line 6498
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $2511
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $2508
LABELV $2510
line 6503
;6503:			if (i < 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $2514
line 6505
;6504:				// FIXME: trace forward and maybe in other directions to find a valid area
;6505:			}
LABELV $2514
line 6506
;6506:			if (i >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $2516
line 6508
;6507:				//
;6508:				VectorCopy(points[i], activategoal->goal.origin);
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 440
ADDP4
INDIRB
ASGNB 12
line 6509
;6509:				activategoal->goal.areanum = areas[i];
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
ADDP4
INDIRI4
ASGNI4
line 6510
;6510:				VectorSet(activategoal->goal.mins, 8, 8, 8);
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 1090519040
ASGNF4
line 6511
;6511:				VectorSet(activategoal->goal.maxs, -8, -8, -8);
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 3238002688
ASGNF4
line 6513
;6512:				//
;6513:				for (i = 0; i < 3; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2518
line 6514
;6514:				{
line 6515
;6515:					if (movedir[i] < 0) activategoal->goal.maxs[i] += fabs(movedir[i]) * fabs(extramaxs[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 0
GEF4 $2522
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 612
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 316
ADDP4
INDIRF4
ARGF4
ADDRLP4 616
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 620
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
ADDP4
ASGNP4
ADDRLP4 620
INDIRP4
ADDRLP4 620
INDIRP4
INDIRF4
ADDRLP4 612
INDIRF4
ADDRLP4 616
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 $2523
JUMPV
LABELV $2522
line 6516
;6516:					else activategoal->goal.mins[i] += fabs(movedir[i]) * fabs(extramins[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 628
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 304
ADDP4
INDIRF4
ARGF4
ADDRLP4 632
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 636
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
ADDP4
ASGNP4
ADDRLP4 636
INDIRP4
ADDRLP4 636
INDIRP4
INDIRF4
ADDRLP4 628
INDIRF4
ADDRLP4 632
INDIRF4
MULF4
ADDF4
ASGNF4
LABELV $2523
line 6517
;6517:				} //end for
LABELV $2519
line 6513
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $2518
line 6519
;6518:				//
;6519:				activategoal->goal.entitynum = entitynum;
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 344
INDIRI4
ASGNI4
line 6520
;6520:				activategoal->goal.number = 0;
ADDRFP4 8
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 6521
;6521:				activategoal->goal.flags = 0;
ADDRFP4 8
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 6522
;6522:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2444
JUMPV
LABELV $2516
line 6524
;6523:			}
;6524:		}
line 6525
;6525:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2444
JUMPV
LABELV $2481
line 6527
;6526:	}
;6527:	else {
line 6529
;6528:		//add bounding box size to the dist
;6529:		trap_AAS_PresenceTypeBoundingBox(PRESENCE_CROUCH, bboxmins, bboxmaxs);
CNSTI4 4
ARGI4
ADDRLP4 136
ARGP4
ADDRLP4 148
ARGP4
ADDRGP4 trap_AAS_PresenceTypeBoundingBox
CALLV
pop
line 6530
;6530:		for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2524
line 6531
;6531:			if (movedir[i] < 0) dist += fabs(movedir[i]) * fabs(bboxmaxs[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 0
GEF4 $2528
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 592
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 148
ADDP4
INDIRF4
ARGF4
ADDRLP4 596
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 28
INDIRF4
ADDRLP4 592
INDIRF4
ADDRLP4 596
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 $2529
JUMPV
LABELV $2528
line 6532
;6532:			else dist += fabs(movedir[i]) * fabs(bboxmins[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 600
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 136
ADDP4
INDIRF4
ARGF4
ADDRLP4 604
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 28
INDIRF4
ADDRLP4 600
INDIRF4
ADDRLP4 604
INDIRF4
MULF4
ADDF4
ASGNF4
LABELV $2529
line 6533
;6533:		}
LABELV $2525
line 6530
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $2524
line 6535
;6534:		//calculate the goal origin
;6535:		VectorMA(origin, -dist, movedir, goalorigin);
ADDRLP4 592
ADDRLP4 28
INDIRF4
NEGF4
ASGNF4
ADDRLP4 124
ADDRLP4 16
INDIRF4
ADDRLP4 4
INDIRF4
ADDRLP4 592
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 124+4
ADDRLP4 16+4
INDIRF4
ADDRLP4 4+4
INDIRF4
ADDRLP4 592
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 124+8
ADDRLP4 16+8
INDIRF4
ADDRLP4 4+8
INDIRF4
ADDRLP4 28
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 6537
;6536:		//
;6537:		VectorCopy(goalorigin, start);
ADDRLP4 292
ADDRLP4 124
INDIRB
ASGNB 12
line 6538
;6538:		start[2] += 24;
ADDRLP4 292+8
ADDRLP4 292+8
INDIRF4
CNSTF4 1103101952
ADDF4
ASGNF4
line 6539
;6539:		VectorCopy(start, end);
ADDRLP4 332
ADDRLP4 292
INDIRB
ASGNB 12
line 6540
;6540:		end[2] -= 100;
ADDRLP4 332+8
ADDRLP4 332+8
INDIRF4
CNSTF4 1120403456
SUBF4
ASGNF4
line 6541
;6541:		numareas = trap_AAS_TraceAreas(start, end, areas, NULL, 10);
ADDRLP4 292
ARGP4
ADDRLP4 332
ARGP4
ADDRLP4 32
ARGP4
CNSTP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 596
ADDRGP4 trap_AAS_TraceAreas
CALLI4
ASGNI4
ADDRLP4 108
ADDRLP4 596
INDIRI4
ASGNI4
line 6543
;6542:		//
;6543:		for (i = 0; i < numareas; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2541
JUMPV
LABELV $2538
line 6544
;6544:			if (trap_AAS_AreaReachability(areas[i])) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
ADDP4
INDIRI4
ARGI4
ADDRLP4 600
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 600
INDIRI4
CNSTI4 0
EQI4 $2542
line 6545
;6545:				break;
ADDRGP4 $2540
JUMPV
LABELV $2542
line 6547
;6546:			}
;6547:		}
LABELV $2539
line 6543
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2541
ADDRLP4 0
INDIRI4
ADDRLP4 108
INDIRI4
LTI4 $2538
LABELV $2540
line 6548
;6548:		if (i < numareas) {
ADDRLP4 0
INDIRI4
ADDRLP4 108
INDIRI4
GEI4 $2544
line 6550
;6549:			//
;6550:			VectorCopy(origin, activategoal->goal.origin);
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 16
INDIRB
ASGNB 12
line 6551
;6551:			activategoal->goal.areanum = areas[i];
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
ADDP4
INDIRI4
ASGNI4
line 6552
;6552:			VectorSubtract(mins, origin, activategoal->goal.mins);
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 72
INDIRF4
ADDRLP4 16
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 72+4
INDIRF4
ADDRLP4 16+4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 72+8
INDIRF4
ADDRLP4 16+8
INDIRF4
SUBF4
ASGNF4
line 6553
;6553:			VectorSubtract(maxs, origin, activategoal->goal.maxs);
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 84
INDIRF4
ADDRLP4 16
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 84+4
INDIRF4
ADDRLP4 16+4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 84+8
INDIRF4
ADDRLP4 16+8
INDIRF4
SUBF4
ASGNF4
line 6555
;6554:			//
;6555:			for (i = 0; i < 3; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2554
line 6556
;6556:			{
line 6557
;6557:				if (movedir[i] < 0) activategoal->goal.maxs[i] += fabs(movedir[i]) * fabs(extramaxs[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 0
GEF4 $2558
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 604
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 316
ADDP4
INDIRF4
ARGF4
ADDRLP4 608
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 612
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
ADDP4
ASGNP4
ADDRLP4 612
INDIRP4
ADDRLP4 612
INDIRP4
INDIRF4
ADDRLP4 604
INDIRF4
ADDRLP4 608
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 $2559
JUMPV
LABELV $2558
line 6558
;6558:				else activategoal->goal.mins[i] += fabs(movedir[i]) * fabs(extramins[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 620
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 304
ADDP4
INDIRF4
ARGF4
ADDRLP4 624
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 628
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
ADDP4
ASGNP4
ADDRLP4 628
INDIRP4
ADDRLP4 628
INDIRP4
INDIRF4
ADDRLP4 620
INDIRF4
ADDRLP4 624
INDIRF4
MULF4
ADDF4
ASGNF4
LABELV $2559
line 6559
;6559:			} //end for
LABELV $2555
line 6555
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $2554
line 6561
;6560:			//
;6561:			activategoal->goal.entitynum = entitynum;
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 344
INDIRI4
ASGNI4
line 6562
;6562:			activategoal->goal.number = 0;
ADDRFP4 8
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 6563
;6563:			activategoal->goal.flags = 0;
ADDRFP4 8
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 6564
;6564:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2444
JUMPV
LABELV $2544
line 6566
;6565:		}
;6566:	}
line 6567
;6567:	return qfalse;
CNSTI4 0
RETI4
LABELV $2444
endproc BotFuncButtonActivateGoal 640 28
export BotFuncDoorActivateGoal
proc BotFuncDoorActivateGoal 1092 20
line 6575
;6568:}
;6569:
;6570:/*
;6571:==================
;6572:BotFuncDoorGoal
;6573:==================
;6574:*/
;6575:int BotFuncDoorActivateGoal(bot_state_t *bs, int bspent, bot_activategoal_t *activategoal) {
line 6581
;6576:	int modelindex, entitynum;
;6577:	char model[MAX_INFO_STRING];
;6578:	vec3_t mins, maxs, origin, angles;
;6579:
;6580:	//shoot at the shootable door
;6581:	trap_AAS_ValueForBSPEpairKey(bspent, "model", model, sizeof(model));
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $221
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
pop
line 6582
;6582:	if (!*model)
ADDRLP4 12
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $2561
line 6583
;6583:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2560
JUMPV
LABELV $2561
line 6584
;6584:	modelindex = atoi(model+1);
ADDRLP4 12+1
ARGP4
ADDRLP4 1080
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1060
ADDRLP4 1080
INDIRI4
ASGNI4
line 6585
;6585:	if (!modelindex)
ADDRLP4 1060
INDIRI4
CNSTI4 0
NEI4 $2564
line 6586
;6586:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2560
JUMPV
LABELV $2564
line 6587
;6587:	VectorClear(angles);
ADDRLP4 1084
CNSTF4 0
ASGNF4
ADDRLP4 1064+8
ADDRLP4 1084
INDIRF4
ASGNF4
ADDRLP4 1064+4
ADDRLP4 1084
INDIRF4
ASGNF4
ADDRLP4 1064
ADDRLP4 1084
INDIRF4
ASGNF4
line 6588
;6588:	entitynum = BotModelMinsMaxs(modelindex, ET_MOVER, 0, mins, maxs);
ADDRLP4 1060
INDIRI4
ARGI4
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 1036
ARGP4
ADDRLP4 1048
ARGP4
ADDRLP4 1088
ADDRGP4 BotModelMinsMaxs
CALLI4
ASGNI4
ADDRLP4 1076
ADDRLP4 1088
INDIRI4
ASGNI4
line 6590
;6589:	//door origin
;6590:	VectorAdd(mins, maxs, origin);
ADDRLP4 0
ADDRLP4 1036
INDIRF4
ADDRLP4 1048
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 1036+4
INDIRF4
ADDRLP4 1048+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 1036+8
INDIRF4
ADDRLP4 1048+8
INDIRF4
ADDF4
ASGNF4
line 6591
;6591:	VectorScale(origin, 0.5, origin);
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 6592
;6592:	VectorCopy(origin, activategoal->target);
ADDRFP4 8
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 0
INDIRB
ASGNB 12
line 6593
;6593:	activategoal->shoot = qtrue;
ADDRFP4 8
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 1
ASGNI4
line 6595
;6594:	//
;6595:	activategoal->goal.entitynum = entitynum; //NOTE: this is the entity number of the shootable door
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 1076
INDIRI4
ASGNI4
line 6596
;6596:	activategoal->goal.number = 0;
ADDRFP4 8
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 6597
;6597:	activategoal->goal.flags = 0;
ADDRFP4 8
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 6598
;6598:	VectorCopy(bs->origin, activategoal->goal.origin);
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRB
ASGNB 12
line 6599
;6599:	activategoal->goal.areanum = bs->areanum;
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
ASGNI4
line 6600
;6600:	VectorSet(activategoal->goal.mins, -8, -8, -8);
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 3238002688
ASGNF4
line 6601
;6601:	VectorSet(activategoal->goal.maxs, 8, 8, 8);
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1090519040
ASGNF4
line 6602
;6602:	return qtrue;
CNSTI4 1
RETI4
LABELV $2560
endproc BotFuncDoorActivateGoal 1092 20
export BotTriggerMultipleActivateGoal
proc BotTriggerMultipleActivateGoal 296 20
line 6610
;6603:}
;6604:
;6605:/*
;6606:==================
;6607:BotTriggerMultipleGoal
;6608:==================
;6609:*/
;6610:int BotTriggerMultipleActivateGoal(bot_state_t *bs, int bspent, bot_activategoal_t *activategoal) {
line 6616
;6611:	int i, areas[10], numareas, modelindex, entitynum;
;6612:	char model[128];
;6613:	vec3_t start, end, mins, maxs, angles;
;6614:	vec3_t origin, goalorigin;
;6615:
;6616:	activategoal->shoot = qfalse;
ADDRFP4 8
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 0
ASGNI4
line 6617
;6617:	VectorClear(activategoal->target);
ADDRLP4 268
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 272
CNSTF4 0
ASGNF4
ADDRLP4 268
INDIRP4
CNSTI4 88
ADDP4
ADDRLP4 272
INDIRF4
ASGNF4
ADDRLP4 268
INDIRP4
CNSTI4 84
ADDP4
ADDRLP4 272
INDIRF4
ASGNF4
ADDRLP4 268
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 272
INDIRF4
ASGNF4
line 6619
;6618:	//create a bot goal towards the trigger
;6619:	trap_AAS_ValueForBSPEpairKey(bspent, "model", model, sizeof(model));
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $221
ARGP4
ADDRLP4 84
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
pop
line 6620
;6620:	if (!*model)
ADDRLP4 84
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $2579
line 6621
;6621:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2578
JUMPV
LABELV $2579
line 6622
;6622:	modelindex = atoi(model+1);
ADDRLP4 84+1
ARGP4
ADDRLP4 276
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 224
ADDRLP4 276
INDIRI4
ASGNI4
line 6623
;6623:	if (!modelindex)
ADDRLP4 224
INDIRI4
CNSTI4 0
NEI4 $2582
line 6624
;6624:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2578
JUMPV
LABELV $2582
line 6625
;6625:	VectorClear(angles);
ADDRLP4 280
CNSTF4 0
ASGNF4
ADDRLP4 240+8
ADDRLP4 280
INDIRF4
ASGNF4
ADDRLP4 240+4
ADDRLP4 280
INDIRF4
ASGNF4
ADDRLP4 240
ADDRLP4 280
INDIRF4
ASGNF4
line 6626
;6626:	entitynum = BotModelMinsMaxs(modelindex, 0, CONTENTS_TRIGGER, mins, maxs);
ADDRLP4 224
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1073741824
ARGI4
ADDRLP4 60
ARGP4
ADDRLP4 72
ARGP4
ADDRLP4 284
ADDRGP4 BotModelMinsMaxs
CALLI4
ASGNI4
ADDRLP4 264
ADDRLP4 284
INDIRI4
ASGNI4
line 6628
;6627:	//trigger origin
;6628:	VectorAdd(mins, maxs, origin);
ADDRLP4 4
ADDRLP4 60
INDIRF4
ADDRLP4 72
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 60+4
INDIRF4
ADDRLP4 72+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 60+8
INDIRF4
ADDRLP4 72+8
INDIRF4
ADDF4
ASGNF4
line 6629
;6629:	VectorScale(origin, 0.5, origin);
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 4+4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 6630
;6630:	VectorCopy(origin, goalorigin);
ADDRLP4 252
ADDRLP4 4
INDIRB
ASGNB 12
line 6632
;6631:	//
;6632:	VectorCopy(goalorigin, start);
ADDRLP4 212
ADDRLP4 252
INDIRB
ASGNB 12
line 6633
;6633:	start[2] += 24;
ADDRLP4 212+8
ADDRLP4 212+8
INDIRF4
CNSTF4 1103101952
ADDF4
ASGNF4
line 6634
;6634:	VectorCopy(start, end);
ADDRLP4 228
ADDRLP4 212
INDIRB
ASGNB 12
line 6635
;6635:	end[2] -= 100;
ADDRLP4 228+8
ADDRLP4 228+8
INDIRF4
CNSTF4 1120403456
SUBF4
ASGNF4
line 6636
;6636:	numareas = trap_AAS_TraceAreas(start, end, areas, NULL, 10);
ADDRLP4 212
ARGP4
ADDRLP4 228
ARGP4
ADDRLP4 20
ARGP4
CNSTP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 288
ADDRGP4 trap_AAS_TraceAreas
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 288
INDIRI4
ASGNI4
line 6638
;6637:	//
;6638:	for (i = 0; i < numareas; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2601
JUMPV
LABELV $2598
line 6639
;6639:		if (trap_AAS_AreaReachability(areas[i])) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 292
INDIRI4
CNSTI4 0
EQI4 $2602
line 6640
;6640:			break;
ADDRGP4 $2600
JUMPV
LABELV $2602
line 6642
;6641:		}
;6642:	}
LABELV $2599
line 6638
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2601
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRI4
LTI4 $2598
LABELV $2600
line 6643
;6643:	if (i < numareas) {
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRI4
GEI4 $2604
line 6644
;6644:		VectorCopy(origin, activategoal->goal.origin);
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 4
INDIRB
ASGNB 12
line 6645
;6645:		activategoal->goal.areanum = areas[i];
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
ADDP4
INDIRI4
ASGNI4
line 6646
;6646:		VectorSubtract(mins, origin, activategoal->goal.mins);
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 60
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 60+4
INDIRF4
ADDRLP4 4+4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 60+8
INDIRF4
ADDRLP4 4+8
INDIRF4
SUBF4
ASGNF4
line 6647
;6647:		VectorSubtract(maxs, origin, activategoal->goal.maxs);
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 72
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 72+4
INDIRF4
ADDRLP4 4+4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 72+8
INDIRF4
ADDRLP4 4+8
INDIRF4
SUBF4
ASGNF4
line 6649
;6648:		//
;6649:		activategoal->goal.entitynum = entitynum;
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 264
INDIRI4
ASGNI4
line 6650
;6650:		activategoal->goal.number = 0;
ADDRFP4 8
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 6651
;6651:		activategoal->goal.flags = 0;
ADDRFP4 8
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 6652
;6652:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2578
JUMPV
LABELV $2604
line 6654
;6653:	}
;6654:	return qfalse;
CNSTI4 0
RETI4
LABELV $2578
endproc BotTriggerMultipleActivateGoal 296 20
export BotPopFromActivateGoalStack
proc BotPopFromActivateGoalStack 4 8
line 6662
;6655:}
;6656:
;6657:/*
;6658:==================
;6659:BotPopFromActivateGoalStack
;6660:==================
;6661:*/
;6662:int BotPopFromActivateGoalStack(bot_state_t *bs) {
line 6663
;6663:	if (!bs->activatestack)
ADDRFP4 0
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2615
line 6664
;6664:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2614
JUMPV
LABELV $2615
line 6665
;6665:	BotEnableActivateGoalAreas(bs->activatestack, qtrue);
ADDRFP4 0
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BotEnableActivateGoalAreas
CALLV
pop
line 6666
;6666:	bs->activatestack->inuse = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CNSTI4 0
ASGNI4
line 6667
;6667:	bs->activatestack->justused_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CNSTI4 68
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 6668
;6668:	bs->activatestack = bs->activatestack->next;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 12448
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ASGNP4
line 6669
;6669:	return qtrue;
CNSTI4 1
RETI4
LABELV $2614
endproc BotPopFromActivateGoalStack 4 8
export BotPushOntoActivateGoalStack
proc BotPushOntoActivateGoalStack 20 12
line 6677
;6670:}
;6671:
;6672:/*
;6673:==================
;6674:BotPushOntoActivateGoalStack
;6675:==================
;6676:*/
;6677:int BotPushOntoActivateGoalStack(bot_state_t *bs, bot_activategoal_t *activategoal) {
line 6681
;6678:	int i, best;
;6679:	float besttime;
;6680:
;6681:	best = -1;
ADDRLP4 8
CNSTI4 -1
ASGNI4
line 6682
;6682:	besttime = FloatTime() + 9999;
ADDRLP4 4
ADDRGP4 floattime
INDIRF4
CNSTF4 1176255488
ADDF4
ASGNF4
line 6684
;6683:	//
;6684:	for (i = 0; i < MAX_ACTIVATESTACK; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2618
line 6685
;6685:		if (!bs->activategoalheap[i].inuse) {
ADDRLP4 0
INDIRI4
CNSTI4 244
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 12452
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2622
line 6686
;6686:			if (bs->activategoalheap[i].justused_time < besttime) {
ADDRLP4 0
INDIRI4
CNSTI4 244
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 12452
ADDP4
ADDP4
CNSTI4 68
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
GEF4 $2624
line 6687
;6687:				besttime = bs->activategoalheap[i].justused_time;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 244
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 12452
ADDP4
ADDP4
CNSTI4 68
ADDP4
INDIRF4
ASGNF4
line 6688
;6688:				best = i;
ADDRLP4 8
ADDRLP4 0
INDIRI4
ASGNI4
line 6689
;6689:			}
LABELV $2624
line 6690
;6690:		}
LABELV $2622
line 6691
;6691:	}
LABELV $2619
line 6684
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 8
LTI4 $2618
line 6692
;6692:	if (best != -1) {
ADDRLP4 8
INDIRI4
CNSTI4 -1
EQI4 $2626
line 6693
;6693:		memcpy(&bs->activategoalheap[best], activategoal, sizeof(bot_activategoal_t));
ADDRLP4 8
INDIRI4
CNSTI4 244
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 12452
ADDP4
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 244
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 6694
;6694:		bs->activategoalheap[best].inuse = qtrue;
ADDRLP4 8
INDIRI4
CNSTI4 244
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 12452
ADDP4
ADDP4
CNSTI4 1
ASGNI4
line 6695
;6695:		bs->activategoalheap[best].next = bs->activatestack;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRI4
CNSTI4 244
MULI4
ADDRLP4 12
INDIRP4
CNSTI4 12452
ADDP4
ADDP4
CNSTI4 240
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
ASGNP4
line 6696
;6696:		bs->activatestack = &bs->activategoalheap[best];
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 12448
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 244
MULI4
ADDRLP4 16
INDIRP4
CNSTI4 12452
ADDP4
ADDP4
ASGNP4
line 6697
;6697:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2617
JUMPV
LABELV $2626
line 6699
;6698:	}
;6699:	return qfalse;
CNSTI4 0
RETI4
LABELV $2617
endproc BotPushOntoActivateGoalStack 20 12
export BotClearActivateGoalStack
proc BotClearActivateGoalStack 0 4
line 6707
;6700:}
;6701:
;6702:/*
;6703:==================
;6704:BotClearActivateGoalStack
;6705:==================
;6706:*/
;6707:void BotClearActivateGoalStack(bot_state_t *bs) {
ADDRGP4 $2630
JUMPV
LABELV $2629
line 6709
;6708:	while(bs->activatestack)
;6709:		BotPopFromActivateGoalStack(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotPopFromActivateGoalStack
CALLI4
pop
LABELV $2630
line 6708
ADDRFP4 0
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2629
line 6710
;6710:}
LABELV $2628
endproc BotClearActivateGoalStack 0 4
export BotEnableActivateGoalAreas
proc BotEnableActivateGoalAreas 12 8
line 6717
;6711:
;6712:/*
;6713:==================
;6714:BotEnableActivateGoalAreas
;6715:==================
;6716:*/
;6717:void BotEnableActivateGoalAreas(bot_activategoal_t *activategoal, int enable) {
line 6720
;6718:	int i;
;6719:
;6720:	if (activategoal->areasdisabled == !enable)
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $2636
ADDRLP4 4
CNSTI4 1
ASGNI4
ADDRGP4 $2637
JUMPV
LABELV $2636
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $2637
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $2633
line 6721
;6721:		return;
ADDRGP4 $2632
JUMPV
LABELV $2633
line 6722
;6722:	for (i = 0; i < activategoal->numareas; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2641
JUMPV
LABELV $2638
line 6723
;6723:		trap_AAS_EnableRoutingArea( activategoal->areas[i], enable );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 trap_AAS_EnableRoutingArea
CALLI4
pop
LABELV $2639
line 6722
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2641
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
LTI4 $2638
line 6724
;6724:	activategoal->areasdisabled = !enable;
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $2643
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRGP4 $2644
JUMPV
LABELV $2643
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $2644
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 6725
;6725:}
LABELV $2632
endproc BotEnableActivateGoalAreas 12 8
export BotIsGoingToActivateEntity
proc BotIsGoingToActivateEntity 8 0
line 6732
;6726:
;6727:/*
;6728:==================
;6729:BotIsGoingToActivateEntity
;6730:==================
;6731:*/
;6732:int BotIsGoingToActivateEntity(bot_state_t *bs, int entitynum) {
line 6736
;6733:	bot_activategoal_t *a;
;6734:	int i;
;6735:
;6736:	for (a = bs->activatestack; a; a = a->next) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
ASGNP4
ADDRGP4 $2649
JUMPV
LABELV $2646
line 6737
;6737:		if (a->time < FloatTime())
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $2650
line 6738
;6738:			continue;
ADDRGP4 $2647
JUMPV
LABELV $2650
line 6739
;6739:		if (a->goal.entitynum == entitynum)
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $2652
line 6740
;6740:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2645
JUMPV
LABELV $2652
line 6741
;6741:	}
LABELV $2647
line 6736
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ASGNP4
LABELV $2649
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2646
line 6742
;6742:	for (i = 0; i < MAX_ACTIVATESTACK; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $2654
line 6743
;6743:		if (bs->activategoalheap[i].inuse)
ADDRLP4 4
INDIRI4
CNSTI4 244
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 12452
ADDP4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2658
line 6744
;6744:			continue;
ADDRGP4 $2655
JUMPV
LABELV $2658
line 6746
;6745:		//
;6746:		if (bs->activategoalheap[i].goal.entitynum == entitynum) {
ADDRLP4 4
INDIRI4
CNSTI4 244
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 12452
ADDP4
ADDP4
CNSTI4 44
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $2660
line 6748
;6747:			// if the bot went for this goal less than 2 seconds ago
;6748:			if (bs->activategoalheap[i].justused_time > FloatTime() - 2)
ADDRLP4 4
INDIRI4
CNSTI4 244
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 12452
ADDP4
ADDP4
CNSTI4 68
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
SUBF4
LEF4 $2662
line 6749
;6749:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2645
JUMPV
LABELV $2662
line 6750
;6750:		}
LABELV $2660
line 6751
;6751:	}
LABELV $2655
line 6742
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 8
LTI4 $2654
line 6752
;6752:	return qfalse;
CNSTI4 0
RETI4
LABELV $2645
endproc BotIsGoingToActivateEntity 8 0
export BotGetActivateGoal
proc BotGetActivateGoal 3316 20
line 6765
;6753:}
;6754:
;6755:/*
;6756:==================
;6757:BotGetActivateGoal
;6758:
;6759:  returns the number of the bsp entity to activate
;6760:  goal->entitynum will be set to the game entity to activate
;6761:==================
;6762:*/
;6763://#define OBSTACLEDEBUG
;6764:
;6765:int BotGetActivateGoal(bot_state_t *bs, int entitynum, bot_activategoal_t *activategoal) {
line 6775
;6766:	int i, ent, cur_entities[10], spawnflags, modelindex, areas[MAX_ACTIVATEAREAS*2], numareas, t;
;6767:	char model[MAX_INFO_STRING], tmpmodel[128];
;6768:	char target[128], classname[128];
;6769:	float health;
;6770:	char targetname[10][128];
;6771:	aas_entityinfo_t entinfo;
;6772:	aas_areainfo_t areainfo;
;6773:	vec3_t origin, angles, absmins, absmaxs;
;6774:
;6775:	memset(activategoal, 0, sizeof(bot_activategoal_t));
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 244
ARGI4
ADDRGP4 memset
CALLP4
pop
line 6776
;6776:	BotEntityInfo(entitynum, &entinfo);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 3052
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 6777
;6777:	Com_sprintf(model, sizeof( model ), "*%d", entinfo.modelindex);
ADDRLP4 1712
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $2665
ARGP4
ADDRLP4 3052+104
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 6778
;6778:	for (ent = trap_AAS_NextBSPEntity(0); ent; ent = trap_AAS_NextBSPEntity(ent)) {
CNSTI4 0
ARGI4
ADDRLP4 3252
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 3252
INDIRI4
ASGNI4
ADDRGP4 $2670
JUMPV
LABELV $2667
line 6779
;6779:		if (!trap_AAS_ValueForBSPEpairKey(ent, "model", tmpmodel, sizeof(tmpmodel))) continue;
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $221
ARGP4
ADDRLP4 1584
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 3256
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3256
INDIRI4
CNSTI4 0
NEI4 $2671
ADDRGP4 $2668
JUMPV
LABELV $2671
line 6780
;6780:		if (!strcmp(model, tmpmodel)) break;
ADDRLP4 1712
ARGP4
ADDRLP4 1584
ARGP4
ADDRLP4 3260
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3260
INDIRI4
CNSTI4 0
NEI4 $2673
ADDRGP4 $2669
JUMPV
LABELV $2673
line 6781
;6781:	}
LABELV $2668
line 6778
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 3256
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 3256
INDIRI4
ASGNI4
LABELV $2670
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2667
LABELV $2669
line 6782
;6782:	if (!ent) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2675
line 6783
;6783:		BotAI_Print(PRT_ERROR, "BotGetActivateGoal: no entity found with model %s\n", model);
CNSTI4 3
ARGI4
ADDRGP4 $2677
ARGP4
ADDRLP4 1712
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 6784
;6784:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $2664
JUMPV
LABELV $2675
line 6786
;6785:	}
;6786:	trap_AAS_ValueForBSPEpairKey(ent, "classname", classname, sizeof(classname));
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2678
ARGP4
ADDRLP4 1456
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
pop
line 6787
;6787:	if (!classname) {
ADDRLP4 1456
CVPU4 4
CNSTU4 0
NEU4 $2679
line 6788
;6788:		BotAI_Print(PRT_ERROR, "BotGetActivateGoal: entity with model %s has no classname\n", model);
CNSTI4 3
ARGI4
ADDRGP4 $2681
ARGP4
ADDRLP4 1712
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 6789
;6789:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $2664
JUMPV
LABELV $2679
line 6792
;6790:	}
;6791:	//if it is a door
;6792:	if (!strcmp(classname, "func_door")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $2684
ARGP4
ADDRLP4 3260
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3260
INDIRI4
CNSTI4 0
NEI4 $2682
line 6793
;6793:		if (trap_AAS_FloatForBSPEpairKey(ent, "health", &health)) {
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2480
ARGP4
ADDRLP4 3208
ARGP4
ADDRLP4 3264
ADDRGP4 trap_AAS_FloatForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3264
INDIRI4
CNSTI4 0
EQI4 $2685
line 6795
;6794:			//if the door has health then the door must be shot to open
;6795:			if (health) {
ADDRLP4 3208
INDIRF4
CNSTF4 0
EQF4 $2687
line 6796
;6796:				BotFuncDoorActivateGoal(bs, ent, activategoal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 BotFuncDoorActivateGoal
CALLI4
pop
line 6797
;6797:				return ent;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $2664
JUMPV
LABELV $2687
line 6799
;6798:			}
;6799:		}
LABELV $2685
line 6801
;6800:		//
;6801:		trap_AAS_IntForBSPEpairKey(ent, "spawnflags", &spawnflags);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2689
ARGP4
ADDRLP4 3204
ARGP4
ADDRGP4 trap_AAS_IntForBSPEpairKey
CALLI4
pop
line 6803
;6802:		// if the door starts open then just wait for the door to return
;6803:		if ( spawnflags & 1 )
ADDRLP4 3204
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $2690
line 6804
;6804:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $2664
JUMPV
LABELV $2690
line 6806
;6805:		//get the door origin
;6806:		if (!trap_AAS_VectorForBSPEpairKey(ent, "origin", origin)) {
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2694
ARGP4
ADDRLP4 3192
ARGP4
ADDRLP4 3268
ADDRGP4 trap_AAS_VectorForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3268
INDIRI4
CNSTI4 0
NEI4 $2692
line 6807
;6807:			VectorClear(origin);
ADDRLP4 3272
CNSTF4 0
ASGNF4
ADDRLP4 3192+8
ADDRLP4 3272
INDIRF4
ASGNF4
ADDRLP4 3192+4
ADDRLP4 3272
INDIRF4
ASGNF4
ADDRLP4 3192
ADDRLP4 3272
INDIRF4
ASGNF4
line 6808
;6808:		}
LABELV $2692
line 6810
;6809:		//if the door is open or opening already
;6810:		if (!VectorCompare(origin, entinfo.origin))
ADDRLP4 3192
ARGP4
ADDRLP4 3052+24
ARGP4
ADDRLP4 3272
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 3272
INDIRI4
CNSTI4 0
NEI4 $2697
line 6811
;6811:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $2664
JUMPV
LABELV $2697
line 6813
;6812:		// store all the areas the door is in
;6813:		trap_AAS_ValueForBSPEpairKey(ent, "model", model, sizeof(model));
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $221
ARGP4
ADDRLP4 1712
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
pop
line 6814
;6814:		if (*model) {
ADDRLP4 1712
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $2700
line 6815
;6815:			modelindex = atoi(model+1);
ADDRLP4 1712+1
ARGP4
ADDRLP4 3276
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 3212
ADDRLP4 3276
INDIRI4
ASGNI4
line 6816
;6816:			if (modelindex) {
ADDRLP4 3212
INDIRI4
CNSTI4 0
EQI4 $2703
line 6817
;6817:				VectorClear(angles);
ADDRLP4 3280
CNSTF4 0
ASGNF4
ADDRLP4 3216+8
ADDRLP4 3280
INDIRF4
ASGNF4
ADDRLP4 3216+4
ADDRLP4 3280
INDIRF4
ASGNF4
ADDRLP4 3216
ADDRLP4 3280
INDIRF4
ASGNF4
line 6818
;6818:				BotModelMinsMaxs(modelindex, ET_MOVER, 0, absmins, absmaxs);
ADDRLP4 3212
INDIRI4
ARGI4
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 3228
ARGP4
ADDRLP4 3240
ARGP4
ADDRGP4 BotModelMinsMaxs
CALLI4
pop
line 6820
;6819:				//
;6820:				numareas = trap_AAS_BBoxAreas(absmins, absmaxs, areas, MAX_ACTIVATEAREAS*2);
ADDRLP4 3228
ARGP4
ADDRLP4 3240
ARGP4
ADDRLP4 2740
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 3284
ADDRGP4 trap_AAS_BBoxAreas
CALLI4
ASGNI4
ADDRLP4 3048
ADDRLP4 3284
INDIRI4
ASGNI4
line 6822
;6821:				// store the areas with reachabilities first
;6822:				for (i = 0; i < numareas; i++) {
ADDRLP4 132
CNSTI4 0
ASGNI4
ADDRGP4 $2710
JUMPV
LABELV $2707
line 6823
;6823:					if (activategoal->numareas >= MAX_ACTIVATEAREAS)
ADDRFP4 8
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
CNSTI4 32
LTI4 $2711
line 6824
;6824:						break;
ADDRGP4 $2709
JUMPV
LABELV $2711
line 6825
;6825:					if ( !trap_AAS_AreaReachability(areas[i]) ) {
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 2740
ADDP4
INDIRI4
ARGI4
ADDRLP4 3288
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 3288
INDIRI4
CNSTI4 0
NEI4 $2713
line 6826
;6826:						continue;
ADDRGP4 $2708
JUMPV
LABELV $2713
line 6828
;6827:					}
;6828:					trap_AAS_AreaInfo(areas[i], &areainfo);
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 2740
ADDP4
INDIRI4
ARGI4
ADDRLP4 2996
ARGP4
ADDRGP4 trap_AAS_AreaInfo
CALLI4
pop
line 6829
;6829:					if (areainfo.contents & AREACONTENTS_MOVER) {
ADDRLP4 2996
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $2715
line 6830
;6830:						activategoal->areas[activategoal->numareas++] = areas[i];
ADDRLP4 3296
ADDRFP4 8
INDIRP4
CNSTI4 232
ADDP4
ASGNP4
ADDRLP4 3292
ADDRLP4 3296
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 3296
INDIRP4
ADDRLP4 3292
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 3292
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
CNSTI4 104
ADDP4
ADDP4
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 2740
ADDP4
INDIRI4
ASGNI4
line 6831
;6831:					}
LABELV $2715
line 6832
;6832:				}
LABELV $2708
line 6822
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2710
ADDRLP4 132
INDIRI4
ADDRLP4 3048
INDIRI4
LTI4 $2707
LABELV $2709
line 6834
;6833:				// store any remaining areas
;6834:				for (i = 0; i < numareas; i++) {
ADDRLP4 132
CNSTI4 0
ASGNI4
ADDRGP4 $2720
JUMPV
LABELV $2717
line 6835
;6835:						if (activategoal->numareas >= MAX_ACTIVATEAREAS)
ADDRFP4 8
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
CNSTI4 32
LTI4 $2721
line 6836
;6836:							break;
ADDRGP4 $2719
JUMPV
LABELV $2721
line 6837
;6837:					if ( trap_AAS_AreaReachability(areas[i]) ) {
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 2740
ADDP4
INDIRI4
ARGI4
ADDRLP4 3288
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 3288
INDIRI4
CNSTI4 0
EQI4 $2723
line 6838
;6838:						continue;
ADDRGP4 $2718
JUMPV
LABELV $2723
line 6840
;6839:					}
;6840:					trap_AAS_AreaInfo(areas[i], &areainfo);
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 2740
ADDP4
INDIRI4
ARGI4
ADDRLP4 2996
ARGP4
ADDRGP4 trap_AAS_AreaInfo
CALLI4
pop
line 6841
;6841:					if (areainfo.contents & AREACONTENTS_MOVER) {
ADDRLP4 2996
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $2725
line 6842
;6842:						activategoal->areas[activategoal->numareas++] = areas[i];
ADDRLP4 3296
ADDRFP4 8
INDIRP4
CNSTI4 232
ADDP4
ASGNP4
ADDRLP4 3292
ADDRLP4 3296
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 3296
INDIRP4
ADDRLP4 3292
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 3292
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
CNSTI4 104
ADDP4
ADDP4
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 2740
ADDP4
INDIRI4
ASGNI4
line 6843
;6843:					}
LABELV $2725
line 6844
;6844:				}
LABELV $2718
line 6834
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2720
ADDRLP4 132
INDIRI4
ADDRLP4 3048
INDIRI4
LTI4 $2717
LABELV $2719
line 6845
;6845:			}
LABELV $2703
line 6846
;6846:		}
LABELV $2700
line 6847
;6847:	}
LABELV $2682
line 6849
;6848:	// if the bot is blocked by or standing on top of a button
;6849:	if (!strcmp(classname, "func_button")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $2729
ARGP4
ADDRLP4 3264
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3264
INDIRI4
CNSTI4 0
NEI4 $2727
line 6850
;6850:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $2664
JUMPV
LABELV $2727
line 6853
;6851:	}
;6852:	// get the targetname so we can find an entity with a matching target
;6853:	if (!trap_AAS_ValueForBSPEpairKey(ent, "targetname", targetname[0], sizeof(targetname[0]))) {
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2732
ARGP4
ADDRLP4 136
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 3268
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3268
INDIRI4
CNSTI4 0
NEI4 $2730
line 6854
;6854:		if (bot_developer.integer) {
ADDRGP4 bot_developer+12
INDIRI4
CNSTI4 0
EQI4 $2733
line 6855
;6855:			BotAI_Print(PRT_ERROR, "BotGetActivateGoal: entity with model \"%s\" has no targetname\n", model);
CNSTI4 3
ARGI4
ADDRGP4 $2736
ARGP4
ADDRLP4 1712
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 6856
;6856:		}
LABELV $2733
line 6857
;6857:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $2664
JUMPV
LABELV $2730
line 6860
;6858:	}
;6859:	// allow tree-like activation
;6860:	cur_entities[0] = trap_AAS_NextBSPEntity(0);
CNSTI4 0
ARGI4
ADDRLP4 3272
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 1416
ADDRLP4 3272
INDIRI4
ASGNI4
line 6861
;6861:	for (i = 0; i >= 0 && i < 10;) {
ADDRLP4 132
CNSTI4 0
ASGNI4
ADDRGP4 $2740
JUMPV
LABELV $2737
line 6862
;6862:		for (ent = cur_entities[i]; ent; ent = trap_AAS_NextBSPEntity(ent)) {
ADDRLP4 0
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1416
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $2744
JUMPV
LABELV $2741
line 6863
;6863:			if (!trap_AAS_ValueForBSPEpairKey(ent, "target", target, sizeof(target))) continue;
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2747
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 3276
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3276
INDIRI4
CNSTI4 0
NEI4 $2745
ADDRGP4 $2742
JUMPV
LABELV $2745
line 6864
;6864:			if (!strcmp(targetname[i], target)) {
ADDRLP4 132
INDIRI4
CNSTI4 7
LSHI4
ADDRLP4 136
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 3280
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3280
INDIRI4
CNSTI4 0
NEI4 $2748
line 6865
;6865:				cur_entities[i] = trap_AAS_NextBSPEntity(ent);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 3284
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1416
ADDP4
ADDRLP4 3284
INDIRI4
ASGNI4
line 6866
;6866:				break;
ADDRGP4 $2743
JUMPV
LABELV $2748
line 6868
;6867:			}
;6868:		}
LABELV $2742
line 6862
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 3276
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 3276
INDIRI4
ASGNI4
LABELV $2744
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2741
LABELV $2743
line 6869
;6869:		if (!ent) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2750
line 6870
;6870:			if (bot_developer.integer) {
ADDRGP4 bot_developer+12
INDIRI4
CNSTI4 0
EQI4 $2752
line 6871
;6871:				BotAI_Print(PRT_ERROR, "BotGetActivateGoal: no entity with target \"%s\"\n", targetname[i]);
CNSTI4 3
ARGI4
ADDRGP4 $2755
ARGP4
ADDRLP4 132
INDIRI4
CNSTI4 7
LSHI4
ADDRLP4 136
ADDP4
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 6872
;6872:			}
LABELV $2752
line 6873
;6873:			i--;
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 6874
;6874:			continue;
ADDRGP4 $2738
JUMPV
LABELV $2750
line 6876
;6875:		}
;6876:		if (!trap_AAS_ValueForBSPEpairKey(ent, "classname", classname, sizeof(classname))) {
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2678
ARGP4
ADDRLP4 1456
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 3280
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3280
INDIRI4
CNSTI4 0
NEI4 $2756
line 6877
;6877:			if (bot_developer.integer) {
ADDRGP4 bot_developer+12
INDIRI4
CNSTI4 0
EQI4 $2738
line 6878
;6878:				BotAI_Print(PRT_ERROR, "BotGetActivateGoal: entity with target \"%s\" has no classname\n", targetname[i]);
CNSTI4 3
ARGI4
ADDRGP4 $2761
ARGP4
ADDRLP4 132
INDIRI4
CNSTI4 7
LSHI4
ADDRLP4 136
ADDP4
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 6879
;6879:			}
line 6880
;6880:			continue;
ADDRGP4 $2738
JUMPV
LABELV $2756
line 6883
;6881:		}
;6882:		// BSP button model
;6883:		if (!strcmp(classname, "func_button")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $2729
ARGP4
ADDRLP4 3284
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3284
INDIRI4
CNSTI4 0
NEI4 $2762
line 6885
;6884:			//
;6885:			if (!BotFuncButtonActivateGoal(bs, ent, activategoal))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 3288
ADDRGP4 BotFuncButtonActivateGoal
CALLI4
ASGNI4
ADDRLP4 3288
INDIRI4
CNSTI4 0
NEI4 $2764
line 6886
;6886:				continue;
ADDRGP4 $2738
JUMPV
LABELV $2764
line 6888
;6887:			// if the bot tries to activate this button already
;6888:			if ( bs->activatestack && bs->activatestack->inuse &&
ADDRLP4 3292
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 3292
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2766
ADDRLP4 3292
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $2766
ADDRLP4 3292
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
NEI4 $2766
ADDRLP4 3296
ADDRGP4 floattime
INDIRF4
ASGNF4
ADDRLP4 3292
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
ADDRLP4 3296
INDIRF4
LEF4 $2766
ADDRLP4 3292
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDRLP4 3296
INDIRF4
CNSTF4 1073741824
SUBF4
GEF4 $2766
line 6892
;6889:				 bs->activatestack->goal.entitynum == activategoal->goal.entitynum &&
;6890:				 bs->activatestack->time > FloatTime() &&
;6891:				 bs->activatestack->start_time < FloatTime() - 2)
;6892:				continue;
ADDRGP4 $2738
JUMPV
LABELV $2766
line 6894
;6893:			// if the bot is in a reachability area
;6894:			if ( trap_AAS_AreaReachability(bs->areanum) ) {
ADDRFP4 0
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
ARGI4
ADDRLP4 3300
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 3300
INDIRI4
CNSTI4 0
EQI4 $2768
line 6896
;6895:				// disable all areas the blocking entity is in
;6896:				BotEnableActivateGoalAreas( activategoal, qfalse );
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotEnableActivateGoalAreas
CALLV
pop
line 6898
;6897:				//
;6898:				t = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, activategoal->goal.areanum, bs->tfl);
ADDRLP4 3304
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 3304
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
ARGI4
ADDRLP4 3304
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRLP4 3304
INDIRP4
CNSTI4 5984
ADDP4
INDIRI4
ARGI4
ADDRLP4 3308
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 2736
ADDRLP4 3308
INDIRI4
ASGNI4
line 6900
;6899:				// if the button is not reachable
;6900:				if (!t) {
ADDRLP4 2736
INDIRI4
CNSTI4 0
NEI4 $2770
line 6901
;6901:					continue;
ADDRGP4 $2738
JUMPV
LABELV $2770
line 6903
;6902:				}
;6903:				activategoal->time = FloatTime() + t * 0.01 + 5;
ADDRFP4 8
INDIRP4
CNSTI4 60
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 2736
INDIRI4
CVIF4 4
CNSTF4 1008981770
MULF4
ADDF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 6904
;6904:			}
LABELV $2768
line 6905
;6905:			return ent;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $2664
JUMPV
LABELV $2762
line 6908
;6906:		}
;6907:		// invisible trigger multiple box
;6908:		else if (!strcmp(classname, "trigger_multiple")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $2774
ARGP4
ADDRLP4 3288
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3288
INDIRI4
CNSTI4 0
NEI4 $2772
line 6910
;6909:			//
;6910:			if (!BotTriggerMultipleActivateGoal(bs, ent, activategoal))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 3292
ADDRGP4 BotTriggerMultipleActivateGoal
CALLI4
ASGNI4
ADDRLP4 3292
INDIRI4
CNSTI4 0
NEI4 $2775
line 6911
;6911:				continue;
ADDRGP4 $2738
JUMPV
LABELV $2775
line 6913
;6912:			// if the bot tries to activate this trigger already
;6913:			if ( bs->activatestack && bs->activatestack->inuse &&
ADDRLP4 3296
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 3296
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2777
ADDRLP4 3296
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $2777
ADDRLP4 3296
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
NEI4 $2777
ADDRLP4 3300
ADDRGP4 floattime
INDIRF4
ASGNF4
ADDRLP4 3296
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
ADDRLP4 3300
INDIRF4
LEF4 $2777
ADDRLP4 3296
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDRLP4 3300
INDIRF4
CNSTF4 1073741824
SUBF4
GEF4 $2777
line 6917
;6914:				 bs->activatestack->goal.entitynum == activategoal->goal.entitynum &&
;6915:				 bs->activatestack->time > FloatTime() &&
;6916:				 bs->activatestack->start_time < FloatTime() - 2)
;6917:				continue;
ADDRGP4 $2738
JUMPV
LABELV $2777
line 6919
;6918:			// if the bot is in a reachability area
;6919:			if ( trap_AAS_AreaReachability(bs->areanum) ) {
ADDRFP4 0
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
ARGI4
ADDRLP4 3304
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 3304
INDIRI4
CNSTI4 0
EQI4 $2779
line 6921
;6920:				// disable all areas the blocking entity is in
;6921:				BotEnableActivateGoalAreas( activategoal, qfalse );
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotEnableActivateGoalAreas
CALLV
pop
line 6923
;6922:				//
;6923:				t = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, activategoal->goal.areanum, bs->tfl);
ADDRLP4 3308
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 3308
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
ARGI4
ADDRLP4 3308
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRLP4 3308
INDIRP4
CNSTI4 5984
ADDP4
INDIRI4
ARGI4
ADDRLP4 3312
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 2736
ADDRLP4 3312
INDIRI4
ASGNI4
line 6925
;6924:				// if the trigger is not reachable
;6925:				if (!t) {
ADDRLP4 2736
INDIRI4
CNSTI4 0
NEI4 $2781
line 6926
;6926:					continue;
ADDRGP4 $2738
JUMPV
LABELV $2781
line 6928
;6927:				}
;6928:				activategoal->time = FloatTime() + t * 0.01 + 5;
ADDRFP4 8
INDIRP4
CNSTI4 60
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 2736
INDIRI4
CVIF4 4
CNSTF4 1008981770
MULF4
ADDF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 6929
;6929:			}
LABELV $2779
line 6930
;6930:			return ent;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $2664
JUMPV
LABELV $2772
line 6932
;6931:		}
;6932:		else if (!strcmp(classname, "func_timer")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $2785
ARGP4
ADDRLP4 3292
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3292
INDIRI4
CNSTI4 0
NEI4 $2783
line 6934
;6933:			// just skip the func_timer
;6934:			continue;
ADDRGP4 $2738
JUMPV
LABELV $2783
line 6937
;6935:		}
;6936:		// the actual button or trigger might be linked through a target_relay or target_delay
;6937:		else if (!strcmp(classname, "target_relay") || !strcmp(classname, "target_delay")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $2788
ARGP4
ADDRLP4 3296
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3296
INDIRI4
CNSTI4 0
EQI4 $2790
ADDRLP4 1456
ARGP4
ADDRGP4 $2789
ARGP4
ADDRLP4 3300
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3300
INDIRI4
CNSTI4 0
NEI4 $2786
LABELV $2790
line 6938
;6938:			if (trap_AAS_ValueForBSPEpairKey(ent, "targetname", targetname[i+1], sizeof(targetname[0]))) {
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2732
ARGP4
ADDRLP4 132
INDIRI4
CNSTI4 7
LSHI4
ADDRLP4 136+128
ADDP4
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 3304
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3304
INDIRI4
CNSTI4 0
EQI4 $2791
line 6939
;6939:				i++;
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 6940
;6940:				cur_entities[i] = trap_AAS_NextBSPEntity(0);
CNSTI4 0
ARGI4
ADDRLP4 3308
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1416
ADDP4
ADDRLP4 3308
INDIRI4
ASGNI4
line 6941
;6941:			}
LABELV $2791
line 6942
;6942:		}
LABELV $2786
line 6943
;6943:	}
LABELV $2738
line 6861
LABELV $2740
ADDRLP4 132
INDIRI4
CNSTI4 0
LTI4 $2794
ADDRLP4 132
INDIRI4
CNSTI4 10
LTI4 $2737
LABELV $2794
line 6947
;6944:#ifdef OBSTACLEDEBUG
;6945:	BotAI_Print(PRT_ERROR, "BotGetActivateGoal: no valid activator for entity with target \"%s\"\n", targetname[0]);
;6946:#endif
;6947:	return 0;
CNSTI4 0
RETI4
LABELV $2664
endproc BotGetActivateGoal 3316 20
export BotGoForActivateGoal
proc BotGoForActivateGoal 144 8
line 6955
;6948:}
;6949:
;6950:/*
;6951:==================
;6952:BotGoForActivateGoal
;6953:==================
;6954:*/
;6955:int BotGoForActivateGoal(bot_state_t *bs, bot_activategoal_t *activategoal) {
line 6958
;6956:	aas_entityinfo_t activateinfo;
;6957:
;6958:	activategoal->inuse = qtrue;
ADDRFP4 4
INDIRP4
CNSTI4 1
ASGNI4
line 6959
;6959:	if (!activategoal->time)
ADDRFP4 4
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
CNSTF4 0
NEF4 $2796
line 6960
;6960:		activategoal->time = FloatTime() + 10;
ADDRFP4 4
INDIRP4
CNSTI4 60
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1092616192
ADDF4
ASGNF4
LABELV $2796
line 6961
;6961:	activategoal->start_time = FloatTime();
ADDRFP4 4
INDIRP4
CNSTI4 64
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 6962
;6962:	BotEntityInfo(activategoal->goal.entitynum, &activateinfo);
ADDRFP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 6963
;6963:	VectorCopy(activateinfo.origin, activategoal->origin);
ADDRFP4 4
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 0+24
INDIRB
ASGNB 12
line 6965
;6964:	//
;6965:	if (BotPushOntoActivateGoalStack(bs, activategoal)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotPushOntoActivateGoalStack
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $2799
line 6967
;6966:		// enter the activate entity AI node
;6967:		AIEnter_Seek_ActivateEntity(bs, "BotGoForActivateGoal");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2801
ARGP4
ADDRGP4 AIEnter_Seek_ActivateEntity
CALLV
pop
line 6968
;6968:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2795
JUMPV
LABELV $2799
line 6970
;6969:	}
;6970:	else {
line 6972
;6971:		// enable any routing areas that were disabled
;6972:		BotEnableActivateGoalAreas(activategoal, qtrue);
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BotEnableActivateGoalAreas
CALLV
pop
line 6973
;6973:		return qfalse;
CNSTI4 0
RETI4
LABELV $2795
endproc BotGoForActivateGoal 144 8
export BotPrintActivateGoalInfo
proc BotPrintActivateGoalInfo 296 36
line 6982
;6974:	}
;6975:}
;6976:
;6977:/*
;6978:==================
;6979:BotPrintActivateGoalInfo
;6980:==================
;6981:*/
;6982:void BotPrintActivateGoalInfo(bot_state_t *bs, bot_activategoal_t *activategoal, int bspent) {
line 6987
;6983:	char netname[MAX_NETNAME];
;6984:	char classname[128];
;6985:	char buf[128];
;6986:
;6987:	ClientName(bs->client, netname, sizeof(netname));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 6988
;6988:	trap_AAS_ValueForBSPEpairKey(bspent, "classname", classname, sizeof(classname));
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 $2678
ARGP4
ADDRLP4 36
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
pop
line 6989
;6989:	if (activategoal->shoot) {
ADDRFP4 4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2803
line 6990
;6990:		Com_sprintf(buf, sizeof(buf), "%s: I have to shoot at a %s from %1.1f %1.1f %1.1f in area %d\n",
ADDRLP4 164
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $2805
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 292
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 292
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 6996
;6991:						netname, classname,
;6992:						activategoal->goal.origin[0],
;6993:						activategoal->goal.origin[1],
;6994:						activategoal->goal.origin[2],
;6995:						activategoal->goal.areanum);
;6996:	}
ADDRGP4 $2804
JUMPV
LABELV $2803
line 6997
;6997:	else {
line 6998
;6998:		Com_sprintf(buf, sizeof(buf), "%s: I have to activate a %s at %1.1f %1.1f %1.1f in area %d\n",
ADDRLP4 164
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $2806
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 292
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 292
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 7004
;6999:						netname, classname,
;7000:						activategoal->goal.origin[0],
;7001:						activategoal->goal.origin[1],
;7002:						activategoal->goal.origin[2],
;7003:						activategoal->goal.areanum);
;7004:	}
LABELV $2804
line 7005
;7005:	trap_EA_Say(bs->client, buf);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 164
ARGP4
ADDRGP4 trap_EA_Say
CALLV
pop
line 7006
;7006:}
LABELV $2802
endproc BotPrintActivateGoalInfo 296 36
export BotRandomMove
proc BotRandomMove 28 16
line 7013
;7007:
;7008:/*
;7009:==================
;7010:BotRandomMove
;7011:==================
;7012:*/
;7013:void BotRandomMove(bot_state_t *bs, bot_moveresult_t *moveresult) {
line 7016
;7014:	vec3_t dir, angles;
;7015:
;7016:	angles[0] = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 7017
;7017:	angles[1] = random() * 360;
ADDRLP4 24
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 0+4
ADDRLP4 24
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 24
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 867434496
MULF4
ASGNF4
line 7018
;7018:	angles[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 7019
;7019:	AngleVectors(angles, dir, NULL, NULL);
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 7021
;7020:
;7021:	trap_BotMoveInDirection(bs->ms, dir, 400, MOVE_WALK);
ADDRFP4 0
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
CNSTF4 1137180672
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotMoveInDirection
CALLI4
pop
line 7023
;7022:
;7023:	moveresult->failure = qfalse;
ADDRFP4 4
INDIRP4
CNSTI4 0
ASGNI4
line 7024
;7024:	VectorCopy(dir, moveresult->movedir);
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 12
INDIRB
ASGNB 12
line 7025
;7025:}
LABELV $2807
endproc BotRandomMove 28 16
proc BotMemorizeOrigin 12 0
line 7032
;7026:
;7027:/*
;7028:==================
;7029:JUHOX: BotMemorizeOrigin
;7030:==================
;7031:*/
;7032:static void BotMemorizeOrigin(bot_state_t* bs) {
line 7033
;7033:	if (bs->oldOrigin1_time <= FloatTime() - 2) {
ADDRFP4 0
INDIRP4
CNSTI4 7360
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
SUBF4
GTF4 $2811
line 7034
;7034:		VectorCopy(bs->oldOrigin1, bs->oldOrigin2);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 7364
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 7348
ADDP4
INDIRB
ASGNB 12
line 7035
;7035:		bs->oldOrigin2_time = bs->oldOrigin1_time;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 7376
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 7360
ADDP4
INDIRF4
ASGNF4
line 7036
;7036:		VectorCopy(bs->origin, bs->oldOrigin1);
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 7348
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 4916
ADDP4
INDIRB
ASGNB 12
line 7037
;7037:		bs->oldOrigin1_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7360
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 7038
;7038:	}
LABELV $2811
line 7039
;7039:}
LABELV $2810
endproc BotMemorizeOrigin 12 0
proc BotCheckSidewardVector 28 4
line 7046
;7040:
;7041:/*
;7042:==================
;7043:JUHOX: BotCheckSidewardVector
;7044:==================
;7045:*/
;7046:static void BotCheckSidewardVector(bot_state_t* bs, const vec3_t sideward) {
line 7047
;7047:	if (bs->oldOrigin2_time >= FloatTime() - 4) {
ADDRFP4 0
INDIRP4
CNSTI4 7376
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1082130432
SUBF4
LTF4 $2814
line 7050
;7048:		vec3_t dir;
;7049:
;7050:		VectorSubtract(bs->origin, bs->oldOrigin2, dir);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 7364
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 12
INDIRP4
CNSTI4 4920
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 7368
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 16
INDIRP4
CNSTI4 4924
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 7372
ADDP4
INDIRF4
SUBF4
ASGNF4
line 7051
;7051:		VectorNormalize(dir);
ADDRLP4 0
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 7052
;7052:		if (DotProduct(sideward, dir) < 0) {
ADDRLP4 20
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
MULF4
ADDF4
ADDRLP4 20
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
MULF4
ADDF4
CNSTF4 0
GEF4 $2818
line 7053
;7053:			bs->flags |= BFL_AVOIDRIGHT;	// try the other direction
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 5992
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 7054
;7054:		}
ADDRGP4 $2819
JUMPV
LABELV $2818
line 7055
;7055:		else {
line 7056
;7056:			bs->flags &= ~BFL_AVOIDRIGHT;	// this direction is ok
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 5992
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 -17
BANDI4
ASGNI4
line 7057
;7057:		}
LABELV $2819
line 7058
;7058:	}
LABELV $2814
line 7059
;7059:}
LABELV $2813
endproc BotCheckSidewardVector 28 4
data
align 4
LABELV $2823
byte 4 0
byte 4 0
byte 4 1065353216
export BotAIBlocked
code
proc BotAIBlocked 956 16
line 7072
;7060:
;7061:/*
;7062:==================
;7063:BotAIBlocked
;7064:
;7065:Very basic handling of bots being blocked by other entities.
;7066:Check what kind of entity is blocking the bot and try to activate
;7067:it. If that's not an option then try to walk around or over the entity.
;7068:Before the bot ends in this part of the AI it should predict which doors to
;7069:open, which buttons to activate etc.
;7070:==================
;7071:*/
;7072:void BotAIBlocked(bot_state_t *bs, bot_moveresult_t *moveresult, int activate) {
line 7074
;7073:	int /*movetype,*/ bspent;	// JUHOX: using bs->tryMove instead
;7074:	vec3_t hordir, /*start, end, mins, maxs,*/ sideward, angles, up = {0, 0, 1};	// JUHOX: some variables no longer needed
ADDRLP4 176
ADDRGP4 $2823
INDIRB
ASGNB 12
line 7087
;7075:	aas_entityinfo_t entinfo;
;7076:	bot_activategoal_t activategoal;
;7077:	playerState_t ps;	// JUHOX
;7078:
;7079:
;7080:#if 0	// JUHOX: continue with obstacle avoidance move if the bot was recently blocked
;7081:	// if the bot is not blocked by anything
;7082:	if (!moveresult->blocked) {
;7083:		bs->notblocked_time = FloatTime();
;7084:		return;
;7085:	}
;7086:#else
;7087:	if (bs->walkTrouble) {
ADDRFP4 0
INDIRP4
CNSTI4 7344
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2824
line 7088
;7088:		bs->tryMove = MOVE_WALK;
ADDRFP4 0
INDIRP4
CNSTI4 7324
ADDP4
CNSTI4 1
ASGNI4
line 7089
;7089:		goto BotBlocked;
ADDRGP4 $2826
JUMPV
LABELV $2824
line 7091
;7090:	}
;7091:	if (!moveresult->blocked) {
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2827
line 7092
;7092:		bs->blockingEnemy = -1;
ADDRFP4 0
INDIRP4
CNSTI4 7320
ADDP4
CNSTI4 -1
ASGNI4
line 7093
;7093:		bs->notblocked_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7316
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 7094
;7094:		if (bs->tryMove && bs->blocked_time > FloatTime() - 0.5) goto ObstacleAvoidanceMove;
ADDRLP4 904
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 904
INDIRP4
CNSTI4 7324
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2829
ADDRLP4 904
INDIRP4
CNSTI4 7340
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1056964608
SUBF4
LEF4 $2829
ADDRGP4 $2831
JUMPV
LABELV $2829
line 7095
;7095:		if (rand() & 1) bs->flags ^= BFL_AVOIDRIGHT;
ADDRLP4 908
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 908
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $2832
ADDRLP4 912
ADDRFP4 0
INDIRP4
CNSTI4 5992
ADDP4
ASGNP4
ADDRLP4 912
INDIRP4
ADDRLP4 912
INDIRP4
INDIRI4
CNSTI4 16
BXORI4
ASGNI4
LABELV $2832
line 7096
;7096:		VectorSet(bs->notblocked_dir, 0, 0, 0);
ADDRFP4 0
INDIRP4
CNSTI4 7328
ADDP4
CNSTF4 0
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 7332
ADDP4
CNSTF4 0
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 7336
ADDP4
CNSTF4 0
ASGNF4
line 7097
;7097:		BotMemorizeOrigin(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotMemorizeOrigin
CALLV
pop
line 7098
;7098:		return;
ADDRGP4 $2822
JUMPV
LABELV $2827
line 7100
;7099:	}
;7100:	bs->tryMove = MOVE_JUMP;
ADDRFP4 0
INDIRP4
CNSTI4 7324
ADDP4
CNSTI4 4
ASGNI4
line 7103
;7101:#endif
;7102:	// if stuck in a solid area
;7103:	if ( moveresult->type == RESULTTYPE_INSOLIDAREA ) {
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 8
NEI4 $2834
line 7105
;7104:		// move in a random direction in the hope to get out
;7105:		BotRandomMove(bs, moveresult);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotRandomMove
CALLV
pop
line 7107
;7106:		//
;7107:		return;
ADDRGP4 $2822
JUMPV
LABELV $2834
line 7110
;7108:	}
;7109:#if 1	// JUHOX: check if it's an enemy
;7110:	if (BotAI_GetClientState(moveresult->blockentity, &ps)) {
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 188
ARGP4
ADDRLP4 904
ADDRGP4 BotAI_GetClientState
CALLI4
ASGNI4
ADDRLP4 904
INDIRI4
CNSTI4 0
EQI4 $2836
line 7112
;7111:		if (
;7112:			g_gametype.integer < GT_TEAM ||
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $2843
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ADDRLP4 188+248+12
INDIRI4
EQI4 $2838
LABELV $2843
line 7114
;7113:			bs->cur_ps.persistant[PERS_TEAM] != ps.persistant[PERS_TEAM]
;7114:		) {
line 7115
;7115:			bs->blockingEnemy = moveresult->blockentity;
ADDRFP4 0
INDIRP4
CNSTI4 7320
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 7116
;7116:		}
LABELV $2838
line 7117
;7117:	}
LABELV $2836
line 7120
;7118:#endif
;7119:	// get info for the entity that is blocking the bot
;7120:	BotEntityInfo(moveresult->blockentity, &entinfo);
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 7126
;7121:#ifdef OBSTACLEDEBUG
;7122:	ClientName(bs->client, netname, sizeof(netname));
;7123:	BotAI_Print(PRT_MESSAGE, "%s: I'm blocked by model %d\n", netname, entinfo.modelindex);
;7124:#endif OBSTACLEDEBUG
;7125:	// if blocked by a bsp model and the bot wants to activate it
;7126:	if (activate && entinfo.modelindex > 0 && entinfo.modelindex <= max_bspmodelindex) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $2844
ADDRLP4 24+104
INDIRI4
CNSTI4 0
LEI4 $2844
ADDRLP4 24+104
INDIRI4
ADDRGP4 max_bspmodelindex
INDIRI4
GTI4 $2844
line 7128
;7127:		// find the bsp entity which should be activated in order to get the blocking entity out of the way
;7128:		bspent = BotGetActivateGoal(bs, entinfo.number, &activategoal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 24+20
INDIRI4
ARGI4
ADDRLP4 656
ARGP4
ADDRLP4 908
ADDRGP4 BotGetActivateGoal
CALLI4
ASGNI4
ADDRLP4 900
ADDRLP4 908
INDIRI4
ASGNI4
line 7129
;7129:		if (bspent) {
ADDRLP4 900
INDIRI4
CNSTI4 0
EQI4 $2849
line 7131
;7130:			//
;7131:			if (bs->activatestack && !bs->activatestack->inuse)
ADDRLP4 912
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 912
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2851
ADDRLP4 912
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $2851
line 7132
;7132:				bs->activatestack = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 12448
ADDP4
CNSTP4 0
ASGNP4
LABELV $2851
line 7134
;7133:			// if not already trying to activate this entity
;7134:			if (!BotIsGoingToActivateEntity(bs, activategoal.goal.entitynum)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 656+4+40
INDIRI4
ARGI4
ADDRLP4 916
ADDRGP4 BotIsGoingToActivateEntity
CALLI4
ASGNI4
ADDRLP4 916
INDIRI4
CNSTI4 0
NEI4 $2853
line 7136
;7135:				//
;7136:				BotGoForActivateGoal(bs, &activategoal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 656
ARGP4
ADDRGP4 BotGoForActivateGoal
CALLI4
pop
line 7137
;7137:			}
LABELV $2853
line 7141
;7138:			// if ontop of an obstacle or
;7139:			// if the bot is not in a reachability area it'll still
;7140:			// need some dynamic obstacle avoidance, otherwise return
;7141:			if (!(moveresult->flags & MOVERESULT_ONTOPOFOBSTACLE) &&
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
NEI4 $2850
ADDRFP4 0
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
ARGI4
ADDRLP4 920
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 920
INDIRI4
CNSTI4 0
EQI4 $2850
line 7143
;7142:				trap_AAS_AreaReachability(bs->areanum))
;7143:				return;
ADDRGP4 $2822
JUMPV
line 7144
;7144:		}
LABELV $2849
line 7145
;7145:		else {
line 7147
;7146:			// enable any routing areas that were disabled
;7147:			BotEnableActivateGoalAreas(&activategoal, qtrue);
ADDRLP4 656
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BotEnableActivateGoalAreas
CALLV
pop
line 7148
;7148:		}
LABELV $2850
line 7149
;7149:	}
LABELV $2844
LABELV $2826
line 7193
;7150:	// just some basic dynamic obstacle avoidance code
;7151:#if 0	// JUHOX: slightly improved obstacle avoidance strategy
;7152:	hordir[0] = moveresult->movedir[0];
;7153:	hordir[1] = moveresult->movedir[1];
;7154:	hordir[2] = 0;
;7155:	// if no direction just take a random direction
;7156:	if (VectorNormalize(hordir) < 0.1) {
;7157:		VectorSet(angles, 0, 360 * random(), 0);
;7158:		AngleVectors(angles, hordir, NULL, NULL);
;7159:	}
;7160:	//
;7161:	//if (moveresult->flags & MOVERESULT_ONTOPOFOBSTACLE) movetype = MOVE_JUMP;
;7162:	//else
;7163:	movetype = MOVE_WALK;
;7164:	// if there's an obstacle at the bot's feet and head then
;7165:	// the bot might be able to crouch through
;7166:	VectorCopy(bs->origin, start);
;7167:	start[2] += 18;
;7168:	VectorMA(start, 5, hordir, end);
;7169:	VectorSet(mins, -16, -16, -24);
;7170:	VectorSet(maxs, 16, 16, 4);
;7171:	//
;7172:	//bsptrace = AAS_Trace(start, mins, maxs, end, bs->entitynum, MASK_PLAYERSOLID);
;7173:	//if (bsptrace.fraction >= 1) movetype = MOVE_CROUCH;
;7174:	// get the sideward vector
;7175:	CrossProduct(hordir, up, sideward);
;7176:	//
;7177:	if (bs->flags & BFL_AVOIDRIGHT) VectorNegate(sideward, sideward);
;7178:	// try to crouch straight forward?
;7179:	if (movetype != MOVE_CROUCH || !trap_BotMoveInDirection(bs->ms, hordir, 400, movetype)) {
;7180:		// perform the movement
;7181:		if (!trap_BotMoveInDirection(bs->ms, sideward, 400, movetype)) {
;7182:			// flip the avoid direction flag
;7183:			bs->flags ^= BFL_AVOIDRIGHT;
;7184:			// flip the direction
;7185:			// VectorNegate(sideward, sideward);
;7186:			VectorMA(sideward, -1, hordir, sideward);
;7187:			// move in the other direction
;7188:			trap_BotMoveInDirection(bs->ms, sideward, 400, movetype);
;7189:		}
;7190:	}
;7191:#else
;7192:	BotBlocked:
;7193:	bs->blocked_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7340
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
LABELV $2831
line 7196
;7194:
;7195:	ObstacleAvoidanceMove:
;7196:	hordir[0] = moveresult->movedir[0];
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ASGNF4
line 7197
;7197:	hordir[1] = moveresult->movedir[1];
ADDRLP4 0+4
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ASGNF4
line 7198
;7198:	hordir[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 7200
;7199:	//if no direction just take a random direction
;7200:	if (VectorNormalize(hordir) < 0.1) {
ADDRLP4 0
ARGP4
ADDRLP4 908
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 908
INDIRF4
CNSTF4 1036831949
GEF4 $2861
line 7201
;7201:		VectorSet(angles, 0, 360 * random(), 0);
ADDRLP4 164
CNSTF4 0
ASGNF4
ADDRLP4 912
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 164+4
ADDRLP4 912
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 912
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1135869952
MULF4
ASGNF4
ADDRLP4 164+8
CNSTF4 0
ASGNF4
line 7202
;7202:		AngleVectors(angles, hordir, NULL, NULL);
ADDRLP4 164
ARGP4
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 7203
;7203:	}
LABELV $2861
line 7204
;7204:	CrossProduct(hordir, up, sideward);
ADDRLP4 0
ARGP4
ADDRLP4 176
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 7205
;7205:	BotCheckSidewardVector(bs, sideward);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 BotCheckSidewardVector
CALLV
pop
line 7206
;7206:	if (bs->flags & BFL_AVOIDRIGHT) VectorNegate(sideward, sideward);
ADDRFP4 0
INDIRP4
CNSTI4 5992
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $2865
ADDRLP4 12
ADDRLP4 12
INDIRF4
NEGF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
NEGF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
NEGF4
ASGNF4
LABELV $2865
line 7209
;7207:
;7208:	//if (!bs->walkTrouble) VectorScale(hordir, -0.5, hordir);
;7209:	VectorAdd(hordir, sideward, hordir);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 12+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 12+8
INDIRF4
ADDF4
ASGNF4
line 7210
;7210:	VectorNormalize(hordir);
ADDRLP4 0
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 7212
;7211:
;7212:	{
line 7215
;7213:		float speed;
;7214:
;7215:		speed = bs->forceWalk? 200 : 400;
ADDRFP4 0
INDIRP4
CNSTI4 7740
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2878
ADDRLP4 916
CNSTI4 200
ASGNI4
ADDRGP4 $2879
JUMPV
LABELV $2878
ADDRLP4 916
CNSTI4 400
ASGNI4
LABELV $2879
ADDRLP4 912
ADDRLP4 916
INDIRI4
CVIF4 4
ASGNF4
line 7217
;7216:		//bs->preventJump = qtrue;
;7217:		if (!trap_BotMoveInDirection(bs->ms, hordir, speed, bs->tryMove)) {
ADDRLP4 920
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 920
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 912
INDIRF4
ARGF4
ADDRLP4 920
INDIRP4
CNSTI4 7324
ADDP4
INDIRI4
ARGI4
ADDRLP4 924
ADDRGP4 trap_BotMoveInDirection
CALLI4
ASGNI4
ADDRLP4 924
INDIRI4
CNSTI4 0
NEI4 $2880
line 7218
;7218:			if (!trap_BotMoveInDirection(bs->ms, sideward, speed, MOVE_WALK)) {
ADDRFP4 0
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
ADDRLP4 912
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRLP4 928
ADDRGP4 trap_BotMoveInDirection
CALLI4
ASGNI4
ADDRLP4 928
INDIRI4
CNSTI4 0
NEI4 $2882
line 7219
;7219:				bs->oldOrigin1_time = bs->oldOrigin2_time = 0;
ADDRLP4 932
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 936
CNSTF4 0
ASGNF4
ADDRLP4 932
INDIRP4
CNSTI4 7376
ADDP4
ADDRLP4 936
INDIRF4
ASGNF4
ADDRLP4 932
INDIRP4
CNSTI4 7360
ADDP4
ADDRLP4 936
INDIRF4
ASGNF4
line 7220
;7220:				bs->flags ^= BFL_AVOIDRIGHT;
ADDRLP4 940
ADDRFP4 0
INDIRP4
CNSTI4 5992
ADDP4
ASGNP4
ADDRLP4 940
INDIRP4
ADDRLP4 940
INDIRP4
INDIRI4
CNSTI4 16
BXORI4
ASGNI4
line 7221
;7221:				VectorNegate(sideward, sideward);
ADDRLP4 12
ADDRLP4 12
INDIRF4
NEGF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
NEGF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
NEGF4
ASGNF4
line 7222
;7222:				if (!trap_BotMoveInDirection(bs->ms, sideward, speed, MOVE_WALK)) {
ADDRFP4 0
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
ADDRLP4 912
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRLP4 944
ADDRGP4 trap_BotMoveInDirection
CALLI4
ASGNI4
ADDRLP4 944
INDIRI4
CNSTI4 0
NEI4 $2888
line 7223
;7223:					if (DotProduct(bs->notblocked_dir, bs->notblocked_dir) < 0.1) {
ADDRLP4 948
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 948
INDIRP4
CNSTI4 7328
ADDP4
INDIRF4
ADDRLP4 948
INDIRP4
CNSTI4 7328
ADDP4
INDIRF4
MULF4
ADDRLP4 948
INDIRP4
CNSTI4 7332
ADDP4
INDIRF4
ADDRLP4 948
INDIRP4
CNSTI4 7332
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 948
INDIRP4
CNSTI4 7336
ADDP4
INDIRF4
ADDRLP4 948
INDIRP4
CNSTI4 7336
ADDP4
INDIRF4
MULF4
ADDF4
CNSTF4 1036831949
GEF4 $2890
line 7224
;7224:						VectorSet(angles, 0, 360 * random(), 0);
ADDRLP4 164
CNSTF4 0
ASGNF4
ADDRLP4 952
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 164+4
ADDRLP4 952
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 952
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1135869952
MULF4
ASGNF4
ADDRLP4 164+8
CNSTF4 0
ASGNF4
line 7225
;7225:						AngleVectors(angles, hordir, NULL, NULL);
ADDRLP4 164
ARGP4
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 7226
;7226:					}
ADDRGP4 $2891
JUMPV
LABELV $2890
line 7227
;7227:					else {
line 7228
;7228:						VectorCopy(bs->notblocked_dir, hordir);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 7328
ADDP4
INDIRB
ASGNB 12
line 7229
;7229:					}
LABELV $2891
line 7230
;7230:					if (trap_BotMoveInDirection(bs->ms, hordir, speed, MOVE_WALK)) {
ADDRFP4 0
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 912
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRLP4 952
ADDRGP4 trap_BotMoveInDirection
CALLI4
ASGNI4
ADDRLP4 952
INDIRI4
CNSTI4 0
EQI4 $2894
line 7231
;7231:						VectorCopy(hordir, bs->notblocked_dir);
ADDRFP4 0
INDIRP4
CNSTI4 7328
ADDP4
ADDRLP4 0
INDIRB
ASGNB 12
line 7232
;7232:					}
ADDRGP4 $2895
JUMPV
LABELV $2894
line 7233
;7233:					else {
line 7234
;7234:						VectorSet(bs->notblocked_dir, 0, 0, 0);
ADDRFP4 0
INDIRP4
CNSTI4 7328
ADDP4
CNSTF4 0
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 7332
ADDP4
CNSTF4 0
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 7336
ADDP4
CNSTF4 0
ASGNF4
line 7235
;7235:					}
LABELV $2895
line 7236
;7236:				}
LABELV $2888
line 7237
;7237:			}
LABELV $2882
line 7238
;7238:		}
LABELV $2880
line 7239
;7239:	}
line 7242
;7240:#endif
;7241:	//
;7242:	if (bs->notblocked_time < FloatTime() - 0.4) {
ADDRFP4 0
INDIRP4
CNSTI4 7316
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1053609165
SUBF4
GEF4 $2896
line 7245
;7243:		// just reset goals and hope the bot will go into another direction?
;7244:		// is this still needed??
;7245:		if (bs->ainode == AINode_Seek_NBG) bs->nbg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 4904
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 AINode_Seek_NBG
CVPU4 4
NEU4 $2898
ADDRFP4 0
INDIRP4
CNSTI4 6092
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 $2899
JUMPV
LABELV $2898
line 7246
;7246:		else if (bs->ainode == AINode_Seek_LTG) bs->ltg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 4904
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 AINode_Seek_LTG
CVPU4 4
NEU4 $2900
ADDRFP4 0
INDIRP4
CNSTI4 6088
ADDP4
CNSTF4 0
ASGNF4
LABELV $2900
LABELV $2899
line 7247
;7247:	}
LABELV $2896
line 7250
;7248:#if 1	// JUHOX: if blocked quite a long time
;7249:	if (
;7250:		(
ADDRLP4 912
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 912
INDIRP4
CNSTI4 7316
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
SUBF4
GEF4 $2905
ADDRLP4 912
INDIRP4
ARGP4
ADDRLP4 916
ADDRGP4 BotWantsToRetreat
CALLI4
ASGNI4
ADDRLP4 916
INDIRI4
CNSTI4 0
EQI4 $2904
LABELV $2905
ADDRFP4 0
INDIRP4
CNSTI4 7316
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
SUBF4
GEF4 $2902
LABELV $2904
line 7255
;7251:			bs->notblocked_time < FloatTime() - 1 &&
;7252:			!BotWantsToRetreat(bs)
;7253:		) ||
;7254:		bs->notblocked_time < FloatTime() - 2
;7255:	) {
line 7256
;7256:		bs->ltgtype = LTG_WAIT;
ADDRFP4 0
INDIRP4
CNSTI4 11532
ADDP4
CNSTI4 17
ASGNI4
line 7257
;7257:		bs->teamgoal_time = FloatTime() + 5 * random();
ADDRLP4 920
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRFP4 0
INDIRP4
CNSTI4 11700
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 920
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 920
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1084227584
MULF4
ADDF4
ASGNF4
line 7258
;7258:	}
LABELV $2902
line 7260
;7259:#endif
;7260:}
LABELV $2822
endproc BotAIBlocked 956 16
export BotAIPredictObstacles
proc BotAIPredictObstacles 316 44
line 7272
;7261:
;7262:/*
;7263:==================
;7264:BotAIPredictObstacles
;7265:
;7266:Predict the route towards the goal and check if the bot
;7267:will be blocked by certain obstacles. When the bot has obstacles
;7268:on it's path the bot should figure out if they can be removed
;7269:by activating certain entities.
;7270:==================
;7271:*/
;7272:int BotAIPredictObstacles(bot_state_t *bs, bot_goal_t *goal) {
line 7277
;7273:	int modelnum, entitynum, bspent;
;7274:	bot_activategoal_t activategoal;
;7275:	aas_predictroute_t route;
;7276:
;7277:	if (!bot_predictobstacles.integer)
ADDRGP4 bot_predictobstacles+12
INDIRI4
CNSTI4 0
NEI4 $2907
line 7278
;7278:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2906
JUMPV
LABELV $2907
line 7281
;7279:
;7280:	// always predict when the goal change or at regular intervals
;7281:	if (bs->predictobstacles_goalareanum == goal->areanum &&
ADDRLP4 292
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 292
INDIRP4
CNSTI4 7388
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
NEI4 $2910
ADDRLP4 292
INDIRP4
CNSTI4 7384
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1086324736
SUBF4
LEF4 $2910
line 7282
;7282:		bs->predictobstacles_time > FloatTime() - 6) {
line 7283
;7283:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2906
JUMPV
LABELV $2910
line 7285
;7284:	}
;7285:	bs->predictobstacles_goalareanum = goal->areanum;
ADDRFP4 0
INDIRP4
CNSTI4 7388
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 7286
;7286:	bs->predictobstacles_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7384
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 7289
;7287:
;7288:	// predict at most 100 areas or 10 seconds ahead
;7289:	trap_AAS_PredictRoute(&route, bs->areanum, bs->origin,
ADDRLP4 0
ARGP4
ADDRLP4 296
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 296
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
ARGI4
ADDRLP4 296
INDIRP4
CNSTI4 4916
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 296
INDIRP4
CNSTI4 5984
ADDP4
INDIRI4
ARGI4
CNSTI4 100
ARGI4
CNSTI4 1000
ARGI4
CNSTI4 6
ARGI4
CNSTI4 1024
ARGI4
CNSTI4 67108864
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_AAS_PredictRoute
CALLI4
pop
line 7294
;7290:							goal->areanum, bs->tfl, 100, 1000,
;7291:							RSE_USETRAVELTYPE|RSE_ENTERCONTENTS,
;7292:							AREACONTENTS_MOVER, TFL_BRIDGE, 0);
;7293:	// if bot has to travel through an area with a mover
;7294:	if (route.stopevent & RSE_ENTERCONTENTS) {
ADDRLP4 0+16
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $2912
line 7296
;7295:		// if the bot will run into a mover
;7296:		if (route.endcontents & AREACONTENTS_MOVER) {
ADDRLP4 0+20
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $2913
line 7298
;7297:			//NOTE: this only works with bspc 2.1 or higher
;7298:			modelnum = (route.endcontents & AREACONTENTS_MODELNUM) >> AREACONTENTS_MODELNUMSHIFT;
ADDRLP4 36
ADDRLP4 0+20
INDIRI4
CNSTI4 255
CNSTI4 24
LSHI4
BANDI4
CNSTI4 24
RSHI4
ASGNI4
line 7299
;7299:			if (modelnum) {
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $2913
line 7301
;7300:				//
;7301:				entitynum = BotModelMinsMaxs(modelnum, ET_MOVER, 0, NULL, NULL);
ADDRLP4 36
INDIRI4
ARGI4
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 300
ADDRGP4 BotModelMinsMaxs
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 300
INDIRI4
ASGNI4
line 7302
;7302:				if (entitynum) {
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $2913
line 7304
;7303:					//NOTE: BotGetActivateGoal already checks if the door is open or not
;7304:					bspent = BotGetActivateGoal(bs, entitynum, &activategoal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 48
ARGP4
ADDRLP4 304
ADDRGP4 BotGetActivateGoal
CALLI4
ASGNI4
ADDRLP4 44
ADDRLP4 304
INDIRI4
ASGNI4
line 7305
;7305:					if (bspent) {
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $2913
line 7307
;7306:						//
;7307:						if (bs->activatestack && !bs->activatestack->inuse)
ADDRLP4 308
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 308
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2925
ADDRLP4 308
INDIRP4
CNSTI4 12448
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $2925
line 7308
;7308:							bs->activatestack = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 12448
ADDP4
CNSTP4 0
ASGNP4
LABELV $2925
line 7310
;7309:						// if not already trying to activate this entity
;7310:						if (!BotIsGoingToActivateEntity(bs, activategoal.goal.entitynum)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 48+4+40
INDIRI4
ARGI4
ADDRLP4 312
ADDRGP4 BotIsGoingToActivateEntity
CALLI4
ASGNI4
ADDRLP4 312
INDIRI4
CNSTI4 0
NEI4 $2927
line 7314
;7311:							//
;7312:							//BotAI_Print(PRT_MESSAGE, "blocked by mover model %d, entity %d ?\n", modelnum, entitynum);
;7313:							//
;7314:							BotGoForActivateGoal(bs, &activategoal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 48
ARGP4
ADDRGP4 BotGoForActivateGoal
CALLI4
pop
line 7315
;7315:							return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2906
JUMPV
LABELV $2927
line 7317
;7316:						}
;7317:						else {
line 7319
;7318:							// enable any routing areas that were disabled
;7319:							BotEnableActivateGoalAreas(&activategoal, qtrue);
ADDRLP4 48
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BotEnableActivateGoalAreas
CALLV
pop
line 7320
;7320:						}
line 7321
;7321:					}
line 7322
;7322:				}
line 7323
;7323:			}
line 7324
;7324:		}
line 7325
;7325:	}
ADDRGP4 $2913
JUMPV
LABELV $2912
line 7326
;7326:	else if (route.stopevent & RSE_USETRAVELTYPE) {
ADDRLP4 0+16
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $2931
line 7327
;7327:		if (route.endtravelflags & TFL_BRIDGE) {
ADDRLP4 0+24
INDIRI4
CNSTI4 67108864
BANDI4
CNSTI4 0
EQI4 $2934
line 7329
;7328:			//FIXME: check if the bridge is available to travel over
;7329:		}
LABELV $2934
line 7330
;7330:	}
LABELV $2931
LABELV $2913
line 7331
;7331:	return qfalse;
CNSTI4 0
RETI4
LABELV $2906
endproc BotAIPredictObstacles 316 44
export BotCheckConsoleMessages
proc BotCheckConsoleMessages 284 8
line 7339
;7332:}
;7333:
;7334:/*
;7335:==================
;7336:BotCheckConsoleMessages
;7337:==================
;7338:*/
;7339:void BotCheckConsoleMessages(bot_state_t *bs) {
ADDRGP4 $2939
JUMPV
LABELV $2938
line 7354
;7340:#if 0	// JUHOX: no bot chats
;7341:	char botname[MAX_NETNAME], message[MAX_MESSAGE_SIZE], netname[MAX_NETNAME], *ptr;
;7342:	float chat_reply;
;7343:	int context, handle;
;7344:	bot_consolemessage_t m;
;7345:	bot_match_t match;
;7346:
;7347:	//the name of this bot
;7348:	ClientName(bs->client, botname, sizeof(botname));
;7349:#else
;7350:	int handle;
;7351:	bot_consolemessage_t m;
;7352:#endif
;7353:	//
;7354:	while((handle = trap_BotNextConsoleMessage(bs->cs, &m)) != 0) {
line 7440
;7355:#if 0	// JUHOX: no bot chats
;7356:		//if the chat state is flooded with messages the bot will read them quickly
;7357:		if (trap_BotNumConsoleMessages(bs->cs) < 10) {
;7358:			//if it is a chat message the bot needs some time to read it
;7359:			if (m.type == CMS_CHAT && m.time > FloatTime() - (1 + random())) break;
;7360:		}
;7361:		//
;7362:		ptr = m.message;
;7363:		//if it is a chat message then don't unify white spaces and don't
;7364:		//replace synonyms in the netname
;7365:		if (m.type == CMS_CHAT) {
;7366:			//
;7367:			if (trap_BotFindMatch(m.message, &match, MTCONTEXT_REPLYCHAT)) {
;7368:				ptr = m.message + match.variables[MESSAGE].offset;
;7369:			}
;7370:		}
;7371:		//unify the white spaces in the message
;7372:		trap_UnifyWhiteSpaces(ptr);
;7373:		//replace synonyms in the right context
;7374:		context = BotSynonymContext(bs);
;7375:		trap_BotReplaceSynonyms(ptr, context);
;7376:		//if there's no match
;7377:		if (!BotMatchMessage(bs, m.message)) {
;7378:			//if it is a chat message
;7379:			if (m.type == CMS_CHAT && !bot_nochat.integer) {
;7380:				//
;7381:				if (!trap_BotFindMatch(m.message, &match, MTCONTEXT_REPLYCHAT)) {
;7382:					trap_BotRemoveConsoleMessage(bs->cs, handle);
;7383:					continue;
;7384:				}
;7385:				//don't use eliza chats with team messages
;7386:				if (match.subtype & ST_TEAM) {
;7387:					trap_BotRemoveConsoleMessage(bs->cs, handle);
;7388:					continue;
;7389:				}
;7390:				//
;7391:				trap_BotMatchVariable(&match, NETNAME, netname, sizeof(netname));
;7392:				trap_BotMatchVariable(&match, MESSAGE, message, sizeof(message));
;7393:				//if this is a message from the bot self
;7394:				if (bs->client == ClientFromName(netname)) {
;7395:					trap_BotRemoveConsoleMessage(bs->cs, handle);
;7396:					continue;
;7397:				}
;7398:				//unify the message
;7399:				trap_UnifyWhiteSpaces(message);
;7400:				//
;7401:				trap_Cvar_Update(&bot_testrchat);
;7402:				if (bot_testrchat.integer) {
;7403:					//
;7404:					trap_BotLibVarSet("bot_testrchat", "1");
;7405:					//if bot replies with a chat message
;7406:					if (trap_BotReplyChat(bs->cs, message, context, CONTEXT_REPLY,
;7407:															NULL, NULL,
;7408:															NULL, NULL,
;7409:															NULL, NULL,
;7410:															botname, netname)) {
;7411:						BotAI_Print(PRT_MESSAGE, "------------------------\n");
;7412:					}
;7413:					else {
;7414:						BotAI_Print(PRT_MESSAGE, "**** no valid reply ****\n");
;7415:					}
;7416:				}
;7417:				//if at a valid chat position and not chatting already and not in teamplay
;7418:				else if (bs->ainode != AINode_Stand && BotValidChatPosition(bs) && !TeamPlayIsOn()) {
;7419:					chat_reply = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_REPLY, 0, 1);
;7420:					if (random() < 1.5 / (NumBots()+1) && random() < chat_reply) {
;7421:						//if bot replies with a chat message
;7422:						if (trap_BotReplyChat(bs->cs, message, context, CONTEXT_REPLY,
;7423:																NULL, NULL,
;7424:																NULL, NULL,
;7425:																NULL, NULL,
;7426:																botname, netname)) {
;7427:							//remove the console message
;7428:							trap_BotRemoveConsoleMessage(bs->cs, handle);
;7429:							bs->stand_time = FloatTime() + BotChatTime(bs);
;7430:							AIEnter_Stand(bs, "BotCheckConsoleMessages: reply chat");
;7431:							//EA_Say(bs->client, bs->cs.chatmessage);
;7432:							break;
;7433:						}
;7434:					}
;7435:				}
;7436:			}
;7437:		}
;7438:#endif
;7439:		//remove the console message
;7440:		trap_BotRemoveConsoleMessage(bs->cs, handle);
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 trap_BotRemoveConsoleMessage
CALLV
pop
line 7441
;7441:	}
LABELV $2939
line 7354
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 280
ADDRGP4 trap_BotNextConsoleMessage
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 280
INDIRI4
ASGNI4
ADDRLP4 280
INDIRI4
CNSTI4 0
NEI4 $2938
line 7442
;7442:}
LABELV $2937
endproc BotCheckConsoleMessages 284 8
export BotCheckEvents
proc BotCheckEvents 164 12
line 7510
;7443:
;7444:/*
;7445:==================
;7446:BotCheckEvents
;7447:==================
;7448:*/
;7449:// JUHOX BUGFIX (workaround): BotCheckForGrenades() seems to cause crashes
;7450:#if 0
;7451:void BotCheckForGrenades(bot_state_t *bs, entityState_t *state) {
;7452:	// if this is not a grenade
;7453:	if (state->eType != ET_MISSILE || state->weapon != WP_GRENADE_LAUNCHER)
;7454:		return;
;7455:	// try to avoid the grenade
;7456:	trap_BotAddAvoidSpot(bs->ms, state->pos.trBase, 160, AVOID_ALWAYS);
;7457:}
;7458:#endif
;7459:
;7460:#ifdef MISSIONPACK
;7461:/*
;7462:==================
;7463:BotCheckForProxMines
;7464:==================
;7465:*/
;7466:void BotCheckForProxMines(bot_state_t *bs, entityState_t *state) {
;7467:	// if this is not a prox mine
;7468:	if (state->eType != ET_MISSILE || state->weapon != WP_PROX_LAUNCHER)
;7469:		return;
;7470:	// if this prox mine is from someone on our own team
;7471:	if (state->generic1 == BotTeam(bs))
;7472:		return;
;7473:	// if the bot doesn't have a weapon to deactivate the mine
;7474:	if (!(bs->inventory[INVENTORY_PLASMAGUN] > 0 && bs->inventory[INVENTORY_CELLS] > 0) &&
;7475:		!(bs->inventory[INVENTORY_ROCKETLAUNCHER] > 0 && bs->inventory[INVENTORY_ROCKETS] > 0) &&
;7476:		!(bs->inventory[INVENTORY_BFG10K] > 0 && bs->inventory[INVENTORY_BFGAMMO] > 0) ) {
;7477:		return;
;7478:	}
;7479:	// try to avoid the prox mine
;7480:	trap_BotAddAvoidSpot(bs->ms, state->pos.trBase, 160, AVOID_ALWAYS);
;7481:	//
;7482:	if (bs->numproxmines >= MAX_PROXMINES)
;7483:		return;
;7484:	bs->proxmines[bs->numproxmines] = state->number;
;7485:	bs->numproxmines++;
;7486:}
;7487:
;7488:/*
;7489:==================
;7490:BotCheckForKamikazeBody
;7491:==================
;7492:*/
;7493:void BotCheckForKamikazeBody(bot_state_t *bs, entityState_t *state) {
;7494:	// if this entity is not wearing the kamikaze
;7495:	if (!(state->eFlags & EF_KAMIKAZE))
;7496:		return;
;7497:	// if this entity isn't dead
;7498:	if (!(state->eFlags & EF_DEAD))
;7499:		return;
;7500:	//remember this kamikaze body
;7501:	bs->kamikazebody = state->number;
;7502:}
;7503:#endif
;7504:
;7505:/*
;7506:==================
;7507:BotCheckEvents
;7508:==================
;7509:*/
;7510:void BotCheckEvents(bot_state_t *bs, entityState_t *state) {
line 7519
;7511:	int event;
;7512:	char buf[128];
;7513:#ifdef MISSIONPACK
;7514:	aas_entityinfo_t entinfo;
;7515:#endif
;7516:
;7517:	//NOTE: this sucks, we're accessing the gentity_t directly
;7518:	//but there's no other fast way to do it right now
;7519:	if (bs->entityeventTime[state->number] == g_entities[state->number].eventTime) {
ADDRLP4 132
ADDRFP4 4
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
ADDP4
INDIRI4
ADDRLP4 132
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+556
ADDP4
INDIRI4
NEI4 $2942
line 7520
;7520:		return;
ADDRGP4 $2941
JUMPV
LABELV $2942
line 7522
;7521:	}
;7522:	bs->entityeventTime[state->number] = g_entities[state->number].eventTime;
ADDRLP4 136
ADDRFP4 4
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 136
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
ADDP4
ADDRLP4 136
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+556
ADDP4
INDIRI4
ASGNI4
line 7524
;7523:	//if it's an event only entity
;7524:	if (state->eType > ET_EVENTS) {
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 14
LEI4 $2946
line 7525
;7525:		event = (state->eType - ET_EVENTS) & ~EV_EVENT_BITS;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 14
SUBI4
CNSTI4 -769
BANDI4
ASGNI4
line 7526
;7526:	}
ADDRGP4 $2947
JUMPV
LABELV $2946
line 7527
;7527:	else {
line 7528
;7528:		event = state->event & ~EV_EVENT_BITS;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 -769
BANDI4
ASGNI4
line 7529
;7529:	}
LABELV $2947
line 7531
;7530:	//
;7531:	switch(event) {
ADDRLP4 140
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 1
LTI4 $2948
ADDRLP4 140
INDIRI4
CNSTI4 77
GTI4 $2948
ADDRLP4 140
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $2997-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $2997
address $2949
address $2949
address $2949
address $2949
address $2949
address $2949
address $2949
address $2949
address $2949
address $2949
address $2949
address $2949
address $2949
address $2949
address $2949
address $2949
address $2949
address $2949
address $2949
address $2949
address $2949
address $2949
address $2949
address $2949
address $2949
address $2949
address $2949
address $2949
address $2949
address $2949
address $2949
address $2949
address $2949
address $2949
address $2949
address $2949
address $2949
address $2949
address $2948
address $2948
address $2948
address $2982
address $2948
address $2948
address $2948
address $2983
address $2961
address $2969
address $2948
address $2948
address $2948
address $2948
address $2948
address $2948
address $2948
address $2948
address $2948
address $2948
address $2948
address $2948
address $2950
address $2948
address $2948
address $2948
address $2948
address $2948
address $2948
address $2948
address $2948
address $2948
address $2948
address $2948
address $2948
address $2948
address $2948
address $2948
address $2949
code
LABELV $2950
line 7534
;7532:		//client obituary event
;7533:		case EV_OBITUARY:
;7534:		{
line 7537
;7535:			int target, attacker, mod;
;7536:
;7537:			target = state->otherEntityNum;
ADDRLP4 144
ADDRFP4 4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 7538
;7538:			attacker = state->otherEntityNum2;
ADDRLP4 148
ADDRFP4 4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ASGNI4
line 7539
;7539:			mod = state->eventParm;
ADDRLP4 152
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 7541
;7540:			//
;7541:			if (target == bs->client) {
ADDRLP4 144
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $2951
line 7542
;7542:				bs->botdeathtype = mod;
ADDRFP4 0
INDIRP4
CNSTI4 6020
ADDP4
ADDRLP4 152
INDIRI4
ASGNI4
line 7543
;7543:				bs->lastkilledby = attacker;
ADDRFP4 0
INDIRP4
CNSTI4 6016
ADDP4
ADDRLP4 148
INDIRI4
ASGNI4
line 7545
;7544:				//
;7545:				if (target == attacker ||
ADDRLP4 156
ADDRLP4 144
INDIRI4
ASGNI4
ADDRLP4 156
INDIRI4
ADDRLP4 148
INDIRI4
EQI4 $2956
ADDRLP4 156
INDIRI4
CNSTI4 1023
EQI4 $2956
ADDRLP4 156
INDIRI4
CNSTI4 1022
NEI4 $2953
LABELV $2956
line 7547
;7546:					target == ENTITYNUM_NONE ||
;7547:					target == ENTITYNUM_WORLD) bs->botsuicide = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6028
ADDP4
CNSTI4 1
ASGNI4
ADDRGP4 $2954
JUMPV
LABELV $2953
line 7548
;7548:				else bs->botsuicide = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6028
ADDP4
CNSTI4 0
ASGNI4
LABELV $2954
line 7550
;7549:				//
;7550:				bs->num_deaths++;
ADDRLP4 160
ADDRFP4 0
INDIRP4
CNSTI4 6048
ADDP4
ASGNP4
ADDRLP4 160
INDIRP4
ADDRLP4 160
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 7551
;7551:			}
ADDRGP4 $2949
JUMPV
LABELV $2951
line 7553
;7552:			//else if this client was killed by the bot
;7553:			else if (attacker == bs->client) {
ADDRLP4 148
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $2957
line 7554
;7554:				bs->enemydeathtype = mod;
ADDRFP4 0
INDIRP4
CNSTI4 6024
ADDP4
ADDRLP4 152
INDIRI4
ASGNI4
line 7555
;7555:				bs->lastkilledplayer = target;
ADDRFP4 0
INDIRP4
CNSTI4 6012
ADDP4
ADDRLP4 144
INDIRI4
ASGNI4
line 7556
;7556:				bs->killedenemy_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7260
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 7558
;7557:				//
;7558:				bs->num_kills++;
ADDRLP4 156
ADDRFP4 0
INDIRP4
CNSTI4 6052
ADDP4
ASGNP4
ADDRLP4 156
INDIRP4
ADDRLP4 156
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 7559
;7559:			}
ADDRGP4 $2949
JUMPV
LABELV $2957
line 7560
;7560:			else if (attacker == bs->enemy && target == attacker) {
ADDRLP4 156
ADDRLP4 148
INDIRI4
ASGNI4
ADDRLP4 156
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 7764
ADDP4
INDIRI4
NEI4 $2949
ADDRLP4 144
INDIRI4
ADDRLP4 156
INDIRI4
NEI4 $2949
line 7561
;7561:				bs->enemysuicide = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6032
ADDP4
CNSTI4 1
ASGNI4
line 7562
;7562:			}
line 7576
;7563:			//
;7564:#ifdef MISSIONPACK			
;7565:			if (gametype == GT_1FCTF) {
;7566:				//
;7567:				BotEntityInfo(target, &entinfo);
;7568:				if ( entinfo.powerups & ( 1 << PW_NEUTRALFLAG ) ) {
;7569:					if (!BotSameTeam(bs, target)) {
;7570:						bs->neutralflagstatus = 3;	//enemy dropped the flag
;7571:						bs->flagstatuschanged = qtrue;
;7572:					}
;7573:				}
;7574:			}
;7575:#endif
;7576:			break;
ADDRGP4 $2949
JUMPV
LABELV $2961
line 7579
;7577:		}
;7578:		case EV_GLOBAL_SOUND:
;7579:		{
line 7580
;7580:			if (state->eventParm < 0 || state->eventParm > MAX_SOUNDS) {
ADDRLP4 144
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 144
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
LTI4 $2964
ADDRLP4 144
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 256
LEI4 $2962
LABELV $2964
line 7581
;7581:				BotAI_Print(PRT_ERROR, "EV_GLOBAL_SOUND: eventParm (%d) out of range\n", state->eventParm);
CNSTI4 3
ARGI4
ADDRGP4 $2965
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 7582
;7582:				break;
ADDRGP4 $2949
JUMPV
LABELV $2962
line 7584
;7583:			}
;7584:			trap_GetConfigstring(CS_SOUNDS + state->eventParm, buf, sizeof(buf));
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 288
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 7604
;7585:			/*
;7586:			if (!strcmp(buf, "sound/teamplay/flagret_red.wav")) {
;7587:				//red flag is returned
;7588:				bs->redflagstatus = 0;
;7589:				bs->flagstatuschanged = qtrue;
;7590:			}
;7591:			else if (!strcmp(buf, "sound/teamplay/flagret_blu.wav")) {
;7592:				//blue flag is returned
;7593:				bs->blueflagstatus = 0;
;7594:				bs->flagstatuschanged = qtrue;
;7595:			}
;7596:			else*/
;7597:#ifdef MISSIONPACK
;7598:			if (!strcmp(buf, "sound/items/kamikazerespawn.wav" )) {
;7599:				//the kamikaze respawned so dont avoid it
;7600:				BotDontAvoid(bs, "Kamikaze");
;7601:			}
;7602:			else
;7603:#endif
;7604:				if (!strcmp(buf, "sound/items/poweruprespawn.wav")) {
ADDRLP4 4
ARGP4
ADDRGP4 $2968
ARGP4
ADDRLP4 148
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $2949
line 7606
;7605:				//powerup respawned... go get it
;7606:				BotGoForPowerups(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotGoForPowerups
CALLV
pop
line 7607
;7607:			}
line 7608
;7608:			break;
ADDRGP4 $2949
JUMPV
LABELV $2969
line 7611
;7609:		}
;7610:		case EV_GLOBAL_TEAM_SOUND:
;7611:		{
line 7612
;7612:			if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $2949
line 7613
;7613:				switch(state->eventParm) {
ADDRLP4 144
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
LTI4 $2949
ADDRLP4 144
INDIRI4
CNSTI4 5
GTI4 $2949
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $2981
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $2981
address $2975
address $2976
address $2977
address $2978
address $2979
address $2980
code
LABELV $2975
line 7615
;7614:					case GTS_RED_CAPTURE:
;7615:						bs->blueflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11896
ADDP4
CNSTI4 0
ASGNI4
line 7616
;7616:						bs->redflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11892
ADDP4
CNSTI4 0
ASGNI4
line 7617
;7617:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 11904
ADDP4
CNSTI4 1
ASGNI4
line 7618
;7618:						break; //see BotMatch_CTF
ADDRGP4 $2949
JUMPV
LABELV $2976
line 7620
;7619:					case GTS_BLUE_CAPTURE:
;7620:						bs->blueflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11896
ADDP4
CNSTI4 0
ASGNI4
line 7621
;7621:						bs->redflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11892
ADDP4
CNSTI4 0
ASGNI4
line 7622
;7622:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 11904
ADDP4
CNSTI4 1
ASGNI4
line 7623
;7623:						break; //see BotMatch_CTF
ADDRGP4 $2949
JUMPV
LABELV $2977
line 7626
;7624:					case GTS_RED_RETURN:
;7625:						//blue flag is returned
;7626:						bs->blueflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11896
ADDP4
CNSTI4 0
ASGNI4
line 7627
;7627:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 11904
ADDP4
CNSTI4 1
ASGNI4
line 7628
;7628:						break;
ADDRGP4 $2949
JUMPV
LABELV $2978
line 7631
;7629:					case GTS_BLUE_RETURN:
;7630:						//red flag is returned
;7631:						bs->redflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11892
ADDP4
CNSTI4 0
ASGNI4
line 7632
;7632:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 11904
ADDP4
CNSTI4 1
ASGNI4
line 7633
;7633:						break;
ADDRGP4 $2949
JUMPV
LABELV $2979
line 7636
;7634:					case GTS_RED_TAKEN:
;7635:						//blue flag is taken
;7636:						bs->blueflagstatus = 1;
ADDRFP4 0
INDIRP4
CNSTI4 11896
ADDP4
CNSTI4 1
ASGNI4
line 7637
;7637:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 11904
ADDP4
CNSTI4 1
ASGNI4
line 7638
;7638:						break; //see BotMatch_CTF
ADDRGP4 $2949
JUMPV
LABELV $2980
line 7641
;7639:					case GTS_BLUE_TAKEN:
;7640:						//red flag is taken
;7641:						bs->redflagstatus = 1;
ADDRFP4 0
INDIRP4
CNSTI4 11892
ADDP4
CNSTI4 1
ASGNI4
line 7642
;7642:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 11904
ADDP4
CNSTI4 1
ASGNI4
line 7643
;7643:						break; //see BotMatch_CTF
line 7645
;7644:				}
;7645:			}
line 7678
;7646:#ifdef MISSIONPACK
;7647:			else if (gametype == GT_1FCTF) {
;7648:				switch(state->eventParm) {
;7649:					case GTS_RED_CAPTURE:
;7650:						bs->neutralflagstatus = 0;
;7651:						bs->flagstatuschanged = qtrue;
;7652:						break;
;7653:					case GTS_BLUE_CAPTURE:
;7654:						bs->neutralflagstatus = 0;
;7655:						bs->flagstatuschanged = qtrue;
;7656:						break;
;7657:					case GTS_RED_RETURN:
;7658:						//flag has returned
;7659:						bs->neutralflagstatus = 0;
;7660:						bs->flagstatuschanged = qtrue;
;7661:						break;
;7662:					case GTS_BLUE_RETURN:
;7663:						//flag has returned
;7664:						bs->neutralflagstatus = 0;
;7665:						bs->flagstatuschanged = qtrue;
;7666:						break;
;7667:					case GTS_RED_TAKEN:
;7668:						bs->neutralflagstatus = BotTeam(bs) == TEAM_RED ? 2 : 1; //FIXME: check Team_TakeFlagSound in g_team.c
;7669:						bs->flagstatuschanged = qtrue;
;7670:						break;
;7671:					case GTS_BLUE_TAKEN:
;7672:						bs->neutralflagstatus = BotTeam(bs) == TEAM_BLUE ? 2 : 1; //FIXME: check Team_TakeFlagSound in g_team.c
;7673:						bs->flagstatuschanged = qtrue;
;7674:						break;
;7675:				}
;7676:			}
;7677:#endif
;7678:			break;
ADDRGP4 $2949
JUMPV
LABELV $2982
line 7681
;7679:		}
;7680:		case EV_PLAYER_TELEPORT_IN:
;7681:		{
line 7682
;7682:			VectorCopy(state->origin, lastteleport_origin);
ADDRGP4 lastteleport_origin
ADDRFP4 4
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 7683
;7683:			lastteleport_time = FloatTime();
ADDRGP4 lastteleport_time
ADDRGP4 floattime
INDIRF4
ASGNF4
line 7684
;7684:			break;
ADDRGP4 $2949
JUMPV
LABELV $2983
line 7687
;7685:		}
;7686:		case EV_GENERAL_SOUND:
;7687:		{
line 7689
;7688:			//if this sound is played on the bot
;7689:			if (state->number == bs->client) {
ADDRFP4 4
INDIRP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $2949
line 7690
;7690:				if (state->eventParm < 0 || state->eventParm > MAX_SOUNDS) {
ADDRLP4 144
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 144
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
LTI4 $2988
ADDRLP4 144
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 256
LEI4 $2986
LABELV $2988
line 7691
;7691:					BotAI_Print(PRT_ERROR, "EV_GENERAL_SOUND: eventParm (%d) out of range\n", state->eventParm);
CNSTI4 3
ARGI4
ADDRGP4 $2989
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 7692
;7692:					break;
ADDRGP4 $2949
JUMPV
LABELV $2986
line 7695
;7693:				}
;7694:				//check out the sound
;7695:				trap_GetConfigstring(CS_SOUNDS + state->eventParm, buf, sizeof(buf));
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 288
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 7697
;7696:				//if falling into a death pit
;7697:				if (!strcmp(buf, "*falling1.wav")) {
ADDRLP4 4
ARGP4
ADDRGP4 $2992
ARGP4
ADDRLP4 148
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $2949
line 7699
;7698:					//if the bot has a personal teleporter
;7699:					if (bs->inventory[INVENTORY_TELEPORTER] > 0) {
ADDRFP4 0
INDIRP4
CNSTI4 5080
ADDP4
INDIRI4
CNSTI4 0
LEI4 $2949
line 7701
;7700:						//use the holdable item
;7701:						trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 7702
;7702:					}
line 7703
;7703:				}
line 7704
;7704:			}
line 7705
;7705:			break;
line 7732
;7706:		}
;7707:		case EV_FOOTSTEP:
;7708:		case EV_FOOTSTEP_METAL:
;7709:		case EV_FOOTSPLASH:
;7710:		case EV_FOOTWADE:
;7711:		case EV_SWIM:
;7712:		case EV_FALL_SHORT:
;7713:		case EV_FALL_MEDIUM:
;7714:		case EV_FALL_FAR:
;7715:		case EV_STEP_4:
;7716:		case EV_STEP_8:
;7717:		case EV_STEP_12:
;7718:		case EV_STEP_16:
;7719:		case EV_JUMP_PAD:
;7720:		case EV_JUMP:
;7721:		case EV_TAUNT:
;7722:		case EV_WATER_TOUCH:
;7723:		case EV_WATER_LEAVE:
;7724:		case EV_WATER_UNDER:
;7725:		case EV_WATER_CLEAR:
;7726:		case EV_ITEM_PICKUP:
;7727:		case EV_GLOBAL_ITEM_PICKUP:
;7728:		case EV_NOAMMO:
;7729:		case EV_CHANGE_WEAPON:
;7730:		case EV_FIRE_WEAPON:
;7731:			//FIXME: either add to sound queue or mark player as someone making noise
;7732:			break;
line 7748
;7733:		case EV_USE_ITEM0:
;7734:		case EV_USE_ITEM1:
;7735:		case EV_USE_ITEM2:
;7736:		case EV_USE_ITEM3:
;7737:		case EV_USE_ITEM4:
;7738:		case EV_USE_ITEM5:
;7739:		case EV_USE_ITEM6:
;7740:		case EV_USE_ITEM7:
;7741:		case EV_USE_ITEM8:
;7742:		case EV_USE_ITEM9:
;7743:		case EV_USE_ITEM10:
;7744:		case EV_USE_ITEM11:
;7745:		case EV_USE_ITEM12:
;7746:		case EV_USE_ITEM13:
;7747:		case EV_USE_ITEM14:
;7748:			break;
LABELV $2948
LABELV $2949
line 7750
;7749:	}
;7750:}
LABELV $2941
endproc BotCheckEvents 164 12
export BotCheckSnapshot
proc BotCheckSnapshot 216 16
line 7757
;7751:
;7752:/*
;7753:==================
;7754:BotCheckSnapshot
;7755:==================
;7756:*/
;7757:void BotCheckSnapshot(bot_state_t *bs) {
line 7762
;7758:	int ent;
;7759:	entityState_t state;
;7760:
;7761:	//remove all avoid spots
;7762:	trap_BotAddAvoidSpot(bs->ms, vec3_origin, 0, AVOID_CLEAR);
ADDRFP4 0
INDIRP4
CNSTI4 7724
ADDP4
INDIRI4
ARGI4
ADDRGP4 vec3_origin
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotAddAvoidSpot
CALLV
pop
line 7764
;7763:	//reset kamikaze body
;7764:	bs->kamikazebody = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7456
ADDP4
CNSTI4 0
ASGNI4
line 7766
;7765:	//reset number of proxmines
;7766:	bs->numproxmines = 0;
ADDRFP4 0
INDIRP4
CNSTI4 7716
ADDP4
CNSTI4 0
ASGNI4
line 7768
;7767:	//
;7768:	ent = 0;
ADDRLP4 208
CNSTI4 0
ASGNI4
ADDRGP4 $3001
JUMPV
LABELV $3000
line 7769
;7769:	while( ( ent = BotAI_GetSnapshotEntity( bs->client, ent, &state ) ) != -1 ) {
line 7771
;7770:		//check the entity state for events
;7771:		BotCheckEvents(bs, &state);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotCheckEvents
CALLV
pop
line 7784
;7772:		// JUHOX BUGFIX (workaround): there seems to be a bug in the 'trap_BotAddAvoidSpot()' code
;7773:#if 0
;7774:		//check for grenades the bot should avoid
;7775:		BotCheckForGrenades(bs, &state);
;7776:#endif
;7777:		//
;7778:#ifdef MISSIONPACK
;7779:		//check for proximity mines which the bot should deactivate
;7780:		BotCheckForProxMines(bs, &state);
;7781:		//check for dead bodies with the kamikaze effect which should be gibbed
;7782:		BotCheckForKamikazeBody(bs, &state);
;7783:#endif
;7784:	}
LABELV $3001
line 7769
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 208
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 212
ADDRGP4 BotAI_GetSnapshotEntity
CALLI4
ASGNI4
ADDRLP4 208
ADDRLP4 212
INDIRI4
ASGNI4
ADDRLP4 212
INDIRI4
CNSTI4 -1
NEI4 $3000
line 7786
;7785:	//check the player state for events
;7786:	BotAI_GetEntityState(bs->client, &state);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotAI_GetEntityState
CALLI4
pop
line 7788
;7787:	//copy the player state events to the entity state
;7788:	state.event = bs->cur_ps.externalEvent;
ADDRLP4 0+180
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ASGNI4
line 7789
;7789:	state.eventParm = bs->cur_ps.externalEventParm;
ADDRLP4 0+184
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ASGNI4
line 7791
;7790:	//
;7791:	BotCheckEvents(bs, &state);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotCheckEvents
CALLV
pop
line 7792
;7792:}
LABELV $2999
endproc BotCheckSnapshot 216 16
export BotCheckAir
proc BotCheckAir 4 4
line 7799
;7793:
;7794:/*
;7795:==================
;7796:BotCheckAir
;7797:==================
;7798:*/
;7799:void BotCheckAir(bot_state_t *bs) {
line 7808
;7800:	// JUHOX: new air-out condition
;7801:#if 0
;7802:	if (bs->inventory[INVENTORY_ENVIRONMENTSUIT] <= 0) {
;7803:		if (trap_AAS_PointContents(bs->eye) & (CONTENTS_WATER|CONTENTS_SLIME|CONTENTS_LAVA)) {
;7804:			return;
;7805:		}
;7806:	}
;7807:#else
;7808:	if (bs->cur_ps.stats[STAT_STRENGTH] <= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
GTI4 $3006
line 7809
;7809:		if (trap_AAS_PointContents(bs->eye) & (CONTENTS_WATER|CONTENTS_SLIME|CONTENTS_LAVA)) {
ADDRFP4 0
INDIRP4
CNSTI4 4944
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 trap_AAS_PointContents
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $3008
line 7810
;7810:			return;
ADDRGP4 $3005
JUMPV
LABELV $3008
line 7812
;7811:		}
;7812:	}
LABELV $3006
line 7814
;7813:#endif
;7814:	bs->lastair_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7268
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 7815
;7815:}
LABELV $3005
endproc BotCheckAir 4 4
export BotAlternateRoute
proc BotAlternateRoute 0 0
line 7822
;7816:
;7817:/*
;7818:==================
;7819:BotAlternateRoute
;7820:==================
;7821:*/
;7822:bot_goal_t *BotAlternateRoute(bot_state_t *bs, bot_goal_t *goal) {
line 7842
;7823:	// JUHOX: currently no alternate routes available
;7824:#if 0
;7825:	int t;
;7826:
;7827:	// if the bot has an alternative route goal
;7828:	if (bs->altroutegoal.areanum) {
;7829:		//
;7830:		if (bs->reachedaltroutegoal_time)
;7831:			return goal;
;7832:		// travel time towards alternative route goal
;7833:		t = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, bs->altroutegoal.areanum, bs->tfl);
;7834:		if (t && t < 20) {
;7835:			//BotAI_Print(PRT_MESSAGE, "reached alternate route goal\n");
;7836:			bs->reachedaltroutegoal_time = FloatTime();
;7837:		}
;7838:		memcpy(goal, &bs->altroutegoal, sizeof(bot_goal_t));
;7839:		return &bs->altroutegoal;
;7840:	}
;7841:#endif
;7842:	return goal;
ADDRFP4 4
INDIRP4
RETP4
LABELV $3010
endproc BotAlternateRoute 0 0
export BotGetAlternateRouteGoal
proc BotGetAlternateRouteGoal 20 0
line 7850
;7843:}
;7844:
;7845:/*
;7846:==================
;7847:BotGetAlternateRouteGoal
;7848:==================
;7849:*/
;7850:int BotGetAlternateRouteGoal(bot_state_t *bs, int base) {
line 7855
;7851:	aas_altroutegoal_t *altroutegoals;
;7852:	bot_goal_t *goal;
;7853:	int numaltroutegoals, rnd;
;7854:
;7855:	if (base == TEAM_RED) {
ADDRFP4 4
INDIRI4
CNSTI4 1
NEI4 $3012
line 7856
;7856:		altroutegoals = red_altroutegoals;
ADDRLP4 12
ADDRGP4 red_altroutegoals
ASGNP4
line 7857
;7857:		numaltroutegoals = red_numaltroutegoals;
ADDRLP4 4
ADDRGP4 red_numaltroutegoals
INDIRI4
ASGNI4
line 7858
;7858:	}
ADDRGP4 $3013
JUMPV
LABELV $3012
line 7859
;7859:	else {
line 7860
;7860:		altroutegoals = blue_altroutegoals;
ADDRLP4 12
ADDRGP4 blue_altroutegoals
ASGNP4
line 7861
;7861:		numaltroutegoals = blue_numaltroutegoals;
ADDRLP4 4
ADDRGP4 blue_numaltroutegoals
INDIRI4
ASGNI4
line 7862
;7862:	}
LABELV $3013
line 7863
;7863:	if (!numaltroutegoals)
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $3014
line 7864
;7864:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3011
JUMPV
LABELV $3014
line 7865
;7865:	rnd = (float) random() * numaltroutegoals;
ADDRLP4 16
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 8
ADDRLP4 16
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 16
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
ADDRLP4 4
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ASGNI4
line 7866
;7866:	if (rnd >= numaltroutegoals)
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $3016
line 7867
;7867:		rnd = numaltroutegoals-1;
ADDRLP4 8
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $3016
line 7868
;7868:	goal = &bs->altroutegoal;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 11636
ADDP4
ASGNP4
line 7869
;7869:	goal->areanum = altroutegoals[rnd].areanum;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 24
MULI4
ADDRLP4 12
INDIRP4
ADDP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 7870
;7870:	VectorCopy(altroutegoals[rnd].origin, goal->origin);
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
CNSTI4 24
MULI4
ADDRLP4 12
INDIRP4
ADDP4
INDIRB
ASGNB 12
line 7871
;7871:	VectorSet(goal->mins, -8, -8, -8);
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 3238002688
ASGNF4
line 7872
;7872:	VectorSet(goal->maxs, 8, 8, 8);
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 1090519040
ASGNF4
line 7873
;7873:	goal->entitynum = 0;
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
CNSTI4 0
ASGNI4
line 7874
;7874:	goal->iteminfo = 0;
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 7875
;7875:	goal->number = 0;
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 0
ASGNI4
line 7876
;7876:	goal->flags = 0;
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 7878
;7877:	//
;7878:	bs->reachedaltroutegoal_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 11692
ADDP4
CNSTF4 0
ASGNF4
line 7879
;7879:	return qtrue;
CNSTI4 1
RETI4
LABELV $3011
endproc BotGetAlternateRouteGoal 20 0
export BotSetupAlternativeRouteGoals
proc BotSetupAlternativeRouteGoals 0 0
line 7887
;7880:}
;7881:
;7882:/*
;7883:==================
;7884:BotSetupAlternateRouteGoals
;7885:==================
;7886:*/
;7887:void BotSetupAlternativeRouteGoals(void) {
line 7889
;7888:
;7889:	if (altroutegoals_setup)
ADDRGP4 altroutegoals_setup
INDIRI4
CNSTI4 0
EQI4 $3019
line 7890
;7890:		return;
ADDRGP4 $3018
JUMPV
LABELV $3019
line 7959
;7891:#ifdef MISSIONPACK
;7892:	if (gametype == GT_CTF) {
;7893:		if (trap_BotGetLevelItemGoal(-1, "Neutral Flag", &ctf_neutralflag) < 0)
;7894:			BotAI_Print(PRT_WARNING, "no alt routes without Neutral Flag\n");
;7895:		if (ctf_neutralflag.areanum) {
;7896:			//
;7897:			red_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
;7898:										ctf_neutralflag.origin, ctf_neutralflag.areanum,
;7899:										ctf_redflag.origin, ctf_redflag.areanum, TFL_DEFAULT,
;7900:										red_altroutegoals, MAX_ALTROUTEGOALS,
;7901:										ALTROUTEGOAL_CLUSTERPORTALS|
;7902:										ALTROUTEGOAL_VIEWPORTALS);
;7903:			blue_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
;7904:										ctf_neutralflag.origin, ctf_neutralflag.areanum,
;7905:										ctf_blueflag.origin, ctf_blueflag.areanum, TFL_DEFAULT,
;7906:										blue_altroutegoals, MAX_ALTROUTEGOALS,
;7907:										ALTROUTEGOAL_CLUSTERPORTALS|
;7908:										ALTROUTEGOAL_VIEWPORTALS);
;7909:		}
;7910:	}
;7911:	else if (gametype == GT_1FCTF) {
;7912:		//
;7913:		red_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
;7914:									ctf_neutralflag.origin, ctf_neutralflag.areanum,
;7915:									ctf_redflag.origin, ctf_redflag.areanum, TFL_DEFAULT,
;7916:									red_altroutegoals, MAX_ALTROUTEGOALS,
;7917:									ALTROUTEGOAL_CLUSTERPORTALS|
;7918:									ALTROUTEGOAL_VIEWPORTALS);
;7919:		blue_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
;7920:									ctf_neutralflag.origin, ctf_neutralflag.areanum,
;7921:									ctf_blueflag.origin, ctf_blueflag.areanum, TFL_DEFAULT,
;7922:									blue_altroutegoals, MAX_ALTROUTEGOALS,
;7923:									ALTROUTEGOAL_CLUSTERPORTALS|
;7924:									ALTROUTEGOAL_VIEWPORTALS);
;7925:	}
;7926:	else if (gametype == GT_OBELISK) {
;7927:		if (trap_BotGetLevelItemGoal(-1, "Neutral Obelisk", &neutralobelisk) < 0)
;7928:			BotAI_Print(PRT_WARNING, "Harvester without neutral obelisk\n");
;7929:		//
;7930:		red_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
;7931:									neutralobelisk.origin, neutralobelisk.areanum,
;7932:									redobelisk.origin, redobelisk.areanum, TFL_DEFAULT,
;7933:									red_altroutegoals, MAX_ALTROUTEGOALS,
;7934:									ALTROUTEGOAL_CLUSTERPORTALS|
;7935:									ALTROUTEGOAL_VIEWPORTALS);
;7936:		blue_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
;7937:									neutralobelisk.origin, neutralobelisk.areanum,
;7938:									blueobelisk.origin, blueobelisk.areanum, TFL_DEFAULT,
;7939:									blue_altroutegoals, MAX_ALTROUTEGOALS,
;7940:									ALTROUTEGOAL_CLUSTERPORTALS|
;7941:									ALTROUTEGOAL_VIEWPORTALS);
;7942:	}
;7943:	else if (gametype == GT_HARVESTER) {
;7944:		//
;7945:		red_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
;7946:									neutralobelisk.origin, neutralobelisk.areanum,
;7947:									redobelisk.origin, redobelisk.areanum, TFL_DEFAULT,
;7948:									red_altroutegoals, MAX_ALTROUTEGOALS,
;7949:									ALTROUTEGOAL_CLUSTERPORTALS|
;7950:									ALTROUTEGOAL_VIEWPORTALS);
;7951:		blue_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
;7952:									neutralobelisk.origin, neutralobelisk.areanum,
;7953:									blueobelisk.origin, blueobelisk.areanum, TFL_DEFAULT,
;7954:									blue_altroutegoals, MAX_ALTROUTEGOALS,
;7955:									ALTROUTEGOAL_CLUSTERPORTALS|
;7956:									ALTROUTEGOAL_VIEWPORTALS);
;7957:	}
;7958:#endif
;7959:	altroutegoals_setup = qtrue;
ADDRGP4 altroutegoals_setup
CNSTI4 1
ASGNI4
line 7960
;7960:}
LABELV $3018
endproc BotSetupAlternativeRouteGoals 0 0
export BotDeathmatchAI
proc BotDeathmatchAI 1492 20
line 7967
;7961:
;7962:/*
;7963:==================
;7964:BotDeathmatchAI
;7965:==================
;7966:*/
;7967:void BotDeathmatchAI(bot_state_t *bs, float thinktime) {
line 7973
;7968:	char gender[144], name[144], buf[144];
;7969:	char userinfo[MAX_INFO_STRING];
;7970:	int i;
;7971:
;7972:	//if the bot has just been setup
;7973:	if (bs->setupcount > 0) {
ADDRFP4 0
INDIRP4
CNSTI4 6036
ADDP4
INDIRI4
CNSTI4 0
LEI4 $3022
line 7974
;7974:		bs->setupcount--;
ADDRLP4 1460
ADDRFP4 0
INDIRP4
CNSTI4 6036
ADDP4
ASGNP4
ADDRLP4 1460
INDIRP4
ADDRLP4 1460
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 7975
;7975:		if (bs->setupcount > 0) return;
ADDRFP4 0
INDIRP4
CNSTI4 6036
ADDP4
INDIRI4
CNSTI4 0
LEI4 $3024
ADDRGP4 $3021
JUMPV
LABELV $3024
line 7977
;7976:		//get the gender characteristic
;7977:		trap_Characteristic_String(bs->character, CHARACTERISTIC_GENDER, gender, sizeof(gender));
ADDRFP4 0
INDIRP4
CNSTI4 7720
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 148
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Characteristic_String
CALLV
pop
line 7979
;7978:		//set the bot gender
;7979:		trap_GetUserinfo(bs->client, userinfo, sizeof(userinfo));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 7980
;7980:		Info_SetValueForKey(userinfo, "sex", gender);
ADDRLP4 292
ARGP4
ADDRGP4 $3026
ARGP4
ADDRLP4 148
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 7981
;7981:		trap_SetUserinfo(bs->client, userinfo);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
ARGP4
ADDRGP4 trap_SetUserinfo
CALLV
pop
line 7983
;7982:		//set the team
;7983:		if ( !bs->map_restart && g_gametype.integer != GT_TOURNAMENT ) {
ADDRFP4 0
INDIRP4
CNSTI4 6040
ADDP4
INDIRI4
CNSTI4 0
NEI4 $3027
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
EQI4 $3027
line 7984
;7984:			Com_sprintf(buf, sizeof(buf), "team %s", bs->settings.team);
ADDRLP4 1316
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 $3030
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 4756
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 7985
;7985:			trap_EA_Command(bs->client, buf);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 1316
ARGP4
ADDRGP4 trap_EA_Command
CALLV
pop
line 7986
;7986:		}
LABELV $3027
line 7988
;7987:		//set the chat gender
;7988:		if (gender[0] == 'm') trap_BotSetChatGender(bs->cs, CHAT_GENDERMALE);
ADDRLP4 148
INDIRI1
CVII4 1
CNSTI4 109
NEI4 $3031
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotSetChatGender
CALLV
pop
ADDRGP4 $3032
JUMPV
LABELV $3031
line 7989
;7989:		else if (gender[0] == 'f')  trap_BotSetChatGender(bs->cs, CHAT_GENDERFEMALE);
ADDRLP4 148
INDIRI1
CVII4 1
CNSTI4 102
NEI4 $3033
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotSetChatGender
CALLV
pop
ADDRGP4 $3034
JUMPV
LABELV $3033
line 7990
;7990:		else  trap_BotSetChatGender(bs->cs, CHAT_GENDERLESS);
ADDRFP4 0
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotSetChatGender
CALLV
pop
LABELV $3034
LABELV $3032
line 7992
;7991:		//set the chat name
;7992:		ClientName(bs->client, name, sizeof(name));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 7993
;7993:		trap_BotSetChatName(bs->cs, name, bs->client);
ADDRLP4 1464
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1464
INDIRP4
CNSTI4 7756
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 1464
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotSetChatName
CALLV
pop
line 7995
;7994:		//
;7995:		bs->lastframe_health = bs->inventory[INVENTORY_HEALTH];
ADDRLP4 1468
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1468
INDIRP4
CNSTI4 6064
ADDP4
ADDRLP4 1468
INDIRP4
CNSTI4 5076
ADDP4
INDIRI4
ASGNI4
line 7996
;7996:		bs->lasthitcount = bs->cur_ps.persistant[PERS_HITS];
ADDRLP4 1472
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1472
INDIRP4
CNSTI4 6068
ADDP4
ADDRLP4 1472
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
ASGNI4
line 7998
;7997:		//
;7998:		bs->setupcount = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6036
ADDP4
CNSTI4 0
ASGNI4
line 8000
;7999:		//
;8000:		BotSetupAlternativeRouteGoals();
ADDRGP4 BotSetupAlternativeRouteGoals
CALLV
pop
line 8001
;8001:	}
LABELV $3022
line 8003
;8002:	//no ideal view set
;8003:	bs->flags &= ~BFL_IDEALVIEWSET;
ADDRLP4 1460
ADDRFP4 0
INDIRP4
CNSTI4 5992
ADDP4
ASGNP4
ADDRLP4 1460
INDIRP4
ADDRLP4 1460
INDIRP4
INDIRI4
CNSTI4 -33
BANDI4
ASGNI4
line 8005
;8004:	//
;8005:	if (!BotIntermission(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1464
ADDRGP4 BotIntermission
CALLI4
ASGNI4
ADDRLP4 1464
INDIRI4
CNSTI4 0
NEI4 $3035
line 8007
;8006:		//set the teleport time
;8007:		BotSetTeleportTime(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeleportTime
CALLV
pop
line 8009
;8008:		//update some inventory values
;8009:		BotUpdateInventory(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotUpdateInventory
CALLV
pop
line 8011
;8010:		//check out the snapshot
;8011:		BotCheckSnapshot(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCheckSnapshot
CALLV
pop
line 8013
;8012:		//check for air
;8013:		BotCheckAir(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCheckAir
CALLV
pop
line 8014
;8014:		if (bs->weaponchoose_time < FloatTime() - 1) BotChooseWeapon(bs);	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 7304
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
SUBF4
GEF4 $3037
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotChooseWeapon
CALLV
pop
LABELV $3037
line 8015
;8015:	}
LABELV $3035
line 8017
;8016:	//check the console messages
;8017:	BotCheckConsoleMessages(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCheckConsoleMessages
CALLV
pop
line 8019
;8018:	//if not in the intermission and not in observer mode
;8019:	if (!BotIntermission(bs) && !BotIsObserver(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1468
ADDRGP4 BotIntermission
CALLI4
ASGNI4
ADDRLP4 1468
INDIRI4
CNSTI4 0
NEI4 $3039
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1472
ADDRGP4 BotIsObserver
CALLI4
ASGNI4
ADDRLP4 1472
INDIRI4
CNSTI4 0
NEI4 $3039
line 8021
;8020:		//do team AI
;8021:		BotTeamAI(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotTeamAI
CALLV
pop
line 8022
;8022:	}
LABELV $3039
line 8024
;8023:	//if the bot has no ai node
;8024:	if (!bs->ainode) {
ADDRFP4 0
INDIRP4
CNSTI4 4904
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3041
line 8025
;8025:		AIEnter_Seek_LTG(bs, "BotDeathmatchAI: no ai node");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $3043
ARGP4
ADDRGP4 AIEnter_Seek_LTG
CALLV
pop
line 8026
;8026:	}
LABELV $3041
line 8028
;8027:	//if the bot entered the game less than 8 seconds ago
;8028:	if (!bs->entergamechat && bs->entergame_time > FloatTime() - 8) {
ADDRLP4 1476
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1476
INDIRP4
CNSTI4 6044
ADDP4
INDIRI4
CNSTI4 0
NEI4 $3044
ADDRLP4 1476
INDIRP4
CNSTI4 6084
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1090519040
SUBF4
LEF4 $3044
line 8029
;8029:		if (BotChat_EnterGame(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1480
ADDRGP4 BotChat_EnterGame
CALLI4
ASGNI4
ADDRLP4 1480
INDIRI4
CNSTI4 0
EQI4 $3046
line 8030
;8030:			bs->stand_time = FloatTime() + BotChatTime(bs);
ADDRLP4 1484
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1484
INDIRP4
ARGP4
ADDRLP4 1488
ADDRGP4 BotChatTime
CALLF4
ASGNF4
ADDRLP4 1484
INDIRP4
CNSTI4 7188
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 1488
INDIRF4
ADDF4
ASGNF4
line 8031
;8031:			AIEnter_Stand(bs, "BotDeathmatchAI: chat enter game");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $3048
ARGP4
ADDRGP4 AIEnter_Stand
CALLV
pop
line 8032
;8032:		}
LABELV $3046
line 8033
;8033:		bs->entergamechat = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6044
ADDP4
CNSTI4 1
ASGNI4
line 8034
;8034:	}
LABELV $3044
line 8036
;8035:	//reset the node switches from the previous frame
;8036:	BotResetNodeSwitches();
ADDRGP4 BotResetNodeSwitches
CALLV
pop
line 8038
;8037:	//execute AI nodes
;8038:	for (i = 0; i < MAX_NODESWITCHES; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $3049
line 8039
;8039:		if (bs->ainode(bs)) break;
ADDRLP4 1480
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1480
INDIRP4
ARGP4
ADDRLP4 1484
ADDRLP4 1480
INDIRP4
CNSTI4 4904
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 1484
INDIRI4
CNSTI4 0
EQI4 $3053
ADDRGP4 $3051
JUMPV
LABELV $3053
line 8040
;8040:	}
LABELV $3050
line 8038
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 50
LTI4 $3049
LABELV $3051
line 8042
;8041:	//if the bot removed itself :)
;8042:	if (!bs->inuse) return;
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $3055
ADDRGP4 $3021
JUMPV
LABELV $3055
line 8044
;8043:	//if the bot executed too many AI nodes
;8044:	if (i >= MAX_NODESWITCHES) {
ADDRLP4 0
INDIRI4
CNSTI4 50
LTI4 $3057
line 8045
;8045:		trap_BotDumpGoalStack(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotDumpGoalStack
CALLV
pop
line 8046
;8046:		trap_BotDumpAvoidGoals(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 7752
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotDumpAvoidGoals
CALLV
pop
line 8047
;8047:		BotDumpNodeSwitches(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotDumpNodeSwitches
CALLV
pop
line 8048
;8048:		ClientName(bs->client, name, sizeof(name));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 8049
;8049:		BotAI_Print(PRT_ERROR, "%s at %1.1f switched more than %d AI nodes\n", name, FloatTime(), MAX_NODESWITCHES);
CNSTI4 3
ARGI4
ADDRGP4 $3059
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 floattime
INDIRF4
ARGF4
CNSTI4 50
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 8050
;8050:	}
LABELV $3057
line 8052
;8051:	//
;8052:	bs->lastframe_health = bs->inventory[INVENTORY_HEALTH];
ADDRLP4 1480
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1480
INDIRP4
CNSTI4 6064
ADDP4
ADDRLP4 1480
INDIRP4
CNSTI4 5076
ADDP4
INDIRI4
ASGNI4
line 8053
;8053:	bs->lasthitcount = bs->cur_ps.persistant[PERS_HITS];
ADDRLP4 1484
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1484
INDIRP4
CNSTI4 6068
ADDP4
ADDRLP4 1484
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
ASGNI4
line 8054
;8054:}
LABELV $3021
endproc BotDeathmatchAI 1492 20
export BotSetEntityNumForGoalWithModel
proc BotSetEntityNumForGoalWithModel 44 4
line 8061
;8055:
;8056:/*
;8057:==================
;8058:BotSetEntityNumForGoalWithModel
;8059:==================
;8060:*/
;8061:void BotSetEntityNumForGoalWithModel(bot_goal_t *goal, int eType, char *modelname) {
line 8066
;8062:	gentity_t *ent;
;8063:	int i, modelindex;
;8064:	vec3_t dir;
;8065:
;8066:	modelindex = G_ModelIndex( modelname );
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 G_ModelIndex
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 24
INDIRI4
ASGNI4
line 8067
;8067:	ent = &g_entities[0];
ADDRLP4 0
ADDRGP4 g_entities
ASGNP4
line 8068
;8068:	for (i = 0; i < level.num_entities; i++, ent++) {
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRGP4 $3064
JUMPV
LABELV $3061
line 8069
;8069:		if ( !ent->inuse ) {
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $3066
line 8070
;8070:			continue;
ADDRGP4 $3062
JUMPV
LABELV $3066
line 8072
;8071:		}
;8072:		if ( eType && ent->s.eType != eType) {
ADDRLP4 28
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $3068
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 28
INDIRI4
EQI4 $3068
line 8073
;8073:			continue;
ADDRGP4 $3062
JUMPV
LABELV $3068
line 8075
;8074:		}
;8075:		if (ent->s.modelindex != modelindex) {
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ADDRLP4 20
INDIRI4
EQI4 $3070
line 8076
;8076:			continue;
ADDRGP4 $3062
JUMPV
LABELV $3070
line 8078
;8077:		}
;8078:		VectorSubtract(goal->origin, ent->s.origin, dir);
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 32
INDIRP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ASGNF4
line 8079
;8079:		if (VectorLengthSquared(dir) < Square(10)) {
ADDRLP4 4
ARGP4
ADDRLP4 40
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 40
INDIRF4
CNSTF4 1120403456
GEF4 $3074
line 8080
;8080:			goal->entitynum = i;
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 8081
;8081:			return;
ADDRGP4 $3060
JUMPV
LABELV $3074
line 8083
;8082:		}
;8083:	}
LABELV $3062
line 8068
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 844
ADDP4
ASGNP4
LABELV $3064
ADDRLP4 16
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $3061
line 8084
;8084:}
LABELV $3060
endproc BotSetEntityNumForGoalWithModel 44 4
export BotSetEntityNumForGoal
proc BotSetEntityNumForGoal 36 8
line 8091
;8085:
;8086:/*
;8087:==================
;8088:BotSetEntityNumForGoal
;8089:==================
;8090:*/
;8091:void BotSetEntityNumForGoal(bot_goal_t *goal, char *classname) {
line 8096
;8092:	gentity_t *ent;
;8093:	int i;
;8094:	vec3_t dir;
;8095:
;8096:	ent = &g_entities[0];
ADDRLP4 0
ADDRGP4 g_entities
ASGNP4
line 8097
;8097:	for (i = 0; i < level.num_entities; i++, ent++) {
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRGP4 $3080
JUMPV
LABELV $3077
line 8098
;8098:		if ( !ent->inuse ) {
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $3082
line 8099
;8099:			continue;
ADDRGP4 $3078
JUMPV
LABELV $3082
line 8101
;8100:		}
;8101:		if ( !Q_stricmp(ent->classname, classname) ) {
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $3084
line 8102
;8102:			continue;
ADDRGP4 $3078
JUMPV
LABELV $3084
line 8104
;8103:		}
;8104:		VectorSubtract(goal->origin, ent->s.origin, dir);
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ASGNF4
line 8105
;8105:		if (VectorLengthSquared(dir) < Square(10)) {
ADDRLP4 4
ARGP4
ADDRLP4 32
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 32
INDIRF4
CNSTF4 1120403456
GEF4 $3088
line 8106
;8106:			goal->entitynum = i;
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 8107
;8107:			return;
ADDRGP4 $3076
JUMPV
LABELV $3088
line 8109
;8108:		}
;8109:	}
LABELV $3078
line 8097
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 844
ADDP4
ASGNP4
LABELV $3080
ADDRLP4 16
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $3077
line 8110
;8110:}
LABELV $3076
endproc BotSetEntityNumForGoal 36 8
export BotGoalForBSPEntity
proc BotGoalForBSPEntity 1128 20
line 8117
;8111:
;8112:/*
;8113:==================
;8114:BotGoalForBSPEntity
;8115:==================
;8116:*/
;8117:int BotGoalForBSPEntity( char *classname, bot_goal_t *goal ) {
line 8122
;8118:	char value[MAX_INFO_STRING];
;8119:	vec3_t origin, start, end;
;8120:	int ent, numareas, areas[10];
;8121:
;8122:	memset(goal, 0, sizeof(bot_goal_t));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 56
ARGI4
ADDRGP4 memset
CALLP4
pop
line 8123
;8123:	for (ent = trap_AAS_NextBSPEntity(0); ent; ent = trap_AAS_NextBSPEntity(ent)) {
CNSTI4 0
ARGI4
ADDRLP4 1108
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 1108
INDIRI4
ASGNI4
ADDRGP4 $3094
JUMPV
LABELV $3091
line 8124
;8124:		if (!trap_AAS_ValueForBSPEpairKey(ent, "classname", value, sizeof(value)))
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2678
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1112
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 1112
INDIRI4
CNSTI4 0
NEI4 $3095
line 8125
;8125:			continue;
ADDRGP4 $3092
JUMPV
LABELV $3095
line 8126
;8126:		if (!strcmp(value, classname)) {
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1116
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 1116
INDIRI4
CNSTI4 0
NEI4 $3097
line 8127
;8127:			if (!trap_AAS_VectorForBSPEpairKey(ent, "origin", origin))
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2694
ARGP4
ADDRLP4 1028
ARGP4
ADDRLP4 1120
ADDRGP4 trap_AAS_VectorForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 1120
INDIRI4
CNSTI4 0
NEI4 $3099
line 8128
;8128:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3090
JUMPV
LABELV $3099
line 8129
;8129:			VectorCopy(origin, goal->origin);
ADDRFP4 4
INDIRP4
ADDRLP4 1028
INDIRB
ASGNB 12
line 8130
;8130:			VectorCopy(origin, start);
ADDRLP4 1040
ADDRLP4 1028
INDIRB
ASGNB 12
line 8131
;8131:			start[2] -= 32;
ADDRLP4 1040+8
ADDRLP4 1040+8
INDIRF4
CNSTF4 1107296256
SUBF4
ASGNF4
line 8132
;8132:			VectorCopy(origin, end);
ADDRLP4 1052
ADDRLP4 1028
INDIRB
ASGNB 12
line 8133
;8133:			end[2] += 32;
ADDRLP4 1052+8
ADDRLP4 1052+8
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 8134
;8134:			numareas = trap_AAS_TraceAreas(start, end, areas, NULL, 10);
ADDRLP4 1040
ARGP4
ADDRLP4 1052
ARGP4
ADDRLP4 1068
ARGP4
CNSTP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 1124
ADDRGP4 trap_AAS_TraceAreas
CALLI4
ASGNI4
ADDRLP4 1064
ADDRLP4 1124
INDIRI4
ASGNI4
line 8135
;8135:			if (!numareas)
ADDRLP4 1064
INDIRI4
CNSTI4 0
NEI4 $3103
line 8136
;8136:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3090
JUMPV
LABELV $3103
line 8137
;8137:			goal->areanum = areas[0];
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 1068
INDIRI4
ASGNI4
line 8138
;8138:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $3090
JUMPV
LABELV $3097
line 8140
;8139:		}
;8140:	}
LABELV $3092
line 8123
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1112
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 1112
INDIRI4
ASGNI4
LABELV $3094
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $3091
line 8141
;8141:	return qfalse;
CNSTI4 0
RETI4
LABELV $3090
endproc BotGoalForBSPEntity 1128 20
export BotCreateItemGoal
proc BotCreateItemGoal 12 12
line 8149
;8142:}
;8143:
;8144:/*
;8145:==================
;8146:JUHOX: BotCreateItemGoal
;8147:==================
;8148:*/
;8149:void BotCreateItemGoal(gentity_t* ent, bot_goal_t* goal) {
line 8150
;8150:	memset(goal, 0, sizeof(*goal));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 56
ARGI4
ADDRGP4 memset
CALLP4
pop
line 8151
;8151:	goal->entitynum = ent->s.number;
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 8152
;8152:	VectorSet(goal->mins, -8, -8, -8);
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 3238002688
ASGNF4
line 8153
;8153:	VectorSet(goal->maxs, 8, 8, 8);
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 1090519040
ASGNF4
line 8154
;8154:	VectorCopy(ent->s.pos.trBase, goal->origin);
ADDRFP4 4
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 8155
;8155:	goal->flags = GFL_ITEM;
ADDRFP4 4
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 1
ASGNI4
line 8156
;8156:	if (ent->flags & FL_DROPPED_ITEM) {
ADDRFP4 0
INDIRP4
CNSTI4 540
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $3106
line 8157
;8157:		goal->flags |= GFL_DROPPED;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 48
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 4
BORI4
ASGNI4
line 8158
;8158:		if (ent->item->giType == IT_ARMOR && ent->item->giTag) goal->origin[2] += 8;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 3
NEI4 $3108
ADDRLP4 4
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 0
EQI4 $3108
ADDRLP4 8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
LABELV $3108
line 8159
;8159:	}
LABELV $3106
line 8161
;8160:	//trap_SnapVector(goal->origin);
;8161:	goal->areanum = BotPointAreaNum(goal->origin);
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 8162
;8162:}
LABELV $3105
endproc BotCreateItemGoal 12 12
export BotSetupDeathmatchAI
proc BotSetupDeathmatchAI 156 16
line 8169
;8163:
;8164:/*
;8165:==================
;8166:BotSetupDeathmatchAI
;8167:==================
;8168:*/
;8169:void BotSetupDeathmatchAI(void) {
line 8173
;8170:	int ent, modelnum;
;8171:	char model[128];
;8172:
;8173:	gametype = trap_Cvar_VariableIntegerValue("g_gametype");
ADDRGP4 $3111
ARGP4
ADDRLP4 136
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 gametype
ADDRLP4 136
INDIRI4
ASGNI4
line 8174
;8174:	maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
ADDRGP4 $226
ARGP4
ADDRLP4 140
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 maxclients
ADDRLP4 140
INDIRI4
ASGNI4
line 8176
;8175:
;8176:	trap_Cvar_Register(&bot_rocketjump, "bot_rocketjump", "1", 0);
ADDRGP4 bot_rocketjump
ARGP4
ADDRGP4 $3112
ARGP4
ADDRGP4 $3113
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 8177
;8177:	trap_Cvar_Register(&bot_grapple, "bot_grapple", "0", 0);
ADDRGP4 bot_grapple
ARGP4
ADDRGP4 $3114
ARGP4
ADDRGP4 $3115
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 8178
;8178:	trap_Cvar_Register(&bot_fastchat, "bot_fastchat", "0", 0);
ADDRGP4 bot_fastchat
ARGP4
ADDRGP4 $3116
ARGP4
ADDRGP4 $3115
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 8179
;8179:	trap_Cvar_Register(&bot_nochat, "bot_nochat", "0", 0);
ADDRGP4 bot_nochat
ARGP4
ADDRGP4 $3117
ARGP4
ADDRGP4 $3115
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 8180
;8180:	trap_Cvar_Register(&bot_testrchat, "bot_testrchat", "0", 0);
ADDRGP4 bot_testrchat
ARGP4
ADDRGP4 $3118
ARGP4
ADDRGP4 $3115
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 8181
;8181:	trap_Cvar_Register(&bot_challenge, "bot_challenge", "0", 0);
ADDRGP4 bot_challenge
ARGP4
ADDRGP4 $3119
ARGP4
ADDRGP4 $3115
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 8182
;8182:	trap_Cvar_Register(&bot_predictobstacles, "bot_predictobstacles", "1", 0);
ADDRGP4 bot_predictobstacles
ARGP4
ADDRGP4 $3120
ARGP4
ADDRGP4 $3113
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 8183
;8183:	trap_Cvar_Register(&g_spSkill, "g_spSkill", "2", 0);
ADDRGP4 g_spSkill
ARGP4
ADDRGP4 $3121
ARGP4
ADDRGP4 $3122
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 8195
;8184:	//
;8185:	// JUHOX BUGFIX: the original flag initializing code didn't work correctly sometimes when
;8186:	// restarting the game.
;8187:#if 0
;8188:	if (gametype == GT_CTF) {
;8189:		if (trap_BotGetLevelItemGoal(-1, "Red Flag", &ctf_redflag) < 0)
;8190:			BotAI_Print(PRT_WARNING, "CTF without Red Flag\n");
;8191:		if (trap_BotGetLevelItemGoal(-1, "Blue Flag", &ctf_blueflag) < 0)
;8192:			BotAI_Print(PRT_WARNING, "CTF without Blue Flag\n");
;8193:	}
;8194:#else
;8195:	if (gametype == GT_CTF) BotFindCTFBases();
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $3123
ADDRGP4 BotFindCTFBases
CALLV
pop
LABELV $3123
line 8227
;8196:#endif
;8197:#ifdef MISSIONPACK
;8198:	else if (gametype == GT_1FCTF) {
;8199:		if (trap_BotGetLevelItemGoal(-1, "Neutral Flag", &ctf_neutralflag) < 0)
;8200:			BotAI_Print(PRT_WARNING, "One Flag CTF without Neutral Flag\n");
;8201:		if (trap_BotGetLevelItemGoal(-1, "Red Flag", &ctf_redflag) < 0)
;8202:			BotAI_Print(PRT_WARNING, "CTF without Red Flag\n");
;8203:		if (trap_BotGetLevelItemGoal(-1, "Blue Flag", &ctf_blueflag) < 0)
;8204:			BotAI_Print(PRT_WARNING, "CTF without Blue Flag\n");
;8205:	}
;8206:	else if (gametype == GT_OBELISK) {
;8207:		if (trap_BotGetLevelItemGoal(-1, "Red Obelisk", &redobelisk) < 0)
;8208:			BotAI_Print(PRT_WARNING, "Obelisk without red obelisk\n");
;8209:		BotSetEntityNumForGoal(&redobelisk, "team_redobelisk");
;8210:		if (trap_BotGetLevelItemGoal(-1, "Blue Obelisk", &blueobelisk) < 0)
;8211:			BotAI_Print(PRT_WARNING, "Obelisk without blue obelisk\n");
;8212:		BotSetEntityNumForGoal(&blueobelisk, "team_blueobelisk");
;8213:	}
;8214:	else if (gametype == GT_HARVESTER) {
;8215:		if (trap_BotGetLevelItemGoal(-1, "Red Obelisk", &redobelisk) < 0)
;8216:			BotAI_Print(PRT_WARNING, "Harvester without red obelisk\n");
;8217:		BotSetEntityNumForGoal(&redobelisk, "team_redobelisk");
;8218:		if (trap_BotGetLevelItemGoal(-1, "Blue Obelisk", &blueobelisk) < 0)
;8219:			BotAI_Print(PRT_WARNING, "Harvester without blue obelisk\n");
;8220:		BotSetEntityNumForGoal(&blueobelisk, "team_blueobelisk");
;8221:		if (trap_BotGetLevelItemGoal(-1, "Neutral Obelisk", &neutralobelisk) < 0)
;8222:			BotAI_Print(PRT_WARNING, "Harvester without neutral obelisk\n");
;8223:		BotSetEntityNumForGoal(&neutralobelisk, "team_neutralobelisk");
;8224:	}
;8225:#endif
;8226:
;8227:	max_bspmodelindex = 0;
ADDRGP4 max_bspmodelindex
CNSTI4 0
ASGNI4
line 8228
;8228:	for (ent = trap_AAS_NextBSPEntity(0); ent; ent = trap_AAS_NextBSPEntity(ent)) {
CNSTI4 0
ARGI4
ADDRLP4 144
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 144
INDIRI4
ASGNI4
ADDRGP4 $3128
JUMPV
LABELV $3125
line 8229
;8229:		if (!trap_AAS_ValueForBSPEpairKey(ent, "model", model, sizeof(model))) continue;
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $221
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 148
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $3129
ADDRGP4 $3126
JUMPV
LABELV $3129
line 8230
;8230:		if (model[0] == '*') {
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $3131
line 8231
;8231:			modelnum = atoi(model+1);
ADDRLP4 4+1
ARGP4
ADDRLP4 152
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 132
ADDRLP4 152
INDIRI4
ASGNI4
line 8232
;8232:			if (modelnum > max_bspmodelindex)
ADDRLP4 132
INDIRI4
ADDRGP4 max_bspmodelindex
INDIRI4
LEI4 $3134
line 8233
;8233:				max_bspmodelindex = modelnum;
ADDRGP4 max_bspmodelindex
ADDRLP4 132
INDIRI4
ASGNI4
LABELV $3134
line 8234
;8234:		}
LABELV $3131
line 8235
;8235:	}
LABELV $3126
line 8228
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 148
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 148
INDIRI4
ASGNI4
LABELV $3128
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $3125
line 8237
;8236:	//initialize the waypoint heap
;8237:	BotInitWaypoints();
ADDRGP4 BotInitWaypoints
CALLV
pop
line 8238
;8238:}
LABELV $3110
endproc BotSetupDeathmatchAI 156 16
export BotShutdownDeathmatchAI
proc BotShutdownDeathmatchAI 0 0
line 8245
;8239:
;8240:/*
;8241:==================
;8242:BotShutdownDeathmatchAI
;8243:==================
;8244:*/
;8245:void BotShutdownDeathmatchAI(void) {
line 8246
;8246:	altroutegoals_setup = qfalse;
ADDRGP4 altroutegoals_setup
CNSTI4 0
ASGNI4
line 8247
;8247:}
LABELV $3136
endproc BotShutdownDeathmatchAI 0 0
bss
export blue_numaltroutegoals
align 4
LABELV blue_numaltroutegoals
skip 4
export blue_altroutegoals
align 4
LABELV blue_altroutegoals
skip 768
export red_numaltroutegoals
align 4
LABELV red_numaltroutegoals
skip 4
export red_altroutegoals
align 4
LABELV red_altroutegoals
skip 768
export altroutegoals_setup
align 4
LABELV altroutegoals_setup
skip 4
export max_bspmodelindex
align 4
LABELV max_bspmodelindex
skip 4
export lastteleport_time
align 4
LABELV lastteleport_time
skip 4
export lastteleport_origin
align 4
LABELV lastteleport_origin
skip 12
import bot_developer
export g_spSkill
align 4
LABELV g_spSkill
skip 272
export bot_predictobstacles
align 4
LABELV bot_predictobstacles
skip 272
export botai_freewaypoints
align 4
LABELV botai_freewaypoints
skip 4
export botai_waypoints
align 4
LABELV botai_waypoints
skip 12800
import BotEnemyFlagStatus
import BotOwnFlagStatus
import LocateFlag
import FindDroppedFlag
import GetItemGoal
import BotDetermineVisibleTeammates
import BotGetNextTeamMate
import BotGetNextPlayerOrMonster
import BotGetNextPlayer
import BotVoiceChatOnly
import BotVoiceChat
import BotSetTeamMateTaskPreference
import BotGetTeamMateTaskPreference
import BotTeamAI
import BotMayNBGBeAvailable
import BotMayLTGItemBeReachable
import BotRememberLTGItemUnreachable
import BotDumpNodeSwitches
import BotResetNodeSwitches
import AINode_Battle_NBG
import AINode_Battle_Retreat
import AINode_Battle_Chase
import AINode_Battle_Fight
import AINode_Seek_LTG
import AINode_Seek_NBG
import AINode_Seek_ActivateEntity
import AINode_Stand
import AINode_Respawn
import AINode_Observer
import AINode_Intermission
import AIEnter_Battle_NBG
import AIEnter_Battle_Retreat
import AIEnter_Battle_Chase
import AIEnter_Battle_Fight
import AIEnter_Seek_Camp
import AIEnter_Seek_LTG
import AIEnter_Seek_NBG
import AIEnter_Seek_ActivateEntity
import AIEnter_Stand
import AIEnter_Respawn
import AIEnter_Observer
import AIEnter_Intermission
import BotPrintTeamGoal
import BotMatchMessage
import notleader
import BotChatTest
import BotValidChatPosition
import BotChatTime
import BotChat_Random
import BotChat_EnemySuicide
import BotChat_Kill
import BotChat_Death
import BotChat_HitNoKill
import BotChat_HitNoDeath
import BotChat_HitTalking
import BotChat_EndLevel
import BotChat_StartLevel
import BotChat_ExitGame
import BotChat_EnterGame
export ctf_blueflag
align 4
LABELV ctf_blueflag
skip 56
export ctf_redflag
align 4
LABELV ctf_redflag
skip 56
export bot_challenge
align 4
LABELV bot_challenge
skip 272
export bot_testrchat
align 4
LABELV bot_testrchat
skip 272
export bot_nochat
align 4
LABELV bot_nochat
skip 272
export bot_fastchat
align 4
LABELV bot_fastchat
skip 272
export bot_rocketjump
align 4
LABELV bot_rocketjump
skip 272
export bot_grapple
align 4
LABELV bot_grapple
skip 272
export maxclients
align 4
LABELV maxclients
skip 4
export gametype
align 4
LABELV gametype
skip 4
import BotCTFRetreatGoals
import BotCTFSeekGoals
import BotVisibleTeamMatesAndEnemies
import BotWantsToCamp
import BotTeamGoals
import BotSetLastOrderedTask
import BotReactionTime
import BotTeamLeader
import BotAI_GetSnapshotEntity
import BotAI_GetEntityState
import BotAI_GetClientState
import BotAI_Trace
import BotAI_BotInitialChat
import BotAI_Print
import BotAI_IsBot
import floattime
import BotEntityInfo
import NumBots
import BotResetState
import BotResetWeaponState
import BotFreeWeaponState
import BotAllocWeaponState
import BotLoadWeaponWeights
import BotGetWeaponInfo
import BotChooseBestFightWeapon
import BotShutdownWeaponAI
import BotSetupWeaponAI
import BotShutdownMoveAI
import BotSetupMoveAI
import BotSetBrushModelTypes
import BotAddAvoidSpot
import BotInitMoveState
import BotFreeMoveState
import BotAllocMoveState
import BotPredictVisiblePosition
import BotMovementViewTarget
import BotReachabilityArea
import BotResetLastAvoidReach
import BotResetAvoidReach
import BotMoveInDirection
import BotMoveToGoal
import BotResetMoveState
import BotShutdownGoalAI
import BotSetupGoalAI
import BotFreeGoalState
import BotAllocGoalState
import BotFreeItemWeights
import BotLoadItemWeights
import BotMutateGoalFuzzyLogic
import BotSaveGoalFuzzyLogic
import BotInterbreedGoalFuzzyLogic
import BotUpdateEntityItems
import BotInitLevelItems
import BotSetAvoidGoalTime
import BotAvoidGoalTime
import BotGetMapLocationGoal
import BotGetNextCampSpotGoal
import BotGetLevelItemGoal
import BotItemGoalInVisButNotVisible
import BotTouchingGoal
import BotChooseNBGItem
import BotChooseLTGItem
import BotGetSecondGoal
import BotGetTopGoal
import BotGoalName
import BotDumpGoalStack
import BotDumpAvoidGoals
import BotEmptyGoalStack
import BotPopGoal
import BotPushGoal
import BotRemoveFromAvoidGoals
import BotResetAvoidGoals
import BotResetGoalState
import GeneticParentsAndChildSelection
import BotSetChatName
import BotSetChatGender
import BotLoadChatFile
import BotReplaceSynonyms
import UnifyWhiteSpaces
import BotMatchVariable
import BotFindMatch
import StringContains
import BotGetChatMessage
import BotEnterChat
import BotChatLength
import BotReplyChat
import BotNumInitialChats
import BotInitialChat
import BotNumConsoleMessages
import BotNextConsoleMessage
import BotRemoveConsoleMessage
import BotQueueConsoleMessage
import BotFreeChatState
import BotAllocChatState
import BotShutdownChatAI
import BotSetupChatAI
import BotShutdownCharacters
import Characteristic_String
import Characteristic_BInteger
import Characteristic_Integer
import Characteristic_BFloat
import Characteristic_Float
import BotFreeCharacter
import BotLoadCharacter
import EA_Shutdown
import EA_Setup
import EA_ResetInput
import EA_GetInput
import EA_EndRegular
import EA_View
import EA_Move
import EA_DelayedJump
import EA_Jump
import EA_SelectWeapon
import EA_Use
import EA_Gesture
import EA_Talk
import EA_Respawn
import EA_Attack
import EA_MoveRight
import EA_MoveLeft
import EA_MoveBack
import EA_MoveForward
import EA_MoveDown
import EA_MoveUp
import EA_Walk
import EA_Crouch
import EA_Action
import EA_Command
import EA_SayTeam
import EA_Say
import GetBotLibAPI
import trap_SnapVector
import trap_GeneticParentsAndChildSelection
import trap_BotResetWeaponState
import trap_BotFreeWeaponState
import trap_BotAllocWeaponState
import trap_BotLoadWeaponWeights
import trap_BotGetWeaponInfo
import trap_BotChooseBestFightWeapon
import trap_BotAddAvoidSpot
import trap_BotInitMoveState
import trap_BotFreeMoveState
import trap_BotAllocMoveState
import trap_BotPredictVisiblePosition
import trap_BotMovementViewTarget
import trap_BotReachabilityArea
import trap_BotResetLastAvoidReach
import trap_BotResetAvoidReach
import trap_BotMoveInDirection
import trap_BotMoveToGoal
import trap_BotResetMoveState
import trap_BotFreeGoalState
import trap_BotAllocGoalState
import trap_BotMutateGoalFuzzyLogic
import trap_BotSaveGoalFuzzyLogic
import trap_BotInterbreedGoalFuzzyLogic
import trap_BotFreeItemWeights
import trap_BotLoadItemWeights
import trap_BotUpdateEntityItems
import trap_BotInitLevelItems
import trap_BotSetAvoidGoalTime
import trap_BotAvoidGoalTime
import trap_BotGetLevelItemGoal
import trap_BotGetMapLocationGoal
import trap_BotGetNextCampSpotGoal
import trap_BotItemGoalInVisButNotVisible
import trap_BotTouchingGoal
import trap_BotChooseNBGItem
import trap_BotChooseLTGItem
import trap_BotGetSecondGoal
import trap_BotGetTopGoal
import trap_BotGoalName
import trap_BotDumpGoalStack
import trap_BotDumpAvoidGoals
import trap_BotEmptyGoalStack
import trap_BotPopGoal
import trap_BotPushGoal
import trap_BotResetAvoidGoals
import trap_BotRemoveFromAvoidGoals
import trap_BotResetGoalState
import trap_BotSetChatName
import trap_BotSetChatGender
import trap_BotLoadChatFile
import trap_BotReplaceSynonyms
import trap_UnifyWhiteSpaces
import trap_BotMatchVariable
import trap_BotFindMatch
import trap_StringContains
import trap_BotGetChatMessage
import trap_BotEnterChat
import trap_BotChatLength
import trap_BotReplyChat
import trap_BotNumInitialChats
import trap_BotInitialChat
import trap_BotNumConsoleMessages
import trap_BotNextConsoleMessage
import trap_BotRemoveConsoleMessage
import trap_BotQueueConsoleMessage
import trap_BotFreeChatState
import trap_BotAllocChatState
import trap_Characteristic_String
import trap_Characteristic_BInteger
import trap_Characteristic_Integer
import trap_Characteristic_BFloat
import trap_Characteristic_Float
import trap_BotFreeCharacter
import trap_BotLoadCharacter
import trap_EA_ResetInput
import trap_EA_GetInput
import trap_EA_EndRegular
import trap_EA_View
import trap_EA_Move
import trap_EA_DelayedJump
import trap_EA_Jump
import trap_EA_SelectWeapon
import trap_EA_MoveRight
import trap_EA_MoveLeft
import trap_EA_MoveBack
import trap_EA_MoveForward
import trap_EA_MoveDown
import trap_EA_MoveUp
import trap_EA_Crouch
import trap_EA_Respawn
import trap_EA_Use
import trap_EA_Attack
import trap_EA_Talk
import trap_EA_Gesture
import trap_EA_Action
import trap_EA_Command
import trap_EA_SayTeam
import trap_EA_Say
import trap_AAS_PredictClientMovement
import trap_AAS_Swimming
import trap_AAS_AlternativeRouteGoals
import trap_AAS_PredictRoute
import trap_AAS_EnableRoutingArea
import trap_AAS_AreaTravelTimeToGoalArea
import trap_AAS_AreaReachability
import trap_AAS_IntForBSPEpairKey
import trap_AAS_FloatForBSPEpairKey
import trap_AAS_VectorForBSPEpairKey
import trap_AAS_ValueForBSPEpairKey
import trap_AAS_NextBSPEntity
import trap_AAS_PointContents
import trap_AAS_TraceAreas
import trap_AAS_PointReachabilityAreaIndex
import trap_AAS_PointAreaNum
import trap_AAS_Time
import trap_AAS_PresenceTypeBoundingBox
import trap_AAS_Initialized
import trap_AAS_EntityInfo
import trap_AAS_AreaInfo
import trap_AAS_BBoxAreas
import trap_BotUserCommand
import trap_BotGetServerCommand
import trap_BotGetSnapshotEntity
import trap_BotLibTest
import trap_BotLibUpdateEntity
import trap_BotLibLoadMap
import trap_BotLibStartFrame
import trap_BotLibDefine
import trap_BotLibVarGet
import trap_BotLibVarSet
import trap_BotLibShutdown
import trap_BotLibSetup
import trap_DebugPolygonDelete
import trap_DebugPolygonCreate
import trap_GetEntityToken
import trap_GetUsercmd
import trap_BotFreeClient
import trap_BotAllocateClient
import trap_EntityContact
import trap_EntitiesInBox
import trap_UnlinkEntity
import trap_LinkEntity
import trap_AreasConnected
import trap_AdjustAreaPortalState
import trap_InPVSIgnorePortals
import trap_InPVS
import trap_PointContents
import trap_Trace
import trap_SetBrushModel
import trap_GetServerinfo
import trap_SetUserinfo
import trap_GetUserinfo
import trap_GetConfigstring
import trap_SetConfigstring
import trap_SendServerCommand
import trap_DropClient
import trap_LocateGameData
import trap_Cvar_VariableStringBuffer
import trap_Cvar_VariableValue
import trap_Cvar_VariableIntegerValue
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_SendConsoleCommand
import trap_FS_Seek
import trap_FS_GetFileList
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_FS_FOpenFile
import trap_Args
import trap_Argv
import trap_Argc
import trap_Milliseconds
import trap_Error
import trap_Printf
import g_mapName
import g_proxMineTimeout
import g_singlePlayer
import g_enableBreath
import g_enableDust
import g_rankings
import pmove_msec
import pmove_fixed
import g_smoothClients
import g_blueteam
import g_redteam
import g_cubeTimeout
import g_obeliskRespawnDelay
import g_obeliskRegenAmount
import g_obeliskRegenPeriod
import g_obeliskHealth
import g_filterBan
import g_banIPs
import g_teamForceBalance
import g_teamAutoJoin
import g_allowVote
import g_blood
import g_doWarmup
import g_warmup
import g_motd
import g_synchronousClients
import g_weaponTeamRespawn
import g_weaponRespawn
import g_debugDamage
import g_debugAlloc
import g_debugMove
import g_inactivity
import g_forcerespawn
import g_quadfactor
import g_knockback
import g_speed
import g_gravity
import g_needpass
import g_password
import g_friendlyFire
import g_meeting
import g_weaponLimit
import g_cloakingDevice
import g_unlimitedAmmo
import g_noHealthRegen
import g_noItems
import g_grapple
import g_lightningDamageLimit
import g_baseHealth
import g_stamina
import g_armorFragments
import g_tssSafetyMode
import g_tss
import g_respawnAtPOD
import g_respawnDelay
import g_gameSeed
import g_template
import g_debugEFH
import g_challengingEnv
import g_distanceLimit
import g_monsterLoad
import g_scoreMode
import g_monsterProgression
import g_monsterBreeding
import g_maxMonstersPP
import g_monsterLauncher
import g_skipEndSequence
import g_monstersPerTrap
import g_monsterTitans
import g_monsterGuards
import g_monsterHealthScale
import g_monsterSpawnDelay
import g_maxMonsters
import g_minMonsters
import g_artefacts
import g_capturelimit
import g_timelimit
import g_fraglimit
import g_dmflags
import g_restarted
import g_maxGameClients
import g_maxclients
import g_cheats
import g_dedicated
import g_gametype
import g_editmode
import g_entities
import level
import Pickup_Team
import CheckTeamStatus
import TeamplayInfoMessage
import Team_GetLocationMsg
import Team_GetLocation
import SelectCTFSpawnPoint
import Team_FreeEntity
import Team_ReturnFlag
import Team_InitGame
import Team_CheckHurtCarrier
import Team_FragBonuses
import Team_DroppedFlagThink
import AddTeamScore
import TeamColorString
import OtherTeamName
import TeamName
import OtherTeam
import BotTestAAS
import BotAIStartFrame
import BotAIShutdownClient
import BotAISetupClient
import BotAILoadMap
import BotAIShutdown
import BotAISetup
import IsPlayerFighting
import G_Constitution
import G_GetEntityPlayerState
import EntityAudible
import G_MonsterAction
import G_CheckMonsterDamage
import G_GetMonsterGeneric1
import G_IsMovable
import G_CanBeDamaged
import G_UpdateMonsterCounters
import G_AddMonsterSeed
import G_ReleaseTrap
import G_IsFriendlyMonster
import G_MonsterOwner
import G_IsAttackingGuard
import G_ChargeMonsters
import G_IsMonsterSuccessfulAttacking
import G_IsMonsterNearEntity
import IsFightingMonster
import G_MonsterSpawning
import G_SpawnMonster
import G_MonsterType
import G_MonsterBaseHealth
import G_MonsterHealthScale
import G_GetMonsterSpawnPoint
import G_GetMonsterBounds
import G_KillMonster
import G_MonsterScanForNoises
import CheckTouchedMonsters
import G_NumMonsters
import G_UpdateMonsterCS
import G_InitMonsters
import BotInterbreedEndMatch
import Svcmd_BotList_f
import Svcmd_AddBot_f
import G_BotConnect
import G_RemoveQueuedBotBegin
import G_CheckBotSpawn
import G_GetBotInfoByName
import G_GetBotInfoByNumber
import G_InitBots
import Svcmd_AbortPodium_f
import SpawnModelsOnVictoryPads
import UpdateTournamentInfo
import G_WriteSessionData
import G_InitWorldSession
import G_InitSessionData
import G_ReadSessionData
import Svcmd_GameMem_f
import G_InitMemory
import G_Alloc
import CheckObeliskAttack
import Team_GetDroppedOrTakenFlag
import Team_CheckDroppedItem
import OnSameTeam
import Team_GetFlagStatus
import G_RunClient
import ClientEndFrame
import ClientThink
import ClientImpacts
import SetTargetPos
import CheckPlayerDischarge
import TotalChargeDamage
import TSS_Run
import TSS_DangerIndex
import IsPlayerInvolvedInFighting
import NearHomeBase
import ClientCommand
import ClientBegin
import ClientDisconnect
import ClientUserinfoChanged
import ClientSetPlayerClass
import ClientConnect
import SelectAppropriateSpawnPoint
import LogExit
import G_Error
import G_Printf
import SendScoreboardMessageToAllClients
import G_LogPrintf
import G_RunThink
import G_SetPlayerRefOrigin
import CheckTeamLeader
import SetLeader
import FindIntermissionPoint
import DeathmatchScoreboardMessage
import G_SetStats
import MoveClientToIntermission
import FireWeapon
import G_FilterPacket
import G_ProcessIPBans
import ConsoleCommand
import PositionWouldTelefrag
import SpotWouldTelefrag
import CalculateRanks
import AddScore
import player_die
import ClientSpawn
import InitBodyQue
import InitClientResp
import InitClientPersistant
import BeginIntermission
import respawn
import CopyToBodyQue
import SelectSpawnPoint
import SetClientViewAngle
import PickTeam
import TeamLeader
import TeamCount
import GetRespawnLocationType
import ForceRespawn
import Weapon_HookThink
import Weapon_HookFree
import CheckTitanAttack
import CheckGauntletAttack
import SnapVectorTowards
import CalcMuzzlePoint
import LogAccuracyHit
import Weapon_GrapplingHook_Throw
import TeleportPlayer
import trigger_teleporter_touch
import InitMover
import Touch_DoorTrigger
import G_RunMover
import fire_monster_seed
import fire_grapple
import fire_bfg
import fire_rocket
import fire_grenade
import fire_plasma
import fire_blaster
import G_RunMissile
import GibEntity
import ScorePlum
import DropArmor
import DropHealth
import TossClientCubes
import TossClientItems
import body_die
import G_InvulnerabilityEffect
import G_RadiusDamage
import G_Damage
import CanDamage
import DoOverkill
import BuildShaderStateConfig
import AddRemap
import G_SetOrigin
import G_AddEvent
import G_AddPredictableEvent
import vectoyaw
import vtos
import tv
import G_acos
import G_TouchSolids
import G_TouchTriggers
import G_EntitiesFree
import G_FreeEntity
import G_Sound
import G_TempEntity
import G_NumEntitiesFree
import G_Spawn
import G_InitGentity
import G_SetMovedir
import G_UseTargets
import G_PickTarget
import G_Find
import G_KillBox
import G_TeamCommand
import G_SoundIndex
import G_ModelIndex
import SaveRegisteredItems
import RegisterItem
import ClearRegisteredItems
import G_SpawnArtefact
import G_BounceItemRotation
import Touch_Item
import Add_Ammo
import ArmorIndex
import Think_Weapon
import FinishSpawningItem
import G_SpawnItem
import SetRespawn
import LaunchItem
import Drop_Item
import PrecacheItem
import UseHoldableItem
import RespawnItem
import G_RunItem
import G_CheckTeamItems
import G_Say
import Cmd_FollowCycle_f
import SetTeam
import BroadcastTeamChange
import StopFollowing
import Cmd_Score_f
import G_EFH_NextDebugSegment
import G_EFH_SpaceExtent
import G_UpdateLightingOrigins
import G_GetTotalWayLength
import G_MakeWorldAwareOfMonsterDeath
import G_FindSegment
import G_UpdateWorld
import G_SpawnWorld
import G_InitWorldSystem
import G_NewString
import G_SpawnEntitiesFromString
import G_SpawnVector
import G_SpawnInt
import G_SpawnFloat
import G_SpawnString
import G_PlayTemplate
import G_PrintTemplateList
import G_SendGameTemplate
import G_TemplateList_Error
import G_TemplateList_Stop
import G_TemplateList_Request
import G_RestartGameTemplates
import G_DefineTemplate
import G_SetTemplateName
import G_LoadGameTemplates
import G_InitGameTemplates
import sv_mapChecksum
import templateList
import numTemplateFiles
import templateFileList
import InitLocalSeed
import SeededRandom
import SetGameSeed
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
LABELV $3122
byte 1 50
byte 1 0
align 1
LABELV $3121
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
LABELV $3120
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 112
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 111
byte 1 98
byte 1 115
byte 1 116
byte 1 97
byte 1 99
byte 1 108
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $3119
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 99
byte 1 104
byte 1 97
byte 1 108
byte 1 108
byte 1 101
byte 1 110
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $3118
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 114
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $3117
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 110
byte 1 111
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $3116
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 102
byte 1 97
byte 1 115
byte 1 116
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $3115
byte 1 48
byte 1 0
align 1
LABELV $3114
byte 1 98
byte 1 111
byte 1 116
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
LABELV $3113
byte 1 49
byte 1 0
align 1
LABELV $3112
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 106
byte 1 117
byte 1 109
byte 1 112
byte 1 0
align 1
LABELV $3111
byte 1 103
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $3059
byte 1 37
byte 1 115
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 115
byte 1 119
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 101
byte 1 100
byte 1 32
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 110
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 65
byte 1 73
byte 1 32
byte 1 110
byte 1 111
byte 1 100
byte 1 101
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $3048
byte 1 66
byte 1 111
byte 1 116
byte 1 68
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 65
byte 1 73
byte 1 58
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $3043
byte 1 66
byte 1 111
byte 1 116
byte 1 68
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 65
byte 1 73
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 97
byte 1 105
byte 1 32
byte 1 110
byte 1 111
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $3030
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $3026
byte 1 115
byte 1 101
byte 1 120
byte 1 0
align 1
LABELV $2992
byte 1 42
byte 1 102
byte 1 97
byte 1 108
byte 1 108
byte 1 105
byte 1 110
byte 1 103
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $2989
byte 1 69
byte 1 86
byte 1 95
byte 1 71
byte 1 69
byte 1 78
byte 1 69
byte 1 82
byte 1 65
byte 1 76
byte 1 95
byte 1 83
byte 1 79
byte 1 85
byte 1 78
byte 1 68
byte 1 58
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 80
byte 1 97
byte 1 114
byte 1 109
byte 1 32
byte 1 40
byte 1 37
byte 1 100
byte 1 41
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 114
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $2968
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
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $2965
byte 1 69
byte 1 86
byte 1 95
byte 1 71
byte 1 76
byte 1 79
byte 1 66
byte 1 65
byte 1 76
byte 1 95
byte 1 83
byte 1 79
byte 1 85
byte 1 78
byte 1 68
byte 1 58
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 80
byte 1 97
byte 1 114
byte 1 109
byte 1 32
byte 1 40
byte 1 37
byte 1 100
byte 1 41
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 114
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $2806
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 73
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 97
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 97
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $2805
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 73
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 115
byte 1 104
byte 1 111
byte 1 111
byte 1 116
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 97
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 97
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $2801
byte 1 66
byte 1 111
byte 1 116
byte 1 71
byte 1 111
byte 1 70
byte 1 111
byte 1 114
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $2789
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 100
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $2788
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 114
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $2785
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $2774
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 95
byte 1 109
byte 1 117
byte 1 108
byte 1 116
byte 1 105
byte 1 112
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $2761
byte 1 66
byte 1 111
byte 1 116
byte 1 71
byte 1 101
byte 1 116
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 58
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $2755
byte 1 66
byte 1 111
byte 1 116
byte 1 71
byte 1 101
byte 1 116
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 10
byte 1 0
align 1
LABELV $2747
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $2736
byte 1 66
byte 1 111
byte 1 116
byte 1 71
byte 1 101
byte 1 116
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 58
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $2732
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2729
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $2694
byte 1 111
byte 1 114
byte 1 105
byte 1 103
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $2689
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $2684
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $2681
byte 1 66
byte 1 111
byte 1 116
byte 1 71
byte 1 101
byte 1 116
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 58
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $2678
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2677
byte 1 66
byte 1 111
byte 1 116
byte 1 71
byte 1 101
byte 1 116
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2665
byte 1 42
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $2480
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $2457
byte 1 97
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $2454
byte 1 108
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $2416
byte 1 109
byte 1 112
byte 1 113
byte 1 51
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 54
byte 1 0
align 1
LABELV $2361
byte 1 113
byte 1 51
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 54
byte 1 0
align 1
LABELV $2357
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $1753
byte 1 67
byte 1 111
byte 1 110
byte 1 116
byte 1 97
byte 1 99
byte 1 116
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $1165
byte 1 73
byte 1 110
byte 1 118
byte 1 105
byte 1 115
byte 1 105
byte 1 98
byte 1 105
byte 1 108
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $1164
byte 1 83
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $1163
byte 1 66
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 83
byte 1 117
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $1162
byte 1 82
byte 1 101
byte 1 103
byte 1 101
byte 1 110
byte 1 101
byte 1 114
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1161
byte 1 81
byte 1 117
byte 1 97
byte 1 100
byte 1 32
byte 1 68
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $894
byte 1 66
byte 1 111
byte 1 116
byte 1 67
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 101
byte 1 87
byte 1 97
byte 1 121
byte 1 80
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 79
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 119
byte 1 97
byte 1 121
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $271
byte 1 93
byte 1 0
align 1
LABELV $270
byte 1 91
byte 1 0
align 1
LABELV $269
byte 1 32
byte 1 0
align 1
LABELV $226
byte 1 115
byte 1 118
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $221
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $220
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 83
byte 1 107
byte 1 105
byte 1 110
byte 1 58
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 114
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $215
byte 1 110
byte 1 0
align 1
LABELV $214
byte 1 91
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 114
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 93
byte 1 0
align 1
LABELV $213
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 58
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 114
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $146
byte 1 67
byte 1 84
byte 1 70
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $143
byte 1 67
byte 1 84
byte 1 70
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $106
byte 1 116
byte 1 0
