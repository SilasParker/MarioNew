if(falling) y_vel += 0.1;
else y_vel -= 0.1;

with(o_BlockParent) {
	
	if(other.x >= left && other.x <= right) {
		if(other.initial_y <= top && other.y >= top) {
			other.y = top;
			other.y_vel = -1.5;
			other.falling = false;
		}
	}

}

initial_x = x;
initial_y = y;
	
x += x_vel;
y += y_vel;

if(y_vel == -1.5) falling = true;