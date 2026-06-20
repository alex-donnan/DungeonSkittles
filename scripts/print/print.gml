/// simple print function for easier debug messaging
function print() {
	var str = "";
    for (var i = 0; i < argument_count; i ++) {
        var arg = (typeof(argument[i]) == "number") ? string_format(argument[i], 4, 4) : string(argument[i]);
        str += arg + " ";
    }

    show_debug_message(str);
}