w_width = window_get_width();
w_height = window_get_height();
gw = display_get_gui_width();
gh = display_get_gui_height();

mousex[0] = device_mouse_x_to_gui(0);
mousey[0] = device_mouse_y_to_gui(0);

mousex_r[0] = device_mouse_raw_x(0);
mousey_r[0] = device_mouse_raw_y(0);

if(os_type == os_android || os_type == os_ios)
{
	mousex_r[1] = device_mouse_x(1);
	mousey_r[1] = device_mouse_y(1);
	mousex_r[2] = device_mouse_x(2);
	mousey_r[2] = device_mouse_y(2);
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
if(room == game)
{
	pcx = x>>8;
	pcy = y>>8;
	update_chunks();
	last_pcx = pcx;
	last_pcy = pcy;
}
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

if (room == game)
{
    // Tiempo del día
    _time += 0.01; // 10 minutos = un ciclo
    _time = _time mod 360;

    notday = true;

    if (_time < 140) // Día
    {
        fog_color = $FFB885; // Azul claro (día)
        sky_color = $DF5F2F;
        notday = false;
        timecolor = c_white;
    }
    else if (_time < 160) // Atardecer
    {
        var amt = (_time - 140) * 0.05;

        fog_color = merge_color($FFB885, $0A9FfF, amt); // Azul claro → Naranja
        timecolor = merge_color($FFFFFF, $A0A0FF, amt); // Blanco → Rosado claro
        sky_color = merge_color($DF5F2F,$3f054a, amt);
    }
    else if (_time < 180) // Anochecer
    {
        var amt = (_time - 160) * 0.05;

        fog_color = merge_color($0A9FFF, $0F0204, amt); // Naranja → Negro azulado
        timecolor = merge_color($A0A0Ff, $5a4a4a, amt); // Rosado claro → Gris azulado
        sky_color = merge_color($3f054a,$000000, amt);
    }
    else if (_time < 340) // Noche
    {
        fog_color = $0F0204;
        timecolor = $5a4a4a;
		sky_color = $000000;
		if fog_density < fog_depth<<1 fog_density+=32;

        if (irandom(500) == 0)
        {
            var r_min = 256;
            var r_max = 512;

            var angle = irandom(359);
            var distance = r_min + irandom(r_max - r_min);

            var _x = x + lengthdir_x(distance, angle);
            var _y = y + lengthdir_y(distance, angle);

            instance_create_layer(_x, _y, "instances", objEpronifo);
        }
    }
    else // Mañana
    {
        var amt = (_time - 340) * 0.05;
        sky_color = merge_color($3f050a, $DF5F2F, amt)
        fog_color = merge_color($100000, $FF9865, amt); // Negro azulado → Azul claro
        timecolor = merge_color($806C6C, $FFFFFF, amt); // Gris azulado → Blanco
    }
}

//biomas especiales
if(ExtTemperature > 215 && humidity > 215)//Jungla
{
	if(fog_density < fog_depth) fog_density+=16;
	fog_color += $003000;
}
else if(ExtTemperature < 40 && humidity > 180)//corrupción
{
	if(fog_density < fog_depth) fog_density+=16;
	sky_color += $000030;
}
else
{
	if(fog_density > CHUNK_SIZE) fog_density-=16;	
}

if(room = dungeon)
{
	fog_color = c_black;
	if(keyboard_check(vk_space)) //antorcha placeholder
	{
		notday = false;
		fog_density = 400;
		fog_depth = 600;
	}
	else
	{
		notday = true;
		timecolor = make_color_rgb(108,100,128);
		fog_density = 40;
		fog_depth = 100;
	}
}
if cooldown > 0 cooldown--;
