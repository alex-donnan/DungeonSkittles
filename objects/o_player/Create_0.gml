timer = 0;
timer_unstable = 0;
start_rpm = rpm;
critical_rpm = start_rpm * exp(-1);

// Unstable RPM
w_kg = weight / 1000;
amiu = (w_kg * power(radius, 2)) / 2;
unstable_rpm = 2 * sqrt(9.81 * (0.001 + power(height, 2)) * height) / amiu;
minimum_rpm = max(15, unstable_rpm / 3);

// Other vars
crashed = false;
image_direction = 0;
mouse_direction = point_direction(x, y, mouse_x, mouse_y);

accelerate = 0;

bounce = false;
airborne = false;