// Copyright (C) 1999-2000 Id Software, Inc.
//

/*****************************************************************************
 * name:		ai_team.h
 *
 * desc:		Quake3 bot AI
 *
 * $Archive: /source/code/botai/ai_chat.c $
 *
 *****************************************************************************/

void BotTeamAI(bot_state_t *bs);
int BotGetTeamMateTaskPreference(bot_state_t *bs, int teammate);
void BotSetTeamMateTaskPreference(bot_state_t *bs, int teammate, int preference);
void BotVoiceChat(bot_state_t *bs, int toclient, char *voicechat);
void BotVoiceChatOnly(bot_state_t *bs, int toclient, char *voicechat);
int BotGetNextPlayer(bot_state_t* bs, int lastPlayer, playerState_t* ps);	// JUHOX
int BotGetNextPlayerOrMonster(bot_state_t* bs, int lastPlayer, playerState_t* ps);	// JUHOX
int BotGetNextTeamMate(bot_state_t* bs, int lastTeamMate, playerState_t* ps);	// JUHOX
void BotDetermineVisibleTeammates(bot_state_t* bs);	// JUHOX
int GetItemGoal(int entitynum, const char* name, bot_goal_t* goal);	// JUHOX
qboolean FindDroppedFlag(int team, bot_goal_t* goal);	// JUHOX
qboolean LocateFlag(int team, bot_goal_t* goal);	// JUHOX
flagStatus_t BotOwnFlagStatus(bot_state_t* bs);	// JUHOX
flagStatus_t BotEnemyFlagStatus(bot_state_t* bs);	// JUHOX
