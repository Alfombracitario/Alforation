global.chunks = ds_map_create();
file_delete(WORLDIR+global.worldname+"/data.ini");
file_delete(WORLDIR+global.worldname+"/inv.ini");
ini_open(WORLDIR+global.worldname+"/data.ini");
ini_write_real("world","seed",global.seed);
room_goto(game);