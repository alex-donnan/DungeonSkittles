if (!active) exit;

camera = view_get_camera(view);

var next_x = ox;
var next_y = oy;

if (!is_null(follow)) {
    next_x = follow.x;
    next_y = follow.y;
}

if (camera_shake > 0) {
    --camera_shake;
    
    next_x += random_range(-4, 4);
    next_y += random_range(-4, 4);
}

x = lerp(x, next_x, 0.3);
y = lerp(y, next_y, 0.3);

camera_set_view_pos(camera, x - width / 2, y - height / 2);