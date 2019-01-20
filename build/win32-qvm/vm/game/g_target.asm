export Use_Target_Give
code
proc Use_Target_Give 64 12
file "..\..\..\..\code\game\g_target.c"
line 10
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:#include "g_local.h"
;4:
;5://==========================================================
;6:
;7:/*QUAKED target_give (1 0 0) (-8 -8 -8) (8 8 8)
;8:Gives the activator all the items pointed to.
;9:*/
;10:void Use_Target_Give( gentity_t *ent, gentity_t *other, gentity_t *activator ) {
line 14
;11:	gentity_t	*t;
;12:	trace_t		trace;
;13:
;14:	if ( !activator->client ) {
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $88
line 15
;15:		return;
ADDRGP4 $87
JUMPV
LABELV $88
line 18
;16:	}
;17:
;18:	if ( !ent->target ) {
ADDRFP4 0
INDIRP4
CNSTI4 652
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $90
line 19
;19:		return;
ADDRGP4 $87
JUMPV
LABELV $90
line 22
;20:	}
;21:
;22:	memset( &trace, 0, sizeof( trace ) );
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 56
ARGI4
ADDRGP4 memset
CALLP4
pop
line 23
;23:	t = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
ADDRGP4 $93
JUMPV
LABELV $92
line 24
;24:	while ( (t = G_Find (t, FOFS(targetname), ent->target)) != NULL ) {
line 25
;25:		if ( !t->item ) {
ADDRLP4 0
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $95
line 26
;26:			continue;
ADDRGP4 $93
JUMPV
LABELV $95
line 28
;27:		}
;28:		Touch_Item( t, activator, &trace );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 Touch_Item
CALLV
pop
line 31
;29:
;30:		// make sure it isn't going to respawn or show any events
;31:		t->nextthink = 0;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
CNSTI4 0
ASGNI4
line 32
;32:		trap_UnlinkEntity( t );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 33
;33:	}
LABELV $93
line 24
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 656
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 652
ADDP4
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 60
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $92
line 34
;34:}
LABELV $87
endproc Use_Target_Give 64 12
export SP_target_give
proc SP_target_give 0 0
line 36
;35:
;36:void SP_target_give( gentity_t *ent ) {
line 37
;37:	ent->use = Use_Target_Give;
ADDRFP4 0
INDIRP4
CNSTI4 712
ADDP4
ADDRGP4 Use_Target_Give
ASGNP4
line 39
;38:#if ESCAPE_MODE	// JUHOX: set entity class
;39:	ent->entClass = GEC_target_give;
ADDRFP4 0
INDIRP4
CNSTI4 824
ADDP4
CNSTI4 20
ASGNI4
line 41
;40:#endif
;41:}
LABELV $97
endproc SP_target_give 0 0
export Use_target_remove_powerups
proc Use_target_remove_powerups 0 12
line 50
;42:
;43:
;44://==========================================================
;45:
;46:/*QUAKED target_remove_powerups (1 0 0) (-8 -8 -8) (8 8 8)
;47:takes away all the activators powerups.
;48:Used to drop flight powerups into death puts.
;49:*/
;50:void Use_target_remove_powerups( gentity_t *ent, gentity_t *other, gentity_t *activator ) {
line 51
;51:	if( !activator->client ) {
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $99
line 52
;52:		return;
ADDRGP4 $98
JUMPV
LABELV $99
line 55
;53:	}
;54:
;55:	if( activator->client->ps.powerups[PW_REDFLAG] ) {
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
EQI4 $101
line 56
;56:		Team_ReturnFlag( TEAM_RED );
CNSTI4 1
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 57
;57:	} else if( activator->client->ps.powerups[PW_BLUEFLAG] ) {
ADDRGP4 $102
JUMPV
LABELV $101
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
EQI4 $103
line 58
;58:		Team_ReturnFlag( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 59
;59:	} else if( activator->client->ps.powerups[PW_NEUTRALFLAG] ) {
ADDRGP4 $104
JUMPV
LABELV $103
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
CNSTI4 0
EQI4 $105
line 60
;60:		Team_ReturnFlag( TEAM_FREE );
CNSTI4 0
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 61
;61:	}
LABELV $105
LABELV $104
LABELV $102
line 67
;62:
;63:	// JUHOX: only remove "real" powerups
;64:#if 0
;65:	memset( activator->client->ps.powerups, 0, sizeof( activator->client->ps.powerups ) );
;66:#else
;67:	memset(activator->client->ps.powerups, 0, PW_NUM_POWERUPS * sizeof(int));
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 52
ARGI4
ADDRGP4 memset
CALLP4
pop
line 69
;68:#endif
;69:}
LABELV $98
endproc Use_target_remove_powerups 0 12
export SP_target_remove_powerups
proc SP_target_remove_powerups 0 0
line 71
;70:
;71:void SP_target_remove_powerups( gentity_t *ent ) {
line 72
;72:	ent->use = Use_target_remove_powerups;
ADDRFP4 0
INDIRP4
CNSTI4 712
ADDP4
ADDRGP4 Use_target_remove_powerups
ASGNP4
line 74
;73:#if ESCAPE_MODE	// JUHOX: set entity class
;74:	ent->entClass = GEC_target_remove_powerups;
ADDRFP4 0
INDIRP4
CNSTI4 824
ADDP4
CNSTI4 19
ASGNI4
line 76
;75:#endif
;76:}
LABELV $107
endproc SP_target_remove_powerups 0 0
export Think_Target_Delay
proc Think_Target_Delay 4 8
line 85
;77:
;78:
;79://==========================================================
;80:
;81:/*QUAKED target_delay (1 0 0) (-8 -8 -8) (8 8 8)
;82:"wait" seconds to pause before firing targets.
;83:"random" delay variance, total delay = delay +/- random seconds
;84:*/
;85:void Think_Target_Delay( gentity_t *ent ) {
line 86
;86:	G_UseTargets( ent, ent->activator );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_UseTargets
CALLV
pop
line 87
;87:}
LABELV $108
endproc Think_Target_Delay 4 8
export Use_Target_Delay
proc Use_Target_Delay 8 0
line 89
;88:
;89:void Use_Target_Delay( gentity_t *ent, gentity_t *other, gentity_t *activator ) {
line 90
;90:	ent->nextthink = level.time + ( ent->wait + ent->random * crandom() ) * 1000;
ADDRLP4 0
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 level+32
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRP4
CNSTI4 800
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 804
ADDP4
INDIRF4
ADDRLP4 0
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 0
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
CNSTF4 1073741824
MULF4
MULF4
ADDF4
CNSTF4 1148846080
MULF4
ADDF4
CVFI4 4
ASGNI4
line 91
;91:	ent->think = Think_Target_Delay;
ADDRFP4 0
INDIRP4
CNSTI4 696
ADDP4
ADDRGP4 Think_Target_Delay
ASGNP4
line 92
;92:	ent->activator = activator;
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
ADDRFP4 8
INDIRP4
ASGNP4
line 93
;93:}
LABELV $109
endproc Use_Target_Delay 8 0
export SP_target_delay
proc SP_target_delay 4 12
line 95
;94:
;95:void SP_target_delay( gentity_t *ent ) {
line 97
;96:	// check delay for backwards compatability
;97:	if ( !G_SpawnFloat( "delay", "0", &ent->wait ) ) {
ADDRGP4 $114
ARGP4
ADDRGP4 $115
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 800
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 G_SpawnFloat
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $112
line 98
;98:		G_SpawnFloat( "wait", "1", &ent->wait );
ADDRGP4 $116
ARGP4
ADDRGP4 $117
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 800
ADDP4
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 99
;99:	}
LABELV $112
line 101
;100:
;101:	if ( !ent->wait ) {
ADDRFP4 0
INDIRP4
CNSTI4 800
ADDP4
INDIRF4
CNSTF4 0
NEF4 $118
line 102
;102:		ent->wait = 1;
ADDRFP4 0
INDIRP4
CNSTI4 800
ADDP4
CNSTF4 1065353216
ASGNF4
line 103
;103:	}
LABELV $118
line 104
;104:	ent->use = Use_Target_Delay;
ADDRFP4 0
INDIRP4
CNSTI4 712
ADDP4
ADDRGP4 Use_Target_Delay
ASGNP4
line 106
;105:#if ESCAPE_MODE	// JUHOX: set entity class
;106:	ent->entClass = GEC_target_delay;
ADDRFP4 0
INDIRP4
CNSTI4 824
ADDP4
CNSTI4 21
ASGNI4
line 108
;107:#endif
;108:}
LABELV $111
endproc SP_target_delay 4 12
export Use_Target_Score
proc Use_Target_Score 4 12
line 118
;109:
;110:
;111://==========================================================
;112:
;113:/*QUAKED target_score (1 0 0) (-8 -8 -8) (8 8 8)
;114:"count" number of points to add, default 1
;115:
;116:The activator is given this many points.
;117:*/
;118:void Use_Target_Score (gentity_t *ent, gentity_t *other, gentity_t *activator) {
line 119
;119:	AddScore( activator, ent->r.currentOrigin, ent->count );
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 764
ADDP4
INDIRI4
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 120
;120:}
LABELV $120
endproc Use_Target_Score 4 12
export SP_target_score
proc SP_target_score 0 0
line 122
;121:
;122:void SP_target_score( gentity_t *ent ) {
line 123
;123:	if ( !ent->count ) {
ADDRFP4 0
INDIRP4
CNSTI4 764
ADDP4
INDIRI4
CNSTI4 0
NEI4 $122
line 124
;124:		ent->count = 1;
ADDRFP4 0
INDIRP4
CNSTI4 764
ADDP4
CNSTI4 1
ASGNI4
line 125
;125:	}
LABELV $122
line 126
;126:	ent->use = Use_Target_Score;
ADDRFP4 0
INDIRP4
CNSTI4 712
ADDP4
ADDRGP4 Use_Target_Score
ASGNP4
line 128
;127:#if ESCAPE_MODE	// JUHOX: set entity class
;128:	ent->entClass = GEC_target_score;
ADDRFP4 0
INDIRP4
CNSTI4 824
ADDP4
CNSTI4 26
ASGNI4
line 130
;129:#endif
;130:}
LABELV $121
endproc SP_target_score 0 0
export Use_Target_Print
proc Use_Target_Print 4 8
line 139
;131:
;132:
;133://==========================================================
;134:
;135:/*QUAKED target_print (1 0 0) (-8 -8 -8) (8 8 8) redteam blueteam private
;136:"message"	text to print
;137:If "private", only the activator gets the message.  If no checks, all clients get the message.
;138:*/
;139:void Use_Target_Print (gentity_t *ent, gentity_t *other, gentity_t *activator) {
line 140
;140:	if ( activator->client && ( ent->spawnflags & 4 ) ) {
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $125
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $125
line 141
;141:		trap_SendServerCommand( activator-g_entities, va("cp \"%s\"", ent->message ));
ADDRGP4 $127
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 640
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 8
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 844
DIVI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 142
;142:		return;
ADDRGP4 $124
JUMPV
LABELV $125
line 145
;143:	}
;144:
;145:	if ( ent->spawnflags & 3 ) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $128
line 146
;146:		if ( ent->spawnflags & 1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $130
line 147
;147:			G_TeamCommand( TEAM_RED, va("cp \"%s\"", ent->message) );
ADDRGP4 $127
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 640
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_TeamCommand
CALLV
pop
line 148
;148:		}
LABELV $130
line 149
;149:		if ( ent->spawnflags & 2 ) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $124
line 150
;150:			G_TeamCommand( TEAM_BLUE, va("cp \"%s\"", ent->message) );
ADDRGP4 $127
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 640
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_TeamCommand
CALLV
pop
line 151
;151:		}
line 152
;152:		return;
ADDRGP4 $124
JUMPV
LABELV $128
line 155
;153:	}
;154:
;155:	trap_SendServerCommand( -1, va("cp \"%s\"", ent->message ));
ADDRGP4 $127
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 640
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 156
;156:}
LABELV $124
endproc Use_Target_Print 4 8
export SP_target_print
proc SP_target_print 0 0
line 158
;157:
;158:void SP_target_print( gentity_t *ent ) {
line 159
;159:	ent->use = Use_Target_Print;
ADDRFP4 0
INDIRP4
CNSTI4 712
ADDP4
ADDRGP4 Use_Target_Print
ASGNP4
line 161
;160:#if ESCAPE_MODE	// JUHOX: set entity class
;161:	ent->entClass = GEC_target_print;
ADDRFP4 0
INDIRP4
CNSTI4 824
ADDP4
CNSTI4 24
ASGNI4
line 163
;162:#endif
;163:}
LABELV $134
endproc SP_target_print 0 0
export Use_Target_Speaker
proc Use_Target_Speaker 4 12
line 181
;164:
;165:
;166://==========================================================
;167:
;168:
;169:/*QUAKED target_speaker (1 0 0) (-8 -8 -8) (8 8 8) looped-on looped-off global activator
;170:"noise"		wav file to play
;171:
;172:A global sound will play full volume throughout the level.
;173:Activator sounds will play on the player that activated the target.
;174:Global and activator sounds can't be combined with looping.
;175:Normal sounds play each time the target is used.
;176:Looped sounds will be toggled by use functions.
;177:Multiple identical looping sounds will just increase volume without any speed cost.
;178:"wait" : Seconds between auto triggerings, 0 = don't auto trigger
;179:"random"	wait variance, default is 0
;180:*/
;181:void Use_Target_Speaker (gentity_t *ent, gentity_t *other, gentity_t *activator) {
line 182
;182:	if (ent->spawnflags & 3) {	// looping sound toggles
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $136
line 183
;183:		if (ent->s.loopSound)
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRI4
CNSTI4 0
EQI4 $138
line 184
;184:			ent->s.loopSound = 0;	// turn it off
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
CNSTI4 0
ASGNI4
ADDRGP4 $137
JUMPV
LABELV $138
line 186
;185:		else
;186:			ent->s.loopSound = ent->noise_index;	// start it
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 796
ADDP4
INDIRI4
ASGNI4
line 187
;187:	}else {	// normal sound
ADDRGP4 $137
JUMPV
LABELV $136
line 188
;188:		if ( ent->spawnflags & 8 ) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $140
line 189
;189:			G_AddEvent( activator, EV_GENERAL_SOUND, ent->noise_index );
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 46
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 796
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 190
;190:		} else if (ent->spawnflags & 4) {
ADDRGP4 $141
JUMPV
LABELV $140
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $142
line 191
;191:			G_AddEvent( ent, EV_GLOBAL_SOUND, ent->noise_index );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 796
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 192
;192:		} else {
ADDRGP4 $143
JUMPV
LABELV $142
line 193
;193:			G_AddEvent( ent, EV_GENERAL_SOUND, ent->noise_index );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 46
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 796
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 194
;194:		}
LABELV $143
LABELV $141
line 195
;195:	}
LABELV $137
line 196
;196:}
LABELV $135
endproc Use_Target_Speaker 4 12
export SP_target_speaker
proc SP_target_speaker 96 16
line 198
;197:
;198:void SP_target_speaker( gentity_t *ent ) {
line 202
;199:	char	buffer[MAX_QPATH];
;200:	char	*s;
;201:
;202:	G_SpawnFloat( "wait", "0", &ent->wait );
ADDRGP4 $116
ARGP4
ADDRGP4 $115
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 800
ADDP4
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 203
;203:	G_SpawnFloat( "random", "0", &ent->random );
ADDRGP4 $145
ARGP4
ADDRGP4 $115
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 205
;204:
;205:	if ( !G_SpawnString( "noise", "NOSOUND", &s ) ) {
ADDRGP4 $148
ARGP4
ADDRGP4 $149
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 68
ADDRGP4 G_SpawnString
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
NEI4 $146
line 206
;206:		G_Error( "target_speaker without a noise key at %s", vtos( ent->s.origin ) );
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 72
ADDRGP4 vtos
CALLP4
ASGNP4
ADDRGP4 $150
ARGP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 207
;207:	}
LABELV $146
line 211
;208:
;209:	// force all client reletive sounds to be "activator" speakers that
;210:	// play on the entity that activates it
;211:	if ( s[0] == '*' ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $151
line 212
;212:		ent->spawnflags |= 8;
ADDRLP4 72
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 213
;213:	}
LABELV $151
line 215
;214:
;215:	if (!strstr( s, ".wav" )) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $155
ARGP4
ADDRLP4 72
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 72
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $153
line 216
;216:		Com_sprintf (buffer, sizeof(buffer), "%s.wav", s );
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $156
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 217
;217:	} else {
ADDRGP4 $154
JUMPV
LABELV $153
line 218
;218:		Q_strncpyz( buffer, s, sizeof(buffer) );
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 219
;219:	}
LABELV $154
line 220
;220:	ent->noise_index = G_SoundIndex(buffer);
ADDRLP4 4
ARGP4
ADDRLP4 76
ADDRGP4 G_SoundIndex
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 796
ADDP4
ADDRLP4 76
INDIRI4
ASGNI4
line 223
;221:
;222:	// a repeating speaker can be done completely client side
;223:	ent->s.eType = ET_SPEAKER;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 7
ASGNI4
line 224
;224:	ent->s.eventParm = ent->noise_index;
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 80
INDIRP4
CNSTI4 796
ADDP4
INDIRI4
ASGNI4
line 225
;225:	ent->s.frame = ent->wait * 10;
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 172
ADDP4
ADDRLP4 84
INDIRP4
CNSTI4 800
ADDP4
INDIRF4
CNSTF4 1092616192
MULF4
CVFI4 4
ASGNI4
line 226
;226:	ent->s.clientNum = ent->random * 10;
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 168
ADDP4
ADDRLP4 88
INDIRP4
CNSTI4 804
ADDP4
INDIRF4
CNSTF4 1092616192
MULF4
CVFI4 4
ASGNI4
line 230
;227:
;228:
;229:	// check for prestarted looping sound
;230:	if ( ent->spawnflags & 1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $157
line 231
;231:		ent->s.loopSound = ent->noise_index;
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 156
ADDP4
ADDRLP4 92
INDIRP4
CNSTI4 796
ADDP4
INDIRI4
ASGNI4
line 232
;232:	}
LABELV $157
line 234
;233:
;234:	ent->use = Use_Target_Speaker;
ADDRFP4 0
INDIRP4
CNSTI4 712
ADDP4
ADDRGP4 Use_Target_Speaker
ASGNP4
line 236
;235:
;236:	if (ent->spawnflags & 4) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $159
line 237
;237:		ent->r.svFlags |= SVF_BROADCAST;
ADDRLP4 92
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 238
;238:	}
LABELV $159
line 240
;239:
;240:	VectorCopy( ent->s.origin, ent->s.pos.trBase );
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 92
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 244
;241:
;242:	// must link the entity so we get areas and clusters so
;243:	// the server can determine who to send updates to
;244:	trap_LinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 246
;245:#if ESCAPE_MODE	// JUHOX: set entity class
;246:	ent->entClass = GEC_target_speaker;
ADDRFP4 0
INDIRP4
CNSTI4 824
ADDP4
CNSTI4 22
ASGNI4
line 248
;247:#endif
;248:}
LABELV $144
endproc SP_target_speaker 96 16
proc Use_target_earthquake 8 8
line 260
;249:
;250:
;251:
;252://==========================================================
;253:
;254:/*
;255:==============
;256:JUHOX: Use_target_earthquake
;257:==============
;258:*/
;259:#if MONSTER_MODE
;260:static void Use_target_earthquake(gentity_t* ent, gentity_t* other, gentity_t* activator) {
line 263
;261:	gentity_t* event;
;262:
;263:	event = G_TempEntity(ent->s.origin, EV_EARTHQUAKE);
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
CNSTI4 93
ARGI4
ADDRLP4 4
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 264
;264:	if (event) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $162
line 265
;265:		VectorCopy(ent->s.angles, event->s.angles);
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 266
;266:		VectorCopy(ent->s.angles2, event->s.angles2);
ADDRLP4 0
INDIRP4
CNSTI4 128
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
INDIRB
ASGNB 12
line 267
;267:	}
LABELV $162
line 268
;268:}
LABELV $161
endproc Use_target_earthquake 8 8
export SP_target_earthquake
proc SP_target_earthquake 8 12
line 277
;269:#endif
;270:
;271:/*
;272:==============
;273:JUHOX: SP_target_earthquake
;274:==============
;275:*/
;276:#if MONSTER_MODE
;277:void SP_target_earthquake(gentity_t* ent) {
line 278
;278:	G_SpawnFloat("duration", "10", &ent->s.angles[0]);
ADDRGP4 $165
ARGP4
ADDRGP4 $166
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 279
;279:	G_SpawnFloat("fadein", "1", &ent->s.angles[1]);
ADDRGP4 $167
ARGP4
ADDRGP4 $117
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 280
;280:	G_SpawnFloat("fadeout", "1", &ent->s.angles[2]);
ADDRGP4 $168
ARGP4
ADDRGP4 $117
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 281
;281:	G_SpawnFloat("amplitude", "100", &ent->s.angles2[0]);
ADDRGP4 $169
ARGP4
ADDRGP4 $170
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 282
;282:	G_SpawnFloat("radius", "-1", &ent->s.angles2[1]);
ADDRGP4 $171
ARGP4
ADDRGP4 $172
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 132
ADDP4
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 284
;283:
;284:	if (ent->s.angles[0] < ent->s.angles[1] + ent->s.angles[2]) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
ADDF4
GEF4 $173
line 285
;285:		ent->s.angles[0] = ent->s.angles[1] + ent->s.angles[2];
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 116
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
ADDF4
ASGNF4
line 286
;286:	}
LABELV $173
line 288
;287:
;288:	ent->use = Use_target_earthquake;
ADDRFP4 0
INDIRP4
CNSTI4 712
ADDP4
ADDRGP4 Use_target_earthquake
ASGNP4
line 291
;289:
;290:#if ESCAPE_MODE
;291:	ent->entClass = GEC_target_earthquake;
ADDRFP4 0
INDIRP4
CNSTI4 824
ADDP4
CNSTI4 23
ASGNI4
line 293
;292:#endif
;293:}
LABELV $164
endproc SP_target_earthquake 8 12
export target_laser_think
proc target_laser_think 104 32
line 302
;294:#endif
;295:
;296:
;297://==========================================================
;298:
;299:/*QUAKED target_laser (0 .5 .8) (-8 -8 -8) (8 8 8) START_ON
;300:When triggered, fires a laser.  You can either set a target or a direction.
;301:*/
;302:void target_laser_think (gentity_t *self) {
line 308
;303:	vec3_t	end;
;304:	trace_t	tr;
;305:	vec3_t	point;
;306:
;307:	// if pointed at another entity, set movedir to point at it
;308:	if ( self->enemy ) {
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $176
line 309
;309:		VectorMA (self->enemy->s.origin, 0.5, self->enemy->r.mins, point);
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 80
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
CNSTF4 1056964608
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 80
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 440
ADDP4
INDIRF4
CNSTF4 1056964608
MULF4
ADDF4
ASGNF4
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 84
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ADDRLP4 84
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 444
ADDP4
INDIRF4
CNSTF4 1056964608
MULF4
ADDF4
ASGNF4
line 310
;310:		VectorMA (point, 0.5, self->enemy->r.maxs, point);
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 88
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 448
ADDP4
INDIRF4
CNSTF4 1056964608
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 88
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 452
ADDP4
INDIRF4
CNSTF4 1056964608
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CNSTF4 1056964608
MULF4
ADDF4
ASGNF4
line 311
;311:		VectorSubtract (point, self->s.origin, self->movedir);
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 680
ADDP4
ADDRLP4 0
INDIRF4
ADDRLP4 92
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 96
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CNSTI4 684
ADDP4
ADDRLP4 0+4
INDIRF4
ADDRLP4 96
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
CNSTI4 688
ADDP4
ADDRLP4 0+8
INDIRF4
ADDRLP4 100
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ASGNF4
line 312
;312:		VectorNormalize (self->movedir);
ADDRFP4 0
INDIRP4
CNSTI4 680
ADDP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 313
;313:	}
LABELV $176
line 316
;314:
;315:	// fire forward and see what we hit
;316:	VectorMA (self->s.origin, 2048, self->movedir, end);
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 80
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 680
ADDP4
INDIRF4
CNSTF4 1157627904
MULF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 80
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 684
ADDP4
INDIRF4
CNSTF4 1157627904
MULF4
ADDF4
ASGNF4
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12+8
ADDRLP4 84
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ADDRLP4 84
INDIRP4
CNSTI4 688
ADDP4
INDIRF4
CNSTF4 1157627904
MULF4
ADDF4
ASGNF4
line 318
;317:
;318:	trap_Trace( &tr, self->s.origin, NULL, NULL, end, self->s.number, CONTENTS_SOLID|CONTENTS_BODY|CONTENTS_CORPSE);
ADDRLP4 24
ARGP4
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 92
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 88
INDIRP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 320
;319:
;320:	if ( tr.entityNum ) {
ADDRLP4 24+52
INDIRI4
CNSTI4 0
EQI4 $188
line 322
;321:		// hurt it if we can
;322:		G_Damage ( &g_entities[tr.entityNum], self, self->activator, self->movedir, 
ADDRLP4 24+52
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
ARGP4
ADDRLP4 92
INDIRP4
CNSTI4 776
ADDP4
INDIRP4
ARGP4
ADDRLP4 92
INDIRP4
CNSTI4 680
ADDP4
ARGP4
ADDRLP4 24+12
ARGP4
ADDRLP4 92
INDIRP4
CNSTI4 744
ADDP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
CNSTI4 26
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 324
;323:			tr.endpos, self->damage, DAMAGE_NO_KNOCKBACK, MOD_TARGET_LASER);
;324:	}
LABELV $188
line 326
;325:
;326:	VectorCopy (tr.endpos, self->s.origin2);
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 24+12
INDIRB
ASGNB 12
line 328
;327:
;328:	trap_LinkEntity( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 329
;329:	self->nextthink = level.time + FRAMETIME;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 330
;330:}
LABELV $175
endproc target_laser_think 104 32
export target_laser_on
proc target_laser_on 4 4
line 333
;331:
;332:void target_laser_on (gentity_t *self)
;333:{
line 334
;334:	if (!self->activator)
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $196
line 335
;335:		self->activator = self;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 776
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
LABELV $196
line 336
;336:	target_laser_think (self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 target_laser_think
CALLV
pop
line 337
;337:}
LABELV $195
endproc target_laser_on 4 4
export target_laser_off
proc target_laser_off 0 4
line 340
;338:
;339:void target_laser_off (gentity_t *self)
;340:{
line 341
;341:	trap_UnlinkEntity( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 342
;342:	self->nextthink = 0;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
CNSTI4 0
ASGNI4
line 343
;343:}
LABELV $198
endproc target_laser_off 0 4
export target_laser_use
proc target_laser_use 0 4
line 346
;344:
;345:void target_laser_use (gentity_t *self, gentity_t *other, gentity_t *activator)
;346:{
line 347
;347:	self->activator = activator;
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
ADDRFP4 8
INDIRP4
ASGNP4
line 348
;348:	if ( self->nextthink > 0 )
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
INDIRI4
CNSTI4 0
LEI4 $200
line 349
;349:		target_laser_off (self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 target_laser_off
CALLV
pop
ADDRGP4 $201
JUMPV
LABELV $200
line 351
;350:	else
;351:		target_laser_on (self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 target_laser_on
CALLV
pop
LABELV $201
line 352
;352:}
LABELV $199
endproc target_laser_use 0 4
export target_laser_start
proc target_laser_start 16 16
line 355
;353:
;354:void target_laser_start (gentity_t *self)
;355:{
line 358
;356:	gentity_t *ent;
;357:
;358:	self->s.eType = ET_BEAM;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 5
ASGNI4
line 360
;359:
;360:	if (self->target) {
ADDRFP4 0
INDIRP4
CNSTI4 652
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $203
line 361
;361:		ent = G_Find (NULL, FOFS(targetname), self->target);
CNSTP4 0
ARGP4
CNSTI4 656
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 652
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 362
;362:		if (!ent) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $205
line 363
;363:			G_Printf ("%s at %s: %s is a bad target\n", self->classname, vtos(self->s.origin), self->target);
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 8
ADDRGP4 vtos
CALLP4
ASGNP4
ADDRGP4 $207
ARGP4
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 652
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 364
;364:		}
LABELV $205
line 365
;365:		self->enemy = ent;
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 366
;366:	} else {
ADDRGP4 $204
JUMPV
LABELV $203
line 367
;367:		G_SetMovedir (self->s.angles, self->movedir);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 680
ADDP4
ARGP4
ADDRGP4 G_SetMovedir
CALLV
pop
line 368
;368:	}
LABELV $204
line 370
;369:
;370:	self->use = target_laser_use;
ADDRFP4 0
INDIRP4
CNSTI4 712
ADDP4
ADDRGP4 target_laser_use
ASGNP4
line 371
;371:	self->think = target_laser_think;
ADDRFP4 0
INDIRP4
CNSTI4 696
ADDP4
ADDRGP4 target_laser_think
ASGNP4
line 373
;372:
;373:	if ( !self->damage ) {
ADDRFP4 0
INDIRP4
CNSTI4 744
ADDP4
INDIRI4
CNSTI4 0
NEI4 $208
line 374
;374:		self->damage = 1;
ADDRFP4 0
INDIRP4
CNSTI4 744
ADDP4
CNSTI4 1
ASGNI4
line 375
;375:	}
LABELV $208
line 377
;376:
;377:	if (self->spawnflags & 1)
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $210
line 378
;378:		target_laser_on (self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 target_laser_on
CALLV
pop
ADDRGP4 $211
JUMPV
LABELV $210
line 380
;379:	else
;380:		target_laser_off (self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 target_laser_off
CALLV
pop
LABELV $211
line 381
;381:}
LABELV $202
endproc target_laser_start 16 16
export SP_target_laser
proc SP_target_laser 0 0
line 384
;382:
;383:void SP_target_laser (gentity_t *self)
;384:{
line 386
;385:	// let everything else get spawned before we start firing
;386:	self->think = target_laser_start;
ADDRFP4 0
INDIRP4
CNSTI4 696
ADDP4
ADDRGP4 target_laser_start
ASGNP4
line 387
;387:	self->nextthink = level.time + FRAMETIME;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 389
;388:#if ESCAPE_MODE	// JUHOX: set entity class
;389:	self->entClass = GEC_target_laser;
ADDRFP4 0
INDIRP4
CNSTI4 824
ADDP4
CNSTI4 25
ASGNI4
line 391
;390:#endif
;391:}
LABELV $212
endproc SP_target_laser 0 0
export target_teleporter_use
proc target_teleporter_use 16 12
line 396
;392:
;393:
;394://==========================================================
;395:
;396:void target_teleporter_use( gentity_t *self, gentity_t *other, gentity_t *activator ) {
line 399
;397:	gentity_t	*dest;
;398:
;399:	if (!activator->client)
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $215
line 400
;400:		return;
ADDRGP4 $214
JUMPV
LABELV $215
line 404
;401:#if !ESCAPE_MODE	// JUHOX: G_PickTarget() also needs to know the segment
;402:	dest = 	G_PickTarget( self->target );
;403:#else
;404:	dest = G_PickTarget(self->target, self->worldSegment - 1);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 652
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRLP4 8
ADDRGP4 G_PickTarget
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 406
;405:#endif
;406:	if (!dest) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $217
line 407
;407:		G_Printf ("Couldn't find teleporter destination\n");
ADDRGP4 $219
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 408
;408:		return;
ADDRGP4 $214
JUMPV
LABELV $217
line 411
;409:	}
;410:
;411:	TeleportPlayer( activator, dest->s.origin, dest->s.angles );
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRGP4 TeleportPlayer
CALLV
pop
line 412
;412:}
LABELV $214
endproc target_teleporter_use 16 12
export SP_target_teleporter
proc SP_target_teleporter 4 12
line 417
;413:
;414:/*QUAKED target_teleporter (1 0 0) (-8 -8 -8) (8 8 8)
;415:The activator will be teleported away.
;416:*/
;417:void SP_target_teleporter( gentity_t *self ) {
line 418
;418:	if (!self->targetname)
ADDRFP4 0
INDIRP4
CNSTI4 656
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $221
line 419
;419:		G_Printf("untargeted %s at %s\n", self->classname, vtos(self->s.origin));
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 vtos
CALLP4
ASGNP4
ADDRGP4 $223
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
LABELV $221
line 421
;420:
;421:	self->use = target_teleporter_use;
ADDRFP4 0
INDIRP4
CNSTI4 712
ADDP4
ADDRGP4 target_teleporter_use
ASGNP4
line 423
;422:#if ESCAPE_MODE	// JUHOX: set entity class
;423:	self->entClass = GEC_target_teleporter;
ADDRFP4 0
INDIRP4
CNSTI4 824
ADDP4
CNSTI4 27
ASGNI4
line 425
;424:#endif
;425:}
LABELV $220
endproc SP_target_teleporter 4 12
export target_relay_use
proc target_relay_use 28 12
line 435
;426:
;427://==========================================================
;428:
;429:
;430:/*QUAKED target_relay (.5 .5 .5) (-8 -8 -8) (8 8 8) RED_ONLY BLUE_ONLY RANDOM
;431:This doesn't perform any actions except fire its targets.
;432:The activator can be forced to be from a certain team.
;433:if RANDOM is checked, only one of the targets will be fired, not all of them
;434:*/
;435:void target_relay_use (gentity_t *self, gentity_t *other, gentity_t *activator) {
line 436
;436:	if ( ( self->spawnflags & 1 ) && activator->client 
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $225
ADDRLP4 0
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $225
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 1
EQI4 $225
line 437
;437:		&& activator->client->sess.sessionTeam != TEAM_RED ) {
line 438
;438:		return;
ADDRGP4 $224
JUMPV
LABELV $225
line 440
;439:	}
;440:	if ( ( self->spawnflags & 2 ) && activator->client 
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $227
ADDRLP4 4
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $227
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
CNSTI4 2
EQI4 $227
line 441
;441:		&& activator->client->sess.sessionTeam != TEAM_BLUE ) {
line 442
;442:		return;
ADDRGP4 $224
JUMPV
LABELV $227
line 444
;443:	}
;444:	if ( self->spawnflags & 4 ) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $229
line 450
;445:		gentity_t	*ent;
;446:
;447:#if !ESCAPE_MODE	// JUHOX: G_PickTarget() also needs to know the segment
;448:		ent = G_PickTarget( self->target );
;449:#else
;450:		ent = G_PickTarget(self->target, self->worldSegment - 1);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 652
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRLP4 16
ADDRGP4 G_PickTarget
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 16
INDIRP4
ASGNP4
line 452
;451:#endif
;452:		if ( ent && ent->use ) {
ADDRLP4 20
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $224
ADDRLP4 20
INDIRP4
CNSTI4 712
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $224
line 453
;453:			ent->use( ent, self, activator );
ADDRLP4 24
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
CNSTI4 712
ADDP4
INDIRP4
CALLV
pop
line 454
;454:		}
line 455
;455:		return;
ADDRGP4 $224
JUMPV
LABELV $229
line 457
;456:	}
;457:	G_UseTargets (self, activator);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 G_UseTargets
CALLV
pop
line 458
;458:}
LABELV $224
endproc target_relay_use 28 12
export SP_target_relay
proc SP_target_relay 0 0
line 460
;459:
;460:void SP_target_relay (gentity_t *self) {
line 461
;461:	self->use = target_relay_use;
ADDRFP4 0
INDIRP4
CNSTI4 712
ADDP4
ADDRGP4 target_relay_use
ASGNP4
line 463
;462:#if ESCAPE_MODE	// JUHOX: set entity class
;463:	self->entClass = GEC_target_relay;
ADDRFP4 0
INDIRP4
CNSTI4 824
ADDP4
CNSTI4 28
ASGNI4
line 465
;464:#endif
;465:}
LABELV $233
endproc SP_target_relay 0 0
export target_kill_use
proc target_kill_use 0 32
line 473
;466:
;467:
;468://==========================================================
;469:
;470:/*QUAKED target_kill (.5 .5 .5) (-8 -8 -8) (8 8 8)
;471:Kills the activator.
;472:*/
;473:void target_kill_use( gentity_t *self, gentity_t *other, gentity_t *activator ) {
line 474
;474:	G_Damage ( activator, NULL, NULL, NULL, NULL, 100000, DAMAGE_NO_PROTECTION, MOD_TELEFRAG);
ADDRFP4 8
INDIRP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTI4 100000
ARGI4
CNSTI4 8
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 475
;475:}
LABELV $234
endproc target_kill_use 0 32
export SP_target_kill
proc SP_target_kill 0 0
line 477
;476:
;477:void SP_target_kill( gentity_t *self ) {
line 478
;478:	self->use = target_kill_use;
ADDRFP4 0
INDIRP4
CNSTI4 712
ADDP4
ADDRGP4 target_kill_use
ASGNP4
line 480
;479:#if ESCAPE_MODE	// JUHOX: set entity class
;480:	self->entClass = GEC_target_kill;
ADDRFP4 0
INDIRP4
CNSTI4 824
ADDP4
CNSTI4 29
ASGNI4
line 482
;481:#endif
;482:}
LABELV $235
endproc SP_target_kill 0 0
export SP_target_position
proc SP_target_position 4 8
line 487
;483:
;484:/*QUAKED target_position (0 0.5 0) (-4 -4 -4) (4 4 4)
;485:Used as a positional target for in-game calculation, like jumppad targets.
;486:*/
;487:void SP_target_position( gentity_t *self ){
line 488
;488:	G_SetOrigin( self, self->s.origin );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 490
;489:#if ESCAPE_MODE	// JUHOX: set entity class
;490:	self->entClass = GEC_target_position;
ADDRFP4 0
INDIRP4
CNSTI4 824
ADDP4
CNSTI4 30
ASGNI4
line 492
;491:#endif
;492:}
LABELV $236
endproc SP_target_position 4 8
proc target_location_linkup 16 8
line 495
;493:
;494:static void target_location_linkup(gentity_t *ent)
;495:{
line 499
;496:	int i;
;497:	int n;
;498:
;499:	if (level.locationLinked) 
ADDRGP4 level+9184
INDIRI4
CNSTI4 0
EQI4 $238
line 500
;500:		return;
ADDRGP4 $237
JUMPV
LABELV $238
line 502
;501:
;502:	level.locationLinked = qtrue;
ADDRGP4 level+9184
CNSTI4 1
ASGNI4
line 504
;503:
;504:	level.locationHead = NULL;
ADDRGP4 level+9188
CNSTP4 0
ASGNP4
line 506
;505:
;506:	trap_SetConfigstring( CS_LOCATIONS, "unknown" );
CNSTI4 608
ARGI4
ADDRGP4 $243
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 508
;507:
;508:	for (i = 0, ent = g_entities, n = 1;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRFP4 0
ADDRGP4 g_entities
ASGNP4
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $247
JUMPV
LABELV $244
line 510
;509:			i < level.num_entities;
;510:			i++, ent++) {
line 511
;511:		if (n >= MAX_LOCATIONS) break;	// JUHOX BUGFIX
ADDRLP4 0
INDIRI4
CNSTI4 100
LTI4 $249
ADDRGP4 $246
JUMPV
LABELV $249
line 512
;512:		if (ent->classname && !Q_stricmp(ent->classname, "target_location")) {
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $251
ADDRLP4 8
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ARGP4
ADDRGP4 $253
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $251
line 514
;513:			// lets overload some variables!
;514:			ent->health = n; // use for location marking
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 515
;515:			trap_SetConfigstring( CS_LOCATIONS + n, ent->message );
ADDRLP4 0
INDIRI4
CNSTI4 608
ADDI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 640
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 516
;516:			n++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 517
;517:			ent->nextTrain = level.locationHead;
ADDRFP4 0
INDIRP4
CNSTI4 608
ADDP4
ADDRGP4 level+9188
INDIRP4
ASGNP4
line 518
;518:			level.locationHead = ent;
ADDRGP4 level+9188
ADDRFP4 0
INDIRP4
ASGNP4
line 519
;519:		}
LABELV $251
line 520
;520:	}
LABELV $245
line 510
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 844
ADDP4
ASGNP4
LABELV $247
line 509
ADDRLP4 4
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $244
LABELV $246
line 523
;521:
;522:	// All linked together now
;523:}
LABELV $237
endproc target_location_linkup 16 8
export SP_target_location
proc SP_target_location 4 8
line 533
;524:
;525:/*QUAKED target_location (0 0.5 0) (-8 -8 -8) (8 8 8)
;526:Set "message" to the name of this location.
;527:Set "count" to 0-7 for color.
;528:0:white 1:red 2:green 3:yellow 4:blue 5:cyan 6:magenta 7:white
;529:
;530:Closest target_location in sight used for the location, if none
;531:in site, closest in distance
;532:*/
;533:void SP_target_location( gentity_t *self ){
line 535
;534:#if ESCAPE_MODE	// JUHOX: target_location not supported in EFH
;535:	if (g_gametype.integer == GT_EFH) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
NEI4 $257
line 536
;536:		G_FreeEntity(self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 537
;537:		return;
ADDRGP4 $256
JUMPV
LABELV $257
line 540
;538:	}
;539:#endif
;540:	self->think = target_location_linkup;
ADDRFP4 0
INDIRP4
CNSTI4 696
ADDP4
ADDRGP4 target_location_linkup
ASGNP4
line 541
;541:	self->nextthink = level.time + 200;  // Let them all spawn first
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 200
ADDI4
ASGNI4
line 543
;542:
;543:	G_SetOrigin( self, self->s.origin );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 544
;544:}
LABELV $256
endproc SP_target_location 4 8
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
LABELV $253
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
LABELV $243
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $223
byte 1 117
byte 1 110
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $219
byte 1 67
byte 1 111
byte 1 117
byte 1 108
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
byte 1 32
byte 1 100
byte 1 101
byte 1 115
byte 1 116
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $207
byte 1 37
byte 1 115
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 97
byte 1 32
byte 1 98
byte 1 97
byte 1 100
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $172
byte 1 45
byte 1 49
byte 1 0
align 1
LABELV $171
byte 1 114
byte 1 97
byte 1 100
byte 1 105
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $170
byte 1 49
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $169
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 105
byte 1 116
byte 1 117
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $168
byte 1 102
byte 1 97
byte 1 100
byte 1 101
byte 1 111
byte 1 117
byte 1 116
byte 1 0
align 1
LABELV $167
byte 1 102
byte 1 97
byte 1 100
byte 1 101
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $166
byte 1 49
byte 1 48
byte 1 0
align 1
LABELV $165
byte 1 100
byte 1 117
byte 1 114
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $156
byte 1 37
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $155
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $150
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
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 97
byte 1 32
byte 1 110
byte 1 111
byte 1 105
byte 1 115
byte 1 101
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $149
byte 1 78
byte 1 79
byte 1 83
byte 1 79
byte 1 85
byte 1 78
byte 1 68
byte 1 0
align 1
LABELV $148
byte 1 110
byte 1 111
byte 1 105
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $145
byte 1 114
byte 1 97
byte 1 110
byte 1 100
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $127
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 0
align 1
LABELV $117
byte 1 49
byte 1 0
align 1
LABELV $116
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $115
byte 1 48
byte 1 0
align 1
LABELV $114
byte 1 100
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
