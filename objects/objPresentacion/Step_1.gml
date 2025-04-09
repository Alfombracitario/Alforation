if(gamepad_button_check_pressed(0,gp_padl))
{
	if(frame > 0)
	{
		frame--;
	}
	image = sprite_get_texture(sprPresentacion,frame);
}
if(gamepad_button_check_pressed(0,gp_padr))
{
	frame++;
	image = sprite_get_texture(sprPresentacion,frame);
}
if(gamepad_button_check_pressed(0,gp_padu) || gamepad_button_check_pressed(0,gp_padd))
{
	model = !model;
}

// Esto va en el evento Step (por ejemplo, Step > Step)
// Verificamos si el gamepad está conectado
if (gamepad_is_connected(0)) {
    if (gamepad_button_check_pressed(0, gp_shoulderlb)) 
	{
        objPlayer.fly = !objPlayer.fly;
	}
}