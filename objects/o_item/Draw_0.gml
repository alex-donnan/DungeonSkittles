if (!active) exit;
    
hovered = point_in_rectangle(mouse_x, mouse_y, x, y, x + width, y + height);

draw_sprite_stretched_ext(sp_item_frame, 0, x, y, width, height, c_white, (hovered) ? 0.5 : 1);
draw_sprite_stretched_ext(sprite_index, 0, x + 3, y + 3, width - 6, height - 6, c_white, (hovered) ? 0.5 : 1);
