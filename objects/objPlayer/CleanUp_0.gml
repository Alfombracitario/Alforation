instance_activate_all();
//hay que asegurse de que el código se ejecute en el orden correcto
ini_open(working_directory+global.worldname+"data.ini");
with(objChunk)
{
	event_user(1)
}
ini_write_real("p","x",x);
ini_write_real("p","y",y);
ini_write_real("p","health",_health);
ini_write_real("p","hunger",_hunger);
ini_write_real("p","temp",_temperature);
ini_write_real("p","camyaw",cam_yaw);
ini_write_real("p","time",time);
var invdata = 3;
for (var i = 0; i < invsize; i++) {
    for (var j = 0; j < invdata; j++) {
        ini_write_string("i"+string(j),i,inventory[i][j]);
    }
}
ini_close();
