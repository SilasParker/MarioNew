event_inherited();

actions = {
	life_pause: new AsLifePause(),
	life_rise: new AsLifeRise(),
	life_run: new AsLifeRun(),
	life_eaten: new AsLifeEaten(),
	life_fall: new AsLifeFall(),
	life_land: new AsLifeLand(),	
	life_pre_rise_wait: new AsLifePreRiseWait(),
	life_bounced: new AsLifeBounced()
}

debug_name = "shroom";


fsm = new FSM(actions.life_pause);

visible = false;




