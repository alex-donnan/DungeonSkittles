hovered = false;
active = true;
update = false;

// CHECK INSTANCE CREATION ORDER BUFFOON
source_object = undefined;
with (o_scroll_window_source) {
    if (name == $"{other.name}_source") {
        other.source_object = self;
    }
}
width = bbox_right - bbox_left;
height = bbox_bottom - bbox_top;

window_surface = surface_create(width, height);
view_set_surface_id(view, window_surface);