code
proc StringToFilter 156 8
file "..\..\..\..\code\game\g_svcmds.c"
line 61
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:
;4:// this file holds commands that can be executed by the server console, but not remote clients
;5:
;6:#include "g_local.h"
;7:
;8:
;9:/*
;10:==============================================================================
;11:
;12:PACKET FILTERING
;13: 
;14:
;15:You can add or remove addresses from the filter list with:
;16:
;17:addip <ip>
;18:removeip <ip>
;19:
;20:The ip address is specified in dot format, and you can use '*' to match any value
;21:so you can specify an entire class C network with "addip 192.246.40.*"
;22:
;23:Removeip will only remove an address specified exactly the same way.  You cannot addip a subnet, then removeip a single host.
;24:
;25:listip
;26:Prints the current list of filters.
;27:
;28:g_filterban <0 or 1>
;29:
;30:If 1 (the default), then ip addresses matching the current list will be prohibited from entering the game.  This is the default setting.
;31:
;32:If 0, then only addresses matching the list will be allowed.  This lets you easily set up a private game, or a game that only allows players from your local network.
;33:
;34:TTimo NOTE: for persistence, bans are stored in g_banIPs cvar MAX_CVAR_VALUE_STRING
;35:The size of the cvar string buffer is limiting the banning to around 20 masks
;36:this could be improved by putting some g_banIPs2 g_banIps3 etc. maybe
;37:still, you should rely on PB for banning instead
;38:
;39:==============================================================================
;40:*/
;41:
;42:
;43:
;44:typedef struct ipFilter_s
;45:{
;46:	unsigned	mask;
;47:	unsigned	compare;
;48:} ipFilter_t;
;49:
;50:#define	MAX_IPFILTERS	1024
;51:
;52:static ipFilter_t	ipFilters[MAX_IPFILTERS];
;53:static int			numIPFilters;
;54:
;55:/*
;56:=================
;57:StringToFilter
;58:=================
;59:*/
;60:static qboolean StringToFilter (char *s, ipFilter_t *f)
;61:{
line 67
;62:	char	num[128];
;63:	int		i, j;
;64:	byte	b[4];
;65:	byte	m[4];
;66:	
;67:	for (i=0 ; i<4 ; i++)
ADDRLP4 132
CNSTI4 0
ASGNI4
LABELV $88
line 68
;68:	{
line 69
;69:		b[i] = 0;
ADDRLP4 132
INDIRI4
ADDRLP4 136
ADDP4
CNSTU1 0
ASGNU1
line 70
;70:		m[i] = 0;
ADDRLP4 132
INDIRI4
ADDRLP4 140
ADDP4
CNSTU1 0
ASGNU1
line 71
;71:	}
LABELV $89
line 67
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 4
LTI4 $88
line 73
;72:	
;73:	for (i=0 ; i<4 ; i++)
ADDRLP4 132
CNSTI4 0
ASGNI4
LABELV $92
line 74
;74:	{
line 75
;75:		if (*s < '0' || *s > '9')
ADDRLP4 144
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 48
LTI4 $98
ADDRLP4 144
INDIRI4
CNSTI4 57
LEI4 $96
LABELV $98
line 76
;76:		{
line 77
;77:			if (*s == '*') // 'match any'
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $99
line 78
;78:			{
line 80
;79:				// b[i] and m[i] to 0
;80:				s++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 81
;81:				if (!*s)
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $101
line 82
;82:					break;
ADDRGP4 $94
JUMPV
LABELV $101
line 83
;83:				s++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 84
;84:				continue;
ADDRGP4 $93
JUMPV
LABELV $99
line 86
;85:			}
;86:			G_Printf( "Bad filter address: %s\n", s );
ADDRGP4 $103
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 87
;87:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $87
JUMPV
LABELV $96
line 90
;88:		}
;89:		
;90:		j = 0;
ADDRLP4 128
CNSTI4 0
ASGNI4
ADDRGP4 $105
JUMPV
LABELV $104
line 92
;91:		while (*s >= '0' && *s <= '9')
;92:		{
line 93
;93:			num[j++] = *s++;
ADDRLP4 148
ADDRLP4 128
INDIRI4
ASGNI4
ADDRLP4 128
ADDRLP4 148
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 152
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 152
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 148
INDIRI4
ADDRLP4 0
ADDP4
ADDRLP4 152
INDIRP4
INDIRI1
ASGNI1
line 94
;94:		}
LABELV $105
line 91
ADDRLP4 148
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 48
LTI4 $107
ADDRLP4 148
INDIRI4
CNSTI4 57
LEI4 $104
LABELV $107
line 95
;95:		num[j] = 0;
ADDRLP4 128
INDIRI4
ADDRLP4 0
ADDP4
CNSTI1 0
ASGNI1
line 96
;96:		b[i] = atoi(num);
ADDRLP4 0
ARGP4
ADDRLP4 152
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
ADDRLP4 136
ADDP4
ADDRLP4 152
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 97
;97:		m[i] = 255;
ADDRLP4 132
INDIRI4
ADDRLP4 140
ADDP4
CNSTU1 255
ASGNU1
line 99
;98:
;99:		if (!*s)
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $108
line 100
;100:			break;
ADDRGP4 $94
JUMPV
LABELV $108
line 101
;101:		s++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 102
;102:	}
LABELV $93
line 73
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 4
LTI4 $92
LABELV $94
line 104
;103:	
;104:	f->mask = *(unsigned *)m;
ADDRFP4 4
INDIRP4
ADDRLP4 140
INDIRU4
ASGNU4
line 105
;105:	f->compare = *(unsigned *)b;
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 136
INDIRU4
ASGNU4
line 107
;106:	
;107:	return qtrue;
CNSTI4 1
RETI4
LABELV $87
endproc StringToFilter 156 8
proc UpdateIPBans 344 12
line 116
;108:}
;109:
;110:/*
;111:=================
;112:UpdateIPBans
;113:=================
;114:*/
;115:static void UpdateIPBans (void)
;116:{
line 123
;117:	byte	b[4];
;118:	byte	m[4];
;119:	int		i,j;
;120:	char	iplist_final[MAX_CVAR_VALUE_STRING];
;121:	char	ip[64];
;122:
;123:	*iplist_final = 0;
ADDRLP4 80
CNSTI1 0
ASGNI1
line 124
;124:	for (i = 0 ; i < numIPFilters ; i++)
ADDRLP4 76
CNSTI4 0
ASGNI4
ADDRGP4 $114
JUMPV
LABELV $111
line 125
;125:	{
line 126
;126:		if (ipFilters[i].compare == 0xffffffff)
ADDRLP4 76
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 ipFilters+4
ADDP4
INDIRU4
CNSTU4 4294967295
NEU4 $115
line 127
;127:			continue;
ADDRGP4 $112
JUMPV
LABELV $115
line 129
;128:
;129:		*(unsigned *)b = ipFilters[i].compare;
ADDRLP4 72
ADDRLP4 76
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 ipFilters+4
ADDP4
INDIRU4
ASGNU4
line 130
;130:		*(unsigned *)m = ipFilters[i].mask;
ADDRLP4 68
ADDRLP4 76
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 ipFilters
ADDP4
INDIRU4
ASGNU4
line 131
;131:		*ip = 0;
ADDRLP4 4
CNSTI1 0
ASGNI1
line 132
;132:		for (j = 0 ; j < 4 ; j++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $119
line 133
;133:		{
line 134
;134:			if (m[j]!=255)
ADDRLP4 0
INDIRI4
ADDRLP4 68
ADDP4
INDIRU1
CVUI4 1
CNSTI4 255
EQI4 $123
line 135
;135:				Q_strcat(ip, sizeof(ip), "*");
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $125
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
ADDRGP4 $124
JUMPV
LABELV $123
line 137
;136:			else
;137:				Q_strcat(ip, sizeof(ip), va("%i", b[j]));
ADDRGP4 $126
ARGP4
ADDRLP4 0
INDIRI4
ADDRLP4 72
ADDP4
INDIRU1
CVUI4 1
ARGI4
ADDRLP4 336
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 336
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
LABELV $124
line 138
;138:			Q_strcat(ip, sizeof(ip), (j<3) ? "." : " ");
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 3
GEI4 $130
ADDRLP4 340
ADDRGP4 $127
ASGNP4
ADDRGP4 $131
JUMPV
LABELV $130
ADDRLP4 340
ADDRGP4 $128
ASGNP4
LABELV $131
ADDRLP4 340
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 139
;139:		}		
LABELV $120
line 132
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $119
line 140
;140:		if (strlen(iplist_final)+strlen(ip) < MAX_CVAR_VALUE_STRING)
ADDRLP4 80
ARGP4
ADDRLP4 336
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
ARGP4
ADDRLP4 340
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 336
INDIRI4
ADDRLP4 340
INDIRI4
ADDI4
CNSTI4 256
GEI4 $132
line 141
;141:		{
line 142
;142:			Q_strcat( iplist_final, sizeof(iplist_final), ip);
ADDRLP4 80
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 143
;143:		}
ADDRGP4 $133
JUMPV
LABELV $132
line 145
;144:		else
;145:		{
line 146
;146:			Com_Printf("g_banIPs overflowed at MAX_CVAR_VALUE_STRING\n");
ADDRGP4 $134
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 147
;147:			break;
ADDRGP4 $113
JUMPV
LABELV $133
line 149
;148:		}
;149:	}
LABELV $112
line 124
ADDRLP4 76
ADDRLP4 76
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $114
ADDRLP4 76
INDIRI4
ADDRGP4 numIPFilters
INDIRI4
LTI4 $111
LABELV $113
line 151
;150:
;151:	trap_Cvar_Set( "g_banIPs", iplist_final );
ADDRGP4 $135
ARGP4
ADDRLP4 80
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 152
;152:}
LABELV $110
endproc UpdateIPBans 344 12
export G_FilterPacket
proc G_FilterPacket 28 0
line 160
;153:
;154:/*
;155:=================
;156:G_FilterPacket
;157:=================
;158:*/
;159:qboolean G_FilterPacket (char *from)
;160:{
line 166
;161:	int		i;
;162:	unsigned	in;
;163:	byte m[4];
;164:	char *p;
;165:
;166:	i = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 167
;167:	p = from;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $138
JUMPV
LABELV $137
line 168
;168:	while (*p && i < 4) {
line 169
;169:		m[i] = 0;
ADDRLP4 4
INDIRI4
ADDRLP4 8
ADDP4
CNSTU1 0
ASGNU1
ADDRGP4 $141
JUMPV
LABELV $140
line 170
;170:		while (*p >= '0' && *p <= '9') {
line 171
;171:			m[i] = m[i]*10 + (*p - '0');
ADDRLP4 16
ADDRLP4 4
INDIRI4
ADDRLP4 8
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRU1
CVUI4 1
CNSTI4 10
MULI4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 48
SUBI4
ADDI4
CVIU4 4
CVUU1 4
ASGNU1
line 172
;172:			p++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 173
;173:		}
LABELV $141
line 170
ADDRLP4 16
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 48
LTI4 $143
ADDRLP4 16
INDIRI4
CNSTI4 57
LEI4 $140
LABELV $143
line 174
;174:		if (!*p || *p == ':')
ADDRLP4 20
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $146
ADDRLP4 20
INDIRI4
CNSTI4 58
NEI4 $144
LABELV $146
line 175
;175:			break;
ADDRGP4 $139
JUMPV
LABELV $144
line 176
;176:		i++, p++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 177
;177:	}
LABELV $138
line 168
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $147
ADDRLP4 4
INDIRI4
CNSTI4 4
LTI4 $137
LABELV $147
LABELV $139
line 179
;178:	
;179:	in = *(unsigned *)m;
ADDRLP4 12
ADDRLP4 8
INDIRU4
ASGNU4
line 181
;180:
;181:	for (i=0 ; i<numIPFilters ; i++)
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $151
JUMPV
LABELV $148
line 182
;182:		if ( (in & ipFilters[i].mask) == ipFilters[i].compare)
ADDRLP4 12
INDIRU4
ADDRLP4 4
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 ipFilters
ADDP4
INDIRU4
BANDU4
ADDRLP4 4
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 ipFilters+4
ADDP4
INDIRU4
NEU4 $152
line 183
;183:			return g_filterBan.integer != 0;
ADDRGP4 g_filterBan+12
INDIRI4
CNSTI4 0
EQI4 $157
ADDRLP4 20
CNSTI4 1
ASGNI4
ADDRGP4 $158
JUMPV
LABELV $157
ADDRLP4 20
CNSTI4 0
ASGNI4
LABELV $158
ADDRLP4 20
INDIRI4
RETI4
ADDRGP4 $136
JUMPV
LABELV $152
LABELV $149
line 181
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $151
ADDRLP4 4
INDIRI4
ADDRGP4 numIPFilters
INDIRI4
LTI4 $148
line 185
;184:
;185:	return g_filterBan.integer == 0;
ADDRGP4 g_filterBan+12
INDIRI4
CNSTI4 0
NEI4 $161
ADDRLP4 24
CNSTI4 1
ASGNI4
ADDRGP4 $162
JUMPV
LABELV $161
ADDRLP4 24
CNSTI4 0
ASGNI4
LABELV $162
ADDRLP4 24
INDIRI4
RETI4
LABELV $136
endproc G_FilterPacket 28 0
proc AddIP 8 8
line 194
;186:}
;187:
;188:/*
;189:=================
;190:AddIP
;191:=================
;192:*/
;193:static void AddIP( char *str )
;194:{
line 197
;195:	int		i;
;196:
;197:	for (i = 0 ; i < numIPFilters ; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $167
JUMPV
LABELV $164
line 198
;198:		if (ipFilters[i].compare == 0xffffffff)
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 ipFilters+4
ADDP4
INDIRU4
CNSTU4 4294967295
NEU4 $168
line 199
;199:			break;		// free spot
ADDRGP4 $166
JUMPV
LABELV $168
LABELV $165
line 197
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $167
ADDRLP4 0
INDIRI4
ADDRGP4 numIPFilters
INDIRI4
LTI4 $164
LABELV $166
line 200
;200:	if (i == numIPFilters)
ADDRLP4 0
INDIRI4
ADDRGP4 numIPFilters
INDIRI4
NEI4 $171
line 201
;201:	{
line 202
;202:		if (numIPFilters == MAX_IPFILTERS)
ADDRGP4 numIPFilters
INDIRI4
CNSTI4 1024
NEI4 $173
line 203
;203:		{
line 204
;204:			G_Printf ("IP filter list is full\n");
ADDRGP4 $175
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 205
;205:			return;
ADDRGP4 $163
JUMPV
LABELV $173
line 207
;206:		}
;207:		numIPFilters++;
ADDRLP4 4
ADDRGP4 numIPFilters
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 208
;208:	}
LABELV $171
line 210
;209:	
;210:	if (!StringToFilter (str, &ipFilters[i]))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 ipFilters
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 StringToFilter
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $176
line 211
;211:		ipFilters[i].compare = 0xffffffffu;
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 ipFilters+4
ADDP4
CNSTU4 4294967295
ASGNU4
LABELV $176
line 213
;212:
;213:	UpdateIPBans();
ADDRGP4 UpdateIPBans
CALLV
pop
line 214
;214:}
LABELV $163
endproc AddIP 8 8
export G_ProcessIPBans
proc G_ProcessIPBans 276 12
line 222
;215:
;216:/*
;217:=================
;218:G_ProcessIPBans
;219:=================
;220:*/
;221:void G_ProcessIPBans(void) 
;222:{
line 226
;223:	char *s, *t;
;224:	char		str[MAX_CVAR_VALUE_STRING];
;225:
;226:	Q_strncpyz( str, g_banIPs.string, sizeof(str) );
ADDRLP4 8
ARGP4
ADDRGP4 g_banIPs+16
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 228
;227:
;228:	for (t = s = g_banIPs.string; *t; /* */ ) {
ADDRLP4 264
ADDRGP4 g_banIPs+16
ASGNP4
ADDRLP4 0
ADDRLP4 264
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 264
INDIRP4
ASGNP4
ADDRGP4 $184
JUMPV
LABELV $181
line 229
;229:		s = strchr(s, ' ');
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 268
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 268
INDIRP4
ASGNP4
line 230
;230:		if (!s)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $189
line 231
;231:			break;
ADDRGP4 $183
JUMPV
LABELV $188
line 233
;232:		while (*s == ' ')
;233:			*s++ = 0;
ADDRLP4 272
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 272
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 272
INDIRP4
CNSTI1 0
ASGNI1
LABELV $189
line 232
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 32
EQI4 $188
line 234
;234:		if (*t)
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $191
line 235
;235:			AddIP( t );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 AddIP
CALLV
pop
LABELV $191
line 236
;236:		t = s;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
line 237
;237:	}
LABELV $182
line 228
LABELV $184
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $181
LABELV $183
line 238
;238:}
LABELV $179
endproc G_ProcessIPBans 276 12
export Svcmd_AddIP_f
proc Svcmd_AddIP_f 1028 12
line 247
;239:
;240:
;241:/*
;242:=================
;243:Svcmd_AddIP_f
;244:=================
;245:*/
;246:void Svcmd_AddIP_f (void)
;247:{
line 250
;248:	char		str[MAX_TOKEN_CHARS];
;249:
;250:	if ( trap_Argc() < 2 ) {
ADDRLP4 1024
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 1024
INDIRI4
CNSTI4 2
GEI4 $194
line 251
;251:		G_Printf("Usage:  addip <ip-mask>\n");
ADDRGP4 $196
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 252
;252:		return;
ADDRGP4 $193
JUMPV
LABELV $194
line 255
;253:	}
;254:
;255:	trap_Argv( 1, str, sizeof( str ) );
CNSTI4 1
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 257
;256:
;257:	AddIP( str );
ADDRLP4 0
ARGP4
ADDRGP4 AddIP
CALLV
pop
line 259
;258:
;259:}
LABELV $193
endproc Svcmd_AddIP_f 1028 12
export Svcmd_RemoveIP_f
proc Svcmd_RemoveIP_f 1048 12
line 267
;260:
;261:/*
;262:=================
;263:Svcmd_RemoveIP_f
;264:=================
;265:*/
;266:void Svcmd_RemoveIP_f (void)
;267:{
line 272
;268:	ipFilter_t	f;
;269:	int			i;
;270:	char		str[MAX_TOKEN_CHARS];
;271:
;272:	if ( trap_Argc() < 2 ) {
ADDRLP4 1036
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 2
GEI4 $198
line 273
;273:		G_Printf("Usage:  sv removeip <ip-mask>\n");
ADDRGP4 $200
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 274
;274:		return;
ADDRGP4 $197
JUMPV
LABELV $198
line 277
;275:	}
;276:
;277:	trap_Argv( 1, str, sizeof( str ) );
CNSTI4 1
ARGI4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 279
;278:
;279:	if (!StringToFilter (str, &f))
ADDRLP4 12
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 1040
ADDRGP4 StringToFilter
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $201
line 280
;280:		return;
ADDRGP4 $197
JUMPV
LABELV $201
line 282
;281:
;282:	for (i=0 ; i<numIPFilters ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $206
JUMPV
LABELV $203
line 283
;283:		if (ipFilters[i].mask == f.mask	&&
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 ipFilters
ADDP4
INDIRU4
ADDRLP4 4
INDIRU4
NEU4 $207
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 ipFilters+4
ADDP4
INDIRU4
ADDRLP4 4+4
INDIRU4
NEU4 $207
line 284
;284:			ipFilters[i].compare == f.compare) {
line 285
;285:			ipFilters[i].compare = 0xffffffffu;
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 ipFilters+4
ADDP4
CNSTU4 4294967295
ASGNU4
line 286
;286:			G_Printf ("Removed.\n");
ADDRGP4 $212
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 288
;287:
;288:			UpdateIPBans();
ADDRGP4 UpdateIPBans
CALLV
pop
line 289
;289:			return;
ADDRGP4 $197
JUMPV
LABELV $207
line 291
;290:		}
;291:	}
LABELV $204
line 282
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $206
ADDRLP4 0
INDIRI4
ADDRGP4 numIPFilters
INDIRI4
LTI4 $203
line 293
;292:
;293:	G_Printf ( "Didn't find %s.\n", str );
ADDRGP4 $213
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 294
;294:}
LABELV $197
endproc Svcmd_RemoveIP_f 1048 12
export Svcmd_EntityList_f
proc Svcmd_EntityList_f 16 8
line 301
;295:
;296:/*
;297:===================
;298:Svcmd_EntityList_f
;299:===================
;300:*/
;301:void	Svcmd_EntityList_f (void) {
line 305
;302:	int			e;
;303:	gentity_t		*check;
;304:
;305:	check = g_entities+1;
ADDRLP4 0
ADDRGP4 g_entities+844
ASGNP4
line 306
;306:	for (e = 1; e < level.num_entities ; e++, check++) {
ADDRLP4 4
CNSTI4 1
ASGNI4
ADDRGP4 $219
JUMPV
LABELV $216
line 307
;307:		if ( !check->inuse ) {
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $221
line 308
;308:			continue;
ADDRGP4 $217
JUMPV
LABELV $221
line 310
;309:		}
;310:		G_Printf("%3i:", e);
ADDRGP4 $223
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 311
;311:		switch ( check->s.eType ) {
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $224
ADDRLP4 8
INDIRI4
CNSTI4 11
GTI4 $224
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $252
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $252
address $227
address $229
address $231
address $233
address $235
address $237
address $239
address $241
address $243
address $245
address $247
address $249
code
LABELV $227
line 313
;312:		case ET_GENERAL:
;313:			G_Printf("ET_GENERAL          ");
ADDRGP4 $228
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 314
;314:			break;
ADDRGP4 $225
JUMPV
LABELV $229
line 316
;315:		case ET_PLAYER:
;316:			G_Printf("ET_PLAYER           ");
ADDRGP4 $230
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 317
;317:			break;
ADDRGP4 $225
JUMPV
LABELV $231
line 319
;318:		case ET_ITEM:
;319:			G_Printf("ET_ITEM             ");
ADDRGP4 $232
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 320
;320:			break;
ADDRGP4 $225
JUMPV
LABELV $233
line 322
;321:		case ET_MISSILE:
;322:			G_Printf("ET_MISSILE          ");
ADDRGP4 $234
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 323
;323:			break;
ADDRGP4 $225
JUMPV
LABELV $235
line 325
;324:		case ET_MOVER:
;325:			G_Printf("ET_MOVER            ");
ADDRGP4 $236
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 326
;326:			break;
ADDRGP4 $225
JUMPV
LABELV $237
line 328
;327:		case ET_BEAM:
;328:			G_Printf("ET_BEAM             ");
ADDRGP4 $238
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 329
;329:			break;
ADDRGP4 $225
JUMPV
LABELV $239
line 331
;330:		case ET_PORTAL:
;331:			G_Printf("ET_PORTAL           ");
ADDRGP4 $240
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 332
;332:			break;
ADDRGP4 $225
JUMPV
LABELV $241
line 334
;333:		case ET_SPEAKER:
;334:			G_Printf("ET_SPEAKER          ");
ADDRGP4 $242
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 335
;335:			break;
ADDRGP4 $225
JUMPV
LABELV $243
line 337
;336:		case ET_PUSH_TRIGGER:
;337:			G_Printf("ET_PUSH_TRIGGER     ");
ADDRGP4 $244
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 338
;338:			break;
ADDRGP4 $225
JUMPV
LABELV $245
line 340
;339:		case ET_TELEPORT_TRIGGER:
;340:			G_Printf("ET_TELEPORT_TRIGGER ");
ADDRGP4 $246
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 341
;341:			break;
ADDRGP4 $225
JUMPV
LABELV $247
line 343
;342:		case ET_INVISIBLE:
;343:			G_Printf("ET_INVISIBLE        ");
ADDRGP4 $248
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 344
;344:			break;
ADDRGP4 $225
JUMPV
LABELV $249
line 346
;345:		case ET_GRAPPLE:
;346:			G_Printf("ET_GRAPPLE          ");
ADDRGP4 $250
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 347
;347:			break;
ADDRGP4 $225
JUMPV
LABELV $224
line 349
;348:		default:
;349:			G_Printf("%3i                 ", check->s.eType);
ADDRGP4 $251
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 350
;350:			break;
LABELV $225
line 353
;351:		}
;352:
;353:		if ( check->classname ) {
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $253
line 354
;354:			G_Printf("%s", check->classname);
ADDRGP4 $255
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 355
;355:		}
LABELV $253
line 356
;356:		G_Printf("\n");
ADDRGP4 $256
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 357
;357:	}
LABELV $217
line 306
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 844
ADDP4
ASGNP4
LABELV $219
ADDRLP4 4
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $216
line 358
;358:}
LABELV $214
endproc Svcmd_EntityList_f 16 8
export ClientForString
proc ClientForString 24 8
line 360
;359:
;360:gclient_t	*ClientForString( const char *s ) {
line 366
;361:	gclient_t	*cl;
;362:	int			i;
;363:	int			idnum;
;364:
;365:	// numeric values are just slot numbers
;366:	if ( s[0] >= '0' && s[0] <= '9' ) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 48
LTI4 $258
ADDRLP4 12
INDIRI4
CNSTI4 57
GTI4 $258
line 367
;367:		idnum = atoi( s );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 16
INDIRI4
ASGNI4
line 368
;368:		if ( idnum < 0 || idnum >= level.maxclients ) {
ADDRLP4 20
ADDRLP4 8
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
LTI4 $263
ADDRLP4 20
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $260
LABELV $263
line 369
;369:			Com_Printf( "Bad client slot: %i\n", idnum );
ADDRGP4 $264
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 370
;370:			return NULL;
CNSTP4 0
RETP4
ADDRGP4 $257
JUMPV
LABELV $260
line 373
;371:		}
;372:
;373:		cl = &level.clients[idnum];
ADDRLP4 0
ADDRLP4 8
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 374
;374:		if ( cl->pers.connected == CON_DISCONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 0
NEI4 $265
line 375
;375:			G_Printf( "Client %i is not connected\n", idnum );
ADDRGP4 $267
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 376
;376:			return NULL;
CNSTP4 0
RETP4
ADDRGP4 $257
JUMPV
LABELV $265
line 378
;377:		}
;378:		return cl;
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $257
JUMPV
LABELV $258
line 382
;379:	}
;380:
;381:	// check for a name match
;382:	for ( i=0 ; i < level.maxclients ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $271
JUMPV
LABELV $268
line 383
;383:		cl = &level.clients[i];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 384
;384:		if ( cl->pers.connected == CON_DISCONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 0
NEI4 $273
line 385
;385:			continue;
ADDRGP4 $269
JUMPV
LABELV $273
line 387
;386:		}
;387:		if ( !Q_stricmp( cl->pers.netname, s ) ) {
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $275
line 388
;388:			return cl;
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $257
JUMPV
LABELV $275
line 390
;389:		}
;390:	}
LABELV $269
line 382
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $271
ADDRLP4 4
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $268
line 392
;391:
;392:	G_Printf( "User %s is not on the server\n", s );
ADDRGP4 $277
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 394
;393:
;394:	return NULL;
CNSTP4 0
RETP4
LABELV $257
endproc ClientForString 24 8
export Svcmd_ForceTeam_f
proc Svcmd_ForceTeam_f 1032 12
line 404
;395:}
;396:
;397:/*
;398:===================
;399:Svcmd_ForceTeam_f
;400:
;401:forceteam <player> <team>
;402:===================
;403:*/
;404:void	Svcmd_ForceTeam_f( void ) {
line 409
;405:	gclient_t	*cl;
;406:	char		str[MAX_TOKEN_CHARS];
;407:
;408:	// find the player
;409:	trap_Argv( 1, str, sizeof( str ) );
CNSTI4 1
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 410
;410:	cl = ClientForString( str );
ADDRLP4 0
ARGP4
ADDRLP4 1028
ADDRGP4 ClientForString
CALLP4
ASGNP4
ADDRLP4 1024
ADDRLP4 1028
INDIRP4
ASGNP4
line 411
;411:	if ( !cl ) {
ADDRLP4 1024
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $279
line 412
;412:		return;
ADDRGP4 $278
JUMPV
LABELV $279
line 416
;413:	}
;414:
;415:	// set the team
;416:	trap_Argv( 2, str, sizeof( str ) );
CNSTI4 2
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 417
;417:	SetTeam( &g_entities[cl - level.clients], str );
ADDRLP4 1024
INDIRP4
CVPU4 4
ADDRGP4 level
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 5604
DIVI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 SetTeam
CALLV
pop
line 418
;418:}
LABELV $278
endproc Svcmd_ForceTeam_f 1032 12
proc Svcmd_LoadTemplates_f 0 0
line 425
;419:
;420:/*
;421:===================
;422:JUHOX: Svcmd_LoadTemplates_f
;423:===================
;424:*/
;425:static void Svcmd_LoadTemplates_f(void) {
line 426
;426:	G_LoadGameTemplates();
ADDRGP4 G_LoadGameTemplates
CALLV
pop
line 427
;427:}
LABELV $281
endproc Svcmd_LoadTemplates_f 0 0
proc Svcmd_TmplName_f 1024 12
line 434
;428:
;429:/*
;430:===================
;431:JUHOX: Svcmd_TmplName_f
;432:===================
;433:*/
;434:static void Svcmd_TmplName_f(void) {
line 437
;435:	char arg[MAX_TOKEN_CHARS];
;436:
;437:	trap_Argv(1, arg, sizeof(arg));
CNSTI4 1
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 438
;438:	G_SetTemplateName(arg);
ADDRLP4 0
ARGP4
ADDRGP4 G_SetTemplateName
CALLV
pop
line 439
;439:}
LABELV $282
endproc Svcmd_TmplName_f 1024 12
proc Svcmd_DefTemplate_f 1024 12
line 446
;440:
;441:/*
;442:===================
;443:JUHOX: Svcmd_DefTemplate_f
;444:===================
;445:*/
;446:static void Svcmd_DefTemplate_f(void) {
line 449
;447:	char arg[MAX_TOKEN_CHARS];
;448:
;449:	trap_Argv(1, arg, sizeof(arg));
CNSTI4 1
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 450
;450:	G_DefineTemplate(arg);
ADDRLP4 0
ARGP4
ADDRGP4 G_DefineTemplate
CALLV
pop
line 451
;451:}
LABELV $283
endproc Svcmd_DefTemplate_f 1024 12
proc Svcmd_RestartTemplates_f 0 0
line 458
;452:
;453:/*
;454:===================
;455:JUHOX: Svcmd_RestartTemplates_f
;456:===================
;457:*/
;458:static void Svcmd_RestartTemplates_f(void) {
line 459
;459:	G_RestartGameTemplates();
ADDRGP4 G_RestartGameTemplates
CALLV
pop
line 460
;460:}
LABELV $284
endproc Svcmd_RestartTemplates_f 0 0
proc Svcmd_TemplateList_f 0 0
line 467
;461:
;462:/*
;463:===================
;464:JUHOX: Svcmd_TemplateList_f
;465:===================
;466:*/
;467:static void Svcmd_TemplateList_f(void) {
line 468
;468:	G_PrintTemplateList();
ADDRGP4 G_PrintTemplateList
CALLV
pop
line 469
;469:}
LABELV $285
endproc Svcmd_TemplateList_f 0 0
proc Svcmd_PlayTemplate_f 24 12
line 476
;470:
;471:/*
;472:===================
;473:JUHOX: Svcmd_PlayTemplate_f
;474:===================
;475:*/
;476:static void Svcmd_PlayTemplate_f(void) {
line 479
;477:	char arg[16];
;478:
;479:	if (trap_Argc() != 2) {
ADDRLP4 16
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 2
EQI4 $287
line 480
;480:		G_Printf("Usage: template <template id>\n");
ADDRGP4 $289
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 481
;481:		return;
ADDRGP4 $286
JUMPV
LABELV $287
line 484
;482:	}
;483:
;484:	trap_Argv(1, arg, sizeof(arg));
CNSTI4 1
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 485
;485:	G_PlayTemplate(atoi(arg));
ADDRLP4 0
ARGP4
ADDRLP4 20
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRGP4 G_PlayTemplate
CALLV
pop
line 486
;486:}
LABELV $286
endproc Svcmd_PlayTemplate_f 24 12
export ConsoleCommand
proc ConsoleCommand 1088 12
line 496
;487:
;488:char	*ConcatArgs( int start );
;489:
;490:/*
;491:=================
;492:ConsoleCommand
;493:
;494:=================
;495:*/
;496:qboolean	ConsoleCommand( void ) {
line 499
;497:	char	cmd[MAX_TOKEN_CHARS];
;498:
;499:	trap_Argv( 0, cmd, sizeof( cmd ) );
CNSTI4 0
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 501
;500:
;501:	if ( Q_stricmp (cmd, "entitylist") == 0 ) {
ADDRLP4 0
ARGP4
ADDRGP4 $293
ARGP4
ADDRLP4 1024
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1024
INDIRI4
CNSTI4 0
NEI4 $291
line 502
;502:		Svcmd_EntityList_f();
ADDRGP4 Svcmd_EntityList_f
CALLV
pop
line 503
;503:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $290
JUMPV
LABELV $291
line 506
;504:	}
;505:
;506:	if ( Q_stricmp (cmd, "forceteam") == 0 ) {
ADDRLP4 0
ARGP4
ADDRGP4 $296
ARGP4
ADDRLP4 1028
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 0
NEI4 $294
line 507
;507:		Svcmd_ForceTeam_f();
ADDRGP4 Svcmd_ForceTeam_f
CALLV
pop
line 508
;508:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $290
JUMPV
LABELV $294
line 511
;509:	}
;510:
;511:	if (Q_stricmp (cmd, "game_memory") == 0) {
ADDRLP4 0
ARGP4
ADDRGP4 $299
ARGP4
ADDRLP4 1032
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 0
NEI4 $297
line 512
;512:		Svcmd_GameMem_f();
ADDRGP4 Svcmd_GameMem_f
CALLV
pop
line 513
;513:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $290
JUMPV
LABELV $297
line 516
;514:	}
;515:
;516:	if (Q_stricmp (cmd, "addbot") == 0) {
ADDRLP4 0
ARGP4
ADDRGP4 $302
ARGP4
ADDRLP4 1036
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
NEI4 $300
line 517
;517:		Svcmd_AddBot_f();
ADDRGP4 Svcmd_AddBot_f
CALLV
pop
line 518
;518:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $290
JUMPV
LABELV $300
line 521
;519:	}
;520:
;521:	if (Q_stricmp (cmd, "botlist") == 0) {
ADDRLP4 0
ARGP4
ADDRGP4 $305
ARGP4
ADDRLP4 1040
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $303
line 522
;522:		Svcmd_BotList_f();
ADDRGP4 Svcmd_BotList_f
CALLV
pop
line 523
;523:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $290
JUMPV
LABELV $303
line 526
;524:	}
;525:
;526:	if (Q_stricmp (cmd, "abort_podium") == 0) {
ADDRLP4 0
ARGP4
ADDRGP4 $308
ARGP4
ADDRLP4 1044
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $306
line 527
;527:		Svcmd_AbortPodium_f();
ADDRGP4 Svcmd_AbortPodium_f
CALLV
pop
line 528
;528:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $290
JUMPV
LABELV $306
line 531
;529:	}
;530:
;531:	if (Q_stricmp (cmd, "addip") == 0) {
ADDRLP4 0
ARGP4
ADDRGP4 $311
ARGP4
ADDRLP4 1048
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $309
line 532
;532:		Svcmd_AddIP_f();
ADDRGP4 Svcmd_AddIP_f
CALLV
pop
line 533
;533:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $290
JUMPV
LABELV $309
line 536
;534:	}
;535:
;536:	if (Q_stricmp (cmd, "removeip") == 0) {
ADDRLP4 0
ARGP4
ADDRGP4 $314
ARGP4
ADDRLP4 1052
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 0
NEI4 $312
line 537
;537:		Svcmd_RemoveIP_f();
ADDRGP4 Svcmd_RemoveIP_f
CALLV
pop
line 538
;538:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $290
JUMPV
LABELV $312
line 541
;539:	}
;540:
;541:	if (Q_stricmp (cmd, "listip") == 0) {
ADDRLP4 0
ARGP4
ADDRGP4 $317
ARGP4
ADDRLP4 1056
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
NEI4 $315
line 542
;542:		trap_SendConsoleCommand( EXEC_NOW, "g_banIPs\n" );
CNSTI4 0
ARGI4
ADDRGP4 $318
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 543
;543:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $290
JUMPV
LABELV $315
line 548
;544:	}
;545:
;546:	// JUHOX: template commands
;547:#if 1
;548:	if (Q_stricmp(cmd, "loadtemplates") == 0) {
ADDRLP4 0
ARGP4
ADDRGP4 $321
ARGP4
ADDRLP4 1060
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1060
INDIRI4
CNSTI4 0
NEI4 $319
line 549
;549:		Svcmd_LoadTemplates_f();
ADDRGP4 Svcmd_LoadTemplates_f
CALLV
pop
line 550
;550:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $290
JUMPV
LABELV $319
line 552
;551:	}
;552:	if (level.loadingTemplates) {
ADDRGP4 level+23060
INDIRI4
CNSTI4 0
EQI4 $322
line 553
;553:		if (Q_stricmp(cmd, "tmplname") == 0) {
ADDRLP4 0
ARGP4
ADDRGP4 $327
ARGP4
ADDRLP4 1064
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1064
INDIRI4
CNSTI4 0
NEI4 $325
line 554
;554:			Svcmd_TmplName_f();
ADDRGP4 Svcmd_TmplName_f
CALLV
pop
line 555
;555:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $290
JUMPV
LABELV $325
line 557
;556:		}
;557:		if (Q_stricmp(cmd, "deftemplate") == 0) {
ADDRLP4 0
ARGP4
ADDRGP4 $330
ARGP4
ADDRLP4 1068
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1068
INDIRI4
CNSTI4 0
NEI4 $328
line 558
;558:			Svcmd_DefTemplate_f();
ADDRGP4 Svcmd_DefTemplate_f
CALLV
pop
line 559
;559:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $290
JUMPV
LABELV $328
line 561
;560:		}
;561:	}
LABELV $322
line 562
;562:	if (Q_stricmp(cmd, "templates_restart") == 0) {
ADDRLP4 0
ARGP4
ADDRGP4 $333
ARGP4
ADDRLP4 1064
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1064
INDIRI4
CNSTI4 0
NEI4 $331
line 563
;563:		Svcmd_RestartTemplates_f();
ADDRGP4 Svcmd_RestartTemplates_f
CALLV
pop
line 564
;564:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $290
JUMPV
LABELV $331
line 566
;565:	}
;566:	if (Q_stricmp(cmd, "template") == 0) {
ADDRLP4 0
ARGP4
ADDRGP4 $336
ARGP4
ADDRLP4 1068
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1068
INDIRI4
CNSTI4 0
NEI4 $334
line 567
;567:		Svcmd_PlayTemplate_f();
ADDRGP4 Svcmd_PlayTemplate_f
CALLV
pop
line 568
;568:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $290
JUMPV
LABELV $334
line 570
;569:	}
;570:	if (Q_stricmp(cmd, "templatelist") == 0) {
ADDRLP4 0
ARGP4
ADDRGP4 $339
ARGP4
ADDRLP4 1072
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1072
INDIRI4
CNSTI4 0
NEI4 $337
line 571
;571:		Svcmd_TemplateList_f();
ADDRGP4 Svcmd_TemplateList_f
CALLV
pop
line 572
;572:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $290
JUMPV
LABELV $337
line 576
;573:	}
;574:#endif
;575:
;576:	if (g_dedicated.integer) {
ADDRGP4 g_dedicated+12
INDIRI4
CNSTI4 0
EQI4 $340
line 577
;577:		if (Q_stricmp (cmd, "say") == 0) {
ADDRLP4 0
ARGP4
ADDRGP4 $345
ARGP4
ADDRLP4 1076
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1076
INDIRI4
CNSTI4 0
NEI4 $343
line 578
;578:			trap_SendServerCommand( -1, va("print \"server: %s\"", ConcatArgs(1) ) );
CNSTI4 1
ARGI4
ADDRLP4 1080
ADDRGP4 ConcatArgs
CALLP4
ASGNP4
ADDRGP4 $346
ARGP4
ADDRLP4 1080
INDIRP4
ARGP4
ADDRLP4 1084
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 1084
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 579
;579:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $290
JUMPV
LABELV $343
line 582
;580:		}
;581:		// everything else will also be printed as a say command
;582:		trap_SendServerCommand( -1, va("print \"server: %s\"", ConcatArgs(0) ) );
CNSTI4 0
ARGI4
ADDRLP4 1080
ADDRGP4 ConcatArgs
CALLP4
ASGNP4
ADDRGP4 $346
ARGP4
ADDRLP4 1080
INDIRP4
ARGP4
ADDRLP4 1084
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 1084
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 583
;583:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $290
JUMPV
LABELV $340
line 586
;584:	}
;585:
;586:	return qfalse;
CNSTI4 0
RETI4
LABELV $290
endproc ConsoleCommand 1088 12
import ConcatArgs
bss
align 4
LABELV numIPFilters
skip 4
align 4
LABELV ipFilters
skip 8192
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
import G_EFH_NextDebugSegment
import G_EFH_SpaceExtent
import G_UpdateLightingOrigins
import G_GetTotalWayLength
import G_MakeWorldAwareOfMonsterDeath
import G_FindSegment
import G_UpdateWorld
import G_SpawnWorld
import G_InitWorldSystem
import G_NewString
import G_SpawnEntitiesFromString
import G_SpawnVector
import G_SpawnInt
import G_SpawnFloat
import G_SpawnString
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
LABELV $346
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 34
byte 1 0
align 1
LABELV $345
byte 1 115
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $339
byte 1 116
byte 1 101
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $336
byte 1 116
byte 1 101
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $333
byte 1 116
byte 1 101
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 101
byte 1 115
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $330
byte 1 100
byte 1 101
byte 1 102
byte 1 116
byte 1 101
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $327
byte 1 116
byte 1 109
byte 1 112
byte 1 108
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $321
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 116
byte 1 101
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $318
byte 1 103
byte 1 95
byte 1 98
byte 1 97
byte 1 110
byte 1 73
byte 1 80
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $317
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $314
byte 1 114
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $311
byte 1 97
byte 1 100
byte 1 100
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $308
byte 1 97
byte 1 98
byte 1 111
byte 1 114
byte 1 116
byte 1 95
byte 1 112
byte 1 111
byte 1 100
byte 1 105
byte 1 117
byte 1 109
byte 1 0
align 1
LABELV $305
byte 1 98
byte 1 111
byte 1 116
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $302
byte 1 97
byte 1 100
byte 1 100
byte 1 98
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $299
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 95
byte 1 109
byte 1 101
byte 1 109
byte 1 111
byte 1 114
byte 1 121
byte 1 0
align 1
LABELV $296
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $293
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $289
byte 1 85
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 116
byte 1 101
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 60
byte 1 116
byte 1 101
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 105
byte 1 100
byte 1 62
byte 1 10
byte 1 0
align 1
LABELV $277
byte 1 85
byte 1 115
byte 1 101
byte 1 114
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 10
byte 1 0
align 1
LABELV $267
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $264
byte 1 66
byte 1 97
byte 1 100
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 115
byte 1 108
byte 1 111
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $256
byte 1 10
byte 1 0
align 1
LABELV $255
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $251
byte 1 37
byte 1 51
byte 1 105
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $250
byte 1 69
byte 1 84
byte 1 95
byte 1 71
byte 1 82
byte 1 65
byte 1 80
byte 1 80
byte 1 76
byte 1 69
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $248
byte 1 69
byte 1 84
byte 1 95
byte 1 73
byte 1 78
byte 1 86
byte 1 73
byte 1 83
byte 1 73
byte 1 66
byte 1 76
byte 1 69
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $246
byte 1 69
byte 1 84
byte 1 95
byte 1 84
byte 1 69
byte 1 76
byte 1 69
byte 1 80
byte 1 79
byte 1 82
byte 1 84
byte 1 95
byte 1 84
byte 1 82
byte 1 73
byte 1 71
byte 1 71
byte 1 69
byte 1 82
byte 1 32
byte 1 0
align 1
LABELV $244
byte 1 69
byte 1 84
byte 1 95
byte 1 80
byte 1 85
byte 1 83
byte 1 72
byte 1 95
byte 1 84
byte 1 82
byte 1 73
byte 1 71
byte 1 71
byte 1 69
byte 1 82
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $242
byte 1 69
byte 1 84
byte 1 95
byte 1 83
byte 1 80
byte 1 69
byte 1 65
byte 1 75
byte 1 69
byte 1 82
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $240
byte 1 69
byte 1 84
byte 1 95
byte 1 80
byte 1 79
byte 1 82
byte 1 84
byte 1 65
byte 1 76
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $238
byte 1 69
byte 1 84
byte 1 95
byte 1 66
byte 1 69
byte 1 65
byte 1 77
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $236
byte 1 69
byte 1 84
byte 1 95
byte 1 77
byte 1 79
byte 1 86
byte 1 69
byte 1 82
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $234
byte 1 69
byte 1 84
byte 1 95
byte 1 77
byte 1 73
byte 1 83
byte 1 83
byte 1 73
byte 1 76
byte 1 69
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $232
byte 1 69
byte 1 84
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $230
byte 1 69
byte 1 84
byte 1 95
byte 1 80
byte 1 76
byte 1 65
byte 1 89
byte 1 69
byte 1 82
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $228
byte 1 69
byte 1 84
byte 1 95
byte 1 71
byte 1 69
byte 1 78
byte 1 69
byte 1 82
byte 1 65
byte 1 76
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $223
byte 1 37
byte 1 51
byte 1 105
byte 1 58
byte 1 0
align 1
LABELV $213
byte 1 68
byte 1 105
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 102
byte 1 105
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $212
byte 1 82
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $200
byte 1 85
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 32
byte 1 115
byte 1 118
byte 1 32
byte 1 114
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 105
byte 1 112
byte 1 32
byte 1 60
byte 1 105
byte 1 112
byte 1 45
byte 1 109
byte 1 97
byte 1 115
byte 1 107
byte 1 62
byte 1 10
byte 1 0
align 1
LABELV $196
byte 1 85
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 32
byte 1 97
byte 1 100
byte 1 100
byte 1 105
byte 1 112
byte 1 32
byte 1 60
byte 1 105
byte 1 112
byte 1 45
byte 1 109
byte 1 97
byte 1 115
byte 1 107
byte 1 62
byte 1 10
byte 1 0
align 1
LABELV $175
byte 1 73
byte 1 80
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 102
byte 1 117
byte 1 108
byte 1 108
byte 1 10
byte 1 0
align 1
LABELV $135
byte 1 103
byte 1 95
byte 1 98
byte 1 97
byte 1 110
byte 1 73
byte 1 80
byte 1 115
byte 1 0
align 1
LABELV $134
byte 1 103
byte 1 95
byte 1 98
byte 1 97
byte 1 110
byte 1 73
byte 1 80
byte 1 115
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
byte 1 97
byte 1 116
byte 1 32
byte 1 77
byte 1 65
byte 1 88
byte 1 95
byte 1 67
byte 1 86
byte 1 65
byte 1 82
byte 1 95
byte 1 86
byte 1 65
byte 1 76
byte 1 85
byte 1 69
byte 1 95
byte 1 83
byte 1 84
byte 1 82
byte 1 73
byte 1 78
byte 1 71
byte 1 10
byte 1 0
align 1
LABELV $128
byte 1 32
byte 1 0
align 1
LABELV $127
byte 1 46
byte 1 0
align 1
LABELV $126
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $125
byte 1 42
byte 1 0
align 1
LABELV $103
byte 1 66
byte 1 97
byte 1 100
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 97
byte 1 100
byte 1 100
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
