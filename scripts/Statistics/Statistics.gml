function Statistics() constructor {
    inventory = new Inventory();
    
    original_stats = {
        start_rpm: 500,
        half_life: 500 / 20,
        weight: 2,
        height: 0.1,
        radius: 2
    }
    
    // Upgrades
    start_rpm = 500;
    half_life = start_rpm / 50;
    weight = 2;
    unstable_rpm = 0;
    height = 0.1;
    radius = 2;
    
    update = function() {
        weight = original_stats.weight + (
            (is_null(inventory.items[$ "0"]) ? 0 : inventory.items[$ "0"].weight) +
            (is_null(inventory.items[$ "1"]) ? 0 : inventory.items[$ "1"].weight) +
            (is_null(inventory.items[$ "2"]) ? 0 : inventory.items[$ "2"].weight) +
            (is_null(inventory.items[$ "3"]) ? 0 : inventory.items[$ "3"].weight)
        );
        var w_kg = weight / 1000;
        var amiu = (w_kg * power(radius, 2)) / 2;
        unstable_rpm = 2 * sqrt(9.81 * (0.001 + power(height, 2)) * height) / amiu;
        
        half_life = start_rpm / (50 - (30 * (start_rpm / 5000)));
    } 
    
    move_influence = 1.2;
    move_speed = 2;
    gems = 0;
    
    // Random stats
    play_time = 0;
    run_count = 0;
    
    damage_done = 0;
    gems_collected = 0;
    items_collected = 0;
    
    distance_travelled = 0;
    bounces = 0;
    
    // Save progress
    save = function() {
        // Variables
        var json = {
            disclaimer: "If you are reading this, welcome to the save file. Feel free to mess with stuff and see how it breaks!",
            
            // Upgrades
            start_rpm,
            half_life,
            weight,
            height,
            radius,
            move_influence,
            move_speed,
            gems,
            
            // Random stats
            play_time,
            run_count,
            
            damage_done,
            gems_collected,
            items_collected,
            
            distance_travelled,
            bounces,
            
            // Items
            items: {},
            equip: {}
        };
        
        // Item state
        struct_foreach(
            o_control.items,
            method({ json }, function(_id, _item) {
                json.items[$ _id] = {
                    unlocked: _item.unlocked,
                    discovered: _item.discovered
                }
            })
        );
        
        // Equipment
        for (var i = 0; i < 4; i++) {
            if (!is_null(inventory.items[$ string(i)])) {
                json.equip[$ string(i)] = inventory.items[$ string(i)].id;
            }
        }
        
        // Read
        var output = file_text_open_write("skittle_dungeon_save.json");
        if (!is_null(output)) {
            file_text_write_string(output, json_stringify(json)); 
            file_text_close(output);
            print("Saved to file");
        }
    }
    
    load = function() {
        var input = file_text_open_read("skittle_dungeon_save.json");
        if (!is_null(input)) {
            var text = file_text_read_string(input);
            var json = json_parse(text);
            
            // Variables
            struct_foreach(
                json,
                method(self, function(_name, _el) {
                    if (struct_exists(self, _name)) {
                        self[$ _name] = _el;
                    }
                })
            );
            
            // Items
            struct_foreach(
                json.items,
                method({ items: o_control.items }, function(_name, _item) {
                    if (struct_exists(items, _name)) {
                        items[$ _name].discovered = bool(_item.discovered);
                        items[$ _name].unlocked = bool(_item.unlocked);
                    }
                })
            );
            
            // Inventory
            for (var i = 0; i < 4; i++) {
                if (struct_exists(json.equip, string(i))) {
                    inventory.add_item(i, o_control.items[$ json.equip[$ string(i)]]);
                }
            }
            
            file_text_close(input);
            print("Loaded save file");
        }
    }
}