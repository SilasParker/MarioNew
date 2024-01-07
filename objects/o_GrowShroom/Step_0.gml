event_inherited();

with(o_Mario) {
	if(m_health >= 2 && !other.activated) {
		instance_create_layer(other.x, other.y, "Powerups", o_Flower)
		instance_destroy(other.id);
	}
}





