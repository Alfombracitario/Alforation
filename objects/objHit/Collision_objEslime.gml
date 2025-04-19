if(activated == true)
{
	other.hp-=damage;
	other.knockspd = -4;
    with(objPlayer) damage_hand_item(1);
}