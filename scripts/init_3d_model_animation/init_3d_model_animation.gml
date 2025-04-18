function init_3d_model_animation(frame_count)
{
vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_color();
vertex_format_add_texcoord();

f = vertex_format_end();
v = vertex_create_buffer();

	for(var i = 0; i < frame_count+1; i++)
	{
		frame[i] = i/frame_count;
	}
frame_index = 0;
}