//screen resolution

global.screendiv++;
global.screendiv = global.screendiv mod 3;

button[2][5] = "Screen resolution: "+string(global.screendiv);