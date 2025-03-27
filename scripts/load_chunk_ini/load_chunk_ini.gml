// Carga un chunk si no está en memoria
function load_chunk_ini(cx, cy) {
	var chunk_size = global.chunk_size
	
	var _cxx = cx*chunk_size
	var _cyy = cy*chunk_size
	
	
    var key = chunk_key(cx, cy);
	
    if (!ds_map_exists(global.chunks, key)) 
	{
		#region New chunk
        if (!ini_section_exists(key)) {
            
			random_set_seed(global.seed+cx+100000*cy);
			
			var ins = instance_create_layer(cx*chunk_size,cy*chunk_size,"instances",objChunk);
			
			var values = generate_noise(cx,cy,global.seed);
			ins.temperature = values[0];
			ins.humidity = values[1];
			
			with(ins)
			{	
				save = false;
				
				objectcount = 0;
				//idea rápida que se le ocurrió a cerda para hacer los biomas lol
	
				image_blend = get_color_colormap(temperature,humidity)
				
				
				var times = irandom(11);
				add_obj(times,0,10);//arbol
				
				times = irandom(20);
				add_obj(times,1,1);//pasto
				
				times = irandom(7);
				add_obj(times,2,3);//roca
				
				times = irandom(4);
				add_obj(times,3,1);//fern

				times = irandom(2);
				add_obj(times,4,1);//champiñón
				
				times = irandom(2);
				add_obj(times,5,1);//champiñón2

				times = irandom(1);
				add_obj(times,6,1);//trigo weón
				
				image_xscale = 16;
				image_yscale = 16;
			}
        }
		#endregion
		#region Load chunk
		else
		{	//Si el chunk existe, cargar los datos
			var ins = instance_create_layer(_cxx,_cyy,"instances",objChunk);
			with(ins)
			{
				//Basicamente este es el evento create del chunk, solo que ejecutado desde aquí
				
				var values = generate_noise(cx,cy,global.seed);
			
				ins.temperature = values[0];
				ins.humidity = values[1];
				save = true;
				image_blend = get_color_colormap(temperature,humidity);
				image_xscale = 16;
				image_yscale = 16;
			
				var file_size = ini_read_real(key,"r",0);
				
				objectcount = file_size;
				
				for(var i = 0; i < file_size; i++)
				{
					
					var valuetoread = ini_read_string(key,i,0);
				
					var hex_digit;
				
					hex_digit[0] = string_char_at(valuetoread, 2);
					hex_digit[1] = string_char_at(valuetoread, 3);
					valuetoread = string_char_at(valuetoread, 1);
					valuetoread = int64(valuetoread);

					objects[i][0] = valuetoread; //objeto
					objects[i][1] =  x+(hex_to_dec_one(hex_digit[0])<<4); //X pos
					objects[i][2] =  y+(hex_to_dec_one(hex_digit[1])<<4); //Y pos
				}
				
			}
		}
		#endregion
		
		//Este código es global para ambos casos
        ds_map_add(global.chunks, key, true);
		ins.cx = cx;
		ins.cy = cy;
		
		with(ins)
		{
			init_3d_image_tile(0);
			init_3d_image_tile(1);
		}
		//mentirle al juego para que actualize los modelos 3D
		prevcamyaw--;
		
    }
}