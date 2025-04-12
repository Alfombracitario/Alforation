function add_obj(times,object)
{
	for(var i = 0; i < times; i++)
		{
			var _x = x+(irandom(15)<<4);
			var _y = y+(irandom(15)<<4);
			for(var j = 0; j < objectcount; j++)
			{
				if objects[j][1] == _x && objects[j][2] == _y
				{
					_x = x+(irandom(15)<<4);
					_y = y+(irandom(15)<<4);
					j = 0;
				}
			}
			objects[objectcount][0] = object;
			objects[objectcount][1] = _x;
			objects[objectcount][2] = _y;
			objectcount++
		}
}