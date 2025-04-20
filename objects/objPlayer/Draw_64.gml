gpu_set_ztestenable(false);
gpu_set_fog(false,0,0,0);

//dibujar la pantalla
if(global.hd)
{
    var grh;
    if(camz <= 0.03) grh = (gh>>1)-(gh*(camz-0.05)) else grh = gh>>1;
    draw_rectangle_color(0,0,gw,grh,sky_color,sky_color,fog_color,fog_color,false);//gradiente
    draw_set_color(fog_color);
    draw_rectangle(0,grh,gw,gh,false);
    draw_set_color(c_white);
}
else {
    draw_set_color(fog_color);
    draw_rectangle(0,0,gw,gh,false);
    draw_set_color(c_white);
}
//dibujar la pantalla a resolución completa
draw_surface_stretched_ext(application_surface,0,0,gw,gh,timecolor,1);

draw_sprite_ext(sprCompass,cam_yaw*0.0888888888888889,gw,gh,2,2,0,c_white,1);

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
if(inventory[hotbar[hotbarsel]][0] != 0)//item en la mano
{
    var hix = (gw * 0.72) + (sin(sway_x *0.1) * sway_amount * 8 * weapon_swaying)
    var hiy = gh-116+(sin(sway_y *0.1) + 1) * sway_amount * 2 * weapon_swaying + weapon_y+(cooldown<<2)
    var angle = 12
    if(global.hd)
    {
    	var scale, _color, color, _index, _color1, _color2;
    		_index = abs(((((_time)+cam_yaw+90) mod 360)/180)-1);
    		_color1 = merge_color($666666,timecolor-$444444,1-_index);
    		_color2 = merge_color($666666,timecolor-$444444,_index);
    		_color = merge_color(timecolor,$666666,_index);
    	if(inventory[hotbar[hotbarsel]][0] < 100)
    	{
    		angle = 24;
    		hiy += 16;
    		for(var i = 0.5; i <8; i+=0.5)//armas
    		{
    			
    			color = merge_color(_color1,_color2,1-i*0.125);
    			scale = 7.5+(i*0.1);
    			draw_sprite_ext(sprItems,inventory[hotbar[hotbarsel]][0],hix-i*0.5,hiy+(i*0.5),scale,scale,angle,color,1);
    		}
    		//obtener los datos para la luz
    		
    		draw_sprite_ext(sprItems,inventory[hotbar[hotbarsel]][0],hix-4,hiy+4,8.3,8.3,angle,_color,1);
    	}
    	else
    	{
    		for(var i = 0.5; i <8; i+=0.5)
    		{
    			color = merge_color(_color1,_color2,1-i*0.125);
    			scale = 7.5+(i*0.1);
    			draw_sprite_ext(sprItems,inventory[hotbar[hotbarsel]][0],hix-i,hiy-i,scale,scale,angle,color,1);
    		}
    		draw_sprite_ext(sprItems,inventory[hotbar[hotbarsel]][0],hix-8,hiy-8,8.3,8.3,angle,_color,1);
    	}
    }
    else {
    
        draw_sprite_ext(sprItems,inventory[hotbar[hotbarsel]][0],hix-4,hiy+4,8.3,8.3,angle,c_white,1);
    }
}
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

//barra de xp
var xp = experience/xp_need;
var color = merge_color($FF7f00,$00FF70,xp);
draw_sprite_ext(sprBar,1,0,20,8.2,0.8,0,color,1);
draw_sprite_ext(sprBar,0,0,20,xp*8.2,0.8,0,color,1);
draw_set_font(global.font);
draw_text(0,20,level);
draw_set_font(global.font2);

//temperatura
color = merge_color($FF0000,$0000FF,ExtTemperature/255);
draw_sprite_ext(sprTemperature,0,82,0,1,1,0,color,1);
color = merge_color($FF0000,$0000FF,_temperature/255);
draw_sprite_ext(sprTemperature,1,82,0,1,1,0,color,1);

//hotbar
var _scl = (hotbarsize*0.8)+0.3;
var _hbx = hotbarx+(gw>>1)-_scl*10
draw_sprite_ext(sprHotbar,0,_hbx,gh-24,_scl,1.1,0,c_white,1);
draw_sprite_ext(sprSlot,0,_hbx+3,gh-21,hotbarsize,1,0,c_white,1);
draw_sprite(sprInvselected,0,_hbx+3+(hotbarsel<<4),gh-21);
for(var i = 0; i<hotbarsize;i++)
{
    draw_item_sprite(3+_hbx+(i<<4),gh-21,inventory[hotbar[i]][0],inventory[hotbar[i]][1]);
}


#region inventory
if(invopen)
{
	//crafteo
	draw_sprite_ext(sprContainer,0,craftx-5,crafty-16,11,9,0,c_white,1);
	draw_sprite_ext(sprSlot,0,craftx,crafty,3,1,0,c_white,1);
    
	for(var i = 0; i<3; i++)//dibujar los items del crafting grid
	{
        draw_item_sprite(craftx+(i<<4),crafty,crafting_grid[i][0],crafting_grid[i][1]);
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
        draw_item_sprite(_x,_y,craftable[i][0],craftable[i][1]);
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
	
	for (var i = 0; i < rows; i++) {
		for (var j = 0; j < 10; j++) {
			
			var _slot = j+(10*i);
            draw_item_sprite(invx+(j<<4),invy+(i<<4),inventory[_slot][0],inventory[_slot][1]);
		}
	}	
	
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
        draw_item_sprite(invmousex,invmousey,selector[0],selector[1],1);
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
            var _a = 0.5;
			draw_sprite_ext(sprAndroidbuttons,0,dx,dy,bs,bs,0,c_white,_a);
			draw_sprite_ext(sprAndroidbuttons,1,dx+ds,dy,bs,bs,0,c_white,_a);
			draw_sprite_ext(sprAndroidbuttons,2,dx+(ds<<1),dy,bs,bs,0,c_white,_a);
			
			draw_sprite_ext(sprAndroidbuttons,3,dx,dy+ds,bs,bs,0,c_white,_a);
			
			draw_sprite_ext(sprAndroidbuttons,5,dx+(ds<<1),dy+ds,bs,bs,0,c_white,_a);
			
			draw_sprite_ext(sprAndroidbuttons,6,dx,dy+(ds<<1),bs,bs,0,c_white,_a);
			draw_sprite_ext(sprAndroidbuttons,7,dx+ds,dy+(ds<<1),bs,bs,0,c_white,_a);
			draw_sprite_ext(sprAndroidbuttons,8,dx+(ds<<1),dy+(ds<<1),bs,bs,0,c_white,_a);
			
			draw_sprite_ext(sprAndroidbuttons,9,bax,bay,bs,bs,0,c_white,_a);
			draw_sprite_ext(sprAndroidbuttons,10,bbx,bby,bs,bs,0,c_white,_a);
			draw_sprite_ext(sprAndroidbuttons,11,bix,biy,bs,bs,0,c_white,_a);
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