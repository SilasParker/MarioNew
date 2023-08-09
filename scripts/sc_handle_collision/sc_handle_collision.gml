function sc_handle_collision() {
	
	var _block_children = [o_GroundBlock];
	
	//fall off platform
	if(current_block != noone) {
		if(x < current_block.left || x > current_block.right) {
			var _block_replaced = false;
			for(var _i = 0; _i < array_length(_block_children); _i++) {
				with(_block_children[_i]) {
					if(other.x < left || other.x > right) {
						other.current_block = id;
						_block_replaced = true;
					}
				}
			}
			if(!_block_replaced) {
				current_block = noone;
				id.fsm.transition(id, id.actions.fall)
			}
			
		}
	}
	
	//land on platform
	if(current_block == noone) {
		for(var _i = 0; _i < array_length(_block_children); _i++) {
			with(_block_children[_i]) {
				if(other.x >= left && other.x <= right) {
					LOG("IN BETWEEN X");
					if(other.initial_y <= top && other.y >= top) {
						LOG("IN BETWEEN Y");
						other.current_block = id;
						other.y = top;
						other.landed = true;
						other.fsm.transition(other.id, other.id.actions.land);
					}
				}
			}
		}
	}
	
	//running into wall
	var _top_y = y - height_offset;
	with(o_BlockParent) {
		if((_top_y > top && _top_y <= bottom) || (other.y > top && other.y <= bottom)) {
			if(other.initial_x < left && other.x >= left) {
				other.x = left - 0.1;	
			} else if(other.initial_x > right && other.x <= right) {
				other.x = right + 0.1;	
			}
		}
	}
	
}