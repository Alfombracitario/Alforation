function inventory_sort()
{
	for (var i = 0; i < invsize; i++) {
	    var slot = inventory[i]
		inventory[i] = [0,0,0]
		add_item(slot[0],slot[1],slot[2]);
	}
}