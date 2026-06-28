mouse_direction = point_direction(WIDTH, HEIGHT, device_mouse_x_to_gui(0), device_mouse_y_to_gui(0));

if (!active) exit;

if (bounce) o_control.dungeon_camera.camera_shake = game_get_speed(gamespeed_fps) * 0.2;
bounce = false;

// Crash
crashed = (abs(tilt_amount) > 60);
if (crashed) {
    image_speed = 0;    
    exit;
}

// RPM
if (!airborne) timer++;
var t_sec = timer / game_get_speed(gamespeed_fps);
rpm = start_rpm * exp(-t_sec / half_life);

// Check if we're unstable
timer_unstable = (rpm > unstable_rpm) ? timer_unstable++ : 0;

// Update the "tilt" direction
tilt_direction = lerp(
    tilt_direction,
    tilt_direction + random_range(-25, 25) + (tilt_amount / 60),
    0.3
) mod 360;

var unstable_mod = 15 * (unstable_rpm / rpm);
tilt_amount = lerp(
    tilt_amount + random_range(unstable_mod, 10 + unstable_mod),
    0,
    0.3
);

// Move speed and bonus acceleration
accelerate = min(5, lerp(accelerate + (tilt_amount / 60), 0, 0.1));
x += lengthdir_x((move_speed + accelerate) * max(0.5, min(1, rpm / 500)), tilt_direction);
y += lengthdir_y((move_speed + accelerate) * max(0.5, min(1, rpm / 500)), tilt_direction);

// Update animation speed and depth
image_speed = min(1, max(0.1, rpm / 60));
image_angle = 10 * -dcos(tilt_direction);

depth = -y;