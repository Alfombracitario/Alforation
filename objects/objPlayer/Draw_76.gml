surface_set_target(application_surface);
draw_clear_alpha(c_black,0);
surface_reset_target();
/*
shader_set(sBillboard_shadows);
shader_set_uniform_f(_ts,global.sincyphp,global.coscyphp);