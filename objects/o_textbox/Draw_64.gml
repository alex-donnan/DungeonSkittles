if (!active) exit;
  
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_alpha(image_alpha);
draw_set_font(f_textbox);
draw_set_color(c_black);
if (view == -1) {
    draw_text((bbox_left + bbox_right), (bbox_top + bbox_bottom), text);
} else {
    draw_text_ext(
        view_get_xport(view) * 2 + ((bbox_left + bbox_right) / 2 - camera_get_view_x(view_get_camera(view))) * 2,
        view_get_yport(view) * 2 + ((bbox_top + bbox_bottom) / 2 - camera_get_view_y(view_get_camera(view))) * 2,
        text,
        14,
        width * 1.8
    );
}
draw_set_alpha(1);