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
				
				if(temperature > 220 && humidity < 20)//Desierto
				{
					var times = irandom(11);
					add_obj(times,T_DEAD_BUSH);
					
					var times = irandom(7);
					add_obj(times,T_CACTUS);
					
					sprite_index = sprSand;
				}
				else if(temperature > 160 && humidity < 80) //acacia
				{
					var times = irandom(2);
					add_obj(times,T_DEAD_BUSH);
					
					var times = irandom(11);
					add_obj(times,T_TREE);
					
					var times = irandom(32);
					add_obj(times,T_GRASS);
					
					times = irandom(5);
					add_obj(times,T_STONE);

					times = irandom(1);
					add_obj(times,T_MUSHROOM1);
				
					times = irandom(1);
					add_obj(times,T_MUSHROOM2);
					
					times = irandom(1);
					add_obj(times,T_STONE_COAL);
					
					if(irandom(5) == 0)
					{
						add_obj(1,T_STONE_TIN);
					}
					
					if(irandom(15) == 0)
					{
						add_obj(1,T_STONE_COPPER);
					}
					
					th = -44;
					tw = 20;
					tree = sprite_get_texture(sprAcaciatree,0);
					image_blend = get_color_colormap(temperature,humidity);
				}
				else if(temperature < 10 && humidity < 30)//Nieve
				{
					
					var times = irandom(11);
					add_obj(times,T_DEAD_BUSH);//arbusto muerto
					var times = irandom(11);
					add_obj(times,T_TREE);//arbol
					
					tree = sprite_get_texture(sprPinetree,1);
					sprite_index = sprSnow;
				}
				else if(temperature > 220 && humidity > 230)//Jungla
				{

					var times = irandom(15);
					add_obj(times,T_TREE);
					
					times = irandom(12);
					add_obj(times,T_GRASS);
					
					times = irandom(6);
					add_obj(times,T_FERN);
					
					times = irandom(3);
					add_obj(times,T_WATERMELON);
					
					tree = sprite_get_texture(sprBamboo,0);
					th = -52;
					tw = 8;
					image_blend = get_color_colormap(temperature,humidity);
				}
				else if(temperature < 100 && temperature > 50 && humidity < 110 && humidity > 80)//bosque de pinos grandes
				{
					var times = irandom(12);
					add_obj(times,T_TREE);//Pinos grandes
					
					var times = irandom(5);
					add_obj(times,T_DEAD_BUSH);
					
					times = irandom(6);
					add_obj(times,T_FERN);
					
					times = irandom(12);
					add_obj(times,T_GRASS);
					
					tw = 48;
					th = -192;
					tree = sprite_get_texture(sprPinetreebig,0);

					image_blend = get_color_colormap(temperature,humidity);
				}
				else if(temperature < 150 && temperature > 100 && humidity < 190 && humidity > 130)//Abedul
				{
					tree = sprite_get_texture(sprBirchTree,0);
					image_blend = get_color_colormap(temperature,humidity)
					
					var times = irandom(12);
					add_obj(times,T_TREE);
				
					times = irandom(15);
					add_obj(times,T_GRASS);
				
					times = irandom(7);
					add_obj(times,T_STONE);

					times = irandom(2);
					add_obj(times,T_MUSHROOM1);
				
					times = irandom(4);
					add_obj(times,T_MUSHROOM2);
					
					times = irandom(1);
					add_obj(times,T_STONE_COAL);
					
					if(irandom(5) == 0)
					{
						add_obj(1,T_STONE_TIN);
					}
					
					if(irandom(15) == 0)
					{
						add_obj(1,T_STONE_COPPER);
					}
				}
				else if(temperature < 40 && humidity > 180)//corrupción
				{
					tree = sprite_get_texture(sprDeadtree,0);
					th = -48;
					tw = 16;
					image_blend = get_color_colormap(temperature,humidity);
					
					var times = irandom(4);
					add_obj(times,T_TREE);
					
					var times = irandom(5);
					add_obj(times,T_DEAD_BUSH);
					
					times = irandom(6);
					add_obj(times,T_GRASS);
					
					times = irandom(5);
					add_obj(times,T_MUSHROOM3);
					
					times = irandom(5);
					add_obj(times,T_GRASS2);
					
				}
				else
				{	//regla de generación general
					tree = sprite_get_texture(sprPinetree,0);
					image_blend = get_color_colormap(temperature,humidity)
					
					var times = irandom(11);
					add_obj(times,T_TREE);
				
					times = irandom((humidity+temperature)>>4);
					add_obj(times,T_GRASS);
				
					times = irandom(7);
					add_obj(times,T_STONE);
				
					times = irandom(humidity>>5);
					add_obj(times,T_FERN);

					times = irandom(2);
					add_obj(times,T_MUSHROOM1);
				
					times = irandom(2);
					add_obj(times,T_MUSHROOM2);

					times = irandom(temperature>>7);
					add_obj(times,T_WILD_WHEAT);
					
					times = irandom(1);
					add_obj(times,T_STONE_COAL);
					
					if(irandom(5) == 0)
					{
						add_obj(1,T_STONE_TIN);
					}
					
					if(irandom(15) == 0)
					{
						add_obj(1,T_STONE_COPPER);
					}
				}
				if(temperature > 150 && temperature < 230 && humidity > 80)
				{
					th = -64
					tree = sprite_get_texture(sprOaktree,0);
				}
				image_xscale = 16;
				image_yscale = 16;
			}
        }
		#endregion
		#region Load chunk
		else
		{	//Si el chunk existe, cargar los datos
			var ins = instance_create_depth(_cxx,_cyy,0,objChunk);
			with(ins)
			{
				//Basicamente este es el evento create del chunk, solo que ejecutado desde aquí
				
				var values = generate_noise(cx,cy,global.seed);
			
				temperature = values[0];
				humidity = values[1];
				save = true; //si no se guardan, el juego los tomará como chunks nuevos y los regenerá
				
				if(temperature > 230 && humidity < 20)
				{
					sprite_index = sprSand;
				}
				else
				{	
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
						valuetoread = real(valuetoread);

						objects[i][0] = valuetoread; //objeto
						objects[i][1] = x+(hex_to_dec_one(hex_digit[0])<<4); //X pos
						objects[i][2] = y+(hex_to_dec_one(hex_digit[1])<<4); //Y pos
					}
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