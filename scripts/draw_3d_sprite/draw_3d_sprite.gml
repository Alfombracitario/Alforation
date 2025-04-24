function draw_3d_sprite()
{//como no quiero cagarme de la cabeza este script no incluye rotación
	var scyphptsw = global.sincyphp*sw;
	var ccyphptsw = global.coscyphp*sw;
	var lefty = y + scyphptsw;
	var righty= y - scyphptsw;
	var leftx = x + ccyphptsw;
	var rightx= x - ccyphptsw;
    vertex_begin(v,f);
    vertex_position_3d(v,leftx,lefty,z);
    vertex_color(v,image_blend,image_alpha);
	vertex_texcoord(v,uv.x2,uv.y2);
    vertex_position_3d(v,leftx,lefty,zv);
    vertex_color(v,image_blend,image_alpha);
    vertex_texcoord(v,uv.x2,uv.y1);
    vertex_position_3d(v,rightx,righty,zv);
    vertex_color(v,image_blend,image_alpha);
    vertex_texcoord(v,uv.x1,uv.y1);
    vertex_position_3d(v,leftx,lefty,z);
    vertex_color(v,image_blend,image_alpha);
    vertex_texcoord(v,uv.x2,uv.y2);
    vertex_position_3d(v,rightx,righty,z);
    vertex_color(v,image_blend,image_alpha);
    vertex_texcoord(v,uv.x1,uv.y2);
    vertex_position_3d(v,rightx,righty,zv);
    vertex_color(v,image_blend,image_alpha);
    vertex_texcoord(v,uv.x1,uv.y1);
    vertex_end(v);
}