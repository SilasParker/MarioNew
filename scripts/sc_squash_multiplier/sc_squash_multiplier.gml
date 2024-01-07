// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function sc_squash_multiplier(){
	var _score_to_add = 0;
	with(o_Mario) {
		switch(enemy_stomped) { //turn this into a script and make non-specific to goombas
			case 1: _score_to_add = 10; break;
			case 2: _score_to_add = 20; break;	
			case 3: _score_to_add = 40; break;
			case 4: _score_to_add = 50; break;
			case 5: _score_to_add = 80; break;
			case 6: _score_to_add = 100; break;
			case 7: _score_to_add = 200; break;
			case 8: _score_to_add = 400; break;
			case 9: _score_to_add = 500; break;
			case 10: _score_to_add = 800; break;
			default: _score_to_add = 0; break;
		}
	}

	sc_create_score(_score_to_add, 0);
}