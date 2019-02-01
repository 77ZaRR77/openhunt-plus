// Copyright (C) 1999-2000 Id Software, Inc.
//
// cg_info.c -- display information while data is being loading

#include "cg_local.h"

#define MAX_LOADING_PLAYER_ICONS	16
#define MAX_LOADING_ITEM_ICONS		26

static int			loadingPlayerIconCount;
static int			loadingItemIconCount;
static qhandle_t	loadingPlayerIcons[MAX_LOADING_PLAYER_ICONS];
static qhandle_t	loadingItemIcons[MAX_LOADING_ITEM_ICONS];


/*
===================
CG_DrawLoadingIcons
===================
*/
static void CG_DrawLoadingIcons( void ) {
	int		n;
	int		x, y;

	for( n = 0; n < loadingPlayerIconCount; n++ ) {
		x = 16 + n * 78;
		y = 324-40;
		CG_DrawPic( x, y, 64, 64, loadingPlayerIcons[n] );
	}

	for( n = 0; n < loadingItemIconCount; n++ ) {
		y = 400-40;
		if( n >= 13 ) {
			y += 40;
		}
		x = 16 + n % 13 * 48;
		CG_DrawPic( x, y, 32, 32, loadingItemIcons[n] );
	}
}


/*
======================
CG_LoadingString

======================
*/
void CG_LoadingString( const char *s ) {
	Q_strncpyz( cg.infoScreenText, s, sizeof( cg.infoScreenText ) );

	trap_UpdateScreen();
}

/*
===================
CG_LoadingItem
===================
*/
void CG_LoadingItem( int itemNum ) {
	gitem_t		*item;

	item = &bg_itemlist[itemNum];

	if ( item->icon && loadingItemIconCount < MAX_LOADING_ITEM_ICONS ) {
		loadingItemIcons[loadingItemIconCount++] = trap_R_RegisterShaderNoMip( item->icon );
	}

	CG_LoadingString( item->pickup_name );
}

/*
===================
CG_LoadingClient
===================
*/
void CG_LoadingClient( int clientNum ) {
	const char		*info;
	char			*skin;
	char			personality[MAX_QPATH];
	char			model[MAX_QPATH];
	char			iconName[MAX_QPATH];


    static char infoBuf[MAX_INFO_STRING];

    infoBuf[0] = 0;
    switch (clientNum) {
    case CLIENTNUM_MONSTER_PREDATOR:
    case CLIENTNUM_MONSTER_PREDATOR_RED:
    case CLIENTNUM_MONSTER_PREDATOR_BLUE:
        Info_SetValueForKey(infoBuf, "n", "Predator");
        Info_SetValueForKey(infoBuf, "model", Info_ValueForKey(CG_ConfigString(CS_SERVERINFO), "monsterModel1"));
        info = infoBuf;
        break;
    case CLIENTNUM_MONSTER_GUARD:
        Info_SetValueForKey(infoBuf, "n", "Guard");
        Info_SetValueForKey(infoBuf, "model", Info_ValueForKey(CG_ConfigString(CS_SERVERINFO), "monsterModel2"));
        info = infoBuf;
        break;
    case CLIENTNUM_MONSTER_TITAN:
        Info_SetValueForKey(infoBuf, "n", "Titan");
        Info_SetValueForKey(infoBuf, "model", Info_ValueForKey(CG_ConfigString(CS_SERVERINFO), "monsterModel3"));
        info = infoBuf;
        break;
    default:
        info = CG_ConfigString(CS_PLAYERS + clientNum);
        break;
    }


	if ( loadingPlayerIconCount < MAX_LOADING_PLAYER_ICONS ) {
		Q_strncpyz( model, Info_ValueForKey( info, "model" ), sizeof( model ) );
		skin = Q_strrchr( model, '/' );
		if ( skin ) {
			*skin++ = '\0';
		} else {
			skin = "default";
		}

		Com_sprintf( iconName, MAX_QPATH, "models/players/%s/icon_%s.tga", model, skin );

		loadingPlayerIcons[loadingPlayerIconCount] = trap_R_RegisterShaderNoMip( iconName );
		if ( !loadingPlayerIcons[loadingPlayerIconCount] ) {
			Com_sprintf( iconName, MAX_QPATH, "models/players/characters/%s/icon_%s.tga", model, skin );
			loadingPlayerIcons[loadingPlayerIconCount] = trap_R_RegisterShaderNoMip( iconName );
		}
		if ( !loadingPlayerIcons[loadingPlayerIconCount] ) {
			Com_sprintf( iconName, MAX_QPATH, "models/players/%s/icon_%s.tga", DEFAULT_MODEL, "default" );
			loadingPlayerIcons[loadingPlayerIconCount] = trap_R_RegisterShaderNoMip( iconName );
		}
		if ( loadingPlayerIcons[loadingPlayerIconCount] ) {
			loadingPlayerIconCount++;
		}
	}

	Q_strncpyz( personality, Info_ValueForKey( info, "n" ), sizeof(personality) );
	Q_CleanStr( personality );

	if( cgs.gametype == GT_SINGLE_PLAYER ) {
		trap_S_RegisterSound( va( "sound/player/announce/%s.wav", personality ), qtrue );
	}

	CG_LoadingString( personality );
}


/*
====================
CG_DrawInformation

Draw all the status / pacifier stuff during level loading
====================
*/
void CG_DrawInformation( void ) {
	const char	*s;
	const char	*info;
	const char	*sysInfo;
	int			y;
	int			value;
	qhandle_t	levelshot;
	qhandle_t	detail;
	char		buf[1024];

	info = CG_ConfigString( CS_SERVERINFO );
	sysInfo = CG_ConfigString( CS_SYSTEMINFO );

	s = Info_ValueForKey( info, "mapname" );
	// JUHOX: don't use va() in CG_DrawInformation()
	Com_sprintf(buf, sizeof(buf), "levelshots/%s.tga", s);
	levelshot = trap_R_RegisterShaderNoMip(buf);

	if ( !levelshot ) {
		levelshot = trap_R_RegisterShaderNoMip( "menu/art/unknownmap" );
	}
	trap_R_SetColor( NULL );
	CG_DrawPic( 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, levelshot );

	// blend a detail texture over it
	detail = trap_R_RegisterShader( "levelShotDetail" );
	trap_R_DrawStretchPic( 0, 0, cgs.glconfig.vidWidth, cgs.glconfig.vidHeight, 0, 0, 2.5, 2, detail );

	// draw the icons of things as they are loaded
	CG_DrawLoadingIcons();

	// the first 150 rows are reserved for the client connection
	// screen to write into
	if ( cg.infoScreenText[0] ) {
		// JUHOX: don't use va() in CG_DrawInformation()

		Com_sprintf(buf, sizeof(buf), "%s", cg.infoScreenText);	// JUHOX
		UI_DrawProportionalString( 320, 128-5, buf,	UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
	} else {
		UI_DrawProportionalString( 320, 128-5, "Awaiting snapshot...",	// JUHOX
			UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
	}
	CG_DrawPic(30, 53, 580, 36, trap_R_RegisterShaderNoMip("gfx/hunt_name.tga"));	// JUHOX: draw "H U N T"

	// draw info string information

	y = 180-32;

	// don't print server lines if playing a local game
	trap_Cvar_VariableStringBuffer( "sv_running", buf, sizeof( buf ) );
	if ( !atoi( buf ) ) {
		// server hostname
		Q_strncpyz(buf, Info_ValueForKey( info, "sv_hostname" ), 1024);
		Q_CleanStr(buf);
		UI_DrawProportionalString( 320, y, buf,
			UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
		y += PROP_HEIGHT;

		// pure server
		s = Info_ValueForKey( sysInfo, "sv_pure" );
		if ( s[0] == '1' ) {
			UI_DrawProportionalString( 320, y, "Pure Server",
				UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
			y += PROP_HEIGHT;
		}

		// server-specific message of the day
		s = CG_ConfigString( CS_MOTD );
		if ( s[0] ) {
			UI_DrawProportionalString( 320, y, s,
				UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
			y += PROP_HEIGHT;
		}

		// some extra space after hostname and motd
		y += 10;
	}

	// map-specific message (long map name)
	s = CG_ConfigString( CS_MESSAGE );
	if ( s[0] ) {
		UI_DrawProportionalString( 320, y, s,
			UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
		y += PROP_HEIGHT;
	}

	// JUHOX: lens flare editor message
	if (cgs.editMode == EM_mlf) {
		UI_DrawProportionalString(320, y, "LENS FLARE EDITOR", UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite);
		return;
	}

	// cheats warning
	s = Info_ValueForKey( sysInfo, "sv_cheats" );
	if ( s[0] == '1' ) {
		UI_DrawProportionalString( 320, y, "CHEATS ARE ENABLED",
			UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
		y += PROP_HEIGHT;
	}

	// game type
	switch ( cgs.gametype ) {
	case GT_FFA:
		s = "Free For All";
		break;
	case GT_SINGLE_PLAYER:
		s = "Single Player";
		break;
	case GT_TOURNAMENT:
		s = "Tournament";
		break;
	case GT_TEAM:
		s = "Team Deathmatch";
		break;
	case GT_CTF:
		s = "Capture The Flag";
		break;
        // JUHOX: STU name for info screen
	case GT_STU:
		s = "Save the Universe";
		break;
        // JUHOX: EFH name for info screen
	case GT_EFH:
		s = "Escape from Hell";
		break;

	default:
		s = "Unknown Gametype";
		break;
	}
	UI_DrawProportionalString( 320, y, s, UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
	y += PROP_HEIGHT;

	value = atoi( Info_ValueForKey( info, "timelimit" ) );
	if ( value ) {

		Com_sprintf(buf, sizeof(buf), "timelimit %i", value);
		UI_DrawProportionalString( 320, y, buf,	UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );

		y += PROP_HEIGHT;
	}

	if (cgs.gametype < GT_CTF || cgs.gametype >= GT_STU) {

		value = atoi( Info_ValueForKey( info, "fraglimit" ) );
		if ( value ) {
		// JUHOX: don't use va() in CG_DrawInformation()

			Com_sprintf(buf, sizeof(buf), "fraglimit %i", value);
			UI_DrawProportionalString( 320, y, buf,
				UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );

			y += PROP_HEIGHT;
		}
	}

	if (cgs.gametype >= GT_CTF && cgs.gametype < GT_STU) {

		value = atoi( Info_ValueForKey( info, "capturelimit" ) );
		if ( value ) {
		// JUHOX: don't use va() in CG_DrawInformation()

			Com_sprintf(buf, sizeof(buf), "capturelimit %i", value);
			UI_DrawProportionalString( 320, y, buf,
				UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );

			y += PROP_HEIGHT;
		}
	}

	// JUHOX: draw artefacts limit
	if (cgs.gametype == GT_STU) {
		value = atoi(Info_ValueForKey(info, "g_artefacts"));
		if (value == 999) {
			UI_DrawProportionalString(320, y, "unlimited artefacts",
				UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite);
			y += PROP_HEIGHT;
		}
		else if (value) {
			Com_sprintf(buf, sizeof(buf), "artefacts %i", value);
			UI_DrawProportionalString(320, y, buf,
				UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite);
			y += PROP_HEIGHT;
		}
	}
}

