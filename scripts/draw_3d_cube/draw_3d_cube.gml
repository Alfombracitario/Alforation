function draw_3d_cube(z = depth,image_zscale = sprite_height,color = image_blend) {
	var zv = z-(image_zscale);//cuanto mide en Z

	var sx = x+0.01+sprite_width; //cuanto mide en X
	var sy = y+0.01+sprite_height; //cuanto mide en Y
	
	var _color2 = merge_color(color,c_black,0.2);
	var _color3 = merge_color(color,c_black,0.4);
	
	vertex_begin(v,f);

	vertex_position_3d(v,x,sy,z); //back
	vertex_color(v,color,1);
	vertex_texcoord(v,tex_back.x1,tex_back.y2);
	vertex_position_3d(v,x,sy,zv);
	vertex_color(v,color,1);
	vertex_texcoord(v,tex_back.x1,tex_back.y1);
	vertex_position_3d(v,sx,sy,zv);
	vertex_color(v,color,1);
	vertex_texcoord(v,tex_back.x2,tex_back.y1);
	vertex_position_3d(v,x,sy,z);
	vertex_color(v,color,1);
	vertex_texcoord(v,tex_back.x1,tex_back.y2);
	vertex_position_3d(v,sx,sy,z);
	vertex_color(v,color,1);
	vertex_texcoord(v,tex_back.x2,tex_back.y2);
	vertex_position_3d(v,sx,sy,zv);
	vertex_color(v,color,1);
	vertex_texcoord(v,tex_back.x2,tex_back.y1);
	
	vertex_position_3d(v,x,y,z); //front
	vertex_color(v,color,1);
	vertex_texcoord(v,tex_front.x2,tex_front.y2);
	vertex_position_3d(v,x,y,zv);
	vertex_color(v,color,1);
	vertex_texcoord(v,tex_front.x2,tex_front.y1);
	vertex_position_3d(v,sx,y,zv);
	vertex_color(v,color,1);
	vertex_texcoord(v,tex_front.x1,tex_front.y1);
	vertex_position_3d(v,x,y,z);
	vertex_color(v,color,1);
	vertex_texcoord(v,tex_front.x2,tex_front.y2);
	vertex_position_3d(v,sx,y,z);
	vertex_color(v,color,1);
	vertex_texcoord(v,tex_front.x1,tex_front.y2);
	vertex_position_3d(v,sx,y,zv);
	vertex_color(v,color,1);
	vertex_texcoord(v,tex_front.x1,tex_front.y1);

	vertex_position_3d(v,sx,sy,z); //right
	vertex_color(v,_color2,1);
	vertex_texcoord(v,tex_right.x1,tex_right.y2);
	vertex_position_3d(v,sx,sy,zv);
	vertex_color(v,_color2,1);
	vertex_texcoord(v,tex_right.x1,tex_right.y1);
	vertex_position_3d(v,sx,y,zv);
	vertex_color(v,_color2,1);
	vertex_texcoord(v,tex_right.x2,tex_right.y1);
	vertex_position_3d(v,sx,sy,z);
	vertex_color(v,_color2,1);
	vertex_texcoord(v,tex_right.x1,tex_right.y2);
	vertex_position_3d(v,sx,y,z);
	vertex_color(v,_color2,1);
	vertex_texcoord(v,tex_right.x2,tex_right.y2);
	vertex_position_3d(v,sx,y,zv);
	vertex_color(v,_color2,1);
	vertex_texcoord(v,tex_right.x2,tex_right.y1);
	
	vertex_position_3d(v,x,sy,z); //left
	vertex_color(v,_color2,1);
	vertex_texcoord(v,tex_left.x2,tex_left.y2);
	vertex_position_3d(v,x,sy,zv);
	vertex_color(v,_color2,1);
	vertex_texcoord(v,tex_left.x2,tex_left.y1);
	vertex_position_3d(v,x,y,zv);
	vertex_color(v,_color2,1);
	vertex_texcoord(v,tex_left.x1,tex_left.y1);
	vertex_position_3d(v,x,sy,z);
	vertex_color(v,_color2,1);
	vertex_texcoord(v,tex_left.x2,tex_left.y2);
	vertex_position_3d(v,x,y,z);
	vertex_color(v,_color2,1);
	vertex_texcoord(v,tex_left.x1,tex_left.y2);
	vertex_position_3d(v,x,y,zv);
	vertex_color(v,_color2,1);
	vertex_texcoord(v,tex_left.x1,tex_left.y1);

	vertex_position_3d(v,x,sy,z); //bottom
	vertex_color(v,_color3,1);
	vertex_texcoord(v,tex_bottom.x1,tex_bottom.y1);
	vertex_position_3d(v,sx,sy,z);
	vertex_color(v,_color3,1);
	vertex_texcoord(v,tex_bottom.x1,tex_bottom.y2);
	vertex_position_3d(v,sx,y,z);
	vertex_color(v,_color3,1);
	vertex_texcoord(v,tex_bottom.x2,tex_bottom.y2);
	vertex_position_3d(v,x,sy,z);
	vertex_color(v,_color3,1);
	vertex_texcoord(v,tex_bottom.x1,tex_bottom.y1);
	vertex_position_3d(v,x,y,z);
	vertex_color(v,_color3,1);
	vertex_texcoord(v,tex_bottom.x2,tex_bottom.y1);
	vertex_position_3d(v,sx,y,z);
	vertex_color(v,_color3,1);
	vertex_texcoord(v,tex_bottom.x2,tex_bottom.y2);
	
	vertex_position_3d(v,x,sy,zv); //Top
	vertex_color(v,_color3,1);
	vertex_texcoord(v,tex_top.x2,tex_top.y1);
	vertex_position_3d(v,sx,sy,zv);
	vertex_color(v,_color3,1);
	vertex_texcoord(v,tex_top.x2,tex_top.y2);
	vertex_position_3d(v,sx,y,zv);
	vertex_color(v,_color3,1);
	vertex_texcoord(v,tex_top.x1,tex_top.y2);
	vertex_position_3d(v,x,sy,zv);
	vertex_color(v,_color3,1);
	vertex_texcoord(v,tex_top.x2,tex_top.y1);
	vertex_position_3d(v,x,y,zv);
	vertex_color(v,_color3,1);
	vertex_texcoord(v,tex_top.x1,tex_top.y1);
	vertex_position_3d(v,sx,y,zv);
	vertex_color(v,_color3,1);
	vertex_texcoord(v,tex_top.x1,tex_top.y2);
	vertex_end(v);
}