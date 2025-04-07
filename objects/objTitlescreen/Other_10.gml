//objplay
instance_create_layer(0,-64,"title",objBcreateworld);
instance_create_layer(0,-64,"title",objBloadworld);
instance_create_layer(0,-64,"title",objBdeleteworld);

screen = 1;
draw_set_font(global.font2);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
bc = 1;
button[0] = [-1,0,0,0,0,""];