function close_inv(){
	invopen = false;
	window_mouse_set_locked(true);
	audio_play_sound(sndCancel,0,0,global.sndvol); 
	if selector[0] != 0 add_item(selector[0],selector[1],selector[2]);
	selector = [0,0,0];
	
}
