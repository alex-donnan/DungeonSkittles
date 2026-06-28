depth = -y;
item_count = 0;
total_count = 0;
struct_foreach(
    o_control.items,
    method(self, function(_name, _item) {
        if (!string_starts_with(_name, "unstable") && _name != "none") {
            total_count += 1;
            if (_item.discovered) item_count++;
        }
    })
);

if (item_count == total_count) {
    instance_destroy(self);
}