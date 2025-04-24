//aquí se maneja la animación
if(frame_index == 0)
{
	frame_index = 1;
}
else
{
	frame_index = 0;
}
alarm_set(0,8);
uv = get_texture_coords_sprite(sprEslime,frame_index)