/// Ortho camera
active = true;
follow = undefined;
view_mat = array_create(16, 0);
proj_mat = array_create(16, 0);

ox = x;
oy = y;

camera_shake = 0;
camera = view_get_camera(view);