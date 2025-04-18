function detect_tile(_x, _y)
{
    for (var i = 0; i < array_length(objects); i++) {
        if (objects[i][1] == _x && objects[i][2] == _y) {
            return i;
        }
    }
    return -1;
}
