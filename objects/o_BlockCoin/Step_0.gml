if(activated) {
	sprite_index = spr_coin_get;
	with(o_ScoreDisplay) {
		score++;	
	}
	with(o_CoinDisplay) {
		coins++;	
	}
	y_vel = -5;	
	activated = false;
	moving = true;
}

if(moving) {
	y_vel += 0.2;	
	death_frames--;
	y += y_vel;
	if(death_frames == 0) {
		instance_destroy(id);
	}
}