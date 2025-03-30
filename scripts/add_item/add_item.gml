/// add_item(id, cantidad, durabilidad)
function add_item(_id, _cantidad = 1, _durabilidad = 1) {
    var max_stack = 999; // Ajusta según el límite del ítem
    var i, espacio_vacio = 0;
	
    if _cantidad == 0 return -1;
	
    // 1. Intentar apilar ítems existentes
    for (i = 0; i < array_length(inventory); i++) {
        if (inventory[i][0] == _id) { // Si el ítem ya está en el inventario
            var espacio_disponible = max_stack - inventory[i][1];
            if (espacio_disponible > 0) {
                var agregar = min(_cantidad, espacio_disponible);
                inventory[i][1] += agregar;
                _cantidad -= agregar;
                if (_cantidad <= 0) return true; // Se agregó todo el ítem
            }
        } 
        else if (espacio_vacio == -1 && inventory[i][0] == -1) {
            espacio_vacio = i; // Guardar el primer espacio vacío encontrado
        }
    }
    
    // 2. Si quedan ítems por agregar, llenar espacios vacíos
    while (_cantidad > 0) {
        if (espacio_vacio == -1) {
            // No hay más espacio en el inventario
            return false;
        }
        
        var agregar = min(_cantidad, max_stack);
        inventory[espacio_vacio] = [_id, agregar, _durabilidad, 0]; // Insertar en espacio vacío
        _cantidad -= agregar;
        
        // Buscar otro espacio vacío para la siguiente pila
        espacio_vacio = -1;
        for (i = 0; i < array_length(inventory); i++) {
            if (inventory[i][0] == -1) {
                espacio_vacio = i;
                break;
            }
        }
    }
    
    return true; // Se agregaron todos los ítems
}
