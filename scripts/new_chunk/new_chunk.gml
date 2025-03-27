function new_chunk(cx, cy)
{
	var key = chunk_key(cx,cy);
	show_debug_message("Making a chunk for "+key+".bin")
	var f = file_bin_open(working_directory+global.worldname+key+".bin",1);
	_cxx = cx*global.chunk_size;
	_cyy = cy*global.chunk_size;
	var _humidity = irandom(255);
	var _temperature = irandom(255);
	file_bin_write_byte(f,_humidity);
	file_bin_write_byte(f,_temperature);
	file_bin_close(f);
	
	var color = get_color_colormap(_temperature,_humidity)
	
	add_obj((_humidity+_temperature*0.4)*0.06,objTallgrass,color);
	add_obj(11,objPinetree);
	add_obj(7,objStone);
	
	var ins = instance_create_layer(cx*chunk_size,cy*chunk_size,"instances",objChunk);
	ins.temperature = _temperature;
	ins.humidity = _humidity;
	ins.image_blend = get_color_colormap(_temperature,_humidity);
}