/*
	is_null : "null" check
	undefined, noone, other "non-viable" values aren't the same
	wrap it
*/
function is_null(_ref){
	return is_undefined(_ref) || _ref == noone;
}