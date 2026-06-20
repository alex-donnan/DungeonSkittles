timer++;
y_draw = 4 * dsin(timer);

if (point_distance(x, y, o_player.x, o_player.y) < 32) {
    direction = point_direction(x, y, o_player.x, o_player.y);
    move_speed += 0.5;
} else {
    

depth = -y;