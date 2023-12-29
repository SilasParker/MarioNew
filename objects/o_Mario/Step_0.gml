
with(o_Timer) {
	if(time	== 0 && !other.died) {
		other.fsm.transition(other.id, other.actions.die);
		other.died = true;
	}
}

if(i_frames > 0) i_frames--;

fsm.step(id);
sc_handle_movement();
sc_handle_collision();

if(x > camera_get_view_x(view_camera[0]) + 128) {
	camera_set_view_pos(view_camera[0], x - 128, camera_get_view_y(view_camera[0]));	
}