global.fpsmode = global.fpsmode mod 2;
global.fpsmode++;
game_set_speed(60/global.fpsmode,gamespeed_fps);
button[4][5] = "FPS rate: "+string(60/global.fpsmode);