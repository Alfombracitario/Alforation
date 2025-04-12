with(objPlayer)
{
	var _item = drops[tile_index][0];
	var _count = drops[tile_index][1];

	if(_count < 1)
	{
		var probabilidad = _count;
		_count = (random(1) < probabilidad) ? 1 : 0;
	}
	add_item(_item,_count);
}