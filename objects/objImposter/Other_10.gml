//cuando se destruye
var _th = th;
var _tile = tile_index;
with(objPlayer)
{
	var _item = drops[_tile][0];
	var _count = drops[_tile][1];
	if _tile == 0 _count = (_th*-1)>>5;

	if(_count < 1)
	{
		var probabilidad = _count;
		_count = (random(1) < probabilidad) ? 1 : 0;
	}
	add_item(_item,_count);
    add_xp(drops[_tile][2]);
}