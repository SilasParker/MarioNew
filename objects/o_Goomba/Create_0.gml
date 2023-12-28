event_inherited();

actions = {
	life_pause: new AsLifePause(),
	life_run: new AsLifeRun(),
	life_fall: new AsLifeFall(),
	life_land: new AsLifeLand(),
	life_die: new AsLifeDie(),
	life_squash: new AsLifeSquash()
}

squash_frames = 30;
alive = true;
debug_name = "goomba";

fsm = new FSM(actions.life_run);





