function place_random_spot(_is_object, _index) {
    var _x, _y;
    repeat (1000) {
        _x = irandom(_xlimit - 1);
        _y = irandom(_ylimit - 1);

        if (tiles[_x][_y] == 0) {
            if (_is_object) {
                instance_create_depth(_x << 4, _y << 4, 0, _index);
            } else {
                tiles[_x][_y] = _index;
            }
            return true;
        }
    }
    return false;
}
