var _move = 0;
var _smove = 0;
if(invopen == true)
{
	if(gamepad_is_connected(0))
	{
		if gamepad_button_check_pressed(0,gp_shoulderr) && selecteditem < invsize selecteditem++;
		selecteditem = selecteditem mod invsize
		if(gamepad_button_check_pressed(0,gp_shoulderl))
		{
			if(selecteditem > 0)
			{
				selecteditem--;
			}
			else
			{
				selecteditem = invsize-1;
			}
		}
		
		if gamepad_button_check_pressed(0,gp_padu) && selecteditem >= 10 selecteditem -= 10;
		if gamepad_button_check_pressed(0,gp_padd) && selecteditem < invsize-10 selecteditem += 10;
		if gamepad_button_check_pressed(0,gp_padr) && selecteditem < invsize-1 selecteditem++;
		if gamepad_button_check_pressed(0,gp_padl) && selecteditem > 0 selecteditem--;
		if gamepad_button_check_pressed(0, gp_face3) || gamepad_button_check_pressed(0, gp_face2) invopen = false;
		
		invmousex += gamepad_axis_value(0, gp_axislh)*global.settings.sensibility*global.fpsmode;
		invmousey += gamepad_axis_value(0, gp_axislv)*global.settings.sensibility*global.fpsmode;
	}
	else
	{
		if(os_type == os_windows || os_type == os_macosx || os_type == os_win8native || os_type == os_operagx)
		{
			if keyboard_check_pressed(ord("E")) invopen = false; window_mouse_set_locked(true);
			if mouse_wheel_down() && selecteditem < invsize selecteditem++;
			selecteditem = selecteditem mod invsize
			if(mouse_wheel_up())
			{
				if(selecteditem > 0)
				{
					selecteditem--;
				}
				else
				{
					selecteditem = invsize-1;
				}
			}
			if keyboard_check_pressed(ord("W")) && selecteditem >= 10 selecteditem -= 10;
			if keyboard_check_pressed(ord("S")) && selecteditem < invsize-10 selecteditem += 10;
			if keyboard_check_pressed(ord("D")) && selecteditem < invsize-1 selecteditem++;
			if keyboard_check_pressed(ord("A")) && selecteditem > 0 selecteditem--;
			if(prevmousex != device_mouse_x_to_gui(0) && prevmousex != device_mouse_y_to_gui(0))
			{
				invmousex = device_mouse_x_to_gui(0);
				invmousey = device_mouse_y_to_gui(0);
			}
		}
	}
	
	//global
	if (device_mouse_check_button_pressed(0,mb_left) || gamepad_button_check_pressed(0,gp_face1))
	{
		if(invmousex > invx-4 && invmousex < invx+164 && invmousey > invy-16 && invmousey < invy)
		{
			invmove = true;
		}
		
		if(invmousex > invx && invmousex < invx+160 && invmousey > invy && invmousey < invy+64)
		{
			var _sx = (invmousex-invx)>>4
			var _sy = (invmousey-invy)>>4
			selecteditem = _sx+(10*_sy);
		}
	}
	if (device_mouse_check_button_released(0,mb_left) || gamepad_button_check_released(0,gp_face1))
	{
		invmove = false;
	}
	
	if(invmove = true)
	{
		invx += invmousex-previnvmousex;
		invy += invmousey-previnvmousey;
	}
	
}
else
{
#region pc input
if(os_type == os_windows || os_type == os_macosx || os_type == os_win8native || os_type == os_operagx)
{
	_move = keyboard_check(ord("W")) - keyboard_check(ord("S"));
	_smove = keyboard_check(ord("A")) - keyboard_check(ord("D"));
	if keyboard_check_pressed(ord("E")) invopen = true; invmousex = gw>>1; invmousey = gh>>1;
	
	if mouse_wheel_down() && selecteditem < invsize selecteditem++;
	selecteditem = selecteditem mod invsize
	if(mouse_wheel_up())
	{
		if(selecteditem > 0)
		{
			selecteditem--;
		}
		else
		{
			selecteditem = invsize-1;
		}
	}
	
	if(window_mouse_get_locked()) {
	camz = clamp(camz + (clamp(window_mouse_get_delta_y() / 200,-0.15,0.15) * (abs(camz) + 1)),-4,4);
		turn_speed = lerp(turn_speed,clamp(-window_mouse_get_delta_x() / 3,-15,15),0.75);
	} else turn_speed = 0;
	
	cam_yaw -= turn_speed;
	
	if device_mouse_check_button_pressed(0,mb_left) event_user(15);//left click
}
#endregion
#region gamepad input
if(gamepad_is_connected(0))
{
	_move = -round(gamepad_axis_value(0, gp_axislv))
	_smove = -round(gamepad_axis_value(0, gp_axislh))
	camz = clamp(camz + (clamp(gamepad_axis_value(0, gp_axisrv)*global.fpsmode*global.settings.sensibility*0.02,-0.15*global.fpsmode,0.15*global.fpsmode) * (abs(camz) + 1)),-4,4);
	cam_yaw += gamepad_axis_value(0, gp_axisrh)*global.settings.sensibility*global.fpsmode;
	if gamepad_button_check_pressed(0,gp_shoulderr) && selecteditem < invsize selecteditem++;
	selecteditem = selecteditem mod invsize
	if(gamepad_button_check_pressed(0,gp_shoulderl))
	{
		if(selecteditem > 0)
		{
			selecteditem--;
		}
		else
		{
			selecteditem = invsize-1;
		}
	}
	
	
	gamepad_set_vibration(0,hurt_tic,hurt_tic);
	if gamepad_button_check_pressed(0, gp_select) display_info = !display_info;
	if gamepad_button_check_pressed(0, gp_face3) invopen = true; invmousex = gw>>1; invmousey = gh>>1;
	if gamepad_button_check_pressed(0, gp_face4) time = 1000;
	if gamepad_button_check_pressed(0, gp_shoulderrb) event_user(15);
}
#endregion
#region phones input
if(os_type == os_android || os_type == os_ios)
{
	
	for(var i = 0; i < 2; i++)
	{
			if(device_mouse_check_button(i,mb_left))
			{
				/// Comprobar entrada táctil para movimiento
				var dx = gw * invdpadx;
				var dy = gh * invdpady;
				var ds = round(gh*0.15);
				var touch_x = mousex[i];
				var touch_y = mousey[i];
				var _move = 0;
				var _smove = 0;
	
	
				var touching_dpad = (touch_x >= dx && touch_x <= dx + (ds * 3) && touch_y >= dy && touch_y <= dy + (ds * 3));
	
				if (touching_dpad) {
				    if (touch_x >= dx && touch_x <= dx + (ds * 3) && touch_y >= dy && touch_y <= dy + ds) {
				        _move = 1; // Arriba
				    }
					if (touch_x >= dx && touch_x <= dx + ds && touch_y >= dy && touch_y <= dy + (ds * 3)) {
				        _smove = 1; // Izquierda
				    }
					if (touch_x >= dx + (ds * 2) && touch_x <= dx + (ds * 3) && touch_y >= dy && touch_y <= dy + (ds * 3)) {
				        _smove = -1; // Derecha
				    }
					if (touch_x >= dx && touch_x <= dx + (ds * 3) && touch_y >= dy + (ds * 2) && touch_y <= dy + (ds * 3)) {
				        _move = -1; // Abajo
				    }
				}
				else
				{	
					if(device_mouse_check_button_pressed(i,mb_left))
					{
						prevmousex_r[i] = mousex_r[i];
						prevmousey_r[i] = mousey_r[i];
					}
					//camera
					cam_yaw += (mousex_r[i]-prevmousex_r[i])*0.25;
					camz = clamp(camz + (clamp((mousey_r[i]-prevmousey_r[i]) *0.0025, -0.15, 0.15) * (abs(camz) + 1)), -4, 4);
			
				}
				show_debug_message("MouseX: " + string(mousex_r[i]) + " PrevX: " + string(prevmousex_r[i]));
				show_debug_message("MouseY: " + string(mousey_r[i]) + " PrevY: " + string(prevmousey_r[i]));
		}
	}
}
#endregion
}
#region movement
if(_move != 0) {
	f_sp += _move * ((sign(f_sp) != _move) ? 0.3 : 0.15);
	f_sp = clamp(f_sp,-mspeed,mspeed);
} else {
	var _s = sign(f_sp);
	f_sp -= _s * 0.1*global.fpsmode;
	if(_s != sign(f_sp)) f_sp = 0;
}

if(_smove != 0) {
	s_sp += _smove * ((sign(s_sp) != _smove) ? 0.3 : 0.15);
	s_sp = clamp(s_sp,-mspeed,mspeed);
} else {
	var _s = sign(s_sp);
	s_sp -= _s * 0.1*global.fpsmode;
	if(_s != sign(s_sp)) s_sp = 0;
}

var _xmove = lengthdir_x(f_sp,((360 - cam_yaw) + 360) mod 360);
var _ymove = lengthdir_y(f_sp,((360 - cam_yaw) + 360) mod 360);

if(place_meeting(x + _xmove,y,objSolid)) {
	while(!place_meeting(x + sign(_xmove) / 20,y,objSolid)) {
		x += sign(_xmove) / 20;
	}
	_xmove = 0;
}

if(place_meeting(x,y + _ymove,objSolid)) {
	while(!place_meeting(x,y + sign(_ymove) / 20,objSolid)) {
		y += sign(_ymove) / 20;
	}
	_ymove = 0;
}

x += _xmove;
y += _ymove;

_xmove = lengthdir_x(s_sp,((360 - cam_yaw + 90) + 360) mod 360);
_ymove = lengthdir_y(s_sp,((360 - cam_yaw + 90) + 360) mod 360);

if(place_meeting(x + _xmove,y,objSolid)) {
	while(!place_meeting(x + sign(_xmove) / 20,y,objSolid)) {
		x += sign(_xmove) / 20;
	}
	_xmove = 0;
}

if(place_meeting(x,y + _ymove,objSolid)) {
	while(!place_meeting(x,y + sign(_ymove) / 20,objSolid)) {
		y += sign(_ymove) / 20;
	}
	_ymove = 0;
}

x += _xmove;
y += _ymove;
#endregion
#region camera
cam_yaw = (cam_yaw + 360) mod 360;

//Where the camera is pointing to
var xfrom = x;
var yfrom = y;

var _z = -22 + (sin(sin_tic *0.1) * 0.02);

var dtrcam_yaw = degtorad(cam_yaw)

var xto = xfrom + cos(dtrcam_yaw);
var yto = yfrom + sin(dtrcam_yaw);
var zto = camz + (sin(sin_tic / 10) * 0.01);

sway_amount = clamp(abs(s_sp) + abs(f_sp),-mspeed,mspeed);

sin_tic += sway_amount;

sway_x += sway_amount / 1.5;
sway_y += sway_amount / 0.75;

//Update the camera
var mat = matrix_build_lookat(xfrom, yfrom, _z, xto, yto, _z + zto, 0, 0, 1);
camera_set_view_mat(view_camera[0], mat);
#endregion

//to help the 3D models render faster
update3Dindex++;

if(global.update3Dtime == update3Dindex)
{
	if(prevcamyaw != cam_yaw)
	{
		global.update3d = true;
		var cyphp = dtrcam_yaw+halfpi;
		global.sincyphp = sin(cyphp);
		global.coscyphp = cos(cyphp);
	}
	else
	{
		global.update3d = false;
	}
	prevcamyaw = cam_yaw;
	
	update3Dindex = 0;
}