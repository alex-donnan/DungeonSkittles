//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;

uniform float start_rpm, half_life, radius, weight, height;
uniform vec2 size;

void main() {
    vec2 coord = floor(v_vTexcoord * size);
    float max_y = start_rpm * 1.2;
    float max_x = half_life * 2.;
    
    gl_FragColor = vec4(0., 0., 0., 1.);
    
    float rpm = start_rpm * exp(-coord.x / half_life);
    float critical_rpm = start_rpm * exp(-1.);
    float unstable_rpm = 2. * sqrt(9.81 * (0.001 + (height * height)) * height) / ((weight * radius * radius) / 2.);
    
    // Exponential RPM curve
    if (coord.y - rpm < 1.) {
        gl_FragColor = vec4(0., 1., 0., 1.);
    }
    
    // Critical RPM
    if (coord.y - critical_rpm < 1. && mod(coord.x, 4.) < 2.) {
        gl_FragColor = vec4(1.);
    }
        
    // Unstable RPM
    if (coord.y - unstable_rpm < 1. && mod(coord.x, 4.) > 1.) {
        gl_FragColor = vec4(1., 0., 0., 1.);
    }
}
