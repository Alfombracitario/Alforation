instance_destroy(objBexit);
instance_destroy(objBsettings);
instance_create_layer(0,-64,"title",objBcreateworld);
instance_create_layer(0,-64,"title",objBloadworld);
instance_create_layer(0,-64,"title",objBdeleteworld);

objTitlescreen.screen = 1;
draw_set_font(global.font2);
draw_set_halign(fa_left);
instance_destroy();