if (armor == 0) {
    var gem_count = irandom_range(start_armor, start_armor * 2);
    repeat(gem_count) {
        instance_create_depth(
            x, y, 0,
            o_gem,
            {
                direction: random(360),
                move_speed: random_range(8, 16)
            }
        );
    }
    instance_destroy(self);
}