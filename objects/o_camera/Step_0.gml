if (!is_null(follow)) {
    if (camera_shake > 0) {
        --camera_shake;
        
        follow.x += random_range(-8, 8);
        follow.y += random_range(-8, 8);
    }
    
    x = lerp(x, follow.x, 0.3);
    y = lerp(y, follow.y, 0.3);
}

matrix_build_lookat(x, y, 1, x, y, 0, 0, 1, 0, view_mat);
matrix_build_projection_ortho(-width, height, 0, 100, proj_mat);
camera_set_view_mat(camera, view_mat);
camera_set_proj_mat(camera, proj_mat);