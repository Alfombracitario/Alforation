function set_tree(_spr,_index = 0)
{
	tree = sprite_get_texture(_spr,_index);
	uv = sprite_get_uvs(_spr,_index);
	th = sprite_get_height(_spr)*-1;
	tw = sprite_get_width(_spr)>>1;

}