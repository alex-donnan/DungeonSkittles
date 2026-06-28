while (place_meeting(x, y, o_artifact)) {
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

bounce = true;

var item = o_control.items[$ other.item_name];
if (!is_null(item)) {
    item.discovered = true;
    o_control.menus[$ "dungeon_menu"].animate("found_item");
    call_later(
        5,
        time_source_units_seconds,
        function() {
            o_control.menus[$ "dungeon_menu"].animate("close_found_item");
        }
    );
    instance_destroy(other);
}