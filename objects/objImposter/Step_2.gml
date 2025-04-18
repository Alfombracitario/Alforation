if(activated)
{
	if(tile_index == 0)
	{
		var s = global.sincyphp;
		var c = global.coscyphp;

		var bill1 = s*tw;
		var bill2 = c*tw;
	
		vertex_begin(v[0],f[0]);
	
		var lefty  = y + bill1+8;
		var righty = y - bill1+8;
		var leftx  = x + bill2+8;
		var rightx = x - bill2+8;
	
		var tcx1 = uv[0];
		var tcx2 = uv[2];
		var tcy1 = uv[1];
		var tcy2 = uv[3];
	
		vertex_position_3d(v[0],leftx,lefty,0);
		vertex_color(v[0],c_white,1);
		vertex_texcoord(v[0],tcx2,tcy2);
		vertex_position_3d(v[0],leftx,lefty,th);
		vertex_color(v[0],c_white,1);
		vertex_texcoord(v[0],tcx2,tcy1);
		vertex_position_3d(v[0],rightx,righty,th);
		vertex_color(v[0],c_white,1);
		vertex_texcoord(v[0],tcx1,tcy1);
		vertex_position_3d(v[0],leftx,lefty,0);
		vertex_color(v[0],c_white,1);
		vertex_texcoord(v[0],tcx2,tcy2);
		vertex_position_3d(v[0],rightx,righty,0);
		vertex_color(v[0],c_white,1);
		vertex_texcoord(v[0],tcx1,tcy2);
		vertex_position_3d(v[0],rightx,righty,th);
		vertex_color(v[0],c_white,1);
		vertex_texcoord(v[0],tcx1,tcy1);
	
		vertex_end(v[0]);
	}
	
	vertex_begin(v[1],f[1]);//este es el modelo de las particulas
	vertex_end(v[1]);
	
	
	//de momento
	
	activated = false;
	event_user(0);
}