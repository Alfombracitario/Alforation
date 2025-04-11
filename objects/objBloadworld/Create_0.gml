image_xscale = (room_width*0.05)-1.6;
image_yscale = 3;
selectedworld = 0;
locked = 0;
Bid = 0;
var folder_names = [];
var folder_sizes = [];

// Fase 1: obtener todos los nombres de las carpetas
var dir = file_find_first(WORLDIR + "*", fa_directory);
while (dir != "") {
    if (dir != "." && dir != "..") {
        array_push(folder_names, dir);
    }
    dir = file_find_next();
}
file_find_close(); // Cerramos búsqueda de carpetas

// Fase 2: calcular tamaños
for (var i = 0; i < array_length(folder_names); i++) {
    var folder_path = WORLDIR + folder_names[i] + "/";
    var total_size = 0;
    var file = file_find_first(folder_path + "*", fa_archive);
    while (file != "") {
        total_size += get_file_size(folder_path + file);
        file = file_find_next();
    }
    file_find_close();
    array_push(folder_sizes, total_size);
}

// Mostrar en consola
show_debug_message(folder_names);

for (var i = 0; i < array_length(folder_names); i++) {
    var ins = instance_create_layer(0, i * 24, "title", objBworld);
    ins._text = string(folder_names[i]) + " | " + string(folder_sizes[i]/1024) + "Kb";
    ins.Bid = i;
	ins.world = string(folder_names[i]);
}
