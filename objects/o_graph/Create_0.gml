hovered = false;
active = true;
update = false;
width = bbox_right - bbox_left;
height = bbox_bottom - bbox_top;

graph_surface = undefined;

start_rpm = 0;
half_life = 0;
radius = 1;
weight = 1;
cm_height = 1;
max_width = o_control.player_stats.half_life * 2.5;
max_height = o_control.player_stats.start_rpm * 1.5;