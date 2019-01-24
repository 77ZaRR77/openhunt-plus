textures/efh01/skybox
{
	qer_editorimage textures/efh01/skybox_up.tga
	surfaceparm noimpact
	surfaceparm nolightmap
	surfaceparm nomarks
	q3map_sun 1 1 1 100 290 50
	skyParms textures/efh01/skybox 512 -
	{
		map textures/efh01/clouds_alpha.tga
		blendfunc gl_zero gl_one_minus_src_color
		tcMod scroll 0.01 0.005
		tcMod scale 2 2
	}
	{
		map textures/efh01/clouds_image.tga
		blendfunc add
		tcMod scroll 0.01 0.005
		tcMod scale 2 2
	}
}

textures/efh01/nearbox_lf
{
	cull disable
	sort sky
	{
		clampmap textures/efh01/nearbox_alpha_lf.tga
		blendfunc gl_zero gl_one_minus_src_color
	}
	{
		clampmap textures/efh01/nearbox_rgb_lf.tga
		blendfunc add
	}
}

textures/efh01/nearbox_ft
{
	cull disable
	sort sky
	{
		clampmap textures/efh01/nearbox_alpha_ft.tga
		blendfunc gl_zero gl_one_minus_src_color
	}
	{
		clampmap textures/efh01/nearbox_rgb_ft.tga
		blendfunc add
	}
}

textures/efh01/nearbox_rt
{
	cull disable
	sort sky
	{
		clampmap textures/efh01/nearbox_alpha_rt.tga
		blendfunc gl_zero gl_one_minus_src_color
	}
	{
		clampmap textures/efh01/nearbox_rgb_rt.tga
		blendfunc add
	}
}

textures/efh01/nearbox_bk
{
	cull disable
	sort sky
	{
		clampmap textures/efh01/nearbox_alpha_bk.tga
		blendfunc gl_zero gl_one_minus_src_color
	}
	{
		clampmap textures/efh01/nearbox_rgb_bk.tga
		blendfunc add
	}
}

textures/efh01/nearbox_dn
{
	cull disable
	sort sky
	{
		clampmap textures/efh01/nearbox_rgb_dn.tga
	}
}

textures/efh01/efh_white_blend
{
	qer_editorimage textures/efh01/efh_white_blend.tga
	surfaceparm nolightmap
	surfaceparm nonsolid
	surfaceparm trans
	cull disable
	{
		map textures/efh01/efh_white_blend.tga
		blendfunc add
	}
}

textures/efh01/wall
{
	qer_editorimage textures/efh01/brick.tga
	{
		map $lightmap
		rgbgen identity
	}
	{
		// hi-detail
		detail
		map textures/efh01/brick_detail.tga
		blendfunc gl_dst_color gl_src_color
		tcmod scale 7.1 7.3
	}
	{
		// lo-detail
		map textures/efh01/floor_detail.tga
		blendfunc gl_dst_color gl_src_color
		tcmod scale 0.111 0.131
	}
	{
		map textures/efh01/brick.tga
		blendfunc filter
		tcmod scale 2 2
	}
}

textures/efh01/floor
{
	{
		map $lightmap
		rgbgen identity
	}
	{
		// hi-detail
		detail
		map textures/efh01/floor_detail.tga
		blendFunc gl_dst_color gl_src_color
		tcmod scale 7.1 7.3
	}
	{
		// lo-detail
		map textures/efh01/floor_detail.tga
		blendFunc gl_dst_color gl_src_color
		tcmod scale 0.211 0.231
	}
	{
		map textures/efh01/floor.tga
		blendfunc filter
	}
}

textures/efh01/wood
{
	qer_editorimage textures/gothic_ceiling/woodceiling1a.tga
	{
		map $lightmap
		rgbgen identity
	}
	{
		// hi-detail
		detail
		map textures/efh01/wood_detail.tga
		blendFunc gl_dst_color gl_src_color
		tcmod scale 7.1 7.3
	}
	{
		map textures/gothic_ceiling/woodceiling1a.tga
		blendfunc filter
	}
}

