if(gamepad_button_check_pressed(0, gp_padu))
{
	selected--;
	audio_play_sound(sndSelect,0,0,global.sndvol);
}

if(gamepad_button_check_pressed(0, gp_padd))
{
	selected++;
	audio_play_sound(sndSelect,0,0,global.sndvol);
}
if(gamepad_is_connected(0))
{
	if gamepad_button_check_pressed(0,gp_face1) audio_play_sound(sndAccept,0,0,global.sndvol);
	if gamepad_button_check_pressed(0,gp_face2) audio_play_sound(sndCancel,0,0,global.sndvol);
}
if mouse_check_button_pressed(mb_left) audio_play_sound(sndAccept,0,0,global.sndvol);

selected = selected mod 3;
if selected < 0 selected = 2;
var ww = window_get_width();
var wh = window_get_height();

if (window_get_height() > 1) {
room_height = wh/global.uisize
room_width = ww/global.uisize
surface_resize(application_surface,room_width,room_height);
}