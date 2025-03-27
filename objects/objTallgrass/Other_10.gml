//delete grass
var cs = global.chunk_size;

var cx = floor(x/cs);
var cy = floor(y/cs);
var key = chunk_key(cx, cy);
if(!ds_map_exists(global.chunks,key))
{
	var _x = floor(x)-(cx*cs);
	var _y = floor(y)-(cy*cs);

	_x = _x>>4;
	_y = _y>>4;
	
	var pos = ["0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"];
	var i = ini_read_real(key,"r",0);
	ini_write_string(key,i,string(object_ID)+pos[_x]+pos[_y]);
	i++;
	ini_write_string(key,"r",i);
	instance_destroy();
}