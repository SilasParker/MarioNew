if(!dying) {
	if(falling) y_vel += 0.1;
	else y_vel -= 0.1;

	//running into wall
	var _top_y = y - 8;
	with(o_BlockParent) {
	
		if(other.x >= left && other.x <= right) {
			if(other.initial_y <= top && other.y >= top) {
				other.y = top;
				other.y_vel = -1.5;
				other.falling = false;
			}
		}
		
		if((_top_y >= top && _top_y < bottom) || (other.y > top && other.y <= bottom)) {
			if((other.initial_x < left && other.x + 8 >= left) || (other.initial_x < left && other.x >= left)) {
				other.dying = true;
				other.sprite_index = spr_fireball_explode;
			} else if((other.initial_x > right && other.x - 8 <= right) || (other.initial_x > right && other.x <= right)) {
				other.dying = true;
				other.sprite_index = spr_fireball_explode;
			}
		}

	}

	initial_x = x;
	initial_y = y;
	
	x += x_vel;
	y += y_vel;

	if(y_vel == -1.5) falling = true;
	
	if(y >= 280) instance_destroy(id);
} else {
	x_vel = 0;
	y_vel = 0;
	if(image_index == 2) instance_destroy(id);
}
