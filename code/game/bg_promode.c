/// bg_promode.c - CPM Physics addition - implemented by SLK

#include "q_shared.h"
#include "bg_public.h"
#include "bg_local.h"
#include "bg_promode.h"

float cpm_pm_jump_z;

// Physics
float	cpm_pm_airstopaccelerate = 1;
float	cpm_pm_aircontrol = 0;
float	cpm_pm_strafeaccelerate = 1;
float	cpm_pm_wishspeed = 400;

void CPM_UpdateSettings(int num)
{
    // vq3
	cpm_pm_jump_z = 0; // turn off double-jump in vq3

    // Physics
	cpm_pm_airstopaccelerate = 1;
	cpm_pm_aircontrol = 0;
	cpm_pm_strafeaccelerate = 1;
	cpm_pm_wishspeed = 400;
	pm_accelerate = 10;
	pm_friction = 6;

	if (num) // pro mode
	{
		cpm_pm_jump_z = 100; // enable double-jump

		// Physics
		cpm_pm_airstopaccelerate = 2.5;
		cpm_pm_aircontrol = 150;
		cpm_pm_strafeaccelerate = 70;
		cpm_pm_wishspeed = 30;
		pm_accelerate = 15;
		pm_friction = 8;
	}

}

void CPM_PM_Aircontrol (pmove_t *pm, vec3_t wishdir, float wishspeed )
{
	float	zspeed, speed, dot, k;
	int		i;

	if ( (pm->ps->movementDir && pm->ps->movementDir !=4) || wishspeed == 0.0)
		return; // can't control movement if not moveing forward or backward

	zspeed = pm->ps->velocity[2];
	pm->ps->velocity[2] = 0;
	speed = VectorNormalize(pm->ps->velocity);

	dot = DotProduct(pm->ps->velocity,wishdir);
	k = 32;
	k *= cpm_pm_aircontrol*dot*dot*pml.frametime;


	if (dot > 0) {	// we can't change direction while slowing down
		for (i=0; i < 2; i++)
			pm->ps->velocity[i] = pm->ps->velocity[i]*speed + wishdir[i]*k;
		VectorNormalize(pm->ps->velocity);
	}

	for (i=0; i < 2; i++)
		pm->ps->velocity[i] *=speed;

	pm->ps->velocity[2] = zspeed;
}
