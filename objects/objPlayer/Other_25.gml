//click izquierdo
var damdiv = 1-(cooldown/cooldownmax);
var item = inventory[hotbar[hotbarsel]][0];
hitanim_tic = 60;

//datos defaults
var _pic = 1;
var _axe = 1;
var _damage = 1;
cooldownmax = 3
if(item == 0)
{
    
    _damage = 0.5;
}
else{
    if(item <= 100)//armas/armadura
    {
        var type = item mod 10;
        var tier = (item-type)*0.1;
        if(type <= I_WOODEN_AXE)//arma
        {
    		cooldownmax = w_coold[type];
    		_damage = (w_damage[type]+w_damincrmt[type]*tier)*damdiv;
    		if type == 2 _pic = _damage;
    		if type == 4 _axe = _damage;
    	}
    }
}
cooldown = cooldownmax;
with(objHit)
{
	direction = -objPlayer.cam_yaw;
	speed = 16;
	x = objPlayer.x
	y = objPlayer.y
	activated = true;
	alarm_set(0,4);
	
	damage = _damage;
	pic = _pic;
	axe = _axe;
	//inventory[hotbar[hotbarsel]][1]--;
	//if inventory[hotbar[hotbarsel]][1] > 1 inventory[hotbar[hotbarsel]] = [0,0,0];
}