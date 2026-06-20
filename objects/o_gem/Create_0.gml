timer = irandom(360);
y_draw = 0;
sprite_index = choose(
    sp_gem_1,
    sp_gem_2,
    sp_gem_3,
    sp_gem_4,
    sp_gem_5
);
image_index = irandom(sprite_get_number(sprite_index));

gem_state = new StateMachine();
gem_state.add_state(
    new State(
        "gem_create",
        {}
    ).add_function(
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
    new State(
        "gem_wait",
        {
            wait_timer: 0
        }
    ).add_function(
        "update",
        function() {
            wait_timer++;
            
        }
    )
)