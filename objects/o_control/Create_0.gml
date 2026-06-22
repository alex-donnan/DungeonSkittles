#macro WIDTH 480
#macro HEIGHT 270

window_set_size(WIDTH * 2, HEIGHT * 2);
display_set_gui_size(WIDTH * 2, HEIGHT * 2);
gpu_set_texfilter(false);
randomise();

camera = instance_create_depth(WIDTH / 2, HEIGHT / 2, 0, o_camera);
player_stats = undefined;
game_state = new StateMachine(self);
next_room = rm_main;
menus = {};

// Main menu states
game_state.add_state(
    new State("main_menu")
        .set_function(
            "enter",
            function() {
                // Load?
                if (is_null(player_stats)) player_stats = new Statistics();
                
                if (!struct_exists(menus, "main_menu")) {
                    var menu = new Menu("main_menu");
                    with (o_menu_object) {
                        if (!is_null(menu_object)) menu.add_object(menu_object);
                    }
                    menu.activate();
                    menu.animate("enter");
                }
            }
        ).set_function(
            "update",
            function() {
                menus[$ "main_menu"].update();
            }
        ).set_function(
            "leave",
            function() {
                room_goto(next_room);
            }
        )
).add_state(
    new State("game_end")
        .set_function(
            "enter",
            function() {
                // Save player stats for next time
                game_end();
            }
        )
)

// Shop states
game_state.add_state(
    new State("shop_menu")
        .set_function(
            "enter",
            function() {
                if (!struct_exists(menus, "shop_menu")) {
                    var menu = new Menu("shop_menu");
                    with (o_menu_object) {
                        if (!is_null(menu_object)) menu.add_object(menu_object);
                    }
                    menu.activate();
                }
            }
        )
        .set_function(
            "update",
            function() {
                menus[$ "shop_menu"].update();
            }    
        ).set_function(
            "leave",
            function() {
                room_goto(next_room);
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
game_state.set_state("main_menu", "next");
