var invdata = 3;
for (var i = 0; i < invsize; i++) {
    for (var j = 0; j < invdata; j++) {
        inventory[i][j] = 0; //item vacío
		
		//lol
		inventory[i][0] = irandom(143);
		inventory[i][1] = 1;
		inventory[i][2] = 0;
    }
}