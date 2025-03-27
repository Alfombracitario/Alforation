function init_3d_image_tile(index)
{
vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_color();
vertex_format_add_texcoord();

f[index] = vertex_format_end();
v[index] = vertex_create_buffer();

vertex_begin(v[index],f[index]);
vertex_end(v[index]);
}