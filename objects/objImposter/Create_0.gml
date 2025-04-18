init_3d_image_tile(0); //impostor

vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_color();

f[1] = vertex_format_end();
v[1] = vertex_create_buffer();

vertex_begin(v[1],f[1]);
vertex_end(v[1]);
damage = 0;
tile_index=0;
tw = 0;
th = 0;
tree = 0;
uv = [];
activated = false;