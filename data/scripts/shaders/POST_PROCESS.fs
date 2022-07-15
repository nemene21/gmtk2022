
uniform Image lightImage;

uniform Image vignetteMask;

vec2 screenDimensions = vec2(800, 600);

vec4 effect( vec4 color, Image image, vec2 uvs, vec2 screen_coords )
{

    vec4 px = Texel(image, uvs) * Texel(lightImage, uvs) * Texel(vignetteMask, uvs);

    return px * color;
}