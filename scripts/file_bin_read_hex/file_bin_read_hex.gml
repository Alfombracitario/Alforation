function file_bin_read_hex(file) {
    var packed = file_bin_read_byte(file);
    var num1 = (packed >> 4) & $F;
    var num2 = packed & $F;
    return [num1, num2];
}