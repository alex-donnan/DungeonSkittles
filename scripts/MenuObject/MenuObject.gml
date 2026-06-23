function MenuObject(_name, _type, _inst, _sequence) constructor {
    name = _name;
    type = _type;
    parent = _inst;
    active = false;
    
    sequence = _sequence;
    layer_sequence = undefined
    layer_sequence_instance = undefined;
     
    animations = {};
    animating = false;
    
    // Animation handling
    add_animation = function(_anim) {
        if (!is_instanceof(_anim, MenuAnimation)) {
            print("Could not add non-animation to menu");
            return self;
        }
        
        animations[$ _anim.name] = _anim;
        
        return self;
    }
    
    remove_animation = function(_anim_name) {
        if (struct_exists(animations, _anim_name)) {
            struct_remove(animations, _anim_name);
        }
        
        return self;
    }
    
    play_animation = function(_anim_name) {
        var anim = animations[$ _anim_name];
        if (!is_null(anim) && !animating) {
            sequence_instance_override_object(layer_sequence_instance, type, parent);
            layer_sequence_headpos(layer_sequence, anim.in);
            layer_sequence_headdir(layer_sequence, anim.dir);
            call_later(
                anim.delay,
                time_source_units_frames,
                function() {
                    animating = true;
                    layer_sequence_play(layer_sequence);
                },
                false
            );
            call_later(
                anim.delay + anim.length,
                time_source_units_frames,
                function() {
                    animating = false;
                }
            );
        }
    }
    
    // Update
    sub_update = function() {
        return;
    }
    
    update = function() {
        if (parent.update) {
            sub_update();
            parent.update = false;
        }
    }
    
    set_update = function(_function) {
        if (!is_callable(_function)) {
            print("Could not set non-callable to update function")
            return self;
        }
        
        sub_update = method(self, _function);
        return self;
    }
    
    // Cleanup
    cleanup = function() {
        layer_sequence_destroy(layer_sequence);
    }
}