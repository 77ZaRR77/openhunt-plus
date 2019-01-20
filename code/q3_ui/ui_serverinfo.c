// Copyright (C) 1999-2000 Id Software, Inc.
//
#include "ui_local.h"

#define SERVERINFO_FRAMEL	"menu/art/frame2_l"
#define SERVERINFO_FRAMER	"menu/art/frame1_r"
#define SERVERINFO_BACK0	"menu/art/back_0"
#define SERVERINFO_BACK1	"menu/art/back_1"
#define SERVERINFO_ARROWS	"menu/art/gs_arrows_0"	// JUHOX
#define SERVERINFO_ARROWSL	"menu/art/gs_arrows_l"	// JUHOX
#define SERVERINFO_ARROWSR	"menu/art/gs_arrows_r"	// JUHOX

static char* serverinfo_artlist[] =
{
	SERVERINFO_FRAMEL,	
	SERVERINFO_FRAMER,
	SERVERINFO_BACK0,
	SERVERINFO_BACK1,
	SERVERINFO_ARROWS,	// JUHOX
	SERVERINFO_ARROWSL,	// JUHOX
	SERVERINFO_ARROWSR,	// JUHOX
	NULL
};

#define ID_ADD	 100
#define ID_BACK	 101
#define ID_PREVPAGE 102	// JUHOX
#define ID_NEXTPAGE 103	// JUHOX

#define MAX_LINES_PER_PAGE 16	// JUHOX

typedef struct
{
	menuframework_s	menu;
	menutext_s		banner;
	menubitmap_s	framel;
	menubitmap_s	framer;
	menubitmap_s	back;
	menubitmap_s	arrows;		// JUHOX
	menubitmap_s	prevpage;	// JUHOX
	menubitmap_s	nextpage;	// JUHOX
	menutext_s		add;
	char			info[MAX_INFO_STRING];
	int				numlines;
	int				firstLine;	// JUHOX
} serverinfo_t;

static serverinfo_t	s_serverinfo;


/*
=================
Favorites_Add

Add current server to favorites
=================
*/
void Favorites_Add( void )
{
	char	adrstr[128];
	char	serverbuff[128];
	int		i;
	int		best;

	trap_Cvar_VariableStringBuffer( "cl_currentServerAddress", serverbuff, sizeof(serverbuff) );
	if (!serverbuff[0])
		return;

	best = 0;
	for (i=0; i<MAX_FAVORITESERVERS; i++)
	{
		trap_Cvar_VariableStringBuffer( va("server%d",i+1), adrstr, sizeof(adrstr) );
		if (!Q_stricmp(serverbuff,adrstr))
		{
			// already in list
			return;
		}
		
		// use first empty or non-numeric available slot
		if ((adrstr[0]  < '0' || adrstr[0] > '9' ) && !best)
			best = i+1;
	}

	if (best)
		trap_Cvar_Set( va("server%d",best), serverbuff);
}


/*
=================
ServerInfo_Event
=================
*/
static void ServerInfo_Event( void* ptr, int event )
{
	switch (((menucommon_s*)ptr)->id)
	{
		case ID_ADD:
			if (event != QM_ACTIVATED)
				break;
		
			Favorites_Add();
			UI_PopMenu();
			break;

		case ID_BACK:
			if (event != QM_ACTIVATED)
				break;

			UI_PopMenu();
			break;

		// JUHOX: handle server info page arrow events
#if 1
		case ID_PREVPAGE:
			if (event != QM_ACTIVATED) break;
			s_serverinfo.firstLine -= MAX_LINES_PER_PAGE;
			if (s_serverinfo.firstLine < 0) {
				s_serverinfo.firstLine = 0;
			}
			break;

		case ID_NEXTPAGE:
			if (event != QM_ACTIVATED) break;
			if (s_serverinfo.firstLine < s_serverinfo.numlines - MAX_LINES_PER_PAGE) {
				s_serverinfo.firstLine += MAX_LINES_PER_PAGE;
			}
			break;
#endif

	}
}

/*
=================
ServerInfo_MenuDraw
=================
*/
static void ServerInfo_MenuDraw( void )
{
	const char		*s;
	char			key[MAX_INFO_KEY];
	char			value[MAX_INFO_VALUE];
	int				y;
	int line = -1;	// JUHOX

	// JUHOX: fixed top line
#if 0
	y = SCREEN_HEIGHT/2 - s_serverinfo.numlines*(SMALLCHAR_HEIGHT)/2 - 20;
#else
	y = SCREEN_HEIGHT/2 - MAX_LINES_PER_PAGE * (SMALLCHAR_HEIGHT) / 2 - 20;
#endif
	s = s_serverinfo.info;
	while ( s ) {
		Info_NextPair( &s, key, value );
		if ( !key[0] ) {
			break;
		}

		// JUHOX: only draw one page of lines
#if 1
		line++;
		if (line < s_serverinfo.firstLine) continue;
		if (line >= s_serverinfo.firstLine + MAX_LINES_PER_PAGE) break;
#endif

		Q_strcat( key, MAX_INFO_KEY, ":" ); 

		UI_DrawString(SCREEN_WIDTH*0.50 - 8,y,key,UI_RIGHT|UI_SMALLFONT,color_red);
		UI_DrawString(SCREEN_WIDTH*0.50 + 8,y,value,UI_LEFT|UI_SMALLFONT,text_color_normal);

		y += SMALLCHAR_HEIGHT;
	}

	Menu_Draw( &s_serverinfo.menu );
}

/*
=================
ServerInfo_MenuKey
=================
*/
static sfxHandle_t ServerInfo_MenuKey( int key )
{
	return ( Menu_DefaultKey( &s_serverinfo.menu, key ) );
}

/*
=================
ServerInfo_Cache
=================
*/
void ServerInfo_Cache( void )
{
	int	i;

	// touch all our pics
	for (i=0; ;i++)
	{
		if (!serverinfo_artlist[i])
			break;
		trap_R_RegisterShaderNoMip(serverinfo_artlist[i]);
	}
}

/*
=================
UI_ServerInfoMenu
=================
*/
void UI_ServerInfoMenu( void )
{
	const char		*s;
	char			key[MAX_INFO_KEY];
	char			value[MAX_INFO_VALUE];

	// zero set all our globals
	memset( &s_serverinfo, 0 ,sizeof(serverinfo_t) );

	ServerInfo_Cache();

	s_serverinfo.menu.draw       = ServerInfo_MenuDraw;
	s_serverinfo.menu.key        = ServerInfo_MenuKey;
	s_serverinfo.menu.wrapAround = qtrue;
	s_serverinfo.menu.fullscreen = qtrue;

	s_serverinfo.banner.generic.type  = MTYPE_BTEXT;
	s_serverinfo.banner.generic.x	  = 320;
	s_serverinfo.banner.generic.y	  = 16;
	s_serverinfo.banner.string		  = "SERVER INFO";
	s_serverinfo.banner.color	      = color_white;
	s_serverinfo.banner.style	      = UI_CENTER;

	s_serverinfo.framel.generic.type  = MTYPE_BITMAP;
	s_serverinfo.framel.generic.name  = SERVERINFO_FRAMEL;
	s_serverinfo.framel.generic.flags = QMF_INACTIVE;
	s_serverinfo.framel.generic.x	  = 0;  
	s_serverinfo.framel.generic.y	  = 78;
	s_serverinfo.framel.width  	      = 256;
	s_serverinfo.framel.height  	  = 329;

	s_serverinfo.framer.generic.type  = MTYPE_BITMAP;
	s_serverinfo.framer.generic.name  = SERVERINFO_FRAMER;
	s_serverinfo.framer.generic.flags = QMF_INACTIVE;
	s_serverinfo.framer.generic.x	  = 376;
	s_serverinfo.framer.generic.y	  = 76;
	s_serverinfo.framer.width  	      = 256;
	s_serverinfo.framer.height  	  = 334;

	// JUHOX: init page arrows
#if 1
	s_serverinfo.arrows.generic.type		= MTYPE_BITMAP;
	s_serverinfo.arrows.generic.name		= SERVERINFO_ARROWS;
	s_serverinfo.arrows.generic.flags		= QMF_INACTIVE;
	s_serverinfo.arrows.generic.x			= 260;
	s_serverinfo.arrows.generic.y			= 371;
	s_serverinfo.arrows.width				= 128;
	s_serverinfo.arrows.height				= 32;

	s_serverinfo.prevpage.generic.type		= MTYPE_BITMAP;
	s_serverinfo.prevpage.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
	s_serverinfo.prevpage.generic.callback	= ServerInfo_Event;
	s_serverinfo.prevpage.generic.id		= ID_PREVPAGE;
	s_serverinfo.prevpage.generic.x			= 260;
	s_serverinfo.prevpage.generic.y			= 371;
	s_serverinfo.prevpage.width				= 64;
	s_serverinfo.prevpage.height			= 32;
	s_serverinfo.prevpage.focuspic			= SERVERINFO_ARROWSL;

	s_serverinfo.nextpage.generic.type		= MTYPE_BITMAP;
	s_serverinfo.nextpage.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
	s_serverinfo.nextpage.generic.callback	= ServerInfo_Event;
	s_serverinfo.nextpage.generic.id		= ID_NEXTPAGE;
	s_serverinfo.nextpage.generic.x			= 321;
	s_serverinfo.nextpage.generic.y			= 371;
	s_serverinfo.nextpage.width				= 64;
	s_serverinfo.nextpage.height			= 32;
	s_serverinfo.nextpage.focuspic			= SERVERINFO_ARROWSR;
#endif

	s_serverinfo.add.generic.type	  = MTYPE_PTEXT;
	s_serverinfo.add.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_serverinfo.add.generic.callback = ServerInfo_Event;
	s_serverinfo.add.generic.id	      = ID_ADD;
	s_serverinfo.add.generic.x		  = 320;
	s_serverinfo.add.generic.y		  = /*371*/420;	// JUHOX
	s_serverinfo.add.string  		  = "ADD TO FAVORITES";
	s_serverinfo.add.style  		  = UI_CENTER|UI_SMALLFONT;
	s_serverinfo.add.color			  =	color_red;
	if( trap_Cvar_VariableValue( "sv_running" ) ) {
		s_serverinfo.add.generic.flags |= QMF_GRAYED;
	}

	s_serverinfo.back.generic.type	   = MTYPE_BITMAP;
	s_serverinfo.back.generic.name     = SERVERINFO_BACK0;
	s_serverinfo.back.generic.flags    = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
	s_serverinfo.back.generic.callback = ServerInfo_Event;
	s_serverinfo.back.generic.id	   = ID_BACK;
	s_serverinfo.back.generic.x		   = 0;
	s_serverinfo.back.generic.y		   = 480-64;
	s_serverinfo.back.width  		   = 128;
	s_serverinfo.back.height  		   = 64;
	s_serverinfo.back.focuspic         = SERVERINFO_BACK1;

	trap_GetConfigString( CS_SERVERINFO, s_serverinfo.info, MAX_INFO_STRING );

	s_serverinfo.numlines = 0;
	s = s_serverinfo.info;
	while ( s ) {
		Info_NextPair( &s, key, value );
		if ( !key[0] ) {
			break;
		}
		s_serverinfo.numlines++;
	}

	// JUHOX: don't limit s_serverinfo.numlines to 16
#if 0
	if (s_serverinfo.numlines > 16)
		s_serverinfo.numlines = 16;
#endif

	Menu_AddItem( &s_serverinfo.menu, (void*) &s_serverinfo.banner );
	Menu_AddItem( &s_serverinfo.menu, (void*) &s_serverinfo.framel );
	Menu_AddItem( &s_serverinfo.menu, (void*) &s_serverinfo.framer );
	Menu_AddItem( &s_serverinfo.menu, &s_serverinfo.arrows);		// JUHOX
	Menu_AddItem( &s_serverinfo.menu, &s_serverinfo.prevpage);		// JUHOX
	Menu_AddItem( &s_serverinfo.menu, &s_serverinfo.nextpage);		// JUHOX
	Menu_AddItem( &s_serverinfo.menu, (void*) &s_serverinfo.add );
	Menu_AddItem( &s_serverinfo.menu, (void*) &s_serverinfo.back );

	UI_PushMenu( &s_serverinfo.menu );
}


