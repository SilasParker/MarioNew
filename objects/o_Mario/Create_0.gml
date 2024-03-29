enum STATES {
	IDLE,
	RUN,
	JUMP,
	FALL,
	LAND,
	DIE,
	GROW,
	SHRINK,
	GROW_FIRE,
	LIFE_PAUSE,
	LIFE_RISE,
	LIFE_RUN,
	LIFE_EATEN,
	LIFE_FALL,
	LIFE_LAND,
	LIFE_DIE,
	LIFE_SQUASH,
	LIFE_PRE_RISE_WAIT,
	LIFE_BOUNCED
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
	shrink: new AsShrink(),
	grow_fire: new AsGrowFire()
}

current_block = noone;
landed = false;
initial_x = x;
initial_y = y;
height_offset = [0, 16, 32, 32];
visual_left = x - 8;
visual_right = x + 8;
m_health = 1;
visual_top = y - height_offset[m_health];
die_frames = 60;
died = false;
idle_sprites = [spr_die, spr_idle, spr_big_idle, spr_fire_idle];
run_sprites = [spr_die, spr_run, spr_big_run, spr_fire_run];
jump_sprites = [spr_die, spr_jump, spr_big_jump, spr_fire_jump];
debug_name = "mario";
coins = 0;
bumped_last_frame = false;
holding_jump = false;
holding_jump_frames = 0;
enemy_stomped = 0;
sprite_frame = noone;
last_sprite = noone;
fire_sprite_equivalent = noone;
fire_grow_frames = 0;
pre_fireball_sprite = noone;
fireball_cooldown = 10;
state = noone;

x_vel = 0;
y_vel = 0;
temp_x_vel = 0;
temp_y_vel = 0;
previous_state = noone;
i_frames = 0;

fsm = new FSM(actions.idle);