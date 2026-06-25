image_speed = 0;
image_index = irandom_range(0,sprite_get_number(sprite_index));

image_xscale = point_distance(x, y, to_x, to_y) / sprite_get_width(sprite_index);
image_angle = point_direction(x, y, to_x, to_y);

call_later(
    0.2,
    time_source_units_seconds,
    function() {
        instance_destroy(self);
    }
)