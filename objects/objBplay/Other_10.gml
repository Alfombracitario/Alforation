instance_destroy(objBexit);
instance_destroy(objBsettings);
instance_create_layer(0,-64,"title",objBcreateworld);
instance_create_layer(0,-64,"title",objBloadworld);
instance_create_layer(0,-64,"title",objBdeleteworld);
instance_destroy();
objTitlescreen.screen = 1;