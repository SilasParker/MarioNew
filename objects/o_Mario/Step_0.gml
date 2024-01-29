
with(o_Timer) {
	if(time	== 0 && !other.died) {
		other.fsm.transition(other.id, other.actions.die);
		other.died = true;
	}
}

if(i_frames > 0) i_frames--;
if(fireball_cooldown > 0) fireball_cooldown--;

if(pre_fireball_sprite != noone) {
	sprite_index = pre_fireball_sprite;
	pre_fireball_sprite = noone;
} else {
	if(keyboard_check_pressed(ord("X")) && m_health == 3) sc_shoot_fireball();	
}

fsm.step(id);
sc_handle_movement();
if(state != STATES.DIE) sc_handle_collision();

if(x > camera_get_view_x(view_camera[0]) + 128) {
	camera_set_view_pos(view_camera[0], x - 128, camera_get_view_y(view_camera[0]));	
}

if(y >= 280) instance_destroy(id);

//LOG(fsm.cur_action);