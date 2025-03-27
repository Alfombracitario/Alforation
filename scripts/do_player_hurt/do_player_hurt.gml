function do_player_hurt(_damage) { 
	with(objPlayer) {
		_health -= _damage;
		
		hurt_tic = max(0.15,_damage / 20);
	}
}