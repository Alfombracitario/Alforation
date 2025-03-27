function get_near_chunk_data(_cx, _cy)
{
    var cs = global.chunk_size;
    
    // Crea las posiciones relativas de los chunks vecinos
    var offsets = [
        [-cs,  0], [ cs,  0], // izquierda y derecha
        [  0, -cs], [  0,  cs], // arriba y abajo
        [-cs, -cs], [ cs, -cs], // diagonales
        [-cs,  cs], [ cs,  cs]
    ];
    
    // Desordena el array para que el orden sea aleatorio
	randomize()
    array_shuffle(offsets);

    var inst;
    
    // Busca en los offsets ya mezclados
    for (var i = 0; i < array_length(offsets); i++)
    {
        var pos = offsets[i];
        var check_x = _cx + pos[0];
        var check_y = _cy + pos[1];

        inst = instance_position(check_x, check_y, objChunk);
        if (inst != noone)
        {
            return [inst.temperature, inst.humidity];
        }
    }

    // Si no encuentra ninguno, devuelve un valor aleatorio
    return [irandom(255), irandom(255)];
}
