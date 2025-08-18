shader_type canvas_item;

uniform vec4 bottom_color = vec4(0.4, 0.7, 1.0, 1.0); // ground
uniform vec4 top_color = vec4(0.0, 0.0, 0.05, 1.0); // space

void fragment() {
    float t = SCREEN_UV.y;
    COLOR = mix(top_color, bottom_color, t);
}
