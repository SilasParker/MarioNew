var _top_left = instance_create_layer(left, top, "Decorations", o_Fragment);
_top_left.x_vel = -1;
_top_left.y_vel = -1.5;

var _top_right = instance_create_layer(right, top, "Decorations", o_Fragment);
_top_right.x_vel = 1;
_top_right.y_vel = -1.5;

var _bot_left = instance_create_layer(left, bottom, "Decorations", o_Fragment);
_bot_left.x_vel = -1;
_bot_left.y_vel = -1;

var _bot_right = instance_create_layer(right, bottom, "Decorations", o_Fragment);
_bot_right.x_vel = 1;
_bot_right.y_vel = -1;
