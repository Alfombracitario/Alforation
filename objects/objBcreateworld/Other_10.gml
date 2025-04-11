randomize();
global.seed = irandom(999999);
var wns;
wns = //nombres de los mundos
["Epic world","New world","Wow, alforation sucks","Isn't this minecraft?","Terraria 3D?",
"Subscribe to my channel!!1","Woah, a default name","Default name","Insert name here", "Text",
"Random name","Creative name","Cool name","Epic name", "Alfombracitario is cool!","Idk","Just a name",
"Normal name","Short name","Super ultra epic long name!!!!","ASFDSFS","a","Enter the world name"]

global.worldname = wns[irandom(array_length(wns))];
if(os_type == os_windows)
{
	global.worldname = get_string("Enter the world name",global.worldname);
	global.seed = get_integer("Enter the world seed",global.seed);
}
global.chunks = ds_map_create();
file_delete(WORLDIR+global.worldname+"/data.ini");
ini_open(WORLDIR+global.worldname+"/data.ini");
ini_write_real("world","seed",global.seed);
instance_destroy(objBloadworld);
instance_destroy(objBdeleteworld);
instance_destroy(objTitlescreen);
instance_destroy(objBcreateworld);
room_goto(game);