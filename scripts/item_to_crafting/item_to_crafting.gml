function item_to_crafting(_slot,_mode = 0)
{
	if(_mode == 0)//click izquierdo
	{
		if selector[0] <= 99 exit;
		if crafting_grid[_slot][0] == selector[0]
		{
			crafting_grid[_slot][1] += selector[1];
			crafting_grid[_slot][2] = selector[2];
			selector[2] = 0;
			selector[1] = 0;
		}
		else
		{
			crafting_grid[_slot][0] = selector[0];
			crafting_grid[_slot][1] = selector[1];
			crafting_grid[_slot][2] = selector[2];
	
			selector[0] = 0;
			selector[1] = 0;
			selector[2] = 0;
		}
	}
	if(_mode == 1)//click derecho
	{
		if selector[0] <= 99 exit;
		if crafting_grid[_slot][0] == selector[0]
		{
			crafting_grid[_slot][1] ++;
			crafting_grid[_slot][2] = selector[2];
			selector[1]--;
		}
		else
		{
			crafting_grid[_slot][0] = selector[0];
			crafting_grid[_slot][1] = selector[1];
			crafting_grid[_slot][2] = selector[2];
	
			selector[0] = 0;
			selector[1] = 0;
			selector[2] = 0;
		}
	}
	if(_mode == 2)//botón
	{
		if inventory[selecteditem][0] <= 99 exit;
		if crafting_grid[_slot][0] != inventory[selecteditem][0] && crafting_grid[_slot][0] != 0 || inventory[selecteditem][0] == 0  exit;
		crafting_grid[_slot][0] = inventory[selecteditem][0];
		crafting_grid[_slot][1]++;
		crafting_grid[_slot][2] = inventory[selecteditem][2];
		
		inventory[selecteditem][1]--;
		
		if inventory[selecteditem][1] < 1
		{
			inventory[selecteditem] = [0,0,0]
		}
	}
	
	craftable = get_craftable_items(crafting_grid);
}