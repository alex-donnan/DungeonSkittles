rpm *= 0.95;
accelerate += 1;

while (place_meeting(x, y, o_wall)) {
    x -= lengthdir_x(1, tilt_direction);
    y -= lengthdir_y(1, tilt_direction);
}

tilt_direction += random_range(135, 180) * (spin_direction == 0 ? -1 : 1);
