// Copyright (C) 1999-2000 Id Software, Inc.
//
// cg_draw.c -- draw all of the graphical elements during
// active (after loading) gameplay

#include "cg_local.h"

int drawTeamOverlayModificationCount = -1;
int sortedTeamPlayers[TEAM_MAXOVERLAY];
int	numSortedTeamPlayers;

char systemChat[256];
char teamChat1[256];
char teamChat2[256];


/*
==============
CG_DrawField

Draws large numbers for status bar and powerups
==============
*/
static void CG_DrawField (int x, int y, int width, int value) {
	char	num[16], *ptr;
	int		l;
	int		frame;

	if ( width < 1 ) return;

	// draw number string
	if ( width > 5 ) width = 5;

	switch ( width ) {
	case 1:
		value = value > 9 ? 9 : value;
		value = value < 0 ? 0 : value;
		break;
	case 2:
		value = value > 99 ? 99 : value;
		value = value < -9 ? -9 : value;
		break;
	case 3:
		value = value > 999 ? 999 : value;
		value = value < -99 ? -99 : value;
		break;
	case 4:
		value = value > 9999 ? 9999 : value;
		value = value < -999 ? -999 : value;
		break;
	}

	Com_sprintf (num, sizeof(num), "%i", value);
	l = strlen(num);
	if (l > width)
		l = width;
	x += 2 + CHAR_WIDTH*(width - l);

	ptr = num;
	while (*ptr && l)
	{
		if (*ptr == '-')
			frame = STAT_MINUS;
		else
			frame = *ptr -'0';

		CG_DrawPic( x,y, CHAR_WIDTH, CHAR_HEIGHT, cgs.media.numberShaders[frame] );
		x += CHAR_WIDTH;
		ptr++;
		l--;
	}
}


/*
================
CG_Draw3DModel

JUHOX: new parameter 'shader' for CG_Draw3DModel()
================
*/
void CG_Draw3DModel(float x, float y, float w, float h, qhandle_t model, qhandle_t skin, vec3_t origin, vec3_t angles, qhandle_t shader) {

	refdef_t		refdef;
	refEntity_t		ent;

	if ( !cg_draw3dIcons.integer || !cg_drawIcons.integer ) return;

	CG_AdjustFrom640( &x, &y, &w, &h );

	memset( &refdef, 0, sizeof( refdef ) );

	memset( &ent, 0, sizeof( ent ) );
	AnglesToAxis( angles, ent.axis );
	VectorCopy( origin, ent.origin );
	ent.hModel = model;
	ent.customSkin = skin;

	ent.customShader = shader;      // JUHOX: set shader
	ent.renderfx = RF_NOSHADOW;		// no stencil shadows

	refdef.rdflags = RDF_NOWORLDMODEL;

	AxisClear( refdef.viewaxis );

	refdef.fov_x = 30;
	refdef.fov_y = 30;

	refdef.x = x;
	refdef.y = y;
	refdef.width = w;
	refdef.height = h;

	refdef.time = cg.time;

	trap_R_ClearScene();
	trap_R_AddRefEntityToScene( &ent );
	trap_R_RenderScene( &refdef );
}

/*
================
CG_DrawHead

Used for both the status bar and the scoreboard
================
*/
void CG_DrawHead( float x, float y, float w, float h, int clientNum, vec3_t headAngles ) {
	clipHandle_t	cm;
	clientInfo_t	*ci;
	float			len;
	vec3_t			origin;
	vec3_t			mins, maxs;

	ci = &cgs.clientinfo[ clientNum ];

	if ( cg_draw3dIcons.integer ) {
		cm = ci->headModel;
		if ( !cm ) return;

		// offset the origin y and z to center the head
		trap_R_ModelBounds( cm, mins, maxs );

		origin[2] = -0.5 * ( mins[2] + maxs[2] );
		origin[1] = 0.5 * ( mins[1] + maxs[1] );

		// calculate distance so the head nearly fills the box
		// assume heads are taller than wide
		len = 0.7 * ( maxs[2] - mins[2] );
		origin[0] = len / 0.268;	// len / tan( fov/2 )

		// allow per-model tweaking
		VectorAdd( origin, ci->headOffset, origin );

		CG_Draw3DModel(x, y, w, h, ci->headModel, ci->headSkin, origin, headAngles, 0);

	} else if ( cg_drawIcons.integer ) {
		CG_DrawPic( x, y, w, h, ci->modelIcon );
	}

	// if they are deferred, draw a cross out
	if ( ci->deferred ) {
		CG_DrawPic( x, y, w, h, cgs.media.deferShader );
	}
}

/*
================
CG_DrawFlagModel

Used for both the status bar and the scoreboard
================
*/
void CG_DrawFlagModel( float x, float y, float w, float h, int team, qboolean force2D ) {
	qhandle_t		cm;
	float			len;
	vec3_t			origin, angles;
	vec3_t			mins, maxs;
	qhandle_t		handle;

	if ( !force2D && cg_draw3dIcons.integer ) {

		VectorClear( angles );

		cm = cgs.media.redFlagModel;

		// offset the origin y and z to center the flag
		trap_R_ModelBounds( cm, mins, maxs );

		origin[2] = -0.5 * ( mins[2] + maxs[2] );
		origin[1] = 0.5 * ( mins[1] + maxs[1] );

		// calculate distance so the flag nearly fills the box
		// assume heads are taller than wide
		len = 0.5 * ( maxs[2] - mins[2] );
		origin[0] = len / 0.268;	// len / tan( fov/2 )

		angles[YAW] = 60 * sin( cg.time / 2000.0 );;

		if( team == TEAM_RED ) {
			handle = cgs.media.redFlagModel;
		} else if( team == TEAM_BLUE ) {
			handle = cgs.media.blueFlagModel;
		} else if( team == TEAM_FREE ) {
			handle = cgs.media.neutralFlagModel;
		} else {
			return;
		}

		CG_Draw3DModel(x, y, w, h, handle, 0, origin, angles, 0);

	} else if ( cg_drawIcons.integer ) {
		gitem_t *item;

		if( team == TEAM_RED ) {
			item = BG_FindItemForPowerup( PW_REDFLAG );
		} else if( team == TEAM_BLUE ) {
			item = BG_FindItemForPowerup( PW_BLUEFLAG );
		} else if( team == TEAM_FREE ) {
			item = BG_FindItemForPowerup( PW_NEUTRALFLAG );
		} else {
			return;
		}
		if (item) {
		  CG_DrawPic( x, y, w, h, cg_items[ ITEM_INDEX(item) ].icon );
		}
	}
}

/*
================
CG_DrawStatusBarHead

================
*/
static void CG_DrawStatusBarHead( float x ) {
	vec3_t		angles;
	float		size, stretch;
	float		frac;

	VectorClear( angles );

	if ( cg.damageTime && cg.time - cg.damageTime < DAMAGE_TIME ) {
		frac = (float)(cg.time - cg.damageTime ) / DAMAGE_TIME;
		size = ICON_SIZE * 1.25 * ( 1.5 - frac * 0.5 );

		stretch = size - ICON_SIZE * 1.25;
		// kick in the direction of damage
		x -= stretch * 0.5 + cg.damageX * stretch * 0.5;

		cg.headStartYaw = 180 + cg.damageX * 45;

		cg.headEndYaw = 180 + 20 * cos( crandom()*M_PI );
		cg.headEndPitch = 5 * cos( crandom()*M_PI );

		cg.headStartTime = cg.time;
		cg.headEndTime = cg.time + 100 + random() * 2000;
	} else {
		if ( cg.time >= cg.headEndTime ) {
			// select a new head angle
			cg.headStartYaw = cg.headEndYaw;
			cg.headStartPitch = cg.headEndPitch;
			cg.headStartTime = cg.headEndTime;
			cg.headEndTime = cg.time + 100 + random() * 2000;

			cg.headEndYaw = 180 + 20 * cos( crandom()*M_PI );
			cg.headEndPitch = 5 * cos( crandom()*M_PI );
		}

		size = ICON_SIZE * 1.25;
	}

	// if the server was frozen for a while we may have a bad head start time
	if ( cg.headStartTime > cg.time ) {
		cg.headStartTime = cg.time;
	}

	frac = ( cg.time - cg.headStartTime ) / (float)( cg.headEndTime - cg.headStartTime );
	frac = frac * frac * ( 3 - 2 * frac );
	angles[YAW] = cg.headStartYaw + ( cg.headEndYaw - cg.headStartYaw ) * frac;
	angles[PITCH] = cg.headStartPitch + ( cg.headEndPitch - cg.headStartPitch ) * frac;

	CG_DrawHead( x, 480 - size, size, size,	cg.snap->ps.clientNum, angles );
}


/*
================
CG_DrawStatusBarFlag

================
*/
static void CG_DrawStatusBarFlag( float x, int team ) {
	CG_DrawFlagModel( x, 480 - ICON_SIZE, ICON_SIZE, ICON_SIZE, team, qfalse );
}


/*
================
CG_DrawTeamBackground

================
*/
void CG_DrawTeamBackground( int x, int y, int w, int h, float alpha, int team )
{
	vec4_t		hcolor;

	hcolor[3] = alpha;
	if ( team == TEAM_RED ) {
		hcolor[0] = 1;
		hcolor[1] = 0;
		hcolor[2] = 0;
	} else if ( team == TEAM_BLUE ) {
		hcolor[0] = 0;
		hcolor[1] = 0;
		hcolor[2] = 1;
	} else {
		return;
	}
	trap_R_SetColor( hcolor );
	CG_DrawPic( x, y, w, h, cgs.media.teamStatusBar );
	trap_R_SetColor( NULL );
}

/*
================
JUHOX: CG_SetValueColor
================
*/
static void CG_SetValueColor(int value, int stdValue, qboolean flash) {
	static float colors[4][4] = {
		{ 1, 0.69, 0, 1.0 } ,		// normal
		{ 1.0, 0.2, 0.2, 1.0 },		// low health
		{0.5, 0.5, 0.5, 1},			// weapon firing
		{ 1, 1, 1, 1 } };			// health > 100

	if (value > stdValue) {
		trap_R_SetColor(colors[3]);	// white
	} else if (value > 0.25*stdValue || !flash) {
		trap_R_SetColor(colors[0]);	// green
	} else if (value > 0) {
		int color;

		color = (cg.time >> 8) & 1;	// flash
		trap_R_SetColor(colors[color]);
	} else {
		trap_R_SetColor(colors[1]);	// red
	}
}

/*
================
JUHOX: CG_DrawStrengthBar
================
*/
static void CG_DrawStrengthBar(qboolean inStatusBar) {
	float color[4];
	float strength;
	float frac;
	float y;
	const float limit1 = 0.5;
	const float color1[3] = {1, 1, 1};
	const float limit2 = 0.333;
	const float color2[3] = {1, 0.69, 0};
	const float limit3 = 0.1;
	const float color3[3] = {1, 0.2, 0.2};

	if (!cgs.stamina) return;

	strength = cg.snap->ps.stats[STAT_STRENGTH] / MAX_STRENGTH_VALUE;

	if (strength < limit3) {
		color[0] = color3[0];
		color[1] = color3[1];
		color[2] = color3[2];
	}
	else if (strength < limit2) {
		frac = (strength - limit3) / (limit2 - limit3);
		color[0] = color3[0] + frac * (color2[0] - color3[0]);
		color[1] = color3[1] + frac * (color2[1] - color3[1]);
		color[2] = color3[2] + frac * (color2[2] - color3[2]);
	}
	else if (strength < limit1) {
		frac = (strength - limit2) / (limit1 - limit2);
		color[0] = color2[0] + frac * (color1[0] - color2[0]);
		color[1] = color2[1] + frac * (color1[1] - color2[1]);
		color[2] = color2[2] + frac * (color1[2] - color2[2]);
	}
	else {
		color[0] = color1[0];
		color[1] = color1[1];
		color[2] = color1[2];
	}
	color[3] = 1;

	if (strength < 0) {
		strength = 1;
		color[0] = 0;
		color[1] = 1;
		color[2] = 0;
	}
	else if (strength > 1) {
		strength = 1;
		color[0] = 0;
		color[1] = 0;
		color[2] = 1;
	}

	y = inStatusBar? 471 - ICON_SIZE : 471;

	CG_FillRect(220, y, 200 * strength, 5, color);

	color[0] = 0.5;
	color[1] = 0.5;
	color[2] = 0.5;
	CG_FillRect(220 + 200*strength, y, 200 * (1-strength), 5, color);
}

/*
================
CG_DrawStatusBar

================
*/
static void CG_DrawStatusBar( void ) {
	int			color;
	centity_t	*cent;
	playerState_t	*ps;
	int			value;
	vec4_t		hcolor;
	vec3_t		angles;
	vec3_t		origin;
	static float colors[4][4] = {
		{ 1.0f, 0.69f, 0.0f, 1.0f } ,	// normal
		{ 1.0f, 0.2f, 0.2f, 1.0f },		// low health
		{0.5f, 0.5f, 0.5f, 1.0f},		// weapon firing
		{ 1.0f, 1.0f, 1.0f, 1.0f } };	// health > 100

	if ( cg_drawStatus.integer == 0 ) return;

	// draw the team background
	CG_DrawTeamBackground( 0, 420, 640, 60, 0.33f, cg.snap->ps.persistant[PERS_TEAM] );

	if (cg.snap->ps.pm_type != PM_SPECTATOR) CG_DrawStrengthBar(qtrue);	// JUHOX

	cent = &cg_entities[cg.snap->ps.clientNum];
	ps = &cg.snap->ps;

	VectorClear( angles );

	// draw any 3D icons first, so the changes back to 2D are minimized
	if ( cent->currentState.weapon && cg_weapons[ cent->currentState.weapon ].ammoModel ) {
		origin[0] = 70;
		origin[1] = 0;
		origin[2] = 0;
		angles[YAW] = 90 + 20 * sin( cg.time / 1000.0 );

		if (cent->currentState.weapon == WP_MONSTER_LAUNCHER) {
			CG_Draw3DModel(
				CHAR_WIDTH*3 + TEXT_ICON_SPACE, 440, ICON_SIZE, ICON_SIZE,
				cg_weapons[WP_MONSTER_LAUNCHER].ammoModel, 0, origin, angles,
				cgs.media.monsterSeedMetalShader
			);
		}
		else
		{
			CG_Draw3DModel(	CHAR_WIDTH*3 + TEXT_ICON_SPACE, 432, ICON_SIZE, ICON_SIZE, cg_weapons[ cent->currentState.weapon ].ammoModel, 0, origin, angles, 0 );
		}
	}

	CG_DrawStatusBarHead( 185 + CHAR_WIDTH*3 + TEXT_ICON_SPACE );

	if (cg.snap->ps.pm_type == PM_SPECTATOR) return;	// JUHOX

	if( cg.predictedPlayerState.powerups[PW_REDFLAG] ) {
		CG_DrawStatusBarFlag( 185 + CHAR_WIDTH*3 + TEXT_ICON_SPACE + ICON_SIZE, TEAM_RED );
	} else if( cg.predictedPlayerState.powerups[PW_BLUEFLAG] ) {
		CG_DrawStatusBarFlag( 185 + CHAR_WIDTH*3 + TEXT_ICON_SPACE + ICON_SIZE, TEAM_BLUE );
	} else if( cg.predictedPlayerState.powerups[PW_NEUTRALFLAG] ) {
		CG_DrawStatusBarFlag( 185 + CHAR_WIDTH*3 + TEXT_ICON_SPACE + ICON_SIZE, TEAM_FREE );
	}

	if ( ps->stats[ STAT_ARMOR ] ) {
		origin[0] = 90;
		origin[1] = 0;
		origin[2] = -10;
		angles[YAW] = ( cg.time & 2047 ) * 360 / 2048.0;

		CG_Draw3DModel( 370 + CHAR_WIDTH*4 + TEXT_ICON_SPACE, 432, ICON_SIZE, ICON_SIZE, cgs.media.armorModel, 0, origin, angles, 0);
	}
	//
	// ammo
	//
	if ( cent->currentState.weapon ) {
		value = ps->ammo[cent->currentState.weapon];
		if ( value > -1 ) {
			if ( cg.predictedPlayerState.weaponstate == WEAPON_FIRING && cg.predictedPlayerState.weaponTime > 100 ) {
				// draw as dark grey when reloading
				color = 2;	    // dark grey
			} else {
				if ( value >= 0 ) {
					color = 0;	// green
				} else {
					color = 1;	// red
				}

				if (cg.viewMode == VIEW_scanner) color = 1;	// JUHOX: show that ammo is not recharging
			}
			trap_R_SetColor( colors[color] );

			CG_DrawField (0, 432, 3, value);
			trap_R_SetColor( NULL );

			// if we didn't draw a 3D icon, draw a 2D icon for ammo
			if ( !cg_draw3dIcons.integer && cg_drawIcons.integer ) {
				qhandle_t	icon;

				icon = cg_weapons[ cg.predictedPlayerState.weapon ].ammoIcon;
				if ( icon ) {
					CG_DrawPic( CHAR_WIDTH*3 + TEXT_ICON_SPACE, 432, ICON_SIZE, ICON_SIZE, icon );
				}
			}
		}
	}

	//
	// health
	//
	value = ps->stats[STAT_HEALTH];
	CG_SetValueColor(value, ps->stats[STAT_MAX_HEALTH], qtrue/*flash if low*/);

	// stretch the health up when taking damage
	CG_DrawField(185-CHAR_WIDTH, 432, 4, value);
	CG_ColorForHealth( hcolor );
	trap_R_SetColor( hcolor );


	//
	// armor
	//
	value = ps->stats[STAT_ARMOR];
	if (value > 0 ) {
		CG_SetValueColor(value, ps->stats[STAT_MAX_HEALTH], qfalse/*don't flash if low*/);
		CG_DrawField(370, 432, 4, value);
		trap_R_SetColor( NULL );

		// if we didn't draw a 3D icon, draw a 2D icon for armor
		if ( !cg_draw3dIcons.integer && cg_drawIcons.integer )
			CG_DrawPic(370 + CHAR_WIDTH*4 + TEXT_ICON_SPACE, 432, ICON_SIZE, ICON_SIZE, cgs.media.armorIcon);
	}
}


/*
===========================================================================================

  UPPER RIGHT CORNER

===========================================================================================
*/

/*
================
CG_DrawAttacker

================
*/
static float CG_DrawAttacker( float y ) {
	int			t;
	float		size;
	vec3_t		angles;
	const char	*info;
	const char	*name;
	int			clientNum;

	if ( cg.predictedPlayerState.stats[STAT_HEALTH] <= 0 ) return y;
	if ( !cg.attackerTime ) return y;

	clientNum = cg.predictedPlayerState.persistant[PERS_ATTACKER];
	if ( clientNum < 0 || clientNum >= MAX_CLIENTS || clientNum == cg.snap->ps.clientNum ) return y;

	t = cg.time - cg.attackerTime;
	if ( t > ATTACKER_HEAD_TIME ) {
		cg.attackerTime = 0;
		return y;
	}

	size = ICON_SIZE * 1.25;

	angles[PITCH] = 0;
	angles[YAW] = 180;
	angles[ROLL] = 0;
	CG_DrawHead( 640 - size, y, size, size, clientNum, angles );

	info = CG_ConfigString( CS_PLAYERS + clientNum );
	name = Info_ValueForKey(  info, "n" );
	y += size;
	CG_DrawBigString( 640 - ( Q_PrintStrlen( name ) * BIGCHAR_WIDTH), y, name, 0.5 );

	return y + BIGCHAR_HEIGHT + 2;
}

/*
==================
CG_DrawSnapshot
==================
*/
static float CG_DrawSnapshot( float y ) {
	char		*s;
	int			w;

	s = va( "time:%i snap:%i cmd:%i", cg.snap->serverTime, cg.latestSnapshotNum, cgs.serverCommandSequence );
	w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;

	CG_DrawBigString( 635 - w, y + 2, s, 1.0F);

	return y + BIGCHAR_HEIGHT + 4;
}

/*
==================
CG_DrawFPS
==================
*/
#define	FPS_FRAMES	4
static float CG_DrawFPS( float y ) {
	char		*s;
	int			w;
	static int	previousTimes[FPS_FRAMES];
	static int	index;
	int		i, total;
	int		fps;
	static	int	previous;
	int		t, frameTime;

	// don't use serverTime, because that will be drifting to
	// correct for internet lag changes, timescales, timedemos, etc
	t = trap_Milliseconds();
	frameTime = t - previous;
	previous = t;

	previousTimes[index % FPS_FRAMES] = frameTime;
	index++;
	if ( index > FPS_FRAMES ) {
		// average multiple frames together to smooth changes out a bit
		total = 0;
		for ( i = 0 ; i < FPS_FRAMES ; i++ ) {
			total += previousTimes[i];
		}
		if ( !total ) {
			total = 1;
		}
		fps = 1000 * FPS_FRAMES / total;

		s = va( "%ifps", fps );
		w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;

		CG_DrawBigString( 635 - w, y + 2, s, 1.0F);
	}

	return y + BIGCHAR_HEIGHT + 4;
}

/*
==================
JUHOX: CG_DrawNumMonsters
==================
*/
static float CG_DrawNumMonsters(float y) {
	char* s;
	int w;

	s = va("Monsters: %d", atoi(CG_ConfigString(CS_NUMMONSTERS)));
	w = CG_DrawStrlen(s) * BIGCHAR_WIDTH;
	CG_DrawBigString(635 - w, y + 2, s, 1);
	return y + BIGCHAR_HEIGHT + 4;
}

/*
==================
JUHOX: CG_DrawSegment
==================
*/
static float CG_DrawSegment(float y) {
	const char* s;
	int w;

	s = CG_ConfigString(CS_EFH_SEGMENT);
	w = CG_DrawStrlen(s) * SMALLCHAR_WIDTH;
	CG_DrawSmallString(635 - w, y + 2, s, 1);
	return y + SMALLCHAR_HEIGHT + 4;
}


/*
==================
JUHOX: CG_DrawWeaponLimit
==================
*/
static float CG_DrawWeaponLimit(float y) {
	const char* s;
	int n;
	int w;

	s = CG_ConfigString(CS_CHOOSENWEAPONS);
	n = 0;
	if (strlen(s) > cg.snap->ps.clientNum) {
		n = s[cg.snap->ps.clientNum] - 'A';
		if (n >= cgs.weaponLimit) return y;
	}
	s = va("selected weapons: %d/%d", n, cgs.weaponLimit);
	w = CG_DrawStrlen(s) * BIGCHAR_WIDTH;
	CG_DrawBigString(635 - w, y + 2, s, 1.0);
	return y + BIGCHAR_HEIGHT + 4;
}

/*
=================
CG_DrawTimer
=================
*/
static float CG_DrawTimer( float y ) {
	char		*s;
	int			w;
	int			mins, seconds, tens;
	int			msec;

	msec = cg.time - cgs.levelStartTime;

	seconds = msec / 1000;
	mins = seconds / 60;
	seconds -= mins * 60;
	tens = seconds / 10;
	seconds -= tens * 10;

	s = va( "%i:%i%i", mins, tens, seconds );
	w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;

	CG_DrawBigString( 635 - w, y + 2, s, 1.0F);

	return y + BIGCHAR_HEIGHT + 4;
}


/*
=================
CG_DrawTeamOverlay
=================
*/

static float CG_DrawTeamOverlay( float y, qboolean right, qboolean upper ) {
	int x, w, h, xx;
	int i, j, len;
	const char *p;
	vec4_t		hcolor;
	int pwidth, lwidth;
	int plyrs;
	char st[16];
	clientInfo_t *ci;
	gitem_t	*item;
	int ret_y, count;

	if (cg.tssInterfaceOn) return y;	// JUHOX
	if ( !cg_drawTeamOverlay.integer ) return y;
	if ( cg.snap->ps.persistant[PERS_TEAM] != TEAM_RED && cg.snap->ps.persistant[PERS_TEAM] != TEAM_BLUE ) return y; // Not on any team

	plyrs = 0;

	// max player name width
	pwidth = 0;
	count = (numSortedTeamPlayers > 8) ? 8 : numSortedTeamPlayers;
	for (i = 0; i < count; i++) {
		ci = cgs.clientinfo + sortedTeamPlayers[i];
		if ( ci->infoValid && ci->team == cg.snap->ps.persistant[PERS_TEAM]) {
			plyrs++;
			len = CG_DrawStrlen(ci->name);
			if (len > pwidth)
				pwidth = len;
		}
	}

	if (!plyrs) return y;

	if (pwidth > TEAM_OVERLAY_MAXNAME_WIDTH)
		pwidth = TEAM_OVERLAY_MAXNAME_WIDTH;

	pwidth += 2;	// JUHOX: make room for the group mark

	// max location name width
	lwidth = 0;
	for (i = 1; i < MAX_LOCATIONS; i++) {
		p = CG_ConfigString(CS_LOCATIONS + i);
		if (p && *p) {
			len = CG_DrawStrlen(p);
			if (len > lwidth)
				lwidth = len;
		}
	}

	// JUHOX: make room for way length
	if (cgs.gametype == GT_EFH) {
		lwidth = 7;
	}

	if (lwidth > TEAM_OVERLAY_MAXLOCATION_WIDTH)
		lwidth = TEAM_OVERLAY_MAXLOCATION_WIDTH;

	w = (pwidth + lwidth + 4 + 7) * TINYCHAR_WIDTH;

	// JUHOX: make more room for health & armor if needed
	if (cgs.baseHealth >= 500)
		w += 2 * TINYCHAR_WIDTH;

	if ( right )
		x = 640 - w;
	else
		x = 0;

	h = plyrs * TINYCHAR_HEIGHT;

	if ( upper ) {
		ret_y = y + h;
	} else {
		y -= h;
		ret_y = y;
	}

	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED ) {
		hcolor[0] = 1.0f;
		hcolor[1] = 0.0f;
		hcolor[2] = 0.0f;
		hcolor[3] = 0.33f;
	} else {
		hcolor[0] = 0.0f;
		hcolor[1] = 0.0f;
		hcolor[2] = 1.0f;
		hcolor[3] = 0.33f;
	}
	trap_R_SetColor( hcolor );
	CG_DrawPic( x, y, w, h, cgs.media.teamStatusBar );
	trap_R_SetColor( NULL );

	for (i = 0; i < count; i++) {
		ci = cgs.clientinfo + sortedTeamPlayers[i];
		if ( ci->infoValid && ci->team == cg.snap->ps.persistant[PERS_TEAM]) {

			hcolor[0] = hcolor[1] = hcolor[2] = hcolor[3] = 1.0;

			xx = x + TINYCHAR_WIDTH;

			CG_DrawStringExt( xx, y,
				ci->name, hcolor, qfalse, qfalse,
				TINYCHAR_WIDTH, TINYCHAR_HEIGHT, TEAM_OVERLAY_MAXNAME_WIDTH);

            // JUHOX: draw the group mark
			if (ci->group >= 0 && ci->health > 0 && ci->location >= 0) {
				char buf[4];
				const vec4_t leaderColor = {1, 0.7, 0, 1};
				const vec4_t retreatingColor = {0.5, 0.5, 0.5, 1};
				const float* color;

				buf[0] = ci->group + 'A';
				buf[1] = 0;
				switch (ci->memberStatus) {
				case TSSGMS_designatedLeader:
				case TSSGMS_temporaryLeader:
					color = leaderColor;
					break;
				case TSSGMS_retreating:
				default:
					color = retreatingColor;
					break;
				case TSSGMS_temporaryFighter:
				case TSSGMS_designatedFighter:
					color = hcolor;
					break;
				}
				xx += (pwidth - 1) * TINYCHAR_WIDTH;
				CG_DrawStringExt(xx, y, buf, color, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
			}

			if (cgs.gametype == GT_EFH) {
				p = va("%dm", ci->wayLength);
				len = strlen(p);
				xx = x + TINYCHAR_WIDTH * 2 + TINYCHAR_WIDTH * pwidth + (lwidth - len) * TINYCHAR_WIDTH;
				CG_DrawStringExt(xx, y, p, hcolor, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, lwidth);
			} else if (lwidth && ci->health > 0 && ci->location >= 0) {

				p = CG_ConfigString(CS_LOCATIONS + ci->location);
				if (!p || !*p)
					p = "unknown";
				len = CG_DrawStrlen(p);
				if (len > lwidth)
					len = lwidth;

				xx = x + TINYCHAR_WIDTH * 2 + TINYCHAR_WIDTH * pwidth;
				CG_DrawStringExt( xx, y, p, hcolor, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, TEAM_OVERLAY_MAXLOCATION_WIDTH);
			}

			if (ci->location >= 0) {
				xx = x + TINYCHAR_WIDTH * 3 +
					TINYCHAR_WIDTH * pwidth + TINYCHAR_WIDTH * lwidth;

				CG_GetColorForHealth(ci->health, ci->armor, (cgs.baseHealth * ci->handicap) / 100, hcolor);

				if (cgs.baseHealth >= 500) {
					Com_sprintf(st, sizeof(st), "%4i %4i", ci->health, ci->armor);
					CG_DrawStringExt(xx, y, st, hcolor, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
					xx += TINYCHAR_WIDTH * 4;
				}
				else {
					Com_sprintf(st, sizeof(st), "%3i %3i", ci->health, ci->armor);
					CG_DrawStringExt(xx, y, st, hcolor, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
					xx += TINYCHAR_WIDTH * 3;
				}


				// draw weapon icon
				if ( cg_weapons[ci->curWeapon].weaponIcon ) {
					CG_DrawPic( xx, y, TINYCHAR_WIDTH, TINYCHAR_HEIGHT,
						cg_weapons[ci->curWeapon].weaponIcon );
				} else {
					CG_DrawPic( xx, y, TINYCHAR_WIDTH, TINYCHAR_HEIGHT,
						cgs.media.deferShader );
				}
			}

			// Draw powerup icons
			if (right) {
				xx = x;
			} else {
				xx = x + w - TINYCHAR_WIDTH;
			}
	// JUHOX: draw fight-in-progress icon
			if (ci->pfmi & PFMI_FIGHTING) {
				if (cg.time % 1200 < 900) {
					CG_DrawPic(xx, y, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, cgs.media.fightInProgressShader);
				}
				xx += right? -TINYCHAR_WIDTH : TINYCHAR_WIDTH;
			}

			for (j = /*0*/1; j </*=*/ PW_NUM_POWERUPS; j++) {	// JUHOX
	// JUHOX: don't draw the misused powerups
				if ( j == PW_INVIS || j == PW_BATTLESUIT ||	j == PW_QUAD ||	j == PW_HASTE || j == PW_BFG_RELOADING ) {
					continue;
				}

				if (ci->powerups & (1 << j)) {

					item = BG_FindItemForPowerup( j );

					if (item) {
						CG_DrawPic( xx, y, TINYCHAR_WIDTH, TINYCHAR_HEIGHT,
						trap_R_RegisterShader( item->icon ) );
						if (right) {
							xx -= TINYCHAR_WIDTH;
						} else {
							xx += TINYCHAR_WIDTH;
						}
					}
				}
			}

			y += TINYCHAR_HEIGHT;
		}
	}

	return ret_y;

}


/*
=====================
CG_DrawUpperRight

=====================
*/
static void CG_DrawUpperRight( void ) {
	float	y = 0;

	// JUHOX: draw lens flare editor title
	if (cgs.editMode == EM_mlf) {
		CG_DrawBigString(640 - 17 * BIGCHAR_WIDTH, y, "lens flare editor", 1);
		y += BIGCHAR_HEIGHT;
	}

	if ( cgs.gametype >= GT_TEAM && cg_drawTeamOverlay.integer == 1 ) {
		y = CG_DrawTeamOverlay( y, qtrue, qtrue );
	}
	if ( cg_drawSnapshot.integer ) {
		y = CG_DrawSnapshot( y );
	}
	// JUHOX: draw current number of monsters
	if (
		cg_drawNumMonsters.integer &&
		(
			cgs.gametype >= GT_STU ||
			cgs.monsterLauncher
		)
	) {
		y = CG_DrawNumMonsters(y);
	}

	// JUHOX: draw current segment
	if (cgs.gametype == GT_EFH && cg_drawSegment.integer) {
		y = CG_DrawSegment(y);
	}

	if ( cg_drawFPS.integer ) {
		y = CG_DrawFPS( y );
	}
	if ( cg_drawTimer.integer ) {
		y = CG_DrawTimer( y );
	}
	// JUHOX: draw weapon limit
	if (cgs.weaponLimit > 0) {
		y = CG_DrawWeaponLimit(y);
	}

	if ( cg_drawAttacker.integer ) {
		y = CG_DrawAttacker( y );
	}

}

/*
===========================================================================================

  LOWER RIGHT CORNER

===========================================================================================
*/

/*
=================
CG_DrawScores

Draw the small two score display
=================
*/
static float CG_DrawScores( float y ) {
	const char	*s;
	int			s1, s2, score;
	int			x, w;
	int			v;
	vec4_t		color;
	float		y1;
	gitem_t		*item;

	s1 = cgs.scores1;
	s2 = cgs.scores2;

	y -=  BIGCHAR_HEIGHT + 8;

	y1 = y;

	// draw from the right side to left
	// JUHOX: draw STU scores
	if (cgs.gametype >= GT_STU) {
		const int iconsize = BIGCHAR_HEIGHT;

		x = 640;
		if (cgs.gametype == GT_EFH && cgs.debugEFH) {
			s = CG_ConfigString(CS_EFH_DEBUG);
			w = CG_DrawStrlen(s) * BIGCHAR_WIDTH;
			x -= w;
			CG_DrawBigString(x, y, s, 1);
		}


		if (cgs.artefacts > 0) {
			if (cgs.artefacts < 999) {
				s = va("%i", cgs.artefacts - cgs.scores1);
			}
			else {
				s = va("%i", cgs.scores1);
			}
			w = CG_DrawStrlen(s) * BIGCHAR_WIDTH;
			x -= w;
			CG_DrawBigString(x, y, s, 1);

			x -= iconsize;
			CG_DrawPic(x, y, iconsize, iconsize, cgs.media.artefactsShader);

			x -= iconsize;
			if (cg.detectorBeepTime > cg.time - 100) {
				CG_DrawPic(x, y, iconsize, iconsize, cgs.media.detectorShader);
			}

			x -= iconsize;
		}

		if (cgs.fraglimit > 0) {
			s = va("%i", cgs.fraglimit - cgs.scores2);
			w = CG_DrawStrlen(s) * BIGCHAR_WIDTH;
			x -= w;
			CG_DrawBigString(x, y, s, 1);

			x -= iconsize;
			CG_DrawPic(x, y, iconsize, iconsize, cgs.media.lifesShader);

			x -= iconsize;
		}

		if (cgs.timelimit > 0) {
			int msec;
			int secs;
			int mins;

			msec = 60000 * cgs.timelimit - (cg.time - cgs.levelStartTime);

			{
				int limit;

				limit = atoi(CG_ConfigString(CS_EFH_GOAL_DISTANCE));
				if (limit > 0 && cgs.distanceLimit > 0) {
					msec += (60000 * (limit - cgs.distanceLimit) * cgs.timelimit) / cgs.distanceLimit;
				}
			}

			if (msec < 0) msec = 0;
			mins = msec / 60000;
			secs = (msec % 60000) / 1000;

			s = va("%i:%02i", mins, secs);
			w = CG_DrawStrlen(s) * BIGCHAR_WIDTH;
			x -= w;
			CG_DrawBigString(x, y, s, 1);

			x -= iconsize;

			if (cgs.gametype == GT_EFH) {
				if (msec > 10000) {
					CG_DrawPic(x, y, iconsize, iconsize, cgs.media.clockShader);
				}
				else {
					if (cg.time % 700 < 450) {
						CG_DrawPic(x, y, iconsize, iconsize, cgs.media.clockShader);
					}
					if (secs != cg.countDown) {
						trap_S_StartLocalSound(cgs.media.respawnWarnSound, CHAN_ANNOUNCER);
					}
					cg.countDown = secs;
				}
			}
			else {
				CG_DrawPic(x, y, iconsize, iconsize, cgs.media.clockShader);
			}
		}

		if (cgs.gametype == GT_EFH) {
			long dist;
			long limit;
			vec4_t color;

			y -= BIGCHAR_HEIGHT;
			y1 = y;
			x = 640;

			dist = atoi(CG_ConfigString(CS_EFH_COVERED_DISTANCE));
			limit = atoi(CG_ConfigString(CS_EFH_GOAL_DISTANCE));
			if (limit <= 0) {
				limit = cgs.distanceLimit;
			}

			color[0] = 1;
			color[1] = 1;
			color[2] = 1;
			color[3] = 1;

			if (limit > 0) {
				float timelimit;

				dist = limit - dist;
				timelimit = cgs.timelimit;
				if (timelimit <= 0 && cgs.recordType == GC_speed && cgs.record > 0) {
					timelimit = (float)limit / (0.001 * cgs.record);
				}

				if (timelimit > 0) {
					float extraTime;
					float remainingTime;
					float avgDist;
					float maxDeviation;
					float loLimit;
					float hiLimit;

					extraTime = 0;
					if (cgs.distanceLimit > 0 && cgs.timelimit > 0) {
						extraTime = (float)((limit - cgs.distanceLimit) * timelimit) / (float)(cgs.distanceLimit);
					}
					remainingTime = 60.0 * (timelimit + extraTime) - 0.001 * (cg.time - cgs.levelStartTime);
					avgDist = limit * remainingTime / (60.0 * timelimit);
					maxDeviation = 0.2 * dist;
					loLimit = avgDist - maxDeviation;
					hiLimit = avgDist + maxDeviation;
					if (dist <= loLimit) {
						// green
						color[0] = 0;
						color[2] = 0;
					}
					else if (dist >= hiLimit) {
						// red
						color[1] = 0;
						color[2] = 0;
					}
					else if (dist <= avgDist) {
						// light green
						color[0] = color[2] = (dist - loLimit) / maxDeviation;
					}
					else {
						// light red
						color[1] = color[2] = 1 - (dist - avgDist) / maxDeviation;
					}
				}
			}
			if (dist < 0) dist = 0;
			s = va("%d.%03dkm", dist / 1000, dist % 1000);
			w = CG_DrawStrlen(s) * BIGCHAR_WIDTH;
			x -= w;
			CG_DrawBigStringColor(x, y, s, color);
		}

		y -= BIGCHAR_HEIGHT;
		y1 = y;
		x = 640;

		{
			vec4_t color;
			int score;

			score = atoi(CG_ConfigString(CS_STU_SCORE));
			color[0] = color[1] = color[2] = color[3] = 1;
			if (
				cgs.timelimit > 0 &&
				cgs.recordType == GC_score &&
				cgs.record > 0
			) {
				float remainingSecs;
				float estRemScore;
				float maxDeviation;
				float loLimit;
				float hiLimit;
				float remainingScore;

				remainingSecs = 60.0 * cgs.timelimit - 0.001 * (cg.time - cgs.levelStartTime);
				estRemScore = cgs.record * remainingSecs / (60.0 * cgs.timelimit);
				remainingScore = cgs.record - score;
				maxDeviation = 0.2 * remainingScore;
				loLimit = estRemScore - maxDeviation;
				hiLimit = estRemScore + maxDeviation;
				if (remainingScore <= loLimit) {
					// green
					color[0] = 0;
					color[2] = 0;
				}
				else if (remainingScore >= hiLimit) {
					// red
					color[1] = 0;
					color[2] = 0;
				}
				else if (remainingScore <= estRemScore) {
					// light green
					color[0] = color[2] = (remainingScore - loLimit) / maxDeviation;
				}
				else {
					// light red
					color[1] = color[2] = 1 - (remainingScore - estRemScore) / maxDeviation;
				}
			}
			s = va("$%d", score);
			w = CG_DrawStrlen(s) * BIGCHAR_WIDTH;
			x -= w;
			CG_DrawBigStringColor(x, y, s, color);
		}
	}
	else

	if ( cgs.gametype >= GT_TEAM ) {
		x = 640;

		color[0] = 0.0f;
		color[1] = 0.0f;
		color[2] = 1.0f;
		color[3] = 0.33f;
		s = va( "%2i", s2 );
		w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
		x -= w;
		CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
		if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE ) {
			CG_DrawPic( x, y-4, w, BIGCHAR_HEIGHT+8, cgs.media.selectShader );
		}
		CG_DrawBigString( x + 4, y, s, 1.0F);

		if ( cgs.gametype == GT_CTF ) {
			// Display flag status
			item = BG_FindItemForPowerup( PW_BLUEFLAG );

			if (item) {
				y1 = y - BIGCHAR_HEIGHT - 8;
				if( cgs.blueflag >= 0 && cgs.blueflag <= 2 ) {
					CG_DrawPic( x, y1-4, w, BIGCHAR_HEIGHT+8, cgs.media.blueFlagShader[cgs.blueflag] );
				}
			}
		}

		color[0] = 1.0f;
		color[1] = 0.0f;
		color[2] = 0.0f;
		color[3] = 0.33f;
		s = va( "%2i", s1 );
		w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
		x -= w;
		CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
		if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED ) {
			CG_DrawPic( x, y-4, w, BIGCHAR_HEIGHT+8, cgs.media.selectShader );
		}
		CG_DrawBigString( x + 4, y, s, 1.0F);

		if ( cgs.gametype == GT_CTF ) {
			// Display flag status
			item = BG_FindItemForPowerup( PW_REDFLAG );

			if (item) {
				y1 = y - BIGCHAR_HEIGHT - 8;
				if( cgs.redflag >= 0 && cgs.redflag <= 2 ) {
					CG_DrawPic( x, y1-4, w, BIGCHAR_HEIGHT+8, cgs.media.redFlagShader[cgs.redflag] );
				}
			}
		}

		if (cgs.gametype == GT_CTF) {
			v = cgs.capturelimit;
		} else {
			v = cgs.fraglimit;
		}
		if ( v ) {
			s = va( "%2i", v );
			w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
			x -= w;
			CG_DrawBigString( x + 4, y, s, 1.0F);
		}

	} else {
		qboolean	spectator;

		x = 640;
		score = cg.snap->ps.persistant[PERS_SCORE];
		spectator = ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR );

		// always show your score in the second box if not in first place
		if ( s1 != score ) {
			s2 = score;
		}
		if ( s2 != SCORE_NOT_PRESENT ) {
			s = va( "%2i", s2 );
			w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
			x -= w;
			if ( !spectator && score == s2 && score != s1 ) {
				color[0] = 1.0f;
				color[1] = 0.0f;
				color[2] = 0.0f;
				color[3] = 0.33f;
				CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
				CG_DrawPic( x, y-4, w, BIGCHAR_HEIGHT+8, cgs.media.selectShader );
			} else {
				color[0] = 0.5f;
				color[1] = 0.5f;
				color[2] = 0.5f;
				color[3] = 0.33f;
				CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
			}
			CG_DrawBigString( x + 4, y, s, 1.0F);
		}

		// first place
		if ( s1 != SCORE_NOT_PRESENT ) {
			s = va( "%2i", s1 );
			w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
			x -= w;
			if ( !spectator && score == s1 ) {
				color[0] = 0.0f;
				color[1] = 0.0f;
				color[2] = 1.0f;
				color[3] = 0.33f;
				CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
				CG_DrawPic( x, y-4, w, BIGCHAR_HEIGHT+8, cgs.media.selectShader );
			} else {
				color[0] = 0.5f;
				color[1] = 0.5f;
				color[2] = 0.5f;
				color[3] = 0.33f;
				CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
			}
			CG_DrawBigString( x + 4, y, s, 1.0F);
		}

		if ( cgs.fraglimit ) {
			s = va( "%2i", cgs.fraglimit );
			w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
			x -= w;
			CG_DrawBigString( x + 4, y, s, 1.0F);
		}

	}

	return y1 - 8;
}

/*
================
CG_DrawPowerups
================
*/
static float CG_DrawPowerups( float y ) {
	int		sorted[MAX_POWERUPS];
	int		sortedTime[MAX_POWERUPS];
	int		i, j, k;
	int		active;
	playerState_t	*ps;
	int		t;
	gitem_t	*item;
	int		x;
	int		color;
	float	size;
	float	f;
	static float colors[2][4] = {
    { 0.2f, 1.0f, 0.2f, 1.0f } ,
    { 1.0f, 0.2f, 0.2f, 1.0f }
  };

	ps = &cg.snap->ps;

	if ( ps->stats[STAT_HEALTH] <= 0 ) {
		return y;
	}

	// sort the list by time remaining
	active = 0;
	for ( i = 0 ; i < /*MAX_POWERUPS*/PW_NUM_POWERUPS ; i++ ) {	// JUHOX
		if ( !ps->powerups[ i ] ) {
			continue;
		}
		// JUHOX: don't draw timer for misused powerups
		if (i == PW_HASTE) continue;
		if (i == PW_BATTLESUIT) continue;

		if (i == PW_INVIS) continue;
		if (i == PW_BFG_RELOADING) continue;

		t = ps->powerups[ i ] - cg.time;
		// ZOID--don't draw if the power up has unlimited time (999 seconds)
		// This is true of the CTF flags
		if ( t < 0 || t > 999000) {
			continue;
		}

		// insert into the list
		for ( j = 0 ; j < active ; j++ ) {
			if ( sortedTime[j] >= t ) {
				for ( k = active - 1 ; k >= j ; k-- ) {
					sorted[k+1] = sorted[k];
					sortedTime[k+1] = sortedTime[k];
				}
				break;
			}
		}
		sorted[j] = i;
		sortedTime[j] = t;
		active++;
	}

	// draw the icons and timers
	x = 640 - ICON_SIZE - CHAR_WIDTH * 2;
	for ( i = 0 ; i < active ; i++ ) {
		item = BG_FindItemForPowerup( sorted[i] );

    if (item) {

		  color = 1;

		  y -= ICON_SIZE;

		  trap_R_SetColor( colors[color] );
		  CG_DrawField( x, y, 2, sortedTime[ i ] / 1000 );

		  t = ps->powerups[ sorted[i] ];
		  // JUHOX: don't let the charge powerup blink as it runs out

		  if ( t - cg.time >= POWERUP_BLINKS * POWERUP_BLINK_TIME || sorted[i] == PW_CHARGE) {

			  trap_R_SetColor( NULL );
		  } else {
			  vec4_t	modulate;

			  f = (float)( t - cg.time ) / POWERUP_BLINK_TIME;
			  f -= (int)f;
			  modulate[0] = modulate[1] = modulate[2] = modulate[3] = f;
			  trap_R_SetColor( modulate );
		  }

		  if ( cg.powerupActive == sorted[i] &&
			  cg.time - cg.powerupTime < PULSE_TIME ) {
			  f = 1.0 - ( ( (float)cg.time - cg.powerupTime ) / PULSE_TIME );
			  size = ICON_SIZE * ( 1.0 + ( PULSE_SCALE - 1.0 ) * f );
		  } else {
			  size = ICON_SIZE;
		  }

		  CG_DrawPic( 640 - size, y + ICON_SIZE / 2 - size / 2,
			  size, size, trap_R_RegisterShader( item->icon ) );
    }
	}
	trap_R_SetColor( NULL );

	return y;
}


/*
=====================
CG_DrawLowerRight

=====================
*/
static void CG_DrawLowerRight( void ) {
	float	y;

	// JUHOX: don't draw scores in lens flare editor
	if (cgs.editMode == EM_mlf) return;

	y = 480 - ICON_SIZE;

	if ( cgs.gametype >= GT_TEAM && cg_drawTeamOverlay.integer == 2 ) {
		y = CG_DrawTeamOverlay( y, qtrue, qfalse );
	}

	y = CG_DrawScores( y );
	y = CG_DrawPowerups( y );
}


/*
===================
JUHOX: CG_DrawWeaponOrderName
===================
*/
static int CG_DrawWeaponOrderName(int y) {
	vec4_t color;

	if (cg.snap->ps.pm_type == PM_SPECTATOR) return y;
	if (cg.snap->ps.stats[STAT_HEALTH] <= 0) return y;
	if (!cg.weaponOrderActive) return y;
	if (cg.showScores) return y;

	y -= BIGCHAR_HEIGHT;
	if (cg.weaponManuallySet && cg_autoswitch.integer) {
		color[0] = 0.5;
		color[1] = 0.5;
		color[2] = 0.5;
	}
	else {
		color[0] = 1.0;
		color[1] = 1.0;
		color[2] = 1.0;
	}
	color[3] = 1.0;
	CG_DrawBigStringColor(0, y, cg_weaponOrderName[cg.currentWeaponOrder].string, color);
	return y;
}

/*
===================
JUHOX: CG_DrawMissionInfo
===================
*/
#define TSS_BLINK_TIME 2000
static int CG_DrawMissionInfo(int y) {
	static qboolean wasValid = qfalse;
	static int lastGroup = -1;
	static int lastGMS = -1;
	static int groupOrGMSChangedTime = 0;
	static tss_mission_t lastMission = -1;
	static int missionChangedTime = 0;
	static tss_missionTask_t lastMissionTask = -1;
	static int lastTaskGoal = -1;
	static int missionTaskChangedTime = 0;

	int size, x;
	qboolean valid;
	int group;
	tss_groupMemberStatus_t gms;
	tss_mission_t mission;
	tss_missionTask_t task;
	int taskGoalNum;
	char buf[128];
	qboolean blinkPhase;	// if true, don't draw a changed item

	if (cg.showScores) return y;
	if (cg.snap->ps.pm_type == PM_SPECTATOR) goto DrawCondition;
	if (cg.snap->ps.stats[STAT_HEALTH] <= 0) return y;
	valid = BG_TSS_GetPlayerInfo(&cg.snap->ps, TSSPI_isValid);
	if (!valid) {
		wasValid = qfalse;
		return y;
	}
	if (!cg.weaponOrderActive && cgs.stamina) {
		// without this adjustment the task description would overwrite the strengthbar
		y -= BIGCHAR_HEIGHT;
	}
	group = BG_TSS_GetPlayerInfo(&cg.snap->ps, TSSPI_group);
	if (group < 0 || group >= MAX_GROUPS) return y;
	gms = BG_TSS_GetPlayerInfo(&cg.snap->ps, TSSPI_groupMemberStatus);
	mission = BG_TSS_GetPlayerInfo(&cg.snap->ps, TSSPI_mission);
	task = BG_TSS_GetPlayerInfo(&cg.snap->ps, TSSPI_task);
	taskGoalNum = BG_TSS_GetPlayerInfo(&cg.snap->ps, TSSPI_taskGoal);

	if ( !wasValid || group != lastGroup ||	gms != lastGMS || mission != lastMission ||
		( (	task != lastMissionTask || taskGoalNum != lastTaskGoal ) &&
        ( mission != TSSMISSION_seek_enemy || task != TSSMT_fulfilMission ) ) ) {
            trap_S_StartLocalSound(cgs.media.tssBeepSound, CHAN_ANNOUNCER);
	}

	if (group != lastGroup || gms != lastGMS || !wasValid) {
		groupOrGMSChangedTime = cg.time;
		lastGroup = group;
		lastGMS = gms;
	}
	else if (groupOrGMSChangedTime && groupOrGMSChangedTime < cg.time - TSS_BLINK_TIME) {
		groupOrGMSChangedTime = 0;
	}

	if (mission != lastMission || !wasValid) {
		missionChangedTime = cg.time;
		lastMission = mission;
	}
	else if (missionChangedTime && missionChangedTime < cg.time - TSS_BLINK_TIME) {
		missionChangedTime = 0;
	}

	if (task != lastMissionTask || taskGoalNum != lastTaskGoal || !wasValid) {
		missionTaskChangedTime = cg.time;
		lastMissionTask = task;
		lastTaskGoal = taskGoalNum;
	}
	else if (missionTaskChangedTime && missionTaskChangedTime < cg.time - TSS_BLINK_TIME) {
		missionTaskChangedTime = 0;
	}

	blinkPhase = (cg.time % 200 >= 100);

	size = 2 * BIGCHAR_HEIGHT;
	y -= size;

	if (!groupOrGMSChangedTime || !blinkPhase) {
		qhandle_t backShader;
		int backColor;
		int frontColor;
		vec4_t color;

		switch (gms) {
		case TSSGMS_retreating:
			backShader = cgs.media.groupTemporary;
			backColor = TSSGROUPCOLOR_BLACK;
			frontColor = TSSGROUPCOLOR_MINT;
			break;
		case TSSGMS_temporaryFighter:
			backShader = cgs.media.groupTemporary;
			backColor = TSSGROUPCOLOR_WHITE;
			frontColor = TSSGROUPCOLOR_BLACK;
			break;
		case TSSGMS_designatedFighter:
			backShader = cgs.media.groupDesignated;
			backColor = TSSGROUPCOLOR_WHITE;
			frontColor = TSSGROUPCOLOR_BLACK;
			break;
		case TSSGMS_temporaryLeader:
			backShader = cgs.media.groupTemporary;
			backColor = TSSGROUPCOLOR_YELLOW;
			frontColor = TSSGROUPCOLOR_BLACK;
			break;
		case TSSGMS_designatedLeader:
			backShader = cgs.media.groupDesignated;
			backColor = TSSGROUPCOLOR_YELLOW;
			frontColor = TSSGROUPCOLOR_BLACK;
			break;
		default:
			backShader = 0;
			backColor = 0;
			frontColor = 0;
			break;
		}

		color[0] = (backColor >> 16) / 255.0;
		color[1] = (backColor >>  8) / 255.0;
		color[2] = (backColor      ) / 255.0;
		color[3] = 1;
		trap_R_SetColor(color);
		CG_DrawPic(0, y, size, size, backShader);

		color[0] = (frontColor >> 16) / 255.0;
		color[1] = (frontColor >>  8) / 255.0;
		color[2] = (frontColor      ) / 255.0;
		color[3] = 1;
		trap_R_SetColor(color);
		CG_DrawPic(0, y, size, size, cgs.media.groupMarks[group]);

		trap_R_SetColor(NULL);
	}

	x = size;

	if (
		mission >= 0 && mission < TSSMISSION_num_missions &&
		(!missionChangedTime || !blinkPhase)
	) {
		const char* ourName;
		const char* theirName;

		if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED) {
			ourName = "Red";
			theirName = "Blue";
		}
		else {
			ourName = "Blue";
			theirName = "Red";
		}

		switch (mission) {
		case TSSMISSION_invalid:
		default:
			strcpy(buf, "???");
			break;
		case TSSMISSION_seek_enemy:
			strcpy(buf, "Seek Enemy");
			break;
		case TSSMISSION_seek_items:
			strcpy(buf, "Seek Items");
			break;
		case TSSMISSION_capture_enemy_flag:
			Com_sprintf(buf, sizeof(buf), "Capture %s Flag", theirName);
			break;
		case TSSMISSION_defend_our_flag:
			if (
				(cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED && cgs.redflag > 0) ||
				(cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE && cgs.blueflag > 0)
			) {
				Com_sprintf(buf, sizeof(buf), "Return %s Flag", ourName);
			}
			else {
				Com_sprintf(buf, sizeof(buf), "Defend %s Flag", ourName);
			}
			break;
		case TSSMISSION_defend_our_base:
			Com_sprintf(buf, sizeof(buf), "Defend %s Base", ourName);
			break;
		case TSSMISSION_occupy_enemy_base:
			Com_sprintf(buf, sizeof(buf), "Occupy %s Base", theirName);
			break;
		}

		if (BG_TSS_GetPlayerInfo(&cg.snap->ps, TSSPI_missionStatus) == TSSMS_valid) {
			CG_DrawBigString(x, y, buf, 1);
		}
		else {
			vec4_t color;

			color[0] = 0.5;
			color[1] = 0.5;
			color[2] = 0.5;
			color[3] = 1;
			CG_DrawBigStringColor(x, y, buf, color);
		}
	}

	if (
		task >= 0 && task < TSSMT_num_tasks &&
		(!missionTaskChangedTime || !blinkPhase)
	) {
		char* goalName;

		if (taskGoalNum < 0 || taskGoalNum >= MAX_CLIENTS || taskGoalNum == cg.clientNum) {
			taskGoalNum = -1;
			goalName = "?";
		}
		else {
			goalName = cgs.clientinfo[taskGoalNum].name;
		}

		switch (task) {
		case TSSMT_followGroupLeader:
			Com_sprintf(buf, sizeof(buf), "Support %s", goalName);
			break;
		case TSSMT_stickToGroupLeader:
			Com_sprintf(buf, sizeof(buf), "Stick to %s", goalName);
			break;
		case TSSMT_retreat:
			strcpy(buf, "Retreat");
			break;
		case TSSMT_helpTeamMate:
			Com_sprintf(buf, sizeof(buf), "Protect %s", goalName);
			break;
		case TSSMT_guardFlagCarrier:
			Com_sprintf(buf, sizeof(buf), "Protect %s" S_COLOR_WHITE " at all costs", goalName);
			break;
		case TSSMT_rushToBase:
			if ( cg.snap->ps.powerups[PW_REDFLAG] || cg.snap->ps.powerups[PW_BLUEFLAG] || taskGoalNum < 0 ) {
				strcpy(buf, "Rush to base");
			}
			else {
				Com_sprintf(buf, sizeof(buf), "Lead %s" S_COLOR_WHITE " to base", goalName);
			}
			break;
		case TSSMT_seekGroupMember:
			Com_sprintf(buf, sizeof(buf), "Meet %s", goalName);
			break;
		case TSSMT_seekEnemyNearTeamMate:
			Com_sprintf(buf, sizeof(buf), "Seek enemy near %s", goalName);
			break;
		case TSSMT_fulfilMission:
			if (BG_TSS_GetPlayerInfo(&cg.snap->ps, TSSPI_missionStatus) == TSSMS_valid) {
				switch (gms) {
				case TSSGMS_designatedLeader:
				case TSSGMS_temporaryLeader:
					strcpy(buf, "Fulfil mission");
					break;
				default:
					strcpy(buf, "Go! Go! Go!");
					break;
				}
			}
			else {
				buf[0] = 0;
			}
			break;
		case TSSMT_prepareForMission:
			strcpy(buf, "Await reinforcements");
			break;
		default:
			buf[0] = 0;
		}

		CG_DrawBigString(x, y + BIGCHAR_HEIGHT, buf, 1);
	}

	switch (gms) {
	case TSSGMS_designatedLeader:
	case TSSGMS_temporaryLeader:
		{
			int numTotal;
			int numAlive;
			int numReady;
			const char* groupCommand;

			y -= TINYCHAR_HEIGHT;

			numTotal = BG_TSS_GetPlayerInfo(&cg.snap->ps, TSSPI_groupSize);
			numAlive = BG_TSS_GetPlayerInfo(&cg.snap->ps, TSSPI_membersAlive);
			numReady = BG_TSS_GetPlayerInfo(&cg.snap->ps, TSSPI_membersReady);
			switch (BG_TSS_GetPlayerInfo(&cg.snap->ps, TSSPI_groupFormation)) {
			case TSSGF_tight:
				groupCommand = "\"Stick to me!\"";
				break;
			case TSSGF_loose:
				groupCommand = "\"Support me!\"";
				break;
			case TSSGF_free:
				groupCommand = "\"Go! Go! Go!\"";
				break;
			default:
				groupCommand = "INVALID COMMAND";
				break;
			}

			Com_sprintf(
				buf, sizeof(buf), "[%d%s/%d%s/%d%s] %s",
				numReady, numReady>=15? "+" : "",
				numAlive, numAlive>=15? "+" : "",
				numTotal, numTotal>=15? "+" : "",
				groupCommand
			);
			CG_DrawStringExt(0, y, buf, NULL, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
		}
		break;
	default:
		break;
	}

	DrawCondition:
	if ( cgs.clientinfo[cg.clientNum].teamLeader &&	cg.tssUtilizedStrategy && cg.tssOnline ) {
		int condition;
		const char* name;

		y -= TINYCHAR_HEIGHT;

		condition = cg.tssUtilizedStrategy->condition;
		name = cg.tssUtilizedStrategy->strategy->directives[condition].name;
		Com_sprintf(
			buf, sizeof(buf), "Condition %c %c %s",
			condition <= 0? '?' : condition + 'A' - 1,
			name[0]? '-' : ' ', name
		);
		CG_DrawStringExt(0, y, buf, NULL, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
	}

	wasValid = qtrue;
	return y;
}

/*
===================
JUHOX: CG_DrawMagnitudes
===================
*/
static int CG_DrawMagnitudes(int y) {
	int i, n;
	int x;

	if (cg.showScores) return y;
	if (!cgs.clientinfo[cg.clientNum].teamLeader) return y;

	n = 0;
	for (i = TSSTM_num_magnitudes-1; i >= 0; i--) {
		char buf[32];

		if (!cg.tssInspectMagnitude[i]) continue;

		CG_TSS_SPrintTacticalMeasure(buf, sizeof(buf), i, &cg.tssMeasures);
		if ((n & 1) == 0) {
			y -= TINYCHAR_HEIGHT;
			x = 0;
		}
		else {
			x = TINYCHAR_WIDTH * 13;
		}
		CG_DrawStringExt(x, y, buf, NULL, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
		n++;
	}
	return y;
}

/*
=====================
CG_DrawLowerLeft

=====================
*/

static void CG_DrawLowerLeft( void ) {
	float	y;

	if (cg.tssInterfaceOn) return;	// JUHOX
	y = 480 - ICON_SIZE;
	if (cg.snap->ps.pm_type == PM_SPECTATOR) y = 480;	// JUHOX: for mission leader in safety mode

	y = CG_DrawWeaponOrderName(y);	// JUHOX
	y = CG_DrawMissionInfo(y);		// JUHOX
	y = CG_DrawMagnitudes(y);		// JUHOX

	if ( cgs.gametype >= GT_TEAM && cg_drawTeamOverlay.integer == 3 ) {
		y = CG_DrawTeamOverlay( y, qfalse, qfalse );
	}
}



//===========================================================================================

/*
=================
CG_DrawTeamInfo
=================
*/

static void CG_DrawTeamInfo( void ) {
	int w, h;
	int i, len;
	vec4_t		hcolor;
	int		chatHeight;

#define CHATLOC_Y 420 // bottom end
#define CHATLOC_X 0

	if (cg_teamChatHeight.integer < TEAMCHAT_HEIGHT)
		chatHeight = cg_teamChatHeight.integer;
	else
		chatHeight = TEAMCHAT_HEIGHT;
	if (chatHeight <= 0)
		return; // disabled

	if (cgs.teamLastChatPos != cgs.teamChatPos) {
		if (cg.time - cgs.teamChatMsgTimes[cgs.teamLastChatPos % chatHeight] > cg_teamChatTime.integer) {
			cgs.teamLastChatPos++;
		}

		h = (cgs.teamChatPos - cgs.teamLastChatPos) * TINYCHAR_HEIGHT;

		w = 0;

		for (i = cgs.teamLastChatPos; i < cgs.teamChatPos; i++) {
			len = CG_DrawStrlen(cgs.teamChatMsgs[i % chatHeight]);
			if (len > w)
				w = len;
		}
		w *= TINYCHAR_WIDTH;
		w += TINYCHAR_WIDTH * 2;

		if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED ) {
			hcolor[0] = 1.0f;
			hcolor[1] = 0.0f;
			hcolor[2] = 0.0f;
			hcolor[3] = 0.33f;
		} else if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE ) {
			hcolor[0] = 0.0f;
			hcolor[1] = 0.0f;
			hcolor[2] = 1.0f;
			hcolor[3] = 0.33f;
		} else {
			hcolor[0] = 0.0f;
			hcolor[1] = 1.0f;
			hcolor[2] = 0.0f;
			hcolor[3] = 0.33f;
		}

		trap_R_SetColor( hcolor );
		CG_DrawPic( CHATLOC_X, CHATLOC_Y - h, 640, h, cgs.media.teamStatusBar );
		trap_R_SetColor( NULL );

		hcolor[0] = hcolor[1] = hcolor[2] = 1.0f;
		hcolor[3] = 1.0f;

		for (i = cgs.teamChatPos - 1; i >= cgs.teamLastChatPos; i--) {
			CG_DrawStringExt( CHATLOC_X + TINYCHAR_WIDTH,
				CHATLOC_Y - (cgs.teamChatPos - i)*TINYCHAR_HEIGHT,
				cgs.teamChatMsgs[i % chatHeight], hcolor, qfalse, qfalse,
				TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0 );
		}
	}
}


/*
===================
CG_DrawHoldableItem
===================
*/

static void CG_DrawHoldableItem( void ) {
	int		value;

	value = cg.snap->ps.stats[STAT_HOLDABLE_ITEM];
	if ( value ) {
		CG_RegisterItemVisuals( value );
		CG_DrawPic( 640-ICON_SIZE, (SCREEN_HEIGHT-ICON_SIZE)/2, ICON_SIZE, ICON_SIZE, cg_items[ value ].icon );
	}

}


/*
===================
CG_DrawReward
===================
*/
static void CG_DrawReward( void ) {
	float	*color;
	int		i, count;
	float	x, y;
	char	buf[32];

	if ( !cg_drawRewards.integer ) {
		return;
	}

	color = CG_FadeColor( cg.rewardTime, REWARD_TIME );
	if ( !color ) {
		if (cg.rewardStack > 0) {
			for(i = 0; i < cg.rewardStack; i++) {
				cg.rewardSound[i] = cg.rewardSound[i+1];
				cg.rewardShader[i] = cg.rewardShader[i+1];
				cg.rewardCount[i] = cg.rewardCount[i+1];
			}
			cg.rewardTime = cg.time;
			cg.rewardStack--;
			color = CG_FadeColor( cg.rewardTime, REWARD_TIME );
			trap_S_StartLocalSound(cg.rewardSound[0], CHAN_ANNOUNCER);
		} else {
			return;
		}
	}

	trap_R_SetColor( color );

	if ( cg.rewardCount[0] >= 10 ) {
		y = 56;
		x = 320 - ICON_SIZE/2;
		CG_DrawPic( x, y, ICON_SIZE-4, ICON_SIZE-4, cg.rewardShader[0] );
		Com_sprintf(buf, sizeof(buf), "%d", cg.rewardCount[0]);
		x = ( SCREEN_WIDTH - SMALLCHAR_WIDTH * CG_DrawStrlen( buf ) ) / 2;
		CG_DrawStringExt( x, y+ICON_SIZE, buf, color, qfalse, qtrue,
								SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0 );
	}
	else {

		count = cg.rewardCount[0];

		y = 56;
		x = 320 - count * ICON_SIZE/2;
		for ( i = 0 ; i < count ; i++ ) {
			CG_DrawPic( x, y, ICON_SIZE-4, ICON_SIZE-4, cg.rewardShader[0] );
			x += ICON_SIZE;
		}
	}
	trap_R_SetColor( NULL );
}


/*
===============================================================================

LAGOMETER

===============================================================================
*/

#define	LAG_SAMPLES		128


typedef struct {
	int		frameSamples[LAG_SAMPLES];
	int		frameCount;
	int		snapshotFlags[LAG_SAMPLES];
	int		snapshotSamples[LAG_SAMPLES];
	int		snapshotCount;
} lagometer_t;

lagometer_t		lagometer;

/*
==============
CG_AddLagometerFrameInfo

Adds the current interpolate / extrapolate bar for this frame
==============
*/
void CG_AddLagometerFrameInfo( void ) {
	int			offset;

	offset = cg.time - cg.latestSnapshotTime;
	lagometer.frameSamples[ lagometer.frameCount & ( LAG_SAMPLES - 1) ] = offset;
	lagometer.frameCount++;
}

/*
==============
CG_AddLagometerSnapshotInfo

Each time a snapshot is received, log its ping time and
the number of snapshots that were dropped before it.

Pass NULL for a dropped packet.
==============
*/
void CG_AddLagometerSnapshotInfo( snapshot_t *snap ) {
	// dropped packet
	if ( !snap ) {
		lagometer.snapshotSamples[ lagometer.snapshotCount & ( LAG_SAMPLES - 1) ] = -1;
		lagometer.snapshotCount++;
		return;
	}

	// add this snapshot's info
	lagometer.snapshotSamples[ lagometer.snapshotCount & ( LAG_SAMPLES - 1) ] = snap->ping;
	lagometer.snapshotFlags[ lagometer.snapshotCount & ( LAG_SAMPLES - 1) ] = snap->snapFlags;
	lagometer.snapshotCount++;
}

/*
==============
CG_DrawDisconnect

Should we draw something differnet for long lag vs no packets?
==============
*/
static void CG_DrawDisconnect( void ) {
	float		x, y;
	int			cmdNum;
	usercmd_t	cmd;
	const char	*s;
	int			w;  // bk010215 - FIXME char message[1024];

	// draw the phone jack if we are completely past our buffers
	cmdNum = trap_GetCurrentCmdNumber() - CMD_BACKUP + 1;
	trap_GetUserCmd( cmdNum, &cmd );
	if ( cmd.serverTime <= cg.snap->ps.commandTime
		|| cmd.serverTime > cg.time ) {	// special check for map_restart // bk 0102165 - FIXME
		return;
	}

	// also add text in center of screen
	s = "Connection Interrupted"; // bk 010215 - FIXME
	w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
	CG_DrawBigString( 320 - w/2, 100, s, 1.0F);

	// blink the icon
	if ( ( cg.time >> 9 ) & 1 ) {
		return;
	}

	x = 640 - 48;
	y = 480 - 48;

	CG_DrawPic( x, y, 48, 48, trap_R_RegisterShader("gfx/2d/net.tga" ) );
}


#define	MAX_LAGOMETER_PING	900
#define	MAX_LAGOMETER_RANGE	300

/*
==============
CG_DrawLagometer
==============
*/
static void CG_DrawLagometer( void ) {
	int		a, x, y, i;
	float	v;
	float	ax, ay, aw, ah, mid, range;
	int		color;
	float	vscale;

	if ( !cg_lagometer.integer || cgs.localServer ) {
		CG_DrawDisconnect();
		return;
	}

	//
	// draw the graph
	//
	x = 640 - 48;
	y = 480 - 48;

	trap_R_SetColor( NULL );
	CG_DrawPic( x, y, 48, 48, cgs.media.lagometerShader );

	ax = x;
	ay = y;
	aw = 48;
	ah = 48;
	CG_AdjustFrom640( &ax, &ay, &aw, &ah );

	color = -1;
	range = ah / 3;
	mid = ay + range;

	vscale = range / MAX_LAGOMETER_RANGE;

	// draw the frame interpoalte / extrapolate graph
	for ( a = 0 ; a < aw ; a++ ) {
		i = ( lagometer.frameCount - 1 - a ) & (LAG_SAMPLES - 1);
		v = lagometer.frameSamples[i];
		v *= vscale;
		if ( v > 0 ) {
			if ( color != 1 ) {
				color = 1;
				trap_R_SetColor( g_color_table[ColorIndex(COLOR_YELLOW)] );
			}
			if ( v > range ) {
				v = range;
			}
			trap_R_DrawStretchPic ( ax + aw - a, mid - v, 1, v, 0, 0, 0, 0, cgs.media.whiteShader );
		} else if ( v < 0 ) {
			if ( color != 2 ) {
				color = 2;
				trap_R_SetColor( g_color_table[ColorIndex(COLOR_BLUE)] );
			}
			v = -v;
			if ( v > range ) {
				v = range;
			}
			trap_R_DrawStretchPic( ax + aw - a, mid, 1, v, 0, 0, 0, 0, cgs.media.whiteShader );
		}
	}

	// draw the snapshot latency / drop graph
	range = ah / 2;
	vscale = range / MAX_LAGOMETER_PING;

	for ( a = 0 ; a < aw ; a++ ) {
		i = ( lagometer.snapshotCount - 1 - a ) & (LAG_SAMPLES - 1);
		v = lagometer.snapshotSamples[i];
		if ( v > 0 ) {
			if ( lagometer.snapshotFlags[i] & SNAPFLAG_RATE_DELAYED ) {
				if ( color != 5 ) {
					color = 5;	// YELLOW for rate delay
					trap_R_SetColor( g_color_table[ColorIndex(COLOR_YELLOW)] );
				}
			} else {
				if ( color != 3 ) {
					color = 3;
					trap_R_SetColor( g_color_table[ColorIndex(COLOR_GREEN)] );
				}
			}
			v = v * vscale;
			if ( v > range ) {
				v = range;
			}
			trap_R_DrawStretchPic( ax + aw - a, ay + ah - v, 1, v, 0, 0, 0, 0, cgs.media.whiteShader );
		} else if ( v < 0 ) {
			if ( color != 4 ) {
				color = 4;		// RED for dropped snapshots
				trap_R_SetColor( g_color_table[ColorIndex(COLOR_RED)] );
			}
			trap_R_DrawStretchPic( ax + aw - a, ay + ah - range, 1, range, 0, 0, 0, 0, cgs.media.whiteShader );
		}
	}

	trap_R_SetColor( NULL );

	if ( cg_nopredict.integer || cg_synchronousClients.integer ) {
		CG_DrawBigString( ax, ay, "snc", 1.0 );
	}

	CG_DrawDisconnect();
}


/*
===============================================================================

CENTER PRINTING

===============================================================================
*/


/*
==============
CG_CenterPrint

Called for important messages that should stay in the center of the screen
for a few moments
==============
*/
void CG_CenterPrint( const char *str, int y, int charWidth ) {
	char	*s;

	Q_strncpyz( cg.centerPrint, str, sizeof(cg.centerPrint) );

	cg.centerPrintTime = cg.time;
	cg.centerPrintY = y;
	cg.centerPrintCharWidth = charWidth;

	// count the number of lines for centering
	cg.centerPrintLines = 1;
	s = cg.centerPrint;
	while( *s ) {

		if (*s == '\n')	cg.centerPrintLines++;

        s++;
	}
}


/*
===================
CG_DrawCenterString
===================
*/
static void CG_DrawCenterString( void ) {
	char	*start;
	int		l;
	int		x, y, w;
	float	*color;

	if ( !cg.centerPrintTime ) {
		return;
	}

	color = CG_FadeColor( cg.centerPrintTime, 1000 * cg_centertime.value );
	if ( !color ) {
		return;
	}

	trap_R_SetColor( color );

	start = cg.centerPrint;

	y = cg.centerPrintY - cg.centerPrintLines * BIGCHAR_HEIGHT / 2;

	while ( 1 ) {
		char linebuffer[1024];

		for ( l = 0; l < 50; l++ ) {
			if ( !start[l] || start[l] == '\n' ) {
				break;
			}
			linebuffer[l] = start[l];
		}
		linebuffer[l] = 0;

		w = cg.centerPrintCharWidth * CG_DrawStrlen( linebuffer );

		x = ( SCREEN_WIDTH - w ) / 2;

		CG_DrawStringExt( x, y, linebuffer, color, qfalse, qtrue, cg.centerPrintCharWidth, (int)(cg.centerPrintCharWidth * 1.5), 0 );

		y += cg.centerPrintCharWidth * 1.5;

		while ( *start && ( *start != '\n' ) ) {
			start++;
		}
		if ( !*start ) {
			break;
		}
		start++;
	}

	trap_R_SetColor( NULL );
}



/*
================================================================================

CROSSHAIR

================================================================================
*/


/*
=================
CG_DrawCrosshair
=================
*/
static void CG_DrawCrosshair(void) {
	float		w, h;
	qhandle_t	hShader;
	float		f;
	float		x, y;
	int			ca;

	if (cg.tssInterfaceOn) return;	// JUHOX
	if ( !cg_drawCrosshair.integer ) {
		return;
	}

	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR) {
		return;
	}

	if ( cg.renderingThirdPerson ) {
		return;
	}

	// set color based on health
	if ( cg_crosshairHealth.integer ) {
		vec4_t		hcolor;

		CG_ColorForHealth( hcolor );
		trap_R_SetColor( hcolor );
	} else {
		trap_R_SetColor( NULL );
	}

	w = h = cg_crosshairSize.value;

	// pulse the size of the crosshair when picking up items
	f = cg.time - cg.itemPickupBlendTime;
	if ( f > 0 && f < ITEM_BLOB_TIME ) {
		f /= ITEM_BLOB_TIME;
		w *= ( 1 + f );
		h *= ( 1 + f );
	}

	x = cg_crosshairX.integer;
	y = cg_crosshairY.integer;
	CG_AdjustFrom640( &x, &y, &w, &h );

	ca = cg_drawCrosshair.integer;
	if (ca < 0) {
		ca = 0;
	}
	hShader = cgs.media.crosshairShader[ ca % NUM_CROSSHAIRS ];

	trap_R_DrawStretchPic( x + cg.refdef.x + 0.5 * (cg.refdef.width - w),
		y + cg.refdef.y + 0.5 * (cg.refdef.height - h),
		w, h, 0, 0, 1, 1, hShader );
}



/*
=================
CG_ScanForCrosshairEntity
=================
*/
static void CG_ScanForCrosshairEntity( void ) {
	trace_t		trace;
	vec3_t		start, end;
	int			content;

	VectorCopy( cg.refdef.vieworg, start );
	VectorMA( start, 131072, cg.refdef.viewaxis[0], end );

	CG_Trace( &trace, start, vec3_origin, vec3_origin, end,
		cg.snap->ps.clientNum, CONTENTS_SOLID|CONTENTS_BODY );
	if ( trace.entityNum >= MAX_CLIENTS ) {
		return;
	}

	// if the player is in fog, don't show it
	content = trap_CM_PointContents( trace.endpos, 0 );
	if ( content & CONTENTS_FOG ) {
		return;
	}

	// if the player is invisible, don't show it
	if ( cg_entities[ trace.entityNum ].currentState.powerups & ( 1 << PW_INVIS ) ) {
		// JUHOX: if the player is on same team show the name
		if (cgs.gametype < GT_TEAM) return;
		if (!cgs.clientinfo[trace.entityNum].infoValid) return;
		if (cgs.clientinfo[trace.entityNum].team != cg.snap->ps.persistant[PERS_TEAM]) return;
	}

	// update the fade timer
	cg.crosshairClientNum = trace.entityNum;
	cg.crosshairClientTime = cg.time;
}


/*
=====================
CG_DrawCrosshairNames
=====================
*/
static void CG_DrawCrosshairNames( void ) {
	float		*color;
	char		*name;
	float		w;

	if (cg.tssInterfaceOn) return;	// JUHOX
	if ( !cg_drawCrosshair.integer ) {
		return;
	}
	if ( !cg_drawCrosshairNames.integer ) {
		return;
	}
	if ( cg.renderingThirdPerson ) {
		return;
	}

	// scan the known entities to see if the crosshair is sighted on one
	CG_ScanForCrosshairEntity();

	// draw the name of the player being looked at
	color = CG_FadeColor( cg.crosshairClientTime, 1000 );
	if ( !color ) {
		trap_R_SetColor( NULL );
		return;
	}

	name = cgs.clientinfo[ cg.crosshairClientNum ].name;

	w = CG_DrawStrlen( name ) * BIGCHAR_WIDTH;
	CG_DrawBigString( 320 - w / 2, 170, name, color[3] * 0.5f );

	trap_R_SetColor( NULL );
}


//==============================================================================

/*
=================
JUHOX: CG_DrawLensFlareEffectList
=================
*/
static void CG_DrawLensFlareEffectList(void) {
	int firstEffect;
	int y;
	int i;

	y = 480 - 12 * TINYCHAR_HEIGHT;

	firstEffect = cg.lfEditor.selectedEffect - 5;
	for (i = 0; i < 12; i++) {
		int effectNum;

		effectNum = firstEffect + i;
		if (effectNum >= 0 && effectNum < cgs.numLensFlareEffects) {
			lensFlareEffect_t* lfeff;
			int width;
			const float* color;

			lfeff = &cgs.lensFlareEffects[effectNum];
			width = CG_DrawStrlen(lfeff->name) * TINYCHAR_WIDTH;
			color = i == 5? colorWhite : colorMdGrey;
			CG_DrawStringExt(640 - width, y, lfeff->name, color, qtrue, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
		}
		y += TINYCHAR_HEIGHT;
	}
}


/*
=================
JUHOX: CG_DrawCopyOptions
=================
*/
static void CG_DrawCopyOptions(void) {
	int y;
	char buf[256];

	y = 480;

	y -= TINYCHAR_HEIGHT;	// 9
	y -= TINYCHAR_HEIGHT;	// 8
	y -= TINYCHAR_HEIGHT;	// 7

	y -= TINYCHAR_HEIGHT;
	Com_sprintf(buf, sizeof(buf), "[6] paste entity angle = %s", cg.lfEditor.copyOptions & LFECO_SPOT_ANGLE? "on" : "off");
	CG_DrawStringExt(0, y, buf, colorWhite, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);

	y -= TINYCHAR_HEIGHT;
	Com_sprintf(buf, sizeof(buf), "[5] paste direction    = %s", cg.lfEditor.copyOptions & LFECO_SPOT_DIR? "on" : "off");
	CG_DrawStringExt(0, y, buf, colorWhite, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);

	y -= TINYCHAR_HEIGHT;
	Com_sprintf(buf, sizeof(buf), "[4] paste light radius = %s", cg.lfEditor.copyOptions & LFECO_LIGHTRADIUS? "on" : "off");
	CG_DrawStringExt(0, y, buf, colorWhite, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);

	y -= TINYCHAR_HEIGHT;
	Com_sprintf(buf, sizeof(buf), "[3] paste vis radius   = %s", cg.lfEditor.copyOptions & LFECO_VISRADIUS? "on" : "off");
	CG_DrawStringExt(0, y, buf, colorWhite, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);

	y -= TINYCHAR_HEIGHT;
	Com_sprintf(buf, sizeof(buf), "[2] paste effect       = %s", cg.lfEditor.copyOptions & LFECO_EFFECT? "on" : "off");
	CG_DrawStringExt(0, y, buf, colorWhite, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);

	y -= TINYCHAR_HEIGHT;
	Com_sprintf(buf, sizeof(buf), "[1] done");
	CG_DrawStringExt(0, y, buf, colorWhite, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
}


/*
=================
CG_DrawSpectator
=================
*/
static void CG_DrawSpectator(void) {
	// JUHOX: map lens flares edit mode
	if (cgs.editMode == EM_mlf) {
		static const vec4_t backFillColor = {
			0.0, 0.0, 0.0, 0.6
		};
		static const vec4_t colorDkGreen = {
			0.0, 0.5, 0.0, 1.0
		};
		static const vec4_t colorLtGreen = {
			0.5, 1.0, 0.5, 1.0
		};
		static const char* const drawModes[] = {
			"normal", "marks", "none"
		};
		static const char* const cursorSize[] = {
			"small", "light radius", "vis radius"
		};
		static const char* const moveModes[] = {
			"coarse", "fine"
		};
		char buf[256];
		int y;

		// crosshair
		if (!cg.lfEditor.selectedLFEnt || cg.lfEditor.editMode != LFEEM_pos) {
			CG_DrawPic(320 - 12, 240 - 12, 24, 24, cgs.media.crosshairShader[0]);
		}

		CG_FillRect(0, 480 - 12 * TINYCHAR_HEIGHT, 640, 12 * TINYCHAR_HEIGHT, backFillColor);

		CG_DrawLensFlareEffectList();

		if (cg.lfEditor.cmdMode == LFECM_copyOptions) {
			CG_DrawCopyOptions();
			return;
		}

		y = 480;

		y -= TINYCHAR_HEIGHT;
		if (cg.lfEditor.oldButtons & BUTTON_WALKING) {
			Com_sprintf(buf, sizeof(buf), "[9] cursor size = %s", cursorSize[cg.lfEditor.cursorSize]);
			CG_DrawStringExt(0, y, buf, cg.lfEditor.selectedLFEnt? colorLtGreen : colorDkGreen, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
		}
		else {
			Com_sprintf(buf, sizeof(buf), "[9] draw mode = %s", drawModes[cg.lfEditor.drawMode]);
			CG_DrawStringExt(0, y, buf, colorWhite, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
		}

		y -= TINYCHAR_HEIGHT;
		if (cg.lfEditor.oldButtons & BUTTON_WALKING) {
			Com_sprintf(buf, sizeof(buf), "[8] copy entity data");
			CG_DrawStringExt(0, y, buf, cg.lfEditor.selectedLFEnt? colorLtGreen : colorDkGreen, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
		}
		else {
			const char* name;

			name = "";
			if (cg.lfEditor.selectedLFEnt && cg.lfEditor.selectedLFEnt->lfeff) {
				name = cg.lfEditor.selectedLFEnt->lfeff->name;
			}
			Com_sprintf(buf, sizeof(buf), "[8] note effect %s", name);
			CG_DrawStringExt(0, y, buf, name[0]? colorWhite : colorMdGrey, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
		}

		y -= TINYCHAR_HEIGHT;
		if (cg.lfEditor.oldButtons & BUTTON_WALKING) {
			Com_sprintf(buf, sizeof(buf), "[7] paste entity data");
			CG_DrawStringExt(0, y, buf, cg.lfEditor.selectedLFEnt? colorLtGreen : colorDkGreen, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
		}
		else {
			Com_sprintf(buf, sizeof(buf), "[7] assign effect %s", cgs.lensFlareEffects[cg.lfEditor.selectedEffect].name);
			CG_DrawStringExt(0, y, buf, cg.lfEditor.selectedLFEnt? colorWhite : colorMdGrey, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
		}

		y -= TINYCHAR_HEIGHT;
		if (cg.lfEditor.oldButtons & BUTTON_WALKING) {
			Com_sprintf(buf, sizeof(buf), "[6] paste options");
			CG_DrawStringExt(0, y, buf, colorLtGreen, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
		}
		else {
			Com_sprintf(buf, sizeof(buf), "[6] %sedit light size f+b / vis radius l+r", cg.lfEditor.editMode == LFEEM_radius? "^3" : "");
			CG_DrawStringExt(0, y, buf, cg.lfEditor.selectedLFEnt? colorWhite : colorMdGrey, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
		}

		y -= TINYCHAR_HEIGHT;
		if (cg.lfEditor.oldButtons & BUTTON_WALKING) {
			Com_sprintf(buf, sizeof(buf), "[5] find entity using %s", cgs.lensFlareEffects[cg.lfEditor.selectedEffect].name);
			CG_DrawStringExt(0, y, buf, colorLtGreen, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
		}
		else {
			Com_sprintf(buf, sizeof(buf), "[5] %sedit spotlight target", cg.lfEditor.editMode == LFEEM_target? "^3" : "");
			CG_DrawStringExt(0, y, buf, cg.lfEditor.selectedLFEnt? colorWhite : colorMdGrey, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
		}

		y -= TINYCHAR_HEIGHT;
		if (cg.lfEditor.oldButtons & BUTTON_WALKING) {
			if (cg.lfEditor.selectedLFEnt) {
				if (cg.lfEditor.selectedLFEnt->lock) {
					CG_DrawStringExt(0, y, "[4] unlock from mover", colorLtGreen, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
				}
				else {
					CG_DrawStringExt(0, y, "[4] lock to selected mover", cg.lfEditor.selectedMover? colorLtGreen : colorDkGreen, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
				}
			}
			else {
				CG_DrawStringExt(0, y, "[4] lock to selected mover", colorDkGreen, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
			}
		}
		else {
			Com_sprintf(buf, sizeof(buf), "[4] %sedit position & vis radius", cg.lfEditor.editMode == LFEEM_pos? "^3" : "");
			CG_DrawStringExt(0, y, buf, cg.lfEditor.selectedLFEnt? colorWhite : colorMdGrey, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
		}

		y -= TINYCHAR_HEIGHT;
		if (cg.lfEditor.oldButtons & BUTTON_WALKING) {
			Com_sprintf(buf, sizeof(buf), "[3] find mover %s", cg.lfEditor.moversStopped? "" : "(need to be stopped)");
			CG_DrawStringExt(0, y, buf, cg.lfEditor.moversStopped? colorLtGreen : colorDkGreen, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
		}
		else {
			Com_sprintf(buf, sizeof(buf), "[3] %sdelete flare entity", cg.lfEditor.delAck? "^1really^7 " : "");
			CG_DrawStringExt(0, y, buf, cg.lfEditor.selectedLFEnt? colorWhite : colorMdGrey, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
		}

		y -= TINYCHAR_HEIGHT;
		if (cg.lfEditor.oldButtons & BUTTON_WALKING) {
			Com_sprintf(buf, sizeof(buf), "[2] %s movers", cg.lfEditor.moversStopped? "release" : "stop");
			CG_DrawStringExt(0, y, buf, colorLtGreen, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
		}
		else {
			Com_sprintf(buf, sizeof(buf), "[2] %s flare entity", cg.lfEditor.selectedLFEnt? "duplicate" : "create");
			CG_DrawStringExt(0, y, buf, cg.lfEditor.editMode == LFEEM_none? colorWhite : colorMdGrey, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
		}

		y -= TINYCHAR_HEIGHT;
		Com_sprintf(buf, sizeof(buf), "[1] cancel");
		CG_DrawStringExt(0, y, buf, cg.lfEditor.selectedLFEnt? NULL : colorMdGrey, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);

		y -= TINYCHAR_HEIGHT;
		Com_sprintf(buf, sizeof(buf), "[TAB] move mode = %s", moveModes[cg.lfEditor.moveMode]);
		CG_DrawStringExt(0, y, buf, cg.lfEditor.selectedLFEnt && cg.lfEditor.editMode > LFEEM_none? colorWhite : colorMdGrey, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);

		y -= TINYCHAR_HEIGHT;
		Com_sprintf(buf, sizeof(buf), "[WALK] alternate command set");
		CG_DrawStringExt(0, y, buf, (cg.lfEditor.oldButtons & BUTTON_WALKING)? colorLtGreen : colorWhite, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);

		y -= TINYCHAR_HEIGHT;
		if (!cg.lfEditor.selectedLFEnt) {
			if (cg.lfEditor.markedLFEnt >= 0) {
				Com_sprintf(buf, sizeof(buf), "[ATTACK] select flare entity");
				CG_DrawStringExt(0, y, buf, NULL, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
			}
		}
		else {
			switch (cg.lfEditor.editMode) {
			case LFEEM_none:
				Com_sprintf(buf, sizeof(buf), "[ATTACK] accept changes");
				break;
			case LFEEM_pos:
				if (cg.lfEditor.moveMode == LFEMM_coarse) {
					Com_sprintf(buf, sizeof(buf), "[ATTACK] switch to tune mode");
				}
				else {
					Com_sprintf(buf, sizeof(buf), "[ATTACK] modify view dist (f+b) or vis radius (l+r)");
				}
				break;
			case LFEEM_target:
				if (cg.lfEditor.editTarget) {
					Com_sprintf(buf, sizeof(buf), "[ATTACK] set target");
				}
				else if (DistanceSquared(cg.refdef.vieworg, cg.lfEditor.targetPosition) < 1) {
					Com_sprintf(buf, sizeof(buf), "[ATTACK] remove target & leave editing mode");
				}
				else {
					Com_sprintf(buf, sizeof(buf), "[ATTACK] set angle & leave editing mode");
				}
				break;
			case LFEEM_radius:
				Com_sprintf(buf, sizeof(buf), "[ATTACK] modify view distance (f+b)");
				break;
			default:
				buf[0] = 0;
				break;
			}
			CG_DrawStringExt(0, y, buf, NULL, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
		}
	}
	else

	CG_DrawBigString(320 - 9 * 8, 440, "SPECTATOR", 1.0F);
	if ( cgs.gametype == GT_TOURNAMENT ) {
		CG_DrawBigString(320 - 15 * 8, 460, "waiting to play", 1.0F);
	}
	else if ( cgs.gametype >= GT_TEAM ) {
		CG_DrawBigString(320 - 39 * 8, 460, "press ESC and use the JOIN menu to play", 1.0F);
	}
}

/*
=================
CG_DrawVote
=================
*/
void CG_DrawVote(void) {	// JUHOX: also called from cg_view.c
	char	*s;
	int		sec;

	if ( !cgs.voteTime ) {
		return;
	}

	// play a talk beep whenever it is modified
	if ( cgs.voteModified ) {
		cgs.voteModified = qfalse;
		trap_S_StartLocalSound( cgs.media.talkSound, CHAN_LOCAL_SOUND );
	}

	sec = ( VOTE_TIME - ( cg.time - cgs.voteTime ) ) / 1000;
	if ( sec < 0 ) {
		sec = 0;
	}

	s = va("VOTE(%i):%s yes:%i no:%i", sec, cgs.voteString, cgs.voteYes, cgs.voteNo );
	// JUHOX: vote string background
	{
		static const vec4_t backColor = {
			0, 0, 0, 0.5
		};

		CG_FillRect(0, 58, CG_DrawStrlen(s) * SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, backColor);
	}

	CG_DrawSmallString( 0, 58, s, 1.0F );
}

/*
=================
CG_DrawTeamVote
=================
*/
void CG_DrawTeamVote(void) {	// JUHOX: also called from cg_view.c
	char	*s;
	int		sec, cs_offset;

	// JUHOX BUGFIX
	if ( cgs.clientinfo[cg.clientNum].team == TEAM_RED )
		cs_offset = 0;
	else if ( cgs.clientinfo[cg.clientNum].team == TEAM_BLUE )
		cs_offset = 1;
	else
		return;

	if ( !cgs.teamVoteTime[cs_offset] ) {
		return;
	}
	if (cg.tssInterfaceOn) return;	// JUHOX: don't draw team vote if TSS interface on

	// play a talk beep whenever it is modified
	if ( cgs.teamVoteModified[cs_offset] ) {
		cgs.teamVoteModified[cs_offset] = qfalse;
		trap_S_StartLocalSound( cgs.media.talkSound, CHAN_LOCAL_SOUND );
	}

	sec = ( VOTE_TIME - ( cg.time - cgs.teamVoteTime[cs_offset] ) ) / 1000;
	if ( sec < 0 ) {
		sec = 0;
	}
	// JUHOX: show teamvote client as name

	if (!Q_strncmp("leader", cgs.teamVoteString[cs_offset], 6)) {
		s = va(
			"TEAMVOTE(%i):mission leader %s - yes:%i no:%i",
			sec, cgs.clientinfo[atoi(cgs.teamVoteString[cs_offset] + 7)].name,
			cgs.teamVoteYes[cs_offset], cgs.teamVoteNo[cs_offset]
		);
	}
	else {
		s = va("TEAMVOTE(%i):%s - yes:%i no:%i", sec, cgs.teamVoteString[cs_offset],
								cgs.teamVoteYes[cs_offset], cgs.teamVoteNo[cs_offset] );
	}

	// JUHOX: teamvote string background
	{
		static const vec4_t backColor = { 0, 0, 0, 0.5 };

		CG_FillRect(0, 90, CG_DrawStrlen(s) * SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, backColor);
	}

	CG_DrawSmallString( 0, 90, s, 1.0F );
}


static qboolean CG_DrawScoreboard() {
	return CG_DrawOldScoreboard();
}

/*
=================
CG_DrawIntermission
=================
*/
static void CG_DrawIntermission( void ) {

	if ( cgs.gametype == GT_SINGLE_PLAYER ) {
		CG_DrawCenterString();
		return;
	}

	cg.scoreFadeTime = cg.time;
	cg.scoreBoardShowing = CG_DrawScoreboard();
	// JUHOX: draw vote string during intermission
	CG_DrawVote();
	CG_DrawTeamVote();

}

/*
=================
CG_DrawFollow
=================
*/
static qboolean CG_DrawFollow( void ) {
	float		x;
	vec4_t		color;
	const char	*name;

	if ( !(cg.snap->ps.pm_flags & PMF_FOLLOW) ) return qfalse;

	color[0] = 1;
	color[1] = 1;
	color[2] = 1;
	color[3] = 1;


	CG_DrawBigString( 320 - 9 * 8, 24, "following", 1.0F );

	name = cgs.clientinfo[ cg.snap->ps.clientNum ].name;

	x = 0.5 * ( 640 - GIANT_WIDTH * CG_DrawStrlen( name ) );

	CG_DrawStringExt( x, 40, name, color, qtrue, qtrue, GIANT_WIDTH, GIANT_HEIGHT, 0 );

	return qtrue;
}

/*
=================
CG_DrawWarmup
=================
*/
static void CG_DrawWarmup( void ) {
	int			w;
	int			sec;
	int			i;
	float scale;
	clientInfo_t	*ci1, *ci2;
	int			cw;
	const char	*s;

	sec = cg.warmup;
	if ( !sec ) {
		return;
	}

	if ( sec < 0 ) {
		s = "Waiting for players";
		w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
		CG_DrawBigString(320 - w / 2, 24, s, 1.0F);
		cg.warmupCount = 0;
		return;
	}

	if (cgs.gametype == GT_TOURNAMENT) {
		// find the two active players
		ci1 = NULL;
		ci2 = NULL;
		for ( i = 0 ; i < cgs.maxclients ; i++ ) {
			if ( cgs.clientinfo[i].infoValid && cgs.clientinfo[i].team == TEAM_FREE ) {
				if ( !ci1 ) {
					ci1 = &cgs.clientinfo[i];
				} else {
					ci2 = &cgs.clientinfo[i];
				}
			}
		}

		if ( ci1 && ci2 ) {
			s = va( "%s vs %s", ci1->name, ci2->name );

			w = CG_DrawStrlen( s );
			if ( w > 640 / GIANT_WIDTH ) {
				cw = 640 / w;
			} else {
				cw = GIANT_WIDTH;
			}
			CG_DrawStringExt( 320 - w * cw/2, 20,s, colorWhite,	qfalse, qtrue, cw, (int)(cw * 1.5f), 0 );
		}
	} else {
		if ( cgs.gametype == GT_FFA ) {
			s = "Free For All";
		} else if ( cgs.gametype == GT_TEAM ) {
			s = "Team Deathmatch";
		} else if ( cgs.gametype == GT_CTF ) {
			s = "Capture the Flag";
		} else {
			s = "";
		}

		w = CG_DrawStrlen( s );
		if ( w > 640 / GIANT_WIDTH ) {
			cw = 640 / w;
		} else {
			cw = GIANT_WIDTH;
		}
		CG_DrawStringExt( 320 - w * cw/2, 25,s, colorWhite,	qfalse, qtrue, cw, (int)(cw * 1.1f), 0 );
	}

	sec = ( sec - cg.time ) / 1000;
	if ( sec < 0 ) {
		cg.warmup = 0;
		sec = 0;
	}
	s = va( "Starts in: %i", sec + 1 );
	if ( sec != cg.warmupCount ) {
		cg.warmupCount = sec;
		switch ( sec ) {
		case 0:
			trap_S_StartLocalSound( cgs.media.count1Sound, CHAN_ANNOUNCER );
			break;
		case 1:
			trap_S_StartLocalSound( cgs.media.count2Sound, CHAN_ANNOUNCER );
			break;
		case 2:
			trap_S_StartLocalSound( cgs.media.count3Sound, CHAN_ANNOUNCER );
			break;
		default:
			break;
		}
	}
	scale = 0.45f;
	switch ( cg.warmupCount ) {
	case 0:
		cw = 28;
		scale = 0.54f;
		break;
	case 1:
		cw = 24;
		scale = 0.51f;
		break;
	case 2:
		cw = 20;
		scale = 0.48f;
		break;
	default:
		cw = 16;
		scale = 0.45f;
		break;
	}

	w = CG_DrawStrlen( s );
	CG_DrawStringExt( 320 - w * cw/2, 70, s, colorWhite, qfalse, qtrue, cw, (int)(cw * 1.5), 0 );

}

/*
=================
JUHOX: CG_StandardView
=================
*/
#define SVM_SWITCHING_NUM_TILES 7
static void CG_StandardView(void) {
	float fraction;
	int i;
	float x, y, w, h;
	float tileSize;

	if (!cg.viewModeSwitchingTime) return;

	if (cg.time >= cg.viewModeSwitchingTime + VIEWMODE_SWITCHING_TIME) {
		cg.viewModeSwitchingTime = 0;
		return;
	}
	fraction = (float)(cg.time - cg.viewModeSwitchingTime) / (float)VIEWMODE_SWITCHING_TIME;

	x = 0;
	y = 0;
	w = 640;
	h = 480;
	CG_AdjustFrom640(&x, &y, &w, &h);
	tileSize = h / SVM_SWITCHING_NUM_TILES;

	for (i = 0; i < SVM_SWITCHING_NUM_TILES; i++) {
		float yy, hh;

		yy = y + (i + fraction) * tileSize;
		hh = (1 - fraction) * tileSize;
		trap_R_DrawStretchPic(
			x, yy, w, hh, 0, 0, 1, 1,
			cgs.media.amplifierShader
		);
	}
}


/*
=================
JUHOX: CG_ScannerView
=================
*/
static void CG_ScannerView(void) {
	float x, y, w, h;
	static const vec4_t filterColor = {
		0.0625, 0.0625, 0.0625, 1
	};
	float fraction;
	float tileSize;
	int i;

	x = 0;
	y = 0;
	w = 640;
	h = 480;
	CG_AdjustFrom640(&x, &y, &w, &h);

	if (cg.time >= cg.viewModeSwitchingTime + VIEWMODE_SWITCHING_TIME) {
		cg.viewModeSwitchingTime = 0;
	}

	if (!cg.viewModeSwitchingTime) {
		float s, t;

		s = 0.7 * random();
		t = 0.7 * random();
		trap_R_SetColor(filterColor);
		trap_R_DrawStretchPic(
			x, y, w, h, s, t, s+0.3, t+0.3,
			cgs.media.scannerShader
		);

		trap_R_SetColor(NULL);
		return;
	}

	fraction = (float)(cg.time - cg.viewModeSwitchingTime) / (float)VIEWMODE_SWITCHING_TIME;
	tileSize = h / SVM_SWITCHING_NUM_TILES;

	trap_R_SetColor(filterColor);
	for (i = 0; i < SVM_SWITCHING_NUM_TILES; i++) {
		float yy, hh;
		float s, t;

		yy = y + i * tileSize;
		hh = fraction * tileSize;
		s = 0.7 * random();
		t = 0.7 * random();
		trap_R_DrawStretchPic(
			x, yy, w, hh,
			s, t, s+0.3, t+0.3*fraction/SVM_SWITCHING_NUM_TILES,
			cgs.media.scannerShader
		);
	}
	trap_R_SetColor(NULL);
}


/*
=================
JUHOX: CG_AmplifierView
=================
*/
static void CG_AmplifierView(void) {
	float fraction;
	int i;
	float x, y, w, h;
	float tileSize;
	static const vec4_t filterColor = {
		0.0625, 0.0625, 0.0625, 1
	};


	x = 0;
	y = 0;
	w = 640;
	h = 480;
	CG_AdjustFrom640(&x, &y, &w, &h);

	if (cg.time >= cg.viewModeSwitchingTime + VIEWMODE_SWITCHING_TIME) {
		cg.viewModeSwitchingTime = 0;
	}

	if (!cg.viewModeSwitchingTime) {
		trap_R_DrawStretchPic(x, y, w, h, 0, 0, 1, 1, cgs.media.amplifierShader);
		return;
	}

	fraction = (float)(cg.time - cg.viewModeSwitchingTime) / (float)VIEWMODE_SWITCHING_TIME;

	tileSize = h / SVM_SWITCHING_NUM_TILES;

	trap_R_SetColor(filterColor);
	for (i = 0; i < SVM_SWITCHING_NUM_TILES; i++) {
		float yy, hh;
		float s, t;

		yy = y + i * tileSize;
		hh = fraction * tileSize;
		trap_R_DrawStretchPic(x, yy, w, hh, 0, 0, 1, 1, cgs.media.amplifierShader);

		yy += hh;
		hh = (1 - fraction) * tileSize;
		s = 0.7 * random();
		t = 0.7 * random();
		trap_R_DrawStretchPic(
			x, yy, w, hh,
			s, t, s+0.3, t+0.3*fraction/SVM_SWITCHING_NUM_TILES,
			cgs.media.scannerShader
		);
	}
	trap_R_SetColor(NULL);
}


/*
=================
JUHOX: CG_HandleViewMode
=================
*/
static void CG_HandleViewMode(void) {
	if (cg.predictedPlayerState.pm_type == PM_INTERMISSION) {
		cg.viewMode = VIEW_standard;
		cg.viewModeSwitchingTime = 0;
	}

	if (cg.viewMode != VIEW_scanner) {
		cg.scannerActivationTime = 0;
	}
	else if (!cg.scannerActivationTime) {
		cg.scannerActivationTime = cg.time;
	}

	switch (cg.viewMode) {
	case VIEW_standard:
	default:
		CG_StandardView();
		break;
	case VIEW_scanner:
		CG_ScannerView();
		break;
	case VIEW_amplifier:
		CG_AmplifierView();
		CG_DrawLightBlobs();
		break;
	}
}


/*
=================
CG_Draw2D
=================
*/
static void CG_Draw2D( void ) {

	// if we are taking a levelshot for the menu, don't draw anything
	if ( cg.levelShot ) {
		return;
	}

	if ( cg_draw2D.integer == 0 ) {
		return;
	}

	if ( cg.snap->ps.pm_type == PM_INTERMISSION ) {
		CG_DrawIntermission();
		return;
	}

	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR ) {
		CG_DrawSpectator();
		CG_DrawCrosshair();
		CG_DrawCrosshairNames();
	} else {
		// don't draw any status if dead or the scoreboard is being explicitly shown
		if ( !cg.showScores && cg.snap->ps.stats[STAT_HEALTH] > 0 ) {

			CG_DrawStatusBar();
			CG_DrawCrosshair();
			CG_DrawCrosshairNames();
			CG_DrawWeaponSelect();
			CG_DrawHoldableItem();
			CG_DrawReward();
		}

        // JUHOX: if dead, draw at least the strength bar
		if (cg.snap->ps.stats[STAT_HEALTH] <= 0) {
			vec4_t color;
			float x, y, w, h, s, t;

			color[0] = 1.0;
			color[1] = 0.9;
			color[2] = 0.5;
			color[3] = 0.4;
			trap_R_SetColor(color);
			x = 0;
			y = 0;
			w = 640;
			h = 480;
			CG_AdjustFrom640(&x, &y, &w, &h);
			s = 0.7 * random();
			t = 0.7 * random();
			trap_R_DrawStretchPic(x, y, w, h, s, t, s+0.3, t+0.3, cgs.media.deathBlurryShader);
			trap_R_SetColor(NULL);
			CG_DrawStrengthBar(qfalse);
		}

		if ( cgs.gametype >= GT_TEAM ) {
			CG_DrawTeamInfo();
		}
	}

	CG_DrawVote();
	CG_DrawTeamVote();
	CG_DrawLagometer();
	CG_DrawUpperRight();
	CG_DrawLowerRight();
	CG_DrawLowerLeft();

	if ( !CG_DrawFollow() ) {
		CG_DrawWarmup();
	}

	// don't draw center string if scoreboard is up
	cg.scoreBoardShowing = CG_DrawScoreboard();
	if ( !cg.scoreBoardShowing) {
		CG_DrawCenterString();
	}
	// JUHOX: draw TSS interface
	if (cg.tssInterfaceOn) {
		CG_TSS_DrawInterface();
	}
}


static void CG_DrawTourneyScoreboard() {
	CG_DrawOldTourneyScoreboard();
}

/*
=====================
CG_DrawActive

Perform all drawing needed to completely fill the screen
=====================
*/
void CG_DrawActive( stereoFrame_t stereoView ) {
	float		separation;
	vec3_t		baseOrg;

	// optionally draw the info screen instead
	if ( !cg.snap ) {
		CG_DrawInformation();
		return;
	}

	// optionally draw the tournement scoreboard instead
	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR &&
		( cg.snap->ps.pm_flags & PMF_SCOREBOARD ) ) {
		CG_DrawTourneyScoreboard();
		return;
	}

	switch ( stereoView ) {
	case STEREO_CENTER:
		separation = 0;
		break;
	case STEREO_LEFT:
		separation = -cg_stereoSeparation.value / 2;
		break;
	case STEREO_RIGHT:
		separation = cg_stereoSeparation.value / 2;
		break;
	default:
		separation = 0;
		CG_Error( "CG_DrawActive: Undefined stereoView" );
	}


	// clear around the rendered view if sized down
	CG_TileClear();

	// offset vieworg appropriately if we're doing stereo separation
	VectorCopy( cg.refdef.vieworg, baseOrg );
	if ( separation != 0 ) {
		VectorMA( cg.refdef.vieworg, -separation, cg.refdef.viewaxis[1], cg.refdef.vieworg );
	}

	// JUHOX: add lens flare editor cursor
	if ( cgs.editMode == EM_mlf && !(cg.lfEditor.moversStopped && cg.lfEditor.selectedMover ) ) {
		CG_AddLFEditorCursor();
	}


	// draw 3D view
	trap_R_RenderScene( &cg.refdef );

	// JUHOX: mark selected mover for lens flare editor
	if (
		cgs.editMode == EM_mlf &&
		cg.lfEditor.moversStopped &&
		cg.lfEditor.selectedMover
	) {
		static const vec4_t darkening = { 0.2, 0, 0, 0.7 };

		CG_FillRect(0, 0, 640, 480, darkening);
		trap_R_ClearScene();
		CG_Mover(cg.lfEditor.selectedMover);
		CG_AddLFEditorCursor();
		cg.refdef.rdflags |= RDF_NOWORLDMODEL;
		trap_R_RenderScene(&cg.refdef);
	}


	// restore original viewpoint if running stereo
	if ( separation != 0 ) {
		VectorCopy( baseOrg, cg.refdef.vieworg );
	}

	CG_HandleViewMode();	// JUHOX

	// draw status bar and other floating elements
 	CG_Draw2D();

	// JUHOX: auto group leader commands
	if (
		cg_autoGLC.integer &&
		cgs.gametype >= GT_TEAM &&
		cgs.gametype < GT_STU &&
		BG_TSS_GetPlayerInfo(&cg.snap->ps, TSSPI_isValid) &&
		BG_TSS_GetPlayerInfo(&cg.snap->ps, TSSPI_groupMemberStatus) >= TSSGMS_temporaryLeader &&
		cg.time >= cg.tssAutoGLCUpdateTime
	) {
		tss_groupFormation_t oldGF;
		tss_groupFormation_t newGF;

		cg.tssAutoGLCUpdateTime = cg.time + 500;

		oldGF = BG_TSS_GetPlayerInfo(&cg.snap->ps, TSSPI_groupFormation);
		newGF = BG_TSS_GetPlayerInfo(&cg.snap->ps, TSSPI_suggestedGF);

		if (oldGF != newGF) {
			switch (newGF) {
			case TSSGF_tight:
				trap_SendClientCommand("groupformation tight");
				break;
			case TSSGF_loose:
				trap_SendClientCommand("groupformation loose");
				break;
			case TSSGF_free:
				trap_SendClientCommand("groupformation free");
				break;
			}
		}
	}


	// JUHOX: tss server update
	if (
		cgs.gametype >= GT_TEAM &&
		cgs.gametype < GT_STU &&
		cgs.clientinfo[cg.clientNum].teamLeader &&
		cg.tssUtilizedStrategy &&
		cg.time >= cg.tssServerUpdateTime &&
		cg.predictedPlayerState.pm_type != PM_INTERMISSION
	) {
		int cmdSize;
		char cmd[1024];
		char* buf;

		cg.tssServerUpdateTime = cg.time + 2000;

		memset(&cmd, 0, sizeof(cmd));
		Com_sprintf(
			cmd, sizeof(cmd), "tssinstructions %d %d %d %d %d ",
			cg.tssUtilizedStrategy->strategy->rfa_dangerLimit,
			cg.tssUtilizedStrategy->strategy->rfd_dangerLimit,
			cg.tssUtilizedStrategy->strategy->short_term,
			cg.tssUtilizedStrategy->strategy->medium_term,
			cg.tssUtilizedStrategy->strategy->long_term
		);

		cmdSize = strlen(cmd);
		buf = &cmd[cmdSize];
		TSS_CodeInt(cg.tssOnline && cgs.tss, &buf);
		BG_TSS_CodeInstructions(
			&cg.tssUtilizedStrategy->strategy->directives[cg.tssUtilizedStrategy->condition].instr,
			&buf
		);
		BG_TSS_CodeLeadership(
			cg.tssGroupLeader[0], cg.tssGroupLeader[1], cg.tssGroupLeader[2],
			cg.tssTeamMatesClientNum,
			&buf
		);

		trap_SendClientCommand(cmd);
	}
}
