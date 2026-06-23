function Menu(_name) constructor {
    static menu_id = 5000;
    
    o_control.menus[$ _name] = self;
    name = _name;
    objects = {};
    active = true;
    
    // Object handling
    add_object = function(_obj) {
        if (!is_instanceof(_obj, MenuObject)) {
            print("Could not add non-Object to menu");
            return self;
        }
        
        _obj.menu = self;
        objects[$ _obj.name] = _obj;
        
        return self;
    }
    
    remove_objects = function(_obj_name) {
        if (struct_exists(objects, _obj_name)) {
            struct_remove(objects, _obj_name);
        }
        
        return self;
    }
    
    // Update objects
    update = function() {
        struct_foreach(
            objects,
            function(_name, _obj) {
                _obj.update();
            }
        )
    }
    
    // Animate objects
    animate = function(_anim_name) {
        struct_foreach(
            objects,
            method({ anim_name: _anim_name }, function(_name, _obj) {
                _obj.play_animation(anim_name);
            })
        );
    }
    
    // Activate/Deactivate
    activate = function() {
        active = true;
        struct_foreach(
            objects,
            function(_name, _obj) {
                 with (_obj) {
                    parent.active = true; 
                    layer_sequence = layer_sequence_create("GUI", parent.x, parent.y, sequence);
                    layer_sequence_instance = layer_sequence_get_instance(layer_sequence);
                    layer_sequence_pause(layer_sequence);
                 }
            }
        )
    }
    
    deactivate = function() {
        active = false;
        struct_foreach(
            objects,
            function(_name, _obj) {
                _obj.parent.active = false;
                _obj.cleanup();
            }
        )
    }
}