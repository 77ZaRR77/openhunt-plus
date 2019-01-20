code
proc ReadByte 8 12
file "..\..\..\..\code\cgame\cg_playlist.c"
line 58
;1://
;2:// JUHOX: cg_playlist.c
;3://
;4:
;5:#include "cg_local.h"
;6:
;7:
;8:
;9:#if PLAYLIST
;10:typedef struct {
;11:	unsigned long id;
;12:	unsigned long size;
;13:} chunkHeader_t;
;14:
;15:typedef struct {
;16:	short wFormatTag;
;17:	unsigned short wChannels;
;18:	unsigned long dwSamplesPerSec;
;19:	unsigned long dwAvgBytesPerSec;
;20:	unsigned short wBlockAlign;
;21:	unsigned short wBitsPerSample;
;22:} formatChunk_t;
;23:
;24:typedef struct {
;25:	char introPart[128];	// complete path
;26:	char mainPart[128];		// complete path
;27:	long duration;			// milliseconds, -1 = infinite, 0 = skip this entry
;28:} playListEntry_t;
;29:
;30:
;31:
;32:#define BUFFER_SIZE 4096
;33:
;34:static fileHandle_t file;
;35:static int fileSize;
;36:static int bufPos;
;37:static int bufLen;
;38:static unsigned char buffer[BUFFER_SIZE];
;39:
;40:static qboolean running;
;41:static playListEntry_t playList[MAX_PLAYLIST_ENTRIES];
;42:static int numEntries;
;43:static int currentEntry;
;44:static int stopEntryTime;
;45:static int startEntryTime;
;46:#endif
;47:
;48:
;49:
;50:/*
;51:===============
;52:ReadByte
;53:
;54:return -1 for EOF
;55:===============
;56:*/
;57:#if PLAYLIST
;58:static int ReadByte(void) {
line 59
;59:	if (bufPos >= bufLen) {
ADDRGP4 bufPos
INDIRI4
ADDRGP4 bufLen
INDIRI4
LTI4 $128
line 60
;60:		if (fileSize <= 0) return -1;
ADDRGP4 fileSize
INDIRI4
CNSTI4 0
GTI4 $130
CNSTI4 -1
RETI4
ADDRGP4 $127
JUMPV
LABELV $130
line 62
;61:
;62:		bufLen = fileSize;
ADDRGP4 bufLen
ADDRGP4 fileSize
INDIRI4
ASGNI4
line 63
;63:		if (bufLen > BUFFER_SIZE) bufLen = BUFFER_SIZE;
ADDRGP4 bufLen
INDIRI4
CNSTI4 4096
LEI4 $132
ADDRGP4 bufLen
CNSTI4 4096
ASGNI4
LABELV $132
line 64
;64:		trap_FS_Read(buffer, bufLen, file);
ADDRGP4 buffer
ARGP4
ADDRGP4 bufLen
INDIRI4
ARGI4
ADDRGP4 file
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 65
;65:		fileSize -= bufLen;
ADDRLP4 0
ADDRGP4 fileSize
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 bufLen
INDIRI4
SUBI4
ASGNI4
line 66
;66:		bufPos = 0;
ADDRGP4 bufPos
CNSTI4 0
ASGNI4
line 67
;67:	}
LABELV $128
line 69
;68:
;69:	return buffer[bufPos++];
ADDRLP4 4
ADDRGP4 bufPos
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRGP4 buffer
ADDP4
INDIRU1
CVUI4 1
RETI4
LABELV $127
endproc ReadByte 8 12
proc BytesLeft 0 0
line 79
;70:}
;71:#endif
;72:
;73:/*
;74:===============
;75:BytesLeft
;76:===============
;77:*/
;78:#if PLAYLIST
;79:static int BytesLeft(void) {
line 80
;80:	return fileSize + bufLen - bufPos;
ADDRGP4 fileSize
INDIRI4
ADDRGP4 bufLen
INDIRI4
ADDI4
ADDRGP4 bufPos
INDIRI4
SUBI4
RETI4
LABELV $134
endproc BytesLeft 0 0
proc ReadDWORD 24 0
line 90
;81:}
;82:#endif
;83:
;84:/*
;85:===============
;86:ReadDWORD
;87:===============
;88:*/
;89:#if PLAYLIST
;90:static qboolean ReadDWORD(void* dataBuf) {
line 93
;91:	unsigned long dword;
;92:
;93:	if (BytesLeft() < 4) return qfalse;
ADDRLP4 4
ADDRGP4 BytesLeft
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 4
GEI4 $136
CNSTI4 0
RETI4
ADDRGP4 $135
JUMPV
LABELV $136
line 95
;94:
;95:	dword = ReadByte();
ADDRLP4 8
ADDRGP4 ReadByte
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
CVIU4 4
ASGNU4
line 96
;96:	dword |= ReadByte() << 8;
ADDRLP4 12
ADDRGP4 ReadByte
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRU4
ADDRLP4 12
INDIRI4
CNSTI4 8
LSHI4
CVIU4 4
BORU4
ASGNU4
line 97
;97:	dword |= ReadByte() << 16;
ADDRLP4 16
ADDRGP4 ReadByte
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRU4
ADDRLP4 16
INDIRI4
CNSTI4 16
LSHI4
CVIU4 4
BORU4
ASGNU4
line 98
;98:	dword |= ReadByte() << 24;
ADDRLP4 20
ADDRGP4 ReadByte
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRU4
ADDRLP4 20
INDIRI4
CNSTI4 24
LSHI4
CVIU4 4
BORU4
ASGNU4
line 100
;99:
;100:	if (dataBuf) *((unsigned long*)dataBuf) = dword;
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $138
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRU4
ASGNU4
LABELV $138
line 101
;101:	return qtrue;
CNSTI4 1
RETI4
LABELV $135
endproc ReadDWORD 24 0
proc OpenWaveFile 20 12
line 111
;102:}
;103:#endif
;104:
;105:/*
;106:===============
;107:OpenWaveFile
;108:===============
;109:*/
;110:#if PLAYLIST
;111:static qboolean OpenWaveFile(const char* name) {
line 114
;112:	unsigned long id;
;113:
;114:	fileSize = trap_FS_FOpenFile(name, &file, FS_READ);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 file
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 4
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRGP4 fileSize
ADDRLP4 4
INDIRI4
ASGNI4
line 115
;115:	if (!file) {
ADDRGP4 file
INDIRI4
CNSTI4 0
NEI4 $141
line 116
;116:		CG_Printf("^3Couldn't open '%s'\n", name);
ADDRGP4 $143
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 117
;117:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $140
JUMPV
LABELV $141
line 120
;118:	}
;119:	
;120:	if (fileSize < 44) {
ADDRGP4 fileSize
INDIRI4
CNSTI4 44
GEI4 $144
LABELV $146
line 122
;121:		BadFile:
;122:		CG_Printf("^3Unknown file format: '%s'\n", name);
ADDRGP4 $147
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 123
;123:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $140
JUMPV
LABELV $144
line 126
;124:	}
;125:
;126:	bufPos = 0;
ADDRGP4 bufPos
CNSTI4 0
ASGNI4
line 127
;127:	bufLen = 0;
ADDRGP4 bufLen
CNSTI4 0
ASGNI4
line 129
;128:
;129:	if (!ReadDWORD(&id)) goto BadFile;
ADDRLP4 0
ARGP4
ADDRLP4 8
ADDRGP4 ReadDWORD
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $148
ADDRGP4 $146
JUMPV
LABELV $148
line 130
;130:	if (id != 0x46464952) goto BadFile;	// 'RIFF'
ADDRLP4 0
INDIRU4
CNSTU4 1179011410
EQU4 $150
ADDRGP4 $146
JUMPV
LABELV $150
line 132
;131:
;132:	if (!ReadDWORD(NULL)) goto BadFile;	// length
CNSTP4 0
ARGP4
ADDRLP4 12
ADDRGP4 ReadDWORD
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $152
ADDRGP4 $146
JUMPV
LABELV $152
line 134
;133:
;134:	if (!ReadDWORD(&id)) goto BadFile;
ADDRLP4 0
ARGP4
ADDRLP4 16
ADDRGP4 ReadDWORD
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $154
ADDRGP4 $146
JUMPV
LABELV $154
line 135
;135:	if (id != 0x45564157) goto BadFile;	// 'WAVE'
ADDRLP4 0
INDIRU4
CNSTU4 1163280727
EQU4 $156
ADDRGP4 $146
JUMPV
LABELV $156
line 137
;136:
;137:	return qtrue;
CNSTI4 1
RETI4
LABELV $140
endproc OpenWaveFile 20 12
proc SkipToEndOfFile 0 0
line 147
;138:}
;139:#endif
;140:
;141:/*
;142:===============
;143:SkipToEndOfFile
;144:===============
;145:*/
;146:#if PLAYLIST
;147:static void SkipToEndOfFile(void) {
line 148
;148:	fileSize = 0;
ADDRGP4 fileSize
CNSTI4 0
ASGNI4
line 149
;149:	bufPos = 0;
ADDRGP4 bufPos
CNSTI4 0
ASGNI4
line 150
;150:	bufLen = 0;
ADDRGP4 bufLen
CNSTI4 0
ASGNI4
line 151
;151:}
LABELV $158
endproc SkipToEndOfFile 0 0
proc ReadChunkHeader 8 4
line 160
;152:#endif
;153:
;154:/*
;155:===============
;156:ReadChunkHeader
;157:===============
;158:*/
;159:#if PLAYLIST
;160:static qboolean ReadChunkHeader(chunkHeader_t* header) {
line 161
;161:	if (!ReadDWORD(&header->id)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 ReadDWORD
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $160
LABELV $162
line 163
;162:		UnexpectedEOF:
;163:		CG_Printf("^3Unexpected end of file\n");
ADDRGP4 $163
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 164
;164:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $159
JUMPV
LABELV $160
line 166
;165:	}
;166:	if (!ReadDWORD(&header->size)) goto UnexpectedEOF;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 ReadDWORD
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $164
ADDRGP4 $162
JUMPV
LABELV $164
line 168
;167:
;168:	return qtrue;
CNSTI4 1
RETI4
LABELV $159
endproc ReadChunkHeader 8 4
proc ReadChunkData 16 0
line 180
;169:}
;170:#endif
;171:
;172:/*
;173:===============
;174:ReadChunkData
;175:
;176:returns the size of the data read into the buffer
;177:===============
;178:*/
;179:#if PLAYLIST
;180:static int ReadChunkData(int chunkSize, void* buffer, int bufferSize) {
line 184
;181:	unsigned char* bytes;
;182:	int count;
;183:
;184:	bytes = (unsigned char*) buffer;
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
line 185
;185:	count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 187
;186:
;187:	chunkSize = (chunkSize + 1) & ~1;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 -2
BANDI4
ASGNI4
ADDRGP4 $168
JUMPV
LABELV $167
line 189
;188:
;189:	while (chunkSize > 0) {
line 192
;190:		int byte;
;191:
;192:		byte = ReadByte();
ADDRLP4 12
ADDRGP4 ReadByte
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 193
;193:		if (byte < 0) break;
ADDRLP4 8
INDIRI4
CNSTI4 0
GEI4 $170
ADDRGP4 $169
JUMPV
LABELV $170
line 195
;194:
;195:		if (bufferSize > 0) {
ADDRFP4 8
INDIRI4
CNSTI4 0
LEI4 $172
line 196
;196:			*bytes = byte;
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 197
;197:			bytes++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 198
;198:			count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 199
;199:			bufferSize--;
ADDRFP4 8
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 200
;200:		}
LABELV $172
line 202
;201:
;202:		chunkSize--;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 203
;203:	}
LABELV $168
line 189
ADDRFP4 0
INDIRI4
CNSTI4 0
GTI4 $167
LABELV $169
line 204
;204:	return count;
ADDRLP4 4
INDIRI4
RETI4
LABELV $166
endproc ReadChunkData 16 0
proc MusicDuration 64 12
line 217
;205:}
;206:#endif
;207:
;208:/*
;209:===============
;210:MusicDuration
;211:
;212:returns the duration of the music file in milliseconds
;213:returns -1 in case of an error
;214:===============
;215:*/
;216:#if PLAYLIST
;217:static long MusicDuration(const char* fileName) {
line 222
;218:	long duration;
;219:	float bytesPerMillisecond;
;220:	long numBytes;
;221:
;222:	duration = -1;
ADDRLP4 8
CNSTI4 -1
ASGNI4
line 223
;223:	file = 0;
ADDRGP4 file
CNSTI4 0
ASGNI4
line 224
;224:	if (!OpenWaveFile(fileName)) goto Exit;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 OpenWaveFile
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $175
ADDRGP4 $177
JUMPV
LABELV $175
line 226
;225:
;226:	bytesPerMillisecond = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 227
;227:	numBytes = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $179
JUMPV
LABELV $178
line 229
;228:	
;229:	while (numBytes < 1 || bytesPerMillisecond < 1) {
line 232
;230:		chunkHeader_t header;
;231:		
;232:		if (!ReadChunkHeader(&header)) break;
ADDRLP4 16
ARGP4
ADDRLP4 24
ADDRGP4 ReadChunkHeader
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $181
ADDRGP4 $180
JUMPV
LABELV $181
line 234
;233:
;234:		switch (header.id) {
ADDRLP4 28
ADDRLP4 16
INDIRU4
ASGNU4
ADDRLP4 32
ADDRLP4 28
INDIRU4
CVUI4 4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 544501094
EQI4 $186
ADDRLP4 32
INDIRI4
CNSTI4 544501094
LTI4 $183
LABELV $196
ADDRLP4 28
INDIRU4
CVUI4 4
CNSTI4 1635017060
EQI4 $193
ADDRGP4 $183
JUMPV
LABELV $186
line 236
;235:		case 0x20746d66:	// "fmt "
;236:			{
line 240
;237:				formatChunk_t format;
;238:				int size;
;239:				
;240:				size = ReadChunkData(header.size, &format, sizeof(format));
ADDRLP4 16+4
INDIRU4
CVUI4 4
ARGI4
ADDRLP4 36
ARGP4
CNSTI4 16
ARGI4
ADDRLP4 56
ADDRGP4 ReadChunkData
CALLI4
ASGNI4
ADDRLP4 52
ADDRLP4 56
INDIRI4
ASGNI4
line 241
;241:				if (size < sizeof(format)) {
ADDRLP4 52
INDIRI4
CVIU4 4
CNSTU4 16
GEU4 $188
line 242
;242:					CG_Printf("^3Illegal format: '%s'\n", fileName);
ADDRGP4 $190
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 243
;243:					goto Exit;
ADDRGP4 $177
JUMPV
LABELV $188
line 245
;244:				}
;245:				bytesPerMillisecond = (format.dwSamplesPerSec * format.wBlockAlign) / 1000.0;
ADDRLP4 60
ADDRLP4 36+4
INDIRU4
ADDRLP4 36+12
INDIRU2
CVUI4 2
CVIU4 4
MULU4
ASGNU4
ADDRLP4 0
ADDRLP4 60
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 60
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 981668463
MULF4
ASGNF4
line 246
;246:			}
line 247
;247:			break;
ADDRGP4 $184
JUMPV
LABELV $193
line 249
;248:		case 0x61746164:	// "data"
;249:			numBytes = header.size;
ADDRLP4 4
ADDRLP4 16+4
INDIRU4
CVUI4 4
ASGNI4
line 250
;250:			SkipToEndOfFile();
ADDRGP4 SkipToEndOfFile
CALLV
pop
line 251
;251:			break;
ADDRGP4 $184
JUMPV
LABELV $183
line 253
;252:		default:
;253:			ReadChunkData(header.size, NULL, 0);
ADDRLP4 16+4
INDIRU4
CVUI4 4
ARGI4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 ReadChunkData
CALLI4
pop
line 254
;254:			break;
LABELV $184
line 256
;255:		}
;256:	}
LABELV $179
line 229
ADDRLP4 4
INDIRI4
CNSTI4 1
LTI4 $178
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
LTF4 $178
LABELV $180
line 258
;257:
;258:	if (numBytes > 0 && bytesPerMillisecond > 1) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LEI4 $197
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
LEF4 $197
line 259
;259:		duration = numBytes / bytesPerMillisecond;
ADDRLP4 8
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRLP4 0
INDIRF4
DIVF4
CVFI4 4
ASGNI4
line 260
;260:	}
LABELV $197
LABELV $177
line 263
;261:
;262:	Exit:
;263:	if (file) trap_FS_FCloseFile(file);
ADDRGP4 file
INDIRI4
CNSTI4 0
EQI4 $199
ADDRGP4 file
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
LABELV $199
line 264
;264:	return duration;
ADDRLP4 8
INDIRI4
RETI4
LABELV $174
endproc MusicDuration 64 12
export CG_InitPlayList
proc CG_InitPlayList 0 12
line 274
;265:}
;266:#endif
;267:
;268:/*
;269:===============
;270:CG_InitPlayList
;271:===============
;272:*/
;273:#if PLAYLIST
;274:void CG_InitPlayList(void) {
line 275
;275:	memset(&playList, 0, sizeof(playList));
ADDRGP4 playList
ARGP4
CNSTI4 0
ARGI4
CNSTI4 26000
ARGI4
ADDRGP4 memset
CALLP4
pop
line 276
;276:	numEntries = 0;
ADDRGP4 numEntries
CNSTI4 0
ASGNI4
line 277
;277:	currentEntry = 0;
ADDRGP4 currentEntry
CNSTI4 0
ASGNI4
line 278
;278:	stopEntryTime = -1;
ADDRGP4 stopEntryTime
CNSTI4 -1
ASGNI4
line 279
;279:	startEntryTime = -1;
ADDRGP4 startEntryTime
CNSTI4 -1
ASGNI4
line 280
;280:	running = qfalse;
ADDRGP4 running
CNSTI4 0
ASGNI4
line 281
;281:}
LABELV $201
endproc CG_InitPlayList 0 12
export CG_ParsePlayList
proc CG_ParsePlayList 1068 12
line 290
;282:#endif
;283:
;284:/*
;285:===============
;286:CG_ParsePlayList
;287:===============
;288:*/
;289:#if PLAYLIST
;290:void CG_ParsePlayList(void) {
line 293
;291:	int i;
;292:
;293:	CG_InitPlayList();
ADDRGP4 CG_InitPlayList
CALLV
pop
line 295
;294:
;295:	for (i = 0; i < MAX_PLAYLIST_ENTRIES; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $203
line 302
;296:		playListEntry_t* entry;
;297:		char info[MAX_INFO_STRING];
;298:		int repetition;
;299:		long introDuration;
;300:		long mainDuration;
;301:		
;302:		entry = &playList[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 260
MULI4
ADDRGP4 playList
ADDP4
ASGNP4
line 303
;303:		trap_Cvar_VariableStringBuffer(va("playlist%02d", i), info, sizeof(info));
ADDRGP4 $207
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1044
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1044
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 305
;304:		
;305:		if (!info[0]) break;
ADDRLP4 8
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $208
ADDRGP4 $205
JUMPV
LABELV $208
line 307
;306:
;307:		Q_strncpyz(entry->introPart, Info_ValueForKey(info, "intro"), sizeof(entry->introPart));
ADDRLP4 8
ARGP4
ADDRGP4 $210
ARGP4
ADDRLP4 1048
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 1048
INDIRP4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 308
;308:		Q_strncpyz(entry->mainPart, Info_ValueForKey(info, "main"), sizeof(entry->mainPart));
ADDRLP4 8
ARGP4
ADDRGP4 $211
ARGP4
ADDRLP4 1052
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 128
ADDP4
ARGP4
ADDRLP4 1052
INDIRP4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 309
;309:		repetition = atoi(Info_ValueForKey(info, "rep"));
ADDRLP4 8
ARGP4
ADDRGP4 $212
ARGP4
ADDRLP4 1056
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1056
INDIRP4
ARGP4
ADDRLP4 1060
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1032
ADDRLP4 1060
INDIRI4
ASGNI4
line 310
;310:		if (repetition <= 0) repetition = -1;
ADDRLP4 1032
INDIRI4
CNSTI4 0
GTI4 $213
ADDRLP4 1032
CNSTI4 -1
ASGNI4
LABELV $213
line 312
;311:
;312:		introDuration = 0;
ADDRLP4 1040
CNSTI4 0
ASGNI4
line 313
;313:		if (entry->introPart[0]) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $215
line 314
;314:			introDuration = MusicDuration(entry->introPart);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 1064
ADDRGP4 MusicDuration
CALLI4
ASGNI4
ADDRLP4 1040
ADDRLP4 1064
INDIRI4
ASGNI4
line 315
;315:			if (introDuration <= 0) {
ADDRLP4 1040
INDIRI4
CNSTI4 0
GTI4 $217
line 316
;316:				introDuration = 0;
ADDRLP4 1040
CNSTI4 0
ASGNI4
line 317
;317:				entry->introPart[0] = 0;
ADDRLP4 4
INDIRP4
CNSTI1 0
ASGNI1
line 318
;318:			}
LABELV $217
line 319
;319:		}
LABELV $215
line 321
;320:
;321:		mainDuration = 0;
ADDRLP4 1036
CNSTI4 0
ASGNI4
line 322
;322:		if (entry->mainPart[0]) {
ADDRLP4 4
INDIRP4
CNSTI4 128
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $219
line 323
;323:			mainDuration = MusicDuration(entry->mainPart);
ADDRLP4 4
INDIRP4
CNSTI4 128
ADDP4
ARGP4
ADDRLP4 1064
ADDRGP4 MusicDuration
CALLI4
ASGNI4
ADDRLP4 1036
ADDRLP4 1064
INDIRI4
ASGNI4
line 324
;324:			if (mainDuration <= 0) {
ADDRLP4 1036
INDIRI4
CNSTI4 0
GTI4 $221
line 325
;325:				mainDuration = 0;
ADDRLP4 1036
CNSTI4 0
ASGNI4
line 326
;326:				entry->mainPart[0] = 0;
ADDRLP4 4
INDIRP4
CNSTI4 128
ADDP4
CNSTI1 0
ASGNI1
line 327
;327:			}
LABELV $221
line 328
;328:		}
LABELV $219
line 330
;329:
;330:		if (!entry->introPart[0]) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $223
line 331
;331:			Q_strncpyz(entry->introPart, entry->mainPart, sizeof(entry->introPart));
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 128
ADDP4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 332
;332:			introDuration = mainDuration;
ADDRLP4 1040
ADDRLP4 1036
INDIRI4
ASGNI4
line 333
;333:			repetition--;
ADDRLP4 1032
ADDRLP4 1032
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 334
;334:		}
LABELV $223
line 335
;335:		if (!entry->mainPart[0]) {
ADDRLP4 4
INDIRP4
CNSTI4 128
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $225
line 336
;336:			Q_strncpyz(entry->mainPart, entry->introPart, sizeof(entry->mainPart));
ADDRLP4 4
INDIRP4
CNSTI4 128
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 337
;337:		}
LABELV $225
line 339
;338:
;339:		if (repetition >= 0 || mainDuration == 0) {
ADDRLP4 1032
INDIRI4
CNSTI4 0
GEI4 $229
ADDRLP4 1036
INDIRI4
CNSTI4 0
NEI4 $227
LABELV $229
line 340
;340:			entry->duration = introDuration + mainDuration * repetition;
ADDRLP4 4
INDIRP4
CNSTI4 256
ADDP4
ADDRLP4 1040
INDIRI4
ADDRLP4 1036
INDIRI4
ADDRLP4 1032
INDIRI4
MULI4
ADDI4
ASGNI4
line 341
;341:		}
ADDRGP4 $228
JUMPV
LABELV $227
line 342
;342:		else {
line 343
;343:			entry->duration = -1;
ADDRLP4 4
INDIRP4
CNSTI4 256
ADDP4
CNSTI4 -1
ASGNI4
line 344
;344:		}
LABELV $228
line 345
;345:	}
LABELV $204
line 295
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 100
LTI4 $203
LABELV $205
line 347
;346:
;347:	numEntries = i;
ADDRGP4 numEntries
ADDRLP4 0
INDIRI4
ASGNI4
line 349
;348:
;349:	CG_Printf("%d entries in playlist\n", numEntries);
ADDRGP4 $230
ARGP4
ADDRGP4 numEntries
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 350
;350:}
LABELV $202
endproc CG_ParsePlayList 1068 12
export CG_StopPlayList
proc CG_StopPlayList 0 0
line 359
;351:#endif
;352:
;353:/*
;354:===============
;355:CG_StopPlayList
;356:===============
;357:*/
;358:#if PLAYLIST
;359:void CG_StopPlayList(void) {
line 360
;360:	trap_S_StopBackgroundTrack();
ADDRGP4 trap_S_StopBackgroundTrack
CALLV
pop
line 361
;361:	stopEntryTime = -1;
ADDRGP4 stopEntryTime
CNSTI4 -1
ASGNI4
line 362
;362:	startEntryTime = -1;
ADDRGP4 startEntryTime
CNSTI4 -1
ASGNI4
line 363
;363:	running = qfalse;
ADDRGP4 running
CNSTI4 0
ASGNI4
line 364
;364:}
LABELV $231
endproc CG_StopPlayList 0 0
export CG_ContinuePlayList
proc CG_ContinuePlayList 4 0
line 373
;365:#endif
;366:
;367:/*
;368:===============
;369:CG_ContinuePlayList
;370:===============
;371:*/
;372:#if PLAYLIST
;373:void CG_ContinuePlayList(void) {
line 374
;374:	if (running) return;
ADDRGP4 running
INDIRI4
CNSTI4 0
EQI4 $233
ADDRGP4 $232
JUMPV
LABELV $233
line 376
;375:
;376:	trap_S_StopBackgroundTrack();
ADDRGP4 trap_S_StopBackgroundTrack
CALLV
pop
line 377
;377:	stopEntryTime = -1;
ADDRGP4 stopEntryTime
CNSTI4 -1
ASGNI4
line 378
;378:	startEntryTime = numEntries > 0? 0 : -1;
ADDRGP4 numEntries
INDIRI4
CNSTI4 0
LEI4 $236
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $237
JUMPV
LABELV $236
ADDRLP4 0
CNSTI4 -1
ASGNI4
LABELV $237
ADDRGP4 startEntryTime
ADDRLP4 0
INDIRI4
ASGNI4
line 379
;379:	running = qtrue;
ADDRGP4 running
CNSTI4 1
ASGNI4
line 380
;380:}
LABELV $232
endproc CG_ContinuePlayList 4 0
export CG_ResetPlayList
proc CG_ResetPlayList 0 0
line 389
;381:#endif
;382:
;383:/*
;384:===============
;385:CG_ResetPlayList
;386:===============
;387:*/
;388:#if PLAYLIST
;389:void CG_ResetPlayList(void) {
line 390
;390:	running = qfalse;
ADDRGP4 running
CNSTI4 0
ASGNI4
line 391
;391:	currentEntry = 0;
ADDRGP4 currentEntry
CNSTI4 0
ASGNI4
line 392
;392:	CG_ContinuePlayList();
ADDRGP4 CG_ContinuePlayList
CALLV
pop
line 393
;393:}
LABELV $238
endproc CG_ResetPlayList 0 0
data
align 4
LABELV $240
byte 4 -1
export CG_RunPlayListFrame
code
proc CG_RunPlayListFrame 24 8
line 402
;394:#endif
;395:
;396:/*
;397:===============
;398:CG_RunPlayListFrame
;399:===============
;400:*/
;401:#if PLAYLIST
;402:void CG_RunPlayListFrame(void) {
line 406
;403:	static int oldMusicMode = -1;
;404:	int currentTime;
;405:
;406:	if (cg_music.integer != oldMusicMode) {
ADDRGP4 cg_music+12
INDIRI4
ADDRGP4 $240
INDIRI4
EQI4 $241
line 407
;407:		oldMusicMode = cg_music.integer;
ADDRGP4 $240
ADDRGP4 cg_music+12
INDIRI4
ASGNI4
line 409
;408:
;409:		CG_StartMusic();
ADDRGP4 CG_StartMusic
CALLV
pop
line 410
;410:	}
LABELV $241
line 412
;411:
;412:	if (!running) return;
ADDRGP4 running
INDIRI4
CNSTI4 0
NEI4 $245
ADDRGP4 $239
JUMPV
LABELV $245
line 414
;413:
;414:	currentTime = trap_Milliseconds();
ADDRLP4 4
ADDRGP4 trap_Milliseconds
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 416
;415:
;416:	if (stopEntryTime >= 0 && currentTime >= stopEntryTime) {
ADDRLP4 8
ADDRGP4 stopEntryTime
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $247
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $247
line 417
;417:		trap_S_StopBackgroundTrack();
ADDRGP4 trap_S_StopBackgroundTrack
CALLV
pop
line 418
;418:		stopEntryTime = -1;
ADDRGP4 stopEntryTime
CNSTI4 -1
ASGNI4
line 419
;419:		currentEntry++;
ADDRLP4 12
ADDRGP4 currentEntry
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 420
;420:		startEntryTime = currentTime + 2000;
ADDRGP4 startEntryTime
ADDRLP4 0
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 421
;421:	}
LABELV $247
line 423
;422:
;423:	if (startEntryTime >= 0 && currentTime >= startEntryTime && numEntries > 0) {
ADDRLP4 12
ADDRGP4 startEntryTime
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
LTI4 $249
ADDRLP4 0
INDIRI4
ADDRLP4 12
INDIRI4
LTI4 $249
ADDRGP4 numEntries
INDIRI4
CNSTI4 0
LEI4 $249
line 426
;424:		const playListEntry_t* entry;
;425:
;426:		if (currentEntry >= numEntries) currentEntry = 0;
ADDRGP4 currentEntry
INDIRI4
ADDRGP4 numEntries
INDIRI4
LTI4 $251
ADDRGP4 currentEntry
CNSTI4 0
ASGNI4
LABELV $251
line 427
;427:		entry = &playList[currentEntry];
ADDRLP4 16
ADDRGP4 currentEntry
INDIRI4
CNSTI4 260
MULI4
ADDRGP4 playList
ADDP4
ASGNP4
line 428
;428:		if (entry->duration == 0) {
ADDRLP4 16
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
CNSTI4 0
NEI4 $253
line 429
;429:			currentEntry++;
ADDRLP4 20
ADDRGP4 currentEntry
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 430
;430:			return;
ADDRGP4 $239
JUMPV
LABELV $253
line 433
;431:		}
;432:
;433:		trap_S_StartBackgroundTrack(entry->introPart, entry->mainPart);
ADDRLP4 20
ADDRLP4 16
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 128
ADDP4
ARGP4
ADDRGP4 trap_S_StartBackgroundTrack
CALLV
pop
line 434
;434:		startEntryTime = -1;
ADDRGP4 startEntryTime
CNSTI4 -1
ASGNI4
line 436
;435:
;436:		if (entry->duration > 0) {
ADDRLP4 16
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
CNSTI4 0
LEI4 $255
line 437
;437:			stopEntryTime = currentTime + entry->duration - 200;
ADDRGP4 stopEntryTime
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
ADDI4
CNSTI4 200
SUBI4
ASGNI4
line 438
;438:		}
ADDRGP4 $256
JUMPV
LABELV $255
line 439
;439:		else {
line 440
;440:			stopEntryTime = -1;
ADDRGP4 stopEntryTime
CNSTI4 -1
ASGNI4
line 441
;441:		}
LABELV $256
line 442
;442:	}
LABELV $249
line 443
;443:}
LABELV $239
endproc CG_RunPlayListFrame 24 8
bss
align 4
LABELV startEntryTime
skip 4
align 4
LABELV stopEntryTime
skip 4
align 4
LABELV currentEntry
skip 4
align 4
LABELV numEntries
skip 4
align 4
LABELV playList
skip 26000
align 4
LABELV running
skip 4
align 1
LABELV buffer
skip 4096
align 4
LABELV bufLen
skip 4
align 4
LABELV bufPos
skip 4
align 4
LABELV fileSize
skip 4
align 4
LABELV file
skip 4
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
LABELV $230
byte 1 37
byte 1 100
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 105
byte 1 101
byte 1 115
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $212
byte 1 114
byte 1 101
byte 1 112
byte 1 0
align 1
LABELV $211
byte 1 109
byte 1 97
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $210
byte 1 105
byte 1 110
byte 1 116
byte 1 114
byte 1 111
byte 1 0
align 1
LABELV $207
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 37
byte 1 48
byte 1 50
byte 1 100
byte 1 0
align 1
LABELV $190
byte 1 94
byte 1 51
byte 1 73
byte 1 108
byte 1 108
byte 1 101
byte 1 103
byte 1 97
byte 1 108
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 109
byte 1 97
byte 1 116
byte 1 58
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $163
byte 1 94
byte 1 51
byte 1 85
byte 1 110
byte 1 101
byte 1 120
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 101
byte 1 110
byte 1 100
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $147
byte 1 94
byte 1 51
byte 1 85
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 109
byte 1 97
byte 1 116
byte 1 58
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $143
byte 1 94
byte 1 51
byte 1 67
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 111
byte 1 112
byte 1 101
byte 1 110
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 10
byte 1 0
