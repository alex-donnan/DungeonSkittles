function State(_name) constructor {
    id = StateMachine.state_id++;
    name = _name;
    parent = undefined;
    
    // State steps
    enter = function() {};
    update = function() {};
    leave = function() {};
    
    set_function = function(_type, _function) {
        self[$ _type] = _function;
        return self;
    }
}