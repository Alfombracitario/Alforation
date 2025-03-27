//Game end
var cs = global.chunk_size;

var cx = floor(x/cs);
var cy = floor(y/cs);
var key = chunk_key(cx, cy);

var _x = floor(x)-(cx*cs);
var _y = floor(y)-(cy*cs);

_x = _x>>4;
_y = _y>>4;
	
	/* buffer
	var f = buffer_load(working_directory+global.worldname+"data.bin");
	var _pos = buffer_find_key(f,key);
	var size = buffer_key_size(f,_pos);
	buffer_seek(f,buffer_seek_start,_pos+size);
	buffer_write(f,buffer_u8,object_ID);
	buffer_write_hex(f,_x,_y);
	buffer_save(f,working_directory+global.worldname+"data.bin");
	buffer_delete(f);
	instance_destroy();
	*/
	
	var pos = ["0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"];
	var i = ini_read_real(key,"r",0);
	ini_write_string(key,i,string(object_ID)+pos[_x]+pos[_y]);
	i++;
	ini_write_string(key,"r",i);
	instance_destroy();