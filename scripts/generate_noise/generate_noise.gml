function generate_noise(_cx, _cy, _seed)
{
	_cx = _cx<<6;
	_cy = _cy<<6;
    var temp = dsin((_cx + _seed * 3.14) * 0.1) * 50 +
               dcos((_cy - _seed * 1.73) * 0.1) * 50 +
               dsin((_cx * 0.05 + _cy * 0.07 + _seed * 2.17)) * 30;

    var hum =  dcos((_cx - _seed * 2.71) * 0.08) * 50 +
               dsin((_cy + _seed * 1.41) * 0.12) * 50 +
               dcos((_cx * 0.06 - _cy * 0.09 + _seed * 3.33)) * 30;

    // Ajustamos los valores para que estén en el rango 0-255
    return [
        clamp(temp + 128, 0, 255), // Temperatura
        clamp(hum + 128, 0, 255)   // Humedad
    ];
}
