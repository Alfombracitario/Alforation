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
			if(_index != -1)
			{
				activated = false;
				objects[_index][3] -= dam;
				
				if(objects[_index][3] <= 0)
				{
					var _item = 0;
					var _count = 1;
					switch(objects[_index][0])//drop
					{		
						case T_TREE:
							_item = 100;
							_count = wood;
							audio_play_sound(sndTreedestroy,0,0,global.sndvol);
						break;
						
						case 2: //roca
							_item = 101;
						break;
						
						case 4://mushroom
							_item = 113;
						break;
						
						case 5:
							_item = 114;
						break;
						
						case 6:
							_item = 110;
							_count = irandom(8)>>3;
						break;
						
						
					}
					with(objPlayer)
					{
						add_item(_item,_count)
					}
					
					array_delete(objects,_index,1);
					objectcount--;
					global.update3d = true;
				}
			}
		}
	}
}
