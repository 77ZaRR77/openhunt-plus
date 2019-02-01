// Copyright (C) 1999-2000 Id Software, Inc.
//
// bg_public.h -- definitions shared by both the server game and client game modules

// because games can change separately from the main system version, we need a
// second version that must match between game and cgame

#ifndef __BG_PUBLIC_H	// JUHOX
#define __BG_PUBLIC_H	// JUHOX

#define	GAME_VERSION		"openhunt-1"	// JUHOX: was "baseq3-1"
#define TSSINCVAR			1	// JUHOX
#define MEETING				1	// JUHOX

#define NOT !	// JUHOX

// JUHOX: global definitions for random number generation
typedef struct {
	unsigned long seed0;
	unsigned long seed1;
	unsigned long seed2;
	unsigned long seed3;
} localseed_t;

// bg_misc.c
unsigned long LocallySeededRandom(localseed_t* seed);
void DeriveLocalSeed(localseed_t* source, localseed_t* destination);
float local_random(localseed_t* seed);
float local_crandom(localseed_t* seed);


// JUHOX: global definitions
#define GRAPPLE_PULL_SPEED_CLASSIC	800.0f
#define GRAPPLE_PULL_SPEED_TOOL		400.0f
#define GRAPPLE_PULL_SPEED_ANCHOR	400.0f
#define GRAPPLE_PULL_SPEED_COMBAT	800.0f
#define MAX_ROPE_ELEMENTS 160		// needs to be divisable by 8
#define ROPE_ELEMENT_SIZE 10.0f
typedef enum {
	HM_disabled,
	HM_classic,
	HM_tool,
	HM_anchor,
	HM_combat,

	HM_num_modes
} hookMode_t;


// JUHOX: global definitions
typedef enum {
	VIEW_standard,
	VIEW_scanner,
	VIEW_amplifier,

	VIEW_num_modes
} viewMode_t;
#define VIEWMODE_SWITCHING_TIME 200	// msec


// JUHOX: STU defines
#define EXTRA_CLIENTNUMS 5
typedef enum {
	MT_predator = 0,
	MT_guard,
	MT_titan,

	MT_num_types
} monsterType_t;
#define CLIENTNUM_MONSTERS MAX_CLIENTS
#define CLIENTNUM_MONSTER_PREDATOR (CLIENTNUM_MONSTERS+MT_predator)
#define CLIENTNUM_MONSTER_GUARD (CLIENTNUM_MONSTERS+MT_guard)
#define CLIENTNUM_MONSTER_TITAN (CLIENTNUM_MONSTERS+MT_titan)
#define CLIENTNUM_MONSTER_PREDATOR_RED (CLIENTNUM_MONSTERS+MT_num_types+0)
#define CLIENTNUM_MONSTER_PREDATOR_BLUE (CLIENTNUM_MONSTERS+MT_num_types+1)
#define MAX_MONSTERS 200
#define MONSTER_GUARD_SCALE 2.0f
#define MONSTER_TITAN_SCALE 3.5f

#define	DEFAULT_GRAVITY		800
#define	GIB_HEALTH			-40
#define	ARMOR_PROTECTION	0.66f

#define	MAX_ITEMS			256

#define	RANK_TIED_FLAG		0x4000

#define DEFAULT_SHOTGUN_SPREAD	1000	// JUHOX: was 700
#define DEFAULT_SHOTGUN_COUNT	15		// JUHOX: was 11

#define	ITEM_RADIUS			15		// item sizes are needed for client side pickup detection

#define	LIGHTNING_RANGE		500		// JUHOX: was 768
#define LIGHTNING_ALPHA_LIMIT 20	// JUHOX

#define	SCORE_NOT_PRESENT	-9999	// for the CS_SCORES[12] when only one player is present

#define	VOTE_TIME			30000	// 30 seconds before vote times out

#define RESPAWN_DELAY		1		// JUHOX: 0 for old behaviour
#define NAVAID_PACKETS		5		// JUHOX: (note that the number of EV_NAVAIDx definitions must match this number)
#define MACHINEGUN_WIND_UP_TIME 650		// JUHOX
#define MACHINEGUN_WIND_OFF_TIME 1000	// JUHOX
#define SPAWNHULL_FADEIN_TIME	500	// JUHOX
#define SPAWNHULL_FADEOUT_TIME	500	// JUHOX
#define SPAWNHULL_TIME (SPAWNHULL_FADEIN_TIME+SPAWNHULL_FADEOUT_TIME)	// JUHOX

#define	MINS_Z				-24
#define	DEFAULT_VIEWHEIGHT	26
#define CROUCH_VIEWHEIGHT	12
#define	DEAD_VIEWHEIGHT		-16
#define MAX_PLAYLIST_ENTRIES 100

// JUHOX: player flags stored in the modelindex
#define PFMI_FIGHTING                   0x01
#define PFMI_HIBERNATION_MODE			0x02
#define PFMI_HIBERNATION_DRAW_SEED		0x04
#define PFMI_HIBERNATION_DRAW_THREAD	0x08
#define PFMI_HIBERNATION_MORPHED		0x10



//
// config strings are a general means of communicating variable length strings
// from the server to all connected clients.
//

// CS_SERVERINFO and CS_SYSTEMINFO are defined in q_shared.h
#define	CS_MUSIC				2
#define	CS_MESSAGE				3		// from the map worldspawn's message field
#define	CS_MOTD					4		// g_motd string for server message of the day
#define	CS_WARMUP				5		// server time when the match will be restarted
#define	CS_SCORES1				6
#define	CS_SCORES2				7
#define CS_VOTE_TIME			8
#define CS_VOTE_STRING			9
#define	CS_VOTE_YES				10
#define	CS_VOTE_NO				11

#define CS_TEAMVOTE_TIME		12
#define CS_TEAMVOTE_STRING		14
#define	CS_TEAMVOTE_YES			16
#define	CS_TEAMVOTE_NO			18

#define	CS_GAME_VERSION			20
#define	CS_LEVEL_START_TIME		21		// so the timer only shows the current level
#define	CS_INTERMISSION			22		// when 1, fraglimit/timelimit has been hit and intermission will start in a second or two
#define CS_FLAGSTATUS			23		// string indicating flag status in CTF
#define CS_SHADERSTATE			24
#define CS_BOTINFO				25

#define	CS_ITEMS				27		// string of 0's and 1's that tell which items are present

#define	CS_MODELS				32
#define	CS_SOUNDS				(CS_MODELS+MAX_MODELS)
#define	CS_PLAYERS				(CS_SOUNDS+MAX_SOUNDS)
#define CS_LOCATIONS			(CS_PLAYERS+MAX_CLIENTS)
#define CS_MAX					(CS_LOCATIONS+MAX_LOCATIONS)
#define CS_NEARBOX				(CS_MAX+0)	// JUHOX
#define CS_MEETING				(CS_MAX+1)	// JUHOX
#define CS_HIGHSCORETEXT		(CS_MAX+2)	// JUHOX
#define CS_GAMESETTINGS			(CS_MAX+3)	// JUHOX
#define CS_CLIENTS_READY		(CS_MAX+4)	// JUHOX
#define CS_RECORD				(CS_MAX+5)	// JUHOX
#define CS_CHOOSENWEAPONS		(CS_MAX+6)	// JUHOX
// JUHOX: configstrings used by STU
#define CS_STU_SCORE			(CS_MAX+7)
#define CS_TIME_PLAYED			(CS_MAX+8)
#define CS_NUMMONSTERS			(CS_MAX+9)
// JUHOX: configstrings used by EFH
#define CS_EFH_GOAL_DISTANCE	(CS_MAX+10)
#define CS_EFH_SPEED			(CS_MAX+11)
#define CS_EFH_DEBUG			(CS_MAX+12)
#define CS_EFH_SEGMENT			(CS_MAX+13)	// for map debugging
#define CS_EFH_COVERED_DISTANCE	(CS_MAX+14)


#if (CS_MAX) > MAX_CONFIGSTRINGS
#error overflow: (CS_MAX) > MAX_CONFIGSTRINGS
#endif

typedef enum {
	GT_FFA,				// free for all
	GT_TOURNAMENT,		// one on one tournament
	GT_SINGLE_PLAYER,	// single player ffa

	//-- team games go after this --

	GT_TEAM,			// team deathmatch
	GT_CTF,				// capture the flag
	GT_1FCTF,
	GT_OBELISK,
	GT_HARVESTER,
	GT_STU,		// "save the universe"
	GT_EFH,		// "escape from hell"
	GT_MAX_GAME_TYPE
} gametype_t;

// JUHOX: global definitions for map lens flares
typedef enum {
	EM_none,
	EM_mlf		// map lens flares
} editMode_t;

typedef enum { GENDER_MALE, GENDER_FEMALE, GENDER_NEUTER } gender_t;

// JUHOX: definitions for game templates
typedef enum {
	TKS_missing,
	TKS_defaultValue,
	TKS_fixedValue
} templateKeyStatus_t;
typedef struct {
	// mandatory keys
	char templateName[64];
	gametype_t gametype;
	char mapName[64];

	// optional keys
	int minplayers;
	templateKeyStatus_t tksMinplayers;
	int maxplayers;
	templateKeyStatus_t tksMaxplayers;
	int highscoretype;
	templateKeyStatus_t	tksHighscoretype;
	char highscorename[64];
	templateKeyStatus_t	tksHighscorename;
	int gameseed;
	templateKeyStatus_t tksGameseed;
	int fraglimit;
	templateKeyStatus_t tksFraglimit;
	int timelimit;
	templateKeyStatus_t tksTimelimit;
	int distancelimit;
	templateKeyStatus_t tksDistancelimit;
	int artefacts;
	templateKeyStatus_t tksArtefacts;
	int respawndelay;
	templateKeyStatus_t tksRespawndelay;
	int basehealth;
	templateKeyStatus_t tksBasehealth;
	int challengingEnv;
	templateKeyStatus_t tksChallengingEnv;
	int monsterLauncher;
	templateKeyStatus_t tksScoremode;
	int scoremode;
	templateKeyStatus_t tksMonsterlauncher;
	int monsterLoad;
	templateKeyStatus_t tksMonsterload;
	int minmonsters;
	templateKeyStatus_t tksMinmonsters;
	int maxmonsters;
	templateKeyStatus_t tksMaxmonsters;
	int monsterspertrap;
	templateKeyStatus_t tksMonsterspertrap;
	int monsterspawndelay;
	templateKeyStatus_t tksMonsterspawndelay;
	int monsterhealthscale;
	templateKeyStatus_t tksMonsterhealthscale;
	int monsterprogressivehealth;
	templateKeyStatus_t	tksMonsterprogessivehealth;
	int guards;
	templateKeyStatus_t tksGuards;
	int titans;
	templateKeyStatus_t tksTitans;
	int monsterbreeding;
	templateKeyStatus_t tksMonsterbreeding;
	int friendlyfire;
	templateKeyStatus_t tksFriendlyfire;
	int stamina;
	templateKeyStatus_t tksStamina;
	int noitems;
	templateKeyStatus_t tksNoitems;
	int nohealthregen;
	templateKeyStatus_t tksNohealthregen;
	int cloakingdevice;
	templateKeyStatus_t tksCloakingdevice;
	int unlimitedammo;
	templateKeyStatus_t tksUnlimitedammo;
	int tss;
	templateKeyStatus_t tksTss;
	int tsssafetymode;
	templateKeyStatus_t tksTsssafetymode;
	int respawnatpod;
	templateKeyStatus_t tksRespawnatpod;
	int armorfragments;
	templateKeyStatus_t tksArmorfragments;
	int lightningdamagelimit;
	templateKeyStatus_t tksLightningdamagelimit;
	int grapple;
	templateKeyStatus_t tksGrapple;
	int dmflags;
	templateKeyStatus_t tksDmflags;
	int speed;
	templateKeyStatus_t tksSpeed;
	int knockback;
	templateKeyStatus_t tksKnockback;
	int gravity;
	templateKeyStatus_t tksGravity;
} gametemplate_t;
typedef enum {
	GC_none,
	GC_score,
	GC_time,
	GC_distance,
	GC_speed
} gameChallenge_t;

qboolean BG_ParseGameTemplate(const char* info, gametemplate_t* gt);

#define MAX_GAMETEMPLATES 1000
#define MAX_HIGHSCORE_DESCRIPTOR 768	// limits the string send over network
typedef struct {
	const char* cvar;
	const char* name;
	int originalIndex;
	qboolean deletable;
} templatelistentry_t;
typedef struct
{
	char buffer[65536];
	char* bufPos;
	templatelistentry_t entries[MAX_GAMETEMPLATES];
	int numEntries;
} gametemplatelist_t;

void BG_GetGameTemplateList(gametemplatelist_t* list, int numFiles, const char* fileList, qboolean sorted);
long BG_TemplateChecksum(const char* name, int highscoreType, const char* highscore, const char* highscoreDescriptor);
char BG_ChecksumChar(long checksum);
unsigned long BG_VectorChecksum(const vec3_t v);


// JUHOX: grapple states; these are stored in player's entityState.modelindex
typedef enum {
	GST_unused,	// silent
	GST_silent,	// silent
	GST_fixed,	// silent
	GST_windoff,
	GST_rewind,
	GST_pulling,
	GST_blocked
} grappleState_t;


// JUHOX: global definitions for EFH
#define REFERENCE_SHIFT 7

// JUHOX: definitions for the TSS
#define MAX_GROUPS 10
#define TSS_NAME_SIZE 32
#define TSS_STOCK_FILE "stock"
#define TSS_PALETTE_FILE "palette"

typedef struct tss_group_members_s {
	int minTotalMembers;	// 0 ... 100%
	int minAliveMembers;	// 0 ... 100% of 'minTotalMembers'
	int minReadyMembers;	// 0 ... 100% of 'minAliveMembers'
} tss_group_members_t;

typedef struct tss_division_s {
	int unassignedPlayers;
	tss_group_members_t group[MAX_GROUPS];
} tss_division_t;

// NOTE: 'BG_TSS_SetPlayerInfo()' reserves 3 bits for this
typedef enum {
	TSSMISSION_invalid,

	TSSMISSION_seek_enemy,
	TSSMISSION_seek_items,
	TSSMISSION_num_tdm_missions,

	TSSMISSION_capture_enemy_flag = TSSMISSION_num_tdm_missions,
	TSSMISSION_defend_our_flag,	// and return it if needed
	TSSMISSION_defend_our_base,	// and don't leave it
	TSSMISSION_occupy_enemy_base,	// and protect flag carrier if needed

	TSSMISSION_num_missions
} tss_mission_t;

typedef struct {
	tss_mission_t mission;
	int maxDanger;		// -100 ... +100
	int minReady;		// 0 ... 100% of 'minTotalMembers'
	int minGroupSize;	// 0 ... 100% of 'minTotalMembers'
	int maxGuards;		// # of guards
} tss_order_t;

typedef struct {
	tss_order_t order[MAX_GROUPS];
} tss_orders_t;

typedef struct tss_instructions_s {
	unsigned char groupOrganization[16];
	tss_division_t division;
	tss_orders_t orders;
} tss_instructions_t;

typedef enum {
	TSSPI_isValid,
	TSSPI_group,
	TSSPI_groupMemberStatus,
	TSSPI_mission,
	TSSPI_missionStatus,
	TSSPI_task,
	TSSPI_groupFormation,
	TSSPI_groupSize,
	TSSPI_membersAlive,
	TSSPI_membersReady,
	TSSPI_hyperspace,
	TSSPI_navAid,

	TSSPI_groupLeader,
	TSSPI_taskGoal,
	TSSPI_suggestedGF
} tss_playerInfo_t;

typedef enum {
	TSSGMS_retreating,
	TSSGMS_temporaryFighter,
	TSSGMS_designatedFighter,
	TSSGMS_temporaryLeader,
	TSSGMS_designatedLeader
} tss_groupMemberStatus_t;

typedef enum {
	TSSMS_valid,
	TSSMS_aborted
} tss_missionStatus_t;

// NOTE: 'BG_TSS_SetPlayerInfo()' reserves 4 bits for this
typedef enum {
	TSSMT_followGroupLeader,	// loose group formation
	TSSMT_stickToGroupLeader,	// tight group formation
	TSSMT_retreat,
	TSSMT_helpTeamMate,
	TSSMT_guardFlagCarrier,
	TSSMT_rushToBase,
	TSSMT_seekGroupMember,
	TSSMT_seekEnemyNearTeamMate,
	TSSMT_fulfilMission,		// also free group formation
	TSSMT_prepareForMission,

	TSSMT_num_tasks
} tss_missionTask_t;

typedef enum {
	TSSGF_tight,
	TSSGF_loose,
	TSSGF_free
} tss_groupFormation_t;

// the following items are needed by cgame & ui
#define TSS_MAX_STRATEGIES 1000
#define STSL_nameChanged_F 1
typedef struct tss_strategySlot_s {
	int id;	// 0 ... 999
	unsigned int creationTime;
	unsigned int accessTime;
	int flags;
	char filename[TSS_NAME_SIZE];
	char tssname[TSS_NAME_SIZE];
#if TSSINCVAR
	char cvarbase[TSS_NAME_SIZE];
#endif
} tss_strategySlot_t;
typedef struct tss_strategyStock_s {
	tss_strategySlot_t slots[TSS_MAX_STRATEGIES];
} tss_strategyStock_t;
typedef struct {
	char id[4];							// 'HUNT'
	int version;						// TSS_STRATEGY_VERSION
	int gametype;
	char generic[16];
	char name[TSS_NAME_SIZE];
} tss_strategyHeader_t;
#define TSS_FILE_SERVICE_PACKETS 64
#define TSS_FILE_SERVICE_PACKET_SIZE 250

#define TSS_PREDICATES_PER_CLAUSE 10
#define TSS_CLAUSES_PER_OCCASION 6
#define TSS_NON_DEFAULT_DIRECTIVES_PER_STRATEGY 26

typedef struct {
	unsigned char missionAndMaxGuards;	// mission | maxGuards (3bit)
	char maxDanger;
	char minReady;
	char minGroupSize;
} tss_packedOrder_t;
typedef struct {
	char groupOrganization;
	char minTotalMembers;
	char minAliveMembers;
	char minReadyMembers;
} tss_packedDivision_t;
typedef struct {
	tss_packedDivision_t division[MAX_GROUPS];
	tss_packedOrder_t orders[MAX_GROUPS];
} tss_packedInstructions_t;
//typedef /*unsigned*/ short tss_packedPredicate_t;	// magnitude * op * limit
//typedef tss_packedPredicate_t tss_packedClause_t[TSS_PREDICATES_PER_CLAUSE];	// without use flags
//typedef tss_packedClause_t tss_packedOccasion_t[TSS_CLAUSES_PER_OCCASION];
typedef unsigned char tss_packedOccasionClauseUseFlags_t;
#define TSS_PACKED_OCCASION_FLAGS_DIRECTIVE_USED 128
typedef struct {
	tss_packedInstructions_t instr;
	char magnitudes[TSS_CLAUSES_PER_OCCASION][TSS_PREDICATES_PER_CLAUSE];
	char operators[TSS_CLAUSES_PER_OCCASION][TSS_PREDICATES_PER_CLAUSE];
	char limits[TSS_CLAUSES_PER_OCCASION][TSS_PREDICATES_PER_CLAUSE];
	//tss_packedOccasion_t occasion;
	char name[TSS_NAME_SIZE];
} tss_packedDirective_t;
typedef struct {
	char id[4];							// 'HUNT'
	char version;						// TSS_STRATEGY_VERSION
	char gametype;
	char generic[18];
	char name[TSS_NAME_SIZE];
	char comment[64];
	tss_packedInstructions_t defaultInstructions;
	tss_packedDirective_t nonDefaultDirectives[TSS_NON_DEFAULT_DIRECTIVES_PER_STRATEGY];
	tss_packedOccasionClauseUseFlags_t nonDefaultDirectivesFlags[TSS_NON_DEFAULT_DIRECTIVES_PER_STRATEGY];
	char autoCondition;
	char rfa_dangerLimit;				// -100 ... +100
	char rfd_dangerLimit;				// -100 ... +100
	char short_term;					// % of respawn delay, currently unused
	char medium_term;					// % of respawn delay
	char long_term;						// % of respawn delay
	char unused[2];
} tss_packedStrategy_t;
typedef struct {
	char id[4];
	char version;
	char gametype;
	char generic[18];
	char name[TSS_NAME_SIZE];
} tss_packedStrategyHeader_t;

int BG_TSS_Proportion(int portion, int total, int newTotal);
int BG_TSS_TakeProportionAway(int portion, int* totalLeft, int* newTotalLeft);
void BG_TSS_AssignPlayers(
	int playersToAssign,					// quantity
	int (*groupSizes)[MAX_GROUPS],	// percentage
	int unassignedPlayers,					// percentage
	int (*assignments)[MAX_GROUPS]			// quantity
);
int TSS_CodeNibble(int n);
int TSS_DecodeNibble(int n);
void TSS_CodeInt(int n, char** buf);
int TSS_DecodeInt(const char** buf, int minimum, int maximum);
void BG_TSS_CodeInstructions(const tss_instructions_t* instr, char** buf);
void BG_TSS_DecodeInstructions(const char** buf, tss_instructions_t* instr);
void BG_TSS_CodeLeadership(
	const int* leaders1, const int* leaders2, const int* leaders3,
	const int* teamMateIndexToClientNum,
	char** buf
);
void BG_TSS_DecodeLeadership(const char** buf, int* leaders1, int* leaders2, int* leaders3);
void BG_TSS_SetPlayerInfo(playerState_t* ps, tss_playerInfo_t pi, int data);
int BG_TSS_GetPlayerInfo(const playerState_t* ps, tss_playerInfo_t pi);
int BG_TSS_GetPlayerEntityInfo(const entityState_t* es, tss_playerInfo_t pi);

/*
===================================================================================

PMOVE MODULE

The pmove code takes a player_state_t and a usercmd_t and generates a new player_state_t
and some other output data.  Used for local prediction on the client game and true
movement on the server game.
===================================================================================
*/

typedef enum {
	PM_NORMAL,		// can accelerate and turn
	PM_NOCLIP,		// noclip movement
	PM_SPECTATOR,	// still run into walls
	PM_DEAD,		// no acceleration or turning, but free falling
	PM_FREEZE,		// stuck in place with no control
	PM_INTERMISSION,	// no movement or status bar
	PM_SPINTERMISSION	// no movement or status bar
#if MEETING
	, PM_MEETING	// JUHOX
#endif
} pmtype_t;

typedef enum {
	WEAPON_READY,
	WEAPON_RAISING,
	WEAPON_DROPPING,
	WEAPON_FIRING,
	WEAPON_WIND_UP,
	WEAPON_WIND_OFF
} weaponstate_t;

// pmove->pm_flags
#define	PMF_DUCKED			1
#define	PMF_JUMP_HELD		2
#define	PMF_BACKWARDS_JUMP	8		// go into backwards land
#define	PMF_BACKWARDS_RUN	16		// coast down to backwards run
#define	PMF_TIME_LAND		32		// pm_time is time before rejump
#define	PMF_TIME_KNOCKBACK	64		// pm_time is an air-accelerate only time
#define	PMF_TIME_WATERJUMP	256		// pm_time is waterjump
#define	PMF_RESPAWNED		512		// clear after attack and jump buttons come up
#define	PMF_USE_ITEM_HELD	1024
#define PMF_GRAPPLE_PULL	2048	// pull towards grapple location
#define PMF_FOLLOW			4096	// spectate following another player
#define PMF_SCOREBOARD		8192	// spectate as a scoreboard
#define PMF_INVULEXPAND		16384	// invulnerability sphere set to full size

#define	PMF_ALL_TIMES	(PMF_TIME_WATERJUMP|PMF_TIME_LAND|PMF_TIME_KNOCKBACK)

#define	MAXTOUCH	32
typedef struct {
	// state (in / out)
	playerState_t	*ps;

	// command (in)
	usercmd_t	cmd;
	int			tracemask;			// collide against these types of surfaces
	int			debugLevel;			// if set, diagnostic output will be printed
	qboolean	noFootsteps;		// if the game is setup for no footsteps by the server
	qboolean	gauntletHit;		// true if a gauntlet attack would actually hit something

	int			framecount;

	vec3_t		target;				// JUHOX: origin of STAT_TARGET

	// JUHOX: definition for hook mode
	hookMode_t	hookMode;

	int			gametype;			// JUHOX

	// JUHOX: definition for monster vars
	vec_t		scale;
	qboolean	superJump;
	qboolean	hibernation;

	// results (out)
	int			numtouch;
	int			touchents[MAXTOUCH];

	vec3_t		mins, maxs;			// bounding box size

	int			watertype;
	int			waterlevel;

	float		xyspeed;

	// for fixed msec Pmove
	int			pmove_fixed;
	int			pmove_msec;

	// callbacks to test the world
	// these will be different functions during game and cgame
	void		(*trace)( trace_t *results, const vec3_t start, const vec3_t mins, const vec3_t maxs, const vec3_t end, int passEntityNum, int contentMask );
	int			(*pointcontents)( const vec3_t point, int passEntityNum );
} pmove_t;

// if a full pmove isn't done on the client, you can just update the angles
void PM_UpdateViewAngles( playerState_t *ps, const usercmd_t *cmd );
void Pmove (pmove_t *pmove);

//===================================================================================


// player_state->stats[] indexes
// NOTE: may not have more than 16
typedef enum {
    STAT_HEALTH,
    STAT_HOLDABLE_ITEM,
    STAT_WEAPONS,                   // 16 bit fields
    STAT_ARMOR,
    STAT_WEAPON_KICK,               // JUHOX: pitch speed
    STAT_MAX_HEALTH,                // health / armor limit, changable by handicap
    STAT_TARGET,                    // JUHOX: client number
    STAT_STRENGTH,
    STAT_PANT_PHASE,
    STAT_BUNDLED,                   // SLK: bundled STAT_EFFECT & STAT_GRAPPLE_STATE to free one slot for STAT_JUMPTIME
    //STAT_EFFECT,                  // JUHOX
    STAT_DETECTOR,                  // JUHOX
    //STAT_GRAPPLE_STATE,           // JUHOX
    STAT_GRAPPLE_SPEED,             // JUHOX
                                    // JUHOX: reference origin for EFH
    STAT_REFERENCE_X,
    STAT_REFERENCE_Y,
    STAT_REFERENCE_Z,
    STAT_JUMPTIME                   // SLK: used for CPM Physics
} statIndex_t;

// SLK defined macros to determine STATS_EFFECT and STAT_GRAPPLE_STATE which are now bundled into STAT_BUNDLED
#define GET_STAT_EFFECT(ps) ((ps)->stats[STAT_BUNDLED] & 0xff)
#define SET_STAT_EFFECT(ps, n) ((ps)->stats[STAT_BUNDLED]=((ps)->stats[STAT_BUNDLED] & 0xff00) + (n & 0xff))
#define GET_STAT_GRAPPLESTATE(ps) (((ps)->stats[STAT_BUNDLED] >>8) & 0xff)
//#define SET_STAT_GRAPPLESTATE (ps, n) (ps)->stats[STAT_BUNDLED] = (((ps)->stats[STAT_BUNDLED] & 0xff) + ((n & 0xff) << 8))
#define SET_STAT_GRAPPLESTATE(ps, n) ((ps)->stats[STAT_BUNDLED]=((ps)->stats[STAT_BUNDLED]&0xff)+((n & 0xff) <<8))

#define STAT_RESPAWN_INFO STAT_ARMOR	// JUHOX: remaining seconds & respawnLocationType_t, valid only if dead
#define WEAPON_KICK_FACTOR 50	        // JUHOX: for STAT_WEAPON_KICK

// JUHOX: STAT_RESPAWN_INFO values
typedef enum {
	RLT_here = 0,
	RLT_atPOD,
	RLT_regular,
	RLT_invalid
} respawnLocationType_t;

// JUHOX: STAT_EFFECT values
typedef enum {
	PE_spawn,
	PE_fade_in,
	PE_fade_out,
	PE_hibernation,
	PE_titan_awaking
} playerEffect_t;

#define STRENGTH_UNIT 100		// JUHOX
#define WEARINESS_FACTOR 3.0	// JUHOX: strength decrease is this times faster than strength increase
#define MAX_STRENGTH_TIME 60.0	// JUHOX: time in seconds of weariness
#define JUMP_WEARINESS 5.0		// JUHOX: time in seconds of weariness
#define LOW_STRENGTH_TIME 10.0	// JUHOX: time in seconds of weariness
// JUHOX: derived values
#define REFRESH_ONE_SECOND (STRENGTH_UNIT)	// refresh after one second of relax
#define WEARY_ONE_SECOND (WEARINESS_FACTOR*STRENGTH_UNIT)	// weariness after one second of fatigue
#define JUMP_STRENGTH_DECREASE (JUMP_WEARINESS*WEARY_ONE_SECOND) // weariness for one jump
#define MAX_STRENGTH_VALUE (MAX_STRENGTH_TIME*WEARY_ONE_SECOND)
#define LOW_STRENGTH_VALUE (LOW_STRENGTH_TIME*WEARY_ONE_SECOND)

// player_state->persistant[] indexes
// these fields are the only part of player_state that isn't
// cleared on respawn
// NOTE: may not have more than 16
typedef enum {
	PERS_SCORE,						// !!! MUST NOT CHANGE, SERVER AND GAME BOTH REFERENCE !!!
	PERS_HITS,						// total points damage inflicted so damage beeps can sound on change
	PERS_RANK,						// player rank or team rank
	PERS_TEAM,						// player team
	PERS_SPAWN_COUNT,				// incremented every respawn
	PERS_PLAYEREVENTS,				// 16 bits that can be flipped for events
	PERS_ATTACKER,					// clientnum of last damage inflicter
	PERS_ATTACKEE_ARMOR,			// health/armor of last person we attacked
	PERS_KILLED,					// count of the number of times you died
	// player awards tracking
	PERS_IMPRESSIVE_COUNT,			// two railgun hits in a row
	PERS_EXCELLENT_COUNT,			// two successive kills in a short amount of time
	PERS_DEFEND_COUNT,				// defend awards
	PERS_ASSIST_COUNT,				// assist awards
	PERS_GAUNTLET_FRAG_COUNT,		// kills with the guantlet
	PERS_CAPTURES					// captures
} persEnum_t;

#define PERS_LIGHT_X PERS_IMPRESSIVE_COUNT	// JUHOX
#define PERS_LIGHT_Y PERS_EXCELLENT_COUNT	// JUHOX
#define PERS_LIGHT_Z PERS_DEFEND_COUNT		// JUHOX
#define PERS_MIN_SEGMENT PERS_ASSIST_COUNT	// JUHOX
#define PERS_MAX_SEGMENT PERS_GAUNTLET_FRAG_COUNT	// JUHOX

// entityState_t->eFlags
#define	EF_DEAD				0x00000001		// don't draw a foe marker over players with EF_DEAD
#define	EF_TELEPORT_BIT		0x00000004		// toggled every time the origin abruptly changes
#define	EF_AWARD_EXCELLENT	0x00000008		// draw an excellent sprite
#define EF_PLAYER_EVENT		0x00000010
#define	EF_BOUNCE			0x00000010		// for missiles
#define	EF_BOUNCE_HALF		0x00000020		// for missiles
#define	EF_AWARD_GAUNTLET	0x00000040		// draw a gauntlet sprite
#define	EF_NODRAW			0x00000080		// may have an event, but no model (unspawned items)
#define	EF_FIRING			0x00000100		// for lightning gun
#define	EF_KAMIKAZE			0x00000200
#define	EF_MOVER_STOP		0x00000400		// will push otherwise
#define EF_AWARD_CAP		0x00000800		// draw the capture sprite
#define	EF_TALK				0x00001000		// draw a talk balloon
#define	EF_CONNECTION		0x00002000		// draw a connection trouble sprite
#define	EF_VOTED			0x00004000		// already cast a vote
#define	EF_AWARD_IMPRESSIVE	0x00008000		// draw an impressive sprite
#define	EF_AWARD_DEFEND		0x00010000		// draw a defend sprite
#define	EF_AWARD_ASSIST		0x00020000		// draw a assist sprite
#define EF_AWARD_DENIED		0x00040000		// denied
// JUHOX: new value for EF_TEAMVOTED
// this is needed because only 16bit of playerState_t.eFlags are transmitted over
// the net, and 'CG_TSS_DrawInterface()' references 'EF_TEAMVOTED'
// note that EF_TEAMVOTED uses now the currently unused value of EF_TICKING (see above)
#define EF_TEAMVOTED		0x00000002
#define EF_DUCKED			0x00000020		// JUHOX: for players

// NOTE: may not have more than 16
typedef enum {
	PW_NONE,

	PW_QUAD,
	PW_BATTLESUIT,
	PW_HASTE,
	PW_INVIS,
	PW_REGEN,
	PW_FLIGHT,
	PW_REDFLAG,
	PW_BLUEFLAG,
	PW_NEUTRALFLAG,
	PW_CHARGE,
	PW_SHIELD,
	PW_BFG_RELOADING,

	PW_NUM_POWERUPS

} powerup_t;
#define PW_EFFECT_TIME (PW_NUM_POWERUPS+0)	// JUHOX
#define PW_TSSDATA1 (PW_NUM_POWERUPS+1)	// JUHOX
#define PW_TSSDATA2 (PW_NUM_POWERUPS+2)	// JUHOX

typedef enum {
	HI_NONE,

	HI_TELEPORTER,
	HI_MEDKIT,
	HI_KAMIKAZE,
	HI_PORTAL,
	HI_INVULNERABILITY,

	HI_NUM_HOLDABLE
} holdable_t;


typedef enum {
	WP_NONE,

	WP_GAUNTLET,
	WP_MACHINEGUN,
	WP_SHOTGUN,
	WP_GRENADE_LAUNCHER,
	WP_ROCKET_LAUNCHER,
	WP_LIGHTNING,
	WP_RAILGUN,
	WP_PLASMAGUN,
	WP_BFG,
	WP_GRAPPLING_HOOK,
	WP_MONSTER_LAUNCHER,	// JUHOX
	WP_NUM_WEAPONS
} weapon_t;

// JUHOX: ammo definitions. refresh is per 10 seconds
#define WP_GAUNTLET_MAX_AMMO				-1
#define WP_GAUNTLET_AMMO_REFRESH			0.0f

#define WP_MACHINEGUN_MAX_AMMO				200
#define WP_MACHINEGUN_AMMO_REFRESH			15.0f

#define WP_SHOTGUN_MAX_AMMO					50
#define WP_SHOTGUN_AMMO_REFRESH				3.0f

#define WP_GRENADE_LAUNCHER_MAX_AMMO		100
#define WP_GRENADE_LAUNCHER_AMMO_REFRESH	5.0f

#define WP_ROCKET_LAUNCHER_MAX_AMMO			40
#define WP_ROCKET_LAUNCHER_AMMO_REFRESH		2.0f

#define WP_LIGHTNING_MAX_AMMO				800
#define WP_LIGHTNING_AMMO_REFRESH			20.0f

#define WP_RAILGUN_MAX_AMMO					6
#define WP_RAILGUN_AMMO_REFRESH				0.3f

#define WP_PLASMAGUN_MAX_AMMO				400
#define WP_PLASMAGUN_AMMO_REFRESH			10.0f

#define WP_BFG_MAX_AMMO						5
#define WP_BFG_AMMO_REFRESH					0.2f

#define WP_GRAPPLING_HOOK_MAX_AMMO			-1
#define WP_GRAPPLING_HOOK_AMMO_REFRESH		0.0f

#define WP_MONSTER_LAUNCHER_MAX_AMMO		0
#define WP_MONSTER_LAUNCHER_AMMO_REFRESH	3.0f

typedef struct {
	int maxAmmo;
	float ammoRefresh;
} weaponAmmoCharacteristic_t;

extern weaponAmmoCharacteristic_t weaponAmmoCharacteristics[];


// reward sounds (stored in ps->persistant[PERS_PLAYEREVENTS])
#define	PLAYEREVENT_DENIEDREWARD		0x0001
#define	PLAYEREVENT_GAUNTLETREWARD		0x0002
#define PLAYEREVENT_HOLYSHIT			0x0004

// entityState_t->event values
// entity events are for effects that take place reletive
// to an existing entities origin.  Very network efficient.

// two bits at the top of the entityState->event field
// will be incremented with each change in the event so
// that an identical event started twice in a row can
// be distinguished.  And off the value with ~EV_EVENT_BITS
// to retrieve the actual event number
#define	EV_EVENT_BIT1		0x00000100
#define	EV_EVENT_BIT2		0x00000200
#define	EV_EVENT_BITS		(EV_EVENT_BIT1|EV_EVENT_BIT2)

#define	EVENT_VALID_MSEC	300

typedef enum {
	EV_NONE,

	EV_FOOTSTEP,
	EV_FOOTSTEP_METAL,
	EV_FOOTSPLASH,
	EV_FOOTWADE,
	EV_SWIM,

	EV_STEP_4,
	EV_STEP_8,
	EV_STEP_12,
	EV_STEP_16,

	EV_FALL_SHORT,
	EV_FALL_MEDIUM,
	EV_FALL_FAR,

	EV_JUMP_PAD,			// boing sound at origin, jump sound on player

	EV_JUMP,
	EV_WATER_TOUCH,	// foot touches
	EV_WATER_LEAVE,	// foot leaves
	EV_WATER_UNDER,	// head touches
	EV_WATER_CLEAR,	// head leaves

	EV_ITEM_PICKUP,			// normal item pickups are predictable
	EV_GLOBAL_ITEM_PICKUP,	// powerup / team sounds are broadcast to everyone

	EV_NOAMMO,
	EV_CHANGE_WEAPON,
	EV_FIRE_WEAPON,

	EV_USE_ITEM0,
	EV_USE_ITEM1,
	EV_USE_ITEM2,
	EV_USE_ITEM3,
	EV_USE_ITEM4,
	EV_USE_ITEM5,
	EV_USE_ITEM6,
	EV_USE_ITEM7,
	EV_USE_ITEM8,
	EV_USE_ITEM9,
	EV_USE_ITEM10,
	EV_USE_ITEM11,
	EV_USE_ITEM12,
	EV_USE_ITEM13,
	EV_USE_ITEM14,
	EV_USE_ITEM15,

	EV_ITEM_RESPAWN,
	EV_ITEM_POP,
	EV_PLAYER_TELEPORT_IN,
	EV_PLAYER_TELEPORT_OUT,

	EV_GRENADE_BOUNCE,		// eventParm will be the soundindex
	EV_COCOON_BOUNCE,	// JUHOX

	EV_GENERAL_SOUND,
	EV_GLOBAL_SOUND,		// no attenuation
	EV_GLOBAL_TEAM_SOUND,

	EV_BULLET_HIT_FLESH,
	EV_BULLET_HIT_WALL,

	EV_MISSILE_HIT,
	EV_MISSILE_MISS,
	EV_MISSILE_MISS_METAL,
	EV_RAILTRAIL,
	EV_SHOTGUN,
	EV_BULLET,				// otherEntity is the shooter

	EV_PAIN,
	EV_DEATH1,
	EV_DEATH2,
	EV_DEATH3,
	EV_OBITUARY,

	EV_POWERUP_QUAD,
	EV_POWERUP_BATTLESUIT,
	EV_POWERUP_REGEN,

	EV_GIB_PLAYER,			// gib a previously living player
	EV_SCOREPLUM,			// score plum


	EV_PROXIMITY_MINE_STICK,
	EV_PROXIMITY_MINE_TRIGGER,
	EV_KAMIKAZE,			// kamikaze explodes
	EV_OBELISKEXPLODE,		// obelisk explodes
	EV_OBELISKPAIN,			// obelisk is in pain
	EV_INVUL_IMPACT,		// invulnerability sphere impact
	EV_JUICED,				// invulnerability juiced effect
	EV_LIGHTNINGBOLT,		// lightning bolt bounced of invulnerability sphere

	EV_DEBUG_LINE,
	EV_STOPLOOPINGSOUND,
	EV_TAUNT,
	EV_TAUNT_YES,
	EV_TAUNT_NO,
	EV_TAUNT_FOLLOWME,
	EV_TAUNT_GETFLAG,
	EV_TAUNT_GUARDBASE,
	EV_TAUNT_PATROL

	// JUHOX: new event types
	,EV_OVERKILL
	,EV_DISCHARGE_FLASH
	,EV_PANT
	,EV_BOUNCE_ARMOR
	,EV_NAVAID0
	,EV_NAVAID1
	,EV_NAVAID2
	,EV_NAVAID3
	,EV_NAVAID4
	,EV_EARTHQUAKE
	,EV_THROW_HOOK
	,EV_ROPE_EXPLOSION

} entity_event_t;


typedef enum {
	GTS_RED_CAPTURE,
	GTS_BLUE_CAPTURE,
	GTS_RED_RETURN,
	GTS_BLUE_RETURN,
	GTS_RED_TAKEN,
	GTS_BLUE_TAKEN,
	GTS_REDOBELISK_ATTACKED,
	GTS_BLUEOBELISK_ATTACKED,
	GTS_REDTEAM_SCORED,
	GTS_BLUETEAM_SCORED,
	GTS_REDTEAM_TOOK_LEAD,
	GTS_BLUETEAM_TOOK_LEAD,
	GTS_TEAMS_ARE_TIED,
	GTS_KAMIKAZE
} global_team_sound_t;

// animations
typedef enum {
	BOTH_DEATH1,
	BOTH_DEAD1,
	BOTH_DEATH2,
	BOTH_DEAD2,
	BOTH_DEATH3,
	BOTH_DEAD3,

	TORSO_GESTURE,

	TORSO_ATTACK,
	TORSO_ATTACK2,

	TORSO_DROP,
	TORSO_RAISE,

	TORSO_STAND,
	TORSO_STAND2,

	LEGS_WALKCR,
	LEGS_WALK,
	LEGS_RUN,
	LEGS_BACK,
	LEGS_SWIM,

	LEGS_JUMP,
	LEGS_LAND,

	LEGS_JUMPB,
	LEGS_LANDB,

	LEGS_IDLE,
	LEGS_IDLECR,

	LEGS_TURN,

	TORSO_GETFLAG,
	TORSO_GUARDBASE,
	TORSO_PATROL,
	TORSO_FOLLOWME,
	TORSO_AFFIRMATIVE,
	TORSO_NEGATIVE,

	MAX_ANIMATIONS,

	LEGS_BACKCR,
	LEGS_BACKWALK,
	FLAG_RUN,
	FLAG_STAND,
	FLAG_STAND2RUN,

	MAX_TOTALANIMATIONS
} animNumber_t;


typedef struct animation_s {
	int		firstFrame;
	int		numFrames;
	int		loopFrames;			// 0 to numFrames
	int		frameLerp;			// msec between frames
	int		initialLerp;		// msec to get to first frame
	int		reversed;			// true if animation is reversed
	int		flipflop;			// true if animation should flipflop back to base
} animation_t;


// flip the togglebit every time an animation
// changes so a restart of the same anim can be detected
#define	ANIM_TOGGLEBIT		128


typedef enum {
	TEAM_FREE,
	TEAM_RED,
	TEAM_BLUE,
	TEAM_SPECTATOR,

	TEAM_NUM_TEAMS
} team_t;

// Time between location updates
#define TEAM_LOCATION_UPDATE_TIME		1000

// How many players on the overlay
#define TEAM_MAXOVERLAY		32

//team task
typedef enum {
	TEAMTASK_NONE,
	TEAMTASK_OFFENSE,
	TEAMTASK_DEFENSE,
	TEAMTASK_PATROL,
	TEAMTASK_FOLLOW,
	TEAMTASK_RETRIEVE,
	TEAMTASK_ESCORT,
	TEAMTASK_CAMP
} teamtask_t;

// means of death
typedef enum {
	MOD_UNKNOWN,
	MOD_SHOTGUN,
	MOD_GAUNTLET,
	MOD_CLAW,		        // JUHOX
	MOD_GUARD,		        // JUHOX
	MOD_TITAN,	            // JUHOX
	MOD_MONSTER_LAUNCHER,	// JUHOX
	MOD_CHARGE,		        // JUHOX
	MOD_MACHINEGUN,
	MOD_GRENADE,
	MOD_GRENADE_SPLASH,
	MOD_ROCKET,
	MOD_ROCKET_SPLASH,
	MOD_PLASMA,
	MOD_PLASMA_SPLASH,
	MOD_RAILGUN,
	MOD_LIGHTNING,
	MOD_BFG,
	MOD_BFG_SPLASH,
	MOD_WATER,
	MOD_SLIME,
	MOD_LAVA,
	MOD_CRUSH,
	MOD_TELEFRAG,
	MOD_FALLING,
	MOD_SUICIDE,
	MOD_TARGET_LASER,
	MOD_TRIGGER_HURT,
	MOD_GRAPPLE
} meansOfDeath_t;


//---------------------------------------------------------

// gitem_t->type
typedef enum {
	IT_BAD,
	IT_WEAPON,				// EFX: rotate + upscale + minlight
	IT_AMMO,				// EFX: rotate
	IT_ARMOR,				// EFX: rotate + minlight
	IT_HEALTH,				// EFX: static external sphere + rotating internal
	IT_POWERUP,				// instant on, timer based
							// EFX: rotate + external ring that rotates
	IT_HOLDABLE,			// single use, holdable item
							// EFX: rotate + bob
	IT_PERSISTANT_POWERUP,
	IT_TEAM,
	IT_POD_MARKER			// JUHOX: rotate + countdown
} itemType_t;

#define MAX_ITEM_MODELS 4

typedef struct gitem_s {
	char		*classname;	// spawning name
	char		*pickup_sound;
	char		*world_model[MAX_ITEM_MODELS];

	char		*icon;
	char		*pickup_name;	// for printing on pickup

	int			quantity;		// for ammo how much, or duration of powerup
	itemType_t  giType;			// IT_* flags

	int			giTag;

	char		*precaches;		// string of all models and images this item will use
	char		*sounds;		// string of all sounds this item will use
} gitem_t;

// included in both the game dll and the client
extern	gitem_t	bg_itemlist[];
extern	int		bg_numItems;

gitem_t	*BG_FindItem( const char *pickupName );
gitem_t	*BG_FindItemForWeapon( weapon_t weapon );
gitem_t	*BG_FindItemForPowerup( powerup_t pw );
gitem_t	*BG_FindItemForHoldable( holdable_t pw );
#define	ITEM_INDEX(x) ((x)-bg_itemlist)

qboolean	BG_CanItemBeGrabbed( int gametype, const entityState_t *ent, const playerState_t *ps );


// g_dmflags->integer flags
#define	DF_NO_FALLING			8
#define DF_FIXED_FOV			16
#define	DF_NO_FOOTSTEPS			32

// content masks
#define	MASK_ALL				(-1)
#define	MASK_SOLID				(CONTENTS_SOLID)
#define	MASK_PLAYERSOLID		(CONTENTS_SOLID|CONTENTS_PLAYERCLIP|CONTENTS_BODY)
#define	MASK_DEADSOLID			(CONTENTS_SOLID|CONTENTS_PLAYERCLIP)
#define	MASK_WATER				(CONTENTS_WATER|CONTENTS_LAVA|CONTENTS_SLIME)
#define	MASK_OPAQUE				(CONTENTS_SOLID|CONTENTS_SLIME|CONTENTS_LAVA)
#define	MASK_SHOT				(CONTENTS_SOLID|CONTENTS_BODY|CONTENTS_CORPSE)


//
// entityState_t->eType
//
typedef enum {
	ET_GENERAL,
	ET_PLAYER,
	ET_ITEM,
	ET_MISSILE,
	ET_MOVER,
	ET_BEAM,
	ET_PORTAL,
	ET_SPEAKER,
	ET_PUSH_TRIGGER,
	ET_TELEPORT_TRIGGER,
	ET_INVISIBLE,
	ET_GRAPPLE,				// grapple hooked on wall
	ET_GRAPPLE_ROPE,		// JUHOX
	ET_TEAM,
	ET_EVENTS				// any of the EV_* events can be added freestanding
							// by setting eType to ET_EVENTS + eventNum
							// this avoids having to set eFlags and eventNum
} entityType_t;


void	BG_EvaluateTrajectory( const trajectory_t *tr, int atTime, vec3_t result );
void	BG_EvaluateTrajectoryDelta( const trajectory_t *tr, int atTime, vec3_t result );

void	BG_AddPredictableEventToPlayerstate( int newEvent, int eventParm, playerState_t *ps );

void	BG_TouchJumpPad( playerState_t *ps, entityState_t *jumppad );

void	BG_PlayerStateToEntityState( playerState_t *ps, entityState_t *s, qboolean snap );
void	BG_PlayerStateToEntityStateExtraPolate( playerState_t *ps, entityState_t *s, int time, qboolean snap );

qboolean	BG_PlayerTouchesItem( playerState_t *ps, entityState_t *item, int atTime );

float BG_PlayerTargetOffset(const entityState_t* state, float pos);	// JUHOX
#define GAUNTLET_TARGET_POS		0.75	// JUHOX
#define LIGHTNING_TARGET_POS	0.5		// JUHOX
#define DEFAULT_TARGET_POS		0.5		// JUHOX


#define ARENAS_PER_TIER		4
#define MAX_ARENAS			1024
#define	MAX_ARENAS_TEXT		8192

#define MAX_BOTS			1024
#define MAX_BOTS_TEXT		8192

// Kamikaze

// 1st shockwave times
#define KAMI_SHOCKWAVE_STARTTIME		0
#define KAMI_SHOCKWAVEFADE_STARTTIME	1500
#define KAMI_SHOCKWAVE_ENDTIME			2000
// explosion/implosion times
#define KAMI_EXPLODE_STARTTIME			250
#define KAMI_IMPLODE_STARTTIME			2000
#define KAMI_IMPLODE_ENDTIME			2250
// 2nd shockwave times
#define KAMI_SHOCKWAVE2_STARTTIME		2000
#define KAMI_SHOCKWAVE2FADE_STARTTIME	2500
#define KAMI_SHOCKWAVE2_ENDTIME			3000
// radius of the models without scaling
#define KAMI_SHOCKWAVEMODEL_RADIUS		88
#define KAMI_BOOMSPHEREMODEL_RADIUS		72
// maximum radius of the models during the effect
#define KAMI_SHOCKWAVE_MAXRADIUS		1320
#define KAMI_BOOMSPHERE_MAXRADIUS		720
#define KAMI_SHOCKWAVE2_MAXRADIUS		704

#endif	// JUHOX: __BG_PUBLIC_H
