export Com_Clamp
code
proc Com_Clamp 0 0
file "..\..\..\..\code\game\q_shared.c"
line 6
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// q_shared.c -- stateless support routines that are included in each code dll
;4:#include "q_shared.h"
;5:
;6:float Com_Clamp( float min, float max, float value ) {
line 7
;7:	if ( value < min ) {
ADDRFP4 8
INDIRF4
ADDRFP4 0
INDIRF4
GEF4 $23
line 8
;8:		return min;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $22
JUMPV
LABELV $23
line 10
;9:	}
;10:	if ( value > max ) {
ADDRFP4 8
INDIRF4
ADDRFP4 4
INDIRF4
LEF4 $25
line 11
;11:		return max;
ADDRFP4 4
INDIRF4
RETF4
ADDRGP4 $22
JUMPV
LABELV $25
line 13
;12:	}
;13:	return value;
ADDRFP4 8
INDIRF4
RETF4
LABELV $22
endproc Com_Clamp 0 0
export COM_SkipPath
proc COM_SkipPath 4 0
line 23
;14:}
;15:
;16:
;17:/*
;18:============
;19:COM_SkipPath
;20:============
;21:*/
;22:char *COM_SkipPath (char *pathname)
;23:{
line 26
;24:	char	*last;
;25:	
;26:	last = pathname;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $29
JUMPV
LABELV $28
line 28
;27:	while (*pathname)
;28:	{
line 29
;29:		if (*pathname=='/')
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 47
NEI4 $31
line 30
;30:			last = pathname+1;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $31
line 31
;31:		pathname++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 32
;32:	}
LABELV $29
line 27
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $28
line 33
;33:	return last;
ADDRLP4 0
INDIRP4
RETP4
LABELV $27
endproc COM_SkipPath 4 0
export COM_StripExtension
proc COM_StripExtension 8 0
line 41
;34:}
;35:
;36:/*
;37:============
;38:COM_StripExtension
;39:============
;40:*/
;41:void COM_StripExtension( const char *in, char *out ) {
ADDRGP4 $35
JUMPV
LABELV $34
line 42
;42:	while ( *in && *in != '.' ) {
line 43
;43:		*out++ = *in++;
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 4
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI1
ASGNI1
line 44
;44:	}
LABELV $35
line 42
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $37
ADDRLP4 0
INDIRI4
CNSTI4 46
NEI4 $34
LABELV $37
line 45
;45:	*out = 0;
ADDRFP4 4
INDIRP4
CNSTI1 0
ASGNI1
line 46
;46:}
LABELV $33
endproc COM_StripExtension 8 0
export COM_DefaultExtension
proc COM_DefaultExtension 76 20
line 54
;47:
;48:
;49:/*
;50:==================
;51:COM_DefaultExtension
;52:==================
;53:*/
;54:void COM_DefaultExtension (char *path, int maxSize, const char *extension ) {
line 62
;55:	char	oldPath[MAX_QPATH];
;56:	char    *src;
;57:
;58://
;59:// if path doesn't have a .EXT, append extension
;60:// (extension should include the .)
;61://
;62:	src = path + strlen(path) - 1;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 68
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
CNSTI4 -1
ADDP4
ASGNP4
ADDRGP4 $40
JUMPV
LABELV $39
line 64
;63:
;64:	while (*src != '/' && src != path) {
line 65
;65:		if ( *src == '.' ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 46
NEI4 $42
line 66
;66:			return;                 // it has an extension
ADDRGP4 $38
JUMPV
LABELV $42
line 68
;67:		}
;68:		src--;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 -1
ADDP4
ASGNP4
line 69
;69:	}
LABELV $40
line 64
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 47
EQI4 $44
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
NEU4 $39
LABELV $44
line 71
;70:
;71:	Q_strncpyz( oldPath, path, sizeof( oldPath ) );
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 72
;72:	Com_sprintf( path, maxSize, "%s%s", oldPath, extension );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $45
ARGP4
ADDRLP4 4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 73
;73:}
LABELV $38
endproc COM_DefaultExtension 76 20
export ShortSwap
proc ShortSwap 2 0
ADDRFP4 0
ADDRFP4 0
INDIRI4
CVII2 4
ASGNI2
line 105
;74:
;75:/*
;76:============================================================================
;77:
;78:					BYTE ORDER FUNCTIONS
;79:
;80:============================================================================
;81:*/
;82:/*
;83:// can't just use function pointers, or dll linkage can
;84:// mess up when qcommon is included in multiple places
;85:static short	(*_BigShort) (short l);
;86:static short	(*_LittleShort) (short l);
;87:static int		(*_BigLong) (int l);
;88:static int		(*_LittleLong) (int l);
;89:static qint64	(*_BigLong64) (qint64 l);
;90:static qint64	(*_LittleLong64) (qint64 l);
;91:static float	(*_BigFloat) (const float *l);
;92:static float	(*_LittleFloat) (const float *l);
;93:
;94:short	BigShort(short l){return _BigShort(l);}
;95:short	LittleShort(short l) {return _LittleShort(l);}
;96:int		BigLong (int l) {return _BigLong(l);}
;97:int		LittleLong (int l) {return _LittleLong(l);}
;98:qint64 	BigLong64 (qint64 l) {return _BigLong64(l);}
;99:qint64 	LittleLong64 (qint64 l) {return _LittleLong64(l);}
;100:float	BigFloat (const float *l) {return _BigFloat(l);}
;101:float	LittleFloat (const float *l) {return _LittleFloat(l);}
;102:*/
;103:
;104:short   ShortSwap (short l)
;105:{
line 108
;106:	byte    b1,b2;
;107:
;108:	b1 = l&255;
ADDRLP4 0
ADDRFP4 0
INDIRI2
CVII4 2
CNSTI4 255
BANDI4
CVIU4 4
CVUU1 4
ASGNU1
line 109
;109:	b2 = (l>>8)&255;
ADDRLP4 1
ADDRFP4 0
INDIRI2
CVII4 2
CNSTI4 8
RSHI4
CNSTI4 255
BANDI4
CVIU4 4
CVUU1 4
ASGNU1
line 111
;110:
;111:	return (b1<<8) + b2;
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 8
LSHI4
ADDRLP4 1
INDIRU1
CVUI4 1
ADDI4
CVII2 4
CVII4 2
RETI4
LABELV $46
endproc ShortSwap 2 0
export ShortNoSwap
proc ShortNoSwap 0 0
ADDRFP4 0
ADDRFP4 0
INDIRI4
CVII2 4
ASGNI2
line 115
;112:}
;113:
;114:short	ShortNoSwap (short l)
;115:{
line 116
;116:	return l;
ADDRFP4 0
INDIRI2
CVII4 2
RETI4
LABELV $47
endproc ShortNoSwap 0 0
export LongSwap
proc LongSwap 4 0
line 120
;117:}
;118:
;119:int    LongSwap (int l)
;120:{
line 123
;121:	byte    b1,b2,b3,b4;
;122:
;123:	b1 = l&255;
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 255
BANDI4
CVIU4 4
CVUU1 4
ASGNU1
line 124
;124:	b2 = (l>>8)&255;
ADDRLP4 1
ADDRFP4 0
INDIRI4
CNSTI4 8
RSHI4
CNSTI4 255
BANDI4
CVIU4 4
CVUU1 4
ASGNU1
line 125
;125:	b3 = (l>>16)&255;
ADDRLP4 2
ADDRFP4 0
INDIRI4
CNSTI4 16
RSHI4
CNSTI4 255
BANDI4
CVIU4 4
CVUU1 4
ASGNU1
line 126
;126:	b4 = (l>>24)&255;
ADDRLP4 3
ADDRFP4 0
INDIRI4
CNSTI4 24
RSHI4
CNSTI4 255
BANDI4
CVIU4 4
CVUU1 4
ASGNU1
line 128
;127:
;128:	return ((int)b1<<24) + ((int)b2<<16) + ((int)b3<<8) + b4;
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 24
LSHI4
ADDRLP4 1
INDIRU1
CVUI4 1
CNSTI4 16
LSHI4
ADDI4
ADDRLP4 2
INDIRU1
CVUI4 1
CNSTI4 8
LSHI4
ADDI4
ADDRLP4 3
INDIRU1
CVUI4 1
ADDI4
RETI4
LABELV $48
endproc LongSwap 4 0
export LongNoSwap
proc LongNoSwap 0 0
line 132
;129:}
;130:
;131:int	LongNoSwap (int l)
;132:{
line 133
;133:	return l;
ADDRFP4 0
INDIRI4
RETI4
LABELV $49
endproc LongNoSwap 0 0
export Long64Swap
proc Long64Swap 8 0
line 137
;134:}
;135:
;136:qint64 Long64Swap (qint64 ll)
;137:{
line 140
;138:	qint64	result;
;139:
;140:	result.b0 = ll.b7;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 7
ADDP4
INDIRU1
ASGNU1
line 141
;141:	result.b1 = ll.b6;
ADDRLP4 0+1
ADDRFP4 4
INDIRP4
CNSTI4 6
ADDP4
INDIRU1
ASGNU1
line 142
;142:	result.b2 = ll.b5;
ADDRLP4 0+2
ADDRFP4 4
INDIRP4
CNSTI4 5
ADDP4
INDIRU1
ASGNU1
line 143
;143:	result.b3 = ll.b4;
ADDRLP4 0+3
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRU1
ASGNU1
line 144
;144:	result.b4 = ll.b3;
ADDRLP4 0+4
ADDRFP4 4
INDIRP4
CNSTI4 3
ADDP4
INDIRU1
ASGNU1
line 145
;145:	result.b5 = ll.b2;
ADDRLP4 0+5
ADDRFP4 4
INDIRP4
CNSTI4 2
ADDP4
INDIRU1
ASGNU1
line 146
;146:	result.b6 = ll.b1;
ADDRLP4 0+6
ADDRFP4 4
INDIRP4
CNSTI4 1
ADDP4
INDIRU1
ASGNU1
line 147
;147:	result.b7 = ll.b0;
ADDRLP4 0+7
ADDRFP4 4
INDIRP4
INDIRU1
ASGNU1
line 149
;148:
;149:	return result;
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRB
ASGNB 8
LABELV $50
endproc Long64Swap 8 0
export Long64NoSwap
proc Long64NoSwap 0 0
line 153
;150:}
;151:
;152:qint64 Long64NoSwap (qint64 ll)
;153:{
line 154
;154:	return ll;
ADDRFP4 0
INDIRP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 8
LABELV $59
endproc Long64NoSwap 0 0
export FloatSwap
proc FloatSwap 12 4
line 162
;155:}
;156:
;157:typedef union {
;158:		float	f;
;159:    unsigned int i;
;160:} _FloatByteUnion;
;161:
;162:float FloatSwap (const float *f) {
line 166
;163:	const _FloatByteUnion *in;
;164:	_FloatByteUnion out;
;165:	
;166:	in = (_FloatByteUnion *)f;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 167
;167:	out.i = LongSwap(in->i);
ADDRLP4 0
INDIRP4
INDIRU4
CVUI4 4
ARGI4
ADDRLP4 8
ADDRGP4 LongSwap
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
CVIU4 4
ASGNU4
line 169
;168:	
;169:	return out.f;
ADDRLP4 4
INDIRF4
RETF4
LABELV $62
endproc FloatSwap 12 4
export FloatNoSwap
proc FloatNoSwap 0 0
line 173
;170:}
;171:
;172:float FloatNoSwap (const float *f)
;173:{
line 174
;174:	return *f;
ADDRFP4 0
INDIRP4
INDIRF4
RETF4
LABELV $63
endproc FloatNoSwap 0 0
export COM_BeginParseSession
proc COM_BeginParseSession 0 16
line 228
;175:}
;176:
;177:/*
;178:================
;179:Swap_Init
;180:================
;181:*/
;182:/*
;183:void Swap_Init (void)
;184:{
;185:	byte	swaptest[2] = {1,0};
;186:
;187:// set the byte swapping variables in a portable manner	
;188:	if ( *(short *)swaptest == 1)
;189:	{
;190:		_BigShort = ShortSwap;
;191:		_LittleShort = ShortNoSwap;
;192:		_BigLong = LongSwap;
;193:		_LittleLong = LongNoSwap;
;194:		_BigLong64 = Long64Swap;
;195:		_LittleLong64 = Long64NoSwap;
;196:		_BigFloat = FloatSwap;
;197:		_LittleFloat = FloatNoSwap;
;198:	}
;199:	else
;200:	{
;201:		_BigShort = ShortNoSwap;
;202:		_LittleShort = ShortSwap;
;203:		_BigLong = LongNoSwap;
;204:		_LittleLong = LongSwap;
;205:		_BigLong64 = Long64NoSwap;
;206:		_LittleLong64 = Long64Swap;
;207:		_BigFloat = FloatNoSwap;
;208:		_LittleFloat = FloatSwap;
;209:	}
;210:
;211:}
;212:*/
;213:
;214:
;215:/*
;216:============================================================================
;217:
;218:PARSING
;219:
;220:============================================================================
;221:*/
;222:
;223:static	char	com_token[MAX_TOKEN_CHARS];
;224:static	char	com_parsename[MAX_TOKEN_CHARS];
;225:static	int		com_lines;
;226:
;227:void COM_BeginParseSession( const char *name )
;228:{
line 229
;229:	com_lines = 0;
ADDRGP4 com_lines
CNSTI4 0
ASGNI4
line 230
;230:	Com_sprintf(com_parsename, sizeof(com_parsename), "%s", name);
ADDRGP4 com_parsename
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $65
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 231
;231:}
LABELV $64
endproc COM_BeginParseSession 0 16
export COM_GetCurrentParseLine
proc COM_GetCurrentParseLine 0 0
line 234
;232:
;233:int COM_GetCurrentParseLine( void )
;234:{
line 235
;235:	return com_lines;
ADDRGP4 com_lines
INDIRI4
RETI4
LABELV $66
endproc COM_GetCurrentParseLine 0 0
export COM_Parse
proc COM_Parse 4 8
line 239
;236:}
;237:
;238:char *COM_Parse( char **data_p )
;239:{
line 240
;240:	return COM_ParseExt( data_p, qtrue );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 0
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
RETP4
LABELV $67
endproc COM_Parse 4 8
bss
align 1
LABELV $69
skip 4096
export COM_ParseError
code
proc COM_ParseError 4 16
line 244
;241:}
;242:
;243:void COM_ParseError( char *format, ... )
;244:{
line 248
;245:	va_list argptr;
;246:	static char string[4096];
;247:
;248:	va_start (argptr, format);
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 249
;249:	vsprintf (string, format, argptr);
ADDRGP4 $69
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 vsprintf
CALLI4
pop
line 250
;250:	va_end (argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 252
;251:
;252:	Com_Printf("ERROR: %s, line %d: %s\n", com_parsename, com_lines, string);
ADDRGP4 $71
ARGP4
ADDRGP4 com_parsename
ARGP4
ADDRGP4 com_lines
INDIRI4
ARGI4
ADDRGP4 $69
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 253
;253:}
LABELV $68
endproc COM_ParseError 4 16
bss
align 1
LABELV $73
skip 4096
export COM_ParseWarning
code
proc COM_ParseWarning 4 16
line 256
;254:
;255:void COM_ParseWarning( char *format, ... )
;256:{
line 260
;257:	va_list argptr;
;258:	static char string[4096];
;259:
;260:	va_start (argptr, format);
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 261
;261:	vsprintf (string, format, argptr);
ADDRGP4 $73
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 vsprintf
CALLI4
pop
line 262
;262:	va_end (argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 264
;263:
;264:	Com_Printf("WARNING: %s, line %d: %s\n", com_parsename, com_lines, string);
ADDRGP4 $75
ARGP4
ADDRGP4 com_parsename
ARGP4
ADDRGP4 com_lines
INDIRI4
ARGI4
ADDRGP4 $73
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 265
;265:}
LABELV $72
endproc COM_ParseWarning 4 16
proc SkipWhitespace 8 0
line 279
;266:
;267:/*
;268:==============
;269:COM_Parse
;270:
;271:Parse a token out of a string
;272:Will never return NULL, just empty strings
;273:
;274:If "allowLineBreaks" is qtrue then an empty
;275:string will be returned if the next token is
;276:a newline.
;277:==============
;278:*/
;279:static char *SkipWhitespace( char *data, qboolean *hasNewLines ) {
ADDRGP4 $78
JUMPV
LABELV $77
line 282
;280:	int c;
;281:
;282:	while( (c = *data) <= ' ') {
line 283
;283:		if( !c ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $80
line 284
;284:			return NULL;
CNSTP4 0
RETP4
ADDRGP4 $76
JUMPV
LABELV $80
line 286
;285:		}
;286:		if( c == '\n' ) {
ADDRLP4 0
INDIRI4
CNSTI4 10
NEI4 $82
line 287
;287:			com_lines++;
ADDRLP4 4
ADDRGP4 com_lines
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 288
;288:			*hasNewLines = qtrue;
ADDRFP4 4
INDIRP4
CNSTI4 1
ASGNI4
line 289
;289:		}
LABELV $82
line 290
;290:		data++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 291
;291:	}
LABELV $78
line 282
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 32
LEI4 $77
line 293
;292:
;293:	return data;
ADDRFP4 0
INDIRP4
RETP4
LABELV $76
endproc SkipWhitespace 8 0
export COM_Compress
proc COM_Compress 44 0
line 296
;294:}
;295:
;296:int COM_Compress( char *data_p ) {
line 299
;297:	char *in, *out;
;298:	int c;
;299:	qboolean newline = qfalse, whitespace = qfalse;
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 16
CNSTI4 0
ASGNI4
line 301
;300:
;301:	in = out = data_p;
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 20
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 302
;302:	if (in) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $85
ADDRGP4 $88
JUMPV
LABELV $87
line 303
;303:		while ((c = *in) != 0) {
line 305
;304:			// skip double slash comments
;305:			if ( c == '/' && in[1] == '/' ) {
ADDRLP4 4
INDIRI4
CNSTI4 47
NEI4 $90
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 47
NEI4 $90
ADDRGP4 $93
JUMPV
LABELV $92
line 306
;306:				while (*in && *in != '\n') {
line 307
;307:					in++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 308
;308:				}
LABELV $93
line 306
ADDRLP4 24
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $95
ADDRLP4 24
INDIRI4
CNSTI4 10
NEI4 $92
LABELV $95
line 310
;309:			// skip /* */ comments
;310:			} else if ( c == '/' && in[1] == '*' ) {
ADDRGP4 $91
JUMPV
LABELV $90
ADDRLP4 4
INDIRI4
CNSTI4 47
NEI4 $96
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $96
ADDRGP4 $99
JUMPV
LABELV $98
line 312
;311:				while ( *in && ( *in != '*' || in[1] != '/' ) ) 
;312:					in++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $99
line 311
ADDRLP4 28
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $101
ADDRLP4 28
INDIRI4
CNSTI4 42
NEI4 $98
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 47
NEI4 $98
LABELV $101
line 313
;313:				if ( *in ) 
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $97
line 314
;314:					in += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 316
;315:                        // record when we hit a newline
;316:                        } else if ( c == '\n' || c == '\r' ) {
ADDRGP4 $97
JUMPV
LABELV $96
ADDRLP4 4
INDIRI4
CNSTI4 10
EQI4 $106
ADDRLP4 4
INDIRI4
CNSTI4 13
NEI4 $104
LABELV $106
line 317
;317:                            newline = qtrue;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 318
;318:                            in++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 320
;319:                        // record when we hit whitespace
;320:                        } else if ( c == ' ' || c == '\t') {
ADDRGP4 $105
JUMPV
LABELV $104
ADDRLP4 4
INDIRI4
CNSTI4 32
EQI4 $109
ADDRLP4 4
INDIRI4
CNSTI4 9
NEI4 $107
LABELV $109
line 321
;321:                            whitespace = qtrue;
ADDRLP4 16
CNSTI4 1
ASGNI4
line 322
;322:                            in++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 324
;323:                        // an actual token
;324:			} else {
ADDRGP4 $108
JUMPV
LABELV $107
line 326
;325:                            // if we have a pending newline, emit it (and it counts as whitespace)
;326:                            if (newline) {
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $110
line 327
;327:                                *out++ = '\n';
ADDRLP4 32
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 32
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI1 10
ASGNI1
line 328
;328:                                newline = qfalse;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 329
;329:                                whitespace = qfalse;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 330
;330:                            } if (whitespace) {
LABELV $110
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $112
line 331
;331:                                *out++ = ' ';
ADDRLP4 32
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 32
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI1 32
ASGNI1
line 332
;332:                                whitespace = qfalse;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 333
;333:                            }
LABELV $112
line 336
;334:                            
;335:                            // copy quoted strings unmolested
;336:                            if (c == '"') {
ADDRLP4 4
INDIRI4
CNSTI4 34
NEI4 $114
line 337
;337:                                    *out++ = c;
ADDRLP4 32
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 32
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 4
INDIRI4
CVII1 4
ASGNI1
line 338
;338:                                    in++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRGP4 $117
JUMPV
LABELV $116
line 339
;339:                                    while (1) {
line 340
;340:                                        c = *in;
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 341
;341:                                        if (c && c != '"') {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $118
ADDRLP4 4
INDIRI4
CNSTI4 34
EQI4 $118
line 342
;342:                                            *out++ = c;
ADDRLP4 40
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 40
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 4
INDIRI4
CVII1 4
ASGNI1
line 343
;343:                                            in++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 344
;344:                                        } else {
line 345
;345:                                            break;
LABELV $120
line 347
;346:                                        }
;347:                                    }
LABELV $117
line 339
ADDRGP4 $116
JUMPV
LABELV $118
line 348
;348:                                    if (c == '"') {
ADDRLP4 4
INDIRI4
CNSTI4 34
NEI4 $115
line 349
;349:                                        *out++ = c;
ADDRLP4 36
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 36
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 4
INDIRI4
CVII1 4
ASGNI1
line 350
;350:                                        in++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 351
;351:                                    }
line 352
;352:                            } else {
ADDRGP4 $115
JUMPV
LABELV $114
line 353
;353:                                *out = c;
ADDRLP4 8
INDIRP4
ADDRLP4 4
INDIRI4
CVII1 4
ASGNI1
line 354
;354:                                out++;
ADDRLP4 8
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 355
;355:                                in++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 356
;356:                            }
LABELV $115
line 357
;357:			}
LABELV $108
LABELV $105
LABELV $97
LABELV $91
line 358
;358:		}
LABELV $88
line 303
ADDRLP4 24
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 4
ADDRLP4 24
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $87
line 359
;359:	}
LABELV $85
line 360
;360:	*out = 0;
ADDRLP4 8
INDIRP4
CNSTI1 0
ASGNI1
line 361
;361:	return out - data_p;
ADDRLP4 8
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
RETI4
LABELV $84
endproc COM_Compress 44 0
export COM_ParseExt
proc COM_ParseExt 28 8
line 365
;362:}
;363:
;364:char *COM_ParseExt( char **data_p, qboolean allowLineBreaks )
;365:{
line 366
;366:	int c = 0, len;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 367
;367:	qboolean hasNewLines = qfalse;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 370
;368:	char *data;
;369:
;370:	data = *data_p;
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRP4
ASGNP4
line 371
;371:	len = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 372
;372:	com_token[0] = 0;
ADDRGP4 com_token
CNSTI1 0
ASGNI1
line 375
;373:
;374:	// make sure incoming data is valid
;375:	if ( !data )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $127
line 376
;376:	{
line 377
;377:		*data_p = NULL;
ADDRFP4 0
INDIRP4
CNSTP4 0
ASGNP4
line 378
;378:		return com_token;
ADDRGP4 com_token
RETP4
ADDRGP4 $123
JUMPV
LABELV $126
line 382
;379:	}
;380:
;381:	while ( 1 )
;382:	{
line 384
;383:		// skip whitespace
;384:		data = SkipWhitespace( data, &hasNewLines );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 16
ADDRGP4 SkipWhitespace
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 385
;385:		if ( !data )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $129
line 386
;386:		{
line 387
;387:			*data_p = NULL;
ADDRFP4 0
INDIRP4
CNSTP4 0
ASGNP4
line 388
;388:			return com_token;
ADDRGP4 com_token
RETP4
ADDRGP4 $123
JUMPV
LABELV $129
line 390
;389:		}
;390:		if ( hasNewLines && !allowLineBreaks )
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $131
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $131
line 391
;391:		{
line 392
;392:			*data_p = data;
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRP4
ASGNP4
line 393
;393:			return com_token;
ADDRGP4 com_token
RETP4
ADDRGP4 $123
JUMPV
LABELV $131
line 396
;394:		}
;395:
;396:		c = *data;
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 399
;397:
;398:		// skip double slash comments
;399:		if ( c == '/' && data[1] == '/' )
ADDRLP4 4
INDIRI4
CNSTI4 47
NEI4 $133
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 47
NEI4 $133
line 400
;400:		{
line 401
;401:			data += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
ADDRGP4 $136
JUMPV
LABELV $135
line 402
;402:			while (*data && *data != '\n') {
line 403
;403:				data++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 404
;404:			}
LABELV $136
line 402
ADDRLP4 20
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $138
ADDRLP4 20
INDIRI4
CNSTI4 10
NEI4 $135
LABELV $138
line 405
;405:		}
ADDRGP4 $134
JUMPV
LABELV $133
line 407
;406:		// skip /* */ comments
;407:		else if ( c=='/' && data[1] == '*' ) 
ADDRLP4 4
INDIRI4
CNSTI4 47
NEI4 $128
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $128
line 408
;408:		{
line 409
;409:			data += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
ADDRGP4 $142
JUMPV
LABELV $141
line 411
;410:			while ( *data && ( *data != '*' || data[1] != '/' ) ) 
;411:			{
line 412
;412:				data++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 413
;413:			}
LABELV $142
line 410
ADDRLP4 24
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $144
ADDRLP4 24
INDIRI4
CNSTI4 42
NEI4 $141
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 47
NEI4 $141
LABELV $144
line 414
;414:			if ( *data ) 
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $140
line 415
;415:			{
line 416
;416:				data += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 417
;417:			}
line 418
;418:		}
line 420
;419:		else
;420:		{
line 421
;421:			break;
LABELV $140
LABELV $134
line 423
;422:		}
;423:	}
LABELV $127
line 381
ADDRGP4 $126
JUMPV
LABELV $128
line 426
;424:
;425:	// handle quoted strings
;426:	if (c == '\"')
ADDRLP4 4
INDIRI4
CNSTI4 34
NEI4 $147
line 427
;427:	{
line 428
;428:		data++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRGP4 $150
JUMPV
LABELV $149
line 430
;429:		while (1)
;430:		{
line 431
;431:			c = *data++;
ADDRLP4 16
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 432
;432:			if (c=='\"' || !c)
ADDRLP4 4
INDIRI4
CNSTI4 34
EQI4 $154
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $152
LABELV $154
line 433
;433:			{
line 434
;434:				com_token[len] = 0;
ADDRLP4 8
INDIRI4
ADDRGP4 com_token
ADDP4
CNSTI1 0
ASGNI1
line 435
;435:				*data_p = ( char * ) data;
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRP4
ASGNP4
line 436
;436:				return com_token;
ADDRGP4 com_token
RETP4
ADDRGP4 $123
JUMPV
LABELV $152
line 438
;437:			}
;438:			if (len < MAX_TOKEN_CHARS)
ADDRLP4 8
INDIRI4
CNSTI4 1024
GEI4 $155
line 439
;439:			{
line 440
;440:				com_token[len] = c;
ADDRLP4 8
INDIRI4
ADDRGP4 com_token
ADDP4
ADDRLP4 4
INDIRI4
CVII1 4
ASGNI1
line 441
;441:				len++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 442
;442:			}
LABELV $155
line 443
;443:		}
LABELV $150
line 429
ADDRGP4 $149
JUMPV
line 444
;444:	}
LABELV $147
LABELV $157
line 448
;445:
;446:	// parse a regular word
;447:	do
;448:	{
line 449
;449:		if (len < MAX_TOKEN_CHARS)
ADDRLP4 8
INDIRI4
CNSTI4 1024
GEI4 $160
line 450
;450:		{
line 451
;451:			com_token[len] = c;
ADDRLP4 8
INDIRI4
ADDRGP4 com_token
ADDP4
ADDRLP4 4
INDIRI4
CVII1 4
ASGNI1
line 452
;452:			len++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 453
;453:		}
LABELV $160
line 454
;454:		data++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 455
;455:		c = *data;
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 456
;456:		if ( c == '\n' )
ADDRLP4 4
INDIRI4
CNSTI4 10
NEI4 $162
line 457
;457:			com_lines++;
ADDRLP4 16
ADDRGP4 com_lines
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $162
line 458
;458:	} while (c>32);
LABELV $158
ADDRLP4 4
INDIRI4
CNSTI4 32
GTI4 $157
line 460
;459:
;460:	if (len == MAX_TOKEN_CHARS)
ADDRLP4 8
INDIRI4
CNSTI4 1024
NEI4 $164
line 461
;461:	{
line 463
;462://		Com_Printf ("Token exceeded %i chars, discarded.\n", MAX_TOKEN_CHARS);
;463:		len = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 464
;464:	}
LABELV $164
line 465
;465:	com_token[len] = 0;
ADDRLP4 8
INDIRI4
ADDRGP4 com_token
ADDP4
CNSTI1 0
ASGNI1
line 467
;466:
;467:	*data_p = ( char * ) data;
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRP4
ASGNP4
line 468
;468:	return com_token;
ADDRGP4 com_token
RETP4
LABELV $123
endproc COM_ParseExt 28 8
export COM_MatchToken
proc COM_MatchToken 12 16
line 532
;469:}
;470:
;471:
;472:#if 0
;473:// no longer used
;474:/*
;475:===============
;476:COM_ParseInfos
;477:===============
;478:*/
;479:int COM_ParseInfos( char *buf, int max, char infos[][MAX_INFO_STRING] ) {
;480:	char	*token;
;481:	int		count;
;482:	char	key[MAX_TOKEN_CHARS];
;483:
;484:	count = 0;
;485:
;486:	while ( 1 ) {
;487:		token = COM_Parse( &buf );
;488:		if ( !token[0] ) {
;489:			break;
;490:		}
;491:		if ( strcmp( token, "{" ) ) {
;492:			Com_Printf( "Missing { in info file\n" );
;493:			break;
;494:		}
;495:
;496:		if ( count == max ) {
;497:			Com_Printf( "Max infos exceeded\n" );
;498:			break;
;499:		}
;500:
;501:		infos[count][0] = 0;
;502:		while ( 1 ) {
;503:			token = COM_ParseExt( &buf, qtrue );
;504:			if ( !token[0] ) {
;505:				Com_Printf( "Unexpected end of info file\n" );
;506:				break;
;507:			}
;508:			if ( !strcmp( token, "}" ) ) {
;509:				break;
;510:			}
;511:			Q_strncpyz( key, token, sizeof( key ) );
;512:
;513:			token = COM_ParseExt( &buf, qfalse );
;514:			if ( !token[0] ) {
;515:				strcpy( token, "<NULL>" );
;516:			}
;517:			Info_SetValueForKey( infos[count], key, token );
;518:		}
;519:		count++;
;520:	}
;521:
;522:	return count;
;523:}
;524:#endif
;525:
;526:
;527:/*
;528:==================
;529:COM_MatchToken
;530:==================
;531:*/
;532:void COM_MatchToken( char **buf_p, char *match ) {
line 535
;533:	char	*token;
;534:
;535:	token = COM_Parse( buf_p );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 536
;536:	if ( strcmp( token, match ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $167
line 537
;537:		Com_Error( ERR_DROP, "MatchToken: %s != %s", token, match );
CNSTI4 1
ARGI4
ADDRGP4 $169
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_Error
CALLV
pop
line 538
;538:	}
LABELV $167
line 539
;539:}
LABELV $166
endproc COM_MatchToken 12 16
export SkipBracedSection
proc SkipBracedSection 12 8
line 551
;540:
;541:
;542:/*
;543:=================
;544:SkipBracedSection
;545:
;546:The next token should be an open brace.
;547:Skips until a matching close brace is found.
;548:Internal brace depths are properly skipped.
;549:=================
;550:*/
;551:void SkipBracedSection (char **program) {
line 555
;552:	char			*token;
;553:	int				depth;
;554:
;555:	depth = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $171
line 556
;556:	do {
line 557
;557:		token = COM_ParseExt( program, qtrue );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 558
;558:		if( token[1] == 0 ) {
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $174
line 559
;559:			if( token[0] == '{' ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 123
NEI4 $176
line 560
;560:				depth++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 561
;561:			}
ADDRGP4 $177
JUMPV
LABELV $176
line 562
;562:			else if( token[0] == '}' ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $178
line 563
;563:				depth--;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 564
;564:			}
LABELV $178
LABELV $177
line 565
;565:		}
LABELV $174
line 566
;566:	} while( depth && *program );
LABELV $172
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $180
ADDRFP4 0
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $171
LABELV $180
line 567
;567:}
LABELV $170
endproc SkipBracedSection 12 8
export SkipRestOfLine
proc SkipRestOfLine 16 0
line 574
;568:
;569:/*
;570:=================
;571:SkipRestOfLine
;572:=================
;573:*/
;574:void SkipRestOfLine ( char **data ) {
line 578
;575:	char	*p;
;576:	int		c;
;577:
;578:	p = *data;
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRP4
ASGNP4
ADDRGP4 $183
JUMPV
LABELV $182
line 579
;579:	while ( (c = *p++) != 0 ) {
line 580
;580:		if ( c == '\n' ) {
ADDRLP4 0
INDIRI4
CNSTI4 10
NEI4 $185
line 581
;581:			com_lines++;
ADDRLP4 8
ADDRGP4 com_lines
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 582
;582:			break;
ADDRGP4 $184
JUMPV
LABELV $185
line 584
;583:		}
;584:	}
LABELV $183
line 579
ADDRLP4 8
ADDRLP4 4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 12
ADDRLP4 8
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $182
LABELV $184
line 586
;585:
;586:	*data = p;
ADDRFP4 0
INDIRP4
ADDRLP4 4
INDIRP4
ASGNP4
line 587
;587:}
LABELV $181
endproc SkipRestOfLine 16 0
export Parse1DMatrix
proc Parse1DMatrix 16 8
line 590
;588:
;589:
;590:void Parse1DMatrix (char **buf_p, int x, float *m) {
line 594
;591:	char	*token;
;592:	int		i;
;593:
;594:	COM_MatchToken( buf_p, "(" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $188
ARGP4
ADDRGP4 COM_MatchToken
CALLV
pop
line 596
;595:
;596:	for (i = 0 ; i < x ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $192
JUMPV
LABELV $189
line 597
;597:		token = COM_Parse(buf_p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 598
;598:		m[i] = atof(token);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
line 599
;599:	}
LABELV $190
line 596
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $192
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRI4
LTI4 $189
line 601
;600:
;601:	COM_MatchToken( buf_p, ")" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $193
ARGP4
ADDRGP4 COM_MatchToken
CALLV
pop
line 602
;602:}
LABELV $187
endproc Parse1DMatrix 16 8
export Parse2DMatrix
proc Parse2DMatrix 8 12
line 604
;603:
;604:void Parse2DMatrix (char **buf_p, int y, int x, float *m) {
line 607
;605:	int		i;
;606:
;607:	COM_MatchToken( buf_p, "(" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $188
ARGP4
ADDRGP4 COM_MatchToken
CALLV
pop
line 609
;608:
;609:	for (i = 0 ; i < y ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $198
JUMPV
LABELV $195
line 610
;610:		Parse1DMatrix (buf_p, x, m + i * x);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
MULI4
CNSTI4 2
LSHI4
ADDRFP4 12
INDIRP4
ADDP4
ARGP4
ADDRGP4 Parse1DMatrix
CALLV
pop
line 611
;611:	}
LABELV $196
line 609
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $198
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRI4
LTI4 $195
line 613
;612:
;613:	COM_MatchToken( buf_p, ")" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $193
ARGP4
ADDRGP4 COM_MatchToken
CALLV
pop
line 614
;614:}
LABELV $194
endproc Parse2DMatrix 8 12
export Parse3DMatrix
proc Parse3DMatrix 12 16
line 616
;615:
;616:void Parse3DMatrix (char **buf_p, int z, int y, int x, float *m) {
line 619
;617:	int		i;
;618:
;619:	COM_MatchToken( buf_p, "(" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $188
ARGP4
ADDRGP4 COM_MatchToken
CALLV
pop
line 621
;620:
;621:	for (i = 0 ; i < z ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $203
JUMPV
LABELV $200
line 622
;622:		Parse2DMatrix (buf_p, y, x, m + i * x*y);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
ADDRFP4 12
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
MULI4
ADDRLP4 4
INDIRI4
MULI4
CNSTI4 2
LSHI4
ADDRFP4 16
INDIRP4
ADDP4
ARGP4
ADDRGP4 Parse2DMatrix
CALLV
pop
line 623
;623:	}
LABELV $201
line 621
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $203
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRI4
LTI4 $200
line 625
;624:
;625:	COM_MatchToken( buf_p, ")" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $193
ARGP4
ADDRGP4 COM_MatchToken
CALLV
pop
line 626
;626:}
LABELV $199
endproc Parse3DMatrix 12 16
export Q_isprint
proc Q_isprint 4 0
line 638
;627:
;628:
;629:/*
;630:============================================================================
;631:
;632:					LIBRARY REPLACEMENT FUNCTIONS
;633:
;634:============================================================================
;635:*/
;636:
;637:int Q_isprint( int c )
;638:{
line 639
;639:	if ( c >= 0x20 && c <= 0x7E )
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $205
ADDRLP4 0
INDIRI4
CNSTI4 126
GTI4 $205
line 640
;640:		return ( 1 );
CNSTI4 1
RETI4
ADDRGP4 $204
JUMPV
LABELV $205
line 641
;641:	return ( 0 );
CNSTI4 0
RETI4
LABELV $204
endproc Q_isprint 4 0
export Q_islower
proc Q_islower 4 0
line 645
;642:}
;643:
;644:int Q_islower( int c )
;645:{
line 646
;646:	if (c >= 'a' && c <= 'z')
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 97
LTI4 $208
ADDRLP4 0
INDIRI4
CNSTI4 122
GTI4 $208
line 647
;647:		return ( 1 );
CNSTI4 1
RETI4
ADDRGP4 $207
JUMPV
LABELV $208
line 648
;648:	return ( 0 );
CNSTI4 0
RETI4
LABELV $207
endproc Q_islower 4 0
export Q_isupper
proc Q_isupper 4 0
line 652
;649:}
;650:
;651:int Q_isupper( int c )
;652:{
line 653
;653:	if (c >= 'A' && c <= 'Z')
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 65
LTI4 $211
ADDRLP4 0
INDIRI4
CNSTI4 90
GTI4 $211
line 654
;654:		return ( 1 );
CNSTI4 1
RETI4
ADDRGP4 $210
JUMPV
LABELV $211
line 655
;655:	return ( 0 );
CNSTI4 0
RETI4
LABELV $210
endproc Q_isupper 4 0
export Q_isalpha
proc Q_isalpha 8 0
line 659
;656:}
;657:
;658:int Q_isalpha( int c )
;659:{
line 660
;660:	if ((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z'))
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 97
LTI4 $217
ADDRLP4 0
INDIRI4
CNSTI4 122
LEI4 $216
LABELV $217
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 65
LTI4 $214
ADDRLP4 4
INDIRI4
CNSTI4 90
GTI4 $214
LABELV $216
line 661
;661:		return ( 1 );
CNSTI4 1
RETI4
ADDRGP4 $213
JUMPV
LABELV $214
line 662
;662:	return ( 0 );
CNSTI4 0
RETI4
LABELV $213
endproc Q_isalpha 8 0
export Q_strrchr
proc Q_strrchr 12 0
line 666
;663:}
;664:
;665:char* Q_strrchr( const char* string, int c )
;666:{
line 667
;667:	char cc = c;
ADDRLP4 4
ADDRFP4 4
INDIRI4
CVII1 4
ASGNI1
line 669
;668:	char *s;
;669:	char *sp=(char *)0;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 671
;670:
;671:	s = (char*)string;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $220
JUMPV
LABELV $219
line 674
;672:
;673:	while (*s)
;674:	{
line 675
;675:		if (*s == cc)
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 4
INDIRI1
CVII4 1
NEI4 $222
line 676
;676:			sp = s;
ADDRLP4 8
ADDRLP4 0
INDIRP4
ASGNP4
LABELV $222
line 677
;677:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 678
;678:	}
LABELV $220
line 673
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $219
line 679
;679:	if (cc == 0)
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $224
line 680
;680:		sp = s;
ADDRLP4 8
ADDRLP4 0
INDIRP4
ASGNP4
LABELV $224
line 682
;681:
;682:	return sp;
ADDRLP4 8
INDIRP4
RETP4
LABELV $218
endproc Q_strrchr 12 0
export Q_strncpyz
proc Q_strncpyz 0 12
line 692
;683:}
;684:
;685:/*
;686:=============
;687:Q_strncpyz
;688: 
;689:Safe strncpy that ensures a trailing zero
;690:=============
;691:*/
;692:void Q_strncpyz( char *dest, const char *src, int destsize ) {
line 694
;693:  // bk001129 - also NULL dest
;694:  if ( !dest ) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $227
line 695
;695:    Com_Error( ERR_FATAL, "Q_strncpyz: NULL dest" );
CNSTI4 0
ARGI4
ADDRGP4 $229
ARGP4
ADDRGP4 Com_Error
CALLV
pop
line 696
;696:  }
LABELV $227
line 697
;697:	if ( !src ) {
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $230
line 698
;698:		Com_Error( ERR_FATAL, "Q_strncpyz: NULL src" );
CNSTI4 0
ARGI4
ADDRGP4 $232
ARGP4
ADDRGP4 Com_Error
CALLV
pop
line 699
;699:	}
LABELV $230
line 700
;700:	if ( destsize < 1 ) {
ADDRFP4 8
INDIRI4
CNSTI4 1
GEI4 $233
line 701
;701:		Com_Error(ERR_FATAL,"Q_strncpyz: destsize < 1" ); 
CNSTI4 0
ARGI4
ADDRGP4 $235
ARGP4
ADDRGP4 Com_Error
CALLV
pop
line 702
;702:	}
LABELV $233
line 704
;703:
;704:	strncpy( dest, src, destsize-1 );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 705
;705:    dest[destsize-1] = 0;
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
ADDRFP4 0
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 706
;706:}
LABELV $226
endproc Q_strncpyz 0 12
export Q_stricmpn
proc Q_stricmpn 32 0
line 708
;707:                 
;708:int Q_stricmpn (const char *s1, const char *s2, int n) {
line 712
;709:	int		c1, c2;
;710:	
;711:	// bk001129 - moved in 1.17 fix not in id codebase
;712:        if ( s1 == NULL ) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $237
line 713
;713:           if ( s2 == NULL )
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $239
line 714
;714:             return 0;
CNSTI4 0
RETI4
ADDRGP4 $236
JUMPV
LABELV $239
line 716
;715:           else
;716:             return -1;
CNSTI4 -1
RETI4
ADDRGP4 $236
JUMPV
LABELV $237
line 718
;717:        }
;718:        else if ( s2==NULL )
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $241
line 719
;719:          return 1;
CNSTI4 1
RETI4
ADDRGP4 $236
JUMPV
LABELV $241
LABELV $243
line 722
;720:
;721:
;722:	do {
line 723
;723:		c1 = *s1++;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 724
;724:		c2 = *s2++;
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 4
ADDRLP4 12
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 4
ADDRLP4 12
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 726
;725:
;726:		if (!n--) {
ADDRLP4 16
ADDRFP4 8
INDIRI4
ASGNI4
ADDRFP4 8
ADDRLP4 16
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $246
line 727
;727:			return 0;		// strings are equal until end point
CNSTI4 0
RETI4
ADDRGP4 $236
JUMPV
LABELV $246
line 730
;728:		}
;729:		
;730:		if (c1 != c2) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $248
line 731
;731:			if (c1 >= 'a' && c1 <= 'z') {
ADDRLP4 0
INDIRI4
CNSTI4 97
LTI4 $250
ADDRLP4 0
INDIRI4
CNSTI4 122
GTI4 $250
line 732
;732:				c1 -= ('a' - 'A');
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 32
SUBI4
ASGNI4
line 733
;733:			}
LABELV $250
line 734
;734:			if (c2 >= 'a' && c2 <= 'z') {
ADDRLP4 4
INDIRI4
CNSTI4 97
LTI4 $252
ADDRLP4 4
INDIRI4
CNSTI4 122
GTI4 $252
line 735
;735:				c2 -= ('a' - 'A');
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 32
SUBI4
ASGNI4
line 736
;736:			}
LABELV $252
line 737
;737:			if (c1 != c2) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $254
line 738
;738:				return c1 < c2 ? -1 : 1;
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
GEI4 $257
ADDRLP4 28
CNSTI4 -1
ASGNI4
ADDRGP4 $258
JUMPV
LABELV $257
ADDRLP4 28
CNSTI4 1
ASGNI4
LABELV $258
ADDRLP4 28
INDIRI4
RETI4
ADDRGP4 $236
JUMPV
LABELV $254
line 740
;739:			}
;740:		}
LABELV $248
line 741
;741:	} while (c1);
LABELV $244
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $243
line 743
;742:	
;743:	return 0;		// strings are equal
CNSTI4 0
RETI4
LABELV $236
endproc Q_stricmpn 32 0
export Q_strncmp
proc Q_strncmp 24 0
line 746
;744:}
;745:
;746:int Q_strncmp (const char *s1, const char *s2, int n) {
LABELV $260
line 749
;747:	int		c1, c2;
;748:	
;749:	do {
line 750
;750:		c1 = *s1++;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 751
;751:		c2 = *s2++;
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 4
ADDRLP4 12
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 4
ADDRLP4 12
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 753
;752:
;753:		if (!n--) {
ADDRLP4 16
ADDRFP4 8
INDIRI4
ASGNI4
ADDRFP4 8
ADDRLP4 16
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $263
line 754
;754:			return 0;		// strings are equal until end point
CNSTI4 0
RETI4
ADDRGP4 $259
JUMPV
LABELV $263
line 757
;755:		}
;756:		
;757:		if (c1 != c2) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $265
line 758
;758:			return c1 < c2 ? -1 : 1;
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
GEI4 $268
ADDRLP4 20
CNSTI4 -1
ASGNI4
ADDRGP4 $269
JUMPV
LABELV $268
ADDRLP4 20
CNSTI4 1
ASGNI4
LABELV $269
ADDRLP4 20
INDIRI4
RETI4
ADDRGP4 $259
JUMPV
LABELV $265
line 760
;759:		}
;760:	} while (c1);
LABELV $261
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $260
line 762
;761:	
;762:	return 0;		// strings are equal
CNSTI4 0
RETI4
LABELV $259
endproc Q_strncmp 24 0
export Q_stricmp
proc Q_stricmp 8 12
line 765
;763:}
;764:
;765:int Q_stricmp (const char *s1, const char *s2) {
line 766
;766:	return (s1 && s2) ? Q_stricmpn (s1, s2, 99999) : -1;
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $272
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $272
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 99999
ARGI4
ADDRLP4 4
ADDRGP4 Q_stricmpn
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
ADDRGP4 $273
JUMPV
LABELV $272
ADDRLP4 0
CNSTI4 -1
ASGNI4
LABELV $273
ADDRLP4 0
INDIRI4
RETI4
LABELV $270
endproc Q_stricmp 8 12
export Q_strlwr
proc Q_strlwr 12 4
line 770
;767:}
;768:
;769:
;770:char *Q_strlwr( char *s1 ) {
line 773
;771:    char	*s;
;772:
;773:    s = s1;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $276
JUMPV
LABELV $275
line 774
;774:	while ( *s ) {
line 775
;775:		*s = tolower(*s);
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 8
ADDRGP4 tolower
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
CVII1 4
ASGNI1
line 776
;776:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 777
;777:	}
LABELV $276
line 774
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $275
line 778
;778:    return s1;
ADDRFP4 0
INDIRP4
RETP4
LABELV $274
endproc Q_strlwr 12 4
export Q_strupr
proc Q_strupr 12 4
line 781
;779:}
;780:
;781:char *Q_strupr( char *s1 ) {
line 784
;782:    char	*s;
;783:
;784:    s = s1;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $280
JUMPV
LABELV $279
line 785
;785:	while ( *s ) {
line 786
;786:		*s = toupper(*s);
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 8
ADDRGP4 toupper
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
CVII1 4
ASGNI1
line 787
;787:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 788
;788:	}
LABELV $280
line 785
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $279
line 789
;789:    return s1;
ADDRFP4 0
INDIRP4
RETP4
LABELV $278
endproc Q_strupr 12 4
export Q_strcat
proc Q_strcat 12 12
line 794
;790:}
;791:
;792:
;793:// never goes past bounds or leaves without a terminating 0
;794:void Q_strcat( char *dest, int size, const char *src ) {
line 797
;795:	int		l1;
;796:
;797:	l1 = strlen( dest );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 798
;798:	if ( l1 >= size ) {
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRI4
LTI4 $283
line 799
;799:		Com_Error( ERR_FATAL, "Q_strcat: already overflowed" );
CNSTI4 0
ARGI4
ADDRGP4 $285
ARGP4
ADDRGP4 Com_Error
CALLV
pop
line 800
;800:	}
LABELV $283
line 801
;801:	Q_strncpyz( dest + l1, src, size - l1 );
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 802
;802:}
LABELV $282
endproc Q_strcat 12 12
export Q_PrintStrlen
proc Q_PrintStrlen 12 0
line 805
;803:
;804:
;805:int Q_PrintStrlen( const char *string ) {
line 809
;806:	int			len;
;807:	const char	*p;
;808:
;809:	if( !string ) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $287
line 810
;810:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $286
JUMPV
LABELV $287
line 813
;811:	}
;812:
;813:	len = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 814
;814:	p = string;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $290
JUMPV
LABELV $289
line 815
;815:	while( *p ) {
line 816
;816:		if( Q_IsColorString( p ) ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $292
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $292
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $292
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 94
EQI4 $292
line 817
;817:			p += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 818
;818:			continue;
ADDRGP4 $290
JUMPV
LABELV $292
line 820
;819:		}
;820:		p++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 821
;821:		len++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 822
;822:	}
LABELV $290
line 815
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $289
line 824
;823:
;824:	return len;
ADDRLP4 4
INDIRI4
RETI4
LABELV $286
endproc Q_PrintStrlen 12 0
export Q_CleanStr
proc Q_CleanStr 20 0
line 828
;825:}
;826:
;827:
;828:char *Q_CleanStr( char *string ) {
line 833
;829:	char*	d;
;830:	char*	s;
;831:	int		c;
;832:
;833:	s = string;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 834
;834:	d = string;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $296
JUMPV
LABELV $295
line 835
;835:	while ((c = *s) != 0 ) {
line 836
;836:		if ( Q_IsColorString( s ) ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $298
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $298
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $298
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 94
EQI4 $298
line 837
;837:			s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 838
;838:		}		
ADDRGP4 $299
JUMPV
LABELV $298
line 843
;839:		// JUHOX: accept more characters as we have an extended charset now
;840:#if 0
;841:		else if ( c >= 0x20 && c <= 0x7E ) {
;842:#else
;843:		else if ((c & 255) >= 32) {
ADDRLP4 4
INDIRI4
CNSTI4 255
BANDI4
CNSTI4 32
LTI4 $300
line 845
;844:#endif
;845:			*d++ = c;
ADDRLP4 16
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 16
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 4
INDIRI4
CVII1 4
ASGNI1
line 846
;846:		}
LABELV $300
LABELV $299
line 847
;847:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 848
;848:	}
LABELV $296
line 835
ADDRLP4 12
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $295
line 849
;849:	*d = '\0';
ADDRLP4 8
INDIRP4
CNSTI1 0
ASGNI1
line 851
;850:
;851:	return string;
ADDRFP4 0
INDIRP4
RETP4
LABELV $294
endproc Q_CleanStr 20 0
export Com_sprintf
proc Com_sprintf 32012 12
line 855
;852:}
;853:
;854:
;855:void QDECL Com_sprintf( char *dest, int size, const char *fmt, ...) {
line 860
;856:	int		len;
;857:	va_list		argptr;
;858:	char	bigbuffer[32000];	// big, but small enough to fit in PPC stack
;859:
;860:	va_start (argptr,fmt);
ADDRLP4 4
ADDRFP4 8+4
ASGNP4
line 861
;861:	len = vsprintf (bigbuffer,fmt,argptr);
ADDRLP4 8
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 32008
ADDRGP4 vsprintf
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 32008
INDIRI4
ASGNI4
line 862
;862:	va_end (argptr);
ADDRLP4 4
CNSTP4 0
ASGNP4
line 863
;863:	if ( len >= sizeof( bigbuffer ) ) {
ADDRLP4 0
INDIRI4
CVIU4 4
CNSTU4 32000
LTU4 $304
line 864
;864:		Com_Error( ERR_FATAL, "Com_sprintf: overflowed bigbuffer" );
CNSTI4 0
ARGI4
ADDRGP4 $306
ARGP4
ADDRGP4 Com_Error
CALLV
pop
line 865
;865:	}
LABELV $304
line 866
;866:	if (len >= size) {
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRI4
LTI4 $307
line 867
;867:		Com_Printf ("Com_sprintf: overflow of %i in %i\n", len, size);
ADDRGP4 $309
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 873
;868:#ifdef	_DEBUG
;869:		__asm {
;870:			int 3;
;871:		}
;872:#endif
;873:	}
LABELV $307
line 874
;874:	Q_strncpyz (dest, bigbuffer, size );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 875
;875:}
LABELV $302
endproc Com_sprintf 32012 12
bss
align 1
LABELV $311
skip 64000
data
align 4
LABELV $312
byte 4 0
export va
code
proc va 12 12
line 887
;876:
;877:
;878:/*
;879:============
;880:va
;881:
;882:does a varargs printf into a temp buffer, so I don't need to have
;883:varargs versions of all text functions.
;884:FIXME: make this buffer size safe someday
;885:============
;886:*/
;887:char	* QDECL va( char *format, ... ) {
line 893
;888:	va_list		argptr;
;889:	static char		string[2][32000];	// in case va is called by nested functions
;890:	static int		index = 0;
;891:	char	*buf;
;892:
;893:	buf = string[index & 1];
ADDRLP4 4
ADDRGP4 $312
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 32000
MULI4
ADDRGP4 $311
ADDP4
ASGNP4
line 894
;894:	index++;
ADDRLP4 8
ADDRGP4 $312
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 896
;895:
;896:	va_start (argptr, format);
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 897
;897:	vsprintf (buf, format,argptr);
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 vsprintf
CALLI4
pop
line 898
;898:	va_end (argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 900
;899:
;900:	return buf;
ADDRLP4 4
INDIRP4
RETP4
LABELV $310
endproc va 12 12
bss
align 1
LABELV $315
skip 16384
data
align 4
LABELV $316
byte 4 0
export Info_ValueForKey
code
proc Info_ValueForKey 8212 8
line 921
;901:}
;902:
;903:
;904:/*
;905:=====================================================================
;906:
;907:  INFO STRINGS
;908:
;909:=====================================================================
;910:*/
;911:
;912:/*
;913:===============
;914:Info_ValueForKey
;915:
;916:Searches the string for the given
;917:key and returns the associated value, or an empty string.
;918:FIXME: overflow check?
;919:===============
;920:*/
;921:char *Info_ValueForKey( const char *s, const char *key ) {
line 928
;922:	char	pkey[BIG_INFO_KEY];
;923:	static	char value[2][BIG_INFO_VALUE];	// use two buffers so compares
;924:											// work without stomping on each other
;925:	static	int	valueindex = 0;
;926:	char	*o;
;927:	
;928:	if ( !s || !key ) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $319
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $317
LABELV $319
line 929
;929:		return "";
ADDRGP4 $320
RETP4
ADDRGP4 $314
JUMPV
LABELV $317
line 932
;930:	}
;931:
;932:	if ( strlen( s ) >= BIG_INFO_STRING ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8196
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8196
INDIRI4
CNSTI4 8192
LTI4 $321
line 933
;933:		Com_Error( ERR_DROP, "Info_ValueForKey: oversize infostring" );
CNSTI4 1
ARGI4
ADDRGP4 $323
ARGP4
ADDRGP4 Com_Error
CALLV
pop
line 934
;934:	}
LABELV $321
line 936
;935:
;936:	valueindex ^= 1;
ADDRLP4 8200
ADDRGP4 $316
ASGNP4
ADDRLP4 8200
INDIRP4
ADDRLP4 8200
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 937
;937:	if (*s == '\\')
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 92
NEI4 $327
line 938
;938:		s++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRGP4 $327
JUMPV
LABELV $326
line 940
;939:	while (1)
;940:	{
line 941
;941:		o = pkey;
ADDRLP4 0
ADDRLP4 4
ASGNP4
ADDRGP4 $330
JUMPV
LABELV $329
line 943
;942:		while (*s != '\\')
;943:		{
line 944
;944:			if (!*s)
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $332
line 945
;945:				return "";
ADDRGP4 $320
RETP4
ADDRGP4 $314
JUMPV
LABELV $332
line 946
;946:			*o++ = *s++;
ADDRLP4 8204
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 8204
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 8208
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 8208
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 8204
INDIRP4
ADDRLP4 8208
INDIRP4
INDIRI1
ASGNI1
line 947
;947:		}
LABELV $330
line 942
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 92
NEI4 $329
line 948
;948:		*o = 0;
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 949
;949:		s++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 951
;950:
;951:		o = value[valueindex];
ADDRLP4 0
ADDRGP4 $316
INDIRI4
CNSTI4 13
LSHI4
ADDRGP4 $315
ADDP4
ASGNP4
ADDRGP4 $335
JUMPV
LABELV $334
line 954
;952:
;953:		while (*s != '\\' && *s)
;954:		{
line 955
;955:			*o++ = *s++;
ADDRLP4 8204
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 8204
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 8208
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 8208
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 8204
INDIRP4
ADDRLP4 8208
INDIRP4
INDIRI1
ASGNI1
line 956
;956:		}
LABELV $335
line 953
ADDRLP4 8204
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 8204
INDIRI4
CNSTI4 92
EQI4 $337
ADDRLP4 8204
INDIRI4
CNSTI4 0
NEI4 $334
LABELV $337
line 957
;957:		*o = 0;
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 959
;958:
;959:		if (!Q_stricmp (key, pkey) )
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 8208
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8208
INDIRI4
CNSTI4 0
NEI4 $338
line 960
;960:			return value[valueindex];
ADDRGP4 $316
INDIRI4
CNSTI4 13
LSHI4
ADDRGP4 $315
ADDP4
RETP4
ADDRGP4 $314
JUMPV
LABELV $338
line 962
;961:
;962:		if (!*s)
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $340
line 963
;963:			break;
ADDRGP4 $328
JUMPV
LABELV $340
line 964
;964:		s++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 965
;965:	}
LABELV $327
line 939
ADDRGP4 $326
JUMPV
LABELV $328
line 967
;966:
;967:	return "";
ADDRGP4 $320
RETP4
LABELV $314
endproc Info_ValueForKey 8212 8
export Info_NextPair
proc Info_NextPair 16 0
line 978
;968:}
;969:
;970:
;971:/*
;972:===================
;973:Info_NextPair
;974:
;975:Used to itterate through all the key/value pairs in an info string
;976:===================
;977:*/
;978:void Info_NextPair( const char **head, char *key, char *value ) {
line 982
;979:	char	*o;
;980:	const char	*s;
;981:
;982:	s = *head;
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRP4
ASGNP4
line 984
;983:
;984:	if ( *s == '\\' ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 92
NEI4 $343
line 985
;985:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 986
;986:	}
LABELV $343
line 987
;987:	key[0] = 0;
ADDRFP4 4
INDIRP4
CNSTI1 0
ASGNI1
line 988
;988:	value[0] = 0;
ADDRFP4 8
INDIRP4
CNSTI1 0
ASGNI1
line 990
;989:
;990:	o = key;
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
ADDRGP4 $346
JUMPV
LABELV $345
line 991
;991:	while ( *s != '\\' ) {
line 992
;992:		if ( !*s ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $348
line 993
;993:			*o = 0;
ADDRLP4 4
INDIRP4
CNSTI1 0
ASGNI1
line 994
;994:			*head = s;
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRP4
ASGNP4
line 995
;995:			return;
ADDRGP4 $342
JUMPV
LABELV $348
line 997
;996:		}
;997:		*o++ = *s++;
ADDRLP4 8
ADDRLP4 4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 12
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI1
ASGNI1
line 998
;998:	}
LABELV $346
line 991
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 92
NEI4 $345
line 999
;999:	*o = 0;
ADDRLP4 4
INDIRP4
CNSTI1 0
ASGNI1
line 1000
;1000:	s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1002
;1001:
;1002:	o = value;
ADDRLP4 4
ADDRFP4 8
INDIRP4
ASGNP4
ADDRGP4 $351
JUMPV
LABELV $350
line 1003
;1003:	while ( *s != '\\' && *s ) {
line 1004
;1004:		*o++ = *s++;
ADDRLP4 8
ADDRLP4 4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 12
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI1
ASGNI1
line 1005
;1005:	}
LABELV $351
line 1003
ADDRLP4 8
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 92
EQI4 $353
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $350
LABELV $353
line 1006
;1006:	*o = 0;
ADDRLP4 4
INDIRP4
CNSTI1 0
ASGNI1
line 1008
;1007:
;1008:	*head = s;
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRP4
ASGNP4
line 1009
;1009:}
LABELV $342
endproc Info_NextPair 16 0
export Info_RemoveKey
proc Info_RemoveKey 2072 8
line 1017
;1010:
;1011:
;1012:/*
;1013:===================
;1014:Info_RemoveKey
;1015:===================
;1016:*/
;1017:void Info_RemoveKey( char *s, const char *key ) {
line 1023
;1018:	char	*start;
;1019:	char	pkey[MAX_INFO_KEY];
;1020:	char	value[MAX_INFO_VALUE];
;1021:	char	*o;
;1022:
;1023:	if ( strlen( s ) >= MAX_INFO_STRING ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 2056
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 2056
INDIRI4
CNSTI4 1024
LTI4 $355
line 1024
;1024:		Com_Error( ERR_DROP, "Info_RemoveKey: oversize infostring" );
CNSTI4 1
ARGI4
ADDRGP4 $357
ARGP4
ADDRGP4 Com_Error
CALLV
pop
line 1025
;1025:	}
LABELV $355
line 1027
;1026:
;1027:	if (strchr (key, '\\')) {
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 92
ARGI4
ADDRLP4 2060
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 2060
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $361
line 1028
;1028:		return;
ADDRGP4 $354
JUMPV
LABELV $360
line 1032
;1029:	}
;1030:
;1031:	while (1)
;1032:	{
line 1033
;1033:		start = s;
ADDRLP4 1028
ADDRFP4 0
INDIRP4
ASGNP4
line 1034
;1034:		if (*s == '\\')
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 92
NEI4 $363
line 1035
;1035:			s++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $363
line 1036
;1036:		o = pkey;
ADDRLP4 0
ADDRLP4 4
ASGNP4
ADDRGP4 $366
JUMPV
LABELV $365
line 1038
;1037:		while (*s != '\\')
;1038:		{
line 1039
;1039:			if (!*s)
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $368
line 1040
;1040:				return;
ADDRGP4 $354
JUMPV
LABELV $368
line 1041
;1041:			*o++ = *s++;
ADDRLP4 2064
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 2064
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 2068
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 2068
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 2064
INDIRP4
ADDRLP4 2068
INDIRP4
INDIRI1
ASGNI1
line 1042
;1042:		}
LABELV $366
line 1037
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 92
NEI4 $365
line 1043
;1043:		*o = 0;
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 1044
;1044:		s++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1046
;1045:
;1046:		o = value;
ADDRLP4 0
ADDRLP4 1032
ASGNP4
ADDRGP4 $371
JUMPV
LABELV $370
line 1048
;1047:		while (*s != '\\' && *s)
;1048:		{
line 1049
;1049:			if (!*s)
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $373
line 1050
;1050:				return;
ADDRGP4 $354
JUMPV
LABELV $373
line 1051
;1051:			*o++ = *s++;
ADDRLP4 2064
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 2064
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 2068
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 2068
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 2064
INDIRP4
ADDRLP4 2068
INDIRP4
INDIRI1
ASGNI1
line 1052
;1052:		}
LABELV $371
line 1047
ADDRLP4 2064
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 2064
INDIRI4
CNSTI4 92
EQI4 $375
ADDRLP4 2064
INDIRI4
CNSTI4 0
NEI4 $370
LABELV $375
line 1053
;1053:		*o = 0;
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 1055
;1054:
;1055:		if (!strcmp (key, pkey) )
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 2068
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 2068
INDIRI4
CNSTI4 0
NEI4 $376
line 1056
;1056:		{
line 1057
;1057:			strcpy (start, s);	// remove this part
ADDRLP4 1028
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1058
;1058:			return;
ADDRGP4 $354
JUMPV
LABELV $376
line 1061
;1059:		}
;1060:
;1061:		if (!*s)
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $378
line 1062
;1062:			return;
ADDRGP4 $354
JUMPV
LABELV $378
line 1063
;1063:	}
LABELV $361
line 1031
ADDRGP4 $360
JUMPV
line 1065
;1064:
;1065:}
LABELV $354
endproc Info_RemoveKey 2072 8
export Info_RemoveKey_Big
proc Info_RemoveKey_Big 16408 8
line 1072
;1066:
;1067:/*
;1068:===================
;1069:Info_RemoveKey_Big
;1070:===================
;1071:*/
;1072:void Info_RemoveKey_Big( char *s, const char *key ) {
line 1078
;1073:	char	*start;
;1074:	char	pkey[BIG_INFO_KEY];
;1075:	char	value[BIG_INFO_VALUE];
;1076:	char	*o;
;1077:
;1078:	if ( strlen( s ) >= BIG_INFO_STRING ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16392
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 16392
INDIRI4
CNSTI4 8192
LTI4 $381
line 1079
;1079:		Com_Error( ERR_DROP, "Info_RemoveKey_Big: oversize infostring" );
CNSTI4 1
ARGI4
ADDRGP4 $383
ARGP4
ADDRGP4 Com_Error
CALLV
pop
line 1080
;1080:	}
LABELV $381
line 1082
;1081:
;1082:	if (strchr (key, '\\')) {
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 92
ARGI4
ADDRLP4 16396
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 16396
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $387
line 1083
;1083:		return;
ADDRGP4 $380
JUMPV
LABELV $386
line 1087
;1084:	}
;1085:
;1086:	while (1)
;1087:	{
line 1088
;1088:		start = s;
ADDRLP4 8196
ADDRFP4 0
INDIRP4
ASGNP4
line 1089
;1089:		if (*s == '\\')
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 92
NEI4 $389
line 1090
;1090:			s++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $389
line 1091
;1091:		o = pkey;
ADDRLP4 0
ADDRLP4 4
ASGNP4
ADDRGP4 $392
JUMPV
LABELV $391
line 1093
;1092:		while (*s != '\\')
;1093:		{
line 1094
;1094:			if (!*s)
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $394
line 1095
;1095:				return;
ADDRGP4 $380
JUMPV
LABELV $394
line 1096
;1096:			*o++ = *s++;
ADDRLP4 16400
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 16400
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 16404
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 16404
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 16400
INDIRP4
ADDRLP4 16404
INDIRP4
INDIRI1
ASGNI1
line 1097
;1097:		}
LABELV $392
line 1092
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 92
NEI4 $391
line 1098
;1098:		*o = 0;
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 1099
;1099:		s++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1101
;1100:
;1101:		o = value;
ADDRLP4 0
ADDRLP4 8200
ASGNP4
ADDRGP4 $397
JUMPV
LABELV $396
line 1103
;1102:		while (*s != '\\' && *s)
;1103:		{
line 1104
;1104:			if (!*s)
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $399
line 1105
;1105:				return;
ADDRGP4 $380
JUMPV
LABELV $399
line 1106
;1106:			*o++ = *s++;
ADDRLP4 16400
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 16400
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 16404
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 16404
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 16400
INDIRP4
ADDRLP4 16404
INDIRP4
INDIRI1
ASGNI1
line 1107
;1107:		}
LABELV $397
line 1102
ADDRLP4 16400
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 16400
INDIRI4
CNSTI4 92
EQI4 $401
ADDRLP4 16400
INDIRI4
CNSTI4 0
NEI4 $396
LABELV $401
line 1108
;1108:		*o = 0;
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 1110
;1109:
;1110:		if (!strcmp (key, pkey) )
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 16404
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 16404
INDIRI4
CNSTI4 0
NEI4 $402
line 1111
;1111:		{
line 1112
;1112:			strcpy (start, s);	// remove this part
ADDRLP4 8196
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1113
;1113:			return;
ADDRGP4 $380
JUMPV
LABELV $402
line 1116
;1114:		}
;1115:
;1116:		if (!*s)
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $404
line 1117
;1117:			return;
ADDRGP4 $380
JUMPV
LABELV $404
line 1118
;1118:	}
LABELV $387
line 1086
ADDRGP4 $386
JUMPV
line 1120
;1119:
;1120:}
LABELV $380
endproc Info_RemoveKey_Big 16408 8
export Info_Validate
proc Info_Validate 8 8
line 1133
;1121:
;1122:
;1123:
;1124:
;1125:/*
;1126:==================
;1127:Info_Validate
;1128:
;1129:Some characters are illegal in info strings because they
;1130:can mess up the server's parsing
;1131:==================
;1132:*/
;1133:qboolean Info_Validate( const char *s ) {
line 1134
;1134:	if ( strchr( s, '\"' ) ) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 34
ARGI4
ADDRLP4 0
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $407
line 1135
;1135:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $406
JUMPV
LABELV $407
line 1137
;1136:	}
;1137:	if ( strchr( s, ';' ) ) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 59
ARGI4
ADDRLP4 4
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $409
line 1138
;1138:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $406
JUMPV
LABELV $409
line 1140
;1139:	}
;1140:	return qtrue;
CNSTI4 1
RETI4
LABELV $406
endproc Info_Validate 8 8
export Info_SetValueForKey
proc Info_SetValueForKey 1068 20
line 1150
;1141:}
;1142:
;1143:/*
;1144:==================
;1145:Info_SetValueForKey
;1146:
;1147:Changes or adds a key/value pair
;1148:==================
;1149:*/
;1150:void Info_SetValueForKey( char *s, const char *key, const char *value ) {
line 1153
;1151:	char	newi[MAX_INFO_STRING];
;1152:
;1153:	if ( strlen( s ) >= MAX_INFO_STRING ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1024
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1024
INDIRI4
CNSTI4 1024
LTI4 $412
line 1154
;1154:		Com_Error( ERR_DROP, "Info_SetValueForKey: oversize infostring" );
CNSTI4 1
ARGI4
ADDRGP4 $414
ARGP4
ADDRGP4 Com_Error
CALLV
pop
line 1155
;1155:	}
LABELV $412
line 1157
;1156:
;1157:	if (strchr (key, '\\') || strchr (value, '\\'))
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 92
ARGI4
ADDRLP4 1028
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 1028
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $417
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 92
ARGI4
ADDRLP4 1032
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 1032
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $415
LABELV $417
line 1158
;1158:	{
line 1159
;1159:		Com_Printf ("Can't use keys or values with a \\\n");
ADDRGP4 $418
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1160
;1160:		return;
ADDRGP4 $411
JUMPV
LABELV $415
line 1163
;1161:	}
;1162:
;1163:	if (strchr (key, ';') || strchr (value, ';'))
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 59
ARGI4
ADDRLP4 1036
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 1036
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $421
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 59
ARGI4
ADDRLP4 1040
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 1040
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $419
LABELV $421
line 1164
;1164:	{
line 1165
;1165:		Com_Printf ("Can't use keys or values with a semicolon\n");
ADDRGP4 $422
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1166
;1166:		return;
ADDRGP4 $411
JUMPV
LABELV $419
line 1169
;1167:	}
;1168:
;1169:	if (strchr (key, '\"') || strchr (value, '\"'))
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 34
ARGI4
ADDRLP4 1044
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 1044
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $425
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 34
ARGI4
ADDRLP4 1048
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 1048
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $423
LABELV $425
line 1170
;1170:	{
line 1171
;1171:		Com_Printf ("Can't use keys or values with a \"\n");
ADDRGP4 $426
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1172
;1172:		return;
ADDRGP4 $411
JUMPV
LABELV $423
line 1175
;1173:	}
;1174:
;1175:	Info_RemoveKey (s, key);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Info_RemoveKey
CALLV
pop
line 1176
;1176:	if (!value || !strlen(value))
ADDRLP4 1052
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 1052
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $429
ADDRLP4 1052
INDIRP4
ARGP4
ADDRLP4 1056
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
NEI4 $427
LABELV $429
line 1177
;1177:		return;
ADDRGP4 $411
JUMPV
LABELV $427
line 1179
;1178:
;1179:	Com_sprintf (newi, sizeof(newi), "\\%s\\%s", key, value);
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $430
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1181
;1180:
;1181:	if (strlen(newi) + strlen(s) > MAX_INFO_STRING)
ADDRLP4 0
ARGP4
ADDRLP4 1060
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1064
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1060
INDIRI4
ADDRLP4 1064
INDIRI4
ADDI4
CNSTI4 1024
LEI4 $431
line 1182
;1182:	{
line 1183
;1183:		Com_Printf ("Info string length exceeded\n");
ADDRGP4 $433
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1184
;1184:		return;
ADDRGP4 $411
JUMPV
LABELV $431
line 1187
;1185:	}
;1186:
;1187:	strcat (newi, s);
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 1188
;1188:	strcpy (s, newi);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1189
;1189:}
LABELV $411
endproc Info_SetValueForKey 1068 20
export Info_SetValueForKey_Big
proc Info_SetValueForKey_Big 8236 20
line 1198
;1190:
;1191:/*
;1192:==================
;1193:Info_SetValueForKey_Big
;1194:
;1195:Changes or adds a key/value pair
;1196:==================
;1197:*/
;1198:void Info_SetValueForKey_Big( char *s, const char *key, const char *value ) {
line 1201
;1199:	char	newi[BIG_INFO_STRING];
;1200:
;1201:	if ( strlen( s ) >= BIG_INFO_STRING ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8192
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8192
INDIRI4
CNSTI4 8192
LTI4 $435
line 1202
;1202:		Com_Error( ERR_DROP, "Info_SetValueForKey: oversize infostring" );
CNSTI4 1
ARGI4
ADDRGP4 $414
ARGP4
ADDRGP4 Com_Error
CALLV
pop
line 1203
;1203:	}
LABELV $435
line 1205
;1204:
;1205:	if (strchr (key, '\\') || strchr (value, '\\'))
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 92
ARGI4
ADDRLP4 8196
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 8196
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $439
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 92
ARGI4
ADDRLP4 8200
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 8200
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $437
LABELV $439
line 1206
;1206:	{
line 1207
;1207:		Com_Printf ("Can't use keys or values with a \\\n");
ADDRGP4 $418
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1208
;1208:		return;
ADDRGP4 $434
JUMPV
LABELV $437
line 1211
;1209:	}
;1210:
;1211:	if (strchr (key, ';') || strchr (value, ';'))
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 59
ARGI4
ADDRLP4 8204
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 8204
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $442
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 59
ARGI4
ADDRLP4 8208
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 8208
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $440
LABELV $442
line 1212
;1212:	{
line 1213
;1213:		Com_Printf ("Can't use keys or values with a semicolon\n");
ADDRGP4 $422
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1214
;1214:		return;
ADDRGP4 $434
JUMPV
LABELV $440
line 1217
;1215:	}
;1216:
;1217:	if (strchr (key, '\"') || strchr (value, '\"'))
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 34
ARGI4
ADDRLP4 8212
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 8212
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $445
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 34
ARGI4
ADDRLP4 8216
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 8216
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $443
LABELV $445
line 1218
;1218:	{
line 1219
;1219:		Com_Printf ("Can't use keys or values with a \"\n");
ADDRGP4 $426
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1220
;1220:		return;
ADDRGP4 $434
JUMPV
LABELV $443
line 1223
;1221:	}
;1222:
;1223:	Info_RemoveKey_Big (s, key);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Info_RemoveKey_Big
CALLV
pop
line 1224
;1224:	if (!value || !strlen(value))
ADDRLP4 8220
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 8220
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $448
ADDRLP4 8220
INDIRP4
ARGP4
ADDRLP4 8224
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8224
INDIRI4
CNSTI4 0
NEI4 $446
LABELV $448
line 1225
;1225:		return;
ADDRGP4 $434
JUMPV
LABELV $446
line 1227
;1226:
;1227:	Com_sprintf (newi, sizeof(newi), "\\%s\\%s", key, value);
ADDRLP4 0
ARGP4
CNSTI4 8192
ARGI4
ADDRGP4 $430
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1229
;1228:
;1229:	if (strlen(newi) + strlen(s) > BIG_INFO_STRING)
ADDRLP4 0
ARGP4
ADDRLP4 8228
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8232
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8228
INDIRI4
ADDRLP4 8232
INDIRI4
ADDI4
CNSTI4 8192
LEI4 $449
line 1230
;1230:	{
line 1231
;1231:		Com_Printf ("BIG Info string length exceeded\n");
ADDRGP4 $451
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1232
;1232:		return;
ADDRGP4 $434
JUMPV
LABELV $449
line 1235
;1233:	}
;1234:
;1235:	strcat (s, newi);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 1236
;1236:}
LABELV $434
endproc Info_SetValueForKey_Big 8236 20
bss
align 4
LABELV com_lines
skip 4
align 1
LABELV com_parsename
skip 1024
align 1
LABELV com_token
skip 1024
import Com_Printf
import Com_Error
import Info_RemoveKey_big
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
LABELV $451
byte 1 66
byte 1 73
byte 1 71
byte 1 32
byte 1 73
byte 1 110
byte 1 102
byte 1 111
byte 1 32
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 108
byte 1 101
byte 1 110
byte 1 103
byte 1 116
byte 1 104
byte 1 32
byte 1 101
byte 1 120
byte 1 99
byte 1 101
byte 1 101
byte 1 100
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $433
byte 1 73
byte 1 110
byte 1 102
byte 1 111
byte 1 32
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 108
byte 1 101
byte 1 110
byte 1 103
byte 1 116
byte 1 104
byte 1 32
byte 1 101
byte 1 120
byte 1 99
byte 1 101
byte 1 101
byte 1 100
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $430
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $426
byte 1 67
byte 1 97
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 115
byte 1 32
byte 1 111
byte 1 114
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 115
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 97
byte 1 32
byte 1 34
byte 1 10
byte 1 0
align 1
LABELV $422
byte 1 67
byte 1 97
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 115
byte 1 32
byte 1 111
byte 1 114
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 115
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 97
byte 1 32
byte 1 115
byte 1 101
byte 1 109
byte 1 105
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $418
byte 1 67
byte 1 97
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 115
byte 1 32
byte 1 111
byte 1 114
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 115
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 97
byte 1 32
byte 1 92
byte 1 10
byte 1 0
align 1
LABELV $414
byte 1 73
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 83
byte 1 101
byte 1 116
byte 1 86
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 70
byte 1 111
byte 1 114
byte 1 75
byte 1 101
byte 1 121
byte 1 58
byte 1 32
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $383
byte 1 73
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 82
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 75
byte 1 101
byte 1 121
byte 1 95
byte 1 66
byte 1 105
byte 1 103
byte 1 58
byte 1 32
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $357
byte 1 73
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 82
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 75
byte 1 101
byte 1 121
byte 1 58
byte 1 32
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $323
byte 1 73
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 86
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 70
byte 1 111
byte 1 114
byte 1 75
byte 1 101
byte 1 121
byte 1 58
byte 1 32
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $320
byte 1 0
align 1
LABELV $309
byte 1 67
byte 1 111
byte 1 109
byte 1 95
byte 1 115
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 102
byte 1 58
byte 1 32
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 102
byte 1 108
byte 1 111
byte 1 119
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $306
byte 1 67
byte 1 111
byte 1 109
byte 1 95
byte 1 115
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 102
byte 1 58
byte 1 32
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 102
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 105
byte 1 103
byte 1 98
byte 1 117
byte 1 102
byte 1 102
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $285
byte 1 81
byte 1 95
byte 1 115
byte 1 116
byte 1 114
byte 1 99
byte 1 97
byte 1 116
byte 1 58
byte 1 32
byte 1 97
byte 1 108
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 121
byte 1 32
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 102
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $235
byte 1 81
byte 1 95
byte 1 115
byte 1 116
byte 1 114
byte 1 110
byte 1 99
byte 1 112
byte 1 121
byte 1 122
byte 1 58
byte 1 32
byte 1 100
byte 1 101
byte 1 115
byte 1 116
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 32
byte 1 60
byte 1 32
byte 1 49
byte 1 0
align 1
LABELV $232
byte 1 81
byte 1 95
byte 1 115
byte 1 116
byte 1 114
byte 1 110
byte 1 99
byte 1 112
byte 1 121
byte 1 122
byte 1 58
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 32
byte 1 115
byte 1 114
byte 1 99
byte 1 0
align 1
LABELV $229
byte 1 81
byte 1 95
byte 1 115
byte 1 116
byte 1 114
byte 1 110
byte 1 99
byte 1 112
byte 1 121
byte 1 122
byte 1 58
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 32
byte 1 100
byte 1 101
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $193
byte 1 41
byte 1 0
align 1
LABELV $188
byte 1 40
byte 1 0
align 1
LABELV $169
byte 1 77
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 84
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 33
byte 1 61
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $75
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 108
byte 1 105
byte 1 110
byte 1 101
byte 1 32
byte 1 37
byte 1 100
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $71
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 108
byte 1 105
byte 1 110
byte 1 101
byte 1 32
byte 1 37
byte 1 100
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $65
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $45
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 0
