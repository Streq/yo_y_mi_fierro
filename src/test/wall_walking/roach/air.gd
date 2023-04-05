extends FighterState


func _physics_update(delta):
	var input : InputState = root.input_state
	var dir = input.get_local_dir()
	var on_floor = root.is_on_floor()
	var on_wall = root.is_on_wall() or root.is_on_ceiling() or root.is_on_floor()
	if on_wall:
		root.stick_to_wall()
		goto("idle")
		return

	else:
		root.global_rotation = 0.0
	
	if input.A.is_pressed():
			goto("fly")
			return
		
	

func _move(delta):
	root.velocity += root.gravity.rotated(root.global_rotation)*delta
	root.velocity = root.move_and_slide(root.velocity, root.get_floor_normal())
	
func _pos_move(delta):
	pass
