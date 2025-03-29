if (mouse_x > x  && mouse_x < x + sprite_width &&
    mouse_y > y  && mouse_y < y + sprite_height ) {
    objBloadworld.selectedworld = Bid;
	image_index = 1;
	if mouse_check_button_pressed(mb_left) event_user(0);
}
else
{
	image_index = 2;
}
if(gamepad_is_connected(0))
{	
	if objBloadworld.selectedworld == Bid image_index = 1; else image_index = 0;
	if image_index == 1 && gamepad_button_check_pressed(0,gp_face1) event_user(0);
}
if objBloadworld.locked == Bid image_index = 0;
image_xscale = (room_width*0.05)-1.6;