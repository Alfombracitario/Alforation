function set_craft_target(_i){
	//se eligió un crafteo, se pone en el cuadrado de creación
	craftresult[0] = craftable[_i][0];
	craftresult[1] = craftable[_i][1];
	craftresult[2] = craftable[_i][2];
	craftresult[3] = craftable[_i][3];
	craftresult[4]++;//cantidad de veces que se va a craftear
					
	//también se quitan los items del inventario y se ponen en el crafting grid
	var _recipe_index = craftresult[3];
	var _count = craftresult[4];
	var _recipe = global.crafting_recipes[_recipe_index];

	var _rial = array_length(_recipe.ingredients);//se ponen en el crafting grid los items a craftear
	for (var i = 0; i < _rial; i++) {//recorre los ingredientes 
		crafting_grid[i][0] = _recipe.ingredients[i][0];//id
		crafting_grid[i][1] = _recipe.ingredients[i][1]*_count;//cantidad
		add_item(crafting_grid[i][0],-_recipe.ingredients[i][1]);//restar del inventario
	}
	craftable = get_craftable_items(inventory);
}