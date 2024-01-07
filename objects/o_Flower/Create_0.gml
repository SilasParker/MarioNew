event_inherited();
rise_frames = 33;

actions = {
	life_pause: new AsLifePause(),
	life_rise: new AsLifeRise(),
	life_run: new AsLifeRun(),
	life_eaten: new AsLifeEaten(),
	life_pre_rise_wait: new AsLifePreRiseWait(),
	life_bounced: new AsLifeBounced()
}

debug_name = "flower";


fsm = new FSM(actions.life_pause);

visible = false;
