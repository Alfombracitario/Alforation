function get_color_gradient(_x,color0,color1,limit) {

    var fx = _x / limit;

    var final_r = lerp(color0[0], color1[0], fx);
    var final_g = lerp(color0[1], color1[1], fx);
    var final_b = lerp(color0[2], color1[2], fx);

    return make_color_rgb(final_r, final_g, final_b);
}