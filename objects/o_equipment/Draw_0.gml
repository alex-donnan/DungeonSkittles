if (!active) exit;
    
hovered = point_in_rectangle(mouse_x, mouse_y, x, y, x + width, y + height);
update = (hovered && mouse_check_button_released(mb_left)) || update;

if (sprite_index == sp_item) {
    draw_sprite_stretched_ext(sp_item_frame, 0, x, y, width, height, c_white, 1);
    
    var item_found = o_control.player_stats.inventory.items[$ string(equip_number)];
    if (!is_null(item_found)) {
        draw_sprite_stretched_ext(item_found.sprite, 0, x + 3, y + 3, width - 6, height - 6, c_white, 1);
    }
} else {
    draw_self();
}