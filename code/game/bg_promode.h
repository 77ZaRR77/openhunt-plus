/// bg_promode.h - CPM Physics addition - implemented by SLK


extern float cpm_pm_jump_z;

// Physics
extern float	cpm_pm_airstopaccelerate;
extern float	cpm_pm_aircontrol;
extern float	cpm_pm_strafeaccelerate;
extern float	cpm_pm_wishspeed;
extern float	pm_accelerate;
extern float	pm_friction;

void CPM_UpdateSettings(int num);
void CPM_PM_Aircontrol ( pmove_t *pm, vec3_t wishdir, float wishspeed );

#define CS_PRO_MODE 16
