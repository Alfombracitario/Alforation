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
				activated = false;//chocó con un tile, se desactiva el golpe
				
				//activar al impostor
				with(objImposter)
				{
					activated = true;
					tile_index = _index;
					damage = dam;
					x = _x;
					y = _y;
				}
				array_delete(objects,_index,1);
				objectcount--;
				instance_activate_object(objVisioncol);
				draw = true;
			}
		}
	}
}