shader_type canvas_item;

// Varying allows us to pass coordinate data safely between functions
varying vec2 local_pixel_pos;

void vertex() {
    // Capture the absolute local pixel positions (e.g. 0 to 16384)
    local_pixel_pos = VERTEX;
}

void fragment() {
    // 1. Maintain clean pattern tiling using standard UV scales
    vec2 tiled_uv = fract(UV * 2.0);
    vec4 tex_color = texture(TEXTURE, tiled_uv);
        vec2 center_pixel = vec2(8192.0, 8192.0);
    float hole_half_size = 5461.33 / 2.0;
    
    if (abs(local_pixel_pos.x - center_pixel.x) < hole_half_size && 
        abs(local_pixel_pos.y - center_pixel.y) < hole_half_size) {
        discard;
    }
    
    COLOR = tex_color;
}
