// Copyright (C) 1999-2000 Id Software, Inc.
//
// cg_scoreboard -- draw the scoreboard on top of the game screen
#include "cg_local.h"


#define	SCOREBOARD_X		(0)

#if !RESPAWN_DELAY	// JUHOX: make room for the "respawning in x ..." message
#define SB_HEADER			86
#else
#define SB_HEADER			107
#endif
#define SB_TOP				(SB_HEADER+32)

// Where the status bar starts, so we don't overwrite it
#define SB_STATUSBAR		420
#define SB_NORMAL_HEIGHT	40
#define SB_INTER_HEIGHT		16 // interleaved height

#define SB_MAXCLIENTS_NORMAL  ((SB_STATUSBAR - SB_TOP) / SB_NORMAL_HEIGHT)
#define SB_MAXCLIENTS_INTER   ((SB_STATUSBAR - SB_TOP) / SB_INTER_HEIGHT - 1)

// Used when interleaved

#define SB_LEFT_BOTICON_X	(SCOREBOARD_X+0)
#define SB_LEFT_HEAD_X		(SCOREBOARD_X+32)
#define SB_RIGHT_BOTICON_X	(SCOREBOARD_X+64)
#define SB_RIGHT_HEAD_X		(SCOREBOARD_X+96)
// Normal
#define SB_BOTICON_X		(SCOREBOARD_X+32)
#define SB_HEAD_X			(SCOREBOARD_X+64)

#define SB_SCORELINE_X		112

#define SB_RATING_WIDTH	    (6 * BIGCHAR_WIDTH) // width 6

#define SB_SCORE_X			(SB_SCORELINE_X + 1.5 * BIGCHAR_WIDTH) // width 6
#define SB_PING_X			(SB_SCORELINE_X + 14.5 * BIGCHAR_WIDTH) // width 5
#define SB_TIME_X			(SB_SCORELINE_X + 19.5 * BIGCHAR_WIDTH) // width 5
#define SB_NAME_X			(SB_SCORELINE_X + 24 * BIGCHAR_WIDTH) // width 15

// The new and improved score board
//
// In cases where the number of clients is high, the score board heads are interleaved
// here's the layout
//
//	0   32   80  112  144   240  320  400   <-- pixel position
//  bot head bot head score ping time name
//
//  wins/losses are drawn on bot icon now

static qboolean localClient; // true if local client has been displayed


							 /*
=================
CG_DrawScoreboard
=================
*/
static void CG_DrawClientScore( int y, score_t *score, float *color, float fade, qboolean largeFormat ) {
	char	string[1024];
	vec3_t	headAngles;
	clientInfo_t	*ci;
	int iconx, headx;
	int xx;	// JUHOX

	if ( score->client < 0 || score->client >= cgs.maxclients ) {
		Com_Printf( "Bad score->client: %i\n", score->client );
		return;
	}

	// JUHOX: STU scoreboard
	xx = 0;

	if (cgs.gametype >= GT_STU) {
		xx = 4 * BIGCHAR_WIDTH;
	}

	ci = &cgs.clientinfo[score->client];
	if (cg.intermissionMusicStarted) ci->powerups = 0;	// JUHOX: remove flags

	iconx = SB_BOTICON_X + (SB_RATING_WIDTH / 2);
	headx = SB_HEAD_X + (SB_RATING_WIDTH / 2);

	iconx -= xx;	// JUHOX
	headx -= xx;	// JUHOX

	// draw the handicap or bot skill marker (unless player has flag)
	if ( ci->powerups & ( 1 << PW_NEUTRALFLAG ) ) {
		if( largeFormat ) {
			CG_DrawFlagModel( iconx, y - ( 32 - BIGCHAR_HEIGHT ) / 2, 32, 32, TEAM_FREE, qfalse );
		}
		else {
			CG_DrawFlagModel( iconx, y, 16, 16, TEAM_FREE, qfalse );
		}
	} else if ( ci->powerups & ( 1 << PW_REDFLAG ) ) {
		if( largeFormat ) {
			CG_DrawFlagModel( iconx, y - ( 32 - BIGCHAR_HEIGHT ) / 2, 32, 32, TEAM_RED, qfalse );
		}
		else {
			CG_DrawFlagModel( iconx, y, 16, 16, TEAM_RED, qfalse );
		}
	} else if ( ci->powerups & ( 1 << PW_BLUEFLAG ) ) {
		if( largeFormat ) {
			CG_DrawFlagModel( iconx, y - ( 32 - BIGCHAR_HEIGHT ) / 2, 32, 32, TEAM_BLUE, qfalse );
		}
		else {
			CG_DrawFlagModel( iconx, y, 16, 16, TEAM_BLUE, qfalse );
		}
	} else {
		if ( ci->botSkill > 0 && ci->botSkill <= 5 ) {
			if ( cg_drawIcons.integer ) {
				if( largeFormat ) {
					CG_DrawPic( iconx, y - ( 32 - BIGCHAR_HEIGHT ) / 2, 32, 32, cgs.media.botSkillShaders[ ci->botSkill - 1 ] );
				}
				else {
					CG_DrawPic( iconx, y, 16, 16, cgs.media.botSkillShaders[ ci->botSkill - 1 ] );
				}
			}
		} else if ( ci->handicap < 100 ) {
			Com_sprintf( string, sizeof( string ), "%i", ci->handicap );
			if ( cgs.gametype == GT_TOURNAMENT )
				CG_DrawSmallStringColor( iconx, y - SMALLCHAR_HEIGHT/2, string, color );
			else
				CG_DrawSmallStringColor( iconx, y, string, color );
		}

		// draw the wins / losses
		if ( cgs.gametype == GT_TOURNAMENT ) {
			Com_sprintf( string, sizeof( string ), "%i/%i", ci->wins, ci->losses );
			if( ci->handicap < 100 && !ci->botSkill ) {
				CG_DrawSmallStringColor( iconx, y + SMALLCHAR_HEIGHT/2, string, color );
			}
			else {
				CG_DrawSmallStringColor( iconx, y, string, color );
			}
		}
	}

	// draw the face
	VectorClear( headAngles );
	headAngles[YAW] = 180;
	if( largeFormat ) {
		CG_DrawHead( headx, y - ( ICON_SIZE - BIGCHAR_HEIGHT ) / 2, ICON_SIZE, ICON_SIZE,
			score->client, headAngles );
	}
	else {
		CG_DrawHead( headx, y, 16, 16, score->client, headAngles );
	}

	// draw the score line

	if (score->ping == -1) {
		Com_sprintf(
			string, sizeof(string), " connecting      %s", ci->name
		);
	}
	else if (ci->team == TEAM_SPECTATOR) {
		Com_sprintf(
			string, sizeof(string), " SPECT  %4i %4i %s", score->ping, score->time, ci->name
		);
	}

	else if (cgs.gametype >= GT_STU) {
		Com_sprintf(
			string, sizeof(string), "%7i:%-3i %4i %4i %s",
			score->score, score->killed,
			score->ping, score->time, ci->name
		);
	}

	else {
		Com_sprintf(
			string, sizeof(string), "%3i%s%-3i %4i %4i %s",
			score->score, cgs.gametype < GT_TEAM? ":" : "-", score->killed,
			score->ping, score->time, ci->name
		);
	}


	// highlight your position
	if ( score->client == cg.snap->ps.clientNum ) {
		float	hcolor[4];
		int		rank;

		localClient = qtrue;

		if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR
			|| cgs.gametype >= GT_TEAM ) {
			rank = -1;
		} else {
			rank = cg.snap->ps.persistant[PERS_RANK] & ~RANK_TIED_FLAG;
		}
		if ( rank == 0 ) {
			hcolor[0] = 0;
			hcolor[1] = 0;
			hcolor[2] = 0.7f;
		} else if ( rank == 1 ) {
			hcolor[0] = 0.7f;
			hcolor[1] = 0;
			hcolor[2] = 0;
		} else if ( rank == 2 ) {
			hcolor[0] = 0.7f;
			hcolor[1] = 0.7f;
			hcolor[2] = 0;
		} else {
			hcolor[0] = 0.7f;
			hcolor[1] = 0.7f;
			hcolor[2] = 0.7f;
		}

		hcolor[3] = fade * 0.7;
		CG_FillRect( SB_SCORELINE_X + (SB_RATING_WIDTH / 2) - xx, y,
			640 - SB_SCORELINE_X - BIGCHAR_WIDTH, BIGCHAR_HEIGHT+1, hcolor );
	}

	if (score->time < 0) {
		vec4_t dcolor;

		dcolor[0] = 1;
		dcolor[1] = 0.7;
		dcolor[2] = 0;
		dcolor[3] = fade;
		CG_DrawBigStringColor(SB_SCORELINE_X + (SB_RATING_WIDTH / 2) - xx, y, string, dcolor);
	}
	else {
		CG_DrawBigString( SB_SCORELINE_X + (SB_RATING_WIDTH / 2) - xx, y, string, fade );
	}

	// add the "ready" marker for intermission exiting

	{
		const char* cs;

		cs = CG_ConfigString(CS_CLIENTS_READY);
		if (strlen(cs) >= MAX_CLIENTS/4) {
			int cl;

			cl = score->client;
			if ((cs[cl/4] - 'A') & (1 << (cl & 3))) {
				CG_DrawBigStringColor(iconx, y, "READY", color);
				return;
			}
		}
	}

	// JUHOX: draw the glass cloaking marker
	if (ci->usesGlassCloaking) {
		CG_DrawBigStringColor(iconx, y, "GC", color);
	}

}

/*
=================
CG_TeamScoreboard
=================
*/
static int CG_TeamScoreboard( int y, team_t team, float fade, int maxClients, int lineHeight ) {
	int		i;
	score_t	*score;
	float	color[4];
	int		count;
	clientInfo_t	*ci;

	color[0] = color[1] = color[2] = 1.0;
	color[3] = fade;

	count = 0;
	for ( i = 0 ; i < cg.numScores && count < maxClients ; i++ ) {
		score = &cg.scores[i];
		ci = &cgs.clientinfo[ score->client ];

		if ( team != ci->team ) {
			continue;
		}

		CG_DrawClientScore( y + lineHeight * count, score, color, fade, lineHeight == SB_NORMAL_HEIGHT );

		count++;
	}

	return count;
}

/*
=================
CG_DrawScoreboard

Draw the normal in-game scoreboard
=================
*/
qboolean CG_DrawOldScoreboard( void ) {
	int		x, y, w, i, n1, n2;
	float	fade;
	float	*fadeColor;
	const char* s;
	int maxClients;
	int lineHeight;
	int topBorderSize, bottomBorderSize;

    // JUHOX: don't draw scoreboard in lens flare editor
	if (cgs.editMode == EM_mlf) return qfalse;

	// don't draw amuthing if the menu or console is up
	if ( cg_paused.integer ) {
		cg.deferredPlayerLoading = 0;
		return qfalse;
	}

	if ( cgs.gametype == GT_SINGLE_PLAYER && cg.predictedPlayerState.pm_type == PM_INTERMISSION ) {
		cg.deferredPlayerLoading = 0;
		return qfalse;
	}

    // JUHOX: if at the intermission play an appropriate music
	if (cg.predictedPlayerState.pm_type == PM_INTERMISSION) {
		if (!cg.intermissionMusicStarted) {
			qboolean winning, loosing;

			winning = loosing = qfalse;
			if (cgs.gametype < GT_TEAM) {
				if (cg.snap->ps.persistant[PERS_TEAM] != TEAM_SPECTATOR) {
					if (cg.snap->ps.persistant[PERS_RANK] <= 0) {
						winning = qtrue;
					}
					else {
						loosing = qtrue;
					}
				}
			}

			else if (cgs.gametype == GT_STU) {
				if (cg.snap->ps.persistant[PERS_TEAM] != TEAM_SPECTATOR) {
					if (cgs.artefacts > 0 && cgs.artefacts < 999) {
						winning = (cgs.scores1 >= cgs.artefacts);
						loosing = !winning;
					}
					else if (CG_ConfigString(CS_HIGHSCORETEXT)[0]) {
						winning = qtrue;
					}
				}
			}

			else if (cgs.gametype == GT_EFH) {
				long limit;

				limit = atoi(CG_ConfigString(CS_EFH_GOAL_DISTANCE));
				if (limit <= 0) {
					limit = cgs.distanceLimit;
				}

				if (limit > 0) {
					if (
						atoi(CG_ConfigString(CS_EFH_COVERED_DISTANCE)) >= limit
					) {
						winning = qtrue;
					}
					else {
						loosing = qtrue;
					}
				}
				else if (CG_ConfigString(CS_HIGHSCORETEXT)[0]) {
					winning = qtrue;
				}
			}

			else if (cgs.scores1 != cgs.scores2) {
				int winningTeam;

				winningTeam = cgs.scores1>cgs.scores2? TEAM_RED : TEAM_BLUE;
				if (cg.snap->ps.persistant[PERS_TEAM] == winningTeam) {
					winning = qtrue;
				}
				else if (cg.snap->ps.persistant[PERS_TEAM] != TEAM_SPECTATOR) {
					loosing = qtrue;
				}
			}
			if (winning) {

				CG_StopPlayList();

				{
					int len;
					fileHandle_t f;

					len = trap_FS_FOpenFile("music/hunt_victory.wav", &f, FS_READ);
					if (f) trap_FS_FCloseFile(f);

					if (len > 0) {
						trap_S_StartBackgroundTrack("music/hunt_victory.wav", "");
					}
					else {
						trap_S_StartBackgroundTrack("music/win.wav", "");
					}
				}
			}
			else if (loosing) {
				CG_StopPlayList();
				trap_S_StartBackgroundTrack("music/loss.wav", "");
			}
			cg.intermissionMusicStarted = qtrue;

			cg.killerName[0] = 0;
		}
	}
	else {
		if (cg.intermissionMusicStarted) {
			CG_StartMusic();
			cg.intermissionMusicStarted = qfalse;
		}
	}

	// don't draw scoreboard during death while warmup up
	if ( cg.warmup && !cg.showScores ) {
		return qfalse;
	}

	if ( cg.showScores || cg.predictedPlayerState.pm_type == PM_DEAD ||
		cg.predictedPlayerState.stats[STAT_HEALTH] <= 0 ||	// JUHOX
#if MEETING	// JUHOX: show scoreboard during meeting
		cg.predictedPlayerState.pm_type == PM_MEETING ||
#endif
		 cg.predictedPlayerState.pm_type == PM_INTERMISSION ) {
		fade = 1.0;
		fadeColor = colorWhite;
	} else {
		cg.deferredPlayerLoading = 0;
		cg.killerName[0] = 0;
		return qfalse;
	}


	// fragged by ... line
	if ( cg.killerName[0] ) {
		s = va("Fragged by %s", cg.killerName );
		w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
		x = ( SCREEN_WIDTH - w ) / 2;
		y = 40;
		CG_DrawBigString( x, y, s, fade );
	}

#if MEETING	// JUHOX: meeting instructions
	if (cg.predictedPlayerState.pm_type == PM_MEETING) {
		if (cg.time % 1000 < 700) {
			s = "Waiting for players...";
			w = CG_DrawStrlen(s) * BIGCHAR_WIDTH;
			x = (SCREEN_WIDTH - w) / 2;
			y = 60;
			CG_DrawBigString(x, y, s, fade);
		}

		s = "Hit <ATTACK> to toggle ready status.";
		w = CG_DrawStrlen(s) * BIGCHAR_WIDTH;
		x = (SCREEN_WIDTH - w) / 2;
		y = 62 + BIGCHAR_HEIGHT;
		CG_DrawBigString(x, y, s, fade);
	}
	else	// don't draw rank during meeting
#endif

	// current rank
	// JUHOX: team rank different in STU
	if (cgs.gametype == GT_STU) {
		if (cg.predictedPlayerState.pm_type == PM_INTERMISSION) {
			if (cgs.artefacts <= 0 || cgs.artefacts >= 999 || cgs.scores1 >= cgs.artefacts) {
				s = va("Score: %s    Time: %s", CG_ConfigString(CS_STU_SCORE), CG_ConfigString(CS_TIME_PLAYED));
				w = CG_DrawStrlen(s) * BIGCHAR_WIDTH;
				x = (SCREEN_WIDTH - w) / 2;
				y = 62 + BIGCHAR_HEIGHT;
				CG_DrawBigString(x, y, s, fade);

				if (cgs.artefacts <= 0) {
					s = "";
				}
				else if (cgs.artefacts >= 999) {
					s = va("%d artefact%s collected", cgs.scores1, cgs.scores1 != 1? "s" : "");
				}
				else {
					if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR) {
						s = "The Universe has been saved!";
					}
					else {
						s = "You saved the Universe!";
					}
				}
			}
			else {
				s = va("%d of %d artefact%s collected", cgs.scores1, cgs.artefacts, cgs.artefacts != 1? "s" : "");
				w = CG_DrawStrlen(s) * BIGCHAR_WIDTH;
				x = (SCREEN_WIDTH - w) / 2;
				y = 62 + BIGCHAR_HEIGHT;
				CG_DrawBigString(x, y, s, fade);

				if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR) {
					s = "Mission failed!";
				}
				else
				{
					s = "Mission failed! Report to HQ!";
				}
			}
			w = CG_DrawStrlen(s) * BIGCHAR_WIDTH;
			x = (SCREEN_WIDTH - w) / 2;
			y = 60;
			CG_DrawBigString(x, y, s, fade);
		}
		// NOTE: no team rank message if not in the intermission
	}
	else

	// JUHOX: team rank in EFH
	if (cgs.gametype == GT_EFH) {
		if (cg.predictedPlayerState.pm_type == PM_INTERMISSION) {
			char s1[256];
			char s2[256];
			char s3[256];
			int w1, w2, w3;
			long dist;
			long distlimit;
			static const vec4_t backColor = {
				0, 0, 0, 0.5
			};

			distlimit = atoi(CG_ConfigString(CS_EFH_GOAL_DISTANCE));
			if (distlimit <= 0) {
				distlimit = cgs.distanceLimit;
			}

			dist = atoi(CG_ConfigString(CS_EFH_COVERED_DISTANCE));

			if (distlimit > 0) {
				if (cgs.timelimit > 0) {
					long timelimit;

					timelimit = 60000 * cgs.timelimit;
					if (cgs.distanceLimit > 0) {
						timelimit += ((distlimit - cgs.distanceLimit) * timelimit) / cgs.distanceLimit;
					}

					s = va(
						" Distance: %d.%03d/%d.%03dkm    Time: %s/%d:%02d.%03d ",
						dist / 1000, dist % 1000,
						distlimit / 1000, distlimit % 1000,
						CG_ConfigString(CS_TIME_PLAYED),
						timelimit / 60000, (timelimit / 1000) % 60, timelimit % 1000
					);
				}
				else {
					s = va(
						" Distance: %d.%03d/%d.%03dkm    Time: %s ",
						dist / 1000, dist % 1000,
						distlimit / 1000, distlimit % 1000,
						CG_ConfigString(CS_TIME_PLAYED)
					);
				}
			}
			else {
				if (cgs.timelimit > 0) {
					s = va(
						" Distance: %d.%03dkm    Time: %s/%d:00 ",
						dist / 1000, dist % 1000,
						CG_ConfigString(CS_TIME_PLAYED),
						cgs.timelimit
					);
				}
				else {
					s = va(
						" Distance: %d.%03dkm    Time: %s ",
						dist / 1000, dist % 1000,
						CG_ConfigString(CS_TIME_PLAYED)
					);
				}
			}
			Q_strncpyz(s2, s, sizeof(s2));
			w2 = CG_DrawStrlen(s2) * SMALLCHAR_WIDTH;


			s = va(
				" Score: %s      Speed: %s metres per minute ",
				CG_ConfigString(CS_STU_SCORE),
				CG_ConfigString(CS_EFH_SPEED)
			);
			Q_strncpyz(s3, s, sizeof(s3));
			w3 = CG_DrawStrlen(s3) * SMALLCHAR_WIDTH;


			if (distlimit <= 0) {
				s = "";
			}
			else if (dist < distlimit) {
				s = " Hell didn't play fair... ";
			}
			else {
				if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR) {
					s = " Successful escape! ";
				}
				else {
					s = " You escaped from hell! ";
				}
			}
			Q_strncpyz(s1, s, sizeof(s1));
			w1 = CG_DrawStrlen(s1) * BIGCHAR_WIDTH;


			w = w1;
			if (w2 > w) w = w2;
			if (w3 > w) w = w3;
			x = (SCREEN_WIDTH - w) / 2;
			y = 60;
			CG_FillRect(x, y, w, BIGCHAR_HEIGHT + 2*SMALLCHAR_HEIGHT + 2, backColor);

			x = (SCREEN_WIDTH - w1) / 2;
			y = 60;
			CG_DrawBigString(x, y, s1, fade);

			x = (SCREEN_WIDTH - w2) / 2;
			y = 62 + BIGCHAR_HEIGHT;
			CG_DrawStringExt(x, y, s2, colorWhite, qfalse, qtrue, SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0);

			x = (SCREEN_WIDTH - w3) / 2;
			y = 62 + BIGCHAR_HEIGHT + SMALLCHAR_HEIGHT;
			CG_DrawStringExt(x, y, s3, colorWhite, qfalse, qtrue, SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0);
		}
	}
	else

	if ( cgs.gametype < GT_TEAM) {
		if (cg.snap->ps.persistant[PERS_TEAM] != TEAM_SPECTATOR ) {
			s = va("%s place with %i",
				CG_PlaceString( cg.snap->ps.persistant[PERS_RANK] + 1 ),
				cg.snap->ps.persistant[PERS_SCORE] );
			w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
			x = ( SCREEN_WIDTH - w ) / 2;
			y = 60;
			CG_DrawBigString( x, y, s, fade );
		}
	} else {
        // JUHOX: cgs.scoresX is more up to date than cg.teamScores[]
		cg.teamScores[0] = cgs.scores1;
		cg.teamScores[1] = cgs.scores2;

		if ( cg.teamScores[0] == cg.teamScores[1] ) {
			s = va("Teams are tied at %i", cg.teamScores[0] );
		} else if ( cg.teamScores[0] >= cg.teamScores[1] ) {
			s = va("Red leads %i to %i",cg.teamScores[0], cg.teamScores[1] );
		} else {
			s = va("Blue leads %i to %i",cg.teamScores[1], cg.teamScores[0] );
		}

		w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
		x = ( SCREEN_WIDTH - w ) / 2;
		y = 60;
		CG_DrawBigString( x, y, s, fade );
	}

#if RESPAWN_DELAY	// JUHOX: draw "respawning in x ..." message
	if (
		cg.snap->ps.stats[STAT_HEALTH] > 0 ||
#if MEETING
		cg.predictedPlayerState.pm_type == PM_MEETING ||
#endif
		cg.predictedPlayerState.pm_type == PM_INTERMISSION
	) {
		cg.oldRespawnTimer = 0;
	}
	else if ((cg.snap->ps.stats[STAT_RESPAWN_INFO] >> 2) > 0) {
		int respawnTimer;

		respawnTimer = cg.snap->ps.stats[STAT_RESPAWN_INFO] >> 2;

		s = va("Respawning in %d ...", respawnTimer);
		w = CG_DrawStrlen(s) * BIGCHAR_WIDTH;
		x = (SCREEN_WIDTH - w) / 2;
		y = 83;
		CG_DrawBigString(x, y, s, fade);
		if (
			cg.oldRespawnTimer != respawnTimer &&
			respawnTimer <= 3
		) {
			trap_S_StartLocalSound(cgs.media.respawnWarnSound, CHAN_ANNOUNCER);
		}
		cg.oldRespawnTimer = respawnTimer;
		if (!cg.showScores && cgs.gametype >= GT_TEAM) {
			switch (cg.snap->ps.stats[STAT_RESPAWN_INFO] & 3) {
			case RLT_invalid:
			case RLT_regular:
			default:
				s = "respawn normally";
				break;
			case RLT_here:
				s = "respawn here";
				break;
			case RLT_atPOD:
				s = "respawn at point of death";
				break;
			}
			w = CG_DrawStrlen(s) * BIGCHAR_WIDTH;
			x = (SCREEN_WIDTH - w) / 2;
			y += BIGCHAR_HEIGHT;
			CG_DrawBigString(x, y, s, fade);
		}
	}
	else if ((cg.snap->ps.stats[STAT_RESPAWN_INFO] >> 2) == 0) {
		char* s2;

		switch (cg.snap->ps.stats[STAT_RESPAWN_INFO] & 3) {
		case RLT_invalid:
		case RLT_regular:
		default:
			s = "press <ATTACK> or <USE> to respawn";
			s2 = NULL;
			break;
		case RLT_here:
			s = "press <ATTACK> to respawn here";
			s2 = "press <USE> to respawn normally";
			break;
		case RLT_atPOD:
			s = "press <ATTACK> to respawn at POD";
			s2 = "press <USE> to respawn normally";
			break;
		}
		w = CG_DrawStrlen(s) * BIGCHAR_WIDTH;
		x = (SCREEN_WIDTH - w) / 2;
		y = 83;
		CG_DrawBigString(x, y, s, fade);

		if (s2 && !cg.showScores) {
			w = CG_DrawStrlen(s2) * BIGCHAR_WIDTH;
			x = (SCREEN_WIDTH - w) / 2;
			y += BIGCHAR_HEIGHT;
			CG_DrawBigString(x, y, s2, fade);
		}
	}
#endif

#if 1	// JUHOX: remove the scoreboard for dead spectators
	if (
		!cg.showScores &&
		cg.snap->ps.stats[STAT_HEALTH] <= 0 &&
#if MEETING
		cg.predictedPlayerState.pm_type != PM_MEETING &&
#endif
		cg.predictedPlayerState.pm_type != PM_INTERMISSION
	) {
		return qfalse;
	}
#endif

#if 1	// JUHOX: draw the hunt title above the intermission scoreboard
	if (
		cg.predictedPlayerState.pm_type == PM_INTERMISSION
#if MEETING
		|| cg.predictedPlayerState.pm_type == PM_MEETING
#endif
	) {
		CG_DrawPic(30, 15, 580, 36, cgs.media.huntNameShader);
	}
#endif

	// scoreboard
	y = SB_HEADER;

	CG_DrawPic( SB_SCORE_X + (SB_RATING_WIDTH / 2), y, 64, 32, cgs.media.scoreboardScore );
	CG_DrawPic( SB_PING_X - (SB_RATING_WIDTH / 2), y, 64, 32, cgs.media.scoreboardPing );
	CG_DrawPic( SB_TIME_X - (SB_RATING_WIDTH / 2), y, 64, 32, cgs.media.scoreboardTime );
	CG_DrawPic( SB_NAME_X - (SB_RATING_WIDTH / 2), y, 64, 32, cgs.media.scoreboardName );

	y = SB_TOP;

	// If there are more than SB_MAXCLIENTS_NORMAL, use the interleaved scores
	if ( cg.numScores > SB_MAXCLIENTS_NORMAL ) {
		maxClients = SB_MAXCLIENTS_INTER;
		lineHeight = SB_INTER_HEIGHT;
		topBorderSize = 8;
		bottomBorderSize = 16;
	} else {
		maxClients = SB_MAXCLIENTS_NORMAL;
		lineHeight = SB_NORMAL_HEIGHT;
		topBorderSize = 16;
		bottomBorderSize = 16;
	}

	localClient = qfalse;

	// JUHOX: draw STU scoreboard
	if (cgs.gametype >= GT_STU) {
		// draw similar to FFA (but use TEAM_RED)
		n1 = CG_TeamScoreboard(y, TEAM_RED, fade, maxClients, lineHeight);
		y += (n1 * lineHeight) + BIGCHAR_HEIGHT;
		n2 = CG_TeamScoreboard(y, TEAM_SPECTATOR, fade, maxClients - n1, lineHeight);
		y += (n2 * lineHeight) + BIGCHAR_HEIGHT;
	}
	else

	if ( cgs.gametype >= GT_TEAM ) {
		//
		// teamplay scoreboard
		//
		y += lineHeight/2;

		if ( cg.teamScores[0] >= cg.teamScores[1] ) {
			n1 = CG_TeamScoreboard( y, TEAM_RED, fade, maxClients, lineHeight );
			CG_DrawTeamBackground( 0, y - topBorderSize, 640, n1 * lineHeight + bottomBorderSize, 0.33f, TEAM_RED );
			y += (n1 * lineHeight) + BIGCHAR_HEIGHT;
			maxClients -= n1;
			n2 = CG_TeamScoreboard( y, TEAM_BLUE, fade, maxClients, lineHeight );
			CG_DrawTeamBackground( 0, y - topBorderSize, 640, n2 * lineHeight + bottomBorderSize, 0.33f, TEAM_BLUE );
			y += (n2 * lineHeight) + BIGCHAR_HEIGHT;
			maxClients -= n2;
		} else {
			n1 = CG_TeamScoreboard( y, TEAM_BLUE, fade, maxClients, lineHeight );
			CG_DrawTeamBackground( 0, y - topBorderSize, 640, n1 * lineHeight + bottomBorderSize, 0.33f, TEAM_BLUE );
			y += (n1 * lineHeight) + BIGCHAR_HEIGHT;
			maxClients -= n1;
			n2 = CG_TeamScoreboard( y, TEAM_RED, fade, maxClients, lineHeight );
			CG_DrawTeamBackground( 0, y - topBorderSize, 640, n2 * lineHeight + bottomBorderSize, 0.33f, TEAM_RED );
			y += (n2 * lineHeight) + BIGCHAR_HEIGHT;
			maxClients -= n2;
		}
		n1 = CG_TeamScoreboard( y, TEAM_SPECTATOR, fade, maxClients, lineHeight );
		y += (n1 * lineHeight) + BIGCHAR_HEIGHT;

	} else {
		//
		// free for all scoreboard
		//
		n1 = CG_TeamScoreboard( y, TEAM_FREE, fade, maxClients, lineHeight );
		y += (n1 * lineHeight) + BIGCHAR_HEIGHT;
		n2 = CG_TeamScoreboard( y, TEAM_SPECTATOR, fade, maxClients - n1, lineHeight );
		y += (n2 * lineHeight) + BIGCHAR_HEIGHT;
	}

	if (!localClient) {
		// draw local client at the bottom
		for ( i = 0 ; i < cg.numScores ; i++ ) {
			if ( cg.scores[i].client == cg.snap->ps.clientNum ) {
				CG_DrawClientScore( y, &cg.scores[i], fadeColor, fade, lineHeight == SB_NORMAL_HEIGHT );
				break;
			}
		}
	}

	// JUHOX: draw highscore message

	if (
		cg.predictedPlayerState.pm_type == PM_INTERMISSION &&
		cg.time % 1500 < 1000
	) {
		static vec4_t color = {1, 0.7, 0, 1};

		s = CG_ConfigString(CS_HIGHSCORETEXT);
		w = CG_DrawStrlen(s) * BIGCHAR_WIDTH;
		x = (SCREEN_WIDTH - w) / 2;
		y = 62 + 2*BIGCHAR_HEIGHT;
		if (cgs.gametype == GT_EFH) {
			y = 480 - 1.5*BIGCHAR_HEIGHT;
		}
		CG_DrawBigStringColor(x, y, s, color);
	}

	// load any models that have been deferred
	if ( ++cg.deferredPlayerLoading > 10 ) {
		CG_LoadDeferredPlayers();
	}

	return qtrue;
}

//================================================================================

/*
================
CG_CenterGiantLine
================
*/
static void CG_CenterGiantLine( float y, const char *string ) {
	float		x;
	vec4_t		color;

	color[0] = 1;
	color[1] = 1;
	color[2] = 1;
	color[3] = 1;

	x = 0.5 * ( 640 - GIANT_WIDTH * CG_DrawStrlen( string ) );

	CG_DrawStringExt( x, y, string, color, qtrue, qtrue, GIANT_WIDTH, GIANT_HEIGHT, 0 );
}

/*
=================
CG_DrawTourneyScoreboard

Draw the oversize scoreboard for tournaments
=================
*/
void CG_DrawOldTourneyScoreboard( void ) {
	const char		*s;
	vec4_t			color;
	int				min, tens, ones;
	clientInfo_t	*ci;
	int				y;
	int				i;

	// request more scores regularly
	if ( cg.scoresRequestTime + 2000 < cg.time ) {
		cg.scoresRequestTime = cg.time;
		trap_SendClientCommand( "score" );
	}

	color[0] = 1;
	color[1] = 1;
	color[2] = 1;
	color[3] = 1;

	// draw the dialog background
	color[0] = color[1] = color[2] = 0;
	color[3] = 1;
	CG_FillRect( 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, color );

	// print the mesage of the day
	s = CG_ConfigString( CS_MOTD );
	if ( !s[0] ) {
		s = "Scoreboard";
	}

	// print optional title
	CG_CenterGiantLine( 8, s );

	// print server time
	ones = cg.time / 1000;
	min = ones / 60;
	ones %= 60;
	tens = ones / 10;
	ones %= 10;
	s = va("%i:%i%i", min, tens, ones );

	CG_CenterGiantLine( 64, s );

	// print the two scores
	y = 160;
	if ( cgs.gametype >= GT_TEAM ) {
		//
		// teamplay scoreboard
		//
		CG_DrawStringExt( 8, y, "Red Team", color, qtrue, qtrue, GIANT_WIDTH, GIANT_HEIGHT, 0 );
		s = va("%i", cg.teamScores[0] );
		CG_DrawStringExt( 632 - GIANT_WIDTH * strlen(s), y, s, color, qtrue, qtrue, GIANT_WIDTH, GIANT_HEIGHT, 0 );

		y += 64;

		CG_DrawStringExt( 8, y, "Blue Team", color, qtrue, qtrue, GIANT_WIDTH, GIANT_HEIGHT, 0 );
		s = va("%i", cg.teamScores[1] );
		CG_DrawStringExt( 632 - GIANT_WIDTH * strlen(s), y, s, color, qtrue, qtrue, GIANT_WIDTH, GIANT_HEIGHT, 0 );
	} else {
		//
		// free for all scoreboard
		//
		for ( i = 0 ; i < MAX_CLIENTS ; i++ ) {
			ci = &cgs.clientinfo[i];
			if ( !ci->infoValid ) {
				continue;
			}
			if ( ci->team != TEAM_FREE ) {
				continue;
			}

			CG_DrawStringExt( 8, y, ci->name, color, qtrue, qtrue, GIANT_WIDTH, GIANT_HEIGHT, 0 );
			s = va("%i", ci->score );
			CG_DrawStringExt( 632 - GIANT_WIDTH * strlen(s), y, s, color, qtrue, qtrue, GIANT_WIDTH, GIANT_HEIGHT, 0 );
			y += 64;
		}
	}
}
