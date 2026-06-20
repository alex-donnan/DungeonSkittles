function State(_name, _vars = {}, _enter = undefined, _update = undefined, _leave = undefined) constructor {
    id = StateMachine.state_id++;
    name = _name;
    vars = _vars;
    state_machine = undefined;
    
    enter = (!is_null(_enter)) ? _enter : function() {
        return;
    };
    update = (!is_null(_update)) ? _update : function() {
        return;
    };
    leave = (!is_null(_leave)) ? _leave : function() {
        return;
    };
    
    set_function = function(_function, _type) {
        self[$ _type] = method(self, _function);
        return self;
    }
}