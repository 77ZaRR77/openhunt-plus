// Copyright (C) 1999-2000 Id Software, Inc.
//
// g_utils.c -- misc utility functions for game module

#include "g_local.h"

typedef struct {
  char oldShader[MAX_QPATH];
  char newShader[MAX_QPATH];
  float timeOffset;
} shaderRemap_t;

#define MAX_SHADER_REMAPS 128

int remapCount = 0;
shaderRemap_t remappedShaders[MAX_SHADER_REMAPS];

void AddRemap(const char *oldShader, const char *newShader, float timeOffset) {
	int i;

	for (i = 0; i < remapCount; i++) {
		if (Q_stricmp(oldShader, remappedShaders[i].oldShader) == 0) {
			// found it, just update this one
			strcpy(remappedShaders[i].newShader,newShader);
			remappedShaders[i].timeOffset = timeOffset;
			return;
		}
	}
	if (remapCount < MAX_SHADER_REMAPS) {
		strcpy(remappedShaders[remapCount].newShader,newShader);
		strcpy(remappedShaders[remapCount].oldShader,oldShader);
		remappedShaders[remapCount].timeOffset = timeOffset;
		remapCount++;
	}
}

const char *BuildShaderStateConfig() {
	static char	buff[MAX_STRING_CHARS*4];
	char out[(MAX_QPATH * 2) + 5];
	int i;

	memset(buff, 0, MAX_STRING_CHARS);
	for (i = 0; i < remapCount; i++) {
		Com_sprintf(out, (MAX_QPATH * 2) + 5, "%s=%s:%5.2f@", remappedShaders[i].oldShader, remappedShaders[i].newShader, remappedShaders[i].timeOffset);
		Q_strcat( buff, sizeof( buff ), out);
	}
	return buff;
}

/*
=========================================================================

model / sound configstring indexes

=========================================================================
*/

/*
================
G_FindConfigstringIndex

================
*/
int G_FindConfigstringIndex( char *name, int start, int max, qboolean create ) {
	int		i;
	char	s[MAX_STRING_CHARS];

	if ( !name || !name[0] ) {
		return 0;
	}

	for ( i=1 ; i<max ; i++ ) {
		trap_GetConfigstring( start + i, s, sizeof( s ) );
		if ( !s[0] ) {
			break;
		}
		if ( !strcmp( s, name ) ) {
			return i;
		}
	}

	if ( !create ) {
		return 0;
	}

	if ( i == max ) {
		G_Error( "G_FindConfigstringIndex: overflow" );
	}

	trap_SetConfigstring( start + i, name );

	return i;
}


int G_ModelIndex( char *name ) {
	return G_FindConfigstringIndex (name, CS_MODELS, MAX_MODELS, qtrue);
}

int G_SoundIndex( char *name ) {
	return G_FindConfigstringIndex (name, CS_SOUNDS, MAX_SOUNDS, qtrue);
}

//=====================================================================


/*
================
G_TeamCommand

Broadcasts a command to only a specific team
================
*/
void G_TeamCommand( team_t team, char *cmd ) {
	int		i;

	for ( i = 0 ; i < level.maxclients ; i++ ) {
		if ( level.clients[i].pers.connected == CON_CONNECTED ) {
			if ( level.clients[i].sess.sessionTeam == team ) {
				trap_SendServerCommand( i, va("%s", cmd ));
			}
		}
	}
}


/*
=============
G_Find

Searches all active entities for the next one that holds
the matching string at fieldofs (use the FOFS() macro) in the structure.

Searches beginning at the entity after from, or the beginning if NULL
NULL will be returned if the end of the list is reached.

=============
*/
gentity_t *G_Find (gentity_t *from, int fieldofs, const char *match)
{
	char	*s;

	if (!from)
		from = g_entities;
	else
		from++;

	for ( ; from < &g_entities[level.num_entities] ; from++)
	{
		if (!from->inuse)
			continue;
		s = *(char **) ((byte *)from + fieldofs);
		if (!s)
			continue;
		if (!Q_stricmp (s, match))
			return from;
	}

	return NULL;
}


/*
=============
G_PickTarget

Selects a random entity from among the targets
=============
*/
#define MAXCHOICES	32

gentity_t* G_PickTarget(char* targetname, int segment)
{
	gentity_t	*ent = NULL;
	int		num_choices = 0;
	gentity_t	*choice[MAXCHOICES];

	if (!targetname)
	{
		G_Printf("G_PickTarget called with NULL targetname\n");
		return NULL;
	}

	while(1)
	{
		ent = G_Find (ent, FOFS(targetname), targetname);
		if (!ent)
			break;

		if (ent->worldSegment - 1 != segment) continue;	// JUHOX

		choice[num_choices++] = ent;
		if (num_choices == MAXCHOICES)
			break;
	}

	if (!num_choices)
	{
		G_Printf("G_PickTarget: target %s not found\n", targetname);
		return NULL;
	}

	return choice[rand() % num_choices];
}


/*
==============================
G_UseTargets

"activator" should be set to the entity that initiated the firing.

Search for (string)targetname in all entities that
match (string)self.target and call their .use function

==============================
*/
void G_UseTargets( gentity_t *ent, gentity_t *activator ) {
	gentity_t		*t;

	if ( !ent ) {
		return;
	}

	if (ent->targetShaderName && ent->targetShaderNewName) {
		float f = level.time * 0.001;
		AddRemap(ent->targetShaderName, ent->targetShaderNewName, f);
		trap_SetConfigstring(CS_SHADERSTATE, BuildShaderStateConfig());
	}

	if ( !ent->target ) {
		return;
	}

	t = NULL;
	while ( (t = G_Find (t, FOFS(targetname), ent->target)) != NULL ) {
		if (t->worldSegment != ent->worldSegment) continue;	// JUHOX

		if ( t == ent ) {
			G_Printf ("WARNING: Entity used itself.\n");
		} else {
			if ( t->use ) {
				t->use (t, ent, activator);
			}
		}
		if ( !ent->inuse ) {
			G_Printf("entity was removed while using targets\n");
			return;
		}
	}
}


// JUHOX: for unknown reason the acos() function is not exported to the game module in g_syscalls.asm
// this version is taken from bg_lib.c, slightly modified
#if 1
float acostable[] = {
3.14159265f,3.07908248f,3.05317551f,3.03328655f,3.01651113f,3.00172442f,2.98834964f,2.97604422f,
2.96458497f,2.95381690f,2.94362719f,2.93393068f,2.92466119f,2.91576615f,2.90720289f,2.89893629f,
2.89093699f,2.88318015f,2.87564455f,2.86831188f,2.86116621f,2.85419358f,2.84738169f,2.84071962f,
2.83419760f,2.82780691f,2.82153967f,2.81538876f,2.80934770f,2.80341062f,2.79757211f,2.79182724f,
2.78617145f,2.78060056f,2.77511069f,2.76969824f,2.76435988f,2.75909250f,2.75389319f,2.74875926f,
2.74368816f,2.73867752f,2.73372510f,2.72882880f,2.72398665f,2.71919677f,2.71445741f,2.70976688f,
2.70512362f,2.70052613f,2.69597298f,2.69146283f,2.68699438f,2.68256642f,2.67817778f,2.67382735f,
2.66951407f,2.66523692f,2.66099493f,2.65678719f,2.65261279f,2.64847088f,2.64436066f,2.64028133f,
2.63623214f,2.63221238f,2.62822133f,2.62425835f,2.62032277f,2.61641398f,2.61253138f,2.60867440f,
2.60484248f,2.60103507f,2.59725167f,2.59349176f,2.58975488f,2.58604053f,2.58234828f,2.57867769f,
2.57502832f,2.57139977f,2.56779164f,2.56420354f,2.56063509f,2.55708594f,2.55355572f,2.55004409f,
2.54655073f,2.54307530f,2.53961750f,2.53617701f,2.53275354f,2.52934680f,2.52595650f,2.52258238f,
2.51922417f,2.51588159f,2.51255441f,2.50924238f,2.50594525f,2.50266278f,2.49939476f,2.49614096f,
2.49290115f,2.48967513f,2.48646269f,2.48326362f,2.48007773f,2.47690482f,2.47374472f,2.47059722f,
2.46746215f,2.46433933f,2.46122860f,2.45812977f,2.45504269f,2.45196720f,2.44890314f,2.44585034f,
2.44280867f,2.43977797f,2.43675809f,2.43374890f,2.43075025f,2.42776201f,2.42478404f,2.42181622f,
2.41885841f,2.41591048f,2.41297232f,2.41004380f,2.40712480f,2.40421521f,2.40131491f,2.39842379f,
2.39554173f,2.39266863f,2.38980439f,2.38694889f,2.38410204f,2.38126374f,2.37843388f,2.37561237f,
2.37279910f,2.36999400f,2.36719697f,2.36440790f,2.36162673f,2.35885335f,2.35608768f,2.35332964f,
2.35057914f,2.34783610f,2.34510044f,2.34237208f,2.33965094f,2.33693695f,2.33423003f,2.33153010f,
2.32883709f,2.32615093f,2.32347155f,2.32079888f,2.31813284f,2.31547337f,2.31282041f,2.31017388f,
2.30753373f,2.30489988f,2.30227228f,2.29965086f,2.29703556f,2.29442632f,2.29182309f,2.28922580f,
2.28663439f,2.28404881f,2.28146900f,2.27889490f,2.27632647f,2.27376364f,2.27120637f,2.26865460f,
2.26610827f,2.26356735f,2.26103177f,2.25850149f,2.25597646f,2.25345663f,2.25094195f,2.24843238f,
2.24592786f,2.24342836f,2.24093382f,2.23844420f,2.23595946f,2.23347956f,2.23100444f,2.22853408f,
2.22606842f,2.22360742f,2.22115104f,2.21869925f,2.21625199f,2.21380924f,2.21137096f,2.20893709f,
2.20650761f,2.20408248f,2.20166166f,2.19924511f,2.19683280f,2.19442469f,2.19202074f,2.18962092f,
2.18722520f,2.18483354f,2.18244590f,2.18006225f,2.17768257f,2.17530680f,2.17293493f,2.17056692f,
2.16820274f,2.16584236f,2.16348574f,2.16113285f,2.15878367f,2.15643816f,2.15409630f,2.15175805f,
2.14942338f,2.14709226f,2.14476468f,2.14244059f,2.14011997f,2.13780279f,2.13548903f,2.13317865f,
2.13087163f,2.12856795f,2.12626757f,2.12397047f,2.12167662f,2.11938600f,2.11709859f,2.11481435f,
2.11253326f,2.11025530f,2.10798044f,2.10570867f,2.10343994f,2.10117424f,2.09891156f,2.09665185f,
2.09439510f,2.09214129f,2.08989040f,2.08764239f,2.08539725f,2.08315496f,2.08091550f,2.07867884f,
2.07644495f,2.07421383f,2.07198545f,2.06975978f,2.06753681f,2.06531651f,2.06309887f,2.06088387f,
2.05867147f,2.05646168f,2.05425445f,2.05204979f,2.04984765f,2.04764804f,2.04545092f,2.04325628f,
2.04106409f,2.03887435f,2.03668703f,2.03450211f,2.03231957f,2.03013941f,2.02796159f,2.02578610f,
2.02361292f,2.02144204f,2.01927344f,2.01710710f,2.01494300f,2.01278113f,2.01062146f,2.00846399f,
2.00630870f,2.00415556f,2.00200457f,1.99985570f,1.99770895f,1.99556429f,1.99342171f,1.99128119f,
1.98914271f,1.98700627f,1.98487185f,1.98273942f,1.98060898f,1.97848051f,1.97635399f,1.97422942f,
1.97210676f,1.96998602f,1.96786718f,1.96575021f,1.96363511f,1.96152187f,1.95941046f,1.95730088f,
1.95519310f,1.95308712f,1.95098292f,1.94888050f,1.94677982f,1.94468089f,1.94258368f,1.94048818f,
1.93839439f,1.93630228f,1.93421185f,1.93212308f,1.93003595f,1.92795046f,1.92586659f,1.92378433f,
1.92170367f,1.91962459f,1.91754708f,1.91547113f,1.91339673f,1.91132385f,1.90925250f,1.90718266f,
1.90511432f,1.90304746f,1.90098208f,1.89891815f,1.89685568f,1.89479464f,1.89273503f,1.89067683f,
1.88862003f,1.88656463f,1.88451060f,1.88245794f,1.88040664f,1.87835668f,1.87630806f,1.87426076f,
1.87221477f,1.87017008f,1.86812668f,1.86608457f,1.86404371f,1.86200412f,1.85996577f,1.85792866f,
1.85589277f,1.85385809f,1.85182462f,1.84979234f,1.84776125f,1.84573132f,1.84370256f,1.84167495f,
1.83964848f,1.83762314f,1.83559892f,1.83357582f,1.83155381f,1.82953289f,1.82751305f,1.82549429f,
1.82347658f,1.82145993f,1.81944431f,1.81742973f,1.81541617f,1.81340362f,1.81139207f,1.80938151f,
1.80737194f,1.80536334f,1.80335570f,1.80134902f,1.79934328f,1.79733848f,1.79533460f,1.79333164f,
1.79132959f,1.78932843f,1.78732817f,1.78532878f,1.78333027f,1.78133261f,1.77933581f,1.77733985f,
1.77534473f,1.77335043f,1.77135695f,1.76936428f,1.76737240f,1.76538132f,1.76339101f,1.76140148f,
1.75941271f,1.75742470f,1.75543743f,1.75345090f,1.75146510f,1.74948002f,1.74749565f,1.74551198f,
1.74352900f,1.74154672f,1.73956511f,1.73758417f,1.73560389f,1.73362426f,1.73164527f,1.72966692f,
1.72768920f,1.72571209f,1.72373560f,1.72175971f,1.71978441f,1.71780969f,1.71583556f,1.71386199f,
1.71188899f,1.70991653f,1.70794462f,1.70597325f,1.70400241f,1.70203209f,1.70006228f,1.69809297f,
1.69612416f,1.69415584f,1.69218799f,1.69022062f,1.68825372f,1.68628727f,1.68432127f,1.68235571f,
1.68039058f,1.67842588f,1.67646160f,1.67449772f,1.67253424f,1.67057116f,1.66860847f,1.66664615f,
1.66468420f,1.66272262f,1.66076139f,1.65880050f,1.65683996f,1.65487975f,1.65291986f,1.65096028f,
1.64900102f,1.64704205f,1.64508338f,1.64312500f,1.64116689f,1.63920905f,1.63725148f,1.63529416f,
1.63333709f,1.63138026f,1.62942366f,1.62746728f,1.62551112f,1.62355517f,1.62159943f,1.61964388f,
1.61768851f,1.61573332f,1.61377831f,1.61182346f,1.60986877f,1.60791422f,1.60595982f,1.60400556f,
1.60205142f,1.60009739f,1.59814349f,1.59618968f,1.59423597f,1.59228235f,1.59032882f,1.58837536f,
1.58642196f,1.58446863f,1.58251535f,1.58056211f,1.57860891f,1.57665574f,1.57470259f,1.57274945f,
1.57079633f,1.56884320f,1.56689007f,1.56493692f,1.56298375f,1.56103055f,1.55907731f,1.55712403f,
1.55517069f,1.55321730f,1.55126383f,1.54931030f,1.54735668f,1.54540297f,1.54344917f,1.54149526f,
1.53954124f,1.53758710f,1.53563283f,1.53367843f,1.53172389f,1.52976919f,1.52781434f,1.52585933f,
1.52390414f,1.52194878f,1.51999323f,1.51803748f,1.51608153f,1.51412537f,1.51216900f,1.51021240f,
1.50825556f,1.50629849f,1.50434117f,1.50238360f,1.50042576f,1.49846765f,1.49650927f,1.49455060f,
1.49259163f,1.49063237f,1.48867280f,1.48671291f,1.48475270f,1.48279215f,1.48083127f,1.47887004f,
1.47690845f,1.47494650f,1.47298419f,1.47102149f,1.46905841f,1.46709493f,1.46513106f,1.46316677f,
1.46120207f,1.45923694f,1.45727138f,1.45530538f,1.45333893f,1.45137203f,1.44940466f,1.44743682f,
1.44546850f,1.44349969f,1.44153038f,1.43956057f,1.43759024f,1.43561940f,1.43364803f,1.43167612f,
1.42970367f,1.42773066f,1.42575709f,1.42378296f,1.42180825f,1.41983295f,1.41785705f,1.41588056f,
1.41390346f,1.41192573f,1.40994738f,1.40796840f,1.40598877f,1.40400849f,1.40202755f,1.40004594f,
1.39806365f,1.39608068f,1.39409701f,1.39211264f,1.39012756f,1.38814175f,1.38615522f,1.38416795f,
1.38217994f,1.38019117f,1.37820164f,1.37621134f,1.37422025f,1.37222837f,1.37023570f,1.36824222f,
1.36624792f,1.36425280f,1.36225684f,1.36026004f,1.35826239f,1.35626387f,1.35426449f,1.35226422f,
1.35026307f,1.34826101f,1.34625805f,1.34425418f,1.34224937f,1.34024364f,1.33823695f,1.33622932f,
1.33422072f,1.33221114f,1.33020059f,1.32818904f,1.32617649f,1.32416292f,1.32214834f,1.32013273f,
1.31811607f,1.31609837f,1.31407960f,1.31205976f,1.31003885f,1.30801684f,1.30599373f,1.30396951f,
1.30194417f,1.29991770f,1.29789009f,1.29586133f,1.29383141f,1.29180031f,1.28976803f,1.28773456f,
1.28569989f,1.28366400f,1.28162688f,1.27958854f,1.27754894f,1.27550809f,1.27346597f,1.27142257f,
1.26937788f,1.26733189f,1.26528459f,1.26323597f,1.26118602f,1.25913471f,1.25708205f,1.25502803f,
1.25297262f,1.25091583f,1.24885763f,1.24679802f,1.24473698f,1.24267450f,1.24061058f,1.23854519f,
1.23647833f,1.23440999f,1.23234015f,1.23026880f,1.22819593f,1.22612152f,1.22404557f,1.22196806f,
1.21988898f,1.21780832f,1.21572606f,1.21364219f,1.21155670f,1.20946958f,1.20738080f,1.20529037f,
1.20319826f,1.20110447f,1.19900898f,1.19691177f,1.19481283f,1.19271216f,1.19060973f,1.18850553f,
1.18639955f,1.18429178f,1.18218219f,1.18007079f,1.17795754f,1.17584244f,1.17372548f,1.17160663f,
1.16948589f,1.16736324f,1.16523866f,1.16311215f,1.16098368f,1.15885323f,1.15672081f,1.15458638f,
1.15244994f,1.15031147f,1.14817095f,1.14602836f,1.14388370f,1.14173695f,1.13958808f,1.13743709f,
1.13528396f,1.13312866f,1.13097119f,1.12881153f,1.12664966f,1.12448556f,1.12231921f,1.12015061f,
1.11797973f,1.11580656f,1.11363107f,1.11145325f,1.10927308f,1.10709055f,1.10490563f,1.10271831f,
1.10052856f,1.09833638f,1.09614174f,1.09394462f,1.09174500f,1.08954287f,1.08733820f,1.08513098f,
1.08292118f,1.08070879f,1.07849378f,1.07627614f,1.07405585f,1.07183287f,1.06960721f,1.06737882f,
1.06514770f,1.06291382f,1.06067715f,1.05843769f,1.05619540f,1.05395026f,1.05170226f,1.04945136f,
1.04719755f,1.04494080f,1.04268110f,1.04041841f,1.03815271f,1.03588399f,1.03361221f,1.03133735f,
1.02905939f,1.02677830f,1.02449407f,1.02220665f,1.01991603f,1.01762219f,1.01532509f,1.01302471f,
1.01072102f,1.00841400f,1.00610363f,1.00378986f,1.00147268f,0.99915206f,0.99682798f,0.99450039f,
0.99216928f,0.98983461f,0.98749636f,0.98515449f,0.98280898f,0.98045980f,0.97810691f,0.97575030f,
0.97338991f,0.97102573f,0.96865772f,0.96628585f,0.96391009f,0.96153040f,0.95914675f,0.95675912f,
0.95436745f,0.95197173f,0.94957191f,0.94716796f,0.94475985f,0.94234754f,0.93993099f,0.93751017f,
0.93508504f,0.93265556f,0.93022170f,0.92778341f,0.92534066f,0.92289341f,0.92044161f,0.91798524f,
0.91552424f,0.91305858f,0.91058821f,0.90811309f,0.90563319f,0.90314845f,0.90065884f,0.89816430f,
0.89566479f,0.89316028f,0.89065070f,0.88813602f,0.88561619f,0.88309116f,0.88056088f,0.87802531f,
0.87548438f,0.87293806f,0.87038629f,0.86782901f,0.86526619f,0.86269775f,0.86012366f,0.85754385f,
0.85495827f,0.85236686f,0.84976956f,0.84716633f,0.84455709f,0.84194179f,0.83932037f,0.83669277f,
0.83405893f,0.83141877f,0.82877225f,0.82611928f,0.82345981f,0.82079378f,0.81812110f,0.81544172f,
0.81275556f,0.81006255f,0.80736262f,0.80465570f,0.80194171f,0.79922057f,0.79649221f,0.79375655f,
0.79101352f,0.78826302f,0.78550497f,0.78273931f,0.77996593f,0.77718475f,0.77439569f,0.77159865f,
0.76879355f,0.76598029f,0.76315878f,0.76032891f,0.75749061f,0.75464376f,0.75178826f,0.74892402f,
0.74605092f,0.74316887f,0.74027775f,0.73737744f,0.73446785f,0.73154885f,0.72862033f,0.72568217f,
0.72273425f,0.71977644f,0.71680861f,0.71383064f,0.71084240f,0.70784376f,0.70483456f,0.70181469f,
0.69878398f,0.69574231f,0.69268952f,0.68962545f,0.68654996f,0.68346288f,0.68036406f,0.67725332f,
0.67413051f,0.67099544f,0.66784794f,0.66468783f,0.66151492f,0.65832903f,0.65512997f,0.65191753f,
0.64869151f,0.64545170f,0.64219789f,0.63892987f,0.63564741f,0.63235028f,0.62903824f,0.62571106f,
0.62236849f,0.61901027f,0.61563615f,0.61224585f,0.60883911f,0.60541564f,0.60197515f,0.59851735f,
0.59504192f,0.59154856f,0.58803694f,0.58450672f,0.58095756f,0.57738911f,0.57380101f,0.57019288f,
0.56656433f,0.56291496f,0.55924437f,0.55555212f,0.55183778f,0.54810089f,0.54434099f,0.54055758f,
0.53675018f,0.53291825f,0.52906127f,0.52517867f,0.52126988f,0.51733431f,0.51337132f,0.50938028f,
0.50536051f,0.50131132f,0.49723200f,0.49312177f,0.48897987f,0.48480547f,0.48059772f,0.47635573f,
0.47207859f,0.46776530f,0.46341487f,0.45902623f,0.45459827f,0.45012983f,0.44561967f,0.44106652f,
0.43646903f,0.43182577f,0.42713525f,0.42239588f,0.41760600f,0.41276385f,0.40786755f,0.40291513f,
0.39790449f,0.39283339f,0.38769946f,0.38250016f,0.37723277f,0.37189441f,0.36648196f,0.36099209f,
0.35542120f,0.34976542f,0.34402054f,0.33818204f,0.33224495f,0.32620390f,0.32005298f,0.31378574f,
0.30739505f,0.30087304f,0.29421096f,0.28739907f,0.28042645f,0.27328078f,0.26594810f,0.25841250f,
0.25065566f,0.24265636f,0.23438976f,0.22582651f,0.21693146f,0.20766198f,0.19796546f,0.18777575f,
0.17700769f,0.16554844f,0.15324301f,0.13986823f,0.12508152f,0.10830610f,0.08841715f,0.06251018f,
0.0f
};

float G_acos(float x) {
	int index;

	if (x < -1.0f) x = -1.0f;
	else if (x > 1.0f) x = 1.0f;
	index = (1.0f + x) * 512.0f;
	return acostable[index];
}
#endif


/*
=============
TempVector

This is just a convenience function
for making temporary vectors for function calls
=============
*/
float	*tv( float x, float y, float z ) {
	static	int		index;
	static	vec3_t	vecs[8];
	float	*v;

	// use an array so that multiple tempvectors won't collide
	// for a while
	v = vecs[index];
	index = (index + 1)&7;

	v[0] = x;
	v[1] = y;
	v[2] = z;

	return v;
}


/*
=============
VectorToString

This is just a convenience function
for printing vectors
=============
*/
char	*vtos( const vec3_t v ) {
	static	int		index;
	static	char	str[8][32];
	char	*s;

	// use an array so that multiple vtos won't collide
	s = str[index];
	index = (index + 1)&7;

	Com_sprintf (s, 32, "(%i %i %i)", (int)v[0], (int)v[1], (int)v[2]);

	return s;
}


/*
===============
G_SetMovedir

The editor only specifies a single value for angles (yaw),
but we have special constants to generate an up or down direction.
Angles will be cleared, because it is being used to represent a direction
instead of an orientation.
===============
*/
void G_SetMovedir( vec3_t angles, vec3_t movedir ) {
	static vec3_t VEC_UP		= {0, -1, 0};
	static vec3_t MOVEDIR_UP	= {0, 0, 1};
	static vec3_t VEC_DOWN		= {0, -2, 0};
	static vec3_t MOVEDIR_DOWN	= {0, 0, -1};

	if ( VectorCompare (angles, VEC_UP) ) {
		VectorCopy (MOVEDIR_UP, movedir);
	} else if ( VectorCompare (angles, VEC_DOWN) ) {
		VectorCopy (MOVEDIR_DOWN, movedir);
	} else {
		AngleVectors (angles, movedir, NULL, NULL);
	}
	VectorClear( angles );
}


float vectoyaw( const vec3_t vec ) {
	float	yaw;

	if (vec[YAW] == 0 && vec[PITCH] == 0) {
		yaw = 0;
	} else {
		if (vec[PITCH]) {
			yaw = ( atan2( vec[YAW], vec[PITCH]) * 180 / M_PI );
		} else if (vec[YAW] > 0) {
			yaw = 90;
		} else {
			yaw = 270;
		}
		if (yaw < 0) {
			yaw += 360;
		}
	}

	return yaw;
}


static int numUsedEntities;	// JUHOX

void G_InitGentity( gentity_t *e ) {
	e->inuse = qtrue;
	e->classname = "noclass";
	e->s.number = e - g_entities;
	e->r.ownerNum = ENTITYNUM_NONE;
}

/*
=================
G_Spawn

Either finds a free entity, or allocates a new one.

  The slots from 0 to MAX_CLIENTS-1 are always reserved for clients, and will
never be used by anything else.

Try to avoid reusing an entity that was recently freed, because it
can cause the client to think the entity morphed into something else
instead of being removed and recreated, which can cause interpolated
angles and bad trails.
=================
*/
gentity_t *G_Spawn( void ) {
	int			i, force;
	gentity_t	*e;

	if (numUsedEntities < MAX_CLIENTS) numUsedEntities = MAX_CLIENTS;	// JUHOX
	e = NULL;	// shut up warning
	i = 0;		// shut up warning
	for ( force = 0 ; force < 2 ; force++ ) {
		// if we go through all entities and can't find one to free,
		// override the normal minimum times before use
		e = &g_entities[MAX_CLIENTS];
		for ( i = MAX_CLIENTS ; i<level.num_entities ; i++, e++) {
			if ( e->inuse ) {
				continue;
			}

			// the first couple seconds of server time can involve a lot of
			// freeing and allocating, so relax the replacement policy
			if ( !force && e->freetime > level.startTime + 2000 && level.time - e->freetime < 1000 ) {
				continue;
			}

			// reuse this slot
			G_InitGentity( e );
			numUsedEntities++;	// JUHOX
			return e;
		}
		if ( i /*!= MAX_GENTITIES*/<ENTITYNUM_MAX_NORMAL ) {	// JUHOX BUGFIX
			break;
		}
	}
	if ( i == ENTITYNUM_MAX_NORMAL ) {
		for (i = 0; i < MAX_GENTITIES; i++) {
			G_Printf("%4i: %s\n", i, g_entities[i].classname);
		}
		G_Error( "G_Spawn: no free entities" );
		return NULL;	// JUHOX BUGFIX
	}

	// open up a new slot
	level.num_entities++;

	// let the server system know that there are more entities
	trap_LocateGameData( level.gentities, level.num_entities, sizeof( gentity_t ),
		&level.clients[0].ps, sizeof( level.clients[0] ) );

	G_InitGentity( e );
	numUsedEntities++;	// JUHOX
	return e;
}

/*
=================
G_EntitiesFree
=================
*/
qboolean G_EntitiesFree( void ) {
	int			i;
	gentity_t	*e;

	e = &g_entities[MAX_CLIENTS];
	for ( i = MAX_CLIENTS; i < level.num_entities; i++, e++) {
		if ( e->inuse ) {
			continue;
		}
		// slot available
		return qtrue;
	}
	return qfalse;
}

/*
=================
JUHOX G_NumEntitiesFree
=================
*/
int G_NumEntitiesFree(void) {
	return ENTITYNUM_MAX_NORMAL - numUsedEntities;
}

/*
=================
G_FreeEntity

Marks the entity as free
=================
*/
void G_FreeEntity( gentity_t *ed ) {
	trap_UnlinkEntity (ed);		// unlink from world

	if ( ed->neverFree ) {
		return;
	}

	memset (ed, 0, sizeof(*ed));
	ed->classname = "freed";
	ed->freetime = level.time;
	ed->inuse = qfalse;
	numUsedEntities--;	// JUHOX
}

/*
=================
G_TempEntity

Spawns an event entity that will be auto-removed
The origin will be snapped to save net bandwidth, so care
must be taken if the origin is right on a surface (snap towards start vector first)
=================
*/
// JUHOX BUGFIX: add 'const' to G_TempEntity() parm 'origin'
#if 0
gentity_t *G_TempEntity( vec3_t origin, int event ) {
#else
gentity_t *G_TempEntity(const vec3_t origin, int event) {
#endif
	gentity_t		*e;
	vec3_t		snapped;

	e = G_Spawn();
	if (!e) return NULL;	// JUHOX BUGFIX
	e->s.eType = ET_EVENTS + event;

	e->classname = "tempEntity";
	e->eventTime = level.time;
	e->freeAfterEvent = qtrue;

	VectorCopy( origin, snapped );
	SnapVector( snapped );		// save network bandwidth
	G_SetOrigin( e, snapped );

	// find cluster for PVS
	trap_LinkEntity( e );

	return e;
}



/*
==============================================================================

Kill box

==============================================================================
*/

/*
=================
G_KillBox

Kills all entities that would touch the proposed new positioning
of ent.  Ent should be unlinked before calling this!
=================
*/
void G_KillBox (gentity_t *ent) {
	int			i, num;
	int			touch[MAX_GENTITIES];
	gentity_t	*hit;
	vec3_t		mins, maxs;

	VectorAdd( ent->client->ps.origin, ent->r.mins, mins );
	VectorAdd( ent->client->ps.origin, ent->r.maxs, maxs );
	num = trap_EntitiesInBox( mins, maxs, touch, MAX_GENTITIES );

	for (i=0 ; i<num ; i++) {
		hit = &g_entities[touch[i]];
		// JUHOX: let G_KillBox kill monster, too
		if (hit->s.eType != ET_PLAYER) continue;

		if (hit->health <= 0) continue;	// JUHOX

		// JUHOX: don't let the entity kill itself
		if (hit == ent) continue;	// why didn't they check this?


		// nail it
		G_Damage ( hit, ent, ent, NULL, NULL,
			100000, DAMAGE_NO_PROTECTION, MOD_TELEFRAG);
	}

}

//==============================================================================

/*
===============
G_AddPredictableEvent

Use for non-pmove events that would also be predicted on the
client side: jumppads and item pickups
Adds an event+parm and twiddles the event counter
===============
*/
void G_AddPredictableEvent( gentity_t *ent, int event, int eventParm ) {
	if ( !ent->client ) {
		return;
	}
	BG_AddPredictableEventToPlayerstate( event, eventParm, &ent->client->ps );
}


/*
===============
G_AddEvent

Adds an event+parm and twiddles the event counter
===============
*/
void G_AddEvent( gentity_t *ent, int event, int eventParm ) {
	int		bits;

	if ( !event ) {
		G_Printf( "G_AddEvent: zero event added for entity %i\n", ent->s.number );
		return;
	}

	// clients need to add the event in playerState_t instead of entityState_t
	if ( ent->client ) {
		bits = ent->client->ps.externalEvent & EV_EVENT_BITS;
		bits = ( bits + EV_EVENT_BIT1 ) & EV_EVENT_BITS;
		ent->client->ps.externalEvent = event | bits;
		ent->client->ps.externalEventParm = eventParm;
		ent->client->ps.externalEventTime = level.time;
	} else {
		bits = ent->s.event & EV_EVENT_BITS;
		bits = ( bits + EV_EVENT_BIT1 ) & EV_EVENT_BITS;
		ent->s.event = event | bits;
		ent->s.eventParm = eventParm;
	}
	ent->eventTime = level.time;
}


/*
=============
G_Sound
=============
*/
void G_Sound( gentity_t *ent, int channel, int soundIndex ) {
	gentity_t	*te;

	te = G_TempEntity( ent->r.currentOrigin, EV_GENERAL_SOUND );
	te->s.eventParm = soundIndex;
}


//==============================================================================


/*
================
G_SetOrigin

Sets the pos trajectory for a fixed position
================
*/

void G_SetOrigin(gentity_t *ent, const vec3_t origin) {

	VectorCopy( origin, ent->s.pos.trBase );
	ent->s.pos.trType = TR_STATIONARY;
	ent->s.pos.trTime = 0;
	ent->s.pos.trDuration = 0;
	VectorClear( ent->s.pos.trDelta );

	VectorCopy( origin, ent->r.currentOrigin );
}

/*
================
DebugLine

  debug polygons only work when running a local game
  with r_debugSurface set to 2
================
*/
int DebugLine(vec3_t start, vec3_t end, int color) {
	vec3_t points[4], dir, cross, up = {0, 0, 1};
	float dot;

	VectorCopy(start, points[0]);
	VectorCopy(start, points[1]);
	//points[1][2] -= 2;
	VectorCopy(end, points[2]);
	//points[2][2] -= 2;
	VectorCopy(end, points[3]);


	VectorSubtract(end, start, dir);
	VectorNormalize(dir);
	dot = DotProduct(dir, up);
	if (dot > 0.99 || dot < -0.99) VectorSet(cross, 1, 0, 0);
	else CrossProduct(dir, up, cross);

	VectorNormalize(cross);

	VectorMA(points[0], 2, cross, points[0]);
	VectorMA(points[1], -2, cross, points[1]);
	VectorMA(points[2], -2, cross, points[2]);
	VectorMA(points[3], 2, cross, points[3]);

	return trap_DebugPolygonCreate(color, 4, points);
}
