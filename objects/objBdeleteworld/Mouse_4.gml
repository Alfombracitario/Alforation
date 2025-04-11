var folder = WORLDIR+global.worldname+"/";
var archivo = file_find_first(folder+"*",fa_archive);

while(archivo != "")
{
	file_delete(folder+archivo);
	archivo = file_find_next();
}

with(objBworld)
{
	if(world = global.worldname)
	{
		instance_destroy();
	}
	
}