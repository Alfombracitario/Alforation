//delete chunk
var pcx = objPlayer.pcx;
var pcy = objPlayer.pcy;
var rd = global.render_distance;
if (cx < pcx - rd || cx > pcx + rd 
 || cy < pcy - rd || cy > pcy + rd) 
{
	instance_destroy();
}
