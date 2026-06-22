function init_menu_object(_name, _inst) {
    switch (_name) {
        // MAIN MENU
        case "main_menu_play":
            return new MenuObject(_name, o_button, _inst, sq_main_menu_button)
                .add_animation(new MenuAnimation("enter", 0, 8))
                .add_animation(new MenuAnimation("leave", 36, 4, seqdir_left))
                .set_update(
                    function() {
                        menu.animate("leave");
                        if (menu.objects[$ "main_menu_credits_text"].parent.image_alpha > 0) menu.animate("close_credits");
                        call_later(
                            50,
                            time_source_units_frames,
                            function() {
                                o_control.game_state.set_state("shop_menu", "next");
                                o_control.next_room = rm_shop;
                            },
                            false
                        );
                    }
                );
        case "main_menu_credits":
            return new MenuObject(_name, o_button, _inst, sq_main_menu_button)
                .add_animation(new MenuAnimation("enter", 0, 16))
                .add_animation(new MenuAnimation("leave", 36, 8, seqdir_left))
                .set_update(
                    function() {
                        var action = (menu.objects[$ "main_menu_credits_text"].parent.image_alpha > 0) ? "close_credits" : "open_credits";
                        menu.animate(action);
                    }
                );
        case "main_menu_credits_text":
            _inst.image_alpha = 0;
            _inst.text = @"
                Dungeon Skittles
                A game by Jellycopter for
                - The Very Serious Juniper Dev Game Jam 2026 -
                Theme: Spin to Win
            
                Software Used:
                GameMaker
                FL Studio
            
                You:
                Thanks for playing!
            ";
            
            return new MenuObject(_name, o_textbox, _inst, sq_main_menu_credits)
                .add_animation(new MenuAnimation("open_credits", 0, 0))
                .add_animation(new MenuAnimation("close_credits", 12, 0, seqdir_left));
        case "main_menu_quit":
            return new MenuObject(_name, o_button, _inst, sq_main_menu_button)
                .add_animation(new MenuAnimation("enter", 0, 24))
                .add_animation(new MenuAnimation("leave", 36, 12, seqdir_left))
                .set_update(
                    function() {
                        o_control.game_state.set_state("game_end", "next");
                    }
                );
            
        // SHOP MENU
        case "shop_menu_start":
            return new MenuObject(_name, o_button, _inst, sq_shop_menu_button)
                .add_animation(new MenuAnimation("enter", 0, 0))
                .add_animation(new MenuAnimation("leave", 1, 0, seqdir_left))
                .set_update(
                    function() {
                        o_control.game_state.set_state("dungeon_start", "next");
                        o_control.next_room = rm_dungeon;
                    }
                );
    }
}