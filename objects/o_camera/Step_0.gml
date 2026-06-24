camera = view_get_camera(view);

var next_x = x;
var next_y = y;

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

matrix_build_lookat(x, y, 1, x, y, 0, 0, 1, 0, view_mat);
matrix_build_projection_ortho(-width, height, 0, 10000, proj_mat);
camera_set_view_mat(camera, view_mat);
camera_set_proj_mat(camera, proj_mat);