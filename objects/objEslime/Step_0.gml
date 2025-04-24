direction = point_direction(x,y,objPlayer.x,objPlayer.y);
if(hp < 2)
{
	speed = -1;
}
if(hp < 0)
{
	instance_destroy();
}
else
{
	draw_3d_sprite();
}