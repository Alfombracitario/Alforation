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
					var tile_index = objects[_index][0]
					
					with(objPlayer)
					{
						var _item = drops[tile_index][0];
						var _count = drops[tile_index][1];
						
						if(_count < 1)
						{
							var probabilidad = _count; // Reemplázalo con el valor deseado entre 0 y 1
							_count = (random(1) < probabilidad) ? 1 : 0;
						}
						add_item(_item,_count)
					}
					
					array_delete(objects,_index,1);
					objectcount--;
					instance_activate_object(objVisioncol);
					draw = true;
				}
			}
		}
	}
}
