if (!active) exit;
  
start_rpm = lerp(start_rpm, o_control.player_stats.start_rpm, 0.1);
half_life = lerp(half_life, o_control.player_stats.half_life, 0.1);
radius = lerp(radius, o_control.player_stats.radius, 0.1);
weight = lerp(weight, o_control.player_stats.weight, 0.1);
cm_height = lerp(cm_height, o_control.player_stats.height, 0.1);

if (hovered) {
    if (mouse_wheel_up()) {
        max_width = max(lerp(max_width, max_width * 0.9, 0.5), width);
        max_height = max(lerp(max_height, max_height * 0.9, 0.5), height);
    }
    
    if (mouse_wheel_down()) {
        max_width = lerp(max_width, max_width * 1.2, 0.5);
        max_height = lerp(max_height, max_height * 1.2, 0.5);
    }
}