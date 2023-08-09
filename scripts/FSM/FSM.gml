// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function FSM(_init_state) constructor {
	
	cur_action = _init_state;
	
	step = function(_p) {
		cur_action.step(_p);
		if(cur_action.interrupt(_p)) return;
	}
	
	transition = function(_p, _new_state) {
		cur_action._exit(_p);
		cur_action = _new_state;
		cur_action.init(_p);
		cur_action.step(_p);
	}
	
}

function ActionState() constructor {

	init = function(_p) {}
	
	step = function(_p) {}
	
	interrupt = function(_p) { return false }
	
	on_wall_collide = function(_p) {}
	
	to_air = function(_p) {}
	
	_exit = function(_p) {}

}

function AsIdle() : ActionState() constructor {

	init = function(_p) {
		_p.state = STATES.IDLE;	
		_p.sprite_index = spr_idle;
	}
	
	step = function(_p) {
		if(_p.x_vel != 0) {
			_p.x_vel = sign(_p.x_vel) * max(0, abs(_p.x_vel) - 0.5);	
		}
	}
	
	interrupt = function(_p) {
		if(keyboard_check(vk_right) || keyboard_check(vk_left)) {
			_p.fsm.transition(_p, _p.actions.run);
			return true;
		}
		if(keyboard_check(vk_up)) {
			_p.fsm.transition(_p, _p.actions.jump);	
			return true;
		}
		return false;
	}

}

function AsRun() : ActionState() constructor {
	
	init = function(_p) {
		_p.state = STATES.RUN
		_p.sprite_index = spr_run;
	}
	
	step = function(_p) {
		if(keyboard_check(vk_left)) {
			_p.image_xscale = -1;
			_p.x_vel = (_p.x_vel - 0.5) * 0.9;
		} else if(keyboard_check(vk_right)) {
			_p.image_xscale = 1;
			_p.x_vel = (_p.x_vel + 0.5) * 0.9;
		}
	}
	
	interrupt = function(_p) {
		if(!(keyboard_check(vk_left) || keyboard_check(vk_right))) {
			_p.fsm.transition(_p, _p.actions.idle);
			return true;
		}
		if(keyboard_check(vk_up)) {
			_p.fsm.transition(_p, _p.actions.jump);	
			return true;
		}
		return false;
	}
	
}

function AsAirbourne() : ActionState() constructor {
	
	step = function(_p) {
		_p.y_vel += 0.1;
		if(keyboard_check(vk_left)) {
			_p.x_vel = (_p.x_vel - 0.25) * 0.9;	
		} else if(keyboard_check(vk_right)) {
			_p.x_vel = (_p.x_vel + 0.25) * 0.9;	
		}
	}
	
}

function AsJump() : AsAirbourne() constructor {
	
	init = function(_p) {
		_p.state = STATES.JUMP;
		_p.y_vel = -4;
		_p.sprite_index = spr_jump;
		_p.current_block = noone;
		_p.landed = false;
	}
	
	interrupt = function(_p) {
		if(_p.y_vel > 0) {
			_p.fsm.transition(_p, _p.actions.fall);
			return true;
		}
		return false;
	}
	
}

function AsFall() : AsAirbourne() constructor {
	
	init = function(_p) {
		_p.state = STATES.FALL;
		image_speed = 0;
		_p.current_block = noone;
		_p.landed = false;
	}
	
	step = function(_p) {
		if(_p.y_vel < 2) _p.y_vel += 0.1;
		if(keyboard_check(vk_left)) {
			_p.x_vel = (_p.x_vel - 0.25) * 0.9;	
		} else if(keyboard_check(vk_right)) {
			_p.x_vel = (_p.x_vel + 0.25) * 0.9;	
		}
	}
	
	_exit = function(_p) {
		image_speed = 1;	
	}
	
}

function AsLand() : ActionState() constructor {
	
	init = function(_p) {
		_p.state = STATES.LAND;
		_p.y_vel = 0;
	}
	
	interrupt = function(_p) {
		_p.fsm.transition(_p, _p.actions.idle);
		return true;
	}
	
}