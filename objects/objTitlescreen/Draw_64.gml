var rw = room_width;
var rh = room_height;
if(screen == -1)
{
	var scale;
	var color;
	draw_sprite(intro[0][0],0,rw*0.5,(rh*0.265)+rh*intro[0][2]);
	for (var i = 1; i < 4; i++)
	{
		
		if(i != 3)
		{
		gpu_set_tex_filter(true);
		var vpos = sprite_get_height(intro[i][0])*0.45;
		var sprw = sprite_get_width(intro[i][0]);
		var rwh = rw*0.5;
		draw_sprite_pos(sprIshadow,0,
		rwh-sprw*0.525,
		rh*intro[i][2]+vpos-2,
		rwh+sprw *0.525,
		rh*intro[i][2]+vpos-2,
		rwh+sprw *0.5,
		rh*intro[i][2]+vpos+2,
		rwh-sprw *0.5,
		rh*intro[i][2]+vpos+2,
		_alpha
		);
		gpu_set_tex_filter(false);
		for(var j = 0; j < 8; j++)
			{
				var color = merge_color($100000,$C0A0A0,j*0.125);
				scale = 0.9402+(j*0.0078125);
				draw_sprite_ext(intro[i][0],0,rw*0.5+rw*intro[i][1],rh*intro[i][2],scale,scale,0,color,1);
			}
		}
		draw_sprite(intro[i][0],0,rw*0.5+rw*intro[i][1],rh*intro[i][2]);
	}
}
else
{
	for (var i = 0; i < bc; i++)
	{
		var _bl = 0; 
		if selected == i _bl = 1;
		draw_sprite_ext(sprButton,_bl,rw*button[i][3],button[i][4],button[i][1],button[i][2],0,c_white,1);
		draw_text_shadow(rw*button[i][3],button[i][4],button[i][5]);
	}
}
if(intro_tic != 0)
{
	draw_sprite_tiled(sprTransition,intro_tic,0,0);
}
/*if(screen == 0)
{
	draw_sprite_ext(sprTitle,0,room_width>>1,room_height*0.15,0.5,0.5,0,c_white,1);
}
*/