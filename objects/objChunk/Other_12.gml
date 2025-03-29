//dibujado 3D
var s = global.sincyphp;
var c = global.coscyphp;

var bill1 = [s*tw,s*8];
var bill2 = [c*tw,c*8];

var zsize = [th,-16];

var color = [c_white,image_blend];
vertex_begin(v[0],f[0]);
vertex_begin(v[1],f[1]);

var tc = objPlayer.tc;
var tuc = objPlayer.tuc;

for(var i = 0; i < objectcount; i++)
{
		var j = objects[i][0];
		if j == -1 continue; //si es -1 entonces saltar
		var c = color[tuc[j]];
		var h = j;
		
		if !j == 0 j = 1;//si no es un arbol usa modelo 0
	
		var _x = objects[i][1];
		var _y = objects[i][2];
	
		var lefty  = _y + bill1[j]+8;
		var righty = _y - bill1[j]+8;
		var leftx  = _x + bill2[j]+8;
		var rightx = _x - bill2[j]+8;
	
		vertex_position_3d(v[j],leftx,lefty,0);
		vertex_color(v[j],c,1);
		vertex_texcoord(v[j],tc[h].x2,tc[h].y2);
		vertex_position_3d(v[j],leftx,lefty,zsize[j]);
		vertex_color(v[j],c,1);
		vertex_texcoord(v[j],tc[h].x2,tc[h].y1);
		vertex_position_3d(v[j],rightx,righty,zsize[j]);
		vertex_color(v[j],c,1);
		vertex_texcoord(v[j],tc[h].x1,tc[h].y1);
		vertex_position_3d(v[j],leftx,lefty,0);
		vertex_color(v[j],c,1);
		vertex_texcoord(v[j],tc[h].x2,tc[h].y2);
		vertex_position_3d(v[j],rightx,righty,0);
		vertex_color(v[j],c,1);
		vertex_texcoord(v[j],tc[h].x1,tc[h].y2);
		vertex_position_3d(v[j],rightx,righty,zsize[j]);
		vertex_color(v[j],c,1);
		vertex_texcoord(v[j],tc[h].x1,tc[h].y1);
		
}
vertex_end(v[0]);
vertex_end(v[1]);