extends FighterState

export var friction := 0.1
#export var can_buffer := false
#var buffered_jab := false

func _enter(params):
#	buffered_jab = false
#	can_buffer = false
	pass

func _physics_update(delta: float) -> void:
#	root.velocity.x *= (1.0-friction)
	root.velocity.x = lerp(root.velocity.x, 0.0, root.stop_lerp*delta)
#	if can_buffer:
#		if root.input_state.B.is_just_pressed():
#			buffered_jab = true
func _on_animation_finished():
	goto("idle")

func throw():
	var dir = root.input_state.dir
	var vec = Vector2(300.0*root.facing_dir, -0.0)
	if dir:
		vec = vec.rotated(dir.angle())*root.facing_dir
	vec.x = abs(vec.x)*root.facing_dir
	root.carry_pivot.throw_carried_object(vec)
