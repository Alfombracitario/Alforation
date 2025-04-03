gpu_set_fog(false,0,0,0);
draw_set_valign(fa_top)
draw_set_halign(fa_left)
if(notday) //día y noche
{
	var lay_id = layer_get_id("Background");
	var back_id = layer_background_get_id(lay_id);
	layer_background_blend(back_id, fog_color);
	
	display_set_gui_size(w_width,w_height);
	draw_surface_ext(application_surface,0,0,1,1,0,timecolor,1);
	display_set_gui_size(gw,gh);
	shader_reset();
}

draw_sprite_ext(
    sprItems,
	inventory[selecteditem][0],
    (gw * 0.75) + (sin(sway_x *0.1) * sway_amount * 8 * weapon_swaying),
    gh-120+(sin(sway_y *0.1) + 1) * sway_amount * 2 * weapon_swaying + weapon_y+(cooldown<<2),
    8,
    8,
    12,
    c_white,
    1
);
if(hurt_tic > 0)
{
	draw_set_alpha(min(hurt_tic,0.8));
	draw_set_color(c_red);
	draw_rectangle(0,0,gw,gh,false);
	draw_set_color(c_white);
	draw_set_alpha(1);
}

//barras
draw_sprite_ext(sprBar,1,0,10,8.2,1,0,c_orange,1);//fondo
draw_sprite_ext(sprBar,0,0,10,_hunger*0.082,1,0,c_orange,1);//contenido

draw_sprite_ext(sprBar,1,0,0,8.2,1,0,c_red,1);
draw_sprite_ext(sprBar,0,0,0,_health*0.082,1,0,c_red,1);

#region inventory
if(invopen)
{
	
	draw_text(0,0,string(invmousex)+"\n"+string(invmousey));
	draw_set_font(global.font2);
	window_mouse_set_locked(false);
	
	draw_sprite_ext(sprContainer,0,invx-5,invy-16,17,9,0,c_white,1); //contorno
	
	draw_sprite_ext(sprSlot,0,invx,invy,10,4,0,c_white,1);
	
	draw_text_shadow(invx,invy-10,"inventory");
	
	var rows = invsize*0.1;
	draw_sprite(sprInvselected,0
	,invx+((selecteditem mod 10)<<4)
	,invy+(floor(selecteditem*0.1)<<4)
	);
	
	
	
	
	for (var i = 0; i < rows; i++) {
		for (var j = 0; j < 10; j++) {
			
			var _slot = j+(10*i);
			var _sx = invx+(j<<4);
			var _sy = invy+(i<<4);
			draw_sprite(sprItems,inventory[_slot][0],_sx,_sy);
			if (inventory[_slot][1] != 0 && inventory[_slot][1] != 1)
			{
				draw_set_halign(fa_right);
				draw_text(_sx+16,_sy+8,inventory[_slot][1]);
				draw_set_halign(fa_left);
			}
		}
	}
	if(gamepad_is_connected(0))
	{
		draw_sprite(sprMouse,0,invmousex,invmousey);
	}
	draw_set_font(global.font);
}
#endregion
else
{
	if(gamepad_is_connected(0))
	{
		draw_sprite(sprGamepadbuttons,0,4,gh-26)
		draw_sprite(sprGamepadbuttons,1,30,gh-26)
		draw_text(52,gh-20,"Change item");
		draw_sprite(sprGamepadbuttons,8,gw-30,gh-26);
		draw_text(gw-86,gh-20,"Inventory");
		draw_sprite(sprGamepadbuttons,9,gw-30,gh-56);
		draw_text(gw-50,gh-50,"Run");
	}
	else
	{
		if(os_type == os_android || os_type == os_ios)
		{
			var dx = gw*invdpadx;
			var dy = gh*invdpady;
			var ds = round(gh*0.15);
			draw_set_color(c_black);
			draw_rectangle(dx,dy,dx+(ds*3),dy+(ds*3),true);//area
			draw_set_alpha(0.5);
			draw_rectangle(dx,dy,dx+(ds*3),dy+ds,false); //arriba
			draw_rectangle(dx,dy,dx+ds,dy+(ds*3),false); //izquierda
			draw_rectangle(dx+(ds<<1),dy,dx+(ds*3),dy+(ds*3),false); //derecha
			draw_rectangle(dx,dy+(ds<<1),dx+(ds*3),dy+(ds*3),false); //abajo
			
			draw_set_color(c_white);
		
		}
	}
	
	
}
//debug
if(display_info == true)
{
	draw_text(0,0,"X: "+string(x)+"\nY: "+string(y)+"\nCx: "+string(pcx)+"\nCy: "+string(pcy)+"\nFPS "+string(fps)+"\nFPSr "+string(fps_real));
	draw_text(0,64,instance_count);
	draw_text(0,128,"t: "+string(_temperature)+"e: \n"+string(ExtTemperature)+"\nH: "+string(humidity));
}