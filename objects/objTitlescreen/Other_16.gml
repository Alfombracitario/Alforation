var factor = round(window_get_height() / 180);
global.uisize = global.uisize mod factor;
global.uisize++;

button[3][5] = "Ui size: "+string(global.uisize);
