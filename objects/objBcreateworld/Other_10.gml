if(mode == 0)
{
objBloadworld.y = 9999;
objBloadworld.x = 9999;
instance_destroy(objBdeleteworld);
instance_destroy(objBworld);
x = 0;
mode = 1;
bc = 2;
randomize();
global.seed = irandom(999999);
var wns;
wns = //nombres de los mundos
["Epic world","New world","Wow, alforation sucks","Isn't this minecraft","Terraria 3D",
"Subscribe to my channel!!1","Woah, a default name","Default name","Insert name here", "Text",
"Random name","Creative name","Cool name","Epic name", "Alfombracitario is cool!","Idk","Just a name",
"Normal name","Short name","Super ultra epic long name!!!!","ASFDSFS","a","Enter the world name"]

global.worldname = wns[irandom(array_length(wns)-1)];

var _string = "World name: "+string(global.worldname);
//			event,xscale,yscale,x,y,string
button[0] = [2,string_length(_string),2,0,24,_string];
_string = "Seed: "+string(global.seed)
button[1] = [3,string_length(_string),2,0,48,_string];
}