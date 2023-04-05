extends FighterState

export var flight_speed := 100.0
func _physics_update(delta):
	var input : InputState = root.input_state
	
	var on_floor = root.is_on_floor()
	var on_wall = root.is_on_wall() or root.is_on_ceiling() or root.is_on_floor()
	if on_wall:
		root.stick_to_wall()
		goto("idle")
		return

	root.global_rotation = 0.0
	var dir = input.get_local_dir()
	root.facing_dir = dir.x
	if !input.A.is_pressed():
		goto("air")
		return
	
	root.velocity.x = lerp(root.velocity.x, dir.x*flight_speed, delta*10.0)
	root.velocity.y = lerp(root.velocity.y, dir.y*flight_speed, delta*10.0)
	

func _move(delta):
#	root.velocity += root.gravity.rotated(root.global_rotation)*delta
	root.velocity = root.move_and_slide(root.velocity, root.get_floor_normal())
	
func _pos_move(delta):
	pass
