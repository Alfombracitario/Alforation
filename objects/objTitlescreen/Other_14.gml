global.render_distance++;
global.render_distance = global.render_distance & 63;

button[1][5] = "Render distance: "+string(1+(global.render_distance<<1));