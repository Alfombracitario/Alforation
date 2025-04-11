w = objPlayer.w_width
h = objPlayer.w_height
gw = display_get_gui_width()
gh = display_get_gui_height()
surf = sprite_create_from_surface(application_surface,0,0,w,h,false,false,0,0);
instance_deactivate_all(true);
window_mouse_set_locked(false);

//botones
hsel = -1;
presel = -1;

bc = 2; //button count

button[0] = [0,16,2,gw>>1,64,"Resume game"];
button[1] = [1,16,2,gw>>1,96,"Exit and save"];
gpu_set_ztestenable(false);
draw_set_halign(fa_middle);
draw_set_valign(fa_center);