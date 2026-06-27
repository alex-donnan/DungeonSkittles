timer -= 10;
tilt_direction = point_direction(other.x, other.y, x, y);
accelerate += (rpm < unstable_rpm) ? 1 + random(1) : 1;

while (place_meeting(x, y, o_player)) {
    x += lengthdir_x(1, tilt_direction);
    y += lengthdir_y(1, tilt_direction);
    other.x -= lengthdir_x(1, tilt_direction);
    other.y -= lengthdir_y(1, tilt_direction);
}

other.tilt_direction = (tilt_direction + 180) % 360;

bounce = true;