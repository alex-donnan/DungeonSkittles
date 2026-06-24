function ds_list_to_array(_list) {
    var output = []; 
    for (var i = 0, j = ds_list_size(_list); i < j; i++) {
        array_push(output, _list[| i]);
    }
    return output;
}