timer = irandom(360);
wait_timer = 0;
draw_y = 0;
draw_scale = 1;
draw_alpha = 1;
sprite_index = choose(
    sp_gem_1,
    sp_gem_2,
    sp_gem_3,
    sp_gem_4,
    sp_gem_5
);
image_index = irandom(sprite_get_number(sprite_index));

gem_state = new StateMachine(self);
gem_state.add_state(
    new State("gem_create")
        .set_function(
            "update",
            function() {
                move_speed = lerp(move_speed, 0, 0.25);
                
                x += lengthdir_x(move_speed, direction);
                y += lengthdir_y(move_speed * 0.75, direction);
                
                if (move_speed < 0.01) {
                    gem_state.set_state("gem_wait", "next");
                }
            }
        )
).add_state(
    new State("gem_wait")
        .set_function(
            "update",
            function() {
                wait_timer++;
                draw_y = 8 * dsin(wait_timer);
                
                var player = instance_nearest(x, y, o_player);
                if (point_distance(x, y, player.x, player.y) < 32) {
                    wait_timer = 0;
                    gem_state.set_state("gem_follow", "next");
                }
                
                if (wait_timer > game_get_speed(gamespeed_fps) * 20) {
                    instance_destroy(self);
                } else if (wait_timer > game_get_speed(gamespeed_fps) * 17) {
                    draw_alpha = (wait_timer mod 10 > 5) ? 0.5 : 1;
                }
            }
        ).set_function(
            "leave",
            function() {
                draw_alpha = 1;
            }
        )
).add_state(
    new State("gem_follow")
        .set_function(
            "enter",
            function() {
                move_speed = 0.5;
            }
        )
        .set_function(
            "update",
            function() {
                var player = instance_nearest(x, y, o_player);
                move_towards_point(player.x, player.y, move_speed);
                move_speed *= 1.05;
                
                if (place_meeting(x, y, o_player)) {
                    o_control.player_stats.gems += 1;
                    instance_destroy(self);
                }
            }
        )
);
gem_state.set_state("gem_create", "next");