function init_menu_object(_name, _inst) {
    switch (_name) {
        // MAIN MENU
        case "main_menu_continue":
            return new MenuObject(_name, o_button, _inst, sq_no_animation);
        case "main_menu_play":
            return new MenuObject(_name, o_button, _inst, sq_main_menu_button)
                .add_animation(new MenuAnimation("enter", 0, 36, 8))
                .add_animation(new MenuAnimation("leave", 36, 36, 4, seqdir_left))
                .set_update(
                    function() {
                        menu.animate("leave");
                        if (menu.objects[$ "main_menu_credits_text"].parent.image_alpha > 0) menu.animate("close_credits");
                        call_later(
                            60,
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
                .add_animation(new MenuAnimation("enter", 0, 36, 16))
                .add_animation(new MenuAnimation("leave", 36, 36, 8, seqdir_left))
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
                .add_animation(new MenuAnimation("open_credits", 0, 12, 0))
                .add_animation(new MenuAnimation("close_credits", 12, 12, 0, seqdir_left));
        case "main_menu_quit":
            return new MenuObject(_name, o_button, _inst, sq_main_menu_button)
                .add_animation(new MenuAnimation("enter", 0, 36, 24))
                .add_animation(new MenuAnimation("leave", 36, 36, 12, seqdir_left))
                .set_update(
                    function() {
                        o_control.game_state.set_state("game_end", "next");
                    }
                );
            
        // SHOP MENU
        case "shop_menu_start":
            return new MenuObject(_name, o_button, _inst, sq_no_animation)
                .set_update(
                    function() {
                        o_control.game_state.set_state("dungeon_start", "next");
                        o_control.next_room = rm_dungeon;
                    }
                );
        case "shop_menu_item_window":
            return new MenuObject(_name, o_window, _inst, sq_no_animation);
        case "shop_menu_quit":
            return new MenuObject(_name, o_button, _inst, sq_no_animation)
                .set_update(
                    function() {
                        o_control.game_state.set_state("main_menu", "next");
                        o_control.next_room = rm_main;
                    }
                );
        case "shop_menu_buy":
            return new MenuObject(_name, o_button, _inst, sq_no_animation)
                .set_update(
                    function() {
                        print(" BUY ");
                    }
                );
        case "shop_menu_upgrade_top":
            return new MenuObject(_name, o_button, _inst, sq_no_animation)
                .set_update(
                    function() {
                        print(" UPGRADE TOP ");
                    }
                );
        case "shop_menu_detail_window":
            _inst.image_alpha = 0;
            return new MenuObject(_name, o_window, _inst, sq_window_quick_fade)
                .add_animation(new MenuAnimation("open_detail", 0, 12, 0))
                .add_animation(new MenuAnimation("close_detail", 12, 12, 0, seqdir_left));
        case "shop_menu_item_stats":
            _inst.track_variable = reference(reference(o_control.items, reference(o_control, "item_focus")), "description");
            return new MenuObject(_name, o_textbox, _inst, sq_no_animation);
        case "shop_menu_item_buy":
            return new MenuObject(_name, o_button, _inst, sq_no_animation)
                .set_update(
                    function() {
                        if (parent.text == "BUY") {
                           if (o_control.player_stats.gems >= o_control.items[$ o_control.item_focus].cost) {
                               o_control.player_stats.gems -= o_control.items[$ o_control.item_focus].cost;
                               o_control.items[$ o_control.item_focus].unlocked = true;
                               parent.text = "EQUIP";
                           }
                        } else {
                            menu.animate("open_swap_item");
                        }
                    }
                );
        case "shop_menu_item_0":
        case "shop_menu_item_1":
        case "shop_menu_item_2":
        case "shop_menu_item_3":
        case "shop_menu_item_4":
        case "shop_menu_item_5":
        case "shop_menu_item_6":
        case "shop_menu_item_7":
        case "shop_menu_item_8":
        case "shop_menu_item_9":
        case "shop_menu_item_10":
        case "shop_menu_item_11":
            var sprite = asset_get_index($"sp_{string_trim(_inst.item_name)}");
            print($"sp_{_inst.item_name}", sprite);
            if (!is_null(sprite) && sprite != -1) {
                _inst.sprite_index = sprite;
            }
             return new MenuObject(_name, o_button, _inst, sq_no_animation)
                .set_update(
                    function() {
                        var detail_obj = menu.objects[$ "shop_menu_detail_window"].parent;
                        if (detail_obj.image_alpha > 0) {
                            menu.animate("close_detail");
                            instance_deactivate_region(
                                detail_obj.window_camera.x - detail_obj.width / 2, detail_obj.window_camera.y - detail_obj.height / 2,
                                detail_obj.width, detail_obj.height,
                                true,
                                true
                            );
                            o_control.item_focus = "none";
                        } else {
                            menu.animate("open_detail");
                            instance_activate_region(
                                detail_obj.window_camera.x - detail_obj.width / 2, detail_obj.window_camera.y - detail_obj.height / 2,
                                detail_obj.width, detail_obj.height,
                                true
                            );
                            o_control.item_focus = parent.item_name;
                            menu.objects[$ "shop_menu_item_buy"].parent.text = (o_control.items[$ parent.item_name].unlocked) ?
                                 "EQUIP" : "BUY";
                        }
                    }
                );
        case "shop_menu_gem_count":
            _inst.track_variable = reference(o_control.player_stats, "gems");
             return new MenuObject(_name, o_textbox, _inst, sq_no_animation);
        // Shop statics
        case "shop_menu_graph":
             return new MenuObject(_name, o_graph, _inst, sq_no_animation);
        case "shop_menu_stats":
             return new MenuObject(_name, o_textbox, _inst, sq_no_animation);
        case "shop_menu_item_window_source":
             return new MenuObject(_name, o_window_source, _inst, sq_no_animation);
        case "shop_menu_detail_window_source":
             return new MenuObject(_name, o_window_source, _inst, sq_no_animation);
    }
}