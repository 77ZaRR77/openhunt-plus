data
align 4
LABELV playermodel_artlist
address $96
address $97
address $98
address $99
address $100
address $101
address $102
address $103
address $104
address $105
byte 4 0
code
proc PlayerModel_UpdateGrid 24 0
file "..\..\..\..\code\q3_ui\ui_playermodel.c"
line 106
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:#include "ui_local.h"
;4:
;5:#define MODEL_BACK0			"menu/art/back_0"
;6:#define MODEL_BACK1			"menu/art/back_1"
;7:#define MODEL_SELECT		"menu/art/opponents_select"
;8:#define MODEL_SELECTED		"menu/art/opponents_selected"
;9:#define MODEL_FRAMEL		"menu/art/frame1_l"
;10:#define MODEL_FRAMER		"menu/art/frame1_r"
;11:#define MODEL_PORTS			"menu/art/player_models_ports"
;12:#define MODEL_ARROWS		"menu/art/gs_arrows_0"
;13:#define MODEL_ARROWSL		"menu/art/gs_arrows_l"
;14:#define MODEL_ARROWSR		"menu/art/gs_arrows_r"
;15:
;16:#define LOW_MEMORY			(5 * 1024 * 1024)
;17:
;18:static char* playermodel_artlist[] =
;19:{
;20:	MODEL_BACK0,	
;21:	MODEL_BACK1,	
;22:	MODEL_SELECT,
;23:	MODEL_SELECTED,
;24:	MODEL_FRAMEL,
;25:	MODEL_FRAMER,
;26:	MODEL_PORTS,	
;27:	MODEL_ARROWS,
;28:	MODEL_ARROWSL,
;29:	MODEL_ARROWSR,
;30:	NULL
;31:};
;32:
;33:#define PLAYERGRID_COLS		4
;34:#define PLAYERGRID_ROWS		4
;35:#define MAX_MODELSPERPAGE	(PLAYERGRID_ROWS*PLAYERGRID_COLS)
;36:
;37:#define MAX_PLAYERMODELS	256
;38:
;39:#define ID_PLAYERPIC0		0
;40:#define ID_PLAYERPIC1		1
;41:#define ID_PLAYERPIC2		2
;42:#define ID_PLAYERPIC3		3
;43:#define ID_PLAYERPIC4		4
;44:#define ID_PLAYERPIC5		5
;45:#define ID_PLAYERPIC6		6
;46:#define ID_PLAYERPIC7		7
;47:#define ID_PLAYERPIC8		8
;48:#define ID_PLAYERPIC9		9
;49:#define ID_PLAYERPIC10		10
;50:#define ID_PLAYERPIC11		11
;51:#define ID_PLAYERPIC12		12
;52:#define ID_PLAYERPIC13		13
;53:#define ID_PLAYERPIC14		14
;54:#define ID_PLAYERPIC15		15
;55:#define ID_PREVPAGE			100
;56:#define ID_NEXTPAGE			101
;57:#define ID_BACK				102
;58:
;59:typedef struct
;60:{
;61:	menuframework_s	menu;
;62:	menubitmap_s	pics[MAX_MODELSPERPAGE];
;63:	menubitmap_s	picbuttons[MAX_MODELSPERPAGE];
;64:	menubitmap_s	framel;
;65:	menubitmap_s	framer;
;66:	menubitmap_s	ports;
;67:	menutext_s		banner;
;68:	menubitmap_s	back;
;69:	menubitmap_s	player;
;70:	menubitmap_s	arrows;
;71:	menubitmap_s	left;
;72:	menubitmap_s	right;
;73:	menutext_s		modelname;
;74:	menutext_s		skinname;
;75:	menutext_s		playername;
;76:	playerInfo_t	playerinfo;
;77:	int				nummodels;
;78:	char			modelnames[MAX_PLAYERMODELS][128];
;79:	int				modelpage;
;80:	int				numpages;
;81:	char			modelskin[64];
;82:	int				selectedmodel;
;83:} playermodel_t;
;84:
;85:static playermodel_t s_playermodel;
;86:
;87:// JUHOX: parameters for the player model page
;88:#if MONSTER_MODE
;89:static char* title;
;90:static const char* subtitle;
;91:static const char* modelvar1;
;92:static const char* modelvar2;
;93:static const char* modelvar3;
;94:static const char* modelvar4;
;95:static char* modelBuf;
;96:static int modelBufSize;
;97:static weapon_t modelweapon;
;98:#endif
;99:
;100:/*
;101:=================
;102:PlayerModel_UpdateGrid
;103:=================
;104:*/
;105:static void PlayerModel_UpdateGrid( void )
;106:{
line 110
;107:	int	i;
;108:    int	j;
;109:
;110:	j = s_playermodel.modelpage * MAX_MODELSPERPAGE;
ADDRLP4 4
ADDRGP4 s_playermodel+38112
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 111
;111:	for (i=0; i<PLAYERGRID_ROWS*PLAYERGRID_COLS; i++,j++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $109
line 112
;112:	{
line 113
;113:		if (j < s_playermodel.nummodels)
ADDRLP4 4
INDIRI4
ADDRGP4 s_playermodel+5340
INDIRI4
GEI4 $113
line 114
;114:		{ 
line 116
;115:			// model/skin portrait
;116: 			s_playermodel.pics[i].generic.name         = s_playermodel.modelnames[j];
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_playermodel+424+4
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 7
LSHI4
ADDRGP4 s_playermodel+5344
ADDP4
ASGNP4
line 117
;117:			s_playermodel.picbuttons[i].generic.flags &= ~QMF_INACTIVE;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_playermodel+1832+44
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 4294950911
BANDU4
ASGNU4
line 118
;118:		}
ADDRGP4 $114
JUMPV
LABELV $113
line 120
;119:		else
;120:		{
line 122
;121:			// dead slot
;122: 			s_playermodel.pics[i].generic.name         = NULL;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_playermodel+424+4
ADDP4
CNSTP4 0
ASGNP4
line 123
;123:			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_playermodel+1832+44
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 16384
BORU4
ASGNU4
line 124
;124:		}
LABELV $114
line 126
;125:
;126: 		s_playermodel.pics[i].generic.flags       &= ~QMF_HIGHLIGHT;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_playermodel+424+44
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 4294967231
BANDU4
ASGNU4
line 127
;127: 		s_playermodel.pics[i].shader               = 0;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_playermodel+424+68
ADDP4
CNSTI4 0
ASGNI4
line 128
;128: 		s_playermodel.picbuttons[i].generic.flags |= QMF_PULSEIFFOCUS;
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_playermodel+1832+44
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRU4
CNSTU4 256
BORU4
ASGNU4
line 129
;129:	}
LABELV $110
line 111
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $109
line 131
;130:
;131:	if (s_playermodel.selectedmodel/MAX_MODELSPERPAGE == s_playermodel.modelpage)
ADDRGP4 s_playermodel+38184
INDIRI4
CNSTI4 16
DIVI4
ADDRGP4 s_playermodel+38112
INDIRI4
NEI4 $131
line 132
;132:	{
line 134
;133:		// set selected model
;134:		i = s_playermodel.selectedmodel % MAX_MODELSPERPAGE;
ADDRLP4 0
ADDRGP4 s_playermodel+38184
INDIRI4
CNSTI4 16
MODI4
ASGNI4
line 136
;135:
;136:		s_playermodel.pics[i].generic.flags       |= QMF_HIGHLIGHT;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_playermodel+424+44
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 64
BORU4
ASGNU4
line 137
;137:		s_playermodel.picbuttons[i].generic.flags &= ~QMF_PULSEIFFOCUS;
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_playermodel+1832+44
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRU4
CNSTU4 4294967039
BANDU4
ASGNU4
line 138
;138:	}
LABELV $131
line 140
;139:
;140:	if (s_playermodel.numpages > 1)
ADDRGP4 s_playermodel+38116
INDIRI4
CNSTI4 1
LEI4 $140
line 141
;141:	{
line 142
;142:		if (s_playermodel.modelpage > 0)
ADDRGP4 s_playermodel+38112
INDIRI4
CNSTI4 0
LEI4 $143
line 143
;143:			s_playermodel.left.generic.flags &= ~QMF_INACTIVE;
ADDRLP4 8
ADDRGP4 s_playermodel+3840+44
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 4294950911
BANDU4
ASGNU4
ADDRGP4 $144
JUMPV
LABELV $143
line 145
;144:		else
;145:			s_playermodel.left.generic.flags |= QMF_INACTIVE;
ADDRLP4 12
ADDRGP4 s_playermodel+3840+44
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRU4
CNSTU4 16384
BORU4
ASGNU4
LABELV $144
line 147
;146:
;147:		if (s_playermodel.modelpage < s_playermodel.numpages-1)
ADDRGP4 s_playermodel+38112
INDIRI4
ADDRGP4 s_playermodel+38116
INDIRI4
CNSTI4 1
SUBI4
GEI4 $150
line 148
;148:			s_playermodel.right.generic.flags &= ~QMF_INACTIVE;
ADDRLP4 16
ADDRGP4 s_playermodel+3928+44
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRU4
CNSTU4 4294950911
BANDU4
ASGNU4
ADDRGP4 $141
JUMPV
LABELV $150
line 150
;149:		else
;150:			s_playermodel.right.generic.flags |= QMF_INACTIVE;
ADDRLP4 20
ADDRGP4 s_playermodel+3928+44
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRU4
CNSTU4 16384
BORU4
ASGNU4
line 151
;151:	}
ADDRGP4 $141
JUMPV
LABELV $140
line 153
;152:	else
;153:	{
line 155
;154:		// hide left/right markers
;155:		s_playermodel.left.generic.flags |= QMF_INACTIVE;
ADDRLP4 8
ADDRGP4 s_playermodel+3840+44
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 16384
BORU4
ASGNU4
line 156
;156:		s_playermodel.right.generic.flags |= QMF_INACTIVE;
ADDRLP4 12
ADDRGP4 s_playermodel+3928+44
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRU4
CNSTU4 16384
BORU4
ASGNU4
line 157
;157:	}
LABELV $141
line 158
;158:}
LABELV $107
endproc PlayerModel_UpdateGrid 24 0
proc PlayerModel_UpdateModel 32 28
line 166
;159:
;160:/*
;161:=================
;162:PlayerModel_UpdateModel
;163:=================
;164:*/
;165:static void PlayerModel_UpdateModel( void )
;166:{
line 170
;167:	vec3_t	viewangles;
;168:	vec3_t	moveangles;
;169:
;170:	memset( &s_playermodel.playerinfo, 0, sizeof(playerInfo_t) );
ADDRGP4 s_playermodel+4232
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1108
ARGI4
ADDRGP4 memset
CALLP4
pop
line 172
;171:	
;172:	viewangles[YAW]   = 180 - 30;
ADDRLP4 0+4
CNSTF4 1125515264
ASGNF4
line 173
;173:	viewangles[PITCH] = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 174
;174:	viewangles[ROLL]  = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 175
;175:	VectorClear( moveangles );
ADDRLP4 24
CNSTF4 0
ASGNF4
ADDRLP4 12+8
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 12
ADDRLP4 24
INDIRF4
ASGNF4
line 177
;176:
;177:	UI_PlayerInfo_SetModel( &s_playermodel.playerinfo, s_playermodel.modelskin );
ADDRGP4 s_playermodel+4232
ARGP4
ADDRGP4 s_playermodel+38120
ARGP4
ADDRGP4 UI_PlayerInfo_SetModel
CALLV
pop
line 182
;178:	// JUHOX: use new weapon parameter
;179:#if !MONSTER_MODE
;180:	UI_PlayerInfo_SetInfo( &s_playermodel.playerinfo, LEGS_IDLE, TORSO_STAND, viewangles, moveangles, WP_MACHINEGUN, qfalse );
;181:#else
;182:	UI_PlayerInfo_SetInfo(
ADDRGP4 s_playermodel+4232
ARGP4
CNSTI4 22
ARGI4
ADDRGP4 modelweapon
INDIRI4
CNSTI4 1
LEI4 $172
ADDRLP4 28
CNSTI4 11
ASGNI4
ADDRGP4 $173
JUMPV
LABELV $172
ADDRLP4 28
CNSTI4 12
ASGNI4
LABELV $173
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 modelweapon
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 UI_PlayerInfo_SetInfo
CALLV
pop
line 189
;183:		&s_playermodel.playerinfo,
;184:		LEGS_IDLE,
;185:		modelweapon > WP_GAUNTLET? TORSO_STAND : TORSO_STAND2,
;186:		viewangles, moveangles, modelweapon, qfalse
;187:	);
;188:#endif
;189:}
LABELV $162
endproc PlayerModel_UpdateModel 32 28
proc PlayerModel_SaveChanges 0 12
line 197
;190:
;191:/*
;192:=================
;193:PlayerModel_SaveChanges
;194:=================
;195:*/
;196:static void PlayerModel_SaveChanges( void )
;197:{
line 205
;198:	// JUHOX: save player model changes in new cvars
;199:#if !MONSTER_MODE
;200:	trap_Cvar_Set( "model", s_playermodel.modelskin );
;201:	trap_Cvar_Set( "headmodel", s_playermodel.modelskin );
;202:	trap_Cvar_Set( "team_model", s_playermodel.modelskin );
;203:	trap_Cvar_Set( "team_headmodel", s_playermodel.modelskin );
;204:#else
;205:	if (modelvar1) trap_Cvar_Set(modelvar1, s_playermodel.modelskin);
ADDRGP4 modelvar1
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $175
ADDRGP4 modelvar1
INDIRP4
ARGP4
ADDRGP4 s_playermodel+38120
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
LABELV $175
line 206
;206:	if (modelvar2) trap_Cvar_Set(modelvar2, s_playermodel.modelskin);
ADDRGP4 modelvar2
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $178
ADDRGP4 modelvar2
INDIRP4
ARGP4
ADDRGP4 s_playermodel+38120
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
LABELV $178
line 207
;207:	if (modelvar3) trap_Cvar_Set(modelvar3, s_playermodel.modelskin);
ADDRGP4 modelvar3
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $181
ADDRGP4 modelvar3
INDIRP4
ARGP4
ADDRGP4 s_playermodel+38120
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
LABELV $181
line 208
;208:	if (modelvar4) trap_Cvar_Set(modelvar4, s_playermodel.modelskin);
ADDRGP4 modelvar4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $184
ADDRGP4 modelvar4
INDIRP4
ARGP4
ADDRGP4 s_playermodel+38120
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
LABELV $184
line 209
;209:	if (modelBuf) Q_strncpyz(modelBuf, s_playermodel.modelskin, modelBufSize);
ADDRGP4 modelBuf
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $187
ADDRGP4 modelBuf
INDIRP4
ARGP4
ADDRGP4 s_playermodel+38120
ARGP4
ADDRGP4 modelBufSize
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
LABELV $187
line 211
;210:#endif
;211:}
LABELV $174
endproc PlayerModel_SaveChanges 0 12
proc PlayerModel_MenuEvent 12 0
line 219
;212:
;213:/*
;214:=================
;215:PlayerModel_MenuEvent
;216:=================
;217:*/
;218:static void PlayerModel_MenuEvent( void* ptr, int event )
;219:{
line 220
;220:	if (event != QM_ACTIVATED)
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $191
line 221
;221:		return;
ADDRGP4 $190
JUMPV
LABELV $191
line 223
;222:
;223:	switch (((menucommon_s*)ptr)->id)
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 100
EQI4 $196
ADDRLP4 0
INDIRI4
CNSTI4 101
EQI4 $201
ADDRLP4 0
INDIRI4
CNSTI4 102
EQI4 $207
ADDRGP4 $193
JUMPV
line 224
;224:	{
LABELV $196
line 226
;225:		case ID_PREVPAGE:
;226:			if (s_playermodel.modelpage > 0)
ADDRGP4 s_playermodel+38112
INDIRI4
CNSTI4 0
LEI4 $194
line 227
;227:			{
line 228
;228:				s_playermodel.modelpage--;
ADDRLP4 8
ADDRGP4 s_playermodel+38112
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 229
;229:				PlayerModel_UpdateGrid();
ADDRGP4 PlayerModel_UpdateGrid
CALLV
pop
line 230
;230:			}
line 231
;231:			break;
ADDRGP4 $194
JUMPV
LABELV $201
line 234
;232:
;233:		case ID_NEXTPAGE:
;234:			if (s_playermodel.modelpage < s_playermodel.numpages-1)
ADDRGP4 s_playermodel+38112
INDIRI4
ADDRGP4 s_playermodel+38116
INDIRI4
CNSTI4 1
SUBI4
GEI4 $194
line 235
;235:			{
line 236
;236:				s_playermodel.modelpage++;
ADDRLP4 8
ADDRGP4 s_playermodel+38112
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 237
;237:				PlayerModel_UpdateGrid();
ADDRGP4 PlayerModel_UpdateGrid
CALLV
pop
line 238
;238:			}
line 239
;239:			break;
ADDRGP4 $194
JUMPV
LABELV $207
line 242
;240:
;241:		case ID_BACK:
;242:			PlayerModel_SaveChanges();
ADDRGP4 PlayerModel_SaveChanges
CALLV
pop
line 243
;243:			UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 244
;244:			break;
LABELV $193
LABELV $194
line 246
;245:	}
;246:}
LABELV $190
endproc PlayerModel_MenuEvent 12 0
proc PlayerModel_MenuKey 44 8
line 254
;247:
;248:/*
;249:=================
;250:PlayerModel_MenuKey
;251:=================
;252:*/
;253:static sfxHandle_t PlayerModel_MenuKey( int key )
;254:{
line 258
;255:	menucommon_s*	m;
;256:	int				picnum;
;257:
;258:	switch (key)
ADDRLP4 8
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 134
EQI4 $211
ADDRLP4 8
INDIRI4
CNSTI4 135
EQI4 $220
ADDRLP4 8
INDIRI4
CNSTI4 135
GTI4 $234
LABELV $233
ADDRFP4 0
INDIRI4
CNSTI4 27
EQI4 $232
ADDRGP4 $209
JUMPV
LABELV $234
ADDRLP4 12
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 163
EQI4 $211
ADDRLP4 12
INDIRI4
CNSTI4 165
EQI4 $220
ADDRLP4 12
INDIRI4
CNSTI4 163
LTI4 $209
LABELV $235
ADDRFP4 0
INDIRI4
CNSTI4 179
EQI4 $232
ADDRGP4 $209
JUMPV
line 259
;259:	{
LABELV $211
line 262
;260:		case K_KP_LEFTARROW:
;261:		case K_LEFTARROW:
;262:			m = Menu_ItemAtCursor(&s_playermodel.menu);
ADDRGP4 s_playermodel
ARGP4
ADDRLP4 16
ADDRGP4 Menu_ItemAtCursor
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRP4
ASGNP4
line 263
;263:			picnum = m->id - ID_PLAYERPIC0;
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 264
;264:			if (picnum >= 0 && picnum <= 15)
ADDRLP4 20
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
LTI4 $210
ADDRLP4 20
INDIRI4
CNSTI4 15
GTI4 $210
line 265
;265:			{
line 266
;266:				if (picnum > 0)
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $214
line 267
;267:				{
line 268
;268:					Menu_SetCursor(&s_playermodel.menu,s_playermodel.menu.cursor-1);
ADDRLP4 24
ADDRGP4 s_playermodel
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRGP4 Menu_SetCursor
CALLV
pop
line 269
;269:					return (menu_move_sound);
ADDRGP4 menu_move_sound
INDIRI4
RETI4
ADDRGP4 $208
JUMPV
LABELV $214
line 272
;270:					
;271:				}
;272:				else if (s_playermodel.modelpage > 0)
ADDRGP4 s_playermodel+38112
INDIRI4
CNSTI4 0
LEI4 $216
line 273
;273:				{
line 274
;274:					s_playermodel.modelpage--;
ADDRLP4 24
ADDRGP4 s_playermodel+38112
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 275
;275:					Menu_SetCursor(&s_playermodel.menu,s_playermodel.menu.cursor+15);
ADDRLP4 28
ADDRGP4 s_playermodel
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 15
ADDI4
ARGI4
ADDRGP4 Menu_SetCursor
CALLV
pop
line 276
;276:					PlayerModel_UpdateGrid();
ADDRGP4 PlayerModel_UpdateGrid
CALLV
pop
line 277
;277:					return (menu_move_sound);
ADDRGP4 menu_move_sound
INDIRI4
RETI4
ADDRGP4 $208
JUMPV
LABELV $216
line 280
;278:				}
;279:				else
;280:					return (menu_buzz_sound);
ADDRGP4 menu_buzz_sound
INDIRI4
RETI4
ADDRGP4 $208
JUMPV
line 282
;281:			}
;282:			break;
LABELV $220
line 286
;283:
;284:		case K_KP_RIGHTARROW:
;285:		case K_RIGHTARROW:
;286:			m = Menu_ItemAtCursor(&s_playermodel.menu);
ADDRGP4 s_playermodel
ARGP4
ADDRLP4 24
ADDRGP4 Menu_ItemAtCursor
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
ASGNP4
line 287
;287:			picnum = m->id - ID_PLAYERPIC0;
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 288
;288:			if (picnum >= 0 && picnum <= 15)
ADDRLP4 28
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
LTI4 $210
ADDRLP4 28
INDIRI4
CNSTI4 15
GTI4 $210
line 289
;289:			{
line 290
;290:				if ((picnum < 15) && (s_playermodel.modelpage*MAX_MODELSPERPAGE + picnum+1 < s_playermodel.nummodels))
ADDRLP4 32
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 15
GEI4 $223
ADDRGP4 s_playermodel+38112
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 32
INDIRI4
ADDI4
CNSTI4 1
ADDI4
ADDRGP4 s_playermodel+5340
INDIRI4
GEI4 $223
line 291
;291:				{
line 292
;292:					Menu_SetCursor(&s_playermodel.menu,s_playermodel.menu.cursor+1);
ADDRLP4 36
ADDRGP4 s_playermodel
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Menu_SetCursor
CALLV
pop
line 293
;293:					return (menu_move_sound);
ADDRGP4 menu_move_sound
INDIRI4
RETI4
ADDRGP4 $208
JUMPV
LABELV $223
line 295
;294:				}					
;295:				else if ((picnum == 15) && (s_playermodel.modelpage < s_playermodel.numpages-1))
ADDRLP4 0
INDIRI4
CNSTI4 15
NEI4 $227
ADDRGP4 s_playermodel+38112
INDIRI4
ADDRGP4 s_playermodel+38116
INDIRI4
CNSTI4 1
SUBI4
GEI4 $227
line 296
;296:				{
line 297
;297:					s_playermodel.modelpage++;
ADDRLP4 36
ADDRGP4 s_playermodel+38112
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 298
;298:					Menu_SetCursor(&s_playermodel.menu,s_playermodel.menu.cursor-15);
ADDRLP4 40
ADDRGP4 s_playermodel
ASGNP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 15
SUBI4
ARGI4
ADDRGP4 Menu_SetCursor
CALLV
pop
line 299
;299:					PlayerModel_UpdateGrid();
ADDRGP4 PlayerModel_UpdateGrid
CALLV
pop
line 300
;300:					return (menu_move_sound);
ADDRGP4 menu_move_sound
INDIRI4
RETI4
ADDRGP4 $208
JUMPV
LABELV $227
line 303
;301:				}
;302:				else
;303:					return (menu_buzz_sound);
ADDRGP4 menu_buzz_sound
INDIRI4
RETI4
ADDRGP4 $208
JUMPV
line 305
;304:			}
;305:			break;
LABELV $232
line 309
;306:			
;307:		case K_MOUSE2:
;308:		case K_ESCAPE:
;309:			PlayerModel_SaveChanges();
ADDRGP4 PlayerModel_SaveChanges
CALLV
pop
line 310
;310:			break;
LABELV $209
LABELV $210
line 313
;311:	}
;312:
;313:	return ( Menu_DefaultKey( &s_playermodel.menu, key ) );
ADDRGP4 s_playermodel
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 Menu_DefaultKey
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
RETI4
LABELV $208
endproc PlayerModel_MenuKey 44 8
proc PlayerModel_PicEvent 48 12
line 322
;314:}
;315:
;316:/*
;317:=================
;318:PlayerModel_PicEvent
;319:=================
;320:*/
;321:static void PlayerModel_PicEvent( void* ptr, int event )
;322:{
line 329
;323:	int				modelnum;
;324:	int				maxlen;
;325:	char*			buffptr;
;326:	char*			pdest;
;327:	int				i;
;328:
;329:	if (event != QM_ACTIVATED)
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $237
line 330
;330:		return;
ADDRGP4 $236
JUMPV
LABELV $237
line 332
;331:
;332:	for (i=0; i<PLAYERGRID_ROWS*PLAYERGRID_COLS; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $239
line 333
;333:	{
line 335
;334:		// reset
;335: 		s_playermodel.pics[i].generic.flags       &= ~QMF_HIGHLIGHT;
ADDRLP4 20
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_playermodel+424+44
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRU4
CNSTU4 4294967231
BANDU4
ASGNU4
line 336
;336: 		s_playermodel.picbuttons[i].generic.flags |= QMF_PULSEIFFOCUS;
ADDRLP4 24
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_playermodel+1832+44
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRU4
CNSTU4 256
BORU4
ASGNU4
line 337
;337:	}
LABELV $240
line 332
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $239
line 340
;338:
;339:	// set selected
;340:	i = ((menucommon_s*)ptr)->id - ID_PLAYERPIC0;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 341
;341:	s_playermodel.pics[i].generic.flags       |= QMF_HIGHLIGHT;
ADDRLP4 20
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_playermodel+424+44
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRU4
CNSTU4 64
BORU4
ASGNU4
line 342
;342:	s_playermodel.picbuttons[i].generic.flags &= ~QMF_PULSEIFFOCUS;
ADDRLP4 24
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_playermodel+1832+44
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRU4
CNSTU4 4294967039
BANDU4
ASGNU4
line 345
;343:
;344:	// get model and strip icon_
;345:	modelnum = s_playermodel.modelpage*MAX_MODELSPERPAGE + i;
ADDRLP4 16
ADDRGP4 s_playermodel+38112
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 346
;346:	buffptr  = s_playermodel.modelnames[modelnum] + strlen("models/players/");
ADDRGP4 $253
ARGP4
ADDRLP4 28
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 28
INDIRI4
ADDRLP4 16
INDIRI4
CNSTI4 7
LSHI4
ADDRGP4 s_playermodel+5344
ADDP4
ADDP4
ASGNP4
line 347
;347:	pdest    = strstr(buffptr,"icon_");
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 $254
ARGP4
ADDRLP4 32
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 32
INDIRP4
ASGNP4
line 348
;348:	if (pdest)
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $255
line 349
;349:	{
line 351
;350:		// track the whole model/skin name
;351:		Q_strncpyz(s_playermodel.modelskin,buffptr,pdest-buffptr+1);
ADDRGP4 s_playermodel+38120
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 352
;352:		strcat(s_playermodel.modelskin,pdest + 5);
ADDRGP4 s_playermodel+38120
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 5
ADDP4
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 355
;353:
;354:		// seperate the model name
;355:		maxlen = pdest-buffptr;
ADDRLP4 12
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 356
;356:		if (maxlen > 16)
ADDRLP4 12
INDIRI4
CNSTI4 16
LEI4 $259
line 357
;357:			maxlen = 16;
ADDRLP4 12
CNSTI4 16
ASGNI4
LABELV $259
line 358
;358:		Q_strncpyz( s_playermodel.modelname.string, buffptr, maxlen );
ADDRGP4 s_playermodel+4016+60
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 359
;359:		Q_strupr( s_playermodel.modelname.string );
ADDRGP4 s_playermodel+4016+60
INDIRP4
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 362
;360:
;361:		// seperate the skin name
;362:		maxlen = strlen(pdest+5)+1;
ADDRLP4 4
INDIRP4
CNSTI4 5
ADDP4
ARGP4
ADDRLP4 40
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 40
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 363
;363:		if (maxlen > 16)
ADDRLP4 12
INDIRI4
CNSTI4 16
LEI4 $265
line 364
;364:			maxlen = 16;
ADDRLP4 12
CNSTI4 16
ASGNI4
LABELV $265
line 365
;365:		Q_strncpyz( s_playermodel.skinname.string, pdest+5, maxlen );
ADDRGP4 s_playermodel+4088+60
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 5
ADDP4
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 366
;366:		Q_strupr( s_playermodel.skinname.string );
ADDRGP4 s_playermodel+4088+60
INDIRP4
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 368
;367:
;368:		s_playermodel.selectedmodel = modelnum;
ADDRGP4 s_playermodel+38184
ADDRLP4 16
INDIRI4
ASGNI4
line 370
;369:
;370:		if( trap_MemoryRemaining() > LOW_MEMORY ) {
ADDRLP4 44
ADDRGP4 trap_MemoryRemaining
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 5242880
LEI4 $272
line 371
;371:			PlayerModel_UpdateModel();
ADDRGP4 PlayerModel_UpdateModel
CALLV
pop
line 372
;372:		}
LABELV $272
line 373
;373:	}
LABELV $255
line 374
;374:}
LABELV $236
endproc PlayerModel_PicEvent 48 12
proc PlayerModel_DrawPlayer 12 24
line 382
;375:
;376:/*
;377:=================
;378:PlayerModel_DrawPlayer
;379:=================
;380:*/
;381:static void PlayerModel_DrawPlayer( void *self )
;382:{
line 385
;383:	menubitmap_s*	b;
;384:
;385:	b = (menubitmap_s*) self;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 387
;386:
;387:	if( trap_MemoryRemaining() <= LOW_MEMORY ) {
ADDRLP4 4
ADDRGP4 trap_MemoryRemaining
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 5242880
GTI4 $275
line 388
;388:		UI_DrawProportionalString( b->generic.x, b->generic.y + b->height / 2, "LOW MEMORY", UI_LEFT, color_red );
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 2
DIVI4
ADDI4
ARGI4
ADDRGP4 $277
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 color_red
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 389
;389:		return;
ADDRGP4 $274
JUMPV
LABELV $275
line 392
;390:	}
;391:
;392:	UI_DrawPlayer( b->generic.x, b->generic.y, b->width, b->height, &s_playermodel.playerinfo, uis.realtime/2 );
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 s_playermodel+4232
ARGP4
ADDRGP4 uis+4
INDIRI4
CNSTI4 2
DIVI4
ARGI4
ADDRGP4 UI_DrawPlayer
CALLV
pop
line 393
;393:}
LABELV $274
endproc PlayerModel_DrawPlayer 12 24
proc PlayerModel_BuildList 4244 20
line 401
;394:
;395:/*
;396:=================
;397:PlayerModel_BuildList
;398:=================
;399:*/
;400:static void PlayerModel_BuildList( void )
;401:{
line 415
;402:	int		numdirs;
;403:	int		numfiles;
;404:	char	dirlist[2048];
;405:	char	filelist[2048];
;406:	char	skinname[64];
;407:	char*	dirptr;
;408:	char*	fileptr;
;409:	int		i;
;410:	int		j;
;411:	int		dirlen;
;412:	int		filelen;
;413:	qboolean precache;
;414:
;415:	precache = trap_Cvar_VariableValue("com_buildscript");
ADDRGP4 $281
ARGP4
ADDRLP4 4196
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 84
ADDRLP4 4196
INDIRF4
CVFI4 4
ASGNI4
line 421
;416:	// -JUHOX: precaching
;417:#if 0
;418:	precache |= (int) trap_Cvar_VariableValue("ui_precache");
;419:#endif
;420:
;421:	s_playermodel.modelpage = 0;
ADDRGP4 s_playermodel+38112
CNSTI4 0
ASGNI4
line 422
;422:	s_playermodel.nummodels = 0;
ADDRGP4 s_playermodel+5340
CNSTI4 0
ASGNI4
line 425
;423:
;424:	// iterate directory of all player models
;425:	numdirs = trap_FS_GetFileList("models/players", "/", dirlist, 2048 );
ADDRGP4 $284
ARGP4
ADDRGP4 $285
ARGP4
ADDRLP4 2148
ARGP4
CNSTI4 2048
ARGI4
ADDRLP4 4200
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRLP4 2144
ADDRLP4 4200
INDIRI4
ASGNI4
line 426
;426:	dirptr  = dirlist;
ADDRLP4 76
ADDRLP4 2148
ASGNP4
line 427
;427:	for (i=0; i<numdirs && s_playermodel.nummodels < MAX_PLAYERMODELS; i++,dirptr+=dirlen+1)
ADDRLP4 92
CNSTI4 0
ASGNI4
ADDRGP4 $289
JUMPV
LABELV $286
line 428
;428:	{
line 429
;429:		dirlen = strlen(dirptr);
ADDRLP4 76
INDIRP4
ARGP4
ADDRLP4 4204
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 88
ADDRLP4 4204
INDIRI4
ASGNI4
line 431
;430:		
;431:		if (dirlen && dirptr[dirlen-1]=='/') dirptr[dirlen-1]='\0';
ADDRLP4 88
INDIRI4
CNSTI4 0
EQI4 $291
ADDRLP4 88
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 76
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 47
NEI4 $291
ADDRLP4 88
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 76
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
LABELV $291
line 433
;432:
;433:		if (!strcmp(dirptr,".") || !strcmp(dirptr,".."))
ADDRLP4 76
INDIRP4
ARGP4
ADDRGP4 $295
ARGP4
ADDRLP4 4212
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 4212
INDIRI4
CNSTI4 0
EQI4 $297
ADDRLP4 76
INDIRP4
ARGP4
ADDRGP4 $296
ARGP4
ADDRLP4 4216
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 4216
INDIRI4
CNSTI4 0
NEI4 $293
LABELV $297
line 434
;434:			continue;
ADDRGP4 $287
JUMPV
LABELV $293
line 437
;435:			
;436:		// iterate all skin files in directory
;437:		numfiles = trap_FS_GetFileList( va("models/players/%s",dirptr), "tga", filelist, 2048 );
ADDRGP4 $298
ARGP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRLP4 4220
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4220
INDIRP4
ARGP4
ADDRGP4 $299
ARGP4
ADDRLP4 96
ARGP4
CNSTI4 2048
ARGI4
ADDRLP4 4224
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRLP4 80
ADDRLP4 4224
INDIRI4
ASGNI4
line 438
;438:		fileptr  = filelist;
ADDRLP4 0
ADDRLP4 96
ASGNP4
line 439
;439:		for (j=0; j<numfiles && s_playermodel.nummodels < MAX_PLAYERMODELS;j++,fileptr+=filelen+1)
ADDRLP4 68
CNSTI4 0
ASGNI4
ADDRGP4 $303
JUMPV
LABELV $300
line 440
;440:		{
line 441
;441:			filelen = strlen(fileptr);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4228
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 72
ADDRLP4 4228
INDIRI4
ASGNI4
line 443
;442:
;443:			COM_StripExtension(fileptr,skinname);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 COM_StripExtension
CALLV
pop
line 446
;444:
;445:			// look for icon_????
;446:			if (!Q_stricmpn(skinname,"icon_",5))
ADDRLP4 4
ARGP4
ADDRGP4 $254
ARGP4
CNSTI4 5
ARGI4
ADDRLP4 4232
ADDRGP4 Q_stricmpn
CALLI4
ASGNI4
ADDRLP4 4232
INDIRI4
CNSTI4 0
NEI4 $305
line 447
;447:			{
line 448
;448:				Com_sprintf( s_playermodel.modelnames[s_playermodel.nummodels++],
ADDRLP4 4240
ADDRGP4 s_playermodel+5340
ASGNP4
ADDRLP4 4236
ADDRLP4 4240
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 4240
INDIRP4
ADDRLP4 4236
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4236
INDIRI4
CNSTI4 7
LSHI4
ADDRGP4 s_playermodel+5344
ADDP4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $311
ARGP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 453
;449:					sizeof( s_playermodel.modelnames[s_playermodel.nummodels] ),
;450:					"models/players/%s/%s", dirptr, skinname );
;451:				//if (s_playermodel.nummodels >= MAX_PLAYERMODELS)
;452:				//	return;
;453:			}
LABELV $305
line 455
;454:
;455:			if( precache ) {
ADDRLP4 84
INDIRI4
CNSTI4 0
EQI4 $312
line 456
;456:				trap_S_RegisterSound( va( "sound/player/announce/%s_wins.wav", skinname), qfalse );
ADDRGP4 $314
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 4236
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4236
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_S_RegisterSound
CALLI4
pop
line 457
;457:			}
LABELV $312
line 458
;458:		}
LABELV $301
line 439
ADDRLP4 68
ADDRLP4 68
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 72
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 0
INDIRP4
ADDP4
ASGNP4
LABELV $303
ADDRLP4 68
INDIRI4
ADDRLP4 80
INDIRI4
GEI4 $315
ADDRGP4 s_playermodel+5340
INDIRI4
CNSTI4 256
LTI4 $300
LABELV $315
line 459
;459:	}	
LABELV $287
line 427
ADDRLP4 92
ADDRLP4 92
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 76
ADDRLP4 88
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 76
INDIRP4
ADDP4
ASGNP4
LABELV $289
ADDRLP4 92
INDIRI4
ADDRLP4 2144
INDIRI4
GEI4 $316
ADDRGP4 s_playermodel+5340
INDIRI4
CNSTI4 256
LTI4 $286
LABELV $316
line 463
;460:
;461:	//APSFIXME - Degenerate no models case
;462:
;463:	s_playermodel.numpages = s_playermodel.nummodels/MAX_MODELSPERPAGE;
ADDRGP4 s_playermodel+38116
ADDRGP4 s_playermodel+5340
INDIRI4
CNSTI4 16
DIVI4
ASGNI4
line 464
;464:	if (s_playermodel.nummodels % MAX_MODELSPERPAGE)
ADDRGP4 s_playermodel+5340
INDIRI4
CNSTI4 16
MODI4
CNSTI4 0
EQI4 $319
line 465
;465:		s_playermodel.numpages++;
ADDRLP4 4204
ADDRGP4 s_playermodel+38116
ASGNP4
ADDRLP4 4204
INDIRP4
ADDRLP4 4204
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $319
line 466
;466:}
LABELV $280
endproc PlayerModel_BuildList 4244 20
proc PlayerModel_SetMenuItems 96 12
line 474
;467:
;468:/*
;469:=================
;470:PlayerModel_SetMenuItems
;471:=================
;472:*/
;473:static void PlayerModel_SetMenuItems( void )
;474:{
line 486
;475:	int				i;
;476:	int				maxlen;
;477:	char			modelskin[64];
;478:	char*			buffptr;
;479:	char*			pdest;
;480:
;481:	// name
;482:	// JUHOX: get the subtitle from the new parameter
;483:#if !MONSTER_MODE
;484:	trap_Cvar_VariableStringBuffer( "name", s_playermodel.playername.string, 16 );
;485:#else
;486:	Q_strncpyz(s_playermodel.playername.string, subtitle, 16);
ADDRGP4 s_playermodel+4160+60
INDIRP4
ARGP4
ADDRGP4 subtitle
INDIRP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 488
;487:#endif
;488:	Q_CleanStr( s_playermodel.playername.string );
ADDRGP4 s_playermodel+4160+60
INDIRP4
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 495
;489:
;490:	// model
;491:	// JUHOX: get the model cvar from the new parameter
;492:#if !MONSTER_MODE
;493:	trap_Cvar_VariableStringBuffer( "model", s_playermodel.modelskin, 64 );
;494:#else
;495:	if (modelvar1) trap_Cvar_VariableStringBuffer(modelvar1, s_playermodel.modelskin, 64);
ADDRGP4 modelvar1
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $328
ADDRGP4 modelvar1
INDIRP4
ARGP4
ADDRGP4 s_playermodel+38120
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
ADDRGP4 $329
JUMPV
LABELV $328
line 496
;496:	else if (modelBuf) Q_strncpyz(s_playermodel.modelskin, modelBuf, 64);
ADDRGP4 modelBuf
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $331
ADDRGP4 s_playermodel+38120
ARGP4
ADDRGP4 modelBuf
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
ADDRGP4 $332
JUMPV
LABELV $331
line 497
;497:	else strcpy(s_playermodel.modelskin, "sarge/default");
ADDRGP4 s_playermodel+38120
ARGP4
ADDRGP4 $335
ARGP4
ADDRGP4 strcpy
CALLP4
pop
LABELV $332
LABELV $329
line 501
;498:#endif
;499:	
;500:	// find model in our list
;501:	for (i=0; i<s_playermodel.nummodels; i++)
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $339
JUMPV
LABELV $336
line 502
;502:	{
line 504
;503:		// strip icon_
;504:		buffptr  = s_playermodel.modelnames[i] + strlen("models/players/");
ADDRGP4 $253
ARGP4
ADDRLP4 80
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 80
INDIRI4
ADDRLP4 4
INDIRI4
CNSTI4 7
LSHI4
ADDRGP4 s_playermodel+5344
ADDP4
ADDP4
ASGNP4
line 505
;505:		pdest    = strstr(buffptr,"icon_");
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 $254
ARGP4
ADDRLP4 84
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 84
INDIRP4
ASGNP4
line 506
;506:		if (pdest)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $337
line 507
;507:		{
line 508
;508:			Q_strncpyz(modelskin,buffptr,pdest-buffptr+1);
ADDRLP4 16
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 509
;509:			strcat(modelskin,pdest + 5);
ADDRLP4 16
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 5
ADDP4
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 510
;510:		}
line 512
;511:		else
;512:			continue;
LABELV $343
line 514
;513:
;514:		if (!Q_stricmp( s_playermodel.modelskin, modelskin ))
ADDRGP4 s_playermodel+38120
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 88
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 0
NEI4 $344
line 515
;515:		{
line 517
;516:			// found pic, set selection here		
;517:			s_playermodel.selectedmodel = i;
ADDRGP4 s_playermodel+38184
ADDRLP4 4
INDIRI4
ASGNI4
line 518
;518:			s_playermodel.modelpage     = i/MAX_MODELSPERPAGE;
ADDRGP4 s_playermodel+38112
ADDRLP4 4
INDIRI4
CNSTI4 16
DIVI4
ASGNI4
line 521
;519:
;520:			// seperate the model name
;521:			maxlen = pdest-buffptr;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 522
;522:			if (maxlen > 16)
ADDRLP4 12
INDIRI4
CNSTI4 16
LEI4 $349
line 523
;523:				maxlen = 16;
ADDRLP4 12
CNSTI4 16
ASGNI4
LABELV $349
line 524
;524:			Q_strncpyz( s_playermodel.modelname.string, buffptr, maxlen );
ADDRGP4 s_playermodel+4016+60
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 525
;525:			Q_strupr( s_playermodel.modelname.string );
ADDRGP4 s_playermodel+4016+60
INDIRP4
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 528
;526:
;527:			// seperate the skin name
;528:			maxlen = strlen(pdest+5)+1;
ADDRLP4 0
INDIRP4
CNSTI4 5
ADDP4
ARGP4
ADDRLP4 92
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 92
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 529
;529:			if (maxlen > 16)
ADDRLP4 12
INDIRI4
CNSTI4 16
LEI4 $355
line 530
;530:				maxlen = 16;
ADDRLP4 12
CNSTI4 16
ASGNI4
LABELV $355
line 531
;531:			Q_strncpyz( s_playermodel.skinname.string, pdest+5, maxlen );
ADDRGP4 s_playermodel+4088+60
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 5
ADDP4
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 532
;532:			Q_strupr( s_playermodel.skinname.string );
ADDRGP4 s_playermodel+4088+60
INDIRP4
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 533
;533:			break;
ADDRGP4 $338
JUMPV
LABELV $344
line 535
;534:		}
;535:	}
LABELV $337
line 501
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $339
ADDRLP4 4
INDIRI4
ADDRGP4 s_playermodel+5340
INDIRI4
LTI4 $336
LABELV $338
line 536
;536:}
LABELV $323
endproc PlayerModel_SetMenuItems 96 12
bss
align 1
LABELV $362
skip 32
align 1
LABELV $363
skip 32
align 1
LABELV $364
skip 32
code
proc PlayerModel_MenuInit 24 12
line 544
;537:
;538:/*
;539:=================
;540:PlayerModel_MenuInit
;541:=================
;542:*/
;543:static void PlayerModel_MenuInit( void )
;544:{
line 555
;545:	int			i;
;546:	int			j;
;547:	int			k;
;548:	int			x;
;549:	int			y;
;550:	static char	playername[32];
;551:	static char	modelname[32];
;552:	static char	skinname[32];
;553:
;554:	// zero set all our globals
;555:	memset( &s_playermodel, 0 ,sizeof(playermodel_t) );
ADDRGP4 s_playermodel
ARGP4
CNSTI4 0
ARGI4
CNSTI4 38188
ARGI4
ADDRGP4 memset
CALLP4
pop
line 557
;556:
;557:	PlayerModel_Cache();
ADDRGP4 PlayerModel_Cache
CALLV
pop
line 559
;558:
;559:	s_playermodel.menu.key        = PlayerModel_MenuKey;
ADDRGP4 s_playermodel+400
ADDRGP4 PlayerModel_MenuKey
ASGNP4
line 560
;560:	s_playermodel.menu.wrapAround = qtrue;
ADDRGP4 s_playermodel+404
CNSTI4 1
ASGNI4
line 561
;561:	s_playermodel.menu.fullscreen = qtrue;
ADDRGP4 s_playermodel+408
CNSTI4 1
ASGNI4
line 563
;562:
;563:	s_playermodel.banner.generic.type  = MTYPE_BTEXT;
ADDRGP4 s_playermodel+3504
CNSTI4 10
ASGNI4
line 564
;564:	s_playermodel.banner.generic.x     = 320;
ADDRGP4 s_playermodel+3504+12
CNSTI4 320
ASGNI4
line 565
;565:	s_playermodel.banner.generic.y     = 16;
ADDRGP4 s_playermodel+3504+16
CNSTI4 16
ASGNI4
line 570
;566:	// JUHOX: set player model page title according to the new parameter
;567:#if !MONSTER_MODE
;568:	s_playermodel.banner.string        = "PLAYER MODEL";
;569:#else
;570:	s_playermodel.banner.string        = title;
ADDRGP4 s_playermodel+3504+60
ADDRGP4 title
INDIRP4
ASGNP4
line 572
;571:#endif
;572:	s_playermodel.banner.color         = color_white;
ADDRGP4 s_playermodel+3504+68
ADDRGP4 color_white
ASGNP4
line 573
;573:	s_playermodel.banner.style         = UI_CENTER;
ADDRGP4 s_playermodel+3504+64
CNSTI4 1
ASGNI4
line 575
;574:
;575:	s_playermodel.framel.generic.type  = MTYPE_BITMAP;
ADDRGP4 s_playermodel+3240
CNSTI4 6
ASGNI4
line 576
;576:	s_playermodel.framel.generic.name  = MODEL_FRAMEL;
ADDRGP4 s_playermodel+3240+4
ADDRGP4 $100
ASGNP4
line 577
;577:	s_playermodel.framel.generic.flags = QMF_LEFT_JUSTIFY|QMF_INACTIVE;
ADDRGP4 s_playermodel+3240+44
CNSTU4 16388
ASGNU4
line 578
;578:	s_playermodel.framel.generic.x     = 0;
ADDRGP4 s_playermodel+3240+12
CNSTI4 0
ASGNI4
line 579
;579:	s_playermodel.framel.generic.y     = 78;
ADDRGP4 s_playermodel+3240+16
CNSTI4 78
ASGNI4
line 580
;580:	s_playermodel.framel.width         = 256;
ADDRGP4 s_playermodel+3240+76
CNSTI4 256
ASGNI4
line 581
;581:	s_playermodel.framel.height        = 329;
ADDRGP4 s_playermodel+3240+80
CNSTI4 329
ASGNI4
line 583
;582:
;583:	s_playermodel.framer.generic.type  = MTYPE_BITMAP;
ADDRGP4 s_playermodel+3328
CNSTI4 6
ASGNI4
line 584
;584:	s_playermodel.framer.generic.name  = MODEL_FRAMER;
ADDRGP4 s_playermodel+3328+4
ADDRGP4 $101
ASGNP4
line 585
;585:	s_playermodel.framer.generic.flags = QMF_LEFT_JUSTIFY|QMF_INACTIVE;
ADDRGP4 s_playermodel+3328+44
CNSTU4 16388
ASGNU4
line 586
;586:	s_playermodel.framer.generic.x     = 376;
ADDRGP4 s_playermodel+3328+12
CNSTI4 376
ASGNI4
line 587
;587:	s_playermodel.framer.generic.y     = 76;
ADDRGP4 s_playermodel+3328+16
CNSTI4 76
ASGNI4
line 588
;588:	s_playermodel.framer.width         = 256;
ADDRGP4 s_playermodel+3328+76
CNSTI4 256
ASGNI4
line 589
;589:	s_playermodel.framer.height        = 334;
ADDRGP4 s_playermodel+3328+80
CNSTI4 334
ASGNI4
line 591
;590:
;591:	s_playermodel.ports.generic.type  = MTYPE_BITMAP;
ADDRGP4 s_playermodel+3416
CNSTI4 6
ASGNI4
line 592
;592:	s_playermodel.ports.generic.name  = MODEL_PORTS;
ADDRGP4 s_playermodel+3416+4
ADDRGP4 $102
ASGNP4
line 593
;593:	s_playermodel.ports.generic.flags = QMF_LEFT_JUSTIFY|QMF_INACTIVE;
ADDRGP4 s_playermodel+3416+44
CNSTU4 16388
ASGNU4
line 594
;594:	s_playermodel.ports.generic.x     = 50;
ADDRGP4 s_playermodel+3416+12
CNSTI4 50
ASGNI4
line 595
;595:	s_playermodel.ports.generic.y     = 59;
ADDRGP4 s_playermodel+3416+16
CNSTI4 59
ASGNI4
line 596
;596:	s_playermodel.ports.width         = 274;
ADDRGP4 s_playermodel+3416+76
CNSTI4 274
ASGNI4
line 597
;597:	s_playermodel.ports.height        = 274;
ADDRGP4 s_playermodel+3416+80
CNSTI4 274
ASGNI4
line 599
;598:
;599:	y =	59;
ADDRLP4 8
CNSTI4 59
ASGNI4
line 600
;600:	for (i=0,k=0; i<PLAYERGRID_ROWS; i++)
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $421
JUMPV
LABELV $418
line 601
;601:	{
line 602
;602:		x =	50;
ADDRLP4 4
CNSTI4 50
ASGNI4
line 603
;603:		for (j=0; j<PLAYERGRID_COLS; j++,k++)
ADDRLP4 12
CNSTI4 0
ASGNI4
LABELV $422
line 604
;604:		{
line 605
;605:			s_playermodel.pics[k].generic.type	   = MTYPE_BITMAP;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_playermodel+424
ADDP4
CNSTI4 6
ASGNI4
line 606
;606:			s_playermodel.pics[k].generic.flags    = QMF_LEFT_JUSTIFY|QMF_INACTIVE;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_playermodel+424+44
ADDP4
CNSTU4 16388
ASGNU4
line 607
;607:			s_playermodel.pics[k].generic.x		   = x;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_playermodel+424+12
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 608
;608:			s_playermodel.pics[k].generic.y		   = y;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_playermodel+424+16
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 609
;609:			s_playermodel.pics[k].width  		   = 64;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_playermodel+424+76
ADDP4
CNSTI4 64
ASGNI4
line 610
;610:			s_playermodel.pics[k].height  		   = 64;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_playermodel+424+80
ADDP4
CNSTI4 64
ASGNI4
line 611
;611:			s_playermodel.pics[k].focuspic         = MODEL_SELECTED;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_playermodel+424+60
ADDP4
ADDRGP4 $99
ASGNP4
line 612
;612:			s_playermodel.pics[k].focuscolor       = colorRed;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_playermodel+424+84
ADDP4
ADDRGP4 colorRed
ASGNP4
line 614
;613:
;614:			s_playermodel.picbuttons[k].generic.type	 = MTYPE_BITMAP;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_playermodel+1832
ADDP4
CNSTI4 6
ASGNI4
line 615
;615:			s_playermodel.picbuttons[k].generic.flags    = QMF_LEFT_JUSTIFY|QMF_NODEFAULTINIT|QMF_PULSEIFFOCUS;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_playermodel+1832+44
ADDP4
CNSTU4 33028
ASGNU4
line 616
;616:			s_playermodel.picbuttons[k].generic.id	     = ID_PLAYERPIC0+k;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_playermodel+1832+8
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 617
;617:			s_playermodel.picbuttons[k].generic.callback = PlayerModel_PicEvent;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_playermodel+1832+48
ADDP4
ADDRGP4 PlayerModel_PicEvent
ASGNP4
line 618
;618:			s_playermodel.picbuttons[k].generic.x    	 = x - 16;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_playermodel+1832+12
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 16
SUBI4
ASGNI4
line 619
;619:			s_playermodel.picbuttons[k].generic.y		 = y - 16;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_playermodel+1832+16
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 16
SUBI4
ASGNI4
line 620
;620:			s_playermodel.picbuttons[k].generic.left	 = x;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_playermodel+1832+20
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 621
;621:			s_playermodel.picbuttons[k].generic.top		 = y;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_playermodel+1832+24
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 622
;622:			s_playermodel.picbuttons[k].generic.right	 = x + 64;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_playermodel+1832+28
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 64
ADDI4
ASGNI4
line 623
;623:			s_playermodel.picbuttons[k].generic.bottom   = y + 64;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_playermodel+1832+32
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 64
ADDI4
ASGNI4
line 624
;624:			s_playermodel.picbuttons[k].width  		     = 128;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_playermodel+1832+76
ADDP4
CNSTI4 128
ASGNI4
line 625
;625:			s_playermodel.picbuttons[k].height  		 = 128;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_playermodel+1832+80
ADDP4
CNSTI4 128
ASGNI4
line 626
;626:			s_playermodel.picbuttons[k].focuspic  		 = MODEL_SELECT;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_playermodel+1832+60
ADDP4
ADDRGP4 $98
ASGNP4
line 627
;627:			s_playermodel.picbuttons[k].focuscolor  	 = colorRed;
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_playermodel+1832+84
ADDP4
ADDRGP4 colorRed
ASGNP4
line 629
;628:
;629:			x += 64+6;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 70
ADDI4
ASGNI4
line 630
;630:		}
LABELV $423
line 603
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 4
LTI4 $422
line 631
;631:		y += 64+6;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 70
ADDI4
ASGNI4
line 632
;632:	}
LABELV $419
line 600
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $421
ADDRLP4 16
INDIRI4
CNSTI4 4
LTI4 $418
line 634
;633:
;634:	s_playermodel.playername.generic.type  = MTYPE_PTEXT;
ADDRGP4 s_playermodel+4160
CNSTI4 9
ASGNI4
line 635
;635:	s_playermodel.playername.generic.flags = QMF_CENTER_JUSTIFY|QMF_INACTIVE;
ADDRGP4 s_playermodel+4160+44
CNSTU4 16392
ASGNU4
line 636
;636:	s_playermodel.playername.generic.x	   = 320;
ADDRGP4 s_playermodel+4160+12
CNSTI4 320
ASGNI4
line 637
;637:	s_playermodel.playername.generic.y	   = 440;
ADDRGP4 s_playermodel+4160+16
CNSTI4 440
ASGNI4
line 638
;638:	s_playermodel.playername.string	       = playername;
ADDRGP4 s_playermodel+4160+60
ADDRGP4 $362
ASGNP4
line 639
;639:	s_playermodel.playername.style		   = UI_CENTER;
ADDRGP4 s_playermodel+4160+64
CNSTI4 1
ASGNI4
line 640
;640:	s_playermodel.playername.color         = text_color_normal;
ADDRGP4 s_playermodel+4160+68
ADDRGP4 text_color_normal
ASGNP4
line 642
;641:
;642:	s_playermodel.modelname.generic.type  = MTYPE_PTEXT;
ADDRGP4 s_playermodel+4016
CNSTI4 9
ASGNI4
line 643
;643:	s_playermodel.modelname.generic.flags = QMF_CENTER_JUSTIFY|QMF_INACTIVE;
ADDRGP4 s_playermodel+4016+44
CNSTU4 16392
ASGNU4
line 644
;644:	s_playermodel.modelname.generic.x	  = 497;
ADDRGP4 s_playermodel+4016+12
CNSTI4 497
ASGNI4
line 645
;645:	s_playermodel.modelname.generic.y	  = 54;
ADDRGP4 s_playermodel+4016+16
CNSTI4 54
ASGNI4
line 646
;646:	s_playermodel.modelname.string	      = modelname;
ADDRGP4 s_playermodel+4016+60
ADDRGP4 $363
ASGNP4
line 647
;647:	s_playermodel.modelname.style		  = UI_CENTER;
ADDRGP4 s_playermodel+4016+64
CNSTI4 1
ASGNI4
line 648
;648:	s_playermodel.modelname.color         = text_color_normal;
ADDRGP4 s_playermodel+4016+68
ADDRGP4 text_color_normal
ASGNP4
line 650
;649:
;650:	s_playermodel.skinname.generic.type   = MTYPE_PTEXT;
ADDRGP4 s_playermodel+4088
CNSTI4 9
ASGNI4
line 651
;651:	s_playermodel.skinname.generic.flags  = QMF_CENTER_JUSTIFY|QMF_INACTIVE;
ADDRGP4 s_playermodel+4088+44
CNSTU4 16392
ASGNU4
line 652
;652:	s_playermodel.skinname.generic.x	  = 497;
ADDRGP4 s_playermodel+4088+12
CNSTI4 497
ASGNI4
line 653
;653:	s_playermodel.skinname.generic.y	  = 394;
ADDRGP4 s_playermodel+4088+16
CNSTI4 394
ASGNI4
line 654
;654:	s_playermodel.skinname.string	      = skinname;
ADDRGP4 s_playermodel+4088+60
ADDRGP4 $364
ASGNP4
line 655
;655:	s_playermodel.skinname.style		  = UI_CENTER;
ADDRGP4 s_playermodel+4088+64
CNSTI4 1
ASGNI4
line 656
;656:	s_playermodel.skinname.color          = text_color_normal;
ADDRGP4 s_playermodel+4088+68
ADDRGP4 text_color_normal
ASGNP4
line 658
;657:
;658:	s_playermodel.player.generic.type      = MTYPE_BITMAP;
ADDRGP4 s_playermodel+3664
CNSTI4 6
ASGNI4
line 659
;659:	s_playermodel.player.generic.flags     = QMF_INACTIVE;
ADDRGP4 s_playermodel+3664+44
CNSTU4 16384
ASGNU4
line 660
;660:	s_playermodel.player.generic.ownerdraw = PlayerModel_DrawPlayer;
ADDRGP4 s_playermodel+3664+56
ADDRGP4 PlayerModel_DrawPlayer
ASGNP4
line 661
;661:	s_playermodel.player.generic.x	       = 400;
ADDRGP4 s_playermodel+3664+12
CNSTI4 400
ASGNI4
line 662
;662:	s_playermodel.player.generic.y	       = -40;
ADDRGP4 s_playermodel+3664+16
CNSTI4 -40
ASGNI4
line 663
;663:	s_playermodel.player.width	           = 32*10;
ADDRGP4 s_playermodel+3664+76
CNSTI4 320
ASGNI4
line 664
;664:	s_playermodel.player.height            = 56*10;
ADDRGP4 s_playermodel+3664+80
CNSTI4 560
ASGNI4
line 666
;665:
;666:	s_playermodel.arrows.generic.type		= MTYPE_BITMAP;
ADDRGP4 s_playermodel+3752
CNSTI4 6
ASGNI4
line 667
;667:	s_playermodel.arrows.generic.name		= MODEL_ARROWS;
ADDRGP4 s_playermodel+3752+4
ADDRGP4 $103
ASGNP4
line 668
;668:	s_playermodel.arrows.generic.flags		= QMF_INACTIVE;
ADDRGP4 s_playermodel+3752+44
CNSTU4 16384
ASGNU4
line 669
;669:	s_playermodel.arrows.generic.x			= 125;
ADDRGP4 s_playermodel+3752+12
CNSTI4 125
ASGNI4
line 670
;670:	s_playermodel.arrows.generic.y			= 340;
ADDRGP4 s_playermodel+3752+16
CNSTI4 340
ASGNI4
line 671
;671:	s_playermodel.arrows.width				= 128;
ADDRGP4 s_playermodel+3752+76
CNSTI4 128
ASGNI4
line 672
;672:	s_playermodel.arrows.height				= 32;
ADDRGP4 s_playermodel+3752+80
CNSTI4 32
ASGNI4
line 674
;673:
;674:	s_playermodel.left.generic.type			= MTYPE_BITMAP;
ADDRGP4 s_playermodel+3840
CNSTI4 6
ASGNI4
line 675
;675:	s_playermodel.left.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_playermodel+3840+44
CNSTU4 260
ASGNU4
line 676
;676:	s_playermodel.left.generic.callback		= PlayerModel_MenuEvent;
ADDRGP4 s_playermodel+3840+48
ADDRGP4 PlayerModel_MenuEvent
ASGNP4
line 677
;677:	s_playermodel.left.generic.id			= ID_PREVPAGE;
ADDRGP4 s_playermodel+3840+8
CNSTI4 100
ASGNI4
line 678
;678:	s_playermodel.left.generic.x			= 125;
ADDRGP4 s_playermodel+3840+12
CNSTI4 125
ASGNI4
line 679
;679:	s_playermodel.left.generic.y			= 340;
ADDRGP4 s_playermodel+3840+16
CNSTI4 340
ASGNI4
line 680
;680:	s_playermodel.left.width  				= 64;
ADDRGP4 s_playermodel+3840+76
CNSTI4 64
ASGNI4
line 681
;681:	s_playermodel.left.height  				= 32;
ADDRGP4 s_playermodel+3840+80
CNSTI4 32
ASGNI4
line 682
;682:	s_playermodel.left.focuspic				= MODEL_ARROWSL;
ADDRGP4 s_playermodel+3840+60
ADDRGP4 $104
ASGNP4
line 684
;683:
;684:	s_playermodel.right.generic.type	    = MTYPE_BITMAP;
ADDRGP4 s_playermodel+3928
CNSTI4 6
ASGNI4
line 685
;685:	s_playermodel.right.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_playermodel+3928+44
CNSTU4 260
ASGNU4
line 686
;686:	s_playermodel.right.generic.callback	= PlayerModel_MenuEvent;
ADDRGP4 s_playermodel+3928+48
ADDRGP4 PlayerModel_MenuEvent
ASGNP4
line 687
;687:	s_playermodel.right.generic.id			= ID_NEXTPAGE;
ADDRGP4 s_playermodel+3928+8
CNSTI4 101
ASGNI4
line 688
;688:	s_playermodel.right.generic.x			= 125+61;
ADDRGP4 s_playermodel+3928+12
CNSTI4 186
ASGNI4
line 689
;689:	s_playermodel.right.generic.y			= 340;
ADDRGP4 s_playermodel+3928+16
CNSTI4 340
ASGNI4
line 690
;690:	s_playermodel.right.width  				= 64;
ADDRGP4 s_playermodel+3928+76
CNSTI4 64
ASGNI4
line 691
;691:	s_playermodel.right.height  		    = 32;
ADDRGP4 s_playermodel+3928+80
CNSTI4 32
ASGNI4
line 692
;692:	s_playermodel.right.focuspic			= MODEL_ARROWSR;
ADDRGP4 s_playermodel+3928+60
ADDRGP4 $105
ASGNP4
line 694
;693:
;694:	s_playermodel.back.generic.type	    = MTYPE_BITMAP;
ADDRGP4 s_playermodel+3576
CNSTI4 6
ASGNI4
line 695
;695:	s_playermodel.back.generic.name     = MODEL_BACK0;
ADDRGP4 s_playermodel+3576+4
ADDRGP4 $96
ASGNP4
line 696
;696:	s_playermodel.back.generic.flags    = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_playermodel+3576+44
CNSTU4 260
ASGNU4
line 697
;697:	s_playermodel.back.generic.callback = PlayerModel_MenuEvent;
ADDRGP4 s_playermodel+3576+48
ADDRGP4 PlayerModel_MenuEvent
ASGNP4
line 698
;698:	s_playermodel.back.generic.id	    = ID_BACK;
ADDRGP4 s_playermodel+3576+8
CNSTI4 102
ASGNI4
line 699
;699:	s_playermodel.back.generic.x		= 0;
ADDRGP4 s_playermodel+3576+12
CNSTI4 0
ASGNI4
line 700
;700:	s_playermodel.back.generic.y		= 480-64;
ADDRGP4 s_playermodel+3576+16
CNSTI4 416
ASGNI4
line 701
;701:	s_playermodel.back.width  		    = 128;
ADDRGP4 s_playermodel+3576+76
CNSTI4 128
ASGNI4
line 702
;702:	s_playermodel.back.height  		    = 64;
ADDRGP4 s_playermodel+3576+80
CNSTI4 64
ASGNI4
line 703
;703:	s_playermodel.back.focuspic         = MODEL_BACK1;
ADDRGP4 s_playermodel+3576+60
ADDRGP4 $97
ASGNP4
line 705
;704:
;705:	Menu_AddItem( &s_playermodel.menu,	&s_playermodel.banner );
ADDRGP4 s_playermodel
ARGP4
ADDRGP4 s_playermodel+3504
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 706
;706:	Menu_AddItem( &s_playermodel.menu,	&s_playermodel.framel );
ADDRGP4 s_playermodel
ARGP4
ADDRGP4 s_playermodel+3240
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 707
;707:	Menu_AddItem( &s_playermodel.menu,	&s_playermodel.framer );
ADDRGP4 s_playermodel
ARGP4
ADDRGP4 s_playermodel+3328
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 708
;708:	Menu_AddItem( &s_playermodel.menu,	&s_playermodel.ports );
ADDRGP4 s_playermodel
ARGP4
ADDRGP4 s_playermodel+3416
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 709
;709:	Menu_AddItem( &s_playermodel.menu,	&s_playermodel.playername );
ADDRGP4 s_playermodel
ARGP4
ADDRGP4 s_playermodel+4160
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 710
;710:	Menu_AddItem( &s_playermodel.menu,	&s_playermodel.modelname );
ADDRGP4 s_playermodel
ARGP4
ADDRGP4 s_playermodel+4016
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 711
;711:	Menu_AddItem( &s_playermodel.menu,	&s_playermodel.skinname );
ADDRGP4 s_playermodel
ARGP4
ADDRGP4 s_playermodel+4088
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 713
;712:
;713:	for (i=0; i<MAX_MODELSPERPAGE; i++)
ADDRLP4 16
CNSTI4 0
ASGNI4
LABELV $593
line 714
;714:	{
line 715
;715:		Menu_AddItem( &s_playermodel.menu,	&s_playermodel.pics[i] );
ADDRGP4 s_playermodel
ARGP4
ADDRLP4 16
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_playermodel+424
ADDP4
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 716
;716:		Menu_AddItem( &s_playermodel.menu,	&s_playermodel.picbuttons[i] );
ADDRGP4 s_playermodel
ARGP4
ADDRLP4 16
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 s_playermodel+1832
ADDP4
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 717
;717:	}
LABELV $594
line 713
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 16
LTI4 $593
line 719
;718:
;719:	Menu_AddItem( &s_playermodel.menu,	&s_playermodel.player );
ADDRGP4 s_playermodel
ARGP4
ADDRGP4 s_playermodel+3664
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 720
;720:	Menu_AddItem( &s_playermodel.menu,	&s_playermodel.arrows );
ADDRGP4 s_playermodel
ARGP4
ADDRGP4 s_playermodel+3752
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 721
;721:	Menu_AddItem( &s_playermodel.menu,	&s_playermodel.left );
ADDRGP4 s_playermodel
ARGP4
ADDRGP4 s_playermodel+3840
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 722
;722:	Menu_AddItem( &s_playermodel.menu,	&s_playermodel.right );
ADDRGP4 s_playermodel
ARGP4
ADDRGP4 s_playermodel+3928
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 723
;723:	Menu_AddItem( &s_playermodel.menu,	&s_playermodel.back );
ADDRGP4 s_playermodel
ARGP4
ADDRGP4 s_playermodel+3576
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 729
;724:
;725:	// find all available models
;726://	PlayerModel_BuildList();
;727:
;728:	// set initial states
;729:	PlayerModel_SetMenuItems();
ADDRGP4 PlayerModel_SetMenuItems
CALLV
pop
line 732
;730:
;731:	// update user interface
;732:	PlayerModel_UpdateGrid();
ADDRGP4 PlayerModel_UpdateGrid
CALLV
pop
line 733
;733:	PlayerModel_UpdateModel();
ADDRGP4 PlayerModel_UpdateModel
CALLV
pop
line 734
;734:}
LABELV $361
endproc PlayerModel_MenuInit 24 12
export PlayerModel_Cache
proc PlayerModel_Cache 4 4
line 742
;735:
;736:/*
;737:=================
;738:PlayerModel_Cache
;739:=================
;740:*/
;741:void PlayerModel_Cache( void )
;742:{
line 745
;743:	int	i;
;744:
;745:	for( i = 0; playermodel_artlist[i]; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $608
JUMPV
LABELV $605
line 746
;746:		trap_R_RegisterShaderNoMip( playermodel_artlist[i] );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 playermodel_artlist
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 747
;747:	}
LABELV $606
line 745
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $608
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 playermodel_artlist
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $605
line 749
;748:
;749:	PlayerModel_BuildList();
ADDRGP4 PlayerModel_BuildList
CALLV
pop
line 750
;750:	for( i = 0; i < s_playermodel.nummodels; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $612
JUMPV
LABELV $609
line 751
;751:		trap_R_RegisterShaderNoMip( s_playermodel.modelnames[i] );
ADDRLP4 0
INDIRI4
CNSTI4 7
LSHI4
ADDRGP4 s_playermodel+5344
ADDP4
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 752
;752:	}
LABELV $610
line 750
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $612
ADDRLP4 0
INDIRI4
ADDRGP4 s_playermodel+5340
INDIRI4
LTI4 $609
line 753
;753:}
LABELV $604
endproc PlayerModel_Cache 4 4
export UI_PlayerModelMenu
proc UI_PlayerModelMenu 0 8
line 770
;754:
;755:// JUHOX: new UI_PlayerModelMenu() parameters
;756:#if !MONSTER_MODE
;757:void UI_PlayerModelMenu(void)
;758:{
;759:#else
;760:void UI_PlayerModelMenu(
;761:	char* titleStr,
;762:	const char* subtitleStr,
;763:	const char* modelcvar1Name,
;764:	const char* modelcvar2Name,
;765:	const char* modelcvar3Name,
;766:	const char* modelcvar4Name,
;767:	char* modelBuffer,
;768:	int modelBufferSize,
;769:	weapon_t weapon
;770:) {
line 771
;771:	title = titleStr;
ADDRGP4 title
ADDRFP4 0
INDIRP4
ASGNP4
line 772
;772:	subtitle = subtitleStr;
ADDRGP4 subtitle
ADDRFP4 4
INDIRP4
ASGNP4
line 773
;773:	modelvar1 = modelcvar1Name;
ADDRGP4 modelvar1
ADDRFP4 8
INDIRP4
ASGNP4
line 774
;774:	modelvar2 = modelcvar2Name;
ADDRGP4 modelvar2
ADDRFP4 12
INDIRP4
ASGNP4
line 775
;775:	modelvar3 = modelcvar3Name;
ADDRGP4 modelvar3
ADDRFP4 16
INDIRP4
ASGNP4
line 776
;776:	modelvar4 = modelcvar4Name;
ADDRGP4 modelvar4
ADDRFP4 20
INDIRP4
ASGNP4
line 777
;777:	modelBuf = modelBuffer;
ADDRGP4 modelBuf
ADDRFP4 24
INDIRP4
ASGNP4
line 778
;778:	modelBufSize = modelBufferSize;
ADDRGP4 modelBufSize
ADDRFP4 28
INDIRI4
ASGNI4
line 779
;779:	modelweapon = weapon;
ADDRGP4 modelweapon
ADDRFP4 32
INDIRI4
ASGNI4
line 781
;780:#endif
;781:	PlayerModel_MenuInit();
ADDRGP4 PlayerModel_MenuInit
CALLV
pop
line 783
;782:
;783:	UI_PushMenu( &s_playermodel.menu );
ADDRGP4 s_playermodel
ARGP4
ADDRGP4 UI_PushMenu
CALLV
pop
line 785
;784:
;785:	Menu_SetCursorToItem( &s_playermodel.menu, &s_playermodel.pics[s_playermodel.selectedmodel % MAX_MODELSPERPAGE] );
ADDRGP4 s_playermodel
ARGP4
ADDRGP4 s_playermodel+38184
INDIRI4
CNSTI4 16
MODI4
CNSTI4 88
MULI4
ADDRGP4 s_playermodel+424
ADDP4
ARGP4
ADDRGP4 Menu_SetCursorToItem
CALLV
pop
line 786
;786:}
LABELV $615
endproc UI_PlayerModelMenu 0 8
bss
align 4
LABELV modelweapon
skip 4
align 4
LABELV modelBufSize
skip 4
align 4
LABELV modelBuf
skip 4
align 4
LABELV modelvar4
skip 4
align 4
LABELV modelvar3
skip 4
align 4
LABELV modelvar2
skip 4
align 4
LABELV modelvar1
skip 4
align 4
LABELV subtitle
skip 4
align 4
LABELV title
skip 4
align 4
LABELV s_playermodel
skip 38188
import UI_RankStatusMenu
import RankStatus_Cache
import UI_SignupMenu
import Signup_Cache
import UI_LoginMenu
import Login_Cache
import UI_RankingsMenu
import Rankings_Cache
import Rankings_DrawPassword
import Rankings_DrawName
import Rankings_DrawText
import UI_InitGameinfo
import UI_SPUnlockMedals_f
import UI_SPUnlock_f
import UI_GetAwardLevel
import UI_LogAwardData
import UI_NewGame
import UI_GetCurrentGame
import UI_CanShowTierVideo
import UI_ShowTierVideo
import UI_TierCompleted
import UI_SetBestScore
import UI_GetBestScore
import UI_GetNumBots
import UI_GetBotInfoByName
import UI_GetBotInfoByNumber
import UI_GetNumSPTiers
import UI_GetNumSPArenas
import UI_GetNumArenas
import UI_GetSpecialArenaInfo
import UI_GetArenaInfoByMap
import UI_GetArenaInfoByNumber
import UI_NetworkOptionsMenu
import UI_NetworkOptionsMenu_Cache
import UI_SoundOptionsMenu
import UI_SoundOptionsMenu_Cache
import UI_DisplayOptionsMenu
import UI_DisplayOptionsMenu_Cache
import UI_SaveConfigMenu
import UI_SaveConfigMenu_Cache
import UI_LoadConfigMenu
import UI_LoadConfig_Cache
import UI_TeamOrdersMenu_Cache
import UI_TeamOrdersMenu_f
import UI_TeamOrdersMenu
import UI_RemoveBotsMenu
import UI_RemoveBots_Cache
import UI_AddBotsMenu
import UI_AddBots_Cache
import trap_SetPbClStatus
import trap_VerifyCDKey
import trap_SetCDKey
import trap_GetCDKey
import trap_MemoryRemaining
import trap_LAN_GetPingInfo
import trap_LAN_GetPing
import trap_LAN_ClearPing
import trap_LAN_ServerStatus
import trap_LAN_GetPingQueueCount
import trap_LAN_GetServerInfo
import trap_LAN_GetServerAddressString
import trap_LAN_GetServerCount
import trap_GetConfigString
import trap_GetGlconfig
import trap_GetClientState
import trap_GetClipboardData
import trap_Key_SetCatcher
import trap_Key_GetCatcher
import trap_Key_ClearStates
import trap_Key_SetOverstrikeMode
import trap_Key_GetOverstrikeMode
import trap_Key_IsDown
import trap_Key_SetBinding
import trap_Key_GetBindingBuf
import trap_Key_KeynumToStringBuf
import trap_S_StartBackgroundTrack
import trap_S_StopBackgroundTrack
import trap_S_RegisterSound
import trap_S_StartLocalSound
import trap_CM_LerpTag
import trap_UpdateScreen
import trap_R_DrawStretchPic
import trap_R_SetColor
import trap_R_RenderScene
import trap_R_AddLightToScene
import trap_R_AddPolyToScene
import trap_R_AddRefEntityToScene
import trap_R_ClearScene
import trap_R_RegisterShaderNoMip
import trap_R_RegisterSkin
import trap_R_RegisterModel
import trap_FS_Seek
import trap_FS_GetFileList
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_FS_FOpenFile
import trap_Cmd_ExecuteText
import trap_Argv
import trap_Argc
import trap_Cvar_InfoStringBuffer
import trap_Cvar_Create
import trap_Cvar_Reset
import trap_Cvar_SetValue
import trap_Cvar_VariableStringBuffer
import trap_Cvar_VariableValue
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_Milliseconds
import trap_Error
import trap_Print
import UI_SPSkillMenu_Cache
import UI_SPSkillMenu
import UI_SPPostgameMenu_f
import UI_SPPostgameMenu_Cache
import UI_SPArena_Start
import UI_SPLevelMenu_ReInit
import UI_SPLevelMenu_f
import UI_SPLevelMenu
import UI_SPLevelMenu_Cache
import uis
import m_entersound
import UI_StartDemoLoop
import UI_DrawBackPic
import UI_Cvar_VariableString
import UI_Argv
import UI_ForceMenuOff
import UI_PopMenu
import UI_PushMenu
import UI_SetActiveMenu
import UI_IsFullscreen
import UI_DrawTextBox
import UI_AdjustFrom640
import UI_CursorInRect
import UI_DrawChar
import UI_DrawString
import UI_DrawStrlen
import UI_ProportionalStringWidth
import UI_DrawProportionalString_AutoWrapped
import UI_DrawProportionalString
import UI_ProportionalSizeScale
import UI_DrawBannerString
import UI_LerpColor
import UI_SetColor
import UI_UpdateScreen
import UI_DrawRect
import UI_FillRect
import UI_DrawHandlePic
import UI_DrawNamedPic
import UI_ClampCvar
import UI_ConsoleCommand
import UI_Refresh
import UI_MouseEvent
import UI_KeyEvent
import UI_Shutdown
import UI_Init
import UI_RegisterClientModelname
import UI_PlayerInfo_SetInfo
import UI_PlayerInfo_SetModel
import UI_DrawPlayer
import DriverInfo_Cache
import GraphicsOptions_Cache
import UI_GraphicsOptionsMenu
import ServerInfo_Cache
import UI_ServerInfoMenu
import UI_GTS_Menu
import UI_TemplateList_Complete
import UI_TemplateList_SvTemplate
import UI_TemplateMenu
import UI_BotSelectMenu_Cache
import UI_BotSelectMenu
import ServerOptions_Cache
import StartServer_Cache
import UI_StartServerMenu
import ArenaServers_Cache
import UI_ArenaServersMenu
import SpecifyServer_Cache
import UI_SpecifyServerMenu
import SpecifyLeague_Cache
import UI_SpecifyLeagueMenu
import Preferences_Cache
import UI_PreferencesMenu
import PlayerSettings_Cache
import UI_PlayerSettingsMenu
import UI_CDKeyMenu_f
import UI_CDKeyMenu_Cache
import UI_CDKeyMenu
import UI_ModsMenu_Cache
import UI_ModsMenu
import UI_CinematicsMenu_Cache
import UI_CinematicsMenu_f
import UI_CinematicsMenu
import Demos_Cache
import UI_DemosMenu
import Controls_Cache
import UI_ControlsMenu
import UI_DrawConnectScreen
import TeamMain_Cache
import UI_TeamMainMenu
import UI_SetupMenu
import UI_SetupMenu_Cache
import UI_Message
import UI_ConfirmMenu_Style
import UI_ConfirmMenu
import ConfirmMenu_Cache
import UI_InGameMenu
import InGame_Cache
import UI_Hunt_Credits
import UI_CreditMenu
import UI_UpdateCvars
import UI_RegisterCvars
import UI_MainMenu
import MainMenu_Cache
import MenuField_Key
import MenuField_Draw
import MenuField_Init
import MField_Draw
import MField_CharEvent
import MField_KeyDownEvent
import MField_Clear
import ui_medalSounds
import ui_medalPicNames
import ui_medalNames
import text_color_highlight
import text_color_normal
import text_color_disabled
import listbar_color
import list_color
import name_color
import color_dim
import color_red
import color_orange
import color_blue
import color_yellow
import color_white
import color_black
import menu_dim_color
import menu_black_color
import menu_red_color
import menu_highlight_color
import menu_dark_color
import menu_grayed_color
import menu_text_color
import weaponChangeSound
import menu_null_sound
import menu_buzz_sound
import menu_out_sound
import menu_move_sound
import menu_in_sound
import ScrollList_Key
import ScrollList_Draw
import Bitmap_Draw
import Bitmap_Init
import Menu_DefaultKey
import Menu_SetCursorToItem
import Menu_SetCursor
import Menu_ActivateItem
import Menu_ItemAtCursor
import Menu_Draw
import Menu_AdjustCursor
import Menu_AddItem
import Menu_Focus
import Menu_Cache
import ui_cdkeychecked
import ui_cdkey
import ui_server16
import ui_server15
import ui_server14
import ui_server13
import ui_server12
import ui_server11
import ui_server10
import ui_server9
import ui_server8
import ui_server7
import ui_server6
import ui_server5
import ui_server4
import ui_server3
import ui_server2
import ui_server1
import ui_hiDetailTitle
import ui_lensFlare
import ui_marks
import ui_drawCrosshairNames
import ui_drawCrosshair
import ui_brassTime
import ui_browserShowEmpty
import ui_browserShowFull
import ui_browserSortKey
import ui_browserGameType
import ui_browserMaster
import ui_spSelection
import ui_spSkill
import ui_spVideos
import ui_spAwards
import ui_spScores5
import ui_spScores4
import ui_spScores3
import ui_spScores2
import ui_spScores1
import ui_botsFile
import ui_arenasFile
import ui_ctf_friendly
import ui_ctf_timelimit
import ui_ctf_capturelimit
import ui_team_friendly
import ui_team_timelimit
import ui_team_fraglimit
import ui_tourney_timelimit
import ui_tourney_fraglimit
import ui_ffa_timelimit
import ui_ffa_fraglimit
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
LABELV $335
byte 1 115
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 47
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $314
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 97
byte 1 110
byte 1 110
byte 1 111
byte 1 117
byte 1 110
byte 1 99
byte 1 101
byte 1 47
byte 1 37
byte 1 115
byte 1 95
byte 1 119
byte 1 105
byte 1 110
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $311
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $299
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $298
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $296
byte 1 46
byte 1 46
byte 1 0
align 1
LABELV $295
byte 1 46
byte 1 0
align 1
LABELV $285
byte 1 47
byte 1 0
align 1
LABELV $284
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $281
byte 1 99
byte 1 111
byte 1 109
byte 1 95
byte 1 98
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 0
align 1
LABELV $277
byte 1 76
byte 1 79
byte 1 87
byte 1 32
byte 1 77
byte 1 69
byte 1 77
byte 1 79
byte 1 82
byte 1 89
byte 1 0
align 1
LABELV $254
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 95
byte 1 0
align 1
LABELV $253
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 0
align 1
LABELV $105
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 103
byte 1 115
byte 1 95
byte 1 97
byte 1 114
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 95
byte 1 114
byte 1 0
align 1
LABELV $104
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 103
byte 1 115
byte 1 95
byte 1 97
byte 1 114
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 95
byte 1 108
byte 1 0
align 1
LABELV $103
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 103
byte 1 115
byte 1 95
byte 1 97
byte 1 114
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 95
byte 1 48
byte 1 0
align 1
LABELV $102
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 95
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 95
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $101
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 102
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 49
byte 1 95
byte 1 114
byte 1 0
align 1
LABELV $100
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 102
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 49
byte 1 95
byte 1 108
byte 1 0
align 1
LABELV $99
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 111
byte 1 112
byte 1 112
byte 1 111
byte 1 110
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 95
byte 1 115
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $98
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 111
byte 1 112
byte 1 112
byte 1 111
byte 1 110
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 95
byte 1 115
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $97
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 95
byte 1 49
byte 1 0
align 1
LABELV $96
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 95
byte 1 48
byte 1 0
