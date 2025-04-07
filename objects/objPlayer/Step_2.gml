if(keyboard_check_pressed(ord("Q"))) do_player_hurt(5);

previnvmousex = invmousex;
previnvmousey = invmousey;

prevmousex[0] = mousex[0];
prevmousey[0] = mousey[0];

prevmousex_r[0] = mousex_r[0];
prevmousey_r[0] = mousey_r[0];

if(os_type == os_android || os_type == os_ios)
{
	prevmousex[1] = mousex[1];
	prevmousey[1] = mousey[1];
	prevmousex[2] = mousex[2];
	prevmousey[2] = mousey[2];
	prevmousex_r[1] = mousex_r[1];
	prevmousey_r[1] = mousey_r[1];
	prevmousex_r[2] = mousex_r[2];
	prevmousey_r[2] = mousey_r[2];
}

if(wprev != w_width || hprev != w_height) {
	
	wprev = w_width;
	hprev = w_height;
	view_set_wport(0,w_width);
	view_set_hport(0,w_height);
	camera_set_view_size(view_camera[0],w_width,w_height);
	
	/*
	surface_free(_surf);
	_surf = surface_create(w_width>>global.screendiv,w_height>>global.screendiv);
	view_set_surface_id(0,_surf);
	*/
	
	if(w_height > 1)
	{
	surface_resize(application_surface,w_width>>global.screendiv,w_height>>global.screendiv);
	var factor = round(w_height / 270);
	if (global.uisize < factor)
	{
		uisize = global.uisize<<global.bigui;
	}
	else
	{
		uisize = factor<<global.bigui;
	}
	
		display_set_gui_size(w_width div uisize, w_height div uisize);
	}
}
camera_set_proj_mat(view_camera[0],matrix_build_projection_perspective_fov(60+fov_mod,w_width/w_height,1,fog_depth));