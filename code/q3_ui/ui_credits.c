// Copyright (C) 1999-2000 Id Software, Inc.
//
/*
=======================================================================

CREDITS

=======================================================================
*/


#include "ui_local.h"


typedef struct {
	menuframework_s	menu;
} creditsmenu_t;

static creditsmenu_t	s_credits;


/*
=================
UI_CreditMenu_Key
=================
*/
static sfxHandle_t UI_CreditMenu_Key( int key ) {
	if( key & K_CHAR_FLAG ) {
		return 0;
	}

	trap_Cmd_ExecuteText( EXEC_APPEND, "quit\n" );
	return 0;
}


/*
===============
UI_CreditMenu_Draw
===============
*/
static void UI_CreditMenu_Draw( void ) {
	int		y;

	y = 12;
	UI_DrawProportionalString( 320, y, "id Software is:", UI_CENTER|UI_SMALLFONT, color_white );

	y += 1.42 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
	UI_DrawProportionalString( 320, y, "Programming", UI_CENTER|UI_SMALLFONT, color_white );
	y += PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
	UI_DrawProportionalString( 320, y, "John Carmack, Robert A. Duffy, Jim Dose'", UI_CENTER|UI_SMALLFONT, color_white );

	y += 1.42 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
	UI_DrawProportionalString( 320, y, "Art", UI_CENTER|UI_SMALLFONT, color_white );
	y += PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
	UI_DrawProportionalString( 320, y, "Adrian Carmack, Kevin Cloud,", UI_CENTER|UI_SMALLFONT, color_white );
	y += PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
	UI_DrawProportionalString( 320, y, "Kenneth Scott, Seneca Menard, Fred Nilsson", UI_CENTER|UI_SMALLFONT, color_white );

	y += 1.42 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
	UI_DrawProportionalString( 320, y, "Game Designer", UI_CENTER|UI_SMALLFONT, color_white );
	y += PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
	UI_DrawProportionalString( 320, y, "Graeme Devine", UI_CENTER|UI_SMALLFONT, color_white );

	y += 1.42 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
	UI_DrawProportionalString( 320, y, "Level Design", UI_CENTER|UI_SMALLFONT, color_white );
	y += PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
	UI_DrawProportionalString( 320, y, "Tim Willits, Christian Antkow, Paul Jaquays", UI_CENTER|UI_SMALLFONT, color_white );

	y += 1.42 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
	UI_DrawProportionalString( 320, y, "CEO", UI_CENTER|UI_SMALLFONT, color_white );
	y += PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
	UI_DrawProportionalString( 320, y, "Todd Hollenshead", UI_CENTER|UI_SMALLFONT, color_white );

	y += 1.42 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
	UI_DrawProportionalString( 320, y, "Director of Business Development", UI_CENTER|UI_SMALLFONT, color_white );
	y += PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
	UI_DrawProportionalString( 320, y, "Marty Stratton", UI_CENTER|UI_SMALLFONT, color_white );

	y += 1.42 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
	UI_DrawProportionalString( 320, y, "Biz Assist and id Mom", UI_CENTER|UI_SMALLFONT, color_white );
	y += PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
	UI_DrawProportionalString( 320, y, "Donna Jackson", UI_CENTER|UI_SMALLFONT, color_white );

	y += 1.42 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
	UI_DrawProportionalString( 320, y, "Development Assistance", UI_CENTER|UI_SMALLFONT, color_white );
	y += PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
	UI_DrawProportionalString( 320, y, "Eric Webb", UI_CENTER|UI_SMALLFONT, color_white );

	y += 1.35 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
	UI_DrawString( 320, y, "To order: 1-800-idgames     www.quake3arena.com     www.idsoftware.com", UI_CENTER|UI_SMALLFONT, color_red );
	y += SMALLCHAR_HEIGHT;
	UI_DrawString( 320, y, "Quake III Arena(c) 1999-2000, Id Software, Inc.  All Rights Reserved", UI_CENTER|UI_SMALLFONT, color_red );
}


/*
===============
UI_CreditMenu
===============
*/
void UI_CreditMenu( void ) {
	memset( &s_credits, 0 ,sizeof(s_credits) );

	s_credits.menu.draw = UI_CreditMenu_Draw;
	s_credits.menu.key = UI_CreditMenu_Key;
	s_credits.menu.fullscreen = qtrue;
	UI_PushMenu ( &s_credits.menu );
}

/*
=================
JUHOX: UI_Hunt_Credits_Key
=================
*/
static sfxHandle_t UI_Hunt_Credits_Key(int key) {
	if(key & K_CHAR_FLAG) {
		return 0;
	}

	trap_S_StopBackgroundTrack();
	UI_PopMenu();
	return 0;
}

// JUHOX: definitions for 3D chars
#if 1
#define CHAR3D_SPACE 5.0
#define CHAR3D_SPACE_WIDTH 30.0
#define CHAR3D_HEIGHT 90.0
#define CREDITS_ENTRY_PHASE1 10000	// msec
#define CREDITS_ENTRY_TIME 15000	// msec

typedef struct {
	const char* text;
	float size;
	float zScale;
	float zOffset;
} creditsEntry_t;

static int creditsStartTime;
static int creditsEndTime;

static refdef_t creditsRefdef;

static creditsEntry_t creditsEntries[] = {
	{ "O   P   E   N\nH   U   N   T", 1.4, 0.4 },
	{ "created by\nJürgen \"Juhox\" Hoffmann", 1, 0.7 },
	{ "coding by\nJürgen Hoffmann\nCraniul", 1, 0.7 },
	{ "artwork & shader scripts by\nJürgen Hoffmann", 1, 0.7 },
	{ "technical assistance by\nMichael \"Padautz\" Hoffmann", 1, 0.7 },
	{ "mapping by\nMichael Hoffmann\nGönenç Giray\nWolfWings", 1, 0.7 },
	{ "lens flare scripts by\nGönenç \"GNC\" Giray\nwww.planetquake.com/gnc", 1, 0.7 },
	{ "hook model by\nIa_Lanky from Ia Clan\nwww.iaclan.com", 1, 0.7 },
	{ "monster launcher skin by\nMajor*Payne", 1, 0.7 },
	{
		"testing & inspiration by\n"
		"Michael Hoffmann\n"
		"Major*Payne\n"
		"Gönenç Giray\n"
		"Syabha\n"
		"Ia_Lanky\n"
		"Jürgen Mersmann\n"
		"Don \"ViPr\" Karam\n"
		"et al.", 0.7, 0.7
	},
	{
		"special thanks to\n"
		"Michael Hoffmann\n"
		"Syabha",
		1, 0.7
	},
	{
		"headache caused by\nMajor*Payne\n:^)", 1, 0.7
	},
	{
		"please visit\n"
		"www.planetquake.com\n"
		"www.planetquake.com/code3arena\n"
		"www.shaderlab.com",
		1, 0.7 },
	{ "www.planetquake.com/modifia", 1, 0.7 },
	{ NULL, 0, 0 },
	{ NULL, 0, 0 },
	{ NULL, 0, 0 },
	{ NULL, 0, 0 }
};

static qhandle_t font3D_models[256];

static const int font3D_charWidth[256] = {
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,	// space
15.09375,
32.1875,
42.375,
42.875,
64.09375,
54.75,
14.09375,
20.875,
20.875,
26.984375,
37.78125,
15.09375,
20.484375,
15.09375,
19.875,
41.484375,
29.09375,
42.1875,
41.875,
44.375,
42.1875,
41.78125,
41.09375,
41.484375,
41.78125,
15.09375,
15.09375,
39.375,
37.78125,
39.375,
38.1875,
52.78125,
55.28125,
46.875,
49.28125,
46.6875,
42.6875,
38.6875,
51.6875,
48.59375,
15.6875,
40.78125,
53.78125,
40.1875,
57.09375,
48.59375,
52.59375,
43.09375,
54.484375,
49.875,
45.984375,
47.6875,
48.6875,
54.984375,
70.984375,
55.1875,
55.1875,
48.09375,
21.28125,
19.875,
21.28125,
37.875,
36.28125,
17.6875,
42.34375,
40.484375,
42.484375,
40.484375,
42.59375,
29.09375,
40.515625,
38.78125,
14.09375,
22.375,
42.984375,
14.09375,
62.28125,
38.78125,
42.28125,
40.484375,
40.484375,
28.984375,
39.09375,
27.59375,
38.875,
43.484375,
66.984375,
46.484375,
43.375,
36.59375,
25.875,
8.78125,
25.875,
39.6875,
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
0, //omitted
55.28125,
55.28125,
55.28125,
55.28125,
55.28125,
55.28125,
70.984375,
49.28125,
42.6875,
42.6875,
42.6875,
42.6875,
19.375,
19.59375,
25.59375,
23.6875,
51.875,
48.59375,
52.59375,
52.59375,
52.59375,
52.59375,
52.59375,
37.875,
56.625,
48.6875,
48.6875,
48.6875,
48.6875,
55.1875,
43.09375,
40.6875,
42.34375,
42.34375,
42.34375,
42.34375,
42.34375,
42.34375,
66.484375,
42.484375,
42.59375,
42.59375,
42.59375,
42.59375,
18.78125,
18.59375,
25.59375,
23.6875,
42.09375,
38.78125,
42.28125,
42.28125,
42.28125,
42.28125,
42.28125,
37.78125,
42.1875,
38.875,
38.875,
38.875,
38.875,
43.375,
40.484375,
43.375
};
#endif

/*
=================
JUHOX: UI_3Dstrlen
=================
*/
static float UI_3Dstrlen(const char* s, float scale) {
	float size;

	size = 0;
	while (*s && *s != '\n') {
		float width;

		width = font3D_charWidth[*s & 255];
		if (width > 0) {
			size += width + CHAR3D_SPACE;
		}
		else if (*s == ' ') {
			size += CHAR3D_SPACE_WIDTH;
		}
		s++;
	}
	return size * scale;
}

/*
=================
JUHOX: UI_3DMultiLineStrlen
=================
*/
static float UI_3DMultiLineStrlen(const char* s, float scale) {
	float size;
	float maxSize;

	size = 0;
	maxSize = 0;
	while (*s) {
		float width;

		if (*s == '\n') {
			if (size > maxSize) {
				maxSize = size;
			}
			size = 0;
		}

		width = font3D_charWidth[*s & 255];
		if (width > 0) {
			size += width + CHAR3D_SPACE;
		}
		else if (*s == ' ') {
			size += CHAR3D_SPACE_WIDTH;
		}
		s++;
	}
	if (size > maxSize) {
		maxSize = size;
	}
	return maxSize * scale;
}

/*
=================
JUHOX: UI_Draw3Dchar
=================
*/
static void UI_Draw3Dchar(const vec3_t origin, int c, float offset, float scale, float zScale, float yaw) {
	refEntity_t ent;
	vec3_t charOrg;
	vec3_t angles;

	memset(&ent, 0, sizeof(ent));

	c &= 255;
	ent.hModel = font3D_models[c];

	VectorSet(angles, 0, 180 + yaw, 0);
	AnglesToAxis(angles, ent.axis);

	VectorCopy(origin, charOrg);
	offset += 0.5 * (font3D_charWidth[c] + CHAR3D_SPACE) * scale;
	VectorMA(charOrg, offset, ent.axis[1], charOrg);
	charOrg[2] -= 70.0 * scale * zScale;
	//charOrg[1] = -charOrg[1];


	/*
	VectorMA(ent.origin, charOrg[0], creditsRefdef.viewaxis[0], ent.origin);
	VectorMA(ent.origin, charOrg[1], creditsRefdef.viewaxis[1], ent.origin);
	VectorMA(ent.origin, charOrg[2], creditsRefdef.viewaxis[2], ent.origin);
	*/
	VectorCopy(charOrg, ent.origin);

	VectorCopy(ent.origin, ent.oldorigin);
	VectorCopy(ent.origin, ent.lightingOrigin);
	VectorScale(ent.axis[0], scale, ent.axis[0]);
	VectorScale(ent.axis[1], scale, ent.axis[1]);
	VectorScale(ent.axis[2], scale * zScale, ent.axis[2]);
	ent.nonNormalizedAxes = qtrue;
	ent.renderfx = RF_NOSHADOW | RF_MINLIGHT | RF_LIGHTING_ORIGIN;

	ent.shaderRGBA[3] = 255;
	if (ent.origin[0] > 1000.0) {
		float alpha;

		alpha = 255 * (1 - (ent.origin[0] - 1000.0) / 1000.0);
		if (alpha < 0) alpha = 0;
		ent.shaderRGBA[3] = (int) alpha; 
	}
	/*
	ent.shaderRGBA[0] = ent.shaderRGBA[3] >> 1;
	ent.shaderRGBA[1] = ent.shaderRGBA[3] >> 1;
	ent.shaderRGBA[2] = ent.shaderRGBA[3] >> 1;
	*/

	trap_R_AddRefEntityToScene(&ent);
}

/*
=================
JUHOX: UI_Draw3Dstring
=================
*/
static int UI_Draw3Dstring(const vec3_t origin, const char* s, float scale, float zScale, float yaw) {
	float offset;
	int n;

	offset = -0.5 * UI_3Dstrlen(s, scale);

	n = 0;
	while (*s && *s != '\n') {
		float width;

		width = font3D_charWidth[*s & 255];
		if (width > 0) {
			UI_Draw3Dchar(origin, *s, offset, scale, zScale, yaw);
			offset += (width + CHAR3D_SPACE) * scale;
		}
		else if (*s == ' ') {
			offset += CHAR3D_SPACE_WIDTH * scale;
		}
		s++;
		n++;
	}
	return n;
}

/*
=================
JUHOX: UI_DrawMultiLine3Dstring
=================
*/
static void UI_DrawMultiLine3Dstring(const vec3_t origin, const char* s, float scale, float zScale, float yaw) {
	int numLines;
	const char* str;
	vec3_t currentOrigin;

	numLines = 1;
	str = s;
	while (*str) {
		if (*str == '\n') numLines++;
		str++;
	}
	VectorCopy(origin, currentOrigin);
	numLines &= ~1;
	currentOrigin[2] += 0.5 * CHAR3D_HEIGHT * numLines * scale * zScale;

	str = s;
	while (*str) {
		str += UI_Draw3Dstring(currentOrigin, str, scale, zScale, yaw);
		if (*str == '\n') str++;
		currentOrigin[2] -= CHAR3D_HEIGHT * scale * zScale;
	}
}

/*
=================
JUHOX: if1
=================
*/
static float if1(float x) {
	return 1 - (1-x) * (1-x);
}

/*
=================
JUHOX: if2
=================
*/
static float if2(float x) {
	return 3 * x * x - 2 * x * x * x;
}

/*
=================
JUHOX: UI_DrawCreditsEntry
=================
*/
static void UI_DrawCreditsEntry(int entry) {
	const creditsEntry_t* ce;
	int entryStartTime;
	float yaw;
	float offset;
	int time;
	vec3_t origin;

	if (entry < 0) return;

	ce = &creditsEntries[entry];
	if (!ce->text) return;

	entryStartTime = entry * CREDITS_ENTRY_TIME;

	offset = 0.5 * UI_3DMultiLineStrlen(ce->text, ce->size);

	time = creditsRefdef.time - entryStartTime;

	origin[0] = -50.0 + 600.0 * time / (float)CREDITS_ENTRY_PHASE1;
	origin[1] = 0;
	origin[2] = ce->zOffset * ce->size * ce->zScale;

	if (time > CREDITS_ENTRY_PHASE1) time = CREDITS_ENTRY_PHASE1;
	yaw = -180.0 + 180.0 * if1((float)time / (float)CREDITS_ENTRY_PHASE1);

	UI_DrawMultiLine3Dstring(origin, ce->text, ce->size, ce->zScale, yaw);

	if (!ce[1].text && origin[0] > 2100) {
		creditsEndTime = uis.realtime;
	}
}

/*
=================
JUHOX: UI_Hunt_Credits_Draw
=================
*/
static void UI_Hunt_Credits_Draw(void) {
	float x, y, w, h;
	int entry;

	if (!creditsStartTime) {
		creditsStartTime = uis.realtime + 3000;
		return;
	}

	x = 0;
	y = 0;
	w = 640;
	h = 480;
	UI_AdjustFrom640(&x, &y, &w, &h);

	trap_R_DrawStretchPic(x, y, w, h, 0, 0, 1, 1, trap_R_RegisterShaderNoMip("gfx/credits_bg.tga"));

	if (uis.realtime < creditsStartTime + 1000) {
		vec4_t color;

		color[0] = 1;
		color[1] = 1;
		color[2] = 1;
		color[3] = if2((creditsStartTime + 1000 - uis.realtime) / 4000.0);
		trap_R_SetColor(color);
		trap_R_DrawStretchPic(x, y, w, h, 0, 0, 1, 1, trap_R_RegisterShaderNoMip("creditsGlare"));
		trap_R_SetColor(NULL);
	}
	if (uis.realtime < creditsStartTime) return;

	if (creditsEndTime) {
		if (uis.realtime > creditsEndTime + 4000) {
			trap_S_StopBackgroundTrack();
			UI_PopMenu();
			return;
		}
		if (uis.realtime >= creditsEndTime) {
			vec4_t color;

			color[0] = 1;
			color[1] = 1;
			color[2] = 1;
			color[3] = if2((uis.realtime - creditsEndTime) / 4000.0);
			trap_R_SetColor(color);
			trap_R_DrawStretchPic(x, y, w, h, 0, 0, 1, 1, trap_R_RegisterShaderNoMip("creditsGlare"));
			trap_R_SetColor(NULL);
		}
		return;
	}

	memset(&creditsRefdef, 0, sizeof(creditsRefdef));

	creditsRefdef.rdflags = RDF_NOWORLDMODEL;

	AxisClear(creditsRefdef.viewaxis);

	creditsRefdef.x = x;
	creditsRefdef.y = y;
	creditsRefdef.width = w;
	creditsRefdef.height = h;

	creditsRefdef.fov_x = 90;
	creditsRefdef.fov_y = 90.0 * 480.0 / 640.0;

	creditsRefdef.time = uis.realtime - creditsStartTime;

	entry = creditsRefdef.time / CREDITS_ENTRY_TIME;

	trap_R_ClearScene();

	UI_DrawCreditsEntry(entry);

	UI_DrawCreditsEntry(entry - 1);

	UI_DrawCreditsEntry(entry - 2);

	trap_R_RenderScene(&creditsRefdef);
}

/*
===============
JUHOX: UI_Hunt_Credits
===============
*/
void UI_Hunt_Credits(void) {
	int i;

	memset(&font3D_models, 0, sizeof(font3D_models));
	for (i = 33; i < 256; i++) {
		font3D_models[i] = trap_R_RegisterModel(va("models/fonts/hunt1/f_%d.md3", i));
	}

	creditsStartTime = 0;
	creditsEndTime = 0;

	memset(&s_credits, 0, sizeof(s_credits));

	s_credits.menu.key = UI_Hunt_Credits_Key;
	s_credits.menu.draw = UI_Hunt_Credits_Draw;
	s_credits.menu.fullscreen = qtrue;
	s_credits.menu.blackBack = qtrue;
	s_credits.menu.noCursor = qtrue;
	UI_PushMenu(&s_credits.menu);

	trap_S_StopBackgroundTrack();
	trap_S_StartBackgroundTrack("music/win.wav", "");
	uis.startTitleMusic = qtrue;
}
