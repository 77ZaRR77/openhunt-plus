export CG_TestModel_f
code
proc CG_TestModel_f 36 12
file "..\..\..\..\code\cgame\cg_view.c"
line 51
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_view.c -- setup all the parameters (position, angle, etc)
;4:// for a 3D rendering
;5:#include "cg_local.h"
;6:
;7:
;8:/*
;9:=============================================================================
;10:
;11:  MODEL TESTING
;12:
;13:The viewthing and gun positioning tools from Q2 have been integrated and
;14:enhanced into a single model testing facility.
;15:
;16:Model viewing can begin with either "testmodel <modelname>" or "testgun <modelname>".
;17:
;18:The names must be the full pathname after the basedir, like 
;19:"models/weapons/v_launch/tris.md3" or "players/male/tris.md3"
;20:
;21:Testmodel will create a fake entity 100 units in front of the current view
;22:position, directly facing the viewer.  It will remain immobile, so you can
;23:move around it to view it from different angles.
;24:
;25:Testgun will cause the model to follow the player around and supress the real
;26:view weapon model.  The default frame 0 of most guns is completely off screen,
;27:so you will probably have to cycle a couple frames to see it.
;28:
;29:"nextframe", "prevframe", "nextskin", and "prevskin" commands will change the
;30:frame or skin of the testmodel.  These are bound to F5, F6, F7, and F8 in
;31:q3default.cfg.
;32:
;33:If a gun is being tested, the "gun_x", "gun_y", and "gun_z" variables will let
;34:you adjust the positioning.
;35:
;36:Note that none of the model testing features update while the game is paused, so
;37:it may be convenient to test with deathmatch set to 1 so that bringing down the
;38:console doesn't pause the game.
;39:
;40:=============================================================================
;41:*/
;42:
;43:/*
;44:=================
;45:CG_TestModel_f
;46:
;47:Creates an entity in front of the current position, which
;48:can then be moved around
;49:=================
;50:*/
;51:void CG_TestModel_f (void) {
line 54
;52:	vec3_t		angles;
;53:
;54:	memset( &cg.testModelEntity, 0, sizeof(cg.testModelEntity) );
ADDRGP4 cg+163464
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 55
;55:	if ( trap_Argc() < 2 ) {
ADDRLP4 12
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 2
GEI4 $127
line 56
;56:		return;
ADDRGP4 $124
JUMPV
LABELV $127
line 59
;57:	}
;58:
;59:	Q_strncpyz (cg.testModelName, CG_Argv( 1 ), MAX_QPATH );
CNSTI4 1
ARGI4
ADDRLP4 16
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRGP4 cg+163604
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 60
;60:	cg.testModelEntity.hModel = trap_R_RegisterModel( cg.testModelName );
ADDRGP4 cg+163604
ARGP4
ADDRLP4 20
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cg+163464+8
ADDRLP4 20
INDIRI4
ASGNI4
line 62
;61:
;62:	if ( trap_Argc() == 3 ) {
ADDRLP4 24
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 3
NEI4 $133
line 63
;63:		cg.testModelEntity.backlerp = atof( CG_Argv( 2 ) );
CNSTI4 2
ARGI4
ADDRLP4 28
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 atof
CALLF4
ASGNF4
ADDRGP4 cg+163464+100
ADDRLP4 32
INDIRF4
ASGNF4
line 64
;64:		cg.testModelEntity.frame = 1;
ADDRGP4 cg+163464+80
CNSTI4 1
ASGNI4
line 65
;65:		cg.testModelEntity.oldframe = 0;
ADDRGP4 cg+163464+96
CNSTI4 0
ASGNI4
line 66
;66:	}
LABELV $133
line 67
;67:	if (! cg.testModelEntity.hModel ) {
ADDRGP4 cg+163464+8
INDIRI4
CNSTI4 0
NEI4 $141
line 68
;68:		CG_Printf( "Can't register model\n" );
ADDRGP4 $145
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 69
;69:		return;
ADDRGP4 $124
JUMPV
LABELV $141
line 72
;70:	}
;71:
;72:	VectorMA( cg.refdef.vieworg, 100, cg.refdef.viewaxis[0], cg.testModelEntity.origin );
ADDRGP4 cg+163464+68
ADDRGP4 cg+109260+24
INDIRF4
ADDRGP4 cg+109260+36
INDIRF4
CNSTF4 1120403456
MULF4
ADDF4
ASGNF4
ADDRGP4 cg+163464+68+4
ADDRGP4 cg+109260+24+4
INDIRF4
ADDRGP4 cg+109260+36+4
INDIRF4
CNSTF4 1120403456
MULF4
ADDF4
ASGNF4
ADDRGP4 cg+163464+68+8
ADDRGP4 cg+109260+24+8
INDIRF4
ADDRGP4 cg+109260+36+8
INDIRF4
CNSTF4 1120403456
MULF4
ADDF4
ASGNF4
line 74
;73:
;74:	angles[PITCH] = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 75
;75:	angles[YAW] = 180 + cg.refdefViewAngles[1];
ADDRLP4 0+4
ADDRGP4 cg+109628+4
INDIRF4
CNSTF4 1127481344
ADDF4
ASGNF4
line 76
;76:	angles[ROLL] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 78
;77:
;78:	AnglesToAxis( angles, cg.testModelEntity.axis );
ADDRLP4 0
ARGP4
ADDRGP4 cg+163464+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 88
;79:
;80:	// -JUHOX DEBUG: enlarge testmodel
;81:#if 0
;82:	VectorScale(cg.testModelEntity.axis[0], 10, cg.testModelEntity.axis[0]);
;83:	VectorScale(cg.testModelEntity.axis[1], 10, cg.testModelEntity.axis[1]);
;84:	VectorScale(cg.testModelEntity.axis[2], 10, cg.testModelEntity.axis[2]);
;85:	cg.testModelEntity.nonNormalizedAxes = qtrue;
;86:#endif
;87:
;88:	cg.testGun = qfalse;
ADDRGP4 cg+163668
CNSTI4 0
ASGNI4
line 89
;89:}
LABELV $124
endproc CG_TestModel_f 36 12
export CG_TestGun_f
proc CG_TestGun_f 0 0
line 98
;90:
;91:/*
;92:=================
;93:CG_TestGun_f
;94:
;95:Replaces the current view weapon with the given model
;96:=================
;97:*/
;98:void CG_TestGun_f (void) {
line 99
;99:	CG_TestModel_f();
ADDRGP4 CG_TestModel_f
CALLV
pop
line 100
;100:	cg.testGun = qtrue;
ADDRGP4 cg+163668
CNSTI4 1
ASGNI4
line 101
;101:	cg.testModelEntity.renderfx = RF_MINLIGHT | RF_DEPTHHACK | RF_FIRST_PERSON;
ADDRGP4 cg+163464+4
CNSTI4 13
ASGNI4
line 102
;102:}
LABELV $177
endproc CG_TestGun_f 0 0
export CG_TestModelNextFrame_f
proc CG_TestModelNextFrame_f 4 8
line 105
;103:
;104:
;105:void CG_TestModelNextFrame_f (void) {
line 106
;106:	cg.testModelEntity.frame++;
ADDRLP4 0
ADDRGP4 cg+163464+80
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 107
;107:	CG_Printf( "frame %i\n", cg.testModelEntity.frame );
ADDRGP4 $184
ARGP4
ADDRGP4 cg+163464+80
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 108
;108:}
LABELV $181
endproc CG_TestModelNextFrame_f 4 8
export CG_TestModelPrevFrame_f
proc CG_TestModelPrevFrame_f 4 8
line 110
;109:
;110:void CG_TestModelPrevFrame_f (void) {
line 111
;111:	cg.testModelEntity.frame--;
ADDRLP4 0
ADDRGP4 cg+163464+80
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 112
;112:	if ( cg.testModelEntity.frame < 0 ) {
ADDRGP4 cg+163464+80
INDIRI4
CNSTI4 0
GEI4 $190
line 113
;113:		cg.testModelEntity.frame = 0;
ADDRGP4 cg+163464+80
CNSTI4 0
ASGNI4
line 114
;114:	}
LABELV $190
line 115
;115:	CG_Printf( "frame %i\n", cg.testModelEntity.frame );
ADDRGP4 $184
ARGP4
ADDRGP4 cg+163464+80
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 116
;116:}
LABELV $187
endproc CG_TestModelPrevFrame_f 4 8
export CG_TestModelNextSkin_f
proc CG_TestModelNextSkin_f 4 8
line 118
;117:
;118:void CG_TestModelNextSkin_f (void) {
line 119
;119:	cg.testModelEntity.skinNum++;
ADDRLP4 0
ADDRGP4 cg+163464+104
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 120
;120:	CG_Printf( "skin %i\n", cg.testModelEntity.skinNum );
ADDRGP4 $201
ARGP4
ADDRGP4 cg+163464+104
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 121
;121:}
LABELV $198
endproc CG_TestModelNextSkin_f 4 8
export CG_TestModelPrevSkin_f
proc CG_TestModelPrevSkin_f 4 8
line 123
;122:
;123:void CG_TestModelPrevSkin_f (void) {
line 124
;124:	cg.testModelEntity.skinNum--;
ADDRLP4 0
ADDRGP4 cg+163464+104
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 125
;125:	if ( cg.testModelEntity.skinNum < 0 ) {
ADDRGP4 cg+163464+104
INDIRI4
CNSTI4 0
GEI4 $207
line 126
;126:		cg.testModelEntity.skinNum = 0;
ADDRGP4 cg+163464+104
CNSTI4 0
ASGNI4
line 127
;127:	}
LABELV $207
line 128
;128:	CG_Printf( "skin %i\n", cg.testModelEntity.skinNum );
ADDRGP4 $201
ARGP4
ADDRGP4 cg+163464+104
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 129
;129:}
LABELV $204
endproc CG_TestModelPrevSkin_f 4 8
proc CG_AddTestModel 32 4
line 131
;130:
;131:static void CG_AddTestModel (void) {
line 135
;132:	int		i;
;133:
;134:	// re-register the model, because the level may have changed
;135:	cg.testModelEntity.hModel = trap_R_RegisterModel( cg.testModelName );
ADDRGP4 cg+163604
ARGP4
ADDRLP4 4
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cg+163464+8
ADDRLP4 4
INDIRI4
ASGNI4
line 136
;136:	if (! cg.testModelEntity.hModel ) {
ADDRGP4 cg+163464+8
INDIRI4
CNSTI4 0
NEI4 $219
line 137
;137:		CG_Printf ("Can't register model\n");
ADDRGP4 $145
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 138
;138:		return;
ADDRGP4 $215
JUMPV
LABELV $219
line 142
;139:	}
;140:
;141:	// if testing a gun, set the origin reletive to the view origin
;142:	if ( cg.testGun ) {
ADDRGP4 cg+163668
INDIRI4
CNSTI4 0
EQI4 $223
line 143
;143:		VectorCopy( cg.refdef.vieworg, cg.testModelEntity.origin );
ADDRGP4 cg+163464+68
ADDRGP4 cg+109260+24
INDIRB
ASGNB 12
line 144
;144:		VectorCopy( cg.refdef.viewaxis[0], cg.testModelEntity.axis[0] );
ADDRGP4 cg+163464+28
ADDRGP4 cg+109260+36
INDIRB
ASGNB 12
line 145
;145:		VectorCopy( cg.refdef.viewaxis[1], cg.testModelEntity.axis[1] );
ADDRGP4 cg+163464+28+12
ADDRGP4 cg+109260+36+12
INDIRB
ASGNB 12
line 146
;146:		VectorCopy( cg.refdef.viewaxis[2], cg.testModelEntity.axis[2] );
ADDRGP4 cg+163464+28+24
ADDRGP4 cg+109260+36+24
INDIRB
ASGNB 12
line 149
;147:
;148:		// allow the position to be adjusted
;149:		for (i=0 ; i<3 ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $246
line 150
;150:			cg.testModelEntity.origin[i] += cg.refdef.viewaxis[0][i] * cg_gun_x.value;
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+163464+68
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+109260+36
ADDP4
INDIRF4
ADDRGP4 cg_gun_x+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 151
;151:			cg.testModelEntity.origin[i] += cg.refdef.viewaxis[1][i] * cg_gun_y.value;
ADDRLP4 20
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+163464+68
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+109260+36+12
ADDP4
INDIRF4
ADDRGP4 cg_gun_y+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 152
;152:			cg.testModelEntity.origin[i] += cg.refdef.viewaxis[2][i] * cg_gun_z.value;
ADDRLP4 28
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+163464+68
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+109260+36+24
ADDP4
INDIRF4
ADDRGP4 cg_gun_z+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 153
;153:		}
LABELV $247
line 149
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $246
line 154
;154:	}
LABELV $223
line 156
;155:
;156:	trap_R_AddRefEntityToScene( &cg.testModelEntity );
ADDRGP4 cg+163464
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 157
;157:}
LABELV $215
endproc CG_AddTestModel 32 4
proc CG_CalcVrect 12 8
line 171
;158:
;159:
;160:
;161://============================================================================
;162:
;163:
;164:/*
;165:=================
;166:CG_CalcVrect
;167:
;168:Sets the coordinates of the rendered window
;169:=================
;170:*/
;171:static void CG_CalcVrect (void) {
line 175
;172:	int		size;
;173:
;174:	// the intermission should allways be full screen
;175:	if ( cg.snap->ps.pm_type == PM_INTERMISSION ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 5
NEI4 $269
line 176
;176:		size = 100;
ADDRLP4 0
CNSTI4 100
ASGNI4
line 177
;177:	} else {
ADDRGP4 $270
JUMPV
LABELV $269
line 179
;178:		// bound normal viewsize
;179:		if (cg_viewsize.integer < 30) {
ADDRGP4 cg_viewsize+12
INDIRI4
CNSTI4 30
GEI4 $272
line 180
;180:			trap_Cvar_Set ("cg_viewsize","30");
ADDRGP4 $275
ARGP4
ADDRGP4 $276
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 181
;181:			size = 30;
ADDRLP4 0
CNSTI4 30
ASGNI4
line 182
;182:		} else if (cg_viewsize.integer > 100) {
ADDRGP4 $273
JUMPV
LABELV $272
ADDRGP4 cg_viewsize+12
INDIRI4
CNSTI4 100
LEI4 $277
line 183
;183:			trap_Cvar_Set ("cg_viewsize","100");
ADDRGP4 $275
ARGP4
ADDRGP4 $280
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 184
;184:			size = 100;
ADDRLP4 0
CNSTI4 100
ASGNI4
line 185
;185:		} else {
ADDRGP4 $278
JUMPV
LABELV $277
line 186
;186:			size = cg_viewsize.integer;
ADDRLP4 0
ADDRGP4 cg_viewsize+12
INDIRI4
ASGNI4
line 187
;187:		}
LABELV $278
LABELV $273
line 189
;188:
;189:	}
LABELV $270
line 190
;190:	cg.refdef.width = cgs.glconfig.vidWidth*size/100;
ADDRGP4 cg+109260+8
ADDRGP4 cgs+20100+11304
INDIRI4
ADDRLP4 0
INDIRI4
MULI4
CNSTI4 100
DIVI4
ASGNI4
line 191
;191:	cg.refdef.width &= ~1;
ADDRLP4 4
ADDRGP4 cg+109260+8
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 193
;192:
;193:	cg.refdef.height = cgs.glconfig.vidHeight*size/100;
ADDRGP4 cg+109260+12
ADDRGP4 cgs+20100+11308
INDIRI4
ADDRLP4 0
INDIRI4
MULI4
CNSTI4 100
DIVI4
ASGNI4
line 194
;194:	cg.refdef.height &= ~1;
ADDRLP4 8
ADDRGP4 cg+109260+12
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 196
;195:
;196:	cg.refdef.x = (cgs.glconfig.vidWidth - cg.refdef.width)/2;
ADDRGP4 cg+109260
ADDRGP4 cgs+20100+11304
INDIRI4
ADDRGP4 cg+109260+8
INDIRI4
SUBI4
CNSTI4 2
DIVI4
ASGNI4
line 197
;197:	cg.refdef.y = (cgs.glconfig.vidHeight - cg.refdef.height)/2;
ADDRGP4 cg+109260+4
ADDRGP4 cgs+20100+11308
INDIRI4
ADDRGP4 cg+109260+12
INDIRI4
SUBI4
CNSTI4 2
DIVI4
ASGNI4
line 198
;198:}
LABELV $268
endproc CG_CalcVrect 12 8
data
align 4
LABELV $306
byte 4 3229614080
byte 4 3229614080
byte 4 3229614080
align 4
LABELV $307
byte 4 1082130432
byte 4 1082130432
byte 4 1082130432
code
proc CG_OffsetThirdPersonView 180 28
line 210
;199:
;200://==============================================================================
;201:
;202:
;203:/*
;204:===============
;205:CG_OffsetThirdPersonView
;206:
;207:===============
;208:*/
;209:#define	FOCUS_DISTANCE	512
;210:static void CG_OffsetThirdPersonView( void ) {
line 221
;211:	vec3_t		forward, right, up;
;212:	vec3_t		view;
;213:	vec3_t		focusAngles;
;214:	trace_t		trace;
;215:	static vec3_t	mins = { -4, -4, -4 };
;216:	static vec3_t	maxs = { 4, 4, 4 };
;217:	vec3_t		focusPoint;
;218:	float		focusDist;
;219:	float		forwardScale, sideScale;
;220:
;221:	cg.refdef.vieworg[2] += cg.predictedPlayerState.viewheight;
ADDRLP4 140
ADDRGP4 cg+109260+24+8
ASGNP4
ADDRLP4 140
INDIRP4
ADDRLP4 140
INDIRP4
INDIRF4
ADDRGP4 cg+107688+164
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 223
;222:
;223:	VectorCopy( cg.refdefViewAngles, focusAngles );
ADDRLP4 56
ADDRGP4 cg+109628
INDIRB
ASGNB 12
line 234
;224:
;225:	// JUHOX: STAT_DEAD_YAW no longer needed
;226:#if 0
;227:	// if dead, look at killer
;228:	if ( cg.predictedPlayerState.stats[STAT_HEALTH] <= 0 ) {
;229:		focusAngles[YAW] = cg.predictedPlayerState.stats[STAT_DEAD_YAW];
;230:		cg.refdefViewAngles[YAW] = cg.predictedPlayerState.stats[STAT_DEAD_YAW];
;231:	}
;232:#endif
;233:
;234:	if ( focusAngles[PITCH] > 45 ) {
ADDRLP4 56
INDIRF4
CNSTF4 1110704128
LEF4 $314
line 235
;235:		focusAngles[PITCH] = 45;		// don't go too far overhead
ADDRLP4 56
CNSTF4 1110704128
ASGNF4
line 236
;236:	}
LABELV $314
line 237
;237:	AngleVectors( focusAngles, forward, NULL, NULL );
ADDRLP4 56
ARGP4
ADDRLP4 24
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 239
;238:
;239:	VectorMA( cg.refdef.vieworg, FOCUS_DISTANCE, forward, focusPoint );
ADDRLP4 12
ADDRGP4 cg+109260+24
INDIRF4
ADDRLP4 24
INDIRF4
CNSTF4 1140850688
MULF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRGP4 cg+109260+24+4
INDIRF4
ADDRLP4 24+4
INDIRF4
CNSTF4 1140850688
MULF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRGP4 cg+109260+24+8
INDIRF4
ADDRLP4 24+8
INDIRF4
CNSTF4 1140850688
MULF4
ADDF4
ASGNF4
line 241
;240:
;241:	VectorCopy( cg.refdef.vieworg, view );
ADDRLP4 0
ADDRGP4 cg+109260+24
INDIRB
ASGNB 12
line 243
;242:
;243:	view[2] += 8;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 245
;244:
;245:	cg.refdefViewAngles[PITCH] *= 0.5;
ADDRLP4 144
ADDRGP4 cg+109628
ASGNP4
ADDRLP4 144
INDIRP4
ADDRLP4 144
INDIRP4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 247
;246:
;247:	AngleVectors( cg.refdefViewAngles, forward, right, up );
ADDRGP4 cg+109628
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 128
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 249
;248:
;249:	forwardScale = cos( cg_thirdPersonAngle.value / 180 * M_PI );
ADDRGP4 cg_thirdPersonAngle+8
INDIRF4
CNSTF4 1016003125
MULF4
ARGF4
ADDRLP4 148
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 48
ADDRLP4 148
INDIRF4
ASGNF4
line 250
;250:	sideScale = sin( cg_thirdPersonAngle.value / 180 * M_PI );
ADDRGP4 cg_thirdPersonAngle+8
INDIRF4
CNSTF4 1016003125
MULF4
ARGF4
ADDRLP4 152
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 52
ADDRLP4 152
INDIRF4
ASGNF4
line 251
;251:	VectorMA( view, -cg_thirdPersonRange.value * forwardScale, forward, view );
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 24
INDIRF4
ADDRGP4 cg_thirdPersonRange+8
INDIRF4
NEGF4
ADDRLP4 48
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 24+4
INDIRF4
ADDRGP4 cg_thirdPersonRange+8
INDIRF4
NEGF4
ADDRLP4 48
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 24+8
INDIRF4
ADDRGP4 cg_thirdPersonRange+8
INDIRF4
NEGF4
ADDRLP4 48
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 252
;252:	VectorMA( view, -cg_thirdPersonRange.value * sideScale, right, view );
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 36
INDIRF4
ADDRGP4 cg_thirdPersonRange+8
INDIRF4
NEGF4
ADDRLP4 52
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 36+4
INDIRF4
ADDRGP4 cg_thirdPersonRange+8
INDIRF4
NEGF4
ADDRLP4 52
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 36+8
INDIRF4
ADDRGP4 cg_thirdPersonRange+8
INDIRF4
NEGF4
ADDRLP4 52
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 258
;253:
;254:
;255:	// trace a ray from the origin to the viewpoint to make sure the view isn't
;256:	// in a solid block.  Use an 8 by 8 block to prevent the view from near clipping anything
;257:
;258:	if (!cg_cameraMode.integer) {
ADDRGP4 cg_cameraMode+12
INDIRI4
CNSTI4 0
NEI4 $353
line 259
;259:		CG_Trace( &trace, cg.refdef.vieworg, mins, maxs, view, cg.predictedPlayerState.clientNum, MASK_SOLID );
ADDRLP4 72
ARGP4
ADDRGP4 cg+109260+24
ARGP4
ADDRGP4 $306
ARGP4
ADDRGP4 $307
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 cg+107688+140
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 261
;260:
;261:		if ( trace.fraction != 1.0 ) {
ADDRLP4 72+8
INDIRF4
CNSTF4 1065353216
EQF4 $360
line 262
;262:			VectorCopy( trace.endpos, view );
ADDRLP4 0
ADDRLP4 72+12
INDIRB
ASGNB 12
line 263
;263:			view[2] += (1.0 - trace.fraction) * 32;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
ADDRLP4 72+8
INDIRF4
SUBF4
CNSTF4 1107296256
MULF4
ADDF4
ASGNF4
line 267
;264:			// try another trace to this position, because a tunnel may have the ceiling
;265:			// close enogh that this is poking out
;266:
;267:			CG_Trace( &trace, cg.refdef.vieworg, mins, maxs, view, cg.predictedPlayerState.clientNum, MASK_SOLID );
ADDRLP4 72
ARGP4
ADDRGP4 cg+109260+24
ARGP4
ADDRGP4 $306
ARGP4
ADDRGP4 $307
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 cg+107688+140
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 268
;268:			VectorCopy( trace.endpos, view );
ADDRLP4 0
ADDRLP4 72+12
INDIRB
ASGNB 12
line 269
;269:		}
LABELV $360
line 270
;270:	}
LABELV $353
line 273
;271:
;272:
;273:	VectorCopy( view, cg.refdef.vieworg );
ADDRGP4 cg+109260+24
ADDRLP4 0
INDIRB
ASGNB 12
line 276
;274:
;275:	// select pitch to look at focus point from vieword
;276:	VectorSubtract( focusPoint, cg.refdef.vieworg, focusPoint );
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRGP4 cg+109260+24
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
ADDRGP4 cg+109260+24+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
ADDRGP4 cg+109260+24+8
INDIRF4
SUBF4
ASGNF4
line 277
;277:	focusDist = sqrt( focusPoint[0] * focusPoint[0] + focusPoint[1] * focusPoint[1] );
ADDRLP4 164
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 164
INDIRF4
ADDRLP4 164
INDIRF4
MULF4
ADDRLP4 12+4
INDIRF4
ADDRLP4 12+4
INDIRF4
MULF4
ADDF4
ARGF4
ADDRLP4 168
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 68
ADDRLP4 168
INDIRF4
ASGNF4
line 278
;278:	if ( focusDist < 1 ) {
ADDRLP4 68
INDIRF4
CNSTF4 1065353216
GEF4 $387
line 279
;279:		focusDist = 1;	// should never happen
ADDRLP4 68
CNSTF4 1065353216
ASGNF4
line 280
;280:	}
LABELV $387
line 281
;281:	cg.refdefViewAngles[PITCH] = -180 / M_PI * atan2( focusPoint[2], focusDist );
ADDRLP4 12+8
INDIRF4
ARGF4
ADDRLP4 68
INDIRF4
ARGF4
ADDRLP4 172
ADDRGP4 atan2
CALLF4
ASGNF4
ADDRGP4 cg+109628
ADDRLP4 172
INDIRF4
CNSTF4 3261411041
MULF4
ASGNF4
line 282
;282:	cg.refdefViewAngles[YAW] -= cg_thirdPersonAngle.value;
ADDRLP4 176
ADDRGP4 cg+109628+4
ASGNP4
ADDRLP4 176
INDIRP4
ADDRLP4 176
INDIRP4
INDIRF4
ADDRGP4 cg_thirdPersonAngle+8
INDIRF4
SUBF4
ASGNF4
line 283
;283:}
LABELV $305
endproc CG_OffsetThirdPersonView 180 28
proc CG_StepOffset 8 0
line 287
;284:
;285:
;286:// this causes a compiler bug on mac MrC compiler
;287:static void CG_StepOffset( void ) {
line 291
;288:	int		timeDelta;
;289:	
;290:	// smooth out stair climbing
;291:	timeDelta = cg.time - cg.stepTime;
ADDRLP4 0
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cg+109128
INDIRI4
SUBI4
ASGNI4
line 292
;292:	if ( timeDelta < STEP_TIME ) {
ADDRLP4 0
INDIRI4
CNSTI4 200
GEI4 $397
line 293
;293:		cg.refdef.vieworg[2] -= cg.stepChange 
ADDRLP4 4
ADDRGP4 cg+109260+24+8
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRGP4 cg+109124
INDIRF4
CNSTI4 200
ADDRLP4 0
INDIRI4
SUBI4
CVIF4 4
MULF4
CNSTF4 1000593162
MULF4
SUBF4
ASGNF4
line 295
;294:			* (STEP_TIME - timeDelta) / STEP_TIME;
;295:	}
LABELV $397
line 296
;296:}
LABELV $394
endproc CG_StepOffset 8 0
proc CG_OffsetFirstPersonView 96 0
line 304
;297:
;298:/*
;299:===============
;300:CG_OffsetFirstPersonView
;301:
;302:===============
;303:*/
;304:static void CG_OffsetFirstPersonView( void ) {
line 315
;305:	float			*origin;
;306:	float			*angles;
;307:	float			bob;
;308:	float			ratio;
;309:	float			delta;
;310:	float			speed;
;311:	float			f;
;312:	vec3_t			predictedVelocity;
;313:	int				timeDelta;
;314:	
;315:	if ( cg.snap->ps.pm_type == PM_INTERMISSION ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 5
NEI4 $404
line 316
;316:		return;
ADDRGP4 $403
JUMPV
LABELV $404
line 321
;317:	}
;318:
;319:	// JUHOX: no view offsets for dead spectators
;320:#if 1
;321:	if (/*cg.snap->ps.stats[STAT_HEALTH] <= 0 &&*/ cg.snap->ps.pm_type == PM_SPECTATOR) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 2
NEI4 $407
line 322
;322:		return;
ADDRGP4 $403
JUMPV
LABELV $407
line 326
;323:	}
;324:#endif
;325:
;326:	origin = cg.refdef.vieworg;
ADDRLP4 8
ADDRGP4 cg+109260+24
ASGNP4
line 327
;327:	angles = cg.refdefViewAngles;
ADDRLP4 4
ADDRGP4 cg+109628
ASGNP4
line 330
;328:
;329:	// if dead, fix the angle and don't add any kick
;330:	if ( cg.snap->ps.stats[STAT_HEALTH] <= 0 ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
GTI4 $413
line 331
;331:		angles[ROLL] = 40;
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 1109393408
ASGNF4
line 332
;332:		angles[PITCH] = -15;
ADDRLP4 4
INDIRP4
CNSTF4 3245342720
ASGNF4
line 337
;333:		// JUHOX: STAT_DEAD_YAW no longer needed
;334:#if 0
;335:		angles[YAW] = cg.snap->ps.stats[STAT_DEAD_YAW];
;336:#endif
;337:		origin[2] += cg.predictedPlayerState.viewheight;
ADDRLP4 44
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRF4
ADDRGP4 cg+107688+164
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 338
;338:		return;
ADDRGP4 $403
JUMPV
LABELV $413
line 342
;339:	}
;340:
;341:	// add angles based on weapon kick
;342:	VectorAdd (angles, cg.kick_angles, angles);
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRGP4 cg+128056
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 cg+128056+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 cg+128056+8
INDIRF4
ADDF4
ASGNF4
line 345
;343:
;344:	// add angles based on damage kick
;345:	if ( cg.damageTime ) {
ADDRGP4 cg+128000
INDIRF4
CNSTF4 0
EQF4 $423
line 346
;346:		ratio = cg.time - cg.damageTime;
ADDRLP4 32
ADDRGP4 cg+107656
INDIRI4
CVIF4 4
ADDRGP4 cg+128000
INDIRF4
SUBF4
ASGNF4
line 347
;347:		if ( ratio < DAMAGE_DEFLECT_TIME ) {
ADDRLP4 32
INDIRF4
CNSTF4 1120403456
GEF4 $428
line 348
;348:			ratio /= DAMAGE_DEFLECT_TIME;
ADDRLP4 32
ADDRLP4 32
INDIRF4
CNSTF4 1008981770
MULF4
ASGNF4
line 349
;349:			angles[PITCH] += ratio * cg.v_dmg_pitch;
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 32
INDIRF4
ADDRGP4 cg+128048
INDIRF4
MULF4
ADDF4
ASGNF4
line 350
;350:			angles[ROLL] += ratio * cg.v_dmg_roll;
ADDRLP4 60
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
ADDRLP4 32
INDIRF4
ADDRGP4 cg+128052
INDIRF4
MULF4
ADDF4
ASGNF4
line 351
;351:		} else {
ADDRGP4 $429
JUMPV
LABELV $428
line 352
;352:			ratio = 1.0 - ( ratio - DAMAGE_DEFLECT_TIME ) / DAMAGE_RETURN_TIME;
ADDRLP4 32
CNSTF4 1065353216
ADDRLP4 32
INDIRF4
CNSTF4 1120403456
SUBF4
CNSTF4 992204554
MULF4
SUBF4
ASGNF4
line 353
;353:			if ( ratio > 0 ) {
ADDRLP4 32
INDIRF4
CNSTF4 0
LEF4 $432
line 354
;354:				angles[PITCH] += ratio * cg.v_dmg_pitch;
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 32
INDIRF4
ADDRGP4 cg+128048
INDIRF4
MULF4
ADDF4
ASGNF4
line 355
;355:				angles[ROLL] += ratio * cg.v_dmg_roll;
ADDRLP4 60
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
ADDRLP4 32
INDIRF4
ADDRGP4 cg+128052
INDIRF4
MULF4
ADDF4
ASGNF4
line 356
;356:			}
LABELV $432
line 357
;357:		}
LABELV $429
line 358
;358:	}
LABELV $423
line 369
;359:
;360:	// add pitch based on fall kick
;361:#if 0
;362:	ratio = ( cg.time - cg.landTime) / FALL_TIME;
;363:	if (ratio < 0)
;364:		ratio = 0;
;365:	angles[PITCH] += ratio * cg.fall_value;
;366:#endif
;367:
;368:	// add angles based on velocity
;369:	VectorCopy( cg.predictedPlayerState.velocity, predictedVelocity );
ADDRLP4 12
ADDRGP4 cg+107688+32
INDIRB
ASGNB 12
line 371
;370:
;371:	delta = DotProduct ( predictedVelocity, cg.refdef.viewaxis[0]);
ADDRLP4 0
ADDRLP4 12
INDIRF4
ADDRGP4 cg+109260+36
INDIRF4
MULF4
ADDRLP4 12+4
INDIRF4
ADDRGP4 cg+109260+36+4
INDIRF4
MULF4
ADDF4
ADDRLP4 12+8
INDIRF4
ADDRGP4 cg+109260+36+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 372
;372:	angles[PITCH] += delta * cg_runpitch.value;
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDRGP4 cg_runpitch+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 374
;373:	
;374:	delta = DotProduct ( predictedVelocity, cg.refdef.viewaxis[1]);
ADDRLP4 0
ADDRLP4 12
INDIRF4
ADDRGP4 cg+109260+36+12
INDIRF4
MULF4
ADDRLP4 12+4
INDIRF4
ADDRGP4 cg+109260+36+12+4
INDIRF4
MULF4
ADDF4
ADDRLP4 12+8
INDIRF4
ADDRGP4 cg+109260+36+12+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 375
;375:	angles[ROLL] -= delta * cg_runroll.value;
ADDRLP4 60
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDRGP4 cg_runroll+8
INDIRF4
MULF4
SUBF4
ASGNF4
line 380
;376:
;377:	// add angles based on bob
;378:
;379:	// make sure the bob is visible even at low speeds
;380:	speed = cg.xyspeed > 200 ? cg.xyspeed : 200;
ADDRGP4 cg+128088
INDIRF4
CNSTF4 1128792064
LEF4 $466
ADDRLP4 64
ADDRGP4 cg+128088
INDIRF4
ASGNF4
ADDRGP4 $467
JUMPV
LABELV $466
ADDRLP4 64
CNSTF4 1128792064
ASGNF4
LABELV $467
ADDRLP4 28
ADDRLP4 64
INDIRF4
ASGNF4
line 382
;381:
;382:	delta = cg.bobfracsin * cg_bobpitch.value * speed;
ADDRLP4 0
ADDRGP4 cg+128080
INDIRF4
ADDRGP4 cg_bobpitch+8
INDIRF4
MULF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 383
;383:	if (cg.predictedPlayerState.pm_flags & PMF_DUCKED)
ADDRGP4 cg+107688+12
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $470
line 384
;384:		delta *= 3;		// crouching
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1077936128
MULF4
ASGNF4
LABELV $470
line 385
;385:	angles[PITCH] += delta;
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
line 386
;386:	delta = cg.bobfracsin * cg_bobroll.value * speed;
ADDRLP4 0
ADDRGP4 cg+128080
INDIRF4
ADDRGP4 cg_bobroll+8
INDIRF4
MULF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 387
;387:	if (cg.predictedPlayerState.pm_flags & PMF_DUCKED)
ADDRGP4 cg+107688+12
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $476
line 388
;388:		delta *= 3;		// crouching accentuates roll
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1077936128
MULF4
ASGNF4
LABELV $476
line 389
;389:	if (cg.bobcycle & 1)
ADDRGP4 cg+128084
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $480
line 390
;390:		delta = -delta;
ADDRLP4 0
ADDRLP4 0
INDIRF4
NEGF4
ASGNF4
LABELV $480
line 391
;391:	angles[ROLL] += delta;
ADDRLP4 72
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
line 396
;392:
;393://===================================
;394:
;395:	// add view height
;396:	origin[2] += cg.predictedPlayerState.viewheight;
ADDRLP4 76
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRF4
ADDRGP4 cg+107688+164
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 407
;397:
;398:	// smooth out duck height changes
;399:	// JUHOX: don't smooth out duck height changes for spectators
;400:#if 0
;401:	timeDelta = cg.time - cg.duckTime;
;402:	if ( timeDelta < DUCK_TIME) {
;403:		cg.refdef.vieworg[2] -= cg.duckChange 
;404:			* (DUCK_TIME - timeDelta) / DUCK_TIME;
;405:	}
;406:#else
;407:	if (cg.snap->ps.persistant[PERS_TEAM] != TEAM_SPECTATOR) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
EQI4 $485
line 408
;408:		timeDelta = cg.time - cg.duckTime;
ADDRLP4 40
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cg+109136
INDIRI4
SUBI4
ASGNI4
line 409
;409:		if ( timeDelta < DUCK_TIME) {
ADDRLP4 40
INDIRI4
CNSTI4 100
GEI4 $490
line 410
;410:			cg.refdef.vieworg[2] -= cg.duckChange 
ADDRLP4 80
ADDRGP4 cg+109260+24+8
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRF4
ADDRGP4 cg+109132
INDIRF4
CNSTI4 100
ADDRLP4 40
INDIRI4
SUBI4
CVIF4 4
MULF4
CNSTF4 1008981770
MULF4
SUBF4
ASGNF4
line 412
;411:				* (DUCK_TIME - timeDelta) / DUCK_TIME;
;412:		}
LABELV $490
line 413
;413:	}
LABELV $485
line 417
;414:#endif
;415:
;416:	// add bob height
;417:	bob = cg.bobfracsin * cg.xyspeed * cg_bobup.value;
ADDRLP4 24
ADDRGP4 cg+128080
INDIRF4
ADDRGP4 cg+128088
INDIRF4
MULF4
ADDRGP4 cg_bobup+8
INDIRF4
MULF4
ASGNF4
line 418
;418:	if (bob > 6) {
ADDRLP4 24
INDIRF4
CNSTF4 1086324736
LEF4 $499
line 419
;419:		bob = 6;
ADDRLP4 24
CNSTF4 1086324736
ASGNF4
line 420
;420:	}
LABELV $499
line 422
;421:
;422:	origin[2] += bob;
ADDRLP4 80
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRF4
ADDRLP4 24
INDIRF4
ADDF4
ASGNF4
line 426
;423:
;424:
;425:	// add fall height
;426:	delta = cg.time - cg.landTime;
ADDRLP4 0
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cg+109144
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 427
;427:	if ( delta < LAND_DEFLECT_TIME ) {
ADDRLP4 0
INDIRF4
CNSTF4 1125515264
GEF4 $503
line 428
;428:		f = delta / LAND_DEFLECT_TIME;
ADDRLP4 36
ADDRLP4 0
INDIRF4
CNSTF4 1004172302
MULF4
ASGNF4
line 429
;429:		cg.refdef.vieworg[2] += cg.landChange * f;
ADDRLP4 84
ADDRGP4 cg+109260+24+8
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRF4
ADDRGP4 cg+109140
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
ADDF4
ASGNF4
line 430
;430:	} else if ( delta < LAND_DEFLECT_TIME + LAND_RETURN_TIME ) {
ADDRGP4 $504
JUMPV
LABELV $503
ADDRLP4 0
INDIRF4
CNSTF4 1138819072
GEF4 $509
line 431
;431:		delta -= LAND_DEFLECT_TIME;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1125515264
SUBF4
ASGNF4
line 432
;432:		f = 1.0 - ( delta / LAND_RETURN_TIME );
ADDRLP4 36
CNSTF4 1065353216
ADDRLP4 0
INDIRF4
CNSTF4 995783694
MULF4
SUBF4
ASGNF4
line 433
;433:		cg.refdef.vieworg[2] += cg.landChange * f;
ADDRLP4 84
ADDRGP4 cg+109260+24+8
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRF4
ADDRGP4 cg+109140
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
ADDF4
ASGNF4
line 434
;434:	}
LABELV $509
LABELV $504
line 437
;435:
;436:	// add step offset
;437:	CG_StepOffset();
ADDRGP4 CG_StepOffset
CALLV
pop
line 441
;438:
;439:	// add kick offset
;440:
;441:	VectorAdd (origin, cg.kick_origin, origin);
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
ADDRGP4 cg+128068
INDIRF4
ADDF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 cg+128068+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 cg+128068+8
INDIRF4
ADDF4
ASGNF4
line 455
;442:
;443:	// pivot the eye based on a neck length
;444:#if 0
;445:	{
;446:#define	NECK_LENGTH		8
;447:	vec3_t			forward, up;
;448: 
;449:	cg.refdef.vieworg[2] -= NECK_LENGTH;
;450:	AngleVectors( cg.refdefViewAngles, forward, NULL, up );
;451:	VectorMA( cg.refdef.vieworg, 3, forward, cg.refdef.vieworg );
;452:	VectorMA( cg.refdef.vieworg, NECK_LENGTH, up, cg.refdef.vieworg );
;453:	}
;454:#endif
;455:}
LABELV $403
endproc CG_OffsetFirstPersonView 96 0
export CG_ZoomDown_f
proc CG_ZoomDown_f 0 0
line 459
;456:
;457://======================================================================
;458:
;459:void CG_ZoomDown_f( void ) { 
line 460
;460:	if ( cg.zoomed ) {
ADDRGP4 cg+112472
INDIRI4
CNSTI4 0
EQI4 $521
line 461
;461:		return;
ADDRGP4 $520
JUMPV
LABELV $521
line 463
;462:	}
;463:	cg.zoomed = qtrue;
ADDRGP4 cg+112472
CNSTI4 1
ASGNI4
line 464
;464:	cg.zoomTime = cg.time;
ADDRGP4 cg+112476
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 465
;465:}
LABELV $520
endproc CG_ZoomDown_f 0 0
export CG_ZoomUp_f
proc CG_ZoomUp_f 0 0
line 467
;466:
;467:void CG_ZoomUp_f( void ) { 
line 468
;468:	if ( !cg.zoomed ) {
ADDRGP4 cg+112472
INDIRI4
CNSTI4 0
NEI4 $528
line 469
;469:		return;
ADDRGP4 $527
JUMPV
LABELV $528
line 471
;470:	}
;471:	cg.zoomed = qfalse;
ADDRGP4 cg+112472
CNSTI4 0
ASGNI4
line 472
;472:	cg.zoomTime = cg.time;
ADDRGP4 cg+112476
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 473
;473:}
LABELV $527
endproc CG_ZoomUp_f 0 0
proc CG_CalcFov 52 8
line 486
;474:
;475:
;476:/*
;477:====================
;478:CG_CalcFov
;479:
;480:Fixed fov at intermissions, otherwise account for fov variable and zooms.
;481:====================
;482:*/
;483:#define	WAVE_AMPLITUDE	1
;484:#define	WAVE_FREQUENCY	0.4
;485:
;486:static int CG_CalcFov( void ) {
line 496
;487:	float	x;
;488:	float	phase;
;489:	float	v;
;490:	int		contents;
;491:	float	fov_x, fov_y;
;492:	float	zoomFov;
;493:	float	f;
;494:	int		inwater;
;495:
;496:	if ( cg.predictedPlayerState.pm_type == PM_INTERMISSION ) {
ADDRGP4 cg+107688+4
INDIRI4
CNSTI4 5
NEI4 $535
line 498
;497:		// if in intermission, use a fixed value
;498:		fov_x = 90;
ADDRLP4 0
CNSTF4 1119092736
ASGNF4
line 499
;499:	} else {
ADDRGP4 $536
JUMPV
LABELV $535
line 505
;500:		// user selectable
;501:		// JUHOX: reverse the meaning of DF_FIXED_FOV
;502:#if 0
;503:		if ( cgs.dmflags & DF_FIXED_FOV ) {
;504:#else
;505:		if (!(cgs.dmflags & DF_FIXED_FOV)) {
ADDRGP4 cgs+31460
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $539
line 508
;506:#endif
;507:			// dmflag to prevent wide fov for all clients
;508:			fov_x = 90;
ADDRLP4 0
CNSTF4 1119092736
ASGNF4
line 509
;509:		} else {
ADDRGP4 $540
JUMPV
LABELV $539
line 510
;510:			fov_x = cg_fov.value;
ADDRLP4 0
ADDRGP4 cg_fov+8
INDIRF4
ASGNF4
line 511
;511:			if ( fov_x < 1 ) {
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
GEF4 $543
line 512
;512:				fov_x = 1;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 513
;513:			} else if ( fov_x > 160 ) {
ADDRGP4 $544
JUMPV
LABELV $543
ADDRLP4 0
INDIRF4
CNSTF4 1126170624
LEF4 $545
line 514
;514:				fov_x = 160;
ADDRLP4 0
CNSTF4 1126170624
ASGNF4
line 515
;515:			}
LABELV $545
LABELV $544
line 516
;516:		}
LABELV $540
line 519
;517:
;518:		// account for zooms
;519:		zoomFov = cg_zoomFov.value;
ADDRLP4 8
ADDRGP4 cg_zoomFov+8
INDIRF4
ASGNF4
line 520
;520:		if ( zoomFov < 1 ) {
ADDRLP4 8
INDIRF4
CNSTF4 1065353216
GEF4 $548
line 521
;521:			zoomFov = 1;
ADDRLP4 8
CNSTF4 1065353216
ASGNF4
line 522
;522:		} else if ( zoomFov > 160 ) {
ADDRGP4 $549
JUMPV
LABELV $548
ADDRLP4 8
INDIRF4
CNSTF4 1126170624
LEF4 $550
line 523
;523:			zoomFov = 160;
ADDRLP4 8
CNSTF4 1126170624
ASGNF4
line 524
;524:		}
LABELV $550
LABELV $549
line 526
;525:
;526:		if ( cg.zoomed ) {
ADDRGP4 cg+112472
INDIRI4
CNSTI4 0
EQI4 $552
line 527
;527:			f = ( cg.time - cg.zoomTime ) / (float)ZOOM_TIME;
ADDRLP4 28
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cg+112476
INDIRI4
SUBI4
CVIF4 4
CNSTF4 1004172302
MULF4
ASGNF4
line 528
;528:			if ( f > 1.0 ) {
ADDRLP4 28
INDIRF4
CNSTF4 1065353216
LEF4 $557
line 529
;529:				fov_x = zoomFov;
ADDRLP4 0
ADDRLP4 8
INDIRF4
ASGNF4
line 530
;530:			} else {
ADDRGP4 $553
JUMPV
LABELV $557
line 531
;531:				fov_x = fov_x + f * ( zoomFov - fov_x );
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 28
INDIRF4
ADDRLP4 8
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 532
;532:			}
line 533
;533:		} else {
ADDRGP4 $553
JUMPV
LABELV $552
line 534
;534:			f = ( cg.time - cg.zoomTime ) / (float)ZOOM_TIME;
ADDRLP4 28
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cg+112476
INDIRI4
SUBI4
CVIF4 4
CNSTF4 1004172302
MULF4
ASGNF4
line 535
;535:			if ( f > 1.0 ) {
ADDRLP4 28
INDIRF4
CNSTF4 1065353216
LEF4 $561
line 536
;536:				fov_x = fov_x;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ASGNF4
line 537
;537:			} else {
ADDRGP4 $562
JUMPV
LABELV $561
line 538
;538:				fov_x = zoomFov + f * ( fov_x - zoomFov );
ADDRLP4 36
ADDRLP4 8
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 36
INDIRF4
ADDRLP4 28
INDIRF4
ADDRLP4 0
INDIRF4
ADDRLP4 36
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 539
;539:			}
LABELV $562
line 540
;540:		}
LABELV $553
line 543
;541:		// JUHOX: gauntlet provides wider fov
;542:#if 1
;543:		if (cg.predictedPlayerState.weapon == WP_GAUNTLET) {
ADDRGP4 cg+107688+144
INDIRI4
CNSTI4 1
NEI4 $563
line 546
;544:			float wideFov;
;545:
;546:			wideFov = fov_x * 1.3;
ADDRLP4 36
ADDRLP4 0
INDIRF4
CNSTF4 1067869798
MULF4
ASGNF4
line 548
;547:
;548:			switch (cg.predictedPlayerState.weaponstate) {
ADDRLP4 40
ADDRGP4 cg+107688+148
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 1
EQI4 $578
ADDRLP4 40
INDIRI4
CNSTI4 2
EQI4 $571
ADDRGP4 $567
JUMPV
LABELV $571
line 550
;549:			case WEAPON_DROPPING:
;550:				f = cg.predictedPlayerState.weaponTime / 200.0;
ADDRLP4 28
ADDRGP4 cg+107688+44
INDIRI4
CVIF4 4
CNSTF4 1000593162
MULF4
ASGNF4
line 551
;551:				if (f < 0) f = 0;
ADDRLP4 28
INDIRF4
CNSTF4 0
GEF4 $574
ADDRLP4 28
CNSTF4 0
ASGNF4
LABELV $574
line 552
;552:				if (f > 1) f = 1;
ADDRLP4 28
INDIRF4
CNSTF4 1065353216
LEF4 $576
ADDRLP4 28
CNSTF4 1065353216
ASGNF4
LABELV $576
line 553
;553:				fov_x += f * (wideFov - fov_x);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 28
INDIRF4
ADDRLP4 36
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 554
;554:				break;
ADDRGP4 $568
JUMPV
LABELV $578
line 556
;555:			case WEAPON_RAISING:
;556:				f = 1.0 - cg.predictedPlayerState.weaponTime / 250.0;
ADDRLP4 28
CNSTF4 1065353216
ADDRGP4 cg+107688+44
INDIRI4
CVIF4 4
CNSTF4 998445679
MULF4
SUBF4
ASGNF4
line 557
;557:				if (f < 0) f = 0;
ADDRLP4 28
INDIRF4
CNSTF4 0
GEF4 $581
ADDRLP4 28
CNSTF4 0
ASGNF4
LABELV $581
line 558
;558:				if (f > 1) f = 1;
ADDRLP4 28
INDIRF4
CNSTF4 1065353216
LEF4 $583
ADDRLP4 28
CNSTF4 1065353216
ASGNF4
LABELV $583
line 559
;559:				fov_x += f * (wideFov - fov_x);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 28
INDIRF4
ADDRLP4 36
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 560
;560:				break;
ADDRGP4 $568
JUMPV
LABELV $567
line 562
;561:			default:
;562:				fov_x = wideFov;
ADDRLP4 0
ADDRLP4 36
INDIRF4
ASGNF4
line 563
;563:				break;
LABELV $568
line 565
;564:			}
;565:		}
LABELV $563
line 567
;566:#endif
;567:	}
LABELV $536
line 569
;568:
;569:	x = cg.refdef.width / tan( fov_x / 360 * M_PI );
ADDRLP4 0
INDIRF4
CNSTF4 1007614517
MULF4
ARGF4
ADDRLP4 36
ADDRGP4 tan
CALLF4
ASGNF4
ADDRLP4 12
ADDRGP4 cg+109260+8
INDIRI4
CVIF4 4
ADDRLP4 36
INDIRF4
DIVF4
ASGNF4
line 570
;570:	fov_y = atan2( cg.refdef.height, x );
ADDRGP4 cg+109260+12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 40
ADDRGP4 atan2
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 40
INDIRF4
ASGNF4
line 571
;571:	fov_y = fov_y * 360 / M_PI;
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1122316001
MULF4
ASGNF4
line 574
;572:
;573:	// warp if underwater
;574:	contents = CG_PointContents( cg.refdef.vieworg, -1 );
ADDRGP4 cg+109260+24
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 44
ADDRGP4 CG_PointContents
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 44
INDIRI4
ASGNI4
line 575
;575:	if ( contents & ( CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA ) ){
ADDRLP4 16
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $591
line 576
;576:		phase = cg.time / 1000.0 * WAVE_FREQUENCY * M_PI * 2;
ADDRLP4 32
ADDRGP4 cg+107656
INDIRI4
CVIF4 4
CNSTF4 992261566
MULF4
ASGNF4
line 577
;577:		v = WAVE_AMPLITUDE * sin( phase );
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 48
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 24
ADDRLP4 48
INDIRF4
CNSTF4 1065353216
MULF4
ASGNF4
line 578
;578:		fov_x += v;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 24
INDIRF4
ADDF4
ASGNF4
line 579
;579:		fov_y -= v;
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 24
INDIRF4
SUBF4
ASGNF4
line 580
;580:		inwater = qtrue;
ADDRLP4 20
CNSTI4 1
ASGNI4
line 581
;581:	}
ADDRGP4 $592
JUMPV
LABELV $591
line 582
;582:	else {
line 583
;583:		inwater = qfalse;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 584
;584:	}
LABELV $592
line 588
;585:
;586:
;587:	// set it
;588:	cg.refdef.fov_x = fov_x;
ADDRGP4 cg+109260+16
ADDRLP4 0
INDIRF4
ASGNF4
line 589
;589:	cg.refdef.fov_y = fov_y;
ADDRGP4 cg+109260+20
ADDRLP4 4
INDIRF4
ASGNF4
line 591
;590:
;591:	if ( !cg.zoomed ) {
ADDRGP4 cg+112472
INDIRI4
CNSTI4 0
NEI4 $598
line 592
;592:		cg.zoomSensitivity = 1;
ADDRGP4 cg+112480
CNSTF4 1065353216
ASGNF4
line 593
;593:	} else {
ADDRGP4 $599
JUMPV
LABELV $598
line 594
;594:		cg.zoomSensitivity = cg.refdef.fov_y / 75.0;
ADDRGP4 cg+112480
ADDRGP4 cg+109260+20
INDIRF4
CNSTF4 1012560910
MULF4
ASGNF4
line 595
;595:	}
LABELV $599
line 597
;596:
;597:	return inwater;
ADDRLP4 20
INDIRI4
RETI4
LABELV $534
endproc CG_CalcFov 52 8
proc CG_DamageBlendBlob 164 12
line 608
;598:}
;599:
;600:
;601:
;602:/*
;603:===============
;604:CG_DamageBlendBlob
;605:
;606:===============
;607:*/
;608:static void CG_DamageBlendBlob( void ) {
line 613
;609:	int			t;
;610:	int			maxTime;
;611:	refEntity_t		ent;
;612:
;613:	if ( !cg.damageValue ) {
ADDRGP4 cg+128012
INDIRF4
CNSTF4 0
NEF4 $606
line 614
;614:		return;
ADDRGP4 $605
JUMPV
LABELV $606
line 622
;615:	}
;616:
;617:	//if (cg.cameraMode) {
;618:	//	return;
;619:	//}
;620:
;621:	// ragePro systems can't fade blends, so don't obscure the screen
;622:	if ( cgs.glconfig.hardwareType == GLHW_RAGEPRO ) {
ADDRGP4 cgs+20100+11288
INDIRI4
CNSTI4 3
NEI4 $609
line 623
;623:		return;
ADDRGP4 $605
JUMPV
LABELV $609
line 626
;624:	}
;625:
;626:	maxTime = DAMAGE_TIME;
ADDRLP4 144
CNSTI4 500
ASGNI4
line 627
;627:	t = cg.time - cg.damageTime;
ADDRLP4 140
ADDRGP4 cg+107656
INDIRI4
CVIF4 4
ADDRGP4 cg+128000
INDIRF4
SUBF4
CVFI4 4
ASGNI4
line 628
;628:	if ( t <= 0 || t >= maxTime ) {
ADDRLP4 140
INDIRI4
CNSTI4 0
LEI4 $617
ADDRLP4 140
INDIRI4
ADDRLP4 144
INDIRI4
LTI4 $615
LABELV $617
line 629
;629:		return;
ADDRGP4 $605
JUMPV
LABELV $615
line 633
;630:	}
;631:
;632:
;633:	memset( &ent, 0, sizeof( ent ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 634
;634:	ent.reType = RT_SPRITE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 635
;635:	ent.renderfx = RF_FIRST_PERSON;
ADDRLP4 0+4
CNSTI4 4
ASGNI4
line 637
;636:
;637:	VectorMA( cg.refdef.vieworg, 8, cg.refdef.viewaxis[0], ent.origin );
ADDRLP4 0+68
ADDRGP4 cg+109260+24
INDIRF4
ADDRGP4 cg+109260+36
INDIRF4
CNSTF4 1090519040
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+4
ADDRGP4 cg+109260+24+4
INDIRF4
ADDRGP4 cg+109260+36+4
INDIRF4
CNSTF4 1090519040
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+8
ADDRGP4 cg+109260+24+8
INDIRF4
ADDRGP4 cg+109260+36+8
INDIRF4
CNSTF4 1090519040
MULF4
ADDF4
ASGNF4
line 638
;638:	VectorMA( ent.origin, cg.damageX * -8, cg.refdef.viewaxis[1], ent.origin );
ADDRLP4 0+68
ADDRLP4 0+68
INDIRF4
ADDRGP4 cg+109260+36+12
INDIRF4
ADDRGP4 cg+128004
INDIRF4
CNSTF4 3238002688
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+4
ADDRLP4 0+68+4
INDIRF4
ADDRGP4 cg+109260+36+12+4
INDIRF4
ADDRGP4 cg+128004
INDIRF4
CNSTF4 3238002688
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+8
ADDRLP4 0+68+8
INDIRF4
ADDRGP4 cg+109260+36+12+8
INDIRF4
ADDRGP4 cg+128004
INDIRF4
CNSTF4 3238002688
MULF4
MULF4
ADDF4
ASGNF4
line 639
;639:	VectorMA( ent.origin, cg.damageY * 8, cg.refdef.viewaxis[2], ent.origin );
ADDRLP4 0+68
ADDRLP4 0+68
INDIRF4
ADDRGP4 cg+109260+36+24
INDIRF4
ADDRGP4 cg+128008
INDIRF4
CNSTF4 1090519040
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+4
ADDRLP4 0+68+4
INDIRF4
ADDRGP4 cg+109260+36+24+4
INDIRF4
ADDRGP4 cg+128008
INDIRF4
CNSTF4 1090519040
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+8
ADDRLP4 0+68+8
INDIRF4
ADDRGP4 cg+109260+36+24+8
INDIRF4
ADDRGP4 cg+128008
INDIRF4
CNSTF4 1090519040
MULF4
MULF4
ADDF4
ASGNF4
line 641
;640:
;641:	ent.radius = cg.damageValue * 3;
ADDRLP4 0+132
ADDRGP4 cg+128012
INDIRF4
CNSTF4 1077936128
MULF4
ASGNF4
line 642
;642:	ent.customShader = cgs.media.viewBloodShader;
ADDRLP4 0+112
ADDRGP4 cgs+751220+384
INDIRI4
ASGNI4
line 643
;643:	ent.shaderRGBA[0] = 255;
ADDRLP4 0+116
CNSTU1 255
ASGNU1
line 644
;644:	ent.shaderRGBA[1] = 255;
ADDRLP4 0+116+1
CNSTU1 255
ASGNU1
line 645
;645:	ent.shaderRGBA[2] = 255;
ADDRLP4 0+116+2
CNSTU1 255
ASGNU1
line 646
;646:	ent.shaderRGBA[3] = 200 * ( 1.0 - ((float)t / maxTime) );
ADDRLP4 156
CNSTF4 1065353216
ADDRLP4 140
INDIRI4
CVIF4 4
ADDRLP4 144
INDIRI4
CVIF4 4
DIVF4
SUBF4
CNSTF4 1128792064
MULF4
ASGNF4
ADDRLP4 160
CNSTF4 1325400064
ASGNF4
ADDRLP4 156
INDIRF4
ADDRLP4 160
INDIRF4
LTF4 $701
ADDRLP4 152
ADDRLP4 156
INDIRF4
ADDRLP4 160
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $702
JUMPV
LABELV $701
ADDRLP4 152
ADDRLP4 156
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $702
ADDRLP4 0+116+3
ADDRLP4 152
INDIRU4
CVUU1 4
ASGNU1
line 647
;647:	trap_R_AddRefEntityToScene( &ent );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 648
;648:}
LABELV $605
endproc CG_DamageBlendBlob 164 12
export CG_AddEarthquake
proc CG_AddEarthquake 20 8
line 660
;649:
;650:/*
;651:===============
;652:JUHOX: CG_AddEarthquake
;653:===============
;654:*/
;655:#if EARTHQUAKE_SYSTEM
;656:void CG_AddEarthquake(
;657:	const vec3_t origin, float radius,
;658:	float duration, float fadeIn, float fadeOut,	// in seconds
;659:	float amplitude
;660:) {
line 663
;661:	int i;
;662:
;663:	if (duration <= 0) {
ADDRFP4 8
INDIRF4
CNSTF4 0
GTF4 $704
line 666
;664:		float a;
;665:
;666:		a = amplitude / 100;
ADDRLP4 4
ADDRFP4 20
INDIRF4
CNSTF4 1008981770
MULF4
ASGNF4
line 668
;667:
;668:		if (radius > 0) {
ADDRFP4 4
INDIRF4
CNSTF4 0
LEF4 $706
line 671
;669:			float distance;
;670:			
;671:			distance = Distance(cg.refdef.vieworg, origin);
ADDRGP4 cg+109260+24
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 12
INDIRF4
ASGNF4
line 672
;672:			if (distance >= radius) return;
ADDRLP4 8
INDIRF4
ADDRFP4 4
INDIRF4
LTF4 $710
ADDRGP4 $703
JUMPV
LABELV $710
line 674
;673:
;674:			a *= 1 - (distance / radius);
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1065353216
ADDRLP4 8
INDIRF4
ADDRFP4 4
INDIRF4
DIVF4
SUBF4
MULF4
ASGNF4
line 675
;675:		}
LABELV $706
line 677
;676:
;677:		cg.additionalTremble += a;
ADDRLP4 8
ADDRGP4 cg+112448
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ASGNF4
line 678
;678:		return;
ADDRGP4 $703
JUMPV
LABELV $704
line 681
;679:	}
;680:
;681:	for (i = 0; i < MAX_EARTHQUAKES; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $713
line 684
;682:		earthquake_t* quake;
;683:
;684:		quake = &cg.earthquakes[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 36
MULI4
ADDRGP4 cg+110144
ADDP4
ASGNP4
line 685
;685:		if (quake->startTime) continue;
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 0
EQI4 $718
ADDRGP4 $714
JUMPV
LABELV $718
line 687
;686:
;687:		quake->startTime = cg.time;
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 688
;688:		quake->endTime = (int) floor(cg.time + 1000 * duration + 0.5);
ADDRGP4 cg+107656
INDIRI4
CVIF4 4
ADDRFP4 8
INDIRF4
CNSTF4 1148846080
MULF4
ADDF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRLP4 8
ADDRGP4 floor
CALLF4
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 8
INDIRF4
CVFI4 4
ASGNI4
line 689
;689:		quake->fadeInTime = (int) floor(1000 * fadeIn + 0.5);
ADDRFP4 12
INDIRF4
CNSTF4 1148846080
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRLP4 12
ADDRGP4 floor
CALLF4
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 12
INDIRF4
CVFI4 4
ASGNI4
line 690
;690:		quake->fadeOutTime = (int) floor(1000 * fadeOut + 0.5);
ADDRFP4 16
INDIRF4
CNSTF4 1148846080
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRLP4 16
ADDRGP4 floor
CALLF4
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 16
INDIRF4
CVFI4 4
ASGNI4
line 691
;691:		quake->amplitude = amplitude;
ADDRLP4 4
INDIRP4
CNSTI4 16
ADDP4
ADDRFP4 20
INDIRF4
ASGNF4
line 692
;692:		VectorCopy(origin, quake->origin);
ADDRLP4 4
INDIRP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 693
;693:		quake->radius = radius;
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 4
INDIRF4
ASGNF4
line 694
;694:		break;
ADDRGP4 $715
JUMPV
LABELV $714
line 681
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $713
LABELV $715
line 696
;695:	}
;696:}
LABELV $703
endproc CG_AddEarthquake 20 8
export CG_AdjustEarthquakes
proc CG_AdjustEarthquakes 20 0
line 705
;697:#endif
;698:
;699:/*
;700:===============
;701:JUHOX: CG_AdjustEarthquakes
;702:===============
;703:*/
;704:#if EARTHQUAKE_SYSTEM
;705:void CG_AdjustEarthquakes(const vec3_t delta) {
line 708
;706:	int i;
;707:
;708:	for (i = 0; i < MAX_EARTHQUAKES; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $723
line 711
;709:		earthquake_t* quake;
;710:
;711:		quake = &cg.earthquakes[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 36
MULI4
ADDRGP4 cg+110144
ADDP4
ASGNP4
line 712
;712:		if (!quake->startTime) continue;
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 0
NEI4 $728
ADDRGP4 $724
JUMPV
LABELV $728
line 713
;713:		if (quake->radius <= 0) continue;
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 0
GTF4 $730
ADDRGP4 $724
JUMPV
LABELV $730
line 715
;714:
;715:		VectorAdd(quake->origin, delta, quake->origin);
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRFP4 0
INDIRP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
ASGNF4
line 716
;716:	}
LABELV $724
line 708
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $723
line 717
;717:}
LABELV $722
endproc CG_AdjustEarthquakes 20 0
proc AddEarthquakeTremble 64 12
line 726
;718:#endif
;719:
;720:/*
;721:===============
;722:JUHOX: AddEarthquakeTremble
;723:===============
;724:*/
;725:#if EARTHQUAKE_SYSTEM
;726:static void AddEarthquakeTremble(earthquake_t* quake) {
line 729
;727:	int time;
;728:	float a;
;729:	const float offsetAmplitude = 0.2;
ADDRLP4 4
CNSTF4 1045220557
ASGNF4
line 730
;730:	const float angleAmplitude = 0.2;
ADDRLP4 8
CNSTF4 1045220557
ASGNF4
line 732
;731:
;732:	if (quake) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $733
line 733
;733:		if (cg.time >= quake->endTime) {
ADDRGP4 cg+107656
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
LTI4 $735
line 734
;734:			memset(quake, 0, sizeof(*quake));
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 36
ARGI4
ADDRGP4 memset
CALLP4
pop
line 735
;735:			return;
ADDRGP4 $732
JUMPV
LABELV $735
line 738
;736:		}
;737:
;738:		if (quake->radius > 0) {
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 0
LEF4 $738
line 741
;739:			float distance;
;740:			
;741:			distance = Distance(cg.refdef.vieworg, quake->origin);
ADDRGP4 cg+109260+24
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 20
INDIRF4
ASGNF4
line 742
;742:			if (distance >= quake->radius) return;
ADDRLP4 16
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
LTF4 $742
ADDRGP4 $732
JUMPV
LABELV $742
line 744
;743:
;744:			a = 1 - (distance / quake->radius);
ADDRLP4 0
CNSTF4 1065353216
ADDRLP4 16
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
DIVF4
SUBF4
ASGNF4
line 745
;745:		}
ADDRGP4 $739
JUMPV
LABELV $738
line 746
;746:		else {
line 747
;747:			a = 1;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 748
;748:		}
LABELV $739
line 750
;749:
;750:		time = cg.time - quake->startTime;
ADDRLP4 12
ADDRGP4 cg+107656
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
SUBI4
ASGNI4
line 751
;751:		a *= quake->amplitude / 100;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
CNSTF4 1008981770
MULF4
MULF4
ASGNF4
line 752
;752:		if (time < quake->fadeInTime) {
ADDRLP4 12
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
GEI4 $745
line 753
;753:			a *= (float)time / (float)(quake->fadeInTime);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 12
INDIRI4
CVIF4 4
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CVIF4 4
DIVF4
MULF4
ASGNF4
line 754
;754:		}
ADDRGP4 $734
JUMPV
LABELV $745
line 755
;755:		else if (cg.time > quake->endTime - quake->fadeOutTime) {
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 cg+107656
INDIRI4
ADDRLP4 16
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
ADDRLP4 16
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
SUBI4
LEI4 $734
line 756
;756:			a *= (float)(quake->endTime - cg.time) / (float)(quake->fadeOutTime);
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
ADDRGP4 cg+107656
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 20
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CVIF4 4
DIVF4
MULF4
ASGNF4
line 757
;757:		}
line 758
;758:	}
ADDRGP4 $734
JUMPV
LABELV $733
line 759
;759:	else {
line 760
;760:		a = cg.additionalTremble;
ADDRLP4 0
ADDRGP4 cg+112448
INDIRF4
ASGNF4
line 761
;761:	}
LABELV $734
line 763
;762:
;763:	cg.refdef.vieworg[0] += offsetAmplitude * a * crandom();
ADDRLP4 16
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 20
ADDRGP4 cg+109260+24
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDRLP4 16
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 16
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
ASGNF4
line 764
;764:	cg.refdef.vieworg[1] += offsetAmplitude * a * crandom();
ADDRLP4 24
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 28
ADDRGP4 cg+109260+24+4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRF4
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
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
MULF4
ADDF4
ASGNF4
line 765
;765:	cg.refdef.vieworg[2] += offsetAmplitude * a * crandom();
ADDRLP4 32
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 36
ADDRGP4 cg+109260+24+8
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRF4
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
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
MULF4
ADDF4
ASGNF4
line 766
;766:	cg.refdefViewAngles[YAW] += angleAmplitude * a * crandom();
ADDRLP4 40
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 44
ADDRGP4 cg+109628+4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRF4
ADDRLP4 8
INDIRF4
ADDRLP4 0
INDIRF4
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
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
MULF4
ADDF4
ASGNF4
line 767
;767:	cg.refdefViewAngles[PITCH] += angleAmplitude * a * crandom();
ADDRLP4 48
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 52
ADDRGP4 cg+109628
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRF4
ADDRLP4 8
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
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
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
MULF4
ADDF4
ASGNF4
line 768
;768:	cg.refdefViewAngles[ROLL] += angleAmplitude * a * crandom();
ADDRLP4 56
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 60
ADDRGP4 cg+109628+8
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
ADDRLP4 8
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDRLP4 56
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 56
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
ASGNF4
line 769
;769:}
LABELV $732
endproc AddEarthquakeTremble 64 12
data
align 4
LABELV $835
byte 4 0
byte 4 0
byte 4 1554
byte 4 1060320051
byte 4 2775
byte 4 1065353216
byte 4 3664
byte 4 1061997773
byte 4 4774
byte 4 1065353216
byte 4 7106
byte 4 1061997773
byte 4 8938
byte 4 1060320051
byte 4 10548
byte 4 1056964608
byte 4 16100
byte 4 0
byte 4 99999
byte 4 0
code
proc CG_CalcViewValues 88 12
line 779
;770:#endif
;771:
;772:/*
;773:===============
;774:CG_CalcViewValues
;775:
;776:Sets cg.refdef view values
;777:===============
;778:*/
;779:static int CG_CalcViewValues( void ) {
line 782
;780:	playerState_t	*ps;
;781:
;782:	memset( &cg.refdef, 0, sizeof( cg.refdef ) );
ADDRGP4 cg+109260
ARGP4
CNSTI4 0
ARGI4
CNSTI4 368
ARGI4
ADDRGP4 memset
CALLP4
pop
line 789
;783:
;784:	// strings for in game rendering
;785:	// Q_strncpyz( cg.refdef.text[0], "Park Ranger", sizeof(cg.refdef.text[0]) );
;786:	// Q_strncpyz( cg.refdef.text[1], "19", sizeof(cg.refdef.text[1]) );
;787:
;788:	// calculate size of 3D view
;789:	CG_CalcVrect();
ADDRGP4 CG_CalcVrect
CALLV
pop
line 791
;790:
;791:	ps = &cg.predictedPlayerState;
ADDRLP4 0
ADDRGP4 cg+107688
ASGNP4
line 808
;792:/*
;793:	if (cg.cameraMode) {
;794:		vec3_t origin, angles;
;795:		if (trap_getCameraInfo(cg.time, &origin, &angles)) {
;796:			VectorCopy(origin, cg.refdef.vieworg);
;797:			angles[ROLL] = 0;
;798:			VectorCopy(angles, cg.refdefViewAngles);
;799:			AnglesToAxis( cg.refdefViewAngles, cg.refdef.viewaxis );
;800:			return CG_CalcFov();
;801:		} else {
;802:			cg.cameraMode = qfalse;
;803:		}
;804:	}
;805:*/
;806:
;807:	// intermission view
;808:	if ( ps->pm_type == PM_INTERMISSION ) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 5
NEI4 $769
line 809
;809:		VectorCopy( ps->origin, cg.refdef.vieworg );
ADDRGP4 cg+109260+24
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 810
;810:		VectorCopy( ps->viewangles, cg.refdefViewAngles );
ADDRGP4 cg+109628
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
INDIRB
ASGNB 12
line 811
;811:		AnglesToAxis( cg.refdefViewAngles, cg.refdef.viewaxis );
ADDRGP4 cg+109628
ARGP4
ADDRGP4 cg+109260+36
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 812
;812:		return CG_CalcFov();
ADDRLP4 4
ADDRGP4 CG_CalcFov
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $765
JUMPV
LABELV $769
line 815
;813:	}
;814:
;815:	cg.bobcycle = ( ps->bobCycle & 128 ) >> 7;
ADDRGP4 cg+128084
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 7
RSHI4
ASGNI4
line 816
;816:	cg.bobfracsin = fabs( sin( ( ps->bobCycle & 127 ) / 127.0 * M_PI ) );
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 127
BANDI4
CVIF4 4
CNSTF4 1019913509
MULF4
ARGF4
ADDRLP4 4
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRGP4 cg+128080
ADDRLP4 8
INDIRF4
ASGNF4
line 817
;817:	cg.xyspeed = sqrt( ps->velocity[0] * ps->velocity[0] +
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
MULF4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
MULF4
ADDF4
ARGF4
ADDRLP4 16
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRGP4 cg+128088
ADDRLP4 16
INDIRF4
ASGNF4
line 821
;818:		ps->velocity[1] * ps->velocity[1] );
;819:
;820:
;821:	VectorCopy( ps->origin, cg.refdef.vieworg );
ADDRGP4 cg+109260+24
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 822
;822:	VectorCopy( ps->viewangles, cg.refdefViewAngles );
ADDRGP4 cg+109628
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
INDIRB
ASGNB 12
line 824
;823:
;824:	if (cg_cameraOrbit.integer) {
ADDRGP4 cg_cameraOrbit+12
INDIRI4
CNSTI4 0
EQI4 $783
line 825
;825:		if (cg.time > cg.nextOrbitTime) {
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cg+128092
INDIRI4
LEI4 $786
line 826
;826:			cg.nextOrbitTime = cg.time + cg_cameraOrbitDelay.integer;
ADDRGP4 cg+128092
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cg_cameraOrbitDelay+12
INDIRI4
ADDI4
ASGNI4
line 827
;827:			cg_thirdPersonAngle.value += cg_cameraOrbit.value;
ADDRLP4 20
ADDRGP4 cg_thirdPersonAngle+8
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRF4
ADDRGP4 cg_cameraOrbit+8
INDIRF4
ADDF4
ASGNF4
line 828
;828:		}
LABELV $786
line 829
;829:	}
LABELV $783
line 831
;830:	// add error decay
;831:	if ( cg_errorDecay.value > 0 ) {
ADDRGP4 cg_errorDecay+8
INDIRF4
CNSTF4 0
LEF4 $795
line 835
;832:		int		t;
;833:		float	f;
;834:
;835:		t = cg.time - cg.predictedErrorTime;
ADDRLP4 24
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cg+109040
INDIRI4
SUBI4
ASGNI4
line 836
;836:		f = ( cg_errorDecay.value - t ) / cg_errorDecay.value;
ADDRLP4 20
ADDRGP4 cg_errorDecay+8
INDIRF4
ADDRLP4 24
INDIRI4
CVIF4 4
SUBF4
ADDRGP4 cg_errorDecay+8
INDIRF4
DIVF4
ASGNF4
line 837
;837:		if ( f > 0 && f < 1 ) {
ADDRLP4 28
ADDRLP4 20
INDIRF4
ASGNF4
ADDRLP4 28
INDIRF4
CNSTF4 0
LEF4 $802
ADDRLP4 28
INDIRF4
CNSTF4 1065353216
GEF4 $802
line 838
;838:			VectorMA( cg.refdef.vieworg, f, cg.predictedError, cg.refdef.vieworg );
ADDRGP4 cg+109260+24
ADDRGP4 cg+109260+24
INDIRF4
ADDRGP4 cg+109044
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 cg+109260+24+4
ADDRGP4 cg+109260+24+4
INDIRF4
ADDRGP4 cg+109044+4
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 cg+109260+24+8
ADDRGP4 cg+109260+24+8
INDIRF4
ADDRGP4 cg+109044+8
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDF4
ASGNF4
line 839
;839:		} else {
ADDRGP4 $803
JUMPV
LABELV $802
line 840
;840:			cg.predictedErrorTime = 0;
ADDRGP4 cg+109040
CNSTI4 0
ASGNI4
line 841
;841:		}
LABELV $803
line 842
;842:	}
LABELV $795
line 844
;843:
;844:	if ( cg.renderingThirdPerson ) {
ADDRGP4 cg+107680
INDIRI4
CNSTI4 0
EQI4 $826
line 846
;845:		// back away from character
;846:		CG_OffsetThirdPersonView();
ADDRGP4 CG_OffsetThirdPersonView
CALLV
pop
line 847
;847:	} else {
ADDRGP4 $827
JUMPV
LABELV $826
line 849
;848:		// offset for local bobbing and kicks
;849:		CG_OffsetFirstPersonView();
ADDRGP4 CG_OffsetFirstPersonView
CALLV
pop
line 850
;850:	}
LABELV $827
line 855
;851:
;852:	// JUHOX: do earthquake
;853:#if MONSTER_MODE
;854:	if (
;855:		cg.earthquakeStartedTime &&
ADDRGP4 cg+110116
INDIRI4
CNSTI4 0
EQI4 $829
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cg+110120
INDIRI4
GEI4 $829
line 857
;856:		cg.time < cg.earthquakeEndTime
;857:	) {
line 888
;858:		static const struct {
;859:			int time;
;860:			float amplitude;
;861:		} envelope[] = {
;862:			/*
;863:			{    0, 0.0},
;864:			{ 1400, 0.7},
;865:			{ 2500, 1.0},
;866:			{ 3300, 0.8},
;867:			{ 4300, 1.0},
;868:			{ 6400, 0.5},
;869:			{ 8050, 0.7},
;870:			{ 9500, 0.5},
;871:			{14500, 0.0},
;872:			{99999, 0.0}
;873:			*/
;874:			{    0, 0.0},
;875:			{ 1554, 0.7},
;876:			{ 2775, 1.0},
;877:			{ 3664, 0.8},
;878:			{ 4774, 1.0},
;879:			{ 7106, 0.8},
;880:			{ 8938, 0.7},
;881:			{10548, 0.5},
;882:			{16100, 0.0},
;883:			{99999, 0.0}
;884:		};
;885:		int time;
;886:		float f;
;887:		float a;
;888:		const float offsetAmplitude = 0.2;
ADDRLP4 28
CNSTF4 1045220557
ASGNF4
line 889
;889:		const float angleAmplitude = 0.2;
ADDRLP4 32
CNSTF4 1045220557
ASGNF4
line 891
;890:
;891:		time = cg.time - cg.earthquakeStartedTime;
ADDRLP4 24
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cg+110116
INDIRI4
SUBI4
ASGNI4
line 892
;892:		if (cg.earthquakeAmplitude <= 0) {
ADDRGP4 cg+110124
INDIRF4
CNSTF4 0
GTF4 $838
line 895
;893:			int i;
;894:
;895:			i = 0;
ADDRLP4 40
CNSTI4 0
ASGNI4
ADDRGP4 $842
JUMPV
LABELV $841
line 896
;896:			while (envelope[i+1].time < time) i++;
ADDRLP4 40
ADDRLP4 40
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $842
ADDRLP4 40
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 $835+8
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
LTI4 $841
line 897
;897:			f = (float)(time - envelope[i].time) / (envelope[i+1].time - envelope[i].time);
ADDRLP4 48
ADDRGP4 $835
ASGNP4
ADDRLP4 36
ADDRLP4 24
INDIRI4
ADDRLP4 40
INDIRI4
CNSTI4 3
LSHI4
ADDRLP4 48
INDIRP4
ADDP4
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 40
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 $835+8
ADDP4
INDIRI4
ADDRLP4 40
INDIRI4
CNSTI4 3
LSHI4
ADDRLP4 48
INDIRP4
ADDP4
INDIRI4
SUBI4
CVIF4 4
DIVF4
ASGNF4
line 898
;898:			a = (1-f) * envelope[i].amplitude + f * envelope[i+1].amplitude;
ADDRLP4 52
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 20
CNSTF4 1065353216
ADDRLP4 52
INDIRF4
SUBF4
ADDRLP4 40
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 $835+4
ADDP4
INDIRF4
MULF4
ADDRLP4 52
INDIRF4
ADDRLP4 40
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 $835+8+4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 899
;899:		}
ADDRGP4 $839
JUMPV
LABELV $838
line 900
;900:		else {
line 901
;901:			a = cg.earthquakeAmplitude / 100;
ADDRLP4 20
ADDRGP4 cg+110124
INDIRF4
CNSTF4 1008981770
MULF4
ASGNF4
line 902
;902:			if (time < cg.earthquakeFadeInTime) {
ADDRLP4 24
INDIRI4
ADDRGP4 cg+110128
INDIRI4
GEI4 $850
line 903
;903:				a *= (float)time / (float)(cg.earthquakeFadeInTime);
ADDRLP4 20
ADDRLP4 20
INDIRF4
ADDRLP4 24
INDIRI4
CVIF4 4
ADDRGP4 cg+110128
INDIRI4
CVIF4 4
DIVF4
MULF4
ASGNF4
line 904
;904:			}
ADDRGP4 $851
JUMPV
LABELV $850
line 905
;905:			else if (cg.time > cg.earthquakeEndTime - cg.earthquakeFadeOutTime) {
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cg+110120
INDIRI4
ADDRGP4 cg+110132
INDIRI4
SUBI4
LEI4 $854
line 906
;906:				a *= (float)(cg.earthquakeEndTime - cg.time) / (float)(cg.earthquakeFadeOutTime);
ADDRLP4 20
ADDRLP4 20
INDIRF4
ADDRGP4 cg+110120
INDIRI4
ADDRGP4 cg+107656
INDIRI4
SUBI4
CVIF4 4
ADDRGP4 cg+110132
INDIRI4
CVIF4 4
DIVF4
MULF4
ASGNF4
line 907
;907:			}
LABELV $854
LABELV $851
line 908
;908:		}
LABELV $839
line 909
;909:		cg.refdef.vieworg[0] += offsetAmplitude * a * crandom();
ADDRLP4 40
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 44
ADDRGP4 cg+109260+24
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRF4
ADDRLP4 28
INDIRF4
ADDRLP4 20
INDIRF4
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
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
MULF4
ADDF4
ASGNF4
line 910
;910:		cg.refdef.vieworg[1] += offsetAmplitude * a * crandom();
ADDRLP4 48
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 52
ADDRGP4 cg+109260+24+4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRF4
ADDRLP4 28
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
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
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
MULF4
ADDF4
ASGNF4
line 911
;911:		cg.refdef.vieworg[2] += offsetAmplitude * a * crandom();
ADDRLP4 56
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 60
ADDRGP4 cg+109260+24+8
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
ADDRLP4 28
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDRLP4 56
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 56
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
ASGNF4
line 912
;912:		cg.refdefViewAngles[YAW] += angleAmplitude * a * crandom();
ADDRLP4 64
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 68
ADDRGP4 cg+109628+4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRF4
ADDRLP4 32
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDRLP4 64
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 64
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
ASGNF4
line 913
;913:		cg.refdefViewAngles[PITCH] += angleAmplitude * a * crandom();
ADDRLP4 72
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 76
ADDRGP4 cg+109628
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRF4
ADDRLP4 32
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDRLP4 72
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 72
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
ASGNF4
line 914
;914:		cg.refdefViewAngles[ROLL] += angleAmplitude * a * crandom();
ADDRLP4 80
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 84
ADDRGP4 cg+109628+8
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRF4
ADDRLP4 32
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
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
CNSTF4 1073741824
MULF4
MULF4
ADDF4
ASGNF4
line 915
;915:	}
LABELV $829
line 919
;916:#endif
;917:
;918:#if EARTHQUAKE_SYSTEM	// JUHOX: add earthquakes
;919:	{
line 922
;920:		int i;
;921:
;922:		for (i = 0; i < MAX_EARTHQUAKES; i++) {
ADDRLP4 20
CNSTI4 0
ASGNI4
LABELV $875
line 925
;923:			earthquake_t* quake;
;924:
;925:			quake = &cg.earthquakes[i];
ADDRLP4 24
ADDRLP4 20
INDIRI4
CNSTI4 36
MULI4
ADDRGP4 cg+110144
ADDP4
ASGNP4
line 926
;926:			if (!quake->startTime) continue;
ADDRLP4 24
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 0
NEI4 $880
ADDRGP4 $876
JUMPV
LABELV $880
line 928
;927:
;928:			AddEarthquakeTremble(quake);
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 AddEarthquakeTremble
CALLV
pop
line 929
;929:		}
LABELV $876
line 922
ADDRLP4 20
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 64
LTI4 $875
line 930
;930:		AddEarthquakeTremble(NULL);	// additional tremble
CNSTP4 0
ARGP4
ADDRGP4 AddEarthquakeTremble
CALLV
pop
line 931
;931:	}
line 935
;932:#endif
;933:
;934:	// position eye reletive to origin
;935:	AnglesToAxis( cg.refdefViewAngles, cg.refdef.viewaxis );
ADDRGP4 cg+109628
ARGP4
ADDRGP4 cg+109260+36
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 950
;936:
;937:	// JUHOX: offset vieworg for lens flare editor fine move mode
;938:#if MAPLENSFLARES
;939:	/*
;940:	if (
;941:		cgs.editMode == EM_mlf &&
;942:		cg.lfEditor.selectedLFEnt &&
;943:		cg.lfEditor.editMode > LFEEM_none &&
;944:		cg.lfEditor.selectedLFEnt->lock
;945:	) {
;946:		VectorAdd(cg.lfEditor.selectedLFEnt->lock->lerpOrigin, cg.lfEditorMoverOffset, cg.refdef.vieworg);
;947:	}
;948:	*/
;949:	if (
;950:		cgs.editMode == EM_mlf &&
ADDRGP4 cgs+31684
INDIRI4
CNSTI4 1
NEI4 $885
ADDRGP4 cg+109660
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $885
ADDRGP4 cg+109660+8
INDIRI4
CNSTI4 0
LEI4 $885
ADDRGP4 cg+109660+12
INDIRI4
CNSTI4 1
NEI4 $885
line 954
;951:		cg.lfEditor.selectedLFEnt &&
;952:		cg.lfEditor.editMode > LFEEM_none &&
;953:		cg.lfEditor.moveMode == LFEMM_fine
;954:	) {
line 957
;955:		vec3_t cursor;
;956:
;957:		CG_LFEntOrigin(cg.lfEditor.selectedLFEnt, cursor);
ADDRGP4 cg+109660
INDIRP4
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 CG_LFEntOrigin
CALLV
pop
line 958
;958:		if (cg.lfEditor.editMode == LFEEM_pos) {
ADDRGP4 cg+109660+8
INDIRI4
CNSTI4 1
NEI4 $894
line 959
;959:			VectorAdd(cg.refdef.vieworg, cg.lfEditor.fmm_offset, cursor);
ADDRLP4 20
ADDRGP4 cg+109260+24
INDIRF4
ADDRGP4 cg+109660+24
INDIRF4
ADDF4
ASGNF4
ADDRLP4 20+4
ADDRGP4 cg+109260+24+4
INDIRF4
ADDRGP4 cg+109660+24+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 20+8
ADDRGP4 cg+109260+24+8
INDIRF4
ADDRGP4 cg+109660+24+8
INDIRF4
ADDF4
ASGNF4
line 960
;960:			CG_SetLFEntOrigin(cg.lfEditor.selectedLFEnt, cursor);
ADDRGP4 cg+109660
INDIRP4
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 CG_SetLFEntOrigin
CALLV
pop
line 961
;961:		}
LABELV $894
line 962
;962:		VectorMA(cursor, -cg.lfEditor.fmm_distance, cg.refdef.viewaxis[0], cg.refdef.vieworg);
ADDRGP4 cg+109260+24
ADDRLP4 20
INDIRF4
ADDRGP4 cg+109260+36
INDIRF4
ADDRGP4 cg+109660+20
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRGP4 cg+109260+24+4
ADDRLP4 20+4
INDIRF4
ADDRGP4 cg+109260+36+4
INDIRF4
ADDRGP4 cg+109660+20
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRGP4 cg+109260+24+8
ADDRLP4 20+8
INDIRF4
ADDRGP4 cg+109260+36+8
INDIRF4
ADDRGP4 cg+109660+20
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 963
;963:	}
LABELV $885
line 966
;964:#endif
;965:
;966:	if ( cg.hyperspace ) {
ADDRGP4 cg+107684
INDIRI4
CNSTI4 0
EQI4 $941
line 967
;967:		cg.refdef.rdflags |= RDF_NOWORLDMODEL | RDF_HYPERSPACE;
ADDRLP4 20
ADDRGP4 cg+109260+76
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 5
BORI4
ASGNI4
line 968
;968:	}
LABELV $941
line 971
;969:
;970:	// field of view
;971:	return CG_CalcFov();
ADDRLP4 20
ADDRGP4 CG_CalcFov
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
RETI4
LABELV $765
endproc CG_CalcViewValues 88 12
proc CG_PowerupTimerSounds 16 16
line 980
;972:}
;973:
;974:
;975:/*
;976:=====================
;977:CG_PowerupTimerSounds
;978:=====================
;979:*/
;980:static void CG_PowerupTimerSounds( void ) {
line 985
;981:	int		i;
;982:	int		t;
;983:
;984:	// powerup timers going away
;985:	for ( i = 0 ; i < /*MAX_POWERUPS*/PW_NUM_POWERUPS ; i++ ) {	// JUHOX
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $947
line 986
;986:		t = cg.snap->ps.powerups[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 356
ADDP4
ADDP4
INDIRI4
ASGNI4
line 987
;987:		if ( t <= cg.time ) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+107656
INDIRI4
GTI4 $952
line 988
;988:			continue;
ADDRGP4 $948
JUMPV
LABELV $952
line 993
;989:		}
;990:		// JUHOX: don't play timer sounds for misused powerups
;991:#if 1
;992:		if (
;993:			i == PW_HASTE ||
ADDRLP4 0
INDIRI4
CNSTI4 3
EQI4 $959
ADDRLP4 0
INDIRI4
CNSTI4 2
EQI4 $959
ADDRLP4 0
INDIRI4
CNSTI4 10
EQI4 $959
ADDRLP4 0
INDIRI4
CNSTI4 12
NEI4 $955
LABELV $959
line 998
;994:			i == PW_BATTLESUIT ||
;995:			//i == PW_QUAD ||
;996:			i == PW_CHARGE ||
;997:			i == PW_BFG_RELOADING
;998:		) {
line 999
;999:			continue;
ADDRGP4 $948
JUMPV
LABELV $955
line 1002
;1000:		}
;1001:#endif
;1002:		if ( t - cg.time >= POWERUP_BLINKS * POWERUP_BLINK_TIME ) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+107656
INDIRI4
SUBI4
CNSTI4 5000
LTI4 $960
line 1003
;1003:			continue;
ADDRGP4 $948
JUMPV
LABELV $960
line 1005
;1004:		}
;1005:		if ( ( t - cg.time ) / POWERUP_BLINK_TIME != ( t - cg.oldTime ) / POWERUP_BLINK_TIME ) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+107656
INDIRI4
SUBI4
CNSTI4 1000
DIVI4
ADDRLP4 4
INDIRI4
ADDRGP4 cg+107660
INDIRI4
SUBI4
CNSTI4 1000
DIVI4
EQI4 $963
line 1006
;1006:			trap_S_StartSound( NULL, cg.snap->ps.clientNum, CHAN_ITEM, cgs.media.wearOffSound );
CNSTP4 0
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 cgs+751220+848
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound_fixed
CALLV
pop
line 1007
;1007:		}
LABELV $963
line 1008
;1008:	}
LABELV $948
line 985
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 13
LTI4 $947
line 1009
;1009:}
LABELV $946
endproc CG_PowerupTimerSounds 16 16
export CG_AddBufferedSound
proc CG_AddBufferedSound 4 0
line 1016
;1010:
;1011:/*
;1012:=====================
;1013:CG_AddBufferedSound
;1014:=====================
;1015:*/
;1016:void CG_AddBufferedSound( sfxHandle_t sfx ) {
line 1017
;1017:	if ( !sfx )
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $971
line 1018
;1018:		return;
ADDRGP4 $970
JUMPV
LABELV $971
line 1019
;1019:	cg.soundBuffer[cg.soundBufferIn] = sfx;
ADDRGP4 cg+127864
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+127876
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 1020
;1020:	cg.soundBufferIn = (cg.soundBufferIn + 1) % MAX_SOUNDBUFFER;
ADDRGP4 cg+127864
ADDRGP4 cg+127864
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 20
MODI4
ASGNI4
line 1021
;1021:	if (cg.soundBufferIn == cg.soundBufferOut) {
ADDRGP4 cg+127864
INDIRI4
ADDRGP4 cg+127868
INDIRI4
NEI4 $977
line 1022
;1022:		cg.soundBufferOut++;
ADDRLP4 0
ADDRGP4 cg+127868
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1023
;1023:	}
LABELV $977
line 1024
;1024:}
LABELV $970
endproc CG_AddBufferedSound 4 0
proc CG_PlayBufferedSounds 0 8
line 1031
;1025:
;1026:/*
;1027:=====================
;1028:CG_PlayBufferedSounds
;1029:=====================
;1030:*/
;1031:static void CG_PlayBufferedSounds( void ) {
line 1032
;1032:	if ( cg.soundTime < cg.time ) {
ADDRGP4 cg+127872
INDIRI4
ADDRGP4 cg+107656
INDIRI4
GEI4 $983
line 1033
;1033:		if (cg.soundBufferOut != cg.soundBufferIn && cg.soundBuffer[cg.soundBufferOut]) {
ADDRGP4 cg+127868
INDIRI4
ADDRGP4 cg+127864
INDIRI4
EQI4 $987
ADDRGP4 cg+127868
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+127876
ADDP4
INDIRI4
CNSTI4 0
EQI4 $987
line 1034
;1034:			trap_S_StartLocalSound(cg.soundBuffer[cg.soundBufferOut], CHAN_ANNOUNCER);
ADDRGP4 cg+127868
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+127876
ADDP4
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 1035
;1035:			cg.soundBuffer[cg.soundBufferOut] = 0;
ADDRGP4 cg+127868
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+127876
ADDP4
CNSTI4 0
ASGNI4
line 1036
;1036:			cg.soundBufferOut = (cg.soundBufferOut + 1) % MAX_SOUNDBUFFER;
ADDRGP4 cg+127868
ADDRGP4 cg+127868
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 20
MODI4
ASGNI4
line 1037
;1037:			cg.soundTime = cg.time + 750;
ADDRGP4 cg+127872
ADDRGP4 cg+107656
INDIRI4
CNSTI4 750
ADDI4
ASGNI4
line 1038
;1038:		}
LABELV $987
line 1039
;1039:	}
LABELV $983
line 1040
;1040:}
LABELV $982
endproc CG_PlayBufferedSounds 0 8
proc CG_DrawMapLensFlare 208 12
line 1053
;1041:
;1042:/*
;1043:===============
;1044:JUHOX: CG_DrawMapLensFlare
;1045:===============
;1046:*/
;1047:#if MAPLENSFLARES
;1048:static void CG_DrawMapLensFlare(
;1049:	const lensFlare_t* lf,
;1050:	float distance,
;1051:	vec3_t center, vec3_t dir, vec3_t angles,
;1052:	float alpha, float visibleLight
;1053:) {
line 1057
;1054:	refEntity_t ent;
;1055:	float radius;
;1056:
;1057:	memset(&ent, 0, sizeof(ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1059
;1058:
;1059:	radius = lf->size;
ADDRLP4 140
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 1061
;1060:
;1061:	switch (lf->mode) {
ADDRLP4 144
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $1005
ADDRLP4 144
INDIRI4
CNSTI4 1
EQI4 $1008
ADDRLP4 144
INDIRI4
CNSTI4 2
EQI4 $1009
ADDRGP4 $1002
JUMPV
LABELV $1005
line 1063
;1062:	case LFM_reflexion:
;1063:		alpha *= 0.2 * lf->rgba[3];
ADDRFP4 20
ADDRFP4 20
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 1045220557
MULF4
MULF4
ASGNF4
line 1065
;1064:
;1065:		radius *= cg.refdef.fov_x / 90;	// lens flares do not change size through zooming
ADDRLP4 140
ADDRLP4 140
INDIRF4
ADDRGP4 cg+109260+16
INDIRF4
CNSTF4 1010174817
MULF4
MULF4
ASGNF4
line 1067
;1066:		//alpha /= radius;
;1067:		break;
ADDRGP4 $1003
JUMPV
LABELV $1008
line 1069
;1068:	case LFM_glare:
;1069:		alpha *= 0.14 * lf->rgba[3];
ADDRFP4 20
ADDRFP4 20
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 1041194025
MULF4
MULF4
ASGNF4
line 1070
;1070:		radius *= visibleLight * 1000000.0 / Square(distance);
ADDRLP4 152
ADDRFP4 4
INDIRF4
ASGNF4
ADDRLP4 140
ADDRLP4 140
INDIRF4
ADDRFP4 24
INDIRF4
CNSTF4 1232348160
MULF4
ADDRLP4 152
INDIRF4
ADDRLP4 152
INDIRF4
MULF4
DIVF4
MULF4
ASGNF4
line 1071
;1071:		break;
ADDRGP4 $1003
JUMPV
LABELV $1009
line 1080
;1072:	case LFM_star:
;1073:		/*
;1074:		alpha *= lf->rgba[3];
;1075:		radius *= 40000.0 / (distance * sqrt(distance) * sqrt(sqrt(sqrt(distance))));
;1076:
;1077:		radius *= cg.refdef.fov_x / 90;	// lens flares do not change size through zooming
;1078:		alpha /= radius;
;1079:		*/
;1080:		alpha *= lf->rgba[3];
ADDRFP4 20
ADDRFP4 20
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
MULF4
ASGNF4
line 1081
;1081:		radius *= visibleLight * 40000.0 / (distance * sqrt(distance) * sqrt(sqrt(sqrt(distance))));
ADDRLP4 156
ADDRFP4 4
INDIRF4
ASGNF4
ADDRLP4 156
INDIRF4
ARGF4
ADDRLP4 160
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRLP4 164
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 164
INDIRF4
ARGF4
ADDRLP4 168
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 168
INDIRF4
ARGF4
ADDRLP4 172
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 140
ADDRLP4 140
INDIRF4
ADDRFP4 24
INDIRF4
CNSTF4 1193033728
MULF4
ADDRLP4 156
INDIRF4
ADDRLP4 160
INDIRF4
MULF4
ADDRLP4 172
INDIRF4
MULF4
DIVF4
MULF4
ASGNF4
line 1082
;1082:		break;
LABELV $1002
LABELV $1003
line 1085
;1083:	}
;1084:
;1085:	alpha *= visibleLight;
ADDRFP4 20
ADDRFP4 20
INDIRF4
ADDRFP4 24
INDIRF4
MULF4
ASGNF4
line 1086
;1086:	if (alpha > 255) alpha = 255;
ADDRFP4 20
INDIRF4
CNSTF4 1132396544
LEF4 $1010
ADDRFP4 20
CNSTF4 1132396544
ASGNF4
LABELV $1010
line 1088
;1087:
;1088:	ent.reType = RT_SPRITE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 1089
;1089:	ent.customShader = lf->shader;
ADDRLP4 0+112
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 1090
;1090:	ent.shaderRGBA[0] = lf->rgba[0];
ADDRLP4 156
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ASGNF4
ADDRLP4 160
CNSTF4 1325400064
ASGNF4
ADDRLP4 156
INDIRF4
ADDRLP4 160
INDIRF4
LTF4 $1015
ADDRLP4 152
ADDRLP4 156
INDIRF4
ADDRLP4 160
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1016
JUMPV
LABELV $1015
ADDRLP4 152
ADDRLP4 156
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1016
ADDRLP4 0+116
ADDRLP4 152
INDIRU4
CVUU1 4
ASGNU1
line 1091
;1091:	ent.shaderRGBA[1] = lf->rgba[1];
ADDRLP4 168
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ASGNF4
ADDRLP4 172
CNSTF4 1325400064
ASGNF4
ADDRLP4 168
INDIRF4
ADDRLP4 172
INDIRF4
LTF4 $1020
ADDRLP4 164
ADDRLP4 168
INDIRF4
ADDRLP4 172
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1021
JUMPV
LABELV $1020
ADDRLP4 164
ADDRLP4 168
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1021
ADDRLP4 0+116+1
ADDRLP4 164
INDIRU4
CVUU1 4
ASGNU1
line 1092
;1092:	ent.shaderRGBA[2] = lf->rgba[2];
ADDRLP4 180
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
ADDRLP4 184
CNSTF4 1325400064
ASGNF4
ADDRLP4 180
INDIRF4
ADDRLP4 184
INDIRF4
LTF4 $1025
ADDRLP4 176
ADDRLP4 180
INDIRF4
ADDRLP4 184
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1026
JUMPV
LABELV $1025
ADDRLP4 176
ADDRLP4 180
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1026
ADDRLP4 0+116+2
ADDRLP4 176
INDIRU4
CVUU1 4
ASGNU1
line 1093
;1093:	ent.shaderRGBA[3] = alpha;
ADDRLP4 192
ADDRFP4 20
INDIRF4
ASGNF4
ADDRLP4 196
CNSTF4 1325400064
ASGNF4
ADDRLP4 192
INDIRF4
ADDRLP4 196
INDIRF4
LTF4 $1030
ADDRLP4 188
ADDRLP4 192
INDIRF4
ADDRLP4 196
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1031
JUMPV
LABELV $1030
ADDRLP4 188
ADDRLP4 192
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1031
ADDRLP4 0+116+3
ADDRLP4 188
INDIRU4
CVUU1 4
ASGNU1
line 1094
;1094:	ent.radius = radius;
ADDRLP4 0+132
ADDRLP4 140
INDIRF4
ASGNF4
line 1096
;1095:
;1096:	ent.rotation =
ADDRLP4 200
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 204
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 0+136
ADDRLP4 200
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 200
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 204
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 200
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 204
INDIRP4
INDIRF4
MULF4
ADDF4
ADDRLP4 200
INDIRP4
CNSTI4 44
ADDP4
INDIRF4
ADDRLP4 204
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1102
;1097:		lf->rotationOffset +
;1098:		lf->rotationYawFactor * angles[YAW] +
;1099:		lf->rotationPitchFactor * angles[PITCH] +
;1100:		lf->rotationRollFactor * angles[ROLL];
;1101:
;1102:	VectorMA(center, lf->pos, dir, ent.origin);
ADDRLP4 0+68
ADDRFP4 8
INDIRP4
INDIRF4
ADDRFP4 12
INDIRP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRFP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+8
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1103
;1103:	trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1104
;1104:}
LABELV $1001
endproc CG_DrawMapLensFlare 208 12
proc CG_AddLensFlareMarker 276 12
line 1113
;1105:#endif
;1106:
;1107:/*
;1108:=====================
;1109:JUHOX: CG_AddLensFlareMarker
;1110:=====================
;1111:*/
;1112:#if MAPLENSFLARES
;1113:static void CG_AddLensFlareMarker(int lfe) {
line 1119
;1114:	const lensFlareEntity_t* lfent;
;1115:	float radius;
;1116:	refEntity_t ent;
;1117:	vec3_t origin;
;1118:
;1119:	lfent = &cgs.lensFlareEntities[lfe];
ADDRLP4 140
ADDRFP4 0
INDIRI4
CNSTI4 184
MULI4
ADDRGP4 cgs+562800
ADDP4
ASGNP4
line 1121
;1120:	
;1121:	memset(&ent, 0, sizeof(ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1122
;1122:	ent.reType = RT_MODEL;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1123
;1123:	ent.hModel = trap_R_RegisterModel("models/powerups/health/small_sphere.md3");
ADDRGP4 $1042
ARGP4
ADDRLP4 160
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 0+8
ADDRLP4 160
INDIRI4
ASGNI4
line 1124
;1124:	ent.customShader = trap_R_RegisterShader("lfeditorcursor");
ADDRGP4 $1044
ARGP4
ADDRLP4 164
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 0+112
ADDRLP4 164
INDIRI4
ASGNI4
line 1125
;1125:	radius = lfent->radius;
ADDRLP4 144
ADDRLP4 140
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ASGNF4
line 1126
;1126:	ent.shaderRGBA[0] = 0x00;
ADDRLP4 0+116
CNSTU1 0
ASGNU1
line 1127
;1127:	ent.shaderRGBA[1] = 0x80;
ADDRLP4 0+116+1
CNSTU1 128
ASGNU1
line 1128
;1128:	ent.shaderRGBA[2] = 0x00;
ADDRLP4 0+116+2
CNSTU1 0
ASGNU1
line 1129
;1129:	if (lfent->angle >= 0) {
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
CNSTF4 0
LTF4 $1050
line 1130
;1130:		ent.shaderRGBA[0] = 0x00;
ADDRLP4 0+116
CNSTU1 0
ASGNU1
line 1131
;1131:		ent.shaderRGBA[1] = 0x00;
ADDRLP4 0+116+1
CNSTU1 0
ASGNU1
line 1132
;1132:		ent.shaderRGBA[2] = 0x80;
ADDRLP4 0+116+2
CNSTU1 128
ASGNU1
line 1133
;1133:	}
LABELV $1050
line 1135
;1134:	if (
;1135:		!cg.lfEditor.selectedLFEnt &&
ADDRGP4 cg+109660
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1057
ADDRFP4 0
INDIRI4
ADDRGP4 cg+109660+44
INDIRI4
NEI4 $1057
line 1137
;1136:		lfe == cg.lfEditor.markedLFEnt
;1137:	) {
line 1140
;1138:		int c;
;1139:
;1140:		c = 0x40 * (1 + sin(0.01 * cg.time));
ADDRGP4 cg+107656
INDIRI4
CVIF4 4
CNSTF4 1008981770
MULF4
ARGF4
ADDRLP4 172
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 168
ADDRLP4 172
INDIRF4
CNSTF4 1065353216
ADDF4
CNSTF4 1115684864
MULF4
CVFI4 4
ASGNI4
line 1141
;1141:		ent.shaderRGBA[0] += c;
ADDRLP4 0+116
ADDRLP4 0+116
INDIRU1
CVUI4 1
ADDRLP4 168
INDIRI4
ADDI4
CVIU4 4
CVUU1 4
ASGNU1
line 1142
;1142:		ent.shaderRGBA[1] += c;
ADDRLP4 0+116+1
ADDRLP4 0+116+1
INDIRU1
CVUI4 1
ADDRLP4 168
INDIRI4
ADDI4
CVIU4 4
CVUU1 4
ASGNU1
line 1143
;1143:		ent.shaderRGBA[2] += c;
ADDRLP4 0+116+2
ADDRLP4 0+116+2
INDIRU1
CVUI4 1
ADDRLP4 168
INDIRI4
ADDI4
CVIU4 4
CVUU1 4
ASGNU1
line 1144
;1144:	}
ADDRGP4 $1058
JUMPV
LABELV $1057
line 1145
;1145:	else if (cg.lfEditor.selectedLFEnt == lfent) {
ADDRGP4 cg+109660
INDIRP4
CVPU4 4
ADDRLP4 140
INDIRP4
CVPU4 4
NEU4 $1068
line 1146
;1146:		ent.shaderRGBA[0] = 0xff;
ADDRLP4 0+116
CNSTU1 255
ASGNU1
line 1147
;1147:		ent.shaderRGBA[1] >>= 1;
ADDRLP4 0+116+1
ADDRLP4 0+116+1
INDIRU1
CVUI4 1
CNSTI4 1
RSHI4
CVIU4 4
CVUU1 4
ASGNU1
line 1148
;1148:		ent.shaderRGBA[2] >>= 1;
ADDRLP4 0+116+2
ADDRLP4 0+116+2
INDIRU1
CVUI4 1
CNSTI4 1
RSHI4
CVIU4 4
CVUU1 4
ASGNU1
line 1149
;1149:		if (cg.lfEditor.editMode == LFEEM_radius) {
ADDRGP4 cg+109660+8
INDIRI4
CNSTI4 3
NEI4 $1076
line 1150
;1150:			radius = cg.lfEditor.selectedLFEnt->lightRadius;
ADDRLP4 144
ADDRGP4 cg+109660
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ASGNF4
line 1151
;1151:		}
ADDRGP4 $1077
JUMPV
LABELV $1076
line 1152
;1152:		else if (cg.lfEditor.cursorSize == LFECS_small) {
ADDRGP4 cg+109660+16
INDIRI4
CNSTI4 0
NEI4 $1081
line 1153
;1153:			radius = 2;
ADDRLP4 144
CNSTF4 1073741824
ASGNF4
line 1154
;1154:		}
ADDRGP4 $1082
JUMPV
LABELV $1081
line 1155
;1155:		else if (cg.lfEditor.cursorSize == LFECS_lightRadius) {
ADDRGP4 cg+109660+16
INDIRI4
CNSTI4 1
NEI4 $1085
line 1156
;1156:			radius = cg.lfEditor.selectedLFEnt->lightRadius;
ADDRLP4 144
ADDRGP4 cg+109660
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ASGNF4
line 1157
;1157:		}
ADDRGP4 $1086
JUMPV
LABELV $1085
line 1158
;1158:		else {
line 1159
;1159:			radius = cg.lfEditor.selectedLFEnt->radius;
ADDRLP4 144
ADDRGP4 cg+109660
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ASGNF4
line 1160
;1160:		}
LABELV $1086
LABELV $1082
LABELV $1077
line 1161
;1161:	}
LABELV $1068
LABELV $1058
line 1162
;1162:	CG_LFEntOrigin(lfent, origin);
ADDRLP4 140
INDIRP4
ARGP4
ADDRLP4 148
ARGP4
ADDRGP4 CG_LFEntOrigin
CALLV
pop
line 1163
;1163:	VectorCopy(origin, ent.origin);
ADDRLP4 0+68
ADDRLP4 148
INDIRB
ASGNB 12
line 1165
;1164:
;1165:	ent.origin[2] -= 0.5 * radius;
ADDRLP4 0+68+8
ADDRLP4 0+68+8
INDIRF4
ADDRLP4 144
INDIRF4
CNSTF4 1056964608
MULF4
SUBF4
ASGNF4
line 1167
;1166:
;1167:	ent.axis[0][0] = 0.1 * radius;
ADDRLP4 0+28
ADDRLP4 144
INDIRF4
CNSTF4 1036831949
MULF4
ASGNF4
line 1168
;1168:	ent.axis[1][1] = 0.1 * radius;
ADDRLP4 0+28+12+4
ADDRLP4 144
INDIRF4
CNSTF4 1036831949
MULF4
ASGNF4
line 1169
;1169:	ent.axis[2][2] = 0.1 * radius;
ADDRLP4 0+28+24+8
ADDRLP4 144
INDIRF4
CNSTF4 1036831949
MULF4
ASGNF4
line 1170
;1170:	ent.nonNormalizedAxes = qtrue;
ADDRLP4 0+64
CNSTI4 1
ASGNI4
line 1171
;1171:	trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1173
;1172:
;1173:	if (lfent->angle >= 0) {
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
CNSTF4 0
LTF4 $1102
line 1177
;1174:		float len;
;1175:		vec3_t end;
;1176:
;1177:		len = 2 * lfent->radius + 10;
ADDRLP4 180
ADDRLP4 140
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
CNSTF4 1073741824
MULF4
CNSTF4 1092616192
ADDF4
ASGNF4
line 1178
;1178:		VectorMA(origin, len, lfent->dir, end);
ADDRLP4 188
ADDRLP4 180
INDIRF4
ASGNF4
ADDRLP4 168
ADDRLP4 148
INDIRF4
ADDRLP4 140
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 188
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 168+4
ADDRLP4 148+4
INDIRF4
ADDRLP4 140
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 188
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 168+8
ADDRLP4 148+8
INDIRF4
ADDRLP4 140
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 180
INDIRF4
MULF4
ADDF4
ASGNF4
line 1179
;1179:		CG_Draw3DLine(origin, end, trap_R_RegisterShader("dischargeFlash"));
ADDRGP4 $1108
ARGP4
ADDRLP4 192
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 148
ARGP4
ADDRLP4 168
ARGP4
ADDRLP4 192
INDIRI4
ARGI4
ADDRGP4 CG_Draw3DLine
CALLV
pop
line 1181
;1180:
;1181:		if (lfent->angle < 70) {
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
CNSTF4 1116471296
GEF4 $1109
line 1186
;1182:			float size;
;1183:			vec3_t right, up;
;1184:			vec3_t p1, p2;
;1185:
;1186:			size = len * tan(DEG2RAD(lfent->angle));
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
CNSTF4 1016003125
MULF4
ARGF4
ADDRLP4 248
ADDRGP4 tan
CALLF4
ASGNF4
ADDRLP4 196
ADDRLP4 180
INDIRF4
ADDRLP4 248
INDIRF4
MULF4
ASGNF4
line 1187
;1187:			MakeNormalVectors(lfent->dir, right, up);
ADDRLP4 140
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 224
ARGP4
ADDRLP4 236
ARGP4
ADDRGP4 MakeNormalVectors
CALLV
pop
line 1189
;1188:
;1189:			VectorMA(end, size, right, p1);
ADDRLP4 200
ADDRLP4 168
INDIRF4
ADDRLP4 224
INDIRF4
ADDRLP4 196
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 200+4
ADDRLP4 168+4
INDIRF4
ADDRLP4 224+4
INDIRF4
ADDRLP4 196
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 200+8
ADDRLP4 168+8
INDIRF4
ADDRLP4 224+8
INDIRF4
ADDRLP4 196
INDIRF4
MULF4
ADDF4
ASGNF4
line 1190
;1190:			VectorMA(end, -size, right, p2);
ADDRLP4 256
ADDRLP4 196
INDIRF4
NEGF4
ASGNF4
ADDRLP4 212
ADDRLP4 168
INDIRF4
ADDRLP4 224
INDIRF4
ADDRLP4 256
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 212+4
ADDRLP4 168+4
INDIRF4
ADDRLP4 224+4
INDIRF4
ADDRLP4 256
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 212+8
ADDRLP4 168+8
INDIRF4
ADDRLP4 224+8
INDIRF4
ADDRLP4 196
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 1191
;1191:			CG_Draw3DLine(p1, p2, trap_R_RegisterShader("dischargeFlash"));
ADDRGP4 $1108
ARGP4
ADDRLP4 260
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 200
ARGP4
ADDRLP4 212
ARGP4
ADDRLP4 260
INDIRI4
ARGI4
ADDRGP4 CG_Draw3DLine
CALLV
pop
line 1193
;1192:
;1193:			VectorMA(end, size, up, p1);
ADDRLP4 200
ADDRLP4 168
INDIRF4
ADDRLP4 236
INDIRF4
ADDRLP4 196
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 200+4
ADDRLP4 168+4
INDIRF4
ADDRLP4 236+4
INDIRF4
ADDRLP4 196
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 200+8
ADDRLP4 168+8
INDIRF4
ADDRLP4 236+8
INDIRF4
ADDRLP4 196
INDIRF4
MULF4
ADDF4
ASGNF4
line 1194
;1194:			VectorMA(end, -size, up, p2);
ADDRLP4 268
ADDRLP4 196
INDIRF4
NEGF4
ASGNF4
ADDRLP4 212
ADDRLP4 168
INDIRF4
ADDRLP4 236
INDIRF4
ADDRLP4 268
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 212+4
ADDRLP4 168+4
INDIRF4
ADDRLP4 236+4
INDIRF4
ADDRLP4 268
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 212+8
ADDRLP4 168+8
INDIRF4
ADDRLP4 236+8
INDIRF4
ADDRLP4 196
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 1195
;1195:			CG_Draw3DLine(p1, p2, trap_R_RegisterShader("dischargeFlash"));
ADDRGP4 $1108
ARGP4
ADDRLP4 272
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 200
ARGP4
ADDRLP4 212
ARGP4
ADDRLP4 272
INDIRI4
ARGI4
ADDRGP4 CG_Draw3DLine
CALLV
pop
line 1196
;1196:		}
LABELV $1109
line 1197
;1197:	}
LABELV $1102
line 1198
;1198:}
LABELV $1039
endproc CG_AddLensFlareMarker 276 12
proc CG_IsLFVisible 64 28
line 1207
;1199:#endif
;1200:
;1201:/*
;1202:=====================
;1203:JUHOX: CG_IsLFVisible
;1204:=====================
;1205:*/
;1206:#if MAPLENSFLARES
;1207:static qboolean CG_IsLFVisible(const vec3_t origin, const vec3_t pos, float lfradius) {
line 1210
;1208:	trace_t trace;
;1209:
;1210:	CG_SmoothTrace(&trace, cg.refdef.vieworg, NULL, NULL, pos, cg.snap->ps.clientNum, MASK_OPAQUE|CONTENTS_BODY);
ADDRLP4 0
ARGP4
ADDRGP4 cg+109260+24
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
CNSTI4 33554457
ARGI4
ADDRGP4 CG_SmoothTrace
CALLV
pop
line 1212
;1211:	//return (1.0 - trace.fraction) * distance <= lfradius;
;1212:	return Distance(trace.endpos, origin) <= lfradius;
ADDRLP4 0+12
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRLP4 60
INDIRF4
ADDRFP4 8
INDIRF4
GTF4 $1141
ADDRLP4 56
CNSTI4 1
ASGNI4
ADDRGP4 $1142
JUMPV
LABELV $1141
ADDRLP4 56
CNSTI4 0
ASGNI4
LABELV $1142
ADDRLP4 56
INDIRI4
RETI4
LABELV $1135
endproc CG_IsLFVisible 64 28
proc CG_ComputeVisibleLightSample 92 12
line 1229
;1213:}
;1214:#endif
;1215:
;1216:/*
;1217:=====================
;1218:JUHOX: CG_ComputeVisibleLightSample
;1219:=====================
;1220:*/
;1221:#if MAPLENSFLARES
;1222:#define NUMVISSAMPLES 50
;1223:static float CG_ComputeVisibleLightSample(
;1224:	lensFlareEntity_t* lfent,
;1225:	const vec3_t origin,		// redundant, but we have this already
;1226:	float distance,				// ditto
;1227:	vec3_t visOrigin,
;1228:	int quality
;1229:) {
line 1244
;1230:	/*
;1231:	static const float angleTab[48] = {
;1232:		0, 45, 90, 135, 180, 225, 270, 315,
;1233:		7.5, 15, 22.5, 30, 37.5, 52.5, 60, 67.5,
;1234:		75, 82.5, 97.5, 105, 112.5, 120, 127.5, 142.5,
;1235:		150, 157.5, 165, 172.5, 187.5, 195, 202.5, 210,
;1236:		217.5, 232.5, 240, 247.5, 255, 262.5, 277.5, 285,
;1237:		292.5, 300, 307.5, 322.5, 330, 337.5, 345, 352.5
;1238:	};
;1239:	*/
;1240:	vec3_t vx, vy;
;1241:	int visCount;
;1242:	int i;
;1243:
;1244:	if (lfent->lightRadius <= 1 || quality < 2) {
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
CNSTF4 1065353216
LEF4 $1146
ADDRFP4 16
INDIRI4
CNSTI4 2
GEI4 $1144
LABELV $1146
line 1245
;1245:		VectorCopy(origin, visOrigin);
ADDRFP4 12
INDIRP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 1246
;1246:		return CG_IsLFVisible(origin, origin, lfent->radius);
ADDRLP4 32
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
ADDRGP4 CG_IsLFVisible
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CVIF4 4
RETF4
ADDRGP4 $1143
JUMPV
LABELV $1144
line 1249
;1247:	}
;1248:
;1249:	visCount = 0;
ADDRLP4 28
CNSTI4 0
ASGNI4
line 1250
;1250:	for (i = 0; i < 8; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1147
line 1253
;1251:		vec3_t corner;
;1252:
;1253:		VectorCopy(origin, corner);
ADDRLP4 32
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 1254
;1254:		corner[0] += i&1? lfent->lightRadius : -lfent->lightRadius;
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1152
ADDRLP4 44
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ASGNF4
ADDRGP4 $1153
JUMPV
LABELV $1152
ADDRLP4 44
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
NEGF4
ASGNF4
LABELV $1153
ADDRLP4 32
ADDRLP4 32
INDIRF4
ADDRLP4 44
INDIRF4
ADDF4
ASGNF4
line 1255
;1255:		corner[1] += i&2? lfent->lightRadius : -lfent->lightRadius;
ADDRLP4 0
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1156
ADDRLP4 48
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ASGNF4
ADDRGP4 $1157
JUMPV
LABELV $1156
ADDRLP4 48
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
NEGF4
ASGNF4
LABELV $1157
ADDRLP4 32+4
ADDRLP4 32+4
INDIRF4
ADDRLP4 48
INDIRF4
ADDF4
ASGNF4
line 1256
;1256:		corner[2] += i&4? lfent->lightRadius : -lfent->lightRadius;
ADDRLP4 0
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $1160
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ASGNF4
ADDRGP4 $1161
JUMPV
LABELV $1160
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
NEGF4
ASGNF4
LABELV $1161
ADDRLP4 32+8
ADDRLP4 32+8
INDIRF4
ADDRLP4 52
INDIRF4
ADDF4
ASGNF4
line 1257
;1257:		if (!CG_IsLFVisible(origin, corner, 1.8 * lfent->radius)) continue;	// 1.8 = rough approx. of sqrt(3)
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 32
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
CNSTF4 1072064102
MULF4
ARGF4
ADDRLP4 56
ADDRGP4 CG_IsLFVisible
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
NEI4 $1162
ADDRGP4 $1148
JUMPV
LABELV $1162
line 1258
;1258:		visCount++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1259
;1259:	}
LABELV $1148
line 1250
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 8
LTI4 $1147
line 1260
;1260:	if (visCount == 0) {
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $1164
line 1261
;1261:		VectorClear(visOrigin);
ADDRLP4 32
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 36
CNSTF4 0
ASGNF4
ADDRLP4 32
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 32
INDIRP4
ADDRLP4 36
INDIRF4
ASGNF4
line 1262
;1262:		return 0;
CNSTF4 0
RETF4
ADDRGP4 $1143
JUMPV
LABELV $1164
line 1264
;1263:	}
;1264:	else if (visCount == 8) {
ADDRLP4 28
INDIRI4
CNSTI4 8
NEI4 $1166
line 1265
;1265:		VectorCopy(origin, visOrigin);
ADDRFP4 12
INDIRP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 1266
;1266:		return 1;
CNSTF4 1065353216
RETF4
ADDRGP4 $1143
JUMPV
LABELV $1166
line 1269
;1267:	}
;1268:
;1269:	{
line 1272
;1270:		vec3_t vz;
;1271:
;1272:		VectorSubtract(origin, cg.refdef.vieworg, vz);
ADDRLP4 44
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 32
ADDRLP4 44
INDIRP4
INDIRF4
ADDRGP4 cg+109260+24
INDIRF4
SUBF4
ASGNF4
ADDRLP4 32+4
ADDRLP4 44
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 cg+109260+24+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 32+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 cg+109260+24+8
INDIRF4
SUBF4
ASGNF4
line 1273
;1273:		VectorNormalize(vz);
ADDRLP4 32
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 1274
;1274:		CrossProduct(vz, axisDefault[2], vx);
ADDRLP4 32
ARGP4
ADDRGP4 axisDefault+24
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 1275
;1275:		VectorNormalize(vx);
ADDRLP4 4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 1276
;1276:		CrossProduct(vz, vx, vy);
ADDRLP4 32
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 16
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 1278
;1277:		// NOTE: the handedness of (vx, vy, vz) is not important
;1278:	}
line 1280
;1279:	
;1280:	visCount = 0;
ADDRLP4 28
CNSTI4 0
ASGNI4
line 1281
;1281:	VectorClear(visOrigin);
ADDRLP4 32
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 36
CNSTF4 0
ASGNF4
ADDRLP4 32
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 32
INDIRP4
ADDRLP4 36
INDIRF4
ASGNF4
line 1283
;1282:	//offset = 45 * random();
;1283:	for (i = 0; i < NUMVISSAMPLES; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1179
line 1286
;1284:		vec3_t end;
;1285:
;1286:		VectorCopy(origin, end);
ADDRLP4 40
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 1287
;1287:		{
line 1306
;1288:			float angle;
;1289:			float radius;
;1290:			float x, y;
;1291:
;1292:			/*
;1293:			if (i == 8) {
;1294:				if (visCount <= 0) return 0;
;1295:				if (visCount >= 8) {
;1296:					VectorCopy(origin, visOrigin);
;1297:					return 1;
;1298:				}
;1299:			}
;1300:			*/
;1301:			/*
;1302:			angle = (M_PI/180) * (angleTab[i] + offset);
;1303:			x = 0.95 * lfent->lightRadius * cos(angle);
;1304:			y = 0.95 * lfent->lightRadius * sin(angle);
;1305:			*/
;1306:			angle = (2*M_PI) * /*random()*/i / (float)NUMVISSAMPLES;
ADDRLP4 60
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1040231933
MULF4
ASGNF4
line 1307
;1307:			radius = 0.95 * lfent->lightRadius * sqrt(random());
ADDRLP4 68
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 68
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 68
INDIRU4
CNSTU4 1
BANDU4
CVUI4 4
CVIF4 4
ADDF4
CNSTF4 796917760
MULF4
ARGF4
ADDRLP4 72
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 64
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
CNSTF4 1064514355
MULF4
ADDRLP4 72
INDIRF4
MULF4
ASGNF4
line 1309
;1308:
;1309:			x = radius * cos(angle);
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 76
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 52
ADDRLP4 64
INDIRF4
ADDRLP4 76
INDIRF4
MULF4
ASGNF4
line 1310
;1310:			y = radius * sin(angle);
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 80
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 56
ADDRLP4 64
INDIRF4
ADDRLP4 80
INDIRF4
MULF4
ASGNF4
line 1312
;1311:
;1312:			VectorMA(end, x, vx, end);
ADDRLP4 40
ADDRLP4 40
INDIRF4
ADDRLP4 4
INDIRF4
ADDRLP4 52
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 40+4
ADDRLP4 40+4
INDIRF4
ADDRLP4 4+4
INDIRF4
ADDRLP4 52
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 40+8
ADDRLP4 40+8
INDIRF4
ADDRLP4 4+8
INDIRF4
ADDRLP4 52
INDIRF4
MULF4
ADDF4
ASGNF4
line 1313
;1313:			VectorMA(end, y, vy, end);
ADDRLP4 40
ADDRLP4 40
INDIRF4
ADDRLP4 16
INDIRF4
ADDRLP4 56
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 40+4
ADDRLP4 40+4
INDIRF4
ADDRLP4 16+4
INDIRF4
ADDRLP4 56
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 40+8
ADDRLP4 40+8
INDIRF4
ADDRLP4 16+8
INDIRF4
ADDRLP4 56
INDIRF4
MULF4
ADDF4
ASGNF4
line 1314
;1314:		}
line 1316
;1315:
;1316:		if (!CG_IsLFVisible(origin, end, lfent->radius)) continue;
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 40
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ARGF4
ADDRLP4 52
ADDRGP4 CG_IsLFVisible
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $1195
ADDRGP4 $1180
JUMPV
LABELV $1195
line 1318
;1317:
;1318:		VectorAdd(visOrigin, end, visOrigin);
ADDRLP4 56
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRF4
ADDRLP4 40
INDIRF4
ADDF4
ASGNF4
ADDRLP4 60
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 40+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 64
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 64
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 40+8
INDIRF4
ADDF4
ASGNF4
line 1319
;1319:		visCount++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1320
;1320:	}
LABELV $1180
line 1283
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 50
LTI4 $1179
line 1322
;1321:
;1322:	if (visCount > 0) {
ADDRLP4 28
INDIRI4
CNSTI4 0
LEI4 $1199
line 1323
;1323:		_VectorScale(visOrigin, 1.0 / visCount, visOrigin);
ADDRLP4 40
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
ARGP4
CNSTF4 1065353216
ADDRLP4 28
INDIRI4
CVIF4 4
DIVF4
ARGF4
ADDRLP4 40
INDIRP4
ARGP4
ADDRGP4 _VectorScale
CALLV
pop
line 1324
;1324:	}
LABELV $1199
line 1326
;1325:
;1326:	return (float)visCount / (float)NUMVISSAMPLES;
ADDRLP4 28
INDIRI4
CVIF4 4
CNSTF4 1017370378
MULF4
RETF4
LABELV $1143
endproc CG_ComputeVisibleLightSample 92 12
proc CG_SetVisibleLightSample 28 0
line 1336
;1327:}
;1328:#endif
;1329:
;1330:/*
;1331:=====================
;1332:JUHOX: CG_SetVisibleLightSample
;1333:=====================
;1334:*/
;1335:#if MAPLENSFLARES
;1336:static void CG_SetVisibleLightSample(lensFlareEntity_t* lfent, float visibleLight, const vec3_t visibleOrigin) {
line 1339
;1337:	vec3_t vorg;
;1338:
;1339:	lfent->lib[lfent->libPos].light = visibleLight;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 12
INDIRP4
CNSTI4 56
ADDP4
ADDP4
ADDRFP4 4
INDIRF4
ASGNF4
line 1340
;1340:	VectorCopy(visibleOrigin, vorg);
ADDRLP4 0
ADDRFP4 8
INDIRP4
INDIRB
ASGNB 12
line 1342
;1341:#if ESCAPE_MODE
;1342:	if (cgs.gametype == GT_EFH) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 9
NEI4 $1202
line 1343
;1343:		vorg[0] += cg.currentReferenceX;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRGP4 cg+107588
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1344
;1344:		vorg[1] += cg.currentReferenceY;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRGP4 cg+107592
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1345
;1345:		vorg[2] += cg.currentReferenceZ;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRGP4 cg+107596
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1346
;1346:	}
LABELV $1202
line 1348
;1347:#endif
;1348:	VectorCopy(vorg, lfent->lib[lfent->libPos].origin);
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 16
INDIRP4
CNSTI4 56
ADDP4
ADDP4
CNSTI4 4
ADDP4
ADDRLP4 0
INDIRB
ASGNB 12
line 1349
;1349:	lfent->libPos++;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1350
;1350:	if (lfent->libPos >= LIGHT_INTEGRATION_BUFFER_SIZE) {
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 8
LTI4 $1210
line 1351
;1351:		lfent->libPos = 0;
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 1352
;1352:	}
LABELV $1210
line 1353
;1353:	lfent->libNumEntries++;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1354
;1354:}
LABELV $1201
endproc CG_SetVisibleLightSample 28 0
proc CG_GetVisibleLight 52 0
line 1363
;1355:#endif
;1356:
;1357:/*
;1358:=====================
;1359:JUHOX: CG_GetVisibleLight
;1360:=====================
;1361:*/
;1362:#if MAPLENSFLARES
;1363:static float CG_GetVisibleLight(lensFlareEntity_t* lfent, vec3_t visibleOrigin) {
line 1370
;1364:	int maxLibEntries;
;1365:	int i;
;1366:	float visLight;
;1367:	vec3_t visOrigin;
;1368:	int numVisPoints;
;1369:
;1370:	if (lfent->lightRadius < 1) {
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
CNSTF4 1065353216
GEF4 $1213
line 1371
;1371:		maxLibEntries = 1;
ADDRLP4 24
CNSTI4 1
ASGNI4
line 1372
;1372:	}
ADDRGP4 $1214
JUMPV
LABELV $1213
line 1373
;1373:	else if (cg.viewMovement > 1 || lfent->lock) {
ADDRGP4 cg+109652
INDIRF4
CNSTF4 1065353216
GTF4 $1218
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1215
LABELV $1218
line 1374
;1374:		maxLibEntries = LIGHT_INTEGRATION_BUFFER_SIZE / 2;
ADDRLP4 24
CNSTI4 4
ASGNI4
line 1375
;1375:	}
ADDRGP4 $1216
JUMPV
LABELV $1215
line 1376
;1376:	else {
line 1377
;1377:		maxLibEntries = LIGHT_INTEGRATION_BUFFER_SIZE;
ADDRLP4 24
CNSTI4 8
ASGNI4
line 1378
;1378:	}
LABELV $1216
LABELV $1214
line 1380
;1379:
;1380:	if (lfent->libNumEntries > maxLibEntries) {
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
LEI4 $1219
line 1381
;1381:		lfent->libNumEntries = maxLibEntries;
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
ADDRLP4 24
INDIRI4
ASGNI4
line 1382
;1382:	}
LABELV $1219
line 1384
;1383:
;1384:	visLight = 0;
ADDRLP4 20
CNSTF4 0
ASGNF4
line 1385
;1385:	VectorClear(visOrigin);
ADDRLP4 28
CNSTF4 0
ASGNF4
ADDRLP4 0+8
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 28
INDIRF4
ASGNF4
line 1386
;1386:	numVisPoints = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 1387
;1387:	for (i = 1; i <= lfent->libNumEntries; i++) {
ADDRLP4 12
CNSTI4 1
ASGNI4
ADDRGP4 $1226
JUMPV
LABELV $1223
line 1390
;1388:		const lightSample_t* sample;
;1389:
;1390:		sample = &lfent->lib[(lfent->libPos - i) & (LIGHT_INTEGRATION_BUFFER_SIZE - 1)];
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
ADDRLP4 36
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
SUBI4
CNSTI4 7
BANDI4
CNSTI4 4
LSHI4
ADDRLP4 36
INDIRP4
CNSTI4 56
ADDP4
ADDP4
ASGNP4
line 1391
;1391:		if (sample->light > 0) {
ADDRLP4 32
INDIRP4
INDIRF4
CNSTF4 0
LEF4 $1227
line 1394
;1392:			vec3_t sorg;
;1393:
;1394:			visLight += sample->light;
ADDRLP4 20
ADDRLP4 20
INDIRF4
ADDRLP4 32
INDIRP4
INDIRF4
ADDF4
ASGNF4
line 1395
;1395:			VectorCopy(sample->origin, sorg);
ADDRLP4 40
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRB
ASGNB 12
line 1397
;1396:#if ESCAPE_MODE
;1397:			if (cgs.gametype == GT_EFH) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 9
NEI4 $1229
line 1398
;1398:				sorg[0] -= cg.currentReferenceX;
ADDRLP4 40
ADDRLP4 40
INDIRF4
ADDRGP4 cg+107588
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 1399
;1399:				sorg[1] -= cg.currentReferenceY;
ADDRLP4 40+4
ADDRLP4 40+4
INDIRF4
ADDRGP4 cg+107592
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 1400
;1400:				sorg[2] -= cg.currentReferenceZ;
ADDRLP4 40+8
ADDRLP4 40+8
INDIRF4
ADDRGP4 cg+107596
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 1401
;1401:			}
LABELV $1229
line 1403
;1402:#endif
;1403:			VectorAdd(visOrigin, sorg, visOrigin);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 40
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 40+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 40+8
INDIRF4
ADDF4
ASGNF4
line 1404
;1404:			numVisPoints++;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1405
;1405:		}
LABELV $1227
line 1406
;1406:	}
LABELV $1224
line 1387
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1226
ADDRLP4 12
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
LEI4 $1223
line 1407
;1407:	if (lfent->libNumEntries > 0) visLight /= lfent->libNumEntries;
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1243
ADDRLP4 20
ADDRLP4 20
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
DIVF4
ASGNF4
LABELV $1243
line 1408
;1408:	if (numVisPoints > 0) {
ADDRLP4 16
INDIRI4
CNSTI4 0
LEI4 $1245
line 1409
;1409:		VectorScale(visOrigin, 1.0 / numVisPoints, visibleOrigin);
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
ADDRLP4 16
INDIRI4
CVIF4 4
DIVF4
MULF4
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0+4
INDIRF4
CNSTF4 1065353216
ADDRLP4 16
INDIRI4
CVIF4 4
DIVF4
MULF4
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
ADDRLP4 16
INDIRI4
CVIF4 4
DIVF4
MULF4
ASGNF4
line 1410
;1410:	}
ADDRGP4 $1246
JUMPV
LABELV $1245
line 1411
;1411:	else {
line 1412
;1412:		VectorCopy(visOrigin, visibleOrigin);
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRB
ASGNB 12
line 1413
;1413:	}
LABELV $1246
line 1414
;1414:	return visLight;
ADDRLP4 20
INDIRF4
RETF4
LABELV $1212
endproc CG_GetVisibleLight 52 0
proc CG_AddMapLensFlares 188 28
line 1425
;1415:}
;1416:#endif
;1417:
;1418:/*
;1419:=====================
;1420:JUHOX: CG_AddMapLensFlares
;1421:=====================
;1422:*/
;1423:#if MAPLENSFLARES
;1424:#define SPRITE_DISTANCE 8
;1425:static void CG_AddMapLensFlares(void) {
line 1428
;1426:	int i;
;1427:
;1428:	cg.viewMovement = Distance(cg.refdef.vieworg, cg.lastViewOrigin);
ADDRGP4 cg+109260+24
ARGP4
ADDRGP4 cg+109640
ARGP4
ADDRLP4 4
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRGP4 cg+109652
ADDRLP4 4
INDIRF4
ASGNF4
line 1429
;1429:	if (cg.viewMovement > 0) {
ADDRGP4 cg+109652
INDIRF4
CNSTF4 0
LEF4 $1254
line 1430
;1430:		cg.numFramesWithoutViewMovement = 0;
ADDRGP4 cg+109656
CNSTI4 0
ASGNI4
line 1431
;1431:	}
ADDRGP4 $1255
JUMPV
LABELV $1254
line 1432
;1432:	else {
line 1433
;1433:		cg.numFramesWithoutViewMovement++;
ADDRLP4 8
ADDRGP4 cg+109656
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1434
;1434:	}
LABELV $1255
line 1436
;1435:
;1436:	if (cgs.editMode == EM_mlf) {
ADDRGP4 cgs+31684
INDIRI4
CNSTI4 1
NEI4 $1259
line 1437
;1437:		if (cg.lfEditor.drawMode == LFEDM_none) {
ADDRGP4 cg+109660+4
INDIRI4
CNSTI4 2
NEI4 $1262
line 1438
;1438:			if (!cg.lfEditor.selectedLFEnt && cg.lfEditor.markedLFEnt >= 0) {
ADDRGP4 cg+109660
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1249
ADDRGP4 cg+109660+44
INDIRI4
CNSTI4 0
LTI4 $1249
line 1439
;1439:				CG_AddLensFlareMarker(cg.lfEditor.markedLFEnt);
ADDRGP4 cg+109660+44
INDIRI4
ARGI4
ADDRGP4 CG_AddLensFlareMarker
CALLV
pop
line 1440
;1440:			}
line 1441
;1441:			return;
ADDRGP4 $1249
JUMPV
LABELV $1262
line 1443
;1442:		}
;1443:		if (cg.lfEditor.drawMode == LFEDM_marks) {
ADDRGP4 cg+109660+4
INDIRI4
CNSTI4 1
NEI4 $1260
line 1446
;1444:			int selectedLFEntNum;
;1445:
;1446:			selectedLFEntNum = cg.lfEditor.selectedLFEnt - cgs.lensFlareEntities;
ADDRLP4 8
ADDRGP4 cg+109660
INDIRP4
CVPU4 4
ADDRGP4 cgs+562800
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 184
DIVI4
ASGNI4
line 1447
;1447:			for (i = 0; i < cgs.numLensFlareEntities; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1282
JUMPV
LABELV $1279
line 1448
;1448:				if (i == selectedLFEntNum) continue;
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $1284
ADDRGP4 $1280
JUMPV
LABELV $1284
line 1450
;1449:
;1450:				CG_AddLensFlareMarker(i);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_AddLensFlareMarker
CALLV
pop
line 1451
;1451:			}
LABELV $1280
line 1447
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1282
ADDRLP4 0
INDIRI4
ADDRGP4 cgs+562612
INDIRI4
LTI4 $1279
line 1452
;1452:			return;
ADDRGP4 $1249
JUMPV
line 1454
;1453:		}
;1454:	}
LABELV $1259
line 1456
;1455:	else if (
;1456:		!cg_lensFlare.integer ||
ADDRGP4 cg_lensFlare+12
INDIRI4
CNSTI4 0
EQI4 $1291
ADDRGP4 cg_mapFlare+12
INDIRI4
CNSTI4 0
NEI4 $1286
ADDRGP4 cg_sunFlare+12
INDIRI4
CNSTI4 0
NEI4 $1286
LABELV $1291
line 1461
;1457:		(
;1458:			!cg_mapFlare.integer &&
;1459:			!cg_sunFlare.integer
;1460:		)
;1461:	) {
line 1462
;1462:		return;
ADDRGP4 $1249
JUMPV
LABELV $1286
LABELV $1260
line 1465
;1463:	}
;1464:
;1465:	if (cg.viewMode == VIEW_scanner) return;
ADDRGP4 cg+107628
INDIRI4
CNSTI4 1
NEI4 $1292
ADDRGP4 $1249
JUMPV
LABELV $1292
line 1466
;1466:	if (cg.clientFrame < 5) return;
ADDRGP4 cg
INDIRI4
CNSTI4 5
GEI4 $1295
ADDRGP4 $1249
JUMPV
LABELV $1295
line 1468
;1467:
;1468:	for (i = -1; i < cgs.numLensFlareEntities; i++) {
ADDRLP4 0
CNSTI4 -1
ASGNI4
ADDRGP4 $1300
JUMPV
LABELV $1297
line 1487
;1469:		lensFlareEntity_t* lfent;
;1470:		const lensFlareEffect_t* lfeff;
;1471:		vec3_t origin;
;1472:		int quality;
;1473:		float distanceSqr;
;1474:		float distance;
;1475:		vec3_t dir;
;1476:		vec3_t angles;
;1477:		float cosViewAngle;
;1478:		float viewAngle;
;1479:		float angleToLightSource;
;1480:		vec3_t virtualOrigin;
;1481:		vec3_t visibleOrigin;
;1482:		float visibleLight;
;1483:		float alpha;
;1484:		vec3_t center;
;1485:		int j;
;1486:
;1487:		if (i < 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $1302
line 1488
;1488:			if (!cg_sunFlare.integer && cgs.editMode != EM_mlf) continue;
ADDRGP4 cg_sunFlare+12
INDIRI4
CNSTI4 0
NEI4 $1304
ADDRGP4 cgs+31684
INDIRI4
CNSTI4 1
EQI4 $1304
ADDRGP4 $1298
JUMPV
LABELV $1304
line 1490
;1489:
;1490:			lfent = &cgs.sunFlare;
ADDRLP4 28
ADDRGP4 cgs+562616
ASGNP4
line 1491
;1491:			lfeff = lfent->lfeff;
ADDRLP4 8
ADDRLP4 28
INDIRP4
CNSTI4 44
ADDP4
INDIRP4
ASGNP4
line 1492
;1492:			if (!lfeff) continue;
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1309
ADDRGP4 $1298
JUMPV
LABELV $1309
line 1494
;1493:
;1494:			VectorAdd(lfent->origin, cg.refdef.vieworg, origin);
ADDRLP4 72
ADDRLP4 28
INDIRP4
INDIRF4
ADDRGP4 cg+109260+24
INDIRF4
ADDF4
ASGNF4
ADDRLP4 72+4
ADDRLP4 28
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 cg+109260+24+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 72+8
ADDRLP4 28
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 cg+109260+24+8
INDIRF4
ADDF4
ASGNF4
line 1496
;1495:
;1496:			quality = cg_sunFlare.integer;
ADDRLP4 120
ADDRGP4 cg_sunFlare+12
INDIRI4
ASGNI4
line 1497
;1497:		}
ADDRGP4 $1303
JUMPV
LABELV $1302
line 1498
;1498:		else {
line 1499
;1499:			if (!cg_mapFlare.integer && cgs.editMode != EM_mlf) continue;
ADDRGP4 cg_mapFlare+12
INDIRI4
CNSTI4 0
NEI4 $1322
ADDRGP4 cgs+31684
INDIRI4
CNSTI4 1
EQI4 $1322
ADDRGP4 $1298
JUMPV
LABELV $1322
line 1501
;1500:
;1501:			lfent = &cgs.lensFlareEntities[i];
ADDRLP4 28
ADDRLP4 0
INDIRI4
CNSTI4 184
MULI4
ADDRGP4 cgs+562800
ADDP4
ASGNP4
line 1502
;1502:			lfeff = lfent->lfeff;
ADDRLP4 8
ADDRLP4 28
INDIRP4
CNSTI4 44
ADDP4
INDIRP4
ASGNP4
line 1503
;1503:			if (!lfeff) continue;
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1327
ADDRGP4 $1298
JUMPV
LABELV $1327
line 1511
;1504:
;1505:			/*
;1506:			if (cgs.editMode == EM_mlf && !cg.lfEditor.selectedLFEnt && cg.lfEditor.markedLFEnt == i) {
;1507:				CG_AddLensFlareMarker(i);
;1508:			}
;1509:			*/
;1510:
;1511:			CG_LFEntOrigin(lfent, origin);
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 72
ARGP4
ADDRGP4 CG_LFEntOrigin
CALLV
pop
line 1513
;1512:
;1513:			quality = cg_mapFlare.integer;
ADDRLP4 120
ADDRGP4 cg_mapFlare+12
INDIRI4
ASGNI4
line 1514
;1514:		}
LABELV $1303
line 1516
;1515:
;1516:		distanceSqr = DistanceSquared(origin, cg.refdef.vieworg);
ADDRLP4 72
ARGP4
ADDRGP4 cg+109260+24
ARGP4
ADDRLP4 124
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 116
ADDRLP4 124
INDIRF4
ASGNF4
line 1517
;1517:		if (lfeff->range > 0 && distanceSqr >= lfeff->rangeSqr) {
ADDRLP4 8
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
CNSTF4 0
LEF4 $1332
ADDRLP4 116
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
LTF4 $1332
LABELV $1334
line 1519
;1518:			SkipLF:
;1519:			lfent->libNumEntries = 0;
ADDRLP4 28
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 1520
;1520:			continue;
ADDRGP4 $1298
JUMPV
LABELV $1332
line 1522
;1521:		}
;1522:		if (distanceSqr < Square(16)) goto SkipLF;
ADDRLP4 116
INDIRF4
CNSTF4 1132462080
GEF4 $1335
ADDRGP4 $1334
JUMPV
LABELV $1335
line 1524
;1523:
;1524:		VectorSubtract(origin, cg.refdef.vieworg, dir);
ADDRLP4 12
ADDRLP4 72
INDIRF4
ADDRGP4 cg+109260+24
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 72+4
INDIRF4
ADDRGP4 cg+109260+24+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 72+8
INDIRF4
ADDRGP4 cg+109260+24+8
INDIRF4
SUBF4
ASGNF4
line 1526
;1525:
;1526:		distance = VectorNormalize(dir);
ADDRLP4 12
ARGP4
ADDRLP4 132
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 56
ADDRLP4 132
INDIRF4
ASGNF4
line 1527
;1527:		cosViewAngle = DotProduct(dir, cg.refdef.viewaxis[0]);
ADDRLP4 108
ADDRLP4 12
INDIRF4
ADDRGP4 cg+109260+36
INDIRF4
MULF4
ADDRLP4 12+4
INDIRF4
ADDRGP4 cg+109260+36+4
INDIRF4
MULF4
ADDF4
ADDRLP4 12+8
INDIRF4
ADDRGP4 cg+109260+36+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 1528
;1528:		viewAngle = acos(cosViewAngle) * (180.0 / M_PI);
ADDRLP4 108
INDIRF4
ARGF4
ADDRLP4 136
ADDRGP4 acos
CALLF4
ASGNF4
ADDRLP4 112
ADDRLP4 136
INDIRF4
CNSTF4 1113927393
MULF4
ASGNF4
line 1529
;1529:		if (viewAngle >= 89.99) goto SkipLF;
ADDRLP4 112
INDIRF4
CNSTF4 1119091425
LTF4 $1359
ADDRGP4 $1334
JUMPV
LABELV $1359
line 1532
;1530:
;1531:		// for spotlights
;1532:		angleToLightSource = acos(-DotProduct(dir, lfent->dir)) * (180.0 / M_PI);
ADDRLP4 12
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
MULF4
ADDRLP4 12+4
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 12+8
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
MULF4
ADDF4
NEGF4
ARGF4
ADDRLP4 144
ADDRGP4 acos
CALLF4
ASGNF4
ADDRLP4 60
ADDRLP4 144
INDIRF4
CNSTF4 1113927393
MULF4
ASGNF4
line 1533
;1533:		if (angleToLightSource > lfent->maxVisAngle) goto SkipLF;
ADDRLP4 60
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
LEF4 $1363
ADDRGP4 $1334
JUMPV
LABELV $1363
line 1536
;1534:
;1535:		if (
;1536:			cg.numFramesWithoutViewMovement <= LIGHT_INTEGRATION_BUFFER_SIZE ||
ADDRGP4 cg+109656
INDIRI4
CNSTI4 8
LEI4 $1369
ADDRLP4 28
INDIRP4
CNSTI4 12
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1369
ADDRLP4 28
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 0
GTI4 $1365
LABELV $1369
line 1539
;1537:			lfent->lock ||
;1538:			lfent->libNumEntries <= 0
;1539:		) {
line 1542
;1540:			float vls;
;1541:
;1542:			vls = CG_ComputeVisibleLightSample(lfent, origin, distance, visibleOrigin, quality);
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 72
ARGP4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 96
ARGP4
ADDRLP4 120
INDIRI4
ARGI4
ADDRLP4 156
ADDRGP4 CG_ComputeVisibleLightSample
CALLF4
ASGNF4
ADDRLP4 152
ADDRLP4 156
INDIRF4
ASGNF4
line 1543
;1543:			CG_SetVisibleLightSample(lfent, vls, visibleOrigin);
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 152
INDIRF4
ARGF4
ADDRLP4 96
ARGP4
ADDRGP4 CG_SetVisibleLightSample
CALLV
pop
line 1544
;1544:		}
LABELV $1365
line 1546
;1545:
;1546:		VectorCopy(origin, visibleOrigin);
ADDRLP4 96
ADDRLP4 72
INDIRB
ASGNB 12
line 1547
;1547:		visibleLight = CG_GetVisibleLight(lfent, visibleOrigin);
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 96
ARGP4
ADDRLP4 152
ADDRGP4 CG_GetVisibleLight
CALLF4
ASGNF4
ADDRLP4 64
ADDRLP4 152
INDIRF4
ASGNF4
line 1548
;1548:		if (visibleLight <= 0) continue;
ADDRLP4 64
INDIRF4
CNSTF4 0
GTF4 $1370
ADDRGP4 $1298
JUMPV
LABELV $1370
line 1550
;1549:
;1550:		VectorSubtract(visibleOrigin, cg.refdef.vieworg, dir);
ADDRLP4 12
ADDRLP4 96
INDIRF4
ADDRGP4 cg+109260+24
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 96+4
INDIRF4
ADDRGP4 cg+109260+24+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 96+8
INDIRF4
ADDRGP4 cg+109260+24+8
INDIRF4
SUBF4
ASGNF4
line 1551
;1551:		VectorNormalize(dir);
ADDRLP4 12
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 1552
;1552:		vectoangles(dir, angles);
ADDRLP4 12
ARGP4
ADDRLP4 32
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 1553
;1553:		angles[YAW] = AngleSubtract(angles[YAW], cg.predictedPlayerState.viewangles[YAW]);
ADDRLP4 32+4
INDIRF4
ARGF4
ADDRGP4 cg+107688+152+4
INDIRF4
ARGF4
ADDRLP4 156
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 32+4
ADDRLP4 156
INDIRF4
ASGNF4
line 1554
;1554:		angles[PITCH] = AngleSubtract(angles[PITCH], cg.predictedPlayerState.viewangles[PITCH]);
ADDRLP4 32
INDIRF4
ARGF4
ADDRGP4 cg+107688+152
INDIRF4
ARGF4
ADDRLP4 160
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 32
ADDRLP4 160
INDIRF4
ASGNF4
line 1556
;1555:
;1556:		VectorMA(cg.refdef.vieworg, SPRITE_DISTANCE / cosViewAngle, dir, virtualOrigin);
ADDRLP4 84
ADDRGP4 cg+109260+24
INDIRF4
ADDRLP4 12
INDIRF4
CNSTF4 1090519040
ADDRLP4 108
INDIRF4
DIVF4
MULF4
ADDF4
ASGNF4
ADDRLP4 84+4
ADDRGP4 cg+109260+24+4
INDIRF4
ADDRLP4 12+4
INDIRF4
CNSTF4 1090519040
ADDRLP4 108
INDIRF4
DIVF4
MULF4
ADDF4
ASGNF4
ADDRLP4 84+8
ADDRGP4 cg+109260+24+8
INDIRF4
ADDRLP4 12+8
INDIRF4
CNSTF4 1090519040
ADDRLP4 108
INDIRF4
DIVF4
MULF4
ADDF4
ASGNF4
line 1557
;1557:		if (lfeff->range < 0) {
ADDRLP4 8
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
CNSTF4 0
GEF4 $1403
line 1558
;1558:			alpha = -lfeff->range / distance;
ADDRLP4 68
ADDRLP4 8
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
NEGF4
ADDRLP4 56
INDIRF4
DIVF4
ASGNF4
line 1559
;1559:		}
ADDRGP4 $1404
JUMPV
LABELV $1403
line 1560
;1560:		else {
line 1561
;1561:			alpha = 1.0 - distance / lfeff->range;
ADDRLP4 68
CNSTF4 1065353216
ADDRLP4 56
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
DIVF4
SUBF4
ASGNF4
line 1562
;1562:		}
LABELV $1404
line 1572
;1563:
;1564:		/*
;1565:		if (fabs(angles[YAW]) > 0.5 * cg.refdef.fov_x) {
;1566:			alpha *= 1.0 - (fabs(angles[YAW]) - 0.5 * cg.refdef.fov_x) / (90 - 0.5 * cg.refdef.fov_x);
;1567:		}
;1568:		if (fabs(angles[PITCH]) > 0.5 * cg.refdef.fov_y) {
;1569:			alpha *= 1.0 - (fabs(angles[PITCH]) - 0.5 * cg.refdef.fov_y) / (90 - 0.5 * cg.refdef.fov_y);
;1570:		}
;1571:		*/
;1572:		if (viewAngle > 0.5 * cg.refdef.fov_x) {
ADDRLP4 112
INDIRF4
ADDRGP4 cg+109260+16
INDIRF4
CNSTF4 1056964608
MULF4
LEF4 $1405
line 1573
;1573:			alpha *= 1.0 - (viewAngle - 0.5 * cg.refdef.fov_x) / (90 - 0.5 * cg.refdef.fov_x);
ADDRLP4 68
ADDRLP4 68
INDIRF4
CNSTF4 1065353216
ADDRLP4 112
INDIRF4
ADDRGP4 cg+109260+16
INDIRF4
CNSTF4 1056964608
MULF4
SUBF4
CNSTF4 1119092736
ADDRGP4 cg+109260+16
INDIRF4
CNSTF4 1056964608
MULF4
SUBF4
DIVF4
SUBF4
MULF4
ASGNF4
line 1574
;1574:		}
LABELV $1405
line 1576
;1575:
;1576:		VectorMA(cg.refdef.vieworg, SPRITE_DISTANCE, cg.refdef.viewaxis[0], center);
ADDRLP4 44
ADDRGP4 cg+109260+24
INDIRF4
ADDRGP4 cg+109260+36
INDIRF4
CNSTF4 1090519040
MULF4
ADDF4
ASGNF4
ADDRLP4 44+4
ADDRGP4 cg+109260+24+4
INDIRF4
ADDRGP4 cg+109260+36+4
INDIRF4
CNSTF4 1090519040
MULF4
ADDF4
ASGNF4
ADDRLP4 44+8
ADDRGP4 cg+109260+24+8
INDIRF4
ADDRGP4 cg+109260+36+8
INDIRF4
CNSTF4 1090519040
MULF4
ADDF4
ASGNF4
line 1577
;1577:		VectorSubtract(virtualOrigin, center, dir);
ADDRLP4 12
ADDRLP4 84
INDIRF4
ADDRLP4 44
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 84+4
INDIRF4
ADDRLP4 44+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 84+8
INDIRF4
ADDRLP4 44+8
INDIRF4
SUBF4
ASGNF4
line 1579
;1578:		
;1579:		{
line 1582
;1580:			vec3_t v;
;1581:
;1582:			VectorRotate(dir, cg.refdef.viewaxis, v);
ADDRLP4 12
ARGP4
ADDRGP4 cg+109260+36
ARGP4
ADDRLP4 168
ARGP4
ADDRGP4 VectorRotate
CALLV
pop
line 1583
;1583:			angles[ROLL] = 90.0 - atan2(v[2], v[1]) * (180.0/M_PI);
ADDRLP4 168+8
INDIRF4
ARGF4
ADDRLP4 168+4
INDIRF4
ARGF4
ADDRLP4 180
ADDRGP4 atan2
CALLF4
ASGNF4
ADDRLP4 32+8
CNSTF4 1119092736
ADDRLP4 180
INDIRF4
CNSTF4 1113927393
MULF4
SUBF4
ASGNF4
line 1584
;1584:		}
line 1586
;1585:
;1586:		for (j = 0; j < lfeff->numLensFlares; j++) {
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRGP4 $1445
JUMPV
LABELV $1442
line 1591
;1587:			float a;
;1588:			float vl;
;1589:			const lensFlare_t* lf;
;1590:
;1591:			a = alpha;
ADDRLP4 176
ADDRLP4 68
INDIRF4
ASGNF4
line 1592
;1592:			vl = visibleLight;
ADDRLP4 172
ADDRLP4 64
INDIRF4
ASGNF4
line 1593
;1593:			lf = &lfeff->lensFlares[j];
ADDRLP4 168
ADDRLP4 24
INDIRI4
CNSTI4 60
MULI4
ADDRLP4 8
INDIRP4
CNSTI4 80
ADDP4
ADDP4
ASGNP4
line 1594
;1594:			if (lfent->angle >= 0) {
ADDRLP4 28
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
CNSTF4 0
LTF4 $1446
line 1597
;1595:				float innerAngle;
;1596:				
;1597:				innerAngle = lfent->angle * lf->entityAngleFactor;
ADDRLP4 180
ADDRLP4 28
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 168
INDIRP4
CNSTI4 52
ADDP4
INDIRF4
MULF4
ASGNF4
line 1598
;1598:				if (angleToLightSource > innerAngle) {
ADDRLP4 60
INDIRF4
ADDRLP4 180
INDIRF4
LEF4 $1448
line 1601
;1599:					float fadeAngle;
;1600:
;1601:					fadeAngle = lfeff->fadeAngle * lf->fadeAngleFactor;
ADDRLP4 184
ADDRLP4 8
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
ADDRLP4 168
INDIRP4
CNSTI4 48
ADDP4
INDIRF4
MULF4
ASGNF4
line 1602
;1602:					if (fadeAngle < 0.1) continue;
ADDRLP4 184
INDIRF4
CNSTF4 1036831949
GEF4 $1450
ADDRGP4 $1443
JUMPV
LABELV $1450
line 1603
;1603:					if (angleToLightSource >= innerAngle + fadeAngle) continue;
ADDRLP4 60
INDIRF4
ADDRLP4 180
INDIRF4
ADDRLP4 184
INDIRF4
ADDF4
LTF4 $1452
ADDRGP4 $1443
JUMPV
LABELV $1452
line 1605
;1604:
;1605:					vl *= 1.0 - (angleToLightSource - innerAngle) / fadeAngle;
ADDRLP4 172
ADDRLP4 172
INDIRF4
CNSTF4 1065353216
ADDRLP4 60
INDIRF4
ADDRLP4 180
INDIRF4
SUBF4
ADDRLP4 184
INDIRF4
DIVF4
SUBF4
MULF4
ASGNF4
line 1606
;1606:				}
LABELV $1448
line 1607
;1607:			}
LABELV $1446
line 1608
;1608:			if (lf->intensityThreshold > 0) {
ADDRLP4 168
INDIRP4
CNSTI4 56
ADDP4
INDIRF4
CNSTF4 0
LEF4 $1454
line 1612
;1609:				float threshold;
;1610:				float intensity;
;1611:
;1612:				threshold = lf->intensityThreshold;
ADDRLP4 184
ADDRLP4 168
INDIRP4
CNSTI4 56
ADDP4
INDIRF4
ASGNF4
line 1613
;1613:				intensity = a * vl;
ADDRLP4 180
ADDRLP4 176
INDIRF4
ADDRLP4 172
INDIRF4
MULF4
ASGNF4
line 1614
;1614:				if (intensity < threshold) continue;
ADDRLP4 180
INDIRF4
ADDRLP4 184
INDIRF4
GEF4 $1456
ADDRGP4 $1443
JUMPV
LABELV $1456
line 1615
;1615:				intensity -= threshold;
ADDRLP4 180
ADDRLP4 180
INDIRF4
ADDRLP4 184
INDIRF4
SUBF4
ASGNF4
line 1616
;1616:				if (lfeff->range >= 0) intensity /= 1 - threshold;
ADDRLP4 8
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
CNSTF4 0
LTF4 $1458
ADDRLP4 180
ADDRLP4 180
INDIRF4
CNSTF4 1065353216
ADDRLP4 184
INDIRF4
SUBF4
DIVF4
ASGNF4
LABELV $1458
line 1617
;1617:				a = intensity / vl;
ADDRLP4 176
ADDRLP4 180
INDIRF4
ADDRLP4 172
INDIRF4
DIVF4
ASGNF4
line 1618
;1618:			}
LABELV $1454
line 1619
;1619:			CG_DrawMapLensFlare(lf, distance, center, dir, angles, a, vl);
ADDRLP4 168
INDIRP4
ARGP4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 44
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 32
ARGP4
ADDRLP4 176
INDIRF4
ARGF4
ADDRLP4 172
INDIRF4
ARGF4
ADDRGP4 CG_DrawMapLensFlare
CALLV
pop
line 1620
;1620:		}
LABELV $1443
line 1586
ADDRLP4 24
ADDRLP4 24
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1445
ADDRLP4 24
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
LTI4 $1442
line 1621
;1621:	}
LABELV $1298
line 1468
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1300
ADDRLP4 0
INDIRI4
ADDRGP4 cgs+562612
INDIRI4
LTI4 $1297
line 1623
;1622:
;1623:	VectorCopy(cg.refdef.vieworg, cg.lastViewOrigin);
ADDRGP4 cg+109640
ADDRGP4 cg+109260+24
INDIRB
ASGNB 12
line 1624
;1624:}
LABELV $1249
endproc CG_AddMapLensFlares 188 28
export CG_AddLFEditorCursor
proc CG_AddLFEditorCursor 264 28
line 1633
;1625:#endif
;1626:
;1627:/*
;1628:=====================
;1629:JUHOX: CG_AddLFEditorCursor
;1630:=====================
;1631:*/
;1632:#if MAPLENSFLARES
;1633:void CG_AddLFEditorCursor(void) {
line 1638
;1634:	trace_t trace;
;1635:	vec3_t end;
;1636:	refEntity_t ent;
;1637:
;1638:	if (cgs.editMode != EM_mlf) return;
ADDRGP4 cgs+31684
INDIRI4
CNSTI4 1
EQI4 $1464
ADDRGP4 $1463
JUMPV
LABELV $1464
line 1640
;1639:
;1640:	cg.lfEditor.markedLFEnt = -1;
ADDRGP4 cg+109660+44
CNSTI4 -1
ASGNI4
line 1641
;1641:	if (!cg.lfEditor.selectedLFEnt) {
ADDRGP4 cg+109660
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1469
line 1645
;1642:		int i;
;1643:		float lowestWeight;
;1644:
;1645:		lowestWeight = 10000000.0;
ADDRLP4 212
CNSTF4 1259902592
ASGNF4
line 1646
;1646:		for (i = 0; i < cgs.numLensFlareEntities; i++) {
ADDRLP4 208
CNSTI4 0
ASGNI4
ADDRGP4 $1475
JUMPV
LABELV $1472
line 1654
;1647:			const lensFlareEntity_t* lfent;
;1648:			vec3_t origin;
;1649:			vec3_t dir;
;1650:			float distance;
;1651:			float alpha;
;1652:			float weight;
;1653:
;1654:			lfent = &cgs.lensFlareEntities[i];
ADDRLP4 240
ADDRLP4 208
INDIRI4
CNSTI4 184
MULI4
ADDRGP4 cgs+562800
ADDP4
ASGNP4
line 1655
;1655:			if (!lfent->lfeff) continue;
ADDRLP4 240
INDIRP4
CNSTI4 44
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1478
ADDRGP4 $1473
JUMPV
LABELV $1478
line 1657
;1656:
;1657:			CG_LFEntOrigin(lfent, origin);
ADDRLP4 240
INDIRP4
ARGP4
ADDRLP4 228
ARGP4
ADDRGP4 CG_LFEntOrigin
CALLV
pop
line 1658
;1658:			VectorSubtract(origin, cg.refdef.vieworg, dir);
ADDRLP4 216
ADDRLP4 228
INDIRF4
ADDRGP4 cg+109260+24
INDIRF4
SUBF4
ASGNF4
ADDRLP4 216+4
ADDRLP4 228+4
INDIRF4
ADDRGP4 cg+109260+24+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 216+8
ADDRLP4 228+8
INDIRF4
ADDRGP4 cg+109260+24+8
INDIRF4
SUBF4
ASGNF4
line 1659
;1659:			distance = VectorNormalize(dir);
ADDRLP4 216
ARGP4
ADDRLP4 256
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 244
ADDRLP4 256
INDIRF4
ASGNF4
line 1660
;1660:			if (distance > 2000) continue;
ADDRLP4 244
INDIRF4
CNSTF4 1157234688
LEF4 $1492
ADDRGP4 $1473
JUMPV
LABELV $1492
line 1662
;1661:
;1662:			alpha = acos(DotProduct(dir, cg.refdef.viewaxis[0])) * (180.0 / M_PI);
ADDRLP4 216
INDIRF4
ADDRGP4 cg+109260+36
INDIRF4
MULF4
ADDRLP4 216+4
INDIRF4
ADDRGP4 cg+109260+36+4
INDIRF4
MULF4
ADDF4
ADDRLP4 216+8
INDIRF4
ADDRGP4 cg+109260+36+8
INDIRF4
MULF4
ADDF4
ARGF4
ADDRLP4 260
ADDRGP4 acos
CALLF4
ASGNF4
ADDRLP4 248
ADDRLP4 260
INDIRF4
CNSTF4 1113927393
MULF4
ASGNF4
line 1663
;1663:			if (alpha > 10.0) continue;
ADDRLP4 248
INDIRF4
CNSTF4 1092616192
LEF4 $1504
ADDRGP4 $1473
JUMPV
LABELV $1504
line 1665
;1664:
;1665:			weight = alpha * distance;
ADDRLP4 252
ADDRLP4 248
INDIRF4
ADDRLP4 244
INDIRF4
MULF4
ASGNF4
line 1666
;1666:			if (weight >= lowestWeight) continue;
ADDRLP4 252
INDIRF4
ADDRLP4 212
INDIRF4
LTF4 $1506
ADDRGP4 $1473
JUMPV
LABELV $1506
line 1673
;1667:
;1668:			/* NOTE: with this trace enabled one would not be able to select entities within solids
;1669:			CG_SmoothTrace(&trace, cg.refdef.vieworg, NULL, NULL, origin, -1, MASK_SOLID);
;1670:			if (trace.fraction < 1.0) continue;
;1671:			*/
;1672:
;1673:			lowestWeight = weight;
ADDRLP4 212
ADDRLP4 252
INDIRF4
ASGNF4
line 1674
;1674:			cg.lfEditor.markedLFEnt = i;
ADDRGP4 cg+109660+44
ADDRLP4 208
INDIRI4
ASGNI4
line 1675
;1675:		}
LABELV $1473
line 1646
ADDRLP4 208
ADDRLP4 208
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1475
ADDRLP4 208
INDIRI4
ADDRGP4 cgs+562612
INDIRI4
LTI4 $1472
line 1676
;1676:		return;
ADDRGP4 $1463
JUMPV
LABELV $1469
line 1679
;1677:	}
;1678:
;1679:	if (cg.lfEditor.editMode == LFEEM_pos) {
ADDRGP4 cg+109660+8
INDIRI4
CNSTI4 1
NEI4 $1510
line 1680
;1680:		if (cg.lfEditor.moveMode == LFEMM_coarse) {
ADDRGP4 cg+109660+12
INDIRI4
CNSTI4 0
NEI4 $1514
line 1683
;1681:			vec3_t cursor;
;1682:
;1683:			VectorMA(cg.refdef.vieworg, 10000, cg.refdef.viewaxis[0], end);
ADDRLP4 0
ADDRGP4 cg+109260+24
INDIRF4
ADDRGP4 cg+109260+36
INDIRF4
CNSTF4 1176256512
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRGP4 cg+109260+24+4
INDIRF4
ADDRGP4 cg+109260+36+4
INDIRF4
CNSTF4 1176256512
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRGP4 cg+109260+24+8
INDIRF4
ADDRGP4 cg+109260+36+8
INDIRF4
CNSTF4 1176256512
MULF4
ADDF4
ASGNF4
line 1684
;1684:			CG_SmoothTrace(&trace, cg.refdef.vieworg, NULL, NULL, end, -1, MASK_OPAQUE|CONTENTS_BODY);
ADDRLP4 152
ARGP4
ADDRGP4 cg+109260+24
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 33554457
ARGI4
ADDRGP4 CG_SmoothTrace
CALLV
pop
line 1685
;1685:			VectorMA(trace.endpos, -1, cg.refdef.viewaxis[0], cursor);
ADDRLP4 208
ADDRLP4 152+12
INDIRF4
ADDRGP4 cg+109260+36
INDIRF4
CNSTF4 3212836864
MULF4
ADDF4
ASGNF4
ADDRLP4 208+4
ADDRLP4 152+12+4
INDIRF4
ADDRGP4 cg+109260+36+4
INDIRF4
CNSTF4 3212836864
MULF4
ADDF4
ASGNF4
ADDRLP4 208+8
ADDRLP4 152+12+8
INDIRF4
ADDRGP4 cg+109260+36+8
INDIRF4
CNSTF4 3212836864
MULF4
ADDF4
ASGNF4
line 1686
;1686:			CG_SetLFEntOrigin(cg.lfEditor.selectedLFEnt, cursor);
ADDRGP4 cg+109660
INDIRP4
ARGP4
ADDRLP4 208
ARGP4
ADDRGP4 CG_SetLFEntOrigin
CALLV
pop
line 1687
;1687:		}
LABELV $1514
line 1689
;1688:		// NOTE: LFEMM_fine handled in CG_CalcViewValues()
;1689:	}
LABELV $1510
line 1691
;1690:
;1691:	CG_AddLensFlareMarker(cg.lfEditor.selectedLFEnt - cgs.lensFlareEntities);
ADDRGP4 cg+109660
INDIRP4
CVPU4 4
ADDRGP4 cgs+562800
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 184
DIVI4
ARGI4
ADDRGP4 CG_AddLensFlareMarker
CALLV
pop
line 1693
;1692:
;1693:	{
line 1696
;1694:		int i;
;1695:
;1696:		for (i = 0; i < 50; i++) {
ADDRLP4 208
CNSTI4 0
ASGNI4
LABELV $1556
line 1701
;1697:			vec3_t dir;
;1698:			float len;
;1699:			int grey;
;1700:
;1701:			dir[0] = crandom();
ADDRLP4 232
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 212
ADDRLP4 232
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 232
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
ASGNF4
line 1702
;1702:			dir[1] = crandom();
ADDRLP4 236
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 212+4
ADDRLP4 236
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 236
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
ASGNF4
line 1703
;1703:			dir[2] = crandom();
ADDRLP4 240
ADDRGP4 lrand
CALLU4
ASGNU4
ADDRLP4 212+8
ADDRLP4 240
INDIRU4
CNSTI4 1
RSHU4
CVUI4 4
CVIF4 4
CNSTF4 1073741824
MULF4
ADDRLP4 240
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
ASGNF4
line 1704
;1704:			len = VectorNormalize(dir);
ADDRLP4 212
ARGP4
ADDRLP4 244
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 228
ADDRLP4 244
INDIRF4
ASGNF4
line 1705
;1705:			if (len > 1 || len < 0.01) continue;
ADDRLP4 228
INDIRF4
CNSTF4 1065353216
GTF4 $1564
ADDRLP4 228
INDIRF4
CNSTF4 1008981770
GEF4 $1562
LABELV $1564
ADDRGP4 $1557
JUMPV
LABELV $1562
line 1707
;1706:
;1707:			CG_LFEntOrigin(cg.lfEditor.selectedLFEnt, end);
ADDRGP4 cg+109660
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_LFEntOrigin
CALLV
pop
line 1708
;1708:			VectorMA(end, cg.lfEditor.selectedLFEnt->radius, dir, end);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 212
INDIRF4
ADDRGP4 cg+109660
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 212+4
INDIRF4
ADDRGP4 cg+109660
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 212+8
INDIRF4
ADDRGP4 cg+109660
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1709
;1709:			CG_SmoothTrace(&trace, cg.refdef.vieworg, NULL, NULL, end, -1, MASK_OPAQUE|CONTENTS_BODY);
ADDRLP4 152
ARGP4
ADDRGP4 cg+109260+24
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 33554457
ARGI4
ADDRGP4 CG_SmoothTrace
CALLV
pop
line 1710
;1710:			if (trace.fraction < 1) continue;
ADDRLP4 152+8
INDIRF4
CNSTF4 1065353216
GEF4 $1577
ADDRGP4 $1557
JUMPV
LABELV $1577
line 1712
;1711:
;1712:			VectorSubtract(end, cg.refdef.vieworg, dir);
ADDRLP4 212
ADDRLP4 0
INDIRF4
ADDRGP4 cg+109260+24
INDIRF4
SUBF4
ASGNF4
ADDRLP4 212+4
ADDRLP4 0+4
INDIRF4
ADDRGP4 cg+109260+24+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 212+8
ADDRLP4 0+8
INDIRF4
ADDRGP4 cg+109260+24+8
INDIRF4
SUBF4
ASGNF4
line 1713
;1713:			VectorNormalize(dir);
ADDRLP4 212
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 1714
;1714:			VectorMA(cg.refdef.vieworg, 8, dir, end);
ADDRLP4 0
ADDRGP4 cg+109260+24
INDIRF4
ADDRLP4 212
INDIRF4
CNSTF4 1090519040
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRGP4 cg+109260+24+4
INDIRF4
ADDRLP4 212+4
INDIRF4
CNSTF4 1090519040
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRGP4 cg+109260+24+8
INDIRF4
ADDRLP4 212+8
INDIRF4
CNSTF4 1090519040
MULF4
ADDF4
ASGNF4
line 1716
;1715:
;1716:			memset(&ent, 0, sizeof(ent));
ADDRLP4 12
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1717
;1717:			ent.reType = RT_SPRITE;
ADDRLP4 12
CNSTI4 2
ASGNI4
line 1718
;1718:			VectorCopy(end, ent.origin);
ADDRLP4 12+68
ADDRLP4 0
INDIRB
ASGNB 12
line 1719
;1719:			ent.customShader = trap_R_RegisterShader("tssgroupTemporary");
ADDRGP4 $1606
ARGP4
ADDRLP4 252
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 12+112
ADDRLP4 252
INDIRI4
ASGNI4
line 1720
;1720:			grey = rand() & 0xff;
ADDRLP4 256
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 224
ADDRLP4 256
INDIRI4
CNSTI4 255
BANDI4
ASGNI4
line 1721
;1721:			ent.shaderRGBA[0] = grey;
ADDRLP4 12+116
ADDRLP4 224
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 1722
;1722:			ent.shaderRGBA[1] = grey;
ADDRLP4 12+116+1
ADDRLP4 224
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 1723
;1723:			ent.shaderRGBA[2] = grey;
ADDRLP4 12+116+2
ADDRLP4 224
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 1724
;1724:			ent.shaderRGBA[3] = 0xff;
ADDRLP4 12+116+3
CNSTU1 255
ASGNU1
line 1725
;1725:			ent.radius = 0.05;
ADDRLP4 12+132
CNSTF4 1028443341
ASGNF4
line 1726
;1726:			trap_R_AddRefEntityToScene(&ent);
ADDRLP4 12
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1727
;1727:		}
LABELV $1557
line 1696
ADDRLP4 208
ADDRLP4 208
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 208
INDIRI4
CNSTI4 50
LTI4 $1556
line 1728
;1728:	}
line 1729
;1729:}
LABELV $1463
endproc CG_AddLFEditorCursor 264 28
export CG_DrawActiveFrame
proc CG_DrawActiveFrame 100 20
line 1741
;1730:#endif
;1731:
;1732://=========================================================================
;1733:
;1734:/*
;1735:=================
;1736:CG_DrawActiveFrame
;1737:
;1738:Generates and draws a game scene and status information at the given time.
;1739:=================
;1740:*/
;1741:void CG_DrawActiveFrame( int serverTime, stereoFrame_t stereoView, qboolean demoPlayback ) {
line 1754
;1742:	int		inwater;
;1743:
;1744:#if SCREENSHOT_TOOLS	// JUHOX
;1745:	cg.stopTime = atoi(CG_ConfigString(CS_STOPTIME));
;1746:	if (cg.stopTime) {
;1747:		cg.timeOffset = serverTime - cg.time;
;1748:	}
;1749:	else {
;1750:		cg.timeOffset = 0;
;1751:	}
;1752:#endif
;1753:
;1754:	cg.time = serverTime;
ADDRGP4 cg+107656
ADDRFP4 0
INDIRI4
ASGNI4
line 1755
;1755:	cg.demoPlayback = demoPlayback;
ADDRGP4 cg+8
ADDRFP4 8
INDIRI4
ASGNI4
line 1758
;1756:
;1757:	// update cvars
;1758:	CG_UpdateCvars();
ADDRGP4 CG_UpdateCvars
CALLV
pop
line 1762
;1759:
;1760:	// if we are only updating the screen as a loading
;1761:	// pacifier, don't even try to read snapshots
;1762:	if ( cg.infoScreenText[0] != 0 ) {
ADDRGP4 cg+112484
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1618
line 1763
;1763:		CG_DrawInformation();
ADDRGP4 CG_DrawInformation
CALLV
pop
line 1764
;1764:		return;
ADDRGP4 $1615
JUMPV
LABELV $1618
line 1769
;1765:	}
;1766:
;1767:	// any looped sounds will be respecified as entities
;1768:	// are added to the render list
;1769:	trap_S_ClearLoopingSounds(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 trap_S_ClearLoopingSounds
CALLV
pop
line 1772
;1770:
;1771:	// clear all the render lists
;1772:	trap_R_ClearScene();
ADDRGP4 trap_R_ClearScene
CALLV
pop
line 1781
;1773:
;1774:#if 0//ESCAPE_MODE	// -JUHOX: clear screen in EFH
;1775:	if (cgs.gametype == GT_EFH) {
;1776:		CG_FillRect(0, 0, 640, 480, colorBlack);
;1777:	}
;1778:#endif
;1779:
;1780:	// set up cg.snap and possibly cg.nextSnap
;1781:	CG_ProcessSnapshots();
ADDRGP4 CG_ProcessSnapshots
CALLV
pop
line 1785
;1782:
;1783:	// if we haven't received any snapshots yet, all
;1784:	// we can draw is the information screen
;1785:	if ( !cg.snap || ( cg.snap->snapFlags & SNAPFLAG_NOT_ACTIVE ) ) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1625
ADDRGP4 cg+36
INDIRP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1621
LABELV $1625
line 1786
;1786:		CG_DrawInformation();
ADDRGP4 CG_DrawInformation
CALLV
pop
line 1787
;1787:		return;
ADDRGP4 $1615
JUMPV
LABELV $1621
line 1803
;1788:	}
;1789:
;1790:#if SCREENSHOT_TOOLS	// JUHOX
;1791:	if (cg.stopTime && cg.snap) {
;1792:		cg.serverOffset = serverTime - cg.snap->serverTime;
;1793:	}
;1794:	else {
;1795:		cg.serverOffset = 0;
;1796:	}
;1797:#endif
;1798:
;1799:	// let the client system know what our weapon and zoom settings are
;1800:#if 0	// JUHOX: 'weaponSelect' may be WP_NONE
;1801:	trap_SetUserCmdValue( cg.weaponSelect, cg.zoomSensitivity );
;1802:#else
;1803:	CG_AutoSwitchToBestWeapon();
ADDRGP4 CG_AutoSwitchToBestWeapon
CALLV
pop
line 1804
;1804:	if (cg.weaponSelect == WP_NONE) cg.weaponSelect = cg.snap->ps.weapon;
ADDRGP4 cg+109148
INDIRI4
CNSTI4 0
NEI4 $1626
ADDRGP4 cg+109148
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ASGNI4
LABELV $1626
line 1805
;1805:	trap_SetUserCmdValue(cg.weaponSelect==WP_NONE? WP_MACHINEGUN : cg.weaponSelect, cg.zoomSensitivity );
ADDRGP4 cg+109148
INDIRI4
CNSTI4 0
NEI4 $1635
ADDRLP4 4
CNSTI4 2
ASGNI4
ADDRGP4 $1636
JUMPV
LABELV $1635
ADDRLP4 4
ADDRGP4 cg+109148
INDIRI4
ASGNI4
LABELV $1636
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 cg+112480
INDIRF4
ARGF4
ADDRGP4 trap_SetUserCmdValue
CALLV
pop
line 1809
;1806:#endif
;1807:
;1808:	// this counter will be bumped for every valid scene we generate
;1809:	cg.clientFrame++;
ADDRLP4 8
ADDRGP4 cg
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1812
;1810:
;1811:	// update cg.predictedPlayerState
;1812:	CG_PredictPlayerState();
ADDRGP4 CG_PredictPlayerState
CALLV
pop
line 1816
;1813:
;1814:#if MEETING	// JUHOX: draw meeting screen
;1815:	if (
;1816:		atoi(CG_ConfigString(CS_MEETING)) ||
CNSTI4 709
ARGI4
ADDRLP4 12
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $1641
ADDRGP4 cg+107688+4
INDIRI4
CNSTI4 7
NEI4 $1637
LABELV $1641
line 1818
;1817:		cg.predictedPlayerState.pm_type == PM_MEETING
;1818:	) {
line 1821
;1819:		qhandle_t levelshot;
;1820:
;1821:		CG_FillRect(0, 0, 640, 480, colorBlack);
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 1142947840
ARGF4
CNSTF4 1139802112
ARGF4
ADDRGP4 colorBlack
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 1822
;1822:		levelshot = trap_R_RegisterShaderNoMip(
CNSTI4 0
ARGI4
ADDRLP4 24
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 $1643
ARGP4
ADDRLP4 28
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $1642
ARGP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 36
INDIRI4
ASGNI4
line 1825
;1823:			va("levelshots/%s.tga", Info_ValueForKey(CG_ConfigString(CS_SERVERINFO), "mapname"))
;1824:		);
;1825:		if (!levelshot) {
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $1644
line 1826
;1826:			levelshot = trap_R_RegisterShaderNoMip("menu/art/unknownmap");
ADDRGP4 $1646
ARGP4
ADDRLP4 40
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 40
INDIRI4
ASGNI4
line 1827
;1827:		}
LABELV $1644
line 1828
;1828:		trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1829
;1829:		CG_DrawPic(160, 180, 320, 240, levelshot);
CNSTF4 1126170624
ARGF4
CNSTF4 1127481344
ARGF4
CNSTF4 1134559232
ARGF4
CNSTF4 1131413504
ARGF4
ADDRLP4 20
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1831
;1830:
;1831:		cg.scoreFadeTime = cg.time;
ADDRGP4 cg+117632
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 1832
;1832:		cg.scoreBoardShowing = CG_DrawOldScoreboard();
ADDRLP4 40
ADDRGP4 CG_DrawOldScoreboard
CALLI4
ASGNI4
ADDRGP4 cg+117628
ADDRLP4 40
INDIRI4
ASGNI4
line 1835
;1833:
;1834:		if (
;1835:			!cg.scoresRequestTime ||
ADDRGP4 cg+113508
INDIRI4
CNSTI4 0
EQI4 $1655
ADDRGP4 cg+113508
INDIRI4
CNSTI4 2000
ADDI4
ADDRGP4 cg+107656
INDIRI4
GEI4 $1650
LABELV $1655
line 1837
;1836:			cg.scoresRequestTime + 2000 < cg.time
;1837:		) {
line 1838
;1838:			cg.scoresRequestTime = cg.time;
ADDRGP4 cg+113508
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 1839
;1839:			trap_SendClientCommand("score");
ADDRGP4 $1658
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 1840
;1840:		}
LABELV $1650
line 1842
;1841:
;1842:		CG_DrawVote();
ADDRGP4 CG_DrawVote
CALLV
pop
line 1843
;1843:		CG_DrawTeamVote();
ADDRGP4 CG_DrawTeamVote
CALLV
pop
line 1844
;1844:		return;
ADDRGP4 $1615
JUMPV
LABELV $1637
line 1852
;1845:	}
;1846:#endif
;1847:
;1848:	// decide on third person view
;1849:#if 0	// JUHOX: no third person view for dead spectators
;1850:	cg.renderingThirdPerson = cg_thirdPerson.integer || (cg.snap->ps.stats[STAT_HEALTH] <= 0);
;1851:#else
;1852:	cg.renderingThirdPerson =
ADDRGP4 cg_thirdPerson+12
INDIRI4
CNSTI4 0
NEI4 $1666
ADDRGP4 cg+36
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
GTI4 $1664
LABELV $1666
ADDRGP4 cg+36
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 2
EQI4 $1664
ADDRLP4 20
CNSTI4 1
ASGNI4
ADDRGP4 $1665
JUMPV
LABELV $1664
ADDRLP4 20
CNSTI4 0
ASGNI4
LABELV $1665
ADDRGP4 cg+107680
ADDRLP4 20
INDIRI4
ASGNI4
line 1858
;1853:		(cg_thirdPerson.integer || (cg.snap->ps.stats[STAT_HEALTH] <= 0)) &&
;1854:		cg.snap->ps.pm_type != PM_SPECTATOR;
;1855:#endif
;1856:
;1857:	// build cg.refdef
;1858:	inwater = CG_CalcViewValues();
ADDRLP4 24
ADDRGP4 CG_CalcViewValues
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 24
INDIRI4
ASGNI4
line 1861
;1859:
;1860:#if EARTHQUAKE_SYSTEM
;1861:	cg.additionalTremble = 0;	// JUHOX
ADDRGP4 cg+112448
CNSTF4 0
ASGNF4
line 1865
;1862:#endif
;1863:
;1864:#if 1	// JUHOX: fill framebuffer with the picture to show on cloaked players
;1865:	if (cg_glassCloaking.integer) {
ADDRGP4 cg_glassCloaking+12
INDIRI4
CNSTI4 0
EQI4 $1668
line 1869
;1866:		qboolean cloakedPlayers;
;1867:
;1868:		// are there any cloaked players to draw?
;1869:		cloakedPlayers = cg.snap->ps.powerups[PW_INVIS]? qtrue : qfalse;
ADDRGP4 cg+36
INDIRP4
CNSTI4 372
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1673
ADDRLP4 32
CNSTI4 1
ASGNI4
ADDRGP4 $1674
JUMPV
LABELV $1673
ADDRLP4 32
CNSTI4 0
ASGNI4
LABELV $1674
ADDRLP4 28
ADDRLP4 32
INDIRI4
ASGNI4
line 1870
;1870:		if (!cloakedPlayers) {
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $1675
line 1873
;1871:			int i;
;1872:	
;1873:			for (i = 0; i < cg.snap->numEntities; i++) {
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRGP4 $1680
JUMPV
LABELV $1677
line 1876
;1874:				centity_t* cent;
;1875:
;1876:				cent = &cg_entities[cg.snap->entities[i].number];
ADDRLP4 40
ADDRLP4 36
INDIRI4
CNSTI4 208
MULI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 516
ADDP4
ADDP4
INDIRI4
CNSTI4 880
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 1877
;1877:				if (cent->currentState.eType != ET_PLAYER) continue;
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 1
EQI4 $1683
ADDRGP4 $1678
JUMPV
LABELV $1683
line 1878
;1878:				if (!(cent->currentState.powerups & (1 << PW_INVIS))) continue;
ADDRLP4 40
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $1685
ADDRGP4 $1678
JUMPV
LABELV $1685
line 1880
;1879:
;1880:				cloakedPlayers = qtrue;
ADDRLP4 28
CNSTI4 1
ASGNI4
line 1881
;1881:				break;
ADDRGP4 $1679
JUMPV
LABELV $1678
line 1873
ADDRLP4 36
ADDRLP4 36
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1680
ADDRLP4 36
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
LTI4 $1677
LABELV $1679
line 1883
;1882:			}
;1883:		}
LABELV $1675
line 1885
;1884:
;1885:		if (cloakedPlayers) {
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $1687
line 1891
;1886:			float fov_x;
;1887:			float fov_y;
;1888:			vec3_t vieworg;
;1889:			vec3_t forward, right, up;
;1890:
;1891:			fov_x = cg.refdef.fov_x;
ADDRLP4 48
ADDRGP4 cg+109260+16
INDIRF4
ASGNF4
line 1892
;1892:			fov_y = cg.refdef.fov_y;
ADDRLP4 52
ADDRGP4 cg+109260+20
INDIRF4
ASGNF4
line 1893
;1893:			cg.refdef.fov_x *= 0.95;
ADDRLP4 92
ADDRGP4 cg+109260+16
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRF4
CNSTF4 1064514355
MULF4
ASGNF4
line 1894
;1894:			cg.refdef.fov_y *= 0.95;
ADDRLP4 96
ADDRGP4 cg+109260+20
ASGNP4
ADDRLP4 96
INDIRP4
ADDRLP4 96
INDIRP4
INDIRF4
CNSTF4 1064514355
MULF4
ASGNF4
line 1896
;1895:
;1896:			VectorCopy(cg.refdef.vieworg, vieworg);
ADDRLP4 56
ADDRGP4 cg+109260+24
INDIRB
ASGNB 12
line 1897
;1897:			AngleVectors(cg.refdefViewAngles, forward, right, up);
ADDRGP4 cg+109628
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 68
ARGP4
ADDRLP4 80
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 1898
;1898:			VectorMA(cg.refdef.vieworg, 8, forward, cg.refdef.vieworg);
ADDRGP4 cg+109260+24
ADDRGP4 cg+109260+24
INDIRF4
ADDRLP4 36
INDIRF4
CNSTF4 1090519040
MULF4
ADDF4
ASGNF4
ADDRGP4 cg+109260+24+4
ADDRGP4 cg+109260+24+4
INDIRF4
ADDRLP4 36+4
INDIRF4
CNSTF4 1090519040
MULF4
ADDF4
ASGNF4
ADDRGP4 cg+109260+24+8
ADDRGP4 cg+109260+24+8
INDIRF4
ADDRLP4 36+8
INDIRF4
CNSTF4 1090519040
MULF4
ADDF4
ASGNF4
line 1902
;1899:			//VectorMA(cg.refdef.vieworg, 5, right, cg.refdef.vieworg);
;1900:			//VectorMA(cg.refdef.vieworg, 5, up, cg.refdef.vieworg);
;1901:
;1902:			if (!cg.hyperspace) {
ADDRGP4 cg+107684
INDIRI4
CNSTI4 0
NEI4 $1718
line 1903
;1903:				CG_AddPacketEntitiesForGlassLook();
ADDRGP4 CG_AddPacketEntitiesForGlassLook
CALLV
pop
line 1904
;1904:				CG_AddNearbox();
ADDRGP4 CG_AddNearbox
CALLV
pop
line 1905
;1905:			}
LABELV $1718
line 1907
;1906:
;1907:			cg.refdef.time = cg.time;
ADDRGP4 cg+109260+72
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 1908
;1908:			memcpy(cg.refdef.areamask, cg.snap->areamask, sizeof(cg.refdef.areamask));
ADDRGP4 cg+109260+80
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 12
ADDP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1910
;1909:
;1910:			trap_R_RenderScene(&cg.refdef);
ADDRGP4 cg+109260
ARGP4
ADDRGP4 trap_R_RenderScene
CALLV
pop
line 1912
;1911:
;1912:			trap_R_ClearScene();	// it seems trap_R_RenderScene() does this too, so we can't optimize :(
ADDRGP4 trap_R_ClearScene
CALLV
pop
line 1914
;1913:
;1914:			cg.refdef.fov_x = fov_x;
ADDRGP4 cg+109260+16
ADDRLP4 48
INDIRF4
ASGNF4
line 1915
;1915:			cg.refdef.fov_y = fov_y;
ADDRGP4 cg+109260+20
ADDRLP4 52
INDIRF4
ASGNF4
line 1916
;1916:			VectorCopy(vieworg, cg.refdef.vieworg);
ADDRGP4 cg+109260+24
ADDRLP4 56
INDIRB
ASGNB 12
line 1917
;1917:		}
LABELV $1687
line 1918
;1918:	}
LABELV $1668
line 1922
;1919:#endif
;1920:
;1921:	// first person blend blobs, done after AnglesToAxis
;1922:	if ( !cg.renderingThirdPerson ) {
ADDRGP4 cg+107680
INDIRI4
CNSTI4 0
NEI4 $1736
line 1923
;1923:		CG_DamageBlendBlob();
ADDRGP4 CG_DamageBlendBlob
CALLV
pop
line 1924
;1924:	}
LABELV $1736
line 1927
;1925:
;1926:	// build the render lists
;1927:	if ( !cg.hyperspace ) {
ADDRGP4 cg+107684
INDIRI4
CNSTI4 0
NEI4 $1739
line 1928
;1928:		CG_AddNearbox();	// JUHOX
ADDRGP4 CG_AddNearbox
CALLV
pop
line 1929
;1929:		CG_AddPacketEntities();			// adter calcViewValues, so predicted player state is correct
ADDRGP4 CG_AddPacketEntities
CALLV
pop
line 1930
;1930:		CG_AddMarks();
ADDRGP4 CG_AddMarks
CALLV
pop
line 1932
;1931:#if MONSTER_MODE	// JUHOX: add the end sequence lightning marks
;1932:		if (cgs.gametype == GT_STU && cg.endPhaseTime > 0 && cg.time - cg.endPhaseTime < 20000) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 8
NEI4 $1742
ADDRGP4 cg+112452
INDIRI4
CNSTI4 0
LEI4 $1742
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cg+112452
INDIRI4
SUBI4
CNSTI4 20000
GEI4 $1742
line 1935
;1933:			int time;
;1934:
;1935:			time = cg.time - cg.endPhaseTime;
ADDRLP4 28
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cg+112452
INDIRI4
SUBI4
ASGNI4
line 1936
;1936:			if (time > 10000) time = 20000 - time;
ADDRLP4 28
INDIRI4
CNSTI4 10000
LEI4 $1750
ADDRLP4 28
CNSTI4 20000
ADDRLP4 28
INDIRI4
SUBI4
ASGNI4
LABELV $1750
line 1937
;1937:			CG_AddLightningMarks(time / 750);
ADDRLP4 28
INDIRI4
CNSTI4 750
DIVI4
ARGI4
ADDRGP4 CG_AddLightningMarks
CALLV
pop
line 1939
;1938:
;1939:			if (random() < 0.0005 * time * 0.001 * (cg.time - cg.endPhaseLastDischargeSoundTime)) {
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
ADDRLP4 28
INDIRI4
CVIF4 4
CNSTF4 889599933
MULF4
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cg+112456
INDIRI4
SUBI4
CVIF4 4
MULF4
GEF4 $1752
line 1940
;1940:				cg.endPhaseLastDischargeSoundTime = cg.time;
ADDRGP4 cg+112456
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 1942
;1941:
;1942:				trap_S_StartLocalSound(cgs.media.dischargeFlashSound, CHAN_AUTO);
ADDRGP4 cgs+751220+1064
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 1943
;1943:			}
LABELV $1752
line 1944
;1944:		}
LABELV $1742
line 1946
;1945:#endif
;1946:		CG_AddParticles ();
ADDRGP4 CG_AddParticles
CALLV
pop
line 1947
;1947:		CG_AddLocalEntities();
ADDRGP4 CG_AddLocalEntities
CALLV
pop
line 1949
;1948:#if MAPLENSFLARES	// JUHOX: add map lens flares
;1949:		CG_AddMapLensFlares();
ADDRGP4 CG_AddMapLensFlares
CALLV
pop
line 1951
;1950:#endif
;1951:	}
LABELV $1739
line 1952
;1952:	CG_AddViewWeapon( &cg.predictedPlayerState );
ADDRGP4 cg+107688
ARGP4
ADDRGP4 CG_AddViewWeapon
CALLV
pop
line 1955
;1953:
;1954:	// add buffered sounds
;1955:	CG_PlayBufferedSounds();
ADDRGP4 CG_PlayBufferedSounds
CALLV
pop
line 1958
;1956:
;1957:	// play buffered voice chats
;1958:	CG_PlayBufferedVoiceChats();
ADDRGP4 CG_PlayBufferedVoiceChats
CALLV
pop
line 1961
;1959:
;1960:	// finish up the rest of the refdef
;1961:	if ( cg.testModelEntity.hModel ) {
ADDRGP4 cg+163464+8
INDIRI4
CNSTI4 0
EQI4 $1761
line 1962
;1962:		CG_AddTestModel();
ADDRGP4 CG_AddTestModel
CALLV
pop
line 1963
;1963:	}
LABELV $1761
line 1964
;1964:	cg.refdef.time = cg.time;
ADDRGP4 cg+109260+72
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 1965
;1965:	memcpy( cg.refdef.areamask, cg.snap->areamask, sizeof( cg.refdef.areamask ) );
ADDRGP4 cg+109260+80
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 12
ADDP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1968
;1966:
;1967:	// warning sounds when powerup is wearing off
;1968:	CG_PowerupTimerSounds();
ADDRGP4 CG_PowerupTimerSounds
CALLV
pop
line 1974
;1969:
;1970:	// update audio positions
;1971:#if !ESCAPE_MODE	// JUHOX: sound fix for EFH
;1972:	trap_S_Respatialize( cg.snap->ps.clientNum, cg.refdef.vieworg, cg.refdef.viewaxis, inwater );
;1973:#else
;1974:	{
line 1977
;1975:		vec3_t worldOrigin;
;1976:
;1977:		VectorAdd(cg.refdef.vieworg, currentReference, worldOrigin);
ADDRLP4 28
ADDRGP4 cg+109260+24
INDIRF4
ADDRGP4 currentReference
INDIRF4
ADDF4
ASGNF4
ADDRLP4 28+4
ADDRGP4 cg+109260+24+4
INDIRF4
ADDRGP4 currentReference+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 28+8
ADDRGP4 cg+109260+24+8
INDIRF4
ADDRGP4 currentReference+8
INDIRF4
ADDF4
ASGNF4
line 1978
;1978:		trap_S_Respatialize(cg.snap->ps.clientNum, worldOrigin, cg.refdef.viewaxis, inwater);
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
ARGP4
ADDRGP4 cg+109260+36
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 trap_S_Respatialize
CALLV
pop
line 1979
;1979:	}
line 1983
;1980:#endif
;1981:
;1982:#if MONSTER_MODE	// JUHOX: start the earthquake sound
;1983:	if (cg.earthquakeSoundCounter > 0) {
ADDRGP4 cg+110136
INDIRI4
CNSTI4 0
LEI4 $1788
line 1984
;1984:		if (cg.lastEarhquakeSoundStartedTime < cg.time - 200) {
ADDRGP4 cg+110140
INDIRI4
ADDRGP4 cg+107656
INDIRI4
CNSTI4 200
SUBI4
GEI4 $1791
line 1985
;1985:			cg.earthquakeSoundCounter--;
ADDRLP4 28
ADDRGP4 cg+110136
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1986
;1986:			trap_S_StartLocalSound(cgs.media.earthquakeSound, CHAN_VOICE);
ADDRGP4 cgs+751220+1132
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 1987
;1987:			cg.lastEarhquakeSoundStartedTime = cg.time + rand() % 20 - 10;
ADDRLP4 32
ADDRGP4 rand
CALLI4
ASGNI4
ADDRGP4 cg+110140
ADDRGP4 cg+107656
INDIRI4
ADDRLP4 32
INDIRI4
CNSTI4 20
MODI4
ADDI4
CNSTI4 10
SUBI4
ASGNI4
line 1988
;1988:		}
LABELV $1791
line 1989
;1989:	}
LABELV $1788
line 1993
;1990:#endif
;1991:
;1992:#if MONSTER_MODE	// JUHOX: check artefact detector
;1993:	if (!cg.lastDetectorCheckTime) {
ADDRGP4 cg+112460
INDIRI4
CNSTI4 0
NEI4 $1800
line 1995
;1994:		// initializing
;1995:		cg.lastDetectorCheckTime = cg.time;
ADDRGP4 cg+112460
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 1996
;1996:		cg.detector = 0;
ADDRGP4 cg+112464
CNSTF4 0
ASGNF4
line 1997
;1997:	}
ADDRGP4 $1801
JUMPV
LABELV $1800
line 1998
;1998:	else if (cg.predictedPlayerState.pm_type == PM_NORMAL) {
ADDRGP4 cg+107688+4
INDIRI4
CNSTI4 0
NEI4 $1806
line 2002
;1999:		float msec;
;2000:		int dist;
;2001:
;2002:		msec = cg.time - cg.lastDetectorCheckTime;
ADDRLP4 32
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cg+112460
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 2003
;2003:		cg.lastDetectorCheckTime = cg.time;
ADDRGP4 cg+112460
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 2005
;2004:
;2005:		dist = cg.snap->ps.stats[STAT_DETECTOR];
ADDRLP4 28
ADDRGP4 cg+36
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
ASGNI4
line 2006
;2006:		if (dist >= 100 && dist < 3000) {
ADDRLP4 36
ADDRLP4 28
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 100
LTI4 $1815
ADDRLP4 36
INDIRI4
CNSTI4 3000
GEI4 $1815
line 2007
;2007:			cg.detector += msec / dist;
ADDRLP4 40
ADDRGP4 cg+112464
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRF4
ADDRLP4 32
INDIRF4
ADDRLP4 28
INDIRI4
CVIF4 4
DIVF4
ADDF4
ASGNF4
line 2008
;2008:			if (cg.detector >= 1) {
ADDRGP4 cg+112464
INDIRF4
CNSTF4 1065353216
LTF4 $1818
line 2009
;2009:				trap_S_StartLocalSound(cgs.media.detectorBeepSound, CHAN_ITEM);
ADDRGP4 cgs+751220+1144
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 2011
;2010:
;2011:				cg.detectorBeepTime = cg.time;
ADDRGP4 cg+112468
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 2013
;2012:
;2013:				cg.detector -= (int) cg.detector;
ADDRLP4 44
ADDRGP4 cg+112464
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRF4
ADDRGP4 cg+112464
INDIRF4
CVFI4 4
CVIF4 4
SUBF4
ASGNF4
line 2014
;2014:			}
LABELV $1818
line 2015
;2015:		}
LABELV $1815
line 2016
;2016:	}
LABELV $1806
LABELV $1801
line 2020
;2017:#endif
;2018:
;2019:	// make sure the lagometerSample and frame timing isn't done twice when in stereo
;2020:	if ( stereoView != STEREO_RIGHT ) {
ADDRFP4 4
INDIRI4
CNSTI4 2
EQI4 $1827
line 2021
;2021:		cg.frametime = cg.time - cg.oldTime;
ADDRGP4 cg+107652
ADDRGP4 cg+107656
INDIRI4
ADDRGP4 cg+107660
INDIRI4
SUBI4
ASGNI4
line 2022
;2022:		if ( cg.frametime < 0 ) {
ADDRGP4 cg+107652
INDIRI4
CNSTI4 0
GEI4 $1832
line 2023
;2023:			cg.frametime = 0;
ADDRGP4 cg+107652
CNSTI4 0
ASGNI4
line 2024
;2024:		}
LABELV $1832
line 2025
;2025:		cg.oldTime = cg.time;
ADDRGP4 cg+107660
ADDRGP4 cg+107656
INDIRI4
ASGNI4
line 2026
;2026:		CG_AddLagometerFrameInfo();
ADDRGP4 CG_AddLagometerFrameInfo
CALLV
pop
line 2027
;2027:	}
LABELV $1827
line 2028
;2028:	if (cg_timescale.value != cg_timescaleFadeEnd.value) {
ADDRGP4 cg_timescale+8
INDIRF4
ADDRGP4 cg_timescaleFadeEnd+8
INDIRF4
EQF4 $1838
line 2029
;2029:		if (cg_timescale.value < cg_timescaleFadeEnd.value) {
ADDRGP4 cg_timescale+8
INDIRF4
ADDRGP4 cg_timescaleFadeEnd+8
INDIRF4
GEF4 $1842
line 2030
;2030:			cg_timescale.value += cg_timescaleFadeSpeed.value * ((float)cg.frametime) / 1000;
ADDRLP4 28
ADDRGP4 cg_timescale+8
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRGP4 cg_timescaleFadeSpeed+8
INDIRF4
ADDRGP4 cg+107652
INDIRI4
CVIF4 4
MULF4
CNSTF4 981668463
MULF4
ADDF4
ASGNF4
line 2031
;2031:			if (cg_timescale.value > cg_timescaleFadeEnd.value)
ADDRGP4 cg_timescale+8
INDIRF4
ADDRGP4 cg_timescaleFadeEnd+8
INDIRF4
LEF4 $1843
line 2032
;2032:				cg_timescale.value = cg_timescaleFadeEnd.value;
ADDRGP4 cg_timescale+8
ADDRGP4 cg_timescaleFadeEnd+8
INDIRF4
ASGNF4
line 2033
;2033:		}
ADDRGP4 $1843
JUMPV
LABELV $1842
line 2034
;2034:		else {
line 2035
;2035:			cg_timescale.value -= cg_timescaleFadeSpeed.value * ((float)cg.frametime) / 1000;
ADDRLP4 28
ADDRGP4 cg_timescale+8
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRGP4 cg_timescaleFadeSpeed+8
INDIRF4
ADDRGP4 cg+107652
INDIRI4
CVIF4 4
MULF4
CNSTF4 981668463
MULF4
SUBF4
ASGNF4
line 2036
;2036:			if (cg_timescale.value < cg_timescaleFadeEnd.value)
ADDRGP4 cg_timescale+8
INDIRF4
ADDRGP4 cg_timescaleFadeEnd+8
INDIRF4
GEF4 $1858
line 2037
;2037:				cg_timescale.value = cg_timescaleFadeEnd.value;
ADDRGP4 cg_timescale+8
ADDRGP4 cg_timescaleFadeEnd+8
INDIRF4
ASGNF4
LABELV $1858
line 2038
;2038:		}
LABELV $1843
line 2039
;2039:		if (cg_timescaleFadeSpeed.value) {
ADDRGP4 cg_timescaleFadeSpeed+8
INDIRF4
CNSTF4 0
EQF4 $1864
line 2040
;2040:			trap_Cvar_Set("timescale", va("%f", cg_timescale.value));
ADDRGP4 $1868
ARGP4
ADDRGP4 cg_timescale+8
INDIRF4
ARGF4
ADDRLP4 28
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $1867
ARGP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2041
;2041:		}
LABELV $1864
line 2042
;2042:	}
LABELV $1838
line 2045
;2043:
;2044:	// actually issue the rendering calls
;2045:	CG_DrawActive( stereoView );
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 CG_DrawActive
CALLV
pop
line 2048
;2046:
;2047:#if PLAYLIST
;2048:	CG_RunPlayListFrame();	// JUHOX
ADDRGP4 CG_RunPlayListFrame
CALLV
pop
line 2051
;2049:#endif
;2050:
;2051:	if ( cg_stats.integer ) {
ADDRGP4 cg_stats+12
INDIRI4
CNSTI4 0
EQI4 $1870
line 2052
;2052:		CG_Printf( "cg.clientFrame:%i\n", cg.clientFrame );
ADDRGP4 $1873
ARGP4
ADDRGP4 cg
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 2053
;2053:	}
LABELV $1870
line 2056
;2054:
;2055:
;2056:}
LABELV $1615
endproc CG_DrawActiveFrame 100 20
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
LABELV $1873
byte 1 99
byte 1 103
byte 1 46
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 70
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 58
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $1868
byte 1 37
byte 1 102
byte 1 0
align 1
LABELV $1867
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 115
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $1658
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $1646
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $1643
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $1642
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1606
byte 1 116
byte 1 115
byte 1 115
byte 1 103
byte 1 114
byte 1 111
byte 1 117
byte 1 112
byte 1 84
byte 1 101
byte 1 109
byte 1 112
byte 1 111
byte 1 114
byte 1 97
byte 1 114
byte 1 121
byte 1 0
align 1
LABELV $1108
byte 1 100
byte 1 105
byte 1 115
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 70
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 0
align 1
LABELV $1044
byte 1 108
byte 1 102
byte 1 101
byte 1 100
byte 1 105
byte 1 116
byte 1 111
byte 1 114
byte 1 99
byte 1 117
byte 1 114
byte 1 115
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $1042
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 47
byte 1 115
byte 1 109
byte 1 97
byte 1 108
byte 1 108
byte 1 95
byte 1 115
byte 1 112
byte 1 104
byte 1 101
byte 1 114
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $280
byte 1 49
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $276
byte 1 51
byte 1 48
byte 1 0
align 1
LABELV $275
byte 1 99
byte 1 103
byte 1 95
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $201
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $184
byte 1 102
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $145
byte 1 67
byte 1 97
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 114
byte 1 101
byte 1 103
byte 1 105
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 10
byte 1 0
