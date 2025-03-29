w_width = window_get_width();
w_height = window_get_height();
gw = display_get_gui_width();
gh = display_get_gui_height();

mousex[0] = device_mouse_x_to_gui(0);
mousey[0] = device_mouse_y_to_gui(0);

if(os_type == os_android || os_type == os_ios)
{
	mousex[1] = device_mouse_x_to_gui(1);
	mousey[1] = device_mouse_y_to_gui(1);
	mousex[2] = device_mouse_x_to_gui(2);
	mousey[2] = device_mouse_y_to_gui(2);
}

var _target_speed = (keyboard_check(vk_shift) ? 2.8 : 1.8) * global.fpsmode;

if gamepad_button_check(0,gp_face2) _target_speed = 2.8*global.fpsmode;

fov_mod = (mspeed/global.fpsmode)*5

mspeed = lerp(mspeed,_target_speed,0.25);

#region CHUNKS
pcx = floor(x/chunk_size);
pcy = floor(y/chunk_size);
update_chunks();
last_pcx = pcx;
last_pcy = pcy;
#endregion

//random
hurt_tic-=0.01;

//datos para controlar tiempo, hambre, temperatura, etc

_hunger -= _target_speed*0.0005;

if(_health < maxhealth)
{
	_health += 0.01*global.fpsmode
	_hunger -= 0.003*global.fpsmode;
}

_temperature = (_temperature*63 + ExtTemperature)/64;

//tiempo del día
time += 0.01;//10 minutos = un ciclo

time = time mod 360;

notday = true;
if(time < 160)//día
{
	fog_color = $FF9865;
	notday = false;
	timecolor = c_white;
}
else if(time > 160 && time < 180)//atardecer
{
	var color0 = [101,152,255];
	var color1 = [255,159,10];
	fog_color = get_color_gradient(time-160,color0,color1,20);
	
	var color2 = [255,255,255];
	var color3 = [200,160,160];
	timecolor = get_color_gradient(time-160,color2,color3,20);
	
}
else if(time > 180 && time < 200)//anochecer
{
	var color0 = [255,159,10];
	var color1 = [0,0,16];
	fog_color = get_color_gradient(time-180,color0,color1,20);
	
	var color2 = [200,160,160];
	var color3 = [108,108,128];
	timecolor = get_color_gradient(time-180,color2,color3,20);
}
else if(time > 200 && time < 340)//noche
{
	fog_color = $0F0000;
	timecolor = make_color_rgb(108,100,128);
	if(irandom(500) == 500)
	{
		var _x = x + ((16 + irandom(16))<<4);
		var _y = y + ((16 + irandom(16))<<4);
		instance_create_layer(_x,_y,"instances",objEslime);
	}
}
else if(time > 340)//mañana
{
	var color0 = [0,0,16];
	var color1 = [101,152,255];
	fog_color = get_color_gradient(time-340,color0,color1,20);
	
	var color2 = [108,108,128];
	var color3 = [255,255,255];
	timecolor = get_color_gradient(time-340,color2,color3,20);
}
if cooldown > 0 cooldown--;