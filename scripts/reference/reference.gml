function reference(_inst, _var, _value = undefined) {
    with ({ _inst, _var }) return function() {
        if (argument_count > 0) {
            if (!variable_instance_exists(_inst, _var)) variable_instance_set(_inst, _var, _value);
        } else {
            return variable_instance_get(is_callable(_inst) ? _inst() : _inst, is_callable(_var) ? _var() : _var);
        }
    }
}