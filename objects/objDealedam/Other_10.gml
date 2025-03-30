active = true;
depth = -32;
show_debug_message(damage);
var dam = floor(damage);

if(dam <= 99)
{
	var _s1 = dam mod 10;
	var _s2 = dam - _s1;
}
else
{
	_s1 = 9;
	_s2 = 9;
}

sprite = sprite_get_texture(sprFontdam,_s1);
sprite2 = sprite_get_texture(sprFontdam,_s2);
