_time = objPlayer._time;
x = objPlayer.x;
y = objPlayer.y-CHUNK_SIZE*dsin(_time+90);

var lefty = y;
var righty= y;
var leftyv = y-(32*dsin(_time));
var rightyv = y-(32*dsin(_time));

var leftx = x + 16;
var rightx= x - 16;
var _z = objPlayer.z
var z = _z + CHUNK_SIZE*dsin(_time+180);
var zv = _z + CHUNK_SIZE*dsin(_time+188);

vertex_begin(v,f);
//sol
vertex_position_3d(v,leftx,leftyv,z);
vertex_color(v,c_white,1);
vertex_texcoord(v,sunuv[2],sunuv[3]);
vertex_position_3d(v,rightx,righty,zv);
vertex_color(v,c_white,1);
vertex_texcoord(v,sunuv[0],sunuv[1]);
vertex_position_3d(v,leftx,lefty,zv);
vertex_color(v,c_white,1);
vertex_texcoord(v,sunuv[2],sunuv[1]);


vertex_position_3d(v,leftx,leftyv,z);
vertex_color(v,c_white,1);
vertex_texcoord(v,sunuv[2],sunuv[3]);
vertex_position_3d(v,rightx,rightyv,z);
vertex_color(v,c_white,1);
vertex_texcoord(v,sunuv[0],sunuv[3]);
vertex_position_3d(v,rightx,righty,zv);
vertex_color(v,c_white,1);
vertex_texcoord(v,sunuv[0],sunuv[1]);

//luna
_time += 180;
x = objPlayer.x;
y = objPlayer.y-CHUNK_SIZE*dsin(_time+90);

lefty = y;
righty= y;
leftyv = y-(32*dsin(_time));
rightyv = y-(32*dsin(_time));

leftx = x + 16;
rightx= x - 16;

z = _z+ CHUNK_SIZE*dsin(_time+180);
zv = _z + CHUNK_SIZE*dsin(_time+188);

vertex_position_3d(v,leftx,leftyv,z);
vertex_color(v,c_white,1);
vertex_texcoord(v,moonuv[2],moonuv[3]);
vertex_position_3d(v,rightx,righty,zv);
vertex_color(v,c_white,1);
vertex_texcoord(v,moonuv[0],moonuv[1]);
vertex_position_3d(v,leftx,lefty,zv);
vertex_color(v,c_white,1);
vertex_texcoord(v,moonuv[2],moonuv[1]);

vertex_position_3d(v,leftx,leftyv,z);
vertex_color(v,c_white,1);
vertex_texcoord(v,moonuv[2],moonuv[3]);
vertex_position_3d(v,rightx,rightyv,z);
vertex_color(v,c_white,1);
vertex_texcoord(v,moonuv[0],moonuv[3]);
vertex_position_3d(v,rightx,righty,zv);
vertex_color(v,c_white,1);
vertex_texcoord(v,moonuv[0],moonuv[1]);

vertex_end(v);