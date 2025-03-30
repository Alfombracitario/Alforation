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

//gpu_set_zwriteenable(true);
//shader_set(sh_timecolor);

if(os_type == os_windows || os_type == os_win8native || os_type == os_macosx)
{
	window_mouse_set_locked(true);
}
if(os_type == os_android || os_type == os_macosx)
{
	
}


view_camera[0] = camera_create();
camera_set_proj_mat(view_camera[0],matrix_build_projection_perspective_fov(60,w_width/w_height,1,16000));

gamepad_set_axis_deadzone(0,0.01);

invmousex = w_width>>1;
invmousey = w_height>>1;
previnvmousex = 0;
previnvmousey = 0;

gw = display_get_gui_width();
gh = display_get_gui_height();
invmove = false;

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

invopen = false;

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

selecteditem = 0;
prevcamyaw = 0;

global.update3d = false;

#region CHUNKS
chunk_size = 256;

pcx = floor(x/chunk_size);
pcy = floor(y/chunk_size);

last_pcx = -99999999;
last_pcy = -99999999;
ExtTemperature = 0;

#endregion

//music
alarm_set(11,1);
audio_stop_all();

#region load data

//ini_open(working_directory+global.worldname+"data.ini");
x = ini_read_real("p","x",0);
y = ini_read_real("p","y",0);
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
invdpadx = ini_read_real("options","invdpadx",0.05);
invdpady = ini_read_real("options","invdpady",0.5);
ini_close();
ini_open(working_directory+global.worldname+"data.ini");
#endregion

//inventario
invsize = 40;
var invdata = 3;
for (var i = 0; i < invsize; i++) {
    for (var j = 0; j < invdata; j++) {
        inventory[i][j] = 0; //item vacío
    }
}


//más optimizaciones:
instance_create_layer(x,y,"instances",objVisioncol);

	//obtener texcoords
	var tx = sprite_get_width(sprBtiles)>>4;
	var ty = sprite_get_height(sprBtiles)>>4;
	var td = 16;
	tc[0] = get_texture_coords(0,0,1,1,1); //tree
	tc[1] = get_texture_coords(0,0,tx,ty,td);//grass
	tc[2] = get_texture_coords(0,2,tx,ty,td);//stone
	tc[3] = get_texture_coords(1,0,tx,ty,td);//fern
	tc[4] = get_texture_coords(0,1,tx,ty,td);//mushroom1
	tc[5] = get_texture_coords(1,1,tx,ty,td);//mushroom2
	tc[6] = get_texture_coords(3,4,tx,ty,td);//wild wheat
	tc[7] = get_texture_coords(2,0,tx,ty,td);//dead bush
	tc[8] = get_texture_coords(3,0,tx,ty,td);//cactus
	tc[9] = get_texture_coords(2,1,tx,ty,td);//mushroom3 (corrupción)
	tc[10] = get_texture_coords(1,1,tx,ty,td);//mushroom4 (corrupción)
	tc[11] = get_texture_coords(1,2,tx,ty,td);//stone coal
	tc[12] = get_texture_coords(2,2,tx,ty,td);//stone tin
	tc[13] = get_texture_coords(3,2,tx,ty,td);//stone copper
	tc[14] = get_texture_coords(4,2,tx,ty,td);//stone uhh
	tc[15] = get_texture_coords(5,2,tx,ty,td);//stone iron
	tc[16] = get_texture_coords(6,2,tx,ty,td);//stone tungsten
	tc[17] = get_texture_coords(7,2,tx,ty,td);//stone ruby
	tc[18] = get_texture_coords(8,2,tx,ty,td);//stone diamond
	
	//color0,1,2,3,4,5,6,7,8,9	
	tuc = [0,1,0,1,0,0,1,0,0,0
		  ,1,0,0,0,0,0,0,0,0];
	
	