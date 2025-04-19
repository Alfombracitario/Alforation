var text = "Create new world"
draw_text_shadow(x+(sprite_width-string_width(text))*0.5,y+sprite_height*0.5-4,text);
if(mode == 1)
{
    for (var i = 0; i < bc; i++)
	{
		var _bl = 3; 
		if selected == i _bl = 4;
		draw_sprite_ext(sprContainer,_bl,room_width*button[i][3],button[i][4]-5,button[i][1],button[i][2],0,c_white,1);
		draw_text_shadow(room_width*button[i][3],button[i][4],button[i][5]);
	}
}