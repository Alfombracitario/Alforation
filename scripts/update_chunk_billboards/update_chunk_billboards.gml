function update_chunk_billboards(){
var zsize = [th,-16];
var color = [c_white,image_blend];
var tc = objPlayer.tc;
var tuc = objPlayer.tuc;
tc[T_TREE].x1 = uv[0];
tc[T_TREE].x2 = uv[2];
tc[T_TREE].y1 = uv[1];
tc[T_TREE].y2 = uv[3];
vertex_begin(v,f);
for(var i = 0; i < objectcount; i++)
{
    
		var j = objects[i][0];
		if j == -1 continue; //si es -1 entonces saltar
		c = color[tuc[j]];
		var h = j;
		
        //muy mala pracitca pero bueno
        zsize[1] = -16;
        if j == T_TALLGRASS zsize[1] = -32;
	    if j == T_BAMBOO zsize[1] = -52;
            
        if !j == 0 j = 1;//si no es un arbol usa modelo 0
        
        var _a = 0;
        if j == 0 _a = 0.2;
    
		var _x = objects[i][1];
		var _y = objects[i][2];
	
		var lefty  = _y + 8;
		var righty = _y - 8;
		var leftx  = _x + 8;
		var rightx = _x - 8;
    
		vertex_position_3d(v,leftx,lefty,0);
		vertex_color(v,c,0+_a);
		vertex_texcoord(v,tc[h].x2,tc[h].y2);
    
		vertex_position_3d(v,leftx,lefty,zsize[j]);
		vertex_color(v,c,0+_a);
		vertex_texcoord(v,tc[h].x2,tc[h].y1);
    
		vertex_position_3d(v,rightx,righty,zsize[j]);
		vertex_color(v,c,0.1+_a);
		vertex_texcoord(v,tc[h].x1,tc[h].y1);
    
		vertex_position_3d(v,leftx,lefty,0);
		vertex_color(v,c,0+_a);
		vertex_texcoord(v,tc[h].x2,tc[h].y2);
    
		vertex_position_3d(v,rightx,righty,0);
		vertex_color(v,c,0.1+_a);
		vertex_texcoord(v,tc[h].x1,tc[h].y2);
    
		vertex_position_3d(v,rightx,righty,zsize[j]);
		vertex_color(v,c,0.1+_a);
		vertex_texcoord(v,tc[h].x1,tc[h].y1);
}
vertex_end(v);
}