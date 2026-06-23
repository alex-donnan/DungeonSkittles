if (!active) exit;

if (hovered) {
    if (source_object.height > height) {
        var view_y = view_get_yport(view);
        if (mouse_wheel_up()) {
            view_set_yport(view, max(lerp(view_y, view_y - 48, 0.25), y + height / 2));
        }
        
        if (mouse_wheel_down()) {
            view_set_yport(view, min(lerp(view_y, view_y + 48, 0.25), source_object.y + source_object.height - height / 2));
        }
    }
}