var folder = WORLDIR+global.worldname+"/";
file_delete(folder+"data.ini");
file_delete(folder+"inv.ini");
directory_destroy(folder);
with(objBworld)
{
	if(world = global.worldname)
	{
		instance_destroy();
	}
	
}