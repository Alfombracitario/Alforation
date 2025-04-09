function do_craft()
{
	var _id = craftresult[0];
	if _id == 0 exit;
	var _count = craftresult[2];
	var recipe_index = craftresult[3];
	
	var recipe = global.crafting_recipes[recipe_index];
	
	var _rial = array_length(recipe.ingredients);
	for (var i = 0; i < _rial; i++) {
		var ing_id = recipe.ingredients[i][0];
		var ing_qty = recipe.ingredients[i][1];
		//restar del crafting grid
		for(var j = 0; j < 3; j++)//revisa en cada crafting grid
		{
			if(ing_id == crafting_grid[j][0])
			{
				crafting_grid[j][1] -= ing_qty;
				if(crafting_grid[j][1] < 1)//tenemos 0 o una deuda
				{
					crafting_grid[j] = [0,0,0];//limpiar la cuadrícula, si tenemos una deuda... eso no debería pasar
				}
			}
		}
	}
	add_item(_id,_count,0);//añadir el item
	//terminar
	craftresult = [0,0,0,0];//limpiar la cuadrícula
	craftable = get_craftable_items(crafting_grid);
}