hp = 5;
speed = 0;
init_3d_model();
zv = -16;
z = 0;
sw = 8;
draw_3d_image();
alarm_set(0,2);
texture = sprite_get_texture(sprEslime,0)
frame_index = 0;
uv = get_texture_coords_sprite(sprEslime,frame_index)
state = 0;