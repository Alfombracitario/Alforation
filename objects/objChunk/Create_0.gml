vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_color();
vertex_format_add_texcoord();

f = vertex_format_end();
v = vertex_create_buffer();

draw = false;
image_xscale = 16;
image_yscale = 16;
u_s_tw  = shader_get_uniform(sBillboard, "_s_tw");
u_c_tw  = shader_get_uniform(sBillboard, "_c_tw");
u_s_8  = shader_get_uniform(sBillboard, "_s_8");
u_c_8  = shader_get_uniform(sBillboard, "_c_8");