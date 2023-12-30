if(x <= camera_get_view_x(view_camera[0]) - 16) {
	instance_destroy(id);	
}

with(o_BlockParent) {
	if(other.current_block == id && bump_frames >= 0 && other.rise_frames == 0 && !other.bounced) {
		other.fsm.transition(other.id, other.id.actions.life_bounced);
	}
}