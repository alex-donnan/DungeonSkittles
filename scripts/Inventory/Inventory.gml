function Inventory() constructor {
    static item_id = 1000;
    items = {};
    
    // Add remove
    add_item = function(_item) {
        if (is_instanceof(_item, Item)) {
            items[$ _item.id] = _item;
        } else {
            print(_item, "is not an Item.");
        }
    }
    
    remove_item = function(_item) {
        if (is_instanceof(_item, Item) && struct_exists(items, _item.id)) {
            struct_remove(items, _item.id);
        } else {
            print(_item, "is not an Item.");
        }
    }
    
    // Update
    update = function() {
        struct_foreach(
            items,
            function(_id, _item) {
                
            }
        )
    }
}