if(active == true)
{
var zv = depth - scale;
var sw = scale;
var scyphptsw = global.sincyphp*sw;
var ccyphptsw = global.coscyphp*sw;
var lefty = y + scyphptsw;
var righty= y - scyphptsw;
var leftx = x + ccyphptsw;
var rightx= x - ccyphptsw;

vertex_begin(v[0],f[0]);
vertex_position_3d(v[0],leftx,lefty,depth);
vertex_color(v[0],image_blend,1);
vertex_texcoord(v[0],1,1);
vertex_position_3d(v[0],leftx,lefty,zv);
vertex_color(v[0],image_blend,1);
vertex_texcoord(v[0],1,0);
vertex_position_3d(v[0],x,y,zv);
vertex_color(v[0],image_blend,1);
vertex_texcoord(v[0],0,0);
vertex_position_3d(v[0],leftx,lefty,depth);
vertex_color(v[0],image_blend,1);
vertex_texcoord(v[0],1,1);
vertex_position_3d(v[0],x,y,depth);
vertex_color(v[0],image_blend,1);
vertex_texcoord(v[0],0,1);
vertex_position_3d(v[0],x,y,zv);
vertex_color(v[0],image_blend,1);
vertex_texcoord(v[0],0,0);
vertex_end(v[0]);

vertex_begin(v[1],f[1]);
vertex_position_3d(v[1],x,y,depth);
vertex_color(v[1],image_blend,1);
vertex_texcoord(v[1],1,1);
vertex_position_3d(v[1],x,y,zv);
vertex_color(v[1],image_blend,1);
vertex_texcoord(v[1],1,0);
vertex_position_3d(v[1],rightx,righty,zv);
vertex_color(v[1],image_blend,1);
vertex_texcoord(v[1],0,0);
vertex_position_3d(v[1],x,y,depth);
vertex_color(v[1],image_blend,1);
vertex_texcoord(v[1],1,1);
vertex_position_3d(v[1],rightx,righty,depth);
vertex_color(v[1],image_blend,1);
vertex_texcoord(v[1],0,1);
vertex_position_3d(v[1],rightx,righty,zv);
vertex_color(v[1],image_blend,1);
vertex_texcoord(v[1],0,0);
vertex_end(v[1]);

depth++;
}
if depth > 32 activated = false;