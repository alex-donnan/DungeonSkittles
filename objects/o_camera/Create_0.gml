/// Ortho camera
depth = 1000;

follow = undefined;
view_mat = array_create(16, 0);
proj_mat = array_create(16, 0);
width = 480;
height = 270;

camera_shake = 0;

//Draw function/////////////////////////////////////////////////////////////////////////////
function draw() {
	var camera = camera_get_active();
	view_mat = matrix_build_lookat(x, y, depth, x, y, 0, 0, 1, 0);
	proj_mat = matrix_build_projection_ortho(-width, height, 0, 10000);
	camera_set_view_mat(camera, view_mat);
	camera_set_proj_mat(camera, proj_mat);
	camera_apply(camera);	
}
