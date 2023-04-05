extends Node2D
#onready var gun: Node2D = $shotgun

onready var gun_hold: Node2D = $gun_hold

export var disabled := false setget set_disabled

func set_disabled(val):
	disabled = val
	set_physics_process(!disabled)
	visible = !disabled
	
func disable():
	set_disabled(true)
	gun_hold.release_trigger()
func enable():
	set_disabled(false)

func _physics_process(delta: float) -> void:
	var input = owner.input_state
	var dir = input.dir
	if owner.facing_dir<0.0:
		dir.x = -dir.x
	
	if dir:
		gun_hold.rotation = dir.angle()
	else:
		gun_hold.rotation = 0.0
	
	#for AIs tapping once per frame
	if input.B.is_just_pressed():
		gun_hold.release_trigger()
		gun_hold.press_trigger()
	elif input.B.is_pressed():
		gun_hold.press_trigger()
	else:
		gun_hold.release_trigger()
