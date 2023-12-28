time--;

if(time != 0) {
	if(time >= 100) {
		value_1.sprite_index = sc_get_number_spr(string_char_at(string(time), 1));
		value_2.sprite_index = sc_get_number_spr(string_char_at(string(time), 2));
		value_3.sprite_index = sc_get_number_spr(string_char_at(string(time), 3));
	} else if(time < 100 && time >= 9) {
		value_1.sprite_index = spr_0;
		value_2.sprite_index = sc_get_number_spr(string_char_at(string(time), 1));
		value_3.sprite_index = sc_get_number_spr(string_char_at(string(time), 2));
	} else {
		value_2.sprite_index = spr_0;
		value_3.sprite_index = sc_get_number_spr(string_char_at(string(time), 1));
	}

	alarm[0] = 60;
} else {
	value_3.sprite_index = spr_0;	
}