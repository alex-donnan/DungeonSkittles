if (!active) {
    draw_sprite_ext(sprite_index, 0, x, y, 1, 1, 0, c_white, 0.8);
    draw_arrow(x, y, x + lengthdir_x(32, mouse_direction), y + lengthdir_y(32, mouse_direction), 8);
} else {
    draw_sprite(sp_shadow, 0, x, y);
    draw_self();
}