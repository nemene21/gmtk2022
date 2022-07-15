
float directions = 12.0;
float quality = 2.0;
float radius = 0.006;

float PI2 = 6.2831;

float iterations = directions * quality * 2;

vec4 effect( vec4 color, Image image, vec2 uvs, vec2 screen_coords )
{
    vec4 blur = Texel(image, uvs);

    float angle = PI2 / directions;
    float qualityDiv = 1.0 / quality;

    for (float directionOn = 0.0; directionOn < PI2; directionOn += angle) {

        for (float i = qualityDiv; i < quality; i += qualityDiv) {

            blur += Texel(image, uvs + vec2(cos(directionOn), sin(directionOn)) * radius * i);

        }

    }

    blur /= iterations;

    blur.a = 0.5;

    return blur;
}