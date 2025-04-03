function add_item(_id, _cantidad = 1, _durabilidad = 1) {
    if _id == 0 return false;

    var invs = invsize;
    
    // Primero buscar si el item ya está en el inventario
    for (var i = 0; i < invs; i++) {
        if (inventory[i][0] == _id) {
            inventory[i][1] += _cantidad;
            inventory[i][2] = _durabilidad;
            return true;
        }
    }
    
    // Si no se encontró, buscar un espacio vacío
    for (var i = 0; i < invs; i++) {
        if (inventory[i][0] == 0) {
            inventory[i][0] = _id;
            inventory[i][1] = _cantidad;
            inventory[i][2] = _durabilidad;
            return true;
        }
    }
    
    // No hay espacio
    return false;
}
