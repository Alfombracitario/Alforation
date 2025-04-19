application_surface_draw_enable(true);
_alpha = -0.5;
screen = 0;
intromode = 0;
intro_tic = 0;
selected_button = 0;
//			sprite, x, y, isvertical
intro[0] = [sprIalfomrade,0,-0.3];
intro[1] = [sprImadera,-1,0.41];
intro[2] = [sprIpresents,1,0.57];
intro[3] = [sprIbar,0,0.5];

Bid = 0;
//botones
selected = -1;
presel = -1;

bc = 3; //button count
//			event,xscale,yscale,x,y,string
button[0] = [0,16,2,0.5,128,"Play"];
button[1] = [1,16,2,0.5,150,"Settings"];
button[2] = [2,16,2,0.5,174,"Exit game"];