/// Evento Step
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);
if(gamepad_is_connected(0))
{
	if gamepad_button_check_pressed(0,gp_padu) hsel--;
	if gamepad_button_check_pressed(0,gp_padd) hsel++;
	if gamepad_button_check_pressed(0,gp_face1) event_user(hsel);
	if gamepad_button_check_pressed(0,gp_face2) 
	|| gamepad_button_check_pressed(0,gp_start) event_user(0);
	
	if hsel < 0 hsel = bc;
	hsel = hsel mod bc;
	selected_button = hsel;
}
else
{
	selected_button = -1; // Variable que almacenará el ID del botón presionado
	hsel = -1;
	for (var i = 0; i < bc; i++) {
	    var bx = button[i][0]; // ID del botón
	    var bwidth = button[i][1] * 10; // Escala horizontal convertida a píxeles
	    var bheight = button[i][2] * 10; // Escala vertical convertida a píxeles

	    var bxpos = button[i][3]; //x
	    var bypos = button[i][4]; //y
    
	    // Verifica si el mouse está sobre el botón
	    if (mx > bxpos - (bwidth >>1) && mx < bxpos + (bwidth >>1) && 
	        my > bypos - (bheight >>1) && my < bypos + (bheight >>1)) {
	        hsel = bx;
	        if (mouse_check_button_pressed(mb_left)) {
	            selected_button = bx; // Almacenar el ID del botón presionado
				event_user(bx);
	        }
	    }
	}
}


if hsel != presel audio_play_sound(sndSelect,0,0,global.sndvol);
presel = hsel;