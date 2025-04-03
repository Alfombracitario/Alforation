vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_color();
vertex_format_add_texcoord();

f = vertex_format_end();
v = vertex_create_buffer();

tex = get_texture_coords(tx,ty);

texture = sprite_get_texture(sprBtiles,0);

var _p = [-1, 0, 1]; 
var _bitIndex = [
    7, 6, 5, // UL, U, UR
    4, -1, 3, // L, (centro), R
    2, 1, 0  // DL, D, DR
];

var model = 0;

for (var i = 0; i < 3; i++) 
{
    for (var j = 0; j < 3; j++) 
    {
        if (i == 1 && j == 1) continue; // Omitir el centro

        if (instance_place(x + (_p[i] << 4), y + (_p[j] << 4), objWall)) 
        {
            model |= 1 << _bitIndex[j * 3 + i];
        }
    }
}

var sx = x+16; //cuanto mide en X
var sy = y+16; //cuanto mide en Y
vertex_begin(v,f);
var _c;
_c[0] = $ffffff;
_c[1] = $ffffff;
z = 0;
var zv = -16;
if!(model & 64 == 64) //up
{
	if model & 32 == 32  _c[1] = $a0a0a0; //upright
	if model & 128 == 128  _c[0] = $a0a0a0; //upleft
	_c[2] = _c[0]-$5f5f5f;
	_c[3] = _c[1]-$5f5f5f;
	vertex_position_3d(v,x,y,z); 
	vertex_color(v,_c[2],1);
	vertex_texcoord(v,tex.x2,tex.y2);
	vertex_position_3d(v,x,y,zv);
	vertex_color(v,_c[0],1);
	vertex_texcoord(v,tex.x2,tex.y1);
	vertex_position_3d(v,sx,y,zv);
	vertex_color(v,_c[1],1);
	vertex_texcoord(v,tex.x1,tex.y1);
	vertex_position_3d(v,x,y,z);
	vertex_color(v,_c[2],1);
	vertex_texcoord(v,tex.x2,tex.y2);
	vertex_position_3d(v,sx,y,z);
	vertex_color(v,_c[3],1);
	vertex_texcoord(v,tex.x1,tex.y2);
	vertex_position_3d(v,sx,y,zv);
	vertex_color(v,_c[1],1);
	vertex_texcoord(v,tex.x1,tex.y1);
	z-=16;
	zv-=16;
	vertex_position_3d(v,x,y,z); 
	vertex_color(v,_c[0],1);
	vertex_texcoord(v,tex.x2,tex.y2);
	vertex_position_3d(v,x,y,zv);
	vertex_color(v,_c[0],1);
	vertex_texcoord(v,tex.x2,tex.y1);
	vertex_position_3d(v,sx,y,zv);
	vertex_color(v,_c[1],1);
	vertex_texcoord(v,tex.x1,tex.y1);
	vertex_position_3d(v,x,y,z);
	vertex_color(v,_c[0],1);
	vertex_texcoord(v,tex.x2,tex.y2);
	vertex_position_3d(v,sx,y,z);
	vertex_color(v,_c[1],1);
	vertex_texcoord(v,tex.x1,tex.y2);
	vertex_position_3d(v,sx,y,zv);
	vertex_color(v,_c[1],1);
	vertex_texcoord(v,tex.x1,tex.y1);
	z-=16;
	zv-=16;
	vertex_position_3d(v,x,y,z); 
	vertex_color(v,_c[0],1);
	vertex_texcoord(v,tex.x2,tex.y2);
	vertex_position_3d(v,x,y,zv);
	vertex_color(v,_c[2],1);
	vertex_texcoord(v,tex.x2,tex.y1);
	vertex_position_3d(v,sx,y,zv);
	vertex_color(v,_c[3],1);
	vertex_texcoord(v,tex.x1,tex.y1);
	vertex_position_3d(v,x,y,z);
	vertex_color(v,_c[0],1);
	vertex_texcoord(v,tex.x2,tex.y2);
	vertex_position_3d(v,sx,y,z);
	vertex_color(v,_c[1],1);
	vertex_texcoord(v,tex.x1,tex.y2);
	vertex_position_3d(v,sx,y,zv);
	vertex_color(v,_c[3],1);
	vertex_texcoord(v,tex.x1,tex.y1);
}
_c[0] = $ffffff;
_c[1] = $ffffff;
z = 0;
zv = -16;
if(!(model & 8 == 8))
{
	if model & 32 == 32  _c[1] = $a0a0a0; //upright
	if model & 1 == 1  _c[0] = $a0a0a0; //downright
	_c[2] = _c[0]-$5f5f5f;
	_c[3] = _c[1]-$5f5f5f;
	vertex_position_3d(v,sx,sy,z); //right
	vertex_color(v,_c[2],1);
	vertex_texcoord(v,tex.x1,tex.y2);
	vertex_position_3d(v,sx,sy,zv);
	vertex_color(v,_c[0],1);
	vertex_texcoord(v,tex.x1,tex.y1);
	vertex_position_3d(v,sx,y,zv);
	vertex_color(v,_c[1],1);
	vertex_texcoord(v,tex.x2,tex.y1);
	vertex_position_3d(v,sx,sy,z);
	vertex_color(v,_c[2],1);
	vertex_texcoord(v,tex.x1,tex.y2);
	vertex_position_3d(v,sx,y,z);
	vertex_color(v,_c[3],1);
	vertex_texcoord(v,tex.x2,tex.y2);
	vertex_position_3d(v,sx,y,zv);
	vertex_color(v,_c[1],1);
	vertex_texcoord(v,tex.x2,tex.y1);
	z-=16;
	zv-=16;
	vertex_position_3d(v,sx,sy,z); //right
	vertex_color(v,_c[0],1);
	vertex_texcoord(v,tex.x1,tex.y2);
	vertex_position_3d(v,sx,sy,zv);
	vertex_color(v,_c[0],1);
	vertex_texcoord(v,tex.x1,tex.y1);
	vertex_position_3d(v,sx,y,zv);
	vertex_color(v,_c[1],1);
	vertex_texcoord(v,tex.x2,tex.y1);
	vertex_position_3d(v,sx,sy,z);
	vertex_color(v,_c[0],1);
	vertex_texcoord(v,tex.x1,tex.y2);
	vertex_position_3d(v,sx,y,z);
	vertex_color(v,_c[1],1);
	vertex_texcoord(v,tex.x2,tex.y2);
	vertex_position_3d(v,sx,y,zv);
	vertex_color(v,_c[1],1);
	vertex_texcoord(v,tex.x2,tex.y1);
	z-=16;
	zv-=16;
	vertex_position_3d(v,sx,sy,z); //right
	vertex_color(v,_c[0],1);
	vertex_texcoord(v,tex.x1,tex.y2);
	vertex_position_3d(v,sx,sy,zv);
	vertex_color(v,_c[2],1);
	vertex_texcoord(v,tex.x1,tex.y1);
	vertex_position_3d(v,sx,y,zv);
	vertex_color(v,_c[3],1);
	vertex_texcoord(v,tex.x2,tex.y1);
	vertex_position_3d(v,sx,sy,z);
	vertex_color(v,_c[0],1);
	vertex_texcoord(v,tex.x1,tex.y2);
	vertex_position_3d(v,sx,y,z);
	vertex_color(v,_c[1],1);
	vertex_texcoord(v,tex.x2,tex.y2);
	vertex_position_3d(v,sx,y,zv);
	vertex_color(v,_c[3],1);
	vertex_texcoord(v,tex.x2,tex.y1);
}
_c[0] = $ffffff;
_c[1] = $ffffff;
z = 0;
zv = -16;
if(!(model & 2 == 2)) //down
{
	if model & 1 == 1  _c[1] = $a0a0a0; //downright
	if model & 4 == 4  _c[0] = $a0a0a0; //downleft
	_c[2] = _c[0]-$5f5f5f;
	_c[3] = _c[1]-$5f5f5f;
	vertex_position_3d(v,x,sy,z); //back
	vertex_color(v,_c[2],1);
	vertex_texcoord(v,tex.x1,tex.y2);
	vertex_position_3d(v,x,sy,zv);
	vertex_color(v,_c[0],1);
	vertex_texcoord(v,tex.x1,tex.y1);
	vertex_position_3d(v,sx,sy,zv);
	vertex_color(v,_c[1],1);
	vertex_texcoord(v,tex.x2,tex.y1);
	vertex_position_3d(v,x,sy,z);
	vertex_color(v,_c[2],1);
	vertex_texcoord(v,tex.x1,tex.y2);
	vertex_position_3d(v,sx,sy,z);
	vertex_color(v,_c[3],1);
	vertex_texcoord(v,tex.x2,tex.y2);
	vertex_position_3d(v,sx,sy,zv);
	vertex_color(v,_c[1],1);
	vertex_texcoord(v,tex.x2,tex.y1);
	z-=16;
	zv-=16;
	vertex_position_3d(v,x,sy,z); //back
	vertex_color(v,_c[0],1);
	vertex_texcoord(v,tex.x1,tex.y2);
	vertex_position_3d(v,x,sy,zv);
	vertex_color(v,_c[0],1);
	vertex_texcoord(v,tex.x1,tex.y1);
	vertex_position_3d(v,sx,sy,zv);
	vertex_color(v,_c[1],1);
	vertex_texcoord(v,tex.x2,tex.y1);
	vertex_position_3d(v,x,sy,z);
	vertex_color(v,_c[0],1);
	vertex_texcoord(v,tex.x1,tex.y2);
	vertex_position_3d(v,sx,sy,z);
	vertex_color(v,_c[1],1);
	vertex_texcoord(v,tex.x2,tex.y2);
	vertex_position_3d(v,sx,sy,zv);
	vertex_color(v,_c[1],1);
	vertex_texcoord(v,tex.x2,tex.y1);
	z-=16;
	zv-=16;
	vertex_position_3d(v,x,sy,z); //back
	vertex_color(v,_c[0],1);
	vertex_texcoord(v,tex.x1,tex.y2);
	vertex_position_3d(v,x,sy,zv);
	vertex_color(v,_c[2],1);
	vertex_texcoord(v,tex.x1,tex.y1);
	vertex_position_3d(v,sx,sy,zv);
	vertex_color(v,_c[3],1);
	vertex_texcoord(v,tex.x2,tex.y1);
	vertex_position_3d(v,x,sy,z);
	vertex_color(v,_c[0],1);
	vertex_texcoord(v,tex.x1,tex.y2);
	vertex_position_3d(v,sx,sy,z);
	vertex_color(v,_c[1],1);
	vertex_texcoord(v,tex.x2,tex.y2);
	vertex_position_3d(v,sx,sy,zv);
	vertex_color(v,_c[3],1);
	vertex_texcoord(v,tex.x2,tex.y1);
}
_c[0] = $ffffff;
_c[1] = $ffffff;
z = 0;
zv = -16;
if(!(model & 16 == 16)) //left
{
	if model & 128 == 128  _c[1] = $a0a0a0; //upleft
	if model & 4 == 4  _c[0] = $a0a0a0; //downleft
	_c[2] = _c[0]-$5f5f5f;
	_c[3] = _c[1]-$5f5f5f;
	vertex_position_3d(v,x,sy,z); //left
	vertex_color(v,_c[2],1);
	vertex_texcoord(v,tex.x2,tex.y2);
	vertex_position_3d(v,x,sy,zv);
	vertex_color(v,_c[0],1);
	vertex_texcoord(v,tex.x2,tex.y1);
	vertex_position_3d(v,x,y,zv);
	vertex_color(v,_c[1],1);
	vertex_texcoord(v,tex.x1,tex.y1);
	vertex_position_3d(v,x,sy,z);
	vertex_color(v,_c[2],1);
	vertex_texcoord(v,tex.x2,tex.y2);
	vertex_position_3d(v,x,y,z);
	vertex_color(v,_c[3],1);
	vertex_texcoord(v,tex.x1,tex.y2);
	vertex_position_3d(v,x,y,zv);
	vertex_color(v,_c[1],1);
	vertex_texcoord(v,tex.x1,tex.y1);
	z-=16;
	zv-=16;
	vertex_position_3d(v,x,sy,z); //left
	vertex_color(v,_c[0],1);
	vertex_texcoord(v,tex.x2,tex.y2);
	vertex_position_3d(v,x,sy,zv);
	vertex_color(v,_c[0],1);
	vertex_texcoord(v,tex.x2,tex.y1);
	vertex_position_3d(v,x,y,zv);
	vertex_color(v,_c[1],1);
	vertex_texcoord(v,tex.x1,tex.y1);
	vertex_position_3d(v,x,sy,z);
	vertex_color(v,_c[0],1);
	vertex_texcoord(v,tex.x2,tex.y2);
	vertex_position_3d(v,x,y,z);
	vertex_color(v,_c[1],1);
	vertex_texcoord(v,tex.x1,tex.y2);
	vertex_position_3d(v,x,y,zv);
	vertex_color(v,_c[1],1);
	vertex_texcoord(v,tex.x1,tex.y1);
	z-=16;
	zv-=16;
	vertex_position_3d(v,x,sy,z); //left
	vertex_color(v,_c[0],1);
	vertex_texcoord(v,tex.x2,tex.y2);
	vertex_position_3d(v,x,sy,zv);
	vertex_color(v,_c[2],1);
	vertex_texcoord(v,tex.x2,tex.y1);
	vertex_position_3d(v,x,y,zv);
	vertex_color(v,_c[3],1);
	vertex_texcoord(v,tex.x1,tex.y1);
	vertex_position_3d(v,x,sy,z);
	vertex_color(v,_c[0],1);
	vertex_texcoord(v,tex.x2,tex.y2);
	vertex_position_3d(v,x,y,z);
	vertex_color(v,_c[1],1);
	vertex_texcoord(v,tex.x1,tex.y2);
	vertex_position_3d(v,x,y,zv);
	vertex_color(v,_c[3],1);
	vertex_texcoord(v,tex.x1,tex.y1);
}
vertex_end(v);