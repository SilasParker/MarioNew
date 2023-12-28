// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function sc_life_handle_collision(){

	//fall off platform
	if(current_block != noone) {
		if(x < current_block.left || x > current_block.right) {
			var _block_replaced = false;
			with(o_BlockParent) {
				if((other.x > left && other.x - 8 < right) && other.y == top) {
					other.current_block = id;
					_block_replaced = true;
				}
			}
			if(!_block_replaced) {
				current_block = noone;	
				id.fsm.transition(id, id.actions.life_fall);
			}
		}
	}
	
	//land on platform
	if(current_block == noone) {
		with(o_BlockParent) {
			if(other.x >= left && other.x <= right) {
				if(other.initial_y <= top && other.y >= top) {
					other.current_block = id;
					other.y = top;
					other.fsm.transition(other.id, other.id.actions.life_land);
				}
			}
		}
	}
	
	//running into wall
	var _top_y = y - y_offset;
	with(o_BlockParent) {
		if((_top_y >= top && _top_y < bottom) || (other.y > top && other.y <= bottom)) {
			if(other.initial_x < left && other.x + 8 >= left) {
				other.x_vel = other.x_vel * -1;
				other.x = left - 0.1;
			} else if(other.initial_x > right && other.x - 8 <= right) {
				other.x_vel = other.x_vel * -1;
				other.x = right + 0.1;
			}
		}
	}
	
}