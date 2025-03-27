function hex_to_dec(hex_string) {
    var result = 0;
    var length = string_length(hex_string);
    var i, digit;
    
    for (i = 0; i < length; i++) {
        digit = string_char_at(hex_string, length - i); // Obtener el carácter actual
        digit = string_upper(digit); // Convertir a mayúscula para manejar letras minúsculas
        
        if (digit >= "0" && digit <= "9") {
            digit = real(digit); // Convertir caracteres '0'-'9' a su valor numérico
        } else if (digit >= "A" && digit <= "F") {
            digit = ord(digit) - ord("A") + 10; // Convertir caracteres 'A'-'F' a su valor numérico
        } else {
            show_error("Unvalid HEX value: " + hex_string, true);
        }
        
        result += digit * power(16, i); // Sumar el valor de la posición actual al total
    }
    
    return result;
}
