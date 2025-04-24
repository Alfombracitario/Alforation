if(activated == true)
{
	var _tree = other.tree;
	var _th = other.th;
	var _tw = other.tw;
	var _uv = other.uv;
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
                
                with(objPlayer) damage_hand_item(1);
				//activar al impostor
				var _tile_index = objects[_index][0];
				with(objImposter)
				{
					tile_index = _tile_index;
					damage = dam;
					x = _x;
					y = _y;
					if _tile_index == 0
					{
						tree = _tree;
						uv = _uv;
						th = _th;
						tw = _tw;
					}
					else
					{
						th = -16;
						tw = 8;
						//uv
					}
					event_user(1);
				}
                
				array_delete(objects,_index,1);
				objectcount--;
			}
		}
        //actualizar solo el chunk afectado
        draw = true;
        event_user(2);
	}
}