extends FighterState

# Called during _physics_process
func _physics_update(delta: float):
	var input = root.input_state
	var dir = root.input_state.dir
	
	var dirx = dir.x
	var diry = dir.y
	
	if root.is_on_floor():
		if input.A.is_just_pressed():
			if InputState.is_jump_down_dir(dir):
				root.global_position.y+=1.0
				root.velocity.y += 25.0
			else:
				root.velocity.y -= root.jump_speed
				goto("jump")
				return
	else:
		goto("air")
		return
	var turn_dir = InputState.get_turn_dir(dir)
	if turn_dir:
		if root.facing_dir != turn_dir:
			root.turn_around()
	
		var run_dir = InputState.get_run_dir(dir)
		if run_dir:
			goto("run")
			return
	root.velocity.x = lerp(root.velocity.x, 0.0, root.idle_lerp*delta)
