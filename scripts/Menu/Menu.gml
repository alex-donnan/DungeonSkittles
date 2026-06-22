function Menu(_name) constructor {
    static menu_id = 5000;
    
    o_control.menus[$ _name] = self;
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
                if (_obj.parent.update) {
                    _obj.update();
                    _obj.parent.update = false;
                }
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
                instance_activate_object(_obj.parent);
            }
        )
    }
    
    deactivate = function() {
        active = false;
        struct_foreach(
            objects,
            function(_name, _obj) {
                instance_deactivate_object(_obj.parent);
            }
        )
    }
}