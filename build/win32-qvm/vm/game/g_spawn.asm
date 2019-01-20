export G_SpawnString
code
proc G_SpawnString 8 8
file "..\..\..\..\code\game\g_spawn.c"
line 124
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:
;4:#include "g_local.h"
;5:
;6:#if ESCAPE_MODE	// JUHOX: variables & definitions for EFH
;7:#define MAX_ENTITY_TEMPLATES		4096
;8:#define MAX_SEGMENTTYPES			256
;9:#define MAX_ENTITIES_PER_SEGMENT	64
;10:#define MAX_WORLD_SEGMENTS			65536
;11:#define MAX_CACHED_MONSTERS			1024
;12:#define MAX_VIEWDISTANCE			3000
;13:#define MAX_WAYPOINTS				16
;14:#define MAX_STYLES					100
;15:#define STYLE_NAME_MAX_SIZE			32
;16:#define MAX_PARALLEL_STYLES			10
;17:#define MAX_FINALIZATION_SUCCESSORS	32
;18:
;19:typedef struct {
;20:	int count;
;21:	vec3_t origin;
;22:} efhWaypoint_t;
;23:typedef enum {
;24:	REACH_unreachable,
;25:	REACH_reachable,
;26:	REACH_loopable
;27:} REACHABILITY;
;28:typedef struct {
;29:	int minStepsToFinalSegment;
;30:	qboolean visited;	// temporarily used
;31:	REACHABILITY reachability;
;32:	char name[STYLE_NAME_MAX_SIZE];
;33:} efhTransitionStyle_t;
;34:typedef struct {
;35:	efhTransitionStyle_t* entrance;
;36:	efhTransitionStyle_t* exit;
;37:	float frequency;
;38:} efhStyleEntry_t;
;39:typedef struct efhSegmentType_s {
;40:	int numEntities;
;41:	int entityTemplateIndex[MAX_ENTITIES_PER_SEGMENT];
;42:	int numWayPoints;
;43:	efhWaypoint_t wayPoints[MAX_WAYPOINTS];
;44:	unsigned long wayLength;
;45:	qboolean entranceSet;
;46:	vec3_t entranceOrigin;
;47:	qboolean exitSet;
;48:	vec3_t exitOrigin;
;49:	qboolean final;
;50:	qboolean initial;
;51:	qboolean visBlocking;
;52:	efhVector_t exitDelta;
;53:	const gentity_t* goalTemplate;
;54:	vec3_t absmin;
;55:	vec3_t absmax;
;56:	vec3_t boundingMin;
;57:	vec3_t boundingMax;
;58:	char* name;
;59:	int idnum;
;60:	efhStyleEntry_t styles[MAX_PARALLEL_STYLES];
;61:	qboolean frustrating;
;62:} efhSegmentType_t;
;63:typedef struct {
;64:	int sourceSegment;	// index in efhWorld, -1 if unused
;65:	int sourceEntity;	// index in entityTemplates
;66:	int index;
;67:	int currentSegment;	// index in efhWorld, -1 if spawned
;68:	efhVector_t position;
;69:	vec3_t angles;
;70:	monsterspawnmode_t spawnmode;
;71:	monsterType_t type;
;72:	int maxHealth;
;73:	monsterAction_t action;
;74:} efhCachedMonster_t;
;75:typedef enum {
;76:	ESS_removed,
;77:	ESS_solidPartSpawned,
;78:	ESS_spawned
;79:} efhSegmentState_t;
;80:typedef enum {
;81:	ESC_spawnCompletely,
;82:	ESC_spawnSolidOnly,
;83:	ESC_spawnNonSolidOnly
;84:} efhSpawnCommand_t;
;85:
;86:static vec3_t efhSpaceMins;
;87:static vec3_t efhSpaceMaxs;
;88:
;89:static int numEntityTemplates;
;90:static gentity_t entityTemplates[MAX_ENTITY_TEMPLATES];
;91:
;92:static int numSegmentTypes;
;93:static efhSegmentType_t segmentTypes[MAX_SEGMENTTYPES+1];
;94://static efhSegmentType_t* initialSegmentType;
;95:
;96:static int debugModeChoosenSegmentType;
;97:static int debugSegment;
;98:static int oldDebugSegment;
;99:
;100:static efhSegmentType_t* efhWorld[MAX_WORLD_SEGMENTS];
;101:static unsigned long totalWayLength[MAX_WORLD_SEGMENTS];
;102:static unsigned char segmentState[MAX_WORLD_SEGMENTS];		// efhSegmentState_t
;103:static unsigned char newSegmentState[MAX_WORLD_SEGMENTS];	// efhSegmentState_t
;104:static unsigned char visitedSegments[MAX_WORLD_SEGMENTS/8];	// bit flags
;105:static int numFallbacks;
;106:
;107:static int currentSegment;
;108:static efhVector_t currentSegmentOrigin;
;109:static int maxSegment;
;110:
;111:static efhCachedMonster_t cachedMonsters[MAX_CACHED_MONSTERS];
;112:
;113:static int numTransitionStyles;
;114:static efhTransitionStyle_t transitionStyles[MAX_STYLES];
;115:
;116:static efhTransitionStyle_t* worldStyle;
;117:static unsigned long worldWayLength;
;118:static int worldEnd;
;119:static localseed_t worldCreationSeed;
;120:
;121:static unsigned long monsterSpawnSeed;
;122:#endif
;123:
;124:qboolean	G_SpawnString( const char *key, const char *defaultString, char **out ) {
line 127
;125:	int		i;
;126:
;127:	if ( !level.spawning ) {
ADDRGP4 level+4520
INDIRI4
CNSTI4 0
NEI4 $95
line 128
;128:		*out = (char *)defaultString;
ADDRFP4 8
INDIRP4
ADDRFP4 4
INDIRP4
ASGNP4
line 130
;129://		G_Error( "G_SpawnString() called while not spawning" );
;130:	}
LABELV $95
line 132
;131:
;132:	for ( i = 0 ; i < level.numSpawnVars ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $101
JUMPV
LABELV $98
line 133
;133:		if ( !Q_stricmp( key, level.spawnVars[i][0] ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 level+4528
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $103
line 134
;134:			*out = level.spawnVars[i][1];
ADDRFP4 8
INDIRP4
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 level+4528+4
ADDP4
INDIRP4
ASGNP4
line 135
;135:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $94
JUMPV
LABELV $103
line 137
;136:		}
;137:	}
LABELV $99
line 132
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $101
ADDRLP4 0
INDIRI4
ADDRGP4 level+4524
INDIRI4
LTI4 $98
line 139
;138:
;139:	*out = (char *)defaultString;
ADDRFP4 8
INDIRP4
ADDRFP4 4
INDIRP4
ASGNP4
line 140
;140:	return qfalse;
CNSTI4 0
RETI4
LABELV $94
endproc G_SpawnString 8 8
export G_SpawnFloat
proc G_SpawnFloat 16 12
line 143
;141:}
;142:
;143:qboolean	G_SpawnFloat( const char *key, const char *defaultString, float *out ) {
line 147
;144:	char		*s;
;145:	qboolean	present;
;146:
;147:	present = G_SpawnString( key, defaultString, &s );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 8
ADDRGP4 G_SpawnString
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 148
;148:	*out = atof( s );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 atof
CALLF4
ASGNF4
ADDRFP4 8
INDIRP4
ADDRLP4 12
INDIRF4
ASGNF4
line 149
;149:	return present;
ADDRLP4 4
INDIRI4
RETI4
LABELV $108
endproc G_SpawnFloat 16 12
export G_SpawnInt
proc G_SpawnInt 16 12
line 152
;150:}
;151:
;152:qboolean	G_SpawnInt( const char *key, const char *defaultString, int *out ) {
line 156
;153:	char		*s;
;154:	qboolean	present;
;155:
;156:	present = G_SpawnString( key, defaultString, &s );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 8
ADDRGP4 G_SpawnString
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 157
;157:	*out = atoi( s );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
line 158
;158:	return present;
ADDRLP4 4
INDIRI4
RETI4
LABELV $109
endproc G_SpawnInt 16 12
export G_SpawnVector
proc G_SpawnVector 16 20
line 161
;159:}
;160:
;161:qboolean	G_SpawnVector( const char *key, const char *defaultString, float *out ) {
line 165
;162:	char		*s;
;163:	qboolean	present;
;164:
;165:	present = G_SpawnString( key, defaultString, &s );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 8
ADDRGP4 G_SpawnString
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 166
;166:	sscanf( s, "%f %f %f", &out[0], &out[1], &out[2] );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $111
ARGP4
ADDRLP4 12
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
ARGP4
ADDRGP4 sscanf
CALLI4
pop
line 167
;167:	return present;
ADDRLP4 4
INDIRI4
RETI4
LABELV $110
endproc G_SpawnVector 16 20
data
export fields
align 4
LABELV fields
address $114
byte 4 528
byte 4 2
skip 4
address $115
byte 4 92
byte 4 4
skip 4
address $116
byte 4 544
byte 4 2
skip 4
address $117
byte 4 548
byte 4 2
skip 4
address $118
byte 4 532
byte 4 0
skip 4
address $119
byte 4 676
byte 4 1
skip 4
address $120
byte 4 652
byte 4 2
skip 4
address $121
byte 4 656
byte 4 2
skip 4
address $122
byte 4 640
byte 4 2
skip 4
address $123
byte 4 660
byte 4 2
skip 4
address $124
byte 4 800
byte 4 1
skip 4
address $125
byte 4 804
byte 4 1
skip 4
address $126
byte 4 764
byte 4 0
skip 4
address $127
byte 4 736
byte 4 0
skip 4
address $128
byte 4 0
byte 4 9
skip 4
address $129
byte 4 744
byte 4 0
skip 4
address $130
byte 4 116
byte 4 4
skip 4
address $131
byte 4 116
byte 4 5
skip 4
address $132
byte 4 664
byte 4 2
skip 4
address $133
byte 4 668
byte 4 2
skip 4
address $134
byte 4 840
byte 4 0
skip 4
byte 4 0
skip 12
export SP_item_botroam
code
proc SP_item_botroam 0 4
line 301
;168:}
;169:
;170:
;171:
;172://
;173:// fields are needed for spawning from the entity string
;174://
;175:typedef enum {
;176:	F_INT,
;177:	F_FLOAT,
;178:	F_LSTRING,			// string on disk, pointer in memory, TAG_LEVEL
;179:	F_GSTRING,			// string on disk, pointer in memory, TAG_GAME
;180:	F_VECTOR,
;181:	F_ANGLEHACK,
;182:	F_ENTITY,			// index on disk, pointer in memory
;183:	F_ITEM,				// index on disk, pointer in memory
;184:	F_CLIENT,			// index on disk, pointer in memory
;185:	F_IGNORE
;186:} fieldtype_t;
;187:
;188:typedef struct
;189:{
;190:	char	*name;
;191:	int		ofs;
;192:	fieldtype_t	type;
;193:	int		flags;
;194:} field_t;
;195:
;196:field_t fields[] = {
;197:	{"classname", FOFS(classname), F_LSTRING},
;198:	{"origin", FOFS(s.origin), F_VECTOR},
;199:	{"model", FOFS(model), F_LSTRING},
;200:	{"model2", FOFS(model2), F_LSTRING},
;201:	{"spawnflags", FOFS(spawnflags), F_INT},
;202:	{"speed", FOFS(speed), F_FLOAT},
;203:	{"target", FOFS(target), F_LSTRING},
;204:	{"targetname", FOFS(targetname), F_LSTRING},
;205:	{"message", FOFS(message), F_LSTRING},
;206:	{"team", FOFS(team), F_LSTRING},
;207:	{"wait", FOFS(wait), F_FLOAT},
;208:	{"random", FOFS(random), F_FLOAT},
;209:	{"count", FOFS(count), F_INT},
;210:	{"health", FOFS(health), F_INT},
;211:	{"light", 0, F_IGNORE},
;212:	{"dmg", FOFS(damage), F_INT},
;213:	{"angles", FOFS(s.angles), F_VECTOR},
;214:	{"angle", FOFS(s.angles), F_ANGLEHACK},
;215:	{"targetShaderName", FOFS(targetShaderName), F_LSTRING},
;216:	{"targetShaderNewName", FOFS(targetShaderNewName), F_LSTRING},
;217:#if ESCAPE_MODE
;218:	{"idnum", FOFS(idnum), F_INT},	// JUHOX
;219:#endif
;220:
;221:	{NULL}
;222:};
;223:
;224:
;225:typedef struct {
;226:	char	*name;
;227:	void	(*spawn)(gentity_t *ent);
;228:} spawn_t;
;229:
;230:void SP_info_player_start (gentity_t *ent);
;231:void SP_info_player_deathmatch (gentity_t *ent);
;232:void SP_info_player_intermission (gentity_t *ent);
;233:void SP_info_firstplace(gentity_t *ent);
;234:void SP_info_secondplace(gentity_t *ent);
;235:void SP_info_thirdplace(gentity_t *ent);
;236:void SP_info_podium(gentity_t *ent);
;237:
;238:void SP_func_plat (gentity_t *ent);
;239:void SP_func_static (gentity_t *ent);
;240:void SP_func_rotating (gentity_t *ent);
;241:void SP_func_bobbing (gentity_t *ent);
;242:void SP_func_pendulum( gentity_t *ent );
;243:void SP_func_button (gentity_t *ent);
;244:void SP_func_door (gentity_t *ent);
;245:void SP_func_train (gentity_t *ent);
;246:void SP_func_timer (gentity_t *self);
;247:
;248:void SP_trigger_always (gentity_t *ent);
;249:void SP_trigger_multiple (gentity_t *ent);
;250:void SP_trigger_push (gentity_t *ent);
;251:void SP_trigger_teleport (gentity_t *ent);
;252:void SP_trigger_hurt (gentity_t *ent);
;253:
;254:void SP_target_remove_powerups( gentity_t *ent );
;255:void SP_target_give (gentity_t *ent);
;256:void SP_target_delay (gentity_t *ent);
;257:void SP_target_speaker (gentity_t *ent);
;258:void SP_target_print (gentity_t *ent);
;259:void SP_target_laser (gentity_t *self);
;260:void SP_target_character (gentity_t *ent);
;261:void SP_target_score( gentity_t *ent );
;262:void SP_target_teleporter( gentity_t *ent );
;263:void SP_target_relay (gentity_t *ent);
;264:void SP_target_kill (gentity_t *ent);
;265:void SP_target_position (gentity_t *ent);
;266:void SP_target_location (gentity_t *ent);
;267:void SP_target_push (gentity_t *ent);
;268:#if MONSTER_MODE
;269:void SP_target_earthquake(gentity_t* ent);	// JUHOX
;270:#endif
;271:
;272:void SP_light (gentity_t *self);
;273:void SP_info_null (gentity_t *self);
;274:void SP_info_notnull (gentity_t *self);
;275:void SP_info_camp (gentity_t *self);
;276:void SP_path_corner (gentity_t *self);
;277:
;278:void SP_misc_teleporter_dest (gentity_t *self);
;279:void SP_misc_model(gentity_t *ent);
;280:void SP_misc_portal_camera(gentity_t *ent);
;281:void SP_misc_portal_surface(gentity_t *ent);
;282:
;283:void SP_shooter_rocket( gentity_t *ent );
;284:void SP_shooter_plasma( gentity_t *ent );
;285:void SP_shooter_grenade( gentity_t *ent );
;286:
;287:void SP_team_CTF_redplayer( gentity_t *ent );
;288:void SP_team_CTF_blueplayer( gentity_t *ent );
;289:
;290:void SP_team_CTF_redspawn( gentity_t *ent );
;291:void SP_team_CTF_bluespawn( gentity_t *ent );
;292:
;293:#ifdef MISSIONPACK
;294:void SP_team_blueobelisk( gentity_t *ent );
;295:void SP_team_redobelisk( gentity_t *ent );
;296:void SP_team_neutralobelisk( gentity_t *ent );
;297:#endif
;298:#if !ESCAPE_MODE	// JUHOX: don't spawn item_botroam in EFH
;299:void SP_item_botroam( gentity_t *ent ) {}/*;*/	// JUHOX BUGFIX: removed ';'
;300:#else
;301:void SP_item_botroam(gentity_t* ent) {
line 302
;302:	if (g_gametype.integer == GT_EFH) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
NEI4 $137
line 303
;303:		G_FreeEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 304
;304:		return;
LABELV $137
line 306
;305:	}
;306:}
LABELV $136
endproc SP_item_botroam 0 4
data
export spawns
align 4
LABELV spawns
address $140
address SP_info_player_start
address $141
address SP_info_player_deathmatch
address $142
address SP_info_player_intermission
address $143
address SP_info_null
address $144
address SP_info_notnull
address $145
address SP_info_camp
address $146
address SP_func_plat
address $147
address SP_func_button
address $148
address SP_func_door
address $149
address SP_func_static
address $150
address SP_func_rotating
address $151
address SP_func_bobbing
address $152
address SP_func_pendulum
address $153
address SP_func_train
address $154
address SP_info_null
address $155
address SP_func_timer
address $156
address SP_trigger_always
address $157
address SP_trigger_multiple
address $158
address SP_trigger_push
address $159
address SP_trigger_teleport
address $160
address SP_trigger_hurt
address $161
address SP_target_give
address $162
address SP_target_remove_powerups
address $163
address SP_target_delay
address $164
address SP_target_speaker
address $165
address SP_target_print
address $166
address SP_target_laser
address $167
address SP_target_score
address $168
address SP_target_teleporter
address $169
address SP_target_relay
address $170
address SP_target_kill
address $171
address SP_target_position
address $172
address SP_target_location
address $173
address SP_target_push
address $174
address SP_target_earthquake
address $128
address SP_light
address $175
address SP_path_corner
address $176
address SP_misc_teleporter_dest
address $177
address SP_misc_model
address $178
address SP_misc_portal_surface
address $179
address SP_misc_portal_camera
address $180
address SP_shooter_rocket
address $181
address SP_shooter_grenade
address $182
address SP_shooter_plasma
address $183
address SP_team_CTF_redplayer
address $184
address SP_team_CTF_blueplayer
address $185
address SP_team_CTF_redspawn
address $186
address SP_team_CTF_bluespawn
address $187
address SP_item_botroam
address $188
address SP_efh_hull
address $189
address SP_efh_model
address $190
address SP_efh_brush
address $191
address SP_efh_null_brush
address $192
address SP_efh_entrance
address $193
address SP_efh_exit
address $194
address SP_efh_monster
address $195
address SP_efh_waypoint
byte 4 0
byte 4 0
code
proc AddEmergencySpawnPoint 16 0
line 415
;307:#endif
;308:
;309:#if ESCAPE_MODE	// JUHOX: prototypes for EFH spawn functions
;310:static void SP_efh_hull(gentity_t* ent);
;311:static void SP_efh_model(gentity_t* ent);
;312:static void SP_efh_brush(gentity_t* ent);
;313:static void SP_efh_null_brush(gentity_t* ent);
;314:static void SP_efh_entrance(gentity_t* ent);
;315:static void SP_efh_exit(gentity_t* ent);
;316:static void SP_efh_monster(gentity_t* ent);
;317:static void SP_efh_waypoint(gentity_t* ent);
;318:#endif
;319:
;320:spawn_t	spawns[] = {
;321:	// info entities don't do anything at all, but provide positional
;322:	// information for things controlled by other processes
;323:	{"info_player_start", SP_info_player_start},
;324:	{"info_player_deathmatch", SP_info_player_deathmatch},
;325:	{"info_player_intermission", SP_info_player_intermission},
;326:	{"info_null", SP_info_null},
;327:	{"info_notnull", SP_info_notnull},		// use target_position instead
;328:	{"info_camp", SP_info_camp},
;329:
;330:	{"func_plat", SP_func_plat},
;331:	{"func_button", SP_func_button},
;332:	{"func_door", SP_func_door},
;333:	{"func_static", SP_func_static},
;334:	{"func_rotating", SP_func_rotating},
;335:	{"func_bobbing", SP_func_bobbing},
;336:	{"func_pendulum", SP_func_pendulum},
;337:	{"func_train", SP_func_train},
;338:	{"func_group", SP_info_null},
;339:	{"func_timer", SP_func_timer},			// rename trigger_timer?
;340:
;341:	// Triggers are brush objects that cause an effect when contacted
;342:	// by a living player, usually involving firing targets.
;343:	// While almost everything could be done with
;344:	// a single trigger class and different targets, triggered effects
;345:	// could not be client side predicted (push and teleport).
;346:	{"trigger_always", SP_trigger_always},
;347:	{"trigger_multiple", SP_trigger_multiple},
;348:	{"trigger_push", SP_trigger_push},
;349:	{"trigger_teleport", SP_trigger_teleport},
;350:	{"trigger_hurt", SP_trigger_hurt},
;351:
;352:	// targets perform no action by themselves, but must be triggered
;353:	// by another entity
;354:	{"target_give", SP_target_give},
;355:	{"target_remove_powerups", SP_target_remove_powerups},
;356:	{"target_delay", SP_target_delay},
;357:	{"target_speaker", SP_target_speaker},
;358:	{"target_print", SP_target_print},
;359:	{"target_laser", SP_target_laser},
;360:	{"target_score", SP_target_score},
;361:	{"target_teleporter", SP_target_teleporter},
;362:	{"target_relay", SP_target_relay},
;363:	{"target_kill", SP_target_kill},
;364:	{"target_position", SP_target_position},
;365:	{"target_location", SP_target_location},
;366:	{"target_push", SP_target_push},
;367:#if MONSTER_MODE
;368:	{"target_earthquake", SP_target_earthquake},
;369:#endif
;370:
;371:	{"light", SP_light},
;372:	{"path_corner", SP_path_corner},
;373:
;374:	{"misc_teleporter_dest", SP_misc_teleporter_dest},
;375:	{"misc_model", SP_misc_model},
;376:	{"misc_portal_surface", SP_misc_portal_surface},
;377:	{"misc_portal_camera", SP_misc_portal_camera},
;378:
;379:	{"shooter_rocket", SP_shooter_rocket},
;380:	{"shooter_grenade", SP_shooter_grenade},
;381:	{"shooter_plasma", SP_shooter_plasma},
;382:
;383:	{"team_CTF_redplayer", SP_team_CTF_redplayer},
;384:	{"team_CTF_blueplayer", SP_team_CTF_blueplayer},
;385:
;386:	{"team_CTF_redspawn", SP_team_CTF_redspawn},
;387:	{"team_CTF_bluespawn", SP_team_CTF_bluespawn},
;388:
;389:#ifdef MISSIONPACK
;390:	{"team_redobelisk", SP_team_redobelisk},
;391:	{"team_blueobelisk", SP_team_blueobelisk},
;392:	{"team_neutralobelisk", SP_team_neutralobelisk},
;393:#endif
;394:	{"item_botroam", SP_item_botroam},
;395:
;396:#if ESCAPE_MODE	// JUHOX: EFH spawn functions
;397:	{"efh_hull", SP_efh_hull},
;398:	{"efh_model", SP_efh_model},
;399:	{"efh_brush", SP_efh_brush},
;400:	{"efh_null_brush", SP_efh_null_brush},
;401:	{"efh_entrance", SP_efh_entrance},
;402:	{"efh_exit", SP_efh_exit},
;403:	{"efh_monster", SP_efh_monster},
;404:	{"efh_waypoint", SP_efh_waypoint},
;405:#endif
;406:
;407:	{0, 0}
;408:};
;409:
;410:/*
;411:===============
;412:JUHOX: AddEmergencySpawnPoint
;413:===============
;414:*/
;415:static void AddEmergencySpawnPoint(const vec3_t origin) {
line 419
;416:	vec3_t pos;
;417:
;418:#if ESCAPE_MODE
;419:	if (g_gametype.integer == GT_EFH) return;	// JUHOX
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
NEI4 $197
ADDRGP4 $196
JUMPV
LABELV $197
line 421
;420:#endif
;421:	if (level.numEmergencySpawnPoints >= MAX_GENTITIES) return;
ADDRGP4 level+10700
INDIRI4
CNSTI4 1024
LTI4 $200
ADDRGP4 $196
JUMPV
LABELV $200
line 423
;422:
;423:	VectorCopy(origin, pos);
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 425
;424:	//pos[2] += 9;
;425:	VectorCopy(pos, level.emergencySpawnPoints[level.numEmergencySpawnPoints]);
ADDRGP4 level+10700
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 level+10704
ADDP4
ADDRLP4 0
INDIRB
ASGNB 12
line 426
;426:	level.numEmergencySpawnPoints++;
ADDRLP4 12
ADDRGP4 level+10700
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 427
;427:}
LABELV $196
endproc AddEmergencySpawnPoint 16 0
export G_CallSpawn
proc G_CallSpawn 44 8
line 437
;428:
;429:/*
;430:===============
;431:G_CallSpawn
;432:
;433:Finds the spawn function for the entity and calls it,
;434:returning qfalse if not found
;435:===============
;436:*/
;437:qboolean G_CallSpawn( gentity_t *ent ) {
line 441
;438:	spawn_t	*s;
;439:	gitem_t	*item;
;440:
;441:	if ( !ent->classname ) {
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $207
line 442
;442:		G_Printf ("G_CallSpawn: NULL classname\n");
ADDRGP4 $209
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 443
;443:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $206
JUMPV
LABELV $207
line 447
;444:	}
;445:
;446:	// check item spawn functions
;447:	for ( item=bg_itemlist+1 ; item->classname ; item++ ) {
ADDRLP4 0
ADDRGP4 bg_itemlist+52
ASGNP4
ADDRGP4 $213
JUMPV
LABELV $210
line 448
;448:		if ( !strcmp(item->classname, ent->classname) ) {
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $215
line 449
;449:			AddEmergencySpawnPoint(ent->s.origin);	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRGP4 AddEmergencySpawnPoint
CALLV
pop
line 452
;450:#if 1	// JUHOX: no flags in non-ctf games (we're able to load all maps now!)
;451:			if (
;452:				item->giType == IT_TEAM &&
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
NEI4 $217
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
EQI4 $217
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
NEI4 $221
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 8
EQI4 $217
LABELV $221
line 462
;453:				NOT (
;454:					g_gametype.integer == GT_CTF
;455:#if ESCAPE_MODE
;456:					|| (
;457:						g_gametype.integer == GT_EFH &&
;458:						item->giTag == PW_BLUEFLAG
;459:					)
;460:#endif
;461:				)
;462:			) {
line 463
;463:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $206
JUMPV
LABELV $217
line 467
;464:			}
;465:#endif
;466:#if MAPLENSFLARES	// JUHOX: no items in lens flare editor
;467:			if (g_editmode.integer == EM_mlf) {
ADDRGP4 g_editmode+12
INDIRI4
CNSTI4 1
NEI4 $222
line 469
;468:				// don't remove, otherwise movers could change their entity number
;469:				ent->s.eType = ET_INVISIBLE;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 10
ASGNI4
line 470
;470:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $206
JUMPV
LABELV $222
line 474
;471:			}
;472:#endif
;473:#if 1	// JUHOX: check for no-items option
;474:			if (g_noItems.integer && item->giType != IT_TEAM) return qfalse;
ADDRGP4 g_noItems+12
INDIRI4
CNSTI4 0
EQI4 $225
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
EQI4 $225
CNSTI4 0
RETI4
ADDRGP4 $206
JUMPV
LABELV $225
line 478
;475:#endif
;476:#if 1	// JUHOX: item replacement
;477:#if ESCAPE_MODE
;478:			if (g_gametype.integer == GT_EFH) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
NEI4 $228
line 480
;479:				// no replacement
;480:			}
ADDRGP4 $229
JUMPV
LABELV $228
line 483
;481:			else
;482:#endif
;483:			if (item->giType == IT_POWERUP) {
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 5
NEI4 $231
line 484
;484:				item = BG_FindItemForPowerup(PW_REGEN);
CNSTI4 5
ARGI4
ADDRLP4 16
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 485
;485:				if (!item) return qfalse;	// should not happen
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $232
CNSTI4 0
RETI4
ADDRGP4 $206
JUMPV
line 486
;486:			}
LABELV $231
line 487
;487:			else if (item->giType == IT_WEAPON) {
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 1
NEI4 $235
line 488
;488:				switch (item->giTag) {
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 1
LTI4 $237
ADDRLP4 16
INDIRI4
CNSTI4 9
GTI4 $237
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $250-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $250
address $240
address $240
address $242
address $244
address $246
address $244
address $244
address $246
address $248
code
LABELV $240
line 491
;489:				case WP_GAUNTLET:
;490:				case WP_MACHINEGUN:
;491:					item = BG_FindItem("5 Health");
ADDRGP4 $241
ARGP4
ADDRLP4 24
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 24
INDIRP4
ASGNP4
line 492
;492:					break;
ADDRGP4 $238
JUMPV
LABELV $242
line 494
;493:				case WP_SHOTGUN:
;494:					item = BG_FindItem("25 Health");
ADDRGP4 $243
ARGP4
ADDRLP4 28
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ASGNP4
line 495
;495:					break;
ADDRGP4 $238
JUMPV
LABELV $244
line 499
;496:				case WP_GRENADE_LAUNCHER:
;497:				case WP_LIGHTNING:
;498:				case WP_RAILGUN:
;499:					item = BG_FindItem("Armor");
ADDRGP4 $245
ARGP4
ADDRLP4 32
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 32
INDIRP4
ASGNP4
line 500
;500:					break;
ADDRGP4 $238
JUMPV
LABELV $246
line 503
;501:				case WP_ROCKET_LAUNCHER:
;502:				case WP_PLASMAGUN:
;503:					item = BG_FindItem("50 Health");
ADDRGP4 $247
ARGP4
ADDRLP4 36
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 36
INDIRP4
ASGNP4
line 504
;504:					break;
ADDRGP4 $238
JUMPV
LABELV $248
line 506
;505:				case WP_BFG:
;506:					item = BG_FindItem("Mega Health");
ADDRGP4 $249
ARGP4
ADDRLP4 40
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 40
INDIRP4
ASGNP4
line 507
;507:					break;
ADDRGP4 $238
JUMPV
LABELV $237
line 509
;508:				default:
;509:					return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $206
JUMPV
LABELV $238
line 511
;510:				}
;511:				if (!item) return qfalse;
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $236
CNSTI4 0
RETI4
ADDRGP4 $206
JUMPV
line 512
;512:			}
LABELV $235
line 513
;513:			else if (item->giType == IT_AMMO) {
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 2
NEI4 $254
line 514
;514:				switch (item->giTag) {
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 1
LTI4 $256
ADDRLP4 16
INDIRI4
CNSTI4 9
GTI4 $256
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $264-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $264
address $259
address $259
address $259
address $261
address $261
address $260
address $260
address $261
address $262
code
LABELV $259
line 518
;515:				case WP_GAUNTLET:
;516:				case WP_MACHINEGUN:
;517:				case WP_SHOTGUN:
;518:					item = BG_FindItem("5 Health");
ADDRGP4 $241
ARGP4
ADDRLP4 24
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 24
INDIRP4
ASGNP4
line 519
;519:					break;
ADDRGP4 $257
JUMPV
LABELV $260
line 522
;520:				case WP_LIGHTNING:
;521:				case WP_RAILGUN:
;522:					item = BG_FindItem("50 Health");
ADDRGP4 $247
ARGP4
ADDRLP4 28
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ASGNP4
line 523
;523:					break;
ADDRGP4 $257
JUMPV
LABELV $261
line 527
;524:				case WP_GRENADE_LAUNCHER:
;525:				case WP_ROCKET_LAUNCHER:
;526:				case WP_PLASMAGUN:
;527:					item = BG_FindItem("25 Health");
ADDRGP4 $243
ARGP4
ADDRLP4 32
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 32
INDIRP4
ASGNP4
line 528
;528:					break;
ADDRGP4 $257
JUMPV
LABELV $262
line 530
;529:				case WP_BFG:
;530:					item = BG_FindItem("Heavy Armor");
ADDRGP4 $263
ARGP4
ADDRLP4 36
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 36
INDIRP4
ASGNP4
line 531
;531:					break;
ADDRGP4 $257
JUMPV
LABELV $256
line 533
;532:				default:
;533:					return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $206
JUMPV
LABELV $257
line 535
;534:				}
;535:				if (!item) return qfalse;
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $266
CNSTI4 0
RETI4
ADDRGP4 $206
JUMPV
LABELV $266
line 536
;536:			}
LABELV $254
LABELV $236
LABELV $232
LABELV $229
line 538
;537:#endif
;538:			G_SpawnItem( ent, item );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_SpawnItem
CALLV
pop
line 539
;539:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $206
JUMPV
LABELV $215
line 541
;540:		}
;541:	}
LABELV $211
line 447
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
ASGNP4
LABELV $213
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $210
line 544
;542:
;543:	// check normal spawn functions
;544:	for ( s=spawns ; s->name ; s++ ) {
ADDRLP4 4
ADDRGP4 spawns
ASGNP4
ADDRGP4 $271
JUMPV
LABELV $268
line 545
;545:		if ( !strcmp(s->name, ent->classname) ) {
ADDRLP4 4
INDIRP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $272
line 547
;546:			// found it
;547:			s->spawn(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 548
;548:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $206
JUMPV
LABELV $272
line 550
;549:		}
;550:	}
LABELV $269
line 544
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
LABELV $271
ADDRLP4 4
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $268
line 551
;551:	G_Printf ("%s doesn't have a spawn function\n", ent->classname);
ADDRGP4 $274
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 552
;552:	return qfalse;
CNSTI4 0
RETI4
LABELV $206
endproc G_CallSpawn 44 8
export G_NewString
proc G_NewString 32 4
line 563
;553:}
;554:
;555:/*
;556:=============
;557:G_NewString
;558:
;559:Builds a copy of the string, translating \n to real linefeeds
;560:so message texts can be multi-line
;561:=============
;562:*/
;563:char *G_NewString( const char *string ) {
line 567
;564:	char	*newb, *new_p;
;565:	int		i,l;
;566:
;567:	l = strlen(string) + 1;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 569
;568:
;569:	newb = G_Alloc( l );
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 G_Alloc
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 20
INDIRP4
ASGNP4
line 571
;570:
;571:	new_p = newb;
ADDRLP4 8
ADDRLP4 12
INDIRP4
ASGNP4
line 574
;572:
;573:	// turn \n into a real linefeed
;574:	for ( i=0 ; i< l ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $279
JUMPV
LABELV $276
line 575
;575:		if (string[i] == '\\' && i < l-1) {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 92
NEI4 $280
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
GEI4 $280
line 576
;576:			i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 577
;577:			if (string[i] == 'n') {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 110
NEI4 $282
line 578
;578:				*new_p++ = '\n';
ADDRLP4 28
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 28
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI1 10
ASGNI1
line 579
;579:			} else {
ADDRGP4 $281
JUMPV
LABELV $282
line 580
;580:				*new_p++ = '\\';
ADDRLP4 28
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 28
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI1 92
ASGNI1
line 581
;581:			}
line 582
;582:		} else {
ADDRGP4 $281
JUMPV
LABELV $280
line 583
;583:			*new_p++ = string[i];
ADDRLP4 28
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 28
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
ASGNI1
line 584
;584:		}
LABELV $281
line 585
;585:	}
LABELV $277
line 574
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $279
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $276
line 587
;586:
;587:	return newb;
ADDRLP4 12
INDIRP4
RETP4
LABELV $275
endproc G_NewString 32 4
export G_ParseField
proc G_ParseField 52 20
line 601
;588:}
;589:
;590:
;591:
;592:
;593:/*
;594:===============
;595:G_ParseField
;596:
;597:Takes a key/value pair and sets the binary values
;598:in a gentity
;599:===============
;600:*/
;601:void G_ParseField( const char *key, const char *value, gentity_t *ent ) {
line 607
;602:	field_t	*f;
;603:	byte	*b;
;604:	float	v;
;605:	vec3_t	vec;
;606:
;607:	for ( f=fields ; f->name ; f++ ) {
ADDRLP4 0
ADDRGP4 fields
ASGNP4
ADDRGP4 $288
JUMPV
LABELV $285
line 608
;608:		if ( !Q_stricmp(f->name, key) ) {
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $289
line 610
;609:			// found it
;610:			b = (byte *)ent;
ADDRLP4 4
ADDRFP4 8
INDIRP4
ASGNP4
line 612
;611:
;612:			switch( f->type ) {
ADDRLP4 28
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
LTI4 $284
ADDRLP4 28
INDIRI4
CNSTI4 9
GTI4 $284
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $304
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $304
address $300
address $301
address $294
address $284
address $295
address $302
address $284
address $284
address $284
address $284
code
LABELV $294
line 614
;613:			case F_LSTRING:
;614:				*(char **)(b+f->ofs) = G_NewString (value);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 G_NewString
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
ADDRLP4 36
INDIRP4
ASGNP4
line 615
;615:				break;
ADDRGP4 $284
JUMPV
LABELV $295
line 617
;616:			case F_VECTOR:
;617:				sscanf (value, "%f %f %f", &vec[0], &vec[1], &vec[2]);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $111
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 8+4
ARGP4
ADDRLP4 8+8
ARGP4
ADDRGP4 sscanf
CALLI4
pop
line 618
;618:				((float *)(b+f->ofs))[0] = vec[0];
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
line 619
;619:				((float *)(b+f->ofs))[1] = vec[1];
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
CNSTI4 4
ADDP4
ADDRLP4 8+4
INDIRF4
ASGNF4
line 620
;620:				((float *)(b+f->ofs))[2] = vec[2];
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
CNSTI4 8
ADDP4
ADDRLP4 8+8
INDIRF4
ASGNF4
line 621
;621:				break;
ADDRGP4 $284
JUMPV
LABELV $300
line 623
;622:			case F_INT:
;623:				*(int *)(b+f->ofs) = atoi(value);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
ADDRLP4 40
INDIRI4
ASGNI4
line 624
;624:				break;
ADDRGP4 $284
JUMPV
LABELV $301
line 626
;625:			case F_FLOAT:
;626:				*(float *)(b+f->ofs) = atof(value);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
ADDRLP4 44
INDIRF4
ASGNF4
line 627
;627:				break;
ADDRGP4 $284
JUMPV
LABELV $302
line 629
;628:			case F_ANGLEHACK:
;629:				v = atof(value);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 20
ADDRLP4 48
INDIRF4
ASGNF4
line 630
;630:				((float *)(b+f->ofs))[0] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
CNSTF4 0
ASGNF4
line 631
;631:				((float *)(b+f->ofs))[1] = v;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
CNSTI4 4
ADDP4
ADDRLP4 20
INDIRF4
ASGNF4
line 632
;632:				((float *)(b+f->ofs))[2] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
CNSTI4 8
ADDP4
CNSTF4 0
ASGNF4
line 633
;633:				break;
line 636
;634:			default:
;635:			case F_IGNORE:
;636:				break;
line 638
;637:			}
;638:			return;
ADDRGP4 $284
JUMPV
LABELV $289
line 640
;639:		}
;640:	}
LABELV $286
line 607
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
LABELV $288
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $285
line 641
;641:}
LABELV $284
endproc G_ParseField 52 20
data
align 4
LABELV $306
address $307
address $308
address $309
address $123
address $310
address $311
address $312
address $313
address $314
address $315
export G_SpawnGEntityFromSpawnVars
code
proc G_SpawnGEntityFromSpawnVars 80 12
line 654
;642:
;643:
;644:
;645:
;646:/*
;647:===================
;648:G_SpawnGEntityFromSpawnVars
;649:
;650:Spawn an entity and fill in all of the level fields from
;651:level.spawnVars[], then call the class specfic spawn function
;652:===================
;653:*/
;654:void G_SpawnGEntityFromSpawnVars( void ) {
line 670
;655:	int			i;
;656:	gentity_t	*ent;
;657:	char		*s, *value, *gametypeName;
;658:#if !MONSTER_MODE	// JUHOX: include new gametype names
;659:	static char *gametypeNames[] = {"ffa", "tournament", "single", "team", "ctf", "oneflag", "obelisk", "harvester", "teamtournament"};
;660:#else
;661:	static char *gametypeNames[] = {
;662:		"ffa", "tournament", "single", "team", "ctf", "oneflag", "obelisk", "harvester", "stu"
;663:#if ESCAPE_MODE
;664:		, "efh"
;665:#endif
;666:	};
;667:#endif
;668:
;669:	// get the next free entity
;670:	ent = G_Spawn();
ADDRLP4 20
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 20
INDIRP4
ASGNP4
line 672
;671:
;672:	for ( i = 0 ; i < level.numSpawnVars ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $319
JUMPV
LABELV $316
line 673
;673:		G_ParseField( level.spawnVars[i][0], level.spawnVars[i][1], ent );
ADDRLP4 24
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 level+4528
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 level+4528+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_ParseField
CALLV
pop
line 674
;674:	}
LABELV $317
line 672
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $319
ADDRLP4 0
INDIRI4
ADDRGP4 level+4524
INDIRI4
LTI4 $316
line 677
;675:
;676:#if 1	// JUHOX: introducing non-solid movers
;677:	G_SpawnInt("nonsolid", "0", &i);
ADDRGP4 $324
ARGP4
ADDRGP4 $325
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnInt
CALLI4
pop
line 678
;678:	if (i) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $326
line 679
;679:		ent->flags |= FL_NON_SOLID;
ADDRLP4 24
ADDRLP4 4
INDIRP4
CNSTI4 540
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 680
;680:	}
LABELV $326
line 684
;681:#endif
;682:
;683:	// check for "notsingle" flag
;684:	if ( g_gametype.integer == GT_SINGLE_PLAYER ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 2
NEI4 $328
line 685
;685:		G_SpawnInt( "notsingle", "0", &i );
ADDRGP4 $331
ARGP4
ADDRGP4 $325
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnInt
CALLI4
pop
line 686
;686:		if ( i ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $332
line 687
;687:			G_FreeEntity( ent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 688
;688:			return;
ADDRGP4 $305
JUMPV
LABELV $332
line 690
;689:		}
;690:	}
LABELV $328
line 692
;691:	// check for "notteam" flag (GT_FFA, GT_TOURNAMENT, GT_SINGLE_PLAYER)
;692:	if ( g_gametype.integer >= GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $334
line 693
;693:		G_SpawnInt( "notteam", "0", &i );
ADDRGP4 $337
ARGP4
ADDRGP4 $325
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnInt
CALLI4
pop
line 694
;694:		if ( i ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $335
line 695
;695:			G_FreeEntity( ent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 696
;696:			return;
ADDRGP4 $305
JUMPV
line 698
;697:		}
;698:	} else {
LABELV $334
line 699
;699:		G_SpawnInt( "notfree", "0", &i );
ADDRGP4 $340
ARGP4
ADDRGP4 $325
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnInt
CALLI4
pop
line 700
;700:		if ( i ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $341
line 701
;701:			G_FreeEntity( ent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 702
;702:			return;
ADDRGP4 $305
JUMPV
LABELV $341
line 704
;703:		}
;704:	}
LABELV $335
line 713
;705:
;706:#ifdef MISSIONPACK
;707:	G_SpawnInt( "notta", "0", &i );
;708:	if ( i ) {
;709:		G_FreeEntity( ent );
;710:		return;
;711:	}
;712:#else
;713:	G_SpawnInt( "notq3a", "0", &i );
ADDRGP4 $343
ARGP4
ADDRGP4 $325
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnInt
CALLI4
pop
line 714
;714:	if ( i ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $344
line 715
;715:		G_FreeEntity( ent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 716
;716:		return;
ADDRGP4 $305
JUMPV
LABELV $344
line 720
;717:	}
;718:#endif
;719:
;720:	if( G_SpawnString( "gametype", NULL, &value ) ) {
ADDRGP4 $348
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 24
ADDRGP4 G_SpawnString
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $346
line 721
;721:		if( g_gametype.integer >= GT_FFA && g_gametype.integer < GT_MAX_GAME_TYPE ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 0
LTI4 $349
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 10
GEI4 $349
line 722
;722:			gametypeName = gametypeNames[g_gametype.integer];
ADDRLP4 16
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $306
ADDP4
INDIRP4
ASGNP4
line 724
;723:
;724:			s = strstr( value, gametypeName );
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 28
INDIRP4
ASGNP4
line 725
;725:			if( !s ) {
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $354
line 726
;726:				G_FreeEntity( ent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 727
;727:				return;
ADDRGP4 $305
JUMPV
LABELV $354
line 729
;728:			}
;729:		}
LABELV $349
line 730
;730:	}
LABELV $346
line 733
;731:
;732:	// move editor origin to pos
;733:	VectorCopy( ent->s.origin, ent->s.pos.trBase );
ADDRLP4 4
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 734
;734:	VectorCopy( ent->s.origin, ent->r.currentOrigin );
ADDRLP4 4
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 737
;735:
;736:	// if we didn't get a classname, don't bother spawning anything
;737:	if ( !G_CallSpawn( ent ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 G_CallSpawn
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $356
line 738
;738:		G_FreeEntity( ent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 739
;739:	}
LABELV $356
line 742
;740:
;741:#if ESCAPE_MODE	// JUHOX: in EFH, add the entity to the list of templates
;742:	if (ent->inuse && g_gametype.integer == GT_EFH) {
ADDRLP4 4
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
EQI4 $358
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
NEI4 $358
line 743
;743:		if (numEntityTemplates < MAX_ENTITY_TEMPLATES) {
ADDRGP4 numEntityTemplates
INDIRI4
CNSTI4 4096
GEI4 $361
line 747
;744:			qboolean linked;
;745:			gentity_t* entTemplate;
;746:
;747:			linked = ent->r.linked;
ADDRLP4 40
ADDRLP4 4
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
ASGNI4
line 748
;748:			if (linked) {
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $363
line 751
;749:				vec3_t v;
;750:
;751:				VectorAdd(ent->r.mins, ent->r.maxs, v);
ADDRLP4 48
ADDRLP4 4
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 448
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 48+4
ADDRLP4 4
INDIRP4
CNSTI4 440
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 452
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 48+8
ADDRLP4 4
INDIRP4
CNSTI4 444
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
ADDF4
ASGNF4
line 752
;752:				VectorMA(ent->r.currentOrigin, 0.5, v, ent->sourceLocation);
ADDRLP4 4
INDIRP4
CNSTI4 828
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 48
INDIRF4
CNSTF4 1056964608
MULF4
ADDF4
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 832
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 48+4
INDIRF4
CNSTF4 1056964608
MULF4
ADDF4
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 836
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRLP4 48+8
INDIRF4
CNSTF4 1056964608
MULF4
ADDF4
ASGNF4
line 753
;753:			}
ADDRGP4 $364
JUMPV
LABELV $363
line 754
;754:			else {
line 755
;755:				VectorCopy(ent->s.origin, ent->sourceLocation);
ADDRLP4 4
INDIRP4
CNSTI4 828
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 756
;756:			}
LABELV $364
line 757
;757:			trap_UnlinkEntity(ent);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 759
;758:
;759:			entTemplate = &entityTemplates[numEntityTemplates];
ADDRLP4 44
ADDRGP4 numEntityTemplates
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 entityTemplates
ADDP4
ASGNP4
line 760
;760:			numEntityTemplates++;
ADDRLP4 48
ADDRGP4 numEntityTemplates
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 762
;761:
;762:			memcpy(entTemplate, ent, sizeof(gentity_t));
ADDRLP4 44
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 844
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 763
;763:			entTemplate->r.linked = linked;
ADDRLP4 44
INDIRP4
CNSTI4 416
ADDP4
ADDRLP4 40
INDIRI4
ASGNI4
line 764
;764:		}
LABELV $361
line 765
;765:		G_FreeEntity(ent);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 766
;766:	}
LABELV $358
line 768
;767:#endif
;768:}
LABELV $305
endproc G_SpawnGEntityFromSpawnVars 80 12
export G_AddSpawnVarToken
proc G_AddSpawnVarToken 16 12
line 778
;769:
;770:
;771:
;772:
;773:/*
;774:====================
;775:G_AddSpawnVarToken
;776:====================
;777:*/
;778:char *G_AddSpawnVarToken( const char *string ) {
line 782
;779:	int		l;
;780:	char	*dest;
;781:
;782:	l = strlen( string );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 783
;783:	if ( level.numSpawnVarChars + l + 1 > MAX_SPAWN_VARS_CHARS ) {
ADDRGP4 level+5040
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
CNSTI4 1
ADDI4
CNSTI4 4096
LEI4 $370
line 784
;784:		G_Error( "G_AddSpawnVarToken: MAX_SPAWN_CHARS" );
ADDRGP4 $373
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 785
;785:	}
LABELV $370
line 787
;786:
;787:	dest = level.spawnVarChars + level.numSpawnVarChars;
ADDRLP4 4
ADDRGP4 level+5040
INDIRI4
ADDRGP4 level+5044
ADDP4
ASGNP4
line 788
;788:	memcpy( dest, string, l+1 );
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 790
;789:
;790:	level.numSpawnVarChars += l + 1;
ADDRLP4 12
ADDRGP4 level+5040
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ADDI4
ASGNI4
line 792
;791:
;792:	return dest;
ADDRLP4 4
INDIRP4
RETP4
LABELV $369
endproc G_AddSpawnVarToken 16 12
export G_ParseSpawnVars
proc G_ParseSpawnVars 2072 8
line 805
;793:}
;794:
;795:/*
;796:====================
;797:G_ParseSpawnVars
;798:
;799:Parses a brace bounded set of key / value pairs out of the
;800:level's entity strings into level.spawnVars[]
;801:
;802:This does not actually spawn an entity.
;803:====================
;804:*/
;805:qboolean G_ParseSpawnVars( void ) {
line 809
;806:	char		keyname[MAX_TOKEN_CHARS];
;807:	char		com_token[MAX_TOKEN_CHARS];
;808:
;809:	level.numSpawnVars = 0;
ADDRGP4 level+4524
CNSTI4 0
ASGNI4
line 810
;810:	level.numSpawnVarChars = 0;
ADDRGP4 level+5040
CNSTI4 0
ASGNI4
line 813
;811:
;812:	// parse the opening brace
;813:	if ( !trap_GetEntityToken( com_token, sizeof( com_token ) ) ) {
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 2048
ADDRGP4 trap_GetEntityToken
CALLI4
ASGNI4
ADDRLP4 2048
INDIRI4
CNSTI4 0
NEI4 $380
line 815
;814:		// end of spawn string
;815:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $377
JUMPV
LABELV $380
line 817
;816:	}
;817:	if ( com_token[0] != '{' ) {
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $386
line 818
;818:		G_Error( "G_ParseSpawnVars: found %s when expecting {",com_token );
ADDRGP4 $384
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 819
;819:	}
ADDRGP4 $386
JUMPV
LABELV $385
line 822
;820:
;821:	// go through all the key / value pairs
;822:	while ( 1 ) {
line 824
;823:		// parse key
;824:		if ( !trap_GetEntityToken( keyname, sizeof( keyname ) ) ) {
ADDRLP4 1024
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 2052
ADDRGP4 trap_GetEntityToken
CALLI4
ASGNI4
ADDRLP4 2052
INDIRI4
CNSTI4 0
NEI4 $388
line 825
;825:			G_Error( "G_ParseSpawnVars: EOF without closing brace" );
ADDRGP4 $390
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 826
;826:		}
LABELV $388
line 828
;827:
;828:		if ( keyname[0] == '}' ) {
ADDRLP4 1024
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $391
line 829
;829:			break;
ADDRGP4 $387
JUMPV
LABELV $391
line 833
;830:		}
;831:
;832:		// parse value
;833:		if ( !trap_GetEntityToken( com_token, sizeof( com_token ) ) ) {
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 2056
ADDRGP4 trap_GetEntityToken
CALLI4
ASGNI4
ADDRLP4 2056
INDIRI4
CNSTI4 0
NEI4 $393
line 834
;834:			G_Error( "G_ParseSpawnVars: EOF without closing brace" );
ADDRGP4 $390
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 835
;835:		}
LABELV $393
line 837
;836:
;837:		if ( com_token[0] == '}' ) {
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $395
line 838
;838:			G_Error( "G_ParseSpawnVars: closing brace without data" );
ADDRGP4 $397
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 839
;839:		}
LABELV $395
line 840
;840:		if ( level.numSpawnVars == MAX_SPAWN_VARS ) {
ADDRGP4 level+4524
INDIRI4
CNSTI4 64
NEI4 $398
line 841
;841:			G_Error( "G_ParseSpawnVars: MAX_SPAWN_VARS" );
ADDRGP4 $401
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 842
;842:		}
LABELV $398
line 843
;843:		level.spawnVars[ level.numSpawnVars ][0] = G_AddSpawnVarToken( keyname );
ADDRLP4 1024
ARGP4
ADDRLP4 2060
ADDRGP4 G_AddSpawnVarToken
CALLP4
ASGNP4
ADDRGP4 level+4524
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 level+4528
ADDP4
ADDRLP4 2060
INDIRP4
ASGNP4
line 844
;844:		level.spawnVars[ level.numSpawnVars ][1] = G_AddSpawnVarToken( com_token );
ADDRLP4 0
ARGP4
ADDRLP4 2064
ADDRGP4 G_AddSpawnVarToken
CALLP4
ASGNP4
ADDRGP4 level+4524
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 level+4528+4
ADDP4
ADDRLP4 2064
INDIRP4
ASGNP4
line 845
;845:		level.numSpawnVars++;
ADDRLP4 2068
ADDRGP4 level+4524
ASGNP4
ADDRLP4 2068
INDIRP4
ADDRLP4 2068
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 846
;846:	}
LABELV $386
line 822
ADDRGP4 $385
JUMPV
LABELV $387
line 848
;847:
;848:	return qtrue;
CNSTI4 1
RETI4
LABELV $377
endproc G_ParseSpawnVars 2072 8
export SP_worldspawn
proc SP_worldspawn 32 12
line 860
;849:}
;850:
;851:
;852:
;853:/*QUAKED worldspawn (0 0 0) ?
;854:
;855:Every map should have exactly one worldspawn.
;856:"music"		music wav file
;857:"gravity"	800 is default gravity
;858:"message"	Text to print during connection process
;859:*/
;860:void SP_worldspawn( void ) {
line 864
;861:	char	*s;
;862:	char buf[16];	// JUHOX
;863:
;864:	G_SpawnString( "classname", "", &s );
ADDRGP4 $114
ARGP4
ADDRGP4 $409
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnString
CALLI4
pop
line 865
;865:	if ( Q_stricmp( s, "worldspawn" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $412
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $410
line 866
;866:		G_Error( "SP_worldspawn: The first entity isn't 'worldspawn'" );
ADDRGP4 $413
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 867
;867:	}
LABELV $410
line 870
;868:
;869:	// make some data visible to connecting client
;870:	trap_SetConfigstring( CS_GAME_VERSION, GAME_VERSION );
CNSTI4 20
ARGI4
ADDRGP4 $414
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 872
;871:
;872:	trap_SetConfigstring( CS_LEVEL_START_TIME, va("%i", level.startTime ) );
ADDRGP4 $415
ARGP4
ADDRGP4 level+40
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 21
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 874
;873:
;874:	G_SpawnString( "music", "", &s );
ADDRGP4 $417
ARGP4
ADDRGP4 $409
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnString
CALLI4
pop
line 875
;875:	trap_SetConfigstring( CS_MUSIC, s );
CNSTI4 2
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 877
;876:
;877:	G_SpawnString( "message", "", &s );
ADDRGP4 $122
ARGP4
ADDRGP4 $409
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnString
CALLI4
pop
line 878
;878:	trap_SetConfigstring( CS_MESSAGE, s );				// map specific message
CNSTI4 3
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 881
;879:
;880:#if 1	// JUHOX: send name of nearbox shader to clients
;881:	G_SpawnString("nearbox", "", &s);
ADDRGP4 $418
ARGP4
ADDRGP4 $409
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnString
CALLI4
pop
line 882
;882:	trap_SetConfigstring(CS_NEARBOX, s);
CNSTI4 708
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 885
;883:#endif
;884:
;885:	trap_SetConfigstring( CS_MOTD, g_motd.string );		// message of the day
CNSTI4 4
ARGI4
ADDRGP4 g_motd+16
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 887
;886:
;887:	G_SpawnString( "gravity", "800", &s );
ADDRGP4 $420
ARGP4
ADDRGP4 $421
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnString
CALLI4
pop
line 889
;888:#if 1	// JUHOX: if set, get the gravity from g_gravityLatch
;889:	trap_Cvar_VariableStringBuffer("g_gravityLatch", buf, sizeof(buf));
ADDRGP4 $422
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 890
;890:	trap_Cvar_Set("g_gravityLatch", "");
ADDRGP4 $422
ARGP4
ADDRGP4 $409
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 891
;891:	if (buf[0]) s = buf;
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $423
ADDRLP4 0
ADDRLP4 4
ASGNP4
LABELV $423
line 893
;892:#endif
;893:	trap_Cvar_Set( "g_gravity", s );
ADDRGP4 $425
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 895
;894:
;895:	G_SpawnString( "enableDust", "0", &s );
ADDRGP4 $426
ARGP4
ADDRGP4 $325
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnString
CALLI4
pop
line 896
;896:	trap_Cvar_Set( "g_enableDust", s );
ADDRGP4 $427
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 898
;897:
;898:	G_SpawnString( "enableBreath", "0", &s );
ADDRGP4 $428
ARGP4
ADDRGP4 $325
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnString
CALLI4
pop
line 899
;899:	trap_Cvar_Set( "g_enableBreath", s );
ADDRGP4 $429
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 901
;900:
;901:	g_entities[ENTITYNUM_WORLD].s.number = ENTITYNUM_WORLD;
ADDRGP4 g_entities+862568
CNSTI4 1022
ASGNI4
line 902
;902:	g_entities[ENTITYNUM_WORLD].classname = "worldspawn";
ADDRGP4 g_entities+862568+528
ADDRGP4 $412
ASGNP4
line 905
;903:
;904:	// see if we want a warmup time
;905:	trap_SetConfigstring( CS_WARMUP, "" );
CNSTI4 5
ARGI4
ADDRGP4 $409
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 906
;906:	if ( g_restarted.integer ) {
ADDRGP4 g_restarted+12
INDIRI4
CNSTI4 0
EQI4 $433
line 907
;907:		trap_Cvar_Set( "g_restarted", "0" );
ADDRGP4 $436
ARGP4
ADDRGP4 $325
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 908
;908:		level.warmupTime = 0;
ADDRGP4 level+16
CNSTI4 0
ASGNI4
line 909
;909:	} else if ( g_doWarmup.integer ) { // Turn it on
ADDRGP4 $434
JUMPV
LABELV $433
ADDRGP4 g_doWarmup+12
INDIRI4
CNSTI4 0
EQI4 $438
line 910
;910:		level.warmupTime = -1;
ADDRGP4 level+16
CNSTI4 -1
ASGNI4
line 911
;911:		trap_SetConfigstring( CS_WARMUP, va("%i", level.warmupTime) );
ADDRGP4 $415
ARGP4
ADDRGP4 level+16
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 5
ARGI4
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 912
;912:		G_LogPrintf( "Warmup:\n" );
ADDRGP4 $443
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 913
;913:	}
LABELV $438
LABELV $434
line 915
;914:
;915:}
LABELV $408
endproc SP_worldspawn 32 12
bss
align 1
LABELV $445
skip 256
code
proc SegmentName 4 28
line 924
;916:
;917:
;918:/*
;919:==============
;920:JUHOX: SegmentName
;921:==============
;922:*/
;923:#if ESCAPE_MODE
;924:static char* SegmentName(const efhSegmentType_t* segType) {
line 927
;925:	static char buf[256];
;926:
;927:	Com_sprintf(
ADDRGP4 $445
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $446
ARGP4
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 632
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 584
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 596
ADDP4
INDIRF4
ADDF4
CNSTF4 1056964608
MULF4
CVFI4 4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 588
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 600
ADDP4
INDIRF4
ADDF4
CNSTF4 1056964608
MULF4
CVFI4 4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 592
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 604
ADDP4
INDIRF4
ADDF4
CNSTF4 1056964608
MULF4
CVFI4 4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 934
;928:		buf, sizeof(buf), "'%s' @ (%d,%d,%d)",
;929:		segType->name,
;930:		(int) (0.5 * (segType->absmin[0] + segType->absmax[0])),
;931:		(int) (0.5 * (segType->absmin[1] + segType->absmax[1])),
;932:		(int) (0.5 * (segType->absmin[2] + segType->absmax[2]))
;933:	);
;934:	return buf;
ADDRGP4 $445
RETP4
LABELV $444
endproc SegmentName 4 28
proc MapOriginToWorldOrigin 0 0
line 944
;935:}
;936:#endif
;937:
;938:/*
;939:==============
;940:JUHOX: MapOriginToWorldOrigin
;941:==============
;942:*/
;943:#if ESCAPE_MODE
;944:static void MapOriginToWorldOrigin(const vec3_t mapOrigin, efhVector_t* worldOrigin) {
line 945
;945:	worldOrigin->x = (long) (level.referenceOrigin.x + mapOrigin[0]);
ADDRFP4 4
INDIRP4
ADDRGP4 level+23032
INDIRI4
CVIF4 4
ADDRFP4 0
INDIRP4
INDIRF4
ADDF4
CVFI4 4
ASGNI4
line 946
;946:	worldOrigin->y = (long) (level.referenceOrigin.y + mapOrigin[1]);
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 level+23032+4
INDIRI4
CVIF4 4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDF4
CVFI4 4
ASGNI4
line 947
;947:	worldOrigin->z = (long) (level.referenceOrigin.z + mapOrigin[2]);
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRGP4 level+23032+8
INDIRI4
CVIF4 4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CVFI4 4
ASGNI4
line 948
;948:}
LABELV $447
endproc MapOriginToWorldOrigin 0 0
proc WorldOriginToMapOrigin 0 0
line 957
;949:#endif
;950:
;951:/*
;952:==============
;953:JUHOX: WorldOriginToMapOrigin
;954:==============
;955:*/
;956:#if ESCAPE_MODE
;957:static void WorldOriginToMapOrigin(const efhVector_t* worldOrigin, vec3_t mapOrigin) {
line 958
;958:	mapOrigin[0] = worldOrigin->x - level.referenceOrigin.x;
ADDRFP4 4
INDIRP4
ADDRFP4 0
INDIRP4
INDIRI4
ADDRGP4 level+23032
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 959
;959:	mapOrigin[1] = worldOrigin->y - level.referenceOrigin.y;
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRGP4 level+23032+4
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 960
;960:	mapOrigin[2] = worldOrigin->z - level.referenceOrigin.z;
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRGP4 level+23032+8
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 961
;961:}
LABELV $453
endproc WorldOriginToMapOrigin 0 0
proc IsStyleEntryValid 0 0
line 970
;962:#endif
;963:
;964:/*
;965:==============
;966:JUHOX: IsStyleEntryValid
;967:==============
;968:*/
;969:#if ESCAPE_MODE
;970:static qboolean IsStyleEntryValid(const efhSegmentType_t* seg, const efhStyleEntry_t* styleEntry) {
line 971
;971:	if (styleEntry->frequency <= 0) return qfalse;
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 0
GTF4 $460
CNSTI4 0
RETI4
ADDRGP4 $459
JUMPV
LABELV $460
line 972
;972:	if (!styleEntry->entrance && !seg->initial) return qfalse;
ADDRFP4 4
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $462
ADDRFP4 0
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
CNSTI4 0
NEI4 $462
CNSTI4 0
RETI4
ADDRGP4 $459
JUMPV
LABELV $462
line 973
;973:	if (!styleEntry->exit && !seg->final) return qfalse;
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $464
ADDRFP4 0
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
CNSTI4 0
NEI4 $464
CNSTI4 0
RETI4
ADDRGP4 $459
JUMPV
LABELV $464
line 975
;974:
;975:	return qtrue;
CNSTI4 1
RETI4
LABELV $459
endproc IsStyleEntryValid 0 0
proc AddWaypoint 16 12
line 985
;976:}
;977:#endif
;978:
;979:/*
;980:==============
;981:JUHOX: AddWaypoint
;982:==============
;983:*/
;984:#if ESCAPE_MODE
;985:static void AddWaypoint(const gentity_t* ent, efhSegmentType_t* seg) {
line 989
;986:	int i;
;987:	int k;
;988:
;989:	if (seg->numWayPoints >= MAX_WAYPOINTS) {
ADDRFP4 4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 16
LTI4 $467
line 990
;990:		G_Error(
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 SegmentName
CALLP4
ASGNP4
ADDRGP4 $469
ARGP4
CNSTI4 16
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 994
;991:			"^1AddWaypoint: too many waypoints (>%d) for segment %s",
;992:			MAX_WAYPOINTS, SegmentName(seg)
;993:		);
;994:		return;
ADDRGP4 $466
JUMPV
LABELV $467
line 997
;995:	}
;996:
;997:	for (i = 0; i < seg->numWayPoints; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $473
JUMPV
LABELV $470
line 998
;998:		if (ent->count < seg->wayPoints[i].count) break;
ADDRFP4 0
INDIRP4
CNSTI4 764
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 264
ADDP4
ADDP4
INDIRI4
GEI4 $474
ADDRGP4 $472
JUMPV
LABELV $474
line 999
;999:		if (ent->count == seg->wayPoints[i].count) {
ADDRFP4 0
INDIRP4
CNSTI4 764
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 264
ADDP4
ADDP4
INDIRI4
NEI4 $476
line 1000
;1000:			G_Error(
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 SegmentName
CALLP4
ASGNP4
ADDRGP4 $478
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 764
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 1004
;1001:				"^1AddWaypoint: duplicate waypoint count %d in segment %s",
;1002:				ent->count, SegmentName(seg)
;1003:			);
;1004:			return;
ADDRGP4 $466
JUMPV
LABELV $476
line 1006
;1005:		}
;1006:	}
LABELV $471
line 997
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $473
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
LTI4 $470
LABELV $472
line 1008
;1007:
;1008:	for (k = seg->numWayPoints; k > i; k--) {
ADDRLP4 4
ADDRFP4 4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $482
JUMPV
LABELV $479
line 1009
;1009:		seg->wayPoints[k] = seg->wayPoints[k-1];
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 12
INDIRP4
CNSTI4 264
ADDP4
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 16
SUBI4
ADDRLP4 12
INDIRP4
CNSTI4 264
ADDP4
ADDP4
INDIRB
ASGNB 16
line 1010
;1010:	}
LABELV $480
line 1008
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $482
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
GTI4 $479
line 1011
;1011:	seg->wayPoints[i].count = ent->count;
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 264
ADDP4
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 764
ADDP4
INDIRI4
ASGNI4
line 1012
;1012:	VectorCopy(ent->s.origin, seg->wayPoints[i].origin);
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 264
ADDP4
ADDP4
CNSTI4 4
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 1013
;1013:	seg->numWayPoints++;
ADDRLP4 8
ADDRFP4 4
INDIRP4
CNSTI4 260
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1014
;1014:}
LABELV $466
endproc AddWaypoint 16 12
proc ComputeWayLength 40 16
line 1023
;1015:#endif
;1016:
;1017:/*
;1018:==============
;1019:JUHOX: ComputeWayLength
;1020:==============
;1021:*/
;1022:#if ESCAPE_MODE
;1023:static void ComputeWayLength(efhSegmentType_t* seg) {
line 1029
;1024:	int i;
;1025:	vec3_t origin;
;1026:	float dist;
;1027:	float len;
;1028:
;1029:	VectorCopy(seg->entranceOrigin, origin);
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRB
ASGNB 12
line 1030
;1030:	len = 0;
ADDRLP4 20
CNSTF4 0
ASGNF4
line 1031
;1031:	for (i = 0; i < seg->numWayPoints; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $487
JUMPV
LABELV $484
line 1032
;1032:		dist = Distance(origin, seg->wayPoints[i].origin);
ADDRLP4 8
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
ADDP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 24
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 24
INDIRF4
ASGNF4
line 1033
;1033:		if (dist < 10) {
ADDRLP4 4
INDIRF4
CNSTF4 1092616192
GEF4 $488
line 1034
;1034:			if (i > 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $490
line 1035
;1035:				G_Error(
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 SegmentName
CALLP4
ASGNP4
ADDRGP4 $492
ARGP4
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 16
SUBI4
ADDRLP4 36
INDIRP4
CNSTI4 264
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 36
INDIRP4
CNSTI4 264
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 1039
;1036:					"^1ComputeWayLength: waypoints #%d & #%d too near in segment %s",
;1037:					seg->wayPoints[i-1].count, seg->wayPoints[i].count, SegmentName(seg)
;1038:				);
;1039:			}
ADDRGP4 $491
JUMPV
LABELV $490
line 1040
;1040:			else {
line 1041
;1041:				G_Error(
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 SegmentName
CALLP4
ASGNP4
ADDRGP4 $493
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 1045
;1042:					"^1ComputeWayLength: waypoint #%d too near to entrance in segment %s",
;1043:					seg->wayPoints[i].count, SegmentName(seg)
;1044:				);
;1045:			}
LABELV $491
line 1046
;1046:		}
LABELV $488
line 1047
;1047:		len += dist;
ADDRLP4 20
ADDRLP4 20
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ASGNF4
line 1048
;1048:		VectorCopy(seg->wayPoints[i].origin, origin);
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
ADDP4
CNSTI4 4
ADDP4
INDIRB
ASGNB 12
line 1049
;1049:	}
LABELV $485
line 1031
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $487
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
LTI4 $484
line 1050
;1050:	dist = Distance(origin, seg->exitOrigin);
ADDRLP4 8
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
ARGP4
ADDRLP4 24
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 24
INDIRF4
ASGNF4
line 1051
;1051:	if (dist < 10) {
ADDRLP4 4
INDIRF4
CNSTF4 1092616192
GEF4 $494
line 1052
;1052:		if (i > 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $496
line 1053
;1053:			G_Error(
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 SegmentName
CALLP4
ASGNP4
ADDRGP4 $498
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 16
SUBI4
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 1057
;1054:				"^1ComputeWayLength: waypoint #%d too near to exit in segment %s",
;1055:				seg->wayPoints[i-1].count, SegmentName(seg)
;1056:			);
;1057:		}
ADDRGP4 $497
JUMPV
LABELV $496
line 1058
;1058:		else {
line 1059
;1059:			G_Error(
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 SegmentName
CALLP4
ASGNP4
ADDRGP4 $499
ARGP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 1063
;1060:				"^1ComputeWayLength: entrance too near to exit in segment %s",
;1061:				SegmentName(seg)
;1062:			);
;1063:		}
LABELV $497
line 1064
;1064:	}
LABELV $494
line 1065
;1065:	len += dist;
ADDRLP4 20
ADDRLP4 20
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ASGNF4
line 1067
;1066:
;1067:	seg->wayLength = (unsigned long) len;
ADDRLP4 36
CNSTF4 1325400064
ASGNF4
ADDRLP4 20
INDIRF4
ADDRLP4 36
INDIRF4
LTF4 $501
ADDRLP4 28
ADDRLP4 20
INDIRF4
ADDRLP4 36
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $502
JUMPV
LABELV $501
ADDRLP4 28
ADDRLP4 20
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $502
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
ADDRLP4 28
INDIRU4
ASGNU4
line 1068
;1068:}
LABELV $483
endproc ComputeWayLength 40 16
proc WayPoint 12 0
line 1077
;1069:#endif
;1070:
;1071:/*
;1072:==============
;1073:JUHOX: WayPoint
;1074:==============
;1075:*/
;1076:#if ESCAPE_MODE
;1077:static void WayPoint(const efhSegmentType_t* seg, int n, vec3_t org) {
line 1078
;1078:	if (n < 0) {
ADDRFP4 4
INDIRI4
CNSTI4 0
GEI4 $504
line 1079
;1079:		VectorClear(org);
ADDRLP4 0
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 4
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
ADDRLP4 4
INDIRF4
ASGNF4
line 1080
;1080:	}
ADDRGP4 $505
JUMPV
LABELV $504
line 1081
;1081:	else if (n < seg->numWayPoints) {
ADDRFP4 4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
GEI4 $506
line 1082
;1082:		VectorSubtract(seg->wayPoints[n].origin, seg->entranceOrigin, org);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 8
INDIRP4
ADDRFP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 264
ADDP4
ADDP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 264
ADDP4
ADDP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 532
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
ADDRFP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 264
ADDP4
ADDP4
CNSTI4 12
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 536
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1083
;1083:	}
ADDRGP4 $507
JUMPV
LABELV $506
line 1084
;1084:	else {
line 1085
;1085:		VectorSubtract(seg->exitOrigin, seg->entranceOrigin, org);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 8
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 548
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 532
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 552
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 536
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1086
;1086:	}
LABELV $507
LABELV $505
line 1087
;1087:}
LABELV $503
endproc WayPoint 12 0
proc SegmentWayLength 312 12
line 1098
;1088:#endif
;1089:
;1090:/*
;1091:==============
;1092:JUHOX: SegmentWayLength
;1093:==============
;1094:*/
;1095:#if ESCAPE_MODE
;1096:static unsigned long SegmentWayLength(
;1097:	const vec3_t origin, const efhSegmentType_t* seg, const efhVector_t* segOrg
;1098:) {
line 1111
;1099:	vec3_t entrance;
;1100:	vec3_t wayPoints[MAX_WAYPOINTS+2];
;1101:	int numWayPoints;
;1102:	int i;
;1103:	float smallestDistance;
;1104:	int nearestWaypoint;
;1105:	int nextWaypoint;
;1106:	int a, b;
;1107:	float wayLength;
;1108:	vec3_t wayDir;
;1109:	vec3_t pointDir;
;1110:
;1111:	if (segOrg) {
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $509
line 1112
;1112:		WorldOriginToMapOrigin(segOrg, entrance);
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 220
ARGP4
ADDRGP4 WorldOriginToMapOrigin
CALLV
pop
line 1113
;1113:	}
ADDRGP4 $510
JUMPV
LABELV $509
line 1114
;1114:	else {
line 1115
;1115:		VectorCopy(seg->entranceOrigin, entrance);
ADDRLP4 220
ADDRFP4 4
INDIRP4
CNSTI4 528
ADDP4
INDIRB
ASGNB 12
line 1116
;1116:	}
LABELV $510
line 1118
;1117:
;1118:	for (i = -1; i <= seg->numWayPoints; i++) {
ADDRLP4 0
CNSTI4 -1
ASGNI4
ADDRGP4 $514
JUMPV
LABELV $511
line 1119
;1119:		WayPoint(seg, i, wayPoints[i + 1]);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4+12
ADDP4
ARGP4
ADDRGP4 WayPoint
CALLV
pop
line 1120
;1120:		VectorAdd(wayPoints[i + 1], entrance, wayPoints[i + 1]);
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4+12
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4+12
ADDP4
INDIRF4
ADDRLP4 220
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4+12+4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4+12+4
ADDP4
INDIRF4
ADDRLP4 220+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4+12+8
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4+12+8
ADDP4
INDIRF4
ADDRLP4 220+8
INDIRF4
ADDF4
ASGNF4
line 1121
;1121:	}
LABELV $512
line 1118
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $514
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
LEI4 $511
line 1122
;1122:	numWayPoints = seg->numWayPoints + 2;
ADDRLP4 244
ADDRFP4 4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 1124
;1123:
;1124:	nearestWaypoint = -1;
ADDRLP4 248
CNSTI4 -1
ASGNI4
line 1125
;1125:	smallestDistance = 1000000.0;
ADDRLP4 236
CNSTF4 1232348160
ASGNF4
line 1126
;1126:	for (i = 0; i < numWayPoints; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $531
JUMPV
LABELV $528
line 1129
;1127:		float distance;
;1128:
;1129:		distance = Distance(origin, wayPoints[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4
ADDP4
ARGP4
ADDRLP4 288
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRLP4 284
ADDRLP4 288
INDIRF4
ASGNF4
line 1130
;1130:		if (distance < smallestDistance) {
ADDRLP4 284
INDIRF4
ADDRLP4 236
INDIRF4
GEF4 $532
line 1131
;1131:			smallestDistance = distance;
ADDRLP4 236
ADDRLP4 284
INDIRF4
ASGNF4
line 1132
;1132:			nearestWaypoint = i;
ADDRLP4 248
ADDRLP4 0
INDIRI4
ASGNI4
line 1133
;1133:		}
LABELV $532
line 1134
;1134:	}
LABELV $529
line 1126
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $531
ADDRLP4 0
INDIRI4
ADDRLP4 244
INDIRI4
LTI4 $528
line 1135
;1135:	if (nearestWaypoint < 0) return 0;	// should not happen
ADDRLP4 248
INDIRI4
CNSTI4 0
GEI4 $534
CNSTU4 0
RETU4
ADDRGP4 $508
JUMPV
LABELV $534
line 1136
;1136:	if (nearestWaypoint == 0) {
ADDRLP4 248
INDIRI4
CNSTI4 0
NEI4 $536
line 1137
;1137:		nextWaypoint = 1;
ADDRLP4 280
CNSTI4 1
ASGNI4
line 1138
;1138:	}
ADDRGP4 $537
JUMPV
LABELV $536
line 1139
;1139:	else if (nearestWaypoint >= numWayPoints - 1) {
ADDRLP4 248
INDIRI4
ADDRLP4 244
INDIRI4
CNSTI4 1
SUBI4
LTI4 $538
line 1140
;1140:		nextWaypoint = numWayPoints - 2;
ADDRLP4 280
ADDRLP4 244
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 1141
;1141:	}
ADDRGP4 $539
JUMPV
LABELV $538
line 1142
;1142:	else {
line 1144
;1143:		if (
;1144:			Distance(origin, wayPoints[nearestWaypoint - 1]) <
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 248
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4-12
ADDP4
ARGP4
ADDRLP4 284
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 248
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4+12
ADDP4
ARGP4
ADDRLP4 288
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRLP4 284
INDIRF4
ADDRLP4 288
INDIRF4
GEF4 $540
line 1146
;1145:			Distance(origin, wayPoints[nearestWaypoint + 1])
;1146:		) {
line 1147
;1147:			nextWaypoint = nearestWaypoint - 1;
ADDRLP4 280
ADDRLP4 248
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1148
;1148:		}
ADDRGP4 $541
JUMPV
LABELV $540
line 1149
;1149:		else {
line 1150
;1150:			nextWaypoint = nearestWaypoint + 1;
ADDRLP4 280
ADDRLP4 248
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1151
;1151:		}
LABELV $541
line 1152
;1152:	}
LABELV $539
LABELV $537
line 1154
;1153:
;1154:	if (nearestWaypoint < nextWaypoint) {
ADDRLP4 248
INDIRI4
ADDRLP4 280
INDIRI4
GEI4 $544
line 1155
;1155:		a = nearestWaypoint;
ADDRLP4 232
ADDRLP4 248
INDIRI4
ASGNI4
line 1156
;1156:		b = nextWaypoint;
ADDRLP4 276
ADDRLP4 280
INDIRI4
ASGNI4
line 1157
;1157:	}
ADDRGP4 $545
JUMPV
LABELV $544
line 1158
;1158:	else {
line 1159
;1159:		a = nextWaypoint;
ADDRLP4 232
ADDRLP4 280
INDIRI4
ASGNI4
line 1160
;1160:		b = nearestWaypoint;
ADDRLP4 276
ADDRLP4 248
INDIRI4
ASGNI4
line 1161
;1161:	}
LABELV $545
line 1163
;1162:
;1163:	wayLength = 0;
ADDRLP4 240
CNSTF4 0
ASGNF4
line 1164
;1164:	for (i = 0; i < a; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $549
JUMPV
LABELV $546
line 1165
;1165:		wayLength += Distance(wayPoints[i], wayPoints[i+1]);
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4
ADDP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4+12
ADDP4
ARGP4
ADDRLP4 288
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRLP4 240
ADDRLP4 240
INDIRF4
ADDRLP4 288
INDIRF4
ADDF4
ASGNF4
line 1166
;1166:	}
LABELV $547
line 1164
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $549
ADDRLP4 0
INDIRI4
ADDRLP4 232
INDIRI4
LTI4 $546
line 1168
;1167:
;1168:	VectorSubtract(wayPoints[b], wayPoints[a], wayDir);
ADDRLP4 252
ADDRLP4 276
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4
ADDP4
INDIRF4
ADDRLP4 232
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 252+4
ADDRLP4 276
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4+4
ADDP4
INDIRF4
ADDRLP4 232
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4+4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 252+8
ADDRLP4 276
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4+8
ADDP4
INDIRF4
ADDRLP4 232
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4+8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1169
;1169:	VectorNormalize(wayDir);
ADDRLP4 252
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 1170
;1170:	VectorSubtract(origin, wayPoints[a], pointDir);
ADDRLP4 292
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 264
ADDRLP4 292
INDIRP4
INDIRF4
ADDRLP4 232
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 264+4
ADDRLP4 292
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 232
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4+4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 264+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 232
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4+8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1171
;1171:	wayLength += DotProduct(wayDir, pointDir);
ADDRLP4 240
ADDRLP4 240
INDIRF4
ADDRLP4 252
INDIRF4
ADDRLP4 264
INDIRF4
MULF4
ADDRLP4 252+4
INDIRF4
ADDRLP4 264+4
INDIRF4
MULF4
ADDF4
ADDRLP4 252+8
INDIRF4
ADDRLP4 264+8
INDIRF4
MULF4
ADDF4
ADDF4
ASGNF4
line 1173
;1172:
;1173:	if (wayLength < 0) wayLength = 0;
ADDRLP4 240
INDIRF4
CNSTF4 0
GEF4 $565
ADDRLP4 240
CNSTF4 0
ASGNF4
LABELV $565
line 1175
;1174:
;1175:	return (unsigned long) wayLength;
ADDRLP4 308
CNSTF4 1325400064
ASGNF4
ADDRLP4 240
INDIRF4
ADDRLP4 308
INDIRF4
LTF4 $568
ADDRLP4 300
ADDRLP4 240
INDIRF4
ADDRLP4 308
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $569
JUMPV
LABELV $568
ADDRLP4 300
ADDRLP4 240
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $569
ADDRLP4 300
INDIRU4
RETU4
LABELV $508
endproc SegmentWayLength 312 12
proc CheckForDeadStyles 216 12
line 1185
;1176:}
;1177:#endif
;1178:
;1179:/*
;1180:==============
;1181:JUHOX: CheckForDeadStyles
;1182:==============
;1183:*/
;1184:#if ESCAPE_MODE
;1185:static void CheckForDeadStyles(void) {
line 1190
;1186:	char styleUsedAsEntrance[MAX_STYLES];
;1187:	char styleUsedAsExit[MAX_STYLES];
;1188:	int i;
;1189:
;1190:	G_Printf("CheckForDeadStyles...\n");
ADDRGP4 $571
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 1192
;1191:
;1192:	memset(&styleUsedAsEntrance, 0, sizeof(styleUsedAsEntrance));
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 100
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1193
;1193:	memset(&styleUsedAsExit, 0, sizeof(styleUsedAsExit));
ADDRLP4 104
ARGP4
CNSTI4 0
ARGI4
CNSTI4 100
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1195
;1194:
;1195:	for (i = 0; i < numSegmentTypes; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $575
JUMPV
LABELV $572
line 1199
;1196:		const efhSegmentType_t* segType;
;1197:		int styleEntryNum;
;1198:
;1199:		segType = &segmentTypes[i];
ADDRLP4 208
ADDRLP4 0
INDIRI4
CNSTI4 764
MULI4
ADDRGP4 segmentTypes
ADDP4
ASGNP4
line 1200
;1200:		for (styleEntryNum = 0; styleEntryNum < MAX_PARALLEL_STYLES; styleEntryNum++) {
ADDRLP4 204
CNSTI4 0
ASGNI4
LABELV $576
line 1203
;1201:			const efhStyleEntry_t* styleEntry;
;1202:
;1203:			styleEntry = &segType->styles[styleEntryNum];
ADDRLP4 212
ADDRLP4 204
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 208
INDIRP4
CNSTI4 640
ADDP4
ADDP4
ASGNP4
line 1206
;1204:			//if (!IsStyleEntryValid(segType, styleEntry)) continue;
;1205:
;1206:			if (styleEntry->entrance) {
ADDRLP4 212
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $580
line 1207
;1207:				styleUsedAsEntrance[styleEntry->entrance - transitionStyles] = qtrue;
ADDRLP4 212
INDIRP4
INDIRP4
CVPU4 4
ADDRGP4 transitionStyles
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 44
DIVI4
ADDRLP4 4
ADDP4
CNSTI1 1
ASGNI1
line 1208
;1208:			}
LABELV $580
line 1209
;1209:			if (styleEntry->exit) {
ADDRLP4 212
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $582
line 1210
;1210:				styleUsedAsExit[styleEntry->exit - transitionStyles] = qtrue;
ADDRLP4 212
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 transitionStyles
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 44
DIVI4
ADDRLP4 104
ADDP4
CNSTI1 1
ASGNI1
line 1211
;1211:			}
LABELV $582
line 1212
;1212:		}
LABELV $577
line 1200
ADDRLP4 204
ADDRLP4 204
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 204
INDIRI4
CNSTI4 10
LTI4 $576
line 1213
;1213:	}
LABELV $573
line 1195
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $575
ADDRLP4 0
INDIRI4
ADDRGP4 numSegmentTypes
INDIRI4
LTI4 $572
line 1215
;1214:
;1215:	for (i = 0; i < numTransitionStyles; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $587
JUMPV
LABELV $584
line 1218
;1216:		const efhTransitionStyle_t* style;
;1217:
;1218:		style = &transitionStyles[i];
ADDRLP4 204
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 transitionStyles
ADDP4
ASGNP4
line 1220
;1219:
;1220:		if (!styleUsedAsEntrance[i]) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $588
line 1221
;1221:			G_Error("^1CheckForDeadStyles: Style '%s' doesn't appear in any style_in key.", style->name);
ADDRGP4 $590
ARGP4
ADDRLP4 204
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 1222
;1222:		}
LABELV $588
line 1223
;1223:		if (!styleUsedAsExit[i]) {
ADDRLP4 0
INDIRI4
ADDRLP4 104
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $591
line 1224
;1224:			G_Error("^1CheckForDeadStyles: Style '%s' doesn't appear in any style_out key.", style->name);
ADDRGP4 $593
ARGP4
ADDRLP4 204
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 1225
;1225:		}
LABELV $591
line 1226
;1226:	}
LABELV $585
line 1215
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $587
ADDRLP4 0
INDIRI4
ADDRGP4 numTransitionStyles
INDIRI4
LTI4 $584
line 1227
;1227:}
LABELV $570
endproc CheckForDeadStyles 216 12
proc CheckForUnterminatedStyles 32 8
line 1236
;1228:#endif
;1229:
;1230:/*
;1231:==============
;1232:JUHOX: CheckForUnterminatedStyles
;1233:==============
;1234:*/
;1235:#if ESCAPE_MODE
;1236:static void CheckForUnterminatedStyles(void) {
line 1242
;1237:	int numRemainingStyles;
;1238:	int segnum;
;1239:	int styleEntryNum;
;1240:	int styleNum;
;1241:
;1242:	G_Printf("CheckForUnterminatedStyles...\n");
ADDRGP4 $595
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 1244
;1243:
;1244:	for (styleNum = 0; styleNum < numTransitionStyles; styleNum++) {
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 $599
JUMPV
LABELV $596
line 1245
;1245:		transitionStyles[styleNum].minStepsToFinalSegment = -1;
ADDRLP4 12
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 transitionStyles
ADDP4
CNSTI4 -1
ASGNI4
line 1246
;1246:	}
LABELV $597
line 1244
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $599
ADDRLP4 12
INDIRI4
ADDRGP4 numTransitionStyles
INDIRI4
LTI4 $596
line 1247
;1247:	numRemainingStyles = numTransitionStyles;
ADDRLP4 8
ADDRGP4 numTransitionStyles
INDIRI4
ASGNI4
line 1249
;1248:
;1249:	for (segnum = 0; segnum < numSegmentTypes; segnum++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $603
JUMPV
LABELV $600
line 1252
;1250:		const efhSegmentType_t* segType;
;1251:
;1252:		segType = &segmentTypes[segnum];
ADDRLP4 16
ADDRLP4 4
INDIRI4
CNSTI4 764
MULI4
ADDRGP4 segmentTypes
ADDP4
ASGNP4
line 1253
;1253:		if (!segType->final) continue;
ADDRLP4 16
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
CNSTI4 0
NEI4 $604
ADDRGP4 $601
JUMPV
LABELV $604
line 1255
;1254:
;1255:		for (styleEntryNum = 0; styleEntryNum < MAX_PARALLEL_STYLES; styleEntryNum++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $606
line 1258
;1256:			const efhStyleEntry_t* styleEntry;
;1257:
;1258:			styleEntry = &segType->styles[styleEntryNum];
ADDRLP4 20
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 16
INDIRP4
CNSTI4 640
ADDP4
ADDP4
ASGNP4
line 1259
;1259:			if (!styleEntry->entrance) continue;
ADDRLP4 20
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $610
ADDRGP4 $607
JUMPV
LABELV $610
line 1261
;1260:
;1261:			if (styleEntry->entrance->minStepsToFinalSegment >= 0) continue;
ADDRLP4 20
INDIRP4
INDIRP4
INDIRI4
CNSTI4 0
LTI4 $612
ADDRGP4 $607
JUMPV
LABELV $612
line 1263
;1262:
;1263:			styleEntry->entrance->minStepsToFinalSegment = 0;
ADDRLP4 20
INDIRP4
INDIRP4
CNSTI4 0
ASGNI4
line 1264
;1264:			numRemainingStyles--;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1265
;1265:		}
LABELV $607
line 1255
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 10
LTI4 $606
line 1266
;1266:	}
LABELV $601
line 1249
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $603
ADDRLP4 4
INDIRI4
ADDRGP4 numSegmentTypes
INDIRI4
LTI4 $600
ADDRGP4 $615
JUMPV
LABELV $614
line 1268
;1267:
;1268:	while (numRemainingStyles > 0) {
line 1271
;1269:		int numProcessedStyles;
;1270:
;1271:		numProcessedStyles = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 1272
;1272:		for (segnum = 0; segnum < numSegmentTypes; segnum++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $620
JUMPV
LABELV $617
line 1275
;1273:			const efhSegmentType_t* segType;
;1274:
;1275:			segType = &segmentTypes[segnum];
ADDRLP4 20
ADDRLP4 4
INDIRI4
CNSTI4 764
MULI4
ADDRGP4 segmentTypes
ADDP4
ASGNP4
line 1276
;1276:			if (segType->final) continue;
ADDRLP4 20
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
CNSTI4 0
EQI4 $621
ADDRGP4 $618
JUMPV
LABELV $621
line 1278
;1277:
;1278:			for (styleEntryNum = 0; styleEntryNum < MAX_PARALLEL_STYLES; styleEntryNum++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $623
line 1281
;1279:				const efhStyleEntry_t* styleEntry;
;1280:
;1281:				styleEntry = &segType->styles[styleEntryNum];
ADDRLP4 24
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 20
INDIRP4
CNSTI4 640
ADDP4
ADDP4
ASGNP4
line 1282
;1282:				if (!styleEntry->entrance) continue;
ADDRLP4 24
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $627
ADDRGP4 $624
JUMPV
LABELV $627
line 1283
;1283:				if (!styleEntry->exit) continue;
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $629
ADDRGP4 $624
JUMPV
LABELV $629
line 1285
;1284:
;1285:				if (styleEntry->exit->minStepsToFinalSegment < 0) continue;
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
GEI4 $631
ADDRGP4 $624
JUMPV
LABELV $631
line 1286
;1286:				if (styleEntry->entrance->minStepsToFinalSegment >= 0) continue;
ADDRLP4 24
INDIRP4
INDIRP4
INDIRI4
CNSTI4 0
LTI4 $633
ADDRGP4 $624
JUMPV
LABELV $633
line 1288
;1287:
;1288:				styleEntry->entrance->minStepsToFinalSegment = styleEntry->exit->minStepsToFinalSegment + 1;
ADDRLP4 24
INDIRP4
INDIRP4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1289
;1289:				numProcessedStyles++;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1290
;1290:			}
LABELV $624
line 1278
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 10
LTI4 $623
line 1291
;1291:		}
LABELV $618
line 1272
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $620
ADDRLP4 4
INDIRI4
ADDRGP4 numSegmentTypes
INDIRI4
LTI4 $617
line 1293
;1292:
;1293:		if (!numProcessedStyles) break;
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $635
ADDRGP4 $616
JUMPV
LABELV $635
line 1295
;1294:
;1295:		numRemainingStyles -= numProcessedStyles;
ADDRLP4 8
ADDRLP4 8
INDIRI4
ADDRLP4 16
INDIRI4
SUBI4
ASGNI4
line 1296
;1296:	}
LABELV $615
line 1268
ADDRLP4 8
INDIRI4
CNSTI4 0
GTI4 $614
LABELV $616
line 1298
;1297:
;1298:	if (numRemainingStyles > 0) {
ADDRLP4 8
INDIRI4
CNSTI4 0
LEI4 $637
line 1299
;1299:		G_Printf("^1ERROR: CheckForUnterminatedStyles: The following styles can't reach a final segment.\n");
ADDRGP4 $639
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 1301
;1300:
;1301:		for (styleNum = 0; styleNum < numTransitionStyles; styleNum++) {
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 $643
JUMPV
LABELV $640
line 1304
;1302:			const efhTransitionStyle_t* style;
;1303:
;1304:			style = &transitionStyles[styleNum];
ADDRLP4 16
ADDRLP4 12
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 transitionStyles
ADDP4
ASGNP4
line 1305
;1305:			if (style->minStepsToFinalSegment >= 0) continue;
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 0
LTI4 $644
ADDRGP4 $641
JUMPV
LABELV $644
line 1307
;1306:
;1307:			G_Printf("  %s\n", style->name);
ADDRGP4 $646
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 1308
;1308:		}
LABELV $641
line 1301
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $643
ADDRLP4 12
INDIRI4
ADDRGP4 numTransitionStyles
INDIRI4
LTI4 $640
line 1309
;1309:		G_Error("(see above)");
ADDRGP4 $647
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 1310
;1310:	}
LABELV $637
line 1311
;1311:}
LABELV $594
endproc CheckForUnterminatedStyles 32 8
proc ReachStyle 8 8
line 1322
;1312:#endif
;1313:
;1314:/*
;1315:==============
;1316:JUHOX: ReachStyle
;1317:==============
;1318:*/
;1319:#if ESCAPE_MODE
;1320:static void ReachSegment(efhTransitionStyle_t* style, const efhSegmentType_t* segType);
;1321:
;1322:static void ReachStyle(efhTransitionStyle_t* style) {
line 1325
;1323:	int segTypeNum;
;1324:
;1325:	if (!style) return;
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $649
ADDRGP4 $648
JUMPV
LABELV $649
line 1327
;1326:
;1327:	if (style->visited) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $651
line 1328
;1328:		if (style->reachability < REACH_loopable) style->reachability = REACH_loopable;
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 2
GEI4 $648
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 2
ASGNI4
line 1329
;1329:		return;
ADDRGP4 $648
JUMPV
LABELV $651
line 1332
;1330:	}
;1331:
;1332:	if (style->reachability < REACH_reachable) style->reachability = REACH_reachable;
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
GEI4 $655
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 1
ASGNI4
LABELV $655
line 1334
;1333:
;1334:	style->visited = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 1
ASGNI4
line 1335
;1335:	for (segTypeNum = 0; segTypeNum < numSegmentTypes; segTypeNum++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $660
JUMPV
LABELV $657
line 1338
;1336:		const efhSegmentType_t* segType;
;1337:
;1338:		segType = &segmentTypes[segTypeNum];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 764
MULI4
ADDRGP4 segmentTypes
ADDP4
ASGNP4
line 1339
;1339:		ReachSegment(style, segType);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 ReachSegment
CALLV
pop
line 1340
;1340:	}
LABELV $658
line 1335
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $660
ADDRLP4 0
INDIRI4
ADDRGP4 numSegmentTypes
INDIRI4
LTI4 $657
line 1341
;1341:	style->visited = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 0
ASGNI4
line 1342
;1342:}
LABELV $648
endproc ReachStyle 8 8
proc ReachSegment 12 8
line 1351
;1343:#endif
;1344:
;1345:/*
;1346:==============
;1347:JUHOX: ReachSegment
;1348:==============
;1349:*/
;1350:#if ESCAPE_MODE
;1351:static void ReachSegment(efhTransitionStyle_t* style, const efhSegmentType_t* segType) {
line 1354
;1352:	int styleEntryNum;
;1353:
;1354:	for (styleEntryNum = 0; styleEntryNum < MAX_PARALLEL_STYLES; styleEntryNum++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $662
line 1357
;1355:		const efhStyleEntry_t* styleEntry;
;1356:
;1357:		styleEntry = &segType->styles[styleEntryNum];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRFP4 4
INDIRP4
CNSTI4 640
ADDP4
ADDP4
ASGNP4
line 1358
;1358:		if (!IsStyleEntryValid(segType, styleEntry)) continue;
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 IsStyleEntryValid
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $666
ADDRGP4 $663
JUMPV
LABELV $666
line 1359
;1359:		if (styleEntry->entrance != style) continue;
ADDRLP4 4
INDIRP4
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
EQU4 $668
ADDRGP4 $663
JUMPV
LABELV $668
line 1360
;1360:		if (!styleEntry->exit) continue;
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $670
ADDRGP4 $663
JUMPV
LABELV $670
line 1362
;1361:
;1362:		ReachStyle(styleEntry->exit);
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRGP4 ReachStyle
CALLV
pop
line 1363
;1363:		if (style && styleEntry->exit->reachability == REACH_loopable) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $672
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 2
NEI4 $672
line 1364
;1364:			style->reachability = REACH_loopable;
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 2
ASGNI4
line 1365
;1365:		}
LABELV $672
line 1366
;1366:	}
LABELV $663
line 1354
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 10
LTI4 $662
line 1367
;1367:}
LABELV $661
endproc ReachSegment 12 8
proc CheckReachabilityAndLoops 16 12
line 1376
;1368:#endif
;1369:
;1370:/*
;1371:==============
;1372:JUHOX: CheckReachabilityAndLoops
;1373:==============
;1374:*/
;1375:#if ESCAPE_MODE
;1376:static void CheckReachabilityAndLoops(void) {
line 1381
;1377:	int segNum;
;1378:	int styleNum;
;1379:	int numLoopableStyles;
;1380:
;1381:	G_Printf("CheckReachabilityAndLoops...\n");
ADDRGP4 $675
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 1383
;1382:
;1383:	for (segNum = 0; segNum < numSegmentTypes; segNum++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $679
JUMPV
LABELV $676
line 1386
;1384:		const efhSegmentType_t* segType;
;1385:
;1386:		segType = &segmentTypes[segNum];
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 764
MULI4
ADDRGP4 segmentTypes
ADDP4
ASGNP4
line 1387
;1387:		if (!segType->initial) continue;
ADDRLP4 12
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
CNSTI4 0
NEI4 $680
ADDRGP4 $677
JUMPV
LABELV $680
line 1389
;1388:
;1389:		ReachSegment(NULL, segType);
CNSTP4 0
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 ReachSegment
CALLV
pop
line 1390
;1390:	}
LABELV $677
line 1383
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $679
ADDRLP4 0
INDIRI4
ADDRGP4 numSegmentTypes
INDIRI4
LTI4 $676
line 1392
;1391:
;1392:	numLoopableStyles = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 1393
;1393:	for (styleNum = 0; styleNum < numTransitionStyles; styleNum++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $685
JUMPV
LABELV $682
line 1396
;1394:		const efhTransitionStyle_t* style;
;1395:
;1396:		style = &transitionStyles[styleNum];
ADDRLP4 12
ADDRLP4 4
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 transitionStyles
ADDP4
ASGNP4
line 1397
;1397:		if (style->reachability >= REACH_loopable) {
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 2
LTI4 $686
line 1398
;1398:			numLoopableStyles++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1399
;1399:		}
LABELV $686
line 1400
;1400:		if (style->reachability) continue;
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 0
EQI4 $688
ADDRGP4 $683
JUMPV
LABELV $688
line 1402
;1401:
;1402:		G_Error("CheckReachabilityAndLoops: Style '%s' not reachable.", style->name);
ADDRGP4 $690
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 1403
;1403:	}
LABELV $683
line 1393
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $685
ADDRLP4 4
INDIRI4
ADDRGP4 numTransitionStyles
INDIRI4
LTI4 $682
line 1405
;1404:
;1405:	if (numLoopableStyles <= 0) {
ADDRLP4 8
INDIRI4
CNSTI4 0
GTI4 $691
line 1406
;1406:		G_Error("CheckReachabilityAndLoops: No loopable styles available.\n");
ADDRGP4 $693
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 1407
;1407:	}
LABELV $691
line 1408
;1408:	G_Printf("%d/%d styles are loopable.\n", numLoopableStyles, numTransitionStyles);
ADDRGP4 $694
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 numTransitionStyles
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 1409
;1409:}
LABELV $674
endproc CheckReachabilityAndLoops 16 12
proc BuildSegments 68 12
line 1418
;1410:#endif
;1411:
;1412:/*
;1413:==============
;1414:JUHOX: BuildSegments
;1415:==============
;1416:*/
;1417:#if ESCAPE_MODE
;1418:static void BuildSegments(void) {
line 1422
;1419:	int t;
;1420:	int s;
;1421:
;1422:	if (g_gametype.integer != GT_EFH) return;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
EQI4 $696
ADDRGP4 $695
JUMPV
LABELV $696
line 1424
;1423:
;1424:	G_Printf("BuildSegments...\n");
ADDRGP4 $699
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 1426
;1425:
;1426:	if (numSegmentTypes <= 0) {
ADDRGP4 numSegmentTypes
INDIRI4
CNSTI4 0
GTI4 $700
line 1427
;1427:		G_Error("^1BuildSegments: no segments found");
ADDRGP4 $702
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 1428
;1428:		return;
ADDRGP4 $695
JUMPV
LABELV $700
line 1431
;1429:	}
;1430:
;1431:	for (t = 0; t < numEntityTemplates; t++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $706
JUMPV
LABELV $703
line 1434
;1432:		const gentity_t* ent;
;1433:
;1434:		ent = &entityTemplates[t];
ADDRLP4 8
ADDRLP4 4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 entityTemplates
ADDP4
ASGNP4
line 1435
;1435:		for (s = 0; s < numSegmentTypes; s++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $710
JUMPV
LABELV $707
line 1438
;1436:			efhSegmentType_t* seg;
;1437:
;1438:			seg = &segmentTypes[s];
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 764
MULI4
ADDRGP4 segmentTypes
ADDP4
ASGNP4
line 1439
;1439:			if (ent->sourceLocation[0] < seg->absmin[0]) continue;
ADDRLP4 8
INDIRP4
CNSTI4 828
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 584
ADDP4
INDIRF4
GEF4 $711
ADDRGP4 $708
JUMPV
LABELV $711
line 1440
;1440:			if (ent->sourceLocation[0] > seg->absmax[0]) continue;
ADDRLP4 8
INDIRP4
CNSTI4 828
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 596
ADDP4
INDIRF4
LEF4 $713
ADDRGP4 $708
JUMPV
LABELV $713
line 1441
;1441:			if (ent->sourceLocation[1] < seg->absmin[1]) continue;
ADDRLP4 8
INDIRP4
CNSTI4 832
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 588
ADDP4
INDIRF4
GEF4 $715
ADDRGP4 $708
JUMPV
LABELV $715
line 1442
;1442:			if (ent->sourceLocation[1] > seg->absmax[1]) continue;
ADDRLP4 8
INDIRP4
CNSTI4 832
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 600
ADDP4
INDIRF4
LEF4 $717
ADDRGP4 $708
JUMPV
LABELV $717
line 1443
;1443:			if (ent->sourceLocation[2] < seg->absmin[2]) continue;
ADDRLP4 8
INDIRP4
CNSTI4 836
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 592
ADDP4
INDIRF4
GEF4 $719
ADDRGP4 $708
JUMPV
LABELV $719
line 1444
;1444:			if (ent->sourceLocation[2] > seg->absmax[2]) continue;
ADDRLP4 8
INDIRP4
CNSTI4 836
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 604
ADDP4
INDIRF4
LEF4 $721
ADDRGP4 $708
JUMPV
LABELV $721
line 1445
;1445:			if (ent->idnum != seg->idnum) continue;
ADDRLP4 8
INDIRP4
CNSTI4 840
ADDP4
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 636
ADDP4
INDIRI4
EQI4 $723
ADDRGP4 $708
JUMPV
LABELV $723
line 1447
;1446:
;1447:			if (ent->s.eType == ET_MOVER && ent->r.linked && ent->s.solid) {
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 4
NEI4 $725
ADDRLP4 8
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
CNSTI4 0
EQI4 $725
ADDRLP4 8
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 0
EQI4 $725
line 1449
;1448:			//if (ent->entClass == GEC_efh_brush) {
;1449:				if (ent->r.absmin[0] < seg->boundingMin[0]) {
ADDRLP4 8
INDIRP4
CNSTI4 464
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 608
ADDP4
INDIRF4
GEF4 $727
line 1450
;1450:					seg->boundingMin[0] = ent->r.absmin[0];
ADDRLP4 12
INDIRP4
CNSTI4 608
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 464
ADDP4
INDIRF4
ASGNF4
line 1451
;1451:				}
LABELV $727
line 1452
;1452:				if (ent->r.absmax[0] > seg->boundingMax[0]) {
ADDRLP4 8
INDIRP4
CNSTI4 476
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 620
ADDP4
INDIRF4
LEF4 $729
line 1453
;1453:					seg->boundingMax[0] = ent->r.absmax[0];
ADDRLP4 12
INDIRP4
CNSTI4 620
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 476
ADDP4
INDIRF4
ASGNF4
line 1454
;1454:				}
LABELV $729
line 1455
;1455:				if (ent->r.absmin[1] < seg->boundingMin[1]) {
ADDRLP4 8
INDIRP4
CNSTI4 468
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 612
ADDP4
INDIRF4
GEF4 $731
line 1456
;1456:					seg->boundingMin[1] = ent->r.absmin[1];
ADDRLP4 12
INDIRP4
CNSTI4 612
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 468
ADDP4
INDIRF4
ASGNF4
line 1457
;1457:				}
LABELV $731
line 1458
;1458:				if (ent->r.absmax[1] > seg->boundingMax[1]) {
ADDRLP4 8
INDIRP4
CNSTI4 480
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 624
ADDP4
INDIRF4
LEF4 $733
line 1459
;1459:					seg->boundingMax[1] = ent->r.absmax[1];
ADDRLP4 12
INDIRP4
CNSTI4 624
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 480
ADDP4
INDIRF4
ASGNF4
line 1460
;1460:				}
LABELV $733
line 1461
;1461:				if (ent->r.absmin[2] < seg->boundingMin[2]) {
ADDRLP4 8
INDIRP4
CNSTI4 472
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 616
ADDP4
INDIRF4
GEF4 $735
line 1462
;1462:					seg->boundingMin[2] = ent->r.absmin[2];
ADDRLP4 12
INDIRP4
CNSTI4 616
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 472
ADDP4
INDIRF4
ASGNF4
line 1463
;1463:				}
LABELV $735
line 1464
;1464:				if (ent->r.absmax[2] > seg->boundingMax[2]) {
ADDRLP4 8
INDIRP4
CNSTI4 484
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 628
ADDP4
INDIRF4
LEF4 $737
line 1465
;1465:					seg->boundingMax[2] = ent->r.absmax[2];
ADDRLP4 12
INDIRP4
CNSTI4 628
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 484
ADDP4
INDIRF4
ASGNF4
line 1466
;1466:				}
LABELV $737
line 1467
;1467:			}
LABELV $725
line 1469
;1468:
;1469:			switch (ent->entClass) {
ADDRLP4 20
ADDRLP4 8
INDIRP4
CNSTI4 824
ADDP4
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 47
EQI4 $742
ADDRLP4 20
INDIRI4
CNSTI4 48
EQI4 $746
ADDRLP4 20
INDIRI4
CNSTI4 50
EQI4 $750
ADDRGP4 $739
JUMPV
LABELV $742
line 1471
;1470:			case GEC_efh_entrance:
;1471:				if (seg->entranceSet) {
ADDRLP4 12
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
EQI4 $743
line 1472
;1472:					G_Error(
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 SegmentName
CALLP4
ASGNP4
ADDRGP4 $745
ARGP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 1476
;1473:						"^1BuildSegments: duplicate entrance in segment %s",
;1474:						SegmentName(seg)
;1475:					);
;1476:				}
LABELV $743
line 1477
;1477:				VectorCopy(ent->sourceLocation, seg->entranceOrigin);
ADDRLP4 12
INDIRP4
CNSTI4 528
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 828
ADDP4
INDIRB
ASGNB 12
line 1478
;1478:				seg->entranceSet = qtrue;
ADDRLP4 12
INDIRP4
CNSTI4 524
ADDP4
CNSTI4 1
ASGNI4
line 1479
;1479:				break;
ADDRGP4 $709
JUMPV
LABELV $746
line 1481
;1480:			case GEC_efh_exit:
;1481:				if (seg->exitSet) {
ADDRLP4 12
INDIRP4
CNSTI4 540
ADDP4
INDIRI4
CNSTI4 0
EQI4 $747
line 1482
;1482:					G_Error(
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 SegmentName
CALLP4
ASGNP4
ADDRGP4 $749
ARGP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 1486
;1483:						"^1BuildSegments: duplicate exit in segment %s",
;1484:						SegmentName(seg)
;1485:					);
;1486:				}
LABELV $747
line 1487
;1487:				VectorCopy(ent->sourceLocation, seg->exitOrigin);
ADDRLP4 12
INDIRP4
CNSTI4 544
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 828
ADDP4
INDIRB
ASGNB 12
line 1488
;1488:				seg->exitSet = qtrue;
ADDRLP4 12
INDIRP4
CNSTI4 540
ADDP4
CNSTI4 1
ASGNI4
line 1489
;1489:				break;
ADDRGP4 $709
JUMPV
LABELV $750
line 1491
;1490:			case GEC_efh_waypoint:
;1491:				AddWaypoint(ent, seg);
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 AddWaypoint
CALLV
pop
line 1492
;1492:				break;
ADDRGP4 $709
JUMPV
LABELV $739
line 1495
;1493:			default:
;1494:				if (
;1495:					ent->item &&
ADDRLP4 8
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $751
ADDRLP4 8
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
NEI4 $751
ADDRLP4 8
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 8
NEI4 $751
line 1498
;1496:					ent->item->giType == IT_TEAM &&
;1497:					ent->item->giTag == PW_BLUEFLAG
;1498:				) {
line 1499
;1499:					if (seg->goalTemplate) {
ADDRLP4 12
INDIRP4
CNSTI4 580
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $753
line 1500
;1500:						G_Error(
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 SegmentName
CALLP4
ASGNP4
ADDRGP4 $755
ARGP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 1504
;1501:							"^1BuildSegments: duplicate goal in segment %s",
;1502:							SegmentName(seg)
;1503:						);
;1504:					}
LABELV $753
line 1505
;1505:					seg->goalTemplate = ent;
ADDRLP4 12
INDIRP4
CNSTI4 580
ADDP4
ADDRLP4 8
INDIRP4
ASGNP4
line 1506
;1506:				}
LABELV $751
line 1508
;1507:
;1508:				if (seg->numEntities >= MAX_ENTITIES_PER_SEGMENT) {
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 64
LTI4 $756
line 1509
;1509:					G_Error(
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 SegmentName
CALLP4
ASGNP4
ADDRGP4 $758
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 32
INDIRP4
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 1513
;1510:						"^1BuildSegments: too many (>%d) entities in segment %s",
;1511:						MAX_ENTITIES_PER_SEGMENT, SegmentName(seg)
;1512:					);
;1513:					break;
ADDRGP4 $709
JUMPV
LABELV $756
line 1516
;1514:				}
;1515:
;1516:				seg->entityTemplateIndex[seg->numEntities] = t;
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 1517
;1517:				seg->numEntities++;
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1518
;1518:			}
line 1520
;1519:
;1520:			break;	// we've found the segment this entity belongs to
ADDRGP4 $709
JUMPV
LABELV $708
line 1435
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $710
ADDRLP4 0
INDIRI4
ADDRGP4 numSegmentTypes
INDIRI4
LTI4 $707
LABELV $709
line 1522
;1521:		}
;1522:	}
LABELV $704
line 1431
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $706
ADDRLP4 4
INDIRI4
ADDRGP4 numEntityTemplates
INDIRI4
LTI4 $703
line 1524
;1523:
;1524:	for (s = 0; s < numSegmentTypes; s++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $762
JUMPV
LABELV $759
line 1528
;1525:		efhSegmentType_t* seg;
;1526:		vec3_t delta;
;1527:
;1528:		seg = &segmentTypes[s];
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 764
MULI4
ADDRGP4 segmentTypes
ADDP4
ASGNP4
line 1530
;1529:
;1530:		if (seg->numEntities <= 0) {
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 0
GTI4 $763
line 1531
;1531:			G_Error("^1BuildSegments: empty segment %s", SegmentName(seg));
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 SegmentName
CALLP4
ASGNP4
ADDRGP4 $765
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 1532
;1532:		}
LABELV $763
line 1534
;1533:
;1534:		if (!seg->entranceSet) {
ADDRLP4 8
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $766
line 1535
;1535:			G_Error("^1BuildSegments: no entrance for segment %s", SegmentName(seg));
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 SegmentName
CALLP4
ASGNP4
ADDRGP4 $768
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 1536
;1536:		}
LABELV $766
line 1549
;1537:		/*
;1538:		if (
;1539:			seg->entranceOrigin[0] > seg->boundingMin[0] + 11 &&
;1540:			seg->entranceOrigin[0] < seg->boundingMax[0] - 11 &&
;1541:			seg->entranceOrigin[1] > seg->boundingMin[1] + 11 &&
;1542:			seg->entranceOrigin[1] < seg->boundingMax[1] - 11 &&
;1543:			seg->entranceOrigin[2] > seg->boundingMin[2] + 11 &&
;1544:			seg->entranceOrigin[2] < seg->boundingMax[2] - 11
;1545:		) {
;1546:			G_Error("^1BuildSegment: efh_entrance inside segment %s", SegmentName(seg));
;1547:		}
;1548:		*/
;1549:		if (!seg->exitSet) {
ADDRLP4 8
INDIRP4
CNSTI4 540
ADDP4
INDIRI4
CNSTI4 0
NEI4 $769
line 1550
;1550:			G_Error("^1BuildSegments: no exit for segment %s", SegmentName(seg));
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 SegmentName
CALLP4
ASGNP4
ADDRGP4 $771
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 1551
;1551:		}
LABELV $769
line 1566
;1552:		/*
;1553:		if (
;1554:			seg->exitOrigin[0] > seg->boundingMin[0] + 11 &&
;1555:			seg->exitOrigin[0] < seg->boundingMax[0] - 11 &&
;1556:			seg->exitOrigin[1] > seg->boundingMin[1] + 11 &&
;1557:			seg->exitOrigin[1] < seg->boundingMax[1] - 11 &&
;1558:			seg->exitOrigin[2] > seg->boundingMin[2] + 11 &&
;1559:			seg->exitOrigin[2] < seg->boundingMax[2] - 11
;1560:		) {
;1561:			G_Error("^1BuildSegment: efh_exit inside segment %s", SegmentName(seg));
;1562:		}
;1563:		*/
;1564:
;1565:		// make bounding box relative to segment entrance
;1566:		VectorSubtract(seg->boundingMin, seg->entranceOrigin, seg->boundingMin);
ADDRLP4 8
INDIRP4
CNSTI4 608
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 608
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 612
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 612
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 532
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 616
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 616
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 536
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1567
;1567:		VectorSubtract(seg->boundingMax, seg->entranceOrigin, seg->boundingMax);
ADDRLP4 8
INDIRP4
CNSTI4 620
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 620
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 624
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 624
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 532
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 628
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 628
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 536
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1569
;1568:
;1569:		if (seg->final && !seg->goalTemplate) {
ADDRLP4 8
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
CNSTI4 0
EQI4 $772
ADDRLP4 8
INDIRP4
CNSTI4 580
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $772
line 1570
;1570:			G_Error("^1BuildSegments: no team_CTF_blueflag in final segment %s", SegmentName(seg));
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 SegmentName
CALLP4
ASGNP4
ADDRGP4 $774
ARGP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 1571
;1571:		}
LABELV $772
line 1573
;1572:
;1573:		VectorSubtract(seg->exitOrigin, seg->entranceOrigin, delta);
ADDRLP4 12
ADDRLP4 8
INDIRP4
CNSTI4 544
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 8
INDIRP4
CNSTI4 548
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 532
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 8
INDIRP4
CNSTI4 552
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 536
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1574
;1574:		seg->exitDelta.x = (int) delta[0];
ADDRLP4 8
INDIRP4
CNSTI4 568
ADDP4
ADDRLP4 12
INDIRF4
CVFI4 4
ASGNI4
line 1575
;1575:		seg->exitDelta.y = (int) delta[1];
ADDRLP4 8
INDIRP4
CNSTI4 572
ADDP4
ADDRLP4 12+4
INDIRF4
CVFI4 4
ASGNI4
line 1576
;1576:		seg->exitDelta.z = (int) delta[2];
ADDRLP4 8
INDIRP4
CNSTI4 576
ADDP4
ADDRLP4 12+8
INDIRF4
CVFI4 4
ASGNI4
line 1578
;1577:
;1578:		if (VectorLength(delta) < 16) {
ADDRLP4 12
ARGP4
ADDRLP4 60
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 60
INDIRF4
CNSTF4 1098907648
GEF4 $779
line 1579
;1579:			G_Error(
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 SegmentName
CALLP4
ASGNP4
ADDRGP4 $781
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 1583
;1580:				"^1BuildSegments: exit too near to entrance in segment %s",
;1581:				SegmentName(seg)
;1582:			);
;1583:		}
LABELV $779
line 1585
;1584:
;1585:		ComputeWayLength(seg);
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 ComputeWayLength
CALLV
pop
line 1586
;1586:	}
LABELV $760
line 1524
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $762
ADDRLP4 0
INDIRI4
ADDRGP4 numSegmentTypes
INDIRI4
LTI4 $759
line 1588
;1587:
;1588:	CheckForDeadStyles();
ADDRGP4 CheckForDeadStyles
CALLV
pop
line 1589
;1589:	CheckForUnterminatedStyles();
ADDRGP4 CheckForUnterminatedStyles
CALLV
pop
line 1590
;1590:	CheckReachabilityAndLoops();
ADDRGP4 CheckReachabilityAndLoops
CALLV
pop
line 1592
;1591:
;1592:	G_Printf("BuildSegments: %d entities in %d segments\n", numEntityTemplates, numSegmentTypes);
ADDRGP4 $782
ARGP4
ADDRGP4 numEntityTemplates
INDIRI4
ARGI4
ADDRGP4 numSegmentTypes
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 1593
;1593:}
LABELV $695
endproc BuildSegments 68 12
proc ClearMonsterCache 0 0
line 1603
;1594:#endif
;1595:
;1596:
;1597:/*
;1598:==============
;1599:JUHOX: ClearMonsterCache
;1600:==============
;1601:*/
;1602:#if ESCAPE_MODE
;1603:static void ClearMonsterCache(efhCachedMonster_t* cache) {
line 1604
;1604:	cache->currentSegment = -1;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 -1
ASGNI4
line 1605
;1605:	cache->sourceSegment = -1;
ADDRFP4 0
INDIRP4
CNSTI4 -1
ASGNI4
line 1606
;1606:	cache->sourceEntity = -1;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 -1
ASGNI4
line 1607
;1607:	cache->index = -1;
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 -1
ASGNI4
line 1608
;1608:}
LABELV $783
endproc ClearMonsterCache 0 0
proc AllocMonsterCache 24 0
line 1617
;1609:#endif
;1610:
;1611:/*
;1612:==============
;1613:JUHOX: AllocMonsterCache
;1614:==============
;1615:*/
;1616:#if ESCAPE_MODE
;1617:static efhCachedMonster_t* AllocMonsterCache(int sourceSegment, int sourceEntity, int index) {
line 1623
;1618:	int i;
;1619:	efhCachedMonster_t* freeCache;
;1620:	efhCachedMonster_t* oldestCache;
;1621:	long minX;
;1622:
;1623:	freeCache = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 1624
;1624:	oldestCache = NULL;
ADDRLP4 12
CNSTP4 0
ASGNP4
line 1625
;1625:	minX = 0x7fffffff;
ADDRLP4 8
CNSTI4 2147483647
ASGNI4
line 1627
;1626:
;1627:	for (i = 0; i < MAX_CACHED_MONSTERS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $785
line 1630
;1628:		efhCachedMonster_t* cache;
;1629:
;1630:		cache = &cachedMonsters[i];
ADDRLP4 16
ADDRLP4 0
INDIRI4
CNSTI4 56
MULI4
ADDRGP4 cachedMonsters
ADDP4
ASGNP4
line 1633
;1631:
;1632:		if (
;1633:			cache->sourceSegment == sourceSegment &&
ADDRLP4 16
INDIRP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $789
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $789
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRFP4 8
INDIRI4
NEI4 $789
line 1636
;1634:			cache->sourceEntity == sourceEntity &&
;1635:			cache->index == index
;1636:		) {
line 1637
;1637:			return NULL;
CNSTP4 0
RETP4
ADDRGP4 $784
JUMPV
LABELV $789
line 1640
;1638:		}
;1639:
;1640:		if (!freeCache && cache->sourceSegment < 0) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $791
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 0
GEI4 $791
line 1641
;1641:			freeCache = cache;
ADDRLP4 4
ADDRLP4 16
INDIRP4
ASGNP4
line 1642
;1642:		}
LABELV $791
line 1643
;1643:		if (cache->position.x < minX) {
ADDRLP4 16
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
GEI4 $793
line 1644
;1644:			minX = cache->position.x;
ADDRLP4 8
ADDRLP4 16
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 1645
;1645:			oldestCache = cache;
ADDRLP4 12
ADDRLP4 16
INDIRP4
ASGNP4
line 1646
;1646:		}
LABELV $793
line 1647
;1647:	}
LABELV $786
line 1627
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1024
LTI4 $785
line 1649
;1648:
;1649:	if (freeCache) return freeCache;
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $795
ADDRLP4 4
INDIRP4
RETP4
ADDRGP4 $784
JUMPV
LABELV $795
line 1650
;1650:	return oldestCache;
ADDRLP4 12
INDIRP4
RETP4
LABELV $784
endproc AllocMonsterCache 24 0
proc FreeMonsterCache 16 8
line 1660
;1651:}
;1652:#endif
;1653:
;1654:/*
;1655:==============
;1656:JUHOX: FreeMonsterCache
;1657:==============
;1658:*/
;1659:#if ESCAPE_MODE
;1660:static void FreeMonsterCache(efhCachedMonster_t* cache) {
line 1666
;1661:	int sourceSegment;
;1662:	int sourceEntity;
;1663:	gentity_t* entTemplate;
;1664:	int i;
;1665:
;1666:	sourceSegment = cache->sourceSegment;
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 1667
;1667:	sourceEntity = cache->sourceEntity;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1669
;1668:
;1669:	ClearMonsterCache(cache);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 ClearMonsterCache
CALLV
pop
line 1671
;1670:
;1671:	if (sourceSegment < 0) return;
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $798
ADDRGP4 $797
JUMPV
LABELV $798
line 1672
;1672:	if (sourceEntity < 0) return;
ADDRLP4 8
INDIRI4
CNSTI4 0
GEI4 $800
ADDRGP4 $797
JUMPV
LABELV $800
line 1674
;1673:
;1674:	entTemplate = &entityTemplates[sourceEntity];
ADDRLP4 12
ADDRLP4 8
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 entityTemplates
ADDP4
ASGNP4
line 1675
;1675:	if (!entTemplate->target) return;
ADDRLP4 12
INDIRP4
CNSTI4 652
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $802
ADDRGP4 $797
JUMPV
LABELV $802
line 1678
;1676:
;1677:	// this was a boss monster, check if there're others
;1678:	for (i = 0; i < MAX_CACHED_MONSTERS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $804
line 1679
;1679:		cache = &cachedMonsters[i];
ADDRFP4 0
ADDRLP4 0
INDIRI4
CNSTI4 56
MULI4
ADDRGP4 cachedMonsters
ADDP4
ASGNP4
line 1681
;1680:
;1681:		if (cache->sourceSegment != sourceSegment) continue;
ADDRFP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $808
ADDRGP4 $805
JUMPV
LABELV $808
line 1682
;1682:		if (cache->sourceEntity != sourceEntity) continue;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $797
line 1684
;1683:
;1684:		return;
LABELV $805
line 1678
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1024
LTI4 $804
line 1687
;1685:	}
;1686:	// No other boss monsters. Fire the targets.
;1687:	entTemplate->worldSegment = sourceSegment + 1;
ADDRLP4 12
INDIRP4
CNSTI4 820
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1688
;1688:	G_UseTargets(entTemplate, &g_entities[ENTITYNUM_WORLD]);
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 g_entities+862568
ARGP4
ADDRGP4 G_UseTargets
CALLV
pop
line 1689
;1689:}
LABELV $797
endproc FreeMonsterCache 16 8
proc SpawnMonster 92 12
line 1701
;1690:#endif
;1691:
;1692:/*
;1693:==============
;1694:JUHOX: SpawnMonster
;1695:==============
;1696:*/
;1697:#if ESCAPE_MODE
;1698:static void SpawnMonster(
;1699:	int count, int sourceSegment, int sourceEntity, const efhVector_t* segOrg,
;1700:	int type, int health, qboolean forceSpawn
;1701:) {
line 1708
;1702:	int load;
;1703:	monsterspawnmode_t msm;
;1704:	localseed_t seed;
;1705:	int i;
;1706:	int n;
;1707:
;1708:	if (visitedSegments[sourceSegment>>3] & (1 << (sourceSegment & 7))) return;
ADDRLP4 32
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 3
RSHI4
ADDRGP4 visitedSegments
ADDP4
INDIRU1
CVUI4 1
CNSTI4 1
ADDRLP4 32
INDIRI4
CNSTI4 7
BANDI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $814
ADDRGP4 $813
JUMPV
LABELV $814
line 1710
;1709:
;1710:	load = g_monsterLoad.integer;
ADDRLP4 28
ADDRGP4 g_monsterLoad+12
INDIRI4
ASGNI4
line 1711
;1711:	if (load > 1000) load = 1000;
ADDRLP4 28
INDIRI4
CNSTI4 1000
LEI4 $817
ADDRLP4 28
CNSTI4 1000
ASGNI4
LABELV $817
line 1712
;1712:	if (totalWayLength[sourceSegment] < 10000) load = (load * totalWayLength[sourceSegment]) / 10000;
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 totalWayLength
ADDP4
INDIRU4
CNSTU4 10000
GEU4 $819
ADDRLP4 28
ADDRLP4 28
INDIRI4
CVIU4 4
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 totalWayLength
ADDP4
INDIRU4
MULU4
CNSTU4 10000
DIVU4
CVUI4 4
ASGNI4
LABELV $819
line 1714
;1713:
;1714:	msm = MSM_nearOrigin;
ADDRLP4 20
CNSTI4 1
ASGNI4
line 1715
;1715:	if (count <= 0) {
ADDRFP4 0
INDIRI4
CNSTI4 0
GTI4 $821
line 1716
;1716:		count = 1;
ADDRFP4 0
CNSTI4 1
ASGNI4
line 1717
;1717:		if (load > 100) load = 100;
ADDRLP4 28
INDIRI4
CNSTI4 100
LEI4 $823
ADDRLP4 28
CNSTI4 100
ASGNI4
LABELV $823
line 1718
;1718:		msm = MSM_atOrigin;
ADDRLP4 20
CNSTI4 2
ASGNI4
line 1719
;1719:	}
LABELV $821
line 1721
;1720:
;1721:	if (forceSpawn && load < 100) {
ADDRFP4 24
INDIRI4
CNSTI4 0
EQI4 $825
ADDRLP4 28
INDIRI4
CNSTI4 100
GEI4 $825
line 1722
;1722:		load = 100;
ADDRLP4 28
CNSTI4 100
ASGNI4
line 1723
;1723:	}
ADDRGP4 $826
JUMPV
LABELV $825
line 1724
;1724:	else if (totalWayLength[sourceSegment] < 3000) {
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 totalWayLength
ADDP4
INDIRU4
CNSTU4 3000
GEU4 $827
line 1725
;1725:		return;
ADDRGP4 $813
JUMPV
LABELV $827
LABELV $826
line 1729
;1726:	}
;1727:
;1728:	// guarantee the seed does not depend on the order of segment creation
;1729:	seed.seed0 = monsterSpawnSeed;
ADDRLP4 4
ADDRGP4 monsterSpawnSeed
INDIRU4
ASGNU4
line 1730
;1730:	seed.seed1 = sourceSegment;
ADDRLP4 4+4
ADDRFP4 4
INDIRI4
CVIU4 4
ASGNU4
line 1731
;1731:	seed.seed2 = sourceEntity;
ADDRLP4 4+8
ADDRFP4 8
INDIRI4
CVIU4 4
ASGNU4
line 1732
;1732:	seed.seed3 = 0;
ADDRLP4 4+12
CNSTU4 0
ASGNU4
line 1734
;1733:
;1734:	n = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1736
;1735:
;1736:	for (i = 0; i < count; i++) {
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRGP4 $835
JUMPV
LABELV $832
line 1739
;1737:		int stock;
;1738:
;1739:		for (stock = load; stock > 0; stock -= 100) {
ADDRLP4 36
ADDRLP4 28
INDIRI4
ASGNI4
ADDRGP4 $839
JUMPV
LABELV $836
line 1743
;1740:			efhCachedMonster_t* cache;
;1741:			vec3_t delta;
;1742:
;1743:			if (stock < 100) {
ADDRLP4 36
INDIRI4
CNSTI4 100
GEI4 $840
line 1744
;1744:				if (LocallySeededRandom(&seed) % 100 >= stock) break;
ADDRLP4 4
ARGP4
ADDRLP4 56
ADDRGP4 LocallySeededRandom
CALLU4
ASGNU4
ADDRLP4 56
INDIRU4
CNSTU4 100
MODU4
ADDRLP4 36
INDIRI4
CVIU4 4
LTU4 $842
ADDRGP4 $838
JUMPV
LABELV $842
line 1745
;1745:			}
LABELV $840
line 1747
;1746:
;1747:			cache = AllocMonsterCache(sourceSegment, sourceEntity, n);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 56
ADDRGP4 AllocMonsterCache
CALLP4
ASGNP4
ADDRLP4 40
ADDRLP4 56
INDIRP4
ASGNP4
line 1748
;1748:			if (!cache) continue;
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $844
ADDRGP4 $837
JUMPV
LABELV $844
line 1750
;1749:
;1750:			switch (type) {
ADDRLP4 60
ADDRFP4 16
INDIRI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 1
EQI4 $848
ADDRLP4 60
INDIRI4
CNSTI4 2
EQI4 $849
ADDRLP4 60
INDIRI4
CNSTI4 3
EQI4 $850
ADDRGP4 $846
JUMPV
LABELV $848
line 1752
;1751:			case 1:
;1752:				cache->type = MT_predator;
ADDRLP4 40
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 0
ASGNI4
line 1753
;1753:				break;
ADDRGP4 $847
JUMPV
LABELV $849
line 1755
;1754:			case 2:
;1755:				cache->type = MT_guard;
ADDRLP4 40
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 1
ASGNI4
line 1756
;1756:				break;
ADDRGP4 $847
JUMPV
LABELV $850
line 1758
;1757:			case 3:
;1758:				cache->type = MT_titan;
ADDRLP4 40
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 2
ASGNI4
line 1759
;1759:				break;
ADDRGP4 $847
JUMPV
LABELV $846
line 1761
;1760:			default:
;1761:				cache->type = G_MonsterType(&seed);
ADDRLP4 4
ARGP4
ADDRLP4 64
ADDRGP4 G_MonsterType
CALLI4
ASGNI4
ADDRLP4 40
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 64
INDIRI4
ASGNI4
line 1762
;1762:				break;
LABELV $847
line 1765
;1763:			}
;1764:
;1765:			if (health > 0) {
ADDRFP4 20
INDIRI4
CNSTI4 0
LEI4 $851
line 1766
;1766:				health = G_MonsterBaseHealth(cache->type, G_MonsterHealthScale() * health / 100.0);
ADDRLP4 64
ADDRGP4 G_MonsterHealthScale
CALLF4
ASGNF4
ADDRLP4 40
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRLP4 64
INDIRF4
ADDRFP4 20
INDIRI4
CVIF4 4
MULF4
CNSTF4 1008981770
MULF4
ARGF4
ADDRLP4 68
ADDRGP4 G_MonsterBaseHealth
CALLI4
ASGNI4
ADDRFP4 20
ADDRLP4 68
INDIRI4
ASGNI4
line 1767
;1767:			}
LABELV $851
line 1769
;1768:
;1769:			cache->sourceSegment = sourceSegment;
ADDRLP4 40
INDIRP4
ADDRFP4 4
INDIRI4
ASGNI4
line 1770
;1770:			cache->sourceEntity = sourceEntity;
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 1771
;1771:			cache->index = n;
ADDRLP4 40
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1772
;1772:			cache->currentSegment = sourceSegment;
ADDRLP4 40
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 1774
;1773:
;1774:			cache->position = *segOrg;
ADDRLP4 40
INDIRP4
CNSTI4 16
ADDP4
ADDRFP4 12
INDIRP4
INDIRB
ASGNB 12
line 1775
;1775:			VectorSubtract(
ADDRLP4 64
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 68
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 72
ADDRGP4 efhWorld
ASGNP4
ADDRLP4 44
ADDRLP4 64
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 entityTemplates+828
ADDP4
INDIRF4
ADDRLP4 68
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 72
INDIRP4
ADDP4
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 44+4
ADDRLP4 64
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 entityTemplates+828+4
ADDP4
INDIRF4
ADDRLP4 68
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 72
INDIRP4
ADDP4
INDIRP4
CNSTI4 532
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 44+8
ADDRFP4 8
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 entityTemplates+828+8
ADDP4
INDIRF4
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 efhWorld
ADDP4
INDIRP4
CNSTI4 536
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1780
;1776:				entityTemplates[sourceEntity].sourceLocation,
;1777:				efhWorld[sourceSegment]->entranceOrigin,
;1778:				delta
;1779:			);
;1780:			cache->position.x += delta[0];
ADDRLP4 76
ADDRLP4 40
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CVIF4 4
ADDRLP4 44
INDIRF4
ADDF4
CVFI4 4
ASGNI4
line 1781
;1781:			cache->position.y += delta[1];
ADDRLP4 80
ADDRLP4 40
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRI4
CVIF4 4
ADDRLP4 44+4
INDIRF4
ADDF4
CVFI4 4
ASGNI4
line 1782
;1782:			cache->position.z += delta[2];
ADDRLP4 84
ADDRLP4 40
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
CVIF4 4
ADDRLP4 44+8
INDIRF4
ADDF4
CVFI4 4
ASGNI4
line 1783
;1783:			VectorSet(cache->angles, 0, local_random(&seed) * 360, 0);
ADDRLP4 40
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 0
ASGNF4
ADDRLP4 4
ARGP4
ADDRLP4 88
ADDRGP4 local_random
CALLF4
ASGNF4
ADDRLP4 40
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 88
INDIRF4
CNSTF4 1135869952
MULF4
ASGNF4
ADDRLP4 40
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 0
ASGNF4
line 1784
;1784:			cache->spawnmode = msm;
ADDRLP4 40
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
line 1785
;1785:			cache->maxHealth = health;
ADDRLP4 40
INDIRP4
CNSTI4 48
ADDP4
ADDRFP4 20
INDIRI4
ASGNI4
line 1786
;1786:			cache->action = MA_waiting;
ADDRLP4 40
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 1787
;1787:			if (cache->type == MT_titan) {
ADDRLP4 40
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 2
NEI4 $862
line 1788
;1788:				cache->action = MA_sleeping;
ADDRLP4 40
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 5
ASGNI4
line 1789
;1789:			}
LABELV $862
line 1791
;1790:
;1791:			n++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1792
;1792:		}
LABELV $837
line 1739
ADDRLP4 36
ADDRLP4 36
INDIRI4
CNSTI4 100
SUBI4
ASGNI4
LABELV $839
ADDRLP4 36
INDIRI4
CNSTI4 0
GTI4 $836
LABELV $838
line 1793
;1793:	}
LABELV $833
line 1736
ADDRLP4 24
ADDRLP4 24
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $835
ADDRLP4 24
INDIRI4
ADDRFP4 0
INDIRI4
LTI4 $832
line 1794
;1794:}
LABELV $813
endproc SpawnMonster 92 12
proc SpawnCachedMonsters 104 44
line 1803
;1795:#endif
;1796:
;1797:/*
;1798:==============
;1799:JUHOX: SpawnCachedMonsters
;1800:==============
;1801:*/
;1802:#if ESCAPE_MODE
;1803:static void SpawnCachedMonsters(void) {
line 1806
;1804:	int i;
;1805:
;1806:	if (G_NumMonsters() >= MAX_MONSTERS) return;
ADDRLP4 4
ADDRGP4 G_NumMonsters
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 200
LTI4 $865
ADDRGP4 $864
JUMPV
LABELV $865
line 1808
;1807:
;1808:	for (i = 0; i < MAX_CACHED_MONSTERS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $867
line 1811
;1809:		efhCachedMonster_t* cache;
;1810:
;1811:		cache = &cachedMonsters[i];
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 56
MULI4
ADDRGP4 cachedMonsters
ADDP4
ASGNP4
line 1813
;1812:		if (
;1813:			cache->currentSegment >= 0 &&
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
LTI4 $871
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRGP4 segmentState
ADDP4
INDIRU1
CVUI4 1
CNSTI4 2
NEI4 $871
line 1815
;1814:			segmentState[cache->currentSegment] == ESS_spawned
;1815:		) {
line 1822
;1816:			vec3_t mins, maxs;
;1817:			vec3_t origin;
;1818:			vec3_t spawnorigin;
;1819:			localseed_t seed;
;1820:			gentity_t* monster;
;1821:
;1822:			G_GetMonsterBounds(cache->type, mins, maxs);
ADDRLP4 8
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
ARGP4
ADDRLP4 60
ARGP4
ADDRGP4 G_GetMonsterBounds
CALLV
pop
line 1823
;1823:			origin[0] = cache->position.x - level.referenceOrigin.x;
ADDRLP4 16
ADDRLP4 8
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ADDRGP4 level+23032
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 1824
;1824:			origin[1] = cache->position.y - level.referenceOrigin.y;
ADDRLP4 16+4
ADDRLP4 8
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ADDRGP4 level+23032+4
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 1825
;1825:			origin[2] = cache->position.z - level.referenceOrigin.z;
ADDRLP4 16+8
ADDRLP4 8
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
ADDRGP4 level+23032+8
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 1826
;1826:			InitLocalSeed(GST_monsterSpawning, &seed);
CNSTI4 0
ARGI4
ADDRLP4 28
ARGP4
ADDRGP4 InitLocalSeed
CALLV
pop
line 1827
;1827:			if (!G_GetMonsterSpawnPoint(mins, maxs, &seed, spawnorigin, cache->spawnmode, origin)) {
ADDRLP4 48
ARGP4
ADDRLP4 60
ARGP4
ADDRLP4 28
ARGP4
ADDRLP4 72
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRLP4 84
ADDRGP4 G_GetMonsterSpawnPoint
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
NEI4 $880
line 1828
;1828:				ClearMonsterCache(cache);
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 ClearMonsterCache
CALLV
pop
line 1829
;1829:				continue;
ADDRGP4 $868
JUMPV
LABELV $880
line 1831
;1830:			}
;1831:			monster = G_SpawnMonster(
ADDRLP4 8
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 28
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 -1
ARGI4
ADDRLP4 28
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 92
ADDRGP4 G_SpawnMonster
CALLP4
ASGNP4
ADDRLP4 44
ADDRLP4 92
INDIRP4
ASGNP4
line 1836
;1832:				cache->type,
;1833:				spawnorigin, cache->angles,
;1834:				0, TEAM_FREE, -1, &seed, NULL, cache->maxHealth, cache->action, i
;1835:			);
;1836:			if (monster) {
ADDRLP4 44
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $882
line 1839
;1837:				playerState_t* ps;
;1838:
;1839:				monster->worldSegment = cache->currentSegment + 1;
ADDRLP4 44
INDIRP4
CNSTI4 820
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1840
;1840:				cache->currentSegment = -1;
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 -1
ASGNI4
line 1841
;1841:				ps = G_GetEntityPlayerState(monster);
ADDRLP4 44
INDIRP4
ARGP4
ADDRLP4 100
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 96
ADDRLP4 100
INDIRP4
ASGNP4
line 1842
;1842:				if (ps) {
ADDRLP4 96
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $884
line 1843
;1843:					cache->maxHealth = ps->stats[STAT_MAX_HEALTH];
ADDRLP4 8
INDIRP4
CNSTI4 48
ADDP4
ADDRLP4 96
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
ASGNI4
line 1844
;1844:				}
LABELV $884
line 1845
;1845:			}
LABELV $882
line 1847
;1846:
;1847:			if (G_NumMonsters() >= MAX_MONSTERS) return;
ADDRLP4 96
ADDRGP4 G_NumMonsters
CALLI4
ASGNI4
ADDRLP4 96
INDIRI4
CNSTI4 200
LTI4 $886
ADDRGP4 $864
JUMPV
LABELV $886
line 1848
;1848:		}
LABELV $871
line 1849
;1849:	}
LABELV $868
line 1808
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1024
LTI4 $867
line 1850
;1850:}
LABELV $864
endproc SpawnCachedMonsters 104 44
proc SpawnSegment 356 28
line 1863
;1851:#endif
;1852:
;1853:/*
;1854:==============
;1855:JUHOX: SpawnSegment
;1856:==============
;1857:*/
;1858:#if ESCAPE_MODE
;1859:static void SpawnSegment(
;1860:	const efhSegmentType_t* seg, const vec3_t origin,
;1861:	int worldSegment, const efhVector_t* segOrg,
;1862:	efhSpawnCommand_t cmd
;1863:) {
line 1868
;1864:	int i;
;1865:	int numBossEntities;
;1866:	int bossEntities[MAX_ENTITIES_PER_SEGMENT];
;1867:
;1868:	if (g_gametype.integer != GT_EFH) return;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
EQI4 $889
ADDRGP4 $888
JUMPV
LABELV $889
line 1870
;1869:
;1870:	numBossEntities = 0;
ADDRLP4 260
CNSTI4 0
ASGNI4
line 1872
;1871:
;1872:	for (i = 0; i < seg->numEntities; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $895
JUMPV
LABELV $892
line 1879
;1873:		gentity_t* ent;
;1874:		const gentity_t* entTemplate;
;1875:		int entnum;
;1876:		vec3_t dir;
;1877:		vec3_t entOrigin;
;1878:
;1879:		entTemplate = &entityTemplates[seg->entityTemplateIndex[i]];
ADDRLP4 292
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 entityTemplates
ADDP4
ASGNP4
line 1881
;1880:
;1881:		switch (cmd) {
ADDRLP4 300
ADDRFP4 16
INDIRI4
ASGNI4
ADDRLP4 300
INDIRI4
CNSTI4 0
EQI4 $897
ADDRLP4 300
INDIRI4
CNSTI4 1
EQI4 $900
ADDRLP4 300
INDIRI4
CNSTI4 2
EQI4 $904
ADDRGP4 $896
JUMPV
line 1883
;1882:		case ESC_spawnCompletely:
;1883:			break;
LABELV $900
line 1885
;1884:		case ESC_spawnSolidOnly:
;1885:			if (entTemplate->s.eType != ET_MOVER) goto NextEntity;
ADDRLP4 292
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 4
EQI4 $897
ADDRGP4 $903
JUMPV
line 1886
;1886:			break;
LABELV $904
line 1888
;1887:		case ESC_spawnNonSolidOnly:
;1888:			if (entTemplate->s.eType == ET_MOVER) goto NextEntity;
ADDRLP4 292
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 4
NEI4 $897
ADDRGP4 $903
JUMPV
line 1889
;1889:			break;
LABELV $896
LABELV $897
line 1892
;1890:		}
;1891:
;1892:		if (entTemplate->entClass == GEC_efh_monster) {
ADDRLP4 292
INDIRP4
CNSTI4 824
ADDP4
INDIRI4
CNSTI4 49
NEI4 $907
line 1893
;1893:			SpawnMonster(
ADDRLP4 292
INDIRP4
CNSTI4 764
ADDP4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 292
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 1
BANDI4
ARGI4
ADDRGP4 SpawnMonster
CALLV
pop
line 1898
;1894:				entTemplate->count, worldSegment, seg->entityTemplateIndex[i], segOrg,
;1895:				entTemplate->s.otherEntityNum, entTemplate->health,
;1896:				entTemplate->spawnflags & 1
;1897:			);
;1898:			if (entTemplate->target) {
ADDRLP4 292
INDIRP4
CNSTI4 652
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $893
line 1899
;1899:				bossEntities[numBossEntities++] = seg->entityTemplateIndex[i];
ADDRLP4 312
ADDRLP4 260
INDIRI4
ASGNI4
ADDRLP4 260
ADDRLP4 312
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 312
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDP4
INDIRI4
ASGNI4
line 1900
;1900:			}
line 1901
;1901:			continue;
ADDRGP4 $893
JUMPV
LABELV $907
line 1904
;1902:		}
;1903:
;1904:		ent = G_Spawn();
ADDRLP4 308
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 264
ADDRLP4 308
INDIRP4
ASGNP4
line 1905
;1905:		if (!ent) return;
ADDRLP4 264
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $911
ADDRGP4 $888
JUMPV
LABELV $911
line 1907
;1906:
;1907:		entnum = ent->s.number;
ADDRLP4 296
ADDRLP4 264
INDIRP4
INDIRI4
ASGNI4
line 1908
;1908:		memcpy(ent, entTemplate, sizeof(gentity_t));
ADDRLP4 264
INDIRP4
ARGP4
ADDRLP4 292
INDIRP4
ARGP4
CNSTI4 844
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1909
;1909:		ent->s.number = entnum;
ADDRLP4 264
INDIRP4
ADDRLP4 296
INDIRI4
ASGNI4
line 1910
;1910:		ent->r.s = ent->s;
ADDRLP4 264
INDIRP4
CNSTI4 208
ADDP4
ADDRLP4 264
INDIRP4
INDIRB
ASGNB 208
line 1911
;1911:		VectorSubtract(ent->r.currentOrigin, seg->entranceOrigin, dir);
ADDRLP4 320
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 268
ADDRLP4 264
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 320
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 268+4
ADDRLP4 264
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 320
INDIRP4
CNSTI4 532
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 268+8
ADDRLP4 264
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1912
;1912:		VectorAdd(origin, dir, entOrigin);
ADDRLP4 324
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 280
ADDRLP4 324
INDIRP4
INDIRF4
ADDRLP4 268
INDIRF4
ADDF4
ASGNF4
ADDRLP4 280+4
ADDRLP4 324
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 268+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 280+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 268+8
INDIRF4
ADDF4
ASGNF4
line 1913
;1913:		VectorCopy(entOrigin, ent->s.pos.trBase);
ADDRLP4 264
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 280
INDIRB
ASGNB 12
line 1914
;1914:		VectorCopy(entOrigin, ent->r.currentOrigin);
ADDRLP4 264
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 280
INDIRB
ASGNB 12
line 1915
;1915:		VectorCopy(entOrigin, ent->s.origin);	// for spawn points
ADDRLP4 264
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 280
INDIRB
ASGNB 12
line 1916
;1916:		if (ent->s.eType == ET_MOVER) {
ADDRLP4 264
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 4
NEI4 $919
line 1917
;1917:			VectorSubtract(entOrigin, entTemplate->r.currentOrigin, dir);
ADDRLP4 268
ADDRLP4 280
INDIRF4
ADDRLP4 292
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 268+4
ADDRLP4 280+4
INDIRF4
ADDRLP4 292
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 268+8
ADDRLP4 280+8
INDIRF4
ADDRLP4 292
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1918
;1918:			VectorAdd(ent->pos1, dir, ent->pos1);
ADDRLP4 264
INDIRP4
CNSTI4 616
ADDP4
ADDRLP4 264
INDIRP4
CNSTI4 616
ADDP4
INDIRF4
ADDRLP4 268
INDIRF4
ADDF4
ASGNF4
ADDRLP4 264
INDIRP4
CNSTI4 620
ADDP4
ADDRLP4 264
INDIRP4
CNSTI4 620
ADDP4
INDIRF4
ADDRLP4 268+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 264
INDIRP4
CNSTI4 624
ADDP4
ADDRLP4 264
INDIRP4
CNSTI4 624
ADDP4
INDIRF4
ADDRLP4 268+8
INDIRF4
ADDF4
ASGNF4
line 1919
;1919:			VectorAdd(ent->pos2, dir, ent->pos2);
ADDRLP4 264
INDIRP4
CNSTI4 628
ADDP4
ADDRLP4 264
INDIRP4
CNSTI4 628
ADDP4
INDIRF4
ADDRLP4 268
INDIRF4
ADDF4
ASGNF4
ADDRLP4 264
INDIRP4
CNSTI4 632
ADDP4
ADDRLP4 264
INDIRP4
CNSTI4 632
ADDP4
INDIRF4
ADDRLP4 268+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 264
INDIRP4
CNSTI4 636
ADDP4
ADDRLP4 264
INDIRP4
CNSTI4 636
ADDP4
INDIRF4
ADDRLP4 268+8
INDIRF4
ADDF4
ASGNF4
line 1920
;1920:			ent->s.time = worldSegment;
ADDRLP4 264
INDIRP4
CNSTI4 84
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 1921
;1921:		}
LABELV $919
line 1922
;1922:		ent->worldSegment = worldSegment + 1;
ADDRLP4 264
INDIRP4
CNSTI4 820
ADDP4
ADDRFP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1925
;1923:
;1924:		// entity type specific initializations
;1925:		switch (ent->entClass) {
ADDRLP4 328
ADDRLP4 264
INDIRP4
CNSTI4 824
ADDP4
INDIRI4
ASGNI4
ADDRLP4 328
INDIRI4
CNSTI4 12
LTI4 $950
ADDRLP4 328
INDIRI4
CNSTI4 16
GTI4 $951
ADDRLP4 328
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $952-48
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $952
address $934
address $936
address $940
address $930
address $934
code
LABELV $950
ADDRLP4 328
INDIRI4
CNSTI4 0
EQI4 $932
ADDRLP4 328
INDIRI4
CNSTI4 1
EQI4 $934
ADDRGP4 $930
JUMPV
LABELV $951
ADDRLP4 328
INDIRI4
CNSTI4 31
LTI4 $930
ADDRLP4 328
INDIRI4
CNSTI4 39
GTI4 $930
ADDRLP4 328
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $954-124
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $954
address $934
address $930
address $930
address $930
address $930
address $942
address $946
address $946
address $946
code
LABELV $932
line 1927
;1926:		case GEC_invalid:
;1927:			G_Error("^1BUG! SpawnSegment: entity class not initialized for '%s'", ent->classname);
ADDRGP4 $933
ARGP4
ADDRLP4 264
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 1928
;1928:			break;
ADDRGP4 $930
JUMPV
LABELV $934
line 1933
;1929:		case GEC_item:
;1930:		case GEC_func_train:
;1931:		case GEC_trigger_push:
;1932:		case GEC_target_push:
;1933:			ent->nextthink = level.time + FRAMETIME;
ADDRLP4 264
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 1934
;1934:			break;
ADDRGP4 $930
JUMPV
LABELV $936
line 1936
;1935:		case GEC_func_timer:
;1936:			if (ent->spawnflags & 1) {
ADDRLP4 264
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $937
line 1937
;1937:				ent->nextthink = level.time + FRAMETIME;
ADDRLP4 264
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 1938
;1938:			}
ADDRGP4 $930
JUMPV
LABELV $937
line 1939
;1939:			else {
line 1940
;1940:				ent->nextthink = 0;
ADDRLP4 264
INDIRP4
CNSTI4 692
ADDP4
CNSTI4 0
ASGNI4
line 1941
;1941:			}
line 1942
;1942:			break;
ADDRGP4 $930
JUMPV
LABELV $940
line 1944
;1943:		case GEC_trigger_always:
;1944:			ent->nextthink = level.time + 300;
ADDRLP4 264
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 300
ADDI4
ASGNI4
line 1945
;1945:			break;
ADDRGP4 $930
JUMPV
LABELV $942
line 1947
;1946:		case GEC_misc_portal_surface:
;1947:			if (ent->target) {
ADDRLP4 264
INDIRP4
CNSTI4 652
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $930
line 1948
;1948:				ent->nextthink = level.time + 100;
ADDRLP4 264
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 1949
;1949:			}
line 1950
;1950:			break;
ADDRGP4 $930
JUMPV
LABELV $946
line 1954
;1951:		case GEC_shooter_rocket:
;1952:		case GEC_shooter_plasma:
;1953:		case GEC_shooter_grenade:
;1954:			if (ent->target) {
ADDRLP4 264
INDIRP4
CNSTI4 652
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $930
line 1955
;1955:				ent->nextthink = level.time + 500;
ADDRLP4 264
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 1956
;1956:			}
line 1957
;1957:			break;
line 1959
;1958:		default:
;1959:			break;
LABELV $930
line 1962
;1960:		}
;1961:
;1962:		if (ent->r.linked) {
ADDRLP4 264
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
CNSTI4 0
EQI4 $956
line 1963
;1963:			ent->r.linked = qfalse;
ADDRLP4 264
INDIRP4
CNSTI4 416
ADDP4
CNSTI4 0
ASGNI4
line 1964
;1964:			trap_LinkEntity(ent);
ADDRLP4 264
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 1965
;1965:		}
LABELV $956
LABELV $903
line 1967
;1966:
;1967:		NextEntity:;
line 1968
;1968:	}
LABELV $893
line 1872
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $895
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
INDIRI4
LTI4 $892
line 1970
;1969:
;1970:	if (cmd == ESC_spawnSolidOnly) return;
ADDRFP4 16
INDIRI4
CNSTI4 1
NEI4 $958
ADDRGP4 $888
JUMPV
LABELV $958
line 1974
;1971:
;1972:	//SpawnCachedMonsters(worldSegment);
;1973:
;1974:	for (i = 0; i < numBossEntities; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $963
JUMPV
LABELV $960
line 1978
;1975:		gentity_t* bossSpawn;
;1976:		int n;
;1977:
;1978:		bossSpawn = &entityTemplates[bossEntities[i]];
ADDRLP4 268
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 entityTemplates
ADDP4
ASGNP4
line 1979
;1979:		for (n = 0; n < MAX_CACHED_MONSTERS; n++) {
ADDRLP4 264
CNSTI4 0
ASGNI4
LABELV $964
line 1982
;1980:			const efhCachedMonster_t* cache;
;1981:
;1982:			cache = &cachedMonsters[n];
ADDRLP4 272
ADDRLP4 264
INDIRI4
CNSTI4 56
MULI4
ADDRGP4 cachedMonsters
ADDP4
ASGNP4
line 1983
;1983:			if (cache->sourceSegment != worldSegment) continue;
ADDRLP4 272
INDIRP4
INDIRI4
ADDRFP4 8
INDIRI4
EQI4 $968
ADDRGP4 $965
JUMPV
LABELV $968
line 1984
;1984:			if (cache->sourceEntity != bossEntities[i]) continue;
ADDRLP4 272
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
EQI4 $966
line 1986
;1985:
;1986:			break;
LABELV $965
line 1979
ADDRLP4 264
ADDRLP4 264
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 264
INDIRI4
CNSTI4 1024
LTI4 $964
LABELV $966
line 1988
;1987:		}
;1988:		if (n >= MAX_CACHED_MONSTERS) {
ADDRLP4 264
INDIRI4
CNSTI4 1024
LTI4 $972
line 1989
;1989:			bossSpawn->worldSegment = worldSegment + 1;
ADDRLP4 268
INDIRP4
CNSTI4 820
ADDP4
ADDRFP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1990
;1990:			G_UseTargets(bossSpawn, &g_entities[ENTITYNUM_WORLD]);
ADDRLP4 268
INDIRP4
ARGP4
ADDRGP4 g_entities+862568
ARGP4
ADDRGP4 G_UseTargets
CALLV
pop
line 1991
;1991:		}
LABELV $972
line 1992
;1992:	}
LABELV $961
line 1974
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $963
ADDRLP4 0
INDIRI4
ADDRLP4 260
INDIRI4
LTI4 $960
line 1994
;1993:
;1994:	visitedSegments[worldSegment>>3] |= 1 << (worldSegment & 7);
ADDRLP4 264
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 268
ADDRLP4 264
INDIRI4
CNSTI4 3
RSHI4
ADDRGP4 visitedSegments
ADDP4
ASGNP4
ADDRLP4 268
INDIRP4
ADDRLP4 268
INDIRP4
INDIRU1
CVUI4 1
CNSTI4 1
ADDRLP4 264
INDIRI4
CNSTI4 7
BANDI4
LSHI4
BORI4
CVIU4 4
CVUU1 4
ASGNU1
line 1995
;1995:}
LABELV $888
endproc SpawnSegment 356 28
proc GetExcludedSegmentTypes 32 0
line 2004
;1996:#endif
;1997:
;1998:/*
;1999:==============
;2000:JUHOX: GetExcludedSegmentTypes
;2001:==============
;2002:*/
;2003:#if ESCAPE_MODE
;2004:static int GetExcludedSegmentTypes(int segment, efhSegmentType_t** exclude) {
line 2009
;2005:	efhVector_t segOrg;
;2006:	int numExcluded;
;2007:	int visBlockingCount;
;2008:
;2009:	segOrg.x = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2010
;2010:	segOrg.y = 0;
ADDRLP4 4+4
CNSTI4 0
ASGNI4
line 2011
;2011:	segOrg.z = 0;
ADDRLP4 4+8
CNSTI4 0
ASGNI4
line 2012
;2012:	numExcluded = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2013
;2013:	visBlockingCount = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRGP4 $979
JUMPV
LABELV $978
line 2015
;2014:
;2015:	while (segment > 0) {
line 2019
;2016:		int i;
;2017:		efhSegmentType_t* seg;
;2018:
;2019:		seg = efhWorld[segment];
ADDRLP4 24
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 efhWorld
ADDP4
INDIRP4
ASGNP4
line 2020
;2020:		if (!seg) continue;
ADDRLP4 24
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $981
ADDRGP4 $979
JUMPV
LABELV $981
line 2022
;2021:
;2022:		for (i = 0; i < numExcluded; i++) {
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRGP4 $986
JUMPV
LABELV $983
line 2023
;2023:			if (exclude[i] == seg) goto NextSegment;
ADDRLP4 20
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 24
INDIRP4
CVPU4 4
NEU4 $987
ADDRGP4 $989
JUMPV
LABELV $987
line 2024
;2024:		}
LABELV $984
line 2022
ADDRLP4 20
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $986
ADDRLP4 20
INDIRI4
ADDRLP4 0
INDIRI4
LTI4 $983
line 2025
;2025:		exclude[numExcluded++] = seg;
ADDRLP4 28
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 0
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
ADDRLP4 24
INDIRP4
ASGNP4
LABELV $989
line 2028
;2026:
;2027:		NextSegment:
;2028:		if (seg->visBlocking) {
ADDRLP4 24
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
CNSTI4 0
EQI4 $990
line 2029
;2029:			visBlockingCount++;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2030
;2030:			if (visBlockingCount >= 2) break;
ADDRLP4 16
INDIRI4
CNSTI4 2
LTI4 $992
ADDRGP4 $980
JUMPV
LABELV $992
line 2031
;2031:		}
LABELV $990
line 2033
;2032:
;2033:		segOrg.x += seg->exitDelta.x;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 24
INDIRP4
CNSTI4 568
ADDP4
INDIRI4
ADDI4
ASGNI4
line 2034
;2034:		segOrg.y += seg->exitDelta.y;
ADDRLP4 4+4
ADDRLP4 4+4
INDIRI4
ADDRLP4 24
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
ADDI4
ASGNI4
line 2035
;2035:		segOrg.z += seg->exitDelta.z;
ADDRLP4 4+8
ADDRLP4 4+8
INDIRI4
ADDRLP4 24
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ADDI4
ASGNI4
line 2037
;2036:
;2037:		if (segOrg.x < -MAX_VIEWDISTANCE) break;
ADDRLP4 4
INDIRI4
CNSTI4 -3000
GEI4 $996
ADDRGP4 $980
JUMPV
LABELV $996
line 2038
;2038:		if (segOrg.x > MAX_VIEWDISTANCE) break;
ADDRLP4 4
INDIRI4
CNSTI4 3000
LEI4 $998
ADDRGP4 $980
JUMPV
LABELV $998
line 2039
;2039:		if (segOrg.y < -MAX_VIEWDISTANCE) break;
ADDRLP4 4+4
INDIRI4
CNSTI4 -3000
GEI4 $1000
ADDRGP4 $980
JUMPV
LABELV $1000
line 2040
;2040:		if (segOrg.y > MAX_VIEWDISTANCE) break;
ADDRLP4 4+4
INDIRI4
CNSTI4 3000
LEI4 $1003
ADDRGP4 $980
JUMPV
LABELV $1003
line 2041
;2041:		if (segOrg.z < -MAX_VIEWDISTANCE) break;
ADDRLP4 4+8
INDIRI4
CNSTI4 -3000
GEI4 $1006
ADDRGP4 $980
JUMPV
LABELV $1006
line 2042
;2042:		if (segOrg.z > MAX_VIEWDISTANCE) break;
ADDRLP4 4+8
INDIRI4
CNSTI4 3000
LEI4 $1009
ADDRGP4 $980
JUMPV
LABELV $1009
line 2044
;2043:
;2044:		segment--;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2045
;2045:	}
LABELV $979
line 2015
ADDRFP4 0
INDIRI4
CNSTI4 0
GTI4 $978
LABELV $980
line 2046
;2046:	return numExcluded;
ADDRLP4 0
INDIRI4
RETI4
LABELV $975
endproc GetExcludedSegmentTypes 32 0
proc IsBoundingBoxOverlappingSegment 0 0
line 2059
;2047:}
;2048:#endif
;2049:
;2050:/*
;2051:==============
;2052:JUHOX: IsBoundingBoxOverlappingSegment
;2053:==============
;2054:*/
;2055:#if ESCAPE_MODE
;2056:static qboolean IsBoundingBoxOverlappingSegment(
;2057:	const efhVector_t* mins, const efhVector_t* maxs,
;2058:	const efhSegmentType_t* segType, const efhVector_t* segOrg
;2059:) {
line 2060
;2060:	if (mins->x - segOrg->x > segType->boundingMax[0] + 1) return qfalse;
ADDRFP4 0
INDIRP4
INDIRI4
ADDRFP4 12
INDIRP4
INDIRI4
SUBI4
CVIF4 4
ADDRFP4 8
INDIRP4
CNSTI4 620
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
LEF4 $1013
CNSTI4 0
RETI4
ADDRGP4 $1012
JUMPV
LABELV $1013
line 2061
;2061:	if (maxs->x - segOrg->x < segType->boundingMin[0] - 1) return qfalse;
ADDRFP4 4
INDIRP4
INDIRI4
ADDRFP4 12
INDIRP4
INDIRI4
SUBI4
CVIF4 4
ADDRFP4 8
INDIRP4
CNSTI4 608
ADDP4
INDIRF4
CNSTF4 1065353216
SUBF4
GEF4 $1015
CNSTI4 0
RETI4
ADDRGP4 $1012
JUMPV
LABELV $1015
line 2062
;2062:	if (mins->y - segOrg->y > segType->boundingMax[1] + 1) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRFP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
SUBI4
CVIF4 4
ADDRFP4 8
INDIRP4
CNSTI4 624
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
LEF4 $1017
CNSTI4 0
RETI4
ADDRGP4 $1012
JUMPV
LABELV $1017
line 2063
;2063:	if (maxs->y - segOrg->y < segType->boundingMin[1] - 1) return qfalse;
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRFP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
SUBI4
CVIF4 4
ADDRFP4 8
INDIRP4
CNSTI4 612
ADDP4
INDIRF4
CNSTF4 1065353216
SUBF4
GEF4 $1019
CNSTI4 0
RETI4
ADDRGP4 $1012
JUMPV
LABELV $1019
line 2064
;2064:	if (mins->z - segOrg->z > segType->boundingMax[2] + 1) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
SUBI4
CVIF4 4
ADDRFP4 8
INDIRP4
CNSTI4 628
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
LEF4 $1021
CNSTI4 0
RETI4
ADDRGP4 $1012
JUMPV
LABELV $1021
line 2065
;2065:	if (maxs->z - segOrg->z < segType->boundingMin[2] - 1) return qfalse;
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
SUBI4
CVIF4 4
ADDRFP4 8
INDIRP4
CNSTI4 616
ADDP4
INDIRF4
CNSTF4 1065353216
SUBF4
GEF4 $1023
CNSTI4 0
RETI4
ADDRGP4 $1012
JUMPV
LABELV $1023
line 2066
;2066:	return qtrue;
CNSTI4 1
RETI4
LABELV $1012
endproc IsBoundingBoxOverlappingSegment 0 0
proc DoesSegmentTypeFit 48 16
line 2076
;2067:}
;2068:#endif
;2069:
;2070:/*
;2071:==============
;2072:JUHOX: DoesSegmentTypeFit
;2073:==============
;2074:*/
;2075:#if ESCAPE_MODE
;2076:static qboolean DoesSegmentTypeFit(const efhSegmentType_t* segType, int segment) {
line 2083
;2077:	efhVector_t segOrg;
;2078:	efhVector_t mins;
;2079:	efhVector_t maxs;
;2080:	const efhSegmentType_t* sType;
;2081:	int visBlockingCount;
;2082:
;2083:	mins.x = segType->boundingMin[0];
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 608
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 2084
;2084:	mins.y = segType->boundingMin[1];
ADDRLP4 16+4
ADDRFP4 0
INDIRP4
CNSTI4 612
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 2085
;2085:	mins.z = segType->boundingMin[2];
ADDRLP4 16+8
ADDRFP4 0
INDIRP4
CNSTI4 616
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 2087
;2086:
;2087:	maxs.x = segType->boundingMax[0];
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 620
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 2088
;2088:	maxs.y = segType->boundingMax[1];
ADDRLP4 28+4
ADDRFP4 0
INDIRP4
CNSTI4 624
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 2089
;2089:	maxs.z = segType->boundingMax[2];
ADDRLP4 28+8
ADDRFP4 0
INDIRP4
CNSTI4 628
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 2091
;2090:
;2091:	sType = efhWorld[segment];
ADDRLP4 12
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 efhWorld
ADDP4
INDIRP4
ASGNP4
line 2093
;2092:
;2093:	segOrg.x = -sType->exitDelta.x;
ADDRLP4 0
ADDRLP4 12
INDIRP4
CNSTI4 568
ADDP4
INDIRI4
NEGI4
ASGNI4
line 2094
;2094:	segOrg.y = -sType->exitDelta.y;
ADDRLP4 0+4
ADDRLP4 12
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
NEGI4
ASGNI4
line 2095
;2095:	segOrg.z = -sType->exitDelta.z;
ADDRLP4 0+8
ADDRLP4 12
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
NEGI4
ASGNI4
line 2097
;2096:
;2097:	visBlockingCount = 0;
ADDRLP4 40
CNSTI4 0
ASGNI4
ADDRGP4 $1033
JUMPV
LABELV $1032
line 2099
;2098:
;2099:	while (segment > 0) {
line 2100
;2100:		if (sType->visBlocking) {
ADDRLP4 12
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1035
line 2101
;2101:			visBlockingCount++;
ADDRLP4 40
ADDRLP4 40
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2102
;2102:			if (visBlockingCount >= 2) {
ADDRLP4 40
INDIRI4
CNSTI4 2
LTI4 $1037
line 2103
;2103:				break;
ADDRGP4 $1034
JUMPV
LABELV $1037
line 2105
;2104:			}
;2105:		}
LABELV $1035
line 2107
;2106:
;2107:		segment--;
ADDRFP4 4
ADDRFP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2108
;2108:		sType = efhWorld[segment];
ADDRLP4 12
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 efhWorld
ADDP4
INDIRP4
ASGNP4
line 2109
;2109:		segOrg.x -= sType->exitDelta.x;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 568
ADDP4
INDIRI4
SUBI4
ASGNI4
line 2110
;2110:		segOrg.y -= sType->exitDelta.y;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
SUBI4
ASGNI4
line 2111
;2111:		segOrg.z -= sType->exitDelta.z;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
SUBI4
ASGNI4
line 2113
;2112:
;2113:		if (IsBoundingBoxOverlappingSegment(&mins, &maxs, sType, &segOrg)) return qfalse;
ADDRLP4 16
ARGP4
ADDRLP4 28
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 44
ADDRGP4 IsBoundingBoxOverlappingSegment
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $1041
CNSTI4 0
RETI4
ADDRGP4 $1025
JUMPV
LABELV $1041
line 2115
;2114:
;2115:		if (segOrg.x < -MAX_VIEWDISTANCE) break;
ADDRLP4 0
INDIRI4
CNSTI4 -3000
GEI4 $1043
ADDRGP4 $1034
JUMPV
LABELV $1043
line 2116
;2116:		if (segOrg.x > MAX_VIEWDISTANCE) break;
ADDRLP4 0
INDIRI4
CNSTI4 3000
LEI4 $1045
ADDRGP4 $1034
JUMPV
LABELV $1045
line 2117
;2117:		if (segOrg.y < -MAX_VIEWDISTANCE) break;
ADDRLP4 0+4
INDIRI4
CNSTI4 -3000
GEI4 $1047
ADDRGP4 $1034
JUMPV
LABELV $1047
line 2118
;2118:		if (segOrg.y > MAX_VIEWDISTANCE) break;
ADDRLP4 0+4
INDIRI4
CNSTI4 3000
LEI4 $1050
ADDRGP4 $1034
JUMPV
LABELV $1050
line 2119
;2119:		if (segOrg.z < -MAX_VIEWDISTANCE) break;
ADDRLP4 0+8
INDIRI4
CNSTI4 -3000
GEI4 $1053
ADDRGP4 $1034
JUMPV
LABELV $1053
line 2120
;2120:		if (segOrg.z > MAX_VIEWDISTANCE) break;
ADDRLP4 0+8
INDIRI4
CNSTI4 3000
LEI4 $1056
ADDRGP4 $1034
JUMPV
LABELV $1056
line 2121
;2121:	}
LABELV $1033
line 2099
ADDRFP4 4
INDIRI4
CNSTI4 0
GTI4 $1032
LABELV $1034
line 2122
;2122:	return qtrue;
CNSTI4 1
RETI4
LABELV $1025
endproc DoesSegmentTypeFit 48 16
proc GetAvailableSegmentTypes 32 8
line 2138
;2123:}
;2124:#endif
;2125:
;2126:/*
;2127:==============
;2128:JUHOX: GetAvailableSegmentTypes
;2129:==============
;2130:*/
;2131:#if ESCAPE_MODE
;2132:static int GetAvailableSegmentTypes(
;2133:	int segment,
;2134:	const efhTransitionStyle_t* style,
;2135:	qboolean finalization,
;2136:	efhSegmentType_t** exclude, int numExcluded,
;2137:	efhSegmentType_t** available
;2138:) {
line 2144
;2139:	int i;
;2140:	int numAvailable;
;2141:	efhSegmentType_t* fallback;
;2142:	int fallbackDist;
;2143:
;2144:	numAvailable = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 2146
;2145:
;2146:	fallback = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 2147
;2147:	fallbackDist = -1;
ADDRLP4 0
CNSTI4 -1
ASGNI4
line 2149
;2148:
;2149:	for (i = 0; i < numSegmentTypes; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $1063
JUMPV
LABELV $1060
line 2153
;2150:		int k;
;2151:		efhSegmentType_t* seg;
;2152:
;2153:		seg = &segmentTypes[i];
ADDRLP4 20
ADDRLP4 4
INDIRI4
CNSTI4 764
MULI4
ADDRGP4 segmentTypes
ADDP4
ASGNP4
line 2156
;2154:
;2155:		// check some basic restrictions
;2156:		if (style) {
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1064
line 2157
;2157:			if (seg->initial) continue;
ADDRLP4 20
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1065
ADDRGP4 $1061
JUMPV
line 2158
;2158:		}
LABELV $1064
line 2159
;2159:		else {
line 2160
;2160:			if (!seg->initial) continue;
ADDRLP4 20
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1070
ADDRGP4 $1061
JUMPV
line 2161
;2161:			goto SegmentAvailable;
LABELV $1065
line 2163
;2162:		}
;2163:		if (seg->final && !finalization) continue;
ADDRLP4 20
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1071
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $1071
ADDRGP4 $1061
JUMPV
LABELV $1071
line 2164
;2164:		if (seg->frustrating && !g_challengingEnv.integer) continue;
ADDRLP4 20
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1073
ADDRGP4 g_challengingEnv+12
INDIRI4
CNSTI4 0
NEI4 $1073
ADDRGP4 $1061
JUMPV
LABELV $1073
line 2167
;2165:
;2166:		// does seg have a matching style?
;2167:		for (k = 0; k < MAX_PARALLEL_STYLES; k++) {
ADDRLP4 16
CNSTI4 0
ASGNI4
LABELV $1076
line 2170
;2168:			const efhStyleEntry_t* se;
;2169:
;2170:			se = &seg->styles[k];
ADDRLP4 24
ADDRLP4 16
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 20
INDIRP4
CNSTI4 640
ADDP4
ADDP4
ASGNP4
line 2171
;2171:			if (!IsStyleEntryValid(seg, se)) continue;
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 IsStyleEntryValid
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $1080
ADDRGP4 $1077
JUMPV
LABELV $1080
line 2173
;2172:
;2173:			if (se->entrance == style) break;
ADDRLP4 24
INDIRP4
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CVPU4 4
NEU4 $1082
ADDRGP4 $1078
JUMPV
LABELV $1082
line 2174
;2174:		}
LABELV $1077
line 2167
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 10
LTI4 $1076
LABELV $1078
line 2175
;2175:		if (k >= MAX_PARALLEL_STYLES) continue;
ADDRLP4 16
INDIRI4
CNSTI4 10
LTI4 $1084
ADDRGP4 $1061
JUMPV
LABELV $1084
line 2178
;2176:
;2177:		// is seg excluded?
;2178:		for (k = 0; k < numExcluded; k++) {
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRGP4 $1089
JUMPV
LABELV $1086
line 2179
;2179:			if (seg == exclude[k]) {
ADDRLP4 20
INDIRP4
CVPU4 4
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 12
INDIRP4
ADDP4
INDIRP4
CVPU4 4
NEU4 $1090
line 2181
;2180:				// seg is excluded, but since everything else matches it may be used as a fallback
;2181:				if (k > fallbackDist) {
ADDRLP4 16
INDIRI4
ADDRLP4 0
INDIRI4
LEI4 $1094
line 2182
;2182:					fallbackDist = k;
ADDRLP4 0
ADDRLP4 16
INDIRI4
ASGNI4
line 2183
;2183:					fallback = seg;
ADDRLP4 8
ADDRLP4 20
INDIRP4
ASGNP4
line 2184
;2184:				}
line 2185
;2185:				goto NextType;
ADDRGP4 $1094
JUMPV
LABELV $1090
line 2187
;2186:			}
;2187:		}
LABELV $1087
line 2178
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1089
ADDRLP4 16
INDIRI4
ADDRFP4 16
INDIRI4
LTI4 $1086
line 2189
;2188:
;2189:		if (!DoesSegmentTypeFit(seg, segment)) continue;
ADDRLP4 20
INDIRP4
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 DoesSegmentTypeFit
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $1095
ADDRGP4 $1061
JUMPV
LABELV $1095
LABELV $1070
line 2192
;2190:
;2191:		SegmentAvailable:
;2192:		available[numAvailable++] = seg;
ADDRLP4 28
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 12
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 20
INDIRP4
ADDP4
ADDRLP4 20
INDIRP4
ASGNP4
LABELV $1094
line 2194
;2193:
;2194:		NextType:;
line 2195
;2195:	}
LABELV $1061
line 2149
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1063
ADDRLP4 4
INDIRI4
ADDRGP4 numSegmentTypes
INDIRI4
LTI4 $1060
line 2197
;2196:
;2197:	if (numAvailable <= 0) {
ADDRLP4 12
INDIRI4
CNSTI4 0
GTI4 $1097
line 2198
;2198:		available[0] = fallback;
ADDRFP4 20
INDIRP4
ADDRLP4 8
INDIRP4
ASGNP4
line 2199
;2199:		numAvailable = 1;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 2200
;2200:		numFallbacks++;
ADDRLP4 16
ADDRGP4 numFallbacks
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2201
;2201:		G_Printf(
ADDRGP4 $1099
ARGP4
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1102
ADDRLP4 20
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRGP4 $1103
JUMPV
LABELV $1102
ADDRLP4 20
ADDRGP4 $1100
ASGNP4
LABELV $1103
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 2206
;2202:			"^3WARNING: Not enough segments to choose from for style '%s'.\n",
;2203:			style? style->name : "<none>"
;2204:		);
;2205:
;2206:		if (!fallback) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1104
line 2207
;2207:			G_Printf(
ADDRGP4 $1106
ARGP4
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1108
ADDRLP4 24
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRGP4 $1109
JUMPV
LABELV $1108
ADDRLP4 24
ADDRGP4 $1100
ASGNP4
LABELV $1109
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 2211
;2208:				"^3WARNING: No fallback available for style '%s'.\n",
;2209:				style? style->name : "<none>"
;2210:			);
;2211:			numAvailable = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 2212
;2212:		}
LABELV $1104
line 2213
;2213:	}
LABELV $1097
line 2215
;2214:
;2215:	return numAvailable;
ADDRLP4 12
INDIRI4
RETI4
LABELV $1059
endproc GetAvailableSegmentTypes 32 8
proc FilterBestSegmentsForFinalization 20 0
line 2228
;2216:}
;2217:#endif
;2218:
;2219:/*
;2220:==============
;2221:JUHOX: FilterBestSegmentsForFinalization
;2222:==============
;2223:*/
;2224:#if ESCAPE_MODE
;2225:static void FilterBestSegmentsForFinalization(
;2226:	const efhTransitionStyle_t* style,
;2227:	efhSegmentType_t** available, int numAvailable
;2228:) {
line 2233
;2229:	int i;
;2230:	int minStepsNeeded;
;2231:
;2232:	// find out the minimum number of segments needed to reach a final segment
;2233:	minStepsNeeded = 10000;
ADDRLP4 0
CNSTI4 10000
ASGNI4
line 2234
;2234:	for (i = 0; i < numAvailable; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $1114
JUMPV
LABELV $1111
line 2238
;2235:		const efhSegmentType_t* segType;
;2236:		int j;
;2237:
;2238:		segType = available[i];
ADDRLP4 12
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRP4
ASGNP4
line 2239
;2239:		if (segType->final) {
ADDRLP4 12
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1115
line 2240
;2240:			minStepsNeeded = -1;
ADDRLP4 0
CNSTI4 -1
ASGNI4
line 2241
;2241:			break;
ADDRGP4 $1113
JUMPV
LABELV $1115
line 2244
;2242:		}
;2243:
;2244:		for (j = 0; j < MAX_PARALLEL_STYLES; j++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $1117
line 2247
;2245:			const efhStyleEntry_t* styleEntry;
;2246:
;2247:			styleEntry = &segType->styles[j];
ADDRLP4 16
ADDRLP4 8
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 12
INDIRP4
CNSTI4 640
ADDP4
ADDP4
ASGNP4
line 2248
;2248:			if (styleEntry->entrance != style) continue;
ADDRLP4 16
INDIRP4
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
EQU4 $1121
ADDRGP4 $1118
JUMPV
LABELV $1121
line 2249
;2249:			if (!styleEntry->exit) continue;	// should not happen
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1123
ADDRGP4 $1118
JUMPV
LABELV $1123
line 2251
;2250:
;2251:			if (styleEntry->exit->minStepsToFinalSegment >= minStepsNeeded) continue;
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
LTI4 $1125
ADDRGP4 $1118
JUMPV
LABELV $1125
line 2253
;2252:
;2253:			minStepsNeeded = styleEntry->exit->minStepsToFinalSegment;
ADDRLP4 0
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
INDIRI4
ASGNI4
line 2254
;2254:		}
LABELV $1118
line 2244
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 10
LTI4 $1117
line 2255
;2255:	}
LABELV $1112
line 2234
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1114
ADDRLP4 4
INDIRI4
ADDRFP4 8
INDIRI4
LTI4 $1111
LABELV $1113
line 2258
;2256:
;2257:	// filter out any segment that would require more steps than needed
;2258:	for (i = 0; i < numAvailable; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $1130
JUMPV
LABELV $1127
line 2262
;2259:		const efhSegmentType_t* segType;
;2260:		int j;
;2261:
;2262:		segType = available[i];
ADDRLP4 12
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRP4
ASGNP4
line 2263
;2263:		for (j = 0; j < MAX_PARALLEL_STYLES; j++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $1131
line 2266
;2264:			const efhStyleEntry_t* styleEntry;
;2265:
;2266:			styleEntry = &segType->styles[j];
ADDRLP4 16
ADDRLP4 8
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 12
INDIRP4
CNSTI4 640
ADDP4
ADDP4
ASGNP4
line 2267
;2267:			if (styleEntry->entrance != style) continue;
ADDRLP4 16
INDIRP4
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
EQU4 $1135
ADDRGP4 $1132
JUMPV
LABELV $1135
line 2269
;2268:			
;2269:			if (!styleEntry->exit) break;
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1137
ADDRGP4 $1133
JUMPV
LABELV $1137
line 2270
;2270:			if (styleEntry->exit->minStepsToFinalSegment <= minStepsNeeded) break;
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
GTI4 $1139
ADDRGP4 $1133
JUMPV
LABELV $1139
line 2271
;2271:		}
LABELV $1132
line 2263
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 10
LTI4 $1131
LABELV $1133
line 2273
;2272:
;2273:		if (j >= MAX_PARALLEL_STYLES) {
ADDRLP4 8
INDIRI4
CNSTI4 10
LTI4 $1141
line 2274
;2274:			available[i] = NULL;
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
CNSTP4 0
ASGNP4
line 2275
;2275:		}
LABELV $1141
line 2276
;2276:	}
LABELV $1128
line 2258
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1130
ADDRLP4 4
INDIRI4
ADDRFP4 8
INDIRI4
LTI4 $1127
line 2277
;2277:}
LABELV $1110
endproc FilterBestSegmentsForFinalization 20 0
proc RemoveSegment 0 12
line 2288
;2278:#endif
;2279:
;2280:/*
;2281:==============
;2282:JUHOX: RemoveSegment
;2283:==============
;2284:*/
;2285:#if ESCAPE_MODE
;2286:static void DeleteUnusedEntities(void);
;2287:
;2288:static void RemoveSegment(int segment) {
line 2289
;2289:	memcpy(&newSegmentState, &segmentState, sizeof(newSegmentState));
ADDRGP4 newSegmentState
ARGP4
ADDRGP4 segmentState
ARGP4
CNSTI4 65536
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2290
;2290:	newSegmentState[segment] = ESS_removed;
ADDRFP4 0
INDIRI4
ADDRGP4 newSegmentState
ADDP4
CNSTU1 0
ASGNU1
line 2292
;2291:
;2292:	DeleteUnusedEntities();
ADDRGP4 DeleteUnusedEntities
CALLV
pop
line 2294
;2293:
;2294:	memcpy(&segmentState, &newSegmentState, sizeof(segmentState));
ADDRGP4 segmentState
ARGP4
ADDRGP4 newSegmentState
ARGP4
CNSTI4 65536
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2295
;2295:}
LABELV $1143
endproc RemoveSegment 0 12
proc PredictWayLength 8 12
line 2304
;2296:#endif
;2297:
;2298:/*
;2299:==============
;2300:JUHOX: PredictWayLength
;2301:==============
;2302:*/
;2303:#if ESCAPE_MODE
;2304:static int PredictWayLength(const vec3_t origin, int segment) {
line 2305
;2305:	return (int) (totalWayLength[segment] + SegmentWayLength(origin, efhWorld[segment], NULL));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 efhWorld
ADDP4
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 4
ADDRGP4 SegmentWayLength
CALLU4
ASGNU4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 totalWayLength
ADDP4
INDIRU4
ADDRLP4 4
INDIRU4
ADDU4
CVUI4 4
RETI4
LABELV $1144
endproc PredictWayLength 8 12
proc ExtendWorld 2144 24
line 2315
;2306:}
;2307:#endif
;2308:
;2309:/*
;2310:==============
;2311:JUHOX: ExtendWorld
;2312:==============
;2313:*/
;2314:#if ESCAPE_MODE
;2315:static void ExtendWorld(void) {
line 2326
;2316:	int numExcluded;
;2317:	efhSegmentType_t* excluded[MAX_SEGMENTTYPES];
;2318:	int numAvailable;
;2319:	efhSegmentType_t* available[MAX_SEGMENTTYPES];
;2320:	int k;
;2321:	float totalFrequency;
;2322:	efhSegmentType_t* choosen;
;2323:	efhTransitionStyle_t* choosenStyle;
;2324:	qboolean finalization;
;2325:
;2326:	if (worldEnd >= MAX_WORLD_SEGMENTS) return;
ADDRGP4 worldEnd
INDIRI4
CNSTI4 65536
LTI4 $1146
ADDRGP4 $1145
JUMPV
LABELV $1146
line 2328
;2327:
;2328:	if (g_debugEFH.integer) {
ADDRGP4 g_debugEFH+12
INDIRI4
CNSTI4 0
EQI4 $1148
line 2329
;2329:		if (debugSegment <= 0) return;
ADDRGP4 debugSegment
INDIRI4
CNSTI4 0
GTI4 $1151
ADDRGP4 $1145
JUMPV
LABELV $1151
line 2331
;2330:
;2331:		if (debugSegment > maxSegment) {
ADDRGP4 debugSegment
INDIRI4
ADDRGP4 maxSegment
INDIRI4
LEI4 $1153
line 2332
;2332:			if (maxSegment > 0) G_EFH_NextDebugSegment(1);
ADDRGP4 maxSegment
INDIRI4
CNSTI4 0
LEI4 $1155
CNSTI4 1
ARGI4
ADDRGP4 G_EFH_NextDebugSegment
CALLV
pop
LABELV $1155
line 2333
;2333:			worldEnd++;
ADDRLP4 2076
ADDRGP4 worldEnd
ASGNP4
ADDRLP4 2076
INDIRP4
ADDRLP4 2076
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2334
;2334:			maxSegment = worldEnd;
ADDRGP4 maxSegment
ADDRGP4 worldEnd
INDIRI4
ASGNI4
line 2335
;2335:		}
ADDRGP4 $1154
JUMPV
LABELV $1153
line 2336
;2336:		else {
line 2337
;2337:			if (debugSegment != oldDebugSegment) {
ADDRGP4 debugSegment
INDIRI4
ADDRGP4 oldDebugSegment
INDIRI4
EQI4 $1157
line 2338
;2338:				debugModeChoosenSegmentType = efhWorld[debugSegment] - segmentTypes;
ADDRGP4 debugModeChoosenSegmentType
ADDRGP4 debugSegment
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 efhWorld
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 segmentTypes
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 764
DIVI4
ASGNI4
line 2339
;2339:				G_EFH_NextDebugSegment(0);
CNSTI4 0
ARGI4
ADDRGP4 G_EFH_NextDebugSegment
CALLV
pop
line 2340
;2340:			}
LABELV $1157
line 2341
;2341:			if (efhWorld[debugSegment] != &segmentTypes[debugModeChoosenSegmentType]) {
ADDRGP4 debugSegment
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 efhWorld
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 debugModeChoosenSegmentType
INDIRI4
CNSTI4 764
MULI4
ADDRGP4 segmentTypes
ADDP4
CVPU4 4
EQU4 $1159
line 2345
;2342:				int i;
;2343:				vec3_t delta;
;2344:
;2345:				for (i = debugSegment; i <= maxSegment; i++) {
ADDRLP4 2088
ADDRGP4 debugSegment
INDIRI4
ASGNI4
ADDRGP4 $1164
JUMPV
LABELV $1161
line 2346
;2346:					RemoveSegment(i);
ADDRLP4 2088
INDIRI4
ARGI4
ADDRGP4 RemoveSegment
CALLV
pop
line 2347
;2347:				}
LABELV $1162
line 2345
ADDRLP4 2088
ADDRLP4 2088
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1164
ADDRLP4 2088
INDIRI4
ADDRGP4 maxSegment
INDIRI4
LEI4 $1161
line 2349
;2348:
;2349:				if (currentSegment > debugSegment) {
ADDRGP4 currentSegment
INDIRI4
ADDRGP4 debugSegment
INDIRI4
LEI4 $1165
line 2350
;2350:					currentSegmentOrigin.x += segmentTypes[debugModeChoosenSegmentType].exitDelta.x - efhWorld[debugSegment]->exitDelta.x;
ADDRLP4 2092
ADDRGP4 currentSegmentOrigin
ASGNP4
ADDRLP4 2092
INDIRP4
ADDRLP4 2092
INDIRP4
INDIRI4
ADDRGP4 debugModeChoosenSegmentType
INDIRI4
CNSTI4 764
MULI4
ADDRGP4 segmentTypes+568
ADDP4
INDIRI4
ADDRGP4 debugSegment
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 efhWorld
ADDP4
INDIRP4
CNSTI4 568
ADDP4
INDIRI4
SUBI4
ADDI4
ASGNI4
line 2351
;2351:					currentSegmentOrigin.y += segmentTypes[debugModeChoosenSegmentType].exitDelta.y - efhWorld[debugSegment]->exitDelta.y;
ADDRLP4 2096
ADDRGP4 currentSegmentOrigin+4
ASGNP4
ADDRLP4 2096
INDIRP4
ADDRLP4 2096
INDIRP4
INDIRI4
ADDRGP4 debugModeChoosenSegmentType
INDIRI4
CNSTI4 764
MULI4
ADDRGP4 segmentTypes+568+4
ADDP4
INDIRI4
ADDRGP4 debugSegment
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 efhWorld
ADDP4
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
SUBI4
ADDI4
ASGNI4
line 2352
;2352:					currentSegmentOrigin.z += segmentTypes[debugModeChoosenSegmentType].exitDelta.z - efhWorld[debugSegment]->exitDelta.z;
ADDRLP4 2100
ADDRGP4 currentSegmentOrigin+8
ASGNP4
ADDRLP4 2100
INDIRP4
ADDRLP4 2100
INDIRP4
INDIRI4
ADDRGP4 debugModeChoosenSegmentType
INDIRI4
CNSTI4 764
MULI4
ADDRGP4 segmentTypes+568+8
ADDP4
INDIRI4
ADDRGP4 debugSegment
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 efhWorld
ADDP4
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
SUBI4
ADDI4
ASGNI4
line 2353
;2353:				}
LABELV $1165
line 2355
;2354:
;2355:				delta[0] = segmentTypes[debugModeChoosenSegmentType].exitDelta.x - efhWorld[debugSegment]->exitDelta.x;
ADDRLP4 2076
ADDRGP4 debugModeChoosenSegmentType
INDIRI4
CNSTI4 764
MULI4
ADDRGP4 segmentTypes+568
ADDP4
INDIRI4
ADDRGP4 debugSegment
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 efhWorld
ADDP4
INDIRP4
CNSTI4 568
ADDP4
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 2356
;2356:				delta[1] = segmentTypes[debugModeChoosenSegmentType].exitDelta.y - efhWorld[debugSegment]->exitDelta.y;
ADDRLP4 2076+4
ADDRGP4 debugModeChoosenSegmentType
INDIRI4
CNSTI4 764
MULI4
ADDRGP4 segmentTypes+568+4
ADDP4
INDIRI4
ADDRGP4 debugSegment
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 efhWorld
ADDP4
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 2357
;2357:				delta[2] = segmentTypes[debugModeChoosenSegmentType].exitDelta.z - efhWorld[debugSegment]->exitDelta.z;
ADDRLP4 2076+8
ADDRGP4 debugModeChoosenSegmentType
INDIRI4
CNSTI4 764
MULI4
ADDRGP4 segmentTypes+568+8
ADDP4
INDIRI4
ADDRGP4 debugSegment
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 efhWorld
ADDP4
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 2359
;2358:
;2359:				for (i = 0; i < level.maxclients; i++) {
ADDRLP4 2088
CNSTI4 0
ASGNI4
ADDRGP4 $1184
JUMPV
LABELV $1181
line 2363
;2360:					gentity_t* ent;
;2361:					playerState_t* ps;
;2362:
;2363:					if (level.clients[i].pers.connected != CON_CONNECTED) continue;
ADDRLP4 2088
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $1186
ADDRGP4 $1182
JUMPV
LABELV $1186
line 2365
;2364:
;2365:					ent = &g_entities[i];
ADDRLP4 2092
ADDRLP4 2088
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 2366
;2366:					if (ent->worldSegment - 1 < debugSegment) continue;
ADDRLP4 2092
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 1
SUBI4
ADDRGP4 debugSegment
INDIRI4
GEI4 $1188
ADDRGP4 $1182
JUMPV
LABELV $1188
line 2368
;2367:
;2368:					VectorAdd(ent->s.pos.trBase, delta, ent->s.pos.trBase);
ADDRLP4 2092
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 2092
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 2076
INDIRF4
ADDF4
ASGNF4
ADDRLP4 2092
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 2092
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 2076+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 2092
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 2092
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 2076+8
INDIRF4
ADDF4
ASGNF4
line 2369
;2369:					VectorAdd(ent->r.currentOrigin, delta, ent->r.currentOrigin);
ADDRLP4 2092
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 2092
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 2076
INDIRF4
ADDF4
ASGNF4
ADDRLP4 2092
INDIRP4
CNSTI4 492
ADDP4
ADDRLP4 2092
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 2076+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 2092
INDIRP4
CNSTI4 496
ADDP4
ADDRLP4 2092
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRLP4 2076+8
INDIRF4
ADDF4
ASGNF4
line 2371
;2370:
;2371:					ps = G_GetEntityPlayerState(ent);
ADDRLP4 2092
INDIRP4
ARGP4
ADDRLP4 2124
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 2096
ADDRLP4 2124
INDIRP4
ASGNP4
line 2372
;2372:					if (ps) {
ADDRLP4 2096
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1194
line 2373
;2373:						VectorAdd(ps->origin, delta, ps->origin);
ADDRLP4 2096
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 2096
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 2076
INDIRF4
ADDF4
ASGNF4
ADDRLP4 2096
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 2096
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 2076+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 2096
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 2096
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 2076+8
INDIRF4
ADDF4
ASGNF4
line 2375
;2374:
;2375:						ps->eFlags ^= EF_TELEPORT_BIT;
ADDRLP4 2140
ADDRLP4 2096
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 2140
INDIRP4
ADDRLP4 2140
INDIRP4
INDIRI4
CNSTI4 4
BXORI4
ASGNI4
line 2376
;2376:					}
LABELV $1194
line 2378
;2377:
;2378:					trap_LinkEntity(ent);
ADDRLP4 2092
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 2379
;2379:				}
LABELV $1182
line 2359
ADDRLP4 2088
ADDRLP4 2088
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1184
ADDRLP4 2088
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $1181
line 2380
;2380:			}
LABELV $1159
line 2381
;2381:		}
LABELV $1154
line 2382
;2382:		efhWorld[debugSegment] = &segmentTypes[debugModeChoosenSegmentType];
ADDRGP4 debugSegment
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 efhWorld
ADDP4
ADDRGP4 debugModeChoosenSegmentType
INDIRI4
CNSTI4 764
MULI4
ADDRGP4 segmentTypes
ADDP4
ASGNP4
line 2383
;2383:		oldDebugSegment = debugSegment;
ADDRGP4 oldDebugSegment
ADDRGP4 debugSegment
INDIRI4
ASGNI4
line 2384
;2384:		return;
ADDRGP4 $1145
JUMPV
LABELV $1148
line 2387
;2385:	}
;2386:
;2387:	finalization = (
ADDRGP4 g_distanceLimit+12
INDIRI4
CNSTI4 0
LEI4 $1201
ADDRGP4 worldWayLength
INDIRU4
CNSTI4 5
RSHU4
ADDRGP4 g_distanceLimit+12
INDIRI4
CVIU4 4
LTU4 $1201
ADDRLP4 2076
CNSTI4 1
ASGNI4
ADDRGP4 $1202
JUMPV
LABELV $1201
ADDRLP4 2076
CNSTI4 0
ASGNI4
LABELV $1202
ADDRLP4 8
ADDRLP4 2076
INDIRI4
ASGNI4
line 2392
;2388:		g_distanceLimit.integer > 0 &&
;2389:		worldWayLength / 32 >= g_distanceLimit.integer
;2390:	);
;2391:
;2392:	numExcluded = GetExcludedSegmentTypes(worldEnd - 1, excluded);
ADDRGP4 worldEnd
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRLP4 1052
ARGP4
ADDRLP4 2080
ADDRGP4 GetExcludedSegmentTypes
CALLI4
ASGNI4
ADDRLP4 1048
ADDRLP4 2080
INDIRI4
ASGNI4
line 2393
;2393:	numAvailable = GetAvailableSegmentTypes(
ADDRGP4 worldEnd
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRGP4 worldStyle
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 1052
ARGP4
ADDRLP4 1048
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRLP4 2084
ADDRGP4 GetAvailableSegmentTypes
CALLI4
ASGNI4
ADDRLP4 1044
ADDRLP4 2084
INDIRI4
ASGNI4
line 2396
;2394:		worldEnd - 1, worldStyle, finalization, excluded, numExcluded, available
;2395:	);
;2396:	if (finalization) {
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $1203
line 2397
;2397:		FilterBestSegmentsForFinalization(worldStyle, available, numAvailable);
ADDRGP4 worldStyle
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 1044
INDIRI4
ARGI4
ADDRGP4 FilterBestSegmentsForFinalization
CALLV
pop
line 2398
;2398:	}
LABELV $1203
line 2401
;2399:
;2400:	// randomly choose among the available segments
;2401:	totalFrequency = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 2402
;2402:	choosen = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 2403
;2403:	choosenStyle = NULL;
ADDRLP4 1040
CNSTP4 0
ASGNP4
line 2404
;2404:	for (k = 0; k < numAvailable; k++) {
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 $1208
JUMPV
LABELV $1205
line 2408
;2405:		const efhSegmentType_t* type;
;2406:		int s;
;2407:
;2408:		type = available[k];
ADDRLP4 2092
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
ADDP4
INDIRP4
ASGNP4
line 2409
;2409:		if (!type) continue;
ADDRLP4 2092
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1209
ADDRGP4 $1206
JUMPV
LABELV $1209
line 2411
;2410:
;2411:		for (s = 0; s < MAX_PARALLEL_STYLES; s++) {
ADDRLP4 2088
CNSTI4 0
ASGNI4
LABELV $1211
line 2414
;2412:			const efhStyleEntry_t* se;
;2413:
;2414:			se = &type->styles[s];
ADDRLP4 2096
ADDRLP4 2088
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 2092
INDIRP4
CNSTI4 640
ADDP4
ADDP4
ASGNP4
line 2415
;2415:			if (se->frequency <= 0) continue;
ADDRLP4 2096
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 0
GTF4 $1215
ADDRGP4 $1212
JUMPV
LABELV $1215
line 2418
;2416:			//if (!IsStyleEntryValid(type, se)) continue;
;2417:
;2418:			if (worldStyle && se->entrance != worldStyle) continue;
ADDRLP4 2100
ADDRGP4 worldStyle
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 2100
INDIRU4
CNSTU4 0
EQU4 $1217
ADDRLP4 2096
INDIRP4
INDIRP4
CVPU4 4
ADDRLP4 2100
INDIRU4
EQU4 $1217
ADDRGP4 $1212
JUMPV
LABELV $1217
line 2419
;2419:			if (!finalization) {
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $1219
line 2420
;2420:				if (!se->exit) continue;
ADDRLP4 2096
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1221
ADDRGP4 $1212
JUMPV
LABELV $1221
line 2421
;2421:				if (se->exit->reachability < REACH_loopable) continue;
ADDRLP4 2096
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 2
GEI4 $1223
ADDRGP4 $1212
JUMPV
LABELV $1223
line 2422
;2422:			}
LABELV $1219
line 2424
;2423:
;2424:			totalFrequency += se->frequency;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 2096
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
ASGNF4
line 2425
;2425:			if (local_random(&worldCreationSeed) * totalFrequency < se->frequency || !choosen) {
ADDRGP4 worldCreationSeed
ARGP4
ADDRLP4 2104
ADDRGP4 local_random
CALLF4
ASGNF4
ADDRLP4 2104
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDRLP4 2096
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
LTF4 $1227
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1225
LABELV $1227
line 2426
;2426:				choosen = available[k];
ADDRLP4 4
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
ADDP4
INDIRP4
ASGNP4
line 2427
;2427:				choosenStyle = se->exit;
ADDRLP4 1040
ADDRLP4 2096
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ASGNP4
line 2428
;2428:			}
LABELV $1225
line 2429
;2429:		}
LABELV $1212
line 2411
ADDRLP4 2088
ADDRLP4 2088
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 2088
INDIRI4
CNSTI4 10
LTI4 $1211
line 2430
;2430:	}
LABELV $1206
line 2404
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1208
ADDRLP4 12
INDIRI4
ADDRLP4 1044
INDIRI4
LTI4 $1205
line 2432
;2431:
;2432:	if (!choosen) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1228
line 2433
;2433:		G_Printf("latest generated segments:\n");
ADDRGP4 $1230
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 2434
;2434:		for (k = 0; k < 15; k++) {
ADDRLP4 12
CNSTI4 0
ASGNI4
LABELV $1231
line 2437
;2435:			int i;
;2436:
;2437:			i = worldEnd - 15 + k;
ADDRLP4 2088
ADDRGP4 worldEnd
INDIRI4
CNSTI4 15
SUBI4
ADDRLP4 12
INDIRI4
ADDI4
ASGNI4
line 2438
;2438:			if (i < 0) continue;
ADDRLP4 2088
INDIRI4
CNSTI4 0
GEI4 $1235
ADDRGP4 $1232
JUMPV
LABELV $1235
line 2440
;2439:
;2440:			G_Printf("#%d: %s\n", i, SegmentName(efhWorld[i]));
ADDRLP4 2088
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 efhWorld
ADDP4
INDIRP4
ARGP4
ADDRLP4 2092
ADDRGP4 SegmentName
CALLP4
ASGNP4
ADDRGP4 $1237
ARGP4
ADDRLP4 2088
INDIRI4
ARGI4
ADDRLP4 2092
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 2441
;2441:		}
LABELV $1232
line 2434
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 15
LTI4 $1231
line 2442
;2442:		G_Error(
ADDRGP4 $1238
ARGP4
ADDRGP4 worldStyle
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1243
ADDRLP4 2088
ADDRGP4 worldStyle
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRGP4 $1244
JUMPV
LABELV $1243
ADDRLP4 2088
ADDRGP4 $1100
ASGNP4
LABELV $1244
ADDRLP4 2088
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $1245
ADDRLP4 2092
ADDRGP4 $1240
ASGNP4
ADDRGP4 $1246
JUMPV
LABELV $1245
ADDRLP4 2092
ADDRGP4 $1241
ASGNP4
LABELV $1246
ADDRLP4 2092
INDIRP4
ARGP4
ADDRLP4 1048
INDIRI4
ARGI4
ADDRLP4 1044
INDIRI4
ARGI4
ADDRGP4 G_Error
CALLV
pop
line 2448
;2443:			"^1ExtendWorld: No segments fit.\n"
;2444:			"worldStyle=%s, finalization=%s, numExcluded=%d, numAvaliable=%d",
;2445:			worldStyle? worldStyle->name : "<none>", finalization? "true" : "false",
;2446:			numExcluded, numAvailable
;2447:		);
;2448:	}
LABELV $1228
line 2450
;2449:
;2450:	efhWorld[worldEnd] = choosen;
ADDRGP4 worldEnd
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 efhWorld
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 2452
;2451:
;2452:	worldStyle = choosenStyle;
ADDRGP4 worldStyle
ADDRLP4 1040
INDIRP4
ASGNP4
line 2453
;2453:	if (worldEnd > 0) {
ADDRGP4 worldEnd
INDIRI4
CNSTI4 0
LEI4 $1247
line 2454
;2454:		totalWayLength[worldEnd] = worldWayLength;
ADDRGP4 worldEnd
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 totalWayLength
ADDP4
ADDRGP4 worldWayLength
INDIRU4
ASGNU4
line 2455
;2455:		worldWayLength += choosen->wayLength;
ADDRLP4 2088
ADDRGP4 worldWayLength
ASGNP4
ADDRLP4 2088
INDIRP4
ADDRLP4 2088
INDIRP4
INDIRU4
ADDRLP4 4
INDIRP4
CNSTI4 520
ADDP4
INDIRU4
ADDU4
ASGNU4
line 2456
;2456:	}
LABELV $1247
line 2458
;2457:
;2458:	maxSegment = worldEnd;
ADDRGP4 maxSegment
ADDRGP4 worldEnd
INDIRI4
ASGNI4
line 2459
;2459:	worldEnd++;
ADDRLP4 2088
ADDRGP4 worldEnd
ASGNP4
ADDRLP4 2088
INDIRP4
ADDRLP4 2088
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2461
;2460:
;2461:	if (choosen->final) {
ADDRLP4 4
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1249
line 2462
;2462:		level.efhGoalDistance = PredictWayLength(choosen->goalTemplate->s.origin, maxSegment) / 32;
ADDRLP4 4
INDIRP4
CNSTI4 580
ADDP4
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRGP4 maxSegment
INDIRI4
ARGI4
ADDRLP4 2092
ADDRGP4 PredictWayLength
CALLI4
ASGNI4
ADDRGP4 level+23048
ADDRLP4 2092
INDIRI4
CNSTI4 32
DIVI4
ASGNI4
line 2463
;2463:		trap_SetConfigstring(CS_EFH_GOAL_DISTANCE, va("%d", level.efhGoalDistance));
ADDRGP4 $1252
ARGP4
ADDRGP4 level+23048
INDIRI4
ARGI4
ADDRLP4 2096
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 718
ARGI4
ADDRLP4 2096
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 2464
;2464:		worldEnd = MAX_WORLD_SEGMENTS;
ADDRGP4 worldEnd
CNSTI4 65536
ASGNI4
line 2465
;2465:	}
LABELV $1249
line 2466
;2466:}
LABELV $1145
endproc ExtendWorld 2144 24
proc CreateWorld 8 12
line 2475
;2467:#endif
;2468:
;2469:/*
;2470:==============
;2471:JUHOX: CreateWorld
;2472:==============
;2473:*/
;2474:#if ESCAPE_MODE
;2475:static void CreateWorld(void) {
line 2478
;2476:	int i;
;2477:
;2478:	if (g_gametype.integer != GT_EFH) return;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
EQI4 $1255
ADDRGP4 $1254
JUMPV
LABELV $1255
line 2480
;2479:
;2480:	G_Printf("CreateWorld...\n");
ADDRGP4 $1258
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 2489
;2481:
;2482:	/*
;2483:	if (!initialSegmentType) {
;2484:		G_Error("^1CreateWorld: no initial segment found");
;2485:		initialSegmentType = &segmentTypes[0];
;2486:	}
;2487:	*/
;2488:
;2489:	if (numTransitionStyles <= 0) {
ADDRGP4 numTransitionStyles
INDIRI4
CNSTI4 0
GTI4 $1259
line 2490
;2490:		G_Error("^1CreateWorld: no styles found");
ADDRGP4 $1261
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 2491
;2491:	}
LABELV $1259
line 2493
;2492:
;2493:	G_Printf("available styles:\n");
ADDRGP4 $1262
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 2494
;2494:	for (i = 0; i < numTransitionStyles; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1266
JUMPV
LABELV $1263
line 2495
;2495:		G_Printf("   %s\n", transitionStyles[i].name);
ADDRGP4 $1267
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 transitionStyles+12
ADDP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 2496
;2496:	}
LABELV $1264
line 2494
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1266
ADDRLP4 0
INDIRI4
ADDRGP4 numTransitionStyles
INDIRI4
LTI4 $1263
line 2497
;2497:	G_Printf("---------\n");
ADDRGP4 $1269
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 2499
;2498:
;2499:	if (!g_debugEFH.integer) {
ADDRGP4 g_debugEFH+12
INDIRI4
CNSTI4 0
NEI4 $1270
line 2500
;2500:		memset(&efhWorld, 0, sizeof(efhWorld));
ADDRGP4 efhWorld
ARGP4
CNSTI4 0
ARGI4
CNSTI4 262144
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2501
;2501:	}
ADDRGP4 $1271
JUMPV
LABELV $1270
line 2502
;2502:	else {
line 2503
;2503:		for (i = 0; i < MAX_WORLD_SEGMENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1273
line 2504
;2504:			efhWorld[i] = &segmentTypes[0];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 efhWorld
ADDP4
ADDRGP4 segmentTypes
ASGNP4
line 2505
;2505:		}
LABELV $1274
line 2503
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 65536
LTI4 $1273
line 2506
;2506:	}
LABELV $1271
line 2508
;2507:
;2508:	monsterSpawnSeed = SeededRandom(GST_worldCreation);
CNSTI4 5
ARGI4
ADDRLP4 4
ADDRGP4 SeededRandom
CALLU4
ASGNU4
ADDRGP4 monsterSpawnSeed
ADDRLP4 4
INDIRU4
ASGNU4
line 2510
;2509:
;2510:	InitLocalSeed(GST_worldCreation, &worldCreationSeed);
CNSTI4 5
ARGI4
ADDRGP4 worldCreationSeed
ARGP4
ADDRGP4 InitLocalSeed
CALLV
pop
line 2512
;2511:
;2512:	worldEnd = 0;
ADDRGP4 worldEnd
CNSTI4 0
ASGNI4
line 2513
;2513:	worldStyle = NULL;
ADDRGP4 worldStyle
CNSTP4 0
ASGNP4
line 2515
;2514:
;2515:	totalWayLength[0] = 0;
ADDRGP4 totalWayLength
CNSTU4 0
ASGNU4
line 2516
;2516:	worldWayLength = 0;
ADDRGP4 worldWayLength
CNSTU4 0
ASGNU4
line 2517
;2517:	maxSegment = 0;
ADDRGP4 maxSegment
CNSTI4 0
ASGNI4
line 2518
;2518:	numFallbacks = 0;
ADDRGP4 numFallbacks
CNSTI4 0
ASGNI4
line 2521
;2519:
;2520:	// create just enough world segments so clients can spawn
;2521:	for (i = 0; i < 100; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1277
line 2522
;2522:		ExtendWorld();
ADDRGP4 ExtendWorld
CALLV
pop
line 2523
;2523:	}
LABELV $1278
line 2521
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 100
LTI4 $1277
line 2524
;2524:}
LABELV $1254
endproc CreateWorld 8 12
proc GetSpaceExtent 84 28
line 2533
;2525:#endif
;2526:
;2527:/*
;2528:==============
;2529:JUHOX: GetSpaceExtent
;2530:==============
;2531:*/
;2532:#if ESCAPE_MODE
;2533:static void GetSpaceExtent(void) {
line 2538
;2534:	trace_t trace;
;2535:	vec3_t start;
;2536:	vec3_t end;
;2537:
;2538:	VectorClear(start);
ADDRLP4 80
CNSTF4 0
ASGNF4
ADDRLP4 12+8
ADDRLP4 80
INDIRF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 80
INDIRF4
ASGNF4
ADDRLP4 12
ADDRLP4 80
INDIRF4
ASGNF4
line 2539
;2539:	VectorCopy(start, end);
ADDRLP4 0
ADDRLP4 12
INDIRB
ASGNB 12
line 2540
;2540:	end[0] = -1000000;
ADDRLP4 0
CNSTF4 3379831808
ASGNF4
line 2541
;2541:	trap_Trace(&trace, start, NULL, NULL, end, -1, CONTENTS_SOLID);
ADDRLP4 24
ARGP4
ADDRLP4 12
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 2542
;2542:	efhSpaceMins[0] = trace.endpos[0];
ADDRGP4 efhSpaceMins
ADDRLP4 24+12
INDIRF4
ASGNF4
line 2544
;2543:
;2544:	end[0] = +1000000;
ADDRLP4 0
CNSTF4 1232348160
ASGNF4
line 2545
;2545:	trap_Trace(&trace, start, NULL, NULL, end, -1, CONTENTS_SOLID);
ADDRLP4 24
ARGP4
ADDRLP4 12
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 2546
;2546:	efhSpaceMaxs[0] = trace.endpos[0];
ADDRGP4 efhSpaceMaxs
ADDRLP4 24+12
INDIRF4
ASGNF4
line 2548
;2547:
;2548:	start[0] = efhSpaceMins[0] + 1;
ADDRLP4 12
ADDRGP4 efhSpaceMins
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2549
;2549:	VectorCopy(start, end);
ADDRLP4 0
ADDRLP4 12
INDIRB
ASGNB 12
line 2550
;2550:	end[1] = -1000000;
ADDRLP4 0+4
CNSTF4 3379831808
ASGNF4
line 2551
;2551:	trap_Trace(&trace, start, NULL, NULL, end, -1, CONTENTS_SOLID);
ADDRLP4 24
ARGP4
ADDRLP4 12
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 2552
;2552:	efhSpaceMins[1] = trace.endpos[1];
ADDRGP4 efhSpaceMins+4
ADDRLP4 24+12+4
INDIRF4
ASGNF4
line 2554
;2553:
;2554:	end[1] = +1000000;
ADDRLP4 0+4
CNSTF4 1232348160
ASGNF4
line 2555
;2555:	trap_Trace(&trace, start, NULL, NULL, end, -1, CONTENTS_SOLID);
ADDRLP4 24
ARGP4
ADDRLP4 12
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 2556
;2556:	efhSpaceMaxs[1] = trace.endpos[1];
ADDRGP4 efhSpaceMaxs+4
ADDRLP4 24+12+4
INDIRF4
ASGNF4
line 2558
;2557:
;2558:	start[1] = efhSpaceMins[1] + 1;
ADDRLP4 12+4
ADDRGP4 efhSpaceMins+4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2559
;2559:	VectorCopy(start, end);
ADDRLP4 0
ADDRLP4 12
INDIRB
ASGNB 12
line 2560
;2560:	end[2] = -1000000;
ADDRLP4 0+8
CNSTF4 3379831808
ASGNF4
line 2561
;2561:	trap_Trace(&trace, start, NULL, NULL, end, -1, CONTENTS_SOLID);
ADDRLP4 24
ARGP4
ADDRLP4 12
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 2562
;2562:	efhSpaceMins[2] = trace.endpos[2];
ADDRGP4 efhSpaceMins+8
ADDRLP4 24+12+8
INDIRF4
ASGNF4
line 2564
;2563:
;2564:	end[2] = +1000000;
ADDRLP4 0+8
CNSTF4 1232348160
ASGNF4
line 2565
;2565:	trap_Trace(&trace, start, NULL, NULL, end, -1, CONTENTS_SOLID);
ADDRLP4 24
ARGP4
ADDRLP4 12
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 2566
;2566:	efhSpaceMaxs[2] = trace.endpos[2];
ADDRGP4 efhSpaceMaxs+8
ADDRLP4 24+12+8
INDIRF4
ASGNF4
line 2567
;2567:}
LABELV $1281
endproc GetSpaceExtent 84 28
export G_SpawnEntitiesFromString
proc G_SpawnEntitiesFromString 8 4
line 2577
;2568:#endif
;2569:
;2570:/*
;2571:==============
;2572:G_SpawnEntitiesFromString
;2573:
;2574:Parses textual entity definitions out of an entstring and spawns gentities.
;2575:==============
;2576:*/
;2577:void G_SpawnEntitiesFromString( void ) {
line 2579
;2578:	// allow calls to G_Spawn*()
;2579:	level.spawning = qtrue;
ADDRGP4 level+4520
CNSTI4 1
ASGNI4
line 2580
;2580:	level.numSpawnVars = 0;
ADDRGP4 level+4524
CNSTI4 0
ASGNI4
line 2583
;2581:
;2582:#if ESCAPE_MODE	// JUHOX: get efh space extent
;2583:	if (g_gametype.integer == GT_EFH) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
NEI4 $1307
line 2584
;2584:		GetSpaceExtent();
ADDRGP4 GetSpaceExtent
CALLV
pop
line 2585
;2585:	}
LABELV $1307
line 2591
;2586:#endif
;2587:
;2588:	// the worldspawn is not an actual entity, but it still
;2589:	// has a "spawn" function to perform any global setup
;2590:	// needed by a level (setting configstrings or cvars, etc)
;2591:	if ( !G_ParseSpawnVars() ) {
ADDRLP4 0
ADDRGP4 G_ParseSpawnVars
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1310
line 2592
;2592:		G_Error( "SpawnEntities: no entities" );
ADDRGP4 $1312
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 2593
;2593:	}
LABELV $1310
line 2594
;2594:	SP_worldspawn();
ADDRGP4 SP_worldspawn
CALLV
pop
ADDRGP4 $1314
JUMPV
LABELV $1313
line 2597
;2595:
;2596:	// parse ents
;2597:	while( G_ParseSpawnVars() ) {
line 2598
;2598:		G_SpawnGEntityFromSpawnVars();
ADDRGP4 G_SpawnGEntityFromSpawnVars
CALLV
pop
line 2599
;2599:	}
LABELV $1314
line 2597
ADDRLP4 4
ADDRGP4 G_ParseSpawnVars
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1313
line 2601
;2600:
;2601:	SetGameSeed();	// JUHOX
ADDRGP4 SetGameSeed
CALLV
pop
line 2604
;2602:
;2603:#if ESCAPE_MODE	// JUHOX: spawn EFH world
;2604:	if (g_gametype.integer == GT_EFH) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
NEI4 $1316
line 2605
;2605:		BuildSegments();
ADDRGP4 BuildSegments
CALLV
pop
line 2606
;2606:		CreateWorld();
ADDRGP4 CreateWorld
CALLV
pop
line 2607
;2607:		if (g_debugEFH.integer) G_EFH_NextDebugSegment(0);
ADDRGP4 g_debugEFH+12
INDIRI4
CNSTI4 0
EQI4 $1319
CNSTI4 0
ARGI4
ADDRGP4 G_EFH_NextDebugSegment
CALLV
pop
LABELV $1319
line 2608
;2608:	}
LABELV $1316
line 2611
;2609:#endif
;2610:
;2611:	level.spawning = qfalse;			// any future calls to G_Spawn*() will be errors
ADDRGP4 level+4520
CNSTI4 0
ASGNI4
line 2612
;2612:}
LABELV $1304
endproc G_SpawnEntitiesFromString 8 4
export G_InitWorldSystem
proc G_InitWorldSystem 16 12
line 2620
;2613:
;2614:/*
;2615:==============
;2616:JUHOX: G_InitWorldSystem
;2617:==============
;2618:*/
;2619:#if ESCAPE_MODE
;2620:void G_InitWorldSystem(void) {
line 2623
;2621:	int i;
;2622:
;2623:	VectorClear(efhSpaceMins);
ADDRLP4 4
CNSTF4 0
ASGNF4
ADDRGP4 efhSpaceMins+8
ADDRLP4 4
INDIRF4
ASGNF4
ADDRGP4 efhSpaceMins+4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRGP4 efhSpaceMins
ADDRLP4 4
INDIRF4
ASGNF4
line 2624
;2624:	VectorClear(efhSpaceMaxs);
ADDRLP4 8
CNSTF4 0
ASGNF4
ADDRGP4 efhSpaceMaxs+8
ADDRLP4 8
INDIRF4
ASGNF4
ADDRGP4 efhSpaceMaxs+4
ADDRLP4 8
INDIRF4
ASGNF4
ADDRGP4 efhSpaceMaxs
ADDRLP4 8
INDIRF4
ASGNF4
line 2625
;2625:	numEntityTemplates = 0;
ADDRGP4 numEntityTemplates
CNSTI4 0
ASGNI4
line 2626
;2626:	numSegmentTypes = 0;
ADDRGP4 numSegmentTypes
CNSTI4 0
ASGNI4
line 2627
;2627:	maxSegment = -1;
ADDRGP4 maxSegment
CNSTI4 -1
ASGNI4
line 2628
;2628:	currentSegment = 0;
ADDRGP4 currentSegment
CNSTI4 0
ASGNI4
line 2629
;2629:	currentSegmentOrigin.x = 0;
ADDRGP4 currentSegmentOrigin
CNSTI4 0
ASGNI4
line 2630
;2630:	currentSegmentOrigin.y = 0;
ADDRGP4 currentSegmentOrigin+4
CNSTI4 0
ASGNI4
line 2631
;2631:	currentSegmentOrigin.z = 0;
ADDRGP4 currentSegmentOrigin+8
CNSTI4 0
ASGNI4
line 2632
;2632:	memset(&entityTemplates, 0, sizeof(entityTemplates));
ADDRGP4 entityTemplates
ARGP4
CNSTI4 0
ARGI4
CNSTI4 3457024
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2633
;2633:	memset(&segmentTypes, 0, sizeof(segmentTypes));
ADDRGP4 segmentTypes
ARGP4
CNSTI4 0
ARGI4
CNSTI4 196348
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2634
;2634:	segmentTypes[MAX_SEGMENTTYPES].name = "<void>";
ADDRGP4 segmentTypes+195584+632
ADDRGP4 $1332
ASGNP4
line 2635
;2635:	segmentTypes[MAX_SEGMENTTYPES].exitDelta.x = 100000;
ADDRGP4 segmentTypes+195584+568
CNSTI4 100000
ASGNI4
line 2636
;2636:	memset(&segmentState, ESS_removed, sizeof(segmentState));
ADDRGP4 segmentState
ARGP4
CNSTI4 0
ARGI4
CNSTI4 65536
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2637
;2637:	memset(&visitedSegments, 0, sizeof(visitedSegments));
ADDRGP4 visitedSegments
ARGP4
CNSTI4 0
ARGI4
CNSTI4 8192
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2638
;2638:	memset(&cachedMonsters, 0, sizeof(cachedMonsters));
ADDRGP4 cachedMonsters
ARGP4
CNSTI4 0
ARGI4
CNSTI4 57344
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2639
;2639:	memset(&efhWorld, 0, sizeof(efhWorld));
ADDRGP4 efhWorld
ARGP4
CNSTI4 0
ARGI4
CNSTI4 262144
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2640
;2640:	for (i = 0; i < MAX_CACHED_MONSTERS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1335
line 2643
;2641:		efhCachedMonster_t* cache;
;2642:
;2643:		cache = &cachedMonsters[i];
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 56
MULI4
ADDRGP4 cachedMonsters
ADDP4
ASGNP4
line 2644
;2644:		ClearMonsterCache(cache);
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 ClearMonsterCache
CALLV
pop
line 2645
;2645:	}
LABELV $1336
line 2640
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1024
LTI4 $1335
line 2646
;2646:	numTransitionStyles = 0;
ADDRGP4 numTransitionStyles
CNSTI4 0
ASGNI4
line 2647
;2647:	memset(&transitionStyles, 0, sizeof(transitionStyles));
ADDRGP4 transitionStyles
ARGP4
CNSTI4 0
ARGI4
CNSTI4 4400
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2648
;2648:	debugSegment = 1;
ADDRGP4 debugSegment
CNSTI4 1
ASGNI4
line 2649
;2649:	oldDebugSegment = 1;
ADDRGP4 oldDebugSegment
CNSTI4 1
ASGNI4
line 2650
;2650:	debugModeChoosenSegmentType = 0;
ADDRGP4 debugModeChoosenSegmentType
CNSTI4 0
ASGNI4
line 2651
;2651:	trap_SetConfigstring(CS_EFH_GOAL_DISTANCE, "0");
CNSTI4 718
ARGI4
ADDRGP4 $325
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 2652
;2652:}
LABELV $1323
endproc G_InitWorldSystem 16 12
proc GetTransitionStyleFromName 16 12
line 2661
;2653:#endif
;2654:
;2655:/*
;2656:==============
;2657:JUHOX: GetTransitionStyleFromName
;2658:==============
;2659:*/
;2660:#if ESCAPE_MODE
;2661:static efhTransitionStyle_t* GetTransitionStyleFromName(const char* name) {
line 2665
;2662:	int i;
;2663:	efhTransitionStyle_t* style;
;2664:
;2665:	if (!name[0]) return NULL;
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1340
CNSTP4 0
RETP4
ADDRGP4 $1339
JUMPV
LABELV $1340
line 2667
;2666:
;2667:	for (i = 0; i < numTransitionStyles; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1345
JUMPV
LABELV $1342
line 2668
;2668:		style = &transitionStyles[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 transitionStyles
ADDP4
ASGNP4
line 2669
;2669:		if (!Q_stricmp(style->name, name)) {
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $1346
line 2670
;2670:			return style;
ADDRLP4 4
INDIRP4
RETP4
ADDRGP4 $1339
JUMPV
LABELV $1346
line 2672
;2671:		}
;2672:	}
LABELV $1343
line 2667
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1345
ADDRLP4 0
INDIRI4
ADDRGP4 numTransitionStyles
INDIRI4
LTI4 $1342
line 2673
;2673:	if (numTransitionStyles >= MAX_STYLES) {
ADDRGP4 numTransitionStyles
INDIRI4
CNSTI4 100
LTI4 $1348
line 2674
;2674:		G_Error("^1GetTransitionStyleFromName: too many styles (>%d)", MAX_STYLES);
ADDRGP4 $1350
ARGP4
CNSTI4 100
ARGI4
ADDRGP4 G_Error
CALLV
pop
line 2675
;2675:		return 0;
CNSTP4 0
RETP4
ADDRGP4 $1339
JUMPV
LABELV $1348
line 2677
;2676:	}
;2677:	style = &transitionStyles[numTransitionStyles++];
ADDRLP4 12
ADDRGP4 numTransitionStyles
ASGNP4
ADDRLP4 8
ADDRLP4 12
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRP4
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 transitionStyles
ADDP4
ASGNP4
line 2678
;2678:	Q_strncpyz(style->name, name, STYLE_NAME_MAX_SIZE);
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 2679
;2679:	return style;
ADDRLP4 4
INDIRP4
RETP4
LABELV $1339
endproc GetTransitionStyleFromName 16 12
proc SP_efh_hull 88 32
line 2689
;2680:}
;2681:#endif
;2682:
;2683:/*
;2684:==============
;2685:JUHOX: SP_efh_hull
;2686:==============
;2687:*/
;2688:#if ESCAPE_MODE
;2689:static void SP_efh_hull(gentity_t* ent) {
line 2695
;2690:	int idnum;
;2691:	int count;
;2692:	const efhSegmentType_t* org;
;2693:
;2694:	if (
;2695:		g_gametype.integer != GT_EFH ||
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
NEI4 $1355
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1352
LABELV $1355
line 2697
;2696:		(ent->spawnflags & 16)
;2697:	) {
line 2698
;2698:		G_FreeEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 2699
;2699:		return;
ADDRGP4 $1351
JUMPV
LABELV $1352
line 2702
;2700:	}
;2701:
;2702:	count = ent->count;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 764
ADDP4
INDIRI4
ASGNI4
line 2703
;2703:	if (count < 1) count = 1;
ADDRLP4 4
INDIRI4
CNSTI4 1
GEI4 $1356
ADDRLP4 4
CNSTI4 1
ASGNI4
LABELV $1356
line 2705
;2704:
;2705:	if (numSegmentTypes + count <= MAX_SEGMENTTYPES) {
ADDRGP4 numSegmentTypes
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
CNSTI4 256
GTI4 $1358
line 2712
;2706:		efhSegmentType_t* seg;
;2707:		char* bounds;
;2708:		int i;
;2709:		int numStyleEntriesDefined;
;2710:		float defaultFrequency;
;2711:
;2712:		seg = &segmentTypes[numSegmentTypes];
ADDRLP4 12
ADDRGP4 numSegmentTypes
INDIRI4
CNSTI4 764
MULI4
ADDRGP4 segmentTypes
ADDP4
ASGNP4
line 2714
;2713:
;2714:		seg->name = ent->targetname;
ADDRLP4 12
INDIRP4
CNSTI4 632
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 656
ADDP4
INDIRP4
ASGNP4
line 2715
;2715:		if (!seg->name) {
ADDRLP4 12
INDIRP4
CNSTI4 632
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1360
line 2716
;2716:			seg->name = "unnamed";
ADDRLP4 12
INDIRP4
CNSTI4 632
ADDP4
ADDRGP4 $1362
ASGNP4
line 2717
;2717:		}
LABELV $1360
line 2719
;2718:
;2719:		if (G_SpawnString("bounds", "", &bounds)) {
ADDRGP4 $1365
ARGP4
ADDRGP4 $409
ARGP4
ADDRLP4 28
ARGP4
ADDRLP4 32
ADDRGP4 G_SpawnString
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $1363
line 2721
;2720:			// map compiled with q3map_efh
;2721:			sscanf(
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 $1366
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 584
ADDP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 588
ADDP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 592
ADDP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 596
ADDP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 600
ADDP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 604
ADDP4
ARGP4
ADDRGP4 sscanf
CALLI4
pop
line 2726
;2722:				bounds, "%f %f %f %f %f %f",
;2723:				&seg->absmin[0], &seg->absmin[1], &seg->absmin[2],
;2724:				&seg->absmax[0], &seg->absmax[1], &seg->absmax[2]
;2725:			);
;2726:		}
ADDRGP4 $1364
JUMPV
LABELV $1363
line 2727
;2727:		else {
line 2729
;2728:			// map compiled with standard q3map
;2729:			trap_SetBrushModel(ent, ent->model);
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 544
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_SetBrushModel
CALLV
pop
line 2730
;2730:			VectorAdd(ent->s.origin, ent->r.mins, seg->absmin);
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 584
ADDP4
ADDRLP4 40
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 588
ADDP4
ADDRLP4 44
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 440
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 592
ADDP4
ADDRLP4 48
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ADDRLP4 48
INDIRP4
CNSTI4 444
ADDP4
INDIRF4
ADDF4
ASGNF4
line 2731
;2731:			VectorAdd(ent->s.origin, ent->r.maxs, seg->absmax);
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 596
ADDP4
ADDRLP4 52
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 448
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 600
ADDP4
ADDRLP4 56
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ADDRLP4 56
INDIRP4
CNSTI4 452
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 604
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ADDRLP4 60
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
ADDF4
ASGNF4
line 2732
;2732:		}
LABELV $1364
line 2735
;2733:
;2734:		// Initial values for the bounding box. Correct values will be computed in BuildSegments()
;2735:		VectorCopy(seg->absmin, seg->boundingMax);
ADDRLP4 12
INDIRP4
CNSTI4 620
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 584
ADDP4
INDIRB
ASGNB 12
line 2736
;2736:		VectorCopy(seg->absmax, seg->boundingMin);
ADDRLP4 12
INDIRP4
CNSTI4 608
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 596
ADDP4
INDIRB
ASGNB 12
line 2738
;2737:
;2738:		if (ent->spawnflags & 1) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1367
line 2739
;2739:			seg->initial = qtrue;
ADDRLP4 12
INDIRP4
CNSTI4 560
ADDP4
CNSTI4 1
ASGNI4
line 2740
;2740:		}
LABELV $1367
line 2741
;2741:		if (ent->spawnflags & 2) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1369
line 2742
;2742:			seg->final = qtrue;
ADDRLP4 12
INDIRP4
CNSTI4 556
ADDP4
CNSTI4 1
ASGNI4
line 2743
;2743:		}
LABELV $1369
line 2744
;2744:		if (ent->spawnflags & 4) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $1371
line 2745
;2745:			seg->frustrating = qtrue;
ADDRLP4 12
INDIRP4
CNSTI4 760
ADDP4
CNSTI4 1
ASGNI4
line 2746
;2746:		}
LABELV $1371
line 2747
;2747:		if (ent->spawnflags & 8) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $1373
line 2748
;2748:			seg->visBlocking = qtrue;
ADDRLP4 12
INDIRP4
CNSTI4 564
ADDP4
CNSTI4 1
ASGNI4
line 2749
;2749:		}
LABELV $1373
line 2751
;2750:
;2751:		if (seg->initial && seg->final) {
ADDRLP4 12
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1375
ADDRLP4 12
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1375
line 2752
;2752:			G_Error("SP_efh_hull: Both initial & final flag set in segment %s", SegmentName(seg));
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 SegmentName
CALLP4
ASGNP4
ADDRGP4 $1377
ARGP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 2753
;2753:		}
LABELV $1375
line 2755
;2754:
;2755:		numStyleEntriesDefined = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 2756
;2756:		defaultFrequency = 100;
ADDRLP4 24
CNSTF4 1120403456
ASGNF4
line 2757
;2757:		for (i = 0; i < MAX_PARALLEL_STYLES; i++) {
ADDRLP4 16
CNSTI4 0
ASGNI4
LABELV $1378
line 2762
;2758:			efhStyleEntry_t* styleEntry;
;2759:			char* styleName;
;2760:			char ext[4];
;2761:
;2762:			styleEntry = &seg->styles[i];
ADDRLP4 48
ADDRLP4 16
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 12
INDIRP4
CNSTI4 640
ADDP4
ADDP4
ASGNP4
line 2764
;2763:
;2764:			if (i <= 0) {
ADDRLP4 16
INDIRI4
CNSTI4 0
GTI4 $1382
line 2765
;2765:				ext[0] = 0;
ADDRLP4 52
CNSTI1 0
ASGNI1
line 2766
;2766:			}
ADDRGP4 $1383
JUMPV
LABELV $1382
line 2767
;2767:			else {
line 2768
;2768:				Q_strncpyz(ext, va("%d", i), sizeof(ext));
ADDRGP4 $1252
ARGP4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 52
ARGP4
ADDRLP4 60
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 2769
;2769:			}
LABELV $1383
line 2771
;2770:
;2771:			G_SpawnFloat(va("frequency%s", ext), "100", &styleEntry->frequency);
ADDRGP4 $1384
ARGP4
ADDRLP4 52
ARGP4
ADDRLP4 60
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRGP4 $1385
ARGP4
ADDRLP4 48
INDIRP4
CNSTI4 8
ADDP4
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 2773
;2772:
;2773:			G_SpawnString(va("style_in%s", ext), "", &styleName);
ADDRGP4 $1386
ARGP4
ADDRLP4 52
ARGP4
ADDRLP4 64
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRGP4 $409
ARGP4
ADDRLP4 56
ARGP4
ADDRGP4 G_SpawnString
CALLI4
pop
line 2774
;2774:			styleEntry->entrance = GetTransitionStyleFromName(styleName);
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 GetTransitionStyleFromName
CALLP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 68
INDIRP4
ASGNP4
line 2776
;2775:
;2776:			G_SpawnString(va("style_out%s", ext), "", &styleName);
ADDRGP4 $1387
ARGP4
ADDRLP4 52
ARGP4
ADDRLP4 72
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRGP4 $409
ARGP4
ADDRLP4 56
ARGP4
ADDRGP4 G_SpawnString
CALLI4
pop
line 2777
;2777:			styleEntry->exit = GetTransitionStyleFromName(styleName);
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 76
ADDRGP4 GetTransitionStyleFromName
CALLP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 76
INDIRP4
ASGNP4
line 2779
;2778:
;2779:			if (styleEntry->entrance || styleEntry->exit) {
ADDRLP4 48
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1390
ADDRLP4 48
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1388
LABELV $1390
line 2780
;2780:				if (!styleEntry->entrance && !seg->initial) {
ADDRLP4 48
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1391
ADDRLP4 12
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1391
line 2781
;2781:					G_Error("^1SP_efh_hull: no style_in%s key in segment %s", ext, SegmentName(seg));
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 84
ADDRGP4 SegmentName
CALLP4
ASGNP4
ADDRGP4 $1393
ARGP4
ADDRLP4 52
ARGP4
ADDRLP4 84
INDIRP4
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 2782
;2782:				}
LABELV $1391
line 2783
;2783:				if (!styleEntry->exit && !seg->final) {
ADDRLP4 48
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1394
ADDRLP4 12
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1394
line 2784
;2784:					G_Error("^1SP_efh_hull: no style_out%s key in segment %s", ext, SegmentName(seg));
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 84
ADDRGP4 SegmentName
CALLP4
ASGNP4
ADDRGP4 $1396
ARGP4
ADDRLP4 52
ARGP4
ADDRLP4 84
INDIRP4
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 2785
;2785:				}
LABELV $1394
line 2786
;2786:			}
LABELV $1388
line 2787
;2787:			if (styleEntry->frequency <= 0) {
ADDRLP4 48
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 0
GTF4 $1397
line 2788
;2788:				G_Error(
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 84
ADDRGP4 SegmentName
CALLP4
ASGNP4
ADDRGP4 $1399
ARGP4
ADDRLP4 52
ARGP4
ADDRLP4 48
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 84
INDIRP4
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 2792
;2789:					"^1SP_efh_hull: invalid value frequency%s=%f for segment %s",
;2790:					ext, styleEntry->frequency, SegmentName(seg)
;2791:				);
;2792:			}
LABELV $1397
line 2795
;2793:
;2794:			// mark unused parts of the entry
;2795:			if (seg->initial) styleEntry->entrance = NULL;
ADDRLP4 12
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1400
ADDRLP4 48
INDIRP4
CNSTP4 0
ASGNP4
LABELV $1400
line 2796
;2796:			if (seg->final) styleEntry->exit = NULL;
ADDRLP4 12
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1402
ADDRLP4 48
INDIRP4
CNSTI4 4
ADDP4
CNSTP4 0
ASGNP4
LABELV $1402
line 2797
;2797:			if (!styleEntry->entrance && !styleEntry->exit) {
ADDRLP4 48
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1404
ADDRLP4 48
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1404
line 2798
;2798:				if (i == 0) defaultFrequency = styleEntry->frequency;
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $1406
ADDRLP4 24
ADDRLP4 48
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ASGNF4
LABELV $1406
line 2799
;2799:				styleEntry->frequency = -1;
ADDRLP4 48
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 3212836864
ASGNF4
line 2800
;2800:			}
ADDRGP4 $1405
JUMPV
LABELV $1404
line 2801
;2801:			else {
line 2802
;2802:				numStyleEntriesDefined++;
ADDRLP4 20
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2803
;2803:			}
LABELV $1405
line 2804
;2804:		}
LABELV $1379
line 2757
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 10
LTI4 $1378
line 2805
;2805:		if (numStyleEntriesDefined <= 0) {
ADDRLP4 20
INDIRI4
CNSTI4 0
GTI4 $1408
line 2806
;2806:			if (!seg->initial) seg->styles[0].entrance = GetTransitionStyleFromName("style_default");
ADDRLP4 12
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1410
ADDRGP4 $1412
ARGP4
ADDRLP4 48
ADDRGP4 GetTransitionStyleFromName
CALLP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 640
ADDP4
ADDRLP4 48
INDIRP4
ASGNP4
LABELV $1410
line 2807
;2807:			if (!seg->final) seg->styles[0].exit = GetTransitionStyleFromName("style_default");
ADDRLP4 12
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1413
ADDRGP4 $1412
ARGP4
ADDRLP4 52
ADDRGP4 GetTransitionStyleFromName
CALLP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 644
ADDP4
ADDRLP4 52
INDIRP4
ASGNP4
LABELV $1413
line 2808
;2808:			seg->styles[0].frequency = defaultFrequency;
ADDRLP4 12
INDIRP4
CNSTI4 648
ADDP4
ADDRLP4 24
INDIRF4
ASGNF4
line 2809
;2809:		}
LABELV $1408
line 2811
;2810:
;2811:		numSegmentTypes++;
ADDRLP4 48
ADDRGP4 numSegmentTypes
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2812
;2812:	}
ADDRGP4 $1359
JUMPV
LABELV $1358
line 2813
;2813:	else {
line 2814
;2814:		G_Error("^1SP_efh_hull: too many segments (>%d)", MAX_SEGMENTTYPES);
ADDRGP4 $1415
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 G_Error
CALLV
pop
line 2815
;2815:	}
LABELV $1359
line 2817
;2816:
;2817:	org = &segmentTypes[numSegmentTypes - 1];
ADDRLP4 8
ADDRGP4 numSegmentTypes
INDIRI4
CNSTI4 764
MULI4
ADDRGP4 segmentTypes-764
ADDP4
ASGNP4
line 2818
;2818:	for (idnum = 1; idnum < count; idnum++) {
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $1420
JUMPV
LABELV $1417
line 2821
;2819:		efhSegmentType_t* seg;
;2820:
;2821:		seg = &segmentTypes[numSegmentTypes++];
ADDRLP4 20
ADDRGP4 numSegmentTypes
ASGNP4
ADDRLP4 16
ADDRLP4 20
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 20
INDIRP4
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 12
ADDRLP4 16
INDIRI4
CNSTI4 764
MULI4
ADDRGP4 segmentTypes
ADDP4
ASGNP4
line 2823
;2822:
;2823:		*seg = *org;
ADDRLP4 12
INDIRP4
ADDRLP4 8
INDIRP4
INDIRB
ASGNB 764
line 2824
;2824:		seg->idnum = idnum;
ADDRLP4 12
INDIRP4
CNSTI4 636
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 2825
;2825:	}
LABELV $1418
line 2818
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1420
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $1417
line 2827
;2826:
;2827:	G_FreeEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 2828
;2828:}
LABELV $1351
endproc SP_efh_hull 88 32
proc SP_efh_model 20 4
line 2837
;2829:#endif
;2830:
;2831:/*
;2832:==============
;2833:JUHOX: SP_efh_model
;2834:==============
;2835:*/
;2836:#if ESCAPE_MODE
;2837:static void SP_efh_model(gentity_t* ent) {
line 2838
;2838:	if (g_gametype.integer != GT_EFH) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
EQI4 $1422
line 2839
;2839:		G_FreeEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 2840
;2840:		return;
ADDRGP4 $1421
JUMPV
LABELV $1422
line 2843
;2841:	}
;2842:
;2843:	ent->s.modelindex = G_ModelIndex(ent->model);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 G_ModelIndex
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 2844
;2844:	InitMover(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 InitMover
CALLV
pop
line 2845
;2845:	VectorCopy(ent->s.origin, ent->s.pos.trBase);
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 2846
;2846:	VectorCopy(ent->s.origin, ent->r.currentOrigin);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 2847
;2847:	VectorCopy(ent->s.angles, ent->s.apos.trBase);
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 60
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 2848
;2848:	ent->entClass = GEC_efh_model;
ADDRFP4 0
INDIRP4
CNSTI4 824
ADDP4
CNSTI4 45
ASGNI4
line 2849
;2849:}
LABELV $1421
endproc SP_efh_model 20 4
proc SP_efh_brush 4 8
line 2858
;2850:#endif
;2851:
;2852:/*
;2853:==============
;2854:JUHOX: SP_efh_brush
;2855:==============
;2856:*/
;2857:#if ESCAPE_MODE
;2858:static void SP_efh_brush(gentity_t* ent) {
line 2859
;2859:	if (g_gametype.integer != GT_EFH) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
EQI4 $1426
line 2860
;2860:		G_FreeEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 2861
;2861:		return;
ADDRGP4 $1425
JUMPV
LABELV $1426
line 2864
;2862:	}
;2863:
;2864:	trap_SetBrushModel(ent, ent->model);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_SetBrushModel
CALLV
pop
line 2865
;2865:	ent->r.svFlags = SVF_USE_CURRENT_ORIGIN;
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 128
ASGNI4
line 2866
;2866:	ent->s.eType = ET_MOVER;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 4
ASGNI4
line 2867
;2867:	trap_LinkEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 2868
;2868:	ent->entClass = GEC_efh_brush;
ADDRFP4 0
INDIRP4
CNSTI4 824
ADDP4
CNSTI4 46
ASGNI4
line 2869
;2869:}
LABELV $1425
endproc SP_efh_brush 4 8
proc SP_efh_null_brush 0 4
line 2878
;2870:#endif
;2871:
;2872:/*
;2873:==============
;2874:JUHOX: SP_efh_null_brush
;2875:==============
;2876:*/
;2877:#if ESCAPE_MODE
;2878:static void SP_efh_null_brush(gentity_t* ent) {
line 2879
;2879:	G_FreeEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 2880
;2880:}
LABELV $1429
endproc SP_efh_null_brush 0 4
proc SP_efh_entrance 0 4
line 2889
;2881:#endif
;2882:
;2883:/*
;2884:==============
;2885:JUHOX: SP_efh_entrance
;2886:==============
;2887:*/
;2888:#if ESCAPE_MODE
;2889:static void SP_efh_entrance(gentity_t* ent) {
line 2890
;2890:	if (g_gametype.integer != GT_EFH) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
EQI4 $1431
line 2891
;2891:		G_FreeEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 2892
;2892:		return;
ADDRGP4 $1430
JUMPV
LABELV $1431
line 2895
;2893:	}
;2894:
;2895:	ent->entClass = GEC_efh_entrance;
ADDRFP4 0
INDIRP4
CNSTI4 824
ADDP4
CNSTI4 47
ASGNI4
line 2896
;2896:}
LABELV $1430
endproc SP_efh_entrance 0 4
proc SP_efh_exit 0 4
line 2905
;2897:#endif
;2898:
;2899:/*
;2900:==============
;2901:JUHOX: SP_efh_exit
;2902:==============
;2903:*/
;2904:#if ESCAPE_MODE
;2905:static void SP_efh_exit(gentity_t* ent) {
line 2906
;2906:	if (g_gametype.integer != GT_EFH) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
EQI4 $1435
line 2907
;2907:		G_FreeEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 2908
;2908:		return;
ADDRGP4 $1434
JUMPV
LABELV $1435
line 2911
;2909:	}
;2910:
;2911:	ent->entClass = GEC_efh_exit;
ADDRFP4 0
INDIRP4
CNSTI4 824
ADDP4
CNSTI4 48
ASGNI4
line 2912
;2912:}
LABELV $1434
endproc SP_efh_exit 0 4
proc SP_efh_monster 0 12
line 2921
;2913:#endif
;2914:
;2915:/*
;2916:==============
;2917:JUHOX: SP_efh_monster
;2918:==============
;2919:*/
;2920:#if ESCAPE_MODE
;2921:static void SP_efh_monster(gentity_t* ent) {
line 2922
;2922:	if (g_gametype.integer != GT_EFH) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
EQI4 $1439
line 2923
;2923:		G_FreeEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 2924
;2924:		return;
ADDRGP4 $1438
JUMPV
LABELV $1439
line 2927
;2925:	}
;2926:
;2927:	G_SpawnInt("type", "0", &ent->s.otherEntityNum);
ADDRGP4 $1442
ARGP4
ADDRGP4 $325
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
ARGP4
ADDRGP4 G_SpawnInt
CALLI4
pop
line 2928
;2928:	ent->entClass = GEC_efh_monster;
ADDRFP4 0
INDIRP4
CNSTI4 824
ADDP4
CNSTI4 49
ASGNI4
line 2929
;2929:}
LABELV $1438
endproc SP_efh_monster 0 12
proc SP_efh_waypoint 0 4
line 2938
;2930:#endif
;2931:
;2932:/*
;2933:==============
;2934:JUHOX: SP_efh_waypoint
;2935:==============
;2936:*/
;2937:#if ESCAPE_MODE
;2938:static void SP_efh_waypoint(gentity_t* ent) {
line 2939
;2939:	if (g_gametype.integer != GT_EFH) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
EQI4 $1444
line 2940
;2940:		G_FreeEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 2941
;2941:		return;
ADDRGP4 $1443
JUMPV
LABELV $1444
line 2944
;2942:	}
;2943:
;2944:	ent->entClass = GEC_efh_waypoint;
ADDRFP4 0
INDIRP4
CNSTI4 824
ADDP4
CNSTI4 50
ASGNI4
line 2945
;2945:}
LABELV $1443
endproc SP_efh_waypoint 0 4
proc IsWorldOriginInsideSegment 0 0
line 2958
;2946:#endif
;2947:
;2948:/*
;2949:==============
;2950:JUHOX: IsWorldOriginInsideSegment
;2951:==============
;2952:*/
;2953:#if ESCAPE_MODE
;2954:static qboolean IsWorldOriginInsideSegment(
;2955:	const efhVector_t* origin,
;2956:	const efhSegmentType_t* segType,
;2957:	const efhVector_t* segOrigin
;2958:) {
line 2959
;2959:	if (origin->x - segOrigin->x < segType->boundingMin[0] - 8) return qfalse;
ADDRFP4 0
INDIRP4
INDIRI4
ADDRFP4 8
INDIRP4
INDIRI4
SUBI4
CVIF4 4
ADDRFP4 4
INDIRP4
CNSTI4 608
ADDP4
INDIRF4
CNSTF4 1090519040
SUBF4
GEF4 $1448
CNSTI4 0
RETI4
ADDRGP4 $1447
JUMPV
LABELV $1448
line 2960
;2960:	if (origin->x - segOrigin->x > segType->boundingMax[0] + 8) return qfalse;
ADDRFP4 0
INDIRP4
INDIRI4
ADDRFP4 8
INDIRP4
INDIRI4
SUBI4
CVIF4 4
ADDRFP4 4
INDIRP4
CNSTI4 620
ADDP4
INDIRF4
CNSTF4 1090519040
ADDF4
LEF4 $1450
CNSTI4 0
RETI4
ADDRGP4 $1447
JUMPV
LABELV $1450
line 2961
;2961:	if (origin->y - segOrigin->y < segType->boundingMin[1] - 8) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
SUBI4
CVIF4 4
ADDRFP4 4
INDIRP4
CNSTI4 612
ADDP4
INDIRF4
CNSTF4 1090519040
SUBF4
GEF4 $1452
CNSTI4 0
RETI4
ADDRGP4 $1447
JUMPV
LABELV $1452
line 2962
;2962:	if (origin->y - segOrigin->y > segType->boundingMax[1] + 8) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
SUBI4
CVIF4 4
ADDRFP4 4
INDIRP4
CNSTI4 624
ADDP4
INDIRF4
CNSTF4 1090519040
ADDF4
LEF4 $1454
CNSTI4 0
RETI4
ADDRGP4 $1447
JUMPV
LABELV $1454
line 2963
;2963:	if (origin->z - segOrigin->z < segType->boundingMin[2] - 8) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
SUBI4
CVIF4 4
ADDRFP4 4
INDIRP4
CNSTI4 616
ADDP4
INDIRF4
CNSTF4 1090519040
SUBF4
GEF4 $1456
CNSTI4 0
RETI4
ADDRGP4 $1447
JUMPV
LABELV $1456
line 2964
;2964:	if (origin->z - segOrigin->z > segType->boundingMax[2] + 8) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
SUBI4
CVIF4 4
ADDRFP4 4
INDIRP4
CNSTI4 628
ADDP4
INDIRF4
CNSTF4 1090519040
ADDF4
LEF4 $1458
CNSTI4 0
RETI4
ADDRGP4 $1447
JUMPV
LABELV $1458
line 2965
;2965:	return qtrue;
CNSTI4 1
RETI4
LABELV $1447
endproc IsWorldOriginInsideSegment 0 0
export G_FindSegment
proc G_FindSegment 52 12
line 3018
;2966:}
;2967:#endif
;2968:
;2969:/*
;2970:==============
;2971:JUHOX: SegmentDistanceSquared
;2972:==============
;2973:*/
;2974:#if ESCAPE_MODE
;2975:/*
;2976:static float SegmentDistanceSquared(
;2977:	const efhVector_t* origin,
;2978:	const efhSegmentType_t* segType,
;2979:	const efhVector_t* segOrigin
;2980:) {
;2981:	vec3_t delta;
;2982:
;2983:	delta[0] = origin->x - segOrigin->x;
;2984:	if (delta[0] < 0.5 * (segType->boundingMin[0] + segType->boundingMax[0])) {
;2985:		delta[0] += segType->boundingMin[0];
;2986:	}
;2987:	else {
;2988:		delta[0] += segType->boundingMax[0];
;2989:	}
;2990:
;2991:	delta[1] = origin->y - segOrigin->y;
;2992:	if (delta[1] < 0.5 * (segType->boundingMin[1] + segType->boundingMax[1])) {
;2993:		delta[1] += segType->boundingMin[1];
;2994:	}
;2995:	else {
;2996:		delta[1] += segType->boundingMax[1];
;2997:	}
;2998:
;2999:	delta[2] = origin->z - segOrigin->z;
;3000:	if (delta[2] < 0.5 * (segType->boundingMin[2] + segType->boundingMax[2])) {
;3001:		delta[2] += segType->boundingMin[2];
;3002:	}
;3003:	else {
;3004:		delta[2] += segType->boundingMax[2];
;3005:	}
;3006:
;3007:	return VectorLengthSquared(delta);
;3008:}
;3009:*/
;3010:#endif
;3011:
;3012:/*
;3013:==============
;3014:JUHOX: G_FindSegment
;3015:==============
;3016:*/
;3017:#if ESCAPE_MODE
;3018:int G_FindSegment(const vec3_t mapOrigin, efhVector_t* segOrigin) {
line 3028
;3019:	efhVector_t worldOrigin;
;3020:	efhVector_t segOrgBack;
;3021:	efhVector_t segOrgForw;
;3022:	/*
;3023:	float minDistanceSquared;
;3024:	int nearestSegment;
;3025:	*/
;3026:	int index;
;3027:
;3028:	if (g_gametype.integer != GT_EFH) return -1;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
EQI4 $1461
CNSTI4 -1
RETI4
ADDRGP4 $1460
JUMPV
LABELV $1461
line 3030
;3029:
;3030:	MapOriginToWorldOrigin(mapOrigin, &worldOrigin);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
ARGP4
ADDRGP4 MapOriginToWorldOrigin
CALLV
pop
line 3031
;3031:	segOrgBack = currentSegmentOrigin;
ADDRLP4 4
ADDRGP4 currentSegmentOrigin
INDIRB
ASGNB 12
line 3032
;3032:	segOrgForw = currentSegmentOrigin;
ADDRLP4 16
ADDRGP4 currentSegmentOrigin
INDIRB
ASGNB 12
line 3037
;3033:	/*
;3034:	minDistanceSquared = 1e12;
;3035:	nearestSegment = currentSegment;
;3036:	*/
;3037:	index = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1464
line 3038
;3038:	do {
line 3042
;3039:		int segment;
;3040:		const efhSegmentType_t* segType;
;3041:
;3042:		segment = currentSegment + index;
ADDRLP4 40
ADDRGP4 currentSegment
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 3043
;3043:		if (segment <= maxSegment) {
ADDRLP4 40
INDIRI4
ADDRGP4 maxSegment
INDIRI4
GTI4 $1467
line 3044
;3044:			segType = efhWorld[segment];
ADDRLP4 44
ADDRLP4 40
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 efhWorld
ADDP4
INDIRP4
ASGNP4
line 3046
;3045:
;3046:			if (IsWorldOriginInsideSegment(&worldOrigin, segType, &segOrgForw)) {
ADDRLP4 28
ARGP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 48
ADDRGP4 IsWorldOriginInsideSegment
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $1469
line 3047
;3047:				if (segOrigin) *segOrigin = segOrgForw;
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1471
ADDRFP4 4
INDIRP4
ADDRLP4 16
INDIRB
ASGNB 12
LABELV $1471
line 3048
;3048:				return segment;
ADDRLP4 40
INDIRI4
RETI4
ADDRGP4 $1460
JUMPV
LABELV $1469
line 3063
;3049:			}
;3050:			/*
;3051:			else {
;3052:				float distanceSquared;
;3053:
;3054:				distanceSquared = SegmentDistanceSquared(&worldOrigin, segType, &segOrgForw);
;3055:				if (distanceSquared < minDistanceSquared) {
;3056:					minDistanceSquared = distanceSquared;
;3057:					nearestSegment = segment;
;3058:					if (segOrigin) *segOrigin = segOrgForw;
;3059:				}
;3060:			}
;3061:			*/
;3062:
;3063:			segOrgForw.x += segType->exitDelta.x;
ADDRLP4 16
ADDRLP4 16
INDIRI4
ADDRLP4 44
INDIRP4
CNSTI4 568
ADDP4
INDIRI4
ADDI4
ASGNI4
line 3064
;3064:			segOrgForw.y += segType->exitDelta.y;
ADDRLP4 16+4
ADDRLP4 16+4
INDIRI4
ADDRLP4 44
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
ADDI4
ASGNI4
line 3065
;3065:			segOrgForw.z += segType->exitDelta.z;
ADDRLP4 16+8
ADDRLP4 16+8
INDIRI4
ADDRLP4 44
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ADDI4
ASGNI4
line 3066
;3066:		}
LABELV $1467
line 3068
;3067:
;3068:		segment = currentSegment - index - 1;
ADDRLP4 40
ADDRGP4 currentSegment
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 1
SUBI4
ASGNI4
line 3069
;3069:		if (segment >= 0) {
ADDRLP4 40
INDIRI4
CNSTI4 0
LTI4 $1475
line 3070
;3070:			segType = efhWorld[segment];
ADDRLP4 44
ADDRLP4 40
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 efhWorld
ADDP4
INDIRP4
ASGNP4
line 3072
;3071:
;3072:			segOrgBack.x -= segType->exitDelta.x;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 44
INDIRP4
CNSTI4 568
ADDP4
INDIRI4
SUBI4
ASGNI4
line 3073
;3073:			segOrgBack.y -= segType->exitDelta.y;
ADDRLP4 4+4
ADDRLP4 4+4
INDIRI4
ADDRLP4 44
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
SUBI4
ASGNI4
line 3074
;3074:			segOrgBack.z -= segType->exitDelta.z;
ADDRLP4 4+8
ADDRLP4 4+8
INDIRI4
ADDRLP4 44
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
SUBI4
ASGNI4
line 3076
;3075:
;3076:			if (IsWorldOriginInsideSegment(&worldOrigin, segType, &segOrgBack)) {
ADDRLP4 28
ARGP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 48
ADDRGP4 IsWorldOriginInsideSegment
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $1479
line 3077
;3077:				if (segOrigin) *segOrigin = segOrgBack;
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1481
ADDRFP4 4
INDIRP4
ADDRLP4 4
INDIRB
ASGNB 12
LABELV $1481
line 3078
;3078:				return segment;
ADDRLP4 40
INDIRI4
RETI4
ADDRGP4 $1460
JUMPV
LABELV $1479
line 3092
;3079:			}
;3080:			/*
;3081:			else {
;3082:				float distanceSquared;
;3083:
;3084:				distanceSquared = SegmentDistanceSquared(&worldOrigin, segType, &segOrgForw);
;3085:				if (distanceSquared < minDistanceSquared) {
;3086:					minDistanceSquared = distanceSquared;
;3087:					nearestSegment = segment;
;3088:					if (segOrigin) *segOrigin = segOrgBack;
;3089:				}
;3090:			}
;3091:			*/
;3092:		}
LABELV $1475
line 3094
;3093:
;3094:		index++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3095
;3095:	} while (index < 50);
LABELV $1465
ADDRLP4 0
INDIRI4
CNSTI4 50
LTI4 $1464
line 3098
;3096:
;3097:	//return nearestSegment;
;3098:	return -1;
CNSTI4 -1
RETI4
LABELV $1460
endproc G_FindSegment 52 12
proc FindSegmentOrigin 20 0
line 3108
;3099:}
;3100:#endif
;3101:
;3102:/*
;3103:==============
;3104:JUHOX: FindSegmentOrigin
;3105:==============
;3106:*/
;3107:#if ESCAPE_MODE
;3108:static void FindSegmentOrigin(int segment, efhVector_t* segOrg) {
line 3112
;3109:	efhVector_t origin;
;3110:	int s;
;3111:
;3112:	origin = currentSegmentOrigin;
ADDRLP4 0
ADDRGP4 currentSegmentOrigin
INDIRB
ASGNB 12
line 3113
;3113:	s = currentSegment;
ADDRLP4 12
ADDRGP4 currentSegment
INDIRI4
ASGNI4
ADDRGP4 $1485
JUMPV
LABELV $1484
line 3115
;3114:
;3115:	while (s < segment) {
line 3118
;3116:		const efhSegmentType_t* segType;
;3117:
;3118:		segType = efhWorld[s];
ADDRLP4 16
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 efhWorld
ADDP4
INDIRP4
ASGNP4
line 3119
;3119:		origin.x += segType->exitDelta.x;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRP4
CNSTI4 568
ADDP4
INDIRI4
ADDI4
ASGNI4
line 3120
;3120:		origin.y += segType->exitDelta.y;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
ADDRLP4 16
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
ADDI4
ASGNI4
line 3121
;3121:		origin.z += segType->exitDelta.z;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRI4
ADDRLP4 16
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ADDI4
ASGNI4
line 3122
;3122:		s++;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3123
;3123:	}
LABELV $1485
line 3115
ADDRLP4 12
INDIRI4
ADDRFP4 0
INDIRI4
LTI4 $1484
ADDRGP4 $1490
JUMPV
LABELV $1489
line 3125
;3124:
;3125:	while (s > segment) {
line 3128
;3126:		const efhSegmentType_t* segType;
;3127:
;3128:		s--;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 3129
;3129:		segType = efhWorld[s];
ADDRLP4 16
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 efhWorld
ADDP4
INDIRP4
ASGNP4
line 3130
;3130:		origin.x -= segType->exitDelta.x;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRP4
CNSTI4 568
ADDP4
INDIRI4
SUBI4
ASGNI4
line 3131
;3131:		origin.y -= segType->exitDelta.y;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
ADDRLP4 16
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
SUBI4
ASGNI4
line 3132
;3132:		origin.z -= segType->exitDelta.z;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRI4
ADDRLP4 16
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
SUBI4
ASGNI4
line 3133
;3133:	}
LABELV $1490
line 3125
ADDRLP4 12
INDIRI4
ADDRFP4 0
INDIRI4
GTI4 $1489
line 3135
;3134:
;3135:	*segOrg = origin;
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRB
ASGNB 12
line 3136
;3136:}
LABELV $1483
endproc FindSegmentOrigin 20 0
proc ActivateSegment 24 20
line 3145
;3137:#endif
;3138:
;3139:/*
;3140:==============
;3141:JUHOX: ActivateSegment
;3142:==============
;3143:*/
;3144:#if ESCAPE_MODE
;3145:static void ActivateSegment(int segment, const efhVector_t* segOrg, efhSegmentState_t state) {
line 3146
;3146:	if (segment < 0 || segment > maxSegment) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1497
ADDRLP4 0
INDIRI4
ADDRGP4 maxSegment
INDIRI4
LEI4 $1495
LABELV $1497
line 3147
;3147:		G_Error("^1BUG! ActivateSegment: segment=%d, max=%d\n", segment, maxSegment);
ADDRGP4 $1498
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 maxSegment
INDIRI4
ARGI4
ADDRGP4 G_Error
CALLV
pop
line 3148
;3148:		return;
ADDRGP4 $1494
JUMPV
LABELV $1495
line 3151
;3149:	}
;3150:
;3151:	if (newSegmentState[segment] >= state) return;
ADDRFP4 0
INDIRI4
ADDRGP4 newSegmentState
ADDP4
INDIRU1
CVUI4 1
ADDRFP4 8
INDIRI4
LTI4 $1499
ADDRGP4 $1494
JUMPV
LABELV $1499
line 3153
;3152:
;3153:	newSegmentState[segment] = state;
ADDRFP4 0
INDIRI4
ADDRGP4 newSegmentState
ADDP4
ADDRFP4 8
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 3155
;3154:
;3155:	if (segmentState[segment] < state) {
ADDRFP4 0
INDIRI4
ADDRGP4 segmentState
ADDP4
INDIRU1
CVUI4 1
ADDRFP4 8
INDIRI4
GEI4 $1501
line 3160
;3156:		efhSegmentType_t* segType;
;3157:		vec3_t mapOrigin;
;3158:		efhSpawnCommand_t cmd;
;3159:
;3160:		segType = efhWorld[segment];
ADDRLP4 4
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 efhWorld
ADDP4
INDIRP4
ASGNP4
line 3161
;3161:		if (!segType) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1503
line 3162
;3162:			G_Error("^1BUG! ActivateSegment: segment=%d, max=%d, type=NULL\n", segment, maxSegment);
ADDRGP4 $1505
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 maxSegment
INDIRI4
ARGI4
ADDRGP4 G_Error
CALLV
pop
line 3163
;3163:		}
LABELV $1503
line 3164
;3164:		WorldOriginToMapOrigin(segOrg, mapOrigin);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 WorldOriginToMapOrigin
CALLV
pop
line 3166
;3165:
;3166:		if (state == ESS_solidPartSpawned) {
ADDRFP4 8
INDIRI4
CNSTI4 1
NEI4 $1506
line 3167
;3167:			cmd = ESC_spawnSolidOnly;
ADDRLP4 20
CNSTI4 1
ASGNI4
line 3168
;3168:		}
ADDRGP4 $1507
JUMPV
LABELV $1506
line 3169
;3169:		else if (segmentState[segment] == ESS_solidPartSpawned) {
ADDRFP4 0
INDIRI4
ADDRGP4 segmentState
ADDP4
INDIRU1
CVUI4 1
CNSTI4 1
NEI4 $1508
line 3170
;3170:			cmd = ESC_spawnNonSolidOnly;
ADDRLP4 20
CNSTI4 2
ASGNI4
line 3171
;3171:		}
ADDRGP4 $1509
JUMPV
LABELV $1508
line 3172
;3172:		else {
line 3173
;3173:			cmd = ESC_spawnCompletely;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 3174
;3174:		}
LABELV $1509
LABELV $1507
line 3176
;3175:
;3176:		SpawnSegment(segType, mapOrigin, segment, segOrg, cmd);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 20
INDIRI4
ARGI4
ADDRGP4 SpawnSegment
CALLV
pop
line 3177
;3177:	}
LABELV $1501
line 3178
;3178:}
LABELV $1494
endproc ActivateSegment 24 20
export G_SpawnWorld
proc G_SpawnWorld 12 12
line 3187
;3179:#endif
;3180:
;3181:/*
;3182:==============
;3183:JUHOX: G_SpawnWorld
;3184:==============
;3185:*/
;3186:#if ESCAPE_MODE
;3187:void G_SpawnWorld(void) {
line 3190
;3188:	efhVector_t origin;
;3189:
;3190:	if (g_gametype.integer != GT_EFH) return;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
EQI4 $1511
ADDRGP4 $1510
JUMPV
LABELV $1511
line 3192
;3191:#if MEETING
;3192:	if (level.meeting) return;
ADDRGP4 level+24092
INDIRI4
CNSTI4 0
EQI4 $1514
ADDRGP4 $1510
JUMPV
LABELV $1514
line 3194
;3193:#endif
;3194:	origin.x = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 3195
;3195:	origin.y = 0;
ADDRLP4 0+4
CNSTI4 0
ASGNI4
line 3196
;3196:	origin.z = 0;
ADDRLP4 0+8
CNSTI4 0
ASGNI4
line 3197
;3197:	ActivateSegment(0, &origin, ESS_spawned);
CNSTI4 0
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 ActivateSegment
CALLV
pop
line 3198
;3198:}
LABELV $1510
endproc G_SpawnWorld 12 12
proc G_UpdateSegmentInfo 16 0
line 3210
;3199:#endif
;3200:
;3201:/*
;3202:==============
;3203:JUHOX: G_UpdateSegmentInfo
;3204:
;3205:clients get the segment number of each player and mover,
;3206:so they can decide about whether to draw them
;3207:==============
;3208:*/
;3209:#if ESCAPE_MODE
;3210:static void G_UpdateSegmentInfo(void) {
line 3213
;3211:	int i;
;3212:
;3213:	for (i = 0; i < level.num_entities; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1523
JUMPV
LABELV $1520
line 3216
;3214:		gentity_t* ent;
;3215:
;3216:		ent = &g_entities[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 3217
;3217:		if (!ent->inuse) continue;
ADDRLP4 4
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1525
ADDRGP4 $1521
JUMPV
LABELV $1525
line 3219
;3218:
;3219:		switch (ent->s.eType) {
ADDRLP4 8
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 1
EQI4 $1530
ADDRGP4 $1527
JUMPV
LABELV $1530
line 3221
;3220:		case ET_PLAYER:
;3221:			ent->s.constantLight = ent->worldSegment - 1;
ADDRLP4 4
INDIRP4
CNSTI4 152
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 3222
;3222:			break;
LABELV $1527
LABELV $1528
line 3229
;3223:		/* already done in SpawnSegment()
;3224:		case ET_MOVER:
;3225:			ent->s.time = ent->worldSegment - 1;
;3226:			break;
;3227:		*/
;3228:		}
;3229:	}
LABELV $1521
line 3213
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1523
ADDRLP4 0
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $1520
line 3230
;3230:}
LABELV $1519
endproc G_UpdateSegmentInfo 16 0
proc DeleteUnusedEntities 60 8
line 3239
;3231:#endif
;3232:
;3233:/*
;3234:==============
;3235:JUHOX: DeleteUnusedEntities
;3236:==============
;3237:*/
;3238:#if ESCAPE_MODE
;3239:static void DeleteUnusedEntities(void) {
line 3242
;3240:	int i;
;3241:
;3242:	for (i = MAX_CLIENTS; i < level.num_entities; i++) {
ADDRLP4 0
CNSTI4 64
ASGNI4
ADDRGP4 $1535
JUMPV
LABELV $1532
line 3247
;3243:		gentity_t* ent;
;3244:		playerState_t* ps;
;3245:		int segment;
;3246:
;3247:		ent = &g_entities[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 3248
;3248:		if (!ent->inuse) continue;
ADDRLP4 4
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1537
ADDRGP4 $1533
JUMPV
LABELV $1537
line 3249
;3249:		if (ent->neverFree) continue;
ADDRLP4 4
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1539
ADDRGP4 $1533
JUMPV
LABELV $1539
line 3251
;3250:
;3251:		ps = G_GetEntityPlayerState(ent);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 16
INDIRP4
ASGNP4
line 3252
;3252:		if (ps) {
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1541
line 3253
;3253:			segment = G_FindSegment(ps->origin, NULL);
ADDRLP4 12
INDIRP4
CNSTI4 20
ADDP4
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 20
ADDRGP4 G_FindSegment
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 20
INDIRI4
ASGNI4
line 3254
;3254:			if (segment >= 0) {
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $1543
line 3255
;3255:				ent->worldSegment = segment + 1;
ADDRLP4 4
INDIRP4
CNSTI4 820
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3256
;3256:			}
ADDRGP4 $1542
JUMPV
LABELV $1543
line 3257
;3257:			else if (ent->worldSegment) {
ADDRLP4 4
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1533
line 3258
;3258:				segment = ent->worldSegment - 1;
ADDRLP4 8
ADDRLP4 4
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 3259
;3259:			}
line 3260
;3260:			else {
line 3261
;3261:				continue;
line 3263
;3262:			}
;3263:		}
ADDRGP4 $1542
JUMPV
LABELV $1541
line 3264
;3264:		else if (ent->worldSegment) {
ADDRLP4 4
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1533
line 3265
;3265:			segment = ent->worldSegment - 1;
ADDRLP4 8
ADDRLP4 4
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 3266
;3266:		}
line 3267
;3267:		else {
line 3268
;3268:			continue;
LABELV $1548
LABELV $1542
line 3271
;3269:		}
;3270:
;3271:		if (ent->s.eType == ET_MOVER) {
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 4
NEI4 $1549
line 3272
;3272:			switch (newSegmentState[segment]) {
ADDRLP4 20
ADDRLP4 8
INDIRI4
ADDRGP4 newSegmentState
ADDP4
INDIRU1
CVUI4 1
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $1554
ADDRLP4 20
INDIRI4
CNSTI4 1
EQI4 $1555
ADDRLP4 20
INDIRI4
CNSTI4 2
EQI4 $1558
ADDRGP4 $1550
JUMPV
LABELV $1554
line 3274
;3273:			case ESS_removed:
;3274:				G_FreeEntity(ent);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 3275
;3275:				break;
ADDRGP4 $1550
JUMPV
LABELV $1555
line 3277
;3276:			case ESS_solidPartSpawned:
;3277:				if (!(ent->r.svFlags & SVF_NOCLIENT)) {
ADDRLP4 4
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $1550
line 3278
;3278:					ent->r.svFlags |= SVF_NOCLIENT;
ADDRLP4 28
ADDRLP4 4
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 3279
;3279:					trap_LinkEntity(ent);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 3280
;3280:				}
line 3281
;3281:				break;
ADDRGP4 $1550
JUMPV
LABELV $1558
line 3283
;3282:			case ESS_spawned:
;3283:				if (ent->r.svFlags & SVF_NOCLIENT) {
ADDRLP4 4
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1550
line 3284
;3284:					ent->r.svFlags &= ~SVF_NOCLIENT;
ADDRLP4 28
ADDRLP4 4
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 3285
;3285:					trap_LinkEntity(ent);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 3286
;3286:				}
line 3287
;3287:				break;
line 3289
;3288:			}
;3289:		}
ADDRGP4 $1550
JUMPV
LABELV $1549
line 3290
;3290:		else {
line 3291
;3291:			if (newSegmentState[segment] >= ESS_spawned) continue;
ADDRLP4 8
INDIRI4
ADDRGP4 newSegmentState
ADDP4
INDIRU1
CVUI4 1
CNSTI4 2
LTI4 $1561
ADDRGP4 $1533
JUMPV
LABELV $1561
line 3293
;3292:
;3293:			if (ent->monster) {
ADDRLP4 4
INDIRP4
CNSTI4 520
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1563
line 3294
;3294:				if (ent->health > 0) {
ADDRLP4 4
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1565
line 3297
;3295:					int cacheIndex;
;3296:
;3297:					cacheIndex = G_GetMonsterGeneric1(ent);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 G_GetMonsterGeneric1
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 24
INDIRI4
ASGNI4
line 3298
;3298:					if (cacheIndex >= 0 && cacheIndex < MAX_CACHED_MONSTERS) {
ADDRLP4 20
INDIRI4
CNSTI4 0
LTI4 $1567
ADDRLP4 20
INDIRI4
CNSTI4 1024
GEI4 $1567
line 3303
;3299:						efhCachedMonster_t* cache;
;3300:						playerState_t* ps;
;3301:						vec3_t origin;
;3302:
;3303:						cache = &cachedMonsters[cacheIndex];
ADDRLP4 32
ADDRLP4 20
INDIRI4
CNSTI4 56
MULI4
ADDRGP4 cachedMonsters
ADDP4
ASGNP4
line 3304
;3304:						cache->currentSegment = segment;
ADDRLP4 32
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 3305
;3305:						ps = G_GetEntityPlayerState(ent);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 48
ADDRLP4 52
INDIRP4
ASGNP4
line 3306
;3306:						VectorCopy(ps->origin, origin);
ADDRLP4 36
ADDRLP4 48
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 3307
;3307:						cache->position.x = (long) (level.referenceOrigin.x + origin[0]);
ADDRLP4 32
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+23032
INDIRI4
CVIF4 4
ADDRLP4 36
INDIRF4
ADDF4
CVFI4 4
ASGNI4
line 3308
;3308:						cache->position.y = (long) (level.referenceOrigin.y + origin[1]);
ADDRLP4 32
INDIRP4
CNSTI4 20
ADDP4
ADDRGP4 level+23032+4
INDIRI4
CVIF4 4
ADDRLP4 36+4
INDIRF4
ADDF4
CVFI4 4
ASGNI4
line 3309
;3309:						cache->position.z = (long) (level.referenceOrigin.z + origin[2]);
ADDRLP4 32
INDIRP4
CNSTI4 24
ADDP4
ADDRGP4 level+23032+8
INDIRI4
CVIF4 4
ADDRLP4 36+8
INDIRF4
ADDF4
CVFI4 4
ASGNI4
line 3310
;3310:						VectorCopy(ps->viewangles, cache->angles);
ADDRLP4 32
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 48
INDIRP4
CNSTI4 152
ADDP4
INDIRB
ASGNB 12
line 3311
;3311:						cache->spawnmode = MSM_atOrigin;
ADDRLP4 32
INDIRP4
CNSTI4 40
ADDP4
CNSTI4 2
ASGNI4
line 3312
;3312:						cache->action = G_MonsterAction(ent);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 G_MonsterAction
CALLI4
ASGNI4
ADDRLP4 32
INDIRP4
CNSTI4 52
ADDP4
ADDRLP4 56
INDIRI4
ASGNI4
line 3313
;3313:						if (cache->action != MA_sleeping) {
ADDRLP4 32
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 5
EQI4 $1576
line 3314
;3314:							cache->action = MA_waiting;
ADDRLP4 32
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 3315
;3315:						}
LABELV $1576
line 3316
;3316:					}
LABELV $1567
line 3317
;3317:				}
LABELV $1565
line 3318
;3318:				G_KillMonster(ent);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_KillMonster
CALLV
pop
line 3319
;3319:			}
ADDRGP4 $1564
JUMPV
LABELV $1563
line 3320
;3320:			else {
line 3321
;3321:				G_FreeEntity(ent);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 3322
;3322:			}
LABELV $1564
line 3323
;3323:		}
LABELV $1550
line 3324
;3324:	}
LABELV $1533
line 3242
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1535
ADDRLP4 0
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $1532
line 3325
;3325:}
LABELV $1531
endproc DeleteUnusedEntities 60 8
export G_UpdateWorld
proc G_UpdateWorld 104 16
line 3334
;3326:#endif
;3327:
;3328:/*
;3329:==============
;3330:JUHOX: G_UpdateWorld
;3331:==============
;3332:*/
;3333:#if ESCAPE_MODE
;3334:void G_UpdateWorld(void) {
line 3340
;3335:	int i;
;3336:	qboolean update;
;3337:	qboolean currentSegmentUpdated;
;3338:	int debugClient;
;3339:
;3340:	if (g_gametype.integer != GT_EFH) return;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
EQI4 $1579
ADDRGP4 $1578
JUMPV
LABELV $1579
line 3342
;3341:
;3342:	ExtendWorld();
ADDRGP4 ExtendWorld
CALLV
pop
line 3345
;3343:
;3344:#if MEETING
;3345:	if (level.meeting) return;
ADDRGP4 level+24092
INDIRI4
CNSTI4 0
EQI4 $1582
ADDRGP4 $1578
JUMPV
LABELV $1582
line 3348
;3346:#endif
;3347:
;3348:	memset(&newSegmentState, ESS_removed, sizeof(newSegmentState));
ADDRGP4 newSegmentState
ARGP4
CNSTI4 0
ARGI4
CNSTI4 65536
ARGI4
ADDRGP4 memset
CALLP4
pop
line 3350
;3349:
;3350:	update = qfalse;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 3351
;3351:	currentSegmentUpdated = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 3352
;3352:	debugSegment = -1;
ADDRGP4 debugSegment
CNSTI4 -1
ASGNI4
line 3353
;3353:	debugClient = -1;
ADDRLP4 12
CNSTI4 -1
ASGNI4
line 3354
;3354:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1588
JUMPV
LABELV $1585
line 3365
;3355:		int segment;
;3356:		efhVector_t segOrg;
;3357:		efhVector_t clientOrg;
;3358:		int s;
;3359:		int limit;
;3360:		efhVector_t sOrg;
;3361:		const efhSegmentType_t* segType;
;3362:		efhVector_t minOrg;
;3363:		efhVector_t maxOrg;
;3364:
;3365:		if (level.clients[i].pers.connected != CON_CONNECTED) continue;
ADDRLP4 0
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $1590
ADDRGP4 $1586
JUMPV
LABELV $1590
line 3367
;3366:
;3367:		segment = G_FindSegment(level.clients[i].ps.origin, &segOrg);
ADDRLP4 0
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 80
ARGP4
ADDRLP4 92
ADDRGP4 G_FindSegment
CALLI4
ASGNI4
ADDRLP4 64
ADDRLP4 92
INDIRI4
ASGNI4
line 3368
;3368:		if (segment < 0) {
ADDRLP4 64
INDIRI4
CNSTI4 0
GEI4 $1592
line 3369
;3369:			segment = g_entities[i].worldSegment - 1;
ADDRLP4 64
ADDRLP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+820
ADDP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 3370
;3370:			if (segment < 0) continue;
ADDRLP4 64
INDIRI4
CNSTI4 0
GEI4 $1595
ADDRGP4 $1586
JUMPV
LABELV $1595
line 3371
;3371:			FindSegmentOrigin(segment, &segOrg);
ADDRLP4 64
INDIRI4
ARGI4
ADDRLP4 80
ARGP4
ADDRGP4 FindSegmentOrigin
CALLV
pop
line 3372
;3372:		}
ADDRGP4 $1593
JUMPV
LABELV $1592
line 3373
;3373:		else if (!currentSegmentUpdated) {
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $1597
line 3374
;3374:			if (currentSegment != segment) {
ADDRGP4 currentSegment
INDIRI4
ADDRLP4 64
INDIRI4
EQI4 $1599
line 3375
;3375:				trap_SetConfigstring(
ADDRLP4 64
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 efhWorld
ADDP4
INDIRP4
ARGP4
ADDRLP4 96
ADDRGP4 SegmentName
CALLP4
ASGNP4
ADDRGP4 $1601
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 96
INDIRP4
ARGP4
ADDRLP4 100
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 721
ARGI4
ADDRLP4 100
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 3383
;3376:					CS_EFH_SEGMENT,
;3377:					va(
;3378:						"%s^7 at %s",
;3379:						level.clients[i].pers.netname,
;3380:						SegmentName(efhWorld[segment])
;3381:					)
;3382:				);
;3383:			}
LABELV $1599
line 3384
;3384:			currentSegment = segment;
ADDRGP4 currentSegment
ADDRLP4 64
INDIRI4
ASGNI4
line 3385
;3385:			currentSegmentOrigin = segOrg;
ADDRGP4 currentSegmentOrigin
ADDRLP4 80
INDIRB
ASGNB 12
line 3386
;3386:			currentSegmentUpdated = qtrue;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 3387
;3387:		}
LABELV $1597
LABELV $1593
line 3389
;3388:
;3389:		g_entities[i].worldSegment = segment + 1;
ADDRLP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities+820
ADDP4
ADDRLP4 64
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3390
;3390:		if (segment > debugSegment) {
ADDRLP4 64
INDIRI4
ADDRGP4 debugSegment
INDIRI4
LEI4 $1603
line 3391
;3391:			debugSegment = segment;
ADDRGP4 debugSegment
ADDRLP4 64
INDIRI4
ASGNI4
line 3392
;3392:			debugClient = i;
ADDRLP4 12
ADDRLP4 0
INDIRI4
ASGNI4
line 3393
;3393:		}
LABELV $1603
line 3394
;3394:		MapOriginToWorldOrigin(level.clients[i].ps.origin, &clientOrg);
ADDRLP4 0
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 68
ARGP4
ADDRGP4 MapOriginToWorldOrigin
CALLV
pop
line 3396
;3395:
;3396:		minOrg.x = clientOrg.x - MAX_VIEWDISTANCE;
ADDRLP4 36
ADDRLP4 68
INDIRI4
CNSTI4 3000
SUBI4
ASGNI4
line 3397
;3397:		minOrg.y = clientOrg.y - MAX_VIEWDISTANCE;
ADDRLP4 36+4
ADDRLP4 68+4
INDIRI4
CNSTI4 3000
SUBI4
ASGNI4
line 3398
;3398:		minOrg.z = clientOrg.z - MAX_VIEWDISTANCE;
ADDRLP4 36+8
ADDRLP4 68+8
INDIRI4
CNSTI4 3000
SUBI4
ASGNI4
line 3400
;3399:
;3400:		maxOrg.x = clientOrg.x + MAX_VIEWDISTANCE;
ADDRLP4 48
ADDRLP4 68
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 3401
;3401:		maxOrg.y = clientOrg.y + MAX_VIEWDISTANCE;
ADDRLP4 48+4
ADDRLP4 68+4
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 3402
;3402:		maxOrg.z = clientOrg.z + MAX_VIEWDISTANCE;
ADDRLP4 48+8
ADDRLP4 68+8
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 3404
;3403:
;3404:		sOrg = segOrg;
ADDRLP4 16
ADDRLP4 80
INDIRB
ASGNB 12
line 3405
;3405:		s = segment;
ADDRLP4 28
ADDRLP4 64
INDIRI4
ASGNI4
line 3406
;3406:		segType = efhWorld[s];
ADDRLP4 32
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 efhWorld
ADDP4
INDIRP4
ASGNP4
LABELV $1613
line 3407
;3407:		do {
line 3408
;3408:			ActivateSegment(s, &sOrg, ESS_spawned);
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 ActivateSegment
CALLV
pop
line 3409
;3409:			limit = s;
ADDRLP4 60
ADDRLP4 28
INDIRI4
ASGNI4
line 3411
;3410:
;3411:			if (segType->visBlocking && s != segment) break;
ADDRLP4 32
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1616
ADDRLP4 28
INDIRI4
ADDRLP4 64
INDIRI4
EQI4 $1616
ADDRGP4 $1615
JUMPV
LABELV $1616
line 3413
;3412:
;3413:			if (sOrg.x < minOrg.x) break;
ADDRLP4 16
INDIRI4
ADDRLP4 36
INDIRI4
GEI4 $1618
ADDRGP4 $1615
JUMPV
LABELV $1618
line 3414
;3414:			if (sOrg.y < minOrg.y) break;
ADDRLP4 16+4
INDIRI4
ADDRLP4 36+4
INDIRI4
GEI4 $1620
ADDRGP4 $1615
JUMPV
LABELV $1620
line 3415
;3415:			if (sOrg.z < minOrg.z) break;
ADDRLP4 16+8
INDIRI4
ADDRLP4 36+8
INDIRI4
GEI4 $1624
ADDRGP4 $1615
JUMPV
LABELV $1624
line 3417
;3416:
;3417:			if (sOrg.x > maxOrg.x) break;
ADDRLP4 16
INDIRI4
ADDRLP4 48
INDIRI4
LEI4 $1628
ADDRGP4 $1615
JUMPV
LABELV $1628
line 3418
;3418:			if (sOrg.y > maxOrg.y) break;
ADDRLP4 16+4
INDIRI4
ADDRLP4 48+4
INDIRI4
LEI4 $1630
ADDRGP4 $1615
JUMPV
LABELV $1630
line 3419
;3419:			if (sOrg.z > maxOrg.z) break;
ADDRLP4 16+8
INDIRI4
ADDRLP4 48+8
INDIRI4
LEI4 $1634
ADDRGP4 $1615
JUMPV
LABELV $1634
line 3421
;3420:
;3421:			s--;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 3422
;3422:			if (s < 0) break;
ADDRLP4 28
INDIRI4
CNSTI4 0
GEI4 $1638
ADDRGP4 $1615
JUMPV
LABELV $1638
line 3424
;3423:
;3424:			segType = efhWorld[s];
ADDRLP4 32
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 efhWorld
ADDP4
INDIRP4
ASGNP4
line 3425
;3425:			sOrg.x -= segType->exitDelta.x;
ADDRLP4 16
ADDRLP4 16
INDIRI4
ADDRLP4 32
INDIRP4
CNSTI4 568
ADDP4
INDIRI4
SUBI4
ASGNI4
line 3426
;3426:			sOrg.y -= segType->exitDelta.y;
ADDRLP4 16+4
ADDRLP4 16+4
INDIRI4
ADDRLP4 32
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
SUBI4
ASGNI4
line 3427
;3427:			sOrg.z -= segType->exitDelta.z;
ADDRLP4 16+8
ADDRLP4 16+8
INDIRI4
ADDRLP4 32
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
SUBI4
ASGNI4
line 3428
;3428:		} while (1);
LABELV $1614
ADDRGP4 $1613
JUMPV
LABELV $1615
line 3429
;3429:		s--;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 3430
;3430:		if (s >= 0) {
ADDRLP4 28
INDIRI4
CNSTI4 0
LTI4 $1642
line 3431
;3431:			segType = efhWorld[s];
ADDRLP4 32
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 efhWorld
ADDP4
INDIRP4
ASGNP4
line 3432
;3432:			sOrg.x -= segType->exitDelta.x;
ADDRLP4 16
ADDRLP4 16
INDIRI4
ADDRLP4 32
INDIRP4
CNSTI4 568
ADDP4
INDIRI4
SUBI4
ASGNI4
line 3433
;3433:			sOrg.y -= segType->exitDelta.y;
ADDRLP4 16+4
ADDRLP4 16+4
INDIRI4
ADDRLP4 32
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
SUBI4
ASGNI4
line 3434
;3434:			sOrg.z -= segType->exitDelta.z;
ADDRLP4 16+8
ADDRLP4 16+8
INDIRI4
ADDRLP4 32
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
SUBI4
ASGNI4
line 3435
;3435:			ActivateSegment(s, &sOrg, ESS_solidPartSpawned);
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 ActivateSegment
CALLV
pop
line 3436
;3436:		}
LABELV $1642
line 3437
;3437:		level.clients[i].ps.persistant[PERS_MIN_SEGMENT] = limit;
ADDRLP4 0
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 296
ADDP4
ADDRLP4 60
INDIRI4
ASGNI4
line 3439
;3438:
;3439:		sOrg = segOrg;
ADDRLP4 16
ADDRLP4 80
INDIRB
ASGNB 12
line 3440
;3440:		s = segment;
ADDRLP4 28
ADDRLP4 64
INDIRI4
ASGNI4
line 3441
;3441:		limit = segment;
ADDRLP4 60
ADDRLP4 64
INDIRI4
ASGNI4
line 3442
;3442:		segType = efhWorld[s];
ADDRLP4 32
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 efhWorld
ADDP4
INDIRP4
ASGNP4
LABELV $1646
line 3443
;3443:		do {
line 3444
;3444:			sOrg.x += segType->exitDelta.x;
ADDRLP4 16
ADDRLP4 16
INDIRI4
ADDRLP4 32
INDIRP4
CNSTI4 568
ADDP4
INDIRI4
ADDI4
ASGNI4
line 3445
;3445:			sOrg.y += segType->exitDelta.y;
ADDRLP4 16+4
ADDRLP4 16+4
INDIRI4
ADDRLP4 32
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
ADDI4
ASGNI4
line 3446
;3446:			sOrg.z += segType->exitDelta.z;
ADDRLP4 16+8
ADDRLP4 16+8
INDIRI4
ADDRLP4 32
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ADDI4
ASGNI4
line 3448
;3447:
;3448:			s++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3449
;3449:			if (s > maxSegment) break;
ADDRLP4 28
INDIRI4
ADDRGP4 maxSegment
INDIRI4
LEI4 $1651
ADDRGP4 $1648
JUMPV
LABELV $1651
line 3451
;3450:
;3451:			ActivateSegment(s, &sOrg, ESS_spawned);
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 ActivateSegment
CALLV
pop
line 3452
;3452:			limit = s;
ADDRLP4 60
ADDRLP4 28
INDIRI4
ASGNI4
line 3454
;3453:
;3454:			segType = efhWorld[s];
ADDRLP4 32
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 efhWorld
ADDP4
INDIRP4
ASGNP4
line 3455
;3455:			if (segType->visBlocking) break;
ADDRLP4 32
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1653
ADDRGP4 $1648
JUMPV
LABELV $1653
line 3456
;3456:		} while (
LABELV $1647
line 3457
;3457:			sOrg.x >= minOrg.x &&
ADDRLP4 96
ADDRLP4 16
INDIRI4
ASGNI4
ADDRLP4 96
INDIRI4
ADDRLP4 36
INDIRI4
LTI4 $1667
ADDRLP4 16+4
INDIRI4
ADDRLP4 36+4
INDIRI4
LTI4 $1667
ADDRLP4 16+8
INDIRI4
ADDRLP4 36+8
INDIRI4
LTI4 $1667
ADDRLP4 96
INDIRI4
ADDRLP4 48
INDIRI4
GTI4 $1667
ADDRLP4 16+4
INDIRI4
ADDRLP4 48+4
INDIRI4
GTI4 $1667
ADDRLP4 16+8
INDIRI4
ADDRLP4 48+8
INDIRI4
LEI4 $1646
LABELV $1667
LABELV $1648
line 3464
;3458:			sOrg.y >= minOrg.y &&
;3459:			sOrg.z >= minOrg.z &&
;3460:			sOrg.x <= maxOrg.x &&
;3461:			sOrg.y <= maxOrg.y &&
;3462:			sOrg.z <= maxOrg.z
;3463:		);
;3464:		s++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3465
;3465:		if (s <= maxSegment) {
ADDRLP4 28
INDIRI4
ADDRGP4 maxSegment
INDIRI4
GTI4 $1668
line 3466
;3466:			sOrg.x += segType->exitDelta.x;
ADDRLP4 16
ADDRLP4 16
INDIRI4
ADDRLP4 32
INDIRP4
CNSTI4 568
ADDP4
INDIRI4
ADDI4
ASGNI4
line 3467
;3467:			sOrg.y += segType->exitDelta.y;
ADDRLP4 16+4
ADDRLP4 16+4
INDIRI4
ADDRLP4 32
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
ADDI4
ASGNI4
line 3468
;3468:			sOrg.z += segType->exitDelta.z;
ADDRLP4 16+8
ADDRLP4 16+8
INDIRI4
ADDRLP4 32
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ADDI4
ASGNI4
line 3469
;3469:			ActivateSegment(s, &sOrg, ESS_solidPartSpawned);
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 ActivateSegment
CALLV
pop
line 3470
;3470:		}
LABELV $1668
line 3471
;3471:		level.clients[i].ps.persistant[PERS_MAX_SEGMENT] = limit;
ADDRLP4 0
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 300
ADDP4
ADDRLP4 60
INDIRI4
ASGNI4
line 3473
;3472:
;3473:		update = qtrue;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 3474
;3474:	}
LABELV $1586
line 3354
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1588
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $1585
line 3476
;3475:
;3476:	if (debugClient >= 0) {
ADDRLP4 12
INDIRI4
CNSTI4 0
LTI4 $1672
line 3479
;3477:		vec3_t dir;
;3478:
;3479:		AngleVectors(level.clients[debugClient].ps.viewangles, dir, NULL, NULL);
ADDRLP4 12
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 152
ADDP4
ARGP4
ADDRLP4 16
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 3480
;3480:		debugSegment += dir[0] < 0? -1 : +1;
ADDRLP4 16
INDIRF4
CNSTF4 0
GEF4 $1675
ADDRLP4 28
CNSTI4 -1
ASGNI4
ADDRGP4 $1676
JUMPV
LABELV $1675
ADDRLP4 28
CNSTI4 1
ASGNI4
LABELV $1676
ADDRLP4 32
ADDRGP4 debugSegment
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
ADDRLP4 28
INDIRI4
ADDI4
ASGNI4
line 3481
;3481:	}
LABELV $1672
line 3483
;3482:
;3483:	if (!update) return;
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1677
ADDRGP4 $1578
JUMPV
LABELV $1677
line 3485
;3484:
;3485:	DeleteUnusedEntities();
ADDRGP4 DeleteUnusedEntities
CALLV
pop
line 3487
;3486:
;3487:	memcpy(&segmentState, &newSegmentState, sizeof(segmentState));
ADDRGP4 segmentState
ARGP4
ADDRGP4 newSegmentState
ARGP4
CNSTI4 65536
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 3489
;3488:
;3489:	SpawnCachedMonsters();
ADDRGP4 SpawnCachedMonsters
CALLV
pop
line 3491
;3490:
;3491:	G_UpdateSegmentInfo();
ADDRGP4 G_UpdateSegmentInfo
CALLV
pop
line 3492
;3492:}
LABELV $1578
endproc G_UpdateWorld 104 16
export G_MakeWorldAwareOfMonsterDeath
proc G_MakeWorldAwareOfMonsterDeath 16 4
line 3501
;3493:#endif
;3494:
;3495:/*
;3496:==============
;3497:JUHOX: G_MakeWorldAwareOfMonsterDeath
;3498:==============
;3499:*/
;3500:#if ESCAPE_MODE
;3501:void G_MakeWorldAwareOfMonsterDeath(gentity_t* monster) {
line 3505
;3502:	int cacheIndex;
;3503:	efhCachedMonster_t* cache;
;3504:
;3505:	if (g_gametype.integer != GT_EFH) return;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
EQI4 $1680
ADDRGP4 $1679
JUMPV
LABELV $1680
line 3507
;3506:
;3507:	cacheIndex = G_GetMonsterGeneric1(monster);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 G_GetMonsterGeneric1
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 3508
;3508:	if (cacheIndex < 0 || cacheIndex >= MAX_CACHED_MONSTERS) return;
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1685
ADDRLP4 0
INDIRI4
CNSTI4 1024
LTI4 $1683
LABELV $1685
ADDRGP4 $1679
JUMPV
LABELV $1683
line 3510
;3509:
;3510:	cache = &cachedMonsters[cacheIndex];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 56
MULI4
ADDRGP4 cachedMonsters
ADDP4
ASGNP4
line 3511
;3511:	FreeMonsterCache(cache);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 FreeMonsterCache
CALLV
pop
line 3512
;3512:}
LABELV $1679
endproc G_MakeWorldAwareOfMonsterDeath 16 4
export G_GetTotalWayLength
proc G_GetTotalWayLength 48 12
line 3521
;3513:#endif
;3514:
;3515:/*
;3516:==============
;3517:JUHOX: G_GetTotalWayLength
;3518:==============
;3519:*/
;3520:#if ESCAPE_MODE
;3521:long G_GetTotalWayLength(gentity_t* ent) {
line 3527
;3522:	playerState_t* ps;
;3523:	vec3_t origin;
;3524:	int segment;
;3525:	efhVector_t segOrg;
;3526:
;3527:	if (g_gametype.integer != GT_EFH) return 0;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
EQI4 $1687
CNSTI4 0
RETI4
ADDRGP4 $1686
JUMPV
LABELV $1687
line 3529
;3528:
;3529:	ps = G_GetEntityPlayerState(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 32
INDIRP4
ASGNP4
line 3530
;3530:	if (ps) {
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1690
line 3531
;3531:		VectorCopy(ps->origin, origin);
ADDRLP4 4
ADDRLP4 16
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 3532
;3532:	}
ADDRGP4 $1691
JUMPV
LABELV $1690
line 3533
;3533:	else {
line 3534
;3534:		VectorCopy(ent->r.currentOrigin, origin);
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 3535
;3535:	}
LABELV $1691
line 3537
;3536:
;3537:	segment = G_FindSegment(origin, &segOrg);
ADDRLP4 4
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 36
ADDRGP4 G_FindSegment
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 36
INDIRI4
ASGNI4
line 3538
;3538:	if (segment < 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $1692
line 3539
;3539:		segment = ent->worldSegment - 1;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 3540
;3540:		if (segment < 0) return 0;
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $1694
CNSTI4 0
RETI4
ADDRGP4 $1686
JUMPV
LABELV $1694
line 3541
;3541:		FindSegmentOrigin(segment, &segOrg);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 20
ARGP4
ADDRGP4 FindSegmentOrigin
CALLV
pop
line 3542
;3542:	}
LABELV $1692
line 3543
;3543:	if (segment <= 0) return 0;
ADDRLP4 0
INDIRI4
CNSTI4 0
GTI4 $1696
CNSTI4 0
RETI4
ADDRGP4 $1686
JUMPV
LABELV $1696
line 3545
;3544:
;3545:	return totalWayLength[segment] + SegmentWayLength(origin, efhWorld[segment], &segOrg);
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 efhWorld
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 44
ADDRGP4 SegmentWayLength
CALLU4
ASGNU4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 totalWayLength
ADDP4
INDIRU4
ADDRLP4 44
INDIRU4
ADDU4
CVUI4 4
RETI4
LABELV $1686
endproc G_GetTotalWayLength 48 12
proc G_GetLightingOrigin 64 8
line 3555
;3546:}
;3547:#endif
;3548:
;3549:/*
;3550:==============
;3551:JUHOX: G_GetLightingOrigin
;3552:==============
;3553:*/
;3554:#if ESCAPE_MODE
;3555:static void G_GetLightingOrigin(gentity_t* ent, vec3_t lightingOrigin) {
line 3563
;3556:	playerState_t* ps;
;3557:	vec3_t origin;
;3558:	int segment;
;3559:	efhVector_t segOrg;
;3560:	vec3_t segMapOrg;
;3561:	vec3_t delta;
;3562:
;3563:	ps = G_GetEntityPlayerState(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 40
ADDRLP4 56
INDIRP4
ASGNP4
line 3564
;3564:	if (ps) {
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1699
line 3565
;3565:		VectorCopy(ps->origin, origin);
ADDRLP4 16
ADDRLP4 40
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 3566
;3566:	}
ADDRGP4 $1700
JUMPV
LABELV $1699
line 3567
;3567:	else {
line 3568
;3568:		VectorCopy(ent->r.currentOrigin, origin);
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 3569
;3569:	}
LABELV $1700
line 3570
;3570:	segment = G_FindSegment(origin, &segOrg);
ADDRLP4 16
ARGP4
ADDRLP4 44
ARGP4
ADDRLP4 60
ADDRGP4 G_FindSegment
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 60
INDIRI4
ASGNI4
line 3571
;3571:	if (segment < 0) {
ADDRLP4 12
INDIRI4
CNSTI4 0
GEI4 $1701
line 3572
;3572:		segment = currentSegment;
ADDRLP4 12
ADDRGP4 currentSegment
INDIRI4
ASGNI4
line 3573
;3573:		segOrg = currentSegmentOrigin;
ADDRLP4 44
ADDRGP4 currentSegmentOrigin
INDIRB
ASGNB 12
line 3574
;3574:	}
LABELV $1701
line 3575
;3575:	WorldOriginToMapOrigin(&segOrg, segMapOrg);
ADDRLP4 44
ARGP4
ADDRLP4 28
ARGP4
ADDRGP4 WorldOriginToMapOrigin
CALLV
pop
line 3576
;3576:	VectorSubtract(origin, segMapOrg, delta);
ADDRLP4 0
ADDRLP4 16
INDIRF4
ADDRLP4 28
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 16+4
INDIRF4
ADDRLP4 28+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 16+8
INDIRF4
ADDRLP4 28+8
INDIRF4
SUBF4
ASGNF4
line 3577
;3577:	VectorAdd(efhWorld[segment]->entranceOrigin, delta, lightingOrigin);
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 efhWorld
ADDP4
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 efhWorld
ADDP4
INDIRP4
CNSTI4 532
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
ADDF4
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 efhWorld
ADDP4
INDIRP4
CNSTI4 536
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
ADDF4
ASGNF4
line 3578
;3578:}
LABELV $1698
endproc G_GetLightingOrigin 64 8
export G_UpdateLightingOrigins
proc G_UpdateLightingOrigins 36 8
line 3587
;3579:#endif
;3580:
;3581:/*
;3582:==============
;3583:JUHOX: G_UpdateLightingOrigins
;3584:==============
;3585:*/
;3586:#if ESCAPE_MODE
;3587:void G_UpdateLightingOrigins(void) {
line 3590
;3588:	int i;
;3589:
;3590:	if (g_gametype.integer != GT_EFH) return;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
EQI4 $1712
ADDRGP4 $1711
JUMPV
LABELV $1712
line 3592
;3591:
;3592:	for (i = 0; i < level.num_entities; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1718
JUMPV
LABELV $1715
line 3597
;3593:		gentity_t* ent;
;3594:		playerState_t* ps;
;3595:		vec3_t lightingOrigin;
;3596:
;3597:		ent = &g_entities[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 3598
;3598:		if (!ent->inuse) continue;
ADDRLP4 4
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1720
ADDRGP4 $1716
JUMPV
LABELV $1720
line 3599
;3599:		if (ent->freeAfterEvent) continue;
ADDRLP4 4
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1722
ADDRGP4 $1716
JUMPV
LABELV $1722
line 3601
;3600:		//if (!ent->r.linked && ent->neverFree) continue;
;3601:		if (!ent->r.linked) continue;
ADDRLP4 4
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1724
ADDRGP4 $1716
JUMPV
LABELV $1724
line 3602
;3602:		if (ent->s.solid == SOLID_BMODEL) continue;
ADDRLP4 4
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 16777215
NEI4 $1726
ADDRGP4 $1716
JUMPV
LABELV $1726
line 3603
;3603:		if (ent->s.eFlags & EF_NODRAW) continue;
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $1728
ADDRGP4 $1716
JUMPV
LABELV $1728
line 3604
;3604:		if (ent->r.svFlags & SVF_NOCLIENT) continue;
ADDRLP4 4
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1730
ADDRGP4 $1716
JUMPV
LABELV $1730
line 3605
;3605:		switch (ent->s.eType) {
ADDRLP4 24
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $1716
ADDRLP4 24
INDIRI4
CNSTI4 2
EQI4 $1736
ADDRLP4 24
INDIRI4
CNSTI4 3
EQI4 $1716
ADDRGP4 $1732
JUMPV
line 3608
;3606:		case ET_GENERAL:
;3607:		case ET_MISSILE:
;3608:			continue;
LABELV $1736
line 3610
;3609:		case ET_ITEM:
;3610:			if (ent->s.pos.trType == TR_STATIONARY) continue;
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1733
ADDRGP4 $1716
JUMPV
line 3611
;3611:			break;
LABELV $1732
LABELV $1733
line 3614
;3612:		}
;3613:
;3614:		G_GetLightingOrigin(ent, lightingOrigin);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 G_GetLightingOrigin
CALLV
pop
line 3616
;3615:
;3616:		ps = G_GetEntityPlayerState(ent);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 G_GetEntityPlayerState
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 32
INDIRP4
ASGNP4
line 3617
;3617:		if (ps) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1739
line 3618
;3618:			ps->persistant[PERS_LIGHT_X] = lightingOrigin[0];
ADDRLP4 8
INDIRP4
CNSTI4 284
ADDP4
ADDRLP4 12
INDIRF4
CVFI4 4
ASGNI4
line 3619
;3619:			ps->persistant[PERS_LIGHT_Y] = lightingOrigin[1];
ADDRLP4 8
INDIRP4
CNSTI4 288
ADDP4
ADDRLP4 12+4
INDIRF4
CVFI4 4
ASGNI4
line 3620
;3620:			ps->persistant[PERS_LIGHT_Z] = lightingOrigin[2];
ADDRLP4 8
INDIRP4
CNSTI4 292
ADDP4
ADDRLP4 12+8
INDIRF4
CVFI4 4
ASGNI4
line 3622
;3621:			//VectorCopy(lightingOrigin, ent->s.origin);
;3622:		}
ADDRGP4 $1740
JUMPV
LABELV $1739
line 3623
;3623:		else {
line 3624
;3624:			VectorCopy(lightingOrigin, ent->s.angles2);
ADDRLP4 4
INDIRP4
CNSTI4 128
ADDP4
ADDRLP4 12
INDIRB
ASGNB 12
line 3625
;3625:		}
LABELV $1740
line 3626
;3626:	}
LABELV $1716
line 3592
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1718
ADDRLP4 0
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $1715
line 3627
;3627:}
LABELV $1711
endproc G_UpdateLightingOrigins 36 8
export G_EFH_SpaceExtent
proc G_EFH_SpaceExtent 0 0
line 3636
;3628:#endif
;3629:
;3630:/*
;3631:==============
;3632:JUHOX: G_EFH_SpaceExtent
;3633:==============
;3634:*/
;3635:#if ESCAPE_MODE
;3636:void G_EFH_SpaceExtent(vec3_t mins, vec3_t maxs) {
line 3637
;3637:	VectorCopy(efhSpaceMins, mins);
ADDRFP4 0
INDIRP4
ADDRGP4 efhSpaceMins
INDIRB
ASGNB 12
line 3638
;3638:	VectorCopy(efhSpaceMaxs, maxs);
ADDRFP4 4
INDIRP4
ADDRGP4 efhSpaceMaxs
INDIRB
ASGNB 12
line 3639
;3639:}
LABELV $1743
endproc G_EFH_SpaceExtent 0 0
export G_EFH_NextDebugSegment
proc G_EFH_NextDebugSegment 16 20
line 3648
;3640:#endif
;3641:
;3642:/*
;3643:==============
;3644:JUHOX: G_EFH_NextDebugSegment
;3645:==============
;3646:*/
;3647:#if ESCAPE_MODE
;3648:void G_EFH_NextDebugSegment(int dir) {
line 3649
;3649:	if (g_gametype.integer != GT_EFH) return;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
EQI4 $1745
ADDRGP4 $1744
JUMPV
LABELV $1745
line 3650
;3650:	if (!g_debugEFH.integer) return;
ADDRGP4 g_debugEFH+12
INDIRI4
CNSTI4 0
NEI4 $1748
ADDRGP4 $1744
JUMPV
LABELV $1748
line 3651
;3651:	if (numSegmentTypes <= 0) return;
ADDRGP4 numSegmentTypes
INDIRI4
CNSTI4 0
GTI4 $1751
ADDRGP4 $1744
JUMPV
LABELV $1751
line 3653
;3652:
;3653:	dir %= numSegmentTypes;
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRGP4 numSegmentTypes
INDIRI4
MODI4
ASGNI4
line 3654
;3654:	dir += numSegmentTypes;
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRGP4 numSegmentTypes
INDIRI4
ADDI4
ASGNI4
line 3655
;3655:	debugModeChoosenSegmentType += dir;
ADDRLP4 0
ADDRGP4 debugModeChoosenSegmentType
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRFP4 0
INDIRI4
ADDI4
ASGNI4
line 3656
;3656:	debugModeChoosenSegmentType %= numSegmentTypes;
ADDRLP4 4
ADDRGP4 debugModeChoosenSegmentType
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
ADDRGP4 numSegmentTypes
INDIRI4
MODI4
ASGNI4
line 3657
;3657:	trap_SetConfigstring(
ADDRGP4 $1753
ARGP4
ADDRLP4 8
ADDRGP4 debugModeChoosenSegmentType
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 764
MULI4
ADDRGP4 segmentTypes+632
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 numSegmentTypes
INDIRI4
ARGI4
ADDRGP4 debugSegment
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 720
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 3667
;3658:		CS_EFH_DEBUG,
;3659:		va(
;3660:			"'%s' #%d/%d @%d",
;3661:			segmentTypes[debugModeChoosenSegmentType].name,
;3662:			debugModeChoosenSegmentType + 1,
;3663:			numSegmentTypes,
;3664:			debugSegment
;3665:		)
;3666:	);
;3667:}
LABELV $1744
endproc G_EFH_NextDebugSegment 16 20
import SP_team_CTF_bluespawn
import SP_team_CTF_redspawn
import SP_team_CTF_blueplayer
import SP_team_CTF_redplayer
import SP_shooter_grenade
import SP_shooter_plasma
import SP_shooter_rocket
import SP_misc_portal_surface
import SP_misc_portal_camera
import SP_misc_model
import SP_misc_teleporter_dest
import SP_path_corner
import SP_info_camp
import SP_info_notnull
import SP_info_null
import SP_light
import SP_target_earthquake
import SP_target_push
import SP_target_location
import SP_target_position
import SP_target_kill
import SP_target_relay
import SP_target_teleporter
import SP_target_score
import SP_target_character
import SP_target_laser
import SP_target_print
import SP_target_speaker
import SP_target_delay
import SP_target_give
import SP_target_remove_powerups
import SP_trigger_hurt
import SP_trigger_teleport
import SP_trigger_push
import SP_trigger_multiple
import SP_trigger_always
import SP_func_timer
import SP_func_train
import SP_func_door
import SP_func_button
import SP_func_pendulum
import SP_func_bobbing
import SP_func_rotating
import SP_func_static
import SP_func_plat
import SP_info_podium
import SP_info_thirdplace
import SP_info_secondplace
import SP_info_firstplace
import SP_info_player_intermission
import SP_info_player_deathmatch
import SP_info_player_start
bss
align 4
LABELV monsterSpawnSeed
skip 4
align 4
LABELV worldCreationSeed
skip 16
align 4
LABELV worldEnd
skip 4
align 4
LABELV worldWayLength
skip 4
align 4
LABELV worldStyle
skip 4
align 4
LABELV transitionStyles
skip 4400
align 4
LABELV numTransitionStyles
skip 4
align 4
LABELV cachedMonsters
skip 57344
align 4
LABELV maxSegment
skip 4
align 4
LABELV currentSegmentOrigin
skip 12
align 4
LABELV currentSegment
skip 4
align 4
LABELV numFallbacks
skip 4
align 1
LABELV visitedSegments
skip 8192
align 1
LABELV newSegmentState
skip 65536
align 1
LABELV segmentState
skip 65536
align 4
LABELV totalWayLength
skip 262144
align 4
LABELV efhWorld
skip 262144
align 4
LABELV oldDebugSegment
skip 4
align 4
LABELV debugSegment
skip 4
align 4
LABELV debugModeChoosenSegmentType
skip 4
align 4
LABELV segmentTypes
skip 196348
align 4
LABELV numSegmentTypes
skip 4
align 4
LABELV entityTemplates
skip 3457024
align 4
LABELV numEntityTemplates
skip 4
align 4
LABELV efhSpaceMaxs
skip 12
align 4
LABELV efhSpaceMins
skip 12
import trap_SnapVector
import trap_GeneticParentsAndChildSelection
import trap_BotResetWeaponState
import trap_BotFreeWeaponState
import trap_BotAllocWeaponState
import trap_BotLoadWeaponWeights
import trap_BotGetWeaponInfo
import trap_BotChooseBestFightWeapon
import trap_BotAddAvoidSpot
import trap_BotInitMoveState
import trap_BotFreeMoveState
import trap_BotAllocMoveState
import trap_BotPredictVisiblePosition
import trap_BotMovementViewTarget
import trap_BotReachabilityArea
import trap_BotResetLastAvoidReach
import trap_BotResetAvoidReach
import trap_BotMoveInDirection
import trap_BotMoveToGoal
import trap_BotResetMoveState
import trap_BotFreeGoalState
import trap_BotAllocGoalState
import trap_BotMutateGoalFuzzyLogic
import trap_BotSaveGoalFuzzyLogic
import trap_BotInterbreedGoalFuzzyLogic
import trap_BotFreeItemWeights
import trap_BotLoadItemWeights
import trap_BotUpdateEntityItems
import trap_BotInitLevelItems
import trap_BotSetAvoidGoalTime
import trap_BotAvoidGoalTime
import trap_BotGetLevelItemGoal
import trap_BotGetMapLocationGoal
import trap_BotGetNextCampSpotGoal
import trap_BotItemGoalInVisButNotVisible
import trap_BotTouchingGoal
import trap_BotChooseNBGItem
import trap_BotChooseLTGItem
import trap_BotGetSecondGoal
import trap_BotGetTopGoal
import trap_BotGoalName
import trap_BotDumpGoalStack
import trap_BotDumpAvoidGoals
import trap_BotEmptyGoalStack
import trap_BotPopGoal
import trap_BotPushGoal
import trap_BotResetAvoidGoals
import trap_BotRemoveFromAvoidGoals
import trap_BotResetGoalState
import trap_BotSetChatName
import trap_BotSetChatGender
import trap_BotLoadChatFile
import trap_BotReplaceSynonyms
import trap_UnifyWhiteSpaces
import trap_BotMatchVariable
import trap_BotFindMatch
import trap_StringContains
import trap_BotGetChatMessage
import trap_BotEnterChat
import trap_BotChatLength
import trap_BotReplyChat
import trap_BotNumInitialChats
import trap_BotInitialChat
import trap_BotNumConsoleMessages
import trap_BotNextConsoleMessage
import trap_BotRemoveConsoleMessage
import trap_BotQueueConsoleMessage
import trap_BotFreeChatState
import trap_BotAllocChatState
import trap_Characteristic_String
import trap_Characteristic_BInteger
import trap_Characteristic_Integer
import trap_Characteristic_BFloat
import trap_Characteristic_Float
import trap_BotFreeCharacter
import trap_BotLoadCharacter
import trap_EA_ResetInput
import trap_EA_GetInput
import trap_EA_EndRegular
import trap_EA_View
import trap_EA_Move
import trap_EA_DelayedJump
import trap_EA_Jump
import trap_EA_SelectWeapon
import trap_EA_MoveRight
import trap_EA_MoveLeft
import trap_EA_MoveBack
import trap_EA_MoveForward
import trap_EA_MoveDown
import trap_EA_MoveUp
import trap_EA_Crouch
import trap_EA_Respawn
import trap_EA_Use
import trap_EA_Attack
import trap_EA_Talk
import trap_EA_Gesture
import trap_EA_Action
import trap_EA_Command
import trap_EA_SayTeam
import trap_EA_Say
import trap_AAS_PredictClientMovement
import trap_AAS_Swimming
import trap_AAS_AlternativeRouteGoals
import trap_AAS_PredictRoute
import trap_AAS_EnableRoutingArea
import trap_AAS_AreaTravelTimeToGoalArea
import trap_AAS_AreaReachability
import trap_AAS_IntForBSPEpairKey
import trap_AAS_FloatForBSPEpairKey
import trap_AAS_VectorForBSPEpairKey
import trap_AAS_ValueForBSPEpairKey
import trap_AAS_NextBSPEntity
import trap_AAS_PointContents
import trap_AAS_TraceAreas
import trap_AAS_PointReachabilityAreaIndex
import trap_AAS_PointAreaNum
import trap_AAS_Time
import trap_AAS_PresenceTypeBoundingBox
import trap_AAS_Initialized
import trap_AAS_EntityInfo
import trap_AAS_AreaInfo
import trap_AAS_BBoxAreas
import trap_BotUserCommand
import trap_BotGetServerCommand
import trap_BotGetSnapshotEntity
import trap_BotLibTest
import trap_BotLibUpdateEntity
import trap_BotLibLoadMap
import trap_BotLibStartFrame
import trap_BotLibDefine
import trap_BotLibVarGet
import trap_BotLibVarSet
import trap_BotLibShutdown
import trap_BotLibSetup
import trap_DebugPolygonDelete
import trap_DebugPolygonCreate
import trap_GetEntityToken
import trap_GetUsercmd
import trap_BotFreeClient
import trap_BotAllocateClient
import trap_EntityContact
import trap_EntitiesInBox
import trap_UnlinkEntity
import trap_LinkEntity
import trap_AreasConnected
import trap_AdjustAreaPortalState
import trap_InPVSIgnorePortals
import trap_InPVS
import trap_PointContents
import trap_Trace
import trap_SetBrushModel
import trap_GetServerinfo
import trap_SetUserinfo
import trap_GetUserinfo
import trap_GetConfigstring
import trap_SetConfigstring
import trap_SendServerCommand
import trap_DropClient
import trap_LocateGameData
import trap_Cvar_VariableStringBuffer
import trap_Cvar_VariableValue
import trap_Cvar_VariableIntegerValue
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_SendConsoleCommand
import trap_FS_Seek
import trap_FS_GetFileList
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_FS_FOpenFile
import trap_Args
import trap_Argv
import trap_Argc
import trap_Milliseconds
import trap_Error
import trap_Printf
import g_mapName
import g_proxMineTimeout
import g_singlePlayer
import g_enableBreath
import g_enableDust
import g_rankings
import pmove_msec
import pmove_fixed
import g_smoothClients
import g_blueteam
import g_redteam
import g_cubeTimeout
import g_obeliskRespawnDelay
import g_obeliskRegenAmount
import g_obeliskRegenPeriod
import g_obeliskHealth
import g_filterBan
import g_banIPs
import g_teamForceBalance
import g_teamAutoJoin
import g_allowVote
import g_blood
import g_doWarmup
import g_warmup
import g_motd
import g_synchronousClients
import g_weaponTeamRespawn
import g_weaponRespawn
import g_debugDamage
import g_debugAlloc
import g_debugMove
import g_inactivity
import g_forcerespawn
import g_quadfactor
import g_knockback
import g_speed
import g_gravity
import g_needpass
import g_password
import g_friendlyFire
import g_meeting
import g_weaponLimit
import g_cloakingDevice
import g_unlimitedAmmo
import g_noHealthRegen
import g_noItems
import g_grapple
import g_lightningDamageLimit
import g_baseHealth
import g_stamina
import g_armorFragments
import g_tssSafetyMode
import g_tss
import g_respawnAtPOD
import g_respawnDelay
import g_gameSeed
import g_template
import g_debugEFH
import g_challengingEnv
import g_distanceLimit
import g_monsterLoad
import g_scoreMode
import g_monsterProgression
import g_monsterBreeding
import g_maxMonstersPP
import g_monsterLauncher
import g_skipEndSequence
import g_monstersPerTrap
import g_monsterTitans
import g_monsterGuards
import g_monsterHealthScale
import g_monsterSpawnDelay
import g_maxMonsters
import g_minMonsters
import g_artefacts
import g_capturelimit
import g_timelimit
import g_fraglimit
import g_dmflags
import g_restarted
import g_maxGameClients
import g_maxclients
import g_cheats
import g_dedicated
import g_gametype
import g_editmode
import g_entities
import level
import Pickup_Team
import CheckTeamStatus
import TeamplayInfoMessage
import Team_GetLocationMsg
import Team_GetLocation
import SelectCTFSpawnPoint
import Team_FreeEntity
import Team_ReturnFlag
import Team_InitGame
import Team_CheckHurtCarrier
import Team_FragBonuses
import Team_DroppedFlagThink
import AddTeamScore
import TeamColorString
import OtherTeamName
import TeamName
import OtherTeam
import BotTestAAS
import BotAIStartFrame
import BotAIShutdownClient
import BotAISetupClient
import BotAILoadMap
import BotAIShutdown
import BotAISetup
import IsPlayerFighting
import G_Constitution
import G_GetEntityPlayerState
import EntityAudible
import G_MonsterAction
import G_CheckMonsterDamage
import G_GetMonsterGeneric1
import G_IsMovable
import G_CanBeDamaged
import G_UpdateMonsterCounters
import G_AddMonsterSeed
import G_ReleaseTrap
import G_IsFriendlyMonster
import G_MonsterOwner
import G_IsAttackingGuard
import G_ChargeMonsters
import G_IsMonsterSuccessfulAttacking
import G_IsMonsterNearEntity
import IsFightingMonster
import G_MonsterSpawning
import G_SpawnMonster
import G_MonsterType
import G_MonsterBaseHealth
import G_MonsterHealthScale
import G_GetMonsterSpawnPoint
import G_GetMonsterBounds
import G_KillMonster
import G_MonsterScanForNoises
import CheckTouchedMonsters
import G_NumMonsters
import G_UpdateMonsterCS
import G_InitMonsters
import BotInterbreedEndMatch
import Svcmd_BotList_f
import Svcmd_AddBot_f
import G_BotConnect
import G_RemoveQueuedBotBegin
import G_CheckBotSpawn
import G_GetBotInfoByName
import G_GetBotInfoByNumber
import G_InitBots
import Svcmd_AbortPodium_f
import SpawnModelsOnVictoryPads
import UpdateTournamentInfo
import G_WriteSessionData
import G_InitWorldSession
import G_InitSessionData
import G_ReadSessionData
import Svcmd_GameMem_f
import G_InitMemory
import G_Alloc
import CheckObeliskAttack
import Team_GetDroppedOrTakenFlag
import Team_CheckDroppedItem
import OnSameTeam
import Team_GetFlagStatus
import G_RunClient
import ClientEndFrame
import ClientThink
import ClientImpacts
import SetTargetPos
import CheckPlayerDischarge
import TotalChargeDamage
import TSS_Run
import TSS_DangerIndex
import IsPlayerInvolvedInFighting
import NearHomeBase
import ClientCommand
import ClientBegin
import ClientDisconnect
import ClientUserinfoChanged
import ClientSetPlayerClass
import ClientConnect
import SelectAppropriateSpawnPoint
import LogExit
import G_Error
import G_Printf
import SendScoreboardMessageToAllClients
import G_LogPrintf
import G_RunThink
import G_SetPlayerRefOrigin
import CheckTeamLeader
import SetLeader
import FindIntermissionPoint
import DeathmatchScoreboardMessage
import G_SetStats
import MoveClientToIntermission
import FireWeapon
import G_FilterPacket
import G_ProcessIPBans
import ConsoleCommand
import PositionWouldTelefrag
import SpotWouldTelefrag
import CalculateRanks
import AddScore
import player_die
import ClientSpawn
import InitBodyQue
import InitClientResp
import InitClientPersistant
import BeginIntermission
import respawn
import CopyToBodyQue
import SelectSpawnPoint
import SetClientViewAngle
import PickTeam
import TeamLeader
import TeamCount
import GetRespawnLocationType
import ForceRespawn
import Weapon_HookThink
import Weapon_HookFree
import CheckTitanAttack
import CheckGauntletAttack
import SnapVectorTowards
import CalcMuzzlePoint
import LogAccuracyHit
import Weapon_GrapplingHook_Throw
import TeleportPlayer
import trigger_teleporter_touch
import InitMover
import Touch_DoorTrigger
import G_RunMover
import fire_monster_seed
import fire_grapple
import fire_bfg
import fire_rocket
import fire_grenade
import fire_plasma
import fire_blaster
import G_RunMissile
import GibEntity
import ScorePlum
import DropArmor
import DropHealth
import TossClientCubes
import TossClientItems
import body_die
import G_InvulnerabilityEffect
import G_RadiusDamage
import G_Damage
import CanDamage
import DoOverkill
import BuildShaderStateConfig
import AddRemap
import G_SetOrigin
import G_AddEvent
import G_AddPredictableEvent
import vectoyaw
import vtos
import tv
import G_acos
import G_TouchSolids
import G_TouchTriggers
import G_EntitiesFree
import G_FreeEntity
import G_Sound
import G_TempEntity
import G_NumEntitiesFree
import G_Spawn
import G_InitGentity
import G_SetMovedir
import G_UseTargets
import G_PickTarget
import G_Find
import G_KillBox
import G_TeamCommand
import G_SoundIndex
import G_ModelIndex
import SaveRegisteredItems
import RegisterItem
import ClearRegisteredItems
import G_SpawnArtefact
import G_BounceItemRotation
import Touch_Item
import Add_Ammo
import ArmorIndex
import Think_Weapon
import FinishSpawningItem
import G_SpawnItem
import SetRespawn
import LaunchItem
import Drop_Item
import PrecacheItem
import UseHoldableItem
import RespawnItem
import G_RunItem
import G_CheckTeamItems
import G_Say
import Cmd_FollowCycle_f
import SetTeam
import BroadcastTeamChange
import StopFollowing
import Cmd_Score_f
import G_PlayTemplate
import G_PrintTemplateList
import G_SendGameTemplate
import G_TemplateList_Error
import G_TemplateList_Stop
import G_TemplateList_Request
import G_RestartGameTemplates
import G_DefineTemplate
import G_SetTemplateName
import G_LoadGameTemplates
import G_InitGameTemplates
import sv_mapChecksum
import templateList
import numTemplateFiles
import templateFileList
import InitLocalSeed
import SeededRandom
import SetGameSeed
import BG_PlayerTargetOffset
import BG_PlayerTouchesItem
import BG_PlayerStateToEntityStateExtraPolate
import BG_PlayerStateToEntityState
import BG_TouchJumpPad
import BG_AddPredictableEventToPlayerstate
import BG_EvaluateTrajectoryDelta
import BG_EvaluateTrajectory
import BG_CanItemBeGrabbed
import BG_FindItemForHoldable
import BG_FindItemForPowerup
import BG_FindItemForWeapon
import BG_FindItem
import bg_numItems
import bg_itemlist
import weaponAmmoCharacteristics
import Pmove
import PM_UpdateViewAngles
import BG_TSS_GetPlayerEntityInfo
import BG_TSS_GetPlayerInfo
import BG_TSS_SetPlayerInfo
import BG_TSS_DecodeLeadership
import BG_TSS_CodeLeadership
import BG_TSS_DecodeInstructions
import BG_TSS_CodeInstructions
import TSS_DecodeInt
import TSS_CodeInt
import TSS_DecodeNibble
import TSS_CodeNibble
import BG_TSS_AssignPlayers
import BG_TSS_TakeProportionAway
import BG_TSS_Proportion
import BG_VectorChecksum
import BG_ChecksumChar
import BG_TemplateChecksum
import BG_GetGameTemplateList
import BG_ParseGameTemplate
import local_crandom
import local_random
import DeriveLocalSeed
import LocallySeededRandom
import Com_Printf
import Com_Error
import Info_NextPair
import Info_Validate
import Info_SetValueForKey_Big
import Info_SetValueForKey
import Info_RemoveKey_big
import Info_RemoveKey
import Info_ValueForKey
import va
import Q_CleanStr
import Q_PrintStrlen
import Q_strcat
import Q_strncpyz
import Q_strrchr
import Q_strupr
import Q_strlwr
import Q_stricmpn
import Q_strncmp
import Q_stricmp
import Q_isalpha
import Q_isupper
import Q_islower
import Q_isprint
import Com_sprintf
import Parse3DMatrix
import Parse2DMatrix
import Parse1DMatrix
import SkipRestOfLine
import SkipBracedSection
import COM_MatchToken
import COM_ParseWarning
import COM_ParseError
import COM_Compress
import COM_ParseExt
import COM_Parse
import COM_GetCurrentParseLine
import COM_BeginParseSession
import COM_DefaultExtension
import COM_StripExtension
import COM_SkipPath
import Com_Clamp
import PerpendicularVector
import AngleVectors
import MatrixMultiply
import MakeNormalVectors
import RotateAroundDirection
import RotatePointAroundVector
import ProjectPointOnPlane
import PlaneFromPoints
import AngleDelta
import AngleNormalize180
import AngleNormalize360
import AnglesSubtract
import AngleSubtract
import LerpAngle
import AngleMod
import BoxOnPlaneSide
import SetPlaneSignbits
import AxisCopy
import AxisClear
import AnglesToAxis
import vectoangles
import lrand
import Q_crandom
import Q_random
import Q_rand
import Q_acos
import Q_log2
import VectorRotate
import Vector4Scale
import VectorNormalize2
import VectorNormalize
import CrossProduct
import VectorInverse
import VectorNormalizeFast
import DistanceSquared
import Distance
import VectorLengthSquared
import VectorLength
import VectorCompare
import AddPointToBounds
import ClearBounds
import RadiusFromBounds
import NormalizeColor
import ColorBytes4
import ColorBytes3
import _VectorMA
import _VectorScale
import _VectorCopy
import _VectorAdd
import _VectorSubtract
import _DotProduct
import ByteToDir
import DirToByte
import ClampShort
import ClampChar
import Q_rsqrt
import Q_fabs
import axisDefault
import vec3_origin
import g_color_table
import colorDkGrey
import colorMdGrey
import colorLtGrey
import colorWhite
import colorCyan
import colorMagenta
import colorYellow
import colorBlue
import colorGreen
import colorRed
import colorBlack
import bytedirs
import Com_Memcpy
import Com_Memset
import Hunk_Alloc
import FloatSwap
import LongSwap
import ShortSwap
import acos
import fabs
import abs
import tan
import atan2
import cos
import sin
import sqrt
import floor
import ceil
import memcpy
import memset
import memmove
import sscanf
import vsprintf
import _atoi
import atoi
import _atof
import atof
import toupper
import tolower
import strncpy
import strstr
import strchr
import strcmp
import strcpy
import strcat
import strlen
import rand
import srand
import qsort
lit
align 1
LABELV $1753
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 32
byte 1 35
byte 1 37
byte 1 100
byte 1 47
byte 1 37
byte 1 100
byte 1 32
byte 1 64
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $1601
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1505
byte 1 94
byte 1 49
byte 1 66
byte 1 85
byte 1 71
byte 1 33
byte 1 32
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 83
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 115
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 61
byte 1 37
byte 1 100
byte 1 44
byte 1 32
byte 1 109
byte 1 97
byte 1 120
byte 1 61
byte 1 37
byte 1 100
byte 1 44
byte 1 32
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 61
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 10
byte 1 0
align 1
LABELV $1498
byte 1 94
byte 1 49
byte 1 66
byte 1 85
byte 1 71
byte 1 33
byte 1 32
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 83
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 115
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 61
byte 1 37
byte 1 100
byte 1 44
byte 1 32
byte 1 109
byte 1 97
byte 1 120
byte 1 61
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $1442
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $1415
byte 1 94
byte 1 49
byte 1 83
byte 1 80
byte 1 95
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 104
byte 1 117
byte 1 108
byte 1 108
byte 1 58
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 109
byte 1 97
byte 1 110
byte 1 121
byte 1 32
byte 1 115
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 32
byte 1 40
byte 1 62
byte 1 37
byte 1 100
byte 1 41
byte 1 0
align 1
LABELV $1412
byte 1 115
byte 1 116
byte 1 121
byte 1 108
byte 1 101
byte 1 95
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $1399
byte 1 94
byte 1 49
byte 1 83
byte 1 80
byte 1 95
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 104
byte 1 117
byte 1 108
byte 1 108
byte 1 58
byte 1 32
byte 1 105
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 102
byte 1 114
byte 1 101
byte 1 113
byte 1 117
byte 1 101
byte 1 110
byte 1 99
byte 1 121
byte 1 37
byte 1 115
byte 1 61
byte 1 37
byte 1 102
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 115
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1396
byte 1 94
byte 1 49
byte 1 83
byte 1 80
byte 1 95
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 104
byte 1 117
byte 1 108
byte 1 108
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 115
byte 1 116
byte 1 121
byte 1 108
byte 1 101
byte 1 95
byte 1 111
byte 1 117
byte 1 116
byte 1 37
byte 1 115
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 115
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1393
byte 1 94
byte 1 49
byte 1 83
byte 1 80
byte 1 95
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 104
byte 1 117
byte 1 108
byte 1 108
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 115
byte 1 116
byte 1 121
byte 1 108
byte 1 101
byte 1 95
byte 1 105
byte 1 110
byte 1 37
byte 1 115
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 115
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1387
byte 1 115
byte 1 116
byte 1 121
byte 1 108
byte 1 101
byte 1 95
byte 1 111
byte 1 117
byte 1 116
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1386
byte 1 115
byte 1 116
byte 1 121
byte 1 108
byte 1 101
byte 1 95
byte 1 105
byte 1 110
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1385
byte 1 49
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $1384
byte 1 102
byte 1 114
byte 1 101
byte 1 113
byte 1 117
byte 1 101
byte 1 110
byte 1 99
byte 1 121
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1377
byte 1 83
byte 1 80
byte 1 95
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 104
byte 1 117
byte 1 108
byte 1 108
byte 1 58
byte 1 32
byte 1 66
byte 1 111
byte 1 116
byte 1 104
byte 1 32
byte 1 105
byte 1 110
byte 1 105
byte 1 116
byte 1 105
byte 1 97
byte 1 108
byte 1 32
byte 1 38
byte 1 32
byte 1 102
byte 1 105
byte 1 110
byte 1 97
byte 1 108
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 115
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1366
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 0
align 1
LABELV $1365
byte 1 98
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $1362
byte 1 117
byte 1 110
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $1350
byte 1 94
byte 1 49
byte 1 71
byte 1 101
byte 1 116
byte 1 84
byte 1 114
byte 1 97
byte 1 110
byte 1 115
byte 1 105
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 83
byte 1 116
byte 1 121
byte 1 108
byte 1 101
byte 1 70
byte 1 114
byte 1 111
byte 1 109
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 58
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 109
byte 1 97
byte 1 110
byte 1 121
byte 1 32
byte 1 115
byte 1 116
byte 1 121
byte 1 108
byte 1 101
byte 1 115
byte 1 32
byte 1 40
byte 1 62
byte 1 37
byte 1 100
byte 1 41
byte 1 0
align 1
LABELV $1332
byte 1 60
byte 1 118
byte 1 111
byte 1 105
byte 1 100
byte 1 62
byte 1 0
align 1
LABELV $1312
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 69
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 105
byte 1 101
byte 1 115
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 105
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $1269
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 10
byte 1 0
align 1
LABELV $1267
byte 1 32
byte 1 32
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1262
byte 1 97
byte 1 118
byte 1 97
byte 1 105
byte 1 108
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 115
byte 1 116
byte 1 121
byte 1 108
byte 1 101
byte 1 115
byte 1 58
byte 1 10
byte 1 0
align 1
LABELV $1261
byte 1 94
byte 1 49
byte 1 67
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 101
byte 1 87
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 115
byte 1 116
byte 1 121
byte 1 108
byte 1 101
byte 1 115
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $1258
byte 1 67
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 101
byte 1 87
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 46
byte 1 46
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $1252
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $1241
byte 1 102
byte 1 97
byte 1 108
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $1240
byte 1 116
byte 1 114
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $1238
byte 1 94
byte 1 49
byte 1 69
byte 1 120
byte 1 116
byte 1 101
byte 1 110
byte 1 100
byte 1 87
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 58
byte 1 32
byte 1 78
byte 1 111
byte 1 32
byte 1 115
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 32
byte 1 102
byte 1 105
byte 1 116
byte 1 46
byte 1 10
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 83
byte 1 116
byte 1 121
byte 1 108
byte 1 101
byte 1 61
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 102
byte 1 105
byte 1 110
byte 1 97
byte 1 108
byte 1 105
byte 1 122
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 61
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 110
byte 1 117
byte 1 109
byte 1 69
byte 1 120
byte 1 99
byte 1 108
byte 1 117
byte 1 100
byte 1 101
byte 1 100
byte 1 61
byte 1 37
byte 1 100
byte 1 44
byte 1 32
byte 1 110
byte 1 117
byte 1 109
byte 1 65
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 61
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $1237
byte 1 35
byte 1 37
byte 1 100
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1230
byte 1 108
byte 1 97
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 32
byte 1 103
byte 1 101
byte 1 110
byte 1 101
byte 1 114
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 115
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 58
byte 1 10
byte 1 0
align 1
LABELV $1106
byte 1 94
byte 1 51
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 78
byte 1 111
byte 1 32
byte 1 102
byte 1 97
byte 1 108
byte 1 108
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 97
byte 1 118
byte 1 97
byte 1 105
byte 1 108
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 115
byte 1 116
byte 1 121
byte 1 108
byte 1 101
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $1100
byte 1 60
byte 1 110
byte 1 111
byte 1 110
byte 1 101
byte 1 62
byte 1 0
align 1
LABELV $1099
byte 1 94
byte 1 51
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 78
byte 1 111
byte 1 116
byte 1 32
byte 1 101
byte 1 110
byte 1 111
byte 1 117
byte 1 103
byte 1 104
byte 1 32
byte 1 115
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 99
byte 1 104
byte 1 111
byte 1 111
byte 1 115
byte 1 101
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 115
byte 1 116
byte 1 121
byte 1 108
byte 1 101
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $933
byte 1 94
byte 1 49
byte 1 66
byte 1 85
byte 1 71
byte 1 33
byte 1 32
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 83
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 105
byte 1 110
byte 1 105
byte 1 116
byte 1 105
byte 1 97
byte 1 108
byte 1 105
byte 1 122
byte 1 101
byte 1 100
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 0
align 1
LABELV $782
byte 1 66
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 83
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 105
byte 1 101
byte 1 115
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 115
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $781
byte 1 94
byte 1 49
byte 1 66
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 83
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 58
byte 1 32
byte 1 101
byte 1 120
byte 1 105
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 110
byte 1 101
byte 1 97
byte 1 114
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 115
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $774
byte 1 94
byte 1 49
byte 1 66
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 83
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 102
byte 1 105
byte 1 110
byte 1 97
byte 1 108
byte 1 32
byte 1 115
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $771
byte 1 94
byte 1 49
byte 1 66
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 83
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 101
byte 1 120
byte 1 105
byte 1 116
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 115
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $768
byte 1 94
byte 1 49
byte 1 66
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 83
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 115
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $765
byte 1 94
byte 1 49
byte 1 66
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 83
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 58
byte 1 32
byte 1 101
byte 1 109
byte 1 112
byte 1 116
byte 1 121
byte 1 32
byte 1 115
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $758
byte 1 94
byte 1 49
byte 1 66
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 83
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 58
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 109
byte 1 97
byte 1 110
byte 1 121
byte 1 32
byte 1 40
byte 1 62
byte 1 37
byte 1 100
byte 1 41
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 105
byte 1 101
byte 1 115
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 115
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $755
byte 1 94
byte 1 49
byte 1 66
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 83
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 58
byte 1 32
byte 1 100
byte 1 117
byte 1 112
byte 1 108
byte 1 105
byte 1 99
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 103
byte 1 111
byte 1 97
byte 1 108
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 115
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $749
byte 1 94
byte 1 49
byte 1 66
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 83
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 58
byte 1 32
byte 1 100
byte 1 117
byte 1 112
byte 1 108
byte 1 105
byte 1 99
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 101
byte 1 120
byte 1 105
byte 1 116
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 115
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $745
byte 1 94
byte 1 49
byte 1 66
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 83
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 58
byte 1 32
byte 1 100
byte 1 117
byte 1 112
byte 1 108
byte 1 105
byte 1 99
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 115
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $702
byte 1 94
byte 1 49
byte 1 66
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 83
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 115
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $699
byte 1 66
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 83
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 46
byte 1 46
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $694
byte 1 37
byte 1 100
byte 1 47
byte 1 37
byte 1 100
byte 1 32
byte 1 115
byte 1 116
byte 1 121
byte 1 108
byte 1 101
byte 1 115
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 108
byte 1 111
byte 1 111
byte 1 112
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $693
byte 1 67
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 82
byte 1 101
byte 1 97
byte 1 99
byte 1 104
byte 1 97
byte 1 98
byte 1 105
byte 1 108
byte 1 105
byte 1 116
byte 1 121
byte 1 65
byte 1 110
byte 1 100
byte 1 76
byte 1 111
byte 1 111
byte 1 112
byte 1 115
byte 1 58
byte 1 32
byte 1 78
byte 1 111
byte 1 32
byte 1 108
byte 1 111
byte 1 111
byte 1 112
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 115
byte 1 116
byte 1 121
byte 1 108
byte 1 101
byte 1 115
byte 1 32
byte 1 97
byte 1 118
byte 1 97
byte 1 105
byte 1 108
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $690
byte 1 67
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 82
byte 1 101
byte 1 97
byte 1 99
byte 1 104
byte 1 97
byte 1 98
byte 1 105
byte 1 108
byte 1 105
byte 1 116
byte 1 121
byte 1 65
byte 1 110
byte 1 100
byte 1 76
byte 1 111
byte 1 111
byte 1 112
byte 1 115
byte 1 58
byte 1 32
byte 1 83
byte 1 116
byte 1 121
byte 1 108
byte 1 101
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 114
byte 1 101
byte 1 97
byte 1 99
byte 1 104
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 46
byte 1 0
align 1
LABELV $675
byte 1 67
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 82
byte 1 101
byte 1 97
byte 1 99
byte 1 104
byte 1 97
byte 1 98
byte 1 105
byte 1 108
byte 1 105
byte 1 116
byte 1 121
byte 1 65
byte 1 110
byte 1 100
byte 1 76
byte 1 111
byte 1 111
byte 1 112
byte 1 115
byte 1 46
byte 1 46
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $647
byte 1 40
byte 1 115
byte 1 101
byte 1 101
byte 1 32
byte 1 97
byte 1 98
byte 1 111
byte 1 118
byte 1 101
byte 1 41
byte 1 0
align 1
LABELV $646
byte 1 32
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $639
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 67
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 70
byte 1 111
byte 1 114
byte 1 85
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 83
byte 1 116
byte 1 121
byte 1 108
byte 1 101
byte 1 115
byte 1 58
byte 1 32
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 115
byte 1 116
byte 1 121
byte 1 108
byte 1 101
byte 1 115
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 114
byte 1 101
byte 1 97
byte 1 99
byte 1 104
byte 1 32
byte 1 97
byte 1 32
byte 1 102
byte 1 105
byte 1 110
byte 1 97
byte 1 108
byte 1 32
byte 1 115
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $595
byte 1 67
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 70
byte 1 111
byte 1 114
byte 1 85
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 83
byte 1 116
byte 1 121
byte 1 108
byte 1 101
byte 1 115
byte 1 46
byte 1 46
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $593
byte 1 94
byte 1 49
byte 1 67
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 70
byte 1 111
byte 1 114
byte 1 68
byte 1 101
byte 1 97
byte 1 100
byte 1 83
byte 1 116
byte 1 121
byte 1 108
byte 1 101
byte 1 115
byte 1 58
byte 1 32
byte 1 83
byte 1 116
byte 1 121
byte 1 108
byte 1 101
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 32
byte 1 100
byte 1 111
byte 1 101
byte 1 115
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 97
byte 1 112
byte 1 112
byte 1 101
byte 1 97
byte 1 114
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 97
byte 1 110
byte 1 121
byte 1 32
byte 1 115
byte 1 116
byte 1 121
byte 1 108
byte 1 101
byte 1 95
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 46
byte 1 0
align 1
LABELV $590
byte 1 94
byte 1 49
byte 1 67
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 70
byte 1 111
byte 1 114
byte 1 68
byte 1 101
byte 1 97
byte 1 100
byte 1 83
byte 1 116
byte 1 121
byte 1 108
byte 1 101
byte 1 115
byte 1 58
byte 1 32
byte 1 83
byte 1 116
byte 1 121
byte 1 108
byte 1 101
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 32
byte 1 100
byte 1 111
byte 1 101
byte 1 115
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 97
byte 1 112
byte 1 112
byte 1 101
byte 1 97
byte 1 114
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 97
byte 1 110
byte 1 121
byte 1 32
byte 1 115
byte 1 116
byte 1 121
byte 1 108
byte 1 101
byte 1 95
byte 1 105
byte 1 110
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 46
byte 1 0
align 1
LABELV $571
byte 1 67
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 70
byte 1 111
byte 1 114
byte 1 68
byte 1 101
byte 1 97
byte 1 100
byte 1 83
byte 1 116
byte 1 121
byte 1 108
byte 1 101
byte 1 115
byte 1 46
byte 1 46
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $499
byte 1 94
byte 1 49
byte 1 67
byte 1 111
byte 1 109
byte 1 112
byte 1 117
byte 1 116
byte 1 101
byte 1 87
byte 1 97
byte 1 121
byte 1 76
byte 1 101
byte 1 110
byte 1 103
byte 1 116
byte 1 104
byte 1 58
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 110
byte 1 101
byte 1 97
byte 1 114
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 101
byte 1 120
byte 1 105
byte 1 116
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 115
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $498
byte 1 94
byte 1 49
byte 1 67
byte 1 111
byte 1 109
byte 1 112
byte 1 117
byte 1 116
byte 1 101
byte 1 87
byte 1 97
byte 1 121
byte 1 76
byte 1 101
byte 1 110
byte 1 103
byte 1 116
byte 1 104
byte 1 58
byte 1 32
byte 1 119
byte 1 97
byte 1 121
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 35
byte 1 37
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 110
byte 1 101
byte 1 97
byte 1 114
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 101
byte 1 120
byte 1 105
byte 1 116
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 115
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $493
byte 1 94
byte 1 49
byte 1 67
byte 1 111
byte 1 109
byte 1 112
byte 1 117
byte 1 116
byte 1 101
byte 1 87
byte 1 97
byte 1 121
byte 1 76
byte 1 101
byte 1 110
byte 1 103
byte 1 116
byte 1 104
byte 1 58
byte 1 32
byte 1 119
byte 1 97
byte 1 121
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 35
byte 1 37
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 110
byte 1 101
byte 1 97
byte 1 114
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 115
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $492
byte 1 94
byte 1 49
byte 1 67
byte 1 111
byte 1 109
byte 1 112
byte 1 117
byte 1 116
byte 1 101
byte 1 87
byte 1 97
byte 1 121
byte 1 76
byte 1 101
byte 1 110
byte 1 103
byte 1 116
byte 1 104
byte 1 58
byte 1 32
byte 1 119
byte 1 97
byte 1 121
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 115
byte 1 32
byte 1 35
byte 1 37
byte 1 100
byte 1 32
byte 1 38
byte 1 32
byte 1 35
byte 1 37
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 110
byte 1 101
byte 1 97
byte 1 114
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 115
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $478
byte 1 94
byte 1 49
byte 1 65
byte 1 100
byte 1 100
byte 1 87
byte 1 97
byte 1 121
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 100
byte 1 117
byte 1 112
byte 1 108
byte 1 105
byte 1 99
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 119
byte 1 97
byte 1 121
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 99
byte 1 111
byte 1 117
byte 1 110
byte 1 116
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 115
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $469
byte 1 94
byte 1 49
byte 1 65
byte 1 100
byte 1 100
byte 1 87
byte 1 97
byte 1 121
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 109
byte 1 97
byte 1 110
byte 1 121
byte 1 32
byte 1 119
byte 1 97
byte 1 121
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 115
byte 1 32
byte 1 40
byte 1 62
byte 1 37
byte 1 100
byte 1 41
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 115
byte 1 101
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $446
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 32
byte 1 64
byte 1 32
byte 1 40
byte 1 37
byte 1 100
byte 1 44
byte 1 37
byte 1 100
byte 1 44
byte 1 37
byte 1 100
byte 1 41
byte 1 0
align 1
LABELV $443
byte 1 87
byte 1 97
byte 1 114
byte 1 109
byte 1 117
byte 1 112
byte 1 58
byte 1 10
byte 1 0
align 1
LABELV $436
byte 1 103
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $429
byte 1 103
byte 1 95
byte 1 101
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 66
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $428
byte 1 101
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 66
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $427
byte 1 103
byte 1 95
byte 1 101
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 68
byte 1 117
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $426
byte 1 101
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 68
byte 1 117
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $425
byte 1 103
byte 1 95
byte 1 103
byte 1 114
byte 1 97
byte 1 118
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $422
byte 1 103
byte 1 95
byte 1 103
byte 1 114
byte 1 97
byte 1 118
byte 1 105
byte 1 116
byte 1 121
byte 1 76
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $421
byte 1 56
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $420
byte 1 103
byte 1 114
byte 1 97
byte 1 118
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $418
byte 1 110
byte 1 101
byte 1 97
byte 1 114
byte 1 98
byte 1 111
byte 1 120
byte 1 0
align 1
LABELV $417
byte 1 109
byte 1 117
byte 1 115
byte 1 105
byte 1 99
byte 1 0
align 1
LABELV $415
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $414
byte 1 79
byte 1 112
byte 1 101
byte 1 110
byte 1 72
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $413
byte 1 83
byte 1 80
byte 1 95
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 58
byte 1 32
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 105
byte 1 114
byte 1 115
byte 1 116
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 105
byte 1 115
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 39
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 39
byte 1 0
align 1
LABELV $412
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $409
byte 1 0
align 1
LABELV $401
byte 1 71
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 86
byte 1 97
byte 1 114
byte 1 115
byte 1 58
byte 1 32
byte 1 77
byte 1 65
byte 1 88
byte 1 95
byte 1 83
byte 1 80
byte 1 65
byte 1 87
byte 1 78
byte 1 95
byte 1 86
byte 1 65
byte 1 82
byte 1 83
byte 1 0
align 1
LABELV $397
byte 1 71
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 86
byte 1 97
byte 1 114
byte 1 115
byte 1 58
byte 1 32
byte 1 99
byte 1 108
byte 1 111
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 98
byte 1 114
byte 1 97
byte 1 99
byte 1 101
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 100
byte 1 97
byte 1 116
byte 1 97
byte 1 0
align 1
LABELV $390
byte 1 71
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 86
byte 1 97
byte 1 114
byte 1 115
byte 1 58
byte 1 32
byte 1 69
byte 1 79
byte 1 70
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 99
byte 1 108
byte 1 111
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 98
byte 1 114
byte 1 97
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $384
byte 1 71
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 86
byte 1 97
byte 1 114
byte 1 115
byte 1 58
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 119
byte 1 104
byte 1 101
byte 1 110
byte 1 32
byte 1 101
byte 1 120
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 123
byte 1 0
align 1
LABELV $373
byte 1 71
byte 1 95
byte 1 65
byte 1 100
byte 1 100
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 86
byte 1 97
byte 1 114
byte 1 84
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 58
byte 1 32
byte 1 77
byte 1 65
byte 1 88
byte 1 95
byte 1 83
byte 1 80
byte 1 65
byte 1 87
byte 1 78
byte 1 95
byte 1 67
byte 1 72
byte 1 65
byte 1 82
byte 1 83
byte 1 0
align 1
LABELV $348
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $343
byte 1 110
byte 1 111
byte 1 116
byte 1 113
byte 1 51
byte 1 97
byte 1 0
align 1
LABELV $340
byte 1 110
byte 1 111
byte 1 116
byte 1 102
byte 1 114
byte 1 101
byte 1 101
byte 1 0
align 1
LABELV $337
byte 1 110
byte 1 111
byte 1 116
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $331
byte 1 110
byte 1 111
byte 1 116
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $325
byte 1 48
byte 1 0
align 1
LABELV $324
byte 1 110
byte 1 111
byte 1 110
byte 1 115
byte 1 111
byte 1 108
byte 1 105
byte 1 100
byte 1 0
align 1
LABELV $315
byte 1 101
byte 1 102
byte 1 104
byte 1 0
align 1
LABELV $314
byte 1 115
byte 1 116
byte 1 117
byte 1 0
align 1
LABELV $313
byte 1 104
byte 1 97
byte 1 114
byte 1 118
byte 1 101
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $312
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $311
byte 1 111
byte 1 110
byte 1 101
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $310
byte 1 99
byte 1 116
byte 1 102
byte 1 0
align 1
LABELV $309
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $308
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $307
byte 1 102
byte 1 102
byte 1 97
byte 1 0
align 1
LABELV $274
byte 1 37
byte 1 115
byte 1 32
byte 1 100
byte 1 111
byte 1 101
byte 1 115
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 97
byte 1 32
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 32
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $263
byte 1 72
byte 1 101
byte 1 97
byte 1 118
byte 1 121
byte 1 32
byte 1 65
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $249
byte 1 77
byte 1 101
byte 1 103
byte 1 97
byte 1 32
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $247
byte 1 53
byte 1 48
byte 1 32
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $245
byte 1 65
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $243
byte 1 50
byte 1 53
byte 1 32
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $241
byte 1 53
byte 1 32
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $209
byte 1 71
byte 1 95
byte 1 67
byte 1 97
byte 1 108
byte 1 108
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 58
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 32
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $195
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 119
byte 1 97
byte 1 121
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $194
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $193
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 101
byte 1 120
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $192
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $191
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 110
byte 1 117
byte 1 108
byte 1 108
byte 1 95
byte 1 98
byte 1 114
byte 1 117
byte 1 115
byte 1 104
byte 1 0
align 1
LABELV $190
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 98
byte 1 114
byte 1 117
byte 1 115
byte 1 104
byte 1 0
align 1
LABELV $189
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $188
byte 1 101
byte 1 102
byte 1 104
byte 1 95
byte 1 104
byte 1 117
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $187
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 98
byte 1 111
byte 1 116
byte 1 114
byte 1 111
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $186
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $185
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $184
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $183
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $182
byte 1 115
byte 1 104
byte 1 111
byte 1 111
byte 1 116
byte 1 101
byte 1 114
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 0
align 1
LABELV $181
byte 1 115
byte 1 104
byte 1 111
byte 1 111
byte 1 116
byte 1 101
byte 1 114
byte 1 95
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $180
byte 1 115
byte 1 104
byte 1 111
byte 1 111
byte 1 116
byte 1 101
byte 1 114
byte 1 95
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $179
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 95
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 97
byte 1 108
byte 1 95
byte 1 99
byte 1 97
byte 1 109
byte 1 101
byte 1 114
byte 1 97
byte 1 0
align 1
LABELV $178
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 95
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 97
byte 1 108
byte 1 95
byte 1 115
byte 1 117
byte 1 114
byte 1 102
byte 1 97
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $177
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 95
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $176
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 95
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 101
byte 1 114
byte 1 95
byte 1 100
byte 1 101
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $175
byte 1 112
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 99
byte 1 111
byte 1 114
byte 1 110
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $174
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 101
byte 1 97
byte 1 114
byte 1 116
byte 1 104
byte 1 113
byte 1 117
byte 1 97
byte 1 107
byte 1 101
byte 1 0
align 1
LABELV $173
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 112
byte 1 117
byte 1 115
byte 1 104
byte 1 0
align 1
LABELV $172
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 108
byte 1 111
byte 1 99
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $171
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 112
byte 1 111
byte 1 115
byte 1 105
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $170
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $169
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 114
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $168
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $167
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $166
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 108
byte 1 97
byte 1 115
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $165
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $164
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 115
byte 1 112
byte 1 101
byte 1 97
byte 1 107
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $163
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 100
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $162
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 114
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 95
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $161
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 103
byte 1 105
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $160
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 95
byte 1 104
byte 1 117
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $159
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 95
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $158
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 95
byte 1 112
byte 1 117
byte 1 115
byte 1 104
byte 1 0
align 1
LABELV $157
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 95
byte 1 109
byte 1 117
byte 1 108
byte 1 116
byte 1 105
byte 1 112
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $156
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 95
byte 1 97
byte 1 108
byte 1 119
byte 1 97
byte 1 121
byte 1 115
byte 1 0
align 1
LABELV $155
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $154
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 103
byte 1 114
byte 1 111
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $153
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 116
byte 1 114
byte 1 97
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $152
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 112
byte 1 101
byte 1 110
byte 1 100
byte 1 117
byte 1 108
byte 1 117
byte 1 109
byte 1 0
align 1
LABELV $151
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 98
byte 1 111
byte 1 98
byte 1 98
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $150
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 114
byte 1 111
byte 1 116
byte 1 97
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $149
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 105
byte 1 99
byte 1 0
align 1
LABELV $148
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $147
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $146
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $145
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 99
byte 1 97
byte 1 109
byte 1 112
byte 1 0
align 1
LABELV $144
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 110
byte 1 111
byte 1 116
byte 1 110
byte 1 117
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $143
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 110
byte 1 117
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $142
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 95
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $141
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 95
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $140
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $134
byte 1 105
byte 1 100
byte 1 110
byte 1 117
byte 1 109
byte 1 0
align 1
LABELV $133
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 83
byte 1 104
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 78
byte 1 101
byte 1 119
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $132
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 83
byte 1 104
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $131
byte 1 97
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $130
byte 1 97
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $129
byte 1 100
byte 1 109
byte 1 103
byte 1 0
align 1
LABELV $128
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $127
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $126
byte 1 99
byte 1 111
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $125
byte 1 114
byte 1 97
byte 1 110
byte 1 100
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $124
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $123
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $122
byte 1 109
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $121
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $120
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $119
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $118
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $117
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 50
byte 1 0
align 1
LABELV $116
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $115
byte 1 111
byte 1 114
byte 1 105
byte 1 103
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $114
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $111
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 0
