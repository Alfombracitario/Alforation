//objSettings
selected = -1;
presel = -1;
screen = 2;

//			event,xscale,yscale,x,y,string
button[0] = [3,16,2,0.5,24,"Done",""];
button[1] = [4,16,2,0.5,72,"Render distance: "+string(1+(global.render_distance<<1))];
button[2] = [5,16,2,0.5,96,"Screen resolution: "+string(global.screendiv)];
button[3] = [6,16,2,0.5,120,"Ui size: "+string(global.uisize)];
button[4] = [7,16,2,0.5,144,"FPS rate: "+string(60/global.fpsmode)];
//button[5] = [8,16,2,0.5,168,"Billboard res: "+string(global.update3Dtime)];

bc = array_length(button);