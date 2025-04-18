direction = point_direction(x,y,objPlayer.x,objPlayer.y);
if(hp < 3)
{
	if mspeed > -2.5 mspeed -= 0.2
}
var dist = point_distance(x, y, objPlayer.x, objPlayer.y);
if(hp < 0)
{
	instance_destroy();
}
else if(dist > 1024)
{
	drop = false;
	instance_destroy();
}
else
{
	draw_3d_image_animation();
}
image_blend = merge_color(c_white,c_red,knockspd*0.25);
if(knockspd < 0) knockspd += 0.1;
speed = mspeed+knockspd;