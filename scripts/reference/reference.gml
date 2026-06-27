function reference(_inst, _var, _value = undefined) {
    with ({ _inst, _var }) return function() {
        if (argument_count > 0) {
            if (!variable_instance_exists(_inst, _var)) variable_instance_set(_inst, _var, _value);
        } else {
            var instance = is_method(_inst) ? _inst() : _inst;
            var variable = is_method(_var) ? _var() : _var;
            if (!is_null(instance) && !is_null(variable)) {
                return variable_instance_get(instance, variable);
            } else {
                return undefined;
            }
        }
    }
}