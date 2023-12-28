x = camera_get_view_x(view_camera[0]) + 88;

coin_display_1.sprite_index = spr_0;
coin_display_2.sprite_index = spr_0;

if(coins >= 10) {
	coin_display_1.sprite_index = sc_get_number_spr(string_char_at(string(coins), 1));
	coin_display_2.sprite_index = sc_get_number_spr(string_char_at(string(coins), 2));	
}
if(coins > 0 && coins < 10) {
	coin_display_2.sprite_index = sc_get_number_spr(string_char_at(string(coins), 1));	
}

coin_display_1.x = camera_get_view_x(view_camera[0]) + 105;
coin_display_2.x = camera_get_view_x(view_camera[0]) + 113;