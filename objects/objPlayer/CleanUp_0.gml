instance_activate_all();
instance_destroy(objVisioncol);
//hay que asegurse de que el código se ejecute en el orden correcto
ini_open(WORLDIR+global.worldname+"/data.ini");
with(objChunk)
{
	event_user(1)
}
ini_close();
ini_open(WORLDIR+global.worldname+"/inv.ini");
ini_write_real("p","x",x);
ini_write_real("p","y",y);
ini_write_real("p","health",_health);
ini_write_real("p","hunger",_hunger);
ini_write_real("p","temp",_temperature);
ini_write_real("p","camyaw",cam_yaw);
ini_write_real("p","time",_time);
ini_write_real("p","xp",experience);
ini_write_real("p","lv",level);

var invdata = 3;
for (var i = 0; i < invsize; i++) {
    for (var j = 0; j < invdata; j++) {
        ini_write_string(j,i,inventory[i][j]);
    }
}
ini_close();