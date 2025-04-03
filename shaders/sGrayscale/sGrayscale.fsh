varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    // Obtener el color del fragmento actual
    vec4 color = texture2D(gm_BaseTexture, v_vTexcoord);

    // Intercambiar el canal rojo con el azul
    gl_FragColor = vec4(color.g, color.g, color.g, color.a) * v_vColour;
}