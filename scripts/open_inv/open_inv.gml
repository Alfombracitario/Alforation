function open_inv(){
	craftable = get_craftable_items(inventory);
	invopen = true; invmousex = gw>>1;
	invmousey = gh>>1;
	audio_play_sound(sndAccept,0,0,global.sndvol);
	window_mouse_set_locked(false);
}