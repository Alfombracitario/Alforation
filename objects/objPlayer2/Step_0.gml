var xfrom = x;
var yfrom = y;

sin_tic = 0;
cam_yaw = 0;

camz = 0;

z = 0;

var _z = -22 + (sin(sin_tic *0.1) * 0.02);

var xto = xfrom + dcos(cam_yaw);
var yto = yfrom + dsin(cam_yaw);
var zto = camz + (sin(sin_tic *0.1) * 0.01);


var mat = matrix_build_lookat(xfrom, yfrom, z+_z, xto, yto, z+_z + zto, 0, 0, 1);
camera_set_view_mat(view_camera[1], mat);