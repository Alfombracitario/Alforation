hp = 75;
maxhp = hp;
state = 0;
mspeed = 0;
knockspd = 0;
drop = true;
init_3d_model(false);
zv = -21;
z = 0;
sw = 15;
draw_3d_image();
alarm_set(0,2);
texture = sprite_get_texture(sprEpronifo,0);
frame_index = 0;
uv = get_texture_coords_sprite(sprEpronifo,frame_index)