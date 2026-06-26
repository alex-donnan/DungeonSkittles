if (!active) exit;
    
update = (hovered && mouse_check_button_released(mb_left));
draw_sprite_stretched_ext(sprite_index, 0, x, y, width, height, c_white, image_alpha * ((hovered) ? 0.5 : 1));