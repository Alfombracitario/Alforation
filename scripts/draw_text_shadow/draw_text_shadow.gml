function draw_text_shadow(_x,_y,_text)
{
	//para ahorrar recursos debes poner la font desde afuera del script
	draw_set_color(c_black);
	draw_set_alpha(0.75);
	draw_text(_x+0.5,_y+0.5,_text);
	draw_set_color(c_white);
	draw_set_alpha(1);
	draw_text(_x,_y,_text);
}