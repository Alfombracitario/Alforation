randomize();
global.worldname = "save/";

global.chunk_size = 256;

global.font = font_add_sprite_ext(sprFont,"1234567890ABCDEFGHIJKLMNÑOPQRSTUVWXYZaábcdeéfghiíjklmnñoópqrstuúüvwxyz*/\"':;.,¡!¿?-~()[]{}<>\\@#$%➤",1,1);
global.font2 = font_add_sprite_ext(sprFont2,"ÀÁÉËÍÓÚß§©!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_abcdefghijklmnopqrstuvwxyz{}~ÇÜéäàçëèïìÄÉæÆöòùÿÖÜ£áíóúñÑ¬¡«»",1,1);
draw_set_font(global.font);

ini_open(working_directory+"options.ini");

global.render_distance = ini_read_real("options","render_distance",2);
global.fpsmode = ini_read_real("options","fpsmode",1);
global.uisize = ini_read_real("options","uisize",3);
global.update3Dtime = ini_read_real("options","update3Dtime",1);
global.screendiv = ini_read_real("options","screendiv",0);
global.fog = ini_read_real("options","fog",1);
global.musvol = ini_read_real("options","musvol",0.125);
global.sndvol = ini_read_real("options","sndvol",1);

audio_play_sound(musTitle,0,0,global.musvol);

/*
ini_write_string("options","render_distance",global.render_distance);
ini_write_string("options","fpsmode",global.fpsmode);
ini_write_string("options","uisize",global.uisize);
ini_write_string("options","update3Dtime",global.update3Dtime);
ini_write_string("options","screendiv",global.screendiv);
ini_write_string("options","fog",global.fog);
*/
ini_close();


switch(os_browser)
{
	case browser_opera:
	case browser_safari:
	case browser_edge:
	case browser_ie: //lol
	global.fog = false;
	break;
}
