enum STATES {
	IDLE,
	RUN,
	JUMP,
	FALL,
	LAND
}

#macro LOG show_debug_message

actions = {
	idle: new AsIdle(),
	run: new AsRun(),
	jump: new AsJump(),
	fall: new AsFall(),
	land: new AsLand()
}

fsm = new FSM(actions.idle);

current_block = noone;
landed = false;
initial_x = x;
initial_y = y;
height_offset = 16;

x_vel = 0;
y_vel = 0;
