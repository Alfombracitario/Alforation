global.fpsmode = (global.fpsmode mod 2) + 1;
if(global.fpsmode = 1)
{
	game_set_speed(60,gamespeed_fps);
}
else
{
	game_set_speed(30,gamespeed_fps);
}
