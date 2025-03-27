function file_bin_write_hex(file, num1, num2) {
    num1 = clamp(floor(num1), 0, 15);
    num2 = clamp(floor(num2), 0, 15);
    var packed = (num1 << 4) | num2;
    file_bin_write_byte(file, packed);
}