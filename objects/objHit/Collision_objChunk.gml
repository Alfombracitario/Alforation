if(activated == true)
{
	var _x = (x>>4)<<4;
	var _y = (y>>4)<<4;
	var dam = damage;
	with(other)
	{
		if(objectcount > 0)
		{
			var _index = detect_tile(_x,_y);
			show_debug_message(objects);
			show_debug_message(_index);
			if(_index != -1)
			{
				objects[_index][3] -= dam;
			
				if(objects[_index][3] <= 0)
				{
					switch(objects[_index][0])//drop
					{
						case -1:
							break;
						case 0: //arbol
							objPlayer.inventory[0][0] = 19;
							objPlayer.inventory[0][1] += wood;
						break;
					
					}
					array_delete(objects,_index,1);
					objectcount--;
					global.update3d = true;
				}
			}
		}
	}
}
