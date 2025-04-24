/*var tile_size = 2; // escala del minimapa
for (var i = 0; i < _xlimit; i++) {
    for (var j = 0; j < _ylimit; j++) {
        var col = tiles[i][j] == 0 ? c_white : c_black;
        draw_set_color(col);
        draw_rectangle(i * tile_size, j * tile_size, (i+1) * tile_size, (j+1) * tile_size, false);
    }
}