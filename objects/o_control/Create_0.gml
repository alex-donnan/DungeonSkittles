#macro WIDTH 480
#macro HEIGHT 270

show_debug_overlay(false);

window_set_size(WIDTH * 2, HEIGHT * 2);
window_center();
display_set_gui_size(WIDTH * 2, HEIGHT * 2);
gpu_set_texfilter(false);
randomise();

game_camera = instance_create_depth(
    WIDTH / 2, HEIGHT / 2, 0,
    o_camera,
    {
        width: WIDTH,
        height: HEIGHT,
        view: 0
    }
);
dungeon_camera = undefined;

player_stats = undefined;
game_state = new StateMachine(self);
next_room = rm_main;

menus = {};
item_focus = "none";
items = init_items();

intro_sequence = undefined;
outro_sequence = undefined;

// Main menu states
game_state.add_state(
    new State("main_menu")
        .set_function(
            "enter",
            function() {
                game_camera.x = WIDTH / 2;
                game_camera.y = HEIGHT / 2;
                
                // Load?
                if (is_null(player_stats)) player_stats = new Statistics();
                
                if (!struct_exists(menus, "main_menu")) {
                    new Menu("main_menu").populate();
                }
                
                menus[$ "main_menu"].activate();
                menus[$ "main_menu"].animate("fast_close");
                if (file_exists("skittle_dungeon_save.json")) menus[$ "main_menu"].animate("continue_enter");
                menus[$ "main_menu"].animate("enter");
            }
        ).set_function(
            "update",
            function() {
                menus[$ "main_menu"].update();
            }
        ).set_function(
            "leave",
            function() {
                menus[$ "main_menu"].deactivate();
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
);

// Intro
game_state.add_state(
    new State("intro")
        .set_function(
            "enter",
            function() {
                intro_sequence = layer_sequence_create("GUI", WIDTH / 2, HEIGHT / 2, intro);
                layer_sequence_play(intro_sequence);
            }
        ).set_function(
            "update",
            function() {
                if (layer_sequence_is_finished(intro_sequence)) {
                    game_state.set_state("shop_menu", "next");
                    next_room = rm_shop;
                    layer_sequence_destroy(intro_sequence);
                }
            }
        ).set_function(
            "leave",
            function() {
                room_goto(next_room);
            }
        )
);

// Outro
game_state.add_state(
    new State("outro")
        .set_function(
            "enter",
            function() {
                outro_sequence = layer_sequence_create("GUI", WIDTH / 2, HEIGHT / 2, outro);
                layer_sequence_play(outro_sequence);
            }
        ).set_function(
            "update",
            function() {
                if (layer_sequence_is_finished(outro_sequence)) {
                    game_state.set_state("main_menu", "next");
                    next_room = rm_main;
                    layer_sequence_destroy(outro_sequence);
                }
            }
        ).set_function(
            "leave",
            function() {
                room_goto(next_room);
            }
        )
);

// Shop states
game_state.add_state(
    new State("shop_menu")
        .set_function(
            "enter",
            function() {
                game_camera.x = WIDTH / 2;
                game_camera.y = HEIGHT / 2;
                
                if (!struct_exists(menus, "shop_menu")) {
                    new Menu("shop_menu").populate();
                }
                
                menus[$ "shop_menu"].activate();
                menus[$ "shop_menu"].animate("fast_close");
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
                player_stats.save();
                menus[$ "shop_menu"].deactivate();
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
                game_camera.x = o_start.x;
                game_camera.y = o_start.y;
                
                if (is_null(dungeon_camera)) {
                    dungeon_camera = instance_create_depth(
                        WIDTH / 2, HEIGHT / 2, 0,
                        o_camera,
                        { view: 1 }
                    );
                }
                dungeon_camera.active = true;
                
                // Create player
                game_camera.follow = instance_create_depth(
                    o_start.x, o_start.y, 0,
                    o_player, {
                        active: false,
                        rpm: player_stats.start_rpm,
                        half_life: player_stats.half_life,
                        weight: player_stats.weight,
                        tilt_direction: point_direction(o_start.x, o_start.y, mouse_x, mouse_y)
                    }
                );
                
                //Remove found artifacts
                with (o_artifact) {
                    var item = o_control.items[$ item_name];
                    if (!is_null(item) && item.discovered) {
                        instance_destroy(self);
                    }
                }
                
                // DUNGEON MENU
                if (!struct_exists(menus, "dungeon_menu")) {
                    new Menu("dungeon_menu").populate();
                }
                
                menus[$ "dungeon_menu"].activate();
                menus[$ "dungeon_menu"].animate("fast_close");
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
                var player = instance_find(o_player, 0);
                player.active = true;
                player.tilt_direction = player.mouse_direction;
            }
        )
).add_state(
    new State("dungeon_run")
        .set_function(
            "update",
            function() {
                player_stats.inventory.update();
                var player = instance_find(o_player, 0);
                
                if (player.rpm < player.unstable_rpm) {
                    menus[$ "dungeon_menu"].animate("unstable_fade");
                }
                
                // CHeck our unstables
                if (player.timer_unstable > 60 * game_get_speed(gamespeed_fps)) {
                    if (items[$ "unstable_sawblade"].discovered == false) {
                        items[$ "unstable_sawblade"].discovered = true;
                        menus[$ "dungeon_menu"].animate("found_item");
                        call_later(
                            5,
                            time_source_units_seconds,
                            function() {
                                o_control.menus[$ "dungeon_menu"].animate("close_found_item");
                            }
                        );
                    }
                } else if (player.timer_unstable > 45 * game_get_speed(gamespeed_fps)) {
                    if (!items[$ "unstable_flywheel"].discovered == false) {
                        items[$ "unstable_flywheel"].discovered = true;
                        menus[$ "dungeon_menu"].animate("found_item");
                        call_later(
                            5,
                            time_source_units_seconds,
                            function() {
                                o_control.menus[$ "dungeon_menu"].animate("close_found_item");
                            }
                        );
                    }
                } else if (player.timer_unstable > 30 * game_get_speed(gamespeed_fps)) {
                    if (!items[$ "unstable_attractor"].discovered == false) {
                        items[$ "unstable_attractor"].discovered = true;
                        menus[$ "dungeon_menu"].animate("found_item");
                        call_later(
                            5,
                            time_source_units_seconds,
                            function() {
                                o_control.menus[$ "dungeon_menu"].animate("close_found_item");
                            }
                        );
                    }
                }
                
                if (player.crashed) {
                    game_state.set_state("dungeon_end", "next");
                }
            }
        )
).add_state(
    new State("dungeon_end")
        .set_function(
            "enter",
            function() {
                menus[$ "dungeon_menu"].animate("open_crash");
            }
        ).set_function(
            "update",
            function() {
                menus[$ "dungeon_menu"].update();
            }
        ).set_function(
            "leave",
            function() {
                menus[$ "dungeon_menu"].animate("fast_close");
                menus[$ "dungeon_menu"].deactivate();
                camera_destroy(dungeon_camera.camera);
                dungeon_camera.active = false;
                game_camera.follow = undefined;
                room_goto(next_room);
            }
        )
).add_state(
    new State("dungeon_win")
        .set_function(
            "update",
            function() {
                game_state.set_state("outro", "next");
                next_room = rm_outro;
            }
        ).set_function(
            "leave",
            function() {
                menus[$ "dungeon_menu"].deactivate();
                camera_destroy(dungeon_camera.camera);
                dungeon_camera.active = false;
                game_camera.follow = undefined;
                room_goto(next_room);
            }
        )
);
game_state.set_state("main_menu", "next");
