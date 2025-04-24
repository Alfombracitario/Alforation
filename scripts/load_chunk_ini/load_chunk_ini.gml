// Carga un chunk si no está en memoria
function load_chunk_ini(cx, cy) {
	
	var _cxx = cx*CHUNK_SIZE
	var _cyy = cy*CHUNK_SIZE
	
    var key = chunk_key(cx, cy);
	
    if (!ds_map_exists(global.chunks, key)) 
	{
		#region New chunk
        if (!ini_section_exists(key)) {
            
			random_set_seed(global.seed+cx+100000*cy);
			
			var ins = instance_create_depth(cx*CHUNK_SIZE,cy*CHUNK_SIZE,0,objChunk);
			
			var values = generate_noise(cx,cy,global.seed);
			ins.temperature = values[0];
			ins.humidity = values[1];
			
            
			with(ins)
			{	
                //probabilidad ultra baja de hacer aparecer un dungueon
                /*var _r = irandom(100)
                if(_r == 1)
                {
                    var _x = x+(irandom(15)<<4);
			        var _y = y+(irandom(15)<<4);
                    _d = instance_create_depth(_x,_y,0,objDungeonladderdown)
                    _d.image_blend = get_color_colormap(temperature,humidity);
                }*/
                
				save = false;
				objectcount = 0;
				var times = 0;
                
				if(temperature > 210 && humidity < 30)//Desierto
				{
					times = irandom(11);
					add_obj(times,T_DEAD_BUSH);
					
					times = irandom(7);
					add_obj(times,T_CACTUS);
					
					sprite_index = sprSand;
                    
                    set_tree(sprPinetree)
				}
				else if(temperature > 160 && humidity < 80) //acacia
				{
					times = irandom(2);
					add_obj(times,T_DEAD_BUSH);
					
					times = irandom(11);
					add_obj(times,T_TREE);
					
					times = irandom(21);
					add_obj(times,T_GRASS);
                    
                    times = irandom(15);
                    add_obj(times,T_TALLGRASS);
					
					times = irandom(5);
					add_obj(times,T_STONE);
					
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
					
					set_tree(sprAcaciatree);
					image_blend = get_color_colormap(temperature,humidity);
				}
				else if(temperature < 25 && humidity < 40)//Nieve
				{
					
					times = irandom(11);
					add_obj(times,T_DEAD_BUSH);
					times = irandom(11);
					add_obj(times,T_TREE);
                    times = irandom(1);
                    add_obj(times,T_STONE_IRON);
					
					set_tree(sprPinetree,1);
					sprite_index = sprSnow;
				}
				else if(temperature > 215 && humidity > 215)//Jungla
				{

					times = irandom(25);
					add_obj(times,T_TREE);
					
					times = irandom(6);
					add_obj(times,T_GRASS);
                    
                    times = irandom(16);
                    add_obj(times,T_TALLGRASS);
					
					times = irandom(19);
					add_obj(times,T_FERN);
					
					times = irandom(2);
					add_obj(times,T_WATERMELON);
					
					times = irandom(1);
					add_obj(times,T_STONE);
					
                    times = irandom(6);
                    add_obj(times,T_BAMBOO);
                    set_tree(sprJungletree);
					image_blend = get_color_colormap(temperature,humidity);
				}
				else if(temperature < 100 && temperature > 50 && humidity < 110 && humidity > 80)//bosque de pinos grandes
				{
					times = irandom(12);
					add_obj(times,T_TREE);//Pinos grandes
					
					times = irandom(5);
					add_obj(times,T_DEAD_BUSH);
					
					times = irandom(6);
					add_obj(times,T_FERN);
					
					times = irandom(12);
					add_obj(times,T_GRASS);
                    
                    times = irandom(2);
                    add_obj(times,T_TALLGRASS);
					
					set_tree(sprPinetreebig);
					image_blend = get_color_colormap(temperature,humidity);
				}
				else if(temperature < 150 && temperature > 100 && humidity < 190 && humidity > 130)//Abedul
				{
					set_tree(sprBirchTree);
					image_blend = get_color_colormap(temperature,humidity)
					
					times = irandom(12);
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
					set_tree(sprDeadtree);
					image_blend = get_color_colormap(temperature,humidity);
					
					times = irandom(4);
					add_obj(times,T_TREE);
					
					times = irandom(5);
					add_obj(times,T_DEAD_BUSH);
					
					times = irandom(6);
					add_obj(times,T_GRASS);
					
					times = irandom(5);
					add_obj(times,T_MUSHROOM3);
					
					times = irandom(5);
					add_obj(times,T_GRASS2);
					
				}
				else if(temperature > 70 && temperature < 120 && humidity > 130)//Pantano
				{
					set_tree(sprSwamptree);
					image_blend = get_color_colormap(temperature,humidity);
					times = irandom(18);
					add_obj(times,T_TREE);
					times = irandom(3)
					add_obj(times,T_DEAD_BUSH);
					times = irandom(4);
					add_obj(times,T_MUSHROOM1);
					times = irandom(5);
					add_obj(times,T_MUSHROOM2);
					times = irandom(8);
					add_obj(times,T_GRASS);
                    times = irandom(2);
                    add_obj(times,T_TALLGRASS);
					
				}
				else
				{	//regla de generación general
					set_tree(sprPinetree);
					image_blend = get_color_colormap(temperature,humidity)
					
					times = irandom(11);
					add_obj(times,T_TREE);
				
					times = irandom((humidity+temperature)>>4);
					add_obj(times,T_GRASS);
                    
                    times = irandom(4);
                    add_obj(times,T_TALLGRASS);
				
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
				if(temperature > 150 && temperature < 200 && humidity > 80)
				{
					set_tree(sprOaktree);
				}
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
				
				if(temperature > 210 && humidity < 30)//Desierto
				{
					sprite_index = sprSand;
				}
				else if(temperature > 160 && humidity < 80) //acacia
				{
					set_tree(sprAcaciatree);
					image_blend = get_color_colormap(temperature,humidity);
				}
				else if(temperature < 25 && humidity < 40)//Nieve
				{
					set_tree(sprPinetree,1);
					sprite_index = sprSnow;
				}
				else if(temperature > 215 && humidity > 215)//Jungla
				{
					if(humidity>240)
					{
						set_tree(sprBamboo);
					}
					else
					{
						set_tree(sprJungletree);
					}
					image_blend = get_color_colormap(temperature,humidity);
				}
				else if(temperature < 100 && temperature > 50 && humidity < 110 && humidity > 80)//bosque de pinos grandes
				{
					set_tree(sprPinetreebig);
					image_blend = get_color_colormap(temperature,humidity);
				}
				else if(temperature < 150 && temperature > 100 && humidity < 190 && humidity > 130)//Abedul
				{
					set_tree(sprBirchTree);
					image_blend = get_color_colormap(temperature,humidity);
				}
				else if(temperature < 40 && humidity > 180)//corrupción
				{
					set_tree(sprDeadtree);
					image_blend = get_color_colormap(temperature,humidity);
				}
				else if(temperature > 70 && temperature < 120 && humidity > 130)
				{
					set_tree(sprSwamptree);
					image_blend = get_color_colormap(temperature,humidity);
				}
				else
				{	//regla de generación general
					set_tree(sprPinetree);
					image_blend = get_color_colormap(temperature,humidity)

				}
				if(temperature > 150 && temperature < 200 && humidity > 80)
				{
					set_tree(sprOaktree);
				}
			
					var file_size = ini_read_real(key,"r",0);
				
					objectcount = file_size;
					
					for(var i = 0; i < file_size; i++)
					{
					
						var valuetoread = ini_read_string(key,i,0);
				
						var hex_digit = 0;
				
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
		#endregion
		
		//Este código es global para ambos casos
        ds_map_add(global.chunks, key, true);
		ins.cx = cx;
		ins.cy = cy;
		
		with(ins)
		{
			event_user(2);
		}
		//mentirle al juego para que actualize los modelos 3D
        prevcamyaw--;
    }
}