var cam_yaw = objPlayer.cam_yaw;

if(model)
{
	left_y  = y + dsin(cam_yaw+90) * w>>1;
	right_y = y - dsin(cam_yaw+90) * w>>1;
	left_x  = x + dcos(cam_yaw+90) * w>>1;
	right_x = x - dcos(cam_yaw+90) * w>>1;
}
else
{
	left_y  = y + dsin(cam_yaw+90) * w>>1;
	right_y = y - dcos(cam_yaw+90) * w>>1;
	left_x  = x + dsin(cam_yaw+90) * w>>1;
	right_x = x - dcos(cam_yaw+90) * w>>1;
}
vertex_begin(v,f);
	vertex_position_3d(v,left_x,left_y,zd);
	vertex_color(v,$FFFFFF,1);
	vertex_texcoord(v,1,1);
	vertex_position_3d(v,left_x,left_y,z);
	vertex_color(v,$FFFFFF,1);
	vertex_texcoord(v,1,0);
	vertex_position_3d(v,right_x,right_y,z);
	vertex_color(v,$FFFFFF,1);
	vertex_texcoord(v,0,0);
	vertex_position_3d(v,left_x,left_y,zd);
	vertex_color(v,$FFFFFF,1);
	vertex_texcoord(v,1,1);
	vertex_position_3d(v,right_x,right_y,zd);
	vertex_color(v,$FFFFFF,1);
	vertex_texcoord(v,0,1);
	vertex_position_3d(v,right_x,right_y,z);
	vertex_color(v,$FFFFFF,1);
	vertex_texcoord(v,0,0);
vertex_end(v);