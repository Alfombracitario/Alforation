//click izquierdo
var item = inventory[selecteditem][0];
hitanim_tic = 60;
if(item >= 10 && item <= 110)//arma/armadura
{
    var type = item mod 10;
    if(type < 6)//arma
    {
    var damadd = (floor((item-type-10)*0.1)-(cooldown*0.1))<<2;
	if damadd < 1 damadd = 1;
	
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
            case 0: //lanza
                damage = damadd+8;
                objPlayer.cooldown = 5;
            break;
        
            case 1://espada
                damage = damadd+12;
                objPlayer.cooldown = 10;
            break;
            
            case 2://pico
                damage = damadd+4;
                objPlayer.cooldown = 3;
            break;
            
            case 3://azada
                damage = damadd+2;
                objPlayer.cooldown = 1;
            break;
            
            case 4://hacha
                damage = damadd+15;
                objPlayer.cooldown = 45;
            break;
            
        }
    }
    }
	    else//armadura
	    {
	        //lol
	    }
}