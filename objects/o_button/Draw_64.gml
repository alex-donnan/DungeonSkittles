if (!active) exit;
  
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_alpha(image_alpha);
draw_set_font(f_textbox);
draw_set_color(c_black);
if (view == -1) {
    draw_text((x + width / 2) * 2, (y + height / 2) * 2, text);
} else {
    draw_text_ext(
        (camera_get_view_x(view_get_camera(view)) + view_get_xport(view) + width / 2) * 2,
        (camera_get_view_y(view_get_camera(view)) + view_get_yport(view) + height / 2) * 2,
        text,
        14,
        width * 1.8
    );
}
draw_set_alpha(1);