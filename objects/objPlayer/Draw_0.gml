//dibujar toda la escena
//primero las cosas sin zbuffer
with(objSun)
{
	event_perform(ev_draw,0);
}

gpu_set_ztestenable(true);
//ahora los elementos normales

//ahora el terreno
if(room == game)
{
	shader_set(sBillboard);
	shader_set_uniform_f(_t,global.sincyphp,global.coscyphp);
	shader_set_uniform_f(fog_settings,fog_depth-fog_density,fog_depth);
	
	with(objChunk)
	{
		event_perform(ev_draw,0);
	}
}