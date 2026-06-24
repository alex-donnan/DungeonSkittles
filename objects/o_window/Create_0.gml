hovered = false;
active = true;
update = false;
width = bbox_right - bbox_left;
height = bbox_bottom - bbox_top;

// CHECK INSTANCE CREATION ORDER BUFFOON
source_object = undefined;
with (o_window_source) {
    if (string_starts_with(name, other.name)) {
        other.source_object = self;
    }
}
if (is_null(source_object)) {
    instance_destroy(self);
} else {
    window_surface = undefined;
    window_camera = instance_create_depth(
        source_object.x + width / 2, source_object.y + height / 2, 0,
        o_camera,
        {
            width,
            height,
            view
        }
    );
}