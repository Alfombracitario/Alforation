gpu_set_ztestenable(false);
vertex_submit(v,pr_trianglelist,texture)
gpu_set_ztestenable(true);
/* nadie quiere a las nubes lmfao
gpu_set_depth(-512);
//dibujar las nubes
draw_sprite_ext(sprClouds,0,objPlayer.x,objPlayer.y,32,32,0,c_white,1);
gpu_set_depth(0);