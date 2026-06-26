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
            return new MenuObject(_name, o_window, _inst, sq_window_quick_fade, true)
                .add_animation(new MenuAnimation("open_detail", 0, 6, 0, seqdir_right, ["fast_close", "close_detail"]))
                .add_animation(new MenuAnimation("fast_close", 1, 1, 0, seqdir_left))
                .add_animation(new MenuAnimation("close_detail", 6, 6, 0, seqdir_left, ["open_detail"]));
        case "shop_menu_detail_stats":
            return new MenuObject(_name, o_textbox, _inst, sq_textbox_quick_fade, true)
                .add_animation(new MenuAnimation("open_detail", 0, 6, 0, seqdir_right, ["fast_close", "close_detail"]))
                .add_animation(new MenuAnimation("fast_close", 1, 1, 0, seqdir_left))
                .add_animation(new MenuAnimation("close_detail", 6, 6, 0, seqdir_left, ["open_detail"]));
        case "shop_menu_detail_buy":
            return new MenuObject(_name, o_button, _inst, sq_button_quick_fade, true)
                .add_animation(new MenuAnimation("open_detail", 0, 6, 0, seqdir_right, ["fast_close", "close_detail"]))
                .add_animation(new MenuAnimation("fast_close", 1, 1, 0, seqdir_left))
                .add_animation(new MenuAnimation("close_detail", 6, 6, 0, seqdir_left, ["open_detail"]))
                .set_update(
                    function() {
                        if (array_contains(["fast_close", "close_detail"], last_animation)) return;
                            
                        if (!o_control.items[$ o_control.item_focus].unlocked) {
                            if (o_control.player_stats.gems >= o_control.items[$ o_control.item_focus].cost) {
                                o_control.player_stats.gems -= o_control.items[$ o_control.item_focus].cost;
                                o_control.items[$ o_control.item_focus].unlocked = true;
                                parent.text = "EQUIP";
                            } else {
                                menu.animate("gem_wiggle");
                            }
                        } else {
                            menu.animate("open_equip");
                        }
                    }
                );
        case "shop_menu_detail_close":
            return new MenuObject(_name, o_button, _inst, sq_button_quick_fade, true)
                .add_animation(new MenuAnimation("open_detail", 0, 6, 0, seqdir_right, ["fast_close", "close_detail"]))
                .add_animation(new MenuAnimation("fast_close", 1, 1, 0, seqdir_left))
                .add_animation(new MenuAnimation("close_detail", 6, 6, 0, seqdir_left, ["open_detail"]))
                .set_update(
                    function() {
                        if (array_contains(["fast_close", "close_detail"], last_animation)) return;
                        menu.animate("close_detail");
                        menu.animate("close_equip");
                    }
                );
        case "shop_menu_equip_0":
            return new MenuObject(_name, o_flexbox, _inst, sq_flexbox_quick_fade)
                .add_animation(new MenuAnimation("open_equip", 0, 6, 0, seqdir_right, ["fast_close", "close_equip"]))
                .add_animation(new MenuAnimation("fast_close", 1, 1, 0, seqdir_left))
                .add_animation(new MenuAnimation("close_equip", 6, 6, 0, seqdir_left, ["open_equip"]));
        case "shop_menu_equip_1":
            return new MenuObject(_name, o_flexbox, _inst, sq_flexbox_quick_fade)
                .add_animation(new MenuAnimation("open_equip", 0, 6, 6, seqdir_right, ["fast_close", "close_equip"]))
                .add_animation(new MenuAnimation("fast_close", 1, 1, 0, seqdir_left))
                .add_animation(new MenuAnimation("close_equip", 6, 6, 0, seqdir_left, ["open_equip"]));
        case "shop_menu_equip_2":
            return new MenuObject(_name, o_flexbox, _inst, sq_flexbox_quick_fade)
                .add_animation(new MenuAnimation("open_equip", 0, 6, 12, seqdir_right, ["fast_close", "close_equip"]))
                .add_animation(new MenuAnimation("fast_close", 1, 1, 0, seqdir_left))
                .add_animation(new MenuAnimation("close_equip", 6, 6, 0, seqdir_left, ["open_equip"]));
        case "shop_menu_equip_3":
            return new MenuObject(_name, o_flexbox, _inst, sq_flexbox_quick_fade)
                .add_animation(new MenuAnimation("open_equip", 0, 6, 18, seqdir_right, ["fast_close", "close_equip"]))
                .add_animation(new MenuAnimation("fast_close", 1, 1, 0, seqdir_left))
                .add_animation(new MenuAnimation("close_equip", 6, 6, 0, seqdir_left, ["open_equip"]));
        case "shop_menu_equipped_item_0":
        case "shop_menu_equipped_item_1":
        case "shop_menu_equipped_item_2":
        case "shop_menu_equipped_item_3":
            return new MenuObject(_name, o_button, _inst, sq_no_animation);
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
            if (!is_null(sprite) && sprite != -1) _inst.sprite_index = sprite;
            
            return new MenuObject(_name, o_button, _inst, sq_no_animation)
                .set_update(
                    function() {
                        var detail = menu.objects[$ "shop_menu_detail_window"];
                        if (detail.last_animation == "open_detail" && o_control.item_focus == parent.item_name) {
                            menu.animate("close_detail");
                            o_control.item_focus = "none";
                        } else {
                            if (array_contains(["fast_close", "close_detail", undefined], detail.last_animation)) {
                                menu.animate("open_detail");
                            }
                            o_control.item_focus = parent.item_name;
                            menu.objects[$ "shop_menu_detail_buy"].parent.text = (o_control.items[$ parent.item_name].unlocked) ?
                                "EQUIP" : "BUY";
                        }
                    }
                );
        case "shop_menu_gem_count":
             return new MenuObject(_name, o_textbox, _inst, sq_textbox_wiggle, true)
                .add_animation(new MenuAnimation("gem_wiggle", 0, 20, 0));
        // Shop statics
        case "shop_menu_graph":
             return new MenuObject(_name, o_graph, _inst, sq_no_animation);
        case "shop_menu_stats":
             return new MenuObject(_name, o_textbox, _inst, sq_no_animation);
        case "shop_menu_item_window":
            return new MenuObject(_name, o_window, _inst, sq_no_animation);
        case "shop_menu_item_window_source":
             return new MenuObject(_name, o_window_source, _inst, sq_no_animation);
        case "shop_menu_detail_window_source":
             return new MenuObject(_name, o_window_source, _inst, sq_no_animation);
    }
}