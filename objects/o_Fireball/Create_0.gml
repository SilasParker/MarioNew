x_vel = 0;
y_vel = 2;
initial_x = x;
initial_y = y;
falling = true;
dying = false;

with(o_Mario) {
	if(image_xscale > 0) {
		other.x_vel = 2;
	} else {
		other.x_vel = -2;	
	}
}