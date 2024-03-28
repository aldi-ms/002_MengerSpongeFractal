shader_type spatial;
render_mode unshaded;

uniform vec4 outline_color;

void fragment() {
    ALBEDO = outline_color.rgb;
}

