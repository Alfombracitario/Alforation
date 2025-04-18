/// Evento Step
if(screen = -1)
{
	var wh = window_get_height();
	if (wh > 1) {
		var ww = window_get_width();
		var _factor = ww/wh;
		room_height = 180;
		room_width = 180*_factor;
		surface_resize(application_surface,room_width,room_height);
		display_set_gui_size(room_width,room_height);
	}
	if(intromode == 0)
	{
		if _alpha < 1 _alpha+=0.01;
		intro[0][2] *= 0.95;
		intro[1][1] *= 0.95;
		intro[2][1] *= 0.95;
	}
	else
	{
		intro_tic++;
		if intro_tic > 16 screen = 0;
	}
	if keyboard_check(vk_anykey) || mouse_check_button(mb_left) || gamepad_button_check(0,gp_face2) intromode = 1;
}
else
{
	if intro_tic > 0 intro_tic--;
	var mx = mouse_x;
	var my = mouse_y;
	if(gamepad_is_connected(0))
	{
		if gamepad_button_check_pressed(0,gp_padu) selected--;
		if gamepad_button_check_pressed(0,gp_padd) selected++;
		if gamepad_button_check_pressed(0,gp_face1) event_user(selected);
		if gamepad_button_check_pressed(0,gp_face2) 
		|| gamepad_button_check_pressed(0,gp_start) event_user(0);
		if gamepad_axis_value(0,gp_axislv) > 0.5 selected++;
		if gamepad_axis_value(0,gp_axislv) < -0.5 selected--;
		
		if selected < 0 selected = bc;
		selected = selected mod bc;
		selected_button = selected;
	}
	else
	{
		if mouse_check_button_pressed(mb_left) audio_play_sound(sndAccept,0,0,global.sndvol);
		selected_button = -1; // Variable que almacenará el ID del botón presionado
		selected = -1;
		for (var i = 0; i < bc; i++) {

		    var bwidth = button[i][1] * 10; // Escala horizontal convertida a píxeles
		    var bheight = button[i][2] * 10; // Escala vertical convertida a píxeles

		    var bxpos = room_width * button[i][3]; //x
		    var bypos = button[i][4]; //y
    
		    // Verifica si el mouse está sobre el botón
		    if (mx > bxpos - (bwidth >>1) && mx < bxpos + (bwidth >>1) && 
		        my > bypos - (bheight >>1) && my < bypos + (bheight >>1)) {
		        selected = i;
		        if (mouse_check_button_pressed(mb_left)) {
		            selected_button = i; // Almacenar el ID del botón presionado
					event_user(button[i][0]);
		        }
		    }
		}
	}


	if selected != presel audio_play_sound(sndSelect,0,0,global.sndvol);
	presel = selected;
var ww = window_get_width();
var wh = window_get_height();

if (wh > 1) {
room_height = wh/global.uisize
room_width = ww/global.uisize
surface_resize(application_surface,room_width,room_height);
display_set_gui_size(room_width,room_height);
}
}