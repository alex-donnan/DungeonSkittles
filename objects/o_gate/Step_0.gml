item_count = 0;
struct_foreach(
    o_control.items,
    method(self, function(_name, _item) {
        if (!string_starts_with(_name, "unstable") && _name != "none" && _item.discovered) return item_count++;
    })
);

if (item_count == total_count) {
    o_control.dungeon_camera.camera_shake = game_get_speed(gamespeed_fps) * 5;
    o_control.menus[$ "dungeon_menu"].animate("gate_opened");
    call_later(
        5,
        time_source_units_seconds,
        function() {
            o_control.menus[$ "dungeon_menu"].animate("close_gate_opened");
        }
    );
    instance_destroy(self);
}