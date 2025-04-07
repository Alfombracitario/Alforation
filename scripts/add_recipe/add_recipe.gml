function add_recipe(_output_id, _output_qty = 1,_table = C_ANY, _ingredients_array) {
    var recipe = {
        output_id: _output_id,
        output_qty: _output_qty,
        ingredients: _ingredients_array,
		table : _table
    };
    array_push(global.crafting_recipes, recipe);
}
