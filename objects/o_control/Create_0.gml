gpu_set_texfilter(false);
randomise();

game_state = new StateMachine();
game_state.add_state(
    new State(
        "dungeon_start",
        {
            timer: 0
        }
    ).set_function(
        function() {
            if (mouse_check_button(mb_left)) {
                state_machine.set_state("dungeon_run", "next");
            }
        },
        "update"
    ).set_function(
        function() {
            // Create player
            instance_create_depth(
                o_start.x, o_start.y, 0,
                o_player, {
                    rpm: 450,
                    tilt_direction: point_direction(o_start.x, o_start.y, mouse_x, mouse_y)
                }
            );
            timer = 0
        },
        "leave"
    )
).add_state(
    new State(
        "dungeon_run",
        {
            timer: 0
        }
    )
).set_state("dungeon_start", "next");
player_stats = new Statistics();
