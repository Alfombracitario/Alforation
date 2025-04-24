attribute vec3 in_Position;
attribute vec4 in_Colour;
attribute vec2 in_TextureCoord;

uniform float _s_tw;
uniform float _c_tw;
uniform float _s_8;
uniform float _c_8;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main() {
    // Convertimos alpha a un número de 0 a 3
    int mode = int(in_Colour.a * 10.0 + 0.5);

    // Calculamos los desplazamientos
    float dx = 0.0;
    float dy = 0.0;
	if(mode >= 2)//si es un árbol
	{
		if(mode == 2)//izquierda
		{
			dx = + _c_tw;
	        dy = + _s_tw;
		}
		else//derecha
		{
	        dx = - _c_tw;
	        dy = - _s_tw;
		}
	}
	else
	{//No es un arbol lol
		if(mode == 0)//izquierda
		{
			dx = + _c_8;
	        dy = + _s_8;
		}
		else//derecha
		{
	        dx = - _c_8;
	        dy = - _s_8;
		}
	}
    vec4 object_space_pos = vec4(in_Position.xy + vec2(dx, dy), in_Position.z, 1.0);

    gl_Position = gm_Matrices[MATRIX_PROJECTION] * (gm_Matrices[MATRIX_VIEW] * object_space_pos);

    v_vColour = vec4(in_Colour.rgb, 1.0); // Forzamos alpha final en 1.0
    v_vTexcoord = in_TextureCoord;
}
