// Copyright (C) 1999-2000 Id Software, Inc.
//
/*
=======================================================================

CONTROLS MENU

=======================================================================
*/


#include "ui_local.h"

#define ART_BACK0			"menu/art/back_0"
#define ART_BACK1			"menu/art/back_1"
#define ART_FRAMEL			"menu/art/frame2_l"
#define ART_FRAMER			"menu/art/frame1_r"


typedef struct {
	char	*command;
	char	*label;
	int		id;
	int		anim;
	int		defaultbind1;
	int		defaultbind2;
	int		bind1;
	int		bind2;
} bind_t;

typedef struct
{
	char*	name;
	float	defaultvalue;
	float	value;
} configcvar_t;

#define SAVE_NOOP		0
#define SAVE_YES		1
#define SAVE_NO			2
#define SAVE_CANCEL		3

// control sections
#define C_MOVEMENT		0
#define C_LOOKING		1
#define C_WEAPONS		2
#define C_MISC			3
#define C_PRIOS			4		// JUHOX
#define C_MAX			/*4*/5	// JUHOX

#define ID_MOVEMENT		100
#define ID_LOOKING		101
#define ID_WEAPONS		102
#define ID_MISC			103
#define ID_DEFAULTS		104
#define ID_BACK			105
#define ID_SAVEANDEXIT	106
#define ID_EXIT			107
#define ID_PRIOS		108	// JUHOX

// bindable actions
#define ID_SHOWSCORES	0
#define ID_USEITEM		1
#define ID_SPEED		2
#define ID_FORWARD		3
#define ID_BACKPEDAL	4
#define ID_MOVELEFT		5
#define ID_MOVERIGHT	6
#define ID_MOVEUP		7
#define ID_MOVEDOWN		8
#define ID_LEFT			9
#define ID_RIGHT		10
#define ID_STRAFE		11
#define ID_LOOKUP		12
#define ID_LOOKDOWN		13
#define ID_MOUSELOOK	14
#define ID_CENTERVIEW	15
#define ID_ZOOMVIEW		16
#define ID_WEAPON1		17
#define ID_WEAPON2		18
#define ID_WEAPON3		19
#define ID_WEAPON4		20
#define ID_WEAPON5		21
#define ID_WEAPON6		22
#define ID_WEAPON7		23
#define ID_WEAPON8		24
#define ID_WEAPON9		25
#define ID_ATTACK		26
#define ID_WEAPPREV		27
#define ID_WEAPNEXT		28
#define ID_GESTURE		29
#define ID_CHAT			30
#define ID_CHAT2		31
#define ID_CHAT3		32
#define ID_CHAT4		33
#define ID_WEAPBEST		34	// JUHOX
#define ID_GIVEHEALTH	35	// JUHOX
#define ID_GIVEARMOR	36	// JUHOX
#define ID_NEXTWPORD	37	// JUHOX
#define ID_PREVWPORD	38	// JUHOX
#define ID_WEAPSKIP		39	// JUHOX
#define ID_TSSI			40	// JUHOX
#define ID_NAVAID		41	// JUHOX
#define ID_GF_TIGHT		42	// JUHOX
#define ID_GF_LOOSE		43	// JUHOX
#define ID_GF_FREE		44	// JUHOX
#define ID_HOLD_BREATH	45	// JUHOX
#define ID_WEAPCAT0		46	// JUHOX
#define ID_WEAPCAT1		47	// JUHOX
#define ID_WEAPCAT2		48	// JUHOX
#define ID_WEAPCAT3		49	// JUHOX
#define ID_WEAPCAT4		50	// JUHOX
#define ID_WEAPCAT5		51	// JUHOX
#define ID_WEAPON10		52	// JUHOX
#define ID_TOGGLEHOOK	53	// JUHOX
#define ID_THROWHOOK	54	// JUHOX
#define ID_WEAPON11		55	// JUHOX
#define ID_TOGGLEVIEW	56	// JUHOX

// all others
#define ID_FREELOOK		34
#define ID_INVERTMOUSE	35
#define ID_ALWAYSRUN	36
#define ID_AUTOSWITCH	37
#define ID_MOUSESPEED	38
#define ID_JOYENABLE	39
#define ID_JOYTHRESHOLD	40
#define ID_SMOOTHMOUSE	41
#define ID_AUTOSWITCHAMMOLIMIT 42	// JUHOX
#define ID_WEAPONORDERSWITCH 43		// JUHOX

#define ANIM_IDLE		0
#define ANIM_RUN		1
#define ANIM_WALK		2
#define ANIM_BACK		3
#define ANIM_JUMP		4
#define ANIM_CROUCH		5
#define ANIM_STEPLEFT	6
#define ANIM_STEPRIGHT	7
#define ANIM_TURNLEFT	8
#define ANIM_TURNRIGHT	9
#define ANIM_LOOKUP		10
#define ANIM_LOOKDOWN	11
#define ANIM_WEAPON1	12
#define ANIM_WEAPON2	13
#define ANIM_WEAPON3	14
#define ANIM_WEAPON4	15
#define ANIM_WEAPON5	16
#define ANIM_WEAPON6	17
#define ANIM_WEAPON7	18
#define ANIM_WEAPON8	19
#define ANIM_WEAPON9	20
#define ANIM_WEAPON10	21
#define ANIM_ATTACK		22
#define ANIM_GESTURE	23
#define ANIM_DIE		24
#define ANIM_CHAT		25
#define ANIM_WEAPON11	26	// JUHOX
#define WEAPONLIST_SIZE 10	// JUHOX


typedef struct
{
	menuframework_s		menu;

	menutext_s			banner;
	menubitmap_s		framel;
	menubitmap_s		framer;
	menubitmap_s		player;

	menutext_s			movement;
	menutext_s			looking;
	menutext_s			weapons;
	menutext_s			prios;	// JUHOX
	menutext_s			misc;

	menuaction_s		walkforward;
	menuaction_s		backpedal;
	menuaction_s		stepleft;
	menuaction_s		stepright;
	menuaction_s		moveup;
	menuaction_s		movedown;
	menuaction_s		turnleft;
	menuaction_s		turnright;
	menuaction_s		sidestep;
	menuaction_s		run;
	menuaction_s		holdBreath;	// JUHOX
	menuaction_s		machinegun;
	menuaction_s		chainsaw;
	menuaction_s		shotgun;
	menuaction_s		grenadelauncher;
	menuaction_s		rocketlauncher;
	menuaction_s		lightning;
	menuaction_s		railgun;
	menuaction_s		plasma;
	menuaction_s		bfg;
	menuaction_s		monsterlauncher;	// JUHOX
	menuaction_s		grapple;	// JUHOX
	menuaction_s		toggleHook;	// JUHOX
	menuaction_s		throwHook;	// JUHOX
	menuradiobutton_s	crouchingCutsRope;	// JUHOX
	menuaction_s		attack;
	menuaction_s		prevweapon;
	menuaction_s		nextweapon;
	menuaction_s		bestweapon;	// JUHOX
	menuaction_s		skipweapon;	// JUHOX
	menuaction_s		lookup;
	menuaction_s		lookdown;
	menuaction_s		mouselook;
	menuradiobutton_s	freelook;
	menuaction_s		centerview;
	menuaction_s		zoomview;
	menuaction_s		toggleview;	// JUHOX
	menuaction_s		gesture;
	menuradiobutton_s	invertmouse;
	menuslider_s		sensitivity;
	menuradiobutton_s	smoothmouse;
	menuradiobutton_s	alwaysrun;
	menuaction_s		showscores;
	menuradiobutton_s	autoswitch;
	menuaction_s		useitem;
	playerInfo_t		playerinfo;
	qboolean			changesmade;
	menuaction_s		chat;
	menuaction_s		chat2;
	menuaction_s		chat3;
	menuaction_s		chat4;
	menuaction_s		givehealth;	// JUHOX
	menuaction_s		givearmor;	// JUHOX
	menuaction_s		tssInterface;	// JUHOX
	menuaction_s		navAid;	// JUHOX
	menuaction_s		gfTight;	// JUHOX
	menuaction_s		gfLoose;	// JUHOX
	menuaction_s		gfFree;		// JUHOX
	menuradiobutton_s	joyenable;
	menuslider_s		joythreshold;
	menufield_s			autoswitchAmmoLimit;	// JUHOX
	menuaction_s		nextWeaponOrder;		// JUHOX
	menuaction_s		prevWeaponOrder;		// JUHOX
	menufield_s			weaponOrderName;		// JUHOX
	menuaction_s		weaponCategory;			// JUHOX
	int					currentlyDrawnWeaponOrderName;	// JUHOX
	menuaction_s		weaponOrderSwitch;		// JUHOX
	menuaction_s		weaponList[WEAPONLIST_SIZE];	// JUHOX
	int					currentWeaponOrder;		// JUHOX
	int					weaponListSelection;	// JUHOX
	int					section;
	qboolean			waitingforkey;
	char				playerModel[64];
	vec3_t				playerViewangles;
	vec3_t				playerMoveangles;
	int					playerLegs;
	int					playerTorso;
	int					playerWeapon;
	qboolean			playerChat;

	menubitmap_s		back;
	menutext_s			name;
} controls_t;

static controls_t s_controls;

static vec4_t controls_binding_color  = {1.00f, 0.43f, 0.00f, 1.00f}; // bk: Win32 C4305

static bind_t g_bindings[] =
{
	{"+scores",			"show scores",		ID_SHOWSCORES,	ANIM_IDLE,		K_TAB,			-1,		-1, -1},
	{"+button2",		"use item",			ID_USEITEM,		ANIM_IDLE,		K_ENTER,		-1,		-1, -1},
	{"+speed", 			"run / walk",		ID_SPEED,		ANIM_RUN,		K_SHIFT,		-1,		-1,	-1},
	{"+forward", 		"walk forward",		ID_FORWARD,		ANIM_WALK,		K_UPARROW,		-1,		-1, -1},
	{"+back", 			"backpedal",		ID_BACKPEDAL,	ANIM_BACK,		K_DOWNARROW,	-1,		-1, -1},
	{"+moveleft", 		"step left",		ID_MOVELEFT,	ANIM_STEPLEFT,	',',			-1,		-1, -1},
	{"+moveright", 		"step right",		ID_MOVERIGHT,	ANIM_STEPRIGHT,	'.',			-1,		-1, -1},
	{"+moveup",			"up / jump",		ID_MOVEUP,		ANIM_JUMP,		K_SPACE,		-1,		-1, -1},
	{"+movedown",		"down / crouch",	ID_MOVEDOWN,	ANIM_CROUCH,	'c',			-1,		-1, -1},
	{"+left", 			"turn left",		ID_LEFT,		ANIM_TURNLEFT,	K_LEFTARROW,	-1,		-1, -1},
	{"+right", 			"turn right",		ID_RIGHT,		ANIM_TURNRIGHT,	K_RIGHTARROW,	-1,		-1, -1},
	{"+strafe", 		"sidestep / turn",	ID_STRAFE,		ANIM_IDLE,		K_ALT,			-1,		-1, -1},
	{"+lookup", 		"look up",			ID_LOOKUP,		ANIM_LOOKUP,	K_PGDN,			-1,		-1, -1},
	{"+lookdown", 		"look down",		ID_LOOKDOWN,	ANIM_LOOKDOWN,	K_DEL,			-1,		-1, -1},
	{"+mlook", 			"mouse look",		ID_MOUSELOOK,	ANIM_IDLE,		'/',			-1,		-1, -1},
	{"centerview", 		"center view",		ID_CENTERVIEW,	ANIM_IDLE,		K_END,			-1,		-1, -1},
	{"+zoom", 			"zoom view",		ID_ZOOMVIEW,	ANIM_IDLE,		-1,				-1,		-1, -1},
	{"weapon 1",		"gauntlet",			ID_WEAPON1,		ANIM_WEAPON1,	'1',			-1,		-1, -1},
	{"weapon 2",		"machinegun",		ID_WEAPON2,		ANIM_WEAPON2,	'2',			-1,		-1, -1},
	{"weapon 3",		"shotgun",			ID_WEAPON3,		ANIM_WEAPON3,	'3',			-1,		-1, -1},
	{"weapon 4",		"grenade launcher",	ID_WEAPON4,		ANIM_WEAPON4,	'4',			-1,		-1, -1},
	{"weapon 5",		"rocket launcher",	ID_WEAPON5,		ANIM_WEAPON5,	'5',			-1,		-1, -1},
	{"weapon 6",		"lightning",		ID_WEAPON6,		ANIM_WEAPON6,	'6',			-1,		-1, -1},
	{"weapon 7",		"railgun",			ID_WEAPON7,		ANIM_WEAPON7,	'7',			-1,		-1, -1},
	{"weapon 8",		"plasma gun",		ID_WEAPON8,		ANIM_WEAPON8,	'8',			-1,		-1, -1},
	{"weapon 9",		"BFG",				ID_WEAPON9,		ANIM_WEAPON9,	'9',			-1,		-1, -1},
	{"+attack", 		"attack",			ID_ATTACK,		ANIM_ATTACK,	K_CTRL,			-1,		-1, -1},
	{"weapprev",		"prev weapon",		ID_WEAPPREV,	ANIM_IDLE,		'[',			-1,		-1, -1},
	{"weapnext", 		"next weapon",		ID_WEAPNEXT,	ANIM_IDLE,		']',			-1,		-1, -1},
	{"+button3", 		"gesture",			ID_GESTURE,		ANIM_GESTURE,	K_MOUSE3,		-1,		-1, -1},
	{"messagemode", 	"chat",				ID_CHAT,		ANIM_CHAT,		't',			-1,		-1, -1},
	{"messagemode2", 	"chat - team",		ID_CHAT2,		ANIM_CHAT,		-1,				-1,		-1, -1},
	{"messagemode3", 	"chat - target",	ID_CHAT3,		ANIM_CHAT,		-1,				-1,		-1, -1},
	{"messagemode4", 	"chat - attacker",	ID_CHAT4,		ANIM_CHAT,		-1,				-1,		-1, -1},
	{"weapbest",		"best weapon",		ID_WEAPBEST,	ANIM_IDLE,		-1,				-1,		-1,	-1},	// JUHOX
	{"drophealth",		"give health",		ID_GIVEHEALTH,	ANIM_IDLE,		-1,				-1,		-1,	-1},	// JUHOX
	{"droparmor",		"give armor",		ID_GIVEARMOR,	ANIM_IDLE,		-1,				-1,		-1,	-1},	// JUHOX
	{"nextweaporder",	"next category",	ID_NEXTWPORD,	ANIM_IDLE,		-1,				-1,		-1,	-1},	// JUHOX
	{"prevweaporder",	"prev category",	ID_PREVWPORD,	ANIM_IDLE,		-1,				-1,		-1, -1},	// JUHOX
	{"weapskip",		"skip weapon",		ID_WEAPSKIP,	ANIM_IDLE,		-1,				-1,		-1,	-1},	// JUHOX
	{"tssinterface",	"TSS interface",	ID_TSSI,		ANIM_CHAT,		-1,				-1,		-1,	-1},	// JUHOX
	{"navaid",			"navigation aid",	ID_NAVAID,		ANIM_IDLE,		-1,				-1,		-1,	-1},	// JUHOX
	{"groupformation tight","Stick to me!",	ID_GF_TIGHT,	ANIM_IDLE,		-1,				-1,		-1,	-1},	// JUHOX
	{"groupformation loose","Support me!",	ID_GF_LOOSE,	ANIM_IDLE,		-1,				-1,		-1,	-1},	// JUHOX
	{"groupformation free","Go! Go! Go!",	ID_GF_FREE,		ANIM_IDLE,		-1,				-1,		-1,	-1},	// JUHOX
	{"+button12",		"hold breath",		ID_HOLD_BREATH,	ANIM_IDLE,		-1,				-1,		-1,	-1},	// JUHOX
	{"weapbest 0",		"category key",		ID_WEAPCAT0,	ANIM_IDLE,		-1,				-1,		-1,	-1},	// JUHOX
	{"weapbest 1",		"category key",		ID_WEAPCAT1,	ANIM_IDLE,		-1,				-1,		-1,	-1},	// JUHOX
	{"weapbest 2",		"category key",		ID_WEAPCAT2,	ANIM_IDLE,		-1,				-1,		-1,	-1},	// JUHOX
	{"weapbest 3",		"category key",		ID_WEAPCAT3,	ANIM_IDLE,		-1,				-1,		-1,	-1},	// JUHOX
	{"weapbest 4",		"category key",		ID_WEAPCAT4,	ANIM_IDLE,		-1,				-1,		-1,	-1},	// JUHOX
	{"weapbest 5",		"category key",		ID_WEAPCAT5,	ANIM_IDLE,		-1,				-1,		-1,	-1},	// JUHOX
	{"weapon 10",		"grappling hook",	ID_WEAPON10,	ANIM_WEAPON10,	'0',			-1,		-1,	-1},	// JUHOX
	{"throwhook",		"use grapple (toggle)", ID_TOGGLEHOOK, ANIM_IDLE,	-1,				-1,		-1,	-1},	// JUHOX
	{"+throwhook",		"use grapple (hold)  ", ID_THROWHOOK, ANIM_IDLE,	-1,				-1,		-1,	-1},	// JUHOX
	{"weapon 11",		"monster launcher",	ID_WEAPON11,	ANIM_WEAPON11,	-1,				-1,		-1,	-1},	// JUHOX
	{"toggleview",		"toggle view",		ID_TOGGLEVIEW,	ANIM_IDLE,		-1,				-1,		-1,	-1},	// JUHOX
	{(char*)NULL,		(char*)NULL,		0,				0,				-1,				-1,		-1,	-1},
};

static configcvar_t g_configcvars[] =
{
	{"cl_run",			0,					0},
	{"m_pitch",			0,					0},
	{"cg_autoswitch",	0,					0},
	{"sensitivity",		0,					0},
	{"in_joystick",		0,					0},
	{"joy_threshold",	0,					0},
	{"m_filter",		0,					0},
	{"cl_freelook",		0,					0},
	{"cg_autoswitchAmmoLimit", 0,			0},	// JUHOX
	{"crouchCutsRope",	0,					0},	// JUHOX
	{NULL,				0,					0}
};

#if 1	// JUHOX: since cg_weaponorderX are strings they won't fit in the g_configcvars[] above
static char currentWeaponOrder[NUM_WEAPONORDERS][20];
static char defaultWeaponOrder[NUM_WEAPONORDERS][20];
static char currentWeaponOrderName[NUM_WEAPONORDERS][20];
static char defaultWeaponOrderName[NUM_WEAPONORDERS][20];
#endif

static menucommon_s *g_movement_controls[] =
{
	(menucommon_s *)&s_controls.alwaysrun,
	(menucommon_s *)&s_controls.run,
	(menucommon_s *)&s_controls.walkforward,
	(menucommon_s *)&s_controls.backpedal,
	(menucommon_s *)&s_controls.stepleft,
	(menucommon_s *)&s_controls.stepright,
	(menucommon_s *)&s_controls.moveup,
	(menucommon_s *)&s_controls.movedown,
	(menucommon_s *)&s_controls.turnleft,
	(menucommon_s *)&s_controls.turnright,
	(menucommon_s *)&s_controls.sidestep,
	(menucommon_s *)&s_controls.holdBreath,	// JUHOX
	NULL
};

static menucommon_s *g_weapons_controls[] = {
	(menucommon_s *)&s_controls.attack,
	(menucommon_s *)&s_controls.nextweapon,
	(menucommon_s *)&s_controls.prevweapon,
	(menucommon_s *)&s_controls.autoswitch,
	(menucommon_s *)&s_controls.chainsaw,
	(menucommon_s *)&s_controls.machinegun,
	(menucommon_s *)&s_controls.shotgun,
	(menucommon_s *)&s_controls.grenadelauncher,
	(menucommon_s *)&s_controls.rocketlauncher,
	(menucommon_s *)&s_controls.lightning,
	(menucommon_s *)&s_controls.railgun,
	(menucommon_s *)&s_controls.plasma,
	(menucommon_s *)&s_controls.bfg,
	(menucommon_s *)&s_controls.grapple,	        // JUHOX
	(menucommon_s *)&s_controls.monsterlauncher,	// JUHOX
	(menucommon_s *)&s_controls.toggleHook,	        // JUHOX
	(menucommon_s *)&s_controls.throwHook,	        // JUHOX
	(menucommon_s *)&s_controls.crouchingCutsRope,	// JUHOX
	NULL,
};

static menucommon_s *g_looking_controls[] = {
	(menucommon_s *)&s_controls.sensitivity,
	(menucommon_s *)&s_controls.smoothmouse,
	(menucommon_s *)&s_controls.invertmouse,
	(menucommon_s *)&s_controls.lookup,
	(menucommon_s *)&s_controls.lookdown,
	(menucommon_s *)&s_controls.mouselook,
	(menucommon_s *)&s_controls.freelook,
	(menucommon_s *)&s_controls.centerview,
	(menucommon_s *)&s_controls.zoomview,
	(menucommon_s *)&s_controls.toggleview,	// JUHOX
	(menucommon_s *)&s_controls.joyenable,
	(menucommon_s *)&s_controls.joythreshold,
	NULL,
};

// JUHOX: controls for the prios menu
static menucommon_s* g_prios_controls[] = {
	(menucommon_s*)&s_controls.bestweapon,
	(menucommon_s*)&s_controls.skipweapon,
	(menucommon_s*)&s_controls.autoswitchAmmoLimit,
	(menucommon_s*)&s_controls.nextWeaponOrder,
	(menucommon_s*)&s_controls.prevWeaponOrder,
	(menucommon_s*)&s_controls.weaponOrderSwitch,
	(menucommon_s*)&s_controls.weaponOrderName,
	(menucommon_s*)&s_controls.weaponCategory,
	(menucommon_s*)&s_controls.weaponList[0],
	(menucommon_s*)&s_controls.weaponList[1],
	(menucommon_s*)&s_controls.weaponList[2],
	(menucommon_s*)&s_controls.weaponList[3],
	(menucommon_s*)&s_controls.weaponList[4],
	(menucommon_s*)&s_controls.weaponList[5],
	(menucommon_s*)&s_controls.weaponList[6],
	(menucommon_s*)&s_controls.weaponList[7],
	(menucommon_s*)&s_controls.weaponList[8],
	(menucommon_s*)&s_controls.weaponList[9],
	NULL,
};

// JUHOX: names for the prios menu
static const char* g_prios_names[] = {
	"",					// WP_NONE
	"gauntlet",
	"machinegun",
	"shotgun",
	"grenade launcher",
	"rocket launcher",
	"lightning gun",
	"railgun",
	"plasma gun",
	"BFG",
	"grappling hook",
	"monster launcher",
	"weapon 12",
	"weapon 13",
	"weapon 14",
	"weapon 15"
};

static menucommon_s *g_misc_controls[] = {
	(menucommon_s *)&s_controls.showscores,
	(menucommon_s *)&s_controls.useitem,
	(menucommon_s *)&s_controls.gesture,
	(menucommon_s *)&s_controls.chat,
	(menucommon_s *)&s_controls.chat2,
	(menucommon_s *)&s_controls.chat3,
	(menucommon_s *)&s_controls.chat4,
	(menucommon_s *)&s_controls.givehealth,	    // JUHOX
	(menucommon_s *)&s_controls.givearmor,	    // JUHOX
	(menucommon_s *)&s_controls.tssInterface,	// JUHOX
	(menucommon_s *)&s_controls.navAid,	        // JUHOX
	(menucommon_s *)&s_controls.gfTight,	    // JUHOX
	(menucommon_s *)&s_controls.gfLoose,	    // JUHOX
	(menucommon_s *)&s_controls.gfFree,		    // JUHOX
	NULL,
};

static menucommon_s **g_controls[] = {
	g_movement_controls,
	g_looking_controls,
	g_weapons_controls,
	g_misc_controls,
	g_prios_controls,	// JUHOX
};

/*
=================
Controls_InitCvars
=================
*/
static void Controls_InitCvars( void )
{
	int				i;
	configcvar_t*	cvarptr;

	cvarptr = g_configcvars;
	for (i=0; ;i++,cvarptr++)
	{
		if (!cvarptr->name)
			break;

		// get current value
		cvarptr->value = trap_Cvar_VariableValue( cvarptr->name );

		// get default value
		trap_Cvar_Reset( cvarptr->name );
		cvarptr->defaultvalue = trap_Cvar_VariableValue( cvarptr->name );

		// restore current value
		trap_Cvar_SetValue( cvarptr->name, cvarptr->value );
	}

	// JUHOX: save current and default value of cg_weaponOrder
	for (i = 0; i < NUM_WEAPONORDERS; i++) {
		char* name;

		name = va("cg_weaponOrder%d", i);
		trap_Cvar_VariableStringBuffer(name, currentWeaponOrder[i], sizeof(currentWeaponOrder[i]));
		trap_Cvar_Reset(name);
		trap_Cvar_VariableStringBuffer(name, defaultWeaponOrder[i], sizeof(defaultWeaponOrder[i]));
		trap_Cvar_Set(name, currentWeaponOrder[i]);

		name = va("cg_weaponOrder%dName", i);
		trap_Cvar_VariableStringBuffer(name, currentWeaponOrderName[i], sizeof(currentWeaponOrderName[i]));
		trap_Cvar_Reset(name);
		trap_Cvar_VariableStringBuffer(name, defaultWeaponOrderName[i], sizeof(defaultWeaponOrderName[i]));
		trap_Cvar_Set(name, currentWeaponOrderName[i]);
	}
}

/*
=================
Controls_GetCvarDefault
=================
*/
static float Controls_GetCvarDefault( char* name )
{
	configcvar_t*	cvarptr;
	int				i;

	cvarptr = g_configcvars;
	for (i=0; ;i++,cvarptr++)
	{
		if (!cvarptr->name)
			return (0);

		if (!strcmp(cvarptr->name,name))
			break;
	}

	return (cvarptr->defaultvalue);
}

/*
=================
Controls_GetCvarValue
=================
*/
static float Controls_GetCvarValue( char* name )
{
	configcvar_t*	cvarptr;
	int				i;

	cvarptr = g_configcvars;
	for (i=0; ;i++,cvarptr++)
	{
		if (!cvarptr->name)
			return (0);

		if (!strcmp(cvarptr->name,name))
			break;
	}

	return (cvarptr->value);
}


/*
=================
Controls_UpdateModel
=================
*/
static void Controls_UpdateModel( int anim ) {
	VectorClear( s_controls.playerViewangles );
	VectorClear( s_controls.playerMoveangles );
	s_controls.playerViewangles[YAW] = 180 - 30;
	s_controls.playerMoveangles[YAW] = s_controls.playerViewangles[YAW];
	s_controls.playerLegs		     = LEGS_IDLE;
	s_controls.playerTorso			 = TORSO_STAND;
	s_controls.playerWeapon			 = -1;
	s_controls.playerChat			 = qfalse;

	switch( anim ) {
	case ANIM_RUN:
		s_controls.playerLegs = LEGS_RUN;
		break;

	case ANIM_WALK:
		s_controls.playerLegs = LEGS_WALK;
		break;

	case ANIM_BACK:
		s_controls.playerLegs = LEGS_BACK;
		break;

	case ANIM_JUMP:
		s_controls.playerLegs = LEGS_JUMP;
		break;

	case ANIM_CROUCH:
		s_controls.playerLegs = LEGS_IDLECR;
		break;

	case ANIM_TURNLEFT:
		s_controls.playerViewangles[YAW] += 90;
		break;

	case ANIM_TURNRIGHT:
		s_controls.playerViewangles[YAW] -= 90;
		break;

	case ANIM_STEPLEFT:
		s_controls.playerLegs = LEGS_WALK;
		s_controls.playerMoveangles[YAW] = s_controls.playerViewangles[YAW] + 90;
		break;

	case ANIM_STEPRIGHT:
		s_controls.playerLegs = LEGS_WALK;
		s_controls.playerMoveangles[YAW] = s_controls.playerViewangles[YAW] - 90;
		break;

	case ANIM_LOOKUP:
		s_controls.playerViewangles[PITCH] = -45;
		break;

	case ANIM_LOOKDOWN:
		s_controls.playerViewangles[PITCH] = 45;
		break;

	case ANIM_WEAPON1:
		s_controls.playerWeapon = WP_GAUNTLET;
		break;

	case ANIM_WEAPON2:
		s_controls.playerWeapon = WP_MACHINEGUN;
		break;

	case ANIM_WEAPON3:
		s_controls.playerWeapon = WP_SHOTGUN;
		break;

	case ANIM_WEAPON4:
		s_controls.playerWeapon = WP_GRENADE_LAUNCHER;
		break;

	case ANIM_WEAPON5:
		s_controls.playerWeapon = WP_ROCKET_LAUNCHER;
		break;

	case ANIM_WEAPON6:
		s_controls.playerWeapon = WP_LIGHTNING;
		break;

	case ANIM_WEAPON7:
		s_controls.playerWeapon = WP_RAILGUN;
		break;

	case ANIM_WEAPON8:
		s_controls.playerWeapon = WP_PLASMAGUN;
		break;

	case ANIM_WEAPON9:
		s_controls.playerWeapon = WP_BFG;
		break;

	case ANIM_WEAPON10:
		s_controls.playerWeapon = WP_GRAPPLING_HOOK;
		break;

	case ANIM_ATTACK:
		s_controls.playerTorso = TORSO_ATTACK;
		break;

	case ANIM_GESTURE:
		s_controls.playerTorso = TORSO_GESTURE;
		break;

	case ANIM_DIE:
		s_controls.playerLegs = BOTH_DEATH1;
		s_controls.playerTorso = BOTH_DEATH1;
		s_controls.playerWeapon = WP_NONE;
		break;

	case ANIM_CHAT:
		s_controls.playerChat = qtrue;
		break;

	// JUHOX: anim for weapon 11 (monster launcher)
	case ANIM_WEAPON11:
		s_controls.playerWeapon = WP_MONSTER_LAUNCHER;
		break;

	default:
		break;
	}

	UI_PlayerInfo_SetInfo( &s_controls.playerinfo, s_controls.playerLegs, s_controls.playerTorso, s_controls.playerViewangles, s_controls.playerMoveangles, s_controls.playerWeapon, s_controls.playerChat );
}


/*
=================
Controls_Update
=================
*/
static void Controls_Update( void ) {
	int		i;
	int		j;
	int		y;
	menucommon_s	**controls;
	menucommon_s	*control;

	// disable all controls in all groups
	for( i = 0; i < C_MAX; i++ ) {
		controls = g_controls[i];
		// bk001204 - parentheses
		for( j = 0;  (control = controls[j]) ; j++ ) {
			control->flags |= (QMF_HIDDEN|QMF_INACTIVE);
		}
	}

	controls = g_controls[s_controls.section];

	// enable controls in active group (and count number of items for vertical centering)
	// bk001204 - parentheses
	for( j = 0;  (control = controls[j]) ; j++ ) {
		control->flags &= ~(QMF_GRAYED|QMF_HIDDEN|QMF_INACTIVE);
	}

	// position controls
	y = ( SCREEN_HEIGHT - j * SMALLCHAR_HEIGHT ) / 2;
	// bk001204 - parentheses
	for( j = 0;	(control = controls[j]) ; j++, y += SMALLCHAR_HEIGHT ) {
		control->x      = 320;
		control->y      = y;
		control->left   = 320 - 19*SMALLCHAR_WIDTH;
		control->right  = 320 + 21*SMALLCHAR_WIDTH;
		control->top    = y;
		control->bottom = y + SMALLCHAR_HEIGHT;
	}

	if( s_controls.waitingforkey ) {
		// disable everybody
		for( i = 0; i < s_controls.menu.nitems; i++ ) {
			((menucommon_s*)(s_controls.menu.items[i]))->flags |= QMF_GRAYED;
		}

		// enable action item
		((menucommon_s*)(s_controls.menu.items[s_controls.menu.cursor]))->flags &= ~QMF_GRAYED;

		// don't gray out player's name
		s_controls.name.generic.flags &= ~QMF_GRAYED;

		return;
	}

	// enable everybody
	for( i = 0; i < s_controls.menu.nitems; i++ ) {
		((menucommon_s*)(s_controls.menu.items[i]))->flags &= ~QMF_GRAYED;
	}

	// makes sure flags are right on the group selection controls
	s_controls.looking.generic.flags  &= ~(QMF_GRAYED|QMF_HIGHLIGHT|QMF_HIGHLIGHT_IF_FOCUS);
	s_controls.movement.generic.flags &= ~(QMF_GRAYED|QMF_HIGHLIGHT|QMF_HIGHLIGHT_IF_FOCUS);
	s_controls.weapons.generic.flags  &= ~(QMF_GRAYED|QMF_HIGHLIGHT|QMF_HIGHLIGHT_IF_FOCUS);
	s_controls.misc.generic.flags     &= ~(QMF_GRAYED|QMF_HIGHLIGHT|QMF_HIGHLIGHT_IF_FOCUS);
	s_controls.prios.generic.flags    &= ~(QMF_GRAYED|QMF_HIGHLIGHT|QMF_HIGHLIGHT_IF_FOCUS);	// JUHOX

	s_controls.looking.generic.flags  |= QMF_PULSEIFFOCUS;
	s_controls.movement.generic.flags |= QMF_PULSEIFFOCUS;
	s_controls.weapons.generic.flags  |= QMF_PULSEIFFOCUS;
	s_controls.misc.generic.flags     |= QMF_PULSEIFFOCUS;
	s_controls.prios.generic.flags    |= QMF_PULSEIFFOCUS;	// JUHOX

	// set buttons
	switch( s_controls.section ) {
	case C_MOVEMENT:
		s_controls.movement.generic.flags &= ~QMF_PULSEIFFOCUS;
		s_controls.movement.generic.flags |= (QMF_HIGHLIGHT|QMF_HIGHLIGHT_IF_FOCUS);
		break;

	case C_LOOKING:
		s_controls.looking.generic.flags &= ~QMF_PULSEIFFOCUS;
		s_controls.looking.generic.flags |= (QMF_HIGHLIGHT|QMF_HIGHLIGHT_IF_FOCUS);
		break;

	case C_WEAPONS:
		s_controls.weapons.generic.flags &= ~QMF_PULSEIFFOCUS;
		s_controls.weapons.generic.flags |= (QMF_HIGHLIGHT|QMF_HIGHLIGHT_IF_FOCUS);
		break;

	case C_MISC:
		s_controls.misc.generic.flags &= ~QMF_PULSEIFFOCUS;
		s_controls.misc.generic.flags |= (QMF_HIGHLIGHT|QMF_HIGHLIGHT_IF_FOCUS);
		break;

	// JUHOX: set C_PRIOS buttons
	case C_PRIOS:
		s_controls.prios.generic.flags &= ~QMF_PULSEIFFOCUS;
		s_controls.prios.generic.flags |= (QMF_HIGHLIGHT|QMF_HIGHLIGHT_IF_FOCUS);
		break;
	}
}


/*
=================
Controls_DrawKeyBinding
=================
*/
static void Controls_DrawKeyBinding( void *self )
{
	menuaction_s*	a;
	int				x;
	int				y;
	int				b1;
	int				b2;
	qboolean		c;
	char			name[32];
	char			name2[32];

	a = (menuaction_s*) self;

	x =	a->generic.x;
	y = a->generic.y;

	c = (Menu_ItemAtCursor( a->generic.parent ) == a);

	b1 = g_bindings[a->generic.id].bind1;
	if (b1 == -1)
		strcpy(name,"???");
	else
	{
		trap_Key_KeynumToStringBuf( b1, name, 32 );
		Q_strupr(name);

		b2 = g_bindings[a->generic.id].bind2;
		if (b2 != -1)
		{
			trap_Key_KeynumToStringBuf( b2, name2, 32 );
			Q_strupr(name2);

			strcat( name, " or " );
			strcat( name, name2 );
		}
	}

	if (c)
	{
		UI_FillRect( a->generic.left, a->generic.top, a->generic.right-a->generic.left+1, a->generic.bottom-a->generic.top+1, listbar_color );

		UI_DrawString( x - SMALLCHAR_WIDTH, y, g_bindings[a->generic.id].label, UI_RIGHT|UI_SMALLFONT, text_color_highlight );
		UI_DrawString( x + SMALLCHAR_WIDTH, y, name, UI_LEFT|UI_SMALLFONT|UI_PULSE, text_color_highlight );

		if (s_controls.waitingforkey)
		{
			UI_DrawChar( x, y, '=', UI_CENTER|UI_BLINK|UI_SMALLFONT, text_color_highlight);
			UI_DrawString(SCREEN_WIDTH * 0.50, SCREEN_HEIGHT * /*0.80*/0.86, "Waiting for new key ... ESCAPE to cancel", UI_SMALLFONT|UI_CENTER|UI_PULSE, colorWhite );	// JUHOX
		}
		else
		{
			UI_DrawChar( x, y, 13, UI_CENTER|UI_BLINK|UI_SMALLFONT, text_color_highlight);
			UI_DrawString(SCREEN_WIDTH * 0.50, SCREEN_HEIGHT * /*0.78*/0.84, "Press ENTER or CLICK to change", UI_SMALLFONT|UI_CENTER, colorWhite );	// JUHOX
			UI_DrawString(SCREEN_WIDTH * 0.50, SCREEN_HEIGHT * /*0.82*/0.88, "Press BACKSPACE to clear", UI_SMALLFONT|UI_CENTER, colorWhite );	// JUHOX
			// JUHOX: draw an explanation for some items
			switch (a->generic.id) {
			case ID_WEAPBEST:
				UI_DrawString(
					SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.92,
					"(chooses best weapon of current category, considering ammo)",
					UI_SMALLFONT|UI_CENTER, colorWhite
				);
				break;
			case ID_WEAPSKIP:
				UI_DrawString(
					SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.92,
					"(temporarily skips to a lesser weapon of current category)",
					UI_SMALLFONT|UI_CENTER, colorWhite
				);
				break;
			}
		}
	}
	else
	{
		if (a->generic.flags & QMF_GRAYED)
		{
			UI_DrawString( x - SMALLCHAR_WIDTH, y, g_bindings[a->generic.id].label, UI_RIGHT|UI_SMALLFONT, text_color_disabled );
			UI_DrawString( x + SMALLCHAR_WIDTH, y, name, UI_LEFT|UI_SMALLFONT, text_color_disabled );
		}
		else
		{
			UI_DrawString( x - SMALLCHAR_WIDTH, y, g_bindings[a->generic.id].label, UI_RIGHT|UI_SMALLFONT, controls_binding_color );
			UI_DrawString( x + SMALLCHAR_WIDTH, y, name, UI_LEFT|UI_SMALLFONT, controls_binding_color );
		}
	}
}

/*
=================
JUHOX: Controls_WeaponListStatusbar
=================
*/
static void Controls_WeaponListStatusbar(void* self)
{
	if (s_controls.weaponListSelection < 0) {
		UI_DrawString(SCREEN_WIDTH * 0.50, SCREEN_HEIGHT * /*0.80*/0.86, "Press ENTER or CLICK to select", UI_SMALLFONT|UI_CENTER, colorWhite );	// JUHOX
	}
	else {
		UI_DrawString(SCREEN_WIDTH * 0.50, SCREEN_HEIGHT * /*0.80*/0.86, "Press ENTER or CLICK to move selected weapon", UI_SMALLFONT|UI_CENTER, colorWhite );	// JUHOX
	}
}


/*
=================
JUHOX: Controls_DrawWeaponListItem
=================
*/
static void Controls_DrawWeaponListItem(void* self)
{
	int x, y;
	menuaction_s* item;
	int weapon;
	qboolean hasFocus;
	vec4_t color;
	const char* label;

	item = (menuaction_s*) self;
	x = item->generic.x;
	y = item->generic.y;
	hasFocus = item->generic.parent->cursor == item->generic.menuPosition;
	weapon = currentWeaponOrder[s_controls.currentWeaponOrder][item->generic.id] - 'A';
	if (weapon < 0 || weapon > 15) weapon = 1;

	if (hasFocus) {
		UI_FillRect(item->generic.left, item->generic.top, item->generic.right-item->generic.left+1, item->generic.bottom-item->generic.top+1, listbar_color);
		Vector4Copy(text_color_highlight, color);
	}
	else {
		Vector4Copy(text_color_normal, color);
	}
	if (item->generic.id == s_controls.weaponListSelection) {
		Vector4Copy(colorWhite, color);
	}
	UI_DrawString(x + SMALLCHAR_WIDTH, y, g_prios_names[weapon], UI_SMALLFONT, color);
	switch (item->generic.id) {
	case 0:
		label = "(best weapon) ";
		break;
	case WEAPONLIST_SIZE-1:
		label = "(worst weapon) ";
		break;
	default:
		return;
	}
	UI_DrawString(x - SMALLCHAR_WIDTH*strlen(label), y, label, UI_SMALLFONT, text_color_normal);
}

/*
=================
JUHOX: Controls_DrawWeaponOrderSwitch
=================
*/
static void Controls_DrawWeaponOrderSwitch(void* self)
{
	menuaction_s* item;
	int x, y;
	qboolean hasFocus;
	vec4_t color;
	char name[128];

	// save or update the menu field
	if (s_controls.currentlyDrawnWeaponOrderName > -2) {
		if (s_controls.currentlyDrawnWeaponOrderName == s_controls.currentWeaponOrder) {
			memcpy(currentWeaponOrderName[s_controls.currentWeaponOrder], s_controls.weaponOrderName.field.buffer, 20);
		}
		else {
			memcpy(s_controls.weaponOrderName.field.buffer, currentWeaponOrderName[s_controls.currentWeaponOrder], 20);
			s_controls.currentlyDrawnWeaponOrderName = s_controls.currentWeaponOrder;
		}
	}

	item = (menuaction_s*) self;
	x = item->generic.x;
	y = item->generic.y;
	hasFocus = item->generic.parent->cursor == item->generic.menuPosition;

	if (hasFocus) {
		UI_FillRect(item->generic.left, item->generic.top, item->generic.right-item->generic.left+1, item->generic.bottom-item->generic.top+1, listbar_color);
		Vector4Copy(text_color_highlight, color);

		UI_DrawString(
			SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.86,
			"Press ENTER or CLICK to switch weapon category",
			UI_SMALLFONT|UI_CENTER, colorWhite
		);
	}
	else {
		Vector4Copy(text_color_normal, color);
	}
	Com_sprintf(name, sizeof(name), "category %d/%d", s_controls.currentWeaponOrder+1, NUM_WEAPONORDERS);
	UI_DrawString(x - strlen(name) * SMALLCHAR_WIDTH*0.5, y, name, UI_SMALLFONT, color);
}

/*
=================
Controls_StatusBar
=================
*/
static void Controls_StatusBar( void *self )
{
	UI_DrawString(SCREEN_WIDTH * 0.50, SCREEN_HEIGHT * /*0.80*/0.86, "Use Arrow Keys or CLICK to change", UI_SMALLFONT|UI_CENTER, colorWhite );	// JUHOX
}


/*
=================
JUHOX: Controls_AutoswitchAmmoLimitStatusbar
=================
*/
static void Controls_AutoswitchAmmoLimitStatusbar(void* self)
{
	UI_DrawString(SCREEN_WIDTH * 0.50, SCREEN_HEIGHT * 0.86, "weapons with less ammo are not auto-switched to", UI_SMALLFONT|UI_CENTER, colorWhite );
}


/*
=================
JUHOX: Controls_CategoryNameStatusbar
=================
*/
static void Controls_CategoryNameStatusbar(void* self)
{
	UI_DrawString(
		SCREEN_WIDTH * 0.50, SCREEN_HEIGHT * 0.86,
		va("Enter a name for weapon category #%d", s_controls.currentWeaponOrder + 1),
		UI_SMALLFONT|UI_CENTER, colorWhite
	);
}


/*
=================
Controls_DrawPlayer
=================
*/
static void Controls_DrawPlayer( void *self ) {
	menubitmap_s	*b;
	char			buf[MAX_QPATH];

	trap_Cvar_VariableStringBuffer( "model", buf, sizeof( buf ) );
	if ( strcmp( buf, s_controls.playerModel ) != 0 ) {
		UI_PlayerInfo_SetModel( &s_controls.playerinfo, buf );
		strcpy( s_controls.playerModel, buf );
		Controls_UpdateModel( ANIM_IDLE );
	}

	b = (menubitmap_s*) self;
	UI_DrawPlayer( b->generic.x, b->generic.y, b->width, b->height, &s_controls.playerinfo, uis.realtime/2 );
}


/*
=================
Controls_GetKeyAssignment
=================
*/
static void Controls_GetKeyAssignment (char *command, int *twokeys)
{
	int		count;
	int		j;
	char	b[256];

	twokeys[0] = twokeys[1] = -1;
	count = 0;

	for ( j = 0; j < 256; j++ )
	{
		trap_Key_GetBindingBuf( j, b, 256 );
		if ( *b == 0 ) {
			continue;
		}
		if ( !Q_stricmp( b, command ) ) {
			twokeys[count] = j;
			count++;
			if (count == 2)
				break;
		}
	}
}

/*
=================
Controls_GetConfig
=================
*/
static void Controls_GetConfig( void )
{
	int		i;
	int		twokeys[2];
	bind_t*	bindptr;

	// put the bindings into a local store
	bindptr = g_bindings;

	// iterate each command, get its numeric binding
	for (i=0; ;i++,bindptr++)
	{
		if (!bindptr->label)
			break;

		Controls_GetKeyAssignment(bindptr->command, twokeys);

		bindptr->bind1 = twokeys[0];
		bindptr->bind2 = twokeys[1];
	}

	s_controls.invertmouse.curvalue  = Controls_GetCvarValue( "m_pitch" ) < 0;
	s_controls.smoothmouse.curvalue  = UI_ClampCvar( 0, 1, Controls_GetCvarValue( "m_filter" ) );
	s_controls.alwaysrun.curvalue    = UI_ClampCvar( 0, 1, Controls_GetCvarValue( "cl_run" ) );
	s_controls.autoswitch.curvalue   = UI_ClampCvar( 0, 1, Controls_GetCvarValue( "cg_autoswitch" ) );
	s_controls.sensitivity.curvalue  = UI_ClampCvar( 2, 30, Controls_GetCvarValue( "sensitivity" ) );
	s_controls.joyenable.curvalue    = UI_ClampCvar( 0, 1, Controls_GetCvarValue( "in_joystick" ) );
	s_controls.joythreshold.curvalue = UI_ClampCvar( 0.05f, 0.75f, Controls_GetCvarValue( "joy_threshold" ) );
	s_controls.freelook.curvalue     = UI_ClampCvar( 0, 1, Controls_GetCvarValue( "cl_freelook" ) );
	Com_sprintf(s_controls.autoswitchAmmoLimit.field.buffer, 4, "%d", (int) Controls_GetCvarValue("cg_autoswitchAmmoLimit"));	// JUHOX
	s_controls.crouchingCutsRope.curvalue = UI_ClampCvar(0, 1, Controls_GetCvarValue("crouchCutsRope"));	// JUHOX
	// JUHOX: weapon order name menu field is automatically updated by Controls_DrawWeaponOrderSwitch()
}

/*
=================
Controls_SetConfig
=================
*/
static void Controls_SetConfig( void )
{
	int		i;
	bind_t*	bindptr;

	// set the bindings from the local store
	bindptr = g_bindings;

	// iterate each command, get its numeric binding
	for (i=0; ;i++,bindptr++)
	{
		if (!bindptr->label)
			break;

		if (bindptr->bind1 != -1)
		{
			trap_Key_SetBinding( bindptr->bind1, bindptr->command );

			if (bindptr->bind2 != -1)
				trap_Key_SetBinding( bindptr->bind2, bindptr->command );
		}
	}

	if ( s_controls.invertmouse.curvalue )
		trap_Cvar_SetValue( "m_pitch", -fabs( trap_Cvar_VariableValue( "m_pitch" ) ) );
	else
		trap_Cvar_SetValue( "m_pitch", fabs( trap_Cvar_VariableValue( "m_pitch" ) ) );

	trap_Cvar_SetValue( "m_filter", s_controls.smoothmouse.curvalue );
	trap_Cvar_SetValue( "cl_run", s_controls.alwaysrun.curvalue );
	trap_Cvar_SetValue( "cg_autoswitch", s_controls.autoswitch.curvalue );
	trap_Cvar_SetValue( "sensitivity", s_controls.sensitivity.curvalue );
	trap_Cvar_SetValue( "in_joystick", s_controls.joyenable.curvalue );
	trap_Cvar_SetValue( "joy_threshold", s_controls.joythreshold.curvalue );
	trap_Cvar_SetValue( "cl_freelook", s_controls.freelook.curvalue );
	trap_Cmd_ExecuteText( EXEC_APPEND, "in_restart\n" );
}

/*
=================
JUHOX: Controls_SetSimpleConfig

simple cvar updates that don't require an 'in_restart'
=================
*/
static void Controls_SetSimpleConfig(void) {
	int i;

	trap_Cvar_Set("cg_autoswitchAmmoLimit", s_controls.autoswitchAmmoLimit.field.buffer);
	trap_Cvar_SetValue("crouchCutsRope", s_controls.crouchingCutsRope.curvalue);
	for (i = 0; i < NUM_WEAPONORDERS; i++) {
		trap_Cvar_Set(va("cg_weaponOrder%d", i), currentWeaponOrder[i]);
		trap_Cvar_Set(va("cg_weaponOrder%dName", i), currentWeaponOrderName[i]);
	}
}

/*
=================
Controls_SetDefaults
=================
*/
static void Controls_SetDefaults( void )
{
	int	i;
	bind_t*	bindptr;

	// set the bindings from the local store
	bindptr = g_bindings;

	// iterate each command, set its default binding
	for (i=0; ;i++,bindptr++)
	{
		if (!bindptr->label)
			break;

		bindptr->bind1 = bindptr->defaultbind1;
		bindptr->bind2 = bindptr->defaultbind2;
	}

	s_controls.invertmouse.curvalue  = Controls_GetCvarDefault( "m_pitch" ) < 0;
	s_controls.smoothmouse.curvalue  = Controls_GetCvarDefault( "m_filter" );
	s_controls.alwaysrun.curvalue    = Controls_GetCvarDefault( "cl_run" );
	s_controls.autoswitch.curvalue   = Controls_GetCvarDefault( "cg_autoswitch" );
	s_controls.sensitivity.curvalue  = Controls_GetCvarDefault( "sensitivity" );
	s_controls.joyenable.curvalue    = Controls_GetCvarDefault( "in_joystick" );
	s_controls.joythreshold.curvalue = Controls_GetCvarDefault( "joy_threshold" );
	s_controls.freelook.curvalue     = Controls_GetCvarDefault( "cl_freelook" );
	Com_sprintf(s_controls.autoswitchAmmoLimit.field.buffer, 4, "%d", (int) Controls_GetCvarDefault("cg_autoswitchAmmoLimit"));	// JUHOX
	s_controls.crouchingCutsRope.curvalue = Controls_GetCvarDefault("crouchCutsRope");	// JUHOX
	// JUHOX: set weapon order defaults
	memcpy(currentWeaponOrder, defaultWeaponOrder, sizeof(currentWeaponOrder));
	s_controls.currentlyDrawnWeaponOrderName = -2;
	memcpy(currentWeaponOrderName, defaultWeaponOrderName, sizeof(currentWeaponOrderName));
	s_controls.currentlyDrawnWeaponOrderName = -1;
}

/*
=================
Controls_MenuKey
=================
*/
static sfxHandle_t Controls_MenuKey( int key )
{
	int			id;
	int			i;
	qboolean	found;
	bind_t*		bindptr;
	found = qfalse;

	if (!s_controls.waitingforkey)
	{
		switch (key)
		{
			case K_BACKSPACE:
			case K_DEL:
			case K_KP_DEL:
				key = -1;
				break;

			case K_MOUSE2:
			case K_ESCAPE:
				if (s_controls.changesmade)
					Controls_SetConfig();
				Controls_SetSimpleConfig();	// JUHOX
				goto ignorekey;

			default:
				goto ignorekey;
		}
	}
	else
	{
		if (key & K_CHAR_FLAG)
			goto ignorekey;

		switch (key)
		{
			case K_ESCAPE:
				s_controls.waitingforkey = qfalse;
				Controls_Update();
				return (menu_out_sound);

			case '`':
				goto ignorekey;
		}
	}

	s_controls.changesmade = qtrue;

	if (key != -1)
	{
		// remove from any other bind
		bindptr = g_bindings;
		for (i=0; ;i++,bindptr++)
		{
			if (!bindptr->label)
				break;

			if (bindptr->bind2 == key)
				bindptr->bind2 = -1;

			if (bindptr->bind1 == key)
			{
				bindptr->bind1 = bindptr->bind2;
				bindptr->bind2 = -1;
			}
		}
	}

	// assign key to local store
	id      = ((menucommon_s*)(s_controls.menu.items[s_controls.menu.cursor]))->id;
	bindptr = g_bindings;
	for (i=0; ;i++,bindptr++)
	{
		if (!bindptr->label)
			break;

		if (bindptr->id == id)
		{
			found = qtrue;
			if (key == -1)
			{
				if( bindptr->bind1 != -1 ) {
					trap_Key_SetBinding( bindptr->bind1, "" );
					bindptr->bind1 = -1;
				}
				if( bindptr->bind2 != -1 ) {
					trap_Key_SetBinding( bindptr->bind2, "" );
					bindptr->bind2 = -1;
				}
			}
			else if (bindptr->bind1 == -1) {
				bindptr->bind1 = key;
			}
			else if (bindptr->bind1 != key && bindptr->bind2 == -1) {
				bindptr->bind2 = key;
			}
			else
			{
				trap_Key_SetBinding( bindptr->bind1, "" );
				trap_Key_SetBinding( bindptr->bind2, "" );
				bindptr->bind1 = key;
				bindptr->bind2 = -1;
			}
			break;
		}
	}

	s_controls.waitingforkey = qfalse;

	if (found)
	{
		Controls_Update();
		return (menu_out_sound);
	}

ignorekey:
	return Menu_DefaultKey( &s_controls.menu, key );
}

/*
=================
Controls_ResetDefaults_Action
=================
*/
static void Controls_ResetDefaults_Action( qboolean result ) {
	if( !result ) {
		return;
	}

	s_controls.changesmade = qtrue;
	Controls_SetDefaults();
	Controls_Update();
}

/*
=================
Controls_ResetDefaults_Draw
=================
*/
static void Controls_ResetDefaults_Draw( void ) {
	UI_DrawProportionalString( SCREEN_WIDTH/2, 356 + PROP_HEIGHT * 0, "WARNING: This will reset all", UI_CENTER|UI_SMALLFONT, color_yellow );
	UI_DrawProportionalString( SCREEN_WIDTH/2, 356 + PROP_HEIGHT * 1, "controls to their default values.", UI_CENTER|UI_SMALLFONT, color_yellow );
}

/*
=================
Controls_MenuEvent
=================
*/
static void Controls_MenuEvent( void* ptr, int event )
{
	switch (((menucommon_s*)ptr)->id)
	{
		case ID_MOVEMENT:
			if (event == QM_ACTIVATED)
			{
				s_controls.section = C_MOVEMENT;
				Controls_Update();
			}
			break;

		case ID_LOOKING:
			if (event == QM_ACTIVATED)
			{
				s_controls.section = C_LOOKING;
				Controls_Update();
			}
			break;

		case ID_WEAPONS:
			if (event == QM_ACTIVATED)
			{
				s_controls.section = C_WEAPONS;
				Controls_Update();
			}
			break;

		case ID_MISC:
			if (event == QM_ACTIVATED)
			{
				s_controls.section = C_MISC;
				Controls_Update();
			}
			break;

		// JUHOX: switch to weapon order menu
		case ID_PRIOS:
			if (event == QM_ACTIVATED)
			{
				s_controls.section = C_PRIOS;
				Controls_Update();
			}
			break;

		case ID_DEFAULTS:
			if (event == QM_ACTIVATED)
			{
				UI_ConfirmMenu( "SET TO DEFAULTS?", Controls_ResetDefaults_Draw, Controls_ResetDefaults_Action );
			}
			break;

		case ID_BACK:
			if (event == QM_ACTIVATED)
			{
				if (s_controls.changesmade)
					Controls_SetConfig();
				Controls_SetSimpleConfig();	// JUHOX
				UI_PopMenu();
			}
			break;

		case ID_SAVEANDEXIT:
			if (event == QM_ACTIVATED)
			{
				Controls_SetConfig();
				Controls_SetSimpleConfig();	// JUHOX
				UI_PopMenu();
			}
			break;

		case ID_EXIT:
			if (event == QM_ACTIVATED)
			{
				UI_PopMenu();
			}
			break;

		case ID_FREELOOK:
		case ID_MOUSESPEED:
		case ID_INVERTMOUSE:
		case ID_SMOOTHMOUSE:
		case ID_ALWAYSRUN:
		case ID_AUTOSWITCH:
		case ID_JOYENABLE:
		case ID_JOYTHRESHOLD:
			if (event == QM_ACTIVATED)
			{
				s_controls.changesmade = qtrue;
			}
			break;
		// JUHOX: handle weapon order switch
		case ID_WEAPONORDERSWITCH:
			if (event == QM_ACTIVATED)
			{
				s_controls.currentWeaponOrder++;
				if (s_controls.currentWeaponOrder >= NUM_WEAPONORDERS) {
					s_controls.currentWeaponOrder = 0;
				}
				s_controls.weaponCategory.generic.id = ID_WEAPCAT0 + s_controls.currentWeaponOrder;
				s_controls.weaponListSelection = -1;

				s_controls.weaponOrderName.field.cursor = 0;
				s_controls.weaponOrderName.field.scroll = 0;
			}
			break;
	}
}

/*
=================
Controls_ActionEvent
=================
*/
static void Controls_ActionEvent( void* ptr, int event )
{
	if (event == QM_LOSTFOCUS)
	{
		Controls_UpdateModel( ANIM_IDLE );
	}
	else if (event == QM_GOTFOCUS)
	{
		Controls_UpdateModel( g_bindings[((menucommon_s*)ptr)->id].anim );
	}
	else if ((event == QM_ACTIVATED) && !s_controls.waitingforkey)
	{
		s_controls.waitingforkey = 1;
		Controls_Update();
	}
}

/*
=================
JUHOX: Controls_WeaponListEvent
=================
*/
static void Controls_WeaponListEvent( void* ptr, int event )
{
	if (event == QM_LOSTFOCUS)
	{
		Controls_UpdateModel(ANIM_IDLE);
	}
	else if (event == QM_GOTFOCUS)
	{
		Controls_UpdateModel(ANIM_IDLE);
	}
	else if ((event == QM_ACTIVATED))
	{
		int item;

		item = ((menucommon_s*)ptr)->id;
		if (s_controls.weaponListSelection >= 0) {
			int i;
			int source, weapon;
			char* weaponOrder;

			source = s_controls.weaponListSelection;
			weaponOrder = &currentWeaponOrder[s_controls.currentWeaponOrder][0];
			weapon = weaponOrder[source];
			if (item < source) {
				for (i = source-1; i >= item; i--) {
					weaponOrder[i+1] = weaponOrder[i];
				}
			}
			else if (item > source) {
				for (i = source+1; i <= item; i++) {
					weaponOrder[i-1] = weaponOrder[i];
				}
			}
			weaponOrder[item] = weapon;
			s_controls.weaponListSelection = -1;
		}
		else {
			s_controls.weaponListSelection = item;
		}
		Controls_Update();
	}
}

/*
=================
Controls_InitModel
=================
*/
static void Controls_InitModel( void )
{
	memset( &s_controls.playerinfo, 0, sizeof(playerInfo_t) );

	UI_PlayerInfo_SetModel( &s_controls.playerinfo, UI_Cvar_VariableString( "model" ) );

	Controls_UpdateModel( ANIM_IDLE );
}

/*
=================
Controls_InitWeapons
=================
*/
static void Controls_InitWeapons( void ) {
	gitem_t *	item;

	for ( item = bg_itemlist + 1 ; item->classname ; item++ ) {
		if ( item->giType != IT_WEAPON ) {
			continue;
		}
		trap_R_RegisterModel( item->world_model[0] );
	}
}

/*
=================
Controls_MenuInit
=================
*/
static void Controls_MenuInit( void )
{
	static char playername[32];

	// zero set all our globals
	memset( &s_controls, 0 ,sizeof(controls_t) );

	Controls_Cache();

	s_controls.menu.key        = Controls_MenuKey;
	s_controls.menu.wrapAround = qtrue;
	s_controls.menu.fullscreen = qtrue;

	s_controls.banner.generic.type	= MTYPE_BTEXT;
	s_controls.banner.generic.flags	= QMF_CENTER_JUSTIFY;
	s_controls.banner.generic.x		= 320;
	s_controls.banner.generic.y		= 16;
	s_controls.banner.string		= "CONTROLS";
	s_controls.banner.color			= color_white;
	s_controls.banner.style			= UI_CENTER;

	s_controls.framel.generic.type  = MTYPE_BITMAP;
	s_controls.framel.generic.name  = ART_FRAMEL;
	s_controls.framel.generic.flags = QMF_LEFT_JUSTIFY|QMF_INACTIVE;
	s_controls.framel.generic.x     = 0;
	s_controls.framel.generic.y     = 78;
	s_controls.framel.width  	    = 256;
	s_controls.framel.height  	    = 329;

	s_controls.framer.generic.type  = MTYPE_BITMAP;
	s_controls.framer.generic.name  = ART_FRAMER;
	s_controls.framer.generic.flags = QMF_LEFT_JUSTIFY|QMF_INACTIVE;
	s_controls.framer.generic.x     = 376;
	s_controls.framer.generic.y     = 76;
	s_controls.framer.width  	    = 256;
	s_controls.framer.height  	    = 334;

	s_controls.looking.generic.type     = MTYPE_PTEXT;
	s_controls.looking.generic.flags    = QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
	s_controls.looking.generic.id	    = ID_LOOKING;
	s_controls.looking.generic.callback	= Controls_MenuEvent;
	s_controls.looking.generic.x	    = 152;
	s_controls.looking.generic.y	    = 240 - 2 * PROP_HEIGHT;
	s_controls.looking.string			= "LOOK";
	s_controls.looking.style			= UI_RIGHT;
	s_controls.looking.color			= color_red;

	s_controls.movement.generic.type     = MTYPE_PTEXT;
	s_controls.movement.generic.flags    = QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
	s_controls.movement.generic.id	     = ID_MOVEMENT;
	s_controls.movement.generic.callback = Controls_MenuEvent;
	s_controls.movement.generic.x	     = 152;
	s_controls.movement.generic.y	     = 240 - PROP_HEIGHT;
	s_controls.movement.string			= "MOVE";
	s_controls.movement.style			= UI_RIGHT;
	s_controls.movement.color			= color_red;

	s_controls.weapons.generic.type	    = MTYPE_PTEXT;
	s_controls.weapons.generic.flags    = QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
	s_controls.weapons.generic.id	    = ID_WEAPONS;
	s_controls.weapons.generic.callback	= Controls_MenuEvent;
	s_controls.weapons.generic.x	    = 152;
	s_controls.weapons.generic.y	    = 240;
	s_controls.weapons.string			= "SHOOT";
	s_controls.weapons.style			= UI_RIGHT;
	s_controls.weapons.color			= color_red;

	// JUHOX: init weapon order menu title
	s_controls.prios.generic.type		= MTYPE_PTEXT;
	s_controls.prios.generic.flags		= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
	s_controls.prios.generic.id			= ID_PRIOS;
	s_controls.prios.generic.callback	= Controls_MenuEvent;
	s_controls.prios.generic.x			= 152;
	s_controls.prios.generic.y			= 240 + PROP_HEIGHT;
	s_controls.prios.string				= "SWITCH";
	s_controls.prios.style				= UI_RIGHT;
	s_controls.prios.color				= color_red;

	s_controls.misc.generic.type	 = MTYPE_PTEXT;
	s_controls.misc.generic.flags    = QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
	s_controls.misc.generic.id	     = ID_MISC;
	s_controls.misc.generic.callback = Controls_MenuEvent;
	s_controls.misc.generic.x		 = 152;
	// JUHOX: move the misc menu title down
	s_controls.misc.generic.y		 = 240 + 2 * PROP_HEIGHT;
	s_controls.misc.string			= "MISC";
	s_controls.misc.style			= UI_RIGHT;
	s_controls.misc.color			= color_red;

	s_controls.back.generic.type	 = MTYPE_BITMAP;
	s_controls.back.generic.name     = ART_BACK0;
	s_controls.back.generic.flags    = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
	s_controls.back.generic.x		 = 0;
	s_controls.back.generic.y		 = 480-64;
	s_controls.back.generic.id	     = ID_BACK;
	s_controls.back.generic.callback = Controls_MenuEvent;
	s_controls.back.width  		     = 128;
	s_controls.back.height  		 = 64;
	s_controls.back.focuspic         = ART_BACK1;

	s_controls.player.generic.type      = MTYPE_BITMAP;
	s_controls.player.generic.flags     = QMF_INACTIVE;
	s_controls.player.generic.ownerdraw = Controls_DrawPlayer;
	s_controls.player.generic.x	        = 400;
	s_controls.player.generic.y	        = -40;
	s_controls.player.width	            = 32*10;
	s_controls.player.height            = 56*10;

	s_controls.walkforward.generic.type	     = MTYPE_ACTION;
	s_controls.walkforward.generic.flags     = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.walkforward.generic.callback  = Controls_ActionEvent;
	s_controls.walkforward.generic.ownerdraw = Controls_DrawKeyBinding;
	s_controls.walkforward.generic.id 	     = ID_FORWARD;

	s_controls.backpedal.generic.type	   = MTYPE_ACTION;
	s_controls.backpedal.generic.flags     = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.backpedal.generic.callback  = Controls_ActionEvent;
	s_controls.backpedal.generic.ownerdraw = Controls_DrawKeyBinding;
	s_controls.backpedal.generic.id 	   = ID_BACKPEDAL;

	s_controls.stepleft.generic.type	  = MTYPE_ACTION;
	s_controls.stepleft.generic.flags     = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.stepleft.generic.callback  = Controls_ActionEvent;
	s_controls.stepleft.generic.ownerdraw = Controls_DrawKeyBinding;
	s_controls.stepleft.generic.id 		  = ID_MOVELEFT;

	s_controls.stepright.generic.type	   = MTYPE_ACTION;
	s_controls.stepright.generic.flags     = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.stepright.generic.callback  = Controls_ActionEvent;
	s_controls.stepright.generic.ownerdraw = Controls_DrawKeyBinding;
	s_controls.stepright.generic.id        = ID_MOVERIGHT;

	s_controls.moveup.generic.type	    = MTYPE_ACTION;
	s_controls.moveup.generic.flags     = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.moveup.generic.callback  = Controls_ActionEvent;
	s_controls.moveup.generic.ownerdraw = Controls_DrawKeyBinding;
	s_controls.moveup.generic.id        = ID_MOVEUP;

	s_controls.movedown.generic.type	  = MTYPE_ACTION;
	s_controls.movedown.generic.flags     = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.movedown.generic.callback  = Controls_ActionEvent;
	s_controls.movedown.generic.ownerdraw = Controls_DrawKeyBinding;
	s_controls.movedown.generic.id        = ID_MOVEDOWN;

	s_controls.turnleft.generic.type	  = MTYPE_ACTION;
	s_controls.turnleft.generic.flags     = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.turnleft.generic.callback  = Controls_ActionEvent;
	s_controls.turnleft.generic.ownerdraw = Controls_DrawKeyBinding;
	s_controls.turnleft.generic.id        = ID_LEFT;

	s_controls.turnright.generic.type	   = MTYPE_ACTION;
	s_controls.turnright.generic.flags     = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.turnright.generic.callback  = Controls_ActionEvent;
	s_controls.turnright.generic.ownerdraw = Controls_DrawKeyBinding;
	s_controls.turnright.generic.id        = ID_RIGHT;

	s_controls.sidestep.generic.type	  = MTYPE_ACTION;
	s_controls.sidestep.generic.flags     = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.sidestep.generic.callback  = Controls_ActionEvent;
	s_controls.sidestep.generic.ownerdraw = Controls_DrawKeyBinding;
	s_controls.sidestep.generic.id        = ID_STRAFE;

	s_controls.run.generic.type	     = MTYPE_ACTION;
	s_controls.run.generic.flags     = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.run.generic.callback  = Controls_ActionEvent;
	s_controls.run.generic.ownerdraw = Controls_DrawKeyBinding;
	s_controls.run.generic.id        = ID_SPEED;

	// JUHOX: init hold breath key binding control
	s_controls.holdBreath.generic.type		= MTYPE_ACTION;
	s_controls.holdBreath.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.holdBreath.generic.callback	= Controls_ActionEvent;
	s_controls.holdBreath.generic.ownerdraw	= Controls_DrawKeyBinding;
	s_controls.holdBreath.generic.id		= ID_HOLD_BREATH;

	s_controls.chainsaw.generic.type	  = MTYPE_ACTION;
	s_controls.chainsaw.generic.flags     = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.chainsaw.generic.callback  = Controls_ActionEvent;
	s_controls.chainsaw.generic.ownerdraw = Controls_DrawKeyBinding;
	s_controls.chainsaw.generic.id        = ID_WEAPON1;

	s_controls.machinegun.generic.type	    = MTYPE_ACTION;
	s_controls.machinegun.generic.flags     = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.machinegun.generic.callback  = Controls_ActionEvent;
	s_controls.machinegun.generic.ownerdraw = Controls_DrawKeyBinding;
	s_controls.machinegun.generic.id        = ID_WEAPON2;

	s_controls.shotgun.generic.type	     = MTYPE_ACTION;
	s_controls.shotgun.generic.flags     = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.shotgun.generic.callback  = Controls_ActionEvent;
	s_controls.shotgun.generic.ownerdraw = Controls_DrawKeyBinding;
	s_controls.shotgun.generic.id        = ID_WEAPON3;

	s_controls.grenadelauncher.generic.type	     = MTYPE_ACTION;
	s_controls.grenadelauncher.generic.flags     = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.grenadelauncher.generic.callback  = Controls_ActionEvent;
	s_controls.grenadelauncher.generic.ownerdraw = Controls_DrawKeyBinding;
	s_controls.grenadelauncher.generic.id        = ID_WEAPON4;

	s_controls.rocketlauncher.generic.type	    = MTYPE_ACTION;
	s_controls.rocketlauncher.generic.flags     = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.rocketlauncher.generic.callback  = Controls_ActionEvent;
	s_controls.rocketlauncher.generic.ownerdraw = Controls_DrawKeyBinding;
	s_controls.rocketlauncher.generic.id        = ID_WEAPON5;

	s_controls.lightning.generic.type	   = MTYPE_ACTION;
	s_controls.lightning.generic.flags     = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.lightning.generic.callback  = Controls_ActionEvent;
	s_controls.lightning.generic.ownerdraw = Controls_DrawKeyBinding;
	s_controls.lightning.generic.id        = ID_WEAPON6;

	s_controls.railgun.generic.type	     = MTYPE_ACTION;
	s_controls.railgun.generic.flags     = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.railgun.generic.callback  = Controls_ActionEvent;
	s_controls.railgun.generic.ownerdraw = Controls_DrawKeyBinding;
	s_controls.railgun.generic.id        = ID_WEAPON7;

	s_controls.plasma.generic.type	    = MTYPE_ACTION;
	s_controls.plasma.generic.flags     = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.plasma.generic.callback  = Controls_ActionEvent;
	s_controls.plasma.generic.ownerdraw = Controls_DrawKeyBinding;
	s_controls.plasma.generic.id        = ID_WEAPON8;

	s_controls.bfg.generic.type	     = MTYPE_ACTION;
	s_controls.bfg.generic.flags     = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.bfg.generic.callback  = Controls_ActionEvent;
	s_controls.bfg.generic.ownerdraw = Controls_DrawKeyBinding;
	s_controls.bfg.generic.id        = ID_WEAPON9;

	// JUHOX: init monster launcher menu item
	s_controls.monsterlauncher.generic.type	     = MTYPE_ACTION;
	s_controls.monsterlauncher.generic.flags     = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.monsterlauncher.generic.callback  = Controls_ActionEvent;
	s_controls.monsterlauncher.generic.ownerdraw = Controls_DrawKeyBinding;
	s_controls.monsterlauncher.generic.id        = ID_WEAPON11;

	// JUHOX: init grappling hook menu item
	s_controls.grapple.generic.type	     = MTYPE_ACTION;
	s_controls.grapple.generic.flags     = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.grapple.generic.callback  = Controls_ActionEvent;
	s_controls.grapple.generic.ownerdraw = Controls_DrawKeyBinding;
	s_controls.grapple.generic.id        = ID_WEAPON10;

	// JUHOX: init toggle hook menu item
	s_controls.toggleHook.generic.type		= MTYPE_ACTION;
	s_controls.toggleHook.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.toggleHook.generic.callback	= Controls_ActionEvent;
	s_controls.toggleHook.generic.ownerdraw	= Controls_DrawKeyBinding;
	s_controls.toggleHook.generic.id		= ID_TOGGLEHOOK;

	// JUHOX: init throw hook menu item
	s_controls.throwHook.generic.type		= MTYPE_ACTION;
	s_controls.throwHook.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.throwHook.generic.callback	= Controls_ActionEvent;
	s_controls.throwHook.generic.ownerdraw	= Controls_DrawKeyBinding;
	s_controls.throwHook.generic.id			= ID_THROWHOOK;

	// JUHOX: init "crouching cuts rope" menu item
	s_controls.crouchingCutsRope.generic.type		= MTYPE_RADIOBUTTON;
	s_controls.crouchingCutsRope.generic.flags		= QMF_SMALLFONT;
	s_controls.crouchingCutsRope.generic.x			= SCREEN_WIDTH/2;
	s_controls.crouchingCutsRope.generic.name		= "crouching cuts grappling rope";
	s_controls.crouchingCutsRope.generic.id			= -1;
	s_controls.crouchingCutsRope.generic.callback	= Controls_MenuEvent;

	s_controls.attack.generic.type	    = MTYPE_ACTION;
	s_controls.attack.generic.flags     = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.attack.generic.callback  = Controls_ActionEvent;
	s_controls.attack.generic.ownerdraw = Controls_DrawKeyBinding;
	s_controls.attack.generic.id        = ID_ATTACK;

	s_controls.prevweapon.generic.type	    = MTYPE_ACTION;
	s_controls.prevweapon.generic.flags     = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.prevweapon.generic.callback  = Controls_ActionEvent;
	s_controls.prevweapon.generic.ownerdraw = Controls_DrawKeyBinding;
	s_controls.prevweapon.generic.id        = ID_WEAPPREV;

	s_controls.nextweapon.generic.type	    = MTYPE_ACTION;
	s_controls.nextweapon.generic.flags     = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.nextweapon.generic.callback  = Controls_ActionEvent;
	s_controls.nextweapon.generic.ownerdraw = Controls_DrawKeyBinding;
	s_controls.nextweapon.generic.id        = ID_WEAPNEXT;

	s_controls.lookup.generic.type	    = MTYPE_ACTION;
	s_controls.lookup.generic.flags     = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.lookup.generic.callback  = Controls_ActionEvent;
	s_controls.lookup.generic.ownerdraw = Controls_DrawKeyBinding;
	s_controls.lookup.generic.id        = ID_LOOKUP;

	s_controls.lookdown.generic.type	  = MTYPE_ACTION;
	s_controls.lookdown.generic.flags     = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.lookdown.generic.callback  = Controls_ActionEvent;
	s_controls.lookdown.generic.ownerdraw = Controls_DrawKeyBinding;
	s_controls.lookdown.generic.id        = ID_LOOKDOWN;

	s_controls.mouselook.generic.type	   = MTYPE_ACTION;
	s_controls.mouselook.generic.flags     = QMF_LEFT_JUSTIFY|QMF_HIGHLIGHT_IF_FOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.mouselook.generic.callback  = Controls_ActionEvent;
	s_controls.mouselook.generic.ownerdraw = Controls_DrawKeyBinding;
	s_controls.mouselook.generic.id        = ID_MOUSELOOK;

	s_controls.freelook.generic.type		= MTYPE_RADIOBUTTON;
	s_controls.freelook.generic.flags		= QMF_SMALLFONT;
	s_controls.freelook.generic.x			= SCREEN_WIDTH/2;
	s_controls.freelook.generic.name		= "free look";
	s_controls.freelook.generic.id			= ID_FREELOOK;
	s_controls.freelook.generic.callback	= Controls_MenuEvent;
	s_controls.freelook.generic.statusbar	= Controls_StatusBar;

	s_controls.centerview.generic.type	    = MTYPE_ACTION;
	s_controls.centerview.generic.flags     = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.centerview.generic.callback  = Controls_ActionEvent;
	s_controls.centerview.generic.ownerdraw = Controls_DrawKeyBinding;
	s_controls.centerview.generic.id        = ID_CENTERVIEW;

	s_controls.zoomview.generic.type	  = MTYPE_ACTION;
	s_controls.zoomview.generic.flags     = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.zoomview.generic.callback  = Controls_ActionEvent;
	s_controls.zoomview.generic.ownerdraw = Controls_DrawKeyBinding;
	s_controls.zoomview.generic.id        = ID_ZOOMVIEW;

	// JUHOX: init toggleview key binding control
	s_controls.toggleview.generic.type	  = MTYPE_ACTION;
	s_controls.toggleview.generic.flags     = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.toggleview.generic.callback  = Controls_ActionEvent;
	s_controls.toggleview.generic.ownerdraw = Controls_DrawKeyBinding;
	s_controls.toggleview.generic.id        = ID_TOGGLEVIEW;

	s_controls.useitem.generic.type	     = MTYPE_ACTION;
	s_controls.useitem.generic.flags     = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.useitem.generic.callback  = Controls_ActionEvent;
	s_controls.useitem.generic.ownerdraw = Controls_DrawKeyBinding;
	s_controls.useitem.generic.id        = ID_USEITEM;

	s_controls.showscores.generic.type	    = MTYPE_ACTION;
	s_controls.showscores.generic.flags     = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.showscores.generic.callback  = Controls_ActionEvent;
	s_controls.showscores.generic.ownerdraw = Controls_DrawKeyBinding;
	s_controls.showscores.generic.id        = ID_SHOWSCORES;

	s_controls.invertmouse.generic.type      = MTYPE_RADIOBUTTON;
	s_controls.invertmouse.generic.flags	 = QMF_SMALLFONT;
	s_controls.invertmouse.generic.x	     = SCREEN_WIDTH/2;
	s_controls.invertmouse.generic.name	     = "invert mouse";
	s_controls.invertmouse.generic.id        = ID_INVERTMOUSE;
	s_controls.invertmouse.generic.callback  = Controls_MenuEvent;
	s_controls.invertmouse.generic.statusbar = Controls_StatusBar;

	s_controls.smoothmouse.generic.type      = MTYPE_RADIOBUTTON;
	s_controls.smoothmouse.generic.flags	 = QMF_SMALLFONT;
	s_controls.smoothmouse.generic.x	     = SCREEN_WIDTH/2;
	s_controls.smoothmouse.generic.name	     = "smooth mouse";
	s_controls.smoothmouse.generic.id        = ID_SMOOTHMOUSE;
	s_controls.smoothmouse.generic.callback  = Controls_MenuEvent;
	s_controls.smoothmouse.generic.statusbar = Controls_StatusBar;

	s_controls.alwaysrun.generic.type      = MTYPE_RADIOBUTTON;
	s_controls.alwaysrun.generic.flags	   = QMF_SMALLFONT;
	s_controls.alwaysrun.generic.x	       = SCREEN_WIDTH/2;
	s_controls.alwaysrun.generic.name	   = "always run";
	s_controls.alwaysrun.generic.id        = ID_ALWAYSRUN;
	s_controls.alwaysrun.generic.callback  = Controls_MenuEvent;
	s_controls.alwaysrun.generic.statusbar = Controls_StatusBar;

	s_controls.autoswitch.generic.type      = MTYPE_RADIOBUTTON;
	s_controls.autoswitch.generic.flags	    = QMF_SMALLFONT;
	s_controls.autoswitch.generic.x	        = SCREEN_WIDTH/2;
	s_controls.autoswitch.generic.name	    = "autoswitch weapons";
	s_controls.autoswitch.generic.id        = ID_AUTOSWITCH;
	s_controls.autoswitch.generic.callback  = Controls_MenuEvent;
	s_controls.autoswitch.generic.statusbar = Controls_StatusBar;

	s_controls.sensitivity.generic.type	     = MTYPE_SLIDER;
	s_controls.sensitivity.generic.x		 = SCREEN_WIDTH/2;
	s_controls.sensitivity.generic.flags	 = QMF_SMALLFONT;
	s_controls.sensitivity.generic.name	     = "mouse speed";
	s_controls.sensitivity.generic.id 	     = ID_MOUSESPEED;
	s_controls.sensitivity.generic.callback  = Controls_MenuEvent;
	s_controls.sensitivity.minvalue		     = 2;
	s_controls.sensitivity.maxvalue		     = 30;
	s_controls.sensitivity.generic.statusbar = Controls_StatusBar;

	s_controls.gesture.generic.type	     = MTYPE_ACTION;
	s_controls.gesture.generic.flags     = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.gesture.generic.callback  = Controls_ActionEvent;
	s_controls.gesture.generic.ownerdraw = Controls_DrawKeyBinding;
	s_controls.gesture.generic.id        = ID_GESTURE;

	s_controls.chat.generic.type	  = MTYPE_ACTION;
	s_controls.chat.generic.flags     = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.chat.generic.callback  = Controls_ActionEvent;
	s_controls.chat.generic.ownerdraw = Controls_DrawKeyBinding;
	s_controls.chat.generic.id        = ID_CHAT;

	s_controls.chat2.generic.type	   = MTYPE_ACTION;
	s_controls.chat2.generic.flags     = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.chat2.generic.callback  = Controls_ActionEvent;
	s_controls.chat2.generic.ownerdraw = Controls_DrawKeyBinding;
	s_controls.chat2.generic.id        = ID_CHAT2;

	s_controls.chat3.generic.type	   = MTYPE_ACTION;
	s_controls.chat3.generic.flags     = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.chat3.generic.callback  = Controls_ActionEvent;
	s_controls.chat3.generic.ownerdraw = Controls_DrawKeyBinding;
	s_controls.chat3.generic.id        = ID_CHAT3;

	s_controls.chat4.generic.type	   = MTYPE_ACTION;
	s_controls.chat4.generic.flags     = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.chat4.generic.callback  = Controls_ActionEvent;
	s_controls.chat4.generic.ownerdraw = Controls_DrawKeyBinding;
	s_controls.chat4.generic.id        = ID_CHAT4;

	// JUHOX: init give health key binding control
	s_controls.givehealth.generic.type		= MTYPE_ACTION;
	s_controls.givehealth.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.givehealth.generic.callback	= Controls_ActionEvent;
	s_controls.givehealth.generic.ownerdraw	= Controls_DrawKeyBinding;
	s_controls.givehealth.generic.id		= ID_GIVEHEALTH;

	// JUHOX: init give armor key binding control
	s_controls.givearmor.generic.type		= MTYPE_ACTION;
	s_controls.givearmor.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.givearmor.generic.callback	= Controls_ActionEvent;
	s_controls.givearmor.generic.ownerdraw	= Controls_DrawKeyBinding;
	s_controls.givearmor.generic.id			= ID_GIVEARMOR;

	// JUHOX: init TSS interface key binding control
	s_controls.tssInterface.generic.type		= MTYPE_ACTION;
	s_controls.tssInterface.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.tssInterface.generic.callback	= Controls_ActionEvent;
	s_controls.tssInterface.generic.ownerdraw	= Controls_DrawKeyBinding;
	s_controls.tssInterface.generic.id			= ID_TSSI;

	// JUHOX: init navigation aid key binding control
	s_controls.navAid.generic.type		= MTYPE_ACTION;
	s_controls.navAid.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.navAid.generic.callback	= Controls_ActionEvent;
	s_controls.navAid.generic.ownerdraw	= Controls_DrawKeyBinding;
	s_controls.navAid.generic.id		= ID_NAVAID;

	// JUHOX: init tight group formation key binding control
	s_controls.gfTight.generic.type			= MTYPE_ACTION;
	s_controls.gfTight.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.gfTight.generic.callback		= Controls_ActionEvent;
	s_controls.gfTight.generic.ownerdraw	= Controls_DrawKeyBinding;
	s_controls.gfTight.generic.id			= ID_GF_TIGHT;

	// JUHOX: init loose group formation key binding control
	s_controls.gfLoose.generic.type			= MTYPE_ACTION;
	s_controls.gfLoose.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.gfLoose.generic.callback		= Controls_ActionEvent;
	s_controls.gfLoose.generic.ownerdraw	= Controls_DrawKeyBinding;
	s_controls.gfLoose.generic.id			= ID_GF_LOOSE;

	// JUHOX: init free group formation key binding control
	s_controls.gfFree.generic.type		= MTYPE_ACTION;
	s_controls.gfFree.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.gfFree.generic.callback	= Controls_ActionEvent;
	s_controls.gfFree.generic.ownerdraw	= Controls_DrawKeyBinding;
	s_controls.gfFree.generic.id		= ID_GF_FREE;

	s_controls.joyenable.generic.type      = MTYPE_RADIOBUTTON;
	s_controls.joyenable.generic.flags	   = QMF_SMALLFONT;
	s_controls.joyenable.generic.x	       = SCREEN_WIDTH/2;
	s_controls.joyenable.generic.name	   = "joystick";
	s_controls.joyenable.generic.id        = ID_JOYENABLE;
	s_controls.joyenable.generic.callback  = Controls_MenuEvent;
	s_controls.joyenable.generic.statusbar = Controls_StatusBar;

	s_controls.joythreshold.generic.type	  = MTYPE_SLIDER;
	s_controls.joythreshold.generic.x		  = SCREEN_WIDTH/2;
	s_controls.joythreshold.generic.flags	  = QMF_SMALLFONT;
	s_controls.joythreshold.generic.name	  = "joystick threshold";
	s_controls.joythreshold.generic.id 	      = ID_JOYTHRESHOLD;
	s_controls.joythreshold.generic.callback  = Controls_MenuEvent;
	s_controls.joythreshold.minvalue		  = 0.05f;
	s_controls.joythreshold.maxvalue		  = 0.75f;
	s_controls.joythreshold.generic.statusbar = Controls_StatusBar;

	// JUHOX: init best weapon key binding control
	s_controls.bestweapon.generic.type		= MTYPE_ACTION;
	s_controls.bestweapon.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.bestweapon.generic.callback	= Controls_ActionEvent;
	s_controls.bestweapon.generic.ownerdraw	= Controls_DrawKeyBinding;
	s_controls.bestweapon.generic.id		= ID_WEAPBEST;
	// JUHOX: init skip weapon key binding control
	s_controls.skipweapon.generic.type		= MTYPE_ACTION;
	s_controls.skipweapon.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.skipweapon.generic.callback	= Controls_ActionEvent;
	s_controls.skipweapon.generic.ownerdraw	= Controls_DrawKeyBinding;
	s_controls.skipweapon.generic.id		= ID_WEAPSKIP;

	// JUHOX: init autoswitch ammo limit control
	s_controls.autoswitchAmmoLimit.generic.type			= MTYPE_FIELD;
	s_controls.autoswitchAmmoLimit.generic.flags		= QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	s_controls.autoswitchAmmoLimit.generic.name			= "ammo limit [%]";
	s_controls.autoswitchAmmoLimit.generic.id			= ID_AUTOSWITCHAMMOLIMIT;
	s_controls.autoswitchAmmoLimit.generic.statusbar	= Controls_AutoswitchAmmoLimitStatusbar;
	s_controls.autoswitchAmmoLimit.field.widthInChars	= 4;
	s_controls.autoswitchAmmoLimit.field.maxchars		= 3;

	// JUHOX: init next weapon order key binding control
	s_controls.nextWeaponOrder.generic.type			= MTYPE_ACTION;
	s_controls.nextWeaponOrder.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.nextWeaponOrder.generic.callback		= Controls_ActionEvent;
	s_controls.nextWeaponOrder.generic.ownerdraw	= Controls_DrawKeyBinding;
	s_controls.nextWeaponOrder.generic.id			= ID_NEXTWPORD;
	// JUHOX: init prev weapon order key binding control
	s_controls.prevWeaponOrder.generic.type			= MTYPE_ACTION;
	s_controls.prevWeaponOrder.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.prevWeaponOrder.generic.callback		= Controls_ActionEvent;
	s_controls.prevWeaponOrder.generic.ownerdraw	= Controls_DrawKeyBinding;
	s_controls.prevWeaponOrder.generic.id			= ID_PREVWPORD;

	// JUHOX: init weapon order switch control
	s_controls.weaponOrderSwitch.generic.type		= MTYPE_ACTION;
	s_controls.weaponOrderSwitch.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.weaponOrderSwitch.generic.callback	= Controls_MenuEvent;
	s_controls.weaponOrderSwitch.generic.ownerdraw	= Controls_DrawWeaponOrderSwitch;
	s_controls.weaponOrderSwitch.generic.id			= ID_WEAPONORDERSWITCH;

	// JUHOX: init add weapon order name control
	s_controls.weaponOrderName.generic.type			= MTYPE_FIELD;
	s_controls.weaponOrderName.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	s_controls.weaponOrderName.generic.name			= "category name";
	s_controls.weaponOrderName.generic.statusbar	= Controls_CategoryNameStatusbar;
	s_controls.weaponOrderName.field.widthInChars	= 16;
	s_controls.weaponOrderName.field.maxchars		= 19;
	s_controls.currentlyDrawnWeaponOrderName = -1;

	// JUHOX: init weapon category key binding control
	s_controls.weaponCategory.generic.type		= MTYPE_ACTION;
	s_controls.weaponCategory.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
	s_controls.weaponCategory.generic.callback	= Controls_ActionEvent;
	s_controls.weaponCategory.generic.ownerdraw	= Controls_DrawKeyBinding;
	s_controls.weaponCategory.generic.id		= ID_WEAPCAT0;

	s_controls.name.generic.type	= MTYPE_PTEXT;
	s_controls.name.generic.flags	= QMF_CENTER_JUSTIFY|QMF_INACTIVE;
	s_controls.name.generic.x		= 320;
	s_controls.name.generic.y		= 440;
	s_controls.name.string			= playername;
	s_controls.name.style			= UI_CENTER;
	s_controls.name.color			= text_color_normal;

	Menu_AddItem( &s_controls.menu, &s_controls.banner );
	Menu_AddItem( &s_controls.menu, &s_controls.framel );
	Menu_AddItem( &s_controls.menu, &s_controls.framer );
	Menu_AddItem( &s_controls.menu, &s_controls.player );
	Menu_AddItem( &s_controls.menu, &s_controls.name );

	Menu_AddItem( &s_controls.menu, &s_controls.looking );
	Menu_AddItem( &s_controls.menu, &s_controls.movement );
	Menu_AddItem( &s_controls.menu, &s_controls.weapons );
	Menu_AddItem( &s_controls.menu, &s_controls.prios );	// JUHOX
	Menu_AddItem( &s_controls.menu, &s_controls.misc );

	Menu_AddItem( &s_controls.menu, &s_controls.sensitivity );
	Menu_AddItem( &s_controls.menu, &s_controls.smoothmouse );
	Menu_AddItem( &s_controls.menu, &s_controls.invertmouse );
	Menu_AddItem( &s_controls.menu, &s_controls.lookup );
	Menu_AddItem( &s_controls.menu, &s_controls.lookdown );
	Menu_AddItem( &s_controls.menu, &s_controls.mouselook );
	Menu_AddItem( &s_controls.menu, &s_controls.freelook );
	Menu_AddItem( &s_controls.menu, &s_controls.centerview );
	Menu_AddItem( &s_controls.menu, &s_controls.zoomview );
	Menu_AddItem( &s_controls.menu, &s_controls.toggleview );	// JUHOX
	Menu_AddItem( &s_controls.menu, &s_controls.joyenable );
	Menu_AddItem( &s_controls.menu, &s_controls.joythreshold );

	Menu_AddItem( &s_controls.menu, &s_controls.alwaysrun );
	Menu_AddItem( &s_controls.menu, &s_controls.run );
	Menu_AddItem( &s_controls.menu, &s_controls.walkforward );
	Menu_AddItem( &s_controls.menu, &s_controls.backpedal );
	Menu_AddItem( &s_controls.menu, &s_controls.stepleft );
	Menu_AddItem( &s_controls.menu, &s_controls.stepright );
	Menu_AddItem( &s_controls.menu, &s_controls.moveup );
	Menu_AddItem( &s_controls.menu, &s_controls.movedown );
	Menu_AddItem( &s_controls.menu, &s_controls.turnleft );
	Menu_AddItem( &s_controls.menu, &s_controls.turnright );
	Menu_AddItem( &s_controls.menu, &s_controls.sidestep );
	Menu_AddItem(&s_controls.menu, &s_controls.holdBreath);	// JUHOX

	Menu_AddItem( &s_controls.menu, &s_controls.attack );
	Menu_AddItem( &s_controls.menu, &s_controls.nextweapon );
	Menu_AddItem( &s_controls.menu, &s_controls.prevweapon );
	Menu_AddItem( &s_controls.menu, &s_controls.autoswitch );
	Menu_AddItem( &s_controls.menu, &s_controls.chainsaw );
	Menu_AddItem( &s_controls.menu, &s_controls.machinegun );
	Menu_AddItem( &s_controls.menu, &s_controls.shotgun );
	Menu_AddItem( &s_controls.menu, &s_controls.grenadelauncher );
	Menu_AddItem( &s_controls.menu, &s_controls.rocketlauncher );
	Menu_AddItem( &s_controls.menu, &s_controls.lightning );
	Menu_AddItem( &s_controls.menu, &s_controls.railgun );
	Menu_AddItem( &s_controls.menu, &s_controls.plasma );
	Menu_AddItem( &s_controls.menu, &s_controls.bfg );
	Menu_AddItem(&s_controls.menu, &s_controls.grapple);	// JUHOX
	Menu_AddItem(&s_controls.menu, &s_controls.monsterlauncher);	// JUHOX
	Menu_AddItem(&s_controls.menu, &s_controls.toggleHook);	// JUHOX
	Menu_AddItem(&s_controls.menu, &s_controls.throwHook);	// JUHOX
	Menu_AddItem(&s_controls.menu, &s_controls.crouchingCutsRope);	// JUHOX

	Menu_AddItem( &s_controls.menu, &s_controls.showscores );
	Menu_AddItem( &s_controls.menu, &s_controls.useitem );
	Menu_AddItem( &s_controls.menu, &s_controls.gesture );
	Menu_AddItem( &s_controls.menu, &s_controls.chat );
	Menu_AddItem( &s_controls.menu, &s_controls.chat2 );
	Menu_AddItem( &s_controls.menu, &s_controls.chat3 );
	Menu_AddItem( &s_controls.menu, &s_controls.chat4 );
	Menu_AddItem( &s_controls.menu, &s_controls.givehealth);	// JUHOX
	Menu_AddItem( &s_controls.menu, &s_controls.givearmor);	// JUHOX
	Menu_AddItem( &s_controls.menu, &s_controls.tssInterface);	// JUHOX
	Menu_AddItem( &s_controls.menu, &s_controls.navAid);	// JUHOX
	Menu_AddItem( &s_controls.menu, &s_controls.gfTight);	// JUHOX
	Menu_AddItem( &s_controls.menu, &s_controls.gfLoose);	// JUHOX
	Menu_AddItem( &s_controls.menu, &s_controls.gfFree);	// JUHOX
	Menu_AddItem( &s_controls.menu, &s_controls.nextWeaponOrder);	// JUHOX
	Menu_AddItem( &s_controls.menu, &s_controls.prevWeaponOrder);	// JUHOX

	Menu_AddItem( &s_controls.menu, &s_controls.back );

	Menu_AddItem(&s_controls.menu, &s_controls.bestweapon);	// JUHOX
	Menu_AddItem(&s_controls.menu, &s_controls.skipweapon);	// JUHOX
	Menu_AddItem(&s_controls.menu, &s_controls.autoswitchAmmoLimit);	// JUHOX
	Menu_AddItem(&s_controls.menu, &s_controls.weaponOrderSwitch);	// JUHOX
	Menu_AddItem(&s_controls.menu, &s_controls.weaponOrderName);	// JUHOX
	Menu_AddItem(&s_controls.menu, &s_controls.weaponCategory);	// JUHOX
	// JUHOX: init & add weapon list controls
	{
		int i;

		for (i = 0; i < WEAPONLIST_SIZE; i++)
		{
			s_controls.weaponList[i].generic.type		= MTYPE_ACTION;
			s_controls.weaponList[i].generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_HIDDEN;
			s_controls.weaponList[i].generic.callback	= Controls_WeaponListEvent;
			s_controls.weaponList[i].generic.ownerdraw	= Controls_DrawWeaponListItem;
			s_controls.weaponList[i].generic.id			= i;
			s_controls.weaponList[i].generic.statusbar	= Controls_WeaponListStatusbar;
			Menu_AddItem(&s_controls.menu, &s_controls.weaponList[i]);
		}
	}
	s_controls.weaponListSelection = -1;

	trap_Cvar_VariableStringBuffer( "name", s_controls.name.string, 16 );
	Q_CleanStr( s_controls.name.string );

	// initialize the configurable cvars
	Controls_InitCvars();

	// initialize the current config
	Controls_GetConfig();

	// intialize the model
	Controls_InitModel();

	// intialize the weapons
	Controls_InitWeapons ();

	// initial default section
	s_controls.section = C_LOOKING;

	// update the ui
	Controls_Update();
}


/*
=================
Controls_Cache
=================
*/
void Controls_Cache( void ) {
	trap_R_RegisterShaderNoMip( ART_BACK0 );
	trap_R_RegisterShaderNoMip( ART_BACK1 );
	trap_R_RegisterShaderNoMip( ART_FRAMEL );
	trap_R_RegisterShaderNoMip( ART_FRAMER );
}


/*
=================
UI_ControlsMenu
=================
*/
void UI_ControlsMenu( void ) {
	Controls_MenuInit();
	UI_PushMenu( &s_controls.menu );
}
