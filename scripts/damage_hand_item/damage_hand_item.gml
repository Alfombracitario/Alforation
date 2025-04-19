function damage_hand_item(_count){
//para ahorrar recursos debes ejecutar esto with(objPlayer) de fuera del script!
var _item = inventory[hotbar[hotbarsel]][0];
if(_item < 100)//si es un arma
{
    inventory[hotbar[hotbarsel]][1] -= _count;
    if(inventory[hotbar[hotbarsel]][1] < 1)//se rompió el item
    {
         inventory[hotbar[hotbarsel]] = [0,0,0];
    } 
}
}