display_set_gui_size(w,h)
shader_set(sGrayscale);
draw_sprite_ext(surf,0,0,0,1,1,0,c_gray,1);
shader_reset();
display_set_gui_size(gw,gh)

draw_set_font(global.font2);
draw_text_shadow(gw>>1,16,"Game paused")


for (var i = 0; i < bc; i++)
{
	var _bl = 0; 
	if hsel == i _bl = 1;
	draw_sprite_ext(sprButton,_bl,button[i][3],button[i][4],button[i][1],button[i][2],0,c_white,1);
	draw_text_shadow(button[i][3],button[i][4],button[i][5]);
}