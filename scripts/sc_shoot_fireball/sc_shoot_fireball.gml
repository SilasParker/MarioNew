function sc_shoot_fireball() {
	if(fireball_cooldown == 0 && instance_number(o_Fireball) < 2) {
		pre_fireball_sprite = sprite_index;
		if(fsm.cur_action == actions.fall || fsm.cur_action == actions.jump) sprite_index = spr_fire_shoot_airbourne;
		else sprite_index = spr_fire_shoot_grounded;
		instance_create_layer(x + 8, y - 16, "Instances", o_Fireball);
	}
}