function new_chunk_buffer(cx, cy)
{
	var key = chunk_key(cx,cy);
	var f = buffer_load(working_directory+global.worldname+"data.bin");
	_cxx = cx*global.chunk_size;
	_cyy = cy*global.chunk_size;
	var _humidity = irandom(255);
	var _temperature = irandom(255);
	buffer_seek(f,buffer_seek_end,0);
	buffer_write(f,buffer_string,"\n"+key+"\n");
	buffer_write(f,buffer_u8,_humidity);
	buffer_write(f,buffer_u8,_temperature);
	buffer_save(f,working_directory+global.worldname+"data.bin")
	buffer_delete(f)
	
	var color = get_color_colormap(_temperature,_humidity)
	
	add_obj((_humidity+_temperature*0.4)*0.06,objTallgrass,color);
	add_obj(11,objPinetree);
	add_obj(7,objStone);
	
	var ins = instance_create_layer(cx*chunk_size,cy*chunk_size,"instances",objChunk);
	ins.temperature = _temperature;
	ins.humidity = _humidity;
	ins.image_blend = get_color_colormap(_temperature,_humidity);
}