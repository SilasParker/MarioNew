if(bumped) {
	bumped = false;
	bump_frames = 20;
}
if(bump_frames >= 10) y -= 0.5;
if(bump_frames < 10 && bump_frames >= 0) y += 0.5;
if(bump_frames >= 0) bump_frames--;
if(bump_frames == -1) y = original_y;





