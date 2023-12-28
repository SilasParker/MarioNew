event_inherited();

actions = {
	life_pause: new AsLifePause(),
	life_rise: new AsLifeRise(),
	life_run: new AsLifeRun(),
	life_eaten: new AsLifeEaten(),
	life_fall: new AsLifeFall(),
	life_land: new AsLifeLand()	
}

debug_name = "shroom";


fsm = new FSM(actions.life_pause);




