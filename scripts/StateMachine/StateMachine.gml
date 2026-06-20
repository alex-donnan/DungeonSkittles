function StateMachine() constructor {
    static state_id = 0;
    states = {};
    active_states = {
        current: undefined,
        next:undefined,
        last: undefined
    }
    
    // Handle state add/remove
    add_state = function(_state) {
        if (!is_instanceof(_state, State)) {
            print("Could not add non-state to machine");
            return;
        }
            
        states[$ _state.name] = _state;
        _state.state_machine = self;
        
        return self;
    }
    
    set_state = function(_state_name, _type = "current") {
        var state = struct_get(states, _state_name)
        active_states[$ _type] = state;
        
        return self;
    }
    
    remove_state = function(_state_name) {
        if (struct_exists(states, _state_name)) {
            struct_remove(states, _state_name);
        }
        
        return self;
    }
    
    // Update the states
    update = function() {
        if (!is_null(active_states[$ "current"])) active_states[$ "current"].update();
        
        if (!is_null(active_states[$ "next"])) {
            if (!is_null(active_states[$ "current"])) active_states[$ "current"].leave();
            set_state(active_states[$ "next"].name, "current");
            set_state(undefined, "next");
            active_states[$ "current"].enter();
        }
    }
}