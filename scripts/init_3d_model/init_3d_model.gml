function init_3d_model(uses_texcoords = false)
{
vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_color();
vertex_format_add_texcoord();

f = vertex_format_end();
v = vertex_create_buffer();

if(uses_texcoords = true)
{
tex_top = get_texture_coords(top_tx,top_ty);

if(bottom_tx == -1) {
    tex_bottom = tex_top;
} else tex_bottom = get_texture_coords(bottom_tx,bottom_ty);

if(left_tx == -1) {
    tex_left = tex_top;
} else tex_left = get_texture_coords(left_tx,left_ty);

if(right_tx == -1) {
    tex_right = tex_left;
} else tex_right = get_texture_coords(right_tx,right_ty);

if(front_tx == -1) {
    tex_front = tex_left;
} else tex_front = get_texture_coords(front_tx,front_ty);

if(back_tx == -1) {
    tex_back = tex_front;
} else tex_back = get_texture_coords(back_tx,back_ty);
}
}