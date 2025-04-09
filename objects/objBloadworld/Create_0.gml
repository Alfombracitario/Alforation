image_xscale = (room_width*0.05)-1.6;
image_yscale = 3;
selectedworld = 0;
locked = 0;
Bid = 0;
var base_path = working_directory + "data/";
var dir = file_find_first(base_path + "*", fa_directory);
var folder_names = [];
var folder_sizes = [];

while (dir != "") {
    if (dir != "." && dir != "..") {
        var folder_path = base_path + dir + "/";
        array_push(folder_names, dir);

        var total_size = 0;
        var file = file_find_first(folder_path + "*", fa_archive);
        while (file != "") {
            total_size += get_file_size(folder_path + file);
            file = file_find_next(); // ¡Moverse al siguiente archivo!
        }
        file_find_close(); // Cerrar correctamente la búsqueda de archivos

        array_push(folder_sizes, total_size);
    }
    dir = file_find_next();
}
file_find_close(); // Cerrar la búsqueda de directorios también

// Mostrar en consola
show_debug_message(folder_names);

for (var i = 0; i < array_length(folder_names); i++) {
    var ins = instance_create_layer(i * 16, 0, "title", objBworld);
    ins._text = string(folder_names[i]) + " | " + string(folder_sizes[i]) + "MB"; // Estaba mostrando mal folder_sizes
    ins.Bid = i;
}
