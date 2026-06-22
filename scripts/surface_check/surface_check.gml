/*
	Ensures a valid shader exists based on width and height
*/
function surface_check(_surface, _w, _h, _function = undefined, _refresh = false) {
	if (
            surface_exists(_surface) &&
            (surface_get_width(_surface) != _w || surface_get_height(_surface) != _h)
    ) {
		surface_free(_surface);
	}
    
	if (is_null(_surface)) {
        _surface = surface_create(_w, _h);
        _refresh = true;
    }
    
    if (_function != undefined && _refresh) {
        surface_set_target(_surface);
            _function();
        surface_reset_target();
    }
    
    return _surface;
}