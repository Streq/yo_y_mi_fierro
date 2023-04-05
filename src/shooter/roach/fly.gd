extends FighterState

var target_pos := Vector2()

export var speed := 200.0
onready var collision_shape_2d: CollisionShape2D = $"%CollisionShape2D"

func _enter(params):
	target_pos = params[0]
	collision_shape_2d.disabled = true
func _exit():
	collision_shape_2d.disabled = false

# Called during _physics_process
func _physics_update(delta: float):
	var input = root.input_state
	var dir = root.global_position.direction_to(target_pos)
	
	root.velocity = Vector2()
	root.global_position = root.global_position.move_toward(target_pos,delta*speed)
#	root.global_position += dir*delta*speed
	
	root.facing_dir = dir.x
	
	
	
	if target_pos.distance_squared_to(root.global_position) < 1.0*1.0:
		goto("air")
		
