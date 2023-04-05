extends Node

export var dir := Vector2()
export var vertical_aim = true
export var target_detect_path : NodePath
onready var target_detect : Area2D = get_node(target_detect_path)

func _physics_process(delta: float) -> void:
	var input = get_parent().input_state
	
	#start by depressing the trigger in order to shoot again
	input.B.pressed = false
	
	input.dir = dir
	var target = Group.get_one("player")
	if target and (!target_detect or target_detect.overlaps_body(target)):
		var dir_to_target = owner.global_position.direction_to(target.global_position)
		#only do our stuff if we are facing the player
		if sign(dir_to_target.x) == owner.facing_dir:
			if owner.is_on_floor() and !owner.gun_hold.gun.is_shooting():
				#depress jump in order to jump again
				input.A.pressed = false
				input.dir.y = sign(dir_to_target.y-0.1)
			else: 
				if vertical_aim:
					input.dir = dir_to_target
				input.B.pressed = true
			#keep jump pressed to reach max height
			input.A.pressed = true
	
func _ready():
	yield(get_parent(),"ready")
	dir.x = get_parent().facing_dir
	
