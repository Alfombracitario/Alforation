function add_3d_face()
{

vertex_position_3d(v,_x,_y,z);
vertex_color(v,c_white,1);
vertex_texcoord(v,1,1);
vertex_position_3d(v,_x,_y,zv);
vertex_color(v,c_white,1);
vertex_texcoord(v,1,0);
vertex_position_3d(v,_sx,_y,zv);
vertex_color(v,c_white,1);
vertex_texcoord(v,0,0);
vertex_position_3d(v,_x,_y,z);
vertex_color(v,c_white,1);
vertex_texcoord(v,1,1);
vertex_position_3d(v,_sx,_y,z);
vertex_color(v,c_white,1);
vertex_texcoord(v,0,1);
vertex_position_3d(v,_sx,_y,zv);
vertex_color(v,c_white,1);
vertex_texcoord(v,0,0);

}
