vertex_delete_buffer(v[0]);
vertex_format_delete(f[0]);
vertex_delete_buffer(v[1]);
vertex_format_delete(f[1]);

var key = chunk_key(cx, cy);
if(save == true)
{
	var pos = ["0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"];
	ds_map_delete(global.chunks, key);
	ini_section_delete(key);
	
	var objc = 0;

	for(var i = 0; i < objectcount; i++)
	{
		if objects[i][0] == -1 continue;
		
		var _x = objects[i][1]-x;
		var _y = objects[i][2]-y;
		_x = _x>>4;
		_y = _y>>4;
		ini_write_string(key,objc,string(objects[i][0])+pos[_x]+pos[_y]);
		objc++;
	}
ini_write_string(key,"r",string(objc));
}
else
{
	ds_map_delete(global.chunks, key);
	ini_section_delete(key);
}