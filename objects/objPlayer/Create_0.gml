draw_set_halign(fa_left);
w_width = window_get_width();
w_height = window_get_height();

view_enabled = true;
view_visible[0] = true;
camera_set_view_size(view_camera[0],w_width,w_height);

var factor = round(w_height / 270);
if (global.uisize < factor)
{
	display_set_gui_size(w_width div global.uisize, w_height div global.uisize);
	uisize = global.uisize
}
else
{
	display_set_gui_size(w_width div factor, w_height div factor);
	uisize = factor;
}


surface_resize(application_surface,w_width>>global.screendiv,w_height>>global.screendiv);
/*
_surf = surface_create(w_height << global.screendiv,w_height << global.screendiv);
view_set_surface_id(0,_surf);
*/
gpu_set_alphatestenable(true);
gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
//shader_set(sh_timecolor);

if(os_type == os_windows || os_type == os_win8native || os_type == os_macosx)
{
	window_mouse_set_locked(true);
}

view_camera[0] = camera_create();
camera_set_proj_mat(view_camera[0],matrix_build_projection_perspective_fov(60,w_width/w_height,1,16000));

gamepad_set_axis_deadzone(0,0.01);

fly = false;
invmousex = w_width>>1;
invmousey = w_height>>1;
previnvmousex = 0;
previnvmousey = 0;
gw = display_get_gui_width();
gh = display_get_gui_height();
invmove = false;
craftmove = false;
craftresult = [0,0,0,0];
prevmousex[0] = 0;
prevmousey[0] = 0;
prevmousex_r[0] = 0;
prevmousey_r[0] = 0;
mousex[0] = 0;
mousey[0] = 0;
mousex_r[0] = 0;
mousey_r[0] = 0;
offset = 0;
display_info = false;
fov_mod = 0;
turn_speed = 0;
selecteditem = 0;
invopen = false;
added_item = 0;
added_tic = 0;
added_count = 0;
camz = 0;
depth = 1;
f_sp = 0;
s_sp = 0;
mspeed = 1.75*global.fpsmode;
sin_tic = 0;
sway_x = 0;
sway_y = 0;
sway_amount = 0;
hitanim_tic = 60;
cooldown = 0;
cooldownmax = 0;
weapon_swaying = true;
weapon_y = 0;
wprev = w_width;
hprev = w_height;
hurt_tic = 0;
notday = false;
timecolor = c_white;
fog_color = $FF9865;
fog_depth = (global.render_distance+0.5)*global.chunk_size;
fog_density = 256;

//variables de mierda de optimización
halfpi = pi*0.5;
global.sincyphp = sin(halfpi);
global.coscyphp = cos(halfpi);
update3Dindex = 0;


global.settings = {
	sensibility : 4
};

prevcamyaw = 0;

global.update3d = false;

#region CHUNKS
chunk_size = 256;

pcx = floor(x/chunk_size);
pcy = floor(y/chunk_size);

last_pcx = -99999999;
last_pcy = -99999999;
ExtTemperature = 0;
selector = [0,0,0,0];

#endregion

//music
alarm_set(11,1);
audio_stop_all();

#region load data

ini_open(working_directory+global.worldname+"data.ini");
if(room == game)
{
	x = ini_read_real("p","x",0);
	y = ini_read_real("p","y",0);
}
_health = ini_read_real("p","health",100);
_hunger = ini_read_real("p","hunger",100);
_temperature = ini_read_real("p","temp",128);
cam_yaw = ini_read_real("p","camyaw",0);
time = ini_read_real("p","time",0);
maxhealth = ini_read_real("p","maxhealth",100);
//configuraciones que se cargan en el jugador por algún motivo
ini_close();
ini_open(working_directory+"options.ini");
invx = ini_read_real("options","invx",64);
invy = ini_read_real("options","invy",64);
hotbarx = ini_read_real("options","hotbx",0);
hotbarsize = ini_read_real("options","hotbs",8);
invdpadx = ini_read_real("options","invdpadx",0.05);
invdpady = ini_read_real("options","invdpady",0.5);
buttonax = ini_read_real("options","buttonax",0.9);
buttonay = ini_read_real("options","buttonay",0.28);
buttonbx = ini_read_real("options","buttonbx",0.81);
buttonby = ini_read_real("options","buttonby",0.38);
buttonix = ini_read_real("options","buttonbx",0.76);
buttoniy = ini_read_real("options","buttonby",0.48);
craftx = ini_read_real("options","craftx",256);
crafty = ini_read_real("options","crafty",64);
ini_close();
ini_open(working_directory+global.worldname+"data.ini");
#endregion

//inventario
invsize = 40;
var invdata = 3;
for (var i = 0; i < invsize; i++) {
    for (var j = 0; j < invdata; j++) {
        inventory[i][j] = ini_read_real("i"+string(j),i,0);
    }
}
/*
	j[0] = id
	j[1] = cantidad/durabilidad
	j[2] = efectos
*/

//hotbar
hotbar = 0;
hotbarsel = 0;
for(var i = 0; i < hotbarsize; i++)
{
	hotbar[i] = i;
}


//más optimizaciones:
instance_create_layer(x,y,"instances",objVisioncol);

	//datos de los items

	//hand,spear,sword,pic,hoe,axe
	w_coold = [5,15,7,2,45];
	w_damincrmt = [10,5,2,1,5];
	w_damage = [ 1, 10, 5, 2,15,];
	w_dur = [32,64,210,270,300,400,460,700,850,1000];
	//obtener texcoords
	var tx = sprite_get_width(sprBtiles)>>4;
	var ty = sprite_get_height(sprBtiles)>>4;
	var td = 16;
	//     Tile name		Id
	#macro T_TREE			0
	#macro T_GRASS			1
	#macro T_STONE			2
	#macro T_FERN			3
	#macro T_MUSHROOM1		4
	#macro T_MUSHROOM2		5
	#macro T_WILD_WHEAT		6
	#macro T_DEAD_BUSH		7
	#macro T_CACTUS			8
	#macro T_MUSHROOM3		9
	#macro T_GRASS2			10
	#macro T_STONE_COAL		11
	#macro T_STONE_TIN		12
	#macro T_STONE_COPPER	13
	#macro T_STONE_IRON		14
	#macro T_STONE_TUNGSTEN 15
	#macro T_STONE_RUBY		16
	#macro T_STONE_DIAMOND	17
	#macro T_STONE_AMETHYST	18
	#macro T_STONE_JUNGLE	19
	#macro T_STONE_GOLD		20
	#macro T_WATERMELON		21
	
	tc[T_TREE] =			get_texture_coords(0,0,1,1,1);
	tc[T_GRASS] =			get_texture_coords(0,0,tx,ty,td);
	tc[T_STONE] =			get_texture_coords(0,2,tx,ty,td);
	tc[T_FERN] =			get_texture_coords(1,0,tx,ty,td);
	tc[T_MUSHROOM1] =		get_texture_coords(0,1,tx,ty,td);
	tc[T_MUSHROOM2] =		get_texture_coords(1,1,tx,ty,td);
	tc[T_WILD_WHEAT] =		get_texture_coords(3,4,tx,ty,td);
	tc[T_DEAD_BUSH] =		get_texture_coords(2,0,tx,ty,td);
	tc[T_CACTUS] =			get_texture_coords(3,0,tx,ty,td);
	tc[T_MUSHROOM3] =		get_texture_coords(2,1,tx,ty,td);
	tc[T_GRASS2] =			get_texture_coords(4,0,tx,ty,td);
	tc[T_STONE_COAL] =		get_texture_coords(1,2,tx,ty,td);
	tc[T_STONE_TIN] =		get_texture_coords(2,2,tx,ty,td);
	tc[T_STONE_COPPER] =	get_texture_coords(3,2,tx,ty,td);
	tc[T_STONE_IRON] =		get_texture_coords(4,2,tx,ty,td);
	tc[T_STONE_TUNGSTEN] =	get_texture_coords(5,2,tx,ty,td);
	tc[T_STONE_RUBY] =		get_texture_coords(6,2,tx,ty,td);
	tc[T_STONE_DIAMOND] =	get_texture_coords(7,2,tx,ty,td);
	tc[T_STONE_AMETHYST] =	get_texture_coords(0,3,tx,ty,td);
	tc[T_STONE_JUNGLE] =	get_texture_coords(1,3,tx,ty,td);
	tc[T_STONE_GOLD] =		get_texture_coords(2,3,tx,ty,td);
	tc[T_WATERMELON] =		get_texture_coords(12,4,tx,ty,td);
	
	//color0,1,2,3,4,5,6,7,8,9	
	tuc = [0,1,0,1,0,0,1,0,0,0
		  ,1,0,0,0,0,0,0,0,0,0
		  ,0,0];
	#region Macros
	#macro I_EMPTY 0
	#macro I_WOOD 110
	#macro I_STICK 100
	#macro I_STONE 111
	#macro I_WSEEDS 120
	#macro I_MUSHROOM1 127
	#macro I_MUSHROOM2 128
	#macro I_MUSHROOM3 129
	#macro I_COAL 106
	#macro I_STONE_TIN 102
	#macro I_STONE_COPPER 103
	#macro I_STONE_IRON 105
	#macro I_STONE_TUNGSTEN 107 
	#macro I_RUBY 118
	#macro I_DIAMOND 119
	#macro I_AMETHYST 108
	#macro I_JUNGLE 0 //La textura no existe
	#macro I_STONE_GOLD 104
	#macro I_WATERMELON 134
	
	#macro I_WOODEN_SWORD 1
	#macro I_WOODEN_PIC 2
	#macro I_WOODEN_HOE 3
	#macro I_WOODEN_AXE 4
	
	#macro I_STONE_SPEAR 10
	#macro I_STONE_SWORD 11
	#macro I_STONE_PIC 12
	#macro I_STONE_HOE 13
	#macro I_STONE_AXE 14
	
	#endregion
	//drops					//Item Id, count
	drops[T_TREE]			= [I_WOOD,3];
	drops[T_GRASS]			= [0,0];
	drops[T_STONE]			= [I_STONE,1];
	drops[T_FERN]			= [0,0];
	drops[T_MUSHROOM1]		= [I_MUSHROOM1,1];
	drops[T_MUSHROOM2]		= [I_MUSHROOM2,1];
	drops[T_WILD_WHEAT]		= [I_WSEEDS,0.1];
	drops[T_DEAD_BUSH]		= [I_STICK,0.6];
	drops[T_CACTUS]			= [I_WOOD,0.2];
	drops[T_MUSHROOM3]		= [I_MUSHROOM3,1];
	drops[T_GRASS2]			= [0,0];
	drops[T_STONE_COAL]		= [I_COAL,1];
	drops[T_STONE_TIN]		= [I_STONE_TIN,1];
	drops[T_STONE_COPPER]	= [I_STONE_COPPER,1];
	drops[T_STONE_IRON]		= [I_STONE_IRON,1];
	drops[T_STONE_TUNGSTEN]	= [I_STONE_TUNGSTEN,1];
	drops[T_STONE_RUBY]		= [I_RUBY,1];
	drops[T_STONE_DIAMOND]	= [I_DIAMOND,1];
	drops[T_STONE_AMETHYST]	= [I_AMETHYST,1];
	drops[T_STONE_JUNGLE]	= [I_JUNGLE,1];
	drops[T_STONE_GOLD]		= [I_STONE_GOLD,1];
	drops[T_WATERMELON]		= [I_WATERMELON,1];
	
	#region crafteos
	global.crafting_recipes = [];
	#macro C_ANY 0
	
	craftable = [];
	
	crafting_grid = [
    [I_EMPTY, 0,0], // Slot 0 vacío
    [I_EMPTY, 0,0], // Slot 1 vacío
    [I_EMPTY, 0,0]  // Slot 2 vacío
	];
	table = C_ANY;
	add_recipe(I_STICK,8,, [
	    [I_WOOD, 1],
	])
	add_recipe(I_WOODEN_SWORD,w_dur[0],, [
	    [I_STICK, 1], 
	    [I_WOOD, 12]
	])
	add_recipe(I_WOODEN_PIC,w_dur[0],, [
	    [I_STICK, 1], 
	    [I_WOOD, 20]
	])
	add_recipe(I_WOODEN_AXE,w_dur[0],, [
	    [I_STICK, 1], 
	    [I_WOOD, 9]
	])
	add_recipe(I_WOODEN_HOE,w_dur[0],, [
	    [I_STICK, 1], 
	    [I_WOOD, 5]
	])

	add_recipe(I_STONE_SWORD,w_dur[1],, [
	    [I_STICK, 1], 
	    [I_STONE, 12]
	])
	
	add_recipe(I_STONE_PIC,w_dur[1],, [
	    [I_STICK, 1], 
	    [I_STONE, 20]
	])
	
	add_recipe(I_STONE_AXE,w_dur[1],, [
	    [I_STICK, 1], 
	    [I_STONE, 9]
	])
	
	add_recipe(I_STONE_HOE,w_dur[1],, [
	    [I_STICK, 1], 
	    [I_STONE, 5]
	])
	
	add_recipe(I_STONE_SPEAR,w_dur[1],, [
	    [I_STICK, 1], 
	    [I_STONE, 10]
	])
	#endregion