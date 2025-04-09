var rw = room_width;
for (var i = 0; i < bc; i++)
{
	var _bl = 0; 
	if selected == i _bl = 1;
	draw_sprite_ext(sprButton,_bl,rw*button[i][3],button[i][4],button[i][1],button[i][2],0,c_white,1);
	draw_text_shadow(rw*button[i][3],button[i][4],button[i][5]);
}