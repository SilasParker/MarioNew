if(activated) {
	with(o_Score) {
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
	display_score = true;
	moving = false;
	sprite_index = spr_100;
}
}

if(display_score) {
	score_frames--;
	if(score_frames == 0) {
		instance_destroy(id);	
	}
}
