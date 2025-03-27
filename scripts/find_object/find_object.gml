function find_object(_x, _y) {
    var len = array_length(objects);
    for (var i = 0; i < len; i++) {
        if (objects[i][1] == _x && objects[i][2] == _y && objects[i][3] > 0) {
            return i;
        }
    }
    return -1;
}
