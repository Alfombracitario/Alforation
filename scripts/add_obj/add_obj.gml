function add_obj(times,object,hp)
{
	for(var i = 0; i < times; i++)
		{
			objects[objectcount][0] = object;
			objects[objectcount][1] = x+(irandom(15)<<4);
			objects[objectcount][2] = y+(irandom(15)<<4);
			objects[objectcount][3] = hp;
			objectcount++
		}
}