extends FighterState

# Called during _physics_process
func _physics_update(delta: float):
	var input = root.input_state
	var dir = root.input_state.dir
	
	var dirx = dir.x
	var diry = dir.y

	if root.is_on_floor():
		goto("idle")
		return
	if dirx:
		if root.facing_dir != sign(dirx):
			root.turn_around()
	if diry>0.30:
		root.velocity.y += 200.0*delta
	if dir.length() < 0.90:
		root.velocity.x = lerp(root.velocity.x, 0.0, root.air_lerp*delta)
	else:
		root.velocity.x = lerp(root.velocity.x, root.run_speed*sign(dirx), root.air_run_lerp*delta)
