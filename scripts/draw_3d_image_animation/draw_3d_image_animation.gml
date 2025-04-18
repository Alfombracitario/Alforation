function draw_3d_image_animation()
{
	var scyphptsw = global.sincyphp*sw;
	var ccyphptsw = global.coscyphp*sw;
	var lefty = y + scyphptsw;
	var righty= y - scyphptsw;
	var leftx = x + ccyphptsw;
	var rightx= x - ccyphptsw;

	vertex_begin(v,f);
	vertex_position_3d(v,leftx,lefty,z);
	vertex_color(v,image_blend,1);
	vertex_texcoord(v,frame[frame_index+1],1);
	vertex_position_3d(v,leftx,lefty,z+zv);
	vertex_color(v,image_blend,1);
	vertex_texcoord(v,frame[frame_index+1],0);
	vertex_position_3d(v,rightx,righty,z+zv);
	vertex_color(v,image_blend,1);
	vertex_texcoord(v,frame[frame_index],0);
	vertex_position_3d(v,leftx,lefty,z);
	vertex_color(v,image_blend,1);
	vertex_texcoord(v,frame[frame_index+1],1);
	vertex_position_3d(v,rightx,righty,z);
	vertex_color(v,image_blend,1);
	vertex_texcoord(v,frame[frame_index],1);
	vertex_position_3d(v,rightx,righty,z+zv);
	vertex_color(v,image_blend,1);
	vertex_texcoord(v,frame[frame_index],0);
	vertex_end(v);

}