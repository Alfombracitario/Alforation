function hex_to_dec_one(input) {
	
		var digit = input
        digit = string_upper(digit); // Convertir a mayúscula para manejar letras minúsculas
        
        if (digit >= "0" && digit <= "9") {
            digit = real(digit); // Convertir caracteres '0'-'9' a su valor numérico
        } else if (digit >= "A" && digit <= "F") {
            digit = ord(digit) - ord("A") + 10; // Convertir caracteres 'A'-'F' a su valor numérico
        } else {
            show_debug_message("ERROR: Invalid Hex value: "+string(digit));
        }
    return digit;
}
