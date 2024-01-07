if(!activated) {
	if(x >= camera_get_view_x(view_camera[0]) && x <= (camera_get_view_x(view_camera[0]) + 256)) {
		LOG("done");
		activated = true;
	}
}

fsm.step(id);
sc_life_handle_movement();
if(activated) sc_life_handle_collision();

event_inherited();