function add_3d_face()
{

vertex_position_3d(v,x,y,z);
vertex_color(v,c_white,1);
vertex_texcoord(v,1,1);
vertex_position_3d(v,x,y,zv);
vertex_color(v,c_white,1);
vertex_texcoord(v,1,0);
vertex_position_3d(v,sx,y,zv);
vertex_color(v,c_white,1);
vertex_texcoord(v,0,0);
vertex_position_3d(v,x,y,z);
vertex_color(v,c_white,1);
vertex_texcoord(v,1,1);
vertex_position_3d(v,sx,y,z);
vertex_color(v,c_white,1);
vertex_texcoord(v,0,1);
vertex_position_3d(v,sx,y,zv);
vertex_color(v,c_white,1);
vertex_texcoord(v,0,0);

}
