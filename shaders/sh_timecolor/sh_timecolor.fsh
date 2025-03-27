varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 textureColor = texture2D(gm_BaseTexture, v_vTexcoord);
    
    // Apply image_blend color
    vec4 blendedColor = textureColor * v_vColour;

    float modifiedR = blendedColor.r * 0.5;
    float modifiedG = blendedColor.g * 0.5;
    float modifiedB = blendedColor.b * 0.7;

    // Combine modified RGB values with original alpha
    gl_FragColor = vec4(modifiedR, modifiedG, modifiedB, blendedColor.a * v_vColour.a);
}