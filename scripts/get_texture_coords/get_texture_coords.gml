function get_texture_coords(_x,_y,_sx = 32,_sy = 32,_td = 16) {
    var _inc = _sx / _td;
	
	var inv_sx = _inc/_sx
	var inv_sy = _inc/_sy
	return {
        x1 :  _x      * inv_sx,
        y1 :  _y      * inv_sy,
        x2 : (_x + 1) * inv_sx,
        y2 : (_y + 1) * inv_sy,
    };
}