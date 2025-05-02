attribute vec3 in_Position;                  // (x,y,z)
attribute vec3 in_Normal;                    // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

uniform vec2 _t; //x = s, y = c

varying float v_LightDepth;

void main() {
	
	float a = -floor((in_Colour.a - 0.5) * 255.0);

    float dx = _t.y * a;
    float dy = _t.x * a;

    vec4 object_space_pos = vec4(in_Position.xy + vec2(dx, dy), in_Position.z, 1.0);
	
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    v_LightDepth = gl_Position.z / gl_Position.w;
}