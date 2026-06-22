//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;

uniform float start_rpm, half_life, radius, weight, height;
uniform vec2 size;

void main() {
    vec2 max_size = vec2(400, 5000);
    vec2 coord = (v_vTexcoord * max_size);
    
    gl_FragColor = vec4(0.);
    
    float rpm = start_rpm * exp(-coord.x / half_life);
    float critical_rpm = start_rpm * exp(-1.);
    float unstable_rpm = 2. * sqrt(9.81 * (0.001 + (height * height)) * height) / ((weight * radius * radius) / 2.);
    
    // Exponential RPM curve
    if (coord.y <= rpm && coord.y >= rpm - ceil(max_size / size).y) {
        gl_FragColor = vec4(0., 1., 0., 1.);
    }
    
    // Critical RPM
    if (mod((v_vTexcoord * size).x, 3.) < 1.) {
        if (coord.y <= critical_rpm && coord.y >= critical_rpm - ceil(max_size / size).y) { 
            gl_FragColor = vec4(1.);
        }
            
        // Unstable RPM
        if (coord.y <= unstable_rpm && coord.y >= unstable_rpm - ceil(max_size / size).y) {
            gl_FragColor = vec4(1., 0., 0., 1.);
        }
    }
}
