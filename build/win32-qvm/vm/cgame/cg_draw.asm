data
export drawTeamOverlayModificationCount
align 4
LABELV drawTeamOverlayModificationCount
byte 4 -1
code
proc CG_DrawField 64 20
file "..\..\..\..\code\cgame\cg_draw.c"
line 192
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_draw.c -- draw all of the graphical elements during
;4:// active (after loading) gameplay
;5:
;6:#include "cg_local.h"
;7:
;8:#ifdef MISSIONPACK
;9:#include "../ui/ui_shared.h"
;10:
;11:// used for scoreboard
;12:extern displayContextDef_t cgDC;
;13:menuDef_t *menuScoreboard = NULL;
;14:#else
;15:int drawTeamOverlayModificationCount = -1;
;16:#endif
;17:
;18:int sortedTeamPlayers[TEAM_MAXOVERLAY];
;19:int	numSortedTeamPlayers;
;20:
;21:char systemChat[256];
;22:char teamChat1[256];
;23:char teamChat2[256];
;24:
;25:#ifdef MISSIONPACK
;26:
;27:int CG_Text_Width(const char *text, float scale, int limit) {
;28:  int count,len;
;29:	float out;
;30:	glyphInfo_t *glyph;
;31:	float useScale;
;32:// FIXME: see ui_main.c, same problem
;33://	const unsigned char *s = text;
;34:	const char *s = text;
;35:	fontInfo_t *font = &cgDC.Assets.textFont;
;36:	if (scale <= cg_smallFont.value) {
;37:		font = &cgDC.Assets.smallFont;
;38:	} else if (scale > cg_bigFont.value) {
;39:		font = &cgDC.Assets.bigFont;
;40:	}
;41:	useScale = scale * font->glyphScale;
;42:  out = 0;
;43:  if (text) {
;44:    len = strlen(text);
;45:		if (limit > 0 && len > limit) {
;46:			len = limit;
;47:		}
;48:		count = 0;
;49:		while (s && *s && count < len) {
;50:			if ( Q_IsColorString(s) ) {
;51:				s += 2;
;52:				continue;
;53:			} else {
;54:				glyph = &font->glyphs[(int)*s]; // TTimo: FIXME: getting nasty warnings without the cast, hopefully this doesn't break the VM build
;55:				out += glyph->xSkip;
;56:				s++;
;57:				count++;
;58:			}
;59:    }
;60:  }
;61:  return out * useScale;
;62:}
;63:
;64:int CG_Text_Height(const char *text, float scale, int limit) {
;65:  int len, count;
;66:	float max;
;67:	glyphInfo_t *glyph;
;68:	float useScale;
;69:// TTimo: FIXME
;70://	const unsigned char *s = text;
;71:	const char *s = text;
;72:	fontInfo_t *font = &cgDC.Assets.textFont;
;73:	if (scale <= cg_smallFont.value) {
;74:		font = &cgDC.Assets.smallFont;
;75:	} else if (scale > cg_bigFont.value) {
;76:		font = &cgDC.Assets.bigFont;
;77:	}
;78:	useScale = scale * font->glyphScale;
;79:  max = 0;
;80:  if (text) {
;81:    len = strlen(text);
;82:		if (limit > 0 && len > limit) {
;83:			len = limit;
;84:		}
;85:		count = 0;
;86:		while (s && *s && count < len) {
;87:			if ( Q_IsColorString(s) ) {
;88:				s += 2;
;89:				continue;
;90:			} else {
;91:				glyph = &font->glyphs[(int)*s]; // TTimo: FIXME: getting nasty warnings without the cast, hopefully this doesn't break the VM build
;92:	      if (max < glyph->height) {
;93:		      max = glyph->height;
;94:			  }
;95:				s++;
;96:				count++;
;97:			}
;98:    }
;99:  }
;100:  return max * useScale;
;101:}
;102:
;103:void CG_Text_PaintChar(float x, float y, float width, float height, float scale, float s, float t, float s2, float t2, qhandle_t hShader) {
;104:  float w, h;
;105:  w = width * scale;
;106:  h = height * scale;
;107:  CG_AdjustFrom640( &x, &y, &w, &h );
;108:  trap_R_DrawStretchPic( x, y, w, h, s, t, s2, t2, hShader );
;109:}
;110:
;111:void CG_Text_Paint(float x, float y, float scale, vec4_t color, const char *text, float adjust, int limit, int style) {
;112:  int len, count;
;113:	vec4_t newColor;
;114:	glyphInfo_t *glyph;
;115:	float useScale;
;116:	fontInfo_t *font = &cgDC.Assets.textFont;
;117:	if (scale <= cg_smallFont.value) {
;118:		font = &cgDC.Assets.smallFont;
;119:	} else if (scale > cg_bigFont.value) {
;120:		font = &cgDC.Assets.bigFont;
;121:	}
;122:	useScale = scale * font->glyphScale;
;123:  if (text) {
;124:// TTimo: FIXME
;125://		const unsigned char *s = text;
;126:		const char *s = text;
;127:		trap_R_SetColor( color );
;128:		memcpy(&newColor[0], &color[0], sizeof(vec4_t));
;129:    len = strlen(text);
;130:		if (limit > 0 && len > limit) {
;131:			len = limit;
;132:		}
;133:		count = 0;
;134:		while (s && *s && count < len) {
;135:			glyph = &font->glyphs[(int)*s]; // TTimo: FIXME: getting nasty warnings without the cast, hopefully this doesn't break the VM build
;136:      //int yadj = Assets.textFont.glyphs[text[i]].bottom + Assets.textFont.glyphs[text[i]].top;
;137:      //float yadj = scale * (Assets.textFont.glyphs[text[i]].imageHeight - Assets.textFont.glyphs[text[i]].height);
;138:			if ( Q_IsColorString( s ) ) {
;139:				memcpy( newColor, g_color_table[ColorIndex(*(s+1))], sizeof( newColor ) );
;140:				newColor[3] = color[3];
;141:				trap_R_SetColor( newColor );
;142:				s += 2;
;143:				continue;
;144:			} else {
;145:				float yadj = useScale * glyph->top;
;146:				if (style == ITEM_TEXTSTYLE_SHADOWED || style == ITEM_TEXTSTYLE_SHADOWEDMORE) {
;147:					int ofs = style == ITEM_TEXTSTYLE_SHADOWED ? 1 : 2;
;148:					colorBlack[3] = newColor[3];
;149:					trap_R_SetColor( colorBlack );
;150:					CG_Text_PaintChar(x + ofs, y - yadj + ofs,
;151:														glyph->imageWidth,
;152:														glyph->imageHeight,
;153:														useScale,
;154:														glyph->s,
;155:														glyph->t,
;156:														glyph->s2,
;157:														glyph->t2,
;158:														glyph->glyph);
;159:					colorBlack[3] = 1.0;
;160:					trap_R_SetColor( newColor );
;161:				}
;162:				CG_Text_PaintChar(x, y - yadj,
;163:													glyph->imageWidth,
;164:													glyph->imageHeight,
;165:													useScale,
;166:													glyph->s,
;167:													glyph->t,
;168:													glyph->s2,
;169:													glyph->t2,
;170:													glyph->glyph);
;171:				// CG_DrawPic(x, y - yadj, scale * cgDC.Assets.textFont.glyphs[text[i]].imageWidth, scale * cgDC.Assets.textFont.glyphs[text[i]].imageHeight, cgDC.Assets.textFont.glyphs[text[i]].glyph);
;172:				x += (glyph->xSkip * useScale) + adjust;
;173:				s++;
;174:				count++;
;175:			}
;176:    }
;177:	  trap_R_SetColor( NULL );
;178:  }
;179:}
;180:
;181:
;182:#endif
;183:
;184:/*
;185:==============
;186:CG_DrawField
;187:
;188:Draws large numbers for status bar and powerups
;189:==============
;190:*/
;191:#ifndef MISSIONPACK
;192:static void CG_DrawField (int x, int y, int width, int value) {
line 197
;193:	char	num[16], *ptr;
;194:	int		l;
;195:	int		frame;
;196:
;197:	if ( width < 1 ) {
ADDRFP4 8
INDIRI4
CNSTI4 1
GEI4 $125
line 198
;198:		return;
ADDRGP4 $124
JUMPV
LABELV $125
line 202
;199:	}
;200:
;201:	// draw number string
;202:	if ( width > 5 ) {
ADDRFP4 8
INDIRI4
CNSTI4 5
LEI4 $127
line 203
;203:		width = 5;
ADDRFP4 8
CNSTI4 5
ASGNI4
line 204
;204:	}
LABELV $127
line 206
;205:
;206:	switch ( width ) {
ADDRLP4 28
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 1
LTI4 $129
ADDRLP4 28
INDIRI4
CNSTI4 4
GTI4 $129
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $159-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $159
address $131
address $138
address $145
address $152
code
LABELV $131
line 208
;207:	case 1:
;208:		value = value > 9 ? 9 : value;
ADDRFP4 12
INDIRI4
CNSTI4 9
LEI4 $133
ADDRLP4 32
CNSTI4 9
ASGNI4
ADDRGP4 $134
JUMPV
LABELV $133
ADDRLP4 32
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $134
ADDRFP4 12
ADDRLP4 32
INDIRI4
ASGNI4
line 209
;209:		value = value < 0 ? 0 : value;
ADDRFP4 12
INDIRI4
CNSTI4 0
GEI4 $136
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRGP4 $137
JUMPV
LABELV $136
ADDRLP4 36
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $137
ADDRFP4 12
ADDRLP4 36
INDIRI4
ASGNI4
line 210
;210:		break;
ADDRGP4 $130
JUMPV
LABELV $138
line 212
;211:	case 2:
;212:		value = value > 99 ? 99 : value;
ADDRFP4 12
INDIRI4
CNSTI4 99
LEI4 $140
ADDRLP4 40
CNSTI4 99
ASGNI4
ADDRGP4 $141
JUMPV
LABELV $140
ADDRLP4 40
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $141
ADDRFP4 12
ADDRLP4 40
INDIRI4
ASGNI4
line 213
;213:		value = value < -9 ? -9 : value;
ADDRFP4 12
INDIRI4
CNSTI4 -9
GEI4 $143
ADDRLP4 44
CNSTI4 -9
ASGNI4
ADDRGP4 $144
JUMPV
LABELV $143
ADDRLP4 44
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $144
ADDRFP4 12
ADDRLP4 44
INDIRI4
ASGNI4
line 214
;214:		break;
ADDRGP4 $130
JUMPV
LABELV $145
line 216
;215:	case 3:
;216:		value = value > 999 ? 999 : value;
ADDRFP4 12
INDIRI4
CNSTI4 999
LEI4 $147
ADDRLP4 48
CNSTI4 999
ASGNI4
ADDRGP4 $148
JUMPV
LABELV $147
ADDRLP4 48
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $148
ADDRFP4 12
ADDRLP4 48
INDIRI4
ASGNI4
line 217
;217:		value = value < -99 ? -99 : value;
ADDRFP4 12
INDIRI4
CNSTI4 -99
GEI4 $150
ADDRLP4 52
CNSTI4 -99
ASGNI4
ADDRGP4 $151
JUMPV
LABELV $150
ADDRLP4 52
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $151
ADDRFP4 12
ADDRLP4 52
INDIRI4
ASGNI4
line 218
;218:		break;
ADDRGP4 $130
JUMPV
LABELV $152
line 220
;219:	case 4:
;220:		value = value > 9999 ? 9999 : value;
ADDRFP4 12
INDIRI4
CNSTI4 9999
LEI4 $154
ADDRLP4 56
CNSTI4 9999
ASGNI4
ADDRGP4 $155
JUMPV
LABELV $154
ADDRLP4 56
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $155
ADDRFP4 12
ADDRLP4 56
INDIRI4
ASGNI4
line 221
;221:		value = value < -999 ? -999 : value;
ADDRFP4 12
INDIRI4
CNSTI4 -999
GEI4 $157
ADDRLP4 60
CNSTI4 -999
ASGNI4
ADDRGP4 $158
JUMPV
LABELV $157
ADDRLP4 60
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $158
ADDRFP4 12
ADDRLP4 60
INDIRI4
ASGNI4
line 222
;222:		break;
LABELV $129
LABELV $130
line 225
;223:	}
;224:
;225:	Com_sprintf (num, sizeof(num), "%i", value);
ADDRLP4 12
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $161
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 226
;226:	l = strlen(num);
ADDRLP4 12
ARGP4
ADDRLP4 32
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 32
INDIRI4
ASGNI4
line 227
;227:	if (l > width)
ADDRLP4 4
INDIRI4
ADDRFP4 8
INDIRI4
LEI4 $162
line 228
;228:		l = width;
ADDRLP4 4
ADDRFP4 8
INDIRI4
ASGNI4
LABELV $162
line 229
;229:	x += 2 + CHAR_WIDTH*(width - l);
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRFP4 8
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 5
LSHI4
CNSTI4 2
ADDI4
ADDI4
ASGNI4
line 231
;230:
;231:	ptr = num;
ADDRLP4 0
ADDRLP4 12
ASGNP4
ADDRGP4 $165
JUMPV
LABELV $164
line 233
;232:	while (*ptr && l)
;233:	{
line 234
;234:		if (*ptr == '-')
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 45
NEI4 $167
line 235
;235:			frame = STAT_MINUS;
ADDRLP4 8
CNSTI4 10
ASGNI4
ADDRGP4 $168
JUMPV
LABELV $167
line 237
;236:		else
;237:			frame = *ptr -'0';
ADDRLP4 8
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 48
SUBI4
ASGNI4
LABELV $168
line 239
;238:
;239:		CG_DrawPic( x,y, CHAR_WIDTH, CHAR_HEIGHT, cgs.media.numberShaders[frame] );
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1107296256
ARGF4
CNSTF4 1111490560
ARGF4
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+751220+508
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 240
;240:		x += CHAR_WIDTH;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 32
ADDI4
ASGNI4
line 241
;241:		ptr++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 242
;242:		l--;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 243
;243:	}
LABELV $165
line 232
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $171
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $164
LABELV $171
line 244
;244:}
LABELV $124
endproc CG_DrawField 64 20
export CG_Draw3DModel
proc CG_Draw3DModel 508 16
line 257
;245:#endif
;246:
;247:/*
;248:================
;249:CG_Draw3DModel
;250:
;251:================
;252:*/
;253:// JUHOX: new parameter 'shader' for CG_Draw3DModel()
;254:#if 0
;255:void CG_Draw3DModel( float x, float y, float w, float h, qhandle_t model, qhandle_t skin, vec3_t origin, vec3_t angles ) {
;256:#else
;257:void CG_Draw3DModel(float x, float y, float w, float h, qhandle_t model, qhandle_t skin, vec3_t origin, vec3_t angles, qhandle_t shader) {
line 262
;258:#endif
;259:	refdef_t		refdef;
;260:	refEntity_t		ent;
;261:
;262:	if ( !cg_draw3dIcons.integer || !cg_drawIcons.integer ) {
ADDRGP4 cg_draw3dIcons+12
INDIRI4
CNSTI4 0
EQI4 $177
ADDRGP4 cg_drawIcons+12
INDIRI4
CNSTI4 0
NEI4 $173
LABELV $177
line 263
;263:		return;
ADDRGP4 $172
JUMPV
LABELV $173
line 266
;264:	}
;265:
;266:	CG_AdjustFrom640( &x, &y, &w, &h );
ADDRFP4 0
ARGP4
ADDRFP4 4
ARGP4
ADDRFP4 8
ARGP4
ADDRFP4 12
ARGP4
ADDRGP4 CG_AdjustFrom640
CALLV
pop
line 268
;267:
;268:	memset( &refdef, 0, sizeof( refdef ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 368
ARGI4
ADDRGP4 memset
CALLP4
pop
line 270
;269:
;270:	memset( &ent, 0, sizeof( ent ) );
ADDRLP4 368
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 271
;271:	AnglesToAxis( angles, ent.axis );
ADDRFP4 28
INDIRP4
ARGP4
ADDRLP4 368+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 272
;272:	VectorCopy( origin, ent.origin );
ADDRLP4 368+68
ADDRFP4 24
INDIRP4
INDIRB
ASGNB 12
line 273
;273:	ent.hModel = model;
ADDRLP4 368+8
ADDRFP4 16
INDIRI4
ASGNI4
line 274
;274:	ent.customSkin = skin;
ADDRLP4 368+108
ADDRFP4 20
INDIRI4
ASGNI4
line 277
;275:	// JUHOX: set shader
;276:#if 1
;277:	ent.customShader = shader;
ADDRLP4 368+112
ADDRFP4 32
INDIRI4
ASGNI4
line 279
;278:#endif
;279:	ent.renderfx = RF_NOSHADOW;		// no stencil shadows
ADDRLP4 368+4
CNSTI4 64
ASGNI4
line 281
;280:
;281:	refdef.rdflags = RDF_NOWORLDMODEL;
ADDRLP4 0+76
CNSTI4 1
ASGNI4
line 283
;282:
;283:	AxisClear( refdef.viewaxis );
ADDRLP4 0+36
ARGP4
ADDRGP4 AxisClear
CALLV
pop
line 285
;284:
;285:	refdef.fov_x = 30;
ADDRLP4 0+16
CNSTF4 1106247680
ASGNF4
line 286
;286:	refdef.fov_y = 30;
ADDRLP4 0+20
CNSTF4 1106247680
ASGNF4
line 288
;287:
;288:	refdef.x = x;
ADDRLP4 0
ADDRFP4 0
INDIRF4
CVFI4 4
ASGNI4
line 289
;289:	refdef.y = y;
ADDRLP4 0+4
ADDRFP4 4
INDIRF4
CVFI4 4
ASGNI4
line 290
;290:	refdef.width = w;
ADDRLP4 0+8
ADDRFP4 8
INDIRF4
CVFI4 4
ASGNI4
line 291
;291:	refdef.height = h;
ADDRLP4 0+12
ADDRFP4 12
INDIRF4
CVFI4 4
ASGNI4
line 293
;292:
;293:	refdef.time = cg.time;
ADDRLP4 0+72
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 295
;294:
;295:	trap_R_ClearScene();
ADDRGP4 trap_R_ClearScene
CALLV
pop
line 296
;296:	trap_R_AddRefEntityToScene( &ent );
ADDRLP4 368
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 297
;297:	trap_R_RenderScene( &refdef );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_RenderScene
CALLV
pop
line 298
;298:}
LABELV $172
endproc CG_Draw3DModel 508 16
export CG_DrawHead
proc CG_DrawHead 56 36
line 307
;299:
;300:/*
;301:================
;302:CG_DrawHead
;303:
;304:Used for both the status bar and the scoreboard
;305:================
;306:*/
;307:void CG_DrawHead( float x, float y, float w, float h, int clientNum, vec3_t headAngles ) {
line 314
;308:	clipHandle_t	cm;
;309:	clientInfo_t	*ci;
;310:	float			len;
;311:	vec3_t			origin;
;312:	vec3_t			mins, maxs;
;313:
;314:	ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 0
ADDRFP4 16
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320
ADDP4
ASGNP4
line 316
;315:
;316:	if ( cg_draw3dIcons.integer ) {
ADDRGP4 cg_draw3dIcons+12
INDIRI4
CNSTI4 0
EQI4 $195
line 317
;317:		cm = ci->headModel;
ADDRLP4 40
ADDRLP4 0
INDIRP4
CNSTI4 552
ADDP4
INDIRI4
ASGNI4
line 318
;318:		if ( !cm ) {
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $198
line 319
;319:			return;
ADDRGP4 $193
JUMPV
LABELV $198
line 323
;320:		}
;321:
;322:		// offset the origin y and z to center the head
;323:		trap_R_ModelBounds( cm, mins, maxs );
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRLP4 28
ARGP4
ADDRGP4 trap_R_ModelBounds
CALLV
pop
line 325
;324:
;325:		origin[2] = -0.5 * ( mins[2] + maxs[2] );
ADDRLP4 4+8
ADDRLP4 16+8
INDIRF4
ADDRLP4 28+8
INDIRF4
ADDF4
CNSTF4 3204448256
MULF4
ASGNF4
line 326
;326:		origin[1] = 0.5 * ( mins[1] + maxs[1] );
ADDRLP4 4+4
ADDRLP4 16+4
INDIRF4
ADDRLP4 28+4
INDIRF4
ADDF4
CNSTF4 1056964608
MULF4
ASGNF4
line 330
;327:
;328:		// calculate distance so the head nearly fills the box
;329:		// assume heads are taller than wide
;330:		len = 0.7 * ( maxs[2] - mins[2] );
ADDRLP4 44
ADDRLP4 28+8
INDIRF4
ADDRLP4 16+8
INDIRF4
SUBF4
CNSTF4 1060320051
MULF4
ASGNF4
line 331
;331:		origin[0] = len / 0.268;	// len / tan( fov/2 )
ADDRLP4 4
ADDRLP4 44
INDIRF4
CNSTF4 1081003604
MULF4
ASGNF4
line 334
;332:
;333:		// allow per-model tweaking
;334:		VectorAdd( origin, ci->headOffset, origin );
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 4+4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRF4
ADDF4
ASGNF4
line 339
;335:
;336:#if 0	// JUHOX: new parameter for CG_Draw3DModel()
;337:		CG_Draw3DModel( x, y, w, h, ci->headModel, ci->headSkin, origin, headAngles );
;338:#else
;339:		CG_Draw3DModel(x, y, w, h, ci->headModel, ci->headSkin, origin, headAngles, 0);
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 552
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 CG_Draw3DModel
CALLV
pop
line 341
;340:#endif
;341:	} else if ( cg_drawIcons.integer ) {
ADDRGP4 $196
JUMPV
LABELV $195
ADDRGP4 cg_drawIcons+12
INDIRI4
CNSTI4 0
EQI4 $212
line 342
;342:		CG_DrawPic( x, y, w, h, ci->modelIcon );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 343
;343:	}
LABELV $212
LABELV $196
line 346
;344:
;345:	// if they are deferred, draw a cross out
;346:	if ( ci->deferred ) {
ADDRLP4 0
INDIRP4
CNSTI4 500
ADDP4
INDIRI4
CNSTI4 0
EQI4 $215
line 347
;347:		CG_DrawPic( x, y, w, h, cgs.media.deferShader );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 cgs+751220+184
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 348
;348:	}
LABELV $215
line 349
;349:}
LABELV $193
endproc CG_DrawHead 56 36
export CG_DrawFlagModel
proc CG_DrawFlagModel 68 36
line 358
;350:
;351:/*
;352:================
;353:CG_DrawFlagModel
;354:
;355:Used for both the status bar and the scoreboard
;356:================
;357:*/
;358:void CG_DrawFlagModel( float x, float y, float w, float h, int team, qboolean force2D ) {
line 365
;359:	qhandle_t		cm;
;360:	float			len;
;361:	vec3_t			origin, angles;
;362:	vec3_t			mins, maxs;
;363:	qhandle_t		handle;
;364:
;365:	if ( !force2D && cg_draw3dIcons.integer ) {
ADDRFP4 20
INDIRI4
CNSTI4 0
NEI4 $220
ADDRGP4 cg_draw3dIcons+12
INDIRI4
CNSTI4 0
EQI4 $220
line 367
;366:
;367:		VectorClear( angles );
ADDRLP4 60
CNSTF4 0
ASGNF4
ADDRLP4 0+8
ADDRLP4 60
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 60
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 60
INDIRF4
ASGNF4
line 369
;368:
;369:		cm = cgs.media.redFlagModel;
ADDRLP4 48
ADDRGP4 cgs+751220+88
INDIRI4
ASGNI4
line 372
;370:
;371:		// offset the origin y and z to center the flag
;372:		trap_R_ModelBounds( cm, mins, maxs );
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
ADDRLP4 36
ARGP4
ADDRGP4 trap_R_ModelBounds
CALLV
pop
line 374
;373:
;374:		origin[2] = -0.5 * ( mins[2] + maxs[2] );
ADDRLP4 12+8
ADDRLP4 24+8
INDIRF4
ADDRLP4 36+8
INDIRF4
ADDF4
CNSTF4 3204448256
MULF4
ASGNF4
line 375
;375:		origin[1] = 0.5 * ( mins[1] + maxs[1] );
ADDRLP4 12+4
ADDRLP4 24+4
INDIRF4
ADDRLP4 36+4
INDIRF4
ADDF4
CNSTF4 1056964608
MULF4
ASGNF4
line 379
;376:
;377:		// calculate distance so the flag nearly fills the box
;378:		// assume heads are taller than wide
;379:		len = 0.5 * ( maxs[2] - mins[2] );
ADDRLP4 52
ADDRLP4 36+8
INDIRF4
ADDRLP4 24+8
INDIRF4
SUBF4
CNSTF4 1056964608
MULF4
ASGNF4
line 380
;380:		origin[0] = len / 0.268;	// len / tan( fov/2 )
ADDRLP4 12
ADDRLP4 52
INDIRF4
CNSTF4 1081003604
MULF4
ASGNF4
line 382
;381:
;382:		angles[YAW] = 60 * sin( cg.time / 2000.0 );;
ADDRGP4 cg+107656
INDIRI4
CVIF4 4
CNSTF4 973279855
MULF4
ARGF4
ADDRLP4 64
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 64
INDIRF4
CNSTF4 1114636288
MULF4
ASGNF4
line 384
;383:
;384:		if( team == TEAM_RED ) {
ADDRFP4 16
INDIRI4
CNSTI4 1
NEI4 $237
line 385
;385:			handle = cgs.media.redFlagModel;
ADDRLP4 56
ADDRGP4 cgs+751220+88
INDIRI4
ASGNI4
line 386
;386:		} else if( team == TEAM_BLUE ) {
ADDRGP4 $238
JUMPV
LABELV $237
ADDRFP4 16
INDIRI4
CNSTI4 2
NEI4 $241
line 387
;387:			handle = cgs.media.blueFlagModel;
ADDRLP4 56
ADDRGP4 cgs+751220+92
INDIRI4
ASGNI4
line 388
;388:		} else if( team == TEAM_FREE ) {
ADDRGP4 $242
JUMPV
LABELV $241
ADDRFP4 16
INDIRI4
CNSTI4 0
NEI4 $219
line 389
;389:			handle = cgs.media.neutralFlagModel;
ADDRLP4 56
ADDRGP4 cgs+751220+96
INDIRI4
ASGNI4
line 390
;390:		} else {
line 391
;391:			return;
LABELV $246
LABELV $242
LABELV $238
line 396
;392:		}
;393:#if 0	// JUHOX: new parameter for CG_Draw3DModel()
;394:		CG_Draw3DModel( x, y, w, h, handle, 0, origin, angles );
;395:#else
;396:		CG_Draw3DModel(x, y, w, h, handle, 0, origin, angles, 0);
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 56
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 CG_Draw3DModel
CALLV
pop
line 398
;397:#endif
;398:	} else if ( cg_drawIcons.integer ) {
ADDRGP4 $221
JUMPV
LABELV $220
ADDRGP4 cg_drawIcons+12
INDIRI4
CNSTI4 0
EQI4 $249
line 401
;399:		gitem_t *item;
;400:
;401:		if( team == TEAM_RED ) {
ADDRFP4 16
INDIRI4
CNSTI4 1
NEI4 $252
line 402
;402:			item = BG_FindItemForPowerup( PW_REDFLAG );
CNSTI4 7
ARGI4
ADDRLP4 64
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 60
ADDRLP4 64
INDIRP4
ASGNP4
line 403
;403:		} else if( team == TEAM_BLUE ) {
ADDRGP4 $253
JUMPV
LABELV $252
ADDRFP4 16
INDIRI4
CNSTI4 2
NEI4 $254
line 404
;404:			item = BG_FindItemForPowerup( PW_BLUEFLAG );
CNSTI4 8
ARGI4
ADDRLP4 64
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 60
ADDRLP4 64
INDIRP4
ASGNP4
line 405
;405:		} else if( team == TEAM_FREE ) {
ADDRGP4 $255
JUMPV
LABELV $254
ADDRFP4 16
INDIRI4
CNSTI4 0
NEI4 $219
line 406
;406:			item = BG_FindItemForPowerup( PW_NEUTRALFLAG );
CNSTI4 9
ARGI4
ADDRLP4 64
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 60
ADDRLP4 64
INDIRP4
ASGNP4
line 407
;407:		} else {
line 408
;408:			return;
LABELV $257
LABELV $255
LABELV $253
line 410
;409:		}
;410:		if (item) {
ADDRLP4 60
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $258
line 411
;411:		  CG_DrawPic( x, y, w, h, cg_items[ ITEM_INDEX(item) ].icon );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CVPU4 4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
CNSTI4 24
MULI4
ADDRGP4 cg_items+20
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 412
;412:		}
LABELV $258
line 413
;413:	}
LABELV $249
LABELV $221
line 414
;414:}
LABELV $219
endproc CG_DrawFlagModel 68 36
proc CG_DrawStatusBarHead 52 24
line 424
;415:
;416:/*
;417:================
;418:CG_DrawStatusBarHead
;419:
;420:================
;421:*/
;422:#ifndef MISSIONPACK
;423:
;424:static void CG_DrawStatusBarHead( float x ) {
line 429
;425:	vec3_t		angles;
;426:	float		size, stretch;
;427:	float		frac;
;428:
;429:	VectorClear( angles );
ADDRLP4 24
CNSTF4 0
ASGNF4
ADDRLP4 4+8
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 4
ADDRLP4 24
INDIRF4
ASGNF4
line 431
;430:
;431:	if ( cg.damageTime && cg.time - cg.damageTime < DAMAGE_TIME ) {
ADDRGP4 cg+128000
INDIRF4
CNSTF4 0
EQF4 $264
ADDRGP4 cg+107656
INDIRI4
CVIF4 4
ADDRGP4 cg+128000
INDIRF4
SUBF4
CNSTF4 1140457472
GEF4 $264
line 432
;432:		frac = (float)(cg.time - cg.damageTime ) / DAMAGE_TIME;
ADDRLP4 0
ADDRGP4 cg+107656
INDIRI4
CVIF4 4
ADDRGP4 cg+128000
INDIRF4
SUBF4
CNSTF4 990057071
MULF4
ASGNF4
line 433
;433:		size = ICON_SIZE * 1.25 * ( 1.5 - frac * 0.5 );
ADDRLP4 16
CNSTF4 1069547520
ADDRLP4 0
INDIRF4
CNSTF4 1056964608
MULF4
SUBF4
CNSTF4 1114636288
MULF4
ASGNF4
line 435
;434:
;435:		stretch = size - ICON_SIZE * 1.25;
ADDRLP4 20
ADDRLP4 16
INDIRF4
CNSTF4 1114636288
SUBF4
ASGNF4
line 437
;436:		// kick in the direction of damage
;437:		x -= stretch * 0.5 + cg.damageX * stretch * 0.5;
ADDRLP4 28
ADDRLP4 20
INDIRF4
ASGNF4
ADDRFP4 0
ADDRFP4 0
INDIRF4
ADDRLP4 28
INDIRF4
CNSTF4 1056964608
MULF4
ADDRGP4 cg+128004
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
CNSTF4 1056964608
MULF4
ADDF4
SUBF4
ASGNF4
line 439
;438:
;439:		cg.headStartYaw = 180 + cg.damageX * 45;
ADDRGP4 cg+128036
ADDRGP4 cg+128004
INDIRF4
CNSTF4 1110704128
MULF4
CNSTF4 1127481344
ADDF4
ASGNF4
line 441
;440:
;441:		cg.headEndYaw = 180 + 20 * cos( crandom()*M_PI );
ADDRLP4 32
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 32
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 32
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1086918619
MULF4
ARGF4
ADDRLP4 36
ADDRGP4 cos
CALLF4
ASGNF4
ADDRGP4 cg+128024
ADDRLP4 36
INDIRF4
CNSTF4 1101004800
MULF4
CNSTF4 1127481344
ADDF4
ASGNF4
line 442
;442:		cg.headEndPitch = 5 * cos( crandom()*M_PI );
ADDRLP4 40
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 40
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 40
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1086918619
MULF4
ARGF4
ADDRLP4 44
ADDRGP4 cos
CALLF4
ASGNF4
ADDRGP4 cg+128020
ADDRLP4 44
INDIRF4
CNSTF4 1084227584
MULF4
ASGNF4
line 444
;443:
;444:		cg.headStartTime = cg.time;
ADDRGP4 cg+128040
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 445
;445:		cg.headEndTime = cg.time + 100 + random() * 2000;
ADDRLP4 48
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRGP4 cg+128028
ADDRGP4 cg+107656
INDIRI4
CNSTI4 100
ADDI4
CVIF4 4
ADDRLP4 48
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 48
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 888799232
MULF4
ADDF4
CVFI4 4
ASGNI4
line 446
;446:	} else {
ADDRGP4 $265
JUMPV
LABELV $264
line 447
;447:		if ( cg.time >= cg.headEndTime ) {
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cg+128028
INDIRI4
LTI4 $280
line 449
;448:			// select a new head angle
;449:			cg.headStartYaw = cg.headEndYaw;
ADDRGP4 cg+128036
ADDRGP4 cg+128024
INDIRF4
ASGNF4
line 450
;450:			cg.headStartPitch = cg.headEndPitch;
ADDRGP4 cg+128032
ADDRGP4 cg+128020
INDIRF4
ASGNF4
line 451
;451:			cg.headStartTime = cg.headEndTime;
ADDRGP4 cg+128040
ADDRGP4 cg+128028
INDIRI4
ASGNI4
line 452
;452:			cg.headEndTime = cg.time + 100 + random() * 2000;
ADDRLP4 28
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRGP4 cg+128028
ADDRGP4 cg+107656
INDIRI4
CNSTI4 100
ADDI4
CVIF4 4
ADDRLP4 28
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 28
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 888799232
MULF4
ADDF4
CVFI4 4
ASGNI4
line 454
;453:
;454:			cg.headEndYaw = 180 + 20 * cos( crandom()*M_PI );
ADDRLP4 32
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 32
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 32
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1086918619
MULF4
ARGF4
ADDRLP4 36
ADDRGP4 cos
CALLF4
ASGNF4
ADDRGP4 cg+128024
ADDRLP4 36
INDIRF4
CNSTF4 1101004800
MULF4
CNSTF4 1127481344
ADDF4
ASGNF4
line 455
;455:			cg.headEndPitch = 5 * cos( crandom()*M_PI );
ADDRLP4 40
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 40
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 40
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1086918619
MULF4
ARGF4
ADDRLP4 44
ADDRGP4 cos
CALLF4
ASGNF4
ADDRGP4 cg+128020
ADDRLP4 44
INDIRF4
CNSTF4 1084227584
MULF4
ASGNF4
line 456
;456:		}
LABELV $280
line 458
;457:
;458:		size = ICON_SIZE * 1.25;
ADDRLP4 16
CNSTF4 1114636288
ASGNF4
line 459
;459:	}
LABELV $265
line 462
;460:
;461:	// if the server was frozen for a while we may have a bad head start time
;462:	if ( cg.headStartTime > cg.time ) {
ADDRGP4 cg+128040
INDIRI4
ADDRGP4 cg+107656
INDIRI4
LEI4 $294
line 463
;463:		cg.headStartTime = cg.time;
ADDRGP4 cg+128040
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 464
;464:	}
LABELV $294
line 466
;465:
;466:	frac = ( cg.time - cg.headStartTime ) / (float)( cg.headEndTime - cg.headStartTime );
ADDRLP4 0
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cg+128040
INDIRI4
SUBI4
CVIF4 4
ADDRGP4 cg+128028
INDIRI4
ADDRGP4 cg+128040
INDIRI4
SUBI4
CVIF4 4
DIVF4
ASGNF4
line 467
;467:	frac = frac * frac * ( 3 - 2 * frac );
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
CNSTF4 1077936128
ADDRLP4 0
INDIRF4
CNSTF4 1073741824
MULF4
SUBF4
MULF4
ASGNF4
line 468
;468:	angles[YAW] = cg.headStartYaw + ( cg.headEndYaw - cg.headStartYaw ) * frac;
ADDRLP4 4+4
ADDRGP4 cg+128036
INDIRF4
ADDRGP4 cg+128024
INDIRF4
ADDRGP4 cg+128036
INDIRF4
SUBF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
line 469
;469:	angles[PITCH] = cg.headStartPitch + ( cg.headEndPitch - cg.headStartPitch ) * frac;
ADDRLP4 4
ADDRGP4 cg+128032
INDIRF4
ADDRGP4 cg+128020
INDIRF4
ADDRGP4 cg+128032
INDIRF4
SUBF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
line 471
;470:
;471:	CG_DrawHead( x, 480 - size, size, size,
ADDRFP4 0
INDIRF4
ARGF4
CNSTF4 1139802112
ADDRLP4 16
INDIRF4
SUBF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 CG_DrawHead
CALLV
pop
line 473
;472:				cg.snap->ps.clientNum, angles );
;473:}
LABELV $261
endproc CG_DrawStatusBarHead 52 24
proc CG_DrawStatusBarFlag 0 24
line 483
;474:#endif
;475:
;476:/*
;477:================
;478:CG_DrawStatusBarFlag
;479:
;480:================
;481:*/
;482:#ifndef MISSIONPACK
;483:static void CG_DrawStatusBarFlag( float x, int team ) {
line 484
;484:	CG_DrawFlagModel( x, 480 - ICON_SIZE, ICON_SIZE, ICON_SIZE, team, qfalse );
ADDRFP4 0
INDIRF4
ARGF4
CNSTF4 1138229248
ARGF4
CNSTF4 1111490560
ARGF4
CNSTF4 1111490560
ARGF4
ADDRFP4 4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawFlagModel
CALLV
pop
line 485
;485:}
LABELV $312
endproc CG_DrawStatusBarFlag 0 24
export CG_DrawTeamBackground
proc CG_DrawTeamBackground 16 20
line 495
;486:#endif
;487:
;488:/*
;489:================
;490:CG_DrawTeamBackground
;491:
;492:================
;493:*/
;494:void CG_DrawTeamBackground( int x, int y, int w, int h, float alpha, int team )
;495:{
line 498
;496:	vec4_t		hcolor;
;497:
;498:	hcolor[3] = alpha;
ADDRLP4 0+12
ADDRFP4 16
INDIRF4
ASGNF4
line 499
;499:	if ( team == TEAM_RED ) {
ADDRFP4 20
INDIRI4
CNSTI4 1
NEI4 $315
line 500
;500:		hcolor[0] = 1;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 501
;501:		hcolor[1] = 0;
ADDRLP4 0+4
CNSTF4 0
ASGNF4
line 502
;502:		hcolor[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 503
;503:	} else if ( team == TEAM_BLUE ) {
ADDRGP4 $316
JUMPV
LABELV $315
ADDRFP4 20
INDIRI4
CNSTI4 2
NEI4 $313
line 504
;504:		hcolor[0] = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 505
;505:		hcolor[1] = 0;
ADDRLP4 0+4
CNSTF4 0
ASGNF4
line 506
;506:		hcolor[2] = 1;
ADDRLP4 0+8
CNSTF4 1065353216
ASGNF4
line 507
;507:	} else {
line 508
;508:		return;
LABELV $320
LABELV $316
line 510
;509:	}
;510:	trap_R_SetColor( hcolor );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 511
;511:	CG_DrawPic( x, y, w, h, cgs.media.teamStatusBar );
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 cgs+751220+180
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 512
;512:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 513
;513:}
LABELV $313
endproc CG_DrawTeamBackground 16 20
data
align 4
LABELV $326
byte 4 1065353216
byte 4 1060152279
byte 4 0
byte 4 1065353216
byte 4 1065353216
byte 4 1045220557
byte 4 1045220557
byte 4 1065353216
byte 4 1056964608
byte 4 1056964608
byte 4 1056964608
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
code
proc CG_SetValueColor 4 4
line 520
;514:
;515:/*
;516:================
;517:JUHOX: CG_SetValueColor
;518:================
;519:*/
;520:static void CG_SetValueColor(int value, int stdValue, qboolean flash) {
line 528
;521:	static float colors[4][4] = {
;522://		{ 0.2, 1.0, 0.2, 1.0 } , { 1.0, 0.2, 0.2, 1.0 }, {0.5, 0.5, 0.5, 1} };
;523:		{ 1, 0.69, 0, 1.0 } ,		// normal
;524:		{ 1.0, 0.2, 0.2, 1.0 },		// low health
;525:		{0.5, 0.5, 0.5, 1},			// weapon firing
;526:		{ 1, 1, 1, 1 } };			// health > 100
;527:
;528:	if (value > stdValue) {
ADDRFP4 0
INDIRI4
ADDRFP4 4
INDIRI4
LEI4 $327
line 529
;529:		trap_R_SetColor(colors[3]);		// white
ADDRGP4 $326+48
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 530
;530:	} else if (value > 0.25*stdValue || !flash) {
ADDRGP4 $328
JUMPV
LABELV $327
ADDRFP4 0
INDIRI4
CVIF4 4
ADDRFP4 4
INDIRI4
CVIF4 4
CNSTF4 1048576000
MULF4
GTF4 $332
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $330
LABELV $332
line 531
;531:		trap_R_SetColor(colors[0]);	// green
ADDRGP4 $326
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 532
;532:	} else if (value > 0) {
ADDRGP4 $331
JUMPV
LABELV $330
ADDRFP4 0
INDIRI4
CNSTI4 0
LEI4 $333
line 535
;533:		int color;
;534:
;535:		color = (cg.time >> 8) & 1;	// flash
ADDRLP4 0
ADDRGP4 cg+107656
INDIRI4
CNSTI4 8
RSHI4
CNSTI4 1
BANDI4
ASGNI4
line 536
;536:		trap_R_SetColor(colors[color]);
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 $326
ADDP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 537
;537:	} else {
ADDRGP4 $334
JUMPV
LABELV $333
line 538
;538:		trap_R_SetColor(colors[1]);	// red
ADDRGP4 $326+16
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 539
;539:	}
LABELV $334
LABELV $331
LABELV $328
line 540
;540:}
LABELV $325
endproc CG_SetValueColor 4 4
data
align 4
LABELV $338
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
align 4
LABELV $339
byte 4 1065353216
byte 4 1060152279
byte 4 0
align 4
LABELV $340
byte 4 1065353216
byte 4 1045220557
byte 4 1045220557
code
proc CG_DrawStrengthBar 84 20
line 547
;541:
;542:/*
;543:================
;544:JUHOX: CG_DrawStrengthBar
;545:================
;546:*/
;547:static void CG_DrawStrengthBar(qboolean inStatusBar) {
line 552
;548:	float color[4];
;549:	float strength;
;550:	float frac;
;551:	float y;
;552:	const float limit1 = 0.5;
ADDRLP4 72
CNSTF4 1056964608
ASGNF4
line 553
;553:	const float color1[3] = {1, 1, 1};
ADDRLP4 56
ADDRGP4 $338
INDIRB
ASGNB 12
line 554
;554:	const float limit2 = 0.333;
ADDRLP4 52
CNSTF4 1051361018
ASGNF4
line 555
;555:	const float color2[3] = {1, 0.69, 0};
ADDRLP4 36
ADDRGP4 $339
INDIRB
ASGNB 12
line 556
;556:	const float limit3 = 0.1;
ADDRLP4 48
CNSTF4 1036831949
ASGNF4
line 557
;557:	const float color3[3] = {1, 0.2, 0.2};
ADDRLP4 20
ADDRGP4 $340
INDIRB
ASGNB 12
line 559
;558:
;559:	if (!cgs.stamina) return;
ADDRGP4 cgs+31832
INDIRI4
CNSTI4 0
NEI4 $341
ADDRGP4 $337
JUMPV
LABELV $341
line 561
;560:
;561:	strength = cg.snap->ps.stats[STAT_STRENGTH] / MAX_STRENGTH_VALUE;
ADDRLP4 16
ADDRGP4 cg+36
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
CVIF4 4
CNSTF4 946406483
MULF4
ASGNF4
line 563
;562:
;563:	if (strength < limit3) {
ADDRLP4 16
INDIRF4
ADDRLP4 48
INDIRF4
GEF4 $345
line 564
;564:		color[0] = color3[0];
ADDRLP4 0
ADDRLP4 20
INDIRF4
ASGNF4
line 565
;565:		color[1] = color3[1];
ADDRLP4 0+4
ADDRLP4 20+4
INDIRF4
ASGNF4
line 566
;566:		color[2] = color3[2];
ADDRLP4 0+8
ADDRLP4 20+8
INDIRF4
ASGNF4
line 567
;567:	}
ADDRGP4 $346
JUMPV
LABELV $345
line 568
;568:	else if (strength < limit2) {
ADDRLP4 16
INDIRF4
ADDRLP4 52
INDIRF4
GEF4 $351
line 569
;569:		frac = (strength - limit3) / (limit2 - limit3);
ADDRLP4 76
ADDRLP4 48
INDIRF4
ASGNF4
ADDRLP4 68
ADDRLP4 16
INDIRF4
ADDRLP4 76
INDIRF4
SUBF4
ADDRLP4 52
INDIRF4
ADDRLP4 76
INDIRF4
SUBF4
DIVF4
ASGNF4
line 570
;570:		color[0] = color3[0] + frac * (color2[0] - color3[0]);
ADDRLP4 80
ADDRLP4 20
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 80
INDIRF4
ADDRLP4 68
INDIRF4
ADDRLP4 36
INDIRF4
ADDRLP4 80
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 571
;571:		color[1] = color3[1] + frac * (color2[1] - color3[1]);
ADDRLP4 0+4
ADDRLP4 20+4
INDIRF4
ADDRLP4 68
INDIRF4
ADDRLP4 36+4
INDIRF4
ADDRLP4 20+4
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 572
;572:		color[2] = color3[2] + frac * (color2[2] - color3[2]);
ADDRLP4 0+8
ADDRLP4 20+8
INDIRF4
ADDRLP4 68
INDIRF4
ADDRLP4 36+8
INDIRF4
ADDRLP4 20+8
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 573
;573:	}
ADDRGP4 $352
JUMPV
LABELV $351
line 574
;574:	else if (strength < limit1) {
ADDRLP4 16
INDIRF4
ADDRLP4 72
INDIRF4
GEF4 $361
line 575
;575:		frac = (strength - limit2) / (limit1 - limit2);
ADDRLP4 76
ADDRLP4 52
INDIRF4
ASGNF4
ADDRLP4 68
ADDRLP4 16
INDIRF4
ADDRLP4 76
INDIRF4
SUBF4
ADDRLP4 72
INDIRF4
ADDRLP4 76
INDIRF4
SUBF4
DIVF4
ASGNF4
line 576
;576:		color[0] = color2[0] + frac * (color1[0] - color2[0]);
ADDRLP4 80
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 80
INDIRF4
ADDRLP4 68
INDIRF4
ADDRLP4 56
INDIRF4
ADDRLP4 80
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 577
;577:		color[1] = color2[1] + frac * (color1[1] - color2[1]);
ADDRLP4 0+4
ADDRLP4 36+4
INDIRF4
ADDRLP4 68
INDIRF4
ADDRLP4 56+4
INDIRF4
ADDRLP4 36+4
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 578
;578:		color[2] = color2[2] + frac * (color1[2] - color2[2]);
ADDRLP4 0+8
ADDRLP4 36+8
INDIRF4
ADDRLP4 68
INDIRF4
ADDRLP4 56+8
INDIRF4
ADDRLP4 36+8
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 579
;579:	}
ADDRGP4 $362
JUMPV
LABELV $361
line 580
;580:	else {
line 581
;581:		color[0] = color1[0];
ADDRLP4 0
ADDRLP4 56
INDIRF4
ASGNF4
line 582
;582:		color[1] = color1[1];
ADDRLP4 0+4
ADDRLP4 56+4
INDIRF4
ASGNF4
line 583
;583:		color[2] = color1[2];
ADDRLP4 0+8
ADDRLP4 56+8
INDIRF4
ASGNF4
line 584
;584:	}
LABELV $362
LABELV $352
LABELV $346
line 585
;585:	color[3] = 1;
ADDRLP4 0+12
CNSTF4 1065353216
ASGNF4
line 587
;586:
;587:	if (strength < 0) {
ADDRLP4 16
INDIRF4
CNSTF4 0
GEF4 $376
line 588
;588:		strength = 1;
ADDRLP4 16
CNSTF4 1065353216
ASGNF4
line 589
;589:		color[0] = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 590
;590:		color[1] = 1;
ADDRLP4 0+4
CNSTF4 1065353216
ASGNF4
line 591
;591:		color[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 592
;592:	}
ADDRGP4 $377
JUMPV
LABELV $376
line 593
;593:	else if (strength > 1) {
ADDRLP4 16
INDIRF4
CNSTF4 1065353216
LEF4 $380
line 594
;594:		strength = 1;
ADDRLP4 16
CNSTF4 1065353216
ASGNF4
line 595
;595:		color[0] = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 596
;596:		color[1] = 0;
ADDRLP4 0+4
CNSTF4 0
ASGNF4
line 597
;597:		color[2] = 1;
ADDRLP4 0+8
CNSTF4 1065353216
ASGNF4
line 598
;598:	}
LABELV $380
LABELV $377
line 600
;599:
;600:	y = inStatusBar? 471 - ICON_SIZE : 471;
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $385
ADDRLP4 76
CNSTI4 423
ASGNI4
ADDRGP4 $386
JUMPV
LABELV $385
ADDRLP4 76
CNSTI4 471
ASGNI4
LABELV $386
ADDRLP4 32
ADDRLP4 76
INDIRI4
CVIF4 4
ASGNF4
line 602
;601:
;602:	CG_FillRect(220, y, 200 * strength, 5, color);
CNSTF4 1130102784
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
CNSTF4 1128792064
MULF4
ARGF4
CNSTF4 1084227584
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 604
;603:
;604:	color[0] = 0.5;
ADDRLP4 0
CNSTF4 1056964608
ASGNF4
line 605
;605:	color[1] = 0.5;
ADDRLP4 0+4
CNSTF4 1056964608
ASGNF4
line 606
;606:	color[2] = 0.5;
ADDRLP4 0+8
CNSTF4 1056964608
ASGNF4
line 607
;607:	CG_FillRect(220 + 200*strength, y, 200 * (1-strength), 5, color);
ADDRLP4 16
INDIRF4
CNSTF4 1128792064
MULF4
CNSTF4 1130102784
ADDF4
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
CNSTF4 1065353216
ADDRLP4 16
INDIRF4
SUBF4
CNSTF4 1128792064
MULF4
ARGF4
CNSTF4 1084227584
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 608
;608:}
LABELV $337
endproc CG_DrawStrengthBar 84 20
data
align 4
LABELV $390
byte 4 1065353216
byte 4 1060152279
byte 4 0
byte 4 1065353216
byte 4 1065353216
byte 4 1045220557
byte 4 1045220557
byte 4 1065353216
byte 4 1056964608
byte 4 1056964608
byte 4 1056964608
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
code
proc CG_DrawStatusBar 68 36
line 617
;609:
;610:/*
;611:================
;612:CG_DrawStatusBar
;613:
;614:================
;615:*/
;616:#ifndef MISSIONPACK
;617:static void CG_DrawStatusBar( void ) {
line 635
;618:	int			color;
;619:	centity_t	*cent;
;620:	playerState_t	*ps;
;621:	int			value;
;622:	vec4_t		hcolor;
;623:	vec3_t		angles;
;624:	vec3_t		origin;
;625:#ifdef MISSIONPACK
;626:	qhandle_t	handle;
;627:#endif
;628:	static float colors[4][4] = {
;629://		{ 0.2, 1.0, 0.2, 1.0 } , { 1.0, 0.2, 0.2, 1.0 }, {0.5, 0.5, 0.5, 1} };
;630:		{ 1.0f, 0.69f, 0.0f, 1.0f } ,		// normal
;631:		{ 1.0f, 0.2f, 0.2f, 1.0f },		// low health
;632:		{0.5f, 0.5f, 0.5f, 1.0f},			// weapon firing
;633:		{ 1.0f, 1.0f, 1.0f, 1.0f } };			// health > 100
;634:
;635:	if ( cg_drawStatus.integer == 0 ) {
ADDRGP4 cg_drawStatus+12
INDIRI4
CNSTI4 0
NEI4 $391
line 636
;636:		return;
ADDRGP4 $389
JUMPV
LABELV $391
line 640
;637:	}
;638:
;639:	// draw the team background
;640:	CG_DrawTeamBackground( 0, 420, 640, 60, 0.33f, cg.snap->ps.persistant[PERS_TEAM] );
CNSTI4 0
ARGI4
CNSTI4 420
ARGI4
CNSTI4 640
ARGI4
CNSTI4 60
ARGI4
CNSTF4 1051260355
ARGF4
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawTeamBackground
CALLV
pop
line 642
;641:
;642:	if (cg.snap->ps.pm_type != PM_SPECTATOR) CG_DrawStrengthBar(qtrue);	// JUHOX
ADDRGP4 cg+36
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 2
EQI4 $395
CNSTI4 1
ARGI4
ADDRGP4 CG_DrawStrengthBar
CALLV
pop
LABELV $395
line 644
;643:
;644:	cent = &cg_entities[cg.snap->ps.clientNum];
ADDRLP4 8
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 880
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 645
;645:	ps = &cg.snap->ps;
ADDRLP4 4
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
line 647
;646:
;647:	VectorClear( angles );
ADDRLP4 56
CNSTF4 0
ASGNF4
ADDRLP4 12+8
ADDRLP4 56
INDIRF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 56
INDIRF4
ASGNF4
ADDRLP4 12
ADDRLP4 56
INDIRF4
ASGNF4
line 650
;648:
;649:	// draw any 3D icons first, so the changes back to 2D are minimized
;650:	if ( cent->currentState.weapon && cg_weapons[ cent->currentState.weapon ].ammoModel ) {
ADDRLP4 8
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 0
EQI4 $402
ADDRLP4 8
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 136
MULI4
ADDRGP4 cg_weapons+76
ADDP4
INDIRI4
CNSTI4 0
EQI4 $402
line 651
;651:		origin[0] = 70;
ADDRLP4 24
CNSTF4 1116471296
ASGNF4
line 652
;652:		origin[1] = 0;
ADDRLP4 24+4
CNSTF4 0
ASGNF4
line 653
;653:		origin[2] = 0;
ADDRLP4 24+8
CNSTF4 0
ASGNF4
line 654
;654:		angles[YAW] = 90 + 20 * sin( cg.time / 1000.0 );
ADDRGP4 cg+107656
INDIRI4
CVIF4 4
CNSTF4 981668463
MULF4
ARGF4
ADDRLP4 64
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 64
INDIRF4
CNSTF4 1101004800
MULF4
CNSTF4 1119092736
ADDF4
ASGNF4
line 660
;655:#if 0	// JUHOX: new parameter for CG_Draw3DModel()
;656:		CG_Draw3DModel( CHAR_WIDTH*3 + TEXT_ICON_SPACE, 432, ICON_SIZE, ICON_SIZE,
;657:					   cg_weapons[ cent->currentState.weapon ].ammoModel, 0, origin, angles );
;658:#else
;659:#if MONSTER_MODE
;660:		if (cent->currentState.weapon == WP_MONSTER_LAUNCHER) {
ADDRLP4 8
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 11
NEI4 $409
line 661
;661:			CG_Draw3DModel(
CNSTF4 1120403456
ARGF4
CNSTF4 1138491392
ARGF4
CNSTF4 1111490560
ARGF4
CNSTF4 1111490560
ARGF4
ADDRGP4 cg_weapons+1496+76
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 24
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 cgs+751220+720
INDIRI4
ARGI4
ADDRGP4 CG_Draw3DModel
CALLV
pop
line 666
;662:				CHAR_WIDTH*3 + TEXT_ICON_SPACE, 440, ICON_SIZE, ICON_SIZE,
;663:				cg_weapons[WP_MONSTER_LAUNCHER].ammoModel, 0, origin, angles,
;664:				cgs.media.monsterSeedMetalShader
;665:			);
;666:		}
ADDRGP4 $410
JUMPV
LABELV $409
line 669
;667:		else
;668:#endif
;669:		{
line 670
;670:			CG_Draw3DModel(
CNSTF4 1120403456
ARGF4
CNSTF4 1138229248
ARGF4
CNSTF4 1111490560
ARGF4
CNSTF4 1111490560
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 136
MULI4
ADDRGP4 cg_weapons+76
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 24
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 CG_Draw3DModel
CALLV
pop
line 674
;671:				CHAR_WIDTH*3 + TEXT_ICON_SPACE, 432, ICON_SIZE, ICON_SIZE,
;672:				cg_weapons[ cent->currentState.weapon ].ammoModel, 0, origin, angles, 0
;673:			);
;674:		}
LABELV $410
line 676
;675:#endif
;676:	}
LABELV $402
line 678
;677:
;678:	CG_DrawStatusBarHead( 185 + CHAR_WIDTH*3 + TEXT_ICON_SPACE );
CNSTF4 1133412352
ARGF4
ADDRGP4 CG_DrawStatusBarHead
CALLV
pop
line 680
;679:
;680:	if (cg.snap->ps.pm_type == PM_SPECTATOR) return;	// JUHOX
ADDRGP4 cg+36
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 2
NEI4 $416
ADDRGP4 $389
JUMPV
LABELV $416
line 682
;681:
;682:	if( cg.predictedPlayerState.powerups[PW_REDFLAG] ) {
ADDRGP4 cg+107688+312+28
INDIRI4
CNSTI4 0
EQI4 $419
line 683
;683:		CG_DrawStatusBarFlag( 185 + CHAR_WIDTH*3 + TEXT_ICON_SPACE + ICON_SIZE, TEAM_RED );
CNSTF4 1134985216
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 CG_DrawStatusBarFlag
CALLV
pop
line 684
;684:	} else if( cg.predictedPlayerState.powerups[PW_BLUEFLAG] ) {
ADDRGP4 $420
JUMPV
LABELV $419
ADDRGP4 cg+107688+312+32
INDIRI4
CNSTI4 0
EQI4 $424
line 685
;685:		CG_DrawStatusBarFlag( 185 + CHAR_WIDTH*3 + TEXT_ICON_SPACE + ICON_SIZE, TEAM_BLUE );
CNSTF4 1134985216
ARGF4
CNSTI4 2
ARGI4
ADDRGP4 CG_DrawStatusBarFlag
CALLV
pop
line 686
;686:	} else if( cg.predictedPlayerState.powerups[PW_NEUTRALFLAG] ) {
ADDRGP4 $425
JUMPV
LABELV $424
ADDRGP4 cg+107688+312+36
INDIRI4
CNSTI4 0
EQI4 $429
line 687
;687:		CG_DrawStatusBarFlag( 185 + CHAR_WIDTH*3 + TEXT_ICON_SPACE + ICON_SIZE, TEAM_FREE );
CNSTF4 1134985216
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStatusBarFlag
CALLV
pop
line 688
;688:	}
LABELV $429
LABELV $425
LABELV $420
line 690
;689:
;690:	if ( ps->stats[ STAT_ARMOR ] ) {
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 0
EQI4 $434
line 691
;691:		origin[0] = 90;
ADDRLP4 24
CNSTF4 1119092736
ASGNF4
line 692
;692:		origin[1] = 0;
ADDRLP4 24+4
CNSTF4 0
ASGNF4
line 693
;693:		origin[2] = -10;
ADDRLP4 24+8
CNSTF4 3240099840
ASGNF4
line 694
;694:		angles[YAW] = ( cg.time & 2047 ) * 360 / 2048.0;
ADDRLP4 12+4
ADDRGP4 cg+107656
INDIRI4
CNSTI4 2047
BANDI4
CNSTI4 360
MULI4
CVIF4 4
CNSTF4 973078528
MULF4
ASGNF4
line 699
;695:#if 0	// JUHOX: armor may be >999; new parameter for CG_Draw3DModel()
;696:		CG_Draw3DModel( 370 + CHAR_WIDTH*3 + TEXT_ICON_SPACE, 432, ICON_SIZE, ICON_SIZE,
;697:					   cgs.media.armorModel, 0, origin, angles );
;698:#else
;699:		CG_Draw3DModel( 370 + CHAR_WIDTH*4 + TEXT_ICON_SPACE, 432, ICON_SIZE, ICON_SIZE,
CNSTF4 1140523008
ARGF4
CNSTF4 1138229248
ARGF4
CNSTF4 1111490560
ARGF4
CNSTF4 1111490560
ARGF4
ADDRGP4 cgs+751220+172
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 24
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 CG_Draw3DModel
CALLV
pop
line 702
;700:					   cgs.media.armorModel, 0, origin, angles, 0);
;701:#endif
;702:	}
LABELV $434
line 720
;703:#ifdef MISSIONPACK
;704:	if( cgs.gametype == GT_HARVESTER ) {
;705:		origin[0] = 90;
;706:		origin[1] = 0;
;707:		origin[2] = -10;
;708:		angles[YAW] = ( cg.time & 2047 ) * 360 / 2048.0;
;709:		if( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE ) {
;710:			handle = cgs.media.redCubeModel;
;711:		} else {
;712:			handle = cgs.media.blueCubeModel;
;713:		}
;714:		CG_Draw3DModel( 640 - (TEXT_ICON_SPACE + ICON_SIZE), 416, ICON_SIZE, ICON_SIZE, handle, 0, origin, angles );
;715:	}
;716:#endif
;717:	//
;718:	// ammo
;719:	//
;720:	if ( cent->currentState.weapon ) {
ADDRLP4 8
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 0
EQI4 $442
line 721
;721:		value = ps->ammo[cent->currentState.weapon];
ADDRLP4 0
ADDRLP4 8
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
ASGNI4
line 722
;722:		if ( value > -1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
LEI4 $444
line 723
;723:			if ( cg.predictedPlayerState.weaponstate == WEAPON_FIRING
ADDRGP4 cg+107688+148
INDIRI4
CNSTI4 3
NEI4 $446
ADDRGP4 cg+107688+44
INDIRI4
CNSTI4 100
LEI4 $446
line 724
;724:				&& cg.predictedPlayerState.weaponTime > 100 ) {
line 726
;725:				// draw as dark grey when reloading
;726:				color = 2;	// dark grey
ADDRLP4 52
CNSTI4 2
ASGNI4
line 727
;727:			} else {
ADDRGP4 $447
JUMPV
LABELV $446
line 728
;728:				if ( value >= 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $452
line 729
;729:					color = 0;	// green
ADDRLP4 52
CNSTI4 0
ASGNI4
line 730
;730:				} else {
ADDRGP4 $453
JUMPV
LABELV $452
line 731
;731:					color = 1;	// red
ADDRLP4 52
CNSTI4 1
ASGNI4
line 732
;732:				}
LABELV $453
line 734
;733:#if SPECIAL_VIEW_MODES
;734:				if (cg.viewMode == VIEW_scanner) color = 1;	// JUHOX: show that ammo is not recharging
ADDRGP4 cg+107628
INDIRI4
CNSTI4 1
NEI4 $454
ADDRLP4 52
CNSTI4 1
ASGNI4
LABELV $454
line 736
;735:#endif
;736:			}
LABELV $447
line 737
;737:			trap_R_SetColor( colors[color] );
ADDRLP4 52
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 $390
ADDP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 739
;738:
;739:			CG_DrawField (0, 432, 3, value);
CNSTI4 0
ARGI4
CNSTI4 432
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_DrawField
CALLV
pop
line 740
;740:			trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 743
;741:
;742:			// if we didn't draw a 3D icon, draw a 2D icon for ammo
;743:			if ( !cg_draw3dIcons.integer && cg_drawIcons.integer ) {
ADDRGP4 cg_draw3dIcons+12
INDIRI4
CNSTI4 0
NEI4 $457
ADDRGP4 cg_drawIcons+12
INDIRI4
CNSTI4 0
EQI4 $457
line 746
;744:				qhandle_t	icon;
;745:
;746:				icon = cg_weapons[ cg.predictedPlayerState.weapon ].ammoIcon;
ADDRLP4 64
ADDRGP4 cg+107688+144
INDIRI4
CNSTI4 136
MULI4
ADDRGP4 cg_weapons+72
ADDP4
INDIRI4
ASGNI4
line 747
;747:				if ( icon ) {
ADDRLP4 64
INDIRI4
CNSTI4 0
EQI4 $464
line 748
;748:					CG_DrawPic( CHAR_WIDTH*3 + TEXT_ICON_SPACE, 432, ICON_SIZE, ICON_SIZE, icon );
CNSTF4 1120403456
ARGF4
CNSTF4 1138229248
ARGF4
CNSTF4 1111490560
ARGF4
CNSTF4 1111490560
ARGF4
ADDRLP4 64
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 749
;749:				}
LABELV $464
line 750
;750:			}
LABELV $457
line 751
;751:		}
LABELV $444
line 752
;752:	}
LABELV $442
line 757
;753:
;754:	//
;755:	// health
;756:	//
;757:	value = ps->stats[STAT_HEALTH];
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 770
;758:#if 0	// JUHOX: consider handicap
;759:	if ( value > 100 ) {
;760:		trap_R_SetColor( colors[3] );		// white
;761:	} else if (value > 25) {
;762:		trap_R_SetColor( colors[0] );	// green
;763:	} else if (value > 0) {
;764:		color = (cg.time >> 8) & 1;	// flash
;765:		trap_R_SetColor( colors[color] );
;766:	} else {
;767:		trap_R_SetColor( colors[1] );	// red
;768:	}
;769:#else
;770:	CG_SetValueColor(value, ps->stats[STAT_MAX_HEALTH], qtrue/*flash if low*/);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 CG_SetValueColor
CALLV
pop
line 777
;771:#endif
;772:
;773:	// stretch the health up when taking damage
;774:#if 0	// JUHOX: health may be >999
;775:	CG_DrawField ( 185, 432, 3, value);
;776:#else
;777:	CG_DrawField(185-CHAR_WIDTH, 432, 4, value);
CNSTI4 153
ARGI4
CNSTI4 432
ARGI4
CNSTI4 4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_DrawField
CALLV
pop
line 779
;778:#endif
;779:	CG_ColorForHealth( hcolor );
ADDRLP4 36
ARGP4
ADDRGP4 CG_ColorForHealth
CALLV
pop
line 780
;780:	trap_R_SetColor( hcolor );
ADDRLP4 36
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 786
;781:
;782:
;783:	//
;784:	// armor
;785:	//
;786:	value = ps->stats[STAT_ARMOR];
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
line 787
;787:	if (value > 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $466
line 791
;788:#if 0	// JUHOX: consider handicap
;789:		trap_R_SetColor( colors[0] );
;790:#else
;791:		CG_SetValueColor(value, ps->stats[STAT_MAX_HEALTH], qfalse/*don't flash if low*/);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_SetValueColor
CALLV
pop
line 796
;792:#endif
;793:#if 0	// JUHOX: armor may be >999
;794:		CG_DrawField (370, 432, 3, value);
;795:#else
;796:		CG_DrawField(370, 432, 4, value);
CNSTI4 370
ARGI4
CNSTI4 432
ARGI4
CNSTI4 4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_DrawField
CALLV
pop
line 798
;797:#endif
;798:		trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 800
;799:		// if we didn't draw a 3D icon, draw a 2D icon for armor
;800:		if ( !cg_draw3dIcons.integer && cg_drawIcons.integer ) {
ADDRGP4 cg_draw3dIcons+12
INDIRI4
CNSTI4 0
NEI4 $468
ADDRGP4 cg_drawIcons+12
INDIRI4
CNSTI4 0
EQI4 $468
line 804
;801:#if 0	// JUHOX: armor may be >999
;802:			CG_DrawPic( 370 + CHAR_WIDTH*3 + TEXT_ICON_SPACE, 432, ICON_SIZE, ICON_SIZE, cgs.media.armorIcon );
;803:#else
;804:			CG_DrawPic(370 + CHAR_WIDTH*4 + TEXT_ICON_SPACE, 432, ICON_SIZE, ICON_SIZE, cgs.media.armorIcon);
CNSTF4 1140523008
ARGF4
CNSTF4 1138229248
ARGF4
CNSTF4 1111490560
ARGF4
CNSTF4 1111490560
ARGF4
ADDRGP4 cgs+751220+176
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 806
;805:#endif
;806:		}
LABELV $468
line 808
;807:
;808:	}
LABELV $466
line 832
;809:#ifdef MISSIONPACK
;810:	//
;811:	// cubes
;812:	//
;813:	if( cgs.gametype == GT_HARVESTER ) {
;814:		value = ps->generic1;
;815:		if( value > 99 ) {
;816:			value = 99;
;817:		}
;818:		trap_R_SetColor( colors[0] );
;819:		CG_DrawField (640 - (CHAR_WIDTH*2 + TEXT_ICON_SPACE + ICON_SIZE), 432, 2, value);
;820:		trap_R_SetColor( NULL );
;821:		// if we didn't draw a 3D icon, draw a 2D icon for armor
;822:		if ( !cg_draw3dIcons.integer && cg_drawIcons.integer ) {
;823:			if( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE ) {
;824:				handle = cgs.media.redCubeIcon;
;825:			} else {
;826:				handle = cgs.media.blueCubeIcon;
;827:			}
;828:			CG_DrawPic( 640 - (TEXT_ICON_SPACE + ICON_SIZE), 432, ICON_SIZE, ICON_SIZE, handle );
;829:		}
;830:	}
;831:#endif
;832:}
LABELV $389
endproc CG_DrawStatusBar 68 36
proc CG_DrawAttacker 52 24
line 849
;833:#endif
;834:
;835:/*
;836:===========================================================================================
;837:
;838:  UPPER RIGHT CORNER
;839:
;840:===========================================================================================
;841:*/
;842:
;843:/*
;844:================
;845:CG_DrawAttacker
;846:
;847:================
;848:*/
;849:static float CG_DrawAttacker( float y ) {
line 857
;850:	int			t;
;851:	float		size;
;852:	vec3_t		angles;
;853:	const char	*info;
;854:	const char	*name;
;855:	int			clientNum;
;856:
;857:	if ( cg.predictedPlayerState.stats[STAT_HEALTH] <= 0 ) {
ADDRGP4 cg+107688+184
INDIRI4
CNSTI4 0
GTI4 $475
line 858
;858:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $474
JUMPV
LABELV $475
line 861
;859:	}
;860:
;861:	if ( !cg.attackerTime ) {
ADDRGP4 cg+127728
INDIRI4
CNSTI4 0
NEI4 $479
line 862
;862:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $474
JUMPV
LABELV $479
line 865
;863:	}
;864:
;865:	clientNum = cg.predictedPlayerState.persistant[PERS_ATTACKER];
ADDRLP4 0
ADDRGP4 cg+107688+248+24
INDIRI4
ASGNI4
line 866
;866:	if ( clientNum < 0 || clientNum >= MAX_CLIENTS || clientNum == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $489
ADDRLP4 0
INDIRI4
CNSTI4 64
GEI4 $489
ADDRLP4 0
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $485
LABELV $489
line 867
;867:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $474
JUMPV
LABELV $485
line 870
;868:	}
;869:
;870:	t = cg.time - cg.attackerTime;
ADDRLP4 24
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cg+127728
INDIRI4
SUBI4
ASGNI4
line 871
;871:	if ( t > ATTACKER_HEAD_TIME ) {
ADDRLP4 24
INDIRI4
CNSTI4 10000
LEI4 $492
line 872
;872:		cg.attackerTime = 0;
ADDRGP4 cg+127728
CNSTI4 0
ASGNI4
line 873
;873:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $474
JUMPV
LABELV $492
line 876
;874:	}
;875:
;876:	size = ICON_SIZE * 1.25;
ADDRLP4 4
CNSTF4 1114636288
ASGNF4
line 878
;877:
;878:	angles[PITCH] = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 879
;879:	angles[YAW] = 180;
ADDRLP4 8+4
CNSTF4 1127481344
ASGNF4
line 880
;880:	angles[ROLL] = 0;
ADDRLP4 8+8
CNSTF4 0
ASGNF4
line 881
;881:	CG_DrawHead( 640 - size, y, size, size, clientNum, angles );
CNSTF4 1142947840
ADDRLP4 4
INDIRF4
SUBF4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
ADDRGP4 CG_DrawHead
CALLV
pop
line 883
;882:
;883:	info = CG_ConfigString( CS_PLAYERS + clientNum );
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 40
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 28
ADDRLP4 40
INDIRP4
ASGNP4
line 884
;884:	name = Info_ValueForKey(  info, "n" );
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 $497
ARGP4
ADDRLP4 44
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 44
INDIRP4
ASGNP4
line 885
;885:	y += size;
ADDRFP4 0
ADDRFP4 0
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ASGNF4
line 886
;886:	CG_DrawBigString( 640 - ( Q_PrintStrlen( name ) * BIGCHAR_WIDTH), y, name, 0.5 );
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 Q_PrintStrlen
CALLI4
ASGNI4
CNSTI4 640
ADDRLP4 48
INDIRI4
CNSTI4 4
LSHI4
SUBI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
CNSTF4 1056964608
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 888
;887:
;888:	return y + BIGCHAR_HEIGHT + 2;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1073741824
ADDF4
RETF4
LABELV $474
endproc CG_DrawAttacker 52 24
proc CG_DrawSnapshot 16 16
line 896
;889:}
;890:
;891:/*
;892:==================
;893:CG_DrawSnapshot
;894:==================
;895:*/
;896:static float CG_DrawSnapshot( float y ) {
line 900
;897:	char		*s;
;898:	int			w;
;899:
;900:	s = va( "time:%i snap:%i cmd:%i", cg.snap->serverTime,
ADDRGP4 $499
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+28
INDIRI4
ARGI4
ADDRGP4 cgs+31444
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 902
;901:		cg.latestSnapshotNum, cgs.serverCommandSequence );
;902:	w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 904
;903:
;904:	CG_DrawBigString( 635 - w, y + 2, s, 1.0F);
CNSTI4 635
ADDRLP4 4
INDIRI4
SUBI4
ARGI4
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
ADDF4
CVFI4 4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 906
;905:
;906:	return y + BIGCHAR_HEIGHT + 4;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1082130432
ADDF4
RETF4
LABELV $498
endproc CG_DrawSnapshot 16 16
bss
align 4
LABELV $504
skip 16
align 4
LABELV $505
skip 4
align 4
LABELV $506
skip 4
code
proc CG_DrawFPS 44 16
line 915
;907:}
;908:
;909:/*
;910:==================
;911:CG_DrawFPS
;912:==================
;913:*/
;914:#define	FPS_FRAMES	4
;915:static float CG_DrawFPS( float y ) {
line 927
;916:	char		*s;
;917:	int			w;
;918:	static int	previousTimes[FPS_FRAMES];
;919:	static int	index;
;920:	int		i, total;
;921:	int		fps;
;922:	static	int	previous;
;923:	int		t, frameTime;
;924:
;925:	// don't use serverTime, because that will be drifting to
;926:	// correct for internet lag changes, timescales, timedemos, etc
;927:	t = trap_Milliseconds();
ADDRLP4 28
ADDRGP4 trap_Milliseconds
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 28
INDIRI4
ASGNI4
line 928
;928:	frameTime = t - previous;
ADDRLP4 12
ADDRLP4 8
INDIRI4
ADDRGP4 $506
INDIRI4
SUBI4
ASGNI4
line 929
;929:	previous = t;
ADDRGP4 $506
ADDRLP4 8
INDIRI4
ASGNI4
line 931
;930:
;931:	previousTimes[index % FPS_FRAMES] = frameTime;
ADDRGP4 $505
INDIRI4
CNSTI4 4
MODI4
CNSTI4 2
LSHI4
ADDRGP4 $504
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 932
;932:	index++;
ADDRLP4 32
ADDRGP4 $505
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 933
;933:	if ( index > FPS_FRAMES ) {
ADDRGP4 $505
INDIRI4
CNSTI4 4
LEI4 $507
line 935
;934:		// average multiple frames together to smooth changes out a bit
;935:		total = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 936
;936:		for ( i = 0 ; i < FPS_FRAMES ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $509
line 937
;937:			total += previousTimes[i];
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $504
ADDP4
INDIRI4
ADDI4
ASGNI4
line 938
;938:		}
LABELV $510
line 936
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $509
line 939
;939:		if ( !total ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $513
line 940
;940:			total = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 941
;941:		}
LABELV $513
line 942
;942:		fps = 1000 * FPS_FRAMES / total;
ADDRLP4 24
CNSTI4 4000
ADDRLP4 4
INDIRI4
DIVI4
ASGNI4
line 944
;943:
;944:		s = va( "%ifps", fps );
ADDRGP4 $515
ARGP4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 36
INDIRP4
ASGNP4
line 945
;945:		w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 40
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 947
;946:
;947:		CG_DrawBigString( 635 - w, y + 2, s, 1.0F);
CNSTI4 635
ADDRLP4 20
INDIRI4
SUBI4
ARGI4
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
ADDF4
CVFI4 4
ARGI4
ADDRLP4 16
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 948
;948:	}
LABELV $507
line 950
;949:
;950:	return y + BIGCHAR_HEIGHT + 4;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1082130432
ADDF4
RETF4
LABELV $503
endproc CG_DrawFPS 44 16
proc CG_DrawNumMonsters 24 16
line 959
;951:}
;952:
;953:/*
;954:==================
;955:JUHOX: CG_DrawNumMonsters
;956:==================
;957:*/
;958:#if MONSTER_MODE
;959:static float CG_DrawNumMonsters(float y) {
line 963
;960:	char* s;
;961:	int w;
;962:
;963:	s = va("Monsters: %d", atoi(CG_ConfigString(CS_NUMMONSTERS)));
CNSTI4 717
ARGI4
ADDRLP4 8
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 $517
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 964
;964:	w = CG_DrawStrlen(s) * BIGCHAR_WIDTH;
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 20
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 965
;965:	CG_DrawBigString(635 - w, y + 2, s, 1);
CNSTI4 635
ADDRLP4 4
INDIRI4
SUBI4
ARGI4
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
ADDF4
CVFI4 4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 966
;966:	return y + BIGCHAR_HEIGHT + 4;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1082130432
ADDF4
RETF4
LABELV $516
endproc CG_DrawNumMonsters 24 16
proc CG_DrawSegment 16 16
line 976
;967:}
;968:#endif
;969:
;970:/*
;971:==================
;972:JUHOX: CG_DrawSegment
;973:==================
;974:*/
;975:#if ESCAPE_MODE
;976:static float CG_DrawSegment(float y) {
line 980
;977:	const char* s;
;978:	int w;
;979:
;980:	s = CG_ConfigString(CS_EFH_SEGMENT);
CNSTI4 721
ARGI4
ADDRLP4 8
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 981
;981:	w = CG_DrawStrlen(s) * SMALLCHAR_WIDTH;
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
CNSTI4 3
LSHI4
ASGNI4
line 982
;982:	CG_DrawSmallString(635 - w, y + 2, s, 1);
CNSTI4 635
ADDRLP4 4
INDIRI4
SUBI4
ARGI4
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
ADDF4
CVFI4 4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawSmallString
CALLV
pop
line 983
;983:	return y + SMALLCHAR_HEIGHT + 4;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1082130432
ADDF4
RETF4
LABELV $518
endproc CG_DrawSegment 16 16
proc CG_DrawWeaponLimit 28 16
line 992
;984:}
;985:#endif
;986:
;987:/*
;988:==================
;989:JUHOX: CG_DrawWeaponLimit
;990:==================
;991:*/
;992:static float CG_DrawWeaponLimit(float y) {
line 997
;993:	const char* s;
;994:	int n;
;995:	int w;
;996:
;997:	s = CG_ConfigString(CS_CHOOSENWEAPONS);
CNSTI4 714
ARGI4
ADDRLP4 12
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 998
;998:	n = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 999
;999:	if (strlen(s) > cg.snap->ps.clientNum) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
LEI4 $520
line 1000
;1000:		n = s[cg.snap->ps.clientNum] - 'A';
ADDRLP4 4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 65
SUBI4
ASGNI4
line 1001
;1001:		if (n >= cgs.weaponLimit) return y;
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+31844
INDIRI4
LTI4 $524
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $519
JUMPV
LABELV $524
line 1002
;1002:	}
LABELV $520
line 1003
;1003:	s = va("selected weapons: %d/%d", n, cgs.weaponLimit);
ADDRGP4 $527
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 cgs+31844
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 1004
;1004:	w = CG_DrawStrlen(s) * BIGCHAR_WIDTH;
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 24
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 1005
;1005:	CG_DrawBigString(635 - w, y + 2, s, 1.0);
CNSTI4 635
ADDRLP4 8
INDIRI4
SUBI4
ARGI4
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
ADDF4
CVFI4 4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1006
;1006:	return y + BIGCHAR_HEIGHT + 4;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1082130432
ADDF4
RETF4
LABELV $519
endproc CG_DrawWeaponLimit 28 16
proc CG_DrawTimer 32 16
line 1014
;1007:}
;1008:
;1009:/*
;1010:=================
;1011:CG_DrawTimer
;1012:=================
;1013:*/
;1014:static float CG_DrawTimer( float y ) {
line 1020
;1015:	char		*s;
;1016:	int			w;
;1017:	int			mins, seconds, tens;
;1018:	int			msec;
;1019:
;1020:	msec = cg.time - cgs.levelStartTime;
ADDRLP4 20
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cgs+35120
INDIRI4
SUBI4
ASGNI4
line 1022
;1021:
;1022:	seconds = msec / 1000;
ADDRLP4 0
ADDRLP4 20
INDIRI4
CNSTI4 1000
DIVI4
ASGNI4
line 1023
;1023:	mins = seconds / 60;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 60
DIVI4
ASGNI4
line 1024
;1024:	seconds -= mins * 60;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
CNSTI4 60
MULI4
SUBI4
ASGNI4
line 1025
;1025:	tens = seconds / 10;
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 10
DIVI4
ASGNI4
line 1026
;1026:	seconds -= tens * 10;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 12
INDIRI4
CNSTI4 10
MULI4
SUBI4
ASGNI4
line 1028
;1027:
;1028:	s = va( "%i:%i%i", mins, tens, seconds );
ADDRGP4 $532
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
ASGNP4
line 1029
;1029:	w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 28
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 1031
;1030:
;1031:	CG_DrawBigString( 635 - w, y + 2, s, 1.0F);
CNSTI4 635
ADDRLP4 16
INDIRI4
SUBI4
ARGI4
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
ADDF4
CVFI4 4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1033
;1032:
;1033:	return y + BIGCHAR_HEIGHT + 4;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1082130432
ADDF4
RETF4
LABELV $529
endproc CG_DrawTimer 32 16
data
align 4
LABELV $605
byte 4 1065353216
byte 4 1060320051
byte 4 0
byte 4 1065353216
align 4
LABELV $606
byte 4 1056964608
byte 4 1056964608
byte 4 1056964608
byte 4 1065353216
code
proc CG_DrawTeamOverlay 156 36
line 1043
;1034:}
;1035:
;1036:
;1037:/*
;1038:=================
;1039:CG_DrawTeamOverlay
;1040:=================
;1041:*/
;1042:
;1043:static float CG_DrawTeamOverlay( float y, qboolean right, qboolean upper ) {
line 1055
;1044:	int x, w, h, xx;
;1045:	int i, j, len;
;1046:	const char *p;
;1047:	vec4_t		hcolor;
;1048:	int pwidth, lwidth;
;1049:	int plyrs;
;1050:	char st[16];
;1051:	clientInfo_t *ci;
;1052:	gitem_t	*item;
;1053:	int ret_y, count;
;1054:
;1055:	if (cg.tssInterfaceOn) return y;	// JUHOX
ADDRGP4 cg+128100
INDIRI4
CNSTI4 0
EQI4 $534
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $533
JUMPV
LABELV $534
line 1056
;1056:	if ( !cg_drawTeamOverlay.integer ) {
ADDRGP4 cg_drawTeamOverlay+12
INDIRI4
CNSTI4 0
NEI4 $537
line 1057
;1057:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $533
JUMPV
LABELV $537
line 1060
;1058:	}
;1059:
;1060:	if ( cg.snap->ps.persistant[PERS_TEAM] != TEAM_RED && cg.snap->ps.persistant[PERS_TEAM] != TEAM_BLUE ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
EQI4 $540
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
EQI4 $540
line 1061
;1061:		return y; // Not on any team
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $533
JUMPV
LABELV $540
line 1064
;1062:	}
;1063:
;1064:	plyrs = 0;
ADDRLP4 60
CNSTI4 0
ASGNI4
line 1067
;1065:
;1066:	// max player name width
;1067:	pwidth = 0;
ADDRLP4 52
CNSTI4 0
ASGNI4
line 1068
;1068:	count = (numSortedTeamPlayers > 8) ? 8 : numSortedTeamPlayers;
ADDRGP4 numSortedTeamPlayers
INDIRI4
CNSTI4 8
LEI4 $545
ADDRLP4 92
CNSTI4 8
ASGNI4
ADDRGP4 $546
JUMPV
LABELV $545
ADDRLP4 92
ADDRGP4 numSortedTeamPlayers
INDIRI4
ASGNI4
LABELV $546
ADDRLP4 48
ADDRLP4 92
INDIRI4
ASGNI4
line 1069
;1069:	for (i = 0; i < count; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $550
JUMPV
LABELV $547
line 1070
;1070:		ci = cgs.clientinfo + sortedTeamPlayers[i];
ADDRLP4 4
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sortedTeamPlayers
ADDP4
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320
ADDP4
ASGNP4
line 1071
;1071:		if ( ci->infoValid && ci->team == cg.snap->ps.persistant[PERS_TEAM]) {
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $552
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
NEI4 $552
line 1072
;1072:			plyrs++;
ADDRLP4 60
ADDRLP4 60
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1073
;1073:			len = CG_DrawStrlen(ci->name);
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 100
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 100
INDIRI4
ASGNI4
line 1074
;1074:			if (len > pwidth)
ADDRLP4 40
INDIRI4
ADDRLP4 52
INDIRI4
LEI4 $555
line 1075
;1075:				pwidth = len;
ADDRLP4 52
ADDRLP4 40
INDIRI4
ASGNI4
LABELV $555
line 1076
;1076:		}
LABELV $552
line 1077
;1077:	}
LABELV $548
line 1069
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $550
ADDRLP4 8
INDIRI4
ADDRLP4 48
INDIRI4
LTI4 $547
line 1079
;1078:
;1079:	if (!plyrs)
ADDRLP4 60
INDIRI4
CNSTI4 0
NEI4 $557
line 1080
;1080:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $533
JUMPV
LABELV $557
line 1082
;1081:
;1082:	if (pwidth > TEAM_OVERLAY_MAXNAME_WIDTH)
ADDRLP4 52
INDIRI4
CNSTI4 12
LEI4 $559
line 1083
;1083:		pwidth = TEAM_OVERLAY_MAXNAME_WIDTH;
ADDRLP4 52
CNSTI4 12
ASGNI4
LABELV $559
line 1084
;1084:	pwidth += 2;	// JUHOX: make room for the group mark
ADDRLP4 52
ADDRLP4 52
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 1087
;1085:
;1086:	// max location name width
;1087:	lwidth = 0;
ADDRLP4 44
CNSTI4 0
ASGNI4
line 1088
;1088:	for (i = 1; i < MAX_LOCATIONS; i++) {
ADDRLP4 8
CNSTI4 1
ASGNI4
LABELV $561
line 1089
;1089:		p = CG_ConfigString(CS_LOCATIONS + i);
ADDRLP4 8
INDIRI4
CNSTI4 608
ADDI4
ARGI4
ADDRLP4 96
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 96
INDIRP4
ASGNP4
line 1090
;1090:		if (p && *p) {
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $565
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $565
line 1091
;1091:			len = CG_DrawStrlen(p);
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 104
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 104
INDIRI4
ASGNI4
line 1092
;1092:			if (len > lwidth)
ADDRLP4 40
INDIRI4
ADDRLP4 44
INDIRI4
LEI4 $567
line 1093
;1093:				lwidth = len;
ADDRLP4 44
ADDRLP4 40
INDIRI4
ASGNI4
LABELV $567
line 1094
;1094:		}
LABELV $565
line 1095
;1095:	}
LABELV $562
line 1088
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 100
LTI4 $561
line 1098
;1096:
;1097:#if ESCAPE_MODE	// JUHOX: make room for way length
;1098:	if (cgs.gametype == GT_EFH) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 9
NEI4 $569
line 1099
;1099:		lwidth = 7;
ADDRLP4 44
CNSTI4 7
ASGNI4
line 1100
;1100:	}
LABELV $569
line 1103
;1101:#endif
;1102:
;1103:	if (lwidth > TEAM_OVERLAY_MAXLOCATION_WIDTH)
ADDRLP4 44
INDIRI4
CNSTI4 16
LEI4 $572
line 1104
;1104:		lwidth = TEAM_OVERLAY_MAXLOCATION_WIDTH;
ADDRLP4 44
CNSTI4 16
ASGNI4
LABELV $572
line 1106
;1105:
;1106:	w = (pwidth + lwidth + 4 + 7) * TINYCHAR_WIDTH;
ADDRLP4 80
ADDRLP4 52
INDIRI4
ADDRLP4 44
INDIRI4
ADDI4
CNSTI4 3
LSHI4
CNSTI4 32
ADDI4
CNSTI4 56
ADDI4
ASGNI4
line 1109
;1107:
;1108:#if 1	// JUHOX: make more room for health & armor if needed
;1109:	if (cgs.baseHealth >= 500) {
ADDRGP4 cgs+31828
INDIRI4
CNSTI4 500
LTI4 $574
line 1110
;1110:		w += 2 * TINYCHAR_WIDTH;
ADDRLP4 80
ADDRLP4 80
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 1111
;1111:	}
LABELV $574
line 1114
;1112:#endif
;1113:
;1114:	if ( right )
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $577
line 1115
;1115:		x = 640 - w;
ADDRLP4 56
CNSTI4 640
ADDRLP4 80
INDIRI4
SUBI4
ASGNI4
ADDRGP4 $578
JUMPV
LABELV $577
line 1117
;1116:	else
;1117:		x = 0;
ADDRLP4 56
CNSTI4 0
ASGNI4
LABELV $578
line 1119
;1118:
;1119:	h = plyrs * TINYCHAR_HEIGHT;
ADDRLP4 84
ADDRLP4 60
INDIRI4
CNSTI4 3
LSHI4
ASGNI4
line 1121
;1120:
;1121:	if ( upper ) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $579
line 1122
;1122:		ret_y = y + h;
ADDRLP4 88
ADDRFP4 0
INDIRF4
ADDRLP4 84
INDIRI4
CVIF4 4
ADDF4
CVFI4 4
ASGNI4
line 1123
;1123:	} else {
ADDRGP4 $580
JUMPV
LABELV $579
line 1124
;1124:		y -= h;
ADDRFP4 0
ADDRFP4 0
INDIRF4
ADDRLP4 84
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 1125
;1125:		ret_y = y;
ADDRLP4 88
ADDRFP4 0
INDIRF4
CVFI4 4
ASGNI4
line 1126
;1126:	}
LABELV $580
line 1128
;1127:
;1128:	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $581
line 1129
;1129:		hcolor[0] = 1.0f;
ADDRLP4 24
CNSTF4 1065353216
ASGNF4
line 1130
;1130:		hcolor[1] = 0.0f;
ADDRLP4 24+4
CNSTF4 0
ASGNF4
line 1131
;1131:		hcolor[2] = 0.0f;
ADDRLP4 24+8
CNSTF4 0
ASGNF4
line 1132
;1132:		hcolor[3] = 0.33f;
ADDRLP4 24+12
CNSTF4 1051260355
ASGNF4
line 1133
;1133:	} else { // if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE )
ADDRGP4 $582
JUMPV
LABELV $581
line 1134
;1134:		hcolor[0] = 0.0f;
ADDRLP4 24
CNSTF4 0
ASGNF4
line 1135
;1135:		hcolor[1] = 0.0f;
ADDRLP4 24+4
CNSTF4 0
ASGNF4
line 1136
;1136:		hcolor[2] = 1.0f;
ADDRLP4 24+8
CNSTF4 1065353216
ASGNF4
line 1137
;1137:		hcolor[3] = 0.33f;
ADDRLP4 24+12
CNSTF4 1051260355
ASGNF4
line 1138
;1138:	}
LABELV $582
line 1139
;1139:	trap_R_SetColor( hcolor );
ADDRLP4 24
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1140
;1140:	CG_DrawPic( x, y, w, h, cgs.media.teamStatusBar );
ADDRLP4 56
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 80
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 84
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 cgs+751220+180
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1141
;1141:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1143
;1142:
;1143:	for (i = 0; i < count; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $595
JUMPV
LABELV $592
line 1144
;1144:		ci = cgs.clientinfo + sortedTeamPlayers[i];
ADDRLP4 4
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sortedTeamPlayers
ADDP4
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320
ADDP4
ASGNP4
line 1145
;1145:		if ( ci->infoValid && ci->team == cg.snap->ps.persistant[PERS_TEAM]) {
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $597
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
NEI4 $597
line 1147
;1146:
;1147:			hcolor[0] = hcolor[1] = hcolor[2] = hcolor[3] = 1.0;
ADDRLP4 100
CNSTF4 1065353216
ASGNF4
ADDRLP4 24+12
ADDRLP4 100
INDIRF4
ASGNF4
ADDRLP4 24+8
ADDRLP4 100
INDIRF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 100
INDIRF4
ASGNF4
ADDRLP4 24
ADDRLP4 100
INDIRF4
ASGNF4
line 1149
;1148:
;1149:			xx = x + TINYCHAR_WIDTH;
ADDRLP4 12
ADDRLP4 56
INDIRI4
CNSTI4 8
ADDI4
ASGNI4
line 1151
;1150:
;1151:			CG_DrawStringExt( xx, y,
ADDRLP4 12
INDIRI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 24
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
CNSTI4 8
ARGI4
CNSTI4 12
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 1156
;1152:				ci->name, hcolor, qfalse, qfalse,
;1153:				TINYCHAR_WIDTH, TINYCHAR_HEIGHT, TEAM_OVERLAY_MAXNAME_WIDTH);
;1154:
;1155:#if 1	// JUHOX: draw the group mark
;1156:			if (ci->group >= 0 && ci->health > 0 && ci->location >= 0) {
ADDRLP4 4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
LTI4 $603
ADDRLP4 4
INDIRP4
CNSTI4 128
ADDP4
INDIRI4
CNSTI4 0
LEI4 $603
ADDRLP4 4
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
CNSTI4 0
LTI4 $603
line 1158
;1157:				char buf[4];
;1158:				const vec4_t leaderColor = {1, 0.7, 0, 1};
ADDRLP4 116
ADDRGP4 $605
INDIRB
ASGNB 16
line 1159
;1159:				const vec4_t retreatingColor = {0.5, 0.5, 0.5, 1};
ADDRLP4 132
ADDRGP4 $606
INDIRB
ASGNB 16
line 1162
;1160:				const float* color;
;1161:
;1162:				buf[0] = ci->group + 'A';
ADDRLP4 108
ADDRLP4 4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 65
ADDI4
CVII1 4
ASGNI1
line 1163
;1163:				buf[1] = 0;
ADDRLP4 108+1
CNSTI1 0
ASGNI1
line 1164
;1164:				switch (ci->memberStatus) {
ADDRLP4 148
ADDRLP4 4
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
LTI4 $608
ADDRLP4 148
INDIRI4
CNSTI4 4
GTI4 $608
ADDRLP4 148
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $614
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $614
address $612
address $613
address $613
address $611
address $611
code
LABELV $611
line 1167
;1165:				case TSSGMS_designatedLeader:
;1166:				case TSSGMS_temporaryLeader:
;1167:					color = leaderColor;
ADDRLP4 112
ADDRLP4 116
ASGNP4
line 1168
;1168:					break;
ADDRGP4 $609
JUMPV
LABELV $612
LABELV $608
line 1171
;1169:				case TSSGMS_retreating:
;1170:				default:
;1171:					color = retreatingColor;
ADDRLP4 112
ADDRLP4 132
ASGNP4
line 1172
;1172:					break;
ADDRGP4 $609
JUMPV
LABELV $613
line 1175
;1173:				case TSSGMS_temporaryFighter:
;1174:				case TSSGMS_designatedFighter:
;1175:					color = hcolor;
ADDRLP4 112
ADDRLP4 24
ASGNP4
line 1176
;1176:					break;
LABELV $609
line 1178
;1177:				}
;1178:				xx += (pwidth - 1) * TINYCHAR_WIDTH;
ADDRLP4 12
ADDRLP4 12
INDIRI4
ADDRLP4 52
INDIRI4
CNSTI4 3
LSHI4
CNSTI4 8
SUBI4
ADDI4
ASGNI4
line 1179
;1179:				CG_DrawStringExt(xx, y, buf, color, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
ADDRLP4 12
INDIRI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 108
ARGP4
ADDRLP4 112
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
CNSTI4 8
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 1180
;1180:			}
LABELV $603
line 1187
;1181:#endif
;1182:
;1183:#if 0	// JUHOX: don't draw location for dead players or spectating mission leaders
;1184:			if (lwidth) {
;1185:#else
;1186:#if ESCAPE_MODE
;1187:			if (cgs.gametype == GT_EFH) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 9
NEI4 $615
line 1188
;1188:				p = va("%dm", ci->wayLength);
ADDRGP4 $618
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
ARGI4
ADDRLP4 108
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 108
INDIRP4
ASGNP4
line 1189
;1189:				len = strlen(p);
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 112
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 112
INDIRI4
ASGNI4
line 1190
;1190:				xx = x + TINYCHAR_WIDTH * 2 + TINYCHAR_WIDTH * pwidth + (lwidth - len) * TINYCHAR_WIDTH;
ADDRLP4 12
ADDRLP4 56
INDIRI4
CNSTI4 16
ADDI4
ADDRLP4 52
INDIRI4
CNSTI4 3
LSHI4
ADDI4
ADDRLP4 44
INDIRI4
ADDRLP4 40
INDIRI4
SUBI4
CNSTI4 3
LSHI4
ADDI4
ASGNI4
line 1191
;1191:				CG_DrawStringExt(xx, y, p, hcolor, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, lwidth);
ADDRLP4 12
INDIRI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 24
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
CNSTI4 8
ARGI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 1192
;1192:			}
ADDRGP4 $616
JUMPV
LABELV $615
line 1195
;1193:			else
;1194:#endif
;1195:			if (lwidth && ci->health > 0 && ci->location >= 0) {
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $619
ADDRLP4 4
INDIRP4
CNSTI4 128
ADDP4
INDIRI4
CNSTI4 0
LEI4 $619
ADDRLP4 4
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
CNSTI4 0
LTI4 $619
line 1197
;1196:#endif
;1197:				p = CG_ConfigString(CS_LOCATIONS + ci->location);
ADDRLP4 4
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
CNSTI4 608
ADDI4
ARGI4
ADDRLP4 112
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 112
INDIRP4
ASGNP4
line 1198
;1198:				if (!p || !*p)
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $623
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $621
LABELV $623
line 1199
;1199:					p = "unknown";
ADDRLP4 20
ADDRGP4 $624
ASGNP4
LABELV $621
line 1200
;1200:				len = CG_DrawStrlen(p);
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 120
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 120
INDIRI4
ASGNI4
line 1201
;1201:				if (len > lwidth)
ADDRLP4 40
INDIRI4
ADDRLP4 44
INDIRI4
LEI4 $625
line 1202
;1202:					len = lwidth;
ADDRLP4 40
ADDRLP4 44
INDIRI4
ASGNI4
LABELV $625
line 1206
;1203:
;1204://				xx = x + TINYCHAR_WIDTH * 2 + TINYCHAR_WIDTH * pwidth +
;1205://					((lwidth/2 - len/2) * TINYCHAR_WIDTH);
;1206:				xx = x + TINYCHAR_WIDTH * 2 + TINYCHAR_WIDTH * pwidth;
ADDRLP4 12
ADDRLP4 56
INDIRI4
CNSTI4 16
ADDI4
ADDRLP4 52
INDIRI4
CNSTI4 3
LSHI4
ADDI4
ASGNI4
line 1207
;1207:				CG_DrawStringExt( xx, y,
ADDRLP4 12
INDIRI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 24
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
CNSTI4 8
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 1210
;1208:					p, hcolor, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT,
;1209:					TEAM_OVERLAY_MAXLOCATION_WIDTH);
;1210:			}
LABELV $619
LABELV $616
line 1235
;1211:
;1212:#if 0	// JUHOX: new health, armor, & weapon drawing in team overlay
;1213:			CG_GetColorForHealth( ci->health, ci->armor, hcolor );
;1214:
;1215:			Com_sprintf (st, sizeof(st), "%3i %3i", ci->health,	ci->armor);
;1216:
;1217:			xx = x + TINYCHAR_WIDTH * 3 +
;1218:				TINYCHAR_WIDTH * pwidth + TINYCHAR_WIDTH * lwidth;
;1219:
;1220:			CG_DrawStringExt( xx, y,
;1221:				st, hcolor, qfalse, qfalse,
;1222:				TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0 );
;1223:
;1224:			// draw weapon icon
;1225:			xx += TINYCHAR_WIDTH * 3;
;1226:
;1227:			if ( cg_weapons[ci->curWeapon].weaponIcon ) {
;1228:				CG_DrawPic( xx, y, TINYCHAR_WIDTH, TINYCHAR_HEIGHT,
;1229:					cg_weapons[ci->curWeapon].weaponIcon );
;1230:			} else {
;1231:				CG_DrawPic( xx, y, TINYCHAR_WIDTH, TINYCHAR_HEIGHT,
;1232:					cgs.media.deferShader );
;1233:			}
;1234:#else
;1235:			if (ci->location >= 0) {
ADDRLP4 4
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
CNSTI4 0
LTI4 $627
line 1236
;1236:				xx = x + TINYCHAR_WIDTH * 3 +
ADDRLP4 12
ADDRLP4 56
INDIRI4
CNSTI4 24
ADDI4
ADDRLP4 52
INDIRI4
CNSTI4 3
LSHI4
ADDI4
ADDRLP4 44
INDIRI4
CNSTI4 3
LSHI4
ADDI4
ASGNI4
line 1239
;1237:					TINYCHAR_WIDTH * pwidth + TINYCHAR_WIDTH * lwidth;
;1238:
;1239:				CG_GetColorForHealth(ci->health, ci->armor, (cgs.baseHealth * ci->handicap) / 100, hcolor);
ADDRLP4 4
INDIRP4
CNSTI4 128
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 132
ADDP4
INDIRI4
ARGI4
ADDRGP4 cgs+31828
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
MULI4
CNSTI4 100
DIVI4
ARGI4
ADDRLP4 24
ARGP4
ADDRGP4 CG_GetColorForHealth
CALLV
pop
line 1241
;1240:
;1241:				if (cgs.baseHealth >= 500) {
ADDRGP4 cgs+31828
INDIRI4
CNSTI4 500
LTI4 $630
line 1242
;1242:					Com_sprintf(st, sizeof(st), "%4i %4i", ci->health, ci->armor);
ADDRLP4 64
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $633
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 128
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 132
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1243
;1243:					CG_DrawStringExt(xx, y, st, hcolor, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
ADDRLP4 12
INDIRI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 64
ARGP4
ADDRLP4 24
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
CNSTI4 8
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 1244
;1244:					xx += TINYCHAR_WIDTH * 4;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 32
ADDI4
ASGNI4
line 1245
;1245:				}
ADDRGP4 $631
JUMPV
LABELV $630
line 1246
;1246:				else {
line 1247
;1247:					Com_sprintf(st, sizeof(st), "%3i %3i", ci->health, ci->armor);
ADDRLP4 64
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $634
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 128
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 132
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1248
;1248:					CG_DrawStringExt(xx, y, st, hcolor, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
ADDRLP4 12
INDIRI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 64
ARGP4
ADDRLP4 24
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
CNSTI4 8
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 1249
;1249:					xx += TINYCHAR_WIDTH * 3;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 24
ADDI4
ASGNI4
line 1250
;1250:				}
LABELV $631
line 1254
;1251:
;1252:
;1253:				// draw weapon icon
;1254:				if ( cg_weapons[ci->curWeapon].weaponIcon ) {
ADDRLP4 4
INDIRP4
CNSTI4 136
ADDP4
INDIRI4
CNSTI4 136
MULI4
ADDRGP4 cg_weapons+68
ADDP4
INDIRI4
CNSTI4 0
EQI4 $635
line 1255
;1255:					CG_DrawPic( xx, y, TINYCHAR_WIDTH, TINYCHAR_HEIGHT,
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
CNSTF4 1090519040
ARGF4
CNSTF4 1090519040
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 136
ADDP4
INDIRI4
CNSTI4 136
MULI4
ADDRGP4 cg_weapons+68
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1257
;1256:						cg_weapons[ci->curWeapon].weaponIcon );
;1257:				} else {
ADDRGP4 $636
JUMPV
LABELV $635
line 1258
;1258:					CG_DrawPic( xx, y, TINYCHAR_WIDTH, TINYCHAR_HEIGHT,
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
CNSTF4 1090519040
ARGF4
CNSTF4 1090519040
ARGF4
ADDRGP4 cgs+751220+184
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1260
;1259:						cgs.media.deferShader );
;1260:				}
LABELV $636
line 1261
;1261:			}
LABELV $627
line 1265
;1262:#endif
;1263:
;1264:			// Draw powerup icons
;1265:			if (right) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $641
line 1266
;1266:				xx = x;
ADDRLP4 12
ADDRLP4 56
INDIRI4
ASGNI4
line 1267
;1267:			} else {
ADDRGP4 $642
JUMPV
LABELV $641
line 1268
;1268:				xx = x + w - TINYCHAR_WIDTH;
ADDRLP4 12
ADDRLP4 56
INDIRI4
ADDRLP4 80
INDIRI4
ADDI4
CNSTI4 8
SUBI4
ASGNI4
line 1269
;1269:			}
LABELV $642
line 1271
;1270:#if 1	// JUHOX: draw fight-in-progress icon
;1271:			if (ci->pfmi & PFMI_FIGHTING) {
ADDRLP4 4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $643
line 1272
;1272:				if (cg.time % 1200 < 900) {
ADDRGP4 cg+107656
INDIRI4
CNSTI4 1200
MODI4
CNSTI4 900
GEI4 $645
line 1273
;1273:					CG_DrawPic(xx, y, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, cgs.media.fightInProgressShader);
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
CNSTF4 1090519040
ARGF4
CNSTF4 1090519040
ARGF4
ADDRGP4 cgs+751220+328
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1274
;1274:				}
LABELV $645
line 1275
;1275:				xx += right? -TINYCHAR_WIDTH : TINYCHAR_WIDTH;
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $651
ADDRLP4 112
CNSTI4 -8
ASGNI4
ADDRGP4 $652
JUMPV
LABELV $651
ADDRLP4 112
CNSTI4 8
ASGNI4
LABELV $652
ADDRLP4 12
ADDRLP4 12
INDIRI4
ADDRLP4 112
INDIRI4
ADDI4
ASGNI4
line 1276
;1276:			}
LABELV $643
line 1278
;1277:#endif
;1278:			for (j = /*0*/1; j </*=*/ PW_NUM_POWERUPS; j++) {	// JUHOX
ADDRLP4 0
CNSTI4 1
ASGNI4
LABELV $653
line 1281
;1279:#if 1	// JUHOX: don't draw the misused powerups
;1280:				if (
;1281:					j == PW_INVIS ||
ADDRLP4 0
INDIRI4
CNSTI4 4
EQI4 $662
ADDRLP4 0
INDIRI4
CNSTI4 2
EQI4 $662
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $662
ADDRLP4 0
INDIRI4
CNSTI4 3
EQI4 $662
ADDRLP4 0
INDIRI4
CNSTI4 12
NEI4 $657
LABELV $662
line 1286
;1282:					j == PW_BATTLESUIT ||
;1283:					j == PW_QUAD ||
;1284:					j == PW_HASTE ||
;1285:					j == PW_BFG_RELOADING
;1286:				) {
line 1287
;1287:					continue;
ADDRGP4 $654
JUMPV
LABELV $657
line 1290
;1288:				}
;1289:#endif
;1290:				if (ci->powerups & (1 << j)) {
ADDRLP4 4
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $663
line 1292
;1291:
;1292:					item = BG_FindItemForPowerup( j );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 116
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 116
INDIRP4
ASGNP4
line 1294
;1293:
;1294:					if (item) {
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $665
line 1295
;1295:						CG_DrawPic( xx, y, TINYCHAR_WIDTH, TINYCHAR_HEIGHT,
ADDRLP4 16
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 120
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
CNSTF4 1090519040
ARGF4
CNSTF4 1090519040
ARGF4
ADDRLP4 120
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1297
;1296:						trap_R_RegisterShader( item->icon ) );
;1297:						if (right) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $667
line 1298
;1298:							xx -= TINYCHAR_WIDTH;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 8
SUBI4
ASGNI4
line 1299
;1299:						} else {
ADDRGP4 $668
JUMPV
LABELV $667
line 1300
;1300:							xx += TINYCHAR_WIDTH;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 8
ADDI4
ASGNI4
line 1301
;1301:						}
LABELV $668
line 1302
;1302:					}
LABELV $665
line 1303
;1303:				}
LABELV $663
line 1304
;1304:			}
LABELV $654
line 1278
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 13
LTI4 $653
line 1306
;1305:
;1306:			y += TINYCHAR_HEIGHT;
ADDRFP4 0
ADDRFP4 0
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 1307
;1307:		}
LABELV $597
line 1308
;1308:	}
LABELV $593
line 1143
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $595
ADDRLP4 8
INDIRI4
ADDRLP4 48
INDIRI4
LTI4 $592
line 1310
;1309:
;1310:	return ret_y;
ADDRLP4 88
INDIRI4
CVIF4 4
RETF4
LABELV $533
endproc CG_DrawTeamOverlay 156 36
proc CG_DrawUpperRight 8 16
line 1321
;1311://#endif
;1312:}
;1313:
;1314:
;1315:/*
;1316:=====================
;1317:CG_DrawUpperRight
;1318:
;1319:=====================
;1320:*/
;1321:static void CG_DrawUpperRight( void ) {
line 1324
;1322:	float	y;
;1323:
;1324:	y = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 1327
;1325:
;1326:#if MAPLENSFLARES	// JUHOX: draw lens flare editor title
;1327:	if (cgs.editMode == EM_mlf) {
ADDRGP4 cgs+31684
INDIRI4
CNSTI4 1
NEI4 $670
line 1328
;1328:		CG_DrawBigString(640 - 17 * BIGCHAR_WIDTH, y, "lens flare editor", 1);
CNSTI4 368
ARGI4
ADDRLP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 $673
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1329
;1329:		y += BIGCHAR_HEIGHT;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 1330
;1330:	}
LABELV $670
line 1333
;1331:#endif
;1332:
;1333:	if ( cgs.gametype >= GT_TEAM && cg_drawTeamOverlay.integer == 1 ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $674
ADDRGP4 cg_drawTeamOverlay+12
INDIRI4
CNSTI4 1
NEI4 $674
line 1334
;1334:		y = CG_DrawTeamOverlay( y, qtrue, qtrue );
ADDRLP4 0
INDIRF4
ARGF4
CNSTI4 1
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 4
ADDRGP4 CG_DrawTeamOverlay
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 1335
;1335:	}
LABELV $674
line 1336
;1336:	if ( cg_drawSnapshot.integer ) {
ADDRGP4 cg_drawSnapshot+12
INDIRI4
CNSTI4 0
EQI4 $678
line 1337
;1337:		y = CG_DrawSnapshot( y );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 CG_DrawSnapshot
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 1338
;1338:	}
LABELV $678
line 1341
;1339:#if MONSTER_MODE	// JUHOX: draw current number of monsters
;1340:	if (
;1341:		cg_drawNumMonsters.integer &&
ADDRGP4 cg_drawNumMonsters+12
INDIRI4
CNSTI4 0
EQI4 $681
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 8
GEI4 $686
ADDRGP4 cgs+31852
INDIRI4
CNSTI4 0
EQI4 $681
LABELV $686
line 1346
;1342:		(
;1343:			cgs.gametype >= GT_STU ||
;1344:			cgs.monsterLauncher
;1345:		)
;1346:	) {
line 1347
;1347:		y = CG_DrawNumMonsters(y);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 CG_DrawNumMonsters
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 1348
;1348:	}
LABELV $681
line 1351
;1349:#endif
;1350:#if ESCAPE_MODE	// JUHOX: draw current segment
;1351:	if (cgs.gametype == GT_EFH && cg_drawSegment.integer) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 9
NEI4 $687
ADDRGP4 cg_drawSegment+12
INDIRI4
CNSTI4 0
EQI4 $687
line 1352
;1352:		y = CG_DrawSegment(y);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 CG_DrawSegment
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 1353
;1353:	}
LABELV $687
line 1355
;1354:#endif
;1355:	if ( cg_drawFPS.integer ) {
ADDRGP4 cg_drawFPS+12
INDIRI4
CNSTI4 0
EQI4 $691
line 1356
;1356:		y = CG_DrawFPS( y );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 CG_DrawFPS
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 1357
;1357:	}
LABELV $691
line 1358
;1358:	if ( cg_drawTimer.integer ) {
ADDRGP4 cg_drawTimer+12
INDIRI4
CNSTI4 0
EQI4 $694
line 1359
;1359:		y = CG_DrawTimer( y );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 CG_DrawTimer
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 1360
;1360:	}
LABELV $694
line 1362
;1361:#if 1	// JUHOX: draw weapon limit
;1362:	if (cgs.weaponLimit > 0) {
ADDRGP4 cgs+31844
INDIRI4
CNSTI4 0
LEI4 $697
line 1363
;1363:		y = CG_DrawWeaponLimit(y);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 CG_DrawWeaponLimit
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 1364
;1364:	}
LABELV $697
line 1366
;1365:#endif
;1366:	if ( cg_drawAttacker.integer ) {
ADDRGP4 cg_drawAttacker+12
INDIRI4
CNSTI4 0
EQI4 $700
line 1367
;1367:		y = CG_DrawAttacker( y );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 CG_DrawAttacker
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 1368
;1368:	}
LABELV $700
line 1370
;1369:
;1370:}
LABELV $669
endproc CG_DrawUpperRight 8 16
proc CG_DrawScores 128 20
line 1388
;1371:
;1372:/*
;1373:===========================================================================================
;1374:
;1375:  LOWER RIGHT CORNER
;1376:
;1377:===========================================================================================
;1378:*/
;1379:
;1380:/*
;1381:=================
;1382:CG_DrawScores
;1383:
;1384:Draw the small two score display
;1385:=================
;1386:*/
;1387:#ifndef MISSIONPACK
;1388:static float CG_DrawScores( float y ) {
line 1397
;1389:	const char	*s;
;1390:	int			s1, s2, score;
;1391:	int			x, w;
;1392:	int			v;
;1393:	vec4_t		color;
;1394:	float		y1;
;1395:	gitem_t		*item;
;1396:
;1397:	s1 = cgs.scores1;
ADDRLP4 32
ADDRGP4 cgs+35124
INDIRI4
ASGNI4
line 1398
;1398:	s2 = cgs.scores2;
ADDRLP4 36
ADDRGP4 cgs+35128
INDIRI4
ASGNI4
line 1400
;1399:
;1400:	y -=  BIGCHAR_HEIGHT + 8;
ADDRFP4 0
ADDRFP4 0
INDIRF4
CNSTF4 1103101952
SUBF4
ASGNF4
line 1402
;1401:
;1402:	y1 = y;
ADDRLP4 28
ADDRFP4 0
INDIRF4
ASGNF4
line 1407
;1403:
;1404:	// draw from the right side to left
;1405:	// JUHOX: draw STU scores
;1406:#if MONSTER_MODE
;1407:	if (cgs.gametype >= GT_STU) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 8
LTI4 $706
line 1408
;1408:		const int iconsize = BIGCHAR_HEIGHT;
ADDRLP4 52
CNSTI4 16
ASGNI4
line 1410
;1409:
;1410:		x = 640;
ADDRLP4 0
CNSTI4 640
ASGNI4
line 1413
;1411:
;1412:#if ESCAPE_MODE
;1413:		if (cgs.gametype == GT_EFH && cgs.debugEFH) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 9
NEI4 $709
ADDRGP4 cgs+31864
INDIRI4
CNSTI4 0
EQI4 $709
line 1414
;1414:			s = CG_ConfigString(CS_EFH_DEBUG);
CNSTI4 720
ARGI4
ADDRLP4 56
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 56
INDIRP4
ASGNP4
line 1415
;1415:			w = CG_DrawStrlen(s) * BIGCHAR_WIDTH;
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 60
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 1416
;1416:			x -= w;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ASGNI4
line 1417
;1417:			CG_DrawBigString(x, y, s, 1);
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1418
;1418:		}
LABELV $709
line 1421
;1419:#endif
;1420:
;1421:		if (cgs.artefacts > 0) {
ADDRGP4 cgs+31848
INDIRI4
CNSTI4 0
LEI4 $713
line 1422
;1422:			if (cgs.artefacts < 999) {
ADDRGP4 cgs+31848
INDIRI4
CNSTI4 999
GEI4 $716
line 1423
;1423:				s = va("%i", cgs.artefacts - cgs.scores1);
ADDRGP4 $161
ARGP4
ADDRGP4 cgs+31848
INDIRI4
ADDRGP4 cgs+35124
INDIRI4
SUBI4
ARGI4
ADDRLP4 56
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 56
INDIRP4
ASGNP4
line 1424
;1424:			}
ADDRGP4 $717
JUMPV
LABELV $716
line 1425
;1425:			else {
line 1426
;1426:				s = va("%i", cgs.scores1);
ADDRGP4 $161
ARGP4
ADDRGP4 cgs+35124
INDIRI4
ARGI4
ADDRLP4 56
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 56
INDIRP4
ASGNP4
line 1427
;1427:			}
LABELV $717
line 1428
;1428:			w = CG_DrawStrlen(s) * BIGCHAR_WIDTH;
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 56
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 1429
;1429:			x -= w;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ASGNI4
line 1430
;1430:			CG_DrawBigString(x, y, s, 1);
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1432
;1431:
;1432:			x -= iconsize;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 52
INDIRI4
SUBI4
ASGNI4
line 1433
;1433:			CG_DrawPic(x, y, iconsize, iconsize, cgs.media.artefactsShader);
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 60
ADDRLP4 52
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRGP4 cgs+751220+332
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1435
;1434:
;1435:			x -= iconsize;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 52
INDIRI4
SUBI4
ASGNI4
line 1436
;1436:			if (cg.detectorBeepTime > cg.time - 100) {
ADDRGP4 cg+112468
INDIRI4
ADDRGP4 cg+107656
INDIRI4
CNSTI4 100
SUBI4
LEI4 $724
line 1437
;1437:				CG_DrawPic(x, y, iconsize, iconsize, cgs.media.detectorShader);
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 64
ADDRLP4 52
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRGP4 cgs+751220+344
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1438
;1438:			}
LABELV $724
line 1440
;1439:
;1440:			x -= iconsize;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 52
INDIRI4
SUBI4
ASGNI4
line 1441
;1441:		}
LABELV $713
line 1443
;1442:
;1443:		if (cgs.fraglimit > 0) {
ADDRGP4 cgs+31468
INDIRI4
CNSTI4 0
LEI4 $730
line 1444
;1444:			s = va("%i", cgs.fraglimit - cgs.scores2);
ADDRGP4 $161
ARGP4
ADDRGP4 cgs+31468
INDIRI4
ADDRGP4 cgs+35128
INDIRI4
SUBI4
ARGI4
ADDRLP4 56
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 56
INDIRP4
ASGNP4
line 1445
;1445:			w = CG_DrawStrlen(s) * BIGCHAR_WIDTH;
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 60
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 1446
;1446:			x -= w;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ASGNI4
line 1447
;1447:			CG_DrawBigString(x, y, s, 1);
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1449
;1448:
;1449:			x -= iconsize;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 52
INDIRI4
SUBI4
ASGNI4
line 1450
;1450:			CG_DrawPic(x, y, iconsize, iconsize, cgs.media.lifesShader);
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 64
ADDRLP4 52
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRGP4 cgs+751220+336
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1452
;1451:
;1452:			x -= iconsize;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 52
INDIRI4
SUBI4
ASGNI4
line 1453
;1453:		}
LABELV $730
line 1455
;1454:
;1455:		if (cgs.timelimit > 0) {
ADDRGP4 cgs+31476
INDIRI4
CNSTI4 0
LEI4 $737
line 1460
;1456:			int msec;
;1457:			int secs;
;1458:			int mins;
;1459:
;1460:			msec = 60000 * cgs.timelimit - (cg.time - cgs.levelStartTime);
ADDRLP4 56
ADDRGP4 cgs+31476
INDIRI4
CNSTI4 60000
MULI4
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cgs+35120
INDIRI4
SUBI4
SUBI4
ASGNI4
line 1463
;1461:
;1462:#if ESCAPE_MODE
;1463:			{
line 1466
;1464:				int limit;
;1465:
;1466:				limit = atoi(CG_ConfigString(CS_EFH_GOAL_DISTANCE));
CNSTI4 718
ARGI4
ADDRLP4 72
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRLP4 76
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 68
ADDRLP4 76
INDIRI4
ASGNI4
line 1467
;1467:				if (limit > 0 && cgs.distanceLimit > 0) {
ADDRLP4 68
INDIRI4
CNSTI4 0
LEI4 $743
ADDRGP4 cgs+31860
INDIRI4
CNSTI4 0
LEI4 $743
line 1468
;1468:					msec += (60000 * (limit - cgs.distanceLimit) * cgs.timelimit) / cgs.distanceLimit;
ADDRLP4 56
ADDRLP4 56
INDIRI4
ADDRLP4 68
INDIRI4
ADDRGP4 cgs+31860
INDIRI4
SUBI4
CNSTI4 60000
MULI4
ADDRGP4 cgs+31476
INDIRI4
MULI4
ADDRGP4 cgs+31860
INDIRI4
DIVI4
ADDI4
ASGNI4
line 1469
;1469:				}
LABELV $743
line 1470
;1470:			}
line 1473
;1471:#endif
;1472:
;1473:			if (msec < 0) msec = 0;
ADDRLP4 56
INDIRI4
CNSTI4 0
GEI4 $749
ADDRLP4 56
CNSTI4 0
ASGNI4
LABELV $749
line 1474
;1474:			mins = msec / 60000;
ADDRLP4 64
ADDRLP4 56
INDIRI4
CNSTI4 60000
DIVI4
ASGNI4
line 1475
;1475:			secs = (msec % 60000) / 1000;
ADDRLP4 60
ADDRLP4 56
INDIRI4
CNSTI4 60000
MODI4
CNSTI4 1000
DIVI4
ASGNI4
line 1477
;1476:
;1477:			s = va("%i:%02i", mins, secs);
ADDRGP4 $751
ARGP4
ADDRLP4 64
INDIRI4
ARGI4
ADDRLP4 60
INDIRI4
ARGI4
ADDRLP4 68
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 68
INDIRP4
ASGNP4
line 1478
;1478:			w = CG_DrawStrlen(s) * BIGCHAR_WIDTH;
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 72
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 72
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 1479
;1479:			x -= w;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ASGNI4
line 1480
;1480:			CG_DrawBigString(x, y, s, 1);
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1482
;1481:
;1482:			x -= iconsize;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 52
INDIRI4
SUBI4
ASGNI4
line 1486
;1483:#if !ESCAPE_MODE
;1484:			CG_DrawPic(x, y, iconsize, iconsize, cgs.media.clockShader);
;1485:#else
;1486:			if (cgs.gametype == GT_EFH) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 9
NEI4 $752
line 1487
;1487:				if (msec > 10000) {
ADDRLP4 56
INDIRI4
CNSTI4 10000
LEI4 $755
line 1488
;1488:					CG_DrawPic(x, y, iconsize, iconsize, cgs.media.clockShader);
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 76
ADDRLP4 52
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 76
INDIRF4
ARGF4
ADDRLP4 76
INDIRF4
ARGF4
ADDRGP4 cgs+751220+340
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1489
;1489:				}
ADDRGP4 $753
JUMPV
LABELV $755
line 1490
;1490:				else {
line 1491
;1491:					if (cg.time % 700 < 450) {
ADDRGP4 cg+107656
INDIRI4
CNSTI4 700
MODI4
CNSTI4 450
GEI4 $759
line 1492
;1492:						CG_DrawPic(x, y, iconsize, iconsize, cgs.media.clockShader);
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 76
ADDRLP4 52
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 76
INDIRF4
ARGF4
ADDRLP4 76
INDIRF4
ARGF4
ADDRGP4 cgs+751220+340
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1493
;1493:					}
LABELV $759
line 1494
;1494:					if (secs != cg.countDown) {
ADDRLP4 60
INDIRI4
ADDRGP4 cg+107624
INDIRI4
EQI4 $764
line 1495
;1495:						trap_S_StartLocalSound(cgs.media.respawnWarnSound, CHAN_ANNOUNCER);
ADDRGP4 cgs+751220+1056
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 1496
;1496:					}
LABELV $764
line 1497
;1497:					cg.countDown = secs;
ADDRGP4 cg+107624
ADDRLP4 60
INDIRI4
ASGNI4
line 1498
;1498:				}
line 1499
;1499:			}
ADDRGP4 $753
JUMPV
LABELV $752
line 1500
;1500:			else {
line 1501
;1501:				CG_DrawPic(x, y, iconsize, iconsize, cgs.media.clockShader);
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 76
ADDRLP4 52
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 76
INDIRF4
ARGF4
ADDRLP4 76
INDIRF4
ARGF4
ADDRGP4 cgs+751220+340
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1502
;1502:			}
LABELV $753
line 1504
;1503:#endif
;1504:		}
LABELV $737
line 1507
;1505:
;1506:#if ESCAPE_MODE
;1507:		if (cgs.gametype == GT_EFH) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 9
NEI4 $772
line 1512
;1508:			long dist;
;1509:			long limit;
;1510:			vec4_t color;
;1511:
;1512:			y -= BIGCHAR_HEIGHT;
ADDRFP4 0
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 1513
;1513:			y1 = y;
ADDRLP4 28
ADDRFP4 0
INDIRF4
ASGNF4
line 1514
;1514:			x = 640;
ADDRLP4 0
CNSTI4 640
ASGNI4
line 1516
;1515:
;1516:			dist = atoi(CG_ConfigString(CS_EFH_COVERED_DISTANCE));
CNSTI4 722
ARGI4
ADDRLP4 80
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 80
INDIRP4
ARGP4
ADDRLP4 84
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 56
ADDRLP4 84
INDIRI4
ASGNI4
line 1517
;1517:			limit = atoi(CG_ConfigString(CS_EFH_GOAL_DISTANCE));
CNSTI4 718
ARGI4
ADDRLP4 88
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRLP4 92
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 76
ADDRLP4 92
INDIRI4
ASGNI4
line 1518
;1518:			if (limit <= 0) {
ADDRLP4 76
INDIRI4
CNSTI4 0
GTI4 $775
line 1519
;1519:				limit = cgs.distanceLimit;
ADDRLP4 76
ADDRGP4 cgs+31860
INDIRI4
ASGNI4
line 1520
;1520:			}
LABELV $775
line 1522
;1521:
;1522:			color[0] = 1;
ADDRLP4 60
CNSTF4 1065353216
ASGNF4
line 1523
;1523:			color[1] = 1;
ADDRLP4 60+4
CNSTF4 1065353216
ASGNF4
line 1524
;1524:			color[2] = 1;
ADDRLP4 60+8
CNSTF4 1065353216
ASGNF4
line 1525
;1525:			color[3] = 1;
ADDRLP4 60+12
CNSTF4 1065353216
ASGNF4
line 1527
;1526:
;1527:			if (limit > 0) {
ADDRLP4 76
INDIRI4
CNSTI4 0
LEI4 $781
line 1530
;1528:				float timelimit;
;1529:
;1530:				dist = limit - dist;
ADDRLP4 56
ADDRLP4 76
INDIRI4
ADDRLP4 56
INDIRI4
SUBI4
ASGNI4
line 1531
;1531:				timelimit = cgs.timelimit;
ADDRLP4 96
ADDRGP4 cgs+31476
INDIRI4
CVIF4 4
ASGNF4
line 1532
;1532:				if (timelimit <= 0 && cgs.recordType == GC_speed && cgs.record > 0) {
ADDRLP4 96
INDIRF4
CNSTF4 0
GTF4 $784
ADDRGP4 cgs+31680
INDIRI4
CNSTI4 4
NEI4 $784
ADDRGP4 cgs+31676
INDIRI4
CNSTI4 0
LEI4 $784
line 1533
;1533:					timelimit = (float)limit / (0.001 * cgs.record);
ADDRLP4 96
ADDRLP4 76
INDIRI4
CVIF4 4
ADDRGP4 cgs+31676
INDIRI4
CVIF4 4
CNSTF4 981668463
MULF4
DIVF4
ASGNF4
line 1534
;1534:				}
LABELV $784
line 1536
;1535:
;1536:				if (timelimit > 0) {
ADDRLP4 96
INDIRF4
CNSTF4 0
LEF4 $789
line 1544
;1537:					float extraTime;
;1538:					float remainingTime;
;1539:					float avgDist;
;1540:					float maxDeviation;
;1541:					float loLimit;
;1542:					float hiLimit;
;1543:
;1544:					extraTime = 0;
ADDRLP4 108
CNSTF4 0
ASGNF4
line 1545
;1545:					if (cgs.distanceLimit > 0 && cgs.timelimit > 0) {
ADDRGP4 cgs+31860
INDIRI4
CNSTI4 0
LEI4 $791
ADDRGP4 cgs+31476
INDIRI4
CNSTI4 0
LEI4 $791
line 1546
;1546:						extraTime = (float)((limit - cgs.distanceLimit) * timelimit) / (float)(cgs.distanceLimit);
ADDRLP4 108
ADDRLP4 76
INDIRI4
ADDRGP4 cgs+31860
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 96
INDIRF4
MULF4
ADDRGP4 cgs+31860
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 1547
;1547:					}
LABELV $791
line 1548
;1548:					remainingTime = 60.0 * (timelimit + extraTime) - 0.001 * (cg.time - cgs.levelStartTime);
ADDRLP4 116
ADDRLP4 96
INDIRF4
ADDRLP4 108
INDIRF4
ADDF4
CNSTF4 1114636288
MULF4
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cgs+35120
INDIRI4
SUBI4
CVIF4 4
CNSTF4 981668463
MULF4
SUBF4
ASGNF4
line 1549
;1549:					avgDist = limit * remainingTime / (60.0 * timelimit);
ADDRLP4 100
ADDRLP4 76
INDIRI4
CVIF4 4
ADDRLP4 116
INDIRF4
MULF4
ADDRLP4 96
INDIRF4
CNSTF4 1114636288
MULF4
DIVF4
ASGNF4
line 1550
;1550:					maxDeviation = 0.2 * dist;
ADDRLP4 104
ADDRLP4 56
INDIRI4
CVIF4 4
CNSTF4 1045220557
MULF4
ASGNF4
line 1551
;1551:					loLimit = avgDist - maxDeviation;
ADDRLP4 112
ADDRLP4 100
INDIRF4
ADDRLP4 104
INDIRF4
SUBF4
ASGNF4
line 1552
;1552:					hiLimit = avgDist + maxDeviation;
ADDRLP4 120
ADDRLP4 100
INDIRF4
ADDRLP4 104
INDIRF4
ADDF4
ASGNF4
line 1553
;1553:					if (dist <= loLimit) {
ADDRLP4 56
INDIRI4
CVIF4 4
ADDRLP4 112
INDIRF4
GTF4 $799
line 1555
;1554:						// green
;1555:						color[0] = 0;
ADDRLP4 60
CNSTF4 0
ASGNF4
line 1556
;1556:						color[2] = 0;
ADDRLP4 60+8
CNSTF4 0
ASGNF4
line 1557
;1557:					}
ADDRGP4 $800
JUMPV
LABELV $799
line 1558
;1558:					else if (dist >= hiLimit) {
ADDRLP4 56
INDIRI4
CVIF4 4
ADDRLP4 120
INDIRF4
LTF4 $802
line 1560
;1559:						// red
;1560:						color[1] = 0;
ADDRLP4 60+4
CNSTF4 0
ASGNF4
line 1561
;1561:						color[2] = 0;
ADDRLP4 60+8
CNSTF4 0
ASGNF4
line 1562
;1562:					}
ADDRGP4 $803
JUMPV
LABELV $802
line 1563
;1563:					else if (dist <= avgDist) {
ADDRLP4 56
INDIRI4
CVIF4 4
ADDRLP4 100
INDIRF4
GTF4 $806
line 1565
;1564:						// light green
;1565:						color[0] = color[2] = (dist - loLimit) / maxDeviation;
ADDRLP4 124
ADDRLP4 56
INDIRI4
CVIF4 4
ADDRLP4 112
INDIRF4
SUBF4
ADDRLP4 104
INDIRF4
DIVF4
ASGNF4
ADDRLP4 60+8
ADDRLP4 124
INDIRF4
ASGNF4
ADDRLP4 60
ADDRLP4 124
INDIRF4
ASGNF4
line 1566
;1566:					}
ADDRGP4 $807
JUMPV
LABELV $806
line 1567
;1567:					else {
line 1569
;1568:						// light red
;1569:						color[1] = color[2] = 1 - (dist - avgDist) / maxDeviation;
ADDRLP4 124
CNSTF4 1065353216
ADDRLP4 56
INDIRI4
CVIF4 4
ADDRLP4 100
INDIRF4
SUBF4
ADDRLP4 104
INDIRF4
DIVF4
SUBF4
ASGNF4
ADDRLP4 60+8
ADDRLP4 124
INDIRF4
ASGNF4
ADDRLP4 60+4
ADDRLP4 124
INDIRF4
ASGNF4
line 1570
;1570:					}
LABELV $807
LABELV $803
LABELV $800
line 1571
;1571:				}
LABELV $789
line 1572
;1572:			}
LABELV $781
line 1573
;1573:			if (dist < 0) dist = 0;
ADDRLP4 56
INDIRI4
CNSTI4 0
GEI4 $811
ADDRLP4 56
CNSTI4 0
ASGNI4
LABELV $811
line 1574
;1574:			s = va("%d.%03dkm", dist / 1000, dist % 1000);
ADDRGP4 $813
ARGP4
ADDRLP4 96
ADDRLP4 56
INDIRI4
ASGNI4
ADDRLP4 96
INDIRI4
CNSTI4 1000
DIVI4
ARGI4
ADDRLP4 96
INDIRI4
CNSTI4 1000
MODI4
ARGI4
ADDRLP4 100
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 100
INDIRP4
ASGNP4
line 1575
;1575:			w = CG_DrawStrlen(s) * BIGCHAR_WIDTH;
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 104
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 104
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 1576
;1576:			x -= w;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ASGNI4
line 1577
;1577:			CG_DrawBigStringColor(x, y, s, color);
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 60
ARGP4
ADDRGP4 CG_DrawBigStringColor
CALLV
pop
line 1578
;1578:		}
LABELV $772
line 1581
;1579:#endif
;1580:
;1581:		y -= BIGCHAR_HEIGHT;
ADDRFP4 0
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 1582
;1582:		y1 = y;
ADDRLP4 28
ADDRFP4 0
INDIRF4
ASGNF4
line 1583
;1583:		x = 640;
ADDRLP4 0
CNSTI4 640
ASGNI4
line 1585
;1584:
;1585:		{
line 1589
;1586:			vec4_t color;
;1587:			int score;
;1588:
;1589:			score = atoi(CG_ConfigString(CS_STU_SCORE));
CNSTI4 715
ARGI4
ADDRLP4 76
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRLP4 80
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 72
ADDRLP4 80
INDIRI4
ASGNI4
line 1590
;1590:			color[0] = color[1] = color[2] = color[3] = 1;
ADDRLP4 84
CNSTF4 1065353216
ASGNF4
ADDRLP4 56+12
ADDRLP4 84
INDIRF4
ASGNF4
ADDRLP4 56+8
ADDRLP4 84
INDIRF4
ASGNF4
ADDRLP4 56+4
ADDRLP4 84
INDIRF4
ASGNF4
ADDRLP4 56
ADDRLP4 84
INDIRF4
ASGNF4
line 1592
;1591:			if (
;1592:				cgs.timelimit > 0 &&
ADDRGP4 cgs+31476
INDIRI4
CNSTI4 0
LEI4 $817
ADDRGP4 cgs+31680
INDIRI4
CNSTI4 1
NEI4 $817
ADDRGP4 cgs+31676
INDIRI4
CNSTI4 0
LEI4 $817
line 1595
;1593:				cgs.recordType == GC_score &&
;1594:				cgs.record > 0
;1595:			) {
line 1603
;1596:				float remainingSecs;
;1597:				float estRemScore;
;1598:				float maxDeviation;
;1599:				float loLimit;
;1600:				float hiLimit;
;1601:				float remainingScore;
;1602:
;1603:				remainingSecs = 60.0 * cgs.timelimit - 0.001 * (cg.time - cgs.levelStartTime);
ADDRLP4 104
ADDRGP4 cgs+31476
INDIRI4
CVIF4 4
CNSTF4 1114636288
MULF4
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cgs+35120
INDIRI4
SUBI4
CVIF4 4
CNSTF4 981668463
MULF4
SUBF4
ASGNF4
line 1604
;1604:				estRemScore = cgs.record * remainingSecs / (60.0 * cgs.timelimit);
ADDRLP4 92
ADDRGP4 cgs+31676
INDIRI4
CVIF4 4
ADDRLP4 104
INDIRF4
MULF4
ADDRGP4 cgs+31476
INDIRI4
CVIF4 4
CNSTF4 1114636288
MULF4
DIVF4
ASGNF4
line 1605
;1605:				remainingScore = cgs.record - score;
ADDRLP4 88
ADDRGP4 cgs+31676
INDIRI4
ADDRLP4 72
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 1606
;1606:				maxDeviation = 0.2 * remainingScore;
ADDRLP4 96
ADDRLP4 88
INDIRF4
CNSTF4 1045220557
MULF4
ASGNF4
line 1607
;1607:				loLimit = estRemScore - maxDeviation;
ADDRLP4 100
ADDRLP4 92
INDIRF4
ADDRLP4 96
INDIRF4
SUBF4
ASGNF4
line 1608
;1608:				hiLimit = estRemScore + maxDeviation;
ADDRLP4 108
ADDRLP4 92
INDIRF4
ADDRLP4 96
INDIRF4
ADDF4
ASGNF4
line 1609
;1609:				if (remainingScore <= loLimit) {
ADDRLP4 88
INDIRF4
ADDRLP4 100
INDIRF4
GTF4 $828
line 1611
;1610:					// green
;1611:					color[0] = 0;
ADDRLP4 56
CNSTF4 0
ASGNF4
line 1612
;1612:					color[2] = 0;
ADDRLP4 56+8
CNSTF4 0
ASGNF4
line 1613
;1613:				}
ADDRGP4 $829
JUMPV
LABELV $828
line 1614
;1614:				else if (remainingScore >= hiLimit) {
ADDRLP4 88
INDIRF4
ADDRLP4 108
INDIRF4
LTF4 $831
line 1616
;1615:					// red
;1616:					color[1] = 0;
ADDRLP4 56+4
CNSTF4 0
ASGNF4
line 1617
;1617:					color[2] = 0;
ADDRLP4 56+8
CNSTF4 0
ASGNF4
line 1618
;1618:				}
ADDRGP4 $832
JUMPV
LABELV $831
line 1619
;1619:				else if (remainingScore <= estRemScore) {
ADDRLP4 88
INDIRF4
ADDRLP4 92
INDIRF4
GTF4 $835
line 1621
;1620:					// light green
;1621:					color[0] = color[2] = (remainingScore - loLimit) / maxDeviation;
ADDRLP4 112
ADDRLP4 88
INDIRF4
ADDRLP4 100
INDIRF4
SUBF4
ADDRLP4 96
INDIRF4
DIVF4
ASGNF4
ADDRLP4 56+8
ADDRLP4 112
INDIRF4
ASGNF4
ADDRLP4 56
ADDRLP4 112
INDIRF4
ASGNF4
line 1622
;1622:				}
ADDRGP4 $836
JUMPV
LABELV $835
line 1623
;1623:				else {
line 1625
;1624:					// light red
;1625:					color[1] = color[2] = 1 - (remainingScore - estRemScore) / maxDeviation;
ADDRLP4 112
CNSTF4 1065353216
ADDRLP4 88
INDIRF4
ADDRLP4 92
INDIRF4
SUBF4
ADDRLP4 96
INDIRF4
DIVF4
SUBF4
ASGNF4
ADDRLP4 56+8
ADDRLP4 112
INDIRF4
ASGNF4
ADDRLP4 56+4
ADDRLP4 112
INDIRF4
ASGNF4
line 1626
;1626:				}
LABELV $836
LABELV $832
LABELV $829
line 1627
;1627:			}
LABELV $817
line 1628
;1628:			s = va("$%d", score);
ADDRGP4 $840
ARGP4
ADDRLP4 72
INDIRI4
ARGI4
ADDRLP4 88
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 88
INDIRP4
ASGNP4
line 1629
;1629:			w = CG_DrawStrlen(s) * BIGCHAR_WIDTH;
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 92
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 92
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 1630
;1630:			x -= w;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ASGNI4
line 1631
;1631:			CG_DrawBigStringColor(x, y, s, color);
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 56
ARGP4
ADDRGP4 CG_DrawBigStringColor
CALLV
pop
line 1632
;1632:		}
line 1633
;1633:	}
ADDRGP4 $707
JUMPV
LABELV $706
line 1636
;1634:	else
;1635:#endif
;1636:	if ( cgs.gametype >= GT_TEAM ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $841
line 1637
;1637:		x = 640;
ADDRLP4 0
CNSTI4 640
ASGNI4
line 1639
;1638:
;1639:		color[0] = 0.0f;
ADDRLP4 12
CNSTF4 0
ASGNF4
line 1640
;1640:		color[1] = 0.0f;
ADDRLP4 12+4
CNSTF4 0
ASGNF4
line 1641
;1641:		color[2] = 1.0f;
ADDRLP4 12+8
CNSTF4 1065353216
ASGNF4
line 1642
;1642:		color[3] = 0.33f;
ADDRLP4 12+12
CNSTF4 1051260355
ASGNF4
line 1643
;1643:		s = va( "%2i", s2 );
ADDRGP4 $847
ARGP4
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 52
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 52
INDIRP4
ASGNP4
line 1644
;1644:		w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 56
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 8
ADDI4
ASGNI4
line 1645
;1645:		x -= w;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ASGNI4
line 1646
;1646:		CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRLP4 12
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 1647
;1647:		if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
NEI4 $848
line 1648
;1648:			CG_DrawPic( x, y-4, w, BIGCHAR_HEIGHT+8, cgs.media.selectShader );
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRGP4 cgs+751220+380
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1649
;1649:		}
LABELV $848
line 1650
;1650:		CG_DrawBigString( x + 4, y, s, 1.0F);
ADDRLP4 0
INDIRI4
CNSTI4 4
ADDI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1652
;1651:
;1652:		if ( cgs.gametype == GT_CTF ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
NEI4 $853
line 1654
;1653:			// Display flag status
;1654:			item = BG_FindItemForPowerup( PW_BLUEFLAG );
CNSTI4 8
ARGI4
ADDRLP4 60
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 48
ADDRLP4 60
INDIRP4
ASGNP4
line 1656
;1655:
;1656:			if (item) {
ADDRLP4 48
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $856
line 1657
;1657:				y1 = y - BIGCHAR_HEIGHT - 8;
ADDRLP4 28
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
SUBF4
CNSTF4 1090519040
SUBF4
ASGNF4
line 1658
;1658:				if( cgs.blueflag >= 0 && cgs.blueflag <= 2 ) {
ADDRGP4 cgs+35136
INDIRI4
CNSTI4 0
LTI4 $858
ADDRGP4 cgs+35136
INDIRI4
CNSTI4 2
GTI4 $858
line 1659
;1659:					CG_DrawPic( x, y1-4, w, BIGCHAR_HEIGHT+8, cgs.media.blueFlagShader[cgs.blueflag] );
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 28
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRGP4 cgs+35136
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+751220+112
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1660
;1660:				}
LABELV $858
line 1661
;1661:			}
LABELV $856
line 1662
;1662:		}
LABELV $853
line 1664
;1663:
;1664:		color[0] = 1.0f;
ADDRLP4 12
CNSTF4 1065353216
ASGNF4
line 1665
;1665:		color[1] = 0.0f;
ADDRLP4 12+4
CNSTF4 0
ASGNF4
line 1666
;1666:		color[2] = 0.0f;
ADDRLP4 12+8
CNSTF4 0
ASGNF4
line 1667
;1667:		color[3] = 0.33f;
ADDRLP4 12+12
CNSTF4 1051260355
ASGNF4
line 1668
;1668:		s = va( "%2i", s1 );
ADDRGP4 $847
ARGP4
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 60
INDIRP4
ASGNP4
line 1669
;1669:		w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 64
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 8
ADDI4
ASGNI4
line 1670
;1670:		x -= w;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ASGNI4
line 1671
;1671:		CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRLP4 12
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 1672
;1672:		if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $868
line 1673
;1673:			CG_DrawPic( x, y-4, w, BIGCHAR_HEIGHT+8, cgs.media.selectShader );
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRGP4 cgs+751220+380
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1674
;1674:		}
LABELV $868
line 1675
;1675:		CG_DrawBigString( x + 4, y, s, 1.0F);
ADDRLP4 0
INDIRI4
CNSTI4 4
ADDI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1677
;1676:
;1677:		if ( cgs.gametype == GT_CTF ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
NEI4 $873
line 1679
;1678:			// Display flag status
;1679:			item = BG_FindItemForPowerup( PW_REDFLAG );
CNSTI4 7
ARGI4
ADDRLP4 68
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 48
ADDRLP4 68
INDIRP4
ASGNP4
line 1681
;1680:
;1681:			if (item) {
ADDRLP4 48
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $876
line 1682
;1682:				y1 = y - BIGCHAR_HEIGHT - 8;
ADDRLP4 28
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
SUBF4
CNSTF4 1090519040
SUBF4
ASGNF4
line 1683
;1683:				if( cgs.redflag >= 0 && cgs.redflag <= 2 ) {
ADDRGP4 cgs+35132
INDIRI4
CNSTI4 0
LTI4 $878
ADDRGP4 cgs+35132
INDIRI4
CNSTI4 2
GTI4 $878
line 1684
;1684:					CG_DrawPic( x, y1-4, w, BIGCHAR_HEIGHT+8, cgs.media.redFlagShader[cgs.redflag] );
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 28
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRGP4 cgs+35132
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+751220+100
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1685
;1685:				}
LABELV $878
line 1686
;1686:			}
LABELV $876
line 1687
;1687:		}
LABELV $873
line 1705
;1688:
;1689:#ifdef MISSIONPACK
;1690:		if ( cgs.gametype == GT_1FCTF ) {
;1691:			// Display flag status
;1692:			item = BG_FindItemForPowerup( PW_NEUTRALFLAG );
;1693:
;1694:			if (item) {
;1695:				y1 = y - BIGCHAR_HEIGHT - 8;
;1696:				if( cgs.flagStatus >= 0 && cgs.flagStatus <= 3 ) {
;1697:					CG_DrawPic( x, y1-4, w, BIGCHAR_HEIGHT+8, cgs.media.flagShader[cgs.flagStatus] );
;1698:				}
;1699:			}
;1700:		}
;1701:#endif
;1702:#if !MONSTER_MODE	// JUHOX: STU is not CTF
;1703:		if ( cgs.gametype >= GT_CTF ) {
;1704:#else
;1705:		if (cgs.gametype == GT_CTF) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
NEI4 $885
line 1707
;1706:#endif
;1707:			v = cgs.capturelimit;
ADDRLP4 44
ADDRGP4 cgs+31472
INDIRI4
ASGNI4
line 1708
;1708:		} else {
ADDRGP4 $886
JUMPV
LABELV $885
line 1709
;1709:			v = cgs.fraglimit;
ADDRLP4 44
ADDRGP4 cgs+31468
INDIRI4
ASGNI4
line 1710
;1710:		}
LABELV $886
line 1711
;1711:		if ( v ) {
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $842
line 1712
;1712:			s = va( "%2i", v );
ADDRGP4 $847
ARGP4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 68
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 68
INDIRP4
ASGNP4
line 1713
;1713:			w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 72
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 72
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 8
ADDI4
ASGNI4
line 1714
;1714:			x -= w;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ASGNI4
line 1715
;1715:			CG_DrawBigString( x + 4, y, s, 1.0F);
ADDRLP4 0
INDIRI4
CNSTI4 4
ADDI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1716
;1716:		}
line 1718
;1717:
;1718:	} else {
ADDRGP4 $842
JUMPV
LABELV $841
line 1721
;1719:		qboolean	spectator;
;1720:
;1721:		x = 640;
ADDRLP4 0
CNSTI4 640
ASGNI4
line 1722
;1722:		score = cg.snap->ps.persistant[PERS_SCORE];
ADDRLP4 40
ADDRGP4 cg+36
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
ASGNI4
line 1723
;1723:		spectator = ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR );
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $895
ADDRLP4 56
CNSTI4 1
ASGNI4
ADDRGP4 $896
JUMPV
LABELV $895
ADDRLP4 56
CNSTI4 0
ASGNI4
LABELV $896
ADDRLP4 52
ADDRLP4 56
INDIRI4
ASGNI4
line 1726
;1724:
;1725:		// always show your score in the second box if not in first place
;1726:		if ( s1 != score ) {
ADDRLP4 32
INDIRI4
ADDRLP4 40
INDIRI4
EQI4 $897
line 1727
;1727:			s2 = score;
ADDRLP4 36
ADDRLP4 40
INDIRI4
ASGNI4
line 1728
;1728:		}
LABELV $897
line 1729
;1729:		if ( s2 != SCORE_NOT_PRESENT ) {
ADDRLP4 36
INDIRI4
CNSTI4 -9999
EQI4 $899
line 1730
;1730:			s = va( "%2i", s2 );
ADDRGP4 $847
ARGP4
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 60
INDIRP4
ASGNP4
line 1731
;1731:			w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 64
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 8
ADDI4
ASGNI4
line 1732
;1732:			x -= w;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ASGNI4
line 1733
;1733:			if ( !spectator && score == s2 && score != s1 ) {
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $901
ADDRLP4 68
ADDRLP4 40
INDIRI4
ASGNI4
ADDRLP4 68
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $901
ADDRLP4 68
INDIRI4
ADDRLP4 32
INDIRI4
EQI4 $901
line 1734
;1734:				color[0] = 1.0f;
ADDRLP4 12
CNSTF4 1065353216
ASGNF4
line 1735
;1735:				color[1] = 0.0f;
ADDRLP4 12+4
CNSTF4 0
ASGNF4
line 1736
;1736:				color[2] = 0.0f;
ADDRLP4 12+8
CNSTF4 0
ASGNF4
line 1737
;1737:				color[3] = 0.33f;
ADDRLP4 12+12
CNSTF4 1051260355
ASGNF4
line 1738
;1738:				CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRLP4 12
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 1739
;1739:				CG_DrawPic( x, y-4, w, BIGCHAR_HEIGHT+8, cgs.media.selectShader );
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRGP4 cgs+751220+380
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1740
;1740:			} else {
ADDRGP4 $902
JUMPV
LABELV $901
line 1741
;1741:				color[0] = 0.5f;
ADDRLP4 12
CNSTF4 1056964608
ASGNF4
line 1742
;1742:				color[1] = 0.5f;
ADDRLP4 12+4
CNSTF4 1056964608
ASGNF4
line 1743
;1743:				color[2] = 0.5f;
ADDRLP4 12+8
CNSTF4 1056964608
ASGNF4
line 1744
;1744:				color[3] = 0.33f;
ADDRLP4 12+12
CNSTF4 1051260355
ASGNF4
line 1745
;1745:				CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRLP4 12
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 1746
;1746:			}
LABELV $902
line 1747
;1747:			CG_DrawBigString( x + 4, y, s, 1.0F);
ADDRLP4 0
INDIRI4
CNSTI4 4
ADDI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1748
;1748:		}
LABELV $899
line 1751
;1749:
;1750:		// first place
;1751:		if ( s1 != SCORE_NOT_PRESENT ) {
ADDRLP4 32
INDIRI4
CNSTI4 -9999
EQI4 $911
line 1752
;1752:			s = va( "%2i", s1 );
ADDRGP4 $847
ARGP4
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 60
INDIRP4
ASGNP4
line 1753
;1753:			w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 64
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 8
ADDI4
ASGNI4
line 1754
;1754:			x -= w;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ASGNI4
line 1755
;1755:			if ( !spectator && score == s1 ) {
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $913
ADDRLP4 40
INDIRI4
ADDRLP4 32
INDIRI4
NEI4 $913
line 1756
;1756:				color[0] = 0.0f;
ADDRLP4 12
CNSTF4 0
ASGNF4
line 1757
;1757:				color[1] = 0.0f;
ADDRLP4 12+4
CNSTF4 0
ASGNF4
line 1758
;1758:				color[2] = 1.0f;
ADDRLP4 12+8
CNSTF4 1065353216
ASGNF4
line 1759
;1759:				color[3] = 0.33f;
ADDRLP4 12+12
CNSTF4 1051260355
ASGNF4
line 1760
;1760:				CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRLP4 12
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 1761
;1761:				CG_DrawPic( x, y-4, w, BIGCHAR_HEIGHT+8, cgs.media.selectShader );
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRGP4 cgs+751220+380
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1762
;1762:			} else {
ADDRGP4 $914
JUMPV
LABELV $913
line 1763
;1763:				color[0] = 0.5f;
ADDRLP4 12
CNSTF4 1056964608
ASGNF4
line 1764
;1764:				color[1] = 0.5f;
ADDRLP4 12+4
CNSTF4 1056964608
ASGNF4
line 1765
;1765:				color[2] = 0.5f;
ADDRLP4 12+8
CNSTF4 1056964608
ASGNF4
line 1766
;1766:				color[3] = 0.33f;
ADDRLP4 12+12
CNSTF4 1051260355
ASGNF4
line 1767
;1767:				CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRLP4 12
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 1768
;1768:			}
LABELV $914
line 1769
;1769:			CG_DrawBigString( x + 4, y, s, 1.0F);
ADDRLP4 0
INDIRI4
CNSTI4 4
ADDI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1770
;1770:		}
LABELV $911
line 1772
;1771:
;1772:		if ( cgs.fraglimit ) {
ADDRGP4 cgs+31468
INDIRI4
CNSTI4 0
EQI4 $923
line 1773
;1773:			s = va( "%2i", cgs.fraglimit );
ADDRGP4 $847
ARGP4
ADDRGP4 cgs+31468
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 60
INDIRP4
ASGNP4
line 1774
;1774:			w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 64
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 8
ADDI4
ASGNI4
line 1775
;1775:			x -= w;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ASGNI4
line 1776
;1776:			CG_DrawBigString( x + 4, y, s, 1.0F);
ADDRLP4 0
INDIRI4
CNSTI4 4
ADDI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1777
;1777:		}
LABELV $923
line 1779
;1778:
;1779:	}
LABELV $842
LABELV $707
line 1781
;1780:
;1781:	return y1 - 8;
ADDRLP4 28
INDIRF4
CNSTF4 1090519040
SUBF4
RETF4
LABELV $703
endproc CG_DrawScores 128 20
data
align 4
LABELV $928
byte 4 1045220557
byte 4 1065353216
byte 4 1045220557
byte 4 1065353216
byte 4 1065353216
byte 4 1045220557
byte 4 1045220557
byte 4 1065353216
code
proc CG_DrawPowerups 200 20
line 1791
;1782:}
;1783:#endif
;1784:
;1785:/*
;1786:================
;1787:CG_DrawPowerups
;1788:================
;1789:*/
;1790:#ifndef MISSIONPACK
;1791:static float CG_DrawPowerups( float y ) {
line 1808
;1792:	int		sorted[MAX_POWERUPS];
;1793:	int		sortedTime[MAX_POWERUPS];
;1794:	int		i, j, k;
;1795:	int		active;
;1796:	playerState_t	*ps;
;1797:	int		t;
;1798:	gitem_t	*item;
;1799:	int		x;
;1800:	int		color;
;1801:	float	size;
;1802:	float	f;
;1803:	static float colors[2][4] = {
;1804:    { 0.2f, 1.0f, 0.2f, 1.0f } ,
;1805:    { 1.0f, 0.2f, 0.2f, 1.0f }
;1806:  };
;1807:
;1808:	ps = &cg.snap->ps;
ADDRLP4 148
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
line 1810
;1809:
;1810:	if ( ps->stats[STAT_HEALTH] <= 0 ) {
ADDRLP4 148
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $930
line 1811
;1811:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $927
JUMPV
LABELV $930
line 1815
;1812:	}
;1813:
;1814:	// sort the list by time remaining
;1815:	active = 0;
ADDRLP4 136
CNSTI4 0
ASGNI4
line 1816
;1816:	for ( i = 0 ; i < /*MAX_POWERUPS*/PW_NUM_POWERUPS ; i++ ) {	// JUHOX
ADDRLP4 144
CNSTI4 0
ASGNI4
LABELV $932
line 1817
;1817:		if ( !ps->powerups[ i ] ) {
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 148
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $936
line 1818
;1818:			continue;
ADDRGP4 $933
JUMPV
LABELV $936
line 1822
;1819:		}
;1820:		// JUHOX: don't draw timer for misused powerups
;1821:#if 1
;1822:		if (i == PW_HASTE) continue;
ADDRLP4 144
INDIRI4
CNSTI4 3
NEI4 $938
ADDRGP4 $933
JUMPV
LABELV $938
line 1823
;1823:		if (i == PW_BATTLESUIT) continue;
ADDRLP4 144
INDIRI4
CNSTI4 2
NEI4 $940
ADDRGP4 $933
JUMPV
LABELV $940
line 1825
;1824:		//if (i == PW_QUAD) continue;
;1825:		if (i == PW_INVIS) continue;
ADDRLP4 144
INDIRI4
CNSTI4 4
NEI4 $942
ADDRGP4 $933
JUMPV
LABELV $942
line 1826
;1826:		if (i == PW_BFG_RELOADING) continue;
ADDRLP4 144
INDIRI4
CNSTI4 12
NEI4 $944
ADDRGP4 $933
JUMPV
LABELV $944
line 1828
;1827:#endif
;1828:		t = ps->powerups[ i ] - cg.time;
ADDRLP4 140
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 148
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
ADDRGP4 cg+107656
INDIRI4
SUBI4
ASGNI4
line 1831
;1829:		// ZOID--don't draw if the power up has unlimited time (999 seconds)
;1830:		// This is true of the CTF flags
;1831:		if ( t < 0 || t > 999000) {
ADDRLP4 140
INDIRI4
CNSTI4 0
LTI4 $949
ADDRLP4 140
INDIRI4
CNSTI4 999000
LEI4 $947
LABELV $949
line 1832
;1832:			continue;
ADDRGP4 $933
JUMPV
LABELV $947
line 1836
;1833:		}
;1834:
;1835:		// insert into the list
;1836:		for ( j = 0 ; j < active ; j++ ) {
ADDRLP4 132
CNSTI4 0
ASGNI4
ADDRGP4 $953
JUMPV
LABELV $950
line 1837
;1837:			if ( sortedTime[j] >= t ) {
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ADDRLP4 140
INDIRI4
LTI4 $954
line 1838
;1838:				for ( k = active - 1 ; k >= j ; k-- ) {
ADDRLP4 0
ADDRLP4 136
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRGP4 $959
JUMPV
LABELV $956
line 1839
;1839:					sorted[k+1] = sorted[k];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68+4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68
ADDP4
INDIRI4
ASGNI4
line 1840
;1840:					sortedTime[k+1] = sortedTime[k];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4+4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ASGNI4
line 1841
;1841:				}
LABELV $957
line 1838
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $959
ADDRLP4 0
INDIRI4
ADDRLP4 132
INDIRI4
GEI4 $956
line 1842
;1842:				break;
ADDRGP4 $952
JUMPV
LABELV $954
line 1844
;1843:			}
;1844:		}
LABELV $951
line 1836
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $953
ADDRLP4 132
INDIRI4
ADDRLP4 136
INDIRI4
LTI4 $950
LABELV $952
line 1845
;1845:		sorted[j] = i;
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68
ADDP4
ADDRLP4 144
INDIRI4
ASGNI4
line 1846
;1846:		sortedTime[j] = t;
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
ADDRLP4 140
INDIRI4
ASGNI4
line 1847
;1847:		active++;
ADDRLP4 136
ADDRLP4 136
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1848
;1848:	}
LABELV $933
line 1816
ADDRLP4 144
ADDRLP4 144
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 13
LTI4 $932
line 1851
;1849:
;1850:	// draw the icons and timers
;1851:	x = 640 - ICON_SIZE - CHAR_WIDTH * 2;
ADDRLP4 168
CNSTI4 528
ASGNI4
line 1852
;1852:	for ( i = 0 ; i < active ; i++ ) {
ADDRLP4 144
CNSTI4 0
ASGNI4
ADDRGP4 $965
JUMPV
LABELV $962
line 1853
;1853:		item = BG_FindItemForPowerup( sorted[i] );
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68
ADDP4
INDIRI4
ARGI4
ADDRLP4 172
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 152
ADDRLP4 172
INDIRP4
ASGNP4
line 1855
;1854:
;1855:    if (item) {
ADDRLP4 152
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $966
line 1857
;1856:
;1857:		  color = 1;
ADDRLP4 164
CNSTI4 1
ASGNI4
line 1859
;1858:
;1859:		  y -= ICON_SIZE;
ADDRFP4 0
ADDRFP4 0
INDIRF4
CNSTF4 1111490560
SUBF4
ASGNF4
line 1861
;1860:
;1861:		  trap_R_SetColor( colors[color] );
ADDRLP4 164
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 $928
ADDP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1862
;1862:		  CG_DrawField( x, y, 2, sortedTime[ i ] / 1000 );
ADDRLP4 168
INDIRI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
CNSTI4 1000
DIVI4
ARGI4
ADDRGP4 CG_DrawField
CALLV
pop
line 1864
;1863:
;1864:		  t = ps->powerups[ sorted[i] ];
ADDRLP4 140
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 148
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
ASGNI4
line 1869
;1865:		  // JUHOX: don't let the charge powerup blink as it runs out
;1866:#if 0
;1867:		  if ( t - cg.time >= POWERUP_BLINKS * POWERUP_BLINK_TIME ) {
;1868:#else
;1869:		  if ( t - cg.time >= POWERUP_BLINKS * POWERUP_BLINK_TIME || sorted[i] == PW_CHARGE) {
ADDRLP4 140
INDIRI4
ADDRGP4 cg+107656
INDIRI4
SUBI4
CNSTI4 5000
GEI4 $971
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68
ADDP4
INDIRI4
CNSTI4 10
NEI4 $968
LABELV $971
line 1871
;1870:#endif
;1871:			  trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1872
;1872:		  } else {
ADDRGP4 $969
JUMPV
LABELV $968
line 1875
;1873:			  vec4_t	modulate;
;1874:
;1875:			  f = (float)( t - cg.time ) / POWERUP_BLINK_TIME;
ADDRLP4 160
ADDRLP4 140
INDIRI4
ADDRGP4 cg+107656
INDIRI4
SUBI4
CVIF4 4
CNSTF4 981668463
MULF4
ASGNF4
line 1876
;1876:			  f -= (int)f;
ADDRLP4 160
ADDRLP4 160
INDIRF4
ADDRLP4 160
INDIRF4
CVFI4 4
CVIF4 4
SUBF4
ASGNF4
line 1877
;1877:			  modulate[0] = modulate[1] = modulate[2] = modulate[3] = f;
ADDRLP4 176+12
ADDRLP4 160
INDIRF4
ASGNF4
ADDRLP4 176+8
ADDRLP4 160
INDIRF4
ASGNF4
ADDRLP4 176+4
ADDRLP4 160
INDIRF4
ASGNF4
ADDRLP4 176
ADDRLP4 160
INDIRF4
ASGNF4
line 1878
;1878:			  trap_R_SetColor( modulate );
ADDRLP4 176
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1879
;1879:		  }
LABELV $969
line 1881
;1880:
;1881:		  if ( cg.powerupActive == sorted[i] &&
ADDRGP4 cg+127720
INDIRI4
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68
ADDP4
INDIRI4
NEI4 $976
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cg+127724
INDIRI4
SUBI4
CNSTI4 200
GEI4 $976
line 1882
;1882:			  cg.time - cg.powerupTime < PULSE_TIME ) {
line 1883
;1883:			  f = 1.0 - ( ( (float)cg.time - cg.powerupTime ) / PULSE_TIME );
ADDRLP4 160
CNSTF4 1065353216
ADDRGP4 cg+107656
INDIRI4
CVIF4 4
ADDRGP4 cg+127724
INDIRI4
CVIF4 4
SUBF4
CNSTF4 1000593162
MULF4
SUBF4
ASGNF4
line 1884
;1884:			  size = ICON_SIZE * ( 1.0 + ( PULSE_SCALE - 1.0 ) * f );
ADDRLP4 156
ADDRLP4 160
INDIRF4
CNSTF4 1056964608
MULF4
CNSTF4 1065353216
ADDF4
CNSTF4 1111490560
MULF4
ASGNF4
line 1885
;1885:		  } else {
ADDRGP4 $977
JUMPV
LABELV $976
line 1886
;1886:			  size = ICON_SIZE;
ADDRLP4 156
CNSTF4 1111490560
ASGNF4
line 1887
;1887:		  }
LABELV $977
line 1889
;1888:
;1889:		  CG_DrawPic( 640 - size, y + ICON_SIZE / 2 - size / 2,
ADDRLP4 152
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 176
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
CNSTF4 1142947840
ADDRLP4 156
INDIRF4
SUBF4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1103101952
ADDF4
ADDRLP4 156
INDIRF4
CNSTF4 1056964608
MULF4
SUBF4
ARGF4
ADDRLP4 156
INDIRF4
ARGF4
ADDRLP4 156
INDIRF4
ARGF4
ADDRLP4 176
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1891
;1890:			  size, size, trap_R_RegisterShader( item->icon ) );
;1891:    }
LABELV $966
line 1892
;1892:	}
LABELV $963
line 1852
ADDRLP4 144
ADDRLP4 144
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $965
ADDRLP4 144
INDIRI4
ADDRLP4 136
INDIRI4
LTI4 $962
line 1893
;1893:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1895
;1894:
;1895:	return y;
ADDRFP4 0
INDIRF4
RETF4
LABELV $927
endproc CG_DrawPowerups 200 20
proc CG_DrawLowerRight 12 12
line 1906
;1896:}
;1897:#endif
;1898:
;1899:/*
;1900:=====================
;1901:CG_DrawLowerRight
;1902:
;1903:=====================
;1904:*/
;1905:#ifndef MISSIONPACK
;1906:static void CG_DrawLowerRight( void ) {
line 1911
;1907:	float	y;
;1908:
;1909:	// JUHOX: don't draw scores in lens flare editor
;1910:#if MAPLENSFLARES
;1911:	if (cgs.editMode == EM_mlf) return;
ADDRGP4 cgs+31684
INDIRI4
CNSTI4 1
NEI4 $984
ADDRGP4 $983
JUMPV
LABELV $984
line 1914
;1912:#endif
;1913:
;1914:	y = 480 - ICON_SIZE;
ADDRLP4 0
CNSTF4 1138229248
ASGNF4
line 1916
;1915:
;1916:	if ( cgs.gametype >= GT_TEAM && cg_drawTeamOverlay.integer == 2 ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $987
ADDRGP4 cg_drawTeamOverlay+12
INDIRI4
CNSTI4 2
NEI4 $987
line 1917
;1917:		y = CG_DrawTeamOverlay( y, qtrue, qfalse );
ADDRLP4 0
INDIRF4
ARGF4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 4
ADDRGP4 CG_DrawTeamOverlay
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 1918
;1918:	}
LABELV $987
line 1920
;1919:
;1920:	y = CG_DrawScores( y );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 CG_DrawScores
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 1921
;1921:	y = CG_DrawPowerups( y );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 CG_DrawPowerups
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
ASGNF4
line 1922
;1922:}
LABELV $983
endproc CG_DrawLowerRight 12 12
proc CG_DrawWeaponOrderName 16 16
line 1965
;1923:#endif
;1924:
;1925:/*
;1926:===================
;1927:CG_DrawPickupItem
;1928:===================
;1929:*/
;1930:// JUHOX: don't draw pickup item
;1931:#if 0
;1932:#ifndef MISSIONPACK
;1933:static int CG_DrawPickupItem( int y ) {
;1934:	int		value;
;1935:	float	*fadeColor;
;1936:
;1937:	if ( cg.snap->ps.stats[STAT_HEALTH] <= 0 ) {
;1938:		return y;
;1939:	}
;1940:
;1941:	y -= ICON_SIZE;
;1942:
;1943:	value = cg.itemPickup;
;1944:	if ( value ) {
;1945:		fadeColor = CG_FadeColor( cg.itemPickupTime, 3000 );
;1946:		if ( fadeColor ) {
;1947:			CG_RegisterItemVisuals( value );
;1948:			trap_R_SetColor( fadeColor );
;1949:			CG_DrawPic( 8, y, ICON_SIZE, ICON_SIZE, cg_items[ value ].icon );
;1950:			CG_DrawBigString( ICON_SIZE + 16, y + (ICON_SIZE/2 - BIGCHAR_HEIGHT/2), bg_itemlist[ value ].pickup_name, fadeColor[0] );
;1951:			trap_R_SetColor( NULL );
;1952:		}
;1953:	}
;1954:
;1955:	return y;
;1956:}
;1957:#endif
;1958:#endif	// JUHOX
;1959:
;1960:/*
;1961:===================
;1962:JUHOX: CG_DrawWeaponOrderName
;1963:===================
;1964:*/
;1965:static int CG_DrawWeaponOrderName(int y) {
line 1968
;1966:	vec4_t color;
;1967:
;1968:	if (cg.snap->ps.pm_type == PM_SPECTATOR) return y;
ADDRGP4 cg+36
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 2
NEI4 $992
ADDRFP4 0
INDIRI4
RETI4
ADDRGP4 $991
JUMPV
LABELV $992
line 1969
;1969:	if (cg.snap->ps.stats[STAT_HEALTH] <= 0) return y;
ADDRGP4 cg+36
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
GTI4 $995
ADDRFP4 0
INDIRI4
RETI4
ADDRGP4 $991
JUMPV
LABELV $995
line 1970
;1970:	if (!cg.weaponOrderActive) return y;
ADDRGP4 cg+109156
INDIRI4
CNSTI4 0
NEI4 $998
ADDRFP4 0
INDIRI4
RETI4
ADDRGP4 $991
JUMPV
LABELV $998
line 1971
;1971:	if (cg.showScores) return y;
ADDRGP4 cg+117624
INDIRI4
CNSTI4 0
EQI4 $1001
ADDRFP4 0
INDIRI4
RETI4
ADDRGP4 $991
JUMPV
LABELV $1001
line 1973
;1972:
;1973:	y -= BIGCHAR_HEIGHT;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 16
SUBI4
ASGNI4
line 1974
;1974:	if (cg.weaponManuallySet && cg_autoswitch.integer) {
ADDRGP4 cg+109152
INDIRI4
CNSTI4 0
EQI4 $1004
ADDRGP4 cg_autoswitch+12
INDIRI4
CNSTI4 0
EQI4 $1004
line 1975
;1975:		color[0] = 0.5;
ADDRLP4 0
CNSTF4 1056964608
ASGNF4
line 1976
;1976:		color[1] = 0.5;
ADDRLP4 0+4
CNSTF4 1056964608
ASGNF4
line 1977
;1977:		color[2] = 0.5;
ADDRLP4 0+8
CNSTF4 1056964608
ASGNF4
line 1978
;1978:	}
ADDRGP4 $1005
JUMPV
LABELV $1004
line 1979
;1979:	else {
line 1980
;1980:		color[0] = 1.0;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 1981
;1981:		color[1] = 1.0;
ADDRLP4 0+4
CNSTF4 1065353216
ASGNF4
line 1982
;1982:		color[2] = 1.0;
ADDRLP4 0+8
CNSTF4 1065353216
ASGNF4
line 1983
;1983:	}
LABELV $1005
line 1984
;1984:	color[3] = 1.0;
ADDRLP4 0+12
CNSTF4 1065353216
ASGNF4
line 1985
;1985:	CG_DrawBigStringColor(0, y, cg_weaponOrderName[cg.currentWeaponOrder].string, color);
CNSTI4 0
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 cg+109160
INDIRI4
CNSTI4 272
MULI4
ADDRGP4 cg_weaponOrderName+16
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_DrawBigStringColor
CALLV
pop
line 1986
;1986:	return y;
ADDRFP4 0
INDIRI4
RETI4
LABELV $991
endproc CG_DrawWeaponOrderName 16 16
data
align 4
LABELV $1016
byte 4 0
align 4
LABELV $1017
byte 4 -1
align 4
LABELV $1018
byte 4 -1
align 4
LABELV $1019
byte 4 0
align 4
LABELV $1020
byte 4 -1
align 4
LABELV $1021
byte 4 0
align 4
LABELV $1022
byte 4 -1
align 4
LABELV $1023
byte 4 -1
align 4
LABELV $1024
byte 4 0
code
proc CG_DrawMissionInfo 288 40
line 1995
;1987:}
;1988:
;1989:/*
;1990:===================
;1991:JUHOX: CG_DrawMissionInfo
;1992:===================
;1993:*/
;1994:#define TSS_BLINK_TIME 2000
;1995:static int CG_DrawMissionInfo(int y) {
line 2016
;1996:	static qboolean wasValid = qfalse;
;1997:	static int lastGroup = -1;
;1998:	static int lastGMS = -1;
;1999:	static int groupOrGMSChangedTime = 0;
;2000:	static tss_mission_t lastMission = -1;
;2001:	static int missionChangedTime = 0;
;2002:	static tss_missionTask_t lastMissionTask = -1;
;2003:	static int lastTaskGoal = -1;
;2004:	static int missionTaskChangedTime = 0;
;2005:
;2006:	int size, x;
;2007:	qboolean valid;
;2008:	int group;
;2009:	tss_groupMemberStatus_t gms;
;2010:	tss_mission_t mission;
;2011:	tss_missionTask_t task;
;2012:	int taskGoalNum;
;2013:	char buf[128];
;2014:	qboolean blinkPhase;	// if true, don't draw a changed item
;2015:
;2016:	if (cg.showScores) return y;
ADDRGP4 cg+117624
INDIRI4
CNSTI4 0
EQI4 $1025
ADDRFP4 0
INDIRI4
RETI4
ADDRGP4 $1015
JUMPV
LABELV $1025
line 2017
;2017:	if (cg.snap->ps.pm_type == PM_SPECTATOR) goto DrawCondition;
ADDRGP4 cg+36
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1028
ADDRGP4 $1031
JUMPV
LABELV $1028
line 2018
;2018:	if (cg.snap->ps.stats[STAT_HEALTH] <= 0) return y;
ADDRGP4 cg+36
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
GTI4 $1032
ADDRFP4 0
INDIRI4
RETI4
ADDRGP4 $1015
JUMPV
LABELV $1032
line 2019
;2019:	valid = BG_TSS_GetPlayerInfo(&cg.snap->ps, TSSPI_isValid);
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 164
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 160
ADDRLP4 164
INDIRI4
ASGNI4
line 2020
;2020:	if (!valid) {
ADDRLP4 160
INDIRI4
CNSTI4 0
NEI4 $1036
line 2021
;2021:		wasValid = qfalse;
ADDRGP4 $1016
CNSTI4 0
ASGNI4
line 2022
;2022:		return y;
ADDRFP4 0
INDIRI4
RETI4
ADDRGP4 $1015
JUMPV
LABELV $1036
line 2024
;2023:	}
;2024:	if (!cg.weaponOrderActive && cgs.stamina) {
ADDRGP4 cg+109156
INDIRI4
CNSTI4 0
NEI4 $1038
ADDRGP4 cgs+31832
INDIRI4
CNSTI4 0
EQI4 $1038
line 2026
;2025:		// without this adjustment the task description would overwrite the strengthbar
;2026:		y -= BIGCHAR_HEIGHT;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 16
SUBI4
ASGNI4
line 2027
;2027:	}
LABELV $1038
line 2028
;2028:	group = BG_TSS_GetPlayerInfo(&cg.snap->ps, TSSPI_group);
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 168
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 168
INDIRI4
ASGNI4
line 2029
;2029:	if (group < 0 || group >= MAX_GROUPS) return y;
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $1045
ADDRLP4 8
INDIRI4
CNSTI4 10
LTI4 $1043
LABELV $1045
ADDRFP4 0
INDIRI4
RETI4
ADDRGP4 $1015
JUMPV
LABELV $1043
line 2030
;2030:	gms = BG_TSS_GetPlayerInfo(&cg.snap->ps, TSSPI_groupMemberStatus);
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 176
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 176
INDIRI4
ASGNI4
line 2031
;2031:	mission = BG_TSS_GetPlayerInfo(&cg.snap->ps, TSSPI_mission);
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ARGP4
CNSTI4 3
ARGI4
ADDRLP4 180
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 180
INDIRI4
ASGNI4
line 2032
;2032:	task = BG_TSS_GetPlayerInfo(&cg.snap->ps, TSSPI_task);
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ARGP4
CNSTI4 5
ARGI4
ADDRLP4 184
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 184
INDIRI4
ASGNI4
line 2033
;2033:	taskGoalNum = BG_TSS_GetPlayerInfo(&cg.snap->ps, TSSPI_taskGoal);
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ARGP4
CNSTI4 13
ARGI4
ADDRLP4 188
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 188
INDIRI4
ASGNI4
line 2036
;2034:
;2035:	if (
;2036:		!wasValid ||
ADDRGP4 $1016
INDIRI4
CNSTI4 0
EQI4 $1057
ADDRLP4 8
INDIRI4
ADDRGP4 $1017
INDIRI4
NEI4 $1057
ADDRLP4 16
INDIRI4
ADDRGP4 $1018
INDIRI4
NEI4 $1057
ADDRLP4 0
INDIRI4
ADDRGP4 $1020
INDIRI4
NEI4 $1057
ADDRLP4 4
INDIRI4
ADDRGP4 $1022
INDIRI4
NEI4 $1056
ADDRLP4 12
INDIRI4
ADDRGP4 $1023
INDIRI4
EQI4 $1050
LABELV $1056
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $1057
ADDRLP4 4
INDIRI4
CNSTI4 8
EQI4 $1050
LABELV $1057
line 2050
;2037:		group != lastGroup ||
;2038:		gms != lastGMS ||
;2039:		mission != lastMission ||
;2040:		(
;2041:			(
;2042:				task != lastMissionTask ||
;2043:				taskGoalNum != lastTaskGoal
;2044:			) &&
;2045:			(
;2046:				mission != TSSMISSION_seek_enemy ||
;2047:				task != TSSMT_fulfilMission
;2048:			)
;2049:		)
;2050:	) {
line 2051
;2051:		trap_S_StartLocalSound(cgs.media.tssBeepSound, CHAN_ANNOUNCER);
ADDRGP4 cgs+751220+1060
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 2052
;2052:	}
LABELV $1050
line 2054
;2053:
;2054:	if (group != lastGroup || gms != lastGMS || !wasValid) {
ADDRLP4 8
INDIRI4
ADDRGP4 $1017
INDIRI4
NEI4 $1063
ADDRLP4 16
INDIRI4
ADDRGP4 $1018
INDIRI4
NEI4 $1063
ADDRGP4 $1016
INDIRI4
CNSTI4 0
NEI4 $1060
LABELV $1063
line 2055
;2055:		groupOrGMSChangedTime = cg.time;
ADDRGP4 $1019
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 2056
;2056:		lastGroup = group;
ADDRGP4 $1017
ADDRLP4 8
INDIRI4
ASGNI4
line 2057
;2057:		lastGMS = gms;
ADDRGP4 $1018
ADDRLP4 16
INDIRI4
ASGNI4
line 2058
;2058:	}
ADDRGP4 $1061
JUMPV
LABELV $1060
line 2059
;2059:	else if (groupOrGMSChangedTime && groupOrGMSChangedTime < cg.time - TSS_BLINK_TIME) {
ADDRLP4 192
ADDRGP4 $1019
INDIRI4
ASGNI4
ADDRLP4 192
INDIRI4
CNSTI4 0
EQI4 $1065
ADDRLP4 192
INDIRI4
ADDRGP4 cg+107656
INDIRI4
CNSTI4 2000
SUBI4
GEI4 $1065
line 2060
;2060:		groupOrGMSChangedTime = 0;
ADDRGP4 $1019
CNSTI4 0
ASGNI4
line 2061
;2061:	}
LABELV $1065
LABELV $1061
line 2063
;2062:
;2063:	if (mission != lastMission || !wasValid) {
ADDRLP4 0
INDIRI4
ADDRGP4 $1020
INDIRI4
NEI4 $1070
ADDRGP4 $1016
INDIRI4
CNSTI4 0
NEI4 $1068
LABELV $1070
line 2064
;2064:		missionChangedTime = cg.time;
ADDRGP4 $1021
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 2065
;2065:		lastMission = mission;
ADDRGP4 $1020
ADDRLP4 0
INDIRI4
ASGNI4
line 2066
;2066:	}
ADDRGP4 $1069
JUMPV
LABELV $1068
line 2067
;2067:	else if (missionChangedTime && missionChangedTime < cg.time - TSS_BLINK_TIME) {
ADDRLP4 196
ADDRGP4 $1021
INDIRI4
ASGNI4
ADDRLP4 196
INDIRI4
CNSTI4 0
EQI4 $1072
ADDRLP4 196
INDIRI4
ADDRGP4 cg+107656
INDIRI4
CNSTI4 2000
SUBI4
GEI4 $1072
line 2068
;2068:		missionChangedTime = 0;
ADDRGP4 $1021
CNSTI4 0
ASGNI4
line 2069
;2069:	}
LABELV $1072
LABELV $1069
line 2071
;2070:
;2071:	if (task != lastMissionTask || taskGoalNum != lastTaskGoal || !wasValid) {
ADDRLP4 4
INDIRI4
ADDRGP4 $1022
INDIRI4
NEI4 $1078
ADDRLP4 12
INDIRI4
ADDRGP4 $1023
INDIRI4
NEI4 $1078
ADDRGP4 $1016
INDIRI4
CNSTI4 0
NEI4 $1075
LABELV $1078
line 2072
;2072:		missionTaskChangedTime = cg.time;
ADDRGP4 $1024
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 2073
;2073:		lastMissionTask = task;
ADDRGP4 $1022
ADDRLP4 4
INDIRI4
ASGNI4
line 2074
;2074:		lastTaskGoal = taskGoalNum;
ADDRGP4 $1023
ADDRLP4 12
INDIRI4
ASGNI4
line 2075
;2075:	}
ADDRGP4 $1076
JUMPV
LABELV $1075
line 2076
;2076:	else if (missionTaskChangedTime && missionTaskChangedTime < cg.time - TSS_BLINK_TIME) {
ADDRLP4 200
ADDRGP4 $1024
INDIRI4
ASGNI4
ADDRLP4 200
INDIRI4
CNSTI4 0
EQI4 $1080
ADDRLP4 200
INDIRI4
ADDRGP4 cg+107656
INDIRI4
CNSTI4 2000
SUBI4
GEI4 $1080
line 2077
;2077:		missionTaskChangedTime = 0;
ADDRGP4 $1024
CNSTI4 0
ASGNI4
line 2078
;2078:	}
LABELV $1080
LABELV $1076
line 2080
;2079:
;2080:	blinkPhase = (cg.time % 200 >= 100);
ADDRGP4 cg+107656
INDIRI4
CNSTI4 200
MODI4
CNSTI4 100
LTI4 $1085
ADDRLP4 204
CNSTI4 1
ASGNI4
ADDRGP4 $1086
JUMPV
LABELV $1085
ADDRLP4 204
CNSTI4 0
ASGNI4
LABELV $1086
ADDRLP4 152
ADDRLP4 204
INDIRI4
ASGNI4
line 2082
;2081:
;2082:	size = 2 * BIGCHAR_HEIGHT;
ADDRLP4 20
CNSTI4 32
ASGNI4
line 2083
;2083:	y -= size;
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRLP4 20
INDIRI4
SUBI4
ASGNI4
line 2085
;2084:
;2085:	if (!groupOrGMSChangedTime || !blinkPhase) {
ADDRGP4 $1019
INDIRI4
CNSTI4 0
EQI4 $1089
ADDRLP4 152
INDIRI4
CNSTI4 0
NEI4 $1087
LABELV $1089
line 2091
;2086:		qhandle_t backShader;
;2087:		int backColor;
;2088:		int frontColor;
;2089:		vec4_t color;
;2090:
;2091:		switch (gms) {
ADDRLP4 236
ADDRLP4 16
INDIRI4
ASGNI4
ADDRLP4 236
INDIRI4
CNSTI4 0
LTI4 $1090
ADDRLP4 236
INDIRI4
CNSTI4 4
GTI4 $1090
ADDRLP4 236
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1108
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1108
address $1093
address $1096
address $1099
address $1102
address $1105
code
LABELV $1093
line 2093
;2092:		case TSSGMS_retreating:
;2093:			backShader = cgs.media.groupTemporary;
ADDRLP4 232
ADDRGP4 cgs+751220+780
INDIRI4
ASGNI4
line 2094
;2094:			backColor = TSSGROUPCOLOR_BLACK;
ADDRLP4 224
CNSTI4 0
ASGNI4
line 2095
;2095:			frontColor = TSSGROUPCOLOR_MINT;
ADDRLP4 228
CNSTI4 12648384
ASGNI4
line 2096
;2096:			break;
ADDRGP4 $1091
JUMPV
LABELV $1096
line 2098
;2097:		case TSSGMS_temporaryFighter:
;2098:			backShader = cgs.media.groupTemporary;
ADDRLP4 232
ADDRGP4 cgs+751220+780
INDIRI4
ASGNI4
line 2099
;2099:			backColor = TSSGROUPCOLOR_WHITE;
ADDRLP4 224
CNSTI4 16777215
ASGNI4
line 2100
;2100:			frontColor = TSSGROUPCOLOR_BLACK;
ADDRLP4 228
CNSTI4 0
ASGNI4
line 2101
;2101:			break;
ADDRGP4 $1091
JUMPV
LABELV $1099
line 2103
;2102:		case TSSGMS_designatedFighter:
;2103:			backShader = cgs.media.groupDesignated;
ADDRLP4 232
ADDRGP4 cgs+751220+784
INDIRI4
ASGNI4
line 2104
;2104:			backColor = TSSGROUPCOLOR_WHITE;
ADDRLP4 224
CNSTI4 16777215
ASGNI4
line 2105
;2105:			frontColor = TSSGROUPCOLOR_BLACK;
ADDRLP4 228
CNSTI4 0
ASGNI4
line 2106
;2106:			break;
ADDRGP4 $1091
JUMPV
LABELV $1102
line 2108
;2107:		case TSSGMS_temporaryLeader:
;2108:			backShader = cgs.media.groupTemporary;
ADDRLP4 232
ADDRGP4 cgs+751220+780
INDIRI4
ASGNI4
line 2109
;2109:			backColor = TSSGROUPCOLOR_YELLOW;
ADDRLP4 224
CNSTI4 16758817
ASGNI4
line 2110
;2110:			frontColor = TSSGROUPCOLOR_BLACK;
ADDRLP4 228
CNSTI4 0
ASGNI4
line 2111
;2111:			break;
ADDRGP4 $1091
JUMPV
LABELV $1105
line 2113
;2112:		case TSSGMS_designatedLeader:
;2113:			backShader = cgs.media.groupDesignated;
ADDRLP4 232
ADDRGP4 cgs+751220+784
INDIRI4
ASGNI4
line 2114
;2114:			backColor = TSSGROUPCOLOR_YELLOW;
ADDRLP4 224
CNSTI4 16758817
ASGNI4
line 2115
;2115:			frontColor = TSSGROUPCOLOR_BLACK;
ADDRLP4 228
CNSTI4 0
ASGNI4
line 2116
;2116:			break;
ADDRGP4 $1091
JUMPV
LABELV $1090
line 2118
;2117:		default:
;2118:			backShader = 0;
ADDRLP4 232
CNSTI4 0
ASGNI4
line 2119
;2119:			backColor = 0;
ADDRLP4 224
CNSTI4 0
ASGNI4
line 2120
;2120:			frontColor = 0;
ADDRLP4 228
CNSTI4 0
ASGNI4
line 2121
;2121:			break;
LABELV $1091
line 2124
;2122:		}
;2123:
;2124:		color[0] = (backColor >> 16) / 255.0;
ADDRLP4 208
ADDRLP4 224
INDIRI4
CNSTI4 16
RSHI4
CVIF4 4
CNSTF4 998277249
MULF4
ASGNF4
line 2125
;2125:		color[1] = (backColor >>  8) / 255.0;
ADDRLP4 208+4
ADDRLP4 224
INDIRI4
CNSTI4 8
RSHI4
CVIF4 4
CNSTF4 998277249
MULF4
ASGNF4
line 2126
;2126:		color[2] = (backColor      ) / 255.0;
ADDRLP4 208+8
ADDRLP4 224
INDIRI4
CVIF4 4
CNSTF4 998277249
MULF4
ASGNF4
line 2127
;2127:		color[3] = 1;
ADDRLP4 208+12
CNSTF4 1065353216
ASGNF4
line 2128
;2128:		trap_R_SetColor(color);
ADDRLP4 208
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2129
;2129:		CG_DrawPic(0, y, size, size, backShader);
CNSTF4 0
ARGF4
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 244
ADDRLP4 20
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 244
INDIRF4
ARGF4
ADDRLP4 244
INDIRF4
ARGF4
ADDRLP4 232
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 2131
;2130:
;2131:		color[0] = (frontColor >> 16) / 255.0;
ADDRLP4 208
ADDRLP4 228
INDIRI4
CNSTI4 16
RSHI4
CVIF4 4
CNSTF4 998277249
MULF4
ASGNF4
line 2132
;2132:		color[1] = (frontColor >>  8) / 255.0;
ADDRLP4 208+4
ADDRLP4 228
INDIRI4
CNSTI4 8
RSHI4
CVIF4 4
CNSTF4 998277249
MULF4
ASGNF4
line 2133
;2133:		color[2] = (frontColor      ) / 255.0;
ADDRLP4 208+8
ADDRLP4 228
INDIRI4
CVIF4 4
CNSTF4 998277249
MULF4
ASGNF4
line 2134
;2134:		color[3] = 1;
ADDRLP4 208+12
CNSTF4 1065353216
ASGNF4
line 2135
;2135:		trap_R_SetColor(color);
ADDRLP4 208
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2136
;2136:		CG_DrawPic(0, y, size, size, cgs.media.groupMarks[group]);
CNSTF4 0
ARGF4
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 248
ADDRLP4 20
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 248
INDIRF4
ARGF4
ADDRLP4 248
INDIRF4
ARGF4
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+751220+788
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 2138
;2137:
;2138:		trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2139
;2139:	}
LABELV $1087
line 2141
;2140:
;2141:	x = size;
ADDRLP4 156
ADDRLP4 20
INDIRI4
ASGNI4
line 2144
;2142:
;2143:	if (
;2144:		mission >= 0 && mission < TSSMISSION_num_missions &&
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1117
ADDRLP4 0
INDIRI4
CNSTI4 7
GEI4 $1117
ADDRGP4 $1021
INDIRI4
CNSTI4 0
EQI4 $1119
ADDRLP4 152
INDIRI4
CNSTI4 0
NEI4 $1117
LABELV $1119
line 2146
;2145:		(!missionChangedTime || !blinkPhase)
;2146:	) {
line 2150
;2147:		const char* ourName;
;2148:		const char* theirName;
;2149:
;2150:		if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1120
line 2151
;2151:			ourName = "Red";
ADDRLP4 216
ADDRGP4 $1123
ASGNP4
line 2152
;2152:			theirName = "Blue";
ADDRLP4 212
ADDRGP4 $1124
ASGNP4
line 2153
;2153:		}
ADDRGP4 $1121
JUMPV
LABELV $1120
line 2154
;2154:		else {
line 2155
;2155:			ourName = "Blue";
ADDRLP4 216
ADDRGP4 $1124
ASGNP4
line 2156
;2156:			theirName = "Red";
ADDRLP4 212
ADDRGP4 $1123
ASGNP4
line 2157
;2157:		}
LABELV $1121
line 2159
;2158:
;2159:		switch (mission) {
ADDRLP4 220
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 220
INDIRI4
CNSTI4 0
LTI4 $1125
ADDRLP4 220
INDIRI4
CNSTI4 6
GTI4 $1125
ADDRLP4 220
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1151
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1151
address $1128
address $1130
address $1132
address $1134
address $1136
address $1147
address $1149
code
LABELV $1128
LABELV $1125
line 2162
;2160:		case TSSMISSION_invalid:
;2161:		default:
;2162:			strcpy(buf, "???");
ADDRLP4 24
ARGP4
ADDRGP4 $1129
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 2163
;2163:			break;
ADDRGP4 $1126
JUMPV
LABELV $1130
line 2165
;2164:		case TSSMISSION_seek_enemy:
;2165:			strcpy(buf, "Seek Enemy");
ADDRLP4 24
ARGP4
ADDRGP4 $1131
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 2166
;2166:			break;
ADDRGP4 $1126
JUMPV
LABELV $1132
line 2168
;2167:		case TSSMISSION_seek_items:
;2168:			strcpy(buf, "Seek Items");
ADDRLP4 24
ARGP4
ADDRGP4 $1133
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 2169
;2169:			break;
ADDRGP4 $1126
JUMPV
LABELV $1134
line 2171
;2170:		case TSSMISSION_capture_enemy_flag:
;2171:			Com_sprintf(buf, sizeof(buf), "Capture %s Flag", theirName);
ADDRLP4 24
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $1135
ARGP4
ADDRLP4 212
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 2172
;2172:			break;
ADDRGP4 $1126
JUMPV
LABELV $1136
line 2175
;2173:		case TSSMISSION_defend_our_flag:
;2174:			if (
;2175:				(cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED && cgs.redflag > 0) ||
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1144
ADDRGP4 cgs+35132
INDIRI4
CNSTI4 0
GTI4 $1143
LABELV $1144
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1137
ADDRGP4 cgs+35136
INDIRI4
CNSTI4 0
LEI4 $1137
LABELV $1143
line 2177
;2176:				(cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE && cgs.blueflag > 0)
;2177:			) {
line 2178
;2178:				Com_sprintf(buf, sizeof(buf), "Return %s Flag", ourName);
ADDRLP4 24
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $1145
ARGP4
ADDRLP4 216
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 2179
;2179:			}
ADDRGP4 $1126
JUMPV
LABELV $1137
line 2180
;2180:			else {
line 2181
;2181:				Com_sprintf(buf, sizeof(buf), "Defend %s Flag", ourName);
ADDRLP4 24
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $1146
ARGP4
ADDRLP4 216
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 2182
;2182:			}
line 2183
;2183:			break;
ADDRGP4 $1126
JUMPV
LABELV $1147
line 2185
;2184:		case TSSMISSION_defend_our_base:
;2185:			Com_sprintf(buf, sizeof(buf), "Defend %s Base", ourName);
ADDRLP4 24
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $1148
ARGP4
ADDRLP4 216
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 2186
;2186:			break;
ADDRGP4 $1126
JUMPV
LABELV $1149
line 2188
;2187:		case TSSMISSION_occupy_enemy_base:
;2188:			Com_sprintf(buf, sizeof(buf), "Occupy %s Base", theirName);
ADDRLP4 24
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $1150
ARGP4
ADDRLP4 212
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 2189
;2189:			break;
LABELV $1126
line 2192
;2190:		}
;2191:
;2192:		if (BG_TSS_GetPlayerInfo(&cg.snap->ps, TSSPI_missionStatus) == TSSMS_valid) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 228
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 228
INDIRI4
CNSTI4 0
NEI4 $1152
line 2193
;2193:			CG_DrawBigString(x, y, buf, 1);
ADDRLP4 156
INDIRI4
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 2194
;2194:		}
ADDRGP4 $1153
JUMPV
LABELV $1152
line 2195
;2195:		else {
line 2198
;2196:			vec4_t color;
;2197:
;2198:			color[0] = 0.5;
ADDRLP4 232
CNSTF4 1056964608
ASGNF4
line 2199
;2199:			color[1] = 0.5;
ADDRLP4 232+4
CNSTF4 1056964608
ASGNF4
line 2200
;2200:			color[2] = 0.5;
ADDRLP4 232+8
CNSTF4 1056964608
ASGNF4
line 2201
;2201:			color[3] = 1;
ADDRLP4 232+12
CNSTF4 1065353216
ASGNF4
line 2202
;2202:			CG_DrawBigStringColor(x, y, buf, color);
ADDRLP4 156
INDIRI4
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
ADDRLP4 232
ARGP4
ADDRGP4 CG_DrawBigStringColor
CALLV
pop
line 2203
;2203:		}
LABELV $1153
line 2204
;2204:	}
LABELV $1117
line 2207
;2205:
;2206:	if (
;2207:		task >= 0 && task < TSSMT_num_tasks &&
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $1158
ADDRLP4 4
INDIRI4
CNSTI4 10
GEI4 $1158
ADDRGP4 $1024
INDIRI4
CNSTI4 0
EQI4 $1160
ADDRLP4 152
INDIRI4
CNSTI4 0
NEI4 $1158
LABELV $1160
line 2209
;2208:		(!missionTaskChangedTime || !blinkPhase)
;2209:	) {
line 2212
;2210:		char* goalName;
;2211:
;2212:		if (taskGoalNum < 0 || taskGoalNum >= MAX_CLIENTS || taskGoalNum == cg.clientNum) {
ADDRLP4 12
INDIRI4
CNSTI4 0
LTI4 $1165
ADDRLP4 12
INDIRI4
CNSTI4 64
GEI4 $1165
ADDRLP4 12
INDIRI4
ADDRGP4 cg+4
INDIRI4
NEI4 $1161
LABELV $1165
line 2213
;2213:			taskGoalNum = -1;
ADDRLP4 12
CNSTI4 -1
ASGNI4
line 2214
;2214:			goalName = "?";
ADDRLP4 216
ADDRGP4 $1166
ASGNP4
line 2215
;2215:		}
ADDRGP4 $1162
JUMPV
LABELV $1161
line 2216
;2216:		else {
line 2217
;2217:			goalName = cgs.clientinfo[taskGoalNum].name;
ADDRLP4 216
ADDRLP4 12
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320+4
ADDP4
ASGNP4
line 2218
;2218:		}
LABELV $1162
line 2220
;2219:
;2220:		switch (task) {
ADDRLP4 224
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 224
INDIRI4
CNSTI4 0
LTI4 $1169
ADDRLP4 224
INDIRI4
CNSTI4 9
GTI4 $1169
ADDRLP4 224
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1207
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1207
address $1172
address $1174
address $1176
address $1178
address $1180
address $1182
address $1191
address $1193
address $1195
address $1205
code
LABELV $1172
line 2222
;2221:		case TSSMT_followGroupLeader:
;2222:			Com_sprintf(buf, sizeof(buf), "Support %s", goalName);
ADDRLP4 24
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $1173
ARGP4
ADDRLP4 216
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 2223
;2223:			break;
ADDRGP4 $1170
JUMPV
LABELV $1174
line 2225
;2224:		case TSSMT_stickToGroupLeader:
;2225:			Com_sprintf(buf, sizeof(buf), "Stick to %s", goalName);
ADDRLP4 24
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $1175
ARGP4
ADDRLP4 216
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 2226
;2226:			break;
ADDRGP4 $1170
JUMPV
LABELV $1176
line 2228
;2227:		case TSSMT_retreat:
;2228:			strcpy(buf, "Retreat");
ADDRLP4 24
ARGP4
ADDRGP4 $1177
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 2229
;2229:			break;
ADDRGP4 $1170
JUMPV
LABELV $1178
line 2231
;2230:		case TSSMT_helpTeamMate:
;2231:			Com_sprintf(buf, sizeof(buf), "Protect %s", goalName);
ADDRLP4 24
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $1179
ARGP4
ADDRLP4 216
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 2232
;2232:			break;
ADDRGP4 $1170
JUMPV
LABELV $1180
line 2234
;2233:		case TSSMT_guardFlagCarrier:
;2234:			Com_sprintf(buf, sizeof(buf), "Protect %s" S_COLOR_WHITE " at all costs", goalName);
ADDRLP4 24
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $1181
ARGP4
ADDRLP4 216
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 2235
;2235:			break;
ADDRGP4 $1170
JUMPV
LABELV $1182
line 2238
;2236:		case TSSMT_rushToBase:
;2237:			if (
;2238:				cg.snap->ps.powerups[PW_REDFLAG] ||
ADDRGP4 cg+36
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1188
ADDRGP4 cg+36
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1188
ADDRLP4 12
INDIRI4
CNSTI4 0
GEI4 $1183
LABELV $1188
line 2241
;2239:				cg.snap->ps.powerups[PW_BLUEFLAG] ||
;2240:				taskGoalNum < 0
;2241:			) {
line 2242
;2242:				strcpy(buf, "Rush to base");
ADDRLP4 24
ARGP4
ADDRGP4 $1189
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 2243
;2243:			}
ADDRGP4 $1170
JUMPV
LABELV $1183
line 2244
;2244:			else {
line 2245
;2245:				Com_sprintf(buf, sizeof(buf), "Lead %s" S_COLOR_WHITE " to base", goalName);
ADDRLP4 24
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $1190
ARGP4
ADDRLP4 216
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 2246
;2246:			}
line 2247
;2247:			break;
ADDRGP4 $1170
JUMPV
LABELV $1191
line 2249
;2248:		case TSSMT_seekGroupMember:
;2249:			Com_sprintf(buf, sizeof(buf), "Meet %s", goalName);
ADDRLP4 24
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $1192
ARGP4
ADDRLP4 216
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 2250
;2250:			break;
ADDRGP4 $1170
JUMPV
LABELV $1193
line 2252
;2251:		case TSSMT_seekEnemyNearTeamMate:
;2252:			Com_sprintf(buf, sizeof(buf), "Seek enemy near %s", goalName);
ADDRLP4 24
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $1194
ARGP4
ADDRLP4 216
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 2253
;2253:			break;
ADDRGP4 $1170
JUMPV
LABELV $1195
line 2255
;2254:		case TSSMT_fulfilMission:
;2255:			if (BG_TSS_GetPlayerInfo(&cg.snap->ps, TSSPI_missionStatus) == TSSMS_valid) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 232
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 232
INDIRI4
CNSTI4 0
NEI4 $1196
line 2256
;2256:				switch (gms) {
ADDRLP4 236
ADDRLP4 16
INDIRI4
ASGNI4
ADDRLP4 236
INDIRI4
CNSTI4 3
EQI4 $1202
ADDRLP4 236
INDIRI4
CNSTI4 4
EQI4 $1202
ADDRGP4 $1199
JUMPV
LABELV $1202
line 2259
;2257:				case TSSGMS_designatedLeader:
;2258:				case TSSGMS_temporaryLeader:
;2259:					strcpy(buf, "Fulfil mission");
ADDRLP4 24
ARGP4
ADDRGP4 $1203
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 2260
;2260:					break;
ADDRGP4 $1170
JUMPV
LABELV $1199
line 2262
;2261:				default:
;2262:					strcpy(buf, "Go! Go! Go!");
ADDRLP4 24
ARGP4
ADDRGP4 $1204
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 2263
;2263:					break;
line 2265
;2264:				}
;2265:			}
ADDRGP4 $1170
JUMPV
LABELV $1196
line 2266
;2266:			else {
line 2267
;2267:				buf[0] = 0;
ADDRLP4 24
CNSTI1 0
ASGNI1
line 2268
;2268:			}
line 2269
;2269:			break;
ADDRGP4 $1170
JUMPV
LABELV $1205
line 2271
;2270:		case TSSMT_prepareForMission:
;2271:			strcpy(buf, "Await reinforcements");
ADDRLP4 24
ARGP4
ADDRGP4 $1206
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 2272
;2272:			break;
ADDRGP4 $1170
JUMPV
LABELV $1169
line 2274
;2273:		default:
;2274:			buf[0] = 0;
ADDRLP4 24
CNSTI1 0
ASGNI1
line 2275
;2275:		}
LABELV $1170
line 2277
;2276:
;2277:		CG_DrawBigString(x, y + BIGCHAR_HEIGHT, buf, 1);
ADDRLP4 156
INDIRI4
ARGI4
ADDRFP4 0
INDIRI4
CNSTI4 16
ADDI4
ARGI4
ADDRLP4 24
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 2278
;2278:	}
LABELV $1158
line 2280
;2279:
;2280:	switch (gms) {
ADDRLP4 216
ADDRLP4 16
INDIRI4
ASGNI4
ADDRLP4 216
INDIRI4
CNSTI4 3
EQI4 $1211
ADDRLP4 216
INDIRI4
CNSTI4 4
EQI4 $1211
ADDRGP4 $1209
JUMPV
LABELV $1211
line 2283
;2281:	case TSSGMS_designatedLeader:
;2282:	case TSSGMS_temporaryLeader:
;2283:		{
line 2289
;2284:			int numTotal;
;2285:			int numAlive;
;2286:			int numReady;
;2287:			const char* groupCommand;
;2288:
;2289:			y -= TINYCHAR_HEIGHT;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 8
SUBI4
ASGNI4
line 2291
;2290:
;2291:			numTotal = BG_TSS_GetPlayerInfo(&cg.snap->ps, TSSPI_groupSize);
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ARGP4
CNSTI4 7
ARGI4
ADDRLP4 240
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 224
ADDRLP4 240
INDIRI4
ASGNI4
line 2292
;2292:			numAlive = BG_TSS_GetPlayerInfo(&cg.snap->ps, TSSPI_membersAlive);
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ARGP4
CNSTI4 8
ARGI4
ADDRLP4 244
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 228
ADDRLP4 244
INDIRI4
ASGNI4
line 2293
;2293:			numReady = BG_TSS_GetPlayerInfo(&cg.snap->ps, TSSPI_membersReady);
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ARGP4
CNSTI4 9
ARGI4
ADDRLP4 248
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 232
ADDRLP4 248
INDIRI4
ASGNI4
line 2294
;2294:			switch (BG_TSS_GetPlayerInfo(&cg.snap->ps, TSSPI_groupFormation)) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ARGP4
CNSTI4 6
ARGI4
ADDRLP4 256
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 252
ADDRLP4 256
INDIRI4
ASGNI4
ADDRLP4 252
INDIRI4
CNSTI4 0
EQI4 $1219
ADDRLP4 252
INDIRI4
CNSTI4 1
EQI4 $1221
ADDRLP4 252
INDIRI4
CNSTI4 2
EQI4 $1223
ADDRGP4 $1215
JUMPV
LABELV $1219
line 2296
;2295:			case TSSGF_tight:
;2296:				groupCommand = "\"Stick to me!\"";
ADDRLP4 236
ADDRGP4 $1220
ASGNP4
line 2297
;2297:				break;
ADDRGP4 $1216
JUMPV
LABELV $1221
line 2299
;2298:			case TSSGF_loose:
;2299:				groupCommand = "\"Support me!\"";
ADDRLP4 236
ADDRGP4 $1222
ASGNP4
line 2300
;2300:				break;
ADDRGP4 $1216
JUMPV
LABELV $1223
line 2302
;2301:			case TSSGF_free:
;2302:				groupCommand = "\"Go! Go! Go!\"";
ADDRLP4 236
ADDRGP4 $1224
ASGNP4
line 2303
;2303:				break;
ADDRGP4 $1216
JUMPV
LABELV $1215
line 2305
;2304:			default:
;2305:				groupCommand = "INVALID COMMAND";
ADDRLP4 236
ADDRGP4 $1225
ASGNP4
line 2306
;2306:				break;
LABELV $1216
line 2309
;2307:			}
;2308:
;2309:			Com_sprintf(
ADDRLP4 24
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $1226
ARGP4
ADDRLP4 276
ADDRLP4 232
INDIRI4
ASGNI4
ADDRLP4 276
INDIRI4
ARGI4
ADDRLP4 276
INDIRI4
CNSTI4 15
LTI4 $1232
ADDRLP4 264
ADDRGP4 $1227
ASGNP4
ADDRGP4 $1233
JUMPV
LABELV $1232
ADDRLP4 264
ADDRGP4 $1228
ASGNP4
LABELV $1233
ADDRLP4 264
INDIRP4
ARGP4
ADDRLP4 280
ADDRLP4 228
INDIRI4
ASGNI4
ADDRLP4 280
INDIRI4
ARGI4
ADDRLP4 280
INDIRI4
CNSTI4 15
LTI4 $1234
ADDRLP4 268
ADDRGP4 $1227
ASGNP4
ADDRGP4 $1235
JUMPV
LABELV $1234
ADDRLP4 268
ADDRGP4 $1228
ASGNP4
LABELV $1235
ADDRLP4 268
INDIRP4
ARGP4
ADDRLP4 284
ADDRLP4 224
INDIRI4
ASGNI4
ADDRLP4 284
INDIRI4
ARGI4
ADDRLP4 284
INDIRI4
CNSTI4 15
LTI4 $1236
ADDRLP4 272
ADDRGP4 $1227
ASGNP4
ADDRGP4 $1237
JUMPV
LABELV $1236
ADDRLP4 272
ADDRGP4 $1228
ASGNP4
LABELV $1237
ADDRLP4 272
INDIRP4
ARGP4
ADDRLP4 236
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 2316
;2310:				buf, sizeof(buf), "[%d%s/%d%s/%d%s] %s",
;2311:				numReady, numReady>=15? "+" : "",
;2312:				numAlive, numAlive>=15? "+" : "",
;2313:				numTotal, numTotal>=15? "+" : "",
;2314:				groupCommand
;2315:			);
;2316:			CG_DrawStringExt(0, y, buf, NULL, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
CNSTI4 0
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
CNSTI4 8
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 2317
;2317:		}
line 2318
;2318:		break;
line 2320
;2319:	default:
;2320:		break;
LABELV $1209
LABELV $1031
line 2325
;2321:	}
;2322:
;2323:	DrawCondition:
;2324:	if (
;2325:		cgs.clientinfo[cg.clientNum].teamLeader &&
ADDRGP4 cg+4
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320+156
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1238
ADDRGP4 cg+131680
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1238
ADDRGP4 cg+128220
INDIRI4
CNSTI4 0
EQI4 $1238
line 2328
;2326:		cg.tssUtilizedStrategy &&
;2327:		cg.tssOnline
;2328:	) {
line 2332
;2329:		int condition;
;2330:		const char* name;
;2331:
;2332:		y -= TINYCHAR_HEIGHT;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 8
SUBI4
ASGNI4
line 2334
;2333:
;2334:		condition = cg.tssUtilizedStrategy->condition;
ADDRLP4 224
ADDRGP4 cg+131680
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 2335
;2335:		name = cg.tssUtilizedStrategy->strategy->directives[condition].name;
ADDRLP4 228
ADDRLP4 224
INDIRI4
CNSTI4 1120
MULI4
ADDRGP4 cg+131680
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CNSTI4 148
ADDP4
ADDP4
CNSTI4 4
ADDP4
ASGNP4
line 2336
;2336:		Com_sprintf(
ADDRLP4 24
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $1247
ARGP4
ADDRLP4 224
INDIRI4
CNSTI4 0
GTI4 $1250
ADDRLP4 232
CNSTI4 63
ASGNI4
ADDRGP4 $1251
JUMPV
LABELV $1250
ADDRLP4 232
ADDRLP4 224
INDIRI4
CNSTI4 65
ADDI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $1251
ADDRLP4 232
INDIRI4
ARGI4
ADDRLP4 228
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1252
ADDRLP4 236
CNSTI4 45
ASGNI4
ADDRGP4 $1253
JUMPV
LABELV $1252
ADDRLP4 236
CNSTI4 32
ASGNI4
LABELV $1253
ADDRLP4 236
INDIRI4
ARGI4
ADDRLP4 228
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 2341
;2337:			buf, sizeof(buf), "Condition %c %c %s",
;2338:			condition <= 0? '?' : condition + 'A' - 1,
;2339:			name[0]? '-' : ' ', name
;2340:		);
;2341:		CG_DrawStringExt(0, y, buf, NULL, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
CNSTI4 0
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
CNSTI4 8
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 2342
;2342:	}
LABELV $1238
line 2344
;2343:
;2344:	wasValid = qtrue;
ADDRGP4 $1016
CNSTI4 1
ASGNI4
line 2345
;2345:	return y;
ADDRFP4 0
INDIRI4
RETI4
LABELV $1015
endproc CG_DrawMissionInfo 288 40
proc CG_DrawMagnitudes 44 36
line 2353
;2346:}
;2347:
;2348:/*
;2349:===================
;2350:JUHOX: CG_DrawMagnitudes
;2351:===================
;2352:*/
;2353:static int CG_DrawMagnitudes(int y) {
line 2357
;2354:	int i, n;
;2355:	int x;
;2356:
;2357:	if (cg.showScores) return y;
ADDRGP4 cg+117624
INDIRI4
CNSTI4 0
EQI4 $1255
ADDRFP4 0
INDIRI4
RETI4
ADDRGP4 $1254
JUMPV
LABELV $1255
line 2358
;2358:	if (!cgs.clientinfo[cg.clientNum].teamLeader) return y;
ADDRGP4 cg+4
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320+156
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1258
ADDRFP4 0
INDIRI4
RETI4
ADDRGP4 $1254
JUMPV
LABELV $1258
line 2361
;2359:	//if (!cg.tssOnline) return y;
;2360:
;2361:	n = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2362
;2362:	for (i = TSSTM_num_magnitudes-1; i >= 0; i--) {
ADDRLP4 0
CNSTI4 39
ASGNI4
LABELV $1263
line 2365
;2363:		char buf[32];
;2364:
;2365:		if (!cg.tssInspectMagnitude[i]) continue;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+128240
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1267
ADDRGP4 $1264
JUMPV
LABELV $1267
line 2367
;2366:
;2367:		CG_TSS_SPrintTacticalMeasure(buf, sizeof(buf), i, &cg.tssMeasures);
ADDRLP4 12
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 cg+130400
ARGP4
ADDRGP4 CG_TSS_SPrintTacticalMeasure
CALLV
pop
line 2368
;2368:		if ((n & 1) == 0) {
ADDRLP4 4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $1271
line 2369
;2369:			y -= TINYCHAR_HEIGHT;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 8
SUBI4
ASGNI4
line 2370
;2370:			x = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2371
;2371:		}
ADDRGP4 $1272
JUMPV
LABELV $1271
line 2372
;2372:		else {
line 2373
;2373:			x = TINYCHAR_WIDTH * 13;
ADDRLP4 8
CNSTI4 104
ASGNI4
line 2374
;2374:		}
LABELV $1272
line 2375
;2375:		CG_DrawStringExt(x, y, buf, NULL, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
ADDRLP4 8
INDIRI4
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
CNSTI4 8
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 2376
;2376:		n++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2377
;2377:	}
LABELV $1264
line 2362
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $1263
line 2378
;2378:	return y;
ADDRFP4 0
INDIRI4
RETI4
LABELV $1254
endproc CG_DrawMagnitudes 44 36
proc CG_DrawLowerLeft 20 12
line 2388
;2379:}
;2380:
;2381:/*
;2382:=====================
;2383:CG_DrawLowerLeft
;2384:
;2385:=====================
;2386:*/
;2387:#ifndef MISSIONPACK
;2388:static void CG_DrawLowerLeft( void ) {
line 2391
;2389:	float	y;
;2390:
;2391:	if (cg.tssInterfaceOn) return;	// JUHOX
ADDRGP4 cg+128100
INDIRI4
CNSTI4 0
EQI4 $1274
ADDRGP4 $1273
JUMPV
LABELV $1274
line 2392
;2392:	y = 480 - ICON_SIZE;
ADDRLP4 0
CNSTF4 1138229248
ASGNF4
line 2393
;2393:	if (cg.snap->ps.pm_type == PM_SPECTATOR) y = 480;	// JUHOX: for mission leader in safety mode
ADDRGP4 cg+36
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1277
ADDRLP4 0
CNSTF4 1139802112
ASGNF4
LABELV $1277
line 2395
;2394:
;2395:	y = CG_DrawWeaponOrderName(y);	// JUHOX
ADDRLP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 4
ADDRGP4 CG_DrawWeaponOrderName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
CVIF4 4
ASGNF4
line 2396
;2396:	y = CG_DrawMissionInfo(y);		// JUHOX
ADDRLP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 8
ADDRGP4 CG_DrawMissionInfo
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
CVIF4 4
ASGNF4
line 2397
;2397:	y = CG_DrawMagnitudes(y);		// JUHOX
ADDRLP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 12
ADDRGP4 CG_DrawMagnitudes
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
CVIF4 4
ASGNF4
line 2399
;2398:
;2399:	if ( cgs.gametype >= GT_TEAM && cg_drawTeamOverlay.integer == 3 ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $1280
ADDRGP4 cg_drawTeamOverlay+12
INDIRI4
CNSTI4 3
NEI4 $1280
line 2400
;2400:		y = CG_DrawTeamOverlay( y, qfalse, qfalse );
ADDRLP4 0
INDIRF4
ARGF4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 16
ADDRGP4 CG_DrawTeamOverlay
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 2401
;2401:	}
LABELV $1280
line 2407
;2402:
;2403:	// JUHOX: don't draw pickup item
;2404:#if 0
;2405:	y = CG_DrawPickupItem( y );
;2406:#endif
;2407:}
LABELV $1273
endproc CG_DrawLowerLeft 20 12
proc CG_DrawTeamInfo 48 36
line 2419
;2408:#endif
;2409:
;2410:
;2411://===========================================================================================
;2412:
;2413:/*
;2414:=================
;2415:CG_DrawTeamInfo
;2416:=================
;2417:*/
;2418:#ifndef MISSIONPACK
;2419:static void CG_DrawTeamInfo( void ) {
line 2428
;2420:	int w, h;
;2421:	int i, len;
;2422:	vec4_t		hcolor;
;2423:	int		chatHeight;
;2424:
;2425:#define CHATLOC_Y 420 // bottom end
;2426:#define CHATLOC_X 0
;2427:
;2428:	if (cg_teamChatHeight.integer < TEAMCHAT_HEIGHT)
ADDRGP4 cg_teamChatHeight+12
INDIRI4
CNSTI4 8
GEI4 $1285
line 2429
;2429:		chatHeight = cg_teamChatHeight.integer;
ADDRLP4 8
ADDRGP4 cg_teamChatHeight+12
INDIRI4
ASGNI4
ADDRGP4 $1286
JUMPV
LABELV $1285
line 2431
;2430:	else
;2431:		chatHeight = TEAMCHAT_HEIGHT;
ADDRLP4 8
CNSTI4 8
ASGNI4
LABELV $1286
line 2432
;2432:	if (chatHeight <= 0)
ADDRLP4 8
INDIRI4
CNSTI4 0
GTI4 $1289
line 2433
;2433:		return; // disabled
ADDRGP4 $1284
JUMPV
LABELV $1289
line 2435
;2434:
;2435:	if (cgs.teamLastChatPos != cgs.teamChatPos) {
ADDRGP4 cgs+162516
INDIRI4
ADDRGP4 cgs+162512
INDIRI4
EQI4 $1291
line 2436
;2436:		if (cg.time - cgs.teamChatMsgTimes[cgs.teamLastChatPos % chatHeight] > cg_teamChatTime.integer) {
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cgs+162516
INDIRI4
ADDRLP4 8
INDIRI4
MODI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+162480
ADDP4
INDIRI4
SUBI4
ADDRGP4 cg_teamChatTime+12
INDIRI4
LEI4 $1295
line 2437
;2437:			cgs.teamLastChatPos++;
ADDRLP4 36
ADDRGP4 cgs+162516
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2438
;2438:		}
LABELV $1295
line 2440
;2439:
;2440:		h = (cgs.teamChatPos - cgs.teamLastChatPos) * TINYCHAR_HEIGHT;
ADDRLP4 32
ADDRGP4 cgs+162512
INDIRI4
ADDRGP4 cgs+162516
INDIRI4
SUBI4
CNSTI4 3
LSHI4
ASGNI4
line 2442
;2441:
;2442:		w = 0;
ADDRLP4 28
CNSTI4 0
ASGNI4
line 2444
;2443:
;2444:		for (i = cgs.teamLastChatPos; i < cgs.teamChatPos; i++) {
ADDRLP4 0
ADDRGP4 cgs+162516
INDIRI4
ASGNI4
ADDRGP4 $1307
JUMPV
LABELV $1304
line 2445
;2445:			len = CG_DrawStrlen(cgs.teamChatMsgs[i % chatHeight]);
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
MODI4
CNSTI4 241
MULI4
ADDRGP4 cgs+160552
ADDP4
ARGP4
ADDRLP4 36
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 36
INDIRI4
ASGNI4
line 2446
;2446:			if (len > w)
ADDRLP4 4
INDIRI4
ADDRLP4 28
INDIRI4
LEI4 $1311
line 2447
;2447:				w = len;
ADDRLP4 28
ADDRLP4 4
INDIRI4
ASGNI4
LABELV $1311
line 2448
;2448:		}
LABELV $1305
line 2444
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1307
ADDRLP4 0
INDIRI4
ADDRGP4 cgs+162512
INDIRI4
LTI4 $1304
line 2449
;2449:		w *= TINYCHAR_WIDTH;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 3
LSHI4
ASGNI4
line 2450
;2450:		w += TINYCHAR_WIDTH * 2;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 2452
;2451:
;2452:		if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1313
line 2453
;2453:			hcolor[0] = 1.0f;
ADDRLP4 12
CNSTF4 1065353216
ASGNF4
line 2454
;2454:			hcolor[1] = 0.0f;
ADDRLP4 12+4
CNSTF4 0
ASGNF4
line 2455
;2455:			hcolor[2] = 0.0f;
ADDRLP4 12+8
CNSTF4 0
ASGNF4
line 2456
;2456:			hcolor[3] = 0.33f;
ADDRLP4 12+12
CNSTF4 1051260355
ASGNF4
line 2457
;2457:		} else if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE ) {
ADDRGP4 $1314
JUMPV
LABELV $1313
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1319
line 2458
;2458:			hcolor[0] = 0.0f;
ADDRLP4 12
CNSTF4 0
ASGNF4
line 2459
;2459:			hcolor[1] = 0.0f;
ADDRLP4 12+4
CNSTF4 0
ASGNF4
line 2460
;2460:			hcolor[2] = 1.0f;
ADDRLP4 12+8
CNSTF4 1065353216
ASGNF4
line 2461
;2461:			hcolor[3] = 0.33f;
ADDRLP4 12+12
CNSTF4 1051260355
ASGNF4
line 2462
;2462:		} else {
ADDRGP4 $1320
JUMPV
LABELV $1319
line 2463
;2463:			hcolor[0] = 0.0f;
ADDRLP4 12
CNSTF4 0
ASGNF4
line 2464
;2464:			hcolor[1] = 1.0f;
ADDRLP4 12+4
CNSTF4 1065353216
ASGNF4
line 2465
;2465:			hcolor[2] = 0.0f;
ADDRLP4 12+8
CNSTF4 0
ASGNF4
line 2466
;2466:			hcolor[3] = 0.33f;
ADDRLP4 12+12
CNSTF4 1051260355
ASGNF4
line 2467
;2467:		}
LABELV $1320
LABELV $1314
line 2469
;2468:
;2469:		trap_R_SetColor( hcolor );
ADDRLP4 12
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2470
;2470:		CG_DrawPic( CHATLOC_X, CHATLOC_Y - h, 640, h, cgs.media.teamStatusBar );
CNSTF4 0
ARGF4
ADDRLP4 36
ADDRLP4 32
INDIRI4
ASGNI4
CNSTI4 420
ADDRLP4 36
INDIRI4
SUBI4
CVIF4 4
ARGF4
CNSTF4 1142947840
ARGF4
ADDRLP4 36
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 cgs+751220+180
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 2471
;2471:		trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2473
;2472:
;2473:		hcolor[0] = hcolor[1] = hcolor[2] = 1.0f;
ADDRLP4 40
CNSTF4 1065353216
ASGNF4
ADDRLP4 12+8
ADDRLP4 40
INDIRF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 40
INDIRF4
ASGNF4
ADDRLP4 12
ADDRLP4 40
INDIRF4
ASGNF4
line 2474
;2474:		hcolor[3] = 1.0f;
ADDRLP4 12+12
CNSTF4 1065353216
ASGNF4
line 2476
;2475:
;2476:		for (i = cgs.teamChatPos - 1; i >= cgs.teamLastChatPos; i--) {
ADDRLP4 0
ADDRGP4 cgs+162512
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRGP4 $1336
JUMPV
LABELV $1333
line 2477
;2477:			CG_DrawStringExt( CHATLOC_X + TINYCHAR_WIDTH,
CNSTI4 8
ARGI4
CNSTI4 420
ADDRGP4 cgs+162512
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 3
LSHI4
SUBI4
ARGI4
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
MODI4
CNSTI4 241
MULI4
ADDRGP4 cgs+160552
ADDP4
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
CNSTI4 8
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 2481
;2478:				CHATLOC_Y - (cgs.teamChatPos - i)*TINYCHAR_HEIGHT,
;2479:				cgs.teamChatMsgs[i % chatHeight], hcolor, qfalse, qfalse,
;2480:				TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0 );
;2481:		}
LABELV $1334
line 2476
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $1336
ADDRLP4 0
INDIRI4
ADDRGP4 cgs+162516
INDIRI4
GEI4 $1333
line 2482
;2482:	}
LABELV $1291
line 2483
;2483:}
LABELV $1284
endproc CG_DrawTeamInfo 48 36
proc CG_DrawHoldableItem 4 20
line 2492
;2484:#endif
;2485:
;2486:/*
;2487:===================
;2488:CG_DrawHoldableItem
;2489:===================
;2490:*/
;2491:#ifndef MISSIONPACK
;2492:static void CG_DrawHoldableItem( void ) {
line 2495
;2493:	int		value;
;2494:
;2495:	value = cg.snap->ps.stats[STAT_HOLDABLE_ITEM];
ADDRLP4 0
ADDRGP4 cg+36
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ASGNI4
line 2496
;2496:	if ( value ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1343
line 2497
;2497:		CG_RegisterItemVisuals( value );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_RegisterItemVisuals
CALLV
pop
line 2498
;2498:		CG_DrawPic( 640-ICON_SIZE, (SCREEN_HEIGHT-ICON_SIZE)/2, ICON_SIZE, ICON_SIZE, cg_items[ value ].icon );
CNSTF4 1142161408
ARGF4
CNSTF4 1129840640
ARGF4
CNSTF4 1111490560
ARGF4
CNSTF4 1111490560
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 cg_items+20
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 2499
;2499:	}
LABELV $1343
line 2501
;2500:
;2501:}
LABELV $1341
endproc CG_DrawHoldableItem 4 20
proc CG_DrawReward 68 36
line 2530
;2502:#endif
;2503:
;2504:#ifdef MISSIONPACK
;2505:/*
;2506:===================
;2507:CG_DrawPersistantPowerup
;2508:===================
;2509:*/
;2510:/*
;2511:static void CG_DrawPersistantPowerup( void ) {
;2512:	int		value;
;2513:
;2514:	value = cg.snap->ps.stats[STAT_PERSISTANT_POWERUP];
;2515:	if ( value ) {
;2516:		CG_RegisterItemVisuals( value );
;2517:		CG_DrawPic( 640-ICON_SIZE, (SCREEN_HEIGHT-ICON_SIZE)/2 - ICON_SIZE, ICON_SIZE, ICON_SIZE, cg_items[ value ].icon );
;2518:	}
;2519:}
;2520:*/
;2521:
;2522:#endif
;2523:
;2524:
;2525:/*
;2526:===================
;2527:CG_DrawReward
;2528:===================
;2529:*/
;2530:static void CG_DrawReward( void ) {
line 2536
;2531:	float	*color;
;2532:	int		i, count;
;2533:	float	x, y;
;2534:	char	buf[32];
;2535:
;2536:	if ( !cg_drawRewards.integer ) {
ADDRGP4 cg_drawRewards+12
INDIRI4
CNSTI4 0
NEI4 $1347
line 2537
;2537:		return;
ADDRGP4 $1346
JUMPV
LABELV $1347
line 2540
;2538:	}
;2539:
;2540:	color = CG_FadeColor( cg.rewardTime, REWARD_TIME );
ADDRGP4 cg+127740
INDIRI4
ARGI4
CNSTI4 3000
ARGI4
ADDRLP4 52
ADDRGP4 CG_FadeColor
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 52
INDIRP4
ASGNP4
line 2541
;2541:	if ( !color ) {
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1351
line 2542
;2542:		if (cg.rewardStack > 0) {
ADDRGP4 cg+127736
INDIRI4
CNSTI4 0
LEI4 $1346
line 2543
;2543:			for(i = 0; i < cg.rewardStack; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1359
JUMPV
LABELV $1356
line 2544
;2544:				cg.rewardSound[i] = cg.rewardSound[i+1];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+127824
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+127824+4
ADDP4
INDIRI4
ASGNI4
line 2545
;2545:				cg.rewardShader[i] = cg.rewardShader[i+1];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+127784
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+127784+4
ADDP4
INDIRI4
ASGNI4
line 2546
;2546:				cg.rewardCount[i] = cg.rewardCount[i+1];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+127744
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+127744+4
ADDP4
INDIRI4
ASGNI4
line 2547
;2547:			}
LABELV $1357
line 2543
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1359
ADDRLP4 0
INDIRI4
ADDRGP4 cg+127736
INDIRI4
LTI4 $1356
line 2548
;2548:			cg.rewardTime = cg.time;
ADDRGP4 cg+127740
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 2549
;2549:			cg.rewardStack--;
ADDRLP4 56
ADDRGP4 cg+127736
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2550
;2550:			color = CG_FadeColor( cg.rewardTime, REWARD_TIME );
ADDRGP4 cg+127740
INDIRI4
ARGI4
CNSTI4 3000
ARGI4
ADDRLP4 60
ADDRGP4 CG_FadeColor
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 60
INDIRP4
ASGNP4
line 2551
;2551:			trap_S_StartLocalSound(cg.rewardSound[0], CHAN_ANNOUNCER);
ADDRGP4 cg+127824
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 2552
;2552:		} else {
line 2553
;2553:			return;
LABELV $1354
line 2555
;2554:		}
;2555:	}
LABELV $1351
line 2557
;2556:
;2557:	trap_R_SetColor( color );
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2574
;2558:
;2559:	/*
;2560:	count = cg.rewardCount[0]/10;				// number of big rewards to draw
;2561:
;2562:	if (count) {
;2563:		y = 4;
;2564:		x = 320 - count * ICON_SIZE;
;2565:		for ( i = 0 ; i < count ; i++ ) {
;2566:			CG_DrawPic( x, y, (ICON_SIZE*2)-4, (ICON_SIZE*2)-4, cg.rewardShader[0] );
;2567:			x += (ICON_SIZE*2);
;2568:		}
;2569:	}
;2570:
;2571:	count = cg.rewardCount[0] - count*10;		// number of small rewards to draw
;2572:	*/
;2573:
;2574:	if ( cg.rewardCount[0] >= 10 ) {
ADDRGP4 cg+127744
INDIRI4
CNSTI4 10
LTI4 $1375
line 2575
;2575:		y = 56;
ADDRLP4 8
CNSTF4 1113587712
ASGNF4
line 2576
;2576:		x = 320 - ICON_SIZE/2;
ADDRLP4 4
CNSTF4 1133772800
ASGNF4
line 2577
;2577:		CG_DrawPic( x, y, ICON_SIZE-4, ICON_SIZE-4, cg.rewardShader[0] );
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
CNSTF4 1110441984
ARGF4
CNSTF4 1110441984
ARGF4
ADDRGP4 cg+127784
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 2578
;2578:		Com_sprintf(buf, sizeof(buf), "%d", cg.rewardCount[0]);
ADDRLP4 20
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $1379
ARGP4
ADDRGP4 cg+127744
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 2579
;2579:		x = ( SCREEN_WIDTH - SMALLCHAR_WIDTH * CG_DrawStrlen( buf ) ) / 2;
ADDRLP4 20
ARGP4
ADDRLP4 56
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 4
CNSTI4 640
ADDRLP4 56
INDIRI4
CNSTI4 3
LSHI4
SUBI4
CNSTI4 2
DIVI4
CVIF4 4
ASGNF4
line 2580
;2580:		CG_DrawStringExt( x, y+ICON_SIZE, buf, color, qfalse, qtrue,
ADDRLP4 4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 8
INDIRF4
CNSTF4 1111490560
ADDF4
CVFI4 4
ARGI4
ADDRLP4 20
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
CNSTI4 8
ARGI4
CNSTI4 16
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 2582
;2581:								SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0 );
;2582:	}
ADDRGP4 $1376
JUMPV
LABELV $1375
line 2583
;2583:	else {
line 2585
;2584:
;2585:		count = cg.rewardCount[0];
ADDRLP4 12
ADDRGP4 cg+127744
INDIRI4
ASGNI4
line 2587
;2586:
;2587:		y = 56;
ADDRLP4 8
CNSTF4 1113587712
ASGNF4
line 2588
;2588:		x = 320 - count * ICON_SIZE/2;
ADDRLP4 4
CNSTI4 320
ADDRLP4 12
INDIRI4
CNSTI4 48
MULI4
CNSTI4 2
DIVI4
SUBI4
CVIF4 4
ASGNF4
line 2589
;2589:		for ( i = 0 ; i < count ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1385
JUMPV
LABELV $1382
line 2590
;2590:			CG_DrawPic( x, y, ICON_SIZE-4, ICON_SIZE-4, cg.rewardShader[0] );
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
CNSTF4 1110441984
ARGF4
CNSTF4 1110441984
ARGF4
ADDRGP4 cg+127784
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 2591
;2591:			x += ICON_SIZE;
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1111490560
ADDF4
ASGNF4
line 2592
;2592:		}
LABELV $1383
line 2589
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1385
ADDRLP4 0
INDIRI4
ADDRLP4 12
INDIRI4
LTI4 $1382
line 2593
;2593:	}
LABELV $1376
line 2594
;2594:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2595
;2595:}
LABELV $1346
endproc CG_DrawReward 68 36
export CG_AddLagometerFrameInfo
proc CG_AddLagometerFrameInfo 8 0
line 2626
;2596:
;2597:
;2598:/*
;2599:===============================================================================
;2600:
;2601:LAGOMETER
;2602:
;2603:===============================================================================
;2604:*/
;2605:
;2606:#define	LAG_SAMPLES		128
;2607:
;2608:
;2609:typedef struct {
;2610:	int		frameSamples[LAG_SAMPLES];
;2611:	int		frameCount;
;2612:	int		snapshotFlags[LAG_SAMPLES];
;2613:	int		snapshotSamples[LAG_SAMPLES];
;2614:	int		snapshotCount;
;2615:} lagometer_t;
;2616:
;2617:lagometer_t		lagometer;
;2618:
;2619:/*
;2620:==============
;2621:CG_AddLagometerFrameInfo
;2622:
;2623:Adds the current interpolate / extrapolate bar for this frame
;2624:==============
;2625:*/
;2626:void CG_AddLagometerFrameInfo( void ) {
line 2629
;2627:	int			offset;
;2628:
;2629:	offset = cg.time - cg.latestSnapshotTime;
ADDRLP4 0
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cg+32
INDIRI4
SUBI4
ASGNI4
line 2630
;2630:	lagometer.frameSamples[ lagometer.frameCount & ( LAG_SAMPLES - 1) ] = offset;
ADDRGP4 lagometer+512
INDIRI4
CNSTI4 127
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 2631
;2631:	lagometer.frameCount++;
ADDRLP4 4
ADDRGP4 lagometer+512
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2632
;2632:}
LABELV $1388
endproc CG_AddLagometerFrameInfo 8 0
export CG_AddLagometerSnapshotInfo
proc CG_AddLagometerSnapshotInfo 4 0
line 2644
;2633:
;2634:/*
;2635:==============
;2636:CG_AddLagometerSnapshotInfo
;2637:
;2638:Each time a snapshot is received, log its ping time and
;2639:the number of snapshots that were dropped before it.
;2640:
;2641:Pass NULL for a dropped packet.
;2642:==============
;2643:*/
;2644:void CG_AddLagometerSnapshotInfo( snapshot_t *snap ) {
line 2646
;2645:	// dropped packet
;2646:	if ( !snap ) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1394
line 2647
;2647:		lagometer.snapshotSamples[ lagometer.snapshotCount & ( LAG_SAMPLES - 1) ] = -1;
ADDRGP4 lagometer+1540
INDIRI4
CNSTI4 127
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer+1028
ADDP4
CNSTI4 -1
ASGNI4
line 2648
;2648:		lagometer.snapshotCount++;
ADDRLP4 0
ADDRGP4 lagometer+1540
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2649
;2649:		return;
ADDRGP4 $1393
JUMPV
LABELV $1394
line 2653
;2650:	}
;2651:
;2652:	// add this snapshot's info
;2653:	lagometer.snapshotSamples[ lagometer.snapshotCount & ( LAG_SAMPLES - 1) ] = snap->ping;
ADDRGP4 lagometer+1540
INDIRI4
CNSTI4 127
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer+1028
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 2654
;2654:	lagometer.snapshotFlags[ lagometer.snapshotCount & ( LAG_SAMPLES - 1) ] = snap->snapFlags;
ADDRGP4 lagometer+1540
INDIRI4
CNSTI4 127
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer+516
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 2655
;2655:	lagometer.snapshotCount++;
ADDRLP4 0
ADDRGP4 lagometer+1540
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2656
;2656:}
LABELV $1393
endproc CG_AddLagometerSnapshotInfo 4 0
proc CG_DrawDisconnect 60 20
line 2665
;2657:
;2658:/*
;2659:==============
;2660:CG_DrawDisconnect
;2661:
;2662:Should we draw something differnet for long lag vs no packets?
;2663:==============
;2664:*/
;2665:static void CG_DrawDisconnect( void ) {
line 2673
;2666:	float		x, y;
;2667:	int			cmdNum;
;2668:	usercmd_t	cmd;
;2669:	const char		*s;
;2670:	int			w;  // bk010215 - FIXME char message[1024];
;2671:
;2672:	// draw the phone jack if we are completely past our buffers
;2673:	cmdNum = trap_GetCurrentCmdNumber() - CMD_BACKUP + 1;
ADDRLP4 44
ADDRGP4 trap_GetCurrentCmdNumber
CALLI4
ASGNI4
ADDRLP4 36
ADDRLP4 44
INDIRI4
CNSTI4 64
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 2674
;2674:	trap_GetUserCmd( cmdNum, &cmd );
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_GetUserCmd
CALLI4
pop
line 2675
;2675:	if ( cmd.serverTime <= cg.snap->ps.commandTime
ADDRLP4 48
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 48
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
LEI4 $1409
ADDRLP4 48
INDIRI4
ADDRGP4 cg+107656
INDIRI4
LEI4 $1405
LABELV $1409
line 2676
;2676:		|| cmd.serverTime > cg.time ) {	// special check for map_restart // bk 0102165 - FIXME
line 2677
;2677:		return;
ADDRGP4 $1404
JUMPV
LABELV $1405
line 2681
;2678:	}
;2679:
;2680:	// also add text in center of screen
;2681:	s = "Connection Interrupted"; // bk 010215 - FIXME
ADDRLP4 24
ADDRGP4 $1410
ASGNP4
line 2682
;2682:	w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 52
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 2683
;2683:	CG_DrawBigString( 320 - w/2, 100, s, 1.0F);
CNSTI4 320
ADDRLP4 40
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 100
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 2686
;2684:
;2685:	// blink the icon
;2686:	if ( ( cg.time >> 9 ) & 1 ) {
ADDRGP4 cg+107656
INDIRI4
CNSTI4 9
RSHI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1411
line 2687
;2687:		return;
ADDRGP4 $1404
JUMPV
LABELV $1411
line 2690
;2688:	}
;2689:
;2690:	x = 640 - 48;
ADDRLP4 28
CNSTF4 1142161408
ASGNF4
line 2691
;2691:	y = 480 - 48;
ADDRLP4 32
CNSTF4 1138229248
ASGNF4
line 2693
;2692:
;2693:	CG_DrawPic( x, y, 48, 48, trap_R_RegisterShader("gfx/2d/net.tga" ) );
ADDRGP4 $1414
ARGP4
ADDRLP4 56
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
CNSTF4 1111490560
ARGF4
CNSTF4 1111490560
ARGF4
ADDRLP4 56
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 2694
;2694:}
LABELV $1404
endproc CG_DrawDisconnect 60 20
proc CG_DrawLagometer 56 36
line 2705
;2695:
;2696:
;2697:#define	MAX_LAGOMETER_PING	900
;2698:#define	MAX_LAGOMETER_RANGE	300
;2699:
;2700:/*
;2701:==============
;2702:CG_DrawLagometer
;2703:==============
;2704:*/
;2705:static void CG_DrawLagometer( void ) {
line 2712
;2706:	int		a, x, y, i;
;2707:	float	v;
;2708:	float	ax, ay, aw, ah, mid, range;
;2709:	int		color;
;2710:	float	vscale;
;2711:
;2712:	if ( !cg_lagometer.integer || cgs.localServer ) {
ADDRGP4 cg_lagometer+12
INDIRI4
CNSTI4 0
EQI4 $1420
ADDRGP4 cgs+31452
INDIRI4
CNSTI4 0
EQI4 $1416
LABELV $1420
line 2713
;2713:		CG_DrawDisconnect();
ADDRGP4 CG_DrawDisconnect
CALLV
pop
line 2714
;2714:		return;
ADDRGP4 $1415
JUMPV
LABELV $1416
line 2724
;2715:	}
;2716:
;2717:	//
;2718:	// draw the graph
;2719:	//
;2720:#ifdef MISSIONPACK
;2721:	x = 640 - 48;
;2722:	y = 480 - 144;
;2723:#else
;2724:	x = 640 - 48;
ADDRLP4 44
CNSTI4 592
ASGNI4
line 2725
;2725:	y = 480 - 48;
ADDRLP4 48
CNSTI4 432
ASGNI4
line 2728
;2726:#endif
;2727:
;2728:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2729
;2729:	CG_DrawPic( x, y, 48, 48, cgs.media.lagometerShader );
ADDRLP4 44
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 48
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1111490560
ARGF4
CNSTF4 1111490560
ARGF4
ADDRGP4 cgs+751220+432
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 2731
;2730:
;2731:	ax = x;
ADDRLP4 24
ADDRLP4 44
INDIRI4
CVIF4 4
ASGNF4
line 2732
;2732:	ay = y;
ADDRLP4 36
ADDRLP4 48
INDIRI4
CVIF4 4
ASGNF4
line 2733
;2733:	aw = 48;
ADDRLP4 12
CNSTF4 1111490560
ASGNF4
line 2734
;2734:	ah = 48;
ADDRLP4 32
CNSTF4 1111490560
ASGNF4
line 2735
;2735:	CG_AdjustFrom640( &ax, &ay, &aw, &ah );
ADDRLP4 24
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 32
ARGP4
ADDRGP4 CG_AdjustFrom640
CALLV
pop
line 2737
;2736:
;2737:	color = -1;
ADDRLP4 20
CNSTI4 -1
ASGNI4
line 2738
;2738:	range = ah / 3;
ADDRLP4 16
ADDRLP4 32
INDIRF4
CNSTF4 1051372203
MULF4
ASGNF4
line 2739
;2739:	mid = ay + range;
ADDRLP4 40
ADDRLP4 36
INDIRF4
ADDRLP4 16
INDIRF4
ADDF4
ASGNF4
line 2741
;2740:
;2741:	vscale = range / MAX_LAGOMETER_RANGE;
ADDRLP4 28
ADDRLP4 16
INDIRF4
CNSTF4 995783694
MULF4
ASGNF4
line 2744
;2742:
;2743:	// draw the frame interpoalte / extrapolate graph
;2744:	for ( a = 0 ; a < aw ; a++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $1426
JUMPV
LABELV $1423
line 2745
;2745:		i = ( lagometer.frameCount - 1 - a ) & (LAG_SAMPLES - 1);
ADDRLP4 8
ADDRGP4 lagometer+512
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 127
BANDI4
ASGNI4
line 2746
;2746:		v = lagometer.frameSamples[i];
ADDRLP4 0
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 2747
;2747:		v *= vscale;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 2748
;2748:		if ( v > 0 ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
LEF4 $1428
line 2749
;2749:			if ( color != 1 ) {
ADDRLP4 20
INDIRI4
CNSTI4 1
EQI4 $1430
line 2750
;2750:				color = 1;
ADDRLP4 20
CNSTI4 1
ASGNI4
line 2751
;2751:				trap_R_SetColor( g_color_table[ColorIndex(COLOR_YELLOW)] );
ADDRGP4 g_color_table+48
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2752
;2752:			}
LABELV $1430
line 2753
;2753:			if ( v > range ) {
ADDRLP4 0
INDIRF4
ADDRLP4 16
INDIRF4
LEF4 $1433
line 2754
;2754:				v = range;
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 2755
;2755:			}
LABELV $1433
line 2756
;2756:			trap_R_DrawStretchPic ( ax + aw - a, mid - v, 1, v, 0, 0, 0, 0, cgs.media.whiteShader );
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ADDRLP4 4
INDIRI4
CVIF4 4
SUBF4
ARGF4
ADDRLP4 40
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 cgs+751220+48
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 2757
;2757:		} else if ( v < 0 ) {
ADDRGP4 $1429
JUMPV
LABELV $1428
ADDRLP4 0
INDIRF4
CNSTF4 0
GEF4 $1437
line 2758
;2758:			if ( color != 2 ) {
ADDRLP4 20
INDIRI4
CNSTI4 2
EQI4 $1439
line 2759
;2759:				color = 2;
ADDRLP4 20
CNSTI4 2
ASGNI4
line 2760
;2760:				trap_R_SetColor( g_color_table[ColorIndex(COLOR_BLUE)] );
ADDRGP4 g_color_table+64
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2761
;2761:			}
LABELV $1439
line 2762
;2762:			v = -v;
ADDRLP4 0
ADDRLP4 0
INDIRF4
NEGF4
ASGNF4
line 2763
;2763:			if ( v > range ) {
ADDRLP4 0
INDIRF4
ADDRLP4 16
INDIRF4
LEF4 $1442
line 2764
;2764:				v = range;
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 2765
;2765:			}
LABELV $1442
line 2766
;2766:			trap_R_DrawStretchPic( ax + aw - a, mid, 1, v, 0, 0, 0, 0, cgs.media.whiteShader );
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ADDRLP4 4
INDIRI4
CVIF4 4
SUBF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 cgs+751220+48
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 2767
;2767:		}
LABELV $1437
LABELV $1429
line 2768
;2768:	}
LABELV $1424
line 2744
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1426
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRLP4 12
INDIRF4
LTF4 $1423
line 2771
;2769:
;2770:	// draw the snapshot latency / drop graph
;2771:	range = ah / 2;
ADDRLP4 16
ADDRLP4 32
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 2772
;2772:	vscale = range / MAX_LAGOMETER_PING;
ADDRLP4 28
ADDRLP4 16
INDIRF4
CNSTF4 982622900
MULF4
ASGNF4
line 2774
;2773:
;2774:	for ( a = 0 ; a < aw ; a++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $1449
JUMPV
LABELV $1446
line 2775
;2775:		i = ( lagometer.snapshotCount - 1 - a ) & (LAG_SAMPLES - 1);
ADDRLP4 8
ADDRGP4 lagometer+1540
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 127
BANDI4
ASGNI4
line 2776
;2776:		v = lagometer.snapshotSamples[i];
ADDRLP4 0
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer+1028
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 2777
;2777:		if ( v > 0 ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
LEF4 $1452
line 2778
;2778:			if ( lagometer.snapshotFlags[i] & SNAPFLAG_RATE_DELAYED ) {
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer+516
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1454
line 2779
;2779:				if ( color != 5 ) {
ADDRLP4 20
INDIRI4
CNSTI4 5
EQI4 $1455
line 2780
;2780:					color = 5;	// YELLOW for rate delay
ADDRLP4 20
CNSTI4 5
ASGNI4
line 2781
;2781:					trap_R_SetColor( g_color_table[ColorIndex(COLOR_YELLOW)] );
ADDRGP4 g_color_table+48
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2782
;2782:				}
line 2783
;2783:			} else {
ADDRGP4 $1455
JUMPV
LABELV $1454
line 2784
;2784:				if ( color != 3 ) {
ADDRLP4 20
INDIRI4
CNSTI4 3
EQI4 $1460
line 2785
;2785:					color = 3;
ADDRLP4 20
CNSTI4 3
ASGNI4
line 2786
;2786:					trap_R_SetColor( g_color_table[ColorIndex(COLOR_GREEN)] );
ADDRGP4 g_color_table+32
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2787
;2787:				}
LABELV $1460
line 2788
;2788:			}
LABELV $1455
line 2789
;2789:			v = v * vscale;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 2790
;2790:			if ( v > range ) {
ADDRLP4 0
INDIRF4
ADDRLP4 16
INDIRF4
LEF4 $1463
line 2791
;2791:				v = range;
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 2792
;2792:			}
LABELV $1463
line 2793
;2793:			trap_R_DrawStretchPic( ax + aw - a, ay + ah - v, 1, v, 0, 0, 0, 0, cgs.media.whiteShader );
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ADDRLP4 4
INDIRI4
CVIF4 4
SUBF4
ARGF4
ADDRLP4 36
INDIRF4
ADDRLP4 32
INDIRF4
ADDF4
ADDRLP4 0
INDIRF4
SUBF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 cgs+751220+48
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 2794
;2794:		} else if ( v < 0 ) {
ADDRGP4 $1453
JUMPV
LABELV $1452
ADDRLP4 0
INDIRF4
CNSTF4 0
GEF4 $1467
line 2795
;2795:			if ( color != 4 ) {
ADDRLP4 20
INDIRI4
CNSTI4 4
EQI4 $1469
line 2796
;2796:				color = 4;		// RED for dropped snapshots
ADDRLP4 20
CNSTI4 4
ASGNI4
line 2797
;2797:				trap_R_SetColor( g_color_table[ColorIndex(COLOR_RED)] );
ADDRGP4 g_color_table+16
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2798
;2798:			}
LABELV $1469
line 2799
;2799:			trap_R_DrawStretchPic( ax + aw - a, ay + ah - range, 1, range, 0, 0, 0, 0, cgs.media.whiteShader );
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ADDRLP4 4
INDIRI4
CVIF4 4
SUBF4
ARGF4
ADDRLP4 36
INDIRF4
ADDRLP4 32
INDIRF4
ADDF4
ADDRLP4 16
INDIRF4
SUBF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 cgs+751220+48
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 2800
;2800:		}
LABELV $1467
LABELV $1453
line 2801
;2801:	}
LABELV $1447
line 2774
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1449
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRLP4 12
INDIRF4
LTF4 $1446
line 2803
;2802:
;2803:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2805
;2804:
;2805:	if ( cg_nopredict.integer || cg_synchronousClients.integer ) {
ADDRGP4 cg_nopredict+12
INDIRI4
CNSTI4 0
NEI4 $1478
ADDRGP4 cg_synchronousClients+12
INDIRI4
CNSTI4 0
EQI4 $1474
LABELV $1478
line 2806
;2806:		CG_DrawBigString( ax, ay, "snc", 1.0 );
ADDRLP4 24
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 36
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 $1479
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 2807
;2807:	}
LABELV $1474
line 2809
;2808:
;2809:	CG_DrawDisconnect();
ADDRGP4 CG_DrawDisconnect
CALLV
pop
line 2810
;2810:}
LABELV $1415
endproc CG_DrawLagometer 56 36
export CG_CenterPrint
proc CG_CenterPrint 8 12
line 2831
;2811:
;2812:
;2813:
;2814:/*
;2815:===============================================================================
;2816:
;2817:CENTER PRINTING
;2818:
;2819:===============================================================================
;2820:*/
;2821:
;2822:
;2823:/*
;2824:==============
;2825:CG_CenterPrint
;2826:
;2827:Called for important messages that should stay in the center of the screen
;2828:for a few moments
;2829:==============
;2830:*/
;2831:void CG_CenterPrint( const char *str, int y, int charWidth ) {
line 2834
;2832:	char	*s;
;2833:
;2834:	Q_strncpyz( cg.centerPrint, str, sizeof(cg.centerPrint) );
ADDRGP4 cg+126676
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 2836
;2835:
;2836:	cg.centerPrintTime = cg.time;
ADDRGP4 cg+126664
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 2837
;2837:	cg.centerPrintY = y;
ADDRGP4 cg+126672
ADDRFP4 4
INDIRI4
ASGNI4
line 2838
;2838:	cg.centerPrintCharWidth = charWidth;
ADDRGP4 cg+126668
ADDRFP4 8
INDIRI4
ASGNI4
line 2841
;2839:
;2840:	// count the number of lines for centering
;2841:	cg.centerPrintLines = 1;
ADDRGP4 cg+127700
CNSTI4 1
ASGNI4
line 2842
;2842:	s = cg.centerPrint;
ADDRLP4 0
ADDRGP4 cg+126676
ASGNP4
ADDRGP4 $1490
JUMPV
LABELV $1489
line 2843
;2843:	while( *s ) {
line 2844
;2844:		if (*s == '\n')
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 10
NEI4 $1492
line 2845
;2845:			cg.centerPrintLines++;
ADDRLP4 4
ADDRGP4 cg+127700
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1492
line 2846
;2846:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 2847
;2847:	}
LABELV $1490
line 2843
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1489
line 2848
;2848:}
LABELV $1480
endproc CG_CenterPrint 8 12
proc CG_DrawCenterString 1060 36
line 2856
;2849:
;2850:
;2851:/*
;2852:===================
;2853:CG_DrawCenterString
;2854:===================
;2855:*/
;2856:static void CG_DrawCenterString( void ) {
line 2865
;2857:	char	*start;
;2858:	int		l;
;2859:	int		x, y, w;
;2860:#ifdef MISSIONPACK // bk010221 - unused else
;2861:  int h;
;2862:#endif
;2863:	float	*color;
;2864:
;2865:	if ( !cg.centerPrintTime ) {
ADDRGP4 cg+126664
INDIRI4
CNSTI4 0
NEI4 $1496
line 2866
;2866:		return;
ADDRGP4 $1495
JUMPV
LABELV $1496
line 2869
;2867:	}
;2868:
;2869:	color = CG_FadeColor( cg.centerPrintTime, 1000 * cg_centertime.value );
ADDRGP4 cg+126664
INDIRI4
ARGI4
ADDRGP4 cg_centertime+8
INDIRF4
CNSTF4 1148846080
MULF4
CVFI4 4
ARGI4
ADDRLP4 24
ADDRGP4 CG_FadeColor
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 24
INDIRP4
ASGNP4
line 2870
;2870:	if ( !color ) {
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1501
line 2871
;2871:		return;
ADDRGP4 $1495
JUMPV
LABELV $1501
line 2874
;2872:	}
;2873:
;2874:	trap_R_SetColor( color );
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2876
;2875:
;2876:	start = cg.centerPrint;
ADDRLP4 0
ADDRGP4 cg+126676
ASGNP4
line 2878
;2877:
;2878:	y = cg.centerPrintY - cg.centerPrintLines * BIGCHAR_HEIGHT / 2;
ADDRLP4 8
ADDRGP4 cg+126672
INDIRI4
ADDRGP4 cg+127700
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 2
DIVI4
SUBI4
ASGNI4
ADDRGP4 $1507
JUMPV
LABELV $1506
line 2880
;2879:
;2880:	while ( 1 ) {
line 2883
;2881:		char linebuffer[1024];
;2882:
;2883:		for ( l = 0; l < 50; l++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $1509
line 2884
;2884:			if ( !start[l] || start[l] == '\n' ) {
ADDRLP4 1052
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 0
EQI4 $1515
ADDRLP4 1052
INDIRI4
CNSTI4 10
NEI4 $1513
LABELV $1515
line 2885
;2885:				break;
ADDRGP4 $1511
JUMPV
LABELV $1513
line 2887
;2886:			}
;2887:			linebuffer[l] = start[l];
ADDRLP4 4
INDIRI4
ADDRLP4 28
ADDP4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
ADDP4
INDIRI1
ASGNI1
line 2888
;2888:		}
LABELV $1510
line 2883
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 50
LTI4 $1509
LABELV $1511
line 2889
;2889:		linebuffer[l] = 0;
ADDRLP4 4
INDIRI4
ADDRLP4 28
ADDP4
CNSTI1 0
ASGNI1
line 2898
;2890:
;2891:#ifdef MISSIONPACK
;2892:		w = CG_Text_Width(linebuffer, 0.5, 0);
;2893:		h = CG_Text_Height(linebuffer, 0.5, 0);
;2894:		x = (SCREEN_WIDTH - w) / 2;
;2895:		CG_Text_Paint(x, y + h, 0.5, color, linebuffer, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE);
;2896:		y += h + 6;
;2897:#else
;2898:		w = cg.centerPrintCharWidth * CG_DrawStrlen( linebuffer );
ADDRLP4 28
ARGP4
ADDRLP4 1052
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRGP4 cg+126668
INDIRI4
ADDRLP4 1052
INDIRI4
MULI4
ASGNI4
line 2900
;2899:
;2900:		x = ( SCREEN_WIDTH - w ) / 2;
ADDRLP4 12
CNSTI4 640
ADDRLP4 16
INDIRI4
SUBI4
CNSTI4 2
DIVI4
ASGNI4
line 2902
;2901:
;2902:		CG_DrawStringExt( x, y, linebuffer, color, qfalse, qtrue,
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 28
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 cg+126668
INDIRI4
ARGI4
ADDRGP4 cg+126668
INDIRI4
CVIF4 4
CNSTF4 1069547520
MULF4
CVFI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 2905
;2903:			cg.centerPrintCharWidth, (int)(cg.centerPrintCharWidth * 1.5), 0 );
;2904:
;2905:		y += cg.centerPrintCharWidth * 1.5;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CVIF4 4
ADDRGP4 cg+126668
INDIRI4
CVIF4 4
CNSTF4 1069547520
MULF4
ADDF4
CVFI4 4
ASGNI4
ADDRGP4 $1521
JUMPV
LABELV $1520
line 2907
;2906:#endif
;2907:		while ( *start && ( *start != '\n' ) ) {
line 2908
;2908:			start++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 2909
;2909:		}
LABELV $1521
line 2907
ADDRLP4 1056
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
EQI4 $1523
ADDRLP4 1056
INDIRI4
CNSTI4 10
NEI4 $1520
LABELV $1523
line 2910
;2910:		if ( !*start ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1524
line 2911
;2911:			break;
ADDRGP4 $1508
JUMPV
LABELV $1524
line 2913
;2912:		}
;2913:		start++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 2914
;2914:	}
LABELV $1507
line 2880
ADDRGP4 $1506
JUMPV
LABELV $1508
line 2916
;2915:
;2916:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2917
;2917:}
LABELV $1495
endproc CG_DrawCenterString 1060 36
proc CG_DrawCrosshair 44 36
line 2935
;2918:
;2919:
;2920:
;2921:/*
;2922:================================================================================
;2923:
;2924:CROSSHAIR
;2925:
;2926:================================================================================
;2927:*/
;2928:
;2929:
;2930:/*
;2931:=================
;2932:CG_DrawCrosshair
;2933:=================
;2934:*/
;2935:static void CG_DrawCrosshair(void) {
line 2942
;2936:	float		w, h;
;2937:	qhandle_t	hShader;
;2938:	float		f;
;2939:	float		x, y;
;2940:	int			ca;
;2941:
;2942:	if (cg.tssInterfaceOn) return;	// JUHOX
ADDRGP4 cg+128100
INDIRI4
CNSTI4 0
EQI4 $1527
ADDRGP4 $1526
JUMPV
LABELV $1527
line 2943
;2943:	if ( !cg_drawCrosshair.integer ) {
ADDRGP4 cg_drawCrosshair+12
INDIRI4
CNSTI4 0
NEI4 $1530
line 2944
;2944:		return;
ADDRGP4 $1526
JUMPV
LABELV $1530
line 2947
;2945:	}
;2946:
;2947:	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1533
line 2948
;2948:		return;
ADDRGP4 $1526
JUMPV
LABELV $1533
line 2951
;2949:	}
;2950:
;2951:	if ( cg.renderingThirdPerson ) {
ADDRGP4 cg+107680
INDIRI4
CNSTI4 0
EQI4 $1536
line 2952
;2952:		return;
ADDRGP4 $1526
JUMPV
LABELV $1536
line 2956
;2953:	}
;2954:
;2955:	// set color based on health
;2956:	if ( cg_crosshairHealth.integer ) {
ADDRGP4 cg_crosshairHealth+12
INDIRI4
CNSTI4 0
EQI4 $1539
line 2959
;2957:		vec4_t		hcolor;
;2958:
;2959:		CG_ColorForHealth( hcolor );
ADDRLP4 28
ARGP4
ADDRGP4 CG_ColorForHealth
CALLV
pop
line 2960
;2960:		trap_R_SetColor( hcolor );
ADDRLP4 28
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2961
;2961:	} else {
ADDRGP4 $1540
JUMPV
LABELV $1539
line 2962
;2962:		trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2963
;2963:	}
LABELV $1540
line 2965
;2964:
;2965:	w = h = cg_crosshairSize.value;
ADDRLP4 28
ADDRGP4 cg_crosshairSize+8
INDIRF4
ASGNF4
ADDRLP4 4
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 28
INDIRF4
ASGNF4
line 2968
;2966:
;2967:	// pulse the size of the crosshair when picking up items
;2968:	f = cg.time - cg.itemPickupBlendTime;
ADDRLP4 8
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cg+127984
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 2969
;2969:	if ( f > 0 && f < ITEM_BLOB_TIME ) {
ADDRLP4 8
INDIRF4
CNSTF4 0
LEF4 $1545
ADDRLP4 8
INDIRF4
CNSTF4 1128792064
GEF4 $1545
line 2970
;2970:		f /= ITEM_BLOB_TIME;
ADDRLP4 8
ADDRLP4 8
INDIRF4
CNSTF4 1000593162
MULF4
ASGNF4
line 2971
;2971:		w *= ( 1 + f );
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 8
INDIRF4
CNSTF4 1065353216
ADDF4
MULF4
ASGNF4
line 2972
;2972:		h *= ( 1 + f );
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
CNSTF4 1065353216
ADDF4
MULF4
ASGNF4
line 2973
;2973:	}
LABELV $1545
line 2975
;2974:
;2975:	x = cg_crosshairX.integer;
ADDRLP4 16
ADDRGP4 cg_crosshairX+12
INDIRI4
CVIF4 4
ASGNF4
line 2976
;2976:	y = cg_crosshairY.integer;
ADDRLP4 20
ADDRGP4 cg_crosshairY+12
INDIRI4
CVIF4 4
ASGNF4
line 2977
;2977:	CG_AdjustFrom640( &x, &y, &w, &h );
ADDRLP4 16
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 CG_AdjustFrom640
CALLV
pop
line 2979
;2978:
;2979:	ca = cg_drawCrosshair.integer;
ADDRLP4 12
ADDRGP4 cg_drawCrosshair+12
INDIRI4
ASGNI4
line 2980
;2980:	if (ca < 0) {
ADDRLP4 12
INDIRI4
CNSTI4 0
GEI4 $1550
line 2981
;2981:		ca = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 2982
;2982:	}
LABELV $1550
line 2983
;2983:	hShader = cgs.media.crosshairShader[ ca % NUM_CROSSHAIRS ];
ADDRLP4 24
ADDRLP4 12
INDIRI4
CNSTI4 10
MODI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+751220+392
ADDP4
INDIRI4
ASGNI4
line 2985
;2984:
;2985:	trap_R_DrawStretchPic( x + cg.refdef.x + 0.5 * (cg.refdef.width - w),
ADDRLP4 36
ADDRLP4 0
INDIRF4
ASGNF4
ADDRLP4 16
INDIRF4
ADDRGP4 cg+109260
INDIRI4
CVIF4 4
ADDF4
ADDRGP4 cg+109260+8
INDIRI4
CVIF4 4
ADDRLP4 36
INDIRF4
SUBF4
CNSTF4 1056964608
MULF4
ADDF4
ARGF4
ADDRLP4 40
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 20
INDIRF4
ADDRGP4 cg+109260+4
INDIRI4
CVIF4 4
ADDF4
ADDRGP4 cg+109260+12
INDIRI4
CVIF4 4
ADDRLP4 40
INDIRF4
SUBF4
CNSTF4 1056964608
MULF4
ADDF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 24
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 2988
;2986:		y + cg.refdef.y + 0.5 * (cg.refdef.height - h),
;2987:		w, h, 0, 0, 1, 1, hShader );
;2988:}
LABELV $1526
endproc CG_DrawCrosshair 44 36
proc CG_ScanForCrosshairEntity 92 28
line 2997
;2989:
;2990:
;2991:
;2992:/*
;2993:=================
;2994:CG_ScanForCrosshairEntity
;2995:=================
;2996:*/
;2997:static void CG_ScanForCrosshairEntity( void ) {
line 3002
;2998:	trace_t		trace;
;2999:	vec3_t		start, end;
;3000:	int			content;
;3001:
;3002:	VectorCopy( cg.refdef.vieworg, start );
ADDRLP4 56
ADDRGP4 cg+109260+24
INDIRB
ASGNB 12
line 3003
;3003:	VectorMA( start, 131072, cg.refdef.viewaxis[0], end );
ADDRLP4 68
ADDRLP4 56
INDIRF4
ADDRGP4 cg+109260+36
INDIRF4
CNSTF4 1207959552
MULF4
ADDF4
ASGNF4
ADDRLP4 68+4
ADDRLP4 56+4
INDIRF4
ADDRGP4 cg+109260+36+4
INDIRF4
CNSTF4 1207959552
MULF4
ADDF4
ASGNF4
ADDRLP4 68+8
ADDRLP4 56+8
INDIRF4
ADDRGP4 cg+109260+36+8
INDIRF4
CNSTF4 1207959552
MULF4
ADDF4
ASGNF4
line 3005
;3004:
;3005:	CG_Trace( &trace, start, vec3_origin, vec3_origin, end,
ADDRLP4 0
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 84
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 84
INDIRP4
ARGP4
ADDRLP4 84
INDIRP4
ARGP4
ADDRLP4 68
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
CNSTI4 33554433
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 3007
;3006:		cg.snap->ps.clientNum, CONTENTS_SOLID|CONTENTS_BODY );
;3007:	if ( trace.entityNum >= MAX_CLIENTS ) {
ADDRLP4 0+52
INDIRI4
CNSTI4 64
LTI4 $1577
line 3008
;3008:		return;
ADDRGP4 $1561
JUMPV
LABELV $1577
line 3012
;3009:	}
;3010:
;3011:	// if the player is in fog, don't show it
;3012:	content = trap_CM_PointContents( trace.endpos, 0 );
ADDRLP4 0+12
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 88
ADDRGP4 trap_CM_PointContents
CALLI4
ASGNI4
ADDRLP4 80
ADDRLP4 88
INDIRI4
ASGNI4
line 3013
;3013:	if ( content & CONTENTS_FOG ) {
ADDRLP4 80
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $1581
line 3014
;3014:		return;
ADDRGP4 $1561
JUMPV
LABELV $1581
line 3018
;3015:	}
;3016:
;3017:	// if the player is invisible, don't show it
;3018:	if ( cg_entities[ trace.entityNum ].currentState.powerups & ( 1 << PW_INVIS ) ) {
ADDRLP4 0+52
INDIRI4
CNSTI4 880
MULI4
ADDRGP4 cg_entities+188
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1583
line 3023
;3019:		// JUHOX: if the player is on same team show the name
;3020:#if 0
;3021:		return;
;3022:#else
;3023:		if (cgs.gametype < GT_TEAM) return;
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
GEI4 $1587
ADDRGP4 $1561
JUMPV
LABELV $1587
line 3024
;3024:		if (!cgs.clientinfo[trace.entityNum].infoValid) return;
ADDRLP4 0+52
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1590
ADDRGP4 $1561
JUMPV
LABELV $1590
line 3025
;3025:		if (cgs.clientinfo[trace.entityNum].team != cg.snap->ps.persistant[PERS_TEAM]) return;
ADDRLP4 0+52
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320+68
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
EQI4 $1594
ADDRGP4 $1561
JUMPV
LABELV $1594
line 3027
;3026:#endif
;3027:	}
LABELV $1583
line 3030
;3028:
;3029:	// update the fade timer
;3030:	cg.crosshairClientNum = trace.entityNum;
ADDRGP4 cg+127712
ADDRLP4 0+52
INDIRI4
ASGNI4
line 3031
;3031:	cg.crosshairClientTime = cg.time;
ADDRGP4 cg+127716
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 3032
;3032:}
LABELV $1561
endproc CG_ScanForCrosshairEntity 92 28
proc CG_DrawCrosshairNames 20 16
line 3040
;3033:
;3034:
;3035:/*
;3036:=====================
;3037:CG_DrawCrosshairNames
;3038:=====================
;3039:*/
;3040:static void CG_DrawCrosshairNames( void ) {
line 3045
;3041:	float		*color;
;3042:	char		*name;
;3043:	float		w;
;3044:
;3045:	if (cg.tssInterfaceOn) return;	// JUHOX
ADDRGP4 cg+128100
INDIRI4
CNSTI4 0
EQI4 $1605
ADDRGP4 $1604
JUMPV
LABELV $1605
line 3046
;3046:	if ( !cg_drawCrosshair.integer ) {
ADDRGP4 cg_drawCrosshair+12
INDIRI4
CNSTI4 0
NEI4 $1608
line 3047
;3047:		return;
ADDRGP4 $1604
JUMPV
LABELV $1608
line 3049
;3048:	}
;3049:	if ( !cg_drawCrosshairNames.integer ) {
ADDRGP4 cg_drawCrosshairNames+12
INDIRI4
CNSTI4 0
NEI4 $1611
line 3050
;3050:		return;
ADDRGP4 $1604
JUMPV
LABELV $1611
line 3052
;3051:	}
;3052:	if ( cg.renderingThirdPerson ) {
ADDRGP4 cg+107680
INDIRI4
CNSTI4 0
EQI4 $1614
line 3053
;3053:		return;
ADDRGP4 $1604
JUMPV
LABELV $1614
line 3057
;3054:	}
;3055:
;3056:	// scan the known entities to see if the crosshair is sighted on one
;3057:	CG_ScanForCrosshairEntity();
ADDRGP4 CG_ScanForCrosshairEntity
CALLV
pop
line 3060
;3058:
;3059:	// draw the name of the player being looked at
;3060:	color = CG_FadeColor( cg.crosshairClientTime, 1000 );
ADDRGP4 cg+127716
INDIRI4
ARGI4
CNSTI4 1000
ARGI4
ADDRLP4 12
ADDRGP4 CG_FadeColor
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 3061
;3061:	if ( !color ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1618
line 3062
;3062:		trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 3063
;3063:		return;
ADDRGP4 $1604
JUMPV
LABELV $1618
line 3066
;3064:	}
;3065:
;3066:	name = cgs.clientinfo[ cg.crosshairClientNum ].name;
ADDRLP4 4
ADDRGP4 cg+127712
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320+4
ADDP4
ASGNP4
line 3072
;3067:#ifdef MISSIONPACK
;3068:	color[3] *= 0.5f;
;3069:	w = CG_Text_Width(name, 0.3f, 0);
;3070:	CG_Text_Paint( 320 - w / 2, 190, 0.3f, color, name, 0, 0, ITEM_TEXTSTYLE_SHADOWED);
;3071:#else
;3072:	w = CG_DrawStrlen( name ) * BIGCHAR_WIDTH;
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 16
INDIRI4
CNSTI4 4
LSHI4
CVIF4 4
ASGNF4
line 3073
;3073:	CG_DrawBigString( 320 - w / 2, 170, name, color[3] * 0.5f );
CNSTF4 1134559232
ADDRLP4 8
INDIRF4
CNSTF4 1056964608
MULF4
SUBF4
CVFI4 4
ARGI4
CNSTI4 170
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 1056964608
MULF4
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 3075
;3074:#endif
;3075:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 3076
;3076:}
LABELV $1604
endproc CG_DrawCrosshairNames 20 16
proc CG_DrawLensFlareEffectList 40 36
line 3087
;3077:
;3078:
;3079://==============================================================================
;3080:
;3081:/*
;3082:=================
;3083:JUHOX: CG_DrawLensFlareEffectList
;3084:=================
;3085:*/
;3086:#if MAPLENSFLARES
;3087:static void CG_DrawLensFlareEffectList(void) {
line 3092
;3088:	int firstEffect;
;3089:	int y;
;3090:	int i;
;3091:
;3092:	y = 480 - 12 * TINYCHAR_HEIGHT;
ADDRLP4 4
CNSTI4 384
ASGNI4
line 3094
;3093:
;3094:	firstEffect = cg.lfEditor.selectedEffect - 5;
ADDRLP4 8
ADDRGP4 cg+109660+40
INDIRI4
CNSTI4 5
SUBI4
ASGNI4
line 3095
;3095:	for (i = 0; i < 12; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1626
line 3098
;3096:		int effectNum;
;3097:
;3098:		effectNum = firstEffect + i;
ADDRLP4 12
ADDRLP4 8
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 3099
;3099:		if (effectNum >= 0 && effectNum < cgs.numLensFlareEffects) {
ADDRLP4 12
INDIRI4
CNSTI4 0
LTI4 $1630
ADDRLP4 12
INDIRI4
ADDRGP4 cgs+162608
INDIRI4
GEI4 $1630
line 3104
;3100:			lensFlareEffect_t* lfeff;
;3101:			int width;
;3102:			const float* color;
;3103:
;3104:			lfeff = &cgs.lensFlareEffects[effectNum];
ADDRLP4 20
ADDRLP4 12
INDIRI4
CNSTI4 2000
MULI4
ADDRGP4 cgs+162612
ADDP4
ASGNP4
line 3105
;3105:			width = CG_DrawStrlen(lfeff->name) * TINYCHAR_WIDTH;
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 32
INDIRI4
CNSTI4 3
LSHI4
ASGNI4
line 3106
;3106:			color = i == 5? colorWhite : colorMdGrey;
ADDRLP4 0
INDIRI4
CNSTI4 5
NEI4 $1635
ADDRLP4 36
ADDRGP4 colorWhite
ASGNP4
ADDRGP4 $1636
JUMPV
LABELV $1635
ADDRLP4 36
ADDRGP4 colorMdGrey
ASGNP4
LABELV $1636
ADDRLP4 28
ADDRLP4 36
INDIRP4
ASGNP4
line 3107
;3107:			CG_DrawStringExt(640 - width, y, lfeff->name, color, qtrue, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
CNSTI4 640
ADDRLP4 24
INDIRI4
SUBI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 28
INDIRP4
ARGP4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
CNSTI4 8
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3108
;3108:		}
LABELV $1630
line 3109
;3109:		y += TINYCHAR_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 8
ADDI4
ASGNI4
line 3110
;3110:	}
LABELV $1627
line 3095
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 12
LTI4 $1626
line 3111
;3111:}
LABELV $1623
endproc CG_DrawLensFlareEffectList 40 36
proc CG_DrawCopyOptions 280 36
line 3120
;3112:#endif
;3113:
;3114:/*
;3115:=================
;3116:JUHOX: CG_DrawCopyOptions
;3117:=================
;3118:*/
;3119:#if MAPLENSFLARES
;3120:static void CG_DrawCopyOptions(void) {
line 3124
;3121:	int y;
;3122:	char buf[256];
;3123:
;3124:	y = 480;
ADDRLP4 256
CNSTI4 480
ASGNI4
line 3126
;3125:
;3126:	y -= TINYCHAR_HEIGHT;	// 9
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 8
SUBI4
ASGNI4
line 3127
;3127:	y -= TINYCHAR_HEIGHT;	// 8
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 8
SUBI4
ASGNI4
line 3128
;3128:	y -= TINYCHAR_HEIGHT;	// 7
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 8
SUBI4
ASGNI4
line 3130
;3129:
;3130:	y -= TINYCHAR_HEIGHT;
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 8
SUBI4
ASGNI4
line 3131
;3131:	Com_sprintf(buf, sizeof(buf), "[6] paste entity angle = %s", cg.lfEditor.copyOptions & LFECO_SPOT_ANGLE? "on" : "off");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $1638
ARGP4
ADDRGP4 cg+109660+260
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1644
ADDRLP4 260
ADDRGP4 $1641
ASGNP4
ADDRGP4 $1645
JUMPV
LABELV $1644
ADDRLP4 260
ADDRGP4 $1642
ASGNP4
LABELV $1645
ADDRLP4 260
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 3132
;3132:	CG_DrawStringExt(0, y, buf, colorWhite, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
CNSTI4 0
ARGI4
ADDRLP4 256
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 colorWhite
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
CNSTI4 8
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3134
;3133:
;3134:	y -= TINYCHAR_HEIGHT;
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 8
SUBI4
ASGNI4
line 3135
;3135:	Com_sprintf(buf, sizeof(buf), "[5] paste direction    = %s", cg.lfEditor.copyOptions & LFECO_SPOT_DIR? "on" : "off");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $1646
ARGP4
ADDRGP4 cg+109660+260
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $1650
ADDRLP4 264
ADDRGP4 $1641
ASGNP4
ADDRGP4 $1651
JUMPV
LABELV $1650
ADDRLP4 264
ADDRGP4 $1642
ASGNP4
LABELV $1651
ADDRLP4 264
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 3136
;3136:	CG_DrawStringExt(0, y, buf, colorWhite, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
CNSTI4 0
ARGI4
ADDRLP4 256
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 colorWhite
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
CNSTI4 8
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3138
;3137:
;3138:	y -= TINYCHAR_HEIGHT;
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 8
SUBI4
ASGNI4
line 3139
;3139:	Com_sprintf(buf, sizeof(buf), "[4] paste light radius = %s", cg.lfEditor.copyOptions & LFECO_LIGHTRADIUS? "on" : "off");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $1652
ARGP4
ADDRGP4 cg+109660+260
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $1656
ADDRLP4 268
ADDRGP4 $1641
ASGNP4
ADDRGP4 $1657
JUMPV
LABELV $1656
ADDRLP4 268
ADDRGP4 $1642
ASGNP4
LABELV $1657
ADDRLP4 268
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 3140
;3140:	CG_DrawStringExt(0, y, buf, colorWhite, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
CNSTI4 0
ARGI4
ADDRLP4 256
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 colorWhite
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
CNSTI4 8
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3142
;3141:
;3142:	y -= TINYCHAR_HEIGHT;
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 8
SUBI4
ASGNI4
line 3143
;3143:	Com_sprintf(buf, sizeof(buf), "[3] paste vis radius   = %s", cg.lfEditor.copyOptions & LFECO_VISRADIUS? "on" : "off");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $1658
ARGP4
ADDRGP4 cg+109660+260
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1662
ADDRLP4 272
ADDRGP4 $1641
ASGNP4
ADDRGP4 $1663
JUMPV
LABELV $1662
ADDRLP4 272
ADDRGP4 $1642
ASGNP4
LABELV $1663
ADDRLP4 272
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 3144
;3144:	CG_DrawStringExt(0, y, buf, colorWhite, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
CNSTI4 0
ARGI4
ADDRLP4 256
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 colorWhite
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
CNSTI4 8
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3146
;3145:
;3146:	y -= TINYCHAR_HEIGHT;
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 8
SUBI4
ASGNI4
line 3147
;3147:	Com_sprintf(buf, sizeof(buf), "[2] paste effect       = %s", cg.lfEditor.copyOptions & LFECO_EFFECT? "on" : "off");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $1664
ARGP4
ADDRGP4 cg+109660+260
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1668
ADDRLP4 276
ADDRGP4 $1641
ASGNP4
ADDRGP4 $1669
JUMPV
LABELV $1668
ADDRLP4 276
ADDRGP4 $1642
ASGNP4
LABELV $1669
ADDRLP4 276
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 3148
;3148:	CG_DrawStringExt(0, y, buf, colorWhite, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
CNSTI4 0
ARGI4
ADDRLP4 256
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 colorWhite
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
CNSTI4 8
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3150
;3149:
;3150:	y -= TINYCHAR_HEIGHT;
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 8
SUBI4
ASGNI4
line 3151
;3151:	Com_sprintf(buf, sizeof(buf), "[1] done");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $1670
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 3152
;3152:	CG_DrawStringExt(0, y, buf, colorWhite, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
CNSTI4 0
ARGI4
ADDRLP4 256
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 colorWhite
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
CNSTI4 8
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3153
;3153:}
LABELV $1637
endproc CG_DrawCopyOptions 280 36
data
align 4
LABELV $1675
byte 4 0
byte 4 0
byte 4 0
byte 4 1058642330
align 4
LABELV $1676
byte 4 0
byte 4 1056964608
byte 4 0
byte 4 1065353216
align 4
LABELV $1677
byte 4 1056964608
byte 4 1065353216
byte 4 1056964608
byte 4 1065353216
align 4
LABELV $1678
address $1679
address $1680
address $1681
align 4
LABELV $1682
address $1683
address $1684
address $1685
align 4
LABELV $1686
address $1687
address $1688
code
proc CG_DrawSpectator 284 36
line 3161
;3154:#endif
;3155:
;3156:/*
;3157:=================
;3158:CG_DrawSpectator
;3159:=================
;3160:*/
;3161:static void CG_DrawSpectator(void) {
line 3164
;3162:	// JUHOX: map lens flares edit mode
;3163:#if MAPLENSFLARES
;3164:	if (cgs.editMode == EM_mlf) {
ADDRGP4 cgs+31684
INDIRI4
CNSTI4 1
NEI4 $1672
line 3187
;3165:		static const vec4_t backFillColor = {
;3166:			0.0, 0.0, 0.0, 0.6
;3167:		};
;3168:		static const vec4_t colorDkGreen = {
;3169:			0.0, 0.5, 0.0, 1.0
;3170:		};
;3171:		static const vec4_t colorLtGreen = {
;3172:			0.5, 1.0, 0.5, 1.0
;3173:		};
;3174:		static const char* const drawModes[] = {
;3175:			"normal", "marks", "none"
;3176:		};
;3177:		static const char* const cursorSize[] = {
;3178:			"small", "light radius", "vis radius"
;3179:		};
;3180:		static const char* const moveModes[] = {
;3181:			"coarse", "fine"
;3182:		};
;3183:		char buf[256];
;3184:		int y;
;3185:
;3186:		// crosshair
;3187:		if (!cg.lfEditor.selectedLFEnt || cg.lfEditor.editMode != LFEEM_pos) {
ADDRGP4 cg+109660
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1694
ADDRGP4 cg+109660+8
INDIRI4
CNSTI4 1
EQI4 $1689
LABELV $1694
line 3188
;3188:			CG_DrawPic(320 - 12, 240 - 12, 24, 24, cgs.media.crosshairShader[0]);
CNSTF4 1134166016
ARGF4
CNSTF4 1130627072
ARGF4
CNSTF4 1103101952
ARGF4
CNSTF4 1103101952
ARGF4
ADDRGP4 cgs+751220+392
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 3189
;3189:		}
LABELV $1689
line 3191
;3190:
;3191:		CG_FillRect(0, 480 - 12 * TINYCHAR_HEIGHT, 640, 12 * TINYCHAR_HEIGHT, backFillColor);
CNSTF4 0
ARGF4
CNSTF4 1136656384
ARGF4
CNSTF4 1142947840
ARGF4
CNSTF4 1119879168
ARGF4
ADDRGP4 $1675
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 3193
;3192:
;3193:		CG_DrawLensFlareEffectList();
ADDRGP4 CG_DrawLensFlareEffectList
CALLV
pop
line 3195
;3194:
;3195:		if (cg.lfEditor.cmdMode == LFECM_copyOptions) {
ADDRGP4 cg+109660+256
INDIRI4
CNSTI4 1
NEI4 $1697
line 3196
;3196:			CG_DrawCopyOptions();
ADDRGP4 CG_DrawCopyOptions
CALLV
pop
line 3197
;3197:			return;
ADDRGP4 $1671
JUMPV
LABELV $1697
line 3200
;3198:		}
;3199:
;3200:		y = 480;
ADDRLP4 256
CNSTI4 480
ASGNI4
line 3202
;3201:
;3202:		y -= TINYCHAR_HEIGHT;
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 8
SUBI4
ASGNI4
line 3203
;3203:		if (cg.lfEditor.oldButtons & BUTTON_WALKING) {
ADDRGP4 cg+109660+232
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1701
line 3204
;3204:			Com_sprintf(buf, sizeof(buf), "[9] cursor size = %s", cursorSize[cg.lfEditor.cursorSize]);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $1705
ARGP4
ADDRGP4 cg+109660+16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1682
ADDP4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 3205
;3205:			CG_DrawStringExt(0, y, buf, cg.lfEditor.selectedLFEnt? colorLtGreen : colorDkGreen, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
CNSTI4 0
ARGI4
ADDRLP4 256
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 cg+109660
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1710
ADDRLP4 260
ADDRGP4 $1677
ASGNP4
ADDRGP4 $1711
JUMPV
LABELV $1710
ADDRLP4 260
ADDRGP4 $1676
ASGNP4
LABELV $1711
ADDRLP4 260
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
CNSTI4 8
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3206
;3206:		}
ADDRGP4 $1702
JUMPV
LABELV $1701
line 3207
;3207:		else {
line 3208
;3208:			Com_sprintf(buf, sizeof(buf), "[9] draw mode = %s", drawModes[cg.lfEditor.drawMode]);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $1712
ARGP4
ADDRGP4 cg+109660+4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1678
ADDP4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 3209
;3209:			CG_DrawStringExt(0, y, buf, colorWhite, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
CNSTI4 0
ARGI4
ADDRLP4 256
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 colorWhite
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
CNSTI4 8
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3210
;3210:		}
LABELV $1702
line 3212
;3211:
;3212:		y -= TINYCHAR_HEIGHT;
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 8
SUBI4
ASGNI4
line 3213
;3213:		if (cg.lfEditor.oldButtons & BUTTON_WALKING) {
ADDRGP4 cg+109660+232
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1715
line 3214
;3214:			Com_sprintf(buf, sizeof(buf), "[8] copy entity data");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $1719
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 3215
;3215:			CG_DrawStringExt(0, y, buf, cg.lfEditor.selectedLFEnt? colorLtGreen : colorDkGreen, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
CNSTI4 0
ARGI4
ADDRLP4 256
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 cg+109660
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1722
ADDRLP4 260
ADDRGP4 $1677
ASGNP4
ADDRGP4 $1723
JUMPV
LABELV $1722
ADDRLP4 260
ADDRGP4 $1676
ASGNP4
LABELV $1723
ADDRLP4 260
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
CNSTI4 8
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3216
;3216:		}
ADDRGP4 $1716
JUMPV
LABELV $1715
line 3217
;3217:		else {
line 3220
;3218:			const char* name;
;3219:
;3220:			name = "";
ADDRLP4 260
ADDRGP4 $1228
ASGNP4
line 3221
;3221:			if (cg.lfEditor.selectedLFEnt && cg.lfEditor.selectedLFEnt->lfeff) {
ADDRGP4 cg+109660
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1724
ADDRGP4 cg+109660
INDIRP4
CNSTI4 44
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1724
line 3222
;3222:				name = cg.lfEditor.selectedLFEnt->lfeff->name;
ADDRLP4 260
ADDRGP4 cg+109660
INDIRP4
CNSTI4 44
ADDP4
INDIRP4
ASGNP4
line 3223
;3223:			}
LABELV $1724
line 3224
;3224:			Com_sprintf(buf, sizeof(buf), "[8] note effect %s", name);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $1729
ARGP4
ADDRLP4 260
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 3225
;3225:			CG_DrawStringExt(0, y, buf, name[0]? colorWhite : colorMdGrey, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
CNSTI4 0
ARGI4
ADDRLP4 256
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 260
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1731
ADDRLP4 264
ADDRGP4 colorWhite
ASGNP4
ADDRGP4 $1732
JUMPV
LABELV $1731
ADDRLP4 264
ADDRGP4 colorMdGrey
ASGNP4
LABELV $1732
ADDRLP4 264
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
CNSTI4 8
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3226
;3226:		}
LABELV $1716
line 3228
;3227:
;3228:		y -= TINYCHAR_HEIGHT;
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 8
SUBI4
ASGNI4
line 3229
;3229:		if (cg.lfEditor.oldButtons & BUTTON_WALKING) {
ADDRGP4 cg+109660+232
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1733
line 3230
;3230:			Com_sprintf(buf, sizeof(buf), "[7] paste entity data");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $1737
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 3231
;3231:			CG_DrawStringExt(0, y, buf, cg.lfEditor.selectedLFEnt? colorLtGreen : colorDkGreen, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
CNSTI4 0
ARGI4
ADDRLP4 256
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 cg+109660
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1740
ADDRLP4 260
ADDRGP4 $1677
ASGNP4
ADDRGP4 $1741
JUMPV
LABELV $1740
ADDRLP4 260
ADDRGP4 $1676
ASGNP4
LABELV $1741
ADDRLP4 260
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
CNSTI4 8
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3232
;3232:		}
ADDRGP4 $1734
JUMPV
LABELV $1733
line 3233
;3233:		else {
line 3234
;3234:			Com_sprintf(buf, sizeof(buf), "[7] assign effect %s", cgs.lensFlareEffects[cg.lfEditor.selectedEffect].name);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $1742
ARGP4
ADDRGP4 cg+109660+40
INDIRI4
CNSTI4 2000
MULI4
ADDRGP4 cgs+162612
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 3235
;3235:			CG_DrawStringExt(0, y, buf, cg.lfEditor.selectedLFEnt? colorWhite : colorMdGrey, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
CNSTI4 0
ARGI4
ADDRLP4 256
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 cg+109660
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1748
ADDRLP4 260
ADDRGP4 colorWhite
ASGNP4
ADDRGP4 $1749
JUMPV
LABELV $1748
ADDRLP4 260
ADDRGP4 colorMdGrey
ASGNP4
LABELV $1749
ADDRLP4 260
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
CNSTI4 8
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3236
;3236:		}
LABELV $1734
line 3238
;3237:
;3238:		y -= TINYCHAR_HEIGHT;
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 8
SUBI4
ASGNI4
line 3239
;3239:		if (cg.lfEditor.oldButtons & BUTTON_WALKING) {
ADDRGP4 cg+109660+232
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1750
line 3240
;3240:			Com_sprintf(buf, sizeof(buf), "[6] paste options");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $1754
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 3241
;3241:			CG_DrawStringExt(0, y, buf, colorLtGreen, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
CNSTI4 0
ARGI4
ADDRLP4 256
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 $1677
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
CNSTI4 8
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3242
;3242:		}
ADDRGP4 $1751
JUMPV
LABELV $1750
line 3243
;3243:		else {
line 3244
;3244:			Com_sprintf(buf, sizeof(buf), "[6] %sedit light size f+b / vis radius l+r", cg.lfEditor.editMode == LFEEM_radius? "^3" : "");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $1755
ARGP4
ADDRGP4 cg+109660+8
INDIRI4
CNSTI4 3
NEI4 $1760
ADDRLP4 260
ADDRGP4 $1758
ASGNP4
ADDRGP4 $1761
JUMPV
LABELV $1760
ADDRLP4 260
ADDRGP4 $1228
ASGNP4
LABELV $1761
ADDRLP4 260
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 3245
;3245:			CG_DrawStringExt(0, y, buf, cg.lfEditor.selectedLFEnt? colorWhite : colorMdGrey, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
CNSTI4 0
ARGI4
ADDRLP4 256
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 cg+109660
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1764
ADDRLP4 264
ADDRGP4 colorWhite
ASGNP4
ADDRGP4 $1765
JUMPV
LABELV $1764
ADDRLP4 264
ADDRGP4 colorMdGrey
ASGNP4
LABELV $1765
ADDRLP4 264
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
CNSTI4 8
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3246
;3246:		}
LABELV $1751
line 3248
;3247:
;3248:		y -= TINYCHAR_HEIGHT;
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 8
SUBI4
ASGNI4
line 3249
;3249:		if (cg.lfEditor.oldButtons & BUTTON_WALKING) {
ADDRGP4 cg+109660+232
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1766
line 3250
;3250:			Com_sprintf(buf, sizeof(buf), "[5] find entity using %s", cgs.lensFlareEffects[cg.lfEditor.selectedEffect].name);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $1770
ARGP4
ADDRGP4 cg+109660+40
INDIRI4
CNSTI4 2000
MULI4
ADDRGP4 cgs+162612
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 3251
;3251:			CG_DrawStringExt(0, y, buf, colorLtGreen, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
CNSTI4 0
ARGI4
ADDRLP4 256
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 $1677
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
CNSTI4 8
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3252
;3252:		}
ADDRGP4 $1767
JUMPV
LABELV $1766
line 3253
;3253:		else {
line 3254
;3254:			Com_sprintf(buf, sizeof(buf), "[5] %sedit spotlight target", cg.lfEditor.editMode == LFEEM_target? "^3" : "");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $1774
ARGP4
ADDRGP4 cg+109660+8
INDIRI4
CNSTI4 2
NEI4 $1778
ADDRLP4 260
ADDRGP4 $1758
ASGNP4
ADDRGP4 $1779
JUMPV
LABELV $1778
ADDRLP4 260
ADDRGP4 $1228
ASGNP4
LABELV $1779
ADDRLP4 260
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 3255
;3255:			CG_DrawStringExt(0, y, buf, cg.lfEditor.selectedLFEnt? colorWhite : colorMdGrey, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
CNSTI4 0
ARGI4
ADDRLP4 256
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 cg+109660
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1782
ADDRLP4 264
ADDRGP4 colorWhite
ASGNP4
ADDRGP4 $1783
JUMPV
LABELV $1782
ADDRLP4 264
ADDRGP4 colorMdGrey
ASGNP4
LABELV $1783
ADDRLP4 264
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
CNSTI4 8
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3256
;3256:		}
LABELV $1767
line 3258
;3257:
;3258:		y -= TINYCHAR_HEIGHT;
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 8
SUBI4
ASGNI4
line 3259
;3259:		if (cg.lfEditor.oldButtons & BUTTON_WALKING) {
ADDRGP4 cg+109660+232
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1784
line 3260
;3260:			if (cg.lfEditor.selectedLFEnt) {
ADDRGP4 cg+109660
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1788
line 3261
;3261:				if (cg.lfEditor.selectedLFEnt->lock) {
ADDRGP4 cg+109660
INDIRP4
CNSTI4 12
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1791
line 3262
;3262:					CG_DrawStringExt(0, y, "[4] unlock from mover", colorLtGreen, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
CNSTI4 0
ARGI4
ADDRLP4 256
INDIRI4
ARGI4
ADDRGP4 $1794
ARGP4
ADDRGP4 $1677
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
CNSTI4 8
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3263
;3263:				}
ADDRGP4 $1785
JUMPV
LABELV $1791
line 3264
;3264:				else {
line 3265
;3265:					CG_DrawStringExt(0, y, "[4] lock to selected mover", cg.lfEditor.selectedMover? colorLtGreen : colorDkGreen, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
CNSTI4 0
ARGI4
ADDRLP4 256
INDIRI4
ARGI4
ADDRGP4 $1795
ARGP4
ADDRGP4 cg+109660+452
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1799
ADDRLP4 260
ADDRGP4 $1677
ASGNP4
ADDRGP4 $1800
JUMPV
LABELV $1799
ADDRLP4 260
ADDRGP4 $1676
ASGNP4
LABELV $1800
ADDRLP4 260
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
CNSTI4 8
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3266
;3266:				}
line 3267
;3267:			}
ADDRGP4 $1785
JUMPV
LABELV $1788
line 3268
;3268:			else {
line 3269
;3269:				CG_DrawStringExt(0, y, "[4] lock to selected mover", colorDkGreen, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
CNSTI4 0
ARGI4
ADDRLP4 256
INDIRI4
ARGI4
ADDRGP4 $1795
ARGP4
ADDRGP4 $1676
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
CNSTI4 8
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3270
;3270:			}
line 3271
;3271:		}
ADDRGP4 $1785
JUMPV
LABELV $1784
line 3272
;3272:		else {
line 3273
;3273:			Com_sprintf(buf, sizeof(buf), "[4] %sedit position & vis radius", cg.lfEditor.editMode == LFEEM_pos? "^3" : "");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $1801
ARGP4
ADDRGP4 cg+109660+8
INDIRI4
CNSTI4 1
NEI4 $1805
ADDRLP4 260
ADDRGP4 $1758
ASGNP4
ADDRGP4 $1806
JUMPV
LABELV $1805
ADDRLP4 260
ADDRGP4 $1228
ASGNP4
LABELV $1806
ADDRLP4 260
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 3274
;3274:			CG_DrawStringExt(0, y, buf, cg.lfEditor.selectedLFEnt? colorWhite : colorMdGrey, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
CNSTI4 0
ARGI4
ADDRLP4 256
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 cg+109660
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1809
ADDRLP4 264
ADDRGP4 colorWhite
ASGNP4
ADDRGP4 $1810
JUMPV
LABELV $1809
ADDRLP4 264
ADDRGP4 colorMdGrey
ASGNP4
LABELV $1810
ADDRLP4 264
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
CNSTI4 8
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3275
;3275:		}
LABELV $1785
line 3277
;3276:
;3277:		y -= TINYCHAR_HEIGHT;
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 8
SUBI4
ASGNI4
line 3278
;3278:		if (cg.lfEditor.oldButtons & BUTTON_WALKING) {
ADDRGP4 cg+109660+232
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1811
line 3279
;3279:			Com_sprintf(buf, sizeof(buf), "[3] find mover %s", cg.lfEditor.moversStopped? "" : "(need to be stopped)");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $1815
ARGP4
ADDRGP4 cg+109660+448
INDIRI4
CNSTI4 0
EQI4 $1820
ADDRLP4 260
ADDRGP4 $1228
ASGNP4
ADDRGP4 $1821
JUMPV
LABELV $1820
ADDRLP4 260
ADDRGP4 $1818
ASGNP4
LABELV $1821
ADDRLP4 260
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 3280
;3280:			CG_DrawStringExt(0, y, buf, cg.lfEditor.moversStopped? colorLtGreen : colorDkGreen, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
CNSTI4 0
ARGI4
ADDRLP4 256
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 cg+109660+448
INDIRI4
CNSTI4 0
EQI4 $1825
ADDRLP4 264
ADDRGP4 $1677
ASGNP4
ADDRGP4 $1826
JUMPV
LABELV $1825
ADDRLP4 264
ADDRGP4 $1676
ASGNP4
LABELV $1826
ADDRLP4 264
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
CNSTI4 8
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3281
;3281:		}
ADDRGP4 $1812
JUMPV
LABELV $1811
line 3282
;3282:		else {
line 3283
;3283:			Com_sprintf(buf, sizeof(buf), "[3] %sdelete flare entity", cg.lfEditor.delAck? "^1really^7 " : "");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $1827
ARGP4
ADDRGP4 cg+109660+36
INDIRI4
CNSTI4 0
EQI4 $1832
ADDRLP4 260
ADDRGP4 $1830
ASGNP4
ADDRGP4 $1833
JUMPV
LABELV $1832
ADDRLP4 260
ADDRGP4 $1228
ASGNP4
LABELV $1833
ADDRLP4 260
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 3284
;3284:			CG_DrawStringExt(0, y, buf, cg.lfEditor.selectedLFEnt? colorWhite : colorMdGrey, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
CNSTI4 0
ARGI4
ADDRLP4 256
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 cg+109660
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1836
ADDRLP4 264
ADDRGP4 colorWhite
ASGNP4
ADDRGP4 $1837
JUMPV
LABELV $1836
ADDRLP4 264
ADDRGP4 colorMdGrey
ASGNP4
LABELV $1837
ADDRLP4 264
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
CNSTI4 8
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3285
;3285:		}
LABELV $1812
line 3287
;3286:
;3287:		y -= TINYCHAR_HEIGHT;
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 8
SUBI4
ASGNI4
line 3288
;3288:		if (cg.lfEditor.oldButtons & BUTTON_WALKING) {
ADDRGP4 cg+109660+232
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1838
line 3289
;3289:			Com_sprintf(buf, sizeof(buf), "[2] %s movers", cg.lfEditor.moversStopped? "release" : "stop");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $1842
ARGP4
ADDRGP4 cg+109660+448
INDIRI4
CNSTI4 0
EQI4 $1848
ADDRLP4 260
ADDRGP4 $1845
ASGNP4
ADDRGP4 $1849
JUMPV
LABELV $1848
ADDRLP4 260
ADDRGP4 $1846
ASGNP4
LABELV $1849
ADDRLP4 260
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 3290
;3290:			CG_DrawStringExt(0, y, buf, colorLtGreen, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
CNSTI4 0
ARGI4
ADDRLP4 256
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 $1677
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
CNSTI4 8
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3291
;3291:		}
ADDRGP4 $1839
JUMPV
LABELV $1838
line 3292
;3292:		else {
line 3293
;3293:			Com_sprintf(buf, sizeof(buf), "[2] %s flare entity", cg.lfEditor.selectedLFEnt? "duplicate" : "create");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $1850
ARGP4
ADDRGP4 cg+109660
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1855
ADDRLP4 260
ADDRGP4 $1852
ASGNP4
ADDRGP4 $1856
JUMPV
LABELV $1855
ADDRLP4 260
ADDRGP4 $1853
ASGNP4
LABELV $1856
ADDRLP4 260
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 3294
;3294:			CG_DrawStringExt(0, y, buf, cg.lfEditor.editMode == LFEEM_none? colorWhite : colorMdGrey, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
CNSTI4 0
ARGI4
ADDRLP4 256
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 cg+109660+8
INDIRI4
CNSTI4 0
NEI4 $1860
ADDRLP4 264
ADDRGP4 colorWhite
ASGNP4
ADDRGP4 $1861
JUMPV
LABELV $1860
ADDRLP4 264
ADDRGP4 colorMdGrey
ASGNP4
LABELV $1861
ADDRLP4 264
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
CNSTI4 8
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3295
;3295:		}
LABELV $1839
line 3297
;3296:
;3297:		y -= TINYCHAR_HEIGHT;
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 8
SUBI4
ASGNI4
line 3298
;3298:		Com_sprintf(buf, sizeof(buf), "[1] cancel");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $1862
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 3299
;3299:		CG_DrawStringExt(0, y, buf, cg.lfEditor.selectedLFEnt? NULL : colorMdGrey, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
CNSTI4 0
ARGI4
ADDRLP4 256
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 cg+109660
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1865
ADDRLP4 260
CNSTP4 0
ASGNP4
ADDRGP4 $1866
JUMPV
LABELV $1865
ADDRLP4 260
ADDRGP4 colorMdGrey
ASGNP4
LABELV $1866
ADDRLP4 260
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
CNSTI4 8
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3301
;3300:
;3301:		y -= TINYCHAR_HEIGHT;
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 8
SUBI4
ASGNI4
line 3302
;3302:		Com_sprintf(buf, sizeof(buf), "[TAB] move mode = %s", moveModes[cg.lfEditor.moveMode]);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $1867
ARGP4
ADDRGP4 cg+109660+12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1686
ADDP4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 3303
;3303:		CG_DrawStringExt(0, y, buf, cg.lfEditor.selectedLFEnt && cg.lfEditor.editMode > LFEEM_none? colorWhite : colorMdGrey, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
CNSTI4 0
ARGI4
ADDRLP4 256
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 cg+109660
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1874
ADDRGP4 cg+109660+8
INDIRI4
CNSTI4 0
LEI4 $1874
ADDRLP4 264
ADDRGP4 colorWhite
ASGNP4
ADDRGP4 $1875
JUMPV
LABELV $1874
ADDRLP4 264
ADDRGP4 colorMdGrey
ASGNP4
LABELV $1875
ADDRLP4 264
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
CNSTI4 8
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3305
;3304:
;3305:		y -= TINYCHAR_HEIGHT;
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 8
SUBI4
ASGNI4
line 3306
;3306:		Com_sprintf(buf, sizeof(buf), "[WALK] alternate command set");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $1876
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 3307
;3307:		CG_DrawStringExt(0, y, buf, (cg.lfEditor.oldButtons & BUTTON_WALKING)? colorLtGreen : colorWhite, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
CNSTI4 0
ARGI4
ADDRLP4 256
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 cg+109660+232
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1880
ADDRLP4 268
ADDRGP4 $1677
ASGNP4
ADDRGP4 $1881
JUMPV
LABELV $1880
ADDRLP4 268
ADDRGP4 colorWhite
ASGNP4
LABELV $1881
ADDRLP4 268
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
CNSTI4 8
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3309
;3308:
;3309:		y -= TINYCHAR_HEIGHT;
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 8
SUBI4
ASGNI4
line 3310
;3310:		if (!cg.lfEditor.selectedLFEnt) {
ADDRGP4 cg+109660
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1882
line 3311
;3311:			if (cg.lfEditor.markedLFEnt >= 0) {
ADDRGP4 cg+109660+44
INDIRI4
CNSTI4 0
LTI4 $1673
line 3312
;3312:				Com_sprintf(buf, sizeof(buf), "[ATTACK] select flare entity");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $1889
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 3313
;3313:				CG_DrawStringExt(0, y, buf, NULL, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
CNSTI4 0
ARGI4
ADDRLP4 256
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
CNSTI4 8
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3314
;3314:			}
line 3315
;3315:		}
ADDRGP4 $1673
JUMPV
LABELV $1882
line 3316
;3316:		else {
line 3317
;3317:			switch (cg.lfEditor.editMode) {
ADDRLP4 272
ADDRGP4 cg+109660+8
INDIRI4
ASGNI4
ADDRLP4 272
INDIRI4
CNSTI4 0
LTI4 $1890
ADDRLP4 272
INDIRI4
CNSTI4 3
GTI4 $1890
ADDRLP4 272
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1920
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1920
address $1895
address $1897
address $1904
address $1918
code
LABELV $1895
line 3319
;3318:			case LFEEM_none:
;3319:				Com_sprintf(buf, sizeof(buf), "[ATTACK] accept changes");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $1896
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 3320
;3320:				break;
ADDRGP4 $1891
JUMPV
LABELV $1897
line 3322
;3321:			case LFEEM_pos:
;3322:				if (cg.lfEditor.moveMode == LFEMM_coarse) {
ADDRGP4 cg+109660+12
INDIRI4
CNSTI4 0
NEI4 $1898
line 3323
;3323:					Com_sprintf(buf, sizeof(buf), "[ATTACK] switch to tune mode");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $1902
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 3324
;3324:				}
ADDRGP4 $1891
JUMPV
LABELV $1898
line 3325
;3325:				else {
line 3326
;3326:					Com_sprintf(buf, sizeof(buf), "[ATTACK] modify view dist (f+b) or vis radius (l+r)");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $1903
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 3327
;3327:				}
line 3328
;3328:				break;
ADDRGP4 $1891
JUMPV
LABELV $1904
line 3330
;3329:			case LFEEM_target:
;3330:				if (cg.lfEditor.editTarget) {
ADDRGP4 cg+109660+240
INDIRI4
CNSTI4 0
EQI4 $1905
line 3331
;3331:					Com_sprintf(buf, sizeof(buf), "[ATTACK] set target");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $1909
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 3332
;3332:				}
ADDRGP4 $1891
JUMPV
LABELV $1905
line 3333
;3333:				else if (DistanceSquared(cg.refdef.vieworg, cg.lfEditor.targetPosition) < 1) {
ADDRGP4 cg+109260+24
ARGP4
ADDRGP4 cg+109660+244
ARGP4
ADDRLP4 280
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 280
INDIRF4
CNSTF4 1065353216
GEF4 $1910
line 3334
;3334:					Com_sprintf(buf, sizeof(buf), "[ATTACK] remove target & leave editing mode");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $1916
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 3335
;3335:				}
ADDRGP4 $1891
JUMPV
LABELV $1910
line 3336
;3336:				else {
line 3337
;3337:					Com_sprintf(buf, sizeof(buf), "[ATTACK] set angle & leave editing mode");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $1917
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 3338
;3338:				}
line 3339
;3339:				break;
ADDRGP4 $1891
JUMPV
LABELV $1918
line 3341
;3340:			case LFEEM_radius:
;3341:				Com_sprintf(buf, sizeof(buf), "[ATTACK] modify view distance (f+b)");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $1919
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 3342
;3342:				break;
ADDRGP4 $1891
JUMPV
LABELV $1890
line 3344
;3343:			default:
;3344:				buf[0] = 0;
ADDRLP4 0
CNSTI1 0
ASGNI1
line 3345
;3345:				break;
LABELV $1891
line 3347
;3346:			}
;3347:			CG_DrawStringExt(0, y, buf, NULL, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
CNSTI4 0
ARGI4
ADDRLP4 256
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
CNSTI4 8
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3348
;3348:		}
line 3349
;3349:	}
ADDRGP4 $1673
JUMPV
LABELV $1672
line 3352
;3350:	else
;3351:#endif
;3352:	CG_DrawBigString(320 - 9 * 8, 440, "SPECTATOR", 1.0F);
CNSTI4 248
ARGI4
CNSTI4 440
ARGI4
ADDRGP4 $1921
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
LABELV $1673
line 3353
;3353:	if ( cgs.gametype == GT_TOURNAMENT ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 1
NEI4 $1922
line 3354
;3354:		CG_DrawBigString(320 - 15 * 8, 460, "waiting to play", 1.0F);
CNSTI4 200
ARGI4
CNSTI4 460
ARGI4
ADDRGP4 $1925
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 3355
;3355:	}
ADDRGP4 $1923
JUMPV
LABELV $1922
line 3356
;3356:	else if ( cgs.gametype >= GT_TEAM ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $1926
line 3357
;3357:		CG_DrawBigString(320 - 39 * 8, 460, "press ESC and use the JOIN menu to play", 1.0F);
CNSTI4 8
ARGI4
CNSTI4 460
ARGI4
ADDRGP4 $1929
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 3358
;3358:	}
LABELV $1926
LABELV $1923
line 3359
;3359:}
LABELV $1671
endproc CG_DrawSpectator 284 36
data
align 4
LABELV $1948
byte 4 0
byte 4 0
byte 4 0
byte 4 1056964608
export CG_DrawVote
code
proc CG_DrawVote 16 20
line 3366
;3360:
;3361:/*
;3362:=================
;3363:CG_DrawVote
;3364:=================
;3365:*/
;3366:/*static*/ void CG_DrawVote(void) {	// JUHOX: also called from cg_view.c
line 3370
;3367:	char	*s;
;3368:	int		sec;
;3369:
;3370:	if ( !cgs.voteTime ) {
ADDRGP4 cgs+32000
INDIRI4
CNSTI4 0
NEI4 $1931
line 3371
;3371:		return;
ADDRGP4 $1930
JUMPV
LABELV $1931
line 3375
;3372:	}
;3373:
;3374:	// play a talk beep whenever it is modified
;3375:	if ( cgs.voteModified ) {
ADDRGP4 cgs+32012
INDIRI4
CNSTI4 0
EQI4 $1934
line 3376
;3376:		cgs.voteModified = qfalse;
ADDRGP4 cgs+32012
CNSTI4 0
ASGNI4
line 3377
;3377:		trap_S_StartLocalSound( cgs.media.talkSound, CHAN_LOCAL_SOUND );
ADDRGP4 cgs+751220+1032
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 3378
;3378:	}
LABELV $1934
line 3380
;3379:
;3380:	sec = ( VOTE_TIME - ( cg.time - cgs.voteTime ) ) / 1000;
ADDRLP4 0
CNSTI4 30000
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cgs+32000
INDIRI4
SUBI4
SUBI4
CNSTI4 1000
DIVI4
ASGNI4
line 3381
;3381:	if ( sec < 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $1942
line 3382
;3382:		sec = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 3383
;3383:	}
LABELV $1942
line 3390
;3384:#ifdef MISSIONPACK
;3385:	s = va("VOTE(%i):%s yes:%i no:%i", sec, cgs.voteString, cgs.voteYes, cgs.voteNo);
;3386:	CG_DrawSmallString( 0, 58, s, 1.0F );
;3387:	s = "or press ESC then click Vote";
;3388:	CG_DrawSmallString( 0, 58 + SMALLCHAR_HEIGHT + 2, s, 1.0F );
;3389:#else
;3390:	s = va("VOTE(%i):%s yes:%i no:%i", sec, cgs.voteString, cgs.voteYes, cgs.voteNo );
ADDRGP4 $1944
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 cgs+32016
ARGP4
ADDRGP4 cgs+32004
INDIRI4
ARGI4
ADDRGP4 cgs+32008
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 3392
;3391:#if	1	// JUHOX: vote string background
;3392:	{
line 3397
;3393:		static const vec4_t backColor = {
;3394:			0, 0, 0, 0.5
;3395:		};
;3396:
;3397:		CG_FillRect(0, 58, CG_DrawStrlen(s) * SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, backColor);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
CNSTF4 0
ARGF4
CNSTF4 1114112000
ARGF4
ADDRLP4 12
INDIRI4
CNSTI4 3
LSHI4
CVIF4 4
ARGF4
CNSTF4 1098907648
ARGF4
ADDRGP4 $1948
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 3398
;3398:	}
line 3400
;3399:#endif
;3400:	CG_DrawSmallString( 0, 58, s, 1.0F );
CNSTI4 0
ARGI4
CNSTI4 58
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawSmallString
CALLV
pop
line 3402
;3401:#endif
;3402:}
LABELV $1930
endproc CG_DrawVote 16 20
data
align 4
LABELV $1991
byte 4 0
byte 4 0
byte 4 0
byte 4 1056964608
export CG_DrawTeamVote
code
proc CG_DrawTeamVote 28 20
line 3409
;3403:
;3404:/*
;3405:=================
;3406:CG_DrawTeamVote
;3407:=================
;3408:*/
;3409:/*static*/ void CG_DrawTeamVote(void) {	// JUHOX: also called from cg_view.c
line 3422
;3410:	char	*s;
;3411:	int		sec, cs_offset;
;3412:
;3413:	// JUHOX BUGFIX
;3414:#if 0
;3415:	if ( cgs.clientinfo->team == TEAM_RED )
;3416:		cs_offset = 0;
;3417:	else if ( cgs.clientinfo->team == TEAM_BLUE )
;3418:		cs_offset = 1;
;3419:	else
;3420:		return;
;3421:#else
;3422:	if ( cgs.clientinfo[cg.clientNum].team == TEAM_RED )
ADDRGP4 cg+4
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320+68
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1950
line 3423
;3423:		cs_offset = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1951
JUMPV
LABELV $1950
line 3424
;3424:	else if ( cgs.clientinfo[cg.clientNum].team == TEAM_BLUE )
ADDRGP4 cg+4
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320+68
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1949
line 3425
;3425:		cs_offset = 1;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 3427
;3426:	else
;3427:		return;
LABELV $1956
LABELV $1951
line 3430
;3428:#endif
;3429:
;3430:	if ( !cgs.teamVoteTime[cs_offset] ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+33040
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1960
line 3431
;3431:		return;
ADDRGP4 $1949
JUMPV
LABELV $1960
line 3433
;3432:	}
;3433:	if (cg.tssInterfaceOn) return;	// JUHOX: don't draw team vote if TSS interface on
ADDRGP4 cg+128100
INDIRI4
CNSTI4 0
EQI4 $1963
ADDRGP4 $1949
JUMPV
LABELV $1963
line 3436
;3434:
;3435:	// play a talk beep whenever it is modified
;3436:	if ( cgs.teamVoteModified[cs_offset] ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+33064
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1966
line 3437
;3437:		cgs.teamVoteModified[cs_offset] = qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+33064
ADDP4
CNSTI4 0
ASGNI4
line 3438
;3438:		trap_S_StartLocalSound( cgs.media.talkSound, CHAN_LOCAL_SOUND );
ADDRGP4 cgs+751220+1032
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 3439
;3439:	}
LABELV $1966
line 3441
;3440:
;3441:	sec = ( VOTE_TIME - ( cg.time - cgs.teamVoteTime[cs_offset] ) ) / 1000;
ADDRLP4 4
CNSTI4 30000
ADDRGP4 cg+107656
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+33040
ADDP4
INDIRI4
SUBI4
SUBI4
CNSTI4 1000
DIVI4
ASGNI4
line 3442
;3442:	if ( sec < 0 ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $1974
line 3443
;3443:		sec = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 3444
;3444:	}
LABELV $1974
line 3450
;3445:	// JUHOX: show teamvote client as name
;3446:#if 0
;3447:	s = va("TEAMVOTE(%i):%s yes:%i no:%i", sec, cgs.teamVoteString[cs_offset],
;3448:							cgs.teamVoteYes[cs_offset], cgs.teamVoteNo[cs_offset] );
;3449:#else
;3450:	if (!Q_strncmp("leader", cgs.teamVoteString[cs_offset], 6)) {
ADDRGP4 $1978
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 10
LSHI4
ADDRGP4 cgs+33072
ADDP4
ARGP4
CNSTI4 6
ARGI4
ADDRLP4 12
ADDRGP4 Q_strncmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $1976
line 3451
;3451:		s = va(
ADDRLP4 0
INDIRI4
CNSTI4 10
LSHI4
ADDRGP4 cgs+33072+7
ADDP4
ARGP4
ADDRLP4 16
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 $1980
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 16
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320+4
ADDP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+33048
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+33056
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 24
INDIRP4
ASGNP4
line 3456
;3452:			"TEAMVOTE(%i):mission leader %s - yes:%i no:%i",
;3453:			sec, cgs.clientinfo[atoi(cgs.teamVoteString[cs_offset] + 7)].name,
;3454:			cgs.teamVoteYes[cs_offset], cgs.teamVoteNo[cs_offset]
;3455:		);
;3456:	}
ADDRGP4 $1977
JUMPV
LABELV $1976
line 3457
;3457:	else {
line 3458
;3458:		s = va("TEAMVOTE(%i):%s - yes:%i no:%i", sec, cgs.teamVoteString[cs_offset],
ADDRGP4 $1987
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 10
LSHI4
ADDRGP4 cgs+33072
ADDP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+33048
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+33056
ADDP4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 20
INDIRP4
ASGNP4
line 3460
;3459:								cgs.teamVoteYes[cs_offset], cgs.teamVoteNo[cs_offset] );
;3460:	}
LABELV $1977
line 3463
;3461:#endif
;3462:#if	1	// JUHOX: teamvote string background
;3463:	{
line 3468
;3464:		static const vec4_t backColor = {
;3465:			0, 0, 0, 0.5
;3466:		};
;3467:
;3468:		CG_FillRect(0, 90, CG_DrawStrlen(s) * SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, backColor);
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
CNSTF4 0
ARGF4
CNSTF4 1119092736
ARGF4
ADDRLP4 16
INDIRI4
CNSTI4 3
LSHI4
CVIF4 4
ARGF4
CNSTF4 1098907648
ARGF4
ADDRGP4 $1991
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 3469
;3469:	}
line 3471
;3470:#endif
;3471:	CG_DrawSmallString( 0, 90, s, 1.0F );
CNSTI4 0
ARGI4
CNSTI4 90
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawSmallString
CALLV
pop
line 3472
;3472:}
LABELV $1949
endproc CG_DrawTeamVote 28 20
proc CG_DrawScoreboard 4 0
line 3475
;3473:
;3474:
;3475:static qboolean CG_DrawScoreboard() {
line 3540
;3476:#ifdef MISSIONPACK
;3477:	static qboolean firstTime = qtrue;
;3478:	float fade, *fadeColor;
;3479:
;3480:	if (menuScoreboard) {
;3481:		menuScoreboard->window.flags &= ~WINDOW_FORCED;
;3482:	}
;3483:	if (cg_paused.integer) {
;3484:		cg.deferredPlayerLoading = 0;
;3485:		firstTime = qtrue;
;3486:		return qfalse;
;3487:	}
;3488:
;3489:	// should never happen in Team Arena
;3490:	if (cgs.gametype == GT_SINGLE_PLAYER && cg.predictedPlayerState.pm_type == PM_INTERMISSION ) {
;3491:		cg.deferredPlayerLoading = 0;
;3492:		firstTime = qtrue;
;3493:		return qfalse;
;3494:	}
;3495:
;3496:	// don't draw scoreboard during death while warmup up
;3497:	if ( cg.warmup && !cg.showScores ) {
;3498:		return qfalse;
;3499:	}
;3500:
;3501:	if ( cg.showScores || cg.predictedPlayerState.pm_type == PM_DEAD || cg.predictedPlayerState.pm_type == PM_INTERMISSION ) {
;3502:		fade = 1.0;
;3503:		fadeColor = colorWhite;
;3504:	} else {
;3505:		fadeColor = CG_FadeColor( cg.scoreFadeTime, FADE_TIME );
;3506:		if ( !fadeColor ) {
;3507:			// next time scoreboard comes up, don't print killer
;3508:			cg.deferredPlayerLoading = 0;
;3509:			cg.killerName[0] = 0;
;3510:			firstTime = qtrue;
;3511:			return qfalse;
;3512:		}
;3513:		fade = *fadeColor;
;3514:	}
;3515:
;3516:
;3517:	if (menuScoreboard == NULL) {
;3518:		if ( cgs.gametype >= GT_TEAM ) {
;3519:			menuScoreboard = Menus_FindByName("teamscore_menu");
;3520:		} else {
;3521:			menuScoreboard = Menus_FindByName("score_menu");
;3522:		}
;3523:	}
;3524:
;3525:	if (menuScoreboard) {
;3526:		if (firstTime) {
;3527:			CG_SetScoreSelection(menuScoreboard);
;3528:			firstTime = qfalse;
;3529:		}
;3530:		Menu_Paint(menuScoreboard, qtrue);
;3531:	}
;3532:
;3533:	// load any models that have been deferred
;3534:	if ( ++cg.deferredPlayerLoading > 10 ) {
;3535:		CG_LoadDeferredPlayers();
;3536:	}
;3537:
;3538:	return qtrue;
;3539:#else
;3540:	return CG_DrawOldScoreboard();
ADDRLP4 0
ADDRGP4 CG_DrawOldScoreboard
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $1992
endproc CG_DrawScoreboard 4 0
proc CG_DrawIntermission 4 0
line 3549
;3541:#endif
;3542:}
;3543:
;3544:/*
;3545:=================
;3546:CG_DrawIntermission
;3547:=================
;3548:*/
;3549:static void CG_DrawIntermission( void ) {
line 3557
;3550://	int key;
;3551:#ifdef MISSIONPACK
;3552:	//if (cg_singlePlayer.integer) {
;3553:	//	CG_DrawCenterString();
;3554:	//	return;
;3555:	//}
;3556:#else
;3557:	if ( cgs.gametype == GT_SINGLE_PLAYER ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 2
NEI4 $1994
line 3558
;3558:		CG_DrawCenterString();
ADDRGP4 CG_DrawCenterString
CALLV
pop
line 3559
;3559:		return;
ADDRGP4 $1993
JUMPV
LABELV $1994
line 3562
;3560:	}
;3561:#endif
;3562:	cg.scoreFadeTime = cg.time;
ADDRGP4 cg+117632
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 3563
;3563:	cg.scoreBoardShowing = CG_DrawScoreboard();
ADDRLP4 0
ADDRGP4 CG_DrawScoreboard
CALLI4
ASGNI4
ADDRGP4 cg+117628
ADDRLP4 0
INDIRI4
ASGNI4
line 3565
;3564:#if 1	// JUHOX: draw vote string during intermission
;3565:	CG_DrawVote();
ADDRGP4 CG_DrawVote
CALLV
pop
line 3566
;3566:	CG_DrawTeamVote();
ADDRGP4 CG_DrawTeamVote
CALLV
pop
line 3568
;3567:#endif
;3568:}
LABELV $1993
endproc CG_DrawIntermission 4 0
proc CG_DrawFollow 28 36
line 3575
;3569:
;3570:/*
;3571:=================
;3572:CG_DrawFollow
;3573:=================
;3574:*/
;3575:static qboolean CG_DrawFollow( void ) {
line 3580
;3576:	float		x;
;3577:	vec4_t		color;
;3578:	const char	*name;
;3579:
;3580:	if ( !(cg.snap->ps.pm_flags & PMF_FOLLOW) ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
NEI4 $2001
line 3581
;3581:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2000
JUMPV
LABELV $2001
line 3583
;3582:	}
;3583:	color[0] = 1;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 3584
;3584:	color[1] = 1;
ADDRLP4 0+4
CNSTF4 1065353216
ASGNF4
line 3585
;3585:	color[2] = 1;
ADDRLP4 0+8
CNSTF4 1065353216
ASGNF4
line 3586
;3586:	color[3] = 1;
ADDRLP4 0+12
CNSTF4 1065353216
ASGNF4
line 3589
;3587:
;3588:
;3589:	CG_DrawBigString( 320 - 9 * 8, 24, "following", 1.0F );
CNSTI4 248
ARGI4
CNSTI4 24
ARGI4
ADDRGP4 $2007
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 3591
;3590:
;3591:	name = cgs.clientinfo[ cg.snap->ps.clientNum ].name;
ADDRLP4 16
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320+4
ADDP4
ASGNP4
line 3593
;3592:
;3593:	x = 0.5 * ( 640 - GIANT_WIDTH * CG_DrawStrlen( name ) );
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 20
CNSTI4 640
ADDRLP4 24
INDIRI4
CNSTI4 5
LSHI4
SUBI4
CVIF4 4
CNSTF4 1056964608
MULF4
ASGNF4
line 3595
;3594:
;3595:	CG_DrawStringExt( x, 40, name, color, qtrue, qtrue, GIANT_WIDTH, GIANT_HEIGHT, 0 );
ADDRLP4 20
INDIRF4
CVFI4 4
ARGI4
CNSTI4 40
ARGI4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1
ARGI4
CNSTI4 1
ARGI4
CNSTI4 32
ARGI4
CNSTI4 48
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3597
;3596:
;3597:	return qtrue;
CNSTI4 1
RETI4
LABELV $2000
endproc CG_DrawFollow 28 36
proc CG_DrawAmmoWarning 0 0
line 3607
;3598:}
;3599:
;3600:
;3601:
;3602:/*
;3603:=================
;3604:CG_DrawAmmoWarning
;3605:=================
;3606:*/
;3607:static void CG_DrawAmmoWarning( void ) {
line 3629
;3608:	// JUHOX: don't draw the ammo warning
;3609:#if 0
;3610:	const char	*s;
;3611:	int			w;
;3612:
;3613:	if ( cg_drawAmmoWarning.integer == 0 ) {
;3614:		return;
;3615:	}
;3616:
;3617:	if ( !cg.lowAmmoWarning ) {
;3618:		return;
;3619:	}
;3620:
;3621:	if ( cg.lowAmmoWarning == 2 ) {
;3622:		s = "OUT OF AMMO";
;3623:	} else {
;3624:		s = "LOW AMMO WARNING";
;3625:	}
;3626:	w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
;3627:	CG_DrawBigString(320 - w / 2, 64, s, 1.0F);
;3628:#endif
;3629:}
LABELV $2011
endproc CG_DrawAmmoWarning 0 0
proc CG_DrawWarmup 48 36
line 3678
;3630:
;3631:
;3632:#ifdef MISSIONPACK
;3633:/*
;3634:=================
;3635:CG_DrawProxWarning
;3636:=================
;3637:*/
;3638:static void CG_DrawProxWarning( void ) {
;3639:	char s [32];
;3640:	int			w;
;3641:  static int proxTime;
;3642:  static int proxCounter;
;3643:  static int proxTick;
;3644:
;3645:	if( !(cg.snap->ps.eFlags & EF_TICKING ) ) {
;3646:    proxTime = 0;
;3647:		return;
;3648:	}
;3649:
;3650:  if (proxTime == 0) {
;3651:    proxTime = cg.time + 5000;
;3652:    proxCounter = 5;
;3653:    proxTick = 0;
;3654:  }
;3655:
;3656:  if (cg.time > proxTime) {
;3657:    proxTick = proxCounter--;
;3658:    proxTime = cg.time + 1000;
;3659:  }
;3660:
;3661:  if (proxTick != 0) {
;3662:    Com_sprintf(s, sizeof(s), "INTERNAL COMBUSTION IN: %i", proxTick);
;3663:  } else {
;3664:    Com_sprintf(s, sizeof(s), "YOU HAVE BEEN MINED");
;3665:  }
;3666:
;3667:	w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
;3668:	CG_DrawBigStringColor( 320 - w / 2, 64 + BIGCHAR_HEIGHT, s, g_color_table[ColorIndex(COLOR_RED)] );
;3669:}
;3670:#endif
;3671:
;3672:
;3673:/*
;3674:=================
;3675:CG_DrawWarmup
;3676:=================
;3677:*/
;3678:static void CG_DrawWarmup( void ) {
line 3687
;3679:	int			w;
;3680:	int			sec;
;3681:	int			i;
;3682:	float scale;
;3683:	clientInfo_t	*ci1, *ci2;
;3684:	int			cw;
;3685:	const char	*s;
;3686:
;3687:	sec = cg.warmup;
ADDRLP4 4
ADDRGP4 cg+127968
INDIRI4
ASGNI4
line 3688
;3688:	if ( !sec ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2014
line 3689
;3689:		return;
ADDRGP4 $2012
JUMPV
LABELV $2014
line 3692
;3690:	}
;3691:
;3692:	if ( sec < 0 ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $2016
line 3693
;3693:		s = "Waiting for players";
ADDRLP4 8
ADDRGP4 $2018
ASGNP4
line 3694
;3694:		w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 32
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 3695
;3695:		CG_DrawBigString(320 - w / 2, 24, s, 1.0F);
CNSTI4 320
ADDRLP4 16
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 24
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 3696
;3696:		cg.warmupCount = 0;
ADDRGP4 cg+127972
CNSTI4 0
ASGNI4
line 3697
;3697:		return;
ADDRGP4 $2012
JUMPV
LABELV $2016
line 3700
;3698:	}
;3699:
;3700:	if (cgs.gametype == GT_TOURNAMENT) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 1
NEI4 $2020
line 3702
;3701:		// find the two active players
;3702:		ci1 = NULL;
ADDRLP4 20
CNSTP4 0
ASGNP4
line 3703
;3703:		ci2 = NULL;
ADDRLP4 24
CNSTP4 0
ASGNP4
line 3704
;3704:		for ( i = 0 ; i < cgs.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2026
JUMPV
LABELV $2023
line 3705
;3705:			if ( cgs.clientinfo[i].infoValid && cgs.clientinfo[i].team == TEAM_FREE ) {
ADDRLP4 0
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2028
ADDRLP4 0
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320+68
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2028
line 3706
;3706:				if ( !ci1 ) {
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2033
line 3707
;3707:					ci1 = &cgs.clientinfo[i];
ADDRLP4 20
ADDRLP4 0
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320
ADDP4
ASGNP4
line 3708
;3708:				} else {
ADDRGP4 $2034
JUMPV
LABELV $2033
line 3709
;3709:					ci2 = &cgs.clientinfo[i];
ADDRLP4 24
ADDRLP4 0
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320
ADDP4
ASGNP4
line 3710
;3710:				}
LABELV $2034
line 3711
;3711:			}
LABELV $2028
line 3712
;3712:		}
LABELV $2024
line 3704
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2026
ADDRLP4 0
INDIRI4
ADDRGP4 cgs+31480
INDIRI4
LTI4 $2023
line 3714
;3713:
;3714:		if ( ci1 && ci2 ) {
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2021
ADDRLP4 24
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2021
line 3715
;3715:			s = va( "%s vs %s", ci1->name, ci2->name );
ADDRGP4 $2039
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 32
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 32
INDIRP4
ASGNP4
line 3720
;3716:#ifdef MISSIONPACK
;3717:			w = CG_Text_Width(s, 0.6f, 0);
;3718:			CG_Text_Paint(320 - w / 2, 60, 0.6f, colorWhite, s, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE);
;3719:#else
;3720:			w = CG_DrawStrlen( s );
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 36
INDIRI4
ASGNI4
line 3721
;3721:			if ( w > 640 / GIANT_WIDTH ) {
ADDRLP4 16
INDIRI4
CNSTI4 20
LEI4 $2040
line 3722
;3722:				cw = 640 / w;
ADDRLP4 12
CNSTI4 640
ADDRLP4 16
INDIRI4
DIVI4
ASGNI4
line 3723
;3723:			} else {
ADDRGP4 $2041
JUMPV
LABELV $2040
line 3724
;3724:				cw = GIANT_WIDTH;
ADDRLP4 12
CNSTI4 32
ASGNI4
line 3725
;3725:			}
LABELV $2041
line 3726
;3726:			CG_DrawStringExt( 320 - w * cw/2, 20,s, colorWhite,
CNSTI4 320
ADDRLP4 16
INDIRI4
ADDRLP4 12
INDIRI4
MULI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 20
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
CVIF4 4
CNSTF4 1069547520
MULF4
CVFI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3729
;3727:					qfalse, qtrue, cw, (int)(cw * 1.5f), 0 );
;3728:#endif
;3729:		}
line 3730
;3730:	} else {
ADDRGP4 $2021
JUMPV
LABELV $2020
line 3731
;3731:		if ( cgs.gametype == GT_FFA ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 0
NEI4 $2042
line 3732
;3732:			s = "Free For All";
ADDRLP4 8
ADDRGP4 $2045
ASGNP4
line 3733
;3733:		} else if ( cgs.gametype == GT_TEAM ) {
ADDRGP4 $2043
JUMPV
LABELV $2042
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
NEI4 $2046
line 3734
;3734:			s = "Team Deathmatch";
ADDRLP4 8
ADDRGP4 $2049
ASGNP4
line 3735
;3735:		} else if ( cgs.gametype == GT_CTF ) {
ADDRGP4 $2047
JUMPV
LABELV $2046
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
NEI4 $2050
line 3736
;3736:			s = "Capture the Flag";
ADDRLP4 8
ADDRGP4 $2053
ASGNP4
line 3745
;3737:#ifdef MISSIONPACK
;3738:		} else if ( cgs.gametype == GT_1FCTF ) {
;3739:			s = "One Flag CTF";
;3740:		} else if ( cgs.gametype == GT_OBELISK ) {
;3741:			s = "Overload";
;3742:		} else if ( cgs.gametype == GT_HARVESTER ) {
;3743:			s = "Harvester";
;3744:#endif
;3745:		} else {
ADDRGP4 $2051
JUMPV
LABELV $2050
line 3746
;3746:			s = "";
ADDRLP4 8
ADDRGP4 $1228
ASGNP4
line 3747
;3747:		}
LABELV $2051
LABELV $2047
LABELV $2043
line 3752
;3748:#ifdef MISSIONPACK
;3749:		w = CG_Text_Width(s, 0.6f, 0);
;3750:		CG_Text_Paint(320 - w / 2, 90, 0.6f, colorWhite, s, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE);
;3751:#else
;3752:		w = CG_DrawStrlen( s );
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 32
INDIRI4
ASGNI4
line 3753
;3753:		if ( w > 640 / GIANT_WIDTH ) {
ADDRLP4 16
INDIRI4
CNSTI4 20
LEI4 $2054
line 3754
;3754:			cw = 640 / w;
ADDRLP4 12
CNSTI4 640
ADDRLP4 16
INDIRI4
DIVI4
ASGNI4
line 3755
;3755:		} else {
ADDRGP4 $2055
JUMPV
LABELV $2054
line 3756
;3756:			cw = GIANT_WIDTH;
ADDRLP4 12
CNSTI4 32
ASGNI4
line 3757
;3757:		}
LABELV $2055
line 3758
;3758:		CG_DrawStringExt( 320 - w * cw/2, 25,s, colorWhite,
CNSTI4 320
ADDRLP4 16
INDIRI4
ADDRLP4 12
INDIRI4
MULI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 25
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
CVIF4 4
CNSTF4 1066192077
MULF4
CVFI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3761
;3759:				qfalse, qtrue, cw, (int)(cw * 1.1f), 0 );
;3760:#endif
;3761:	}
LABELV $2021
line 3763
;3762:
;3763:	sec = ( sec - cg.time ) / 1000;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRGP4 cg+107656
INDIRI4
SUBI4
CNSTI4 1000
DIVI4
ASGNI4
line 3764
;3764:	if ( sec < 0 ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $2057
line 3765
;3765:		cg.warmup = 0;
ADDRGP4 cg+127968
CNSTI4 0
ASGNI4
line 3766
;3766:		sec = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 3767
;3767:	}
LABELV $2057
line 3768
;3768:	s = va( "Starts in: %i", sec + 1 );
ADDRGP4 $2060
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 32
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 32
INDIRP4
ASGNP4
line 3769
;3769:	if ( sec != cg.warmupCount ) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+127972
INDIRI4
EQI4 $2061
line 3770
;3770:		cg.warmupCount = sec;
ADDRGP4 cg+127972
ADDRLP4 4
INDIRI4
ASGNI4
line 3771
;3771:		switch ( sec ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $2067
ADDRLP4 4
INDIRI4
CNSTI4 1
EQI4 $2070
ADDRLP4 4
INDIRI4
CNSTI4 2
EQI4 $2073
ADDRGP4 $2066
JUMPV
LABELV $2067
line 3773
;3772:		case 0:
;3773:			trap_S_StartLocalSound( cgs.media.count1Sound, CHAN_ANNOUNCER );
ADDRGP4 cgs+751220+1468
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 3774
;3774:			break;
ADDRGP4 $2066
JUMPV
LABELV $2070
line 3776
;3775:		case 1:
;3776:			trap_S_StartLocalSound( cgs.media.count2Sound, CHAN_ANNOUNCER );
ADDRGP4 cgs+751220+1464
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 3777
;3777:			break;
ADDRGP4 $2066
JUMPV
LABELV $2073
line 3779
;3778:		case 2:
;3779:			trap_S_StartLocalSound( cgs.media.count3Sound, CHAN_ANNOUNCER );
ADDRGP4 cgs+751220+1460
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 3780
;3780:			break;
line 3782
;3781:		default:
;3782:			break;
LABELV $2066
line 3784
;3783:		}
;3784:	}
LABELV $2061
line 3785
;3785:	scale = 0.45f;
ADDRLP4 28
CNSTF4 1055286886
ASGNF4
line 3786
;3786:	switch ( cg.warmupCount ) {
ADDRLP4 36
ADDRGP4 cg+127972
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $2079
ADDRLP4 36
INDIRI4
CNSTI4 1
EQI4 $2080
ADDRLP4 36
INDIRI4
CNSTI4 2
EQI4 $2081
ADDRGP4 $2076
JUMPV
LABELV $2079
line 3788
;3787:	case 0:
;3788:		cw = 28;
ADDRLP4 12
CNSTI4 28
ASGNI4
line 3789
;3789:		scale = 0.54f;
ADDRLP4 28
CNSTF4 1057635697
ASGNF4
line 3790
;3790:		break;
ADDRGP4 $2077
JUMPV
LABELV $2080
line 3792
;3791:	case 1:
;3792:		cw = 24;
ADDRLP4 12
CNSTI4 24
ASGNI4
line 3793
;3793:		scale = 0.51f;
ADDRLP4 28
CNSTF4 1057132380
ASGNF4
line 3794
;3794:		break;
ADDRGP4 $2077
JUMPV
LABELV $2081
line 3796
;3795:	case 2:
;3796:		cw = 20;
ADDRLP4 12
CNSTI4 20
ASGNI4
line 3797
;3797:		scale = 0.48f;
ADDRLP4 28
CNSTF4 1056293519
ASGNF4
line 3798
;3798:		break;
ADDRGP4 $2077
JUMPV
LABELV $2076
line 3800
;3799:	default:
;3800:		cw = 16;
ADDRLP4 12
CNSTI4 16
ASGNI4
line 3801
;3801:		scale = 0.45f;
ADDRLP4 28
CNSTF4 1055286886
ASGNF4
line 3802
;3802:		break;
LABELV $2077
line 3809
;3803:	}
;3804:
;3805:#ifdef MISSIONPACK
;3806:		w = CG_Text_Width(s, scale, 0);
;3807:		CG_Text_Paint(320 - w / 2, 125, scale, colorWhite, s, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE);
;3808:#else
;3809:	w = CG_DrawStrlen( s );
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 40
INDIRI4
ASGNI4
line 3810
;3810:	CG_DrawStringExt( 320 - w * cw/2, 70, s, colorWhite,
CNSTI4 320
ADDRLP4 16
INDIRI4
ADDRLP4 12
INDIRI4
MULI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 70
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
CVIF4 4
CNSTF4 1069547520
MULF4
CVFI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3813
;3811:			qfalse, qtrue, cw, (int)(cw * 1.5), 0 );
;3812:#endif
;3813:}
LABELV $2012
endproc CG_DrawWarmup 48 36
proc CG_StandardView 36 36
line 3822
;3814:
;3815:/*
;3816:=================
;3817:JUHOX: CG_StandardView
;3818:=================
;3819:*/
;3820:#if SPECIAL_VIEW_MODES
;3821:#define SVM_SWITCHING_NUM_TILES 7
;3822:static void CG_StandardView(void) {
line 3828
;3823:	float fraction;
;3824:	int i;
;3825:	float x, y, w, h;
;3826:	float tileSize;
;3827:
;3828:	if (!cg.viewModeSwitchingTime) return;
ADDRGP4 cg+107632
INDIRI4
CNSTI4 0
NEI4 $2083
ADDRGP4 $2082
JUMPV
LABELV $2083
line 3830
;3829:
;3830:	if (cg.time >= cg.viewModeSwitchingTime + VIEWMODE_SWITCHING_TIME) {
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cg+107632
INDIRI4
CNSTI4 200
ADDI4
LTI4 $2086
line 3831
;3831:		cg.viewModeSwitchingTime = 0;
ADDRGP4 cg+107632
CNSTI4 0
ASGNI4
line 3832
;3832:		return;
ADDRGP4 $2082
JUMPV
LABELV $2086
line 3834
;3833:	}
;3834:	fraction = (float)(cg.time - cg.viewModeSwitchingTime) / (float)VIEWMODE_SWITCHING_TIME;
ADDRLP4 4
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cg+107632
INDIRI4
SUBI4
CVIF4 4
CNSTF4 1000593162
MULF4
ASGNF4
line 3836
;3835:
;3836:	x = 0;
ADDRLP4 12
CNSTF4 0
ASGNF4
line 3837
;3837:	y = 0;
ADDRLP4 16
CNSTF4 0
ASGNF4
line 3838
;3838:	w = 640;
ADDRLP4 20
CNSTF4 1142947840
ASGNF4
line 3839
;3839:	h = 480;
ADDRLP4 24
CNSTF4 1139802112
ASGNF4
line 3840
;3840:	CG_AdjustFrom640(&x, &y, &w, &h);
ADDRLP4 12
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 24
ARGP4
ADDRGP4 CG_AdjustFrom640
CALLV
pop
line 3841
;3841:	tileSize = h / SVM_SWITCHING_NUM_TILES;
ADDRLP4 8
ADDRLP4 24
INDIRF4
CNSTF4 1041385765
MULF4
ASGNF4
line 3843
;3842:
;3843:	for (i = 0; i < SVM_SWITCHING_NUM_TILES; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2093
line 3846
;3844:		float yy, hh;
;3845:
;3846:		yy = y + (i + fraction) * tileSize;
ADDRLP4 28
ADDRLP4 16
INDIRF4
ADDRLP4 0
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRF4
ADDF4
ADDRLP4 8
INDIRF4
MULF4
ADDF4
ASGNF4
line 3847
;3847:		hh = (1 - fraction) * tileSize;
ADDRLP4 32
CNSTF4 1065353216
ADDRLP4 4
INDIRF4
SUBF4
ADDRLP4 8
INDIRF4
MULF4
ASGNF4
line 3848
;3848:		trap_R_DrawStretchPic(
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 cgs+751220+364
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 3852
;3849:			x, yy, w, hh, 0, 0, 1, 1,
;3850:			cgs.media.amplifierShader
;3851:		);
;3852:	}
LABELV $2094
line 3843
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 7
LTI4 $2093
line 3853
;3853:}
LABELV $2082
endproc CG_StandardView 36 36
data
align 4
LABELV $2100
byte 4 1031798784
byte 4 1031798784
byte 4 1031798784
byte 4 1065353216
code
proc CG_ScannerView 60 36
line 3862
;3854:#endif
;3855:
;3856:/*
;3857:=================
;3858:JUHOX: CG_ScannerView
;3859:=================
;3860:*/
;3861:#if SPECIAL_VIEW_MODES
;3862:static void CG_ScannerView(void) {
line 3871
;3863:	float x, y, w, h;
;3864:	static const vec4_t filterColor = {
;3865:		0.0625, 0.0625, 0.0625, 1
;3866:	};
;3867:	float fraction;
;3868:	float tileSize;
;3869:	int i;
;3870:
;3871:	x = 0;
ADDRLP4 12
CNSTF4 0
ASGNF4
line 3872
;3872:	y = 0;
ADDRLP4 16
CNSTF4 0
ASGNF4
line 3873
;3873:	w = 640;
ADDRLP4 20
CNSTF4 1142947840
ASGNF4
line 3874
;3874:	h = 480;
ADDRLP4 24
CNSTF4 1139802112
ASGNF4
line 3875
;3875:	CG_AdjustFrom640(&x, &y, &w, &h);
ADDRLP4 12
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 24
ARGP4
ADDRGP4 CG_AdjustFrom640
CALLV
pop
line 3877
;3876:
;3877:	if (cg.time >= cg.viewModeSwitchingTime + VIEWMODE_SWITCHING_TIME) {
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cg+107632
INDIRI4
CNSTI4 200
ADDI4
LTI4 $2101
line 3878
;3878:		cg.viewModeSwitchingTime = 0;
ADDRGP4 cg+107632
CNSTI4 0
ASGNI4
line 3879
;3879:	}
LABELV $2101
line 3881
;3880:
;3881:	if (!cg.viewModeSwitchingTime) {
ADDRGP4 cg+107632
INDIRI4
CNSTI4 0
NEI4 $2106
line 3884
;3882:		float s, t;
;3883:
;3884:		s = 0.7 * random();
ADDRLP4 36
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 28
ADDRLP4 36
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 36
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1060320051
MULF4
ASGNF4
line 3885
;3885:		t = 0.7 * random();
ADDRLP4 40
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 32
ADDRLP4 40
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 40
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1060320051
MULF4
ASGNF4
line 3886
;3886:		trap_R_SetColor(filterColor);
ADDRGP4 $2100
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 3887
;3887:		trap_R_DrawStretchPic(
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 44
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 44
INDIRF4
ARGF4
ADDRLP4 48
ADDRLP4 32
INDIRF4
ASGNF4
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 44
INDIRF4
CNSTF4 1050253722
ADDF4
ARGF4
ADDRLP4 48
INDIRF4
CNSTF4 1050253722
ADDF4
ARGF4
ADDRGP4 cgs+751220+360
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 3892
;3888:			x, y, w, h, s, t, s+0.3, t+0.3,
;3889:			cgs.media.scannerShader
;3890:		);
;3891:
;3892:		trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 3893
;3893:		return;
ADDRGP4 $2099
JUMPV
LABELV $2106
line 3896
;3894:	}
;3895:
;3896:	fraction = (float)(cg.time - cg.viewModeSwitchingTime) / (float)VIEWMODE_SWITCHING_TIME;
ADDRLP4 4
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cg+107632
INDIRI4
SUBI4
CVIF4 4
CNSTF4 1000593162
MULF4
ASGNF4
line 3897
;3897:	tileSize = h / SVM_SWITCHING_NUM_TILES;
ADDRLP4 8
ADDRLP4 24
INDIRF4
CNSTF4 1041385765
MULF4
ASGNF4
line 3899
;3898:
;3899:	trap_R_SetColor(filterColor);
ADDRGP4 $2100
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 3900
;3900:	for (i = 0; i < SVM_SWITCHING_NUM_TILES; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2113
line 3904
;3901:		float yy, hh;
;3902:		float s, t;
;3903:
;3904:		yy = y + i * tileSize;
ADDRLP4 36
ADDRLP4 16
INDIRF4
ADDRLP4 0
INDIRI4
CVIF4 4
ADDRLP4 8
INDIRF4
MULF4
ADDF4
ASGNF4
line 3905
;3905:		hh = fraction * tileSize;
ADDRLP4 40
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
MULF4
ASGNF4
line 3906
;3906:		s = 0.7 * random();
ADDRLP4 44
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 28
ADDRLP4 44
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 44
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1060320051
MULF4
ASGNF4
line 3907
;3907:		t = 0.7 * random();
ADDRLP4 48
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 32
ADDRLP4 48
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 48
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1060320051
MULF4
ASGNF4
line 3908
;3908:		trap_R_DrawStretchPic(
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 28
INDIRF4
CNSTF4 1050253722
ADDF4
ARGF4
ADDRLP4 32
INDIRF4
ADDRLP4 4
INDIRF4
CNSTF4 1026525945
MULF4
ADDF4
ARGF4
ADDRGP4 cgs+751220+360
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 3913
;3909:			x, yy, w, hh,
;3910:			s, t, s+0.3, t+0.3*fraction/SVM_SWITCHING_NUM_TILES,
;3911:			cgs.media.scannerShader
;3912:		);
;3913:	}
LABELV $2114
line 3900
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 7
LTI4 $2113
line 3914
;3914:	trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 3915
;3915:}
LABELV $2099
endproc CG_ScannerView 60 36
data
align 4
LABELV $2120
byte 4 1031798784
byte 4 1031798784
byte 4 1031798784
byte 4 1065353216
code
proc CG_AmplifierView 60 36
line 3924
;3916:#endif
;3917:
;3918:/*
;3919:=================
;3920:JUHOX: CG_AmplifierView
;3921:=================
;3922:*/
;3923:#if SPECIAL_VIEW_MODES
;3924:static void CG_AmplifierView(void) {
line 3934
;3925:	float fraction;
;3926:	int i;
;3927:	float x, y, w, h;
;3928:	float tileSize;
;3929:	static const vec4_t filterColor = {
;3930:		0.0625, 0.0625, 0.0625, 1
;3931:	};
;3932:
;3933:
;3934:	x = 0;
ADDRLP4 12
CNSTF4 0
ASGNF4
line 3935
;3935:	y = 0;
ADDRLP4 20
CNSTF4 0
ASGNF4
line 3936
;3936:	w = 640;
ADDRLP4 16
CNSTF4 1142947840
ASGNF4
line 3937
;3937:	h = 480;
ADDRLP4 24
CNSTF4 1139802112
ASGNF4
line 3938
;3938:	CG_AdjustFrom640(&x, &y, &w, &h);
ADDRLP4 12
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 24
ARGP4
ADDRGP4 CG_AdjustFrom640
CALLV
pop
line 3940
;3939:
;3940:	if (cg.time >= cg.viewModeSwitchingTime + VIEWMODE_SWITCHING_TIME) {
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cg+107632
INDIRI4
CNSTI4 200
ADDI4
LTI4 $2121
line 3941
;3941:		cg.viewModeSwitchingTime = 0;
ADDRGP4 cg+107632
CNSTI4 0
ASGNI4
line 3942
;3942:	}
LABELV $2121
line 3944
;3943:
;3944:	if (!cg.viewModeSwitchingTime) {
ADDRGP4 cg+107632
INDIRI4
CNSTI4 0
NEI4 $2126
line 3945
;3945:		trap_R_DrawStretchPic(x, y, w, h, 0, 0, 1, 1, cgs.media.amplifierShader);
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 cgs+751220+364
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 3946
;3946:		return;
ADDRGP4 $2119
JUMPV
LABELV $2126
line 3949
;3947:	}
;3948:
;3949:	fraction = (float)(cg.time - cg.viewModeSwitchingTime) / (float)VIEWMODE_SWITCHING_TIME;
ADDRLP4 0
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cg+107632
INDIRI4
SUBI4
CVIF4 4
CNSTF4 1000593162
MULF4
ASGNF4
line 3951
;3950:
;3951:	tileSize = h / SVM_SWITCHING_NUM_TILES;
ADDRLP4 8
ADDRLP4 24
INDIRF4
CNSTF4 1041385765
MULF4
ASGNF4
line 3953
;3952:
;3953:	trap_R_SetColor(filterColor);
ADDRGP4 $2120
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 3954
;3954:	for (i = 0; i < SVM_SWITCHING_NUM_TILES; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $2133
line 3958
;3955:		float yy, hh;
;3956:		float s, t;
;3957:
;3958:		yy = y + i * tileSize;
ADDRLP4 32
ADDRLP4 20
INDIRF4
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRLP4 8
INDIRF4
MULF4
ADDF4
ASGNF4
line 3959
;3959:		hh = fraction * tileSize;
ADDRLP4 28
ADDRLP4 0
INDIRF4
ADDRLP4 8
INDIRF4
MULF4
ASGNF4
line 3960
;3960:		trap_R_DrawStretchPic(x, yy, w, hh, 0, 0, 1, 1, cgs.media.amplifierShader);
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 cgs+751220+364
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 3962
;3961:
;3962:		yy += hh;
ADDRLP4 32
ADDRLP4 32
INDIRF4
ADDRLP4 28
INDIRF4
ADDF4
ASGNF4
line 3963
;3963:		hh = (1 - fraction) * tileSize;
ADDRLP4 28
CNSTF4 1065353216
ADDRLP4 0
INDIRF4
SUBF4
ADDRLP4 8
INDIRF4
MULF4
ASGNF4
line 3964
;3964:		s = 0.7 * random();
ADDRLP4 44
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 36
ADDRLP4 44
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 44
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1060320051
MULF4
ASGNF4
line 3965
;3965:		t = 0.7 * random();
ADDRLP4 48
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 40
ADDRLP4 48
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 48
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1060320051
MULF4
ASGNF4
line 3966
;3966:		trap_R_DrawStretchPic(
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 36
INDIRF4
CNSTF4 1050253722
ADDF4
ARGF4
ADDRLP4 40
INDIRF4
ADDRLP4 0
INDIRF4
CNSTF4 1026525945
MULF4
ADDF4
ARGF4
ADDRGP4 cgs+751220+360
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 3971
;3967:			x, yy, w, hh,
;3968:			s, t, s+0.3, t+0.3*fraction/SVM_SWITCHING_NUM_TILES,
;3969:			cgs.media.scannerShader
;3970:		);
;3971:	}
LABELV $2134
line 3954
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 7
LTI4 $2133
line 3972
;3972:	trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 3973
;3973:}
LABELV $2119
endproc CG_AmplifierView 60 36
proc CG_HandleViewMode 8 0
line 3982
;3974:#endif
;3975:
;3976:/*
;3977:=================
;3978:JUHOX: CG_HandleViewMode
;3979:=================
;3980:*/
;3981:#if SPECIAL_VIEW_MODES
;3982:static void CG_HandleViewMode(void) {
line 3983
;3983:	if (cg.predictedPlayerState.pm_type == PM_INTERMISSION) {
ADDRGP4 cg+107688+4
INDIRI4
CNSTI4 5
NEI4 $2142
line 3984
;3984:		cg.viewMode = VIEW_standard;
ADDRGP4 cg+107628
CNSTI4 0
ASGNI4
line 3985
;3985:		cg.viewModeSwitchingTime = 0;
ADDRGP4 cg+107632
CNSTI4 0
ASGNI4
line 3986
;3986:	}
LABELV $2142
line 3988
;3987:
;3988:	if (cg.viewMode != VIEW_scanner) {
ADDRGP4 cg+107628
INDIRI4
CNSTI4 1
EQI4 $2148
line 3989
;3989:		cg.scannerActivationTime = 0;
ADDRGP4 cg+107636
CNSTI4 0
ASGNI4
line 3990
;3990:	}
ADDRGP4 $2149
JUMPV
LABELV $2148
line 3991
;3991:	else if (!cg.scannerActivationTime) {
ADDRGP4 cg+107636
INDIRI4
CNSTI4 0
NEI4 $2152
line 3992
;3992:		cg.scannerActivationTime = cg.time;
ADDRGP4 cg+107636
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 3993
;3993:	}
LABELV $2152
LABELV $2149
line 3995
;3994:
;3995:	switch (cg.viewMode) {
ADDRLP4 0
ADDRGP4 cg+107628
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $2161
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $2162
ADDRLP4 0
INDIRI4
CNSTI4 2
EQI4 $2163
ADDRGP4 $2157
JUMPV
LABELV $2161
LABELV $2157
line 3998
;3996:	case VIEW_standard:
;3997:	default:
;3998:		CG_StandardView();
ADDRGP4 CG_StandardView
CALLV
pop
line 3999
;3999:		break;
ADDRGP4 $2158
JUMPV
LABELV $2162
line 4001
;4000:	case VIEW_scanner:
;4001:		CG_ScannerView();
ADDRGP4 CG_ScannerView
CALLV
pop
line 4002
;4002:		break;
ADDRGP4 $2158
JUMPV
LABELV $2163
line 4004
;4003:	case VIEW_amplifier:
;4004:		CG_AmplifierView();
ADDRGP4 CG_AmplifierView
CALLV
pop
line 4005
;4005:		CG_DrawLightBlobs();
ADDRGP4 CG_DrawLightBlobs
CALLV
pop
line 4006
;4006:		break;
LABELV $2158
line 4008
;4007:	}
;4008:}
LABELV $2141
endproc CG_HandleViewMode 8 0
proc CG_Draw2D 56 36
line 4035
;4009:#endif
;4010:
;4011:
;4012://==================================================================================
;4013:#ifdef MISSIONPACK
;4014:/*
;4015:=================
;4016:CG_DrawTimedMenus
;4017:=================
;4018:*/
;4019:void CG_DrawTimedMenus() {
;4020:	if (cg.voiceTime) {
;4021:		int t = cg.time - cg.voiceTime;
;4022:		if ( t > 2500 ) {
;4023:			Menus_CloseByName("voiceMenu");
;4024:			trap_Cvar_Set("cl_conXOffset", "0");
;4025:			cg.voiceTime = 0;
;4026:		}
;4027:	}
;4028:}
;4029:#endif
;4030:/*
;4031:=================
;4032:CG_Draw2D
;4033:=================
;4034:*/
;4035:static void CG_Draw2D( void ) {
line 4042
;4036:#ifdef MISSIONPACK
;4037:	if (cgs.orderPending && cg.time > cgs.orderTime) {
;4038:		CG_CheckOrderPending();
;4039:	}
;4040:#endif
;4041:	// if we are taking a levelshot for the menu, don't draw anything
;4042:	if ( cg.levelShot ) {
ADDRGP4 cg+12
INDIRI4
CNSTI4 0
EQI4 $2165
line 4043
;4043:		return;
ADDRGP4 $2164
JUMPV
LABELV $2165
line 4046
;4044:	}
;4045:
;4046:	if ( cg_draw2D.integer == 0 ) {
ADDRGP4 cg_draw2D+12
INDIRI4
CNSTI4 0
NEI4 $2168
line 4047
;4047:		return;
ADDRGP4 $2164
JUMPV
LABELV $2168
line 4050
;4048:	}
;4049:
;4050:	if ( cg.snap->ps.pm_type == PM_INTERMISSION ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 5
NEI4 $2171
line 4051
;4051:		CG_DrawIntermission();
ADDRGP4 CG_DrawIntermission
CALLV
pop
line 4052
;4052:		return;
ADDRGP4 $2164
JUMPV
LABELV $2171
line 4060
;4053:	}
;4054:
;4055:/*
;4056:	if (cg.cameraMode) {
;4057:		return;
;4058:	}
;4059:*/
;4060:	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $2174
line 4061
;4061:		CG_DrawSpectator();
ADDRGP4 CG_DrawSpectator
CALLV
pop
line 4062
;4062:		CG_DrawCrosshair();
ADDRGP4 CG_DrawCrosshair
CALLV
pop
line 4063
;4063:		CG_DrawCrosshairNames();
ADDRGP4 CG_DrawCrosshairNames
CALLV
pop
line 4064
;4064:	} else {
ADDRGP4 $2175
JUMPV
LABELV $2174
line 4066
;4065:		// don't draw any status if dead or the scoreboard is being explicitly shown
;4066:		if ( !cg.showScores && cg.snap->ps.stats[STAT_HEALTH] > 0 ) {
ADDRGP4 cg+117624
INDIRI4
CNSTI4 0
NEI4 $2177
ADDRGP4 cg+36
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
LEI4 $2177
line 4074
;4067:
;4068:#ifdef MISSIONPACK
;4069:			if ( cg_drawStatus.integer ) {
;4070:				Menu_PaintAll();
;4071:				CG_DrawTimedMenus();
;4072:			}
;4073:#else
;4074:			CG_DrawStatusBar();
ADDRGP4 CG_DrawStatusBar
CALLV
pop
line 4077
;4075:#endif
;4076:
;4077:			CG_DrawAmmoWarning();
ADDRGP4 CG_DrawAmmoWarning
CALLV
pop
line 4082
;4078:
;4079:#ifdef MISSIONPACK
;4080:			CG_DrawProxWarning();
;4081:#endif
;4082:			CG_DrawCrosshair();
ADDRGP4 CG_DrawCrosshair
CALLV
pop
line 4083
;4083:			CG_DrawCrosshairNames();
ADDRGP4 CG_DrawCrosshairNames
CALLV
pop
line 4084
;4084:			CG_DrawWeaponSelect();
ADDRGP4 CG_DrawWeaponSelect
CALLV
pop
line 4087
;4085:
;4086:#ifndef MISSIONPACK
;4087:			CG_DrawHoldableItem();
ADDRGP4 CG_DrawHoldableItem
CALLV
pop
line 4091
;4088:#else
;4089:			//CG_DrawPersistantPowerup();
;4090:#endif
;4091:			CG_DrawReward();
ADDRGP4 CG_DrawReward
CALLV
pop
line 4092
;4092:		}
LABELV $2177
line 4095
;4093:
;4094:#if 1	// JUHOX: if dead, draw at least the strength bar
;4095:		if (cg.snap->ps.stats[STAT_HEALTH] <= 0) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
GTI4 $2181
line 4099
;4096:			vec4_t color;
;4097:			float x, y, w, h, s, t;
;4098:
;4099:			color[0] = 1.0;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 4100
;4100:			color[1] = 0.9;
ADDRLP4 0+4
CNSTF4 1063675494
ASGNF4
line 4101
;4101:			color[2] = 0.5;
ADDRLP4 0+8
CNSTF4 1056964608
ASGNF4
line 4102
;4102:			color[3] = 0.4;
ADDRLP4 0+12
CNSTF4 1053609165
ASGNF4
line 4103
;4103:			trap_R_SetColor(color);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 4104
;4104:			x = 0;
ADDRLP4 16
CNSTF4 0
ASGNF4
line 4105
;4105:			y = 0;
ADDRLP4 20
CNSTF4 0
ASGNF4
line 4106
;4106:			w = 640;
ADDRLP4 24
CNSTF4 1142947840
ASGNF4
line 4107
;4107:			h = 480;
ADDRLP4 28
CNSTF4 1139802112
ASGNF4
line 4108
;4108:			CG_AdjustFrom640(&x, &y, &w, &h);
ADDRLP4 16
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 28
ARGP4
ADDRGP4 CG_AdjustFrom640
CALLV
pop
line 4109
;4109:			s = 0.7 * random();
ADDRLP4 40
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 32
ADDRLP4 40
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 40
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1060320051
MULF4
ASGNF4
line 4110
;4110:			t = 0.7 * random();
ADDRLP4 44
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 36
ADDRLP4 44
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 44
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
CNSTF4 1060320051
MULF4
ASGNF4
line 4111
;4111:			trap_R_DrawStretchPic(x, y, w, h, s, t, s+0.3, t+0.3, cgs.media.deathBlurryShader);
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 48
ADDRLP4 32
INDIRF4
ASGNF4
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 52
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 52
INDIRF4
ARGF4
ADDRLP4 48
INDIRF4
CNSTF4 1050253722
ADDF4
ARGF4
ADDRLP4 52
INDIRF4
CNSTF4 1050253722
ADDF4
ARGF4
ADDRGP4 cgs+751220+352
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 4112
;4112:			trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 4113
;4113:			CG_DrawStrengthBar(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStrengthBar
CALLV
pop
line 4114
;4114:		}
LABELV $2181
line 4117
;4115:#endif
;4116:
;4117:		if ( cgs.gametype >= GT_TEAM ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $2189
line 4119
;4118:#ifndef MISSIONPACK
;4119:			CG_DrawTeamInfo();
ADDRGP4 CG_DrawTeamInfo
CALLV
pop
line 4121
;4120:#endif
;4121:		}
LABELV $2189
line 4122
;4122:	}
LABELV $2175
line 4124
;4123:
;4124:	CG_DrawVote();
ADDRGP4 CG_DrawVote
CALLV
pop
line 4125
;4125:	CG_DrawTeamVote();
ADDRGP4 CG_DrawTeamVote
CALLV
pop
line 4127
;4126:
;4127:	CG_DrawLagometer();
ADDRGP4 CG_DrawLagometer
CALLV
pop
line 4134
;4128:
;4129:#ifdef MISSIONPACK
;4130:	if (!cg_paused.integer) {
;4131:		CG_DrawUpperRight();
;4132:	}
;4133:#else
;4134:	CG_DrawUpperRight();
ADDRGP4 CG_DrawUpperRight
CALLV
pop
line 4138
;4135:#endif
;4136:
;4137:#ifndef MISSIONPACK
;4138:	CG_DrawLowerRight();
ADDRGP4 CG_DrawLowerRight
CALLV
pop
line 4139
;4139:	CG_DrawLowerLeft();
ADDRGP4 CG_DrawLowerLeft
CALLV
pop
line 4142
;4140:#endif
;4141:
;4142:	if ( !CG_DrawFollow() ) {
ADDRLP4 0
ADDRGP4 CG_DrawFollow
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2192
line 4143
;4143:		CG_DrawWarmup();
ADDRGP4 CG_DrawWarmup
CALLV
pop
line 4144
;4144:	}
LABELV $2192
line 4147
;4145:
;4146:	// don't draw center string if scoreboard is up
;4147:	cg.scoreBoardShowing = CG_DrawScoreboard();
ADDRLP4 4
ADDRGP4 CG_DrawScoreboard
CALLI4
ASGNI4
ADDRGP4 cg+117628
ADDRLP4 4
INDIRI4
ASGNI4
line 4148
;4148:	if ( !cg.scoreBoardShowing) {
ADDRGP4 cg+117628
INDIRI4
CNSTI4 0
NEI4 $2195
line 4149
;4149:		CG_DrawCenterString();
ADDRGP4 CG_DrawCenterString
CALLV
pop
line 4150
;4150:	}
LABELV $2195
line 4152
;4151:#if 1	// JUHOX: draw TSS interface
;4152:	if (cg.tssInterfaceOn) {
ADDRGP4 cg+128100
INDIRI4
CNSTI4 0
EQI4 $2198
line 4153
;4153:		CG_TSS_DrawInterface();
ADDRGP4 CG_TSS_DrawInterface
CALLV
pop
line 4154
;4154:	}
LABELV $2198
line 4156
;4155:#endif
;4156:}
LABELV $2164
endproc CG_Draw2D 56 36
proc CG_DrawTourneyScoreboard 0 0
line 4159
;4157:
;4158:
;4159:static void CG_DrawTourneyScoreboard() {
line 4162
;4160:#ifdef MISSIONPACK
;4161:#else
;4162:	CG_DrawOldTourneyScoreboard();
ADDRGP4 CG_DrawOldTourneyScoreboard
CALLV
pop
line 4164
;4163:#endif
;4164:}
LABELV $2201
endproc CG_DrawTourneyScoreboard 0 0
data
align 4
LABELV $2266
byte 4 1045220557
byte 4 0
byte 4 0
byte 4 1060320051
export CG_DrawActive
code
proc CG_DrawActive 1072 32
line 4173
;4165:
;4166:/*
;4167:=====================
;4168:CG_DrawActive
;4169:
;4170:Perform all drawing needed to completely fill the screen
;4171:=====================
;4172:*/
;4173:void CG_DrawActive( stereoFrame_t stereoView ) {
line 4178
;4174:	float		separation;
;4175:	vec3_t		baseOrg;
;4176:
;4177:	// optionally draw the info screen instead
;4178:	if ( !cg.snap ) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2203
line 4179
;4179:		CG_DrawInformation();
ADDRGP4 CG_DrawInformation
CALLV
pop
line 4180
;4180:		return;
ADDRGP4 $2202
JUMPV
LABELV $2203
line 4184
;4181:	}
;4182:
;4183:	// optionally draw the tournement scoreboard instead
;4184:	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR &&
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $2206
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $2206
line 4185
;4185:		( cg.snap->ps.pm_flags & PMF_SCOREBOARD ) ) {
line 4186
;4186:		CG_DrawTourneyScoreboard();
ADDRGP4 CG_DrawTourneyScoreboard
CALLV
pop
line 4187
;4187:		return;
ADDRGP4 $2202
JUMPV
LABELV $2206
line 4190
;4188:	}
;4189:
;4190:	switch ( stereoView ) {
ADDRLP4 16
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $2213
ADDRLP4 16
INDIRI4
CNSTI4 1
EQI4 $2214
ADDRLP4 16
INDIRI4
CNSTI4 2
EQI4 $2216
ADDRGP4 $2210
JUMPV
LABELV $2213
line 4192
;4191:	case STEREO_CENTER:
;4192:		separation = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 4193
;4193:		break;
ADDRGP4 $2211
JUMPV
LABELV $2214
line 4195
;4194:	case STEREO_LEFT:
;4195:		separation = -cg_stereoSeparation.value / 2;
ADDRLP4 0
ADDRGP4 cg_stereoSeparation+8
INDIRF4
NEGF4
CNSTF4 1056964608
MULF4
ASGNF4
line 4196
;4196:		break;
ADDRGP4 $2211
JUMPV
LABELV $2216
line 4198
;4197:	case STEREO_RIGHT:
;4198:		separation = cg_stereoSeparation.value / 2;
ADDRLP4 0
ADDRGP4 cg_stereoSeparation+8
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 4199
;4199:		break;
ADDRGP4 $2211
JUMPV
LABELV $2210
line 4201
;4200:	default:
;4201:		separation = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 4202
;4202:		CG_Error( "CG_DrawActive: Undefined stereoView" );
ADDRGP4 $2218
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 4203
;4203:	}
LABELV $2211
line 4207
;4204:
;4205:
;4206:	// clear around the rendered view if sized down
;4207:	CG_TileClear();
ADDRGP4 CG_TileClear
CALLV
pop
line 4210
;4208:
;4209:	// offset vieworg appropriately if we're doing stereo separation
;4210:	VectorCopy( cg.refdef.vieworg, baseOrg );
ADDRLP4 4
ADDRGP4 cg+109260+24
INDIRB
ASGNB 12
line 4211
;4211:	if ( separation != 0 ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
EQF4 $2221
line 4212
;4212:		VectorMA( cg.refdef.vieworg, -separation, cg.refdef.viewaxis[1], cg.refdef.vieworg );
ADDRGP4 cg+109260+24
ADDRGP4 cg+109260+24
INDIRF4
ADDRGP4 cg+109260+36+12
INDIRF4
ADDRLP4 0
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRGP4 cg+109260+24+4
ADDRGP4 cg+109260+24+4
INDIRF4
ADDRGP4 cg+109260+36+12+4
INDIRF4
ADDRLP4 0
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRGP4 cg+109260+24+8
ADDRGP4 cg+109260+24+8
INDIRF4
ADDRGP4 cg+109260+36+12+8
INDIRF4
ADDRLP4 0
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 4213
;4213:	}
LABELV $2221
line 4217
;4214:
;4215:#if MAPLENSFLARES	// JUHOX: add lens flare editor cursor
;4216:	if (
;4217:		cgs.editMode == EM_mlf &&
ADDRGP4 cgs+31684
INDIRI4
CNSTI4 1
NEI4 $2250
ADDRGP4 cg+109660+448
INDIRI4
CNSTI4 0
EQI4 $2257
ADDRGP4 cg+109660+452
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2250
LABELV $2257
line 4222
;4218:		!(
;4219:			cg.lfEditor.moversStopped &&
;4220:			cg.lfEditor.selectedMover
;4221:		)
;4222:	) {
line 4223
;4223:		CG_AddLFEditorCursor();
ADDRGP4 CG_AddLFEditorCursor
CALLV
pop
line 4224
;4224:	}
LABELV $2250
line 4228
;4225:#endif
;4226:
;4227:	// draw 3D view
;4228:	trap_R_RenderScene( &cg.refdef );
ADDRGP4 cg+109260
ARGP4
ADDRGP4 trap_R_RenderScene
CALLV
pop
line 4232
;4229:
;4230:#if MAPLENSFLARES	// JUHOX: mark selected mover for lens flare editor
;4231:	if (
;4232:		cgs.editMode == EM_mlf &&
ADDRGP4 cgs+31684
INDIRI4
CNSTI4 1
NEI4 $2259
ADDRGP4 cg+109660+448
INDIRI4
CNSTI4 0
EQI4 $2259
ADDRGP4 cg+109660+452
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2259
line 4235
;4233:		cg.lfEditor.moversStopped &&
;4234:		cg.lfEditor.selectedMover
;4235:	) {
line 4238
;4236:		static const vec4_t darkening = { 0.2, 0, 0, 0.7 };
;4237:
;4238:		CG_FillRect(0, 0, 640, 480, darkening);
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 1142947840
ARGF4
CNSTF4 1139802112
ARGF4
ADDRGP4 $2266
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 4239
;4239:		trap_R_ClearScene();
ADDRGP4 trap_R_ClearScene
CALLV
pop
line 4240
;4240:		CG_Mover(cg.lfEditor.selectedMover);
ADDRGP4 cg+109660+452
INDIRP4
ARGP4
ADDRGP4 CG_Mover
CALLV
pop
line 4241
;4241:		CG_AddLFEditorCursor();
ADDRGP4 CG_AddLFEditorCursor
CALLV
pop
line 4242
;4242:		cg.refdef.rdflags |= RDF_NOWORLDMODEL;
ADDRLP4 24
ADDRGP4 cg+109260+76
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 4243
;4243:		trap_R_RenderScene(&cg.refdef);
ADDRGP4 cg+109260
ARGP4
ADDRGP4 trap_R_RenderScene
CALLV
pop
line 4244
;4244:	}
LABELV $2259
line 4248
;4245:#endif
;4246:
;4247:	// restore original viewpoint if running stereo
;4248:	if ( separation != 0 ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
EQF4 $2272
line 4249
;4249:		VectorCopy( baseOrg, cg.refdef.vieworg );
ADDRGP4 cg+109260+24
ADDRLP4 4
INDIRB
ASGNB 12
line 4250
;4250:	}
LABELV $2272
line 4253
;4251:
;4252:#if SPECIAL_VIEW_MODES
;4253:	CG_HandleViewMode();	// JUHOX
ADDRGP4 CG_HandleViewMode
CALLV
pop
line 4257
;4254:#endif
;4255:
;4256:	// draw status bar and other floating elements
;4257: 	CG_Draw2D();
ADDRGP4 CG_Draw2D
CALLV
pop
line 4261
;4258:
;4259:#if 1	// JUHOX: auto group leader commands
;4260:	if (
;4261:		cg_autoGLC.integer &&
ADDRGP4 cg_autoGLC+12
INDIRI4
CNSTI4 0
EQI4 $2276
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $2276
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 8
GEI4 $2276
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 24
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $2276
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 28
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 3
LTI4 $2276
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cg+162904
INDIRI4
LTI4 $2276
line 4269
;4262:		cgs.gametype >= GT_TEAM &&
;4263:#if MONSTER_MODE	// JUHOX: no TSS with STU
;4264:		cgs.gametype < GT_STU &&
;4265:#endif
;4266:		BG_TSS_GetPlayerInfo(&cg.snap->ps, TSSPI_isValid) &&
;4267:		BG_TSS_GetPlayerInfo(&cg.snap->ps, TSSPI_groupMemberStatus) >= TSSGMS_temporaryLeader &&
;4268:		cg.time >= cg.tssAutoGLCUpdateTime
;4269:	) {
line 4273
;4270:		tss_groupFormation_t oldGF;
;4271:		tss_groupFormation_t newGF;
;4272:
;4273:		cg.tssAutoGLCUpdateTime = cg.time + 500;
ADDRGP4 cg+162904
ADDRGP4 cg+107656
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 4275
;4274:
;4275:		oldGF = BG_TSS_GetPlayerInfo(&cg.snap->ps, TSSPI_groupFormation);
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ARGP4
CNSTI4 6
ARGI4
ADDRLP4 40
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 36
ADDRLP4 40
INDIRI4
ASGNI4
line 4276
;4276:		newGF = BG_TSS_GetPlayerInfo(&cg.snap->ps, TSSPI_suggestedGF);
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ARGP4
CNSTI4 14
ARGI4
ADDRLP4 44
ADDRGP4 BG_TSS_GetPlayerInfo
CALLI4
ASGNI4
ADDRLP4 32
ADDRLP4 44
INDIRI4
ASGNI4
line 4278
;4277:
;4278:		if (oldGF != newGF) {
ADDRLP4 36
INDIRI4
ADDRLP4 32
INDIRI4
EQI4 $2289
line 4279
;4279:			switch (newGF) {
ADDRLP4 48
ADDRLP4 32
INDIRI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $2294
ADDRLP4 48
INDIRI4
CNSTI4 1
EQI4 $2296
ADDRLP4 48
INDIRI4
CNSTI4 2
EQI4 $2298
ADDRGP4 $2291
JUMPV
LABELV $2294
line 4281
;4280:			case TSSGF_tight:
;4281:				trap_SendClientCommand("groupformation tight");
ADDRGP4 $2295
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 4282
;4282:				break;
ADDRGP4 $2292
JUMPV
LABELV $2296
line 4284
;4283:			case TSSGF_loose:
;4284:				trap_SendClientCommand("groupformation loose");
ADDRGP4 $2297
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 4285
;4285:				break;
ADDRGP4 $2292
JUMPV
LABELV $2298
line 4287
;4286:			case TSSGF_free:
;4287:				trap_SendClientCommand("groupformation free");
ADDRGP4 $2299
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 4288
;4288:				break;
LABELV $2291
LABELV $2292
line 4290
;4289:			}
;4290:		}
LABELV $2289
line 4291
;4291:	}
LABELV $2276
line 4296
;4292:#endif
;4293:
;4294:#if 1	// JUHOX: tss server update
;4295:	if (
;4296:		cgs.gametype >= GT_TEAM &&
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $2300
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 8
GEI4 $2300
ADDRGP4 cg+4
INDIRI4
CNSTI4 1728
MULI4
ADDRGP4 cgs+41320+156
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2300
ADDRGP4 cg+131680
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2300
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cg+162888
INDIRI4
LTI4 $2300
ADDRGP4 cg+107688+4
INDIRI4
CNSTI4 5
EQI4 $2300
line 4304
;4297:#if MONSTER_MODE	// JUHOX: no TSS with STU
;4298:		cgs.gametype < GT_STU &&
;4299:#endif
;4300:		cgs.clientinfo[cg.clientNum].teamLeader &&
;4301:		cg.tssUtilizedStrategy &&
;4302:		cg.time >= cg.tssServerUpdateTime &&
;4303:		cg.predictedPlayerState.pm_type != PM_INTERMISSION
;4304:	) {
line 4309
;4305:		int cmdSize;
;4306:		char cmd[1024];
;4307:		char* buf;
;4308:
;4309:		cg.tssServerUpdateTime = cg.time + 2000;
ADDRGP4 cg+162888
ADDRGP4 cg+107656
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 4311
;4310:
;4311:		memset(&cmd, 0, sizeof(cmd));
ADDRLP4 32
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1024
ARGI4
ADDRGP4 memset
CALLP4
pop
line 4312
;4312:		Com_sprintf(
ADDRLP4 32
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $2314
ARGP4
ADDRGP4 cg+131680
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CNSTI4 128
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+131680
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CNSTI4 132
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+131680
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CNSTI4 136
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+131680
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+131680
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 4321
;4313:			cmd, sizeof(cmd), "tssinstructions %d %d %d %d %d ",
;4314:			cg.tssUtilizedStrategy->strategy->rfa_dangerLimit,
;4315:			cg.tssUtilizedStrategy->strategy->rfd_dangerLimit,
;4316:			cg.tssUtilizedStrategy->strategy->short_term,
;4317:			cg.tssUtilizedStrategy->strategy->medium_term,
;4318:			cg.tssUtilizedStrategy->strategy->long_term
;4319:		);
;4320:
;4321:		cmdSize = strlen(cmd);
ADDRLP4 32
ARGP4
ADDRLP4 1064
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1060
ADDRLP4 1064
INDIRI4
ASGNI4
line 4322
;4322:		buf = &cmd[cmdSize];
ADDRLP4 1056
ADDRLP4 1060
INDIRI4
ADDRLP4 32
ADDP4
ASGNP4
line 4323
;4323:		TSS_CodeInt(cg.tssOnline && cgs.tss, &buf);
ADDRGP4 cg+128220
INDIRI4
CNSTI4 0
EQI4 $2323
ADDRGP4 cgs+31836
INDIRI4
CNSTI4 0
EQI4 $2323
ADDRLP4 1068
CNSTI4 1
ASGNI4
ADDRGP4 $2324
JUMPV
LABELV $2323
ADDRLP4 1068
CNSTI4 0
ASGNI4
LABELV $2324
ADDRLP4 1068
INDIRI4
ARGI4
ADDRLP4 1056
ARGP4
ADDRGP4 TSS_CodeInt
CALLV
pop
line 4324
;4324:		BG_TSS_CodeInstructions(
ADDRGP4 cg+131680
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 1120
MULI4
ADDRGP4 cg+131680
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CNSTI4 148
ADDP4
ADDP4
CNSTI4 780
ADDP4
ARGP4
ADDRLP4 1056
ARGP4
ADDRGP4 BG_TSS_CodeInstructions
CALLV
pop
line 4328
;4325:			&cg.tssUtilizedStrategy->strategy->directives[cg.tssUtilizedStrategy->condition].instr,
;4326:			&buf
;4327:		);
;4328:		BG_TSS_CodeLeadership(
ADDRGP4 cg+129952
ARGP4
ADDRGP4 cg+129952+40
ARGP4
ADDRGP4 cg+129952+80
ARGP4
ADDRGP4 cg+129684
ARGP4
ADDRLP4 1056
ARGP4
ADDRGP4 BG_TSS_CodeLeadership
CALLV
pop
line 4334
;4329:			cg.tssGroupLeader[0], cg.tssGroupLeader[1], cg.tssGroupLeader[2],
;4330:			cg.tssTeamMatesClientNum,
;4331:			&buf
;4332:		);
;4333:
;4334:		trap_SendClientCommand(cmd);
ADDRLP4 32
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 4335
;4335:	}
LABELV $2300
line 4337
;4336:#endif
;4337:}
LABELV $2202
endproc CG_DrawActive 1072 32
bss
export lagometer
align 4
LABELV lagometer
skip 1544
import CG_AdjustParticles
import CG_NewParticleArea
import initparticles
import CG_ParticleExplosion
import CG_ParticleMisc
import CG_ParticleDust
import CG_ParticleSparks
import CG_ParticleBulletDebris
import CG_ParticleSnowFlurry
import CG_AddParticleShrapnel
import CG_ParticleSmoke
import CG_ParticleSnow
import CG_AddParticles
import CG_ClearParticles
import trap_GetEntityToken
import trap_getCameraInfo
import trap_startCamera
import trap_loadCamera
import trap_SnapVector
import trap_CIN_SetExtents
import trap_CIN_DrawCinematic
import trap_CIN_RunCinematic
import trap_CIN_StopCinematic
import trap_CIN_PlayCinematic
import trap_Key_GetKey
import trap_Key_SetCatcher
import trap_Key_GetCatcher
import trap_Key_IsDown
import trap_R_RegisterFont
import trap_MemoryRemaining
import testPrintFloat
import testPrintInt
import trap_SetUserCmdValue
import trap_GetUserCmd
import trap_GetCurrentCmdNumber
import trap_GetServerCommand
import trap_GetSnapshot
import trap_GetCurrentSnapshotNumber
import trap_GetGameState
import trap_GetGlconfig
import trap_R_RemapShader
import trap_R_LerpTag
import trap_R_ModelBounds
import trap_R_DrawStretchPic
import trap_R_SetColor
import trap_R_RenderScene
import trap_R_LightForPoint
import trap_R_AddLightToScene
import trap_R_AddPolysToScene
import trap_R_AddPolyToScene
import trap_R_AddRefEntityToScene
import trap_R_ClearScene
import trap_R_RegisterShaderNoMip
import trap_R_RegisterShader
import trap_R_RegisterSkin
import trap_R_RegisterModel
import trap_R_LoadWorldMap
import trap_S_AddRealLoopingSound_fixed
import trap_S_AddLoopingSound_fixed
import trap_S_StartSound_fixed
import currentReference
import trap_S_StopBackgroundTrack
import trap_S_StartBackgroundTrack
import trap_S_RegisterSound
import trap_S_Respatialize
import trap_S_UpdateEntityPosition
import trap_S_AddRealLoopingSound
import trap_S_AddLoopingSound
import trap_S_ClearLoopingSounds
import trap_S_StartLocalSound
import trap_S_StopLoopingSound
import trap_S_StartSound
import trap_CM_MarkFragments
import trap_CM_TransformedBoxTrace
import trap_CM_BoxTrace
import trap_CM_TransformedPointContents
import trap_CM_PointContents
import trap_CM_TempBoxModel
import trap_CM_InlineModel
import trap_CM_NumInlineModels
import trap_CM_LoadMap
import trap_UpdateScreen
import trap_SendClientCommand
import trap_AddCommand
import trap_SendConsoleCommand
import trap_FS_Seek
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_FS_FOpenFile
import trap_Args
import trap_Argv
import trap_Argc
import trap_Cvar_VariableStringBuffer
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_Milliseconds
import trap_Error
import trap_Print
import CG_RunPlayListFrame
import CG_ResetPlayList
import CG_ContinuePlayList
import CG_StopPlayList
import CG_ParsePlayList
import CG_InitPlayList
import CG_TSS_CheckMouseEvents
import CG_TSS_CheckKeyEvents
import CG_TSS_MouseEvent
import CG_TSS_KeyEvent
import CG_TSS_CloseInterface
import CG_TSS_OpenInterface
import CG_TSS_DrawInterface
import CG_TSS_SPrintTacticalMeasure
import CG_TSS_Update
import CG_TSS_SaveInterface
import CG_TSS_LoadInterface
import CG_TSS_InitInterface
import TSS_SetPalette
import TSS_GetPalette
import CG_TSS_StrategyNameChanged
import CG_TSS_SetSearchPattern
import CG_TSS_CreateNewStrategy
import CG_TSS_FreePaletteSlot
import CG_TSS_SavePaletteSlotIfNeeded
import CG_TSS_LoadPaletteSlot
import CG_TSS_GetSortIndexByID
import CG_TSS_GetSortedSlot
import CG_TSS_GetSlotByName
import CG_TSS_GetSlotByID
import CG_TSS_NumStrategiesInStock
import TSSFS_SaveStrategyStock
import TSSFS_LoadStrategyStock
import TSSFS_LoadStrategy
import TSSFS_SaveStrategy
import CG_CheckChangedPredictableEvents
import CG_TransitionPlayerState
import CG_Respawn
import CG_PlayBufferedVoiceChats
import CG_VoiceChatLocal
import CG_ShaderStateChanged
import CG_LoadVoiceChats
import CG_SetConfigValues
import CG_ParseServerinfo
import CG_ExecuteNewServerCommands
import CG_InitConsoleCommands
import CG_ConsoleCommand
import CG_DrawOldTourneyScoreboard
import CG_DrawOldScoreboard
import CG_DrawInformation
import CG_LoadingClient
import CG_LoadingItem
import CG_LoadingString
import CG_ProcessSnapshots
import CG_MakeExplosion
import CG_Bleed
import CG_BigExplode
import CG_BFGsuperExpl
import CG_GibPlayer
import CG_ScorePlum
import CG_SpawnEffect
import CG_BubbleTrail
import CG_SmokePuff
import CG_AdjustLocalEntities
import CG_AddLocalEntities
import CG_AllocLocalEntity
import CG_InitLocalEntities
import CG_DrawLightBlobs
import CG_CheckStrongLight
import CG_AddLightningMarks
import CG_AddNearbox
import CG_ImpactMark
import CG_AddMarks
import CG_InitMarkPolys
import CG_OutOfAmmoChange
import CG_DrawWeaponSelect
import CG_AddPlayerWeapon
import CG_AddViewWeapon
import CG_GrappleTrail
import CG_RailTrail
import CG_Draw3DLine
import CG_Bullet
import CG_ShotgunFire
import CG_MissileHitPlayer
import CG_MissileHitWall
import CG_FireWeapon
import CG_RegisterItemVisuals
import CG_RegisterWeapon
import CG_Weapon_f
import CG_PrevWeapon_f
import CG_NextWeapon_f
import CG_PrevWeaponOrder_f
import CG_NextWeaponOrder_f
import CG_SkipWeapon_f
import CG_BestWeapon_f
import CG_AutoSwitchToBestWeapon
import CG_CalcEntityLerpPositions
import CG_Mover
import CG_AddPacketEntitiesForGlassLook
import CG_PositionRotatedEntityOnTag
import CG_PositionEntityOnTag
import CG_AdjustPositionForMover
import CG_DrawLineSegment
import CG_Beam
import CG_AddPacketEntities
import CG_SetEntitySoundPosition
import CG_PainEvent
import CG_EntityEvent
import CG_PlaceString
import CG_CheckEvents
import CG_LoadDeferredPlayers
import CG_PredictPlayerState
import CG_SmoothTrace
import CG_Trace
import CG_PointContents
import CG_BuildSolidList
import CG_GetSpawnEffectParameters
import CG_InitMonsterClientInfo
import CG_CustomSound
import CG_NewClientInfo
import CG_AddRefEntityWithPowerups
import CG_ResetPlayerEntity
import CG_Player
import AddDischargeFlash
import CG_StatusHandle
import CG_OtherTeamHasFlag
import CG_YourTeamHasFlag
import CG_GameTypeString
import CG_CheckOrderPending
import CG_Text_PaintChar
import CG_GetKillerText
import CG_GetGameStatusText
import CG_GetTeamColor
import CG_InitTeamChat
import CG_SetPrintString
import CG_ShowResponseHead
import CG_RunMenuScript
import CG_OwnerDrawVisible
import CG_GetValue
import CG_SelectNextPlayer
import CG_SelectPrevPlayer
import CG_Text_Height
import CG_Text_Width
import CG_Text_Paint
import CG_OwnerDraw
export teamChat2
align 1
LABELV teamChat2
skip 256
export teamChat1
align 1
LABELV teamChat1
skip 256
export systemChat
align 1
LABELV systemChat
skip 256
export numSortedTeamPlayers
align 4
LABELV numSortedTeamPlayers
skip 4
export sortedTeamPlayers
align 4
LABELV sortedTeamPlayers
skip 128
import CG_DrawTopBottom
import CG_DrawSides
import CG_DrawRect
import UI_DrawProportionalString
import CG_GetColorForHealth
import CG_ColorForHealth
import CG_TileClear
import CG_TeamColor
import CG_FadeColor
import CG_DrawStrlen
import CG_DrawSmallStringColor
import CG_DrawSmallString
import CG_DrawBigStringColor
import CG_DrawBigString
import CG_DrawStringExt
import CG_DrawString
import CG_DrawPic
import CG_FillRect
import CG_AdjustFrom640
import CG_GetScreenCoordinates
import CG_AddLFEditorCursor
import CG_AdjustEarthquakes
import CG_AddEarthquake
import CG_DrawActiveFrame
import CG_AddBufferedSound
import CG_ZoomUp_f
import CG_ZoomDown_f
import CG_TestModelPrevSkin_f
import CG_TestModelNextSkin_f
import CG_TestModelPrevFrame_f
import CG_TestModelNextFrame_f
import CG_TestGun_f
import CG_TestModel_f
import CG_LoadLensFlareEntities
import CG_ComputeMaxVisAngle
import CG_LoadLensFlares
import CG_SelectLFEnt
import CG_SetLFEdMoveMode
import CG_SetLFEntOrigin
import CG_LFEntOrigin
import CG_BuildSpectatorString
import CG_GetSelectedScore
import CG_SetScoreSelection
import CG_RankRunFrame
import CG_EventHandling
import CG_MouseEvent
import CG_KeyEvent
import CG_LoadMenus
import CG_LastAttacker
import CG_CrosshairPlayer
import CG_UpdateCvars
import CG_StartMusic
import CG_Error
import CG_Printf
import CG_Argv
import CG_ConfigString
import cg_music
import cg_autoGLC
import cg_nearbox
import cg_BFGsuperExpl
import cg_missileFlare
import cg_sunFlare
import cg_mapFlare
import cg_lensFlare
import cg_glassCloaking
import cg_trueLightning
import cg_oldPlasma
import cg_oldRocket
import cg_oldRail
import cg_noProjectileTrail
import cg_noTaunt
import cg_bigFont
import cg_smallFont
import cg_cameraMode
import cg_timescale
import cg_timescaleFadeSpeed
import cg_timescaleFadeEnd
import cg_cameraOrbitDelay
import cg_cameraOrbit
import pmove_msec
import pmove_fixed
import cg_smoothClients
import cg_scorePlum
import cg_noVoiceText
import cg_noVoiceChats
import cg_teamChatsOnly
import cg_drawFriend
import cg_deferPlayers
import cg_predictItems
import cg_blood
import cg_paused
import cg_buildScript
import cg_forceModel
import cg_stats
import cg_teamChatHeight
import cg_teamChatTime
import cg_synchronousClients
import cg_drawAttacker
import cg_lagometer
import cg_stereoSeparation
import cg_thirdPerson
import cg_thirdPersonAngle
import cg_thirdPersonRange
import cg_zoomFov
import cg_fov
import cg_simpleItems
import cg_noTrace
import cg_tssiKey
import cg_tssiMouse
import cg_drawSegment
import cg_fireballTrail
import cg_drawNumMonsters
import cg_ignore
import cg_weaponOrderName
import cg_weaponOrder
import cg_autoswitchAmmoLimit
import cg_autoswitch
import cg_tracerLength
import cg_tracerWidth
import cg_tracerChance
import cg_viewsize
import cg_drawGun
import cg_gun_z
import cg_gun_y
import cg_gun_x
import cg_gun_frame
import cg_brassTime
import cg_addMarks
import cg_footsteps
import cg_showmiss
import cg_noPlayerAnims
import cg_nopredict
import cg_errorDecay
import cg_railTrailTime
import cg_debugEvents
import cg_debugPosition
import cg_debugAnim
import cg_animSpeed
import cg_draw2D
import cg_drawStatus
import cg_crosshairHealth
import cg_crosshairSize
import cg_crosshairY
import cg_crosshairX
import cg_teamOverlayUserinfo
import cg_drawTeamOverlay
import cg_drawRewards
import cg_drawCrosshairNames
import cg_drawCrosshair
import cg_drawAmmoWarning
import cg_drawIcons
import cg_draw3dIcons
import cg_drawSnapshot
import cg_drawFPS
import cg_drawTimer
import cg_gibs
import cg_shadows
import cg_swingSpeed
import cg_bobroll
import cg_bobpitch
import cg_bobup
import cg_runroll
import cg_runpitch
import cg_centertime
import cg_markPolys
import cg_items
import cg_weapons
import cg_entities
import cg
import cgs
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
LABELV $2314
byte 1 116
byte 1 115
byte 1 115
byte 1 105
byte 1 110
byte 1 115
byte 1 116
byte 1 114
byte 1 117
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 115
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 0
align 1
LABELV $2299
byte 1 103
byte 1 114
byte 1 111
byte 1 117
byte 1 112
byte 1 102
byte 1 111
byte 1 114
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 102
byte 1 114
byte 1 101
byte 1 101
byte 1 0
align 1
LABELV $2297
byte 1 103
byte 1 114
byte 1 111
byte 1 117
byte 1 112
byte 1 102
byte 1 111
byte 1 114
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 108
byte 1 111
byte 1 111
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $2295
byte 1 103
byte 1 114
byte 1 111
byte 1 117
byte 1 112
byte 1 102
byte 1 111
byte 1 114
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 116
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $2218
byte 1 67
byte 1 71
byte 1 95
byte 1 68
byte 1 114
byte 1 97
byte 1 119
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 101
byte 1 58
byte 1 32
byte 1 85
byte 1 110
byte 1 100
byte 1 101
byte 1 102
byte 1 105
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 101
byte 1 111
byte 1 86
byte 1 105
byte 1 101
byte 1 119
byte 1 0
align 1
LABELV $2060
byte 1 83
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 115
byte 1 32
byte 1 105
byte 1 110
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $2053
byte 1 67
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $2049
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 68
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
LABELV $2045
byte 1 70
byte 1 114
byte 1 101
byte 1 101
byte 1 32
byte 1 70
byte 1 111
byte 1 114
byte 1 32
byte 1 65
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $2039
byte 1 37
byte 1 115
byte 1 32
byte 1 118
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $2018
byte 1 87
byte 1 97
byte 1 105
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $2007
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $1987
byte 1 84
byte 1 69
byte 1 65
byte 1 77
byte 1 86
byte 1 79
byte 1 84
byte 1 69
byte 1 40
byte 1 37
byte 1 105
byte 1 41
byte 1 58
byte 1 37
byte 1 115
byte 1 32
byte 1 45
byte 1 32
byte 1 121
byte 1 101
byte 1 115
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 110
byte 1 111
byte 1 58
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $1980
byte 1 84
byte 1 69
byte 1 65
byte 1 77
byte 1 86
byte 1 79
byte 1 84
byte 1 69
byte 1 40
byte 1 37
byte 1 105
byte 1 41
byte 1 58
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 45
byte 1 32
byte 1 121
byte 1 101
byte 1 115
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 110
byte 1 111
byte 1 58
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $1978
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1944
byte 1 86
byte 1 79
byte 1 84
byte 1 69
byte 1 40
byte 1 37
byte 1 105
byte 1 41
byte 1 58
byte 1 37
byte 1 115
byte 1 32
byte 1 121
byte 1 101
byte 1 115
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 110
byte 1 111
byte 1 58
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $1929
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 32
byte 1 69
byte 1 83
byte 1 67
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 74
byte 1 79
byte 1 73
byte 1 78
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $1925
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $1921
byte 1 83
byte 1 80
byte 1 69
byte 1 67
byte 1 84
byte 1 65
byte 1 84
byte 1 79
byte 1 82
byte 1 0
align 1
LABELV $1919
byte 1 91
byte 1 65
byte 1 84
byte 1 84
byte 1 65
byte 1 67
byte 1 75
byte 1 93
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 105
byte 1 102
byte 1 121
byte 1 32
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 116
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 32
byte 1 40
byte 1 102
byte 1 43
byte 1 98
byte 1 41
byte 1 0
align 1
LABELV $1917
byte 1 91
byte 1 65
byte 1 84
byte 1 84
byte 1 65
byte 1 67
byte 1 75
byte 1 93
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 97
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 32
byte 1 38
byte 1 32
byte 1 108
byte 1 101
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 101
byte 1 100
byte 1 105
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $1916
byte 1 91
byte 1 65
byte 1 84
byte 1 84
byte 1 65
byte 1 67
byte 1 75
byte 1 93
byte 1 32
byte 1 114
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 38
byte 1 32
byte 1 108
byte 1 101
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 101
byte 1 100
byte 1 105
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $1909
byte 1 91
byte 1 65
byte 1 84
byte 1 84
byte 1 65
byte 1 67
byte 1 75
byte 1 93
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $1903
byte 1 91
byte 1 65
byte 1 84
byte 1 84
byte 1 65
byte 1 67
byte 1 75
byte 1 93
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 105
byte 1 102
byte 1 121
byte 1 32
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 116
byte 1 32
byte 1 40
byte 1 102
byte 1 43
byte 1 98
byte 1 41
byte 1 32
byte 1 111
byte 1 114
byte 1 32
byte 1 118
byte 1 105
byte 1 115
byte 1 32
byte 1 114
byte 1 97
byte 1 100
byte 1 105
byte 1 117
byte 1 115
byte 1 32
byte 1 40
byte 1 108
byte 1 43
byte 1 114
byte 1 41
byte 1 0
align 1
LABELV $1902
byte 1 91
byte 1 65
byte 1 84
byte 1 84
byte 1 65
byte 1 67
byte 1 75
byte 1 93
byte 1 32
byte 1 115
byte 1 119
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 116
byte 1 117
byte 1 110
byte 1 101
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $1896
byte 1 91
byte 1 65
byte 1 84
byte 1 84
byte 1 65
byte 1 67
byte 1 75
byte 1 93
byte 1 32
byte 1 97
byte 1 99
byte 1 99
byte 1 101
byte 1 112
byte 1 116
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $1889
byte 1 91
byte 1 65
byte 1 84
byte 1 84
byte 1 65
byte 1 67
byte 1 75
byte 1 93
byte 1 32
byte 1 115
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $1876
byte 1 91
byte 1 87
byte 1 65
byte 1 76
byte 1 75
byte 1 93
byte 1 32
byte 1 97
byte 1 108
byte 1 116
byte 1 101
byte 1 114
byte 1 110
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $1867
byte 1 91
byte 1 84
byte 1 65
byte 1 66
byte 1 93
byte 1 32
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 32
byte 1 61
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1862
byte 1 91
byte 1 49
byte 1 93
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $1853
byte 1 99
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $1852
byte 1 100
byte 1 117
byte 1 112
byte 1 108
byte 1 105
byte 1 99
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $1850
byte 1 91
byte 1 50
byte 1 93
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $1846
byte 1 115
byte 1 116
byte 1 111
byte 1 112
byte 1 0
align 1
LABELV $1845
byte 1 114
byte 1 101
byte 1 108
byte 1 101
byte 1 97
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $1842
byte 1 91
byte 1 50
byte 1 93
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $1830
byte 1 94
byte 1 49
byte 1 114
byte 1 101
byte 1 97
byte 1 108
byte 1 108
byte 1 121
byte 1 94
byte 1 55
byte 1 32
byte 1 0
align 1
LABELV $1827
byte 1 91
byte 1 51
byte 1 93
byte 1 32
byte 1 37
byte 1 115
byte 1 100
byte 1 101
byte 1 108
byte 1 101
byte 1 116
byte 1 101
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $1818
byte 1 40
byte 1 110
byte 1 101
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 98
byte 1 101
byte 1 32
byte 1 115
byte 1 116
byte 1 111
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 41
byte 1 0
align 1
LABELV $1815
byte 1 91
byte 1 51
byte 1 93
byte 1 32
byte 1 102
byte 1 105
byte 1 110
byte 1 100
byte 1 32
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1801
byte 1 91
byte 1 52
byte 1 93
byte 1 32
byte 1 37
byte 1 115
byte 1 101
byte 1 100
byte 1 105
byte 1 116
byte 1 32
byte 1 112
byte 1 111
byte 1 115
byte 1 105
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 38
byte 1 32
byte 1 118
byte 1 105
byte 1 115
byte 1 32
byte 1 114
byte 1 97
byte 1 100
byte 1 105
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $1795
byte 1 91
byte 1 52
byte 1 93
byte 1 32
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 115
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1794
byte 1 91
byte 1 52
byte 1 93
byte 1 32
byte 1 117
byte 1 110
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1774
byte 1 91
byte 1 53
byte 1 93
byte 1 32
byte 1 37
byte 1 115
byte 1 101
byte 1 100
byte 1 105
byte 1 116
byte 1 32
byte 1 115
byte 1 112
byte 1 111
byte 1 116
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $1770
byte 1 91
byte 1 53
byte 1 93
byte 1 32
byte 1 102
byte 1 105
byte 1 110
byte 1 100
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 117
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1758
byte 1 94
byte 1 51
byte 1 0
align 1
LABELV $1755
byte 1 91
byte 1 54
byte 1 93
byte 1 32
byte 1 37
byte 1 115
byte 1 101
byte 1 100
byte 1 105
byte 1 116
byte 1 32
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 32
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 32
byte 1 102
byte 1 43
byte 1 98
byte 1 32
byte 1 47
byte 1 32
byte 1 118
byte 1 105
byte 1 115
byte 1 32
byte 1 114
byte 1 97
byte 1 100
byte 1 105
byte 1 117
byte 1 115
byte 1 32
byte 1 108
byte 1 43
byte 1 114
byte 1 0
align 1
LABELV $1754
byte 1 91
byte 1 54
byte 1 93
byte 1 32
byte 1 112
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 32
byte 1 111
byte 1 112
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $1742
byte 1 91
byte 1 55
byte 1 93
byte 1 32
byte 1 97
byte 1 115
byte 1 115
byte 1 105
byte 1 103
byte 1 110
byte 1 32
byte 1 101
byte 1 102
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1737
byte 1 91
byte 1 55
byte 1 93
byte 1 32
byte 1 112
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 100
byte 1 97
byte 1 116
byte 1 97
byte 1 0
align 1
LABELV $1729
byte 1 91
byte 1 56
byte 1 93
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 101
byte 1 102
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1719
byte 1 91
byte 1 56
byte 1 93
byte 1 32
byte 1 99
byte 1 111
byte 1 112
byte 1 121
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 100
byte 1 97
byte 1 116
byte 1 97
byte 1 0
align 1
LABELV $1712
byte 1 91
byte 1 57
byte 1 93
byte 1 32
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 32
byte 1 61
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1705
byte 1 91
byte 1 57
byte 1 93
byte 1 32
byte 1 99
byte 1 117
byte 1 114
byte 1 115
byte 1 111
byte 1 114
byte 1 32
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 32
byte 1 61
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1688
byte 1 102
byte 1 105
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $1687
byte 1 99
byte 1 111
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $1685
byte 1 118
byte 1 105
byte 1 115
byte 1 32
byte 1 114
byte 1 97
byte 1 100
byte 1 105
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $1684
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 32
byte 1 114
byte 1 97
byte 1 100
byte 1 105
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $1683
byte 1 115
byte 1 109
byte 1 97
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $1681
byte 1 110
byte 1 111
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $1680
byte 1 109
byte 1 97
byte 1 114
byte 1 107
byte 1 115
byte 1 0
align 1
LABELV $1679
byte 1 110
byte 1 111
byte 1 114
byte 1 109
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $1670
byte 1 91
byte 1 49
byte 1 93
byte 1 32
byte 1 100
byte 1 111
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $1664
byte 1 91
byte 1 50
byte 1 93
byte 1 32
byte 1 112
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 32
byte 1 101
byte 1 102
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 61
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1658
byte 1 91
byte 1 51
byte 1 93
byte 1 32
byte 1 112
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 32
byte 1 118
byte 1 105
byte 1 115
byte 1 32
byte 1 114
byte 1 97
byte 1 100
byte 1 105
byte 1 117
byte 1 115
byte 1 32
byte 1 32
byte 1 32
byte 1 61
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1652
byte 1 91
byte 1 52
byte 1 93
byte 1 32
byte 1 112
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 32
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 32
byte 1 114
byte 1 97
byte 1 100
byte 1 105
byte 1 117
byte 1 115
byte 1 32
byte 1 61
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1646
byte 1 91
byte 1 53
byte 1 93
byte 1 32
byte 1 112
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 32
byte 1 100
byte 1 105
byte 1 114
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 61
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1642
byte 1 111
byte 1 102
byte 1 102
byte 1 0
align 1
LABELV $1641
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1638
byte 1 91
byte 1 54
byte 1 93
byte 1 32
byte 1 112
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 97
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 32
byte 1 61
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1479
byte 1 115
byte 1 110
byte 1 99
byte 1 0
align 1
LABELV $1414
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 101
byte 1 116
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1410
byte 1 67
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 73
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 114
byte 1 117
byte 1 112
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $1379
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $1247
byte 1 67
byte 1 111
byte 1 110
byte 1 100
byte 1 105
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 37
byte 1 99
byte 1 32
byte 1 37
byte 1 99
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1228
byte 1 0
align 1
LABELV $1227
byte 1 43
byte 1 0
align 1
LABELV $1226
byte 1 91
byte 1 37
byte 1 100
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 100
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 100
byte 1 37
byte 1 115
byte 1 93
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1225
byte 1 73
byte 1 78
byte 1 86
byte 1 65
byte 1 76
byte 1 73
byte 1 68
byte 1 32
byte 1 67
byte 1 79
byte 1 77
byte 1 77
byte 1 65
byte 1 78
byte 1 68
byte 1 0
align 1
LABELV $1224
byte 1 34
byte 1 71
byte 1 111
byte 1 33
byte 1 32
byte 1 71
byte 1 111
byte 1 33
byte 1 32
byte 1 71
byte 1 111
byte 1 33
byte 1 34
byte 1 0
align 1
LABELV $1222
byte 1 34
byte 1 83
byte 1 117
byte 1 112
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 32
byte 1 109
byte 1 101
byte 1 33
byte 1 34
byte 1 0
align 1
LABELV $1220
byte 1 34
byte 1 83
byte 1 116
byte 1 105
byte 1 99
byte 1 107
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 109
byte 1 101
byte 1 33
byte 1 34
byte 1 0
align 1
LABELV $1206
byte 1 65
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 32
byte 1 114
byte 1 101
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $1204
byte 1 71
byte 1 111
byte 1 33
byte 1 32
byte 1 71
byte 1 111
byte 1 33
byte 1 32
byte 1 71
byte 1 111
byte 1 33
byte 1 0
align 1
LABELV $1203
byte 1 70
byte 1 117
byte 1 108
byte 1 102
byte 1 105
byte 1 108
byte 1 32
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1194
byte 1 83
byte 1 101
byte 1 101
byte 1 107
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 110
byte 1 101
byte 1 97
byte 1 114
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1192
byte 1 77
byte 1 101
byte 1 101
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1190
byte 1 76
byte 1 101
byte 1 97
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $1189
byte 1 82
byte 1 117
byte 1 115
byte 1 104
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $1181
byte 1 80
byte 1 114
byte 1 111
byte 1 116
byte 1 101
byte 1 99
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 32
byte 1 99
byte 1 111
byte 1 115
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $1179
byte 1 80
byte 1 114
byte 1 111
byte 1 116
byte 1 101
byte 1 99
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1177
byte 1 82
byte 1 101
byte 1 116
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $1175
byte 1 83
byte 1 116
byte 1 105
byte 1 99
byte 1 107
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1173
byte 1 83
byte 1 117
byte 1 112
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1166
byte 1 63
byte 1 0
align 1
LABELV $1150
byte 1 79
byte 1 99
byte 1 99
byte 1 117
byte 1 112
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 66
byte 1 97
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $1148
byte 1 68
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 66
byte 1 97
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $1146
byte 1 68
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $1145
byte 1 82
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $1135
byte 1 67
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $1133
byte 1 83
byte 1 101
byte 1 101
byte 1 107
byte 1 32
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $1131
byte 1 83
byte 1 101
byte 1 101
byte 1 107
byte 1 32
byte 1 69
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 0
align 1
LABELV $1129
byte 1 63
byte 1 63
byte 1 63
byte 1 0
align 1
LABELV $1124
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $1123
byte 1 82
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $847
byte 1 37
byte 1 50
byte 1 105
byte 1 0
align 1
LABELV $840
byte 1 36
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $813
byte 1 37
byte 1 100
byte 1 46
byte 1 37
byte 1 48
byte 1 51
byte 1 100
byte 1 107
byte 1 109
byte 1 0
align 1
LABELV $751
byte 1 37
byte 1 105
byte 1 58
byte 1 37
byte 1 48
byte 1 50
byte 1 105
byte 1 0
align 1
LABELV $673
byte 1 108
byte 1 101
byte 1 110
byte 1 115
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 101
byte 1 100
byte 1 105
byte 1 116
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $634
byte 1 37
byte 1 51
byte 1 105
byte 1 32
byte 1 37
byte 1 51
byte 1 105
byte 1 0
align 1
LABELV $633
byte 1 37
byte 1 52
byte 1 105
byte 1 32
byte 1 37
byte 1 52
byte 1 105
byte 1 0
align 1
LABELV $624
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $618
byte 1 37
byte 1 100
byte 1 109
byte 1 0
align 1
LABELV $532
byte 1 37
byte 1 105
byte 1 58
byte 1 37
byte 1 105
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $527
byte 1 115
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 100
byte 1 47
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $517
byte 1 77
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $515
byte 1 37
byte 1 105
byte 1 102
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $499
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 115
byte 1 110
byte 1 97
byte 1 112
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 99
byte 1 109
byte 1 100
byte 1 58
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $497
byte 1 110
byte 1 0
align 1
LABELV $161
byte 1 37
byte 1 105
byte 1 0
