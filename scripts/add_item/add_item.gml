function add_item(_id, _cantidad = 1, _efectos = 1) {//este código se ejecuta en objPlayer
	if (_cantidad > 0)
	{
		added_item = _id
		added_count = _cantidad
		added_tic = 100;
	}
	if _cantidad == 0 return false;
    if _id == 0 return false;
	
	
    var invs = invsize;
    
    if(_id >= 100)//si no es un arma entonces se puede stackear
    {
        // Primero buscar si el item ya está en el inventario
        for (var i = 0; i < invs; i++) {
            if (inventory[i][0] == _id) {
                inventory[i][1] += _cantidad;
				if inventory[i][1] <= 0 inventory[i] = [0,0,0];//Si hay 0 o menos se elimina el item
                inventory[i][2] = _efectos;
                return true;
            }
        }
    }
    
    // Si no se encontró, buscar un espacio vacío
    for (var i = 0; i < invs; i++) {
        if (inventory[i][0] == 0) {
            inventory[i][0] = _id;
            inventory[i][1] = _cantidad;
			if inventory[i][1] <= 0 inventory[i] = [0,0,0];//Si hay 0 o menos se elimina el item
            inventory[i][2] = _efectos;
            return true;
        }
    }
	
	
	
	
    // No hay espacio
    return false;
}
