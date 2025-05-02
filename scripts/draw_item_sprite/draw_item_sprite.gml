function draw_item_sprite(_x,_y,_sprite,_count,_shpos = 0){ 
    if _sprite == 0 exit;
        
    if _shpos != 0
    {
        draw_sprite_ext(sprItems,_sprite,_x+_shpos,_y+_shpos,1,1,0,c_black,0.5); //item
    }
	
    if(_sprite <= 99 && _sprite > 0)//barra
	{
		var _tier = (_sprite*0.1)>>0
        var _durabilitypercentage = _count/w_dur[_tier];
        var color = merge_color($000070,$00FF20,_durabilitypercentage);
		draw_sprite_ext(sprPixel,0,_x,_y+16,16,_durabilitypercentage*16,0,color,1);
		draw_sprite(sprItems,_sprite,_x,_y); //item
	}
	else
	{
		draw_sprite(sprItems,_sprite,_x,_y); //item
		if (_count > 1)
		{
			draw_text_shadow(_x,_y+8,_count);//cantidad
		}
	}
}