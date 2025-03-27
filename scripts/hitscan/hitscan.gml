function hitscan(_x,_y,_dir) {
	instance_create_depth(_x,_y,-8,objHitscan,{direction : _dir});
}