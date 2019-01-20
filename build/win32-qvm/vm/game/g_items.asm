export Pickup_Powerup
code
proc Pickup_Powerup 116 28
file "..\..\..\..\code\game\g_items.c"
line 29
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:#include "g_local.h"
;4:
;5:/*
;6:
;7:  Items are any object that a player can touch to gain some effect.
;8:
;9:  Pickup will return the number of seconds until they should respawn.
;10:
;11:  all items should pop when dropped in lava or slime
;12:
;13:  Respawnable items don't actually go away when picked up, they are
;14:  just made invisible and untouchable.  This allows them to ride
;15:  movers and respawn apropriately.
;16:*/
;17:
;18:
;19:#define	RESPAWN_ARMOR		25
;20:#define	RESPAWN_HEALTH		35
;21:#define	RESPAWN_AMMO		40
;22:#define	RESPAWN_HOLDABLE	60
;23:#define	RESPAWN_MEGAHEALTH	35//120
;24:#define	RESPAWN_POWERUP		120
;25:
;26:
;27://======================================================================
;28:
;29:int Pickup_Powerup( gentity_t *ent, gentity_t *other ) {
line 34
;30:	int			quantity;
;31:	int			i;
;32:	gclient_t	*client;
;33:
;34:	if ( !other->client->ps.powerups[ent->item->giTag] ) {
ADDRFP4 0
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $88
line 37
;35:		// round timing to seconds to make multiple powerup timers
;36:		// count in sync
;37:		other->client->ps.powerups[ent->item->giTag] = 
ADDRFP4 0
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
MODI4
SUBI4
ASGNI4
line 39
;38:			level.time - ( level.time % 1000 );
;39:	}
LABELV $88
line 41
;40:
;41:	if ( ent->count ) {
ADDRFP4 0
INDIRP4
CNSTI4 764
ADDP4
INDIRI4
CNSTI4 0
EQI4 $92
line 42
;42:		quantity = ent->count;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 764
ADDP4
INDIRI4
ASGNI4
line 43
;43:	} else {
ADDRGP4 $93
JUMPV
LABELV $92
line 44
;44:		quantity = ent->item->quantity;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ASGNI4
line 45
;45:	}
LABELV $93
line 47
;46:
;47:	other->client->ps.powerups[ent->item->giTag] += quantity * 1000;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
ADDRLP4 8
INDIRI4
CNSTI4 1000
MULI4
ADDI4
ASGNI4
line 50
;48:
;49:	// give any nearby players a "denied" anti-reward
;50:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $97
JUMPV
LABELV $94
line 56
;51:		vec3_t		delta;
;52:		float		len;
;53:		vec3_t		forward;
;54:		trace_t		tr;
;55:
;56:		client = &level.clients[i];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 5604
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 57
;57:		if ( client == other->client ) {
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
NEU4 $99
line 58
;58:			continue;
ADDRGP4 $95
JUMPV
LABELV $99
line 60
;59:		}
;60:		if ( client->pers.connected == CON_DISCONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 0
NEI4 $101
line 61
;61:			continue;
ADDRGP4 $95
JUMPV
LABELV $101
line 63
;62:		}
;63:		if ( client->ps.stats[STAT_HEALTH] <= 0 ) {
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $103
line 64
;64:			continue;
ADDRGP4 $95
JUMPV
LABELV $103
line 68
;65:		}
;66:		// JUHOX: don't give spectators an anti-reward
;67:#if 1
;68:		if (client->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR) {
ADDRLP4 0
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 3
NEI4 $105
line 69
;69:			continue;
ADDRGP4 $95
JUMPV
LABELV $105
line 75
;70:		}
;71:#endif
;72:
;73:    // if same team in team game, no sound
;74:    // cannot use OnSameTeam as it expects to g_entities, not clients
;75:  	if ( g_gametype.integer >= GT_TEAM && other->client->sess.sessionTeam == client->sess.sessionTeam  ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $107
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
NEI4 $107
line 76
;76:      continue;
ADDRGP4 $95
JUMPV
LABELV $107
line 80
;77:    }
;78:
;79:		// if too far away, no sound
;80:		VectorSubtract( ent->s.pos.trBase, client->ps.origin, delta );
ADDRLP4 100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 100
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 100
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 16+8
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
line 81
;81:		len = VectorNormalize( delta );
ADDRLP4 16
ARGP4
ADDRLP4 108
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 40
ADDRLP4 108
INDIRF4
ASGNF4
line 82
;82:		if ( len > 192 ) {
ADDRLP4 40
INDIRF4
CNSTF4 1128267776
LEF4 $112
line 83
;83:			continue;
ADDRGP4 $95
JUMPV
LABELV $112
line 87
;84:		}
;85:
;86:		// if not facing, no sound
;87:		AngleVectors( client->ps.viewangles, forward, NULL, NULL );
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRLP4 28
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 88
;88:		if ( DotProduct( delta, forward ) < 0.4 ) {
ADDRLP4 16
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ADDRLP4 16+4
INDIRF4
ADDRLP4 28+4
INDIRF4
MULF4
ADDF4
ADDRLP4 16+8
INDIRF4
ADDRLP4 28+8
INDIRF4
MULF4
ADDF4
CNSTF4 1053609165
GEF4 $114
line 89
;89:			continue;
ADDRGP4 $95
JUMPV
LABELV $114
line 93
;90:		}
;91:
;92:		// if not line of sight, no sound
;93:		trap_Trace( &tr, client->ps.origin, NULL, NULL, ent->s.pos.trBase, ENTITYNUM_NONE, CONTENTS_SOLID );
ADDRLP4 44
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 94
;94:		if ( tr.fraction != 1.0 ) {
ADDRLP4 44+8
INDIRF4
CNSTF4 1065353216
EQF4 $120
line 95
;95:			continue;
ADDRGP4 $95
JUMPV
LABELV $120
line 99
;96:		}
;97:
;98:		// anti-reward
;99:		client->ps.persistant[PERS_PLAYEREVENTS] ^= PLAYEREVENT_DENIEDREWARD;
ADDRLP4 112
ADDRLP4 0
INDIRP4
CNSTI4 268
ADDP4
ASGNP4
ADDRLP4 112
INDIRP4
ADDRLP4 112
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 100
;100:	}
LABELV $95
line 50
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $97
ADDRLP4 4
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $94
line 101
;101:	return RESPAWN_POWERUP;
CNSTI4 120
RETI4
LABELV $87
endproc Pickup_Powerup 116 28
export Pickup_Holdable
proc Pickup_Holdable 4 0
line 181
;102:}
;103:
;104://======================================================================
;105:
;106:#ifdef MISSIONPACK
;107:int Pickup_PersistantPowerup( gentity_t *ent, gentity_t *other ) {
;108:	int		clientNum;
;109:	char	userinfo[MAX_INFO_STRING];
;110:	float	handicap;
;111:	int		max;
;112:
;113:	other->client->ps.stats[STAT_PERSISTANT_POWERUP] = ent->item - bg_itemlist;
;114:	other->client->persistantPowerup = ent;
;115:
;116:	switch( ent->item->giTag ) {
;117:	case PW_GUARD:
;118:		clientNum = other->client->ps.clientNum;
;119:		trap_GetUserinfo( clientNum, userinfo, sizeof(userinfo) );
;120:		handicap = atof( Info_ValueForKey( userinfo, "handicap" ) );
;121:		if( handicap<=0.0f || handicap>100.0f) {
;122:			handicap = 100.0f;
;123:		}
;124:		max = (int)(2 *  handicap);
;125:
;126:		other->health = max;
;127:		other->client->ps.stats[STAT_HEALTH] = max;
;128:		other->client->ps.stats[STAT_MAX_HEALTH] = max;
;129:		other->client->ps.stats[STAT_ARMOR] = max;
;130:		other->client->pers.maxHealth = max;
;131:
;132:		break;
;133:
;134:	case PW_SCOUT:
;135:		clientNum = other->client->ps.clientNum;
;136:		trap_GetUserinfo( clientNum, userinfo, sizeof(userinfo) );
;137:		handicap = atof( Info_ValueForKey( userinfo, "handicap" ) );
;138:		if( handicap<=0.0f || handicap>100.0f) {
;139:			handicap = 100.0f;
;140:		}
;141:		other->client->pers.maxHealth = handicap;
;142:		other->client->ps.stats[STAT_ARMOR] = 0;
;143:		break;
;144:
;145:	case PW_DOUBLER:
;146:		clientNum = other->client->ps.clientNum;
;147:		trap_GetUserinfo( clientNum, userinfo, sizeof(userinfo) );
;148:		handicap = atof( Info_ValueForKey( userinfo, "handicap" ) );
;149:		if( handicap<=0.0f || handicap>100.0f) {
;150:			handicap = 100.0f;
;151:		}
;152:		other->client->pers.maxHealth = handicap;
;153:		break;
;154:	case PW_AMMOREGEN:
;155:		clientNum = other->client->ps.clientNum;
;156:		trap_GetUserinfo( clientNum, userinfo, sizeof(userinfo) );
;157:		handicap = atof( Info_ValueForKey( userinfo, "handicap" ) );
;158:		if( handicap<=0.0f || handicap>100.0f) {
;159:			handicap = 100.0f;
;160:		}
;161:		other->client->pers.maxHealth = handicap;
;162:		memset(other->client->ammoTimes, 0, sizeof(other->client->ammoTimes));
;163:		break;
;164:	default:
;165:		clientNum = other->client->ps.clientNum;
;166:		trap_GetUserinfo( clientNum, userinfo, sizeof(userinfo) );
;167:		handicap = atof( Info_ValueForKey( userinfo, "handicap" ) );
;168:		if( handicap<=0.0f || handicap>100.0f) {
;169:			handicap = 100.0f;
;170:		}
;171:		other->client->pers.maxHealth = handicap;
;172:		break;
;173:	}
;174:
;175:	return -1;
;176:}
;177:
;178://======================================================================
;179:#endif
;180:
;181:int Pickup_Holdable( gentity_t *ent, gentity_t *other ) {
line 183
;182:
;183:	other->client->ps.stats[STAT_HOLDABLE_ITEM] = ent->item - bg_itemlist;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 188
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
ASGNI4
line 185
;184:
;185:	if( ent->item->giTag == HI_KAMIKAZE ) {
ADDRFP4 0
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 3
NEI4 $124
line 186
;186:		other->client->ps.eFlags |= EF_KAMIKAZE;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 512
BORI4
ASGNI4
line 187
;187:	}
LABELV $124
line 189
;188:
;189:	return RESPAWN_HOLDABLE;
CNSTI4 60
RETI4
LABELV $123
endproc Pickup_Holdable 4 0
export Add_Ammo
proc Add_Ammo 4 0
line 196
;190:}
;191:
;192:
;193://======================================================================
;194:
;195:void Add_Ammo (gentity_t *ent, int weapon, int count)
;196:{
line 197
;197:	if (ent->client->ps.ammo[weapon] < 0) return;	// JUHOX
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
CNSTI4 0
GEI4 $127
ADDRGP4 $126
JUMPV
LABELV $127
line 198
;198:	ent->client->ps.ammo[weapon] += count;
ADDRLP4 0
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRFP4 8
INDIRI4
ADDI4
ASGNI4
line 199
;199:	if ( ent->client->ps.ammo[weapon] > 200 ) {
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
CNSTI4 200
LEI4 $129
line 200
;200:		ent->client->ps.ammo[weapon] = 200;
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
CNSTI4 200
ASGNI4
line 201
;201:	}
LABELV $129
line 202
;202:}
LABELV $126
endproc Add_Ammo 4 0
export Pickup_Ammo
proc Pickup_Ammo 4 12
line 205
;203:
;204:int Pickup_Ammo (gentity_t *ent, gentity_t *other)
;205:{
line 208
;206:	int		quantity;
;207:
;208:	if ( ent->count ) {
ADDRFP4 0
INDIRP4
CNSTI4 764
ADDP4
INDIRI4
CNSTI4 0
EQI4 $132
line 209
;209:		quantity = ent->count;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 764
ADDP4
INDIRI4
ASGNI4
line 210
;210:	} else {
ADDRGP4 $133
JUMPV
LABELV $132
line 211
;211:		quantity = ent->item->quantity;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ASGNI4
line 212
;212:	}
LABELV $133
line 214
;213:
;214:	Add_Ammo (other, ent->item->giTag, quantity);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Add_Ammo
CALLV
pop
line 216
;215:
;216:	return RESPAWN_AMMO;
CNSTI4 40
RETI4
LABELV $131
endproc Pickup_Ammo 4 12
export Pickup_Weapon
proc Pickup_Weapon 8 12
line 222
;217:}
;218:
;219://======================================================================
;220:
;221:
;222:int Pickup_Weapon (gentity_t *ent, gentity_t *other) {
line 225
;223:	int		quantity;
;224:
;225:	if ( ent->count < 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 764
ADDP4
INDIRI4
CNSTI4 0
GEI4 $135
line 226
;226:		quantity = 0; // None for you, sir!
ADDRLP4 0
CNSTI4 0
ASGNI4
line 227
;227:	} else {
ADDRGP4 $136
JUMPV
LABELV $135
line 228
;228:		if ( ent->count ) {
ADDRFP4 0
INDIRP4
CNSTI4 764
ADDP4
INDIRI4
CNSTI4 0
EQI4 $137
line 229
;229:			quantity = ent->count;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 764
ADDP4
INDIRI4
ASGNI4
line 230
;230:		} else {
ADDRGP4 $138
JUMPV
LABELV $137
line 231
;231:			quantity = ent->item->quantity;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ASGNI4
line 232
;232:		}
LABELV $138
line 235
;233:
;234:		// dropped items and teamplay weapons always have full ammo
;235:		if ( ! (ent->flags & FL_DROPPED_ITEM) && g_gametype.integer != GT_TEAM ) {
ADDRFP4 0
INDIRP4
CNSTI4 540
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
NEI4 $139
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
EQI4 $139
line 238
;236:			// respawning rules
;237:			// drop the quantity if the already have over the minimum
;238:			if ( other->client->ps.ammo[ ent->item->giTag ] < quantity ) {
ADDRFP4 0
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
GEI4 $142
line 239
;239:				quantity = quantity - other->client->ps.ammo[ ent->item->giTag ];
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
SUBI4
ASGNI4
line 240
;240:			} else {
ADDRGP4 $143
JUMPV
LABELV $142
line 241
;241:				quantity = 1;		// only add a single shot
ADDRLP4 0
CNSTI4 1
ASGNI4
line 242
;242:			}
LABELV $143
line 243
;243:		}
LABELV $139
line 244
;244:	}
LABELV $136
line 247
;245:
;246:	// add the weapon
;247:	other->client->ps.stats[STAT_WEAPONS] |= ( 1 << ent->item->giTag );
ADDRLP4 4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 192
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDRFP4 0
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
LSHI4
BORI4
ASGNI4
line 249
;248:
;249:	Add_Ammo( other, ent->item->giTag, quantity );
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Add_Ammo
CALLV
pop
line 251
;250:
;251:	if (ent->item->giTag == WP_GRAPPLING_HOOK)
ADDRFP4 0
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 10
NEI4 $144
line 252
;252:		other->client->ps.ammo[ent->item->giTag] = -1; // unlimited ammo
ADDRFP4 0
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
CNSTI4 -1
ASGNI4
LABELV $144
line 255
;253:
;254:	// team deathmatch has slow weapon respawns
;255:	if ( g_gametype.integer == GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
NEI4 $146
line 256
;256:		return g_weaponTeamRespawn.integer;
ADDRGP4 g_weaponTeamRespawn+12
INDIRI4
RETI4
ADDRGP4 $134
JUMPV
LABELV $146
line 259
;257:	}
;258:
;259:	return g_weaponRespawn.integer;
ADDRGP4 g_weaponRespawn+12
INDIRI4
RETI4
LABELV $134
endproc Pickup_Weapon 8 12
export Pickup_Health
proc Pickup_Health 20 0
line 265
;260:}
;261:
;262:
;263://======================================================================
;264:
;265:int Pickup_Health (gentity_t *ent, gentity_t *other) {
line 276
;266:	int			max;
;267:	int			quantity;
;268:
;269:	// small and mega healths will go over the max
;270:#ifdef MISSIONPACK
;271:	if( other->client && bg_itemlist[other->client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_GUARD ) {
;272:		max = other->client->ps.stats[STAT_MAX_HEALTH];
;273:	}
;274:	else
;275:#endif
;276:	if ( ent->item->quantity != 5 && ent->item->quantity != 100 ) {
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 5
EQI4 $152
ADDRLP4 8
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 100
EQI4 $152
line 277
;277:		max = other->client->ps.stats[STAT_MAX_HEALTH];
ADDRLP4 4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
ASGNI4
line 278
;278:	} else {
ADDRGP4 $153
JUMPV
LABELV $152
line 279
;279:		max = other->client->ps.stats[STAT_MAX_HEALTH] * 2;
ADDRLP4 4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
line 280
;280:	}
LABELV $153
line 282
;281:
;282:	if ( ent->count ) {
ADDRFP4 0
INDIRP4
CNSTI4 764
ADDP4
INDIRI4
CNSTI4 0
EQI4 $154
line 283
;283:		quantity = ent->count;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 764
ADDP4
INDIRI4
ASGNI4
line 284
;284:	} else {
ADDRGP4 $155
JUMPV
LABELV $154
line 285
;285:		quantity = ent->item->quantity;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ASGNI4
line 286
;286:	}
LABELV $155
line 297
;287:
;288:	// JUHOX: health items reduce charge
;289:#if 0
;290:	other->health += quantity;
;291:
;292:	if (other->health > max ) {
;293:		other->health = max;
;294:	}
;295:	other->client->ps.stats[STAT_HEALTH] = other->health;
;296:#else
;297:	if (other->client->ps.powerups[PW_CHARGE]) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 352
ADDP4
INDIRI4
CNSTI4 0
EQI4 $156
line 298
;298:		other->client->ps.powerups[PW_CHARGE] -= 100 * quantity;
ADDRLP4 12
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 352
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
SUBI4
ASGNI4
line 299
;299:	}
ADDRGP4 $157
JUMPV
LABELV $156
line 300
;300:	else {
line 301
;301:		other->health += quantity;
ADDRLP4 12
ADDRFP4 4
INDIRP4
CNSTI4 736
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 303
;302:
;303:		if (other->health > max ) {
ADDRFP4 4
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
LEI4 $158
line 304
;304:			other->health = max;
ADDRFP4 4
INDIRP4
CNSTI4 736
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 305
;305:		}
LABELV $158
line 306
;306:		other->client->ps.stats[STAT_HEALTH] = other->health;
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
ASGNI4
line 307
;307:	}
LABELV $157
line 310
;308:#endif
;309:
;310:	if ( ent->item->quantity == 100 ) {		// mega health respawns slow
ADDRFP4 0
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 100
NEI4 $160
line 311
;311:		return RESPAWN_MEGAHEALTH;
CNSTI4 35
RETI4
ADDRGP4 $151
JUMPV
LABELV $160
line 314
;312:	}
;313:
;314:	return RESPAWN_HEALTH;
CNSTI4 35
RETI4
LABELV $151
endproc Pickup_Health 20 0
export Pickup_Armor
proc Pickup_Armor 12 0
line 319
;315:}
;316:
;317://======================================================================
;318:
;319:int Pickup_Armor( gentity_t *ent, gentity_t *other ) {
line 336
;320:#ifdef MISSIONPACK
;321:	int		upperBound;
;322:
;323:	other->client->ps.stats[STAT_ARMOR] += ent->item->quantity;
;324:
;325:	if( other->client && bg_itemlist[other->client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_GUARD ) {
;326:		upperBound = other->client->ps.stats[STAT_MAX_HEALTH];
;327:	}
;328:	else {
;329:		upperBound = other->client->ps.stats[STAT_MAX_HEALTH] * 2;
;330:	}
;331:
;332:	if ( other->client->ps.stats[STAT_ARMOR] > upperBound ) {
;333:		other->client->ps.stats[STAT_ARMOR] = upperBound;
;334:	}
;335:#else
;336:	other->client->ps.stats[STAT_ARMOR] += ent->item->quantity;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 196
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ADDI4
ASGNI4
line 337
;337:	if ( other->client->ps.stats[STAT_ARMOR] > other->client->ps.stats[STAT_MAX_HEALTH] * 2 ) {
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 1
LSHI4
LEI4 $163
line 338
;338:		other->client->ps.stats[STAT_ARMOR] = other->client->ps.stats[STAT_MAX_HEALTH] * 2;
ADDRLP4 8
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
line 339
;339:	}
LABELV $163
line 342
;340:#endif
;341:
;342:	return RESPAWN_ARMOR;
CNSTI4 25
RETI4
LABELV $162
endproc Pickup_Armor 12 0
proc Think_Artefact 0 0
line 353
;343:}
;344:
;345://======================================================================
;346:
;347:/*
;348:===============
;349:JUHOX: Think_Artefact
;350:===============
;351:*/
;352:#if MONSTER_MODE
;353:static void Think_Artefact(gentity_t* ent) {
line 354
;354:	G_SpawnArtefact();
ADDRGP4 G_SpawnArtefact
CALLV
pop
line 355
;355:}
LABELV $165
endproc Think_Artefact 0 0
export Pickup_Artefact
proc Pickup_Artefact 36 12
line 364
;356:#endif
;357:
;358:/*
;359:===============
;360:JUHOX: Pickup_Artefact
;361:===============
;362:*/
;363:#if MONSTER_MODE
;364:int Pickup_Artefact(gentity_t* ent, gentity_t* other) {
line 369
;365:	gentity_t* te;
;366:	int i;
;367:	int score;
;368:
;369:	level.artefactCapturedTime = level.time;
ADDRGP4 level+23008
ADDRGP4 level+32
INDIRI4
ASGNI4
line 371
;370:
;371:	level.teamScores[TEAM_RED]++;
ADDRLP4 12
ADDRGP4 level+44+4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 372
;372:	score = 1000;
ADDRLP4 8
CNSTI4 1000
ASGNI4
line 373
;373:	level.stuScore += score;
ADDRLP4 16
ADDRGP4 level+23020
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
ADDRLP4 8
INDIRI4
ADDI4
ASGNI4
line 374
;374:	if (other->client) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $172
line 375
;375:		other->client->ps.persistant[PERS_SCORE] += score;
ADDRLP4 20
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 248
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
ADDRLP4 8
INDIRI4
ADDI4
ASGNI4
line 376
;376:		ScorePlum(other, ent->s.pos.trBase, score);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 ScorePlum
CALLV
pop
line 377
;377:	}
LABELV $172
line 378
;378:	CalculateRanks();
ADDRGP4 CalculateRanks
CALLV
pop
line 380
;379:
;380:	if (other->client->pers.predictItemPickup) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 504
ADDP4
INDIRI4
CNSTI4 0
EQI4 $174
line 381
;381:		G_AddPredictableEvent(other, EV_ITEM_PICKUP, ent->s.modelindex);
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 19
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_AddPredictableEvent
CALLV
pop
line 382
;382:	} else {
ADDRGP4 $175
JUMPV
LABELV $174
line 383
;383:		G_AddEvent(other, EV_ITEM_PICKUP, ent->s.modelindex);
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 19
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 384
;384:	}
LABELV $175
line 386
;385:
;386:	ent->r.svFlags |= SVF_NOCLIENT;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 387
;387:	ent->s.eFlags |= EF_NODRAW;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 388
;388:	ent->r.contents = 0;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 0
ASGNI4
line 391
;389:
;390:	if (
;391:		g_skipEndSequence.integer &&
ADDRGP4 g_skipEndSequence+12
INDIRI4
CNSTI4 0
EQI4 $176
ADDRGP4 g_artefacts+12
INDIRI4
CNSTI4 999
GEI4 $176
ADDRGP4 level+44+4
INDIRI4
ADDRGP4 g_artefacts+12
INDIRI4
LTI4 $176
line 394
;392:		g_artefacts.integer < 999 &&
;393:		level.teamScores[TEAM_RED] >= g_artefacts.integer
;394:	) return 0;
CNSTI4 0
RETI4
ADDRGP4 $166
JUMPV
LABELV $176
line 396
;395:
;396:	te = G_TempEntity(ent->s.pos.trBase, EV_GLOBAL_ITEM_PICKUP);
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 20
ARGI4
ADDRLP4 28
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 28
INDIRP4
ASGNP4
line 397
;397:	te->s.eventParm = ent->s.modelindex;
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ASGNI4
line 398
;398:	te->s.modelindex = 0;
ADDRLP4 4
INDIRP4
CNSTI4 160
ADDP4
CNSTI4 0
ASGNI4
line 399
;399:	te->r.svFlags |= SVF_BROADCAST;
ADDRLP4 32
ADDRLP4 4
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 402
;400:
;401:	//G_SpawnArtefact();
;402:	if (level.teamScores[TEAM_RED] < g_artefacts.integer || g_artefacts.integer >= 999) {
ADDRGP4 level+44+4
INDIRI4
ADDRGP4 g_artefacts+12
INDIRI4
LTI4 $189
ADDRGP4 g_artefacts+12
INDIRI4
CNSTI4 999
LTI4 $183
LABELV $189
line 403
;403:		ent->think = Think_Artefact;
ADDRFP4 0
INDIRP4
CNSTI4 696
ADDP4
ADDRGP4 Think_Artefact
ASGNP4
line 404
;404:		ent->nextthink = level.time + 16000;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 16000
ADDI4
ASGNI4
line 405
;405:	}
ADDRGP4 $184
JUMPV
LABELV $183
line 406
;406:	else {
line 407
;407:		te->s.modelindex = 1;	// signal to the clients: "this was the last pickup"
ADDRLP4 4
INDIRP4
CNSTI4 160
ADDP4
CNSTI4 1
ASGNI4
line 408
;408:	}
LABELV $184
line 410
;409:
;410:	for (i = 0; i < level.maxclients; i++) ForceRespawn(&g_entities[i]);
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $194
JUMPV
LABELV $191
ADDRLP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRGP4 ForceRespawn
CALLV
pop
LABELV $192
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $194
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $191
line 412
;411:
;412:	G_ReleaseTrap(g_monstersPerTrap.integer, ent->s.pos.trBase);
ADDRGP4 g_monstersPerTrap+12
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRGP4 G_ReleaseTrap
CALLV
pop
line 414
;413:
;414:	return 0;
CNSTI4 0
RETI4
LABELV $166
endproc Pickup_Artefact 36 12
export RespawnItem
proc RespawnItem 24 12
line 425
;415:}
;416:#endif
;417:
;418://======================================================================
;419:
;420:/*
;421:===============
;422:RespawnItem
;423:===============
;424:*/
;425:void RespawnItem( gentity_t *ent ) {
line 427
;426:	// randomly select from teamed entities
;427:	if (ent->team) {
ADDRFP4 0
INDIRP4
CNSTI4 660
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $198
line 432
;428:		gentity_t	*master;
;429:		int	count;
;430:		int choice;
;431:
;432:		if ( !ent->teammaster ) {
ADDRFP4 0
INDIRP4
CNSTI4 784
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $200
line 433
;433:			G_Error( "RespawnItem: bad teammaster");
ADDRGP4 $202
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 434
;434:		}
LABELV $200
line 435
;435:		master = ent->teammaster;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 784
ADDP4
INDIRP4
ASGNP4
line 437
;436:
;437:		for (count = 0, ent = master; ent; ent = ent->teamchain, count++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRFP4 0
ADDRLP4 8
INDIRP4
ASGNP4
ADDRGP4 $206
JUMPV
LABELV $203
line 438
;438:			;
LABELV $204
line 437
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 780
ADDP4
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $206
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $203
line 440
;439:
;440:		choice = rand() % count;
ADDRLP4 12
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
ADDRLP4 0
INDIRI4
MODI4
ASGNI4
line 442
;441:
;442:		for (count = 0, ent = master; count < choice; ent = ent->teamchain, count++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRFP4 0
ADDRLP4 8
INDIRP4
ASGNP4
ADDRGP4 $210
JUMPV
LABELV $207
line 443
;443:			;
LABELV $208
line 442
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 780
ADDP4
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $210
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $207
line 444
;444:	}
LABELV $198
line 446
;445:
;446:	ent->r.contents = CONTENTS_TRIGGER;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 1073741824
ASGNI4
line 447
;447:	ent->s.eFlags &= ~EF_NODRAW;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 448
;448:	ent->r.svFlags &= ~SVF_NOCLIENT;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 449
;449:	trap_LinkEntity (ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 451
;450:
;451:	if ( ent->item->giType == IT_POWERUP ) {
ADDRFP4 0
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 5
NEI4 $211
line 456
;452:		// play powerup spawn sound to all clients
;453:		gentity_t	*te;
;454:
;455:		// if the powerup respawn sound should Not be global
;456:		if (ent->speed) {
ADDRFP4 0
INDIRP4
CNSTI4 676
ADDP4
INDIRF4
CNSTF4 0
EQF4 $213
line 457
;457:			te = G_TempEntity( ent->s.pos.trBase, EV_GENERAL_SOUND );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 46
ARGI4
ADDRLP4 12
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 12
INDIRP4
ASGNP4
line 458
;458:		}
ADDRGP4 $214
JUMPV
LABELV $213
line 459
;459:		else {
line 460
;460:			te = G_TempEntity( ent->s.pos.trBase, EV_GLOBAL_SOUND );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 12
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 12
INDIRP4
ASGNP4
line 461
;461:		}
LABELV $214
line 462
;462:		te->s.eventParm = G_SoundIndex( "sound/items/poweruprespawn.wav" );
ADDRGP4 $215
ARGP4
ADDRLP4 12
ADDRGP4 G_SoundIndex
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 463
;463:		te->r.svFlags |= SVF_BROADCAST;
ADDRLP4 16
ADDRLP4 8
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 464
;464:	}
LABELV $211
line 466
;465:
;466:	if ( ent->item->giType == IT_HOLDABLE && ent->item->giTag == HI_KAMIKAZE ) {
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 6
NEI4 $216
ADDRLP4 8
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 3
NEI4 $216
line 471
;467:		// play powerup spawn sound to all clients
;468:		gentity_t	*te;
;469:
;470:		// if the powerup respawn sound should Not be global
;471:		if (ent->speed) {
ADDRFP4 0
INDIRP4
CNSTI4 676
ADDP4
INDIRF4
CNSTF4 0
EQF4 $218
line 472
;472:			te = G_TempEntity( ent->s.pos.trBase, EV_GENERAL_SOUND );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 46
ARGI4
ADDRLP4 16
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 16
INDIRP4
ASGNP4
line 473
;473:		}
ADDRGP4 $219
JUMPV
LABELV $218
line 474
;474:		else {
line 475
;475:			te = G_TempEntity( ent->s.pos.trBase, EV_GLOBAL_SOUND );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 16
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 16
INDIRP4
ASGNP4
line 476
;476:		}
LABELV $219
line 477
;477:		te->s.eventParm = G_SoundIndex( "sound/items/kamikazerespawn.wav" );
ADDRGP4 $220
ARGP4
ADDRLP4 16
ADDRGP4 G_SoundIndex
CALLI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 478
;478:		te->r.svFlags |= SVF_BROADCAST;
ADDRLP4 20
ADDRLP4 12
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 479
;479:	}
LABELV $216
line 482
;480:
;481:	// play the normal respawn sound only to nearby clients
;482:	G_AddEvent( ent, EV_ITEM_RESPAWN, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 40
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 484
;483:
;484:	ent->nextthink = 0;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
CNSTI4 0
ASGNI4
line 485
;485:}
LABELV $197
endproc RespawnItem 24 12
export Touch_Item
proc Touch_Item 44 12
line 493
;486:
;487:
;488:/*
;489:===============
;490:Touch_Item
;491:===============
;492:*/
;493:void Touch_Item (gentity_t *ent, gentity_t *other, trace_t *trace) {
line 497
;494:	int			respawn;
;495:	qboolean	predict;
;496:
;497:	if (!other->client)
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $222
line 498
;498:		return;
ADDRGP4 $221
JUMPV
LABELV $222
line 499
;499:	if (other->health < 1)
ADDRFP4 4
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 1
GEI4 $224
line 500
;500:		return;		// dead people can't pickup
ADDRGP4 $221
JUMPV
LABELV $224
line 503
;501:
;502:	// the same pickup rules are used for client side and server side
;503:	if ( !BG_CanItemBeGrabbed( g_gametype.integer, &ent->s, &other->client->ps ) ) {
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BG_CanItemBeGrabbed
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $226
line 504
;504:		return;
ADDRGP4 $221
JUMPV
LABELV $226
line 507
;505:	}
;506:
;507:	G_LogPrintf( "Item: %i %s\n", other->s.number, ent->item->classname );
ADDRGP4 $229
ARGP4
ADDRFP4 4
INDIRP4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 509
;508:
;509:	predict = other->client->pers.predictItemPickup;
ADDRLP4 4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 504
ADDP4
INDIRI4
ASGNI4
line 512
;510:
;511:	// call the item-specific pickup function
;512:	switch( ent->item->giType ) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 1
LTI4 $221
ADDRLP4 12
INDIRI4
CNSTI4 8
GTI4 $221
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $242-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $242
address $233
address $234
address $235
address $236
address $237
address $241
address $221
address $238
code
LABELV $233
line 514
;513:	case IT_WEAPON:
;514:		respawn = Pickup_Weapon(ent, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 Pickup_Weapon
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 20
INDIRI4
ASGNI4
line 516
;515://		predict = qfalse;
;516:		break;
ADDRGP4 $231
JUMPV
LABELV $234
line 518
;517:	case IT_AMMO:
;518:		respawn = Pickup_Ammo(ent, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 Pickup_Ammo
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 24
INDIRI4
ASGNI4
line 520
;519://		predict = qfalse;
;520:		break;
ADDRGP4 $231
JUMPV
LABELV $235
line 522
;521:	case IT_ARMOR:
;522:		respawn = Pickup_Armor(ent, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 Pickup_Armor
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 28
INDIRI4
ASGNI4
line 523
;523:		break;
ADDRGP4 $231
JUMPV
LABELV $236
line 525
;524:	case IT_HEALTH:
;525:		respawn = Pickup_Health(ent, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 Pickup_Health
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 32
INDIRI4
ASGNI4
line 526
;526:		break;
ADDRGP4 $231
JUMPV
LABELV $237
line 528
;527:	case IT_POWERUP:
;528:		respawn = Pickup_Powerup(ent, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 Pickup_Powerup
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 36
INDIRI4
ASGNI4
line 529
;529:		predict = qfalse;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 530
;530:		break;
ADDRGP4 $231
JUMPV
LABELV $238
line 541
;531:#ifdef MISSIONPACK
;532:	case IT_PERSISTANT_POWERUP:
;533:		respawn = Pickup_PersistantPowerup(ent, other);
;534:		break;
;535:#endif
;536:	case IT_TEAM:
;537:		// JUHOX: check for picking up an artefact
;538:#if !MONSTER_MODE
;539:		respawn = Pickup_Team(ent, other);
;540:#else
;541:		if (ent->item->giTag == PW_QUAD) {
ADDRFP4 0
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 1
NEI4 $239
line 542
;542:			respawn = Pickup_Artefact(ent, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 Pickup_Artefact
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 40
INDIRI4
ASGNI4
line 543
;543:		}
ADDRGP4 $231
JUMPV
LABELV $239
line 544
;544:		else {
line 545
;545:			respawn = Pickup_Team(ent, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 Pickup_Team
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 40
INDIRI4
ASGNI4
line 546
;546:		}
line 548
;547:#endif
;548:		break;
ADDRGP4 $231
JUMPV
LABELV $241
line 550
;549:	case IT_HOLDABLE:
;550:		respawn = Pickup_Holdable(ent, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 Pickup_Holdable
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 40
INDIRI4
ASGNI4
line 551
;551:		break;
line 553
;552:	default:
;553:		return;
LABELV $231
line 556
;554:	}
;555:
;556:	if ( !respawn ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $244
line 557
;557:		return;
ADDRGP4 $221
JUMPV
LABELV $244
line 561
;558:	}
;559:
;560:	// play the normal pickup sound
;561:	if (predict) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $246
line 562
;562:		G_AddPredictableEvent( other, EV_ITEM_PICKUP, ent->s.modelindex );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 19
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_AddPredictableEvent
CALLV
pop
line 563
;563:	} else {
ADDRGP4 $247
JUMPV
LABELV $246
line 564
;564:		G_AddEvent( other, EV_ITEM_PICKUP, ent->s.modelindex );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 19
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 565
;565:	}
LABELV $247
line 572
;566:
;567:	// powerup pickups are global broadcasts
;568:	// JUHOX: don't play global sounds for powerups
;569:#if 0
;570:	if ( ent->item->giType == IT_POWERUP || ent->item->giType == IT_TEAM) {
;571:#else
;572:	if (ent->item->giType == IT_TEAM) {
ADDRFP4 0
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
NEI4 $248
line 575
;573:#endif
;574:		// if we want the global sound to play
;575:		if (!ent->speed) {
ADDRFP4 0
INDIRP4
CNSTI4 676
ADDP4
INDIRF4
CNSTF4 0
NEF4 $250
line 578
;576:			gentity_t	*te;
;577:
;578:			te = G_TempEntity( ent->s.pos.trBase, EV_GLOBAL_ITEM_PICKUP );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 20
ARGI4
ADDRLP4 24
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 24
INDIRP4
ASGNP4
line 579
;579:			te->s.eventParm = ent->s.modelindex;
ADDRLP4 20
INDIRP4
CNSTI4 184
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ASGNI4
line 580
;580:			te->r.svFlags |= SVF_BROADCAST;
ADDRLP4 28
ADDRLP4 20
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 581
;581:		} else {
ADDRGP4 $251
JUMPV
LABELV $250
line 584
;582:			gentity_t	*te;
;583:
;584:			te = G_TempEntity( ent->s.pos.trBase, EV_GLOBAL_ITEM_PICKUP );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 20
ARGI4
ADDRLP4 24
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 24
INDIRP4
ASGNP4
line 585
;585:			te->s.eventParm = ent->s.modelindex;
ADDRLP4 20
INDIRP4
CNSTI4 184
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ASGNI4
line 587
;586:			// only send this temp entity to a single client
;587:			te->r.svFlags |= SVF_SINGLECLIENT;
ADDRLP4 28
ADDRLP4 20
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 588
;588:			te->r.singleClient = other->s.number;
ADDRLP4 20
INDIRP4
CNSTI4 428
ADDP4
ADDRFP4 4
INDIRP4
INDIRI4
ASGNI4
line 589
;589:		}
LABELV $251
line 590
;590:	}
LABELV $248
line 593
;591:
;592:	// fire item targets
;593:	G_UseTargets (ent, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 G_UseTargets
CALLV
pop
line 596
;594:
;595:	// wait of -1 will not respawn
;596:	if ( ent->wait == -1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 800
ADDP4
INDIRF4
CNSTF4 3212836864
NEF4 $252
line 597
;597:		ent->r.svFlags |= SVF_NOCLIENT;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 598
;598:		ent->s.eFlags |= EF_NODRAW;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 599
;599:		ent->r.contents = 0;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 0
ASGNI4
line 600
;600:		ent->unlinkAfterEvent = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 564
ADDP4
CNSTI4 1
ASGNI4
line 601
;601:		return;
ADDRGP4 $221
JUMPV
LABELV $252
line 605
;602:	}
;603:
;604:	// non zero wait overrides respawn time
;605:	if ( ent->wait ) {
ADDRFP4 0
INDIRP4
CNSTI4 800
ADDP4
INDIRF4
CNSTF4 0
EQF4 $254
line 606
;606:		respawn = ent->wait;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 800
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 607
;607:	}
LABELV $254
line 610
;608:
;609:	// random can be used to vary the respawn time
;610:	if ( ent->random ) {
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRF4
CNSTF4 0
EQF4 $256
line 611
;611:		respawn += crandom() * ent->random;
ADDRLP4 20
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
ADDRLP4 20
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 20
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
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 612
;612:		if ( respawn < 1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 1
GEI4 $258
line 613
;613:			respawn = 1;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 614
;614:		}
LABELV $258
line 615
;615:	}
LABELV $256
line 618
;616:
;617:	// dropped items will not respawn
;618:	if ( ent->flags & FL_DROPPED_ITEM ) {
ADDRFP4 0
INDIRP4
CNSTI4 540
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $260
line 619
;619:		ent->freeAfterEvent = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 560
ADDP4
CNSTI4 1
ASGNI4
line 620
;620:	}
LABELV $260
line 625
;621:
;622:	// picked up items still stay around, they just don't
;623:	// draw anything.  This allows respawnable items
;624:	// to be placed on movers.
;625:	ent->r.svFlags |= SVF_NOCLIENT;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 626
;626:	ent->s.eFlags |= EF_NODRAW;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 627
;627:	ent->r.contents = 0;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 0
ASGNI4
line 633
;628:
;629:	// ZOID
;630:	// A negative respawn times means to never respawn this item (but don't 
;631:	// delete it).  This is used by items that are respawned by third party 
;632:	// events such as ctf flags
;633:	if ( respawn <= 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GTI4 $262
line 634
;634:		ent->nextthink = 0;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
CNSTI4 0
ASGNI4
line 635
;635:		ent->think = 0;
ADDRFP4 0
INDIRP4
CNSTI4 696
ADDP4
CNSTP4 0
ASGNP4
line 636
;636:	} else {
ADDRGP4 $263
JUMPV
LABELV $262
line 637
;637:		ent->nextthink = level.time + respawn * 1000;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 1000
MULI4
ADDI4
ASGNI4
line 638
;638:		ent->think = RespawnItem;
ADDRFP4 0
INDIRP4
CNSTI4 696
ADDP4
ADDRGP4 RespawnItem
ASGNP4
line 639
;639:	}
LABELV $263
line 640
;640:	trap_LinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 641
;641:}
LABELV $221
endproc Touch_Item 44 12
export G_SpawnArtefact
proc G_SpawnArtefact 152 28
line 654
;642:
;643:
;644://======================================================================
;645:
;646:/*
;647:================
;648:JUHOX: G_SpawnArtefact
;649:
;650:derived in part from LaunchItem()
;651:================
;652:*/
;653:#if MONSTER_MODE
;654:void G_SpawnArtefact(void) {
line 662
;655:	int i;
;656:	int numItems1;
;657:	int numItems2;
;658:	gentity_t* placeHolder1;
;659:	gentity_t* placeHolder2;
;660:	vec3_t origin;
;661:
;662:	if (g_gametype.integer != GT_STU) return;
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
EQI4 $266
ADDRGP4 $265
JUMPV
LABELV $266
line 664
;663:
;664:	if (!level.artefact) {
ADDRGP4 level+23000
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $269
line 667
;665:		gitem_t* item;
;666:
;667:		item = BG_FindItem("Artefact");
ADDRGP4 $272
ARGP4
ADDRLP4 36
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 32
ADDRLP4 36
INDIRP4
ASGNP4
line 668
;668:		if (!item) return;
ADDRLP4 32
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $273
ADDRGP4 $265
JUMPV
LABELV $273
line 670
;669:
;670:		level.artefact = G_Spawn();
ADDRLP4 40
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRGP4 level+23000
ADDRLP4 40
INDIRP4
ASGNP4
line 671
;671:		if (!level.artefact) return;
ADDRGP4 level+23000
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $276
ADDRGP4 $265
JUMPV
LABELV $276
line 673
;672:
;673:		level.artefact->s.eType = ET_ITEM;
ADDRGP4 level+23000
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 2
ASGNI4
line 674
;674:		level.artefact->s.modelindex = item - bg_itemlist;
ADDRGP4 level+23000
INDIRP4
CNSTI4 160
ADDP4
ADDRLP4 32
INDIRP4
CVPU4 4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
ASGNI4
line 675
;675:		level.artefact->s.modelindex2 = 0;
ADDRGP4 level+23000
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 0
ASGNI4
line 677
;676:
;677:		level.artefact->classname = item->classname;
ADDRGP4 level+23000
INDIRP4
CNSTI4 528
ADDP4
ADDRLP4 32
INDIRP4
INDIRP4
ASGNP4
line 678
;678:		level.artefact->item = item;
ADDRGP4 level+23000
INDIRP4
CNSTI4 808
ADDP4
ADDRLP4 32
INDIRP4
ASGNP4
line 679
;679:		VectorSet(level.artefact->r.mins, -ITEM_RADIUS, -ITEM_RADIUS, -ITEM_RADIUS);
ADDRGP4 level+23000
INDIRP4
CNSTI4 436
ADDP4
CNSTF4 3245342720
ASGNF4
ADDRGP4 level+23000
INDIRP4
CNSTI4 440
ADDP4
CNSTF4 3245342720
ASGNF4
ADDRGP4 level+23000
INDIRP4
CNSTI4 444
ADDP4
CNSTF4 3245342720
ASGNF4
line 680
;680:		VectorSet(level.artefact->r.maxs, ITEM_RADIUS, ITEM_RADIUS, ITEM_RADIUS);
ADDRGP4 level+23000
INDIRP4
CNSTI4 448
ADDP4
CNSTF4 1097859072
ASGNF4
ADDRGP4 level+23000
INDIRP4
CNSTI4 452
ADDP4
CNSTF4 1097859072
ASGNF4
ADDRGP4 level+23000
INDIRP4
CNSTI4 456
ADDP4
CNSTF4 1097859072
ASGNF4
line 681
;681:		level.artefact->r.contents = CONTENTS_TRIGGER;
ADDRGP4 level+23000
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 1073741824
ASGNI4
line 683
;682:
;683:		level.artefact->touch = Touch_Item;
ADDRGP4 level+23000
INDIRP4
CNSTI4 708
ADDP4
ADDRGP4 Touch_Item
ASGNP4
line 684
;684:	}
LABELV $269
line 686
;685:
;686:	if (level.artefactPlaceholder) {
ADDRGP4 level+23004
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $292
line 687
;687:		level.artefactPlaceholder->think = RespawnItem;
ADDRGP4 level+23004
INDIRP4
CNSTI4 696
ADDP4
ADDRGP4 RespawnItem
ASGNP4
line 688
;688:		level.artefactPlaceholder->nextthink = level.time + 30000;
ADDRGP4 level+23004
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 30000
ADDI4
ASGNI4
line 689
;689:		level.artefactPlaceholder = NULL;
ADDRGP4 level+23004
CNSTP4 0
ASGNP4
line 690
;690:	}
LABELV $292
line 692
;691:
;692:	numItems1 = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 693
;693:	placeHolder1 = NULL;
ADDRLP4 12
CNSTP4 0
ASGNP4
line 694
;694:	numItems2 = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 695
;695:	placeHolder2 = NULL;
ADDRLP4 16
CNSTP4 0
ASGNP4
line 696
;696:	for (i = MAX_CLIENTS; i < level.num_entities; i++) {
ADDRLP4 0
CNSTI4 64
ASGNI4
ADDRGP4 $302
JUMPV
LABELV $299
line 699
;697:		gentity_t* ent;
;698:
;699:		ent = &g_entities[i];
ADDRLP4 32
ADDRLP4 0
INDIRI4
CNSTI4 844
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 700
;700:		if (!ent->inuse) continue;
ADDRLP4 32
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $304
ADDRGP4 $300
JUMPV
LABELV $304
line 701
;701:		if (ent->s.eType != ET_ITEM) continue;
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $306
ADDRGP4 $300
JUMPV
LABELV $306
line 702
;702:		if (ent->s.modelindex2) continue;	// dropped item
ADDRLP4 32
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 0
EQI4 $308
ADDRGP4 $300
JUMPV
LABELV $308
line 703
;703:		if (ent == level.artefact) continue;
ADDRLP4 32
INDIRP4
CVPU4 4
ADDRGP4 level+23000
INDIRP4
CVPU4 4
NEU4 $310
ADDRGP4 $300
JUMPV
LABELV $310
line 705
;704:
;705:		numItems2++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 706
;706:		if (SeededRandom(GST_artefactSpawning) % numItems2 == 0) placeHolder2 = ent;
CNSTI4 1
ARGI4
ADDRLP4 36
ADDRGP4 SeededRandom
CALLU4
ASGNU4
ADDRLP4 36
INDIRU4
ADDRLP4 8
INDIRI4
CVIU4 4
MODU4
CNSTU4 0
NEU4 $313
ADDRLP4 16
ADDRLP4 32
INDIRP4
ASGNP4
LABELV $313
line 709
;707:
;708:		if (
;709:			level.artefact &&
ADDRGP4 level+23000
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $315
ADDRLP4 32
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRGP4 level+23000
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 40
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 40
INDIRF4
CNSTF4 1232348160
GEF4 $315
line 711
;710:			DistanceSquared(ent->s.pos.trBase, level.artefact->s.pos.trBase) < Square(1000.0)
;711:		) {
line 712
;712:			continue;
ADDRGP4 $300
JUMPV
LABELV $315
line 715
;713:		}
;714:
;715:		numItems1++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 716
;716:		if (SeededRandom(GST_artefactSpawning) % numItems1 == 0) placeHolder1 = ent;
CNSTI4 1
ARGI4
ADDRLP4 44
ADDRGP4 SeededRandom
CALLU4
ASGNU4
ADDRLP4 44
INDIRU4
ADDRLP4 4
INDIRI4
CVIU4 4
MODU4
CNSTU4 0
NEU4 $319
ADDRLP4 12
ADDRLP4 32
INDIRP4
ASGNP4
LABELV $319
line 717
;717:	}
LABELV $300
line 696
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $302
ADDRLP4 0
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $299
line 718
;718:	if (!placeHolder2) {
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $321
line 727
;719:		int choosen;
;720:		int numSpawnPoints;
;721:		trace_t trace;
;722:		vec3_t mins;
;723:		vec3_t maxs;
;724:		vec3_t start;
;725:		vec3_t end;
;726:
;727:		if (level.numEmergencySpawnPoints <= 0) {
ADDRGP4 level+10700
INDIRI4
CNSTI4 0
GTI4 $323
line 728
;728:			G_Error("Couldn't find a suitable item to spawn artefact.\n");
ADDRGP4 $326
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 729
;729:			return;
ADDRGP4 $265
JUMPV
LABELV $323
line 732
;730:		}
;731:
;732:		numSpawnPoints = 0;
ADDRLP4 32
CNSTI4 0
ASGNI4
line 733
;733:		choosen = -1;
ADDRLP4 36
CNSTI4 -1
ASGNI4
line 734
;734:		for (i = 0; i < level.numEmergencySpawnPoints; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $330
JUMPV
LABELV $327
line 736
;735:			if (
;736:				level.artefact &&
ADDRGP4 level+23000
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $332
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 level+10704
ADDP4
ARGP4
ADDRGP4 level+23000
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 144
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 144
INDIRF4
CNSTF4 1232348160
GEF4 $332
line 738
;737:				DistanceSquared(level.emergencySpawnPoints[i], level.artefact->s.pos.trBase) < Square(1000.0)
;738:			) {
line 739
;739:				continue;
ADDRGP4 $328
JUMPV
LABELV $332
line 742
;740:			}
;741:
;742:			numSpawnPoints++;
ADDRLP4 32
ADDRLP4 32
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 743
;743:			if (SeededRandom(GST_artefactSpawning) % numSpawnPoints == 0) choosen = i;
CNSTI4 1
ARGI4
ADDRLP4 148
ADDRGP4 SeededRandom
CALLU4
ASGNU4
ADDRLP4 148
INDIRU4
ADDRLP4 32
INDIRI4
CVIU4 4
MODU4
CNSTU4 0
NEU4 $337
ADDRLP4 36
ADDRLP4 0
INDIRI4
ASGNI4
LABELV $337
line 744
;744:		}
LABELV $328
line 734
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $330
ADDRLP4 0
INDIRI4
ADDRGP4 level+10700
INDIRI4
LTI4 $327
line 745
;745:		if (choosen < 0) {
ADDRLP4 36
INDIRI4
CNSTI4 0
GEI4 $339
line 746
;746:			choosen = SeededRandom(GST_artefactSpawning) % level.numEmergencySpawnPoints;
CNSTI4 1
ARGI4
ADDRLP4 144
ADDRGP4 SeededRandom
CALLU4
ASGNU4
ADDRLP4 36
ADDRLP4 144
INDIRU4
ADDRGP4 level+10700
INDIRI4
CVIU4 4
MODU4
CVUI4 4
ASGNI4
line 747
;747:		}
LABELV $339
line 748
;748:		VectorCopy(level.emergencySpawnPoints[choosen], start);
ADDRLP4 64
ADDRLP4 36
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 level+10704
ADDP4
INDIRB
ASGNB 12
line 749
;749:		VectorCopy(start, end);
ADDRLP4 76
ADDRLP4 64
INDIRB
ASGNB 12
line 750
;750:		end[2] -= 4000;
ADDRLP4 76+8
ADDRLP4 76+8
INDIRF4
CNSTF4 1165623296
SUBF4
ASGNF4
line 751
;751:		VectorSet(mins, -ITEM_RADIUS, -ITEM_RADIUS, -ITEM_RADIUS);
ADDRLP4 40
CNSTF4 3245342720
ASGNF4
ADDRLP4 40+4
CNSTF4 3245342720
ASGNF4
ADDRLP4 40+8
CNSTF4 3245342720
ASGNF4
line 752
;752:		VectorSet(maxs, ITEM_RADIUS, ITEM_RADIUS, ITEM_RADIUS);
ADDRLP4 52
CNSTF4 1097859072
ASGNF4
ADDRLP4 52+4
CNSTF4 1097859072
ASGNF4
ADDRLP4 52+8
CNSTF4 1097859072
ASGNF4
line 753
;753:		trap_Trace(&trace, start, mins, maxs, end, -1, MASK_PLAYERSOLID & ~CONTENTS_BODY);
ADDRLP4 88
ARGP4
ADDRLP4 64
ARGP4
ADDRLP4 40
ARGP4
ADDRLP4 52
ARGP4
ADDRLP4 76
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 65537
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 754
;754:		VectorCopy(trace.endpos, origin);
ADDRLP4 20
ADDRLP4 88+12
INDIRB
ASGNB 12
line 755
;755:	}
ADDRGP4 $322
JUMPV
LABELV $321
line 756
;756:	else {
line 757
;757:		if (!placeHolder1) placeHolder1 = placeHolder2;
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $349
ADDRLP4 12
ADDRLP4 16
INDIRP4
ASGNP4
LABELV $349
line 760
;758:
;759:		// inhibit placeHolder
;760:		placeHolder1->r.svFlags |= SVF_NOCLIENT;
ADDRLP4 32
ADDRLP4 12
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 761
;761:		placeHolder1->s.eFlags |= EF_NODRAW;
ADDRLP4 36
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 762
;762:		placeHolder1->r.contents = 0;
ADDRLP4 12
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 0
ASGNI4
line 763
;763:		placeHolder1->nextthink = 0;
ADDRLP4 12
INDIRP4
CNSTI4 692
ADDP4
CNSTI4 0
ASGNI4
line 764
;764:		placeHolder1->think = 0;
ADDRLP4 12
INDIRP4
CNSTI4 696
ADDP4
CNSTP4 0
ASGNP4
line 765
;765:		level.artefactPlaceholder = placeHolder1;
ADDRGP4 level+23004
ADDRLP4 12
INDIRP4
ASGNP4
line 766
;766:		VectorCopy(placeHolder1->s.pos.trBase, origin);
ADDRLP4 20
ADDRLP4 12
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 767
;767:	}
LABELV $322
line 769
;768:
;769:	level.artefact->think = 0;
ADDRGP4 level+23000
INDIRP4
CNSTI4 696
ADDP4
CNSTP4 0
ASGNP4
line 770
;770:	level.artefact->nextthink = 0;
ADDRGP4 level+23000
INDIRP4
CNSTI4 692
ADDP4
CNSTI4 0
ASGNI4
line 771
;771:	G_SetOrigin(level.artefact, origin);
ADDRGP4 level+23000
INDIRP4
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 772
;772:	level.artefact->s.eFlags ^= EF_TELEPORT_BIT;
ADDRLP4 32
ADDRGP4 level+23000
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 4
BXORI4
ASGNI4
line 773
;773:	level.artefact->r.contents = CONTENTS_TRIGGER;
ADDRGP4 level+23000
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 1073741824
ASGNI4
line 774
;774:	level.artefact->s.eFlags &= ~EF_NODRAW;
ADDRLP4 36
ADDRGP4 level+23000
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 775
;775:	level.artefact->r.svFlags &= ~SVF_NOCLIENT;
ADDRLP4 40
ADDRGP4 level+23000
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 776
;776:	trap_LinkEntity(level.artefact);
ADDRGP4 level+23000
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 777
;777:}
LABELV $265
endproc G_SpawnArtefact 152 28
export LaunchItem
proc LaunchItem 12 8
line 787
;778:#endif
;779:
;780:/*
;781:================
;782:LaunchItem
;783:
;784:Spawns an item and tosses it forward
;785:================
;786:*/
;787:gentity_t *LaunchItem( gitem_t *item, vec3_t origin, vec3_t velocity ) {
line 790
;788:	gentity_t	*dropped;
;789:
;790:	dropped = G_Spawn();
ADDRLP4 4
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 791
;791:	if (!dropped) return NULL;	// JUHOX BUGFIX
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $361
CNSTP4 0
RETP4
ADDRGP4 $360
JUMPV
LABELV $361
line 793
;792:
;793:	dropped->s.eType = ET_ITEM;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 2
ASGNI4
line 794
;794:	dropped->s.modelindex = item - bg_itemlist;	// store item number in modelindex
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
ASGNI4
line 795
;795:	dropped->s.modelindex2 = 1; // This is non-zero is it's a dropped item
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 1
ASGNI4
line 797
;796:
;797:	dropped->classname = item->classname;
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
ADDRFP4 0
INDIRP4
INDIRP4
ASGNP4
line 798
;798:	dropped->item = item;
ADDRLP4 0
INDIRP4
CNSTI4 808
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 799
;799:	VectorSet (dropped->r.mins, -ITEM_RADIUS, -ITEM_RADIUS, -ITEM_RADIUS);
ADDRLP4 0
INDIRP4
CNSTI4 436
ADDP4
CNSTF4 3245342720
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 440
ADDP4
CNSTF4 3245342720
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 444
ADDP4
CNSTF4 3245342720
ASGNF4
line 800
;800:	VectorSet (dropped->r.maxs, ITEM_RADIUS, ITEM_RADIUS, ITEM_RADIUS);
ADDRLP4 0
INDIRP4
CNSTI4 448
ADDP4
CNSTF4 1097859072
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 452
ADDP4
CNSTF4 1097859072
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 456
ADDP4
CNSTF4 1097859072
ASGNF4
line 801
;801:	dropped->r.contents = CONTENTS_TRIGGER;
ADDRLP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 1073741824
ASGNI4
line 803
;802:
;803:	dropped->touch = Touch_Item;
ADDRLP4 0
INDIRP4
CNSTI4 708
ADDP4
ADDRGP4 Touch_Item
ASGNP4
line 805
;804:
;805:	G_SetOrigin( dropped, origin );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 806
;806:	dropped->s.pos.trType = TR_GRAVITY;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 5
ASGNI4
line 807
;807:	dropped->s.pos.trTime = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 808
;808:	VectorCopy( velocity, dropped->s.pos.trDelta );
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRFP4 8
INDIRP4
INDIRB
ASGNB 12
line 810
;809:
;810:	dropped->s.eFlags |= EF_BOUNCE_HALF;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 814
;811:#ifdef MISSIONPACK
;812:	if ((g_gametype.integer == GT_CTF || g_gametype.integer == GT_1FCTF)			&& item->giType == IT_TEAM) { // Special case for CTF flags
;813:#else
;814:	if (g_gametype.integer == GT_CTF && item->giType == IT_TEAM) { // Special case for CTF flags
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $364
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
NEI4 $364
line 816
;815:#endif
;816:		dropped->think = Team_DroppedFlagThink;
ADDRLP4 0
INDIRP4
CNSTI4 696
ADDP4
ADDRGP4 Team_DroppedFlagThink
ASGNP4
line 817
;817:		dropped->nextthink = level.time + 30000;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 30000
ADDI4
ASGNI4
line 818
;818:		Team_CheckDroppedItem( dropped );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Team_CheckDroppedItem
CALLV
pop
line 819
;819:	} else { // auto-remove after 30 seconds
ADDRGP4 $365
JUMPV
LABELV $364
line 820
;820:		dropped->think = G_FreeEntity;
ADDRLP4 0
INDIRP4
CNSTI4 696
ADDP4
ADDRGP4 G_FreeEntity
ASGNP4
line 821
;821:		dropped->nextthink = level.time + 30000;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 30000
ADDI4
ASGNI4
line 822
;822:	}
LABELV $365
line 824
;823:
;824:	dropped->flags = FL_DROPPED_ITEM;
ADDRLP4 0
INDIRP4
CNSTI4 540
ADDP4
CNSTI4 4096
ASGNI4
line 826
;825:
;826:	trap_LinkEntity (dropped);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 828
;827:
;828:	return dropped;
ADDRLP4 0
INDIRP4
RETP4
LABELV $360
endproc LaunchItem 12 8
export Drop_Item
proc Drop_Item 32 16
line 838
;829:}
;830:
;831:/*
;832:================
;833:Drop_Item
;834:
;835:Spawns an item and tosses it forward
;836:================
;837:*/
;838:gentity_t *Drop_Item( gentity_t *ent, gitem_t *item, float angle ) {
line 842
;839:	vec3_t	velocity;
;840:	vec3_t	angles;
;841:
;842:	VectorCopy( ent->s.apos.trBase, angles );
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRB
ASGNB 12
line 843
;843:	angles[YAW] += angle;
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
ADDRFP4 8
INDIRF4
ADDF4
ASGNF4
line 844
;844:	angles[PITCH] = 0;	// always forward
ADDRLP4 12
CNSTF4 0
ASGNF4
line 846
;845:
;846:	AngleVectors( angles, velocity, NULL, NULL );
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 847
;847:	VectorScale( velocity, 150, velocity );
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1125515264
MULF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
CNSTF4 1125515264
MULF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1125515264
MULF4
ASGNF4
line 848
;848:	velocity[2] += 200 + crandom() * 50;
ADDRLP4 24
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 24
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 24
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
CNSTF4 1120403456
MULF4
CNSTF4 1128792064
ADDF4
ADDF4
ASGNF4
line 850
;849:	
;850:	return LaunchItem( item, ent->s.pos.trBase, velocity );
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 28
ADDRGP4 LaunchItem
CALLP4
ASGNP4
ADDRLP4 28
INDIRP4
RETP4
LABELV $369
endproc Drop_Item 32 16
export Use_Item
proc Use_Item 0 4
line 861
;851:}
;852:
;853:
;854:/*
;855:================
;856:Use_Item
;857:
;858:Respawn the item
;859:================
;860:*/
;861:void Use_Item( gentity_t *ent, gentity_t *other, gentity_t *activator ) {
line 862
;862:	RespawnItem( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 RespawnItem
CALLV
pop
line 863
;863:}
LABELV $376
endproc Use_Item 0 4
export FinishSpawningItem
proc FinishSpawningItem 88 28
line 875
;864:
;865://======================================================================
;866:
;867:/*
;868:================
;869:FinishSpawningItem
;870:
;871:Traces down to find where an item should rest, instead of letting them
;872:free fall from their spawn points
;873:================
;874:*/
;875:void FinishSpawningItem( gentity_t *ent ) {
line 879
;876:	trace_t		tr;
;877:	vec3_t		dest;
;878:
;879:	VectorSet( ent->r.mins, -ITEM_RADIUS, -ITEM_RADIUS, -ITEM_RADIUS );
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
CNSTF4 3245342720
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 440
ADDP4
CNSTF4 3245342720
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
CNSTF4 3245342720
ASGNF4
line 880
;880:	VectorSet( ent->r.maxs, ITEM_RADIUS, ITEM_RADIUS, ITEM_RADIUS );
ADDRFP4 0
INDIRP4
CNSTI4 448
ADDP4
CNSTF4 1097859072
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 452
ADDP4
CNSTF4 1097859072
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 456
ADDP4
CNSTF4 1097859072
ASGNF4
line 882
;881:
;882:	ent->s.eType = ET_ITEM;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 2
ASGNI4
line 883
;883:	ent->s.modelindex = ent->item - bg_itemlist;		// store item number in modelindex
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 160
ADDP4
ADDRLP4 68
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
ASGNI4
line 884
;884:	ent->s.modelindex2 = 0; // zero indicates this isn't a dropped item
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 0
ASGNI4
line 886
;885:
;886:	ent->r.contents = CONTENTS_TRIGGER;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 1073741824
ASGNI4
line 887
;887:	ent->touch = Touch_Item;
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
ADDRGP4 Touch_Item
ASGNP4
line 889
;888:	// useing an item causes it to respawn
;889:	ent->use = Use_Item;
ADDRFP4 0
INDIRP4
CNSTI4 712
ADDP4
ADDRGP4 Use_Item
ASGNP4
line 891
;890:
;891:	if ( ent->spawnflags & 1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $378
line 893
;892:		// suspended
;893:		G_SetOrigin( ent, ent->s.origin );
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRLP4 72
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 894
;894:	} else {
ADDRGP4 $379
JUMPV
LABELV $378
line 896
;895:		// drop to floor
;896:		VectorSet( dest, ent->s.origin[0], ent->s.origin[1], ent->s.origin[2] - 4096 );
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
ADDRLP4 72
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ASGNF4
ADDRLP4 56+4
ADDRLP4 72
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ASGNF4
ADDRLP4 56+8
ADDRFP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
CNSTF4 1166016512
SUBF4
ASGNF4
line 897
;897:		trap_Trace( &tr, ent->s.origin, ent->r.mins, ent->r.maxs, dest, ent->s.number, MASK_SOLID );
ADDRLP4 0
ARGP4
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 76
INDIRP4
CNSTI4 436
ADDP4
ARGP4
ADDRLP4 76
INDIRP4
CNSTI4 448
ADDP4
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 76
INDIRP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 898
;898:		if ( tr.startsolid ) {
ADDRLP4 0+4
INDIRI4
CNSTI4 0
EQI4 $382
line 899
;899:			G_Printf ("FinishSpawningItem: %s startsolid at %s\n", ent->classname, vtos(ent->s.origin));
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 80
ADDRGP4 vtos
CALLP4
ASGNP4
ADDRGP4 $385
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ARGP4
ADDRLP4 80
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 900
;900:			G_FreeEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 901
;901:			return;
ADDRGP4 $377
JUMPV
LABELV $382
line 905
;902:		}
;903:
;904:		// allow to ride movers
;905:		ent->s.groundEntityNum = tr.entityNum;
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
ADDRLP4 0+52
INDIRI4
ASGNI4
line 907
;906:
;907:		G_SetOrigin( ent, tr.endpos );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+12
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 908
;908:	}
LABELV $379
line 911
;909:
;910:	// team slaves and targeted items aren't present at start
;911:	if ( ( ent->flags & FL_TEAMSLAVE ) || ent->targetname ) {
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 540
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
NEI4 $390
ADDRLP4 72
INDIRP4
CNSTI4 656
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $388
LABELV $390
line 912
;912:		ent->s.eFlags |= EF_NODRAW;
ADDRLP4 76
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 913
;913:		ent->r.contents = 0;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 0
ASGNI4
line 914
;914:		return;
ADDRGP4 $377
JUMPV
LABELV $388
line 921
;915:	}
;916:
;917:	// powerups don't spawn in for a while
;918:#if !ESCAPE_MODE	// JUHOX: in EFH powerups spawn immediately
;919:	if ( ent->item->giType == IT_POWERUP ) {
;920:#else
;921:	if (ent->item->giType == IT_POWERUP && g_gametype.integer != GT_EFH) {
ADDRFP4 0
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 5
NEI4 $391
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
EQI4 $391
line 925
;922:#endif
;923:		float	respawn;
;924:
;925:		respawn = 45 + crandom() * 15;
ADDRLP4 80
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 76
ADDRLP4 80
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 80
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
CNSTF4 1106247680
MULF4
CNSTF4 1110704128
ADDF4
ASGNF4
line 926
;926:		ent->s.eFlags |= EF_NODRAW;
ADDRLP4 84
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 927
;927:		ent->r.contents = 0;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 0
ASGNI4
line 928
;928:		ent->nextthink = level.time + respawn * 1000;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 level+32
INDIRI4
CVIF4 4
ADDRLP4 76
INDIRF4
CNSTF4 1148846080
MULF4
ADDF4
CVFI4 4
ASGNI4
line 929
;929:		ent->think = RespawnItem;
ADDRFP4 0
INDIRP4
CNSTI4 696
ADDP4
ADDRGP4 RespawnItem
ASGNP4
line 930
;930:		return;
ADDRGP4 $377
JUMPV
LABELV $391
line 934
;931:	}
;932:
;933:
;934:	trap_LinkEntity (ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 935
;935:}
LABELV $377
endproc FinishSpawningItem 88 28
export G_CheckTeamItems
proc G_CheckTeamItems 20 4
line 945
;936:
;937:
;938:qboolean	itemRegistered[MAX_ITEMS];
;939:
;940:/*
;941:==================
;942:G_CheckTeamItems
;943:==================
;944:*/
;945:void G_CheckTeamItems( void ) {
line 948
;946:
;947:	// Set up team stuff
;948:	Team_InitGame();
ADDRGP4 Team_InitGame
CALLV
pop
line 950
;949:
;950:	if( g_gametype.integer == GT_CTF ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $396
line 954
;951:		gitem_t	*item;
;952:
;953:		// check for the two flags
;954:		item = BG_FindItem( "Red Flag" );
ADDRGP4 $399
ARGP4
ADDRLP4 4
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 955
;955:		if ( !item || !itemRegistered[ item - bg_itemlist ] ) {
ADDRLP4 8
ADDRLP4 0
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 8
INDIRU4
CNSTU4 0
EQU4 $402
ADDRLP4 8
INDIRU4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
CNSTI4 2
LSHI4
ADDRGP4 itemRegistered
ADDP4
INDIRI4
CNSTI4 0
NEI4 $400
LABELV $402
line 956
;956:			G_Printf( S_COLOR_YELLOW "WARNING: No team_CTF_redflag in map" );
ADDRGP4 $403
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 957
;957:		}
LABELV $400
line 958
;958:		item = BG_FindItem( "Blue Flag" );
ADDRGP4 $404
ARGP4
ADDRLP4 12
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 959
;959:		if ( !item || !itemRegistered[ item - bg_itemlist ] ) {
ADDRLP4 16
ADDRLP4 0
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 16
INDIRU4
CNSTU4 0
EQU4 $407
ADDRLP4 16
INDIRU4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
CNSTI4 2
LSHI4
ADDRGP4 itemRegistered
ADDP4
INDIRI4
CNSTI4 0
NEI4 $405
LABELV $407
line 960
;960:			G_Printf( S_COLOR_YELLOW "WARNING: No team_CTF_blueflag in map" );
ADDRGP4 $408
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 961
;961:		}
LABELV $405
line 962
;962:	}
LABELV $396
line 1022
;963:#ifdef MISSIONPACK
;964:	if( g_gametype.integer == GT_1FCTF ) {
;965:		gitem_t	*item;
;966:
;967:		// check for all three flags
;968:		item = BG_FindItem( "Red Flag" );
;969:		if ( !item || !itemRegistered[ item - bg_itemlist ] ) {
;970:			G_Printf( S_COLOR_YELLOW "WARNING: No team_CTF_redflag in map" );
;971:		}
;972:		item = BG_FindItem( "Blue Flag" );
;973:		if ( !item || !itemRegistered[ item - bg_itemlist ] ) {
;974:			G_Printf( S_COLOR_YELLOW "WARNING: No team_CTF_blueflag in map" );
;975:		}
;976:		item = BG_FindItem( "Neutral Flag" );
;977:		if ( !item || !itemRegistered[ item - bg_itemlist ] ) {
;978:			G_Printf( S_COLOR_YELLOW "WARNING: No team_CTF_neutralflag in map" );
;979:		}
;980:	}
;981:
;982:	if( g_gametype.integer == GT_OBELISK ) {
;983:		gentity_t	*ent;
;984:
;985:		// check for the two obelisks
;986:		ent = NULL;
;987:		ent = G_Find( ent, FOFS(classname), "team_redobelisk" );
;988:		if( !ent ) {
;989:			G_Printf( S_COLOR_YELLOW "WARNING: No team_redobelisk in map" );
;990:		}
;991:
;992:		ent = NULL;
;993:		ent = G_Find( ent, FOFS(classname), "team_blueobelisk" );
;994:		if( !ent ) {
;995:			G_Printf( S_COLOR_YELLOW "WARNING: No team_blueobelisk in map" );
;996:		}
;997:	}
;998:
;999:	if( g_gametype.integer == GT_HARVESTER ) {
;1000:		gentity_t	*ent;
;1001:
;1002:		// check for all three obelisks
;1003:		ent = NULL;
;1004:		ent = G_Find( ent, FOFS(classname), "team_redobelisk" );
;1005:		if( !ent ) {
;1006:			G_Printf( S_COLOR_YELLOW "WARNING: No team_redobelisk in map" );
;1007:		}
;1008:
;1009:		ent = NULL;
;1010:		ent = G_Find( ent, FOFS(classname), "team_blueobelisk" );
;1011:		if( !ent ) {
;1012:			G_Printf( S_COLOR_YELLOW "WARNING: No team_blueobelisk in map" );
;1013:		}
;1014:
;1015:		ent = NULL;
;1016:		ent = G_Find( ent, FOFS(classname), "team_neutralobelisk" );
;1017:		if( !ent ) {
;1018:			G_Printf( S_COLOR_YELLOW "WARNING: No team_neutralobelisk in map" );
;1019:		}
;1020:	}
;1021:#endif
;1022:}
LABELV $395
endproc G_CheckTeamItems 20 4
export ClearRegisteredItems
proc ClearRegisteredItems 48 12
line 1029
;1023:
;1024:/*
;1025:==============
;1026:ClearRegisteredItems
;1027:==============
;1028:*/
;1029:void ClearRegisteredItems( void ) {
line 1030
;1030:	memset( itemRegistered, 0, sizeof( itemRegistered ) );
ADDRGP4 itemRegistered
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1024
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1033
;1031:
;1032:#if MAPLENSFLARES	// JUHOX: don't load items for lens flare editor
;1033:	if (g_editmode.integer == EM_mlf) return;
ADDRGP4 g_editmode+12
INDIRI4
CNSTI4 1
NEI4 $410
ADDRGP4 $409
JUMPV
LABELV $410
line 1041
;1034:#endif
;1035:
;1036:	// players always start with the base weapon
;1037:#if 0	// JUHOX: new base weapons
;1038:	RegisterItem( BG_FindItemForWeapon( WP_MACHINEGUN ) );
;1039:	RegisterItem( BG_FindItemForWeapon( WP_GAUNTLET ) );
;1040:#else
;1041:	RegisterItem(BG_FindItem("5 Health"));
ADDRGP4 $413
ARGP4
ADDRLP4 0
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 1042
;1042:	RegisterItem(BG_FindItem("Armor Shard"));
ADDRGP4 $414
ARGP4
ADDRLP4 4
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 1043
;1043:	if (g_armorFragments.integer) {
ADDRGP4 g_armorFragments+12
INDIRI4
CNSTI4 0
EQI4 $415
line 1044
;1044:		RegisterItem(BG_FindItem("Armor Fragment 5"));
ADDRGP4 $418
ARGP4
ADDRLP4 8
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 1046
;1045:		//RegisterItem(BG_FindItem("Armor Fragment 25"));
;1046:	}
LABELV $415
line 1047
;1047:	RegisterItem(BG_FindItemForWeapon(WP_GAUNTLET));
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 BG_FindItemForWeapon
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 1048
;1048:	RegisterItem(BG_FindItemForWeapon(WP_MACHINEGUN));
CNSTI4 2
ARGI4
ADDRLP4 12
ADDRGP4 BG_FindItemForWeapon
CALLP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 1049
;1049:	RegisterItem(BG_FindItemForWeapon(WP_SHOTGUN));
CNSTI4 3
ARGI4
ADDRLP4 16
ADDRGP4 BG_FindItemForWeapon
CALLP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 1050
;1050:	RegisterItem(BG_FindItemForWeapon(WP_GRENADE_LAUNCHER));
CNSTI4 4
ARGI4
ADDRLP4 20
ADDRGP4 BG_FindItemForWeapon
CALLP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 1051
;1051:	RegisterItem(BG_FindItemForWeapon(WP_ROCKET_LAUNCHER));
CNSTI4 5
ARGI4
ADDRLP4 24
ADDRGP4 BG_FindItemForWeapon
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 1052
;1052:	RegisterItem(BG_FindItemForWeapon(WP_LIGHTNING));
CNSTI4 6
ARGI4
ADDRLP4 28
ADDRGP4 BG_FindItemForWeapon
CALLP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 1053
;1053:	RegisterItem(BG_FindItemForWeapon(WP_RAILGUN));
CNSTI4 7
ARGI4
ADDRLP4 32
ADDRGP4 BG_FindItemForWeapon
CALLP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 1054
;1054:	RegisterItem(BG_FindItemForWeapon(WP_PLASMAGUN));
CNSTI4 8
ARGI4
ADDRLP4 36
ADDRGP4 BG_FindItemForWeapon
CALLP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 1055
;1055:	RegisterItem(BG_FindItemForWeapon(WP_BFG));
CNSTI4 9
ARGI4
ADDRLP4 40
ADDRGP4 BG_FindItemForWeapon
CALLP4
ASGNP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 1059
;1056:#if GRAPPLE_ROPE
;1057:	if (
;1058:#if ESCAPE_MODE
;1059:		g_gametype.integer != GT_EFH &&
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
EQI4 $419
ADDRGP4 g_grapple+12
INDIRI4
CNSTI4 0
LEI4 $419
ADDRGP4 g_grapple+12
INDIRI4
CNSTI4 5
GEI4 $419
line 1063
;1060:#endif
;1061:		g_grapple.integer > HM_disabled &&
;1062:		g_grapple.integer < HM_num_modes
;1063:	) {
line 1064
;1064:		RegisterItem(BG_FindItemForWeapon(WP_GRAPPLING_HOOK));
CNSTI4 10
ARGI4
ADDRLP4 44
ADDRGP4 BG_FindItemForWeapon
CALLP4
ASGNP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 1065
;1065:	}
LABELV $419
line 1067
;1066:#endif
;1067:	if (g_respawnAtPOD.integer && g_gametype.integer == GT_CTF) {
ADDRGP4 g_respawnAtPOD+12
INDIRI4
CNSTI4 0
EQI4 $424
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $424
line 1068
;1068:		RegisterItem(BG_FindItem("POD marker"));
ADDRGP4 $428
ARGP4
ADDRLP4 44
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 1069
;1069:	}
LABELV $424
line 1072
;1070:#endif
;1071:#if MONSTER_MODE	// JUHOX: register artefact item
;1072:	if (g_gametype.integer == GT_STU) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
NEI4 $429
line 1073
;1073:		RegisterItem(BG_FindItem("Artefact"));
ADDRGP4 $272
ARGP4
ADDRLP4 44
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 1074
;1074:	}
ADDRGP4 $430
JUMPV
LABELV $429
line 1075
;1075:	else if (g_gametype.integer < GT_STU && g_monsterLauncher.integer) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
GEI4 $432
ADDRGP4 g_monsterLauncher+12
INDIRI4
CNSTI4 0
EQI4 $432
line 1076
;1076:		RegisterItem(BG_FindItemForWeapon(WP_MONSTER_LAUNCHER));
CNSTI4 11
ARGI4
ADDRLP4 44
ADDRGP4 BG_FindItemForWeapon
CALLP4
ASGNP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 1077
;1077:	}
LABELV $432
LABELV $430
line 1085
;1078:#endif
;1079:#ifdef MISSIONPACK
;1080:	if( g_gametype.integer == GT_HARVESTER ) {
;1081:		RegisterItem( BG_FindItem( "Red Cube" ) );
;1082:		RegisterItem( BG_FindItem( "Blue Cube" ) );
;1083:	}
;1084:#endif
;1085:}
LABELV $409
endproc ClearRegisteredItems 48 12
export RegisterItem
proc RegisterItem 0 4
line 1094
;1086:
;1087:/*
;1088:===============
;1089:RegisterItem
;1090:
;1091:The item will be added to the precache list
;1092:===============
;1093:*/
;1094:void RegisterItem( gitem_t *item ) {
line 1095
;1095:	if ( !item ) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $437
line 1096
;1096:		G_Error( "RegisterItem: NULL" );
ADDRGP4 $439
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 1097
;1097:	}
LABELV $437
line 1098
;1098:	itemRegistered[ item - bg_itemlist ] = qtrue;
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
CNSTI4 2
LSHI4
ADDRGP4 itemRegistered
ADDP4
CNSTI4 1
ASGNI4
line 1099
;1099:}
LABELV $436
endproc RegisterItem 0 4
export SaveRegisteredItems
proc SaveRegisteredItems 268 8
line 1110
;1100:
;1101:
;1102:/*
;1103:===============
;1104:SaveRegisteredItems
;1105:
;1106:Write the needed items to a config string
;1107:so the client will know which ones to precache
;1108:===============
;1109:*/
;1110:void SaveRegisteredItems( void ) {
line 1115
;1111:	char	string[MAX_ITEMS+1];
;1112:	int		i;
;1113:	int		count;
;1114:
;1115:	count = 0;
ADDRLP4 264
CNSTI4 0
ASGNI4
line 1116
;1116:	for ( i = 0 ; i < bg_numItems ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $444
JUMPV
LABELV $441
line 1117
;1117:		if ( itemRegistered[i] ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 itemRegistered
ADDP4
INDIRI4
CNSTI4 0
EQI4 $445
line 1118
;1118:			count++;
ADDRLP4 264
ADDRLP4 264
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1119
;1119:			string[i] = '1';
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
CNSTI1 49
ASGNI1
line 1120
;1120:		} else {
ADDRGP4 $446
JUMPV
LABELV $445
line 1121
;1121:			string[i] = '0';
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
CNSTI1 48
ASGNI1
line 1122
;1122:		}
LABELV $446
line 1123
;1123:	}
LABELV $442
line 1116
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $444
ADDRLP4 0
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $441
line 1124
;1124:	string[ bg_numItems ] = 0;
ADDRGP4 bg_numItems
INDIRI4
ADDRLP4 4
ADDP4
CNSTI1 0
ASGNI1
line 1126
;1125:
;1126:	G_Printf( "%i items registered\n", count );
ADDRGP4 $447
ARGP4
ADDRLP4 264
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 1127
;1127:	trap_SetConfigstring(CS_ITEMS, string);
CNSTI4 27
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1128
;1128:}
LABELV $440
endproc SaveRegisteredItems 268 8
export G_ItemDisabled
proc G_ItemDisabled 132 16
line 1135
;1129:
;1130:/*
;1131:============
;1132:G_ItemDisabled
;1133:============
;1134:*/
;1135:int G_ItemDisabled( gitem_t *item ) {
line 1139
;1136:
;1137:	char name[128];
;1138:
;1139:	Com_sprintf(name, sizeof(name), "disable_%s", item->classname);
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $449
ARGP4
ADDRFP4 0
INDIRP4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1140
;1140:	return trap_Cvar_VariableIntegerValue( name );
ADDRLP4 0
ARGP4
ADDRLP4 128
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRLP4 128
INDIRI4
RETI4
LABELV $448
endproc G_ItemDisabled 132 16
export G_SpawnItem
proc G_SpawnItem 8 12
line 1153
;1141:}
;1142:
;1143:/*
;1144:============
;1145:G_SpawnItem
;1146:
;1147:Sets the clipping size and plants the object on the floor.
;1148:
;1149:Items can't be immediately dropped to floor, because they might
;1150:be on an entity that hasn't spawned yet.
;1151:============
;1152:*/
;1153:void G_SpawnItem (gentity_t *ent, gitem_t *item) {
line 1154
;1154:	G_SpawnFloat( "random", "0", &ent->random );
ADDRGP4 $451
ARGP4
ADDRGP4 $452
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 1155
;1155:	G_SpawnFloat( "wait", "0", &ent->wait );
ADDRGP4 $453
ARGP4
ADDRGP4 $452
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 800
ADDP4
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 1157
;1156:
;1157:	RegisterItem( item );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 1158
;1158:	if ( G_ItemDisabled(item) )
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 G_ItemDisabled
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $454
line 1159
;1159:		return;
ADDRGP4 $450
JUMPV
LABELV $454
line 1161
;1160:
;1161:	ent->item = item;
ADDRFP4 0
INDIRP4
CNSTI4 808
ADDP4
ADDRFP4 4
INDIRP4
ASGNP4
line 1164
;1162:	// some movers spawn on the second frame, so delay item
;1163:	// spawns until the third frame so they can ride trains
;1164:	ent->nextthink = level.time + FRAMETIME * 2;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 200
ADDI4
ASGNI4
line 1165
;1165:	ent->think = FinishSpawningItem;
ADDRFP4 0
INDIRP4
CNSTI4 696
ADDP4
ADDRGP4 FinishSpawningItem
ASGNP4
line 1167
;1166:
;1167:	ent->physicsBounce = 0.50;		// items are bouncy
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
CNSTF4 1056964608
ASGNF4
line 1169
;1168:
;1169:	if ( item->giType == IT_POWERUP ) {
ADDRFP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 5
NEI4 $457
line 1170
;1170:		G_SoundIndex( "sound/items/poweruprespawn.wav" );
ADDRGP4 $215
ARGP4
ADDRGP4 G_SoundIndex
CALLI4
pop
line 1171
;1171:		G_SpawnFloat( "noglobalsound", "0", &ent->speed);
ADDRGP4 $459
ARGP4
ADDRGP4 $452
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 676
ADDP4
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 1172
;1172:	}
LABELV $457
line 1182
;1173:
;1174:#ifdef MISSIONPACK
;1175:	if ( item->giType == IT_PERSISTANT_POWERUP ) {
;1176:		ent->s.generic1 = ent->spawnflags;
;1177:	}
;1178:#endif
;1179:
;1180:	// JUHOX: finish item spawning for EFH
;1181:#if ESCAPE_MODE
;1182:	if (g_gametype.integer == GT_EFH) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
NEI4 $460
line 1183
;1183:		FinishSpawningItem(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 FinishSpawningItem
CALLV
pop
line 1184
;1184:		G_SetOrigin(ent, ent->s.origin);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 1185
;1185:	}
LABELV $460
line 1186
;1186:	ent->entClass = GEC_item;
ADDRFP4 0
INDIRP4
CNSTI4 824
ADDP4
CNSTI4 1
ASGNI4
line 1188
;1187:#endif
;1188:}
LABELV $450
endproc G_SpawnItem 8 12
proc G_PODMarkerRotation 16 12
line 1198
;1189:
;1190:
;1191:/*
;1192:================
;1193:JUHOX: G_PODMarkerRotation
;1194:================
;1195:*/
;1196:#define PODMARKER_MINSPIN 180.0
;1197:#define PODMARKER_MAXSPIN 4000.0
;1198:static void G_PODMarkerRotation(gentity_t* ent) {
line 1201
;1199:	vec3_t angles;
;1200:
;1201:	BG_EvaluateTrajectory(&ent->s.apos, level.time, angles);
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRGP4 level+32
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 1202
;1202:	VectorCopy(angles, ent->s.apos.trBase);
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
ADDRLP4 0
INDIRB
ASGNB 12
line 1203
;1203:	ent->s.apos.trTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1205
;1204:
;1205:	if (level.time >= ent->s.time) {
ADDRGP4 level+32
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
LTI4 $466
line 1206
;1206:		ent->s.apos.trDelta[YAW] = PODMARKER_MAXSPIN;
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
CNSTF4 1165623296
ASGNF4
line 1207
;1207:	}
ADDRGP4 $467
JUMPV
LABELV $466
line 1208
;1208:	else if (level.time < ent->s.time - 10000) {
ADDRGP4 level+32
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 10000
SUBI4
GEI4 $469
line 1209
;1209:		ent->s.apos.trDelta[YAW] = PODMARKER_MINSPIN;
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
CNSTF4 1127481344
ASGNF4
line 1210
;1210:	}
ADDRGP4 $470
JUMPV
LABELV $469
line 1211
;1211:	else {
line 1212
;1212:		ent->s.apos.trDelta[YAW] =
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 76
ADDP4
CNSTF4 1165623296
ADDRLP4 12
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
SUBI4
CVIF4 4
CNSTF4 1053005185
MULF4
SUBF4
ASGNF4
line 1215
;1213:			PODMARKER_MAXSPIN -
;1214:			(PODMARKER_MAXSPIN - PODMARKER_MINSPIN) * (ent->s.time - level.time) / 10000.0;
;1215:	}
LABELV $470
LABELV $467
line 1216
;1216:}
LABELV $463
endproc G_PODMarkerRotation 16 12
export G_BounceItemRotation
proc G_BounceItemRotation 44 12
line 1223
;1217:
;1218:/*
;1219:================
;1220:JUHOX: G_BounceItemRotation
;1221:================
;1222:*/
;1223:void G_BounceItemRotation(gentity_t* ent) {
line 1227
;1224:	float maxSpeed;
;1225:	vec3_t angles;
;1226:
;1227:	BG_EvaluateTrajectory(&ent->s.apos, level.time, angles);
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRGP4 level+32
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 1228
;1228:	VectorCopy(angles, ent->s.apos.trBase);
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
ADDRLP4 4
INDIRB
ASGNB 12
line 1229
;1229:	ent->s.apos.trTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1231
;1230:
;1231:	maxSpeed = VectorLength(ent->s.pos.trDelta) * 20;
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ARGP4
ADDRLP4 16
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 16
INDIRF4
CNSTF4 1101004800
MULF4
ASGNF4
line 1233
;1232:
;1233:	ent->s.apos.trDelta[0] = maxSpeed * crandom() * random();
ADDRLP4 20
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 24
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ADDRLP4 0
INDIRF4
ADDRLP4 20
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 20
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
ADDRLP4 24
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 24
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
MULF4
ASGNF4
line 1234
;1234:	ent->s.apos.trDelta[1] = maxSpeed * crandom() * random();
ADDRLP4 28
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 32
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
ADDRLP4 0
INDIRF4
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
CNSTF4 796917760
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
MULF4
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
MULF4
ASGNF4
line 1235
;1235:	ent->s.apos.trDelta[2] = maxSpeed * crandom() * random();
ADDRLP4 36
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 40
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRFP4 0
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 0
INDIRF4
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
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
MULF4
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
MULF4
ASGNF4
line 1237
;1236:
;1237:	ent->s.apos.trType = TR_LINEAR;
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 2
ASGNI4
line 1238
;1238:	ent->s.apos.trDuration = 0;
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
CNSTI4 0
ASGNI4
line 1239
;1239:}
LABELV $473
endproc G_BounceItemRotation 44 12
export G_BounceItem
proc G_BounceItem 72 12
line 1247
;1240:
;1241:/*
;1242:================
;1243:G_BounceItem
;1244:
;1245:================
;1246:*/
;1247:void G_BounceItem( gentity_t *ent, trace_t *trace ) {
line 1254
;1248:	vec3_t	velocity;
;1249:	float	dot;
;1250:	int		hitTime;
;1251:	qboolean armorFragment;	// JUHOX
;1252:	float sqrspeed;	// JUHOX
;1253:
;1254:	armorFragment = (ent->item && ent->item->giType == IT_ARMOR && ent->item->giTag);	// JUHOX
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $478
ADDRLP4 32
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 3
NEI4 $478
ADDRLP4 32
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 0
EQI4 $478
ADDRLP4 28
CNSTI4 1
ASGNI4
ADDRGP4 $479
JUMPV
LABELV $478
ADDRLP4 28
CNSTI4 0
ASGNI4
LABELV $479
ADDRLP4 20
ADDRLP4 28
INDIRI4
ASGNI4
line 1257
;1255:
;1256:	// reflect the velocity on the trace plane
;1257:	hitTime = level.previousTime + ( level.time - level.previousTime ) * trace->fraction;
ADDRLP4 24
ADDRGP4 level+36
INDIRI4
CVIF4 4
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+36
INDIRI4
SUBI4
CVIF4 4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 1258
;1258:	BG_EvaluateTrajectoryDelta( &ent->s.pos, hitTime, velocity );
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BG_EvaluateTrajectoryDelta
CALLV
pop
line 1259
;1259:	dot = DotProduct( velocity, trace->plane.normal );
ADDRLP4 36
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 0
INDIRF4
ADDRLP4 36
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
MULF4
ADDRLP4 0+4
INDIRF4
ADDRLP4 36
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+8
INDIRF4
ADDRLP4 36
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1260
;1260:	VectorMA( velocity, -2*dot, trace->plane.normal, ent->s.pos.trDelta );
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 0
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
CNSTF4 3221225472
MULF4
MULF4
ADDF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 0+4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
CNSTF4 3221225472
MULF4
MULF4
ADDF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 0+8
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
CNSTF4 3221225472
MULF4
MULF4
ADDF4
ASGNF4
line 1263
;1261:
;1262:	// cut the velocity to keep from bouncing forever
;1263:	VectorScale( ent->s.pos.trDelta, ent->physicsBounce, ent->s.pos.trDelta );
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 40
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 572
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 44
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 572
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 48
INDIRP4
CNSTI4 44
ADDP4
INDIRF4
ADDRLP4 48
INDIRP4
CNSTI4 572
ADDP4
INDIRF4
MULF4
ASGNF4
line 1265
;1264:
;1265:	sqrspeed = VectorLengthSquared(ent->s.pos.trDelta);	// JUHOX
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ARGP4
ADDRLP4 52
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 52
INDIRF4
ASGNF4
line 1269
;1266:
;1267:	// JUHOX: bouncing armor fragment
;1268:#if 1
;1269:	if (armorFragment) {
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $487
line 1270
;1270:		G_BounceItemRotation(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_BounceItemRotation
CALLV
pop
line 1271
;1271:		if (sqrspeed >= 160*160) {
ADDRLP4 16
INDIRF4
CNSTF4 1187512320
LTF4 $489
line 1272
;1272:			G_AddEvent(ent, EV_BOUNCE_ARMOR, 0);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 87
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 1273
;1273:		}
ADDRGP4 $490
JUMPV
LABELV $489
line 1274
;1274:		else if (sqrspeed >= 80*80) {
ADDRLP4 16
INDIRF4
CNSTF4 1170735104
LTF4 $491
line 1275
;1275:			G_AddEvent(ent, EV_BOUNCE_ARMOR, 1);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 87
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 1276
;1276:		}
ADDRGP4 $492
JUMPV
LABELV $491
line 1277
;1277:		else if (sqrspeed >= 40*40) {
ADDRLP4 16
INDIRF4
CNSTF4 1153957888
LTF4 $493
line 1278
;1278:			G_AddEvent(ent, EV_BOUNCE_ARMOR, 2);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 87
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 1279
;1279:		}
LABELV $493
LABELV $492
LABELV $490
line 1280
;1280:	}
LABELV $487
line 1288
;1281:#endif
;1282:
;1283:	// check for stop
;1284:	// JUHOX BUGFIX: check like in G_BounceMissile() (the VectorLength() call is the important thing, I think)
;1285:#if 0
;1286:	if ( trace->plane.normal[2] > 0 && ent->s.pos.trDelta[2] < 40 ) {
;1287:#else
;1288:	if (trace->plane.normal[2] > 0.2 && sqrspeed < 40*40) {
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
CNSTF4 1045220557
LEF4 $495
ADDRLP4 16
INDIRF4
CNSTF4 1153957888
GEF4 $495
line 1292
;1289:#endif
;1290:		// JUHOX: stop armor fragment rotation
;1291:#if 1
;1292:		if (armorFragment) {
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $497
line 1296
;1293:			vec3_t angles;
;1294:			//float pitch;
;1295:
;1296:			ent->s.apos.trType = TR_STATIONARY;
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 1306
;1297:			/*
;1298:			VectorClear(ent->s.apos.trDelta);
;1299:			ent->s.apos.trTime = 0;
;1300:			ent->s.apos.trDuration = 0;
;1301:			pitch = AngleMod(ent->s.apos.trBase[PITCH]);
;1302:			ent->s.apos.trBase[PITCH] = pitch < 180? 90 : -90;
;1303:			ent->s.apos.trBase[ROLL] = 0;
;1304:			*/
;1305:			// JUHOX: the following depends on code in CG_Item() [cg_ents.c]
;1306:			BG_EvaluateTrajectory(&ent->s.apos, level.time, angles);
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRGP4 level+32
INDIRI4
ARGI4
ADDRLP4 56
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 1307
;1307:			ent->s.apos.trDelta[YAW] = angles[YAW];
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
ADDRLP4 56+4
INDIRF4
ASGNF4
line 1308
;1308:			VectorCopy(trace->plane.normal, ent->s.apos.trBase);
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 1309
;1309:		}
LABELV $497
line 1311
;1310:#endif
;1311:		trace->endpos[2] += 1.0;	// make sure it is off ground
ADDRLP4 56
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 1312
;1312:		SnapVector( trace->endpos );
ADDRLP4 60
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 64
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 64
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 68
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 68
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 1313
;1313:		G_SetOrigin( ent, trace->endpos );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 1314
;1314:		ent->s.groundEntityNum = trace->entityNum;
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
ASGNI4
line 1315
;1315:		return;
ADDRGP4 $476
JUMPV
LABELV $495
line 1318
;1316:	}
;1317:
;1318:	VectorAdd( ent->r.currentOrigin, trace->plane.normal, ent->r.currentOrigin);
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 56
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 492
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 496
ADDP4
ADDRLP4 64
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDF4
ASGNF4
line 1319
;1319:	VectorCopy( ent->r.currentOrigin, ent->s.pos.trBase );
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 68
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 1320
;1320:	ent->s.pos.trTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1321
;1321:}
LABELV $476
endproc G_BounceItem 72 12
data
align 4
LABELV $503
byte 4 3238002688
byte 4 3238002688
byte 4 3238002688
align 4
LABELV $504
byte 4 1090519040
byte 4 1090519040
byte 4 1090519040
export G_RunItem
code
proc G_RunItem 116 28
line 1331
;1322:
;1323:
;1324:/*
;1325:================
;1326:G_RunItem
;1327:
;1328:================
;1329:*/
;1330:// JUHOX NOTE: G_RunItem() is also called for corpses
;1331:void G_RunItem( gentity_t *ent ) {
line 1341
;1332:	vec3_t		origin;
;1333:	trace_t		tr;
;1334:	int			contents;
;1335:	int			mask;
;1336:	static vec3_t mins = {-8,-8,-8};	// JUHOX
;1337:	static vec3_t maxs = {8,8,8};		// JUHOX
;1338:
;1339:	// JUHOX: POD markers do not much
;1340:#if 1
;1341:	if (ent->item && ent->item->giType == IT_POD_MARKER) {
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $505
ADDRLP4 76
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 9
NEI4 $505
line 1342
;1342:		G_PODMarkerRotation(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_PODMarkerRotation
CALLV
pop
line 1343
;1343:		return;
ADDRGP4 $502
JUMPV
LABELV $505
line 1348
;1344:	}
;1345:#endif
;1346:
;1347:	// if groundentity has been set to -1, it may have been pushed off an edge
;1348:	if ( ent->s.groundEntityNum == -1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $507
line 1349
;1349:		if ( ent->s.pos.trType != TR_GRAVITY ) {
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 5
EQI4 $509
line 1350
;1350:			ent->s.pos.trType = TR_GRAVITY;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 5
ASGNI4
line 1351
;1351:			ent->s.pos.trTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1352
;1352:		}
LABELV $509
line 1353
;1353:	}
LABELV $507
line 1355
;1354:
;1355:	if ( ent->s.pos.trType == TR_STATIONARY ) {
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
NEI4 $512
line 1357
;1356:		// check think function
;1357:		G_RunThink( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_RunThink
CALLV
pop
line 1358
;1358:		return;
ADDRGP4 $502
JUMPV
LABELV $512
line 1362
;1359:	}
;1360:
;1361:	// get current position
;1362:	BG_EvaluateTrajectory( &ent->s.pos, level.time, origin );
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 level+32
INDIRI4
ARGI4
ADDRLP4 60
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 1365
;1363:
;1364:#if 1	// JUHOX: corpse sinking into ground
;1365:	if (ent->s.pos.trType == TR_LINEAR_STOP) {
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 3
NEI4 $515
line 1366
;1366:		if (level.time - ent->s.pos.trTime < 3000) {
ADDRGP4 level+32
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
SUBI4
CNSTI4 3000
GEI4 $517
line 1367
;1367:			VectorCopy(origin, ent->r.currentOrigin);
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 60
INDIRB
ASGNB 12
line 1368
;1368:			trap_LinkEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 1369
;1369:		}
ADDRGP4 $518
JUMPV
LABELV $517
line 1370
;1370:		else if (ent->r.contents) {
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
INDIRI4
CNSTI4 0
EQI4 $520
line 1371
;1371:			ent->r.contents = 0;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 0
ASGNI4
line 1372
;1372:			trap_LinkEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 1373
;1373:		}
LABELV $520
LABELV $518
line 1374
;1374:		G_RunThink(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_RunThink
CALLV
pop
line 1375
;1375:		return;
ADDRGP4 $502
JUMPV
LABELV $515
line 1380
;1376:	}
;1377:#endif
;1378:
;1379:	// trace a line from the previous position to the current position
;1380:	if ( ent->clipmask ) {
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
CNSTI4 0
EQI4 $522
line 1381
;1381:		mask = ent->clipmask;
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ASGNI4
line 1382
;1382:	} else {
ADDRGP4 $523
JUMPV
LABELV $522
line 1383
;1383:		mask = MASK_PLAYERSOLID & ~CONTENTS_BODY;//MASK_SOLID;
ADDRLP4 56
CNSTI4 65537
ASGNI4
line 1384
;1384:	}
LABELV $523
line 1390
;1385:	// JUHOX: use smaller mins & maxs for fragment movement
;1386:#if 0
;1387:	trap_Trace( &tr, ent->r.currentOrigin, ent->r.mins, ent->r.maxs, origin,
;1388:		ent->r.ownerNum, mask );
;1389:#else
;1390:	if (ent->item && ent->item->giType == IT_ARMOR && ent->item->giTag) {
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $524
ADDRLP4 80
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 3
NEI4 $524
ADDRLP4 80
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 0
EQI4 $524
line 1391
;1391:		trap_Trace(&tr, ent->r.currentOrigin, mins, maxs, origin, ent->r.ownerNum, mask);
ADDRLP4 0
ARGP4
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRGP4 $503
ARGP4
ADDRGP4 $504
ARGP4
ADDRLP4 60
ARGP4
ADDRLP4 84
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
INDIRI4
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1392
;1392:	}
ADDRGP4 $525
JUMPV
LABELV $524
line 1393
;1393:	else {
line 1394
;1394:		trap_Trace(&tr, ent->r.currentOrigin, ent->r.mins, ent->r.maxs, origin, ent->r.ownerNum, mask);
ADDRLP4 0
ARGP4
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 84
INDIRP4
CNSTI4 436
ADDP4
ARGP4
ADDRLP4 84
INDIRP4
CNSTI4 448
ADDP4
ARGP4
ADDRLP4 60
ARGP4
ADDRLP4 84
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
INDIRI4
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1395
;1395:	}
LABELV $525
line 1406
;1396:#endif
;1397:
;1398:	// JUHOX: do item movement like missile movement [G_RunMissile()]
;1399:#if 0
;1400:	VectorCopy( tr.endpos, ent->r.currentOrigin );
;1401:
;1402:	if ( tr.startsolid ) {
;1403:		tr.fraction = 0;
;1404:	}
;1405:#else
;1406:	if ( tr.startsolid || tr.allsolid ) {
ADDRLP4 0+4
INDIRI4
CNSTI4 0
NEI4 $529
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $526
LABELV $529
line 1409
;1407:		vec3_t normal;
;1408:
;1409:		VectorCopy(tr.plane.normal, normal);
ADDRLP4 84
ADDRLP4 0+24
INDIRB
ASGNB 12
line 1412
;1410:
;1411:		// make sure the tr.entityNum is set to the entity we're stuck in
;1412:		trap_Trace( &tr, ent->r.currentOrigin, ent->r.mins, ent->r.maxs, ent->r.currentOrigin,
ADDRLP4 0
ARGP4
ADDRLP4 96
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 96
INDIRP4
CNSTI4 436
ADDP4
ARGP4
ADDRLP4 96
INDIRP4
CNSTI4 448
ADDP4
ARGP4
ADDRLP4 96
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 96
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
INDIRI4
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1416
;1413:			ent->r.ownerNum, mask );
;1414:		//tr.fraction = 0;
;1415:
;1416:		tr.fraction = 1;
ADDRLP4 0+8
CNSTF4 1065353216
ASGNF4
line 1417
;1417:		tr.endpos[2] += 1.0;	// make sure it is off ground
ADDRLP4 0+12+8
ADDRLP4 0+12+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 1418
;1418:		SnapVector(tr.endpos);
ADDRLP4 0+12
ADDRLP4 0+12
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 0+12+4
ADDRLP4 0+12+4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 0+12+8
ADDRLP4 0+12+8
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 1419
;1419:		G_SetOrigin(ent, tr.endpos);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+12
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 1420
;1420:		ent->s.groundEntityNum = tr.entityNum;
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
ADDRLP4 0+52
INDIRI4
ASGNI4
line 1421
;1421:		if (ent->item && ent->item->giType == IT_ARMOR && ent->item->giTag) {
ADDRLP4 100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $527
ADDRLP4 100
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 3
NEI4 $527
ADDRLP4 100
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 0
EQI4 $527
line 1426
;1422:			vec3_t angles;
;1423:			//float pitch;
;1424:
;1425:			// stop armor fragment rotation
;1426:			ent->s.apos.trType = TR_STATIONARY;
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 1436
;1427:			/*
;1428:			VectorClear(ent->s.apos.trDelta);
;1429:			ent->s.apos.trTime = 0;
;1430:			ent->s.apos.trDuration = 0;
;1431:			pitch = AngleMod(ent->s.apos.trBase[PITCH]);
;1432:			ent->s.apos.trBase[PITCH] = pitch < 180? 90 : -90;
;1433:			ent->s.apos.trBase[ROLL] = 0;
;1434:			*/
;1435:			// JUHOX: the following depends on code in CG_Item() [cg_ents.c]
;1436:			BG_EvaluateTrajectory(&ent->s.apos, level.time, angles);
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRGP4 level+32
INDIRI4
ARGI4
ADDRLP4 104
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 1437
;1437:			ent->s.apos.trDelta[YAW] = angles[YAW];
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
ADDRLP4 104+4
INDIRF4
ASGNF4
line 1438
;1438:			VectorCopy(normal, ent->s.apos.trBase);
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
ADDRLP4 84
INDIRB
ASGNB 12
line 1439
;1439:		}
line 1440
;1440:	}
ADDRGP4 $527
JUMPV
LABELV $526
line 1441
;1441:	else {
line 1442
;1442:		VectorCopy(tr.endpos, ent->r.currentOrigin);
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 0+12
INDIRB
ASGNB 12
line 1443
;1443:	}
LABELV $527
line 1446
;1444:#endif
;1445:
;1446:	trap_LinkEntity( ent );	// FIXME: avoid this for stationary?
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 1449
;1447:
;1448:	// check think function
;1449:	G_RunThink( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_RunThink
CALLV
pop
line 1451
;1450:
;1451:	if ( tr.fraction == 1 ) {
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
NEF4 $551
line 1452
;1452:		return;
ADDRGP4 $502
JUMPV
LABELV $551
line 1456
;1453:	}
;1454:
;1455:	// if it is in a nodrop volume, remove it
;1456:	contents = trap_PointContents( ent->r.currentOrigin, -1 );
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 84
ADDRGP4 trap_PointContents
CALLI4
ASGNI4
ADDRLP4 72
ADDRLP4 84
INDIRI4
ASGNI4
line 1457
;1457:	if ( contents & CONTENTS_NODROP ) {
ADDRLP4 72
INDIRI4
CVIU4 4
CNSTU4 2147483648
BANDU4
CNSTU4 0
EQU4 $554
line 1458
;1458:		if (ent->item && ent->item->giType == IT_TEAM) {
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $556
ADDRLP4 88
INDIRP4
CNSTI4 808
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
NEI4 $556
line 1459
;1459:			Team_FreeEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Team_FreeEntity
CALLV
pop
line 1460
;1460:		} else {
ADDRGP4 $502
JUMPV
LABELV $556
line 1461
;1461:			G_FreeEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 1462
;1462:		}
line 1463
;1463:		return;
ADDRGP4 $502
JUMPV
LABELV $554
line 1466
;1464:	}
;1465:
;1466:	G_BounceItem( ent, &tr );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_BounceItem
CALLV
pop
line 1467
;1467:}
LABELV $502
endproc G_RunItem 116 28
bss
export itemRegistered
align 4
LABELV itemRegistered
skip 1024
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
import ArmorIndex
import Think_Weapon
import SetRespawn
import PrecacheItem
import UseHoldableItem
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
LABELV $459
byte 1 110
byte 1 111
byte 1 103
byte 1 108
byte 1 111
byte 1 98
byte 1 97
byte 1 108
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $453
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $452
byte 1 48
byte 1 0
align 1
LABELV $451
byte 1 114
byte 1 97
byte 1 110
byte 1 100
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $449
byte 1 100
byte 1 105
byte 1 115
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 95
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $447
byte 1 37
byte 1 105
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 32
byte 1 114
byte 1 101
byte 1 103
byte 1 105
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $439
byte 1 82
byte 1 101
byte 1 103
byte 1 105
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 58
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 0
align 1
LABELV $428
byte 1 80
byte 1 79
byte 1 68
byte 1 32
byte 1 109
byte 1 97
byte 1 114
byte 1 107
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $418
byte 1 65
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 32
byte 1 70
byte 1 114
byte 1 97
byte 1 103
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 53
byte 1 0
align 1
LABELV $414
byte 1 65
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 32
byte 1 83
byte 1 104
byte 1 97
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $413
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
LABELV $408
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
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $404
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $403
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
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $399
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $385
byte 1 70
byte 1 105
byte 1 110
byte 1 105
byte 1 115
byte 1 104
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 115
byte 1 111
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $326
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
byte 1 97
byte 1 32
byte 1 115
byte 1 117
byte 1 105
byte 1 116
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 32
byte 1 97
byte 1 114
byte 1 116
byte 1 101
byte 1 102
byte 1 97
byte 1 99
byte 1 116
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $272
byte 1 65
byte 1 114
byte 1 116
byte 1 101
byte 1 102
byte 1 97
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $229
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $220
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 107
byte 1 97
byte 1 109
byte 1 105
byte 1 107
byte 1 97
byte 1 122
byte 1 101
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $215
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $202
byte 1 82
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 58
byte 1 32
byte 1 98
byte 1 97
byte 1 100
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 109
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 0
