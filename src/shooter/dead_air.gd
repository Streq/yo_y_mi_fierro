extends FighterState

signal hit_the_ground_hard()

var y_velocity_at_floor_point = 0.0

func _physics_update(delta: float):
	if root.is_on_floor():
		if y_velocity_at_floor_point > 100.0:
			emit_signal("hit_the_ground_hard")
		goto("dead")
		return
	root.velocity.x = lerp(root.velocity.x, 0.0, root.air_dead_lerp*delta)
	y_velocity_at_floor_point = root.velocity.y
	
