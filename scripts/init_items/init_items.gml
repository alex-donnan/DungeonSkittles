global.item_db = new Inventory();

function init_items() {
    global.item_db.add_item(
        new ActiveItem(
            "Gyroscope", "Left click to encourage the top towards the mouse.", 1,
            function() {
                if (mouse_check_button(mb_left)) {
                    o_player.move_influence = 1.5 + (0.25 * self.level);
                }
            }
        )
    )
}