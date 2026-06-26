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
player_stats = undefined;
game_state = new StateMachine(self);
next_room = rm_main;

menus = {};
item_focus = "none";
items = init_items();

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
)

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
                
                print(game_camera.x, game_camera.y);
                print(game_camera.view);
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
                game_camera.follow = instance_create_depth(
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
        .set_function(
            "update",
            function() {
                if (o_player.crashed) {
                    game_state.set_state("shop_menu", "next");
                    next_room = rm_shop;
                }
            }
        ).set_function(
            "leave",
            function() {
                game_camera.follow = undefined;
                room_goto(next_room);
            }
        )
);
game_state.set_state("main_menu", "next");
