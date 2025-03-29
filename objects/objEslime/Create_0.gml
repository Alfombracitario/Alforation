hp = 10;
speed = 1;

init_3d_model(false);
zv = depth-(sprite_height*image_yscale);
sw = image_xscale*sprite_width>>1; 
draw_3d_image();

object_sprite = sprite_get_texture(sprBlank,0)