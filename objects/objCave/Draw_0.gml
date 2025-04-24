vertex_submit(v,pr_trianglelist,texture);
gpu_set_depth(-48);
draw_sprite_ext(sprBtiles,64,x,y,_xlimit,_ylimit,0,c_gray,1);
gpu_set_depth(0);
draw_sprite_ext(sprBtiles,64,x,y,_xlimit,_ylimit,0,c_white,1);