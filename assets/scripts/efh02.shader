textures/efh02/efh_flame01_lava
{
	qer_editorimage textures/sfx/flame1.tga
	surfaceparm lava
	surfaceparm nolightmap
	surfaceparm nomarks
	surfaceparm trans
	surfaceparm water
	cull disable
	q3map_surfacelight 5500
	{
		animmap 10 textures/sfx/flame1.tga textures/sfx/flame2.tga textures/sfx/flame3.tga textures/sfx/flame4.tga textures/sfx/flame5.tga textures/sfx/flame6.tga textures/sfx/flame7.tga textures/sfx/flame8.tga 
		blendfunc add
		rgbGen wave inversesawtooth 0 1 0 10 
	}
	{
		animmap 10 textures/sfx/flame2.tga textures/sfx/flame3.tga textures/sfx/flame4.tga textures/sfx/flame5.tga textures/sfx/flame6.tga textures/sfx/flame7.tga textures/sfx/flame8.tga textures/sfx/flame1.tga 
		blendfunc add
		rgbGen wave sawtooth 0 1 0 10 
	}
	{
		map textures/sfx/flameball.tga
		blendfunc add
		rgbGen wave sin 0.6 0.2 0 0.6 
	}
}

textures/efh02/efh_lava_caulk
{
	surfaceparm lava
	surfaceparm nodraw
	surfaceparm nolightmap
	surfaceparm nomarks
	surfaceparm trans
	surfaceparm water
}

textures/efh02/efh_flame01_slime
{
	qer_editorimage textures/sfx/flame1.tga
	surfaceparm nolightmap
	surfaceparm nomarks
	surfaceparm slime
	surfaceparm trans
	surfaceparm water
	cull disable
	q3map_surfacelight 5500
	{
		animmap 10 textures/sfx/flame1.tga textures/sfx/flame2.tga textures/sfx/flame3.tga textures/sfx/flame4.tga textures/sfx/flame5.tga textures/sfx/flame6.tga textures/sfx/flame7.tga textures/sfx/flame8.tga 
		blendfunc add
		rgbGen wave inversesawtooth 0 1 0 10 
	}
	{
		animmap 10 textures/sfx/flame2.tga textures/sfx/flame3.tga textures/sfx/flame4.tga textures/sfx/flame5.tga textures/sfx/flame6.tga textures/sfx/flame7.tga textures/sfx/flame8.tga textures/sfx/flame1.tga 
		blendfunc add
		rgbGen wave sawtooth 0 1 0 10 
	}
	{
		map textures/sfx/flameball.tga
		blendfunc add
		rgbGen wave sin 0.6 0.2 0 0.6 
	}
}

textures/efh02/efh_slime_caulk
{
	surfaceparm nodraw
	surfaceparm nolightmap
	surfaceparm nomarks
	surfaceparm slime
	surfaceparm trans
	surfaceparm water
}

textures/efh02/efh_glowing_white
{
	qer_editorimage textures/efh02/white.tga
	surfaceparm nolightmap
	surfaceparm nomarks
	q3map_surfacelight 1500
	{
		map textures/efh02/white.tga
	}
}

textures/efh02/efh_pitch_black
{
	qer_editorimage textures/skies/blacksky.tga
	surfaceparm noimpact
	surfaceparm nolightmap
	{
		map gfx/colors/black.tga
	}
}

textures/efh02/efh_white_blend
{
	qer_editorimage textures/efh02/efh_white_blend.tga
	surfaceparm nolightmap
	surfaceparm trans
	{
		map textures/efh02/efh_white_blend.tga
		blendfunc add
	}
}

