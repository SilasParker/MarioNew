x = camera_get_view_x(view_camera[0]) + 24;

score_value_1.x = camera_get_view_x(view_camera[0]) + 28;
score_value_2.x = camera_get_view_x(view_camera[0]) + 36;
score_value_3.x = camera_get_view_x(view_camera[0]) + 44;
score_value_4.x = camera_get_view_x(view_camera[0]) + 52;
score_value_5.x = camera_get_view_x(view_camera[0]) + 60;
score_value_6.x = camera_get_view_x(view_camera[0]) + 68;

score_value_1.sprite_index = spr_0;
score_value_2.sprite_index = spr_0;
score_value_3.sprite_index = spr_0;
score_value_4.sprite_index = spr_0;

if(score >= 1000) {
	score_value_1.sprite_index = sc_get_number_spr(string_char_at(string(score), 1));	
	score_value_2.sprite_index = sc_get_number_spr(string_char_at(string(score), 2));	
	score_value_3.sprite_index = sc_get_number_spr(string_char_at(string(score), 3));
	score_value_4.sprite_index = sc_get_number_spr(string_char_at(string(score), 4));	
}
if(score >= 100) {
	score_value_2.sprite_index = sc_get_number_spr(string_char_at(string(score), 1));
	score_value_3.sprite_index = sc_get_number_spr(string_char_at(string(score), 2));
	score_value_4.sprite_index = sc_get_number_spr(string_char_at(string(score), 3));
}
if(score >= 10) {
	score_value_3.sprite_index = sc_get_number_spr(string_char_at(string(score), 1));
	score_value_4.sprite_index = sc_get_number_spr(string_char_at(string(score), 2));
}
if(score >= 1) {
	score_value_4.sprite_index = sc_get_number_spr(string_char_at(string(score), 1));	
}