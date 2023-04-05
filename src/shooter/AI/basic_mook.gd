extends Node

export var dir := Vector2()
export var vertical_aim = true
export var jump_gaps = false
export var target_detect_path : NodePath
onready var target_detect : Area2D = get_node(target_detect_path)
export var floor_ahead_detect_path : NodePath
onready var floor_ahead_detect : Area2D = get_node(floor_ahead_detect_path)

func _physics_process(delta: float) -> void:
	var input = get_parent().input_state
	input.B.pressed = false
	input.dir = dir
	if jump_gaps and owner.is_on_floor():
		var should_jump = !floor_ahead_detect.get_overlapping_bodies()
		input.A.pressed = should_jump
		if should_jump:
			return
	var target = Group.get_one("player")
	if target and (!target_detect or target_detect.overlaps_body(target)):
		var dir_to_target = owner.global_position.direction_to(target.global_position)
		if sign(dir_to_target.x) == owner.facing_dir:
			if vertical_aim:
				input.dir = dir_to_target
			input.B.pressed = true
	

func _ready():
	yield(get_parent(),"ready")
	dir.x = get_parent().facing_dir
	
