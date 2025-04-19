//cambiar el nombre
state = !state;
_state = 2;
if(state)
{
    keyboard_string = "";
    keyboard_virtual_show(kbv_type_default,kbv_returnkey_default,kbv_autocapitalize_words,false);
    button[0][5] = "";
    
}
else {
    global.worldname = keyboard_string;
    keyboard_string = "";
    button[0][5] = "World name: "+string(global.worldname);
    button[0][1] = string_length(button[0][5]);
}
