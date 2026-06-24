function reference(_inst, _var) {
    with ({ _inst, _var }) return function() {
        if (argument_count > 0) {
            variable_instance_set(_inst, _var, argument[0]);
        } else {
            return variable_instance_get(_inst, (is_callable(_var)) ? _var() : _var);
        }
    }
}