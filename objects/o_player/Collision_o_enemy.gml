timer += (rpm < unstable_rpm) ? 20 + random(60) : 20;
accelerate += (rpm < unstable_rpm) ? 1 + random(1) : 1;

while (place_meeting(x, y, o_enemy)) {
    x -= lengthdir_x(1, tilt_direction);
    y -= lengthdir_y(1, tilt_direction);
}

var col_dir = ((tilt_direction + 27.5) div 45) * 45;
var x_pos = dcos(tilt_direction);
var y_pos = -dsin(tilt_direction);

if (col_dir == 0 || col_dir == 180) {
    x_pos *= -1;
} else if (col_dir == 90 || col_dir == 270) {
    y_pos *= -1;
} else if (col_dir == 135 || col_dir = 315) {
    var sign_mod = (sign(x_pos) == sign(y_pos)) ? 1 : -1;
    x_pos = dsin(tilt_direction) * sign_mod;
    y_pos = dcos(tilt_direction) * sign_mod;
} else {
    var sign_mod = (sign(x_pos) != sign(y_pos)) ? 1 : -1;
    x_pos = dsin(tilt_direction) * sign_mod;
    y_pos = dcos(tilt_direction) * sign_mod;
}
tilt_direction = point_direction(0, 0, x_pos, y_pos);

other.armor--;

bounce = true;