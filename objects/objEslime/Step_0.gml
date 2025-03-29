direction = point_direction(x,y,objPlayer.x,objPlayer.y);
if(hp < 2)
{
	speed = -1;
}
if(hp < 0)
{
	instance_destroy();
}
else
{
var scyphptsw = global.sincyphp*sw;
var ccyphptsw = global.coscyphp*sw;
var lefty = y + scyphptsw;
var righty= y - scyphptsw;
var leftx = x + ccyphptsw;
var rightx= x - ccyphptsw;

vertex_begin(v,f);
vertex_position_3d(v,leftx,lefty,0);
vertex_color(v,image_blend,1);
vertex_texcoord(v,1,1);
vertex_position_3d(v,leftx,lefty,zv);
vertex_color(v,image_blend,1);
vertex_texcoord(v,1,0);
vertex_position_3d(v,rightx,righty,zv);
vertex_color(v,image_blend,1);
vertex_texcoord(v,0,0);
vertex_position_3d(v,leftx,lefty,0);
vertex_color(v,image_blend,1);
vertex_texcoord(v,1,1);
vertex_position_3d(v,rightx,righty,0);
vertex_color(v,image_blend,1);
vertex_texcoord(v,0,1);
vertex_position_3d(v,rightx,righty,zv);
vertex_color(v,image_blend,1);
vertex_texcoord(v,0,0);
vertex_end(v);
}