function init_menu_object(_name, _inst) {
    switch (_name) {
        case "main_menu_play":
            return new MenuObject(_name, o_button, _inst, sq_main_menu_button)
                .add_animation(new MenuAnimation("enter", 0))
                .add_animation(new MenuAnimation("leave", 36, seqdir_left))
    }
}