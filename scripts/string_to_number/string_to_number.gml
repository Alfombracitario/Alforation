/// @function string_to_number(str)
/// @param str La cadena que se convertirá a número
/// @returns Un número generado desde el string

function string_to_number(str) {
    var result = 0;
    var len = string_length(str);
    
    for (var i = 1; i <= len; i++) {
        var char = string_char_at(str, i);
        var val = ord(char); // Convierte el carácter a su código ASCII
        result = (result * 31 + val) mod 2147483647; // Acumulador tipo hash
    }
    
    return result;
}
