// Copyright (C) 1999-2000 Id Software, Inc.
//

/*****************************************************************************
 * name:		ai_main.h
 *
 * desc:		Quake3 bot AI
 *
 * $Archive: /source/code/botai/ai_chat.c $
 *
 *****************************************************************************/

//#define DEBUG
#define CTF

#define MAX_ITEMS					256
//bot flags
#define BFL_STRAFERIGHT				1	//strafe to the right
#define BFL_ATTACKED				2	//bot has attacked last ai frame
#define BFL_ATTACKJUMPED			4	//bot jumped during attack last frame
#define BFL_AIMATENEMY				8	//bot aimed at the enemy this frame
#define BFL_AVOIDRIGHT				16	//avoid obstacles by going to the right
#define BFL_IDEALVIEWSET			32	//bot has ideal view angles set
#define BFL_FIGHTSUICIDAL			64	//bot is in a suicidal fight
//long term goal types
#define LTG_TEAMHELP				1	//help a team mate
#define LTG_TEAMACCOMPANY			2	//accompany a team mate
#define LTG_DEFENDKEYAREA			3	//defend a key area
#define LTG_GETFLAG					4	//get the enemy flag
#define LTG_RUSHBASE				5	//rush to the base
#define LTG_RETURNFLAG				6	//return the flag
#define LTG_CAMP					7	//camp somewhere
#define LTG_CAMPORDER				8	//ordered to camp somewhere
#define LTG_PATROL					9	//patrol
#define LTG_GETITEM					10	//get an item
#define LTG_KILL					11	//kill someone
#define LTG_HARVEST					12	//harvest skulls
#define LTG_ATTACKENEMYBASE			13	//attack the enemy base
#define LTG_MAKELOVE_UNDER			14
#define LTG_MAKELOVE_ONTOP			15
#define LTG_ESCAPE					16	// JUHOX: try to retreat
#define LTG_WAIT					17	// JUHOX: used if the bot could not overcome an obstacle for some time
//some goal dedication times
#define TEAM_HELP_TIME				60	//1 minute teamplay help time
#define TEAM_ACCOMPANY_TIME			600	//10 minutes teamplay accompany time
#define TEAM_DEFENDKEYAREA_TIME		600	//10 minutes ctf defend base time
#define TEAM_CAMP_TIME				600	//10 minutes camping time
#define TEAM_PATROL_TIME			600	//10 minutes patrolling time
#define TEAM_LEAD_TIME				600	//10 minutes taking the lead
#define TEAM_GETITEM_TIME			60	//1 minute
#define	TEAM_KILL_SOMEONE			180	//3 minute to kill someone
#define TEAM_ATTACKENEMYBASE_TIME	600	//10 minutes
#define TEAM_HARVEST_TIME			120	//2 minutes
#define CTF_GETFLAG_TIME			600	//10 minutes ctf get flag time
#define CTF_RUSHBASE_TIME			120	//2 minutes ctf rush base time
#define CTF_RETURNFLAG_TIME			180	//3 minutes to return the flag
#define CTF_ROAM_TIME				60	//1 minute ctf roam time
//patrol flags
#define PATROL_LOOP					1
#define PATROL_REVERSE				2
#define PATROL_BACK					4
//teamplay task preference
#define TEAMTP_DEFENDER				1
#define TEAMTP_ATTACKER				2
//CTF strategy
#define CTFS_AGRESSIVE				1
//copied from the aas file header
#define PRESENCE_NONE				1
#define PRESENCE_NORMAL				2
#define PRESENCE_CROUCH				4
//
#define MAX_PROXMINES				64

//check points
typedef struct bot_waypoint_s
{
	int			inuse;
	char		name[32];
	bot_goal_t	goal;
	struct		bot_waypoint_s *next, *prev;
} bot_waypoint_t;

#define MAX_ACTIVATESTACK		8
#define MAX_ACTIVATEAREAS		32

typedef struct bot_activategoal_s
{
	int inuse;
	bot_goal_t goal;						//goal to activate (buttons etc.)
	float time;								//time to activate something
	float start_time;						//time starting to activate something
	float justused_time;					//time the goal was used
	int shoot;								//true if bot has to shoot to activate
	int weapon;								//weapon to be used for activation
	vec3_t target;							//target to shoot at to activate something
	vec3_t origin;							//origin of the blocking entity to activate
	int areas[MAX_ACTIVATEAREAS];			//routing areas disabled by blocking entity
	int numareas;							//number of disabled routing areas
	int areasdisabled;						//true if the areas are disabled for the routing
	struct bot_activategoal_s *next;		//next activate goal on stack
} bot_activategoal_t;

// JUHOX: definitions for view history
#define VIEWHISTORY_SIZE 128
typedef struct viewhistory_s
{
	vec3_t real_viewangles;
	vec3_t lastviewcommand;
	vec3_t totalviewdistortion;
	float lastUpdateTime;
	int oldestEntry;
	struct
	{
		float time;
		vec3_t ideal_view;
		vec3_t viewdistortion;
	} entryTab[VIEWHISTORY_SIZE];
} viewhistory_t;

#define MAX_SUBTEAM_SIZE 32	// JUHOX

// JUHOX: definitions for NBG history
#define NBGHISTORY_SIZE 64
typedef struct nbghistory_s
{
	struct
	{
		// entity 'entitynum' not available as seen at 'time'
		float time;
		int entitynum;
	} entryTab[NBGHISTORY_SIZE];
} nbghistory_t;

// JUHOX: definitions for LTG item reachability memory
#define LTG_ITEM_MEMORY_SIZE 64
typedef struct
{
	struct
	{
		int entitynum;
		float unreachable_time;
	} entryTab[LTG_ITEM_MEMORY_SIZE];
} ltgitemmemory_t;

//bot state
typedef struct bot_state_s
{
	int inuse;										//true if this state is used by a bot client
	int botthink_residual;							//residual for the bot thinks
	int client;										//client number of the bot
	int entitynum;									//entity number of the bot
	playerState_t cur_ps;							//current player state
	int last_eFlags;								//last ps flags
	usercmd_t lastucmd;								//usercmd from last frame
	int entityeventTime[1024];						//last entity event time

	bot_settings_t settings;						//several bot settings
	int (*ainode)(struct bot_state_s *bs);			//current AI node
	float thinktime;								//time the bot thinks this frame
	float reactiontime;								// JUHOX: cache this
	vec3_t origin;									//origin of the bot
	vec3_t velocity;								//velocity of the bot
	int presencetype;								//presence type of the bot
	vec3_t eye;										//eye coordinates of the bot
	int areanum;									//the number of the area the bot is in
	int inventory[MAX_ITEMS];						//string with items amounts the bot has
	int tfl;										//the travel flags the bot uses
	float travelLavaAndSlime_time;					// JUHOX: set if 'tfl' should include TFL_LAVA and TFL_SLIME
	int flags;										//several flags
	int respawn_wait;								//wait until respawned
	float lastRespawn_time;							// JUHOX: last time the bot respawned
	float lastKilled_time;							// JUHOX: last time the bot has been killed
	int lasthealth;									//health value previous frame
	int lastkilledplayer;							//last killed player
	int lastkilledby;								//player that last killed this bot
	int botdeathtype;								//the death type of the bot
	int enemydeathtype;								//the death type of the enemy
	int botsuicide;									//true when the bot suicides
	int enemysuicide;								//true when the enemy of the bot suicides
	int setupcount;									//true when the bot has just been setup
	int map_restart;									//true when the map is being restarted
	int entergamechat;								//true when the bot used an enter game chat
	int num_deaths;									//number of time this bot died
	int num_kills;									//number of kills of this bot
	int revenge_enemy;								//the revenge enemy
	int revenge_kills;								//number of kills the enemy made
	int lastframe_health;							//health value the last frame
	int lasthitcount;								//number of hits last frame
	int chatto;										//chat to all or team
	float walker;									//walker charactertic
	float ltime;									//local bot time
	float entergame_time;							//time the bot entered the game
	float ltg_time;									//long term goal time
	float nbg_time;									//nearby goal time
	nbghistory_t nbg_history;						// JUHOX
	gentity_t* nbgEntity;							// JUHOX
	qboolean nbgGivesArmor;							// JUHOX
	qboolean nbgGivesLimitedHealth;					// JUHOX
	qboolean nbgGivesUnlimitedHealth;				// JUHOX
	qboolean nbgGivesHoldableItem;					// JUHOX
	qboolean nbgGivesStrength;						// JUHOX
	qboolean nbgGivesFlag;							// JUHOX
	qboolean nbgGivesPODMarker;						// JUHOX
	ltgitemmemory_t ltg_item_memory;				// JUHOX
	float respawn_time;								//time the bot takes to respawn
	float respawnchat_time;							//time the bot started a chat during respawn
	float chase_time;								//time the bot will chase the enemy
	int chasearea;									// JUHOX: area number the chase began
	vec3_t chaseorigin;								// JUHOX: position the chase began
	float enemyvisible_time;						//time the enemy was last visible
	float check_time;								//time to check for nearby items
	float stand_time;								//time the bot is standing still
	float lastchat_time;							//time the bot last selected a chat
	float kamikaze_time;							//time to check for kamikaze usage
	float invulnerability_time;						//time to check for invulnerability usage
	float standfindenemy_time;						//time to find enemy while standing
	float attackstrafe_time;						//time the bot is strafing in one dir
	float attackcrouch_time;						//time the bot will stop crouching
	float attackchase_time;							//time the bot chases during actual attack
	float attackjump_time;							//time the bot jumped during attack
	float enemysight_time;							//time before reacting to enemy
	float enemydeath_time;							//time the enemy died
	float enemyposition_time;						//time the position and velocity of the enemy were stored
	float defendaway_time;							//time away while defending
	float defendaway_range;							//max travel time away from defend area
	float rushbaseaway_time;						//time away from rushing to the base
	float attackaway_time;							//time away from attacking the enemy base
	float harvestaway_time;							//time away from harvesting
	float ctfroam_time;								//time the bot is roaming in ctf
	float killedenemy_time;							//time the bot killed the enemy
	float arrive_time;								//time arrived (at companion)
	float lastair_time;								//last time the bot had air
	float teleport_time;							//last time the bot teleported
	vec3_t teleport_origin;							// JUHOX: origin the bot was last teleported to
	float camp_time;								//last time camped
	float camp_range;								//camp range
	float machinegun_attack_time;					// JUHOX: last time the bot attacked with the machinegun
	float weaponchange_time;						//time the bot started changing weapons
	float weaponchoose_time;						// JUHOX: next time the bot should choose its weapon
	float firethrottlewait_time;					//amount of time to wait
	float firethrottleshoot_time;					//amount of time to shoot
	float notblocked_time;							//last time the bot was not blocked
	int blockingEnemy;								// JUHOX
	int tryMove;									// JUHOX
	vec3_t notblocked_dir;							// JUHOX
	float blocked_time;								// JUHOX: last time the bot was blocked
	qboolean walkTrouble;							// JUHOX
	vec3_t oldOrigin1;								// JUHOX
	float oldOrigin1_time;							// JUHOX
	vec3_t oldOrigin2;								// JUHOX
	float oldOrigin2_time;							// JUHOX
	float blockedbyavoidspot_time;					//time blocked by an avoid spot
	float predictobstacles_time;					//last time the bot predicted obstacles
	int predictobstacles_goalareanum;				//last goal areanum the bot predicted obstacles for
	vec3_t aimtarget;
	int walltargetorder;							// JUHOX
	float walltargetorder_time;						// JUHOX: last time the walltargetorder was available
	float walltarget_time;							// JUHOX: last time a wall target was available
	float viewnotperfect_time;						// JUHOX: last time the bot didn't exactly aim to enemy
	float couldNotSeeEnemyWhileDucked_time;			// JUHOX: to suppress "crouch-shaking"
	float lineOfFireBlocked_time;					// JUHOX
	float lineOfFireNotBlocked_time;				// JUHOX
	vec3_t enemyvelocity;							//enemy velocity 0.5 secs ago during battle
	vec3_t enemyorigin;								//enemy origin 0.5 secs ago during battle

	int kamikazebody;								//kamikaze body
	int proxmines[MAX_PROXMINES];
	int numproxmines;

	int character;									//the bot character
	int ms;											//move state of the bot
	float railgunJump_ordertime;					// JUHOX
	float railgunJump_jumptime;						// JUHOX
	qboolean getImportantNBGItem;					// JUHOX
	qboolean forceWalk;								// JUHOX: make sure the bot walks
	qboolean specialMove;							// JUHOX: set for rocket jumping etc.
	qboolean preventJump;							// JUHOX: make sure the bot doesn't jump
	int gs;											//goal state of the bot
	int cs;											//chat state of the bot
	int ws;											//weapon state of the bot

	int enemy;										//enemy entity number
	int lastenemyareanum;							//last reachability area the enemy was in
	vec3_t lastenemyorigin;							//last origin of the enemy in the reachability area
	qboolean lastEnemyAreaPredicted;				// JUHOX: 'qfalse' if the enemy has been seen in 'lastenemyareanum'
	qboolean wantsToRetreat;						// JUHOX: cached value
	float wantsToRetreat_time;						// JUHOX: time 'wantsToRetreat' has been cached
	qboolean enemytoostrong;						// JUHOX
	float enemytoostrong_time;						// JUHOX: next time the 'enemytoostrong' flag is to be updated
	int weaponnum;									//current weapon number
	int weaponProposal;								// JUHOX: suggested weapon
	float weaponProposal_time;						// JUHOX: time the weaponProposal was set
	int splashCount_grenade;						// JUHOX: for weapon choosing
	int splashCount_rocket;							// JUHOX: for weapon choosing
	int splashCount_plasma;							// JUHOX: for weapon choosing
	int splashCount_bfg;							// JUHOX: for weapon choosing
	int splashCount_monster_launcher;				// JUHOX: for weapon choosing
	float nextSplashCalculation_time;				// JUHOX
	vec3_t viewangles;								//current view angles
	vec3_t ideal_viewangles;						//ideal view angles
	vec3_t viewanglespeed;
	viewhistory_t viewhistory;						// JUHOX
	float dynamicroamgoal_time;						// JUHOX: next time the roaming view goal for dynamic targets is to be determined
	qboolean hasDynamicRoamGoal;					// JUHOX
	vec3_t dynamicRoamGoal;							// JUHOX: only used if solely looking for dynamic roam goals
	float roamgoal_time;							// JUHOX: next time the roaming view goal is to be determined
	int roamgoalcnt;								// JUHOX: do not roam view if this is zero

	int ltgtype;									//long term goal type
	float singlebot_ltg_check_time;					// JUHOX
	float teamleader_ltg_check_time;				// JUHOX
	int groupFormationProposal;						// JUHOX: for group leaders
	float groupFormationProposalTime;				// JUHOX: time the groupFormationProposal will be set
	int oldMission;									// JUHOX: to be able to detect mission changes
	float missionChangeTime;						// JUHOX: last time the mission changed
	// team goals
	int teammate;									//team mate involved in this team goal
	int decisionmaker;								//player who decided to go for this goal
	int ordered;									//true if ordered to do something
	float order_time;								//time ordered to do something
	int owndecision_time;							//time the bot made it's own decision
	bot_goal_t teamgoal;							//the team goal
	bot_goal_t altroutegoal;						//alternative route goal
	float reachedaltroutegoal_time;					//time the bot reached the alt route goal
	float teammessage_time;							//time to message team mates what the bot is doing
	float teamgoal_time;							//time to stop helping team mate
	float teamgoal_checktime;						// JUHOX: time to check the teamgoal team mate
	float teammatevisible_time;						//last time the team mate was NOT visible
	int teamtaskpreference;							//team task preference
	// last ordered team goal
	int lastgoal_decisionmaker;
	int lastgoal_ltgtype;
	int lastgoal_teammate;
	bot_goal_t lastgoal_teamgoal;
	// for leading team mates
	int lead_teammate;								//team mate the bot is leading
	bot_goal_t lead_teamgoal;						//team goal while leading
	float lead_time;								//time leading someone
	float leadvisible_time;							//last time the team mate was visible
	float leadmessage_time;							//last time a messaged was sent to the team mate
	float leadbackup_time;							//time backing up towards team mate

	float noTeamLeaderGoal_time;					// JUHOX
	qboolean teamleadernotreachable;				// JUHOX
	float teamleaderreachable_time;					// JUHOX: last time the team leader was reachable

	int leader;										// client number or -1
	float leaderCheckTime;							// next time the leader is to be checked

	float teamgiveorders_time;						//time to give team orders
	float lastflagcapture_time;						//last time a flag was captured
	int numteammates;								//number of team mates
	int redflagstatus;								//0 = at base, 1 = not at base
	int blueflagstatus;								//0 = at base, 1 = not at base
	int neutralflagstatus;							//0 = at base, 1 = our team has flag, 2 = enemy team has flag, 3 = enemy team dropped the flag
	int flagstatuschanged;							//flag status changed
	int forceorders;								//true if forced to give orders
	int flagcarrier;								//team mate carrying the enemy flag
	int ctfstrategy;								//ctf strategy
	int humanHelpers[MAX_SUBTEAM_SIZE];				// JUHOX: the human helpers this bot has acquired
	float humanHelpersTime[MAX_SUBTEAM_SIZE];		// JUHOX: time the bot acquired the human helpers
	float visteammates_time;						// JUHOX: next time the visible teammates are to be determined
	int numvisteammates;							// JUHOX: number of the visible teammates
	int visteammates[MAX_SUBTEAM_SIZE];				// JUHOX: the visible teammates
	char subteam[32];								//sub team name
	float formation_dist;							//formation team mate intervening space
	char formation_teammate[16];					//netname of the team mate the bot uses for relative positioning
	float formation_angle;							//angle relative to the formation team mate
	vec3_t formation_dir;							//the direction the formation is moving in
	vec3_t formation_origin;						//origin the bot uses for relative positioning
	bot_goal_t formation_goal;						//formation goal

	bot_activategoal_t *activatestack;				//first activate goal on the stack
	bot_activategoal_t activategoalheap[MAX_ACTIVATESTACK];	//activate goal heap

	bot_waypoint_t *checkpoints;					//check points
	bot_waypoint_t *patrolpoints;					//patrol points
	bot_waypoint_t *curpatrolpoint;					//current patrol point the bot is going for
	int patrolflags;								//patrol flags
#if JUHOX_BOT_DEBUG
	qboolean debugThisBot;	// JUHOX
#endif
} bot_state_t;

//resets the whole bot state
void BotResetState(bot_state_t *bs);
//returns the number of bots in the game
int NumBots(void);
//returns info about the entity
void BotEntityInfo(int entnum, aas_entityinfo_t *info);

extern float floattime;
#define FloatTime() floattime

// from the game source
bot_state_t* BotAI_IsBot(int client);	// JUHOX
void	QDECL BotAI_Print(int type, char *fmt, ...);
void	QDECL QDECL BotAI_BotInitialChat( bot_state_t *bs, char *type, ... );
void	BotAI_Trace(bsp_trace_t *bsptrace, vec3_t start, vec3_t mins, vec3_t maxs, vec3_t end, int passent, int contentmask);
int		BotAI_GetClientState( int clientNum, playerState_t *state );
int		BotAI_GetEntityState( int entityNum, entityState_t *state );
int		BotAI_GetSnapshotEntity( int clientNum, int sequence, entityState_t *state );
int		BotTeamLeader(bot_state_t *bs);
float BotReactionTime(bot_state_t* bs);	// JUHOX
