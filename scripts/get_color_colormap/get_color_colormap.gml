function get_color_colormap(_x, _y) {
    
    var color11 = [75, 229, 52];
    var color01 = [2, 37, 121];
    var color10 = [200, 186, 65];
    var color00 = [128, 199, 173];

    var fx = _x / 255;
    var fy = _y / 255;

    // Mezcla en el eje X
    var top_r = lerp(color00[0], color10[0], fx);
    var top_g = lerp(color00[1], color10[1], fx);
    var top_b = lerp(color00[2], color10[2], fx);

    var bottom_r = lerp(color01[0], color11[0], fx);
    var bottom_g = lerp(color01[1], color11[1], fx);
    var bottom_b = lerp(color01[2], color11[2], fx);

    // Mezcla final en el eje Y
    var final_r = lerp(top_r, bottom_r, fy);
    var final_g = lerp(top_g, bottom_g, fy);
    var final_b = lerp(top_b, bottom_b, fy);

    // Devolver el color mezclado en formato RGB
    return make_color_rgb(final_r, final_g, final_b);
}