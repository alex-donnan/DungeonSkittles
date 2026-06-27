if (!active) exit;
  
draw_set_halign(halign);
draw_set_valign(valign);
draw_set_alpha(image_alpha);
draw_set_font(f_textbox);
draw_set_color(c_black);
if (view == -1) {
    // Non camera
    draw_text_ext(
        (x + width / 2) * 2, (y + height / 2) * 2,
        text,
        14,
        width * 1.8
    );
} else {
    // Camera
    draw_text_ext(
        view_get_xport(view) * 2 + ((x + width / 2) - camera_get_view_x(view_get_camera(view))) * 2,
        view_get_yport(view) * 2 + ((y + height / 2) - camera_get_view_y(view_get_camera(view))) * 2,
        text,
        14,
        width * 1.8
    );
}
draw_set_alpha(1);