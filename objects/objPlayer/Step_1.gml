w_width = window_get_width();
w_height = window_get_height();
gw = display_get_gui_width();
gh = display_get_gui_height();

//input
//reset
Pdpad_u = 0;
Pdpad_d = 0;
Pdpad_l = 0;
Pdpad_r = 0;
Pface_a = 0;
Pface_b = 0;
Pface_x = 0;
Pface_y = 0;
Pshoulder_l = 0;
Pshoulder_r = 0;
Pshoulder_lb = 0;
Pshoulder_rb = 0;
Pselect = 0;
Pstart = 0;
Dface_a = 0;

Pkey_w = 0;
Pkey_a = 0;
Pkey_s = 0;
Pkey_d = 0;
Pclick_r = 0;
Pclick_l = 0;

//define
if(gamepad_is_connected(0))
{
Pdpad_u = gamepad_button_check_pressed(0, gp_padu);
Pdpad_d = gamepad_button_check_pressed(0, gp_padd);
Pdpad_l = gamepad_button_check_pressed(0, gp_padl);
Pdpad_r = gamepad_button_check_pressed(0, gp_padr);
Pface_a = gamepad_button_check_pressed(0, gp_face1);
Pface_b = gamepad_button_check_pressed(0, gp_face2);
Pface_x = gamepad_button_check_pressed(0, gp_face3);
Pface_y = gamepad_button_check_pressed(0, gp_face4);
Pshoulder_l = gamepad_button_check_pressed(0,gp_shoulderl);
Pshoulder_r = gamepad_button_check_pressed(0,gp_shoulderr);
Pshoulder_lb = gamepad_button_check_pressed(0,gp_shoulderlb);
Pshoulder_rb = gamepad_button_check_pressed(0,gp_shoulderrb);
Pselect = gamepad_button_check_pressed(0,gp_select);
Pstart = gamepad_button_check_pressed(0,gp_start);
Dface_a = gamepad_button_check(0,gp_face1);
}
if(os_type == os_windows || os_type = os_android)
{
Pkey_w = 0;
Pkey_a = 0;
Pkey_s = 0;
Pkey_d = 0;
}
Pclick_r = 0;
Pclick_l = 0;

if(global.players > 1)//ajustar dependiendo de la cantidad de jugadores
{
	factordiv = 0.5;
	gw*=0.5;
	if global.players > 2 gh*=0.5;
}
previnvmousex = invmousex;
previnvmousey = invmousey;

prevmousex[0] = mousex[0];
prevmousey[0] = mousey[0];

prevmousex_r[0] = mousex_r[0];
prevmousey_r[0] = mousey_r[0];
if(os_type == os_android || os_type == os_ios)
{
	prevmousex[1] = mousex[1];
	prevmousey[1] = mousey[1];
	prevmousex[2] = mousex[2];
	prevmousey[2] = mousey[2];
	prevmousex_r[1] = mousex_r[1];
	prevmousey_r[1] = mousey_r[1];
	prevmousex_r[2] = mousex_r[2];
	prevmousey_r[2] = mousey_r[2];
}


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
var _target_speed = (running ? 2.8 : 1.8) * global.fpsmode;

fov_mod = (mspeed/global.fpsmode)*5
mspeed = lerp(mspeed,_target_speed,0.25);

z-=zspeed;
zspeed+=grav;
if(z > 0)
{
    z = 0;
    zspeed = 0;
}

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
hurt_tic-=0.01*global.fpsmode;

//datos para controlar tiempo, hambre, temperatura, etc
_hunger -= _target_speed*0.0005;

if(_health < maxhealth)
{
	_health += 0.01*global.fpsmode
	_hunger -= 0.003*global.fpsmode;
}

_temperature = (_temperature*255*global.fpsmode + ExtTemperature)/256*global.fpsmode;

if (room == game)
{
    // Tiempo del día
    _time += 0.01*global.fpsmode; // 10 minutos = un ciclo
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

        fog_color = merge_color($0A9FFF, $120406, amt); // Naranja → Negro azulado
        timecolor = merge_color($A0A0Ff, $7a6a6a, amt); // Rosado claro → Gris azulado
        sky_color = merge_color($3f054a,$000000, amt);
    }
    else if (_time < 340) // Noche
    {
        fog_color = $120406;
        timecolor = $7a6a6a;
		sky_color = $000000;
		if fog_density < fog_depth<<1 fog_density+=17;

        if (irandom(500) == 0)
        {
            var r_min = 256;
            var r_max = 512;

            var angle = irandom(359);
            var distance = r_min + irandom(r_max - r_min);

            var _x = x + lengthdir_x(distance, angle);
            var _y = y + lengthdir_y(distance, angle);

            instance_create_depth(_x, _y, 0, objEpronifo);
        }
    }
    else // Mañana
    {
        var amt = (_time - 340) * 0.05;
        sky_color = merge_color($3f050a, $DF5F2F, amt)
        fog_color = merge_color($120406, $FF9865, amt); // Negro azulado → Azul claro
        timecolor = merge_color($7a6a6a, $FFFFFF, amt); // Gris azulado → Blanco
    }
}

//biomas especiales
if(ExtTemperature > 215 && humidity > 215)//Jungla
{
	if(fog_density < fog_depth) fog_density+=16;
	fog_color += $002000;
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
if cooldown > 0 cooldown -= global.fpsmode;
