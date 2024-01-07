// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function sc_create_score(_score_to_add, _coins_to_add){
	var sprite;
	switch(_score_to_add) {
		case 0: sprite = spr_1up_text; break;
		case 10: sprite = spr_100; break;
		case 20: sprite = spr_200; break;
		case 100: sprite = spr_1000; break;
	}
	var instance = instance_create_layer(x, y, "Decorations", o_Score)
	with(o_Score) {
		if(instance.id == id) sprite_index = sprite;	
	}
	with(o_ScoreDisplay) {
		score += _score_to_add;	
	}
	with(o_CoinDisplay) {
		coins += _coins_to_add;	
	}
}