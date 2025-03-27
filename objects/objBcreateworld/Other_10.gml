global.seed = irandom(999999);
if(os_type == os_windows)
{
	global.worldname = get_string("Enter the world name",global.worldname);
	global.seed = get_integer("Enter the world seed",global.seed);
}
global.chunks = ds_map_create();
file_delete(working_directory+global.worldname+"data.ini");
ini_open(working_directory+global.worldname+"data.ini");
randomize();
ini_write_real("world","seed",global.seed);
room_goto(game);