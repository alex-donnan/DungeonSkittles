draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_alpha(image_alpha);
draw_set_font(f_textbox);
draw_set_color(c_black);
draw_text((bbox_left + bbox_right), (bbox_top + bbox_bottom), text);
draw_set_alpha(1);