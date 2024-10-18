shader_type canvas_item;

uniform vec4 color; // Color of the vignette
uniform float radius : hint_range(0.0, 1.0); // Radius of the vignette
uniform float softness : hint_range(0.0, 1.0); // Softness of the vignette

void fragment() {
    vec2 uv = FRAGCOORD.xy / vec2(640, 360); // Normalized coordinates
    float dist = distance(uv, vec2(0.5, 0.5)); // Distance from the center

    float vignette = smoothstep(radius, radius - softness, dist);
    COLOR = mix(color, vec4(1.0), vignette);
}
