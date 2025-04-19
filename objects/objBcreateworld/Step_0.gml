if(mode == 0)
{
    image_xscale = (room_width*0.05)-1.6;
    x = room_width-sprite_width-32;
}
    y = room_height-sprite_height
    if (mouse_x > x  && mouse_x < x + sprite_width &&
        mouse_y > y  && mouse_y < y + sprite_height ) {
        objTitlescreen.selected = Bid;
    	image_index = 1;
    	if mouse_check_button_pressed(mb_left) event_user(0+mode);
    }
    else
    {
    	image_index = 0;
    }
    if(gamepad_is_connected(0))
    {	
    	if objTitlescreen.selected == Bid image_index = 1; else image_index = 0;
    	if image_index == 1 && gamepad_button_check_pressed(0,gp_face1) event_user(0+mode);
    }
var mx = mouse_x;
var my = mouse_y;

if (mouse_check_button_pressed(mb_left)) {
    audio_play_sound(sndAccept, 0, 0, global.sndvol);
}

selected_button = -1; // Variable que almacenará el ID del botón presionado
selected = -1;

for (var i = 0; i < bc; i++) {
    var bwidth = button[i][1] * 10; // Escala horizontal convertida a píxeles
    var bheight = button[i][2] * 10; // Escala vertical convertida a píxeles

    var bxpos = room_width * button[i][3]; // x
    var bypos = button[i][4];             // y

    // Verifica si el mouse está sobre el botón (origen arriba a la izquierda)
    if (mx >= bxpos && mx < bxpos + bwidth &&
        my >= bypos && my < bypos + bheight) {
        
        selected = i;

        if (mouse_check_button_pressed(mb_left)) {
            selected_button = i; // Almacenar el ID del botón presionado
            event_user(button[i][0]);
        }
    }
}

if(state)
{
    button[_state-2][5] = keyboard_string;
    button[_state-2][1] = 1+string_length(keyboard_string)*0.5;
}