activated = false;
rise_frames = 34;
original_y = y;
x_vel = 0;
y_vel = 0;
current_block = noone;
y_offset = 16;
x_offset = 8;
previous_state = noone;
temp_x_vel = 0;
temp_y_vel = 0;

with(o_BlockParent) {
	if(x == other.x && y == other.y - 8) {
		other.current_block = id;	
	}
}


