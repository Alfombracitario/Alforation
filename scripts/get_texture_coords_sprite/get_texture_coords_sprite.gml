function get_texture_coords_sprite(_sprite,_index) {
	var _texture = sprite_get_texture(_sprite,_index);
	var uvs = texture_get_uvs(_texture);
	return {
        x1 : uvs[0],
        y1 : uvs[1],
        x2 : uvs[2],
        y2 : uvs[3],
    };
}