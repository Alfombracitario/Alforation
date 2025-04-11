var _time = objPlayer._time;
x = objPlayer.x;
y = objPlayer.y-256*dsin(_time+90);

var lefty = y;
var righty= y;
var leftyv = y-(64*dsin(_time));
var rightyv = y-(64*dsin(_time));

var leftx = x + 32;
var rightx= x - 32;

var z = 256*dsin(_time+180);
var zv = 256*dsin(_time+196);

vertex_begin(v,f);
//sol
vertex_position_3d(v,leftx,leftyv,z);
vertex_color(v,c_white,1);
vertex_texcoord(v,0.1,1);
vertex_position_3d(v,leftx,lefty,zv);
vertex_color(v,c_white,1);
vertex_texcoord(v,0.1,0);
vertex_position_3d(v,rightx,righty,zv);
vertex_color(v,c_white,1);
vertex_texcoord(v,0,0);
vertex_position_3d(v,leftx,leftyv,z);
vertex_color(v,c_white,1);
vertex_texcoord(v,0.1,1);
vertex_position_3d(v,rightx,rightyv,z);
vertex_color(v,c_white,1);
vertex_texcoord(v,0,1);
vertex_position_3d(v,rightx,righty,zv);
vertex_color(v,c_white,1);
vertex_texcoord(v,0,0);

//luna
_time += 180;
x = objPlayer.x;
y = objPlayer.y-256*dsin(_time+90);

var lefty = y;
var righty= y;
var leftyv = y-(64*dsin(_time));
var rightyv = y-(64*dsin(_time));

leftx = x + 32;
rightx= x - 32;

z = 256*dsin(_time+180);
zv = 256*dsin(_time+196);

vertex_position_3d(v,leftx,leftyv,z);
vertex_color(v,c_white,1);
vertex_texcoord(v,0.2,1);
vertex_position_3d(v,leftx,lefty,zv);
vertex_color(v,c_white,1);
vertex_texcoord(v,0.2,0);
vertex_position_3d(v,rightx,righty,zv);
vertex_color(v,c_white,1);
vertex_texcoord(v,0.1,0);
vertex_position_3d(v,leftx,leftyv,z);
vertex_color(v,c_white,1);
vertex_texcoord(v,0.2,1);
vertex_position_3d(v,rightx,rightyv,z);
vertex_color(v,c_white,1);
vertex_texcoord(v,0.1,1);
vertex_position_3d(v,rightx,righty,zv);
vertex_color(v,c_white,1);
vertex_texcoord(v,0.1,0);

vertex_end(v);