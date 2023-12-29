fsm.step(id);
sc_life_handle_movement();
sc_life_handle_collision();

event_inherited();

LOG(id)