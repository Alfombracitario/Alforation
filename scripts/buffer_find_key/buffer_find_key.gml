function buffer_find_key(buffer, key)
{	
    key = "[" + key + "]";
	
	buffer_seek(f,buffer_seek_start,0);
	
    var content = buffer_read(buffer, buffer_text);
    
    // Verificar si el contenido está vacío
    if (string_length(content) == 0) {
        return -1; // El archivo está vacío, no se puede encontrar la clave
    }
    
    var kpos = string_pos(key, content);
    if (kpos != -1) {
        return kpos + string_length(key);
    } else {
        return -1; // No se encontró la clave
    }
}
