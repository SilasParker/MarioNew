fsm.step(id);
if(activated) {
	sc_life_handle_movement();
	if(rise_frames == 0) {
		sc_life_handle_collision();
	}
}

event_inherited();

