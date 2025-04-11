gpu_set_ztestenable(false);
gpu_set_fog(false,0,0,0);
if(added_tic > 0)
{
	var _y = 24
	if(added_tic < _y)
	{
		_y = added_tic
	}
	added_tic--;
	draw_sprite_ext(sprTransparentuitriangleleft,0,gw,_y-24,3,1,0,$FFFFFF,1);
	draw_sprite_ext(sprItems,added_item,gw-23,_y-23,1,1,0,c_black,0.5);
	draw_sprite(sprItems,added_item,gw-24,_y-24);
	draw_set_halign(fa_right);
	draw_text_shadow(gw-26,_y-18,"+"+string(added_count),1);
	draw_set_halign(fa_left);
}
if(notday) //día y noche
{
	var lay_id = layer_get_id("Background");
	var back_id = layer_background_get_id(lay_id);
	layer_background_blend(back_id, fog_color);
	
	display_set_gui_size(w_width<<global.screendiv,w_height<<global.screendiv);
	draw_surface_ext(application_surface,0,0,1,1,0,timecolor,1);
	display_set_gui_size(gw,gh);
	shader_reset();
}

draw_sprite_ext(
    sprItems,
	inventory[hotbar[hotbarsel]][0],
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

//hotbar
var _scl = (hotbarsize*0.8)+0.3;
var _hbx = hotbarx+(gw>>1)-_scl*10
draw_sprite_ext(sprHotbar,0,_hbx,gh-24,_scl,1.1,0,c_white,1);
draw_sprite_ext(sprSlot,0,_hbx+3,gh-21,hotbarsize,1,0,c_white,1);
draw_sprite(sprInvselected,0,_hbx+3+(hotbarsel<<4),gh-21);
for(var i = 0; i<hotbarsize;i++)
{
	draw_sprite(sprItems,inventory[hotbar[i]][0],3+_hbx+(i<<4),gh-21);
	if inventory[hotbar[i]][1] > 1 draw_text(3+_hbx+(i<<4),gh-21,inventory[hotbar[i]][1]);
}


#region inventory
if(invopen)
{
	//crafteo
	draw_sprite_ext(sprContainer,0,craftx-5,crafty-16,11,9,0,c_white,1);
	draw_sprite_ext(sprSlot,0,craftx,crafty,3,1,0,c_white,1);
	for(var i = 0; i<3; i++)//dibujar los items
	{
		var _x = craftx+(i<<4);
		draw_sprite(sprItems,crafting_grid[i][0],_x,crafty);
		if crafting_grid[i][1] > 1 draw_text(_x,crafty,crafting_grid[i][1]);
	}
	var craftp80 = craftx+80
	draw_sprite(sprArrowright,0,craftx+52,crafty);
	draw_sprite(sprSlot,0,craftp80,crafty);
	draw_sprite(sprItems,craftresult[0],craftp80,crafty);
	draw_text(craftp80,crafty,craftresult[2]);
	
	var _crftc = array_length(craftable)
	for(var i = 0; i<_crftc; i++)
	{
		var _x = craftx+(i<<4);
		var _y = crafty+24;
		
		draw_sprite(sprSlot,0,_x,_y);
		draw_sprite(sprItems,craftable[i][0],_x,_y)
		draw_text(_x,_y,craftable[i][1]);
	}
	draw_text_shadow(craftx,crafty-10,"Crafting");
	
	
	
	
	//inventario
	draw_sprite_ext(sprContainer,0,invx-5,invy-16,17,9,0,c_white,1); //contorno
	draw_sprite_ext(sprSlot,0,invx,invy,10,4,0,c_white,1);
	draw_text_shadow(invx,invy-10,"inventory");
	
	var rows = invsize*0.1;
	draw_sprite(sprInvselected,0
	,invx+((selecteditem mod 10)<<4)
	,invy+(floor(selecteditem*0.1)<<4)
	);
	
	
	
	draw_set_halign(fa_right);
	for (var i = 0; i < rows; i++) {
		for (var j = 0; j < 10; j++) {
			
			var _slot = j+(10*i);
			var _sx = invx+(j<<4);
			var _sy = invy+(i<<4);
			draw_sprite(sprItems,inventory[_slot][0],_sx,_sy);
			if(inventory[_slot][0] <= 99 && inventory[_slot][0] > 0)
			{
				_tier = floor(inventory[_slot][0]*0.1)
				draw_sprite_ext(sprPixel,0,_sx,_sy,2,(inventory[_slot][1]/w_dur[_tier])*16,0,c_lime,1);
				
			}
			else
			{
				if (inventory[_slot][1] > 1)
				{
					draw_text(_sx+16,_sy+8,inventory[_slot][1]);
				}
			}
		}
	}	
	
	draw_set_halign(fa_left);
	if(gamepad_is_connected(0))
	{
		if(selector[0] == 0)
		{
			draw_sprite(sprMouse,0,invmousex,invmousey);
		}
		//draw_sprite(sprGamepadbuttons
	}
	if(selector[0] != 0)//dibujar el item que se está moviendo
	{
		draw_sprite(sprItems,selector[0],invmousex,invmousey);
		if selector[1] > 1 draw_text(invmousex,invmousey,selector[1]);
		
	}
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
			var bs = ds*0.05;
			var bax = gw*buttonax;
			var bay = gw*buttonay;
			var bbx = gw*buttonbx;
			var bby = gw*buttonby;
			var bix = gw*buttonix;
			var biy = gw*buttoniy;
			
			draw_sprite_ext(sprAndroidbuttons,0,dx,dy,bs,bs,0,c_white,1);
			draw_sprite_ext(sprAndroidbuttons,1,dx+ds,dy,bs,bs,0,c_white,1);
			draw_sprite_ext(sprAndroidbuttons,2,dx+(ds<<1),dy,bs,bs,0,c_white,1);
			
			draw_sprite_ext(sprAndroidbuttons,3,dx,dy+ds,bs,bs,0,c_white,1);
			
			draw_sprite_ext(sprAndroidbuttons,5,dx+(ds<<1),dy+ds,bs,bs,0,c_white,1);
			
			draw_sprite_ext(sprAndroidbuttons,6,dx,dy+(ds<<1),bs,bs,0,c_white,1);
			draw_sprite_ext(sprAndroidbuttons,7,dx+ds,dy+(ds<<1),bs,bs,0,c_white,1);
			draw_sprite_ext(sprAndroidbuttons,8,dx+(ds<<1),dy+(ds<<1),bs,bs,0,c_white,1);
			
			draw_sprite_ext(sprAndroidbuttons,9,bax,bay,bs,bs,0,c_white,1-cooldown/cooldownmax);
			draw_sprite_ext(sprAndroidbuttons,10,bbx,bby,bs,bs,0,c_white,1);
			draw_sprite_ext(sprAndroidbuttons,11,bix,biy,bs,bs,0,c_white,1);
		}
	}
	//global, out the inventory
	draw_sprite_ext(sprCrosshair,1,(gw>>1)+0.5,(gh>>1)+0.5,1,1,0,c_white,1-(cooldown/cooldownmax));
}
//debug
if(display_info == true)
{
	draw_text(0,0,"X: "+string(x)+"\nY: "+string(y)+"\nCx: "+string(pcx)+"\nCy: "+string(pcy)+"\nFPS "+string(fps)+"\nFPSr "+string(fps_real));
	draw_text(0,64,instance_count);
}
gpu_set_ztestenable(true);