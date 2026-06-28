if (armor == 0) {
    var gem_count = irandom_range(start_armor, start_armor * 2);
    repeat(gem_count) {
        instance_create_depth(
            x, y, 0,
            o_gem,
            {
                direction: random(360),
                move_speed: random_range(8, 16)
            }
        );
    }
    
    var player = instance_find(o_player, 0);
    player.active = false;
    
    o_control.game_camera.camera_shake = game_get_speed(gamespeed_fps) * 5;
    call_later(
        5,
        time_source_units_seconds,
        function() {
            o_control.game_state.set_state("dungeon_win", "next");
        }
    ); 
}