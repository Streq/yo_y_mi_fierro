extends FighterState

var target
onready var timer: Timer = $Timer

export var speed := 200.0
onready var collision_shape_2d: CollisionShape2D = $"%CollisionShape2D"

export (int, LAYERS_2D_PHYSICS) var layer : int

func _ready() -> void:
	timer.connect("timeout",self,"done")

func _enter(params):
	target = params[0]
	var r : KinematicBody2D = root
	r.collision_mask &= ~layer
	timer.start()
	done = false
func _exit():
	var r : KinematicBody2D = root
	r.collision_mask |= layer
	pass
# Called during _physics_process
func _physics_update(delta: float):
	var input = root.input_state
	var target_pos = target.global_position
	var dir = root.global_position.direction_to(target_pos)
	
#	root.velocity = Vector2()
	root.velocity += dir*speed*delta
#	root.global_position += dir*delta*speed
	
	root.facing_dir = dir.x
	
	
	
	if done or target_pos.distance_squared_to(root.global_position) < 1.0*1.0:
		goto("air")
		
func _move(delta):
	root.velocity = root.move_and_slide(root.velocity, Vector2.UP)

var done = false
func done():
	done = true
