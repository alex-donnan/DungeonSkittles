draw_sprite_ext(sp_shadow, 0, x, y, 0.5, 0.5, 0, c_white, draw_alpha);
draw_sprite_ext(
    sprite_index, image_index,
    x, y - 8 + draw_y,
    draw_scale, draw_scale,
    0, c_white, draw_alpha
);