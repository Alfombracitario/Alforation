/// Evento Step
var mx = mouse_x;
var my = mouse_y;
if(gamepad_is_connected(0))
{
	if gamepad_button_check_pressed(0,gp_padu) selected--;
	if gamepad_button_check_pressed(0,gp_padd) selected++;
	if gamepad_button_check_pressed(0,gp_face1) event_user(selected);
	if gamepad_button_check_pressed(0,gp_face2) 
	|| gamepad_button_check_pressed(0,gp_start) event_user(0);
	
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

if (window_get_height() > 1) {
room_height = wh/global.uisize
room_width = ww/global.uisize
surface_resize(application_surface,room_width,room_height);
display_set_gui_size(room_width,room_height);
}