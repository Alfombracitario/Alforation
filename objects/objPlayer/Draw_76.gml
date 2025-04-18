gpu_set_fog(global.fog,fog_color,fog_depth-fog_density,fog_depth);

surface_set_target(application_surface);
draw_clear_alpha(c_black,0);
surface_reset_target();