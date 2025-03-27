function buffer_read_hex(buffer) {
    var packed = buffer_read(buffer,buffer_u8);
    var num1 = (packed >> 4) & $F;
    var num2 = packed & $F;
    return [num1, num2];
}