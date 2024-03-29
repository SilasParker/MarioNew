function sc_handle_collision() {
	
	//fall off platform
	if(current_block != noone) {
		if(x + 6 <= current_block.left || x - 6 >= current_block.right) {
			var _block_replaced = false;
			with(o_BlockParent) {
				if((other.x > left && other.x < right) && other.y == top) {
					other.current_block = id;
					_block_replaced = true;
				}
			}
			if(!_block_replaced) {
				current_block = noone;
				id.fsm.transition(id, id.actions.fall)
			}
		}
	}
	
	//land on platform
	if(current_block == noone && !died) {
		with(o_BlockParent) {
			if(id.object_index != o_InvisibleQuestionBlock || (id.object_index == o_InvisibleQuestionBlock && activated)) {
				if((other.x + 6 >= left && other.x - 6 <= right) && (other.initial_y <= top && other.y >= top)) {
					other.current_block = id;
					other.y = top;
					other.fsm.transition(other.id, other.id.actions.land);
				}
			}
		}
	}
	
	//running into wall
	var _top_y = y - height_offset[m_health];
	with(o_BlockParent) {
		if(id.object_index != o_InvisibleQuestionBlock || (id.object_index == o_InvisibleQuestionBlock && activated)) {
			if(((_top_y >= top && _top_y < bottom) || (other.y > top && other.y <= bottom) || (other.y - (other.height_offset[other.m_health] * 0.5) > top && other.y - (other.height_offset[other.m_health] * 0.5) <= bottom))) {
				if((other.initial_x + 8 < left && other.x + 8 >= left) || (other.initial_x < left && other.x >= left)) {
					other.x_vel = 0;
					other.x = left - 8.1;
				} else if((other.initial_x - 8 > right && other.x - 8 <= right) || (other.initial_x > right && other.x <= right)) {
					other.x_vel = 0;
					other.x = right + 8.1;	
				}
			}
		}
	}
	
	//running into left side of camera
	if(initial_x > camera_get_view_x(view_camera[0]) && x <= camera_get_view_x(view_camera[0])) {
		x_vel = 0;
		x = camera_get_view_x(view_camera[0]) + 0.1;
	}
	
	//bump head
	with(o_BlockParent) {
		if(other.x + 4 >= left && other.x - 4 <= right) {
			if((other.initial_y - other.height_offset[other.m_health]) > bottom && (other.y - other.height_offset[other.m_health]) <= bottom) {
				other.y_vel = 0;	
				if(id.object_index == o_BrickBlock) {
					if(other.m_health > 1) {
						instance_destroy(id);
						with(o_BlockCoin) {
							if(other.x == x && other.y == y) {
								activated = true;
							}
						}
					} else {
						y = original_y;
						bumped = true;	
					}
				}
				else if(id.object_index == o_BlockQuestion || id.object_index == o_InvisibleQuestionBlock) {
					if(!activated) bumped = true;
					sprite_index = spr_question_hit;
					activated = true;
					with(o_Shroom) {
						if(other.x == x && other.y == y - 8) {
							activated = true;	
							fsm.transition(id, id.actions.life_pre_rise_wait);
						}
					}
					with(o_Flower) {
						if(other.x == x && other.y == y - 8) {
							activated = true;
							fsm.transition(id, id.actions.life_pre_rise_wait);
						}
					}
					with(o_BlockCoin) {
						if(other.x == x && other.y == y) {
							activated = true;
						}
					}
				}
			}
		}
	} 
	
	//collide with grow shroom
	with(o_GrowShroom) {
		if(other.x > x - x_offset && other.x < x + x_offset) {
			if(other.y <= y && other.y > y - y_offset) {
				instance_destroy(id);
				other.fsm.transition(other.id, other.id.actions.grow);
			}
		}
	}
	
	//collide with 1upshroom
	with(o_1UPShroom) {
		if(other.x > x - x_offset && other.x < x + x_offset) {
			if(other.y <= y && other.y > y - y_offset) {
				if(activated) instance_destroy(id);	
			}	
		}
	}
	
	//collide with flower
	with(o_Flower) {
		if(other.x > x - x_offset && other.x < x + x_offset) {
			if(other.y <= y && other.y > y - y_offset) {
				instance_destroy(id);	
				other.fsm.transition(other.id, other.id.actions.grow_fire);
			}	
		}
	}
	
	//bounce on goomba
	with(o_Goomba) {
		if(other.x > x - x_offset && other.x < x + x_offset && alive) {
			if(other.initial_y <= y - y_offset && other.y >= y - y_offset) {	
				fsm.transition(id, id.actions.life_squash);
				other.fsm.transition(other.id, other.id.actions.jump);
				other.enemy_stomped += 1;
			}
		}
	}
	
	//collide with goomba
	with(o_Goomba) {
		if(other.x > x - x_offset && other.x < x + x_offset && alive && other.i_frames == 0) {
			if(floor(other.y) > y - y_offset && floor(other.y) - other.height_offset[other.m_health] <= y) {
				other.fsm.transition(other.id, other.id.actions.shrink);	
			}
		}
	}
	
}