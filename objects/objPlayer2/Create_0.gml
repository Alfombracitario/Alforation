w_width = objPlayer.w_width;
w_height = objPlayer.w_height;
view_visible[1] = true;
camera_set_view_size(view_camera[1],w_width,w_height);
view_camera[1] = camera_create();
camera_set_proj_mat(view_camera[1],matrix_build_projection_perspective_fov(60,w_width/w_height,1,16000));
surf = surface_create(w_width*0.5,w_height);