// Crash
crashed = (abs(tilt_amount) > 60);
if (crashed) {
    image_speed = 0;    
    exit;
}

// RPM
timer++;
var t_sec = timer / game_get_speed(gamespeed_fps);
rpm = start_rpm * exp(-t_sec / half_life);

// Check if we're unstable
timer_unstable = (rpm > unstable_rpm) ? timer_unstable++ : 0;

// Update the "tilt" direction
mouse_direction = point_direction(x, y, mouse_x, mouse_y);
tilt_direction = lerp(
    tilt_direction,
    tilt_direction + random_range(-25, 25) + (tilt_amount / 60),
    0.3
);
tilt_direction += lerp(
    angle_difference(tilt_direction + 180, mouse_direction),
    0,
    0.3
) mod 360;
tilt_amount = lerp(
    tilt_amount + random_range(10 * (unstable_rpm / rpm), 10 + 10 * (unstable_rpm / rpm)),
    0,
    0.3 + (0.2 * (weight / 10))
);

// Move speed and bonus acceleration
accelerate = min(2, lerp(accelerate + (tilt_amount / 60), 0, 0.2));
x += lengthdir_x((move_speed + accelerate) * min(1, rpm / critical_rpm), tilt_direction);
y += lengthdir_y((move_speed + accelerate) * min(1, rpm / critical_rpm), tilt_direction);

// Update animation speed and depth
image_speed = max(0.1, rpm / start_rpm);
image_direction = 15 * -dcos(tilt_direction);

depth = -y;