function buffer_key_size(buffer, pos_start) {
    // Paso 1: Mover el puntero al inicio después de la clave
    buffer_seek(buffer, buffer_seek_start, pos_start);
    
    var buffer_size = buffer_get_size(buffer);
    
    // Paso 2: Buscar el siguiente '[' que marca el inicio del valor
    var c = "";
    while (buffer_tell(buffer) < buffer_size) {
        c = buffer_read(buffer, buffer_u8);
        
        if (c == ord("[")) {
            break; // Inicio del valor encontrado
        }
    }
    
    if (c != ord("[")) {
        return -1; // No encontró el inicio del valor
    }
    
    var data_start = buffer_tell(buffer); // Posición después de '['
    
    // Paso 3: Buscar el siguiente ']' que marca el final del valor
    var data_end = data_start;
    
    while (data_end < buffer_size) {
        buffer_seek(buffer, buffer_seek_start, data_end);
        c = buffer_read(buffer, buffer_u8);
        
        if (c == ord("]")) {
            break; // Fin del valor encontrado
        }
        
        data_end++;
    }
    
    if (c != ord("]")) {
        return -1; // No encontró el cierre del valor
    }
    
    var data_size = data_end - data_start; // Longitud del valor dentro de los corchetes
    
    return data_size;
}
