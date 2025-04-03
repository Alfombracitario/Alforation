/// Evento Step
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);
selected_button = -1; // Variable que almacenará el ID del botón presionado

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