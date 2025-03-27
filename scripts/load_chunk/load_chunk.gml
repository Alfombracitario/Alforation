// Carga un chunk si no está en memoria
function load_chunk(cx, cy) {
	var chunk_size = global.chunk_size
	
	var _cxx = cx*chunk_size
	var _cyy = cy*chunk_size
	
	
    var key = chunk_key(cx, cy);
    if (!ds_map_exists(global.chunks, key)) {
        
        // Aquí verificas si el archivo existe y cargas los datos si es necesario
        if (!file_exists(working_directory+global.worldname+key+".bin")) {
            // Si no existe, generar un nuevo chunk
            new_chunk(cx, cy);
        }
		else
		{	//Si el chunk existe, cargar los datos
			var f = file_bin_open(working_directory+global.worldname+key+".bin",0);
			var ins = instance_create_layer(_cxx,_cyy,"instances",objChunk);
			
			ins.temperature = file_bin_read_byte(f);
			ins.humidity = file_bin_read_byte(f);
			ins.image_blend = get_color_colormap(ins.temperature,ins.humidity);
			
			var object;
			var file_size = file_bin_size(f)-2;
			var pos;
			
			for(var i = 0; i < file_size; i+=2)
			{
				
				var valuetoread = file_bin_read_byte(f);
				
				switch(valuetoread)
				{
					case 0:
						object = objTallgrass;
						pos = file_bin_read_hex(f);
						var ins2 = instance_create_layer(_cxx+(pos[0]<<4),_cyy+(pos[1]<<4),"instances",object);
						ins2.image_blend = ins.image_blend;
					break;
				
					case 1:
						object = objPinetree;
						pos = file_bin_read_hex(f);
						instance_create_layer(_cxx+(pos[0]<<4),_cyy+(pos[1]<<4),"instances",object);
					break;
				
					case 2:
						object = objStone;
						pos = file_bin_read_hex(f);
						instance_create_layer(_cxx+(pos[0]<<4),_cyy+(pos[1]<<4),"instances",object);
					break;
				}
				
			}
			file_bin_close(f);
		}
		
        
        // Solo registramos que el chunk está activo
        ds_map_add(global.chunks, key, true);
    }
}