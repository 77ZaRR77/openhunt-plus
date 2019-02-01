// Copyright (C) 1999-2000 Id Software, Inc.
//
// bg_misc.c -- both games misc functions, all completely stateless

#include "q_shared.h"
#include "bg_public.h"

/*QUAKED item_***** ( 0 0 0 ) (-16 -16 -16) (16 16 16) suspended
DO NOT USE THIS CLASS, IT JUST HOLDS GENERAL INFORMATION.
The suspended flag will allow items to hang in the air, otherwise they are dropped to the next surface.

If an item is the target of another entity, it will not spawn in until fired.

An item fires all of its targets when it is picked up.  If the toucher can't carry it, the targets won't be fired.

"notfree" if set to 1, don't spawn in free for all games
"notteam" if set to 1, don't spawn in team games
"notsingle" if set to 1, don't spawn in single player games
"wait"	override the default wait before respawning.  -1 = never respawn automatically, which can be used with targeted spawning.
"random" random number of plus or minus seconds varied from the respawn time
"count" override quantity or duration on most items.
*/

gitem_t	bg_itemlist[] =
{
	{
		NULL,
		NULL,
		{ NULL,
		NULL,
		0, 0} ,
/* icon */		NULL,
/* pickup */	NULL,
		0,
		0,
		0,
/* precache */ "",
/* sounds */ ""
	},	// leave index 0 alone

	//
	// ARMOR
	//

/*QUAKED item_armor_shard (.3 .3 1) (-16 -16 -16) (16 16 16) suspended
*/
	{
		"item_armor_shard",
		"sound/misc/ar1_pkup.wav",
		{ "models/powerups/armor/shard.md3",
		"models/powerups/armor/shard_sphere.md3",
		0, 0} ,
/* icon */		"icons/iconr_shard",
/* pickup */	"Armor Shard",
		5,
		IT_ARMOR,
		0,
/* precache */ "",
/* sounds */ ""
	},

/*QUAKED item_armor_combat (.3 .3 1) (-16 -16 -16) (16 16 16) suspended
*/
	{
		"item_armor_combat",
		"sound/misc/ar2_pkup.wav",
        { "models/powerups/armor/armor_yel.md3",
		0, 0, 0},
/* icon */		"icons/iconr_yellow",
/* pickup */	"Armor",
		50,
		IT_ARMOR,
		0,
/* precache */ "",
/* sounds */ ""
	},

/*QUAKED item_armor_body (.3 .3 1) (-16 -16 -16) (16 16 16) suspended
*/
	{
		"item_armor_body",
		"sound/misc/ar2_pkup.wav",
        { "models/powerups/armor/armor_red.md3",
		0, 0, 0},
/* icon */		"icons/iconr_red",
/* pickup */	"Heavy Armor",
		100,
		IT_ARMOR,
		0,
/* precache */ "",
/* sounds */ ""
	},

	//
	// health
	//
/*QUAKED item_health_small (.3 .3 1) (-16 -16 -16) (16 16 16) suspended
*/
	{
		"item_health_small",
		"sound/items/s_health.wav",
        { "models/powerups/health/small_cross.md3",
		"models/powerups/health/small_sphere.md3",
		0, 0 },
/* icon */		"icons/iconh_green",
/* pickup */	"5 Health",
		5,
		IT_HEALTH,
		0,
/* precache */ "",
/* sounds */ ""
	},

/*QUAKED item_health (.3 .3 1) (-16 -16 -16) (16 16 16) suspended
*/
	{
		"item_health",
		"sound/items/n_health.wav",
        { "models/powerups/health/medium_cross.md3",
		"models/powerups/health/medium_sphere.md3",
		0, 0 },
/* icon */		"icons/iconh_yellow",
/* pickup */	"25 Health",
		25,
		IT_HEALTH,
		0,
/* precache */ "",
/* sounds */ ""
	},

/*QUAKED item_health_large (.3 .3 1) (-16 -16 -16) (16 16 16) suspended
*/
	{
		"item_health_large",
		"sound/items/l_health.wav",
        { "models/powerups/health/large_cross.md3",
		"models/powerups/health/large_sphere.md3",
		0, 0 },
/* icon */		"icons/iconh_red",
/* pickup */	"50 Health",
		50,
		IT_HEALTH,
		0,
/* precache */ "",
/* sounds */ ""
	},

/*QUAKED item_health_mega (.3 .3 1) (-16 -16 -16) (16 16 16) suspended
*/
	{
		"item_health_mega",
		"sound/items/m_health.wav",
        { "models/powerups/health/mega_cross.md3",
		"models/powerups/health/mega_sphere.md3",
		0, 0 },
/* icon */		"icons/iconh_mega",
/* pickup */	"Mega Health",
		100,
		IT_HEALTH,
		0,
/* precache */ "",
/* sounds */ ""
	},


	//
	// WEAPONS
	//

/*QUAKED weapon_gauntlet (.3 .3 1) (-16 -16 -16) (16 16 16) suspended
*/
	{
		"weapon_gauntlet",
		"sound/misc/w_pkup.wav",
        { "models/weapons2/gauntlet/gauntlet.md3",
		0, 0, 0},
/* icon */		"icons/iconw_gauntlet",
/* pickup */	"Gauntlet",
		0,
		IT_WEAPON,
		WP_GAUNTLET,
/* precache */ "",
/* sounds */ ""
	},

/*QUAKED weapon_shotgun (.3 .3 1) (-16 -16 -16) (16 16 16) suspended
*/
	{
		"weapon_shotgun",
		"sound/misc/w_pkup.wav",
        { "models/weapons2/shotgun/shotgun.md3",
		0, 0, 0},
/* icon */		"icons/iconw_shotgun",
/* pickup */	"Shotgun",
		10,
		IT_WEAPON,
		WP_SHOTGUN,
/* precache */ "",
/* sounds */ ""
	},

/*QUAKED weapon_machinegun (.3 .3 1) (-16 -16 -16) (16 16 16) suspended
*/
	{
		"weapon_machinegun",
		"sound/misc/w_pkup.wav",
        { "models/weapons2/machinegun/machinegun.md3",
		0, 0, 0},
/* icon */		"icons/iconw_machinegun",
/* pickup */	"Machinegun",
		40,
		IT_WEAPON,
		WP_MACHINEGUN,
/* precache */ "",
/* sounds */ ""
	},

/*QUAKED weapon_grenadelauncher (.3 .3 1) (-16 -16 -16) (16 16 16) suspended
*/
	{
		"weapon_grenadelauncher",
		"sound/misc/w_pkup.wav",
        { "models/weapons2/grenadel/grenadel.md3",
		0, 0, 0},
/* icon */		"icons/iconw_grenade",
/* pickup */	"Grenade Launcher",
		10,
		IT_WEAPON,
		WP_GRENADE_LAUNCHER,
/* precache */ "",
/* sounds */ "sound/weapons/grenade/hgrenb1a.wav sound/weapons/grenade/hgrenb2a.wav"
	},

/*QUAKED weapon_rocketlauncher (.3 .3 1) (-16 -16 -16) (16 16 16) suspended
*/
	{
		"weapon_rocketlauncher",
		"sound/misc/w_pkup.wav",
        { "models/weapons2/rocketl/rocketl.md3",
		0, 0, 0},
/* icon */		"icons/iconw_rocket",
/* pickup */	"Rocket Launcher",
		10,
		IT_WEAPON,
		WP_ROCKET_LAUNCHER,
/* precache */ "",
/* sounds */ ""
	},

/*QUAKED weapon_lightning (.3 .3 1) (-16 -16 -16) (16 16 16) suspended
*/
	{
		"weapon_lightning",
		"sound/misc/w_pkup.wav",
        { "models/weapons2/lightning/lightning.md3",
		0, 0, 0},
/* icon */		"icons/iconw_lightning",
/* pickup */	"Lightning Gun",
		100,
		IT_WEAPON,
		WP_LIGHTNING,
/* precache */ "",
/* sounds */ ""
	},

/*QUAKED weapon_railgun (.3 .3 1) (-16 -16 -16) (16 16 16) suspended
*/
	{
		"weapon_railgun",
		"sound/misc/w_pkup.wav",
        { "models/weapons2/railgun/railgun.md3",
		0, 0, 0},
/* icon */		"icons/iconw_railgun",
/* pickup */	"Railgun",
		10,
		IT_WEAPON,
		WP_RAILGUN,
/* precache */ "",
/* sounds */ ""
	},

/*QUAKED weapon_plasmagun (.3 .3 1) (-16 -16 -16) (16 16 16) suspended
*/
	{
		"weapon_plasmagun",
		"sound/misc/w_pkup.wav",
        { "models/weapons2/plasma/plasma.md3",
		0, 0, 0},
/* icon */		"icons/iconw_plasma",
/* pickup */	"Plasma Gun",
		50,
		IT_WEAPON,
		WP_PLASMAGUN,
/* precache */ "",
/* sounds */ ""
	},

/*QUAKED weapon_bfg (.3 .3 1) (-16 -16 -16) (16 16 16) suspended
*/
	{
		"weapon_bfg",
		"sound/misc/w_pkup.wav",
        { "models/weapons2/bfg/bfg.md3",
		0, 0, 0},
/* icon */		"icons/iconw_bfg",
/* pickup */	"BFG10K",
		20,
		IT_WEAPON,
		WP_BFG,
/* precache */ "",
/* sounds */ ""
	},

/*QUAKED weapon_grapplinghook (.3 .3 1) (-16 -16 -16) (16 16 16) suspended
*/
	{
		"weapon_grapplinghook",
		"sound/misc/w_pkup.wav",
        { "models/weapons2/grapple/grapple.md3",
		0, 0, 0},
/* icon */		"icons/iconw_grapple",
/* pickup */	"Grappling Hook",
		0,
		IT_WEAPON,
		WP_GRAPPLING_HOOK,
/* precache */ "",
/* sounds */ ""
	},

	//
	// AMMO ITEMS
	//

/*QUAKED ammo_shells (.3 .3 1) (-16 -16 -16) (16 16 16) suspended
*/
	{
		"ammo_shells",
		"sound/misc/am_pkup.wav",
        { "models/powerups/ammo/shotgunam.md3",
		0, 0, 0},
/* icon */		"icons/icona_shotgun",
/* pickup */	"Shells",
		10,
		IT_AMMO,
		WP_SHOTGUN,
/* precache */ "",
/* sounds */ ""
	},

/*QUAKED ammo_bullets (.3 .3 1) (-16 -16 -16) (16 16 16) suspended
*/
	{
		"ammo_bullets",
		"sound/misc/am_pkup.wav",
        { "models/powerups/ammo/machinegunam.md3",
		0, 0, 0},
/* icon */		"icons/icona_machinegun",
/* pickup */	"Bullets",
		50,
		IT_AMMO,
		WP_MACHINEGUN,
/* precache */ "",
/* sounds */ ""
	},

/*QUAKED ammo_grenades (.3 .3 1) (-16 -16 -16) (16 16 16) suspended
*/
	{
		"ammo_grenades",
		"sound/misc/am_pkup.wav",
        { "models/powerups/ammo/grenadeam.md3",
		0, 0, 0},
/* icon */		"icons/icona_grenade",
/* pickup */	"Grenades",
		5,
		IT_AMMO,
		WP_GRENADE_LAUNCHER,
/* precache */ "",
/* sounds */ ""
	},

/*QUAKED ammo_cells (.3 .3 1) (-16 -16 -16) (16 16 16) suspended
*/
	{
		"ammo_cells",
		"sound/misc/am_pkup.wav",
        { "models/powerups/ammo/plasmaam.md3",
		0, 0, 0},
/* icon */		"icons/icona_plasma",
/* pickup */	"Cells",
		30,
		IT_AMMO,
		WP_PLASMAGUN,
/* precache */ "",
/* sounds */ ""
	},

/*QUAKED ammo_lightning (.3 .3 1) (-16 -16 -16) (16 16 16) suspended
*/
	{
		"ammo_lightning",
		"sound/misc/am_pkup.wav",
        { "models/powerups/ammo/lightningam.md3",
		0, 0, 0},
/* icon */		"icons/icona_lightning",
/* pickup */	"Lightning",
		60,
		IT_AMMO,
		WP_LIGHTNING,
/* precache */ "",
/* sounds */ ""
	},

/*QUAKED ammo_rockets (.3 .3 1) (-16 -16 -16) (16 16 16) suspended
*/
	{
		"ammo_rockets",
		"sound/misc/am_pkup.wav",
        { "models/powerups/ammo/rocketam.md3",
		0, 0, 0},
/* icon */		"icons/icona_rocket",
/* pickup */	"Rockets",
		5,
		IT_AMMO,
		WP_ROCKET_LAUNCHER,
/* precache */ "",
/* sounds */ ""
	},

/*QUAKED ammo_slugs (.3 .3 1) (-16 -16 -16) (16 16 16) suspended
*/
	{
		"ammo_slugs",
		"sound/misc/am_pkup.wav",
        { "models/powerups/ammo/railgunam.md3",
		0, 0, 0},
/* icon */		"icons/icona_railgun",
/* pickup */	"Slugs",
		10,
		IT_AMMO,
		WP_RAILGUN,
/* precache */ "",
/* sounds */ ""
	},

/*QUAKED ammo_bfg (.3 .3 1) (-16 -16 -16) (16 16 16) suspended
*/
	{
		"ammo_bfg",
		"sound/misc/am_pkup.wav",
        { "models/powerups/ammo/bfgam.md3",
		0, 0, 0},
/* icon */		"icons/icona_bfg",
/* pickup */	"Bfg Ammo",
		15,
		IT_AMMO,
		WP_BFG,
/* precache */ "",
/* sounds */ ""
	},

	//
	// HOLDABLE ITEMS
	//
/*QUAKED holdable_teleporter (.3 .3 1) (-16 -16 -16) (16 16 16) suspended
*/
	{
		"holdable_teleporter",
		"sound/items/holdable.wav",
        { "models/powerups/holdable/teleporter.md3",
		0, 0, 0},
/* icon */		"icons/teleporter",
/* pickup */	"Personal Teleporter",
		60,
		IT_HOLDABLE,
		HI_TELEPORTER,
/* precache */ "",
/* sounds */ ""
	},
/*QUAKED holdable_medkit (.3 .3 1) (-16 -16 -16) (16 16 16) suspended
*/
	{
		"holdable_medkit",
		"sound/items/holdable.wav",
        {
		"models/powerups/holdable/medkit.md3",
		"models/powerups/holdable/medkit_sphere.md3",
		0, 0},
/* icon */		"icons/medkit",
/* pickup */	"Medkit",
		60,
		IT_HOLDABLE,
		HI_MEDKIT,
/* precache */ "",
/* sounds */ "sound/items/use_medkit.wav"
	},

	//
	// POWERUP ITEMS
	//
/*QUAKED item_quad (.3 .3 1) (-16 -16 -16) (16 16 16) suspended
*/
	{
		"item_quad",
		"sound/items/quaddamage.wav",
        { "models/powerups/instant/quad.md3",
        "models/powerups/instant/quad_ring.md3",
		0, 0 },
/* icon */		"icons/quad",
/* pickup */	"Quad Damage",
		30,
		IT_POWERUP,
		PW_QUAD,
/* precache */ "",
/* sounds */ "sound/items/damage2.wav sound/items/damage3.wav"
	},

/*QUAKED item_enviro (.3 .3 1) (-16 -16 -16) (16 16 16) suspended
*/
	{
		"item_enviro",
		"sound/items/protect.wav",
        { "models/powerups/instant/enviro.md3",
		"models/powerups/instant/enviro_ring.md3",
		0, 0 },
/* icon */		"icons/envirosuit",
/* pickup */	"Battle Suit",
		30,
		IT_POWERUP,
		PW_BATTLESUIT,
/* precache */ "",
/* sounds */ "sound/items/airout.wav sound/items/protect3.wav"
	},

/*QUAKED item_haste (.3 .3 1) (-16 -16 -16) (16 16 16) suspended
*/
	{
		"item_haste",
		"sound/items/haste.wav",
        { "models/powerups/instant/haste.md3",
		"models/powerups/instant/haste_ring.md3",
		0, 0 },
/* icon */		"icons/haste",
/* pickup */	"Speed",
		30,
		IT_POWERUP,
		PW_HASTE,
/* precache */ "",
/* sounds */ ""
	},

/*QUAKED item_invis (.3 .3 1) (-16 -16 -16) (16 16 16) suspended
*/
	{
		"item_invis",
		"sound/items/invisibility.wav",
        { "models/powerups/instant/invis.md3",
		"models/powerups/instant/invis_ring.md3",
		0, 0 },
/* icon */		"icons/invis",
/* pickup */	"Invisibility",
		30,
		IT_POWERUP,
		PW_INVIS,
/* precache */ "",
/* sounds */ ""
	},

/*QUAKED item_regen (.3 .3 1) (-16 -16 -16) (16 16 16) suspended
*/
	{
		"item_regen",
		"sound/items/regeneration.wav",
        { "models/powerups/instant/regen.md3",
		"models/powerups/instant/regen_ring.md3",
		0, 0 },
/* icon */		"icons/regen",
/* pickup */	"Regeneration",
		30,
		IT_POWERUP,
		PW_REGEN,
/* precache */ "",
/* sounds */ "sound/items/regen.wav"
	},

/*QUAKED item_flight (.3 .3 1) (-16 -16 -16) (16 16 16) suspended
*/
	{
		"item_flight",
		"sound/items/flight.wav",
        { "models/powerups/instant/flight.md3",
		"models/powerups/instant/flight_ring.md3",
		0, 0 },
/* icon */		"icons/flight",
/* pickup */	"Flight",
		60,
		IT_POWERUP,
		PW_FLIGHT,
/* precache */ "",
/* sounds */ "sound/items/flight.wav"
	},

/*QUAKED team_CTF_redflag (1 0 0) (-16 -16 -16) (16 16 16)
Only in CTF games
*/
	{
		"team_CTF_redflag",
		NULL,
        { "models/flags/r_flag.md3",
		0, 0, 0 },
/* icon */		"icons/iconf_red1",
/* pickup */	"Red Flag",
		0,
		IT_TEAM,
		PW_REDFLAG,
/* precache */ "",
/* sounds */ ""
	},

/*QUAKED team_CTF_blueflag (0 0 1) (-16 -16 -16) (16 16 16)
Only in CTF games
*/
	{
		"team_CTF_blueflag",
		NULL,
        { "models/flags/b_flag.md3",
		0, 0, 0 },
/* icon */		"icons/iconf_blu1",
/* pickup */	"Blue Flag",
		0,
		IT_TEAM,
		PW_BLUEFLAG,
/* precache */ "",
/* sounds */ ""
	},

// JUHOX: charge powerup item definition
/*QUAKED item_charge (.3 .3 1) (-16 -16 -16) (16 16 16) suspended
*/
	{
		"item_charge",
		"sound/misc/am_pkup.wav",
        { "models/powerups/instant/regen.md3",
		0, 0, 0 },
/* icon */		"icons/iconw_lightning",
/* pickup */	"Charge",
		0,
		IT_POWERUP,
		PW_CHARGE,
/* precache */ "",
/* sounds */ ""
	},

// JUHOX: shield powerup item definition
/*QUAKED item_shield (.3 .3 1) (-16 -16 -16) (16 16 16) suspended
*/
	{
		"item_shield",
		"sound/misc/am_pkup.wav",
        { "models/powerups/instant/regen.md3",
		0, 0, 0},
/* icon */		"icons/envirosuit",
/* pickup */	"Shield",
		0,
		IT_POWERUP,
		PW_SHIELD,
/* precache */ "",
/* sounds */ ""
	},

// JUHOX: small armor fragment item definition
/*QUAKED item_armor_smallfrag (.3 .3 1) (-16 -16 -16) (16 16 16) suspended
*/
	{
		"item_armor_smallfrag",
		"sound/misc/ar1_pkup.wav",
		{ "models/powerups/armor/shard.md3",
		0, 0, 0} ,
/* icon */		"icons/iconr_shard",
/* pickup */	"Armor Fragment 5",
		5,
		IT_ARMOR,
		1,	// special appearance
/* precache */ "",
/* sounds */ ""
	},

// JUHOX: large armor fragment item definition
/*QUAKED item_armor_largefrag (.3 .3 1) (-16 -16 -16) (16 16 16) suspended
*/
	{
		"item_armor_largefrag",
		"sound/misc/ar1_pkup.wav",
		{ "models/powerups/armor/shard.md3",
		0, 0, 0} ,
/* icon */		"icons/iconr_shard",
/* pickup */	"Armor Fragment 25",
		25,
		IT_ARMOR,
		1,	// special appearance
/* precache */ "",
/* sounds */ ""
	},

// JUHOX: POD (place of death) item definition
/*QUAKED item_pod (.3 .3 1) (-16 -16 -16) (16 16 16) suspended
*/
	{
		"item_pod",
		"sound/misc/ar1_pkup.wav",
		{ "models/players/bones/head.md3",
		0, 0, 0} ,
/* icon */		"sprites/deathlocation",
/* pickup */	"POD marker",
		0,
		IT_POD_MARKER,
		0,
/* precache */ "",
/* sounds */ ""
	},

// JUHOX: artefact item definition
/*QUAKED item_quad (.3 .3 1) (-16 -16 -16) (16 16 16) suspended
*/
	{
		"item_artefact",
		//"sound/items/quaddamage.wav",
		"sound/earthquake.wav",
        { "models/powerups/instant/quad.md3",
		0, 0, 0 },
/* icon */		"icons/artefact",
/* pickup */	"Artefact",
		1,
		IT_TEAM,
		PW_QUAD,
/* precache */ "",
/* sounds */ ""
	},

// JUHOX: monster launcher item definition
/*QUAKED weapon_monsterlauncher (.3 .3 1) (-16 -16 -16) (16 16 16) suspended
*/
	{
		"weapon_monsterlauncher",
		"sound/misc/w_pkup.wav",
        { "models/weapons2/grenadel/grenadel.md3",
		0, 0, 0},
/* icon */		"models/weapons2/monsterl/icon.tga",
/* pickup */	"Monster Launcher",
		10,
		IT_WEAPON,
		WP_MONSTER_LAUNCHER,
/* precache */ "",
/* sounds */ "sound/weapons/grenade/hgrenb1a.wav sound/weapons/grenade/hgrenb2a.wav"
	},

/*QUAKED ammo_seeds (.3 .3 1) (-16 -16 -16) (16 16 16) suspended
*/
	{
		"ammo_seeds",
		"sound/misc/am_pkup.wav",
        { "models/powerups/health/small_sphere.md3",
		0, 0, 0},
/* icon */		"models/weapons2/monsterl/icon.tga",
/* pickup */	"Monster Seeds",
		5,
		IT_AMMO,
		WP_MONSTER_LAUNCHER,
/* precache */ "",
/* sounds */ ""
	},

	// end of list marker
	{NULL}
};

int		bg_numItems = sizeof(bg_itemlist) / sizeof(bg_itemlist[0]) - 1;

// JUHOX: ammo characteristics
weaponAmmoCharacteristic_t weaponAmmoCharacteristics[] = {
	{0, 0},		//
	{WP_GAUNTLET_MAX_AMMO, WP_GAUNTLET_AMMO_REFRESH},
	{WP_MACHINEGUN_MAX_AMMO, WP_MACHINEGUN_AMMO_REFRESH},
	{WP_SHOTGUN_MAX_AMMO, WP_SHOTGUN_AMMO_REFRESH},
	{WP_GRENADE_LAUNCHER_MAX_AMMO, WP_GRENADE_LAUNCHER_AMMO_REFRESH},
	{WP_ROCKET_LAUNCHER_MAX_AMMO, WP_ROCKET_LAUNCHER_AMMO_REFRESH},
	{WP_LIGHTNING_MAX_AMMO, WP_LIGHTNING_AMMO_REFRESH},
	{WP_RAILGUN_MAX_AMMO, WP_RAILGUN_AMMO_REFRESH},
	{WP_PLASMAGUN_MAX_AMMO, WP_PLASMAGUN_AMMO_REFRESH},
	{WP_BFG_MAX_AMMO, WP_BFG_AMMO_REFRESH},
	{WP_GRAPPLING_HOOK_MAX_AMMO, WP_GRAPPLING_HOOK_AMMO_REFRESH},
	{WP_MONSTER_LAUNCHER_MAX_AMMO, WP_MONSTER_LAUNCHER_AMMO_REFRESH}
};


/*
==============
BG_FindItemForPowerup
==============
*/
gitem_t	*BG_FindItemForPowerup( powerup_t pw ) {
	int		i;

	for ( i = 0 ; i < bg_numItems ; i++ ) {
		if ( (bg_itemlist[i].giType == IT_POWERUP ||
					bg_itemlist[i].giType == IT_TEAM ||
					bg_itemlist[i].giType == IT_PERSISTANT_POWERUP) &&
			bg_itemlist[i].giTag == pw ) {
			return &bg_itemlist[i];
		}
	}

	return NULL;
}


/*
==============
BG_FindItemForHoldable
==============
*/
gitem_t	*BG_FindItemForHoldable( holdable_t pw ) {
	int		i;

	for ( i = 0 ; i < bg_numItems ; i++ ) {
		if ( bg_itemlist[i].giType == IT_HOLDABLE && bg_itemlist[i].giTag == pw ) {
			return &bg_itemlist[i];
		}
	}

	Com_Error( ERR_DROP, "HoldableItem not found" );

	return NULL;
}


/*
===============
BG_FindItemForWeapon

===============
*/
gitem_t	*BG_FindItemForWeapon( weapon_t weapon ) {
	gitem_t	*it;

	for ( it = bg_itemlist + 1 ; it->classname ; it++) {
		if ( it->giType == IT_WEAPON && it->giTag == weapon ) {
			return it;
		}
	}

	Com_Error( ERR_DROP, "Couldn't find item for weapon %i", weapon);
	return NULL;
}

/*
===============
BG_FindItem

===============
*/
gitem_t	*BG_FindItem( const char *pickupName ) {
	gitem_t	*it;

	for ( it = bg_itemlist + 1 ; it->classname ; it++ ) {
		if ( !Q_stricmp( it->pickup_name, pickupName ) )
			return it;
	}

	return NULL;
}

/*
============
BG_PlayerTouchesItem

Items can be picked up without actually touching their physical bounds to make
grabbing them easier
============
*/
qboolean	BG_PlayerTouchesItem( playerState_t *ps, entityState_t *item, int atTime ) {
	vec3_t		origin;

	BG_EvaluateTrajectory( &item->pos, atTime, origin );

	// we are ignoring ducked differences here
	if ( ps->origin[0] - origin[0] > 44
		|| ps->origin[0] - origin[0] < -50
		|| ps->origin[1] - origin[1] > 36
		|| ps->origin[1] - origin[1] < -36
		|| ps->origin[2] - origin[2] > 36
		|| ps->origin[2] - origin[2] < -36 ) {
		return qfalse;
	}

	return qtrue;
}



/*
================
BG_CanItemBeGrabbed

Returns false if the item should not be picked up.
This needs to be the same for client side prediction and server use.
================
*/
qboolean BG_CanItemBeGrabbed( int gametype, const entityState_t *ent, const playerState_t *ps ) {
	gitem_t	*item;

	if ( ent->modelindex < 1 || ent->modelindex >= bg_numItems ) {
		Com_Error( ERR_DROP, "BG_CanItemBeGrabbed: index out of range" );
	}

	if (ent->pos.trType != TR_STATIONARY) return qfalse;	// JUHOX

	item = &bg_itemlist[ent->modelindex];

	switch( item->giType ) {
	case IT_WEAPON:
		return qtrue;	// weapons are always picked up

	case IT_AMMO:
		if ( ps->ammo[ item->giTag ] >= 200 ) {
			return qfalse;		// can't hold any more
		}
		return qtrue;

	case IT_ARMOR:
		if ( ps->stats[STAT_ARMOR] >= ps->stats[STAT_MAX_HEALTH] * 2 ) {
			return qfalse;
		}
		return qtrue;

	case IT_HEALTH:
		if (ps->powerups[PW_CHARGE]) return qtrue;	// JUHOX: pick up all health if charged
		// small and mega healths will go over the max, otherwise
		// don't pick up if already at max
		if ( item->quantity == 5 || item->quantity == 100 ) {
			if ( ps->stats[STAT_HEALTH] >= ps->stats[STAT_MAX_HEALTH] * 2 ) {
				return qfalse;
			}
			return qtrue;
		}

		if ( ps->stats[STAT_HEALTH] >= ps->stats[STAT_MAX_HEALTH] ) {
			return qfalse;
		}
		return qtrue;

	case IT_POWERUP:
		return qtrue;	// powerups are always picked up

	case IT_TEAM: // team items, such as flags
		if( gametype == GT_CTF ) {
			// ent->modelindex2 is non-zero on items if they are dropped
			// we need to know this because we can pick up our dropped flag (and return it)
			// but we can't pick up our flag at base
			if (ps->persistant[PERS_TEAM] == TEAM_RED) {
				if (item->giTag == PW_BLUEFLAG ||
					(item->giTag == PW_REDFLAG && ent->modelindex2) ||
					(item->giTag == PW_REDFLAG && ps->powerups[PW_BLUEFLAG]) )
					return qtrue;
			} else if (ps->persistant[PERS_TEAM] == TEAM_BLUE) {
				if (item->giTag == PW_REDFLAG ||
					(item->giTag == PW_BLUEFLAG && ent->modelindex2) ||
					(item->giTag == PW_BLUEFLAG && ps->powerups[PW_REDFLAG]) )
					return qtrue;
			}
		}
        // JUHOX: pickup artefact in STU
		if (gametype == GT_STU) {
			if (item->giTag == PW_QUAD && ps->persistant[PERS_TEAM] == TEAM_RED) return qtrue;
		}


		return qfalse;

	case IT_HOLDABLE:
		// can only hold one item at a time
		if ( ps->stats[STAT_HOLDABLE_ITEM] ) {
			return qfalse;
		}
		return qtrue;

	// JUHOX: POD markers can never be grabbed
	case IT_POD_MARKER:
		return qfalse;

        case IT_BAD:
            Com_Error( ERR_DROP, "BG_CanItemBeGrabbed: IT_BAD" );
        default:
#ifndef Q3_VM
#ifndef NDEBUG // bk0001204
          Com_Printf("BG_CanItemBeGrabbed: unknown enum %d\n", item->giType );
#endif
#endif
         break;
	}

	return qfalse;
}

//======================================================================

/*
================
BG_EvaluateTrajectory

================
*/
void BG_EvaluateTrajectory( const trajectory_t *tr, int atTime, vec3_t result ) {
	float		deltaTime;
	float		phase;

	switch( tr->trType ) {
	case TR_STATIONARY:
	case TR_INTERPOLATE:
		VectorCopy( tr->trBase, result );
		break;
	case TR_LINEAR:
		deltaTime = ( atTime - tr->trTime ) * 0.001;	// milliseconds to seconds
		VectorMA( tr->trBase, deltaTime, tr->trDelta, result );
		break;
	case TR_SINE:
		deltaTime = ( atTime - tr->trTime ) / (float) tr->trDuration;
		phase = sin( deltaTime * M_PI * 2 );
		VectorMA( tr->trBase, phase, tr->trDelta, result );
		break;
	case TR_LINEAR_STOP:
		if ( atTime > tr->trTime + tr->trDuration ) {
			atTime = tr->trTime + tr->trDuration;
		}
		deltaTime = ( atTime - tr->trTime ) * 0.001;	// milliseconds to seconds
		if ( deltaTime < 0 ) {
			deltaTime = 0;
		}
		VectorMA( tr->trBase, deltaTime, tr->trDelta, result );
		break;
	case TR_GRAVITY:
		deltaTime = ( atTime - tr->trTime ) * 0.001;	// milliseconds to seconds
		VectorMA( tr->trBase, deltaTime, tr->trDelta, result );
		result[2] -= 0.5 * DEFAULT_GRAVITY * deltaTime * deltaTime;		// FIXME: local gravity...
		break;
	default:
		Com_Error( ERR_DROP, "BG_EvaluateTrajectory: unknown trType: %i", tr->trTime );
		break;
	}
}

/*
================
BG_EvaluateTrajectoryDelta

For determining velocity at a given time
================
*/
void BG_EvaluateTrajectoryDelta( const trajectory_t *tr, int atTime, vec3_t result ) {
	float	deltaTime;
	float	phase;

	switch( tr->trType ) {
	case TR_STATIONARY:
	case TR_INTERPOLATE:
		VectorClear( result );
		break;
	case TR_LINEAR:
		VectorCopy( tr->trDelta, result );
		break;
	case TR_SINE:
		deltaTime = ( atTime - tr->trTime ) / (float) tr->trDuration;
		phase = cos( deltaTime * M_PI * 2 );	// derivative of sin = cos
		phase *= 0.5;
		VectorScale( tr->trDelta, phase, result );
		break;
	case TR_LINEAR_STOP:
		if ( atTime > tr->trTime + tr->trDuration ) {
			VectorClear( result );
			return;
		}
		VectorCopy( tr->trDelta, result );
		break;
	case TR_GRAVITY:
		deltaTime = ( atTime - tr->trTime ) * 0.001;	// milliseconds to seconds
		VectorCopy( tr->trDelta, result );
		result[2] -= DEFAULT_GRAVITY * deltaTime;		// FIXME: local gravity...
		break;
	default:
		Com_Error( ERR_DROP, "BG_EvaluateTrajectoryDelta: unknown trType: %i", tr->trTime );
		break;
	}
}

char *eventnames[] = {
	"EV_NONE",

	"EV_FOOTSTEP",
	"EV_FOOTSTEP_METAL",
	"EV_FOOTSPLASH",
	"EV_FOOTWADE",
	"EV_SWIM",

	"EV_STEP_4",
	"EV_STEP_8",
	"EV_STEP_12",
	"EV_STEP_16",

	"EV_FALL_SHORT",
	"EV_FALL_MEDIUM",
	"EV_FALL_FAR",

	"EV_JUMP_PAD",			// boing sound at origin", jump sound on player

	"EV_JUMP",
	"EV_WATER_TOUCH",	    // foot touches
	"EV_WATER_LEAVE",	    // foot leaves
	"EV_WATER_UNDER",	    // head touches
	"EV_WATER_CLEAR",	    // head leaves

	"EV_ITEM_PICKUP",			// normal item pickups are predictable
	"EV_GLOBAL_ITEM_PICKUP",	// powerup / team sounds are broadcast to everyone

	"EV_NOAMMO",
	"EV_CHANGE_WEAPON",
	"EV_FIRE_WEAPON",

	"EV_USE_ITEM0",
	"EV_USE_ITEM1",
	"EV_USE_ITEM2",
	"EV_USE_ITEM3",
	"EV_USE_ITEM4",
	"EV_USE_ITEM5",
	"EV_USE_ITEM6",
	"EV_USE_ITEM7",
	"EV_USE_ITEM8",
	"EV_USE_ITEM9",
	"EV_USE_ITEM10",
	"EV_USE_ITEM11",
	"EV_USE_ITEM12",
	"EV_USE_ITEM13",
	"EV_USE_ITEM14",
	"EV_USE_ITEM15",

	"EV_ITEM_RESPAWN",
	"EV_ITEM_POP",
	"EV_PLAYER_TELEPORT_IN",
	"EV_PLAYER_TELEPORT_OUT",

	"EV_GRENADE_BOUNCE",		// eventParm will be the soundindex

	"EV_COCOON_BOUNCE",	// JUHOX


	"EV_GENERAL_SOUND",
	"EV_GLOBAL_SOUND",		// no attenuation
	"EV_GLOBAL_TEAM_SOUND",

	"EV_BULLET_HIT_FLESH",
	"EV_BULLET_HIT_WALL",

	"EV_MISSILE_HIT",
	"EV_MISSILE_MISS",
	"EV_MISSILE_MISS_METAL",
	"EV_RAILTRAIL",
	"EV_SHOTGUN",
	"EV_BULLET",				// otherEntity is the shooter

	"EV_PAIN",
	"EV_DEATH1",
	"EV_DEATH2",
	"EV_DEATH3",
	"EV_OBITUARY",

	"EV_POWERUP_QUAD",
	"EV_POWERUP_BATTLESUIT",
	"EV_POWERUP_REGEN",

	"EV_GIB_PLAYER",			// gib a previously living player
	"EV_SCOREPLUM",			// score plum

	"EV_PROXIMITY_MINE_STICK",
	"EV_PROXIMITY_MINE_TRIGGER",
	"EV_KAMIKAZE",			// kamikaze explodes
	"EV_OBELISKEXPLODE",		// obelisk explodes
	"EV_INVUL_IMPACT",		// invulnerability sphere impact
	"EV_JUICED",				// invulnerability juiced effect
	"EV_LIGHTNINGBOLT",		// lightning bolt bounced of invulnerability sphere

	"EV_DEBUG_LINE",
	"EV_STOPLOOPINGSOUND",
	"EV_TAUNT"

};

/*
===============
BG_AddPredictableEventToPlayerstate

Handles the sequence numbers
===============
*/

void	trap_Cvar_VariableStringBuffer( const char *var_name, char *buffer, int bufsize );

void BG_AddPredictableEventToPlayerstate( int newEvent, int eventParm, playerState_t *ps ) {

#ifdef _DEBUG
	{
		char buf[256];
		trap_Cvar_VariableStringBuffer("showevents", buf, sizeof(buf));
		if ( atof(buf) != 0 ) {
#ifdef QAGAME
			Com_Printf(" game event svt %5d -> %5d: num = %20s parm %d\n", ps->pmove_framecount/*ps->commandTime*/, ps->eventSequence, eventnames[newEvent], eventParm);
#else
			Com_Printf("Cgame event svt %5d -> %5d: num = %20s parm %d\n", ps->pmove_framecount/*ps->commandTime*/, ps->eventSequence, eventnames[newEvent], eventParm);
#endif
		}
	}
#endif
	ps->events[ps->eventSequence & (MAX_PS_EVENTS-1)] = newEvent;
	ps->eventParms[ps->eventSequence & (MAX_PS_EVENTS-1)] = eventParm;
	ps->eventSequence++;
	ps->externalEvent = 0;	// JUHOX BUGFIX
}

/*
========================
BG_TouchJumpPad
========================
*/
void BG_TouchJumpPad( playerState_t *ps, entityState_t *jumppad ) {
	vec3_t	angles;
	float p;
	int effectNum;

	// spectators don't use jump pads
	if ( ps->pm_type != PM_NORMAL ) {
		return;
	}

	// flying characters don't hit bounce pads
	if ( ps->powerups[PW_FLIGHT] ) {
		return;
	}

	// if we didn't hit this same jumppad the previous frame
	// then don't play the event sound again if we are in a fat trigger
	if ( ps->jumppad_ent != jumppad->number ) {

		vectoangles( jumppad->origin2, angles);
		p = fabs( AngleNormalize180( angles[PITCH] ) );
		if( p < 45 ) {
			effectNum = 0;
		} else {
			effectNum = 1;
		}
		BG_AddPredictableEventToPlayerstate( EV_JUMP_PAD, effectNum, ps );
	}
	// remember hitting this jumppad this frame
	ps->jumppad_ent = jumppad->number;
	ps->jumppad_frame = ps->pmove_framecount;
	// give the player the velocity from the jumppad
	VectorCopy( jumppad->origin2, ps->velocity );
}

/*
========================
BG_PlayerStateToEntityState

This is done after each set of usercmd_t on the server,
and after local prediction on the client
========================
*/
void BG_PlayerStateToEntityState( playerState_t *ps, entityState_t *s, qboolean snap ) {
	int		i;

	if ( ps->pm_type == PM_INTERMISSION || ps->pm_type == PM_SPECTATOR ) {
		s->eType = ET_INVISIBLE;
	} else if ( ps->stats[STAT_HEALTH] <= GIB_HEALTH ) {
		s->eType = ET_INVISIBLE;
	} else {
		s->eType = ET_PLAYER;
	}

	s->number = ps->clientNum;

	s->pos.trType = TR_INTERPOLATE;
	VectorCopy( ps->origin, s->pos.trBase );
	if ( snap ) {
		SnapVector( s->pos.trBase );
	}
	// set the trDelta for flag direction
	VectorCopy( ps->velocity, s->pos.trDelta );

	s->apos.trType = TR_INTERPOLATE;
	VectorCopy( ps->viewangles, s->apos.trBase );
	if ( snap ) {
		SnapVector( s->apos.trBase );
	}

	s->angles2[YAW] = ps->movementDir;
	s->legsAnim = ps->legsAnim;
	s->torsoAnim = ps->torsoAnim;
	s->clientNum = ps->clientNum;		// ET_PLAYER looks here instead of at number
										// so corpses can also reference the proper config
	s->eFlags = ps->eFlags;
	if ( ps->stats[STAT_HEALTH] <= 0 ) {
		s->eFlags |= EF_DEAD;
	} else {
		s->eFlags &= ~EF_DEAD;
	}
	// JUHOX: add EF_DUCKED flag
	if (ps->pm_flags & PMF_DUCKED) {
		s->eFlags |= EF_DUCKED;
	}


	if ( ps->externalEvent ) {
		s->event = ps->externalEvent;
		s->eventParm = ps->externalEventParm;
	} else if (ps->entityEventSequence < ps->eventSequence) {
		int		seq;

		if ( ps->entityEventSequence < ps->eventSequence - MAX_PS_EVENTS) {
			ps->entityEventSequence = ps->eventSequence - MAX_PS_EVENTS;
		}
		seq = ps->entityEventSequence & (MAX_PS_EVENTS-1);
		s->event = ps->events[ seq ] | ( ( ps->entityEventSequence & 3 ) << 8 );
		s->eventParm = ps->eventParms[ seq ];
		ps->entityEventSequence++;
	}

	s->weapon = ps->weapon;
	s->groundEntityNum = ps->groundEntityNum;

	s->powerups = 0;
	for ( i = 0 ; i < PW_NUM_POWERUPS ; i++ ) {	// JUHOX
		if ( ps->powerups[ i ] ) {
			s->powerups |= 1 << i;
		}
	}

	s->loopSound = ps->loopSound;
	s->generic1 = ps->generic1;
	s->time2 = ps->powerups[PW_CHARGE];	// JUHOX
	// JUHOX: map standard players' playerState_t to entityState_t

	if (ps->clientNum < MAX_CLIENTS)
	{
		s->otherEntityNum = ps->powerups[PW_TSSDATA1] & 255;
		s->otherEntityNum2 = ps->stats[STAT_TARGET];
	}

	// JUHOX NOTE: s->modelindex used for PFMI
	//s->modelindex2 = ps->stats[STAT_GRAPPLE_STATE];	// JUHOX
	s->modelindex2 = GET_STAT_GRAPPLESTATE(ps);

	//s->frame = ps->stats[STAT_EFFECT];	// JUHOX
	s->frame = GET_STAT_EFFECT(ps);         // SLK
	s->time = ps->powerups[PW_EFFECT_TIME];	// JUHOX
    // JUHOX: set corrected lighting origin for EFH
	s->origin[0] = ps->persistant[PERS_LIGHT_X];
	s->origin[1] = ps->persistant[PERS_LIGHT_Y];
	s->origin[2] = ps->persistant[PERS_LIGHT_Z];

}

/*
========================
BG_PlayerStateToEntityStateExtraPolate

This is done after each set of usercmd_t on the server,
and after local prediction on the client
========================
*/
void BG_PlayerStateToEntityStateExtraPolate( playerState_t *ps, entityState_t *s, int time, qboolean snap ) {
	int		i;

	if ( ps->pm_type == PM_INTERMISSION || ps->pm_type == PM_SPECTATOR ) {
		s->eType = ET_INVISIBLE;
	} else if ( ps->stats[STAT_HEALTH] <= GIB_HEALTH ) {
		s->eType = ET_INVISIBLE;
	} else {
		s->eType = ET_PLAYER;
	}

	s->number = ps->clientNum;

	s->pos.trType = TR_LINEAR_STOP;
	VectorCopy( ps->origin, s->pos.trBase );
	if ( snap ) {
		SnapVector( s->pos.trBase );
	}
	// set the trDelta for flag direction and linear prediction
	VectorCopy( ps->velocity, s->pos.trDelta );
	// set the time for linear prediction
	s->pos.trTime = time;
	// set maximum extra polation time
	s->pos.trDuration = 50; // 1000 / sv_fps (default = 20)

	s->apos.trType = TR_INTERPOLATE;
	VectorCopy( ps->viewangles, s->apos.trBase );
	if ( snap ) {
		SnapVector( s->apos.trBase );
	}

	s->angles2[YAW] = ps->movementDir;
	s->legsAnim = ps->legsAnim;
	s->torsoAnim = ps->torsoAnim;
	s->clientNum = ps->clientNum;		// ET_PLAYER looks here instead of at number
										// so corpses can also reference the proper config
	s->eFlags = ps->eFlags;
	if ( ps->stats[STAT_HEALTH] <= 0 ) {
		s->eFlags |= EF_DEAD;
	} else {
		s->eFlags &= ~EF_DEAD;
	}

	if ( ps->externalEvent ) {
		s->event = ps->externalEvent;
		s->eventParm = ps->externalEventParm;
	} else if (ps->entityEventSequence < ps->eventSequence) {
		int		seq;

		if ( ps->entityEventSequence < ps->eventSequence - MAX_PS_EVENTS) {
			ps->entityEventSequence = ps->eventSequence - MAX_PS_EVENTS;
		}
		seq = ps->entityEventSequence & (MAX_PS_EVENTS-1);
		s->event = ps->events[ seq ] | ( ( ps->entityEventSequence & 3 ) << 8 );
		s->eventParm = ps->eventParms[ seq ];
		ps->entityEventSequence++;
	}

	s->weapon = ps->weapon;
	s->groundEntityNum = ps->groundEntityNum;

	s->powerups = 0;
	for ( i = 0 ; i < /*MAX_POWERUPS*/PW_NUM_POWERUPS ; i++ ) {	// JUHOX
		if ( ps->powerups[ i ] ) {
			s->powerups |= 1 << i;
		}
	}

	s->loopSound = ps->loopSound;
	s->generic1 = ps->generic1;
	s->time2 = ps->powerups[PW_CHARGE];	// JUHOX
	// JUHOX: map standard players' playerState_t to entityState_t
	if (ps->clientNum < MAX_CLIENTS)
	{
		s->otherEntityNum = ps->powerups[PW_TSSDATA1] & 255;
		s->otherEntityNum2 = ps->stats[STAT_TARGET];
	}

	// JUHOX NOTE: s->modelindex used for PFMI
	//s->modelindex2 = ps->stats[STAT_GRAPPLE_STATE];	// JUHOX
	s->modelindex2 = GET_STAT_GRAPPLESTATE (ps);
	//s->frame = ps->stats[STAT_EFFECT];	// JUHOX
	s->frame = GET_STAT_EFFECT(ps); // SLK
	s->time = ps->powerups[PW_EFFECT_TIME];	// JUHOX
	// JUHOX: set corrected lighting origin for EFH
	s->origin[0] = ps->persistant[PERS_LIGHT_X];
	s->origin[1] = ps->persistant[PERS_LIGHT_Y];
	s->origin[2] = ps->persistant[PERS_LIGHT_Z];

}

/*
=================
JUHOX: BG_TSS_Proportion
=================
*/
int BG_TSS_Proportion(int portion, int total, int newTotal) {
	if (total == 0) return 0;
	return (portion * newTotal + (total>>1)) / total;
}

/*
=================
JUHOX: BG_TSS_TakeProportionAway
=================
*/
int BG_TSS_TakeProportionAway(int portion, int* totalLeft, int* newTotalLeft) {
	int newPortion;

	newPortion = BG_TSS_Proportion(portion, *totalLeft, *newTotalLeft);
	*totalLeft -= portion;
	*newTotalLeft -= newPortion;
	return newPortion;
}

/*
=================
JUHOX: BG_TSS_AssignPlayers
=================
*/
void BG_TSS_AssignPlayers(
	int playersToAssign,				// quantity		(input)
	int (*groupSizes)[MAX_GROUPS],		// percentage	(input)
	int unassignedPlayers,				// percentage	(input)
	int (*assignments)[MAX_GROUPS]		// quantity		(output)
) {
	// integer version (all floats have been multiplied by 'playersToAssign'
	int remainingSize[MAX_GROUPS];
	int remainingUnassigned;
	const int percentPerPlayer = 100;
	int i;

	memset(assignments, 0, sizeof(*assignments));

	for (i = 0; i < MAX_GROUPS; i++) remainingSize[i] = (*groupSizes)[i] * playersToAssign;
	remainingUnassigned = unassignedPlayers * playersToAssign;

	for (i = 0; i < playersToAssign; i++) {
		int gr;
		int highestRemainingSize;
		int mostNeedingGroup;

		highestRemainingSize = remainingUnassigned;
		mostNeedingGroup = -1;
		for (gr = 0; gr < MAX_GROUPS; gr++) {
			if (remainingSize[gr] > highestRemainingSize) {
				mostNeedingGroup = gr;
				highestRemainingSize = remainingSize[gr];
			}
		}

		if (mostNeedingGroup < 0) {
			remainingUnassigned -= percentPerPlayer;
		}
		else {
			(*assignments)[mostNeedingGroup]++;
			remainingSize[mostNeedingGroup] -= percentPerPlayer;
		}
	}
}


/*
========================
JUHOX: TSS_CodeNibble
========================
*/
int TSS_CodeNibble(int n) {
	static char codes[64] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+-";

	n &= 63;
	return codes[n];
}

/*
========================
JUHOX: TSS_DecodeNibble
========================
*/
int TSS_DecodeNibble(int n) {
	n &= 255;

	if (n >= 'A' && n <= 'Z') return n - 'A';
	if (n >= 'a' && n <= 'z') return n - 'a' + 26;
	if (n >= '0' && n <= '9') return n - '0' + 52;
	if (n == '+') return 62;
	if (n == '-') return 63;
	return 0;
}

/*
========================
JUHOX: TSS_CodeInt
========================
*/
void TSS_CodeInt(int n, char** buf) {
	n += 2048;
	*((*buf)++) = TSS_CodeNibble(n);
	*((*buf)++) = TSS_CodeNibble(n >> 6);
}

/*
========================
JUHOX: TSS_DecodeInt
========================
*/
int TSS_DecodeInt(const char** buf, int minimum, int maximum) {
	int n;

	n = -2048;
	n += TSS_DecodeNibble(*((*buf)++));
	n += TSS_DecodeNibble(*((*buf)++)) << 6;
	if (n < minimum) n = minimum;
	if (n > maximum) n = maximum;
	return n;
}

/*
========================
JUHOX: BG_TSS_CodeInstructions
========================
*/
void BG_TSS_CodeInstructions(const tss_instructions_t* instr, char** buf) {
	int i;

	TSS_CodeInt(instr->division.unassignedPlayers, buf);

	for (i = 0; i < MAX_GROUPS; i++) {
		TSS_CodeInt(instr->groupOrganization[i], buf);
		TSS_CodeInt(instr->division.group[i].minTotalMembers, buf);
		TSS_CodeInt(instr->division.group[i].minAliveMembers, buf);
		TSS_CodeInt(instr->division.group[i].minReadyMembers, buf);
		TSS_CodeInt(instr->orders.order[i].mission, buf);
		TSS_CodeInt(instr->orders.order[i].maxDanger, buf);
		TSS_CodeInt(instr->orders.order[i].minReady, buf);
		TSS_CodeInt(instr->orders.order[i].minGroupSize, buf);
		TSS_CodeInt(instr->orders.order[i].maxGuards, buf);
	}
}

/*
========================
JUHOX: BG_TSS_DecodeInstructions
========================
*/
void BG_TSS_DecodeInstructions(const char** buf, tss_instructions_t* instr) {
	int i;

	instr->division.unassignedPlayers = TSS_DecodeInt(buf, 0, 100);

	for (i = 0; i < MAX_GROUPS; i++) {
		instr->groupOrganization[i] = TSS_DecodeInt(buf, 0, MAX_GROUPS-1);
		instr->division.group[i].minTotalMembers = TSS_DecodeInt(buf, 0, 100);
		instr->division.group[i].minAliveMembers = TSS_DecodeInt(buf, 0, 100);
		instr->division.group[i].minReadyMembers = TSS_DecodeInt(buf, 0, 100);
		instr->orders.order[i].mission = TSS_DecodeInt(buf, 0, TSSMISSION_num_missions-1);
		instr->orders.order[i].maxDanger = TSS_DecodeInt(buf, -100, 100);
		instr->orders.order[i].minReady = TSS_DecodeInt(buf, 0, 100);
		instr->orders.order[i].minGroupSize = TSS_DecodeInt(buf, 0, 100);
		instr->orders.order[i].maxGuards = TSS_DecodeInt(buf, 0, 100);
	}
}

/*
========================
JUHOX: BG_TSS_CodeLeadership
========================
*/
void BG_TSS_CodeLeadership(
	const int* leaders1,
	const int* leaders2,
	const int* leaders3,
	const int* teamMateIndexToClientNum,
	char** buf
) {
	int i;

	for (i = 0; i < MAX_GROUPS; i++) {
		int n;

		n = leaders1[i];
		if (n >= 0) n = teamMateIndexToClientNum[n];
		TSS_CodeInt(n, buf);
		n = leaders2[i];
		if (n >= 0) n = teamMateIndexToClientNum[n];
		TSS_CodeInt(n, buf);
		n = leaders3[i];
		if (n >= 0) n = teamMateIndexToClientNum[n];
		TSS_CodeInt(n, buf);
	}
}

/*
========================
JUHOX: BG_TSS_DecodeLeadership
========================
*/
void BG_TSS_DecodeLeadership(
	const char** buf,
	int* leaders1,
	int* leaders2,
	int* leaders3
) {
	int i;

	for (i = 0; i < MAX_GROUPS; i++) {
		leaders1[i] = TSS_DecodeInt(buf, -1, MAX_CLIENTS-1);
		leaders2[i] = TSS_DecodeInt(buf, -1, MAX_CLIENTS-1);
		leaders3[i] = TSS_DecodeInt(buf, -1, MAX_CLIENTS-1);
	}
}

// JUHOX: tss player info bit field definitions
#define TSSPI_isValid_size				1
#define TSSPI_group_size				4
#define TSSPI_groupMemberStatus_size	3
#define TSSPI_mission_size				3
#define TSSPI_missionStatus_size		1
#define TSSPI_task_size					4
#define TSSPI_groupFormation_size		2
#define TSSPI_groupSize_size			4
#define TSSPI_membersAlive_size			4
#define TSSPI_membersReady_size			4
#define TSSPI_hyperspace_size			1
#define TSSPI_navAid_size				1
// ----------------------------------- 32 bits used

#define TSSPI_isValid_start				0
#define TSSPI_group_start				(TSSPI_isValid_start+TSSPI_isValid_size)
#define TSSPI_groupMemberStatus_start	(TSSPI_group_start+TSSPI_group_size)
#define TSSPI_mission_start				(TSSPI_groupMemberStatus_start+TSSPI_groupMemberStatus_size)
#define TSSPI_missionStatus_start		(TSSPI_mission_start+TSSPI_mission_size)
#define TSSPI_task_start				(TSSPI_missionStatus_start+TSSPI_missionStatus_size)
#define TSSPI_groupFormation_start		(TSSPI_task_start+TSSPI_task_size)
#define TSSPI_groupSize_start			(TSSPI_groupFormation_start+TSSPI_groupFormation_size)
#define TSSPI_membersAlive_start		(TSSPI_groupSize_start+TSSPI_groupSize_size)
#define TSSPI_membersReady_start		(TSSPI_membersAlive_start+TSSPI_membersAlive_size)
#define TSSPI_hyperspace_start			(TSSPI_membersReady_start+TSSPI_membersReady_size)
#define TSSPI_navAid_start				(TSSPI_hyperspace_start+TSSPI_hyperspace_size)
#define TSSPI_FIELD2 TSSPI_groupLeader

#define TSSPI_groupLeader_size			6
#define TSSPI_taskGoal_size				6
#define TSSPI_suggestedGF_size			2
// ----------------------------------- 14 bits used

#define TSSPI_groupLeader_start			0
#define TSSPI_taskGoal_start			(TSSPI_groupLeader_start+TSSPI_groupLeader_size)
#define TSSPI_suggestedGF_start			(TSSPI_taskGoal_start+TSSPI_taskGoal_size)


static const int tssPlayerInfoBitStart[] = {
	TSSPI_isValid_start,
	TSSPI_group_start,
	TSSPI_groupMemberStatus_start,
	TSSPI_mission_start,
	TSSPI_missionStatus_start,
	TSSPI_task_start,
	TSSPI_groupFormation_start,
	TSSPI_groupSize_start,
	TSSPI_membersAlive_start,
	TSSPI_membersReady_start,
	TSSPI_hyperspace_start,
	TSSPI_navAid_start,
	TSSPI_groupLeader_start,
	TSSPI_taskGoal_start,
	TSSPI_suggestedGF_start
};
static const int tssPlayerInfoBitSize[] = {
	TSSPI_isValid_size,
	TSSPI_group_size,
	TSSPI_groupMemberStatus_size,
	TSSPI_mission_size,
	TSSPI_missionStatus_size,
	TSSPI_task_size,
	TSSPI_groupFormation_size,
	TSSPI_groupSize_size,
	TSSPI_membersAlive_size,
	TSSPI_membersReady_size,
	TSSPI_hyperspace_size,
	TSSPI_navAid_size,
	TSSPI_groupLeader_size,
	TSSPI_taskGoal_size,
	TSSPI_suggestedGF_size
};

/*
========================
JUHOX: BG_TSS_SetPlayerInfo
========================
*/
void BG_TSS_SetPlayerInfo(playerState_t* ps, tss_playerInfo_t pi, int data) {
	int mask;
	int field;

	field = PW_TSSDATA1;
	if (pi >= TSSPI_FIELD2) field = PW_TSSDATA2;

	mask = (1 << tssPlayerInfoBitSize[pi]) - 1;
	if (data < 0) {
		data = 0;
	}
	else if (data > mask) {
		data = mask;
	}
	mask <<= tssPlayerInfoBitStart[pi];
	data <<= tssPlayerInfoBitStart[pi];
	ps->powerups[field] &= ~mask;
	ps->powerups[field] |= data;
}

/*
========================
JUHOX: BG_TSS_GetPlayerInfo
========================
*/
int BG_TSS_GetPlayerInfo(const playerState_t* ps, tss_playerInfo_t pi) {
	int mask;
	int field;

	field = PW_TSSDATA1;
	if (pi >= TSSPI_FIELD2) field = PW_TSSDATA2;

	mask = (1 << tssPlayerInfoBitSize[pi]) - 1;
	return (ps->powerups[field] >> tssPlayerInfoBitStart[pi]) & mask;
}

/*
========================
JUHOX: BG_TSS_GetPlayerEntityInfo

NOTE: this function also depends on code in
	'BG_PlayerStateToEntityState()' and 'BG_PlayerStateToEntityStateExtraPolate()'
========================
*/
int BG_TSS_GetPlayerEntityInfo(const entityState_t* es, tss_playerInfo_t pi) {
	int mask;

	if (es->clientNum >= MAX_CLIENTS) return 0;	// no TSS for monsters
	mask = (1 << tssPlayerInfoBitSize[pi]) - 1;
	return (es->otherEntityNum >> tssPlayerInfoBitStart[pi]) & mask;
}

/*
==================
JUHOX: ParseGameTemplateIntKey
==================
*/
static templateKeyStatus_t ParseGameTemplateIntKey(const char* info, const char* key, int* value) {
	const char* v;

	v = Info_ValueForKey(info, key);
	switch (v[0]) {
	case 'd':
	case 'D':
		*value = atoi(&v[1]);
		return TKS_defaultValue;
	case 'f':
	case 'F':
		*value = atoi(&v[1]);
		return TKS_fixedValue;
	default:
		return TKS_missing;
	}
}

/*
==================
JUHOX: BG_ParseGameTemplate
==================
*/
qboolean BG_ParseGameTemplate(const char* info, gametemplate_t* gt) {
	const char* v;

	memset(gt, 0, sizeof(*gt));

	// parse the mandatory keys

	v = Info_ValueForKey(info, "name");
	if (!v[0]) return qfalse;
	Q_strncpyz(gt->templateName, v, sizeof(gt->templateName));

	v = Info_ValueForKey(info, "gt");
	if (!v[0]) return qfalse;
	gt->gametype = atoi(v);
	switch (gt->gametype) {
	case GT_FFA:
	case GT_TOURNAMENT:
	case GT_TEAM:
	case GT_CTF:
	case GT_STU:
	case GT_EFH:
		break;
	default:
		return qfalse;
	}

	// parse the optional keys

	v = Info_ValueForKey(info, "map");

	Q_strncpyz(gt->mapName, v, sizeof(gt->mapName));

	v = Info_ValueForKey(info, "mip");
	gt->minplayers = atoi(v);
	gt->tksMinplayers = v[0]? TKS_fixedValue : TKS_missing;

	v = Info_ValueForKey(info, "mp");
	gt->maxplayers = atoi(v);
	gt->tksMaxplayers = v[0]? TKS_fixedValue : TKS_missing;

	v = Info_ValueForKey(info, "ht");
	gt->highscoretype = atoi(v);
	gt->tksHighscoretype = v[0]? TKS_fixedValue : TKS_missing;

	v = Info_ValueForKey(info, "hn");
	Q_strncpyz(gt->highscorename, v, sizeof(gt->highscorename));
	gt->tksHighscorename = v[0]? TKS_fixedValue : TKS_missing;

	gt->tksBasehealth = ParseGameTemplateIntKey(info, "bh", &gt->basehealth);

	gt->tksFraglimit = ParseGameTemplateIntKey(info, "fl", &gt->fraglimit);

	gt->tksTimelimit = ParseGameTemplateIntKey(info, "tl", &gt->timelimit);

	gt->tksDistancelimit = ParseGameTemplateIntKey(info, "dl", &gt->distancelimit);

	gt->tksArtefacts = ParseGameTemplateIntKey(info, "art", &gt->artefacts);

	gt->tksRespawndelay = ParseGameTemplateIntKey(info, "rd", &gt->respawndelay);

	gt->tksGameseed = ParseGameTemplateIntKey(info, "gs", &gt->gameseed);

	gt->tksFriendlyfire = ParseGameTemplateIntKey(info, "ff", &gt->friendlyfire);

	gt->tksChallengingEnv = ParseGameTemplateIntKey(info, "che", &gt->challengingEnv);

	gt->tksScoremode = ParseGameTemplateIntKey(info, "sm", &gt->scoremode);

	gt->tksMonsterlauncher = ParseGameTemplateIntKey(info, "ml", &gt->monsterLauncher);

	gt->tksMonsterload = ParseGameTemplateIntKey(info, "mlo", &gt->monsterLoad);

	gt->tksMinmonsters = ParseGameTemplateIntKey(info, "mim", &gt->minmonsters);

	gt->tksMaxmonsters = ParseGameTemplateIntKey(info, "mam", &gt->maxmonsters);

	gt->tksMonsterspertrap = ParseGameTemplateIntKey(info, "mpt", &gt->monsterspertrap);

	gt->tksMonsterspawndelay = ParseGameTemplateIntKey(info, "msd", &gt->monsterspawndelay);

	gt->tksMonsterhealthscale = ParseGameTemplateIntKey(info, "mhs", &gt->monsterhealthscale);

	gt->tksMonsterprogessivehealth = ParseGameTemplateIntKey(info, "mph", &gt->monsterprogressivehealth);

	gt->tksMonsterbreeding = ParseGameTemplateIntKey(info, "mbr", &gt->monsterbreeding);

	gt->tksGuards = ParseGameTemplateIntKey(info, "mg", &gt->guards);

	gt->tksTitans = ParseGameTemplateIntKey(info, "mt", &gt->titans);

	gt->tksStamina = ParseGameTemplateIntKey(info, "st", &gt->stamina);

	gt->tksNoitems = ParseGameTemplateIntKey(info, "ni", &gt->noitems);

	gt->tksNohealthregen = ParseGameTemplateIntKey(info, "nhr", &gt->nohealthregen);

	gt->tksCloakingdevice = ParseGameTemplateIntKey(info, "cd", &gt->cloakingdevice);

	gt->tksUnlimitedammo = ParseGameTemplateIntKey(info, "ua", &gt->unlimitedammo);

	gt->tksArmorfragments = ParseGameTemplateIntKey(info, "af", &gt->armorfragments);

	gt->tksLightningdamagelimit = ParseGameTemplateIntKey(info, "ldl", &gt->lightningdamagelimit);

	gt->tksGrapple = ParseGameTemplateIntKey(info, "gh", &gt->grapple);

	gt->tksDmflags = ParseGameTemplateIntKey(info, "dmf", &gt->dmflags);

	gt->tksSpeed = ParseGameTemplateIntKey(info, "spd", &gt->speed);

	gt->tksKnockback = ParseGameTemplateIntKey(info, "kb", &gt->knockback);

	gt->tksGravity = ParseGameTemplateIntKey(info, "grv", &gt->gravity);

	return qtrue;
}

/*
=================
JUHOX: CompareTemplateNames
=================
*/
static int CompareTemplateNames(const void* a, const void* b) {
	return Q_stricmp(((const templatelistentry_t*)a)->name, ((const templatelistentry_t*)b)->name);
}

/*
==================
JUHOX: AddGameTemplates
==================
*/
void trap_Cvar_Register(vmCvar_t *vmCvar, const char *varName, const char *defaultValue, int flags);
static void AddGameTemplates(gametemplatelist_t* list, const char* varStem, qboolean deletable) {
	int i;

	for (i = 0; i < MAX_GAMETEMPLATES; i++) {
		char name[64];
		char buf[MAX_INFO_STRING];
		char* v;
		int nameSize, varSize, size;
		int cvarFlags;

		Com_sprintf(name, sizeof(name), "%s%03d", varStem, i);
		trap_Cvar_VariableStringBuffer(name, buf, sizeof(buf));
		if (!buf[0]) continue;

		if (deletable) {
			cvarFlags = CVAR_ARCHIVE | CVAR_NORESTART;
		}
		else {
			cvarFlags = CVAR_ROM | CVAR_NORESTART;
		}
		trap_Cvar_Register(NULL, name, "", cvarFlags);

		if (!Info_Validate(buf)) continue;
		v = Info_ValueForKey(buf, "name");
		if (!v[0]) continue;

		nameSize = strlen(v) + 1;
		varSize = strlen(name) + 1;
		size = nameSize + varSize;
		if (&list->bufPos[size] - list->buffer > sizeof(list->buffer)) return;

		strcpy(list->bufPos, v);
		list->entries[list->numEntries].name = list->bufPos;
		list->bufPos += nameSize;

		strcpy(list->bufPos, name);
		list->entries[list->numEntries].cvar = list->bufPos;
		list->bufPos += varSize;

		list->entries[list->numEntries].originalIndex = list->numEntries;

		list->entries[list->numEntries].deletable = deletable;

		list->numEntries++;
		if (list->numEntries >= MAX_GAMETEMPLATES) return;
	}
}

/*
==================
JUHOX: BG_GetGameTemplateList
==================
*/
void BG_GetGameTemplateList(gametemplatelist_t* list, int numFiles, const char* fileList, qboolean sorted) {
	int i;

	memset(list, 0, sizeof(*list));
	list->bufPos = list->buffer;

	if (fileList) {
		AddGameTemplates(list, "saved", qtrue);

		for (i = 0; i < numFiles; i++) {
			char stem[64];
			int n;

			n = strlen(fileList) + 1;
			if (n > 6 && n < sizeof(stem)) {
				strcpy(stem, fileList);
				stem[n - 6] = 0;	// remove ".tmpl"
				AddGameTemplates(list, stem, qfalse);
			}
			fileList += n;
		}
	}
	else {
		AddGameTemplates(list, "svtmpl", qfalse);
	}

	if (sorted) {
		qsort(
			list->entries, list->numEntries,
			sizeof(templatelistentry_t), CompareTemplateNames
		);
	}
}

/*
==================
JUHOX: IncrementalChecksum
==================
*/
static unsigned long checkSeed[4];
static unsigned long IncrementalChecksum(int value) {
	unsigned long r;

	r = 0x23f49524;

	r += 0xddc4911b * (value ^ 0xc562b907);

	r += 0xa5229bdf * (checkSeed[0] ^ 0x4ded7fe6);
	checkSeed[0] = checkSeed[1];

	r += 0xc3636bed * (checkSeed[1] ^ 0xc277a38a);
	checkSeed[1] = checkSeed[2];

	r += 0xdf90dc7b * (checkSeed[2] ^ 0x6899659e);
	checkSeed[2] = checkSeed[3];

	r += 0x05d36a93 * (checkSeed[3] ^ 0x28f234bf);
	r = (r << 1) | (r >> 31);
	checkSeed[3] = r;

	return r;
}

/*
==================
JUHOX: AddStringToChecksum
==================
*/
static unsigned long AddStringToChecksum(const char* s) {
	while (*s) {
		IncrementalChecksum(*s);
		s++;
	}
	return IncrementalChecksum(0);
}

/*
==================
JUHOX: BG_TemplateChecksum
==================
*/
long BG_TemplateChecksum(const char* name, int highscoreType, const char* highscore, const char* highscoreDescriptor) {
	checkSeed[0] = 0;
	checkSeed[1] = 0;
	checkSeed[2] = 0;
	checkSeed[3] = 0;

	AddStringToChecksum(name);
	IncrementalChecksum(highscoreType);
	AddStringToChecksum(highscore);
	AddStringToChecksum(highscoreDescriptor);
	return (long) IncrementalChecksum(-1);
}

/*
==================
JUHOX: BG_ChecksumChar
==================
*/
static const char checksumchar[64] =
	"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	"abcdefghijklmnopqrstuvwxyz"
	"0123456789+-";
char BG_ChecksumChar(long checksum) {
	return checksumchar[checksum & 63];
}

/*
==================
JUHOX: BG_VectorChecksum
==================
*/
unsigned long BG_VectorChecksum(const vec3_t v) {
	union {
		long i;
		float f;
	} converter;

	checkSeed[0] = 0;
	checkSeed[1] = 0;
	checkSeed[2] = 0;
	checkSeed[3] = 0;

	converter.f = v[0];
	IncrementalChecksum(converter.i);

	converter.f = v[1];
	IncrementalChecksum(converter.i);

	converter.f = v[2];
	return IncrementalChecksum(converter.i);
}

/*
================
JUHOX: LocallySeededRandom
================
*/
unsigned long LocallySeededRandom(localseed_t* seed) {
	unsigned long r;

	r = 0xa7418bd3;

	r += 0xfd889ce1 * (seed->seed0 ^ 0xb82cee9f);
	seed->seed0 = seed->seed1;

	r += 0x806b133f * (seed->seed1 ^ 0x094b69e7);
	seed->seed1 = seed->seed2;

	r += 0xd89b1c0b * (seed->seed2 ^ 0x53fecc69);
	seed->seed2 = seed->seed3;

	r += 0xec5660c5 * (seed->seed3 ^ 0x7af29614);
	r = (r << 1) | (r >> 31);
	seed->seed3 = r;

	return r;
}

/*
================
JUHOX: DeriveLocalSeed
================
*/
void DeriveLocalSeed(localseed_t* source, localseed_t* destination) {
	destination->seed3 = LocallySeededRandom(source) + 0x7fa4bce1;
	destination->seed2 = LocallySeededRandom(source) + 0x298a02b6;
	destination->seed1 = LocallySeededRandom(source) + 0x1c86de05;
	destination->seed0 = LocallySeededRandom(source) + 0xd9ca631b;
}

/*
================
JUHOX: local_random
================
*/
float local_random(localseed_t* seed) {
	return LocallySeededRandom(seed) / 4294967295.0;
}

/*
================
JUHOX: local_crandom
================
*/
float local_crandom(localseed_t* seed) {
	return LocallySeededRandom(seed) / 2147483647.5 - 1.0;
}

/*
================
JUHOX: BG_PlayerTargetOffset

pos: 0.0 = hips, 1.0 = eye
================
*/
float BG_PlayerTargetOffset(const entityState_t* state, float pos) {
	float offset;

	if (state->eType != ET_PLAYER) return 0;

	offset = DEFAULT_VIEWHEIGHT;
	if (state->eFlags & EF_DUCKED) {
		offset = CROUCH_VIEWHEIGHT;
	}
	offset *= pos;

	switch (state->clientNum) {
	case CLIENTNUM_MONSTER_PREDATOR:
	case CLIENTNUM_MONSTER_PREDATOR_RED:
	case CLIENTNUM_MONSTER_PREDATOR_BLUE:
		if (state->modelindex & PFMI_HIBERNATION_MORPHED) {
			offset = 0;
		}
		break;
	case CLIENTNUM_MONSTER_GUARD:
		offset *= MONSTER_GUARD_SCALE;
		break;
	case CLIENTNUM_MONSTER_TITAN:
		offset *= MONSTER_TITAN_SCALE;
		break;
	}

	return offset;
}
