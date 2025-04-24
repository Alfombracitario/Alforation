#region cave generation mejorado
_xlimit = 64;
_ylimit = 64;

tiles = array_create(_xlimit, 0);
for (var i = 0; i < _xlimit; i++) {
    tiles[i] = array_create(_ylimit, 1); // Todo muro al inicio (1)
}

// Parámetros
var _steps_per_worm = 200;
var _initial_worms = 3;
var _worm_branch_chance = 0.02;
var _max_total_worms = 10;

// Iniciar gusanos desde el centro
var _start_x = _xlimit div 2;
var _start_y = _ylimit div 2;

var _worms = [];
for (var i = 0; i < _initial_worms; i++) {
    array_push(_worms, [_start_x, _start_y]);
}
var _total_worms = _initial_worms;

var _index = 0;
while (_index < array_length(_worms)) {
    var _pos = _worms[_index];
    var _x = _pos[0];
    var _y = _pos[1];

    for (var _s = 0; _s < _steps_per_worm; _s++) {
        // Tallar zona (3x3)
        for (var _dx = -1; _dx <= 1; _dx++) {
            for (var _dy = -1; _dy <= 1; _dy++) {
                var _xx = _x + _dx;
                var _yy = _y + _dy;
                if (_xx > 1 && _xx < _xlimit - 2 && _yy > 1 && _yy < _ylimit - 2) {
                    tiles[_xx][_yy] = 0;
                }
            }
        }

        // Movimiento aleatorio
        var _dir = irandom(3);
        switch (_dir) {
            case 0: _x += 1; break;
            case 1: _x -= 1; break;
            case 2: _y += 1; break;
            case 3: _y -= 1; break;
        }

        _x = clamp(_x, 3, _xlimit - 4);
        _y = clamp(_y, 3, _ylimit - 4);

        // Ramificación: solo durante los primeros pasos
        if (_s < 40 && random(1) < _worm_branch_chance && _total_worms < _max_total_worms) {
            array_push(_worms, [_x, _y]);
            _total_worms += 1;
        }
    }

    _index += 1;
}

//tocó añadir cosas para bajar o subir más
place_random_spot(true,objCaveladderup);
place_random_spot(true,objCaveladderdown);
#endregion




#region 3D
vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_color();
vertex_format_add_texcoord();

f = vertex_format_end();
v = vertex_create_buffer();

tex = get_texture_coords_sprite(sprBtiles,63)

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
var _px = irandom(_xlimit-2)+1;
var _py = irandom(_ylimit-2)+1;

while(tiles[_px][_py] == 1)
{
	_px = irandom(_xlimit-2)+1;
    _py = irandom(_ylimit-2)+1;
}
instance_create_layer(_px<<4,_py<<4,"instances",objPlayer);