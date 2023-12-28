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
		_p.sprite_index = _p.idle_sprites[_p.m_health];
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
		_p.sprite_index = _p.run_sprites[_p.m_health];
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
		_p.sprite_index = _p.jump_sprites[_p.m_health];
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
		LOG("FAAAALLING");
		_p.state = STATES.FALL;
		_p.image_speed = 0;
		_p.current_block = noone;
		_p.landed = false;
	}
	
	step = function(_p) {
		if(_p.y_vel < 2) _p.y_vel += 0.1;
		if(keyboard_check(vk_left)) {
			_p.x_vel = (_p.x_vel - 0.25) * 0.9;	
		} else if(keyboard_check(vk_right)) {
			LOG("GO RIGHT");
			_p.x_vel = (_p.x_vel + 0.25) * 0.9;	
		}
	}
	
	_exit = function(_p) {
		_p.image_speed = 1;	
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

function AsDie() : ActionState() constructor {

	init = function(_p) {
		_p.state = STATES.DIE;
		_p.y_vel = 0;
		_p.x_vel = 0;
		_p.sprite_index = spr_die;
		_p.i_frames = -1;
	}
	
	step = function(_p) {
		_p.die_frames--;
		if(_p.die_frames == 0) {
			_p.y_vel = -5;	
		}
		if(_p.die_frames < 0) {
			_p.y_vel += 0.1;	
		}
	}

}

function AsGrow() : ActionState() constructor {
	
	init = function(_p) {
		_p.previous_state = _p.state;
		_p.state = STATES.GROW;
		_p.temp_x_vel = _p.x_vel;
		_p.temp_y_vel = _p.y_vel;
		_p.x_vel = 0;
		_p.y_vel = 0;
		_p.sprite_index = spr_grow;
		_p.m_health++;
		with(o_Life) {
			temp_x_vel = x_vel;
			temp_y_vel = y_vel;
			fsm.transition(id, id.actions.life_pause);	
		}
	}
	
	interrupt = function(_p) {
		if(_p.image_index == 32) {
			switch(_p.previous_state) {
				case STATES.IDLE: _p.fsm.transition(_p, _p.actions.idle); break;
				case STATES.RUN: _p.fsm.transition(_p, _p.actions.run);	break;
				case STATES.JUMP: _p.fsm.transition(_p, _p.actions.jump); break;
				case STATES.FALL: _p.fsm.transition(_p, _p.actions.fall); break;
				case STATES.LAND: _p.fsm.transition(_p, _p.actions.land); break;
			}
			_p.x_vel = _p.temp_x_vel;
			_p.y_vel = _p.temp_y_vel;
			with(o_Life) {
				switch(previous_state) {
					case STATES.LIFE_RUN: fsm.transition(id, id.actions.life_run); break;
					case STATES.LIFE_RISE: fsm.transition(id, id.actions.life_rise); break;
					case STATES.LIFE_FALL: fsm.transition(id, id.actions.life_fall); break;
					case STATES.LIFE_LAND: fsm.transition(id, id.actions.life_land); break;
				}
				x_vel = temp_x_vel;
				y_vel = temp_y_vel;
				image_speed = 1;
			}
			return true;
		}
		return false;
	}
	
}

function AsShrink() : ActionState() constructor {
	
	init = function(_p) {
		_p.previous_state = _p.state;
		_p.state = STATES.SHRINK;
		_p.temp_x_vel = _p.x_vel;
		_p.temp_y_vel = _p.y_vel;
		_p.x_vel = 0;
		_p.y_vel = 0;
		_p.sprite_index = spr_grow;
		_p.image_index = 32;
		_p.image_speed = -1;
		_p.i_frames = 120;
		_p.m_health--;
		with(o_Life) {
			LOG(debug_name);
			temp_x_vel = x_vel;
			temp_y_vel = y_vel;
			fsm.transition(id, id.actions.life_pause);	
		}
	}
	
	interrupt = function(_p) {
		if(_p.m_health <= 0) {
			_p.fsm.transition(_p, _p.actions.die);
			return true;
		}
		if(_p.image_index == 0) {
			switch(_p.previous_state) {
				case STATES.IDLE: _p.fsm.transition(_p, _p.actions.idle); break;
				case STATES.RUN: _p.fsm.transition(_p, _p.actions.run);	break;
				case STATES.JUMP: _p.fsm.transition(_p, _p.actions.jump); break;
				case STATES.FALL: _p.fsm.transition(_p, _p.actions.fall); break;
				case STATES.LAND: _p.fsm.transition(_p, _p.actions.land); break;
			}
			_p.x_vel = _p.temp_x_vel;
			_p.y_vel = _p.temp_y_vel;
			with(o_Life) {
				switch(previous_state) {
					case STATES.LIFE_RUN: fsm.transition(id, id.actions.life_run); break;
					case STATES.LIFE_RISE: fsm.transition(id, id.actions.life_rise); break;
					case STATES.LIFE_FALL: fsm.transition(id, id.actions.life_fall); break;
					case STATES.LIFE_LAND: fsm.transition(id, id.actions.life_land); break;
					case STATES.LIFE_PAUSE: break;
				}
				x_vel = temp_x_vel;
				y_vel = temp_y_vel;
				image_speed = 1;
			}
			return true;
		}
		return false;
	}
	
}

function AsLifePause() : ActionState() constructor {

	init = function(_p) {
		_p.previous_state = _p.state;
		_p.state = STATES.LIFE_PAUSE;
		_p.temp_x_vel = _p.x_vel;
		_p.temp_y_vel = _p.y_vel;
		_p.x_vel = 0;
		_p.y_vel = 0;
		_p.image_speed = 0;
	}
	
	interrupt = function(_p) {
		if(_p.activated && _p.rise_frames != 0) {
			_p.fsm.transition(_p, _p.actions.life_rise);
			return true;
		}
		return false;
	}

}

function AsLifeRise() : ActionState() constructor {
	
	init = function(_p) {
		_p.state = STATES.LIFE_RISE;
		_p.y_vel = -0.5;
	}
	
	step = function(_p) {
		_p.rise_frames--;
	}
	
	interrupt = function(_p) {
		if(_p.rise_frames == 0) {
			_p.fsm.transition(_p, _p.actions.life_run);
			return true;
		}
		return false;
	}
	
	_exit = function(_p) {
		//_p.current_block = instance_position(x, y - 8, o_BlockParent);	
	}
	
}

function AsLifeRun() : ActionState() constructor {
	
	init = function(_p) {
		_p.state = STATES.LIFE_RUN;
		if(_p.x_vel == 0) _p.x_vel = 1;
		_p.y_vel = 0;
	}
	
}

function AsLifeFall() : ActionState() constructor {
	
	init = function(_p) {
		_p.state = STATES.LIFE_FALL;
		_p.current_block = noone;
		_p.y_vel = 1;
	}
	
	step = function(_p) {
		if(_p.y_vel < 2) _p.y_vel += 0.1;	
	}
	
}

function AsLifeEaten() : ActionState() constructor {
	
	init = function(_p) {
		instance_destroy(_p);
	}
	
}

function AsLifeLand() : ActionState() constructor {
	
	init = function(_p) {
		_p.state = STATES.LIFE_LAND;
		_p.y_vel = 0;
	}
	
	interrupt = function(_p) {
		_p.fsm.transition(_p, _p.actions.life_run);
		return true;
	}
	
}

function AsLifeDie() : ActionState() constructor {

}

function AsLifeSquash() : ActionState() constructor {

	init = function(_p) {
		_p.state = STATES.LIFE_DIE;
		_p.sprite_index = spr_goomba_squash;
		_p.x_vel = 0;
		_p.y_vel = 0;
		_p.alive = false;
	}
	
	step = function(_p) {
		_p.squash_frames--;
	}
	
	interrupt = function(_p) {
		if(_p.squash_frames == 0) instance_destroy(_p);
	}

}
