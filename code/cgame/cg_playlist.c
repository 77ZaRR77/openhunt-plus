//
// JUHOX: cg_playlist.c
//

#include "cg_local.h"

typedef struct {
	unsigned long id;
	unsigned long size;
} chunkHeader_t;

typedef struct {
	short wFormatTag;
	unsigned short wChannels;
	unsigned long dwSamplesPerSec;
	unsigned long dwAvgBytesPerSec;
	unsigned short wBlockAlign;
	unsigned short wBitsPerSample;
} formatChunk_t;

typedef struct {
	char introPart[128];	// complete path
	char mainPart[128];		// complete path
	long duration;			// milliseconds, -1 = infinite, 0 = skip this entry
} playListEntry_t;


#define BUFFER_SIZE 4096

static fileHandle_t file;
static int fileSize;
static int bufPos;
static int bufLen;
static unsigned char buffer[BUFFER_SIZE];

static qboolean running;
static playListEntry_t playList[MAX_PLAYLIST_ENTRIES];
static int numEntries;
static int currentEntry;
static int stopEntryTime;
static int startEntryTime;



/*
===============
ReadByte

return -1 for EOF
===============
*/
static int ReadByte(void) {
	if (bufPos >= bufLen) {
		if (fileSize <= 0) return -1;

		bufLen = fileSize;
		if (bufLen > BUFFER_SIZE) bufLen = BUFFER_SIZE;
		trap_FS_Read(buffer, bufLen, file);
		fileSize -= bufLen;
		bufPos = 0;
	}

	return buffer[bufPos++];
}

/*
===============
BytesLeft
===============
*/
static int BytesLeft(void) {
	return fileSize + bufLen - bufPos;
}


/*
===============
ReadDWORD
===============
*/
static qboolean ReadDWORD(void* dataBuf) {
	unsigned long dword;

	if (BytesLeft() < 4) return qfalse;

	dword = ReadByte();
	dword |= ReadByte() << 8;
	dword |= ReadByte() << 16;
	dword |= ReadByte() << 24;

	if (dataBuf) *((unsigned long*)dataBuf) = dword;
	return qtrue;
}


/*
===============
OpenWaveFile
===============
*/
static qboolean OpenWaveFile(const char* name) {
	unsigned long id;

	fileSize = trap_FS_FOpenFile(name, &file, FS_READ);
	if (!file) {
		CG_Printf("^3Couldn't open '%s'\n", name);
		return qfalse;
	}

	if (fileSize < 44) {
		BadFile:
		CG_Printf("^3Unknown file format: '%s'\n", name);
		return qfalse;
	}

	bufPos = 0;
	bufLen = 0;

	if (!ReadDWORD(&id)) goto BadFile;
	if (id != 0x46464952) goto BadFile;	// 'RIFF'

	if (!ReadDWORD(NULL)) goto BadFile;	// length

	if (!ReadDWORD(&id)) goto BadFile;
	if (id != 0x45564157) goto BadFile;	// 'WAVE'

	return qtrue;
}


/*
===============
SkipToEndOfFile
===============
*/
static void SkipToEndOfFile(void) {
	fileSize = 0;
	bufPos = 0;
	bufLen = 0;
}


/*
===============
ReadChunkHeader
===============
*/
static qboolean ReadChunkHeader(chunkHeader_t* header) {
	if (!ReadDWORD(&header->id)) {
		UnexpectedEOF:
		CG_Printf("^3Unexpected end of file\n");
		return qfalse;
	}
	if (!ReadDWORD(&header->size)) goto UnexpectedEOF;

	return qtrue;
}


/*
===============
ReadChunkData

returns the size of the data read into the buffer
===============
*/
static int ReadChunkData(int chunkSize, void* buffer, int bufferSize) {
	unsigned char* bytes;
	int count;

	bytes = (unsigned char*) buffer;
	count = 0;

	chunkSize = (chunkSize + 1) & ~1;

	while (chunkSize > 0) {
		int byte;

		byte = ReadByte();
		if (byte < 0) break;

		if (bufferSize > 0) {
			*bytes = byte;
			bytes++;
			count++;
			bufferSize--;
		}

		chunkSize--;
	}
	return count;
}


/*
===============
MusicDuration

returns the duration of the music file in milliseconds
returns -1 in case of an error
===============
*/
static long MusicDuration(const char* fileName) {
	long duration;
	float bytesPerMillisecond;
	long numBytes;

	duration = -1;
	file = 0;
	if (!OpenWaveFile(fileName)) goto Exit;

	bytesPerMillisecond = 0;
	numBytes = 0;

	while (numBytes < 1 || bytesPerMillisecond < 1) {
		chunkHeader_t header;

		if (!ReadChunkHeader(&header)) break;

		switch (header.id) {
		case 0x20746d66:	// "fmt "
			{
				formatChunk_t format;
				int size;

				size = ReadChunkData(header.size, &format, sizeof(format));
				if (size < sizeof(format)) {
					CG_Printf("^3Illegal format: '%s'\n", fileName);
					goto Exit;
				}
				bytesPerMillisecond = (format.dwSamplesPerSec * format.wBlockAlign) / 1000.0;
			}
			break;
		case 0x61746164:	// "data"
			numBytes = header.size;
			SkipToEndOfFile();
			break;
		default:
			ReadChunkData(header.size, NULL, 0);
			break;
		}
	}

	if (numBytes > 0 && bytesPerMillisecond > 1) {
		duration = numBytes / bytesPerMillisecond;
	}

	Exit:
	if (file) trap_FS_FCloseFile(file);
	return duration;
}


/*
===============
CG_InitPlayList
===============
*/
void CG_InitPlayList(void) {
	memset(&playList, 0, sizeof(playList));
	numEntries = 0;
	currentEntry = 0;
	stopEntryTime = -1;
	startEntryTime = -1;
	running = qfalse;
}


/*
===============
CG_ParsePlayList
===============
*/
void CG_ParsePlayList(void) {
	int i;

	CG_InitPlayList();

	for (i = 0; i < MAX_PLAYLIST_ENTRIES; i++) {
		playListEntry_t* entry;
		char info[MAX_INFO_STRING];
		int repetition;
		long introDuration;
		long mainDuration;

		entry = &playList[i];
		trap_Cvar_VariableStringBuffer(va("playlist%02d", i), info, sizeof(info));

		if (!info[0]) break;

		Q_strncpyz(entry->introPart, Info_ValueForKey(info, "intro"), sizeof(entry->introPart));
		Q_strncpyz(entry->mainPart, Info_ValueForKey(info, "main"), sizeof(entry->mainPart));
		repetition = atoi(Info_ValueForKey(info, "rep"));
		if (repetition <= 0) repetition = -1;

		introDuration = 0;
		if (entry->introPart[0]) {
			introDuration = MusicDuration(entry->introPart);
			if (introDuration <= 0) {
				introDuration = 0;
				entry->introPart[0] = 0;
			}
		}

		mainDuration = 0;
		if (entry->mainPart[0]) {
			mainDuration = MusicDuration(entry->mainPart);
			if (mainDuration <= 0) {
				mainDuration = 0;
				entry->mainPart[0] = 0;
			}
		}

		if (!entry->introPart[0]) {
			Q_strncpyz(entry->introPart, entry->mainPart, sizeof(entry->introPart));
			introDuration = mainDuration;
			repetition--;
		}
		if (!entry->mainPart[0]) {
			Q_strncpyz(entry->mainPart, entry->introPart, sizeof(entry->mainPart));
		}

		if (repetition >= 0 || mainDuration == 0) {
			entry->duration = introDuration + mainDuration * repetition;
		}
		else {
			entry->duration = -1;
		}
	}

	numEntries = i;

	CG_Printf("%d entries in playlist\n", numEntries);
}


/*
===============
CG_StopPlayList
===============
*/
void CG_StopPlayList(void) {
	trap_S_StopBackgroundTrack();
	stopEntryTime = -1;
	startEntryTime = -1;
	running = qfalse;
}

/*
===============
CG_ContinuePlayList
===============
*/
void CG_ContinuePlayList(void) {
	if (running) return;

	trap_S_StopBackgroundTrack();
	stopEntryTime = -1;
	startEntryTime = numEntries > 0? 0 : -1;
	running = qtrue;
}

/*
===============
CG_ResetPlayList
===============
*/
void CG_ResetPlayList(void) {
	running = qfalse;
	currentEntry = 0;
	CG_ContinuePlayList();
}

/*
===============
CG_RunPlayListFrame
===============
*/
void CG_RunPlayListFrame(void) {
	static int oldMusicMode = -1;
	int currentTime;

	if (cg_music.integer != oldMusicMode) {
		oldMusicMode = cg_music.integer;

		CG_StartMusic();
	}

	if (!running) return;

	currentTime = trap_Milliseconds();

	if (stopEntryTime >= 0 && currentTime >= stopEntryTime) {
		trap_S_StopBackgroundTrack();
		stopEntryTime = -1;
		currentEntry++;
		startEntryTime = currentTime + 2000;
	}

	if (startEntryTime >= 0 && currentTime >= startEntryTime && numEntries > 0) {
		const playListEntry_t* entry;

		if (currentEntry >= numEntries) currentEntry = 0;
		entry = &playList[currentEntry];
		if (entry->duration == 0) {
			currentEntry++;
			return;
		}

		trap_S_StartBackgroundTrack(entry->introPart, entry->mainPart);
		startEntryTime = -1;

		if (entry->duration > 0) {
			stopEntryTime = currentTime + entry->duration - 200;
		}
		else {
			stopEntryTime = -1;
		}
	}
}
