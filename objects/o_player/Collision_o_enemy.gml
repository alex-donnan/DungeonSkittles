rpm *= 0.9;
tilt_direction = point_direction(other.x, other.y, x, y);
accelerate += 1;

while (place_meeting(x, y, o_enemy)) {
    x += lengthdir_x(1, tilt_direction);
    y += lengthdir_y(1, tilt_direction);
}

other.armor--;