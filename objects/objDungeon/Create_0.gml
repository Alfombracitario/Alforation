#region dungeuon generation
_xlimit = 64;
_ylimit = 64;
var _rooms = 32;
var _minroomh = 4;
var _minroomv = 4;
var _maxroomh = 8;
var _maxroomv = 8;
var _roomh, _roomv, _x, _y;

image_xscale = _xlimit;
image_yscale = _ylimit;

room_width = _xlimit << 4;
room_height = _ylimit << 4;

// Inicializar array de tiles con paredes (1)
tiles = array_create(_xlimit, 0);
for (var i = 0; i < _xlimit; i++) {
    tiles[i] = array_create(_ylimit, 1);
}

// Guardar las habitaciones
var room_positions = [];

// Generar habitaciones
for (var i = 0; i < _rooms; i++) {
    _roomh = irandom_range(_minroomh, _maxroomh);
    _roomv = irandom_range(_minroomv, _maxroomv);
    _x = irandom(_xlimit - _roomh);
    _y = irandom(_ylimit - _roomv);

    // Crear la habitación vacía (0)
    for (var j = _x; j < _x + _roomh; j++) {
        for (var h = _y; h < _y + _roomv; h++) {
            tiles[j][h] = 0;
        }
    }

    // Guardar el centro de la habitación
    var center_x = _x + _roomh div 2;
    var center_y = _y + _roomv div 2;
    array_push(room_positions, [center_x, center_y]);
}

// Conectar las habitaciones en orden de generación
for (var i = 0; i < array_length(room_positions) - 1; i++) {
    var x1 = room_positions[i][0];
    var y1 = room_positions[i][1];
    var x2 = room_positions[i + 1][0];
    var y2 = room_positions[i + 1][1];

    // Crear un pasillo horizontal
    for (var _x = min(x1, x2); _x <= max(x1, x2); _x++) {
        tiles[_x][y1] = 0;
    }

    // Crear un pasillo vertical
    for (var _y = min(y1, y2); _y <= max(y1, y2); _y++) {
        tiles[x2][_y] = 0;
    }
}
#endregion

#region 3D
vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_color();
vertex_format_add_texcoord();

f = vertex_format_end();
v = vertex_create_buffer();

tex = get_texture_coords(0,7);

texture = sprite_get_texture(sprBtiles,0);
vertex_begin(v,f);

var _p = [-1, 0, 1]; 
var _bitIndex = [
    7, 6, 5, // UL, U, UR
    4, -1, 3, // L, (centro), R
    2, 1, 0  // DL, D, DR
];
var model;

for(_x = 0; _x < _xlimit; _x++)
{
	for(_y = 0; _y < _ylimit; _y++)
	{
	model = 0;
	if tiles[_x][_y] = 0 continue;
	for (var i = 0; i < 3; i++) 
	{
	    for (var j = 0; j < 3; j++) 
	    {
	        if (i == 1 && j == 1) continue; // Omitir el centro
			if(_x + _p[i] <= 0 || _x + _p[i] >= _xlimit
			|| _y + _p[j] <= 0 || _y + _p[j] >= _ylimit)
			{
				continue;
			}
	        if!(tiles[_x+_p[i]][_y+_p[j]] == 0)
	        {
	            model |= 1 << _bitIndex[j * 3 + i];
	        }
	    }
	}
	
	x = _x<<4
	y = _y<<4
	var sx = x+16; //cuanto mide en X
	var sy = y+16; //cuanto mide en Y
	
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
	}
}
vertex_end(v);
#endregion
x = 0;
y = 0;
image_blend = c_gray;
var _px = irandom(_xlimit-2)+1
var _py = irandom(_ylimit-2)+1
while(tiles[_px][_py] == 1)
{
	var _px = irandom(_xlimit-2)+1
	var _py = irandom(_ylimit-2)+1
}
instance_create_layer(_px<<4,_py<<4,"instances",objPlayer);