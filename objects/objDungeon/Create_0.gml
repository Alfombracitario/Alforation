#region dungeon generation con múltiples conexiones y sin salirse
_xlimit = 64;
_ylimit = 64;
var _rooms = 32;
var _minroomh = 4;
var _minroomv = 4;
var _maxroomh = 8;
var _maxroomv = 8;

// Inicializar array de tiles con paredes (1)
tiles = array_create(_xlimit, 0);
for (var i = 0; i < _xlimit; i++) {
    tiles[i] = array_create(_ylimit, 1);
}

// Lista de habitaciones [x, y, w, h]
var room_list = [];

// Verifica si un área está libre y dentro de los límites
function is_area_free(x, y, w, h) {
    if (x < 1 || y < 1 || x + w >= _xlimit - 1 || y + h >= _ylimit - 1) return false;
    for (var i = x - 1; i < x + w + 1; i++) {
        for (var j = y - 1; j < y + h + 1; j++) {
            if (tiles[i][j] == 0) return false;
        }
    }
    return true;
}

// Crear habitación
function make_room(x, y, w, h) {
    for (var i = x; i < x + w; i++) {
        for (var j = y; j < y + h; j++) {
            tiles[i][j] = 0;
        }
    }
}

// Crear primera habitación en el centro
var start_w = irandom_range(_minroomh, _maxroomh);
var start_h = irandom_range(_minroomv, _maxroomv);
var start_x = (_xlimit div 2) - (start_w div 2);
var start_y = (_ylimit div 2) - (start_h div 2);
make_room(start_x, start_y, start_w, start_h);
array_push(room_list, [start_x, start_y, start_w, start_h]);

// Direcciones de expansión: [dx, dy]
var directions = [
    [0, -1], // arriba
    [0, 1],  // abajo
    [-1, 0], // izquierda
    [1, 0]   // derecha
];

var attempts = 0;
while (array_length(room_list) < _rooms && attempts < 10000) {
    attempts++;

    // Elegir una habitación base
    var base = room_list[irandom(array_length(room_list) - 1)];
    var bx = base[0], by = base[1], bw = base[2], bh = base[3];

    // Mezclar las direcciones para intentar más de una
    var dirs = array_shuffle(directions);

    for (var d = 0; d < 4; d++) {
        var dir = dirs[d];
        var dx = dir[0], dy = dir[1];

        // Nueva habitación aleatoria
        var nw = irandom_range(_minroomh, _maxroomh);
        var nh = irandom_range(_minroomv, _maxroomv);
        var nx, ny, px, py;

        if (dx == 0) {
            // Vertical
            nx = bx + irandom(bw - 1) - (nw div 2);
            ny = (dy < 0) ? by - nh - 1 : by + bh + 1;
            px = clamp(nx + (nw div 2), 1, _xlimit - 2);
            py = (dy < 0) ? by - 1 : by + bh;
        } else {
            // Horizontal
            nx = (dx < 0) ? bx - nw - 1 : bx + bw + 1;
            ny = by + irandom(bh - 1) - (nh div 2);
            nx = clamp(nx, 1, _xlimit - nw - 2);
            py = clamp(ny + (nh div 2), 1, _ylimit - 2);
            px = (dx < 0) ? bx - 1 : bx + bw;
        }

        // Verificar y crear
        if (is_area_free(nx, ny, nw, nh)) {
            make_room(nx, ny, nw, nh);
            if (px >= 1 && px < _xlimit - 1 && py >= 1 && py < _ylimit - 1) {
                tiles[px][py] = 0; // pasillo
            }
            array_push(room_list, [nx, ny, nw, nh]);
            break; // solo una conexión nueva por intento
        }
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

tex = get_texture_coords_sprite(sprBtiles,70)

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
	
	var _c = 0;
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
		vertex_position_3d(v,sx,y,zv);
		vertex_color(v,_c[1],1);
		vertex_texcoord(v,tex.x1,tex.y1);
		vertex_position_3d(v,x,y,zv);
		vertex_color(v,_c[0],1);
		vertex_texcoord(v,tex.x2,tex.y1);
		
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
		vertex_position_3d(v,sx,y,zv);
		vertex_color(v,_c[1],1);
		vertex_texcoord(v,tex.x1,tex.y1);
		vertex_position_3d(v,x,y,zv);
		vertex_color(v,_c[0],1);
		vertex_texcoord(v,tex.x2,tex.y1);

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
		vertex_position_3d(v,sx,y,zv);
		vertex_color(v,_c[3],1);
		vertex_texcoord(v,tex.x1,tex.y1);
		vertex_position_3d(v,x,y,zv);
		vertex_color(v,_c[2],1);
		vertex_texcoord(v,tex.x2,tex.y1);

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
		vertex_position_3d(v,sx,y,zv);
		vertex_color(v,_c[1],1);
		vertex_texcoord(v,tex.x2,tex.y1);
		vertex_position_3d(v,sx,y,z);
		vertex_color(v,_c[3],1);
		vertex_texcoord(v,tex.x2,tex.y2);

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
		vertex_position_3d(v,sx,y,zv);
		vertex_color(v,_c[1],1);
		vertex_texcoord(v,tex.x2,tex.y1);
		vertex_position_3d(v,sx,y,z);
		vertex_color(v,_c[1],1);
		vertex_texcoord(v,tex.x2,tex.y2);
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
		vertex_position_3d(v,sx,y,zv);
		vertex_color(v,_c[3],1);
		vertex_texcoord(v,tex.x2,tex.y1);
		vertex_position_3d(v,sx,y,z);
		vertex_color(v,_c[1],1);
		vertex_texcoord(v,tex.x2,tex.y2);

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
		vertex_position_3d(v,sx,sy,zv);
		vertex_color(v,_c[1],1);
		vertex_texcoord(v,tex.x2,tex.y1);
		vertex_position_3d(v,sx,sy,z);
		vertex_color(v,_c[3],1);
		vertex_texcoord(v,tex.x2,tex.y2);
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
		vertex_position_3d(v,sx,sy,zv);
		vertex_color(v,_c[1],1);
		vertex_texcoord(v,tex.x2,tex.y1);
		vertex_position_3d(v,sx,sy,z);
		vertex_color(v,_c[1],1);
		vertex_texcoord(v,tex.x2,tex.y2);
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
		vertex_position_3d(v,sx,sy,zv);
		vertex_color(v,_c[3],1);
		vertex_texcoord(v,tex.x2,tex.y1);
		vertex_position_3d(v,sx,sy,z);
		vertex_color(v,_c[1],1);
		vertex_texcoord(v,tex.x2,tex.y2);
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
		vertex_position_3d(v,x,y,zv);
		vertex_color(v,_c[1],1);
		vertex_texcoord(v,tex.x1,tex.y1);
		vertex_position_3d(v,x,sy,zv);
		vertex_color(v,_c[0],1);
		vertex_texcoord(v,tex.x2,tex.y1);
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
		vertex_position_3d(v,x,y,zv);
		vertex_color(v,_c[1],1);
		vertex_texcoord(v,tex.x1,tex.y1);
		vertex_position_3d(v,x,sy,zv);
		vertex_color(v,_c[0],1);
		vertex_texcoord(v,tex.x2,tex.y1);
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
		vertex_position_3d(v,x,y,zv);
		vertex_color(v,_c[3],1);
		vertex_texcoord(v,tex.x1,tex.y1);
		vertex_position_3d(v,x,sy,zv);
		vertex_color(v,_c[2],1);
		vertex_texcoord(v,tex.x2,tex.y1);
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
vertex_freeze(v);
#endregion
x = 0;
y = 0;
image_blend = c_gray;
var _px = irandom(_xlimit-2)+1;
var _py = irandom(_ylimit-2)+1;

while(tiles[_px][_py] == 1)
{
	_px = irandom(_xlimit-2)+1;
    _py = irandom(_ylimit-2)+1;
}
instance_create_depth(_px<<4,_py<<4,0,objPlayer);