draw_set_halign(fa_left);
w_width = window_get_width();
w_height = window_get_height();
image_alpha = 0;
view_enabled = true;
view_visible[0] = true;
camera_set_view_size(view_camera[0],w_width,w_height);
var factor = round(w_height / 180);
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
application_surface_draw_enable(false);

gpu_set_alphatestenable(true);
gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);

if(os_type == os_windows || os_type == os_macosx || os_type == os_operagx)
{
	window_mouse_set_locked(true);
}

view_camera[0] = camera_create();
camera_set_proj_mat(view_camera[0],matrix_build_projection_perspective_fov(60,w_width/w_height,1,16000));

gamepad_set_axis_deadzone(0,0.01);

//macros iniciales
#macro GRAV_NORMAL -0.15*global.fpsmode
#macro GRAV_JUMP -0.13*global.fpsmode
invmousex = w_width>>1;
invmousey = w_height>>1;
previnvmousex = 0;
previnvmousey = 0;
gw = display_get_gui_width();
gh = display_get_gui_height();
z = 0;
running = false;
zspeed = 0;
grav = -0.2*global.fpsmode;
jumpf = 2;
knockback = 0;
invmove = false;
craftmove = false;
craftresult = [0,0,0,0,0];
prevmousex = [0,0,0];
prevmousey = [0,0,0];
prevmousex_r = [0,0,0];
prevmousey_r = [0,0,0];
mousex = [0,0,0];
mousey = [0,0,0];
mousex_r = [0,0,0];
mousey_r = [0,0,0];
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
hand_text = "";
hand_text_tic = 0;
cooldown = 0;
cooldownmax = 0;
weapon_swaying = true;
weapon_y = 0;
wprev = w_width;
hprev = w_height;
humidity = 0;
hurt_tic = 0;
notday = false;
timecolor = c_white;
fog_color = $FF9865;
sky_color = fog_color;
fog_depth = (global.render_distance+0.5)*CHUNK_SIZE;
fog_density = CHUNK_SIZE;

//variables de mierda de optimización
halfpi = pi*0.5;
global.sincyphp = sin(halfpi);
global.coscyphp = cos(halfpi);
update3Dindex = 0;

prevcamyaw = 0;

global.update3d = false;

#region CHUNKS

pcx = (x/CHUNK_SIZE)<<0;
pcy = (y/CHUNK_SIZE)<<0;

last_pcx = 16777217;
last_pcy = 16777217;
ExtTemperature = 0;
selector = [0,0,0,0];

#endregion

//music
alarm_set(11,1);
audio_stop_all();

#region load data

ini_open(WORLDIR+global.worldname+"/inv.ini");
if(room == game)
{
	x = ini_read_real("p","x",0);
	y = ini_read_real("p","y",0);
    z = ini_read_real("p","z",0);
}
else {
if room == dungeon tiles = objDungeon.tiles;
if room == cave tiles = objCave.tiles;
}
_health = ini_read_real("p","health",100);
_hunger = ini_read_real("p","hunger",100);
_temperature = ini_read_real("p","temp",128);
cam_yaw = ini_read_real("p","camyaw",0);
_time = ini_read_real("p","time",0);
maxhealth = ini_read_real("p","maxhealth",100);
experience = ini_read_real("p","xp",0);
level = ini_read_real("p","lv",1);
xp_need = floor(25 * level * power(1.1, level));
//inventario
invsize = 40;
var invdata = 3;
for (var i = 0; i < invsize; i++) {
    for (var j = 0; j < invdata; j++) {
        inventory[i][j] = ini_read_real(j,i,0);
    }
}
/*
	j[0] = id
	j[1] = cantidad/durabilidad
	j[2] = efectos
*/
//configuraciones que se cargan en el jugador por algún motivo
ini_close();
ini_open(working_directory+"options.ini");
invx = ini_read_real("options","invx",64);
invy = ini_read_real("options","invy",64);
hotbarx = ini_read_real("options","hotbx",0);
hotbarsize = ini_read_real("options","hotbs",8);
if(os_type == os_android || os_type == os_ios)
{
    invdpadx = ini_read_real("options","invdpadx",0.05);
    invdpady = ini_read_real("options","invdpady",0.5);
    buttonax = ini_read_real("options","buttonax",0.9);
    buttonay = ini_read_real("options","buttonay",0.5);
    buttonbx = ini_read_real("options","buttonbx",0.81);
    buttonby = ini_read_real("options","buttonby",0.65);
    buttonix = ini_read_real("options","buttonix",0.76);
    buttoniy = ini_read_real("options","buttoniy",0.8);
    dx = gw*invdpadx;
	dy = gh*invdpady;
	ds = round(gh*0.15);
	bs = ds*0.05;
	bax = gw*buttonax;
	bay = gh*buttonay;
	bbx = gw*buttonbx;
	bby = gh*buttonby;
	bix = gw*buttonix;
	biy = gh*buttoniy;
}



craftx = ini_read_real("options","craftx",256);
crafty = ini_read_real("options","crafty",64);


ini_close();
#endregion
ini_open(WORLDIR+global.worldname+"/data.ini");


//hotbar
hotbar = 0;
hotbarsel = 0;
for(var i = 0; i < hotbarsize; i++)
{
	hotbar[i] = i;
}

//más optimizaciones:
if room == game 
{
	instance_create_depth(x,y,1,objVisioncol);
	instance_create_depth(x,y,0,objImposter);
}
	//datos de los items

	//spear,sword,pic,hoe,axe
	w_coold = [15,20,12,4,45];
	w_damincrmt = [3,5,2,1,7];
	w_damage = [7,10,5,2,15];
	w_dur = [32,64,210,270,300,400,460,700,850,1000];
	
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
    #macro T_TALLGRASS      22
    #macro T_BAMBOO         23
	
	tc[T_TREE] =			get_texture_coords_sprite(sprBtiles,0);
	tc[T_GRASS] =			get_texture_coords_sprite(sprBtiles,0);
	tc[T_STONE] =			get_texture_coords_sprite(sprBtiles,20);
	tc[T_FERN] =			get_texture_coords_sprite(sprBtiles,1);
	tc[T_MUSHROOM1] =		get_texture_coords_sprite(sprBtiles,10);
	tc[T_MUSHROOM2] =		get_texture_coords_sprite(sprBtiles,11);
	tc[T_WILD_WHEAT] =		get_texture_coords_sprite(sprBtiles,43);
	tc[T_DEAD_BUSH] =		get_texture_coords_sprite(sprBtiles,2);
	tc[T_CACTUS] =			get_texture_coords_sprite(sprBtiles,3);
	tc[T_MUSHROOM3] =		get_texture_coords_sprite(sprBtiles,12);
	tc[T_GRASS2] =			get_texture_coords_sprite(sprBtiles,4);
	tc[T_STONE_COAL] =		get_texture_coords_sprite(sprBtiles,21);
	tc[T_STONE_TIN] =		get_texture_coords_sprite(sprBtiles,22);
	tc[T_STONE_COPPER] =	get_texture_coords_sprite(sprBtiles,23);
	tc[T_STONE_IRON] =		get_texture_coords_sprite(sprBtiles,24);
	tc[T_STONE_TUNGSTEN] =	get_texture_coords_sprite(sprBtiles,25);
	tc[T_STONE_RUBY] =		get_texture_coords_sprite(sprBtiles,26);
	tc[T_STONE_DIAMOND] =	get_texture_coords_sprite(sprBtiles,27);
	tc[T_STONE_AMETHYST] =	get_texture_coords_sprite(sprBtiles,30);
	tc[T_STONE_JUNGLE] =	get_texture_coords_sprite(sprBtiles,31);
	tc[T_STONE_GOLD] =		get_texture_coords_sprite(sprBtiles,32);
	tc[T_WATERMELON] =		get_texture_coords_sprite(sprBtiles,49);
    tc[T_TALLGRASS] =       get_texture_coords_sprite(sprBtiles16b32,0);
    tc[T_BAMBOO] =          get_texture_coords_sprite(sprBamboo,0);
	
	//color0,1,2,3,4,5,6,7,8,9	
	tuc = [0,1,0,1,0,0,1,0,0,0
		  ,1,0,0,0,0,0,0,0,0,0
		  ,0,0,1,0];
	
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
	#macro I_WATERMELON 133
	#macro I_SLIME 142
	#macro I_BONE 141
	#macro I_WOOD_BLOCK 151
	#macro I_COBBLE_BLOCK 150
	
	#macro I_TIN_INGOT 112
	#macro I_COPPER_INGOT 113
	#macro I_BRONZE_INGOT 114
	#macro I_IRON_INGOT 115
	#macro I_LEAD_INGOT 116
	#macro I_TUNGSTEN_INGOT 117
	
	#macro I_WOODEN_SWORD 1
	#macro I_WOODEN_PIC 2
	#macro I_WOODEN_HOE 3
	#macro I_WOODEN_AXE 4
	
	#macro I_STONE_SPEAR 10
	#macro I_STONE_SWORD 11
	#macro I_STONE_PIC 12
	#macro I_STONE_HOE 13
	#macro I_STONE_AXE 14
	
	#macro I_TIN_SPEAR 20
	#macro I_TIN_SWORD 21
	#macro I_TIN_PIC 22
	#macro I_TIN_HOE 23
	#macro I_TIN_AXE 24

	#macro I_COPPER_SPEAR 30
	#macro I_COPPER_SWORD 31
	#macro I_COPPER_PIC 32
	#macro I_COPPER_HOE 33
	#macro I_COPPER_AXE 34

	#macro I_BRONZE_SPEAR 40
	#macro I_BRONZE_SWORD 41
	#macro I_BRONZE_PIC 42
	#macro I_BRONZE_HOE 43
	#macro I_BRONZE_AXE 44

	#macro I_IRON_SPEAR 50
	#macro I_IRON_SWORD 51
	#macro I_IRON_PIC 52
	#macro I_IRON_HOE 53
	#macro I_IRON_AXE 54

	#macro I_LEAD_SPEAR 60
	#macro I_LEAD_SWORD 61
	#macro I_LEAD_PIC 62
	#macro I_LEAD_HOE 63
	#macro I_LEAD_AXE 64

	#endregion
	//drops					//Item Id, count, xpcount
	drops[T_TREE]			= [I_WOOD,3,1];
	drops[T_GRASS]			= [0,0,0];
	drops[T_STONE]			= [I_STONE,1,0.1];
	drops[T_FERN]			= [0,0,0];
	drops[T_MUSHROOM1]		= [I_MUSHROOM1,1,0];
	drops[T_MUSHROOM2]		= [I_MUSHROOM2,1,0];
	drops[T_WILD_WHEAT]		= [I_WSEEDS,0.1,0.1];
	drops[T_DEAD_BUSH]		= [I_STICK,0.6,0];
	drops[T_CACTUS]			= [I_WOOD,0.2,0];
	drops[T_MUSHROOM3]		= [I_MUSHROOM3,1,0];
	drops[T_GRASS2]			= [0,0];
	drops[T_STONE_COAL]		= [I_COAL,1,2];
	drops[T_STONE_TIN]		= [I_STONE_TIN,1,3];
	drops[T_STONE_COPPER]	= [I_STONE_COPPER,1,5];
	drops[T_STONE_IRON]		= [I_STONE_IRON,1,10];
	drops[T_STONE_TUNGSTEN]	= [I_STONE_TUNGSTEN,1,15];
	drops[T_STONE_RUBY]		= [I_RUBY,1,20];
	drops[T_STONE_DIAMOND]	= [I_DIAMOND,1,25];
	drops[T_STONE_AMETHYST]	= [I_AMETHYST,1,20];
	drops[T_STONE_JUNGLE]	= [I_JUNGLE,1,20];
	drops[T_STONE_GOLD]		= [I_STONE_GOLD,1,20];
	drops[T_WATERMELON]		= [I_WATERMELON,1,0];
	drops[T_TALLGRASS]		= [0,0,0];
    drops[T_BAMBOO]		    = [I_WOOD,0.5,0];

	#region crafteos
	global.crafting_recipes = [];
	#macro C_ANY 0
	#macro C_FURNACE 0 //temporal
	
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
	

    //estaño
	add_recipe(I_TIN_SWORD,w_dur[2],, [
	    [I_STICK, 1], 
	    [I_TIN_INGOT, 12]
	])
	
	add_recipe(I_TIN_PIC,w_dur[2],, [
	    [I_STICK, 1], 
	    [I_TIN_INGOT, 20]
	])
	
	add_recipe(I_TIN_AXE,w_dur[2],, [
	    [I_STICK, 1], 
	    [I_TIN_INGOT, 9]
	])
	
	add_recipe(I_TIN_HOE,w_dur[2],, [
	    [I_STICK, 1], 
	    [I_TIN_INGOT, 5]
	])
	
	add_recipe(I_TIN_SPEAR,w_dur[2],, [
	    [I_STICK, 1], 
	    [I_TIN_INGOT, 10]
	])


    //cobre
	add_recipe(I_COPPER_SWORD,w_dur[3],, [
	    [I_STICK, 1], 
	    [I_COPPER_INGOT, 12]
	])
	
	add_recipe(I_COPPER_PIC,w_dur[3],, [
	    [I_STICK, 1], 
	    [I_COPPER_INGOT, 20]
	])
	
	add_recipe(I_COPPER_AXE,w_dur[3],, [
	    [I_STICK, 1], 
	    [I_COPPER_INGOT, 9]
	])
	
	add_recipe(I_COPPER_HOE,w_dur[3],, [
	    [I_STICK, 1], 
	    [I_COPPER_INGOT, 5]
	])
	
	add_recipe(I_COPPER_SPEAR,w_dur[3],, [
	    [I_STICK, 1], 
	    [I_COPPER_INGOT, 10]
	])

    //Bronze
	add_recipe(I_BRONZE_SWORD,w_dur[4],, [
	    [I_STICK, 1], 
	    [I_BRONZE_INGOT, 12]
	])
	
	add_recipe(I_BRONZE_PIC,w_dur[4],, [
	    [I_STICK, 1], 
	    [I_BRONZE_INGOT, 20]
	])
	
	add_recipe(I_BRONZE_AXE,w_dur[4],, [
	    [I_STICK, 1], 
	    [I_BRONZE_INGOT, 9]
	])
	
	add_recipe(I_BRONZE_HOE,w_dur[4],, [
	    [I_STICK, 1], 
	    [I_BRONZE_INGOT, 5]
	])
	
	add_recipe(I_BRONZE_SPEAR,w_dur[4],, [
	    [I_STICK, 1], 
	    [I_BRONZE_INGOT, 10]
	])

    //Iron
	add_recipe(I_IRON_SWORD,w_dur[5],, [
	    [I_STICK, 1], 
	    [I_IRON_INGOT, 12]
	])
	
	add_recipe(I_IRON_PIC,w_dur[5],, [
	    [I_STICK, 1], 
	    [I_IRON_INGOT, 20]
	])
	
	add_recipe(I_IRON_AXE,w_dur[5],, [
	    [I_STICK, 1], 
	    [I_IRON_INGOT, 9]
	])
	
	add_recipe(I_IRON_HOE,w_dur[5],, [
	    [I_STICK, 1], 
	    [I_IRON_INGOT, 5]
	])
	
	add_recipe(I_IRON_SPEAR,w_dur[5],, [
	    [I_STICK, 1], 
	    [I_IRON_INGOT, 10]
	])

    //Lead
	add_recipe(I_LEAD_SWORD,w_dur[6],, [
	    [I_STICK, 1], 
	    [I_LEAD_INGOT, 12]
	])
	
	add_recipe(I_LEAD_PIC,w_dur[6],, [
	    [I_STICK, 1], 
	    [I_LEAD_INGOT, 20]
	])
	
	add_recipe(I_LEAD_AXE,w_dur[6],, [
	    [I_STICK, 1], 
	    [I_LEAD_INGOT, 9]
	])
	
	add_recipe(I_LEAD_HOE,w_dur[6],, [
	    [I_STICK, 1], 
	    [I_LEAD_INGOT, 5]
	])
	
	add_recipe(I_LEAD_SPEAR,w_dur[6],, [
	    [I_STICK, 1], 
	    [I_LEAD_INGOT, 10]
	])

	//Bloques y otras cosas generales
	add_recipe(I_WOOD_BLOCK,1,,
	[
		[I_WOOD,4]
	])
	
	add_recipe(I_COBBLE_BLOCK,1,,
	[
		[I_STONE,8]
	])
	
	add_recipe(I_WOOD,1,,
	[
		[I_STICK,8]
	])
	
	add_recipe(I_WOOD,4,,
	[
		[I_WOOD_BLOCK,1]
	])
	
	add_recipe(I_STONE,8,,
	[
		[I_COBBLE_BLOCK,1]
	])
	
	
	
	//horno
	add_recipe(I_TIN_INGOT,1,C_FURNACE,
	[
		[I_STONE_TIN,1]
	])
	add_recipe(I_COPPER_INGOT,1,C_FURNACE,
	[
		[I_STONE_COPPER,1]
	])
	add_recipe(I_BRONZE_INGOT,1,C_FURNACE,
	[
		[I_STONE_TIN,1],
		[I_STONE_COPPER,1],
	])
	add_recipe(I_IRON_INGOT,1,C_FURNACE,
	[
		[I_STONE_IRON,2]
	])
	add_recipe(I_LEAD_INGOT,1,C_FURNACE,
	[
		[I_STONE_IRON,4],
		[I_COAL,1]
	])
	#endregion