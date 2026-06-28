function MenuObject(_name, _type, _inst, _sequence, _ignore_animating = false) constructor {
    name = _name;
    type = _type;
    parent = _inst;
    active = false;
    
    sequence = _sequence;
    layer_sequence = undefined
    layer_sequence_instance = undefined;
     
    animations = {};
    last_animation = undefined;
    animating = false;
    ignore_animating = _ignore_animating;
    
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
    
    start_animation = function() {
        animating = true;
        layer_sequence_play(layer_sequence);
    }
    
    stop_animation = function() {
        animating = false;
        layer_sequence_pause(layer_sequence);
    }
    
    play_animation = function(_anim_name) {
        var anim = animations[$ _anim_name];
        if (
            !is_null(anim) &&
            (!animating || ignore_animating) &&
            (len(anim.previous_anim) == 0 || array_contains(anim.previous_anim, last_animation))
        ) {
            last_animation = _anim_name;
            sequence_instance_override_object(layer_sequence_instance, type, parent);
            layer_sequence_headpos(layer_sequence, anim.in);
            layer_sequence_headdir(layer_sequence, anim.dir);
            
            if (!is_null(anim.end_anim) && time_source_exists(anim.end_anim)) {
                call_cancel(anim.end_anim);
                anim.end_anim = undefined;
            }
            
            if (anim.delay > 0) {
                call_later(
                    anim.delay,
                    time_source_units_frames,
                    start_animation,
                    false
                );
            } else {
                start_animation();
            }
            
            if (anim.delay + anim.length > 0) {
                anim.end_anim = call_later(
                    anim.delay + anim.length + 1,
                    time_source_units_frames,
                    stop_animation,
                    false
                );
            } else {
                stop_animation();
            }
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
        if (!is_method(_function)) {
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