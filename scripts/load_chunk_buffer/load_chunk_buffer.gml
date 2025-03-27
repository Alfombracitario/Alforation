// Carga un chunk si no está en memoria
function load_chunk_buffer(cx, cy) {
	var chunk_size = global.chunk_size;
	
	_cxx = cx*chunk_size
	_cyy = cy*chunk_size
	
	
    var key = chunk_key(cx, cy);
    if (!ds_map_exists(global.chunks, key)) {
        
		var f = buffer_load(working_directory+global.worldname+"data.bin");
		var _pos = buffer_find_key(f,key);
		show_debug_message("key "+key+" Found on "+string(_pos))
        if(_pos = -1) {
            // Si no existe, generar un nuevo chunk
            new_chunk_buffer(cx, cy);
			}
			
			else
			{
			//Si el chunk existe, cargar los datos
			var ins = instance_create_layer(_cxx,_cyy,"instances",objChunk);
			buffer_seek(f,buffer_seek_start,_pos);
			
			ins.temperature = buffer_read(f,buffer_u8)
			ins.humidity = buffer_read(f,buffer_u8)
			ins.image_blend = get_color_colormap(ins.temperature,ins.humidity);
			
			var file_size = buffer_key_size(f,_pos)-2;
			for(var i = 0; i < file_size; i+=2)
			{
				
				var obj_id = buffer_read(f,buffer_u8);
				var pos;
				
				switch(obj_id)
				{
					case 0:
						pos = buffer_read_hex(f);
						var ins2 = instance_create_layer(_cxx+(pos[0]<<4),_cyy+(pos[1]<<4),"instances",objTallgrass);
						ins2.image_blend = ins.image_blend;
					break;
				
					case 1:
						pos = buffer_read_hex(f);
						instance_create_layer(_cxx+(pos[0]<<4),_cyy+(pos[1]<<4),"instances",objPinetree);
					break;
				
					case 2:
						pos = buffer_read_hex(f);
						instance_create_layer(_cxx+(pos[0]<<4),_cyy+(pos[1]<<4),"instances",objStone);
					break;
				}
				
				buffer_delete(f);
			}
			
		}
        // Solo registramos que el chunk está activo
        ds_map_add(global.chunks, key, true);
    }
}