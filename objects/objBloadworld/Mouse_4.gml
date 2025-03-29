global.chunks = ds_map_create();
ini_open(working_directory+global.worldname+"data.ini");
global.seed = ini_read_real("world","seed",irandom(999999));
instance_destroy(objBloadworld);
instance_destroy(objBdeleteworld);
instance_destroy(objTitlescreen);
instance_destroy(objBcreateworld);
room_goto(game);