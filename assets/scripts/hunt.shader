bloodExplosion
{
	cull disable
	{
		animmap 10 models/weaphits/blood201.tga models/weaphits/blood202.tga models/weaphits/blood203.tga models/weaphits/blood204.tga models/weaphits/blood205.tga
		blendfunc blend
		alphagen wave inversesawtooth 0 1 0 10
	}
	{
		animmap 10 models/weaphits/blood202.tga models/weaphits/blood203.tga models/weaphits/blood204.tga models/weaphits/blood205.tga gfx/2d/transparent.tga
		blendfunc blend
		alphagen wave sawtooth 0 1 0 10
	}
}

gfx/damage/monster_blood_explosion
{
	{
		map gfx/damage/monster_blood_explosion.tga
		blendfunc blend
		alphagen vertex
	}
}

monsterBloodMark
{
	nopicmip
	polygonOffset
	{
		clampmap gfx/damage/monster_blood_stain.tga
		blendFunc gl_src_alpha gl_one_minus_src_alpha
		rgbGen identityLighting
		alphaGen vertex
	}
}
monsterBloodTrail1
{
	nopicmip
	entitymergable
	{
        map gfx/damage/monster_blood_spurt.tga
		blendFunc gl_src_alpha gl_one_minus_src_alpha
		rgbgen vertex
		alphagen vertex
	}
}
monsterBloodTrail2
{
	nopicmip
	entitymergable
	{
        map gfx/damage/monster_blood_explosion.tga
		blendFunc gl_src_alpha gl_one_minus_src_alpha
		rgbgen vertex
		alphagen vertex
	}
}
deathBlurry
{
	nopicmip
	{
		map textures/sfx/detail.tga
	    blendfunc gl_src_alpha gl_one_minus_src_alpha
		alphagen vertex
	}
}

plasmaParticle
{
	cull none
	{
		clampmap gfx/misc/raildisc_mono2.tga 
		blendfunc gl_src_alpha gl_one
		rgbgen vertex
		alphagen vertex
        tcMod rotate -30
	}
}

hotAir
{
	{
		map textures/effects/hotair1.tga
		blendfunc gl_zero gl_one_minus_src_color
		rgbgen vertex
		tcmod rotate 101
	}
	{
		map textures/effects/hotair2.tga
		blendfunc gl_dst_color gl_one
		rgbgen vertex
		tcmod rotate -31
	}
}

scannerFilter
{
	nopicmip
	{
		map $whiteimage
	        blendfunc gl_dst_color gl_one
	}
	{
		map textures/sfx/detail.tga
	        blendfunc gl_dst_color gl_src_color
	}
	{
		map $whiteimage
	        blendfunc gl_zero gl_src_color
		rgbgen vertex
	}
	{
		map $whiteimage
	        blendfunc gl_dst_color gl_one
	}
	{
		map $whiteimage
	        blendfunc gl_dst_color gl_one
	}
	{
		map $whiteimage
	        blendfunc gl_dst_color gl_one
	}
	{
		map $whiteimage
	        blendfunc gl_dst_color gl_one
	}
}

scannerSegment
{
	nopicmip
	{
		map $whiteimage
		blendfunc gl_one gl_zero
		rgbgen vertex
	}
}

lightAmplifier
{
	{
		map $whiteimage
	        blendfunc gl_dst_color gl_one
	}
	{
		map $whiteimage
	        blendfunc gl_dst_color gl_one
	}
	{
		map $whiteimage
	        blendfunc gl_dst_color gl_one
	}
	{
		map $whiteimage
	        blendfunc gl_dst_color gl_one
	}
}

monsterGlow
{
	deformVertexes wave 100 sin 0.5 0 0 0
	{
		map textures/effects/monsterglow.tga
		blendfunc gl_one gl_one
		rgbgen entity
		tcmod rotate 5.1
		tcmod scale 0.25 0.25
		tcmod scroll 0.05 0.17
	}
}

spawnHull
{
	deformVertexes wave 100 sin 0.2 0 0 0
	{
		map $whiteimage
		blendfunc gl_src_alpha gl_one_minus_src_alpha
		alphagen entity
		rgbgen identitylighting
	}
}

spawnHullGlow1
{
	deformVertexes wave 100 sin 2 0 0 0
	{
		map $whiteimage
		blendfunc gl_src_alpha gl_one
		alphagen entity
		rgbgen identitylighting
	}
}

spawnHullGlow2
{
	deformVertexes wave 100 sin 4 0 0 0
	{
		map $whiteimage
		blendfunc gl_src_alpha gl_one
		alphagen entity
		rgbgen identitylighting
	}
}

spawnHullGlow3
{
	deformVertexes wave 100 sin 6 0 0 0
	{
		map $whiteimage
		blendfunc gl_src_alpha gl_one
		alphagen entity
		rgbgen identitylighting
	}
}

spawnHullGlow4
{
	deformVertexes wave 100 sin 8 0 0 0
	{
		map $whiteimage
		blendfunc gl_src_alpha gl_one
		alphagen entity
		rgbgen identitylighting
	}
}

spawnHullWeapon
{
	deformVertexes wave 100 sin 0.1 0 0 0
	{
		map $whiteimage
		blendfunc gl_src_alpha gl_one_minus_src_alpha
		alphagen entity
		rgbgen identitylighting
	}
}

spawnHullGlow1Weapon
{
	deformVertexes wave 100 sin 0.3 0 0 0
	{
		map $whiteimage
		blendfunc gl_src_alpha gl_one
		alphagen entity
		rgbgen identitylighting
	}
}

spawnHullGlow2Weapon
{
	deformVertexes wave 100 sin 0.6 0 0 0
	{
		map $whiteimage
		blendfunc gl_src_alpha gl_one
		alphagen entity
		rgbgen identitylighting
	}
}

spawnHullGlow3Weapon
{
	deformVertexes wave 100 sin 0.9 0 0 0
	{
		map $whiteimage
		blendfunc gl_src_alpha gl_one
		alphagen entity
		rgbgen identitylighting
	}
}

spawnHullGlow4Weapon
{
	deformVertexes wave 100 sin 1.2 0 0 0
	{
		map $whiteimage
		blendfunc gl_src_alpha gl_one
		alphagen entity
		rgbgen identitylighting
	}
}

gfx/2d/bigchar0
{
	nopicmip
	nomipmaps
	{
		map gfx/2d/bigchar0.tga
		blendFunc gl_src_alpha gl_one_minus_src_alpha 
		rgbgen vertex
	}
}
gfx/2d/bigchar1
{
	nopicmip
	nomipmaps
	{
		map gfx/2d/bigchar1.tga
		blendFunc gl_src_alpha gl_one_minus_src_alpha 
		rgbgen vertex
	}
}
gfx/2d/bigchar2
{
	nopicmip
	nomipmaps
	{
		map gfx/2d/bigchar2.tga
		blendFunc gl_src_alpha gl_one_minus_src_alpha 
		rgbgen vertex
	}
}
gfx/2d/bigchar3
{
	nopicmip
	nomipmaps
	{
		map gfx/2d/bigchar3.tga
		blendFunc gl_src_alpha gl_one_minus_src_alpha 
		rgbgen vertex
	}
}
gfx/2d/bigchar4
{
	nopicmip
	nomipmaps
	{
		map gfx/2d/bigchar4.tga
		blendFunc gl_src_alpha gl_one_minus_src_alpha 
		rgbgen vertex
	}
}
gfx/2d/bigchar5
{
	nopicmip
	nomipmaps
	{
		map gfx/2d/bigchar5.tga
		blendFunc gl_src_alpha gl_one_minus_src_alpha 
		rgbgen vertex
	}
}
gfx/2d/bigchar6
{
	nopicmip
	nomipmaps
	{
		map gfx/2d/bigchar6.tga
		blendFunc gl_src_alpha gl_one_minus_src_alpha 
		rgbgen vertex
	}
}
gfx/2d/bigchar7
{
	nopicmip
	nomipmaps
	{
		map gfx/2d/bigchar7.tga
		blendFunc gl_src_alpha gl_one_minus_src_alpha 
		rgbgen vertex
	}
}

models/fonts/hunt1
{
	{
		map textures/effects/tinfxb.tga
		blendfunc gl_src_alpha gl_one_minus_src_alpha
		rgbgen identitylighting
		alphagen entity
		tcgen environment
		depthwrite
	}
}

creditsGlare
{
	{
		map $whiteimage
		blendfunc gl_src_alpha gl_one
		rgbgen identitylighting
		alphagen vertex
	}
}

powerups/shield
{
	deformVertexes wave 100 sin 1 0 0 0
	{
		map textures/effects/shieldmap.tga
		blendfunc gl_one gl_one
		tcmod rotate 15
		tcmod scroll 2 .1
		tcgen environment
        rgbgen wave sin 0 1 0 3
	}
}

powerups/shieldWeapon
{
	deformVertexes wave 100 sin 0.5 0 0 0
	{
		map textures/effects/shieldmap.tga
		blendfunc gl_one gl_one
		tcmod rotate 15
		tcmod scroll 2 .1
		tcgen environment
        rgbgen wave sin 0.5 0.5 0 3
	}
}

powerups/charge
{
	deformVertexes wave 100 sin 1 0 0 0
	{
		map textures/effects/chargemap.tga
		blendfunc gl_src_alpha gl_one
		tcmod rotate 75
		tcmod scroll 11 .1
		tcgen environment
		alphagen entity
	}
}

powerups/chargeWeapon
{
	deformVertexes wave 100 sin 0.5 0 0 0
	{
		map textures/effects/chargemap.tga
		blendfunc gl_src_alpha gl_one
        tcmod rotate 75
        tcmod scroll 11 .1
		tcgen environment
		alphagen entity
	}
}

powerups/stdInvis
{
	{
		map textures/effects/invismap.tga
		blendfunc gl_dst_color gl_src_color
		tcGen environment
		tcmod scale 0.3 0.3
		tcmod rotate 5
		tcmod scroll 0.5 .1
	}
}
powerups/blueInvis
{
	{
		map textures/effects/quadmap2.tga
		blendfunc gl_one gl_one
		tcgen environment
		tcmod rotate 30
		tcmod scroll 1 .1
	}
}

powerups/redInvis
{
	{
		map textures/effects/regenmap2.tga
		blendfunc gl_one gl_one
		tcGen environment
		tcmod rotate 30
		tcmod scroll 1 .1
	}
}

powerups/targetMarker
{
	deformVertexes wave 100 sin 3 0 0 0
	{
		map textures/effects/targetmarker.tga
		blendfunc gl_one gl_one
		tcgen environment
        tcmod rotate 30
        tcmod scroll 1 .1
	}
}

powerups/glassCloaking
{
	sort portal
	{
		map $whiteimage
		blendfunc gl_zero gl_one
		depthwrite
	}
}

powerups/glassCloakingSpecular
{
	{
		map textures/effects/invismap.tga
		blendfunc gl_src_alpha gl_one
		alphagen entity
		tcmod turb 0 0.15 0 0.25
		tcgen environment
	}
}

dischargeFlash
{
	cull none
	{
		map gfx/misc/dischargeflash.tga
		blendfunc gl_one gl_one
	}
}

thread
{
	cull none
	{
		map gfx/misc/thread.tga
		blendfunc gl_src_alpha gl_one_minus_src_alpha 
	}
}

stone
{
	{
		map textures/efh01/brick.tga
		rgbgen lightingdiffuse
		tcgen vector ( 0.01 0.005 0 ) ( 0 0.01 0.005 )
	}
}

models/weapons2/bfg/reloading
{
	deformVertexes wave 100 sin 0.2 0 0 0
	{
		map textures/effects/envmaprail.tga
		blendfunc gl_one gl_one
        tcgen environment
        tcmod rotate 30
		tcmod scroll 1 1
        rgbgen wave sin 0.55 0.45 0 1.5
	}
}

models/weapons2/machinegun/barrel
{
	{
		map models/weapons2/machinegun/barrel.tga
		rgbgen lightingdiffuse
		tcgen environment
	}
	{
		map textures/base_wall/chrome_env2.tga
		blendfunc add
		tcgen environment
		tcmod scale 0.3 0.3
		rgbgen wave sin 0.2 0 0 0
	}
}

models/weapons2/machinegun/shaft
{
	{
		map textures/base_wall/chrome_env2.tga
		tcgen environment
		rgbgen wave sin 0.175 0 0 0
	}
}

models/weapons2/machinegun/connector_front
{
	{
		map models/weapons2/machinegun/connector_front.tga
		rgbgen lightingdiffuse
	}
}

grappleRope
{
	cull none
	nomipmaps
	{
		map gfx/misc/grapplerope.tga
		blendfunc gl_src_alpha gl_one_minus_src_alpha
		alphagen entity
		tcmod scale 40 1
	}
}

models/weapons2/grapple/hook
{
	{
		map textures/base_wall/chrome_env2.tga
		rgbgen identitylighting
		tcgen environment
	}
}

models/weapons2/grapple/grapple01
{
	{
		map models/weapons2/grapple/grapple01.tga
		rgbgen lightingdiffuse
		tcmod scale 2 2
	}
}
models/weapons2/grapple/grapple02
{
	{
		map models/weapons2/grapple/grapple02.tga
		rgbgen lightingdiffuse
		tcmod scale 2 1
	}
}
models/weapons2/grapple/grapple03
{
	{
		map models/weapons2/grapple/grapple01.tga
		rgbgen lightingdiffuse
	}
}
models/weapons2/grapple/grapple06
{
	{
		map models/weapons2/grapple/grapple10.tga
		rgbgen lightingdiffuse
	}
}
models/weapons2/grapple/grapple07
{
	{
		map models/weapons2/grapple/grapple10.tga
		rgbgen lightingdiffuse
	}
}
models/weapons2/grapple/grapple08
{
	{
		map models/weapons2/grapple/grapple10.tga
		rgbgen lightingdiffuse
	}
}
models/weapons2/grapple/grapple09
{
	{
		map models/weapons2/grapple/grapple10.tga
		rgbgen lightingdiffuse
	}
}


models/weapons2/monsterl/monsterl
{
	{
		map models/weapons2/monsterl/monsterl.tga
		rgbgen lightingdiffuse
	}
}

models/weapons2/monsterl/seed
{
	{
		map models/weapons2/monsterl/seed.tga
		rgbgen identitylighting
		tcgen environment
	}
}

flame1
{
	{
		map sprites/flame1.tga
		blendfunc gl_one gl_one
		rgbgen vertex
	}
	{
		map sprites/flame_core.tga
		blendfunc gl_src_alpha gl_one
		alphagen vertex
	}
}

bfgLFStar
{
	sort nearest
	{
		map sprites/bfglfstar.tga
		blendfunc gl_src_alpha gl_one
		alphagen vertex
		rgbgen vertex
	}
}

bfgLFGlare
{
	sort nearest
	{
		map sprites/bfglfglare.tga
		blendfunc gl_src_alpha gl_one
		alphagen vertex
		rgbgen vertex
	}
}
bfgSuperExpl
{
	{
		map sprites/bfglfglare.tga
		blendfunc gl_src_alpha gl_one
		alphagen vertex
		rgbgen vertex
	}
}

bfgLFDisc
{
	sort nearest
	{
		map sprites/bfglfdisc.tga
		blendfunc gl_src_alpha gl_one
		alphagen vertex
		rgbgen vertex
	}
}

bfgLFRing
{
	sort nearest
	{
		map sprites/bfglfring.tga
		blendfunc gl_src_alpha gl_one
		alphagen vertex
		rgbgen vertex
	}
}

bfgLFLine
{
	nomipmaps
	nopicmip
	sort nearest
	{
		clampmap sprites/bfglfline.tga
		blendfunc gl_src_alpha gl_one
		alphagen vertex
		rgbgen vertex
		tcmod transform 1 0 0 64 0 -31.5
	}
}

lightningBoltHunt
{
	cull none
	{
		map gfx/misc/lightning.tga
		blendfunc add
		tcMod scroll -2 0
	}
}

navAidLine
{
	cull none
	{
		map gfx/misc/navaidline.tga
		blendfunc gl_one gl_one
		tcmod scroll -1 0
	}
}

navAidLine2
{
	cull none
	{
		map gfx/misc/navaidline2.tga
		blendfunc gl_one gl_one
		tcmod scroll -1 0
	}
}

navAidTarget
{
	nomipmaps
	nopicmip
	{
		map sprites/targetmarker.tga
		blendfunc gl_src_alpha gl_one_minus_src_alpha
	}
}

navAidGoal
{
	nopicmip
	{
		map sprites/goalmarker.tga
		blendfunc gl_src_alpha gl_one_minus_src_alpha
	}
}

tssgroupTemporary
{
	nopicmip
	{
		map sprites/groupt.tga
		blendfunc gl_src_alpha gl_one_minus_src_alpha
		rgbgen vertex
	}
}
tssgroupDesignated
{
	nopicmip
	{
		map sprites/groupd.tga
		blendfunc gl_src_alpha gl_one_minus_src_alpha
		rgbgen vertex
	}
}
tssgroupA
{
	nopicmip
	{
		map sprites/group_a.tga
		blendfunc gl_src_alpha gl_one_minus_src_alpha
		rgbgen vertex
	}
}
tssgroupB
{
	nopicmip
	{
		map sprites/group_b.tga
		blendfunc gl_src_alpha gl_one_minus_src_alpha
		rgbgen vertex
	}
}
tssgroupC
{
	nopicmip
	{
		map sprites/group_c.tga
		blendfunc gl_src_alpha gl_one_minus_src_alpha
		rgbgen vertex
	}
}
tssgroupD
{
	nopicmip
	{
		map sprites/group_d.tga
		blendfunc gl_src_alpha gl_one_minus_src_alpha
		rgbgen vertex
	}
}
tssgroupE
{
	nopicmip
	{
		map sprites/group_e.tga
		blendfunc gl_src_alpha gl_one_minus_src_alpha
		rgbgen vertex
	}
}
tssgroupF
{
	nopicmip
	{
		map sprites/group_f.tga
		blendfunc gl_src_alpha gl_one_minus_src_alpha
		rgbgen vertex
	}
}
tssgroupG
{
	nopicmip
	{
		map sprites/group_g.tga
		blendfunc gl_src_alpha gl_one_minus_src_alpha
		rgbgen vertex
	}
}
tssgroupH
{
	nopicmip
	{
		map sprites/group_h.tga
		blendfunc gl_src_alpha gl_one_minus_src_alpha
		rgbgen vertex
	}
}
tssgroupI
{
	nopicmip
	{
		map sprites/group_i.tga
		blendfunc gl_src_alpha gl_one_minus_src_alpha
		rgbgen vertex
	}
}
tssgroupJ
{
	nopicmip
	{
		map sprites/group_j.tga
		blendfunc gl_src_alpha gl_one_minus_src_alpha
		rgbgen vertex
	}
}

lfeditorcursor
{
	{
		map $whiteimage
		blendfunc gl_one gl_zero
		rgbgen entity
	}
}

lfdisc1
{
	sort nearest
	{
		map sprites/lfdisc1.tga
		blendfunc gl_src_alpha gl_one
		alphagen vertex
		rgbgen vertex
	}
}

lfdisc2
{
	sort nearest
	{
		map sprites/lfdisc2.tga
		blendfunc gl_src_alpha gl_one
		alphagen vertex
		rgbgen vertex
	}
}

lfarc1
{
	sort nearest
	{
		map sprites/lfarc1.tga
		blendfunc gl_src_alpha gl_one
		alphagen vertex
		rgbgen vertex
	}
}


lfring1
{
	sort nearest
	{
		map sprites/lfring1.tga
		blendfunc gl_src_alpha gl_one
		alphagen vertex
		rgbgen vertex
	}
}

//Hell Model Pack for HUNT
models/players/sorlag/guard
{
	{
		map models/players/sorlag/guard.tga
		rgbGen lightingDiffuse
	}
	{
		map models/players/sorlag/guard_glow.tga
		blendfunc add
		rgbGen wave sin 0.9 0.1 0 8 
	}
}

models/players/sorlag/guard_t
{
	{
		map models/players/sorlag/guard_t.tga
		rgbGen lightingDiffuse
	}
	{
		map models/players/sorlag/guard_t_glow.tga
		blendfunc add
		rgbGen wave sin 0.9 0.1 0 8 
	}
}

models/players/uriel/titan
{
	{
		map models/players/uriel/titan.tga
		rgbGen lightingDiffuse
	}
	{
		map models/players/uriel/titan_glow.tga
		blendfunc add
		rgbGen wave sin 0.9 0.1 0 8 
	}
}

models/players/uriel/titan_h
{
	{
		map models/players/uriel/titan_h.tga
		rgbGen lightingDiffuse
	}
	{
		map textures/sfx/firegorre.tga
		blendfunc add
		rgbGen identity
		tcMod scroll -0.2 1
	}
	{
		map models/players/uriel/titan_h.tga
		blendfunc blend
		rgbGen lightingDiffuse
	}
}

models/players/uriel/titan_w
{
	deformVertexes wave 100 sin 0 0.5 0 0.2 
	{
		map models/players/uriel/titan_w.tga
		rgbGen lightingDiffuse
		depthWrite
		alphaFunc GE128
	}
	{
		map models/players/uriel/titan_w_glow.tga
		blendfunc add
		rgbGen wave sin 0.9 0.1 0 8 
		depthFunc equal
	}
}

models/players/klesk/predator
{
	{
		map models/players/klesk/predator.tga
		rgbGen lightingDiffuse
	}
	{
		map models/players/klesk/predator_glow.tga
		blendfunc add
		rgbGen wave sin 0.9 0.1 0 8 
	}
}

models/players/klesk/predator_h
{
	{
		map models/players/klesk/predator_h.tga
		rgbGen lightingDiffuse
	}
	{
		map models/players/klesk/predator_h_glow.tga
		blendfunc add
		rgbGen wave sin 0.9 0.1 0 8 
	}
}

models/gibs/monstergibs
{
	{
		map models/gibs/monstergibs.tga
		rgbGen lightingDiffuse
	}
	{
		map textures/effects/firegorre_red.tga
		blendfunc add
		rgbGen identity
		tcMod scroll -0.4 2
		tcMod scale 2 2
		tcMod rotate 36
	}
	{
		map models/gibs/monstergibs.tga
		blendfunc blend
		rgbGen lightingDiffuse
	}
}
