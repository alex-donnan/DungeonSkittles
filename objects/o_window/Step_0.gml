if (!active) exit;

if (source_object.hovered && source_object.height > height) {
    if (mouse_wheel_up()) {
        window_camera.y = max(lerp(window_camera.y, window_camera.y - scroll_dist, 0.5), y + height / 2);
    }
    
    if (mouse_wheel_down()) {
        window_camera.y = min(lerp(window_camera.y, window_camera.y + scroll_dist, 0.5), source_object.y + source_object.height - height / 2);
    }
}