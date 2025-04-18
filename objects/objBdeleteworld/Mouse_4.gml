var folder = WORLDIR+global.worldname+"/";
file_delete(folder+"data.ini");
file_delete(folder+"inv.ini");

with(objBworld)
{
	if(world = global.worldname)
	{
		instance_destroy();
	}
	
}