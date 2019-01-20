code
proc Demos_MenuEvent 12 8
file "..\..\..\..\code\q3_ui\ui_demo2.c"
line 66
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:/*
;4:=======================================================================
;5:
;6:DEMOS MENU
;7:
;8:=======================================================================
;9:*/
;10:
;11:
;12:#include "ui_local.h"
;13:
;14:
;15:#define ART_BACK0			"menu/art/back_0"
;16:#define ART_BACK1			"menu/art/back_1"	
;17:#define ART_GO0				"menu/art/play_0"
;18:#define ART_GO1				"menu/art/play_1"
;19:#define ART_FRAMEL			"menu/art/frame2_l"
;20:#define ART_FRAMER			"menu/art/frame1_r"
;21:#define ART_ARROWS			"menu/art/arrows_horz_0"
;22:#define ART_ARROWLEFT		"menu/art/arrows_horz_left"
;23:#define ART_ARROWRIGHT		"menu/art/arrows_horz_right"
;24:
;25:#define MAX_DEMOS			128
;26:#define NAMEBUFSIZE			( MAX_DEMOS * 16 )
;27:
;28:#define ID_BACK				10
;29:#define ID_GO				11
;30:#define ID_LIST				12
;31:#define ID_RIGHT			13
;32:#define ID_LEFT				14
;33:
;34:#define ARROWS_WIDTH		128
;35:#define ARROWS_HEIGHT		48
;36:
;37:
;38:typedef struct {
;39:	menuframework_s	menu;
;40:
;41:	menutext_s		banner;
;42:	menubitmap_s	framel;
;43:	menubitmap_s	framer;
;44:
;45:	menulist_s		list;
;46:
;47:	menubitmap_s	arrows;
;48:	menubitmap_s	left;
;49:	menubitmap_s	right;
;50:	menubitmap_s	back;
;51:	menubitmap_s	go;
;52:
;53:	int				numDemos;
;54:	char			names[NAMEBUFSIZE];
;55:	char			*demolist[MAX_DEMOS];
;56:} demos_t;
;57:
;58:static demos_t	s_demos;
;59:
;60:
;61:/*
;62:===============
;63:Demos_MenuEvent
;64:===============
;65:*/
;66:static void Demos_MenuEvent( void *ptr, int event ) {
line 67
;67:	if( event != QM_ACTIVATED ) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $98
line 68
;68:		return;
ADDRGP4 $97
JUMPV
LABELV $98
line 71
;69:	}
;70:
;71:	switch( ((menucommon_s*)ptr)->id ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 10
LTI4 $100
ADDRLP4 0
INDIRI4
CNSTI4 14
GTI4 $100
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $114-40
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $114
address $109
address $103
address $100
address $112
address $110
code
LABELV $103
line 73
;72:	case ID_GO:
;73:		UI_ForceMenuOff ();
ADDRGP4 UI_ForceMenuOff
CALLV
pop
line 74
;74:		trap_Cmd_ExecuteText( EXEC_APPEND, va( "demo %s\n", s_demos.list.itemnames[s_demos.list.curvalue]) );
ADDRGP4 $104
ARGP4
ADDRGP4 s_demos+672+64
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 s_demos+672+76
INDIRP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 75
;75:		break;
ADDRGP4 $101
JUMPV
LABELV $109
line 78
;76:
;77:	case ID_BACK:
;78:		UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 79
;79:		break;
ADDRGP4 $101
JUMPV
LABELV $110
line 82
;80:
;81:	case ID_LEFT:
;82:		ScrollList_Key( &s_demos.list, K_LEFTARROW );
ADDRGP4 s_demos+672
ARGP4
CNSTI4 134
ARGI4
ADDRGP4 ScrollList_Key
CALLI4
pop
line 83
;83:		break;
ADDRGP4 $101
JUMPV
LABELV $112
line 86
;84:
;85:	case ID_RIGHT:
;86:		ScrollList_Key( &s_demos.list, K_RIGHTARROW );
ADDRGP4 s_demos+672
ARGP4
CNSTI4 135
ARGI4
ADDRGP4 ScrollList_Key
CALLI4
pop
line 87
;87:		break;
LABELV $100
LABELV $101
line 89
;88:	}
;89:}
LABELV $97
endproc Demos_MenuEvent 12 8
proc UI_DemosMenu_Key 12 8
line 97
;90:
;91:
;92:/*
;93:=================
;94:UI_DemosMenu_Key
;95:=================
;96:*/
;97:static sfxHandle_t UI_DemosMenu_Key( int key ) {
line 100
;98:	menucommon_s	*item;
;99:
;100:	item = Menu_ItemAtCursor( &s_demos.menu );
ADDRGP4 s_demos
ARGP4
ADDRLP4 4
ADDRGP4 Menu_ItemAtCursor
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 102
;101:
;102:	return Menu_DefaultKey( &s_demos.menu, key );
ADDRGP4 s_demos
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 Menu_DefaultKey
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
LABELV $116
endproc UI_DemosMenu_Key 12 8
proc Demos_MenuInit 60 16
line 111
;103:}
;104:
;105:
;106:/*
;107:===============
;108:Demos_MenuInit
;109:===============
;110:*/
;111:static void Demos_MenuInit( void ) {
line 116
;112:	int		i;
;113:	int		len;
;114:	char	*demoname, extension[32];
;115:
;116:	memset( &s_demos, 0 ,sizeof(demos_t) );
ADDRGP4 s_demos
ARGP4
CNSTI4 0
ARGI4
CNSTI4 3772
ARGI4
ADDRGP4 memset
CALLP4
pop
line 117
;117:	s_demos.menu.key = UI_DemosMenu_Key;
ADDRGP4 s_demos+400
ADDRGP4 UI_DemosMenu_Key
ASGNP4
line 119
;118:
;119:	Demos_Cache();
ADDRGP4 Demos_Cache
CALLV
pop
line 121
;120:
;121:	s_demos.menu.fullscreen = qtrue;
ADDRGP4 s_demos+408
CNSTI4 1
ASGNI4
line 122
;122:	s_demos.menu.wrapAround = qtrue;
ADDRGP4 s_demos+404
CNSTI4 1
ASGNI4
line 124
;123:
;124:	s_demos.banner.generic.type		= MTYPE_BTEXT;
ADDRGP4 s_demos+424
CNSTI4 10
ASGNI4
line 125
;125:	s_demos.banner.generic.x		= 320;
ADDRGP4 s_demos+424+12
CNSTI4 320
ASGNI4
line 126
;126:	s_demos.banner.generic.y		= 16;
ADDRGP4 s_demos+424+16
CNSTI4 16
ASGNI4
line 127
;127:	s_demos.banner.string			= "DEMOS";
ADDRGP4 s_demos+424+60
ADDRGP4 $128
ASGNP4
line 128
;128:	s_demos.banner.color			= color_white;
ADDRGP4 s_demos+424+68
ADDRGP4 color_white
ASGNP4
line 129
;129:	s_demos.banner.style			= UI_CENTER;
ADDRGP4 s_demos+424+64
CNSTI4 1
ASGNI4
line 131
;130:
;131:	s_demos.framel.generic.type		= MTYPE_BITMAP;
ADDRGP4 s_demos+496
CNSTI4 6
ASGNI4
line 132
;132:	s_demos.framel.generic.name		= ART_FRAMEL;
ADDRGP4 s_demos+496+4
ADDRGP4 $136
ASGNP4
line 133
;133:	s_demos.framel.generic.flags	= QMF_INACTIVE;
ADDRGP4 s_demos+496+44
CNSTU4 16384
ASGNU4
line 134
;134:	s_demos.framel.generic.x		= 0;  
ADDRGP4 s_demos+496+12
CNSTI4 0
ASGNI4
line 135
;135:	s_demos.framel.generic.y		= 78;
ADDRGP4 s_demos+496+16
CNSTI4 78
ASGNI4
line 136
;136:	s_demos.framel.width			= 256;
ADDRGP4 s_demos+496+76
CNSTI4 256
ASGNI4
line 137
;137:	s_demos.framel.height			= 329;
ADDRGP4 s_demos+496+80
CNSTI4 329
ASGNI4
line 139
;138:
;139:	s_demos.framer.generic.type		= MTYPE_BITMAP;
ADDRGP4 s_demos+584
CNSTI4 6
ASGNI4
line 140
;140:	s_demos.framer.generic.name		= ART_FRAMER;
ADDRGP4 s_demos+584+4
ADDRGP4 $150
ASGNP4
line 141
;141:	s_demos.framer.generic.flags	= QMF_INACTIVE;
ADDRGP4 s_demos+584+44
CNSTU4 16384
ASGNU4
line 142
;142:	s_demos.framer.generic.x		= 376;
ADDRGP4 s_demos+584+12
CNSTI4 376
ASGNI4
line 143
;143:	s_demos.framer.generic.y		= 76;
ADDRGP4 s_demos+584+16
CNSTI4 76
ASGNI4
line 144
;144:	s_demos.framer.width			= 256;
ADDRGP4 s_demos+584+76
CNSTI4 256
ASGNI4
line 145
;145:	s_demos.framer.height			= 334;
ADDRGP4 s_demos+584+80
CNSTI4 334
ASGNI4
line 147
;146:
;147:	s_demos.arrows.generic.type		= MTYPE_BITMAP;
ADDRGP4 s_demos+768
CNSTI4 6
ASGNI4
line 148
;148:	s_demos.arrows.generic.name		= ART_ARROWS;
ADDRGP4 s_demos+768+4
ADDRGP4 $164
ASGNP4
line 149
;149:	s_demos.arrows.generic.flags	= QMF_INACTIVE;
ADDRGP4 s_demos+768+44
CNSTU4 16384
ASGNU4
line 150
;150:	s_demos.arrows.generic.x		= 320-ARROWS_WIDTH/2;
ADDRGP4 s_demos+768+12
CNSTI4 256
ASGNI4
line 151
;151:	s_demos.arrows.generic.y		= 400;
ADDRGP4 s_demos+768+16
CNSTI4 400
ASGNI4
line 152
;152:	s_demos.arrows.width			= ARROWS_WIDTH;
ADDRGP4 s_demos+768+76
CNSTI4 128
ASGNI4
line 153
;153:	s_demos.arrows.height			= ARROWS_HEIGHT;
ADDRGP4 s_demos+768+80
CNSTI4 48
ASGNI4
line 155
;154:
;155:	s_demos.left.generic.type		= MTYPE_BITMAP;
ADDRGP4 s_demos+856
CNSTI4 6
ASGNI4
line 156
;156:	s_demos.left.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_MOUSEONLY;
ADDRGP4 s_demos+856+44
CNSTU4 2308
ASGNU4
line 157
;157:	s_demos.left.generic.x			= 320-ARROWS_WIDTH/2;
ADDRGP4 s_demos+856+12
CNSTI4 256
ASGNI4
line 158
;158:	s_demos.left.generic.y			= 400;
ADDRGP4 s_demos+856+16
CNSTI4 400
ASGNI4
line 159
;159:	s_demos.left.generic.id			= ID_LEFT;
ADDRGP4 s_demos+856+8
CNSTI4 14
ASGNI4
line 160
;160:	s_demos.left.generic.callback	= Demos_MenuEvent;
ADDRGP4 s_demos+856+48
ADDRGP4 Demos_MenuEvent
ASGNP4
line 161
;161:	s_demos.left.width				= ARROWS_WIDTH/2;
ADDRGP4 s_demos+856+76
CNSTI4 64
ASGNI4
line 162
;162:	s_demos.left.height				= ARROWS_HEIGHT;
ADDRGP4 s_demos+856+80
CNSTI4 48
ASGNI4
line 163
;163:	s_demos.left.focuspic			= ART_ARROWLEFT;
ADDRGP4 s_demos+856+60
ADDRGP4 $192
ASGNP4
line 165
;164:
;165:	s_demos.right.generic.type		= MTYPE_BITMAP;
ADDRGP4 s_demos+944
CNSTI4 6
ASGNI4
line 166
;166:	s_demos.right.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_MOUSEONLY;
ADDRGP4 s_demos+944+44
CNSTU4 2308
ASGNU4
line 167
;167:	s_demos.right.generic.x			= 320;
ADDRGP4 s_demos+944+12
CNSTI4 320
ASGNI4
line 168
;168:	s_demos.right.generic.y			= 400;
ADDRGP4 s_demos+944+16
CNSTI4 400
ASGNI4
line 169
;169:	s_demos.right.generic.id		= ID_RIGHT;
ADDRGP4 s_demos+944+8
CNSTI4 13
ASGNI4
line 170
;170:	s_demos.right.generic.callback	= Demos_MenuEvent;
ADDRGP4 s_demos+944+48
ADDRGP4 Demos_MenuEvent
ASGNP4
line 171
;171:	s_demos.right.width				= ARROWS_WIDTH/2;
ADDRGP4 s_demos+944+76
CNSTI4 64
ASGNI4
line 172
;172:	s_demos.right.height			= ARROWS_HEIGHT;
ADDRGP4 s_demos+944+80
CNSTI4 48
ASGNI4
line 173
;173:	s_demos.right.focuspic			= ART_ARROWRIGHT;
ADDRGP4 s_demos+944+60
ADDRGP4 $210
ASGNP4
line 175
;174:
;175:	s_demos.back.generic.type		= MTYPE_BITMAP;
ADDRGP4 s_demos+1032
CNSTI4 6
ASGNI4
line 176
;176:	s_demos.back.generic.name		= ART_BACK0;
ADDRGP4 s_demos+1032+4
ADDRGP4 $214
ASGNP4
line 177
;177:	s_demos.back.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_demos+1032+44
CNSTU4 260
ASGNU4
line 178
;178:	s_demos.back.generic.id			= ID_BACK;
ADDRGP4 s_demos+1032+8
CNSTI4 10
ASGNI4
line 179
;179:	s_demos.back.generic.callback	= Demos_MenuEvent;
ADDRGP4 s_demos+1032+48
ADDRGP4 Demos_MenuEvent
ASGNP4
line 180
;180:	s_demos.back.generic.x			= 0;
ADDRGP4 s_demos+1032+12
CNSTI4 0
ASGNI4
line 181
;181:	s_demos.back.generic.y			= 480-64;
ADDRGP4 s_demos+1032+16
CNSTI4 416
ASGNI4
line 182
;182:	s_demos.back.width				= 128;
ADDRGP4 s_demos+1032+76
CNSTI4 128
ASGNI4
line 183
;183:	s_demos.back.height				= 64;
ADDRGP4 s_demos+1032+80
CNSTI4 64
ASGNI4
line 184
;184:	s_demos.back.focuspic			= ART_BACK1;
ADDRGP4 s_demos+1032+60
ADDRGP4 $231
ASGNP4
line 186
;185:
;186:	s_demos.go.generic.type			= MTYPE_BITMAP;
ADDRGP4 s_demos+1120
CNSTI4 6
ASGNI4
line 187
;187:	s_demos.go.generic.name			= ART_GO0;
ADDRGP4 s_demos+1120+4
ADDRGP4 $235
ASGNP4
line 188
;188:	s_demos.go.generic.flags		= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_demos+1120+44
CNSTU4 272
ASGNU4
line 189
;189:	s_demos.go.generic.id			= ID_GO;
ADDRGP4 s_demos+1120+8
CNSTI4 11
ASGNI4
line 190
;190:	s_demos.go.generic.callback		= Demos_MenuEvent;
ADDRGP4 s_demos+1120+48
ADDRGP4 Demos_MenuEvent
ASGNP4
line 191
;191:	s_demos.go.generic.x			= 640;
ADDRGP4 s_demos+1120+12
CNSTI4 640
ASGNI4
line 192
;192:	s_demos.go.generic.y			= 480-64;
ADDRGP4 s_demos+1120+16
CNSTI4 416
ASGNI4
line 193
;193:	s_demos.go.width				= 128;
ADDRGP4 s_demos+1120+76
CNSTI4 128
ASGNI4
line 194
;194:	s_demos.go.height				= 64;
ADDRGP4 s_demos+1120+80
CNSTI4 64
ASGNI4
line 195
;195:	s_demos.go.focuspic				= ART_GO1;
ADDRGP4 s_demos+1120+60
ADDRGP4 $252
ASGNP4
line 197
;196:
;197:	s_demos.list.generic.type		= MTYPE_SCROLLLIST;
ADDRGP4 s_demos+672
CNSTI4 8
ASGNI4
line 198
;198:	s_demos.list.generic.flags		= QMF_PULSEIFFOCUS;
ADDRGP4 s_demos+672+44
CNSTU4 256
ASGNU4
line 199
;199:	s_demos.list.generic.callback	= Demos_MenuEvent;
ADDRGP4 s_demos+672+48
ADDRGP4 Demos_MenuEvent
ASGNP4
line 200
;200:	s_demos.list.generic.id			= ID_LIST;
ADDRGP4 s_demos+672+8
CNSTI4 12
ASGNI4
line 201
;201:	s_demos.list.generic.x			= 118;
ADDRGP4 s_demos+672+12
CNSTI4 118
ASGNI4
line 202
;202:	s_demos.list.generic.y			= 130;
ADDRGP4 s_demos+672+16
CNSTI4 130
ASGNI4
line 203
;203:	s_demos.list.width				= 16;
ADDRGP4 s_demos+672+80
CNSTI4 16
ASGNI4
line 204
;204:	s_demos.list.height				= 14;
ADDRGP4 s_demos+672+84
CNSTI4 14
ASGNI4
line 205
;205:	Com_sprintf(extension, sizeof(extension), "dm_%d", (int)trap_Cvar_VariableValue( "protocol" ) );
ADDRGP4 $269
ARGP4
ADDRLP4 44
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 12
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $268
ARGP4
ADDRLP4 44
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 206
;206:	s_demos.list.numitems			= trap_FS_GetFileList( "demos", extension, s_demos.names, NAMEBUFSIZE );
ADDRGP4 $272
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 s_demos+1212
ARGP4
CNSTI4 2048
ARGI4
ADDRLP4 48
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRGP4 s_demos+672+68
ADDRLP4 48
INDIRI4
ASGNI4
line 207
;207:	s_demos.list.itemnames			= (const char **)s_demos.demolist;
ADDRGP4 s_demos+672+76
ADDRGP4 s_demos+3260
ASGNP4
line 208
;208:	s_demos.list.columns			= 3;
ADDRGP4 s_demos+672+88
CNSTI4 3
ASGNI4
line 210
;209:
;210:	if (!s_demos.list.numitems) {
ADDRGP4 s_demos+672+68
INDIRI4
CNSTI4 0
NEI4 $279
line 211
;211:		strcpy( s_demos.names, "No Demos Found." );
ADDRGP4 s_demos+1212
ARGP4
ADDRGP4 $284
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 212
;212:		s_demos.list.numitems = 1;
ADDRGP4 s_demos+672+68
CNSTI4 1
ASGNI4
line 215
;213:
;214:		//degenerate case, not selectable
;215:		s_demos.go.generic.flags |= (QMF_INACTIVE|QMF_HIDDEN);
ADDRLP4 52
ADDRGP4 s_demos+1120+44
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRU4
CNSTU4 20480
BORU4
ASGNU4
line 216
;216:	}
ADDRGP4 $280
JUMPV
LABELV $279
line 217
;217:	else if (s_demos.list.numitems > MAX_DEMOS)
ADDRGP4 s_demos+672+68
INDIRI4
CNSTI4 128
LEI4 $289
line 218
;218:		s_demos.list.numitems = MAX_DEMOS;
ADDRGP4 s_demos+672+68
CNSTI4 128
ASGNI4
LABELV $289
LABELV $280
line 220
;219:
;220:	demoname = s_demos.names;
ADDRLP4 0
ADDRGP4 s_demos+1212
ASGNP4
line 221
;221:	for ( i = 0; i < s_demos.list.numitems; i++ ) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $299
JUMPV
LABELV $296
line 222
;222:		s_demos.list.itemnames[i] = demoname;
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 s_demos+672+76
INDIRP4
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 225
;223:		
;224:		// strip extension
;225:		len = strlen( demoname );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 52
INDIRI4
ASGNI4
line 226
;226:		if (!Q_stricmp(demoname +  len - 4,".dm3"))
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
ADDP4
CNSTI4 -4
ADDP4
ARGP4
ADDRGP4 $306
ARGP4
ADDRLP4 56
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
NEI4 $304
line 227
;227:			demoname[len-4] = '\0';
ADDRLP4 4
INDIRI4
CNSTI4 4
SUBI4
ADDRLP4 0
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
LABELV $304
line 229
;228:
;229:		Q_strupr(demoname);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 231
;230:
;231:		demoname += len + 1;
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 0
INDIRP4
ADDP4
ASGNP4
line 232
;232:	}
LABELV $297
line 221
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $299
ADDRLP4 8
INDIRI4
ADDRGP4 s_demos+672+68
INDIRI4
LTI4 $296
line 234
;233:
;234:	Menu_AddItem( &s_demos.menu, &s_demos.banner );
ADDRGP4 s_demos
ARGP4
ADDRGP4 s_demos+424
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 235
;235:	Menu_AddItem( &s_demos.menu, &s_demos.framel );
ADDRGP4 s_demos
ARGP4
ADDRGP4 s_demos+496
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 236
;236:	Menu_AddItem( &s_demos.menu, &s_demos.framer );
ADDRGP4 s_demos
ARGP4
ADDRGP4 s_demos+584
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 237
;237:	Menu_AddItem( &s_demos.menu, &s_demos.list );
ADDRGP4 s_demos
ARGP4
ADDRGP4 s_demos+672
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 238
;238:	Menu_AddItem( &s_demos.menu, &s_demos.arrows );
ADDRGP4 s_demos
ARGP4
ADDRGP4 s_demos+768
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 239
;239:	Menu_AddItem( &s_demos.menu, &s_demos.left );
ADDRGP4 s_demos
ARGP4
ADDRGP4 s_demos+856
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 240
;240:	Menu_AddItem( &s_demos.menu, &s_demos.right );
ADDRGP4 s_demos
ARGP4
ADDRGP4 s_demos+944
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 241
;241:	Menu_AddItem( &s_demos.menu, &s_demos.back );
ADDRGP4 s_demos
ARGP4
ADDRGP4 s_demos+1032
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 242
;242:	Menu_AddItem( &s_demos.menu, &s_demos.go );
ADDRGP4 s_demos
ARGP4
ADDRGP4 s_demos+1120
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 243
;243:}
LABELV $117
endproc Demos_MenuInit 60 16
export Demos_Cache
proc Demos_Cache 0 4
line 250
;244:
;245:/*
;246:=================
;247:Demos_Cache
;248:=================
;249:*/
;250:void Demos_Cache( void ) {
line 251
;251:	trap_R_RegisterShaderNoMip( ART_BACK0 );
ADDRGP4 $214
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 252
;252:	trap_R_RegisterShaderNoMip( ART_BACK1 );
ADDRGP4 $231
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 253
;253:	trap_R_RegisterShaderNoMip( ART_GO0 );
ADDRGP4 $235
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 254
;254:	trap_R_RegisterShaderNoMip( ART_GO1 );
ADDRGP4 $252
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 255
;255:	trap_R_RegisterShaderNoMip( ART_FRAMEL );
ADDRGP4 $136
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 256
;256:	trap_R_RegisterShaderNoMip( ART_FRAMER );
ADDRGP4 $150
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 257
;257:	trap_R_RegisterShaderNoMip( ART_ARROWS );
ADDRGP4 $164
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 258
;258:	trap_R_RegisterShaderNoMip( ART_ARROWLEFT );
ADDRGP4 $192
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 259
;259:	trap_R_RegisterShaderNoMip( ART_ARROWRIGHT );
ADDRGP4 $210
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 260
;260:}
LABELV $316
endproc Demos_Cache 0 4
export UI_DemosMenu
proc UI_DemosMenu 0 4
line 267
;261:
;262:/*
;263:===============
;264:UI_DemosMenu
;265:===============
;266:*/
;267:void UI_DemosMenu( void ) {
line 268
;268:	Demos_MenuInit();
ADDRGP4 Demos_MenuInit
CALLV
pop
line 269
;269:	UI_PushMenu( &s_demos.menu );
ADDRGP4 s_demos
ARGP4
ADDRGP4 UI_PushMenu
CALLV
pop
line 270
;270:}
LABELV $317
endproc UI_DemosMenu 0 4
bss
align 4
LABELV s_demos
skip 3772
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
import PlayerModel_Cache
import UI_PlayerModelMenu
import UI_CDKeyMenu_f
import UI_CDKeyMenu_Cache
import UI_CDKeyMenu
import UI_ModsMenu_Cache
import UI_ModsMenu
import UI_CinematicsMenu_Cache
import UI_CinematicsMenu_f
import UI_CinematicsMenu
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
LABELV $306
byte 1 46
byte 1 100
byte 1 109
byte 1 51
byte 1 0
align 1
LABELV $284
byte 1 78
byte 1 111
byte 1 32
byte 1 68
byte 1 101
byte 1 109
byte 1 111
byte 1 115
byte 1 32
byte 1 70
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 46
byte 1 0
align 1
LABELV $272
byte 1 100
byte 1 101
byte 1 109
byte 1 111
byte 1 115
byte 1 0
align 1
LABELV $269
byte 1 112
byte 1 114
byte 1 111
byte 1 116
byte 1 111
byte 1 99
byte 1 111
byte 1 108
byte 1 0
align 1
LABELV $268
byte 1 100
byte 1 109
byte 1 95
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $252
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
byte 1 95
byte 1 49
byte 1 0
align 1
LABELV $235
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
byte 1 95
byte 1 48
byte 1 0
align 1
LABELV $231
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
LABELV $214
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
align 1
LABELV $210
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 97
byte 1 114
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 95
byte 1 104
byte 1 111
byte 1 114
byte 1 122
byte 1 95
byte 1 114
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $192
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 97
byte 1 114
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 95
byte 1 104
byte 1 111
byte 1 114
byte 1 122
byte 1 95
byte 1 108
byte 1 101
byte 1 102
byte 1 116
byte 1 0
align 1
LABELV $164
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 97
byte 1 114
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 95
byte 1 104
byte 1 111
byte 1 114
byte 1 122
byte 1 95
byte 1 48
byte 1 0
align 1
LABELV $150
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
LABELV $136
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
byte 1 50
byte 1 95
byte 1 108
byte 1 0
align 1
LABELV $128
byte 1 68
byte 1 69
byte 1 77
byte 1 79
byte 1 83
byte 1 0
align 1
LABELV $104
byte 1 100
byte 1 101
byte 1 109
byte 1 111
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
