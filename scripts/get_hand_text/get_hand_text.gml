function get_hand_text(){
    hand_text_tic = 1;
    hand_text = "";
    var item = inventory[hotbar[hotbarsel]][0];
    if(item == 0) exit;
    if(item < I_STICK)
    {
        var type = item mod 10;
        var tier = ((item-type)*0.1)<<0;
        
        var names = ["Spear","Sword","Picaxe","Hoe","Axe","Helmet","Chestplate","Leggings","Boots","You shouldn't have this item"];
        var namestier = ["Wooden ","Stone ","Tin ","Copper ","Bronze ","Iron ", "Lead ","Tugnsten ","Ruby ","Diamond "];
        
        if(item < I_TIN_SPEAR && type > I_WOODEN_AXE)
        {
            names = ["Spear","Sword","Picaxe","Hoe","Axe","Hat","Shirt","Pants","Shoes","You shouldn't have this item"];
            namestier = ["Cotton ","Leather ","Tin ","Copper ","Bronze ","Iron ", "Lead ","Tugnsten ","Ruby ","Diamond "];
        
        }
        hand_text = namestier[tier]+names[type];
        if type <= I_WOODEN_AXE hand_text+=" (+"+string(w_damage[type]+w_damincrmt[type]*tier)+")";
    }
    else {//alguien día alguien verá este código y vomitará
    	var names = ["Stick","Black Stick","Tin ore","Copper ore","Gold ore","Iron ore","Coal ore","Tungsten ore","Amethyst",
        "Gold ingot","Log","Stone","Tin ingot","Copper ingot","Bronze ingot","Iron ingot","Lead ingot","Tungsten ingot","Ruby","Diamond",
        "Seeds","Wheat","Cotton","Cotton seeds","","","","Red mushroom","Brown mushroom","Corruped mushroom","Bread","Raw meat","Meat","Watermelon",
        "","","","","","","Leather","Bone","Slime","","","","","","","","Stone block","Wooden block"];
        hand_text = names[item-100];
    }
}