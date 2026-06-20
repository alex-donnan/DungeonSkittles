function len(_input) {
	switch (typeof(_input)) {
		case "array":
			return array_length(_input);
		case "string":
			return string_length(_input);
		case "struct":
			return array_length(struct_get_names(_input));
		default:
			return -1;
	}
}