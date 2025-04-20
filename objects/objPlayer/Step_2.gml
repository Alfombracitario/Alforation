if(keyboard_check_pressed(ord("Q"))) do_player_hurt(5);

if(wprev != w_width || hprev != w_height) {
	
	wprev = w_width;
	hprev = w_height;
	view_set_wport(0,w_width);
	view_set_hport(0,w_height);
	camera_set_view_size(view_camera[0],w_width,w_height);

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
	
        gw = w_width div uisize
        gh = w_height div uisize
	}
    display_set_gui_size(gw,gh);
    
    if(os_type == os_android || os_type == os_ios)
    {
            dx = gw*invdpadx;
			dy = gh*invdpady;
			ds = round(gh*0.15);
			bs = ds*0.05;
			bax = gw*buttonax;
			bay = gh*buttonay;
			bbx = gw*buttonbx;
			bby = gh*buttonby;
			bix = gw*buttonix;
			biy = gh*buttoniy;
    }
}
camera_set_proj_mat(view_camera[0],matrix_build_projection_perspective_fov(60+fov_mod,w_width/w_height,1,fog_depth));