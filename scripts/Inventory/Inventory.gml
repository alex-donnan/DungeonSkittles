function Inventory() constructor {
    static item_id = 1000;
    items = {
        "0": undefined,
        "1": undefined,
        "2": undefined,
        "3": undefined
    };
    
    // Add remove
    add_item = function(_pos, _item) {
        if (is_instanceof(_item, Item)) {
            var swap_spot = -1;
            for (var i = 0; i < 4; i++) {
                if (items[$ string(i)] == _item) {
                    items[$ string(i)] = undefined;
                    swap_spot = i;
                }
            }
            if (!is_null(items[$ _pos])) {
                print("swappable");
                add_item(swap_spot, items[$ _pos]);
            }
            items[$ _pos] = _item;
        } else {
            print(_item, "is not an Item.");
        }
    }
    
    remove_item = function(_pos) {
        items[$ _pos] = undefined;
    }
    
    // Update
    update = function() {
        struct_foreach(
            items,
            function(_id, _item) {
                if (is_null(_item)) return;
                    
                _item.ability();
            }
        )
    }
}