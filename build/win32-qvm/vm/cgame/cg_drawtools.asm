export CG_GetScreenCoordinates
code
proc CG_GetScreenCoordinates 40 4
file "..\..\..\..\code\cgame\cg_drawtools.c"
line 16
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_drawtools.c -- helper functions called by cg_draw, cg_scoreboard, cg_info, etc
;4:#include "cg_local.h"
;5:
;6:
;7:/*
;8:================
;9:JUHOX: CG_GetScreenCoordinates
;10:
;11:Coordinates are 640*480 virtual values
;12:Needs cg.refdef.vieworg, cg.refdef.viewaxis, and cg.refdef.fov_x/y set
;13:returns qfalse if origin is behind the player
;14:=================
;15:*/
;16:qboolean CG_GetScreenCoordinates(const vec3_t origin, float* x, float* y) {
line 21
;17:	vec3_t dir;
;18:	vec3_t projection;
;19:	float f;
;20:
;21:	VectorSubtract(origin, cg.refdef.vieworg, dir);
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
INDIRF4
ADDRGP4 cg+109260+24
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 28
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 cg+109260+24+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 cg+109260+24+8
INDIRF4
SUBF4
ASGNF4
line 22
;22:	projection[0] = DotProduct(dir, cg.refdef.viewaxis[0]);
ADDRLP4 12
ADDRLP4 0
INDIRF4
ADDRGP4 cg+109260+36
INDIRF4
MULF4
ADDRLP4 0+4
INDIRF4
ADDRGP4 cg+109260+36+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+8
INDIRF4
ADDRGP4 cg+109260+36+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 23
;23:	if (projection[0] < 1) return qfalse;
ADDRLP4 12
INDIRF4
CNSTF4 1065353216
GEF4 $145
CNSTI4 0
RETI4
ADDRGP4 $124
JUMPV
LABELV $145
line 24
;24:	projection[1] = DotProduct(dir, cg.refdef.viewaxis[1]);
ADDRLP4 12+4
ADDRLP4 0
INDIRF4
ADDRGP4 cg+109260+36+12
INDIRF4
MULF4
ADDRLP4 0+4
INDIRF4
ADDRGP4 cg+109260+36+12+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+8
INDIRF4
ADDRGP4 cg+109260+36+12+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 25
;25:	projection[2] = DotProduct(dir, cg.refdef.viewaxis[2]);
ADDRLP4 12+8
ADDRLP4 0
INDIRF4
ADDRGP4 cg+109260+36+24
INDIRF4
MULF4
ADDRLP4 0+4
INDIRF4
ADDRGP4 cg+109260+36+24+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+8
INDIRF4
ADDRGP4 cg+109260+36+24+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 27
;26:
;27:	f = 320.0 / tan(cg.refdef.fov_x * (M_PI / 360.0));
ADDRGP4 cg+109260+16
INDIRF4
CNSTF4 1007614517
MULF4
ARGF4
ADDRLP4 32
ADDRGP4 tan
CALLF4
ASGNF4
ADDRLP4 24
CNSTF4 1134559232
ADDRLP4 32
INDIRF4
DIVF4
ASGNF4
line 28
;28:	*x = 320.0 - f * projection[1] / projection[0];
ADDRFP4 4
INDIRP4
CNSTF4 1134559232
ADDRLP4 24
INDIRF4
ADDRLP4 12+4
INDIRF4
MULF4
ADDRLP4 12
INDIRF4
DIVF4
SUBF4
ASGNF4
line 30
;29:
;30:	f = 240.0 / tan(cg.refdef.fov_y * (M_PI / 360.0));
ADDRGP4 cg+109260+20
INDIRF4
CNSTF4 1007614517
MULF4
ARGF4
ADDRLP4 36
ADDRGP4 tan
CALLF4
ASGNF4
ADDRLP4 24
CNSTF4 1131413504
ADDRLP4 36
INDIRF4
DIVF4
ASGNF4
line 31
;31:	*y = 240.0 - f * projection[2] / projection[0];
ADDRFP4 8
INDIRP4
CNSTF4 1131413504
ADDRLP4 24
INDIRF4
ADDRLP4 12+8
INDIRF4
MULF4
ADDRLP4 12
INDIRF4
DIVF4
SUBF4
ASGNF4
line 33
;32:
;33:	return qtrue;
CNSTI4 1
RETI4
LABELV $124
endproc CG_GetScreenCoordinates 40 4
export CG_AdjustFrom640
proc CG_AdjustFrom640 16 0
line 44
;34:}
;35:
;36:
;37:/*
;38:================
;39:CG_AdjustFrom640
;40:
;41:Adjusted for resolution and screen aspect ratio
;42:================
;43:*/
;44:void CG_AdjustFrom640( float *x, float *y, float *w, float *h ) {
line 52
;45:#if 0
;46:	// adjust for wide screens
;47:	if ( cgs.glconfig.vidWidth * 480 > cgs.glconfig.vidHeight * 640 ) {
;48:		*x += 0.5 * ( cgs.glconfig.vidWidth - ( cgs.glconfig.vidHeight * 640 / 480 ) );
;49:	}
;50:#endif
;51:	// scale for screen sizes
;52:	*x *= cgs.screenXScale;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRGP4 cgs+31432
INDIRF4
MULF4
ASGNF4
line 53
;53:	*y *= cgs.screenYScale;
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRGP4 cgs+31436
INDIRF4
MULF4
ASGNF4
line 54
;54:	*w *= cgs.screenXScale;
ADDRLP4 8
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
ADDRGP4 cgs+31432
INDIRF4
MULF4
ASGNF4
line 55
;55:	*h *= cgs.screenYScale;
ADDRLP4 12
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
ADDRGP4 cgs+31436
INDIRF4
MULF4
ASGNF4
line 56
;56:}
LABELV $181
endproc CG_AdjustFrom640 16 0
export CG_FillRect
proc CG_FillRect 0 36
line 65
;57:
;58:/*
;59:================
;60:CG_FillRect
;61:
;62:Coordinates are 640*480 virtual values
;63:=================
;64:*/
;65:void CG_FillRect( float x, float y, float width, float height, const float *color ) {
line 66
;66:	trap_R_SetColor( color );
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 68
;67:
;68:	CG_AdjustFrom640( &x, &y, &width, &height );
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
line 69
;69:	trap_R_DrawStretchPic( x, y, width, height, 0, 0, 0, 0, cgs.media.whiteShader );
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
line 71
;70:
;71:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 72
;72:}
LABELV $186
endproc CG_FillRect 0 36
export CG_DrawSides
proc CG_DrawSides 4 36
line 81
;73:
;74:/*
;75:================
;76:CG_DrawSides
;77:
;78:Coords are virtual 640x480
;79:================
;80:*/
;81:void CG_DrawSides(float x, float y, float w, float h, float size) {
line 82
;82:	CG_AdjustFrom640( &x, &y, &w, &h );
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
line 83
;83:	size *= cgs.screenXScale;
ADDRFP4 16
ADDRFP4 16
INDIRF4
ADDRGP4 cgs+31432
INDIRF4
MULF4
ASGNF4
line 84
;84:	trap_R_DrawStretchPic( x, y, size, h, 0, 0, 0, 0, cgs.media.whiteShader );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 16
INDIRF4
ARGF4
ADDRFP4 12
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
line 85
;85:	trap_R_DrawStretchPic( x + w - size, y, size, h, 0, 0, 0, 0, cgs.media.whiteShader );
ADDRLP4 0
ADDRFP4 16
INDIRF4
ASGNF4
ADDRFP4 0
INDIRF4
ADDRFP4 8
INDIRF4
ADDF4
ADDRLP4 0
INDIRF4
SUBF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRFP4 12
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
line 86
;86:}
LABELV $189
endproc CG_DrawSides 4 36
export CG_DrawTopBottom
proc CG_DrawTopBottom 4 36
line 88
;87:
;88:void CG_DrawTopBottom(float x, float y, float w, float h, float size) {
line 89
;89:	CG_AdjustFrom640( &x, &y, &w, &h );
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
line 90
;90:	size *= cgs.screenYScale;
ADDRFP4 16
ADDRFP4 16
INDIRF4
ADDRGP4 cgs+31436
INDIRF4
MULF4
ASGNF4
line 91
;91:	trap_R_DrawStretchPic( x, y, w, size, 0, 0, 0, 0, cgs.media.whiteShader );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 16
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
line 92
;92:	trap_R_DrawStretchPic( x, y + h - size, w, size, 0, 0, 0, 0, cgs.media.whiteShader );
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 0
ADDRFP4 16
INDIRF4
ASGNF4
ADDRFP4 4
INDIRF4
ADDRFP4 12
INDIRF4
ADDF4
ADDRLP4 0
INDIRF4
SUBF4
ARGF4
ADDRFP4 8
INDIRF4
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
line 93
;93:}
LABELV $195
endproc CG_DrawTopBottom 4 36
export CG_DrawRect
proc CG_DrawRect 0 20
line 101
;94:/*
;95:================
;96:UI_DrawRect
;97:
;98:Coordinates are 640*480 virtual values
;99:=================
;100:*/
;101:void CG_DrawRect( float x, float y, float width, float height, float size, const float *color ) {
line 102
;102:	trap_R_SetColor( color );
ADDRFP4 20
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 104
;103:
;104:  CG_DrawTopBottom(x, y, width, height, size);
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
ADDRFP4 16
INDIRF4
ARGF4
ADDRGP4 CG_DrawTopBottom
CALLV
pop
line 105
;105:  CG_DrawSides(x, y, width, height, size);
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
ADDRFP4 16
INDIRF4
ARGF4
ADDRGP4 CG_DrawSides
CALLV
pop
line 107
;106:
;107:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 108
;108:}
LABELV $201
endproc CG_DrawRect 0 20
export CG_DrawPic
proc CG_DrawPic 0 36
line 119
;109:
;110:
;111:
;112:/*
;113:================
;114:CG_DrawPic
;115:
;116:Coordinates are 640*480 virtual values
;117:=================
;118:*/
;119:void CG_DrawPic( float x, float y, float width, float height, qhandle_t hShader ) {
line 120
;120:	CG_AdjustFrom640( &x, &y, &width, &height );
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
line 121
;121:	trap_R_DrawStretchPic( x, y, width, height, 0, 0, 1, 1, hShader );
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
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 122
;122:}
LABELV $202
endproc CG_DrawPic 0 36
export CG_DrawChar
proc CG_DrawChar 52 36
line 133
;123:
;124:
;125:
;126:/*
;127:===============
;128:CG_DrawChar
;129:
;130:Coordinates and size in 640*480 virtual screen size
;131:===============
;132:*/
;133:void CG_DrawChar( int x, int y, int width, int height, int ch ) {
line 139
;134:	int row, col;
;135:	float frow, fcol;
;136:	float size;
;137:	float	ax, ay, aw, ah;
;138:
;139:	ch &= 255;
ADDRFP4 16
ADDRFP4 16
INDIRI4
CNSTI4 255
BANDI4
ASGNI4
line 141
;140:
;141:	if ( ch == ' ' ) {
ADDRFP4 16
INDIRI4
CNSTI4 32
NEI4 $204
line 142
;142:		return;
ADDRGP4 $203
JUMPV
LABELV $204
line 145
;143:	}
;144:
;145:	ax = x;
ADDRLP4 12
ADDRFP4 0
INDIRI4
CVIF4 4
ASGNF4
line 146
;146:	ay = y;
ADDRLP4 16
ADDRFP4 4
INDIRI4
CVIF4 4
ASGNF4
line 147
;147:	aw = width;
ADDRLP4 20
ADDRFP4 8
INDIRI4
CVIF4 4
ASGNF4
line 148
;148:	ah = height;
ADDRLP4 0
ADDRFP4 12
INDIRI4
CVIF4 4
ASGNF4
line 149
;149:	CG_AdjustFrom640( &ax, &ay, &aw, &ah );
ADDRLP4 12
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_AdjustFrom640
CALLV
pop
line 165
;150:
;151:	// JUHOX: we've now more than one charsetShader
;152:#if 0
;153:	row = ch>>4;
;154:	col = ch&15;
;155:
;156:	frow = row*0.0625;
;157:	fcol = col*0.0625;
;158:	size = 0.0625;
;159:
;160:	trap_R_DrawStretchPic( ax, ay, aw, ah,
;161:					   fcol, frow, 
;162:					   fcol + size, frow + size, 
;163:					   cgs.media.charsetShader );
;164:#else
;165:	if (ah >= 12) {
ADDRLP4 0
INDIRF4
CNSTF4 1094713344
LTF4 $206
line 168
;166:		qhandle_t charsetShader;
;167:
;168:		charsetShader = cgs.media.charsetShaders[((ch&8)>>3) + ((ch&192)>>5)];
ADDRLP4 40
ADDRFP4 16
INDIRI4
ASGNI4
ADDRLP4 36
ADDRLP4 40
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 3
RSHI4
ADDRLP4 40
INDIRI4
CNSTI4 192
BANDI4
CNSTI4 5
RSHI4
ADDI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+751220+4
ADDP4
INDIRI4
ASGNI4
line 170
;169:
;170:		col = ch & 7;
ADDRLP4 28
ADDRFP4 16
INDIRI4
CNSTI4 7
BANDI4
ASGNI4
line 171
;171:		row = (ch & 48) >> 4;
ADDRLP4 24
ADDRFP4 16
INDIRI4
CNSTI4 48
BANDI4
CNSTI4 4
RSHI4
ASGNI4
line 173
;172:
;173:		fcol = col * 0.125 + 1.0/168.0;
ADDRLP4 8
ADDRLP4 28
INDIRI4
CVIF4 4
CNSTF4 1040187392
MULF4
CNSTF4 1002638385
ADDF4
ASGNF4
line 174
;174:		frow = row * 0.25 + 1.0/192.0;
ADDRLP4 4
ADDRLP4 24
INDIRI4
CVIF4 4
CNSTF4 1048576000
MULF4
CNSTF4 1001040555
ADDF4
ASGNF4
line 176
;175:
;176:		trap_R_DrawStretchPic(
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
CNSTF4 1040187392
ADDF4
CNSTF4 1011026993
SUBF4
ARGF4
ADDRLP4 4
INDIRF4
CNSTF4 1048576000
ADDF4
CNSTF4 1009429163
SUBF4
ARGF4
ADDRLP4 36
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 181
;177:			ax, ay, aw, ah,
;178:			fcol, frow, fcol+0.125-(2.0/168.0), frow+0.25-(2.0/192.0),
;179:			charsetShader
;180:		);
;181:	}
ADDRGP4 $207
JUMPV
LABELV $206
line 182
;182:	else {
line 183
;183:		if (ch >= 128) ch = '.';
ADDRFP4 16
INDIRI4
CNSTI4 128
LTI4 $210
ADDRFP4 16
CNSTI4 46
ASGNI4
LABELV $210
line 185
;184:
;185:		row = ch>>4;
ADDRLP4 24
ADDRFP4 16
INDIRI4
CNSTI4 4
RSHI4
ASGNI4
line 186
;186:		col = ch&15;
ADDRLP4 28
ADDRFP4 16
INDIRI4
CNSTI4 15
BANDI4
ASGNI4
line 188
;187:
;188:		frow = row*0.0625;
ADDRLP4 4
ADDRLP4 24
INDIRI4
CVIF4 4
CNSTF4 1031798784
MULF4
ASGNF4
line 189
;189:		fcol = col*0.0625;
ADDRLP4 8
ADDRLP4 28
INDIRI4
CVIF4 4
CNSTF4 1031798784
MULF4
ASGNF4
line 190
;190:		size = 0.0625;
ADDRLP4 32
CNSTF4 1031798784
ASGNF4
line 192
;191:
;192:		trap_R_DrawStretchPic(
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 44
ADDRLP4 32
INDIRF4
ASGNF4
ADDRLP4 8
INDIRF4
ADDRLP4 44
INDIRF4
ADDF4
ARGF4
ADDRLP4 4
INDIRF4
ADDRLP4 44
INDIRF4
ADDF4
ARGF4
ADDRGP4 cgs+751220
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 197
;193:			ax, ay, aw, ah,
;194:			fcol, frow, fcol + size, frow + size, 
;195:			cgs.media.oldCharsetShader
;196:		);
;197:	}
LABELV $207
line 199
;198:#endif
;199:}
LABELV $203
endproc CG_DrawChar 52 36
export CG_DrawStringExt
proc CG_DrawStringExt 36 20
line 213
;200:
;201:
;202:/*
;203:==================
;204:CG_DrawStringExt
;205:
;206:Draws a multi-colored string with a drop shadow, optionally forcing
;207:to a fixed color.
;208:
;209:Coordinates are at 640 by 480 virtual resolution
;210:==================
;211:*/
;212:void CG_DrawStringExt( int x, int y, const char *string, const float *setColor, 
;213:		qboolean forceColor, qboolean shadow, int charWidth, int charHeight, int maxChars ) {
line 219
;214:	vec4_t		color;
;215:	const char	*s;
;216:	int			xx;
;217:	int			cnt;
;218:
;219:	if (maxChars <= 0)
ADDRFP4 32
INDIRI4
CNSTI4 0
GTI4 $214
line 220
;220:		maxChars = 32767; // do them all!
ADDRFP4 32
CNSTI4 32767
ASGNI4
LABELV $214
line 223
;221:
;222:	// draw the drop shadow
;223:	if (shadow) {
ADDRFP4 20
INDIRI4
CNSTI4 0
EQI4 $216
line 224
;224:		color[0] = color[1] = color[2] = 0;
ADDRLP4 28
CNSTF4 0
ASGNF4
ADDRLP4 12+8
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 12
ADDRLP4 28
INDIRF4
ASGNF4
line 225
;225:		color[3] = setColor[3];
ADDRLP4 12+12
ADDRFP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 226
;226:		trap_R_SetColor( color );
ADDRLP4 12
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 227
;227:		s = string;
ADDRLP4 0
ADDRFP4 8
INDIRP4
ASGNP4
line 228
;228:		xx = x;
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
line 229
;229:		cnt = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $222
JUMPV
LABELV $221
line 230
;230:		while ( *s && cnt < maxChars) {
line 231
;231:			if ( Q_IsColorString( s ) ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $224
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $224
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $224
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 94
EQI4 $224
line 232
;232:				s += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 233
;233:				continue;
ADDRGP4 $222
JUMPV
LABELV $224
line 235
;234:			}
;235:			CG_DrawChar( xx + 2, y + 2, charWidth, charHeight, *s );
ADDRLP4 4
INDIRI4
CNSTI4 2
ADDI4
ARGI4
ADDRFP4 4
INDIRI4
CNSTI4 2
ADDI4
ARGI4
ADDRFP4 24
INDIRI4
ARGI4
ADDRFP4 28
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRGP4 CG_DrawChar
CALLV
pop
line 236
;236:			cnt++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 237
;237:			xx += charWidth;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRFP4 24
INDIRI4
ADDI4
ASGNI4
line 238
;238:			s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 239
;239:		}
LABELV $222
line 230
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $226
ADDRLP4 8
INDIRI4
ADDRFP4 32
INDIRI4
LTI4 $221
LABELV $226
line 240
;240:	}
LABELV $216
line 243
;241:
;242:	// draw the colored text
;243:	s = string;
ADDRLP4 0
ADDRFP4 8
INDIRP4
ASGNP4
line 244
;244:	xx = x;
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
line 245
;245:	cnt = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 246
;246:	trap_R_SetColor( setColor );
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
ADDRGP4 $228
JUMPV
LABELV $227
line 247
;247:	while ( *s && cnt < maxChars) {
line 248
;248:		if ( Q_IsColorString( s ) ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $230
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $230
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $230
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 94
EQI4 $230
line 249
;249:			if ( !forceColor ) {
ADDRFP4 16
INDIRI4
CNSTI4 0
NEI4 $232
line 250
;250:				memcpy( color, g_color_table[ColorIndex(*(s+1))], sizeof( color ) );
ADDRLP4 12
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 48
SUBI4
CNSTI4 7
BANDI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 251
;251:				color[3] = setColor[3];
ADDRLP4 12+12
ADDRFP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 252
;252:				trap_R_SetColor( color );
ADDRLP4 12
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 253
;253:			}
LABELV $232
line 254
;254:			s += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 255
;255:			continue;
ADDRGP4 $228
JUMPV
LABELV $230
line 257
;256:		}
;257:		CG_DrawChar( xx, y, charWidth, charHeight, *s );
ADDRLP4 4
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 24
INDIRI4
ARGI4
ADDRFP4 28
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRGP4 CG_DrawChar
CALLV
pop
line 258
;258:		xx += charWidth;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRFP4 24
INDIRI4
ADDI4
ASGNI4
line 259
;259:		cnt++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 260
;260:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 261
;261:	}
LABELV $228
line 247
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $235
ADDRLP4 8
INDIRI4
ADDRFP4 32
INDIRI4
LTI4 $227
LABELV $235
line 262
;262:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 263
;263:}
LABELV $213
endproc CG_DrawStringExt 36 20
export CG_DrawBigString
proc CG_DrawBigString 20 36
line 265
;264:
;265:void CG_DrawBigString( int x, int y, const char *s, float alpha ) {
line 268
;266:	float	color[4];
;267:
;268:	color[0] = color[1] = color[2] = 1.0;
ADDRLP4 16
CNSTF4 1065353216
ASGNF4
ADDRLP4 0+8
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 269
;269:	color[3] = alpha;
ADDRLP4 0+12
ADDRFP4 12
INDIRF4
ASGNF4
line 270
;270:	CG_DrawStringExt( x, y, s, color, qfalse, qtrue, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0 );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
CNSTI4 16
ARGI4
CNSTI4 16
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 271
;271:}
LABELV $236
endproc CG_DrawBigString 20 36
export CG_DrawBigStringColor
proc CG_DrawBigStringColor 0 36
line 273
;272:
;273:void CG_DrawBigStringColor( int x, int y, const char *s, vec4_t color ) {
line 274
;274:	CG_DrawStringExt( x, y, s, color, qtrue, qtrue, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0 );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
CNSTI4 1
ARGI4
CNSTI4 1
ARGI4
CNSTI4 16
ARGI4
CNSTI4 16
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 275
;275:}
LABELV $240
endproc CG_DrawBigStringColor 0 36
export CG_DrawSmallString
proc CG_DrawSmallString 20 36
line 277
;276:
;277:void CG_DrawSmallString( int x, int y, const char *s, float alpha ) {
line 280
;278:	float	color[4];
;279:
;280:	color[0] = color[1] = color[2] = 1.0;
ADDRLP4 16
CNSTF4 1065353216
ASGNF4
ADDRLP4 0+8
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 281
;281:	color[3] = alpha;
ADDRLP4 0+12
ADDRFP4 12
INDIRF4
ASGNF4
line 282
;282:	CG_DrawStringExt( x, y, s, color, qfalse, qfalse, SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0 );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
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
line 283
;283:}
LABELV $241
endproc CG_DrawSmallString 20 36
export CG_DrawSmallStringColor
proc CG_DrawSmallStringColor 0 36
line 285
;284:
;285:void CG_DrawSmallStringColor( int x, int y, const char *s, vec4_t color ) {
line 286
;286:	CG_DrawStringExt( x, y, s, color, qtrue, qfalse, SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0 );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
CNSTI4 1
ARGI4
CNSTI4 0
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
line 287
;287:}
LABELV $245
endproc CG_DrawSmallStringColor 0 36
export CG_DrawStrlen
proc CG_DrawStrlen 12 0
line 296
;288:
;289:/*
;290:=================
;291:CG_DrawStrlen
;292:
;293:Returns character count, skiping color escape codes
;294:=================
;295:*/
;296:int CG_DrawStrlen( const char *str ) {
line 297
;297:	const char *s = str;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 298
;298:	int count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $248
JUMPV
LABELV $247
line 300
;299:
;300:	while ( *s ) {
line 301
;301:		if ( Q_IsColorString( s ) ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $250
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $250
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $250
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 94
EQI4 $250
line 302
;302:			s += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 303
;303:		} else {
ADDRGP4 $251
JUMPV
LABELV $250
line 304
;304:			count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 305
;305:			s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 306
;306:		}
LABELV $251
line 307
;307:	}
LABELV $248
line 300
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $247
line 309
;308:
;309:	return count;
ADDRLP4 4
INDIRI4
RETI4
LABELV $246
endproc CG_DrawStrlen 12 0
proc CG_TileClearBox 16 36
line 320
;310:}
;311:
;312:/*
;313:=============
;314:CG_TileClearBox
;315:
;316:This repeats a 64*64 tile graphic to fill the screen around a sized down
;317:refresh window.
;318:=============
;319:*/
;320:static void CG_TileClearBox( int x, int y, int w, int h, qhandle_t hShader ) {
line 323
;321:	float	s1, t1, s2, t2;
;322:
;323:	s1 = x/64.0;
ADDRLP4 0
ADDRFP4 0
INDIRI4
CVIF4 4
CNSTF4 1015021568
MULF4
ASGNF4
line 324
;324:	t1 = y/64.0;
ADDRLP4 4
ADDRFP4 4
INDIRI4
CVIF4 4
CNSTF4 1015021568
MULF4
ASGNF4
line 325
;325:	s2 = (x+w)/64.0;
ADDRLP4 8
ADDRFP4 0
INDIRI4
ADDRFP4 8
INDIRI4
ADDI4
CVIF4 4
CNSTF4 1015021568
MULF4
ASGNF4
line 326
;326:	t2 = (y+h)/64.0;
ADDRLP4 12
ADDRFP4 4
INDIRI4
ADDRFP4 12
INDIRI4
ADDI4
CVIF4 4
CNSTF4 1015021568
MULF4
ASGNF4
line 327
;327:	trap_R_DrawStretchPic( x, y, w, h, s1, t1, s2, t2, hShader );
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
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 328
;328:}
LABELV $252
endproc CG_TileClearBox 16 36
export CG_TileClear
proc CG_TileClear 40 20
line 339
;329:
;330:
;331:
;332:/*
;333:==============
;334:CG_TileClear
;335:
;336:Clear around a sized down screen
;337:==============
;338:*/
;339:void CG_TileClear( void ) {
line 343
;340:	int		top, bottom, left, right;
;341:	int		w, h;
;342:
;343:	w = cgs.glconfig.vidWidth;
ADDRLP4 8
ADDRGP4 cgs+20100+11304
INDIRI4
ASGNI4
line 344
;344:	h = cgs.glconfig.vidHeight;
ADDRLP4 20
ADDRGP4 cgs+20100+11308
INDIRI4
ASGNI4
line 346
;345:
;346:	if ( cg.refdef.x == 0 && cg.refdef.y == 0 && 
ADDRGP4 cg+109260
INDIRI4
CNSTI4 0
NEI4 $258
ADDRGP4 cg+109260+4
INDIRI4
CNSTI4 0
NEI4 $258
ADDRGP4 cg+109260+8
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $258
ADDRGP4 cg+109260+12
INDIRI4
ADDRLP4 20
INDIRI4
NEI4 $258
line 347
;347:		cg.refdef.width == w && cg.refdef.height == h ) {
line 348
;348:		return;		// full screen rendering
ADDRGP4 $253
JUMPV
LABELV $258
line 351
;349:	}
;350:
;351:	top = cg.refdef.y;
ADDRLP4 0
ADDRGP4 cg+109260+4
INDIRI4
ASGNI4
line 352
;352:	bottom = top + cg.refdef.height-1;
ADDRLP4 4
ADDRLP4 0
INDIRI4
ADDRGP4 cg+109260+12
INDIRI4
ADDI4
CNSTI4 1
SUBI4
ASGNI4
line 353
;353:	left = cg.refdef.x;
ADDRLP4 12
ADDRGP4 cg+109260
INDIRI4
ASGNI4
line 354
;354:	right = left + cg.refdef.width-1;
ADDRLP4 16
ADDRLP4 12
INDIRI4
ADDRGP4 cg+109260+8
INDIRI4
ADDI4
CNSTI4 1
SUBI4
ASGNI4
line 357
;355:
;356:	// clear above view screen
;357:	CG_TileClearBox( 0, 0, w, top, cgs.media.backTileShader );
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 cgs+751220+436
INDIRI4
ARGI4
ADDRGP4 CG_TileClearBox
CALLV
pop
line 360
;358:
;359:	// clear below view screen
;360:	CG_TileClearBox( 0, bottom, w, h - bottom, cgs.media.backTileShader );
CNSTI4 0
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 20
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
ARGI4
ADDRGP4 cgs+751220+436
INDIRI4
ARGI4
ADDRGP4 CG_TileClearBox
CALLV
pop
line 363
;361:
;362:	// clear left of view screen
;363:	CG_TileClearBox( 0, top, left, bottom - top + 1, cgs.media.backTileShader );
CNSTI4 0
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 cgs+751220+436
INDIRI4
ARGI4
ADDRGP4 CG_TileClearBox
CALLV
pop
line 366
;364:
;365:	// clear right of view screen
;366:	CG_TileClearBox( right, top, w - right, bottom - top + 1, cgs.media.backTileShader );
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ADDRLP4 16
INDIRI4
SUBI4
ARGI4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 cgs+751220+436
INDIRI4
ARGI4
ADDRGP4 CG_TileClearBox
CALLV
pop
line 367
;367:}
LABELV $253
endproc CG_TileClear 40 20
bss
align 4
LABELV $283
skip 16
export CG_FadeColor
code
proc CG_FadeColor 8 0
line 376
;368:
;369:
;370:
;371:/*
;372:================
;373:CG_FadeColor
;374:================
;375:*/
;376:float *CG_FadeColor( int startMsec, int totalMsec ) {
line 380
;377:	static vec4_t		color;
;378:	int			t;
;379:
;380:	if ( startMsec == 0 ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $284
line 381
;381:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $282
JUMPV
LABELV $284
line 384
;382:	}
;383:
;384:	t = cg.time - startMsec;
ADDRLP4 0
ADDRGP4 cg+107656
INDIRI4
ADDRFP4 0
INDIRI4
SUBI4
ASGNI4
line 386
;385:
;386:	if ( t >= totalMsec ) {
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRI4
LTI4 $287
line 387
;387:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $282
JUMPV
LABELV $287
line 391
;388:	}
;389:
;390:	// fade out
;391:	if ( totalMsec - t < FADE_TIME ) {
ADDRFP4 4
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 200
GEI4 $289
line 392
;392:		color[3] = ( totalMsec - t ) * 1.0/FADE_TIME;
ADDRGP4 $283+12
ADDRFP4 4
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CVIF4 4
CNSTF4 1000593162
MULF4
ASGNF4
line 393
;393:	} else {
ADDRGP4 $290
JUMPV
LABELV $289
line 394
;394:		color[3] = 1.0;
ADDRGP4 $283+12
CNSTF4 1065353216
ASGNF4
line 395
;395:	}
LABELV $290
line 396
;396:	color[0] = color[1] = color[2] = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
ADDRGP4 $283+8
ADDRLP4 4
INDIRF4
ASGNF4
ADDRGP4 $283+4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRGP4 $283
ADDRLP4 4
INDIRF4
ASGNF4
line 398
;397:
;398:	return color;
ADDRGP4 $283
RETP4
LABELV $282
endproc CG_FadeColor 8 0
data
align 4
LABELV $296
byte 4 1065353216
byte 4 1045220557
byte 4 1045220557
byte 4 1065353216
align 4
LABELV $297
byte 4 1045220557
byte 4 1045220557
byte 4 1065353216
byte 4 1065353216
align 4
LABELV $298
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
align 4
LABELV $299
byte 4 1060320051
byte 4 1060320051
byte 4 1060320051
byte 4 1065353216
export CG_TeamColor
code
proc CG_TeamColor 4 0
line 407
;399:}
;400:
;401:
;402:/*
;403:================
;404:CG_TeamColor
;405:================
;406:*/
;407:float *CG_TeamColor( int team ) {
line 413
;408:	static vec4_t	red = {1, 0.2f, 0.2f, 1};
;409:	static vec4_t	blue = {0.2f, 0.2f, 1, 1};
;410:	static vec4_t	other = {1, 1, 1, 1};
;411:	static vec4_t	spectator = {0.7f, 0.7f, 0.7f, 1};
;412:
;413:	switch ( team ) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $302
ADDRLP4 0
INDIRI4
CNSTI4 2
EQI4 $303
ADDRLP4 0
INDIRI4
CNSTI4 3
EQI4 $304
ADDRGP4 $300
JUMPV
LABELV $302
line 415
;414:	case TEAM_RED:
;415:		return red;
ADDRGP4 $296
RETP4
ADDRGP4 $295
JUMPV
LABELV $303
line 417
;416:	case TEAM_BLUE:
;417:		return blue;
ADDRGP4 $297
RETP4
ADDRGP4 $295
JUMPV
LABELV $304
line 419
;418:	case TEAM_SPECTATOR:
;419:		return spectator;
ADDRGP4 $299
RETP4
ADDRGP4 $295
JUMPV
LABELV $300
line 421
;420:	default:
;421:		return other;
ADDRGP4 $298
RETP4
LABELV $295
endproc CG_TeamColor 4 0
export CG_GetColorForHealth
proc CG_GetColorForHealth 16 0
line 436
;422:	}
;423:}
;424:
;425:
;426:
;427:/*
;428:=================
;429:CG_GetColorForHealth
;430:=================
;431:*/
;432:// JUHOX: new parameter for CG_GetColorForHealth()
;433:#if 0
;434:void CG_GetColorForHealth( int health, int armor, vec4_t hcolor ) {
;435:#else
;436:void CG_GetColorForHealth(int health, int armor, int maxhealth, vec4_t hcolor) {
line 443
;437:#endif
;438:	int		count;
;439:	int		max;
;440:
;441:	// calculate the total points of damage that can
;442:	// be sustained at the current health / armor level
;443:	if ( health <= 0 ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
GTI4 $306
line 444
;444:		VectorClear( hcolor );	// black
ADDRLP4 8
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 12
CNSTF4 0
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 8
INDIRP4
ADDRLP4 12
INDIRF4
ASGNF4
line 445
;445:		hcolor[3] = 1;
ADDRFP4 12
INDIRP4
CNSTI4 12
ADDP4
CNSTF4 1065353216
ASGNF4
line 446
;446:		return;
ADDRGP4 $305
JUMPV
LABELV $306
line 448
;447:	}
;448:	count = armor;
ADDRLP4 0
ADDRFP4 4
INDIRI4
ASGNI4
line 449
;449:	max = health * ARMOR_PROTECTION / ( 1.0 - ARMOR_PROTECTION );
ADDRLP4 4
ADDRFP4 0
INDIRI4
CVIF4 4
CNSTF4 1073248376
MULF4
CVFI4 4
ASGNI4
line 450
;450:	if ( max < count ) {
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
GEI4 $308
line 451
;451:		count = max;
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 452
;452:	}
LABELV $308
line 453
;453:	health += count;
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 457
;454:
;455:	// JUHOX: normalize health to 100
;456:#if 1
;457:	if (maxhealth < 1) maxhealth = 1;
ADDRFP4 8
INDIRI4
CNSTI4 1
GEI4 $310
ADDRFP4 8
CNSTI4 1
ASGNI4
LABELV $310
line 458
;458:	health = (100 * health) / maxhealth;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRFP4 8
INDIRI4
DIVI4
ASGNI4
line 462
;459:#endif
;460:
;461:	// set the color based on health
;462:	hcolor[0] = 1.0;
ADDRFP4 12
INDIRP4
CNSTF4 1065353216
ASGNF4
line 463
;463:	hcolor[3] = 1.0;
ADDRFP4 12
INDIRP4
CNSTI4 12
ADDP4
CNSTF4 1065353216
ASGNF4
line 464
;464:	if ( health >= 100 ) {
ADDRFP4 0
INDIRI4
CNSTI4 100
LTI4 $312
line 465
;465:		hcolor[2] = 1.0;
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 1065353216
ASGNF4
line 466
;466:	} else if ( health < 66 ) {
ADDRGP4 $313
JUMPV
LABELV $312
ADDRFP4 0
INDIRI4
CNSTI4 66
GEI4 $314
line 467
;467:		hcolor[2] = 0;
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 0
ASGNF4
line 468
;468:	} else {
ADDRGP4 $315
JUMPV
LABELV $314
line 469
;469:		hcolor[2] = ( health - 66 ) / 33.0;
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
ADDRFP4 0
INDIRI4
CNSTI4 66
SUBI4
CVIF4 4
CNSTF4 1022901776
MULF4
ASGNF4
line 470
;470:	}
LABELV $315
LABELV $313
line 472
;471:
;472:	if ( health > 60 ) {
ADDRFP4 0
INDIRI4
CNSTI4 60
LEI4 $316
line 473
;473:		hcolor[1] = 1.0;
ADDRFP4 12
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 1065353216
ASGNF4
line 474
;474:	} else if ( health < 30 ) {
ADDRGP4 $317
JUMPV
LABELV $316
ADDRFP4 0
INDIRI4
CNSTI4 30
GEI4 $318
line 475
;475:		hcolor[1] = 0;
ADDRFP4 12
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 0
ASGNF4
line 476
;476:	} else {
ADDRGP4 $319
JUMPV
LABELV $318
line 477
;477:		hcolor[1] = ( health - 30 ) / 30.0;
ADDRFP4 12
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 0
INDIRI4
CNSTI4 30
SUBI4
CVIF4 4
CNSTF4 1023969417
MULF4
ASGNF4
line 478
;478:	}
LABELV $319
LABELV $317
line 479
;479:}
LABELV $305
endproc CG_GetColorForHealth 16 0
export CG_ColorForHealth
proc CG_ColorForHealth 0 16
line 486
;480:
;481:/*
;482:=================
;483:CG_ColorForHealth
;484:=================
;485:*/
;486:void CG_ColorForHealth( vec4_t hcolor ) {
line 493
;487:
;488:	// JUHOX: include new parameter for CG_GetColorForHealth()
;489:#if 0
;490:	CG_GetColorForHealth( cg.snap->ps.stats[STAT_HEALTH], 
;491:		cg.snap->ps.stats[STAT_ARMOR], hcolor );
;492:#else
;493:	CG_GetColorForHealth(
ADDRGP4 cg+36
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_GetColorForHealth
CALLV
pop
line 500
;494:		cg.snap->ps.stats[STAT_HEALTH], 
;495:		cg.snap->ps.stats[STAT_ARMOR],
;496:		cg.snap->ps.stats[STAT_MAX_HEALTH],
;497:		hcolor
;498:	);
;499:#endif
;500:}
LABELV $320
endproc CG_ColorForHealth 0 16
data
align 4
LABELV propMap
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 8
byte 4 11
byte 4 122
byte 4 7
byte 4 154
byte 4 181
byte 4 14
byte 4 55
byte 4 122
byte 4 17
byte 4 79
byte 4 122
byte 4 18
byte 4 101
byte 4 122
byte 4 23
byte 4 153
byte 4 122
byte 4 18
byte 4 9
byte 4 93
byte 4 7
byte 4 207
byte 4 122
byte 4 8
byte 4 230
byte 4 122
byte 4 9
byte 4 177
byte 4 122
byte 4 18
byte 4 30
byte 4 152
byte 4 18
byte 4 85
byte 4 181
byte 4 7
byte 4 34
byte 4 93
byte 4 11
byte 4 110
byte 4 181
byte 4 6
byte 4 130
byte 4 152
byte 4 14
byte 4 22
byte 4 64
byte 4 17
byte 4 41
byte 4 64
byte 4 12
byte 4 58
byte 4 64
byte 4 17
byte 4 78
byte 4 64
byte 4 18
byte 4 98
byte 4 64
byte 4 19
byte 4 120
byte 4 64
byte 4 18
byte 4 141
byte 4 64
byte 4 18
byte 4 204
byte 4 64
byte 4 16
byte 4 162
byte 4 64
byte 4 17
byte 4 182
byte 4 64
byte 4 18
byte 4 59
byte 4 181
byte 4 7
byte 4 35
byte 4 181
byte 4 7
byte 4 203
byte 4 152
byte 4 14
byte 4 56
byte 4 93
byte 4 14
byte 4 228
byte 4 152
byte 4 14
byte 4 177
byte 4 181
byte 4 18
byte 4 28
byte 4 122
byte 4 22
byte 4 5
byte 4 4
byte 4 18
byte 4 27
byte 4 4
byte 4 18
byte 4 48
byte 4 4
byte 4 18
byte 4 69
byte 4 4
byte 4 17
byte 4 90
byte 4 4
byte 4 13
byte 4 106
byte 4 4
byte 4 13
byte 4 121
byte 4 4
byte 4 18
byte 4 143
byte 4 4
byte 4 17
byte 4 164
byte 4 4
byte 4 8
byte 4 175
byte 4 4
byte 4 16
byte 4 195
byte 4 4
byte 4 18
byte 4 216
byte 4 4
byte 4 12
byte 4 230
byte 4 4
byte 4 23
byte 4 6
byte 4 34
byte 4 18
byte 4 27
byte 4 34
byte 4 18
byte 4 48
byte 4 34
byte 4 18
byte 4 68
byte 4 34
byte 4 18
byte 4 90
byte 4 34
byte 4 17
byte 4 110
byte 4 34
byte 4 18
byte 4 130
byte 4 34
byte 4 14
byte 4 146
byte 4 34
byte 4 18
byte 4 166
byte 4 34
byte 4 19
byte 4 185
byte 4 34
byte 4 29
byte 4 215
byte 4 34
byte 4 18
byte 4 234
byte 4 34
byte 4 18
byte 4 5
byte 4 64
byte 4 14
byte 4 60
byte 4 152
byte 4 7
byte 4 106
byte 4 151
byte 4 13
byte 4 83
byte 4 152
byte 4 7
byte 4 128
byte 4 122
byte 4 17
byte 4 4
byte 4 152
byte 4 21
byte 4 134
byte 4 181
byte 4 5
byte 4 5
byte 4 4
byte 4 18
byte 4 27
byte 4 4
byte 4 18
byte 4 48
byte 4 4
byte 4 18
byte 4 69
byte 4 4
byte 4 17
byte 4 90
byte 4 4
byte 4 13
byte 4 106
byte 4 4
byte 4 13
byte 4 121
byte 4 4
byte 4 18
byte 4 143
byte 4 4
byte 4 17
byte 4 164
byte 4 4
byte 4 8
byte 4 175
byte 4 4
byte 4 16
byte 4 195
byte 4 4
byte 4 18
byte 4 216
byte 4 4
byte 4 12
byte 4 230
byte 4 4
byte 4 23
byte 4 6
byte 4 34
byte 4 18
byte 4 27
byte 4 34
byte 4 18
byte 4 48
byte 4 34
byte 4 18
byte 4 68
byte 4 34
byte 4 18
byte 4 90
byte 4 34
byte 4 17
byte 4 110
byte 4 34
byte 4 18
byte 4 130
byte 4 34
byte 4 14
byte 4 146
byte 4 34
byte 4 18
byte 4 166
byte 4 34
byte 4 19
byte 4 185
byte 4 34
byte 4 29
byte 4 215
byte 4 34
byte 4 18
byte 4 234
byte 4 34
byte 4 18
byte 4 5
byte 4 64
byte 4 14
byte 4 153
byte 4 152
byte 4 13
byte 4 11
byte 4 181
byte 4 5
byte 4 180
byte 4 152
byte 4 13
byte 4 79
byte 4 93
byte 4 17
byte 4 0
byte 4 0
byte 4 -1
align 4
LABELV propMapB
byte 4 11
byte 4 12
byte 4 33
byte 4 49
byte 4 12
byte 4 31
byte 4 85
byte 4 12
byte 4 31
byte 4 120
byte 4 12
byte 4 30
byte 4 156
byte 4 12
byte 4 21
byte 4 183
byte 4 12
byte 4 21
byte 4 207
byte 4 12
byte 4 32
byte 4 13
byte 4 55
byte 4 30
byte 4 49
byte 4 55
byte 4 13
byte 4 66
byte 4 55
byte 4 29
byte 4 101
byte 4 55
byte 4 31
byte 4 135
byte 4 55
byte 4 21
byte 4 158
byte 4 55
byte 4 40
byte 4 204
byte 4 55
byte 4 32
byte 4 12
byte 4 97
byte 4 31
byte 4 48
byte 4 97
byte 4 31
byte 4 82
byte 4 97
byte 4 30
byte 4 118
byte 4 97
byte 4 30
byte 4 153
byte 4 97
byte 4 30
byte 4 185
byte 4 97
byte 4 25
byte 4 213
byte 4 97
byte 4 30
byte 4 11
byte 4 139
byte 4 32
byte 4 42
byte 4 139
byte 4 51
byte 4 93
byte 4 139
byte 4 32
byte 4 126
byte 4 139
byte 4 31
byte 4 158
byte 4 139
byte 4 25
code
proc UI_DrawBannerString2 52 36
line 666
;501:
;502:
;503:
;504:
;505:// bk001205 - code below duplicated in q3_ui/ui-atoms.c
;506:// bk001205 - FIXME: does this belong in ui_shared.c?
;507:// bk001205 - FIXME: HARD_LINKED flags not visible here
;508:#ifndef Q3_STATIC // bk001205 - q_shared defines not visible here 
;509:/*
;510:=================
;511:UI_DrawProportionalString2
;512:=================
;513:*/
;514:static int	propMap[128][3] = {
;515:{0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1},
;516:{0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1},
;517:
;518:{0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1},
;519:{0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1},
;520:
;521:{0, 0, PROP_SPACE_WIDTH},		// SPACE
;522:{11, 122, 7},	// !
;523:{154, 181, 14},	// "
;524:{55, 122, 17},	// #
;525:{79, 122, 18},	// $
;526:{101, 122, 23},	// %
;527:{153, 122, 18},	// &
;528:{9, 93, 7},		// '
;529:{207, 122, 8},	// (
;530:{230, 122, 9},	// )
;531:{177, 122, 18},	// *
;532:{30, 152, 18},	// +
;533:{85, 181, 7},	// ,
;534:{34, 93, 11},	// -
;535:{110, 181, 6},	// .
;536:{130, 152, 14},	// /
;537:
;538:{22, 64, 17},	// 0
;539:{41, 64, 12},	// 1
;540:{58, 64, 17},	// 2
;541:{78, 64, 18},	// 3
;542:{98, 64, 19},	// 4
;543:{120, 64, 18},	// 5
;544:{141, 64, 18},	// 6
;545:{204, 64, 16},	// 7
;546:{162, 64, 17},	// 8
;547:{182, 64, 18},	// 9
;548:{59, 181, 7},	// :
;549:{35,181, 7},	// ;
;550:{203, 152, 14},	// <
;551:{56, 93, 14},	// =
;552:{228, 152, 14},	// >
;553:{177, 181, 18},	// ?
;554:
;555:{28, 122, 22},	// @
;556:{5, 4, 18},		// A
;557:{27, 4, 18},	// B
;558:{48, 4, 18},	// C
;559:{69, 4, 17},	// D
;560:{90, 4, 13},	// E
;561:{106, 4, 13},	// F
;562:{121, 4, 18},	// G
;563:{143, 4, 17},	// H
;564:{164, 4, 8},	// I
;565:{175, 4, 16},	// J
;566:{195, 4, 18},	// K
;567:{216, 4, 12},	// L
;568:{230, 4, 23},	// M
;569:{6, 34, 18},	// N
;570:{27, 34, 18},	// O
;571:
;572:{48, 34, 18},	// P
;573:{68, 34, 18},	// Q
;574:{90, 34, 17},	// R
;575:{110, 34, 18},	// S
;576:{130, 34, 14},	// T
;577:{146, 34, 18},	// U
;578:{166, 34, 19},	// V
;579:{185, 34, 29},	// W
;580:{215, 34, 18},	// X
;581:{234, 34, 18},	// Y
;582:{5, 64, 14},	// Z
;583:{60, 152, 7},	// [
;584:{106, 151, 13},	// '\'
;585:{83, 152, 7},	// ]
;586:{128, 122, 17},	// ^
;587:{4, 152, 21},	// _
;588:
;589:{134, 181, 5},	// '
;590:{5, 4, 18},		// A
;591:{27, 4, 18},	// B
;592:{48, 4, 18},	// C
;593:{69, 4, 17},	// D
;594:{90, 4, 13},	// E
;595:{106, 4, 13},	// F
;596:{121, 4, 18},	// G
;597:{143, 4, 17},	// H
;598:{164, 4, 8},	// I
;599:{175, 4, 16},	// J
;600:{195, 4, 18},	// K
;601:{216, 4, 12},	// L
;602:{230, 4, 23},	// M
;603:{6, 34, 18},	// N
;604:{27, 34, 18},	// O
;605:
;606:{48, 34, 18},	// P
;607:{68, 34, 18},	// Q
;608:{90, 34, 17},	// R
;609:{110, 34, 18},	// S
;610:{130, 34, 14},	// T
;611:{146, 34, 18},	// U
;612:{166, 34, 19},	// V
;613:{185, 34, 29},	// W
;614:{215, 34, 18},	// X
;615:{234, 34, 18},	// Y
;616:{5, 64, 14},	// Z
;617:{153, 152, 13},	// {
;618:{11, 181, 5},	// |
;619:{180, 152, 13},	// }
;620:{79, 93, 17},	// ~
;621:{0, 0, -1}		// DEL
;622:};
;623:
;624:static int propMapB[26][3] = {
;625:{11, 12, 33},
;626:{49, 12, 31},
;627:{85, 12, 31},
;628:{120, 12, 30},
;629:{156, 12, 21},
;630:{183, 12, 21},
;631:{207, 12, 32},
;632:
;633:{13, 55, 30},
;634:{49, 55, 13},
;635:{66, 55, 29},
;636:{101, 55, 31},
;637:{135, 55, 21},
;638:{158, 55, 40},
;639:{204, 55, 32},
;640:
;641:{12, 97, 31},
;642:{48, 97, 31},
;643:{82, 97, 30},
;644:{118, 97, 30},
;645:{153, 97, 30},
;646:{185, 97, 25},
;647:{213, 97, 30},
;648:
;649:{11, 139, 32},
;650:{42, 139, 51},
;651:{93, 139, 32},
;652:{126, 139, 31},
;653:{158, 139, 25},
;654:};
;655:
;656:#define PROPB_GAP_WIDTH		4
;657:#define PROPB_SPACE_WIDTH	12
;658:#define PROPB_HEIGHT		36
;659:
;660:/*
;661:=================
;662:UI_DrawBannerString
;663:=================
;664:*/
;665:static void UI_DrawBannerString2( int x, int y, const char* str, vec4_t color )
;666:{
line 679
;667:	const char* s;
;668:	unsigned char	ch; // bk001204 : array subscript
;669:	float	ax;
;670:	float	ay;
;671:	float	aw;
;672:	float	ah;
;673:	float	frow;
;674:	float	fcol;
;675:	float	fwidth;
;676:	float	fheight;
;677:
;678:	// draw the colored text
;679:	trap_R_SetColor( color );
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 681
;680:	
;681:	ax = x * cgs.screenXScale + cgs.screenXBias;
ADDRLP4 8
ADDRFP4 0
INDIRI4
CVIF4 4
ADDRGP4 cgs+31432
INDIRF4
MULF4
ADDRGP4 cgs+31440
INDIRF4
ADDF4
ASGNF4
line 682
;682:	ay = y * cgs.screenXScale;
ADDRLP4 36
ADDRFP4 4
INDIRI4
CVIF4 4
ADDRGP4 cgs+31432
INDIRF4
MULF4
ASGNF4
line 684
;683:
;684:	s = str;
ADDRLP4 4
ADDRFP4 8
INDIRP4
ASGNP4
ADDRGP4 $329
JUMPV
LABELV $328
line 686
;685:	while ( *s )
;686:	{
line 687
;687:		ch = *s & 127;
ADDRLP4 0
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 127
BANDI4
CVIU4 4
CVUU1 4
ASGNU1
line 688
;688:		if ( ch == ' ' ) {
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 32
NEI4 $331
line 689
;689:			ax += ((float)PROPB_SPACE_WIDTH + (float)PROPB_GAP_WIDTH)* cgs.screenXScale;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRGP4 cgs+31432
INDIRF4
CNSTF4 1098907648
MULF4
ADDF4
ASGNF4
line 690
;690:		}
ADDRGP4 $332
JUMPV
LABELV $331
line 691
;691:		else if ( ch >= 'A' && ch <= 'Z' ) {
ADDRLP4 40
ADDRLP4 0
INDIRU1
CVUI4 1
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 65
LTI4 $334
ADDRLP4 40
INDIRI4
CNSTI4 90
GTI4 $334
line 692
;692:			ch -= 'A';
ADDRLP4 0
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 65
SUBI4
CVIU4 4
CVUU1 4
ASGNU1
line 693
;693:			fcol = (float)propMapB[ch][0] / 256.0f;
ADDRLP4 20
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 12
MULI4
ADDRGP4 propMapB
ADDP4
INDIRI4
CVIF4 4
CNSTF4 998244352
MULF4
ASGNF4
line 694
;694:			frow = (float)propMapB[ch][1] / 256.0f;
ADDRLP4 16
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 12
MULI4
ADDRGP4 propMapB+4
ADDP4
INDIRI4
CVIF4 4
CNSTF4 998244352
MULF4
ASGNF4
line 695
;695:			fwidth = (float)propMapB[ch][2] / 256.0f;
ADDRLP4 28
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 12
MULI4
ADDRGP4 propMapB+8
ADDP4
INDIRI4
CVIF4 4
CNSTF4 998244352
MULF4
ASGNF4
line 696
;696:			fheight = (float)PROPB_HEIGHT / 256.0f;
ADDRLP4 32
CNSTF4 1041235968
ASGNF4
line 697
;697:			aw = (float)propMapB[ch][2] * cgs.screenXScale;
ADDRLP4 12
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 12
MULI4
ADDRGP4 propMapB+8
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 cgs+31432
INDIRF4
MULF4
ASGNF4
line 698
;698:			ah = (float)PROPB_HEIGHT * cgs.screenXScale;
ADDRLP4 24
ADDRGP4 cgs+31432
INDIRF4
CNSTF4 1108344832
MULF4
ASGNF4
line 699
;699:			trap_R_DrawStretchPic( ax, ay, aw, ah, fcol, frow, fcol+fwidth, frow+fheight, cgs.media.charsetPropB );
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ADDRLP4 28
INDIRF4
ADDF4
ARGF4
ADDRLP4 16
INDIRF4
ADDRLP4 32
INDIRF4
ADDF4
ARGF4
ADDRGP4 cgs+751220+44
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 700
;700:			ax += (aw + (float)PROPB_GAP_WIDTH * cgs.screenXScale);
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRLP4 12
INDIRF4
ADDRGP4 cgs+31432
INDIRF4
CNSTF4 1082130432
MULF4
ADDF4
ADDF4
ASGNF4
line 701
;701:		}
LABELV $334
LABELV $332
line 702
;702:		s++;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 703
;703:	}
LABELV $329
line 685
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $328
line 705
;704:
;705:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 706
;706:}
LABELV $324
endproc UI_DrawBannerString2 52 36
export UI_DrawBannerString
proc UI_DrawBannerString 40 16
line 708
;707:
;708:void UI_DrawBannerString( int x, int y, const char* str, int style, vec4_t color ) {
line 715
;709:	const char *	s;
;710:	int				ch;
;711:	int				width;
;712:	vec4_t			drawcolor;
;713:
;714:	// find the width of the drawn text
;715:	s = str;
ADDRLP4 4
ADDRFP4 8
INDIRP4
ASGNP4
line 716
;716:	width = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $346
JUMPV
LABELV $345
line 717
;717:	while ( *s ) {
line 718
;718:		ch = *s;
ADDRLP4 0
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 719
;719:		if ( ch == ' ' ) {
ADDRLP4 0
INDIRI4
CNSTI4 32
NEI4 $348
line 720
;720:			width += PROPB_SPACE_WIDTH;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 12
ADDI4
ASGNI4
line 721
;721:		}
ADDRGP4 $349
JUMPV
LABELV $348
line 722
;722:		else if ( ch >= 'A' && ch <= 'Z' ) {
ADDRLP4 0
INDIRI4
CNSTI4 65
LTI4 $350
ADDRLP4 0
INDIRI4
CNSTI4 90
GTI4 $350
line 723
;723:			width += propMapB[ch - 'A'][2] + PROPB_GAP_WIDTH;
ADDRLP4 8
ADDRLP4 8
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 propMapB-780+8
ADDP4
INDIRI4
CNSTI4 4
ADDI4
ADDI4
ASGNI4
line 724
;724:		}
LABELV $350
LABELV $349
line 725
;725:		s++;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 726
;726:	}
LABELV $346
line 717
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $345
line 727
;727:	width -= PROPB_GAP_WIDTH;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 4
SUBI4
ASGNI4
line 729
;728:
;729:	switch( style & UI_FORMATMASK ) {
ADDRLP4 28
ADDRFP4 12
INDIRI4
CNSTI4 7
BANDI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $355
ADDRLP4 28
INDIRI4
CNSTI4 1
EQI4 $357
ADDRLP4 28
INDIRI4
CNSTI4 2
EQI4 $358
ADDRGP4 $355
JUMPV
LABELV $357
line 731
;730:		case UI_CENTER:
;731:			x -= width / 2;
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRLP4 8
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ASGNI4
line 732
;732:			break;
ADDRGP4 $355
JUMPV
LABELV $358
line 735
;733:
;734:		case UI_RIGHT:
;735:			x -= width;
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ASGNI4
line 736
;736:			break;
line 740
;737:
;738:		case UI_LEFT:
;739:		default:
;740:			break;
LABELV $355
line 743
;741:	}
;742:
;743:	if ( style & UI_DROPSHADOW ) {
ADDRFP4 12
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $360
line 744
;744:		drawcolor[0] = drawcolor[1] = drawcolor[2] = 0;
ADDRLP4 36
CNSTF4 0
ASGNF4
ADDRLP4 12+8
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 12
ADDRLP4 36
INDIRF4
ASGNF4
line 745
;745:		drawcolor[3] = color[3];
ADDRLP4 12+12
ADDRFP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 746
;746:		UI_DrawBannerString2( x+2, y+2, str, drawcolor );
ADDRFP4 0
INDIRI4
CNSTI4 2
ADDI4
ARGI4
ADDRFP4 4
INDIRI4
CNSTI4 2
ADDI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 UI_DrawBannerString2
CALLV
pop
line 747
;747:	}
LABELV $360
line 749
;748:
;749:	UI_DrawBannerString2( x, y, str, color );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 UI_DrawBannerString2
CALLV
pop
line 750
;750:}
LABELV $344
endproc UI_DrawBannerString 40 16
export UI_ProportionalStringWidth
proc UI_ProportionalStringWidth 16 0
line 753
;751:
;752:
;753:int UI_ProportionalStringWidth( const char* str ) {
line 759
;754:	const char *	s;
;755:	int				ch;
;756:	int				charWidth;
;757:	int				width;
;758:
;759:	s = str;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 760
;760:	width = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 $367
JUMPV
LABELV $366
line 761
;761:	while ( *s ) {
line 762
;762:		ch = *s & 127;
ADDRLP4 8
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 127
BANDI4
ASGNI4
line 763
;763:		charWidth = propMap[ch][2];
ADDRLP4 4
ADDRLP4 8
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 propMap+8
ADDP4
INDIRI4
ASGNI4
line 764
;764:		if ( charWidth != -1 ) {
ADDRLP4 4
INDIRI4
CNSTI4 -1
EQI4 $370
line 765
;765:			width += charWidth;
ADDRLP4 12
ADDRLP4 12
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 766
;766:			width += PROP_GAP_WIDTH;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 3
ADDI4
ASGNI4
line 767
;767:		}
LABELV $370
line 768
;768:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 769
;769:	}
LABELV $367
line 761
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $366
line 771
;770:
;771:	width -= PROP_GAP_WIDTH;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 3
SUBI4
ASGNI4
line 772
;772:	return width;
ADDRLP4 12
INDIRI4
RETI4
LABELV $365
endproc UI_ProportionalStringWidth 16 0
proc UI_DrawProportionalString2 48 36
line 776
;773:}
;774:
;775:static void UI_DrawProportionalString2( int x, int y, const char* str, vec4_t color, float sizeScale, qhandle_t charset )
;776:{
line 789
;777:	const char* s;
;778:	unsigned char	ch; // bk001204 - unsigned
;779:	float	ax;
;780:	float	ay;
;781:	float	aw;
;782:	float	ah;
;783:	float	frow;
;784:	float	fcol;
;785:	float	fwidth;
;786:	float	fheight;
;787:
;788:	// draw the colored text
;789:	trap_R_SetColor( color );
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 791
;790:	
;791:	ax = x * cgs.screenXScale + cgs.screenXBias;
ADDRLP4 12
ADDRFP4 0
INDIRI4
CVIF4 4
ADDRGP4 cgs+31432
INDIRF4
MULF4
ADDRGP4 cgs+31440
INDIRF4
ADDF4
ASGNF4
line 792
;792:	ay = y * cgs.screenXScale;
ADDRLP4 36
ADDRFP4 4
INDIRI4
CVIF4 4
ADDRGP4 cgs+31432
INDIRF4
MULF4
ASGNF4
line 794
;793:
;794:	s = str;
ADDRLP4 4
ADDRFP4 8
INDIRP4
ASGNP4
ADDRGP4 $377
JUMPV
LABELV $376
line 796
;795:	while ( *s )
;796:	{
line 797
;797:		ch = *s & 127;
ADDRLP4 0
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 127
BANDI4
CVIU4 4
CVUU1 4
ASGNU1
line 798
;798:		if ( ch == ' ' ) {
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 32
NEI4 $379
line 799
;799:			aw = (float)PROP_SPACE_WIDTH * cgs.screenXScale * sizeScale;
ADDRLP4 8
ADDRGP4 cgs+31432
INDIRF4
CNSTF4 1090519040
MULF4
ADDRFP4 16
INDIRF4
MULF4
ASGNF4
line 800
;800:		} else if ( propMap[ch][2] != -1 ) {
ADDRGP4 $380
JUMPV
LABELV $379
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 12
MULI4
ADDRGP4 propMap+8
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $382
line 801
;801:			fcol = (float)propMap[ch][0] / 256.0f;
ADDRLP4 20
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 12
MULI4
ADDRGP4 propMap
ADDP4
INDIRI4
CVIF4 4
CNSTF4 998244352
MULF4
ASGNF4
line 802
;802:			frow = (float)propMap[ch][1] / 256.0f;
ADDRLP4 16
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 12
MULI4
ADDRGP4 propMap+4
ADDP4
INDIRI4
CVIF4 4
CNSTF4 998244352
MULF4
ASGNF4
line 803
;803:			fwidth = (float)propMap[ch][2] / 256.0f;
ADDRLP4 28
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 12
MULI4
ADDRGP4 propMap+8
ADDP4
INDIRI4
CVIF4 4
CNSTF4 998244352
MULF4
ASGNF4
line 804
;804:			fheight = (float)PROP_HEIGHT / 256.0f;
ADDRLP4 32
CNSTF4 1037565952
ASGNF4
line 805
;805:			aw = (float)propMap[ch][2] * cgs.screenXScale * sizeScale;
ADDRLP4 8
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 12
MULI4
ADDRGP4 propMap+8
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 cgs+31432
INDIRF4
MULF4
ADDRFP4 16
INDIRF4
MULF4
ASGNF4
line 806
;806:			ah = (float)PROP_HEIGHT * cgs.screenXScale * sizeScale;
ADDRLP4 24
ADDRGP4 cgs+31432
INDIRF4
CNSTF4 1104674816
MULF4
ADDRFP4 16
INDIRF4
MULF4
ASGNF4
line 807
;807:			trap_R_DrawStretchPic( ax, ay, aw, ah, fcol, frow, fcol+fwidth, frow+fheight, charset );
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ADDRLP4 28
INDIRF4
ADDF4
ARGF4
ADDRLP4 16
INDIRF4
ADDRLP4 32
INDIRF4
ADDF4
ARGF4
ADDRFP4 20
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 808
;808:		} else {
ADDRGP4 $383
JUMPV
LABELV $382
line 809
;809:			aw = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 810
;810:		}
LABELV $383
LABELV $380
line 812
;811:
;812:		ax += (aw + (float)PROP_GAP_WIDTH * cgs.screenXScale * sizeScale);
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
ADDRGP4 cgs+31432
INDIRF4
CNSTF4 1077936128
MULF4
ADDRFP4 16
INDIRF4
MULF4
ADDF4
ADDF4
ASGNF4
line 813
;813:		s++;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 814
;814:	}
LABELV $377
line 795
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $376
line 816
;815:
;816:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 817
;817:}
LABELV $372
endproc UI_DrawProportionalString2 48 36
export UI_ProportionalSizeScale
proc UI_ProportionalSizeScale 0 0
line 824
;818:
;819:/*
;820:=================
;821:UI_ProportionalSizeScale
;822:=================
;823:*/
;824:float UI_ProportionalSizeScale( int style ) {
line 825
;825:	if(  style & UI_SMALLFONT ) {
ADDRFP4 0
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $392
line 826
;826:		return 0.75;
CNSTF4 1061158912
RETF4
ADDRGP4 $391
JUMPV
LABELV $392
line 829
;827:	}
;828:
;829:	return 1.00;
CNSTF4 1065353216
RETF4
LABELV $391
endproc UI_ProportionalSizeScale 0 0
export UI_DrawProportionalString
proc UI_DrawProportionalString 44 24
line 838
;830:}
;831:
;832:
;833:/*
;834:=================
;835:UI_DrawProportionalString
;836:=================
;837:*/
;838:void UI_DrawProportionalString( int x, int y, const char* str, int style, vec4_t color ) {
line 843
;839:	vec4_t	drawcolor;
;840:	int		width;
;841:	float	sizeScale;
;842:
;843:	sizeScale = UI_ProportionalSizeScale( style );
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 UI_ProportionalSizeScale
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 24
INDIRF4
ASGNF4
line 845
;844:
;845:	switch( style & UI_FORMATMASK ) {
ADDRLP4 28
ADDRFP4 12
INDIRI4
CNSTI4 7
BANDI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $396
ADDRLP4 28
INDIRI4
CNSTI4 1
EQI4 $398
ADDRLP4 28
INDIRI4
CNSTI4 2
EQI4 $399
ADDRGP4 $396
JUMPV
LABELV $398
line 847
;846:		case UI_CENTER:
;847:			width = UI_ProportionalStringWidth( str ) * sizeScale;
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 UI_ProportionalStringWidth
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 36
INDIRI4
CVIF4 4
ADDRLP4 16
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 848
;848:			x -= width / 2;
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRLP4 20
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ASGNI4
line 849
;849:			break;
ADDRGP4 $396
JUMPV
LABELV $399
line 852
;850:
;851:		case UI_RIGHT:
;852:			width = UI_ProportionalStringWidth( str ) * sizeScale;
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 UI_ProportionalStringWidth
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 40
INDIRI4
CVIF4 4
ADDRLP4 16
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 853
;853:			x -= width;
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRLP4 20
INDIRI4
SUBI4
ASGNI4
line 854
;854:			break;
line 858
;855:
;856:		case UI_LEFT:
;857:		default:
;858:			break;
LABELV $396
line 861
;859:	}
;860:
;861:	if ( style & UI_DROPSHADOW ) {
ADDRFP4 12
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $401
line 862
;862:		drawcolor[0] = drawcolor[1] = drawcolor[2] = 0;
ADDRLP4 36
CNSTF4 0
ASGNF4
ADDRLP4 0+8
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 36
INDIRF4
ASGNF4
line 863
;863:		drawcolor[3] = color[3];
ADDRLP4 0+12
ADDRFP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 864
;864:		UI_DrawProportionalString2( x+2, y+2, str, drawcolor, sizeScale, cgs.media.charsetProp );
ADDRFP4 0
INDIRI4
CNSTI4 2
ADDI4
ARGI4
ADDRFP4 4
INDIRI4
CNSTI4 2
ADDI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 16
INDIRF4
ARGF4
ADDRGP4 cgs+751220+36
INDIRI4
ARGI4
ADDRGP4 UI_DrawProportionalString2
CALLV
pop
line 865
;865:	}
LABELV $401
line 867
;866:
;867:	if ( style & UI_INVERSE ) {
ADDRFP4 12
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $408
line 868
;868:		drawcolor[0] = color[0] * 0.8;
ADDRLP4 0
ADDRFP4 16
INDIRP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 869
;869:		drawcolor[1] = color[1] * 0.8;
ADDRLP4 0+4
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 870
;870:		drawcolor[2] = color[2] * 0.8;
ADDRLP4 0+8
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 871
;871:		drawcolor[3] = color[3];
ADDRLP4 0+12
ADDRFP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 872
;872:		UI_DrawProportionalString2( x, y, str, drawcolor, sizeScale, cgs.media.charsetProp );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 16
INDIRF4
ARGF4
ADDRGP4 cgs+751220+36
INDIRI4
ARGI4
ADDRGP4 UI_DrawProportionalString2
CALLV
pop
line 873
;873:		return;
ADDRGP4 $394
JUMPV
LABELV $408
line 876
;874:	}
;875:
;876:	if ( style & UI_PULSE ) {
ADDRFP4 12
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $415
line 877
;877:		drawcolor[0] = color[0] * 0.8;
ADDRLP4 0
ADDRFP4 16
INDIRP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 878
;878:		drawcolor[1] = color[1] * 0.8;
ADDRLP4 0+4
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 879
;879:		drawcolor[2] = color[2] * 0.8;
ADDRLP4 0+8
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 880
;880:		drawcolor[3] = color[3];
ADDRLP4 0+12
ADDRFP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 881
;881:		UI_DrawProportionalString2( x, y, str, color, sizeScale, cgs.media.charsetProp );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 16
INDIRF4
ARGF4
ADDRGP4 cgs+751220+36
INDIRI4
ARGI4
ADDRGP4 UI_DrawProportionalString2
CALLV
pop
line 883
;882:
;883:		drawcolor[0] = color[0];
ADDRLP4 0
ADDRFP4 16
INDIRP4
INDIRF4
ASGNF4
line 884
;884:		drawcolor[1] = color[1];
ADDRLP4 0+4
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 885
;885:		drawcolor[2] = color[2];
ADDRLP4 0+8
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ASGNF4
line 886
;886:		drawcolor[3] = 0.5 + 0.5 * sin( cg.time / PULSE_DIVISOR );
ADDRGP4 cg+107656
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 36
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 0+12
ADDRLP4 36
INDIRF4
CNSTF4 1056964608
MULF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 887
;887:		UI_DrawProportionalString2( x, y, str, drawcolor, sizeScale, cgs.media.charsetPropGlow );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 16
INDIRF4
ARGF4
ADDRGP4 cgs+751220+40
INDIRI4
ARGI4
ADDRGP4 UI_DrawProportionalString2
CALLV
pop
line 888
;888:		return;
ADDRGP4 $394
JUMPV
LABELV $415
line 891
;889:	}
;890:
;891:	UI_DrawProportionalString2( x, y, str, color, sizeScale, cgs.media.charsetProp );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 16
INDIRF4
ARGF4
ADDRGP4 cgs+751220+36
INDIRI4
ARGI4
ADDRGP4 UI_DrawProportionalString2
CALLV
pop
line 892
;892:}
LABELV $394
endproc UI_DrawProportionalString 44 24
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
import CG_DrawTeamVote
import CG_DrawVote
import CG_StatusHandle
import CG_OtherTeamHasFlag
import CG_YourTeamHasFlag
import CG_GameTypeString
import CG_CheckOrderPending
import CG_Text_PaintChar
import CG_Draw3DModel
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
import CG_DrawTeamBackground
import CG_DrawFlagModel
import CG_DrawActive
import CG_DrawHead
import CG_CenterPrint
import CG_AddLagometerSnapshotInfo
import CG_AddLagometerFrameInfo
import teamChat2
import teamChat1
import systemChat
import drawTeamOverlayModificationCount
import numSortedTeamPlayers
import sortedTeamPlayers
import CG_DrawString
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
