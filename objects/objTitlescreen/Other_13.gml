//se guardan los ajustes
ini_open(working_directory+"options.ini");
ini_write_string("options","render_distance",global.render_distance);
ini_write_string("options","fpsmode",global.fpsmode);
ini_write_string("options","uisize",global.uisize);
ini_write_string("options","screendiv",global.screendiv);

ini_close();
game_restart()