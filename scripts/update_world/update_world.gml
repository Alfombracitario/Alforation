function update_world(){
//este código actualiza todos los modelos del juego
    instance_activate_object(objVisioncol);
	with(objVisioncol)
    {
        objChunk.draw = false;
        x = objPlayer.x;
        y = objPlayer.y;
        image_angle = -objPlayer.cam_yaw;
        direction = image_angle;
    }
}