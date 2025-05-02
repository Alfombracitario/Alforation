function normalize_value(value, minimo = -127, maximo = 128) {
    return (value - minimo) / (maximo - minimo);
}
