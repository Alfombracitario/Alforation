vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_color();
vertex_format_add_texcoord();

f = vertex_format_end();
v = vertex_create_buffer();

tw = 1;
draw = false;
image_xscale = 2;
image_yscale = 2;
image_alpha = 0.5;