//click izquierdo
var item = inventory[selecteditem][0];
hitanim_tic = 60;


type = -1;
if(item <= 100)//arma/armadura
{
    var type = item mod 10;
    if(type < 6)//arma
    {
		var damadd = (floor((item-type-10)*0.1)-(cooldown*0.1))<<2;
		if damadd < 1 damadd = 1;
	}
}
    with(objHit)
    {
        direction = -objPlayer.cam_yaw;
		speed = 16;
		x = objPlayer.x
		y = objPlayer.y
		activated = true;
		alarm_set(0,4);
        switch(type)
        {
			default://default
				damage = 1;
				axe = 0;
				pic = 0;
			break;
			
            case 0: //lanza
                damage = (damadd<<1)+8;
                objPlayer.cooldown = 4;
				axe = 0;
				pic = 0;
            break;
        
            case 1://espada
                damage = (damadd<<1)+12;
                objPlayer.cooldown = 10;
				axe = 0;
				pic = 0;
            break;
            
            case 2://pico
                damage = (damadd<<1)+4;
                objPlayer.cooldown = 4;
				pic = 0;
				axe = 0;
            break;
            
            case 3://azada
                damage = (damadd<<1)+2;
                objPlayer.cooldown = 2;
				pic = 0;
				axe = 0;
            break;
            
            case 4://hacha
                damage = (damadd<<1)+15;
                objPlayer.cooldown = 45;
				pic = 0;
				axe = 0;
            break;
            
        }
	}