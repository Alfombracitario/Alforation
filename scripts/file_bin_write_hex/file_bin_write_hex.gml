function buffer_write_hex(buffer, num1, num2) {
    num1 = clamp(floor(num1), 0, 15);
    num2 = clamp(floor(num2), 0, 15);
    var packed = (num1 << 4) | num2;
    buffer_write(buffer, buffer_u8,packed);
}