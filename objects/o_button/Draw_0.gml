if (!active) exit;
    
pressed = (hovered && mouse_check_button(mb_left));
update = (hovered && mouse_check_button_released(mb_left));
if (sprite_index != sp_button) {
    draw_sprite_stretched_ext(sprite_index, hovered + pressed, x, y, width, height, c_white, image_alpha);
} else {
    draw_sprite_stretched_ext(sprite_index, 0, x, y, width, height, c_white, image_alpha);
}