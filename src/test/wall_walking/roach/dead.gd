extends FighterState


func _physics_update(delta):
	root.global_rotation = 0.0
	
	if root.is_on_floor():
		goto("dead")
		return
	
	

func _move(delta):
	root.velocity += root.gravity.rotated(root.global_rotation)*delta
	root.velocity = root.move_and_slide(root.velocity, root.get_floor_normal())
	
	
func _pos_move(delta):
	pass
