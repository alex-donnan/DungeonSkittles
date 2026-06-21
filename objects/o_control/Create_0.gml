gpu_set_texfilter(false);
randomise();

camera = instance_create_depth(x, y, 0, o_camera);
game_state = new StateMachine(self);
menus = {};

// Main menu states
game_state.add_state(
    new State("main_menu")
        .set_function(
            "enter",
            function() {
                // Load?
                player_stats = new Statistics();
                var menu = new Menu("main_menu");
                
                with (o_button) {
                    if (!is_null(menu_object)) menu.add_object(menu_object);
                }
                
                menu.activate();
            }
        )
);

// Shop states
game_state.add_state(
    new State("shop_menu")
        .set_function(
            "update",
            function() {
                print("bean");
            }
        )
);

// Dungeon states
game_state.add_state(
    new State("dungeon_start")
        .set_function(
            "enter",
            function() {
                camera.x = o_start.x;
                camera.y = o_start.y;
            }
        )
        .set_function(
            "update",
            function() {
                if (mouse_check_button(mb_left)) {
                    game_state.set_state("dungeon_run", "next");
                }
            }
        ).set_function(
            "leave",
            function() {
                // Create player
                camera.follow = instance_create_depth(
                    o_start.x, o_start.y, 0,
                    o_player, {
                        rpm: 450,
                        tilt_direction: point_direction(o_start.x, o_start.y, mouse_x, mouse_y)
                    }
                );
            }
        )
).add_state(
    new State("dungeon_run")
);
game_state.set_state("dungeon_start", "next");
