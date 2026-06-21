if (!is_null(follow)) {
    if (camera_shake > 0) {
        --camera_shake;
        
        follow.x += random_range(-8, 8);
        follow.y += random_range(-8, 8);
    }
    
    x = lerp(x, follow.x, 0.3);
    y = lerp(y, follow.y, 0.3);
}