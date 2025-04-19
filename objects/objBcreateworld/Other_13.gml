//cambiar la seed
state = !state;
_state = 3;
if(state)
{
    keyboard_string = "";
    keyboard_virtual_show(kbv_type_default,kbv_returnkey_default,kbv_autocapitalize_words,false);
    button[1][5] = "";
    
}
else {
    global.seed = keyboard_string;
    keyboard_string = "";
    button[1][5] = "Seed: "+global.seed;
    button[1][1] = string_length(button[1][5]);
    global.seed = string_to_number(global.seed);
}
