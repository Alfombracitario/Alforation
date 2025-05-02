function get_craftable_items(input_array) {
    var result = [];

    var table_available = objPlayer.table;

    // Paso 1: contar los materiales disponibles (sumar repeticiones)
    var input_counts = ds_map_create();
    var total_materiales = 0; // Para evitar recetas con solo 1 ítem

    var input_len = array_length(input_array);
    for (var i = 0; i < input_len; i++) {
        var _id = input_array[i][0];
        var _qty = input_array[i][1];

        if (_id != -1 && _qty > 0) {
            total_materiales++;
            if (!ds_map_exists(input_counts, _id)) {
                input_counts[? _id] = _qty;
            } else {
                input_counts[? _id] += _qty;
            }
        }
    }

    // Si no hay suficientes materiales, no seguimos
    if (total_materiales == 0) {
        ds_map_destroy(input_counts);
        return result;
    }

    // Paso 2: revisar cada receta
    for (var r = 0; r < array_length(global.crafting_recipes); r++) {
        var recipe = global.crafting_recipes[r];

        // Verificar si la mesa es válida
        if (recipe.table != 0 && recipe.table != table_available) {
            continue;
        }

        var ingredientes = recipe.ingredients;
        var puede_craftear = true;

        // Requiere al menos tantos materiales como ingredientes
        if (array_length(ingredientes) > total_materiales) {
            continue;
        }

        var posible = -1;

        for (var i = 0; i < array_length(ingredientes); i++) {
            var ing_id = ingredientes[i][0];
            var ing_qty = ingredientes[i][1];

            if (!ds_map_exists(input_counts, ing_id)) {
                puede_craftear = false;
                break;
            }

            var tengo = input_counts[? ing_id];

            var max_crafts = floor(tengo / ing_qty);

            if (posible == -1 || max_crafts < posible) {
                posible = max_crafts;
            }

            if (max_crafts <= 0) {
                puede_craftear = false;
                break;
            }
        }

        if (puede_craftear && posible > 0) {
            array_push(result, [recipe.output_id, posible, recipe.output_qty, r]);
        }
    }

    ds_map_destroy(input_counts);
    return result;
}
