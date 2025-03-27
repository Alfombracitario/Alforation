// Convierte coordenadas de chunk a una clave única
function chunk_key(cx, cy) {
    return string(cx) + "_" + string(cy);
}