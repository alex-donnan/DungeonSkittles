function MenuObject(_name, _type, _inst, _sequence) constructor {
    id = Menu.menu_id++;
    name = _name;
    type = _type;
    parent = _inst;
    sequence = layer_sequence_create(_name, _inst.x, _inst.y, _sequence);
    sequence_instance = layer_sequence_get_instance(sequence);
    layer_sequence_pause(sequence);
    
    animations = {};
    
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
        sequence_instance_override_object(sequence_instance, type, parent);
        layer_sequence_headpos(sequence, anim.in);
        layer_sequence_headdir(sequence, anim.dir);
        call_later(
            anim.delay,
            time_source_units_frames,
            layer_sequence_play(sequence),
            false
        );
    }
    
    // Update
    update = function() {
        
    }
    
    // Cleanup
    cleanup = function() {
        layer_sequence_destroy(sequence);
    }
}