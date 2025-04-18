//aquí se maneja la animación
if hp < maxhp hp+=0.025;
if(state == 1)//si se mueve
{
	if mspeed < 2.8 mspeed+=0.2;
	if(frame_index < 8)
	{
		frame_index ++
	}
	else
	{
		frame_index = 1;	
	}
	alarm_set(0,8);
}
else
{
	frame_index++
	frame_index = frame_index & 1
	alarm_set(0,8);
	var dist = point_distance(x, y, objPlayer.x, objPlayer.y);
	if(dist < 256)
	{
		mspeed = 1;
		state = 1;
	}
}