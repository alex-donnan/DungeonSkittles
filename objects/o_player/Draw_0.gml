draw_sprite_ext(sp_top, image_index, floor(x), floor(y), 1, 1, image_direction, c_white, 1);
draw_text(x, y-64, rpm);
draw_text(x, y-32, timer / game_get_speed(gamespeed_fps));