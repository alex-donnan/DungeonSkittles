if (!active) exit;

if (sprite_index != sp_window_source) { 
    draw_sprite_stretched_ext(sprite_index, 0, x, y, width, height, c_white, image_alpha);
}