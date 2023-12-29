enum STATES {
	IDLE,
	RUN,
	JUMP,
	FALL,
	LAND,
	DIE,
	GROW,
	SHRINK,
	LIFE_PAUSE,
	LIFE_RISE,
	LIFE_RUN,
	LIFE_EATEN,
	LIFE_FALL,
	LIFE_LAND,
	LIFE_DIE,
	LIFE_SQUASH
}

#macro LOG show_debug_message

actions = {
	idle: new AsIdle(),
	run: new AsRun(),
	jump: new AsJump(),
	fall: new AsFall(),
	land: new AsLand(),
	die: new AsDie(),
	grow: new AsGrow(),
	shrink: new AsShrink()
}

current_block = noone;
landed = false;
initial_x = x;
initial_y = y;
height_offset = [0, 16, 32, 32];
visual_left = x - 8; //probably needs updating for proper collision
visual_right = x + 8;
m_health = 1;
visual_top = y - height_offset[m_health];
die_frames = 60;
died = false;
idle_sprites = [spr_die, spr_idle, spr_big_idle];
run_sprites = [spr_die, spr_run, spr_big_run];
jump_sprites = [spr_die, spr_jump, spr_big_jump];
debug_name = "mario";
coins = 0;
bumped_last_frame = false;

x_vel = 0;
y_vel = 0;
temp_x_vel = 0;
temp_y_vel = 0;
previous_state = noone;
i_frames = 0;

fsm = new FSM(actions.idle);