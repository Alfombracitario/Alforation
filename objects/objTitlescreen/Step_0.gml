if(gamepad_button_check_pressed(0, gp_padu))
{
	selected--;
}

if(gamepad_button_check_pressed(0, gp_padd))
{
	selected++;
}
selected = selected mod 3;
if selected < 0 selected = 2;
var ww = window_get_width();
var wh = window_get_height();

if (window_get_height() > 1) {
room_height = wh/global.uisize
room_width = ww/global.uisize
surface_resize(application_surface,room_width,room_height);
}