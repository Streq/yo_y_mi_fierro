extends FighterState


func _physics_update(delta):
	var input : InputState = root.input_state
	var dir = input.get_local_dir()
	var on_floor = root.is_on_floor()
	var on_wall = root.is_on_wall() or root.is_on_ceiling() or root.is_on_floor()
	if on_wall:
		root.stick_to_wall()
	else:
		root.global_rotation = 0.0
		goto("air")
		return
		
	if on_floor:
		if !is_equal_approx(dir.x, 0):
			root.facing_dir = dir.x
			goto("run")
			return
		var local_velocity = root.velocity.rotated(-root.global_rotation)
	
		local_velocity.x = dir.x*root.walk_speed
		var jumped = false
		
		if input.B.is_just_pressed():
			goto("shoot")
		elif input.A.is_just_pressed():
			local_velocity.y -= root.jump_speed
			jumped = true
			goto("fly")
		
		root.velocity = local_velocity.rotated(root.global_rotation)
		
		
		if jumped:
			root.facing_dir = root.velocity.x
		
		
		
	

func _move(delta):
	root.velocity += root.gravity.rotated(root.global_rotation)*delta
	root.velocity = root.move_and_slide(root.velocity, root.get_floor_normal())
	
func _pos_move(delta):
	pass
