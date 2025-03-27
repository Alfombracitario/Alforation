var _x = lengthdir_x(1,direction);
var _y = lengthdir_y(1,direction);

var _t = 0;
while(!collision_line(x,y,x + _x * 4,y + _y * 4,objSolid,0,true)) {
	x += _x * 4;
	y += _y * 4;
	
	_t++;
	if(_t >= 500) { instance_destroy(); return; }
}

_t = 0;
while(collision_line(x,y,x + _x,y + _y,objSolid,0,true)) {
	x -= _x;
	y -= _y;
	
	_t++;
	if(_t >= 200) break;
}
instance_create_depth(x,y,-8,objDust);