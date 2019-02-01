// Copyright (C) 1999-2000 Id Software, Inc.
//
/*
=============================================================================

START SERVER MENU *****

=============================================================================
*/

#include "ui_local.h"

#define GAMESERVER_BACK0		"menu/art/back_0"
#define GAMESERVER_BACK1		"menu/art/back_1"
#define GAMESERVER_NEXT0		"menu/art/next_0"
#define GAMESERVER_NEXT1		"menu/art/next_1"
#define GAMESERVER_SELECT		"menu/art/maps_select"
#define GAMESERVER_SELECTED		"menu/art/maps_selected"
#define GAMESERVER_FIGHT0		"menu/art/fight_0"
#define GAMESERVER_FIGHT1		"menu/art/fight_1"
#define GAMESERVER_UNKNOWNMAP	"menu/art/unknownmap"
#define GAMESERVER_ARROWS		"menu/art/gs_arrows_0"
#define GAMESERVER_ARROWSL		"menu/art/gs_arrows_l"
#define GAMESERVER_ARROWSR		"menu/art/gs_arrows_r"

#define MAX_MAPROWS		2
#define MAX_MAPCOLS		4
#define MAX_MAPSPERPAGE 8

#define	MAX_SERVERSTEXT	8192

#define MAX_SERVERMAPS	256	// JUHOX: was 64
#define MAX_NAMELENGTH	16

#define ID_GAMETYPE				10
#define ID_PICTURES				11
#define ID_PREVPAGE				15
#define ID_NEXTPAGE				16
#define ID_STARTSERVERBACK		17
#define ID_STARTSERVERNEXT		18

typedef struct {
	menuframework_s	menu;

	menutext_s		banner;

	int				gametype;     // JUHOX: game type selection menu instead of spin control
	menutext_s		gametitle;
	char			gamename[32];

	menubitmap_s	mappics[MAX_MAPSPERPAGE];
	menubitmap_s	mapbuttons[MAX_MAPSPERPAGE];
	menubitmap_s	arrows;
	menubitmap_s	prevpage;
	menubitmap_s	nextpage;
	menubitmap_s	back;
	menubitmap_s	next;

	menutext_s		mapname;
	menubitmap_s	item_null;

	qboolean		multiplayer;
	int				currentmap;
	int				nummaps;
	int				page;
	int				maxpages;
	char			maplist[MAX_SERVERMAPS][MAX_NAMELENGTH];
	int				mapGamebits[MAX_SERVERMAPS];

	char			choosenmap[MAX_NAMELENGTH];		// JUHOX: original name
	char			choosenmapname[MAX_NAMELENGTH];	// JUHOX: upper case name
} startserver_t;

static startserver_t s_startserver;
static int initialGameType;	// JUHOX

static const char* gametype_names[] = {
	"Free For All",
	"Tournament",
	"",	// single player
	"Team Deathmatch",
	"Capture the Flag",
	"",	// 1FCTF
	"",	// Obelisk
	"",	// Harvester
	"Save the Universe",
	"Escape From Hell"
};

static void UI_ServerOptionsMenu( qboolean multiplayer );

// JUHOX: template variables
gametemplate_t gtmpl;



/*
=================
JUHOX: ClearTemplate
=================
*/
static void ClearTemplate(void) {
	memset(&gtmpl, 0, sizeof(gtmpl));
	trap_Cvar_Set("g_template", "");
}

/*
=================
GametypeBits
=================
*/
static int GametypeBits( char *string ) {
	int		bits;
	char	*p;
	char	*token;

	bits = 0;
	p = string;
	while( 1 ) {
		token = COM_ParseExt( &p, qfalse );
		if( token[0] == 0 ) {
			break;
		}

		if( Q_stricmp( token, "ffa" ) == 0 ) {
			bits |= 1 << GT_FFA;
            // JUHOX: accept ffa maps for other gametypes too
			bits |= 1 << GT_TOURNAMENT;
			bits |= 1 << GT_TEAM;
			bits |= 1 << GT_STU;
			continue;
		}

		if( Q_stricmp( token, "tourney" ) == 0 ) {
			bits |= 1 << GT_TOURNAMENT;
            // JUHOX: accept tourney maps for other gametypes too
			bits |= 1 << GT_FFA;
			bits |= 1 << GT_TEAM;
			bits |= 1 << GT_STU;
			continue;
		}

		if( Q_stricmp( token, "single" ) == 0 ) {
			bits |= 1 << GT_SINGLE_PLAYER;
			continue;
		}

		if( Q_stricmp( token, "team" ) == 0 ) {
			bits |= 1 << GT_TEAM;
            // JUHOX: accept tdm maps for other gametypes too
			bits |= 1 << GT_FFA;
			bits |= 1 << GT_TOURNAMENT;
			bits |= 1 << GT_STU;
			continue;
		}

		if( Q_stricmp( token, "ctf" ) == 0 ) {
			bits |= 1 << GT_CTF;
            // JUHOX: accept ctf maps for other gametypes too
			bits |= 1 << GT_FFA;
			bits |= 1 << GT_TOURNAMENT;
			bits |= 1 << GT_TEAM;
			bits |= 1 << GT_STU;
			continue;
		}
        // JUHOX: check for STU map
		if (Q_stricmp(token, "stu") == 0) {
			bits |= 1 << GT_STU;
			continue;
		}

        // JUHOX: check for EFH map
		if (Q_stricmp(token, "efh") == 0) {
			bits |= 1 << GT_EFH;
			continue;
		}
	}

	return bits;
}


/*
=================
StartServer_Update
=================
*/
static void StartServer_Update( void ) {
	int				i;
	int				top;
	static	char	picname[MAX_MAPSPERPAGE][64];

	top = s_startserver.page*MAX_MAPSPERPAGE;

	for (i=0; i<MAX_MAPSPERPAGE; i++)
	{
		if (top+i >= s_startserver.nummaps)
			break;

		Com_sprintf( picname[i], sizeof(picname[i]), "levelshots/%s", s_startserver.maplist[top+i] );

		s_startserver.mappics[i].generic.flags &= ~QMF_HIGHLIGHT;
		s_startserver.mappics[i].generic.name   = picname[i];
		s_startserver.mappics[i].shader         = 0;

		// reset
		s_startserver.mapbuttons[i].generic.flags |= QMF_PULSEIFFOCUS;
		s_startserver.mapbuttons[i].generic.flags &= ~QMF_INACTIVE;
	}

	for (; i<MAX_MAPSPERPAGE; i++)
	{
		s_startserver.mappics[i].generic.flags &= ~QMF_HIGHLIGHT;
		s_startserver.mappics[i].generic.name   = NULL;
		s_startserver.mappics[i].shader         = 0;

		// disable
		s_startserver.mapbuttons[i].generic.flags &= ~QMF_PULSEIFFOCUS;
		s_startserver.mapbuttons[i].generic.flags |= QMF_INACTIVE;
	}


	// no servers to start
	if( !s_startserver.nummaps ) {
		s_startserver.next.generic.flags |= QMF_INACTIVE;

		// set the map name
		strcpy( s_startserver.mapname.string, "NO MAPS FOUND" );
	}
	else {
		// set the highlight
		s_startserver.next.generic.flags &= ~QMF_INACTIVE;
		i = s_startserver.currentmap - top;
		if ( i >=0 && i < MAX_MAPSPERPAGE )
		{
			s_startserver.mappics[i].generic.flags    |= QMF_HIGHLIGHT;
			s_startserver.mapbuttons[i].generic.flags &= ~QMF_PULSEIFFOCUS;
		}

		// set the map name
		strcpy( s_startserver.mapname.string, s_startserver.maplist[s_startserver.currentmap] );
	}

	Q_strupr( s_startserver.mapname.string );
}


/*
=================
StartServer_MapEvent
=================
*/
static void StartServer_MapEvent( void* ptr, int event ) {
	if( event != QM_ACTIVATED) {
		return;
	}

	s_startserver.currentmap = (s_startserver.page*MAX_MAPSPERPAGE) + (((menucommon_s*)ptr)->id - ID_PICTURES);
	StartServer_Update();
}


/*
=================
StartServer_GametypeEvent
=================
*/
static void StartServer_GametypeEvent( void* ptr, int event ) {
	int			i;
	int			count;
	int			gamebits;
	int			matchbits;
	const char	*info;

	if( event != QM_ACTIVATED) {
		return;
	}

	count = UI_GetNumArenas();
	s_startserver.nummaps = 0;

	matchbits = 1 << s_startserver.gametype;
	if(s_startserver.gametype == GT_FFA) matchbits |= (1 << GT_SINGLE_PLAYER);

	for( i = 0; i < count; i++ ) {
		info = UI_GetArenaInfoByNumber( i );

		gamebits = GametypeBits( Info_ValueForKey( info, "type") );
		if( !( gamebits & matchbits ) ) {
			continue;
		}

		Q_strncpyz( s_startserver.maplist[s_startserver.nummaps], Info_ValueForKey( info, "map"), MAX_NAMELENGTH );
		Q_strupr( s_startserver.maplist[s_startserver.nummaps] );
		s_startserver.mapGamebits[s_startserver.nummaps] = gamebits;
		s_startserver.nummaps++;
	}
	s_startserver.maxpages = (s_startserver.nummaps + MAX_MAPSPERPAGE-1)/MAX_MAPSPERPAGE;
	s_startserver.page = 0;
	s_startserver.currentmap = 0;

	StartServer_Update();
}


/*
=================
StartServer_MenuEvent
=================
*/
static void StartServer_MenuEvent( void* ptr, int event ) {
	if( event != QM_ACTIVATED ) {
		return;
	}

	switch( ((menucommon_s*)ptr)->id ) {
	case ID_PREVPAGE:
		if( s_startserver.page > 0 ) {
			s_startserver.page--;
			StartServer_Update();
		}
		break;

	case ID_NEXTPAGE:
		if( s_startserver.page < s_startserver.maxpages - 1 ) {
			s_startserver.page++;
			StartServer_Update();
		}
		break;

	case ID_STARTSERVERNEXT:
		ClearTemplate();	// JUHOX
		Q_strncpyz(s_startserver.choosenmap, s_startserver.maplist[s_startserver.currentmap], sizeof(s_startserver.choosenmap));	// JUHOX
		Q_strncpyz(s_startserver.choosenmapname, s_startserver.mapname.string, sizeof(s_startserver.choosenmapname));	// JUHOX

		trap_Cvar_SetValue("g_gameType", s_startserver.gametype);

		UI_ServerOptionsMenu( s_startserver.multiplayer );
		break;

	case ID_STARTSERVERBACK:
		UI_PopMenu();
		break;
	}
}


/*
===============
StartServer_LevelshotDraw
===============
*/
static void StartServer_LevelshotDraw( void *self ) {
	menubitmap_s	*b;
	int				x;
	int				y;
	int				w;
	int				h;
	int				n;

	b = (menubitmap_s *)self;

	if( !b->generic.name ) {
		return;
	}

	if( b->generic.name && !b->shader ) {
		b->shader = trap_R_RegisterShaderNoMip( b->generic.name );
		if( !b->shader && b->errorpic ) {
			b->shader = trap_R_RegisterShaderNoMip( b->errorpic );
		}
	}

	if( b->focuspic && !b->focusshader ) {
		b->focusshader = trap_R_RegisterShaderNoMip( b->focuspic );
	}

	x = b->generic.x;
	y = b->generic.y;
	w = b->width;
	h =	b->height;
	if( b->shader ) {
		UI_DrawHandlePic( x, y, w, h, b->shader );
	}

	x = b->generic.x;
	y = b->generic.y + b->height;
	UI_FillRect( x, y, b->width, 28, colorBlack );

	x += b->width / 2;
	y += 4;
	n = s_startserver.page * MAX_MAPSPERPAGE + b->generic.id - ID_PICTURES;
	UI_DrawString( x, y, s_startserver.maplist[n], UI_CENTER|UI_SMALLFONT, color_orange );

	x = b->generic.x;
	y = b->generic.y;
	w = b->width;
	h =	b->height + 28;
	if( b->generic.flags & QMF_HIGHLIGHT ) {
		UI_DrawHandlePic( x, y, w, h, b->focusshader );
	}
}


/*
=================
StartServer_MenuInit
=================
*/
static void StartServer_MenuInit( void ) {
	int	i;
	int	x;
	int	y;
	static char mapnamebuffer[64];

	// zero set all our globals
	memset( &s_startserver, 0 ,sizeof(startserver_t) );
	ClearTemplate();	// JUHOX
	s_startserver.gametype = initialGameType;	// JUHOX

	StartServer_Cache();

	s_startserver.menu.wrapAround = qtrue;
	s_startserver.menu.fullscreen = qtrue;

	s_startserver.banner.generic.type  = MTYPE_BTEXT;
	s_startserver.banner.generic.x	   = 320;
	s_startserver.banner.generic.y	   = 16;
	s_startserver.banner.string        = "GAME SERVER";
	s_startserver.banner.color         = color_white;
	s_startserver.banner.style         = UI_CENTER;

	// JUHOX: add game title
	Q_strncpyz(s_startserver.gamename, gametype_names[s_startserver.gametype], sizeof(s_startserver.gamename));
	s_startserver.gametitle.generic.type	= MTYPE_PTEXT;
	s_startserver.gametitle.generic.x		= 320;
	s_startserver.gametitle.generic.y		= 57;
	s_startserver.gametitle.string			= s_startserver.gamename;
	s_startserver.gametitle.color			= colorWhite;
	s_startserver.gametitle.style			= UI_CENTER;
	Menu_AddItem(&s_startserver.menu, &s_startserver.gametitle);

	for (i=0; i<MAX_MAPSPERPAGE; i++)
	{

		x = (i % MAX_MAPCOLS) * (128+8) + 320 - (64+4)*MAX_MAPCOLS + 4;
		y = (i / MAX_MAPCOLS) * (128+8) + 96;	// JUHOX BUGFIX: MAX_MAPROWS is wrong!

		s_startserver.mappics[i].generic.type   = MTYPE_BITMAP;
		s_startserver.mappics[i].generic.flags  = QMF_LEFT_JUSTIFY|QMF_INACTIVE;
		s_startserver.mappics[i].generic.x	    = x;
		s_startserver.mappics[i].generic.y	    = y;
		s_startserver.mappics[i].generic.id		= ID_PICTURES+i;
		s_startserver.mappics[i].width  		= 128;
		s_startserver.mappics[i].height  	    = 96;
		s_startserver.mappics[i].focuspic       = GAMESERVER_SELECTED;
		s_startserver.mappics[i].errorpic       = GAMESERVER_UNKNOWNMAP;
		s_startserver.mappics[i].generic.ownerdraw = StartServer_LevelshotDraw;

		s_startserver.mapbuttons[i].generic.type     = MTYPE_BITMAP;
		s_startserver.mapbuttons[i].generic.flags    = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_NODEFAULTINIT;
		s_startserver.mapbuttons[i].generic.id       = ID_PICTURES+i;
		s_startserver.mapbuttons[i].generic.callback = StartServer_MapEvent;
		s_startserver.mapbuttons[i].generic.x	     = x - 30;
		s_startserver.mapbuttons[i].generic.y	     = y - 32;
		s_startserver.mapbuttons[i].width  		     = 256;
		s_startserver.mapbuttons[i].height  	     = 248;
		s_startserver.mapbuttons[i].generic.left     = x;
		s_startserver.mapbuttons[i].generic.top  	 = y;
		s_startserver.mapbuttons[i].generic.right    = x + 128;
		s_startserver.mapbuttons[i].generic.bottom   = y + 128;
		s_startserver.mapbuttons[i].focuspic         = GAMESERVER_SELECT;
	}

	s_startserver.arrows.generic.type  = MTYPE_BITMAP;
	s_startserver.arrows.generic.name  = GAMESERVER_ARROWS;
	s_startserver.arrows.generic.flags = QMF_INACTIVE;
	s_startserver.arrows.generic.x	   = 260;
	s_startserver.arrows.generic.y	   = 400;
	s_startserver.arrows.width  	   = 128;
	s_startserver.arrows.height  	   = 32;

	s_startserver.prevpage.generic.type	    = MTYPE_BITMAP;
	s_startserver.prevpage.generic.flags    = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
	s_startserver.prevpage.generic.callback = StartServer_MenuEvent;
	s_startserver.prevpage.generic.id	    = ID_PREVPAGE;
	s_startserver.prevpage.generic.x		= 260;
	s_startserver.prevpage.generic.y		= 400;
	s_startserver.prevpage.width  		    = 64;
	s_startserver.prevpage.height  		    = 32;
	s_startserver.prevpage.focuspic         = GAMESERVER_ARROWSL;

	s_startserver.nextpage.generic.type	    = MTYPE_BITMAP;
	s_startserver.nextpage.generic.flags    = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
	s_startserver.nextpage.generic.callback = StartServer_MenuEvent;
	s_startserver.nextpage.generic.id	    = ID_NEXTPAGE;
	s_startserver.nextpage.generic.x		= 321;
	s_startserver.nextpage.generic.y		= 400;
	s_startserver.nextpage.width  		    = 64;
	s_startserver.nextpage.height  		    = 32;
	s_startserver.nextpage.focuspic         = GAMESERVER_ARROWSR;

	s_startserver.mapname.generic.type  = MTYPE_PTEXT;
	s_startserver.mapname.generic.flags = QMF_CENTER_JUSTIFY|QMF_INACTIVE;
	s_startserver.mapname.generic.x	    = 320;
	s_startserver.mapname.generic.y	    = 440;
	s_startserver.mapname.string        = mapnamebuffer;
	s_startserver.mapname.style         = UI_CENTER|UI_BIGFONT;
	s_startserver.mapname.color         = text_color_normal;

	s_startserver.back.generic.type	    = MTYPE_BITMAP;
	s_startserver.back.generic.name     = GAMESERVER_BACK0;
	s_startserver.back.generic.flags    = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
	s_startserver.back.generic.callback = StartServer_MenuEvent;
	s_startserver.back.generic.id	    = ID_STARTSERVERBACK;
	s_startserver.back.generic.x		= 0;
	s_startserver.back.generic.y		= 480-64;
	s_startserver.back.width  		    = 128;
	s_startserver.back.height  		    = 64;
	s_startserver.back.focuspic         = GAMESERVER_BACK1;

	s_startserver.next.generic.type	    = MTYPE_BITMAP;
	s_startserver.next.generic.name     = GAMESERVER_NEXT0;
	s_startserver.next.generic.flags    = QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
	s_startserver.next.generic.callback = StartServer_MenuEvent;
	s_startserver.next.generic.id	    = ID_STARTSERVERNEXT;
	s_startserver.next.generic.x		= 640;
	s_startserver.next.generic.y		= 480-64;
	s_startserver.next.width  		    = 128;
	s_startserver.next.height  		    = 64;
	s_startserver.next.focuspic         = GAMESERVER_NEXT1;

	s_startserver.item_null.generic.type	= MTYPE_BITMAP;
	s_startserver.item_null.generic.flags	= QMF_LEFT_JUSTIFY|QMF_MOUSEONLY|QMF_SILENT;
	s_startserver.item_null.generic.x		= 0;
	s_startserver.item_null.generic.y		= 0;
	s_startserver.item_null.width			= 640;
	s_startserver.item_null.height			= 480;

	Menu_AddItem( &s_startserver.menu, &s_startserver.banner );

	for (i=0; i<MAX_MAPSPERPAGE; i++)
	{
		Menu_AddItem( &s_startserver.menu, &s_startserver.mappics[i] );
		Menu_AddItem( &s_startserver.menu, &s_startserver.mapbuttons[i] );
	}

	Menu_AddItem( &s_startserver.menu, &s_startserver.arrows );
	Menu_AddItem( &s_startserver.menu, &s_startserver.prevpage );
	Menu_AddItem( &s_startserver.menu, &s_startserver.nextpage );
	Menu_AddItem( &s_startserver.menu, &s_startserver.back );
	Menu_AddItem( &s_startserver.menu, &s_startserver.next );
	Menu_AddItem( &s_startserver.menu, &s_startserver.mapname );
	Menu_AddItem( &s_startserver.menu, &s_startserver.item_null );

	StartServer_GametypeEvent( NULL, QM_ACTIVATED );
}


/*
=================
StartServer_Cache
=================
*/
void StartServer_Cache( void )
{
	int				i;
	const char		*info;
	qboolean		precache;
	char			picname[64];

	trap_R_RegisterShaderNoMip( GAMESERVER_BACK0 );
	trap_R_RegisterShaderNoMip( GAMESERVER_BACK1 );
	trap_R_RegisterShaderNoMip( GAMESERVER_NEXT0 );
	trap_R_RegisterShaderNoMip( GAMESERVER_NEXT1 );

	precache = trap_Cvar_VariableValue("com_buildscript");
	// JUHOX: precaching
	precache |= (int) trap_Cvar_VariableValue("ui_precache");

	s_startserver.nummaps = UI_GetNumArenas();

	for( i = 0; i < s_startserver.nummaps; i++ ) {
		info = UI_GetArenaInfoByNumber( i );

		Q_strncpyz( s_startserver.maplist[i], Info_ValueForKey( info, "map"), MAX_NAMELENGTH );
		Q_strupr( s_startserver.maplist[i] );
		s_startserver.mapGamebits[i] = GametypeBits( Info_ValueForKey( info, "type") );

		if( precache ) {
			Com_sprintf( picname, sizeof(picname), "levelshots/%s", s_startserver.maplist[i] );
			trap_R_RegisterShaderNoMip(picname);
		}
	}

	s_startserver.maxpages = (s_startserver.nummaps + MAX_MAPSPERPAGE-1)/MAX_MAPSPERPAGE;
}


/*
=================
UI_StartServerMenu
=================
*/
void UI_StartServerMenu( qboolean multiplayer ) {
	StartServer_MenuInit();
	s_startserver.multiplayer = multiplayer;
	UI_PushMenu( &s_startserver.menu );
}



/*
=============================================================================

SERVER OPTIONS MENU *****

=============================================================================
*/

#define ID_PLAYER_TYPE			20
#define ID_MAXCLIENTS			21
#define ID_DEDICATED			22
#define ID_GO					23
#define ID_BACK					24

#define PLAYER_SLOTS			12


typedef struct {
	menuframework_s		menu;

	menutext_s			banner;

	menubitmap_s		mappic;
	menubitmap_s		picframe;

	menulist_s			dedicated;
	menufield_s			timelimit;
	menufield_s			fraglimit;
	menufield_s			flaglimit;
	// JUHOX: artefacts menu field definition
	menufield_s			artefacts;
	// JUHOX: distanceLimit menu field definition
	menufield_s			distanceLimit;
	menuradiobutton_s	friendlyfire;
	menutext_s			advOptions;	// JUHOX
	int					respawnDelay;	// JUHOX
	qboolean			respawnAtPOD;
	qboolean			tss;	// JUHOX
	qboolean			tssSafetyMode;	// JUHOX
	qboolean			armorFragments;	// JUHOX
	qboolean			stamina;	// JUHOX
	int					baseHealth;	// JUHOX
	int					lightningDamageLimit;	// JUHOX
	qboolean			grapple;	// JUHOX
	qboolean			noItems;	// JUHOX
	qboolean			noHealthRegen;	// JUHOX
	qboolean			unlimitedAmmo;	// JUHOX
	qboolean			cloakingDevice;	// JUHOX
	int					weaponLimit;	// JUHOX
	// JUHOX: server variable definitions for STU
	qboolean			monsterLauncher;
	int					minMonsters;
	int					maxMonsters;
	int					maxMonstersPerPlayer;
	int					monstersPerTrap;
	int					monsterSpawnDelay;
	int					monsterGuards;
	int					monsterTitans;
	int					monsterHealthScale;
	int					monsterProgression;
	qboolean			monsterBreeding;
	char				monsterModel1[32];
	char				monsterModel2[32];
	char				monsterModel3[32];
	qboolean			skipEndSequence;
	int					scoreMode;

	// JUHOX: server variable definitions for EFH
	int					monsterLoad;
	qboolean			challengingEnv;

	menufield_s			hostname;
	menuradiobutton_s	pure;
	menulist_s			botSkill;
	menufield_s			additionalSlots;	// JUHOX
	menufield_s			gameseed;			// JUHOX
#if MEETING
	menuradiobutton_s	meeting;			// JUHOX
#endif

	menutext_s			player0;
	menulist_s			playerType[PLAYER_SLOTS];
	menutext_s			playerName[PLAYER_SLOTS];
	menulist_s			playerTeam[PLAYER_SLOTS];

	menubitmap_s		go;
	menubitmap_s		next;
	menubitmap_s		back;

	qboolean			multiplayer;
	int					gametype;
	char				mapnamebuffer[32];
	char				playerNameBuffers[PLAYER_SLOTS][16];

	qboolean			newBot;
	int					newBotIndex;
	char				newBotName[16];

} serveroptions_t;

static serveroptions_t s_serveroptions;

static const char *dedicated_list[] = {
	"No",
	"LAN",
	"Internet",
	0
};

static const char *playerType_list[] = {
	"Open",
	"Bot",
	"----",
	0
};

static const char *playerTeam_list[] = {
	"Blue",
	"Red",
	0
};

static const char *botSkill_list[] = {
	"I Can Win",
	"Bring It On",
	"Hurt Me Plenty",
	"Hardcore",
	"Nightmare!",
	0
};


/*
=================
BotAlreadySelected
=================
*/
static qboolean BotAlreadySelected( const char *checkName ) {
	int		n;

	for( n = 1; n < PLAYER_SLOTS; n++ ) {
		if( s_serveroptions.playerType[n].curvalue != 1 ) {
			continue;
		}
		if( (s_serveroptions.gametype >= GT_TEAM) &&
			(s_serveroptions.playerTeam[n].curvalue != s_serveroptions.playerTeam[s_serveroptions.newBotIndex].curvalue ) ) {
			continue;
		}
		if( Q_stricmp( checkName, s_serveroptions.playerNameBuffers[n] ) == 0 ) {
			return qtrue;
		}
	}

	return qfalse;
}


/*
=================
ServerOptions_Start
=================
*/
static void ServerOptions_Start( void ) {
	int		timelimit;
	int		fraglimit;
	int		respawndelay;	// JUHOX
	int		respawnAtPOD;	// JUHOX
	int		tss;			// JUHOX
	int		tssSafetyMode;	// JUHOX
	int		armorFragments;	// JUHOX
	int		maxclients;
	int		dedicated;
	int		friendlyfire;
	int		flaglimit;
	int		pure;
	int		skill;
	int		additionalSlots;	// JUHOX
	int		gameseed;			// JUHOX
#if MEETING
	int		meeting;			// JUHOX
#endif
	int		noItems;			// JUHOX
	int		noHealthRegen;		// JUHOX
	int		unlimitedAmmo;		// JUHOX
	int		cloakingDevice;		// JUHOX
	int		weaponLimit;		// JUHOX

	qboolean monsterLauncher;	// JUHOX
	int		maxMonsters;		// JUHOX
	int		maxMonstersPP;		// JUHOX
	int		minMonsters;		// JUHOX
	int		monsterHealth;		// JUHOX
	char*	monsterModel1;		// JUHOX
	char*	monsterModel2;		// JUHOX
	char*	monsterModel3;		// JUHOX

	int		n;
	char	buf[64];


	timelimit	 = atoi( s_serveroptions.timelimit.field.buffer );
	fraglimit	 = atoi( s_serveroptions.fraglimit.field.buffer );
	flaglimit	 = atoi( s_serveroptions.flaglimit.field.buffer );
	respawndelay = s_serveroptions.respawnDelay;	// JUHOX
	respawnAtPOD = s_serveroptions.respawnAtPOD;	// JUHOX
	tss			 = s_serveroptions.tss;	// JUHOX
	tssSafetyMode = s_serveroptions.tssSafetyMode;	// JUHOX
	armorFragments = s_serveroptions.armorFragments;	// JUHOX
	dedicated	 = s_serveroptions.dedicated.curvalue;
	friendlyfire = s_serveroptions.friendlyfire.curvalue;
	pure		 = s_serveroptions.pure.curvalue;
	skill		 = s_serveroptions.botSkill.curvalue + 1;
	additionalSlots = atoi(s_serveroptions.additionalSlots.field.buffer);	// JUHOX
	gameseed = atoi(s_serveroptions.gameseed.field.buffer) & 0xffff;	// JUHOX
#if MEETING
	meeting = s_serveroptions.meeting.curvalue;	// JUHOX
#endif
	noItems = s_serveroptions.noItems;	// JUHOX
	noHealthRegen = s_serveroptions.noHealthRegen;	// JUHOX
	unlimitedAmmo = s_serveroptions.unlimitedAmmo;	// JUHOX
	cloakingDevice = s_serveroptions.cloakingDevice;	// JUHOX
	weaponLimit = s_serveroptions.weaponLimit;	// JUHOX
	monsterLauncher = Com_Clamp(0, 1, s_serveroptions.monsterLauncher);	// JUHOX
	maxMonstersPP = Com_Clamp(1, MAX_MONSTERS, s_serveroptions.maxMonstersPerPlayer);	// JUHOX
	maxMonsters = Com_Clamp(1, MAX_MONSTERS, s_serveroptions.maxMonsters);	// JUHOX
	minMonsters = Com_Clamp(0, MAX_MONSTERS, s_serveroptions.minMonsters);	// JUHOX
	monsterHealth = Com_Clamp(1, 1000, s_serveroptions.monsterHealthScale);	// JUHOX
	monsterModel1 = s_serveroptions.monsterModel1;	// JUHOX
	monsterModel2 = s_serveroptions.monsterModel2;	// JUHOX
	monsterModel3 = s_serveroptions.monsterModel3;	// JUHOX

	//set maxclients
	for( n = 0, maxclients = 0; n < PLAYER_SLOTS; n++ ) {
		if( s_serveroptions.playerType[n].curvalue == 2 ) {
			continue;
		}
		if( (s_serveroptions.playerType[n].curvalue == 1) && (s_serveroptions.playerNameBuffers[n][0] == 0) ) {
			continue;
		}
		maxclients++;
	}
	maxclients += additionalSlots;	// JUHOX

	switch( s_serveroptions.gametype ) {
	case GT_FFA:
	default:
		trap_Cvar_SetValue( "ui_ffa_fraglimit", fraglimit );
		trap_Cvar_SetValue( "ui_ffa_timelimit", timelimit );
		trap_Cvar_SetValue("ui_ffa_respawndelay", respawndelay);	// JUHOX
		trap_Cvar_SetValue("ui_ffa_gameseed", gameseed);	// JUHOX
		tss = qfalse;
		trap_Cvar_SetValue("ui_ffa_noItems", noItems);	// JUHOX
		trap_Cvar_SetValue("ui_ffa_noHealthRegen", noHealthRegen);	// JUHOX
		trap_Cvar_SetValue("ui_ffa_unlimitedAmmo", unlimitedAmmo);	// JUHOX
		trap_Cvar_SetValue("ui_ffa_cloakingDevice", cloakingDevice);	// JUHOX
		trap_Cvar_SetValue("ui_ffa_weaponLimit", weaponLimit);	// JUHOX
		trap_Cvar_SetValue("ui_ffa_monsterLauncher", monsterLauncher);	// JUHOX
		trap_Cvar_SetValue("ui_ffa_maxMonsters", maxMonsters);	// JUHOX
		trap_Cvar_SetValue("ui_ffa_maxMonstersPP", maxMonstersPP);	// JUHOX
		trap_Cvar_SetValue("ui_ffa_monsterHealthScale", monsterHealth);	// JUHOX
#if MEETING
		trap_Cvar_SetValue("ui_ffa_meeting", meeting);	// JUHOX
#endif
		break;

	case GT_TOURNAMENT:
		trap_Cvar_SetValue( "ui_tourney_fraglimit", fraglimit );
		trap_Cvar_SetValue( "ui_tourney_timelimit", timelimit );
		respawndelay = 0;	// JUHOX
		trap_Cvar_SetValue("ui_tourney_gameseed", gameseed);	// JUHOX
		tss = qfalse;
		trap_Cvar_SetValue("ui_tourney_noItems", noItems);	// JUHOX
		trap_Cvar_SetValue("ui_tourney_noHealthRegen", noHealthRegen);	// JUHOX
		trap_Cvar_SetValue("ui_tourney_unlimitedAmmo", unlimitedAmmo);	// JUHOX
		trap_Cvar_SetValue("ui_tourney_cloakingDevice", cloakingDevice);	// JUHOX
		trap_Cvar_SetValue("ui_tourney_weaponLimit", weaponLimit);	// JUHOX
		trap_Cvar_SetValue("ui_tourney_monsterLauncher", monsterLauncher);	// JUHOX
		trap_Cvar_SetValue("ui_tourney_maxMonsters", maxMonsters);	// JUHOX
		trap_Cvar_SetValue("ui_tourney_maxMonstersPP", maxMonstersPP);	// JUHOX
		trap_Cvar_SetValue("ui_tourney_monsterHealthScale", monsterHealth);	// JUHOX
#if MEETING
		trap_Cvar_SetValue("ui_tourney_meeting", meeting);	// JUHOX
#endif
		break;

	case GT_TEAM:
		trap_Cvar_SetValue( "ui_team_fraglimit", fraglimit );
		trap_Cvar_SetValue( "ui_team_timelimit", timelimit );
		trap_Cvar_SetValue( "ui_team_friendly", friendlyfire );	// JUHOX BUGFIX: was "ui_team_friendlt"
		trap_Cvar_SetValue("ui_team_respawndelay", respawndelay);	// JUHOX
		trap_Cvar_SetValue("ui_team_gameseed", gameseed);	// JUHOX
		trap_Cvar_SetValue("ui_team_tss", tss);	// JUHOX
		trap_Cvar_SetValue("ui_team_noItems", noItems);	// JUHOX
		trap_Cvar_SetValue("ui_team_noHealthRegen", noHealthRegen);	// JUHOX
		trap_Cvar_SetValue("ui_team_unlimitedAmmo", unlimitedAmmo);	// JUHOX
		trap_Cvar_SetValue("ui_team_cloakingDevice", cloakingDevice);	// JUHOX
		trap_Cvar_SetValue("ui_team_weaponLimit", weaponLimit);	// JUHOX
		trap_Cvar_SetValue("ui_team_monsterLauncher", monsterLauncher);	// JUHOX
		trap_Cvar_SetValue("ui_team_maxMonsters", maxMonsters);	// JUHOX
		trap_Cvar_SetValue("ui_team_maxMonstersPP", maxMonstersPP);	// JUHOX
		trap_Cvar_SetValue("ui_team_monsterHealthScale", monsterHealth);	// JUHOX
#if MEETING
		trap_Cvar_SetValue("ui_team_meeting", meeting);	// JUHOX
#endif
		break;

	case GT_CTF:
		trap_Cvar_SetValue( "ui_ctf_capturelimit", flaglimit );	// JUHOX BUGFIX: was "ui_ctf_fraglimit" and 'fraglimit'
		trap_Cvar_SetValue( "ui_ctf_timelimit", timelimit );
		trap_Cvar_SetValue( "ui_ctf_friendly", friendlyfire );	// JUHOX BUGFIX: was "ui_ctf_friendlt"
		trap_Cvar_SetValue("ui_ctf_respawndelay", respawndelay);	// JUHOX
		trap_Cvar_SetValue("ui_ctf_gameseed", gameseed);	// JUHOX
		trap_Cvar_SetValue("ui_ctf_tss", tss);	// JUHOX
		trap_Cvar_SetValue("ui_ctf_noItems", noItems);	// JUHOX
		trap_Cvar_SetValue("ui_ctf_noHealthRegen", noHealthRegen);	// JUHOX
		trap_Cvar_SetValue("ui_ctf_unlimitedAmmo", unlimitedAmmo);	// JUHOX
		trap_Cvar_SetValue("ui_ctf_cloakingDevice", cloakingDevice);	// JUHOX
		trap_Cvar_SetValue("ui_ctf_weaponLimit", weaponLimit);	// JUHOX
		trap_Cvar_SetValue("ui_ctf_monsterLauncher", monsterLauncher);	// JUHOX
		trap_Cvar_SetValue("ui_ctf_maxMonsters", maxMonsters);	// JUHOX
		trap_Cvar_SetValue("ui_ctf_maxMonstersPP", maxMonstersPP);	// JUHOX
		trap_Cvar_SetValue("ui_ctf_monsterHealthScale", monsterHealth);	// JUHOX
#if MEETING
		trap_Cvar_SetValue("ui_ctf_meeting", meeting);	// JUHOX
#endif
		break;

	// JUHOX: set STU ui cvars
	case GT_STU:
		trap_Cvar_SetValue("ui_stu_fraglimit", fraglimit);
		trap_Cvar_SetValue("ui_stu_timelimit", timelimit);
		trap_Cvar_SetValue("ui_stu_friendly", friendlyfire);
		trap_Cvar_SetValue("ui_stu_respawndelay", respawndelay);
		trap_Cvar_SetValue("ui_stu_gameseed", gameseed);
		//trap_Cvar_SetValue("ui_stu_tss", tss);
		tss = qfalse;
		monsterLauncher = qfalse;
		trap_Cvar_SetValue("ui_stu_noItems", noItems);
		trap_Cvar_SetValue("ui_stu_noHealthRegen", noHealthRegen);
		trap_Cvar_SetValue("ui_stu_unlimitedAmmo", unlimitedAmmo);
		trap_Cvar_SetValue("ui_stu_cloakingDevice", cloakingDevice);
		trap_Cvar_SetValue("ui_stu_weaponLimit", weaponLimit);

		trap_Cvar_SetValue("ui_stu_maxMonsters", maxMonsters);

		trap_Cvar_SetValue("ui_stu_minMonsters", minMonsters);
		trap_Cvar_SetValue("g_minMonsters", minMonsters);

		trap_Cvar_SetValue("ui_stu_monstersPerTrap", Com_Clamp(0, MAX_MONSTERS, s_serveroptions.monstersPerTrap));
		trap_Cvar_SetValue("g_monstersPerTrap", Com_Clamp(0, MAX_MONSTERS, s_serveroptions.monstersPerTrap));

		trap_Cvar_SetValue("ui_stu_monsterSpawnDelay", Com_Clamp(200, 999999, s_serveroptions.monsterSpawnDelay));
		trap_Cvar_SetValue("g_monsterSpawnDelay", Com_Clamp(200, 999999, s_serveroptions.monsterSpawnDelay));

		trap_Cvar_SetValue("ui_stu_monsterHealthScale", monsterHealth);

		trap_Cvar_SetValue("ui_stu_monsterProgression", Com_Clamp(0, 1000, s_serveroptions.monsterProgression));
		trap_Cvar_SetValue("g_monsterProgression", Com_Clamp(0, 1000, s_serveroptions.monsterProgression));

		trap_Cvar_SetValue("ui_stu_monsterGuards", Com_Clamp(0, 100, s_serveroptions.monsterGuards));
		trap_Cvar_SetValue("g_monsterGuards", Com_Clamp(0, 100, s_serveroptions.monsterGuards));

		trap_Cvar_SetValue("ui_stu_monsterTitans", Com_Clamp(0, 100, s_serveroptions.monsterTitans));
		trap_Cvar_SetValue("g_monsterTitans", Com_Clamp(0, 100, s_serveroptions.monsterTitans));

		trap_Cvar_SetValue("ui_stu_monsterBreeding", Com_Clamp(0, 1, s_serveroptions.monsterBreeding));
		trap_Cvar_SetValue("g_monsterBreeding", Com_Clamp(0, 1, s_serveroptions.monsterBreeding));

		trap_Cvar_SetValue("ui_stu_artefacts", Com_Clamp(0, 999, atoi(s_serveroptions.artefacts.field.buffer)));
		trap_Cvar_SetValue("g_artefacts", Com_Clamp(0, 999, atoi(s_serveroptions.artefacts.field.buffer)));

		trap_Cvar_SetValue("g_skipEndSequence", Com_Clamp(0, 1, s_serveroptions.skipEndSequence));
#if MEETING
		trap_Cvar_SetValue("ui_stu_meeting", meeting);	// JUHOX
#endif
		break;

	// JUHOX: set EFH ui cvars
	case GT_EFH:
		trap_Cvar_SetValue("ui_efh_fraglimit", fraglimit);
		trap_Cvar_SetValue("ui_efh_timelimit", timelimit);
		trap_Cvar_SetValue("ui_efh_distancelimit", (int)(1000.0 * Com_Clamp(0, 100, atof(s_serveroptions.distanceLimit.field.buffer))));
		trap_Cvar_SetValue("distancelimit", (int)(1000.0 * Com_Clamp(0, 100, atof(s_serveroptions.distanceLimit.field.buffer))));
		trap_Cvar_SetValue("ui_efh_friendly", friendlyfire);
		trap_Cvar_SetValue("ui_efh_gameseed", gameseed);
		tss = qfalse;
		monsterLauncher = qfalse;
		trap_Cvar_SetValue("ui_efh_noItems", noItems);
		trap_Cvar_SetValue("ui_efh_noHealthRegen", noHealthRegen);
		trap_Cvar_SetValue("ui_efh_unlimitedAmmo", unlimitedAmmo);
		trap_Cvar_SetValue("ui_efh_cloakingDevice", cloakingDevice);
		trap_Cvar_SetValue("ui_efh_weaponLimit", weaponLimit);

		trap_Cvar_SetValue("ui_efh_monsterLoad", (int)Com_Clamp(0, 1000, s_serveroptions.monsterLoad));
		trap_Cvar_SetValue("g_monsterLoad", (int)Com_Clamp(0, 1000, s_serveroptions.monsterLoad));

		trap_Cvar_SetValue("ui_efh_challengingEnv", (int)Com_Clamp(0, 1, s_serveroptions.challengingEnv));
		trap_Cvar_SetValue("g_challengingEnv", (int)Com_Clamp(0, 1, s_serveroptions.challengingEnv));

		trap_Cvar_SetValue("ui_efh_monsterGuards", Com_Clamp(0, 100, s_serveroptions.monsterGuards));
		trap_Cvar_SetValue("g_monsterGuards", Com_Clamp(0, 100, s_serveroptions.monsterGuards));

		trap_Cvar_SetValue("ui_efh_monsterTitans", Com_Clamp(0, 100, s_serveroptions.monsterTitans));
		trap_Cvar_SetValue("g_monsterTitans", Com_Clamp(0, 100, s_serveroptions.monsterTitans));

		trap_Cvar_SetValue("ui_efh_monsterHealthScale", monsterHealth);

		trap_Cvar_SetValue("ui_efh_monsterProgression", Com_Clamp(0, 1000, s_serveroptions.monsterProgression));
		trap_Cvar_SetValue("g_monsterProgression", Com_Clamp(0, 1000, s_serveroptions.monsterProgression));
#if MEETING
		trap_Cvar_SetValue("ui_efh_meeting", meeting);	// JUHOX
#endif
		break;
	}

	// JUHOX: cvars (also) needed for monster launcher/efh
	trap_Cvar_SetValue("g_monsterLauncher", monsterLauncher);
	trap_Cvar_SetValue("g_maxMonsters", maxMonsters);
	trap_Cvar_SetValue("g_maxMonstersPP", maxMonstersPP);
	trap_Cvar_SetValue("g_monsterHealthScale", monsterHealth);
	trap_Cvar_Set("monsterModel1", monsterModel1);
	trap_Cvar_Set("monsterModel2", monsterModel2);
	trap_Cvar_Set("monsterModel3", monsterModel3);
	trap_Cvar_SetValue("g_scoreMode", Com_Clamp(0, 1, s_serveroptions.scoreMode));	// JUHOX

	trap_Cvar_SetValue("g_armorFragments", Com_Clamp(0, 1, armorFragments));	// JUHOX
	trap_Cvar_SetValue("ui_additionalSlots", Com_Clamp(0, MAX_CLIENTS, additionalSlots));	// JUHOX
	trap_Cvar_SetValue( "sv_maxclients", Com_Clamp( 0, /*12*/MAX_CLIENTS, maxclients ) );	// JUHOX
	trap_Cvar_SetValue( "dedicated", Com_Clamp( 0, 2, dedicated ) );
	trap_Cvar_SetValue("g_editmode", 0);
	trap_Cvar_SetValue ("timelimit", Com_Clamp( 0, timelimit, timelimit ) );
	trap_Cvar_SetValue ("fraglimit", Com_Clamp( 0, fraglimit, fraglimit ) );
	trap_Cvar_SetValue ("capturelimit", Com_Clamp( 0, flaglimit, flaglimit ) );
	trap_Cvar_SetValue( "respawnDelay", Com_Clamp( 0, 999, respawndelay ) );	// JUHOX
	trap_Cvar_SetValue( "respawnAtPOD", respawnAtPOD );	// JUHOX
	trap_Cvar_SetValue("tss", tss);	// JUHOX
	trap_Cvar_SetValue("tssSafetyModeAllowed", tssSafetyMode);	// JUHOX
	trap_Cvar_SetValue("g_stamina", s_serveroptions.stamina);	// JUHOX
	trap_Cvar_SetValue("g_baseHealth", s_serveroptions.baseHealth);	// JUHOX
	trap_Cvar_SetValue("g_lightningDamageLimit", s_serveroptions.lightningDamageLimit);	// JUHOX
	trap_Cvar_SetValue("g_grapple", s_serveroptions.grapple);	// JUHOX
	trap_Cvar_SetValue("g_noItems", noItems);	// JUHOX
	trap_Cvar_SetValue("g_noHealthRegen", noHealthRegen);	// JUHOX
	trap_Cvar_SetValue("g_unlimitedAmmo", unlimitedAmmo);	// JUHOX
	trap_Cvar_SetValue("g_cloakingDevice", cloakingDevice);	// JUHOX
	trap_Cvar_SetValue("g_weaponLimit", weaponLimit);	// JUHOX
	trap_Cvar_SetValue( "g_friendlyfire", friendlyfire );
	trap_Cvar_SetValue( "sv_pure", pure );
	trap_Cvar_SetValue("g_gameSeed", gameseed);	// JUHOX
#if MEETING	// JUHOX: set g_meeting
	if (s_serveroptions.multiplayer) {
		trap_Cvar_SetValue("g_meeting", meeting);
	}
	else {
		trap_Cvar_Set("g_meeting", "0");
	}
#endif
	trap_Cvar_Set("sv_hostname", s_serveroptions.hostname.field.buffer );

	trap_Cvar_SetValue( "sv_punkbuster", 0 );

	// the wait commands will allow the dedicated to take effect
	trap_Cmd_ExecuteText( EXEC_APPEND, va( "wait ; wait ; map %s\n", /*s_startserver.maplist[s_startserver.currentmap]*/s_startserver.choosenmap ) );	// JUHOX

	// add bots
	trap_Cmd_ExecuteText( EXEC_APPEND, "wait 3\n" );
	for( n = 1; n < PLAYER_SLOTS; n++ ) {
		if( s_serveroptions.playerType[n].curvalue != 1 ) {
			continue;
		}
		if( s_serveroptions.playerNameBuffers[n][0] == 0 ) {
			continue;
		}
		if( s_serveroptions.playerNameBuffers[n][0] == '-' ) {
			continue;
		}
		if( s_serveroptions.gametype >= GT_TEAM ) {
			Com_sprintf( buf, sizeof(buf), "addbot %s %i %s\n", s_serveroptions.playerNameBuffers[n], skill,
				playerTeam_list[s_serveroptions.playerTeam[n].curvalue] );
		}
		else {
			Com_sprintf( buf, sizeof(buf), "addbot %s %i\n", s_serveroptions.playerNameBuffers[n], skill );
		}
		trap_Cmd_ExecuteText( EXEC_APPEND, buf );
	}

	// set player's team
	if( dedicated == 0 && s_serveroptions.gametype >= GT_TEAM ) {
		trap_Cmd_ExecuteText( EXEC_APPEND, va( "wait 5; team %s\n", playerTeam_list[s_serveroptions.playerTeam[0].curvalue] ) );
	}
}


/*
=================
ServerOptions_InitPlayerItems
=================
*/
static void ServerOptions_InitPlayerItems( void ) {
	int		n;
	int		v;

	// init types
	if( s_serveroptions.multiplayer ) {
		v = 0;	// open
	}
	else {
		v = 1;	// bot
	}
	// JUHOX: no bots in EFH
	if (s_serveroptions.gametype == GT_EFH) {
		v = 0;	// open
	}

	for( n = 0; n < PLAYER_SLOTS; n++ ) {
		s_serveroptions.playerType[n].curvalue = v;
	}

	if( s_serveroptions.multiplayer && (s_serveroptions.gametype < GT_TEAM) ) {
		for( n = 8; n < PLAYER_SLOTS; n++ ) {
			s_serveroptions.playerType[n].curvalue = 2;
		}
	}

	// if not a dedicated server, first slot is reserved for the human on the server
	if( s_serveroptions.dedicated.curvalue == 0 ) {
		// human
		s_serveroptions.playerType[0].generic.flags |= QMF_INACTIVE;
		s_serveroptions.playerType[0].curvalue = 0;
		trap_Cvar_VariableStringBuffer( "name", s_serveroptions.playerNameBuffers[0], sizeof(s_serveroptions.playerNameBuffers[0]) );
		Q_CleanStr( s_serveroptions.playerNameBuffers[0] );
	}

	// init teams
	// JUHOX: hide team selector for STU & EFH
	if (s_serveroptions.gametype >= GT_STU) {
		for (n = 0; n < PLAYER_SLOTS; n++) {
			s_serveroptions.playerTeam[n].curvalue = 1;	// 0=blue, 1=red
			s_serveroptions.playerTeam[n].generic.flags |= (QMF_INACTIVE|QMF_HIDDEN);
		}
	}
	else

	if( s_serveroptions.gametype >= GT_TEAM ) {
		for( n = 0; n < (PLAYER_SLOTS / 2); n++ ) {
			s_serveroptions.playerTeam[n].curvalue = 0;
		}
		for( ; n < PLAYER_SLOTS; n++ ) {
			s_serveroptions.playerTeam[n].curvalue = 1;
		}
	}
	else {
		for( n = 0; n < PLAYER_SLOTS; n++ ) {
			s_serveroptions.playerTeam[n].generic.flags |= (QMF_INACTIVE|QMF_HIDDEN);
		}
	}
}


/*
=================
ServerOptions_SetPlayerItems
=================
*/
static void ServerOptions_SetPlayerItems( void ) {
	int		start;
	int		n;

	// names
	if( s_serveroptions.dedicated.curvalue == 0 ) {
		s_serveroptions.player0.string = "Human";
		s_serveroptions.playerName[0].generic.flags &= ~QMF_HIDDEN;

		start = 1;
	}
	else {
		s_serveroptions.player0.string = "Open";
		start = 0;
	}
	for( n = start; n < PLAYER_SLOTS; n++ ) {
        // JUHOX: no bots in EFH
		if (
			s_serveroptions.gametype == GT_EFH &&
			s_serveroptions.playerType[n].curvalue == 1
		) {
			s_serveroptions.playerType[n].curvalue = 2;	// closed
		}

		if( s_serveroptions.playerType[n].curvalue == 1 ) {
			s_serveroptions.playerName[n].generic.flags &= ~(QMF_INACTIVE|QMF_HIDDEN);
		}
		else {
			s_serveroptions.playerName[n].generic.flags |= (QMF_INACTIVE|QMF_HIDDEN);
		}
	}

	// teams
	if( s_serveroptions.gametype < GT_TEAM ) {
		return;
	}
	// JUHOX: don't change team selector's hidden status for STU & EFH
	if (s_serveroptions.gametype >= GT_STU) {
		return;
	}

	for( n = start; n < PLAYER_SLOTS; n++ ) {
		if( s_serveroptions.playerType[n].curvalue == 2 ) {
			s_serveroptions.playerTeam[n].generic.flags |= (QMF_INACTIVE|QMF_HIDDEN);
		}
		else {
			s_serveroptions.playerTeam[n].generic.flags &= ~(QMF_INACTIVE|QMF_HIDDEN);
		}
	}
}


/*
=================
ServerOptions_Event
=================
*/
static void ServerOptions_Event( void* ptr, int event ) {
	switch( ((menucommon_s*)ptr)->id ) {

	//if( event != QM_ACTIVATED && event != QM_LOSTFOCUS) {
	//	return;
	//}
	case ID_PLAYER_TYPE:
		if( event != QM_ACTIVATED ) {
			break;
		}
		ServerOptions_SetPlayerItems();
		break;

	case ID_MAXCLIENTS:
	case ID_DEDICATED:
		ServerOptions_SetPlayerItems();
		break;
	case ID_GO:
		if( event != QM_ACTIVATED ) {
			break;
		}
		ServerOptions_Start();
		break;

	case ID_STARTSERVERNEXT:
		if( event != QM_ACTIVATED ) {
			break;
		}
		break;
	case ID_BACK:
		if( event != QM_ACTIVATED ) {
			break;
		}
		UI_PopMenu();
		break;
	}
}


static void ServerOptions_PlayerNameEvent( void* ptr, int event ) {
	int		n;

	if( event != QM_ACTIVATED ) {
		return;
	}
	n = ((menutext_s*)ptr)->generic.id;
	s_serveroptions.newBotIndex = n;
	UI_BotSelectMenu( s_serveroptions.playerNameBuffers[n] );
}


/*
=================
ServerOptions_StatusBar
=================
*/
static void ServerOptions_StatusBar( void* ptr ) {
	switch( ((menucommon_s*)ptr)->id ) {
	default:
		// JUHOX: in STU & EFH move server options status bar a bit lower
		{
			int y;

			y = 400;
			if (s_serveroptions.gametype >= GT_STU && s_serveroptions.multiplayer) {
				y += SMALLCHAR_HEIGHT;
			}
			UI_DrawString(420, y, "0 = no limit", UI_CENTER|UI_SMALLFONT, colorWhite);
		}
		break;
	}
}

/*
=================
JUHOX: ServerOptions_PureServerStatusBar
=================
*/
static void ServerOptions_PureServerStatusBar(void* ptr) {
	if (s_serveroptions.gametype < GT_TEAM) return;
	// JUHOX: no TSS with STU & EFH
	if (s_serveroptions.gametype >= GT_STU) return;

#if !TSSINCVAR
	if (s_serveroptions.pure.curvalue) {
		//s_serveroptions.tss = qfalse;	// JUHOX FIXME: unusual place for this
		UI_DrawString(420, 400, "NOTE: No TSS on pure servers!", UI_CENTER|UI_SMALLFONT, colorWhite);
	}
#endif
}

/*
=================
JUHOX: ServerOptions_ArtefactsStatusBar
=================
*/
static void ServerOptions_ArtefactsStatusBar(void* ptr) {
	int y;

	y = 400;
	if (s_serveroptions.multiplayer) {
		y += SMALLCHAR_HEIGHT;
	}
	UI_DrawString(420, y, "0 ... 998, 999 = unlimited", UI_CENTER|UI_SMALLFONT, colorWhite);
}

/*
===============
ServerOptions_LevelshotDraw
===============
*/
static void ServerOptions_LevelshotDraw( void *self ) {
	menubitmap_s	*b;
	int				x;
	int				y;

	// strange place for this, but it works
	if( s_serveroptions.newBot ) {
		Q_strncpyz( s_serveroptions.playerNameBuffers[s_serveroptions.newBotIndex], s_serveroptions.newBotName, 16 );
		s_serveroptions.newBot = qfalse;
	}

	b = (menubitmap_s *)self;

	Bitmap_Draw( b );

	x = b->generic.x;
	y = b->generic.y + b->height;
	UI_FillRect( x, y, b->width, 40, colorBlack );

	x += b->width / 2;
	y += 4;
	UI_DrawString( x, y, s_serveroptions.mapnamebuffer, UI_CENTER|UI_SMALLFONT, color_orange );

	y += SMALLCHAR_HEIGHT;

	UI_DrawString(x, y, gametype_names[s_serveroptions.gametype], UI_CENTER|UI_SMALLFONT, color_orange);

}


static void ServerOptions_InitBotNames( void ) {
	int			count;
	int			n;
	const char	*arenaInfo;
	const char	*botInfo;
	char		*p;
	char		*bot;
	char		bots[MAX_INFO_STRING];

	// JUHOX: no bots in EFH
	if (s_serveroptions.gametype == GT_EFH) {
		count = 1;
		goto CloseSuperfluousSlots;
	}

	count = 1;
	if (s_serveroptions.gametype == GT_STU) goto Init;
	if (s_serveroptions.gametype >= GT_TEAM) {

		Q_strncpyz( s_serveroptions.playerNameBuffers[1], "grunt", 16 );
		Q_strncpyz( s_serveroptions.playerNameBuffers[2], "major", 16 );
		if( s_serveroptions.gametype == GT_TEAM ) {
			Q_strncpyz( s_serveroptions.playerNameBuffers[3], "visor", 16 );
		}
		else {
			s_serveroptions.playerType[3].curvalue = 2;
		}
		s_serveroptions.playerType[4].curvalue = 2;
		s_serveroptions.playerType[5].curvalue = 2;

		Q_strncpyz( s_serveroptions.playerNameBuffers[6], "sarge", 16 );
		Q_strncpyz( s_serveroptions.playerNameBuffers[7], "grunt", 16 );
		Q_strncpyz( s_serveroptions.playerNameBuffers[8], "major", 16 );
		if( s_serveroptions.gametype == GT_TEAM ) {
			Q_strncpyz( s_serveroptions.playerNameBuffers[9], "visor", 16 );
		}
		else {
			s_serveroptions.playerType[9].curvalue = 2;
		}
		s_serveroptions.playerType[10].curvalue = 2;
		s_serveroptions.playerType[11].curvalue = 2;

        // JUHOX: add more bot names1
		Q_strncpyz( s_serveroptions.playerNameBuffers[3], "visor", 16 );
		Q_strncpyz( s_serveroptions.playerNameBuffers[4], "anarki", 16 );
		Q_strncpyz( s_serveroptions.playerNameBuffers[5], "xaero", 16 );
		Q_strncpyz( s_serveroptions.playerNameBuffers[9], "visor", 16 );
		Q_strncpyz( s_serveroptions.playerNameBuffers[10], "anarki", 16 );
		Q_strncpyz( s_serveroptions.playerNameBuffers[11], "xaero", 16 );

		return;
	}

	count = 1;	// skip the first slot, reserved for a human

	// get info for this map
	arenaInfo = UI_GetArenaInfoByMap( s_serveroptions.mapnamebuffer );

	// get the bot info - we'll seed with them if any are listed
	Q_strncpyz( bots, Info_ValueForKey( arenaInfo, "bots" ), sizeof(bots) );
	p = &bots[0];
	while( *p && count < PLAYER_SLOTS ) {
		//skip spaces
		while( *p && *p == ' ' ) {
			p++;
		}
		if( !p ) {
			break;
		}

		// mark start of bot name
		bot = p;

		// skip until space of null
		while( *p && *p != ' ' ) {
			p++;
		}
		if( *p ) {
			*p++ = 0;
		}

		botInfo = UI_GetBotInfoByName( bot );
		bot = Info_ValueForKey( botInfo, "name" );

		Q_strncpyz( s_serveroptions.playerNameBuffers[count], bot, sizeof(s_serveroptions.playerNameBuffers[count]) );
		count++;
	}

	// JUHOX: initialize bot slots with names
	Init:
	for (n = count; n < PLAYER_SLOTS; n++) {
		static const char* const names[PLAYER_SLOTS] = {
			"Sarge", "Grunt", "Major", "Visor",
			"Anarki", "Xaero", "Harpy", "Sorlag",
			"TankJr", "Uriel", "Bones", "Orbb"
		};

		strcpy(s_serveroptions.playerNameBuffers[n], names[n]);
	}

	// JUHOX: check "maxplayers" for # of open slots
	CloseSuperfluousSlots:
	{
		int openSlots;

		openSlots = gtmpl.maxplayers;
		if (openSlots > 0 && openSlots <= PLAYER_SLOTS) {
			s_serveroptions.additionalSlots.generic.flags |= QMF_GRAYED;

			for (n = openSlots; n < PLAYER_SLOTS; n++) {
				s_serveroptions.playerType[n].generic.flags |= QMF_GRAYED;
				s_serveroptions.playerName[n].generic.flags |= QMF_GRAYED;
			}
		}

		if (openSlots < 1) openSlots = 8;
		if (openSlots > MAX_CLIENTS) openSlots = MAX_CLIENTS;

		n = openSlots;
		if (n > PLAYER_SLOTS) n = PLAYER_SLOTS;
		for (; count < n; count++) {
			s_serveroptions.playerType[count].curvalue = 0;
		}

		if (gtmpl.tksMaxplayers > TKS_missing) {
			for (n = openSlots; n < PLAYER_SLOTS; n++) {
				s_serveroptions.playerType[n].curvalue = 2;
			}

			n = openSlots - PLAYER_SLOTS;
			if (n < 0) n = 0;
			Com_sprintf(s_serveroptions.additionalSlots.field.buffer, 3, "%i", n);
		}
	}

	// close off the rest by default
	for( ;count < PLAYER_SLOTS; count++ ) {
		if( s_serveroptions.playerType[count].curvalue == 1 ) {
			s_serveroptions.playerType[count].curvalue = 2;
		}
	}
}


/*
=================
ServerOptions_SetMenuItems
=================
*/
static void ServerOptions_SetMenuItems( void ) {
	static char picname[64];

	switch( s_serveroptions.gametype ) {
	case GT_FFA:
	default:
		Com_sprintf( s_serveroptions.fraglimit.field.buffer, 4, "%i", (int)Com_Clamp( 0, 999, trap_Cvar_VariableValue( "ui_ffa_fraglimit" ) ) );
		Com_sprintf( s_serveroptions.timelimit.field.buffer, 4, "%i", (int)Com_Clamp( 0, 999, trap_Cvar_VariableValue( "ui_ffa_timelimit" ) ) );
		Com_sprintf(s_serveroptions.gameseed.field.buffer, 6, "%i", (int)Com_Clamp(0, 65535, trap_Cvar_VariableValue("ui_ffa_gameseed")));	// JUHOX
		s_serveroptions.respawnDelay = (int) Com_Clamp(0, 999, trap_Cvar_VariableValue("ui_ffa_respawndelay"));	// JUHOX
		s_serveroptions.noItems = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_ffa_noItems"));	// JUHOX
		s_serveroptions.noHealthRegen = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_ffa_noHealthRegen"));	// JUHOX
		s_serveroptions.unlimitedAmmo = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_ffa_unlimitedAmmo"));	// JUHOX
		s_serveroptions.cloakingDevice = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_ffa_cloakingDevice"));	// JUHOX
		s_serveroptions.weaponLimit = (int) Com_Clamp(0, MAX_WEAPONS, trap_Cvar_VariableValue("ui_ffa_weaponLimit"));	// JUHOX
		s_serveroptions.monsterLauncher = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_ffa_monsterLauncher"));	// JUHOX
		s_serveroptions.maxMonsters = (int) Com_Clamp(1, MAX_MONSTERS, trap_Cvar_VariableValue("ui_ffa_maxMonsters"));	// JUHOX
		s_serveroptions.maxMonstersPerPlayer = (int) Com_Clamp(1, MAX_MONSTERS, trap_Cvar_VariableValue("ui_ffa_maxMonstersPP"));	// JUHOX
		s_serveroptions.monsterHealthScale = (int) Com_Clamp(1, 1000, trap_Cvar_VariableValue("ui_ffa_monsterHealthScale"));	// JUHOX

#if MEETING
		s_serveroptions.meeting.curvalue = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_ffa_meeting"));	// JUHOX
#endif
		break;

	case GT_TOURNAMENT:
		Com_sprintf( s_serveroptions.fraglimit.field.buffer, 4, "%i", (int)Com_Clamp( 0, 999, trap_Cvar_VariableValue( "ui_tourney_fraglimit" ) ) );
		Com_sprintf( s_serveroptions.timelimit.field.buffer, 4, "%i", (int)Com_Clamp( 0, 999, trap_Cvar_VariableValue( "ui_tourney_timelimit" ) ) );
		Com_sprintf(s_serveroptions.gameseed.field.buffer, 6, "%i", (int)Com_Clamp(0, 65535, trap_Cvar_VariableValue("ui_tourney_gameseed")));	// JUHOX
		s_serveroptions.noItems = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_tourney_noItems"));	// JUHOX
		s_serveroptions.noHealthRegen = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_tourney_noHealthRegen"));	// JUHOX
		s_serveroptions.unlimitedAmmo = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_tourney_unlimitedAmmo"));	// JUHOX
		s_serveroptions.cloakingDevice = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_tourney_cloakingDevice"));	// JUHOX
		s_serveroptions.weaponLimit = (int) Com_Clamp(0, MAX_WEAPONS, trap_Cvar_VariableValue("ui_tourney_weaponLimit"));	// JUHOX
		s_serveroptions.monsterLauncher = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_tourney_monsterLauncher"));	// JUHOX
		s_serveroptions.maxMonsters = (int) Com_Clamp(1, MAX_MONSTERS, trap_Cvar_VariableValue("ui_tourney_maxMonsters"));	// JUHOX
		s_serveroptions.maxMonstersPerPlayer = (int) Com_Clamp(1, MAX_MONSTERS, trap_Cvar_VariableValue("ui_tourney_maxMonstersPP"));	// JUHOX
		s_serveroptions.monsterHealthScale = (int) Com_Clamp(1, 1000, trap_Cvar_VariableValue("ui_tourney_monsterHealthScale"));	// JUHOX
#if MEETING
		s_serveroptions.meeting.curvalue = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_tourney_meeting"));	// JUHOX
#endif
		break;

	case GT_TEAM:
		Com_sprintf( s_serveroptions.fraglimit.field.buffer, 4, "%i", (int)Com_Clamp( 0, 999, trap_Cvar_VariableValue( "ui_team_fraglimit" ) ) );
		Com_sprintf( s_serveroptions.timelimit.field.buffer, 4, "%i", (int)Com_Clamp( 0, 999, trap_Cvar_VariableValue( "ui_team_timelimit" ) ) );
		s_serveroptions.friendlyfire.curvalue = (int)Com_Clamp( 0, 1, trap_Cvar_VariableValue( "ui_team_friendly" ) );
		Com_sprintf(s_serveroptions.gameseed.field.buffer, 6, "%i", (int)Com_Clamp(0, 65535, trap_Cvar_VariableValue("ui_team_gameseed")));	// JUHOX
		s_serveroptions.respawnDelay = (int) Com_Clamp(0, 999, trap_Cvar_VariableValue("ui_team_respawnDelay"));	// JUHOX
		s_serveroptions.tss = (int)Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_team_tss"));	// JUHOX
		s_serveroptions.noItems = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_team_noItems"));	// JUHOX
		s_serveroptions.noHealthRegen = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_team_noHealthRegen"));	// JUHOX
		s_serveroptions.unlimitedAmmo = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_team_unlimitedAmmo"));	// JUHOX
		s_serveroptions.cloakingDevice = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_team_cloakingDevice"));	// JUHOX
		s_serveroptions.weaponLimit = (int) Com_Clamp(0, MAX_WEAPONS, trap_Cvar_VariableValue("ui_team_weaponLimit"));	// JUHOX
		s_serveroptions.monsterLauncher = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_team_monsterLauncher"));	// JUHOX
		s_serveroptions.maxMonsters = (int) Com_Clamp(1, MAX_MONSTERS, trap_Cvar_VariableValue("ui_team_maxMonsters"));	// JUHOX
		s_serveroptions.maxMonstersPerPlayer = (int) Com_Clamp(1, MAX_MONSTERS, trap_Cvar_VariableValue("ui_team_maxMonstersPP"));	// JUHOX
		s_serveroptions.monsterHealthScale = (int) Com_Clamp(1, 1000, trap_Cvar_VariableValue("ui_team_monsterHealthScale"));	// JUHOX
#if MEETING
		s_serveroptions.meeting.curvalue = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_team_meeting"));	// JUHOX
#endif
		break;

	case GT_CTF:
		Com_sprintf( s_serveroptions.flaglimit.field.buffer, 4, "%i", (int)Com_Clamp( 0, 100, trap_Cvar_VariableValue( "ui_ctf_capturelimit" ) ) );
		Com_sprintf( s_serveroptions.timelimit.field.buffer, 4, "%i", (int)Com_Clamp( 0, 999, trap_Cvar_VariableValue( "ui_ctf_timelimit" ) ) );
		s_serveroptions.friendlyfire.curvalue = (int)Com_Clamp( 0, 1, trap_Cvar_VariableValue( "ui_ctf_friendly" ) );
		Com_sprintf(s_serveroptions.gameseed.field.buffer, 6, "%i", (int)Com_Clamp(0, 65535, trap_Cvar_VariableValue("ui_ctf_gameseed")));	// JUHOX
		s_serveroptions.respawnDelay = (int) Com_Clamp(0, 999, trap_Cvar_VariableValue("ui_ctf_respawndelay"));	// JUHOX
		s_serveroptions.tss = (int)Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_ctf_tss"));	// JUHOX
		s_serveroptions.noItems = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_ctf_noItems"));	// JUHOX
		s_serveroptions.noHealthRegen = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_ctf_noHealthRegen"));	// JUHOX
		s_serveroptions.unlimitedAmmo = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_ctf_unlimitedAmmo"));	// JUHOX
		s_serveroptions.cloakingDevice = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_ctf_cloakingDevice"));	// JUHOX
		s_serveroptions.weaponLimit = (int) Com_Clamp(0, MAX_WEAPONS, trap_Cvar_VariableValue("ui_ctf_weaponLimit"));	// JUHOX
		s_serveroptions.monsterLauncher = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_ctf_monsterLauncher"));	// JUHOX
		s_serveroptions.maxMonsters = (int) Com_Clamp(1, MAX_MONSTERS, trap_Cvar_VariableValue("ui_ctf_maxMonsters"));	// JUHOX
		s_serveroptions.maxMonstersPerPlayer = (int) Com_Clamp(1, MAX_MONSTERS, trap_Cvar_VariableValue("ui_ctf_maxMonstersPP"));	// JUHOX
		s_serveroptions.monsterHealthScale = (int) Com_Clamp(1, 1000, trap_Cvar_VariableValue("ui_ctf_monsterHealthScale"));	// JUHOX
#if MEETING
		s_serveroptions.meeting.curvalue = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_ctf_meeting"));	// JUHOX
#endif
		break;

	// JUHOX: read STU ui cvars
	case GT_STU:
		Com_sprintf(s_serveroptions.fraglimit.field.buffer, 4, "%i", (int)Com_Clamp(0, 999, trap_Cvar_VariableValue("ui_stu_fraglimit")));
		Com_sprintf(s_serveroptions.timelimit.field.buffer, 4, "%i", (int)Com_Clamp(0, 999, trap_Cvar_VariableValue("ui_stu_timelimit")));
		Com_sprintf(s_serveroptions.artefacts.field.buffer, 4, "%i", (int)Com_Clamp(0, 999, trap_Cvar_VariableValue("ui_stu_artefacts")));
		s_serveroptions.friendlyfire.curvalue = (int)Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_stu_friendly"));
		Com_sprintf(s_serveroptions.gameseed.field.buffer, 6, "%i", (int)Com_Clamp(0, 65535, trap_Cvar_VariableValue("ui_stu_gameseed")));
		s_serveroptions.respawnDelay = (int) Com_Clamp(0, 999, trap_Cvar_VariableValue("ui_stu_respawnDelay"));
		s_serveroptions.tss = (int)Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_stu_tss"));
		s_serveroptions.noItems = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_stu_noItems"));
		s_serveroptions.noHealthRegen = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_stu_noHealthRegen"));
		s_serveroptions.unlimitedAmmo = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_stu_unlimitedAmmo"));
		s_serveroptions.cloakingDevice = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_stu_cloakingDevice"));
		s_serveroptions.weaponLimit = (int) Com_Clamp(0, MAX_WEAPONS, trap_Cvar_VariableValue("ui_stu_weaponLimit"));

		s_serveroptions.maxMonsters = (int) Com_Clamp(1, MAX_MONSTERS, trap_Cvar_VariableValue("ui_stu_maxMonsters"));
		s_serveroptions.minMonsters = (int) Com_Clamp(0, MAX_MONSTERS, trap_Cvar_VariableValue("ui_stu_minMonsters"));
		s_serveroptions.monstersPerTrap = (int) Com_Clamp(0, MAX_MONSTERS, trap_Cvar_VariableValue("ui_stu_monstersPerTrap"));
		s_serveroptions.monsterSpawnDelay = (int) Com_Clamp(1, 999999, trap_Cvar_VariableValue("ui_stu_monsterSpawnDelay"));
		if (s_serveroptions.monsterSpawnDelay < 200) s_serveroptions.monsterSpawnDelay *= 1000;	// JUHOX FIXME: to support old values
		s_serveroptions.monsterGuards = (int) Com_Clamp(0, 100, trap_Cvar_VariableValue("ui_stu_monsterGuards"));
		s_serveroptions.monsterTitans = (int) Com_Clamp(0, 100, trap_Cvar_VariableValue("ui_stu_monsterTitans"));
		s_serveroptions.monsterHealthScale = (int) Com_Clamp(1, 1000, trap_Cvar_VariableValue("ui_stu_monsterHealthScale"));
		s_serveroptions.monsterProgression = (int) Com_Clamp(0, 1000, trap_Cvar_VariableValue("ui_stu_monsterProgression"));
		s_serveroptions.monsterBreeding = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_stu_monsterBreeding"));
		s_serveroptions.skipEndSequence = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("g_skipEndSequence"));
		s_serveroptions.monsterLauncher = qfalse;
#if MEETING
		s_serveroptions.meeting.curvalue = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_stu_meeting"));	// JUHOX
#endif
		break;


// JUHOX: read EFH ui cvars
	case GT_EFH:
		Com_sprintf(s_serveroptions.fraglimit.field.buffer, 4, "%i", (int)Com_Clamp(0, 999, trap_Cvar_VariableValue("ui_efh_fraglimit")));
		Com_sprintf(s_serveroptions.timelimit.field.buffer, 4, "%i", (int)Com_Clamp(0, 999, trap_Cvar_VariableValue("ui_efh_timelimit")));
		Com_sprintf(s_serveroptions.distanceLimit.field.buffer, 10, "%f", Com_Clamp(0, 100, 0.001 * trap_Cvar_VariableValue("ui_efh_distancelimit")));
		s_serveroptions.friendlyfire.curvalue = (int)Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_efh_friendly"));
		Com_sprintf(s_serveroptions.gameseed.field.buffer, 6, "%i", (int)Com_Clamp(0, 65535, trap_Cvar_VariableValue("ui_efh_gameseed")));
		s_serveroptions.tss = qfalse;
		s_serveroptions.monsterLauncher = qfalse;
		s_serveroptions.noItems = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_efh_noItems"));
		s_serveroptions.noHealthRegen = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_efh_noHealthRegen"));
		s_serveroptions.unlimitedAmmo = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_efh_unlimitedAmmo"));
		s_serveroptions.cloakingDevice = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_efh_cloakingDevice"));
		s_serveroptions.weaponLimit = (int) Com_Clamp(0, MAX_WEAPONS, trap_Cvar_VariableValue("ui_efh_weaponLimit"));
		s_serveroptions.monsterLoad = (int) Com_Clamp(0, 1000, trap_Cvar_VariableValue("ui_efh_monsterLoad"));
		s_serveroptions.challengingEnv = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_efh_challengingEnv"));
		s_serveroptions.monsterGuards = (int) Com_Clamp(0, 100, trap_Cvar_VariableValue("ui_efh_monsterGuards"));
		s_serveroptions.monsterTitans = (int) Com_Clamp(0, 100, trap_Cvar_VariableValue("ui_efh_monsterTitans"));
		s_serveroptions.monsterHealthScale = (int) Com_Clamp(1, 1000, trap_Cvar_VariableValue("ui_efh_monsterHealthScale"));
		s_serveroptions.monsterProgression = (int) Com_Clamp(0, 1000, trap_Cvar_VariableValue("ui_efh_monsterProgression"));
#if MEETING
		s_serveroptions.meeting.curvalue = (int) Com_Clamp(0, 1, trap_Cvar_VariableValue("ui_efh_meeting"));	// JUHOX
#endif
		break;
	}

	// JUHOX: cvars (also) needed for monster launcher & EFH
	trap_Cvar_VariableStringBuffer("monsterModel1", s_serveroptions.monsterModel1, sizeof(s_serveroptions.monsterModel1));
	trap_Cvar_VariableStringBuffer("monsterModel2", s_serveroptions.monsterModel2, sizeof(s_serveroptions.monsterModel2));
	trap_Cvar_VariableStringBuffer("monsterModel3", s_serveroptions.monsterModel3, sizeof(s_serveroptions.monsterModel3));
	s_serveroptions.scoreMode = (int)Com_Clamp(0, 1, trap_Cvar_VariableValue("g_scoreMode"));

	s_serveroptions.respawnAtPOD = (int)Com_Clamp(0, 1, trap_Cvar_VariableValue("respawnAtPOD"));	// JUHOX
	s_serveroptions.tssSafetyMode = (int)Com_Clamp(0, 1, trap_Cvar_VariableValue("tssSafetyModeAllowed"));	// JUHOX
	s_serveroptions.armorFragments = (int)Com_Clamp(0, 1, trap_Cvar_VariableValue("g_armorFragments"));	// JUHOX
	s_serveroptions.stamina = (int)Com_Clamp(0, 1, trap_Cvar_VariableValue("g_stamina"));	// JUHOX
	s_serveroptions.baseHealth = (int)Com_Clamp(1, 1000, trap_Cvar_VariableValue("g_baseHealth"));	// JUHOX
	s_serveroptions.lightningDamageLimit = (int)Com_Clamp(0, 999, trap_Cvar_VariableValue("g_lightningDamageLimit"));	// JUHOX
	s_serveroptions.grapple = (int)Com_Clamp(0, HM_num_modes-1, trap_Cvar_VariableValue("g_grapple"));	// JUHOX

	Com_sprintf(s_serveroptions.additionalSlots.field.buffer, 3, "%i", (int)Com_Clamp(0, MAX_CLIENTS, trap_Cvar_VariableValue("ui_additionalSlots")));	// JUHOX

	Q_strncpyz( s_serveroptions.hostname.field.buffer, UI_Cvar_VariableString( "sv_hostname" ), sizeof( s_serveroptions.hostname.field.buffer ) );
	s_serveroptions.pure.curvalue = Com_Clamp( 0, 1, trap_Cvar_VariableValue( "sv_pure" ) );
#if !TSSINCVAR	// JUHOX: if tss is activated, let sv_pure default to 0
	if (s_serveroptions.gametype >= GT_TEAM && s_serveroptions.tss) s_serveroptions.pure.curvalue = 0;
#endif

	// set the map pic
	Com_sprintf( picname, 64, "levelshots/%s", /*s_startserver.maplist[s_startserver.currentmap]*/s_startserver.choosenmap );	// JUHOX
	s_serveroptions.mappic.generic.name = picname;

	// set the map name
	strcpy( s_serveroptions.mapnamebuffer, /*s_startserver.mapname.string*/s_startserver.choosenmapname );	// JUHOX
	Q_strupr( s_serveroptions.mapnamebuffer );

	// get the player selections initialized
	ServerOptions_InitPlayerItems();
	ServerOptions_SetPlayerItems();

	// seed bot names
	ServerOptions_InitBotNames();
	ServerOptions_SetPlayerItems();
}

/*
=================
PlayerName_Draw
=================
*/
static void PlayerName_Draw( void *item ) {
	menutext_s	*s;
	float		*color;
	int			x, y;
	int			style;
	qboolean	focus;

	s = (menutext_s *)item;

	x = s->generic.x;
	y =	s->generic.y;

	style = UI_SMALLFONT;
	focus = (s->generic.parent->cursor == s->generic.menuPosition);

	if ( s->generic.flags & QMF_GRAYED )
		color = text_color_disabled;
	else if ( focus )
	{
		color = text_color_highlight;
		style |= UI_PULSE;
	}
	else if ( s->generic.flags & QMF_BLINK )
	{
		color = text_color_highlight;
		style |= UI_BLINK;
	}
	else
		color = text_color_normal;

	if ( focus )
	{
		// draw cursor
		UI_FillRect( s->generic.left, s->generic.top, s->generic.right-s->generic.left+1, s->generic.bottom-s->generic.top+1, listbar_color );
		UI_DrawChar( x, y, 13, UI_CENTER|UI_BLINK|UI_SMALLFONT, color);
	}

	UI_DrawString( x - SMALLCHAR_WIDTH, y, s->generic.name, style|UI_RIGHT, color );
	UI_DrawString( x + SMALLCHAR_WIDTH, y, s->string, style|UI_LEFT, color );
}


/*
=================
JUHOX: ServerOptions_AdvancedOptions
=================
*/
void UI_AdvOptMenu(void);
static void ServerOptions_AdvancedOptions(void* ptr, int event) {
	if( event != QM_ACTIVATED ) {
		return;
	}

	UI_AdvOptMenu();
}

/*
=================
ServerOptions_MenuInit
=================
*/
#define OPTIONS_X	456

static void ServerOptions_MenuInit( qboolean multiplayer ) {
	int		y;
	int		n;

	memset( &s_serveroptions, 0 ,sizeof(serveroptions_t) );
	s_serveroptions.multiplayer = multiplayer;
	s_serveroptions.gametype = (int)Com_Clamp( 0, GT_MAX_GAME_TYPE-1, trap_Cvar_VariableValue( "g_gameType" ) );

	ServerOptions_Cache();

	s_serveroptions.menu.wrapAround = qtrue;
	s_serveroptions.menu.fullscreen = qtrue;

	s_serveroptions.banner.generic.type			= MTYPE_BTEXT;
	s_serveroptions.banner.generic.x			= 320;
	s_serveroptions.banner.generic.y			= 16;
	s_serveroptions.banner.string  				= "GAME SERVER";
	s_serveroptions.banner.color  				= color_white;
	s_serveroptions.banner.style  				= UI_CENTER;

	s_serveroptions.mappic.generic.type			= MTYPE_BITMAP;
	s_serveroptions.mappic.generic.flags		= QMF_LEFT_JUSTIFY|QMF_INACTIVE;
	s_serveroptions.mappic.generic.x			= 352;
	s_serveroptions.mappic.generic.y			= 80;
	s_serveroptions.mappic.width				= 160;
	s_serveroptions.mappic.height				= 120;
	s_serveroptions.mappic.errorpic				= GAMESERVER_UNKNOWNMAP;
	s_serveroptions.mappic.generic.ownerdraw	= ServerOptions_LevelshotDraw;

	s_serveroptions.picframe.generic.type		= MTYPE_BITMAP;
	s_serveroptions.picframe.generic.flags		= QMF_LEFT_JUSTIFY|QMF_INACTIVE|QMF_HIGHLIGHT;
	s_serveroptions.picframe.generic.x			= 352 - 38;
	s_serveroptions.picframe.generic.y			= 80 - 40;
	s_serveroptions.picframe.width  			= 320;
	s_serveroptions.picframe.height  			= 320;
	s_serveroptions.picframe.focuspic			= GAMESERVER_SELECT;

	y = 272;
	if( s_serveroptions.gametype != GT_CTF ) {
		s_serveroptions.fraglimit.generic.type       = MTYPE_FIELD;
		s_serveroptions.fraglimit.generic.name       = "Frag Limit:";
		s_serveroptions.fraglimit.generic.flags      = QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
		s_serveroptions.fraglimit.generic.x	         = OPTIONS_X;
		s_serveroptions.fraglimit.generic.y	         = y;
		s_serveroptions.fraglimit.generic.statusbar  = ServerOptions_StatusBar;
		s_serveroptions.fraglimit.field.widthInChars = /*3*/4;	// JUHOX
		s_serveroptions.fraglimit.field.maxchars     = 3;
	}
	else {
		s_serveroptions.flaglimit.generic.type       = MTYPE_FIELD;
		s_serveroptions.flaglimit.generic.name       = "Capture Limit:";
		s_serveroptions.flaglimit.generic.flags      = QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
		s_serveroptions.flaglimit.generic.x	         = OPTIONS_X;
		s_serveroptions.flaglimit.generic.y	         = y;
		s_serveroptions.flaglimit.generic.statusbar  = ServerOptions_StatusBar;
		s_serveroptions.flaglimit.field.widthInChars = /*3*/4;	// JUHOX
		s_serveroptions.flaglimit.field.maxchars     = 3;
	}

	y += BIGCHAR_HEIGHT+2;
	s_serveroptions.timelimit.generic.type       = MTYPE_FIELD;
	s_serveroptions.timelimit.generic.name       = "Time Limit:";
	s_serveroptions.timelimit.generic.flags      = QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	s_serveroptions.timelimit.generic.x	         = OPTIONS_X;
	s_serveroptions.timelimit.generic.y	         = y;
	s_serveroptions.timelimit.generic.statusbar  = ServerOptions_StatusBar;
	s_serveroptions.timelimit.field.widthInChars = /*3*/4;	// JUHOX
	s_serveroptions.timelimit.field.maxchars     = 3;

	// JUHOX: init the artefacts menu field
	if (s_serveroptions.gametype == GT_STU) {
		y += BIGCHAR_HEIGHT+2;
		s_serveroptions.artefacts.generic.type			= MTYPE_FIELD;
		s_serveroptions.artefacts.generic.name			= "Artefacts:";
		s_serveroptions.artefacts.generic.flags			= QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
		s_serveroptions.artefacts.generic.x				= OPTIONS_X;
		s_serveroptions.artefacts.generic.y				= y;
		s_serveroptions.artefacts.generic.statusbar		= ServerOptions_ArtefactsStatusBar;
		s_serveroptions.artefacts.field.widthInChars	= 4;
		s_serveroptions.artefacts.field.maxchars		= 3;
	}

	// JUHOX: init the distanceLimit menu field
	if (s_serveroptions.gametype == GT_EFH) {
		y += BIGCHAR_HEIGHT+2;
		s_serveroptions.distanceLimit.generic.type			= MTYPE_FIELD;
		s_serveroptions.distanceLimit.generic.name			= "Distance [km]:";
		s_serveroptions.distanceLimit.generic.flags			= QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
		s_serveroptions.distanceLimit.generic.x				= OPTIONS_X;
		s_serveroptions.distanceLimit.generic.y				= y;
		s_serveroptions.distanceLimit.field.widthInChars	= 10;
		s_serveroptions.distanceLimit.field.maxchars		= 9;
	}

	if( s_serveroptions.gametype >= GT_TEAM ) {
		y += BIGCHAR_HEIGHT+2;
		s_serveroptions.friendlyfire.generic.type     = MTYPE_RADIOBUTTON;
		s_serveroptions.friendlyfire.generic.flags    = QMF_PULSEIFFOCUS|QMF_SMALLFONT;
		s_serveroptions.friendlyfire.generic.x	      = OPTIONS_X;
		s_serveroptions.friendlyfire.generic.y	      = y;
		s_serveroptions.friendlyfire.generic.name	  = "Friendly Fire:";
	}

	y += BIGCHAR_HEIGHT+2;
	s_serveroptions.pure.generic.type			= MTYPE_RADIOBUTTON;
	s_serveroptions.pure.generic.flags			= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	s_serveroptions.pure.generic.x				= OPTIONS_X;
	s_serveroptions.pure.generic.y				= y;
	s_serveroptions.pure.generic.name			= "Pure Server:";
	s_serveroptions.pure.generic.statusbar		= ServerOptions_PureServerStatusBar;	// JUHOX

	if( s_serveroptions.multiplayer ) {
		y += BIGCHAR_HEIGHT+2;
		s_serveroptions.dedicated.generic.type		= MTYPE_SPINCONTROL;
		s_serveroptions.dedicated.generic.id		= ID_DEDICATED;
		s_serveroptions.dedicated.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
		s_serveroptions.dedicated.generic.callback	= ServerOptions_Event;
		s_serveroptions.dedicated.generic.x			= OPTIONS_X;
		s_serveroptions.dedicated.generic.y			= y;
		s_serveroptions.dedicated.generic.name		= "Dedicated:";
		s_serveroptions.dedicated.itemnames			= dedicated_list;
	}

	if( s_serveroptions.multiplayer ) {
		y += BIGCHAR_HEIGHT+2;
		s_serveroptions.hostname.generic.type       = MTYPE_FIELD;
		s_serveroptions.hostname.generic.name       = "Hostname:";
		s_serveroptions.hostname.generic.flags      = QMF_SMALLFONT;
		s_serveroptions.hostname.generic.x          = OPTIONS_X;
		s_serveroptions.hostname.generic.y	        = y;
		s_serveroptions.hostname.field.widthInChars = 18;
		s_serveroptions.hostname.field.maxchars     = 64;
	}

	y = 80;
	// JUHOX: no bots in EFH
	if (s_serveroptions.gametype != GT_EFH)
    {
        s_serveroptions.botSkill.generic.type			= MTYPE_SPINCONTROL;
        s_serveroptions.botSkill.generic.flags			= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
        s_serveroptions.botSkill.generic.name			= "Bot Skill:  ";
        s_serveroptions.botSkill.generic.x				= 32 + (strlen(s_serveroptions.botSkill.generic.name) + 2 ) * SMALLCHAR_WIDTH;
        s_serveroptions.botSkill.generic.y				= y;
        s_serveroptions.botSkill.itemnames				= botSkill_list;
        s_serveroptions.botSkill.curvalue				= 1;
        // JUHOX: in STU default bot skill is nightmare
        if (s_serveroptions.gametype == GT_STU) {
            s_serveroptions.botSkill.curvalue = 4;
        }
	}

	y += ( 2 * SMALLCHAR_HEIGHT );
	s_serveroptions.player0.generic.type			= MTYPE_TEXT;
	s_serveroptions.player0.generic.flags			= QMF_SMALLFONT;
	s_serveroptions.player0.generic.x				= 32 + SMALLCHAR_WIDTH;
	s_serveroptions.player0.generic.y				= y;
	s_serveroptions.player0.color					= color_orange;
	s_serveroptions.player0.style					= UI_LEFT|UI_SMALLFONT;

	for( n = 0; n < PLAYER_SLOTS; n++ ) {
		s_serveroptions.playerType[n].generic.type		= MTYPE_SPINCONTROL;
		s_serveroptions.playerType[n].generic.flags		= QMF_SMALLFONT;
		s_serveroptions.playerType[n].generic.id		= ID_PLAYER_TYPE;
		s_serveroptions.playerType[n].generic.callback	= ServerOptions_Event;
		s_serveroptions.playerType[n].generic.x			= 32;
		s_serveroptions.playerType[n].generic.y			= y;
		s_serveroptions.playerType[n].itemnames			= playerType_list;

		s_serveroptions.playerName[n].generic.type		= MTYPE_TEXT;
		s_serveroptions.playerName[n].generic.flags		= QMF_SMALLFONT;
		s_serveroptions.playerName[n].generic.x			= 96;
		s_serveroptions.playerName[n].generic.y			= y;
		s_serveroptions.playerName[n].generic.callback	= ServerOptions_PlayerNameEvent;
		s_serveroptions.playerName[n].generic.id		= n;
		s_serveroptions.playerName[n].generic.ownerdraw	= PlayerName_Draw;
		s_serveroptions.playerName[n].color				= color_orange;
		s_serveroptions.playerName[n].style				= UI_SMALLFONT;
		s_serveroptions.playerName[n].string			= s_serveroptions.playerNameBuffers[n];
		s_serveroptions.playerName[n].generic.top		= s_serveroptions.playerName[n].generic.y;
		s_serveroptions.playerName[n].generic.bottom	= s_serveroptions.playerName[n].generic.y + SMALLCHAR_HEIGHT;
		s_serveroptions.playerName[n].generic.left		= s_serveroptions.playerName[n].generic.x - SMALLCHAR_HEIGHT/ 2;
		s_serveroptions.playerName[n].generic.right		= s_serveroptions.playerName[n].generic.x + 16 * SMALLCHAR_WIDTH;

		s_serveroptions.playerTeam[n].generic.type		= MTYPE_SPINCONTROL;
		s_serveroptions.playerTeam[n].generic.flags		= QMF_SMALLFONT;
		s_serveroptions.playerTeam[n].generic.x			= 240;
		s_serveroptions.playerTeam[n].generic.y			= y;
		s_serveroptions.playerTeam[n].itemnames			= playerTeam_list;

		y += ( SMALLCHAR_HEIGHT + 4 );
	}

	// JUHOX: init the additional slots menu field
	y += SMALLCHAR_HEIGHT + 4;
	s_serveroptions.additionalSlots.generic.type		= MTYPE_FIELD;
	s_serveroptions.additionalSlots.generic.name		= "Additional Open Slots:";
	s_serveroptions.additionalSlots.generic.flags		= QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	s_serveroptions.additionalSlots.generic.x			= 240;
	s_serveroptions.additionalSlots.generic.y			= y;
	s_serveroptions.additionalSlots.field.widthInChars	= 3;
	s_serveroptions.additionalSlots.field.maxchars		= 2;

	// JUHOX: init the game seed menu field
	y += SMALLCHAR_HEIGHT + 4;
	s_serveroptions.gameseed.generic.type		= MTYPE_FIELD;
	s_serveroptions.gameseed.generic.name		= "Game Seed:";
	s_serveroptions.gameseed.generic.flags		= QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	s_serveroptions.gameseed.generic.x			= 240;
	s_serveroptions.gameseed.generic.y			= y;
	s_serveroptions.gameseed.field.widthInChars	= 6;
	s_serveroptions.gameseed.field.maxchars		= 5;


#if MEETING	// JUHOX: init the meeting menu field
	y += SMALLCHAR_HEIGHT + 4;
	s_serveroptions.meeting.generic.type			= MTYPE_RADIOBUTTON;
	s_serveroptions.meeting.generic.flags			= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	s_serveroptions.meeting.generic.x				= 240;
	s_serveroptions.meeting.generic.y				= y;
	s_serveroptions.meeting.generic.name			= "Meeting:";
#endif

	// JUHOX: init the advanced options menu field
	s_serveroptions.advOptions.generic.type		= MTYPE_PTEXT;
	s_serveroptions.advOptions.generic.flags	= QMF_SMALLFONT|QMF_PULSEIFFOCUS|QMF_CENTER_JUSTIFY;
	s_serveroptions.advOptions.generic.x		= 320;
	s_serveroptions.advOptions.generic.y		= 440;
	s_serveroptions.advOptions.generic.callback	= ServerOptions_AdvancedOptions;
	s_serveroptions.advOptions.color			= color_red;
	s_serveroptions.advOptions.style			= UI_SMALLFONT|UI_CENTER;
	s_serveroptions.advOptions.string			= "Advanced Options";

	s_serveroptions.back.generic.type	  = MTYPE_BITMAP;
	s_serveroptions.back.generic.name     = GAMESERVER_BACK0;
	s_serveroptions.back.generic.flags    = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
	s_serveroptions.back.generic.callback = ServerOptions_Event;
	s_serveroptions.back.generic.id	      = ID_BACK;
	s_serveroptions.back.generic.x		  = 0;
	s_serveroptions.back.generic.y		  = 480-64;
	s_serveroptions.back.width  		  = 128;
	s_serveroptions.back.height  		  = 64;
	s_serveroptions.back.focuspic         = GAMESERVER_BACK1;

	s_serveroptions.next.generic.type	  = MTYPE_BITMAP;
	s_serveroptions.next.generic.name     = GAMESERVER_NEXT0;
	s_serveroptions.next.generic.flags    = QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_INACTIVE|QMF_GRAYED|QMF_HIDDEN;
	s_serveroptions.next.generic.callback = ServerOptions_Event;
	s_serveroptions.next.generic.id	      = ID_STARTSERVERNEXT;
	s_serveroptions.next.generic.x		  = 640;
	s_serveroptions.next.generic.y		  = 480-64-72;
	s_serveroptions.next.generic.statusbar  = ServerOptions_StatusBar;
	s_serveroptions.next.width  		  = 128;
	s_serveroptions.next.height  		  = 64;
	s_serveroptions.next.focuspic         = GAMESERVER_NEXT1;

	s_serveroptions.go.generic.type	    = MTYPE_BITMAP;
	s_serveroptions.go.generic.name     = GAMESERVER_FIGHT0;
	s_serveroptions.go.generic.flags    = QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
	s_serveroptions.go.generic.callback = ServerOptions_Event;
	s_serveroptions.go.generic.id	    = ID_GO;
	s_serveroptions.go.generic.x		= 640;
	s_serveroptions.go.generic.y		= 480-64;
	s_serveroptions.go.width  		    = 128;
	s_serveroptions.go.height  		    = 64;
	s_serveroptions.go.focuspic         = GAMESERVER_FIGHT1;

	// JUHOX: gray out variables that are set by the template
	if (gtmpl.tksGameseed == TKS_fixedValue) s_serveroptions.gameseed.generic.flags |= QMF_GRAYED;
	if (gtmpl.tksFraglimit == TKS_fixedValue) {
		s_serveroptions.flaglimit.generic.flags |= QMF_GRAYED;
		s_serveroptions.fraglimit.generic.flags |= QMF_GRAYED;
	}
	if (gtmpl.tksTimelimit == TKS_fixedValue) s_serveroptions.timelimit.generic.flags |= QMF_GRAYED;
	if (gtmpl.tksArtefacts == TKS_fixedValue) s_serveroptions.artefacts.generic.flags |= QMF_GRAYED;
	if (gtmpl.tksDistancelimit == TKS_fixedValue) s_serveroptions.distanceLimit.generic.flags |= QMF_GRAYED;
	if (gtmpl.tksFriendlyfire == TKS_fixedValue) s_serveroptions.friendlyfire.generic.flags |= QMF_GRAYED;
	if (gtmpl.tksHighscoretype != TKS_missing) s_serveroptions.pure.generic.flags |= QMF_GRAYED;

	Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.banner );
	Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.mappic );
	Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.picframe );

	// JUHOX: no bots in EFH
	if (s_serveroptions.gametype != GT_EFH)

	Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.botSkill );
	Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.player0 );
	for( n = 0; n < PLAYER_SLOTS; n++ ) {
		if( n != 0 ) {
			Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.playerType[n] );
		}
		Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.playerName[n] );

		// JUHOX: don't add team selector for STU
		if (s_serveroptions.gametype >= GT_TEAM && s_serveroptions.gametype != GT_STU) {
			Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.playerTeam[n] );
		}
	}

	if( s_serveroptions.gametype != GT_CTF ) {
		Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.fraglimit );
	}
	else {
		Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.flaglimit );
	}
	Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.timelimit );
	// JUHOX: add the artefacts menu field
	if (s_serveroptions.gametype == GT_STU) {
		Menu_AddItem(&s_serveroptions.menu, &s_serveroptions.artefacts);
	}

	// JUHOX add the distanceLimit menu field
	if (s_serveroptions.gametype == GT_EFH) {
		Menu_AddItem(&s_serveroptions.menu, &s_serveroptions.distanceLimit);
	}

	if( s_serveroptions.gametype >= GT_TEAM ) {
		Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.friendlyfire );
	}
	Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.pure );
	if( s_serveroptions.multiplayer ) {
		Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.dedicated );
	}
	if( s_serveroptions.multiplayer ) {
		Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.hostname );
	}
	Menu_AddItem(&s_serveroptions.menu, &s_serveroptions.additionalSlots);	// JUHOX
	Menu_AddItem(&s_serveroptions.menu, &s_serveroptions.gameseed);	// JUHOX
#if MEETING
	if (s_serveroptions.multiplayer) {
		Menu_AddItem(&s_serveroptions.menu, &s_serveroptions.meeting);	// JUHOX
	}
#endif
	Menu_AddItem(&s_serveroptions.menu, &s_serveroptions.advOptions);	// JUHOX
	s_serveroptions.advOptions.generic.flags &= ~QMF_INACTIVE;	// JUHOX

	Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.back );
	Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.next );
	Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.go );

	//Menu_AddItem( &s_serveroptions.menu, (void*) &s_serveroptions.punkbuster );

	ServerOptions_SetMenuItems();
}

/*
=================
ServerOptions_Cache
=================
*/
void ServerOptions_Cache( void ) {
	trap_R_RegisterShaderNoMip( GAMESERVER_BACK0 );
	trap_R_RegisterShaderNoMip( GAMESERVER_BACK1 );
	trap_R_RegisterShaderNoMip( GAMESERVER_FIGHT0 );
	trap_R_RegisterShaderNoMip( GAMESERVER_FIGHT1 );
	trap_R_RegisterShaderNoMip( GAMESERVER_SELECT );
	trap_R_RegisterShaderNoMip( GAMESERVER_UNKNOWNMAP );
}


/*
=================
UI_ServerOptionsMenu
=================
*/
static void UI_ServerOptionsMenu( qboolean multiplayer ) {
	ServerOptions_MenuInit( multiplayer );
	UI_PushMenu( &s_serveroptions.menu );
}



/*
=============================================================================

BOT SELECT MENU *****

=============================================================================
*/


#define BOTSELECT_BACK0			"menu/art/back_0"
#define BOTSELECT_BACK1			"menu/art/back_1"
#define BOTSELECT_ACCEPT0		"menu/art/accept_0"
#define BOTSELECT_ACCEPT1		"menu/art/accept_1"
#define BOTSELECT_SELECT		"menu/art/opponents_select"
#define BOTSELECT_SELECTED		"menu/art/opponents_selected"
#define BOTSELECT_ARROWS		"menu/art/gs_arrows_0"
#define BOTSELECT_ARROWSL		"menu/art/gs_arrows_l"
#define BOTSELECT_ARROWSR		"menu/art/gs_arrows_r"

#define PLAYERGRID_COLS			4
#define PLAYERGRID_ROWS			4
#define MAX_MODELSPERPAGE		(PLAYERGRID_ROWS * PLAYERGRID_COLS)


typedef struct {
	menuframework_s	menu;

	menutext_s		banner;

	menubitmap_s	pics[MAX_MODELSPERPAGE];
	menubitmap_s	picbuttons[MAX_MODELSPERPAGE];
	menutext_s		picnames[MAX_MODELSPERPAGE];

	menubitmap_s	arrows;
	menubitmap_s	left;
	menubitmap_s	right;

	menubitmap_s	go;
	menubitmap_s	back;

	int				numBots;
	int				modelpage;
	int				numpages;
	int				selectedmodel;
	int				sortedBotNums[MAX_BOTS];
	char			boticons[MAX_MODELSPERPAGE][MAX_QPATH];
	char			botnames[MAX_MODELSPERPAGE][16];
} botSelectInfo_t;

static botSelectInfo_t	botSelectInfo;


/*
=================
UI_BotSelectMenu_SortCompare
=================
*/
static int QDECL UI_BotSelectMenu_SortCompare( const void *arg1, const void *arg2 ) {
	int			num1, num2;
	const char	*info1, *info2;
	const char	*name1, *name2;

	num1 = *(int *)arg1;
	num2 = *(int *)arg2;

	info1 = UI_GetBotInfoByNumber( num1 );
	info2 = UI_GetBotInfoByNumber( num2 );

	name1 = Info_ValueForKey( info1, "name" );
	name2 = Info_ValueForKey( info2, "name" );

	return Q_stricmp( name1, name2 );
}


/*
=================
UI_BotSelectMenu_BuildList
=================
*/
static void UI_BotSelectMenu_BuildList( void ) {
	int		n;

	botSelectInfo.modelpage = 0;
	botSelectInfo.numBots = UI_GetNumBots();
	botSelectInfo.numpages = botSelectInfo.numBots / MAX_MODELSPERPAGE;
	if( botSelectInfo.numBots % MAX_MODELSPERPAGE ) {
		botSelectInfo.numpages++;
	}

	// initialize the array
	for( n = 0; n < botSelectInfo.numBots; n++ ) {
		botSelectInfo.sortedBotNums[n] = n;
	}

	// now sort it
	qsort( botSelectInfo.sortedBotNums, botSelectInfo.numBots, sizeof(botSelectInfo.sortedBotNums[0]), UI_BotSelectMenu_SortCompare );
}


/*
=================
ServerPlayerIcon
=================
*/
static void ServerPlayerIcon( const char *modelAndSkin, char *iconName, int iconNameMaxSize ) {
	char	*skin;
	char	model[MAX_QPATH];

	Q_strncpyz( model, modelAndSkin, sizeof(model));
	skin = Q_strrchr( model, '/' );
	if ( skin ) {
		*skin++ = '\0';
	}
	else {
		skin = "default";
	}

	Com_sprintf(iconName, iconNameMaxSize, "models/players/%s/icon_%s.tga", model, skin );

	if( !trap_R_RegisterShaderNoMip( iconName ) && Q_stricmp( skin, "default" ) != 0 ) {
		Com_sprintf(iconName, iconNameMaxSize, "models/players/%s/icon_default.tga", model );
	}
}


/*
=================
UI_BotSelectMenu_UpdateGrid
=================
*/
static void UI_BotSelectMenu_UpdateGrid( void ) {
	const char	*info;
	int			i;
    int			j;

	j = botSelectInfo.modelpage * MAX_MODELSPERPAGE;
	for( i = 0; i < (PLAYERGRID_ROWS * PLAYERGRID_COLS); i++, j++) {
		if( j < botSelectInfo.numBots ) {
			info = UI_GetBotInfoByNumber( botSelectInfo.sortedBotNums[j] );
			ServerPlayerIcon( Info_ValueForKey( info, "model" ), botSelectInfo.boticons[i], MAX_QPATH );
			Q_strncpyz( botSelectInfo.botnames[i], Info_ValueForKey( info, "name" ), 16 );
			Q_CleanStr( botSelectInfo.botnames[i] );
 			botSelectInfo.pics[i].generic.name = botSelectInfo.boticons[i];
			if( BotAlreadySelected( botSelectInfo.botnames[i] ) ) {
				botSelectInfo.picnames[i].color = color_red;
			}
			else {
				botSelectInfo.picnames[i].color = color_orange;
			}
			botSelectInfo.picbuttons[i].generic.flags &= ~QMF_INACTIVE;
		}
		else {
			// dead slot
 			botSelectInfo.pics[i].generic.name         = NULL;
			botSelectInfo.picbuttons[i].generic.flags |= QMF_INACTIVE;
			botSelectInfo.botnames[i][0] = 0;
		}

 		botSelectInfo.pics[i].generic.flags       &= ~QMF_HIGHLIGHT;
 		botSelectInfo.pics[i].shader               = 0;
 		botSelectInfo.picbuttons[i].generic.flags |= QMF_PULSEIFFOCUS;
	}

	// set selected model
	i = botSelectInfo.selectedmodel % MAX_MODELSPERPAGE;
	botSelectInfo.pics[i].generic.flags |= QMF_HIGHLIGHT;
	botSelectInfo.picbuttons[i].generic.flags &= ~QMF_PULSEIFFOCUS;

	if( botSelectInfo.numpages > 1 ) {
		if( botSelectInfo.modelpage > 0 ) {
			botSelectInfo.left.generic.flags &= ~QMF_INACTIVE;
		}
		else {
			botSelectInfo.left.generic.flags |= QMF_INACTIVE;
		}

		if( botSelectInfo.modelpage < (botSelectInfo.numpages - 1) ) {
			botSelectInfo.right.generic.flags &= ~QMF_INACTIVE;
		}
		else {
			botSelectInfo.right.generic.flags |= QMF_INACTIVE;
		}
	}
	else {
		// hide left/right markers
		botSelectInfo.left.generic.flags |= QMF_INACTIVE;
		botSelectInfo.right.generic.flags |= QMF_INACTIVE;
	}
}


/*
=================
UI_BotSelectMenu_Default
=================
*/
static void UI_BotSelectMenu_Default( char *bot ) {
	const char	*botInfo;
	const char	*test;
	int			n;
	int			i;

	for( n = 0; n < botSelectInfo.numBots; n++ ) {
		botInfo = UI_GetBotInfoByNumber( n );
		test = Info_ValueForKey( botInfo, "name" );
		if( Q_stricmp( bot, test ) == 0 ) {
			break;
		}
	}
	if( n == botSelectInfo.numBots ) {
		botSelectInfo.selectedmodel = 0;
		return;
	}

	for( i = 0; i < botSelectInfo.numBots; i++ ) {
		if( botSelectInfo.sortedBotNums[i] == n ) {
			break;
		}
	}
	if( i == botSelectInfo.numBots ) {
		botSelectInfo.selectedmodel = 0;
		return;
	}

	botSelectInfo.selectedmodel = i;
}


/*
=================
UI_BotSelectMenu_LeftEvent
=================
*/
static void UI_BotSelectMenu_LeftEvent( void* ptr, int event ) {
	if( event != QM_ACTIVATED ) {
		return;
	}
	if( botSelectInfo.modelpage > 0 ) {
		botSelectInfo.modelpage--;
		botSelectInfo.selectedmodel = botSelectInfo.modelpage * MAX_MODELSPERPAGE;
		UI_BotSelectMenu_UpdateGrid();
	}
}


/*
=================
UI_BotSelectMenu_RightEvent
=================
*/
static void UI_BotSelectMenu_RightEvent( void* ptr, int event ) {
	if( event != QM_ACTIVATED ) {
		return;
	}
	if( botSelectInfo.modelpage < botSelectInfo.numpages - 1 ) {
		botSelectInfo.modelpage++;
		botSelectInfo.selectedmodel = botSelectInfo.modelpage * MAX_MODELSPERPAGE;
		UI_BotSelectMenu_UpdateGrid();
	}
}


/*
=================
UI_BotSelectMenu_BotEvent
=================
*/
static void UI_BotSelectMenu_BotEvent( void* ptr, int event ) {
	int		i;

	if( event != QM_ACTIVATED ) {
		return;
	}

	for( i = 0; i < (PLAYERGRID_ROWS * PLAYERGRID_COLS); i++ ) {
 		botSelectInfo.pics[i].generic.flags &= ~QMF_HIGHLIGHT;
 		botSelectInfo.picbuttons[i].generic.flags |= QMF_PULSEIFFOCUS;
	}

	// set selected
	i = ((menucommon_s*)ptr)->id;
	botSelectInfo.pics[i].generic.flags |= QMF_HIGHLIGHT;
	botSelectInfo.picbuttons[i].generic.flags &= ~QMF_PULSEIFFOCUS;
	botSelectInfo.selectedmodel = botSelectInfo.modelpage * MAX_MODELSPERPAGE + i;
}


/*
=================
UI_BotSelectMenu_BackEvent
=================
*/
static void UI_BotSelectMenu_BackEvent( void* ptr, int event ) {
	if( event != QM_ACTIVATED ) {
		return;
	}
	UI_PopMenu();
}


/*
=================
UI_BotSelectMenu_SelectEvent
=================
*/
static void UI_BotSelectMenu_SelectEvent( void* ptr, int event ) {
	if( event != QM_ACTIVATED ) {
		return;
	}
	UI_PopMenu();

	s_serveroptions.newBot = qtrue;
	Q_strncpyz( s_serveroptions.newBotName, botSelectInfo.botnames[botSelectInfo.selectedmodel % MAX_MODELSPERPAGE], 16 );
}


/*
=================
UI_BotSelectMenu_Cache
=================
*/
void UI_BotSelectMenu_Cache( void ) {
	trap_R_RegisterShaderNoMip( BOTSELECT_BACK0 );
	trap_R_RegisterShaderNoMip( BOTSELECT_BACK1 );
	trap_R_RegisterShaderNoMip( BOTSELECT_ACCEPT0 );
	trap_R_RegisterShaderNoMip( BOTSELECT_ACCEPT1 );
	trap_R_RegisterShaderNoMip( BOTSELECT_SELECT );
	trap_R_RegisterShaderNoMip( BOTSELECT_SELECTED );
	trap_R_RegisterShaderNoMip( BOTSELECT_ARROWS );
	trap_R_RegisterShaderNoMip( BOTSELECT_ARROWSL );
	trap_R_RegisterShaderNoMip( BOTSELECT_ARROWSR );
}


static void UI_BotSelectMenu_Init( char *bot ) {
	int		i, j, k;
	int		x, y;

	memset( &botSelectInfo, 0 ,sizeof(botSelectInfo) );
	botSelectInfo.menu.wrapAround = qtrue;
	botSelectInfo.menu.fullscreen = qtrue;

	UI_BotSelectMenu_Cache();

	botSelectInfo.banner.generic.type	= MTYPE_BTEXT;
	botSelectInfo.banner.generic.x		= 320;
	botSelectInfo.banner.generic.y		= 16;
	botSelectInfo.banner.string			= "SELECT BOT";
	botSelectInfo.banner.color			= color_white;
	botSelectInfo.banner.style			= UI_CENTER;

	y =	80;
	for( i = 0, k = 0; i < PLAYERGRID_ROWS; i++) {
		x =	180;
		for( j = 0; j < PLAYERGRID_COLS; j++, k++ ) {
			botSelectInfo.pics[k].generic.type				= MTYPE_BITMAP;
			botSelectInfo.pics[k].generic.flags				= QMF_LEFT_JUSTIFY|QMF_INACTIVE;
			botSelectInfo.pics[k].generic.x					= x;
			botSelectInfo.pics[k].generic.y					= y;
 			botSelectInfo.pics[k].generic.name				= botSelectInfo.boticons[k];
			botSelectInfo.pics[k].width						= 64;
			botSelectInfo.pics[k].height					= 64;
			botSelectInfo.pics[k].focuspic					= BOTSELECT_SELECTED;
			botSelectInfo.pics[k].focuscolor				= colorRed;

			botSelectInfo.picbuttons[k].generic.type		= MTYPE_BITMAP;
			botSelectInfo.picbuttons[k].generic.flags		= QMF_LEFT_JUSTIFY|QMF_NODEFAULTINIT|QMF_PULSEIFFOCUS;
			botSelectInfo.picbuttons[k].generic.callback	= UI_BotSelectMenu_BotEvent;
			botSelectInfo.picbuttons[k].generic.id			= k;
			botSelectInfo.picbuttons[k].generic.x			= x - 16;
			botSelectInfo.picbuttons[k].generic.y			= y - 16;
			botSelectInfo.picbuttons[k].generic.left		= x;
			botSelectInfo.picbuttons[k].generic.top			= y;
			botSelectInfo.picbuttons[k].generic.right		= x + 64;
			botSelectInfo.picbuttons[k].generic.bottom		= y + 64;
			botSelectInfo.picbuttons[k].width				= 128;
			botSelectInfo.picbuttons[k].height				= 128;
			botSelectInfo.picbuttons[k].focuspic			= BOTSELECT_SELECT;
			botSelectInfo.picbuttons[k].focuscolor			= colorRed;

			botSelectInfo.picnames[k].generic.type			= MTYPE_TEXT;
			botSelectInfo.picnames[k].generic.flags			= QMF_SMALLFONT;
			botSelectInfo.picnames[k].generic.x				= x + 32;
			botSelectInfo.picnames[k].generic.y				= y + 64;
			botSelectInfo.picnames[k].string				= botSelectInfo.botnames[k];
			botSelectInfo.picnames[k].color					= color_orange;
			botSelectInfo.picnames[k].style					= UI_CENTER|UI_SMALLFONT;

			x += (64 + 6);
		}
		y += (64 + SMALLCHAR_HEIGHT + 6);
	}

	botSelectInfo.arrows.generic.type		= MTYPE_BITMAP;
	botSelectInfo.arrows.generic.name		= BOTSELECT_ARROWS;
	botSelectInfo.arrows.generic.flags		= QMF_INACTIVE;
	botSelectInfo.arrows.generic.x			= 260;
	botSelectInfo.arrows.generic.y			= 440;
	botSelectInfo.arrows.width				= 128;
	botSelectInfo.arrows.height				= 32;

	botSelectInfo.left.generic.type			= MTYPE_BITMAP;
	botSelectInfo.left.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
	botSelectInfo.left.generic.callback		= UI_BotSelectMenu_LeftEvent;
	botSelectInfo.left.generic.x			= 260;
	botSelectInfo.left.generic.y			= 440;
	botSelectInfo.left.width  				= 64;
	botSelectInfo.left.height  				= 32;
	botSelectInfo.left.focuspic				= BOTSELECT_ARROWSL;

	botSelectInfo.right.generic.type	    = MTYPE_BITMAP;
	botSelectInfo.right.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
	botSelectInfo.right.generic.callback	= UI_BotSelectMenu_RightEvent;
	botSelectInfo.right.generic.x			= 321;
	botSelectInfo.right.generic.y			= 440;
	botSelectInfo.right.width  				= 64;
	botSelectInfo.right.height  		    = 32;
	botSelectInfo.right.focuspic			= BOTSELECT_ARROWSR;

	botSelectInfo.back.generic.type		= MTYPE_BITMAP;
	botSelectInfo.back.generic.name		= BOTSELECT_BACK0;
	botSelectInfo.back.generic.flags	= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
	botSelectInfo.back.generic.callback	= UI_BotSelectMenu_BackEvent;
	botSelectInfo.back.generic.x		= 0;
	botSelectInfo.back.generic.y		= 480-64;
	botSelectInfo.back.width			= 128;
	botSelectInfo.back.height			= 64;
	botSelectInfo.back.focuspic			= BOTSELECT_BACK1;

	botSelectInfo.go.generic.type		= MTYPE_BITMAP;
	botSelectInfo.go.generic.name		= BOTSELECT_ACCEPT0;
	botSelectInfo.go.generic.flags		= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
	botSelectInfo.go.generic.callback	= UI_BotSelectMenu_SelectEvent;
	botSelectInfo.go.generic.x			= 640;
	botSelectInfo.go.generic.y			= 480-64;
	botSelectInfo.go.width				= 128;
	botSelectInfo.go.height				= 64;
	botSelectInfo.go.focuspic			= BOTSELECT_ACCEPT1;

	Menu_AddItem( &botSelectInfo.menu, &botSelectInfo.banner );
	for( i = 0; i < MAX_MODELSPERPAGE; i++ ) {
		Menu_AddItem( &botSelectInfo.menu,	&botSelectInfo.pics[i] );
		Menu_AddItem( &botSelectInfo.menu,	&botSelectInfo.picbuttons[i] );
		Menu_AddItem( &botSelectInfo.menu,	&botSelectInfo.picnames[i] );
	}
	Menu_AddItem( &botSelectInfo.menu, &botSelectInfo.arrows );
	Menu_AddItem( &botSelectInfo.menu, &botSelectInfo.left );
	Menu_AddItem( &botSelectInfo.menu, &botSelectInfo.right );
	Menu_AddItem( &botSelectInfo.menu, &botSelectInfo.back );
	Menu_AddItem( &botSelectInfo.menu, &botSelectInfo.go );

	UI_BotSelectMenu_BuildList();
	UI_BotSelectMenu_Default( bot );
	botSelectInfo.modelpage = botSelectInfo.selectedmodel / MAX_MODELSPERPAGE;
	UI_BotSelectMenu_UpdateGrid();
}


/*
=================
UI_BotSelectMenu
=================
*/
void UI_BotSelectMenu( char *bot ) {
	UI_BotSelectMenu_Init( bot );
	UI_PushMenu( &botSelectInfo.menu );
}



/*
=============================================================================

JUHOX: ADVANCED OPTIONS MENU *****

=============================================================================
*/


#define ADVOPT_BACK0			"menu/art/back_0"
#define ADVOPT_BACK1			"menu/art/back_1"

#define ADVOPTIONS_X 400
#define ADVOPTIONS_MAINMENU_SPACING 60

#define ID_ADVOPT_GAME		100
#define ID_ADVOPT_EQUIPMENT	101
#define ID_ADVOPT_MONSTERS	102

typedef struct {
	menuframework_s	menu;

	menutext_s		banner;

	menutext_s		game;
	menutext_s		equipment;
	menutext_s		monsters;

	menubitmap_s	back;
} advancedOptionsMainInfo_t;

typedef struct {
	menuframework_s	    menu;

	menutext_s		    banner;

	menufield_s			respawnDelay;
	menuradiobutton_s	respawnAtPOD;
	menuradiobutton_s	tss;
	menuradiobutton_s	tssSafetyMode;
	menuradiobutton_s	stamina;
	menufield_s			baseHealth;
	menuradiobutton_s	noItems;
	menuradiobutton_s	noHealthRegen;
	menuradiobutton_s	armorFragments;
	menuradiobutton_s	skipEndSequence;
	menuradiobutton_s	scoreMode;
	menuradiobutton_s	challengingEnv;

	menubitmap_s	back;
} advancedOptionsGameInfo_t;

typedef struct {
	menuframework_s	menu;

	menutext_s		banner;

	menuradiobutton_s	cloakingDevice;
	menufield_s			weaponLimit;
	menuradiobutton_s	unlimitedAmmo;
	menulist_s			grapple;
	menufield_s			lightningDamageLimit;
	menuradiobutton_s	monsterLauncher;
	menufield_s			maxMonstersPP;

	menubitmap_s	back;
} advancedOptionsEquipmentInfo_t;

typedef struct {
	menuframework_s	menu;

	menutext_s		banner;

	menufield_s			minMonsters;
	menufield_s			maxMonsters;
	menufield_s			monstersPerTrap;
	menufield_s			monsterSpawnDelay;
	menufield_s			monsterHealthScale;
	menufield_s			monsterProgression;
	menufield_s			monsterGuards;
	menufield_s			monsterTitans;
	menuradiobutton_s	monsterBreeding;
	menutext_s			monsterModel1;
	menutext_s			monsterModel2;
	menutext_s			monsterModel3;
	menufield_s			monsterLoad;


	menubitmap_s	back;
} advancedOptionsMonstersInfo_t;


static advancedOptionsMainInfo_t		advOptMainInfo;
static advancedOptionsGameInfo_t		advOptGameInfo;
static advancedOptionsEquipmentInfo_t	advOptEquipInfo;
static advancedOptionsMonstersInfo_t	advOptMonInfo;

static const char *hookMode_items[] = {
	"disabled",
	"classic",
	"tool",
	"anchor",
	"combat",
	0
};



/*
=============================================================================
JUHOX: ADVANCED OPTIONS MENU ***** GAME
=============================================================================
*/

/*
=================
JUHOX: UI_AdvOptGameMenu_SetMenuItems
=================
*/
static void UI_AdvOptGameMenu_SetMenuItems(void) {
	Com_sprintf(advOptGameInfo.respawnDelay.field.buffer, 4, "%d", s_serveroptions.respawnDelay);
	advOptGameInfo.respawnAtPOD.curvalue = s_serveroptions.respawnAtPOD;
	advOptGameInfo.tss.curvalue = s_serveroptions.tss;
	advOptGameInfo.tssSafetyMode.curvalue = s_serveroptions.tssSafetyMode;
	advOptGameInfo.stamina.curvalue = s_serveroptions.stamina;
	Com_sprintf(advOptGameInfo.baseHealth.field.buffer, 5, "%d", s_serveroptions.baseHealth);
	advOptGameInfo.noItems.curvalue = s_serveroptions.noItems;
	advOptGameInfo.noHealthRegen.curvalue = s_serveroptions.noHealthRegen;
	advOptGameInfo.armorFragments.curvalue = s_serveroptions.armorFragments;
	advOptGameInfo.skipEndSequence.curvalue = s_serveroptions.skipEndSequence;
	advOptGameInfo.scoreMode.curvalue = s_serveroptions.scoreMode;
	advOptGameInfo.challengingEnv.curvalue = s_serveroptions.challengingEnv;

}

/*
=================
JUHOX: UI_AdvOptGameMenu_BackEvent
=================
*/
static void UI_AdvOptGameMenu_BackEvent(void* ptr, int event) {
	if (event != QM_ACTIVATED) return;

	s_serveroptions.respawnDelay = (int)Com_Clamp(0, 999, atoi(advOptGameInfo.respawnDelay.field.buffer));
	s_serveroptions.respawnAtPOD = advOptGameInfo.respawnAtPOD.curvalue;
	s_serveroptions.tss = advOptGameInfo.tss.curvalue;
	s_serveroptions.tssSafetyMode = advOptGameInfo.tssSafetyMode.curvalue;
	s_serveroptions.stamina = advOptGameInfo.stamina.curvalue;
	s_serveroptions.baseHealth = (int)Com_Clamp(1, 1000, atoi(advOptGameInfo.baseHealth.field.buffer));
	s_serveroptions.noItems = advOptGameInfo.noItems.curvalue;
	s_serveroptions.noHealthRegen = advOptGameInfo.noHealthRegen.curvalue;
	s_serveroptions.armorFragments = advOptGameInfo.armorFragments.curvalue;
	s_serveroptions.skipEndSequence = advOptGameInfo.skipEndSequence.curvalue;
	s_serveroptions.scoreMode = advOptGameInfo.scoreMode.curvalue;
	s_serveroptions.challengingEnv = advOptGameInfo.challengingEnv.curvalue;

	UI_PopMenu();
}

/*
=================
JUHOX: UI_AdvOptGameMenu_RespawnDelayStatusBar
=================
*/
static void UI_AdvOptGameMenu_RespawnDelayStatusBar(void* ptr) {
	UI_DrawString(320, 440, "in seconds", UI_CENTER|UI_SMALLFONT, colorWhite);
}

/*
=================
JUHOX: UI_AdvOptGameMenu_TSSStatusBar
TSS = Tactical Support System
=================
*/
static void UI_AdvOptGameMenu_TSSStatusBar(void* ptr) {
#if !TSSINCVAR
	if (advOptGameInfo.tss.curvalue) {
		UI_DrawString(320, 440, "NOTE: TSS only on unpure servers!", UI_CENTER|UI_SMALLFONT, colorWhite);
	}
#endif
}

/*
=================
JUHOX: UI_AdvOptGameMenu_ChallEnvStatusBar
=================
*/
static void UI_AdvOptGameMenu_ChallEnvStatusBar(void* ptr) {
	UI_DrawString(
		320, 440, "Enable/disable parts that have been marked as \"possibly frustrating\"",
		UI_CENTER|UI_SMALLFONT, colorWhite
	);
}


/*
=================
JUHOX: UI_AdvOptGameMenu_Init
=================
*/
static void UI_AdvOptGameMenu_Init(void) {
	int y;

	memset(&advOptGameInfo, 0, sizeof(advOptGameInfo));
	advOptGameInfo.menu.wrapAround = qtrue;
	advOptGameInfo.menu.fullscreen = qtrue;

	advOptGameInfo.banner.generic.type	= MTYPE_BTEXT;
	advOptGameInfo.banner.generic.x		= 320;
	advOptGameInfo.banner.generic.y		= 16;
	advOptGameInfo.banner.string		= "ADVANCED OPTIONS";
	advOptGameInfo.banner.color			= color_white;
	advOptGameInfo.banner.style			= UI_CENTER;
	Menu_AddItem(&advOptGameInfo.menu, &advOptGameInfo.banner);

	y =	80;

	advOptGameInfo.baseHealth.generic.type			= MTYPE_FIELD;
	advOptGameInfo.baseHealth.generic.name			= "Base Health:";
	advOptGameInfo.baseHealth.generic.flags			= QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	advOptGameInfo.baseHealth.generic.x				= ADVOPTIONS_X;
	advOptGameInfo.baseHealth.generic.y				= y;
	advOptGameInfo.baseHealth.field.widthInChars	= 5;
	advOptGameInfo.baseHealth.field.maxchars		= 4;
	if (gtmpl.tksBasehealth == TKS_fixedValue) advOptGameInfo.baseHealth.generic.flags |= QMF_GRAYED;
	Menu_AddItem(&advOptGameInfo.menu, &advOptGameInfo.baseHealth);
	y += BIGCHAR_HEIGHT+2;

	if (s_serveroptions.gametype == GT_EFH) {
		advOptGameInfo.challengingEnv.generic.type			= MTYPE_RADIOBUTTON;
		advOptGameInfo.challengingEnv.generic.name			= "Challenging Environment:";
		advOptGameInfo.challengingEnv.generic.flags			= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
		advOptGameInfo.challengingEnv.generic.x				= ADVOPTIONS_X;
		advOptGameInfo.challengingEnv.generic.y				= y;
		advOptGameInfo.challengingEnv.generic.statusbar		= UI_AdvOptGameMenu_ChallEnvStatusBar;
		if (gtmpl.tksChallengingEnv == TKS_fixedValue) advOptGameInfo.challengingEnv.generic.flags |= QMF_GRAYED;
		Menu_AddItem(&advOptGameInfo.menu, &advOptGameInfo.challengingEnv);
		y += BIGCHAR_HEIGHT+2;
	}

	if ( s_serveroptions.gametype != GT_TOURNAMENT && s_serveroptions.gametype != GT_EFH)
    {
		advOptGameInfo.respawnDelay.generic.type		= MTYPE_FIELD;
		advOptGameInfo.respawnDelay.generic.name		= "Respawn Delay:";
		advOptGameInfo.respawnDelay.generic.flags		= QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
		advOptGameInfo.respawnDelay.generic.x			= ADVOPTIONS_X;
		advOptGameInfo.respawnDelay.generic.y			= y;
		advOptGameInfo.respawnDelay.generic.statusbar	= UI_AdvOptGameMenu_RespawnDelayStatusBar;
		advOptGameInfo.respawnDelay.field.widthInChars	= 4;
		advOptGameInfo.respawnDelay.field.maxchars		= 3;
		if (gtmpl.tksRespawndelay == TKS_fixedValue) advOptGameInfo.respawnDelay.generic.flags |= QMF_GRAYED;
		Menu_AddItem(&advOptGameInfo.menu, &advOptGameInfo.respawnDelay);
		y += BIGCHAR_HEIGHT+2;
	}

	if ( s_serveroptions.gametype >= GT_TEAM &&	s_serveroptions.gametype < GT_STU )
    {
		advOptGameInfo.tss.generic.type			= MTYPE_RADIOBUTTON;
		advOptGameInfo.tss.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
		advOptGameInfo.tss.generic.x			= ADVOPTIONS_X;
		advOptGameInfo.tss.generic.y			= y;
		advOptGameInfo.tss.generic.name			= "Tactical Support System:";
		advOptGameInfo.tss.generic.statusbar	= UI_AdvOptGameMenu_TSSStatusBar;
		if (gtmpl.tksTss == TKS_fixedValue) advOptGameInfo.tss.generic.flags |= QMF_GRAYED;
		Menu_AddItem(&advOptGameInfo.menu, &advOptGameInfo.tss);
		y += BIGCHAR_HEIGHT+2;

		advOptGameInfo.tssSafetyMode.generic.type	= MTYPE_RADIOBUTTON;
		advOptGameInfo.tssSafetyMode.generic.flags	= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
		advOptGameInfo.tssSafetyMode.generic.x		= ADVOPTIONS_X;
		advOptGameInfo.tssSafetyMode.generic.y		= y;
		advOptGameInfo.tssSafetyMode.generic.name	= "Allow Mission Leader Safety Mode:";
		if (gtmpl.tksTsssafetymode == TKS_fixedValue) advOptGameInfo.tssSafetyMode.generic.flags |= QMF_GRAYED;
		Menu_AddItem(&advOptGameInfo.menu, &advOptGameInfo.tssSafetyMode);
		y += BIGCHAR_HEIGHT+2;
	}

	if (s_serveroptions.gametype >= GT_STU) {
		advOptGameInfo.scoreMode.generic.type	= MTYPE_RADIOBUTTON;
		advOptGameInfo.scoreMode.generic.name	= "Score Adapts To Monster Constitution:";
		advOptGameInfo.scoreMode.generic.flags	= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
		advOptGameInfo.scoreMode.generic.x		= ADVOPTIONS_X;
		advOptGameInfo.scoreMode.generic.y		= y;
		if (gtmpl.tksScoremode == TKS_fixedValue) advOptGameInfo.scoreMode.generic.flags |= QMF_GRAYED;
		Menu_AddItem(&advOptGameInfo.menu, &advOptGameInfo.scoreMode);
		y += BIGCHAR_HEIGHT+2;
	}


	advOptGameInfo.stamina.generic.type		= MTYPE_RADIOBUTTON;
	advOptGameInfo.stamina.generic.name		= "Limited Stamina:";
	advOptGameInfo.stamina.generic.flags	= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	advOptGameInfo.stamina.generic.x		= ADVOPTIONS_X;
	advOptGameInfo.stamina.generic.y		= y;
	if (gtmpl.tksStamina == TKS_fixedValue) advOptGameInfo.stamina.generic.flags |= QMF_GRAYED;
	Menu_AddItem(&advOptGameInfo.menu, &advOptGameInfo.stamina);
	y += BIGCHAR_HEIGHT+2;

	advOptGameInfo.noItems.generic.type		= MTYPE_RADIOBUTTON;
	advOptGameInfo.noItems.generic.name		= "No Items:";
	advOptGameInfo.noItems.generic.flags	= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	advOptGameInfo.noItems.generic.x		= ADVOPTIONS_X;
	advOptGameInfo.noItems.generic.y		= y;
	if (gtmpl.tksNoitems == TKS_fixedValue) advOptGameInfo.noItems.generic.flags |= QMF_GRAYED;
	Menu_AddItem(&advOptGameInfo.menu, &advOptGameInfo.noItems);
	y += BIGCHAR_HEIGHT+2;

	advOptGameInfo.noHealthRegen.generic.type	= MTYPE_RADIOBUTTON;
	advOptGameInfo.noHealthRegen.generic.name	= "Neither Health Nor Armour Regeneration:";
	advOptGameInfo.noHealthRegen.generic.flags	= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	advOptGameInfo.noHealthRegen.generic.x		= ADVOPTIONS_X;
	advOptGameInfo.noHealthRegen.generic.y		= y;
	if (gtmpl.tksNohealthregen == TKS_fixedValue) advOptGameInfo.noHealthRegen.generic.flags |= QMF_GRAYED;
	Menu_AddItem(&advOptGameInfo.menu, &advOptGameInfo.noHealthRegen);
	y += BIGCHAR_HEIGHT+2;

	advOptGameInfo.armorFragments.generic.type	= MTYPE_RADIOBUTTON;
	advOptGameInfo.armorFragments.generic.name	= "Generate Armour Fragments:";
	advOptGameInfo.armorFragments.generic.flags	= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	advOptGameInfo.armorFragments.generic.x		= ADVOPTIONS_X;
	advOptGameInfo.armorFragments.generic.y		= y;
	if (gtmpl.tksArmorfragments == TKS_fixedValue) advOptGameInfo.armorFragments.generic.flags |= QMF_GRAYED;
	Menu_AddItem(&advOptGameInfo.menu, &advOptGameInfo.armorFragments);
	y += BIGCHAR_HEIGHT+2;

	if (s_serveroptions.gametype == GT_CTF) {
		advOptGameInfo.respawnAtPOD.generic.type	= MTYPE_RADIOBUTTON;
		advOptGameInfo.respawnAtPOD.generic.name	= "Allow Respawn At Place Of Death:";
		advOptGameInfo.respawnAtPOD.generic.flags	= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
		advOptGameInfo.respawnAtPOD.generic.x		= ADVOPTIONS_X;
		advOptGameInfo.respawnAtPOD.generic.y		= y;
		if (gtmpl.tksRespawnatpod == TKS_fixedValue) advOptGameInfo.respawnAtPOD.generic.flags |= QMF_GRAYED;
		Menu_AddItem(&advOptGameInfo.menu, &advOptGameInfo.respawnAtPOD);
		y += BIGCHAR_HEIGHT+2;
	}

	if (s_serveroptions.gametype == GT_STU) {
		advOptGameInfo.skipEndSequence.generic.type		= MTYPE_RADIOBUTTON;
		advOptGameInfo.skipEndSequence.generic.name		= "Skip End Sequence";
		advOptGameInfo.skipEndSequence.generic.flags	= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
		advOptGameInfo.skipEndSequence.generic.x		= ADVOPTIONS_X;
		advOptGameInfo.skipEndSequence.generic.y		= y;
		Menu_AddItem(&advOptGameInfo.menu, &advOptGameInfo.skipEndSequence);
		y += BIGCHAR_HEIGHT+2;
	}

	advOptGameInfo.back.generic.type		= MTYPE_BITMAP;
	advOptGameInfo.back.generic.name		= ADVOPT_BACK0;
	advOptGameInfo.back.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
	advOptGameInfo.back.generic.callback	= UI_AdvOptGameMenu_BackEvent;
	advOptGameInfo.back.generic.x			= 0;
	advOptGameInfo.back.generic.y			= 480-64;
	advOptGameInfo.back.width				= 128;
	advOptGameInfo.back.height				= 64;
	advOptGameInfo.back.focuspic			= ADVOPT_BACK1;
	Menu_AddItem(&advOptGameInfo.menu, &advOptGameInfo.back);

	UI_AdvOptGameMenu_SetMenuItems();
}

/*
=================
JUHOX: UI_AdvOptGameMenu
=================
*/
static void UI_AdvOptGameMenu(void) {
	UI_AdvOptGameMenu_Init();
	UI_PushMenu(&advOptGameInfo.menu);
}









/*
=============================================================================
JUHOX: ADVANCED OPTIONS MENU ***** EQUIPMENT
=============================================================================
*/

/*
=================
JUHOX: UI_AdvOptEquipMenu_SetMenuItems
=================
*/
static void UI_AdvOptEquipMenu_SetMenuItems(void) {
	advOptEquipInfo.cloakingDevice.curvalue = s_serveroptions.cloakingDevice;
	Com_sprintf(advOptEquipInfo.weaponLimit.field.buffer, 5, "%d", s_serveroptions.weaponLimit);
	advOptEquipInfo.unlimitedAmmo.curvalue = s_serveroptions.unlimitedAmmo;
	Com_sprintf(advOptEquipInfo.lightningDamageLimit.field.buffer, 5, "%d", s_serveroptions.lightningDamageLimit);
	advOptEquipInfo.grapple.curvalue = s_serveroptions.grapple;
	advOptEquipInfo.monsterLauncher.curvalue = s_serveroptions.monsterLauncher;
	Com_sprintf(advOptEquipInfo.maxMonstersPP.field.buffer, 5, "%d", s_serveroptions.maxMonstersPerPlayer);
}

/*
=================
JUHOX: UI_AdvOptEquipMenu_BackEvent
=================
*/
static void UI_AdvOptEquipMenu_BackEvent(void* ptr, int event) {
	if (event != QM_ACTIVATED) return;

	s_serveroptions.cloakingDevice = advOptEquipInfo.cloakingDevice.curvalue;
	s_serveroptions.weaponLimit = (int) Com_Clamp(0, MAX_WEAPONS, atoi(advOptEquipInfo.weaponLimit.field.buffer));
	s_serveroptions.unlimitedAmmo = advOptEquipInfo.unlimitedAmmo.curvalue;
	s_serveroptions.lightningDamageLimit = (int)Com_Clamp(0, 999, atoi(advOptEquipInfo.lightningDamageLimit.field.buffer));
	s_serveroptions.grapple = advOptEquipInfo.grapple.curvalue;
	s_serveroptions.monsterLauncher = advOptEquipInfo.monsterLauncher.curvalue;
	s_serveroptions.maxMonstersPerPlayer = (int) Com_Clamp(1, MAX_MONSTERS, atoi(advOptEquipInfo.maxMonstersPP.field.buffer));

	UI_PopMenu();
}

/*
=================
JUHOX: UI_AdvOptEquipMenu_LDLStatusBar
LDL = Lightning gun Damage Limit
=================
*/
static void UI_AdvOptEquipMenu_LDLStatusBar(void* ptr) {
	UI_DrawString(320, 440, "0 = no limit", UI_CENTER|UI_SMALLFONT, colorWhite);
}

/*
=================
JUHOX: UI_AdvOptEquipMenu_MaxMonPPStatusBar
=================
*/
static void UI_AdvOptEquipMenu_MaxMonPPStatusBar(void* ptr) {
	UI_DrawString(320, 440, va("1 ... %d", MAX_MONSTERS), UI_CENTER|UI_SMALLFONT, colorWhite);
	UI_DrawString(320, 460, "limits the capacity of the monster launcher", UI_CENTER|UI_SMALLFONT, colorWhite);
}

/*
=================
JUHOX: UI_AdvOptEquipMenu_MaxWeapStatusBar
=================
*/
static void UI_AdvOptEquipMenu_MaxWeapStatusBar(void* ptr) {
	UI_DrawString(320, 440, "0 = no limit", UI_CENTER|UI_SMALLFONT, colorWhite);
}

/*
=================
JUHOX: UI_AdvOptEquipMenu_Init
=================
*/
static void UI_AdvOptEquipMenu_Init(void) {
	int y;

	memset(&advOptEquipInfo, 0, sizeof(advOptEquipInfo));
	advOptEquipInfo.menu.wrapAround = qtrue;
	advOptEquipInfo.menu.fullscreen = qtrue;

	advOptEquipInfo.banner.generic.type	= MTYPE_BTEXT;
	advOptEquipInfo.banner.generic.x	= 320;
	advOptEquipInfo.banner.generic.y	= 16;
	advOptEquipInfo.banner.string		= "ADVANCED OPTIONS";
	advOptEquipInfo.banner.color		= color_white;
	advOptEquipInfo.banner.style		= UI_CENTER;
	Menu_AddItem(&advOptEquipInfo.menu, &advOptEquipInfo.banner);

	y =	80;

	advOptEquipInfo.cloakingDevice.generic.type			= MTYPE_RADIOBUTTON;
	advOptEquipInfo.cloakingDevice.generic.name			= "Cloaking Device:";
	advOptEquipInfo.cloakingDevice.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	advOptEquipInfo.cloakingDevice.generic.x			= ADVOPTIONS_X;
	advOptEquipInfo.cloakingDevice.generic.y			= y;
	Menu_AddItem(&advOptEquipInfo.menu, &advOptEquipInfo.cloakingDevice);
	if (gtmpl.tksCloakingdevice == TKS_fixedValue) advOptEquipInfo.cloakingDevice.generic.flags |= QMF_GRAYED;
	y += BIGCHAR_HEIGHT+2;

	advOptEquipInfo.weaponLimit.generic.type			= MTYPE_FIELD;
	advOptEquipInfo.weaponLimit.generic.name			= "Max. # of Weapons per Player:";
	advOptEquipInfo.weaponLimit.generic.flags			= QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	advOptEquipInfo.weaponLimit.generic.x				= ADVOPTIONS_X;
	advOptEquipInfo.weaponLimit.generic.y				= y;
	advOptEquipInfo.weaponLimit.field.widthInChars		= 3;
	advOptEquipInfo.weaponLimit.field.maxchars			= 2;
	advOptEquipInfo.weaponLimit.generic.statusbar		= UI_AdvOptEquipMenu_MaxWeapStatusBar;
	Menu_AddItem(&advOptEquipInfo.menu, &advOptEquipInfo.weaponLimit);
	y += BIGCHAR_HEIGHT+2;

	advOptEquipInfo.unlimitedAmmo.generic.type			= MTYPE_RADIOBUTTON;
	advOptEquipInfo.unlimitedAmmo.generic.name			= "Unlimited Ammunition:";
	advOptEquipInfo.unlimitedAmmo.generic.flags			= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	advOptEquipInfo.unlimitedAmmo.generic.x				= ADVOPTIONS_X;
	advOptEquipInfo.unlimitedAmmo.generic.y				= y;
	Menu_AddItem(&advOptEquipInfo.menu, &advOptEquipInfo.unlimitedAmmo);
	if (gtmpl.tksUnlimitedammo == TKS_fixedValue) advOptEquipInfo.unlimitedAmmo.generic.flags |= QMF_GRAYED;
	y += BIGCHAR_HEIGHT+2;

	if (s_serveroptions.gametype < GT_STU) {
		advOptEquipInfo.monsterLauncher.generic.type	= MTYPE_RADIOBUTTON;
		advOptEquipInfo.monsterLauncher.generic.flags	= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
		advOptEquipInfo.monsterLauncher.generic.x		= ADVOPTIONS_X;
		advOptEquipInfo.monsterLauncher.generic.y		= y;
		advOptEquipInfo.monsterLauncher.generic.name	= "Monster Launcher:";
		if (gtmpl.tksMonsterlauncher == TKS_fixedValue) advOptEquipInfo.monsterLauncher.generic.flags |= QMF_GRAYED;
		Menu_AddItem(&advOptEquipInfo.menu, &advOptEquipInfo.monsterLauncher);
		y += BIGCHAR_HEIGHT+2;

		advOptEquipInfo.maxMonstersPP.generic.type			= MTYPE_FIELD;
		advOptEquipInfo.maxMonstersPP.generic.name			= "Max. # of Monsters per Player:";
		advOptEquipInfo.maxMonstersPP.generic.flags			= QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
		advOptEquipInfo.maxMonstersPP.generic.x				= ADVOPTIONS_X;
		advOptEquipInfo.maxMonstersPP.generic.y				= y;
		advOptEquipInfo.maxMonstersPP.field.widthInChars	= 4;
		advOptEquipInfo.maxMonstersPP.field.maxchars		= 3;
		advOptEquipInfo.maxMonstersPP.generic.statusbar		= UI_AdvOptEquipMenu_MaxMonPPStatusBar;
		Menu_AddItem(&advOptEquipInfo.menu, &advOptEquipInfo.maxMonstersPP);
		y += BIGCHAR_HEIGHT+2;
	}


	if (s_serveroptions.gametype != GT_EFH)
	{
		advOptEquipInfo.grapple.generic.type	= MTYPE_SPINCONTROL;
		advOptEquipInfo.grapple.generic.name	= "Grappling Hook Mode:";
		advOptEquipInfo.grapple.generic.flags	= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
		advOptEquipInfo.grapple.generic.x		= ADVOPTIONS_X;
		advOptEquipInfo.grapple.generic.y		= y;
		advOptEquipInfo.grapple.itemnames		= hookMode_items;
		if (gtmpl.tksGrapple == TKS_fixedValue) advOptEquipInfo.grapple.generic.flags |= QMF_GRAYED;
		Menu_AddItem(&advOptEquipInfo.menu, &advOptEquipInfo.grapple);
		y += BIGCHAR_HEIGHT+2;
	}

	advOptEquipInfo.lightningDamageLimit.generic.type		= MTYPE_FIELD;
	advOptEquipInfo.lightningDamageLimit.generic.name		= "Lightning Gun Damage Limit [per Second]:";
	advOptEquipInfo.lightningDamageLimit.generic.flags		= QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	advOptEquipInfo.lightningDamageLimit.generic.x			= ADVOPTIONS_X;
	advOptEquipInfo.lightningDamageLimit.generic.y			= y;
	advOptEquipInfo.lightningDamageLimit.generic.statusbar	= UI_AdvOptEquipMenu_LDLStatusBar;
	advOptEquipInfo.lightningDamageLimit.field.widthInChars	= 4;
	advOptEquipInfo.lightningDamageLimit.field.maxchars		= 3;
	if (gtmpl.tksLightningdamagelimit == TKS_fixedValue) advOptEquipInfo.lightningDamageLimit.generic.flags |= QMF_GRAYED;
	Menu_AddItem(&advOptEquipInfo.menu, &advOptEquipInfo.lightningDamageLimit);
	y += BIGCHAR_HEIGHT+2;

	advOptEquipInfo.back.generic.type		= MTYPE_BITMAP;
	advOptEquipInfo.back.generic.name		= ADVOPT_BACK0;
	advOptEquipInfo.back.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
	advOptEquipInfo.back.generic.callback	= UI_AdvOptEquipMenu_BackEvent;
	advOptEquipInfo.back.generic.x			= 0;
	advOptEquipInfo.back.generic.y			= 480-64;
	advOptEquipInfo.back.width				= 128;
	advOptEquipInfo.back.height				= 64;
	advOptEquipInfo.back.focuspic			= ADVOPT_BACK1;
	Menu_AddItem(&advOptEquipInfo.menu, &advOptEquipInfo.back);

	UI_AdvOptEquipMenu_SetMenuItems();
}

/*
=================
JUHOX: UI_AdvOptEquipMenu
=================
*/
static void UI_AdvOptEquipMenu(void) {
	UI_AdvOptEquipMenu_Init();
	UI_PushMenu(&advOptEquipInfo.menu);
}








/*
=============================================================================
JUHOX: ADVANCED OPTIONS MENU ***** MONSTERS
=============================================================================
*/

/*
=================
JUHOX: UI_AdvOptMonMenu_SetMenuItems
=================
*/

static void UI_AdvOptMonMenu_SetMenuItems(void) {
	Com_sprintf(advOptMonInfo.minMonsters.field.buffer, 5, "%d", s_serveroptions.minMonsters);
	Com_sprintf(advOptMonInfo.maxMonsters.field.buffer, 5, "%d", s_serveroptions.maxMonsters);
	Com_sprintf(advOptMonInfo.monstersPerTrap.field.buffer, 5, "%d", s_serveroptions.monstersPerTrap);
	Com_sprintf(advOptMonInfo.monsterSpawnDelay.field.buffer, 8, "%.3f", s_serveroptions.monsterSpawnDelay / 1000.0);
	Com_sprintf(advOptMonInfo.monsterGuards.field.buffer, 5, "%d", s_serveroptions.monsterGuards);
	Com_sprintf(advOptMonInfo.monsterTitans.field.buffer, 5, "%d", s_serveroptions.monsterTitans);
	Com_sprintf(advOptMonInfo.monsterHealthScale.field.buffer, 5, "%d", s_serveroptions.monsterHealthScale);
	Com_sprintf(advOptMonInfo.monsterProgression.field.buffer, 5, "%d", s_serveroptions.monsterProgression);
	advOptMonInfo.monsterBreeding.curvalue = s_serveroptions.monsterBreeding;
	Com_sprintf(advOptMonInfo.monsterLoad.field.buffer, 5, "%d", s_serveroptions.monsterLoad);

}


/*
=================
JUHOX: UI_AdvOptMonMenu_BackEvent
=================
*/
static void UI_AdvOptMonMenu_BackEvent(void* ptr, int event) {
	if (event != QM_ACTIVATED) return;

	s_serveroptions.minMonsters = (int) Com_Clamp(0, MAX_MONSTERS, atoi(advOptMonInfo.minMonsters.field.buffer));
	s_serveroptions.maxMonsters = (int) Com_Clamp(1, MAX_MONSTERS, atoi(advOptMonInfo.maxMonsters.field.buffer));
	s_serveroptions.monstersPerTrap = (int) Com_Clamp(0, MAX_MONSTERS, atoi(advOptMonInfo.monstersPerTrap.field.buffer));
	s_serveroptions.monsterSpawnDelay = (int) Com_Clamp(200, 999999, 1000 * atof(advOptMonInfo.monsterSpawnDelay.field.buffer));
	s_serveroptions.monsterGuards = (int) Com_Clamp(0, 100, atoi(advOptMonInfo.monsterGuards.field.buffer));
	s_serveroptions.monsterTitans = (int) Com_Clamp(0, 100, atoi(advOptMonInfo.monsterTitans.field.buffer));
	s_serveroptions.monsterHealthScale = (int) Com_Clamp(1, 1000, atoi(advOptMonInfo.monsterHealthScale.field.buffer));
	s_serveroptions.monsterProgression = (int) Com_Clamp(0, 1000, atoi(advOptMonInfo.monsterProgression.field.buffer));
	s_serveroptions.monsterBreeding = advOptMonInfo.monsterBreeding.curvalue;
	s_serveroptions.monsterLoad = (int) Com_Clamp(0, 1000, atoi(advOptMonInfo.monsterLoad.field.buffer));

	UI_PopMenu();
}


/*
=================
JUHOX: UI_AdvOptMonMenu_MonsterModel_Draw

derived from PlayerName_Draw()
=================
*/
static void UI_AdvOptMonMenu_MonsterModel_Draw(void* item) {
	menutext_s* s;
	float* color;
	int x, y;
	int style;
	qboolean focus;

	s = (menutext_s*) item;

	x = s->generic.x;
	y =	s->generic.y;

	style = UI_SMALLFONT;
	focus = (s->generic.parent->cursor == s->generic.menuPosition);

	if (s->generic.flags & QMF_GRAYED)
	{
		color = text_color_disabled;
	}
	else if (focus)
	{
		color = text_color_highlight;
		style |= UI_PULSE;
	}
	else if (s->generic.flags & QMF_BLINK)
	{
		color = text_color_highlight;
		style |= UI_BLINK;
	}
	else
	{
		color = text_color_normal;
	}

	if (focus)
	{
		// draw cursor
		UI_FillRect(s->generic.left, s->generic.top, s->generic.right-s->generic.left+1, s->generic.bottom-s->generic.top+1, listbar_color);
		UI_DrawChar(x, y, 13, UI_CENTER|UI_BLINK|UI_SMALLFONT, color);
	}

	UI_DrawString(x - SMALLCHAR_WIDTH, y, s->generic.name, style|UI_RIGHT, color);
	UI_DrawString(x + SMALLCHAR_WIDTH, y, s->string, style|UI_LEFT, color);
}


/*
=================
JUHOX: UI_AdvOptMonMenu_PredatorModel_Callback
=================
*/
static void UI_AdvOptMonMenu_PredatorModel_Callback(void* ptr, int event) {
	if (event != QM_ACTIVATED) return;

	UI_PlayerModelMenu(
		"PREDATOR MODEL", "",
		NULL, NULL, NULL, NULL,
		s_serveroptions.monsterModel1, sizeof(s_serveroptions.monsterModel1),
		WP_NONE
	);
}


/*
=================
JUHOX: UI_AdvOptMonMenu_GuardModel_Callback
=================
*/
static void UI_AdvOptMonMenu_GuardModel_Callback(void* ptr, int event) {
	if (event != QM_ACTIVATED) return;

	UI_PlayerModelMenu(
		"GUARD MODEL", "",
		NULL, NULL, NULL, NULL,
		s_serveroptions.monsterModel2, sizeof(s_serveroptions.monsterModel2),
		WP_ROCKET_LAUNCHER
	);
}


/*
=================
JUHOX: UI_AdvOptMonMenu_TitansModel_Callback
=================
*/
static void UI_AdvOptMonMenu_TitansModel_Callback(void* ptr, int event) {
	if (event != QM_ACTIVATED) return;

	UI_PlayerModelMenu(
		"TITANS MODEL", "",
		NULL, NULL, NULL, NULL,
		s_serveroptions.monsterModel3, sizeof(s_serveroptions.monsterModel3),
		WP_NONE
	);
}


/*
=================
JUHOX: UI_AdvOptMonMenu_MinMonStatusBar
=================
*/
static void UI_AdvOptMonMenu_MinMonStatusBar(void* ptr) {
	UI_DrawString(320, 440, va("0 ... %d", MAX_MONSTERS), UI_CENTER|UI_SMALLFONT, colorWhite);
}


/*
=================
JUHOX: UI_AdvOptMonMenu_MaxMonStatusBar
=================
*/
static void UI_AdvOptMonMenu_MaxMonStatusBar(void* ptr) {
	UI_DrawString(320, 440, va("1 ... %d", MAX_MONSTERS), UI_CENTER|UI_SMALLFONT, colorWhite);
	if (s_serveroptions.gametype < GT_STU) {
		UI_DrawString(320, 460, "all players get an equal share of this", UI_CENTER|UI_SMALLFONT, colorWhite);
	}
}


/*
=================
JUHOX: UI_AdvOptMonMenu_MonLoadStatusBar
=================
*/
static void UI_AdvOptMonMenu_MonLoadStatusBar(void* ptr) {
	UI_DrawString(320, 440, "0% ... 1000%", UI_CENTER|UI_SMALLFONT, colorWhite);
}


/*
=================
JUHOX: UI_AdvOptMonMenu_MSDStatusBar
MSD = Monster Spawn Delay
=================
*/
static void UI_AdvOptMonMenu_MSDStatusBar(void* ptr) {
	UI_DrawString(320, 440, "0.2 ... 999 seconds", UI_CENTER|UI_SMALLFONT, colorWhite);
}


/*
=================
JUHOX: UI_AdvOptMonMenu_GuardsStatusBar
=================
*/
static void UI_AdvOptMonMenu_GuardsStatusBar(void* ptr) {
	UI_DrawString(320, 440, "0 ... 100%", UI_CENTER|UI_SMALLFONT, colorWhite);
}


/*
=================
JUHOX: UI_AdvOptMonMenu_MonHealthStatusBar
=================
*/
static void UI_AdvOptMonMenu_MonHealthStatusBar(void* ptr) {
	UI_DrawString(320, 440, "1% ... 1000% (\"very easy\" ... \"very hard\")", UI_CENTER|UI_SMALLFONT, colorWhite);
}


/*
=================
JUHOX: UI_AdvOptMonMenu_MonProgStatusBar
=================
*/
static void UI_AdvOptMonMenu_MonProgStatusBar(void* ptr) {
	UI_DrawString(320, 440, "0 ... 1000 (\"very easy\" ... \"very hard\")", UI_CENTER|UI_SMALLFONT, colorWhite);
}


/*
=================
JUHOX: UI_AdvOptMonMenu_Init
=================
*/
static void UI_AdvOptMonMenu_Init(void) {
	int y;

	memset(&advOptMonInfo, 0, sizeof(advOptMonInfo));
	advOptMonInfo.menu.wrapAround = qtrue;
	advOptMonInfo.menu.fullscreen = qtrue;

	advOptMonInfo.banner.generic.type	= MTYPE_BTEXT;
	advOptMonInfo.banner.generic.x		= 320;
	advOptMonInfo.banner.generic.y		= 16;
	advOptMonInfo.banner.string			= "ADVANCED OPTIONS";
	advOptMonInfo.banner.color			= color_white;
	advOptMonInfo.banner.style			= UI_CENTER;
	Menu_AddItem(&advOptMonInfo.menu, &advOptMonInfo.banner);

	y =	80;

	if (s_serveroptions.gametype == GT_STU) {
		advOptMonInfo.minMonsters.generic.type			= MTYPE_FIELD;
		advOptMonInfo.minMonsters.generic.name			= "Min. # of Monsters:";
		advOptMonInfo.minMonsters.generic.flags			= QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
		advOptMonInfo.minMonsters.generic.x				= ADVOPTIONS_X;
		advOptMonInfo.minMonsters.generic.y				= y;
		advOptMonInfo.minMonsters.field.widthInChars	= 4;
		advOptMonInfo.minMonsters.field.maxchars		= 3;
		advOptMonInfo.minMonsters.generic.statusbar	= UI_AdvOptMonMenu_MinMonStatusBar;
		if (gtmpl.tksMinmonsters == TKS_fixedValue) advOptMonInfo.minMonsters.generic.flags |= QMF_GRAYED;
		Menu_AddItem(&advOptMonInfo.menu, &advOptMonInfo.minMonsters);
		y += BIGCHAR_HEIGHT+2;
	}

	if (s_serveroptions.gametype != GT_EFH)

	{
		advOptMonInfo.maxMonsters.generic.type			= MTYPE_FIELD;
		advOptMonInfo.maxMonsters.generic.name			= "Max. # of Monsters:";
		advOptMonInfo.maxMonsters.generic.flags			= QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
		advOptMonInfo.maxMonsters.generic.x				= ADVOPTIONS_X;
		advOptMonInfo.maxMonsters.generic.y				= y;
		advOptMonInfo.maxMonsters.field.widthInChars	= 4;
		advOptMonInfo.maxMonsters.field.maxchars		= 3;
		advOptMonInfo.maxMonsters.generic.statusbar	= UI_AdvOptMonMenu_MaxMonStatusBar;
		if (gtmpl.tksMaxmonsters == TKS_fixedValue) advOptMonInfo.maxMonsters.generic.flags |= QMF_GRAYED;
		Menu_AddItem(&advOptMonInfo.menu, &advOptMonInfo.maxMonsters);
		y += BIGCHAR_HEIGHT+2;
	}

	if (s_serveroptions.gametype == GT_EFH) {
		advOptMonInfo.monsterLoad.generic.type			= MTYPE_FIELD;
		advOptMonInfo.monsterLoad.generic.name			= "Monster Load [%]:";
		advOptMonInfo.monsterLoad.generic.flags			= QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
		advOptMonInfo.monsterLoad.generic.x				= ADVOPTIONS_X;
		advOptMonInfo.monsterLoad.generic.y				= y;
		advOptMonInfo.monsterLoad.field.widthInChars	= 4;
		advOptMonInfo.monsterLoad.field.maxchars		= 3;
		advOptMonInfo.monsterLoad.generic.statusbar	= UI_AdvOptMonMenu_MonLoadStatusBar;
		if (gtmpl.tksMonsterload == TKS_fixedValue) advOptMonInfo.monsterLoad.generic.flags |= QMF_GRAYED;
		Menu_AddItem(&advOptMonInfo.menu, &advOptMonInfo.monsterLoad);
		y += BIGCHAR_HEIGHT+2;
	}

	if (s_serveroptions.gametype == GT_STU) {
		advOptMonInfo.monstersPerTrap.generic.type			= MTYPE_FIELD;
		advOptMonInfo.monstersPerTrap.generic.name			= "# of Monsters Spawned on Artefacts:";
		advOptMonInfo.monstersPerTrap.generic.flags			= QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
		advOptMonInfo.monstersPerTrap.generic.x				= ADVOPTIONS_X;
		advOptMonInfo.monstersPerTrap.generic.y				= y;
		advOptMonInfo.monstersPerTrap.field.widthInChars	= 4;
		advOptMonInfo.monstersPerTrap.field.maxchars		= 3;
		advOptMonInfo.monstersPerTrap.generic.statusbar	= UI_AdvOptMonMenu_MinMonStatusBar;
		if (gtmpl.tksMonsterspertrap == TKS_fixedValue) advOptMonInfo.monstersPerTrap.generic.flags |= QMF_GRAYED;
		Menu_AddItem(&advOptMonInfo.menu, &advOptMonInfo.monstersPerTrap);
		y += BIGCHAR_HEIGHT+2;

		advOptMonInfo.monsterSpawnDelay.generic.type		= MTYPE_FIELD;
		advOptMonInfo.monsterSpawnDelay.generic.name		= "Monster Spawn Delay:";
		advOptMonInfo.monsterSpawnDelay.generic.flags		= QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
		advOptMonInfo.monsterSpawnDelay.generic.x			= ADVOPTIONS_X;
		advOptMonInfo.monsterSpawnDelay.generic.y			= y;
		advOptMonInfo.monsterSpawnDelay.field.widthInChars	= 8;
		advOptMonInfo.monsterSpawnDelay.field.maxchars		= 7;
		advOptMonInfo.monsterSpawnDelay.generic.statusbar	= UI_AdvOptMonMenu_MSDStatusBar;
		if (gtmpl.tksMonsterspawndelay == TKS_fixedValue) advOptMonInfo.monsterSpawnDelay.generic.flags |= QMF_GRAYED;
		Menu_AddItem(&advOptMonInfo.menu, &advOptMonInfo.monsterSpawnDelay);
		y += BIGCHAR_HEIGHT+2;
	}

	advOptMonInfo.monsterHealthScale.generic.type			= MTYPE_FIELD;
	advOptMonInfo.monsterHealthScale.generic.name			= "Monster Constitution [%]:";
	advOptMonInfo.monsterHealthScale.generic.flags			= QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	advOptMonInfo.monsterHealthScale.generic.x				= ADVOPTIONS_X;
	advOptMonInfo.monsterHealthScale.generic.y				= y;
	advOptMonInfo.monsterHealthScale.field.widthInChars		= 5;
	advOptMonInfo.monsterHealthScale.field.maxchars			= 4;
	advOptMonInfo.monsterHealthScale.generic.statusbar		= UI_AdvOptMonMenu_MonHealthStatusBar;
	if (gtmpl.tksMonsterhealthscale == TKS_fixedValue) advOptMonInfo.monsterHealthScale.generic.flags |= QMF_GRAYED;
	Menu_AddItem(&advOptMonInfo.menu, &advOptMonInfo.monsterHealthScale);
	y += BIGCHAR_HEIGHT+2;

	if ( s_serveroptions.gametype == GT_STU	|| s_serveroptions.gametype == GT_EFH ) {
		advOptMonInfo.monsterProgression.generic.type			= MTYPE_FIELD;
		advOptMonInfo.monsterProgression.generic.name			= "Monster Constitution Progression [%/min]:";
		advOptMonInfo.monsterProgression.generic.flags			= QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
		advOptMonInfo.monsterProgression.generic.x				= ADVOPTIONS_X;
		advOptMonInfo.monsterProgression.generic.y				= y;
		advOptMonInfo.monsterProgression.field.widthInChars		= 5;
		advOptMonInfo.monsterProgression.field.maxchars			= 4;
		advOptMonInfo.monsterProgression.generic.statusbar		= UI_AdvOptMonMenu_MonProgStatusBar;
		if (gtmpl.tksMonsterprogessivehealth == TKS_fixedValue) advOptMonInfo.monsterProgression.generic.flags |= QMF_GRAYED;
		Menu_AddItem(&advOptMonInfo.menu, &advOptMonInfo.monsterProgression);
		y += BIGCHAR_HEIGHT+2;
	}

	if (s_serveroptions.gametype == GT_STU) {
		advOptMonInfo.monsterBreeding.generic.type		= MTYPE_RADIOBUTTON;
		advOptMonInfo.monsterBreeding.generic.name		= "Predators Breeding Monsters:";
		advOptMonInfo.monsterBreeding.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
		advOptMonInfo.monsterBreeding.generic.x			= ADVOPTIONS_X;
		advOptMonInfo.monsterBreeding.generic.y			= y;
		if (gtmpl.tksMonsterbreeding == TKS_fixedValue) advOptMonInfo.monsterBreeding.generic.flags |= QMF_GRAYED;
		Menu_AddItem(&advOptMonInfo.menu, &advOptMonInfo.monsterBreeding);
		y += BIGCHAR_HEIGHT+2;
	}

	advOptMonInfo.monsterModel1.generic.type		= MTYPE_TEXT;
	advOptMonInfo.monsterModel1.generic.name		= "Monster Model \"Predator\":";
	advOptMonInfo.monsterModel1.generic.flags		= QMF_SMALLFONT;
	advOptMonInfo.monsterModel1.generic.x			= ADVOPTIONS_X;
	advOptMonInfo.monsterModel1.generic.y			= y;
	advOptMonInfo.monsterModel1.generic.callback	= UI_AdvOptMonMenu_PredatorModel_Callback;
	advOptMonInfo.monsterModel1.generic.ownerdraw	= UI_AdvOptMonMenu_MonsterModel_Draw;
	advOptMonInfo.monsterModel1.color				= color_orange;
	advOptMonInfo.monsterModel1.style				= UI_SMALLFONT;
	advOptMonInfo.monsterModel1.string				= s_serveroptions.monsterModel1;
	advOptMonInfo.monsterModel1.generic.top			= advOptMonInfo.monsterModel1.generic.y;
	advOptMonInfo.monsterModel1.generic.bottom		= advOptMonInfo.monsterModel1.generic.y + SMALLCHAR_HEIGHT;
	advOptMonInfo.monsterModel1.generic.left		= advOptMonInfo.monsterModel1.generic.x - (strlen(advOptMonInfo.monsterModel1.generic.name)+1) * SMALLCHAR_WIDTH;
	advOptMonInfo.monsterModel1.generic.right		= advOptMonInfo.monsterModel1.generic.x + 32 * SMALLCHAR_WIDTH;
	Menu_AddItem(&advOptMonInfo.menu, &advOptMonInfo.monsterModel1);
	advOptMonInfo.monsterModel1.generic.flags &= ~QMF_INACTIVE;
	y += BIGCHAR_HEIGHT+2;

	if (s_serveroptions.gametype >= GT_STU) {
		advOptMonInfo.monsterModel2.generic.type		= MTYPE_TEXT;
		advOptMonInfo.monsterModel2.generic.name		= "Monster Model \"Guard\":";
		advOptMonInfo.monsterModel2.generic.flags		= QMF_SMALLFONT;
		advOptMonInfo.monsterModel2.generic.x			= ADVOPTIONS_X;
		advOptMonInfo.monsterModel2.generic.y			= y;
		advOptMonInfo.monsterModel2.generic.callback	= UI_AdvOptMonMenu_GuardModel_Callback;
		advOptMonInfo.monsterModel2.generic.ownerdraw	= UI_AdvOptMonMenu_MonsterModel_Draw;
		advOptMonInfo.monsterModel2.color				= color_orange;
		advOptMonInfo.monsterModel2.style				= UI_SMALLFONT;
		advOptMonInfo.monsterModel2.string				= s_serveroptions.monsterModel2;
		advOptMonInfo.monsterModel2.generic.top			= advOptMonInfo.monsterModel2.generic.y;
		advOptMonInfo.monsterModel2.generic.bottom		= advOptMonInfo.monsterModel2.generic.y + SMALLCHAR_HEIGHT;
		advOptMonInfo.monsterModel2.generic.left		= advOptMonInfo.monsterModel2.generic.x - (strlen(advOptMonInfo.monsterModel2.generic.name)+1) * SMALLCHAR_WIDTH;
		advOptMonInfo.monsterModel2.generic.right		= advOptMonInfo.monsterModel2.generic.x + 32 * SMALLCHAR_WIDTH;
		Menu_AddItem(&advOptMonInfo.menu, &advOptMonInfo.monsterModel2);
		advOptMonInfo.monsterModel2.generic.flags &= ~QMF_INACTIVE;
		y += BIGCHAR_HEIGHT+2;

		advOptMonInfo.monsterModel3.generic.type		= MTYPE_TEXT;
		advOptMonInfo.monsterModel3.generic.name		= "Monster Model \"Titan\":";
		advOptMonInfo.monsterModel3.generic.flags		= QMF_SMALLFONT;
		advOptMonInfo.monsterModel3.generic.x			= ADVOPTIONS_X;
		advOptMonInfo.monsterModel3.generic.y			= y;
		advOptMonInfo.monsterModel3.generic.callback	= UI_AdvOptMonMenu_TitansModel_Callback;
		advOptMonInfo.monsterModel3.generic.ownerdraw	= UI_AdvOptMonMenu_MonsterModel_Draw;
		advOptMonInfo.monsterModel3.color				= color_orange;
		advOptMonInfo.monsterModel3.style				= UI_SMALLFONT;
		advOptMonInfo.monsterModel3.string				= s_serveroptions.monsterModel3;
		advOptMonInfo.monsterModel3.generic.top			= advOptMonInfo.monsterModel3.generic.y;
		advOptMonInfo.monsterModel3.generic.bottom		= advOptMonInfo.monsterModel3.generic.y + SMALLCHAR_HEIGHT;
		advOptMonInfo.monsterModel3.generic.left		= advOptMonInfo.monsterModel3.generic.x - (strlen(advOptMonInfo.monsterModel3.generic.name)+1) * SMALLCHAR_WIDTH;
		advOptMonInfo.monsterModel3.generic.right		= advOptMonInfo.monsterModel3.generic.x + 32 * SMALLCHAR_WIDTH;
		Menu_AddItem(&advOptMonInfo.menu, &advOptMonInfo.monsterModel3);
		advOptMonInfo.monsterModel3.generic.flags &= ~QMF_INACTIVE;
		y += BIGCHAR_HEIGHT+2;

		advOptMonInfo.monsterGuards.generic.type		= MTYPE_FIELD;
		advOptMonInfo.monsterGuards.generic.name		= "Avg. Part of Monsters Spawning as Guards [%]:";
		advOptMonInfo.monsterGuards.generic.flags		= QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
		advOptMonInfo.monsterGuards.generic.x			= ADVOPTIONS_X;
		advOptMonInfo.monsterGuards.generic.y			= y;
		advOptMonInfo.monsterGuards.field.widthInChars	= 4;
		advOptMonInfo.monsterGuards.field.maxchars		= 3;
		advOptMonInfo.monsterGuards.generic.statusbar	= UI_AdvOptMonMenu_GuardsStatusBar;
		if (gtmpl.tksGuards == TKS_fixedValue) advOptMonInfo.monsterGuards.generic.flags |= QMF_GRAYED;
		Menu_AddItem(&advOptMonInfo.menu, &advOptMonInfo.monsterGuards);
		y += BIGCHAR_HEIGHT+2;

		advOptMonInfo.monsterTitans.generic.type		= MTYPE_FIELD;
		advOptMonInfo.monsterTitans.generic.name		= "Avg. Part of Monsters Spawning as Titans [%]:";
		advOptMonInfo.monsterTitans.generic.flags		= QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
		advOptMonInfo.monsterTitans.generic.x			= ADVOPTIONS_X;
		advOptMonInfo.monsterTitans.generic.y			= y;
		advOptMonInfo.monsterTitans.field.widthInChars	= 4;
		advOptMonInfo.monsterTitans.field.maxchars		= 3;
		advOptMonInfo.monsterTitans.generic.statusbar	= UI_AdvOptMonMenu_GuardsStatusBar;
		if (gtmpl.tksTitans == TKS_fixedValue) advOptMonInfo.monsterTitans.generic.flags |= QMF_GRAYED;
		Menu_AddItem(&advOptMonInfo.menu, &advOptMonInfo.monsterTitans);
		y += BIGCHAR_HEIGHT+2;
	}


	advOptMonInfo.back.generic.type		= MTYPE_BITMAP;
	advOptMonInfo.back.generic.name		= ADVOPT_BACK0;
	advOptMonInfo.back.generic.flags	= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
	advOptMonInfo.back.generic.callback	= UI_AdvOptMonMenu_BackEvent;
	advOptMonInfo.back.generic.x		= 0;
	advOptMonInfo.back.generic.y		= 480-64;
	advOptMonInfo.back.width			= 128;
	advOptMonInfo.back.height			= 64;
	advOptMonInfo.back.focuspic			= ADVOPT_BACK1;
	Menu_AddItem(&advOptMonInfo.menu, &advOptMonInfo.back);

	UI_AdvOptMonMenu_SetMenuItems();
}


/*
=================
JUHOX: UI_AdvOptMonMenu
=================
*/
static void UI_AdvOptMonMenu(void) {
	UI_AdvOptMonMenu_Init();
	UI_PushMenu(&advOptMonInfo.menu);
}



/*
=============================================================================
JUHOX: ADVANCED OPTIONS MENU ***** MAIN
=============================================================================
*/

/*
=================
JUHOX: UI_AdvOptMainMenu_Cache
=================
*/
void UI_AdvOptMainMenu_Cache(void) {
	trap_R_RegisterShaderNoMip(ADVOPT_BACK0);
	trap_R_RegisterShaderNoMip(ADVOPT_BACK1);
}

/*
=================
JUHOX: UI_AdvOptMainMenu_BackEvent
=================
*/
void UI_AdvOptMainMenu_BackEvent(void* ptr, int event) {
	if (event != QM_ACTIVATED) return;

	UI_PopMenu();
}

/*
=================
JUHOX: UI_AdvOptMainMenu_Event
=================
*/
static void UI_AdvOptMainMenu_Event(void* ptr, int event) {
	if (event != QM_ACTIVATED) return;

	switch (((menucommon_s *)ptr)->id) {
	case ID_ADVOPT_GAME:
		UI_AdvOptGameMenu();
		break;
	case ID_ADVOPT_EQUIPMENT:
		UI_AdvOptEquipMenu();
		break;
	case ID_ADVOPT_MONSTERS:
		UI_AdvOptMonMenu();
		break;
	}
}
/*
=================
JUHOX: UI_AdvOptMainMenu_Init
=================
*/
static void UI_AdvOptMainMenu_Init(void) {
	int y;

	memset(&advOptMainInfo, 0, sizeof(advOptMainInfo));
	advOptMainInfo.menu.wrapAround = qtrue;
	advOptMainInfo.menu.fullscreen = qtrue;

	UI_AdvOptMainMenu_Cache();

	advOptMainInfo.banner.generic.type	= MTYPE_BTEXT;
	advOptMainInfo.banner.generic.x		= 320;
	advOptMainInfo.banner.generic.y		= 16;
	advOptMainInfo.banner.string		= "ADVANCED OPTIONS";
	advOptMainInfo.banner.color			= color_white;
	advOptMainInfo.banner.style			= UI_CENTER;
	Menu_AddItem(&advOptMainInfo.menu, &advOptMainInfo.banner);

	y = 180;

	advOptMainInfo.game.generic.type		= MTYPE_PTEXT;
	advOptMainInfo.game.generic.x			= 320;
	advOptMainInfo.game.generic.y			= y;
	advOptMainInfo.game.generic.flags		= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	advOptMainInfo.game.generic.id			= ID_ADVOPT_GAME;
	advOptMainInfo.game.generic.callback	= UI_AdvOptMainMenu_Event;
	advOptMainInfo.game.color				= color_red;
	advOptMainInfo.game.style				= UI_CENTER|UI_DROPSHADOW;
	advOptMainInfo.game.string				= "GAMEPLAY";
	Menu_AddItem(&advOptMainInfo.menu, &advOptMainInfo.game);
	y += ADVOPTIONS_MAINMENU_SPACING;

	advOptMainInfo.equipment.generic.type		= MTYPE_PTEXT;
	advOptMainInfo.equipment.generic.x			= 320;
	advOptMainInfo.equipment.generic.y			= y;
	advOptMainInfo.equipment.generic.flags		= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	advOptMainInfo.equipment.generic.id			= ID_ADVOPT_EQUIPMENT;
	advOptMainInfo.equipment.generic.callback	= UI_AdvOptMainMenu_Event;
	advOptMainInfo.equipment.color				= color_red;
	advOptMainInfo.equipment.style				= UI_CENTER|UI_DROPSHADOW;
	advOptMainInfo.equipment.string				= "EQUIPMENT";
	Menu_AddItem(&advOptMainInfo.menu, &advOptMainInfo.equipment);
	y += ADVOPTIONS_MAINMENU_SPACING;

	advOptMainInfo.monsters.generic.type		= MTYPE_PTEXT;
	advOptMainInfo.monsters.generic.x			= 320;
	advOptMainInfo.monsters.generic.y			= y;
	advOptMainInfo.monsters.generic.flags		= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	advOptMainInfo.monsters.generic.id			= ID_ADVOPT_MONSTERS;
	advOptMainInfo.monsters.generic.callback	= UI_AdvOptMainMenu_Event;
	advOptMainInfo.monsters.color				= color_red;
	advOptMainInfo.monsters.style				= UI_CENTER|UI_DROPSHADOW;
	advOptMainInfo.monsters.string				= "MONSTERS";
	Menu_AddItem(&advOptMainInfo.menu, &advOptMainInfo.monsters);
	y += ADVOPTIONS_MAINMENU_SPACING;

	advOptMainInfo.back.generic.type		= MTYPE_BITMAP;
	advOptMainInfo.back.generic.name		= ADVOPT_BACK0;
	advOptMainInfo.back.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
	advOptMainInfo.back.generic.callback	= UI_AdvOptMainMenu_BackEvent;
	advOptMainInfo.back.generic.x			= 0;
	advOptMainInfo.back.generic.y			= 480-64;
	advOptMainInfo.back.width				= 128;
	advOptMainInfo.back.height				= 64;
	advOptMainInfo.back.focuspic			= ADVOPT_BACK1;
	Menu_AddItem(&advOptMainInfo.menu, &advOptMainInfo.back);
}

/*
=================
JUHOX: UI_AdvOptMenu
=================
*/
void UI_AdvOptMenu(void) {
	UI_AdvOptMainMenu_Init();
	UI_PushMenu(&advOptMainInfo.menu);
}


/*
=============================================================================

JUHOX: TEMPLATES MENU *****

=============================================================================
*/

#define TEMPL_BACK0			"menu/art/back_0"
#define TEMPL_BACK1			"menu/art/back_1"
#define TEMPL_NEXT0			"menu/art/next_0"
#define TEMPL_NEXT1			"menu/art/next_1"
#define TEMPL_VOTE0			"menu/art/vote_0"
#define TEMPL_VOTE1			"menu/art/vote_1"
#define TEMPL_DEL0			"menu/art/delete_0"
#define TEMPL_DEL1			"menu/art/delete_1"
#define TEMPL_SAVE0			"menu/art/save_0"
#define TEMPL_SAVE1			"menu/art/save_1"
#define TEMPL_ARROWS		"menu/art/gs_arrows_0"
#define TEMPL_ARROWSL		"menu/art/gs_arrows_l"
#define TEMPL_ARROWSR		"menu/art/gs_arrows_r"

#define NUM_TEMPLATES_PER_PAGE 14

typedef struct {
	menuframework_s	menu;

	menutext_s		banner;

	menufield_s		name;
	char			oldName[256];

	menulist_s remote;

	menutext_s		page;
	menubitmap_s	arrows;
	menubitmap_s	prevpage;
	menubitmap_s	nextpage;

	menubitmap_s	back;
	menubitmap_s	next;
	menubitmap_s	del;
	menubitmap_s	save;

	menuaction_s	templateLine[NUM_TEMPLATES_PER_PAGE];

	char error[128];
	int errorTime;
	qboolean inGame;
	qboolean multiplayer;
	qboolean remoteServer;
	gametemplatelist_t svList;
	gametemplatelist_t* currentList;
	int firstTemplate;
	int savedFirstTemplate;
	int selectedTemplate;
	int gametype;
	char highscoreLine1[256];
	char highscoreLine2[MAX_STRING_CHARS];
	int highscoreLineSetTime;
	long svlistChecksum;
	char allChecksums[MAX_GAMETEMPLATES];
	int lastMsgTime;
	qboolean isActive;
	qboolean errorDetected;
} templateInfo_t;

static templateInfo_t templateInfo;

static const char* remote_items[] = {
	"local templates",
	"server's templates",
	0
};


/*
=================
JUHOX: UI_TemplateMenu_Error
=================
*/
static void UI_TemplateMenu_Error(const char* msg) {
	Q_strncpyz(templateInfo.error, msg, sizeof(templateInfo.error));
	templateInfo.errorTime = uis.realtime + 5000;
}

/*
=================
JUHOX: UI_SendTemplateListCommand
=================
*/
static int tmplcmdCounter;
static void UI_SendTemplateListCommand(const char* cmd) {
	tmplcmdCounter++;
	tmplcmdCounter &= 15;

	trap_Cvar_Set("tmplcmd", va("%c%s", tmplcmdCounter + 'A', cmd));
	templateInfo.lastMsgTime = uis.realtime;
}

/*
=================
JUHOX: UI_Send_TemplateList_Request
=================
*/
static void UI_Send_TemplateList_Request(void) {
	if (templateInfo.inGame && templateInfo.remoteServer) {
		UI_SendTemplateListCommand(
			va("templatelist_request %d %d\n", templateInfo.svList.numEntries, templateInfo.svlistChecksum)
		);
	}
}

/*
=================
JUHOX: UI_Send_TemplateList_Stop
=================
*/
static void UI_Send_TemplateList_Stop(void) {
	if (templateInfo.inGame && templateInfo.remoteServer) UI_SendTemplateListCommand("templatelist_stop\n");
}

/*
=================
JUHOX: UI_Send_TemplateList_Error
=================
*/
static void UI_Send_TemplateList_Error(void) {
	if (templateInfo.inGame && templateInfo.remoteServer) {
		char checksums[MAX_STRING_CHARS];
		int i;

		for (i = 0; i < templateInfo.svList.numEntries; i++) {
			checksums[i] = templateInfo.allChecksums[i];
		}
		if (i == 0) checksums[i++] = '*';
		checksums[i] = 0;

		UI_SendTemplateListCommand(va("templatelist_error \"%s\"", checksums));
	}
}

/*
=================
JUHOX: UI_TemplateMenu_Exit
=================
*/
static void UI_TemplateMenu_Exit(void) {
	trap_Cvar_Set("tmplcmd", "");
	templateInfo.isActive = qfalse;
}

/*
=================
JUHOX: UI_TemplateMenu_ComputeChecksums
=================
*/
static void UI_TemplateMenu_ComputeChecksums(void) {
	int i;

	memset(templateInfo.allChecksums, '*', sizeof(templateInfo.allChecksums));

	templateInfo.svlistChecksum = 0;
	for (i = 0; i < templateInfo.svList.numEntries; i++) {
		char info[MAX_INFO_STRING];
		char name[64];
		int highscoreType;
		char highscore[32];
		char descriptor[MAX_INFO_STRING];
		long checksum;

		trap_Cvar_VariableStringBuffer(templateInfo.svList.entries[i].cvar, info, sizeof(info));
		Q_strncpyz(name, Info_ValueForKey(info, "name"), sizeof(name));
		highscoreType = atoi(Info_ValueForKey(info, "ht"));
		Q_strncpyz(highscore, Info_ValueForKey(info, "h"), sizeof(highscore));
		Q_strncpyz(descriptor, Info_ValueForKey(info, "d"), sizeof(descriptor));
		checksum = BG_TemplateChecksum(name, highscoreType, highscore, descriptor);
		templateInfo.svlistChecksum += checksum;
		templateInfo.allChecksums[i] = BG_ChecksumChar(checksum);
	}
}

/*
=================
JUHOX: UI_TemplateMenu_InitTemplates
=================
*/
static void UI_TemplateMenu_InitTemplates(void) {
	if (uis.templateList.numEntries <= 0) {
		BG_GetGameTemplateList(&uis.templateList, uis.numTemplateFiles, uis.templateFileList, qtrue);
	}
	templateInfo.remoteServer = !trap_Cvar_VariableValue("sv_running");
	if (templateInfo.inGame && templateInfo.remoteServer) {
		BG_GetGameTemplateList(&templateInfo.svList, 0, NULL, qtrue);
		UI_TemplateMenu_ComputeChecksums();
		UI_Send_TemplateList_Request();
		templateInfo.currentList = &templateInfo.svList;
	}
	else {
		templateInfo.currentList = &uis.templateList;
	}
}

/*
=================
JUHOX: UI_TemplateMenu_Cache
=================
*/
static void UI_TemplateMenu_Cache(void) {
	trap_R_RegisterShaderNoMip(TEMPL_BACK0);
	trap_R_RegisterShaderNoMip(TEMPL_BACK1);
	if (templateInfo.inGame) {
		trap_R_RegisterShaderNoMip(TEMPL_VOTE0);
		trap_R_RegisterShaderNoMip(TEMPL_VOTE1);
		trap_R_RegisterShaderNoMip(TEMPL_SAVE0);
		trap_R_RegisterShaderNoMip(TEMPL_SAVE1);
	}
	else {
		trap_R_RegisterShaderNoMip(TEMPL_NEXT0);
		trap_R_RegisterShaderNoMip(TEMPL_NEXT1);
		trap_R_RegisterShaderNoMip(TEMPL_DEL0);
		trap_R_RegisterShaderNoMip(TEMPL_DEL1);
	}
}

/*
==================
JUHOX: HighscoreName
==================
*/
static const char* HighscoreName(const char* highscorename, const char* templatename) {
	static char name[256];
	int i;
	int len;

	Q_strncpyz(name, highscorename, sizeof(name));
	if (!name[0]) {
		Q_strncpyz(name, templatename, sizeof(name));
	}

	len = strlen(name);
	for (i = 0; i < len; i++) {
		if (name[i] >= 'a' && name[i] <= 'z') continue;
		if (name[i] >= 'A' && name[i] <= 'Z') continue;
		if (name[i] >= '0' && name[i] <= '9') continue;
		name[i] = '_';
	}
	return name;
}

/*
=================
JUHOX: UI_TemplateMenu_SetHighscore
=================
*/
static void UI_TemplateMenu_SetHighscore(void) {
	const char* templateVarName;
	char info[MAX_INFO_STRING];
	char highscoreVarName[64];
	int highscoreType;
	char highscore[32];
	char line1[256];
	char line2[MAX_INFO_STRING];
	char oldLine1[256];
	char oldLine2[MAX_STRING_CHARS];

	Q_strncpyz(oldLine1, templateInfo.highscoreLine1, sizeof(oldLine1));
	Q_strncpyz(oldLine2, templateInfo.highscoreLine2, sizeof(oldLine2));
	memset(templateInfo.highscoreLine1, 0, sizeof(templateInfo.highscoreLine1));
	memset(templateInfo.highscoreLine2, 0, sizeof(templateInfo.highscoreLine2));

	if (
		templateInfo.selectedTemplate < 0 ||
		templateInfo.selectedTemplate >= templateInfo.currentList->numEntries
	) {
		return;
	}

	templateVarName = templateInfo.currentList->entries[templateInfo.selectedTemplate].cvar;
	trap_Cvar_VariableStringBuffer(templateVarName, info, sizeof(info));
	highscoreType = atoi(Info_ValueForKey(info, "ht"));
	if (templateInfo.inGame && templateInfo.remoteServer) {
		Q_strncpyz(highscore, Info_ValueForKey(info, "h"), sizeof(highscore));
		Q_strncpyz(line2, Info_ValueForKey(info, "d"), sizeof(line2));
	}
	else {
		Q_strncpyz(highscoreVarName, HighscoreName(Info_ValueForKey(info, "hn"), templateVarName), sizeof(highscoreVarName));
		if (!highscoreVarName[0]) return;
		trap_Cvar_VariableStringBuffer(va("%s0", highscoreVarName), highscore, sizeof(highscore));
		trap_Cvar_VariableStringBuffer(va("%s1", highscoreVarName), line2, sizeof(line2));
	}
	switch (highscoreType) {
	case GC_score:
		if (highscore[0]) {
			Com_sprintf(line1, sizeof(line1), "HIGHSCORE %d", atoi(highscore));
		}
		else {
			Q_strncpyz(line1, "Play to set the first highscore!", sizeof(line1));
			line2[0] = 0;
		}
		break;
	case GC_time:
		if (highscore[0]) {
			int minutes, seconds, msecs;

			msecs = atoi(highscore);
			seconds = msecs / 1000;
			minutes = seconds / 60;
			Com_sprintf(
				line1, sizeof(line1), "RECORD TIME %d:%02d.%03d",
				minutes, seconds % 60, msecs % 1000
			);
		}
		else {
			Q_strncpyz(line1, "Play to set the first record time!", sizeof(line1));
			line2[0] = 0;
		}
		break;
	case GC_distance:
		if (highscore[0]) {
			int metres;

			metres = atoi(highscore);
			Com_sprintf(
				line1, sizeof(line1), "RECORD DISTANCE %d.%03dkm",
				metres / 1000, metres % 1000
			);
		}
		else {
			Q_strncpyz(line1, "Play to set the first record distance!", sizeof(line1));
			line2[0] = 0;
		}
		break;
	case GC_speed:
		if (highscore[0]) {
			int speed;

			speed = atoi(highscore);
			Com_sprintf(
				line1, sizeof(line1), "RECORD SPEED %d.%03d metres per minute",
				speed / 1000, speed % 1000
			);
		}
		else {
			Q_strncpyz(line1, "Play to set the first record speed!", sizeof(line1));
			line2[0] = 0;
		}
		break;
	default:
		return;
	}
	Q_strncpyz(templateInfo.highscoreLine1, line1, sizeof(templateInfo.highscoreLine1));
	Q_strncpyz(templateInfo.highscoreLine2, line2, sizeof(templateInfo.highscoreLine2));
	if (strcmp(line1, oldLine1) || strcmp(line2, oldLine2)) {
		templateInfo.highscoreLineSetTime = uis.realtime;
	}
}

/*
=================
JUHOX: UI_TemplateMenu_SetGametype
=================
*/
static void UI_TemplateMenu_SetGametype(void) {
	const char* templateVarName;
	char info[MAX_INFO_STRING];

	if (templateInfo.inGame) return;

	if (
		templateInfo.selectedTemplate < 0 ||
		templateInfo.selectedTemplate >= templateInfo.currentList->numEntries
	) {
		return;
	}

	templateVarName = templateInfo.currentList->entries[templateInfo.selectedTemplate].cvar;
	trap_Cvar_VariableStringBuffer(templateVarName, info, sizeof(info));

	templateInfo.gametype = atoi(Info_ValueForKey(info, "gt"));
}

/*
=================
JUHOX: UI_Template_SetMenuItems
=================
*/
static void UI_Template_SetMenuItems(void) {
	int i;
	static char pagename[32];

	if (!templateInfo.inGame) {
		templateInfo.currentList = &uis.templateList;
	}
	else if (templateInfo.remoteServer && templateInfo.remote.curvalue) {
		templateInfo.currentList = &templateInfo.svList;
	}
	else {
		templateInfo.currentList = &uis.templateList;
	}

	for (i = 0; i < NUM_TEMPLATES_PER_PAGE; i++)
	{
		int line;

		line = templateInfo.firstTemplate + i;

		if (line >= 0 && line < templateInfo.currentList->numEntries) {
			templateInfo.templateLine[i].generic.flags &= ~(QMF_INACTIVE|QMF_HIDDEN);

			if (templateInfo.inGame && templateInfo.remoteServer && !templateInfo.remote.curvalue) {
				templateInfo.templateLine[i].generic.flags |= QMF_GRAYED|QMF_INACTIVE;
			}
			else {
				templateInfo.templateLine[i].generic.flags &= ~(QMF_GRAYED|QMF_INACTIVE);
			}
		}
		else {
			templateInfo.templateLine[i].generic.flags |= QMF_INACTIVE|QMF_HIDDEN;
		}
	}

	if (
		templateInfo.selectedTemplate >= 0 &&
		templateInfo.selectedTemplate < templateInfo.currentList->numEntries &&
		templateInfo.currentList->entries[templateInfo.selectedTemplate].deletable &&
		NOT (
			templateInfo.inGame && templateInfo.remoteServer && !templateInfo.remote.curvalue
		)
	) {
		templateInfo.del.generic.flags &= ~(QMF_INACTIVE|QMF_HIDDEN);
	}
	else {
		templateInfo.del.generic.flags |= QMF_INACTIVE|QMF_HIDDEN;
	}

	if (templateInfo.inGame) {
		qboolean enable;

		enable = qfalse;
		if (
			templateInfo.name.field.buffer[0] &&
			Info_Validate(templateInfo.name.field.buffer)
		) {
			for (i = 0; i < uis.templateList.numEntries; i++) {
				if (!Q_stricmp(templateInfo.name.field.buffer, uis.templateList.entries[i].name)) break;
			}
			if (i >= uis.templateList.numEntries) enable = qtrue;
		}

		if (enable) {
			templateInfo.save.generic.flags &= ~(QMF_GRAYED|QMF_INACTIVE);
		}
		else {
			templateInfo.save.generic.flags |= (QMF_GRAYED|QMF_INACTIVE);
		}
	}

	if (
		templateInfo.currentList->numEntries > 0 &&
		NOT (
			templateInfo.inGame && templateInfo.remoteServer && !templateInfo.remote.curvalue
		)
	) {
		templateInfo.next.generic.flags &= ~(QMF_GRAYED|QMF_INACTIVE);
	}
	else {
		templateInfo.next.generic.flags |= QMF_GRAYED|QMF_INACTIVE;
	}

	Com_sprintf(
		pagename, sizeof(pagename), "Page %d/%d",
		templateInfo.firstTemplate / NUM_TEMPLATES_PER_PAGE + 1,
		templateInfo.currentList->numEntries <= 0?
			1 :
			(templateInfo.currentList->numEntries - 1) / NUM_TEMPLATES_PER_PAGE + 1
	);
	templateInfo.page.string = pagename;

	UI_TemplateMenu_SetHighscore();
	UI_TemplateMenu_SetGametype();
}

/*
=================
JUHOX: UI_TemplateMenu_BackEvent
=================
*/
static void UI_TemplateMenu_BackEvent(void* ptr, int event) {
	if (event != QM_ACTIVATED) return;

	UI_Send_TemplateList_Stop();
	UI_PopMenu();
	templateInfo.isActive = qfalse;
	//UI_TemplateMenu_Exit();
}

/*
=================
JUHOX: UI_TemplateMenu_DelEvent
=================
*/
static void UI_TemplateMenu_DelEvent(void* ptr, int event) {
	const char* templateVarName;

	if (event != QM_ACTIVATED) return;

	if (
		templateInfo.selectedTemplate < 0 ||
		templateInfo.selectedTemplate >= uis.templateList.numEntries
	) {
		return;
	}

	if (!uis.templateList.entries[templateInfo.selectedTemplate].deletable) return;

	templateVarName = uis.templateList.entries[templateInfo.selectedTemplate].cvar;

	{	// delete the highscore
		char info[MAX_INFO_STRING];
		char highscoreVarName[256];

		trap_Cvar_VariableStringBuffer(templateVarName, info, sizeof(info));
		Q_strncpyz(highscoreVarName, HighscoreName(Info_ValueForKey(info, "hn"), templateVarName), sizeof(highscoreVarName));
		if (highscoreVarName[0]) {
			trap_Cvar_Set(va("%s0", highscoreVarName), "");
			trap_Cvar_Set(va("%s1", highscoreVarName), "");
		}
	}

	trap_Cvar_Set(templateVarName, "");
	uis.templateList.numEntries = 0;
	UI_TemplateMenu_InitTemplates();

	if (templateInfo.selectedTemplate >= uis.templateList.numEntries) {
		templateInfo.selectedTemplate = uis.templateList.numEntries - 1;
	}
	if (templateInfo.selectedTemplate < 0) {
		templateInfo.selectedTemplate = 0;
	}
	if (templateInfo.firstTemplate >= uis.templateList.numEntries) {
		templateInfo.firstTemplate = uis.templateList.numEntries - 1;
	}
	if (templateInfo.firstTemplate < 0) {
		templateInfo.firstTemplate = 0;
	}

	UI_Template_SetMenuItems();
}

/*
=================
JUHOX: UI_TemplateMenu_SaveEvent
=================
*/
static void UI_TemplateMenu_SaveEvent(void* ptr, int event) {
	char gs[MAX_INFO_STRING];
	char info[MAX_INFO_STRING];
	int i;

	if (event != QM_ACTIVATED) return;

	trap_GetConfigString(CS_GAMESETTINGS, gs, sizeof(gs));

	Com_sprintf(info, sizeof(info), "name\\%s\\%s", templateInfo.name.field.buffer, gs);

	for (i = 0; i < MAX_GAMETEMPLATES; i++) {
		char buf[MAX_STRING_CHARS];
		char name[32];

		Com_sprintf(name, sizeof(name), "saved%03d", i);
		trap_Cvar_VariableStringBuffer(name, buf, sizeof(buf));
		if (!buf[0]) {
			trap_Cvar_Register(NULL, name, "", CVAR_ARCHIVE);
			trap_Cvar_Set(name, info);
			uis.templateList.numEntries = 0;
			UI_TemplateMenu_InitTemplates();
			UI_Template_SetMenuItems();
			return;
		}
	}
}

/*
=================
JUHOX: UI_TemplateMenu_NextEvent
=================
*/
static void UI_TemplateMenu_NextEvent(void* ptr, int event) {
	const char* templateVar;
	char info[MAX_INFO_STRING];

	if (event != QM_ACTIVATED) return;

	if (templateInfo.inGame) {
		UI_TemplateMenu_Exit();
		trap_Cmd_ExecuteText(
			EXEC_APPEND,
			va(
				"callvote template %d",
				templateInfo.currentList->entries[templateInfo.selectedTemplate].originalIndex
			)
		);
		UI_ForceMenuOff();
		return;
	}

	templateVar = templateInfo.currentList->entries[templateInfo.selectedTemplate].cvar;

	trap_Cvar_VariableStringBuffer(templateVar, info, sizeof(info));

	if (!BG_ParseGameTemplate(info, &gtmpl)) {
		UI_TemplateMenu_Error("Invalid template.");
		return;
	}

	if (gtmpl.mapName[0] && !UI_GetArenaInfoByMap(gtmpl.mapName)) {
		UI_TemplateMenu_Error(va("Unknown map '%s'.", gtmpl.mapName));
		return;
	}

	trap_Cvar_Set("g_template", templateVar);
	trap_Cvar_SetValue("g_gameType", gtmpl.gametype);

	Q_strncpyz(s_startserver.choosenmap, gtmpl.mapName, sizeof(s_startserver.choosenmap));
	Q_strncpyz(s_startserver.choosenmapname, gtmpl.mapName, sizeof(s_startserver.choosenmapname));
	Q_strupr(s_startserver.choosenmapname);

	if (gtmpl.tksArmorfragments) trap_Cvar_SetValue("g_armorFragments", gtmpl.armorfragments);
	if (gtmpl.tksBasehealth) trap_Cvar_SetValue("g_baseHealth", gtmpl.basehealth);
	if (gtmpl.tksStamina) trap_Cvar_SetValue("g_stamina", gtmpl.stamina);
	if (gtmpl.tksLightningdamagelimit) trap_Cvar_SetValue("g_lightningDamageLimit", gtmpl.lightningdamagelimit);
	if (gtmpl.tksDmflags) trap_Cvar_SetValue("dmflags", gtmpl.dmflags);
	if (gtmpl.tksSpeed) trap_Cvar_SetValue("g_speed", gtmpl.speed);
	if (gtmpl.tksKnockback) trap_Cvar_SetValue("g_knockback", gtmpl.knockback);
	if (gtmpl.tksGravity) trap_Cvar_SetValue("g_gravityLatch", gtmpl.gravity);
        else trap_Cvar_Set("g_gravityLatch", "");
	if (gtmpl.tksTsssafetymode) trap_Cvar_SetValue("tssSafetyModeAllowed", gtmpl.tsssafetymode);
	if (gtmpl.tksHighscoretype) trap_Cvar_SetValue("sv_pure", 1);
	if (gtmpl.tksGrapple) trap_Cvar_SetValue("g_grapple", gtmpl.grapple);
	if (gtmpl.tksScoremode) trap_Cvar_SetValue("g_scoreMode", gtmpl.scoremode);

	switch(gtmpl.gametype) {
	case GT_FFA:
	default:
		if (gtmpl.tksFraglimit) trap_Cvar_SetValue("ui_ffa_fraglimit", gtmpl.fraglimit);
		if (gtmpl.tksTimelimit) trap_Cvar_SetValue("ui_ffa_timelimit", gtmpl.timelimit);
		if (gtmpl.tksRespawndelay) trap_Cvar_SetValue("ui_ffa_respawndelay", gtmpl.respawndelay);
		if (gtmpl.tksGameseed) trap_Cvar_SetValue("ui_ffa_gameseed", gtmpl.gameseed);
		if (gtmpl.tksNoitems) trap_Cvar_SetValue("ui_ffa_noItems", gtmpl.noitems);
		if (gtmpl.tksNohealthregen) trap_Cvar_SetValue("ui_ffa_noHealthRegen", gtmpl.nohealthregen);
		if (gtmpl.tksCloakingdevice) trap_Cvar_SetValue("ui_ffa_cloakingDevice", gtmpl.cloakingdevice);
		if (gtmpl.tksUnlimitedammo) trap_Cvar_SetValue("ui_ffa_unlimitedAmmo", gtmpl.unlimitedammo);
		if (gtmpl.tksMonsterlauncher) trap_Cvar_SetValue("ui_ffa_monsterLauncher", gtmpl.monsterLauncher);
		break;

	case GT_TOURNAMENT:
		if (gtmpl.tksFraglimit) trap_Cvar_SetValue("ui_tourney_fraglimit", gtmpl.fraglimit);
		if (gtmpl.tksTimelimit) trap_Cvar_SetValue("ui_tourney_timelimit", gtmpl.timelimit);
		if (gtmpl.tksGameseed) trap_Cvar_SetValue("ui_tourney_gamessed", gtmpl.gameseed);
		if (gtmpl.tksNoitems) trap_Cvar_SetValue("ui_tourney_noItems", gtmpl.noitems);
		if (gtmpl.tksNohealthregen) trap_Cvar_SetValue("ui_tourney_noHealthRegen", gtmpl.nohealthregen);
		if (gtmpl.tksCloakingdevice) trap_Cvar_SetValue("ui_tourney_cloakingDevice", gtmpl.cloakingdevice);
		if (gtmpl.tksUnlimitedammo) trap_Cvar_SetValue("ui_tourney_unlimitedAmmo", gtmpl.unlimitedammo);
		if (gtmpl.tksMonsterlauncher) trap_Cvar_SetValue("ui_tourney_monsterLauncher", gtmpl.monsterLauncher);
		break;

	case GT_TEAM:
		if (gtmpl.tksFraglimit) trap_Cvar_SetValue("ui_team_fraglimit", gtmpl.fraglimit);
		if (gtmpl.tksTimelimit) trap_Cvar_SetValue("ui_team_timelimit", gtmpl.timelimit);
		if (gtmpl.tksFriendlyfire) trap_Cvar_SetValue("ui_team_friendly", gtmpl.friendlyfire);
		if (gtmpl.tksRespawndelay) trap_Cvar_SetValue("ui_team_respawndelay", gtmpl.respawndelay);
		if (gtmpl.tksGameseed) trap_Cvar_SetValue("ui_team_gameseed", gtmpl.gameseed);
		if (gtmpl.tksTss) trap_Cvar_SetValue("ui_team_tss", gtmpl.tss);
		if (gtmpl.tksNoitems) trap_Cvar_SetValue("ui_team_noItems", gtmpl.noitems);
		if (gtmpl.tksNohealthregen) trap_Cvar_SetValue("ui_team_noHealthRegen", gtmpl.nohealthregen);
		if (gtmpl.tksCloakingdevice) trap_Cvar_SetValue("ui_team_cloakingDevice", gtmpl.cloakingdevice);
		if (gtmpl.tksUnlimitedammo) trap_Cvar_SetValue("ui_team_unlimitedAmmo", gtmpl.unlimitedammo);
		if (gtmpl.tksMonsterlauncher) trap_Cvar_SetValue("ui_team_monsterLauncher", gtmpl.monsterLauncher);
		break;

	case GT_CTF:
		if (gtmpl.tksFraglimit) trap_Cvar_SetValue("ui_ctf_capturelimit", gtmpl.fraglimit);
		if (gtmpl.tksTimelimit) trap_Cvar_SetValue("ui_ctf_timelimit", gtmpl.timelimit);
		if (gtmpl.tksFriendlyfire) trap_Cvar_SetValue("ui_ctf_friendlyfire", gtmpl.friendlyfire);
		if (gtmpl.tksRespawndelay) trap_Cvar_SetValue("ui_ctf_respawndelay", gtmpl.respawndelay);
		if (gtmpl.tksGameseed) trap_Cvar_SetValue("ui_ctf_gameseed", gtmpl.gameseed);
		if (gtmpl.tksTss) trap_Cvar_SetValue("ui_ctf_tss", gtmpl.tss);
		if (gtmpl.tksNoitems) trap_Cvar_SetValue("ui_ctf_noItems", gtmpl.noitems);
		if (gtmpl.tksNohealthregen) trap_Cvar_SetValue("ui_ctf_noHealthRegen", gtmpl.nohealthregen);
		if (gtmpl.tksCloakingdevice) trap_Cvar_SetValue("ui_ctf_cloakingDevice", gtmpl.cloakingdevice);
		if (gtmpl.tksUnlimitedammo) trap_Cvar_SetValue("ui_ctf_unlimitedAmmo", gtmpl.unlimitedammo);
		if (gtmpl.tksMonsterlauncher) trap_Cvar_SetValue("ui_ctf_monsterLauncher", gtmpl.monsterLauncher);
		break;

	// JUHOX: set STU ui cvars
	case GT_STU:
		if (gtmpl.tksFraglimit) trap_Cvar_SetValue("ui_stu_fraglimit", gtmpl.fraglimit);
		if (gtmpl.tksTimelimit) trap_Cvar_SetValue("ui_stu_timelimit", gtmpl.timelimit);
		if (gtmpl.tksArtefacts) trap_Cvar_SetValue("ui_stu_artefacts", gtmpl.artefacts);
		if (gtmpl.tksFriendlyfire) trap_Cvar_SetValue("ui_stu_friendly", gtmpl.friendlyfire);
		if (gtmpl.tksRespawndelay) trap_Cvar_SetValue("ui_stu_respawndelay", gtmpl.respawndelay);
		if (gtmpl.tksGameseed) trap_Cvar_SetValue("ui_stu_gameseed", gtmpl.gameseed);
		if (gtmpl.tksNoitems) trap_Cvar_SetValue("ui_stu_noItems", gtmpl.noitems);
		if (gtmpl.tksNohealthregen) trap_Cvar_SetValue("ui_stu_noHealthRegen", gtmpl.nohealthregen);
		if (gtmpl.tksCloakingdevice) trap_Cvar_SetValue("ui_stu_cloakingDevice", gtmpl.cloakingdevice);
		if (gtmpl.tksUnlimitedammo) trap_Cvar_SetValue("ui_stu_unlimitedAmmo", gtmpl.unlimitedammo);

		if (gtmpl.tksMinmonsters) trap_Cvar_SetValue("ui_stu_minmonsters", gtmpl.minmonsters);
		if (gtmpl.tksMaxmonsters) trap_Cvar_SetValue("ui_stu_maxmonsters", gtmpl.maxmonsters);
		if (gtmpl.tksMonsterspertrap) trap_Cvar_SetValue("ui_stu_monstersPerTrap", gtmpl.monsterspertrap);
		if (gtmpl.tksMonsterspawndelay) trap_Cvar_SetValue("ui_stu_monsterSpawnDelay", gtmpl.monsterspawndelay);
		if (gtmpl.tksMonsterhealthscale) trap_Cvar_SetValue("ui_stu_monsterHealthScale", gtmpl.monsterhealthscale);
		if (gtmpl.tksMonsterprogessivehealth) trap_Cvar_SetValue("ui_stu_monsterProgression", gtmpl.monsterprogressivehealth);
		if (gtmpl.tksGuards) trap_Cvar_SetValue("ui_stu_monsterGuards", gtmpl.guards);
		if (gtmpl.tksTitans) trap_Cvar_SetValue("ui_stu_monsterTitans", gtmpl.titans);
		if (gtmpl.tksMonsterbreeding) trap_Cvar_SetValue("ui_stu_monsterBreeding", gtmpl.monsterbreeding);
		break;


    // JUHOX: set EFH ui cvars
	case GT_EFH:
		if (gtmpl.tksFraglimit) trap_Cvar_SetValue("ui_efh_fraglimit", gtmpl.fraglimit);
		if (gtmpl.tksTimelimit) trap_Cvar_SetValue("ui_efh_timelimit", gtmpl.timelimit);
		if (gtmpl.tksDistancelimit) trap_Cvar_SetValue("ui_efh_distancelimit", gtmpl.distancelimit);
		if (gtmpl.tksFriendlyfire) trap_Cvar_SetValue("ui_efh_friendly", gtmpl.friendlyfire);
		if (gtmpl.tksRespawndelay) trap_Cvar_SetValue("ui_efh_respawndelay", gtmpl.respawndelay);
		if (gtmpl.tksChallengingEnv) trap_Cvar_SetValue("ui_efh_challengingenv", gtmpl.challengingEnv);
		if (gtmpl.tksGameseed) trap_Cvar_SetValue("ui_efh_gameseed", gtmpl.gameseed);
		if (gtmpl.tksNoitems) trap_Cvar_SetValue("ui_efh_noItems", gtmpl.noitems);
		if (gtmpl.tksNohealthregen) trap_Cvar_SetValue("ui_efh_noHealthRegen", gtmpl.nohealthregen);
		if (gtmpl.tksCloakingdevice) trap_Cvar_SetValue("ui_efh_cloakingDevice", gtmpl.cloakingdevice);
		if (gtmpl.tksUnlimitedammo) trap_Cvar_SetValue("ui_efh_unlimitedAmmo", gtmpl.unlimitedammo);

		if (gtmpl.tksMonsterload) trap_Cvar_SetValue("ui_efh_monsterLoad", gtmpl.monsterLoad);
		if (gtmpl.tksMonsterhealthscale) trap_Cvar_SetValue("ui_efh_monsterHealthScale", gtmpl.monsterhealthscale);
		if (gtmpl.tksMonsterprogessivehealth) trap_Cvar_SetValue("ui_efh_monsterProgression", gtmpl.monsterprogressivehealth);
		if (gtmpl.tksGuards) trap_Cvar_SetValue("ui_efh_monsterGuards", gtmpl.guards);
		if (gtmpl.tksTitans) trap_Cvar_SetValue("ui_efh_monsterTitans", gtmpl.titans);
		break;
	}

	if (gtmpl.mapName[0]) {
		UI_ServerOptionsMenu(templateInfo.multiplayer);
	}
	else {
		initialGameType = gtmpl.gametype;
		UI_StartServerMenu(templateInfo.multiplayer);
	}
	UI_TemplateMenu_Exit();
}

/*
=================
JUHOX: UI_TemplateMenu_TemplateLineDraw
=================
*/
static void UI_TemplateMenu_TemplateLineDraw(void* self)
{
	int x, y;
	menuaction_s* item;
	int line;
	qboolean hasFocus;
	vec4_t color;
	int style;

	item = (menuaction_s*) self;
	x = item->generic.x;
	y = item->generic.y;
	hasFocus = item->generic.parent->cursor == item->generic.menuPosition;
	line = templateInfo.firstTemplate + item->generic.id;
	if (line < 0 || line >= templateInfo.currentList->numEntries) return;

	style = 0;
	if (item->generic.flags & QMF_GRAYED) {
		Vector4Copy(text_color_disabled, color);
	}
	else {
		if (hasFocus) {
			Vector4Copy(text_color_highlight, color);
			style = UI_PULSE;
		}
		else {
			Vector4Copy(text_color_normal, color);
		}

		if (line == templateInfo.selectedTemplate) {
			UI_FillRect(0, y, 640, SMALLCHAR_HEIGHT, listbar_color);
			Vector4Copy(colorWhite, color);
		}
	}
	UI_DrawString(x + 40, y, templateInfo.currentList->entries[line].name, UI_SMALLFONT | style, color);
}

/*
=================
JUHOX: UI_TemplateMenu_TemplateLineEvent
=================
*/
static void UI_TemplateMenu_TemplateLineEvent(void* ptr, int event)
{
	if (event == QM_ACTIVATED)
	{
		templateInfo.selectedTemplate = templateInfo.firstTemplate + ((menucommon_s*)ptr)->id;
		UI_Template_SetMenuItems();
	}
}

/*
=================
JUHOX: UI_TemplateMenu_PrevPageEvent
=================
*/
static void UI_TemplateMenu_PrevPageEvent(void* ptr, int event) {
	if (event == QM_ACTIVATED)
	{
		if (templateInfo.firstTemplate >= NUM_TEMPLATES_PER_PAGE) {
			templateInfo.firstTemplate -= NUM_TEMPLATES_PER_PAGE;

			if (
				!templateInfo.inGame ||
				!templateInfo.remoteServer ||
				templateInfo.remote.curvalue
			) {
				templateInfo.selectedTemplate -= NUM_TEMPLATES_PER_PAGE;
				if (templateInfo.selectedTemplate < 0) templateInfo.selectedTemplate = 0;
			}
		}
		UI_Template_SetMenuItems();
	}
}

/*
=================
JUHOX: UI_TemplateMenu_NextPageEvent
=================
*/
static void UI_TemplateMenu_NextPageEvent(void* ptr, int event) {
	if (event == QM_ACTIVATED)
	{
		if (templateInfo.firstTemplate < templateInfo.currentList->numEntries - NUM_TEMPLATES_PER_PAGE) {
			templateInfo.firstTemplate += NUM_TEMPLATES_PER_PAGE;

			if (
				!templateInfo.inGame ||
				!templateInfo.remoteServer ||
				templateInfo.remote.curvalue
			) {
				templateInfo.selectedTemplate += NUM_TEMPLATES_PER_PAGE;
				if (templateInfo.selectedTemplate >= templateInfo.currentList->numEntries) {
					templateInfo.selectedTemplate = templateInfo.currentList->numEntries - 1;
				}
			}
		}
		UI_Template_SetMenuItems();
	}
}

/*
=================
JUHOX: UI_TemplateMenu_RemoteEvent
=================
*/
static void UI_TemplateMenu_RemoteEvent(void* ptr, int event) {
	int t;

	if (event != QM_ACTIVATED) return;

	t = templateInfo.firstTemplate;
	templateInfo.firstTemplate = templateInfo.savedFirstTemplate;
	templateInfo.savedFirstTemplate = t;

	UI_Template_SetMenuItems();
}

/*
=================
JUHOX: UI_TemplateMenu_Draw
=================
*/
#define SCROLL_SPEED 50.0	// pixels per second
static void UI_TemplateMenu_Draw(void) {
	static const vec4_t backgroundColor = {0, 0, 0, 0.75};
	int w;

	if (templateInfo.inGame) {
		UI_FillRect(0, 0, 640, 480, backgroundColor);
	}

	if (NOT(templateInfo.inGame && templateInfo.remoteServer && !templateInfo.remote.curvalue)) {
		UI_DrawString(320, 360, templateInfo.highscoreLine1, UI_SMALLFONT | UI_CENTER, colorWhite);

		w = UI_DrawStrlen(templateInfo.highscoreLine2) * SMALLCHAR_WIDTH;
		if (w <= 640) {
			UI_DrawString(320, 377, templateInfo.highscoreLine2, UI_SMALLFONT | UI_CENTER, colorWhite);
		}
		else {
			float x;

			w += 120;
			x = SCROLL_SPEED * (3.0 + (templateInfo.highscoreLineSetTime - uis.realtime) / 1000.0);
			if (x + w < 640) {
				int n;

				n = (int) (x / w);
				x -= w * n;
				UI_DrawString(x + w, 377, templateInfo.highscoreLine2, UI_SMALLFONT, colorWhite);
			}
			UI_DrawString(x, 377, templateInfo.highscoreLine2, UI_SMALLFONT, colorWhite);
		}
	}

	if (Q_stricmp(templateInfo.name.field.buffer, templateInfo.oldName)) {
		Q_strncpyz(templateInfo.oldName, templateInfo.name.field.buffer, sizeof(templateInfo.oldName));

		UI_Template_SetMenuItems();
	}

	Menu_Draw(&templateInfo.menu);

	if (templateInfo.errorDetected) {
		if (templateInfo.lastMsgTime < uis.realtime - 2000) {
			UI_Send_TemplateList_Error();
		}
	}
	else if (
		templateInfo.inGame &&
		templateInfo.remoteServer &&
		templateInfo.lastMsgTime < uis.realtime - 2000
	) {
		UI_Send_TemplateList_Request();
	}

	if (!templateInfo.inGame) {
		UI_DrawString(320, 440, gametype_names[templateInfo.gametype], UI_CENTER, colorWhite);
	}

	if (templateInfo.errorTime && uis.realtime < templateInfo.errorTime) {
		UI_DrawString(320, 462, templateInfo.error, UI_SMALLFONT | UI_CENTER, colorWhite);
	}
}

/*
=================
JUHOX: UI_TemplateMenu_Init
=================
*/
static void UI_TemplateMenu_Init(qboolean inGame, qboolean multiplayer) {
	memset(&templateInfo, 0, sizeof(templateInfo));
	templateInfo.inGame = inGame;
	templateInfo.multiplayer = multiplayer;
	templateInfo.menu.wrapAround = qtrue;
	templateInfo.menu.fullscreen = !inGame;
	templateInfo.menu.draw = UI_TemplateMenu_Draw;

	UI_TemplateMenu_InitTemplates();
	UI_TemplateMenu_Cache();

	templateInfo.banner.generic.type	= MTYPE_BTEXT;
	templateInfo.banner.generic.x		= 320;
	templateInfo.banner.generic.y		= 16;
	templateInfo.banner.string			= "GAME TEMPLATES";
	templateInfo.banner.color			= colorWhite;
	templateInfo.banner.style			= UI_CENTER;
	Menu_AddItem(&templateInfo.menu, &templateInfo.banner);

	templateInfo.page.generic.type	= MTYPE_PTEXT;
	templateInfo.page.generic.x		= 170;
	templateInfo.page.generic.y		= 60;
	templateInfo.page.string		= "";
	templateInfo.page.color			= colorLtGrey;
	templateInfo.page.style			= UI_LEFT;
	Menu_AddItem(&templateInfo.menu, &templateInfo.page);

	templateInfo.arrows.generic.type		= MTYPE_BITMAP;
	templateInfo.arrows.generic.name		= TEMPL_ARROWS;
	templateInfo.arrows.generic.flags		= QMF_INACTIVE;
	templateInfo.arrows.generic.x			= 30;
	templateInfo.arrows.generic.y			= 60;
	templateInfo.arrows.width				= 128;
	templateInfo.arrows.height				= 32;
	Menu_AddItem(&templateInfo.menu, &templateInfo.arrows);

	templateInfo.prevpage.generic.type		= MTYPE_BITMAP;
	templateInfo.prevpage.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
	templateInfo.prevpage.generic.callback	= UI_TemplateMenu_PrevPageEvent;
	templateInfo.prevpage.generic.x			= 30;
	templateInfo.prevpage.generic.y			= 60;
	templateInfo.prevpage.width				= 64;
	templateInfo.prevpage.height			= 32;
	templateInfo.prevpage.focuspic			= TEMPL_ARROWSL;
	Menu_AddItem(&templateInfo.menu, &templateInfo.prevpage);

	templateInfo.nextpage.generic.type		= MTYPE_BITMAP;
	templateInfo.nextpage.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
	templateInfo.nextpage.generic.callback	= UI_TemplateMenu_NextPageEvent;
	templateInfo.nextpage.generic.x			= 30+65;
	templateInfo.nextpage.generic.y			= 60;
	templateInfo.nextpage.width				= 64;
	templateInfo.nextpage.height			= 32;
	templateInfo.nextpage.focuspic			= TEMPL_ARROWSR;
	Menu_AddItem(&templateInfo.menu, &templateInfo.nextpage);

	if (templateInfo.inGame && templateInfo.remoteServer) {
		templateInfo.remote.generic.type		= MTYPE_SPINCONTROL;
		templateInfo.remote.generic.name		= "Show";
		templateInfo.remote.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
		templateInfo.remote.generic.x			= 450;
		templateInfo.remote.generic.y			= 67;
		templateInfo.remote.generic.callback	= UI_TemplateMenu_RemoteEvent;
		templateInfo.remote.itemnames			= remote_items;
		templateInfo.remote.curvalue			= qtrue;
		Menu_AddItem(&templateInfo.menu, &templateInfo.remote);
	}

	{
		int y;
		int i;

		y = 100;
		for (i = 0; i < NUM_TEMPLATES_PER_PAGE; i++)
		{
			templateInfo.templateLine[i].generic.type		= MTYPE_ACTION;
			templateInfo.templateLine[i].generic.y			= y;
			templateInfo.templateLine[i].generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_INACTIVE|QMF_HIDDEN;
			templateInfo.templateLine[i].generic.callback	= UI_TemplateMenu_TemplateLineEvent;
			templateInfo.templateLine[i].generic.ownerdraw	= UI_TemplateMenu_TemplateLineDraw;
			templateInfo.templateLine[i].generic.id			= i;
			Menu_AddItem(&templateInfo.menu, &templateInfo.templateLine[i]);
			templateInfo.templateLine[i].generic.top		= y;
			templateInfo.templateLine[i].generic.bottom		= y + SMALLCHAR_HEIGHT;
			templateInfo.templateLine[i].generic.right		= 640;

			y += SMALLCHAR_HEIGHT + 1;
		}
	}

	templateInfo.back.generic.type		= MTYPE_BITMAP;
	templateInfo.back.generic.name		= TEMPL_BACK0;
	templateInfo.back.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
	templateInfo.back.generic.callback	= UI_TemplateMenu_BackEvent;
	templateInfo.back.generic.x			= 0;
	templateInfo.back.generic.y			= 480-64;
	templateInfo.back.width				= 128;
	templateInfo.back.height			= 64;
	templateInfo.back.focuspic			= TEMPL_BACK1;
	Menu_AddItem(&templateInfo.menu, &templateInfo.back);

	templateInfo.del.generic.type		= MTYPE_BITMAP;
	templateInfo.del.generic.name		= TEMPL_DEL0;
	templateInfo.del.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_INACTIVE|QMF_HIDDEN;
	templateInfo.del.generic.callback	= UI_TemplateMenu_DelEvent;
	templateInfo.del.generic.x			= 100;
	templateInfo.del.generic.y			= 480-64;
	templateInfo.del.width				= 128;
	templateInfo.del.height				= 64;
	templateInfo.del.focuspic			= TEMPL_DEL1;
	Menu_AddItem(&templateInfo.menu, &templateInfo.del);

	if (templateInfo.inGame) {
		templateInfo.name.generic.type			= MTYPE_FIELD;
		templateInfo.name.generic.name			= "Save Current Settings As:";
		templateInfo.name.generic.flags			= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
		templateInfo.name.generic.x				= 250;
		templateInfo.name.generic.y				= 396;
		templateInfo.name.field.widthInChars	= 32;
		templateInfo.name.field.maxchars		= 60;
		Menu_AddItem(&templateInfo.menu, &templateInfo.name);
	}

	if (templateInfo.inGame) {
		templateInfo.save.generic.type		= MTYPE_BITMAP;
		templateInfo.save.generic.name		= TEMPL_SAVE0;
		templateInfo.save.generic.flags		= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED;
		templateInfo.save.generic.callback	= UI_TemplateMenu_SaveEvent;
		templateInfo.save.generic.x			= 510;
		templateInfo.save.generic.y			= 480-64;
		templateInfo.save.width				= 128;
		templateInfo.save.height			= 64;
		templateInfo.save.focuspic			= TEMPL_SAVE1;
		Menu_AddItem(&templateInfo.menu, &templateInfo.save);
	}

	templateInfo.next.generic.type		= MTYPE_BITMAP;
	templateInfo.next.generic.name		= templateInfo.inGame? TEMPL_VOTE0 : TEMPL_NEXT0;
	templateInfo.next.generic.flags		= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_GRAYED|QMF_INACTIVE;
	templateInfo.next.generic.callback	= UI_TemplateMenu_NextEvent;
	templateInfo.next.generic.x			= 640;
	templateInfo.next.generic.y			= 480-64;
	templateInfo.next.width				= 128;
	templateInfo.next.height			= 64;
	templateInfo.next.focuspic			= templateInfo.inGame? TEMPL_VOTE1 : TEMPL_NEXT1;
	Menu_AddItem(&templateInfo.menu, &templateInfo.next);

	UI_Template_SetMenuItems();
}

/*
=================
JUHOX: UI_TemplateMenu
=================
*/
void UI_TemplateMenu(qboolean inGame, qboolean multiplayer) {
	UI_TemplateMenu_Init(inGame, multiplayer);
	UI_PushMenu(&templateInfo.menu);
	templateInfo.isActive = qtrue;
}

/*
=================
JUHOX: UI_TemplateList_SvTemplate
=================
*/
void UI_TemplateList_SvTemplate(
	int n, const char* name, int highscoreType, const char* highscore, const char* descriptor
) {
	char varName[32];

	Com_sprintf(varName, sizeof(varName), "svtmpl%03d", n);
	trap_Cvar_Register(NULL, varName, "", CVAR_ROM | CVAR_NORESTART);
	trap_Cvar_Set(varName, va("name\\%s\\ht\\%d\\h\\%s\\d\\%s", name, highscoreType, highscore, descriptor));

	// update menu
	if (templateInfo.isActive) {
		BG_GetGameTemplateList(&templateInfo.svList, 0, NULL, qtrue);
		UI_TemplateMenu_ComputeChecksums();
		UI_Template_SetMenuItems();
	}
	else {
		UI_Send_TemplateList_Stop();
	}
	templateInfo.errorDetected = qfalse;
}

/*
=================
JUHOX: UI_TemplateList_Complete
=================
*/
void UI_TemplateList_Complete(int number, long checksum) {
	int i;

	templateInfo.errorDetected = qfalse;
	if (!templateInfo.isActive) return;

	// delete superfluous templates
	for (i = number; i < MAX_GAMETEMPLATES; i++) {
		char varName[32];
		char buf[MAX_STRING_CHARS];

		Com_sprintf(varName, sizeof(varName), "svtmpl%03d", i);
		trap_Cvar_VariableStringBuffer(varName, buf, sizeof(buf));
		if (buf[0]) trap_Cvar_Set(varName, "");
	}

	BG_GetGameTemplateList(&templateInfo.svList, 0, NULL, qtrue);
	UI_TemplateMenu_ComputeChecksums();
	UI_Template_SetMenuItems();

	if (checksum != templateInfo.svlistChecksum || number != templateInfo.svList.numEntries) {
		// JUHOX FIXME: the error command doesn't reach the server if send here and sv_floodprotect is 1
		//UI_Send_TemplateList_Error();
		templateInfo.errorDetected = qtrue;
		templateInfo.lastMsgTime = uis.realtime;
	}
}




/*
=============================================================================

JUHOX: GAME TYPE SELECTION MENU *****

=============================================================================
*/

#define GTS_BACK0			"menu/art/back_0"
#define GTS_BACK1			"menu/art/back_1"

typedef struct {
	menuframework_s	menu;

	menutext_s		banner;

	qboolean		multiplayer;

	menutext_s		templateMenuDescr;
	menutext_s		templateMenu;

	menutext_s		singleDescr;
	menutext_s		ffa;
	menutext_s		tourney;
	menutext_s		teamDescr;
	menutext_s		tdm;
	menutext_s		ctf;
	menutext_s		coopDescr;
	menutext_s		stu;
	menutext_s		efh;

	menubitmap_s	back;
} gameTypeSelectionInfo_t;

static gameTypeSelectionInfo_t	gtsInfo;



/*
=================
JUHOX: UI_GTS_Cache
=================
*/
void UI_GTS_Cache(void) {
	trap_R_RegisterShaderNoMip(GTS_BACK0);
	trap_R_RegisterShaderNoMip(GTS_BACK1);
}

/*
=================
JUHOX: UI_GTS_BackEvent
=================
*/
static void UI_GTS_BackEvent(void* ptr, int event) {
	if(event != QM_ACTIVATED) {
		return;
	}

	UI_PopMenu();
}

/*
=================
JUHOX: UI_GTS_TemplateEvent
=================
*/
static void UI_GTS_TemplateEvent(void* ptr, int event) {
	if(event != QM_ACTIVATED) {
		return;
	}

	UI_TemplateMenu(qfalse, gtsInfo.multiplayer);
}

/*
=================
JUHOX: UI_GTS_Event
=================
*/
static void UI_GTS_Event(void* ptr, int event) {
	if( event != QM_ACTIVATED ) {
		return;
	}

	initialGameType = ((menucommon_s*)ptr)->id;
	UI_StartServerMenu(gtsInfo.multiplayer);
}

/*
=================
JUHOX: UI_GTS_Init
=================
*/
static void UI_GTS_Init(qboolean multiplayer) {
	int y;
	static vec4_t descrColor = { 0.6, 0.6, 0.6, 1.0	};

	memset(&gtsInfo, 0, sizeof(gtsInfo));
	gtsInfo.menu.wrapAround = qtrue;
	gtsInfo.menu.fullscreen = qtrue;
	gtsInfo.multiplayer = multiplayer;

	UI_GTS_Cache();

	gtsInfo.banner.generic.type	= MTYPE_BTEXT;
	gtsInfo.banner.generic.x	= 320;
	gtsInfo.banner.generic.y	= 16;
	gtsInfo.banner.string		= "GAME SELECTION";
	gtsInfo.banner.color		= colorWhite;
	gtsInfo.banner.style		= UI_CENTER;
	Menu_AddItem(&gtsInfo.menu, &gtsInfo.banner);

	gtsInfo.back.generic.type		= MTYPE_BITMAP;
	gtsInfo.back.generic.name		= GTS_BACK0;
	gtsInfo.back.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
	gtsInfo.back.generic.callback	= UI_GTS_BackEvent;
	gtsInfo.back.generic.x			= 0;
	gtsInfo.back.generic.y			= 480-64;
	gtsInfo.back.width				= 128;
	gtsInfo.back.height				= 64;
	gtsInfo.back.focuspic			= GTS_BACK1;
	Menu_AddItem(&gtsInfo.menu, &gtsInfo.back);

	y = 80;

	gtsInfo.templateMenuDescr.generic.type	= MTYPE_TEXT;
	gtsInfo.templateMenuDescr.generic.flags	= QMF_LEFT_JUSTIFY|QMF_SMALLFONT;
	gtsInfo.templateMenuDescr.generic.x		= 50;
	gtsInfo.templateMenuDescr.generic.y		= y;
	gtsInfo.templateMenuDescr.string		= "prefabs";
	gtsInfo.templateMenuDescr.color			= descrColor;
	gtsInfo.templateMenuDescr.style			= UI_LEFT|UI_SMALLFONT;
	Menu_AddItem(&gtsInfo.menu, &gtsInfo.templateMenuDescr);

	gtsInfo.templateMenu.generic.type		= MTYPE_PTEXT;
	gtsInfo.templateMenu.generic.flags		= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
	gtsInfo.templateMenu.generic.x			= 590;
	gtsInfo.templateMenu.generic.y			= y;
	gtsInfo.templateMenu.generic.callback	= UI_GTS_TemplateEvent;
	gtsInfo.templateMenu.string				= "Game Templates";
	gtsInfo.templateMenu.color				= color_red;
	gtsInfo.templateMenu.style				= UI_RIGHT|UI_DROPSHADOW;
	Menu_AddItem(&gtsInfo.menu, &gtsInfo.templateMenu);
	y += 58;

	gtsInfo.singleDescr.generic.type	= MTYPE_TEXT;
	gtsInfo.singleDescr.generic.flags	= QMF_LEFT_JUSTIFY|QMF_SMALLFONT;
	gtsInfo.singleDescr.generic.x		= 50;
	gtsInfo.singleDescr.generic.y		= y;
	gtsInfo.singleDescr.string			= "ego games";
	gtsInfo.singleDescr.color			= descrColor;
	gtsInfo.singleDescr.style			= UI_LEFT|UI_SMALLFONT;
	Menu_AddItem(&gtsInfo.menu, &gtsInfo.singleDescr);

	gtsInfo.ffa.generic.type		= MTYPE_PTEXT;
	gtsInfo.ffa.generic.flags		= QMF_PULSEIFFOCUS|QMF_RIGHT_JUSTIFY;
	gtsInfo.ffa.generic.x			= 590;
	gtsInfo.ffa.generic.y			= y;
	gtsInfo.ffa.generic.id			= GT_FFA;
	gtsInfo.ffa.generic.callback	= UI_GTS_Event;
	gtsInfo.ffa.color				= color_red;
	gtsInfo.ffa.style				= UI_RIGHT|UI_DROPSHADOW;
	gtsInfo.ffa.string				= "Free For All";
	Menu_AddItem(&gtsInfo.menu, &gtsInfo.ffa);
	y += 34;

	gtsInfo.tourney.generic.type		= MTYPE_PTEXT;
	gtsInfo.tourney.generic.flags		= QMF_PULSEIFFOCUS|QMF_RIGHT_JUSTIFY;
	gtsInfo.tourney.generic.x			= 590;
	gtsInfo.tourney.generic.y			= y;
	gtsInfo.tourney.generic.id			= GT_TOURNAMENT;
	gtsInfo.tourney.generic.callback	= UI_GTS_Event;
	gtsInfo.tourney.color				= color_red;
	gtsInfo.tourney.style				= UI_RIGHT|UI_DROPSHADOW;
	gtsInfo.tourney.string				= "Tournament";
	Menu_AddItem(&gtsInfo.menu, &gtsInfo.tourney);
	y += 58;

	gtsInfo.teamDescr.generic.type	= MTYPE_TEXT;
	gtsInfo.teamDescr.generic.flags	= QMF_LEFT_JUSTIFY|QMF_SMALLFONT;
	gtsInfo.teamDescr.generic.x		= 50;
	gtsInfo.teamDescr.generic.y		= y;
	gtsInfo.teamDescr.string		= "team games";
	gtsInfo.teamDescr.color			= descrColor;
	gtsInfo.teamDescr.style			= UI_LEFT|UI_SMALLFONT;
	Menu_AddItem(&gtsInfo.menu, &gtsInfo.teamDescr);

	gtsInfo.tdm.generic.type		= MTYPE_PTEXT;
	gtsInfo.tdm.generic.flags		= QMF_PULSEIFFOCUS|QMF_RIGHT_JUSTIFY;
	gtsInfo.tdm.generic.x			= 590;
	gtsInfo.tdm.generic.y			= y;
	gtsInfo.tdm.generic.id			= GT_TEAM;
	gtsInfo.tdm.generic.callback	= UI_GTS_Event;
	gtsInfo.tdm.color				= color_red;
	gtsInfo.tdm.style				= UI_RIGHT|UI_DROPSHADOW;
	gtsInfo.tdm.string				= "Team Deathmatch";
	Menu_AddItem(&gtsInfo.menu, &gtsInfo.tdm);
	y += 34;

	gtsInfo.ctf.generic.type		= MTYPE_PTEXT;
	gtsInfo.ctf.generic.flags		= QMF_PULSEIFFOCUS|QMF_RIGHT_JUSTIFY;
	gtsInfo.ctf.generic.x			= 590;
	gtsInfo.ctf.generic.y			= y;
	gtsInfo.ctf.generic.id			= GT_CTF;
	gtsInfo.ctf.generic.callback	= UI_GTS_Event;
	gtsInfo.ctf.color				= color_red;
	gtsInfo.ctf.style				= UI_RIGHT|UI_DROPSHADOW;
	gtsInfo.ctf.string				= "Capture the Flag";
	Menu_AddItem(&gtsInfo.menu, &gtsInfo.ctf);
	y += 58;

	gtsInfo.coopDescr.generic.type	= MTYPE_TEXT;
	gtsInfo.coopDescr.generic.flags	= QMF_LEFT_JUSTIFY|QMF_SMALLFONT;
	gtsInfo.coopDescr.generic.x		= 50;
	gtsInfo.coopDescr.generic.y		= y;
	gtsInfo.coopDescr.string		= "co-op games";
	gtsInfo.coopDescr.color			= descrColor;
	gtsInfo.coopDescr.style			= UI_LEFT|UI_SMALLFONT;
	Menu_AddItem(&gtsInfo.menu, &gtsInfo.coopDescr);

	gtsInfo.stu.generic.type		= MTYPE_PTEXT;
	gtsInfo.stu.generic.flags		= QMF_PULSEIFFOCUS|QMF_RIGHT_JUSTIFY;
	gtsInfo.stu.generic.x			= 590;
	gtsInfo.stu.generic.y			= y;
	gtsInfo.stu.generic.id			= GT_STU;
	gtsInfo.stu.generic.callback	= UI_GTS_Event;
	gtsInfo.stu.color				= color_red;
	gtsInfo.stu.style				= UI_RIGHT|UI_DROPSHADOW;
	gtsInfo.stu.string				= "Save the Universe";
	Menu_AddItem(&gtsInfo.menu, &gtsInfo.stu);
	y += 34;

	gtsInfo.efh.generic.type		= MTYPE_PTEXT;
	gtsInfo.efh.generic.flags		= QMF_PULSEIFFOCUS|QMF_RIGHT_JUSTIFY;
	gtsInfo.efh.generic.x			= 590;
	gtsInfo.efh.generic.y			= y;
	gtsInfo.efh.generic.id			= GT_EFH;
	gtsInfo.efh.generic.callback	= UI_GTS_Event;
	gtsInfo.efh.color				= color_red;
	gtsInfo.efh.style				= UI_RIGHT|UI_DROPSHADOW;
	gtsInfo.efh.string				= "Escape from Hell";
	Menu_AddItem(&gtsInfo.menu, &gtsInfo.efh);
	y += 34;

}

/*
=================
JUHOX: UI_GTS_Menu
=================
*/
void UI_GTS_Menu(qboolean multiplayer) {
	UI_GTS_Init(multiplayer);
	UI_PushMenu(&gtsInfo.menu);
}

