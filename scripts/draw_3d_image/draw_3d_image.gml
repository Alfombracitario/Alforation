function draw_3d_image(z=depth)
{
var zv = z-(sprite_height*image_yscale);

var sw = image_xscale*sprite_width>>1; 

var scyphptsw = global.sincyphp*sw;
var ccyphptsw = global.coscyphp*sw;

var lefty = y + scyphptsw;
var righty= y - scyphptsw;
var leftx = x + ccyphptsw;
var rightx= x - ccyphptsw;

vertex_begin(v,f);

vertex_position_3d(v,leftx,lefty,z);
vertex_color(v,c_white,1);
vertex_texcoord(v,1,1);
vertex_position_3d(v,leftx,lefty,zv);
vertex_color(v,c_white,1);
vertex_texcoord(v,1,0);
vertex_position_3d(v,rightx,righty,zv);
vertex_color(v,c_white,1);
vertex_texcoord(v,0,0);
vertex_position_3d(v,leftx,lefty,z);
vertex_color(v,c_white,1);
vertex_texcoord(v,1,1);
vertex_position_3d(v,rightx,righty,z);
vertex_color(v,c_white,1);
vertex_texcoord(v,0,1);
vertex_position_3d(v,rightx,righty,zv);
vertex_color(v,c_white,1);
vertex_texcoord(v,0,0);

vertex_end(v);
}