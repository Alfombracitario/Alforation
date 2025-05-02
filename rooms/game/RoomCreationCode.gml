global.floor = 0;
ini_open(WORLDIR+global.worldname+"/inv.ini");

var	_x = ini_read_real("p","x",0);
var	_y = ini_read_real("p","y",0);
	
instance_create_depth(_x,_y,1,objPlayer);
objPlayer.z = ini_read_real("p","z",0);

ini_close();
instance_create_depth(0,0,1,objVisioncol);
instance_create_depth(0,0,0,objImposter);
instance_create_depth(0,0,0,objSun);
instance_create_depth(0,0,0,objHit);