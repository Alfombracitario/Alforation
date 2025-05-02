function check_new_player(player = 1){

	if(gamepad_button_check_pressed(player,gp_start))//si el jugador apreta start
	{
		switch(player)
		{
			case 1://jugador 2
				objPlayer.gw*=0.5;
				global.players = 2;
				objPlayer.wprev--;
				instance_create_depth(0,0,0,objPlayer2);
			break;
			
			case 2:
				objPlayer.gh*=0.5;
				global.players = 3;
				objPlayer.wprev--;
			break;
			
			case 3:
				global.players = 4;
				objPlayer.wprev--;
			break;
		}
	}
}