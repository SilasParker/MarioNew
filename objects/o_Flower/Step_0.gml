fsm.step(id);
if(activated) {
	sc_life_handle_movement();
	if(rise_frames == 0) {
		sc_life_handle_collision();
	}
}

event_inherited();

with(o_Mario) {
	if(m_health == 1 && !other.activated) {
		instance_create_layer(other.x, other.y, "Powerups", o_GrowShroom)
		instance_destroy(other.id);
	}
}

//LOG(fsm.cur_action);
LOG(y);



