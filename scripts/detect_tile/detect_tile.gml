function detect_tile(_x, _y)
{
    for (var i = 0; i < array_length(objects); i++) {
        if (objects[i][1] == _x && objects[i][2] == _y) {
            return i;
			show_debug_message("Objecto encontrado: "+string(i));
        }
    }
    return -1;
}
